Return-Path: <linux-kernel+bounces-412813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E32A9D0F5F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AF71F223B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AD219885D;
	Mon, 18 Nov 2024 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="A2l/pWR0"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68673194A63
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731928445; cv=none; b=Hmj53b3QPyjL+9lRo0VJDNNs5mR0NJxRp5B4O5dmL8NYnW22xshzgeeLAJbMWJHicrYwcDeARToT/xydHnrPZgp8EF50RZP0wUVbi33gey9AE3ps5Tnq5jMIZCQ/CPNirFKEvCad/Gr/tlWzShd4N9dKNsUEf5S3yHg8QfavIUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731928445; c=relaxed/simple;
	bh=pyErrRXkhifmAwSePxwTdGqPL4ScPIP2rk07J3ovzkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcFdUz+nosQhZlqCEBVcpuplxzPX2YmIBmGmiiwbqLcYygoIiqFYGE59UjhWxt4ezNM5BYCnEWSQxlmMISpetFhBOOw9rJNd561TmO8lKMaselF5bI3GhEa+seQOQpzWsDN0f+cTfyXrBdHf/HC1VlD/plwlGUOuAgtb/iKmtpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=A2l/pWR0; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ee020ec76dso3141832a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 03:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731928443; x=1732533243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORrVs+s0V5otpD68MhZ7rAWmPvfENIKBy1EC12UuyQs=;
        b=A2l/pWR0YqqigB7afob7sOlpW70OKqjyi4/sELGretnVr6HGf0XZsLPtm8kz/VfQ82
         TNWHV+NQJJcBL5OPK6IGsNcPLAhVbdyqIvPlx8ls/P3lxbCqWHspsOp5kXdRzlo4Sdhi
         S/VmkgEsL8cR0Hf+GgXXhSM58jmN7UsDZbD0xF4HlE5JQC2WfM44sx2LLr/rf75zX54V
         avwPCwXyPeInZhb1o0Dv5c8+mJOBESGbUtdyDF+7X1hnjoSnliEU8b0j8Tukf8jRnfUx
         FmdWbScpT3M1ikPpwOpNP9ntIduiKhD6rMakq8EUili42fTvqntO8wYAELPqAkqoyYOt
         sM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731928443; x=1732533243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORrVs+s0V5otpD68MhZ7rAWmPvfENIKBy1EC12UuyQs=;
        b=FyarPCRqA9l3k31aLtNSHz9PLT8aHLnmWSN4jZkp1M6aevlcnpGovBrJUQ2dVwzBVR
         Z8EWcwpZZeBwF7WLUj8ltIhLA1iQw7Cz3C8+oraJNwfpcIZkpmvxZlmCif0PS1BwjlB8
         ttAs7zCuMZ2gtV9JzHouDSKb8T8qMMFH86EIQ+UGhuVjLeL+pdYdy1e2eh4+hf4RhYc/
         0Uc7QmjphNbaoU4kPeoNLLs5xQxKFL0Mcl+BK33323tcriTm6GFlkKq6NKLcLVuBwwz6
         aSrKkPUty1RsgNFJRY16FSxtKTny52lexNUFCdPDJperGJcODIXhqqSp0gkDqE1hoQud
         4vAA==
X-Forwarded-Encrypted: i=1; AJvYcCWa1yYKqAZ3cUtVoq0KXso6nY3eskMpG/oUJI5H1mxuKIZTiNfQS+xpIXT7cBvcQ4oN6zbT9wQVo4JXDXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqw5UQymRH7nwxndIEe5EWnH0xxgVjDQwaLjLL0XKN9GlbQR2u
	mBxw4RuSXQDxZuFPb9L91/RxayeKVGnYWvW38FBmAmF8czZ4QKx+xypdeKFpWj0=
X-Google-Smtp-Source: AGHT+IEH6pemOWN/YAryx+DlY/pBV3dgpcgNKO/QEpdyCBZYCTXDYKz3IjnBXx8ovLRGEl/XltUULA==
X-Received: by 2002:a05:6a20:394d:b0:1d9:c78f:4207 with SMTP id adf61e73a8af0-1dc90b1c34amr16642798637.11.1731928442746;
        Mon, 18 Nov 2024 03:14:02 -0800 (PST)
Received: from [10.84.149.95] ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771394ffsm5899231b3a.90.2024.11.18.03.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 03:14:02 -0800 (PST)
Message-ID: <d897a1d3-bf72-48f2-b4df-1f7acb3ac311@bytedance.com>
Date: Mon, 18 Nov 2024 19:13:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] mm: introduce skip_none_ptes()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: jannh@google.com, hughd@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 peterx@redhat.com, mgorman@suse.de, catalin.marinas@arm.com,
 will@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, x86@kernel.org, lorenzo.stoakes@oracle.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, zokeefe@google.com,
 rientjes@google.com
