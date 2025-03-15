Return-Path: <linux-kernel+bounces-562695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0776CA63119
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 18:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 815397AD609
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 17:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF9F206F01;
	Sat, 15 Mar 2025 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LHDQm3SA"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32D62066E3
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742061016; cv=none; b=IadPsUI855C6od77OhhlZScpAj4YKfibrj6NYD1pO7PHkTNVoLrTIvOl0zX/jCfvUI7tvcRjXXODNO9u4KBwwSdEm+xBpGDoHR7mUS9GyXFAlwjyQOLeUdhyChFWl0Crt8qvbKdZzQX/Yli7c5ShLpTZVcP/rIvRrsiA1vcsxMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742061016; c=relaxed/simple;
	bh=pX6LjMd9E3wFWwByfNIBXNtx/iaZ5LpUzpJ93/Soi6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Puw8o575U8x894dKnMpLQV9IPaD+R2eXofj70BTc01EIXAi+CkjEInIbAXAXgqrP2oO+MRubRwsKRmOzihJxTC8d0tTWWgaOQ4uSWWgB1CfNgWNOC6vBC3pFAZHdbyraUz2RVcFvv2mYhQKwsMcZMshldy5L4p/vukXO0rrwU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LHDQm3SA; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742061013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYGBaqcauUTYU40tZGtRDDBbg7pHPWXhJB6/pipNZSg=;
	b=LHDQm3SAQHbOdOc/lx7xNRctT2V94M44B935v1mp0JKaFZD4ihZxYWRfQk1mXWZlM0YnV8
	mUJPtgGxHSicxTjlkyDNWob2m9rowYzZQ0N2FbX6cTsr0uOiJu8tvTqevoPkB6VEYHtP9L
	MnOPP/rrbzJKtED4KZRq6GaquCbHc40=
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
Subject: [PATCH 9/9] memcg: manually inline replace_stock_objcg
Date: Sat, 15 Mar 2025 10:49:30 -0700
Message-ID: <20250315174930.1769599-10-shakeel.butt@linux.dev>
In-Reply-To: <20250315174930.1769599-1-shakeel.butt@linux.dev>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The replace_stock_objcg() is being called by only refill_obj_stock, so
manually inline it.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 553eb1d7250a..f6e3fc418866 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2742,17 +2742,6 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 	obj_cgroup_put(objcg);
 }
 
-/* Replace the stock objcg with objcg, return the old objcg */
-static void replace_stock_objcg(struct memcg_stock_pcp *stock,
-				struct obj_cgroup *objcg)
-{
-	drain_obj_stock(stock);
-	obj_cgroup_get(objcg);
-	stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
-			? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
-	WRITE_ONCE(stock->cached_objcg, objcg);
-}
-
 static void __account_obj_stock(struct obj_cgroup *objcg,
 				struct memcg_stock_pcp *stock, int nr,
 				struct pglist_data *pgdat, enum node_stat_item idx)
@@ -2913,7 +2902,12 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
-		replace_stock_objcg(stock, objcg);
+		drain_obj_stock(stock);
+		obj_cgroup_get(objcg);
+		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
+				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
+		WRITE_ONCE(stock->cached_objcg, objcg);
+
 		allow_uncharge = true;	/* Allow uncharge when objcg changes */
 	}
 	stock->nr_bytes += nr_bytes;
-- 
2.47.1


