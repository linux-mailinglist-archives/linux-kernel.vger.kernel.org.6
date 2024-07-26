Return-Path: <linux-kernel+bounces-263770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8023393DA4B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D667C282D22
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE82153598;
	Fri, 26 Jul 2024 21:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bj9jBOmM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F2A152166
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031031; cv=none; b=jyqnGtA+Lm36gsB+2RoHZlY0M9l+BpK7R6KEogvVLlkvLWi7W9D+5xBt557jBOb1aUssE89FzIfWnFRmRmp8lEwiU8ft1Vxk+q5L8wT6UuJfhs9oUJQSvugNXop6RgSF2Ywo1KC8YM97cO2lEL6rExSm+tvQf8TWCwRzSVKhRMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031031; c=relaxed/simple;
	bh=6bIiF2HH3HUsJJc37tbdsLXdubo38jKZqYpDgeWswng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8xfqdl+KYQSR8mnaUw+T8nvS2eKp8Tnw97QRFLm+2jD9raey5K/cvhiDE0ZZ+nz66npmVuWas7De3UN8YVdt1a9cbwgehCvsvIYbFO1ZpFsuSxUZ084GKOq/Yw3OVe3Gw25X0rE1uwvcluEiVqTBB56K7L58+VXtbv8aFpi+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bj9jBOmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB5CC4AF0F;
	Fri, 26 Jul 2024 21:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722031031;
	bh=6bIiF2HH3HUsJJc37tbdsLXdubo38jKZqYpDgeWswng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bj9jBOmMStNzj+cgOq8CHPJI5UEiBVpJp1mpVKrwD6nI/9pozNwhAEdEasqNPH2p5
	 NpU/hf3UtOliCw9SZ4GGjlBH7BZKYgYBzn62hepa6YkrJXNmFteXBYL+ibANjCp9dc
	 IavAccxMauMlFtFnkkV68hdOMtAefb3M0vZrkP9+WeNm4Pm9Y9CCvLMViV1s65HJ8V
	 e1AxtaURwgVatoAf1nxAIOyP55yz4HJ9dxh6W96ai75Jzk8tklAMJDr+JsaS5kVmNZ
	 PoVeRFQFUQA5muJO+2o+ySiqE1hm5l9OF8fTVwexMyZm+IgYopU4WoKen13QG5267R
	 k6eF1/n2+Fkvw==
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
Subject: [PATCH 02/20] x86/resctrl: Use kthread_run_on_cpu()
Date: Fri, 26 Jul 2024 23:56:38 +0200
Message-ID: <20240726215701.19459-3-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726215701.19459-1-frederic@kernel.org>
References: <20240726215701.19459-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the proper API instead of open coding it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 28 +++++++----------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index aacf236dfe3b..a07778fade31 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -1207,20 +1207,14 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
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
 
@@ -1228,8 +1222,6 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
 		ret = PTR_ERR(thread);
 		goto out;
 	}
-	kthread_bind(thread, cpu);
-	wake_up_process(thread);
 
 	ret = wait_event_interruptible(plr->lock_thread_wq,
 				       plr->thread_done == 1);
@@ -1317,18 +1309,14 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 
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


