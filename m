Return-Path: <linux-kernel+bounces-314480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E1C96B3DC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B60B1F21549
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C1A1885AE;
	Wed,  4 Sep 2024 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7P/srdS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89133187FF5
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437015; cv=none; b=DUd3kIGOO4nc1D4cuZxjd6zMVHkgutxjH921H+ycaO818qkt+I2lSde+FiFyvHLR14uOEpmk7qBRFjKzQSdLvkUeuaSoBlyxZgGOS/BDEftDSJ60bpLVMyfqmkTQdUL3lRNgywj6d+ZyLZwCXH8CaxS7EpsmlitNTUBqyDRTzO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437015; c=relaxed/simple;
	bh=t1liJbnbFrWVXBr6VbH3W+FxroXRKXrKLHA8+4+jw3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQ/DO7fS8AvkxlpsfezY7Xl3Jj147CgDZMOf2Rc+j4GC47eNnZr1OBdZQhBwf7e0hrzQWgA55Od7w64Yap+11EHIEUscvdfhH10CKHSJ7bpBtXWJhNOyasnk1iCXHBEdWvRmRNHPqt/JsABrIZh7ni4fIt0+om3a5qY+9kmuNz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7P/srdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3EDC4CEC5;
	Wed,  4 Sep 2024 08:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725437015;
	bh=t1liJbnbFrWVXBr6VbH3W+FxroXRKXrKLHA8+4+jw3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B7P/srdSAV+EndeBN+20BS2QWBE5nvzvMExU6bq/4KUur59XEGz1KQH4yfwUlspQJ
	 slg3r1p5uDdSlBXb279V0E90HtioxFlLuxnCkvGmd7gFKR2b8D9pG3qOaOspriaZDq
	 854RgJi0VeIvyIE50U2+SVuJCvEiUq1Hggv1GUjj2fLaRlKEr1lqMm6SCtqb66PJqi
	 NAstyGk8NbVFFq3RjQaRnbkB9oS9Fw1Llyo4F181BcjvP3k1TzfUwF7nTJkGQqto5r
	 nMXlLrtmo/ByTmhdEv10m5xKXA3k1fWatueEBVFXLwJy/uiUub0mvJuIolW1vDoedB
	 4UsAkU9/mcX1Q==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/6] sched_ext: Remove sched_class->switch_class()
Date: Tue,  3 Sep 2024 22:03:08 -1000
Message-ID: <20240904080326.1132275-7-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904080326.1132275-1-tj@kernel.org>
References: <20240904080326.1132275-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With sched_ext converted to use put_prev_task() for class switch detection,
there's no user of switch_class() left. Drop it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c  | 12 +-----------
 kernel/sched/sched.h |  2 --
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 91bedf5d9f89..df56301bfa97 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5965,22 +5965,12 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	for_each_active_class(class) {
 		if (class->pick_next_task) {
 			p = class->pick_next_task(rq, prev);
-			if (p) {
-				const struct sched_class *prev_class = prev->sched_class;
-
-				if (class != prev_class && prev_class->switch_class)
-					prev_class->switch_class(rq, p);
+			if (p)
 				return p;
-			}
 		} else {
 			p = class->pick_task(rq);
 			if (p) {
-				const struct sched_class *prev_class = prev->sched_class;
-
 				put_prev_set_next_task(rq, prev, p);
-
-				if (class != prev_class && prev_class->switch_class)
-					prev_class->switch_class(rq, p);
 				return p;
 			}
 		}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 477e7a861d10..73ba0cfe4226 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2385,8 +2385,6 @@ struct sched_class {
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct task_struct *next);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
 
-	void (*switch_class)(struct rq *rq, struct task_struct *next);
-
 #ifdef CONFIG_SMP
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);
 
-- 
2.46.0


