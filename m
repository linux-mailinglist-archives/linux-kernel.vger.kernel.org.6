Return-Path: <linux-kernel+bounces-558204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 821DDA5E2BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5AA719C0386
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D3C264A76;
	Wed, 12 Mar 2025 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ACL9g4Zq"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58A425A62C;
	Wed, 12 Mar 2025 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800161; cv=none; b=UhVcJdRJ+/jbWInMp15h2bqBXBjo6n5LDB970cVKDsCFCC5PUwyKTTtZMhkjSCZz/e6Man5rCcR02rNgvr7YDUDlP3ONImejG2XYVLfEnVNiszzGmU+xAv01H0cBaxejXNTt7J7B9fmBWVzSr5Yg3upwHXpiodw8m7+799dsgSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800161; c=relaxed/simple;
	bh=6127ygvZXTME1do5wRRtO3kMhMiQO3FkuwzLKOs7VxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgjYkfpnpj01LbYN44Acrct8dvEOhnHjfqGGezl9571vsoTubI7WJXiofADlCIxPj3maKgLZL8ulFSUMLdOJc+ih85hqGN03PFolJsjMgPhsUU6IzS+JPQnwJ3RPPBcgvME/p3x+kyaiddVnYEXIk0Ek4r3EQFRSJEw0Rwtbi3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ACL9g4Zq; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C5qIHr028516;
	Wed, 12 Mar 2025 12:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=0qla7TqeD7AP0VzkhQh1MZ4NW6vmChNeQKjzTjSN5wI=; b=
	ACL9g4Zq0BJusHjl8UOPZHH6VAgyfmaaxdU4KqIMDDdAgzeliNsePJrnAtzWNSQt
	+aesz4FU45VPgGhETW5i76skBQX6QmEYF+DiVaLA8uG6SwAjfU/tjoERdFz77qxE
	D8plNtvN6dxT+gnqiw3trJMNOZEKl9KREmdkwOli/DgY1BqE2qfPQucla3fCyTQ9
	uzxMUS6IQCilclzAdN8vduWqWtgH5syZvTcRpONINqj2AwgoOcVUHfkKO2mc401g
	HwjffHiKmS07A3k6aJXij74s4Is6mC/RU/v/JL8SvTwwxpdv3Pn4IrY0iM0SPvKA
	sKj8V7a4CMmsoTSXBGDWDg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45au85tfdn-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 12:22:10 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Mar
 2025 17:22:05 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 17:22:05 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 4A513822560;
	Wed, 12 Mar 2025 17:22:05 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <pierre-louis.bossart@linux.dev>,
        <yung-chuan.liao@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 5/6] ASoC: SDCA: Add SDCA Control Range data access helper
Date: Wed, 12 Mar 2025 17:22:04 +0000
Message-ID: <20250312172205.4152686-6-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250312172205.4152686-1-ckeepax@opensource.cirrus.com>
References: <20250312172205.4152686-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: I4pgDpYozK6LoXdN2NXB-_dU3ol17Ogp
X-Proofpoint-GUID: I4pgDpYozK6LoXdN2NXB-_dU3ol17Ogp
X-Authority-Analysis: v=2.4 cv=fv/cZE4f c=1 sm=1 tr=0 ts=67d1c2c2 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=-8eBNB2PD3_OK0XNUkQA:9
X-Proofpoint-Spam-Reason: safe

SDCA Ranges are two dimensional arrays of data associated with controls,
add a helper to provide an x,y access mechanism to the data and a helper
to locate a specific value inside a range.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/sdca_function.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/sound/sdca_function.h b/include/sound/sdca_function.h
index ca0376903e87c..d7489e3c7e471 100644
--- a/include/sound/sdca_function.h
+++ b/include/sound/sdca_function.h
@@ -1136,6 +1136,25 @@ struct sdca_function_data {
 	unsigned int busy_max_delay;
 };
 
+static inline u32 sdca_range(struct sdca_control_range *range,
+			     unsigned int col, unsigned int row)
+{
+	return range->data[(row * range->cols) + col];
+}
+
+static inline u32 sdca_range_search(struct sdca_control_range *range,
+				    int search_col, int value, int result_col)
+{
+	int i;
+
+	for (i = 0; i < range->rows; i++) {
+		if (sdca_range(range, search_col, i) == value)
+			return sdca_range(range, result_col, i);
+	}
+
+	return 0;
+}
+
 int sdca_parse_function(struct device *dev,
 			struct sdca_function_desc *desc,
 			struct sdca_function_data *function);
-- 
2.39.5


