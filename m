Return-Path: <linux-kernel+bounces-349167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F2B98F1FB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954081F221A2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21EA19F432;
	Thu,  3 Oct 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kvTn1y3I"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766B626ACD
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967515; cv=none; b=Y+BWSOptWxLq0sgGMbM2th2DUK+XjFKQncXCgaUwM+cNGIa4VffHM0RHNaXYdxs5PsAXVDdQ3I5PFpJPMhlvZhm+SPE6vAuOTfnwS+wTHUpxpN8XpTjJhsKwWB8eiSIg5uPZ3sr4Gqv57n9rSc8NlNbVtLbimIK91qjwByLGdHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967515; c=relaxed/simple;
	bh=GKHtfj37CNGse5EH3aylphaiOEB5Kj4jq9UhlQgMeXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QE8djhayEdiNFI2cM8BfVTQYKZGsOvUGw7vdSw193HKdM7ZEm8i78Ddd/0ZXv1aT8glpkk4m7DvJJ63CM1uOZ0mUeXEbuAb+pdRUEdeX4VOnsskadvdAz95Mmn2rAONnVRi8vp3sGGtcCeNP/8Gd4niVnzeaQDALxKH3bj4XTyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kvTn1y3I; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727967511;
	bh=GKHtfj37CNGse5EH3aylphaiOEB5Kj4jq9UhlQgMeXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kvTn1y3IB4Z2Hk2S+3CF3KHUcG/q6JntATwfk2XtcdS604ITksKF2IGNzOZ7pyYEA
	 sxTsJhKR2E+uG6zP5nWyQivgmL3ixBho9Iy/NzqaalMVAllQek2BbIHqqqFOG/xXZP
	 eq4qJh59TlG7Xnkv+aqoHqr0MQ+RNWWU+ycG8k0+TW2pAyw9jH3bW4vmv4LsZaLlHU
	 ySWEU4+FPo8NpC+uyi5q6cXFTLhiLpK1yWnVc/R6wDQvsphY2Ueh8MKruD8fykQkzP
	 j34HnKRTwyiKc9JTPbQcNnkGu26DooGqctwkZAYdjb6c2KXvq7jA5sxq57l7EKWHes
	 7KI6cfImEHt/A==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F111E17E3601;
	Thu,  3 Oct 2024 16:58:30 +0200 (CEST)
Date: Thu, 3 Oct 2024 16:58:25 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>,
 kernel@collabora.com
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, AngeloGioacchino Del
 Regno <angelogioacchino.delregno@collabora.com>, Liviu Dudau
 <liviu.dudau@arm.com>, =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?=
 <peron.clem@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Grant Likely
 <grant.likely@linaro.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/panthor: Fix OPP refcnt leaks in devfreq
 initialisation
Message-ID: <20241003165825.178bb096@collabora.com>
In-Reply-To: <20241003133037.3398144-2-adrian.larumbe@collabora.com>
References: <20241003133037.3398144-1-adrian.larumbe@collabora.com>
	<20241003133037.3398144-2-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  3 Oct 2024 14:30:29 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Make sure in case of errors between the first fetch of an OPP in
> panthor_devfreq_init and its successive put, the error path decrements its
> reference count to avoid OPP object leaks when removing the device.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> Fixes: fac9b22df4b1 ("drm/panthor: Add the devfreq logical block")
> ---
>  drivers/gpu/drm/panthor/panthor_devfreq.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/=
panthor/panthor_devfreq.c
> index 9d0f891b9b53..ce0ac4563f65 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> @@ -197,7 +197,7 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
>  	if (ret && ret !=3D -ENODEV) {
>  		if (ret !=3D -EPROBE_DEFER)
>  			DRM_DEV_ERROR(dev, "Couldn't retrieve/enable sram supply\n");
> -		return ret;
> +		goto opp_err;
>  	}
> =20
>  	/*
> @@ -207,7 +207,7 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
>  	ret =3D dev_pm_opp_set_opp(dev, opp);
>  	if (ret) {
>  		DRM_DEV_ERROR(dev, "Couldn't set recommended OPP\n");
> -		return ret;
> +		goto opp_err;
>  	}
> =20
>  	dev_pm_opp_put(opp);
> @@ -242,6 +242,10 @@ int panthor_devfreq_init(struct panthor_device *ptde=
v)
>  		DRM_DEV_INFO(dev, "Failed to register cooling device\n");
> =20
>  	return 0;
> +
> +opp_err:
> +	dev_pm_opp_put(opp);
> +	return ret;

If you re-order things (see the following diff), you shouldn't need
this error path.

--->8---

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/pa=
nthor/panthor_devfreq.c
index 9d0f891b9b53..4f1a30f29c06 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -163,13 +163,6 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
=20
        cur_freq =3D clk_get_rate(ptdev->clks.core);
=20
-       opp =3D devfreq_recommended_opp(dev, &cur_freq, 0);
-       if (IS_ERR(opp))
-               return PTR_ERR(opp);
-
-       panthor_devfreq_profile.initial_freq =3D cur_freq;
-       ptdev->current_frequency =3D cur_freq;
-
        /* Regulator coupling only takes care of synchronizing/balancing vo=
ltage
         * updates, but the coupled regulator needs to be enabled manually.
         *
@@ -200,17 +193,24 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
                return ret;
        }
=20
+       opp =3D devfreq_recommended_opp(dev, &cur_freq, 0);
+       if (IS_ERR(opp))
+               return PTR_ERR(opp);
+
+       panthor_devfreq_profile.initial_freq =3D cur_freq;
+       ptdev->current_frequency =3D cur_freq;
+
        /*
         * Set the recommend OPP this will enable and configure the regulat=
or
         * if any and will avoid a switch off by regulator_late_cleanup()
         */
        ret =3D dev_pm_opp_set_opp(dev, opp);
+       dev_pm_opp_put(opp);
        if (ret) {
                DRM_DEV_ERROR(dev, "Couldn't set recommended OPP\n");
                return ret;
        }
=20
-       dev_pm_opp_put(opp);
=20
        /* Find the fastest defined rate  */
        opp =3D dev_pm_opp_find_freq_floor(dev, &freq);

