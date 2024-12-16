Return-Path: <linux-kernel+bounces-447343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FE89F30E8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D916C165FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82454204F87;
	Mon, 16 Dec 2024 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GydS7UA8"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80B9204598
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353540; cv=none; b=fEc7jEnZ9VBAryjb/svv+BeR4YzSBpoIaFULZ2qnEOJ4RyTpOsHjbxyEW0e5KqEHNYmwmCPbBDrZfcU1dNH3XYXZBCbQpqFGXzSsD5cNWbk5hwkxsWY6ecnm359m5Wjs8Pb5PYIoDUFRJFfYb1nBTfSU4EaSz5x5znIPU7Qu19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353540; c=relaxed/simple;
	bh=MkC//mOOOK6k1rW/WC7sEW0EcIopJx7zRu+Qn7gyz6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSJGkNo6FfcbpURROp1W5WHHsDIJx+Axel+JKxBxSCklaqYZUqGKYVEXzU5/F+2JKfvlVW22/ZWezlpGZFL2yFVTw6lUs8ksITCpM3msY5TRhY4x1/4FRcrZCnvpvhwPXkRFakjUQIOSQItywYEjW0yZc5DfCpzoAIhKVghR05k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GydS7UA8; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-728eedfca37so4162090b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734353537; x=1734958337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jpVujSgfhyquRi3lcxkjWXtolDAfOmabfZbvo9rKQ0U=;
        b=GydS7UA8Qu6WEsesoUvdmSCpevpXWa67phkRZZFVbYxDO3wy6i6aY6Cn4ieuu6rdGr
         KWlEW2EYBvTIq8LhoQfci6JXL3pHIdfU/6gcDmZd2uxf6QmiWbafdX4ko3cLYs4BWvNX
         dK4hPGV/GcxybWm63lYBCOOYWtGGWB8yqL3hnadOvOAAMsQZlx6PE08ydeOWhjJeR7Hf
         mGhr8B/LWbSaNVfCZ0zd8XiHMkKtHOj16B5OIXLgiGFBzvhNap41OaKqfD7GxOX+D96P
         RHy7NaKjSZ1UootpxaejGT5Q5oDYloYS5L06nud37wuPsVREBGnDH5GjbCiqPa+i0kEG
         f9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734353537; x=1734958337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpVujSgfhyquRi3lcxkjWXtolDAfOmabfZbvo9rKQ0U=;
        b=mkOa+fT0pa19EK9gSiCDw6eEkAMZqS3VdRP6kji6pY4//fFioFVRClejEO+6e/8XIQ
         kaL6FZunM1JnvXmiLw0JX7AZm6JjljCv/UiYmr5C876bmbJ/X4IePWzCrRdIpnttNtPS
         TJsLn6ZOopfTX45B/f4DBTuWWHm3sxK56bMzzLTqxzDdfhRKxbAfsoAT/YX0ZiYdm4Y5
         5AI8Cz4ZRwjpw+0FlNkiiosdTgyENRPKC10Wr3wzf+QypmaNJx1f0QAbFBakk/3WEeMD
         MpKitCJDKLpzQ5PLESzKwHQy2q0tCw2GLb9RhGuVYUu6HSofKD+3mqPwUR/nT3MgNd3K
         LIxA==
X-Forwarded-Encrypted: i=1; AJvYcCV5ZI01oGO7o+d6gam0InnhmE9MOGRJs/dedBm0CNei1osHRhkswzZ/LYdH1SGtgYOtK+DT4Pgq7VRLe1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh/9yKP4sklP5VNSGhEk4PXjqns5I2VzxLtDH7hWj9a6fKDcYL
	a1tXgtWBYp7zWQPiH5L9n8m2uIuXDLJ0tPAnwrTyNJn0NJI1PxiAFsZ4R65l4gU=
