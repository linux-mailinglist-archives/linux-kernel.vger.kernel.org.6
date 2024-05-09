Return-Path: <linux-kernel+bounces-174107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA0B8C0A44
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520441F24802
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6F2149C47;
	Thu,  9 May 2024 03:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Exu/CQXX"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF24A14830C
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 03:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715226159; cv=none; b=tMHQra+9r+cqMr0EuOHOS0wol2h322KAPFVht/KNKfOwm+cbpNODfUtOL/rTZNMvLSl9XCGWQHjlpNDsuRjsMzGrfJi5zpfbpWNftMCDdH5ECfANvKICD70xoSQO0odGeMWMvUhNco1I27hpbwyesdw2viSPphMaGKQ1/tu1Yc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715226159; c=relaxed/simple;
	bh=iEylPXWx8PW786NEyrNzqH5lJq/Y7pg7f6hXkzHwIz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bb4HC9TZG1kCjPWDCIsDDI7BGWYpxUtWQeU3Q8kWYCzIgmVCRlvmnJU6Lc23sBjr4x1ux5NTvrittvi+/pao/ZqmJCcRlv7mQxLz1mGonpKiLBUmatpLam4d7I3ypqGBr+rukko8WEX/u6dwnsnjyuuQuuO+A04QbYeFQmu09jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Exu/CQXX; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715226148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dw2WxfyzO5phrNYcejGku6aC7TT0H0mgxaapi/nzE68=;
	b=Exu/CQXXta7/748feKtaHt6ZdSNf+MZZejRvNAAT//Krgqm+P11yXG98gr8CAkUsrJgl+o
	BHXl1frW++LIeLHUpp2ymfP2LhgalpYaW5nEbjDFc6vuljOGpIGBsdQIK0IbxjTePaUYB+
	mvY2jN0/UkvwueWbqM/FMOgJaL5V+KA=
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
Subject: [PATCH rfc 9/9] mm: memcg: put cgroup v1-related members of task_struct under config option
Date: Wed,  8 May 2024 20:41:38 -0700
Message-ID: <20240509034138.2207186-10-roman.gushchin@linux.dev>
In-Reply-To: <20240509034138.2207186-1-roman.gushchin@linux.dev>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Guard cgroup v1-related members of task_struct under the CONFIG_MEMCG_V1
config option, so that users who adopted cgroup v2 don't have to waste
the memory for fields which are never accessed.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 11 ++++++++++-
 include/linux/sched.h      |  5 ++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4347d6889fa0..8005d749f8fc 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -944,6 +944,7 @@ void mem_cgroup_print_oom_context(struct mem_cgroup *memcg,
 
 void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg);
 
+#ifdef CONFIG_MEMCG_V1
 static inline void mem_cgroup_enter_user_fault(void)
 {
 	WARN_ON(current->in_user_fault);
@@ -961,9 +962,17 @@ static inline bool task_in_memcg_oom(struct task_struct *p)
 	return p->memcg_in_oom;
 }
 
-#ifdef CONFIG_MEMCG_V1
 bool mem_cgroup_oom_synchronize(bool wait);
 #else
+static inline void mem_cgroup_enter_user_fault(void) {}
+
+static inline void mem_cgroup_exit_user_fault(void) {}
+
+static inline bool task_in_memcg_oom(struct task_struct *p)
+{
+	return false;
+}
+
 static inline bool mem_cgroup_oom_synchronize(bool wait)
 {
 	return false;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4118b3f959c3..2ecdeb7588e3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1446,11 +1446,14 @@ struct task_struct {
 	unsigned int			kcov_softirq;
 #endif
 
-#ifdef CONFIG_MEMCG
+
+#ifdef CONFIG_MEMCG_V1
 	struct mem_cgroup		*memcg_in_oom;
 	gfp_t				memcg_oom_gfp_mask;
 	int				memcg_oom_order;
+#endif
 
+#ifdef CONFIG_MEMCG
 	/* Number of pages to reclaim on returning to userland: */
 	unsigned int			memcg_nr_pages_over_high;
 
-- 
2.43.2


