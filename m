Return-Path: <linux-kernel+bounces-378682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C479AD400
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB85284508
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824581CEADD;
	Wed, 23 Oct 2024 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUXya09z"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD0312DD88;
	Wed, 23 Oct 2024 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708310; cv=none; b=QXqrQyqqH8isYUBC1nnqGlK42mkIgJdRlm8uuepzNIE/4IB3GwagJJOC1V0zRJLVxEsYmaQxdiXR3t8h2HqDAYf/+nH5GhBiR7HSQ0WuocjNOFJUrSb+FcFAceY2YJn31+t1VghH1kF/PVQznLrsg5MVnhSnOIjoXTjc1taFopE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708310; c=relaxed/simple;
	bh=LDeRORQDUCNnPctUdVA1pj24Xt5W/uZx7DafSOrlzv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owZ13xpDMBXkkaiakjJHUSvGK49bxYwsrDp5FOaIxmjLeD2sNQh5bk5DXEFmbHGz2oRBvd2n70BTWHjw3twl6inmN6oC9qSQRkVstQ7HdbvY7IkYaoYL73Pwag17yMMs4RQebIf/7Md+OljEozgpUUM1BzeUTnWd4bPJGMH3mq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUXya09z; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99eb8b607aso809466b.2;
        Wed, 23 Oct 2024 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729708307; x=1730313107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EwQqP5AWVTYwFtS7kdVHGRz6sy9Kk9hcy334T4mBOI8=;
        b=NUXya09z4QUGSWaQwi7k6IFB6bzNYlphLtelcEbQXnnVNeE6Q7MYewlp2U+NbGExCb
         XlbdMGZrubi0Wkn7gbdZSLN1nLBVIP7WVQQAGumI6kFhg4FyP9qpJsfDOjoNNut3IO/U
         caEmFSUBpDmTvnYfnZYavLie86DbtCcvK0aZUxnfuwY3XGp1+ds0PYVs2V+JCaLt8zuN
         PaznQVuj5ZzHz9jkPAEP6UpOg78PbAvA7/WbhBSVSS/kVXrV274rhJBCmokMjeAgCDPO
         DzR06FesEi38gi2m6SwSMi29/tJk3v+nnuJ6CjYUgveasJ0OF/867HBLl1BXyNUpKQ+C
         qpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729708307; x=1730313107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwQqP5AWVTYwFtS7kdVHGRz6sy9Kk9hcy334T4mBOI8=;
        b=R2PQoFlaA3ylpRgcOVTqfTWXsFOoearyyKpEMPZdfE7+O9M6tVrA/AGXgOWzP542vM
         8DuCy2CwlohbQIw1Ec4HY04iDR6arofbkamx+JjdXE+qlLKDKMYVzuh8jXb1f+4lRjFn
         t52VTtRGahiaFBJEP7zKKV3CY24HUx35NrSpM5Sosc4gwYmWBqgfQ3nUeKzy+fxoMkip
         U/wb+5a0fWxK5EFwZ6QeJHy8Eo4htSs0O+RlPepoYMXrOTfnE8jAgIC3S5UlQx45cT9q
         jj+IgyXPgLn+cdeEsQZLeU0VbVrE3+CjckDUHBxjtVgLTUEi91ra8PwcEE0WbTPjdWHe
         Qy6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCKaKug3T6eqYPc7AxS/kI64Xfnc0loniE0NvO6wtA8yTJQgzSWXNii7Ut8Zrv2slFUILE0jiFFsA=@vger.kernel.org, AJvYcCXqZpkPqK6NIb1RVUIizvM+/+xR8o/QC9cg01kpTvizoi2lPFm4WeZFTUx0euJLJvc1WyEu447t5uFLvgAi@vger.kernel.org
X-Gm-Message-State: AOJu0Yze5kTXKH6PLYiHn/n4eg0+hbkjTxTmLuuRTSSLq8ZdF9kjy8au
	c5iBvGrRDBmSvwmDHyZrCK+y8//EnkCPe9kE3u3UAlo2AR3/F/EC
X-Google-Smtp-Source: AGHT+IG9s4/MZj0zBY44ccwxDxyYhdj18MMmDIcIqy+iQlSVXJUZgc60wgvOe/Bic0z/OFYSruZKqw==
X-Received: by 2002:a17:907:a08:b0:a9a:17f5:79a8 with SMTP id a640c23a62f3a-a9abf84a887mr322150666b.13.1729708307157;
        Wed, 23 Oct 2024 11:31:47 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:ca73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912edff8sm507478666b.59.2024.10.23.11.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 11:31:46 -0700 (PDT)
