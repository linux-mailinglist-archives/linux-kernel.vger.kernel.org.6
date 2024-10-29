Return-Path: <linux-kernel+bounces-386193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7149B403D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28211C23101
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBF015B0F7;
	Tue, 29 Oct 2024 02:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aOL2ecp8"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2087.outbound.protection.outlook.com [40.107.105.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72F61922CC;
	Tue, 29 Oct 2024 02:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167882; cv=fail; b=AinPzpZWwNL4CL/LKkabBIrgj/b0Q2YPYyXfXtjMKL9w0h2qvkOfseXlQPjjJ7sYwrUjyblR8KPKpZWx25sDnwFy2+iNwGJLP+4JQlB2fktDt3kdhoK4yxZREFTy58/ZMo5c8G40aEAk2PLnD2BxQht3ZTThaNn0rc2l0lhb884=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167882; c=relaxed/simple;
	bh=Kga5T+ah2FU3Ou2fNm/+P5B4ui4zBo7U8oJFsAlVAeU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IgfbXQo5fRiKl/ozn11I+o26GzvCQNFJI5fA6iugExONfPrCPP1qv/NY+j+AACxzmqisRFKpkoIfBDyIxbI0P9WdifF0iz8QrLYAhn5xO40d3nH3lGgP2AUVaqmO+Q/BjCxmve4u8csvkhmRzXbFyl8BAi0/khpgIcB5pdwxLgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aOL2ecp8; arc=fail smtp.client-ip=40.107.105.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBZkCS3hU1ki8Qbz3YPLdxYHkzGcPpGb/YkVUdhmirVKr4JJ+Q4T02GzUjc70mrJemMtozMrQc34B+nDd/DCaZnnDwP+yhRiSs/nyqsgyBAD2s7YGDnBlWf/kthOF1suivQSFXC1jPaiTjSPdOJHLAela4SR7r9DZ0mMO5NOEcsDaTrmjOyq2juECZ1D2s30WcGgbtC6Uh2VijkbB4Zre2IHPHYLETzUWpMS6UVXj23GhovR20R2np/DGX2plmtzU19d5ykzd7dMwB6+5xAmxZIRv3kwL8/omXtsfMFXMMPjqksc0aNCMMfHTNvqH123zUbMk59YQoPcx9Ed9/YL/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gx4r59MsUrRSAYnRBL2LULLZNbMWnLuBxzcN1FydhN0=;
 b=dvCybpT4QjK1gZ3p+ErgfwKL3LufPCamknLi7pP4Pd5oGnbk6hwPxRkWBhJt3VNZNn5MxqBv8hM3CAL0Jbw2u4MUeY4N62LRktOiXv5kd7CViY8Jjo/KeUJebKrXSf6a0uWDQuPzwKSsjc5RCacMdGfH4VWrfE+plN7Qz8VPtKt1Bdnr4rQ/IjTdqodRk0egU12n+nHzpSgx+5NtfjczuGXDwJ7rkj25A4AyJZBTlEi6/dNYlo+bTYUGI41Ptsi6a0qF4sujm7WHmKerss/nH4oN11NtnLoy7AQAia19rd8f9Pp14rgOU+5cVpnwgFnP9mXoFYKVGDjBJn247tm03w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gx4r59MsUrRSAYnRBL2LULLZNbMWnLuBxzcN1FydhN0=;
 b=aOL2ecp8vC6w0n8PpwGe9ysa54x7ufbhe9+dlX1WDatg1WLHm/nPcdSxymvq52Dw3JJZiIJiTA/nX9jDFhdWTamUrm19P82yBXd/mqvjGRY6ujiPNDPHTKMCR07Wi5rlakKFEHJcFc2+tLpi6mQ+92RkmFPO7y+SqbwzMNf1NZSkio/CzxIETVOuGNWQ0v2+5ZsyUwqPb77jQFgCxN+0421W9aCXSkVslVWPMqHu+5DJM7Y0w8BOJSsPKLWmCSAo8ONf9yRvS/vRuzXf/egY/FuIKiEbu0LERHpfgvl1nqPA4vJ66O5bWizYCVo1ZMS0N619cHC4FeOrFieQnnZodQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by DU2PR04MB9147.eurprd04.prod.outlook.com (2603:10a6:10:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 02:11:17 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 02:11:17 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 5/6] ASoC: fsl_asrc: register m2m platform device
