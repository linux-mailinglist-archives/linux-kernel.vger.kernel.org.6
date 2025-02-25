Return-Path: <linux-kernel+bounces-531444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 000BBA4409B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302313ADE59
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23767268C4B;
	Tue, 25 Feb 2025 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IjNYTDYE"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF7820AF88;
	Tue, 25 Feb 2025 13:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489538; cv=none; b=oUtImUcSkfuQbn4iTmyDEfQl2ITDWSCMR09ywpuA+dCbWwxl53ldI+5lowIvYxxdSZr74W4Yx+MEZqKz3Yy1qumoIsEqX37GrvGqD5AYKlG2g5xmbcf/wELXhvFcR8txHkkyWyJXIkvnRZ0rfeIvFeo+XVhPgboI6bVtkR8xrJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489538; c=relaxed/simple;
	bh=OMSEGtvaXB0EveudO1vwM/O3tb13oNpaAnhvq+jXV8c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjIev9O3E4VhwvyKebHGJF1nvJ00ztEChnf8ps2GZCO5LIsy2viTNwktcilKXI3FZokp07iNi2bHA7f189zwxfaArygY35SJdO3ZWSJlGxkkq7T0pXvQyTtkxf/coCsTz8Lt3CKVMZb+fzmPsmioaP65bEN0LwpfoRZCETcDQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=IjNYTDYE; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P4j5jI001538;
	Tue, 25 Feb 2025 07:18:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=/fpBlv0vvdznQLHHD91oBOMkSt6loBEdSYpDNGea5Qk=; b=
	IjNYTDYEMh+/5hZH4TSyQtNj4Mwar/K7uR2qZo4nuWn3pMiNc5hjr7XJXp6LFtxl
	k31YmQJ6Siwdug5/vKqsCf1b9gnVj3t7Pds6AGViTb9JxryjgBG1AJZIFYKy80XZ
	CfspO0KkAosaTQYvL7d8Fp91+88cbZR1W6fFvbtsvsMQ5OciUCReqIsxisrkjAyq
	53+XeX1bElh290Qriz8GUQpU3WehjopIFXJgOaGcVEQ93LXl6zCzZRhzLBdKnoya
	SX0u3KL6F/YuaD+WwsIDftsSwe0/yOO3BMFFfECT+2B8cET+QitDrre1R2cxhZCI
	tjA4gdcWpaBuPE1PpZzgIQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 44ycv5ptdu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 07:18:46 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 13:18:43 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 13:18:43 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 523A482026B;
	Tue, 25 Feb 2025 13:18:43 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 1/2] firmware: cs_dsp: Remove async regmap writes
Date: Tue, 25 Feb 2025 13:18:42 +0000
Message-ID: <20250225131843.113752-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225131843.113752-1-rf@opensource.cirrus.com>
References: <20250225131843.113752-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=HoqMG1TS c=1 sm=1 tr=0 ts=67bdc336 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=YrvnGbKzfWGhYe5hZGcA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: GUK7M3dPTE6I-LCwUxaJH5uvra7GeGz5
X-Proofpoint-ORIG-GUID: GUK7M3dPTE6I-LCwUxaJH5uvra7GeGz5
X-Proofpoint-Spam-Reason: safe

Change calls to async regmap write functions to use the normal
blocking writes so that the cs35l56 driver can use spi_bus_lock() to
gain exclusive access to the SPI bus.

As this is part of a fix, it makes only the minimal change to swap the
functions to the blocking equivalents. There's no need to risk
reworking the buffer allocation logic that is now partially redundant.

The async writes are a 12-year-old workaround for inefficiency of
synchronous writes in the SPI subsystem. The SPI subsystem has since
been changed to avoid the overheads, so this workaround should not be
necessary.

The cs35l56 driver needs to use spi_bus_lock() prevent bus activity
while it is soft-resetting the cs35l56. But spi_bus_lock() is
incompatible with spi_async() calls, which will fail with -EBUSY.

Fixes: 8a731fd37f8b ("ASoC: cs35l56: Move utility functions to shared file")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 5365e9a43000..42433c19eb30 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -1609,8 +1609,8 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 				goto out_fw;
 			}
 
-			ret = regmap_raw_write_async(regmap, reg, buf->buf,
-						     le32_to_cpu(region->len));
+			ret = regmap_raw_write(regmap, reg, buf->buf,
+					       le32_to_cpu(region->len));
 			if (ret != 0) {
 				cs_dsp_err(dsp,
 					   "%s.%d: Failed to write %d bytes at %d in %s: %d\n",
@@ -1625,12 +1625,6 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 		regions++;
 	}
 
-	ret = regmap_async_complete(regmap);
-	if (ret != 0) {
-		cs_dsp_err(dsp, "Failed to complete async write: %d\n", ret);
-		goto out_fw;
-	}
-
 	if (pos > firmware->size)
 		cs_dsp_warn(dsp, "%s.%d: %zu bytes at end of file\n",
 			    file, regions, pos - firmware->size);
@@ -1638,7 +1632,6 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 	cs_dsp_debugfs_save_wmfwname(dsp, file);
 
 out_fw:
-	regmap_async_complete(regmap);
 	cs_dsp_buf_free(&buf_list);
 
 	if (ret == -EOVERFLOW)
@@ -2326,8 +2319,8 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 			cs_dsp_dbg(dsp, "%s.%d: Writing %d bytes at %x\n",
 				   file, blocks, le32_to_cpu(blk->len),
 				   reg);
-			ret = regmap_raw_write_async(regmap, reg, buf->buf,
-						     le32_to_cpu(blk->len));
+			ret = regmap_raw_write(regmap, reg, buf->buf,
+					       le32_to_cpu(blk->len));
 			if (ret != 0) {
 				cs_dsp_err(dsp,
 					   "%s.%d: Failed to write to %x in %s: %d\n",
@@ -2339,10 +2332,6 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 		blocks++;
 	}
 
-	ret = regmap_async_complete(regmap);
-	if (ret != 0)
-		cs_dsp_err(dsp, "Failed to complete async write: %d\n", ret);
-
 	if (pos > firmware->size)
 		cs_dsp_warn(dsp, "%s.%d: %zu bytes at end of file\n",
 			    file, blocks, pos - firmware->size);
@@ -2350,7 +2339,6 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 	cs_dsp_debugfs_save_binname(dsp, file);
 
 out_fw:
-	regmap_async_complete(regmap);
 	cs_dsp_buf_free(&buf_list);
 
 	if (ret == -EOVERFLOW)
@@ -2561,8 +2549,8 @@ static int cs_dsp_adsp2_enable_core(struct cs_dsp *dsp)
 {
 	int ret;
 
-	ret = regmap_update_bits_async(dsp->regmap, dsp->base + ADSP2_CONTROL,
-				       ADSP2_SYS_ENA, ADSP2_SYS_ENA);
+	ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+				 ADSP2_SYS_ENA, ADSP2_SYS_ENA);
 	if (ret != 0)
 		return ret;
 
-- 
2.39.5


