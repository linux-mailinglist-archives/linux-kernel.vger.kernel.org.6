Return-Path: <linux-kernel+bounces-515292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D53A362FC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065C416B917
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAE9267728;
	Fri, 14 Feb 2025 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="pavJ67K0"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548C14D28C;
	Fri, 14 Feb 2025 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550256; cv=none; b=j0gIGRfsbQEyE7pxwfQ9f7vOG3xxQ22QHa0Np5WPPqb4dcbWoO9Tz/O1DfKMNakO/OafDiZ5AE45FiRNNaGo5DTt6ct7CRr0q6wclcHDPtAMFcUavp5ySodMZRnEvaq9eypYwGm+GhBS6nIfMvEN7zUROe3NO3IaHPdr7yFogdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550256; c=relaxed/simple;
	bh=JASZ1AA+Y6RP5R2iE4caDkFGRcyQA+Umt8TbI/O1piU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NWqF+uF7z9VdT4hpi7KesNHy8Lb4SHKB8PxrJ7S+vW7v/NTgOd19/gpIul42Z7hOBH/+kv0O7eX9irK4sqfa9rT3JkpL1yDAcq/M4E1+0LoEzQawfORPFdlqGfHdFJRUhq2hO4ePovBKn6q7L2sFe3Bepjw4l0V8B+0iuF458L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=pavJ67K0; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EESekB026079;
	Fri, 14 Feb 2025 10:24:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=uDtvAfbcGbD2a21k
	kxvIGFiaVRjDVlVDaEQw9EYVt+k=; b=pavJ67K0cDAYiOxjo2OsJj81V+cpSzDv
	BD3Aod9P/jgtnNmDAh76MTmfrzcvINX0wpipiMzZ8WE7qNnHbr/0IwumZTqL/Gi/
	y7g9/SjOpqP52S2pbb6Hgv6gVfJoa8DpEBm38tC0Wu3h5Zhjns/vFaJDPSA7GODv
	ONEwxEMWt1JYoLJiL5FKm7DSBi2cxVwqnAbVnIsFZvvLErZz98VIY6IIrEIcoQzO
	IQqw+CnLom2HRfiSJA2Xh91GRwYfWxle9YHWb/L6fOfLv3G077ArrcgVsxWViiW+
	QbEPKsL8o4J6aV4r9Z9bywNzA+qlaV93s4wkcsry4ZGIDunjCqJItg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 44p4jn2wfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 10:24:00 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 14 Feb
 2025 16:23:58 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Fri, 14 Feb 2025 16:23:58 +0000
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 4585E82025A;
	Fri, 14 Feb 2025 16:23:58 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Vitaly Rodionov
	<vitalyr@opensource.cirrus.com>
Subject: [PATCH 1/2] ALSA: hda/cirrus: Correct the full scale volume set logic
Date: Fri, 14 Feb 2025 16:23:25 +0000
Message-ID: <20250214162354.2675652-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=PNv1+eqC c=1 sm=1 tr=0 ts=67af6e20 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=qwdXLPsP7PC7M7duAzoA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: pt7lytE70h3Xa6jjl6NNdBVPbPkysxKH
X-Proofpoint-ORIG-GUID: pt7lytE70h3Xa6jjl6NNdBVPbPkysxKH
X-Proofpoint-Spam-Reason: safe

