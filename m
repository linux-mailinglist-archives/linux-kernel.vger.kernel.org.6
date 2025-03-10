Return-Path: <linux-kernel+bounces-554114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE6CA59321
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 010607A4C83
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992EC2248A4;
	Mon, 10 Mar 2025 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMmE6/EW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB922371A;
	Mon, 10 Mar 2025 11:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607697; cv=none; b=b5xQu5CQLfwiKEFVknuXOp+7swfnt+JsIIkiMbYlpklQ37s/5zei0EAYEKyaEiX5Rw5twVmqVyNeq64lJ3kT78MTnxlE71OtPI1gEFxsH8c0pI5asPa5e4oiiJ07PE933HfV9FXnvw1OH7bsF0uZRPoNnLN9GFsZSfYrMtco/h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607697; c=relaxed/simple;
	bh=L0G+cWQ6MiMUUxg8yXwOMuhWPhIuaRGC4pei6Zxu458=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLHWdO9sZtVFWSUzDUXcj689+MyqMQjInVtNG7PrWom3VpKKluLBR+cZpcRczEW3c+ggP0jXnPAdVMkXpqxQXYTkoScvs00RjsTWDPS3G8GqOeNzc6Jx6s2n80soFwzGQm36Amuebxr4VebB9ug6jOPhOCRYTff5steTKG9q5BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMmE6/EW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7FDC4CEEA;
	Mon, 10 Mar 2025 11:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741607696;
	bh=L0G+cWQ6MiMUUxg8yXwOMuhWPhIuaRGC4pei6Zxu458=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nMmE6/EWnK+OXvU+AHMISIPyVX9w6Uxp6tn//YML+2dz0/cFecoOny2UwEjkcJsWJ
	 8jzq7nHyYXoqohswhwJBgfP0xIkAqyqdnRJWO6RBjJgaBqfMQFKbv65y6JMgCBbrO4
	 B18vzDJIF4r4JK2ldov7MW1EFvF0yIK7S31vi+HhimByUL9KFH8jtMJgrpnbp8r1Am
	 ClTGgSl8Fxxg/tSaV00E/1/C2j8Xq+kAjuz37biDTGYZaE1LwAQ+lVftWMj9fqgSf6
	 DXPeC8pGlsmR54sS5ikRX5Gg0BN9y0NU9fDTTXxvUjtjFN5jBrpbNRQL32Z26gWEUN
	 UkmQq1FLV0xtw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1trbif-00C9s2-HP;
	Mon, 10 Mar 2025 11:54:53 +0000
Date: Mon, 10 Mar 2025 11:54:52 +0000
Message-ID: <861pv5p0c3.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: <ankita@nvidia.com>
Cc: <jgg@nvidia.com>,
	<oliver.upton@linux.dev>,
	<joey.gouly@arm.com>,
	<suzuki.poulose@arm.com>,
	<yuzenghui@huawei.com>,
	<catalin.marinas@arm.com>,
	<will@kernel.org>,
	<ryan.roberts@arm.com>,
	<shahuang@redhat.com>,
	<lpieralisi@kernel.org>,
	<david@redhat.com>,
	<aniketa@nvidia.com>,
	<cjia@nvidia.com>,
	<kwankhede@nvidia.com>,
	<targupta@nvidia.com>,
	<vsethi@nvidia.com>,
	<acurrid@nvidia.com>,
	<apopple@nvidia.com>,
	<jhubbard@nvidia.com>,
	<danw@nvidia.com>,
	<zhiw@nvidia.com>,
	<mochs@nvidia.com>,
	<udhoke@nvidia.com>,
	<dnigam@nvidia.com>,
	<alex.williamson@redhat.com>,
	<sebastianene@google.com>,
	<coltonlewis@google.com>,
	<kevin.tian@intel.com>,
	<yi.l.liu@intel.com>,
	<ardb@kernel.org>,
	<akpm@linux-foundation.org>,
	<gshan@redhat.com>,
	<linux-mm@kvack.org>,
	<ddutile@redhat.com>,
	<tabba@google.com>,
	<qperret@google.com>,
	<seanjc@google.com>,
	<kvmarm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/1] KVM: arm64: Allow cacheable stage 2 mapping using VMA flags
