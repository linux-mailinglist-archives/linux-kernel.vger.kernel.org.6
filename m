Return-Path: <linux-kernel+bounces-214739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B3B90896B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A2328EE4E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7606B193091;
	Fri, 14 Jun 2024 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsMwyGiS"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40D0192B9C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359752; cv=none; b=t0HqnX7ojD+EV2TjZiPZnYHibC3xt1Ts3nIAxYlb0W9JvhzKCvNQeMpMrARLci7CqqXo0G/r577C8QwBpNCfzkeqv1L2bS/dTzjfDfaM+8EpwqzuDhBbAA/RkfOYVVPnNuxF7x1ucrMlvAMWg7iSprdpRIX+JXEqEm382vIjGn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359752; c=relaxed/simple;
	bh=1MT8xFKeBPw5AjOzcJOw/5QJHrl6H6hSaG9te/askVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSvTiy0n05iHCHuEczcOAGhdfWQVvp5EGMJcK/oLoH9BBFG8J0vYp6v926k9+dxsnnQkRjoyt2MbXzyZfC6Hiq37IVK8oOwUOzL/dDCJ25IbIdnAt91Kgbm1MFxBYMvQPZnZV8T5LfVy9Jyp440pEudCKJD84wNswoEjnDk8vEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsMwyGiS; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7955ddc6516so127932185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718359749; x=1718964549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6fv8HdnUEDMg3BMIhTRciMdCxiiErbM6c3rC1OGOWE=;
        b=DsMwyGiSwBrl+nks53tYC6+hguMuUsi0YCkeMNrvP5T3+FetXx5Ih47hNzm5o/I9X0
         Kq6XuVn+lw50DumuR2YKeZDdd2jbkSwKr7avEjaKshk6uacKO2fpbxd7ZQ7xBj67xxKs
         dgkkbvC5BMsW5TSSsWp2OAuERBZU0qICgNjE5LTBOTG2wYI5sQt+pqTOpnJwhovcTUBq
         vSLNZHPnDVEVZUUY9zGv0EXfXNK5R/TN2ectT4S2Tns/LWVdB2Ojg+4Ail2UnByXiVd5
         YjvM3IbkWuXWo2+IrHMQHBCKXd9vztDfPzAK6UwdsZWZw53rMbrJI6sT1CjAtS/M39ri
         WICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718359749; x=1718964549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6fv8HdnUEDMg3BMIhTRciMdCxiiErbM6c3rC1OGOWE=;
        b=bK+8OEl8gHCREry6VtEaBDS+T60kiIsQLoQwsx6Nn8jcj4xwEvFd6t0hp1vKc1GLab
         uAlGRorCjZZ8hnWmZiY7z5sFBlZBXV3RAV8rmb2TsZXMI7kQ7PdHi3eYqVdZV11BcfPm
         xQo0AFvf6X4JcGwPoMwyf6ak8pn8sTL2uKqfIFjhdY3hPfiyQPW7Wrg4HQKtONmGIvBN
         W91+53YLOJfaFSylpiPcirVO6aJGxQPmZZE2gKooZm3fKYRBB5FnjJn9zMnD2W7NqBmk
         VdUCeu73ql8rAUMXx0PKdddCIb+V051Et6Bf0HYfc2G8aQpvmJCBV9FRqrjfqC57ExPf
         +wCw==
X-Forwarded-Encrypted: i=1; AJvYcCU8ahsBMrW/1AleF8G7xDtv0TcJCpYgzNDDLCr8roDKQXad3zfxStDsQzKmgusCTH+y23/0QyT8I+PHwNPCTeLI/4957aeXHEcjhLkk
X-Gm-Message-State: AOJu0YzVY3kFSXN3/D/lTT53R9o+CTXZz5lISGs2S4F8PKsar6sDuhUY
	GTXd3tDVpQSlzdqL2pPdnYzBeYmDrADkQoHv6KXD2nhn+Dr2r2fD
X-Google-Smtp-Source: AGHT+IGB51PlczTS+Q8lC/8MDqy7gI3RzP4surNROYc6BI+M5ZcIlbCQASDwUV5uflux1tzhLPLPaA==
X-Received: by 2002:ad4:590c:0:b0:6b0:4542:e42e with SMTP id 6a1803df08f44-6b2afcc0ebfmr20182046d6.28.1718359748441;
        Fri, 14 Jun 2024 03:09:08 -0700 (PDT)
