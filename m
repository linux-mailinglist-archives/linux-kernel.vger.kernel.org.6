Return-Path: <linux-kernel+bounces-406033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304B39C5A43
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC7B1F25F71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768461FC7F2;
	Tue, 12 Nov 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1O9NV5N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FCE1FCF73
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421419; cv=none; b=c73t3APl8QOwrjcsyWiZa9nd3Xtn17bnDPOfykBmjHh2jimZ4HGJqR3wxJt07Gc9Rmb29ienv+YbuQ3WRz7gpS9Be3u5Zrv3Sd895OMvCZIDL83PiSAT+aLew2r1f1h+664cJDB2lGsYFZiWZ3Kj+K2xNc8kb/907wSZoZfiF98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421419; c=relaxed/simple;
	bh=KNvMrDCkq+FkVo1LT5dQKXPLt7u3YoAjScUJDJ7bxzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chzmIfQSuyvb1rfxj6Q/bQb71uvA7RUB/AnFdcK0Tl8jhfHgojTzmZ8m/iT8P0+AtszYBUMjmSpZUxK2Tw8rB8gRdjO+7HqETT/Jbr+gBw/DDvGTDiFCXnfwO1cTADA4QPlsFpiSfjJQRizQss8pLwewlzgbtDKkonAZBt6X0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1O9NV5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9259C4CECD;
	Tue, 12 Nov 2024 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731421419;
	bh=KNvMrDCkq+FkVo1LT5dQKXPLt7u3YoAjScUJDJ7bxzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q1O9NV5NBLcP9bidRunvKKRNekVsicJ56mPgrMO9TvKroDqkxtfTAUxMn23f5UqVl
	 ZHIxRDlI7gIoJmY7caOSxYA18hbZKOC9TuKHNcfO52HrJMEK5SE3m+kL2f4ybC+KiT
	 SlAu7sXTxUGFvRZaSTJXCZoNoMwT7Elw6A18DfiuHa+xaWDQv+EyX7jIEmOisY0vNU
	 cUUDYMB0q26vkcQQsF/R4jOhcL2hbY5HWrBMf4SspagRSkOIurR90wuSrT3/QVDrzM
	 VEOwjgK1adSLPK4xsiD7fgruumY9q7dn6fGogIV+O5puHjTu7iY2YMRDB4J8EB7PsD
	 0MDaJpt6OxGKg==
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
Subject: [PATCH 16/21] mm: Create/affine kswapd to its preferred node
Date: Tue, 12 Nov 2024 15:22:40 +0100
Message-ID: <20241112142248.20503-17-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112142248.20503-1-frederic@kernel.org>
References: <20241112142248.20503-1-frederic@kernel.org>
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
index 28ba2b06fc7d..5d7686bef51c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7168,10 +7168,6 @@ static int kswapd(void *p)
 	unsigned int highest_zoneidx = MAX_NR_ZONES - 1;
 	pg_data_t *pgdat = (pg_data_t *)p;
 	struct task_struct *tsk = current;
-	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
-
-	if (!cpumask_empty(cpumask))
-		set_cpus_allowed_ptr(tsk, cpumask);
 
 	/*
 	 * Tell the memory management that we're a "memory allocator",
@@ -7340,13 +7336,15 @@ void __meminit kswapd_run(int nid)
 
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