Date: Tue, 29 Oct 2024 10:20:56 +0800
Message-Id: <20241029022057.816402-6-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241029022057.816402-1-shengjiu.wang@nxp.com>
References: <20241029022057.816402-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|DU2PR04MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f95093f-d085-4eda-ad8e-08dcf7bef8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0WvsFjvQXmSyU518eiY0qatYO18A7wHjhFSgiNOruqx9Ycd11LJS40PkyDy/?=
 =?us-ascii?Q?JRppbuKA7KUmnPd/F6i2uVFGxlg9Y/MhDeUHtAniv/yxU1TMSZrK6vCjP3JO?=
 =?us-ascii?Q?tMVWmGyFdGbw7yZrSJY/EHUms8JGl6YDiqpNcuH+p/WndSGNfRr/prwoEy7v?=
 =?us-ascii?Q?mtfg0d/U8SMP49Shf9X8wXZbW15LBzis67OrnC8rNsN40Fw2YtyuqSTIsO1p?=
 =?us-ascii?Q?lJJU9T4/fdo2e0qTEf/M/1jiMJtwdTT5ezs6/0aYu8T7BkDRV4nNTiX0b+y5?=
 =?us-ascii?Q?ezDHUV5aqDhkfzyUxxCpKQvcoEAag7W9Y4zFSS1zdXWNs+hSbEFtwWdQ4pZM?=
 =?us-ascii?Q?fWKcQjw2fbSKRTVXWxOlB2SgUYRAP5deeyLfLi4k+H6Vvf3MakFtkAnBibMo?=
 =?us-ascii?Q?8tjkzj5kUkItbNha485DjUML3rE8h4hz1YRb2AHh2lRTn1Kuox6yiuBFa+9L?=
 =?us-ascii?Q?zkcSTCMHuTWVTaQkvLKRO4ngZIZTmghzNGwlTCK6RzeKKWjzwk3yLMu1cIOL?=
 =?us-ascii?Q?ZD9Fp+NVFmTZiFxrsYNbpXV1PRc6GAKm2qrsxuHfCKV2+mhoaPvDLX2CQpkB?=
 =?us-ascii?Q?PrbvQ+N71tS4iD+2c4l9XjwVDG1p4hMvtJLIkssebatbsSH4zbL2rW1BXidK?=
 =?us-ascii?Q?ZSpO1awL1CrrVo8zsFKw93nXfE63KF1O7HN/rMImeKpF+W27XbUZBqQahUSR?=
 =?us-ascii?Q?iQH2CcaUtJZmNsJuE4N+kqu/PqgmI3fbo0I8c6q+t/jpAYFDczysCVPikPSw?=
 =?us-ascii?Q?aFP02rKzWsbsuEps4kfC2dzet5ptbN2lMSfDeCfWV8osztS/h0TlF2gc/Mnz?=
 =?us-ascii?Q?OT82KKALO2E7twOaebrNt08YM8yHdANtT19mjEspzUUfVp8yiEu9yLyYa19f?=
 =?us-ascii?Q?9Cn4w+mxbRMLItzTCxaV+wP3cV5tcBhSTLAOBrFGQMuGvZ3DZfCAdWWH1N3B?=
 =?us-ascii?Q?kz9VQYlQsnyiy28SoPHFfV9w6W00PiZQ7QYnVVna2/soaluuMqTVobyTsMDC?=
 =?us-ascii?Q?NWHrq/kR3gDXjIoRBNuV9MjdialxsQ20OA1z+B4Qou8nktWAsFuxWwJ8y1QY?=
 =?us-ascii?Q?G472kLTa9gcEieUpxF8Odd9b4mnBsB+vLazt0wY9U8wVMlFj3yo7QnQ3ihK0?=
 =?us-ascii?Q?zr3ric7BB1Srfl9yJ0370PO9sBjvIsLN4gXLvynpCtIV5Kap1HQHcP0gBAR6?=
 =?us-ascii?Q?N1gZDEWQUhCnOe39t14xgF4eVVwFuRR1ZegCqTePz6PBz+Ju6vQFZTlBZqtD?=
 =?us-ascii?Q?kU7QDh6otrhUQH4VF7uwFTL9lB8XaQD/tXXmzyBA2tZHrs7Bfe+5jjdaXQx5?=
 =?us-ascii?Q?xvjFKGd3WHLNgqNaY/ErF4NSXzr0ZVuM8VLNBTFdVklDIFIrTBMbuaGJu7F6?=
 =?us-ascii?Q?effO43T9tqosJAGtsMZzDWsj5H2m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+utBqn+a6OjbEFUNtA9yVzn3Cr5svIzAcVNhc9nAvMK6rPj8kRdo2ENdjra1?=
 =?us-ascii?Q?udnCB+V6X0bEPHI2SAHir9DOdZli3Sb4JPihEuMsqvCGA76pKYC0CVKT9cMJ?=
 =?us-ascii?Q?+ZPlSbk7DrvNuJF15K/2xkIbRZWU60Qcpd0zFnQ7f5ZBUzxy/7Cr/BBcVdML?=
 =?us-ascii?Q?AHVI4q0OI/P3kd/uHD1D06U5ODlcSkCyLTkeaxPDaoRudplG352r1qntejbC?=
 =?us-ascii?Q?HfI2bPe+iMNQF3D495aGRCuISgB9+SYbv5GvTzdPOeES+KW7ofmyOQP7l6ri?=
 =?us-ascii?Q?rU1Opp7NjpQjGlt0FsdN4J3wQRwc8AlGLJtktqt/iPi41QOBnJu1kdifh8os?=
 =?us-ascii?Q?qVaMZ0Bi26U4Ma2ZzfOIA5H0EiCs8i1DxObydpkyU7RmfN8x1mhwBto67XeX?=
 =?us-ascii?Q?u6CFZi8NZSN3H5ncg5PM+x+0XYo3ADc20b8cw/nUFOXy5soiwPSanbvJzTfN?=
 =?us-ascii?Q?8Xtw5SX8VhxxusMXNH5757ew/68qKyD8qOlLmw4J6lmc7wJOdIQZSdNMBzXP?=
 =?us-ascii?Q?1ffxeZx579MAQL503PcyObnfYia9hQ7YQoRcXY7Qcy31F0TAeYhOuLWi8kXI?=
 =?us-ascii?Q?s+MGZYoT1O0QNzqZIp33XMly5R3dfsoUom36XAvAP3J24lh7MVBHmhOVvh8g?=
 =?us-ascii?Q?7DDhZkVMBw3VkaUSFmJdh6MHVWOsLWaQyu1nLvYZbmjoaQI+cSMs6Zx5vfDJ?=
 =?us-ascii?Q?FwgsAWGUsOrO6Yv3DopeJDVjH5xPr9lmX/MJCUbqMDux2SPAknF15/x1ZMtE?=
 =?us-ascii?Q?bVa3dP8r3iQKvexFKtWDBxFbDA4HfDTZqWZ/Y4t/pM1jxI4+x0EBYEIEucjx?=
 =?us-ascii?Q?hs2RRalZy8zKNbb9s/hQ9DGyErTrHZQ4Ltsuruiy7/C1tedacqMxAo/ogsCH?=
 =?us-ascii?Q?8U4b+Zi4K4tmeerKbexYhqDMCGFm/cNCMHz2a+aw77vCLhRD/gHmg3F2UaBi?=
 =?us-ascii?Q?juadM+f3haAUVmBCFdMGtlV0V7Y/EISQ51fS0d1mtDJh4zsD2RbwfwmAiYMZ?=
 =?us-ascii?Q?Jfv/TyMsjCWXl/0QFuMMvHekVLggen/+vIt8H7ILH5/H+LACdRuHUcCzfz5I?=
 =?us-ascii?Q?F2K/VG073z5Rln8Ffj1GaNsGpdaJGgaPKoIcGwU3UkGr/bSUPpS1ARIZu8I8?=
 =?us-ascii?Q?WCkYulXzbu5eoOf4w9e6n+YtQ0A10YXuRTjPmyJYQuk6H/hvqTLkZ/4HRCnD?=
 =?us-ascii?Q?csWXWLJRqB4P8+nQjFsyvRZaBWxKcX/ebd3uXWqG/V+p1YSF2odK7bSC1WO7?=
 =?us-ascii?Q?aXi9WXnZ6STxbrG1VzdWjKUKbER7ZQPtrHhTqJ7pVzpf72jqxz4AufR8sEm7?=
 =?us-ascii?Q?u+Mz3jI0LDvjV4XwF/y9uEzltmhkeeZDQzEbWk5aTd7J4U9o+egCW+jJwmhL?=
 =?us-ascii?Q?HHVse6UHKD9+zqk73Gh8q7SUo3/JYraLJrM9NmRAZqXmqklZFMF2V0uytPmi?=
 =?us-ascii?Q?5/NQ5yq8COTLxH5OaZInXj4TjJ7A0ODonljJP8P0XKQjAk1HwZUuNgauxZ7A?=
 =?us-ascii?Q?uLdL0NOUjmARFY3NEhGyUrR+vYe4dLHzUyCAGCt0yw/rcAyYOXdg1Ik8XuzL?=
 =?us-ascii?Q?66VGJT/wLCCK8SMfv/kcGgUYI+GpWbGiuNFEF51p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f95093f-d085-4eda-ad8e-08dcf7bef8c7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 02:11:17.2169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYmqjwN6PBY9NkC15EvlOJsr0OpHTGXKuywFbc2Mqkr+IEL3733hO+GKRiSOz2qi7kQSH5KVH+jhwikGCZCAnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9147

