Return-Path: <linux-kernel+bounces-234544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5712091C7C2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D621C26367
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E57200C7;
	Fri, 28 Jun 2024 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qScH7uId"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4047FBDF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608638; cv=none; b=HXemnl/F7SplRczJgpphbBj//VRyuWoRoSeDm2F10Qag5wSBVfC3NStzRDgB4KzutQR7r/Tsuk2mO8h6IxswyOTnPCNX+DPnFPpQsCIicOyxpMmGmT+D1UcWqcCdAwm/VN41wmfxoJUVGhuHePy1W0u3IIWfLfstBjSOpFbZgmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608638; c=relaxed/simple;
	bh=jrdNc1FvYMoNxZiGVSA0JQFKUK+6PIskXh3kA3K1MRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVj0bRcgftGh5VlqZ6l6gyVSTBfmWojGvZWmrY7yj5JFXNdu6GR2w1Ej1dMEiRID27CA3Insny0OJNGYl0PxhMoqm7cCWG8Vkw/Ym2imWxRbfP/2TBsUB7ucv1p6LPv0bxLdmMiTY1UsDJTA6jaJRzIypFGMxsAoftSVC9f2oto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qScH7uId; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719608635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ftjq9d47t8edbds95FzE0JhHDxWshorq1wfRXh80pJE=;
	b=qScH7uIdUhSfmN6nvR0ns/TrqGeFu3T4kb4Qb1WEjtGASe1cRWhPo/8WujA5868tRA/ntU
	Qv1YDCW1CXcDnM7amCXludxngCWUhPkf+uTrkSiIPsSPh4N2G/INANYAWA8vJE9HtcH6rd
	7MPWOjrK/oVLHuzKgcF7Z1x+p8nCgHQ=
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 4/9] mm: memcg: gather memcg1-specific fields initialization in memcg1_memcg_init()
Date: Fri, 28 Jun 2024 21:03:12 +0000
Message-ID: <20240628210317.272856-5-roman.gushchin@linux.dev>
In-Reply-To: <20240628210317.272856-1-roman.gushchin@linux.dev>
References: <20240628210317.272856-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Gather all memcg1-specific struct mem_cgroup's members initialization
in a new memcg1_memcg_init() function, defined in mm/memcontrol-v1.c.
Obviously, if CONFIG_MEMCG_V1 is not set, there is no need to
initialize these fields, so the function becomes trivial.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol-v1.c | 9 +++++++++
 mm/memcontrol-v1.h | 2 ++
 mm/memcontrol.c    | 6 +-----
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index c9b4c3e4797d..5fa48a45e34b 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1961,6 +1961,15 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	return ret;
 }
 
+void memcg1_memcg_init(struct mem_cgroup *memcg)
+{
+	INIT_LIST_HEAD(&memcg->oom_notify);
+	mutex_init(&memcg->thresholds_lock);
+	spin_lock_init(&memcg->move_lock);
+	INIT_LIST_HEAD(&memcg->event_list);
+	spin_lock_init(&memcg->event_list_lock);
+}
+
 void memcg1_css_offline(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup_event *event, *tmp;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index c8e5119223bb..6545fa1b7d09 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -76,6 +76,7 @@ int memory_stat_show(struct seq_file *m, void *v);
 
 /* Cgroup v1-specific declarations */
 #ifdef CONFIG_MEMCG_V1
+void memcg1_memcg_init(struct mem_cgroup *memcg);
 void memcg1_remove_from_trees(struct mem_cgroup *memcg);
 
 static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
@@ -124,6 +125,7 @@ extern struct cftype mem_cgroup_legacy_files[];
 
 #else	/* CONFIG_MEMCG_V1 */
 
+static inline void memcg1_memcg_init(struct mem_cgroup *memcg) {}
 static inline void memcg1_remove_from_trees(struct mem_cgroup *memcg) {}
 static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg) {}
 static inline bool memcg1_wait_acct_move(struct mem_cgroup *memcg) { return false; }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b69abd327549..e78ed54d46d2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3624,13 +3624,9 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 		goto fail;
 
 	INIT_WORK(&memcg->high_work, high_work_func);
-	INIT_LIST_HEAD(&memcg->oom_notify);
-	mutex_init(&memcg->thresholds_lock);
-	spin_lock_init(&memcg->move_lock);
 	vmpressure_init(&memcg->vmpressure);
-	INIT_LIST_HEAD(&memcg->event_list);
-	spin_lock_init(&memcg->event_list_lock);
 	memcg->socket_pressure = jiffies;
+	memcg1_memcg_init(memcg);
 #ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
 	INIT_LIST_HEAD(&memcg->objcg_list);
-- 
2.45.2.803.g4e1b14247a-goog


