Return-Path: <linux-kernel+bounces-273583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C100E946AF3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 21:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0FE281F72
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 19:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6151CD02;
	Sat,  3 Aug 2024 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VLNK5uoZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5A15ACA
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722712102; cv=none; b=tjvmu1JtNzDUmFIrnQ3qCy88Kvm+GlKRz3gAsk5zgtMV2TCRVFa6t7PVAHuSincIWQrTC5S+G5b5bft48IW51LnM7e8LoFVEboj1D3G3kXMp1XVo40xcvV4xDg1X72rzV5hKkXJS59+m3TcOHTtoh+eXwZ3S3ZLzThKNk95pkRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722712102; c=relaxed/simple;
	bh=M4MvruE1F4Gz3Tgefob3wbbY6lpPmTqXqxP8x8F1p9E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FJXiVtxKqqFLGmfrH+Z7HoT1CWSBc7ie6x7Au0hS5JIiMUg/kXyz0y1U5Grrjhw8nIgylrL8B8TyEfxMzUHT1yLic4wGyjB1hFxH6iVNsXR70D2uH4LtCKUOmlI1puVZRTSdTS99GNoj98EJS7qrUtIOwL2XKpcif0N00I+wGOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VLNK5uoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F02C116B1;
	Sat,  3 Aug 2024 19:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722712102;
	bh=M4MvruE1F4Gz3Tgefob3wbbY6lpPmTqXqxP8x8F1p9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VLNK5uoZn/RSkGEnGD++mhKTHZ6Hn/ntuYHrFSBubyI0M7T699Z9WWetd6WcmqUVy
	 Txw1ZsxOnneKRX4TgtVilL8a78UlzSToOpNBdg4/lLRCBaDIroV5mcVkdZ6Uou79Tk
	 vhbHtNTX/8epGxMSR+/72D/0uAj0AB56gLpOb8JQ=
Date: Sat, 3 Aug 2024 12:08:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, baolin.wang@linux.alibaba.com, chrisl@kernel.org,
 david@redhat.com, hannes@cmpxchg.org, hughd@google.com,
 kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org,
 mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com,
 ryan.roberts@arm.com, senozhatsky@chromium.org, shakeel.butt@linux.dev,
 shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
 yosryahmed@google.com, hch@infradead.org, Chuanhua Han
 <hanchuanhua@oppo.com>
Subject: Re: [PATCH v6 2/2] mm: support large folios swap-in for zRAM-like
 devices
Message-Id: <20240803120819.b2f539115ad3cec84de967bf@linux-foundation.org>
In-Reply-To: <20240802122031.117548-3-21cnbao@gmail.com>
References: <20240726094618.401593-1-21cnbao@gmail.com>
	<20240802122031.117548-1-21cnbao@gmail.com>
	<20240802122031.117548-3-21cnbao@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  3 Aug 2024 00:20:31 +1200 Barry Song <21cnbao@gmail.com> wrote:

> From: Chuanhua Han <hanchuanhua@oppo.com>
> 
> Currently, we have mTHP features, but unfortunately, without support for large
> folio swap-ins, once these large folios are swapped out, they are lost because
> mTHP swap is a one-way process. The lack of mTHP swap-in functionality prevents
> mTHP from being used on devices like Android that heavily rely on swap.
> 
> This patch introduces mTHP swap-in support. It starts from sync devices such
> as zRAM. This is probably the simplest and most common use case, benefiting
> billions of Android phones and similar devices with minimal implementation
> cost. In this straightforward scenario, large folios are always exclusive,
> eliminating the need to handle complex rmap and swapcache issues.
> 
> It offers several benefits:
> 1. Enables bidirectional mTHP swapping, allowing retrieval of mTHP after
>    swap-out and swap-in. Large folios in the buddy system are also
>    preserved as much as possible, rather than being fragmented due
>    to swap-in.
> 
> 2. Eliminates fragmentation in swap slots and supports successful
>    THP_SWPOUT.
> 
>    w/o this patch (Refer to the data from Chris's and Kairui's latest
>    swap allocator optimization while running ./thp_swap_allocator_test
>    w/o "-a" option [1]):
> 
> ...
>
> +static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>
> ...
>
> +#endif
> +	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->address, false);
> +}

Generates an unused-variable warning with allnoconfig.  Because
vma_alloc_folio_noprof() was implemented as a macro instead of an
inlined C function.  Why do we keep doing this.

Please check:

From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm-support-large-folios-swap-in-for-zram-like-devices-fix
Date: Sat Aug  3 11:59:00 AM PDT 2024

fix unused var warning

mm/memory.c: In function 'alloc_swap_folio':
mm/memory.c:4062:32: warning: unused variable 'vma' [-Wunused-variable]
 4062 |         struct vm_area_struct *vma = vmf->vma;
      |                                ^~~

Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <v-songbaohua@oppo.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Chuanhua Han <hanchuanhua@oppo.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Gao Xiang <xiang@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memory.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/mm/memory.c~mm-support-large-folios-swap-in-for-zram-like-devices-fix
+++ a/mm/memory.c
@@ -4059,8 +4059,8 @@ static inline bool can_swapin_thp(struct
 
 static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	struct vm_area_struct *vma = vmf->vma;
 	unsigned long orders;
 	struct folio *folio;
 	unsigned long addr;
@@ -4128,7 +4128,8 @@ static struct folio *alloc_swap_folio(st
 
 fallback:
 #endif
-	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->address, false);
+	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vmf->vma,
+			       vmf->address, false);
 }
 
 
_


