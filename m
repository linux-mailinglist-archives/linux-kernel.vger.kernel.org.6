Return-Path: <linux-kernel+bounces-528949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE8EA41E50
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713B61887F68
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BF0B666;
	Mon, 24 Feb 2025 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="a19wWjJT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D423125E45F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397894; cv=none; b=FipSEHnsMuIcsbUOyG1oRWYUWVEcMNCN7GE06aIF0lC4i4lbHnp1DSeP9icmc2iqEr/CykHEB74nzH2MMALvluGI4hUeauahIR80Vxn9uetFNfinTaEg8wuElI0HhkIiSd2arcWOdVf/STyHxCKFtfeIAqaZxHxjK99gnPxQR/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397894; c=relaxed/simple;
	bh=DEB+SMivXXKdttMI0HIj4UzZBSfctVingpXmJjWYPbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+9IGjG49HFrrYmsjpQcj4anuegMN4fztQ7Tf2AHW/7qpAe1GxnvyXPntuUiLPSfRbMyGmPc6sTw6J1Pcr4XaVGSeXQ458VL1ewka2izvJs/YL2FmZOKXcEL/F2QdmIVcDQSmqRFOfgPZkVuM0eSv3SbZ8JP1Rvr50kTHnbSyH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=a19wWjJT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740397890;
	bh=DEB+SMivXXKdttMI0HIj4UzZBSfctVingpXmJjWYPbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a19wWjJTIdrUI1w/E9NlR5Zwn9/2T1WkvKsDDms833Rlvearb30SSwORC0D/0WoMQ
	 I9GTYJ94HLVE3Cgy0/sF+lGuEp85SsIWDXsBwzpwFBBi7y8/cPV+wfhk0RmYDucuYq
	 9yKcvzWdO2MRKhmv/uqbZznaDSVxFze0qrIhAYor72HnKPGG6EFrU2wJLGhXNu+8d3
	 RLu5hxRiM9rLzEysXDv4gsKwQtuu0hRNdEzE8vT/Gwu9/y8k5iDjctV3CQb+eUfXdf
	 s3g/rHhYMbsDYlkhV+Sg92FTj++WEsjUCgNM0WDImL/uWlyE8O56mCGNYO2lkL1wLi
	 JvInyWNZnoPZw==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8A8E617E00FC;
	Mon, 24 Feb 2025 12:51:29 +0100 (CET)
Date: Mon, 24 Feb 2025 12:51:24 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Mihail Atanassov
 <mihail.atanassov@arm.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/panthor: Avoid sleep locking in the internal
 BO size path
Message-ID: <20250224125124.34dc1e7a@collabora.com>
In-Reply-To: <22tktof6433nshmhihwjpvvgnwpos3v4mkggxqikxbta5p4s57@w2gzdqudhbfi>
References: <20250214210009.1994543-1-adrian.larumbe@collabora.com>
	<20250214210009.1994543-2-adrian.larumbe@collabora.com>
	<20250215104438.13220f14@collabora.com>
	<22tktof6433nshmhihwjpvvgnwpos3v4mkggxqikxbta5p4s57@w2gzdqudhbfi>
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

Hi Adrian,

