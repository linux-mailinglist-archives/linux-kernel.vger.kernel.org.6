Return-Path: <linux-kernel+bounces-273244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F175094664D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 01:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFFA1F222B2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA52013BC2F;
	Fri,  2 Aug 2024 23:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hNkoehj8"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB4A13AA47
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 23:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722643120; cv=none; b=POnwI9SKrESFwkq3WlL0OxjzSNXc2n2sJ0D7mWLV+9LUhc3zZv8N0fTZ1nckIiC2rboKd2+Wp92YFk+uK9UG1RuWtVGdJqpz61d6l76Ou4A1ZRBETOphl+sYkyKStv1hheiqa4sbfEe8Z8FY4WkcuyHaS4CNXkuwodf3dvLDC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722643120; c=relaxed/simple;
	bh=ek/Twkf/0KzDJOxl6HALvLL1GFA3f53vbYPKmu0cq8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tf+41imxkCOi40EHi7lBznQQvgcgSvMeUrbkm8jyzUvcZJpMbuC2+MTiS8ulLC9BsMTLL+edhHdeaF8uQLbtQrOdmyhW9uwAaJNcBNeMfaxeUmmy7LbKbeDrOoqY1JOnFM4QrgfgDfUKjOPpbAU1Dxe6+wk/9eNMeJDsrpn1/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hNkoehj8; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722643114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vIQpQxNg2MyXYsuSEiANpsXDOnYEMzwRDvdV46avMd4=;
	b=hNkoehj8SQFvqoNGAU3xYIlPtkmBu3wq4mO2bfPvELiR4pHFgu49d0eJr1gYnD62kxfOME
	JOraAP21UfmZ9Z63EmTk1QSXiRXxr/LbPDu8MQUNCQUdUqRzYz0a3HHUOu/gidzcR4imVv
	sTMkN1wPpVjOPFiooS0YmHx4jFKLSDI=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH] memcg: protect concurrent access to mem_cgroup_idr
Date: Fri,  2 Aug 2024 16:58:22 -0700
Message-ID: <20240802235822.1830976-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The commit 73f576c04b94 ("mm: memcontrol: fix cgroup creation failure
after many small jobs") decoupled the memcg IDs from the CSS ID space to
fix the cgroup creation failures. It introduced IDR to maintain the
memcg ID space. The IDR depends on external synchronization mechanisms
for modifications. For the mem_cgroup_idr, the idr_alloc() and
idr_replace() happen within css callback and thus are protected through
cgroup_mutex from concurrent modifications. However idr_remove() for
mem_cgroup_idr was not protected against concurrency and can be run
concurrently for different memcgs when they hit their refcnt to zero.
Fix that.

We have been seeing list_lru based kernel crashes at a low frequency in
our fleet for a long time. These crashes were in different part of
list_lru code including list_lru_add(), list_lru_del() and reparenting
code. Upon further inspection, it looked like for a given object (dentry
and inode), the super_block's list_lru didn't have list_lru_one for the
memcg of that object. The initial suspicions were either the object is
not allocated through kmem_cache_alloc_lru() or somehow
memcg_list_lru_alloc() failed to allocate list_lru_one() for a memcg but
returned success. No evidence were found for these cases.

Looking more deeper, we started seeing situations where valid memcg's id
is not present in mem_cgroup_idr and in some cases multiple valid memcgs
have same id and mem_cgroup_idr is pointing to one of them. So, the most
reasonable explanation is that these situations can happen due to race
between multiple idr_remove() calls or race between
idr_alloc()/idr_replace() and idr_remove(). These races are causing
multiple memcgs to acquire the same ID and then offlining of one of them
would cleanup list_lrus on the system for all of them. Later access from
other memcgs to the list_lru cause crashes due to missing list_lru_one.

Fixes: 73f576c04b94 ("mm: memcontrol: fix cgroup creation failure after many small jobs")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b889a7fbf382..8971d3473a7b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3364,11 +3364,28 @@ static void memcg_wb_domain_size_changed(struct mem_cgroup *memcg)
 
 #define MEM_CGROUP_ID_MAX	((1UL << MEM_CGROUP_ID_SHIFT) - 1)
 static DEFINE_IDR(mem_cgroup_idr);
+static DEFINE_SPINLOCK(memcg_idr_lock);
+
+static int mem_cgroup_alloc_id(void)
+{
+	int ret;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&memcg_idr_lock);
+	ret = idr_alloc(&mem_cgroup_idr, NULL, 1, MEM_CGROUP_ID_MAX + 1,
+			GFP_NOWAIT);
+	spin_unlock(&memcg_idr_lock);
+	idr_preload_end();
+	return ret;
+}
 
 static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
 {
 	if (memcg->id.id > 0) {
+		spin_lock(&memcg_idr_lock);
 		idr_remove(&mem_cgroup_idr, memcg->id.id);
+		spin_unlock(&memcg_idr_lock);
+
 		memcg->id.id = 0;
 	}
 }
@@ -3502,8 +3519,7 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	if (!memcg)
 		return ERR_PTR(error);
 
-	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
-				 1, MEM_CGROUP_ID_MAX + 1, GFP_KERNEL);
+	memcg->id.id = mem_cgroup_alloc_id();
 	if (memcg->id.id < 0) {
 		error = memcg->id.id;
 		goto fail;
@@ -3648,7 +3664,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	 * publish it here at the end of onlining. This matches the
 	 * regular ID destruction during offlining.
 	 */
+	spin_lock(&memcg_idr_lock);
 	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
+	spin_unlock(&memcg_idr_lock);
 
 	return 0;
 offline_kmem:
-- 
2.43.5


