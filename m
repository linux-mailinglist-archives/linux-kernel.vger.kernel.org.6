Return-Path: <linux-kernel+bounces-319333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F69796FB3A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0950028B361
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6A013D248;
	Fri,  6 Sep 2024 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpfFbUgG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181751B85E9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725647453; cv=none; b=ssJqVSTm/d9zti/sPltVJG/aWRMvye7GcGBNYqtZ5n7jkDUdWZC23AFJYo1AYM2BHdNnGhUhYLiyktWgpjiV4Sai7tn+4NZwZtTe17SuV5G3RSzmiWWj8FNnQe5VwqZ0FTUsI29ujezxTzKpGCOO9W94oh40bhtvqnsp/z2qzuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725647453; c=relaxed/simple;
	bh=dvOZjNx1hVYWt4zDsuRPH25ttEwhM4CAQUgxQr2BXgU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hA5LjEUIoXsM6+C8C9ou3+CXV9dToGaA6+w38ybKVAyu1ynO5/3Ow3UvvmIhWdzUB9KyAPizgTE554UfkovPdcH3/xzq9tgkfYz4os2Xcv/UApN2e3f06IwjXX1kLA/PyeHCLxi51psQFaNj/7MYDwKXabBLi5vTzT1aEfH0OZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpfFbUgG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725647448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+cTLp246SuoH0cstCTboZcCOT7Xg05JX2fW0gtMBz8=;
	b=fpfFbUgGTxIzcOHC3pNmyZpLnYGgLgfeK/+bICrbxV7/gdLMkMfjGeqBKyvKInROHUuhvg
	UEH1Ot9z7tBii2FKdRIkiwXRuHpVNCNloBrFvjPL3QRQ8yGcwnhmXE5rbMQTAnKicvRWZa
	MtkjgWr1pJWT+aYzez/H/LpS0VpSVFc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-ZPSxSBD4OZCKMNdmZHJp3w-1; Fri, 06 Sep 2024 14:30:47 -0400
X-MC-Unique: ZPSxSBD4OZCKMNdmZHJp3w-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-45680f90e56so35417421cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 11:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725647447; x=1726252247;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+cTLp246SuoH0cstCTboZcCOT7Xg05JX2fW0gtMBz8=;
        b=HvE5rXMF4xf/WujZI/axLM2sabEI5+T3AG68o6vmNjnqIBgbdEBOzZZHAKK8xRdPTY
         w90jKvR+eSLZRVdFBH6bAnQ1/UxWoPEesvBV5x/sDR1H1rYqodOT/W86FppKpbxTtLLb
         aPTp1d+9VgxfU1boNMBnfBUWuE6pO7WfAUyU7E+M2qL3UdzqEkRshUy2Fx6PRzFjbBrR
         2STFCLGYuxBIAUUjtXO3LPtsCBO99AsuqdNUJmXwg8aOxmbXxtK9XNCmDgAJpJvrOkGn
         6xPrKbGl63m3kl6CQd1TIj0xYFGRw9BY0RBzibaXywgtytE8+lFHUP0r4N/VcFu3IMuH
         byIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4/qt4LmHmuhnkFpKBi2rMaLAmLs4j/fDgiZqrs9Y3m/yUhajgEFUCa8e/XFMmVaZNo2l9qNZSlMoOje8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo9LGTTzMdyt8Xt9dYutnRMTSGrjuCg8iGwjrQA0TGq1HjSiAn
	ivJ9rPz2h0+1JuQUHIMyeixqiy1Z1Qblwv4OrTSsAxuRwvFagJi6pZAmJtbflgUDn8zLhIqHEaG
	vU0XtoHL88TK4ugM6ru1f0x2dcCjnpX7kINLrCRTGLSfETSB252IESVkb1bG+iw==
