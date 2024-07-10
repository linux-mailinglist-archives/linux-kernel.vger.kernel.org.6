Return-Path: <linux-kernel+bounces-247447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED7992CF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C235C1C209FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D250197A6A;
	Wed, 10 Jul 2024 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fHD/CQIg"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC28C196D9D;
	Wed, 10 Jul 2024 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607812; cv=none; b=WJFigc1vhT0QI9jMY7zp34pToS0cbnAxs8KLz6FTQ3x2NaAdhELOtwuh4lHW/fJlWlybaTwMKn5Sypojq+RhkdAwQLt/7zJzyQGChumUjcrQgBeHAXowAOzPneWZQa8gND/9JvunS4ziwYJf+LFUUhyuh1jK1ZW9KtC1XXRexek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607812; c=relaxed/simple;
	bh=sUFRpB9tn4pKYjz656dcZgE4v6AXfR+oBbjTGOOHJNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2Ro64kAtWMuqa00L4i/Sx4YZA0gXrGGstIZGAg+FI97BIJsz6r8lCy1v/dMRqGR+Go8FU//aAcoyso6gTV/CuvmK5D/BpNpvKe1olW1I5F9xRaiMKhmq9BfCPfykcqHwWso64G9dnJgjahJImMUWIi1/GuXQg3cvliGgluOrkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fHD/CQIg; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A4s4Gn006601;
	Wed, 10 Jul 2024 05:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=BI9y81EZerHwzLYzPxJaK7fauU2DS3/I335/BNTzokk=; b=
	fHD/CQIg+GJ4M2YeonM3cgEBEm8p5rmhB1Jkp8sBbiaqkKSNOrs0/FQ/46+31M5d
	T50y4llA2PZLxMEbUhrGOett+RJxlBCByBm8ES93NTeJvSnw0dFoCRBiaxLC46PT
	9jOTo0BEIKbT4hnk8IxLPQ7sRBgLQFLPirFLRJ3qdU1tW3mn9OxJQrjvVS7NW+Mg
	EtsvnMNrnszwHhn49bV0rQ+T1usnd/4puF4Rm4YVekRrziM1gJLa0yoHIpV/w+pR
	9vV95aHf4iH4khEoTwo1F9X1KZ2jZsa3FW5qamMb/MwHgK33pI21Vg03j2ainytk
	6kDmyBN5Dw7ZusWVptA+PA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 409c9a8h0p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 05:36:43 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Jul
 2024 11:36:40 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 10 Jul 2024 11:36:40 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6982C82024D;
	Wed, 10 Jul 2024 10:36:40 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH v2 1/4] firmware: cs_dsp: Don't allocate temporary buffer for info text
Date: Wed, 10 Jul 2024 11:36:37 +0100
Message-ID: <20240710103640.78197-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710103640.78197-1-rf@opensource.cirrus.com>
References: <20240710103640.78197-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BAv89DRGGZKKLyszZ4f9DljKiPAN78pc
X-Proofpoint-GUID: BAv89DRGGZKKLyszZ4f9DljKiPAN78pc
X-Proofpoint-Spam-Reason: safe

Don't allocate a temporary buffer to hold a NUL-terminated copy
of the NAME/INFO string from the wmfw/bin. It can be printed
directly to the log. Also limit the maximum number of characters
that will be logged from this string.

The NAME/INFO blocks in the firmware files are an array of
characters with a length, not a NUL-terminated C string. The
original code allocated a temporary buffer to make a
NUL-terminated copy of the string and then passed that to
dev_info(). There's no need for this: printf formatting can
use "%.*s" to print a character array of a given length.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
No changes since V1
---
 drivers/firmware/cirrus/cs_dsp.c | 35 +++++++-------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 89fd63205a6e..bf25107a98ee 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -12,6 +12,7 @@
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/seq_file.h>
@@ -1473,7 +1474,6 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 	const struct wmfw_region *region;
 	const struct cs_dsp_region *mem;
 	const char *region_name;
-	char *text = NULL;
 	struct cs_dsp_buf *buf;
 	unsigned int reg;
 	int regions = 0;
@@ -1545,15 +1545,15 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 
 		region_name = "Unknown";
 		reg = 0;
-		text = NULL;
 		offset = le32_to_cpu(region->offset) & 0xffffff;
 		type = be32_to_cpu(region->type) & 0xff;
 
 		switch (type) {
+		case WMFW_INFO_TEXT:
 		case WMFW_NAME_TEXT:
-			region_name = "Firmware name";
-			text = kzalloc(le32_to_cpu(region->len) + 1,
-				       GFP_KERNEL);
+			region_name = "Info/Name";
+			cs_dsp_info(dsp, "%s: %.*s\n", file,
+				    min(le32_to_cpu(region->len), 100), region->data);
 			break;
 		case WMFW_ALGORITHM_DATA:
 			region_name = "Algorithm";
@@ -1561,11 +1561,6 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 			if (ret != 0)
 				goto out_fw;
 			break;
-		case WMFW_INFO_TEXT:
-			region_name = "Information";
-			text = kzalloc(le32_to_cpu(region->len) + 1,
-				       GFP_KERNEL);
-			break;
 		case WMFW_ABSOLUTE:
 			region_name = "Absolute";
 			reg = offset;
@@ -1599,13 +1594,6 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 			   regions, le32_to_cpu(region->len), offset,
 			   region_name);
 
-		if (text) {
-			memcpy(text, region->data, le32_to_cpu(region->len));
-			cs_dsp_info(dsp, "%s: %s\n", file, text);
-			kfree(text);
-			text = NULL;
-		}
-
 		if (reg) {
 			buf = cs_dsp_buf_alloc(region->data,
 					       le32_to_cpu(region->len),
@@ -1647,7 +1635,6 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 out_fw:
 	regmap_async_complete(regmap);
 	cs_dsp_buf_free(&buf_list);
-	kfree(text);
 
 	if (ret == -EOVERFLOW)
 		cs_dsp_err(dsp, "%s: file content overflows file data\n", file);
@@ -2180,7 +2167,6 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 	struct cs_dsp_alg_region *alg_region;
 	const char *region_name;
 	int ret, pos, blocks, type, offset, reg, version;
-	char *text = NULL;
 	struct cs_dsp_buf *buf;
 
 	if (!firmware)
@@ -2249,7 +2235,8 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 		region_name = "Unknown";
 		switch (type) {
 		case (WMFW_NAME_TEXT << 8):
-			text = kzalloc(le32_to_cpu(blk->len) + 1, GFP_KERNEL);
+			cs_dsp_info(dsp, "%s: %.*s\n", dsp->fw_name,
+				    min(le32_to_cpu(blk->len), 100), blk->data);
 			break;
 		case (WMFW_INFO_TEXT << 8):
 		case (WMFW_METADATA << 8):
@@ -2321,13 +2308,6 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 			break;
 		}
 
-		if (text) {
-			memcpy(text, blk->data, le32_to_cpu(blk->len));
-			cs_dsp_info(dsp, "%s: %s\n", dsp->fw_name, text);
-			kfree(text);
-			text = NULL;
-		}
-
 		if (reg) {
 			buf = cs_dsp_buf_alloc(blk->data,
 					       le32_to_cpu(blk->len),
@@ -2367,7 +2347,6 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 out_fw:
 	regmap_async_complete(regmap);
 	cs_dsp_buf_free(&buf_list);
-	kfree(text);
 
 	if (ret == -EOVERFLOW)
 		cs_dsp_err(dsp, "%s: file content overflows file data\n", file);
-- 
2.39.2


