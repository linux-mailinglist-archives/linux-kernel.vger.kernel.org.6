Return-Path: <linux-kernel+bounces-349164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CD298F1F0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51465B21245
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C50019F432;
	Thu,  3 Oct 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E9vQjEb6"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6A119F420
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967407; cv=none; b=Ig94Evp2ii70blVoj8mx0ZJ3beilt0OUPmmtpdEsMWaWU13YDA6ii9qNOYiKBxMQlqRPyr9MhOK3LqNJaFb73mjvEQbgog1eovxZMGIPwngMELWoO4bVnZxCNqo0goqeAbOS0PmU/NKj+MjV9dB2HfoFQ9tG5ebOsUYoWlu1ypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967407; c=relaxed/simple;
	bh=xNB8aA4lwhkIWkbB3SrXYkjCVDmlWQ+HINc2HyZXxy8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rz8GKUzgPfqxjm2RvZp5i/V1RqupOTSf4C9UrTPW3tGgB0IsYbd8Yq9xJiD/ZrRDa018ia7PSGHweVmAQgg/gilZjOW8w7D32kRBBCpIpAjqZoHY2DVpEc2uUwZrS8IxlNEWtP7d4MRwEdmMy2cl786ykVrR1NhQjnSJDRAJgvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E9vQjEb6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727967404;
	bh=xNB8aA4lwhkIWkbB3SrXYkjCVDmlWQ+HINc2HyZXxy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E9vQjEb6DZSHlrpW7fhQwpsHX0Ffb6bXFAImCCaFq0YDIV12Tp1lZW14imXDY/5UF
	 lFzOfG3JJzDfdxe2lkFDYMmuTxIyDvx6Az0t2DgBVAOodUbgaybIo7iZOo9WsEg6/M
	 5PgfdyL5qEIxmoTPICOJBELh08GIlBGMnshc4aIsGR79tScD7f+v+ulUFAx47pbmGB
	 PTC+D9LNhXrOYen9/WEI43q+CffeZRDqDTTCsbBBoj9BGdsWXFIqc22nNGXYGAxbNJ
	 M/oGMluRWgrmLOdemPG616O4K+pST87PHmS+egIv03wBWzd+2IPyojeAJ3A5l9T7IX
	 0lgqjrm90HnsQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 995AF17E3600;
	Thu,  3 Oct 2024 16:56:43 +0200 (CEST)
Date: Thu, 3 Oct 2024 16:56:38 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, AngeloGioacchino Del
 Regno <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/panfrost: Add missing OPP table refcnt
 decremental
Message-ID: <20241003165638.65a2d16e@collabora.com>
In-Reply-To: <20241003133037.3398144-1-adrian.larumbe@collabora.com>
References: <20241003133037.3398144-1-adrian.larumbe@collabora.com>
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

On Thu,  3 Oct 2024 14:30:28 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Commit f11b0417eec2 ("drm/panfrost: Add fdinfo support GPU load metrics")
> retrieves the OPP for the maximum device clock frequency, but forgets to
> keep the reference count balanced by putting the returned OPP object. This
> eventually leads to an OPP core warning when removing the device.
>=20
> Fix it by putting OPP objects as many times as they're retrieved. That
> includes putting the OPP object in case setting it fails.
>=20
> Also remove an unnecessary whitespace.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> Fixes: f11b0417eec2 ("drm/panfrost: Add fdinfo support GPU load metrics")
> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/dr=
m/panfrost/panfrost_devfreq.c
> index 2d30da38c2c3..4b8840a41779 100644
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
> @@ -184,9 +184,12 @@ int panfrost_devfreq_init(struct panfrost_device *pf=
dev)
>  	ret =3D dev_pm_opp_set_opp(dev, opp);

Put the dev_pm_opp_put(opp) here, and you can drop the one in the error
path.

>  	if (ret) {
>  		DRM_DEV_ERROR(dev, "Couldn't set recommended OPP\n");
> +		dev_pm_opp_put(opp);
>  		return ret;
>  	}
> =20
> +	dev_pm_opp_put(opp);
> +
>  	/* Find the fastest defined rate  */
>  	opp =3D dev_pm_opp_find_freq_floor(dev, &freq);
>  	if (IS_ERR(opp))


