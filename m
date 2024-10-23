Return-Path: <linux-kernel+bounces-378764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123399AD52A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2365286605
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FC61D4340;
	Wed, 23 Oct 2024 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMmfRdmH"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6104678C9C;
	Wed, 23 Oct 2024 19:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712825; cv=none; b=VZm8mANem9tN1TqhqCrVB1bVqp4XPiBuule4juWzuIlP8QZoitb0juD0YN69FbE57Q6Srs+1ObQ20VUfbVCH+L4DYzvWIWI5tGb8/jT35BvmXybSoxXFNQOr6VcjkALDg5KYP5RDK/fk25yZBfXOE69KcMrIVysGXGxIMMnEV0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712825; c=relaxed/simple;
	bh=ucEA7464hGCezqRystmWElGO4b2mdjFDCHIjcXKe/K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDsi8ruFWKfRqAkMxY/ofLNQIfiYN/MJlZgyJ7H9yBPkpt9DRPPrzXAB8ys5nRFn+LwtUWYyl3F43m0TzoNYbvqf8Odqv+DsBpR/3JaHzyJFyIcPYxZUCtJ3zq1IOjvJJSqqSHjBDssoxe5bf1iuvzI8UzJRXOza7m2E6WQaCb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMmfRdmH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315eac969aso1094355e9.1;
        Wed, 23 Oct 2024 12:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729712822; x=1730317622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5iSjnuhuDC0DOpI59kZ9NDtU1vZVCYiMLuN86UCJqw=;
        b=EMmfRdmHm9BvqADfHRb3br4N5o7c73LTKYIjNACo1GfHz/yJweaOHRaSiT4yHBiGF8
         CuaELEeY0RFMkvmfqsuBK2gapBeB/7Dmil1vkulyPmOc8guARMfqROxuY2zSH3mNX69v
         PwnNu4LkY1PJywYKkyJiQLSEfOp0HeKR9EV3nQ2GZl3QV9ZJE5rMiCxuotUJAj8aZUjS
         G81MaWhlBB7Q1LJNQ42pWM1fF15QEqiRjcAynDoVzkc9EPN+ki7/zP5OKLd39uM34/wm
         jFelDduB/yGux49zmtmaR0gtZsvVkhHIr6OY61Y3bSG4cMnTk3Sdwrk7duK2APvzkrrU
         MKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729712822; x=1730317622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5iSjnuhuDC0DOpI59kZ9NDtU1vZVCYiMLuN86UCJqw=;
        b=GIlRNDF2lkkMFaGdznaB3aYNkD/RYZHPGaIFGZlMJlV4DtzFf33/xk5IW9r66d0iHb
         ohajtGF5dzpbHpro6VRqEyFB6G+G96BFprFkpDCpA+kSkfpCC8KGI+pZOOYpgMzkoV5h
         AVVJZAlZYNqyXA3e/dMnbRYunqNJ80XcKeiDLSl1IjYzpdDP450rZzP1ED9X3f4SkM5B
         aAgr9kCcUHmgBvOE0IQs4qOBmCLUoYzeuw3GcJWMam1kh1v7Kt3gRz3i6M/2jvrVeypO
         ci14pvT8cmpqC0C+rRrBN5FNA0FhIiMSx1F8OVitgJJAE9TyXXX+xUR1Tq5DxiKIr2M6
         3hzw==
X-Forwarded-Encrypted: i=1; AJvYcCUQI3xxxNXKeCXUv5kQg6OGcylb65K0APfu/YXXJ/s7LgNHRQUqC7HPESH6SBweEgyzPlmcfPH5L3ZYw0r7@vger.kernel.org, AJvYcCW1j0V85wWBjN59touVtGtgLKVYTlSmkp9I/qDNUG2gwwJID4u2LZBR8faAbmARPVjWIjKRjBdWf1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTKFNwz0FEEh6are0Vkxj9f0dGS9gxUztlUTKa4k3cp/XipzDe
	w9909DvM7lLjamgDC/m+0aVR/vAgLvUQdbZJO8M6wXBIav82gzY/
X-Google-Smtp-Source: AGHT+IGSgbb9Dtn2zixDYzF1lkFR+CixRzTX88TfIjLLmQudW/61Mt6ogVCex3tHv4UxYkKRS3dA0g==
X-Received: by 2002:a05:600c:45c6:b0:431:4fbd:f571 with SMTP id 5b1f17b1804b1-4318445a11amr23806835e9.13.1729712821463;
        Wed, 23 Oct 2024 12:47:01 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c1eccesm24571635e9.46.2024.10.23.12.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 12:47:01 -0700 (PDT)
