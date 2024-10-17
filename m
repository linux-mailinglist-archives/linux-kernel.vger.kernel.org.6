Return-Path: <linux-kernel+bounces-369656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8820F9A2075
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CD91F2778D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242F11DB37C;
	Thu, 17 Oct 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NHov7A+Q"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2089.outbound.protection.outlook.com [40.107.241.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323FE1D9660;
	Thu, 17 Oct 2024 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162953; cv=fail; b=JrOBw9yP4EYCg8HxOUJHJ0GJJr+izeYG6U+PaTc7OqKxm20Z1N3hGrwRr7zEJnTg1+hK5YUStNlEiAsfAMI5gCwMiEb77qWdd5eruHl6DG/urgvhKwlqawE+3afPb5/OiD9Oc68P8kgt/O0zKqcRIyinjQHQyjLNxLBRjFZLOxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162953; c=relaxed/simple;
	bh=yALLdb0dbxPW6ycLAH3PsyYeJhsPbq0K26UR6OPZnwc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=s+X9oHskotJwD0C0o74egtrvFm8pg0FujanTx1Mg2UFwdBDa18I1yoDj67JnXzpAmJnnqjlP0N1Jg0j9Y2C4lzzyyzoBqM6C6j1Rq837Poa8a785BdNho5Db+R0U/oZ6OgN364vgZsa2LFLfF1aS6c/kkL8Vhf1m7mO0B3UzyWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NHov7A+Q; arc=fail smtp.client-ip=40.107.241.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grOh9WXSf+oUaf6iy+fZec8ndCXjBfm+lLEYuyDvaM/W0S+QgtUqDxMBnh9UdwNWMFgxaHEwABDsLtwPsurh7jmXraQt53XKikc/V4jX3D38TBpfWedBeq5Fkd11teUuFf8snEHV68DgInvn0WAhHfj+qmiOS55VNva7ELcvs/MCl4ZDHCFWxg0UOVtLXEjGCzY25NDFyLvtMa6sbTagyyyYgz30WxxTbnQURIDSpkskROXT7ykffSOK8+FH2LEO378qAwynswdrRPaIRP3f4VwwtZH/HuL86lEwxS8pN/HetYVt4EVC05L+SlS1YwxuUHKPFne4d3nw/2Jg8Ak1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmrxZgN4TBMtUyCROHM2QsJDWaSedZEBBEoWrZRJlWY=;
 b=opQ3dQC2JnKIQ46ZZLHtLGTO+IEgfulgYM/N/5kFz408MiaysVwqd12nKjuvUi+38dRxqu+Xi0sL0Ddrjg7rt0oAirBWLUiMSrfP8+Yxm+5T1UIrzeevp58XycaUObSKdAy0jRA6PW06/QONDrI/+46ZLdGo8PHOWHOGNbySpF8PD7z2YdGTnJ8wSQiWZk2QVVcMT5HEuyswjnUrN8fJtfcrbDOiY54roJBp+CDeSZXz/HVRsJwIJ4FVuM11gXkAC1mwMA1Yu9KaEEK0A5mcxhJQV0DbE5wYAbkjVZd8X/0ujghNedWVk9GgfO6SxCQ2UZYN2ST0WkkXAqgDvjGL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmrxZgN4TBMtUyCROHM2QsJDWaSedZEBBEoWrZRJlWY=;
 b=NHov7A+Q08U00hT5h5XjpygC5SuGh/HYGLsCCdOzetAICIYeq6G/yiBIGkoHuvbp0OcmDvb9Jomq1ORJpk17lqvOgF7GpA6cmsHY/w57vU83H+U66BKO6p4XCGntxv0TAN2Js7MzcJPY7yby4ET9ZeWMBzl3rKdp/UtyGpseKOSJTWXJPRoovW57RBMv9XzD9iw/XDqXBDzQlSnVYodpPleFks8YzronlKs9heDiZiNNmujFrScUhzcI3k3nZkeDv3sYZg3ob+HoE9cZsnrzLVWR/8V3WhVYNKwllJ0/5F98s6PizhjPLZ08348drHOQXWiLVODE47KFVnKzVo+Ftg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by AS8PR04MB8087.eurprd04.prod.outlook.com (2603:10a6:20b:3fb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 11:02:26 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 11:02:26 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: broonie@kernel.org,
	linux-sound@vger.kernel.org
Cc: lgirdwood@gmail.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	Anne Onciulescu <anne.onciulescu@gmail.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Chao Song <chao.song@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: SOF: sof-of-dev: add parameter to override tplg/fw_filename
Date: Thu, 17 Oct 2024 14:03:13 +0300
Message-ID: <20241017110313.1423258-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0027.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::17) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|AS8PR04MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a861d1-8171-4631-35b4-08dcee9b2f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dVWn+3iVOKRRVWkShblcEvbbmNK9dSBaNNvsX0FXCDARJG6ztkMSBzga/Xh7?=
 =?us-ascii?Q?EOa9mvYulVFkkukzcCgqwTwAIFiaJyAr6HkLC45gAOPveBVSgadiLLwRwqdX?=
 =?us-ascii?Q?ON+uKSLGqLmtf52kpfHoqFHr13oGgWPDVMYGXehtuUPJP/EMydwFmBplON6j?=
 =?us-ascii?Q?Gdc6f7/LxXp9SpSdLM5kfuLitL2JCcF8G+p1h+norv2HleKRjo5wAdwva/qI?=
 =?us-ascii?Q?wHg9PjpVrPziEHYWI3D9WW+QMcN2bbIG0IQy6LAAkmVL4mI2vhxz2Sd2BFz0?=
 =?us-ascii?Q?cQ0nuShfiULVgQL9zD3AUMcs2JUol53ok2DFHlXn6Zgd3lZR22XyOF0GsKXA?=
 =?us-ascii?Q?5H6sMgAsfj7oduAtfllWthkt+vQTpUdHe0ULZsqCZMDZVk8oXOZB7Rl33nMu?=
 =?us-ascii?Q?9Vf/gdXeWssejC7Gaj0gNsH6aM4PPG8oOIxqhzNkOs5rcVJ6K0NytGVtucIf?=
 =?us-ascii?Q?PT0LdTmlAfM+eWPpmFRiUZ5EvIEqPFgPyPkcDhr1goFYHOeyoSW10qsE6xvv?=
 =?us-ascii?Q?9/l6eJzHijSEcsji9cx7FLuMYe4Y6jrbYVlonJwAz3CjpdAzmMA+0sp7hJHC?=
 =?us-ascii?Q?SMCxZar5RWgTk7MAmv/TwHfDKBSdQ9gMq0/WpeAXcrVU68xX0SBF7IrM+Q47?=
 =?us-ascii?Q?7U2bgEcw203weO0IGvSpZcOYZ4Sr9LbaPbS80WaCYLnC3H94yp5rIR4qbmrC?=
 =?us-ascii?Q?ZC+Nz3uxqRiZLQdhw6jkq9ZqTfg6yfYLCkNfgie8OFGjtKKYrWnCt8W0qgUU?=
 =?us-ascii?Q?VGupDNun+HbtUolpbUb+wC8uNotBHITuY4u/HsZg2bIAwSIIpa68ZDSHhXu8?=
 =?us-ascii?Q?/aR4Uv6SzywIN6HKfOz+/HKoXWJw5HzgXco+F6I/hqPgNnXExcZi5EkfqwVr?=
 =?us-ascii?Q?dUTaC2EjaI125+56S+UqDVUum2NxvWdhJ8ef1rWqj2U7rdUQ3JJBmR7LpuD9?=
 =?us-ascii?Q?wBYmeDI9PAGp7wQxK/KRQIz4gKij7fTYau9fF0DHwhYODA2o4XTaXk8IgpZH?=
 =?us-ascii?Q?U9KgGeLrPKCCdqJVPqIpct5wAwmpMaD2lQG6PVpzE2yhigrquev8bN9Pl3nl?=
 =?us-ascii?Q?QOkrpuSXrO3iRx2x4ObZb2OrA66SEwozUv4uo31j7Xv/bjwtLVFqbu1WzdBs?=
 =?us-ascii?Q?rJJSFSBPOgH9QcdS3C1NeWhW8GTkdW5CFVE9fDczRTDLfElOiv5ByYCRWV53?=
 =?us-ascii?Q?P0Rz+GACvr4n9YUZ0/EE0WnVPMyopczhP3BWtj+aJqIjZtEqLbqpsKSRflB1?=
 =?us-ascii?Q?6T592oTkZ5gCIWgqzZkZZixptLKnTGEnJXFNMrY5j1+DHrxQXL5z4kSLRZfI?=
 =?us-ascii?Q?9ZlKHZq94l+tQm/lHRb0u3WQzdXCshFFr7VxwdxTXOweUMKAgeMz97byDyf4?=
 =?us-ascii?Q?t1IY3r8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QDcZV8S3QKmvoS0cTwgIBgkaKYUHgg8oXUhX2fdUrFoWkhxHmRuHLBV7oHuG?=
 =?us-ascii?Q?vCFsXGcRuzhVV/oxCLww+3QWt34e9rYrs0ScObv1IdB0Kyqw2Rnr1crzLdSF?=
 =?us-ascii?Q?3OcoaTNyqiFEpn8BEPhsVfpZy3Hc4cyRsynQvQ8PqSzG/JXEO8AEPeDEbZvb?=
 =?us-ascii?Q?WD0MVSWPXOghqOaB3MWLE4W+JaO1HPwKLxERVmytQ8BwPi5nNZakDGZMTtQZ?=
 =?us-ascii?Q?AmmN0psaNor7dTsYjjduNjfYy5R+eJXCgDw7T6jdEJXI1xk7DfBUzWZka7iF?=
 =?us-ascii?Q?Unfv8fSgwGARTa0V19QxiEScT5u5rSHn4COu4P+mqTiZ4jTpSKQ/seR1M0YX?=
 =?us-ascii?Q?Blz3yblOh67hP5g5d5imQv6zNBWzWrBKRtQW0DoZ9tAcItfoWXJXE8smjGWI?=
 =?us-ascii?Q?GsFBWBg3Z7UfFHpoIPbbPvC2V2qzhEEEB6Jfc9nLqMFf0EaX1TpIuExkZBKX?=
 =?us-ascii?Q?IvDpz8+aL1Te68BUi0QByT0OhEMdnNlxZILdEK026O3b/R9eoO8N2qngFGbC?=
 =?us-ascii?Q?uu/VCmh6d8wKgQz6Per7GEEJbxzrf9vtrtW9ZvGQtKnfOe4rqoYqDevnQLRI?=
 =?us-ascii?Q?OClg9pUBWmLDK9l6y5DiDR6Ca/mIo3YPq6Yh3WNQl1PDR2B7bsD4sfUTk6F8?=
 =?us-ascii?Q?koG3s+IQar7Fa8D579NSuWgAoizzdZ31BS0SNh6aazWRJNEkkPImuvX5efuE?=
 =?us-ascii?Q?ZRbjjyuaLsmNppeAVXLu62oR/e85CyU2J3haQne52x5Sbo68IB8DWYdmTptF?=
 =?us-ascii?Q?AuMBzvvdDeSHKB3g6x+LZZXjrBPgUAxVq+Lgqfqid8urSyvH6BkiymhEBltS?=
 =?us-ascii?Q?4zxEVN2V0SBxHUzHvPc9N18MVQisXeyWnb3220N1cacEQPds/rHvJVUoEa9s?=
 =?us-ascii?Q?d2uDRky8PzSxhfhGeGWy8Z0I646aSvRF3MUBIbIzTelJN7z9IaFKGFESHrVH?=
 =?us-ascii?Q?VdGUFqTfht8rIIeDB8FhCurXX/2JX5C9rg23aibXUo6C/5PdYfmCTc3gS5iC?=
 =?us-ascii?Q?ShV/G7oC3UP47KU+jUeWNdpWVHjTbfbhu7xg7OPR95VI2jsD+QG7WSAZ/7CS?=
 =?us-ascii?Q?NDCxMgpEgEfXq8h6f9VaUApvizjeTkf9aJc8fGX2KlqdgEGmQs0yLawpdtSv?=
 =?us-ascii?Q?SweB2s60UkpYxKDtd0YgGEHs3qJfUOQcbSqU1PXdMsgYaRma3T4+dP++lI6C?=
 =?us-ascii?Q?8EANDehUQUrvNnQkSEzQzEvs50i91qYPBcWPa9gcar0BURS+/ejtSJqTK8or?=
 =?us-ascii?Q?2PfQJugA4mMrq1HwMjwvbj6Zmtf03GYc59ydLwH8V0xVIN+hAza5REziyaUo?=
 =?us-ascii?Q?Fr6zbY6tvwjHrGoG06Su2d9228hU/gLqwSXyJwP1FM52pdhaYYVNbpiMcjJz?=
 =?us-ascii?Q?Vs4A6tt2UujO3EBgHmJWsISUUuG1hDH9a5POuekJkNvqqQgGuM2y7diD6aYQ?=
 =?us-ascii?Q?1AeRlHLENQTzmZp/ARYGvXoqalw+HheRCottRaJ1G8IY5CK0JEf44PRocFkT?=
 =?us-ascii?Q?qyZZro8ddlCFbo1cygm9cZAHf01ycDxh/MdVJitaKs/wkc67Dve9x1gfEj7r?=
 =?us-ascii?Q?ZCOvaksC94V11iDXoykFGswVA1+g2QafDAUdryD8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a861d1-8171-4631-35b4-08dcee9b2f25
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 11:02:25.9732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBS1ig3SPJtwgXxaFSkpIxtZTvNzqpFDUWdQK/qfIbLMgsgkljxm8/Pg0ie177kAm14WArQzy780+irF1S+xVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8087

