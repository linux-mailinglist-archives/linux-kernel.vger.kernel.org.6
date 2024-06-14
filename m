Return-Path: <linux-kernel+bounces-214810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C0A908A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC681F21129
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D733A194ACB;
	Fri, 14 Jun 2024 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Mm+xjw2A"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A598A193091
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361839; cv=none; b=ZwrmeRflLtVa5mNFuBO8adT9eAxCjw596kDfv41djjLUzjuQRD6qloeWEvHuyDSb0EGGAcau8q0CameE0NYQxlxUqn9+3J1OjdCbn9N70ovKv/bKI5I/1JywUWcMPvEMLFJYBghYmSiRVvRCS+vFlsRY69hUfmqEIXjuJEXnDGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361839; c=relaxed/simple;
	bh=7PuP78ru6jiBfVBrYl1dVfoJwyFY0gSotJgrsbXkFAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LuXIZDQAdfsUmnv/D84JI6uoXbNEwlCK7kyTr5r9zgWcA573gml2FB5JULzL8wCItllA60CTkVaDUjUOqdppfD6NuZjkWakRoFf6f04mvmVHc0XaTGVOjrnsx8U1IivyJJY/nZEjsN2vW2FUMGBWM1OMMhu2i8NOaEAWsEkclc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Mm+xjw2A; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from Monstersaurus.local (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 92348B53;
	Fri, 14 Jun 2024 12:43:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718361820;
	bh=7PuP78ru6jiBfVBrYl1dVfoJwyFY0gSotJgrsbXkFAI=;
	h=From:To:Cc:Subject:Date:From;
	b=Mm+xjw2ApRB54+5k532l1+y03V7JRK0Go9F/0TpWBjPwdXuYQuxMr+JvElVoPlwMp
	 /y2T+QWmfil/MkJzh4tE+iNITBXadyAPbueDeq6CAcuMuJ41URZNrjfOs2FiCAqvOs
	 n/y3YM3W4K5cBqTgiN1PyG7syjC6T2qhC/35pp5g=
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
To: Umang Jain <umang.jain@ideasonboard.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.org>,
	detule <ogjoneski@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [v2 PATCH] staging: vc04_services: vchiq_arm: Fix initialisation check
Date: Fri, 14 Jun 2024 11:43:35 +0100
Message-Id: <20240614104339.3858830-1-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
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
v2:
 - No change, just resend

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


