Return-Path: <linux-kernel+bounces-241751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D95D927F21
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE51E284DFC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 23:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CD1143C69;
	Thu,  4 Jul 2024 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dz1kDJ0T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7C5481B1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720135378; cv=none; b=YtMMELpe90BRSWgRHh/8DATzYYKKgq1kCErZfWLy6j+ZN9ypae8oiUDb8hRwkllXdTnc+GxnVB9utjouE7ct/YUqKEO5n0FtRousVvVbAWy2j8yFiBlK4FbfT9ymChuRxS4yXv4VF2IHWtg5Wlw/SYSXveUOZJLc+DjxRMOUMFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720135378; c=relaxed/simple;
	bh=WcyGzBDPm08jDqw9VW7mWQ1QgDFVUCZ5sEiUBFTEALY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YxUjAzllA4n91mnXt+/dzjTyw6vsN3ZC6iYDd2fCHCk0gNoDwKDADAbn8OLfs30Ryj737hIjPRz2LecDvLYL91BVXSXp5ua8WXhfy3Yji2Bce7rKcqlImEgjq6FDbP0hbh5GMaDNAuTH4b4k4YUa1zeAeI5lp4Hu23+drnAUQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Dz1kDJ0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DECC3277B;
	Thu,  4 Jul 2024 23:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720135377;
	bh=WcyGzBDPm08jDqw9VW7mWQ1QgDFVUCZ5sEiUBFTEALY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dz1kDJ0TGUKuQxQI0YRdtxhLnMEAjmd05nT+q/gspjPw1TfnMUwr5t0zrJ3dmmj6C
	 FTz6hJCYInPVC7ygaRAAkUsj3NV8OQO+ebkTDuq5FiWRyrqXfiQinc9yJsOxm4Pm64
	 2OYItLZ0tzEtlrUC7YEjNM8n5qEFW/xhhYT7cCzE=
Date: Thu, 4 Jul 2024 16:22:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev,
 david@redhat.com, ying.huang@intel.com, hughd@google.com,
 willy@infradead.org, yosryahmed@google.com, nphamcs@gmail.com,
 chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v7 1/2] mm: store zero pages to be swapped out in a
 bitmap
Message-Id: <20240704162256.f64fa9b6752d0d5e003f9c18@linux-foundation.org>
In-Reply-To: <6f8b64f8-b7b0-42f4-a1d4-bf79624cff1e@gmail.com>
References: <20240627105730.3110705-1-usamaarif642@gmail.com>
	<20240627105730.3110705-2-usamaarif642@gmail.com>
	<20240627161852.GA469122@cmpxchg.org>
	<44a57df4-e54c-47ee-96b8-e2361c549239@gmail.com>
	<aa573e39-8d27-475d-a3a1-27fdcfdcef56@gmail.com>
	<5743d4e4-3e34-4ac1-b4a9-0ddc4f0e624d@gmail.com>
	<6f8b64f8-b7b0-42f4-a1d4-bf79624cff1e@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jul 2024 20:15:46 +0300 Usama Arif <usamaarif642@gmail.com> wrote:

> Changes from v7 (Johannes):
> - Give overview and explain how locking works in zeromap in comments
> - Add comment for why last word is checked first when checking if
>   folio is zero-filled
> - Merge is_folio_zero_filled and is_folio_page_zero_filled into
>   1 function.
> - Use folio_zero_range to fill a folio with zero at readtime.
> - Put swap_zeromap_folio_clear in an else branch (even if checkpatch
>   gives warning) and add comment to make it explicitly clear that it
>   needs to happen if folio is not zero filled.
> - add missing kvfree for zeromap incase swapon fails.

I queued the below as a delta against what was in mm-unstable.

Can we please get this nailed down?  It has been nearly three weeks and
this patch is getting in the way of the "mm/zsmalloc: change back to
per-size_class lock" series, at least.

 include/linux/swap.h |    2 -
 mm/page_io.c         |   64 +++++++++++++++++++++--------------------
 mm/swapfile.c        |    9 +++--
 3 files changed, 40 insertions(+), 35 deletions(-)

--- a/include/linux/swap.h~mm-store-zero-pages-to-be-swapped-out-in-a-bitmap-v8
+++ a/include/linux/swap.h
@@ -299,7 +299,7 @@ struct swap_info_struct {
 	signed char	type;		/* strange name for an index */
 	unsigned int	max;		/* extent of the swap_map */
 	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
-	unsigned long *zeromap;		/* vmalloc'ed bitmap to track zero pages */
+	unsigned long *zeromap;		/* kvmalloc'ed bitmap to track zero pages */
 	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
 	struct swap_cluster_list free_clusters; /* free clusters list */
 	unsigned int lowest_bit;	/* index of first free in swap_map */
--- a/mm/page_io.c~mm-store-zero-pages-to-be-swapped-out-in-a-bitmap-v8
+++ a/mm/page_io.c
@@ -172,42 +172,34 @@ bad_bmap:
 	goto out;
 }
 
-static bool is_folio_page_zero_filled(struct folio *folio, int i)
-{
-	unsigned long *data;
-	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*data) - 1;
-	bool ret = false;
-
-	data = kmap_local_folio(folio, i * PAGE_SIZE);
-	if (data[last_pos])
-		goto out;
-	for (pos = 0; pos < PAGE_SIZE / sizeof(*data); pos++) {
-		if (data[pos])
-			goto out;
-	}
-	ret = true;
-out:
-	kunmap_local(data);
-	return ret;
-}
-
 static bool is_folio_zero_filled(struct folio *folio)
 {
+	unsigned int pos, last_pos;
+	unsigned long *data;
 	unsigned int i;
 
+	last_pos = PAGE_SIZE / sizeof(*data) - 1;
 	for (i = 0; i < folio_nr_pages(folio); i++) {
-		if (!is_folio_page_zero_filled(folio, i))
+		data = kmap_local_folio(folio, i * PAGE_SIZE);
+		/*
+		 * Check last word first, incase the page is zero-filled at
+		 * the start and has non-zero data at the end, which is common
+		 * in real-world workloads.
+		 */
+		if (data[last_pos]) {
+			kunmap_local(data);
 			return false;
+		}
+		for (pos = 0; pos < last_pos; pos++) {
+			if (data[pos]) {
+				kunmap_local(data);
+				return false;
+			}
+		}
+		kunmap_local(data);
 	}
-	return true;
-}
 
-static void folio_zero_fill(struct folio *folio)
-{
-	unsigned int i;
-
-	for (i = 0; i < folio_nr_pages(folio); i++)
-		clear_highpage(folio_page(folio, i));
+	return true;
 }
 
 static void swap_zeromap_folio_set(struct folio *folio)
@@ -278,12 +270,24 @@ int swap_writepage(struct page *page, st
 		return ret;
 	}
 
+	/*
+	 * Use a bitmap (zeromap) to avoid doing IO for zero-filled pages.
+	 * The bits in zeromap are protected by the locked swapcache folio
+	 * and atomic updates are used to protect against read-modify-write
+	 * corruption due to other zero swap entries seeing concurrent updates.
+	 */
 	if (is_folio_zero_filled(folio)) {
 		swap_zeromap_folio_set(folio);
 		folio_unlock(folio);
 		return 0;
+	} else {
+		/*
+		 * Clear bits this folio occupies in the zeromap to prevent
+		 * zero data being read in from any previous zero writes that
+		 * occupied the same swap entries.
+		 */
+		swap_zeromap_folio_clear(folio);
 	}
-	swap_zeromap_folio_clear(folio);
 	if (zswap_store(folio)) {
 		folio_unlock(folio);
 		return 0;
@@ -528,7 +532,7 @@ static bool swap_read_folio_zeromap(stru
 	if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
 		return true;
 
-	folio_zero_fill(folio);
+	folio_zero_range(folio, 0, folio_size(folio));
 	folio_mark_uptodate(folio);
 	return true;
 }
--- a/mm/swapfile.c~mm-store-zero-pages-to-be-swapped-out-in-a-bitmap-v8
+++ a/mm/swapfile.c
@@ -3181,11 +3181,11 @@ SYSCALL_DEFINE2(swapon, const char __use
 	}
 
 	/*
-	 * Use kvmalloc_array instead of bitmap_zalloc as the allocation order
-	 * might be above MAX_PAGE_ORDER incase of a large swap file.
+	 * Use kvmalloc_array instead of bitmap_zalloc as the allocation order might
+	 * be above MAX_PAGE_ORDER incase of a large swap file.
 	 */
-	p->zeromap = kvmalloc_array(BITS_TO_LONGS(maxpages),
-				sizeof(unsigned long), GFP_KERNEL | __GFP_ZERO);
+	p->zeromap = kvmalloc_array(BITS_TO_LONGS(maxpages), sizeof(long),
+				    GFP_KERNEL | __GFP_ZERO);
 	if (!p->zeromap) {
 		error = -ENOMEM;
 		goto bad_swap_unlock_inode;
@@ -3345,6 +3345,7 @@ bad_swap:
 	p->flags = 0;
 	spin_unlock(&swap_lock);
 	vfree(swap_map);
+	kvfree(p->zeromap);
 	kvfree(cluster_info);
 	if (inced_nr_rotate_swap)
 		atomic_dec(&nr_rotate_swap);
_


