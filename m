Return-Path: <linux-kernel+bounces-571656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DB8A6C03E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740143AD296
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F4D22DF83;
	Fri, 21 Mar 2025 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jJPPRBm/";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="qGpwkqPA"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233F422D4DC;
	Fri, 21 Mar 2025 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575201; cv=fail; b=GL76djdg37q8NeFsTC4zAZ8E2CPD4ixML443C47bu4ktI8HrEngkMdTZZEp7b1DxYZVaIF682/vFG3PexLeAd9oR0epTAf1yI4aIAV7UG6ZthWVTYRyPNDF2wgqsidO0uiVC+S9LCKsmP/F4jmP+5D6r+oFDKGzWfJEfUzcF0es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575201; c=relaxed/simple;
	bh=rJ7Zr+1aTfrpY77IoVlBdIDxsPzEFha9xZaOFWwpUx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLnElqZj1llrmh7QN/DAc2NPO983oFR02/P+g6ZIn8RxBn1ltuNdEcze78nGpvc3TaX4TgM++WIB+/xAU5biJYMZsDyOwdT7hD+tND5ZfND9YDLNKGJvozqQg2UINylyUIYPhBHS085DlIxu9gdfc6hvg/ErjjbCiIaus7nAyok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=jJPPRBm/; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=qGpwkqPA; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L5KkjG026985;
	Fri, 21 Mar 2025 11:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=bCQxKQMzWjQXS5Y/it3VH9/KsNGnaNyHPfw4WNeM/go=; b=
	jJPPRBm/UVJ4OXBo9XweURLGs3On9equXL0ALg92YVKdVma51wohX7HMppdr0zHv
	rTsYpkQcI0qhAo5Wi0IbEQos5oboaSjtRQkfpQkJgNwk80OS0RnxcPpMvzj0xiTy
	bwg41DpgUR2UpbFAXY22lpSjQjevcE3zM0Za3YauTflS8cPRPDKozE6BtUVteY/E
	llDYWyC0e9Wqu50qsbfAVSu80P7rmvUskUVChfPHuMIOklOFzqsZr6rUgJcMeYuZ
	JLojWMfjRJB4nKMA7ZsYqGaz6QxuywrmWB3cJjf4bZ6LO6O7JNKhBSBp2GY84vFu
	fOYt+PNoxhg2fpZuLfIhrg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45g9p6v7hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 11:39:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tq2mgzrQh7aEWmB/CGtsVrGIkuqmF8d7uKvM0KYXwt3FZWyPzrYpgp0rwKPVkZo0cNE2wfO8tL5Wnc7y6L6owbwjdJqJKJz+TzpvGrXzOCmqFRwQJ/lIGJ98hyca1erDwwO0Y/zAyJHbffyz1fcyPMkCSRydqrLIZXnX5bik7QJMW/J3IlsB8/m33e4xp6s4lPr4g9ZOzWHRJqwYbys5/fYceBJgr6jialshJWO80qTrfeS3g222zpHkjiD0k+cDaDbHY3kUJk+u1J0kQ7kWoAJO1Z7kpazhttUX9DHzY1AbS10NYyid8UKl/OykVMrXg/LlZRtu98AH5vhp4rbd9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCQxKQMzWjQXS5Y/it3VH9/KsNGnaNyHPfw4WNeM/go=;
 b=oLSisoyjG23eOXu8lXQfyn8j+G6LVfamOE7qjtOd8EpXrDR+XH+sbf11WNdyJsNniGaWc0bNTlhEQ2y/BJbR4FZrrzTD4j3ZXssCbYA8LSwCHxXtLTd9gkZgDRgpXq4EccK6La1MYZJ9mqrZMTuk3clSEKLQvtD+ZvwHok39Yt/OJQN1CMTOlf13RynXUo5Qg7ZvYKPTwKCY9ethOo5hzEyvtIi3nHE5DnSa7pdqeiklJHSadC6dCW+lVR6wszLS7lj8QvDa+/ia9KMsVuvH/TJo3SW/1Pn9C+c/tUEKVfFSuvs1fV/RCUDq1QKt8VT3OZT1J409pb9pQ3e5pc2V8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCQxKQMzWjQXS5Y/it3VH9/KsNGnaNyHPfw4WNeM/go=;
 b=qGpwkqPAyQ3IMcTzq/5v3v95J0HvHrm74yuFt6yK+IgJU2ol1uT2lAeXBz3toGdE1zmhvudBKhy8iKO8XsyTqUPD7tGsXMD20qME1a/ABDjqarLa0NxaCH/QV+p2KqX8BPcWaodAlFV2tgL5+tM46mSevDERvifsqoKG4u/+6OU=
Received: from MN2PR20CA0038.namprd20.prod.outlook.com (2603:10b6:208:235::7)
 by SA3PR19MB7748.namprd19.prod.outlook.com (2603:10b6:806:2fc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 16:39:31 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::f) by MN2PR20CA0038.outlook.office365.com
 (2603:10b6:208:235::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.37 via Frontend Transport; Fri,
 21 Mar 2025 16:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Fri, 21 Mar 2025 16:39:30 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E9EB6406547;
	Fri, 21 Mar 2025 16:39:28 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id BDD0482255C;
	Fri, 21 Mar 2025 16:39:28 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, pierre-louis.bossart@linux.dev,
        yung-chuan.liao@linux.intel.com, peter.ujfalusi@linux.intel.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 1/3] ASoC: SDCA: Create DAPM widgets and routes from DisCo
