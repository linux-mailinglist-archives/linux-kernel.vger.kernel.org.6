Return-Path: <linux-kernel+bounces-372193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F1F9A457D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B1828366F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897D6204931;
	Fri, 18 Oct 2024 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s3gqcCSQ"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FBF2040B7
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274999; cv=none; b=ichCgG8aCoh5YdeUfXcI9nrvzlVMcVAD/FaDONRdTVCMgnGpkyUluJWa4GxKBJn3bCH9WndJKWsIosX2DStjcPGz92y0c9Lf8MKDgXrG+39newCkCantuiS/klfDx1IatW/Eb439gG84GaEYzix3md8Ot7EYJzkgzeXBv2eI9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274999; c=relaxed/simple;
	bh=W9pP8aAhBIbIZU0KiiaZPkNSQMOggtpuCasabxpekCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YbjMb//9IfWQ6rrI0ACbv/VQDA/2tsMpv40t8CV/XGRIdsl1LE3qPkommzf1KjV2dpR7CggSoBsOodAbPVKFl+jRt/Ki4Nui8espTcHb0RKuR9bw/Ox8qwfYElcRz+zkZThSjj87r9CE8wp8jYFevTnEdBzVGarqDA0fY8O4b6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s3gqcCSQ; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729274994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LQa9VnLheHxCFWlnEiY1bZ51fkZDcHbIYFUsXeK1JWE=;
	b=s3gqcCSQaELXX879OHjU9ucb60mF9sfOcvJo0lCBy3z79mW3poVsBP5NcD5DTGdk4n1OfI
	9QpRFaphmc+bDwGiIv4npzRHbtq9T+z0bySqRHyib+krmZZYif+gZKPVgfkBOswLaR2F/6
	LCF6LDKFs15RwoJG7wvNwATG0QBjh6w=
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched_ext: improve WAKE_SYNC behavior for default idle CPU selection
Date: Fri, 18 Oct 2024 20:09:51 +0200
Message-ID: <20241018180951.599625-1-andrea.righi@linux.dev>
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
 kernel/sched/ext.c | 46 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

ChangeLog v1 -> v2:
  - correctly return prev_cpu in the cache affine case

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6eae3b69bf6e..a34af6df2f98 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3087,20 +3087,40 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
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
+		    test_and_clear_cpu_idle(prev_cpu)) {
+			cpu = prev_cpu;
 			goto cpu_found;
+		}
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


