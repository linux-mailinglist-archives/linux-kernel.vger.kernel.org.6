Return-Path: <linux-kernel+bounces-331167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C07297A952
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A4928BD52
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0250915DBDD;
	Mon, 16 Sep 2024 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGeYvanq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D9115B57C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726526976; cv=none; b=RUFxX+37n3wkjOCI4ravx7Bqnedlx3K/ayz0R5aNO5cf/VJ7USuXmeh3mrNU/jAwTo3nmxUYl4YPhMLXuzRgW8713b2JUZM5LSghmIgy8b3quds6Qrskec1+aLmiPwn+RJ6Bx4I/xoB321VUGuLmvEKUzb+KnthRFbkGAmpJp7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726526976; c=relaxed/simple;
	bh=0P3cw1hR9bRTtfA3GkNVPSqmTI3laEGRCvS0ucnfa+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrJVr9prQvm6hjEoali8khn4uK2m36x9foURAyX8l+32B8Oj6GspWTXN23jVbTtFxks2gCoZzfDZhd3LNa1lf4IxBMKXrfY6BEis6xcC2aHpAOZPQY7lqWAH7LPP0dXlca3Lcm3uKfMaWQ/BjxtfQS3mOvsDbIRppkZOpQ+lAJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGeYvanq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA79C4CEC5;
	Mon, 16 Sep 2024 22:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726526975;
	bh=0P3cw1hR9bRTtfA3GkNVPSqmTI3laEGRCvS0ucnfa+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eGeYvanql6Br+UdwFEhFyLgvO0ID7xr5o0ZW2NwP+6N0n7XpmiJZOgkmhOjZkI6Uj
	 YMBmJj1+6FM6ute8bBCSY4BTzFPsw+bq12Up6mxhrPNKPfqsnMeUMBoBan/qVYZ2XF
	 CmU9i0CmDKfgtBcjIKkYUnnnhW1YknTojcYzKAyo86D7+WaOGhEZXGWe4f69Tyskoz
	 WXQGsn+tyBKJUHPAELkAI8gNj4tQfrsvOFlVPdNxdJu+PGcNMwfJJGENS8CMfMEi0X
	 TDP09T+F5EV4RvY3+ou0CFJixTMqSK8pJTy6bROMUP02AqBMg9xDrExeL15Rg2GAox
	 lDOSXQKve1kWQ==
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
Date: Tue, 17 Sep 2024 00:49:05 +0200
Message-ID: <20240916224925.20540-2-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916224925.20540-1-frederic@kernel.org>
References: <20240916224925.20540-1-frederic@kernel.org>
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


