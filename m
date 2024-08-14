Return-Path: <linux-kernel+bounces-287233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A40952524
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E168F283D53
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9914A093;
	Wed, 14 Aug 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wa4X42Rw"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86DA1494D7
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672834; cv=none; b=qqPfg4K5Tsbq7sWHdWAZC55hvrvzDiJQM724Zd3v+0sXQQW4ofp3Zdl65DewZgW4enPmF3nwxRvouOlUPB9FPdKcu+r1AKbg2Z4hSJ3Y+DIGiphSvpG2DYUKuu8TtlKEZXyywbrBhSqpaoW9RaapkKeVfCFlylA34ma9fOqmtQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672834; c=relaxed/simple;
	bh=7wWPttm3aZ9icfz+5PbT8iv5ss9RlWE+/HX28OrIEEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSwwSGizPgZLrpENSpY9XSCgfY20eWqTwGjtX9AM9J44eyHaulH3kc7FTnV1Exo+zfPeAWDECPI4v18fy6we4X3V3La/79ZFzvNycjFTFkbiKT+k80Mi6KErntpe080poxvH6aSeval6/xGU6J83QnYyvgTSGu4M04zKpeEJ2sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wa4X42Rw; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723672830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CoKWYd7P/AKTgOxnO9z4vGUx2mh73AJSsiyA7cwqTAU=;
	b=wa4X42Rwt2kklgTFcAFXO/x/P5VKRQaJFoHFUwFYe4F6hsjQgaSSwKJXTPjuw7wjLUxeYX
	z8WHwVh0omw5zZdhINdF8S5R0v9ooyocSSy2i3Z9o5cVebyScNQVLRvrhbegTOVl3Vg5zK
	G69KtcTWY5BZ2dUv/cevweIOqDFOjss=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH v2 2/4] memcg: initiate deprecation of v1 soft limit
Date: Wed, 14 Aug 2024 15:00:19 -0700
Message-ID: <20240814220021.3208384-3-shakeel.butt@linux.dev>
In-Reply-To: <20240814220021.3208384-1-shakeel.butt@linux.dev>
References: <20240814220021.3208384-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Memcg v1 provides soft limit functionality for the best effort memory
sharing between multiple workloads on a system. It is usually triggered
through kswapd and at the moment does not reclaim kernel memory.

Memcg v2 provide more straightforward best effort (memory.low) and hard
protection (memory.min) functionalities. Let's initiate the deprecation
of soft limit from v1 and gather if v2 needs something more to move the
existing v1 users to v2 regarding soft limit.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
Changes since v1:
- N/A

 Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++--
 mm/memcontrol-v1.c                             | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 0114d758beab..6831c6c16e3f 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -78,6 +78,8 @@ Brief summary of control files.
  memory.memsw.max_usage_in_bytes     show max memory+Swap usage recorded
  memory.soft_limit_in_bytes	     set/show soft limit of memory usage
 				     This knob is not available on CONFIG_PREEMPT_RT systems.
+                                     This knob is deprecated and shouldn't be
+                                     used.
  memory.stat			     show various statistics
  memory.use_hierarchy		     set/show hierarchical account enabled
                                      This knob is deprecated and shouldn't be
@@ -701,8 +703,10 @@ For compatibility reasons writing 1 to memory.use_hierarchy will always pass::
 
 	# echo 1 > memory.use_hierarchy
 
-7. Soft limits
-==============
+7. Soft limits (DEPRECATED)
+===========================
+
+THIS IS DEPRECATED!
 
 Soft limits allow for greater sharing of memory. The idea behind soft limits
 is to allow control groups to use as much of the memory as needed, provided
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index b8e2ee454eaa..e0bb54e42011 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -2458,6 +2458,9 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			ret = -EOPNOTSUPP;
 		} else {
+			pr_warn_once("soft_limit_in_bytes is deprecated and will be removed. "
+				     "Please report your usecase to linux-mm@kvack.org if you "
+				     "depend on this functionality.\n");
 			WRITE_ONCE(memcg->soft_limit, nr_pages);
 			ret = 0;
 		}
-- 
2.43.5


