Return-Path: <linux-kernel+bounces-348669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E925798EA3D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 321DFB217D4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A087D417;
	Thu,  3 Oct 2024 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MHvIFztx"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D62CA9
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939870; cv=none; b=ODCbr4Kljoim+7pqGyilw9I4/Ou/5OcEQtUzjrk11NZY4tRiBplGO2vDFPRB3xhvGTKADFK+afb/cLo0zwiMUgtOhOV4j/n45SsgaJ+K+bdJvp31lIdcmpUGS0ryupo/nFFyZvZhdCHpW85lmIm0QoqIyYaCpgbOCRvkqMRHGgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939870; c=relaxed/simple;
	bh=lT8bT5kSxgIfLqr7Z2JCHBxtG5CmBxPjUIRJ7Ggt7fw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8Yh18sMvSGiUWkQVAWHPALLj9XAjFZSSMHDyw9JL8Odc2BZm6da9bBqhncysduHW8NOJ+rJwK8wRf4543AaU+04ryrC/9+4nJTwKWKkBveG6V0Gj05Z2ajl46NLXYJtnqza0prm6TKJBTC5sWiRH06ovyp5irH6plLkhiLo0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MHvIFztx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727939866;
	bh=lT8bT5kSxgIfLqr7Z2JCHBxtG5CmBxPjUIRJ7Ggt7fw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MHvIFztxhjhDMGBD4nqw27saXhmX4h2DeAgqBUJynHF/mjC9uxB4OQmSCiJ4xGhZL
	 n5FMwm+/NMqC/knPYDJ1QbHxbxPhE/HfcatTu8sY+CTShmP5qP9C7YueNWsFaIXqac
	 uZCJT6sNkdYV1SL3/kT7OWuVar9Lz6JnqGFfG4pgnPfa1V2N7Ix5f8p1OkaEPza8ia
	 97e2yNcrnzC6IicFMg+yex/+1nX7feZwta0VFnVYN9G6ZXzxpP7rKC20OzQH/y2vED
	 xtIJpRrgY4meaKvDxlsHPmMG/Csf7FlQFzma7ow+NA6W5fm1iESOWXWHhiwsGXurLi
	 u8Uk79hThnC8A==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 56EB217E0F98;
	Thu,  3 Oct 2024 09:17:46 +0200 (CEST)
Date: Thu, 3 Oct 2024 09:17:40 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, AngeloGioacchino Del
 Regno <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: Add missing OPP table refcnt decremental
Message-ID: <20241003091740.4e610f21@collabora.com>
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
>=20
> Fix it by putting OPP objects as many times as they're retrieved.
> Also remove an unnecessary whitespace.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> Fixes: f11b0417eec2 ("drm/panfrost: Add fdinfo support GPU load metrics")

Reviewed-by:=20

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

Shouldn't this be moved after the dev_pm_opp_set_opp() that's
following?

>  	/*
>  	 * Set the recommend OPP this will enable and configure the regulator
>  	 * if any and will avoid a switch off by regulator_late_cleanup()


