Return-Path: <linux-kernel+bounces-558203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEB1A5E2BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF8B164E94
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910BE263F35;
	Wed, 12 Mar 2025 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GotZy3ec"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370E425A345;
	Wed, 12 Mar 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800160; cv=none; b=LuJtqUOt84S5UMtsraYUmbD2JgaOj58QBeBLM6GH7thhywc01CFRRoVRiPhV3fvCYZIqW3JxuPfBpsoN0CdDaErGFmLrZoAsosvUYsPWWTyjlZIuC7nEq8h+Nn4dpp6qpV3GorcLNsAVUmsx5TJuNT9AuwBuoya5nR9MA61yfMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800160; c=relaxed/simple;
	bh=8RZpTNrxRgEy840kLhtmbXv+dqKPikz10SZRdFYFHJo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnGRMjv+sL2c+fBC9SYpJEhY1cbsLn1fo0e8Xz7cfpQWbhnbf5YSNZlY8RfZNlVzLy8cV/EE3h+xF1UDTKW8jue1JOuhFeheIjGEiolML8Wup+BVBt6cHpiWRznPlr5RixL9T0pw+CPIw9zzRONSt5GSqz6k5aqWTImPNx7TZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GotZy3ec; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C5qIHq028516;
	Wed, 12 Mar 2025 12:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ezUeGDZHweKiEEZic4xQCO7F9z7Om2v8wl8Z8QPEgp8=; b=
	GotZy3ecnDKLJ6XLDRhQbTf84dvALByIMsl5acMSRoI/YAdkFzE4sVrGDkR2K+nw
	BI9cXLqNfQgkPYrlIBuPrQZDo8ewpo8vVGdly7MVCNSBEHVVpK4GP1hqCDJoNdSQ
	WIQ6xeLm/F4XtTW3UjqUZ71JkWFHdUEpuqQP1v5DyL6WtH6sbPVfYiva0TgbMAgL
	FnjGZn1au43DO87RyFP9F+ElN47ftB6SYL6DGJHbWDw4VkQSqyeuiLfycC+zLjWV
	NOYc9V2H/v0SX8hgeTXMlPhByG7H0fx7MxdCO0ZWi6Y7YL8uJSRMuWe+k/4G+6m7
	m8Sw6+KQlFq8SU59MQO2+A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45au85tfdn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 12:22:09 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Mar
 2025 17:22:05 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 17:22:05 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 244A982255C;
	Wed, 12 Mar 2025 17:22:05 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <pierre-louis.bossart@linux.dev>,
        <yung-chuan.liao@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 1/6] ASoC: SDCA: Tidy up initialization write parsing
Date: Wed, 12 Mar 2025 17:22:00 +0000
Message-ID: <20250312172205.4152686-2-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: hQyLHgIBbLP-fUhrd5QsPAdxWvgLFw73
X-Proofpoint-GUID: hQyLHgIBbLP-fUhrd5QsPAdxWvgLFw73
X-Authority-Analysis: v=2.4 cv=fv/cZE4f c=1 sm=1 tr=0 ts=67d1c2c1 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=hwdkbXGhDEx7mCVxsSsA:9
X-Proofpoint-Spam-Reason: safe

Slightly neaten up the initialization write code to overlay a struct
rather than shifting the pointer along manually. This also removes the
Sparse warning:

sound/soc/sdca/sdca_functions.c:233:36: warning: cast to restricted __le32

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/sdca/sdca_functions.c | 43 ++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/sound/soc/sdca/sdca_functions.c b/sound/soc/sdca/sdca_functions.c
index 091d55abe1091..133cbde17ef48 100644
--- a/sound/soc/sdca/sdca_functions.c
+++ b/sound/soc/sdca/sdca_functions.c
@@ -10,6 +10,7 @@
 
 #include <linux/acpi.h>
 #include <linux/byteorder/generic.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/dev_printk.h>
 #include <linux/module.h>
@@ -186,14 +187,18 @@ void sdca_lookup_functions(struct sdw_slave *slave)
 }
 EXPORT_SYMBOL_NS(sdca_lookup_functions, "SND_SOC_SDCA");
 
+struct raw_init_write {
+	__le32 addr;
+	u8 val;
+} __packed;
+
 static int find_sdca_init_table(struct device *dev,
 				struct fwnode_handle *function_node,
 				struct sdca_function_data *function)
 {
+	struct raw_init_write *raw __free(kfree) = NULL;
 	struct sdca_init_write *init_write;
-	int write_size = sizeof(init_write->addr) + sizeof(init_write->val);
-	u8 *init_list, *init_iter;
-	int num_init_writes;
+	int i, num_init_writes;
 
 	num_init_writes = fwnode_property_count_u8(function_node,
 						   "mipi-sdca-function-initialization-table");
@@ -203,7 +208,7 @@ static int find_sdca_init_table(struct device *dev,
 		dev_err(dev, "%pfwP: failed to read initialization table: %d\n",
 			function_node, num_init_writes);
 		return num_init_writes;
-	} else if (num_init_writes % write_size != 0) {
+	} else if (num_init_writes % sizeof(*raw) != 0) {
 		dev_err(dev, "%pfwP: init table size invalid\n", function_node);
 		return -EINVAL;
 	} else if (num_init_writes > SDCA_MAX_INIT_COUNT) {
@@ -211,33 +216,27 @@ static int find_sdca_init_table(struct device *dev,
 		return -EINVAL;
 	}
 
-	init_write = devm_kcalloc(dev, num_init_writes / write_size,
-				  sizeof(*init_write), GFP_KERNEL);
-	if (!init_write)
-		return -ENOMEM;
-
-	init_list = kcalloc(num_init_writes, sizeof(*init_list), GFP_KERNEL);
-	if (!init_list)
+	raw = kzalloc(num_init_writes, GFP_KERNEL);
+	if (!raw)
 		return -ENOMEM;
 
 	fwnode_property_read_u8_array(function_node,
 				      "mipi-sdca-function-initialization-table",
-				      init_list, num_init_writes);
+				      (u8 *)raw, num_init_writes);
 
-	function->num_init_table = num_init_writes;
-	function->init_table = init_write;
+	num_init_writes /= sizeof(*raw);
 
-	for (init_iter = init_list; init_iter < init_list + num_init_writes;) {
-		u32 *addr = (u32 *)init_iter;
-
-		init_write->addr = le32_to_cpu(*addr);
-		init_iter += sizeof(init_write->addr);
+	init_write = devm_kcalloc(dev, num_init_writes, sizeof(*init_write), GFP_KERNEL);
+	if (!init_write)
+		return -ENOMEM;
 
-		init_write->val = *init_iter;
-		init_iter += sizeof(init_write->val);
+	for (i = 0; i < num_init_writes; i++) {
+		init_write[i].addr = le32_to_cpu(raw[i].addr);
+		init_write[i].val = raw[i].val;
 	}
 
-	kfree(init_list);
+	function->num_init_table = num_init_writes;
+	function->init_table = init_write;
 
 	return 0;
 }
-- 
2.39.5


