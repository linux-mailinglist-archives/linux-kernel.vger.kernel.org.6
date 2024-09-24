Return-Path: <linux-kernel+bounces-336451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01536983B05
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB3E1F22E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE2D1B85EB;
	Tue, 24 Sep 2024 01:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YnIjX8nw"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AD638C
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727142949; cv=none; b=Vw+VjNd8Fjr4G3gSe1UGcYWWC/mQGGNK/GAu2+S4aVp2xdtgA58LiRPX8wKsjoQWC5q3FOYzfY6yH/nHIWtlB2XsycGmWYclsSYpmLrlWxQzXVzDVTYTf/ZXJchlCwCmpkoerlg+n4QkEfj86EsBobdsDkgDU6xTLD2VjvyZrrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727142949; c=relaxed/simple;
	bh=eQGfIO9HSMg5Exet2LE6v9ak0XY9XAXLv94DDnuCHJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtAVytvK8pJDosXnScqHthFCT/J3T5bJMkKuYy3c8TJpLp4+2zCTFZndmFH42yoh1DXKdzcg7LDoH6TPzji9MNF4y5JqeWVWbWpueOVWAc5hTpM9sN4eSJzzowMTeeRQNZ3yQ6AaRC1mA7rlCau7KsKxUUbDVFBSgm/1gairYGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YnIjX8nw; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727142944; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QK7m63y5+dM5qtwR3OerysVuM/WrkXtW1Hv0gD6hl6k=;
	b=YnIjX8nwVNg27ERRcjFzVwyz60P0Eug6l5pH5CL9Ez/eb0YOWMz5HobVz8N0mmKR9rOys1ak059xAdOkkx0pkCHk4dVjm2SOD8bRGZaQ2L1KsZRvaeyfd9laIn+9/w3WRA67CphG5H0h2TqWEl739KvJ/t4/rZuBR3NCAnNo3mo=
Received: from 30.74.144.117(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WFe6d.J_1727142941)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 09:55:42 +0800
Message-ID: <4d38c65d-760c-43a5-bb47-8e0235c13a51@linux.alibaba.com>
Date: Tue, 24 Sep 2024 09:55:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, yosryahmed@google.com, hughd@google.com,
 shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
 chrisl@kernel.org, david@redhat.com, kasong@tencent.com,
 willy@infradead.org, viro@zeniv.linux.org.uk, baohua@kernel.org,
 chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
 linux-kernel@vger.kernel.org
References: <20240923231142.4155415-1-nphamcs@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240923231142.4155415-1-nphamcs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/24 07:11, Nhat Pham wrote:
> The SWAP_MAP_SHMEM state was originally introduced in the commit
> aaa468653b4a ("swap_info: note SWAP_MAP_SHMEM"), to quickly determine if a
> swap entry belongs to shmem during swapoff.
> 
> However, swapoff has since been rewritten drastically in the commit
> b56a2d8af914 ("mm: rid swapoff of quadratic complexity"). Now
> having swap count == SWAP_MAP_SHMEM value is basically the same as having
> swap count == 1, and swap_shmem_alloc() behaves analogously to
> swap_duplicate()
>      
> This RFC proposes the removal of this state and the associated helper to
> simplify the state machine (both mentally and code-wise). We will also
> have an extra state/special value that can be repurposed (for swap entries
> that never gets re-duplicated).
> 
> Another motivation (albeit a bit premature at the moment) is the new swap
> abstraction I am currently working on, that would allow for swap/zswap
> decoupling, swapoff optimization, etc. The fewer states and swap API
> functions there are, the simpler the conversion will be.
> 
> I am sending this series first as an RFC, just in case I missed something
> or misunderstood this state, or if someone has a swap optimization in mind
> for shmem that would require this special state.

The idea makes sense to me. I did a quick test with shmem mTHP, and 
encountered the following warning which is triggered by 
'VM_WARN_ON(usage == 1 && nr > 1)' in __swap_duplicate().

[   81.064967] ------------[ cut here ]------------
[   81.064968] WARNING: CPU: 4 PID: 6852 at mm/swapfile.c:3623 
__swap_duplicate+0x1d0/0x2e0
[   81.064994] pstate: 23400005 (nzCv daif +PAN -UAO +TCO +DIT -SSBS 
BTYPE=--)
[   81.064995] pc : __swap_duplicate+0x1d0/0x2e0
[   81.064997] lr : swap_duplicate_nr+0x30/0x70
[......]
[   81.065019] Call trace:
[   81.065019]  __swap_duplicate+0x1d0/0x2e0
[   81.065021]  swap_duplicate_nr+0x30/0x70
[   81.065022]  shmem_writepage+0x24c/0x438
[   81.065024]  pageout+0x104/0x2e0
[   81.065026]  shrink_folio_list+0x7f0/0xe60
[   81.065027]  reclaim_folio_list+0x90/0x178
[   81.065029]  reclaim_pages+0x128/0x1a8
[   81.065030]  madvise_cold_or_pageout_pte_range+0x80c/0xd10
[   81.065031]  walk_pmd_range.isra.0+0x1b8/0x3a0
[   81.065033]  walk_pud_range+0x120/0x1b0
[   81.065035]  walk_pgd_range+0x150/0x1a8
[   81.065036]  __walk_page_range+0xa4/0xb8
[   81.065038]  walk_page_range+0x1c8/0x250
[   81.065039]  madvise_pageout+0xf4/0x280
[   81.065041]  madvise_vma_behavior+0x268/0x3f0
[   81.065042]  madvise_walk_vmas.constprop.0+0xb8/0x128
[   81.065043]  do_madvise.part.0+0xe8/0x2a0
[   81.065044]  __arm64_sys_madvise+0x64/0x78
[   81.065046]  invoke_syscall.constprop.0+0x54/0xe8
[   81.065048]  do_el0_svc+0xa4/0xc0
[   81.065050]  el0_svc+0x2c/0xb0
[   81.065052]  el0t_64_sync_handler+0xb8/0xc0
[   81.065054]  el0t_64_sync+0x14c/0x150

> Swap experts, let me know if I'm mistaken :) Otherwise if there is no
> objection I will resend this patch series again for merging.
> 
> Nhat Pham (2):
>    swapfile: add a batched variant for swap_duplicate()
>    swap: shmem: remove SWAP_MAP_SHMEM
> 
>   include/linux/swap.h | 16 ++++++++--------
>   mm/shmem.c           |  2 +-
>   mm/swapfile.c        | 28 +++++++++-------------------
>   3 files changed, 18 insertions(+), 28 deletions(-)
> 
> 
> base-commit: acfabf7e197f7a5bedf4749dac1f39551417b049

