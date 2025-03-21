Return-Path: <linux-kernel+bounces-571654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6122DA6C03F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC1E1B61AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5270022D7A1;
	Fri, 21 Mar 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ak7lojVr";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="DcnQKaNN"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23393155A25;
	Fri, 21 Mar 2025 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575201; cv=fail; b=VFtzm5sos6pXRirBnaMkca3oUFqCPS/7jkeFQoU1fBfJysD9M+v2ov3T12s6GMNH81VLRqPHkZ6d1sNWUrdNcHdAStfChHDj9RdY3ckhoQAKCDwI1krNEhkcjuL4wjFZUeTbPz0XgCy3tWuHyKcGh2v9Xdc2oL3gfityGuxbODc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575201; c=relaxed/simple;
	bh=kTtnj5vPyQf1EaKg4K4mBY6cmbN1QO3ntw9+fMLguBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3E9dul4fsET+90mjwrRmqHodkyEscuJRw6JvfXPHcXCIhsDuF57qyNC2p9r5I0SZJ+nOZhTNYHCRTfiDR38aj/VEzlpc8P+sb32jOHrYIfn89pblPHeX66PT+Ndr2pJk/HrzEJibCi/ddSnJTj8M+9ZS57aPXfq8uAcdlHKyB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ak7lojVr; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=DcnQKaNN; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L5KkjH026985;
	Fri, 21 Mar 2025 11:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=vjoclKEm5S24mIZoyUynMutELDAnmPjkKAogAfxqbF4=; b=
	ak7lojVrQN7WeTQcNMV5QxRm4Opg5CHvhTObWyYT24+7d/2Ap0wFcffSUjwaLj5k
	srbHusCUXIrz+zCsNGhDVhYTnqb2gpu3Ot0K0JM3y3UisvxXkBJj6XeufJHgRo37
	UY0m6OXpoNvKtS/e74ZLY5iL7DBY/kJoUe/j2x4p2cYO2S7MVl+uoCDIiq1iEAB1
	S2dvVSrYs7J3yxlvnUWixTehy6mtErHlGy8+IGe8djbSQeR5Acpyqj8mq/akF1gx
	CMveGxhDDPuEzkiH85Dt9GKlYJs4oG5BZBUsARkmSW8N0ygujEe8qdzAudRaiCjG
	3SFXtWgBQiHB9yTQ0Eifrw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45g9p6v7hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 11:39:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvJ21uxzQ0hhCFIQXrVEirc99hxb4laJOCT1wQM4Wif2A2iGqvKsj6vZlj4wy4sa4LwNrvCKBHlyTWXLmuEFrNiN3M6NCGIFR1IkYjMdLxUWAnTustlKHqXcGa79vsot8otMxR4Z53milLhC9WE16IljB9PrLhlfPrcvnZ4ubSqglGpPruCjy07DqcI+5ibel0EIzQVi87J1Lzuw959X0J5ZkVVxmjMwQfACqo9xR8vR7bFa307jcBg8Mt6Se4mgI44vCtjwlrUJxtbyinb//lRyhrFfkXWJ1s2GFUDoMnC2zJMJPrOOhMTlI5hWvGse3qW8UtWH3SK2fLpvgESnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjoclKEm5S24mIZoyUynMutELDAnmPjkKAogAfxqbF4=;
 b=dPTZLQzIPxdswcUmFbrGQwv5PSSktgvGH6HoW/JnXHwiwSpqO3ISd0RABLQgXzM1QHPBveJDHH8eU5BNW/APtvYFI5QXyY46WpL49ax0ybQlAKngylYZBo4Mh2dmzL5o2EAAiYRrS+r9AjWv3rYNhKh4D0+8m5cNAkksLQYIkFxdIGZOrha9iL2tFfZdkIrW0UxLJY8irIEfCdtmfY/g4HfxHlRE16pFcZ9Si+sdjRCozTCTYLF3Z4pWnLYu8lAsduWfYWQg53JwGRhThO5R3G2QhTA7mSVM+R5KTeiQ5xvz2f322NmbMCFWCcfz3wWcPnM9iRiUzPZvlmIsIpI6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjoclKEm5S24mIZoyUynMutELDAnmPjkKAogAfxqbF4=;
 b=DcnQKaNNbFjdj/i9twgX4vTSAUyzgtmVc2jw98f1vr718hezQexJYqHwNhXHj9/dY4Fh4QCADqUZpuCxH2N1+UFbLz974/4BbUfMU+fVNhJl66v11V9WcuRloPh8+xiBzvZF/n5BiPdXWBCfNatNIBBUBhe2DabjMWj8/Q4787I=
