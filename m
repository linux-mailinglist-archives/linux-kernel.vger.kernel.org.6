Return-Path: <linux-kernel+bounces-563560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD6AA64422
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF6D1893917
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E429664C6;
	Mon, 17 Mar 2025 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cPJX69XT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E92D219317
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197580; cv=none; b=jMXgd34o7pmAGHHjWxFtQBkMGPN3cYP4K5vFM6vt/rXIPDwHBMWSTT2aVVy+APt/qEmYeV674tgA+3xj3Hsrli2OFObgM4YlVIiaoMLz3aPgcaFk+yxoewtf5iHTE8tko5judA5MEu8ISaf2N1qGegiPymp2y1CmHeVwWC/NSVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197580; c=relaxed/simple;
	bh=TJWCBFHyo+kksNlpZw7pIYngyF+E1fD1NPR7ro2ue6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqJiOpcHvBLPlmGmOZNnHZi5C7vxgzGJQxTdO4ZNW5ZkjYK4IrjTQcvLNncySSoa8mK855nS+q+2Oi831fr/IIJRP5y5Rf09tiYynf6a8/Q6nfRam0O6JyTEjJeMBTZZN1ImSO4xItNZYS2cpx8UIsMOBclMCyHee7rua5MQzIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cPJX69XT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742197570;
	bh=TJWCBFHyo+kksNlpZw7pIYngyF+E1fD1NPR7ro2ue6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cPJX69XT7Vt15Erq5ioPzpG2TNNhU9ASyGCwepbrHasHPdtmeNYoOxU8DpNKFC+pW
	 IHZVlDExhm5YU0Aqdv1oUdi3SiQNpdYywHJ0npTuV+queLrh6izRR3wZaiM6i7aXHF
	 ekgsgcsnBD7syH930ypYErjWxpKXTrz7PoC0+kDWGrTlczCmG0aD0G/ygbKpAfTk2q
	 84otGlw7ra0iWG1WOSf/Pl416wn8/LBSmVX+Exbq/w6ThCUsOraexFjRGh4pabYslg
	 5g1K49U7oA6SBHWCYkg6L1VDJDIllyHjqF/P3syDellvmumE3Kkz8WLolF7JOfnyMm
	 5FXhrQULj7yCQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 58FC717E0B12;
	Mon, 17 Mar 2025 08:46:10 +0100 (CET)
Date: Mon, 17 Mar 2025 08:45:56 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] drm/panthor: Introduce BO labeling
Message-ID: <20250317084556.763bd126@collabora.com>
In-Reply-To: <20250316215139.3940623-2-adrian.larumbe@collabora.com>
References: <20250316215139.3940623-1-adrian.larumbe@collabora.com>
	<20250316215139.3940623-2-adrian.larumbe@collabora.com>
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

On Sun, 16 Mar 2025 21:51:32 +0000
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Add a new character string Panthor BO field, and a function that allows
> setting it from within the driver.
>=20
> Driver takes care of freeing the string when it's replaced or no longer
> needed at object destruction time, but allocating it is the responsibility
> of callers.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_gem.c | 18 ++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_gem.h | 12 ++++++++++++
>  2 files changed, 30 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/pant=
hor/panthor_gem.c
> index 8244a4e6c2a2..3c58bb2965ea 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -18,6 +18,9 @@ static void panthor_gem_free_object(struct drm_gem_obje=
ct *obj)
>  	struct panthor_gem_object *bo =3D to_panthor_bo(obj);
>  	struct drm_gem_object *vm_root_gem =3D bo->exclusive_vm_root_gem;
> =20
> +	kfree(bo->label);
> +	mutex_destroy(&bo->label_lock);
> +
>  	drm_gem_free_mmap_offset(&bo->base.base);
>  	mutex_destroy(&bo->gpuva_list_lock);
>  	drm_gem_shmem_free(&bo->base);
> @@ -196,6 +199,7 @@ struct drm_gem_object *panthor_gem_create_object(stru=
ct drm_device *ddev, size_t
>  	obj->base.map_wc =3D !ptdev->coherent;
>  	mutex_init(&obj->gpuva_list_lock);
>  	drm_gem_gpuva_set_lock(&obj->base.base, &obj->gpuva_list_lock);
> +	mutex_init(&obj->label_lock);
> =20
>  	return &obj->base.base;
>  }
> @@ -247,3 +251,17 @@ panthor_gem_create_with_handle(struct drm_file *file,
> =20
>  	return ret;
>  }
> +
> +void
> +panthor_gem_label_bo(struct drm_gem_object *obj, const char *label)
> +{
> +	struct panthor_gem_object *bo =3D to_panthor_bo(obj);
> +	const char *old_label;
> +
> +	mutex_lock(&bo->label_lock);
> +	old_label =3D bo->label;
> +	bo->label =3D label;
> +	mutex_unlock(&bo->label_lock);
> +
> +	kfree(old_label);
> +}
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/pant=
hor/panthor_gem.h
> index 5749ef2ebe03..da9268d24566 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.h
> +++ b/drivers/gpu/drm/panthor/panthor_gem.h
> @@ -46,6 +46,15 @@ struct panthor_gem_object {
> =20
>  	/** @flags: Combination of drm_panthor_bo_flags flags. */
>  	u32 flags;
> +
> +	/**
> +	 * @label: Pointer to NULL-terminated string, can be assigned within the
> +	 * driver itself or through a specific IOCTL.
> +	 */
> +	const char *label;
> +
> +	/** @label_lock: Lock that protects access to the @label field. */
> +	struct mutex label_lock;

Nit: can we have a label struct with the lock and string under it
instead?

	/** @label: Fields related to GEM labeling. */
	struct {
		/**
		 * @label.str: Pointer to NULL-terminated string, can be assigned within =
the
		 * driver itself or through a specific IOCTL.
		 */
		const char *str;

		/** @label.lock: Lock that protects access to the @label field. */
		struct mutex lock;
	} label;

>  };
> =20
>  /**
> @@ -91,6 +100,9 @@ panthor_gem_create_with_handle(struct drm_file *file,
>  			       struct panthor_vm *exclusive_vm,
>  			       u64 *size, u32 flags, uint32_t *handle);
> =20
> +void
> +panthor_gem_label_bo(struct drm_gem_object *obj, const char *label);
> +
>  static inline u64
>  panthor_kernel_bo_gpuva(struct panthor_kernel_bo *bo)
>  {


