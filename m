Return-Path: <linux-kernel+bounces-321092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F39B97145C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE38D1F2384C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0351B14F3;
	Mon,  9 Sep 2024 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gdmvvxhn"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690981AD9C3
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875404; cv=none; b=eddT04rRWwTY15Iq4O5E2KeDdbNnHXRenBLpqwK1R8Ow79UgytNp9BUvxCV/ZxqsrcoRooevshe/Qc79MnKfo8h25paZ0M/hATwmGvU9lySx7W75DdUDh8T03PPnlXz5Ols5hu5vApvPMLcxyhbsukiZg5tQqTRfbI7RP1xW+PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875404; c=relaxed/simple;
	bh=WGSfmjP2xpkg9kRW5SbVOyZniCqkxswImo1NnnS+ve8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHEwW7uhm4v6AwNaMVkCc6DYUoLTAW/GLr8eFN7oZ/tYCk7mHqjw31ONHUgv4irHcu6Fzk3CnN4nMnPSNgcsOyuTIzF18MsM6bc/ZT4EMKLJAeJu0gNBaYXXwbbSn3gi7llJod3y+syeh2sa3g0qXU4FAHStcDQkD6Dj6JmUtfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gdmvvxhn; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E39A60004;
	Mon,  9 Sep 2024 09:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725875393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGSfmjP2xpkg9kRW5SbVOyZniCqkxswImo1NnnS+ve8=;
	b=GdmvvxhnbXhVuPkYO7n179XVJp7AbyHe8ARxaB9MFEmiuv0He1KV7+s4eR8nN5poH/Pqbv
	G8oRLw1kcLxNNqI/+HTJH2usCsBO6aqQUtpIfch36TlTno0TZN3rb/eiln5vFTcNJ5IOyx
	KvdUmn/QCstJE/OUH9tyZmmMxau/Er6iFShK2kds9JZzoubHtzxiEODcN4URT1ko7xcLO/
	hAt1Kq14aY3TnyOO//hdPfnQmECNAokNOXbt8o/p08JT3YJIeyICLXw/bFCtvHh0FrZUZE
	g7IS3JlxRdYYUkURGlA/kUfMvuFpdB02g7rPa62+wPJHvGa4E6ftaJ0Dz/sSRQ==
Date: Mon, 9 Sep 2024 11:49:52 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 05/18] mtd: tests: Include <linux/prandom.h> instead of
 <linux/random.h>
Message-ID: <20240909114952.580d0c20@xps-13>
In-Reply-To: <CAFULd4ZwEcv-KZSpoQznMvd2wZBqAvqvr_JzK7fboR_Ec6721g@mail.gmail.com>
References: <20240905122020.872466-6-ubizjak@gmail.com>
	<20240906151021.736425-1-miquel.raynal@bootlin.com>
	<CAFULd4ZwEcv-KZSpoQznMvd2wZBqAvqvr_JzK7fboR_Ec6721g@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Uros,

ubizjak@gmail.com wrote on Fri, 6 Sep 2024 17:58:39 +0200:

> On Fri, Sep 6, 2024 at 5:10=E2=80=AFPM Miquel Raynal <miquel.raynal@bootl=
in.com> wrote:
> >
> > On Thu, 2024-09-05 at 12:17:13 UTC, Uros Bizjak wrote: =20
> > > Usage of pseudo-random functions requires inclusion of
> > > <linux/prandom.h> header instead of <linux/random.h>.
> > >
> > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > > Cc: Richard Weinberger <richard@nod.at>
> > > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > > Cc: linux-mtd@lists.infradead.org =20
> >
> > Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.gi=
t mtd/next, thanks. =20
>=20
> Miquel, is it possible to just ACK the patch for now? The series
> touches many parts of the kernel, so I guess it is best to harvest
> Acked-by:s in this stage of development and commit all the patches
> some time after the merge window. This will avoid merge conflicts with
> the series.

Changing an include with a more specific include didn't look like a
dangerous change, but I'm fine dropping the patch. Please mention it
next time, because I didn't see it.

Thanks,
Miqu=C3=A8l