References: <cover.1731566457.git.zhengqi.arch@bytedance.com>
 <574bc9b646c87d878a5048edb63698a1f8483e10.1731566457.git.zhengqi.arch@bytedance.com>
 <c7eeac93-3619-4443-896f-ef2e02f0bef0@redhat.com>
 <617a063e-bd84-4da5-acf4-6ff516512055@bytedance.com>
 <fa3fc933-cd51-4be5-944e-250da9289eda@redhat.com>
 <b524a568-fa3b-4618-80cc-e8c31ea4eeac@bytedance.com>
 <d27a75fa-b968-43d3-bbd3-cc607feee495@redhat.com>
 <253e5fd0-7e98-43fd-b0d7-8a5b739ae4aa@bytedance.com>
 <77b1eddf-7c1b-43e9-9352-229998ce3fc7@redhat.com>
 <5a3428bd-743a-4d51-8b75-163ab560bca7@bytedance.com>
 <4edccc1a-2761-4a5a-89a6-7869c1b6b08a@redhat.com>
 <2b48d313-4f66-47c8-98d8-8aa78db62b1b@bytedance.com>
 <995804f4-b658-44b2-bb40-c84b8a322616@redhat.com>
 <f3adf382-d252-4007-b8ca-c557814cb5c8@bytedance.com>
 <4ee60b7b-a81e-4b94-96c9-52b1bd9d5061@redhat.com>
 <e2870a81-840a-4b33-b65b-318a4a526c26@bytedance.com>
 <332cbacb-cad3-4522-a74b-b5ad5efee4af@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <332cbacb-cad3-4522-a74b-b5ad5efee4af@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/18 18:59, David Hildenbrand wrote:
> On 18.11.24 11:56, Qi Zheng wrote:
>>
>>
>> On 2024/11/18 18:41, David Hildenbrand wrote:
>>> On 18.11.24 11:34, Qi Zheng wrote:
>>>>
>>>>
>>>> On 2024/11/18 17:29, David Hildenbrand wrote:
>>>>> On 18.11.24 04:35, Qi Zheng wrote:
>>>>>>
>>>>>>
>>>>>> On 2024/11/15 22:59, David Hildenbrand wrote:
>>>>>>> On 15.11.24 15:41, Qi Zheng wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2024/11/15 18:22, David Hildenbrand wrote:
>>>>>>>>>>>> *nr_skip = nr;
>>>>>>>>>>>>
>>>>>>>>>>>> and then:
>>>>>>>>>>>>
>>>>>>>>>>>> zap_pte_range
>>>>>>>>>>>> --> nr = do_zap_pte_range(tlb, vma, pte, addr, end, details,
>>>>>>>>>>>> &skip_nr,
>>>>>>>>>>>>                               rss, &force_flush, &force_break);
>>>>>>>>>>>>            if (can_reclaim_pt) {
>>>>>>>>>>>>                none_nr += count_pte_none(pte, nr);
>>>>>>>>>>>>                none_nr += nr_skip;
>>>>>>>>>>>>            }
>>>>>>>>>>>>
>>>>>>>>>>>> Right?
>>>>>>>>>>>
>>>>>>>>>>> Yes. I did not look closely at the patch that adds the 
>>>>>>>>>>> counting of
>>>>>>>>>>
>>>>>>>>>> Got it.
>>>>>>>>>>
>>>>>>>>>>> pte_none though (to digest why it is required :) ).
>>>>>>>>>>
>>>>>>>>>> Because 'none_nr == PTRS_PER_PTE' is used in patch #7 to detect
>>>>>>>>>> empty PTE page.
>>>>>>>>>
>>>>>>>>> Okay, so the problem is that "nr" would be "all processed
>>>>>>>>> entries" but
>>>>>>>>> there are cases where we "process an entry but not zap it".
>>>>>>>>>
>>>>>>>>> What you really only want to know is "was any entry not zapped",
>>>>>>>>> which
>>>>>>>>> could be a simple input boolean variable passed into
>>>>>>>>> do_zap_pte_range?
>>>>>>>>>
>>>>>>>>> Because as soon as any entry was processed but  no zapped, you can
>>>>>>>>> immediately give up on reclaiming that table.
>>>>>>>>
>>>>>>>> Yes, we can set can_reclaim_pt to false when a !pte_none() entry is
>>>>>>>> found in count_pte_none().
>>>>>>>
>>>>>>> I'm not sure if well need cont_pte_none(), but I'll have to take a
>>>>>>> look
>>>>>>> at your new patch to see how this fits together with doing the
>>>>>>> pte_none
>>>>>>> detection+skipping in do_zap_pte_range().
>>>>>>>
>>>>>>> I was wondering if you cannot simply avoid the additional 
>>>>>>> scanning and
>>>>>>> simply set "can_reclaim_pt" if you skip a zap.
>>>>>>
>>>>>> Maybe we can return the information whether the zap was skipped from
>>>>>> zap_present_ptes() and zap_nonpresent_ptes() through parameters 
>>>>>> like I
>>>>>> did in [PATCH v1 3/7] and [PATCH v1 4/7].
>>>>>>
>>>>>> In theory, we can detect empty PTE pages in the following two ways:
>>>>>>
>>>>>> 1) If no zap is skipped, it means that all pte entries have been
>>>>>>        zap, and the PTE page must be empty.
>>>>>> 2) If all pte entries are detected to be none, then the PTE page is
>>>>>>        empty.
>>>>>>
>>>>>> In the error case, 1) may cause non-empty PTE pages to be reclaimed
>>>>>> (which is unacceptable), while the 2) will at most cause empty PTE
>>>>>> pages
>>>>>> to not be reclaimed.
>>>>>>
>>>>>> So the most reliable and efficient method may be:
>>>>>>
>>>>>> a. If there is a zap that is skipped, stop scanning and do not 
>>>>>> reclaim
>>>>>>        the PTE page;
>>>>>> b. Otherwise, as now, detect the empty PTE page through
>>>>>> count_pte_none()
>>>>>
>>>>> Is there a need for count_pte_none() that I am missing?
>>>>
>>>> When any_skipped == false, at least add VM_BUG_ON() to recheck none 
>>>> ptes.
>>>>
>>>>>
>>>>> Assume we have
>>>>>
>>>>> nr = do_zap_pte_range(&any_skipped)
>>>>>
>>>>>
>>>>> If "nr" is the number of processed entries (including pte_none()), and
>>>>> "any_skipped" is set whenever we skipped to zap a !pte_none entry, we
>>>>> can detect what we need, no?
>>>>>
>>>>> If any_skipped == false after the call, we now have "nr" pte_none()
>>>>> entries. -> We can continue trying to reclaim
>>>>
>>>> I prefer that "nr" should not include pte_none().
>>>>
>>>
>>> Why? do_zap_pte_range() should tell you how far to advance, nothing
>>> less, nothing more.
>>>
>>> Let's just keep it simple and avoid count_pte_none().
>>>
>>> I'm probably missing something important?
>>
>> As we discussed before, we should skip all consecutive none ptes,
>  > pte and addr are already incremented before returning.
> 
> It's probably best to send the resulting patch so I can either 
> understand why count_pte_none() is required or comment on how to get rid 
> of it.

