Return-Path: <linux-kernel+bounces-241800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2E8927FBD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4301A1C2151B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916231172C;
	Fri,  5 Jul 2024 01:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4lEObwB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3378B175BE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720142663; cv=none; b=BckYaTg3NdEJnXbnqOmZkPkajyX230VX1cjK6+r4P3OqlhV2gH/5+4Q6bVykCrANjmBIRQAkuA7AtJ9cBwol978IoraXXhVes7QyJ4GD/+zk4QgNriLVRfoInYzPrmCXc6jjB7xg0+sOnzfR51PXFtlBet2x7howrd3Q+oRRWGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720142663; c=relaxed/simple;
	bh=aLbzOgGM94M8i/WfxlL4RimNH/ID16I3FYwPJdxiSSw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ss7WVUEjt6JJbpfopM+79TrXkh8NOrkgc5ako3/LlGjMmsfYD5jRCKohZS9tGGBynsBsmiKa6BwLb/fVxYplM++2BkaqiWBbd4nJl4+gbzWoQFK/6+C0QKrQhDPG/wkFANTwkkMGVQF5QjvNBrrVhpS6dnSTGgdDv5Q2uoeFLFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4lEObwB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720142661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZLhzKcuP+gg065nEYjMsR+AcYMo96oe3zgwFjcHYSU=;
	b=E4lEObwBcSDtxMXDPDTNU1QO8eKLqynJn2dqb5Wt4r3cAFrt5kniVZSX6CdhhLzMBaWDHH
	ZHf5mJtCbyHalcv3YZf2R4sBV0o/zK1ROQCUgZKv2tJ4zdd9WnZ+MfBgZa1VLVfN+IaUVk
	SIXMk6+YT1DMkTVINK9Bg7lBd+lheh8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-SoTq1a7uNGCBEey6jyLTzQ-1; Thu, 04 Jul 2024 21:24:19 -0400
X-MC-Unique: SoTq1a7uNGCBEey6jyLTzQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b057a9690bso15164056d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 18:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720142659; x=1720747459;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZLhzKcuP+gg065nEYjMsR+AcYMo96oe3zgwFjcHYSU=;
        b=d6JPVgMLQWpLbLVNDBjlMVHH3SrOCnToTuB/3brpzAOCP9tYo+JZU7R5TogoXQcjOu
         L+NJQg3TozZY6BEJEOYvs9Cx01snXvfzMt0AhIs2I34FS7//2/ynXRzXzdxwA4Ah35rw
         IzFA84zCWFsAoLpTNTqin6PE0eaDO7bfF9AVanH4FsvkMbQ98LINil7aTOxahCF7ObL9
         arpahlybEmbkvCmx0ehcHX/zJYEms6YW8Y7/Q+aLI1WpaEBTQ0/V//xmQqCe8pUQ51YH
         ilewOd6qGm+jmz2PgoHlPLMOnvufaTzJ2zKRJXTnn+wwxyhWSwi1CP1WvuogVoeK4nWH
         F6+w==
X-Forwarded-Encrypted: i=1; AJvYcCWN3PQWvj4L7ENJcHGvBlRA+hV2upziyuNWZJl5GNYmYHBDSfgHR1RQjIjSrFKsGowQkzUm9ZqCl9ySDvPHBN+PPgJColIqyJSWOBQs
X-Gm-Message-State: AOJu0Yy0c+1UPAehq5Y7jdGm/RKKDDwBP9GDIPu2SuF8jFZvOEWIOGOA
	S1W3YrrGVD1Usn+U5Gq1jCEnIEtQDBBpiOaL3GAYeQrBqyfC2TZe8mHM3ZfAjeFMbUMQqeHe4Bq
	RvIXzmuuuRIxerLvS9ySFDVgfTpwmg8iFnCQPKzP1nR+c1ytswUM9JyQACEBong==
X-Received: by 2002:a05:6214:caf:b0:6b5:4573:4ac5 with SMTP id 6a1803df08f44-6b5ed09c5a3mr37786726d6.45.1720142659253;
        Thu, 04 Jul 2024 18:24:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ+R2wAP8LrTl4TfjZs1NRP7NYOoXTbvMuM/yBYbzgPdP+STLBHQsBY+mHo/82C6h213l/uQ==
