Return-Path: <linux-kernel+bounces-236055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE5C91DCF0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCCCE1C20F2E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8140013C679;
	Mon,  1 Jul 2024 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ZtC4fsfy"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E7012B169;
	Mon,  1 Jul 2024 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719830706; cv=none; b=IaKO7incdyGTuyCncC5Q7pshUtqvi1/ijWRYnVb4wVUp0HMWs3q41Ql9hNAal6qKgJovF+4w0TSjRQHHGAaDG7ZP7X2Y3UVrFOo0Fkj1Ixx3XMgQflloj7iUluBvcJOIlRWu01KyIsFWwTW0drHlie3I1SPKTnBKhl5guM5hvdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719830706; c=relaxed/simple;
	bh=UjmG9148C/MbU8P2sKa1BOqxrerMxEBzmqBiMfuFgak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+WUhXPLYDnJkzY2ghcN0Qaq/C361tpDkZgov8hdLwosFCA8QHDiuMk/iP8YnDBEaq9Kbvk0Izo55CSPMxyJIwfblQfUg4nfz5XgCdfFhD8zH5uqUIAzmSLu6b3UN295BqSQdGhINKwxxHu+wdyPl4zeFNV/tk0edW4ZKgLhnG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ZtC4fsfy; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4614mX4w015862;
	Mon, 1 Jul 2024 05:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=BGS71ITV0WQMamb+2yMoCh7HOdvC+QTRijghEkzf3Zo=; b=
	ZtC4fsfyY+4D5MPNEtzXpsMH7VTmVs14ExmcPB4VBzQ9F3Eztmr3tln8g63H+DFP
	VdCJrtc5ot0b0rlsYJC8Vnah6wQJy4au26P/a3WQNhYaL8yTVWk0sy6zyAbeFv8G
	UYm02YLOnr30BRFCdvZxoAGrBHK6gH2WzxvPznCTFx5Jjs6bOXqcd6v/s0/IhTQk
	H83eOS2o6wXlO/gqhmbdMfYIzufQy+Zu5hYTvpWPDm5YMPLICl/Nweobh2Fl9PFJ
	VGILtUXUYjIO4M2TIQqB54GHl2MwWLe3zbARGBIR04ON5L86WBoMmgq8kiFsGX2f
	KI6QGikdOKcIJCs11Pcvjw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 402epjabpk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 05:44:47 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Jul 2024
 11:44:44 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 1 Jul 2024 11:44:44 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id AE4FC820257;
	Mon,  1 Jul 2024 10:44:44 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 2/3] ASoC: cs35l56: Remove support for A1 silicon
Date: Mon, 1 Jul 2024 11:44:43 +0100
Message-ID: <20240701104444.172556-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701104444.172556-1-rf@opensource.cirrus.com>
References: <20240701104444.172556-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: aTjEy-oVL9nyPn4Ec4rtbRS7m413ypTQ
X-Proofpoint-ORIG-GUID: aTjEy-oVL9nyPn4Ec4rtbRS7m413ypTQ
X-Proofpoint-Spam-Reason: safe

No product was ever released with A1 silicon so there is no
need for the driver to include support for it.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h           |  2 -
 sound/soc/codecs/cs35l56-sdw.c    | 74 -------------------------------
 sound/soc/codecs/cs35l56-shared.c | 21 +--------
 sound/soc/codecs/cs35l56.h        |  1 -
 4 files changed, 2 insertions(+), 96 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 2e19722989f7..642ef690ebc2 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -80,9 +80,7 @@
 #define CS35L56_DSP1_AHBM_WINDOW_DEBUG_1		0x25E2044
 #define CS35L56_DSP1_XMEM_UNPACKED24_0			0x2800000
 #define CS35L56_DSP1_FW_VER				0x2800010
-#define CS35L56_DSP1_HALO_STATE_A1			0x2801E58
 #define CS35L56_DSP1_HALO_STATE				0x28021E0