X-Gm-Gg: ASbGncuDCuPfFubs5b75pemGdlQKy2S4UxVRntRtLiKZE1zh0PkWXOkHBOlNDLsMDRI
	JRFlJIRw23KsnLf4CDXopU9A/Y2ES+aH6W6g5dKnypqPtHmVsdVdwk915P66xlsU0JTS1nD5bPd
	Zq5Yogq1F/ppWfvlmr5+mLicdr8EYj6o/U6GVQlddmxdtmlpoEcOP2tDTj5X394/7v8r4+h2a1W
	1NrSC6aZN+VPpZp/Bw/EV200ZgxpWiOY2kzXEltdTkAj5/gMONXkcQFVyr5a+gUdZdXKjvEg6Ty
	LP0ILA==
X-Google-Smtp-Source: AGHT+IF2FtSfrsbSHuvFmynqJ3lzZ4Jsn1NnQA/IFgalSUJpQVUj9raH/YTN0GW/eEuhU/ngGHHeVw==
X-Received: by 2002:a05:6a00:4c83:b0:727:3b77:4174 with SMTP id d2e1a72fcca58-7290c27d95amr19398327b3a.23.1734353535280;
        Mon, 16 Dec 2024 04:52:15 -0800 (PST)
Received: from [10.4.194.102] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918af0caesm4666395b3a.86.2024.12.16.04.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 04:52:14 -0800 (PST)
Message-ID: <efc3f9c9-5040-44c1-82dd-59361281336c@bytedance.com>
Date: Mon, 16 Dec 2024 20:52:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] mm: pgtable: introduce generic __tlb_remove_table()
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
 <271e58cd4ab808c4f402539b76d5916924e2bc6f.1734164094.git.zhengqi.arch@bytedance.com>
 <20241216120043.GA11133@noisy.programming.kicks-ass.net>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20241216120043.GA11133@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/16 20:00, Peter Zijlstra wrote:
> On Sat, Dec 14, 2024 at 05:02:57PM +0800, Qi Zheng wrote:

[...]

>>   
>> +#ifndef __HAVE_ARCH_TLB_REMOVE_TABLE
>> +static inline void __tlb_remove_table(void *_table)
>> +{
>> +	struct ptdesc *ptdesc = (struct ptdesc *)_table;
>> +
>> +	pagetable_dtor(ptdesc);
>> +	pagetable_free(ptdesc);
>> +}
>> +#endif
> 
> 
> Spot the fail...
> 
> That said, all this ptdesc stuff is another giant trainwreck. Let me
> clean that up for you.

It looks like you want to revert what was done in this patch series:

https://lore.kernel.org/all/20230807230513.102486-1-vishal.moola@gmail.com/

But why? It seems that splitting ptdesc from struct page is a good
thing?

