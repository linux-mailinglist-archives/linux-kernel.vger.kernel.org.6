Return-Path: <linux-kernel+bounces-422266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396F49D96C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7861684A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADD51D3564;
	Tue, 26 Nov 2024 11:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lb4pfG7/"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856BA1D0B82;
	Tue, 26 Nov 2024 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732622123; cv=fail; b=ihbIh6flTAstqf+GTMbAzOwwimHSQKLO++UZk2CEjkqbd4ycJTB5pIW5knyZtmRIzZIGK6biEMYSLCqFVkCxSOnoIi+8B6lfgGsrHYlj7si6prbJTr3Hdgico72zvsrIFSqGAaOujUbhH6dTBLsPoJdx4K+uL6K44aWLzmYsnUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732622123; c=relaxed/simple;
	bh=r9DEGxKf8a/KjVkM+W/wOdoeDj74irsLs8pDmLiwGAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=an/O4/uWAe4kv0kvf/G8FdcmtPBtrQP00NNeIPlI9i30CG9jcCcVuy+SvmP4KQFO3n3vABquLWu1MRdsmV60W0wYFpXSQl17fcKlaGZZ3AAHlHSNLv3h2l44q3h17ttbIWhvb3HuWKJtNcJJs4m7M2s/jO0htBagVugTwSlxrss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lb4pfG7/; arc=fail smtp.client-ip=40.107.247.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyF0jNtX9B7IocbgPV+prFiaDdGHnVmKDYUhqHs4tgqgz6S7qYWhg9xIEtjU4WNLw1aUW0eoMbE8hK5CIfmcS8DUCtO0gYq4+FHQyQpMyxell6cn40Fu6XOi88tHW5FjoVFgHM2OZuejgvXsupqkQsjY7EpkqgnvV82bmy2NLWo/frC38MCRmLYV5+YzAiwUU/HG8Hr7sZkVDmLowAuScJ4aVLaW+y9SGZcbHm8PPKa0oCKQP0tAEA+1d7E9YvgE2zEYFb7Y/hcmHKI2IgyYDp1NX4st/nvTq5+SQOw6Cb8JN6cvq3DvTiCcoo34ZaMPvZNEYc1bg6Fj5MjAM+b81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJFfd4SuEfSSWyBka0cEXifU9TdRzIwtY0KkNpGWjOc=;
 b=GKLkiwWhMFFNPZbK4J5tyLHmm97I4oX6xQglX2iEQkAugU1KUtbhzBDtY2hp5nzrxCTDQjEbLwSHTbO01fJhxLnkHzYr+7jXPDbsTKqHUiaxOekIsBjsAL/eW5U/veXxzHnDAaojw+PHso5IbveDm/lbop5Wwd/21dgirFMC6bJMIT5rXRelwBJiWz+XdA39GZnXm4ZsDhjZzcF77HlpO4Xc5jsq5GlV6S0Cbi6n9hAGFBOVVX6QKnsRu4PupMUH1WQ26+Gwe4fQyulrm88EJN9uVBIgWDXnv7mLQhu6vaf3RVOY66SSy+Bdx9H9rX9KHO8xYpjbieVdDVDIIUYZcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJFfd4SuEfSSWyBka0cEXifU9TdRzIwtY0KkNpGWjOc=;
 b=Lb4pfG7/jCMac8KyapLE4XhoOyZIQ/KXpjQSnyy+uD0W+qyfSrWcyDeFZcNa7HvcY3g65t/hfyAD3BwFAMTS5PiEkSAF5+IUm/I0gHnk2tO4HDs88R3wHaBsYySX7eqFouVLyHMODWYlo3J+Ad5aZ760cIdqeyUC2Z2aWDf7uzZ+h9AHk3kFEBli6me8L41WjbYyT1JFNxSWXV6iQHPO5G8EG4fCeDGlsd5bIqIgMFfcXFkqzPSY222Fma64ip9FOMmJMuFIJM9R474UneBqdkpqymbC7ClIe4szbt0EF48Xx5TkoCv97PE0tg61EBEhlr9UmDuz8H2LZjeTgdMtQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by DU2PR04MB8504.eurprd04.prod.outlook.com (2603:10a6:10:2d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 11:55:20 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::24fa:6f9:8247:c5dc]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::24fa:6f9:8247:c5dc%5]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 11:55:20 +0000