Received: from BN0PR04CA0134.namprd04.prod.outlook.com (2603:10b6:408:ed::19)
 by SJ0PR19MB4810.namprd19.prod.outlook.com (2603:10b6:a03:2ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 16:39:31 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::b3) by BN0PR04CA0134.outlook.office365.com
 (2603:10b6:408:ed::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Fri,
 21 Mar 2025 16:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Fri, 21 Mar 2025 16:39:30 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id EE26440654D;
	Fri, 21 Mar 2025 16:39:28 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C883382255E;
	Fri, 21 Mar 2025 16:39:28 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, pierre-louis.bossart@linux.dev,
        yung-chuan.liao@linux.intel.com, peter.ujfalusi@linux.intel.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 3/3] ASoC: SDCA: Create DAI drivers from DisCo
Date: Fri, 21 Mar 2025 16:39:28 +0000
Message-Id: <20250321163928.793301-4-ckeepax@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|SJ0PR19MB4810:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 43acb2ac-d2b2-422f-b50d-08dd6896f40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EO/JOcPV9gS6iPeyL5Og8SHxv1U9DsFrS6/zV2aYKFKAYV/lZ5ivRkAx/KJv?=
 =?us-ascii?Q?QB+R7xIN3EPNRyWGHp5HQ06HZ4DeGsQAdT6RsELfaofMikZXPM7W/D2l72B1?=
 =?us-ascii?Q?M5ynM3508zYuavp9RNN3zcWILiL7tarwgqNM0efcQqlh4Uxb4zCtfIrO8PFj?=
 =?us-ascii?Q?nrSbG9fE/ATIgmWmjgvM3Epe+xkhYzix8PfaWX0dyFByHocHpeW7Pa/nw7mA?=
 =?us-ascii?Q?FDgnpxzZjS8pSTopKI5f3AkhTQRpwE9tkbyz0Py39W5EAsxMYqbYumsKDXSt?=
 =?us-ascii?Q?9xO53XcenbmJWGud3/tjiF2iDFI9AK9ZszhhuAp/QaYgTEaES/avpic+gzcG?=
 =?us-ascii?Q?Q25cWPRnIBmI/LhiLmTn0ZzbL0KLWLrw8DDmygD0GeEQ1m6ZMS9zOQ4gjK4W?=
 =?us-ascii?Q?kWVvF+6PT2HqECeTmW380rtoOEeqHU0xbZntU0o8udZd4cztkPZ3wHtxjPeX?=
 =?us-ascii?Q?MYodNjF9nrjHk2Ta34r91LE0bfKa+999P2qT9i7Kst8ebm3eGuUjsZ5HtEA2?=
 =?us-ascii?Q?oRE38rxY8sBSD7lhnGCn0LziQ1pVVZgAZg+cFfkZ2SL8rmgpBR12U1qT6ep+?=
 =?us-ascii?Q?JYz8AFEJT9/YrDYjCXP0UHt+p/wY9mYqREwWGseuWFnhInVt4DREjPjDifjz?=
 =?us-ascii?Q?VRSvuHAE+TTz+B57tJkIFf5lI7bafIIjJFhNBnWmiDbnp9c0BqUdVDWyB0LN?=
 =?us-ascii?Q?30l7a0k0iBV+HGwrJggi62QreRtFDplGw30dRf9KF+0JGukS6BUD0J03VKHz?=
 =?us-ascii?Q?XdSp/XsLd6LREj4gf2HU8xbqL6XkGkQPwr2FIt5CLuWU1EKNijS8ep5J/ReY?=
 =?us-ascii?Q?6HsAuUbIoxKYPkclv0UBwq++MHRnCC4ekzs2khF0w94J9qQieMmV7GG8buMz?=
 =?us-ascii?Q?WhE+OabsIZ56yFSoViysfIo54JEphob7BBgKEfFMxcRAwU7xUC5QbQbP8XoL?=
 =?us-ascii?Q?0jPs1Fq2i6pw/tncEycd8QGe4/wmRONnFq0UwS8oeSGqzPRsFnIZ3iUFaGJ8?=
 =?us-ascii?Q?LP2ZuE2WjBgUy7C93b9tNgpo7SjiM3oJsSNYYNPyU5jGt8aW3CPFLpRt8zt0?=
 =?us-ascii?Q?cYMyb+b2fGOzQ5KzgeS5rkv9LGJNxfuh23fjM4HzT9N6PHJmv+fR6IMTAiW0?=
 =?us-ascii?Q?R41YJXvXLo7fihANgckXjDreRE+CPS5IUcEIS9u8UB5HC0kUCRwSS+SxDzlB?=
 =?us-ascii?Q?76ZOplHxWr1xuhHNdLKUwOsDyWMpUoXCNHPhekG0gK7lfw7/wMYMAb/9ke+C?=
 =?us-ascii?Q?19kyVFsM1C7+3oU1szAmDQcFMhlZYfF//pkIAOqjf4XPw27jDLajrOT4dtbh?=
 =?us-ascii?Q?y6Di9WvF8NYj7KKJJOi33pnw8uWGRRbR/MZ0Xho54QAm78pHN0o7j0gzYVxF?=
 =?us-ascii?Q?5gS26y7Rarepdq/r8C+Fa/af15vgnll4oQ+NQyzvg7eC7T+OQJ22Iyk3s6j5?=
 =?us-ascii?Q?C6aiO0NadcYelobXlef7/ohScr9VGkUCd2gCpU6Aae0KDMTUaCQs9d8HJEVP?=
 =?us-ascii?Q?A4okGry8E6fABP8=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 16:39:30.3369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43acb2ac-d2b2-422f-b50d-08dd6896f40d
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4810
X-Authority-Analysis: v=2.4 cv=Vcz3PEp9 c=1 sm=1 tr=0 ts=67dd964a cx=c_pps a=LxkDbUgDkQmSfly3BTNqMw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=mtmGHodxziJHnfEkOdcA:9 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-GUID: vuosxof-ybqcyKHF1lcJtYFpsH9LLaMR
X-Proofpoint-ORIG-GUID: vuosxof-ybqcyKHF1lcJtYFpsH9LLaMR
X-Proofpoint-Spam-Reason: safe

