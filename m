Return-Path: <linux-kernel+bounces-536055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A954FA47B04
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D691891C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E697522A4F3;
	Thu, 27 Feb 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QhrhG1MN"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914901DC997
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653904; cv=none; b=HPRhjsl91y9r+2DAkaazhFvbpHCt4nypI1EspSJ+Z/+azHmyb3AnHrx5g9rd6m8TA40/KG6IxXZu/ZBvIH5izatx10EkVEnb49AAPPWNs0sqqVddD6njfjk/P/qwhdKYZgyg0eCUn1zUbcDhfrmf0FPashD9xgR504pQxHi4o6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653904; c=relaxed/simple;
	bh=teTDa3liTei2AdNqaa9IqgRmnKDfj0qKFfTebiwSFag=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S2sm2zmjskrWJIID2CMb5+VHlzM7ZY0+Z/eyi9byIWPkfpUKUQCaqVudeWysoBauwJMgZ28BTXvwDtPXKghX5FYwhqa8rp1xsXRngdSN/U6ERy8H0y4ukAu6fBWphvd1nhMomz1WPpGcSZGIOM7gLszAKpjN4fHHLm/XmX++Dzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QhrhG1MN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740653903; x=1772189903;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=teTDa3liTei2AdNqaa9IqgRmnKDfj0qKFfTebiwSFag=;
  b=QhrhG1MNfXqM0BrH9/XB+Pg10P9SYp4w0HbvfV1uEkBcN4w4EOlTW36n
   w0F7qg0YweAt235spcpx0ry4K5Rvgog60Oiu+jTHbYkU5ppS42IOgf1nF
   SdcdjAl6NZ2qKCfzl9nDh6br6tcNkOwVrGULFQoR2xTYPZZIdIKJ9ious
   SlkDScLF6kqh9uavzvZokDYzk0Ba0CDmCgUKoHWDN+i2Z92vu/qnQSQnN
   s61eBAG0lO9EhAUSuQnHA0RwLPrJAF/PCJE4oNpDkRucdfIhY+es6M9QS
   Yhh/lWaH4sVlh741hIM40aaUUC3nog620qLAGn65kj4iAIsOjbna+Ho42
   w==;
X-CSE-ConnectionGUID: JWjrnE6DQtWZk0nVbJYONA==
X-CSE-MsgGUID: JCcOmOIfRpqgToz9BX0Zsw==
X-IronPort-AV: E=Sophos;i="6.13,319,1732604400"; 
   d="scan'208";a="269594456"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2025 03:58:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Feb 2025 03:58:12 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 27 Feb 2025 03:58:10 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <p.zabel@pengutronix.de>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<herve.codina@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v4] reset: mchp: sparx5: Fix for lan966x
Date: Thu, 27 Feb 2025 11:55:02 +0100
Message-ID: <20250227105502.25125-1-horatiu.vultur@microchip.com>
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
this with devm_ioremap, this seems to fix the issue as we use the same
region also for other devices.

Fixes: 0426a920d6269c ("reset: mchp: sparx5: Map cpu-syscon locally in case of LAN966x")
Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
v3->v4:
- update commit message to match the actual changes
- add comment explaining why we can't use devm_of_iomap
v2->v3:
- forward error from of_address_to_resource
- use devm_ioremap instead of_iomap
v1->v2:
- make sure to use iounmap when driver is removed
---
 drivers/reset/reset-microchip-sparx5.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index aa5464be7053b..6d3e75b33260e 100644
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
@@ -72,14 +73,22 @@ static struct regmap *mchp_lan966x_syscon_to_regmap(struct device *dev,
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
+	/* It is not possible to use devm_of_iomap because this resource is
+	 * shared with other drivers.
+	 */
+	base = devm_ioremap(dev, res.start, resource_size(&res));
+	if (!base)
+		return ERR_PTR(-ENOMEM);
 
-	regmap_config.max_register = size - 4;
+	regmap_config.max_register =  resource_size(&res) - 4;
 
 	return devm_regmap_init_mmio(dev, base, &regmap_config);
 }
-- 
2.34.1


