Return-Path: <linux-kernel+bounces-423797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F1E9DACD6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D241642E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DAF2010E2;
	Wed, 27 Nov 2024 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U7nvKIk6"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E913BC35
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732730913; cv=none; b=du2nuX6v9+zCwTiFlsrIVzgnu1GNdEijIcMzDNfBsZMVZwSqb0qPhyIfWf07qHGEgJLfiP3qTLgIfH5TNZqfqu92dfIyZYn/xA/blSmf4lFr8c1RLx8/NBqR4PHfP1rBgxnDHOGqU34EWfdZqnwifWk26n+DtQD6/OhZt0zoUHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732730913; c=relaxed/simple;
	bh=vw2132CNXBgRGLLxwWucExzLgrRbHh8Lw1RU9m2KfZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWL29ltE0RZO4CYgt98nXgqpa6REFpMXbU2611iXEl+qtLf/Bxvky7rVzHyu/xtBgdHm0A4LxFd6YU7bms7ZU0wfI3q9Zp6QML1aHrcCl9eEvIupSC3vZ9VAtHEVWwEn1Zjhj2rmcn/aitojOxzF/O4K43xjANW59Lk4eU+ATHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U7nvKIk6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a95095efso7024215e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732730909; x=1733335709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pcxsieADxwEhyCmOAhCE2XhvbQKgUEh8cW7DZ1U1H+Q=;
        b=U7nvKIk6aBv+LMKM+JU52NtoM6cnfIfKVnjCoHdGz8Mcbg2C3nryOp3lGGNTTxQAgY
         uwyEENXnM2dXHQFtBbQAEKXQY/qYtXP+N85nqxeF2OO1davhZxuKnxF+il2/aDoKvYSF
         VQXOzHTyb5um3LBcusjZYehe2rc23KcqCfoV48nGQaThgWAJCOYPgLr552JcqF/xCf6q
         8dBo0bIcrg+2YW4MvXo4b3ya0VfEtGqteUBuzj2OvK5tPkSSAtVxBEX3q6XCgkS+Same
         Z1sN1ex7LOhrlC9klp7utzs+N+oc+NbQ+PTfx4lUmohsq62S+rQ9bfQOlLu77XLgfmzf
         90jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732730909; x=1733335709;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcxsieADxwEhyCmOAhCE2XhvbQKgUEh8cW7DZ1U1H+Q=;
        b=eBdpoiL0yhEH52ZbX3U95tvGnzeRrWgjJEtDNGzsIar3Mp3PvOkDOhFI4o0kmeoXIx
         vG6xh0gg9EMczWVg81EluU7J/NRVpj4QWISK76Tm2A3iWaHvtOWNHeiPKfkYjy/xRWOz
         6vcqP6pNljFkPXMcsoWz3nFoYpnmxbFPjaV6ALlZE9OxrCevGI7CT1g0DKYf5Jh5V3x4
         ckbYl6K3KTJW1J0UHClhmEKoXjjYgFDigL3uWZbc9jtYwtIthYBXoZnT7ATa1q0Xzg8w
         l1M4Nd0IpbFPn1khEKoWNfkCSt+WZPU+8Xg1ammuvv6pM4NO//TlYcDarSwtsGB28Rmf
         Uo/w==
X-Forwarded-Encrypted: i=1; AJvYcCUC3nWAxs/L3VhDvtX8TJBbMVxzjJxZ3ahg/YaQYsfTmXFlATNW69u0KWMn3jusZMnScrVNjUYS6oHzwBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkbRto2vJuDQhSgM6ShtfSE15Kys1E5UHRSIxT0x18pFmWkPv/
	PADkZc/Mbyot8O6rfcph7bn9jzzzp3i2vYQzh6gfOvfEtgcF+QrYA0keEF4eHxg=
X-Gm-Gg: ASbGncvcw/PK6YMzYI/ur7P1Hfm9i79fmoPPFt+abOl2Rs14ftxpbCCDA/vxHrixDZN
	aHLPiAsY1b/zd95jRD3wA9twUw1htQVfVJMBYZHMIZq0ouCPO+hgQQk/TeIsOb4Rh3em7h71cRW
	J8tbUTdLqIISqzIrPpkzfxhVyeePazqAsvUbDeB8elIE5uibWRQZ+K/DHzzTwzkaskgv4BEQ6cd
	i1AY/SLJVc/fAbh1s9XOqTbk+qPOabyNfjLG1Rdhykf6DdodMQwUIOQz8txZtWwmRnmc5mIZ1Y=
X-Google-Smtp-Source: AGHT+IEkG57GfQYROw7UzsrGEc7hpUA4YJpR0B46jSPEzhuIK4lIAcvNg5EbrTLWVYnRyHKkQ8bUUA==
X-Received: by 2002:a05:600c:1ca9:b0:431:55f3:d34e with SMTP id 5b1f17b1804b1-434afc46197mr3328125e9.15.1732730908944;
        Wed, 27 Nov 2024 10:08:28 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a5d5fb37sm49655025e9.0.2024.11.27.10.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 10:08:28 -0800 (PST)
