Return-Path: <linux-kernel+bounces-363456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C10099C2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4E91C254E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05C114A4F7;
	Mon, 14 Oct 2024 08:14:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F29A13D537
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893642; cv=none; b=RYN2uk0eFWn9lbyKW6q1xRhbJX/2x/wwWDXA/G1QGUOG8PxoF0GwhuY4n9n6nnEBUOw49HQLfb8FVSlThUCjeYjwqs6uUFMGrYOg6BOoieeDupU0bSo4eR4MGFGgWoDCirF0nF6nNsZdKbnXcKU+J1ZRs18eIL5hioCrJzTvq9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893642; c=relaxed/simple;
	bh=YltVEum8JEEazY4xDjz2+jAbzXELSy9dlOHvgdb4TOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcmB08vjH1bAdmf3KaRMwc9n/mfWJ/Xo2CY6p3tbGAHNQ1Ik5TaGIv4M+yoSgbn8dpsgydCNIgDLTgPQiaixLnKuT0wD5WsQEQTucy9cR+vgbtUz2iy2GbVGh9ee8c/WNFjSRgKyZ9osOENwisd3o9PeGAgNyp3J2UNPCXCVk68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F19C31007;
	Mon, 14 Oct 2024 01:14:27 -0700 (PDT)
Received: from [10.163.38.184] (unknown [10.163.38.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5866F3F71E;
	Mon, 14 Oct 2024 01:13:55 -0700 (PDT)
Message-ID: <c34b962b-8b9a-41e5-a54e-364b826c5e2a@arm.com>
Date: Mon, 14 Oct 2024 13:43:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
To: Chen Ridong <chenridong@huaweicloud.com>, akpm@linux-foundation.org,
 david@fromorbit.com, zhengqi.arch@bytedance.com, roman.gushchin@linux.dev,
 muchun.song@linux.dev
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, chenridong@huawei.com,
 wangweiyang2@huawei.com
References: <20241014032336.482088-1-chenridong@huaweicloud.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241014032336.482088-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/14/24 08:53, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> A memleak was found as bellow:
> 
> unreferenced object 0xffff8881010d2a80 (size 32):
>   comm "mkdir", pid 1559, jiffies 4294932666
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
>   backtrace (crc 2e7ef6fa):
>     [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
>     [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
>     [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
>     [<ffffffff81198dd9>] online_css+0x29/0xa0
>     [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
>     [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
>     [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
>     [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
>     [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
>     [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
>     [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
>     [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> In the alloc_shrinker_info function, when shrinker_unit_alloc return
> err, the info won't be freed. Just fix it.
> 
> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  mm/shrinker.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index dc5d2a6fcfc4..92270413190d 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -97,6 +97,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>  
>  err:
>  	mutex_unlock(&shrinker_mutex);
> +	kvfree(info);
>  	free_shrinker_info(memcg);
>  	return -ENOMEM;
>  }

There are two scenarios when "goto err:" gets called

- When shrinker_info allocations fails, no kvfree() is required
	- but after this change kvfree() would be called even
	  when the allocation had failed originally, which does
	  not sound right

- shrinker_unit_alloc() fails, kvfree() is actually required

I guess kvfree() should be called just after shrinker_unit_alloc()
fails but before calling into "goto err".

But curious, should not both kvzalloc_node()/kvfree() be avoided
while inside mutex lock to avoid possible lockdep issues ?

