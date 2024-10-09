Return-Path: <linux-kernel+bounces-357914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA6A9977B8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EBAA1C226C2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DB81E47CF;
	Wed,  9 Oct 2024 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Psj23Q/D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933591E32C6
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510259; cv=none; b=XzoCxY2q5Ddcys6AimfYFQOjMz0s6vSuQCGV2qZe258DZl+9xdPSZrkrs9QVf0q65+DIHWdNr5gqnPoABbqr2be9lUKXMW0ySR+wt98Jj5626evEJafqgdMFz2rvywgLgsopaBILMssOXF5ONvbGwzmiQ2gjNKF7Wg1tuz96utY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510259; c=relaxed/simple;
	bh=v2JslQ06rZanUgKLfcnqH5Oi2auWsfQe8Yql1FBbRhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMMEuqkrtmsUc2PEOpl0XiUbKSSonI4I+DFCikhkU/Q9RmBfnCISNqX4FL35e/4S0fMQ1WcKEebXUXpxhVNQ4AoACU+oOsgmRECSqN3nOK+AjU+F25MByrCCGIus6EuOi3AU5K/etDaJ9OmzP26dzw3+zgpa0uNgyTiKCgZYY9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Psj23Q/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09940C4CECE;
	Wed,  9 Oct 2024 21:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728510257;
	bh=v2JslQ06rZanUgKLfcnqH5Oi2auWsfQe8Yql1FBbRhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Psj23Q/D5sX+nQlE6bZClXSo9Kkydc37A6eFNB/nu4gMFRe6DbmWMIcSPa2XHtcY4
	 yQRDrT6xjSos+tBvQOTiQun66jUPbnwEG+0sVLidG6c4qBq9+KRk4rH/THs7+Ii231
	 SfpBRrBFlcWE3IyX8ZIedOQYymNQnbWE2gpknwvtvrH5JOgeracpSRnwXLgc/FrkyC
	 V6y+Cm4ahWdotey71nBRBg0b6zw5Vna5copk95Zz/o/pyhiDP4ibJJlcKMSVBB/cXu
	 JYKdo5z5evzRbgqRCSqrgn+mboZ5XTY2cUVH9FDTZx+XVx49kjqSRb89l50hYp4qd+
	 L/LgfwF9brmMQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/6] sched_ext: Move scx_buildin_idle_enabled check to scx_bpf_select_cpu_dfl()
Date: Wed,  9 Oct 2024 11:40:59 -1000
Message-ID: <20241009214411.681233-4-tj@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009214411.681233-1-tj@kernel.org>
References: <20241009214411.681233-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the sanity check from the inner function scx_select_cpu_dfl() to the
exported kfunc scx_bpf_select_cpu_dfl(). This doesn't cause behavior
differences and will allow using scx_select_cpu_dfl() in bypass mode
regardless of scx_builtin_idle_enabled.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7d2fa78ba0c9..1cae18000de1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3062,11 +3062,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 
 	*found = false;
 
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
-		return prev_cpu;
-	}
-
 	/*
 	 * If WAKE_SYNC, the waker's local DSQ is empty, and the system is
 	 * under utilized, wake up @p to the local DSQ of the waker. Checking
@@ -5870,16 +5865,21 @@ __bpf_kfunc_start_defs();
 __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				       u64 wake_flags, bool *is_idle)
 {
-	if (!scx_kf_allowed(SCX_KF_SELECT_CPU)) {
-		*is_idle = false;
-		return prev_cpu;
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		goto prev_cpu;
 	}
+
+	if (!scx_kf_allowed(SCX_KF_SELECT_CPU))
+		goto prev_cpu;
+
 #ifdef CONFIG_SMP
 	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle);
-#else
+#endif
+
+prev_cpu:
 	*is_idle = false;
 	return prev_cpu;
-#endif
 }
 
 __bpf_kfunc_end_defs();
-- 
2.46.2


