Return-Path: <linux-kernel+bounces-271157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A950944A36
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFAF21F2909B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A861898F2;
	Thu,  1 Aug 2024 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T7PDa/Zm"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1930F18453A;
	Thu,  1 Aug 2024 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511169; cv=fail; b=QeqAZLeaeILHDjG8/chbF7QNPBvBd7G+R/l6n5NN55Sp9DLqA/hhRUXii884vFxIa3r89gJye6fYD7CwcOAMKhjmxqz7rK7iyCnh1WQi1BWIbe//fcjzioYMYfe0i0G4T7zVfpum5UK1E47d3DNUl8OzZhmIvvaJGqVM/gCDQi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511169; c=relaxed/simple;
	bh=7lJm62gGZaCzzSe8SzfIekE5+wsRSGOc+zr+ncqda3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwZwGscgRUCM8OnUxNPuIhfu7mHwdNSPqZ+FPRy3AXgUGsQdt8VHgz1w+xUCX33a8xm0nOci5tgDGSktsfiuRqu2b7IO/w+z6UHsLMCW2QMaYGa0qA2mXssDK2VNHzTLIw4uP+ObRWBoV49Ah14GuUBcFN3+/if5/RKKIT14B0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T7PDa/Zm; arc=fail smtp.client-ip=40.107.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fr+ssI6eth9E/dAE8KfUwaaWESw9v7O49beFfUTxRQ3Xh/PTWV3hfmO4IEJnGx2MnVUtcpNGR5yO824CT12nRzEOr3vKnRglxNzzSr/K3ZN1pSazDVIui7picSTbZ00diNRZ2XaVym0Z397QTAYvWIcY1zv6f4Lk8fqQL3OTO96AQSArOjEfaZ9YMAWw6llay8GijGgE/mZE5D1xqshfFEWroUKgj8/uyKFjFri41tUflmLrU6gthjXKTD8LkPvWJli4gRkDCbYRN5eHjLKaJRgdMBjBf0ahdZMU5UsnkSHEXYfp1Fc922j8QXP0gEX+3kDIm2NlyJGb+0+PKwa7og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umBKBFd3O3E9jBAAyGqscWbcRWLwPoR5N1kTEzkf11w=;
 b=ddfKRJyVMcy5AwmbPLBb+5Gu0T4TDIkfUCNX/MXmruqizD807U/oVl3Q5jLeqmrtXEyiYGvYozzTSGIpGM/CW/JDQx0p7NQQCBP+8ZaHMBzxBs/ZmH2xljMdNKTfE3v4ydg4OPBPqaLCfxCe/dHx0TG0zlitBHgXFh6tYrgr3UAe9IX7b7K4fIdbdIPq22Xad7aG7YEqP6zFPKg/1x/3WGiWygkISpsE67ZipTXCDHTCiC2XrFJi1u+u+oMkNzTDLpE6eEzeKIQo44MONiXRRGQ2Ho7WN1FsK2bVf++DEDtZ1FUYdAV4hdzjcua2TkKcPh3Bmy/+tbeRw7xYtI6p8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umBKBFd3O3E9jBAAyGqscWbcRWLwPoR5N1kTEzkf11w=;
 b=T7PDa/ZmCs9+swh03tyJoHzXKqmCNcZ+rf3HYu6fAYEfDKDmCZSqagUr8NHw0ggp/7tt2NY3SQGtnWVo2B1M9ptp1yQtQlDdUHf9mivWTA0r9WWe7dven9a4RsUQfxpQnZhXoeb9OJTeHfMK/oZt6GiAQ8sHCDKsZbAcC4vMzkU=
Received: from MN2PR15CA0031.namprd15.prod.outlook.com (2603:10b6:208:1b4::44)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 11:19:25 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::35) by MN2PR15CA0031.outlook.office365.com
 (2603:10b6:208:1b4::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Thu, 1 Aug 2024 11:19:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 11:19:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 06:19:23 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 1 Aug 2024 06:19:13 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <vijendar.mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <alsa-devel@alsa-project.org>,
	<pierre-louis.bossart@linux.intel.com>, <venkataprasad.potturu@amd.com>,
	<yung-chuan.liao@linux.intel.com>, <linux-sound@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Cezary
 Rojewski" <cezary.rojewski@intel.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Charles Keepax
	<ckeepax@opensource.cirrus.com>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 24/31] ASoC: intel/sdw_utils: move machine driver dai link helper functions
