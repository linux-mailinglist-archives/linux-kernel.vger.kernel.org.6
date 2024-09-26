Return-Path: <linux-kernel+bounces-341086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACD3987B3F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB18F1C22CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E4D1B07AD;
	Thu, 26 Sep 2024 22:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIgaUP7Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327AB1AFB2E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727390963; cv=none; b=EnYsESc39qSQPRHHHHw+IiR+AaA6hKOOxXJrSzlLaY2aq5+pjVPLY0vYd3oAiuftOVYcPbqUvYus63neYW6hSeaVT/rDibs5m75XAnQHPrZQ0LBKRLae4jEZYMwLNX0ochk0f9C4YgZcfP3oQrAAPepA+IlouYVqj/M1XPJ79p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727390963; c=relaxed/simple;
	bh=FNDnC4NnSKXZi0fBd7+r+3GeRTH7g/FrYIGmJ7rL3+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0LDP9Oorrpaa4i+c3+8kYJ5CkitCvyD6NaC33Y+YiEqb3X02OmxP6k0e332L4TPZK7am+7YicARYMC48YS7tFomid1nieuEh7jFP7cIukqsSnBR4XCTdZBDH73RJZ1hU4BAns0g7s2PEMfuO0Uf3SU6e+V1+aCl6Ipuk2N7x/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIgaUP7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E56DC4CED0;
	Thu, 26 Sep 2024 22:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727390962;
	bh=FNDnC4NnSKXZi0fBd7+r+3GeRTH7g/FrYIGmJ7rL3+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iIgaUP7ZzM8sluTdnxV7RYe/ra6qR89+gIe5xvdzIBmOA7Ptx5nPeBif7FlVpMPll
	 //FVrVnuYmTYKCuFbiJqGnW/p5fjJr6XbM7KTBIYE4UHUoe8gEtcxXso1LgaWGUwmb
	 bsdd4XYdUDrIxTACL/C9PVLaeBn819oDZBvRePz7UMQiogrISjUL6wLFOKU9GVQ35x
	 JUmE9dijH610yl21BqWm+Of7mDzLNxPMQoCloyvmXaoTnfIOBS/HHk8gbghFn48dcZ
	 A8FGoFJ3MJ0EfFMUQfakDvW+o5CU0VaInu2XxBMgB8LgTTT5XSOzFZ9VLzO5HdpaNW
	 TM89+HgtBAkpw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 03/20] firmware: stratix10-svc: Use kthread_run_on_cpu()
Date: Fri, 27 Sep 2024 00:48:51 +0200
Message-ID: <20240926224910.11106-4-frederic@kernel.org>
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


