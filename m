Return-Path: <linux-kernel+bounces-341098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ED5987B50
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488AD1F22666
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1752B1B1436;
	Thu, 26 Sep 2024 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPdT/czz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D571B07A4
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 22:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727390993; cv=none; b=EpWm+8+BNgi7LOqFdUdtbixlE4ckjmYWxb2eadEicKJLBfKr0/ikWPAIT2JwZ9iu5uYE5N5sIZGktq/B/ZhD7hsoIGARqOCNm2VWIHOSKrcm/zb/wfMLouLw0wigW2MGObPBL7BLtG3Hy5SEyev7I5Z0dCok341zIxn1K+NCKmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727390993; c=relaxed/simple;
	bh=GGwHDTPCelnTuLQKmOHE+XEiEGRzn3nDzNLPlrg5wLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TF3XKiVuj7CKtd1Z89L6c/FJECApN/GmCz5RcdTqF50pxXrACXLMtV2OFLhulcrlsEPS8eBPUvsygpsorZ1cT3Rozi1mfkYatLi1f56cFPAGZ0OR000mrn4Yy79MQKGcdvPuejEtStoAEvpQw9WO6YOkev+N3aTUuxY3UyKEiis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPdT/czz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85329C4CECE;
	Thu, 26 Sep 2024 22:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727390993;
	bh=GGwHDTPCelnTuLQKmOHE+XEiEGRzn3nDzNLPlrg5wLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qPdT/czzAUkVt9taXAsYs8HYqiPAzFsD1PahFMGeLLa7p2XkOjqAGBmtuWIxHHZzI
	 L73JueO4kixmDYeWu4a8O6Hn0pH8EOVcPCTshEGMwt/hCvhT5sU0By3wHdlwzQxZeg
	 iJQwSFGkPH8DB3lu63k2EugRuJGZ1VPzYDgoxy+UIi4yJzBy0vF7kxHNXBsdPjwhgf
	 kgXfavf0yn90bg42dxvHuz0QrUskQDnr4er73zhZEdFiHbE93hnfsomY8jIU0clpCq
	 dnEuS0e4bCA/Mg/ntuju71is5DUonzaMun23oaFLmCDFNQiEx7M05CYRWIWd2qVizV
	 vL26k62znYIuQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 15/20] mm: Create/affine kswapd to its preferred node
Date: Fri, 27 Sep 2024 00:49:03 +0200
Message-ID: <20240926224910.11106-16-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926224910.11106-1-frederic@kernel.org>
References: <20240926224910.11106-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

kswapd is dedicated to a specific node. As such it wants to be
preferrably affine to it, memory and CPUs-wise.

Use the proper kthread API to achieve that. As a bonus it takes care of
CPU-hotplug events and CPU-isolation on its behalf.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 mm/vmscan.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 749cdc110c74..2f2b75536d9c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7162,10 +7162,6 @@ static int kswapd(void *p)
 	unsigned int highest_zoneidx = MAX_NR_ZONES - 1;
 	pg_data_t *pgdat = (pg_data_t *)p;
 	struct task_struct *tsk = current;
-	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
-
-	if (!cpumask_empty(cpumask))
-		set_cpus_allowed_ptr(tsk, cpumask);
 
 	/*
 	 * Tell the memory management that we're a "memory allocator",
@@ -7334,13 +7330,15 @@ void __meminit kswapd_run(int nid)
 
 	pgdat_kswapd_lock(pgdat);
 	if (!pgdat->kswapd) {
-		pgdat->kswapd = kthread_run(kswapd, pgdat, "kswapd%d", nid);
+		pgdat->kswapd = kthread_create_on_node(kswapd, pgdat, nid, "kswapd%d", nid);
 		if (IS_ERR(pgdat->kswapd)) {
 			/* failure at boot is fatal */
 			pr_err("Failed to start kswapd on node %d，ret=%ld\n",
 				   nid, PTR_ERR(pgdat->kswapd));
 			BUG_ON(system_state < SYSTEM_RUNNING);
 			pgdat->kswapd = NULL;
+		} else {
+			wake_up_process(pgdat->kswapd);
 		}
 	}
 	pgdat_kswapd_unlock(pgdat);
-- 
2.46.0


