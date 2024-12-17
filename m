Return-Path: <linux-kernel+bounces-448526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 770039F4149
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136FB1882EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 03:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C6B13B590;
	Tue, 17 Dec 2024 03:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RrZ/M/ai"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37BF3D69
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734406933; cv=none; b=kcODANoGe8meDaKednU7cqiKgK/8rorX6JOlFt24fZLTIHXRrN1+V1jWGN5zHHjMV4Pp29hV0jFiBB9tnq8n0Q0waHxNLPAWaHHej4zvCp70Q1kUk6PpH6bLP/ekFgGVnQYwq45uIwBuJT19r9Lqled83axWIa0mLwCkK4iLLJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734406933; c=relaxed/simple;
	bh=1WGnnStYPrLtTSHVMyc1Ltv2sO8D/9UWU/E0ON1gMvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Auj+JoAVsoVC9c0AXOjRISvIci4Nq6ynNN8FEA6IpElvatwEnaPKR2qyEBR9R8N+42t4A7sBEGeT4k2GOuxfeOmbG3J2zVXdz+sg6cwJJ0iLeeAo8dwDrgprk7k5UwEF7AWycv4WstW7E7K3+XjHBM/D2ygUCnudFqxehMwfWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RrZ/M/ai; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef748105deso3441758a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734406931; x=1735011731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dEvQQbN9uQygIRPITlzp9JjlYwIYyBnZyz8VAeqPXDw=;
        b=RrZ/M/aiCz+KqL2XqcVDWvdOrHd05rb421Fnra1sWCXimhSS3QH9zyewJ3VfxVL+M1
         9UKjDAZnWmV1rg7XnHk7HRrotTRC/lSQ3bFmlAS+BGJ/aCzKybQNfJTBNIPnwQUaEyPq
         ZePHFNBjyZy8LZXPCz/8IbVAQqfg/9sag1/cnp8fzDWxNBLgquu0foeAPG0AoOGp+IGa
         s8yf6RAQDiwhdd2jgnHGfbVOLV765sWti42FkiKsy5s5MsN4vAvG2JsyoTJNlNDELyNv
         shJfPoUrHCO/WHCVqXXqzRrc+QicgrRxDrR1Z292lA68DMcslnT9Wqr8zLF55KNHqIZS
         4Oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734406931; x=1735011731;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dEvQQbN9uQygIRPITlzp9JjlYwIYyBnZyz8VAeqPXDw=;
        b=wWOzkyDGbN3h1eUhfQ1Q7vcPBrIF841N/8KPi8zA/0qBUJy7ONgQKHLRojg6Z0mhkB
         UHCH/qCQMNXwXFW47anmP1jElSYWL/JdVHZbQMkxahUJFbDVp2un37Eolgz/mmKxnAx6
         YRG2uNj5ici0A/JFUZnRT1gGF+lvvxq+MwnOzrkJFGe6F2p5fNSLYQezKru41SN/PnD6
         FDIx4pRmCqA1jf5Ym+TYKdQwkBFvz1unZRs+MJGck8OfOslbo72rX69FdzjrGIstnMkB
         7g+oIK6vbTF9uo1ssT8RsWg+5sBBEllsFEkdm7HgaDUwmAefOmj3IcWpuNGXDeOW4OSl
         5nXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG27FnMQxeoWUYLN6tGeJ7DVEWPhFWXXTSMbbNbt0P/0jQ4uwB2BqvbkQQssefFYULhcK/Cw4igxfbecQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7Qs4pIku+vKUKATvIWq/PNVwnQxb0V+CMJRAAuwMe1zYTnCM
	+Df0h0BpHZtw7qaySWfFBeO+1fRcUvjH9DsNvCTAMEs/7pudEGuYoxOHEer4YIE=
X-Gm-Gg: ASbGnctmTvcofr/S438otEUB/HTk+3b2abwJrJ5CckHN4UZgAQxJRkAbPNror5cZJPo
	9Rvz6jnbvYvwrWvm+CxzFAoVG6XkHbML4ocQqg/c+ImoMI1y37+yZRFTxYv69PynFgLpLUD1obF
	1r6n3wPLidUzvoqryhl3jahLvtaD+GIAnAQapPhe++T24u+/V1KwoOhlwohTkq8ZbOwLuB/ZgES
	E2A9PDFpRqlzWVIRRfi/I7NVkFvgU+xAdN36T6rmV1ENjOoAAFzIZ8O80cIBL9Ma5vsV50ZO0Wx
	66KwpA==
X-Google-Smtp-Source: AGHT+IEua29FJxatcLG14Qf54QYYiPtd3uLrgcl6ElEvZjYWwgaaKuMa21PXYrcQLxGZMroSxa4iLw==
X-Received: by 2002:a17:90b:388f:b0:2ee:7698:e565 with SMTP id 98e67ed59e1d1-2f28fb5028amr22915639a91.8.1734406930987;
        Mon, 16 Dec 2024 19:42:10 -0800 (PST)
Received: from [10.4.194.102] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fc344csm8846764a91.47.2024.12.16.19.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 19:42:10 -0800 (PST)
Message-ID: <6666f651-2a59-40fb-b984-60669d4fdaa2@bytedance.com>
Date: Tue, 17 Dec 2024 11:42:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] mm: pgtable: introduce generic __tlb_remove_table()
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>,
 Vishal Moola <vishal.moola@gmail.com>
