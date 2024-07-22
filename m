Return-Path: <linux-kernel+bounces-259141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8517F9391CC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC061F21E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D489A16E86B;
	Mon, 22 Jul 2024 15:29:53 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519C616E862
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662193; cv=none; b=KKF9do1uEWDCyw/Ixk/3FI5yyTfPxBMYIivUr+O9HsDrGh8du0+3ZjFQL4MrN1oPWpuZgJd2NaJN0GM3uBdpvxIeWgI1V71stb71U6rrfM4lhRhn7Nwn/U5b9gQkSnfchosD0ZF5vr2FXJ0h8/LsiUsbTAgiUQy6WlbES3/PhzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662193; c=relaxed/simple;
	bh=CMz/UJxN47BQ6tDxFxwfIRMNWKWNrIcUjG5LNTtghS0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=pnvWAlJMib8MIFIguj7aewnJP5BFBNmxYRdHph88ZCuklVL/4/Az365Xlkh9MI2gFLjgXtT6R771RJ++2oKw1a93IqzIzE/fS6w3Q4zLjOhmMx/Bpi1E0ie4b9UbZqR6/GmImRtGpyOXBbHpYM2bymcuDvwb9kBpv096u1SFxaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D89626196A4A;
	Mon, 22 Jul 2024 17:21:22 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Qza8hDRPG0nx; Mon, 22 Jul 2024 17:21:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3DB0E609184C;
	Mon, 22 Jul 2024 17:21:22 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Q9HYSQTFU0cQ; Mon, 22 Jul 2024 17:21:22 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 10D4E6196A4A;
	Mon, 22 Jul 2024 17:21:22 +0200 (CEST)
Date: Mon, 22 Jul 2024 17:21:21 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	DRI mailing list <dri-devel@lists.freedesktop.org>, 
	Knop Ryszard <ryszard.knop@intel.com>
Message-ID: <1868573045.102281.1721661681881.JavaMail.zimbra@nod.at>
In-Reply-To: <20240719152542.1554440-1-jfalempe@redhat.com>
References: <20240719152542.1554440-1-jfalempe@redhat.com>
Subject: Re: [PATCH] mtd: mtdoops: Fix kmsgdump parameter renaming.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: mtdoops: Fix kmsgdump parameter renaming.
Thread-Index: TphXISdImxx2iJrcLR4C9m8Leyhpgw==

----- Urspr=C3=BCngliche Mail -----
> Betreff: [PATCH] mtd: mtdoops: Fix kmsgdump parameter renaming.

> When the kmsg_dumper callback parameter changed, the reason variable
> in mtdoops_do_dump() was not updated accordingly.
> This breaks the build with mtdoops.
>=20
> Fixes: e1a261ba599e ("printk: Add a short description string to kmsg_dump=
()")
> Reported-by: Knop Ryszard <ryszard.knop@intel.com>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>=20
> The offended commit is in the drm-misc tree, because it was needed
> by drm_panic. So I will push the fix there too.
>=20
> drivers/mtd/mtdoops.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
> index 86d49db9196d..7bf3777e1f13 100644
> --- a/drivers/mtd/mtdoops.c
> +++ b/drivers/mtd/mtdoops.c
> @@ -305,7 +305,7 @@ static void mtdoops_do_dump(struct kmsg_dumper *dumpe=
r,
> =09struct kmsg_dump_iter iter;
>=20
> =09/* Only dump oopses if dump_oops is set */
> -=09if (reason =3D=3D KMSG_DUMP_OOPS && !dump_oops)
> +=09if (detail->reason =3D=3D KMSG_DUMP_OOPS && !dump_oops)
> =09=09return;
>=20
> =09kmsg_dump_rewind(&iter);
> @@ -317,7 +317,7 @@ static void mtdoops_do_dump(struct kmsg_dumper *dumpe=
r,
> =09=09=09     record_size - sizeof(struct mtdoops_hdr), NULL);
> =09clear_bit(0, &cxt->oops_buf_busy);
>=20
> -=09if (reason !=3D KMSG_DUMP_OOPS) {
> +=09if (detail->reason !=3D KMSG_DUMP_OOPS) {

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

