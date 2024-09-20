Return-Path: <linux-kernel+bounces-334002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841E697D144
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139BF1F23A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 06:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DDA3FB1B;
	Fri, 20 Sep 2024 06:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAINRAKN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3A3BB22
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726814395; cv=none; b=qMVf1BDZVZk7J/9/ERoyDJGR5Ns4avcCzdqMJqi3BC4WsMiiwkBfNC5WTP6+ex5XlwKm2YlwNPWujLp6L/tK9LK0cl/sUJHsyTdCt6Np9qoYB72hTns27OkuMZpEE/kLx7lgSBeXVjjcldYUi/xf/yW6abncwQfBDEiNIrNiPys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726814395; c=relaxed/simple;
	bh=VQebi6bHfucIPxSeioZteL269wIqQ2kSxJcg4ViSDgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nN8VKBSPfjQlm/kuBtEr++S4rWbTbiKrodu9C6O/Ifaru0/tSKFt1XtjD2KxAOPzePaX2OyjauN6eIcgAQIknpVAsh2VqGIEC/oucUDoNU3rsTsSAxa7caFzZEKyMox7qDcS7hHHz/rafmQFNfzFC9es6TxyGqe65MgriOUrOXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAINRAKN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726814392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TBTohzt93k/pWZ0gykhNCsmzYxdwEQp2uEI3E4E2c9E=;
	b=LAINRAKNN/nWG58TZyn/8wuvs6T/UiC7sWjms0UScY0jakUPM5/HWgO6rrt8gfBCm00cDo
	YsayIGpXITZQ4bc5y9llpwvCtTifDWPm7j64PQHJiaOnDd5hhD3RDWdl43e29mIdVIKplS
	7Gk9mn+2aQHzy3hhaCD61gSMubuyPIQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-JkXjslt2NXyh2vlbtFqKmQ-1; Fri, 20 Sep 2024 02:39:50 -0400
X-MC-Unique: JkXjslt2NXyh2vlbtFqKmQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3750b4feb9fso784153f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 23:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726814389; x=1727419189;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBTohzt93k/pWZ0gykhNCsmzYxdwEQp2uEI3E4E2c9E=;
        b=JMdLsBhbwPFKy2Am1RX8eYgcOu7bIltWZFX9rPE74etCLOpCSmHTiVgR4oV5pZYEDI
         eFWDnKXsSn9LUtRelbmoSqwPo4L7v0eSl5edgA3Gn4srQoKg3Hx0vAIx/kcW7mdjSM/k
         9dbwZ0xSEkqnLHNe1u8U8KiV/whpD0KsGuW3iPZG2k1PfdBHw4DvdBBcmIrReQ88mg1k
         JG2hWzA+YmoCDZl0Tvsxso4cHp24hJpPzVVH4qDPA+Q4TTZOMPyX1b0M/KJpG5xi67Q7
         6spltip/sHxDu6ByKRIsyWZ6JKYpqN9T4JOvknGk8Db0/xCZxvoka2nEx8kep49tKEpQ
         WD8g==
X-Forwarded-Encrypted: i=1; AJvYcCU+rk3mQecofnDM7SvzBI/cBTy4Daad5+YNmYbjF1Fvp0Gn7de75m6OI9WRQvmSSs2mRg7XVIXdulGl268=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKfgLGjOkERjQn/TeJAjM6ynmBtNYPdcScO0iSkCFnR4HLl1+N
	pDNumiF9hqPowya6ndDbaHvLCLCUyhNQusaVHDf7XwMK55jQAqTMX80RGW/6gSfNLgB8X9q1GHm
	hnvrP+gVfw7EQ04CtrKnQO8N+gM2kL5XmsBoAVUQVWdUOL/qkw59YCWI/JwDmqg==
X-Received: by 2002:a5d:59a7:0:b0:374:bcfe:e73 with SMTP id ffacd0b85a97d-37a4159acb4mr1162102f8f.28.1726814389482;
        Thu, 19 Sep 2024 23:39:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNuEOmvvlI6JB+HKX1XlBcDemyM8s/TOWb5uNYzbgvjt8YB27WYVLkE+t5zNEfo0/pu/qk2A==
X-Received: by 2002:a5d:59a7:0:b0:374:bcfe:e73 with SMTP id ffacd0b85a97d-37a4159acb4mr1162083f8f.28.1726814388959;
        Thu, 19 Sep 2024 23:39:48 -0700 (PDT)
