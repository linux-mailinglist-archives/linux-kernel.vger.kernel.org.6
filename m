Return-Path: <linux-kernel+bounces-531466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 923FAA440D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125DB188B4B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B4B26982B;
	Tue, 25 Feb 2025 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bhllHNYj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BFA21931C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490139; cv=none; b=Up7KLo6gwcqnEWvoan5BMi0/OxKciCOiyCYw0bmc/S5A5BFjFIBx5kv/ARagWis6Y0M07+YsU7PwnpKLNLKnSnTbafATfuWAI8qWLGYcMqifN9sKAoECSidhnSZzLtvhWQo3wlfHeOAmPUWjtbEM1kLlMa4Ygz4mWkWLw9/VO+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490139; c=relaxed/simple;
	bh=wsU4kJ1XGzokvgOGLtJpT/bXWw/ITBLYkrSt5rEXIDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4fd5HwEvDh7uyLeyYDfmNfL1BQiXOuWYX014zuxacytXXL4EGMGl36rpN97x4vJIkkB3mNaxZSTZK+Ge8q6lla9x522YExdQnouy4RGjWaV4tDlSh6kegSO4XjxKCOM9wKQ0xsz0znOMF79+oXQtQf3T5jnHRxpV/riaMHeaZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bhllHNYj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740490135;
	bh=wsU4kJ1XGzokvgOGLtJpT/bXWw/ITBLYkrSt5rEXIDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bhllHNYj49a9OWjQdFME3L8gLMCfI5obbF6NCs1gZK3j5iB3nHqnGEKAxq/g54Fxs
	 TqGOrJB7tZB4L6kxN1lMR1jnd70Ol639bgcuGeVqTDUfW2hXSnwRLBA8Imwfj8TsLl
	 rOHjTds71Jd+KWfdDg8hh4J+Aeoky5HrukCyWjthchQszCtY+o5WCxXQJD9zVpJtCJ
	 fH+96Ui1lyfkyX/wHy8ZbvaWKWL7ImITRJAWkdk0Q0SY4X7tWgiSBmgE4MWtNMGP5C
	 zmPAGLrUo/so15DDfTtN039znY/robn4Cv/Sy3YJau+Mcd98N5aK7uLCyAH2Su0zk5
	 +JMbif5vKUKmg==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B2D6B17E00FC;
	Tue, 25 Feb 2025 14:28:54 +0100 (CET)
Date: Tue, 25 Feb 2025 14:28:49 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Steven
 Price <steven.price@arm.com>, Rob Herring <robh@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com
Subject: Re: [RFC PATCH 4/7] drm/shmem: Introduce the notion of sparse
 objects
Message-ID: <20250225142849.4dcec919@collabora.com>
In-Reply-To: <20250218232552.3450939-5-adrian.larumbe@collabora.com>
References: <20250218232552.3450939-1-adrian.larumbe@collabora.com>
	<20250218232552.3450939-5-adrian.larumbe@collabora.com>
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

On Tue, 18 Feb 2025 23:25:34 +0000
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Sparse DRM objects will store their backing pages in an xarray, to avoid =
the
> overhead of preallocating a huge struct page pointer array when only a ve=
ry
> small range of indices might be assigned.
>=20
> For now, only the definition of a sparse object as a union alternative to=
 a
