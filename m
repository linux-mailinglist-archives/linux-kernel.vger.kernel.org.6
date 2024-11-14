Return-Path: <linux-kernel+bounces-408664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB4C9C81C5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 05:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1DE284447
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 04:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC5D1E7660;
	Thu, 14 Nov 2024 04:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ajzuyKbr"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0313D53E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 04:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731557547; cv=none; b=geQ7gD5GkaDLrErYQgaBX3/bu9jQCVIB1R/KPnQXMGw7c1VlNci2Cl5otLJxeKpdiY1aPqmikAi9qo8uYy7YoKDIm3SiF3hyZoFDjph3E7158brc6ZMGRvxJngPQIa0cZYwwgRV9dRvCQyrI6lE2aEaMR4XSVhXf7qoRaxX+ZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731557547; c=relaxed/simple;
	bh=vaRofsphtJfAy8+yDn7V2mBeiKrFnzQ3mhzOrxnXDT0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eKZ6L5U9DMcS1UqkZGhciCUcSOoI+wUczrsxMRYiCE/fQyPwy1fj38ETccEgJD6k04hqFgU7GEEhjxeeqVUxCBAxCGG6RJ0+pwT8TCw/N/ZJXWTbFg4WdV6kbaFSEsDzCPYtXZDCoEH1PhUzrlvOw2c/+EpFLan8uMIGTcAtAaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ajzuyKbr; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71811707775so94707a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 20:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731557544; x=1732162344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wxe1Yk51FV/Oee9pdPgY/SU6vQRpXk/VbwUw9M4e2Z0=;
        b=ajzuyKbr1Q8hJgkjqQjQvIwq2fllDiHGCDQdLZiyyMy6owBkPaUiRwuDhoaDW6BP4b
         y8uuMmubZAHX1DJJ4wAvpoWLKvnDgyXjZBOTuQzNXjK/GPD5f8Ek+/m2xRYdp8POt4CF
         sL0NpwNIHxKtvTv923I71LEnLIVRzKPHT8za0HekvfAvjFOmc8b6XPBH3XeSpc9L1e5t
         giAIe85LTb+lXcGHigPJvQ8fa+6g3TeiXBVvaw/+HxCOSIcfyRmMlv8iNdZaCenh6vyq
         zM0OECi7UWMiTYTkTkUtQ10m5l2InwsRhQC8dTY65vgKlA9L7DTqtsDeJiePAwnJ3KFO
         Pkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731557544; x=1732162344;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wxe1Yk51FV/Oee9pdPgY/SU6vQRpXk/VbwUw9M4e2Z0=;
        b=tNMiffnHkAMK3/vNdXkzv6cFpN9kN0MLKOMvyzF6TafKZnW2DhB3C/7/0zmGDw6ePK
         2SBTGUclMjRfUs6biDsp/KTZCpWGVvT2tUsdLuzbFlaqhrXSSH5IcmAekU8AxrJk/QqK
         VTUQnA05AytqvC2gm0BBO4xG/KGQGC+ItLUuw4xfvWq7x/vWKCmHRpCUSRDHHx5p/YDy
         7IRzeC1rf8t1NDfRs2g5EwMYgrKbyLSLayGz/T9lqVyWs0X+Kn6pL9Pum+SJcVzorQUu
         Z6KxRuVXhOmF13mzJDIrhOVHbugZaNTVPTlaskyXd+ick/wM0CZd0CkwibbEJenMoDYw
         NLvw==
X-Forwarded-Encrypted: i=1; AJvYcCUfcKji9SCuQTEky53wXT04EU6eMXSeMhyCHMTBVvkVbjTV1hecYPYHPxk26oL1U8NUeCjpFPQOL2lshCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg3IzPVP/anPpj5bwGB5QYdfVxb7Kg3hgyzwy3RDOBEkNMTOPv
	VW3FbLwCkecOfLr4eVrdmiiO/zxzjBiyQmB9Knb+tvpVCxiM1fhpWpNStin1CrA=
X-Google-Smtp-Source: AGHT+IFQSA1TW8zjz7vQRFOj76hw7DbV+dkqDiRPaRUvdVeNbIK+tzJTg4LLlVnhDxA2Rie4rsnBCw==
X-Received: by 2002:a05:6830:6288:b0:718:118d:2be8 with SMTP id 46e09a7af769-71a6e60bc5fmr1000501a34.28.1731557544150;
        Wed, 13 Nov 2024 20:12:24 -0800 (PST)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8b39b57b4sm134058a12.80.2024.11.13.20.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 20:12:22 -0800 (PST)