Received: from [192.168.21.234] (85-124-1-52.static.upcbusiness.at. [85.124.1.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e78002afsm16854347f8f.75.2024.09.19.23.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 23:39:47 -0700 (PDT)
Message-ID: <4aad893a-f8ba-4b2e-bded-b01a35ec0a94@redhat.com>
Date: Fri, 20 Sep 2024 08:39:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Move set_pxd_safe() helpers from generic to platform
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240920053017.2514920-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240920053017.2514920-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.09.24 07:30, Anshuman Khandual wrote:
> set_pxd_safe() helpers that serve a specific purpose for both x86 and riscv
> platforms, do not need to be in the common memory code. Otherwise they just
> unnecessarily make the common API more complicated. This moves the helpers
> from common code to platform instead.
> 
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: x86@kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/riscv/include/asm/pgtable.h | 19 ++++++++++++++++
>   arch/x86/include/asm/pgtable.h   | 37 +++++++++++++++++++++++++++++++
>   include/linux/pgtable.h          | 38 --------------------------------
>   3 files changed, 56 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 089f3c9f56a3..39ca652c5ebe 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -957,6 +957,25 @@ void misc_mem_init(void);
>   extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>   #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
>   
> +/*
> + * Use set_p*_safe(), and elide TLB flushing, when confident that *no*
> + * TLB flush will be required as a result of the "set". For example, use
> + * in scenarios where it is known ahead of time that the routine is
> + * setting non-present entries, or re-setting an existing entry to the
> + * same value. Otherwise, use the typical "set" helpers and flush the
> + * TLB.
> + */
> +#define set_p4d_safe(p4dp, p4d) \
> +({ \
> +	WARN_ON_ONCE(p4d_present(*p4dp) && !p4d_same(*p4dp, p4d)); \
> +	set_p4d(p4dp, p4d); \
> +})
> +
> +#define set_pgd_safe(pgdp, pgd) \
> +({ \
> +	WARN_ON_ONCE(pgd_present(*pgdp) && !pgd_same(*pgdp, pgd)); \
> +	set_pgd(pgdp, pgd); \
> +})
>   #endif /* !__ASSEMBLY__ */
>   
>   #endif /* _ASM_RISCV_PGTABLE_H */
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index e39311a89bf4..fefb52bb6b4d 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1701,6 +1701,43 @@ bool arch_is_platform_page(u64 paddr);
>   #define arch_is_platform_page arch_is_platform_page
>   #endif
>   
> +/*
> + * Use set_p*_safe(), and elide TLB flushing, when confident that *no*
> + * TLB flush will be required as a result of the "set". For example, use
> + * in scenarios where it is known ahead of time that the routine is
> + * setting non-present entries, or re-setting an existing entry to the
> + * same value. Otherwise, use the typical "set" helpers and flush the
> + * TLB.
> + */
> +#define set_pte_safe(ptep, pte) \
> +({ \
> +	WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
> +	set_pte(ptep, pte); \
> +})
> +
> +#define set_pmd_safe(pmdp, pmd) \
> +({ \
> +	WARN_ON_ONCE(pmd_present(*pmdp) && !pmd_same(*pmdp, pmd)); \
> +	set_pmd(pmdp, pmd); \
> +})
> +
> +#define set_pud_safe(pudp, pud) \
> +({ \
> +	WARN_ON_ONCE(pud_present(*pudp) && !pud_same(*pudp, pud)); \
> +	set_pud(pudp, pud); \
> +})
> +
> +#define set_p4d_safe(p4dp, p4d) \
> +({ \
> +	WARN_ON_ONCE(p4d_present(*p4dp) && !p4d_same(*p4dp, p4d)); \
> +	set_p4d(p4dp, p4d); \
> +})
> +
> +#define set_pgd_safe(pgdp, pgd) \
> +({ \
> +	WARN_ON_ONCE(pgd_present(*pgdp) && !pgd_same(*pgdp, pgd)); \
> +	set_pgd(pgdp, pgd); \
> +})
>   #endif	/* __ASSEMBLY__ */

I'm wondering if we can completely get rid of these, for example via:

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index d8dbeac8b206..bc71c25930bb 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -79,10 +79,8 @@ DEFINE_POPULATE(pmd_populate_kernel, pmd, pte, init)
  static inline void set_##type1##_init(type1##_t *arg1,         \
                         type2##_t arg2, bool init)              \
  {                                                              \
-       if (init)                                               \
-               set_##type1##_safe(arg1, arg2);                 \
-       else                                                    \
-               set_##type1(arg1, arg2);                        \
+       WARN_ON_ONCE(init && ##type1##_present(*arg1) && !##type1##_same(*arg1, arg2)); \
+       set_##type1(arg1, arg2);                                \
  }
  

We might be able to handle the pgd_populate etc part similarly, possibly getting
rid of the pgd_populate_safe etc as well.

Assuming I don't miss anything important :)

Ideally, we get rid of the macros here and just use inline functions ...

-- 
Cheers,

David / dhildenb