> 'dense' object is provided, with functions that exploit it being part of =
later
> commits.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 42 +++++++++++++++++++++++---
>  include/drm/drm_gem_shmem_helper.h     | 18 ++++++++++-
>  2 files changed, 54 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm=
_gem_shmem_helper.c
> index 5ab351409312..d63e42be2d72 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -10,6 +10,7 @@
>  #include <linux/shmem_fs.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> +#include <linux/xarray.h>
> =20
>  #ifdef CONFIG_X86
>  #include <asm/set_memory.h>
> @@ -50,7 +51,7 @@ static const struct drm_gem_object_funcs drm_gem_shmem_=
funcs =3D {
> =20
>  static struct drm_gem_shmem_object *
>  __drm_gem_shmem_create(struct drm_device *dev, size_t size, bool private,
> -		       struct vfsmount *gemfs)
> +		       bool sparse, struct vfsmount *gemfs)
>  {
>  	struct drm_gem_shmem_object *shmem;
>  	struct drm_gem_object *obj;
> @@ -90,6 +91,11 @@ __drm_gem_shmem_create(struct drm_device *dev, size_t =
size, bool private,
> =20
>  	INIT_LIST_HEAD(&shmem->madv_list);
> =20
> +	if (unlikely(sparse))
> +		xa_init_flags(&shmem->xapages, XA_FLAGS_ALLOC);
> +
> +	shmem->sparse =3D sparse;

Looks like the only caller passing sparse=3Dtrue is
drm_gem_shmem_create_sparse(), and the sparse property is not used for
the rest of the gem_shmem object initialization, so maybe we could move
that code to drm_gem_shmem_create_sparse() instead of modifying the
prototype of __drm_gem_shmem_create().

> +
>  	if (!private) {
>  		/*
>  		 * Our buffers are kept pinned, so allocating them
> @@ -124,10 +130,16 @@ __drm_gem_shmem_create(struct drm_device *dev, size=
_t size, bool private,
>   */
>  struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev=
, size_t size)
>  {
> -	return __drm_gem_shmem_create(dev, size, false, NULL);
> +	return __drm_gem_shmem_create(dev, size, false, false, NULL);
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_create);
> =20
> +struct drm_gem_shmem_object *drm_gem_shmem_create_sparse(struct drm_devi=
ce *dev, size_t size)
> +{
> +	return __drm_gem_shmem_create(dev, size, false, true, NULL);
> +}
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_create_sparse);
> +
>  /**
>   * drm_gem_shmem_create_with_mnt - Allocate an object with the given siz=
e in a
>   * given mountpoint
> @@ -145,7 +157,7 @@ struct drm_gem_shmem_object *drm_gem_shmem_create_wit=
h_mnt(struct drm_device *de
>  							   size_t size,
>  							   struct vfsmount *gemfs)
>  {
> -	return __drm_gem_shmem_create(dev, size, false, gemfs);
> +	return __drm_gem_shmem_create(dev, size, false, false, gemfs);
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_create_with_mnt);
> =20
> @@ -173,7 +185,9 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *=
shmem)
>  			sg_free_table(shmem->sgt);
>  			kfree(shmem->sgt);
>  		}
> -		if (shmem->pages)
> +
> +		if ((!shmem->sparse && shmem->pages) ||
> +		    (shmem->sparse && !xa_empty(&shmem->xapages)))
>  			drm_gem_shmem_put_pages(shmem);

Can we let drm_gem_shmem_put_pages() do the is_empty() check?

> =20
>  		drm_WARN_ON(obj->dev, shmem->pages_use_count);
> @@ -191,11 +205,19 @@ static int drm_gem_shmem_get_pages(struct drm_gem_s=
hmem_object *shmem)
>  	struct drm_gem_object *obj =3D &shmem->base;
>  	struct page **pages;
> =20
> +	if (drm_WARN_ON(obj->dev, shmem->sparse))
> +		return -EINVAL;
> +
>  	dma_resv_assert_held(shmem->base.resv);
> =20
>  	if (shmem->pages_use_count++ > 0)
>  		return 0;
> =20
> +	/* We only allow increasing the user count in the case of
> +	  sparse shmem objects with some backed pages for now */
> +	if (shmem->sparse && xa_empty(&shmem->xapages))
> +		return -EINVAL;

You'll never enter this branch because you return -EINVAL early when
sparse=3D=3Dtrue.

> +
>  	pages =3D drm_gem_get_pages(obj);
>  	if (IS_ERR(pages)) {
>  		drm_dbg_kms(obj->dev, "Failed to get pages (%ld)\n",
> @@ -541,6 +563,8 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault=
 *vmf)
>  	struct page *page;
>  	pgoff_t page_offset;
> =20
> +	drm_WARN_ON(obj->dev, shmem->sparse);

For all those WARN_ON()s you add, I would add a comment explaining why
you don't expect sparse objects to enter this path. In that case, it
has to do with the fact sparse GEMs are not mmap-able (yet?).
And, if you don't want to populate on-demand, you should probably
return VM_FAULT_SIGBUS here, even if that's not expected.

> +
>  	/* We don't use vmf->pgoff since that has the fake offset */
>  	page_offset =3D (vmf->address - vma->vm_start) >> PAGE_SHIFT;
> =20
> @@ -567,6 +591,7 @@ static void drm_gem_shmem_vm_open(struct vm_area_stru=
ct *vma)
>  	struct drm_gem_shmem_object *shmem =3D to_drm_gem_shmem_obj(obj);
> =20
>  	drm_WARN_ON(obj->dev, obj->import_attach);
> +	drm_WARN_ON(obj->dev, shmem->sparse);
> =20
>  	dma_resv_lock(shmem->base.resv, NULL);
> =20
> @@ -666,6 +691,9 @@ void drm_gem_shmem_print_info(const struct drm_gem_sh=
mem_object *shmem,
>  	if (shmem->base.import_attach)
>  		return;
> =20
> +	if (drm_WARN_ON(shmem->base.dev, shmem->sparse))
> +		return;
> +

We probably want to print some of these in case we're dealing with a
sparse GEM object.

>  	drm_printf_indent(p, indent, "pages_use_count=3D%u\n", shmem->pages_use=
_count);
>  	drm_printf_indent(p, indent, "vmap_use_count=3D%u\n", shmem->vmap_use_c=
ount);
>  	drm_printf_indent(p, indent, "vaddr=3D%p\n", shmem->vaddr);
> @@ -691,6 +719,7 @@ struct sg_table *drm_gem_shmem_get_sg_table(struct dr=
m_gem_shmem_object *shmem)
>  	struct drm_gem_object *obj =3D &shmem->base;
> =20
>  	drm_WARN_ON(obj->dev, obj->import_attach);
> +	drm_WARN_ON(obj->dev, shmem->sparse);
> =20
>  	return drm_prime_pages_to_sg(obj->dev, shmem->pages, obj->size >> PAGE_=
SHIFT);
>  }
> @@ -702,6 +731,9 @@ static struct sg_table *drm_gem_shmem_get_pages_sgt_l=
ocked(struct drm_gem_shmem_
>  	int ret;
>  	struct sg_table *sgt;
> =20
> +	if (drm_WARN_ON(obj->dev, shmem->sparse))
> +		return ERR_PTR(-EINVAL);
> +
>  	if (shmem->sgt)
>  		return shmem->sgt;
> =20
> @@ -787,7 +819,7 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device=
 *dev,
>  	size_t size =3D PAGE_ALIGN(attach->dmabuf->size);
>  	struct drm_gem_shmem_object *shmem;
> =20
> -	shmem =3D __drm_gem_shmem_create(dev, size, true, NULL);
> +	shmem =3D __drm_gem_shmem_create(dev, size, true, false, NULL);
>  	if (IS_ERR(shmem))
>  		return ERR_CAST(shmem);
> =20
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shm=
em_helper.h
> index d22e3fb53631..902039cfc4ce 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -6,6 +6,7 @@
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/mutex.h>
> +#include <linux/xarray.h>
> =20
>  #include <drm/drm_file.h>
>  #include <drm/drm_gem.h>
> @@ -29,7 +30,11 @@ struct drm_gem_shmem_object {
>  	/**
>  	 * @pages: Page table
>  	 */
> -	struct page **pages;
> +	union {
> +
> +		struct page **pages;
> +		struct xarray xapages;
> +	};
> =20
>  	/**
>  	 * @pages_use_count:
> @@ -91,6 +96,11 @@ struct drm_gem_shmem_object {
>  	 * @map_wc: map object write-combined (instead of using shmem defaults).
>  	 */
>  	bool map_wc : 1;
> +
> +	/**
> +	 * @sparse: the object's virtual memory space is only partially backed =
by pages

I would drop the "virtual memory space" part. sparse just means the
object might be partially backed by physical memory, and that memory
will be allocated on-demand (most likely on-GPU-demand, but there's
nothing preventing us from doing it on-CPU-demand, as long as the fault
handler knows the allocation granularity).

> +	 */
> +	bool sparse : 1;
>  };
> =20
>  #define to_drm_gem_shmem_obj(obj) \
> @@ -229,6 +239,9 @@ static inline int drm_gem_shmem_object_vmap(struct dr=
m_gem_object *obj,
>  {
>  	struct drm_gem_shmem_object *shmem =3D to_drm_gem_shmem_obj(obj);
> =20
> +	if (shmem->sparse)
> +		return -EACCES;
> +
>  	return drm_gem_shmem_vmap(shmem, map);

Do we need a WARN_ON() in drm_gem_shmem_vunmap()?

>  }
> =20
> @@ -263,6 +276,9 @@ static inline int drm_gem_shmem_object_mmap(struct dr=
m_gem_object *obj, struct v
>  {
>  	struct drm_gem_shmem_object *shmem =3D to_drm_gem_shmem_obj(obj);
> =20
> +	if (shmem->sparse)
> +		return -EACCES;
> +
>  	return drm_gem_shmem_mmap(shmem, vma);
>  }
> =20

I guess we also need to fail in drm_gem_shmem_get_sg_table() is this is
a sparse object.


