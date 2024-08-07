Return-Path: <linux-kernel+bounces-278213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D414A94AD87
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0781F234EE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6DF13B588;
	Wed,  7 Aug 2024 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdG9FrQF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1245213A87A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046567; cv=none; b=evpTfJj7S20Nkm6NzmyvNfI9/kZGO0CyoHAv3waSnQixU7yK+zhPcVdbCiqaFL8ZaSei0QBPGrEMZhpSZ2FnbAw6JnAHT+ivrjBBlu0k8rwO2xQzOBwwvZ+Hh6FSCMk10EjEK3dmRaouDWiOBWUS1dPq/T0LRDgfrVDiFTRkBa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046567; c=relaxed/simple;
	bh=xQm/Blenebln1H3o3tKc4fTJ6K2fC1fA3KMGh8EFNkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4PvhS7l0LYRflSP+McYr4A5WR99LefLRWah/Pp+RHLNh9RJM9tIa0EgGaeJt36ScS0xJW+IxJm0/s0YPR5ZDSTe7lhQxZtUe0Q90HlGrlFenJfRbbL/Irw8uzq6ynd0WelROlW7KsBvAE1aUHkstnxGCZEVQ7cqygiOkl7yCeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdG9FrQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A7AC4AF0B;
	Wed,  7 Aug 2024 16:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723046566;
	bh=xQm/Blenebln1H3o3tKc4fTJ6K2fC1fA3KMGh8EFNkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VdG9FrQF0uoBrsqFyhm5IOyoPEBD1Pg4Vu6fvkF50r7S7eeKwVRuvjhwsuTTtH9HX
	 EWlVrndSS9SlHkkxSe02B+j5M/nfnuud6PElbAlIsts3K501/QSqGqInCiHNEg/Mqd
	 2/BGBGX/w91wW8GEHAzH+GUv0dKyKoonFwkPHyvLTqCpvoySZiPk4IPcs5ZVkIpy2n
	 igpd74XFWgPX7RgMqhis+V30YvcsWg1zVTaRAcwM6qjUkIO0TFvdK3hJuKuGNNe8p9
	 UKpvtKKr3dlQ7OZG6EUdUJnzHPTmOhjQ8TTC3+qAyl14YBz+W5QIlqx94B334kp9Gx
	 2DAyUhQb1TVRQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 03/19] firmware: stratix10-svc: Use kthread_run_on_cpu()
Date: Wed,  7 Aug 2024 18:02:09 +0200
Message-ID: <20240807160228.26206-4-frederic@kernel.org>
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
2.45.2


