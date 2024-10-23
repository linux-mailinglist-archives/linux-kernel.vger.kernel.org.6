Return-Path: <linux-kernel+bounces-377762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C71589AC663
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E509B21BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FF419E7F8;
	Wed, 23 Oct 2024 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="l3nMobwd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="jj7j6Aiv"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE73D19DFAC;
	Wed, 23 Oct 2024 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675598; cv=none; b=QHVCnHWRbgc1uY0FskPAo6JoDKxZb7NNV3c4T7vPu0aW8z4szofvzxAqtOuHsS1KlNwbL2tP8pyiNu/QExGIvJaktcTf2ZnPvhcNStA9s2YMKJ/glWVPcDPbWRkersyvWk+DioUqXlW29D6PYmfGe6KPIDAw8k+04APclILwAiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675598; c=relaxed/simple;
	bh=VxvVDNyw6ySri3t4X+ACuVSJgTGXxU/81JYx7yBMXiA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=owxnWv1Xrt3GGmHAP0bQiRXPyoeT6Vyn2TlOIREXJr0fYhytireyetnS1lj+41L6RDKrakrgPq7Fqj9Am0G80nyz7TL2RB0e1MWfD40/L/2xtWRM03/SzDn6TWaxmm9P4pa7HLemgnXQtOjbCC5bNQpxH25NT3SBUa5LTxcG7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=l3nMobwd; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=jj7j6Aiv reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729675594; x=1761211594;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+BKf5KNrU31RpU4f9DG5CAmvfL+4I9L1qsDYZ+zZzCE=;
  b=l3nMobwdH3kvxtE4X86BSUNEGqDqTbAieKux3jVhJ4jTVut+M9N5jD4f
   aUE60hO8JD40qWPfd2PmM+cg1I3vi1F6KNIM6zhERLLWSprfV6YatxQ6A
   0e74qy9aES4Nly6FQ5XGBllC2w49L8D9r2ASF7FBRlwFtI6oQAHn3kdCQ
   stGCI/bsQNtH3MUt0AwpWPHF2126Czbh6lo7ySxhS10OwfxMnCNM/6m6K
   QJ67e18a4XmYFc9tg2/0oHvZa7lY1Fxorpy3rm+7IwF8D8NzPaKLfcS9j
   bgSBc8lehJFHcCh+jFHC7rboB3l3xidK4cWbwQOfuuz83/FHklm/hwj41
   Q==;
X-CSE-ConnectionGUID: N5sDUTW0TzWaNZbOIF1DaQ==
X-CSE-MsgGUID: BV9o/6MzQE6vVbNfyAy0Jg==
X-IronPort-AV: E=Sophos;i="6.11,225,1725314400"; 
   d="scan'208";a="39619700"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Oct 2024 11:26:31 +0200
X-CheckPoint: {6718C147-4-21611FC3-DAD22B0C}
X-MAIL-CPID: B425432F9F0D62CAF79F75DB369425F4_4
X-Control-Analysis: str=0001.0A682F25.6718C147.006C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9D4FB163EF1;
	Wed, 23 Oct 2024 11:26:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729675586;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+BKf5KNrU31RpU4f9DG5CAmvfL+4I9L1qsDYZ+zZzCE=;
	b=jj7j6AivhZGqdOxW9K9Ox6trqW/UaA2OOFLhI/gKvbP1o7poL8tpQ9wuO2AhzuMpDwhlb7
	t9XNkJBSYJ/rqr9suy69zOGSjwhFOGsY6YzPqh+oAilizzZMix+sXu+mOnUc9ARBH9yz0i
	ugvhNjdcQb3KpD6g/VgdvwtFuyDTm2DZVRie0/llR8O/W2R511Z2/GWiveARKmJCYIY5Au
	Yij+bpuudRSNyGbgWleh8E7OSxaOnZcc0FStMNXsJ0Kid5imp8nt5Nad0eKxxliNmigoIl
	qkBxf9W408ds5fwHtbA0eEQ4XWjLRewijHyvjIAlb5tnnsMSHxyZ0/+s9UnV3A==
Message-ID: <e45a5f9a63e6dba8eb57bac3c5001e8a360af393.camel@ew.tq-group.com>
Subject: Re: [PATCH next] drm/fsl-dcu: prevent error pointer dereference in
 fsl_dcu_load()
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Alexander Stein
 <alexander.stein@ew.tq-group.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date: Wed, 23 Oct 2024 11:26:24 +0200
In-Reply-To: <e4e078ed-9342-48f4-80c5-28f0f7b711b0@stanley.mountain>
References: <e4e078ed-9342-48f4-80c5-28f0f7b711b0@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 2024-10-23 at 11:35 +0300, Dan Carpenter wrote:
>=20
> The syscon_regmap_lookup_by_compatible() function returns -ENODEV if
> there isn't a compatible for it or other error pointers on error.  This
> code only checks for -ENODEV instead of checking for other errors so it
> could lead to an error pointer dereference inside the regmap_update_bits(=
)
> function.
>=20
> Fixes: ffcde9e44d3e ("drm: fsl-dcu: enable PIXCLK on LS1021A")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>



> ---
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/=
fsl-dcu/fsl_dcu_drm_drv.c
> index 91a48d774cf7..5997d9b4a431 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> @@ -109,7 +109,9 @@ static int fsl_dcu_load(struct drm_device *dev, unsig=
ned long flags)
>  		return dev_err_probe(dev->dev, ret, "failed to initialize mode setting=
\n");
> =20
>  	scfg =3D syscon_regmap_lookup_by_compatible("fsl,ls1021a-scfg");
> -	if (PTR_ERR(scfg) !=3D -ENODEV) {
> +	if (IS_ERR(scfg) && PTR_ERR(scfg) !=3D -ENODEV)
> +		return dev_err_probe(dev->dev, PTR_ERR(scfg), "failed to find regmap\n=
");
> +	if (!IS_ERR(scfg)) {
>  		/*
>  		 * For simplicity, enable the PIXCLK unconditionally,
>  		 * resulting in increased power consumption. Disabling

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

