Return-Path: <linux-kernel+bounces-393297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545509B9EC6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 11:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE281C22873
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 10:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E5716F910;
	Sat,  2 Nov 2024 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7OV7Xfe"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633AE170A19
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542375; cv=none; b=Wr9FZuJaODh3bJpFFsTUNxm3ACKx17aujUxFYvlZa8JoELpzOGt1ktp41diHvclj5qGVxcMlJghMpvgZq5pA7fZW0OLghlfZ2OJcKYubI7J8dTrN7hxmvM9PqS0BbTCgcZ4ATyOviK7w+Woy+Orefvs16ugTX6va2Tw0NOAkDoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542375; c=relaxed/simple;
	bh=r+3T1sK9tntwFZrvTM6TXyUjf0ciaP+jDny0F4p7Kwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HFb1AabTgb+y6MjPAa10lX85VVMlh71xB5Xl89VKv2mH5kH2FLisuRJ/mEywBqvaOvkchv7t6ZREbnea4YjFKEjmSZR5naS3qlobi47Dd9hTWOZg9kzf/Trg7snCAGus/PdjkqI/b10B/BSF5cvvH6ca9iZJx0GFFTc4YSnt3Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7OV7Xfe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c803787abso21508655ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 03:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730542372; x=1731147172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hZugl64Sp4r/qKgfzCCff/lOeoH7GG2OCZqrY25ODH8=;
        b=S7OV7XfewYBHeDVRyGXQgFNUatkyYUZlikCy5KZ9h1s3j2WJfzCM6TwVnRM87vkBWA
         oEPo8olr0ikdigjRy8+lC0vatDNRl4hineyGPAnPdWf6Molvfuned7XnrrlVjzeaA5IJ
         VPBI+iI6v99KH24oXiG5ZimDsSe13E/Q6zDC1zTdCeYqFMbW1+uS4CZihLGVg0B/4WZQ
         lMKOqSREGXGfQ+TrioB/OHOapmwxPsX6jowyXPRumfAlCwh5DbeD4eoT4ZYMtwTrPkPv
         fUBB93GB3pRJLwnM4pzlWmEAhO93kiTnF4/e6YZ2xwahoJ0xiyrSFM9srTKHmME2aTC5
         3SDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730542372; x=1731147172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZugl64Sp4r/qKgfzCCff/lOeoH7GG2OCZqrY25ODH8=;
        b=QbP3EX1nAN5/wEpBE/jNlYJtfC58RwQevwgVjKYeqPJdc3B+y3cNSn7HGwVN+MdETb
         zsn2pl5ZngOn0G/I0g/ytNbFbRLGUNQq5Zc++jUFUaJav9s8N89HmqWvxcMMRnW/bBDX
         Nbv0iUreax8t5G1X7umOIciILCMiNwgby1B4oHOC6D77yP2pYCekK+qbcH9Wo+IS5JRv
         4JTWiRSJAepYBZVdc/x0QWG/THiB49LfWTyWlQCWpd4+CjMCDDBt5u9slbEbfzZpbew4
         eo9oetFE0v4uumLxGcOY7R4DYrLolGduffIi7odR4r7EsLe2aH74X32NuowP3z7PdC6q
         XI2Q==
X-Gm-Message-State: AOJu0Yyy12K/NBSyZ/ppPk2DaYlWQGfTzb6Zz73lTgIFWk5JaJ7oHYOf
	amprKy6+7NBb0AjgUD+uHoxI/QN6Y8lpx+kcTjF+uAmv6F4km+UO
X-Google-Smtp-Source: AGHT+IFJyvRUxnkKCNxdxJMLRlxNvxSxxPfLZYyB/obaqAGGXdsp/lsawhNkkOmPTRWZrb6lbA1XYw==
X-Received: by 2002:a17:902:ec8e:b0:211:2fb2:6a6 with SMTP id d9443c01a7336-2112fb206e3mr38447105ad.24.1730542372401;
        Sat, 02 Nov 2024 03:12:52 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:89d8:b773:1a89:5a6e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105715434sm31843505ad.113.2024.11.02.03.12.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 02 Nov 2024 03:12:51 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andi Kleen <ak@linux.intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chris Li <chrisl@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Kairui Song <kasong@tencent.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH v2] mm: count zeromap read and set for swapout and swapin
Date: Sat,  2 Nov 2024 23:12:40 +1300
Message-Id: <20241102101240.35072-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

When the proportion of folios from the zero map is small, missing their
accounting may not significantly impact profiling. However, it’s easy
to construct a scenario where this becomes an issue—for example,
allocating 1 GB of memory, writing zeros from userspace, followed by
MADV_PAGEOUT, and then swapping it back in. In this case, the swap-out
and swap-in counts seem to vanish into a black hole, potentially
causing semantic ambiguity.

We have two ways to address this:

1. Add a separate counter specifically for the zero map.
2. Continue using the current accounting, treating the zero map like
a normal backend. (This aligns with the current behavior of zRAM
when supporting same-page fills at the device level.)