In-Reply-To: <20250310103008.3471-2-ankita@nvidia.com>
References: <20250310103008.3471-1-ankita@nvidia.com>
	<20250310103008.3471-2-ankita@nvidia.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: ankita@nvidia.com, jgg@nvidia.com, oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, ryan.roberts@arm.com, shahuang@redhat.com, lpieralisi@kernel.org, david@redhat.com, aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com, zhiw@nvidia.com, mochs@nvidia.com, udhoke@nvidia.com, dnigam@nvidia.com, alex.williamson@redhat.com, sebastianene@google.com, coltonlewis@google.com, kevin.tian@intel.com, yi.l.liu@intel.com, ardb@kernel.org, akpm@linux-foundation.org, gshan@redhat.com, linux-mm@kvack.org, ddutile@redhat.com, tabba@google.com, qperret@google.com, seanjc@google.com, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 10 Mar 2025 10:30:08 +0000,
<ankita@nvidia.com> wrote:
> 
> From: Ankit Agrawal <ankita@nvidia.com>
> 
> Today KVM forces the memory to either NORMAL or DEVICE_nGnRE
> based on pfn_is_map_memory (which tracks whether the device memory
> is added to the kernel) and ignores the per-VMA flags that indicates the
> memory attributes. The KVM code is thus restrictive and allows only for
> the memory that is added to the kernel to be marked as cacheable.
> 
> The device memory such as on the Grace Hopper/Blackwell systems
> is interchangeable with DDR memory and retains properties such as
> cacheability, unaligned accesses, atomics and handling of executable
> faults. This requires the device memory to be mapped as NORMAL in
> stage-2.
> 
> Given that the GPU device memory is not added to the kernel (but is rather
> VMA mapped through remap_pfn_range() in nvgrace-gpu module which sets
> VM_PFNMAP), pfn_is_map_memory() is false and thus KVM prevents such memory
> to be mapped Normal cacheable. The patch aims to solve this use case.
> 
> A cachebility check is made if the VM_PFNMAP is set in VMA flags by
> consulting the VMA pgprot value. If the pgprot mapping type is MT_NORMAL,
> it is safe to be mapped cacheable as the KVM S2 will have the same
> Normal memory type as the VMA has in the S1 and KVM has no additional
> responsibility for safety. Checking pgprot as NORMAL is thus a KVM
> sanity check.
> 
> Introduce a new variable cacheable_devmem to indicate a safely
> cacheable mapping. Do not set the device variable when cacheable_devmem
> is true. This essentially have the effect of setting stage-2 mapping
> as NORMAL through kvm_pgtable_stage2_map.
> 
> Add check for COW VM_PFNMAP and refuse such mapping.
> 
> No additional checks for MTE are needed as kvm_arch_prepare_memory_region()
> already tests it at an early stage during memslot creation. There would
> not even be a fault if the memslot is not created.
> 
> Note when FWB is not enabled, the kernel expects to trivially do
> cache management by flushing the memory by linearly converting a
> kvm_pte to phys_addr to a KVA, see kvm_flush_dcache_to_poc(). The
> cache management thus relies on memory being mapped. So do not allow
> !FWB.
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h |  8 ++++++
>  arch/arm64/kvm/hyp/pgtable.c         |  2 +-
>  arch/arm64/kvm/mmu.c                 | 43 +++++++++++++++++++++++++++-
>  3 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index 6b9d274052c7..f21e2fae2bfe 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -507,6 +507,14 @@ u64 kvm_pgtable_hyp_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size);
>   */
>  u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift);
>  
> +/**
> + * stage2_has_fwb() - Determine whether FWB is supported
> + * @pgt:    Page-table structure initialised by kvm_pgtable_stage2_init*()
> + *
> + * Return: True if FWB is supported.
> + */
> +bool stage2_has_fwb(struct kvm_pgtable *pgt);
> +
>  /**
>   * kvm_pgtable_stage2_pgd_size() - Helper to compute size of a stage-2 PGD
>   * @vtcr:	Content of the VTCR register.
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index df5cc74a7dd0..ee6b98fefd61 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -637,7 +637,7 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
>  	return vtcr;
>  }
>  
> -static bool stage2_has_fwb(struct kvm_pgtable *pgt)
> +bool stage2_has_fwb(struct kvm_pgtable *pgt)
>  {
>  	if (!cpus_have_final_cap(ARM64_HAS_STAGE2_FWB))
>  		return false;
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 1f55b0c7b11d..4b3a03c9d700 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1454,6 +1454,15 @@ static bool kvm_vma_mte_allowed(struct vm_area_struct *vma)
>  	return vma->vm_flags & VM_MTE_ALLOWED;
>  }
>  
> +/*
> + * Determine the memory region cacheability from VMA's pgprot. This
> + * is used to set the stage 2 PTEs.
> + */
> +static unsigned long mapping_type(pgprot_t page_prot)
> +{
> +	return FIELD_GET(PTE_ATTRINDX_MASK, pgprot_val(page_prot));
> +}
> +
>  static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  			  struct kvm_s2_trans *nested,
>  			  struct kvm_memory_slot *memslot, unsigned long hva,
> @@ -1463,6 +1472,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	bool write_fault, writable, force_pte = false;
>  	bool exec_fault, mte_allowed;
>  	bool device = false, vfio_allow_any_uc = false;
> +	bool cacheable_devmem = false;
>  	unsigned long mmu_seq;
>  	phys_addr_t ipa = fault_ipa;
>  	struct kvm *kvm = vcpu->kvm;
> @@ -1600,6 +1610,19 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  
>  	vfio_allow_any_uc = vma->vm_flags & VM_ALLOW_ANY_UNCACHED;
>  
> +	if (vma->vm_flags & VM_PFNMAP) {
> +		/* Reject COW VM_PFNMAP */
> +		if (is_cow_mapping(vma->vm_flags))
> +			return -EINVAL;
> +		/*
> +		 * If the VM_PFNMAP is set in VMA flags, do a KVM sanity
> +		 * check to see if pgprot mapping type is MT_NORMAL and a
> +		 * safely cacheable device memory.
> +		 */
> +		if (mapping_type(vma->vm_page_prot) == MT_NORMAL)
> +			cacheable_devmem = true;
> +	}
> +
>  	/* Don't use the VMA after the unlock -- it may have vanished */
>  	vma = NULL;
>  
> @@ -1633,8 +1656,13 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  		 *
>  		 * In both cases, we don't let transparent_hugepage_adjust()
>  		 * change things at the last minute.
> +		 *
> +		 * Do not set device as the device memory is cacheable. Note
> +		 * that such mapping is safe as the KVM S2 will have the same
> +		 * Normal memory type as the VMA has in the S1.
>  		 */
> -		device = true;
> +		if (!cacheable_devmem)
> +			device = true;
>  	} else if (logging_active && !write_fault) {
>  		/*
>  		 * Only actually map the page as writable if this was a write
> @@ -1716,6 +1744,19 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  		prot |= KVM_PGTABLE_PROT_X;
>  	}
>  
> +	/*
> +	 *  When FWB is unsupported KVM needs to do cache flushes
> +	 *  (via dcache_clean_inval_poc()) of the underlying memory. This is
> +	 *  only possible if the memory is already mapped into the kernel map.
> +	 *
> +	 *  Outright reject as the cacheable device memory is not present in
> +	 *  the kernel map and not suitable for cache management.
> +	 */
> +	if (cacheable_devmem && !stage2_has_fwb(pgt)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +

These new error reasons should at least be complemented by an
equivalent check at the point where the memslot is registered. It
maybe OK to blindly return an error at fault time (because userspace
has messed with the mapping behind our back), but there should at
least be something telling a well behaved userspace that there is a
bunch of combination we're unwilling to support.

Which brings me to the next point: FWB is not discoverable from
userspace. How do you expect a VMM to know what it can or cannot do?

	M.

-- 
Without deviation from the norm, progress is not possible.