This patch corrects the full-scale volume setting logic. On certain
platforms, the full-scale volume bit is required. The current logic
mistakenly sets this bit and incorrectly clears reserved bit 0, causing
the headphone output to be muted.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409-tables.c |  6 +++---
 sound/pci/hda/patch_cs8409.c        | 20 +++++++++++---------
 sound/pci/hda/patch_cs8409.h        |  5 +++--
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index 759f48038273..621f947e3817 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -121,7 +121,7 @@ static const struct cs8409_i2c_param cs42l42_init_reg_seq[] = {
 	{ CS42L42_MIXER_CHA_VOL, 0x3F },
 	{ CS42L42_MIXER_CHB_VOL, 0x3F },
 	{ CS42L42_MIXER_ADC_VOL, 0x3f },
-	{ CS42L42_HP_CTL, 0x03 },
+	{ CS42L42_HP_CTL, 0x0D },
 	{ CS42L42_MIC_DET_CTL1, 0xB6 },
 	{ CS42L42_TIPSENSE_CTL, 0xC2 },
 	{ CS42L42_HS_CLAMP_DISABLE, 0x01 },
@@ -315,7 +315,7 @@ static const struct cs8409_i2c_param dolphin_c0_init_reg_seq[] = {
 	{ CS42L42_ASP_TX_SZ_EN, 0x01 },
 	{ CS42L42_PWR_CTL1, 0x0A },
 	{ CS42L42_PWR_CTL2, 0x84 },
-	{ CS42L42_HP_CTL, 0x03 },
+	{ CS42L42_HP_CTL, 0x0D },
 	{ CS42L42_MIXER_CHA_VOL, 0x3F },
 	{ CS42L42_MIXER_CHB_VOL, 0x3F },
 	{ CS42L42_MIXER_ADC_VOL, 0x3f },
@@ -371,7 +371,7 @@ static const struct cs8409_i2c_param dolphin_c1_init_reg_seq[] = {
 	{ CS42L42_ASP_TX_SZ_EN, 0x00 },
 	{ CS42L42_PWR_CTL1, 0x0E },
 	{ CS42L42_PWR_CTL2, 0x84 },
-	{ CS42L42_HP_CTL, 0x01 },
+	{ CS42L42_HP_CTL, 0x0D },
 	{ CS42L42_MIXER_CHA_VOL, 0x3F },
 	{ CS42L42_MIXER_CHB_VOL, 0x3F },
 	{ CS42L42_MIXER_ADC_VOL, 0x3f },
diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 614327218634..b760332a4e35 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -876,7 +876,7 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 		{ CS42L42_DET_INT_STATUS2, 0x00 },
 		{ CS42L42_TSRS_PLUG_STATUS, 0x00 },
 	};
-	int fsv_old, fsv_new;
+	unsigned int fsv;
 
 	/* Bring CS42L42 out of Reset */
 	spec->gpio_data = snd_hda_codec_read(codec, CS8409_PIN_AFG, 0, AC_VERB_GET_GPIO_DATA, 0);
@@ -893,13 +893,15 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 	/* Clear interrupts, by reading interrupt status registers */
 	cs8409_i2c_bulk_read(cs42l42, irq_regs, ARRAY_SIZE(irq_regs));
 
-	fsv_old = cs8409_i2c_read(cs42l42, CS42L42_HP_CTL);
-	if (cs42l42->full_scale_vol == CS42L42_FULL_SCALE_VOL_0DB)
-		fsv_new = fsv_old & ~CS42L42_FULL_SCALE_VOL_MASK;
-	else
-		fsv_new = fsv_old & CS42L42_FULL_SCALE_VOL_MASK;
-	if (fsv_new != fsv_old)
-		cs8409_i2c_write(cs42l42, CS42L42_HP_CTL, fsv_new);
+	fsv = cs8409_i2c_read(cs42l42, CS42L42_HP_CTL);
+	if (cs42l42->full_scale_vol) {
+		// Set the full scale volume bit
+		fsv |= CS42L42_FULL_SCALE_VOL_MASK;
+		cs8409_i2c_write(cs42l42, CS42L42_HP_CTL, fsv);
+	}
+	// Unmute analog channels A and B
+	fsv = (fsv & ~CS42L42_ANA_MUTE_AB);
+	cs8409_i2c_write(cs42l42, CS42L42_HP_CTL, fsv);
 
 	/* we have to explicitly allow unsol event handling even during the
 	 * resume phase so that the jack event is processed properly
@@ -920,7 +922,7 @@ static void cs42l42_suspend(struct sub_codec *cs42l42)
 		{ CS42L42_MIXER_CHA_VOL, 0x3F },
 		{ CS42L42_MIXER_ADC_VOL, 0x3F },
 		{ CS42L42_MIXER_CHB_VOL, 0x3F },
-		{ CS42L42_HP_CTL, 0x0F },
+		{ CS42L42_HP_CTL, 0x0D },
 		{ CS42L42_ASP_RX_DAI0_EN, 0x00 },
 		{ CS42L42_ASP_CLK_CFG, 0x00 },
 		{ CS42L42_PWR_CTL1, 0xFE },
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index 5e48115caf09..14645d25e70f 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -230,9 +230,10 @@ enum cs8409_coefficient_index_registers {
 #define CS42L42_PDN_TIMEOUT_US			(250000)
 #define CS42L42_PDN_SLEEP_US			(2000)
 #define CS42L42_INIT_TIMEOUT_MS			(45)
+#define CS42L42_ANA_MUTE_AB			(0x0C)
 #define CS42L42_FULL_SCALE_VOL_MASK		(2)
-#define CS42L42_FULL_SCALE_VOL_0DB		(1)
-#define CS42L42_FULL_SCALE_VOL_MINUS6DB		(0)
+#define CS42L42_FULL_SCALE_VOL_0DB		(0)
+#define CS42L42_FULL_SCALE_VOL_MINUS6DB		(1)
 
 /* Dell BULLSEYE / WARLOCK / CYBORG Specific Definitions */
 
-- 
2.43.0