-#define CS35L56_DSP1_PM_CUR_STATE_A1			0x2804000
 #define CS35L56_DSP1_PM_CUR_STATE			0x2804308
 #define CS35L56_DSP1_XMEM_UNPACKED24_8191		0x2807FFC
 #define CS35L56_DSP1_CORE_BASE				0x2B80000
diff --git a/sound/soc/codecs/cs35l56-sdw.c b/sound/soc/codecs/cs35l56-sdw.c
index 70ff55c1517f..8862107105ae 100644
--- a/sound/soc/codecs/cs35l56-sdw.c
+++ b/sound/soc/codecs/cs35l56-sdw.c
@@ -317,79 +317,6 @@ static int cs35l56_sdw_update_status(struct sdw_slave *peripheral,
 	return 0;
 }
 
-static int cs35l56_a1_kick_divider(struct cs35l56_private *cs35l56,
-				   struct sdw_slave *peripheral)
-{
-	unsigned int curr_scale_reg, next_scale_reg;
-	int curr_scale, next_scale, ret;
-
-	if (!cs35l56->base.init_done)
-		return 0;
-
-	if (peripheral->bus->params.curr_bank) {
-		curr_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B1;
-		next_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B0;
-	} else {
-		curr_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B0;
-		next_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B1;
-	}
-
-	/*
-	 * Current clock scale value must be different to new value.
-	 * Modify current to guarantee this. If next still has the dummy
-	 * value we wrote when it was current, the core code has not set
-	 * a new scale so restore its original good value
-	 */
-	curr_scale = sdw_read_no_pm(peripheral, curr_scale_reg);
-	if (curr_scale < 0) {
-		dev_err(cs35l56->base.dev, "Failed to read current clock scale: %d\n", curr_scale);
-		return curr_scale;
-	}
-
-	next_scale = sdw_read_no_pm(peripheral, next_scale_reg);
-	if (next_scale < 0) {
-		dev_err(cs35l56->base.dev, "Failed to read next clock scale: %d\n", next_scale);
-		return next_scale;
-	}
-
-	if (next_scale == CS35L56_SDW_INVALID_BUS_SCALE) {
-		next_scale = cs35l56->old_sdw_clock_scale;
-		ret = sdw_write_no_pm(peripheral, next_scale_reg, next_scale);
-		if (ret < 0) {
-			dev_err(cs35l56->base.dev, "Failed to modify current clock scale: %d\n",
-				ret);
-			return ret;
-		}
-	}
-
-	cs35l56->old_sdw_clock_scale = curr_scale;
-	ret = sdw_write_no_pm(peripheral, curr_scale_reg, CS35L56_SDW_INVALID_BUS_SCALE);
-	if (ret < 0) {
-		dev_err(cs35l56->base.dev, "Failed to modify current clock scale: %d\n", ret);
-		return ret;
-	}
-
-	dev_dbg(cs35l56->base.dev, "Next bus scale: %#x\n", next_scale);
-
-	return 0;
-}
-
-static int cs35l56_sdw_bus_config(struct sdw_slave *peripheral,
-				  struct sdw_bus_params *params)
-{
-	struct cs35l56_private *cs35l56 = dev_get_drvdata(&peripheral->dev);
-	int sclk;
-
-	sclk = params->curr_dr_freq / 2;
-	dev_dbg(cs35l56->base.dev, "%s: sclk=%u c=%u r=%u\n",
-		__func__, sclk, params->col, params->row);
-
-	if ((cs35l56->base.type == 0x56) && (cs35l56->base.rev < 0xb0))
-		return cs35l56_a1_kick_divider(cs35l56, peripheral);
-
-	return 0;
-}
-
 static int __maybe_unused cs35l56_sdw_clk_stop(struct sdw_slave *peripheral,
 					       enum sdw_clk_stop_mode mode,
 					       enum sdw_clk_stop_type type)
