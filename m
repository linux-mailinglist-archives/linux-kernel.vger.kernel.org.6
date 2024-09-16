Return-Path: <linux-kernel+bounces-331168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E1997A954
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10411F2910A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE88165EE9;
	Mon, 16 Sep 2024 22:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUBFuQWt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5AB14BFBF
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726526980; cv=none; b=FxJ5h+RhNAap3/NFbE1sFO4cLJf9inFZCVzjKNpEyeofnFt78+TdCGeMixMHjwlVwGB3fECKvAUjsw0fL22pMQHEUpTDByFZDr3JzHDHiw3EMQod4ktjtWi+aWyZsjpQv6x0ntYfiLUXXfOoDi3OHwHSYRPjjvzOd1IqoYNwjGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726526980; c=relaxed/simple;
	bh=IoZPaCv863UIRZr027aVdH0TUkaWU86goti0yjIS6gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAxuM+u7somQ4lX5+5r+/6QQl/xeLoEGH8TEZNNo4kyqVPn71Le6SIhTj1v3rd03onDawQ7zEoqarn+QLCHZVOQV/AEmKnzstgQ1k6YukL8WID5oW6FLtyDwtAD0uHRNkVAJZLYG6y+9bnxXtX0wpQXTNRJKiQqBt6ICUuS4DSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUBFuQWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C780C4AF0B;
	Mon, 16 Sep 2024 22:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726526979;
	bh=IoZPaCv863UIRZr027aVdH0TUkaWU86goti0yjIS6gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DUBFuQWtRy2rJuwxloWCe2KUZI/Rn9O5vmvS88Tougo3Z3sRMOu76gUEo1PNT4J7k
	 3C0nKiJ1zzshPdh5rtJjS10ASrIKTAB5xBx2BC+3lmGotRs/HIvciK0vfTOcfU4qNh
	 LL19liBIdS3JQ8fjj21D1rYOqevGJTSVo9Lw5f8NGDs5r4VhkkSKYdxkfPeXNXLRLM
	 q7kbJUfV5ScF8jz1Kz99wQwg+cnWuvMta3MfgCYW62PHJf0PMAaYQMuZXPTSqfQ+Fr
	 lSF9XgSx2XhShE4abLEfXEuVinpsJLPFfgeORcI0oEpGUjybASuHWq8/Ab8vMIHknf
	 gq2y89QJzJAmw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 02/19] x86/resctrl: Use kthread_run_on_cpu()
Date: Tue, 17 Sep 2024 00:49:06 +0200
Message-ID: <20240916224925.20540-3-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916224925.20540-1-frederic@kernel.org>
References: <20240916224925.20540-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the proper API instead of open coding it.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 28 +++++++----------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index e69489d48625..ae1f0c28eee6 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -1205,20 +1205,14 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
 	plr->cpu = cpu;
 
 	if (sel == 1)
-		thread = kthread_create_on_node(measure_cycles_lat_fn, plr,
-						cpu_to_node(cpu),
-						"pseudo_lock_measure/%u",
-						cpu);
+		thread = kthread_run_on_cpu(measure_cycles_lat_fn, plr,
+					    cpu, "pseudo_lock_measure/%u");
 	else if (sel == 2)
-		thread = kthread_create_on_node(measure_l2_residency, plr,
-						cpu_to_node(cpu),
-						"pseudo_lock_measure/%u",
-						cpu);
+		thread = kthread_run_on_cpu(measure_l2_residency, plr,
+					    cpu, "pseudo_lock_measure/%u");
 	else if (sel == 3)
-		thread = kthread_create_on_node(measure_l3_residency, plr,
-						cpu_to_node(cpu),
-						"pseudo_lock_measure/%u",
-						cpu);
+		thread = kthread_run_on_cpu(measure_l3_residency, plr,
+					    cpu, "pseudo_lock_measure/%u");
 	else
 		goto out;
 
@@ -1226,8 +1220,6 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
 		ret = PTR_ERR(thread);
 		goto out;
 	}
-	kthread_bind(thread, cpu);
-	wake_up_process(thread);
 
 	ret = wait_event_interruptible(plr->lock_thread_wq,
 				       plr->thread_done == 1);
@@ -1315,18 +1307,14 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 
 	plr->thread_done = 0;
 
-	thread = kthread_create_on_node(pseudo_lock_fn, rdtgrp,
-					cpu_to_node(plr->cpu),
-					"pseudo_lock/%u", plr->cpu);
+	thread = kthread_run_on_cpu(pseudo_lock_fn, rdtgrp,
+				    plr->cpu, "pseudo_lock/%u");
 	if (IS_ERR(thread)) {
 		ret = PTR_ERR(thread);
 		rdt_last_cmd_printf("Locking thread returned error %d\n", ret);
 		goto out_cstates;
 	}
 
-	kthread_bind(thread, plr->cpu);
-	wake_up_process(thread);
-
 	ret = wait_event_interruptible(plr->lock_thread_wq,
 				       plr->thread_done == 1);
 	if (ret < 0) {
-- 
2.46.0


