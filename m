Return-Path: <linux-kernel+bounces-238416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A591C924A2A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE031F2331E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC16205E11;
	Tue,  2 Jul 2024 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBQxZx52"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3761BD512;
	Tue,  2 Jul 2024 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957252; cv=none; b=lWFEJl4nsExN41DTTiJXBy3tMNRXKMIB4a6g3wTgqeviLdmrPfEyJeRAFIWtVcLkQWzcZnenlUiOm8BKyVOvCOvNMOFVJm/19oeJS9SRKnXF7X7OFZkzy1nUTxSeXR+CVwUEnC8vTUkATiMS/rpy9MMiiMF1HfqBRAvJmG9eDCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957252; c=relaxed/simple;
	bh=wtpmY7jbHLqaod6kPJD79ZoXCdRnLkrdjOGoR8rPK/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MEpOd7TpBr1s1nJPvUCzn+ek5z304jRcm9Af0ZoF/mwiblmHn6of4OM7KIMKH/095oHxvU2jF8NKqLhrcVKCvysxvB+aDrcwTIxcVAM5yESG2/FcKo4g4BSnqT/1Su3blr6jKltdnybA3wpnl+0fd3ZPj/DngTTayo4roRVCDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBQxZx52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1BBC116B1;
	Tue,  2 Jul 2024 21:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719957251;
	bh=wtpmY7jbHLqaod6kPJD79ZoXCdRnLkrdjOGoR8rPK/A=;
	h=From:To:Cc:Subject:Date:From;
	b=BBQxZx528FOCjH9Fcb22+wc/ah4DmulinHU+0BCmJGTtzJTNX8s5Kck4hl908QxX6
	 bgEVbtJn1FhtjCLGP9OZZt8KSaqtCymMkAEU0dXRnXeagg64cZABVGys/6uZwTABhk
	 r2+f81JsEGv8OaXAkh6Gj0fl/W1/jCehIexP9OCvLbel89Uhc2MTcr25sKtOvScHC8
	 7K9eKWPG3EzG3XfrIUSgm2gT7baNrn2UASTjylCun9PWUzIUQI1+dxEIJgJK2p1qhF
	 wJ/LiQm8xGyqliIXZIweBNd38JdE7W435lQ3IN9mhFunQxhUtk4uex4n99rY8SHYLu
	 69Lr5EBHT5F4w==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: tas2781: Use of_property_read_reg()
Date: Tue,  2 Jul 2024 15:54:01 -0600
Message-ID: <20240702215402.839673-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded parsing of "reg" with of_property_read_reg().
The #ifdef is also easily replaced with IS_ENABLED().

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 sound/soc/codecs/tas2781-i2c.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 9350972dfefe..746e6964bfb3 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
@@ -622,33 +623,20 @@ static void tasdevice_parse_dt(struct tasdevice_priv *tas_priv)
 
 		tas_priv->irq_info.irq_gpio =
 			acpi_dev_gpio_irq_get(ACPI_COMPANION(&client->dev), 0);
-	} else {
+	} else if (IS_ENABLED(CONFIG_OF)) {
 		struct device_node *np = tas_priv->dev->of_node;
-#ifdef CONFIG_OF
-		const __be32 *reg, *reg_end;
-		int len, sw, aw;
-
-		aw = of_n_addr_cells(np);
-		sw = of_n_size_cells(np);
-		if (sw == 0) {
-			reg = (const __be32 *)of_get_property(np,
-				"reg", &len);
-			reg_end = reg + len/sizeof(*reg);
-			ndev = 0;
-			do {
-				dev_addrs[ndev] = of_read_number(reg, aw);
-				reg += aw;
-				ndev++;
-			} while (reg < reg_end);
-		} else {
-			ndev = 1;
-			dev_addrs[0] = client->addr;
+		u64 addr;
+
+		for (i = 0; i < TASDEVICE_MAX_CHANNELS; i++) {
+			if (of_property_read_reg(np, i, &addr, NULL))
+				break;
+			dev_addrs[ndev++] = addr;
 		}
-#else
+
+		tas_priv->irq_info.irq_gpio = of_irq_get(np, 0);
+	} else {
 		ndev = 1;
 		dev_addrs[0] = client->addr;
-#endif
-		tas_priv->irq_info.irq_gpio = of_irq_get(np, 0);
 	}
 	tas_priv->ndev = ndev;
 	for (i = 0; i < ndev; i++)
-- 
2.43.0


