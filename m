Return-Path: <linux-kernel+bounces-288232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A629537B0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC8AB240E8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B0B1B0123;
	Thu, 15 Aug 2024 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kx2KlLkN"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3615C1A4F0F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737279; cv=none; b=cRm7ecvtGjnc5UXF0+zhP3wWBgyzHnNR12Qs+5X6SqAAz6CjT9PkUPhaOJGhXqAyUQJhiL9rHrFT6oB+YGrWqOLB1jvEOVQsTIzeNUqSizjotJnbYfLOI+1EXD1V8Qa1j4zQQyLOl9YzfpqvQDEihfrxtOVwTRTa+nqQ7ReqoTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737279; c=relaxed/simple;
	bh=UEuDwq5fCqw0aYSvkVR5Xz7u6/KcgixJHCd2wEmzA4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uV8INvD+XjvGF/d0GryqKuhRcFng6R90B38cT6f8lD4iyMqpIer5FjbsOtAMNEzQwrHrDWJzznzZCxoDFqdHc06ApHMfHVneIZodkMLqrFnLQ5oKrS5sRz1zZ6BnpNyuFocrA9/SMeYEbu4uMYYGtQ+SBNv2PeerWBMX3JHVw8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kx2KlLkN; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723737275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DjpAiVrd2YJQXzgNMIISiRWFMgGrAObcvytxXAsoS+o=;
	b=Kx2KlLkNtiaJWRRx1Lpiwnl0vG51HtNZvOmfAwA7VxHKPaUsVKh74zukXNwa6JqfNawSrb
	Ai6f4bTwh+vYS7bZvva9tO+v/MbyrUBhtVtoR8lGaNnb5x/BIVKBRnPamna0xBLDdeHYq7
	NR3qdWieoaGRvtDMrqCvMlV6YN0AyZk=
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
	cgroups@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2] memcg: replace memcg ID idr with xarray
Date: Thu, 15 Aug 2024 08:54:02 -0700
Message-ID: <20240815155402.3630804-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

At the moment memcg IDs are managed through IDR which requires external
synchronization mechanisms and makes the allocation code a bit awkward.
Let's switch to xarray and make the code simpler.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

Changes since v1:
- Fix error path in mem_cgroup_alloc (Dan Carpenter)

 mm/memcontrol.c | 39 ++++++++++-----------------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index df84683a0e1c..e8e03a5e1e5e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3408,29 +3408,12 @@ static void memcg_wb_domain_size_changed(struct mem_cgroup *memcg)
  */
 
 #define MEM_CGROUP_ID_MAX	((1UL << MEM_CGROUP_ID_SHIFT) - 1)
-static DEFINE_IDR(mem_cgroup_idr);
-static DEFINE_SPINLOCK(memcg_idr_lock);
-
-static int mem_cgroup_alloc_id(void)
-{
-	int ret;
-
-	idr_preload(GFP_KERNEL);
-	spin_lock(&memcg_idr_lock);
-	ret = idr_alloc(&mem_cgroup_idr, NULL, 1, MEM_CGROUP_ID_MAX + 1,
-			GFP_NOWAIT);
-	spin_unlock(&memcg_idr_lock);
-	idr_preload_end();
-	return ret;
-}
+static DEFINE_XARRAY_ALLOC1(mem_cgroup_ids);
 
 static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
 {
 	if (memcg->id.id > 0) {
-		spin_lock(&memcg_idr_lock);
-		idr_remove(&mem_cgroup_idr, memcg->id.id);
-		spin_unlock(&memcg_idr_lock);
-
+		xa_erase(&mem_cgroup_ids, memcg->id.id);
 		memcg->id.id = 0;
 	}
 }
@@ -3465,7 +3448,7 @@ static inline void mem_cgroup_id_put(struct mem_cgroup *memcg)
 struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
-	return idr_find(&mem_cgroup_idr, id);
+	return xa_load(&mem_cgroup_ids, id);
 }
 
 #ifdef CONFIG_SHRINKER_DEBUG
@@ -3558,17 +3541,17 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	struct mem_cgroup *memcg;
 	int node, cpu;
 	int __maybe_unused i;
-	long error = -ENOMEM;
+	long error;
 
 	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL);
 	if (!memcg)
-		return ERR_PTR(error);
+		return ERR_PTR(-ENOMEM);
 
-	memcg->id.id = mem_cgroup_alloc_id();
-	if (memcg->id.id < 0) {
-		error = memcg->id.id;
+	error = xa_alloc(&mem_cgroup_ids, &memcg->id.id, NULL,
+			 XA_LIMIT(1, MEM_CGROUP_ID_MAX), GFP_KERNEL);
+	if (error)
 		goto fail;
-	}
+	error = -ENOMEM;
 
 	memcg->vmstats = kzalloc(sizeof(struct memcg_vmstats),
 				 GFP_KERNEL_ACCOUNT);
@@ -3709,9 +3692,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	 * publish it here at the end of onlining. This matches the
 	 * regular ID destruction during offlining.
 	 */
-	spin_lock(&memcg_idr_lock);
-	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
-	spin_unlock(&memcg_idr_lock);
+	xa_store(&mem_cgroup_ids, memcg->id.id, memcg, GFP_KERNEL);
 
 	return 0;
 offline_kmem:
-- 
2.43.5


