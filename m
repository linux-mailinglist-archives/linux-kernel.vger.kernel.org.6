Return-Path: <linux-kernel+bounces-232450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 423E791A8FA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52241F28659
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34A71991A6;
	Thu, 27 Jun 2024 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BxWI/+x+"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D26A198E7D;
	Thu, 27 Jun 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497687; cv=none; b=QZBpeLYvmswq/BgYvKimd8gSIJ32Pvha4hSKq3dAebRl9QPvFwlgPOiUngX4oaBX5s2msKnJevtrmlXoUqq52sEYj39G8icLu0HSqwUkGDW7RBY/UHfgjSv6DsVwLOVJRntd9VGH/yE56u1T747cjAj+9kzqxVbUApKLkdCMyJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497687; c=relaxed/simple;
	bh=b9d7/dmslLYP0afwudsRhSrkvDKaCvz1lx64yUTfCSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ho6aWz4rB/uBMPlpIPIahGBSEGlRQ8kgZEAqvl6Z3rPz7GYWf+XQHvDpTwYyhvoXT2N3xFTpF4GHI8BxssPYdlxXpFotXR7gbUOCA7GvJLBd96tIgX/DMIEI4FeIFxBl9mz1VE3fmA4gDhqAI/deajdE+iHjYooj6Z37i9u4l1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BxWI/+x+; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RCpTLN015656;
	Thu, 27 Jun 2024 09:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=CmsVyh5Qi+WLjy5luML+16VV909jq5eKeD4lvnffB/4=; b=
	BxWI/+x+XsCCqw/kswGVhKmJkBDJxyvdVDSFzcjCqMoLuQ6zR3YwTSO5dr1qhdzu
	RqGhB4eLacuIoJiMZhL+kUmy1Eu0lztqwaGzJWOntbsLCRuCKadH5LdYcB//uNnY
	1pVKcylO5C0/wlPn1yVUBK+govfnf0jCwSgQzjkzuOL2Vrxz+ol0umXsIADdVBP+
	mrBi3tXRj8c2sgwlQ3WDoD1Cm7LYnx60F5jDX45uy/fRK+jMbAPbK1Tj6vGgBMoQ
	WGQ0srm8FgcI7gpAi+ZFvL/NoOB+YvmBRxLWkrR41VQdPgQUVaaW5iauRjbfx9iZ
	baekzECdCer2Iv7Qb1Cajg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ywu1hwh36-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:14:36 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Jun
 2024 15:14:32 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 27 Jun 2024 15:14:32 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 630E2820273;
	Thu, 27 Jun 2024 14:14:32 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 1/4] firmware: cs_dsp: Fix overflow checking of wmfw header
Date: Thu, 27 Jun 2024 15:14:29 +0100
Message-ID: <20240627141432.93056-2-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: 41-TjDMycii_9KYadwcCzhriF7Idn_Og
X-Proofpoint-GUID: 41-TjDMycii_9KYadwcCzhriF7Idn_Og
X-Proofpoint-Spam-Reason: safe

Fix the checking that firmware file buffer is large enough for the
wmfw header, to prevent overrunning the buffer.

The original code tested that the firmware data buffer contained
enough bytes for the sums of the size of the structs

	wmfw_header + wmfw_adsp1_sizes + wmfw_footer

But wmfw_adsp1_sizes is only used on ADSP1 firmware. For ADSP2 and
Halo Core the equivalent struct is wmfw_adsp2_sizes, which is
4 bytes longer. So the length check didn't guarantee that there
are enough bytes in the firmware buffer for a header with
wmfw_adsp2_sizes.

This patch splits the length check into three separate parts. Each
of the wmfw_header, wmfw_adsp?_sizes and wmfw_footer are checked
separately before they are used.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: f6bc909e7673 ("firmware: cs_dsp: add driver to support firmware loading on Cirrus Logic DSPs")
---
 drivers/firmware/cirrus/cs_dsp.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 0d139e4de37c..6eca62d31e20 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -1321,6 +1321,10 @@ static unsigned int cs_dsp_adsp1_parse_sizes(struct cs_dsp *dsp,
 	const struct wmfw_adsp1_sizes *adsp1_sizes;
 
 	adsp1_sizes = (void *)&firmware->data[pos];
+	if (sizeof(*adsp1_sizes) > firmware->size - pos) {
+		cs_dsp_err(dsp, "%s: file truncated\n", file);
+		return 0;
+	}
 
 	cs_dsp_dbg(dsp, "%s: %d DM, %d PM, %d ZM\n", file,
 		   le32_to_cpu(adsp1_sizes->dm), le32_to_cpu(adsp1_sizes->pm),
@@ -1337,6 +1341,10 @@ static unsigned int cs_dsp_adsp2_parse_sizes(struct cs_dsp *dsp,
 	const struct wmfw_adsp2_sizes *adsp2_sizes;
 
 	adsp2_sizes = (void *)&firmware->data[pos];
+	if (sizeof(*adsp2_sizes) > firmware->size - pos) {
+		cs_dsp_err(dsp, "%s: file truncated\n", file);
+		return 0;
+	}
 
 	cs_dsp_dbg(dsp, "%s: %d XM, %d YM %d PM, %d ZM\n", file,
 		   le32_to_cpu(adsp2_sizes->xm), le32_to_cpu(adsp2_sizes->ym),
@@ -1376,7 +1384,6 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 	struct regmap *regmap = dsp->regmap;
 	unsigned int pos = 0;
 	const struct wmfw_header *header;
-	const struct wmfw_adsp1_sizes *adsp1_sizes;
 	const struct wmfw_footer *footer;
 	const struct wmfw_region *region;
 	const struct cs_dsp_region *mem;
@@ -1392,10 +1399,8 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 
 	ret = -EINVAL;
 
-	pos = sizeof(*header) + sizeof(*adsp1_sizes) + sizeof(*footer);
-	if (pos >= firmware->size) {
-		cs_dsp_err(dsp, "%s: file too short, %zu bytes\n",
-			   file, firmware->size);
+	if (sizeof(*header) >= firmware->size) {
+		ret = -EOVERFLOW;
 		goto out_fw;
 	}
 
@@ -1423,13 +1428,16 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 
 	pos = sizeof(*header);
 	pos = dsp->ops->parse_sizes(dsp, file, pos, firmware);
+	if ((pos == 0) || (sizeof(*footer) > firmware->size - pos)) {
+		ret = -EOVERFLOW;
+		goto out_fw;
+	}
 
 	footer = (void *)&firmware->data[pos];
 	pos += sizeof(*footer);
 
 	if (le32_to_cpu(header->len) != pos) {
-		cs_dsp_err(dsp, "%s: unexpected header length %d\n",
-			   file, le32_to_cpu(header->len));
+		ret = -EOVERFLOW;
 		goto out_fw;
 	}
 
@@ -1555,6 +1563,9 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 	cs_dsp_buf_free(&buf_list);
 	kfree(text);
 
+	if (ret == -EOVERFLOW)
+		cs_dsp_err(dsp, "%s: file content overflows file data\n", file);
+
 	return ret;
 }
 
-- 
2.39.2