Message-ID: <cb3f67c3-e8d3-4398-98c9-d5aee134fd4c@gmail.com>
Date: Wed, 23 Oct 2024 20:47:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] mm: zswap: add support for zswapin of large folios
To: Barry Song <21cnbao@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, senozhatsky@chromium.org,
 minchan@kernel.org, hanchuanhua@oppo.com, v-songbaohua@oppo.com,
 akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 david@redhat.com, willy@infradead.org, kanchana.p.sridhar@intel.com,
 nphamcs@gmail.com, chengming.zhou@linux.dev, ryan.roberts@arm.com,
 ying.huang@intel.com, riel@surriel.com, shakeel.butt@linux.dev,
 kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
 <CAGsJ_4xweuSwMUBuLSr2eUy69mtQumeDpMZ1g2jFPGq6nFn9fg@mail.gmail.com>
 <5313c721-9cf1-4ecd-ac23-1eeddabd691f@gmail.com>
 <b1c17b5e-acd9-4bef-820e-699768f1426d@gmail.com>
 <CAGsJ_4wykOyJupLhcqkSPe27rdANd=bOJhqxL74vcdZ+T9f==g@mail.gmail.com>
 <eab11780-e671-4d09-86a6-af4cf3589392@gmail.com>
 <CAGsJ_4wWf7QnibY_uU8B=efuEACrvFaJJ=bJTD+9KrxFtfoMmQ@mail.gmail.com>
 <CAGsJ_4w5XLMok4F6Xw7aTAdV6rY9OvCVPM3U+hzFnKyTXBUpOA@mail.gmail.com>
 <4c30cc30-0f7c-4ca7-a933-c8edfadaee5c@gmail.com>
 <7a14c332-3001-4b9a-ada3-f4d6799be555@gmail.com>
 <CAJD7tkbrjV3Px8h1p950VZFi9FnzxZPn2Kg+vZD69eEcsQvtxg@mail.gmail.com>
 <3dca2498-363c-4ba5-a7e6-80c5e5532db5@gmail.com>
 <CAGsJ_4zp=E7izB5oAAiWu14UCqNCSvWhveGoHCP6Wr030SHH1A@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4zp=E7izB5oAAiWu14UCqNCSvWhveGoHCP6Wr030SHH1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 23/10/2024 19:52, Barry Song wrote:
> On Thu, Oct 24, 2024 at 7:31 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 23/10/2024 19:02, Yosry Ahmed wrote:
>>> [..]
>>>>>> I suspect the regression occurs because you're running an edge case
>>>>>> where the memory cgroup stays nearly full most of the time (this isn't
>>>>>> an inherent issue with large folio swap-in). As a result, swapping in
>>>>>> mTHP quickly triggers a memcg overflow, causing a swap-out. The
>>>>>> next swap-in then recreates the overflow, leading to a repeating
>>>>>> cycle.
>>>>>>
>>>>>
>>>>> Yes, agreed! Looking at the swap counters, I think this is what is going
>>>>> on as well.
>>>>>
>>>>>> We need a way to stop the cup from repeatedly filling to the brim and
>>>>>> overflowing. While not a definitive fix, the following change might help
>>>>>> improve the situation:
>>>>>>
>>>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>>>>
>>>>>> index 17af08367c68..f2fa0eeb2d9a 100644
>>>>>> --- a/mm/memcontrol.c
>>>>>> +++ b/mm/memcontrol.c
>>>>>>
>>>>>> @@ -4559,7 +4559,10 @@ int mem_cgroup_swapin_charge_folio(struct folio
>>>>>> *folio, struct mm_struct *mm,
>>>>>>                 memcg = get_mem_cgroup_from_mm(mm);
>>>>>>         rcu_read_unlock();
>>>>>>
>>>>>> -       ret = charge_memcg(folio, memcg, gfp);
>>>>>> +       if (folio_test_large(folio) && mem_cgroup_margin(memcg) <
>>>>>> MEMCG_CHARGE_BATCH)
>>>>>> +               ret = -ENOMEM;
>>>>>> +       else
>>>>>> +               ret = charge_memcg(folio, memcg, gfp);
>>>>>>
>>>>>>         css_put(&memcg->css);
>>>>>>         return ret;
>>>>>> }
>>>>>>
>>>>>
>>>>> The diff makes sense to me. Let me test later today and get back to you.
>>>>>
>>>>> Thanks!
>>>>>
>>>>>> Please confirm if it makes the kernel build with memcg limitation
>>>>>> faster. If so, let's
>>>>>> work together to figure out an official patch :-) The above code hasn't consider
>>>>>> the parent memcg's overflow, so not an ideal fix.
>>>>>>
>>>>
>>>> Thanks Barry, I think this fixes the regression, and even gives an improvement!
>>>> I think the below might be better to do:
>>>>
>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>> index c098fd7f5c5e..0a1ec55cc079 100644
>>>> --- a/mm/memcontrol.c
>>>> +++ b/mm/memcontrol.c
>>>> @@ -4550,7 +4550,11 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
>>>>                 memcg = get_mem_cgroup_from_mm(mm);
>>>>         rcu_read_unlock();
>>>>
>>>> -       ret = charge_memcg(folio, memcg, gfp);
>>>> +       if (folio_test_large(folio) &&
>>>> +           mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_nr_pages(folio)))
>>>> +               ret = -ENOMEM;
>>>> +       else
>>>> +               ret = charge_memcg(folio, memcg, gfp);
>>>>
>>>>         css_put(&memcg->css);
>>>>         return ret;
>>>>
>>>>
>>>> AMD 16K+32K THP=always
>>>> metric         mm-unstable      mm-unstable + large folio zswapin series    mm-unstable + large folio zswapin + no swap thrashing fix
>>>> real           1m23.038s        1m23.050s                                   1m22.704s
>>>> user           53m57.210s       53m53.437s                                  53m52.577s
>>>> sys            7m24.592s        7m48.843s                                   7m22.519s
>>>> zswpin         612070           999244                                      815934
>>>> zswpout        2226403          2347979                                     2054980
>>>> pgfault        20667366         20481728                                    20478690
>>>> pgmajfault     385887           269117                                      309702
>>>>
>>>> AMD 16K+32K+64K THP=always
>>>> metric         mm-unstable      mm-unstable + large folio zswapin series   mm-unstable + large folio zswapin + no swap thrashing fix
>>>> real           1m22.975s        1m23.266s                                  1m22.549s
>>>> user           53m51.302s       53m51.069s                                 53m46.471s
>>>> sys            7m40.168s        7m57.104s                                  7m25.012s
>>>> zswpin         676492           1258573                                    1225703
>>>> zswpout        2449839          2714767                                    2899178
>>>> pgfault        17540746         17296555                                   17234663
>>>> pgmajfault     429629           307495                                     287859
>>>>
>>>
>>> Thanks Usama and Barry for looking into this. It seems like this would
>>> fix a regression with large folio swapin regardless of zswap. Can the
>>> same result be reproduced on zram without this series?
>>
>>
>> Yes, its a regression in large folio swapin support regardless of zswap/zram.
>>
>> Need to do 3 tests, one with probably the below diff to remove large folio support,
>> one with current upstream and one with upstream + swap thrashing fix.
>>
>> We only use zswap and dont have a zram setup (and I am a bit lazy to create one :)).
>> Any zram volunteers to try this?
> 
> Hi Usama,
> 
> I tried a quick experiment:
> 
> echo 1 > /sys/module/zswap/parameters/enabled
> echo 0 > /sys/module/zswap/parameters/enabled
> 
> This was to test the zRAM scenario. Enabling zswap even
> once disables mTHP swap-in. :)
> 
> I noticed a similar regression with zRAM alone, but the change resolved
> the issue and even sped up the kernel build compared to the setup without
> mTHP swap-in.

