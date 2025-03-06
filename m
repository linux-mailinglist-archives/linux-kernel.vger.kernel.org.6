Return-Path: <linux-kernel+bounces-549469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F23A552F1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D90E77AB0B7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7528A25D522;
	Thu,  6 Mar 2025 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="3rtuLGp9"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B80269B12;
	Thu,  6 Mar 2025 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281748; cv=none; b=eI2emSnSHE3ExG3yOFaZF984CrHekbfy7X6gAzfDZPplbNYG3AL/ZDKivLpemzUa4Hw7zA1TpucDSYXXIZmdft4vdgav9j87YVmKU7EzTMnFQvCeGCXGP+iI54BCrAruo17yaU8bZjzfMv/nqVX4/uaczlkxHKQRMlll0873Sf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281748; c=relaxed/simple;
	bh=HRBm/Oot1TUfs1y8xS2C+sYEPpBogIjf8tRBM2T1dYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7mPNkK+vSpK9NEI4Txvd1ssnWQi7qLlJUgSKo9EzQZmaBHHzoo8f43Vca3E4bJ6mOTOm2os4gT3b+ti6zx0w7FqhYvVabg4LBYazEFpwafWwbQ7JrZ71bZ61P9AHOYvpYkUPQXCyj4Xwcw32zGrTxsl7zqrtv/YedSZhC9voy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=3rtuLGp9; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526H1lH8023601;
	Thu, 6 Mar 2025 18:22:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	3q2UpESHByLT6vptLy/ukIpQLBJg/EwgyUQuNp/7HuI=; b=3rtuLGp9ww+C0FcG
	kEJ763nLrVx28Tu6t5Togc6KEDj0Hh5HdPbNlssCfWGGUjCAhKhX+QjyMDLd0JEc
	wmLcdA5Y2WjZswxx2TS5JsyN8XclLfp4sWW6UkWbFL0wb+UUahDyKlKkwFC7T/Q6
	dmtRfOuUUHKhC5vr9rYaBm4IsUuYEeIi6mUB+9c/haF3P3/E5XtmxyFzWN3IFR50
	K8R3UhR+uJQtDvaAnbHqHM/84/vTfcE5KTBu4bB22RtO63Ozl6xuF74Y4UW5Xt4J
	5d1hXFQh2pNdA40oAY/Ol7+tkDwFnpNavnjPlPJr2fkQBaWZqE4Elr2cfrPUOYfo
	WbzRpg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 457dr0h88x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 18:22:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B0B5D40077;
	Thu,  6 Mar 2025 18:21:30 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7E47E5B9F3B;
	Thu,  6 Mar 2025 18:18:50 +0100 (CET)
Received: from localhost (10.252.22.44) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 18:18:50 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: Olivier Moysan <olivier.moysan@foss.st.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: dmic: add regulator support
Date: Thu, 6 Mar 2025 18:18:40 +0100
Message-ID: <20250306171840.593443-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250306171840.593443-1-olivier.moysan@foss.st.com>
References: <20250306171840.593443-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01

Allow management of the regulator that may be used to supply the
digital microphone.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 sound/soc/codecs/dmic.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index 0388f115470c..5d3c3f17c6d8 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -9,6 +9,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <sound/core.h>
@@ -25,6 +26,7 @@ module_param(wakeup_delay, uint, 0644);
 
 struct dmic {
 	struct gpio_desc *gpio_en;
+	struct regulator *vref;
 	int wakeup_delay;
 	/* Delay after DMIC mode switch */
 	int modeswitch_delay;
@@ -55,22 +57,33 @@ static int dmic_aif_event(struct snd_soc_dapm_widget *w,
 			  struct snd_kcontrol *kcontrol, int event) {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct dmic *dmic = snd_soc_component_get_drvdata(component);
+	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		if (dmic->gpio_en)
 			gpiod_set_value_cansleep(dmic->gpio_en, 1);
 
+		if (dmic->vref) {
+			ret = regulator_enable(dmic->vref);
+			if (ret)
+				return ret;
+		}
+
 		if (dmic->wakeup_delay)
 			msleep(dmic->wakeup_delay);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		if (dmic->gpio_en)
 			gpiod_set_value_cansleep(dmic->gpio_en, 0);
+
+		if (dmic->vref)
+			ret = regulator_disable(dmic->vref);
+
 		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static struct snd_soc_dai_driver dmic_dai = {
@@ -100,6 +113,10 @@ static int dmic_component_probe(struct snd_soc_component *component)
 	if (!dmic)
 		return -ENOMEM;
 
+	dmic->vref = devm_regulator_get_optional(component->dev, "vref");
+	if (IS_ERR(dmic->vref) && PTR_ERR(dmic->vref) != -ENODEV)
+		return dev_err_probe(component->dev, PTR_ERR(dmic->vref), "Failed to get vref\n");
+
 	dmic->gpio_en = devm_gpiod_get_optional(component->dev,
 						"dmicen", GPIOD_OUT_LOW);
 	if (IS_ERR(dmic->gpio_en))
-- 
2.25.1


