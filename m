Return-Path: <linux-kernel+bounces-348215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEDC98E432
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5181C23564
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6EC21730E;
	Wed,  2 Oct 2024 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrB9M5OC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293DB216A21
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901219; cv=none; b=GopT+XxkXC3ERuggvKuusWyEfsF+xerk/z+SmrwR2bs5wIAUSzExUkc1LyURb0DJR2A4ClcOWgAZYbTTMwiEZcq602XPo4b00a03/ALB7OnudSzWnAKAwZiO2hRFx16rHCA8qzz3nQgbMrAHBa2ag9XbsaCbYZcCCYoOE0B7weU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901219; c=relaxed/simple;
	bh=ZbdFxguw6QAPRg4tzO2SJ7YLitKaWlGiXtozsHVf9MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eCTRVbLqTO/e2ezoP+42e1Mt6dEgFAWjUo52IsFQMPT9zIiOmZ909TGUqQe0NcsOCZHzF/7L/aqBIwTReSdTGVE0Wm6aLmVFJoMgf6t4rjFbWBnEiZXKt0G2pF3DCtx4h4YpSj45cTm7YRw2LXg3WCoyoGIrG+2+lynno9qYiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrB9M5OC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA6FC4CEC2;
	Wed,  2 Oct 2024 20:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727901219;
	bh=ZbdFxguw6QAPRg4tzO2SJ7YLitKaWlGiXtozsHVf9MQ=;
	h=Date:From:To:Cc:Subject:From;
	b=mrB9M5OCrEqimi0nLGrLZcRwq9Dev9Gtp9ySlwmWJnFR4jwa6lv22BiAOo4ywr21E
	 tP/nJglIw0Izq3Vey/YHyNwCo2srLLzzgb3evp69J14mjNKFKY0Xo02YACfh7sM6PC
	 bRWo4nH8rR16rNvQvi6l0oD+DXNRoHMw3/tKlKQMVYR7SseB4TLrXWYtauu6k9sVO5
	 EdhOMfVl6fn+De8qdKx/z4DggCYDz1GbFMtsOvVb7OfUxYeFsrkTKWKszTtZ9x4jZb
	 kMlSAANzZkB5SBy+b+Jo1+srrDff8GTC8Y9PiZPuAq20kc5l8S3lOg7tRT46QPhHVO
	 Np0LCvaf1S+pw==
Date: Wed, 2 Oct 2024 10:33:37 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com,
	Daniel Hodges <hodges.daniel.scott@gmail.com>,
	Changwoo Min <multics69@gmail.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: [PATCH sched_ext/for-6.12-fixes] sched_ext: Improve error reporting
 during loading
Message-ID: <Zv2uIXK53_Dqtw8T@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When the BPF scheduler fails, ops.exit() allows rich error reporting through
scx_exit_info. Use scx.exit() path consistently for all failures which can
be caused by the BPF scheduler:

- scx_ops_error() is called after ops.init() and ops.cgroup_init() failure
  to record error information.

- ops.init_task() failure now uses scx_ops_error() instead of pr_err().

- The err_disable path updated to automatically trigger scx_ops_error() to
  cover cases that the error message hasn't already been generated and
  always return 0 indicating init success so that the error is reported
  through ops.exit().

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
Cc: Daniel Hodges <hodges.daniel.scott@gmail.com>
Cc: Changwoo Min <multics69@gmail.com>
Cc: Andrea Righi <andrea.righi@linux.dev>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 kernel/sched/ext.c |   30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -625,6 +625,10 @@ struct sched_ext_ops {
 	/**
 	 * exit - Clean up after the BPF scheduler
 	 * @info: Exit info
+	 *
+	 * ops.exit() is also called on ops.init() failure, which is a bit
+	 * unusual. This is to allow rich reporting through @info on how
+	 * ops.init() failed.
 	 */
 	void (*exit)(struct scx_exit_info *info);
 
@@ -4184,6 +4188,7 @@ static int scx_cgroup_init(void)
 				      css->cgroup, &args);
 		if (ret) {
 			css_put(css);
+			scx_ops_error("ops.cgroup_init() failed (%d)", ret);
 			return ret;
 		}
 		tg->scx_flags |= SCX_TG_INITED;
@@ -5108,6 +5113,7 @@ static int scx_ops_enable(struct sched_e
 		if (ret) {
 			ret = ops_sanitize_err("init", ret);
 			cpus_read_unlock();
+			scx_ops_error("ops.init() failed (%d)", ret);
 			goto err_disable;
 		}
 	}
@@ -5217,8 +5223,8 @@ static int scx_ops_enable(struct sched_e
 			spin_lock_irq(&scx_tasks_lock);
 			scx_task_iter_exit(&sti);
 			spin_unlock_irq(&scx_tasks_lock);
-			pr_err("sched_ext: ops.init_task() failed (%d) for %s[%d] while loading\n",
-			       ret, p->comm, p->pid);
+			scx_ops_error("ops.init_task() failed (%d) for %s[%d]",
+				      ret, p->comm, p->pid);
 			goto err_disable_unlock_all;
 		}
 
@@ -5266,14 +5272,8 @@ static int scx_ops_enable(struct sched_e
 
 	scx_ops_bypass(false);
 
-	/*
-	 * Returning an error code here would lose the recorded error
-	 * information. Exit indicating success so that the error is notified
-	 * through ops.exit() with all the details.
-	 */
 	if (!scx_ops_tryset_enable_state(SCX_OPS_ENABLED, SCX_OPS_ENABLING)) {
 		WARN_ON_ONCE(atomic_read(&scx_exit_kind) == SCX_EXIT_NONE);
-		ret = 0;
 		goto err_disable;
 	}
 
@@ -5308,10 +5308,18 @@ err_disable_unlock_all:
 	scx_ops_bypass(false);
 err_disable:
 	mutex_unlock(&scx_ops_enable_mutex);
-	/* must be fully disabled before returning */
-	scx_ops_disable(SCX_EXIT_ERROR);
+	/*
+	 * Returning an error code here would not pass all the error information
+	 * to userspace. Record errno using scx_ops_error() for cases
+	 * scx_ops_error() wasn't already invoked and exit indicating success so
+	 * that the error is notified through ops.exit() with all the details.
+	 *
+	 * Flush scx_ops_disable_work to ensure that error is reported before
+	 * init completion.
+	 */
+	scx_ops_error("scx_ops_enable() failed (%d)", ret);
 	kthread_flush_work(&scx_ops_disable_work);
-	return ret;
+	return 0;
 }

