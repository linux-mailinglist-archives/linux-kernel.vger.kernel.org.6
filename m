Return-Path: <linux-kernel+bounces-263771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A1F93DA4C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2292827C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1591615444D;
	Fri, 26 Jul 2024 21:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1DOQbJa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C09153836
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031033; cv=none; b=hcD+xybnlA4djZbdhe1sauVItt6XRdufTWBaAHADbkEvlZmSsWAGZHjBu4Wc90WecobxlAdmniSG6wkRskgAlOMODBZEMLh/8uIupURUPAqNFqjaN3vT4/C4CzlwPazH1e7iU7dpj6QlBgZTf0b1MFLMgBerMU67UQJ+TKHXKTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031033; c=relaxed/simple;
	bh=xQm/Blenebln1H3o3tKc4fTJ6K2fC1fA3KMGh8EFNkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECYHGzJM0E9WLHuhO+lCNCj5DHr0/tRqrhqlGBo88NIGKWyHMeTbrczlEzR0GBR1X7msvliXVXN8uUZBR+inI9ytU9qBw0tIVxV2GTvUvYXqvHc8l4YSMwWRnwPZJY55neM9b/8Pi6mfYTN/okO3TRNd0Ok+oNmInnBMB67oixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1DOQbJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD62CC4AF09;
	Fri, 26 Jul 2024 21:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722031033;
	bh=xQm/Blenebln1H3o3tKc4fTJ6K2fC1fA3KMGh8EFNkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1DOQbJaZ756sFC42oFP2ciwft2vEyCQZhxZqfCUGZyexUUZpcrjkN4xHDYHoSv+Z
	 UZwZKKVr/JYg9pG2e/C/tKKAjUVNa8PVJTV4jadxhInPdIQUCZx2vygpTqPhWDL5St
	 +NWkU8Jawk2I4egagJDdVNp8nhAJKOq1EQDdsBkw+yxLyQGLBvgK6FWrEzZk4gFHEK
	 GcfuetUp9bUsvbz3ipFW3+QCd1fGMP/Ps4Nmjjo8foEsqqJiMLo96DaA+jztZPdEti
	 4oPLtqf4/O9hzsI3MAAVt+2SfjvslMDMy1JrCJUk+V82WlatkXXve+Y5jvyr2cx7QJ
	 QXx0mub+ZITMg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 03/20] firmware: stratix10-svc: Use kthread_run_on_cpu()
Date: Fri, 26 Jul 2024 23:56:39 +0200
Message-ID: <20240726215701.19459-4-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726215701.19459-1-frederic@kernel.org>
References: <20240726215701.19459-1-frederic@kernel.org>
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