From: Chancel Liu <chancel.liu@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org
Cc: Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH 2/4] ASoC: fsl_micfil: Switch to common sample rate constraint function
Date: Tue, 26 Nov 2024 20:54:38 +0900
Message-ID: <20241126115440.3929061-3-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241126115440.3929061-1-chancel.liu@nxp.com>
References: <20241126115440.3929061-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|DU2PR04MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: e78a6e27-8653-4d45-d74c-08dd0e1133ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lXeEaHSP2YIfvGJGimfvQe0ldxflQN7ODNCRjZGtq/oK/l5yME7NigzG+9FR?=
 =?us-ascii?Q?XmyiCDn392RnXCc6snssqaCRsWxbRWCKrIosaaN8/ZzEGM3FBvKVyKfIgdww?=
 =?us-ascii?Q?q/suDXPllXhUZHRvhsEmB7OswSlmA6V/aKk4djFtgj1yN6Rsfomd9t+tX8rj?=
 =?us-ascii?Q?+LXvULwivlEc10k6OOADrIIl+14uSNMRu5Gg+1xN+++FQKzbZXbfTb8bWeFH?=
 =?us-ascii?Q?np+Wc0XKZyMDe5BhLL/92swJm0K8bwispZbbjMtNCd37Z6e+lpCvZBYJuqLO?=
 =?us-ascii?Q?xuJpS0qGZc/LAA1oscyNqKZikFq3xenGPUEoYrOwh3W9zBNCgYUYTmI9YIA/?=
 =?us-ascii?Q?vZLo8BG/XOA3FG/JqQxI/lZ09m5ucWy4On6FVxT7d94n02s8l0OctZ1f5pJU?=
 =?us-ascii?Q?UDp66YCyUVWCKrUebMGupCU4kC3AZusPo7y8PFeBEL99ljsTCgFiBhVPFg6O?=
 =?us-ascii?Q?KuO+9WhzAfltCt4cKywCeJwTZPoXSXQhrHVIItat1sALkRtSpN206CbWr/Zs?=
 =?us-ascii?Q?J4V2sFMbiDFN3t0ktRKJdhCAHPYbUDP4GEoiH0B3zc8Z2CudETSWcIIr/iQK?=
 =?us-ascii?Q?DaY/MmBVn7tMCq+bQqxtZs7QUnVfsrVtgqZF/Pdz+hwnKhWSd9aqP+wru2/U?=
 =?us-ascii?Q?QxjiKGdjW40LB45HTN5h+qmIRTU5QJZRvDwx71cYp+ulltGDSwFCc5YBiheD?=
 =?us-ascii?Q?ipbV28JSkhsNMYv+yZrLjCNO8TI2yQ9U0nvpPFSA26x+Z6ZzMq1pLg7KAgvz?=
 =?us-ascii?Q?UToCuPiNELtblGCFwkK8Mx0+8ONHt7dSHgm5Dt/2fyjx+oGqupuYH9Ut3VEa?=
 =?us-ascii?Q?NebRZqwznLZ+TVd0kIkgTQhVlDpoKCi1upoJSMyv+3v0N+wRyzng2KKGoowX?=
 =?us-ascii?Q?686MqTa7giNFMIa4J0brKZbZHuf1vCxYSYYsdt8wi3su0yWcKsHIlL4AYP8q?=
 =?us-ascii?Q?+YCjrlhAiU5aJ5EYxxpR8DsYw8aXHyfi3RCWQ665lc0vmyrYA+O1+lW7UJcM?=
 =?us-ascii?Q?LAiRxdBwlmrc2MM4BJaJaN7S0SbUDh3awAGfpbNCllf3EPeYSYIZjqSDy4XH?=
 =?us-ascii?Q?VGaarcYccU4ELrbAo7LJ7XJfXISM+7IghB/r3f1bT/dXSDLoLyr5czpgnjYC?=
 =?us-ascii?Q?bcqrRMn/N5Evj2wbpA3sYUSusH3Pc5y4NL3lu7eLKaKCP7cIyPrhnfNZstOI?=
 =?us-ascii?Q?EsPVD470luzposvJ6LHlxMvl2cVvMCXb0GyY1CNvNRkmpRjxtkYxCvYgXvhB?=
 =?us-ascii?Q?udnFIVDOAL6OEMP5sNPFB/YzMiTTEpyKNvQMCwg4dfAw4/Pso0YqAN1M5kYl?=
 =?us-ascii?Q?iaShQxFUHUW8x0CDyZgLTtyyvLeHvXBkgeQK9I2lnPeSqi99eKD1FykCjhUQ?=
 =?us-ascii?Q?DoDMr3Gw3KASJvL+OfYYqDQC41DwKlr990pJI3jYxkEpRW2P0DnUT3O6n8mm?=
 =?us-ascii?Q?QMI1k+aEAnU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qs7Xb3RczoSG+xOybyBPPOCr05BO5xm//lcqprhu8NaciDEMLg2PCu0JqicU?=
 =?us-ascii?Q?W0Wc/R3czve5It8iARbKaVz2Wv17EsAKZRXFBnFZGcpFAQhQC7MvdKVdZgNn?=
 =?us-ascii?Q?3KGVNslPQJMlN9xdc7rJvVy8V1K8gWPrGk/cwrtDLXvzk0V4a7hwBVkfZUUL?=
 =?us-ascii?Q?6Ei3ynpxAzb+SUXIzfYeqsaW7XEMjNgQWyk16FCyGyv9Q/zDiPGRQ92n314Z?=
 =?us-ascii?Q?sDFlBTuaD2vmR5nBYB+jancvnIOK4qiViC9ocarwmeFEE+WtcEIW6f1h5hQv?=
 =?us-ascii?Q?J2+MSJpREYtLhFphGpCVgS71uorqlt4FlcuOM5yif7eLHQ5KO1j+EX95nYIw?=
 =?us-ascii?Q?TxyJwPa7Gm3eK5IEMIxNXfD3krk25eessf5lkEGdEWYpc+6AkUsAeSOx7TYp?=
 =?us-ascii?Q?UMuJDGVzghyE+JjgF9K7tZVTVVToHXaHI6XqB6Ubslu7ql1hd2l5jxYqnEfY?=
 =?us-ascii?Q?s43zYwnEJ0oBfxnnLg6Gn2QMigGRN1GLCnP2BNS4bwSY4WcGnFVrLhLI88Em?=
 =?us-ascii?Q?gFuhzhlTeaFz/b5fUjsC1DMAI0w9dSdc9Pb2gcKRycSagOZIR5Y3D3RYLT3v?=
 =?us-ascii?Q?4Da4XM6WkXLART81nZLilaWI5b55RpaZZmqTyD5oULLNjctlEMwHeDevIuQP?=
 =?us-ascii?Q?Zek0yXbScQTvTGF+HmsLGNP71oaBhXYkLibA2IrFBWvvYyOrFQhyptOuP8UD?=
 =?us-ascii?Q?/C5QgXcs4nlRrXCL/EK+RHYIYRYjiZuW+a3sfZ/Fk1Zb182DlF1Z9TQv2KVY?=
 =?us-ascii?Q?2Cgl+5/QMclfn+KwtCqu1Pkrlr1cWazY9gW58a/CJswebjDkmrH6uQT7XlP0?=
 =?us-ascii?Q?qjR9l2anHxt342XmT54vrwT1L6xwmXNsr9Ea8r1TWOd9uYN4a1kSnFwrnlNm?=
 =?us-ascii?Q?NuK0z6YuDVXcuLNImaFHkl0xiTHa6C+7FAGuo/GGo6WQ2g3onM0GHe1jU24E?=
 =?us-ascii?Q?sNfXc7uk/EZN7kTEIq7ewOGS32UCBQVb9DpjXsShWoS6Peb62++dO6DBSFx3?=
 =?us-ascii?Q?wudpmTLCFZJGXV2c5KDCmjBUaIihg4An4S0hkX9nKEl2GYmoeF90J7gzfFcL?=
 =?us-ascii?Q?9DGmy0A0k2SPsQpGy7AV6NQ9DoedqJ2edBeg8Ftteq+5bUQCuY/p308On8B7?=
 =?us-ascii?Q?Tc9+nSsQ0UrItBwsI93WIAtNZVqK+06IntFbRcOInSlf0X+dDA5sgs/bJnGe?=
 =?us-ascii?Q?XhUbd9UVd0d7FjEpoy7wg2tlAXioXWy2cH6YCaqT0NqePzopV34PIgxuL8F8?=
 =?us-ascii?Q?hEUhCyFTegIiNPCOqxtDnRKEhb9tgaQpbJ7dDQ5J4gw6cXZTB41IALwk/Bmt?=
 =?us-ascii?Q?4Vz1rPUkyY3pdJEPazKcWqEfzD7UZAbE7/BkhZFW3NgGrRTZu7Htcsjy5GL4?=
 =?us-ascii?Q?fXca8K0lgySsK52ADZ0nHK92IAYVo7Kv3mo6EM6v9NF2a/82IXIJHyjd1uHd?=
 =?us-ascii?Q?GHk/J+DnXvKMFLh0marMXMa3sOEpDUXgeMU25A4SX0IfbQ+FH+VC5KAoZZ8o?=
 =?us-ascii?Q?cqYuTXrWr+HTNe/tdeQrEJJBnGlC55aeIq3zvVgJUWXkjmpyZhr9QPAVgY/y?=
 =?us-ascii?Q?+o/M0SGLv1lbNYQjPbEOGcpeGXhL/jmrC1iG1eku?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78a6e27-8653-4d45-d74c-08dd0e1133ca
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 11:55:20.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amQgUvnli7JSr7z9y0UQxrPYgntRhMuEyHqAjwCw7egaPV2gWHLN4ek4JjuGHfCqo0PDQ0qS57At0L7tE1f19A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8504

