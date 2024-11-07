Return-Path: <linux-kernel+bounces-400216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AC79C0A7D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C4428415C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B138D215C77;
	Thu,  7 Nov 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="5XljyOpv"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C785213157;
	Thu,  7 Nov 2024 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994903; cv=none; b=FOU2/PNPXLFJA9MwSeg7vf6H3bY0ToEMxyKTbBeGqpPHsPsFt1Y9RzoDxFBc2j8Mc5wGylVg6rytDyGQ7HF1fFt2gy3mpcUmvAm6i5A/8ZrrroQUJ56clvtfz7nhbnIlrp2ApzrMWAAaylw0huPUcZodhGzWC7P9QVhGiK/kXw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994903; c=relaxed/simple;
	bh=4FRCcZ45+p60gSzvR31xcMSxENhbBKhHUYbNhCJUpGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmnSW3+yk+ueI2GA2vdg2UHnuOPGVqNOQMHqzEOikm04QJ+9zJ4yNNf9cowJEVf1172OBmQHjTvCwPb2bFQFbTCUzwbyKGjjH9qfDcKZ64dpn7qLp9aos4FC0vATDzWZqLJcXMVHOXJD/Wv1+hWQhi2urBWWUb7B/9bdLVGQTz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=5XljyOpv; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7BPO9H001277;
	Thu, 7 Nov 2024 16:54:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	PtWyNXu25X19/7qXTR13e6RUjUQOKgl4cgGMCZy8wPI=; b=5XljyOpv1UshwdpF
	J/NjV7E5ckjj51f8EL/srrhjkFsmf0dne5wQbAGrGNHd7DQsurH2qr/d3ik060Au
	dqS+MC68y79mMTMblrDnOXB0t6e/+P0+fwj2Sc4UBPDlg+zbcFOE2U1lLj0ctlxc
	46Bb73xaw+GHplhPkms5JQ01HUrfblAbjj29xVpVEH0X5X8TGimk0W5hnZynvZRB
	EJmbGd0412zUKU6d0QG2Cjvp4ixEnauUOr2khDnh0xQt9vpawN3DzNsU07iRTji/
	t/BahBdWO0E9A7br8V950xKoabc0FDSh8mgik3uRCnmOeBcL8xONMHECrZq2d1+s
	2YvW3Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42r9765y3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 16:54:46 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 07BEE40065;
	Thu,  7 Nov 2024 16:53:42 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1F3B72A7E2F;
	Thu,  7 Nov 2024 16:52:03 +0100 (CET)
Received: from localhost (10.48.86.132) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 7 Nov
 2024 16:52:02 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: <linux-sound@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: stm32: sai: add stm32mp25 support
Date: Thu, 7 Nov 2024 16:51:42 +0100
Message-ID: <20241107155143.1340523-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241107155143.1340523-1-olivier.moysan@foss.st.com>
References: <20241107155143.1340523-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add STM32MP25 support for STM32 SAI.

On STM32MP25 the SAI driver does not manage SAI kernel clock rate
by chosing its parent clock, dependending on audio stream rate.

The driver requests a rate change on SAI kernel clock instead.
This rate change is performed with the following guidelines:
- Chose highest rate multiple of the audio stream
  (Try to get clock accuracy within 1000 ppm)
- Ensure clock rate compatibility between SAI sub-blocks A&B
  and between instances sharing the same flexgen.
  Use clk_rate_exclusive API to fulfill this requirement.

The STM32 SAI peripheral does not support the DMA burst mode
on STM32MP25. Add a field in compatible structure to manage DMA
burst support capability.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 sound/soc/stm/stm32_sai.c     |  58 +++++++++++---
 sound/soc/stm/stm32_sai.h     |   6 ++
 sound/soc/stm/stm32_sai_sub.c | 144 ++++++++++++++++++++++++++++++++--
 3 files changed, 191 insertions(+), 17 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index b45ee7e24f22..bc8180fc8462 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -19,26 +19,42 @@
 
 #include "stm32_sai.h"
 
