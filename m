Return-Path: <linux-kernel+bounces-447495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B949F3361
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FF51631A9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685CC205E11;
	Mon, 16 Dec 2024 14:41:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F99717BA2
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360090; cv=none; b=n5BtCUcgzjI3R2+tUf1/iha21HGhe5kyJJ9hy3rs+n3dNbe0uLnPdfA7fAgxBBkeu6qxZF/sfUsRZqRZ98Vea2r1lO5vhhz94Fb6kfil0eCchyKqZbF3JzJ9+tPfW1xqE9p6891OcanEpYXDot1g04W8iYhPH7LDm5kG+ZXJGx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360090; c=relaxed/simple;
	bh=deHX/WGOgtCTH00xAl5YgWkilBCgZ1TkKI+P+y7Yk9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBY+gxx0Um4NaBFilhdEGx7b0DYjSnH9X9HPTYHSkEhS6+TyY7e9p4YwPCgKnKlpwLvYFnkSNmnyq94Ey1jS09WZBNLw5ptMWcd3gL/TuVYWF2vQJkZGvSW24HNE7l0u4S9EKB3U0Q1WJPS0GsWlOWrmaphPJpoo2SXOtFT5EN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB41B113E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:41:55 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 88C183F58B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:41:27 -0800 (PST)
Date: Mon, 16 Dec 2024 14:41:16 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	kernel@collabora.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] drm/panthor: Expose size of driver internal BO's
 over fdinfo
Message-ID: <Z2A8DEIPSZY8kKG8@e110455-lin.cambridge.arm.com>
References: <20241211163436.381069-1-adrian.larumbe@collabora.com>
 <20241211163436.381069-2-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211163436.381069-2-adrian.larumbe@collabora.com>

On Wed, Dec 11, 2024 at 04:34:31PM +0000, Adrián Larumbe wrote:
> This will display the sizes of kenrel BO's bound to an open file, which are
> otherwise not exposed to UM through a handle.
> 
> The sizes recorded are as follows:
>  - Per group: suspend buffer, protm-suspend buffer, syncobjcs
>  - Per queue: ringbuffer, profiling slots, firmware interface
>  - For all heaps in all heap pools across all VM's bound to an open file,
>  record size of all heap chuks, and for each pool the gpu_context BO too.
> 
> This does not record the size of FW regions, as these aren't bound to a
> specific open file and remain active through the whole life of the driver.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

