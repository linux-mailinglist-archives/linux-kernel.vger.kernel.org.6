Return-Path: <linux-kernel+bounces-244510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FC992A548
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F491F21644
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD30D1420C9;
	Mon,  8 Jul 2024 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJCWzCXE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16F378C75
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450765; cv=none; b=e+X4SrBTSVQ3dvnI/CoXUBlT8FtBKJVgVid3/AKaxyfldnFAKmHUnUSyhbJBAq33ugaZXY+Bn7Mkfi6bvsRQUFxx4M5OIgaO+FfUw/IvF/eiU7TKRpawTfTP1WMOyH8y8ZZ1bxoAbl7q8l0sdPsLCgQlZo2biUx+Q1uSmqkUQF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450765; c=relaxed/simple;
	bh=jUDFW65Hw+qVUyZ1BNKiCte8ar7aYmWWU6Qto9MJt+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kg3X2pHoQmJi7crpvkQ9FAALWOo02P8yftMnrgmq3SDA8deyEM1K170RBjYjUNfbZBDr/yNQDoWJOBfzXq/3MbR0YLiICH6naG/y0Pl8+aq/yA7IG/VPIB1H6ARdSWpqkCdeCJj/w2NlbDtHr9EfHkQ4qRIm21An+aYLpMvd8JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJCWzCXE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720450761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vg9DjfCwdbJDNgmS6lMmq1sY0xpLSifks2hUMYnkge4=;
	b=WJCWzCXExX242kbXTpn6+Q4vZaqIZL4HxbanPfEpLuutPfffiCLRvqVEzcRYxzV7+O+T4k
	HxrBw2oKWVIVbgEoh6jQk/Uv35fpXRiABy/I8W5imr+NPRy9uEqBH/XfZTHCGbc4cfkdkC
	FTEhuCbnfYRsM7IXwVrkqgLgVlSon/E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-zMs3q7g_P1a_-30uCl_s1w-1; Mon, 08 Jul 2024 10:59:19 -0400
X-MC-Unique: zMs3q7g_P1a_-30uCl_s1w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4266b03fe2bso7335265e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 07:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720450759; x=1721055559;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vg9DjfCwdbJDNgmS6lMmq1sY0xpLSifks2hUMYnkge4=;
        b=cmdQ4iRlQeHVb6jMHVasOsyQFqcEiAX0BTYmM7oLLS12iiT+6eTfIr5FeatjhVf9Bs
         HyaGS6Nau+6R/9Wjc4HyOsWQkCCeXfk1jzP4ug3r4oluP4mTllHckyDpN4MyfcynrVa1
         U6/KF3n0Oknx0ojj8TD7LD8IT4uDRdjy0tDTvXsE/JYuA0rxg4u8Gttzx1mVfGPqRtIv
         5oV1mRisX6qPGZaNczEKoiY0Oh5jhDVsCIeGVebjo+QikhLITW29Fh4wGd6LvfSDFKj0
         r5b13RcIsAQoRiB9B9vqPbb7Ux9qd6wjNGeEaml6LKAjcXh2/mVZRd5CGoXSST0+WTcp
         AATQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL+DXEWQzEISQOGBMv8kBcmQ6dvU3xHTx0DzvC8yqMcjjBAEstKznySi9yKHtODAEfCJmYZ85jWy0R9geWaSaOT/1ytGKSalqFWtRJ
X-Gm-Message-State: AOJu0YxAkc8XY6SWuJS7jVrymrlzhjGcbdG/AXEfQrOXJNL/WN8fPbmj
	BgNdbD0hI77GCfhh2fidDVNrEEyQeF/EcDhY3p1o67+Rbz6pUPzvjhYkjFvXuX+T5QdsL6mZKtQ
	0Op0t/eZOym58CrxLxPfxJLu0c2Hn4LpJJRR4CFhYTk4PXSblMIb88NO/CEqLHg==
X-Received: by 2002:a05:600c:4a2a:b0:426:6618:146a with SMTP id 5b1f17b1804b1-426661815cdmr28054815e9.2.1720450758774;
        Mon, 08 Jul 2024 07:59:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp5lzobkSaZTj0R3xkan3t7S9lWQ61nLaBDlag/pBn1hy1FMw3L4m04fxYvWWxkJ0eLo5r2Q==
X-Received: by 2002:a05:600c:4a2a:b0:426:6618:146a with SMTP id 5b1f17b1804b1-426661815cdmr28054585e9.2.1720450758298;
        Mon, 08 Jul 2024 07:59:18 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42666680fa5sm61659735e9.22.2024.07.08.07.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 07:59:17 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, linux-doc@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, graf@amazon.de, dwmw2@infradead.org,
 paul@amazon.com, nsaenz@amazon.com, mlevitsk@redhat.com,
 jgowans@amazon.com, corbet@lwn.net, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, amoorthy@google.com
