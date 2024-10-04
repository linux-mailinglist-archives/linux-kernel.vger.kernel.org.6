Return-Path: <linux-kernel+bounces-350061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B0D98FF3C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7711C21423
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBDA2421D;
	Fri,  4 Oct 2024 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoR167V7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79BB136345
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032556; cv=none; b=sxQjB7xpyIrCZ5iH7rNvf5fii33Wq14337t4JdBiWj1A9Qeie9wIcL5eTS6JuCSpB1+SMF2SyGHmFmk4jwEXLV/ERvfSPIxacdUqSlWvbblumdxRPmW6eiFxPAleGvroeSTmMR2ssf2hTsTN90GutzlqjoUAd6NVnJqrhlno9Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032556; c=relaxed/simple;
	bh=cvj/bbwL7wzGroTNguyDg1hkU9ArUlS5iQh7ZwpA5bA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H6bCJzy0aVAmdrynbbbHz6NnO3cAqEBeT1EN/M2vzWUwOnnIBSKGdvMudAEMEgnQ6kxeAx5wRCtwoJDUWj9o9L0O55hoMSuFnmdFfHoEvLBvpOq3axw6Jt7WossyIPPq4tvZrHVOf1ICXZYEzhbwgfBH4pqW7Wyf6RXJf2i51so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BoR167V7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728032553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EWV61+NjRLWN9h7jRFDU6mqmJ25L5jQ7Jfta7diEgeg=;
	b=BoR167V762zG+nZNF0yixrYPbhOkMbZaSUJOW8cr3YZSb8DSjJuJOXiiaIjBPZdEPBX3cQ
	/R8hQZMlqqFFUVWIyb093qDqltal4cjogihr4mf7ZePkEW1fKDa8zE5yNRSm/0vzAw9FQE
	beVikmu3Li8UYK02tPyJ15D34yAVzZY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-ZVYOhMBRO3mje_7w3Y-XYQ-1; Fri, 04 Oct 2024 05:02:32 -0400
X-MC-Unique: ZVYOhMBRO3mje_7w3Y-XYQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb6f3c476so14029155e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 02:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728032551; x=1728637351;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWV61+NjRLWN9h7jRFDU6mqmJ25L5jQ7Jfta7diEgeg=;
        b=i/+KQWEtWMcsvI0fIDDxRHMlwhf2RYjpBl1vgs/GwQQfUv5beyUPtvCBsRToU0dGI/
         GO44ZFoVGWw+7v/Jq/8mo3NLHfG0uv/EP0N4IdNXEEnjpC25avOmOazxQJgt0e15wYXn
         5qmlXy0OvrfmBu0v2YUUMESy4brbJjiicd11ACvp7t2QOGdjg0bE57gTcxz9gTo0tfk8
         lNHYM5Sj5q+05N8F8m7Fp5D6eL/qtFZkPjr2nSKgQyOfRnvz0pepGXJi4P/8g2Ptffg5
         9EOyTGJH80sXQ7bQVrwuQ3vERz1d2W1VT8kr4GgkCND/bArWMHvIlPvOoWIeUtARyQ/n
         M+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxNIKXAvvPqAsrcrdzxL7sgUFYouQcRALY+tsyZtOnSGZpRpFeod3IoEWBL1rxAixOC8HtaGVXw/JUZ04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO7ABgPFjs2ZDPMFnq6V8Wa5DPNwxDZj1f7Zkh+LW1d8jBCYZ2
	uTY9qap5q2Zr1E6cGMRpfvTXkB4IpMkDeov/lVm4qfnt3jBn/2GxqIgltAnL2POt+6DWhL0L2zs
	0WDH3N1dfQg61yOf9xFJ//Y82Q0VRAinuwdiW9BCNcyv6A1gNqOZ7YcONKrXpSt763NVGlvqHYu
	o8CrtJjoc58ZlJP7wAx2s8+Lva1Chi799tVD0Xubmzwnh23Q==
X-Received: by 2002:a05:600c:190b:b0:42f:80f4:ab2b with SMTP id 5b1f17b1804b1-42f85ab77admr13509735e9.19.1728032551341;
        Fri, 04 Oct 2024 02:02:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlsgXZOEZhhT2agJz2PyCQZK8FXrDwrnLcuhnP9smApMIRgbHENsTThEkN+2vw+ZCeMZxKbQ==
X-Received: by 2002:a05:600c:190b:b0:42f:80f4:ab2b with SMTP id 5b1f17b1804b1-42f85ab77admr13509445e9.19.1728032550809;
        Fri, 04 Oct 2024 02:02:30 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b444a4sm10247255e9.29.2024.10.04.02.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 02:02:30 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] KVM: selftests: Precisely mask off dynamic fields
 in CPUID test
In-Reply-To: <20241003234337.273364-3-seanjc@google.com>
References: <20241003234337.273364-1-seanjc@google.com>
 <20241003234337.273364-3-seanjc@google.com>
