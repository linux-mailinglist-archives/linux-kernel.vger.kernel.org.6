Return-Path: <linux-kernel+bounces-273398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA339468C9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 11:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10606282553
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D58B14E2D7;
	Sat,  3 Aug 2024 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iyvkc+48"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAE149647
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722676297; cv=none; b=YXf9jnzXTpbVwNt71Hl5okUABus40bWXliajkin6eTiad+MIxV2+Z8L94MEFwxyUhTcIPHXRSnob/SyQDrXiuM36i3AMS3BpAX3HoQoWuUVV0MMS1/xQmrIMjHhYQADD2PwQACA/4IsM309MG3cijhHUUQJmMxJD9LCtt/xOTEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722676297; c=relaxed/simple;
	bh=gMbmMvF5F/XkMWmdYVAhyOlo5NwuHvesrCFBfkKVABo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyfpDtI/o0QXHqfZ4/e//53YpUtUlOwiNA2pil1VLbj0UHdKJw7FaG7NLBS8GFDXmVeYVCrZLA3DLY/xUIenVdaja0KAyH4qLydoTOWxjCREpiugNC2mKn9qPo9CYnE+Wzxi8DTsHBEuDKkMgdPuBqN/EZOdX4jGEGJxSmNT3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iyvkc+48; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb5787b4a5so6006017a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 02:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722676295; x=1723281095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyHzns6fv4vzn1BHlOyIeJLzB9UhGPzYZabxEtUQGWk=;
        b=Iyvkc+48Uda4Bj+qDjpLnqeZaz1LlFJdEx5gyeoXmk4Vf4KiTIp173CAtb9AEamDKw
         PiL4p1yrgCJ3enbEvFvkDGyWIWbxfAHDjmCikrDk3hrt5oYyx5cZbRQpTBKu+inaM5O4
         SuJoRS8aeKhu1eecBGb/Bx/Muebqp83LjLMsfjqo1BtrTUMNBZcCezt8NG5PjbSEhQJa
         XbcstThDfYz4My2ovcFuj4YVa4UEXA0yXOTUpwiey0v0+VCub2pIpHPT3JyKRMJXfZll
         RsxLW2HeybV6gtPuq3H17GzM0lzJSpkBn1lPCVm4PCoLQElKAEVSxCLnhifFwf/mbH9T
         dJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722676295; x=1723281095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyHzns6fv4vzn1BHlOyIeJLzB9UhGPzYZabxEtUQGWk=;
        b=V3BEsHngu/3FdBdWqrcw0XkU6mqwC0z9GV0BfSCgeR2M6ioGtv4AotnRwZJYfSYbdS
         7H1AU01RkrJZLkMOomGxtnuvd6V9WgMAsS3Z8UVd9djI0J3ANaboI+977UYAgyySHRvi
         UpIlNtLWD1gvdWLnrSWh74834jKbSGpx2VxlWeOcCBSMRSGCjEU6Px/V/RPX8Ky2xwtO
         i27TN/fg1l4jUOiCgG94KWa7haR/tdNeSSbCtt9b27xqqKULp3vJbOJ76oY4PxC6ncI6
         +DTFI9W1ICpb1UEHE9xW2Vox6MVXG3Pg1qYqk1bDxVaZmwq8GwX35ZKN/d3q4iqVBsRP
         D+RA==
X-Forwarded-Encrypted: i=1; AJvYcCX9XTGVFQEK5NqlUQ80k0UsOstQ+RcDPqgqEQWFQvECwp3DlK55Uj167TWyXNrRr66SzHTw9yhGJqZKo3+xMflZ94wfUQ+wbz5zRN2X
X-Gm-Message-State: AOJu0YxILAl2hUVA7bb09MXnBqtYfh4JJrzqsfxc0hhM9jytM8nNxmcp
	UxJkF2FEYd/YLvQu4p4Pd9mzDfpx8u1v39/tj1sU1lH/X827Yzur
X-Google-Smtp-Source: AGHT+IGZF7adYEYRApBk2zmy2UwHmUFCE5l2pC56AzNHsLlv/ks1x0q67elburQSuZTqHcd+4mH7Rw==
X-Received: by 2002:a17:90a:a10d:b0:2c9:6aae:ac08 with SMTP id 98e67ed59e1d1-2cff943e05amr6944091a91.17.1722676294944;
        Sat, 03 Aug 2024 02:11:34 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf181sm6454237a91.37.2024.08.03.02.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 02:11:34 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: chrisl@kernel.org
Cc: akpm@linux-foundation.org,
	baohua@kernel.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v5 5/9] mm: swap: skip slot cache on freeing for mTHP
