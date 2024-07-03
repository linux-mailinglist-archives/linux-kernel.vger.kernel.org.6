Return-Path: <linux-kernel+bounces-239485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E733B9260BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BDE1C22488
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B2717A589;
	Wed,  3 Jul 2024 12:44:05 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B5217966F;
	Wed,  3 Jul 2024 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010644; cv=none; b=qz+x0zCVlKoBDK0VMiHd6sNxC3BjFlOrEzG32wDYcJLKsJlLfwoFf1sCLMQsUpz9Z1robKDhMPBXOYIKnZ9SEskHBeX9tJeKZCqajV5KY5PhlrEcmjgl7N5OyoH7aTscRALpV4aFykgPvjwreOziTcYljm7ThYc4VSPxyGWu9og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010644; c=relaxed/simple;
	bh=DW33uEh7lbKDEp+99mSXUnjmv+I8Iz/14mbPiuQxcHE=;
	h=From:To:Subject:Date:Message-Id; b=uwmjkeW7HXo6vUXj0oSLRd0kAQ14tWJimy8V7HD30jdvAVK9c8w8ORr6BahCuXjmT2ZuSjM0wQmqN5ac89l1Y0Ix24699y4xy29d0GjxpfslqJ5m+uSWEJmMEum9ODFyduSy/XOdXuLnzKh/aT0zPmCpHLCwXfTW6pE403wlN54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3EC53200B6D;
	Wed,  3 Jul 2024 14:44:01 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 05F45200AD5;
	Wed,  3 Jul 2024 14:44:01 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 765F9180226C;
	Wed,  3 Jul 2024 20:43:59 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	ckeepax@opensource.cirrus.com,
	andriy.shevchenko@linux.intel.com,
	heiko@sntech.de,
	robh@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: [PATCH] ASoC: ak4458: remove "reset-gpios" property handler
Date: Wed,  3 Jul 2024 20:26:15 +0800
Message-Id: <1720009575-11677-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

commit c721f189e89c0 ("reset: Instantiate reset GPIO controller for
shared reset-gpios") check if there is no "resets" property
will fallback to "reset-gpios".

So don't need to handle "reset-gpios" separately in the driver,
the "reset-gpios" handler is duplicated with "resets" control handler,
remove it.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/ak4458.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 32cb802ad635..d472d9952628 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -45,7 +45,6 @@ struct ak4458_priv {
 	const struct ak4458_drvdata *drvdata;
 	struct device *dev;
 	struct regmap *regmap;
-	struct gpio_desc *reset_gpiod;
 	struct reset_control *reset;
 	struct gpio_desc *mute_gpiod;
 	int digfil;	/* SSLOW, SD, SLOW bits */
@@ -631,10 +630,7 @@ static struct snd_soc_dai_driver ak4497_dai = {
 
 static void ak4458_reset(struct ak4458_priv *ak4458, bool active)
 {
-	if (ak4458->reset_gpiod) {
-		gpiod_set_value_cansleep(ak4458->reset_gpiod, active);
-		usleep_range(1000, 2000);
-	} else if (!IS_ERR_OR_NULL(ak4458->reset)) {
+	if (!IS_ERR_OR_NULL(ak4458->reset)) {
 		if (active)
 			reset_control_assert(ak4458->reset);
 		else
@@ -758,11 +754,6 @@ static int ak4458_i2c_probe(struct i2c_client *i2c)
 	if (IS_ERR(ak4458->reset))
 		return PTR_ERR(ak4458->reset);
 
-	ak4458->reset_gpiod = devm_gpiod_get_optional(ak4458->dev, "reset",
-						      GPIOD_OUT_LOW);
-	if (IS_ERR(ak4458->reset_gpiod))
-		return PTR_ERR(ak4458->reset_gpiod);
-
 	ak4458->mute_gpiod = devm_gpiod_get_optional(ak4458->dev, "mute",
 						     GPIOD_OUT_LOW);
 	if (IS_ERR(ak4458->mute_gpiod))
-- 
2.34.1


