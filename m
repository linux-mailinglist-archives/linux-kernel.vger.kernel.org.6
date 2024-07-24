Return-Path: <linux-kernel+bounces-261506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0653D93B80F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844EE1F22022
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EB7137C35;
	Wed, 24 Jul 2024 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="qQiHnNvP"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE1F13A240
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721853209; cv=none; b=J9IqAPKUA4iajecryxx8+orUMU0KYLPc1o5skl04BXSEYbYbXrJjSofHbBFVab2wgq9Jw6mj8zNUvkLvdAPj0usF7KTEcN6Xf9V5zzrw1Nw6TXv8eDByBEEstMn65D9Z0OrmmqUqgLhRLkWqkPixfRTQvF0f30aS3kp7V/u+pFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721853209; c=relaxed/simple;
	bh=4wxgB74edsFm6Dr9FcZQqUwub70B++YR0pA1qUyMwug=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqOw1a07yUey6OXmqbIgqUG4hS2rhkVK2n/yjzyXaBV/3oDWmNrN1KyAS0zJdFt8TgRFikXhb14SYuOZlOIZ/HmP8hmoCY06/ctvPRJX+o4UcBjxJGfjtxxFZTAK/JvlCGqVbX6ijfs9WeNs1Z78eia0Z4ey4K9HvQKj/b3xsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=qQiHnNvP; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1d3959ad5so28366685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1721853206; x=1722458006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=za/dqz+eg2q+LXUxzWgwz8U+r7avopRJxf8/6QSZyz0=;
        b=qQiHnNvPcY4CokjlY2F2mdFthyyTgIj6B0CvLLWw5sBkEO1YPJcAyUxZyBiv7T2J81
         OPjXCmOagcQ5Vg3RxA90gvEWZmtJt3QwASNQyoKZkat1dDhCIoTBjawcftidIo4tBqrK
         sXKk/8E1jXQ/iYqzanevnkO+c5YXspcPyBzQHygYPCe+vRN7w8Iiso80aR7Gs1ZNeIFb
         TBEuslpEwCuXYjv1yxhZ6XC3pbU7pgIyWkbuvxE2okO4iseTs1vmJngPNEyz7P2wJaJy
         ktNjVF+aa1yNrR7zYKwbpsdhgh07U8zcQmgDeSzpjvoBENJd+3XYkFuclwVwXVtz4yKc
         VbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721853206; x=1722458006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=za/dqz+eg2q+LXUxzWgwz8U+r7avopRJxf8/6QSZyz0=;
        b=pN6QfY14at8P2VlDDQi9KRUgvk44dei10e6OAJjUAOeNl4Psv8gNB23IvfEitRY7Lo
         ygxSr7xnl2HyXqFtcIpApEuSASM6H3laHT23dKxYa1Zn4S0hPgv5j7nufjtiTjq5gdFv
         wszivTI/tW1OyksR9AyEa/OXZ00IO+Etv63nSIYu1+sDNp8tVc17sjcolmXbOdzeuOei
         WDHdJxo85T6PCqi+1O7hlaZvtYUDSvv/iy8QODCo0czPaJa6FK1C1EELEGzCvALMc+cd
         QNdRStm+2z2Da126uqfnfPeTuDIaN5B59M7QkD823hAzgMPzLz5g15BtTN9SLNbhWNQ7
         b5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVmFF2cS0hFb/xkYUGomSTDx0k0JaxmzJnJRJvBGBNkXBFkXUHaenHvOK2fUKXDlqic2ZPalD7OTxE3mGAPFCkFLinHoKNXfZyXHjw8
X-Gm-Message-State: AOJu0YwLeoab0AItjcpeW/NmGNNo5sARRUIx6zl1oA1deMCHasaA6NH7
	M5zUitexbrKKCzY0Rfy3zLpw7rPD7br1L5OSynX0n2PCFnQL3+E+XyjT7YgMhTo=
