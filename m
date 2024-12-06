Return-Path: <linux-kernel+bounces-434956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1FA9E6D6D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB2F280E67
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829201FECC6;
	Fri,  6 Dec 2024 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eBxguAgB"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2072.outbound.protection.outlook.com [40.107.241.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA9A1FA246
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484555; cv=fail; b=Fq/ye7/mtJPO6n2iaFly33styOkRvMxicFwXupCHjERmcFYAk8fCU8XCSfCHxfIxVn9V6UlLpIghCr9SaHd0OZWl9qtqheT93SmufkWXyC9wOry9GXL6F80crwEagykcJHMZwlF6nTWoaNMTXsgwtts/CmG8OPb4nDSmj9sy/3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484555; c=relaxed/simple;
	bh=Ks1UyW23PhOP76h+Gp6Iq+OG+iTIYnyNYV4CMGgCVL0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Vr3P+c57ZE2y3sXj6UFECKeN68LLsPfcNpvyahNVibnveXsEWDD46U3HMtBHiF/u+ukKjleXas/W3044vT9AN46JuB2ETgjT/A/pi060kCSPMkME2pDD4f9pajo32ybsDdBo1VGmEphPS3eMLFfEJfpGWcdtvVd9XQu8MBzyJ58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eBxguAgB; arc=fail smtp.client-ip=40.107.241.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFLjZmVr7ssxwNTNka5vp+fgKix9KY/vssot6gB8LqYZDbAREIRAyV7xHi0f+LMG2vCLKTqJ669oUHPLrtAgs0OX+E5Dt2R4fB8RjYjpk2jCQTeNATaiZbbICWQjSUlrEedsua/PaSXO20gpsQd85qVZ0E3d+WSvkYQvJfAWpm83xTLf2m6Ru5yTIhPZyhNk3WSFwNYVFjKowH1s0ooOmPr67eXjD04DF4Yg9fQ9RTbywbGNMg3PFCoCcfXdf/33yph+0U5b8naSWrQKaCWaF6Ymv1nXsbLKyvubRh5yh2t4TsZlkSZHEqhqbkgu/sKhGETZxTQiRc/j4mVpjF28Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6B11cyy9XOQqKXU7wxLVjDeaKeFpE/yHLm4/QVpIxuY=;
 b=YlGN2FPPQO55bmS0k3QOyv3F3rIk7E1Itd+5+X35TA+M3eA8sr5d1Adko5GHKLUKB+6nZ/nqirWwxNLsqhluKcMY2b6sXgnqEfN6mRJKclC6T5gPn/DT7WFoG+oMxRaER6sFiL3AgzsctHCu7YEcc2xgssRqQzKIrW7jrIz9hpcMRd79ykLp7uloLP12wHXJ9m+3NocgyIUXNnBPtgIzqXhAyOGxRHBc1j1ZVXH18ejXm4E5bZ613R+XCRiVC47G90NB59ch3qcJrigXUeeXcZZ6WCwHZHAQm/9ibQLTT789lx8/5VtCJMPPpgL4HyTtyTj1qXD+n5RVxilVKT+FWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6B11cyy9XOQqKXU7wxLVjDeaKeFpE/yHLm4/QVpIxuY=;
 b=eBxguAgBsJmDmYetG5SeQQh/dEatQiIRhDjNgtTLBL51ZKpdsWSaUHaJ91Dc4GoP/BPm009xLbdIInIrPIaPxVkA1V4hahZZFTEFtpYgPzISrC6oMILjKfD8aD+Vzub6JrU4OP03GxoEWW9NtzEOXlW2RFQC2EJBd7MmqId41tl35HeBUJpTCuQjZP5ULFl1hmTU0CrAkJh+3YCjFnk0IaBGBAkAsbGJsvM2M8VVNpH8KHQIwou9KLoKRRjnS9CM7yqkHEQD1RVEmR4AowucyNr5Bmx2XoVKJB+rU75kQtMEfJkTP0n5lkh7etX2kqkaCIHllPKAcz+e7gIlPvkOXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10273.eurprd04.prod.outlook.com (2603:10a6:150:1a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 11:29:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 11:29:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	marex@denx.de,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] soc: imx8m: Add remove function