Date: Sat,  3 Aug 2024 21:11:18 +1200
Message-Id: <20240803091118.84274-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730-swap-allocator-v5-5-cb9c148b9297@kernel.org>
References: <20240730-swap-allocator-v5-5-cb9c148b9297@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Jul 31, 2024 at 6:49 PM <chrisl@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> Currently when we are freeing mTHP folios from swap cache, we free
> then one by one and put each entry into swap slot cache. Slot
> cache is designed to reduce the overhead by batching the freeing,
> but mTHP swap entries are already continuous so they can be batch
> freed without it already, it saves litle overhead, or even increase
> overhead for larger mTHP.
>
> What's more, mTHP entries could stay in swap cache for a while.
> Contiguous swap entry is an rather rare resource so releasing them
> directly can help improve mTHP allocation success rate when under
> pressure.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Barry Song <baohua@kernel.org>

I believe this is the right direction to take. Currently, entries are released
one by one, even when they are contiguous in the swap file(those nr_pages
entries are definitely in the same cluster and same si), leading to numerous
lock and unlock operations.
This approach provides batched support.

free_swap_and_cache_nr() has the same issue, so I drafted a patch based on
your code. I wonder if you can also help test and review before I send it
officially:

From 4bed5c08bc0f7769ee2849812acdad70c4e32ead Mon Sep 17 00:00:00 2001
From: Barry Song <v-songbaohua@oppo.com>
Date: Sat, 3 Aug 2024 20:21:14 +1200
Subject: [PATCH RFC] mm: attempt to batch free swap entries for zap_pte_range()

Zhiguo reported that swap release could be a serious bottleneck
during process exits[1]. With mTHP, we have the opportunity to
batch free swaps.
Thanks to the work of Chris and Kairui[2], I was able to achieve
this optimization with minimal code changes by building on their
efforts.

[1] https://lore.kernel.org/linux-mm/20240731133318.527-1-justinjiang@vivo.com/
[2] https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org/

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/swapfile.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index ea023fc25d08..9def6dba8d26 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -156,6 +156,25 @@ static bool swap_is_has_cache(struct swap_info_struct *si,
 	return true;
 }
 
+static bool swap_is_last_map(struct swap_info_struct *si,
+			      unsigned long offset, int nr_pages,
+			      bool *any_only_cache)
+{
+	unsigned char *map = si->swap_map + offset;
+	unsigned char *map_end = map + nr_pages;
+	bool cached = false;
+
+	do {
+		if ((*map & ~SWAP_HAS_CACHE) != 1)
+			return false;
+		if (*map & SWAP_HAS_CACHE)
+			cached = true;
+	} while (++map < map_end);
+
+	*any_only_cache = cached;
+	return true;
+}
+
 /*
  * returns number of pages in the folio that backs the swap entry. If positive,
  * the folio was reclaimed. If negative, the folio was not reclaimed. If 0, no
@@ -1808,6 +1827,29 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	if (WARN_ON(end_offset > si->max))
 		goto out;
 
+	if (nr > 1) {
+		struct swap_cluster_info *ci;
+		bool batched_free;
+		int i;
+
+		ci = lock_cluster_or_swap_info(si, start_offset);
+		if ((batched_free = swap_is_last_map(si, start_offset, nr, &any_only_cache))) {
+			for (i = 0; i < nr; i++)
+				WRITE_ONCE(si->swap_map[start_offset + i], SWAP_HAS_CACHE);
+		}
+		unlock_cluster_or_swap_info(si, ci);
+
+		if (batched_free) {
+			spin_lock(&si->lock);
+			pr_err("%s offset:%lx nr:%lx\n", __func__,start_offset, nr);
+			swap_entry_range_free(si, entry, nr);
+			spin_unlock(&si->lock);
+			if (any_only_cache)
+				goto reclaim;
+			goto out;
+		}
+	}
+
 	/*
 	 * First free all entries in the range.
 	 */
@@ -1828,6 +1870,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	if (!any_only_cache)
 		goto out;
 
+reclaim:
 	/*
 	 * Now go back over the range trying to reclaim the swap cache. This is
 	 * more efficient for large folios because we will only try to reclaim
-- 
2.34.1



> ---
>  mm/swapfile.c | 59 ++++++++++++++++++++++++++---------------------------------
>  1 file changed, 26 insertions(+), 33 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 34e6ea13e8e4..9b63b2262cc2 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -479,20 +479,21 @@ static void inc_cluster_info_page(struct swap_info_struct *p,
>  }
>
>  /*
> - * The cluster ci decreases one usage. If the usage counter becomes 0,
> + * The cluster ci decreases @nr_pages usage. If the usage counter becomes 0,
>   * which means no page in the cluster is in use, we can optionally discard
>   * the cluster and add it to free cluster list.
>   */
> -static void dec_cluster_info_page(struct swap_info_struct *p, struct swap_cluster_info *ci)
> +static void dec_cluster_info_page(struct swap_info_struct *p,
> +                                 struct swap_cluster_info *ci, int nr_pages)
>  {
>         if (!p->cluster_info)
>                 return;
>
> -       VM_BUG_ON(ci->count == 0);
> +       VM_BUG_ON(ci->count < nr_pages);
>         VM_BUG_ON(cluster_is_free(ci));
>         lockdep_assert_held(&p->lock);
>         lockdep_assert_held(&ci->lock);
> -       ci->count--;
> +       ci->count -= nr_pages;
>
>         if (!ci->count) {
>                 free_cluster(p, ci);
> @@ -998,19 +999,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>         return n_ret;
>  }
>
> -static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
> -{
> -       unsigned long offset = idx * SWAPFILE_CLUSTER;
> -       struct swap_cluster_info *ci;
> -
> -       ci = lock_cluster(si, offset);
> -       memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> -       ci->count = 0;
> -       free_cluster(si, ci);
> -       unlock_cluster(ci);
> -       swap_range_free(si, offset, SWAPFILE_CLUSTER);
> -}
> -
>  int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
>  {
>         int order = swap_entry_order(entry_order);
> @@ -1269,21 +1257,28 @@ static unsigned char __swap_entry_free(struct swap_info_struct *p,
>         return usage;
>  }
>
> -static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
> +/*
> + * Drop the last HAS_CACHE flag of swap entries, caller have to
> + * ensure all entries belong to the same cgroup.
> + */
> +static void swap_entry_range_free(struct swap_info_struct *p, swp_entry_t entry,
> +                                 unsigned int nr_pages)
>  {
> -       struct swap_cluster_info *ci;
>         unsigned long offset = swp_offset(entry);
> -       unsigned char count;
> +       unsigned char *map = p->swap_map + offset;
> +       unsigned char *map_end = map + nr_pages;
> +       struct swap_cluster_info *ci;
>
>         ci = lock_cluster(p, offset);
> -       count = p->swap_map[offset];
> -       VM_BUG_ON(count != SWAP_HAS_CACHE);
> -       p->swap_map[offset] = 0;
> -       dec_cluster_info_page(p, ci);
> +       do {
> +               VM_BUG_ON(*map != SWAP_HAS_CACHE);
> +               *map = 0;
> +       } while (++map < map_end);
> +       dec_cluster_info_page(p, ci, nr_pages);
>         unlock_cluster(ci);
>
> -       mem_cgroup_uncharge_swap(entry, 1);
> -       swap_range_free(p, offset, 1);
> +       mem_cgroup_uncharge_swap(entry, nr_pages);
> +       swap_range_free(p, offset, nr_pages);
>  }
>
>  static void cluster_swap_free_nr(struct swap_info_struct *sis,
> @@ -1343,7 +1338,6 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
>  void put_swap_folio(struct folio *folio, swp_entry_t entry)
>  {
>         unsigned long offset = swp_offset(entry);
> -       unsigned long idx = offset / SWAPFILE_CLUSTER;
>         struct swap_cluster_info *ci;
>         struct swap_info_struct *si;
>         unsigned char *map;
> @@ -1356,19 +1350,18 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
>                 return;
>
>         ci = lock_cluster_or_swap_info(si, offset);
> -       if (size == SWAPFILE_CLUSTER) {
> +       if (size > 1) {
>                 map = si->swap_map + offset;
> -               for (i = 0; i < SWAPFILE_CLUSTER; i++) {
> +               for (i = 0; i < size; i++) {
>                         val = map[i];
>                         VM_BUG_ON(!(val & SWAP_HAS_CACHE));
>                         if (val == SWAP_HAS_CACHE)
>                                 free_entries++;
>                 }
> -               if (free_entries == SWAPFILE_CLUSTER) {
> +               if (free_entries == size) {
>                         unlock_cluster_or_swap_info(si, ci);
>                         spin_lock(&si->lock);
> -                       mem_cgroup_uncharge_swap(entry, SWAPFILE_CLUSTER);
> -                       swap_free_cluster(si, idx);
> +                       swap_entry_range_free(si, entry, size);
>                         spin_unlock(&si->lock);
>                         return;
>                 }
> @@ -1413,7 +1406,7 @@ void swapcache_free_entries(swp_entry_t *entries, int n)
>         for (i = 0; i < n; ++i) {
>                 p = swap_info_get_cont(entries[i], prev);
>                 if (p)
> -                       swap_entry_free(p, entries[i]);
> +                       swap_entry_range_free(p, entries[i], 1);
>                 prev = p;
>         }
>         if (p)
>
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>

Thanks
Barry