Use the previously parsed DisCo information from ACPI to create the DAI
drivers required to connect an SDCA Function into an ASoC soundcard.

Create DAI driver structures and populate the supported sample rates
and sample widths into them based on the Input/Output Terminal and any
attach Clock Source entities. More complex relationships with channels
etc. will be added later as constraints as part of the DAI startup.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/sdca_asoc.h     |  12 +-
 include/sound/sdca_function.h |  23 ++++
 sound/soc/sdca/sdca_asoc.c    | 209 +++++++++++++++++++++++++++++++++-
 3 files changed, 238 insertions(+), 6 deletions(-)

diff --git a/include/sound/sdca_asoc.h b/include/sound/sdca_asoc.h
index d19e7e969283a..9121531f08260 100644
--- a/include/sound/sdca_asoc.h
+++ b/include/sound/sdca_asoc.h
@@ -14,11 +14,14 @@ struct device;
 struct sdca_function_data;
 struct snd_kcontrol_new;
 struct snd_soc_component_driver;
+struct snd_soc_dai_driver;
+struct snd_soc_dai_ops;
 struct snd_soc_dapm_route;
 struct snd_soc_dapm_widget;
 
 int sdca_asoc_count_component(struct device *dev, struct sdca_function_data *function,
-			      int *num_widgets, int *num_routes, int *num_controls);
+			      int *num_widgets, int *num_routes, int *num_controls,
+			      int *num_dais);
 
 int sdca_asoc_populate_dapm(struct device *dev, struct sdca_function_data *function,
 			    struct snd_soc_dapm_widget *widgets,
@@ -26,9 +29,14 @@ int sdca_asoc_populate_dapm(struct device *dev, struct sdca_function_data *funct
 int sdca_asoc_populate_controls(struct device *dev,
 				struct sdca_function_data *function,
 				struct snd_kcontrol_new *kctl);
+int sdca_asoc_populate_dais(struct device *dev, struct sdca_function_data *function,
+			    struct snd_soc_dai_driver *dais,
+			    const struct snd_soc_dai_ops *ops);
 
 int sdca_asoc_populate_component(struct device *dev,
 				 struct sdca_function_data *function,
-				 struct snd_soc_component_driver *component_drv);
+				 struct snd_soc_component_driver *component_drv,
+				 struct snd_soc_dai_driver **dai_drv, int *num_dai_drv,
+				 const struct snd_soc_dai_ops *ops);
 
 #endif // __SDCA_ASOC_H__
diff --git a/include/sound/sdca_function.h b/include/sound/sdca_function.h
index 358caacc28764..c995cf51a9f21 100644
--- a/include/sound/sdca_function.h
+++ b/include/sound/sdca_function.h
@@ -168,6 +168,20 @@ enum sdca_ot_controls {
 	SDCA_CTL_OT_NDAI_PACKETTYPE			= 0x17,
 };
 
+/**
+ * enum sdca_usage_range - Column definitions for Usage
+ */
+enum sdca_usage_range {
+	SDCA_USAGE_NUMBER				= 0,
+	SDCA_USAGE_CBN					= 1,
+	SDCA_USAGE_SAMPLE_RATE				= 2,
+	SDCA_USAGE_SAMPLE_WIDTH				= 3,
+	SDCA_USAGE_FULL_SCALE				= 4,
+	SDCA_USAGE_NOISE_FLOOR				= 5,
+	SDCA_USAGE_TAG					= 6,
+	SDCA_USAGE_NCOLS				= 7,
+};
+
 /**
  * enum sdca_mu_controls - SDCA Controls for Mixer Unit
  *
@@ -246,6 +260,15 @@ enum sdca_cs_controls {
 	SDCA_CTL_CS_SAMPLERATEINDEX			= 0x10,
 };
 
+/**
+ * enum sdca_samplerateindex_range - Column definitions for SampleRateIndex
+ */
+enum sdca_samplerateindex_range {
+	SDCA_SAMPLERATEINDEX_INDEX			= 0,
+	SDCA_SAMPLERATEINDEX_RATE			= 1,
+	SDCA_SAMPLERATEINDEX_NCOLS			= 2,
+};
+
 /**
  * enum sdca_cx_controls - SDCA Controls for Clock Selector
  *
diff --git a/sound/soc/sdca/sdca_asoc.c b/sound/soc/sdca/sdca_asoc.c
index aced9cc27a520..67a182a7616ef 100644
--- a/sound/soc/sdca/sdca_asoc.c
+++ b/sound/soc/sdca/sdca_asoc.c
@@ -81,13 +81,15 @@ static bool exported_control(struct sdca_control *control)
 }
 
 int sdca_asoc_count_component(struct device *dev, struct sdca_function_data *function,
-			      int *num_widgets, int *num_routes, int *num_controls)
+			      int *num_widgets, int *num_routes, int *num_controls,
+			      int *num_dais)
 {
 	int i, j;
 
 	*num_widgets = function->num_entities - 1;
 	*num_routes = 0;
 	*num_controls = 0;
+	*num_dais = 0;
 
 	for (i = 0; i < function->num_entities - 1; i++) {
 		struct sdca_entity *entity = &function->entities[i];
@@ -97,6 +99,7 @@ int sdca_asoc_count_component(struct device *dev, struct sdca_function_data *fun
 		case SDCA_ENTITY_TYPE_OT:
 			*num_routes += !!entity->iot.clock;
 			*num_routes += !!entity->iot.is_dataport;
+			*num_dais += !!entity->iot.is_dataport;
 			break;
 		case SDCA_ENTITY_TYPE_PDE:
 			*num_routes += entity->pde.num_managed;
@@ -932,18 +935,205 @@ int sdca_asoc_populate_controls(struct device *dev,
 }
 EXPORT_SYMBOL_NS(sdca_asoc_populate_controls, "SND_SOC_SDCA");
 
+static unsigned int rate_find_mask(unsigned int rate)
+{
+	switch (rate) {
+	case 0:
+		return SNDRV_PCM_RATE_8000_768000;
+	case 5512:
+		return SNDRV_PCM_RATE_5512;
+	case 8000:
+		return SNDRV_PCM_RATE_8000;
+	case 11025:
+		return SNDRV_PCM_RATE_11025;
+	case 16000:
+		return SNDRV_PCM_RATE_16000;
+	case 22050:
+		return SNDRV_PCM_RATE_22050;
+	case 32000:
+		return SNDRV_PCM_RATE_32000;
+	case 44100:
+		return SNDRV_PCM_RATE_44100;
+	case 48000:
+		return SNDRV_PCM_RATE_48000;
+	case 64000:
+		return SNDRV_PCM_RATE_64000;
+	case 88200:
+		return SNDRV_PCM_RATE_88200;
+	case 96000:
+		return SNDRV_PCM_RATE_96000;
+	case 176400:
+		return SNDRV_PCM_RATE_176400;
+	case 192000:
+		return SNDRV_PCM_RATE_192000;
+	case 352800:
+		return SNDRV_PCM_RATE_352800;
+	case 384000:
+		return SNDRV_PCM_RATE_384000;
+	case 705600:
+		return SNDRV_PCM_RATE_705600;
+	case 768000:
+		return SNDRV_PCM_RATE_768000;
+	case 12000:
+		return SNDRV_PCM_RATE_12000;
+	case 24000:
+		return SNDRV_PCM_RATE_24000;
+	case 128000:
+		return SNDRV_PCM_RATE_128000;
+	default:
+		return 0;
+	}
+}
+
+static u64 width_find_mask(unsigned int bits)
+{
+	switch (bits) {
+	case 0:
+		return SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |
+		       SNDRV_PCM_FMTBIT_S20_LE | SNDRV_PCM_FMTBIT_S24_LE |
+		       SNDRV_PCM_FMTBIT_S32_LE;
+	case 8:
+		return SNDRV_PCM_FMTBIT_S8;
+	case 16:
+		return SNDRV_PCM_FMTBIT_S16_LE;
+	case 20:
+		return SNDRV_PCM_FMTBIT_S20_LE;
+	case 24:
+		return SNDRV_PCM_FMTBIT_S24_LE;
+	case 32:
+		return SNDRV_PCM_FMTBIT_S32_LE;
+	default:
+		return 0;
+	}
+}
+
+static int populate_rate_format(struct device *dev,
+				struct sdca_function_data *function,
+				struct sdca_entity *entity,
+				struct snd_soc_pcm_stream *stream)
+{
+	struct sdca_control_range *range;
+	unsigned int sample_rate, sample_width;
+	unsigned int clock_rates = 0;
+	unsigned int rates = 0;
+	u64 formats = 0;
+	int sel, i;
+
+	switch (entity->type) {
+	case SDCA_ENTITY_TYPE_IT:
+		sel = SDCA_CTL_IT_USAGE;
+		break;
+	case SDCA_ENTITY_TYPE_OT:
+		sel = SDCA_CTL_OT_USAGE;
+		break;
+	default:
+		dev_err(dev, "%s: entity type has no usage control\n",
+			entity->label);
+		return -EINVAL;
+	}
+
+	if (entity->iot.clock) {
+		range = selector_find_range(dev, entity->iot.clock,
+					    SDCA_CTL_CS_SAMPLERATEINDEX,
+					    SDCA_SAMPLERATEINDEX_NCOLS, 0);
+		if (!range)
+			return -EINVAL;
+
+		for (i = 0; i < range->rows; i++) {
+			sample_rate = sdca_range(range, SDCA_SAMPLERATEINDEX_RATE, i);
+			clock_rates |= rate_find_mask(sample_rate);
+		}
+	} else {
+		clock_rates = UINT_MAX;
+	}
+
+	range = selector_find_range(dev, entity, sel, SDCA_USAGE_NCOLS, 0);
+	if (!range)
+		return -EINVAL;
+
+	for (i = 0; i < range->rows; i++) {
+		sample_rate = sdca_range(range, SDCA_USAGE_SAMPLE_RATE, i);
+		sample_rate = rate_find_mask(sample_rate);
+
+		if (sample_rate & clock_rates) {
+			rates |= sample_rate;
+
+			sample_width = sdca_range(range, SDCA_USAGE_SAMPLE_WIDTH, i);
+			formats |= width_find_mask(sample_width);
+		}
+	}
+
+	stream->formats = formats;
+	stream->rates = rates;
+
+	return 0;
+}
+
+int sdca_asoc_populate_dais(struct device *dev, struct sdca_function_data *function,
+			    struct snd_soc_dai_driver *dais,
+			    const struct snd_soc_dai_ops *ops)
+{
+	int i, j;
+	int ret;
+
+	for (i = 0, j = 0; i < function->num_entities - 1; i++) {
+		struct sdca_entity *entity = &function->entities[i];
+		struct snd_soc_pcm_stream *stream;
+		const char *stream_suffix;
+
+		switch (entity->type) {
+		case SDCA_ENTITY_TYPE_IT:
+			stream = &dais[j].playback;
+			stream_suffix = "Playback";
+			break;
+		case SDCA_ENTITY_TYPE_OT:
+			stream = &dais[j].capture;
+			stream_suffix = "Capture";
+			break;
+		default:
+			continue;
+		}
+
+		if (!entity->iot.is_dataport)
+			continue;
+
+		stream->stream_name = devm_kasprintf(dev, GFP_KERNEL, "%s %s",
+						     entity->label, stream_suffix);
+		if (!stream->stream_name)
+			return -ENOMEM;
+		/* Channels will be further limited by constraints */
+		stream->channels_min = 1;
+		stream->channels_max = SDCA_MAX_CHANNEL_COUNT;
+
+		ret = populate_rate_format(dev, function, entity, stream);
+		if (ret)
+			return ret;
+
+		dais[j].id = i;
+		dais[j].name = entity->label;
+		dais[j].ops = ops;
+		j++;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS(sdca_asoc_populate_dais, "SND_SOC_SDCA");
+
 int sdca_asoc_populate_component(struct device *dev,
 				 struct sdca_function_data *function,
-				 struct snd_soc_component_driver *component_drv)
+				 struct snd_soc_component_driver *component_drv,
+				 struct snd_soc_dai_driver **dai_drv, int *num_dai_drv,
+				 const struct snd_soc_dai_ops *ops)
 {
 	struct snd_soc_dapm_widget *widgets;
 	struct snd_soc_dapm_route *routes;
 	struct snd_kcontrol_new *controls;
-	int num_widgets, num_routes, num_controls;
+	struct snd_soc_dai_driver *dais;
+	int num_widgets, num_routes, num_controls, num_dais;
 	int ret;
 
 	ret = sdca_asoc_count_component(dev, function, &num_widgets, &num_routes,
-					&num_controls);
+					&num_controls, &num_dais);
 	if (ret)
 		return ret;
 
@@ -959,6 +1149,10 @@ int sdca_asoc_populate_component(struct device *dev,
 	if (!controls)
 		return -ENOMEM;
 
+	dais = devm_kcalloc(dev, num_dais, sizeof(*dais), GFP_KERNEL);
+	if (!dais)
+		return -ENOMEM;
+
 	ret = sdca_asoc_populate_dapm(dev, function, widgets, routes);
 	if (ret)
 		return ret;
@@ -967,6 +1161,10 @@ int sdca_asoc_populate_component(struct device *dev,
 	if (ret)
 		return ret;
 
+	ret = sdca_asoc_populate_dais(dev, function, dais, ops);
+	if (ret)
+		return ret;
+
 	component_drv->dapm_widgets = widgets;
 	component_drv->num_dapm_widgets = num_widgets;
 	component_drv->dapm_routes = routes;
@@ -974,6 +1172,9 @@ int sdca_asoc_populate_component(struct device *dev,
 	component_drv->controls = controls;
 	component_drv->num_controls = num_controls;
 
+	*dai_drv = dais;
+	*num_dai_drv = num_dais;
+
 	return 0;
 }
 EXPORT_SYMBOL_NS(sdca_asoc_populate_component, "SND_SOC_SDCA");
-- 
2.39.5


