Return-Path: <linux-kernel+bounces-223603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 201D5911570
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76DA2845AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BFC130ADA;
	Thu, 20 Jun 2024 22:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="oFxHduq6"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C4D39856
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921455; cv=none; b=n8fFZyNQi7tXN4DGSwoUiU5wyo068IiD0Nk70eIoec+ic22p5253aEoF5WjiZkwwAmPTqEPDn366TX4N1/CCMykJY3HQ7VDSxMpmPDvKNCLJghvK5JJxO/GaK0NvCZ3mPVoetgUvOID9bzyhe0bsOJms4vUg0Ksav31EaWDhNQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921455; c=relaxed/simple;
	bh=NDe1t69bQjF5wXikbN+OjRjQ1Lrwn+Df1AKfDsfwvxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VpGSZoB09jZIeoiZf4J/vatDw1dKZMQtoy3IqKNY+yS87z93rorcYU4evHVUoCglNIiWRDhmd8xFF5d38f+KLPHMMl8vDxMt+gLsGRjyffPAvabsggv4RdkTi13tLMLuifjbBDlup9fQSSM56fX+H79MiwWv+fN+tu7GlZBj9tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=oFxHduq6; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from Monstersaurus.local (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 954943E6;
	Fri, 21 Jun 2024 00:10:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718921432;
	bh=NDe1t69bQjF5wXikbN+OjRjQ1Lrwn+Df1AKfDsfwvxQ=;
	h=From:To:Cc:Subject:Date:From;
	b=oFxHduq68IIllLHaxXLNuY0UcE4sx6hUibNArOvt7lL4h8gkSRPeGGmyAgH0VcI/j
	 j4MMVDvcDsX+0oaKV/llBZ0d3+Nmir4uvOgfDU0nop2+4IE1vGoN2PzGv49CfLwHqf
	 B+E5qtunHnbszERCFuao/zBwnIyL+nWTzBkUUZ+Q=
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
To: Umang Jain <umang.jain@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] staging: vc04_services: vchiq_arm: Fix initialisation check
Date: Thu, 20 Jun 2024 23:10:42 +0100
Message-Id: <20240620221046.2731704-1-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vchiq_state used to be obtained through an accessor which would
validate that the VCHIQ had been initialised correctly with the remote,
or return a null state.

In commit 42a2f6664e18 ("staging: vc04_services: Move global g_state to
vchiq_state") the global state was moved to the vchiq_mgnt structures
stored as a vchiq instance specific context. This conversion removed the
helpers and instead replaced users of this helper with the assumption
that the state is always available and the remote connected.

The conversion does ensure that the state is always available, so some
remaining state null pointer checks that remain are unnecessary, but the
assumption that the remote is present and initialised is incorrect.

Fix this broken assumption by re-introducing the logic that was lost
during the conversion.

Fixes: 42a2f6664e18 ("staging: vc04_services: Move global g_state to vchiq_state")
Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

---
v2:
 - Just a resend

v3:
 - Downgrade vchiq_open() error path print to dbg
 - Clarify commit message about unnecessary state checks.

 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 4 ++--
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h | 5 +++++
 .../staging/vc04_services/interface/vchiq_arm/vchiq_dev.c  | 7 ++++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 69daeba974f2..5f518e5a9273 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -707,7 +707,7 @@ int vchiq_initialise(struct vchiq_state *state, struct vchiq_instance **instance
 	 * block forever.
 	 */
 	for (i = 0; i < VCHIQ_INIT_RETRIES; i++) {
-		if (state)
+		if (vchiq_remote_initialised(state))
 			break;
 		usleep_range(500, 600);
 	}
@@ -1202,7 +1202,7 @@ void vchiq_dump_platform_instances(struct vchiq_state *state, struct seq_file *f
 {
 	int i;
 
-	if (!state)
+	if (!vchiq_remote_initialised(state))
 		return;
 
 	/*
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 8af209e34fb2..382ec08f6a14 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -413,6 +413,11 @@ struct vchiq_state {
 	struct opaque_platform_state *platform_state;
 };
 
+static inline bool vchiq_remote_initialised(const struct vchiq_state *state)
+{
+	return state->remote && state->remote->initialised;
+}
+
 struct bulk_waiter {
 	struct vchiq_bulk *bulk;
 	struct completion event;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 67ba9ceaad3e..9cd2a64dce5e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -1170,6 +1170,11 @@ static int vchiq_open(struct inode *inode, struct file *file)
 
 	dev_dbg(state->dev, "arm: vchiq open\n");
 
+	if (!vchiq_remote_initialised(state)) {
+		dev_dbg(state->dev, "arm: vchiq has no connection to VideoCore\n");
+		return -ENOTCONN;
+	}
+
 	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
 	if (!instance)
 		return -ENOMEM;
@@ -1200,7 +1205,7 @@ static int vchiq_release(struct inode *inode, struct file *file)
 
 	dev_dbg(state->dev, "arm: instance=%p\n", instance);
 
-	if (!state) {
+	if (!vchiq_remote_initialised(state)) {
 		ret = -EPERM;
 		goto out;
 	}
-- 
2.34.1


