Return-Path: <linux-kernel+bounces-539698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085FDA4A787
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D456F16379A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0056A14B08A;
	Sat,  1 Mar 2025 01:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ct7rcUPZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD07182D7
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 01:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793064; cv=none; b=pFQJUQyORsXA85V+88sjuc3SVx1AJsYNaS66kQ+Kd5FAs/dK1xaAdIXW4M+YyGERNm8c3QOEaDMaeDs14WaP/S8f9iq1c0QTYHAmXOeP238W4MSsEDVFiSp33K6MG4jiJTJ1wCqRRf+ZqM4KVamGQMaeP4iBWd0TFRvu7kJVKuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793064; c=relaxed/simple;
	bh=qESiWLtNg8pNT3kw9CM9EvlGat+N9UabGQzZ8rlbcZ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QpyV29pG8zude9KBn/KaSQfCXVjaEzq3fAwqiz+GFkvkjeldaoKwbsvMUZU+FEinLm1d5XwRb6gLSGXydtruIUYJJYllwG1/xSMNiIoWBV3gCkjm2bNN21qQcHhPApNJM2iZwDgst1vP7UY5iS8Fqu4EiWVD2PNBkIbl5ohm5cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ct7rcUPZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740793061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbjFTBlv9o3OEhDfHME1jza4oVL1Cr86+PPTD5t1xQQ=;
	b=ct7rcUPZm23OmChXYdR0iY6Ii/4u4RHSt2zkRmPVei7nuKiVQEkm3eOeWd7kCXrG8YosZ4
	VwFyZhBRCHjtQDROt3SNk5pEg9HtAwwQ6vzot7wS4RqBz//aS5cv52YlgDUMfATPkVURQR
	otg2hssn1NWJJSr31xSlDis0MY56KSA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-AeCiADu5PIidPf_1Baz0Gg-1; Fri, 28 Feb 2025 20:37:39 -0500
X-MC-Unique: AeCiADu5PIidPf_1Baz0Gg-1
X-Mimecast-MFC-AGG-ID: AeCiADu5PIidPf_1Baz0Gg_1740793059
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8a1eb7148so27694656d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740793059; x=1741397859;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wbjFTBlv9o3OEhDfHME1jza4oVL1Cr86+PPTD5t1xQQ=;
        b=O3CxyGVD0ds/nzspmH/rtBVZ6UrPZlGCkFj3idRAI4CbDTVMpsfauDlbxHJRhGYg6g
         0AdzWqxnWPMtBWCrhr42pBsJ862EQyu/WeJg7llkZgyuWBsM+szrK66O8B6XsU+n0F8D
         K22xUha6vlcP8hNbtUkYGcCPlIDA/lv7DiRQtsbIRxs7cKEuAMRo7NnN8uYaEDPsXdKw
         EF4Dt6oy7DCEVUe6swJfpzPcQ87s6Vx4/5+B86o7PUGsNRIEy76/vv3fcEJcpJXhaQgJ
         0bbuSV+WN1Z8oe7NFvzLwbkThFEYt0vqNr20/dTjjajvLSxd5Z1ecRWzXxat1tX9yuTe
         nHJA==
X-Forwarded-Encrypted: i=1; AJvYcCVSsqO04L1QEiOD9MvmGu+WLhPXf6rE71RugwpBHnKzY3FWyt99u7n+KkCW+0p5d747kDIPfodFgsEsD/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13mDAUxOLW/8RwH72bXqDYqmucZJYIL1ub25gSsck5b9WZM8X
	B90CvFaigW48V6NzKXDqlzKLZecjHmr2xbFX6IGMjKONLyDnDf9m+ONs434jT8lQFWc4+JNdEtm
	KeTpjRHySpVYks27VThVo2W+50F1SxkiyCzGqWFTpd6DJASLSYPX/VL4DkYlxAA==
