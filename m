Return-Path: <linux-kernel+bounces-441544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1959ED005
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303AD28413B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE811D8A0B;
	Wed, 11 Dec 2024 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbuHLX6V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374311D6DB9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931645; cv=none; b=pxqveBMX3t8NzErGZKOQh8YfogBhfqmykejceJuGHrZf+gppqg9SyMh4naS2+jIL8mngR308MWQo4NyUJ6hpp11YLsXE7856UD+/ui1SaEwiQJqchQ7mKpEYWg2HPK/cEJYsFYHBaFyMB0gEpkjY/h04LKMN4f63lLzLwJyCOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931645; c=relaxed/simple;
	bh=K7AFaGyko0Nvc0J0jeAtHpBPtPp/vAo75gKUuVvNPu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNOdML7Dltt1wfH8em/0aRjKIXf5aaSBaYiPwBc+ujZt6q+Wm43NEc+SqZGmQjUWzwEr9vwaz0wiA1+GH/vC2cdV1TP1NsJ0/dj+T5O/EGQar9zg9c2kinvrk8dwKI2zZPg87eWOphV71LIuTIZMrzZYGDbdaJlWWRdc0Xwi9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbuHLX6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFCCC4CED4;
	Wed, 11 Dec 2024 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931644;
	bh=K7AFaGyko0Nvc0J0jeAtHpBPtPp/vAo75gKUuVvNPu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TbuHLX6Vc0+Ymd4qKep/+3xB4as9v+AiyTd3BDajUoQXjWK0Gi1Ow1BthfDFrmheh
	 lntR6Nvw/yglXBJjPvFnyq+3G83MzYTrxPs2Krbm9yJ5iEUKV1Lr7k0LpNfbaX9qYd
	 FIJ0NFN4OlA+P0U3Oia/q+AGFGpx8LU+a8zpChSaWqdyQFG79gD1QKSgMfmnCZ5OwA
	 hY1tZkj1qz2ggSX90+AgvdijJXP2sEZg9xeuYhIPOwEZhmg1TBE1BR8u8Qpf2H/xDc
	 V1FX3OHYASClQN5wmmmwASJ8yAkSA7yYuPrp7FG6oHegKHeSsd3x4Lr/NISfEL5qRD
	 kjKHpfnhSZvqw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 02/19] firmware: stratix10-svc: Use kthread_run_on_cpu()
Date: Wed, 11 Dec 2024 16:40:15 +0100
Message-ID: <20241211154035.75565-3-frederic@kernel.org>
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

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/firmware/stratix10-svc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index c5c78b869561..3c52cb73237a 100644
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


