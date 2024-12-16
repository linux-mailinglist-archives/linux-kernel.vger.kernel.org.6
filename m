Return-Path: <linux-kernel+bounces-447185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C09849F2E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB30166065
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FD9203D78;
	Mon, 16 Dec 2024 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XG2Xb/XY"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D251E202C49;
	Mon, 16 Dec 2024 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346530; cv=none; b=oq2RpAGFJr8ZU4+2OJlwrkJougxU6IDyp33N2PDFerLNyjtFKGX30J8KroI456+7p+edoWcW+45raQjMF5hiHm5zeqafMBgxWBmlD+sbz3KC1BZDMtWAFFmla1takE3/DW03G00wlvGsB0PGMBJnOzUZ4wPpnt3yxmD1Ma/N6Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346530; c=relaxed/simple;
	bh=zTkjL6NRUyqG3EUlsoGAyWI//1gu2i7DthsC5AtINls=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XrRDdYe4r1CD4HW2AQr+/DP79hHzqGcnZhB/1R1SHhhE01gNPGl23bfDWrneV8ys0kGVVIASvSeBJ5Jz2JJd7Z3muwCwmpjuPn6jCLN3bDOIjCQ0PzXHayr+Xh7AMPRke4jkO5JD23Zz96sWSu7RXKzPfoyBAsZBeVSOjzeCPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XG2Xb/XY; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG6mTpT012591;
	Mon, 16 Dec 2024 04:55:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=mXDLZN2XD3GzhAnU
	AbD6xDpT13bOLj4uPQUcPbphOnA=; b=XG2Xb/XYk4CD0D8RwFbyTxDCq4roBUt8
	7r+GkDSTgYGZmLkTDiMbwPysmdtWylLkg+wRYxJ8QCIOj6rZYRG2fCE6K7vD1Ow8
	7pjr7qomJVHCgVsEvm2gMGuIYihIqjp+iBRiiNbwCyQtdoEXkehOGS6tPg5pxcNJ
	4o54pO7KGkfVTEvrMLYN+aT5LU0qz7ShpzY6OvsTEdR0rqb/JD1HLQ8Ld5vPO1Om
	2MFXRxpfcMcCfFOTDVwccvZ6BbTfWWI2bVTTp6lMEB27hk/ScO6jU9GPwjBdih50
	HEsEpVeWVVyYOa9chVeo59At7IW7HFfxuWG5dCC9SjlR9/XaZC+jlg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 43h8a21s0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 04:55:22 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Mon, 16 Dec
 2024 10:55:20 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Mon, 16 Dec 2024 10:55:20 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 245F3820248;
	Mon, 16 Dec 2024 10:55:20 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: [PATCH] firmware: cs_dsp: Fix kerneldoc typos in cs_dsp_mock_bin.c
Date: Mon, 16 Dec 2024 10:55:20 +0000
Message-ID: <20241216105520.22135-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Yuoi5O_RuCGYFieiQvAbw5qkLagjxqG1
X-Proofpoint-GUID: Yuoi5O_RuCGYFieiQvAbw5qkLagjxqG1
X-Proofpoint-Spam-Reason: safe

Fix two places in kerneldoc where alg_id had been mistyped as alg_ig.

Fixes: 7c052c661529 ("firmware: cs_dsp: Add mock bin file generator for KUnit testing")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412142205.HHHcousT-lkp@intel.com/
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/test/cs_dsp_mock_bin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/cirrus/test/cs_dsp_mock_bin.c b/drivers/firmware/cirrus/test/cs_dsp_mock_bin.c
index 1e271ccfd9b0..49d84f7e59e6 100644
--- a/drivers/firmware/cirrus/test/cs_dsp_mock_bin.c
+++ b/drivers/firmware/cirrus/test/cs_dsp_mock_bin.c
@@ -53,7 +53,7 @@ EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_bin_get_firmware, "FW_CS_DSP_KUNIT_TEST_UTILS")
  * cs_dsp_mock_bin_add_raw_block() - Add a data block to the bin file.
  *
  * @builder:		Pointer to struct cs_dsp_mock_bin_builder.
- * @alg_ig:		Algorithm ID.
+ * @alg_id:		Algorithm ID.
  * @alg_ver:		Algorithm version.
  * @type:		Type of the block.
  * @offset:		Offset.
@@ -139,7 +139,7 @@ EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_bin_add_name, "FW_CS_DSP_KUNIT_TEST_UTILS");
  * cs_dsp_mock_bin_add_patch() - Add a patch data block to the bin file.
  *
  * @builder:		Pointer to struct cs_dsp_mock_bin_builder.
- * @alg_ig:		Algorithm ID for the patch.
+ * @alg_id:		Algorithm ID for the patch.
  * @alg_ver:		Algorithm version for the patch.
  * @mem_region:		Memory region for the patch.
  * @reg_addr_offset:	Offset to start of data in register addresses.
-- 
2.39.5