Date: Fri, 04 Oct 2024 11:02:29 +0200
Message-ID: <87setci6l6.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> When comparing vCPU CPUID entries against KVM's supported CPUID, mask off
> only the dynamic fields/bits instead of skipping the entire entry.
> Precisely masking bits isn't meaningfully more difficult than skipping
> entire entries, and will be necessary to maintain test coverage when a
> future commit enables OSXSAVE by default, i.e. makes one bit in all of
> CPUID.0x1 dynamic.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../testing/selftests/kvm/x86_64/cpuid_test.c | 61 +++++++++++--------
>  1 file changed, 36 insertions(+), 25 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/cpuid_test.c b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
> index fec03b11b059..f7fdcef5fa59 100644
> --- a/tools/testing/selftests/kvm/x86_64/cpuid_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
> @@ -12,17 +12,16 @@
>  #include "kvm_util.h"
>  #include "processor.h"
>  
> -/* CPUIDs known to differ */
> -struct {
> -	u32 function;
> -	u32 index;
> -} mangled_cpuids[] = {
> -	/*
> -	 * These entries depend on the vCPU's XCR0 register and IA32_XSS MSR,
> -	 * which are not controlled for by this test.
> -	 */
> -	{.function = 0xd, .index = 0},
> -	{.function = 0xd, .index = 1},
> +struct cpuid_mask {
> +	union {
> +		struct {
> +			u32 eax;
> +			u32 ebx;
> +			u32 ecx;
> +			u32 edx;
> +		};
> +		u32 regs[4];
> +	};
>  };
>  
>  static void test_guest_cpuids(struct kvm_cpuid2 *guest_cpuid)
> @@ -56,17 +55,23 @@ static void guest_main(struct kvm_cpuid2 *guest_cpuid)
>  	GUEST_DONE();
>  }
>  
> -static bool is_cpuid_mangled(const struct kvm_cpuid_entry2 *entrie)
> +static struct cpuid_mask get_const_cpuid_mask(const struct kvm_cpuid_entry2 *entry)
>  {
> -	int i;
> +	struct cpuid_mask mask;
>  
> -	for (i = 0; i < ARRAY_SIZE(mangled_cpuids); i++) {
> -		if (mangled_cpuids[i].function == entrie->function &&
> -		    mangled_cpuids[i].index == entrie->index)
> -			return true;
> +	memset(&mask, 0xff, sizeof(mask));
> +
> +	switch (entry->function) {
> +	case 0xd:
> +		/*
> +		 * CPUID.0xD.{0,1}.EBX enumerate XSAVE size based on the current
> +		 * XCR0 and IA32_XSS MSR values.
> +		 */
> +		if (entry->index < 2)
> +			mask.ebx = 0;
> +		break;
>  	}
> -
> -	return false;
> +	return mask;
>  }
>  
>  static void compare_cpuids(const struct kvm_cpuid2 *cpuid1,
> @@ -79,6 +84,8 @@ static void compare_cpuids(const struct kvm_cpuid2 *cpuid1,
>  		    "CPUID nent mismatch: %d vs. %d", cpuid1->nent, cpuid2->nent);
>  
>  	for (i = 0; i < cpuid1->nent; i++) {
> +		struct cpuid_mask mask;
> +
>  		e1 = &cpuid1->entries[i];
>  		e2 = &cpuid2->entries[i];
>  
> @@ -88,15 +95,19 @@ static void compare_cpuids(const struct kvm_cpuid2 *cpuid1,
>  			    i, e1->function, e1->index, e1->flags,
>  			    e2->function, e2->index, e2->flags);
>  
> -		if (is_cpuid_mangled(e1))
> -			continue;
> +		/* Mask off dynamic bits, e.g. OSXSAVE, when comparing entries. */
> +		mask = get_const_cpuid_mask(e1);
>  
> -		TEST_ASSERT(e1->eax == e2->eax && e1->ebx == e2->ebx &&
> -			    e1->ecx == e2->ecx && e1->edx == e2->edx,
> +		TEST_ASSERT((e1->eax & mask.eax) == (e2->eax & mask.eax) &&
> +			    (e1->ebx & mask.ebx) == (e2->ebx & mask.ebx) &&
> +			    (e1->ecx & mask.ecx) == (e2->ecx & mask.ecx) &&
> +			    (e1->edx & mask.edx) == (e2->edx & mask.edx),
>  			    "CPUID 0x%x.%x differ: 0x%x:0x%x:0x%x:0x%x vs 0x%x:0x%x:0x%x:0x%x",
>  			    e1->function, e1->index,
> -			    e1->eax, e1->ebx, e1->ecx, e1->edx,
> -			    e2->eax, e2->ebx, e2->ecx, e2->edx);
> +			    e1->eax & mask.eax, e1->ebx & mask.ebx,
> +			    e1->ecx & mask.ecx, e1->edx & mask.edx,
> +			    e2->eax & mask.eax, e2->ebx & mask.ebx,
> +			    e2->ecx & mask.ecx, e2->edx & mask.edx);
>  	}
>  }

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly


