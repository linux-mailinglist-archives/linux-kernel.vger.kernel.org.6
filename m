Return-Path: <linux-kernel+bounces-314263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D6896B0CA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58EA1C24721
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 05:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5D613AD0F;
	Wed,  4 Sep 2024 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQUu3skQ"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D083A06
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 05:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725429335; cv=none; b=lH4HteHk6CSXesAIX/5+fAlhlSwjtiYzvACf+t4S0wSrGDTn9JOoVu2DOWhIF4mj8XGMLPCnVVDXM3Pv8aFJ7n4IrJ/N2XctSZnqSHwQ1gMJQVX0s8cyRI9yB3z9Y3aUwNaB8oE2rhDR6xKUy8NI03rzZBXWz3Ey1F3g1cCGOSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725429335; c=relaxed/simple;
	bh=e6JTbWRvI2/PnDhOIGOVcgp14vlpS0n8hr5uNB8tvV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BX5zbIJAEfU+h+pXn7f4OCzGPdn8hqaNCv9v0Zzfa24napcGC+iGbq3svBWGJeb6Cqpu8fV2Cz+I4KfFyPzmj7RvZObPEZrKFYck0Sw6QVM9rRkOutLRnv08pjDaXJ6o08mGe2lfv9HTNvpn7zhCCjRfva1r+rt2o6/YRg15m4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQUu3skQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d8881850d9so3168629a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 22:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725429333; x=1726034133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoFH4FMt+wXQqq7eQ8+QSpnLM+4TMCJr3a9E4w8Z+hE=;
        b=jQUu3skQJAjMwok8X0hNR0MmexBUfXf1qQAQ+Jc9a0zLDGhiZMGuIsLNwRjcYR7WPK
         WPxTwWd0kYmZn0ifsy0H5w4KlLbmGbsndyfBy9n49gGg6m1sm7IIPobhKoEz15X8gkIp
         mstdNYTLEJ21oyj1VmcT4x6vz75KMyrg0z73iwtT9Mn6GzOIjfHmc1tghKg0tzT/9Lsi
         hX1sb2Y1pOl5xIZKFViEpOhRLuXNX1hBG0ZaYJDMaH05bHmKAOv61eHxU8G0V1/tdciv
         i6dsY9Os2raR9a1BF2U83OBvmheJyZtzcpQ4shOrCalvFsWtIxDWNpYs5XNsr/qCuYvc
         5blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725429333; x=1726034133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoFH4FMt+wXQqq7eQ8+QSpnLM+4TMCJr3a9E4w8Z+hE=;
        b=ESWqzI/NZAW1DmaUcyPOc5zlhJpbgi6316uskweZNp0BCQ/a9a2pvJGKYO1syq2Wit
         6LAbCfOcHCrk7U3MKXdbaknGNV6Xj1Sa2taVwcUAA1fKp4C+hl17URCstH0/IBkb0+SO
         betIC0CSw2sD1SqaaQoEI2vikxhwPGNT/vo2Y11HzA5uC2YFxh+hsal2t7UpKrfRSdSI
         aRDnJeZ/6eKmZQnS7igR2wgdK/VikybuihdZhJG8AUogGZolsor//ud8pMp7A4mNQz6T
         k+DYZynugOB2eeTaxFYYPEhWpCUQ08zJvPV6o+f7CW5Ddu/xEppsW6q7IVNiigoDy6uA
         XOjw==
X-Forwarded-Encrypted: i=1; AJvYcCUKwxZwAm1KoyGVCoMXxrn4oesPztXNhgYIkMQ1pqBsBHkZkq5cPpdc0v8q2P8clUb6UA/mDJ7thO6NGMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXGZ0oRe8eRwBrK8ttN/fbHHc8EXHRHP2vVWV+nRYtZ+4UC0nG
	6p9SHpyhXXmWQYHmOSrlhFhtuNp3A5XidBjqjuGLrKJVq4p0Bjpf
X-Google-Smtp-Source: AGHT+IEctEsdGjIZiTg5BvQ9VLZNiSdEqaY9shFXt0y07cPPwA4g/hKJgUr5PrKitSIQj7/q1WURRw==
X-Received: by 2002:a05:6a21:39b:b0:1cc:ef31:da6d with SMTP id adf61e73a8af0-1ccef31dc1emr16410973637.52.1725429332700;
        Tue, 03 Sep 2024 22:55:32 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:3dfb:fdbe:2749:2520])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae9505acsm6732365ad.66.2024.09.03.22.55.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Sep 2024 22:55:31 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: usamaarif642@gmail.com