Date: Fri, 21 Mar 2025 16:39:26 +0000
Message-Id: <20250321163928.793301-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250321163928.793301-1-ckeepax@opensource.cirrus.com>
References: <20250321163928.793301-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|SA3PR19MB7748:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 03a37520-41dd-4f55-296b-08dd6896f41b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fRrMASubirLfI1edbieDyHmdLJg8SsmCZudEX1UegYieM37y0LHBcg6nrgVt?=
 =?us-ascii?Q?ZzKhCTOFKhBYvgloxAujR8JvPQxMB4RwTwW6swYjxpF4mfC7Ku9srkx6KVdV?=
 =?us-ascii?Q?Vo+DJ2ipR1CRNB3sSFbyGq61R1Ks2jLrVll2umpH8m0zZ3dD1NAjtUt3oNaf?=
 =?us-ascii?Q?E0WdDuvly1m5EEbZsKZmjvwj+enFJlP3TZe1Od3Do4ATvrhw5/niInf+l/kH?=
 =?us-ascii?Q?MdirKDEkRI+5rLgWLTTQdfsxC5pHjsq3P4TpcvDVwQlNWvPl0kl0++RQceuY?=
 =?us-ascii?Q?5/NtaFqW0XiAuJxVMA0q83Cbtd+UCLHdrAnPAjA3iLDS1ULwgP71jwCOdKFx?=
 =?us-ascii?Q?IuBYtc6Nr652hwExx8Bf55ZSZSIdF/zJxh6pAc11Ip5kfCBcMxXg3ixF5Fi0?=
 =?us-ascii?Q?5ZCb2HyZH1NO21g97bUR8TP24Z+95xDFhgb/bGAF/8i9IOvPNnMkCa2cQaIn?=
 =?us-ascii?Q?M4WRKXcwPpR2Y/ArmjYCyR3ac7hJzmbl8OE0MWrv4DkEci/aiQjG6kqpopAT?=
 =?us-ascii?Q?DvWFuIz8EPNRJlx8fyach6cZBwZkxJjtrtdyL5yNjvktGnwh/IsuSZgxqKRD?=
 =?us-ascii?Q?MIRSmbiwt+h5eCIPlnyv2uWopwJOnk+Z/Cm4Z0zeLA4U8dYgbYBMert52E5H?=
 =?us-ascii?Q?mQCN+A/u17hM6wzE1wbU+EL68sqfQiVF0I5yET5oGsup7D06ZjB89GOSukrO?=
 =?us-ascii?Q?dnSbwN0jN4NYkwTFqasgSLxcYUFkxXbVl9hBZ6CKevJnZ8QA5vX1/BaNfUPd?=
 =?us-ascii?Q?76dw/zFCnHNtQ2i/D2yKrcLjtFrJxF0Xt0GHqk7HJWFue+x3seehpUfUDlv2?=
 =?us-ascii?Q?ku4O+P/8S++r69gQzM0b7rzcG2nslV1Dde6BadGI5OXzRwpP+fkXvr/A8zJI?=
 =?us-ascii?Q?c+gVIlP+DhHtJeSMRP73gfhRnXawZd03fLX9EDa71me7JfKpxzxHn/bKTwAI?=
 =?us-ascii?Q?XCvp7haKpFXCM+PKjk5+gaX/woh07DDaMetGFqJaf6Z4I6PMNQ/3vf4VQDxD?=
 =?us-ascii?Q?mFc3KBorRLwdriZCkW9maSGiC5ed3yNgsRQW1riXJkUwKFd73GzsBbJ16g7X?=
 =?us-ascii?Q?NrEKQ88+MjnMZYT1XEO+IlzbGTOA1KnyLbFHt/dVG58+9EUpb1/ZrVKR6Q5q?=
 =?us-ascii?Q?oertw8J/r1beTSeLyrIEqa5l9GcMX5BN12GZ6cV9OPRphztnZA7TTiXoL6uV?=
 =?us-ascii?Q?PtfY+lYehMWt9dSofsk2wXqikxVZPlEqJ6m5gVvHG7RS/ko3Nbt6TDUZKUli?=
 =?us-ascii?Q?OPDngXVkeQAB/83107T6ydIYgvrZoriFEtGOBHFnTGs8IU2Z72th25/pNdhF?=
 =?us-ascii?Q?vKr8n20W0uQKh7Ip0Bbf86tlg5Dbwm4SOI3fmGfjjj9TogIj/IAaVxyTynnb?=
 =?us-ascii?Q?JvojIhnSqYOkWpGjAsbne45IBtBfl+70Nl+6ol37bRezJrl/tnKgNzJ8F3ZU?=
 =?us-ascii?Q?BpnZF43loKg=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 16:39:30.4094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a37520-41dd-4f55-296b-08dd6896f41b
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB7748
X-Authority-Analysis: v=2.4 cv=Vcz3PEp9 c=1 sm=1 tr=0 ts=67dd964a cx=c_pps a=sGbpJkUcFVeWJOR+0qTsNQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=KJT-RnjOAAAA:8 a=w1d2syhTAAAA:8 a=04aGDqRuwiNVRNv7JHcA:9 a=HE_01F9_QflCRFonrIQr:22 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-GUID: _j7s-kE4q1tegt5MzS5P4uKQoOyf6XnO
X-Proofpoint-ORIG-GUID: _j7s-kE4q1tegt5MzS5P4uKQoOyf6XnO
X-Proofpoint-Spam-Reason: safe

Use the previously parsed DisCo information from ACPI to create DAPM
widgets and routes representing a SDCA Function. For the most part SDCA
maps well to the DAPM abstractions.

The primary point of interest is the SDCA Power Domain Entities
(PDEs), which actually control the power status of the device. Whilst
these PDEs are the primary widgets the other parts of the SDCA graph
are added to maintain a consistency with the hardware abstract, and
allow routing to take effect.

Other minor points of slightly complexity include, the Group Entities
(GEs) these set the value of several other controls, typically
Selector Units (SUs) for enabling a cetain jack configuration. These
are easily modelled creating a single control and sharing it among
the controlled muxes.

SDCA also has a slight habit of having fully connected paths, relying
more on activating the PDEs to enable functionality. This doesn't map
quite so perfectly to DAPM which considers the path a reason to power
the PDE. Whilst in the current specification Mixer Units are defined as
fixed-function, in DAPM we create a virtual control for each input. This
allows paths to be connected/disconnected, providing a more ASoC style
approach to managing the power.