Date: Thu, 1 Aug 2024 16:48:10 +0530
Message-ID: <20240801111821.18076-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801111821.18076-1-Vijendar.Mukunda@amd.com>
References: <20240801091446.10457-1-Vijendar.Mukunda@amd.com>
 <20240801111821.18076-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Vijendar.Mukunda@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: a10b7f81-0281-4743-e104-08dcb21bcc79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nEj0iyPAeTHFkuhDNHyNvvRq6P6p2p/egrsX7NKSYo3HQCYBxCRILaoVxTok?=
 =?us-ascii?Q?j+F/dLGFcgzzXMnHCwDJ5LubfsjTYBQW2pFBFqBaUbkigUui05zBKlkHk+My?=
 =?us-ascii?Q?Nn2JtKbU/7VxinYYn94HkfE9of3LiupTv6bbqJPmkaBXCZfMu3fPDmWuy6S9?=
 =?us-ascii?Q?ykIV2SxCgi2LQ3SV6Yu29yMyAoWmJYf5v30qWySFBYUScT9vue2YY9THyaZm?=
 =?us-ascii?Q?H4qAdQHSqK07kNvHDojZWJYGtYo3CEwkufatWLl8un/Tx/pe5+wVTfJB11L3?=
 =?us-ascii?Q?Hu+YyIbpjhrc/7f3mfFS8pMJzHgJBxXXT4CEism4C0WGmsUSdm1GV5e+Gex5?=
 =?us-ascii?Q?TLrdD3qo3Dx3iFP/9RbEb9/hHlC+uAmZK/mx0eBY0YZGwnJMOLrwiOyBL2nT?=
 =?us-ascii?Q?00SPhibS9MdILPSfpqkiymK1MxM2K0Fx9VKDpjMQWLtEkBJnfEj7CrIzktT7?=
 =?us-ascii?Q?wF51CNh3YwFxNQfdSh/c5owfbxQyVxS8dc2Ic6PLZC0JgmcdXHhZxgFvtEZa?=
 =?us-ascii?Q?3iubMv6+g+celKI9biTpKjC481yt/9PuZ56Co0N030KXDt0k0dQJL1xF6yj1?=
 =?us-ascii?Q?ImDfCpMeQbF49iE0Kfx+WKnkLsWUikA7wdiT+OFAQaLYIFtmfOHCEJ+JTvaM?=
 =?us-ascii?Q?NrQmCAO5VFcceoDe1P82eZ5DCcl30ApOiFdn98zTEfR2tT2tCev2BL9LF41j?=
 =?us-ascii?Q?vRLJ9RSrd+1cQdw5FLeMiwKj4M9woM3aFO9LH9AcSIEgyr9j7CwsbCDYiVJw?=
 =?us-ascii?Q?5f2xt4NzNeMavFs2SGY1NWtJhsJ1LHlqPLVI3r08p970uOBbA1bZ+dJi9fs6?=
 =?us-ascii?Q?iI7qT9OZLqK+2ZOsyM5uD9pqh0sYEBL8iGpviTB+9cImwzJX1j+JCIVDYCou?=
 =?us-ascii?Q?56MZD2VZK7Xmy5PixeHo90Q1exaDN6EI4KY8qegOjBr9Nm1SQkUpDY5xVEz1?=
 =?us-ascii?Q?rO94qR1MbSl1wedpH0c11LEi7xFCnnoDAJRH+nvwwmSgs1r7O0C3aVr6SDlQ?=
 =?us-ascii?Q?XGB8+yQv0CFMYegueFhFvsNHFUZtNfJPODrUaGmmJ/ijV4cK09KicJ4UEYa3?=
 =?us-ascii?Q?s71V/TU5ESPqzxSsISI9Wg8k7mvViLWyh2B7BMbUyfoYD8ZJy3P2f/ZMOlMd?=
 =?us-ascii?Q?B0pOdVkzGN2cpifxcC5Ysd070hmI7rOl85UWmnzNH4cpntMjm9jpD5UhTbBb?=
 =?us-ascii?Q?mt59B4r0E3x6EN9mnRkxDleSXmdE2llcfHIR9AjPm4zehKhy5RojssYRevCL?=
 =?us-ascii?Q?+IjZeUcg21W1cai3/IDewodvdN6yVqQA9U+HWGxAPefQ+68gV3BtmVi4P86A?=
 =?us-ascii?Q?dK5LWbT5m+trIkkhkRUKEfBAuEsmjKnM6LLwyqX0TslUMeG/mAMTDfKeeYO0?=
 =?us-ascii?Q?h/nAimSYzV04dJX8zTZAcgKR4U+VEfSOegbOAce4bGhxqk+5NA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 11:19:24.3543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a10b7f81-0281-4743-e104-08dcb21bcc79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160

