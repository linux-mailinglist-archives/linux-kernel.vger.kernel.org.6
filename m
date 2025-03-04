Return-Path: <linux-kernel+bounces-543453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B957A4D5CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9BA188CD01
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B6A1F9423;
	Tue,  4 Mar 2025 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aYmC0ic0"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8EB1F8BDC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075709; cv=none; b=f+JaH4RAUy/RGnvhRY6HrdlamE7fu73vtMmv+ixP/t2aIzmfZrmQu7RUJ1N4r+YTx+FC27hSw46XsWG1UPwMFPOanlkSAUChGBGCKMZAAo0xgzRzj8S0f/WpAAdaSh5rXil1Icv27hZvd+cDmm7wM2KI7bjwZ6HaSXZTiwUTUow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075709; c=relaxed/simple;
	bh=TqwdvhkdF+IlPnumt9ZdEjwxTxBz79Zs40VYVW5s3PA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/HXx9J/NZK90uH/5Zeamhf+66c1GJD7tUiqYXfwlXh6GcRup3mhdSjo2vINQ/mHACAojGQvPUiSwqzdwt4eZKfrb4hxP+XSfSnsT2wJD/OZbVSZJcW6r4G6JvKSPL+cHzsr8sZibZON9umDRxU6K6LbglkhbpzqUtBy2uMGdTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aYmC0ic0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741075705;
	bh=TqwdvhkdF+IlPnumt9ZdEjwxTxBz79Zs40VYVW5s3PA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aYmC0ic0+2WmDaaF/H9WUdcDobxJwU29yWmdq8qOl23GYaXA6lgVhOKVTUy1O56A0
	 c4arQl1CjjabBvquEQc+WkupHYBpe7Ph+nAS+xvTtZ/8BWg1bBP4B9pVxk7BYT5Ysm
	 Kopg4LzERwGDiHhBFlxQEcIH8GKZwOhWGi4Uu6AxCZaVEVGLp6QyzR+KdVl6hmYfpg
	 cxq8QMQzYUQ+zUiH9MvieD1xY9Tg+Iy/GddlzOTQNaihltJcmsFuXGoF88FVN/vvCL
	 kI14orNlFp3873aUMrtt6A4IXzg8OYFxrU6VoaiOYSJqk0f+VOGpXHTdPLpt/SSKK7
	 LvAVb2wNOPA4g==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8CC3117E088C;
	Tue,  4 Mar 2025 09:08:24 +0100 (CET)
Date: Tue, 4 Mar 2025 09:08:19 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Mihail Atanassov
 <mihail.atanassov@arm.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] drm/panthor: Avoid sleep locking in the internal
 BO size path
Message-ID: <20250304090819.47b7ca7e@collabora.com>
In-Reply-To: <20250303190923.1639985-2-adrian.larumbe@collabora.com>
References: <20250303190923.1639985-1-adrian.larumbe@collabora.com>
	<20250303190923.1639985-2-adrian.larumbe@collabora.com>
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