Cc: akpm@linux-foundation.org,
	chengming.zhou@linux.dev,
	david@redhat.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	shakeel.butt@linux.dev,
	willy@infradead.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	hanchuanhua@oppo.com
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
Date: Wed,  4 Sep 2024 17:55:22 +1200
Message-Id: <20240904055522.2376-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240612124750.2220726-2-usamaarif642@gmail.com>
References: <20240612124750.2220726-2-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Jun 13, 2024 at 12:48 AM Usama Arif <usamaarif642@gmail.com> wrote:
>
> Approximately 10-20% of pages to be swapped out are zero pages [1].
> Rather than reading/writing these pages to flash resulting
> in increased I/O and flash wear, a bitmap can be used to mark these
> pages as zero at write time, and the pages can be filled at
> read time if the bit corresponding to the page is set.
> With this patch, NVMe writes in Meta server fleet decreased
> by almost 10% with conventional swap setup (zswap disabled).
>
> [1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  include/linux/swap.h |   1 +
>  mm/page_io.c         | 114 ++++++++++++++++++++++++++++++++++++++++++-
>  mm/swapfile.c        |  24 ++++++++-
>  3 files changed, 136 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index a11c75e897ec..e88563978441 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -299,6 +299,7 @@ struct swap_info_struct {
>         signed char     type;           /* strange name for an index */
>         unsigned int    max;            /* extent of the swap_map */
>         unsigned char *swap_map;        /* vmalloc'ed array of usage counts */
> +       unsigned long *zeromap;         /* vmalloc'ed bitmap to track zero pages */
>         struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
>         struct swap_cluster_list free_clusters; /* free clusters list */
>         unsigned int lowest_bit;        /* index of first free in swap_map */
> diff --git a/mm/page_io.c b/mm/page_io.c
> index a360857cf75d..39fc3919ce15 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -172,6 +172,88 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
>         goto out;
>  }
>
> +static bool is_folio_page_zero_filled(struct folio *folio, int i)
> +{
> +       unsigned long *data;
> +       unsigned int pos, last_pos = PAGE_SIZE / sizeof(*data) - 1;
> +       bool ret = false;
> +
> +       data = kmap_local_folio(folio, i * PAGE_SIZE);
> +       if (data[last_pos])
> +               goto out;
> +       for (pos = 0; pos < PAGE_SIZE / sizeof(*data); pos++) {
> +               if (data[pos])
> +                       goto out;
> +       }
> +       ret = true;
> +out:
> +       kunmap_local(data);
> +       return ret;
> +}
> +
> +static bool is_folio_zero_filled(struct folio *folio)
> +{
> +       unsigned int i;
> +
> +       for (i = 0; i < folio_nr_pages(folio); i++) {
> +               if (!is_folio_page_zero_filled(folio, i))
> +                       return false;
> +       }
> +       return true;
> +}
> +
> +static void folio_zero_fill(struct folio *folio)
> +{
> +       unsigned int i;
> +
> +       for (i = 0; i < folio_nr_pages(folio); i++)
> +               clear_highpage(folio_page(folio, i));
> +}
> +
> +static void swap_zeromap_folio_set(struct folio *folio)
> +{
> +       struct swap_info_struct *sis = swp_swap_info(folio->swap);
> +       swp_entry_t entry;
> +       unsigned int i;
> +
> +       for (i = 0; i < folio_nr_pages(folio); i++) {
> +               entry = page_swap_entry(folio_page(folio, i));
> +               set_bit(swp_offset(entry), sis->zeromap);
> +       }
> +}
> +
> +static void swap_zeromap_folio_clear(struct folio *folio)
> +{
> +       struct swap_info_struct *sis = swp_swap_info(folio->swap);
> +       swp_entry_t entry;
> +       unsigned int i;
> +
> +       for (i = 0; i < folio_nr_pages(folio); i++) {
> +               entry = page_swap_entry(folio_page(folio, i));
> +               clear_bit(swp_offset(entry), sis->zeromap);
> +       }
> +}
> +
> +/*
> + * Return the index of the first subpage which is not zero-filled
> + * according to swap_info_struct->zeromap.
> + * If all pages are zero-filled according to zeromap, it will return
> + * folio_nr_pages(folio).
> + */
> +static unsigned int swap_zeromap_folio_test(struct folio *folio)
> +{
> +       struct swap_info_struct *sis = swp_swap_info(folio->swap);
> +       swp_entry_t entry;
> +       unsigned int i;
> +
> +       for (i = 0; i < folio_nr_pages(folio); i++) {
> +               entry = page_swap_entry(folio_page(folio, i));
> +               if (!test_bit(swp_offset(entry), sis->zeromap))
> +                       return i;
> +       }
> +       return i;
> +}
> +
>  /*
>   * We may have stale swap cache pages in memory: notice
>   * them here and get rid of the unnecessary final write.
> @@ -195,6 +277,13 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>                 folio_unlock(folio);
>                 return ret;
>         }
> +
> +       if (is_folio_zero_filled(folio)) {
> +               swap_zeromap_folio_set(folio);
> +               folio_unlock(folio);
> +               return 0;
> +       }
> +       swap_zeromap_folio_clear(folio);
>         if (zswap_store(folio)) {
>                 folio_start_writeback(folio);
>                 folio_unlock(folio);
> @@ -426,6 +515,26 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>         mempool_free(sio, sio_pool);
>  }
>
> +static bool swap_read_folio_zeromap(struct folio *folio)
> +{
> +       unsigned int idx = swap_zeromap_folio_test(folio);
> +
> +       if (idx == 0)
> +               return false;
> +
> +       /*
> +        * Swapping in a large folio that is partially in the zeromap is not
> +        * currently handled. Return true without marking the folio uptodate so
> +        * that an IO error is emitted (e.g. do_swap_page() will sigbus).
> +        */
> +       if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
> +               return true;

Hi Usama, Yosry,

I feel the warning is wrong as we could have the case where idx==0
is not zeromap but idx=1 is zeromap. idx == 0 doesn't necessarily
mean we should return false.

What about the below change which both fixes the warning and unblocks
large folios swap-in?

diff --git a/mm/page_io.c b/mm/page_io.c
index 4bc77d1c6bfa..7d7ff7064e2b 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -226,26 +226,6 @@ static void swap_zeromap_folio_clear(struct folio *folio)
 	}
 }
 
