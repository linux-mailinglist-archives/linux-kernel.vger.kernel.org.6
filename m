Return-Path: <linux-kernel+bounces-191467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA1A8D0FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEEB283035
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F341161B43;
	Mon, 27 May 2024 21:44:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10F91CAA9;
	Mon, 27 May 2024 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716846268; cv=none; b=fqA4V4mvHO2vfXbkU/abNFntjbm6uPUAmqAPUdERqYFnOXpxbkdBXsSMEU3MR6J5UlFZZ2OGtT1ERv+/8rDvCnDgmn/R2uF0H2bRwVrx7JCJc0RJIn+r+zk58nIOPvIlxlk0+uJ5pVwsuYVKAU5COo+hVqVO/3fdHUmPe3VS8Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716846268; c=relaxed/simple;
	bh=xGGTdclt9/dkLqZyCAVM0iigww+nrR6P6WZz43MPiqE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdJ4HUS9ZxCqPjjOemdypkyhIjcuYF1TOGushZGI1HhBaBzhyEGeejPQEB5NkaegsIYv5a26311AHHIp5iGPei6u8BmrsDAyBhc2SltcXfM/dP8AfQG+8e5Di9tYOOBpVY9KMb9ftO6qLY9hrRavAzyLVyZCcsUe/y/k0uUeupA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F8BC2BBFC;
	Mon, 27 May 2024 21:44:26 +0000 (UTC)
Date: Mon, 27 May 2024 17:44:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?= <digirigawa@gmail.com>, "Linux
 regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, Linux
 regressions mailing list <regressions@lists.linux.dev>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: Bug in Kernel 6.8.x, 6.9.x Causing Trace/Panic During
 Shutdown/Reboot
Message-ID: <20240527174424.75625921@rorschach.local.home>
In-Reply-To: <2024052710-marsupial-debug-febd@gregkh>
References: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
	<5b79732b-087c-411f-a477-9b837566673e@leemhuis.info>
	<20240524132008.6b6f69f6@gandalf.local.home>
	<CAE4VaRF80OhnaiqeP9STfLa5pORB31YSorgoJ92fQ8tsRovxqQ@mail.gmail.com>
	<CAE4VaRGaNJSdo474joOtKEkxkfmyJ-zsrr8asb7ojP2JexFt-A@mail.gmail.com>
	<2024052710-marsupial-debug-febd@gregkh>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 May 2024 20:14:42 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, May 27, 2024 at 07:40:21PM +0300, Ilkka Naulap=C3=A4=C3=A4 wrote:
> > Hi Steven,
> >=20
> > I took some time and bisected the 6.8.9 - 6.8.10 and git gave the
> > panic inducing commit:
> >=20
> > 414fb08628143 (tracefs: Reset permissions on remount if permissions are=
 options)
> >=20
> > I reverted that commit to 6.9.2 and now it only serves the trace but
> > the panic is gone. But I can live with it. =20
>=20
> Steven, should we revert that?
>=20
> Or is there some other change that we should take to resolve this?
>=20

Before we revert it (as it may be a bug in mainline), Ilkka, can you
test v6.10-rc1?  If it exists there, it will let me know whether or not
I missed something.

Thanks,

-- Steve