On Mon,  3 Mar 2025 19:08:46 +0000
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Commit 434e5ca5b5d7 ("drm/panthor: Expose size of driver internal BO's ov=
er
> fdinfo") locks the VMS xarray, to avoid UAF errors when the same VM is
> being concurrently destroyed by another thread. However, that puts the
> current thread in atomic context, which means taking the VMS' heap locks
> will trigger a warning as the thread is no longer allowed to sleep.
>=20
> Because in this case replacing the heap mutex with a spinlock isn't
> feasible, the fdinfo handler no longer traverses the list of heaps for
> every single VM associated with an open DRM file. Instead, when a new heap
> chunk is allocated, its size is accumulated into a pool-wide tally, which
> also makes the atomic context code path somewhat faster.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> Fixes: 3e2c8c718567 ("drm/panthor: Expose size of driver internal BO's ov=
er fdinfo")

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_heap.c | 62 +++++++++++++-------------
>  drivers/gpu/drm/panthor/panthor_mmu.c  |  8 +---
>  2 files changed, 31 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/pan=
thor/panthor_heap.c
> index db0285ce5812..3bdf61c14264 100644
> --- a/drivers/gpu/drm/panthor/panthor_heap.c
> +++ b/drivers/gpu/drm/panthor/panthor_heap.c
> @@ -97,6 +97,9 @@ struct panthor_heap_pool {
> =20
>  	/** @gpu_contexts: Buffer object containing the GPU heap contexts. */
>  	struct panthor_kernel_bo *gpu_contexts;
> +
> +	/** @size: Size of all chunks across all heaps in the pool. */
> +	atomic_t size;
>  };
> =20
>  static int panthor_heap_ctx_stride(struct panthor_device *ptdev)
> @@ -118,7 +121,7 @@ static void *panthor_get_heap_ctx(struct panthor_heap=
_pool *pool, int id)
>  	       panthor_get_heap_ctx_offset(pool, id);
>  }
> =20
> -static void panthor_free_heap_chunk(struct panthor_vm *vm,
> +static void panthor_free_heap_chunk(struct panthor_heap_pool *pool,
>  				    struct panthor_heap *heap,
>  				    struct panthor_heap_chunk *chunk)
>  {
> @@ -127,12 +130,13 @@ static void panthor_free_heap_chunk(struct panthor_=
vm *vm,
>  	heap->chunk_count--;
>  	mutex_unlock(&heap->lock);
> =20
> +	atomic_sub(heap->chunk_size, &pool->size);
> +
>  	panthor_kernel_bo_destroy(chunk->bo);
>  	kfree(chunk);
>  }
> =20
> -static int panthor_alloc_heap_chunk(struct panthor_device *ptdev,
> -				    struct panthor_vm *vm,
> +static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
>  				    struct panthor_heap *heap,
>  				    bool initial_chunk)
>  {
> @@ -144,7 +148,7 @@ static int panthor_alloc_heap_chunk(struct panthor_de=
vice *ptdev,
>  	if (!chunk)
>  		return -ENOMEM;
> =20
> -	chunk->bo =3D panthor_kernel_bo_create(ptdev, vm, heap->chunk_size,
> +	chunk->bo =3D panthor_kernel_bo_create(pool->ptdev, pool->vm, heap->chu=
nk_size,
>  					     DRM_PANTHOR_BO_NO_MMAP,
>  					     DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC,
>  					     PANTHOR_VM_KERNEL_AUTO_VA);
> @@ -180,6 +184,8 @@ static int panthor_alloc_heap_chunk(struct panthor_de=
vice *ptdev,
>  	heap->chunk_count++;
>  	mutex_unlock(&heap->lock);
> =20
> +	atomic_add(heap->chunk_size, &pool->size);
> +
>  	return 0;
> =20
>  err_destroy_bo:
> @@ -191,17 +197,16 @@ static int panthor_alloc_heap_chunk(struct panthor_=
device *ptdev,
>  	return ret;
>  }
> =20
> -static void panthor_free_heap_chunks(struct panthor_vm *vm,
> +static void panthor_free_heap_chunks(struct panthor_heap_pool *pool,
>  				     struct panthor_heap *heap)
>  {
>  	struct panthor_heap_chunk *chunk, *tmp;
> =20
>  	list_for_each_entry_safe(chunk, tmp, &heap->chunks, node)
> -		panthor_free_heap_chunk(vm, heap, chunk);
> +		panthor_free_heap_chunk(pool, heap, chunk);
>  }
> =20
> -static int panthor_alloc_heap_chunks(struct panthor_device *ptdev,
> -				     struct panthor_vm *vm,
> +static int panthor_alloc_heap_chunks(struct panthor_heap_pool *pool,
>  				     struct panthor_heap *heap,
>  				     u32 chunk_count)
>  {
> @@ -209,7 +214,7 @@ static int panthor_alloc_heap_chunks(struct panthor_d=
evice *ptdev,
>  	u32 i;
> =20
>  	for (i =3D 0; i < chunk_count; i++) {
> -		ret =3D panthor_alloc_heap_chunk(ptdev, vm, heap, true);
> +		ret =3D panthor_alloc_heap_chunk(pool, heap, true);
>  		if (ret)
>  			return ret;
>  	}
> @@ -226,7 +231,7 @@ panthor_heap_destroy_locked(struct panthor_heap_pool =
*pool, u32 handle)
>  	if (!heap)
>  		return -EINVAL;
> =20
> -	panthor_free_heap_chunks(pool->vm, heap);
> +	panthor_free_heap_chunks(pool, heap);
>  	mutex_destroy(&heap->lock);
>  	kfree(heap);
>  	return 0;
> @@ -308,8 +313,7 @@ int panthor_heap_create(struct panthor_heap_pool *poo=
l,
>  	heap->max_chunks =3D max_chunks;
>  	heap->target_in_flight =3D target_in_flight;
> =20
> -	ret =3D panthor_alloc_heap_chunks(pool->ptdev, vm, heap,
> -					initial_chunk_count);
> +	ret =3D panthor_alloc_heap_chunks(pool, heap, initial_chunk_count);
>  	if (ret)
>  		goto err_free_heap;
> =20
> @@ -342,7 +346,7 @@ int panthor_heap_create(struct panthor_heap_pool *poo=
l,
>  	return id;
> =20
>  err_free_heap:
> -	panthor_free_heap_chunks(pool->vm, heap);
> +	panthor_free_heap_chunks(pool, heap);
>  	mutex_destroy(&heap->lock);
>  	kfree(heap);
> =20
> @@ -389,6 +393,7 @@ int panthor_heap_return_chunk(struct panthor_heap_poo=
l *pool,
>  			removed =3D chunk;
>  			list_del(&chunk->node);
>  			heap->chunk_count--;
> +			atomic_sub(heap->chunk_size, &pool->size);
>  			break;
>  		}
>  	}
> @@ -466,7 +471,7 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
>  	 * further jobs in this queue fail immediately instead of having to
>  	 * wait for the job timeout.
>  	 */
> -	ret =3D panthor_alloc_heap_chunk(pool->ptdev, pool->vm, heap, false);
> +	ret =3D panthor_alloc_heap_chunk(pool, heap, false);
>  	if (ret)
>  		goto out_unlock;
> =20
> @@ -560,6 +565,8 @@ panthor_heap_pool_create(struct panthor_device *ptdev=
, struct panthor_vm *vm)
>  	if (ret)
>  		goto err_destroy_pool;
> =20
> +	atomic_add(pool->gpu_contexts->obj->size, &pool->size);
> +
>  	return pool;
> =20
>  err_destroy_pool:
> @@ -594,8 +601,10 @@ void panthor_heap_pool_destroy(struct panthor_heap_p=
ool *pool)
>  	xa_for_each(&pool->xa, i, heap)
>  		drm_WARN_ON(&pool->ptdev->base, panthor_heap_destroy_locked(pool, i));
> =20
> -	if (!IS_ERR_OR_NULL(pool->gpu_contexts))
> +	if (!IS_ERR_OR_NULL(pool->gpu_contexts)) {
> +		atomic_sub(pool->gpu_contexts->obj->size, &pool->size);
>  		panthor_kernel_bo_destroy(pool->gpu_contexts);
> +	}
> =20
>  	/* Reflects the fact the pool has been destroyed. */
>  	pool->vm =3D NULL;
> @@ -605,27 +614,16 @@ void panthor_heap_pool_destroy(struct panthor_heap_=
pool *pool)
>  }
> =20
>  /**
> - * panthor_heap_pool_size() - Calculate size of all chunks across all he=
aps in a pool
> - * @pool: Pool whose total chunk size to calculate.
> + * panthor_heap_pool_size() - Get a heap pool's total size
> + * @pool: Pool whose total chunks size to return
>   *
> - * This function adds the size of all heap chunks across all heaps in the
> - * argument pool. It also adds the size of the gpu contexts kernel bo.
> - * It is meant to be used by fdinfo for displaying the size of internal
> - * driver BO's that aren't exposed to userspace through a GEM handle.
> + * Returns the aggregated size of all chunks for all heaps in the pool
>   *
>   */
>  size_t panthor_heap_pool_size(struct panthor_heap_pool *pool)
>  {
> -	struct panthor_heap *heap;
> -	unsigned long i;
> -	size_t size =3D 0;
> -
> -	down_read(&pool->lock);
> -	xa_for_each(&pool->xa, i, heap)
> -		size +=3D heap->chunk_size * heap->chunk_count;
> -	up_read(&pool->lock);
> -
> -	size +=3D pool->gpu_contexts->obj->size;
> +	if (!pool)
> +		return 0;
> =20
> -	return size;
> +	return atomic_read(&pool->size);
>  }
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 8c6fc587ddc3..12a02e28f50f 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1963,13 +1963,7 @@ void panthor_vm_heaps_sizes(struct panthor_file *p=
file, struct drm_memory_stats
> =20
>  	xa_lock(&pfile->vms->xa);
>  	xa_for_each(&pfile->vms->xa, i, vm) {
> -		size_t size =3D 0;
> -
> -		mutex_lock(&vm->heaps.lock);
> -		if (vm->heaps.pool)
> -			size =3D panthor_heap_pool_size(vm->heaps.pool);
> -		mutex_unlock(&vm->heaps.lock);
> -
> +		size_t size =3D panthor_heap_pool_size(vm->heaps.pool);
>  		stats->resident +=3D size;
>  		if (vm->as.id >=3D 0)
>  			stats->active +=3D size;


