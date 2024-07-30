Return-Path: <linux-kernel+bounces-267748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E342B94150F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119BC1C23017
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1132A1C7;
	Tue, 30 Jul 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Nm11yIpS"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977051A0B1A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351755; cv=none; b=Kubig63Isp7JC7vHJ966F0B9wmn+QmiPcIaMZd3ekuZkJPOHTMXqngn/xmqg367nqyzKvVjHUa6tldrQ3Ic5TgcVXyWzmOY3Mb9KEA9bei8eQQZ0ntGVAVQrm3rfQsUcw8n5oV9IKD+EHKUEunlhW79i5sRXya5FKZsciYQyzR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351755; c=relaxed/simple;
	bh=dHKZkmG/VXTGH5N/BUNRvkBMgEHtHZVj7W0wVsS460g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cK9/48sTKfyoOUdZUEQNVpTBkmuBD2GAo2uElt1xt9dUFpDudDV8phvFtvRfwDRTcrz+suv54eSSIfrjda4pSJsSmUwPE+wS6LjH2nlv4e1cHaXdsCfmqDbvhozZJ8N0nN5EfX+KWTDbFkHJGWR+ChPEE9hOSvfj1V1gZwVm+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Nm11yIpS; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1e1237e9aso286541885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1722351752; x=1722956552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qK7WOu+hv7tl+cxtg7CXPtDPtjLG3K7kUlaYAaWdes0=;
        b=Nm11yIpSZK/N/RD92e3yEqnL/nQwH0884Nl/K7g9kCJ27Pbm+1u2UwO1/nXmSI37s+
         EOFDJKAdmpLq/7nQAJecEiGrtK5PTPnVstKK4xOXn+ofSZfs9c7wnq4VBecvhHolGXOh
         qQEDyBL/hjw95gIc6luBUl8xfFVm+P2rFu+FLCEXd9ZIIcMTkAfW2SLMR2EVhBEX4VZt
         80EPRu9QMZuRjCYTn63+M2AzFgEe5BPjIF4KgDHxgQwyzUWmjSp6Qb7KgygPhyvw0knx
         CepLK4m/qeQdoRaYp1YgFfcGSVuh2JLLPPAJlcva5FtaNuSBVqJDNNujPkr6WjjcX6Us
         GZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722351752; x=1722956552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qK7WOu+hv7tl+cxtg7CXPtDPtjLG3K7kUlaYAaWdes0=;
        b=kKL/p0cc6Bb2vc98EaFD2J+kaw30hMQkzCCwPSm89rdRBbDKlGRSLsmrKQiTbyvW8Z
         GL3g1i8efv5Aa5D4gEj0z08brPGqebxtOee5bU+09ax7z9AfWxZSAYi+Gy/cnU8zdS/s
         sWSFsf6WSEc9nvD+y4K+ecNyAYquo5Xwv7YIiaySlvNUsEg9a90aysLvAdyoNKEOUPuW
         o3cg42e7YROHOJg5jrLCEXBnRaBJOxSpoTtDRnHQAYi8U+1zuEdGGTeAElYoFjnPztQW
         ne1uPdTCRxnuk+aNDaeGbaIkKpRD7i2NLiODdy/XuVuPUbgX+eKtSIK1mR39r9gj25QV
         SiIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4ojrmDMjl5l7P/7fUa334bdrIeG5CnuHcFvhDlMkZQ209c/reH+lpDhXAVIB8ZfZJHeIOUt40PwbYp54hugkfR3+5RxO/XUj9JqD7
X-Gm-Message-State: AOJu0YzowI+5TWsOdtICj/OELMzuVqmDdvNOT8FCNoiIGcVcHpnbgVYu
	BrxWe/RgGABhDtjTl8cydiz4b50Fgsn0LKvLMRzpo+QZtEpJxfbPEBcrb/nTG40=
X-Google-Smtp-Source: AGHT+IGuBFGt6MK7hI5v2XIYYwSP41dPGObuYRlJA5D+J3MWpue7Ez/s4WblQus1adMdjSSsNHR4iQ==
X-Received: by 2002:a05:620a:179f:b0:79c:e7d:22b6 with SMTP id af79cd13be357-7a1e525fafbmr1390496785a.39.1722351722274;
        Tue, 30 Jul 2024 08:02:02 -0700 (PDT)
Received: from soleen.c.googlers.com.com (197.5.86.34.bc.googleusercontent.com. [34.86.5.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73efffdsm645934285a.69.2024.07.30.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:02:01 -0700 (PDT)
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
	linux-mm@kvack.org,
	yosryahmed@google.com
Subject: [PATCH v6 1/3] memcg: increase the valid index range for memcg stats
Date: Tue, 30 Jul 2024 15:01:56 +0000
Message-ID: <20240730150158.832783-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
In-Reply-To: <20240730150158.832783-1-pasha.tatashin@soleen.com>
References: <20240730150158.832783-1-pasha.tatashin@soleen.com>
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
index 960371788687..84f383952d32 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -320,24 +320,27 @@ static const unsigned int memcg_stat_items[] = {
 #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
 #define MEMCG_VMSTAT_SIZE (NR_MEMCG_NODE_STAT_ITEMS + \
 			   ARRAY_SIZE(memcg_stat_items))
-static int8_t mem_cgroup_stats_index[MEMCG_NR_STAT] __read_mostly;
+#define BAD_STAT_IDX(index) ((u32)(index) >= U8_MAX)
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
+	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return 0;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
@@ -392,7 +395,7 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 		return node_page_state(lruvec_pgdat(lruvec), idx);
 
 	i = memcg_stats_index(idx);
-	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
+	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
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
+	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return 0;
 
 	x = READ_ONCE(memcg->vmstats->state[i]);
@@ -662,7 +668,7 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 	if (mem_cgroup_disabled())
 		return;
 
-	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
+	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return;
 
 	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
@@ -675,7 +681,7 @@ unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 	long x;
 	int i = memcg_stats_index(idx);
 
-	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
+	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return 0;
 
 	x = READ_ONCE(memcg->vmstats->state_local[i]);
@@ -694,7 +700,7 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 	struct mem_cgroup *memcg;
 	int i = memcg_stats_index(idx);
 
-	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
+	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
@@ -810,7 +816,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 	if (mem_cgroup_disabled())
 		return;
 
-	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
+	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return;
 
 	memcg_stats_lock();
@@ -823,7 +829,7 @@ unsigned long memcg_events(struct mem_cgroup *memcg, int event)
 {
 	int i = memcg_events_index(event);
 
-	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, event))
+	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, event))
 		return 0;
 
 	return READ_ONCE(memcg->vmstats->events[i]);
@@ -833,7 +839,7 @@ unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 {
 	int i = memcg_events_index(event);
 
-	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, event))
+	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, event))
 		return 0;
 
 	return READ_ONCE(memcg->vmstats->events_local[i]);
-- 
2.46.0.rc1.232.g9752f9e123-goog