Message-ID: <3dca2498-363c-4ba5-a7e6-80c5e5532db5@gmail.com>
Date: Wed, 23 Oct 2024 19:31:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] mm: zswap: add support for zswapin of large folios
To: Yosry Ahmed <yosryahmed@google.com>, Barry Song <21cnbao@gmail.com>
Cc: senozhatsky@chromium.org, minchan@kernel.org, hanchuanhua@oppo.com,
 v-songbaohua@oppo.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 hannes@cmpxchg.org, david@redhat.com, willy@infradead.org,
 kanchana.p.sridhar@intel.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
 ryan.roberts@arm.com, ying.huang@intel.com, riel@surriel.com,
 shakeel.butt@linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
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
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkbrjV3Px8h1p950VZFi9FnzxZPn2Kg+vZD69eEcsQvtxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/10/2024 19:02, Yosry Ahmed wrote:
> [..]
>>>> I suspect the regression occurs because you're running an edge case
>>>> where the memory cgroup stays nearly full most of the time (this isn't
>>>> an inherent issue with large folio swap-in). As a result, swapping in
>>>> mTHP quickly triggers a memcg overflow, causing a swap-out. The
>>>> next swap-in then recreates the overflow, leading to a repeating
>>>> cycle.
>>>>
>>>
>>> Yes, agreed! Looking at the swap counters, I think this is what is going
>>> on as well.
>>>
>>>> We need a way to stop the cup from repeatedly filling to the brim and
>>>> overflowing. While not a definitive fix, the following change might help
>>>> improve the situation:
>>>>
>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>>
>>>> index 17af08367c68..f2fa0eeb2d9a 100644
>>>> --- a/mm/memcontrol.c
>>>> +++ b/mm/memcontrol.c
>>>>
>>>> @@ -4559,7 +4559,10 @@ int mem_cgroup_swapin_charge_folio(struct folio
>>>> *folio, struct mm_struct *mm,
>>>>                 memcg = get_mem_cgroup_from_mm(mm);
>>>>         rcu_read_unlock();
>>>>
>>>> -       ret = charge_memcg(folio, memcg, gfp);
>>>> +       if (folio_test_large(folio) && mem_cgroup_margin(memcg) <
>>>> MEMCG_CHARGE_BATCH)
>>>> +               ret = -ENOMEM;
>>>> +       else
>>>> +               ret = charge_memcg(folio, memcg, gfp);
>>>>
>>>>         css_put(&memcg->css);
>>>>         return ret;
>>>> }
>>>>
>>>
>>> The diff makes sense to me. Let me test later today and get back to you.
>>>
>>> Thanks!
>>>
>>>> Please confirm if it makes the kernel build with memcg limitation
>>>> faster. If so, let's
>>>> work together to figure out an official patch :-) The above code hasn't consider
>>>> the parent memcg's overflow, so not an ideal fix.
>>>>
>>
>> Thanks Barry, I think this fixes the regression, and even gives an improvement!
>> I think the below might be better to do:
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index c098fd7f5c5e..0a1ec55cc079 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -4550,7 +4550,11 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
>>                 memcg = get_mem_cgroup_from_mm(mm);
>>         rcu_read_unlock();
>>
>> -       ret = charge_memcg(folio, memcg, gfp);
>> +       if (folio_test_large(folio) &&
>> +           mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_nr_pages(folio)))
>> +               ret = -ENOMEM;
>> +       else
>> +               ret = charge_memcg(folio, memcg, gfp);
>>
>>         css_put(&memcg->css);
>>         return ret;
>>
>>
>> AMD 16K+32K THP=always
>> metric         mm-unstable      mm-unstable + large folio zswapin series    mm-unstable + large folio zswapin + no swap thrashing fix
>> real           1m23.038s        1m23.050s                                   1m22.704s
>> user           53m57.210s       53m53.437s                                  53m52.577s
>> sys            7m24.592s        7m48.843s                                   7m22.519s
>> zswpin         612070           999244                                      815934
>> zswpout        2226403          2347979                                     2054980
>> pgfault        20667366         20481728                                    20478690
>> pgmajfault     385887           269117                                      309702
>>
>> AMD 16K+32K+64K THP=always
>> metric         mm-unstable      mm-unstable + large folio zswapin series   mm-unstable + large folio zswapin + no swap thrashing fix
>> real           1m22.975s        1m23.266s                                  1m22.549s
>> user           53m51.302s       53m51.069s                                 53m46.471s
>> sys            7m40.168s        7m57.104s                                  7m25.012s
>> zswpin         676492           1258573                                    1225703
>> zswpout        2449839          2714767                                    2899178
>> pgfault        17540746         17296555                                   17234663
>> pgmajfault     429629           307495                                     287859
>>
> 
> Thanks Usama and Barry for looking into this. It seems like this would
> fix a regression with large folio swapin regardless of zswap. Can the
> same result be reproduced on zram without this series?


Yes, its a regression in large folio swapin support regardless of zswap/zram.

Need to do 3 tests, one with probably the below diff to remove large folio support,
one with current upstream and one with upstream + swap thrashing fix.

We only use zswap and dont have a zram setup (and I am a bit lazy to create one :)).
Any zram volunteers to try this?

diff --git a/mm/memory.c b/mm/memory.c
index fecdd044bc0b..62f6b087beb3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4124,6 +4124,8 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
        gfp_t gfp;
        int order;
 
+       goto fallback;
+
        /*
         * If uffd is active for the vma we need per-page fault fidelity to
         * maintain the uffd semantics. 

