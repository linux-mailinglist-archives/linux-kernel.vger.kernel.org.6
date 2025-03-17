Return-Path: <linux-kernel+bounces-563572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E961A64465
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE82516FF2A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D7C21B909;
	Mon, 17 Mar 2025 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VRmLEKwH"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB35789D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742198092; cv=none; b=N2nmWp4eWgmlZvCVviY45CCzphN9rpG4xF/CLtaPjnDBxddiP2HNo98PJnZas+lVvXiORK2yrUHfbqzCICSybf9y3XwNSQfxkfbpIOtorhzh3ymvY3SHOcmpUhU4km1hoHJdaxkTXz10G0/KRn1CkBglr7GPkjEx7ApXoL0YXhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742198092; c=relaxed/simple;
	bh=MrqHrpOxtBdNPctpsoz+sTFWqBqGBrTaNSgz51e6ycY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRl2YjyP1BijmNGdGVUpZw/Rbr9k33w1g3swFmA7CtknwjQisY+hF6CbTrV/1KV2TMHld0DEsWrozsIk37Bn1CTemn9soo+mUm5AJj/ymPVZ6v6FoMpE+VcA0UGrfK+VBqmQzTski11aUsQ1Boy5MQMsNfjuKJ9gM9T1jPQHQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VRmLEKwH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742198088;
	bh=MrqHrpOxtBdNPctpsoz+sTFWqBqGBrTaNSgz51e6ycY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VRmLEKwHK+OW2XCnum5+CrFE3OuRsYISsNPm4mkpo38z8ti8p/xhcc4gOjBn4aSMj
	 oMKCVGTBoco54jWF2b577qm3azcR5A3uuFgokEYp1cirgLphdne5fea4MeeVyY4TKi
	 DeCZoNwemkLRCgaoJUSI00VeH0TpuqSz17jngPXItiOBSNs+wR9JoehsB9EBslnfYj
	 mZBAEqVT9dxckEl9iiLG9CjQr8xOEbFxsFufFlL0Az6Qj2H/0z4j81UMkqB7xcRH2A
	 NO3IE67Njvu4/HGpe0wcf5UXcW7UwySm1viDuso/gB9V9VHZIP8JH/nLCFCgYCeYfK
	 i1Wnb1wfR+LoQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DD49B17E05C8;
	Mon, 17 Mar 2025 08:54:47 +0100 (CET)
Date: Mon, 17 Mar 2025 08:54:36 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] drm/panthor: Add driver IOCTL for setting BO labels
Message-ID: <20250317085436.35edbf47@collabora.com>
In-Reply-To: <20250316215139.3940623-3-adrian.larumbe@collabora.com>
References: <20250316215139.3940623-1-adrian.larumbe@collabora.com>
	<20250316215139.3940623-3-adrian.larumbe@collabora.com>
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

On Sun, 16 Mar 2025 21:51:33 +0000
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Allow UM to label a BO for which it possesses a DRM handle.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 31 +++++++++++++++++++++++++++
>  include/uapi/drm/panthor_drm.h        | 14 ++++++++++++
>  2 files changed, 45 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/pant=
hor/panthor_drv.c
> index 310bb44abe1a..f41b8946258f 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1330,6 +1330,35 @@ static int panthor_ioctl_vm_get_state(struct drm_d=
evice *ddev, void *data,
>  	return 0;
>  }
> =20
> +static int panthor_ioctl_label_bo(struct drm_device *ddev, void *data,
> +				  struct drm_file *file)
> +{
> +	struct drm_panthor_label_bo *args =3D data;
> +	struct drm_gem_object *obj;
> +	const char *label;
> +	int ret =3D 0;
> +
> +	obj =3D drm_gem_object_lookup(file, args->handle);
> +	if (!obj)
> +		return -ENOENT;
> +
> +	if (args->len && args->label) {

We probably want to have a limit on the label length (PAGE_SIZE or
less?). I would also return -EINVAL if the length is not zero and the
label is NULL instead of silently setting the label to NULL.

> +		label =3D strndup_user(u64_to_user_ptr(args->label), args->len + 1);
> +		if (IS_ERR(label)) {
> +			ret =3D PTR_ERR(label);
> +			goto err_label;
> +		}
> +	} else
> +		label =3D NULL;

	} else {
		label =3D NULL;
	}
> +
> +	panthor_gem_label_bo(obj, label);
> +
> +err_label:
> +	drm_gem_object_put(obj);
> +
> +	return ret;
> +}
> +