-/*
- * Return the index of the first subpage which is not zero-filled
- * according to swap_info_struct->zeromap.
- * If all pages are zero-filled according to zeromap, it will return
- * folio_nr_pages(folio).
- */
-static unsigned int swap_zeromap_folio_test(struct folio *folio)
-{
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
-	swp_entry_t entry;
-	unsigned int i;
-
-	for (i = 0; i < folio_nr_pages(folio); i++) {
-		entry = page_swap_entry(folio_page(folio, i));
-		if (!test_bit(swp_offset(entry), sis->zeromap))
-			return i;
-	}
-	return i;
-}
-
 /*
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
@@ -524,9 +504,10 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 
 static bool swap_read_folio_zeromap(struct folio *folio)
 {
-	unsigned int idx = swap_zeromap_folio_test(folio);
+	unsigned int nr_pages = folio_nr_pages(folio);
+	unsigned int nr = swap_zeromap_entries_count(folio->swap, nr_pages);
 
-	if (idx == 0)
+	if (nr == 0)
 		return false;
 
 	/*
@@ -534,7 +515,7 @@ static bool swap_read_folio_zeromap(struct folio *folio)
 	 * currently handled. Return true without marking the folio uptodate so
 	 * that an IO error is emitted (e.g. do_swap_page() will sigbus).
 	 */
-	if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
+	if (WARN_ON_ONCE(nr < nr_pages))
 		return true;
 
 	folio_zero_range(folio, 0, folio_size(folio));
diff --git a/mm/swap.h b/mm/swap.h
index f8711ff82f84..2d59e9d89e95 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -80,6 +80,32 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	return swp_swap_info(folio->swap)->flags;
 }
+
+/*
+ * Return the number of entries which are zero-filled according to
+ * swap_info_struct->zeromap. It isn't precise if the return value
+ * is larger than 0 and smaller than nr to avoid extra iterations,
+ * In this case, it means entries haven't consistent zeromap.
+ */
+static inline unsigned int swap_zeromap_entries_count(swp_entry_t entry, int nr)
+{
+	struct swap_info_struct *sis = swp_swap_info(entry);
+	unsigned long offset = swp_offset(entry);
+	unsigned int type = swp_type(entry);
+	unsigned int n = 0;
+
+	for (int i = 0; i < nr; i++) {
+		entry = swp_entry(type, offset + i);
+		if (test_bit(offset + i, sis->zeromap)) {
+			if (i != n)
+				return i;
+			n++;
+		}
+	}
+
+	return n;
+}
+
 #else /* CONFIG_SWAP */
 struct swap_iocb;
 static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
@@ -171,6 +197,11 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	return 0;
 }
