Return-Path: <linux-kernel+bounces-414025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCCA9D21FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13438281F42
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619C919CCEA;
	Tue, 19 Nov 2024 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="N3fOHlB6"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9F1BDA8C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732006647; cv=none; b=CSNiZoIN1UpUSaFshnea/ehd98lYreJvfkgqH7ZQbjYdQ/mWq3PCp6rDX08820WKfbZ0TnZpWG1kW0duERVBI1JBACxEtkt8LLGlz8uOxcr1adeNLAGjgr7Am6KXTe0I2HH9ze+Wx7Le2xHd+3PVBagMsO9EP93qpuR5nKQ6SSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732006647; c=relaxed/simple;
	bh=V5vMXnZWhus7HTKBdOfYrSnVUw61kA/PumPgeGgBiJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aTHbGXnwVl2aCqmD7mJMQ+DZ4QhkIGmdQj1Mbr/8qPHIA/KXk6UBu3jsSOYB8Pze5DesAIwBGq8bpwY2pZ+fSd1ID8B0ckog1cns5auxWcl8nAy21cqduhI+5E4xD8P0NUmpBwoVJkv50PU1yvY1RdcDY/4Kudyw/mS+i5cdnvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=N3fOHlB6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so35994385e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 00:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1732006643; x=1732611443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ktw5vNNsoI0/xw8RwtG6vuFFJgPzM5I0SbeQQ++zF/8=;
        b=N3fOHlB625Pk0J/Y/pvsPeBWsW17hrQyIFoaB+NzmeycUhOVzTcczgxBAqrIaPsmTw
         Q7lV8pIO1suM8jfHebCoSEqrr+gTNvGUySShYJ5FHBnas0hZG+dGAwKclEzhwPSK8NP9
         dCCHeRz4T4QDoEBADLFd+V2xmhBmYokeyNJX29q+25fW/YCBUq8npN5Csi82bG43seW1
         jr4q4M2e2+OMABtOHsbGBdb4jEp9hd/QuOkZYcya7dGXbAjIgyW99PLDtX817w8QlbS5
         G1KEqL2tcM05Vc3hszCze1kP2HxTGNya+piDQOQIVIN9Eo0qpAmCzEsoJVdibvZ8GRQ8
         NPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732006643; x=1732611443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ktw5vNNsoI0/xw8RwtG6vuFFJgPzM5I0SbeQQ++zF/8=;
        b=LOAhnvzjTOhKzuSdjWt/gJp8FjQanfXkb/ZwTQHiQrYxHj5xQ/7efKSg/NR4SuVeQY
         VsKNLTsabNRLTzJbxzC0/q9ZoclKF3QpX4I68hmcUlP4GxKtXVexqnEZstEY7bIAxLOh
         ibG7Y/encMGF/NgJSTzLdKhESwxKyoKCsR5AV2NiAcMDzo9F0chyXPWz8ZqqBX8XKsGl
         0aHntvTmoiJanp6J2EtgS+XAbPpo0VWtPZWX39zDVj52STud975usZe+LwCaidLBicBA
         chVowreYDWjzaILjOJl/IVgAsbQigWv9YtBz9tqxMmzk6fun4FC1U5vH6fols4RPaw7l
         Bvbw==
X-Gm-Message-State: AOJu0Yw9smPDM8ttsr5n49NhRR+9wRPcUcM2c5jbe8/E1uGHOcsUE82u
	yo6ay74XX+no6jciFgcqTsfiJrwQTj1C6v/DMQHKvVNAdx7fAgSieKDA+JUJTkQ=
X-Google-Smtp-Source: AGHT+IGsT+xnuSDoaJBESxO6DKBNjndXUPz2NZsic5CdV3tGLLMFqSzHH5Ufo09yrJGRqJ1c8Vj7Gw==
X-Received: by 2002:adf:e186:0:b0:382:4867:2de5 with SMTP id ffacd0b85a97d-38248672fe2mr6850044f8f.35.1732006643478;
        Tue, 19 Nov 2024 00:57:23 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab80ad9sm182833005e9.25.2024.11.19.00.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 00:57:22 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: p.zabel@pengutronix.de,
	broonie@kernel.org,
	biju.das.jz@bp.renesas.com
Cc: linux-kernel@vger.kernel.org,
	jbrunet@baylibre.com,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] reset: rzg2l-usbphy-ctrl: Assign proper of node to the allocated device
Date: Tue, 19 Nov 2024 10:55:54 +0200
Message-Id: <20241119085554.1035881-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The platform device named "rzg2l-usb-vbus-regulator", allocated by
the rzg2l-usbphy-ctrl driver, is used to instantiate a regulator driver.
This regulator driver is associated with a device tree (DT) node, which
is a child of the rzg2l-usbphy-ctrl DT node. The regulator's DT node allows
consumer nodes to reference the regulator and configure the regulator as
needed.

Starting with commit cd7a38c40b23 ("regulator: core: do not silently ignore
provided init_data") the struct regulator_dev::dev::of_node is no longer
populated using of_node_get(config->of_node) if the regulator does not
provide init_data. Since the rzg2l-usb-vbus-regulator does not provide
init_data, this behaviour causes the of_find_regulator_by_node() function
to fails, resulting in errors when attempting to request the regulator.

To fix this issue, call device_set_of_node_from_dev() for the
"rzg2l-usb-vbus-regulator" platform device.

Fixes: 84fbd6198766 ("regulator: Add Renesas RZ/G2L USB VBUS regulator driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index 1cd157f4f03b..4e2ac1f0060c 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -176,6 +176,7 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
 	vdev->dev.parent = dev;
 	priv->vdev = vdev;
 
+	device_set_of_node_from_dev(&vdev->dev, dev);
 	error = platform_device_add(vdev);
 	if (error)
 		goto err_device_put;
-- 
2.39.2