X-Google-Smtp-Source: AGHT+IExTwTAOD/5fd9WfUJdqA5+PovpxcivQTu3nfLVJy2iPs6JHKTbh5T2ftGVvWPvF45SGasYCg==
X-Received: by 2002:a05:620a:199b:b0:79f:7c0:ebfd with SMTP id af79cd13be357-7a1ccd334bfmr551254285a.16.1721853206521;
        Wed, 24 Jul 2024 13:33:26 -0700 (PDT)
Received: from soleen.c.googlers.com.com (197.5.86.34.bc.googleusercontent.com. [34.86.5.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b1786sm466485a.33.2024.07.24.13.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 13:33:25 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	jpoimboe@kernel.org,
	pasha.tatashin@soleen.com,
	kent.overstreet@linux.dev,
	peterz@infradead.org,
	nphamcs@gmail.com,
	cerasuolodomenico@gmail.com,
	surenb@google.com,
	lizhijian@fujitsu.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	vbabka@suse.cz,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 1/3] memcg: increase the valid index range for memcg stats
Date: Wed, 24 Jul 2024 20:33:20 +0000
Message-ID: <20240724203322.2765486-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
In-Reply-To: <20240724203322.2765486-1-pasha.tatashin@soleen.com>
References: <20240724203322.2765486-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shakeel Butt <shakeel.butt@linux.dev>

At the moment the valid index for the indirection tables for memcg stats
and events is < S8_MAX. These indirection tables are used in performance
critical codepaths. With the latest addition to the vm_events, the
NR_VM_EVENT_ITEMS has gone over S8_MAX. One way to resolve is to
increase the entry size of the indirection table from int8_t to int16_t
but this will increase the potential number of cachelines needed to
access the indirection table.

This patch took a different approach and make the valid index < U8_MAX.
In this way the size of the indirection tables will remain same and we
only need to invalid index check from less than 0 to equal to U8_MAX.
In this approach we have also removed a subtraction from the performance
critical codepaths.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/memcontrol.c | 50 +++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 960371788687..2fdeece7f1f8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -320,24 +320,27 @@ static const unsigned int memcg_stat_items[] = {
 #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
 #define MEMCG_VMSTAT_SIZE (NR_MEMCG_NODE_STAT_ITEMS + \
 			   ARRAY_SIZE(memcg_stat_items))
-static int8_t mem_cgroup_stats_index[MEMCG_NR_STAT] __read_mostly;
+#define IS_INVALID(index) ((index) == U8_MAX)
+static u8 mem_cgroup_stats_index[MEMCG_NR_STAT] __read_mostly;
 
 static void init_memcg_stats(void)
 {
-	int8_t i, j = 0;
+	u8 i, j = 0;
 
-	BUILD_BUG_ON(MEMCG_NR_STAT >= S8_MAX);
+	BUILD_BUG_ON(MEMCG_NR_STAT >= U8_MAX);
 
-	for (i = 0; i < NR_MEMCG_NODE_STAT_ITEMS; ++i)
-		mem_cgroup_stats_index[memcg_node_stat_items[i]] = ++j;
+	memset(mem_cgroup_stats_index, U8_MAX, sizeof(mem_cgroup_stats_index));
 
-	for (i = 0; i < ARRAY_SIZE(memcg_stat_items); ++i)
-		mem_cgroup_stats_index[memcg_stat_items[i]] = ++j;
+	for (i = 0; i < NR_MEMCG_NODE_STAT_ITEMS; ++i, ++j)
+		mem_cgroup_stats_index[memcg_node_stat_items[i]] = j;
+
+	for (i = 0; i < ARRAY_SIZE(memcg_stat_items); ++i, ++j)
+		mem_cgroup_stats_index[memcg_stat_items[i]] = j;
 }
 
 static inline int memcg_stats_index(int idx)
 {
-	return mem_cgroup_stats_index[idx] - 1;
+	return mem_cgroup_stats_index[idx];
 }
 
 struct lruvec_stats_percpu {
@@ -369,7 +372,7 @@ unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
 		return node_page_state(lruvec_pgdat(lruvec), idx);
 
 	i = memcg_stats_index(idx);
-	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
+	if (WARN_ONCE(IS_INVALID(i), "%s: missing stat item %d\n", __func__, idx))
 		return 0;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
@@ -392,7 +395,7 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 		return node_page_state(lruvec_pgdat(lruvec), idx);
 
 	i = memcg_stats_index(idx);
-	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
+	if (WARN_ONCE(IS_INVALID(i), "%s: missing stat item %d\n", __func__, idx))
 		return 0;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
@@ -435,21 +438,24 @@ static const unsigned int memcg_vm_event_stat[] = {
 };
 
 #define NR_MEMCG_EVENTS ARRAY_SIZE(memcg_vm_event_stat)
-static int8_t mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
+static u8 mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
 
 static void init_memcg_events(void)
 {
-	int8_t i;
+	u8 i;
+
+	BUILD_BUG_ON(NR_VM_EVENT_ITEMS >= U8_MAX);
 
-	BUILD_BUG_ON(NR_VM_EVENT_ITEMS >= S8_MAX);
+	memset(mem_cgroup_events_index, U8_MAX,
+	       sizeof(mem_cgroup_events_index));
 
 	for (i = 0; i < NR_MEMCG_EVENTS; ++i)
-		mem_cgroup_events_index[memcg_vm_event_stat[i]] = i + 1;
+		mem_cgroup_events_index[memcg_vm_event_stat[i]] = i;
 }
 
 static inline int memcg_events_index(enum vm_event_item idx)
 {
-	return mem_cgroup_events_index[idx] - 1;
+	return mem_cgroup_events_index[idx];
 }
 
 struct memcg_vmstats_percpu {
@@ -621,7 +627,7 @@ unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 	long x;
 	int i = memcg_stats_index(idx);
 
-	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
+	if (WARN_ONCE(IS_INVALID(i), "%s: missing stat item %d\n", __func__, idx))
 		return 0;
 
 	x = READ_ONCE(memcg->vmstats->state[i]);
@@ -662,7 +668,7 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 	if (mem_cgroup_disabled())
 		return;
 
-	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
+	if (WARN_ONCE(IS_INVALID(i), "%s: missing stat item %d\n", __func__, idx))
 		return;
 
 	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
@@ -675,7 +681,7 @@ unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 	long x;
 	int i = memcg_stats_index(idx);
 
-	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
+	if (WARN_ONCE(IS_INVALID(i), "%s: missing stat item %d\n", __func__, idx))
 		return 0;
 
 	x = READ_ONCE(memcg->vmstats->state_local[i]);
@@ -694,7 +700,7 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 	struct mem_cgroup *memcg;
 	int i = memcg_stats_index(idx);
 
-	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
+	if (WARN_ONCE(IS_INVALID(i), "%s: missing stat item %d\n", __func__, idx))
 		return;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
@@ -810,7 +816,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 	if (mem_cgroup_disabled())
 		return;
 
-	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
+	if (WARN_ONCE(IS_INVALID(i), "%s: missing stat item %d\n", __func__, idx))
 		return;
 
 	memcg_stats_lock();
@@ -823,7 +829,7 @@ unsigned long memcg_events(struct mem_cgroup *memcg, int event)
 {
 	int i = memcg_events_index(event);
 
-	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, event))
+	if (WARN_ONCE(IS_INVALID(i), "%s: missing stat item %d\n", __func__, event))
 		return 0;
 
 	return READ_ONCE(memcg->vmstats->events[i]);
@@ -833,7 +839,7 @@ unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 {
 	int i = memcg_events_index(event);
 
-	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, event))
+	if (WARN_ONCE(IS_INVALID(i), "%s: missing stat item %d\n", __func__, event))
 		return 0;
 
 	return READ_ONCE(memcg->vmstats->events_local[i]);
-- 
2.45.2.1089.g2a221341d9-goog


