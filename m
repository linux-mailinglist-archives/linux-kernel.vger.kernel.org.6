Return-Path: <linux-kernel+bounces-544508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 077B2A4E1F1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7381888CD7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818CE276D3C;
	Tue,  4 Mar 2025 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="p5AyZn9e"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492B1209F53;
	Tue,  4 Mar 2025 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099818; cv=none; b=W5hJSCyVPi0gzyQl897AfyQ/Hg5Vv1rh/sVzX8u/n/oI0IGbqL0tIW04B1tcRHc0h0AjdmK+GTRa0WLC9MxEP7WTSy7hm6ABnCywoLcOQunutlDeohp3eLvpeYKCQy1I8J2G77X2EKO2E3N88EINgwXXMe95hvppqNWsNiSJuSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099818; c=relaxed/simple;
	bh=PdMK50kHKvLXxZDAUAQmvEbuSLS25BrQE6dtAirLsGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRWUFHA/zV2l72Adg8V2pSh5QfV2EKuQ0iJLEunW/zs8UGACo5CHSzoCTOzlP3FpbzW7kEjoGD9C309YBXsYBik9Ldr/B7rLCSfHauQCbNb+yVaHGqtf3LehBksGlwn+/ZotoxoyM2l3HbdD+CTebn0xocKzFjl3UXc2k8SCtVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=p5AyZn9e; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5245gdjx021938;
	Tue, 4 Mar 2025 08:50:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Q4c8idnoRhQhonFIfYlGR5z+11twpSRuSEJHCSMIk4o=; b=
	p5AyZn9ejczjblbadMSSOAnW7NRKugq1ZOSyTAgYRrAjkScwKbPhe6lZHhcGK+bv
	DEg4ZQzk6i673CsuYId+7VHWhpS4AjVpzNArJIm8iJTbZP3kzIJsxdo3UgZwYot2
	3+7dKMqHxyRTQrk+RObvsJAMrO+g7P6ANuCTiCZOj02wFZXMM9Cwui9jeeejfAGN
	IlJbibFe9vZQgcCTAdHarvKkNtuQ6Y+ABiAHqymkbxi6jJ0cjHV6c8K/qD1g/3/Q
	SUx1RQH5OavMrXZ46NnXPAVeVw6Zg33D8Llp9b/OASF5EqoNaBqoQtSU9qWi++qJ
	g3dJIBpouE50X16ZwWPgDw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyj3j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:50:13 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 14:50:11 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 14:50:11 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1958B820270;
	Tue,  4 Mar 2025 14:50:11 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <yung-chuan.liao@linux.intel.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH for-next 2/2] ASoC: Intel: tgl-match: Add CS35L56 on SSP2 for CDB35L56-FOUR board
Date: Tue, 4 Mar 2025 14:50:10 +0000
Message-ID: <20250304145010.288082-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304145010.288082-1-rf@opensource.cirrus.com>
References: <20250304145010.288082-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: yEcAHOaAZWchQyjbwvmXEoOZP6aP_B7S
X-Proofpoint-ORIG-GUID: yEcAHOaAZWchQyjbwvmXEoOZP6aP_B7S
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c71325 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=yoF4US7cGVVEIrFK7tgA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

This adds a match for CS35L56 on SSP2, as used on the Cirrus
Logic CDB35L56-FOUR board, and also adds an entry in ssp-common
for the CS35L56.

The intended host is an Aaeon UpXtreme i11 (TGL). This board does
not have NHLT so the SSP and topology are hardcoded.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/soc-acpi-intel-ssp-common.h          | 2 ++
 sound/soc/intel/common/soc-acpi-intel-ssp-common.c | 1 +
 sound/soc/intel/common/soc-acpi-intel-tgl-match.c  | 5 +++++
 3 files changed, 8 insertions(+)

diff --git a/include/sound/soc-acpi-intel-ssp-common.h b/include/sound/soc-acpi-intel-ssp-common.h
index b4597c8dac78..0865be3daf32 100644
--- a/include/sound/soc-acpi-intel-ssp-common.h
+++ b/include/sound/soc-acpi-intel-ssp-common.h
@@ -9,6 +9,7 @@
 /* Cirrus Logic */
 #define CS35L41_ACPI_HID	"CSC3541"
 #define CS42L42_ACPI_HID	"10134242"
+#define CS35L56_ACPI_HID	"CSC355C"
 
 /* Dialog */
 #define DA7219_ACPI_HID		"DLGS7219"
@@ -53,6 +54,7 @@ enum snd_soc_acpi_intel_codec {
 
 	/* speaker amplifier */
 	CODEC_CS35L41,
+	CODEC_CS35L56,
 	CODEC_MAX98357A,
 	CODEC_MAX98360A,
 	CODEC_MAX98373,
diff --git a/sound/soc/intel/common/soc-acpi-intel-ssp-common.c b/sound/soc/intel/common/soc-acpi-intel-ssp-common.c
index f56f4bfa5187..120ed129ca3f 100644
--- a/sound/soc/intel/common/soc-acpi-intel-ssp-common.c
+++ b/sound/soc/intel/common/soc-acpi-intel-ssp-common.c
@@ -48,6 +48,7 @@ static const struct codec_map codecs[] = {
 static const struct codec_map amps[] = {
 	/* Cirrus Logic */
 	CODEC_MAP_ENTRY("CS35L41", "cs35l41", CS35L41_ACPI_HID, CODEC_CS35L41),
+	CODEC_MAP_ENTRY("CS35L56", "cs35l56", CS35L56_ACPI_HID, CODEC_CS35L56),
 
 	/* Maxim */
 	CODEC_MAP_ENTRY("MAX98357A", "max98357a", MAX_98357A_ACPI_HID, CODEC_MAX98357A),
diff --git a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
index b77aafb0bfb6..fe99e77c21b5 100644
--- a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
@@ -532,6 +532,11 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
 		.quirk_data = &tgl_lt6911_hdmi,
 		.sof_tplg_filename = "sof-tgl-rt1308-ssp2-hdmi-ssp15.tplg"
 	},
+	{
+		.id = CS35L56_ACPI_HID,
+		.drv_name = "tgl_cs35l56_ssp2_def",
+		.sof_tplg_filename = "sof-tgl-cs35l56-ssp2.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_tgl_machines);
-- 
2.39.5


