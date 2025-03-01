Return-Path: <linux-kernel+bounces-539685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C098A4A75A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0F216A04F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113EF22318;
	Sat,  1 Mar 2025 01:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkN/2Stl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B73163A9
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740792235; cv=none; b=tRZlW3KBNZR3C6I018k+VCBBBzWWYCL99DD80GpMuGJ2d4MlsjafGDwwLWEFUbWYVinFrcZ3Xzy5RcEphWidnOCAEKajDFz/A9cQsNrjLZg5b3Q8h13wgrZL98SLtvmM8pjH7/pEulDMyJkYbxncthslt6zY5LjenIMAhUC/vxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740792235; c=relaxed/simple;
	bh=o1p+ne+HAvY4DDZ63M6vfhpNc3u5cYCy3IlSrcF7C2I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E5lMWqUwc2/Tm6/jPxmCHcfRb0z/snSGqBJ70oP7tZQkZWZaP3LnyFJeO51g3wNzwXgVqNOm/knaaiB+qXVdOA1kpnTXAKASHMSIFQh3j1DP+OIzzrhSjrSBlsgPVnYevn9W0UMBLUEUNK1i04ymFH6g30qg7bTrCukROK2FZgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkN/2Stl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740792232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8OAJrklYzp8/r3g4lixGYj7CZWiatxwAHqPRLaD3+jg=;
	b=CkN/2StlvJ8SJ7paAQakChOdKvQcNe4IJ6Stfe6FMg7Vj4xhMTxrBTWY7zYjI5WGVMeGR2
	43DZSn+i78/TCzKpGZ82zQLe6Xt4bPQcfEU7EJhg5pFgHe4hxoFGvF+QZWrL+GQKUGqNMS
	HpRjSCt58c2hrtZqVKF5hmq1ickecJY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-kWmq9q2nMZmvYMRLtw6hvQ-1; Fri, 28 Feb 2025 20:23:50 -0500
X-MC-Unique: kWmq9q2nMZmvYMRLtw6hvQ-1
X-Mimecast-MFC-AGG-ID: kWmq9q2nMZmvYMRLtw6hvQ_1740792230
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-471f1b00de4so56211081cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740792230; x=1741397030;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8OAJrklYzp8/r3g4lixGYj7CZWiatxwAHqPRLaD3+jg=;
        b=P19CZEW7/j64/ed59j+OewlQOZjlQVNvFjPphF0pb177FItoYIGeoJQk7ozy8HN1wG
         Yf/C/uWCJUcTgn8cLRiB8emFgcvnMI/zM0OJBfP5NxvQ8C3rNKt08qLuTjpyP9RzGeCU
         lwpN/Kt8oBqg0OeNIbfYPClPwj1Xf4mQof23tf0e+imbRd+7Eh1qIHnKRBBiJT9ZLxIX
         oymvA43oWTE6CUn7ZKAlAzNcoXWw2cQuqNCFukWFGzTT0l4ELse771QuUHnWnsexuEv4
         mbDZ4tF37jnNH6UZQZcnST7cm0FoPSJ/KEgDpUe+MG3CKxPkUz9z69YWAXRGLGMmFbgJ
         YWfg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/G4Xc1maTvbCMjdqowprc7VQU/gNLeD0TTWepf9AGCE+qACKjT9Zzem/wHUiG1hIZKSu7GPyXRNncDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YydkMJBDzyS840vC5PwELhnAigmJZ86M45RQuknn7Y1BeXmpG97
	K7CJN0hgdaWsrnokOWxS2EP2xueyVWJQXLFlcEPq3u4B765wnaAuwmlmFOt/46nka4Ng5B8QjKl
	RgpLYAtTd9DPeF4gIdcZ4B9yb28T7jsT48vfb9yPWP5PwhufntbMM25rFqN7TRw==
X-Gm-Gg: ASbGncsAodnfTMTT4m5jXcjJ/kphrvNTTh1mOcc4F3S2c+szIo7x9k6mZhOI/2b+kdk
	7XGVsgUpHiSdMLuXcmJERKlTHbGmp6TR3ZYZOcoDq/dAPmjO3XhiPmizd9DNLVcV8cKOz/FjAyP
	pdzR4gMw/B6AZ4vtxRRN0Y9lVDLoQh/Rg9pZWFGxZxy6kEIxNJfIsDzFWTuAE2BfWvRaxXlwUiD
	XXBOSJr2evfCU/gDbDFXzjyv/nFKFSjKOmEvw237gOSHnEGogdhn37KgQdppPFptTcuSMaPOQ+a
	VmKxDQohhcw1Mo8=
X-Received: by 2002:ad4:574c:0:b0:6e6:64e8:28e7 with SMTP id 6a1803df08f44-6e8a0d0895amr88661486d6.15.1740792230268;
        Fri, 28 Feb 2025 17:23:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqrmNkALLpnsrIVr0ZBViMhrVD8kVQJKE0j3X/XcwAt87q8J9yjv80JpSGnSy0+3KHJEeJbA==
X-Received: by 2002:ad4:574c:0:b0:6e6:64e8:28e7 with SMTP id 6a1803df08f44-6e8a0d0895amr88661316d6.15.1740792229955;
        Fri, 28 Feb 2025 17:23:49 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ccbefsm27878336d6.85.2025.02.28.17.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 17:23:49 -0800 (PST)
