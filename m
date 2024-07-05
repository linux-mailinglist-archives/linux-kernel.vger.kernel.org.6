Return-Path: <linux-kernel+bounces-241785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C02927F9F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF28B22D70
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDC7F9F7;
	Fri,  5 Jul 2024 01:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ck/Dmf94"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15403171AD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 01:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720142240; cv=none; b=q4yNNlnzJzOMJYwkCXNsRfxlOO1KooxVLKlZRHl+pbk/FJg7fdEBXsgUu3pnkqRu5hfZqdiYpdw+OQBT50Eq++ddpnfhQh4Foa3fmN4UJ5Svf9a6LBPLKH5HfYvMdJYH2tzNnjD0P74yM/Rx/KwoglXU0+mDhWu46eyzJG5uoG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720142240; c=relaxed/simple;
	bh=yb1R7584+mBxVugSncldycKDVGwmKrIXHVMigrsWGwc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nN0upexG1zX2ViG6H7E/3QTOjifpZr5HN7ZxezprHl4/DCpQcVFqQMmCnL+VedWGZCMoKmdtZfW6DaZ4OkcyqGnGFiDAfe20aHObH3bWFk6a0gyUrJgKiaGxrTRnItAQcuvKBJQoi3sPdHg9LJQrQR/aVibutI8ZmxPaRHhJXuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ck/Dmf94; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720142238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iD+wgKPvz6bmuy7K8MRQ025lb40rKGascQLOBBT4y5c=;
	b=ck/Dmf94RWiYbz4W+qvs8c5ly0Xm9vhx7dX6DBhVizs9Ijsn38WDxPToKU/904xNPIq8/o
	KyWcHDcIeQaaRmDauUKJAhTMKc4KVMcU/xEAmSb+xWrZG+br352z0hS63cHtkBwx0T6ImP
	mKsK+yoVuXD6qlG4wxXGZ71xJ1fTXTE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-osjpHfFdNMyhkQhpfDli1Q-1; Thu, 04 Jul 2024 21:17:16 -0400
X-MC-Unique: osjpHfFdNMyhkQhpfDli1Q-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-79d58cde738so130022585a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 18:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720142236; x=1720747036;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iD+wgKPvz6bmuy7K8MRQ025lb40rKGascQLOBBT4y5c=;
        b=uFPh7HhBwjmS9QKqo6PqZltExE/xzI0NxCyrxViUkqJyTHv2iyJ3iZNqsmrA0bCN2J
         lTR+zMz68hL+1thjfkBNGhm9Os00H/C7xZ0noYf4sMv0aH6jN1/7KjA43U2G9OlFyyK5
         dIGJhxIqqcL/47O/mAhSS0zZuI2tTwDDBAzNklCDq9Mdqp3dGvCZceKr/BzfrOOCLYzB
         SZWl/2QphX1hJ1YLQhf/KaImz9H+v4k6WKtGUbEFqElOo+BtKC1zqXECuri1Ap0bjJbc
         c2MUDqLCmNEsxDdrsiOPLzPe/3mnFlDHLxEa+NEjmCAzNiE7GPdfPWbNmes2nWnDE0Ui
         q7sg==
X-Forwarded-Encrypted: i=1; AJvYcCWBDP6o6PFVK2UUWx2i4QKE00uTyv3Gpy7dV8KLn3qXc/J6EDNTx4WnL0ZrfOXOVVmxdh4lf8LGH1FauvDj49BkfRi/e18RHZqBt03r
X-Gm-Message-State: AOJu0YywcGFox9Nbm+Dj1sI/2vY5/bBOFCok/nMiJXaSHsiE//tVFMYi
	4kKSRsXtsfJ3qBvkqD1FtZTI+72i4wF7FlM9twl3htCMg8QC6YuM3qvqtEQExU1L2phy259ucWh
	FN8VlkFUuFsEK04TmKqEfIU/fdwH9C3LLGoVYR8PNDWm0PMNW10M+w+ePDRuvdQ==
X-Received: by 2002:a05:6214:2427:b0:6b5:4b10:784c with SMTP id 6a1803df08f44-6b5ecf9d879mr39534636d6.9.1720142236312;
        Thu, 04 Jul 2024 18:17:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNVSdLo/Xk5JjKK5rsR0R0HZwYRhWR1QTyprLnv0SMW9lU8aN+wasSB2MfLImAJSeonW1mXw==
X-Received: by 2002:a05:6214:2427:b0:6b5:4b10:784c with SMTP id 6a1803df08f44-6b5ecf9d879mr39534486d6.9.1720142235918;
        Thu, 04 Jul 2024 18:17:15 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e562abasm68913526d6.33.2024.07.04.18.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 18:17:15 -0700 (PDT)