From: Anne Onciulescu <anne.onciulescu@gmail.com>

Add support to override topology and firmware filename,
using module parameters. This is helpful for development
and also for testing various scenarios.

Signed-off-by: Anne Onciulescu <anne.onciulescu@gmail.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Chao Song <chao.song@linux.intel.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/sof-of-dev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/sof/sof-of-dev.c b/sound/soc/sof/sof-of-dev.c
index 71f7153cf79c..f245c1b48c47 100644
--- a/sound/soc/sof/sof-of-dev.c
+++ b/sound/soc/sof/sof-of-dev.c
@@ -18,10 +18,18 @@ static char *fw_path;
 module_param(fw_path, charp, 0444);
 MODULE_PARM_DESC(fw_path, "alternate path for SOF firmware.");
 
+static char *fw_filename;
+module_param(fw_filename, charp, 0444);
+MODULE_PARM_DESC(fw_filename, "alternate filename for SOF firmware.");
+
 static char *tplg_path;
 module_param(tplg_path, charp, 0444);
 MODULE_PARM_DESC(tplg_path, "alternate path for SOF topology.");
 
+static char *tplg_filename;
+module_param(tplg_filename, charp, 0444);
+MODULE_PARM_DESC(tplg_filename, "alternate filename for SOF topology.");
+
 const struct dev_pm_ops sof_of_pm = {
 	.prepare = snd_sof_prepare,
 	.complete = snd_sof_complete,
@@ -68,6 +76,8 @@ int sof_of_probe(struct platform_device *pdev)
 	sof_pdata->ipc_file_profile_base.ipc_type = desc->ipc_default;
 	sof_pdata->ipc_file_profile_base.fw_path = fw_path;
 	sof_pdata->ipc_file_profile_base.tplg_path = tplg_path;
+	sof_pdata->ipc_file_profile_base.fw_name = fw_filename;
+	sof_pdata->ipc_file_profile_base.tplg_name = tplg_filename;
 
 	/* set callback to be called on successful device probe to enable runtime_pm */
 	sof_pdata->sof_probe_complete = sof_of_probe_complete;
-- 
2.43.0


