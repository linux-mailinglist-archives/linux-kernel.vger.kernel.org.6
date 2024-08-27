Return-Path: <linux-kernel+bounces-304104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9F0961A45
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9106A1C22DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE2D1D54F2;
	Tue, 27 Aug 2024 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="luT5wC9r"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FA41D47DC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 23:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800307; cv=none; b=PJxhk4NO87ePl5mOSX2mhrwwYNt6Q1X16ZsNC7g5tRULBBAg393MOtuHYsNDCsiYUlql0AgWomhQRQ3mTxrqXRLByadUNT0dGA1GQCfJiCUIWgKml5p6OuE5fGAjhElkYuHOiGalEgIHlLdh6+SMYhr22tqYGT7PEa123WYdIxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800307; c=relaxed/simple;
	bh=S1S4yqh1NPYayJ940lwvzrOEw1UTdu7vbQmz11c0RI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P01uAxpxYGVZbn4qvsVy2iMVCeNylpZMfHfiozWBYkpl303exE0MN4c8xbq5bjKeJ2ibpSV1TAfsk/6UMcH3zzrtXoBfS5Ed9oDSq1Sfl/c3KvkbhQc1KD0pTI6YaTAGqJF+NVfJZMHvkJKp6OgRx+ZZIBEiS74KZ2l5XMSrlfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=luT5wC9r; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-69a0536b23aso114074297b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724800305; x=1725405105; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GW/USJCjupc34zRwCQ9bHi7JmQHKfEiUl9nNlR9x2Hk=;
        b=luT5wC9rusx55XedaPAqa6mzDF7BZkeOjKEdIuYEyh7Hl+XCek1cBvOp0PZxyrUFFV
         X7orzv/4LbKeiUkg5qiT7AEQc//+XRIUA3oP4SOFi1qcZkWeCzj+NRsBeTY0Duy9FXz5
         TrdNIS/gAoLkhnz9y3BjZJkN1DZnKKFlyEuaISFAE39uy5q1SdC+oFL9L0n98DjHe4F3
         g6LEc47Mm55gQdXoAs2U8TJ3uLLKTVAmPny5bHoIwpDhguDltDxQmnEAknyWR0mRrL2R
         VrAhupptcJZvuQVxwmdFaMWcgm9Om7UYN9fn1rmKNECJ089kfGQNGwFeHc67J2NAeApi
         +vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724800305; x=1725405105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GW/USJCjupc34zRwCQ9bHi7JmQHKfEiUl9nNlR9x2Hk=;
        b=ayEQvKXz2DsBEq8gOUpEbyoywoJRf0G2WbBGNl8MDHly9MzDH2b5dgNDy1S1aYPW4a
         zWuSL+57ki9C0ciYTJ601yZqC3+ifB8rRg2BwHpgqsHsiAKxbcuJ0uzkANiL8Ropjmn0
         2XRMx1PdzxqUul/bfoFvA4tmLqFd1vRzPgB2wlgDFoT29YNhr++VCqbhyfYrtscK05SW
         ArROkYK7kdA+xQ5su8z1z6U4GIxIBO5z0GmK6wIAZJZpZWjrxECaiMJ+j76/EOjyOAO0
         oLthoZPXaptrUVC8DEtGxwV0Fndnk12DDWJbMaa1vkfBj/ZyQPajBwqb9sIYW1ZOhbSs
         lYhw==
X-Forwarded-Encrypted: i=1; AJvYcCWX1q9IcMJ+1692rPyt7iknyFZICxUWD/qkwEBZzRmZvYmCcllGunnD/6d+OBbZ6y8uxRL/OsONzwUL9KM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8FwItpFG45Mg52YfZ1NELQuVIf31Z6B03QnaajTcj5TmUC+v5
	pk8Cq4ccRoIPJ4APVcuLQMYBqrJqNmeyCKSzEf/EXdiKKQD9j9dZD3A0Jsb7Ks02QDFqrQ6ER69
	Ax5c66K5M6Q==