Something like this:

diff --git a/mm/memory.c b/mm/memory.c
index bd9ebe0f4471f..e9bec3cd49d44 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1657,6 +1657,66 @@ static inline int zap_nonpresent_ptes(struct 
mmu_gather *tlb,
         return nr;
  }

+static inline int do_zap_pte_range(struct mmu_gather *tlb,
+                                  struct vm_area_struct *vma, pte_t *pte,
+                                  unsigned long addr, unsigned long end,
+                                  struct zap_details *details, int *rss,
+                                  bool *force_flush, bool *force_break,
+                                  bool *any_skipped)
+{
+       pte_t ptent = ptep_get(pte);
+       int max_nr = (end - addr) / PAGE_SIZE;
+
+       /* Skip all consecutive pte_none(). */
+       if (pte_none(ptent)) {
+               int nr;
+
+               for (nr = 1; nr < max_nr; nr++) {
+                       ptent = ptep_get(pte + nr);
+                       if (!pte_none(ptent))
+                               break;
+               }
+               max_nr -= nr;
+               if (!max_nr)
+                       return 0;
+               pte += nr;
+               addr += nr * PAGE_SIZE;
+       }
+
+       if (pte_present(ptent))
+               return zap_present_ptes(tlb, vma, pte, ptent, max_nr,
+                                       addr, details, rss, force_flush,
+                                       force_break, any_skipped);
+
+       return zap_nonpresent_ptes(tlb, vma, pte, ptent, max_nr, addr,
+                                  details, rss, any_skipped);
+}
+
+static inline int count_pte_none(pte_t *pte, int nr)
+{
+       int none_nr = 0;
+
+       /*
+        * If PTE_MARKER_UFFD_WP is enabled, the uffd-wp PTEs may be
+        * re-installed, so we need to check pte_none() one by one.
+        * Otherwise, checking a single PTE in a batch is sufficient.
+        */
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
+       for (;;) {
+               if (pte_none(ptep_get(pte)))
+                       none_nr++;
+               if (--nr == 0)
+                       break;
+               pte++;
+       }
+#else
+       if (pte_none(ptep_get(pte)))
+               none_nr = nr;
+#endif
+       return none_nr;
+}
+
+
  static unsigned long zap_pte_range(struct mmu_gather *tlb,
                                 struct vm_area_struct *vma, pmd_t *pmd,
                                 unsigned long addr, unsigned long end,
@@ -1667,6 +1727,7 @@ static unsigned long zap_pte_range(struct 
mmu_gather *tlb,
         int rss[NR_MM_COUNTERS];
         spinlock_t *ptl;
         pte_t *start_pte;
+       bool can_reclaim_pt;
         pte_t *pte;
         int nr;

@@ -1679,28 +1740,22 @@ static unsigned long zap_pte_range(struct 
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
+               bool any_skipped;

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
+                                     rss, &force_flush, &force_break,
+                                     &any_skipped);
+               if (can_reclaim_pt) {
+                       VM_BUG_ON(!any_skipped && count_pte_none(pte, 
nr) == nr);
+                       if (any_skipped)
+                               can_reclaim_pt = false;
+               }
+               if (unlikely(force_break)) {
+                       addr += nr * PAGE_SIZE;
+                       break;
                 }
         } while (pte += nr, addr += PAGE_SIZE * nr, addr != end);


> 

