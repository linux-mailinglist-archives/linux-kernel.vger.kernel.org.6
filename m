Return-Path: <linux-kernel+bounces-361950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E91F99AF48
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569BF1C2352F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8854D1E2821;
	Fri, 11 Oct 2024 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qm/KuQ8d"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DCE1D12F0
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688856; cv=none; b=PYoW1dp/b9kqD9/5DHWaYQWTyWF3rvhwWzTw9wv5Xq6Zyk+fD8xUMSPxM2wFTCvNUkZYYqIXvLWGgNZ1NuFhhasmz8LzXBg8sdrH3vksdsPRFUxHXDftkshkomCLd3zvfF7X7hLYG/BYMbu9eml4qq3zNzutaBWZWfTJH5KjEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688856; c=relaxed/simple;
	bh=MbAdx+mtP/JAUP/AgI9dJTIu78ff4Vht6ytXuf6CFRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PTLm7hgmEzR5Hv31cnpn7MTQd5wI/3GLm+iwOL2ohU3Gqqt5ON8lzPZ20cl9gjddfGcEcnHkoTlWfqa40+BLDHnwJpZVXHXoQPfBZ6WtUiTV31YjroYMKNa2aT6iM4P+QGLBZKNohdFchLY9D1KaBwwcM/fyLhOtNBAERyjwK/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qm/KuQ8d; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e315a5b199so44760227b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728688854; x=1729293654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YwGhlCRXhgYSAFXqwfoqXhd5rW/XunG1cue48PxDUZE=;
        b=Qm/KuQ8dghDOxRtusj+WV9qAaueFJvIQe7hR1TD5k1BC5QooEmXFA5ogPHHQW58nKd
         WyJvCKQpw7BmdBhGOPb3ilun/KapQembYyusjPta62mQ0rfXM8tH8S7O7+Gucoi5KwC5
         AhozVS0b2dSnJSukeNSgQGG+DbceLcLPamkPQhNC21OEQeJp2mVdyz28u8UwLXdawCpa
         dxfOpIza8/ganQG4ZS7SwL0UfYmuKaSdhIosMeFbCZmoxodt29d6MRR1MLbGDfb4g5ZE
         O79Ov6DDnsl8uAkB8SzedIwSeqIg5rNNAVttWuuYLePLJqZSLr4ZlQCIQDhelul8ZIAE
         ddpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728688854; x=1729293654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YwGhlCRXhgYSAFXqwfoqXhd5rW/XunG1cue48PxDUZE=;
        b=eSR2y9wHYPCyd0IzxacUzFqU79VIrig9aWZUo5YyZQ3LqC8nqRMTqIkYb09EoNk7k3
         bQR1bm+d8/RaCTBfOisnpP+txSdR+el5Qp7MibGje6qiDuBbgV8DJox4haaoYmGxigvl
         GQoz/EDsv9nClBpdeUeON+oJR/+R9cm0FPrcteodSnDGVg8L2tOXJsxnOF86SmdwE2rc
         SRPucA9izjYGnDIUb75j5F2ccDg+ODeQBvYkmoxB9pzwa3G+hj5J+U5mm7+MULeaqKG4
         1Vycc4/TyeajglR3Af6Rd5B0dSljGePtzkQ8R0Up6S0gMSCzg3aaDjTRITmxdVJjCDyK
         r22g==
X-Forwarded-Encrypted: i=1; AJvYcCWCpEeDVkyTLmkIo0WmXXJj4odCtVsAA39aUxrjYj71EM7sB08+Ob79tJFdkguAvqcy+wv5urchAb1p3Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6UagUf7hzkfdNJ4TIQrGV/OYaHOHmC9g9UrMgoEIm4I3LjnXe
	cxEAnCkVcFAoCd5rI51lX1BXC4F+edjmsBEZCa1p8UDBr6Mw9rUeDArDDF9+phc1G0uQC7RpYQa
	T5g==
X-Google-Smtp-Source: AGHT+IELihX6sWiwhxOnnagxVBxOHmb47dO+Atfy25px1Zypp6MSqk5ajFTu+RvkwVw1bBpbzuIuYM5SeAw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4d8a:b0:6b2:6cd4:7f9a with SMTP id
 00721157ae682-6e347c9a830mr1858947b3.8.1728688854038; Fri, 11 Oct 2024
 16:20:54 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:20:46 -0700
In-Reply-To: <20240927161657.68110-2-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240927161657.68110-1-iorlov@amazon.com> <20240927161657.68110-2-iorlov@amazon.com>
Message-ID: <Zwmyzg5WiKKvySS1@google.com>
Subject: Re: [PATCH 1/3] KVM: x86, vmx: Add function for event delivery error generation
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, jalliste@amazon.com, 
	nh-open-source@amazon.com, pdurrant@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

"KVM: VMX:" for the scope.  See "Shortlog" in Documentation/process/maintainer-kvm-x86.rst

On Fri, Sep 27, 2024, Ivan Orlov wrote:
> Extract KVM_INTERNAL_ERROR_DELIVERY_EV internal error generation into
> the SVM/VMX-agnostic 'kvm_prepare_ev_delivery_failure_exit' function, as
> it is done for KVM_INTERNAL_ERROR_EMULATION.

Use the changelog to provide a human readable summary of the change.  There are
definitely situations where calling out functions, variables, defines, etc. by
name is necessary, but this isn't one such situation.

