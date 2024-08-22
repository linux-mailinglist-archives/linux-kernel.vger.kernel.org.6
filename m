Return-Path: <linux-kernel+bounces-297365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE61095B6F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8625B286636
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED6E1CB30F;
	Thu, 22 Aug 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="oOdP3C/X"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D301CB150;
	Thu, 22 Aug 2024 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333764; cv=none; b=ctiGUgHGnfzCJ1uuzd99gxg6sh/gHd7NDTw/LS+9DoDrM6vOKwS/5sCbn9Id7ddBJ6frDMQLaQfavD8Q5X4KNQ5/wH0Y2ZYPbPjPAM+Ke9jQNuo7ynzY8UJoGnkAYVd6luHmr+qCdOKvHG2JZgZY1FKoprUK3nWJHynkuiLPRis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333764; c=relaxed/simple;
	bh=2O5PLnrJLKc8Zi5w8xYVVUK98bcjPiBPPwclE0xMhV8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LrwbK69J1srWk891qETH6q8F2n8Qni1K/Cop4NgBCHtD69kBTVitrDZLkGvEHYTWqDle8ZRBojpUU1s8+P/zvJIm/33L8U+poDy2ybHqvUp05kuQkn1ckr9cA6sSiqYHXVT01rmXujITN8hqp6Dtox/WoavLDjX4wCyLo0gxmcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=oOdP3C/X; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47M5LL3n028633;
	Thu, 22 Aug 2024 08:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=UHZT8jiYyWQuWa1T
	GUgXZFk/vZ7UrsdwcoU5TMMVrug=; b=oOdP3C/XdYsiCLzBI/0RMmA0VMTjlpHv
	6VSlSL2fqONW5v+7J26vr9ro6NZwVkwrOcnF6lulZzhEey7p4m7PpPRqC/7AQDOn
	yN2f2usciE8ufqQDV2fS7yRe8/BCHpEsCAARnUnI5lWKLBbywoetzpwytKLNaFvU
	I6NMlMFqUyGe9z9JNgQRZEAMEhMhZMhCVShrQIGWyu4VQBl9ZjJTSS7PjgIA1Yc1
	7IomXJbOsUD3yAj0ygmUIpah02ANVo2yRdaLXYAtvnB+iquAv5WnUDkTNnNM6sIm
	K5aqIfiTsGgi0DDXILerbpN/YpEafIEKGy88oJoOIyAeksaKu0hESQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 412r9hwssm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 08:35:46 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 Aug
 2024 14:35:44 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 22 Aug 2024 14:35:44 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6D951820244;
	Thu, 22 Aug 2024 13:35:44 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2] ASoC: cs-amp-lib: Ignore empty UEFI calibration entries
Date: Thu, 22 Aug 2024 14:35:44 +0100
Message-ID: <20240822133544.304421-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Gy5mLh_i21ft7E57N96cZfqn4bjQ8G50
X-Proofpoint-ORIG-GUID: Gy5mLh_i21ft7E57N96cZfqn4bjQ8G50
X-Proofpoint-Spam-Reason: safe

If the timestamp of a calibration entry is 0 it is an unused entry and
must be ignored.

Some end-products reserve EFI space for calibration entries by shipping
with a zero-filled EFI file. When searching the file for calibration
data the driver must skip the empty entries. The timestamp of a valid
entry is always non-zero.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 1cad8725f2b9 ("ASoC: cs-amp-lib: Add helpers for factory calibration data")
---
Changes since V1:
This time actually send the correct version of the code that doesn't
break the build.

 sound/soc/codecs/cs-amp-lib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index 605964af8afa..51b128c80671 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -182,6 +182,10 @@ static int _cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid,
 		for (i = 0; i < efi_data->count; ++i) {
 			u64 cal_target = cs_amp_cal_target_u64(&efi_data->data[i]);
 
+			/* Skip empty entries */
+			if (!efi_data->data[i].calTime[0] && !efi_data->data[i].calTime[1])
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
+	    (efi_data->data[amp_index].calTime[0] || efi_data->data[amp_index].calTime[1])) {
 		u64 cal_target = cs_amp_cal_target_u64(&efi_data->data[amp_index]);
 
 		/*
-- 
2.39.2


