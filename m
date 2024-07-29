Return-Path: <linux-kernel+bounces-265845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F090D93F6B5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB2C1F22374
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB56149DFA;
	Mon, 29 Jul 2024 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0hkDigB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F45514534C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722259868; cv=none; b=p4znALx7cHFlL/DseikzboppdxlAvPJ0yyxTSUFQJ8i2PC8GhLycFAInTq6b9AXRqHfMZEfcxW1ViIjNLi4uFJDf9yIYq7CAXkyJhCDGEfJ9q1Ce4xJchwL7NMw6mpIf20Btf2urSiLfYE9+dhZdzUvREbwcDRMBeCSSOBSFN2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722259868; c=relaxed/simple;
	bh=XsHOodkGVugeYBKiy3NN35QUunVskHzFOlmmNRL11kM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AeFI7FuOdZxN6yekBgw4IJm4+jemwgnGPbHlDvAPC2lj3NJaZPzNcUgO+bsm2PPm1E72xJEKe3/MhGnYW7jnj62MweeWPml8PwrbehGJ3FfCcbQS070mMZJt9FqDZZRQJ5ncN/7Fp+eKFO1CrBT9njHtMOEZNvvGG8Kgsa07zck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0hkDigB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722259866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BlLuGikkUGKCvXsXriKTsyTsgVOTK7WyWyEUec7ttEo=;
	b=X0hkDigB4aMS00aS8tmZYH2LISya30UOR6AahRZgJvmK2sUxxgvgXgg7YuNqgE1Xz3/UAr
	lcoQ/Bjjgj2Hh0wPqp4AKj9vfJvlcuwkmIVC0/mUvRJRMe4g40OhrmhFaNmqPr/gVX05i5
	cyWlp8jOKxloqm9lRbWh3GAFQ1BKdCY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-XRtzAszOMwObE630tr-Zfw-1; Mon, 29 Jul 2024 09:31:03 -0400
X-MC-Unique: XRtzAszOMwObE630tr-Zfw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280291f739so17868295e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722259862; x=1722864662;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlLuGikkUGKCvXsXriKTsyTsgVOTK7WyWyEUec7ttEo=;
        b=jvc9EGbdeEOv3r/M9BUz1mN7ZasQG9BtQMtHiRHkSXQRl8DJPL4MMo0gjuKsDdBoT2
         KSyrvKEnyJE1pLumjjjt/LafWfFP/o90kO5wb+d87Z2BUD9b3wUa34NjOu8MV6SnmRTo
         jVLpFBegHdvmBiXHQxH6TZdPSZuANBYe18gIV4kJ0LW5SINDOO9jP2bup9/r6Zayw1u1
         oV4W5zciMATV6ZoGp3LNtisPJpAbSnfuA24xxqzYCyrG5oS9ijMggBz4CZaHoQYowLtc
         wMq7OaMnJVqojzO5jDWFNngSy+uWNnfMusTGUcBKnpF/qN8SaJiyGBMMtBMzHQlrTMNw
         r1IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUT8VskJb37+Nm38PDej8R/k6SAqyy55JVwNZiT2NunkzPKqFGwZ+Qwiw7D22kFP2s2ytlgZZO/W8I0/k2M6cvheREXLsdC59F8atn
X-Gm-Message-State: AOJu0Yw15LO9dWetgneKvNTulRWzZW8GTtaEyrE37ylKxivnxBQrN3Xo
	1wfDnU0P8+EKmjwkIylnUar5rlrV+OboiJ4jJJh8n7OvYzfOzYVOGFvn81IE49LDzTLZ4Pu8xaV
	PnKZ7lzYyYjMoiGvv0if8EdRvHKK4kzwM9N3HPtKqd3uXuMPK4MEMDUF2+ENmUE1+mGSJ1Hhs5H
	4Op0HvMFGsdmCEMpyBRGnP3mBDStN/2LLZGdQ7l0sz4y0fvg==
X-Received: by 2002:a05:600c:4b1a:b0:426:64f4:7793 with SMTP id 5b1f17b1804b1-42811da7dd3mr53752865e9.22.1722259862471;
        Mon, 29 Jul 2024 06:31:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMndcFYOEWtmUpK603jitEUzAiFadBmIa0FTnXJv33+nbkyn2Th00kSMWmDtDaf3Zoy7ZjjQ==
