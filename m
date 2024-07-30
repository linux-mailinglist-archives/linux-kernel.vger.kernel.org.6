Return-Path: <linux-kernel+bounces-267704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 504BA94148E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD631F2459D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFAB1A2567;
	Tue, 30 Jul 2024 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YxbTTaBC"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2BA19DF41;
	Tue, 30 Jul 2024 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350405; cv=none; b=NO6FHgdY98mgzEiXmuhGJgHhBLFv/J01CRMQtUqT1i92gHYmQO6oZOUT40NiRalL+PAjDg9TIjBAEstAaceByIIc84Mqk+Szbi/XbykUIh6MNk84kIa3+GkHHszeGMj3sLH1OF5SEtwcSjNV4fqeODTnpOyIvmUVNZ4N608kptI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350405; c=relaxed/simple;
	bh=t9jAeD4j0jVid6BC2wnJl/6g4yMrWkaHlTKb22lrknI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LAgGG+bjXugc/1kuFEIKZqyS92gRJNj933bI1Z8eMbOliPv/Pp1tiQU6MbOiGjQJcTxylokMtit1iKWIqyRD6IfFWCK+5PLfNYl2jI00R0HLFtc8Tg7oGb81DquEsDTYyHRGgAofUITnIUtir9AZuogCJLD6CNPIXV/VFUIJVrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=YxbTTaBC; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U5LVV0006061;
	Tue, 30 Jul 2024 09:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=Dmt1vMuq1R2aPYy1
	HyO8eAJxFYFqYaPrRiDVFF19+Dg=; b=YxbTTaBCOx/mjROfhfaFmqCmphcOli+n
	YaYvWIYgLyL2u/nbpvQm6to1S5tmbY7ajDnuhwIuHnKhDXMvcqx3b4uWGdd2hiAt
	KJQeAIJ5uRaCF12i2rm8rUpraLRgdGRyO72cxrWkbmmjSvgDhUdIB3eS+wIWjBDS
	RiDPxoHH8V81he6Enyc2TMIp8dPbspZ7nrSC8kjOsDJD0JmPwgRuRSOFgBngruJ7
	pEX4Ufyf+Ta8KbAtu4Yk6VJwHgwpB5bfnJkeR7N1D5tANFv3jd9FRKt9JuX86x9c
	ogyLhHP8FXzvcdBnLQg5bf6UBrYAIvD7dmFbFFJ9PvZSLwa6tvE68w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40mwajugag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 09:37:54 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Jul
 2024 15:37:52 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 30 Jul 2024 15:37:52 +0100
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3EA14820244;
	Tue, 30 Jul 2024 14:37:52 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1] ALSA: hda: cs35l41: Stop creating ALSA Controls for firmware coefficients
Date: Tue, 30 Jul 2024 15:37:28 +0100
Message-ID: <20240730143748.351651-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: wluP2XWrgs5Kye9c4U-mIZlXHZppvhUz
X-Proofpoint-ORIG-GUID: wluP2XWrgs5Kye9c4U-mIZlXHZppvhUz
X-Proofpoint-Spam-Reason: safe

Add a kernel parameter to allow coefficients to be exposed as ALSA controls.

When the CS35L41 loads its firmware, it has a number of controls to
affect its behaviour. Currently, these controls are exposed as ALSA
Controls by default.

However, nothing in userspace currently uses them, and is unlikely to
do so in the future, therefore we don't need to create ASLA controls
for them.

These controls can be useful for debug, so we can add a kernel
parameter to re-enable them if necessary.

Disabling these controls would prevent userspace from trying to read
these controls when the CS35L41 is hibernating, which ordinarily
would result in an error message.

Also change the formatting of the other module parameter in
cs35l41_hda.c to match the new parameter.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 4b411ed8c3fe..43d49a69ca14 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -76,8 +76,13 @@ static const struct cirrus_amp_cal_controls cs35l41_calibration_controls = {
 
 static bool firmware_autostart = 1;
 module_param(firmware_autostart, bool, 0444);
-MODULE_PARM_DESC(firmware_autostart, "Allow automatic firmware download on boot"
-			     "(0=Disable, 1=Enable) (default=1); ");
+MODULE_PARM_DESC(firmware_autostart,
+		 "Allow automatic firmware download on boot, (0=Disable, 1=Enable) (default=1)");
+
+static bool expose_dsp_controls;
+module_param(expose_dsp_controls, bool, 0444);
+MODULE_PARM_DESC(expose_dsp_controls,
+		 "Expose DSP controls as ALSA controls on boot, (0=Disable, 1=Enable) (default=0)");
 
 static const struct reg_sequence cs35l41_hda_config[] = {
 	{ CS35L41_PLL_CLK_CTRL,		0x00000430 }, // 3072000Hz, BCLK Input, PLL_REFCLK_EN = 1
@@ -603,7 +608,8 @@ static int cs35l41_init_dsp(struct cs35l41_hda *cs35l41)
 	if (ret)
 		goto err;
 
-	cs35l41_add_controls(cs35l41);
+	if (expose_dsp_controls)
+		cs35l41_add_controls(cs35l41);
 
 	cs35l41_hda_apply_calibration(cs35l41);
 
-- 
2.43.0


