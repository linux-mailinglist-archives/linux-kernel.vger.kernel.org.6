Return-Path: <linux-kernel+bounces-336241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6244F97F0FB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9363B1C20A40
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F06E1A3030;
	Mon, 23 Sep 2024 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq3wHuCU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC21A3020
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118037; cv=none; b=h+fYyHSd0VgEOmL+y+lWbdCu/0t4WWj4pvFTb5YiJmk9MGqUBzQGorPQF2C15M9yc7ldBserAjNiqdtK3OJ+9Squxd2V2J/dX+EuehD/Bq8jXRHeeeQ0sj0Iubx0gxeOC/FiDg6FAIZN/CcT6VqvEUlQOYVS0CNOEkhTThqPXQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118037; c=relaxed/simple;
	bh=j0VCwuJl4cZp0rd8bJpHjeUVe1MJPzBBrM/Y9DvCYEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZECt25IcEIRl/OKkobEQM9MEvQPI23YVwVX+hFITAPLEjmYwG40+xNtqNTcIth0GObDjKhPDBiLe8m1cyz4YCtCOKgvWrO+SAGhrBPOdByJmrT9g4CqrNvpdq7kuLE0m2hDBwmbjdfXCl+G6rDKCB94/xwTmoqI2fOrAtskyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq3wHuCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A7FC4CED0;
	Mon, 23 Sep 2024 19:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727118037;
	bh=j0VCwuJl4cZp0rd8bJpHjeUVe1MJPzBBrM/Y9DvCYEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mq3wHuCUygl+N8Y9r5Cgy9YAMvrRszO6Lm9Fd8fFf7CP//YJrA+ElOw0H639D3noP
	 2mE+GtVmvWASbliUf6xMS4Kq10aYU/+n3KghiuDX2+/gKqmzisvgbj/XwFJeu86r9p
	 2DyFH+yRTEwKJWjkhEb6VcFbMWLoqLlT82bn7ogOtTINQS36B5zgXTUYHPEdUKcoTY
	 VXhTXZ8vvS68EFuG7MiqJlrfC7bdXIBhUuV3P2e6hnnXK0MWI2YWupleaHLCUBWulO
	 p3fKXIq6mG7vHI9BXDrdCXhfH15eibRhfRLg76KofWUpluOENLroM9iASneN2DiyIk
	 SE9Ssq1zhI/xg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	aboorvad@linux.ibm.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/8] sched_ext: Fix SCX_TASK_INIT -> SCX_TASK_READY transitions in scx_ops_enable()
Date: Mon, 23 Sep 2024 08:59:31 -1000
Message-ID: <20240923190020.1446325-5-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923190020.1446325-1-tj@kernel.org>
References: <20240923190020.1446325-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_ops_enable() has two task iteration loops. The first one calls
scx_ops_init_task() on every task and the latter switches the eligible ones
into SCX. The first loop left the tasks in SCX_TASK_INIT state and then the
second loop switched it into READY before switching the task into SCX.

The distinction between INIT and READY is only meaningful in the fork path
where it's used to tell whether the task finished forking so that we can
tell ops.exit_task() accordingly. Leaving task in INIT state between the two
loops is incosistent with the fork path and incorrect. The following can be
triggered by running a program which keeps toggling a task between
SCHED_OTHER and SCHED_SCX while enabling a task:

  sched_ext: Invalid task state transition 1 -> 3 for fish[1526]
  WARNING: CPU: 2 PID: 1615 at kernel/sched/ext.c:3393 scx_ops_enable_task+0x1a1/0x200
  ...
  Sched_ext: qmap (enabling+all)
  RIP: 0010:scx_ops_enable_task+0x1a1/0x200
  ...
   switching_to_scx+0x13/0xa0
   __sched_setscheduler+0x850/0xa50
   do_sched_setscheduler+0x104/0x1c0
   __x64_sys_sched_setscheduler+0x18/0x30
   do_syscall_64+0x7b/0x140
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fix it by transitioning to READY in the first loop right after
scx_ops_init_task() succeeds.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1b4b6439cd1a..fe86231e021d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5121,6 +5121,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			goto err_disable_unlock_all;
 		}
 
+		scx_set_task_state(p, SCX_TASK_READY);
+
 		put_task_struct(p);
 		spin_lock_irq(&scx_tasks_lock);
 	}
@@ -5133,7 +5135,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	WRITE_ONCE(scx_switching_all, !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
 
 	/*
-	 * We're fully committed and can't fail. The PREPPED -> ENABLED
+	 * We're fully committed and can't fail. The task READY -> ENABLED
 	 * transitions here are synchronized against sched_ext_free() through
 	 * scx_tasks_lock.
 	 */
@@ -5145,7 +5147,6 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
 
-		scx_set_task_state(p, SCX_TASK_READY);
 		__setscheduler_prio(p, p->prio);
 		check_class_changing(task_rq(p), p, old_class);
 
-- 
2.46.0