X-Google-Smtp-Source: AGHT+IF1yp8ipyeMEvESYLh84If45Gfi4ptWiqS2P4CUd5/mGA60SGsDPudut6D5G0yZlYICuZUQrkeSqUZvzQ==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a05:690c:46c3:b0:69a:536:afd3 with SMTP
 id 00721157ae682-6d172052874mr2467b3.5.1724800304855; Tue, 27 Aug 2024
 16:11:44 -0700 (PDT)
Date: Tue, 27 Aug 2024 23:07:41 +0000
In-Reply-To: <20240827230753.2073580-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240827230753.2073580-1-kinseyho@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827230753.2073580-5-kinseyho@google.com>
Subject: [PATCH mm-unstable v3 4/5] mm: restart if multiple traversals raced
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, if multiple reclaimers raced on the same position, the
reclaimers which detect the race will still reclaim from the same memcg.
Instead, the reclaimers which detect the race should move on to the next
memcg in the hierarchy.

So, in the case where multiple traversals race, jump back to the start
of the mem_cgroup_iter() function to find the next memcg in the
hierarchy to reclaim from.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 include/linux/memcontrol.h |  4 ++--
 mm/memcontrol.c            | 22 ++++++++++++++--------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fe05fdb92779..2ef94c74847d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -57,7 +57,7 @@ enum memcg_memory_event {
 
 struct mem_cgroup_reclaim_cookie {
 	pg_data_t *pgdat;
-	unsigned int generation;
+	int generation;
 };
 
 #ifdef CONFIG_MEMCG
@@ -78,7 +78,7 @@ struct lruvec_stats;
 struct mem_cgroup_reclaim_iter {
 	struct mem_cgroup *position;
 	/* scan generation, increased every round-trip */
-	unsigned int generation;
+	atomic_t generation;
 };
 
 /*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 51b194a4c375..33bd379c738b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -986,7 +986,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 				   struct mem_cgroup_reclaim_cookie *reclaim)
 {
 	struct mem_cgroup_reclaim_iter *iter;
-	struct cgroup_subsys_state *css = NULL;
+	struct cgroup_subsys_state *css;
 	struct mem_cgroup *memcg = NULL;
 	struct mem_cgroup *pos = NULL;
 
@@ -999,18 +999,20 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 	rcu_read_lock();
 restart:
 	if (reclaim) {
+		int gen;
 		struct mem_cgroup_per_node *mz;
 
 		mz = root->nodeinfo[reclaim->pgdat->node_id];
 		iter = &mz->iter;
+		gen = atomic_read(&iter->generation);
 
 		/*
 		 * On start, join the current reclaim iteration cycle.
 		 * Exit when a concurrent walker completes it.
 		 */
 		if (!prev)
-			reclaim->generation = iter->generation;
-		else if (reclaim->generation != iter->generation)
+			reclaim->generation = gen;
+		else if (reclaim->generation != gen)
 			goto out_unlock;
 
 		pos = READ_ONCE(iter->position);
@@ -1018,8 +1020,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		pos = prev;
 	}
 
-	if (pos)
-		css = &pos->css;
+	css = pos ? &pos->css : NULL;
 
 	for (;;) {
 		css = css_next_descendant_pre(css, &root->css);
@@ -1033,21 +1034,26 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		 * and kicking, and don't take an extra reference.
 		 */
 		if (css == &root->css || css_tryget(css)) {
-			memcg = mem_cgroup_from_css(css);
 			break;
 		}
 	}
 
+	memcg = mem_cgroup_from_css(css);
+
 	if (reclaim) {
 		/*
 		 * The position could have already been updated by a competing
 		 * thread, so check that the value hasn't changed since we read
 		 * it to avoid reclaiming from the same cgroup twice.
 		 */
-		(void)cmpxchg(&iter->position, pos, memcg);
+		if (cmpxchg(&iter->position, pos, memcg) != pos) {
+			if (css && css != &root->css)
+				css_put(css);
+			goto restart;
+		}
 
 		if (!memcg) {
-			iter->generation++;
+			atomic_inc(&iter->generation);
 
 			/*
 			 * Reclaimers share the hierarchy walk, and a
-- 
2.46.0.295.g3b9ea8a38a-goog


