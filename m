Return-Path: <linux-kernel+bounces-407014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5D59C676E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8D28B2616C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A557148FE1;
	Wed, 13 Nov 2024 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="IzIguMs+"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F238E1442F6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731465786; cv=none; b=faarf6uBUli2klHH3nlAUOHaWpNr/cwrsaEyvoBzlJ060It4CuTlFPNBv9z+neSj8TdZG0NWxeZCfKWrmQUqCz8E64E1bjnz7d0+guQFIHzCB04psjcXBixpsgMdsBlJpjcNgRbS/K/z+gYCSdYkPFbtkYi/tmZAxBS+A4VtzuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731465786; c=relaxed/simple;
	bh=uvKW4kIptltJp4U3xd9CGKD1ESbFT5ezIz0HemAtG2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSZYDz8Lmfni+dxABDAzrwwCu6UszQNo2p4yTcAyMiBbYqmM6VSpY7GL1lZXBoSusUYkjDtfYKz6EY3vSrCP0Owl2Es0MoW+WGBrq6cFCaDEofwkTwI5AiECJqw3dnuTvHCDxNVAA6qUZOaNnCWcUU9kIlGIoc6hKuhfXp03DTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=IzIguMs+; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=jq6uH
	QbE9AGGKyeI1cLFEGZadC02GR2k/GYhmY8uqAc=; b=IzIguMs+l8shhEp3H3p93
	17G8mLBnAuW2aUYTYxzMIDEqdz5OKkNwpsQpq8SXWHh62qH/78NySNv93dHHj6/M
	KIk46CEXorUMHkVTLllF3YapMjfYyBWlHoDVYfc+FNAZNdRGjReDzL8xey4FFacc
	0EwEwl9hP6D7KFpySZwswY=
Received: from localhost.localdomain (unknown [123.53.36.205])
	by gzsmtp5 (Coremail) with SMTP id qSkvCgD3Vy+ADjRnLaknBQ--.10188S2;
	Wed, 13 Nov 2024 10:27:12 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com
Cc: zhaomengmeng@kylinos.cn,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Replace hardcoding with macro and minor typo fix
Date: Wed, 13 Nov 2024 10:26:37 +0800
Message-ID: <20241113022637.297792-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qSkvCgD3Vy+ADjRnLaknBQ--.10188S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4kGw15Zr1rZrWkuF47XFb_yoW8Zw4xpF
	Z8XF4UG3WkXF47X34xAF4kC3429wna93W7Kr1rAwsakr95Kr1jqwnFqF4aqFW0y39avFy3
	ZF4jg3y7Xwn7W3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQmRUUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbimguWd2c0BquoRQAAsj

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

1. replace hardcoding with SCX_KF_UNLOCKED.
2. scx_next_task_picked() has been replaced with siwtch_class().
2. minor typo fixes.

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


