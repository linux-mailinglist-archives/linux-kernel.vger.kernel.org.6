Return-Path: <linux-kernel+bounces-278211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999BB94AD85
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549E32824E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6453137903;
	Wed,  7 Aug 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzBWgCMa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156411369AA
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046562; cv=none; b=nv8/I97fDfdU06kL8UZ/tBILIcyn53UY9ZrsDTsaqyrH/NPE9q06xFJyjfBLBWtSup9dGi8r+fh8eg+BOU16Wc1utiD1j8q0IIS2wF641N4MQO6QwTWa3Zt92x+wrpYZB3T0Sd0XU9/Jqs9846Dkww7AxfA/Lm9I3vWeTMAbcIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046562; c=relaxed/simple;
	bh=XJLOQaKXEoWZZ3EpAMdxxdBt/6PlHqDp/TaZaQ4iKag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTyy7ekjbwd0+IkvfSYRgJaJGPLNz8S+ZEK6Iigyejw2/WCxlxLDH4y2rO6LWUAAlSG4PB9UAr8ByflFuuNKcruIkXRj1kO4D9dMPJBv3V1UbRovv2R64bpfTv/CgllvUKvsS5tHSn1fR09HL4yLEFFdiSptkIs/zvYsIb5zyh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzBWgCMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE907C4AF0E;
	Wed,  7 Aug 2024 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723046561;
	bh=XJLOQaKXEoWZZ3EpAMdxxdBt/6PlHqDp/TaZaQ4iKag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uzBWgCMadGLAhjdhdjo9rQFyp89GkSQQPkhbenkJ2Ut9VytdXvHbE8DwjZmkruk2N
	 WUM86oa5GJe4r/yZg5qL7um+MyyCaXmCFIRIdx0Vw1MR9phfzlA2EssmLDYULZp0HJ
	 NBH54CRvWCmrTdcX1MvAu/oexmxITN9Pxwb/rKvSWKQimQlk4dTl0jUCRItMuorUin
	 1z2OyYesJxOikp9yTD0+BkxF6Q8OE6WTMNMNi00Eca8Rh6cuxw8IbhAv3n46/PyvQP
	 ZEExDe6tjZ8jT4oLWab1b4ycIYJebf+doAS9iB7YTMmN5M7Z48UBVhiDMee1wgy04N
	 gtD7zH+ciYB3Q==
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
Date: Wed,  7 Aug 2024 18:02:07 +0200
Message-ID: <20240807160228.26206-2-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807160228.26206-1-frederic@kernel.org>
References: <20240807160228.26206-1-frederic@kernel.org>
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
2.45.2