+
+static inline unsigned int swap_zeromap_entries_count(swp_entry_t entry, int nr)
+{
+	return 0;
+}
 #endif /* CONFIG_SWAP */
 
 #endif /* _MM_SWAP_H */

> +
> +       folio_zero_fill(folio);
> +       folio_mark_uptodate(folio);
> +       return true;
> +}
> +
>  static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
>  {
>         struct swap_info_struct *sis = swp_swap_info(folio->swap);
> @@ -515,8 +624,9 @@ void swap_read_folio(struct folio *folio, bool synchronous,
>                 psi_memstall_enter(&pflags);
>         }
>         delayacct_swapin_start();
> -
> -       if (zswap_load(folio)) {
> +       if (swap_read_folio_zeromap(folio)) {
> +               folio_unlock(folio);
> +       } else if (zswap_load(folio)) {
>                 folio_mark_uptodate(folio);
>                 folio_unlock(folio);
>         } else if (data_race(sis->flags & SWP_FS_OPS)) {
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f1e559e216bd..48d8dca0b94b 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -453,6 +453,8 @@ static unsigned int cluster_list_del_first(struct swap_cluster_list *list,
>  static void swap_cluster_schedule_discard(struct swap_info_struct *si,
>                 unsigned int idx)
>  {
> +       unsigned int i;
> +
>         /*
>          * If scan_swap_map_slots() can't find a free cluster, it will check
>          * si->swap_map directly. To make sure the discarding cluster isn't
> @@ -461,6 +463,13 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
>          */
>         memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>                         SWAP_MAP_BAD, SWAPFILE_CLUSTER);
> +       /*
> +        * zeromap can see updates from concurrent swap_writepage() and swap_read_folio()
> +        * call on other slots, hence use atomic clear_bit for zeromap instead of the
> +        * non-atomic bitmap_clear.
> +        */
> +       for (i = 0; i < SWAPFILE_CLUSTER; i++)
> +               clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);
>
>         cluster_list_add_tail(&si->discard_clusters, si->cluster_info, idx);
>
> @@ -482,7 +491,7 @@ static void __free_cluster(struct swap_info_struct *si, unsigned long idx)
>  static void swap_do_scheduled_discard(struct swap_info_struct *si)
>  {
>         struct swap_cluster_info *info, *ci;
> -       unsigned int idx;
> +       unsigned int idx, i;
>
>         info = si->cluster_info;
>
> @@ -498,6 +507,8 @@ static void swap_do_scheduled_discard(struct swap_info_struct *si)
>                 __free_cluster(si, idx);
>                 memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>                                 0, SWAPFILE_CLUSTER);
> +               for (i = 0; i < SWAPFILE_CLUSTER; i++)
> +                       clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);
>                 unlock_cluster(ci);
>         }
>  }
> @@ -1059,9 +1070,12 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
>  {
>         unsigned long offset = idx * SWAPFILE_CLUSTER;
>         struct swap_cluster_info *ci;
> +       unsigned int i;
>
>         ci = lock_cluster(si, offset);
>         memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> +       for (i = 0; i < SWAPFILE_CLUSTER; i++)
> +               clear_bit(offset + i, si->zeromap);
>         cluster_set_count_flag(ci, 0, 0);
>         free_cluster(si, idx);
>         unlock_cluster(ci);
> @@ -1336,6 +1350,7 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
>         count = p->swap_map[offset];
>         VM_BUG_ON(count != SWAP_HAS_CACHE);
>         p->swap_map[offset] = 0;
> +       clear_bit(offset, p->zeromap);
>         dec_cluster_info_page(p, p->cluster_info, offset);
>         unlock_cluster(ci);
>
> @@ -2597,6 +2612,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>         free_percpu(p->cluster_next_cpu);
>         p->cluster_next_cpu = NULL;
>         vfree(swap_map);
> +       bitmap_free(p->zeromap);
>         kvfree(cluster_info);
>         /* Destroy swap account information */
>         swap_cgroup_swapoff(p->type);
> @@ -3123,6 +3139,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>                 goto bad_swap_unlock_inode;
>         }
>
> +       p->zeromap = bitmap_zalloc(maxpages, GFP_KERNEL);
> +       if (!p->zeromap) {
> +               error = -ENOMEM;
> +               goto bad_swap_unlock_inode;
> +       }
> +
>         if (p->bdev && bdev_stable_writes(p->bdev))
>                 p->flags |= SWP_STABLE_WRITES;
>
> --
> 2.43.0
>
>

