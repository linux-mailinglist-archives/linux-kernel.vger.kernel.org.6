Return-Path: <linux-kernel+bounces-371375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5920E9A3A37
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0899E1F281F7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A881FF7CC;
	Fri, 18 Oct 2024 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IJE8xZ5O"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135CB1F8924
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244441; cv=none; b=dp3tmY712pxRhK/zeBC+MZcVeh6AbUs3cJpl8Ox18nB0dpzhomBVpvpafTF3A0z1Z8QVUV3XS15Y6TLmQmoTEBdun0DxA1km8E6OLxM9ME+gAybXLWxTovmLmWHvAOLM/3FkNvQR6Trk4esSWB6g5TSR3jTZ+RBq9RiCVcV8YKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244441; c=relaxed/simple;
	bh=VjtlmWV+/LA8G3s2lKzJGA3bXCeBNqT37Gm49h5CU6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFlx+TjF+q8VUF4BzDsH1auyRBO9QQMA/iANBgC7Gr07cGRntpxenDMg76/7F1BvZV8/ALn7P9qpP0oJYH2NPjTIV8iRRlW1qgQc1iTG/vXyHRiOZlnKaRXFvXHTZZV4wFxfuV/tptqHs57AXrIyhkLOFY1PX5BY6u8om13SI/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IJE8xZ5O; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729244437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EGS+Zmvx1BSPBM6JUvsz/W/2vC9RaxIP5u5IVVeaHTo=;
	b=IJE8xZ5OSeHLCMDW1oJ5brzkF3EvxcEqIpuo0xHIJU/i1Ujfrb9G6DR9goDHBb+kILMTK1
	qra3crdsHK7vU97ZGQ4vP/kYV16snR9sOypn3pYzIOpJMQCTJDe7HfgOqgpoW5FbCh62nw
	cOiBl3kCcPa/3GL6o+2nxl1aSFnj6Qc=
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: improve WAKE_SYNC behavior for default idle CPU selection
Date: Fri, 18 Oct 2024 11:40:33 +0200
Message-ID: <20241018094033.160188-1-andrea.righi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the sched_ext built-in idle CPU selection logic, when handling a
WF_SYNC wakeup, we always attempt to migrate the task to the waker's
CPU, as the waker is expected to yield the CPU after waking the task.

However, it may be preferable to keep the task on its previous CPU if
the waker's CPU is cache-affine.

The same approach is also used by the fair class and in other scx
schedulers, like scx_rusty and scx_bpfland.

Therefore, apply the same logic to the built-in idle CPU selection
policy as well.

Signed-off-by: Andrea Righi <andrea.righi@linux.dev>
---
 kernel/sched/ext.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6eae3b69bf6e..8b7d90db3cfb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3087,20 +3087,38 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	*found = false;
 
 	/*
-	 * If WAKE_SYNC, the waker's local DSQ is empty, and the system is
-	 * under utilized, wake up @p to the local DSQ of the waker. Checking
-	 * only for an empty local DSQ is insufficient as it could give the
-	 * wakee an unfair advantage when the system is oversaturated.
-	 * Checking only for the presence of idle CPUs is also insufficient as
-	 * the local DSQ of the waker could have tasks piled up on it even if
-	 * there is an idle core elsewhere on the system.
-	 */
-	cpu = smp_processor_id();
-	if ((wake_flags & SCX_WAKE_SYNC) &&
-	    !cpumask_empty(idle_masks.cpu) && !(current->flags & PF_EXITING) &&
-	    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
-		if (cpumask_test_cpu(cpu, p->cpus_ptr))
+	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
+	 */
+	if (wake_flags & SCX_WAKE_SYNC) {
+		cpu = smp_processor_id();
+
+		/*
+		 * If the waker's CPU is cache affine and prev_cpu is idle,
+		 * then avoid a migration.
+		 */
+		if (cpus_share_cache(cpu, prev_cpu) &&
+		    test_and_clear_cpu_idle(prev_cpu))
 			goto cpu_found;
+
+		/*
+		 * If the waker's local DSQ is empty, and the system is under
+		 * utilized, try to wake up @p to the local DSQ of the waker.
+		 *
+		 * Checking only for an empty local DSQ is insufficient as it
+		 * could give the wakee an unfair advantage when the system is
+		 * oversaturated.
+		 *
+		 * Checking only for the presence of idle CPUs is also
+		 * insufficient as the local DSQ of the waker could have tasks
+		 * piled up on it even if there is an idle core elsewhere on
+		 * the system.
+		 */
+		if (!cpumask_empty(idle_masks.cpu) &&
+		    !(current->flags & PF_EXITING) &&
+		    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
+			if (cpumask_test_cpu(cpu, p->cpus_ptr))
+				goto cpu_found;
+		}
 	}
 
 	/*
-- 
2.47.0


