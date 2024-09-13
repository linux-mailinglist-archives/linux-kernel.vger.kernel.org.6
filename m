Return-Path: <linux-kernel+bounces-328130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41678977F3F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D782B20F76
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83C81D88AA;
	Fri, 13 Sep 2024 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tYyhCVMf"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41FB1C3304;
	Fri, 13 Sep 2024 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229265; cv=none; b=YvBsrBT14OC33/4uQhnl4OnGrNDzddmBEdhhxAXVtE2s0F8Vz9WHp/WlDOj/A6ahMkKRaV+Azhda2sHpMYJjLRfRgS8hHoqaCL8grKVMHmxFxcyBZan0O+yW4lBTgyuKg/L9etZ6wYhateiBzH/ZP43Lt7VZ5kt/qfX8X3IHaFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229265; c=relaxed/simple;
	bh=V6u2eHa/w9HQk3WWvCdMr/y/+BoQMgcZ+Nl2/14uCeA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rkiuvV89FRDpVAWNBHKA6wRnHCCiI5nizG024qPtQfDFxZUC45GlKyVpLoGs3P2QWOhnJt0A2l6HXST/uyQHlbrBdFblUa8JpXluy+GjC5Agsr02TA15DXbONpObruiC/gynE3utaT4jwr44RyTF6PdXF/TMDrOdHUXBBpRdjXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tYyhCVMf; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726229263; x=1757765263;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V6u2eHa/w9HQk3WWvCdMr/y/+BoQMgcZ+Nl2/14uCeA=;
  b=tYyhCVMfKYu5YpNt7kKscM4SF9qUYsGlKlEljVhDTCfXTenW9RWy4xkz
   0bdVTxk3XJqEYk+VFQoW2Al/wgj5W53gAlDirIByD5/M1nt16dPsjwtZe
   sj6j/OAa/dgXhGhDuUDvPihy9nrloymCfFCfxpY5x9bW4NqMshBFFRyad
   2CpX/C3LVh4IIJjW0CP6TwISJoCu1mVKtr9LJIcq9ecdQN/+lk6xLoK0E
   FTLean241LXKmDFhKiWCbz3BuUDrbG0LoDL01HISmBs18tIpYuXKY540L
   efNPxdWTYdhc1xT4BShXL4SQKbSzAXKxk+pk7EtNjtrIq1pxzBXlFMLMT
   Q==;
X-CSE-ConnectionGUID: ap9aDqYYRZ2h/RrZKGCbqA==
X-CSE-MsgGUID: FyIGOBtkRr+rtkG0jt9EvA==
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="31749888"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Sep 2024 05:07:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 13 Sep 2024 05:07:25 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 13 Sep 2024 05:07:21 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH v2] ASoC: atmel: mchp-pdmc: Retain Non-Runtime Controls
Date: Fri, 13 Sep 2024 15:06:22 +0300
Message-ID: <20240913120621.79088-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Avoid removing these controls, as doing so can cause issues if the stream
is initiated from another control. Ensure these controls remain intact when
the stream is started or finished. Instead of removing them, return an
-EBUSY error code to indicate that the controller is busy, especially when
the audio filter and the SINC filter are in use.

[andrei.simion@microchip.com: Reword the commit title and the commit
message. Replace spinlock and busy variable with atomic_t busy_stream.]

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
v1 -> v2:
- drop spinlock and u8 busy:1;
- use atomic_t variable busy_stream
- use atomic_read, atomic_set
---
 sound/soc/atmel/mchp-pdmc.c | 57 ++++++++++---------------------------
 1 file changed, 15 insertions(+), 42 deletions(-)

diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
index d97d153ee375..939cd44ebc8a 100644
--- a/sound/soc/atmel/mchp-pdmc.c
+++ b/sound/soc/atmel/mchp-pdmc.c
@@ -124,6 +124,7 @@ struct mchp_pdmc {
 	int mic_no;
 	int sinc_order;
 	bool audio_filter_en;
+	atomic_t busy_stream;
 };
 
 static const char *const mchp_pdmc_sinc_filter_order_text[] = {
@@ -167,6 +168,10 @@ static int mchp_pdmc_sinc_order_put(struct snd_kcontrol *kcontrol,
 		return -EINVAL;
 
 	val = snd_soc_enum_item_to_val(e, item[0]) << e->shift_l;
+
+	if (atomic_read(&dd->busy_stream))
+		return -EBUSY;
+
 	if (val == dd->sinc_order)
 		return 0;
 
@@ -193,6 +198,9 @@ static int mchp_pdmc_af_put(struct snd_kcontrol *kcontrol,
 	struct mchp_pdmc *dd = snd_soc_component_get_drvdata(component);
 	bool af = uvalue->value.integer.value[0] ? true : false;
 
+	if (atomic_read(&dd->busy_stream))
+		return -EBUSY;
+
 	if (dd->audio_filter_en == af)
 		return 0;
 
@@ -379,52 +387,10 @@ static const struct snd_kcontrol_new mchp_pdmc_snd_controls[] = {
 	},
 };
 
-static int mchp_pdmc_close(struct snd_soc_component *component,
-			   struct snd_pcm_substream *substream)
-{
-	return snd_soc_add_component_controls(component, mchp_pdmc_snd_controls,
-					      ARRAY_SIZE(mchp_pdmc_snd_controls));
-}
-
-static int mchp_pdmc_open(struct snd_soc_component *component,
-			  struct snd_pcm_substream *substream)
-{
-	int i;
-
-	/* remove controls that can't be changed at runtime */
-	for (i = 0; i < ARRAY_SIZE(mchp_pdmc_snd_controls); i++) {
-		const struct snd_kcontrol_new *control = &mchp_pdmc_snd_controls[i];
-		struct snd_ctl_elem_id id;
-		int err;
-
-		if (component->name_prefix)
-			snprintf(id.name, sizeof(id.name), "%s %s", component->name_prefix,
-				 control->name);
-		else
-			strscpy(id.name, control->name, sizeof(id.name));
-
-		id.numid = 0;
-		id.iface = control->iface;
-		id.device = control->device;
-		id.subdevice = control->subdevice;
-		id.index = control->index;
-		err = snd_ctl_remove_id(component->card->snd_card, &id);
-		if (err < 0)
-			dev_err(component->dev, "%d: Failed to remove %s\n", err,
-				control->name);
-	}
-
-	return 0;
-}
-
 static const struct snd_soc_component_driver mchp_pdmc_dai_component = {
 	.name = "mchp-pdmc",
 	.controls = mchp_pdmc_snd_controls,
 	.num_controls = ARRAY_SIZE(mchp_pdmc_snd_controls),
-	.open = &mchp_pdmc_open,
-	.close = &mchp_pdmc_close,
-	.legacy_dai_naming = 1,
-	.trigger_start = SND_SOC_TRIGGER_ORDER_LDC,
 };
 
 static const unsigned int mchp_pdmc_1mic[] = {1};
@@ -587,6 +553,11 @@ static int mchp_pdmc_hw_params(struct snd_pcm_substream *substream,
 			cfgr_val |= MCHP_PDMC_CFGR_BSSEL(i);
 	}
 
+	/*
+	 * from these point forward, we consider the controller busy, so the
+	 * audio filter and SINC order can't be changed
+	 */
+	atomic_set(&dd->busy_stream, 1);
 	for (osr_start = dd->audio_filter_en ? 64 : 8;
 	     osr_start <= 256 && best_diff_rate; osr_start *= 2) {
 		long round_rate;
@@ -1143,6 +1114,8 @@ static void mchp_pdmc_remove(struct platform_device *pdev)
 {
 	struct mchp_pdmc *dd = platform_get_drvdata(pdev);
 
+	atomic_set(&dd->busy_stream, 0);
+
 	if (!pm_runtime_status_suspended(dd->dev))
 		mchp_pdmc_runtime_suspend(dd->dev);
 

base-commit: 5acd9952f95fb4b7da6d09a3be39195a80845eb6
-- 
2.34.1


