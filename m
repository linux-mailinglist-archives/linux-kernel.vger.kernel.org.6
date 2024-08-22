Return-Path: <linux-kernel+bounces-297526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F257195BA33
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCF01F21031
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954051CDFD1;
	Thu, 22 Aug 2024 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="biw6fs4F"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0907D1CDA37
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340510; cv=none; b=h1ESqEAkVvtaKt+ugMP6hhHgqLeyZytT68pjSVCkksnUQ188aC3TN7e9dsEmyhdnCTIeruC6D4vGPFAbuhmOq/YlCoE8OxYpKqcm7+5033sKbhQwOA3BA1T+0dCrwOWEhvKd+54lX7l9U+/P2jwylBYIF+JazXenDWdmjyfCbTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340510; c=relaxed/simple;
	bh=XrqcPTylVERKklChscjba3VfZJzY0R9/Nuua9/voHH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GK1IpPEE/HCaymqlhwAVS1cNDln+yEnAT1cGEKTsvvoSyr38nQ4lfCcMXXzUn9JIRkOe31ClGpH6eC8fCUBgES93nPLA52MKrq/P9UzPwV1aTrXL8f5K96QQfNSbUTfGb3q4sNSuH+lOvTX0nr7z034F3ixOWn0xV1sF8VJEwDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=biw6fs4F; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a866cea40c4so118540066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724340506; x=1724945306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgJzIoJ7odKtUR1tmJxpafPTYpDoiiIktLX51hzayU4=;
        b=biw6fs4FEJ9VTT0QKBWewO4YKyGNdebDHOlYUrgMTg8iOBHUSMU5Gmb7ecqjTIdyaK
         I7Ro0JkfBrfV5nKFDiGU/J0j9kmD3SFKkWJ73ydYo612bUdMTmEWqCV7I1627gYW9aim
         +BUa1jzThreIMURepC90llPIoN7eqrXtsuJYcWuDl1K3jSJEHbUZ2kUURun1i/MayD74
         WjWNbwka553pU9i/deR9XDEcnOr34ZiOgWYuEW/PmLtrmVrAWEdwDOFgzyNxa0RNyMae
         FD0rvjoJ1YKbx9PmMlF7EylOCXtBOC2eEUsHyvi4f9zoAAogZ1rpbwwKy79yy8y8DoEx
         Um7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724340506; x=1724945306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgJzIoJ7odKtUR1tmJxpafPTYpDoiiIktLX51hzayU4=;
        b=RR9NMwbm24WMe4HTXLYLf19IkK6rqFFhTxM3MyMRr37PCd1lRxa37EhAJx7i+6rhUk
         KWwzypmMTUHaOF0t1tL+SOO7/L11cxEwUBwvr0OSH0B7fC0V6RaCnyTtLFj3JTXxGFMx
         zMTdIx5vLF7VO8BNniHZsIvgOs+0yUNpe3JJPa26bBipQLqloEfHW7MZcSO7Ai+llFGc
         khLjR7Hv7MIqkNLftSf8UMZ4RGbFi0y0YJRmuVm/iHq3GsC3SO0U24Wmr+U7/dlEQ9rh
         ts7Ekp+sHTpS0rM5OW7e/kp6FRIRUQrsn8o1ptiwZblZA9C+yJP98KX9nLu1Kn1AFwPf
         SiBg==
X-Forwarded-Encrypted: i=1; AJvYcCVxrVeBU1GYccbHoYxUfzbfsMcs/5wypwv9ZUrEXz384Xemqt3n6I8igD+6i2oROLUunNsFult4ejKW/8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu14odx+2a3CGhYwM0b7e+/DgdzNKJ4Uv2oTKWYyQtRAGoA48Z
	xVLDVzjOQ9Utvy5OgVWOB7FHF7cfiNeT61yO8SDz/BMF6wa82fM1pCK4zbXHzT8=
X-Google-Smtp-Source: AGHT+IFeGPZpt21jhTv4W0bfHajPG9OGuBMYaiwjLe2EM/CfoluWSL4gm6uew0mp9CeRcXzWktBU8w==
X-Received: by 2002:a17:907:9688:b0:a86:7a23:1292 with SMTP id a640c23a62f3a-a867a23275amr475672566b.66.1724340506359;
        Thu, 22 Aug 2024 08:28:26 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f484dc5sm134189166b.171.2024.08.22.08.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 08:28:25 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	gregkh@linuxfoundation.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com,
	ulf.hansson@linaro.org
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 05/16] soc: renesas: sysc: Move RZ/G3S SoC detection on SYSC driver
Date: Thu, 22 Aug 2024 18:27:50 +0300
Message-Id: <20240822152801.602318-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Now that we have a driver for SYSC driver for RZ/G3S move the SoC detection
for RZ/G3S in SYSC driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/soc/renesas/renesas-soc.c | 12 ---------
 drivers/soc/renesas/rzg3s-sysc.c  | 45 +++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 172d59e6fbcf..425d9037dcd0 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -71,10 +71,6 @@ static const struct renesas_family fam_rzg2ul __initconst __maybe_unused = {
 	.name	= "RZ/G2UL",
 };
 