Message-ID: <c270d467-4a12-4dab-8cdc-47b61779a37c@suse.com>
Date: Wed, 27 Nov 2024 20:08:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/24] KVM: TDX: Add an ioctl to create initial guest
 memory
To: Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, seanjc@google.com,
 kvm@vger.kernel.org, dave.hansen@linux.intel.com
Cc: rick.p.edgecombe@intel.com, kai.huang@intel.com, adrian.hunter@intel.com,
 reinette.chatre@intel.com, xiaoyao.li@intel.com, tony.lindgren@intel.com,
 binbin.wu@linux.intel.com, dmatlack@google.com, isaku.yamahata@intel.com,
 isaku.yamahata@gmail.com, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20241112073327.21979-1-yan.y.zhao@intel.com>
 <20241112073837.22284-1-yan.y.zhao@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20241112073837.22284-1-yan.y.zhao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12.11.24 г. 9:38 ч., Yan Zhao wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Add a new ioctl for the user space VMM to initialize guest memory with the
> specified memory contents.
> 
> Because TDX protects the guest's memory, the creation of the initial guest
> memory requires a dedicated TDX module API, TDH.MEM.PAGE.ADD(), instead of
> directly copying the memory contents into the guest's memory in the case of
> the default VM type.
> 
> Define a new subcommand, KVM_TDX_INIT_MEM_REGION, of vCPU-scoped
> KVM_MEMORY_ENCRYPT_OP.  Check if the GFN is already pre-allocated, assign
> the guest page in Secure-EPT, copy the initial memory contents into the
> guest memory, and encrypt the guest memory.  Optionally, extend the memory
> measurement of the TDX guest.
> 
> The ioctl uses the vCPU file descriptor because of the TDX module's
> requirement that the memory is added to the S-EPT (via TDH.MEM.SEPT.ADD)
> prior to initialization (TDH.MEM.PAGE.ADD).  Accessing the MMU in turn
> requires a vCPU file descriptor, just like for KVM_PRE_FAULT_MEMORY.  In
> fact, the post-populate callback is able to reuse the same logic used by
> KVM_PRE_FAULT_MEMORY, so that userspace can do everything with a single
> ioctl.
> 
> Note that this is the only way to invoke TDH.MEM.SEPT.ADD before the TD
> in finalized, as userspace cannot use KVM_PRE_FAULT_MEMORY at that
> point.  This ensures that there cannot be pages in the S-EPT awaiting
> TDH.MEM.PAGE.ADD, which would be treated incorrectly as spurious by
> tdp_mmu_map_handle_target_level() (KVM would see the SPTE as PRESENT,
> but the corresponding S-EPT entry will be !PRESENT).
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Co-developed-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
> TDX MMU part 2 v2:
>   - Updated commit msg (Paolo)
>   - Added a guard around kvm_tdp_mmu_gpa_is_mapped() (Paolo).
>   - Remove checking kvm_mem_is_private() in tdx_gmem_post_populate (Rick)
>   - No need for is_td_finalized() (Rick)
>   - Remove decrement of nr_premapped (moved to "Finalize VM initialization"
>     patch) (Paolo)
>   - Take slots_lock before checking kvm_tdx->finalized in
>     tdx_vcpu_init_mem_region(), and use guard() (Paolo)
>   - Fixup SEAMCALL call sites due to function parameter changes to SEAMCALL
>     wrappers (Kai)
>   - Add TD state handling (Tony)
> 
> TDX MMU part 2 v1:
>   - Update the code according to latest gmem update.
>     https://lore.kernel.org/kvm/CABgObfa=a3cKcKJHQRrCs-3Ty8ppSRou=dhi6Q+KdZnom0Zegw@mail.gmail.com/
>   - Fixup a aligment bug reported by Binbin.
>   - Rename KVM_MEMORY_MAPPING => KVM_MAP_MEMORY (Sean)
>   - Drop issueing TDH.MEM.PAGE.ADD() on KVM_MAP_MEMORY(), defer it to
>     KVM_TDX_INIT_MEM_REGION. (Sean)
>   - Added nr_premapped to track the number of premapped pages
>   - Drop tdx_post_mmu_map_page().
>   - Drop kvm_slot_can_be_private() check (Paolo)
>   - Use kvm_tdp_mmu_gpa_is_mapped() (Paolo)
> 
> v19:
>   - Switched to use KVM_MEMORY_MAPPING
>   - Dropped measurement extension
>   - updated commit message. private_page_add() => set_private_spte()
> ---
>   arch/x86/include/uapi/asm/kvm.h |   9 ++
>   arch/x86/kvm/vmx/tdx.c          | 147 ++++++++++++++++++++++++++++++++
>   virt/kvm/kvm_main.c             |   1 +
>   3 files changed, 157 insertions(+)
> 
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index 36fa03376581..a19cd84cec76 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -931,6 +931,7 @@ enum kvm_tdx_cmd_id {
>   	KVM_TDX_CAPABILITIES = 0,
>   	KVM_TDX_INIT_VM,
>   	KVM_TDX_INIT_VCPU,
> +	KVM_TDX_INIT_MEM_REGION,
>   	KVM_TDX_GET_CPUID,
>   
>   	KVM_TDX_CMD_NR_MAX,
> @@ -985,4 +986,12 @@ struct kvm_tdx_init_vm {
>   	struct kvm_cpuid2 cpuid;
>   };
>   
> +#define KVM_TDX_MEASURE_MEMORY_REGION   _BITULL(0)
> +
> +struct kvm_tdx_init_mem_region {
> +	__u64 source_addr;
> +	__u64 gpa;
> +	__u64 nr_pages;
> +};
> +
>   #endif /* _ASM_X86_KVM_H */
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index ead520083397..15cedacd717a 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1,4 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
> +#include <linux/cleanup.h>
>   #include <linux/cpu.h>
>   #include <asm/tdx.h>
>   #include "capabilities.h"
> @@ -7,6 +8,7 @@
>   #include "tdx.h"
>   #include "vmx.h"
>   #include "mmu/spte.h"
> +#include "common.h"
>   
>   #undef pr_fmt
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -1597,6 +1599,148 @@ static int tdx_vcpu_init(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *cmd)
>   	return 0;
>   }
>   
> +struct tdx_gmem_post_populate_arg {
> +	struct kvm_vcpu *vcpu;
> +	__u32 flags;
> +};
> +
> +static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +				  void __user *src, int order, void *_arg)
> +{
> +	u64 error_code = PFERR_GUEST_FINAL_MASK | PFERR_PRIVATE_ACCESS;
> +	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
> +	struct tdx_gmem_post_populate_arg *arg = _arg;
> +	struct kvm_vcpu *vcpu = arg->vcpu;
> +	gpa_t gpa = gfn_to_gpa(gfn);
> +	u8 level = PG_LEVEL_4K;
> +	struct page *page;
> +	int ret, i;
> +	u64 err, entry, level_state;
> +
> +	/*
> +	 * Get the source page if it has been faulted in. Return failure if the
> +	 * source page has been swapped out or unmapped in primary memory.
> +	 */
> +	ret = get_user_pages_fast((unsigned long)src, 1, 0, &page);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != 1)
> +		return -ENOMEM;
> +
> +	ret = kvm_tdp_map_page(vcpu, gpa, error_code, &level);
> +	if (ret < 0)
> +		goto out;
> +
> +	/*
> +	 * The private mem cannot be zapped after kvm_tdp_map_page()
> +	 * because all paths are covered by slots_lock and the
> +	 * filemap invalidate lock.  Check that they are indeed enough.
> +	 */
> +	if (IS_ENABLED(CONFIG_KVM_PROVE_MMU)) {
> +		scoped_guard(read_lock, &kvm->mmu_lock) {
> +			if (KVM_BUG_ON(!kvm_tdp_mmu_gpa_is_mapped(vcpu, gpa), kvm)) {
> +				ret = -EIO;
> +				goto out;
> +			}
> +		}
> +	}
> +
> +	ret = 0;
> +	do {
> +		err = tdh_mem_page_add(kvm_tdx->tdr_pa, gpa, pfn_to_hpa(pfn),
> +				       pfn_to_hpa(page_to_pfn(page)),
> +				       &entry, &level_state);
> +	} while (err == TDX_ERROR_SEPT_BUSY);
> +	if (err) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	if (arg->flags & KVM_TDX_MEASURE_MEMORY_REGION) {
> +		for (i = 0; i < PAGE_SIZE; i += TDX_EXTENDMR_CHUNKSIZE) {
> +			err = tdh_mr_extend(kvm_tdx->tdr_pa, gpa + i, &entry,
> +					    &level_state);
> +			if (err) {
> +				ret = -EIO;
> +				break;
> +			}
> +		}
> +	}
> +
> +out:
> +	put_page(page);
> +	return ret;
> +}
> +
> +static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *cmd)
> +{
> +	struct vcpu_tdx *tdx = to_tdx(vcpu);
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
> +	struct kvm_tdx_init_mem_region region;
> +	struct tdx_gmem_post_populate_arg arg;
> +	long gmem_ret;
> +	int ret;
> +
> +	if (tdx->state != VCPU_TD_STATE_INITIALIZED)
> +		return -EINVAL;
> +
> +	guard(mutex)(&kvm->slots_lock);

It seems the scope of this lock can be reduced. It's really needed for 
the kvm_gmem_populate call only, no ?

<snip>


