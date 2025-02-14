Return-Path: <linux-kernel+bounces-515293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ADEA362FD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDD316B9FB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A60267AF7;
	Fri, 14 Feb 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="H105/2Jg"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E81A267739;
	Fri, 14 Feb 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550259; cv=none; b=UHFJi7bu5taWkEalA5AU/WTRV9uc/DISisZO9Pd69mqe71uHIOTdJK/MJ9jx/5lhsde9305+0TyDEn0Olttm4m7Z3CZGAnc58pmwePlMHK7XdVJrkNCplAqYg+/WC1wCBqJGB3dBFzOlfskPH8cgn297XsSz3+IVtZGIYcUKakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550259; c=relaxed/simple;
	bh=7AgIKn7csdyYxmF3m/Q7J4+PJzNeiOLf9q091XJ4E/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8yQpiuHIkBfBS/ffAmrf/r/4rMDbIknuS4xhRWl4VjGdvlNPx40oZMR3vGF+9SFhNGvydRPMKJ97jX++utD+dZORFhGa5kDCrgzh9xTb2xEEg+G9KQlWh8tszSahov7xlJRi6KK+TMxK4cypVo4DG8H+T+LD3oWSToGlzu1G/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=H105/2Jg; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E4od4M018291;
	Fri, 14 Feb 2025 10:24:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=0VhoGhsglbZJj1oXUFMWOU4f5t2yztkzd93wyUTPzZY=; b=
	H105/2JgbrA/WYv3hsQb3DdrPqxFmYe1eURYuGZwqywplmHsLdBRy7SFG9rAX3SV
	+ajzfrON5XUCtGCY3F7M1H5CleZrlaKPvCT32uO+X3WzWfsFhhN3O2QzXAFMflZh
	ZOuijwwZCAltfP9iqSFe83mohBzkECHICoAfeEWY7urydM+6ob7ZDASYQxg3MtMx
	clwzASLLgSQX4LPvObjDmzVLidWbAQ+454btL23XAIAoeIVp8ZdEo28wZQ36cU/7
	E6Y90VqqB8K9eKiqP3xsEeB3Nr4j109JD8ur8VyL1Bz8IyEoG6ZQlKacSsXCf1Zg
	tmrL7BHnYgnecvNlYXl6yw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 44rpsvcvvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 10:24:04 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 14 Feb
 2025 16:24:02 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Fri, 14 Feb 2025 16:24:02 +0000
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2A48B82025A;
	Fri, 14 Feb 2025 16:24:02 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Vitaly Rodionov
	<vitalyr@opensource.cirrus.com>
Subject: [PATCH 2/2] ALSA: hda/cirrus: Reduce codec resume time
Date: Fri, 14 Feb 2025 16:23:26 +0000
Message-ID: <20250214162354.2675652-2-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214162354.2675652-1-vitalyr@opensource.cirrus.com>
References: <20250214162354.2675652-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=O73DvA9W c=1 sm=1 tr=0 ts=67af6e24 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=U9z2HhxXZIhU2ysfx1IA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=GIWBuCPpE9siKy2bWEcf:22
 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-ORIG-GUID: yjz1QX87CfhbG4UR3NR9bStIaeQ14Hgh
X-Proofpoint-GUID: yjz1QX87CfhbG4UR3NR9bStIaeQ14Hgh
X-Proofpoint-Spam-Reason: safe

This patch reduces the resume time by half and introduces an option to
include a delay after a single write operation before continuing.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409-tables.c | 6 +++---
 sound/pci/hda/patch_cs8409.c        | 6 +++++-
 sound/pci/hda/patch_cs8409.h        | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index 621f947e3817..09240138e087 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -131,7 +131,7 @@ static const struct cs8409_i2c_param cs42l42_init_reg_seq[] = {
 	{ CS42L42_RSENSE_CTL3, 0x00 },
 	{ CS42L42_TSENSE_CTL, 0x80 },
 	{ CS42L42_HS_BIAS_CTL, 0xC0 },
-	{ CS42L42_PWR_CTL1, 0x02 },
+	{ CS42L42_PWR_CTL1, 0x02, 10000 },
 	{ CS42L42_ADC_OVFL_INT_MASK, 0xff },
 	{ CS42L42_MIXER_INT_MASK, 0xff },
 	{ CS42L42_SRC_INT_MASK, 0xff },
@@ -328,7 +328,7 @@ static const struct cs8409_i2c_param dolphin_c0_init_reg_seq[] = {
 	{ CS42L42_RSENSE_CTL3, 0x00 },
 	{ CS42L42_TSENSE_CTL, 0x80 },
 	{ CS42L42_HS_BIAS_CTL, 0xC0 },
-	{ CS42L42_PWR_CTL1, 0x02 },
+	{ CS42L42_PWR_CTL1, 0x02, 10000 },
 	{ CS42L42_ADC_OVFL_INT_MASK, 0xff },
 	{ CS42L42_MIXER_INT_MASK, 0xff },
 	{ CS42L42_SRC_INT_MASK, 0xff },
@@ -384,7 +384,7 @@ static const struct cs8409_i2c_param dolphin_c1_init_reg_seq[] = {
 	{ CS42L42_RSENSE_CTL3, 0x00 },
 	{ CS42L42_TSENSE_CTL, 0x80 },
 	{ CS42L42_HS_BIAS_CTL, 0xC0 },
-	{ CS42L42_PWR_CTL1, 0x06 },
+	{ CS42L42_PWR_CTL1, 0x06, 10000 },
 	{ CS42L42_ADC_OVFL_INT_MASK, 0xff },
 	{ CS42L42_MIXER_INT_MASK, 0xff },
 	{ CS42L42_SRC_INT_MASK, 0xff },
diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index b760332a4e35..e50006757a2c 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -346,6 +346,11 @@ static int cs8409_i2c_bulk_write(struct sub_codec *scodec, const struct cs8409_i
 
 		if (cs8409_i2c_wait_complete(codec) < 0)
 			goto error;
+		/* Certain use cases may require a delay
+		 * after a write operation before proceeding.
+		 */
+		if (seq[i].delay)
+			fsleep(seq[i].delay);
 	}
 
 	mutex_unlock(&spec->i2c_mux);
@@ -888,7 +893,6 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 
 	/* Initialize CS42L42 companion codec */
 	cs8409_i2c_bulk_write(cs42l42, cs42l42->init_seq, cs42l42->init_seq_num);
-	msleep(CS42L42_INIT_TIMEOUT_MS);
 
 	/* Clear interrupts, by reading interrupt status registers */
 	cs8409_i2c_bulk_read(cs42l42, irq_regs, ARRAY_SIZE(irq_regs));
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index 14645d25e70f..e4bd2e12110b 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -229,7 +229,6 @@ enum cs8409_coefficient_index_registers {
 #define CS42L42_I2C_SLEEP_US			(2000)
 #define CS42L42_PDN_TIMEOUT_US			(250000)
 #define CS42L42_PDN_SLEEP_US			(2000)
-#define CS42L42_INIT_TIMEOUT_MS			(45)
 #define CS42L42_ANA_MUTE_AB			(0x0C)
 #define CS42L42_FULL_SCALE_VOL_MASK		(2)
 #define CS42L42_FULL_SCALE_VOL_0DB		(0)
@@ -291,6 +290,7 @@ enum {
 struct cs8409_i2c_param {
 	unsigned int addr;
 	unsigned int value;
+	unsigned int delay;
 };
 
 struct cs8409_cir_param {
-- 
2.43.0


