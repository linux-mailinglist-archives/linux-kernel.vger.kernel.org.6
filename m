Return-Path: <linux-kernel+bounces-406019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBBD9C5BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4D5B38DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B051FF02B;
	Tue, 12 Nov 2024 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULzm8T5c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAEB1FEFD1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421381; cv=none; b=CS4bcadod/7S6EpReDLxwsPprqBcv4sP4THeok+5R82F0JLegw/XUuJ6pf4fuPyPt4C/mRffSLXzUq842kvJoDIbjp0OT/wgL2u+vCyO37BaVVyj63upKjKoEIfm9CQAKX3GvNmZOtm/abXLa8QqWLkfMU+pvHuAwxdCD+uXCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421381; c=relaxed/simple;
	bh=FNDnC4NnSKXZi0fBd7+r+3GeRTH7g/FrYIGmJ7rL3+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SX7mco9d//iOuVqXRHveKgsuKKW/aEUJi+1PLdFALQtFB+ozqH+O6nrsA52MjsiWfxZO7hY9OxdMXiq/99QImau1yzNbuDUJ92QP7Ed+1adndV92SdT+r/CxInGuj6LN/qUD/XcgaY/1aRGwZJdh/lspFUtxLEJ/SY3gnfOf9QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULzm8T5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1402C4CED6;
	Tue, 12 Nov 2024 14:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731421381;
	bh=FNDnC4NnSKXZi0fBd7+r+3GeRTH7g/FrYIGmJ7rL3+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ULzm8T5cGqCLmzZeHNVliWAIvGK4hZRt5Sub0bM470s72RzUShFfZY8A4DZULL5Fz
	 3VjTvSn+1kM5/vRlQQ5KXJpoG0lcAFWIDfpdvoQ2xCSlSm4UP+mIXheKSyniMiQIjx
	 7QgLeo4V7saVSR67mi+ywZs9SYQF/rSDjt9BrGb/rhEQo37o6hq7w3lXcbGXMw/3Bs
	 tubLPsPrfQ1ZpnUY5WKSiRsTFeGgH3kIvQC/2E7xZikAalJw4azcG9YZmVH4+MPIEU
	 0+et0aGgoLEf5Yb5E+KBk2evE/c0s89WauyHbKt/qKd26gq6FUyjDblylX0aqQzXvd
	 4BzwYYzk7jxGg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 03/21] firmware: stratix10-svc: Use kthread_run_on_cpu()
Date: Tue, 12 Nov 2024 15:22:27 +0100
Message-ID: <20241112142248.20503-4-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112142248.20503-1-frederic@kernel.org>
References: <20241112142248.20503-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the proper API instead of open coding it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/firmware/stratix10-svc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 528f37417aea..4cf5bd5647a4 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -967,18 +967,15 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 	/* first client will create kernel thread */
 	if (!chan->ctrl->task) {
 		chan->ctrl->task =
-			kthread_create_on_node(svc_normal_to_secure_thread,
-					      (void *)chan->ctrl,
-					      cpu_to_node(cpu),
-					      "svc_smc_hvc_thread");
+			kthread_run_on_cpu(svc_normal_to_secure_thread,
+					   (void *)chan->ctrl,
+					   cpu, "svc_smc_hvc_thread");
 			if (IS_ERR(chan->ctrl->task)) {
 				dev_err(chan->ctrl->dev,
 					"failed to create svc_smc_hvc_thread\n");
 				kfree(p_data);
 				return -EINVAL;
 			}
-		kthread_bind(chan->ctrl->task, cpu);
-		wake_up_process(chan->ctrl->task);
 	}
 
 	pr_debug("%s: sent P-va=%p, P-com=%x, P-size=%u\n", __func__,
-- 
2.46.0


