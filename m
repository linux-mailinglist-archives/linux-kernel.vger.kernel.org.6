Return-Path: <linux-kernel+bounces-397160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7099BD782
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCDD1F238BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F4621219E;
	Tue,  5 Nov 2024 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bk7W7FYm"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF8A3D81
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730841590; cv=none; b=ahjoFxxHdkoT6cZqQRgBeI5LxREdvARRPnIVOQkX5jYnJVu+SearEQyJ6uwjqrFOuZzYIBGzKzParKgpkzrML0ZAykU5UBftfONIx30kTjxHYGhVIdJeyPQcsAcweo9k3yDS3aDJFj8KYeXALmvpTBe1jjFOfRwR7Y9Gsnc3aM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730841590; c=relaxed/simple;
	bh=ekAEcLCRQdROLQZ94HycNYS/g//N+wxfyxwB2cXS3Zg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=i1d5QxdoONDdVW5egWUbInEwErfI8aeC8m6+gm0zQmSYEe7SHa0K4tOvfBJXo2+mWmsfnAxNAGy/J1NEOrPmceFeT+TScRI8yYW4VChvw1ZwQzgKQuK4WPBZwK0Z4oQVl8sCpMSeYQhuLvfZNi03BqSAXxDwh99e4zxaPwXLW7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bk7W7FYm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-723db2798caso2672146b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 13:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730841588; x=1731446388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=78g/UltacuctUqO/KqSaHCwdizA+7FjwVPdidVsrYh8=;
        b=Bk7W7FYmDEJXtgIeK4Dac4UTFeYlPFRPGs6IUzPyfbYnEhFySUULSk7CLfAUYDDmEm
         WowaD5wNvtCD6gTo+rB5YiAAF2HIHpf695+SrpGKx62IBUBQW52sMYbgdmah+tB1UTjN
         sf9qOYZUwvvAVRMMzMVVINw5irJGUyB9q7vFoEW5s1OiQKCau7CvpF5/IHsSEZwNYRIB
         5xM0OGLfX89r2myIRQLl2xgfG7yIVi7thijNhPDJV5V5gx676TmqOLzWv8WVHkY6oNTH
         nI4jkhCi5fteo1opWX2qqbqvqrqWiKfy4M+1ZqwMf0Kn8CRgpbSAI/NXatS1DwNA+wV2
         5n2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730841588; x=1731446388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=78g/UltacuctUqO/KqSaHCwdizA+7FjwVPdidVsrYh8=;
        b=Fdh4Zlwh0OvYh5HIVrZdtNz8WYTyN6CX1cGAL75JgrzAOkbpwFfCuEjPIjRm60NBgk
         IILz7PSPpJ/FxxRFsdXKN6C8tiif6A42xtw1QSRjLILdfv92F7qnAo4pyEvqfeNePzWj
         dD1tEGNHvOHpBgSqYGGiXqi1Ys3r9kyp/FJKxBtDg/6lyHqY71JVYEHMY4/wFrGoGRoa
         i8+eHonKR2gYY2nfZH9aZ7HL8U62zN7r0n66P6ipNlQGgwiGiEwVMhYOWO/m4JLo1c7G
         X+0k5urbwxCyQfECt1qAE9wzP94dQmuwPkXHfQ1D/2bDOLjdB9QcIuLFYLBoLG+Tg8Cy
         6Heg==
X-Gm-Message-State: AOJu0YxgzJ7jh4hK0HjKD7+5RQcD7mlEWii/oPYuaWa3YVVeWAqh0jAB
	4fzYOeb2t7n2pbzqzOc06RLz1wSrukDYHP4iYDW7RuNKsGsoDHf7
