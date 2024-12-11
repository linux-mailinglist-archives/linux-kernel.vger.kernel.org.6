Return-Path: <linux-kernel+bounces-441543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F36BE9ED003
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5B41883B87
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7001D61A2;
	Wed, 11 Dec 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqquj51m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C331D3576
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931643; cv=none; b=bwMettgNI5JUv4a8XOgXRtsWMDBIjOwXtz3qbBS/lcxe8Vvjl+QgNzw0JT2K2b5NG1K/k1j/OC64POmIn8WLSE0e5QmoBsWwYP/Z98XBmv4hhnZhU6D/A8XQtx2MwgYrGBA50wx8M9lFeXB//16Vj14E/lfCi7+tFnm/cIpINCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931643; c=relaxed/simple;
	bh=0P3cw1hR9bRTtfA3GkNVPSqmTI3laEGRCvS0ucnfa+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtulB7CsQVbTR4qWy9DwLQ66vWf98d2m8MH+SC/Tdit2fop5/+sPtkVoR6MAYW//CHnMCQGju5U7v9wcNp9OMpP3IZVCwDcVafml6Hn4Kq8vmtInLBUz7lIhYGYh2CMHvHf6HqiULjTNmXhclVuIOpswZ2GqoGLG5Z38BhgEMgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqquj51m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B4DC4CED7;
	Wed, 11 Dec 2024 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931643;
	bh=0P3cw1hR9bRTtfA3GkNVPSqmTI3laEGRCvS0ucnfa+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zqquj51mU338XBIQhAtjN6dMBAJikxw/sXbeTopvXNY9c9eY9QrPmJzy2wyH8JIy2
	 TBk/XHvHPTaHzTu/N2BiWP4ZMY0A9oVBIMui4N6VcCMvQAn6CxCon7TTOnVotNhg2B
	 ArLaMZPYufYgmUVfIEg1s/CDIAh7GTlMgK9oex82rT4YAhcwcdPQem1ycZEfYvWxEF
	 mfNwpX8jCoff9vPIneBmKlZkizg0VH2gz174MXFCzhZM1knuSQSgR+9jKe7P/iUuQu
	 owPe3QVOXpnQaWWlpQbeNP1PTSm8lov8lyxOoKXbmzPF0SP2P0LpZ6ihOsvTz5tLWj
	 gPuh01jZhEOHg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Martin <Dave.Martin@arm.com>,
	Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 01/19] arm/bL_switcher: Use kthread_run_on_cpu()
Date: Wed, 11 Dec 2024 16:40:14 +0100
Message-ID: <20241211154035.75565-2-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241211154035.75565-1-frederic@kernel.org>
References: <20241211154035.75565-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the proper API instead of open coding it.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/arm/common/bL_switcher.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 9a9aa53547a6..d1e82a318e3b 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -307,13 +307,11 @@ static struct task_struct *bL_switcher_thread_create(int cpu, void *arg)
 {
 	struct task_struct *task;
 
-	task = kthread_create_on_node(bL_switcher_thread, arg,
-				      cpu_to_node(cpu), "kswitcher_%d", cpu);
-	if (!IS_ERR(task)) {
-		kthread_bind(task, cpu);
-		wake_up_process(task);
-	} else
+	task = kthread_run_on_cpu(bL_switcher_thread, arg,
+				  cpu, "kswitcher_%d");
+	if (IS_ERR(task))
 		pr_err("%s failed for CPU %d\n", __func__, cpu);
+
 	return task;
 }
 
-- 
2.46.0


