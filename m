Return-Path: <linux-kernel+bounces-331169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 215C197A955
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79542860F7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50625166315;
	Mon, 16 Sep 2024 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXc2sdfO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59FA14D452
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726526981; cv=none; b=Q1UG5XRgCHXw5o0WeW/ubwSeaFbZOd9d4AFfqMrTzXjdvlThMZ8J58/Qc8H7LRHhzvrA6u1FVQHaWXkLh+hKkZ2X3QBwQ5sStNnb0gAP36MKkRr7UCjwCMwsliKnAG3rswD63X8Ct3g4aWpKhYBC9HZa1i+4pHq1o8Da/6+Ek7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726526981; c=relaxed/simple;
	bh=FNDnC4NnSKXZi0fBd7+r+3GeRTH7g/FrYIGmJ7rL3+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8kKVEbsmmdRHTgIgqAS5qsXBWvHebG9ClznQ2uXKleEc0xfiGxGXhIulei/taBtob2X5uh0p+OLV/nwFsgjHv1clIePRTNX8KLUjq+Z2Juju4km8X0z5Tnzr0iD9zAgZx4RwVt0tmlxKuHPAD28xLplY6gBOEXyiSJSqajFwCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXc2sdfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA680C4CEC4;
	Mon, 16 Sep 2024 22:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726526981;
	bh=FNDnC4NnSKXZi0fBd7+r+3GeRTH7g/FrYIGmJ7rL3+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EXc2sdfOE6qiBM9xDTexN8GiPSpGHxEhcLHvbtvwkQynNgQBg+c+xqiq+NSFLFt48
	 b989d78UnoKKgI+TpgHG/reZoFCMXh2hrA18ZprVjpUGns34Esx1QQp6qKjw4SL60A
	 xpnWZp40LlmxGl2u1LLm5qzQDN755Q9QS4uoE1kFihbA4Pt2esTWb6nRmWuQI7IQTk
	 iBqcJl49hTysgS7LRJElQUs3s+Z6+l3ZCW8Ef5xaZJKfJgyLaRcJu46HNaRxnPo9ms
	 xpSIJoJcI4pk68PN7R0Eo0CUSdp2j8jwrIcpi7pds+9q42TpkSVWH8mW2W/Wxuy3Mg
	 lt6eA15iUNSaQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 03/19] firmware: stratix10-svc: Use kthread_run_on_cpu()
Date: Tue, 17 Sep 2024 00:49:07 +0200
Message-ID: <20240916224925.20540-4-frederic@kernel.org>
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