Date: Fri,  6 Dec 2024 19:28:43 +0800
Message-Id: <20241206112843.98720-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10273:EE_
X-MS-Office365-Filtering-Correlation-Id: dd550ae6-99af-4fa6-0d40-08dd15e93397
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0dlx6Rs8c4BmptqcyhkYzQJoAcR84tHy7JKz1ow7ms2rZnPNHF7DM9dPnoEu?=
 =?us-ascii?Q?+NinrLmwrf1w65MM8bIJziLmdqdzWB8h0TXtsjXFJSYrznYYY1gIggzLgA+S?=
 =?us-ascii?Q?Fo42+IDRZ9w13a2BWlilr7v5tdhuduvNUCvEwRSJm7PBUrGMRZQ/PkxfnMcN?=
 =?us-ascii?Q?iru9I3lqyOdDKJy9k/mi0geQru+0IQ4QESayBRdeFGZBhv+68U7bfLJCnq9f?=
 =?us-ascii?Q?qDhgedhC79UfVspcME87R+RAHc2rkbCSya/BOrjkggPgP0N2NhUT59UZYMPz?=
 =?us-ascii?Q?dJY8haEXI0oNhjP+oED8w/LZeFsQsAglmXYtSDMrWcR3oAE5hVQIQkHLMToG?=
 =?us-ascii?Q?cTmddomgDqPyH9jqrPrch+dd1pRMAw1CQOukPTcrkcphcsLMFhyquTj/QDIY?=
 =?us-ascii?Q?xGnZHbArkaQ2nLUYV/H4bUQ97xVMuoDCjsVuYA4WZs4m20d24RBZWkBt89Xv?=
 =?us-ascii?Q?A/oUDSBKg5m5GbKyTOqZ4OV58N7LmNsJmmeclfcEodR3plsWFO4pmGtSpP/7?=
 =?us-ascii?Q?T5pFG+SJZ2+ZP3D3I1c+k1pNDPV1VRHCQiImLn+9Ue9hOV0eW8b2bgGJE6/r?=
 =?us-ascii?Q?btuozoChqwokbevCbds52yKYyWny9cpA8fbauKdBQgNoSC3qHVVMZY6xxQq4?=
 =?us-ascii?Q?uc5WXbfIwIgmwSgAEONHzk5O1YXu8LE3kNM/5phjTan1+Ok7WXK8eHgokwL9?=
 =?us-ascii?Q?fIsOxGtigjGVosMq9KYT6CCXxX2fTUagLGu6XgctP+jUwkpLb1jTCzLb5Thb?=
 =?us-ascii?Q?5btpV7xiUEw65sj+XHFAfru0uunrGlkIs0ZeMYw6gRPtUxeTevYbdImjddSm?=
 =?us-ascii?Q?xSmPIL+3M1g4NgdxA4LJgoE9BrzbFEO1hK1R+xCFGFFI6vr8/5rBt1AIabub?=
 =?us-ascii?Q?EcY0Rg+ETTjQ7kcKhySX24ol5+/UExn89gdxx+HCdwVV48pY3INfzERT6JmH?=
 =?us-ascii?Q?ibheVZkMV1K2ZGuCeE8AQbXXv0qaZIffCjdXI2P6fjPPZd6Zs1Rtg4cqaCtp?=
 =?us-ascii?Q?OZpq7F95FzUbVWwZPeoCfyoRInFgr3CslnkCCKxNnfupLjIh1PSJOA3vohyI?=
 =?us-ascii?Q?Kewk1Uqb5TjbAYcq7CyQ0z++Pa5vb1y85CKdVmDsfxU1pRIprrlVRIegap6y?=
 =?us-ascii?Q?WNtEy6mi21lU3zFFl1ihhAh8t1RVlQz0KMUy/MNWYon26y++nzZ7JvnjyPcG?=
 =?us-ascii?Q?REkr6dpdv40dl1y+aYOz2MUSNaJR+rmwBhPmE0mDRxApuXusQz+LbXIude2G?=
 =?us-ascii?Q?f95ItqLgdrIimfQ9XrWSb4XiLlp7NOVe0GCJkW0eDMvhYAfqWlqVVYPwWN2l?=
 =?us-ascii?Q?Q7MTx2m2qNa2rTZ7IvdFy9NvYQ4+MivXgWfz9Ekn/gTIPV+1ZY1MCLfwBRFp?=
 =?us-ascii?Q?QACwiXGnVbaTstRWkwvgq/Z2z6X9/KU4wZoe0AaO0lruBdM/Bw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?55jawkQEF/9NO68e4GUsisO7nY++P033h6vSu5bfv1sinbEwykitBPtMUwZB?=
 =?us-ascii?Q?JV9VEc116cKeAug6mlPSMZaXSF8yyDzlJegDTq9PduNjBCGsWnPYEwmnQli/?=
 =?us-ascii?Q?ZehRmafDDks5IeXmBx0WVmoxkZWqN4ayhLu6o46vOUCT9G2m7/zDsJ8xV4Q0?=
 =?us-ascii?Q?AxbzRtl+nrVUz6pIwrVMC5BP7wfIIz8FgQ/z6LVFYF6cDQRyu9+Wrv/VrQA0?=
 =?us-ascii?Q?SAZo1q7loqPBc2Yd2QZgmrHVBiIZR8oQYnd74bHsYA6Pj8W8SWTsmi68i5jb?=
 =?us-ascii?Q?0VR4rhoRYxZSLd8iXmoK7z9vPVTaULc5TQ7wDaGVVAMVqgunccmFosacz2U5?=
 =?us-ascii?Q?phpCz/rJroGXipWlVJ8vMT8cIW3BclO/+nI74TtcpTxhalMb+QnfI1C+tVs3?=
 =?us-ascii?Q?a52FFxUl+IK+/jRZ1F8gTgHC+tIl6jbjZg42KUP+7rW+OuGnfxli/QSifXfz?=
 =?us-ascii?Q?ClLKtro/g0WCnLVqkjwcGrBotmNCO0LNuu+iBmzhIaausemKucuseaBLUoEx?=
 =?us-ascii?Q?8kqkCsyH0+IRIRLUpwdzF7Bupwb0FNEk8iRQDiGf65ymGGK7T/okrf1O0gRI?=
 =?us-ascii?Q?icjqoGDAe59czwsrh+v7qH3gSUtlJKq9+0ymE6xv4z5vDENxxxEnAjfcFT5W?=
 =?us-ascii?Q?aXg9RlaE0iU9Kvm2DqOUJl26eQEW+3FPfvQs4U+u/HVTuzNAHdkVWXEaw12w?=
 =?us-ascii?Q?snY9ChKb4eJUqeXgt4frwm9ttsYik06+khOIklCdaestqVEPOTEDlXwbeuLd?=
 =?us-ascii?Q?+FPwjnfCLTR8yQKOQwfwgBwl1VhB29Zsei3fw5FrcJ/fUDi1J8jzpcf2bqy9?=
 =?us-ascii?Q?jOwci++Q0TsYZKq/x0eh5TwfzSi9egBDb1VkUJm4gZnE7pyAU5/IHVjJzX7y?=
 =?us-ascii?Q?x5HMxt/NRRco644gh03edtdNojuW1XV+njMmdpskDgmUy59RLUaZvHSHJdyc?=
 =?us-ascii?Q?FLnRM8MOxu5zgC1AsLoZnQE9L+CW+Q5BujatNwSng9U+YqvzgQPU0BJoiWGy?=
 =?us-ascii?Q?pFgp6HbSOgYc+FR2CQ+Im9hu4tSnyrKDjUo2BxEM2Q9Qfp1avkBsq4S0qWS4?=
 =?us-ascii?Q?pjxoNXxIWq0QiYrv2MFOpo9bOxHtDrPDeRTidNjF+3ed83MwEsHygVtlrZNR?=
 =?us-ascii?Q?Iy57R5orJApTld8UHUxAF+AhBFhyNjJrb2/cYdK+hNh9gF1zS1tQVX2GN924?=
 =?us-ascii?Q?Tv3fru2SQ9TnFDL1evNfmBRd4V0mWTvz4OF6vI9+34qQ135kN5IBw4zin80W?=
 =?us-ascii?Q?qSDuAzI4+Y9hUbOdSoMHIm0qfcTeWWxO9YZQYNuUsyBVonKDctA9XZm7KyG8?=
 =?us-ascii?Q?o0dL26k7gKNBLud3wLJ4SeoHXnasLPVwMqMd4VhFMrRcHxmpy7KkQJ7kAz8Q?=
 =?us-ascii?Q?0zlc0vYpOpIrEpnGPXsUBjGwpS1NtM2rdaGuaED2XpC1/vl7YgMChjl+a+4e?=
 =?us-ascii?Q?UyTBmfluf1YpBoOrRL8+1LTfUcUZAXKpS/0Nz87d93YAsdK5XavPof7Z4Spb?=
 =?us-ascii?Q?GE2vOTbKM7HVzcg/PqqQIBaVe4dXX7kYPmNfoROqXr5u1b0jbb9LCf/em3AS?=
 =?us-ascii?Q?1KUDEwAfPkmryyUrc5zpnuo+bq0DYDLOOM0ed0z2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd550ae6-99af-4fa6-0d40-08dd15e93397
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 11:29:09.6259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDHEUxF6ExmqwVncDBVKTv/xB17GcsCTM1vbFnnGr4i1mUs5TiqILO9e11zftBs1tae9P9nflKth4fns6j3YVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10273

