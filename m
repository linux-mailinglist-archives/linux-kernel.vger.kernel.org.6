Return-Path: <linux-kernel+bounces-449074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B989F4960
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E2687A278F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEBD1E633C;
	Tue, 17 Dec 2024 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="lo89k2Zs"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9F1DE8B9;
	Tue, 17 Dec 2024 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432992; cv=none; b=mZDwLn9Ux5WkSsiJwax/FhILR29hwYuZDGstujTb2DdDkn9N3T5/HGB3DrFMY1RXkzXsRK+RjiGhUusW7wHJ6B2iUWJhcOcWi+atschTrtLS9amA1zAVomEZDrcXW2PPLCVXrnnCzfapspriSzGQuNTJ/hVtHpNWpvnWqOviRw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432992; c=relaxed/simple;
	bh=3SISvEwS/XyyCMIkP6zwek3JtvXyWarLQbljS7JywQU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cXesZH6nBEc1v9WOcOPjMNUqORruWGMSp8+yIOdmh1kfvX6aaa6mwVucpZYhRCR2IfMIgBU516xh7SrJEp4/83gBPllKS2egH4eFbBV31LQL7eP1A/4Ojz81INxP6i17x68jhy9YIvb/MQSJBf+2moHYMcRFGwAO+nGBksUyIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=lo89k2Zs; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH4qHmb011485;
	Tue, 17 Dec 2024 04:56:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=Xr23EUoPfpAnvTB6
	vGMJZuM9vVYgdcmO3WlkZHA/4I8=; b=lo89k2ZsQRgJd2/tm1yuUN3Pf+sXkNgE
	uTS0663lyoMj/TbVq4JJ9P3r950kAbohUDRQJzscwrpXm2CgNH/SGcCv2emsHYV9
	DGy03+aJ6qSaZzSNGzfLPMJMVs+cchUfsFcT4a1FdoebQ5GkP68dJuBsoa/tRdBu
	YDpgYFeT1B6nG1iaqoG7+miqDAGc2IafhgDisR0pYtqCCX+H5BU7jYN3WExKwUuH
	cK09w8b+6RYShS0GigCL/AL+zJ79PIsylXI6+N0wH/ZFEmoUluHLxlNntqoAZPuC
	JUj4Ob5bXQlEK03QthFf4pJUNMWerAiXBYcjOPh4U1tSkey+u8+NAw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43h7akb5r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 04:56:26 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Tue, 17 Dec
 2024 10:56:25 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Tue, 17 Dec 2024 10:56:25 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id EBFAF820248;
	Tue, 17 Dec 2024 10:56:24 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: [PATCH] firmware: cs_dsp: Fix endianness conversion in cs_dsp_mock_wmfw.c
Date: Tue, 17 Dec 2024 10:56:24 +0000
Message-ID: <20241217105624.139479-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Rsj_RlUarXr5OswHE9KH8_JEOX2O9Xil
X-Proofpoint-ORIG-GUID: Rsj_RlUarXr5OswHE9KH8_JEOX2O9Xil
X-Proofpoint-Spam-Reason: safe

In cs_dsp_mock_wmfw_add_coeff_desc() the value stored in longstring->len
needs a cpu_to_le16() conversion.

Fixes: 5cf1b7b47180 ("firmware: cs_dsp: Add mock wmfw file generator for KUnit testing")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412170233.8DnsdtY6-lkp@intel.com/
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/test/cs_dsp_mock_wmfw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/cirrus/test/cs_dsp_mock_wmfw.c b/drivers/firmware/cirrus/test/cs_dsp_mock_wmfw.c
index d3d84da239a3..5a3ac03ac37f 100644
--- a/drivers/firmware/cirrus/test/cs_dsp_mock_wmfw.c
+++ b/drivers/firmware/cirrus/test/cs_dsp_mock_wmfw.c
@@ -334,7 +334,7 @@ void cs_dsp_mock_wmfw_add_coeff_desc(struct cs_dsp_mock_wmfw_builder *builder,
 				  sizeof(*ple32)) / sizeof(*ple32);
 
 		longstring = (__force struct wmfw_long_string *)ple32;
-		longstring->len = description_len;
+		longstring->len = cpu_to_le16(description_len);
 		memcpy(longstring->data, def->description, description_len);
 
 		/* Round up to next __le32 multiple */
-- 
2.39.5


