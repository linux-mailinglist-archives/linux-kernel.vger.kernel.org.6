Return-Path: <linux-kernel+bounces-280147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FAB94C656
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E301F2524D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2B515CD42;
	Thu,  8 Aug 2024 21:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="R659dDfm"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BD813DDC0
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 21:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723152884; cv=none; b=nht//AK9l4PKpNe5A93vA/q3voD5KpVWRKv6QNH7QbOwhmapvBEbZWRQG/PKlepITIoxPANZXBuzqqdd9IQ/+T8I5tLTDqnziS8YYVkeZ9v7hnbKxYA78WgtVnDHMjbGdTqQc17qh1YO+iZst3r4HRxjUTqUjeqo0tEtFWvLCbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723152884; c=relaxed/simple;
	bh=LPymHoA6qtomFJj9prs4W/8rrsULUAMfwn30gfK801o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wi01qnZxSwjax1KCkFDBF3mKsjV+Uk0Bofyi4sSHyU9CYSVu7NKOEz8e8J1v0RJ3BXH6YEyo2VMM+1+xwaSlJTQT+n13Vk4ccyBAKt08rNt6r0p1LH94KQrjfw5WXVnJHz8GtWysVVnfY0MMYasaO9b6Zz53FewChPlhsopQ9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=R659dDfm; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-8205ceff95cso487953241.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 14:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723152881; x=1723757681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YmoLJUzKwh05YDZkUnFH4Q03LnbmDmhfqr83K75cyk=;
        b=R659dDfmPHqrWs0s7iDXfuSm+V9j/3GmFB5pzAoEjBSgAV6VHaigwehiQ2lbpnU7UZ
         biS0xUioOK8jJq0a7QDiUz8N5LNdHECjYX+1RO6agHi/uvQwMutK4TPsO9pA1zWCwdNH
         14eI2AcLYWHYIQIWSicK/Ehra8cgJjACZS/imhFcNPhYhD2sWPVK2oxDCTg4U+emvVKw
         /rQ82Gw6vOlTvWs5FCnuQz183HaoTUAHWn1L2bNqVGp9zPFSBS6Xz3ibmQE4WDnX18OG
         70tSDrhG0qiZEU1J28Cye9drvsqtljLW5nojdEAQLgNAgYYuSjAy7CpjTa0iiD1IUkvI
         hIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723152881; x=1723757681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YmoLJUzKwh05YDZkUnFH4Q03LnbmDmhfqr83K75cyk=;
        b=fhqWUGe9oYPey00mKnmZG//kgoBJUeEy7/apNrAzTkHJoIK7SuNtycU90iIwkFeUUe
         I45nA9JQw0fIZVaYeD5g0Wubb1gd6Ud2bgpYsuwIoeDpK8ctlNjFWcU2GPM/EUWOORi6
         6MW5BdbWkBw3ltbdVH1m4HGRB4gNVj7FdlNqTJdK3bHiFAWGNdPjDL23hdsaQtOzK78A
         ZPgjg92cTnjUMhkwYE/SmIALADObbZ28Xi9Bw5r7rmJfaa+79ZDAFhEoK7Q197ZjRGW1
         eu2CUu60/9Zv4iRQAZKbLychlrOD2U6Yqd312S9hLgP4QMySqlg+Ls6re8QfjdsyCprK
         Enyg==
X-Forwarded-Encrypted: i=1; AJvYcCUafoBpcIlh5DpxSwPT4CV/scPc1bW/LTJVSLv5g6M3XHXLHcMdWGHS7BDNGlwHF1G/FpDF8ZOcC/GqsOVzYGBoe6tZ1xAZ9VeWMVqw
X-Gm-Message-State: AOJu0Yyc34ItCByut5Kw5SRtiPhmMK9no7DB23Zmnmdb4kXIBhe0Aqm+
	tOuT0wic7x50fCtKr+oUyoHGH5shxnq2t0NNuwwgxvB6TBOXyLl58RC5/outfxQ=
X-Google-Smtp-Source: AGHT+IE4Qv1sn/qov17GIXusF8ykKagazq0LzzEpnGG7EXiIsWLtpNSrGNRu3rLDOXEBkRSnwDDAyA==
X-Received: by 2002:a05:6102:2acb:b0:492:ab05:8d6e with SMTP id ada2fe7eead31-495c5b38e89mr3764112137.3.1723152880951;
        Thu, 08 Aug 2024 14:34:40 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c762bd1sm70205026d6.29.2024.08.08.14.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 14:34:40 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	cerasuolodomenico@gmail.com,
	hannes@cmpxchg.org,
	j.granados@samsung.com,
	lizhijian@fujitsu.com,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	pasha.tatashin@soleen.com,
	rientjes@google.com,
	rppt@kernel.org,
	souravpanda@google.com,
	vbabka@suse.cz,
	willy@infradead.org,
	dan.j.williams@intel.com,
	yi.zhang@redhat.com,
	alison.schofield@intel.com,
	david@redhat.com,
	yosryahmed@google.com