X-Gm-Gg: ASbGncuRipLnurssTyVVkmhgmVs+sYoO6RZT5+mWOwHQ81Nq+qynaDEfxciGd+ACKIF
	nHolsq/o3w/abXoV+VroLPS7u8o6n3ClVJB4aHJZxlG6lYeMNUCffihNEvErKDKHYuYrojQhsR5
	eM4iL4N2KSYSleKHXMNmaClPppK9Qun/zzC4uA00VDKx9bwBiWLtYWWI09PXrT4ZO8XaVFTtuUg
	odYfgSIuagYjNrw84oKuOp5LwyqV8t5sMYEzm/+O+Xrqjhs/5aEUOp6qTGfaUFGnOdZyn0Q0I40
	LT6OaOPIOPvSfYY=
X-Received: by 2002:a05:6214:2aad:b0:6e1:715f:cdf5 with SMTP id 6a1803df08f44-6e8a0d77582mr80862736d6.15.1740793059328;
        Fri, 28 Feb 2025 17:37:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/lGF35E66itIC4CFSpT1I377Q3SynkjXqLrgBB1/PVXtshkzQ3dnZsGHaeAFgJuaumO6MxQ==
X-Received: by 2002:a05:6214:2aad:b0:6e1:715f:cdf5 with SMTP id 6a1803df08f44-6e8a0d77582mr80862566d6.15.1740793058991;
        Fri, 28 Feb 2025 17:37:38 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976347acsm28205876d6.4.2025.02.28.17.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 17:37:38 -0800 (PST)
Message-ID: <974185d11c41c8019036e153e95a96e0c2712d6c.camel@redhat.com>
Subject: Re: [RFC PATCH 04/13] KVM: SVM: Introduce helpers for updating
 TLB_CONTROL
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>, Sean Christopherson
 <seanjc@google.com>,  Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 28 Feb 2025 20:37:37 -0500
In-Reply-To: <20250205182402.2147495-5-yosry.ahmed@linux.dev>
References: <20250205182402.2147495-1-yosry.ahmed@linux.dev>
	 <20250205182402.2147495-5-yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2025-02-05 at 18:23 +0000, Yosry Ahmed wrote:
