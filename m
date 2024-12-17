Return-Path: <linux-kernel+bounces-449304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161829F4D00
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8203B7A4225
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4A31F5401;
	Tue, 17 Dec 2024 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="RdNb/jq6"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5062C1F472C;
	Tue, 17 Dec 2024 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443987; cv=none; b=gOMZ6X4mbYTPiAyyEBfxkCLXjsfubrM/FeuBoxZbAc60Pe7ELrSL0ela0eS7LW3DTJrdEIFY64Kxn3YiYvHf8jEhtA+CTYGslzXhWQqiNRUTvQldgTh0tmB+WeZau2pHrDmN+jx+xYbp41zs0BSENa+AwV6L3U0drA2qkqlaolY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443987; c=relaxed/simple;
	bh=bYCXv5yKC61M7oQp+mtFhgUfAZw2ETsVra/7uFlfmwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSzRSi+O7MtoDqF1tIyZNj2DpH698T9ceoWJeE57KKv7eMk6K/SMZMj4Fjqi6K3hGLZuJekxRwMV5xX896WxTPnqW0LHcF0EtIc6OWpocdWshb7PHfbOTAVczo2AVQCq4Z6XR0jMWOBjOJx9VuSNSkO+V4PCkqZGmtOjrRZwhrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=RdNb/jq6; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH47Fb2011049;
	Tue, 17 Dec 2024 07:59:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=B2NhyqpnSsex+JDvv9pDFT7w1tA6gR4VXwzEnWWZ4MY=; b=
	RdNb/jq6BeSPK3zk9YhhfXku1AFSNIXr0RUByG9gLCUlTF2W8Q+uEsHrQA/f8m0t
	UhFNNch/AcgqIr5M2Ywd5agdLRVzeXI0LuPf+iUE5+Ag31fGgnzh/PcY/B3cEsrZ
	FiX6bJylxFNYKDONdORCcTTIbITDChuIuO9ih3fdu6HJ/TZPK6nfsaeYAC47W15l
	t6MWpBG3JJJCKo3ANkdqkr2qRIkqsykbzD/O4BH8kJqY24aimrWz0k6Njahb5D/R
	hJf143zU1kLJAnjowyUgKVSWglY6f+yxlHLmz1Bvb8PSTs7jHRcNNgKWq0QCyolz
	1D9B4e04C7EuSJtkCVSA9w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43h7akbb0q-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 07:59:25 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Tue, 17 Dec
 2024 13:59:22 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Tue, 17 Dec 2024 13:59:22 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id D65CD822544;
	Tue, 17 Dec 2024 13:59:21 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>, <oder_chiou@realtek.com>
CC: <jack.yu@realtek.com>, <shumingf@realtek.com>, <lgirdwood@gmail.com>,
        <peter.ujfalusi@linux.intel.com>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <pierre-louis.bossart@linux.dev>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 2/5] ASoC: SDCA: Update list of entity_0 controls
Date: Tue, 17 Dec 2024 13:59:18 +0000
Message-ID: <20241217135921.3572496-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217135921.3572496-1-ckeepax@opensource.cirrus.com>
References: <20241217135921.3572496-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: odzo_7eD6Cc-xBn_TkTR78yDcx8UdS2o
X-Proofpoint-ORIG-GUID: odzo_7eD6Cc-xBn_TkTR78yDcx8UdS2o
X-Proofpoint-Spam-Reason: safe

Update the list of entity_0 controls to better match version v1.0 of the
SDCA specification. Remove both INTSTAT_CLEAR and INT_ENABLE as these are
no longer used, and add some missing controls and bits into the enum. Also
rename the SDCA_CONTROL prefix to SDCA_CTL because this better matches the
macros in the sdw_registers.h header, and the names can get quite long so
saving a few characters is definitely a plus.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/sdca_function.h | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/sound/sdca_function.h b/include/sound/sdca_function.h
index a01eec86b9a6..9dc5bfec07e5 100644
--- a/include/sound/sdca_function.h
+++ b/include/sound/sdca_function.h
@@ -42,14 +42,31 @@ enum sdca_function_type {
 #define	SDCA_FUNCTION_TYPE_HID_NAME		"HID"
 
 enum sdca_entity0_controls {
-	SDCA_CONTROL_ENTITY_0_COMMIT_GROUP_MASK		= 0x01,
-	SDCA_CONTROL_ENTITY_0_INTSTAT_CLEAR		= 0x02,
-	SDCA_CONTROL_ENTITY_0_INT_ENABLE		= 0x03,
-	SDCA_CONTROL_ENTITY_0_FUNCTION_SDCA_VERSION	= 0x04,
-	SDCA_CONTROL_ENTITY_0_FUNCTION_TOPOLOGY		= 0x05,
-	SDCA_CONTROL_ENTITY_0_FUNCTION_MANUFACTURER_ID	= 0x06,
-	SDCA_CONTROL_ENTITY_0_FUNCTION_ID		= 0x07,
-	SDCA_CONTROL_ENTITY_0_FUNCTION_VERSION		= 0x08
+	SDCA_CTL_ENTITY_0_COMMIT_GROUP_MASK		= 0x01,
+	SDCA_CTL_ENTITY_0_FUNCTION_SDCA_VERSION		= 0x04,
+	SDCA_CTL_ENTITY_0_FUNCTION_TYPE			= 0x05,
+	SDCA_CTL_ENTITY_0_FUNCTION_MANUFACTURER_ID	= 0x06,
+	SDCA_CTL_ENTITY_0_FUNCTION_ID			= 0x07,
+	SDCA_CTL_ENTITY_0_FUNCTION_VERSION		= 0x08,
+	SDCA_CTL_ENTITY_0_FUNCTION_EXTENSION_ID		= 0x09,
+	SDCA_CTL_ENTITY_0_FUNCTION_EXTENSION_VERSION	= 0x0A,
+	SDCA_CTL_ENTITY_0_FUNCTION_STATUS		= 0x10,
+	SDCA_CTL_ENTITY_0_FUNCTION_ACTION		= 0x11,
+	SDCA_CTL_ENTITY_0_MATCHING_GUID			= 0x12,
+	SDCA_CTL_ENTITY_0_DEVICE_MANUFACTURER_ID	= 0x2C,
+	SDCA_CTL_ENTITY_0_DEVICE_PART_ID		= 0x2D,
+	SDCA_CTL_ENTITY_0_DEVICE_VERSION		= 0x2E,
+	SDCA_CTL_ENTITY_0_DEVICE_SDCA_VERSION		= 0x2F,
+
+	/* Function Status Bits */
+	SDCA_CTL_ENTITY_0_DEVICE_NEWLY_ATTACHED		= BIT(0),
+	SDCA_CTL_ENTITY_0_INTS_DISABLED_ABNORMALLY	= BIT(1),
+	SDCA_CTL_ENTITY_0_STREAMING_STOPPED_ABNORMALLY	= BIT(2),
+	SDCA_CTL_ENTITY_0_FUNCTION_FAULT		= BIT(3),
+	SDCA_CTL_ENTITY_0_UMP_SEQUENCE_FAULT		= BIT(4),
+	SDCA_CTL_ENTITY_0_FUNCTION_NEEDS_INITIALIZATION	= BIT(5),
+	SDCA_CTL_ENTITY_0_FUNCTION_HAS_BEEN_RESET	= BIT(6),
+	SDCA_CTL_ENTITY_0_FUNCTION_BUSY			= BIT(7),
 };
 
 #endif
-- 
2.39.5


