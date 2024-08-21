Return-Path: <linux-kernel+bounces-294999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55797959532
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85523B247B1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642FB193435;
	Wed, 21 Aug 2024 06:58:31 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DF2193429
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223510; cv=none; b=oUcWri2C7Pn6SSu6K3GCeOppyx0pQithYwbplzE+IIM5itXVsalTeFqoUJ/DfKbXZ125Y3TgSO9pGtpLVdA3ZtCQr9OvfGC8+Vd4z5b9ggFlLaNL7LN5ovdYWbsuSTf8fGARClaKa3VJMAnY0uOeHBBv/UGvF4MSaV3Atqk07u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223510; c=relaxed/simple;
	bh=OYAUaBvmmhEbKDrF+5PsGJuiRJQ975zqwyOhxBg0G8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NkT3N7Lz4Vxga91SXTckKWgoghbHf4+QHrs+y5wt0nQVcUm06rcze64LewlsNMMPPgE1Re5fOwcrVV51uHMSpFaG1TfCE80LO46T/YfC4BHjTD8e8atMFcaISCR3H7bpQNsy7siwewWjckxSC3u7y8WA5MHqJcvlSK8ZP/h90y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WpccG4nNBz2Cn71;
	Wed, 21 Aug 2024 14:58:22 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (unknown [7.185.36.59])
	by mail.maildlp.com (Postfix) with ESMTPS id C21251400CA;
	Wed, 21 Aug 2024 14:58:24 +0800 (CST)
Received: from [10.174.178.155] (10.174.178.155) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 14:58:24 +0800
Message-ID: <6e744d2b-bbb3-4e1f-bd61-e0e971f974db@huawei.com>
Date: Wed, 21 Aug 2024 14:58:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, slub: prefetch freelist in ___slab_alloc()
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<zhangxiaoxu5@huawei.com>, <cl@linux.com>, <wangkefeng.wang@huawei.com>,
	<penberg@kernel.org>, <rientjes@google.com>, <iamjoonsoo.kim@lge.com>,
	<akpm@linux-foundation.org>, <vbabka@suse.cz>, <roman.gushchin@linux.dev>
References: <20240819070204.753179-1-liuyongqiang13@huawei.com>
 <CAB=+i9TxYRcr+ZRMD31SDay+899RXOwTvQevC=8sv7b27ZO1Vg@mail.gmail.com>
From: Yongqiang Liu <liuyongqiang13@huawei.com>
In-Reply-To: <CAB=+i9TxYRcr+ZRMD31SDay+899RXOwTvQevC=8sv7b27ZO1Vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500005.china.huawei.com (7.185.36.59)


在 2024/8/19 17:33, Hyeonggon Yoo 写道:
> On Mon, Aug 19, 2024 at 4:02 PM Yongqiang Liu <liuyongqiang13@huawei.com> wrote:
>> commit 0ad9500e16fe ("slub: prefetch next freelist pointer in
>> slab_alloc()") introduced prefetch_freepointer() for fastpath
>> allocation. Use it at the freelist firt load could have a bit
>> improvement in some workloads. Here is hackbench results at
>> arm64 machine(about 3.8%):
>>
>> Before:
>>    average time cost of 'hackbench -g 100 -l 1000': 17.068
>>
>> Afther:
>>    average time cost of 'hackbench -g 100 -l 1000': 16.416
>>
>> There is also having about 5% improvement at x86_64 machine
>> for hackbench.
> I think adding more prefetch might not be a good idea unless we have
> more real-world data supporting it because prefetch might help when slab
> is frequently used, but it will end up unnecessarily using more cache
> lines when slab is not frequently used.

Yes, prefetching unnecessary objects is a bad idea. But I think the slab 
entered

in slowpath that means it will more likely need more objects. I've 
tested the

cases from commit 0ad9500e16fe ("slub: prefetch next freelist pointer in
slab_alloc()"). Here is the result:

Before:

Performance counter stats for './hackbench 50 process 4000' (32 runs):

                 2545.28 msec task-clock                #    6.938 CPUs 
utilized        ( +-  1.75% )
                      6166     context-switches          #    0.002 
M/sec                    ( +-  1.58% )
                     1129      cpu-migrations            #    0.444 
K/sec                     ( +-  2.16% )
                   13298      page-faults                  # 0.005 
M/sec                    ( +-  0.38% )
         4435113150      cycles                           # 1.742 
GHz                         ( +-  1.22% )
         2259717630      instructions                 #    0.51 insn per 
cycle           ( +-  0.05% )
           385847392      branches                     #  151.593 
M/sec                    ( +-  0.06% )
              6205369       branch-misses            #    1.61% of all 
branches       ( +-  0.56% )

            0.36688 +- 0.00595 seconds time elapsed  ( +-  1.62% )
After:

  Performance counter stats for './hackbench 50 process 4000' (32 runs):

                2277.61 msec task-clock                #    6.855 CPUs 
utilized            ( +-  0.98% )
                     5653      context-switches         #    0.002 
M/sec                       ( +-  1.62% )
                     1081      cpu-migrations           #    0.475 
K/sec                        ( +-  1.89% )
                   13217      page-faults                 # 0.006 
M/sec                       ( +-  0.48% )
         3751509945      cycles                          #    1.647 
GHz                          ( +-  1.14% )
         2253177626      instructions                #    0.60 insn per 
cycle             ( +-  0.06% )
           384509166      branches                    #    168.821 
M/sec                    ( +-  0.07% )
               6045031      branch-misses           #    1.57% of all 
branches          ( +-  0.58% )

            0.33225 +- 0.00321 seconds time elapsed  ( +-  0.97% )

>
> Also I don't understand how adding prefetch in slowpath affects the performance
> because most allocs/frees should be done in the fastpath. Could you
> please explain?

By adding some debug info to count the slowpath for the hackbench:

'hackbench -g 100 -l 1000' slab alloc total: 80416886, and the slowpath: 
7184236.

About 9% slowpath in total allocation. The perf stats in arm64 as follow：

Before:
  Performance counter stats for './hackbench -g 100 -l 1000' (32 runs):

        34766611220 branches                      ( +-  0.01% )
            382593804      branch-misses                  # 1.10% of all 
branches          ( +-  0.14% )
          1120091414 cache-misses                 ( +-  0.08% )
        76810485402 L1-dcache-loads               ( +-  0.03% )
          1120091414      L1-dcache-load-misses     #    1.46% of all 
L1-dcache hits    ( +-  0.08% )

            23.8854 +- 0.0804 seconds time elapsed  ( +-  0.34% )

After:
  Performance counter stats for './hackbench -g 100 -l 1000' (32 runs):

        34812735277 branches                  ( +-  0.01% )
            393449644      branch-misses             #    1.13% of all 
branches           ( +-  0.15% )
          1095185949 cache-misses             ( +-  0.15% )
        76995789602 L1-dcache-loads             ( +-  0.03% )
          1095185949      L1-dcache-load-misses     #    1.42% of all 
L1-dcache hits    ( +-  0.15% )

             23.341 +- 0.104 seconds time elapsed  ( +-  0.45% )

It seems having less L1-dcache-load-misses.

>
>> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
>> ---
>>   mm/slub.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index c9d8a2497fd6..f9daaff10c6a 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -3630,6 +3630,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>          VM_BUG_ON(!c->slab->frozen);
>>          c->freelist = get_freepointer(s, freelist);
>>          c->tid = next_tid(c->tid);
>> +       prefetch_freepointer(s, c->freelist);
>>          local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>>          return freelist;
>>
>> --
>> 2.25.1
>>