> Introduce helpers for updating TLB_CONTROL in the VMCB instead of
> directly setting it. Two helpers are introduced:
> 
> - svm_add_tlb_ctl_flush(): Combines a new TLB_CONTROL value with the
>   existing one.
> 
> - svm_clear_tlb_ctl_flush(): Clears the TLB_CONTROL field.
> 
> The goal is to prevent overwriting a TLB_CONTROL value with something
> that results in less TLB entries being flushed. This does not currently
> happen as KVM only sets TLB_CONTROL_FLUSH_ASID when servicing a flush
> request, and TLB_CONTROL_FLUSH_ALL_ASID when allocating a new ASID. The
> latter always happens after the former so no unsafe overwrite happens.
> 
> However, future changes may result in subtle bugs where the TLB_CONTROL
> field is incorrectly overwritten. The new helpers prevent that.
> 
> A separate helper is used for clearing the TLB flush because it is
> semantically different. In this case, KVM knowingly ignores the existing
> value of TLB_CONTROL. Also, although svm_add_tlb_ctl_flush() would just
> work for TLB_CONTROL_DO_NOTHING, the logic becomes inconsistent (use the
> biggest hammer unless no hammer at all is requested).
> 
> Opportunistically move the TLB_CONTROL_* definitions to
> arch/x86/kvm/svm/svm.h as they are not used outside of
> arch/x86/kvm/svm/.
> 
> No functional change intended.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  arch/x86/include/asm/svm.h |  6 ------
>  arch/x86/kvm/svm/nested.c  |  2 +-
>  arch/x86/kvm/svm/sev.c     |  2 +-
>  arch/x86/kvm/svm/svm.c     |  6 +++---
>  arch/x86/kvm/svm/svm.h     | 29 +++++++++++++++++++++++++++++
>  5 files changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 2b59b9951c90e..e6bccf8f90982 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -169,12 +169,6 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
>  	};
>  };
>  
> -
> -#define TLB_CONTROL_DO_NOTHING 0
> -#define TLB_CONTROL_FLUSH_ALL_ASID 1
> -#define TLB_CONTROL_FLUSH_ASID 3
> -#define TLB_CONTROL_FLUSH_ASID_LOCAL 7
> -
>  #define V_TPR_MASK 0x0f
>  
>  #define V_IRQ_SHIFT 8
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 2eba36af44f22..0e9b0592c1f83 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -690,7 +690,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
>  	/* Done at vmrun: asid.  */
>  
>  	/* Also overwritten later if necessary.  */
> -	vmcb02->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
> +	svm_clear_tlb_ctl_flush(vmcb02);
>  
>  	/* nested_cr3.  */
>  	if (nested_npt_enabled(svm))
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index b0adfd0537d00..3af296d6c04f6 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3481,7 +3481,7 @@ void pre_sev_run(struct vcpu_svm *svm, int cpu)
>  		return;
>  
>  	sd->sev_vmcbs[asid] = svm->vmcb;
> -	svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
> +	svm_add_tlb_ctl_flush(svm->vmcb, TLB_CONTROL_FLUSH_ASID);
>  	vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
>  }
>  
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 2108b48ba4959..a2d601cd4c283 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1985,7 +1985,7 @@ static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
>  	if (sd->next_asid > sd->max_asid) {
>  		++sd->asid_generation;
>  		sd->next_asid = sd->min_asid;
> -		svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ALL_ASID;
> +		svm_add_tlb_ctl_flush(svm->vmcb, TLB_CONTROL_FLUSH_ALL_ASID);
>  		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
>  	}
>  
> @@ -3974,7 +3974,7 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu, struct kvm_vmcb_info *vmcb
>  	 * VM-Exit (via kvm_mmu_reset_context()).
>  	 */
>  	if (static_cpu_has(X86_FEATURE_FLUSHBYASID))
> -		vmcb->ptr->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
> +		svm_add_tlb_ctl_flush(vmcb->ptr, TLB_CONTROL_FLUSH_ASID);
>  	else
>  		vmcb->asid_generation--;
>  }
> @@ -4317,7 +4317,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
>  		svm->nested.nested_run_pending = 0;
>  	}
>  
> -	svm->vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
> +	svm_clear_tlb_ctl_flush(svm->vmcb);
>  	vmcb_mark_all_clean(svm->vmcb);
>  
>  	/* if exit due to PF check for async PF */
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index ebbb0b1a64676..6a73d6ed1e428 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -611,6 +611,35 @@ void svm_set_x2apic_msr_interception(struct vcpu_svm *svm, bool disable);
>  void svm_complete_interrupt_delivery(struct kvm_vcpu *vcpu, int delivery_mode,
>  				     int trig_mode, int vec);
>  
> +#define TLB_CONTROL_DO_NOTHING 0
> +#define TLB_CONTROL_FLUSH_ALL_ASID 1
> +#define TLB_CONTROL_FLUSH_ASID 3
> +#define TLB_CONTROL_FLUSH_ASID_LOCAL 7
> +
> +/*
> + * Clearing TLB flushes is done separately because combining
> + * TLB_CONTROL_DO_NOTHING with others is counter-intuitive.
> + */
> +static inline void svm_add_tlb_ctl_flush(struct vmcb *vmcb, u8 tlb_ctl)
> +{
> +	if (WARN_ON_ONCE(tlb_ctl == TLB_CONTROL_DO_NOTHING))
> +		return;
> +
> +	/*
> +	 * Apply the least targeted (most inclusive) TLB flush. Apart from
> +	 * TLB_CONTROL_DO_NOTHING, lower values of tlb_ctl are less targeted.
> +	 */
> +	if (vmcb->control.tlb_ctl == TLB_CONTROL_DO_NOTHING)
> +		vmcb->control.tlb_ctl = tlb_ctl;
> +	else
> +		vmcb->control.tlb_ctl = min(vmcb->control.tlb_ctl, tlb_ctl);
> +}
> +
> +static inline void svm_clear_tlb_ctl_flush(struct vmcb *vmcb)
> +{
> +	vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
> +}
> +
>  /* nested.c */
>  
>  #define NESTED_EXIT_HOST	0	/* Exit handled on host level */


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



