Return-Path: <linux-kernel+bounces-231914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A872C91A047
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2041C21257
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801D24CE05;
	Thu, 27 Jun 2024 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dp8y2dzf"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444FD48CC7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472751; cv=none; b=BsR2RZi50UuLuLJ03d9VSDGKiC4iJVSE1oVYo/QjRbTLJ6ZD5fHGEVuB10zbazpO/CsjnYQ9aaFp+ulvMkUBnk6YUI6mbPI2LMcQjyPbHLeQqVIWpfbO/xOkJ6tEa6gDz44E/kiCghXGg2dbYHybytXcqpzG8bviqQ4fCfj0Mt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472751; c=relaxed/simple;
	bh=cnAIdvlXwQ/j9YRKWonoChw7ab4J4a6MgAZ2Iwg+Jwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hA80bQeB4lPs7c0b4CYFkN7i4SBVgNH1buRr2vSfUj/LscSrL1eiDbe+fxTNqNbvG0X/QMQG8vRz3bpwHMv4BdQN+cxYw06H478zHR9Ptc4yLqEN15y2c+yytQa8HPDCOqKM4vdS98bE+0O3WlmrT0WY/AOpQHIeQ8RuujG7Zm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Dp8y2dzf; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70671ecd334so3798272b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 00:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719472749; x=1720077549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KOw0F8v0grJ8IuAnZTAplm9tXQhwzs0nBcu+ZgyxR4o=;
        b=Dp8y2dzfCdwCH7dvn7QHUlGGueafQiBNaMIX8OrEBMR0M8h+Rv4YclW5D+L5xtI/hZ
         U8GDxlThzF/X1G5O1FxxWLGwHvECslU3g2AglM76Fn//G8t+M6mSDHj5gQLxOjx/momi
         SXUFhMO3OuaWGTWT1tFmKVlF9Lz66Z7tcaL60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719472749; x=1720077549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOw0F8v0grJ8IuAnZTAplm9tXQhwzs0nBcu+ZgyxR4o=;
        b=tM6BF3b6C9J6djwNIUuPFsaWdAIEgJKRAiiZiwuUo8uik6ysocOS/8Ar+a1BgJBaac
         ZpzTVbgg/A9Y156BLOIfD3IuyPvtGLEzksz0kStLa6kRJOFl75SnajqOSYsTDrHr5QpH
         EJLJAOFqaTkYEkazd1aVaiWzG3x1dvLh9AOMFv5+2G6JrIQwca2OwJIkKNfMjZ0WgCnv
         bs7aa4Sn5u/GwivLQgUIu/Ssa+OlvGDw3BnK5wMDZER9qjFl5ZiO97RkgXNx+3olo/TW
         jODfzPSvqABM546R6WpaC069LVFzzy5tiPOZVs7kqo563Noe+qgONkU5ar5UROTssFJy
         Z69A==
X-Forwarded-Encrypted: i=1; AJvYcCVk8yT62BuFE43Gp5didj4XvmqjCB8VlW05zD/7gPXoA8M4h6ZTaNHpNqS+3S/icHK4a35PTqODvalQUSCPUAoExh7+BtrDWePGYjFH
X-Gm-Message-State: AOJu0YyBLaSu/qP68PC3cUzzfAqG44v8m71OOeraFM0oD2y/dHFXVYXP
	P1MLf4lAb/mGIjJuNsg7leCxX3EJQwF41XNHw2EbwjehHS4HBdLOzp5YoFyAR33Vr7D+SF8GPdB
	k4YUZ
X-Google-Smtp-Source: AGHT+IHlncdv9HVyQDeNK4Vd2L7zyyqyfpKGaNI4AodY8XUtdLlWupV4oLXPzaYsiCtGoG1CGijcxA==
X-Received: by 2002:a05:6a20:3d86:b0:1b5:d477:fcd5 with SMTP id adf61e73a8af0-1bcf44a7d6emr16341274637.25.1719472749434;
        Thu, 27 Jun 2024 00:19:09 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c8c3:6aca:70ce:49d9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8fe9ecdc8sm718653a91.29.2024.06.27.00.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:19:09 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2] drm/mipi-dsi: Add OF notifier handler
