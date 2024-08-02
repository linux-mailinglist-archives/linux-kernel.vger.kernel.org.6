Return-Path: <linux-kernel+bounces-271957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA00945567
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B591C22E0D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAECF9EC;
	Fri,  2 Aug 2024 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a17gmV2w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E68D53C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558649; cv=none; b=N2OZVwrKeWiJOtJSchML9hB5t7+SxMqhl08Zm1H1TiY6fNCoy7/8a75O9gO1RIUl45lm6h8BaSAciWIz+MWWALXCu+5AoFMktL14x9pH++PWzGANf6OCBhiFVwMuY17+E2tupwDKZkg39w1rhwnrSAcbP/MQq2F0qHkWU9pHD9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558649; c=relaxed/simple;
	bh=8C34RINqOzbv7O7VmP3k09aSRfR+MGxFqszYs5oYLmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KwSAm6BZ65/s34awRRv7A2t72Mz5FfX8mAGVXJtYcNAneptiMNOhnKgMAf0C6s58COzIrzYiqZBITbpIYF6WtvMxo3luPhwuvt8dbhTCYFC6xMkL263Zz+VOQXU/mqQGq2Sf4LGjg1+atP/H0VcNRkaNBqT+9WGc36HVcBjZ3e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a17gmV2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76223C32786;
	Fri,  2 Aug 2024 00:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558648;
	bh=8C34RINqOzbv7O7VmP3k09aSRfR+MGxFqszYs5oYLmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a17gmV2wnRRVOhxYHWUgCEM6Vzn7ARLANkfCUMrUt2RVBrdSOxkZr9uRHbI+nFQ9L
	 3n8/3kGeeLcc3Z1mNUkRfzKM7xc4ZKFKatT4O1KlbgFmHXQBK2YxUgG0ueNX+8iOZU
	 GQOrIWVIdQJGwBLkiZGwii8yePOo/nIkY8tCfbvIXKIxt5DyLjBnA2DHyBZcQYke2X
	 8Y3SJZjYEvOGKhNtyBZ05/I07OFWzjICuPO24W3TrgHPMnMBNKnRlgR6A6HCVonmZe
	 Ymh62f1q+3mOKqnRKCSAir4vwAUVm/jSOSTvC5DnhCCyhGzmMUvDtC7/FF/mdaHbAm
	 cqgB4pf4KsPkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2B8C0CE09F8; Thu,  1 Aug 2024 17:30:48 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Rik van Riel <riel@surriel.com>,
	Anhad Jai Singh <ffledgling@meta.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chris Mason <clm@fb.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH misc 1/2] workqueue: Add check for clocks going backwards to wq_worker_tick()
Date: Thu,  1 Aug 2024 17:30:45 -0700
Message-Id: <20240802003046.4134043-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d70d1654-fed2-477f-8f4f-f81322784f17@paulmck-laptop>
References: <d70d1654-fed2-477f-8f4f-f81322784f17@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Experimental, might never go to mainline.

There has been some evidence of clocks going backwards, producing
"workqueue: kfree_rcu_monitor hogged CPU" diagnostics on idle systems
just after a change in clocksource.  This diagnostic commit checks for
this, ignoring differences that would be negative if interpreted as a
signed 64-bit integer.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: Rik van Riel <riel@surriel.com>
---
 kernel/workqueue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1745ca788ede3..4f7b4b32e6b4e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1482,6 +1482,7 @@ void wq_worker_tick(struct task_struct *task)
 	 * If the current worker is concurrency managed and hogged the CPU for
 	 * longer than wq_cpu_intensive_thresh_us, it's automatically marked
 	 * CPU_INTENSIVE to avoid stalling other concurrency-managed work items.
+	 * If the time is negative, ignore, assuming a backwards clock.
 	 *
 	 * Set @worker->sleeping means that @worker is in the process of
 	 * switching out voluntarily and won't be contributing to
@@ -1491,6 +1492,7 @@ void wq_worker_tick(struct task_struct *task)
 	 * We probably want to make this prettier in the future.
 	 */
 	if ((worker->flags & WORKER_NOT_RUNNING) || READ_ONCE(worker->sleeping) ||
+	    WARN_ON_ONCE((s64)(worker->task->se.sum_exec_runtime - worker->current_at) < 0) ||
 	    worker->task->se.sum_exec_runtime - worker->current_at <
 	    wq_cpu_intensive_thresh_us * NSEC_PER_USEC)
 		return;
-- 
2.40.1