Message-ID: <7addde721e3f67bfa8ec5c9671f51d131f84bc6b.camel@redhat.com>
Subject: Re: [RFC PATCH 01/13] KVM: nSVM: Track the ASID per-VMCB
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>, Sean Christopherson
 <seanjc@google.com>,  Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 28 Feb 2025 20:23:48 -0500
In-Reply-To: <20250205182402.2147495-2-yosry.ahmed@linux.dev>
References: <20250205182402.2147495-1-yosry.ahmed@linux.dev>
	 <20250205182402.2147495-2-yosry.ahmed@linux.dev>
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
> The ASID is currently tracked per-vCPU, because the same ASID is used by
> L1 and L2. That ASID is flushed on every transition between L1 and L2.
> 
> Track the ASID separately for each VMCB (similar to the
> asid_generation), giving L2 a separate ASID. This is in preparation for
> doing fine-grained TLB flushes on nested transitions instead of
> unconditional full flushes.
> 
> The ASIDs are still not fully maintained (e.g. a remote flush will only
> flush the current ASID), so keep the TLB flush on every transition until
> this is sorted out.
> 
> L1's ASID will be flushed on KVM_REQ_TLB_FLUSH_GUEST if it is the
> active context, so remove the TODO in nested_svm_transition_tlb_flush()
> about it.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  arch/x86/kvm/svm/nested.c |  1 -
>  arch/x86/kvm/svm/sev.c    |  2 +-
>  arch/x86/kvm/svm/svm.c    | 12 +++++++-----
>  arch/x86/kvm/svm/svm.h    |  2 +-
>  4 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 04c375bf1ac2a..bbe4f3ac9f250 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -495,7 +495,6 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
>  	 *  - Honor L1's request to flush an ASID on nested VMRUN
>  	 *  - Sync nested NPT MMU on VMRUN that flushes L2's ASID[*]
>  	 *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
> -	 *  - Flush L1's ASID on KVM_REQ_TLB_FLUSH_GUEST
>  	 *
>  	 * [*] Unlike nested EPT, SVM's ASID management can invalidate nested
>  	 *     NPT guest-physical mappings on VMRUN.
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 799f8494b599c..b0adfd0537d00 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3468,7 +3468,7 @@ void pre_sev_run(struct vcpu_svm *svm, int cpu)
>  	unsigned int asid = sev_get_asid(svm->vcpu.kvm);
>  
>  	/* Assign the asid allocated with this SEV guest */
> -	svm->asid = asid;
> +	svm->current_vmcb->asid = asid;
>  
>  	/*
>  	 * Flush guest TLB:
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 7640a84e554a6..08340ae57777b 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1335,8 +1335,10 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
>  		save->g_pat = vcpu->arch.pat;
>  		save->cr3 = 0;
>  	}
> -	svm->current_vmcb->asid_generation = 0;
> -	svm->asid = 0;
> +	svm->vmcb01.asid_generation = 0;
> +	svm->vmcb01.asid = 0;
> +	svm->nested.vmcb02.asid_generation = 0;
> +	svm->nested.vmcb02.asid = 0;
>  
>  	svm->nested.vmcb12_gpa = INVALID_GPA;
>  	svm->nested.last_vmcb12_gpa = INVALID_GPA;
> @@ -1988,7 +1990,7 @@ static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
>  	}
>  
>  	svm->current_vmcb->asid_generation = sd->asid_generation;
> -	svm->asid = sd->next_asid++;
> +	svm->current_vmcb->asid = sd->next_asid++;
>  }
>  
>  static void svm_set_dr6(struct vcpu_svm *svm, unsigned long value)
> @@ -4235,8 +4237,8 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
>  
>  	sync_lapic_to_cr8(vcpu);
>  
> -	if (unlikely(svm->asid != svm->vmcb->control.asid)) {
> -		svm->vmcb->control.asid = svm->asid;
> +	if (unlikely(svm->current_vmcb->asid != svm->vmcb->control.asid)) {
> +		svm->vmcb->control.asid = svm->current_vmcb->asid;
>  		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
>  	}
>  	svm->vmcb->save.cr2 = vcpu->arch.cr2;
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 9d7cdb8fbf872..ebbb0b1a64676 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -133,6 +133,7 @@ struct kvm_vmcb_info {
>  	unsigned long pa;
>  	int cpu;
>  	uint64_t asid_generation;
> +	u32 asid;
>  };
>  
>  struct vmcb_save_area_cached {
> @@ -247,7 +248,6 @@ struct vcpu_svm {
>  	struct vmcb *vmcb;
>  	struct kvm_vmcb_info vmcb01;
>  	struct kvm_vmcb_info *current_vmcb;
> -	u32 asid;
>  	u32 sysenter_esp_hi;
>  	u32 sysenter_eip_hi;
>  	uint64_t tsc_aux;

Hi,


I think it should be possible to eliminate separate ASID field (current_vmcb->asid/svm->asid)
completely and instead just use the value stored in the vmcb.

When there is a need to update it, KVM can also set the corresponding dirty bit
as done in svm_vcpu_run (new_asid also already does this when the asid generation increases)

Also KVM already sets the tlb_ctl directly in the vmcb.

What do you think?

Best regards,
	Maxim Levitsky






