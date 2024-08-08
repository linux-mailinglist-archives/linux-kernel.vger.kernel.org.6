Return-Path: <linux-kernel+bounces-279773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C7B94C1AD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3EAC1F218F7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBBD18FDA6;
	Thu,  8 Aug 2024 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="odX2AyLr"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ABC19007E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131766; cv=none; b=gbqOIHCqyntL3b4CaCV19gXw1BfcbbI9WtFyk5U2gybOfQxCVxg2zapF3U/PtrPmII0zJNwCUXKJWpg5BPVPK9POvBbFHkyS3OfFeybktSu5vCRmLs8JNQv481SZBrPpcUoy0zAIm3OYEACJT774LFszQ9srGxLcD3royGmUFqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131766; c=relaxed/simple;
	bh=KzCccIwCfnqYYKbqVUPtNw8gt5c4QzHqTyrIudH/hWU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrDN5wpVEMHnCAPeF8J3weg4NkZtmr33H34XSwhnAWgY+KRRMLtVbx/wKqGlez0oYicF2FDlbp/X//gK1kS9z9ORF4L8UcxdI7rPCt8FjRU70bavBA5/CIau2YM+A9ASPu1oU+r40GJwOws8S0UTLkV4jvaSEjHQNoOYpg+NFX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=odX2AyLr; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b7b28442f9so11940096d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723131764; x=1723736564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDFp22AQxyyflK1t03n9dVCi8P6WDfRZ5X/KyWOrQIc=;
        b=odX2AyLrot3kgdbhZbBRiCYmdx1Zx8p8TW8nEmTyUYrO24SlNzAdXkx9+H0diWoXfY
         FAWruzir6KtjcsPh7xLFJo8K5E9T20dZxgUEPNCnE8FAHKfBml71z/BfkIPWt9oynFFS
         QuipZWInGHZDqQ+YFkPINM+DHDuWoqqpejaF7FqqsMYeXSdpf3ZLD6+dr8pOCz5OsW/o
         1c4h0lT7B1KD/W1yu26ZXLZpggXgPKw41TWzeVFcrR9z7LAj/oCsb6dObFVjR/5keC8q
         jkM9wtdCRUBmf/CcraGHny1b0Iuv2wJ7kp7yQB/yYjpzU/hRH7RNaVnW6fZuLmsNl4DC
         Po+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723131764; x=1723736564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDFp22AQxyyflK1t03n9dVCi8P6WDfRZ5X/KyWOrQIc=;
        b=ppHxHT8v7cOHWOlgVsZPzBI/3kL6XdK1ND47ckBfAPSZXjuUqHkaLMUAu3ETIp1xQZ
         1di8H+lDhL+NwyGiSmTsNQmAeAg3p9oH5fmvMAI/vkra1XQvHE6HRKNQbQ6iMsCJw4Ss
         PTTu7FDuWg646GSTCGY7ox9O+LXNr5z6698EPDqn1eLGWG9Eu/uOO9HiLjrqa5oukqnz
         TPPAEeqW017Zr2qciuYSwK/5xWuSoYJnOmYy8Jlq6cWEnt8O7n9qeZfkEJIGU+7Gc++3
         fP2DK7eNm6UEc7ZImzRAcu+5Ld+1GyOfnubFC36eCw8+i7zrWIF+ApV9U/Ns2Gk1F53c
         S80Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdGm07gNoubVR0A7oGY3frH9alns9A3dqQls3G9Bv1+kBrDiAMmuo5ofOwxmd2NFwtzAJpZ6vro8XJ/JBWhitDpTg4cBvMMq9I52l2
X-Gm-Message-State: AOJu0YzfvAtLzCV8HhZjZYqSBM3UQWp1371YqLONDkoXmz53sczqRf2R
	SzIyM89SWJJw4iJZLbuGQKNdLYr2MKKnNhhZAaK3cOq+a5z1RK65VFUBlrFtmjs=
X-Google-Smtp-Source: AGHT+IEX9KsTxhX/Ixnu+CrH4K+4EL15weClfV8tgGdVgFqf5/zGrOX8N7XKxkOKw/LPNvKUtrOSaQ==
X-Received: by 2002:a05:6214:5d0d:b0:6b5:7e09:970c with SMTP id 6a1803df08f44-6bd6bd227f2mr22276276d6.33.1723131763822;
        Thu, 08 Aug 2024 08:42:43 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b72d9sm67160936d6.60.2024.08.08.08.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:42:42 -0700 (PDT)
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
Subject: [PATCH v3 3/4] mm: add system wide stats items category
Date: Thu,  8 Aug 2024 15:42:36 +0000
Message-ID: <20240808154237.220029-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240808154237.220029-1-pasha.tatashin@soleen.com>
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/proc/vmstat contains events and stats, events can only grow, but stats
can grow and srhink.

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


