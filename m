Return-Path: <linux-kernel+bounces-341084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CD5987B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB10828763B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0E61B0119;
	Thu, 26 Sep 2024 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSRjgxaK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5F41B010C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727390958; cv=none; b=IXbx9v7l6zx4Vh+i4Xq1D+F0k7aBrVtXVBHFeqw/cCN/ZhxPqrZzqoTj7Nfgp2j1KYsCc35TTVP4eg+hKSMNJ+e9KpItGxloSvJhhlvIaPkWVUMyPeBBi6LhsnqPiHwp/4uHGskllX8rtRF/giWMQmHQ+JpoQr+8La0q3Aus0ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727390958; c=relaxed/simple;
	bh=0P3cw1hR9bRTtfA3GkNVPSqmTI3laEGRCvS0ucnfa+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQeVQY2n3vShbAtkh0Tiphx3zfX9JDdugdvgB2vt97XE3cSDZ0NUNUYABuo7gs4jJ3lt8NWNowQvQwc1v5x8vBteejqzG3cr9V9Dz4MO2IyF19m3ciI8a8kf1xm9qx568CQjH8KYIIdNhUV9RbRAL6iH0ZbZgzt7PuPXKuzQspw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSRjgxaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370C1C4CECE;
	Thu, 26 Sep 2024 22:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727390958;
	bh=0P3cw1hR9bRTtfA3GkNVPSqmTI3laEGRCvS0ucnfa+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CSRjgxaKBDq9huQ+NP2aSSsEPA4znsDF9fYKi49YQHnimwX6ef7noEMc3hgoh4447
	 RB21Nw0zRgwENDf2H8AQtWYmAA7ARhsEgxhZZNz8XmrFXtl91KGGX87ihKgXKKZMmR
	 mwX0c/TR/Z/I0LIgL9mcLOZfzYa3MfXGpyRmNRdD5Wzz+X30XLqJUl+zEnbLSOhc5Y
	 QoncazrS/qKejP96Akq7cQzDVRf4pM2mLMf0unlx6vXwttpuIN7lk8Kv+bCGXbQIye
	 1rFxnPTN9D8Wzimkbc4cY2By3ax614PPe4nTHEokLqg5uFbqG0hAP8YaJyedYNqvwH
	 nXxLIJTPR5PVQ==
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
Subject: [PATCH 01/20] arm/bL_switcher: Use kthread_run_on_cpu()
Date: Fri, 27 Sep 2024 00:48:49 +0200
Message-ID: <20240926224910.11106-2-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926224910.11106-1-frederic@kernel.org>
References: <20240926224910.11106-1-frederic@kernel.org>
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