fsl_asoc_constrain_rates() is a common function to constrain rates.
Let's switch to this function.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 8c15389c9a04..e908cfb594ab 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -35,6 +35,15 @@
 #define MICFIL_AUDIO_PLL2	1
 #define MICFIL_CLK_EXT3		2
 
+static const unsigned int fsl_micfil_rates[] = {
+	8000, 11025, 16000, 22050, 32000, 44100, 48000,
+};
+
+static const struct snd_pcm_hw_constraint_list fsl_micfil_rate_constraints = {
+	.count = ARRAY_SIZE(fsl_micfil_rates),
+	.list = fsl_micfil_rates,
+};
+
 enum quality {
 	QUALITY_HIGH,
 	QUALITY_MEDIUM,
@@ -486,29 +495,12 @@ static int fsl_micfil_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
 	struct fsl_micfil *micfil = snd_soc_dai_get_drvdata(dai);
-	unsigned int rates[MICFIL_NUM_RATES] = {8000, 11025, 16000, 22050, 32000, 44100, 48000};
-	int i, j, k = 0;
-	u64 clk_rate;
 
 	if (!micfil) {
 		dev_err(dai->dev, "micfil dai priv_data not set\n");
 		return -EINVAL;
 	}
 
-	micfil->constraint_rates.list = micfil->constraint_rates_list;
-	micfil->constraint_rates.count = 0;
-
-	for (j = 0; j < MICFIL_NUM_RATES; j++) {
-		for (i = 0; i < MICFIL_CLK_SRC_NUM; i++) {
-			clk_rate = clk_get_rate(micfil->clk_src[i]);
-			if (clk_rate != 0 && do_div(clk_rate, rates[j]) == 0) {
-				micfil->constraint_rates_list[k++] = rates[j];
-				micfil->constraint_rates.count++;
-				break;
-			}
-		}
-	}
-
 	if (micfil->constraint_rates.count > 0)
 		snd_pcm_hw_constraint_list(substream->runtime, 0,
 					   SNDRV_PCM_HW_PARAM_RATE,
@@ -1239,6 +1231,13 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 	if (IS_ERR(micfil->clk_src[MICFIL_CLK_EXT3]))
 		micfil->clk_src[MICFIL_CLK_EXT3] = NULL;
 
+	fsl_asoc_constrain_rates(&micfil->constraint_rates,
+				 &fsl_micfil_rate_constraints,
+				 micfil->clk_src[MICFIL_AUDIO_PLL1],
+				 micfil->clk_src[MICFIL_AUDIO_PLL2],
+				 micfil->clk_src[MICFIL_CLK_EXT3],
+				 micfil->constraint_rates_list);
+
 	/* init regmap */
 	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(regs))
-- 
2.46.2


