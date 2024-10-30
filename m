Return-Path: <linux-kernel+bounces-389483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B619B6DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E7D2820A8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F711D1731;
	Wed, 30 Oct 2024 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHHuJ69b"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1C01F4713
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319933; cv=none; b=CtkdNQhA+B/xU/ywFstno4S10tE0cHt66mY+6dYDGKhMxZQ2pbjp9x90BTFhF+kzX41RcaIpbrueJ3O6usz4uBMMuvsjmUEGDs6V8GhUASbzIK1vQdoR/9PcQAJADNOVWsuq76+CHT1IcPVCwGbl7bp/sEbcl8imTlo9Yczi0e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319933; c=relaxed/simple;
	bh=WCu/usnA0Q15DcjK+Zvr4U/lQJ+yvOXim7r8vOA5y7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JieJIivSjyEtshACkXObsewE2M1Soo+NT6ef26tD7+knLvncR0YEcMMlvlRlp9yxhkyuI+2Zq4RXOBNIkfK8OduE2Oa3s4ZCtpN5+W3WPa7iftd7inNfxZeSI2+C1/gg0ZIRYYtECxye8mlXLGV+KxK760n7CljdpFxAYOYror4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHHuJ69b; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4316cce103dso2345115e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730319929; x=1730924729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fR2+vu403L40rXb7uTJaqctd7/7tN0LQaS/5y7wX67o=;
        b=bHHuJ69b4bX+NXfnIU+DlXB3fZ9YDrHPZRCJkz3qVJtgznQ0IHiNlbTnc01ca5/L/7
         kHJgQOcceVOz7HRC79QpviUYkXfz0JkqUrspTsU+0n22XrM2TlwrofvS2nYldPt1PX81
         0sEJEu0JhBl6HWK6KUH6mGeB4aLjhTQEW8FyP9xJ+WPY3ozH4UELoZupgYzBnf5f33N5
         I9O0n0PUApP4RlTm1/BAXoi+bz/tW08x7zoWfPwUrXHvkXuOz1Q3R1tKpMR6abyCkeAn
         1b4vxxLROh2Qu6cLpbfDYAOp6kNDL0xkm70ywkUs8GVio9CqzDfcw6wxYrL7V1H0bkNa
         TAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730319929; x=1730924729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fR2+vu403L40rXb7uTJaqctd7/7tN0LQaS/5y7wX67o=;
        b=fN0Jft759BqFTZPh+oe7MN2IXhJjllujQuviY06yn+HatPowsmC0MPsXzsyDcLC1RZ
         rgy8qVs2IlpGLKk19x2b1pv9x5B23PEba9MJpnVR+tJxJ1VmevfKQckdJReRvoewNBkn
         xom3Dj7qDzCuWcYqCxNdGa/+2H7pEB5lCmxOQH+qTyEgJPydcAseJnQJ7n15a7VDPGtJ
         hA9+/DdzRgaCPwdWs9DhaT+Oe3jrwop9+ig0vVou57ZXBjUvyEheb76KNj5BVdW0m4z8
         QvcTF8Aelg8aUbOFyaaXR1IzEpLp2esIEMhUELXbUWHaXOl+Fl+LYouFMBA1BSIRDPFS
         OIHA==
X-Forwarded-Encrypted: i=1; AJvYcCX+pcHoU6U4zq11HJkyHZW01+/FvIzkyOT8g2HoX+CZArRqKak0iHgMBOuu31ib3+W74DOf2SMw+lEXv+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2puK607MGAXXJOlwMPTE7wLwDigGrzJxAusyFQPPFEwEjGVHJ
	GvcXap5wBuWCCn8TlfDVX+dG7pmFgDMFYVKDcwJLtOfclH17rRtiRUjh9A==
X-Google-Smtp-Source: AGHT+IGTh7hqR4cXUiWQ4jlbKDxvDcPHYIrN4wJEVWmXREQG0vN4tnG4IFzCT3on6XUZFLt92kpOhw==
X-Received: by 2002:a05:600c:3107:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-4319ad065abmr169813115e9.28.1730319928745;
        Wed, 30 Oct 2024 13:25:28 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8471sm31810545e9.4.2024.10.30.13.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 13:25:28 -0700 (PDT)
Message-ID: <852211c6-0b55-4bdd-8799-90e1f0c002c1@gmail.com>
Date: Wed, 30 Oct 2024 20:25:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>,
 Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
References: <20241027001444.3233-1-21cnbao@gmail.com>
 <33c5d5ca-7bc4-49dc-b1c7-39f814962ae0@gmail.com>
 <CAGsJ_4wdgptMK0dDTC5g66OE9WDxFDt7ixDQaFCjuHdTyTEGiA@mail.gmail.com>
 <e8c6d46c-b8cf-4369-aa61-9e1b36b83fe3@gmail.com>
 <CAJD7tkZ60ROeHek92jgO0z7LsEfgPbfXN9naUC5j7QjRQxpoKw@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkZ60ROeHek92jgO0z7LsEfgPbfXN9naUC5j7QjRQxpoKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30/10/2024 19:51, Yosry Ahmed wrote:
> [..]
>>> My second point about the mitigation is as follows: For a system (or
>>> memcg) under severe memory pressure, especially one without hardware TLB
>>> optimization, is enabling mTHP always the right choice? Since mTHP operates at
>>> a larger granularity, some internal fragmentation is unavoidable, regardless
>>> of optimization. Could the mitigation code help in automatically tuning
>>> this fragmentation?
>>>
>>
>> I agree with the point that enabling mTHP always is not the right thing to do
>> on all platforms. I also think it might be the case that enabling mTHP
>> might be a good thing for some workloads, but enabling mTHP swapin along with
>> it might not.
>>
>> As you said when you have apps switching between foreground and background
>> in android, it probably makes sense to have large folio swapping, as you
>> want to bringin all the pages from background app as quickly as possible.
>> And also all the TLB optimizations and smaller lru overhead you get after
>> you have brought in all the pages.
>> Linux kernel build test doesnt really get to benefit from the TLB optimization
>> and smaller lru overhead, as probably the pages are very short lived. So I
>> think it doesnt show the benefit of large folio swapin properly and
>> large folio swapin should probably be disabled for this kind of workload,
>> eventhough mTHP should be enabled.
>>
>> I am not sure that the approach we are trying in this patch is the right way:
>> - This patch makes it a memcg issue, but you could have memcg disabled and
>> then the mitigation being tried here wont apply.
> 
> Is the problem reproducible without memcg? I imagine only if the
> entire system is under memory pressure. I guess we would want the same
> "mitigation" either way.
> 
What would be a good open source benchmark/workload to test without limiting memory
in memcg?
For the kernel build test, I can only get zswap activity to happen if I build
in cgroup and limit memory.max.

I can just run zswap large folio zswapin in production and see, but that will take me a few
days. tbh, running in prod is a much better test, and if there isn't any sort of thrashing,
then maybe its not really an issue? I believe Barry doesnt see an issue in android
phones (but please correct me if I am wrong), and if there isnt an issue in Meta 
production as well, its a good data point for servers as well. And maybe
kernel build in 4G memcg is not a good test.

>> - Instead of this being a large folio swapin issue, is it more of a readahead
>> issue? If we zswap (without the large folio swapin series) and change the window
>> to 1 in swap_vma_readahead, we might see an improvement in linux kernel build time
>> when cgroup memory is limited as readahead would probably cause swap thrashing as
>> well.
> 
> I think large folio swapin would make the problem worse anyway. I am
> also not sure if the readahead window adjusts on memory pressure or
> not.
> 
readahead window doesnt look at memory pressure. So maybe the same thing is being
seen here as there would be in swapin_readahead? Maybe if we check kernel build test
performance in 4G memcg with below diff, it might get better?  

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 4669f29cf555..9e196e1e6885 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -809,7 +809,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
        pgoff_t ilx;
        bool page_allocated;
 
-       win = swap_vma_ra_win(vmf, &start, &end);
+       win = 1;
        if (win == 1)
                goto skip;

>> - Instead of looking at cgroup margin, maybe we should try and look at
>> the rate of change of workingset_restore_anon? This might be a lot more complicated
>> to do, but probably is the right metric to determine swap thrashing. It also means
>> that this could be used in both the synchronous swapcache skipping path and
>> swapin_readahead path.
>> (Thanks Johannes for suggesting this)
>>
>> With the large folio swapin, I do see the large improvement when considering only
>> swapin performance and latency in the same way as you saw in zram.
>> Maybe the right short term approach is to have
>> /sys/kernel/mm/transparent_hugepage/swapin
>> and have that disabled by default to avoid regression.
>> If the workload owner sees a benefit, they can enable it.
>> I can add this when sending the next version of large folio zswapin if that makes
>> sense?
> 
> I would honestly prefer we avoid this if possible. It's always easy to
> just put features behind knobs, and then users have the toil of
> figuring out if/when they can use it, or just give up. We should find
> a way to avoid the thrashing due to hitting the memcg limit (or being
> under global memory pressure), it seems like something the kernel
> should be able to do on its own.
> 
>> Longer term I can try and have a look at if we can do something with
>> workingset_restore_anon to improve things.
> 
> I am not a big fan of this, mainly because reading a stat from the
> kernel puts us in a situation where we have to choose between:
> - Doing a memcg stats flush in the kernel, which is something we are
> trying to move away from due to various problems we have been running
> into.
> - Using potentially stale stats (up to 2s), which may be fine but is
> suboptimal at best. We may have blips of thrashing due to stale stats
> not showing the refaults.


