Return-Path: <linux-kernel+bounces-228991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC5591697A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBA51F210C4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4025216C69F;
	Tue, 25 Jun 2024 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMpGwrrs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F916C68F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323579; cv=none; b=oe3Unb9kBiooNXeSb1JXb4QLovWbQXZtdjnuHnJBTggb3w/NwE+71euKRoJ8aXMQzM3InmplR5Z88ulEJ8CQ0GrOJ+rgjOwT5dnVydoga0Qo3oj0yOb+ac9d2i9tKajlfyYkUqmdRumAFSZHBs/giVEaZLrD2loMaW3+yKvaP/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323579; c=relaxed/simple;
	bh=1Lmu4cLSQd3WIs+Qp9CQZmWu+Bdz0TB/eweAMF+fREs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjJLLotF6ihKRHBHw3MNOyO8BccRDyYPVtzyCi5mT71COdbr8csfz1U3HRevtbcB2uM9l/qMLcxm9NWA0Rd+p/p38aO7sv8fyk3JJHiNH9OrBO0L7t9ThTYaXZxoaG2/3y9bJ/TLWpdPkEH7pOpXN2Gtz5PiDOEe66MWwEC20VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMpGwrrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2487C4AF10;
	Tue, 25 Jun 2024 13:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719323579;
	bh=1Lmu4cLSQd3WIs+Qp9CQZmWu+Bdz0TB/eweAMF+fREs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tMpGwrrs8lNBF6+IyzFFzHnboXv74SEp00R5GHX9cijPU3UyznfXy/D5o4eiuMJu2
	 3+gPpot5RrOwwJ/cEqn0Z7DcJncm/JiYV0gkT3eqm1uo6ObLGIUmnq++QYNGuwX9rW
	 F/WmyqxJAV42SKJbW0aW+J5fW9TGCApj0IwUD06I2D1C1aWCadPHark+1iK7dF23gA
	 qoPqYDwLgoqKsAr9PEqp6t7Y5bB0a6mANVONasJrxa1zkYsaSYD1xMBhqPXs9caA8X
	 CUD2k2hPj1yTGeNlZoBpPzwUHklQa1n7sxEc6+OqW7p8+MML4AvPts13Fi1WayKqAz
	 ApYyFfuSx6AOA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [RFC PATCH 3/6] sched: Use task_work_queued() on cid_work
Date: Tue, 25 Jun 2024 15:52:41 +0200
Message-ID: <20240625135244.20227-4-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625135244.20227-1-frederic@kernel.org>
References: <20240625135244.20227-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the ad-hoc implementation of task_work_queued()

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc0522..f01979b600e8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11930,7 +11930,6 @@ static void task_mm_cid_work(struct callback_head *work)
 
 	SCHED_WARN_ON(t != container_of(work, struct task_struct, cid_work));
 
-	work->next = work;	/* Prevent double-add */
 	if (t->flags & PF_EXITING)
 		return;
 	mm = t->mm;
@@ -11974,7 +11973,6 @@ void init_sched_mm_cid(struct task_struct *t)
 		if (mm_users == 1)
 			mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
 	}
-	t->cid_work.next = &t->cid_work;	/* Protect against double add */
 	init_task_work(&t->cid_work, task_mm_cid_work);
 }
 
@@ -11983,8 +11981,7 @@ void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
 	struct callback_head *work = &curr->cid_work;
 	unsigned long now = jiffies;
 
-	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
-	    work->next != work)
+	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) || task_work_queued(work))
 		return;
 	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
 		return;
-- 
2.45.2