> The order of internal.data array entries is preserved as is, so it is going
> to be the same on VMX platforms (vectoring info, full exit reason, exit
> qualification, GPA if error happened due to MMIO and last_vmentry_cpu of the
> vcpu).

Similar to the above, let the code speak.  The "No functional change intended"
makes it clear that the intent is to preserve the order and behavior.

> Having it as a separate function will help us to avoid code duplication

Avoid pronouns as much as possible, and no "we" or "us" as a hard rule.  E.g. this
can all be distilled down to:

--
Extract VMX's code for reporting an unhandleable VM-Exit during event
delivery to userspace, so that the boilerplate code can be shared by SVM.

No functional change intended.
--

> when handling the MMIO during event delivery error on SVM.
> 
> No functional change intended.
> 
> Signed-off-by: Ivan Orlov <iorlov@amazon.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 ++
>  arch/x86/kvm/vmx/vmx.c          | 15 +++------------
>  arch/x86/kvm/x86.c              | 22 ++++++++++++++++++++++
>  3 files changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 6d9f763a7bb9..348daba424dd 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2060,6 +2060,8 @@ void __kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu,
>  					  u64 *data, u8 ndata);
>  void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu);
>  
> +void kvm_prepare_ev_delivery_failure_exit(struct kvm_vcpu *vcpu, gpa_t gpa, bool is_mmio);

Please wrap at 80 columns.  While checkpatch doesn't complaing until 100, my
preference is to default to wrapping at 80, and poking past 80 only when it yields
more readable code (which is obviously subjective, but it shouldn't be too hard
to figure out KVM x86's preferred style).

>  void kvm_enable_efer_bits(u64);
>  bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
>  int kvm_get_msr_with_filter(struct kvm_vcpu *vcpu, u32 index, u64 *data);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index c67e448c6ebd..afd785e7f3a3 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6550,19 +6550,10 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>  	     exit_reason.basic != EXIT_REASON_APIC_ACCESS &&
>  	     exit_reason.basic != EXIT_REASON_TASK_SWITCH &&
>  	     exit_reason.basic != EXIT_REASON_NOTIFY)) {
> -		int ndata = 3;
> +		gpa_t gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
> +		bool is_mmio = exit_reason.basic == EXIT_REASON_EPT_MISCONFIG;

There's no need for is_mmio, just pass INVALID_GPA when the GPA isn't known.

> -		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> -		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_DELIVERY_EV;
> -		vcpu->run->internal.data[0] = vectoring_info;
> -		vcpu->run->internal.data[1] = exit_reason.full;
> -		vcpu->run->internal.data[2] = vmx_get_exit_qual(vcpu);
> -		if (exit_reason.basic == EXIT_REASON_EPT_MISCONFIG) {
> -			vcpu->run->internal.data[ndata++] =
> -				vmcs_read64(GUEST_PHYSICAL_ADDRESS);
> -		}
> -		vcpu->run->internal.data[ndata++] = vcpu->arch.last_vmentry_cpu;
> -		vcpu->run->internal.ndata = ndata;
> +		kvm_prepare_ev_delivery_failure_exit(vcpu, gpa, is_mmio);
>  		return 0;
>  	}
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 83fe0a78146f..8ee67fc23e5d 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8828,6 +8828,28 @@ void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu)
>  }
>  EXPORT_SYMBOL_GPL(kvm_prepare_emulation_failure_exit);
>  
> +void kvm_prepare_ev_delivery_failure_exit(struct kvm_vcpu *vcpu, gpa_t gpa, bool is_mmio)

Hmm, I don't love the name.  I really don't like that event is abbreviated, and
I suspect many readers will be misinterpret "event delivery failure" to mean that
_KVM_ failed to deliver an event.  Which is kinda sorta true, but it's more
accurate to say that the CPU triggered a VM-Exit when vectoring/delivery an event,
and KVM doesn't have code to robustly handle the situation.

Maybe kvm_prepare_event_vectoring_exit()?  Vectoring is quite specific in Intel
terminology.

> +{
> +	struct kvm_run *run = vcpu->run;
> +	int ndata = 0;
> +	u32 reason, intr_info, error_code;
> +	u64 info1, info2;

Reverse fir/x-mas tree for variables.  See "Coding Style" in
Documentation/process/maintainer-kvm-x86.rst (which will redirect you to
Documentation/process/maintainer-tip.rst, specifically "Variable declarations").

> +
> +	kvm_x86_call(get_exit_info)(vcpu, &reason, &info1, &info2, &intr_info, &error_code);

Wrap.  Though calling back into vendor code is silly.  Pass the necessary info
as parameters.  E.g. error_code and intr_info are unused, so the above is wasteful
and weird.

> +
> +	run->internal.data[ndata++] = info2;
> +	run->internal.data[ndata++] = reason;
> +	run->internal.data[ndata++] = info1;
> +	if (is_mmio)

And this is where keying off MMIO gets weird.

> +		run->internal.data[ndata++] = (u64)gpa;
> +	run->internal.data[ndata++] = vcpu->arch.last_vmentry_cpu;
> +
> +	run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> +	run->internal.suberror = KVM_INTERNAL_ERROR_DELIVERY_EV;
> +	run->internal.ndata = ndata;
> +}
> +EXPORT_SYMBOL_GPL(kvm_prepare_ev_delivery_failure_exit);
> +
>  static int handle_emulation_failure(struct kvm_vcpu *vcpu, int emulation_type)
>  {
>  	struct kvm *kvm = vcpu->kvm;
> -- 
> 2.43.0
> 

