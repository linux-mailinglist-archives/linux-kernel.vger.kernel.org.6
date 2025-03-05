Return-Path: <linux-kernel+bounces-547335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF41AA505FC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E2F3AD736
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4CF24FBE8;
	Wed,  5 Mar 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nv2MR6VK"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F921A316B;
	Wed,  5 Mar 2025 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194457; cv=none; b=E7rKmYE1C5AJlgN4toDlvzespPllOkQNp22iv5KPAnF1i06m26BSwbtBtcpziIFCmkdKdM+bg8Fy//GkSZ5rWNdGvYr1oeBlIXh9Ms5tDh63SI3Hw5mIPnoTm+OGbKrsSeCSBS6Yd7QdKAaikdyNYWK7xa+JiCuD02jaXhr7d7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194457; c=relaxed/simple;
	bh=xKF3QOuLjEao9ch6bimlkjR/xiqs57DCjyFdPX3khmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvPWrjQk6ocYXLtvq5yzZZoStPcVZrcL8sYe2GvhuP5uUb+CawGLJwywhi8y5Rhti2jgLHNN33zsop3N7/mZRzWMwGDiBQXSD01i1Tj3tSwZh2ISbL5RnvjmfGM3DAxJ+T2HNbKfrkiQtSxT/w+lVl7qZlJpJLTDGfFnEIqajhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=nv2MR6VK; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5254p2QC002458;
	Wed, 5 Mar 2025 11:07:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=tsOYMuT3YzJOQbuUEuocUjoexHb6aFf6KIBIxMxNndQ=; b=
	nv2MR6VKO6XLhzulxONVdY16sJ92np3XlnScWZ+OyPH5+tdP4mj9R/3wz5VKiElf
	GwqlM40yBuzHeQp32HVIWY6K42QYj5Se8BmgpgsvF5O+ylvwv+Tm6HKjFdSW4E8b
	Rm9i32xaXYEBAkIkp6Orltqe+0Yaw0BRllUt//cu7dtlIgZ4//7bLAGr7TMlHEpz
	HEiwPy7/HhHjPuNzTFSNfcT+z1eNbW8Ckx9Ef/DPkI4b0/ubFgTnWu8oWFnhFRdN
	GAXO2H1dB4N/KDqb+ZzwXIHHE2/cAL6axjClS4PtVmDeJ5UlQl9Xtkqpe8IPlsmf
	oJv55wnUquJ7tG5wvS54wQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 456e8nsap8-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 11:07:23 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Mar
 2025 17:07:21 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 17:07:21 +0000
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 0964C820270;
	Wed,  5 Mar 2025 17:07:21 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding
	<sbinding@opensource.cirrus.com>
Subject: [PATCH v1 7/7] ALSA: hda/realtek: Add support for ASUS Zenbook UM3406KA Laptops using CS35L41 HDA
Date: Wed, 5 Mar 2025 17:06:51 +0000
Message-ID: <20250305170714.755794-8-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305170714.755794-1-sbinding@opensource.cirrus.com>
References: <20250305170714.755794-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DpWs+H/+ c=1 sm=1 tr=0 ts=67c884cb cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=cGFEEDjkhq4frd4CDRsA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: c6AAFzmJ871WaojTXMw7Ab0F5LSYt1EZ
X-Proofpoint-ORIG-GUID: c6AAFzmJ871WaojTXMw7Ab0F5LSYt1EZ
X-Proofpoint-Spam-Reason: safe

Laptop uses 2 CS35L41 Amps with HDA, using External boost with I2C

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 99be1220de63..cda2596f294e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10645,6 +10645,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x10d3, "ASUS K6500ZC", ALC294_FIXUP_ASUS_SPK),
 	SND_PCI_QUIRK(0x1043, 0x1154, "ASUS TP3607SH", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x115d, "Asus 1015E", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x1043, 0x1194, "ASUS UM3406KA", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x11c0, "ASUS X556UR", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1204, "ASUS Strix G615JHR_JMR_JPR", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x1214, "ASUS Strix G615LH_LM_LP", ALC287_FIXUP_TAS2781_I2C),
-- 
2.43.0


