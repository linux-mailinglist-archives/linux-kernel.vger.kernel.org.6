Return-Path: <linux-kernel+bounces-308970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA42E966471
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C99F4B22ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F28D1B2EC3;
	Fri, 30 Aug 2024 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="E0RHKaIX"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC61917E2;
	Fri, 30 Aug 2024 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029314; cv=none; b=lbNrVJqHG4aRmF7j8B8npAChGXoPQNy2ry3tCQQB5gpQK7v80NfwijrToHj46xS878DETcjorWN/5vYWADQHp28ExY96DAEjrs39pjhEijssn0Fh4tjsUwVyYhV6cb5P/Jrc5L/gFBuSFuUGI22ntGNh1XwMkbspCODyqxe4n7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029314; c=relaxed/simple;
	bh=1MVxMZuUMGmZv9ffTjULk4PjapvB6RE1uq4SGs4CVQo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gfg3S89qrzN0NZEOY6BYqQ9lBE6T4vQEW0ehZ5x2c6mgzCI21BRcaN/JklE8tNQJoFyHS3U0D0RrYxXAaO0Icdpch1GlGX+4C1YOdNyoMt7oImtVa+XubymarCwms3quGzH5MCsd5hPZkMJlJh+ik+FPxFYQzveqwsOIz3NGWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=E0RHKaIX; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U6g4n8029742;
	Fri, 30 Aug 2024 09:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=POjgcX6nbxbSeL4s
	vGSRtgBKOJDds0kexrHsGUGyl0o=; b=E0RHKaIXfrX1qEJ3ldqzDmQy6P0L3wPY
	PNnyB33Vdt52ryokASECD6ifOJPww9N7OcmGu23UE4kdcUsYTIGpEuVRhSNkdDHM
	OF1XJkW+vK9GTaeGh5YF4OPJg+7oYB5sguCdrBB2ezzMJuhqhaYihnoggnAVDR+m
	NLMCIwR2CZqB5taCfXOIFsZow4BxCcj/izSs1l4c0wBw/VUegUZx5CLY52U9Qhvc
	Sqfd0Xe3T+tuhcfn39h24+HO3O/W0EPYHKjCzRCvVnL+Sa8FfiXDCK5BrWiQfiE+
	vx4HH2BE1uhogqFrwY6rsV++eTB5lULLv+thMN9e39dX45fTjM6Zng==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 419pukbvc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 09:48:22 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 30 Aug
 2024 15:48:19 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 30 Aug 2024 15:48:19 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 99278820244;
	Fri, 30 Aug 2024 14:48:19 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs-amp-lib: Add KUnit test case for empty calibration entries
Date: Fri, 30 Aug 2024 15:48:19 +0100
Message-ID: <20240830144819.118362-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ve36sNyYpHnK14h_LFkXzVPQK7J64Etl
X-Proofpoint-ORIG-GUID: ve36sNyYpHnK14h_LFkXzVPQK7J64Etl
X-Proofpoint-Spam-Reason: safe

Add a test case for commit bb4485562f59 ("ASoC: cs-amp-lib: Ignore
empty UEFI calibration entries").

Any entries in the calibration blob that have calTime==0 are empty
entries. So they must not be returned by a lookup.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs-amp-lib-test.c | 44 ++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/sound/soc/codecs/cs-amp-lib-test.c b/sound/soc/codecs/cs-amp-lib-test.c
index 8169ec88a8ba..a6e8348a1bd5 100644
--- a/sound/soc/codecs/cs-amp-lib-test.c
+++ b/sound/soc/codecs/cs-amp-lib-test.c
@@ -515,6 +515,49 @@ static void cs_amp_lib_test_get_efi_cal_zero_not_matched_test(struct kunit *test
 	kunit_deactivate_static_stub(test, cs_amp_test_hooks->get_efi_variable);
 }
 
+/*
+ * If an entry has a timestamp of 0 it should be ignored even if it has
+ * a matching target UID.
+ */
+static void cs_amp_lib_test_get_efi_cal_empty_entry_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cirrus_amp_cal_data result_data;
+	u64 uid;
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 8);
+
+	/* Mark the 3rd entry invalid by zeroing calTime */
+	priv->cal_blob->data[2].calTime[0] = 0;
+	priv->cal_blob->data[2].calTime[1] = 0;
+
+	/* Get the UID value of the 3rd entry */
+	uid = priv->cal_blob->data[2].calTarget[1];
+	uid <<= 32;
+	uid |= priv->cal_blob->data[2].calTarget[0];
+
+	/* Redirect calls to get EFI data */
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+
+	/* Lookup by UID should not find it */
+	KUNIT_EXPECT_EQ(test,
+			cs_amp_get_efi_calibration_data(&priv->amp_pdev.dev,
+							uid, -1,
+							&result_data),
+			-ENOENT);
+
+	/* Get by index should ignore it */
+	KUNIT_EXPECT_EQ(test,
+			cs_amp_get_efi_calibration_data(&priv->amp_pdev.dev,
+							0, 2,
+							&result_data),
+			-ENOENT);
+
+	kunit_deactivate_static_stub(test, cs_amp_test_hooks->get_efi_variable);
+}
+
 static const struct cirrus_amp_cal_controls cs_amp_lib_test_calibration_controls = {
 	.alg_id =	0x9f210,
 	.mem_region =	WMFW_ADSP2_YM,
@@ -696,6 +739,7 @@ static struct kunit_case cs_amp_lib_test_cases[] = {
 			 cs_amp_lib_test_get_cal_gen_params),
 	KUNIT_CASE_PARAM(cs_amp_lib_test_get_efi_cal_by_index_fallback_test,
 			 cs_amp_lib_test_get_cal_gen_params),
+	KUNIT_CASE(cs_amp_lib_test_get_efi_cal_empty_entry_test),
 
 	/* Tests for writing calibration data */
 	KUNIT_CASE(cs_amp_lib_test_write_cal_data_test),
-- 
2.39.2