@@ -405,7 +332,6 @@ static const struct sdw_slave_ops cs35l56_sdw_ops = {
 	.read_prop = cs35l56_sdw_read_prop,
 	.interrupt_callback = cs35l56_sdw_interrupt,
 	.update_status = cs35l56_sdw_update_status,
-	.bus_config = cs35l56_sdw_bus_config,
 #ifdef DEBUG
 	.clk_stop = cs35l56_sdw_clk_stop,
 #endif
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 035d7c3c4683..e7e8d617da94 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -245,19 +245,13 @@ EXPORT_SYMBOL_NS_GPL(cs35l56_mbox_send, SND_SOC_CS35L56_SHARED);
 int cs35l56_firmware_shutdown(struct cs35l56_base *cs35l56_base)
 {
 	int ret;
-	unsigned int reg;
 	unsigned int val;
 
 	ret = cs35l56_mbox_send(cs35l56_base, CS35L56_MBOX_CMD_SHUTDOWN);
 	if (ret)
 		return ret;
 
-	if (cs35l56_base->rev < CS35L56_REVID_B0)
-		reg = CS35L56_DSP1_PM_CUR_STATE_A1;
-	else
-		reg = CS35L56_DSP1_PM_CUR_STATE;
-
-	ret = regmap_read_poll_timeout(cs35l56_base->regmap,  reg,
+	ret = regmap_read_poll_timeout(cs35l56_base->regmap,  CS35L56_DSP1_PM_CUR_STATE,
 				       val, (val == CS35L56_HALO_STATE_SHUTDOWN),
 				       CS35L56_HALO_STATE_POLL_US,
 				       CS35L56_HALO_STATE_TIMEOUT_US);
@@ -270,15 +264,9 @@ EXPORT_SYMBOL_NS_GPL(cs35l56_firmware_shutdown, SND_SOC_CS35L56_SHARED);
 
 int cs35l56_wait_for_firmware_boot(struct cs35l56_base *cs35l56_base)
 {
-	unsigned int reg;
 	unsigned int val = 0;
 	int read_ret, poll_ret;
 
-	if (cs35l56_base->rev < CS35L56_REVID_B0)
-		reg = CS35L56_DSP1_HALO_STATE_A1;
-	else
-		reg = CS35L56_DSP1_HALO_STATE;
-
 	/*
 	 * The regmap must remain in cache-only until the chip has
 	 * booted, so use a bypassed read of the status register.
@@ -288,7 +276,7 @@ int cs35l56_wait_for_firmware_boot(struct cs35l56_base *cs35l56_base)
 				     CS35L56_HALO_STATE_POLL_US,
 				     CS35L56_HALO_STATE_TIMEOUT_US,
 				     false,
-				     cs35l56_base->regmap, reg, &val);
+				     cs35l56_base->regmap, CS35L56_DSP1_HALO_STATE, &val);
 
 	if (poll_ret) {
 		dev_err(cs35l56_base->dev, "Firmware boot timed out(%d): HALO_STATE=%#x\n",
@@ -726,11 +714,6 @@ int cs35l56_hw_init(struct cs35l56_base *cs35l56_base)
 	else
 		cs35l56_wait_control_port_ready();
 
-	/*
-	 * The HALO_STATE register is in different locations on Ax and B0
-	 * devices so the REVID needs to be determined before waiting for the
-	 * firmware to boot.
-	 */
 	ret = regmap_read_bypassed(cs35l56_base->regmap, CS35L56_REVID, &revid);
 	if (ret < 0) {
 		dev_err(cs35l56_base->dev, "Get Revision ID failed\n");
diff --git a/sound/soc/codecs/cs35l56.h b/sound/soc/codecs/cs35l56.h
index 200f695efca3..8a987ec01507 100644
--- a/sound/soc/codecs/cs35l56.h
+++ b/sound/soc/codecs/cs35l56.h
@@ -51,7 +51,6 @@ struct cs35l56_private {
 	u8 asp_slot_count;
 	bool tdm_mode;
 	bool sysclk_set;
-	u8 old_sdw_clock_scale;
 };
 
 extern const struct dev_pm_ops cs35l56_pm_ops_i2c_spi;
-- 
2.39.2


