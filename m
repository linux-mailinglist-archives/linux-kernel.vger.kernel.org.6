Return-Path: <linux-kernel+bounces-406018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F67F9C5A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E411F226EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE4B1FC7F2;
	Tue, 12 Nov 2024 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXXbYsQp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA551FEFAB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421379; cv=none; b=duYf7TeU7Cg5YhuuCc2jz5XHWqLy8jbwCPEm53CFRzmTK+ZYJ/tQ9asevPj7NI0h4g/wWu6J801bExhkOpv/exRF3AaZK7X6SdbsBceQrpoKR4JFhq2t626G0dFaNcrtdPqCz0BWD6+VnFYdPfPkCn3IgFx0+bYSIq3kWuBc2pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421379; c=relaxed/simple;
	bh=czA8yNM5/VtFC7HnPS8smHZh74i23s5lUxRm0+IFziw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pn6X3uhn3BwVeqC8angBkbD6YpgmP+rrx388/HAXDaDruAMWGQEGHrFzmavkTsznCHRo6GtrFKNJmJsBakt9Cv4aFUFP/gkj8CVWtN/5FKYip2CDdfjo4M20hccVE70SYU9JG4zq12xCqz2d3khP5chQmB7ozsZJor/BOS5ovZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXXbYsQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AF6C4CECD;
	Tue, 12 Nov 2024 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731421379;
	bh=czA8yNM5/VtFC7HnPS8smHZh74i23s5lUxRm0+IFziw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XXXbYsQpbRWOs1MvlB8WJNj8xFNJeCsG2MB00bCvGJrghji57bNTwr8G2COlTOhdG
	 3Ji2yU0K4xTLh5L4W7LrKQDnxBSKrkXeQiAqRgqdGLSXpEohrcC195P8+Qe6ISc16l
	 +zLiHi6UHsLi7DdU8x+WQWWwrDdUHXLE2tPjhfuV8+H8InJKwyQFX16uHaIw2v5Op8
	 KHM+caiuFVuAKZF3X4bX8eJzXzOSYpeZN3wNcsXRpBX82E+E3MIjC1B4vo+pmrmZR9
	 Uyx051XW6dkk/SBsTU1JDHzcBVrKKJh/DJbS5pj+D1uc3YsqYyK6K+f8p+m3BqkUGT
	 8W2KltieTVsrQ==
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
Subject: [PATCH 02/21] x86/resctrl: Use kthread_run_on_cpu()
Date: Tue, 12 Nov 2024 15:22:26 +0100
Message-ID: <20241112142248.20503-3-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112142248.20503-1-frederic@kernel.org>
References: <20241112142248.20503-1-frederic@kernel.org>
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
index 972e6b6b0481..6c60c16a9dd0 100644
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