Move machine driver dai link helper functions to common place holder,
So that it can be used by other platform machine driver.
Rename these functions with "asoc_sdw" tag as a prefix.

Link: https://github.com/thesofproject/linux/pull/5068
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc_sdw_utils.h       |  5 +++
 sound/soc/intel/boards/sof_sdw.c    | 54 ++---------------------------
 sound/soc/sdw_utils/soc_sdw_utils.c | 52 +++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 52 deletions(-)

diff --git a/include/sound/soc_sdw_utils.h b/include/sound/soc_sdw_utils.h
index 9d99a460ba27..b3b6d6b7ce2f 100644
--- a/include/sound/soc_sdw_utils.h
+++ b/include/sound/soc_sdw_utils.h
@@ -117,6 +117,11 @@ struct asoc_sdw_codec_info *asoc_sdw_find_codec_info_acpi(const u8 *acpi_id);
 struct asoc_sdw_codec_info *asoc_sdw_find_codec_info_dai(const char *dai_name,
 							 int *dai_index);
 
+struct snd_soc_dai_link *asoc_sdw_mc_find_codec_dai_used(struct snd_soc_card *card,
+							 const char *dai_name);
+
+void asoc_sdw_mc_dailink_exit_loop(struct snd_soc_card *card);
+
 int asoc_sdw_rtd_init(struct snd_soc_pcm_runtime *rtd);
 
 /* DMIC support */
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 87f3e5aa1477..07b1d6994304 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -1238,56 +1238,6 @@ static int sof_sdw_card_late_probe(struct snd_soc_card *card)
 	return ret;
 }
 
