Return-Path: <linux-kernel+bounces-173331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED898BFF06
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F2D28BDA6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D6882876;
	Wed,  8 May 2024 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rKc2VW1w"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA0679B9D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175681; cv=none; b=bfiJ+3ldluSdTo25nyaJ0oI1EFidnKLL21FCEDbaASRdi8SBqGtlLiVjz/chkkdEOVgRlrDEyos+8l6ivAz4CP4VVGoSat42o1xRZj5WuhiprDgwj30YKr6IWSURkaJbViQix7BaVu8uL6gxI/frkYuCpOuz5D0CGyvAxFzc3gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175681; c=relaxed/simple;
	bh=o8olPzSeQq0O2st52A0umUMGgyxIaxK4E5u+1qqFwQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4xsJMem7xSx/Z95fm/MibLDFObsc3Ov70xdyEfqr+sPeRkjVo2qdb2Krc4dw5b7Fy/+Pt2Z0IM28/gsmnq9OBaQVblZ8fVjqZh6WtuHEIzTQAZKtsYNa3D0kNZfYWzKq4wyxVJBYdOHFNDPqCCHx9zbWBT63DThjaPoWPP5VmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rKc2VW1w; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715175674; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IWHfvBV+F3yFlGdOQ1Q3mOZgyc0OCykO4A66rQKOeTY=;
	b=rKc2VW1w21dWCEmv7eqWZfXg1AsR3bMoQPEZ/iqF0MEW9+1zAJJznCdJh6p1QMki9yvYt68Z7n0SPc6dGrBqST6jBiJsC4FyeossdnQA7cwKt+NdDhmah9cs+uLaCs2wwmxYeveBirRcL2vshoZPdM+i1D9bVcsbpv1Id9Exe6o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W63uK1o_1715175671;
Received: from 30.27.69.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W63uK1o_1715175671)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 21:41:13 +0800
Message-ID: <404add29-2d3f-45db-9103-0c5b66fb254e@linux.alibaba.com>
Date: Wed, 8 May 2024 21:41:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
To: hailong.liu@oppo.com, akpm@linux-foundation.org,
 Michal Hocko <mhocko@suse.com>
Cc: urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
 21cnbao@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 xiang@kernel.org, chao@kernel.org, Oven <liyangouwen1@oppo.com>
References: <20240508125808.28882-1-hailong.liu@oppo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240508125808.28882-1-hailong.liu@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


+Cc Michal,

On 2024/5/8 20:58, hailong.liu@oppo.com wrote:
> From: "Hailong.Liu" <hailong.liu@oppo.com>
> 
> Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
> includes support for __GFP_NOFAIL, but it presents a conflict with
> commit dd544141b9eb ("vmalloc: back off when the current task is
> OOM-killed"). A possible scenario is as belows:
> 
> process-a
> kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
>      __vmalloc_node_range()
> 	__vmalloc_area_node()
> 	    vm_area_alloc_pages()
>              --> oom-killer send SIGKILL to process-a
>              if (fatal_signal_pending(current)) break;
> --> return NULL;
> 
> to fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
> if __GFP_NOFAIL set.
> 
> Reported-by: Oven <liyangouwen1@oppo.com>
> Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>

Why taging this as RFC here?  It seems a corner-case fix of
commit a421ef303008

Thanks,
Gao Xiang

> ---
>   mm/vmalloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6641be0ca80b..2f359d08bf8d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3560,7 +3560,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> 
>   	/* High-order pages or fallback path if "bulk" fails. */
>   	while (nr_allocated < nr_pages) {
> -		if (fatal_signal_pending(current))
> +		if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current))
>   			break;
> 
>   		if (nid == NUMA_NO_NODE)
> ---
> This issue occurred during OPLUS KASAN test. Below is part of the log
> 
> -> send signal
> [65731.222840] [ T1308] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/apps/uid_10198,task=gs.intelligence,pid=32454,uid=10198
> 
> [65731.259685] [T32454] Call trace:
> [65731.259698] [T32454]  dump_backtrace+0xf4/0x118
> [65731.259734] [T32454]  show_stack+0x18/0x24
> [65731.259756] [T32454]  dump_stack_lvl+0x60/0x7c
> [65731.259781] [T32454]  dump_stack+0x18/0x38
> [65731.259800] [T32454]  mrdump_common_die+0x250/0x39c [mrdump]
> [65731.259936] [T32454]  ipanic_die+0x20/0x34 [mrdump]
> [65731.260019] [T32454]  atomic_notifier_call_chain+0xb4/0xfc
> [65731.260047] [T32454]  notify_die+0x114/0x198
> [65731.260073] [T32454]  die+0xf4/0x5b4
> [65731.260098] [T32454]  die_kernel_fault+0x80/0x98
> [65731.260124] [T32454]  __do_kernel_fault+0x160/0x2a8
> [65731.260146] [T32454]  do_bad_area+0x68/0x148
> [65731.260174] [T32454]  do_mem_abort+0x151c/0x1b34
> [65731.260204] [T32454]  el1_abort+0x3c/0x5c
> [65731.260227] [T32454]  el1h_64_sync_handler+0x54/0x90
> [65731.260248] [T32454]  el1h_64_sync+0x68/0x6c
> [65731.260269] [T32454]  z_erofs_decompress_queue+0x7f0/0x2258
> --> be->decompressed_pages = kvcalloc(be->nr_pages, sizeof(struct page *), GFP_KERNEL | __GFP_NOFAIL);
> 	kernel panic by NULL pointer dereference.
> 	erofs assume kvmalloc with __GFP_NOFAIL never return NULL.
> 
> [65731.260293] [T32454]  z_erofs_runqueue+0xf30/0x104c
> [65731.260314] [T32454]  z_erofs_readahead+0x4f0/0x968
> [65731.260339] [T32454]  read_pages+0x170/0xadc
> [65731.260364] [T32454]  page_cache_ra_unbounded+0x874/0xf30
> [65731.260388] [T32454]  page_cache_ra_order+0x24c/0x714
> [65731.260411] [T32454]  filemap_fault+0xbf0/0x1a74
> [65731.260437] [T32454]  __do_fault+0xd0/0x33c
> [65731.260462] [T32454]  handle_mm_fault+0xf74/0x3fe0
> [65731.260486] [T32454]  do_mem_abort+0x54c/0x1b34
> [65731.260509] [T32454]  el0_da+0x44/0x94
> [65731.260531] [T32454]  el0t_64_sync_handler+0x98/0xb4
> [65731.260553] [T32454]  el0t_64_sync+0x198/0x19c
> 
> --
> 2.34.1