> 
> ---
> diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
> index ea4fbe7b17f6..ac3881ec342f 100644
> --- a/arch/arm/include/asm/tlb.h
> +++ b/arch/arm/include/asm/tlb.h
> @@ -32,8 +32,6 @@
>   static inline void
>   __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
>   {
> -	struct ptdesc *ptdesc = page_ptdesc(pte);
> -
>   #ifndef CONFIG_ARM_LPAE
>   	/*
>   	 * With the classic ARM MMU, a pte page has two corresponding pmd
> @@ -43,16 +41,14 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
>   	__tlb_adjust_range(tlb, addr - PAGE_SIZE, 2 * PAGE_SIZE);
>   #endif
>   
> -	tlb_remove_ptdesc(tlb, ptdesc);
> +	tlb_remove_table(tlb, pte);
>   }
>   
>   static inline void
>   __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
>   {
>   #ifdef CONFIG_ARM_LPAE
> -	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
> -
> -	tlb_remove_ptdesc(tlb, ptdesc);
> +	tlb_remove_table(tlb, virt_to_page(pmdp));
>   #endif
>   }
>   
> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> index 8d762607285c..4a60569fed69 100644
> --- a/arch/arm64/include/asm/tlb.h
> +++ b/arch/arm64/include/asm/tlb.h
> @@ -75,18 +75,14 @@ static inline void tlb_flush(struct mmu_gather *tlb)
>   static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
>   				  unsigned long addr)
>   {
> -	struct ptdesc *ptdesc = page_ptdesc(pte);
> -
> -	tlb_remove_ptdesc(tlb, ptdesc);
> +	tlb_remove_table(tlb, pte);
>   }
>   
>   #if CONFIG_PGTABLE_LEVELS > 2
>   static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
>   				  unsigned long addr)
>   {
> -	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
> -
> -	tlb_remove_ptdesc(tlb, ptdesc);
> +	tlb_remove_table(tlb, virt_to_page(pmdp));
>   }
>   #endif
>   
> @@ -94,12 +90,10 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
>   static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
>   				  unsigned long addr)
>   {
> -	struct ptdesc *ptdesc = virt_to_ptdesc(pudp);
> -
>   	if (!pgtable_l4_enabled())
>   		return;
>   
> -	tlb_remove_ptdesc(tlb, ptdesc);
> +	tlb_remove_table(tlb, virt_to_page(pudp));
>   }
>   #endif
>   
> @@ -107,12 +101,10 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
>   static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
>   				  unsigned long addr)
>   {
> -	struct ptdesc *ptdesc = virt_to_ptdesc(p4dp);
> -
>   	if (!pgtable_l5_enabled())
>   		return;
>   
> -	tlb_remove_ptdesc(tlb, ptdesc);
> +	tlb_remove_table(tlb, virt_to_page(p4dp));
>   }
>   #endif
>   
> diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
> index f1ce5b7b28f2..2c0897624699 100644
> --- a/arch/csky/include/asm/pgalloc.h
> +++ b/arch/csky/include/asm/pgalloc.h
> @@ -64,7 +64,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>   #define __pte_free_tlb(tlb, pte, address)		\
>   do {							\
>   	pagetable_dtor(page_ptdesc(pte));		\
> -	tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));	\
> +	tlb_remove_page(tlb, pte);			\
>   } while (0)
>   
>   extern void pagetable_init(void);
> diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
> index 40e42a0e7167..8b1550498f1b 100644
> --- a/arch/hexagon/include/asm/pgalloc.h
> +++ b/arch/hexagon/include/asm/pgalloc.h
> @@ -90,7 +90,7 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
>   #define __pte_free_tlb(tlb, pte, addr)				\
>   do {								\
>   	pagetable_dtor((page_ptdesc(pte)));			\
> -	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
> +	tlb_remove_page((tlb), (pte));				\
>   } while (0)
>   
>   #endif
> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
> index 7211dff8c969..5a4f22aeb618 100644
> --- a/arch/loongarch/include/asm/pgalloc.h
> +++ b/arch/loongarch/include/asm/pgalloc.h
> @@ -58,7 +58,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   #define __pte_free_tlb(tlb, pte, address)			\
>   do {								\
>   	pagetable_dtor(page_ptdesc(pte));			\
> -	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
> +	tlb_remove_page((tlb), (pte));				\
>   } while (0)
>   
>   #ifndef __PAGETABLE_PMD_FOLDED
> diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
> index 2b626cb3ad0a..63d9f95f5e3d 100644
> --- a/arch/m68k/include/asm/sun3_pgalloc.h
> +++ b/arch/m68k/include/asm/sun3_pgalloc.h
> @@ -20,7 +20,7 @@ extern const char bad_pmd_string[];
>   #define __pte_free_tlb(tlb, pte, addr)				\
>   do {								\
>   	pagetable_dtor(page_ptdesc(pte));			\
> -	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
> +	tlb_remove_page((tlb), (pte));				\
>   } while (0)
>   
>   static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
> diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
> index 36d9805033c4..bbee21345154 100644
> --- a/arch/mips/include/asm/pgalloc.h
> +++ b/arch/mips/include/asm/pgalloc.h
> @@ -57,7 +57,7 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>   #define __pte_free_tlb(tlb, pte, address)			\
>   do {								\
>   	pagetable_dtor(page_ptdesc(pte));			\
> -	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
> +	tlb_remove_page((tlb), (pte));				\
>   } while (0)
>   
>   #ifndef __PAGETABLE_PMD_FOLDED
> diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
> index 12a536b7bfbd..641cec8fb2a2 100644
> --- a/arch/nios2/include/asm/pgalloc.h
> +++ b/arch/nios2/include/asm/pgalloc.h
> @@ -31,7 +31,7 @@ extern pgd_t *pgd_alloc(struct mm_struct *mm);
>   #define __pte_free_tlb(tlb, pte, addr)					\
>   	do {								\
>   		pagetable_dtor(page_ptdesc(pte));			\
> -		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
> +		tlb_remove_page((tlb), (pte));				\
>   	} while (0)
>   
>   #endif /* _ASM_NIOS2_PGALLOC_H */
> diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
> index 596e2355824e..e9b9bc53ece0 100644
> --- a/arch/openrisc/include/asm/pgalloc.h
> +++ b/arch/openrisc/include/asm/pgalloc.h
> @@ -69,7 +69,7 @@ extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
>   #define __pte_free_tlb(tlb, pte, addr)				\
>   do {								\
>   	pagetable_dtor(page_ptdesc(pte));			\
> -	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
> +	tlb_remove_page((tlb), (pte));				\
>   } while (0)
>   
>   #endif
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index fc50d1401024..baedbd2546b9 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -26,13 +26,13 @@
>    * comment below 'ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE' in include/asm-generic/tlb.h
>    * for more details.
>    */
> -static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
> +static inline void riscv_tlb_remove_table(struct mmu_gather *tlb, void *pt)
>   {
>   	if (riscv_use_sbi_for_rfence()) {
> -		tlb_remove_ptdesc(tlb, pt);
> +		tlb_remove_table(tlb, pt);
>   	} else {
>   		pagetable_dtor(pt);
> -		tlb_remove_page_ptdesc(tlb, pt);
> +		tlb_remove_page(tlb, pt);
>   	}
>   }
>   
> @@ -120,7 +120,7 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
>   				  unsigned long addr)
>   {
>   	if (pgtable_l4_enabled)
> -		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(pud));
> +		riscv_tlb_remove_table(tlb, virt_to_page(pud));
>   }
>   
>   #define p4d_alloc_one p4d_alloc_one
> @@ -143,7 +143,7 @@ static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
>   				  unsigned long addr)
>   {
>   	if (pgtable_l5_enabled)
> -		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
> +		riscv_tlb_remove_table(tlb, virt_to_page(p4d));
>   }
>   #endif /* __PAGETABLE_PMD_FOLDED */
>   
> @@ -172,7 +172,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>   static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
>   				  unsigned long addr)
>   {
> -	riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(pmd));
> +	riscv_tlb_remove_table(tlb, virt_to_page(pmd));
>   }
>   
>   #endif /* __PAGETABLE_PMD_FOLDED */
> @@ -180,7 +180,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
>   static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
>   				  unsigned long addr)
>   {
> -	riscv_tlb_remove_ptdesc(tlb, page_ptdesc(pte));
> +	riscv_tlb_remove_table(tlb, pte);
>   }
>   #endif /* CONFIG_MMU */
>   
> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
> index 705278074034..fba11949dd2e 100644
> --- a/arch/s390/include/asm/tlb.h
> +++ b/arch/s390/include/asm/tlb.h
> @@ -86,7 +86,7 @@ static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
>   	tlb->cleared_pmds = 1;
>   	if (mm_alloc_pgste(tlb->mm))
>   		gmap_unlink(tlb->mm, (unsigned long *)pte, address);
> -	tlb_remove_ptdesc(tlb, pte);
> +	tlb_remove_table(tlb, pte);
>   }
>   
>   /*
> @@ -105,7 +105,7 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
>   	tlb->mm->context.flush_mm = 1;
>   	tlb->freed_tables = 1;
>   	tlb->cleared_puds = 1;
> -	tlb_remove_ptdesc(tlb, pmd);
> +	tlb_remove_table(tlb, pmd);
>   }
>   
>   /*
> @@ -123,7 +123,7 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
>   	tlb->mm->context.flush_mm = 1;
>   	tlb->freed_tables = 1;
>   	tlb->cleared_p4ds = 1;
> -	tlb_remove_ptdesc(tlb, pud);
> +	tlb_remove_table(tlb, pud);
>   }
>   
>   /*
> @@ -141,7 +141,7 @@ static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
>   	__tlb_adjust_range(tlb, address, PAGE_SIZE);
>   	tlb->mm->context.flush_mm = 1;
>   	tlb->freed_tables = 1;
> -	tlb_remove_ptdesc(tlb, p4d);
> +	tlb_remove_table(tlb, p4d);
>   }
>   
>   #endif /* _S390_TLB_H */
> diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
> index 96d938fdf224..43812b2363ef 100644
> --- a/arch/sh/include/asm/pgalloc.h
> +++ b/arch/sh/include/asm/pgalloc.h
> @@ -35,7 +35,7 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
>   #define __pte_free_tlb(tlb, pte, addr)				\
>   do {								\
>   	pagetable_dtor(page_ptdesc(pte));			\
> -	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
> +	tlb_remove_page((tlb), (pte));				\
>   } while (0)
>   
>   #endif /* __ASM_SH_PGALLOC_H */
> diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
> index f0af23c3aeb2..aa6063dc5b1e 100644
> --- a/arch/um/include/asm/pgalloc.h
> +++ b/arch/um/include/asm/pgalloc.h
> @@ -28,7 +28,7 @@ extern pgd_t *pgd_alloc(struct mm_struct *);
>   #define __pte_free_tlb(tlb, pte, address)			\
>   do {								\
>   	pagetable_dtor(page_ptdesc(pte));			\
> -	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
> +	tlb_remove_page((tlb), (pte));				\
>   } while (0)
>   
>   #if CONFIG_PGTABLE_LEVELS > 2
> @@ -36,15 +36,15 @@ do {								\
>   #define __pmd_free_tlb(tlb, pmd, address)			\
>   do {								\
>   	pagetable_dtor(virt_to_ptdesc(pmd));			\
> -	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
> +	tlb_remove_page((tlb), virt_page(pmd));			\
>   } while (0)
>   
>   #if CONFIG_PGTABLE_LEVELS > 3
>   
>   #define __pud_free_tlb(tlb, pud, address)			\
>   do {								\
> -	pagetable_dtor(virt_to_ptdesc(pud));		\
> -	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pud));	\
> +	pagetable_dtor(virt_to_ptdesc(pud));			\
> +	tlb_remove_page((tlb), virt_to_page(pud));		\
>   } while (0)
>   
>   #endif
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 939a813023d7..7991950e98f6 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -209,9 +209,9 @@ struct mmu_table_batch {
>   	((PAGE_SIZE - sizeof(struct mmu_table_batch)) / sizeof(void *))
>   
>   #ifndef __HAVE_ARCH_TLB_REMOVE_TABLE
> -static inline void __tlb_remove_table(void *_table)
> +static inline void __tlb_remove_table(void *table)
>   {
> -	struct ptdesc *ptdesc = (struct ptdesc *)_table;
> +	struct ptdesc *ptdesc = page_to_ptdesc(table);
>   
>   	pagetable_dtor(ptdesc);
>   	pagetable_free(ptdesc);
> @@ -499,17 +499,6 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
>   	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
>   }
>   
> -static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
> -{
> -	tlb_remove_table(tlb, pt);
> -}
> -
> -/* Like tlb_remove_ptdesc, but for page-like page directories. */
> -static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
> -{
> -	tlb_remove_page(tlb, ptdesc_page(pt));
> -}
> -
>   static inline void tlb_change_page_size(struct mmu_gather *tlb,
>   						     unsigned int page_size)
>   {