-/* helper to get the link that the codec DAI is used */
-static struct snd_soc_dai_link *mc_find_codec_dai_used(struct snd_soc_card *card,
-						       const char *dai_name)
-{
-	struct snd_soc_dai_link *dai_link;
-	int i;
-	int j;
-
-	for_each_card_prelinks(card, i, dai_link) {
-		for (j = 0; j < dai_link->num_codecs; j++) {
-			/* Check each codec in a link */
-			if (!strcmp(dai_link->codecs[j].dai_name, dai_name))
-				return dai_link;
-		}
-	}
-	return NULL;
-}
-
-static void mc_dailink_exit_loop(struct snd_soc_card *card)
-{
-	struct snd_soc_dai_link *dai_link;
-	struct asoc_sdw_mc_private *ctx = snd_soc_card_get_drvdata(card);
-	int ret;
-	int i, j;
-
-	for (i = 0; i < ctx->codec_info_list_count; i++) {
-		for (j = 0; j < codec_info_list[i].dai_num; j++) {
-			codec_info_list[i].dais[j].rtd_init_done = false;
-			/* Check each dai in codec_info_lis to see if it is used in the link */
-			if (!codec_info_list[i].dais[j].exit)
-				continue;
-			/*
-			 * We don't need to call .exit function if there is no matched
-			 * dai link found.
-			 */
-			dai_link = mc_find_codec_dai_used(card,
-							  codec_info_list[i].dais[j].dai_name);
-			if (dai_link) {
-				/* Do the .exit function if the codec dai is used in the link */
-				ret = codec_info_list[i].dais[j].exit(card, dai_link);
-				if (ret)
-					dev_warn(card->dev,
-						 "codec exit failed %d\n",
-						 ret);
-				break;
-			}
-		}
-	}
-}
-
 static int mc_probe(struct platform_device *pdev)
 {
 	struct snd_soc_acpi_mach *mach = dev_get_platdata(&pdev->dev);
@@ -1368,7 +1318,7 @@ static int mc_probe(struct platform_device *pdev)
 	ret = devm_snd_soc_register_card(card->dev, card);
 	if (ret) {
 		dev_err_probe(card->dev, ret, "snd_soc_register_card failed %d\n", ret);
-		mc_dailink_exit_loop(card);
+		asoc_sdw_mc_dailink_exit_loop(card);
 		return ret;
 	}
 
@@ -1381,7 +1331,7 @@ static void mc_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
-	mc_dailink_exit_loop(card);
+	asoc_sdw_mc_dailink_exit_loop(card);
 }
 
 static const struct platform_device_id mc_id_table[] = {
diff --git a/sound/soc/sdw_utils/soc_sdw_utils.c b/sound/soc/sdw_utils/soc_sdw_utils.c
index a496b4eff6e3..409a50147349 100644
--- a/sound/soc/sdw_utils/soc_sdw_utils.c
+++ b/sound/soc/sdw_utils/soc_sdw_utils.c
@@ -864,5 +864,57 @@ const char *asoc_sdw_get_codec_name(struct device *dev,
 }
 EXPORT_SYMBOL_NS(asoc_sdw_get_codec_name, SND_SOC_SDW_UTILS);
 
+/* helper to get the link that the codec DAI is used */
+struct snd_soc_dai_link *asoc_sdw_mc_find_codec_dai_used(struct snd_soc_card *card,
+							 const char *dai_name)
+{
+	struct snd_soc_dai_link *dai_link;
+	int i;
+	int j;
+
+	for_each_card_prelinks(card, i, dai_link) {
+		for (j = 0; j < dai_link->num_codecs; j++) {
+			/* Check each codec in a link */
+			if (!strcmp(dai_link->codecs[j].dai_name, dai_name))
+				return dai_link;
+		}
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_NS(asoc_sdw_mc_find_codec_dai_used, SND_SOC_SDW_UTILS);
+
+void asoc_sdw_mc_dailink_exit_loop(struct snd_soc_card *card)
+{
+	struct snd_soc_dai_link *dai_link;
+	struct asoc_sdw_mc_private *ctx = snd_soc_card_get_drvdata(card);
+	int ret;
+	int i, j;
+
+	for (i = 0; i < ctx->codec_info_list_count; i++) {
+		for (j = 0; j < codec_info_list[i].dai_num; j++) {
+			codec_info_list[i].dais[j].rtd_init_done = false;
+			/* Check each dai in codec_info_lis to see if it is used in the link */
+			if (!codec_info_list[i].dais[j].exit)
+				continue;
+			/*
+			 * We don't need to call .exit function if there is no matched
+			 * dai link found.
+			 */
+			dai_link = asoc_sdw_mc_find_codec_dai_used(card,
+							  codec_info_list[i].dais[j].dai_name);
+			if (dai_link) {
+				/* Do the .exit function if the codec dai is used in the link */
+				ret = codec_info_list[i].dais[j].exit(card, dai_link);
+				if (ret)
+					dev_warn(card->dev,
+						 "codec exit failed %d\n",
+						 ret);
+				break;
+			}
+		}
+	}
+}
+EXPORT_SYMBOL_NS(asoc_sdw_mc_dailink_exit_loop, SND_SOC_SDW_UTILS);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("SoundWire ASoC helpers");
-- 
2.34.1


