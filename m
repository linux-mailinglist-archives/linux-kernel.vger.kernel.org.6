Return-Path: <linux-kernel+bounces-246091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3C792BD7B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE941C2270C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3509A19D088;
	Tue,  9 Jul 2024 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GL1w3MEd"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088518E76B;
	Tue,  9 Jul 2024 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536740; cv=none; b=bRkvTQ59XccBfQKkUfJvFVlGI/0NbOZWUudP+Qoatvm2+xsPEkIx9aTz5gQP2pHqarGifPSFxjchyC1UKrVuh/ehHWCaVCuns0NvzywrfDK0kyXCBndJDhBGyJd8cS3ANcRMb6HAmW9VvSMAMoKs9KnSgsyXq8Cb7vlo/jOypAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536740; c=relaxed/simple;
	bh=kHic7sC6ZH2AbrBooEeaERzQHXRTdQ9dm5ISCUWeMZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pS+A9M5LgMdbEDw3quoQ4SIPYZLzF6vs95ekRfhTZ3i/AOr8uedq5q7JaIPV6L3+g6h+UcYgYKATMSa/DCu3NXcmJjZseDDBl4SHTHkzeOkLVcfi+iFJda0LTmS9/b8JrD+HutIw3enrb876cjU7JN9WQ9qb3rlZZE0RkK5uj54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GL1w3MEd; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4699SgHb015345;
	Tue, 9 Jul 2024 09:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=NN3wIvV31GO7VEkUhfRXkdoFpo5rlVSBv89Npcmj1vg=; b=
	GL1w3MEd9gIcn7yXiPjrlwi39FDDdvRwiib1oTlBuilpYoe5dg5xdvvdTddZWJiX
	ffC9EJzroAdUdFkLB897gjRy081vFKEHLNSEzFWhvOmTGNdplnA6cOvdD0yi1rBA
	g39DaInbBCu/naAypjMFvW51OK8f3dTw9tHm4dErY8VS4+ecrzuk187Tl+8Mwzie
	Fl/ZjgsnT7WUU9Z2LW57tKyQ/uWq4sUJG+owQJ2dT747KugAgmL3DCfk2A0WNbfN
	feYNjvAojJ2EsU6MDVCcG/+ivtjhFhCzmTceG4oAEPcPTVIql/Iq4l1XgtKnFhZ1
	cWkugfGhQfItfsNZAKLIeQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4073axtqjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 09:51:59 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 15:51:57 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 9 Jul 2024 15:51:57 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id F229282024D;
	Tue,  9 Jul 2024 14:51:56 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 1/4] firmware: cs_dsp: Don't allocate temporary buffer for info text
Date: Tue, 9 Jul 2024 15:51:53 +0100
Message-ID: <20240709145156.268074-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240709145156.268074-1-rf@opensource.cirrus.com>
References: <20240709145156.268074-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3KAlLF-uM4roJ-Jm4ZeW2xcjU8uXJgjN
X-Proofpoint-GUID: 3KAlLF-uM4roJ-Jm4ZeW2xcjU8uXJgjN
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


