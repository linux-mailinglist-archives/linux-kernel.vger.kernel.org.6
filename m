Return-Path: <linux-kernel+bounces-295317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DBB95999C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656CC1C21959
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF5320E891;
	Wed, 21 Aug 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dwT6vNOf"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D17120E886;
	Wed, 21 Aug 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724235029; cv=none; b=THm3+q27EsvtCh5JHNPH1lPiz3hXhnMxaX618oyMkynUjfC2+nyWS/wr725kztKJnpFVKV1HXERAQ4DfhrBuo1A0dWjSAagKUWW5rhLp3Q4Bob41dDFBlArUZyx/afFACA8peFP5xbdssU/98Z1QfbqdjNZrT0zAz8nGa7owqZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724235029; c=relaxed/simple;
	bh=Lx7jwuo6J8Ost+MPgZWKVy6/+qVZbw9oxb1dHunwnTk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rDHxxijLYfe6IH6oU18GaK1v0Y0Xi4w0YvYuWXk+8eihfO60ev4992Uwnt3CPNh2DToh2zt84Lc5ObW42dTHPtp/OIuTSWZMSq25+ngAhAUX826e12BDFRT0lJk12VS7ZQc1BfZ+677Q0OtsZGBgufcVTPO6OiSGBO1ZpXFc3s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=dwT6vNOf; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L4e6LG007283;
	Wed, 21 Aug 2024 05:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=SSyno9oNLXGnpqoj
	/MvwdCHpBYzjjT/KQnDu8AVeWDg=; b=dwT6vNOfIlPxtdl8OUrVyXp+rEBEI1EC
	k27IwyY8+Ydjjo/Am4eWocIYdMtn66ye0RjMsJ4+8QygOfC2oPJvcQj4zw/dU6Xj
	dbYf02xoxk8sa8T8VOTkLx4xTklVnIuWvmjAerseLiunEohGh8noXYb5TktBeQWB
	j02Vk0wWX9ob39vfvie2dhdbVv1FKxmRc87rgGmDYN+uf80Kw03lXsUVzE3nPBxW
	eFxBLfNIQm09TCBCdzFy0rZt3k+/LX6Vc9/Yc3rLvvT8AT831ygQnkfFhqM1KVeU
	UgX3yVWI4eNP8POREKipDUfg0MTON4R6C1Z39IN/Fb05Z8bX8CyhrA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 412r9hv3jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 05:10:11 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 Aug
 2024 11:02:21 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 21 Aug 2024 11:02:21 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id AB18E820244;
	Wed, 21 Aug 2024 10:02:21 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs-amp-lib: Ignore empty UEFI calibration entries
Date: Wed, 21 Aug 2024 11:02:21 +0100
Message-ID: <20240821100221.99699-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2eb-ZgEUsc37O-AvjggW0FxEDDHgs08e
X-Proofpoint-ORIG-GUID: 2eb-ZgEUsc37O-AvjggW0FxEDDHgs08e
X-Proofpoint-Spam-Reason: safe

If the timestamp of a calibration entry is 0 it is an unused entry and
must be ignored.

Some end-products reserve EFI space for calibration entries by shipping
with a zero-filled EFI file. When searching the file for calibration
data the driver must skip the empty entries. The timestamp of a valid
entry is always non-zero.

The type of struct cirrus_amp_efi_data.calTime has been changed from an
array of two u32 to a single u64. The timestamp is a 64-bit value and
treating it as such simplifies the code.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 1cad8725f2b9 ("ASoC: cs-amp-lib: Add helpers for factory calibration data")
---
 include/sound/cs-amp-lib.h    | 2 +-
 sound/soc/codecs/cs-amp-lib.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/sound/cs-amp-lib.h b/include/sound/cs-amp-lib.h
index f481148735e1..77c4c1c9cf1a 100644
--- a/include/sound/cs-amp-lib.h
+++ b/include/sound/cs-amp-lib.h
@@ -14,7 +14,7 @@ struct cs_dsp;
 
 struct cirrus_amp_cal_data {
 	u32 calTarget[2];
-	u32 calTime[2];
+	u64 calTime;
 	s8  calAmbient;
 	u8  calStatus;
 	u16 calR;
diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index 605964af8afa..8aaca88ef1b6 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -182,6 +182,10 @@ static int _cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid,
 		for (i = 0; i < efi_data->count; ++i) {
 			u64 cal_target = cs_amp_cal_target_u64(&efi_data->data[i]);
 
+			/* Skip empty entries */
+			if (efi_data->data[i].calTime == 0)
+				continue;
+
 			/* Skip entries with unpopulated silicon ID */
 			if (cal_target == 0)
 				continue;
@@ -193,7 +197,8 @@ static int _cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid,
 		}
 	}
 
-	if (!cal && (amp_index >= 0) && (amp_index < efi_data->count)) {
+	if (!cal && (amp_index >= 0) && (amp_index < efi_data->count) &&
+	    (efi_data->data[amp_index].calTime != 0)) {
 		u64 cal_target = cs_amp_cal_target_u64(&efi_data->data[amp_index]);
 
 		/*
-- 
2.39.2