Message-ID: <2c52e1a0-8431-47ca-9a27-153435805963@bytedance.com>
Date: Thu, 14 Nov 2024 12:12:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] mm: introduce do_zap_pte_range()
Content-Language: en-US
From: Qi Zheng <zhengqi.arch@bytedance.com>
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
 <6c2c4e04-13da-4072-8d63-d9bea0168214@bytedance.com>
In-Reply-To: <6c2c4e04-13da-4072-8d63-d9bea0168214@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/14 11:09, Qi Zheng wrote:
> 
> 
> On 2024/11/13 19:43, David Hildenbrand wrote:
>> On 13.11.24 03:40, Qi Zheng wrote:
>>>
>>>
>>> On 2024/11/13 01:00, David Hildenbrand wrote:
>>>> On 31.10.24 09:13, Qi Zheng wrote:
>>>>> This commit introduces do_zap_pte_range() to actually zap the PTEs, 
>>>>> which
>>>>> will help improve code readability and facilitate secondary 
>>>>> checking of
>>>>> the processed PTEs in the future.
>>>>>
>>>>> No functional change.
>>>>>
>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>> ---
>>>>>    mm/memory.c | 45 ++++++++++++++++++++++++++-------------------
>>>>>    1 file changed, 26 insertions(+), 19 deletions(-)
>>>>>
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index bd9ebe0f4471f..c1150e62dd073 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -1657,6 +1657,27 @@ static inline int zap_nonpresent_ptes(struct
>>>>> mmu_gather *tlb,
>>>>>        return nr;
>>>>>    }
>>>>> +static inline int do_zap_pte_range(struct mmu_gather *tlb,
>>>>> +                   struct vm_area_struct *vma, pte_t *pte,
>>>>> +                   unsigned long addr, unsigned long end,
>>>>> +                   struct zap_details *details, int *rss,
>>>>> +                   bool *force_flush, bool *force_break)
>>>>> +{
>>>>> +    pte_t ptent = ptep_get(pte);
>>>>> +    int max_nr = (end - addr) / PAGE_SIZE;
>>>>> +
>>>>> +    if (pte_none(ptent))
>>>>> +        return 1;
>>>>
>>>> Maybe we should just skip all applicable pte_none() here directly.
>>>
>>> Do you mean we should keep pte_none() case in zap_pte_range()? Like
>>> below:
>>>
>>
>> No rather an addon patch that will simply skip over all
>> consecutive pte_none, like:
>>
>> if (pte_none(ptent)) {
>>      int nr;
>>
>>      for (nr = 1; nr < max_nr; nr++) {
>>          ptent = ptep_get(pte + nr);
>>          if (pte_none(ptent))
>>              continue;
>>      }
>>
>>      max_nr -= nr;
>>      if (!max_nr)
>>          return nr;
>>      addr += nr * PAGE_SIZE;
>>      pte += nr;
>> }
> 
> I tend to hand over the pte/addr increments here to the loop
> outside do_zap_pte_range(), like this:
> 

Finally, I choose to introduce skip_none_ptes() to do this:

diff --git a/mm/memory.c b/mm/memory.c
index bd9ebe0f4471f..24633d0e1445a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1657,6 +1657,28 @@ static inline int zap_nonpresent_ptes(struct 
mmu_gather *tlb,
         return nr;
  }

+static inline int skip_none_ptes(pte_t *pte, unsigned long addr,
+                                unsigned long end)
+{
+       pte_t ptent = ptep_get(pte);
+       int max_nr;
+       int nr;
+
+       if (!pte_none(ptent))
+               return 0;
+
+       max_nr = (end - addr) / PAGE_SIZE;
+       nr = 1;
+
+       for (; nr < max_nr; nr++) {
+               ptent = ptep_get(pte + nr);
+               if (!pte_none(ptent))
+                       break;
+       }
+
+       return nr;
+}
+
  static unsigned long zap_pte_range(struct mmu_gather *tlb,
                                 struct vm_area_struct *vma, pmd_t *pmd,
                                 unsigned long addr, unsigned long end,
@@ -1682,13 +1704,17 @@ static unsigned long zap_pte_range(struct 
mmu_gather *tlb,
                 pte_t ptent = ptep_get(pte);
                 int max_nr;

-               nr = 1;
-               if (pte_none(ptent))
-                       continue;
-
                 if (need_resched())
                         break;

+               nr = skip_none_ptes(pte, addr, end);
+               if (nr) {
+                       addr += PAGE_SIZE * nr;
+                       if (addr == end)
+                               break;
+                       pte += nr;
+               }
+
                 max_nr = (end - addr) / PAGE_SIZE;
                 if (pte_present(ptent)) {
                         nr = zap_present_ptes(tlb, vma, pte, ptent, max_nr,

Thanks!