X-Google-Smtp-Source: AGHT+IHboVYLLbLpYHtd/PM6QhN03QTE5xzXp/O1/frEEs2UDffScaNan1q2/LypjnySfgkoVR8/eA==
X-Received: by 2002:a05:6a00:27a0:b0:71d:f510:b791 with SMTP id d2e1a72fcca58-720ab3c6d19mr33962932b3a.12.1730841587791;
        Tue, 05 Nov 2024 13:19:47 -0800 (PST)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:19bb:246:5891:e8ce])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c7ef1sm10162920b3a.103.2024.11.05.13.19.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 05 Nov 2024 13:19:47 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	Hailong Liu <hailong.liu@oppo.com>,
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
Subject: [PATCH v3] mm: count zeromap read and set for swapout and swapin
Date: Wed,  6 Nov 2024 10:19:34 +1300
Message-Id: <20241105211934.5083-1-21cnbao@gmail.com>
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

When the proportion of folios from the zeromap is small, missing their
accounting may not significantly impact profiling. However, it’s easy
to construct a scenario where this becomes an issue—for example,
allocating 1 GB of memory, writing zeros from userspace, followed by
MADV_PAGEOUT, and then swapping it back in. In this case, the swap-out
and swap-in counts seem to vanish into a black hole, potentially
causing semantic ambiguity.

On the other hand, Usama reported that zero-filled pages can exceed 10% in
workloads utilizing zswap, while Hailong noted that some app in Android
have more than 6% zero-filled pages. Before commit 0ca0c24e3211 ("mm: store
zero pages to be swapped out in a bitmap"), both zswap and zRAM implemented
similar optimizations, leading to these optimized-out pages being counted
in either zswap or zRAM counters (with pswpin/pswpout also increasing for
zRAM). With zeromap functioning prior to both zswap and zRAM, userspace
will no longer detect these swap-out and swap-in actions.

We have three ways to address this:

1. Introduce a dedicated counter specifically for the zeromap.
2. Use pswpin/pswpout accounting, treating the zero map as a standard
backend. This approach aligns with zRAM's current handling of
same-page fills at the device level. However, it would mean losing
the optimized-out page counters previously available in zRAM and
would not align with systems using zswap. Additionally, as noted by
Nhat Pham, pswpin/pswpout counters apply only to I/O done directly
to the backend device.
3. Count zeromap pages under zswap, aligning with system behavior when
zswap is enabled. However, this would not be consistent with zRAM,
nor would it align with systems lacking both zswap and zRAM.

Given the complications with options 2 and 3, this patch selects
option 1.

We can find these counters from /proc/vmstat (counters for the whole
system) and memcg's memory.stat (counters for the interested memcg).

For example:

$ grep -E 'swpin_zero|swpout_zero' /proc/vmstat
swpin_zero 1648
swpout_zero 33536

$ grep -E 'swpin_zero|swpout_zero' /sys/fs/cgroup/system.slice/memory.stat
swpin_zero 3905
swpout_zero 3985

This patch does not address any specific zeromap bug, but the missing
swpout and swpin counts for zero-filled pages can be highly confusing
and may mislead user-space agents that rely on changes in these counters
as indicators. Therefore, we add a Fixes tag to encourage the inclusion
of this counter in any kernel versions with zeromap.

Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Hailong Liu <hailong.liu@oppo.com>
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
 -v3:
 * collected Nhat's reviewed-by, thanks!
 * refine doc per Usama and David, thanks!
 * refine changelog

 Documentation/admin-guide/cgroup-v2.rst |  9 +++++++++
 include/linux/vm_event_item.h           |  2 ++
 mm/memcontrol.c                         |  4 ++++
 mm/page_io.c                            | 16 ++++++++++++++++
 mm/vmstat.c                             |  2 ++
 5 files changed, 33 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index db3799f1483e..13736a94edfd 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1599,6 +1599,15 @@ The following nested keys are defined.
 	  pglazyfreed (npn)
 		Amount of reclaimed lazyfree pages
 
+	  swpin_zero
+		Number of pages swapped into memory and filled with zero, where I/O
+		was optimized out because the page content was detected to be zero
+		during swapout.
+
+	  swpout_zero
+		Number of zero-filled pages swapped out with I/O skipped due to the
+		content being detected as zero.
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


