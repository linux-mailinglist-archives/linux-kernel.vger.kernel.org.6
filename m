Return-Path: <linux-kernel+bounces-244526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFDF92A584
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BE01C213F9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D271411D7;
	Mon,  8 Jul 2024 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HlQuxlFQ"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C430176035;
	Mon,  8 Jul 2024 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452065; cv=none; b=X+vxP4SJUdRFijULPpckdomFYwX46eXNVgzNE1K/zhGwv7FOiLjhP63FtosHoJtOr35bbrYHzG/5im3Ch6Pe3qbeVspWLvCw9auZGuX9oyuKzt+jKSIC0Q3JbMJmthZ/+wo+6IL0uvxLNnY9qf0EcyKFbUjQmjLPjzNsO5mm5O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452065; c=relaxed/simple;
	bh=BQsr0QooV/d3TxNeQGRSzfpz7axyeeF7mtNZAvlbAow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lClZEa0nKds6cxVVhdxT2WyguFr9hGiOsVQ6k7aKMa8GVfWgKLvLfKi0GvlnOLIgP1rbLDfrtrpYM5gIXqvhUvbSyOD+h38MOCaZug8rmN+6SMtAWj3kljwcKIbOYn8BalnelMklO5RGcEeWHsuVmASo4Rmm0P4lFKvhCa+fN1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HlQuxlFQ; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46870Jll022463;
	Mon, 8 Jul 2024 10:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=VTOCAsJ2DgwNIHbx
	lWGqUzgfjvlXFbBnCmhOojAy2co=; b=HlQuxlFQRwqxRBxlvheArRTSQJK7x5M6
	sdtW1UOjzaP284RvHM9DydKmRqLxzpXBe8PThwO7nxJ/W3sNwFZ40ODOS4B5AwSc
	UnAzNm+2mu/lWZ14Nv7SrBZj3QwPT7AgkSPQ6BNpUkQ/D6OI3Lz9HQTNpyut6o7n
	3VD2FUM96cR6HyLjN1lyJRDU06KdZUNh3kliBL6yt/ioo/plf07cyupihShDpw/1
	tlaW4YjY2ko6cV9c9b9Bc3zwSDSdcZx1tfO53Dp336GW2OV0Y/8MByi5qGLdSRY8
	/a0jLzvdjTaDESmZwFAH4wrFtOu64gjWGY49bDoRy5Fkn2U1G91sBA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4073axsnbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 10:20:55 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Jul 2024
 16:20:52 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 8 Jul 2024 16:20:52 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 4B96882024D;
	Mon,  8 Jul 2024 15:20:52 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH v2] firmware: cs_dsp: Use strnlen() on name fields in V1 wmfw files
Date: Mon, 8 Jul 2024 16:20:52 +0100
Message-ID: <20240708152052.390594-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 80UGiJTZpRXp0rd6aaAHA3UiHuVIHDZM
X-Proofpoint-GUID: 80UGiJTZpRXp0rd6aaAHA3UiHuVIHDZM
X-Proofpoint-Spam-Reason: safe

Use strnlen() instead of strlen() on the algorithm and coefficient name
string arrays in V1 wmfw files.

In V1 wmfw files the name is a NUL-terminated string in a fixed-size
array. cs_dsp should protect against overrunning the array if the NUL
terminator is missing.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: f6bc909e7673 ("firmware: cs_dsp: add driver to support firmware loading on Cirrus Logic DSPs")
---
 drivers/firmware/cirrus/cs_dsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 16484ab9b09d..8a347b938406 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -1183,4 +1183,4 @@ static int cs_dsp_coeff_parse_alg(struct cs_dsp *dsp,
 		blk->id = le32_to_cpu(raw->id);
 		blk->name = raw->name;
-		blk->name_len = strlen(raw->name);
+		blk->name_len = strnlen(raw->name, ARRAY_SIZE(raw->name));
 		blk->ncoeff = le32_to_cpu(raw->ncoeff);
@@ -1260,4 +1260,4 @@ static int cs_dsp_coeff_parse_coeff(struct cs_dsp *dsp,
 		blk->name = raw->name;
-		blk->name_len = strlen(raw->name);
+		blk->name_len = strnlen(raw->name, ARRAY_SIZE(raw->name));
 		blk->ctl_type = le16_to_cpu(raw->ctl_type);
 		blk->flags = le16_to_cpu(raw->flags);
-- 
2.39.2


