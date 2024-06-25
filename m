Return-Path: <linux-kernel+bounces-228657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F24809164FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1111F21C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EA814A089;
	Tue, 25 Jun 2024 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kZG0NZvH"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22E713C90B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310106; cv=none; b=nFPi3PbynT3SWOj99C3CqXqSDarOaiQN7COXwQ1jeQ2DQws0eDHbIUlkALMtIGRDzSIKbUJ+KJ9P1kOTH6tX5L4VFydFWxIM/5Z3CO76DdMv2t/cBWtAja9aShHRz/S+Fg/XZBfP/GcMaO0DPZ9PrXaz60MiqZfViSB5bCjiqKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310106; c=relaxed/simple;
	bh=lPN1OjBWX/LKJ4yBO7CP8Nq5sjBDJHpLdacouSjVFWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SM3MZK1QGr0r8ry+sEuyqTrGbmuAY+ksga5kuBgMB1RuFA/Z/A6/2zo3Qsy7DDYMccAkVtyp15zgZwGhQ65I9SZTu1ZcU7pW/hOmmhx7axGx6gfd+oolLMw1LBmH2UojqU5pgjt431sKZyeMLNgTHXGw51rWTfhT7czAWiOQgWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kZG0NZvH; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2c72becd4fdso4150107a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719310104; x=1719914904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P0VI4tQBTmZ5EZUuvascNs7IsaJGTBT4lhzcT7XH/+M=;
        b=kZG0NZvHm/0MxqQb/E2Gagg2G0yGJXKcvV2TkAHQ1fq44Nl6PrxU05SdJnxXOX4MWL
         jWmB1HcELDtrHG60jTiyKCE0IhqQm0H6K1V6kCdTxY/C3lrAzV60AJQ8uw/WDYHGjsl5
         ss+S/2HCDCjM67gKykyYFG/aTi0NIk0tCL6EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719310104; x=1719914904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0VI4tQBTmZ5EZUuvascNs7IsaJGTBT4lhzcT7XH/+M=;
        b=C6hmY/sE78UTOjy8Va77x/HhM3IvaXe0soq5RRPTVuRRtDpl3tGo0l7A2Dq09Hhlht
         irpnNd0oIpWFhr51yE5D6EYRdgWywVOL9SdXUUCixfoFGIcM1nDF77/ROC2on7ml1mXP
         sldVJqWfsqcmMYDxwh8QPxMMMORFeYd7KmaOlAPstOwzK3elQIpdrAudP22IWfqWaaqL
         CJto7Lk46svrkUUQ0G5llydb4+yloSfoNIR4dxz0SeOgZAB1ARuXaesKeBblw5Dm2ue0
         Uq6rWnlCiXTT90t1TNlO9NuLP2W11hkNcBfJhFq5BucVq5fRCJCNhCVovUPzJDrj1r51
         0Kcg==
X-Forwarded-Encrypted: i=1; AJvYcCUamaut20xu4TCIIIYLUfpR2LZvvhzkN7EE07V9keS/UPeJU4xSgfCp6f5qJ/zTJQL2G4Ax+0KntsoyeOP6oN3UGFafudohWy9zVqP6
X-Gm-Message-State: AOJu0Yzqa7XlBOHhb+EWsUtGBRNVUM7saBgVd+uf4SwV/e1QiVr4vMGl
	b4MzZmjvWuNAHQacnCiJoR5pDejyWQys7C5ZD/HZ/Pzx85F5rJ4n/2M255JiKw==
X-Google-Smtp-Source: AGHT+IH5OdAV9csYNq1eqW1UaiZqOfB6WW6Pq0nAQiIUqAEOfTwBZ1zBKWpXAJ+WtCc4g8XzMAVHfQ==
X-Received: by 2002:a17:90a:398f:b0:2c7:c703:ef26 with SMTP id 98e67ed59e1d1-2c8613d5b2emr5468261a91.24.1719310103953;
        Tue, 25 Jun 2024 03:08:23 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:ea5a:67dd:bd1e:edef])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819dbb979sm8313305a91.46.2024.06.25.03.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 03:08:23 -0700 (PDT)
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
Subject: [PATCH] drm/mipi-dsi: Add OF notifier handler
Date: Tue, 25 Jun 2024 18:08:17 +0800
Message-ID: <20240625100818.3478242-1-wenst@chromium.org>
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
This is a patch I wrote for the ChromeOS SKU component prober [1]. That
series is still being worked on, but in the meantime I thought this
patch might be useful to Luca. Luca talked about a hot-pluggable
connector that has DSI at ELC earlier this year. If DT live tree
patching is used in this case, this patch could be needed.

[1] https://lore.kernel.org/linux-arm-kernel/20231109100606.1245545-1-wenst@chromium.org/

 drivers/gpu/drm/drm_mipi_dsi.c | 67 +++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index a471c46f5ca6..a47e8928db53 100644
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
 
@@ -175,9 +177,70 @@ of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
 
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
 static struct mipi_dsi_device *
 of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
@@ -1703,6 +1766,8 @@ EXPORT_SYMBOL(mipi_dsi_driver_unregister);
 
 static int __init mipi_dsi_bus_init(void)
 {
+	if (IS_ENABLED(CONFIG_OF_DYNAMIC))
+		WARN_ON(of_reconfig_notifier_register(&mipi_dsi_of_notifier));
 	return bus_register(&mipi_dsi_bus_type);
 }
 postcore_initcall(mipi_dsi_bus_init);
-- 
2.45.2.741.gdbec12cfda-goog


