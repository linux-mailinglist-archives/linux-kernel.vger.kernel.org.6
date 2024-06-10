Return-Path: <linux-kernel+bounces-208016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2742C901F63
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 651BEB29627
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6935E78C64;
	Mon, 10 Jun 2024 10:28:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE3115B3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718015294; cv=none; b=Cfj0/bV4XVbTr9oY/jN7azaw+N4ZeOLa+NzU88L0dJY47K1gipRG1aFjAlEI6FI+KlPf8r8ptEL9N58CyC9nSgiGNT3Co4KD92xREVeoUvL5Ktec9mh/9pUU84Azo5+InWcG9pB9N3fQhgw7Vl/EeiGNopa4GljgmMvQSCBiLjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718015294; c=relaxed/simple;
	bh=59vqSNo8efv80hHanD7EjByevBNH4rkg7/y6UCfmSng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nG8mODK/TUxOFHu2/FzI3MKjGZg35s/+0pyUGRisKs7nil6M8ExnMODn7+DvcRtNkdm7sm6rYNPYy+VqJDDLlvyCZPJJ5s/WkEsp2EUS153Waqo1EF367xD/mnTenWKwvhrSBzgpqXUn6o7yC5wGRai5RBhSZtFlpcDM9plCU3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D43D1688;
	Mon, 10 Jun 2024 03:28:36 -0700 (PDT)
Received: from e128090.cambridge.arm.com (unknown [10.1.198.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A54FC3F73B;
	Mon, 10 Jun 2024 03:28:09 -0700 (PDT)
From: Adam Miotk <adam.miotk@arm.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Adam Miotk <adam.miotk@arm.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Smitha T Murthy <smitha.tmurthy@arm.com>,
	Deepak Pandey <deepak.pandey@arm.com>
Subject: [PATCH] drm/bridge/panel: Fix runtime warning on panel bridge release
Date: Mon, 10 Jun 2024 11:27:39 +0100
Message-Id: <20240610102739.139852-1-adam.miotk@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device managed panel bridge wrappers are created by calling to
drm_panel_bridge_add_typed() and registering a release handler for
clean-up when the device gets unbound.

Since the memory for this bridge is also managed and linked to the panel
device, the release function should not try to free that memory.
Moreover, the call to devm_kfree() inside drm_panel_bridge_remove() will
fail in this case and emit a warning because the panel bridge resource
is no longer on the device resources list (it has been removed from
there before the call to release handlers).

Signed-off-by: Adam Miotk <adam.miotk@arm.com>
---
 drivers/gpu/drm/bridge/panel.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 32506524d9a2..fe5fb08c9fc4 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -360,9 +360,12 @@ EXPORT_SYMBOL(drm_panel_bridge_set_orientation);
 
 static void devm_drm_panel_bridge_release(struct device *dev, void *res)
 {
-	struct drm_bridge **bridge = res;
+	struct drm_bridge *bridge = *(struct drm_bridge **)res;
 
-	drm_panel_bridge_remove(*bridge);
+	if (!bridge)
+		return;
+
+	drm_bridge_remove(bridge);
 }
 
 /**
-- 
2.25.1


