Return-Path: <linux-kernel+bounces-432239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1F49E4822
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CB41880421
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E701F541A;
	Wed,  4 Dec 2024 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XRsnoFzd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CC723918D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733352561; cv=none; b=KHXY9jEJN9iyjItZxOQb0KYskSnR3cujU71SjB9NZQHyWJDW7tLGc2WNnOoDx5hg4mCNjUajyw4BmfVT9ugUs8Fyyp19QLGIp3/0HEIVwsnUGmshwKU0bydsECorUHz7PcPHk+tfKsjC37WVqgGpV9hqyX+UlXiI4xnX2WNWaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733352561; c=relaxed/simple;
	bh=QSx0YX9GTvAnD4VTmejGcVAQBDaWQeLp1doZlxhzA0c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YYut4ee4CcPWKx5gAjpvYn0ZMd9oLmwD3tDoMSP/4aq8JHrIAU1rf9W+DanTFqyf/jTshcwStmQ7gj9x5WRJINnNEhMMiql6sjhydooL3zaTrkTc9B0yJy/X1VKvdMGOvlTcTWYwuY9eABiYYlt8wRaWAFImwoBL9xbJVURBwng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XRsnoFzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F71C4CECD;
	Wed,  4 Dec 2024 22:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733352559;
	bh=QSx0YX9GTvAnD4VTmejGcVAQBDaWQeLp1doZlxhzA0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XRsnoFzdu0bluJdapeLXPwObNVqO0YnPagJLcVZJ44RzCRf/dpZgRF4ddR9LVU4UN
	 BjOLCnQQ8ubJWq/PMVFmTEx1T+wLAdmNH2sd1Th2zGH+jOUIxwFIYLW4RVzSMTBf1U
	 pyLrAjnYCtuTZMNpgn+/8//9A6bWkGo0ZrhSmT70=
Date: Wed, 4 Dec 2024 14:49:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: david@redhat.com, jannh@google.com, hughd@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 peterx@redhat.com, mgorman@suse.de, catalin.marinas@arm.com,
 will@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, x86@kernel.org, lorenzo.stoakes@oracle.com,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/11] synchronously scan and reclaim empty user PTE
 pages
Message-Id: <20241204144918.b08dbdd99903d3e18a27eb44@linux-foundation.org>
In-Reply-To: <cover.1733305182.git.zhengqi.arch@bytedance.com>
References: <cover.1733305182.git.zhengqi.arch@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Dec 2024 19:09:40 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> 
> ...
>
> Previously, we tried to use a completely asynchronous method to reclaim empty
> user PTE pages [1]. After discussing with David Hildenbrand, we decided to
> implement synchronous reclaimation in the case of madvise(MADV_DONTNEED) as the
> first step.

Please help us understand what the other steps are.  Because we dont
want to commit to a particular partial implementation only to later
discover that completing that implementation causes us problems.

> So this series aims to synchronously free the empty PTE pages in
> madvise(MADV_DONTNEED) case. We will detect and free empty PTE pages in
> zap_pte_range(), and will add zap_details.reclaim_pt to exclude cases other than
> madvise(MADV_DONTNEED).
> 
> In zap_pte_range(), mmu_gather is used to perform batch tlb flushing and page
> freeing operations. Therefore, if we want to free the empty PTE page in this
> path, the most natural way is to add it to mmu_gather as well. Now, if
> CONFIG_MMU_GATHER_RCU_TABLE_FREE is selected, mmu_gather will free page table
> pages by semi RCU:
> 
>  - batch table freeing: asynchronous free by RCU
>  - single table freeing: IPI + synchronous free
> 
> But this is not enough to free the empty PTE page table pages in paths other
> that munmap and exit_mmap path, because IPI cannot be synchronized with
> rcu_read_lock() in pte_offset_map{_lock}(). So we should let single table also
> be freed by RCU like batch table freeing.
> 
> As a first step, we supported this feature on x86_64 and selectd the newly
> introduced CONFIG_ARCH_SUPPORTS_PT_RECLAIM.
> 
> For other cases such as madvise(MADV_FREE), consider scanning and freeing empty
> PTE pages asynchronously in the future.

Handling MADV_FREE sounds fairly straightforward?