A top level helper sdca_asoc_populate_component() is exported that
counts and allocates everything, however, the intermediate counting and
population functions are also exported. This will allow end drivers to
do allocation and add custom handling, which is probably fairly likely
for the early SDCA devices.

Clock muxes are currently not fully supported, so some future work will
also be required there.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/sdca_asoc.h     |  30 ++
 include/sound/sdca_function.h |  36 ++
 sound/soc/sdca/Makefile       |   2 +-
 sound/soc/sdca/sdca_asoc.c    | 799 ++++++++++++++++++++++++++++++++++
 4 files changed, 866 insertions(+), 1 deletion(-)
 create mode 100644 include/sound/sdca_asoc.h
 create mode 100644 sound/soc/sdca/sdca_asoc.c

diff --git a/include/sound/sdca_asoc.h b/include/sound/sdca_asoc.h
new file mode 100644
index 0000000000000..414d461b6fc4a
--- /dev/null
+++ b/include/sound/sdca_asoc.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The MIPI SDCA specification is available for public downloads at
+ * https://www.mipi.org/mipi-sdca-v1-0-download
+ *
+ * Copyright (C) 2025 Cirrus Logic, Inc. and
+ *                    Cirrus Logic International Semiconductor Ltd.
+ */
+
+#ifndef __SDCA_ASOC_H__
+#define __SDCA_ASOC_H__
+
+struct device;
+struct sdca_function_data;
+struct snd_soc_component_driver;
+struct snd_soc_dapm_route;
+struct snd_soc_dapm_widget;
+
+int sdca_asoc_count_component(struct device *dev, struct sdca_function_data *function,
+			      int *num_widgets, int *num_routes);
+
+int sdca_asoc_populate_dapm(struct device *dev, struct sdca_function_data *function,
+			    struct snd_soc_dapm_widget *widgets,
+			    struct snd_soc_dapm_route *routes);
+
+int sdca_asoc_populate_component(struct device *dev,
+				 struct sdca_function_data *function,
+				 struct snd_soc_component_driver *component_drv);
+
+#endif // __SDCA_ASOC_H__
diff --git a/include/sound/sdca_function.h b/include/sound/sdca_function.h
index 253654568a41e..447752f71286a 100644
--- a/include/sound/sdca_function.h
+++ b/include/sound/sdca_function.h
@@ -257,6 +257,14 @@ enum sdca_pde_controls {
 	SDCA_CTL_PDE_ACTUAL_PS				= 0x10,
 };
 