This patch adopts option 1 as pswpin/pswpout counters are that they
only apply to IO done directly to the backend device (as noted by
Nhat Pham).

We can find these counters from /proc/vmstat (counters for the whole
system) and memcg's memory.stat (counters for the interested memcg).

For example:

$ grep -E 'swpin_zero|swpout_zero' /proc/vmstat
swpin_zero 1648
swpout_zero 33536

$ grep -E 'swpin_zero|swpout_zero' /sys/fs/cgroup/system.slice/memory.stat
swpin_zero 3905
swpout_zero 3985

Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v2:
 * add separate counters rather than using pswpin/out; thanks
 for the comments from Usama, David, Yosry and Nhat;
 * Usama also suggested a new counter like swapped_zero, I
 prefer that one be separated as an enhancement patch not
 a hotfix. will probably handle it later on.

 Documentation/admin-guide/cgroup-v2.rst | 10 ++++++++++
 include/linux/vm_event_item.h           |  2 ++
 mm/memcontrol.c                         |  4 ++++
 mm/page_io.c                            | 16 ++++++++++++++++
 mm/vmstat.c                             |  2 ++
 5 files changed, 34 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index db3799f1483e..984eb3c9d05b 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1599,6 +1599,16 @@ The following nested keys are defined.
 	  pglazyfreed (npn)
 		Amount of reclaimed lazyfree pages
 
+	  swpin_zero
+		Number of pages moved into memory with zero content, meaning no
+		copy exists in the backend swapfile, allowing swap-in to avoid
+		I/O read overhead.
+
+	  swpout_zero
+		Number of pages moved out of memory with zero content, meaning no
+		copy is needed in the backend swapfile, allowing swap-out to avoid
+		I/O write overhead.
+
 	  zswpin
 		Number of pages moved in to memory from zswap.
 
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index aed952d04132..f70d0958095c 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -134,6 +134,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_SWAP
 		SWAP_RA,
 		SWAP_RA_HIT,
+		SWPIN_ZERO,
+		SWPOUT_ZERO,
 #ifdef CONFIG_KSM
 		KSM_SWPIN_COPY,
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5e44d6e7591e..7b3503d12aaf 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -441,6 +441,10 @@ static const unsigned int memcg_vm_event_stat[] = {
 	PGDEACTIVATE,
 	PGLAZYFREE,
 	PGLAZYFREED,
+#ifdef CONFIG_SWAP
+	SWPIN_ZERO,
+	SWPOUT_ZERO,
+#endif
 #ifdef CONFIG_ZSWAP
 	ZSWPIN,
 	ZSWPOUT,
diff --git a/mm/page_io.c b/mm/page_io.c
index 5d9b6e6cf96c..4b4ea8e49cf6 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -204,7 +204,9 @@ static bool is_folio_zero_filled(struct folio *folio)
 
 static void swap_zeromap_folio_set(struct folio *folio)
 {
+	struct obj_cgroup *objcg = get_obj_cgroup_from_folio(folio);
 	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	int nr_pages = folio_nr_pages(folio);
 	swp_entry_t entry;
 	unsigned int i;
 
@@ -212,6 +214,12 @@ static void swap_zeromap_folio_set(struct folio *folio)
 		entry = page_swap_entry(folio_page(folio, i));
 		set_bit(swp_offset(entry), sis->zeromap);
 	}
+
+	count_vm_events(SWPOUT_ZERO, nr_pages);
+	if (objcg) {
+		count_objcg_events(objcg, SWPOUT_ZERO, nr_pages);
+		obj_cgroup_put(objcg);
+	}
 }
 
 static void swap_zeromap_folio_clear(struct folio *folio)
@@ -507,6 +515,7 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 static bool swap_read_folio_zeromap(struct folio *folio)
 {
 	int nr_pages = folio_nr_pages(folio);
+	struct obj_cgroup *objcg;
 	bool is_zeromap;
 
 	/*
@@ -521,6 +530,13 @@ static bool swap_read_folio_zeromap(struct folio *folio)
 	if (!is_zeromap)
 		return false;
 
+	objcg = get_obj_cgroup_from_folio(folio);
+	count_vm_events(SWPIN_ZERO, nr_pages);
+	if (objcg) {
+		count_objcg_events(objcg, SWPIN_ZERO, nr_pages);
+		obj_cgroup_put(objcg);
+	}
+
 	folio_zero_range(folio, 0, folio_size(folio));
 	folio_mark_uptodate(folio);
 	return true;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 22a294556b58..c8ef7352f9ed 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1418,6 +1418,8 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_SWAP
 	"swap_ra",
 	"swap_ra_hit",
+	"swpin_zero",
+	"swpout_zero",
 #ifdef CONFIG_KSM
 	"ksm_swpin_copy",
 #endif
-- 
2.39.3 (Apple Git-146)


