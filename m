Return-Path: <linux-kernel+bounces-193028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D5E8D25BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B171C218F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A567A17DE16;
	Tue, 28 May 2024 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LkZenzNv"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E317BB3E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927714; cv=none; b=HfD5IlK4F4WRjX90gBItBNPjxUlaDYSSnkBpyFvIgrOXdPOd69rYk+l1cZ3smNRzBVjcCyHWAyPjbIbVUGqjZ7IDgQS2n9jtuu9Pc1lwGBsdBRdk13PXjMLOwOanwlqn05+gYN0jTISNO0Llk8DfwRc5KkfrnnLqv088XhiHXoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927714; c=relaxed/simple;
	bh=yU/Zcw3aI8AjMKksL2tdtgKEwEThetupmLxc/WFBv1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSxpm2K8DdWao5olI0IoTFgN2jd0jDQvQ/1FxGn2PX2xySDBNIlRK1Q5LVbBXbdmK49EdvDvyOo7mAZUJT8tFxooPtJjx0Ivsg7gHGxoJwUZlgQBkRpqnRVmNDYuf2KmMuUMrKtyFKex/4mxcg3yCZ2I/KLAr2f4IYMo7hdiQuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LkZenzNv; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716927711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OeFsCVicsmIcJz/F7rjSxNev8T0hhwq0eN6+J3Y4BM8=;
	b=LkZenzNvmfsJgfDdOHnpDbqf2Na0D38sAL9OmxSR8fBqCjbiSMP/ZL3nHkm6LHssps2b4X
	4Bv/L0c++DrNIfkFSX9UOfULUTn4B1FArCAXQ4nGirdw2AxLiILByzklAeAPwjKF2Tmvz5
	JSqzJmTzj5EF9CN5CPuGrnstZlmh8as=
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
Subject: [PATCH v1 09/14] mm: memcg: rename memcg_oom_recover()
Date: Tue, 28 May 2024 13:21:01 -0700
Message-ID: <20240528202101.3099300-10-roman.gushchin@linux.dev>
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

Rename memcg_oom_recover() into memcg1_oom_recover() for consistency
with other memory cgroup v1-related functions.

Move the declaration in mm/memcontrol-v1.h to be nearby other
memcg v1 oom handling functions.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol-v1.c | 6 +++---
 mm/memcontrol-v1.h | 2 +-
 mm/memcontrol.c    | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 6188b33ba03db..f73551ff8b2d1 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1090,8 +1090,8 @@ static void __mem_cgroup_clear_mc(void)
 
 		mc.moved_swap = 0;
 	}
-	memcg_oom_recover(from);
-	memcg_oom_recover(to);
+	memcg1_oom_recover(from);
+	memcg1_oom_recover(to);
 	wake_up_all(&mc.waitq);
 }
 
@@ -2067,7 +2067,7 @@ static int memcg_oom_wake_function(wait_queue_entry_t *wait,
 	return autoremove_wake_function(wait, mode, sync, arg);
 }
 
-void memcg_oom_recover(struct mem_cgroup *memcg)
+void memcg1_oom_recover(struct mem_cgroup *memcg)
 {
 	/*
 	 * For the following lockless ->under_oom test, the only required
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 3de956b2422f1..972c493a8ae32 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -13,7 +13,6 @@ static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
 
 void mem_cgroup_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
 void memcg1_check_events(struct mem_cgroup *memcg, int nid);
-void memcg_oom_recover(struct mem_cgroup *memcg);
 int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		     unsigned int nr_pages);
 
@@ -92,5 +91,6 @@ ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 
 bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked);
 void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
+void memcg1_oom_recover(struct mem_cgroup *memcg);
 
 #endif	/* __MM_MEMCONTROL_V1_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3b088e0078821..1622086cab274 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3169,7 +3169,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 	} while (true);
 
 	if (!ret && enlarge)
-		memcg_oom_recover(memcg);
+		memcg1_oom_recover(memcg);
 
 	return ret;
 }
@@ -3754,7 +3754,7 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
 
 	WRITE_ONCE(memcg->oom_kill_disable, val);
 	if (!val)
-		memcg_oom_recover(memcg);
+		memcg1_oom_recover(memcg);
 
 	return 0;
 }
@@ -5481,7 +5481,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 			page_counter_uncharge(&ug->memcg->memsw, ug->nr_memory);
 		if (ug->nr_kmem)
 			memcg_account_kmem(ug->memcg, -ug->nr_kmem);
-		memcg_oom_recover(ug->memcg);
+		memcg1_oom_recover(ug->memcg);
 	}
 
 	local_irq_save(flags);
-- 
2.45.1


