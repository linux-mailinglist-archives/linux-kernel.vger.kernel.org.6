Return-Path: <linux-kernel+bounces-380255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A9F9AEB10
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2C22848D9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5098F1F5820;
	Thu, 24 Oct 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bfwEEwSs"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376981E7642
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784993; cv=none; b=ussSyjOc0dp1Pye0ynQoid8eDWUZoXJ3RLsDeulzF7tgp/j8lxusjQ7mN6NKIFAtIpqektR168hx01m1PUAK4L0367bqeE/uQSMvjKUJvpaF8MyeF3Jul7BQGyFidwkzo2515lSjksvly5ndEwl7FYjjpr97DelF9P9o1Q263lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784993; c=relaxed/simple;
	bh=+r7PFQxCeGpmi1up4Fbly4LPrmk1HCWZowpXp5Vr+Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHQidaINVtAdLq1tQOjNkDTFMA6zPhIc+mTws2W6ZNg5j2eGkonlD9cJcClNNCxdH4qZELNg1tve3g7JNQhuppC14K/FuBU8oXF95Eq7l2Jwkjn5v15nO2hmijXTS9NZ71c9YAjX4bYpbSBNA66yoGoWp+tTrzbNMMZoR88mqoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bfwEEwSs; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729784989;
	bh=+r7PFQxCeGpmi1up4Fbly4LPrmk1HCWZowpXp5Vr+Uc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bfwEEwSsDrHBVjL9JElSpgFrtK8WsWUzxFbswhKJh6Bjz89fbNXtQp3UPLTDexoIl
	 xty2FNOgwX9j1JYnse11HPVD6cKJU5WtBbrHsT4jtyQcZv2CKInHV0RsHWhxRPEm+g
	 hwOsph71Zs4eHsIXPs1jlawsQgsZdW/zPio4z0Kpqv4T0VnRKAWdQWxN/g0thOMRUZ
	 Qc94KvEEq7qJB8i0l0uERpQzTh90sM1oa88QSomvNZma4M5Pu66j/QCSmpz6J4fyyI
	 VKMWNxJhWVoMf3PDCo+8o+AV34hYCCXd0KaBREDhpNCCITsuqEh3VYqb5TJKUFffqw
	 v6FoRXCcstJIQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C42BA17E3664;
	Thu, 24 Oct 2024 17:49:48 +0200 (CEST)
Date: Thu, 24 Oct 2024 17:49:44 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Akash Goel <akash.goel@arm.com>, Robin Murphy <robin.murphy@arm.com>
Cc: liviu.dudau@arm.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mihail.atanassov@arm.com, ketil.johnsen@arm.com, florent.tomasin@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH 1/3] drm/panthor: Update memattr programing to align
 with GPU spec
Message-ID: <20241024174944.4e811816@collabora.com>
In-Reply-To: <20241024145432.934086-2-akash.goel@arm.com>
References: <20241024145432.934086-1-akash.goel@arm.com>
	<20241024145432.934086-2-akash.goel@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

+Robin for the MMU details

On Thu, 24 Oct 2024 15:54:30 +0100
Akash Goel <akash.goel@arm.com> wrote:

> Mali GPU Arch spec forbids the GPU PTEs to indicate Inner or Outer
> shareability when no_coherency protocol is selected. Doing so results in
> unexpected or undesired snooping of the CPU caches on some platforms,
> such as Juno FPGA, causing functional issues. For example the boot of
> MCU firmware fails as GPU ends up reading stale data for the FW memory
> pages from the CPU's cache. The FW memory pages are initialized with
> uncached mapping when the device is not reported to be dma-coherent.
> The shareability bits are set to inner-shareable when IOMMU_CACHE flag
> is passed to map_pages() callback and IOMMU_CACHE flag is passed by
> Panthor driver when memory needs to be mapped as cached on the GPU side.
> 
> IOMMU_CACHE seems to imply cache coherent and is probably not fit for
> purpose for the memory that is mapped as cached on GPU side but doesn't
> need to remain coherent with the CPU.

Yeah, IIRC I've been abusing the _CACHE flag to mean GPU-cached, not
cache-coherent. I think it be good to sit down with Rob and add the
necessary IOMMU_ flags so we can express all the shareability and
cacheability variants we have with the "Mali" MMU. For instance, I
think the shareability between MCU/GPU can be expressed properly at the
moment, and we unconditionally map things uncached because of that.

> 
> This commit updates the programming of MEMATTR register to use
> MIDGARD_INNER instead of CPU_INNER when coherency is disabled. That way
> the inner-shareability specified in the GPU PTEs would map to Mali's
> internal-shareable mode, which is always supported by the GPU regardless
> of the coherency protocal and is required by the Userspace driver to
> ensure coherency between the shader cores.
> 
> Signed-off-by: Akash Goel <akash.goel@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index f3ee5d2753f1..f522a116c1b1 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1927,7 +1927,7 @@ struct panthor_heap_pool *panthor_vm_get_heap_pool(struct panthor_vm *vm, bool c
>  	return pool;
>  }
>  
> -static u64 mair_to_memattr(u64 mair)
> +static u64 mair_to_memattr(u64 mair, bool coherent)
>  {
>  	u64 memattr = 0;
>  	u32 i;
> @@ -1946,14 +1946,21 @@ static u64 mair_to_memattr(u64 mair)
>  				   AS_MEMATTR_AARCH64_SH_MIDGARD_INNER |
>  				   AS_MEMATTR_AARCH64_INNER_ALLOC_EXPL(false, false);
>  		} else {
> -			/* Use SH_CPU_INNER mode so SH_IS, which is used when
> -			 * IOMMU_CACHE is set, actually maps to the standard
> -			 * definition of inner-shareable and not Mali's
> -			 * internal-shareable mode.
> -			 */
>  			out_attr = AS_MEMATTR_AARCH64_INNER_OUTER_WB |
> -				   AS_MEMATTR_AARCH64_SH_CPU_INNER |
>  				   AS_MEMATTR_AARCH64_INNER_ALLOC_EXPL(inner & 1, inner & 2);
> +			/* Use SH_MIDGARD_INNER mode when device isn't coherent,
> +			 * so SH_IS, which is used when IOMMU_CACHE is set, maps
> +			 * to Mali's internal-shareable mode. As per the Mali
> +			 * Spec, inner and outer-shareable modes aren't allowed
> +			 * for WB memory when coherency is disabled.
> +			 * Use SH_CPU_INNER mode when coherency is enabled, so
> +			 * that SH_IS actually maps to the standard definition of
> +			 * inner-shareable.
> +			 */
> +			if (!coherent)
> +				out_attr |= AS_MEMATTR_AARCH64_SH_MIDGARD_INNER;
> +			else
> +				out_attr |= AS_MEMATTR_AARCH64_SH_CPU_INNER;
>  		}
>  
>  		memattr |= (u64)out_attr << (8 * i);
> @@ -2325,7 +2332,7 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
>  		goto err_sched_fini;
>  
>  	mair = io_pgtable_ops_to_pgtable(vm->pgtbl_ops)->cfg.arm_lpae_s1_cfg.mair;
> -	vm->memattr = mair_to_memattr(mair);
> +	vm->memattr = mair_to_memattr(mair, ptdev->coherent);
>  
>  	mutex_lock(&ptdev->mmu->vm.lock);
>  	list_add_tail(&vm->node, &ptdev->mmu->vm.list);


