Return-Path: <linux-kernel+bounces-212300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF3F905E02
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34ADC284BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979AD12A16D;
	Wed, 12 Jun 2024 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fB8clxDM"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6230631A67
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 21:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718229185; cv=none; b=sT3E4btmb3Aqd36D07tBrHiP1G6j/EN4LC9Wr9LELlwU8yCtJp1zgBgmJHJPI6ujH1KPIr9kbr+Vh1VAukGzgjEdRuAY+2OwdKddBsxnKmFGomuwhkkgNiwfO8JT63YPb3k1UfBKOKjOq+Xmk76vBV7teZYtrjF1k4gkfSIcKA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718229185; c=relaxed/simple;
	bh=wusK4kc1FS+vHMjVpzL07yrjIW2g3Y3LcvsX2vuPaps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KGv2UpslBnfnWQKX5GFso+1AkvCJTQ8f/avMgV0v+IkugeIKcd/3o23juSvjS+oqJsEgF7fOUi9K5Z74ELXRxDHe9rodkSPJ0wOvJ9CYyWtginLu4HDmbZ79sATFM+ipNG7bOV6KE0Q38gl613/g853n7qVcAFXye2oxmXSmdk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fB8clxDM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c24109ad3fso235342a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718229183; x=1718833983; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xc5E1XEOoOO6m8at8GOziJ7pGWON/gur52mgUSEksH0=;
        b=fB8clxDMfQn1hS6Z2I1gxumHpNNQjaVGN3szaluSHppL6hXntf8uxhdY9Js8lzGccg
         ggTTh5Z1SsyDNOSmoGSmxBnNJ7RqDqJPK1LD7+6QT480YauemTIvdv4pgjpMoybFHuby
         jIsATDnv+s5qGaXHuD8ZLAX43k5JNhmEfJzUM1mCvIhBAOyY1rWbTaPKvm5XNxf5AU0E
         ZzCe1ivh/IQrQhiiQ0RqvMIZvDjDkoAMW3hgwyWOuFsz2E8VFIAbZJCvjEK8qBfIYc4H
         5UB94XtiRSqYWhJv6kMFgHQh6e/d2upyP2zj/BW+PzWk66CpJ5p+jF3Xu8FegBkuKfTB
         y5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718229183; x=1718833983;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xc5E1XEOoOO6m8at8GOziJ7pGWON/gur52mgUSEksH0=;
        b=L24c5M4OUuJ2iaOnlk4kqPDJK674noBlo/IZ3OBpBGU+kEthvbNfgM89x6f7fEileH
         /LBCgjqjF4COFNlMzZBFpZ37mOLrjknzHOeDtzRKvs48SW6NQ0MBqDCi/Vtn40UJvN41
         Bl3eaf9nUOWNMnga4/MpuJuwftqUSdMz7+VTerFHza6wXHWspt62HJq+vbEsQSNZXcys
         4AAE9cN7qRnDD8FxNsaDZfPQd2EFPf4Ep3wJBt11wtwvZ1+3XgzlaW2ryMEEfrjegQs6
         KvSSJHB5eY7kdBHOMZkvX6MezY0ymF/mzNu8YN4p8S/5THh7Q5DMN5qgeK5Pb7iHT1az
         pqDQ==
X-Gm-Message-State: AOJu0YzLYz3TFf3oxXK0QlAy0rkpikBROo4ciTVEjzbP1UhJfK4dyrRH
	guP+IHHvrUIXexD+qUowfanMLkBoLquYMkmMjYXWpvV7f69E5ZWhmvpsWrQK8NBip093BXqxm3u
	2cg==
X-Google-Smtp-Source: AGHT+IHbT5hnMTXfHXSrzZVzfM2ddDy1yTfVBw9Mcqt2XJ++35TEAMcRNhA5paiMB3+XTpPwciNXAbVip6c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:62c9:b0:2c2:c65f:52dc with SMTP id
 98e67ed59e1d1-2c4a770e8f6mr8577a91.6.1718229182634; Wed, 12 Jun 2024 14:53:02
 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:53:01 -0700
