Return-Path: <linux-kernel+bounces-407019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8183B9C677A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF553B239B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7885C15ADA6;
	Wed, 13 Nov 2024 02:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="jFkhEfWb"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7157158DA3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731466771; cv=none; b=Edls0Tw+bz3l/xQN/wt0Ak94y4sAkWEUqhKnzA1WdAeaK5hgykgfjbGYar4Hs8bRC9Z89aX0oO4JGztoqzna+hFMEpgM6sYa71eJLvDjU4+ViAmQbIlm2s8M+w5Pa+Awd5zLsPGQ6QI0KE8si2cJhMJVKs5EsZDsVv+lTtxKSC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731466771; c=relaxed/simple;
	bh=SBGAdYILeQEY8Z4kAz9ncA42TXWq70GKT6dTLRGxFh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kFALgSgpc0HGKEPGOGdhYuWtUh5KcWKfhx3MhsEmCy+JUOXOfJT/cVrI6Uqw2Mq7V4tDf6McC03saElZm+jPa3ek8EW3Q1ostWm3KRgF6uEsHO1vGrbrhVM75KLvioSsK6ymKQJU9GPY2jq7B4w2sIvutfKzcEJr8sf1L1GUJGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=jFkhEfWb; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=D35NX
	9xzWeirIXvaA+Grz6mddwogtebIf88MjH4CXOw=; b=jFkhEfWbtKOx2NS/xB0ii
	7xSNlSSllGd/FNvMDFW00v460xqT7V2wdPlyCBHYYLL8Vx9W9G7ZlcoSHONIvDRQ
	sTz8xJ9OMoeWOPMtNGLC8k0I1VNjckUAbk07OBnFRPTQzXaw/PwhRCpYMZBejCTM
	z8MGX4rYFi7ZA5jBEg4ags=
Received: from localhost.localdomain (unknown [123.53.36.205])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3n3wAFjRneISrBw--.40449S2;
	Wed, 13 Nov 2024 10:59:12 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com
Cc: zhaomengmeng@kylinos.cn,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched_ext: Replace hardcoding with macro and minor typo fix
Date: Wed, 13 Nov 2024 10:59:08 +0800
Message-ID: <20241113025908.306936-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n3wAFjRneISrBw--.40449S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4kGw15Zr1kCFWkuFWrAFb_yoW8Zw4xpF
	Z8XF4UG3WkXF47X34xAF4kC3429wna93W7Kr1rAwsakr95Kr1jqwnFqF4aqFW0y39avFy3
	ZF4jgrW7Xwn7W3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQmRUUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbiEBCWd2c0Ew40tQAAsu

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

1. replace hardcoding with SCX_KF_UNLOCKED.
2. scx_next_task_picked() has been replaced with siwtch_class().
3. minor typo fixes.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 kernel/sched/ext.c             | 6 +++---
 tools/sched_ext/scx_qmap.bpf.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1b1c33f12dd7..832f77d1d318 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2759,10 +2759,10 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * If the previous sched_class for the current CPU was not SCX,
 		 * notify the BPF scheduler that it again has control of the
 		 * core. This callback complements ->cpu_release(), which is
-		 * emitted in scx_next_task_picked().
+		 * emitted in switch_class().
 		 */
 		if (SCX_HAS_OP(cpu_acquire))
-			SCX_CALL_OP(0, cpu_acquire, cpu_of(rq), NULL);
+			SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_acquire, cpu_of(rq), NULL);
 		rq->scx.cpu_released = false;
 	}
 
@@ -6096,7 +6096,7 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 		if (cpu != cpu_of(this_rq)) {
 			/*
 			 * Pairs with smp_store_release() issued by this CPU in
-			 * scx_next_task_picked() on the resched path.
+			 * switch_class() on the resched path.
 			 *
 			 * We busy-wait here to guarantee that no other task can
 			 * be scheduled on our core before the target CPU has
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index ee264947e0c3..f230641929ec 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -5,7 +5,7 @@
  * There are five FIFOs implemented using BPF_MAP_TYPE_QUEUE. A task gets
  * assigned to one depending on its compound weight. Each CPU round robins
  * through the FIFOs and dispatches more from FIFOs with higher indices - 1 from
- * queue0, 2 from queue1, 4 from queue2 and so on.
+ * queue0, 2 from queue1, 3 from queue2 and so on.
  *
  * This scheduler demonstrates:
  *
-- 
2.43.0


