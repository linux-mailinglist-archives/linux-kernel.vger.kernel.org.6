Return-Path: <linux-kernel+bounces-534164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2BFA463AC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103133B601C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD220221F3C;
	Wed, 26 Feb 2025 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YFCzt2Kz"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CF622171E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581384; cv=none; b=HsXaPj4uJE1EyJYB4EBvcu/F5umUqXkMYgQG87LLnwGrnZKUjre6BD8+av/JxtMQjxw9xA6d2Yu95ElyfbkaF3SuQrW09DXTy+4b6U3KesyiDy/oAU9o8uSvwWbPN8+s1rn8kN+n6rfMJ6H9PYhN0ZIqz2nnHExcunodrmr7ruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581384; c=relaxed/simple;
	bh=AIZC9KG4Oy6b/fGWRZ0LAFqhcEEQuHGy4hYDeydpnjM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l5PfO/qzO5t1TdVLugf82geqeHkOz0LhnkDodhSf1WbsIohz1dxGJ18GaigCMnX1EtRk5/h8/lF2VPG8E9zMgVAbQfcg/7KpIAj3yPbi1j7zFpmim2NgDikOK6V9/TJ1P89IovSBavvu4c8eCmP3lAkRW6/cM+A3TWd7J5fqznI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YFCzt2Kz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740581382; x=1772117382;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AIZC9KG4Oy6b/fGWRZ0LAFqhcEEQuHGy4hYDeydpnjM=;
  b=YFCzt2Kzm9/teRXRcz4xDYL5cB41U1ZLCDBRwmLyvcH4NbyfN/qXBnh/
   wkKzQEFY+uCKtx4MjLd7pV0yqb9TMdUiilBKwBwE9gPNKN7EVk3W5jl/t
   7ilUcS1avCxyDIp+ooDAIbktHnJ0QKW/B2GNQvNGOwmopcSh5Mxl5lL2k
   d4KouiKztW8A8oYM7GkZWG86tXN93GZMCe6J3nCODj88Lx+ZLQDDxJRov
   ccneNW82npMZSnhYe44Ea63ySYO5IqzfyGNjMgbxb0Hpd1yfMIOIQXdXu
   MqNq2Z7I8AqZ3XdNppSnjyTAevVqmeOWFLxyxhB50va4EsDE5Mz11DZNC
   A==;
X-CSE-ConnectionGUID: 9VXBx6tySd6ERCH2/JYSYg==
X-CSE-MsgGUID: 0LV2LjD8T8KwiCqKNuNbOQ==
X-IronPort-AV: E=Sophos;i="6.13,317,1732604400"; 
   d="scan'208";a="42293617"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2025 07:49:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 26 Feb 2025 07:49:08 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 26 Feb 2025 07:49:07 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <p.zabel@pengutronix.de>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<herve.codina@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v3] reset: mchp: sparx5: Fix for lan966x
Date: Wed, 26 Feb 2025 15:46:45 +0100
Message-ID: <20250226144645.1950451-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

With the blamed commit it seems that lan966x doesn't seem to boot
anymore when the internal CPU is used.
The reason seems to be the usage of the devm_of_iomap, if we replace
this with of_iomap, this seems to fix the issue as we use the same
region also for other devices.

Fixes: 0426a920d6269c ("reset: mchp: sparx5: Map cpu-syscon locally in case of LAN966x")
Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
v2->v3:
- forward error from of_address_to_resource
- use devm_ioremap instead of_iomap
v1->v2:
- make sure to use iounmap when driver is removed
---
 drivers/reset/reset-microchip-sparx5.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index aa5464be7053b..176b3f46e9243 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -8,6 +8,7 @@
  */
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -72,14 +73,19 @@ static struct regmap *mchp_lan966x_syscon_to_regmap(struct device *dev,
 						    struct device_node *syscon_np)
 {
 	struct regmap_config regmap_config = mchp_lan966x_syscon_regmap_config;
-	resource_size_t size;
+	struct resource res;
 	void __iomem *base;
+	int err;
+
+	err = of_address_to_resource(syscon_np, 0, &res);
+	if (err)
+		return ERR_PTR(err);
 
-	base = devm_of_iomap(dev, syscon_np, 0, &size);
-	if (IS_ERR(base))
-		return ERR_CAST(base);
+	base = devm_ioremap(dev, res.start, resource_size(&res));
+	if (!base)
+		return ERR_PTR(-ENOMEM);
 
-	regmap_config.max_register = size - 4;
+	regmap_config.max_register =  resource_size(&res) - 4;
 
 	return devm_regmap_init_mmio(dev, base, &regmap_config);
 }
-- 
2.34.1