X-Received: by 2002:ac8:5792:0:b0:456:80dd:2b74 with SMTP id d75a77b69052e-4580c67ed7amr46075111cf.2.1725647447094;
        Fri, 06 Sep 2024 11:30:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHltzXqVLPRMAahgW6J8x8ctvNe6U8FdCVTEJ9rfrauTjIAsn/Z8IGYg5bv9hsI+m1WEJm86A==
X-Received: by 2002:ac8:5792:0:b0:456:80dd:2b74 with SMTP id d75a77b69052e-4580c67ed7amr46074631cf.2.1725647446362;
        Fri, 06 Sep 2024 11:30:46 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:760d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b37007sm18444611cf.39.2024.09.06.11.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:30:46 -0700 (PDT)
Message-ID: <db41b66ffe19134ee2c742420b5637a2a531ffc3.camel@redhat.com>
Subject: Re: [PATCH] KVM: x86: Forcibly leave nested if RSM to L2 hits
 shutdown
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+988d9efcdf137bc05f66@syzkaller.appspotmail.com, Zheyu Ma
	 <zheyuma97@gmail.com>, Kishen Maloor <kishen.maloor@intel.com>
Date: Fri, 06 Sep 2024 14:30:45 -0400
In-Reply-To: <20240906161337.1118412-1-seanjc@google.com>
References: <20240906161337.1118412-1-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-09-06 at 09:13 -0700, Sean Christopherson wrote:
> Leave nested mode before synthesizing shutdown (a.k.a. TRIPLE_FAULT) if
> RSM fails when resuming L2 (a.k.a. guest mode).  Architecturally, shutdown
> on RSM occurs _before_ the transition back to guest mode on both Intel and
> AMD.
> 
> On Intel, per the SDM pseudocode, SMRAM state is loaded before critical
> VMX state:
> 
>   restore state normally from SMRAM;
>   ...
>   CR4.VMXE := value stored internally;
>   IF internal storage indicates that the logical processor had been in
>      VMX operation (root or non-root)
>   THEN
>      enter VMX operation (root or non-root);
>      restore VMX-critical state as defined in Section 32.14.1;
>      ...
>      restore current VMCS pointer;
>   FI;
> 
> AMD's APM is both less clearcut and more explicit.  Because AMD CPUs save
> VMCB and guest state in SMRAM itself, given the lack of anything in the
> APM to indicate a shutdown in guest mode is possible, a straightforward
> reading of the clause on invalid state is that _what_ state is invalid is
> irrelevant, i.e. all roads lead to shutdown.
> 
>   An RSM causes a processor shutdown if an invalid-state condition is
>   found in the SMRAM state-save area.
> 
> This fixes a bug found by syzkaller where synthesizing shutdown for L2
> led to a nested VM-Exit (if L1 is intercepting shutdown), which in turn
> caused KVM to complain about trying to cancel a nested VM-Enter (see
> commit 759cbd59674a ("KVM: x86: nSVM/nVMX: set nested_run_pending on VM
> entry which is a result of RSM").
> 
> Note, Paolo pointed out that KVM shouldn't set nested_run_pending until
> after loading SMRAM state.  But as above, that's only half the story, KVM
> shouldn't transition to guest mode either.  Unfortunately, fixing that
> mess requires rewriting the nVMX and nSVM RSM flows to not piggyback
> their nested VM-Enter flows, as executing the nested VM-Enter flows after
> loading state from SMRAM would clobber much of said state.
> 
> For now, add a FIXME to call out that transitioning to guest mode before
> loading state from SMRAM is wrong.
> 
> Link: https://lore.kernel.org/all/CABgObfYaUHXyRmsmg8UjRomnpQ0Jnaog9-L2gMjsjkqChjDYUQ@mail.gmail.com
> Reported-by: syzbot+988d9efcdf137bc05f66@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/0000000000007a9acb06151e1670@google.com
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Closes: https://lore.kernel.org/all/CAMhUBjmXMYsEoVYw_M8hSZjBMHh24i88QYm-RY6HDta5YZ7Wgw@mail.gmail.com
> Analyzed-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Cc: Kishen Maloor <kishen.maloor@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/smm.c | 24 +++++++++++++++++++-----
>  arch/x86/kvm/x86.c |  6 ------
>  arch/x86/kvm/x86.h |  6 ++++++
>  3 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
> index 00e3c27d2a87..85241c0c7f56 100644
> --- a/arch/x86/kvm/smm.c
> +++ b/arch/x86/kvm/smm.c
> @@ -624,17 +624,31 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
>  #endif
>  
>  	/*
> -	 * Give leave_smm() a chance to make ISA-specific changes to the vCPU
> -	 * state (e.g. enter guest mode) before loading state from the SMM
> -	 * state-save area.
> +	 * FIXME: When resuming L2 (a.k.a. guest mode), the transition to guest
> +	 * mode should happen _after_ loading state from SMRAM.  However, KVM
> +	 * piggybacks the nested VM-Enter flows (which is wrong for many other
> +	 * reasons), and so nSVM/nVMX would clobber state that is loaded from
> +	 * SMRAM and from the VMCS/VMCB.
>  	 */
>  	if (kvm_x86_call(leave_smm)(vcpu, &smram))
>  		return X86EMUL_UNHANDLEABLE;
>  
>  #ifdef CONFIG_X86_64
>  	if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
> -		return rsm_load_state_64(ctxt, &smram.smram64);
> +		ret = rsm_load_state_64(ctxt, &smram.smram64);
>  	else
>  #endif
> -		return rsm_load_state_32(ctxt, &smram.smram32);
> +		ret = rsm_load_state_32(ctxt, &smram.smram32);
> +
> +	/*
> +	 * If RSM fails and triggers shutdown, architecturally the shutdown
> +	 * occurs *before* the transition to guest mode.  But due to KVM's
> +	 * flawed handling of RSM to L2 (see above), the vCPU may already be
> +	 * in_guest_mode().  Force the vCPU out of guest mode before delivering
> +	 * the shutdown, so that L1 enters shutdown instead of seeing a VM-Exit
> +	 * that architecturally shouldn't be possible.
> +	 */
> +	if (ret != X86EMUL_CONTINUE && is_guest_mode(vcpu))
> +		kvm_leave_nested(vcpu);
> +	return ret;
>  }
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7aecf5b4c148..d00fd0d611bb 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -833,12 +833,6 @@ static void kvm_queue_exception_vmexit(struct kvm_vcpu *vcpu, unsigned int vecto
>  	ex->payload = payload;
>  }
>  
> -/* Forcibly leave the nested mode in cases like a vCPU reset */
> -static void kvm_leave_nested(struct kvm_vcpu *vcpu)
> -{
> -	kvm_x86_ops.nested_ops->leave_nested(vcpu);
> -}
> -
>  static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
>  		unsigned nr, bool has_error, u32 error_code,
>  	        bool has_payload, unsigned long payload, bool reinject)
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index bab6f9c4a790..a84c48ef5278 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -109,6 +109,12 @@ static inline unsigned int __shrink_ple_window(unsigned int val,
>  void kvm_service_local_tlb_flush_requests(struct kvm_vcpu *vcpu);
>  int kvm_check_nested_events(struct kvm_vcpu *vcpu);
>  
> +/* Forcibly leave the nested mode in cases like a vCPU reset */
> +static inline void kvm_leave_nested(struct kvm_vcpu *vcpu)
> +{
> +	kvm_x86_ops.nested_ops->leave_nested(vcpu);
> +}
> +
>  static inline bool kvm_vcpu_has_run(struct kvm_vcpu *vcpu)
>  {
>  	return vcpu->arch.last_vmentry_cpu != -1;
> 
> base-commit: 12680d7b8ac4db2eba6237a21a93d2b0e78a52a6

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky





