Return-Path: <linux-kernel+bounces-512376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FEAA33870
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAC03A8CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD43207A3D;
	Thu, 13 Feb 2025 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V5QC1ubp"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE8C205ACF;
	Thu, 13 Feb 2025 07:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739430262; cv=fail; b=RG3JdUMsuhr/eDcv/mIAMnFDNmIgbk1JMWPoO7q/dBcCusa1VjqYRwEgVIcmEkkYSNv9vZ38cBrCsjNIw9n9X/fk4PFa7fC9h5fnsgOTJAEpHZWtuKJUxxF/Q5Yq97Endwn92Y2fCkiAxPAffLmcAQQ9IoAONADXf+y86K78rDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739430262; c=relaxed/simple;
	bh=VLf6PN+ZK1p8GJSJLSwEqBz/nDXdKXi3UxmHxtF2WrY=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nnoLpOn6NJWFak5c5Pzgf5M0zjHqLP5KRvCltc0i2YHcNUlRyX7mxtjB7oty6rhzI90+0qb3idNMhT5UozWn6Yq6YOUZb+iJ7GOEro0VAMuHqVL8sbrwaRnZKxDcNhuf5yr8RYAh8kwzq6T6CCfnE50HpS+zRgRWEyHmUn2HyfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V5QC1ubp; arc=fail smtp.client-ip=40.107.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opZuD1m5O5HzzDMio00aTFeGK31l+h5x8UR/zav+lCkj/UwslqSjLHZ9fC8PyculyGaUHdz4uZUrimBVc9XztueLPcoeex34p4Gi/xVk4MsuTzAaOgS0QqX/sb/uXM6CgT2CQPTneLqnN7APHPG18hzMZF7QdSTxAWlcammH4W6FirF37gnQoFcKY/jazU0cN4QLRSLnXyIMb79nXH5NrCO354DArrKEtJJg5iUPWwmjFaVSjPAIhilZ8bQdctXpEvzXwYp1WTBolGm83TBsPCetT+90FlJAvt9zvYZ87qik7gho2OUArvP5+rMLkijnzOtfFEjLQVe/+atHQ+vlZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6y+kXGuLjQ6dRaqKwxAew/44MG70QD7gS8mE5NyLKs=;
 b=b6k51SXwO7I5sxl2IpVejOMtnAXhyGagWJoovZbr6v2mkRSsK2to8NpqZZKoaBFwNLtMNWOURrGEU2JvOHOyFc5DU35RPbZk+3ND2CS/zsTIddS1UogLl6kjaxCZJfW7YggU5KgK2FRH5tK6RD43V+ykigUDkl3o/2ylT5KKAhoNQa54HLfcZs72E36kx39jBmnTUI4RZwuL+vGKOL97eTle0142saL5ev5Zo2r3Bxkzn9Q+mi0rU0cJh+PqRQWfEHhV02J2Z/EEuKQrx+CqT/s5SSfO2ArNMSGiXP2bj1o8UeXqdumMIRA9aWevfHtcuigjwRHwJcfA27euOwwyOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6y+kXGuLjQ6dRaqKwxAew/44MG70QD7gS8mE5NyLKs=;
 b=V5QC1ubp+2bSthIop1QIo2J2VvQI/YB6S45FBCFKiAg+15cw9BIuzNfHiLmRl+tB3rcXldJI6CIRvnPdLMYjuQs40Uk//Y43fNdkTBMYAiekG7PWdhEyXmj61Jlcw+QYrhPgsnnkJvqNq5SEp/Priew5P+K3upPbF1NieenwKe6ktiXUMvVBi84/x1DuRNwhsoennJYwvxfTdSARYFyenIkdoSh+knIx8p6vW9BkXesz+Sp7nDbaUbC0O050qcueA7EaKg4ODknCPSd7DxppPtdPUCH4GaHwFwmbfDZsXT99d7zMX1k1RLbqRf8+6QxUMWPqUUMi1tF0xyfSthT0Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PA1PR04MB10674.eurprd04.prod.outlook.com (2603:10a6:102:483::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Thu, 13 Feb
 2025 07:04:15 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%3]) with mapi id 15.20.8445.011; Thu, 13 Feb 2025
 07:04:15 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: imx-audmix: remove cpu_mclk which is from cpu dai device
Date: Thu, 13 Feb 2025 15:05:18 +0800
Message-Id: <20250213070518.547375-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PA1PR04MB10674:EE_
X-MS-Office365-Filtering-Correlation-Id: 439f8864-86b4-4809-1180-08dd4bfca095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FJkBRXTBycbsPUCwgzwbL+489Q+VXvThl5hPAr+GJpYMfVjAQb1vzTCNnhZA?=
 =?us-ascii?Q?LgPlrTMZ5K1cWPv3nU3X0OkkZt+fZTO+fdawxZPBdQLtSSaJuBMEQLdCrYrs?=
 =?us-ascii?Q?siy95+jRQHghEvFTvzHKcM5WFPdj7W1aPP+bVX0wQjkACdTiODNM74wm5+ZA?=
 =?us-ascii?Q?AJCTukC7P7EYNrq9E3iD+y/QQc66LE4XKgtZ7ClIxsCMA7mTOAek39MoQ4LD?=
 =?us-ascii?Q?4aveQhB8y0HeDoDEDQn2eAldJvMaoP0LG6rRMrB4LjcGhV4xm4OsAhEhcE7L?=
 =?us-ascii?Q?liaR6nxmwFc81Cde9WZEWK7H6hND+wSPV5/9JpkTVyRB4RC0MMOhSBmDdULQ?=
 =?us-ascii?Q?zma33l4adQBJPU5DONJWZzesBP+VinWWoIL27SgSrl/blIjMKwNwzH3bMZiS?=
 =?us-ascii?Q?ondOVxh0bpLup8aU1/7DxS1gx5rYRSswoTzq4LS0i4NOi9s9FsDdFg03CvW1?=
 =?us-ascii?Q?M/TRTcl/GPE83nwdSXnNX6OY6brq0WsBg8N2leo7FOXzSDFyUHxo13HfBxSn?=
 =?us-ascii?Q?97KpmnR4VNUqwHIkZM0TRNIFr9sa/8WIBeMM6eJzKn2o73+5C5stSRnD2Y++?=
 =?us-ascii?Q?w25HmrDDFrrabtgxOXOHA2XHn5JmX9HlKQoZ7j1ek0vOz93Cl/xxCQM8BnUU?=
 =?us-ascii?Q?qmS/rAPKpP6aoX8lFePXos6mp+tAqyvO0qQh7RR3ApztPBvq+V8DHbCS0FkB?=
 =?us-ascii?Q?I7z1Ze67I7ROy8+qXibQ5lPDF0hWHU8thXGvMCIhMqU3fBt9xY4WMbueBR6O?=
 =?us-ascii?Q?ayZPLkKbGrD21LC75BiGhdqKwdLuq2Iro/7sHoqwRoqoed8lvtz/hbpCsmf6?=
 =?us-ascii?Q?4r8sFoepn+V+u5kYCroJiryNLbCdEUaZ2bAD1PGCJARQ+rrY7YvqbTAVJQJQ?=
 =?us-ascii?Q?3bfVtu7fQrdZRWTWs0PeX1iga3q8fe/605tg0EGI5lDtEgLM92GiHhA10Gyj?=
 =?us-ascii?Q?jYIzPkqkHCon5MIKD3It0+eMg9RG5y4jz2F/g53m2sLRrORWaP1GdUXBWZe0?=
 =?us-ascii?Q?aKdJMTCd/Xx+WO8wSZ28J9K6uVn2/GZesFcIzdXSHvOaqr1EpFMcMEYAfQhc?=
 =?us-ascii?Q?JmZXuuhvN8dki+MJLPJ0OAf/CrsfaqI6t+mNMGFiz09M55XDwX8ge42+RYO+?=
 =?us-ascii?Q?Nacj/v68FZ1MOPniOiT1nN0MRgXuLJ5HEiwB/BKLisO6DsHW2/DrHULeypwU?=
 =?us-ascii?Q?N6VY2Ctm/nQNFLY70NuzcOtDWyl6y9vR1MmfjW9OynZ+0hjrFDXvoLUrq5Dy?=
 =?us-ascii?Q?ma3G+GuxSUsITkPFlmDW/zyRWsSm8G21Va91zB3ToyawbJaebsugqLbHieKA?=
 =?us-ascii?Q?anAh4kBJ78AJVqSYEpoI6P0NaZ510sPiFSdA8p7QMhxsKweHAbfnfmWMUcVP?=
 =?us-ascii?Q?edSdDOO414VYoPI1jQP40vD8Irgavj4e0+eYwYim81Q7WMqAX9g520xt3U+8?=
 =?us-ascii?Q?hYaf/82FnS7G8t3LPk/bct1k6r/HmF+RHQFCywfqMK5k1FU6bDoIeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yyfJL+u0tIEDPEtF1/7xJ7L8ji3kMYooOoyuHZ0zwZlW3jVWKhfybXcu9Jvz?=
 =?us-ascii?Q?5oqpmD1jMj3Vf81lC/C+XSKoXzTcAXY/to9SeOO2TQFHXaQ9IKvqvrQ+ttKc?=
 =?us-ascii?Q?1kGdwRMTOBuK4d9GMzDF3HsiZgihHLW+qY3xFFXpZkLvsBc4V7pllg/Mfn1H?=
 =?us-ascii?Q?CjCsMGtPUynZPPgymDx19xTWeKni7ZYe2CWLNUwLWi5rT+3exGQI4FSL6OQg?=
 =?us-ascii?Q?hYajBJepcFZyDdHKmimwtkvlyFQMZSUDBATeyN5zsthU5Gt9l8IIFVPfa3FX?=
 =?us-ascii?Q?PHVoJXfGA/kgUjumHJFNvnn3p2Ym+6u3kKnu9uC1eWnDvlqxRjLK59VOS4mM?=
 =?us-ascii?Q?BC117qpA0ryEitN/P6GB5OhnbiDY7j0MWVF8hbpEURuN06h787J74Df47tKh?=
 =?us-ascii?Q?7gTAhENMihOBwKbcYLoCksx6GvPu7PnXbj+d5TiwYxaltuYZ1NBOVu3eGBiZ?=
 =?us-ascii?Q?AuFhMojVHPqplXcRfNmxiJGnaV9fFNK6ZqnpXBsRpvfDGdFb33kocAOF3YLC?=
 =?us-ascii?Q?g6dkjUA6zLDJ7psTCRSrvLSQw41JJZ3uTmgN1D55O7y655GMQzCKL+KSBJgT?=
 =?us-ascii?Q?au9rcOTbXpko+3izPxmi1jZRAt2A7n56Im7kAmIjArEWPR7Gc7i1LKI/FUMD?=
 =?us-ascii?Q?bF8QIFakjO+H3ywf+w75vT0oo3FZfYHGAWxJmrT6dO44SaOnfZqEVOVkg5nO?=
 =?us-ascii?Q?lIZuhrvsIPNCCd2t0cKadC2gkt/UpaTPOjoMpB+HlJKNBnxcDH/BybDMEVZ/?=
 =?us-ascii?Q?AU3uo3q0mNv4Segi2jCTLBxgVtZBF87JGsRzKgyD56sB67FXA7FKd8zdw/st?=
 =?us-ascii?Q?sQ8PU/411PAUtjpKEKQUJK7B3aJD63MBiqDwyhbFX27vT8DM7nDKhtWyQN1n?=
 =?us-ascii?Q?pEtMAX1/juwZ+ehkJIPlEMh6n1p5/LLm3dCv3BZeTT7ef4vh2LwLpREY4IvI?=
 =?us-ascii?Q?gOI8rnQPIfsquw/Br9tWY7G5uNiaSKS1yNWSWyQnKYyZcTHi0mKRjtlI4zi6?=
 =?us-ascii?Q?SNGyUdUqSsswxopx3mnwxL5ukujZCSRvtz/HCYK7Bj2IgtiQQPmXBzF56d/Q?=
 =?us-ascii?Q?NJeH9ls9Gi/6MMJ5il+bGCVFLSOBBDNObYqXBbuvAkD6i0plscOMIUaxVL7t?=
 =?us-ascii?Q?LG9xGcqFcNBek9fzHILR5F0LLmVI3+iqyceXypUjUjVqePEuKKeUi6QMtDiU?=
 =?us-ascii?Q?EXfgWZ9bBQj0FXAz5LLvGkFqYPG5Y9EkL3zbGUZyHhnU95DJJbuT5UK0Voyk?=
 =?us-ascii?Q?2r3rB1QuVILid0HOUkP3qRAhCnmCbGG1kRv/gR8imtIOgcXOPDMd2ZWy6/Jz?=
 =?us-ascii?Q?u4aqQVJ9x9xzlekE+iNU38ptaCPdRv6CkObuJSLxkkHcm18AqInWEnsZYvum?=
 =?us-ascii?Q?vcAjklKqXHacv0RAgm4sEn/KxGb7lKouRRZn/oZdnJw8zsyvwnbMtw/jPTIs?=
 =?us-ascii?Q?N0zTkznMT5U97hLWhWQnmntolVT8DHfrKXfQXEyP3Cu1VL+HpHDLcbYxvwr6?=
 =?us-ascii?Q?JvVrZx363tj3+8wwYabGI+8Ggsn1x3iH8VxRysO2PgoI4wFAX/tEBu3OyQ77?=
 =?us-ascii?Q?B7DA5zetIxz4gkA+/dGyZSuNdRIeVINK1/eNiMUh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439f8864-86b4-4809-1180-08dd4bfca095
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 07:04:15.6479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIWTtKyyWb30+yQt8b3NxYzzVyGAyb1jAIJmfIxfGJL9ydoEZSiRHbaOMZksiT9fmT5/e+hRkJ5y5AGEO/YscQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10674