-static const struct renesas_family fam_rzg3s __initconst __maybe_unused = {
-	.name	= "RZ/G3S",
-};
-
 static const struct renesas_family fam_rzv2h __initconst __maybe_unused = {
 	.name	= "RZ/V2H",
 };
@@ -176,11 +172,6 @@ static const struct renesas_soc soc_rz_g2ul __initconst __maybe_unused = {
 	.id     = 0x8450447,
 };
 
-static const struct renesas_soc soc_rz_g3s __initconst __maybe_unused = {
-	.family = &fam_rzg3s,
-	.id	= 0x85e0447,
-};
-
 static const struct renesas_soc soc_rz_v2h __initconst __maybe_unused = {
 	.family = &fam_rzv2h,
 	.id     = 0x847a447,
@@ -410,9 +401,6 @@ static const struct of_device_id renesas_socs[] __initconst __maybe_unused = {
 #ifdef CONFIG_ARCH_R9A07G054
 	{ .compatible = "renesas,r9a07g054",	.data = &soc_rz_v2l },
 #endif
-#ifdef CONFIG_ARCH_R9A08G045
-	{ .compatible = "renesas,r9a08g045",	.data = &soc_rz_g3s },
-#endif
 #ifdef CONFIG_ARCH_R9A09G011
 	{ .compatible = "renesas,r9a09g011",	.data = &soc_rz_v2m },
 #endif
diff --git a/drivers/soc/renesas/rzg3s-sysc.c b/drivers/soc/renesas/rzg3s-sysc.c
index e664d29ce5c3..1dd48c7255d1 100644
--- a/drivers/soc/renesas/rzg3s-sysc.c
+++ b/drivers/soc/renesas/rzg3s-sysc.c
@@ -6,10 +6,16 @@
  */
 
 #include <linux/auxiliary_bus.h>
+#include <linux/io.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/sys_soc.h>
 
 #include <linux/soc/renesas/rzg3s-sysc-reset.h>
 
+#define RZG3S_SYS_LSI_DEVID		0xa04
+#define RZG3S_SYS_LSI_DEVID_REV		GENMASK(31, 28)
+
 /**
  * struct rzg3s_sysc - SYSC private data structure
  * @base: base address
@@ -71,8 +77,14 @@ static int rzg3s_sysc_reset_probe(struct rzg3s_sysc *sysc, const char *adev_name
 
 static int rzg3s_sysc_probe(struct platform_device *pdev)
 {
+	const char *soc_id_start, *soc_id_end, *compatible;
+	struct soc_device_attribute *soc_dev_attr;
 	struct device *dev = &pdev->dev;
+	struct soc_device *soc_dev;
 	struct rzg3s_sysc *sysc;
+	char soc_id[32] = {0};
+	u32 devid, revision;
+	u8 size;
 
 	sysc = devm_kzalloc(dev, sizeof(*sysc), GFP_KERNEL);
 	if (!sysc)
@@ -85,6 +97,39 @@ static int rzg3s_sysc_probe(struct platform_device *pdev)
 	sysc->dev = dev;
 	spin_lock_init(&sysc->lock);
 
+	compatible = of_get_property(dev->of_node, "compatible", NULL);
+	if (!compatible)
+		return -ENODEV;
+
+	soc_id_start = strchr(compatible, ',') + 1;
+	soc_id_end = strchr(compatible, '-');
+	size = soc_id_end - soc_id_start;
+	if (size > 32)
+		size = 32;
+	strscpy(soc_id, soc_id_start, size);
+
+	soc_dev_attr = devm_kzalloc(dev, sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->family = "RZ/G3S";
+	soc_dev_attr->soc_id = devm_kstrdup(dev, soc_id, GFP_KERNEL);
+	if (!soc_dev_attr->soc_id)
+		return -ENOMEM;
+
+	devid = readl(sysc->base + RZG3S_SYS_LSI_DEVID);
+	revision = FIELD_GET(RZG3S_SYS_LSI_DEVID_REV, devid);
+	soc_dev_attr->revision = devm_kasprintf(dev, GFP_KERNEL, "%u", revision);
+	if (!soc_dev_attr->revision)
+		return -ENOMEM;
+
+	dev_info(dev, "Detected Renesas %s %s Rev %s\n", soc_dev_attr->family,
+		 soc_dev_attr->soc_id, soc_dev_attr->revision);
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev))
+		return PTR_ERR(soc_dev);
+
 	return rzg3s_sysc_reset_probe(sysc, "reset", 0);
 }
 
-- 
2.39.2


