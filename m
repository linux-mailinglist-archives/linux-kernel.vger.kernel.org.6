Return-Path: <linux-kernel+bounces-307153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F72964947
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B14E1F23137
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABAB1B1411;
	Thu, 29 Aug 2024 14:57:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67A019306A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943455; cv=none; b=dLVmOZgqPK1c9vj6stohnUxKi3y9tA5zlYteP0qbcS3Z8/yxNMiwf0IbhhvRYRuPMZaY69lptNr+fuGtdOS7XDYOP6ukefrk+LtXNzqBbJAngXmbRkhbokO3IhIAfTviqzEB+biosDR1x5A+QdPXj/0B8rg9gTQHBCZvf4yiuFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943455; c=relaxed/simple;
	bh=itDRsPCZmnBSiq95LvMWzpQhmvQqcCOF7OKWG03AKoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ih+Ka8KhzXszWh+m2FO2EXAl1muVlsaThXLrLQnbEjonBKWvYE1dksM66eHJzCC5t50wcAlZlvRQGqLmqQ8EELUraIrv1XS5NV8mbZ4Kok+bW0ma+GFJxz0ZMbU2YmrQ4hU8grE9BtO5SMU2azWpQEQUebit1BFv00632Yaj/kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6844BDA7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:57:59 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E73E73F66E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:57:32 -0700 (PDT)
Date: Thu, 29 Aug 2024 15:57:22 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	kernel@collabora.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: flush FW AS caches in slow reset path
Message-ID: <ZtCMUg-PoOUH98Ub@e110455-lin.cambridge.arm.com>
References: <20240816185250.344080-1-adrian.larumbe@collabora.com>
 <20240817111017.2a010061@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240817111017.2a010061@collabora.com>

Hi Adrián,

On Sat, Aug 17, 2024 at 11:10:17AM +0200, Boris Brezillon wrote:
> On Fri, 16 Aug 2024 19:52:49 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > In the off-chance that waiting for the firmware to signal its booted status
> > timed out in the fast reset path, one must flush the cache lines for the
> > entire FW VM address space before reloading the regions, otherwise stale
> > values eventually lead to a scheduler job timeout.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> 
> We probably want Fixes/Cc-stable tags here.
> 
> > ---
> >  drivers/gpu/drm/panthor/panthor_fw.c  |  8 +++++++-
> >  drivers/gpu/drm/panthor/panthor_mmu.c | 19 ++++++++++++++++---
> >  drivers/gpu/drm/panthor/panthor_mmu.h |  1 +
> >  3 files changed, 24 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> > index 857f3f11258a..ef232c0c2049 100644
> > --- a/drivers/gpu/drm/panthor/panthor_fw.c
> > +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> > @@ -1089,6 +1089,12 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
> >  		panthor_fw_stop(ptdev);
> >  		ptdev->fw->fast_reset = false;
> >  		drm_err(&ptdev->base, "FW fast reset failed, trying a slow reset");
> > +
> > +		ret = panthor_vm_flush_all(ptdev->fw->vm);
> > +		if (ret) {
> > +			drm_err(&ptdev->base, "FW slow reset failed (couldn't flush FW's AS l2cache)");
> > +			return ret;
> > +		}
> >  	}
> >  
> >  	/* Reload all sections, including RO ones. We're not supposed
> > @@ -1099,7 +1105,7 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
> >  
> >  	ret = panthor_fw_start(ptdev);
> >  	if (ret) {
> > -		drm_err(&ptdev->base, "FW slow reset failed");
> > +		drm_err(&ptdev->base, "FW slow reset failed (couldn't start the FW )");
> >  		return ret;
> >  	}
> >  
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> > index d47972806d50..a77ee5ce691d 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -874,14 +874,27 @@ static int panthor_vm_flush_range(struct panthor_vm *vm, u64 iova, u64 size)
> >  	if (!drm_dev_enter(&ptdev->base, &cookie))
> >  		return 0;
> >  
> > -	/* Flush the PTs only if we're already awake */
> > -	if (pm_runtime_active(ptdev->base.dev))
> > -		ret = mmu_hw_do_operation(vm, iova, size, AS_COMMAND_FLUSH_PT);
> > +	/*
> > +	 * If we made it this far, that means the device is awake, because
> > +	 * upon device suspension, all active VMs are given an AS id of -1
> > +	 */
> > +	ret = mmu_hw_do_operation(vm, iova, size, AS_COMMAND_FLUSH_PT);
> 
> I would normally prefer this change to be in its own commit, but given
> this is needed to be able to flush caches in the resume path, I'm fine
> keeping it in the same patch. The comment is a bit odd now that you
> dropped the pm_runtime_active() call though. I would rather have a
> comment in mmu_hw_do_operation_locked(), after the AS ID check
> explaining that as.id >= 0 guarantees that the HW is up and running,
> and that we can proceed with the flush operation without calling
> pm_runtime_active().

Given Boris' comments, are you planning on sending a v2?

Best regards,
Liviu

> 
> >  
> >  	drm_dev_exit(cookie);
> >  	return ret;
> >  }
> >  
> > +/**
> > + * panthor_vm_flush_all() - Flush L2 caches for the entirety of a VM's AS
> > + * @vm: VM whose cache to flush
> > + *
> > + * Return: 0 on success, a negative error code if flush failed.
> > + */
> > +int panthor_vm_flush_all(struct panthor_vm *vm)
> > +{
> > +	return panthor_vm_flush_range(vm, vm->base.mm_start, vm->base.mm_range);
> > +}
> > +
> >  static int panthor_vm_unmap_pages(struct panthor_vm *vm, u64 iova, u64 size)
> >  {
> >  	struct panthor_device *ptdev = vm->ptdev;
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
> > index f3c1ed19f973..6788771071e3 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.h
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.h
> > @@ -31,6 +31,7 @@ panthor_vm_get_bo_for_va(struct panthor_vm *vm, u64 va, u64 *bo_offset);
> >  int panthor_vm_active(struct panthor_vm *vm);
> >  void panthor_vm_idle(struct panthor_vm *vm);
> >  int panthor_vm_as(struct panthor_vm *vm);
> > +int panthor_vm_flush_all(struct panthor_vm *vm);
> >  
> >  struct panthor_heap_pool *
> >  panthor_vm_get_heap_pool(struct panthor_vm *vm, bool create);
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

