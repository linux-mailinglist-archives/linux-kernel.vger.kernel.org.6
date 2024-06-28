Return-Path: <linux-kernel+bounces-234549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 822E791C7C7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29CE1C26C79
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BFB7E57F;
	Fri, 28 Jun 2024 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QpsayaNI"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C451F85285
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608650; cv=none; b=qZ5VGo9rAahd7UqhG1qTi5bwJYc0ANjv2f3JMMA+htjkAgIwlPa+DHLW3CC6862goUYuBr/BzWT1G1EEozgdhCT3nIFzTNpM0XLsTz9k6UrrXgX4G9horK2Z4nsyO2d14PExKV04p/wRIUBLIwzQvKV7JUz596HioSQxVJ6vHY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608650; c=relaxed/simple;
	bh=YiYPVdRLqxJLawA15SLmOwIEx5CxfztgDQBvQwuW+uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrCB5MTWdB183CLe/A8im3ji5Da4PRnhaTYX1qV2ZNADHGw/2J8B3qSv1shAqP8XwUpIVWUnTJcB/c3/TOZlmOa9D/15BqC+FFaMkIncXrq5Edb2ne5Q5z5GfNI9H12CTavfRI+XlwmokBnFZyCpqpCpQUabALuenrfPMPM91ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QpsayaNI; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719608644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oh6eW8o5ezSHh2B9Y0288jMuerKh+JrpdW4rG/niw6g=;
	b=QpsayaNInZKUdJVZpy1kkSsroiwMuaPQfyxm5rAk+pXTVr8En9fFyYvIwTr6R7dJ33uiKM
	1AzxHnAG8Ddl6RthYG+usN6D76Fxc8a0sAv/JKBzlZOI8QTxzSeg84AglcBFGF+h71kNIF
	DTcfQi/0cnTValmfFuaVbPpyxydd07g=
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
Subject: [PATCH v1 9/9] mm: memcg: put struct task_struct::in_user_fault under CONFIG_MEMCG_V1
Date: Fri, 28 Jun 2024 21:03:17 +0000
Message-ID: <20240628210317.272856-10-roman.gushchin@linux.dev>
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

The struct task_struct's in_user_fault member is not used by the
cgroup v2's memory controller, so it can be put under the
CONFIG_MEMCG_V1 config option. To do so, mem_cgroup_enter_user_fault()
and mem_cgroup_exit_user_fault() are moved under the CONFIG_MEMCG_V1
option as well.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 40 +++++++++++++++++++-------------------
 include/linux/sched.h      |  2 +-
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c7ef628ee882..d0c9365ff039 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -943,18 +943,6 @@ void mem_cgroup_print_oom_context(struct mem_cgroup *memcg,
 
 void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg);
 
-static inline void mem_cgroup_enter_user_fault(void)
-{
-	WARN_ON(current->in_user_fault);
-	current->in_user_fault = 1;
-}
-
-static inline void mem_cgroup_exit_user_fault(void)
-{
-	WARN_ON(!current->in_user_fault);
-	current->in_user_fault = 0;
-}
-
 struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
 					    struct mem_cgroup *oom_domain);
 void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
@@ -1402,14 +1390,6 @@ static inline void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 {
 }
 
-static inline void mem_cgroup_enter_user_fault(void)
-{
-}
-
-static inline void mem_cgroup_exit_user_fault(void)
-{
-}
-
 static inline struct mem_cgroup *mem_cgroup_get_oom_group(
 	struct task_struct *victim, struct mem_cgroup *oom_domain)
 {
@@ -1890,6 +1870,18 @@ static inline void mem_cgroup_unlock_pages(void)
 	rcu_read_unlock();
 }
 
+static inline void mem_cgroup_enter_user_fault(void)
+{
+	WARN_ON(current->in_user_fault);
+	current->in_user_fault = 1;
+}
+
+static inline void mem_cgroup_exit_user_fault(void)
+{
+	WARN_ON(!current->in_user_fault);
+	current->in_user_fault = 0;
+}
+
 #else /* CONFIG_MEMCG_V1 */
 static inline
 unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
@@ -1929,6 +1921,14 @@ static inline bool mem_cgroup_oom_synchronize(bool wait)
 	return false;
 }
 
+static inline void mem_cgroup_enter_user_fault(void)
+{
+}
+
+static inline void mem_cgroup_exit_user_fault(void)
+{
+}
+
 #endif /* CONFIG_MEMCG_V1 */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2a16023e8620..a7770c566c4d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -934,7 +934,7 @@ struct task_struct {
 #ifndef TIF_RESTORE_SIGMASK
 	unsigned			restore_sigmask:1;
 #endif
-#ifdef CONFIG_MEMCG
+#ifdef CONFIG_MEMCG_V1
 	unsigned			in_user_fault:1;
 #endif
 #ifdef CONFIG_LRU_GEN
-- 
2.45.2.803.g4e1b14247a-goog


