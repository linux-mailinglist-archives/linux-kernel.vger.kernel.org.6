Return-Path: <linux-kernel+bounces-297261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A6195B513
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B215B1F220E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C4E1C9444;
	Thu, 22 Aug 2024 12:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="X8qU7jXY"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A469F1E4B0;
	Thu, 22 Aug 2024 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330073; cv=none; b=cs9/JICZoBu5XfiWQI5myMGHp9F2eUbpL3AGmLF67C/sQSAqzIPNSK32HKvHLsz0h/VSmsFS1dUVq/UJx1/z5TPsMDBnJEoBXXQ1ngRkx7qCoLzQCWRLbYK54BrX+QWTYYfL149zPrpgu8xe0ftOWN7ADIIhA8LZE6YJV9qOYC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330073; c=relaxed/simple;
	bh=3t8k4IPYRftT6nZ8UX7GzF4RhagPZ3in+/Up5WFzFM8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tF0EKBMbxFJZMQozro8y1ScL7mxXkxB7Sj6TIvOoOGjxXPxwVvbf6uT3Cykv5RbWqCuQpkOmWNmiCX9yCWcwUbXpvNRACbB2+ceVgigj3C1mhQXektaloZiA+3FgdXSigIjJrOEUteK2kqmsoEOfijxO/BYI1HxCMwPo3IqSd0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=X8qU7jXY; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LNl4nZ025114;
	Thu, 22 Aug 2024 06:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=Ek+bakmG4WGbqKlO
	WEEBoQdUCTBQawtInzbF4OKh30E=; b=X8qU7jXY0JBX6Z9n1ExbYLjOi3tLUBla
	pKpyyg2apofFaFKrj2/rx9oERt3u1QgYUz3OgWhBFOvPCstAHjLH1UxwNiV/KFh4
	MqsR20YoUIrQRgT33Mk8PbBjjyDwzxAUsefDOyMIZteAofoQFGNuTqf0NvY+Nav4
	wmBAskDIcFMQkISzYQr/uwAhEltndSOeopKQKyILOoqCL6wqv2XDL8aSOLVbRaxv
	V553ylPPHNKqU3vgFJrEdesmjqzc1TBcSE41lJuCiarfrI6lpPn6FKAVqGe6p6JK
	GgaWVMz9spk9tSjAom3dmPlpnMMA7IrcB98rJwMl+5NiC3etMMUSSA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 412s8x5pa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 06:57:27 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 Aug
 2024 12:57:25 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 22 Aug 2024 12:57:25 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 759DA820244;
	Thu, 22 Aug 2024 11:57:25 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs-amp-lib-test: Force test calibration blob entries to be valid
Date: Thu, 22 Aug 2024 12:57:25 +0100
Message-ID: <20240822115725.259568-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Q3c_HikjKUd-Hxa-t1uddM9YssOYEp4l
X-Proofpoint-GUID: Q3c_HikjKUd-Hxa-t1uddM9YssOYEp4l
X-Proofpoint-Spam-Reason: safe

For a normal calibration blob the calTarget values must be non-zero and
unique, and the calTime values must be non-zero. Don't rely on
get_random_bytes() to be random enough to guarantee this. Force the
calTarget and calTime values to be valid while retaining randomness
in the values.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 177862317a98 ("ASoC: cs-amp-lib: Add KUnit test for calibration helpers")
---
 sound/soc/codecs/cs-amp-lib-test.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/cs-amp-lib-test.c b/sound/soc/codecs/cs-amp-lib-test.c
index 15f991b2e16e..8169ec88a8ba 100644
--- a/sound/soc/codecs/cs-amp-lib-test.c
+++ b/sound/soc/codecs/cs-amp-lib-test.c
@@ -38,6 +38,7 @@ static void cs_amp_lib_test_init_dummy_cal_blob(struct kunit *test, int num_amps
 {
 	struct cs_amp_lib_test_priv *priv = test->priv;
 	unsigned int blob_size;
+	int i;
 
 	blob_size = offsetof(struct cirrus_amp_efi_data, data) +
 		    sizeof(struct cirrus_amp_cal_data) * num_amps;
@@ -49,6 +50,14 @@ static void cs_amp_lib_test_init_dummy_cal_blob(struct kunit *test, int num_amps
 	priv->cal_blob->count = num_amps;
 
 	get_random_bytes(priv->cal_blob->data, sizeof(struct cirrus_amp_cal_data) * num_amps);
+
+	/* Ensure all timestamps are non-zero to mark the entry valid. */
+	for (i = 0; i < num_amps; i++)
+		priv->cal_blob->data[i].calTime[0] |= 1;
+
+	/* Ensure that all UIDs are non-zero and unique. */
+	for (i = 0; i < num_amps; i++)
+		*(u8 *)&priv->cal_blob->data[i].calTarget[0] = i + 1;
 }
 
 static u64 cs_amp_lib_test_get_target_uid(struct kunit *test)
-- 
2.39.2


