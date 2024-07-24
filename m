Return-Path: <linux-kernel+bounces-261343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC3A93B616
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B27CB2173F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4C715FD13;
	Wed, 24 Jul 2024 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4zNyIYR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC01BF38
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721842858; cv=none; b=IQQe4L1dT+lzqttuYp50TujjX6p/TDTicOvk17ZMxIW/vC6+ewbd4ajHAWdues/trxdX2sCMAAyutLqe0VOa36uSj7EILYcCx3YHn63jVDGuwwmQMnNI0yVSRgco9wdSkdAMJbz8n1HhJPufp71c5NsSf4BKJ5+WHQ8g/RDgdgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721842858; c=relaxed/simple;
	bh=OYhf9i9zA5SgHVdUG4+f7oWNo/fKoU8Py2NSvpMpCg0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ufbyQuMRglMHeOswDtyiljrsaHFfMhDhfSzE/TFQ3E+mwpD8etqVcj0pRjYNfymz2T9Njvn1pjtiOvPs3JtzCWtNvCcTUvJ1vIbMVEcS5KXsKHJFERuo2nqTmU34VNuB8Wx8xlPOz+hdZ8fk1B+I8QCN1jcYmLb4xjDxZhqyUAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4zNyIYR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721842855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owQmW2FeZvZ65U+s4o+FvJjOZqmyBhsCVfnDoijmjRA=;
	b=h4zNyIYRcySK1+g4WheKi6/KO+XFTv7ZR2BG5N9fxPGaK+tzU4AP7qsnUfKUJUTjBDzIND
	pwI9qgmk8wGKY9JalnNyzK2YekOXquuTq2MTbM3B+JknkwtKDlZs1X5BaCmIGaLTDAUPwK
	YIPD944dRVdpudKPoOmej1+ocgJWT3c=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-2mF8V7MqMmS9AEJUc7cyyA-1; Wed, 24 Jul 2024 13:40:54 -0400
X-MC-Unique: 2mF8V7MqMmS9AEJUc7cyyA-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5c65e857a32so71399eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721842854; x=1722447654;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=owQmW2FeZvZ65U+s4o+FvJjOZqmyBhsCVfnDoijmjRA=;
        b=gtPU4L4vzEnOOiYQdus0TT3HJPLYKddFVN6DEc6i/ZvywXOoXWE28OMjeKOtUxVeIH
         z/N5ZT2gBOFsYoW2y9MdLMMq2hDVT1KvdU31/1o2skDvIB0weamiPn27kjYzIqrZBAIb
         8EAeGov01z+MSWP8Jwp2rQtG+ACIVywocyMbh0DV65CLRxaMoID+RV6lvJvIOtCr9AGc
         uYiSFoaGRkU/0U+jA1L0qYu3EXtWL9AnT2oKU0n8Is6cgOGbgzm+wtaZQkbAtNIXmLPU
         bziJ+ZYSlXmwqjH4BpISwM+5U4mkO9erx5BSJN8UaV7ChzprtzptyNqmBuaobIBfqap6
         ZvsA==
X-Forwarded-Encrypted: i=1; AJvYcCVrH/wDPccysLkKTzEyDb+Hm55E+V4zH14vPJfWuV8bgczwTCZ3oULogzAgS98siC6ymUwohn++yXqTKFqSJ5xLmvbsS2Oe3Xe6HYCA
X-Gm-Message-State: AOJu0YwApfep2CLqZ6GFT3tc1hUGsBTyKgBAYV5tXOlPpizo8eYYQghQ
	UeAXbVNVf//w0BVqRhFJKpfvgTQSk0GDXcig1KUVfi3P/qJ4q2eB2eCnpWXMTtgO6liafVqH56d
	piSKo8C6wEEEmMGZVsVpc53nuQfEQGJ0tT5LE8Ezc8acDasYFFTX1zrFJ+/m/Eg==
X-Received: by 2002:a05:6359:4c1f:b0:1ac:65e7:9399 with SMTP id e5c5f4694b2df-1acf8a1406emr72921855d.9.1721842853811;
        Wed, 24 Jul 2024 10:40:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHep2kCnDTBvGNQu8jrzcXjMYD6HPrxfTzgyc4VtAPE3854fhISzuH2gLZrO+wCBXfMX9cTmA==
X-Received: by 2002:a05:6359:4c1f:b0:1ac:65e7:9399 with SMTP id e5c5f4694b2df-1acf8a1406emr72918355d.9.1721842853384;
        Wed, 24 Jul 2024 10:40:53 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19907507esm593718485a.108.2024.07.24.10.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:40:52 -0700 (PDT)