With the issue that Boris pointed fixed,

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_drv.c   | 12 ++++++
>  drivers/gpu/drm/panthor/panthor_heap.c  | 26 +++++++++++++
>  drivers/gpu/drm/panthor/panthor_heap.h  |  2 +
>  drivers/gpu/drm/panthor/panthor_mmu.c   | 35 +++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_mmu.h   |  4 ++
>  drivers/gpu/drm/panthor/panthor_sched.c | 52 ++++++++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_sched.h |  4 ++
>  7 files changed, 134 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index ac7e53f6e3f0..8e27d0429019 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1457,12 +1457,24 @@ static void panthor_gpu_show_fdinfo(struct panthor_device *ptdev,
>  	drm_printf(p, "drm-curfreq-panthor:\t%lu Hz\n", ptdev->current_frequency);
>  }
>  
> +static void panthor_show_internal_memory_stats(struct drm_printer *p, struct drm_file *file)
> +{
> +	struct panthor_file *pfile = file->driver_priv;
> +	struct drm_memory_stats status = {0};
> +
> +	panthor_group_kbo_sizes(pfile, &status);
> +	panthor_vm_heaps_sizes(pfile, &status);
> +
> +	drm_print_memory_stats(p, &status, DRM_GEM_OBJECT_RESIDENT, "internal");
> +}
> +
>  static void panthor_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>  {
>  	struct drm_device *dev = file->minor->dev;
>  	struct panthor_device *ptdev = container_of(dev, struct panthor_device, base);
>  
>  	panthor_gpu_show_fdinfo(ptdev, file->driver_priv, p);
> +	panthor_show_internal_memory_stats(p, file);
>  
>  	drm_show_memory_stats(p, file);
>  }
> diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
> index 3796a9eb22af..e4464c5e93ef 100644
> --- a/drivers/gpu/drm/panthor/panthor_heap.c
> +++ b/drivers/gpu/drm/panthor/panthor_heap.c
> @@ -603,3 +603,29 @@ void panthor_heap_pool_destroy(struct panthor_heap_pool *pool)
>  
>  	panthor_heap_pool_put(pool);
>  }
> +
> +/**
> + * panthor_heap_pool_size() - Calculate size of all chunks across all heaps in a pool
> + * @pool: Pool whose total chunk size to calculate.
> + *
> + * This function adds the size of all heap chunks across all heaps in the
> + * argument pool. It also adds the size of the gpu contexts kernel bo.
> + * It is meant to be used by fdinfo for displaying the size of internal
> + * driver BO's that aren't exposed to userspace through a GEM handle.
> + *
> + */
> +size_t panthor_heap_pool_size(struct panthor_heap_pool *pool)
> +{
> +	struct panthor_heap *heap;
> +	unsigned long i;
> +	size_t size = 0;
> +
> +	down_write(&pool->lock);
> +	xa_for_each(&pool->xa, i, heap)
> +		size += heap->chunk_size * heap->chunk_count;
> +	up_write(&pool->lock);
> +
> +	size += pool->gpu_contexts->obj->size;
> +
> +	return size;
> +}
> diff --git a/drivers/gpu/drm/panthor/panthor_heap.h b/drivers/gpu/drm/panthor/panthor_heap.h
> index 25a5f2bba445..e3358d4e8edb 100644
> --- a/drivers/gpu/drm/panthor/panthor_heap.h
> +++ b/drivers/gpu/drm/panthor/panthor_heap.h
> @@ -27,6 +27,8 @@ struct panthor_heap_pool *
>  panthor_heap_pool_get(struct panthor_heap_pool *pool);
>  void panthor_heap_pool_put(struct panthor_heap_pool *pool);
>  
> +size_t panthor_heap_pool_size(struct panthor_heap_pool *pool);
> +
>  int panthor_heap_grow(struct panthor_heap_pool *pool,
>  		      u64 heap_gpu_va,
>  		      u32 renderpasses_in_flight,
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index c3f0b0225cf9..72387c95d103 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1941,6 +1941,41 @@ struct panthor_heap_pool *panthor_vm_get_heap_pool(struct panthor_vm *vm, bool c
>  	return pool;
>  }
>  
> +/**
> + * panthor_vm_heaps_size() - Calculate size of all heap chunks across all
> + * heaps over all the heap pools in a VM
> + * @pfile: File.
> + * @status: Memory status to be updated.
> + *
> + * Calculate all heap chunk sizes in all heap pools bound to a VM. If the VM
> + * is active, record the size as active as well.
> + */
> +void panthor_vm_heaps_sizes(struct panthor_file *pfile, struct drm_memory_stats *status)
> +{
> +	struct panthor_vm *vm;
> +	unsigned long i;
> +
> +	if (!pfile->vms)
> +		return;
> +
> +	xa_for_each(&pfile->vms->xa, i, vm) {
> +		size_t size;
> +
> +		mutex_lock(&vm->heaps.lock);
> +		if (!vm->heaps.pool) {
> +			mutex_unlock(&vm->heaps.lock);
> +			continue;
> +		}
> +		size = panthor_heap_pool_size(vm->heaps.pool);
> +		mutex_unlock(&vm->heaps.lock);
> +
> +		status->resident += size;
> +		status->private += size;
> +		if (vm->as.id >= 0)
> +			status->active += size;
> +	}
> +}
> +
>  static u64 mair_to_memattr(u64 mair, bool coherent)
>  {
>  	u64 memattr = 0;
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
> index 8d21e83d8aba..2aeb2522cdfa 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.h
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.h
> @@ -5,10 +5,12 @@
>  #ifndef __PANTHOR_MMU_H__
>  #define __PANTHOR_MMU_H__
>  
> +#include <linux/types.h>
>  #include <linux/dma-resv.h>
>  
>  struct drm_exec;
>  struct drm_sched_job;
> +struct drm_memory_stats;
>  struct panthor_gem_object;
>  struct panthor_heap_pool;
>  struct panthor_vm;
> @@ -37,6 +39,8 @@ int panthor_vm_flush_all(struct panthor_vm *vm);
>  struct panthor_heap_pool *
>  panthor_vm_get_heap_pool(struct panthor_vm *vm, bool create);
>  
> +void panthor_vm_heaps_sizes(struct panthor_file *pfile, struct drm_memory_stats *status);
> +
>  struct panthor_vm *panthor_vm_get(struct panthor_vm *vm);
>  void panthor_vm_put(struct panthor_vm *vm);
>  struct panthor_vm *panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index ef4bec7ff9c7..93497dadf085 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -618,7 +618,7 @@ struct panthor_group {
>  	 */
>  	struct panthor_kernel_bo *syncobjs;
>  
> -	/** @fdinfo: Per-file total cycle and timestamp values reference. */
> +	/** @fdinfo: Per-group total cycle and timestamp values and kernel BO sizes. */
>  	struct {
>  		/** @data: Total sampled values for jobs in queues from this group. */
>  		struct panthor_gpu_usage data;
> @@ -628,6 +628,9 @@ struct panthor_group {
>  		 * and job post-completion processing function
>  		 */
>  		struct mutex lock;
> +
> +		/** @bo_sizes: Aggregate size of private kernel BO's held by the group. */
> +		size_t kbo_sizes;
>  	} fdinfo;
>  
>  	/** @state: Group state. */
> @@ -3365,6 +3368,29 @@ group_create_queue(struct panthor_group *group,
>  	return ERR_PTR(ret);
>  }
>  
> +static void add_group_kbo_sizes(struct panthor_device *ptdev,
> +				struct panthor_group *group)
> +{
> +	struct panthor_queue *queue;
> +	int i;
> +
> +	if (drm_WARN_ON(&ptdev->base, IS_ERR_OR_NULL(group)))
> +		return;
> +	if (drm_WARN_ON(&ptdev->base, ptdev != group->ptdev))
> +		return;
> +
> +	group->fdinfo.kbo_sizes += group->suspend_buf->obj->size;
> +	group->fdinfo.kbo_sizes += group->protm_suspend_buf->obj->size;
> +	group->fdinfo.kbo_sizes += group->syncobjs->obj->size;
> +
> +	for (i = 0; i < group->queue_count; i++) {
> +		queue =	group->queues[i];
> +		group->fdinfo.kbo_sizes += queue->ringbuf->obj->size;
> +		group->fdinfo.kbo_sizes += queue->iface.mem->obj->size;
> +		group->fdinfo.kbo_sizes += queue->profiling.slots->obj->size;
> +	}
> +}
> +
>  #define MAX_GROUPS_PER_POOL		128
>  
>  int panthor_group_create(struct panthor_file *pfile,
> @@ -3489,6 +3515,7 @@ int panthor_group_create(struct panthor_file *pfile,
>  	}
>  	mutex_unlock(&sched->reset.lock);
>  
> +	add_group_kbo_sizes(group->ptdev, group);
>  	mutex_init(&group->fdinfo.lock);
>  
>  	return gid;
> @@ -3606,6 +3633,29 @@ void panthor_group_pool_destroy(struct panthor_file *pfile)
>  	pfile->groups = NULL;
>  }
>  
> +/**
> + * panthor_group_kbo_sizes() - Retrieve aggregate size of all private kernel BO's
> + * belonging to all the groups owned by an open Panthor file
> + * @pfile: File.
> + * @status: Memory status to be updated.
> + *
> + */
> +void panthor_group_kbo_sizes(struct panthor_file *pfile, struct drm_memory_stats *status)
> +{
> +	struct panthor_group_pool *gpool = pfile->groups;
> +	struct panthor_group *group;
> +	unsigned long i;
> +
> +	if (IS_ERR_OR_NULL(gpool))
> +		return;
> +	xa_for_each(&gpool->xa, i, group) {
> +		status->resident += group->fdinfo.kbo_sizes;
> +		status->private += group->fdinfo.kbo_sizes;
> +		if (group->csg_id >= 0)
> +			status->active += group->fdinfo.kbo_sizes;
> +	}
> +}
> +
>  static void job_release(struct kref *ref)
>  {
>  	struct panthor_job *job = container_of(ref, struct panthor_job, refcount);
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
> index 5ae6b4bde7c5..4dd6a7fc8fbd 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.h
> +++ b/drivers/gpu/drm/panthor/panthor_sched.h
> @@ -4,11 +4,14 @@
>  #ifndef __PANTHOR_SCHED_H__
>  #define __PANTHOR_SCHED_H__
>  
> +#include <linux/types.h>
> +
>  struct drm_exec;
>  struct dma_fence;
>  struct drm_file;
>  struct drm_gem_object;
>  struct drm_sched_job;
> +struct drm_memory_stats;
>  struct drm_panthor_group_create;
>  struct drm_panthor_queue_create;
>  struct drm_panthor_group_get_state;
> @@ -36,6 +39,7 @@ void panthor_job_update_resvs(struct drm_exec *exec, struct drm_sched_job *job);
>  
>  int panthor_group_pool_create(struct panthor_file *pfile);
>  void panthor_group_pool_destroy(struct panthor_file *pfile);
> +void panthor_group_kbo_sizes(struct panthor_file *pfile, struct drm_memory_stats *status);
>  
>  int panthor_sched_init(struct panthor_device *ptdev);
>  void panthor_sched_unplug(struct panthor_device *ptdev);
> -- 
> 2.47.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

