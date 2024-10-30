Return-Path: <linux-kernel+bounces-389007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBB69B6775
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9095C28174F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75043213EF0;
	Wed, 30 Oct 2024 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dc+6jQKl"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEA62185A3
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301249; cv=none; b=jQvf+UxMp7vhlbfJ4YZ+2dD1FPlJZsOEeBI1+OZhuozvPaeuzAKqmpiiO2dvo9J04sU54XwljF/P8nCpWkWQ4fdkHNuHL1Wc/gbwyoa8aw9awgPcbKZNH124FKIohjQOeL1ns+1Bo+gLxVNUngffgY168DH4qrRGmwPOzVATKxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301249; c=relaxed/simple;
	bh=XDyPHnPK/41K24Mu77jy/av5KyboXA4GUK7JOhfY4QA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GODyQ71ypoovkZvxo96GSj83iF4xFOfE3yQ6KgHlTWTbslQ7u3TUoXgdoHotKd78RFEnHd/xjR2ov3Hx2KOLAHL6bX79ryihpuuvF7S5qkF55XbnDduzE3RjqhGP26A5x8nwZCLpOfip7XInIr9RYgiYAC8EFyMyLibt5vMX1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dc+6jQKl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730301245;
	bh=XDyPHnPK/41K24Mu77jy/av5KyboXA4GUK7JOhfY4QA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dc+6jQKl4pbMnIJ0Is6cu76vG33iBRCDCKosNKfr2HEWKUCu1i3sT+BnrA+isyFqt
	 Kam+YwAYb6YFC9Wv8Csb1Ju3uhpUy2zJZdM0Y4LrNmS5DZ0JB7Ln89fe7Y5CHGLtfQ
	 wDrAvxAJVkaeTIMZLB4r/iYWC+lt6uMt0uCPBypavyqy8xDWDWcVS5nH0ijVvFWt6b
	 LwUnSroqJ0dWB7fYedbVyLO0X+cNC8mIXB1KxGyARJav0MOgL/i6TvanZ+zGbwCYpB
	 hyVaAEwLXYcViQludKYRuFA4vAltAkhjFvlUN+ougwWseXl2ga5xhbSCoWc6vYAB+V
	 zC/yBPjIzYcZQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7BB7A17E3636;
	Wed, 30 Oct 2024 16:14:04 +0100 (CET)
Date: Wed, 30 Oct 2024 16:13:58 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, AngeloGioacchino Del
 Regno <angelogioacchino.delregno@collabora.com>, Liviu Dudau
 <liviu.dudau@arm.com>, =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?=
 <peron.clem@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Grant Likely
 <grant.likely@linaro.org>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/panthor: Fix OPP refcnt leaks in devfreq
 initialisation
Message-ID: <20241030161358.3b78b423@collabora.com>
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

It doesn't apply on top of drm-misc-fixes. Could you send a v3 based
on drm-misc-fixes please?

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
>  }
> =20
>  int panthor_devfreq_resume(struct panthor_device *ptdev)