Subject: Re: [PATCH 01/18] KVM: x86: hyper-v: Introduce XMM output support
In-Reply-To: <20240609154945.55332-2-nsaenz@amazon.com>
References: <20240609154945.55332-1-nsaenz@amazon.com>
 <20240609154945.55332-2-nsaenz@amazon.com>
Date: Mon, 08 Jul 2024 16:59:16 +0200
Message-ID: <87tth0rku3.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nicolas Saenz Julienne <nsaenz@amazon.com> writes:

> Prepare infrastructure to be able to return data through the XMM
> registers when Hyper-V hypercalls are issues in fast mode. The XMM
> registers are exposed to user-space through KVM_EXIT_HYPERV_HCALL and
> restored on successful hypercall completion.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
>
> ---
>
> There was some discussion in the RFC about whether growing 'struct
> kvm_hyperv_exit' is ABI breakage. IMO it isn't:
> - There is padding in 'struct kvm_run' that ensures that a bigger
>   'struct kvm_hyperv_exit' doesn't alter the offsets within that struct.
> - Adding a new field at the bottom of the 'hcall' field within the
>   'struct kvm_hyperv_exit' should be fine as well, as it doesn't alter
>   the offsets within that struct either.
> - Ultimately, previous updates to 'struct kvm_hyperv_exit's hint that
>   its size isn't part of the uABI. It already grew when syndbg was
>   introduced.

Yes but SYNDBG exit comes with KVM_EXIT_HYPERV_SYNDBG. While I don't see
any immediate issues with the current approach, we may want to introduce
something like KVM_EXIT_HYPERV_HCALL_XMM: the userspace must be prepared
to handle this new information anyway and it is better to make
unprepared userspace fail with 'unknown exit' then to mishandle a
hypercall by ignoring XMM portion of the data.

>
>  Documentation/virt/kvm/api.rst     | 19 ++++++++++
>  arch/x86/include/asm/hyperv-tlfs.h |  2 +-
>  arch/x86/kvm/hyperv.c              | 56 +++++++++++++++++++++++++++++-
>  include/uapi/linux/kvm.h           |  6 ++++
>  4 files changed, 81 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index a71d91978d9ef..17893b330b76f 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -8893,3 +8893,22 @@ Ordering of KVM_GET_*/KVM_SET_* ioctls
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
>  TBD
> +
> +10. Hyper-V CPUIDs
> +==================
> +
> +This section only applies to x86.

We can probably use 

:Architectures: x86

which we already use.

> +
> +New Hyper-V feature support is no longer being tracked through KVM
> +capabilities.  Userspace can check if a particular version of KVM supports a
> +feature using KMV_GET_SUPPORTED_HV_CPUID.  This section documents how Hyper-V
> +CPUIDs map to KVM functionality.
> +
> +10.1 HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE
> +------------------------------------------
> +
> +:Location: CPUID.40000003H:EDX[bit 15]
> +
> +This CPUID indicates that KVM supports retuning data to the guest in response
> +to a hypercall using the XMM registers. It also extends ``struct
> +kvm_hyperv_exit`` to allow passing the XMM data from userspace.

It's always good to document things, thanks! I'm, however, wondering
what should we document as part of KVM API. In the file, we already
have:
- "4.118 KVM_GET_SUPPORTED_HV_CPUID"
- "struct kvm_hyperv_exit" description in "5. The kvm_run structure"

The later should definitely get extended to cover XMM and I guess the
former can accomodate the 'no longer being tracked' comment. With that,
maybe there's no need for a new section? 

> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 3787d26810c1c..6a18c9f77d5fe 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -49,7 +49,7 @@
>  /* Support for physical CPU dynamic partitioning events is available*/
>  #define HV_X64_CPU_DYNAMIC_PARTITIONING_AVAILABLE	BIT(3)
>  /*
> - * Support for passing hypercall input parameter block via XMM
> + * Support for passing hypercall input and output parameter block via XMM
>   * registers is available
>   */
>  #define HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE		BIT(4)

This change of the comment is weird (or I may have forgotten something
important), could you please elaborate?. Currently, we have:

/*
 * Support for passing hypercall input parameter block via XMM
 * registers is available
 */
#define HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE         BIT(4)
...
/*
 * Support for returning hypercall output block via XMM
 * registers is available
 */
#define HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE                BIT(15)

which seems to be correct. TLFS also defines

Bit 4: XmmRegistersForFastHypercallAvailable

in CPUID 0x40000009.EDX (Nested Hypervisor Feature Identification) which
probably covers both but we don't set this leaf in KVM currently ...

> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 8a47f8541eab7..42f44546fe79c 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1865,6 +1865,7 @@ struct kvm_hv_hcall {
>  	u16 rep_idx;
>  	bool fast;
>  	bool rep;
> +	bool xmm_dirty;
>  	sse128_t xmm[HV_HYPERCALL_MAX_XMM_REGISTERS];
>  
>  	/*
> @@ -2396,9 +2397,49 @@ static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
>  	return ret;
>  }
>  
> +static void kvm_hv_write_xmm(struct kvm_hyperv_xmm_reg *xmm)
> +{
> +	int reg;
> +
> +	kvm_fpu_get();
> +	for (reg = 0; reg < HV_HYPERCALL_MAX_XMM_REGISTERS; reg++) {
> +		const sse128_t data = sse128(xmm[reg].low, xmm[reg].high);
> +		_kvm_write_sse_reg(reg, &data);
> +	}
> +	kvm_fpu_put();
> +}
> +
> +static bool kvm_hv_is_xmm_output_hcall(u16 code)
> +{
> +	return false;
> +}
> +
> +static bool kvm_hv_xmm_output_allowed(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
> +
> +	return !hv_vcpu->enforce_cpuid ||
> +	       hv_vcpu->cpuid_cache.features_edx &
> +		       HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE;
> +}
> +
>  static int kvm_hv_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
>  {
> -	return kvm_hv_hypercall_complete(vcpu, vcpu->run->hyperv.u.hcall.result);
> +	bool fast = !!(vcpu->run->hyperv.u.hcall.input & HV_HYPERCALL_FAST_BIT);
> +	u16 code = vcpu->run->hyperv.u.hcall.input & 0xffff;
> +	u64 result = vcpu->run->hyperv.u.hcall.result;
> +
> +	if (hv_result_success(result) && fast &&
> +	    kvm_hv_is_xmm_output_hcall(code)) {

Assuming hypercalls with XMM output are always 'fast', should we include
'fast' check in kvm_hv_is_xmm_output_hcall()?

> +		if (unlikely(!kvm_hv_xmm_output_allowed(vcpu))) {
> +			kvm_queue_exception(vcpu, UD_VECTOR);
> +			return 1;
> +		}
> +
> +		kvm_hv_write_xmm(vcpu->run->hyperv.u.hcall.xmm);
> +	}
> +
> +	return kvm_hv_hypercall_complete(vcpu, result);
>  }
>  
>  static u16 kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
> @@ -2553,6 +2594,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  	hc.rep_cnt = (hc.param >> HV_HYPERCALL_REP_COMP_OFFSET) & 0xfff;
>  	hc.rep_idx = (hc.param >> HV_HYPERCALL_REP_START_OFFSET) & 0xfff;
>  	hc.rep = !!(hc.rep_cnt || hc.rep_idx);
> +	hc.xmm_dirty = false;
>  
>  	trace_kvm_hv_hypercall(hc.code, hc.fast, hc.var_cnt, hc.rep_cnt,
>  			       hc.rep_idx, hc.ingpa, hc.outgpa);
> @@ -2673,6 +2715,15 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  		break;
>  	}
>  
> +	if (hv_result_success(ret) && hc.xmm_dirty) {
> +		if (unlikely(!kvm_hv_xmm_output_allowed(vcpu))) {
> +			kvm_queue_exception(vcpu, UD_VECTOR);
> +			return 1;
> +		}
> +
> +		kvm_hv_write_xmm((struct kvm_hyperv_xmm_reg *)hc.xmm);
> +	}
> +
>  hypercall_complete:
>  	return kvm_hv_hypercall_complete(vcpu, ret);
>  
> @@ -2682,6 +2733,8 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  	vcpu->run->hyperv.u.hcall.input = hc.param;
>  	vcpu->run->hyperv.u.hcall.params[0] = hc.ingpa;
>  	vcpu->run->hyperv.u.hcall.params[1] = hc.outgpa;
> +	if (hc.fast)
> +		memcpy(vcpu->run->hyperv.u.hcall.xmm, hc.xmm, sizeof(hc.xmm));
>  	vcpu->arch.complete_userspace_io = kvm_hv_hypercall_complete_userspace;
>  	return 0;
>  }
> @@ -2830,6 +2883,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  			ent->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
>  
>  			ent->edx |= HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE;
> +			ent->edx |= HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE;
>  			ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
>  			ent->edx |= HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
>  
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index d03842abae578..fbdee8d754595 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -90,6 +90,11 @@ struct kvm_pit_config {
>  
>  #define KVM_PIT_SPEAKER_DUMMY     1
>  
> +struct kvm_hyperv_xmm_reg {
> +	__u64 low;
> +	__u64 high;
> +};
> +
>  struct kvm_hyperv_exit {
>  #define KVM_EXIT_HYPERV_SYNIC          1
>  #define KVM_EXIT_HYPERV_HCALL          2
> @@ -108,6 +113,7 @@ struct kvm_hyperv_exit {
>  			__u64 input;
>  			__u64 result;
>  			__u64 params[2];
> +			struct kvm_hyperv_xmm_reg xmm[6];

In theory, we have HV_HYPERCALL_MAX_XMM_REGISTERS in TLFS (which you
already use in the code). While I'm not sure it makes sense to make KVM
ABI dependent on TLFS changes (probably not), we may want to leave a
short comment explaining where '6' comes from.

>  		} hcall;
>  		struct {
>  			__u32 msr;

-- 
Vitaly


