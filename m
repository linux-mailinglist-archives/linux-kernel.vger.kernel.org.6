Return-Path: <linux-kernel+bounces-515336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99679A36357
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0AF3ADD53
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5423526770F;
	Fri, 14 Feb 2025 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuHQjnss"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE238635A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551435; cv=none; b=VhpkC23tN1QBaYHE3Z5NsPxywITOh91Uie7pVP1KAtmszjNCCX8vRfhF1AOwg0GzBO5FZjqmhwcb9HagdnLRSaCF+nAlxnybDVbX7L26lkUy7St+TmnQoIEvWIqEgUbB9PeSe/x+Jjg//IgWh+INBA2l1xXifZ/PGDSlNKh5QMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551435; c=relaxed/simple;
	bh=esYoUBbmHnuppLQ8e5DQfVQUVFoE7zAAEwjgZADndxI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p7rB71oPsJs1Y4B37/U2KuuUrqCvnKyEnHDHEt42LdDapG9mChQHGRWzO/Nl8vuMbtga2kgOJ981s2vDCmxUZwLRU4tm6PSd01S1GnEZggpCV8g4ToCA7bSdXfxJibNHpYsGMbfdJz1BvOLgu4vo7TFJrCsvYG+CmXlgyDd37sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuHQjnss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60CFC4CED1;
	Fri, 14 Feb 2025 16:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739551435;
	bh=esYoUBbmHnuppLQ8e5DQfVQUVFoE7zAAEwjgZADndxI=;
	h=From:To:Cc:Subject:Date:From;
	b=nuHQjnssdw3xfKuKFcIAxLfIs5GD2OTSPr5Zvq/1YmQ/BH2lyuSLdrKEcXCNobGgq
	 ThMi28QMuZlnAhO8OWm9Vr0WnSEpItlvIKgOQ20WHIbfNNOdyRhj76X/TCsy9fXQ9I
	 DGQjLhF6JtCnxERtHzhzbRglSUZPswP7OBOQiIXyOn34l59ALQ8vn4pZO3V5BNUAF1
	 oLb2iYCzdHK3bAmx5q8ujVP0z/vz5Un7JR5cOKepCYM7xRc9P0c34KjLEX3k93xm35
	 tjISFZlUuhLdc5wBx/aKP1I1aiSoff3wid+fjgw0SQY9A3/yYQYmUPfnZmxjssEhqZ
	 94CzI5RBoXGUQ==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: Log additional details when rejecting work
Date: Fri, 14 Feb 2025 16:43:49 +0000
Message-Id: <20250214164349.13694-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot regularly runs into the following warning on arm64:

  | WARNING: CPU: 1 PID: 6023 at kernel/workqueue.c:2257 current_wq_worker kernel/workqueue_internal.h:69 [inline]
  | WARNING: CPU: 1 PID: 6023 at kernel/workqueue.c:2257 is_chained_work kernel/workqueue.c:2199 [inline]
  | WARNING: CPU: 1 PID: 6023 at kernel/workqueue.c:2257 __queue_work+0xe50/0x1308 kernel/workqueue.c:2256
  | Modules linked in:
  | CPU: 1 UID: 0 PID: 6023 Comm: klogd Not tainted 6.13.0-rc2-syzkaller-g2e7aff49b5da #0
  | Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
  | pstate: 404000c5 (nZcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  | pc : __queue_work+0xe50/0x1308 kernel/workqueue_internal.h:69
  | lr : current_wq_worker kernel/workqueue_internal.h:69 [inline]
  | lr : is_chained_work kernel/workqueue.c:2199 [inline]
  | lr : __queue_work+0xe50/0x1308 kernel/workqueue.c:2256

  [...]

  |    __queue_work+0xe50/0x1308 kernel/workqueue.c:2256 (L)
  |  delayed_work_timer_fn+0x74/0x90 kernel/workqueue.c:2485
  |  call_timer_fn+0x1b4/0x8b8 kernel/time/timer.c:1793
  |  expire_timers kernel/time/timer.c:1839 [inline]
  |  __run_timers kernel/time/timer.c:2418 [inline]
  |  __run_timer_base+0x59c/0x7b4 kernel/time/timer.c:2430
  |  run_timer_base kernel/time/timer.c:2439 [inline]
  |  run_timer_softirq+0xcc/0x194 kernel/time/timer.c:2449

The warning is probably because we are trying to queue work into a
destroyed workqueue, but the softirq context makes it hard to pinpoint
the problematic caller.

Extend the warning diagnostics to print both the function we are trying
to queue as well as the name of the workqueue.

Cc: Tejun Heo <tj@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Link: https://syzkaller.appspot.com/bug?extid=e13e654d315d4da1277c
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/workqueue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3c2c45313c88..1fad298ed85f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2254,8 +2254,10 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	 * queues a new work item to a wq after destroy_workqueue(wq).
 	 */
 	if (unlikely(wq->flags & (__WQ_DESTROYING | __WQ_DRAINING) &&
-		     WARN_ON_ONCE(!is_chained_work(wq))))
+		     WARN_ONCE(!is_chained_work(wq), "workqueue: cannot queue %ps on wq %s\n",
+			       work->func, wq->name))) {
 		return;
+	}
 	rcu_read_lock();
 retry:
 	/* pwq which will be used unless @work is executing elsewhere */
-- 
2.48.1.601.g30ceb7b040-goog


