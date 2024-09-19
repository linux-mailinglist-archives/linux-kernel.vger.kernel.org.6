Return-Path: <linux-kernel+bounces-333574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F49497CAE4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4574E2856C5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E7219FA9F;
	Thu, 19 Sep 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="L9rbX6Hs"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D068D19E7E2
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755709; cv=none; b=A5abT3toQpgMG+fmY/BB0nXJ0T53ZUEGTSA1t+wqeBKdc6+zmB1JKQV9W3BQIuaT2DdDjGtkVALZZd/lHKw6uygSNVLFLHj33II5neggI+VblI1n/knMQlbb5lpsrdPI55k5SF+xlCKzvLqRG4F89yEZDCUd1hyX5Uwmo+k0pfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755709; c=relaxed/simple;
	bh=yalx1iY3oUr63A3ECojFRU4frdF6VGfKWcHOLLSVRb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLR1E/MZsxGLLWB2AtvNbcGTXmSgVWiRT8j4TbyvtejZCCL6pMO38J1IRTNxqOaixIN0xY/FkSIb+LlW1DG/xwunqimXgcQfjkJietqn9O5w+JEhniPOpj6llh6SB6KlnJy29m7Q+4aEia0j1qP5KSsFU0O1e95iF4sSxUbPRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=L9rbX6Hs; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9C80777F;
	Thu, 19 Sep 2024 16:20:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1726755622;
	bh=yalx1iY3oUr63A3ECojFRU4frdF6VGfKWcHOLLSVRb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L9rbX6HsQSCs5eTsBYl4j0x16yH8t/ltanwAqe673aZnUzC/KrhKefpr0gZivxdUB
	 6eIaYJYuAFJmNmmfx7ZuAv0cL2etOCnfXHB2chpi8UAK8XsbjSJqlSY+nqTfI47eyY
	 P81RU6Ww4UaoCugAHu1cZTTwaNdZ3KfuLIwlS1Rs=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 1/3] staging: vchiq_core: Move remote_event_signal() vchiq_core
Date: Thu, 19 Sep 2024 19:51:28 +0530
Message-ID: <20240919142130.1331495-2-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240919142130.1331495-1-umang.jain@ideasonboard.com>
References: <20240919142130.1331495-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function remote_event_signal() is declared in vchiq_core.h while
defined in vchiq_arm.c and used only in vchiq_core.c. Move the
definition to vchiq_core.c as it is only used in this file.

Also convert it to static and drop the function signature from
vchiq_core.h header. BELL2 doorbell macro is also moved from vchiq_arm
to vchiq_core as part of this change.

No functional changes intended in this patch.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 19 ----------------
 .../interface/vchiq_arm/vchiq_core.c          | 22 +++++++++++++++++++
 .../interface/vchiq_arm/vchiq_core.h          |  2 --
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index c44b4dc79c03..8e9a5c67a6de 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -48,7 +48,6 @@
 #define VCHIQ_PLATFORM_FRAGMENTS_COUNT_IDX  1
 
 #define BELL0	0x00
-#define BELL2	0x08
 
 #define ARM_DS_ACTIVE	BIT(2)
 
@@ -616,24 +615,6 @@ static struct vchiq_arm_state *vchiq_platform_get_arm_state(struct vchiq_state *
 	return (struct vchiq_arm_state *)state->platform_state;
 }
 
-void
-remote_event_signal(struct vchiq_state *state, struct remote_event *event)
-{
-	struct vchiq_drv_mgmt *mgmt = dev_get_drvdata(state->dev);
-
-	/*
-	 * Ensure that all writes to shared data structures have completed
-	 * before signalling the peer.
-	 */
-	wmb();
-
-	event->fired = 1;
-
-	dsb(sy);         /* data barrier operation */
-
-	if (event->armed)
-		writel(0, mgmt->regs + BELL2); /* trigger vc interrupt */
-}
 
 int
 vchiq_prepare_bulk_data(struct vchiq_instance *instance, struct vchiq_bulk *bulk, void *offset,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 7ad43a3d1bab..88d510c6793a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -5,6 +5,7 @@
 #include <linux/completion.h>
 #include <linux/mutex.h>
 #include <linux/bitops.h>
+#include <linux/io.h>
 #include <linux/kthread.h>
 #include <linux/wait.h>
 #include <linux/delay.h>
@@ -61,6 +62,8 @@
 #define MAKE_REMOTE_USE			(VCHIQ_MSG_REMOTE_USE << TYPE_SHIFT)
 #define MAKE_REMOTE_USE_ACTIVE		(VCHIQ_MSG_REMOTE_USE_ACTIVE << TYPE_SHIFT)
 
+#define BELL2	0x08
+
 /* Ensure the fields are wide enough */
 static_assert(VCHIQ_MSG_SRCPORT(VCHIQ_MAKE_MSG(0, 0, VCHIQ_PORT_MAX))
 	== 0);
@@ -526,6 +529,25 @@ remote_event_wait(wait_queue_head_t *wq, struct remote_event *event)
 	return ret;
 }
 
+static void
+remote_event_signal(struct vchiq_state *state, struct remote_event *event)
+{
+	struct vchiq_drv_mgmt *mgmt = dev_get_drvdata(state->dev);
+
+	/*
+	 * Ensure that all writes to shared data structures have completed
+	 * before signalling the peer.
+	 */
+	wmb();
+
+	event->fired = 1;
+
+	dsb(sy);         /* data barrier operation */
+
+	if (event->armed)
+		writel(0, mgmt->regs + BELL2); /* trigger vc interrupt */
+}
+
 /*
  * Acknowledge that the event has been signalled, and wake any waiters. Usually
  * called as a result of the doorbell being rung.
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 5bf543dfc9c7..32b0521aa036 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -534,8 +534,6 @@ int vchiq_prepare_bulk_data(struct vchiq_instance *instance, struct vchiq_bulk *
 
 void vchiq_complete_bulk(struct vchiq_instance *instance, struct vchiq_bulk *bulk);
 
-void remote_event_signal(struct vchiq_state *state, struct remote_event *event);
-
 void vchiq_dump_platform_state(struct seq_file *f);
 
 void vchiq_dump_platform_instances(struct vchiq_state *state, struct seq_file *f);
-- 
2.45.2


