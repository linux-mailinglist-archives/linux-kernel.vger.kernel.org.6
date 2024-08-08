Return-Path: <linux-kernel+bounces-280161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9517C94C677
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0461C218E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081CF15B99F;
	Thu,  8 Aug 2024 21:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rShFr4c0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511D08827
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 21:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723153910; cv=none; b=dTXeTsW+vBVIwSinbSTDEqtEqOBaRC1dSsOmE8pa5xfcqehDhFLtdS7MMw2aiz7Wg8+EC+2DabLcw9ZxFGxL/tN1WusEnbkOuf5KjuTuu0U+Xqx1REOduzdKhqct7GdBQSzPS3ak7iy5sPd2kyGY1Y92MilDeW2exkoZwsztl0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723153910; c=relaxed/simple;
	bh=3TwS60iIKkqYIWLXbVPdeRGu64tLBLQpiHvY1xMb4xY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNMfV1r0ecQ+R/I6nPtsCptQ5FYCyVli2w8MOa5KJo7BjEZpq0ivIE7Gjs0pCepOEk0duYI2QwXQxamTmFKHtj3yPCP9UX8amCxg08l8gWDI9G99ZvOzkZcm9H17Djo/ryA/AsXNv8o6TQUqSbU5g04aWoyAKsEBulvsz8ujMF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rShFr4c0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB63C32782;
	Thu,  8 Aug 2024 21:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723153909;
	bh=3TwS60iIKkqYIWLXbVPdeRGu64tLBLQpiHvY1xMb4xY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rShFr4c0XMySRfus8TDmx/uyPwFwu03rtMybAa2GpZNuFDoEuG9ReBBVD1zfRIbkB
	 nAMHbWdw5aHi+zKcy0/oMgYtuNDVZQ/1XyoxtvsJXBcBl0UlmmZGgGBPiQpcKlR6Ty
	 /wlgTuyPW7z3+FxK/+87xlWeBQjeviO/UIf/GRtJAfT/DnasoKgfR7hPhtJNBnlPJ0
	 ndUd2OoTdUu0O+3xXeLjN6hXk1A2Cxvgvb2cpd675HA3Gd9zId1GlPMGqE/MmhJn3H
	 VPrq3uGiwcmhu3unWTHLMEjproGLYgb1rz3r5NPV9U/78nkR1nDDlhwTPoYMZMaUwZ
	 241d+m3L/r39w==
Date: Thu, 8 Aug 2024 23:51:44 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: John Snow <jsnow@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Cleber Rosa <crosa@redhat.com>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 7/7] scripts/ghes_inject: add a script to generate
 GHES error inject
Message-ID: <20240808235144.726ab8e4@foz.lan>
In-Reply-To: <CAFn=p-bM3oECXtPt5zVZSh53dJx+TDciU_N+vCW4Xp-Jd0MaHw@mail.gmail.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<0654a89fe24f4343016b9cecc0752594ad1cd49f.1722634602.git.mchehab+huawei@kernel.org>
	<CAFn=p-bM3oECXtPt5zVZSh53dJx+TDciU_N+vCW4Xp-Jd0MaHw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Thu, 8 Aug 2024 16:58:38 -0400
John Snow <jsnow@redhat.com> escreveu:

> On Fri, Aug 2, 2024 at 5:44=E2=80=AFPM Mauro Carvalho Chehab <
> mchehab+huawei@kernel.org> wrote: =20
>=20

> > +#!/usr/bin/env python3
> > +#
> > +# pylint: disable=3DC0301, C0114, R0912, R0913, R0914, R0915, W0511
> > =20
>=20
> Out of curiosity, what tools are you using to delint your files=20

Primarily I use pylint, almost always with disable line(s), as those lint
tools have some warnings that sound too silly (like too many/too low=20
functions/branches/arguments...). From time to time, I review the disable
lines, to keep the code as clean as desired.

Sometimes I also use pep8 (now named as pycodestyle) and black, specially=20
when I want some autoformat hints (I manually commit the hunks that make
sense), but I prefer pylint as the primary checking tool. I'm not too
found of the black's coding style, though[1].

[1] For instance, black would do this change:

	-        g_arm.add_argument("--arm", "--arm-valid",
	-                           help=3Df"ARM valid bits: {arm_valid_bits}")
	+        g_arm.add_argument(
	+            "--arm", "--arm-valid", help=3Df"ARM valid bits: {arm_valid_b=
its}"
	+        )

IMO, the original coding style I wrote is a lot better than black's
suggestion - and it is closer to the C style I use at the Linux Kernel ;-)

> and how are
> you invoking them?

I don't play much with such tools, though. I usually just invoke them with
the python file names(s) without passing any parameters nor creating any
configuration file.

> I don't really maintain any strict regime for python files under
> qemu.git/scripts (yet), so I am mostly curious as to what regimes others
> are using currently. I don't see most QEMU contributors checking in pylint
> ignores etc directly into the files, so it caught my eye.

Having some verification sounds interesting, as it may help preventing
some hidden bugs (like re-defining a variable that it was already used
globally), if such check is not too picky and if stupid warnings can be=20
bypassed.

Regards,
Mauro


