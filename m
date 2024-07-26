Return-Path: <linux-kernel+bounces-263783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17A493DA75
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8707E1F23E83
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A0315B0F1;
	Fri, 26 Jul 2024 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqgrHSmz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E5C15AADB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031064; cv=none; b=AxYuejOrHaA6ekpq1Lf9hw44WXxfVhfU7ruCxhm8kV3JeFSvHg8DdSBovINazDxNXDudzxIQAXHv/HxhJuxh2/JGGmV6aCG/mNfbJh0G2CgxV9KMxdqJcr+ThVzQz5dAK2zw28tcZrNqIsKIKYYO+PHRgvhWDSTAQapHZ26PsgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031064; c=relaxed/simple;
	bh=gPMXvX+GlymTegeJ33I/1BOjjt7hvEufmzbmhRPnpxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSBRhsU0feMzV4N7zkAwD/GBlWgcs5dFUJxywS2PD9VXUwuCtF59DpTIacgNcNWXpktplDQC+t6JQwcGc8S4qoucEXXvoKlDQFFCTKt79c4UVLaxIL2CACb6FwBITCd4O6ONzgGXCla5bSTQmSUa/6ewTJ/6WRg46RDgoCnTtyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqgrHSmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B33C32782;
	Fri, 26 Jul 2024 21:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722031064;
	bh=gPMXvX+GlymTegeJ33I/1BOjjt7hvEufmzbmhRPnpxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iqgrHSmz8YA7EVyJFrBUszMUuoULJREzG0WmIVQaPwZgshXH9zPEIRF+Y8MrjnWkM
	 Zt3wRLuZMuDHLaUl7mHZVZJJebIAnhF3ewfY12xrp+pMS3rOrGHuwiCIrXgDtdgbpo
	 fqrvDWzHarZ5T4rMmD8B0dQWcCrjj7zT4ofXxfLUT1/BcPwCJnP2kMJVcshvr4xbwW
	 xdMDv2GNTaRv6yTwhplpRpErKEak9nfL5A3iL7FO8eM/NlgFldnD6GIsJ4MQTFVPMn
	 svskNbqqQ3C0B6v8p/pu/8VrsrkvDTA2qxa0iiKGjB9B0mJJXmZ3Z1wJndxKQW2vdE
	 GB5zT8LjtgUBg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 15/20] mm: Make kswapd use kthread's preferred affinity
Date: Fri, 26 Jul 2024 23:56:51 +0200
Message-ID: <20240726215701.19459-16-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726215701.19459-1-frederic@kernel.org>
References: <20240726215701.19459-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that kthreads have an infrastructure to handle preferred affinity
against CPU hotplug and housekeeping cpumask, convert kswapd to use
it instead of handling halfway all the constraints by itself.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 mm/vmscan.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2e34de9cd0d4..94359a893b4f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7116,10 +7116,6 @@ static int kswapd(void *p)
 	unsigned int highest_zoneidx = MAX_NR_ZONES - 1;
 	pg_data_t *pgdat = (pg_data_t *)p;
 	struct task_struct *tsk = current;
-	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
-
-	if (!cpumask_empty(cpumask))
-		set_cpus_allowed_ptr(tsk, cpumask);
 
 	/*
 	 * Tell the memory management that we're a "memory allocator",
@@ -7288,7 +7284,7 @@ void __meminit kswapd_run(int nid)
 
 	pgdat_kswapd_lock(pgdat);
 	if (!pgdat->kswapd) {
-		pgdat->kswapd = kthread_run(kswapd, pgdat, "kswapd%d", nid);
+		pgdat->kswapd = kthread_create(kswapd, pgdat, "kswapd%d", nid);
 		if (IS_ERR(pgdat->kswapd)) {
 			/* failure at boot is fatal */
 			pr_err("Failed to start kswapd on node %d，ret=%ld\n",
@@ -7296,6 +7292,8 @@ void __meminit kswapd_run(int nid)
 			BUG_ON(system_state < SYSTEM_RUNNING);
 			pgdat->kswapd = NULL;
 		}
+		kthread_affine_preferred(pgdat->kswapd, cpumask_of_node(pgdat->node_id));
+		wake_up_process(pgdat->kswapd);
 	}
 	pgdat_kswapd_unlock(pgdat);
 }
-- 
2.45.2