Received: from localhost (fwdproxy-ash-116.fbsv.net. [2a03:2880:20ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c1ceadsm16455526d6.43.2024.06.14.03.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 03:09:07 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	david@redhat.com,
	ying.huang@intel.com,
	hughd@google.com,
	willy@infradead.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v5 1/2] mm: store zero pages to be swapped out in a bitmap
Date: Fri, 14 Jun 2024 11:07:05 +0100
Message-ID: <20240614100902.3469724-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240614100902.3469724-1-usamaarif642@gmail.com>
References: <20240614100902.3469724-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Approximately 10-20% of pages to be swapped out are zero pages [1].
Rather than reading/writing these pages to flash resulting
in increased I/O and flash wear, a bitmap can be used to mark these
pages as zero at write time, and the pages can be filled at
read time if the bit corresponding to the page is set.
With this patch, NVMe writes in Meta server fleet decreased
by almost 10% with conventional swap setup (zswap disabled).

[1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 include/linux/swap.h |   1 +
 mm/page_io.c         | 113 ++++++++++++++++++++++++++++++++++++++++++-
 mm/swapfile.c        |  15 ++++++
 3 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 3df75d62a835..ed03d421febd 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -299,6 +299,7 @@ struct swap_info_struct {
 	signed char	type;		/* strange name for an index */
 	unsigned int	max;		/* extent of the swap_map */
 	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
+	unsigned long *zeromap;		/* vmalloc'ed bitmap to track zero pages */
 	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
 	struct swap_cluster_list free_clusters; /* free clusters list */
 	unsigned int lowest_bit;	/* index of first free in swap_map */
diff --git a/mm/page_io.c b/mm/page_io.c
index 6c1c1828bb88..480b8f221d90 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -172,6 +172,88 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
 	goto out;
 }
 
+static bool is_folio_page_zero_filled(struct folio *folio, int i)
+{
+	unsigned long *data;
+	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*data) - 1;
+	bool ret = false;
+
+	data = kmap_local_folio(folio, i * PAGE_SIZE);
+	if (data[last_pos])
+		goto out;
+	for (pos = 0; pos < PAGE_SIZE / sizeof(*data); pos++) {
+		if (data[pos])
+			goto out;
+	}
+	ret = true;
+out:
+	kunmap_local(data);
+	return ret;
+}
+
+static bool is_folio_zero_filled(struct folio *folio)
+{
+	unsigned int i;
+
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		if (!is_folio_page_zero_filled(folio, i))
+			return false;
+	}
+	return true;
+}
+
+static void folio_zero_fill(struct folio *folio)
+{
+	unsigned int i;
+
+	for (i = 0; i < folio_nr_pages(folio); i++)
+		clear_highpage(folio_page(folio, i));
+}
+
+static void swap_zeromap_folio_set(struct folio *folio)
+{
+	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	swp_entry_t entry;
+	unsigned int i;
+
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		entry = page_swap_entry(folio_page(folio, i));
+		set_bit(swp_offset(entry), sis->zeromap);
+	}
+}
+
+static void swap_zeromap_folio_clear(struct folio *folio)
+{
+	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	swp_entry_t entry;
+	unsigned int i;
+
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		entry = page_swap_entry(folio_page(folio, i));
+		clear_bit(swp_offset(entry), sis->zeromap);
+	}
+}
+
+/*
+ * Return the index of the first subpage which is not zero-filled
+ * according to swap_info_struct->zeromap.
+ * If all pages are zero-filled according to zeromap, it will return
+ * folio_nr_pages(folio).
+ */
+static unsigned int swap_zeromap_folio_test(struct folio *folio)
+{
+	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	swp_entry_t entry;
+	unsigned int i;
+
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		entry = page_swap_entry(folio_page(folio, i));
+		if (!test_bit(swp_offset(entry), sis->zeromap))
+			return i;
+	}
+	return i;
+}
+
 /*
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
@@ -195,6 +277,13 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		folio_unlock(folio);
 		return ret;
 	}
+
+	if (is_folio_zero_filled(folio)) {
+		swap_zeromap_folio_set(folio);
+		folio_unlock(folio);
+		return 0;
+	}
+	swap_zeromap_folio_clear(folio);
 	if (zswap_store(folio)) {
 		folio_unlock(folio);
 		return 0;
@@ -424,6 +513,26 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 	mempool_free(sio, sio_pool);
 }
 
+static bool swap_read_folio_zeromap(struct folio *folio)
+{
+	unsigned int idx = swap_zeromap_folio_test(folio);
+
+	if (idx == 0)
+		return false;
+
+	/*
+	 * Swapping in a large folio that is partially in the zeromap is not
+	 * currently handled. Return true without marking the folio uptodate so
+	 * that an IO error is emitted (e.g. do_swap_page() will sigbus).
+	 */
+	if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
+		return true;
+
+	folio_zero_fill(folio);
+	folio_mark_uptodate(folio);
+	return true;
+}
+
 static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
 {
 	struct swap_info_struct *sis = swp_swap_info(folio->swap);
@@ -514,7 +623,9 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	}
 	delayacct_swapin_start();
 
-	if (zswap_load(folio)) {
+	if (swap_read_folio_zeromap(folio)) {
+		folio_unlock(folio);
+	} else if (zswap_load(folio)) {
 		folio_unlock(folio);
 	} else if (data_race(sis->flags & SWP_FS_OPS)) {
 		swap_read_folio_fs(folio, plug);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9c6d8e557c0f..0b8270359bcf 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -747,6 +747,14 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	unsigned long begin = offset;
 	unsigned long end = offset + nr_entries - 1;
 	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
+	unsigned int i;
+
+	/*
+	 * Use atomic clear_bit operations only on zeromap instead of non-atomic
+	 * bitmap_clear to prevent adjacent bits corruption due to simultaneous writes.
+	 */
+	for (i = 0; i < nr_entries; i++)
+		clear_bit(offset + i, si->zeromap);
 
 	if (offset < si->lowest_bit)
 		si->lowest_bit = offset;
@@ -2635,6 +2643,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	free_percpu(p->cluster_next_cpu);
 	p->cluster_next_cpu = NULL;
 	vfree(swap_map);
+	bitmap_free(p->zeromap);
 	kvfree(cluster_info);
 	/* Destroy swap account information */
 	swap_cgroup_swapoff(p->type);
@@ -3161,6 +3170,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 
+	p->zeromap = bitmap_zalloc(maxpages, GFP_KERNEL);
+	if (!p->zeromap) {
+		error = -ENOMEM;
+		goto bad_swap_unlock_inode;
+	}
+
 	if (p->bdev && bdev_stable_writes(p->bdev))
 		p->flags |= SWP_STABLE_WRITES;
 
-- 
2.43.0


