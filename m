Return-Path: <linux-kernel+bounces-213942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41526907CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3C20B26495
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C2C14D712;
	Thu, 13 Jun 2024 19:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fPRCophs"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C1714C59A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307722; cv=none; b=gY9a6GvH6yCuDSB9FH0EzDuw/LLktX1JnKsLXpSEVPMBl3FtKWom69b5HJ64+WYTWvc+NgcsLrQMX5nypt8M8jCi1gST2LxBqKElRaIt9rR9GkV5Cl1lX8jtiLolokcDnzrle3mmwA4zYBDpaGqOh89i99FBL5ThppFE0uw6otc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307722; c=relaxed/simple;
	bh=XAZMt9N0NCglaqew8dSYutoepiDFHTvY9wdHf9ybtaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=odawNCo48RUHW3YlWoDIG6DRhq6NbRH/bjSjwQe82gG5KP34XuWekx8ygVA7MLWvohoemb48Dty2crq2eIiI4d3C2UYeiVsjwpaYwBQky9Yeape6FG3pRzPFU0ErW70d4x5ofoXZbbxCuvl86dYREYLns+35gfmGq6gYjuIIVyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fPRCophs; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from Monstersaurus.local (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1A9E2675;
	Thu, 13 Jun 2024 21:41:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718307704;
	bh=XAZMt9N0NCglaqew8dSYutoepiDFHTvY9wdHf9ybtaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fPRCophsCkL/oJokmlFr3G1tmx1YfRvarY1fKLc6go9/IO43NxaSWvcUDfAVgaKmC
	 FnMs0BeA70P0XsBxkmBzb1WBBAbyf66Ri7U4acX8fll9sORbQbJJxF7JJNjbsNTXqL
	 W7lQyOl3ceJajuufSI6wD6q/56Zamqmd+/hhG/sY=
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
To: Umang Jain <umang.jain@ideasonboard.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.org>,
	detule <ogjoneski@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] staging: vc04_services: vchiq_arm: Fix initialisation check
Date: Thu, 13 Jun 2024 20:41:46 +0100
Message-Id: <20240613194150.2915202-2-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613194150.2915202-1-kieran.bingham@ideasonboard.com>
References: <20240613194150.2915202-1-kieran.bingham@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vchiq_state used to be obtained through an accessor
which would validate that the VCHIQ had been initialised
correctly with the remote.

In commit 42a2f6664e18 ("staging: vc04_services: Move global g_state to
vchiq_state") the global state was moved to the vchiq_mgnt structures
stored as a vchiq instance specific context. This conversion removed the
helpers and instead replaced users of this helper with the assumption
that the state is always available and the remote connected.

Fix this broken assumption by re-introducing the logic that was lost
during the conversion.

Fixes: 42a2f6664e18 ("staging: vc04_services: Move global g_state to vchiq_state")
Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 4 ++--
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h | 5 +++++
 .../staging/vc04_services/interface/vchiq_arm/vchiq_dev.c  | 7 ++++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 54467be8c371..67d853f5f2a0 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -804,7 +804,7 @@ int vchiq_initialise(struct vchiq_state *state, struct vchiq_instance **instance
 	 * block forever.
 	 */
 	for (i = 0; i < VCHIQ_INIT_RETRIES; i++) {
-		if (state)
+		if (vchiq_remote_initialised(state))
 			break;
 		usleep_range(500, 600);
 	}
@@ -1299,7 +1299,7 @@ void vchiq_dump_platform_instances(struct vchiq_state *state, struct seq_file *f
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
index 3c63347d2d08..8c4830df1070 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -1170,6 +1170,11 @@ static int vchiq_open(struct inode *inode, struct file *file)
 
 	dev_dbg(state->dev, "arm: vchiq open\n");
 
+	if (!vchiq_remote_initialised(state)) {
+		dev_err(state->dev, "arm: vchiq has no connection to VideoCore\n");
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


