Return-Path: <linux-kernel+bounces-232447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A90FE91A8F4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509291F28E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA02198A2E;
	Thu, 27 Jun 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PTQRTOUk"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3290198827;
	Thu, 27 Jun 2024 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497684; cv=none; b=XAek8fA/Fx+htJzppdc4AtxzZ2TPJZhQuzUUURDLQ47h2leXIUBbU+FLQK6nr7OB0BNFJl5mwG1ERcRp3gonveGO5r0zVceXanVo4jh4r+82UzdxVhsDRwlJpX7CJHUfyn9LRMs1Rmp9X71p/6YqmEieSRwnCh7wQCmaLkAShfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497684; c=relaxed/simple;
	bh=9D/2PaOW6MKVyp7k7rOu+102ZV2kHkSiZRo5a83CszQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqbIkz8pALh//ggyET/WHK6Jc8+nICMkVYukq9K0hjFvCD28gbsTWorUE76cVHUzwTWhz6AM1knDV9S0RLGUx4MKywVEbaPmPQbDiWBg8Gt9RIV7a2ZVedcDGZVhCAF3Aks7ZA4QEGCOQwJ9PYUpxfKa4T/CvY4EAYbaFUzixMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PTQRTOUk; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RCpTLL015656;
	Thu, 27 Jun 2024 09:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Mf466zPNszl4cwSOtyzf4Z5XuNbdlzhvEDQrtGPSQks=; b=
	PTQRTOUkPHyjAvMeLpRrIGQr314Oo2gkaCmYvUe3WtufnzQdRPudpl8m8EpepXtM
	c3s5Wbn6CTEimuT2ld7NaaENdu8oYi3U32x+FJXO/S6+cGEb4tq31N3S/xISd6ai
	RYvRckxqd14yEvq/W5tnNMXCIWb/CzTSUiBrM+sIszw8vpR6e/8ZwZ9KDC+Of7r7
	fv1zkZn4PSqzZHNq+nKH3RBC/VVqAPia3PxUUqvK3lzHgJAMQ+Y9SSHP5h1ULTZ0
	5u/R1cLsbzgHdW6dxgeJmRS+ZvkvrBI0kB0Km7QAUKTU3H8N/6E6JIebT40tZNJb
	vySqSX5jUxNbbOqsLztxKA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ywu1hwh36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:14:34 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Jun
 2024 15:14:32 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 27 Jun 2024 15:14:32 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 690FE82F2A2;
	Thu, 27 Jun 2024 14:14:32 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 3/4] firmware: cs_dsp: Validate payload length before processing block
Date: Thu, 27 Jun 2024 15:14:31 +0100
Message-ID: <20240627141432.93056-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240627141432.93056-1-rf@opensource.cirrus.com>
References: <20240627141432.93056-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SwvW2r7efNwRyuBMy-RoQ0aJXmVsIGtF
X-Proofpoint-GUID: SwvW2r7efNwRyuBMy-RoQ0aJXmVsIGtF
X-Proofpoint-Spam-Reason: safe

Move the payload length check in cs_dsp_load() and cs_dsp_coeff_load()
to be done before the block is processed.

The check that the length of a block payload does not exceed the number
of remaining bytes in the firwmware file buffer was being done near the
end of the loop iteration. However, some code before that check used the
length field without validating it.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: f6bc909e7673 ("firmware: cs_dsp: add driver to support firmware loading on Cirrus Logic DSPs")
---
 drivers/firmware/cirrus/cs_dsp.c | 36 +++++++++++++-------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 47cf91be99a1..13ff08870d69 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -1452,6 +1452,12 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 		}
 
 		region = (void *)&(firmware->data[pos]);
+
+		if (le32_to_cpu(region->len) > firmware->size - pos - sizeof(*region)) {
+			ret = -EOVERFLOW;
+			goto out_fw;
+		}
+
 		region_name = "Unknown";
 		reg = 0;
 		text = NULL;
@@ -1508,16 +1514,6 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 			   regions, le32_to_cpu(region->len), offset,
 			   region_name);
 
-		if (le32_to_cpu(region->len) >
-		    firmware->size - pos - sizeof(*region)) {
-			cs_dsp_err(dsp,
-				   "%s.%d: %s region len %d bytes exceeds file length %zu\n",
-				   file, regions, region_name,
-				   le32_to_cpu(region->len), firmware->size);
-			ret = -EINVAL;
-			goto out_fw;
-		}
-
 		if (text) {
 			memcpy(text, region->data, le32_to_cpu(region->len));
 			cs_dsp_info(dsp, "%s: %s\n", file, text);
@@ -2147,6 +2143,11 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 
 		blk = (void *)(&firmware->data[pos]);
 
+		if (le32_to_cpu(blk->len) > firmware->size - pos - sizeof(*blk)) {
+			ret = -EOVERFLOW;
+			goto out_fw;
+		}
+
 		type = le16_to_cpu(blk->type);
 		offset = le16_to_cpu(blk->offset);
 		version = le32_to_cpu(blk->ver) >> 8;
@@ -2243,17 +2244,6 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 		}
 
 		if (reg) {
-			if (le32_to_cpu(blk->len) >
-			    firmware->size - pos - sizeof(*blk)) {
-				cs_dsp_err(dsp,
-					   "%s.%d: %s region len %d bytes exceeds file length %zu\n",
-					   file, blocks, region_name,
-					   le32_to_cpu(blk->len),
-					   firmware->size);
-				ret = -EINVAL;
-				goto out_fw;
-			}
-
 			buf = cs_dsp_buf_alloc(blk->data,
 					       le32_to_cpu(blk->len),
 					       &buf_list);
@@ -2293,6 +2283,10 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 	regmap_async_complete(regmap);
 	cs_dsp_buf_free(&buf_list);
 	kfree(text);
+
+	if (ret == -EOVERFLOW)
+		cs_dsp_err(dsp, "%s: file content overflows file data\n", file);
+
 	return ret;
 }
 
-- 
2.39.2