X-Received: by 2002:a05:600c:4b1a:b0:426:64f4:7793 with SMTP id 5b1f17b1804b1-42811da7dd3mr53752525e9.22.1722259861832;
        Mon, 29 Jul 2024 06:31:01 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36858148sm12306885f8f.72.2024.07.29.06.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 06:31:01 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Mirsad Todorovac <mtodorovac69@gmail.com>, Sean Christopherson
 <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [BUG] arch/x86/kvm/vmx/vmx_onhyperv.h:109:36: error:
 dereference of NULL =?utf-8?B?4oCYMOKAmQ==?=
In-Reply-To: <207a5c75-b6ad-4bfb-b436-07d4a3353003@gmail.com>
References: <b44227c5-5af6-4243-8ed9-2b8cdc0e5325@gmail.com>
 <Zpq2Lqd5nFnA0VO-@google.com>
 <207a5c75-b6ad-4bfb-b436-07d4a3353003@gmail.com>
Date: Mon, 29 Jul 2024 15:31:00 +0200
Message-ID: <87a5i05nqj.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirsad Todorovac <mtodorovac69@gmail.com> writes:

> On 7/19/24 20:53, Sean Christopherson wrote:
>> On Fri, Jul 19, 2024, Mirsad Todorovac wrote:
>>> Hi, all!
>>>
>>> Here is another potential NULL pointer dereference in kvm subsystem of linux
>>> stable vanilla 6.10, as GCC 12.3.0 complains.
>>>
>>> (Please don't throw stuff at me, I think this is the last one for today :-)
>>>
>>> arch/x86/include/asm/mshyperv.h
>>> -------------------------------
>>>   242 static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
>>>   243 {
>>>   244         if (!hv_vp_assist_page)
>>>   245                 return NULL;
>>>   246 
>>>   247         return hv_vp_assist_page[cpu];
>>>   248 }
>>>
>>> arch/x86/kvm/vmx/vmx_onhyperv.h
>>> -------------------------------
>>>   102 static inline void evmcs_load(u64 phys_addr)
>>>   103 {
>>>   104         struct hv_vp_assist_page *vp_ap =
>>>   105                 hv_get_vp_assist_page(smp_processor_id());
>>>   106 
>>>   107         if (current_evmcs->hv_enlightenments_control.nested_flush_hypercall)
>>>   108                 vp_ap->nested_control.features.directhypercall = 1;
>>>   109         vp_ap->current_nested_vmcs = phys_addr;
>>>   110         vp_ap->enlighten_vmentry = 1;
>>>   111 }
>>>

...

>
> GCC 12.3.0 appears unaware of this fact that evmcs_load() cannot be called with hv_vp_assist_page() == NULL.
>
> This, for example, silences the warning and also hardens the code against the "impossible" situations:
>
> -------------------><------------------------------------------------------------------
> diff --git a/arch/x86/kvm/vmx/vmx_onhyperv.h b/arch/x86/kvm/vmx/vmx_onhyperv.h
> index eb48153bfd73..8b0e3ffa7fc1 100644
> --- a/arch/x86/kvm/vmx/vmx_onhyperv.h
> +++ b/arch/x86/kvm/vmx/vmx_onhyperv.h
> @@ -104,6 +104,11 @@ static inline void evmcs_load(u64 phys_addr)
>         struct hv_vp_assist_page *vp_ap =
>                 hv_get_vp_assist_page(smp_processor_id());
>  
> +       if (!vp_ap) {
> +               pr_warn("BUG: hy_get_vp_assist_page(%d) returned NULL.\n", smp_processor_id());
> +               return;
> +       }
> +
>         if (current_evmcs->hv_enlightenments_control.nested_flush_hypercall)
>                 vp_ap->nested_control.features.directhypercall = 1;
>         vp_ap->current_nested_vmcs = phys_addr;

As Sean said, this does not seem to be possible today but I uderstand
why the compiler is not able to infer this. If we were to fix this, I'd
suggest we do something like "BUG_ON(!vp_ap)" (with a comment why)
instead of the suggested patch:
- pr_warn() is not ratelimited
- 'return' from evmcs_load does not propagate the error so the VM is
going to misbehave somewhere else.

-- 
Vitaly


