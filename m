Return-Path: <linux-kernel+bounces-246090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A880692BD7A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA33E1C219DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A54719CD03;
	Tue,  9 Jul 2024 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VUws4sia"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ABD14EC41;
	Tue,  9 Jul 2024 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536738; cv=none; b=t+8EEg8IdUYqsLznYEskv7IChSTYjKaiHLnIb/jixtNJyBXbJ5M0HDQxnY1B/6rfrl/peDG3WNxXK9+NZruuiLDbjh3brJvOMzWqbXcWMtW64kkO5Tpa7moIL/JUcVkjRU1nIK9joupkhHy0vlr6lOG1qI9K8Ovfnp5/GM6XsBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536738; c=relaxed/simple;
	bh=w6bnO4FXGLkv0kiWma3TyTD9lix6tsitqIFPbJa90q8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXAcGGOE53X16XbK6/xbvb4ZoatN9YaJCpMEWf6Np/nrFJAyb7/Ttum0pETzT5t6acjmaOjvQx2qgvVEH5toTPwEN5hFRiwzPFcmf+GeneV5XqEWpoSFjGWB1IMd0uSdrRb6lmlOlyzmDuLt7twmgNwjO2i966OtplITZHUFqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VUws4sia; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4699SgHc015345;
	Tue, 9 Jul 2024 09:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=y76QHNI6/5GC9gzkTC3WfDuRlPen11I/0SbKaKMkNqM=; b=
	VUws4siaXvIgH8n/5KY2eRNsHN1kOazRMM2FjxnGmoQz1D3aIxVTnuRslCkxSxmb
	2j2/JvBh8P2gPrFESl66f2OfYo20qq1TJ0y4pWd0Sg5WWPs38DRA2Tz8FaBD3f+U
	0qkK+RMe6das0eeZBmLI5VtaQLZq/UfgUM69iLwzOhPAYNvD9HruF1lrJkwr10fY
	wT7vEDUAdltc7y6V+9Qv0tCDGavpBF+jePjutW4ombpyBEK69ZfgVjYHg2UQGD5n
	RCwW2Hl75SLj5vgwUUcXH+8P7Vhk+M27Pb5q8diU2ElXbPdfjdmrAvvAEq0fVyOI
	JE0Y0oDzDLoVgdLxfoVmaw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4073axtqjf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 09:52:00 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 15:51:57 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 9 Jul 2024 15:51:57 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 17D36820258;
	Tue,  9 Jul 2024 14:51:57 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 3/4] firmware: cs_dsp: Merge wmfw format log message into INFO message
Date: Tue, 9 Jul 2024 15:51:55 +0100
Message-ID: <20240709145156.268074-4-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: hsy1gjFLOG2l16JQZJITqkqtyPPGJWSr
X-Proofpoint-GUID: hsy1gjFLOG2l16JQZJITqkqtyPPGJWSr
X-Proofpoint-Spam-Reason: safe

Log the WMFW file format version with the INFO_TEST message.

The behaviour of firmware controls depends on the WMFW format version,
so this is useful information to log for debugging. But there's no
need to use a separate log line just for this value.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 1bc2e0b6d40b..141a6c9d6737 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -1502,7 +1502,6 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 		goto out_fw;
 	}
 
-	cs_dsp_info(dsp, "Firmware version: %d\n", header->ver);
 	dsp->fw_ver = header->ver;
 
 	if (header->core != dsp->type) {
@@ -1552,7 +1551,7 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 		case WMFW_INFO_TEXT:
 		case WMFW_NAME_TEXT:
 			region_name = "Info/Name";
-			cs_dsp_info(dsp, "%s: %.*s\n", file,
+			cs_dsp_info(dsp, "%s (rev %d): %.*s\n", file, dsp->fw_ver,
 				    min(le32_to_cpu(region->len), 100), region->data);
 			break;
 		case WMFW_ALGORITHM_DATA:
-- 
2.39.2