Register m2m platform device, that user can
use M2M feature.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/soc/fsl/fsl_asrc.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 471753276209..677529916dc0 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1384,6 +1384,12 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		goto err_pm_get_sync;
 	}
 
+	ret = fsl_asrc_m2m_init(asrc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to init m2m device %d\n", ret);
+		return ret;
+	}
+
 	return 0;
 
 err_pm_get_sync:
@@ -1396,6 +1402,10 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 
 static void fsl_asrc_remove(struct platform_device *pdev)
 {
+	struct fsl_asrc *asrc = dev_get_drvdata(&pdev->dev);
+
+	fsl_asrc_m2m_exit(asrc);
+
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		fsl_asrc_runtime_suspend(&pdev->dev);
@@ -1497,10 +1507,29 @@ static int fsl_asrc_runtime_suspend(struct device *dev)
 	return 0;
 }
 
+static int fsl_asrc_suspend(struct device *dev)
+{
+	struct fsl_asrc *asrc = dev_get_drvdata(dev);
+	int ret;
+
+	fsl_asrc_m2m_suspend(asrc);
+	ret = pm_runtime_force_suspend(dev);
+	return ret;
+}
+
+static int fsl_asrc_resume(struct device *dev)
+{
+	struct fsl_asrc *asrc = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	fsl_asrc_m2m_resume(asrc);
+	return ret;
+}
+
 static const struct dev_pm_ops fsl_asrc_pm = {
-	SET_RUNTIME_PM_OPS(fsl_asrc_runtime_suspend, fsl_asrc_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
+	RUNTIME_PM_OPS(fsl_asrc_runtime_suspend, fsl_asrc_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(fsl_asrc_suspend, fsl_asrc_resume)
 };
 
 static const struct fsl_asrc_soc_data fsl_asrc_imx35_data = {
@@ -1538,7 +1567,7 @@ static struct platform_driver fsl_asrc_driver = {
 	.driver = {
 		.name = "fsl-asrc",
 		.of_match_table = fsl_asrc_ids,
-		.pm = &fsl_asrc_pm,
+		.pm = pm_ptr(&fsl_asrc_pm),
 	},
 };
 module_platform_driver(fsl_asrc_driver);
-- 
2.34.1


