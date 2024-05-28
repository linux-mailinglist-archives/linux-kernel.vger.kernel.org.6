Return-Path: <linux-kernel+bounces-193023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EFD8D25B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B29928CB94
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2B817B4E0;
	Tue, 28 May 2024 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uEf6u+5H"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2A7178CFD
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927704; cv=none; b=d75YnqnFRTws/hOud0OAOs91Lep5BF+pLLFfOIeuNidvXeea2QhVXle0vrKOQPDwVnXFuisW4sya1xbDk7X44yPz/VscrASEiAV/fTyIfGGbDfcGidcHJdB0KgW8am0ldO4cJkih7bJTzmqjQ+rxstV7pv8h4VaInCP6iM8t1PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927704; c=relaxed/simple;
	bh=rAcoPgaFoESIAVPrFSOkSJde5889deNvoK0nmWMprN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1OeaOpQfFwznzq3LlMqLc2uJkivrFe/UrIfLtWO8e2eFVvH6+sjqEUwQs0oRy7o+bFV1qROQhOEQ42o9Wzb4Y0UFQNNOtseJmN+BIv+WTQxIRePlmUVXRhG58A1Z9G6u8iQAFmJTi/U9OWmPPirq63cGE8ae1UuGOOo8X/RDO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uEf6u+5H; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716927701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eun9LANYNIu6WRYBzr/NUdVevzuva5x/1L5dxfrGADE=;
	b=uEf6u+5H2ptxKxJYJqPeQz4DfDY15c2qmOVY/ZbMWk4dE+M1nT/rRUA2ZEqtnnY+ri68h9
	8aCs3D9eu74QEehioHZpRj37oa8wtOZTqdd3cDCg5sEnFhEEZwrVmVy9GE3VycxnUsYFHn
	FziRkd0mj5l+N0Zocgl/JWyUTsjDvfc=
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 05/14] mm: memcg: rename charge move-related functions
Date: Tue, 28 May 2024 13:20:57 -0700
Message-ID: <20240528202101.3099300-6-roman.gushchin@linux.dev>
In-Reply-To: <20240528202101.3099300-1-roman.gushchin@linux.dev>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Rename exported function related to the charge move to have
the memcg1_ prefix.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol-v1.c | 8 ++++----
 mm/memcontrol-v1.h | 8 ++++----
 mm/memcontrol.c    | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index f4c8bec5ae1b8..f3ea01a17eea9 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -384,7 +384,7 @@ static bool mem_cgroup_under_move(struct mem_cgroup *memcg)
 	return ret;
 }
 
-bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
+bool memcg1_wait_acct_move(struct mem_cgroup *memcg)
 {
 	if (mc.moving_task && current != mc.moving_task) {
 		if (mem_cgroup_under_move(memcg)) {
@@ -1056,7 +1056,7 @@ static void mem_cgroup_clear_mc(void)
 	mmput(mm);
 }
 
-int mem_cgroup_can_attach(struct cgroup_taskset *tset)
+int memcg1_can_attach(struct cgroup_taskset *tset)
 {
 	struct cgroup_subsys_state *css;
 	struct mem_cgroup *memcg = NULL; /* unneeded init to make gcc happy */
@@ -1126,7 +1126,7 @@ int mem_cgroup_can_attach(struct cgroup_taskset *tset)
 	return ret;
 }
 
-void mem_cgroup_cancel_attach(struct cgroup_taskset *tset)
+void memcg1_cancel_attach(struct cgroup_taskset *tset)
 {
 	if (mc.to)
 		mem_cgroup_clear_mc();
@@ -1285,7 +1285,7 @@ static void mem_cgroup_move_charge(void)
 	atomic_dec(&mc.from->moving_account);
 }
 
-void mem_cgroup_move_task(void)
+void memcg1_move_task(void)
 {
 	if (mc.to) {
 		mem_cgroup_move_charge();
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 55e7c4f90c399..d377c0be9880b 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -29,11 +29,11 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
 void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n);
 
-bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg);
+bool memcg1_wait_acct_move(struct mem_cgroup *memcg);
 struct cgroup_taskset;
-int mem_cgroup_can_attach(struct cgroup_taskset *tset);
-void mem_cgroup_cancel_attach(struct cgroup_taskset *tset);
-void mem_cgroup_move_task(void);
+int memcg1_can_attach(struct cgroup_taskset *tset);
+void memcg1_cancel_attach(struct cgroup_taskset *tset);
+void memcg1_move_task(void);
 
 struct cftype;
 u64 mem_cgroup_move_charge_read(struct cgroup_subsys_state *css,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ba538ab0a80ad..b983cb6d1d228 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2582,7 +2582,7 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * At task move, charge accounts can be doubly counted. So, it's
 	 * better to wait until the end of task_move if something is going on.
 	 */
-	if (mem_cgroup_wait_acct_move(mem_over_limit))
+	if (memcg1_wait_acct_move(mem_over_limit))
 		goto retry;
 
 	if (nr_retries--)
@@ -6032,12 +6032,12 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.css_free = mem_cgroup_css_free,
 	.css_reset = mem_cgroup_css_reset,
 	.css_rstat_flush = mem_cgroup_css_rstat_flush,
-	.can_attach = mem_cgroup_can_attach,
+	.can_attach = memcg1_can_attach,
 #if defined(CONFIG_LRU_GEN) || defined(CONFIG_MEMCG_KMEM)
 	.attach = mem_cgroup_attach,
 #endif
-	.cancel_attach = mem_cgroup_cancel_attach,
-	.post_attach = mem_cgroup_move_task,
+	.cancel_attach = memcg1_cancel_attach,
+	.post_attach = memcg1_move_task,
 #ifdef CONFIG_MEMCG_KMEM
 	.fork = mem_cgroup_fork,
 	.exit = mem_cgroup_exit,
-- 
2.45.1