Subject: [PATCH v4 2/3] mm: add system wide stats items category
Date: Thu,  8 Aug 2024 21:34:35 +0000
Message-ID: <20240808213437.682006-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240808213437.682006-1-pasha.tatashin@soleen.com>
References: <20240808213437.682006-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/proc/vmstat contains events and stats, events can only grow, but stats
can grow and shrink.

vmstat has the following:
-------------------------
NR_VM_ZONE_STAT_ITEMS:	per-zone stats
NR_VM_NUMA_EVENT_ITEMS:	per-numa events
NR_VM_NODE_STAT_ITEMS:	per-numa stats
NR_VM_WRITEBACK_STAT_ITEMS:	system-wide background-writeback and
				dirty-throttling tresholds.
NR_VM_EVENT_ITEMS:	system-wide events
-------------------------

Rename NR_VM_WRITEBACK_STAT_ITEMS to NR_VM_STAT_ITEMS, to track the
system-wide stats, we are going to add per-page metadata stats to this
category in the next patch.

Also delete unused writeback_stat_name() function.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/vmstat.h | 15 ++++-----------
 mm/vmstat.c            |  6 +++---
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 23cd17942036..9ab4fa5e09b5 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -34,10 +34,11 @@ struct reclaim_stat {
 	unsigned nr_lazyfree_fail;
 };
 
-enum writeback_stat_item {
+/* Stat data for system wide items */
+enum vm_stat_item {
 	NR_DIRTY_THRESHOLD,
 	NR_DIRTY_BG_THRESHOLD,
-	NR_VM_WRITEBACK_STAT_ITEMS,
+	NR_VM_STAT_ITEMS,
 };
 
 #ifdef CONFIG_VM_EVENT_COUNTERS
@@ -514,21 +515,13 @@ static inline const char *lru_list_name(enum lru_list lru)
 	return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
 }
 
-static inline const char *writeback_stat_name(enum writeback_stat_item item)
-{
-	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
-			   NR_VM_NUMA_EVENT_ITEMS +
-			   NR_VM_NODE_STAT_ITEMS +
-			   item];
-}
-
 #if defined(CONFIG_VM_EVENT_COUNTERS) || defined(CONFIG_MEMCG)
 static inline const char *vm_event_name(enum vm_event_item item)
 {
 	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
 			   NR_VM_NUMA_EVENT_ITEMS +
 			   NR_VM_NODE_STAT_ITEMS +
-			   NR_VM_WRITEBACK_STAT_ITEMS +
+			   NR_VM_STAT_ITEMS +
 			   item];
 }
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 04a1cb6cc636..6f8aa4766f16 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1257,7 +1257,7 @@ const char * const vmstat_text[] = {
 	"pgdemote_khugepaged",
 	"nr_memmap",
 	"nr_memmap_boot",
-	/* enum writeback_stat_item counters */
+	/* system-wide enum vm_stat_item counters */
 	"nr_dirty_threshold",
 	"nr_dirty_background_threshold",
 
@@ -1790,7 +1790,7 @@ static const struct seq_operations zoneinfo_op = {
 #define NR_VMSTAT_ITEMS (NR_VM_ZONE_STAT_ITEMS + \
 			 NR_VM_NUMA_EVENT_ITEMS + \
 			 NR_VM_NODE_STAT_ITEMS + \
-			 NR_VM_WRITEBACK_STAT_ITEMS + \
+			 NR_VM_STAT_ITEMS + \
 			 (IS_ENABLED(CONFIG_VM_EVENT_COUNTERS) ? \
 			  NR_VM_EVENT_ITEMS : 0))
 
@@ -1827,7 +1827,7 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
 
 	global_dirty_limits(v + NR_DIRTY_BG_THRESHOLD,
 			    v + NR_DIRTY_THRESHOLD);
-	v += NR_VM_WRITEBACK_STAT_ITEMS;
+	v += NR_VM_STAT_ITEMS;
 
 #ifdef CONFIG_VM_EVENT_COUNTERS
 	all_vm_events(v);
-- 
2.46.0.76.ge559c4bf1a-goog