Message-ID: <5163b4408cf3bb2dc22904679c3bc64381869130.camel@redhat.com>
Subject: Re: [PATCH v2 12/49] KVM: x86: Reject disabling of MWAIT/HLT
 interception when not allowed
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 21:17:14 -0400
In-Reply-To: <20240517173926.965351-13-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-13-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> Reject KVM_CAP_X86_DISABLE_EXITS if userspace attempts to disable MWAIT or
> HLT exits and KVM previously reported (via KVM_CHECK_EXTENSION) that
> disabling the exit(s) is not allowed.  E.g. because MWAIT isn't supported
> or the CPU doesn't have an aways-running APIC timer, or because KVM is
> configured to mitigate cross-thread vulnerabilities.
> 
> Cc: Kechen Lu <kechenl@nvidia.com>
> Fixes: 4d5422cea3b6 ("KVM: X86: Provide a capability to disable MWAIT intercepts")
> Fixes: 6f0f2d5ef895 ("KVM: x86: Mitigate the cross-thread return address predictions bug")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/x86.c | 54 ++++++++++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 4cb0c150a2f8..c729227c6501 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4590,6 +4590,20 @@ static inline bool kvm_can_mwait_in_guest(void)
>  		boot_cpu_has(X86_FEATURE_ARAT);
>  }
>  
> +static u64 kvm_get_allowed_disable_exits(void)
> +{
> +	u64 r = KVM_X86_DISABLE_EXITS_PAUSE;
> +
> +	if (!mitigate_smt_rsb) {
> +		r |= KVM_X86_DISABLE_EXITS_HLT |
> +			KVM_X86_DISABLE_EXITS_CSTATE;
> +
> +		if (kvm_can_mwait_in_guest())
> +			r |= KVM_X86_DISABLE_EXITS_MWAIT;
> +	}
> +	return r;
> +}
> +
>  #ifdef CONFIG_KVM_HYPERV
>  static int kvm_ioctl_get_supported_hv_cpuid(struct kvm_vcpu *vcpu,
>  					    struct kvm_cpuid2 __user *cpuid_arg)
> @@ -4726,15 +4740,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  		r = KVM_CLOCK_VALID_FLAGS;
>  		break;
>  	case KVM_CAP_X86_DISABLE_EXITS:
> -		r = KVM_X86_DISABLE_EXITS_PAUSE;
> -
> -		if (!mitigate_smt_rsb) {
> -			r |= KVM_X86_DISABLE_EXITS_HLT |
> -			     KVM_X86_DISABLE_EXITS_CSTATE;
> -
> -			if (kvm_can_mwait_in_guest())
> -				r |= KVM_X86_DISABLE_EXITS_MWAIT;
> -		}
> +		r |= kvm_get_allowed_disable_exits();
>  		break;
>  	case KVM_CAP_X86_SMM:
>  		if (!IS_ENABLED(CONFIG_KVM_SMM))
> @@ -6565,33 +6571,29 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  		break;
>  	case KVM_CAP_X86_DISABLE_EXITS:
>  		r = -EINVAL;
> -		if (cap->args[0] & ~KVM_X86_DISABLE_VALID_EXITS)
> +		if (cap->args[0] & ~kvm_get_allowed_disable_exits())
>  			break;
>  
>  		mutex_lock(&kvm->lock);
>  		if (kvm->created_vcpus)
>  			goto disable_exits_unlock;
>  
> -		if (cap->args[0] & KVM_X86_DISABLE_EXITS_PAUSE)
> -			kvm->arch.pause_in_guest = true;
> -
>  #define SMT_RSB_MSG "This processor is affected by the Cross-Thread Return Predictions vulnerability. " \
>  		    "KVM_CAP_X86_DISABLE_EXITS should only be used with SMT disabled or trusted guests."
>  
> -		if (!mitigate_smt_rsb) {
> -			if (boot_cpu_has_bug(X86_BUG_SMT_RSB) && cpu_smt_possible() &&
> -			    (cap->args[0] & ~KVM_X86_DISABLE_EXITS_PAUSE))
> -				pr_warn_once(SMT_RSB_MSG);
> -
> -			if ((cap->args[0] & KVM_X86_DISABLE_EXITS_MWAIT) &&
> -			    kvm_can_mwait_in_guest())
> -				kvm->arch.mwait_in_guest = true;
> -			if (cap->args[0] & KVM_X86_DISABLE_EXITS_HLT)
> -				kvm->arch.hlt_in_guest = true;
> -			if (cap->args[0] & KVM_X86_DISABLE_EXITS_CSTATE)
> -				kvm->arch.cstate_in_guest = true;
> -		}
> +		if (!mitigate_smt_rsb && boot_cpu_has_bug(X86_BUG_SMT_RSB) &&
> +		    cpu_smt_possible() &&
> +		    (cap->args[0] & ~KVM_X86_DISABLE_EXITS_PAUSE))
> +			pr_warn_once(SMT_RSB_MSG);
>  
> +		if (cap->args[0] & KVM_X86_DISABLE_EXITS_PAUSE)
> +			kvm->arch.pause_in_guest = true;
> +		if (cap->args[0] & KVM_X86_DISABLE_EXITS_MWAIT)
> +			kvm->arch.mwait_in_guest = true;
> +		if (cap->args[0] & KVM_X86_DISABLE_EXITS_HLT)
> +			kvm->arch.hlt_in_guest = true;
> +		if (cap->args[0] & KVM_X86_DISABLE_EXITS_CSTATE)
> +			kvm->arch.cstate_in_guest = true;
>  		r = 0;
>  disable_exits_unlock:
>  		mutex_unlock(&kvm->lock);


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