+static int stm32_sai_get_parent_clk(struct stm32_sai_data *sai);
+
 static const struct stm32_sai_conf stm32_sai_conf_f4 = {
 	.version = STM_SAI_STM32F4,
 	.fifo_size = 8,
 	.has_spdif_pdm = false,
+	.get_sai_ck_parent = stm32_sai_get_parent_clk,
 };
 
 /*
- * Default settings for stm32 H7 socs and next.
+ * Default settings for STM32H7x socs and STM32MP1x.
  * These default settings will be overridden if the soc provides
  * support of hardware configuration registers.
+ * - STM32H7: rely on default settings
+ * - STM32MP1: retrieve settings from registers
  */
 static const struct stm32_sai_conf stm32_sai_conf_h7 = {
 	.version = STM_SAI_STM32H7,
 	.fifo_size = 8,
 	.has_spdif_pdm = true,
+	.get_sai_ck_parent = stm32_sai_get_parent_clk,
+};
+
+/*
+ * STM32MP2x:
+ * - do not use SAI parent clock source selection
+ * - do not use DMA burst mode
+ */
+static const struct stm32_sai_conf stm32_sai_conf_mp25 = {
+	.no_dma_burst = true,
 };
 
 static const struct of_device_id stm32_sai_ids[] = {
 	{ .compatible = "st,stm32f4-sai", .data = (void *)&stm32_sai_conf_f4 },
 	{ .compatible = "st,stm32h7-sai", .data = (void *)&stm32_sai_conf_h7 },
+	{ .compatible = "st,stm32mp25-sai", .data = (void *)&stm32_sai_conf_mp25 },
 	{}
 };
 
@@ -148,6 +164,29 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 	return ret;
 }
 
+static int stm32_sai_get_parent_clk(struct stm32_sai_data *sai)
+{
+	struct device *dev = &sai->pdev->dev;
+
+	sai->clk_x8k = devm_clk_get(dev, "x8k");
+	if (IS_ERR(sai->clk_x8k)) {
+		if (PTR_ERR(sai->clk_x8k) != -EPROBE_DEFER)
+			dev_err(dev, "missing x8k parent clock: %ld\n",
+				PTR_ERR(sai->clk_x8k));
+		return PTR_ERR(sai->clk_x8k);
+	}
+
+	sai->clk_x11k = devm_clk_get(dev, "x11k");
+	if (IS_ERR(sai->clk_x11k)) {
+		if (PTR_ERR(sai->clk_x11k) != -EPROBE_DEFER)
+			dev_err(dev, "missing x11k parent clock: %ld\n",
+				PTR_ERR(sai->clk_x11k));
+		return PTR_ERR(sai->clk_x11k);
+	}
+
+	return 0;
+}
+
 static int stm32_sai_probe(struct platform_device *pdev)
 {
 	struct stm32_sai_data *sai;
@@ -160,6 +199,8 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	if (!sai)
 		return -ENOMEM;
 
+	sai->pdev = pdev;
+
 	sai->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sai->base))
 		return PTR_ERR(sai->base);
@@ -178,15 +219,11 @@ static int stm32_sai_probe(struct platform_device *pdev)
 					     "missing bus clock pclk\n");
 	}
 
-	sai->clk_x8k = devm_clk_get(&pdev->dev, "x8k");
-	if (IS_ERR(sai->clk_x8k))
-		return dev_err_probe(&pdev->dev, PTR_ERR(sai->clk_x8k),
-				     "missing x8k parent clock\n");
-
-	sai->clk_x11k = devm_clk_get(&pdev->dev, "x11k");
-	if (IS_ERR(sai->clk_x11k))
-		return dev_err_probe(&pdev->dev, PTR_ERR(sai->clk_x11k),
-				     "missing x11k parent clock\n");
+	if (sai->conf.get_sai_ck_parent) {
+		ret = sai->conf.get_sai_ck_parent(sai);
+		if (ret)
+			return ret;
+	}
 
 	/* init irqs */
 	sai->irq = platform_get_irq(pdev, 0);
@@ -227,7 +264,6 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	}
 	clk_disable_unprepare(sai->pclk);
 
-	sai->pdev = pdev;
 	sai->set_sync = &stm32_sai_set_sync;
 	platform_set_drvdata(pdev, sai);
 
diff --git a/sound/soc/stm/stm32_sai.h b/sound/soc/stm/stm32_sai.h
index 33e4bff8c2f5..07b71133db2a 100644
--- a/sound/soc/stm/stm32_sai.h
+++ b/sound/soc/stm/stm32_sai.h
@@ -264,16 +264,22 @@ enum stm32_sai_syncout {
 	STM_SAI_SYNC_OUT_B,
 };
 
