Return-Path: <linux-kernel+bounces-336238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AA697F0F6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF621F223D9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5BC1A2876;
	Mon, 23 Sep 2024 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COcN/ZZh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1F11974F4
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118035; cv=none; b=Rk0M8QOsPsF+Pyd4avRJ6hcgQHCA30MV/ka5CmzpfFjOX1da4wHkGWw70XEMDmx3aCHnntHrWu/htJDsFs5fNPAAN4bYwI1n7rXjsdqrcdyrKErynTPGm9l87ZdO0802vNapj/KhuZD9iUk8PNvrRaYKE4ylZC4Ai9hEC5xELbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118035; c=relaxed/simple;
	bh=lNBL5OYiJpvcnKfUa3RpueVyJhUTgz3pkJkPdWIAvlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Upt/FbrAFkEn8zDdlm4ZnYExN4akvrnpNcO+xkUvbr5p2lYlPGwhrC5Da42LYRL53yF+UjRdbM3oXKL5Z3dz2mSQojecoNglHlmsscGNIkG9q3MqfZ32HbWS4daKhaQMoWN5/t9f3EmBH0QoJWqrWohh/2MPvpSWvSU/UIa1Dug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COcN/ZZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F065CC4AF0B;
	Mon, 23 Sep 2024 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727118035;
	bh=lNBL5OYiJpvcnKfUa3RpueVyJhUTgz3pkJkPdWIAvlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=COcN/ZZhJmbdtfNEmeWmwcuxT6wpu/2pdsfpULo6imyt/PagGO45zy96TCVc2iWnj
	 jYs2vfnXf4vZrEsH2wcP8MeMfpV4WOa0oHLY7CjytwvJtA6tueaTA1O0sQhAkd5Qe0
	 s/5SHO/avLdJy771yjFPN1+93YIRGAwFvA2/lVLHOBt+8M/hAqreUoA77ONoV+TYGg
	 wfzxrGl+U8KQ9oEAcyjkSieR9WpPMlRC8n1NJryH+3Qz8HKWELKjeY9vzuRiaA7HV4
	 HyDVSnV2LBkbRlJvHNMx9e00iltFPHWdmJqNJm8QrLR2EY8u7MOPulArTASxGHV4Hb
	 9ilCPL6VgxFuw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	aboorvad@linux.ibm.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/8] sched_ext: Remove SCX_OPS_PREPPING
Date: Mon, 23 Sep 2024 08:59:29 -1000
Message-ID: <20240923190020.1446325-3-tj@kernel.org>
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

The distinction between SCX_OPS_PREPPING and SCX_OPS_ENABLING is not used
anywhere and only adds confusion. Drop SCX_OPS_PREPPING.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 95ed822fa563..2422b2abee6e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -778,7 +778,6 @@ enum scx_tg_flags {
 };
 
 enum scx_ops_enable_state {
-	SCX_OPS_PREPPING,
 	SCX_OPS_ENABLING,
 	SCX_OPS_ENABLED,
 	SCX_OPS_DISABLING,
@@ -786,7 +785,6 @@ enum scx_ops_enable_state {
 };
 
 static const char *scx_ops_enable_state_str[] = {
-	[SCX_OPS_PREPPING]	= "prepping",
 	[SCX_OPS_ENABLING]	= "enabling",
 	[SCX_OPS_ENABLED]	= "enabled",
 	[SCX_OPS_DISABLING]	= "disabling",
@@ -4971,12 +4969,12 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	}
 
 	/*
-	 * Set scx_ops, transition to PREPPING and clear exit info to arm the
+	 * Set scx_ops, transition to ENABLING and clear exit info to arm the
 	 * disable path. Failure triggers full disabling from here on.
 	 */
 	scx_ops = *ops;
 
-	WARN_ON_ONCE(scx_ops_set_enable_state(SCX_OPS_PREPPING) !=
+	WARN_ON_ONCE(scx_ops_set_enable_state(SCX_OPS_ENABLING) !=
 		     SCX_OPS_DISABLED);
 
 	atomic_set(&scx_exit_kind, SCX_EXIT_NONE);
@@ -5129,23 +5127,6 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 */
 	preempt_disable();
 
-	/*
-	 * From here on, the disable path must assume that tasks have ops
-	 * enabled and need to be recovered.
-	 *
-	 * Transition to ENABLING fails iff the BPF scheduler has already
-	 * triggered scx_bpf_error(). Returning an error code here would lose
-	 * the recorded error information. Exit indicating success so that the
-	 * error is notified through ops.exit() with all the details.
-	 */
-	if (!scx_ops_tryset_enable_state(SCX_OPS_ENABLING, SCX_OPS_PREPPING)) {
-		preempt_enable();
-		spin_unlock_irq(&scx_tasks_lock);
-		WARN_ON_ONCE(atomic_read(&scx_exit_kind) == SCX_EXIT_NONE);
-		ret = 0;
-		goto err_disable_unlock_all;
-	}
-
 	/*
 	 * We're fully committed and can't fail. The PREPPED -> ENABLED
 	 * transitions here are synchronized against sched_ext_free() through
@@ -5176,7 +5157,11 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	cpus_read_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 
-	/* see above ENABLING transition for the explanation on exiting with 0 */
+	/*
+	 * Returning an error code here would lose the recorded error
+	 * information. Exit indicating success so that the error is notified
+	 * through ops.exit() with all the details.
+	 */
 	if (!scx_ops_tryset_enable_state(SCX_OPS_ENABLED, SCX_OPS_ENABLING)) {
 		WARN_ON_ONCE(atomic_read(&scx_exit_kind) == SCX_EXIT_NONE);
 		ret = 0;
-- 
2.46.0


