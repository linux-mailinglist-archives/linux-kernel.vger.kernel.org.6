Return-Path: <linux-kernel+bounces-238415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB59924A29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B70B23D28
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC11205E28;
	Tue,  2 Jul 2024 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qclkqh+r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09E9201251;
	Tue,  2 Jul 2024 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957233; cv=none; b=OyHseoD43SEHYvjnOuOrz6FZIJMn0k9gAChuKRJRlhTwVS1NFLZvmp+KZPrZq0G8ER81c8e9tiuzhESYpQzXuDnrW1PgbLZTYlFucBSNxGftkr/dkpXrh5pjt3MdOufg/oohvRPdetvtu6fVeCygnEZLu2EY12zlQmt1a+keJs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957233; c=relaxed/simple;
	bh=GqDySciOdh/ZJElVyIAI2o7yiirNNf3pmGDgtOq+X14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kp+krcGKNUF0ZwBpMfzQucmw4XNI7Qgl4l5mPwPiFouMkhxbeZPRzqjubdJHMVZ8smZjs5zMFS+wvMeo+z9Nzc8rgO4lpm9b5/FctXAMq6vFwFw3jN/eToqK4GuGWRUqHLf3A5U4In8SISlvOQUDaEJIhvLgvBCSZ+SDNH1K7qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qclkqh+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442F0C116B1;
	Tue,  2 Jul 2024 21:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719957233;
	bh=GqDySciOdh/ZJElVyIAI2o7yiirNNf3pmGDgtOq+X14=;
	h=From:To:Cc:Subject:Date:From;
	b=qclkqh+rAt79YIeB7M7kocCWMG34x1+6R2Wc+RnBarWfpgh5+V7i9D0kMQY+27Yc0
	 nfOjc9zqA0cKx6MSUzvhgPMNRX62nhhu79u6ef7LFymlb9YYATXPRthReqvlA4fCdD
	 2pFAJxFmm+jqOAt80Ot/r0DMkOc6Zkx59GrFROIlFflUIzCz3MyNWwYpXc9LWzwROi
	 VJqUAZjpT5dtqk4XVpgmm6LWvXR6S8ZkSjRgloQuJyzPQappU1gVyuASaG4DKlCswG
	 yhFrIRgHI/4rVH3gVeMqd7EbXzvwh5YH+O6ar+c+IdjdN/buH7F08Kc/pDcUqDe49+
	 XgJUsb6CBnojA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: PCM6240: Use of_property_read_reg()
Date: Tue,  2 Jul 2024 15:53:49 -0600
Message-ID: <20240702215349.839350-1-robh@kernel.org>
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
 sound/soc/codecs/pcm6240.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/pcm6240.c b/sound/soc/codecs/pcm6240.c
index 86e126783a1d..4a6019ee3d83 100644
--- a/sound/soc/codecs/pcm6240.c
+++ b/sound/soc/codecs/pcm6240.c
@@ -18,6 +18,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of_irq.h>
+#include <linux/of_address.h>
 #include <linux/regmap.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -2081,10 +2082,6 @@ static int pcmdevice_i2c_probe(struct i2c_client *i2c)
 	struct device_node *np;
 	unsigned int dev_addrs[PCMDEVICE_MAX_I2C_DEVICES];
 	int ret = 0, i = 0, ndev = 0;
-#ifdef CONFIG_OF
-	const __be32 *reg, *reg_end;
-	int len, sw, aw;
-#endif
 
 	pcm_dev = devm_kzalloc(&i2c->dev, sizeof(*pcm_dev), GFP_KERNEL);
 	if (!pcm_dev) {
@@ -2120,27 +2117,19 @@ static int pcmdevice_i2c_probe(struct i2c_client *i2c)
 	i2c_set_clientdata(i2c, pcm_dev);
 	mutex_init(&pcm_dev->codec_lock);
 	np = pcm_dev->dev->of_node;
-#ifdef CONFIG_OF
-	aw = of_n_addr_cells(np);
-	sw = of_n_size_cells(np);
-	if (sw == 0) {
-		reg = (const __be32 *)of_get_property(np,
-			"reg", &len);
-		reg_end = reg + len/sizeof(*reg);
-		ndev = 0;
-		do {
-			dev_addrs[ndev] = of_read_number(reg, aw);
-			reg += aw;
-			ndev++;
-		} while (reg < reg_end);
+
+	if (IS_ENABLED(CONFIG_OF)) {
+		u64 addr;
+
+		for (i = 0; i < PCMDEVICE_MAX_I2C_DEVICES; i++) {
+			if (of_property_read_reg(np, i, &addr, NULL))
+				break;
+			dev_addrs[ndev++] = addr;
+		}
 	} else {
 		ndev = 1;
 		dev_addrs[0] = i2c->addr;
 	}
-#else
-	ndev = 1;
-	dev_addrs[0] = i2c->addr;
-#endif
 	pcm_dev->irq_info.gpio = of_irq_get(np, 0);
 
 	for (i = 0; i < ndev; i++)
-- 
2.43.0