Cc: tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
 <271e58cd4ab808c4f402539b76d5916924e2bc6f.1734164094.git.zhengqi.arch@bytedance.com>
 <20241216120043.GA11133@noisy.programming.kicks-ass.net>
 <efc3f9c9-5040-44c1-82dd-59361281336c@bytedance.com>
 <20241216181225.GB11133@noisy.programming.kicks-ass.net>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20241216181225.GB11133@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/17 02:12, Peter Zijlstra wrote:
> On Mon, Dec 16, 2024 at 08:52:06PM +0800, Qi Zheng wrote:
>>
>>
>> On 2024/12/16 20:00, Peter Zijlstra wrote:
>>> On Sat, Dec 14, 2024 at 05:02:57PM +0800, Qi Zheng wrote:
>>
>> [...]
>>
>>>> +#ifndef __HAVE_ARCH_TLB_REMOVE_TABLE
>>>> +static inline void __tlb_remove_table(void *_table)
>>>> +{
>>>> +	struct ptdesc *ptdesc = (struct ptdesc *)_table;
>>>> +
>>>> +	pagetable_dtor(ptdesc);
>>>> +	pagetable_free(ptdesc);
>>>> +}
>>>> +#endif
>>>
>>>
>>> Spot the fail...
>>>
>>> That said, all this ptdesc stuff is another giant trainwreck. Let me
>>> clean that up for you.
>>
>> It looks like you want to revert what was done in this patch series:
>>
>> https://lore.kernel.org/all/20230807230513.102486-1-vishal.moola@gmail.com/
>>
>> But why? It seems that splitting ptdesc from struct page is a good
>> thing?
> 
> Because we're explicitly allocating pages for the page-tables, and also,
> code like:
> 
> tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));
> 
> static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
> {
> 	tlb_remove_page(tlb, ptdesc_page(pt));
> }
> 
> Just makes me upset.

Aha, this strikes me as odd too.

Also +CC Vishal Moola, the author of ptdesc, who may be able to provide
more background information. If Vishal has no objection, I will try to
remove tlb_remove_ptdesc() and tlb_remove_page_ptdesc() as Peter suggested.

> 
> Just bloody write tlb_remove_page() and call it a day.
> 
> All that nonsense is just obfuscation at this point.

In addition, will remove the duplicates of __tlb_remove_table,
asm-generic/pgalloc.h pte_free(), pmd_free(), __pud_free() and
__p4d_free() as follows:

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 3673e9c29504e..370f5b579ff88 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -107,10 +107,7 @@ static inline pgtable_t pte_alloc_one_noprof(struct 
mm_struct *mm)
   */
  static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
  {
-       struct ptdesc *ptdesc = page_ptdesc(pte_page);
-
-       pagetable_dtor(ptdesc);
-       pagetable_free(ptdesc);
+       pagetable_dtor_free(pte_page);
  }


@@ -150,11 +147,7 @@ static inline pmd_t *pmd_alloc_one_noprof(struct 
mm_struct *mm, unsigned long ad
  #ifndef __HAVE_ARCH_PMD_FREE
  static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
  {
-       struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
-
-       BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
-       pagetable_dtor(ptdesc);
-       pagetable_free(ptdesc);
+       pagetable_dtor_free(virt_to_page(pmd));
  }
  #endif

@@ -199,11 +192,7 @@ static inline pud_t *pud_alloc_one_noprof(struct 
mm_struct *mm, unsigned long ad

  static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
  {
-       struct ptdesc *ptdesc = virt_to_ptdesc(pud);
-
-       BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
-       pagetable_dtor(ptdesc);
-       pagetable_free(ptdesc);
+       pagetable_dtor_free(virt_to_page(pud));
  }

  #ifndef __HAVE_ARCH_PUD_FREE
@@ -254,11 +243,7 @@ static inline p4d_t *p4d_alloc_one_noprof(struct 
mm_struct *mm, unsigned long ad

  static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
  {
-       struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
-
-       BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
-       pagetable_dtor(ptdesc);
-       pagetable_free(ptdesc);
+       pagetable_dtor_free(virt_to_page(p4d));
  }

  #ifndef __HAVE_ARCH_P4D_FREE
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 939a813023d7e..b34d014c23ef0 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -211,10 +211,7 @@ struct mmu_table_batch {
  #ifndef __HAVE_ARCH_TLB_REMOVE_TABLE
  static inline void __tlb_remove_table(void *_table)
  {
-       struct ptdesc *ptdesc = (struct ptdesc *)_table;
-
-       pagetable_dtor(ptdesc);
-       pagetable_free(ptdesc);
+       pagetable_dtor_free(_table);
  }
  #endif

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 497035a78849b..11829860ec05e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3064,6 +3064,14 @@ static inline void pagetable_dtor(struct ptdesc 
*ptdesc)
         lruvec_stat_sub_folio(folio, NR_PAGETABLE);
  }

+static inline void pagetable_dtor_free(void *table)
+{
+       struct ptdesc *ptdesc = page_ptdesc((struct page *)table);
+
+        pagetable_dtor(ptdesc);
+        pagetable_dtor(ptdesc);
+}
+
  static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
  {
         struct folio *folio = ptdesc_folio(ptdesc);

Thanks!