Message-ID: <3e17a33c59c6a57a836c92c1bddc9bd6d36cafca.camel@redhat.com>
Subject: Re: [PATCH v2 19/49] KVM: x86: Add a macro to init CPUID features
 that ignore host kernel support
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>,
 Oliver Upton <oliver.upton@linux.dev>, Binbin Wu
 <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Robert Hoo <robert.hoo.linux@gmail.com>
Date: Wed, 24 Jul 2024 13:40:51 -0400
In-Reply-To: <Zoxp4ahfifWA-P34@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-20-seanjc@google.com>
	 <2a4052ba67970ce41e79deb0a0931bb54e2c2a86.camel@redhat.com>
	 <Zoxp4ahfifWA-P34@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2024-07-08 at 15:36 -0700, Sean Christopherson wrote:
> On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> > On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> > > +/*
> > > + * Raw Feature - For features that KVM supports based purely on raw host CPUID,
> > > + * i.e. that KVM virtualizes even if the host kernel doesn't use the feature.
> > > + * Simply force set the feature in KVM's capabilities, raw CPUID support will
> > > + * be factored in by kvm_cpu_cap_mask().
> > > + */
> > > +#define RAW_F(name)						\
> > > +({								\
> > > +	kvm_cpu_cap_set(X86_FEATURE_##name);			\
> > > +	F(name);						\
> > > +})
> > > +
> > >  /*
> > >   * Magic value used by KVM when querying userspace-provided CPUID entries and
> > >   * doesn't care about the CPIUD index because the index of the function in
> > > @@ -682,15 +694,12 @@ void kvm_set_cpu_caps(void)
> > >  		F(AVX512VL));
> > >  
> > >  	kvm_cpu_cap_mask(CPUID_7_ECX,
> > > -		F(AVX512VBMI) | F(LA57) | F(PKU) | 0 /*OSPKE*/ | F(RDPID) |
> > > +		F(AVX512VBMI) | RAW_F(LA57) | F(PKU) | 0 /*OSPKE*/ | F(RDPID) |
> > >  		F(AVX512_VPOPCNTDQ) | F(UMIP) | F(AVX512_VBMI2) | F(GFNI) |
> > >  		F(VAES) | F(VPCLMULQDQ) | F(AVX512_VNNI) | F(AVX512_BITALG) |
> > >  		F(CLDEMOTE) | F(MOVDIRI) | F(MOVDIR64B) | 0 /*WAITPKG*/ |
> > >  		F(SGX_LC) | F(BUS_LOCK_DETECT)
> > >  	);
> > > -	/* Set LA57 based on hardware capability. */
> > > -	if (cpuid_ecx(7) & F(LA57))
> > > -		kvm_cpu_cap_set(X86_FEATURE_LA57);
> > >  
> > >  	/*
> > >  	 * PKU not yet implemented for shadow paging and requires OSPKE
> > 
> > Putting a function call into a macro which evaluates into a bitmask is somewhat misleading,
> > but let it be...
> 
> And weird.  Rather than abuse kvm_cpu_cap_set(), what about adding another variable
> scoped to kvm_cpu_cap_init()?
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 0e64a6332052..b8bc8713a0ec 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -87,12 +87,10 @@ u32 xstate_required_size(u64 xstate_bv, bool compacted)
>  /*
>   * Raw Feature - For features that KVM supports based purely on raw host CPUID,
>   * i.e. that KVM virtualizes even if the host kernel doesn't use the feature.
> - * Simply force set the feature in KVM's capabilities, raw CPUID support will
> - * be factored in by __kvm_cpu_cap_mask().
>   */
>  #define RAW_F(name)                                            \
>  ({                                                             \
> -       kvm_cpu_cap_set(X86_FEATURE_##name);                    \
> +       kvm_cpu_cap_passthrough |= F(name);                     \
>         F(name);                                                \
>  })
>  
> @@ -737,6 +735,7 @@ do {                                                                        \
>  do {                                                                   \
>         const struct cpuid_reg cpuid = x86_feature_cpuid(leaf * 32);    \
>         const u32 __maybe_unused kvm_cpu_cap_init_in_progress = leaf;   \
> +       u32 kvm_cpu_cap_passthrough = 0;                                \
>         u32 kvm_cpu_cap_emulated = 0;                                   \
>         u32 kvm_cpu_cap_synthesized = 0;                                \
>                                                                         \
> @@ -745,6 +744,7 @@ do {                                                                        \
>         else                                                            \
>                 kvm_cpu_caps[leaf] = (mask);                            \
>                                                                         \
> +       kvm_cpu_caps[leaf] |= kvm_cpu_cap_passthrough;                  \
>         kvm_cpu_caps[leaf] &= (raw_cpuid_get(cpuid) |                   \
>                                kvm_cpu_cap_synthesized);                \
>         kvm_cpu_caps[leaf] |= kvm_cpu_cap_emulated;                     \
> 

I agree, this is better.

Best regards,
	Maxim Levitsky




