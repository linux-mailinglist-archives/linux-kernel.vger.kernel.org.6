Return-Path: <linux-kernel+bounces-278212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B65394ADF2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 140FAB25BA2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB5913AA4C;
	Wed,  7 Aug 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4yCzTMD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013E13A896
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046565; cv=none; b=hqBw9B4OydrEQAxvKAlqqp20Nh8+olke3Wy529s6tZztJIIEQabji0tCEXJ3yQZK7Y2ALG2HUIOCL4F6WABfzfLlS9R6/kvo1yPG+1xnLdjuF3IDkKKZWZBy5TS8Vao8Q8WtnmDIFEgixIn9razvqd+UBL6231WU2aW4MBVeuyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046565; c=relaxed/simple;
	bh=RrD86gQdUXwYV0YUjUZqjd7jwjhQYkYNATDY7ibM1KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTGlwxD10VK86JnvWddNGZ1/Bf+yt7V3ZrF5YCTda+aCcDMFmN8HzYHizISIP9VdWaJ4lOjF4yBUiLtEbXm2dmUmYXC0cAPGjNDCPFOz87QcxLL3Zo23B2MyXhX3TCBc5qVVjKjq4TKPesQ6Z3ofszPaDnr0bgJdRTWRrZO5FcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4yCzTMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51394C4AF0F;
	Wed,  7 Aug 2024 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723046564;
	bh=RrD86gQdUXwYV0YUjUZqjd7jwjhQYkYNATDY7ibM1KY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4yCzTMDMtHBLSyrrfHZksAjtaLKJ9oTDpNJGEoj8q7bqvht8Xl9QTOW1FM60J0yG
	 mr89WmGeWi1Wxyd9SkbZh1kVR6fwlG51LF1IPUWNcPDVkHe64XXoC65aDoOET2LC2E
	 5akWNaNCvve4jJeJopA8h6ZBPqyZSdIZi5DSvpVgx/jZebbR96dIPuu7wRx140EI0R
	 9wDw+NO9wJhmPLxeZy6O9M8L0AJWkLwblrs2pw/srgVKKwAyhaZST+PeB4kUSn2qtN
	 ZdMZIJWOWLkCxK/OW/tblLtEvOGwudAspHYxlj13vVPYcgd/Yk23WbBppnViQN9Fqz
	 O3RYbOb4ajxyw==
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
Date: Wed,  7 Aug 2024 18:02:08 +0200
Message-ID: <20240807160228.26206-3-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807160228.26206-1-frederic@kernel.org>
References: <20240807160228.26206-1-frederic@kernel.org>
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
2.45.2


