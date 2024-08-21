Return-Path: <linux-kernel+bounces-295395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0904A959A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80641F21CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D7E1CCEF0;
	Wed, 21 Aug 2024 11:18:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C0A19ABA9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239091; cv=none; b=DRUN+WSwUnlwjDh/x46q4jkffwHeKOTyAnxP5/bR1Fqm22Q1Qa9qjvLHlR1CJAhb4TWl17kUIomvy/QxtXZJV05+0uuFLpk5mV9xtQfyMAByEpwsUwnpCeEB6nSjO60YqmBCHsU9rwCc73mjRrnxpuSlHzGY9JakPsj6zML3cm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239091; c=relaxed/simple;
	bh=VCK6CBMI+8Go/sR6KG7kjD+agbdaBVZENpVfDu8DnA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNZfaGU83XNAL5pOpBG4cAea24y2eTOMLf5OdgdfYFrY5C7C9pb9eFYxnAv9zvp8exeKPv8E+ziUerR4tM1EKVqAB/8vM/JKgfXvYi9wHp9gBIr8T/z9Cm9z5sZEx4AhDabHwT3AYKpbiRNVkZKUDxyTIsbr3T+wHFg+qCWlV0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A5BADA7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 04:18:34 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DCD473F73B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 04:18:07 -0700 (PDT)
Date: Wed, 21 Aug 2024 12:17:53 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	kernel@collabora.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: flush FW AS caches in slow reset path
Message-ID: <ZsXM4asd99z98HYb@e110455-lin.cambridge.arm.com>
References: <20240816185250.344080-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240816185250.344080-1-adrian.larumbe@collabora.com>

On Fri, Aug 16, 2024 at 07:52:49PM +0100, Adrián Larumbe wrote:
> In the off-chance that waiting for the firmware to signal its booted status
> timed out in the fast reset path, one must flush the cache lines for the
> entire FW VM address space before reloading the regions, otherwise stale
> values eventually lead to a scheduler job timeout.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Looks good to me!

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c  |  8 +++++++-
>  drivers/gpu/drm/panthor/panthor_mmu.c | 19 ++++++++++++++++---
>  drivers/gpu/drm/panthor/panthor_mmu.h |  1 +
>  3 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 857f3f11258a..ef232c0c2049 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1089,6 +1089,12 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
>  		panthor_fw_stop(ptdev);
>  		ptdev->fw->fast_reset = false;
>  		drm_err(&ptdev->base, "FW fast reset failed, trying a slow reset");
> +
> +		ret = panthor_vm_flush_all(ptdev->fw->vm);
> +		if (ret) {
> +			drm_err(&ptdev->base, "FW slow reset failed (couldn't flush FW's AS l2cache)");
> +			return ret;
> +		}
>  	}
>  
>  	/* Reload all sections, including RO ones. We're not supposed
> @@ -1099,7 +1105,7 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
>  
>  	ret = panthor_fw_start(ptdev);
>  	if (ret) {
> -		drm_err(&ptdev->base, "FW slow reset failed");
> +		drm_err(&ptdev->base, "FW slow reset failed (couldn't start the FW )");
>  		return ret;
>  	}
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index d47972806d50..a77ee5ce691d 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -874,14 +874,27 @@ static int panthor_vm_flush_range(struct panthor_vm *vm, u64 iova, u64 size)
>  	if (!drm_dev_enter(&ptdev->base, &cookie))
>  		return 0;
>  
> -	/* Flush the PTs only if we're already awake */
> -	if (pm_runtime_active(ptdev->base.dev))
> -		ret = mmu_hw_do_operation(vm, iova, size, AS_COMMAND_FLUSH_PT);
> +	/*
> +	 * If we made it this far, that means the device is awake, because
> +	 * upon device suspension, all active VMs are given an AS id of -1
> +	 */
> +	ret = mmu_hw_do_operation(vm, iova, size, AS_COMMAND_FLUSH_PT);
>  
>  	drm_dev_exit(cookie);
>  	return ret;
>  }
>  
> +/**
> + * panthor_vm_flush_all() - Flush L2 caches for the entirety of a VM's AS
> + * @vm: VM whose cache to flush
> + *
> + * Return: 0 on success, a negative error code if flush failed.
> + */
> +int panthor_vm_flush_all(struct panthor_vm *vm)
> +{
> +	return panthor_vm_flush_range(vm, vm->base.mm_start, vm->base.mm_range);
> +}
> +
>  static int panthor_vm_unmap_pages(struct panthor_vm *vm, u64 iova, u64 size)
>  {
>  	struct panthor_device *ptdev = vm->ptdev;
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
> index f3c1ed19f973..6788771071e3 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.h
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.h
> @@ -31,6 +31,7 @@ panthor_vm_get_bo_for_va(struct panthor_vm *vm, u64 va, u64 *bo_offset);
>  int panthor_vm_active(struct panthor_vm *vm);
>  void panthor_vm_idle(struct panthor_vm *vm);
>  int panthor_vm_as(struct panthor_vm *vm);
> +int panthor_vm_flush_all(struct panthor_vm *vm);
>  
>  struct panthor_heap_pool *
>  panthor_vm_get_heap_pool(struct panthor_vm *vm, bool create);
> -- 
> 2.46.0
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