When defer probe happens, there may be below error:

platform 59820000.sai: Resources present before probing

The cpu_mclk clock is from the cpu dai device, if it is not released,
then the cpu dai device probe will fail for the second time.

The cpu_mclk is used to get rate for rate constraint, rate constraint
may be specific for each platform, which is not necessary for machine
driver, so remove it.

Fixes: b86ef5367761 ("ASoC: fsl: Add Audio Mixer machine driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2:
- remove cpu_mclk and related constraint setting

 sound/soc/fsl/imx-audmix.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index 231400661c90..50ecc5f51100 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -23,7 +23,6 @@ struct imx_audmix {
 	struct snd_soc_card card;
 	struct platform_device *audmix_pdev;
 	struct platform_device *out_pdev;
-	struct clk *cpu_mclk;
 	int num_dai;
 	struct snd_soc_dai_link *dai;
 	int num_dai_conf;
@@ -32,34 +31,11 @@ struct imx_audmix {
 	struct snd_soc_dapm_route *dapm_routes;
 };
 
-static const u32 imx_audmix_rates[] = {
-	8000, 12000, 16000, 24000, 32000, 48000, 64000, 96000,
-};
-
-static const struct snd_pcm_hw_constraint_list imx_audmix_rate_constraints = {
-	.count = ARRAY_SIZE(imx_audmix_rates),
-	.list = imx_audmix_rates,
-};
-
 static int imx_audmix_fe_startup(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-	struct imx_audmix *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct device *dev = rtd->card->dev;
-	unsigned long clk_rate = clk_get_rate(priv->cpu_mclk);
 	int ret;
 
-	if (clk_rate % 24576000 == 0) {
-		ret = snd_pcm_hw_constraint_list(runtime, 0,
-						 SNDRV_PCM_HW_PARAM_RATE,
-						 &imx_audmix_rate_constraints);
-		if (ret < 0)
-			return ret;
-	} else {
-		dev_warn(dev, "mclk may be not supported %lu\n", clk_rate);
-	}
-
 	ret = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_CHANNELS,
 					   1, 8);
 	if (ret < 0)
@@ -323,13 +299,6 @@ static int imx_audmix_probe(struct platform_device *pdev)
 	}
 	put_device(&cpu_pdev->dev);
 
-	priv->cpu_mclk = devm_clk_get(&cpu_pdev->dev, "mclk1");
-	if (IS_ERR(priv->cpu_mclk)) {
-		ret = PTR_ERR(priv->cpu_mclk);
-		dev_err(&cpu_pdev->dev, "failed to get DAI mclk1: %d\n", ret);
-		return ret;
-	}
-
 	priv->audmix_pdev = audmix_pdev;
 	priv->out_pdev  = cpu_pdev;
 
-- 
2.34.1


