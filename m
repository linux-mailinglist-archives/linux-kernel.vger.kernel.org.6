Return-Path: <linux-kernel+bounces-547336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AA5A505F8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3AEC188E304
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293B22500B1;
	Wed,  5 Mar 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YEzWvUz5"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FDB1A317E;
	Wed,  5 Mar 2025 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194457; cv=none; b=XOk5thdXwrdXPyTR+Tj+yW4xoOqEZxYWOll5K3FUasYCaH/iTl/n1Uh0JIrzZg+ifQMkwJVFejbOHaafk72CLrDEUAM2fPo2VyR54zknYtE6yXzyUKyWN9gZEVX6BkoTY4cUudd/W59uEfiuFjFZXK/BoTpCJl4+T7PQK7YDJ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194457; c=relaxed/simple;
	bh=Y7YxX2l3iQb0IM6oa8fgI0o/1U7mMHeD27C0mht4JVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9ksMY1o+h6a2jsN7CRW5dRwazk4e5yLrSKFtDcswemEn+j33aW8DrI2uHOyiDtrl1c6HAMLT1Iv/n633WwS1wRXvHywxpScvzBpBJJ0FDkYm56uy7107bwUvw2U54wFWRQW6RItVcMFBz9DquJvKVGlr3/cTGpcZNalzdbToKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=YEzWvUz5; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5254p2Q9002458;
	Wed, 5 Mar 2025 11:07:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=2iNKt25cL2fH0qIHZYEWmxjSeXZcVc6Ql1ZfIJljUy8=; b=
	YEzWvUz5GBIjzEashYY+irQYknsTNkJG4NGeHtJCzx5X3yCPD/QM2sTGVg9dM5Ho
	hCktQgDpNra5BMurpeFUkgjCoSdjnGbFwI0sfBFkYGcDQ8JOiZeKUMjFnS+K4Sci
	OjmXt6ALX3UOz4dCLgRAJ7wXydgpGeKhs4KFZPwMovDSzHNHxeLRcLH1nUW36gtq
	7WeaobsVjK2viSoOHE60oqtdgLBoaJ3WpABYJbF2NYML5i2HVSir/ndXHIxAAxdR
	Dfi6Ln+plKkY4sx7Ga3AO4G1uz3EdKSqs0bSKIxFwlricBI28QSglRHdmFwedam/
	xG0/rlDaaEa/VaXnpx4aVA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 456e8nsap8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 11:07:21 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Mar
 2025 17:07:19 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 17:07:19 +0000
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B5FE182026B;
	Wed,  5 Mar 2025 17:07:19 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding
	<sbinding@opensource.cirrus.com>
Subject: [PATCH v1 1/7] ALSA: hda/realtek: Add support for ASUS ROG Strix G814 Laptop using CS35L41 HDA
Date: Wed, 5 Mar 2025 17:06:45 +0000
Message-ID: <20250305170714.755794-2-sbinding@opensource.cirrus.com>
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
X-Authority-Analysis: v=2.4 cv=DpWs+H/+ c=1 sm=1 tr=0 ts=67c884ca cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=v0MoPBhksWDeor11JeoA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: X-XO4k_0SzOoRLoV_aXDLYMfMHxHwACN
X-Proofpoint-ORIG-GUID: X-XO4k_0SzOoRLoV_aXDLYMfMHxHwACN
X-Proofpoint-Spam-Reason: safe

Add support for ASUS G814PH/PM/PP and G814FH/FM/FP.

Laptops use 2 CS35L41 Amps with HDA, using Internal boost, with I2C.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ca10b9e9e3a4..d23d6fafd009 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10743,6 +10743,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x3a40, "ASUS G814JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a50, "ASUS G834JYR/JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a60, "ASUS G634JYR/JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
+	SND_PCI_QUIRK(0x1043, 0x3e00, "ASUS G814FH/FM/FP", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1043, 0x3e20, "ASUS G814PH/PM/PP", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x3e30, "ASUS TP3607SA", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x3ee0, "ASUS Strix G815_JHR_JMR_JPR", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x3ef0, "ASUS Strix G635LR_LW_LX", ALC287_FIXUP_TAS2781_I2C),
-- 
2.43.0