Date: Thu, 27 Jun 2024 15:19:03 +0800
Message-ID: <20240627071904.4017160-1-wenst@chromium.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add OF notifier handler needed for creating/destroying MIPI DSI devices
according to dynamic runtime changes in the DT live tree. This code is
enabled when CONFIG_OF_DYNAMIC is selected.

This is based on existing code for I2C and SPI subsystems.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Added stub mipi_dsi_of_notifier in CONFIG_OF=n section for compilation

 drivers/gpu/drm/drm_mipi_dsi.c | 68 +++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index a471c46f5ca6..35d6ed1fb587 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -118,6 +118,7 @@ static void mipi_dsi_dev_release(struct device *dev)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
 
+	of_node_clear_flag(dev->of_node, OF_POPULATED);
 	of_node_put(dev->of_node);
 	kfree(dsi);
 }
@@ -158,6 +159,7 @@ static struct mipi_dsi_device *
 of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
 {
 	struct mipi_dsi_device_info info = { };
+	struct mipi_dsi_device *device;
 	int ret;
 	u32 reg;
 
@@ -175,10 +177,72 @@ of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
 
 	info.channel = reg;
 	info.node = of_node_get(node);
+	of_node_set_flag(node, OF_POPULATED);
 
-	return mipi_dsi_device_register_full(host, &info);
+	device = mipi_dsi_device_register_full(host, &info);
+	if (IS_ERR(device))
+		of_node_clear_flag(node, OF_POPULATED);
+
+	return device;
 }
+
+#if IS_ENABLED(CONFIG_OF_DYNAMIC)
+static int of_mipi_dsi_notify(struct notifier_block *nb, unsigned long action, void *arg)
+{
+	struct of_reconfig_data *rd = arg;
+	struct mipi_dsi_host *host;
+	struct mipi_dsi_device *device;
+
+	switch (of_reconfig_get_state_change(action, rd)) {
+	case OF_RECONFIG_CHANGE_ADD:
+		host = of_find_mipi_dsi_host_by_node(rd->dn->parent);
+		if (!host)
+			return NOTIFY_OK;	/* not for us */
+
+		if (of_node_test_and_set_flag(rd->dn, OF_POPULATED))
+			return NOTIFY_OK;
+
+		/*
+		 * Clear the flag before adding the device so that fw_devlink
+		 * doesn't skip adding consumers to this device.
+		 */
+		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
+		device = of_mipi_dsi_device_add(host, rd->dn);
+		if (IS_ERR(device)) {
+			dev_err(host->dev, "failed to create device for '%pOF'\n", rd->dn);
+			of_node_clear_flag(rd->dn, OF_POPULATED);
+			return notifier_from_errno(PTR_ERR(device));
+		}
+		break;
+	case OF_RECONFIG_CHANGE_REMOVE:
+		/* already depopulated? */
+		if (!of_node_check_flag(rd->dn, OF_POPULATED))
+			return NOTIFY_OK;
+
+		/* find our device by node */
+		device = of_find_mipi_dsi_device_by_node(rd->dn);
+		if (!device)
+			return NOTIFY_OK;	/* no? not meant for us */
+
+		/* unregister takes one ref away */
+		mipi_dsi_device_unregister(device);
+
+		/* and put the reference of the find */
+		put_device(&device->dev);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block mipi_dsi_of_notifier = {
+	.notifier_call = of_mipi_dsi_notify,
+};
+#else
+static struct notifier_block mipi_dsi_of_notifier __always_unused;
+#endif
 #else
+static struct notifier_block mipi_dsi_of_notifier __always_unused;
 static struct mipi_dsi_device *
 of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
 {
@@ -1703,6 +1767,8 @@ EXPORT_SYMBOL(mipi_dsi_driver_unregister);
 
 static int __init mipi_dsi_bus_init(void)
 {
+	if (IS_ENABLED(CONFIG_OF_DYNAMIC))
+		WARN_ON(of_reconfig_notifier_register(&mipi_dsi_of_notifier));
 	return bus_register(&mipi_dsi_bus_type);
 }
 postcore_initcall(mipi_dsi_bus_init);
-- 
2.45.2.741.gdbec12cfda-goog


