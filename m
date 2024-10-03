Return-Path: <linux-kernel+bounces-348673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D89598EA46
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E616E1F219A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4679384A4D;
	Thu,  3 Oct 2024 07:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pgzOY+Ej"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0AC7D417
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939986; cv=none; b=dePY4GVevvbCWaDLwkAFddVduDRNiVanNOiEMPuDzYTjZnc5Iqy8W2whmzb5jhrCdCl+HJmK+cs9Jo4Fd1fAfVohNnYuMl8m8WtTHcbGVQq49HeOlXCX5nLkfNcoGQWvZBVCUw+gwK5eXhjU8AZYX12OplaaOqPjX6eNE4rvXGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939986; c=relaxed/simple;
	bh=fVrQjiIXiyJfjUITmJLGNtW5drmI/FLWZ17s/X1WhbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAq7Dfn3qPhBcspn+8vPwIAoWyUhbuqGrFGsNqfhrC8rQafDH2Jc4ssF1UJ6kWFmJv/aTBTz60IomgcYqYZC1emPVCl9MDvqHwju/MmljqI7yOFKHCYB9hm4xCKaABwpmmYOIlUn5zm3WVUK7o7BNv1uWkFQ1UPmEQ4VOg6QBQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pgzOY+Ej; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727939983;
	bh=fVrQjiIXiyJfjUITmJLGNtW5drmI/FLWZ17s/X1WhbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pgzOY+EjkbMrN9rKcllO8chvnaU/9aZmgngD9av8iXyK7yltXc628NLRQYo3fQ20W
	 C8N3FsoUHctc5cOp1QbGoQmIplOAaPGmJZXzs1eIsNrjVEYQfLePJZEILaqJi+aEsD
	 2MuI3D0pAo8wXoX36VCAWNh0oZy+SPkpM3SCwZxszeUmZHSGM1ES5ZPz1gWbgiUNED
	 xCR2Sj7eyPpWV9ppZ9edKI9KYIl0Vm69vkhbCGefNsC4rCI8TlniJCdbcajw1kDOvL
	 DwD5Cs++bcYrJBWUXa5Hdw66phU6YazVuEcJvYDAKG5vTmnVryUppU7CIBIsa/pzoI
	 dPQueOYy2fKlA==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D0F6B17E0FE0;
	Thu,  3 Oct 2024 09:19:42 +0200 (CEST)
Date: Thu, 3 Oct 2024 09:19:36 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, AngeloGioacchino Del
 Regno <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: Add missing OPP table refcnt decremental
Message-ID: <20241003091936.0b7d6f15@collabora.com>
In-Reply-To: <20241003002603.3177741-1-adrian.larumbe@collabora.com>
References: <20241003002603.3177741-1-adrian.larumbe@collabora.com>
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

On Thu,  3 Oct 2024 01:25:37 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Commit f11b0417eec2 ("drm/panfrost: Add fdinfo support GPU load metrics")
> retrieves the OPP for the maximum device clock frequency, but forgets to
> keep the reference count balanced by putting the returned OPP object. This
> eventually leads to an OPP core warning when removing the device.

BTW, we do have opp leaks in the error paths of panthor_devfreq_init()
too.

>=20
> Fix it by putting OPP objects as many times as they're retrieved.
> Also remove an unnecessary whitespace.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> Fixes: f11b0417eec2 ("drm/panfrost: Add fdinfo support GPU load metrics")
> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/dr=
m/panfrost/panfrost_devfreq.c
> index 2d30da38c2c3..c7d3f980f1e5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -38,7 +38,7 @@ static int panfrost_devfreq_target(struct device *dev, =
unsigned long *freq,
>  		return PTR_ERR(opp);
>  	dev_pm_opp_put(opp);
> =20
> -	err =3D  dev_pm_opp_set_rate(dev, *freq);
> +	err =3D dev_pm_opp_set_rate(dev, *freq);
>  	if (!err)
>  		ptdev->pfdevfreq.current_frequency =3D *freq;
> =20
> @@ -177,6 +177,8 @@ int panfrost_devfreq_init(struct panfrost_device *pfd=
ev)
>  	 */
>  	pfdevfreq->current_frequency =3D cur_freq;
> =20
> +	dev_pm_opp_put(opp);
> +
>  	/*
>  	 * Set the recommend OPP this will enable and configure the regulator
>  	 * if any and will avoid a switch off by regulator_late_cleanup()


