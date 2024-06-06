Return-Path: <linux-kernel+bounces-204314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A294D8FE719
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5701C1F26257
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6B3195B3C;
	Thu,  6 Jun 2024 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Ku281UW2"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADBE195B31;
	Thu,  6 Jun 2024 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679174; cv=none; b=RWGy5mxoS5QlaDiMZme//Tt0Ev+tjIkWKav5HVtDYNIXF2Cvok6VQ0lY/aboaDri67cszx1WLFiUbQfoGYuLx3Uz2ghf6Mp0NM7bxNTRBsE4e5SkANcgd1+wck+f44KgTQCHJpEYxth1rnoSZ8qWMx14+eoETnWM9RVn3NmlB1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679174; c=relaxed/simple;
	bh=Tp6wP+IiUzNwJhS8uTGND8lmdrlCNCVC1Ss82iqyxQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIVvyx+/A8PD9P8Rl4R75a4bgSigojxg2mBEcTsmMZpM12LTn/sWOZ4Zn/kgt2Ty9eRWsTFXwHM/38XZsDTqit8PlzU/HMqAOUUi+cYXsDE3mglwY7oYOezmB0zu6T1yMdMy1zZA0OEDblxGjo3TTW4rgXzVJVDCbQGOgLanhYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Ku281UW2; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4564ueAa021615;
	Thu, 6 Jun 2024 08:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=GUbMaD2PpQP+ANm8Yi6q+kmBfu7Q89wlNpJCsxvENus=; b=
	Ku281UW2JZgc+74MvOBpt1kzoc4KBoj2KMzcu7EyZSAlRXZtJwM15L/14uCWF1TT
	pNasOfmTWE0cc4ktgwO95hy31jKlnW4E0f+q5trfshKQDNT6CU0JxcL4g95/wPfJ
	tBA4YFcsv7ee9AcilUfShSH0F/Ngh7jul3bOO0Yy7T07pYaQl/Bz1vXQl++CqPlQ
	iNDKMFgj3ycTMnEuwHMVHlGGmCj8MG6mhtYSoTAt0JDM5lB/Prf/LKKR6NR2sBED
	XFP/YTPSjDWnpBPaSPxJdEOpB3R0XZEQsOJGgg/v/PWngsn3e+hHhA9gCPYetTdY
	UqB9sbfy2Li2Z44DKbfCLQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3yg02hn5xp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 08:03:59 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 14:03:57 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 6 Jun 2024 14:03:57 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.61.65.44])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 5EDD4820259;
	Thu,  6 Jun 2024 13:03:57 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 3/4] ALSA: hda/realtek: Support Lenovo Thinkbook 16P Gen 5
Date: Thu, 6 Jun 2024 14:03:50 +0100
Message-ID: <20240606130351.333495-4-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606130351.333495-1-sbinding@opensource.cirrus.com>
References: <20240606130351.333495-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 583GiSrnpYDsCigqm-WQwWhFCSyubJ1c
X-Proofpoint-ORIG-GUID: 583GiSrnpYDsCigqm-WQwWhFCSyubJ1c
X-Proofpoint-Spam-Reason: safe

Add support for this laptop, which uses CS35L41 HDA amps.
The laptop does not contain valid _DSD for these amps, so requires
entries into the CS35L41 configuration table to function correctly.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index aa76d1c88589..6cb258978666 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10544,6 +10544,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38cd, "Y790 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38d2, "Lenovo Yoga 9 14IMH9", ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x38d7, "Lenovo Yoga 9 14IMH9", ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x38F9, "Thinkbook 16P Gen5", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38FA, "Thinkbook 16P Gen5", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
-- 
2.34.1


