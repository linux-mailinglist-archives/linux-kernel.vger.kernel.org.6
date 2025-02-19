Return-Path: <linux-kernel+bounces-521889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078AFA3C390
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676503A7796
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333681F4189;
	Wed, 19 Feb 2025 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PgvKnhgm"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A719149F;
	Wed, 19 Feb 2025 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978511; cv=none; b=OxzTxv8aJkjyDvFJLLhfegwEXRBGu8kKf56y0gTPZ1rVCFvSBr5aFkb92XEfwtu9TQkJmoo8GjuSGMhw2QFgpjOqoKUhbopjQPRgPs3rcsDTCBZjE1gR1RpmG2LPVNC8mfZAr7fmvVIm4CxJKfXCW1uhgBsuHT+79D6w1ZPbJCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978511; c=relaxed/simple;
	bh=lOJucpUBW1weD9sd1p/IHAQeHP3/bAsh8f4KjOledd0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tVCshiVBdCLtmAyFWSkBG7K8FwdojeTuWwqzbFJHg9PaU19kH8pAb0PPKnsIPvwzsDS7ppqSpIznE7wME8fciLWw4u6EZ0ei4InU7nVAa03B2y/+YtG0RpUUaG+M7RpIebQBsmKeUsCmTlvKect8aOwHmhblT/xlUOiEQGoDEII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PgvKnhgm; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JFH0rb028064;
	Wed, 19 Feb 2025 09:21:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=/4n+9sQ6e4VHuMQm
	Z1ycsESMXapriznal3x1bbRBntY=; b=PgvKnhgmJA+B2vQzECXpHdxyYgWfwhEq
	AYGFLzn3LXmVINz5V3SwiREPa+iAuH18j3vTjw7cpErxMfiJYXEINlrkcdevcaHa
	Q71Ht0eudcljTzP0d9r9w0eB7KQD2+yc8werYv4Xc/PPZHMBMNoUJg9CluIkpQ6g
	NaPkncPDYFeGaOqrYBgqmPQvh86KHgOzkzLbsySk+O6oVKeNY+yQ67071d5Enrmt
	5hvVHsZI2pgRFyyhTnpa6rpdkTjltzJz91bUstQ1qKy5Gcj7+FfKZOqJ/A30+Mv7
	sIcr4Lx1jQzJOBD2607FnvEeMaEpd3yamE8r6SfTzfvLcTS93tKovg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 44w8j7h2yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 09:21:33 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 15:21:32 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 15:21:32 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 31C5882025A;
	Wed, 19 Feb 2025 15:21:32 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>
Subject: [PATCH] firmware: cs_dsp: test_bin_error: Use same test cases for adsp2 and Halo Core
Date: Wed, 19 Feb 2025 15:21:32 +0000
Message-ID: <20250219152132.1285941-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: S1lhIE8zSIITQ9PYVKKrYFCSdQkJ8ihs
X-Proofpoint-GUID: S1lhIE8zSIITQ9PYVKKrYFCSdQkJ8ihs
X-Authority-Analysis: v=2.4 cv=ZY7nNtVA c=1 sm=1 tr=0 ts=67b5f6fd cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=jpo4JabcuIscFAbp0T0A:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Re-use the adsp2 test cases for the Halo Core test run. Before this the
Halo Core kunit_case array was an empty placeholder.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 .../firmware/cirrus/test/cs_dsp_test_bin_error.c    | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/cirrus/test/cs_dsp_test_bin_error.c b/drivers/firmware/cirrus/test/cs_dsp_test_bin_error.c
index 5dcf62f19fafd..8748874f05524 100644
--- a/drivers/firmware/cirrus/test/cs_dsp_test_bin_error.c
+++ b/drivers/firmware/cirrus/test/cs_dsp_test_bin_error.c
@@ -534,11 +534,6 @@ static int cs_dsp_bin_err_test_adsp2_16bit_init(struct kunit *test)
 	return cs_dsp_bin_err_test_common_init(test, dsp, 1);
 }
 
-static struct kunit_case cs_dsp_bin_err_test_cases_halo[] = {
-
-	{ } /* terminator */
-};
-
 static void cs_dsp_bin_err_block_types_desc(const struct cs_dsp_bin_test_param *param,
 					    char *desc)
 {
@@ -560,7 +555,7 @@ KUNIT_ARRAY_PARAM(bin_test_block_types,
 		  bin_test_block_types_cases,
 		  cs_dsp_bin_err_block_types_desc);
 
-static struct kunit_case cs_dsp_bin_err_test_cases_adsp2[] = {
+static struct kunit_case cs_dsp_bin_err_test_cases[] = {
 	KUNIT_CASE(bin_load_with_unknown_blocks),
 	KUNIT_CASE(bin_err_wrong_magic),
 	KUNIT_CASE(bin_err_too_short_for_header),
@@ -578,21 +573,21 @@ static struct kunit_suite cs_dsp_bin_err_test_halo = {
 	.name = "cs_dsp_bin_err_halo",
 	.init = cs_dsp_bin_err_test_halo_init,
 	.exit = cs_dsp_bin_err_test_exit,
-	.test_cases = cs_dsp_bin_err_test_cases_halo,
+	.test_cases = cs_dsp_bin_err_test_cases,
 };
 
 static struct kunit_suite cs_dsp_bin_err_test_adsp2_32bit = {
 	.name = "cs_dsp_bin_err_adsp2_32bit",
 	.init = cs_dsp_bin_err_test_adsp2_32bit_init,
 	.exit = cs_dsp_bin_err_test_exit,
-	.test_cases = cs_dsp_bin_err_test_cases_adsp2,
+	.test_cases = cs_dsp_bin_err_test_cases,
 };
 
 static struct kunit_suite cs_dsp_bin_err_test_adsp2_16bit = {
 	.name = "cs_dsp_bin_err_adsp2_16bit",
 	.init = cs_dsp_bin_err_test_adsp2_16bit_init,
 	.exit = cs_dsp_bin_err_test_exit,
-	.test_cases = cs_dsp_bin_err_test_cases_adsp2,
+	.test_cases = cs_dsp_bin_err_test_cases,
 };
 
 kunit_test_suites(&cs_dsp_bin_err_test_halo,
-- 
2.39.5