From: Peng Fan <peng.fan@nxp.com>

Unregister the cpufreq device and soc device in remove path, otherwise
there will be warning when do removing test:
sysfs: cannot create duplicate filename '/devices/platform/imx-cpufreq-dt'
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc1-next-20241204
Hardware name: NXP i.MX8MPlus EVK board (DT)

Fixes: 9cc832d37799 ("soc: imx8m: Probe the SoC driver as platform driver")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/soc-imx8m.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 8ac7658e3d52..8c368947d1e5 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -33,6 +33,11 @@ struct imx8_soc_data {
 	int (*soc_revision)(u32 *socrev, u64 *socuid);
 };
 
+struct imx8m_soc_priv {
+	struct soc_device *soc_dev;
+	struct platform_device *cpufreq_dev;
+};
+
 #ifdef CONFIG_HAVE_ARM_SMCCC
 static u32 imx8mq_soc_revision_from_atf(void)
 {
@@ -198,7 +203,7 @@ static int imx8m_soc_probe(struct platform_device *pdev)
 	const struct imx8_soc_data *data;
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *id;
-	struct soc_device *soc_dev;
+	struct imx8m_soc_priv *priv;
 	u32 soc_rev = 0;
 	u64 soc_uid = 0;
 	int ret;
@@ -207,6 +212,10 @@ static int imx8m_soc_probe(struct platform_device *pdev)
 	if (!soc_dev_attr)
 		return -ENOMEM;
 
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
 	soc_dev_attr->family = "Freescale i.MX";
 
 	ret = of_property_read_string(of_root, "model", &soc_dev_attr->machine);
@@ -235,21 +244,34 @@ static int imx8m_soc_probe(struct platform_device *pdev)
 	if (!soc_dev_attr->serial_number)
 		return -ENOMEM;
 
-	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev))
-		return PTR_ERR(soc_dev);
+	priv->soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(priv->soc_dev))
+		return PTR_ERR(priv->soc_dev);
 
 	pr_info("SoC: %s revision %s\n", soc_dev_attr->soc_id,
 		soc_dev_attr->revision);
 
 	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
-		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
+		priv->cpufreq_dev = platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
+
+	platform_set_drvdata(pdev, priv);
 
 	return 0;
 }
 
+static void imx8m_soc_remove(struct platform_device *pdev)
+{
+	struct imx8m_soc_priv *priv = platform_get_drvdata(pdev);
+
+	if (!IS_ERR(priv->cpufreq_dev))
+		platform_device_unregister(priv->cpufreq_dev);
+
+	soc_device_unregister(priv->soc_dev);
+}
+
 static struct platform_driver imx8m_soc_driver = {
 	.probe = imx8m_soc_probe,
+	.remove	= imx8m_soc_remove,
 	.driver = {
 		.name = "imx8m-soc",
 	},
-- 
2.37.1


