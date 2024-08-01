Return-Path: <linux-kernel+bounces-271538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BBD944FB1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1C61C242B0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E6813D2AF;
	Thu,  1 Aug 2024 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Jlzlc5+C"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9419E7E3;
	Thu,  1 Aug 2024 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722527583; cv=none; b=sBje7n2VvyI06+sQwJYjB4vK+IWgcQxWJaKQ/jVBWTk4zsBzquWqXHPjdcOKC6wT1dEc3m4tzrrkg3Ke6/OHjWngQLkweffH+KGtfEFarEB5Xfob2QpgtgZL8UdQ7jOWo0x31FqM9VzcsJ6B2UvfcuIrWskFZESlsTcY6C8nHQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722527583; c=relaxed/simple;
	bh=lQk44XHczDRYM6nLafmMm+oVfZnAi9uGJ3MVHbLyH5Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XImaExGM0Cb78tWSpRfmrRj+3DEVQ6UYKwmjpS82+hPnAdbl2w50pgdQqDmkZO3eQMG0tGMVBwDBeUxNFwiUMhzz6IAt1M4sk8YQ3Q8WcyCcjH/+gDje/FDk792CLneg0RxKuGnnqQ6n0UD/XrPFm9xXCIfF9Jgw4B+C47obSfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Jlzlc5+C; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471B7jT0018617;
	Thu, 1 Aug 2024 10:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=vA4YnIoXhgtb2Vr+
	Sw8CAqszqP5Gp8SLedy8ZRCd80c=; b=Jlzlc5+C0pXc2dC1O2YErBcSTEALtPfU
	hsN3TmgymVMnC0ZxLU5sPbZb/HXoybh4jpqI+EndGVvIY03nYkT/EmAQPpo3TclN
	FUq43Fe7KsEvagBBRr8TxnmYDhQeqGLgm4bOGAIOlva14q4nhXhlJrUDv4rbWZTW
	yjj4d6TzGOLJN2SL4OB0Ky7PqJreSjEw8yICZWK6OBYNjXoFsKvnCQjrKZ0nCkIx
	kSAZjKeMEZXQYUTks4S4bYQJXVeq6pg9+h9RR6G+oDFdtl9x27a0dK2MFHN1ZFIy
	UPtu2MAllf8kcJvOJLYsyv4NgJOP0sFxe5lei0nhZxmQyebOIu1pKw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40qjw9ah0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 10:50:53 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 1 Aug 2024
 16:50:51 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 1 Aug 2024 16:50:51 +0100
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id A31F0820244;
	Thu,  1 Aug 2024 15:50:51 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v2] ALSA: hda: cs35l41: Stop creating ALSA Controls for firmware coefficients
Date: Thu, 1 Aug 2024 16:50:44 +0100
Message-ID: <20240801155047.456540-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 8yjjT0z8P8zD35W4P3UWYpdfW3LQyWuJ
X-Proofpoint-ORIG-GUID: 8yjjT0z8P8zD35W4P3UWYpdfW3LQyWuJ
X-Proofpoint-Spam-Reason: safe

When the CS35L41 loads its firmware, it has a number of controls to
affect its behaviour. Currently, these controls are exposed as ALSA
Controls.

These controls were never intended to be exposed to users but the
firmware doesn't mark them hidden, so make the driver ignore them.

Any changes in the coefficients handled by these controls needs to
be matched to the individual system by SSID, which is already handled
using the tuning file, when firmware is loaded, so UCM should not be
setting these controls anyway.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 4b411ed8c3fe..3a92e98da72d 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -133,17 +133,6 @@ static const struct reg_sequence cs35l41_hda_mute[] = {
 	{ CS35L41_AMP_DIG_VOL_CTRL,	0x0000A678 }, // AMP_HPF_PCM_EN = 1, AMP_VOL_PCM Mute
 };
 
-static void cs35l41_add_controls(struct cs35l41_hda *cs35l41)
-{
-	struct hda_cs_dsp_ctl_info info;
-
-	info.device_name = cs35l41->amp_name;
-	info.fw_type = cs35l41->firmware_type;
-	info.card = cs35l41->codec->card;
-
-	hda_cs_dsp_add_controls(&cs35l41->cs_dsp, &info);
-}
-
 static const struct cs_dsp_client_ops client_ops = {
 	.control_remove = hda_cs_dsp_control_remove,
 };
@@ -603,8 +592,6 @@ static int cs35l41_init_dsp(struct cs35l41_hda *cs35l41)
 	if (ret)
 		goto err;
 
-	cs35l41_add_controls(cs35l41);
-
 	cs35l41_hda_apply_calibration(cs35l41);
 
 err:
-- 
2.43.0