On Thu, 20 Feb 2025 20:26:23 +0000
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Hi Boris,
>=20
> On 15.02.2025 10:44, Boris Brezillon wrote:
> > On Fri, 14 Feb 2025 20:55:21 +0000
> > Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:
> > =20
> > > Commit 434e5ca5b5d7 ("drm/panthor: Expose size of driver internal BO'=
s over
> > > fdinfo") locks the VMS xarray, to avoid UAF errors when the same VM is
> > > being concurrently destroyed by another thread. However, that puts the
> > > current thread in atomic context, which means taking the VMS' heap lo=
cks
> > > will trigger a warning as the thread is no longer allowed to sleep.
> > >
> > > Because in this case replacing the heap mutex with a spinlock isn't
> > > feasible, the fdinfo handler no longer traverses the list of heaps for
> > > every single VM associated with an open DRM file. Instead, when a new=
 heap
> > > chunk is allocated, its size is accumulated into a VM-wide tally, whi=
ch
> > > also makes the atomic context code path somewhat faster.
> > >
> > > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> > > Fixes: 3e2c8c718567 ("drm/panthor: Expose size of driver internal BO'=
s over fdinfo")
> > > ---
> > >  drivers/gpu/drm/panthor/panthor_heap.c | 38 ++++++++----------------=
--
> > >  drivers/gpu/drm/panthor/panthor_heap.h |  2 --
> > >  drivers/gpu/drm/panthor/panthor_mmu.c  | 23 +++++++++++-----
> > >  drivers/gpu/drm/panthor/panthor_mmu.h  |  1 +
> > >  4 files changed, 28 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm=
/panthor/panthor_heap.c
> > > index db0285ce5812..e5e5953e4f87 100644
> > > --- a/drivers/gpu/drm/panthor/panthor_heap.c
> > > +++ b/drivers/gpu/drm/panthor/panthor_heap.c
> > > @@ -127,6 +127,8 @@ static void panthor_free_heap_chunk(struct pantho=
r_vm *vm,
> > >  	heap->chunk_count--;
> > >  	mutex_unlock(&heap->lock);
> > >
> > > +	panthor_vm_heaps_size_accumulate(vm, -heap->chunk_size);
> > > +
> > >  	panthor_kernel_bo_destroy(chunk->bo);
> > >  	kfree(chunk);
> > >  }
> > > @@ -180,6 +182,8 @@ static int panthor_alloc_heap_chunk(struct pantho=
r_device *ptdev,
> > >  	heap->chunk_count++;
> > >  	mutex_unlock(&heap->lock);
> > >
> > > +	panthor_vm_heaps_size_accumulate(vm, heap->chunk_size);
> > > +
> > >  	return 0;
> > >
> > >  err_destroy_bo:
> > > @@ -389,6 +393,7 @@ int panthor_heap_return_chunk(struct panthor_heap=
_pool *pool,
> > >  			removed =3D chunk;
> > >  			list_del(&chunk->node);
> > >  			heap->chunk_count--;
> > > +			panthor_vm_heaps_size_accumulate(chunk->bo->vm, -heap->chunk_size=
);
> > >  			break;
> > >  		}
> > >  	}
> > > @@ -560,6 +565,8 @@ panthor_heap_pool_create(struct panthor_device *p=
tdev, struct panthor_vm *vm)
> > >  	if (ret)
> > >  		goto err_destroy_pool;
> > >
> > > +	panthor_vm_heaps_size_accumulate(vm, pool->gpu_contexts->obj->size);
> > > +
> > >  	return pool;
> > >
> > >  err_destroy_pool:
> > > @@ -594,8 +601,11 @@ void panthor_heap_pool_destroy(struct panthor_he=
ap_pool *pool)
> > >  	xa_for_each(&pool->xa, i, heap)
> > >  		drm_WARN_ON(&pool->ptdev->base, panthor_heap_destroy_locked(pool, =
i));
> > >
> > > -	if (!IS_ERR_OR_NULL(pool->gpu_contexts))
> > > +	if (!IS_ERR_OR_NULL(pool->gpu_contexts)) {
> > > +		panthor_vm_heaps_size_accumulate(pool->gpu_contexts->vm,
> > > +					    -pool->gpu_contexts->obj->size);
> > >  		panthor_kernel_bo_destroy(pool->gpu_contexts);
> > > +	}
> > >
> > >  	/* Reflects the fact the pool has been destroyed. */
> > >  	pool->vm =3D NULL;
> > > @@ -603,29 +613,3 @@ void panthor_heap_pool_destroy(struct panthor_he=
ap_pool *pool)
> > >
> > >  	panthor_heap_pool_put(pool);
> > >  }
> > > -
> > > -/**
> > > - * panthor_heap_pool_size() - Calculate size of all chunks across al=
l heaps in a pool
> > > - * @pool: Pool whose total chunk size to calculate.
> > > - *
> > > - * This function adds the size of all heap chunks across all heaps i=
n the
> > > - * argument pool. It also adds the size of the gpu contexts kernel b=
o.
> > > - * It is meant to be used by fdinfo for displaying the size of inter=
nal
> > > - * driver BO's that aren't exposed to userspace through a GEM handle.
> > > - *
> > > - */
> > > -size_t panthor_heap_pool_size(struct panthor_heap_pool *pool)
> > > -{
> > > -	struct panthor_heap *heap;
> > > -	unsigned long i;
> > > -	size_t size =3D 0;
> > > -
> > > -	down_read(&pool->lock);
> > > -	xa_for_each(&pool->xa, i, heap)
> > > -		size +=3D heap->chunk_size * heap->chunk_count;
> > > -	up_read(&pool->lock);
> > > -
> > > -	size +=3D pool->gpu_contexts->obj->size;
> > > -
> > > -	return size;
> > > -}
> > > diff --git a/drivers/gpu/drm/panthor/panthor_heap.h b/drivers/gpu/drm=
/panthor/panthor_heap.h
> > > index e3358d4e8edb..25a5f2bba445 100644
> > > --- a/drivers/gpu/drm/panthor/panthor_heap.h
> > > +++ b/drivers/gpu/drm/panthor/panthor_heap.h
> > > @@ -27,8 +27,6 @@ struct panthor_heap_pool *
> > >  panthor_heap_pool_get(struct panthor_heap_pool *pool);
> > >  void panthor_heap_pool_put(struct panthor_heap_pool *pool);
> > >
> > > -size_t panthor_heap_pool_size(struct panthor_heap_pool *pool);
> > > -
> > >  int panthor_heap_grow(struct panthor_heap_pool *pool,
> > >  		      u64 heap_gpu_va,
> > >  		      u32 renderpasses_in_flight,
> > > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/=
panthor/panthor_mmu.c
> > > index 8c6fc587ddc3..9e48b34fcf80 100644
> > > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > > @@ -347,6 +347,14 @@ struct panthor_vm {
> > >  		struct mutex lock;
> > >  	} heaps;
> > >
> > > +	/**
> > > +	 * @fdinfo: VM-wide fdinfo fields.
> > > +	 */
> > > +	struct {
> > > +		/** @fdinfo.heaps_size: Size of all chunks across all heaps in the=
 pool. */
> > > +		atomic_t heaps_size;
> > > +	} fdinfo; =20
> >
> > Feels more like a panthor_heap_pool field to me. If you do that,
> > you can keep the panthor_heap_pool_size() helper. =20
>=20
> The only downside of storing a per-heap-pool fdinfo size for its chunks s=
ize total is that we'll
> have to traverse all the heap pools owned by a VM any time the fdinfo han=
dler for an open
> DRM file is invoked. That means spending a longer time with the vms xarra=
y lock taken.

There's only one heap pool per VM though, and once the pool is created
it can't go away, so you don't even have to take the lock to deref the
panthor_vm::heaps::pool object, you just need a NULL check.

> > >
> > > +void panthor_vm_heaps_size_accumulate(struct panthor_vm *vm, ssize_t=
 acc)
> > > +{
> > > +	atomic_add(acc, &vm->fdinfo.heaps_size);
> > > +} =20
> >
> > Calling atomic_add() directly would probably be shorter, and I prefer
> > the idea of calling atomic_sub(size) instead of atomic_add(-size), so
> > how about we drop this helper and use atomic_add/sub() directly? =20
>=20
> I had to add this VM interface function because the VM struct fields are =
kept hidden from
> other compilation units, as struct panthor_vm is defined inside panthor_m=
mu.c. I agree
> using atomic_sub() would be clearer, but that would imply exporting yet a=
nother panthor_mmu
> symbol, and atomic_add() can take signed values anyway.

If you move the "heaps_size" field to panthor_heap_pool (which I would
rename "size" when moving it to panthor_heap::fdinfo BTW), you no longer
have this problem, because all users of this field exist in
panthor_heap.c only.

Regards,

Boris