In-Reply-To: <20240207172646.3981-10-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-10-xin3.li@intel.com>
Message-ID: <ZmoYvcbFBPJ5ARma@google.com>
Subject: Re: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and guest
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin3.li@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, vkuznets@redhat.com, peterz@infradead.org, 
	ravi.v.shankar@intel.com, xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 07, 2024, Xin Li wrote:
> Switch MSR_IA32_FRED_RSP0 between host and guest in
> vmx_prepare_switch_to_{host,guest}().
> 
> MSR_IA32_FRED_RSP0 is used during ring 3 event delivery only, thus
> KVM, running on ring 0, can run safely with guest FRED RSP0, i.e.,
> no need to switch between host/guest FRED RSP0 during VM entry and
> exit.
> 
> KVM should switch to host FRED RSP0 before returning to user level,
> and switch to guest FRED RSP0 before entering guest mode.

Heh, if only KVM had a framework that was specifically designed for context
switching MSRs on return to userspace.  Translation: please use the user_return_msr()
APIs.

> Signed-off-by: Xin Li <xin3.li@intel.com>
> Tested-by: Shan Kang <shan.kang@intel.com>
> ---
> 
> Changes since v1:
> * Don't use guest_cpuid_has() in vmx_prepare_switch_to_{host,guest}(),
>   which are called from IRQ-disabled context (Chao Gao).
> * Reset msr_guest_fred_rsp0 in __vmx_vcpu_reset() (Chao Gao).
> ---
>  arch/x86/kvm/vmx/vmx.c | 17 +++++++++++++++++
>  arch/x86/kvm/vmx/vmx.h |  2 ++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index b7b772183ee4..264378c3b784 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1337,6 +1337,16 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
>  	}
>  
>  	wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
> +
> +	if (guest_can_use(vcpu, X86_FEATURE_FRED)) {
> +		/*
> +		 * MSR_IA32_FRED_RSP0 is top of task stack, which never changes.
> +		 * Thus it should be initialized only once.

Then grab the host value during vmx_hardware_setup().  And when you rebase on top
of the latest kvm-x86/next, there's a handy dandy "struct kvm_host_values kvm_host"
to track host MSR values (and similar state).

You could also use that for MSR_IA32_FRED_CONFIG and MSR_IA32_FRED_STKLVLS.

> +		 */
> +		if (unlikely(vmx->msr_host_fred_rsp0 == 0))
> +			vmx->msr_host_fred_rsp0 = read_msr(MSR_IA32_FRED_RSP0);
> +		wrmsrl(MSR_IA32_FRED_RSP0, vmx->msr_guest_fred_rsp0);
> +	}
>  #else
>  	savesegment(fs, fs_sel);
>  	savesegment(gs, gs_sel);
> @@ -1381,6 +1391,11 @@ static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
>  	invalidate_tss_limit();
>  #ifdef CONFIG_X86_64
>  	wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_host_kernel_gs_base);
> +
> +	if (guest_can_use(&vmx->vcpu, X86_FEATURE_FRED)) {
> +		vmx->msr_guest_fred_rsp0 = read_msr(MSR_IA32_FRED_RSP0);
> +		wrmsrl(MSR_IA32_FRED_RSP0, vmx->msr_host_fred_rsp0);
> +	}
>  #endif
>  	load_fixmap_gdt(raw_smp_processor_id());
>  	vmx->guest_state_loaded = false;
> @@ -4889,6 +4904,8 @@ static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
>  
>  #ifdef CONFIG_X86_64
>  	if (kvm_cpu_cap_has(X86_FEATURE_FRED)) {
> +		vmx->msr_guest_fred_rsp0 = 0;

Eh, I wouldn't bother.  Arguably it's better to use __kvm_set_msr(), and "vmx"
is zero-allocated so this is unnecessary.

The GUEST_IA32_FRED_* VMCS fields need to be explicitly initialized because the
VMCS could (very theoretically) use a non-zero-based encoding scheme.