X-Received: by 2002:a05:6214:caf:b0:6b5:4573:4ac5 with SMTP id 6a1803df08f44-6b5ed09c5a3mr37786516d6.45.1720142658854;
        Thu, 04 Jul 2024 18:24:18 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5d9b1001esm28565326d6.146.2024.07.04.18.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 18:24:18 -0700 (PDT)
Message-ID: <c8c88b6adaa5b5331bf336cfb2fe29f98f82c37e.camel@redhat.com>
Subject: Re: [PATCH v2 21/49] KVM: x86: Add a macro to init CPUID features
 that are 64-bit only
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 21:24:17 -0400
In-Reply-To: <20240517173926.965351-22-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-22-seanjc@google.com>
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
> Add a macro to mask-in feature flags that are supported only on 64-bit
> kernels/KVM.  In addition to reducing overall #ifdeffery, using a macro
> will allow hardening the kvm_cpu_cap initialization sequences to assert
> that the features being advertised are indeed included in the word being
> initialized.  And arguably using *F() macros through is more readable.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 5a4d6138c4f1..5e3b97d06374 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -70,6 +70,12 @@ u32 xstate_required_size(u64 xstate_bv, bool compacted)
>  	(boot_cpu_has(X86_FEATURE_##name) ? F(name) : 0);	\
>  })
>  
> +/* Features that KVM supports only on 64-bit kernels. */
> +#define X86_64_F(name)						\
> +({								\
> +	(IS_ENABLED(CONFIG_X86_64) ? F(name) : 0);		\
> +})
> +
>  /*
>   * Raw Feature - For features that KVM supports based purely on raw host CPUID,
>   * i.e. that KVM virtualizes even if the host kernel doesn't use the feature.
> @@ -639,15 +645,6 @@ static __always_inline void kvm_cpu_cap_init(enum cpuid_leafs leaf, u32 mask)
>  
>  void kvm_set_cpu_caps(void)
>  {
> -#ifdef CONFIG_X86_64
> -	unsigned int f_gbpages = F(GBPAGES);
> -	unsigned int f_lm = F(LM);
> -	unsigned int f_xfd = F(XFD);
> -#else
> -	unsigned int f_gbpages = 0;
> -	unsigned int f_lm = 0;
> -	unsigned int f_xfd = 0;
> -#endif
>  	memset(kvm_cpu_caps, 0, sizeof(kvm_cpu_caps));
>  
>  	BUILD_BUG_ON(sizeof(kvm_cpu_caps) - (NKVMCAPINTS * sizeof(*kvm_cpu_caps)) >
> @@ -744,7 +741,8 @@ void kvm_set_cpu_caps(void)
>  	);
>  
>  	kvm_cpu_cap_init(CPUID_D_1_EAX,
> -		F(XSAVEOPT) | F(XSAVEC) | F(XGETBV1) | F(XSAVES) | f_xfd
> +		F(XSAVEOPT) | F(XSAVEC) | F(XGETBV1) | F(XSAVES) |
> +		X86_64_F(XFD)
>  	);
>  
>  	kvm_cpu_cap_init_kvm_defined(CPUID_12_EAX,
> @@ -766,8 +764,8 @@ void kvm_set_cpu_caps(void)
>  		F(MTRR) | F(PGE) | F(MCA) | F(CMOV) |
>  		F(PAT) | F(PSE36) | 0 /* Reserved */ |
>  		F(NX) | 0 /* Reserved */ | F(MMXEXT) | F(MMX) |
> -		F(FXSR) | F(FXSR_OPT) | f_gbpages | F(RDTSCP) |
> -		0 /* Reserved */ | f_lm | F(3DNOWEXT) | F(3DNOW)
> +		F(FXSR) | F(FXSR_OPT) | X86_64_F(GBPAGES) | F(RDTSCP) |
> +		0 /* Reserved */ | X86_64_F(LM) | F(3DNOWEXT) | F(3DNOW)
>  	);
>  
>  	if (!tdp_enabled && IS_ENABLED(CONFIG_X86_64))

This is a good cleanup.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