+struct stm32_sai_data;
+
 /**
  * struct stm32_sai_conf - SAI configuration
+ * @get_sai_ck_parent: get parent clock of SAI kernel clock
  * @version: SAI version
  * @fifo_size: SAI fifo size as words number
  * @has_spdif_pdm: SAI S/PDIF and PDM features support flag
+ * @no_dma_burst: Support only DMA single transfers if set
  */
 struct stm32_sai_conf {
+	int (*get_sai_ck_parent)(struct stm32_sai_data *sai);
 	u32 version;
 	u32 fifo_size;
 	bool has_spdif_pdm;
+	bool no_dma_burst;
 };
 
 /**
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index a772bc8ea7be..27b7fdef7cb0 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -60,6 +60,9 @@
 
 #define SAI_MCLK_NAME_LEN		32
 #define SAI_RATE_11K			11025
+#define SAI_MAX_SAMPLE_RATE_8K		192000
+#define SAI_MAX_SAMPLE_RATE_11K		176400
+#define SAI_CK_RATE_TOLERANCE		1000 /* ppm */
 
 /**
  * struct stm32_sai_sub_data - private data of SAI sub block (block A or B)
@@ -80,6 +83,7 @@
  * @dir: SAI block direction (playback or capture). set at init
  * @master: SAI block mode flag. (true=master, false=slave) set at init
  * @spdif: SAI S/PDIF iec60958 mode flag. set at init
+ * @sai_ck_used: flag set while exclusivity on SAI kernel clock is active
  * @fmt: SAI block format. relevant only for custom protocols. set at init
  * @sync: SAI block synchronization mode. (none, internal or external)
  * @synco: SAI block ext sync source (provider setting). (none, sub-block A/B)
@@ -93,6 +97,8 @@
  * @iec958: iec958 data
  * @ctrl_lock: control lock
  * @irq_lock: prevent race condition with IRQ
+ * @set_sai_ck_rate: set SAI kernel clock rate
+ * @put_sai_ck_rate: put SAI kernel clock rate
  */
 struct stm32_sai_sub_data {
 	struct platform_device *pdev;
@@ -112,6 +118,7 @@ struct stm32_sai_sub_data {
 	int dir;
 	bool master;
 	bool spdif;
+	bool sai_ck_used;
 	int fmt;
 	int sync;
 	int synco;
@@ -125,6 +132,8 @@ struct stm32_sai_sub_data {
 	struct snd_aes_iec958 iec958;
 	struct mutex ctrl_lock; /* protect resources accessed by controls */
 	spinlock_t irq_lock; /* used to prevent race condition with IRQ */
+	int (*set_sai_ck_rate)(struct stm32_sai_sub_data *sai, unsigned int rate);
+	void (*put_sai_ck_rate)(struct stm32_sai_sub_data *sai);
 };
 
 enum stm32_sai_fifo_th {
@@ -351,8 +360,26 @@ static int stm32_sai_set_clk_div(struct stm32_sai_sub_data *sai,
 	return ret;
 }
 
-static int stm32_sai_set_parent_clock(struct stm32_sai_sub_data *sai,
-				      unsigned int rate)
+static bool stm32_sai_rate_accurate(unsigned int max_rate, unsigned int rate)
+{
+	u64 delta, dividend;
+	int ratio;
+
+	ratio = DIV_ROUND_CLOSEST(max_rate, rate);
+	if (!ratio)
+		return false;
+
+	dividend = mul_u32_u32(1000000, abs(max_rate - (ratio * rate)));
+	delta = div_u64(dividend, max_rate);
+
+	if (delta <= SAI_CK_RATE_TOLERANCE)
+		return true;
+
+	return false;
+}
+
+static int stm32_sai_set_parent_clk(struct stm32_sai_sub_data *sai,
+				    unsigned int rate)
 {
 	struct platform_device *pdev = sai->pdev;
 	struct clk *parent_clk = sai->pdata->clk_x8k;
@@ -370,6 +397,92 @@ static int stm32_sai_set_parent_clock(struct stm32_sai_sub_data *sai,
 	return ret;
 }
 
+static void stm32_sai_put_parent_rate(struct stm32_sai_sub_data *sai)
+{
+	if (sai->sai_ck_used) {
+		sai->sai_ck_used = false;
+		clk_rate_exclusive_put(sai->sai_ck);
+	}
+}
+
+static int stm32_sai_set_parent_rate(struct stm32_sai_sub_data *sai,
+				     unsigned int rate)
+{
+	struct platform_device *pdev = sai->pdev;
+	unsigned int sai_ck_rate, sai_ck_max_rate, sai_curr_rate, sai_new_rate;
+	int div, ret;
+
+	/*
+	 * Set maximum expected kernel clock frequency
+	 * - mclk on or spdif:
+	 *   f_sai_ck = MCKDIV * mclk-fs * fs
+	 *   Here typical 256 ratio is assumed for mclk-fs
+	 * - mclk off:
+	 *   f_sai_ck = MCKDIV * FRL * fs
+	 *   Where FRL=[8..256], MCKDIV=[1..n] (n depends on SAI version)
+	 *   Set constraint MCKDIV * FRL <= 256, to ensure MCKDIV is in available range
+	 *   f_sai_ck = sai_ck_max_rate * pow_of_two(FRL) / 256
+	 */
+	if (!(rate % SAI_RATE_11K))
+		sai_ck_max_rate = SAI_MAX_SAMPLE_RATE_11K * 256;
+	else
+		sai_ck_max_rate = SAI_MAX_SAMPLE_RATE_8K * 256;
+
+	if (!sai->sai_mclk && !STM_SAI_PROTOCOL_IS_SPDIF(sai))
+		sai_ck_max_rate /= DIV_ROUND_CLOSEST(256, roundup_pow_of_two(sai->fs_length));
+
+	/*
+	 * Request exclusivity, as the clock is shared by SAI sub-blocks and by
+	 * some SAI instances. This allows to ensure that the rate cannot be
+	 * changed while one or more SAIs are using the clock.
+	 */
+	clk_rate_exclusive_get(sai->sai_ck);
+	sai->sai_ck_used = true;
+
+	/*
+	 * Check current kernel clock rate. If it gives the expected accuracy
+	 * return immediately.
+	 */
+	sai_curr_rate = clk_get_rate(sai->sai_ck);
+	if (stm32_sai_rate_accurate(sai_ck_max_rate, sai_curr_rate))
+		return 0;
+
+	/*
+	 * Otherwise try to set the maximum rate and check the new actual rate.
+	 * If the new rate does not give the expected accuracy, try to set
+	 * lower rates for the kernel clock.
+	 */
+	sai_ck_rate = sai_ck_max_rate;
+	div = 1;
+	do {
+		/* Check new rate accuracy. Return if ok */
+		sai_new_rate = clk_round_rate(sai->sai_ck, sai_ck_rate);
+		if (stm32_sai_rate_accurate(sai_ck_rate, sai_new_rate)) {
+			ret = clk_set_rate(sai->sai_ck, sai_ck_rate);
+			if (ret) {
+				dev_err(&pdev->dev, "Error %d setting sai_ck rate. %s",
+					ret, ret == -EBUSY ?
+					"Active stream rates may be in conflict\n" : "\n");
+				goto err;
+			}
+
+			return 0;
+		}
+
+		/* Try a lower frequency */
+		div++;
+		sai_ck_rate = sai_ck_max_rate / div;
+	} while (sai_ck_rate > rate);
+
+	/* No accurate rate found */
+	dev_err(&pdev->dev, "Failed to find an accurate rate");
+
+err:
+	stm32_sai_put_parent_rate(sai);
+
+	return -EINVAL;
+}
+
 static long stm32_sai_mclk_round_rate(struct clk_hw *hw, unsigned long rate,
 				      unsigned long *prate)
 {
@@ -565,11 +678,15 @@ static int stm32_sai_set_sysclk(struct snd_soc_dai *cpu_dai,
 				clk_rate_exclusive_put(sai->sai_mclk);
 				sai->mclk_rate = 0;
 			}
+
+			if (sai->put_sai_ck_rate)
+				sai->put_sai_ck_rate(sai);
+
 			return 0;
 		}
 
-		/* If master clock is used, set parent clock now */
-		ret = stm32_sai_set_parent_clock(sai, freq);
+		/* If master clock is used, configure SAI kernel clock now */
+		ret = sai->set_sai_ck_rate(sai, freq);
 		if (ret)
 			return ret;
 
@@ -993,7 +1110,7 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 	int ret;
 
 	if (!sai->sai_mclk) {
-		ret = stm32_sai_set_parent_clock(sai, rate);
+		ret = sai->set_sai_ck_rate(sai, rate);
 		if (ret)
 			return ret;
 	}
@@ -1154,6 +1271,14 @@ static void stm32_sai_shutdown(struct snd_pcm_substream *substream,
 
 	clk_disable_unprepare(sai->sai_ck);
 
+	/*
+	 * Release kernel clock if following conditions are fulfilled
+	 * - Master clock is not used. Kernel clock won't be released trough sysclk
+	 * - Put handler is defined. Involve that clock is managed exclusively
+	 */
+	if (!sai->sai_mclk && sai->put_sai_ck_rate)
+		sai->put_sai_ck_rate(sai);
+
 	spin_lock_irqsave(&sai->irq_lock, flags);
 	sai->substream = NULL;
 	spin_unlock_irqrestore(&sai->irq_lock, flags);
@@ -1188,7 +1313,7 @@ static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	 * constraints).
 	 */
 	sai->dma_params.maxburst = 4;
-	if (sai->pdata->conf.fifo_size < 8)
+	if (sai->pdata->conf.fifo_size < 8 || sai->pdata->conf.no_dma_burst)
 		sai->dma_params.maxburst = 1;
 	/* Buswidth will be set by framework at runtime */
 	sai->dma_params.addr_width = DMA_SLAVE_BUSWIDTH_UNDEFINED;
@@ -1526,6 +1651,13 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (sai->pdata->conf.get_sai_ck_parent) {
+		sai->set_sai_ck_rate = stm32_sai_set_parent_clk;
+	} else {
+		sai->set_sai_ck_rate = stm32_sai_set_parent_rate;
+		sai->put_sai_ck_rate = stm32_sai_put_parent_rate;
+	}
+
 	ret = stm32_sai_sub_parse_of(pdev, sai);
 	if (ret)
 		return ret;
-- 
2.25.1


