Return-Path: <linux-kernel+bounces-408635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 610E49C8153
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 04:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CCE8B23390
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04041E7C09;
	Thu, 14 Nov 2024 03:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IcMquauG"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23942E634
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 03:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553754; cv=none; b=GpfieZkEBUt6bgUCj9p3jM8bElS6aWozfLdSPzs1AjjRdvF/fPE2en113gXWik1aXqVyYzMzG5XA2FmHivRHg7YEy8JrucNP4xc6OIgJ7XPSCy/r+4ht1qVcGiG6rwGGOtXFODB2y7oZQik5LTWnzSHwH/L1s9ZtjQ6FI/lZMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553754; c=relaxed/simple;
	bh=oyIwahuRdCF8pasK3P7UOZsv2D32C1toBrrCPOrNwYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTS2qy8aPoEToFpEB4WW9xMW+xIBb4CSBGfW5rOQgJveGBGjkUXizUTRthupUhlgRl3e9ivxPasNOFR7nEDcGrLTkg6T5FdOl088NIh3PhdZxPQwJ1XWhD0NKuH+ItopiyP/R/ERRVwC/yrS/96w+AlJh3PTN6nUNUaJwfSJ6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IcMquauG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c805a0753so1038755ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 19:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731553752; x=1732158552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ic6E1MfCrTLiottFhJNcjdiSZfVmBufK3+/Ihufuuuc=;
        b=IcMquauGTdKpOiDv2p0LGTlLBdQEAMN4LUHWT0GDZkt50k8IT3MyWcMDEwAdG2GCFu
         ZrCYTE2XSzFXyKQm2kdn1Uv5shEW1WhHLL7QXz/HglJh9Mjv8Wr6syAgCVXeNiHfIBC3
         hUlFGNPsyaWidVL9SAqZNYgg/zkYvnGbm4hCkvvJvDrQDU49+tnxsZVoR4knXEzkFd/b
         DJquLHhe99qWpO7Nzj9aXNiwNG5vYeZuIKkAzObzeqTRWmGsMhy7QIVD3u74lMk1VNg6
         anOYUs4j4YGbczcbCHuBauHxcYI0+uVFkHf/fLxzGPtJxjs47JtblL65r2RGTOaFmOQC
         LFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731553752; x=1732158552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ic6E1MfCrTLiottFhJNcjdiSZfVmBufK3+/Ihufuuuc=;
        b=F2mfM/MhrcwjogC2GNpjE+e+lhUCrn1lzstaG3Jhm7POvrCWrCkr6lod2SjGcHN1kL
         jbmg/BbZdUXJwZo769emHyAijbI95s0PDqQt+J54QAMVcu/JmUySRqyfk/CM6qbo+Ju1
         qF86ZZAD8iJGr6tB77gK2H6tFN8WqdoAj+3/hrV+h/1GsZJidVNvEgRhZMHRWHBR5/h6
         YEtTiqLU8RplaVAL3WEEDIRCEfw0CTaTfNSI7nPvSV9FZInqMyUasvULS4i3E9c6PC5X
         X+VJ7LfvX/72GLYmc923cId5zWo4MSyEXoJW/x4PZtEPZJbAQ5TosqHAg6QVFDMSsH+X
         y5TA==
X-Forwarded-Encrypted: i=1; AJvYcCVq8CebJBxCeC2eMQ+IO0J6tr47RmxHQS3Pdq1K3T5VEyGRmzRSh5UVe5IGoF6vRTNju8piO3oQUWMQzaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfwab+3FdEGdwEe70slmxKqB/D8Vlwp4Sv27NYoMmEznhlHV7A
	rRkAVFnjLIPiPo3ZskQMeg3L/GzjLUbO/WFgbqfZwJb/ssgt2kKm6iADd/Mpv4E=
X-Google-Smtp-Source: AGHT+IHsDh5m1SqaRs7selWdid+JYC0KnSB5eclPMEkrNblU32XA/gt2P8JTKPvbhc91KQh/ctYRmw==
X-Received: by 2002:a17:903:234c:b0:20b:6188:fc5e with SMTP id d9443c01a7336-21183d66a42mr317181895ad.28.1731553752212;
        Wed, 13 Nov 2024 19:09:12 -0800 (PST)
Received: from [10.84.149.95] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d0627esm744865ad.202.2024.11.13.19.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 19:09:11 -0800 (PST)
Message-ID: <6c2c4e04-13da-4072-8d63-d9bea0168214@bytedance.com>
Date: Thu, 14 Nov 2024 11:09:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] mm: introduce do_zap_pte_range()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: jannh@google.com, hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, peterx@redhat.com,
 catalin.marinas@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
 <1639ac32194f2b2590852f410fd3ce3595eb730b.1730360798.git.zhengqi.arch@bytedance.com>
 <db3cd6c1-03d6-48fd-9591-ab3e90d7e10f@redhat.com>
 <2fd11f54-8c0c-401d-8635-e54ebf7facc2@bytedance.com>
 <6e9c649f-5fc9-4fcc-928c-c4f46a74ca66@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <6e9c649f-5fc9-4fcc-928c-c4f46a74ca66@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/13 19:43, David Hildenbrand wrote:
> On 13.11.24 03:40, Qi Zheng wrote:
>>
>>
>> On 2024/11/13 01:00, David Hildenbrand wrote:
>>> On 31.10.24 09:13, Qi Zheng wrote:
>>>> This commit introduces do_zap_pte_range() to actually zap the PTEs, 
>>>> which
>>>> will help improve code readability and facilitate secondary checking of
>>>> the processed PTEs in the future.
>>>>
>>>> No functional change.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>>    mm/memory.c | 45 ++++++++++++++++++++++++++-------------------
>>>>    1 file changed, 26 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index bd9ebe0f4471f..c1150e62dd073 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -1657,6 +1657,27 @@ static inline int zap_nonpresent_ptes(struct
>>>> mmu_gather *tlb,
>>>>        return nr;
>>>>    }
>>>> +static inline int do_zap_pte_range(struct mmu_gather *tlb,
>>>> +                   struct vm_area_struct *vma, pte_t *pte,
>>>> +                   unsigned long addr, unsigned long end,
>>>> +                   struct zap_details *details, int *rss,
>>>> +                   bool *force_flush, bool *force_break)
>>>> +{
>>>> +    pte_t ptent = ptep_get(pte);
>>>> +    int max_nr = (end - addr) / PAGE_SIZE;
>>>> +
>>>> +    if (pte_none(ptent))
>>>> +        return 1;
>>>
>>> Maybe we should just skip all applicable pte_none() here directly.
>>
>> Do you mean we should keep pte_none() case in zap_pte_range()? Like
>> below:
>>
> 
> No rather an addon patch that will simply skip over all
> consecutive pte_none, like:
> 
> if (pte_none(ptent)) {
>      int nr;
> 
>      for (nr = 1; nr < max_nr; nr++) {
>          ptent = ptep_get(pte + nr);
>          if (pte_none(ptent))
>              continue;
>      }
> 
>      max_nr -= nr;
>      if (!max_nr)
>          return nr;
>      addr += nr * PAGE_SIZE;
>      pte += nr;
> }

I tend to hand over the pte/addr increments here to the loop
outside do_zap_pte_range(), like this:

diff --git a/mm/memory.c b/mm/memory.c
index bd9ebe0f4471f..2367a1c19edd6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1657,6 +1657,36 @@ static inline int zap_nonpresent_ptes(struct 
mmu_gather *tlb,
         return nr;
  }

+static inline int do_zap_pte_range(struct mmu_gather *tlb,
+                                  struct vm_area_struct *vma, pte_t *pte,
+                                  unsigned long addr, unsigned long end,
+                                  struct zap_details *details, int *rss,
+                                  bool *force_flush, bool *force_break)
+{
+       pte_t ptent = ptep_get(pte);
+       int max_nr = (end - addr) / PAGE_SIZE;
+
+       if (pte_none(ptent)) {
+               int nr = 1;
+
+               for (; nr < max_nr; nr++) {
+                       ptent = ptep_get(pte + nr);
+                       if (!pte_none(ptent))
+                               break;
+               }
+
+               return nr;
+       }
+
+       if (pte_present(ptent))
+               return zap_present_ptes(tlb, vma, pte, ptent, max_nr,
+                                       addr, details, rss, force_flush,
+                                       force_break);
+
+       return zap_nonpresent_ptes(tlb, vma, pte, ptent, max_nr, addr,
+                                        details, rss);
+}
+
  static unsigned long zap_pte_range(struct mmu_gather *tlb,
                                 struct vm_area_struct *vma, pmd_t *pmd,
                                 unsigned long addr, unsigned long end,
@@ -1679,28 +1709,14 @@ static unsigned long zap_pte_range(struct 
mmu_gather *tlb,
         flush_tlb_batched_pending(mm);
         arch_enter_lazy_mmu_mode();
         do {
-               pte_t ptent = ptep_get(pte);
-               int max_nr;
-
-               nr = 1;
-               if (pte_none(ptent))
-                       continue;
-
                 if (need_resched())
                         break;

-               max_nr = (end - addr) / PAGE_SIZE;
-               if (pte_present(ptent)) {
-                       nr = zap_present_ptes(tlb, vma, pte, ptent, max_nr,
-                                             addr, details, rss, 
&force_flush,
-                                             &force_break);
-                       if (unlikely(force_break)) {
-                               addr += nr * PAGE_SIZE;
-                               break;
-                       }
-               } else {
-                       nr = zap_nonpresent_ptes(tlb, vma, pte, ptent, 
max_nr,
-                                                addr, details, rss);
+               nr = do_zap_pte_range(tlb, vma, pte, addr, end, details,
+                                     rss, &force_flush, &force_break);
+               if (unlikely(force_break)) {
+                       addr += nr * PAGE_SIZE;
+                       break;
                 }
         } while (pte += nr, addr += PAGE_SIZE * nr, addr != end);

> 
> Assuming that it's likely more common to have larger pte_none() holes 
> that single ones, optimizing out the 
> need_resched()+force_break+incremental pte/addr increments etc.
> 