Thanks for trying, this is amazing!
> 
> However, I’m still working on a proper patch to address this. The current
> approach:
> 
> mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_nr_pages(folio))
> 
> isn’t sufficient, as it doesn’t cover cases where group A contains group B, and
> we’re operating within group B. The problem occurs not at the boundary of
> group B but at the boundary of group A.

I am not sure I completely followed this. As MEMCG_CHARGE_BATCH=64, if we are
trying to swapin a 16kB page, we basically check if atleast 64/4 = 16 folios can be
charged to cgroup, which is reasonable. If we try to swapin a 1M folio, we just
check if we can charge atleast 1 folio. Are you saying that checking just 1 folio
is not enough in this case and can still cause thrashing, i.e we should check more?

If we want to maintain consitency for all folios another option is
mem_cgroup_margin(memcg) < MEMCG_CHARGE_BATCH * folio_nr_pages(folio)
but I think this is too extreme, we would be checking if 64M can be charged to
cgroup just to swapin 1M.

> 
> I believe there’s still room for improvement. For example, if a 64KB charge
> attempt fails, there’s no need to waste time trying 32KB or 16KB. We can
> directly fall back to 4KB, as 32KB and 16KB will also fail based on our
> margin detection logic.
> 

Yes that makes sense. Would something like below work to fix that:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c098fd7f5c5e..0a1ec55cc079 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4550,7 +4550,11 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
                memcg = get_mem_cgroup_from_mm(mm);
        rcu_read_unlock();
 
-       ret = charge_memcg(folio, memcg, gfp);
+       if (folio_test_large(folio) &&
+           mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_nr_pages(folio)))
+               ret = -ENOMEM;
+       else
+               ret = charge_memcg(folio, memcg, gfp);
 
        css_put(&memcg->css);
        return ret;
diff --git a/mm/memory.c b/mm/memory.c
index fecdd044bc0b..b6ce6605dc63 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4123,6 +4123,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
        pte_t *pte;
        gfp_t gfp;
        int order;
+       int ret;
 
        /*
         * If uffd is active for the vma we need per-page fault fidelity to
@@ -4170,9 +4171,13 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
                addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
                folio = vma_alloc_folio(gfp, order, vma, addr, true);
                if (folio) {
-                       if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
-                                                           gfp, entry))
+                       ret = mem_cgroup_swapin_charge_folio(folio, vma->vm_mm, gfp, entry);
+                       if (!ret) {
                                return folio;
+                       } else if (ret == -ENOMEM) {
+                               folio_put(folio);
+                               goto fallback;
+                       }
                        folio_put(folio);
                }
                order = next_order(&orders, order);