+/**
+ * enum sdca_requested_ps_range - Column definitions for Requested PS
+ */
+enum sdca_requested_ps_range {
+	SDCA_REQUESTED_PS_STATE				= 0,
+	SDCA_REQUESTED_PS_NCOLS				= 1,
+};
+
 /**
  * enum sdca_ge_controls - SDCA Controls for Group Unit
  *
@@ -268,6 +276,15 @@ enum sdca_ge_controls {
 	SDCA_CTL_GE_DETECTED_MODE			= 0x02,
 };
 
+/**
+ * enum sdca_selected_mode_range - Column definitions for Selected Mode
+ */
+enum sdca_selected_mode_range {
+	SDCA_SELECTED_MODE_INDEX			= 0,
+	SDCA_SELECTED_MODE_TERM_TYPE			= 1,
+	SDCA_SELECTED_MODE_NCOLS			= 2,
+};
+
 /**
  * enum sdca_spe_controls - SDCA Controls for Security & Privacy Unit
  *
@@ -773,6 +790,25 @@ enum sdca_terminal_type {
 	SDCA_TERM_TYPE_PRIVACY_INDICATORS		= 0x747,
 };
 
+#define SDCA_TERM_TYPE_LINEIN_STEREO_NAME		"LineIn Stereo"
+#define SDCA_TERM_TYPE_LINEIN_FRONT_LR_NAME		"LineIn Front-LR"
+#define SDCA_TERM_TYPE_LINEIN_CENTER_LFE_NAME		"LineIn Center-LFE"
+#define SDCA_TERM_TYPE_LINEIN_SURROUND_LR_NAME		"LineIn Surround-LR"
+#define SDCA_TERM_TYPE_LINEIN_REAR_LR_NAME		"LineIn Rear-LR"
+#define SDCA_TERM_TYPE_LINEOUT_STEREO_NAME		"LineOut Stereo"
+#define SDCA_TERM_TYPE_LINEOUT_FRONT_LR_NAME		"LineOut Front-LR"
+#define SDCA_TERM_TYPE_LINEOUT_CENTER_LFE_NAME		"LineOut Center-LFE"
+#define SDCA_TERM_TYPE_LINEOUT_SURROUND_LR_NAME		"LineOut Surround-LR"
+#define SDCA_TERM_TYPE_LINEOUT_REAR_LR_NAME		"LineOut Rear-LR"
+#define SDCA_TERM_TYPE_MIC_JACK_NAME			"Microphone "
+#define SDCA_TERM_TYPE_STEREO_JACK_NAME			"Speaker Stereo"
+#define SDCA_TERM_TYPE_FRONT_LR_JACK_NAME		"Speaker Front-LR"
+#define SDCA_TERM_TYPE_CENTER_LFE_JACK_NAME		"Speaker Center-LFE"
+#define SDCA_TERM_TYPE_SURROUND_LR_JACK_NAME		"Speaker Surround-LR"
+#define SDCA_TERM_TYPE_REAR_LR_JACK_NAME		"Speaker Rear-LR"
+#define SDCA_TERM_TYPE_HEADPHONE_JACK_NAME		"Headphone"
+#define SDCA_TERM_TYPE_HEADSET_JACK_NAME		"Headset"
+
 /**
  * enum sdca_connector_type - SDCA Connector Types
  *
diff --git a/sound/soc/sdca/Makefile b/sound/soc/sdca/Makefile
index dddc3e6942569..53344f108ca67 100644
--- a/sound/soc/sdca/Makefile
+++ b/sound/soc/sdca/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-snd-soc-sdca-y	:= sdca_functions.o sdca_device.o sdca_regmap.o
+snd-soc-sdca-y	:= sdca_functions.o sdca_device.o sdca_regmap.o sdca_asoc.o
 
 obj-$(CONFIG_SND_SOC_SDCA)	+= snd-soc-sdca.o
diff --git a/sound/soc/sdca/sdca_asoc.c b/sound/soc/sdca/sdca_asoc.c
new file mode 100644
index 0000000000000..dab434a8daac2
--- /dev/null
+++ b/sound/soc/sdca/sdca_asoc.c
@@ -0,0 +1,799 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2025 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+/*
+ * The MIPI SDCA specification is available for public downloads at
+ * https://www.mipi.org/mipi-sdca-v1-0-download
+ */
+
+#include <linux/bitmap.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/string_helpers.h>
+#include <sound/control.h>
+#include <sound/sdca.h>
+#include <sound/sdca_asoc.h>
+#include <sound/sdca_function.h>
+#include <sound/soc.h>
+#include <sound/soc-component.h>
+#include <sound/soc-dapm.h>
+
+static struct sdca_control *selector_find_control(struct sdca_entity *entity,
+						  const int sel)
+{
+	int i;
+
+	for (i = 0; i < entity->num_controls; i++) {
+		struct sdca_control *control = &entity->controls[i];
+
+		if (control->sel == sel)
+			return control;
+	}
+
+	return NULL;
+}
+
+static struct sdca_control_range *control_find_range(struct device *dev,
+						     struct sdca_entity *entity,
+						     struct sdca_control *control,
+						     int cols, int rows)
+{
+	struct sdca_control_range *range = &control->range;
+
+	if ((cols && range->cols != cols) || (rows && range->rows != rows) ||
+	    !range->data) {
+		dev_err(dev, "%s: control %#x: ranges invalid (%d,%d)\n",
+			entity->label, control->sel, range->cols, range->rows);
+		return NULL;
+	}
+
+	return range;
+}
+
+static struct sdca_control_range *selector_find_range(struct device *dev,
+						      struct sdca_entity *entity,
+						      int sel, int cols, int rows)
+{
+	struct sdca_control *control;
+
+	control = selector_find_control(entity, sel);
+	if (!control) {
+		dev_err(dev, "%s: control %#x: missing\n", entity->label, sel);
+		return NULL;
+	}
+
+	return control_find_range(dev, entity, control, cols, rows);
+}
+
+int sdca_asoc_count_component(struct device *dev, struct sdca_function_data *function,
+			      int *num_widgets, int *num_routes)
+{
+	int i;
+
+	*num_widgets = function->num_entities - 1;
+	*num_routes = 0;
+
+	for (i = 0; i < function->num_entities - 1; i++) {
+		struct sdca_entity *entity = &function->entities[i];
+
+		switch (entity->type) {
+		case SDCA_ENTITY_TYPE_IT:
+		case SDCA_ENTITY_TYPE_OT:
+			*num_routes += !!entity->iot.clock;
+			*num_routes += !!entity->iot.is_dataport;
+			break;
+		case SDCA_ENTITY_TYPE_PDE:
+			*num_routes += entity->pde.num_managed;
+			break;
+		default:
+			break;
+		}
+
+		*num_routes += entity->num_sources;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS(sdca_asoc_count_component, "SND_SOC_SDCA");
+
+static const char *get_terminal_name(enum sdca_terminal_type type)
+{
+	switch (type) {
+	case SDCA_TERM_TYPE_LINEIN_STEREO:
+		return SDCA_TERM_TYPE_LINEIN_STEREO_NAME;
+	case SDCA_TERM_TYPE_LINEIN_FRONT_LR:
+		return SDCA_TERM_TYPE_LINEIN_FRONT_LR_NAME;
+	case SDCA_TERM_TYPE_LINEIN_CENTER_LFE:
+		return SDCA_TERM_TYPE_LINEIN_CENTER_LFE_NAME;
+	case SDCA_TERM_TYPE_LINEIN_SURROUND_LR:
+		return SDCA_TERM_TYPE_LINEIN_SURROUND_LR_NAME;
+	case SDCA_TERM_TYPE_LINEIN_REAR_LR:
+		return SDCA_TERM_TYPE_LINEIN_REAR_LR_NAME;
+	case SDCA_TERM_TYPE_LINEOUT_STEREO:
+		return SDCA_TERM_TYPE_LINEOUT_STEREO_NAME;
+	case SDCA_TERM_TYPE_LINEOUT_FRONT_LR:
+		return SDCA_TERM_TYPE_LINEOUT_FRONT_LR_NAME;
+	case SDCA_TERM_TYPE_LINEOUT_CENTER_LFE:
+		return SDCA_TERM_TYPE_LINEOUT_CENTER_LFE_NAME;
+	case SDCA_TERM_TYPE_LINEOUT_SURROUND_LR:
+		return SDCA_TERM_TYPE_LINEOUT_SURROUND_LR_NAME;
+	case SDCA_TERM_TYPE_LINEOUT_REAR_LR:
+		return SDCA_TERM_TYPE_LINEOUT_REAR_LR_NAME;
+	case SDCA_TERM_TYPE_MIC_JACK:
+		return SDCA_TERM_TYPE_MIC_JACK_NAME;
+	case SDCA_TERM_TYPE_STEREO_JACK:
+		return SDCA_TERM_TYPE_STEREO_JACK_NAME;
+	case SDCA_TERM_TYPE_FRONT_LR_JACK:
+		return SDCA_TERM_TYPE_FRONT_LR_JACK_NAME;
+	case SDCA_TERM_TYPE_CENTER_LFE_JACK:
+		return SDCA_TERM_TYPE_CENTER_LFE_JACK_NAME;
+	case SDCA_TERM_TYPE_SURROUND_LR_JACK:
+		return SDCA_TERM_TYPE_SURROUND_LR_JACK_NAME;
+	case SDCA_TERM_TYPE_REAR_LR_JACK:
+		return SDCA_TERM_TYPE_REAR_LR_JACK_NAME;
+	case SDCA_TERM_TYPE_HEADPHONE_JACK:
+		return SDCA_TERM_TYPE_HEADPHONE_JACK_NAME;
+	case SDCA_TERM_TYPE_HEADSET_JACK:
+		return SDCA_TERM_TYPE_HEADSET_JACK_NAME;
+	default:
+		return NULL;
+	}
+}
+
+static int entity_early_parse_ge(struct device *dev,
+				 struct sdca_function_data *function,
+				 struct sdca_entity *entity)
+{
+	struct sdca_control_range *range;
+	struct sdca_control *control;
+	struct snd_kcontrol_new *kctl;
+	struct soc_enum *soc_enum;
+	const char *control_name;
+	unsigned int *values;
+	const char **texts;
+	int i;
+
+	control = selector_find_control(entity, SDCA_CTL_GE_SELECTED_MODE);
+	if (!control) {
+		dev_err(dev, "%s: no selected mode control\n", entity->label);
+		return -EINVAL;
+	}
+
+	if (control->layers != SDCA_ACCESS_LAYER_CLASS)
+		dev_warn(dev, "%s: unexpected access layer: %x\n",
+			 entity->label, control->layers);
+
+	range = control_find_range(dev, entity, control, SDCA_SELECTED_MODE_NCOLS, 0);
+	if (!range)
+		return -EINVAL;
+
+	control_name = devm_kasprintf(dev, GFP_KERNEL, "%s %s",
+				      entity->label, control->label);
+	if (!control_name)
+		return -ENOMEM;
+
+	kctl = devm_kmalloc(dev, sizeof(*kctl), GFP_KERNEL);
+	if (!kctl)
+		return -ENOMEM;
+
+	soc_enum = devm_kmalloc(dev, sizeof(*soc_enum), GFP_KERNEL);
+	if (!soc_enum)
+		return -ENOMEM;
+
+	texts = devm_kcalloc(dev, range->rows + 3, sizeof(*texts), GFP_KERNEL);
+	if (!texts)
+		return -ENOMEM;
+
+	values = devm_kcalloc(dev, range->rows + 3, sizeof(*values), GFP_KERNEL);
+	if (!values)
+		return -ENOMEM;
+
+	texts[0] = "No Jack";
+	texts[1] = "Jack Unknown";
+	texts[2] = "Detection in Progress";
+	values[0] = 0;
+	values[1] = 1;
+	values[2] = 2;
+	for (i = 0; i < range->rows; i++) {
+		enum sdca_terminal_type type;
+
+		type = sdca_range(range, SDCA_SELECTED_MODE_TERM_TYPE, i);
+
+		values[i + 3] = sdca_range(range, SDCA_SELECTED_MODE_INDEX, i);
+		texts[i + 3] = get_terminal_name(type);
+		if (!texts[i + 3]) {
+			dev_err(dev, "%s: Unrecognised terminal type: %#x\n",
+				entity->label, type);
+			return -EINVAL;
+		}
+	}
+
+	soc_enum->reg = SDW_SDCA_CTL(function->desc->adr, entity->id, control->sel, 0);
+	soc_enum->items = range->rows + 3;
+	soc_enum->mask = roundup_pow_of_two(soc_enum->items) - 1;
+	soc_enum->texts = texts;
+
+	kctl->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	kctl->name = control_name;
+	kctl->info = snd_soc_info_enum_double;
+	kctl->get = snd_soc_dapm_get_enum_double;
+	kctl->put = snd_soc_dapm_put_enum_double;
+	kctl->private_value = (unsigned long)soc_enum;
+
+	entity->ge.kctl = kctl;
+
+	return 0;
+}
+
+static void add_route(struct snd_soc_dapm_route **route, const char *sink,
+		      const char *control, const char *source)
+{
+	(*route)->sink = sink;
+	(*route)->control = control;
+	(*route)->source = source;
+	(*route)++;
+}
+
+static int entity_parse_simple(struct device *dev,
+			       struct sdca_function_data *function,
+			       struct sdca_entity *entity,
+			       struct snd_soc_dapm_widget **widget,
+			       struct snd_soc_dapm_route **route,
+			       enum snd_soc_dapm_type id)
+{
+	int i;
+
+	(*widget)->id = id;
+	(*widget)++;
+
+	for (i = 0; i < entity->num_sources; i++)
+		add_route(route, entity->label, NULL, entity->sources[i]->label);
+
+	return 0;
+}
+
+static int entity_parse_it(struct device *dev,
+			   struct sdca_function_data *function,
+			   struct sdca_entity *entity,
+			   struct snd_soc_dapm_widget **widget,
+			   struct snd_soc_dapm_route **route)
+{
+	int i;
+
+	if (entity->iot.is_dataport) {
+		const char *aif_name = devm_kasprintf(dev, GFP_KERNEL, "%s %s",
+						      entity->label, "Playback");
+		if (!aif_name)
+			return -ENOMEM;
+
+		(*widget)->id = snd_soc_dapm_aif_in;
+
+		add_route(route, entity->label, NULL, aif_name);
+	} else {
+		(*widget)->id = snd_soc_dapm_input;
+	}
+
+	if (entity->iot.clock)
+		add_route(route, entity->label, NULL, entity->iot.clock->label);
+
+	for (i = 0; i < entity->num_sources; i++)
+		add_route(route, entity->label, NULL, entity->sources[i]->label);
+
+	(*widget)++;
+
+	return 0;
+}
+
+static int entity_parse_ot(struct device *dev,
+			   struct sdca_function_data *function,
+			   struct sdca_entity *entity,
+			   struct snd_soc_dapm_widget **widget,
+			   struct snd_soc_dapm_route **route)
+{
+	int i;
+
+	if (entity->iot.is_dataport) {
+		const char *aif_name = devm_kasprintf(dev, GFP_KERNEL, "%s %s",
+						      entity->label, "Capture");
+		if (!aif_name)
+			return -ENOMEM;
+
+		(*widget)->id = snd_soc_dapm_aif_out;
+
+		add_route(route, aif_name, NULL, entity->label);
+	} else {
+		(*widget)->id = snd_soc_dapm_output;
+	}
+
+	if (entity->iot.clock)
+		add_route(route, entity->label, NULL, entity->iot.clock->label);
+
+	for (i = 0; i < entity->num_sources; i++)
+		add_route(route, entity->label, NULL, entity->sources[i]->label);
+
+	(*widget)++;
+
+	return 0;
+}
+
+static int entity_pde_event(struct snd_soc_dapm_widget *widget,
+			    struct snd_kcontrol *kctl, int event)
+{
+	struct snd_soc_component *component = widget->dapm->component;
+	struct sdca_entity *entity = widget->priv;
+	static const int poll_us = 10000;
+	int polls = 1;
+	unsigned int reg, val;
+	int from, to, i;
+	int ret;
+
+	if (!component)
+		return -EIO;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMD:
+		from = widget->on_val;
+		to = widget->off_val;
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		from = widget->off_val;
+		to = widget->on_val;
+		break;
+	}
+
+	for (i = 0; i < entity->pde.num_max_delay; i++) {
+		struct sdca_pde_delay *delay = &entity->pde.max_delay[i];
+
+		if (delay->from_ps == from && delay->to_ps == to) {
+			polls = max(polls, delay->us / poll_us);
+			break;
+		}
+	}
+
+	reg = SDW_SDCA_CTL(SDW_SDCA_CTL_FUNC(widget->reg),
+			   SDW_SDCA_CTL_ENT(widget->reg),
+			   SDCA_CTL_PDE_ACTUAL_PS, 0);
+
+	for (i = 0; i < polls; i++) {
+		if (i)
+			fsleep(poll_us);
+
+		ret = regmap_read(component->regmap, reg, &val);
+		if (ret)
+			return ret;
+		else if (val == to)
+			return 0;
+	}
+
+	dev_err(component->dev, "%s: power transition failed: %x\n",
+		entity->label, val);
+	return -ETIMEDOUT;
+}
+
+static int entity_parse_pde(struct device *dev,
+			    struct sdca_function_data *function,
+			    struct sdca_entity *entity,
+			    struct snd_soc_dapm_widget **widget,
+			    struct snd_soc_dapm_route **route)
+{
+	unsigned int target = (1 << SDCA_PDE_PS0) | (1 << SDCA_PDE_PS3);
+	struct sdca_control_range *range;
+	struct sdca_control *control;
+	unsigned int mask = 0;
+	int i;
+
+	control = selector_find_control(entity, SDCA_CTL_PDE_REQUESTED_PS);
+	if (!control) {
+		dev_err(dev, "%s: no power control\n", entity->label);
+		return -EINVAL;
+	}
+
+	/* Power should only be controlled by the driver */
+	if (control->layers != SDCA_ACCESS_LAYER_CLASS)
+		dev_warn(dev, "%s: unexpected access layer: %x\n",
+			 entity->label, control->layers);
+
+	range = control_find_range(dev, entity, control, SDCA_REQUESTED_PS_NCOLS, 0);
+	if (!range)
+		return -EINVAL;
+
+	for (i = 0; i < range->rows; i++)
+		mask |= 1 << sdca_range(range, SDCA_REQUESTED_PS_STATE, i);
+
+	if ((mask & target) != target) {
+		dev_err(dev, "%s: power control missing states\n", entity->label);
+		return -EINVAL;
+	}
+
+	(*widget)->id = snd_soc_dapm_supply;
+	(*widget)->reg = SDW_SDCA_CTL(function->desc->adr, entity->id, control->sel, 0);
+	(*widget)->mask = GENMASK(control->nbits - 1, 0);
+	(*widget)->on_val = SDCA_PDE_PS0;
+	(*widget)->off_val = SDCA_PDE_PS3;
+	(*widget)->event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD;
+	(*widget)->event = entity_pde_event;
+	(*widget)->priv = entity;
+	(*widget)++;
+
+	for (i = 0; i < entity->pde.num_managed; i++)
+		add_route(route, entity->pde.managed[i]->label, NULL, entity->label);
+
+	for (i = 0; i < entity->num_sources; i++)
+		add_route(route, entity->label, NULL, entity->sources[i]->label);
+
+	return 0;
+}
+
+/* Device selector units are controlled through a group entity */
+static int entity_parse_su_device(struct device *dev,
+				  struct sdca_function_data *function,
+				  struct sdca_entity *entity,
+				  struct snd_soc_dapm_widget **widget,
+				  struct snd_soc_dapm_route **route)
+{
+	struct sdca_control_range *range;
+	int num_routes = 0;
+	int i, j;
+
+	if (!entity->group) {
+		dev_err(dev, "%s: device selector unit missing group\n", entity->label);
+		return -EINVAL;
+	}
+
+	range = selector_find_range(dev, entity->group, SDCA_CTL_GE_SELECTED_MODE,
+				    SDCA_SELECTED_MODE_NCOLS, 0);
+	if (!range)
+		return -EINVAL;
+
+	(*widget)->id = snd_soc_dapm_mux;
+	(*widget)->kcontrol_news = entity->group->ge.kctl;
+	(*widget)->num_kcontrols = 1;
+	(*widget)++;
+
+	for (i = 0; i < entity->group->ge.num_modes; i++) {
+		struct sdca_ge_mode *mode = &entity->group->ge.modes[i];
+
+		for (j = 0; j < mode->num_controls; j++) {
+			struct sdca_ge_control *affected = &mode->controls[j];
+			int term;
+
+			if (affected->id != entity->id ||
+			    affected->sel != SDCA_CTL_SU_SELECTOR ||
+			    !affected->val)
+				continue;
+
+			if (affected->val - 1 >= entity->num_sources) {
+				dev_err(dev, "%s: Bad control value: %#x\n",
+					entity->label, affected->val);
+				return -EINVAL;
+			}
+
+			if (++num_routes > entity->num_sources) {
+				dev_err(dev, "%s: Too many input routes\n", entity->label);
+				return -EINVAL;
+			}
+
+			term = sdca_range_search(range, SDCA_SELECTED_MODE_INDEX,
+						 mode->val, SDCA_SELECTED_MODE_TERM_TYPE);
+			if (!term) {
+				dev_err(dev, "%s: Mode not found: %#x\n",
+					entity->label, mode->val);
+				return -EINVAL;
+			}
+
+			add_route(route, entity->label, get_terminal_name(term),
+				  entity->sources[affected->val - 1]->label);
+		}
+	}
+
+	return 0;
+}
+
+/* Class selector units will be exported as an ALSA control */
+static int entity_parse_su_class(struct device *dev,
+				 struct sdca_function_data *function,
+				 struct sdca_entity *entity,
+				 struct sdca_control *control,
+				 struct snd_soc_dapm_widget **widget,
+				 struct snd_soc_dapm_route **route)
+{
+	struct snd_kcontrol_new *kctl;
+	struct soc_enum *soc_enum;
+	const char **texts;
+	int i;
+
+	kctl = devm_kmalloc(dev, sizeof(*kctl), GFP_KERNEL);
+	if (!kctl)
+		return -ENOMEM;
+
+	soc_enum = devm_kmalloc(dev, sizeof(*soc_enum), GFP_KERNEL);
+	if (!soc_enum)
+		return -ENOMEM;
+
+	texts = devm_kcalloc(dev, entity->num_sources + 1, sizeof(*texts), GFP_KERNEL);
+	if (!texts)
+		return -ENOMEM;
+
+	texts[0] = "No Signal";
+	for (i = 0; i < entity->num_sources; i++)
+		texts[i + 1] = entity->sources[i]->label;
+
+	soc_enum->reg = SDW_SDCA_CTL(function->desc->adr, entity->id, control->sel, 0);
+	soc_enum->items = entity->num_sources + 1;
+	soc_enum->mask = roundup_pow_of_two(soc_enum->items) - 1;
+	soc_enum->texts = texts;
+
+	kctl->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	kctl->name = "Route";
+	kctl->info = snd_soc_info_enum_double;
+	kctl->get = snd_soc_dapm_get_enum_double;
+	kctl->put = snd_soc_dapm_put_enum_double;
+	kctl->private_value = (unsigned long)soc_enum;
+
+	(*widget)->id = snd_soc_dapm_mux;
+	(*widget)->kcontrol_news = kctl;
+	(*widget)->num_kcontrols = 1;
+	(*widget)++;
+
+	for (i = 0; i < entity->num_sources; i++)
+		add_route(route, entity->label, texts[i + 1], entity->sources[i]->label);
+
+	return 0;
+}
+
+static int entity_parse_su(struct device *dev,
+			   struct sdca_function_data *function,
+			   struct sdca_entity *entity,
+			   struct snd_soc_dapm_widget **widget,
+			   struct snd_soc_dapm_route **route)
+{
+	struct sdca_control *control;
+
+	if (!entity->num_sources) {
+		dev_err(dev, "%s: selector with no inputs\n", entity->label);
+		return -EINVAL;
+	}
+
+	control = selector_find_control(entity, SDCA_CTL_SU_SELECTOR);
+	if (!control) {
+		dev_err(dev, "%s: no selector control\n", entity->label);
+		return -EINVAL;
+	}
+
+	if (control->layers == SDCA_ACCESS_LAYER_DEVICE)
+		return entity_parse_su_device(dev, function, entity, widget, route);
+
+	if (control->layers != SDCA_ACCESS_LAYER_CLASS)
+		dev_warn(dev, "%s: unexpected access layer: %x\n",
+			 entity->label, control->layers);
+
+	return entity_parse_su_class(dev, function, entity, control, widget, route);
+}
+
+static int entity_parse_mu(struct device *dev,
+			   struct sdca_function_data *function,
+			   struct sdca_entity *entity,
+			   struct snd_soc_dapm_widget **widget,
+			   struct snd_soc_dapm_route **route)
+{
+	struct sdca_control *control;
+	struct snd_kcontrol_new *kctl;
+	int cn;
+	int i;
+
+	if (!entity->num_sources) {
+		dev_err(dev, "%s: selector 1 or more inputs\n", entity->label);
+		return -EINVAL;
+	}
+
+	control = selector_find_control(entity, SDCA_CTL_MU_MIXER);
+	if (!control) {
+		dev_err(dev, "%s: no mixer controls\n", entity->label);
+		return -EINVAL;
+	}
+
+	/* MU control should be through DAPM */
+	if (control->layers != SDCA_ACCESS_LAYER_CLASS)
+		dev_warn(dev, "%s: unexpected access layer: %x\n",
+			 entity->label, control->layers);
+
+	if (entity->num_sources != hweight64(control->cn_list)) {
+		dev_err(dev, "%s: mismatched control and sources\n", entity->label);
+		return -EINVAL;
+	}
+
+	kctl = devm_kcalloc(dev, entity->num_sources, sizeof(*kctl), GFP_KERNEL);
+	if (!kctl)
+		return -ENOMEM;
+
+	i = 0;
+	for_each_set_bit(cn, (unsigned long *)&control->cn_list,
+			 BITS_PER_TYPE(control->cn_list)) {
+		const char *control_name;
+		struct soc_mixer_control *mc;
+
+		control_name = devm_kasprintf(dev, GFP_KERNEL, "%s %d",
+					      control->label, i + 1);
+		if (!control_name)
+			return -ENOMEM;
+
+		mc = devm_kmalloc(dev, sizeof(*mc), GFP_KERNEL);
+		if (!mc)
+			return -ENOMEM;
+
+		mc->reg = SND_SOC_NOPM;
+		mc->rreg = SND_SOC_NOPM;
+		mc->invert = 1; // Ensure default is connected
+		mc->min = 0;
+		mc->max = 1;
+
+		kctl[i].name = control_name;
+		kctl[i].private_value = (unsigned long)mc;
+		kctl[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+		kctl[i].info = snd_soc_info_volsw;
+		kctl[i].get = snd_soc_dapm_get_volsw;
+		kctl[i].put = snd_soc_dapm_put_volsw;
+		i++;
+	}
+
+	(*widget)->id = snd_soc_dapm_mixer;
+	(*widget)->kcontrol_news = kctl;
+	(*widget)->num_kcontrols = entity->num_sources;
+	(*widget)++;
+
+	for (i = 0; i < entity->num_sources; i++)
+		add_route(route, entity->label, kctl[i].name, entity->sources[i]->label);
+
+	return 0;
+}
+
+static int entity_cs_event(struct snd_soc_dapm_widget *widget,
+			   struct snd_kcontrol *kctl, int event)
+{
+	struct snd_soc_component *component = widget->dapm->component;
+	struct sdca_entity *entity = widget->priv;
+
+	if (!component)
+		return -EIO;
+
+	if (entity->cs.max_delay)
+		fsleep(entity->cs.max_delay);
+
+	return 0;
+}
+
+static int entity_parse_cs(struct device *dev,
+			   struct sdca_function_data *function,
+			   struct sdca_entity *entity,
+			   struct snd_soc_dapm_widget **widget,
+			   struct snd_soc_dapm_route **route)
+{
+	int i;
+
+	(*widget)->id = snd_soc_dapm_supply;
+	(*widget)->subseq = 1; /* Ensure these run after PDEs */
+	(*widget)->event_flags = SND_SOC_DAPM_POST_PMU;
+	(*widget)->event = entity_cs_event;
+	(*widget)->priv = entity;
+	(*widget)++;
+
+	for (i = 0; i < entity->num_sources; i++)
+		add_route(route, entity->label, NULL, entity->sources[i]->label);
+
+	return 0;
+}
+
+int sdca_asoc_populate_dapm(struct device *dev, struct sdca_function_data *function,
+			    struct snd_soc_dapm_widget *widget,
+			    struct snd_soc_dapm_route *route)
+{
+	int ret;
+	int i;
+
+	/* Some entities need to add controls referenced by other entities */
+	for (i = 0; i < function->num_entities - 1; i++) {
+		struct sdca_entity *entity = &function->entities[i];
+
+		switch (entity->type) {
+		case SDCA_ENTITY_TYPE_GE:
+			ret = entity_early_parse_ge(dev, function, entity);
+			if (ret)
+				return ret;
+			break;
+		default:
+			break;
+		}
+	}
+
+	for (i = 0; i < function->num_entities - 1; i++) {
+		struct sdca_entity *entity = &function->entities[i];
+
+		widget->name = entity->label;
+		widget->reg = SND_SOC_NOPM;
+
+		switch (entity->type) {
+		case SDCA_ENTITY_TYPE_IT:
+			ret = entity_parse_it(dev, function, entity, &widget, &route);
+			break;
+		case SDCA_ENTITY_TYPE_OT:
+			ret = entity_parse_ot(dev, function, entity, &widget, &route);
+			break;
+		case SDCA_ENTITY_TYPE_PDE:
+			ret = entity_parse_pde(dev, function, entity, &widget, &route);
+			break;
+		case SDCA_ENTITY_TYPE_SU:
+			ret = entity_parse_su(dev, function, entity, &widget, &route);
+			break;
+		case SDCA_ENTITY_TYPE_MU:
+			ret = entity_parse_mu(dev, function, entity, &widget, &route);
+			break;
+		case SDCA_ENTITY_TYPE_CS:
+			ret = entity_parse_cs(dev, function, entity, &widget, &route);
+			break;
+		case SDCA_ENTITY_TYPE_CX:
+			/*
+			 * FIXME: For now we will just treat these as a supply,
+			 * meaning all options are enabled.
+			 */
+			dev_warn(dev, "%s: Clock Selectors not fully supported yet\n",
+				 entity->label);
+			ret = entity_parse_simple(dev, function, entity, &widget,
+						  &route, snd_soc_dapm_supply);
+			break;
+		case SDCA_ENTITY_TYPE_TG:
+			ret = entity_parse_simple(dev, function, entity, &widget,
+						  &route, snd_soc_dapm_siggen);
+			break;
+		default:
+			ret = entity_parse_simple(dev, function, entity, &widget,
+						  &route, snd_soc_dapm_pga);
+			break;
+		}
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS(sdca_asoc_populate_dapm, "SND_SOC_SDCA");
+
+int sdca_asoc_populate_component(struct device *dev,
+				 struct sdca_function_data *function,
+				 struct snd_soc_component_driver *component_drv)
+{
+	struct snd_soc_dapm_widget *widgets;
+	struct snd_soc_dapm_route *routes;
+	int num_widgets, num_routes;
+	int ret;
+
+	ret = sdca_asoc_count_component(dev, function, &num_widgets, &num_routes);
+	if (ret)
+		return ret;
+
+	widgets = devm_kcalloc(dev, num_widgets, sizeof(*widgets), GFP_KERNEL);
+	if (!widgets)
+		return -ENOMEM;
+
+	routes = devm_kcalloc(dev, num_routes, sizeof(*routes), GFP_KERNEL);
+	if (!routes)
+		return -ENOMEM;
+
+	ret = sdca_asoc_populate_dapm(dev, function, widgets, routes);
+	if (ret)
+		return ret;
+
+	component_drv->dapm_widgets = widgets;
+	component_drv->num_dapm_widgets = num_widgets;
+	component_drv->dapm_routes = routes;
+	component_drv->num_dapm_routes = num_routes;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS(sdca_asoc_populate_component, "SND_SOC_SDCA");
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SDCA library");
-- 
2.39.5


