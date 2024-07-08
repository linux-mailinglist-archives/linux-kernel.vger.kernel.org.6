Return-Path: <linux-kernel+bounces-244501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A8692A51C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610831C21AC5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDB0140363;
	Mon,  8 Jul 2024 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="p3UlSIKo"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941DE13FD8C;
	Mon,  8 Jul 2024 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450157; cv=none; b=VKqg1EQSFu290ZiPFB7RIfbrFYStJlbzV1h1t0dLrrMA/RzzwEdNJ2/t4fFP24ZEmMdx5VqJFfiyouUgEBnTLvV7xEiMBIM1iQ32R10RpU7lkKyqkJVN2icTpZQlRqcxzNtMrbaom2vqLDUobk3MNwikDVX0ShKWtysu+pIx86U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450157; c=relaxed/simple;
	bh=z781XFgAu6Gb7mSdPzePCv03ZyJcZhjXm/dGiLnhcXQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GGGFijYQWphl9Gzx0Mndh3EdT2MSS7wcUYL3IVtDTUQOkzAYgZu/AtmX0xMFQA0ClTbH0rgFYLuk4vfUibaOOhM0oj/mgf6dB079M4MQRQ6Z3jgJortAWxzFtdtApC4IFnjZACthDqv0k1wt/V9FeG+AxKhNa/WmxfxIwnRwtLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=p3UlSIKo; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687RE75025730;
	Mon, 8 Jul 2024 09:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=EI1gyBEUL/L/gMbK
	lNgm8TuixCJBNXmQ4JPs9SARDuw=; b=p3UlSIKoPCsxGT9w2op8UkULnqNufwjW
	rrlDC2Eq+ozuxGf5sWK7UCP0ltfXWQCrTmhbjyye8vH1vKkRk3CMGDltnUOEye/g
	QjYdWsdGxdZcVGn4f1K4+3zD+juLp3TDc03vL/2Clt4QEIy+dSngo5qedz01i5lw
	iKgN4hXSYNTaeCQGa0GmkiIulz8L90BdNYrhQ2xsLncEFKsfQLmIvxRr6ZV789xD
	FN1ForJWq6BSmBIv6QZoeyUlEa0p4ae2mglg5Yh4ClAdouiCDrWj6vM7Cfumvd/3
	dP1VjJAQum+6mhrCPCkaC8l0jm7NBpS15rJ1MYbBigOnD1EkDLDCyA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4073axsm0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 09:48:57 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Jul 2024
 15:48:55 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 8 Jul 2024 15:48:55 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 13578820244;
	Mon,  8 Jul 2024 14:48:55 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH] firmware: cs_dsp: Use strnlen() on name fields in V1 wmfw files
Date: Mon, 8 Jul 2024 15:48:55 +0100
Message-ID: <20240708144855.385332-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0EfxtVBMUaeoF8YGw4iXUuD0UUPjf5u2
X-Proofpoint-GUID: 0EfxtVBMUaeoF8YGw4iXUuD0UUPjf5u2
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
index d2aa0980ed78..0a504a3c4375 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -1166,7 +1166,7 @@ static inline void cs_dsp_coeff_parse_alg(struct cs_dsp *dsp, const u8 **data,
 
 		blk->id = le32_to_cpu(raw->id);
 		blk->name = raw->name;
-		blk->name_len = strlen(raw->name);
+		blk->name_len = strnlen(raw->name, ARRAY_SIZE(raw->name));
 		blk->ncoeff = le32_to_cpu(raw->ncoeff);
 		break;
 	default:
@@ -1199,7 +1199,7 @@ static inline void cs_dsp_coeff_parse_coeff(struct cs_dsp *dsp, const u8 **data,
 		blk->offset = le16_to_cpu(raw->hdr.offset);
 		blk->mem_type = le16_to_cpu(raw->hdr.type);
 		blk->name = raw->name;
-		blk->name_len = strlen(raw->name);
+		blk->name_len = strnlen(raw->name, ARRAY_SIZE(raw->name));
 		blk->ctl_type = le16_to_cpu(raw->ctl_type);
 		blk->flags = le16_to_cpu(raw->flags);
 		blk->len = le32_to_cpu(raw->len);
-- 
2.39.2


