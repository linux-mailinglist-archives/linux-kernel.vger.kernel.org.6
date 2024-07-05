Return-Path: <linux-kernel+bounces-241864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A274F92806A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D74328161F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90CD17995;
	Fri,  5 Jul 2024 02:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="an/64KTL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A8219FC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720146378; cv=none; b=kNtxwam9pJu34fhldnsSJ7amuaVWuifk8nyvKeyEpOMht788K72T9VZg0e5wH13GYED5y85GZJoCLwgjE236ynQSdiOotx2NnsW8JtR5xdHRyyjGmqnfLBr39vqmnjFiM/OiEvHp5Ll4bGI7dvQCCP2EGnd6UmzMPsCbPJ/7EEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720146378; c=relaxed/simple;
	bh=VI6uYP43VrCE5BVgAqM1izsxwt2f74U2UGKYfXHejVo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fzPhavNe40h1Zo44BCnuxE8PyS9kLvMqyk3u3aRCSMYyTrAEKTOFw7VOlSf88+kfJoXunlUJQUp03NVYplhaUghYJ4RNNKBN44qrSsswNt/BaINYbrmoAGwpHrn1T+cJtE++0BJYcvWtgqPy0tTsvPkRxAHsnUbc7i7Zn7ow07U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=an/64KTL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720146375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7skmqPFDAkxHjvcg2f8mSug2SFsFPGybHobLUjeio4=;
	b=an/64KTL092zjXot5Wj7o5i8Yl9JVrKm7PXgn8ROs4pLraKI7lWJm8W6t5i/lFZLBfoNAq
	N6L6SsCC73ldLF/+AqKUrp9SOf/FoMQ81lcIqCm8wsNWg6JQj5iSmMVKyz1pX/ItcA+L2c
	IKD5hkBtV0CDdzSAPUSKti2kFnuOSlc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-ny9pwWNUMVerogt8xlozng-1; Thu, 04 Jul 2024 22:26:14 -0400
X-MC-Unique: ny9pwWNUMVerogt8xlozng-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b5f37aae55so5744096d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 19:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720146373; x=1720751173;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7skmqPFDAkxHjvcg2f8mSug2SFsFPGybHobLUjeio4=;
        b=fO6E8xrxdgQP4DseVA2KpNigfhtdw+JLgWkLt1U9SXxLUywLdK5ZzAmiPGIuYDELk1
         8LibTKN92Hsl1awUNhZKcsne/vdT9iHJKOTi6ZL5sxk1kT6599RHT3/KfARVDWQ13N+b
         iLwmU5n64n+DnrJ9rTxatcl0niPLiCRkVCmAthMBISyT6yKTo1Eska6B8WBvQ6fAZ+GA
         G1/GJt5/8ukji3Cl+UsJFerOJjUQSiM9yMh2kM7IW3dpt+vhB2rCRAVbws2kSd2b8Emp
         1ge0SLFDYiP49clvvR447Og32cn/aA2+3HCkX+0peEKrhjYwX6f9MCQkAWTrMXmAf9SY
         8zJA==
X-Forwarded-Encrypted: i=1; AJvYcCXZitbawgwZLrc3c2IFninpyla727xfV7gOh3rSG9ift5br3y26X1PJaOWpg8vAsCKXRb88Y1tbJl4ziR6ZJB7bGRIE18oLYcmeOg+H
X-Gm-Message-State: AOJu0YxJ9PAXYkyMWKLduJDGtSChyQKIKVWhWEazwErwsLOuDzPaq4NJ
	JIfIZAyCA5DEh7msC/mFMiUKuzTBEFGfnmNZ7zkOLxK0AF7HWuGaVu5+BS6OMFdksKLvhl9Qdno
	BmolZEYAJi7dICiajg1sBe8Qhi8FPlXO1omvGLZ+sTGkZBg02WeMMEqF+Q5m4ssTL9nvJlw==
X-Received: by 2002:a05:6214:19ca:b0:6b4:fc6f:17ba with SMTP id 6a1803df08f44-6b5ed1d7658mr43946176d6.33.1720146373671;
        Thu, 04 Jul 2024 19:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqI7IRFDsn77qjda0I38S1/gkfCdQdiN4hn+6CwUqbAFzPHngy7jEHUMC30UiL0vIeUWvCZA==
X-Received: by 2002:a05:6214:19ca:b0:6b4:fc6f:17ba with SMTP id 6a1803df08f44-6b5ed1d7658mr43946046d6.33.1720146373385;
        Thu, 04 Jul 2024 19:26:13 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5a705bc83sm65249216d6.131.2024.07.04.19.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 19:26:13 -0700 (PDT)
Message-ID: <eafcee4f973d3d76bb43c8ee8d59461a14574157.camel@redhat.com>
Subject: Re: [PATCH v2 45/49] KVM: x86: Shuffle code to prepare for dropping
 guest_cpuid_has()
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 22:26:12 -0400
In-Reply-To: <20240517173926.965351-46-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-46-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> Move the implementations of guest_has_{spec_ctrl,pred_cmd}_msr() down
> below guest_cpu_cap_has() so that their use of guest_cpuid_has() can be
> replaced with calls to guest_cpu_cap_has().
> 
> No functional change intended.
> 
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.h | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index 60da304db4e4..7be56fa62342 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -168,21 +168,6 @@ static inline int guest_cpuid_stepping(struct kvm_vcpu *vcpu)
>  	return x86_stepping(best->eax);
>  }
>  
> -static inline bool guest_has_spec_ctrl_msr(struct kvm_vcpu *vcpu)
> -{
> -	return (guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) ||
> -		guest_cpuid_has(vcpu, X86_FEATURE_AMD_STIBP) ||
> -		guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) ||
> -		guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD));
> -}
> -
> -static inline bool guest_has_pred_cmd_msr(struct kvm_vcpu *vcpu)
> -{
> -	return (guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) ||
> -		guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBPB) ||
> -		guest_cpuid_has(vcpu, X86_FEATURE_SBPB));
> -}
> -
>  static inline bool supports_cpuid_fault(struct kvm_vcpu *vcpu)
>  {
>  	return vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT;
> @@ -301,4 +286,19 @@ static inline bool kvm_vcpu_is_legal_cr3(struct kvm_vcpu *vcpu, unsigned long cr
>  	return kvm_vcpu_is_legal_gpa(vcpu, cr3);
>  }
>  
> +static inline bool guest_has_spec_ctrl_msr(struct kvm_vcpu *vcpu)
> +{
> +	return (guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) ||
> +		guest_cpuid_has(vcpu, X86_FEATURE_AMD_STIBP) ||
> +		guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) ||
> +		guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD));
> +}
> +
> +static inline bool guest_has_pred_cmd_msr(struct kvm_vcpu *vcpu)
> +{
> +	return (guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) ||
> +		guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBPB) ||
> +		guest_cpuid_has(vcpu, X86_FEATURE_SBPB));
> +}
> +
>  #endif

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


