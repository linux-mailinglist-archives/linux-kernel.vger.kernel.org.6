Return-Path: <linux-kernel+bounces-449102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E019F49E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85E6188BD73
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18171F03E0;
	Tue, 17 Dec 2024 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="lmgNnhfL"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C121EF0A1;
	Tue, 17 Dec 2024 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435094; cv=none; b=sDOuxZbFOM/Dr0XNguUy5iquxjVb7EHBjKGSzNV+9souV+2CWvQgnKBvaWU4npSMT8tjdFHnO+PR8fLcGqJKgVxF2miMLfH2IxkzfxqdneAhFwirPhyyJYhGtPIv4XWoj6Tt/fT6MxHC4CcL4bD8qZfY5mwciaJfGCJSNSkjlvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435094; c=relaxed/simple;
	bh=LVb5TPKRGE4rQfPY1t923yjgSTIPeFhHZBX2+8g/SyU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mGN9dm7s0EejAE5qjvn5DVGQH17qYFD4qxGR48vpU/VhGtRZDQmPjbXOGArYflh++0y00Wh1jd9IYu1PAMKfFmIE5L6ZkdreQYNWlaqYyx47+XMJapb95aMhoHmA+3lHnYef4bOzR7r76Xlt62zYmZ1/cw5clwMHGz1dsMJWnYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=lmgNnhfL; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH59KoI017522;
	Tue, 17 Dec 2024 05:31:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=6g9QIbqx/y9tAqWn
	LzPJDI6PAJxXqqi9jOxeTtD8CYw=; b=lmgNnhfL5QT71O6wO+jG5tFuf6/vhn6+
	SBsoarkL0/t8Ew0fc9N/sA1EVGtWcbyJEkiZWDwd7QPSNAyZOZfSSCLQ+E4b4hO2
	i665SL9aQ/StT6syEGqxVQIQokUb7ueqGZLJTJ069SYVVeiNmTwMfR+SrVbqVv57
	573yJ39D8hVX/5fVW+0dZ14G9xRCvPQ7zPgFsIcco9/Adoj+0byyJk4k0GmeE3ph
	Yt5g64kWKfA3FTo7aog2itNzL46PU/AbkjkdNWwBhLMrUVaNPzMQGmMpzFiLOLVy
	1y3oJjN76p2yK1fL+UplV0miFwhXZpsPog0WZzVCSwSpKrjGJ2RikQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 43h8a239ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 05:31:29 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Tue, 17 Dec
 2024 11:31:27 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Tue, 17 Dec 2024 11:31:27 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6443B820248;
	Tue, 17 Dec 2024 11:31:27 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>
Subject: [PATCH] firmware: cs_dsp: Avoid using a u32 as a __be32 in cs_dsp_mock_mem_maps.c
Date: Tue, 17 Dec 2024 11:31:27 +0000
Message-ID: <20241217113127.186736-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _VsQLcmRBp5Q0PJMkj1ZOVJC8ECxrdnR
X-Proofpoint-GUID: _VsQLcmRBp5Q0PJMkj1ZOVJC8ECxrdnR
X-Proofpoint-Spam-Reason: safe

In cs_dsp_mock_xm_header_drop_from_regmap_cache() for the ADSP2 case read
the big-endian firmware word into a dedicated __be32 variable instead of
using the same u32 for both the big-endian and cpu-endian value.

Fixes: 41e78c0f44f9 ("firmware: cs_dsp: Add mock DSP memory map for KUnit testing")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/test/cs_dsp_mock_mem_maps.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/cirrus/test/cs_dsp_mock_mem_maps.c b/drivers/firmware/cirrus/test/cs_dsp_mock_mem_maps.c
index ae5d57bdcc2f..161272e47bda 100644
--- a/drivers/firmware/cirrus/test/cs_dsp_mock_mem_maps.c
+++ b/drivers/firmware/cirrus/test/cs_dsp_mock_mem_maps.c
@@ -526,7 +526,8 @@ void cs_dsp_mock_xm_header_drop_from_regmap_cache(struct cs_dsp_test *priv)
 {
 	unsigned int xm = cs_dsp_mock_base_addr_for_mem(priv, WMFW_ADSP2_XM);
 	unsigned int bytes;
-	u32 num_algs;
+	__be32 num_algs_be32;
+	unsigned int num_algs;
 
 	switch (priv->dsp->type) {
 	case WMFW_ADSP2:
@@ -536,8 +537,8 @@ void cs_dsp_mock_xm_header_drop_from_regmap_cache(struct cs_dsp_test *priv)
 		 */
 		regmap_raw_read(priv->dsp->regmap,
 				xm + (offsetof(struct wmfw_adsp2_id_hdr, n_algs) / 2),
-				&num_algs, sizeof(num_algs));
-		num_algs = be32_to_cpu(num_algs);
+				&num_algs_be32, sizeof(num_algs_be32));
+		num_algs = be32_to_cpu(num_algs_be32);
 		bytes = sizeof(struct wmfw_adsp2_id_hdr) +
 			(num_algs * sizeof(struct wmfw_adsp2_alg_hdr)) +
 			4 /* terminator word */;
-- 
2.39.5


