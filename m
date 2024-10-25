Return-Path: <linux-kernel+bounces-381365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59079AFE1F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2481B25906
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8161D2B2A;
	Fri, 25 Oct 2024 09:24:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F946189F32
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848281; cv=none; b=NTVV9mP9qP44L1lULyb60j0o9SavTwsfi7NEbHRcKZQiyDsfq1C96BOGowzQd7UsEH/E5rDOi2Mkg/JiV9tOsotWNVoLhBeqFh7GNJvKuzF8hKQbNoyN+IBFUEO/AI/hYvERBlL7GcKeD+EgXlhM7Z1lS/g/yRUl2VwMGvJXB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848281; c=relaxed/simple;
	bh=TBDkSuo5x3p8mQoUGeLG6MNLepjmbreVxYkVHosW27I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vk0RMDM08L9nNo4eQ59vaUfqR/Cx7hpiBWCYvdCzY+gss+vM3vLtr6bVbloXG7Wny4+ib8j2/5qkdoKs4m2b398qnua747xgw+6oGaflnXlYt/KHomFW1WYhH5bLKMzCjtCXGCCjR7Nr32uc6+8t1YEhdmsRIMWlg/3okpDcuW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E950339
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:25:06 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A3CBE3F528
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:24:36 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:24:32 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Akash Goel <akash.goel@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	steven.price@arm.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, mihail.atanassov@arm.com,
	ketil.johnsen@arm.com, florent.tomasin@arm.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH 1/3] drm/panthor: Update memattr programing to align with
 GPU spec
Message-ID: <Zxtj0B3BrMYDt9ID@e110455-lin.cambridge.arm.com>
References: <20241024145432.934086-1-akash.goel@arm.com>
 <20241024145432.934086-2-akash.goel@arm.com>
 <20241024174944.4e811816@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024174944.4e811816@collabora.com>

On Thu, Oct 24, 2024 at 05:49:44PM +0200, Boris Brezillon wrote:
> +Robin for the MMU details
> 
> On Thu, 24 Oct 2024 15:54:30 +0100
> Akash Goel <akash.goel@arm.com> wrote:
> 
> > Mali GPU Arch spec forbids the GPU PTEs to indicate Inner or Outer
> > shareability when no_coherency protocol is selected. Doing so results in
> > unexpected or undesired snooping of the CPU caches on some platforms,
> > such as Juno FPGA, causing functional issues. For example the boot of
> > MCU firmware fails as GPU ends up reading stale data for the FW memory
> > pages from the CPU's cache. The FW memory pages are initialized with
> > uncached mapping when the device is not reported to be dma-coherent.
> > The shareability bits are set to inner-shareable when IOMMU_CACHE flag
> > is passed to map_pages() callback and IOMMU_CACHE flag is passed by
> > Panthor driver when memory needs to be mapped as cached on the GPU side.
> > 
> > IOMMU_CACHE seems to imply cache coherent and is probably not fit for
> > purpose for the memory that is mapped as cached on GPU side but doesn't
> > need to remain coherent with the CPU.
> 
> Yeah, IIRC I've been abusing the _CACHE flag to mean GPU-cached, not
> cache-coherent. I think it be good to sit down with Rob and add the
> necessary IOMMU_ flags so we can express all the shareability and
> cacheability variants we have with the "Mali" MMU. For instance, I
> think the shareability between MCU/GPU can be expressed properly at the
> moment, and we unconditionally map things uncached because of that.

Boris, did you mean to say "shareability between MCU/GPU *can't* be expressed
properly" ? Currently the sentence reads a bit strange, as if there was a
negation somewhere.

Our GPU's architecture dictates a lot of coherency attributes, especially at
the read-write/read-only L1$, so using _CACHE as a flag for something else
is indeed tempting. We should talk with Rob to see how we can improve things
here.

> 
> > 
> > This commit updates the programming of MEMATTR register to use
> > MIDGARD_INNER instead of CPU_INNER when coherency is disabled. That way
> > the inner-shareability specified in the GPU PTEs would map to Mali's
> > internal-shareable mode, which is always supported by the GPU regardless
> > of the coherency protocal and is required by the Userspace driver to
> > ensure coherency between the shader cores.
> > 
> > Signed-off-by: Akash Goel <akash.goel@arm.com>
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> 
> > ---
> >  drivers/gpu/drm/panthor/panthor_mmu.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> > index f3ee5d2753f1..f522a116c1b1 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -1927,7 +1927,7 @@ struct panthor_heap_pool *panthor_vm_get_heap_pool(struct panthor_vm *vm, bool c
> >  	return pool;
> >  }
> >  
> > -static u64 mair_to_memattr(u64 mair)
> > +static u64 mair_to_memattr(u64 mair, bool coherent)
> >  {
> >  	u64 memattr = 0;
> >  	u32 i;
> > @@ -1946,14 +1946,21 @@ static u64 mair_to_memattr(u64 mair)
> >  				   AS_MEMATTR_AARCH64_SH_MIDGARD_INNER |
> >  				   AS_MEMATTR_AARCH64_INNER_ALLOC_EXPL(false, false);
> >  		} else {
> > -			/* Use SH_CPU_INNER mode so SH_IS, which is used when
> > -			 * IOMMU_CACHE is set, actually maps to the standard
> > -			 * definition of inner-shareable and not Mali's
> > -			 * internal-shareable mode.
> > -			 */
> >  			out_attr = AS_MEMATTR_AARCH64_INNER_OUTER_WB |
> > -				   AS_MEMATTR_AARCH64_SH_CPU_INNER |
> >  				   AS_MEMATTR_AARCH64_INNER_ALLOC_EXPL(inner & 1, inner & 2);
> > +			/* Use SH_MIDGARD_INNER mode when device isn't coherent,
> > +			 * so SH_IS, which is used when IOMMU_CACHE is set, maps
> > +			 * to Mali's internal-shareable mode. As per the Mali
> > +			 * Spec, inner and outer-shareable modes aren't allowed
> > +			 * for WB memory when coherency is disabled.
> > +			 * Use SH_CPU_INNER mode when coherency is enabled, so
> > +			 * that SH_IS actually maps to the standard definition of
> > +			 * inner-shareable.
> > +			 */
> > +			if (!coherent)
> > +				out_attr |= AS_MEMATTR_AARCH64_SH_MIDGARD_INNER;
> > +			else
> > +				out_attr |= AS_MEMATTR_AARCH64_SH_CPU_INNER;
> >  		}
> >  
> >  		memattr |= (u64)out_attr << (8 * i);
> > @@ -2325,7 +2332,7 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
> >  		goto err_sched_fini;
> >  
> >  	mair = io_pgtable_ops_to_pgtable(vm->pgtbl_ops)->cfg.arm_lpae_s1_cfg.mair;
> > -	vm->memattr = mair_to_memattr(mair);
> > +	vm->memattr = mair_to_memattr(mair, ptdev->coherent);
> >  
> >  	mutex_lock(&ptdev->mmu->vm.lock);
> >  	list_add_tail(&vm->node, &ptdev->mmu->vm.list);
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

