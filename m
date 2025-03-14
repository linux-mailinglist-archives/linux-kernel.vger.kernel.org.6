Return-Path: <linux-kernel+bounces-560752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF667A6090E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C783AD249
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BDA18A6D7;
	Fri, 14 Mar 2025 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A3ycuLnE"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E65D186E56
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932944; cv=none; b=Ntb8dTZvOvVja6LIdhwSMNBcbkgySAkosgcZAMu2O/sOaSdrOxHuA9cROF2+b+/Nug3ghY6cFRzMgDAKfxDqmRo9mOKowbMUjkJj+BAxjoqqU+Iw2y0eUvmRhRWzwBC4roJay3IOXKusRtcCQO5BSQoL9fQMaCUDeLARSwks/7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932944; c=relaxed/simple;
	bh=ivi2Ai5pbO72ygi8JeAdlS/MqXoqGjtJwT11DBtAaM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gL68zFgmxDTUWIAM1q1DVaLpooe3bTFiVFUUkFs3cFPfQsCRIEI9OVaQcLPt+Qp82tNlgt1iXge0mFJHpFBW5XOCW7La50dV2LZIAMsB/q+YSqCXvz4iaWbtH/b4rRSLdxRHaliFWuKHKqELE9TY1qXhq4vPup9AJZBZkHeQFdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A3ycuLnE; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741932941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lcDoiTd7xEiImi4APdwYNjABkW5nrlOItPgvjNpxcds=;
	b=A3ycuLnENDh5V07GWrH8Jxn+FR3OaxeVX1PN7A7UGAgmaark0HHfSnFiszqsZ4vp8xDkjs
	fPjVhxtQ7rRtNBIuopLUKdw0S2PB/6Ooq+Es0ODBtRgCobG9H0wTXDPAQOxpVL/z4Rv7uc
	1aWOQV+aKTZuhIGf3oAQCTRqjvv0WUM=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [RFC PATCH 05/10] memcg: no refilling stock from obj_cgroup_release
Date: Thu, 13 Mar 2025 23:15:06 -0700
Message-ID: <20250314061511.1308152-6-shakeel.butt@linux.dev>
In-Reply-To: <20250314061511.1308152-1-shakeel.butt@linux.dev>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

obj_cgroup_release is called when all the references to the objcg has
been released i.e. no more memory objects are pointing to it. Most
probably objcg->memcg will be pointing to some ancestor memcg and at the
moment, in obj_cgroup_release, the kernel call
obj_cgroup_uncharge_pages() to uncharge last remaining memory.

However obj_cgroup_uncharge_pages() refills the local stock. There is
no need to refill the local stock with some ancestor memcg and flush the
local stock. In addition this removes the requirement to only call
obj_cgroup_put() outside of local_lock.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7054b0ebd207..83db180455a1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -129,8 +129,7 @@ bool mem_cgroup_kmem_disabled(void)
 	return cgroup_memory_nokmem;
 }
 
-static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
-				      unsigned int nr_pages);
+static void memcg_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages);
 
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
@@ -163,8 +162,16 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
 	nr_pages = nr_bytes >> PAGE_SHIFT;
 
-	if (nr_pages)
-		obj_cgroup_uncharge_pages(objcg, nr_pages);
+	if (nr_pages) {
+		struct mem_cgroup *memcg;
+
+		memcg = get_mem_cgroup_from_objcg(objcg);
+		mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
+		memcg1_account_kmem(memcg, -nr_pages);
+		if (!mem_cgroup_is_root(memcg))
+			memcg_uncharge(memcg, nr_pages);
+		css_put(&memcg->css);
+	}
 
 	spin_lock_irqsave(&objcg_lock, flags);
 	list_del(&objcg->list);
-- 
2.47.1


