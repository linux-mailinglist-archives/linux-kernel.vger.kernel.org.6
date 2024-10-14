Return-Path: <linux-kernel+bounces-363087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E515799BDBA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B53A1F22158
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B572A3A1BA;
	Mon, 14 Oct 2024 02:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SO2adAYJ"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B7B44C77;
	Mon, 14 Oct 2024 02:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728872629; cv=fail; b=eduEklVL16SIiumWlv/SMcntCXTbNkH+roSh425Bkc//DE5QUPw9XULFoqLMA1yDA2n1a79xQ7krVd+BOoQIuAp2j6HpMtnEOS4mt5b2ZcAwDkAQBVI+JidkZ74Of/GQ4WZrvreXHPlTvY1h5HVVjyfMguAwo/8RD7imAxe1RpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728872629; c=relaxed/simple;
	bh=tSg9UBMm3ZnFCuZVWj46eFf3317ntAx2oD04Av1KvcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fAw9EijLgzy5x44MXrl2dQGKSyqFHT/dR2+MxBCmXYEs76jryU8BQcleXtANX6gxJkcs6C3vh0j6s2t7IuxB3tcSyxrDTazoLIEOK/n5/lAupnHH7Psmx1xEuBDvQHkTGefuKYRYaszZsAfKmi/iGzFoD+IoXH3ztKpbVviyyiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SO2adAYJ; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGDTCUJ0OGaN+0MClD/qpgBC1Yt1fyMC6F9Lr7aBPV7b/2U+MNtF12xc6RC7j2XpHO2XvVvngHhUo7KNKJZV/co+9EhImROniIVrCSashUizt1NBZ/5Qb56suM7gaYSfEN7EyIi8xs3y9L71FvKMSBCe/yxp2gQMIAJIOHizS7HyxenjEvmWYYJEnBEkLLmjTjjeq/NDy4dXfnNGB4pOsle4arUKq2SLhzRdicUBydCnK4TKt6aYRWcBOWHxM+qQ9aE+SpkLo6xHIfSg8Tm5rzZEVif/zirnnRKGtoUJ/MKtCzNToPOXJrmW8Ufq+pAcGc1vbylAh1bxkGYySOfQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1OAJdReJttTaYWJtW0DQh4jBxgvKCVFq2CojZ44yy4=;
 b=TtuK1Zold1TpktnStl4HqBMEn7oqftVLXOPBU1zqVNgT/z1/jBU2YXNK5E/1inPYftn+dk96HH0XGHu2hp1rPdbOg2OxxouVFfJHFi3h1ip3kYgB6l8cCdxn3kI2iEBlNil2Z80BlpR0QlAz7NC6f92ecqtjAP5Js4qUrWRZ4M2sDSNKIxS2uTBGCrDQafjzh/a+Gp/sV3MhirHD7M0noRMINFzv17339A2MZzpynvydlza+y/A5QoiNs/l+WLDV/vIMMuQz1mPWbDu8hzEV6zmGu06txPGSBAyKwfsVDcVFJY+kTWhRmDQXRWl0YEV5ul7vxOT/rsgEh/uRo+Q03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1OAJdReJttTaYWJtW0DQh4jBxgvKCVFq2CojZ44yy4=;
 b=SO2adAYJc3aRW2BDURYkE0Owzish6ONT5jadju9j9jBSzpio7zOa825yj77snS8iAkqqVJyI0Wb1s1QcYM7XYdI4/E600vSHtagRz/bt6IIWD3Dgd0t6IjjsSfOKTTCJhg+YAYjAvZmbC3ErEs6olE0XVv7Y15qN9xsbd2y7eid92YHWGh9J6lCK5LDhN1y6cii5JP31BTOev+WTJxVVTUGrT2Di0yoejKVidLjkeI9lbksQW4p5cSnu4SW1feSUpLe9mUGYxKR/DzDdKnJblbwI1zQWuN+y6x+xt/7uTBhPMy4HvhMuJUrJBGl+BLHU6mtayMFbCrRI3eMkeMZwnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DB9PR04MB9378.eurprd04.prod.outlook.com (2603:10a6:10:36a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Mon, 14 Oct
 2024 02:23:44 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 02:23:44 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: krzk+dt@kernel.org,
	robh@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] clk: imx93: Move IMX93_CLK_END macro to clk driver
Date: Mon, 14 Oct 2024 11:24:35 -0700
Message-Id: <20241014182438.732444-2-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014182438.732444-1-pengfei.li_1@nxp.com>
References: <20241014182438.732444-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DB9PR04MB9378:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f0e081-a140-45f9-791d-08dcebf739ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a6ixNrxk/R6LLoz/P/0CuF2N6oBXAIg7ROA9BVSlcsphWexjcb6cY0nDp2v3?=
 =?us-ascii?Q?jjSUhPrvLLt0D7es6URQSwZ8ErKn6y7TZuwP4jal15rH+NRw+0YbAbbGZT27?=
 =?us-ascii?Q?pC78IXQBmMm4QmeuOj2Mddfo1PX1mPaA6raHzypvauCJoZB9Kf8Whyj8wWiX?=
 =?us-ascii?Q?JL/wRp54Uek8kfc+ydyYRea2uvZ0lUmJQAkqE2PfUnc+3T1j4Oa/Fv2ik2hB?=
 =?us-ascii?Q?gGv/SEjyZ2vSb2Wc93qMnkMRYBVY4ChzrCcgb1hgPA2qHmbLg/+ZNWt2Mo9o?=
 =?us-ascii?Q?P0R3degHZRmpJCy2ZBkWCC5DN0+L87K7PZ4miqzt3spvd3ki2z5vwI+bmlFq?=
 =?us-ascii?Q?aOyz+XvNsxRee66NsAz9DRyRpA0MygSgMbUvq/vMzLQHBrIlVCIEWXMDiHQI?=
 =?us-ascii?Q?m4r1ACrLbJuRSxQ0+wGPtSY9tO4cFepxkEvy9s8REu4JE6Zl9+EAuNVxuhK7?=
 =?us-ascii?Q?xstl0ZgGs6CHz53sBcDc31VkS3+2WHmvy5e3FFjfZc/wfn2RaJVo62/5sDEU?=
 =?us-ascii?Q?oERN5h/KtP+vWCzqPf/5fGevN3zs0Q5yfWrzhfpcpxa8RNppcBp1U4DjLIVe?=
 =?us-ascii?Q?aJurd52Uc6p8vYPvK40Z2du5kdjvDO08Fvjh212aEwIMAGA4mn9Oy63SEhDL?=
 =?us-ascii?Q?GiaYkyoEpBgc9mCFmNexLw7KPltlvdB0IrATmYqdx1hgDHSBfjcKGpjgHIC1?=
 =?us-ascii?Q?tdXHt7h0de1Rw3upVh1H5GUQ0AHGNXo93wM3KwTQH/12Ed+oOe/8vAfUPsMf?=
 =?us-ascii?Q?7bTmgh0AWAYQ5kP0StqoM6yRMFMdkYBCxf+DSUEXW86itNsU1mTc6ayj0qro?=
 =?us-ascii?Q?IjlG8sDkZdIARSZQE1nts1tTbLdH45pkkVeGAJpUz5muGZ9Xsb8xTPr52Ca7?=
 =?us-ascii?Q?M780SHHMe35GzGbXtoL2RiCZhEVyx8m8v0t3z8tDJSg7jPCPBZyHWbalxI2A?=
 =?us-ascii?Q?GWMjT6JxnWolW34lMCitb8wJdSVanIuU8qBXMS6jLvMCyPdEy+tfZyQNYXJz?=
 =?us-ascii?Q?+9v8aAGEc4mbx+xkHV/ry70wpKc73FlPyBIE2IGxG+5Y5rVYy1du36oc/gbt?=
 =?us-ascii?Q?lDS3xJWtjJPj2xCEQszpf6czrAkvVIJ1a9o4vtgX55DjMwGEa9hrhyuv5YpD?=
 =?us-ascii?Q?4+mOXLx6kIVMHvf1KMlKruhlLiIg3lNZtWTxXd/g8KVopNk88k3t4Dy7opsE?=
 =?us-ascii?Q?NB6Fi6Yqxka7J2C8clcGxgQg3wdZvUjDBQjAu/+WrT+lZCpKS8IUjKxhTdEM?=
 =?us-ascii?Q?hR19ZdMS5d44Cahbhywn2rTcRQdprCfNckyq+/tSQFFAORTBAPXL41H6vWS8?=
 =?us-ascii?Q?ylg0WRe+po3RMU5ErKkFnR2ABce9GxMfna4n/TBOun5LfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M3y9tq7cXbv6OxSODsLZzT56xrX7xjzGwuFP5seho7Is/lejhZU4wHB4CKD/?=
 =?us-ascii?Q?3ZNqXViA0S0LK2afVvOIoQhlfj6a1GnLSSO2YQNTMWAg52QXqB6GTUxzJfNv?=
 =?us-ascii?Q?Bk2FVeeekOtC3G+friTHieDvB2c2Ju2FOXxUB3Wrby3eBWrPQvyeBw8am+/6?=
 =?us-ascii?Q?vgyVsoTQnMS6fDeAbLIPvC4Zi2t/D6/c+H0OX8XnLQqemsdnHjES3ET/Dk26?=
 =?us-ascii?Q?8zy6ch4GbKtRB94+A7QgQqOwTg3bmhr2t54Zc7Q6fSBmIddlstjlephYZXa1?=
 =?us-ascii?Q?SAZJ/5vKwLwH6MdcADkOQ1qILgoqby1jf+5Y60qUxyqW9i2y6c61SRPYDhJy?=
 =?us-ascii?Q?rTSdfqy6ddVsuBMbFxfFfJs6BAxvfJTWOPAT5hGKHy6dIXNwHVqPJVGbVgZu?=
 =?us-ascii?Q?0gfUxu2yJPF/obXtc/2qPWA88Eksc0O9GlNAxP0NeGQrXa2XuQz0jMn8RpSV?=
 =?us-ascii?Q?KAq4GaKOjYCgaXQQFcWfpf3MlBT/soIFakUJsbkLxufhdWkDnYUf7zby8u9A?=
 =?us-ascii?Q?vj1wVSL9q65jBDTKED1EhMtbcNX3Pb8kArH4Df83EPae0MMDDdUQUTUTeDOZ?=
 =?us-ascii?Q?QtkFNFuMRE514Hy6Ixf1S+XtZ5kDRtprJrOw902mq0nmrd3stXvDy7HHD1bl?=
 =?us-ascii?Q?aKp8LxOKuE63vJ+HZ+mCo30l+r5oA5PcTssM7hexgthPo5bfrIRykPmySfpG?=
 =?us-ascii?Q?zXbknJy2lSseUj6LEU7N8H0SQ2g3JXuwcAD+NsEJH+MP/WmT9K+EpcODrrLA?=
 =?us-ascii?Q?0UCdZnyHYxItSuAejjTghKQ9qG30Dy6RmBmfp+lhuyuaoMbtrADDTvZARugc?=
 =?us-ascii?Q?hY3EHWTaxpqRdv3ziPRE63b8Rx/kc7YInR570i2pyB4p+3S9awfJmQOYd/ld?=
 =?us-ascii?Q?pUHaYtHT8CgfKT7a9Y4/dNMPU9Ve4T+q+0OYJuunNwFH92PwFAkxdYYcBUcN?=
 =?us-ascii?Q?YuCKFTBLecUvCNEZ1vD754QzjOIAyvaT//4gcHQh2bs2BPAx0sv0Y7coGvIT?=
 =?us-ascii?Q?x683U21w0d4XRzIReqa/XesD4/gJcGjUiRwh7MyQ6HJL/rsG0gxOVm2o5H6x?=
 =?us-ascii?Q?NxPFFelGVnEqbz5c/t5h+q4HaHK4xMX2tHpoDFuW5Z8uqoIc3p1gyxltxIzS?=
 =?us-ascii?Q?+5WkqimBn/SIppZmUtYXfx3vtBY58Y62XK5dr4W36q2xNQT22I3omE7FhFcL?=
 =?us-ascii?Q?dk3G7g6Eu3njl8z2/PSqlixHjCb3lxyPJqyePbnY0eGOpu4V37tBGi1qp3Mm?=
 =?us-ascii?Q?irIuDnoWjbVq1i4JIUytWOIhlYR+WLTLnX2IOY3aw6DeF12pA9GKutSKMvz3?=
 =?us-ascii?Q?H7WkXz/jlJMq6bWkcVoEGNwKCuVBO+a8KT+VQfJd8i3c+oyKxgbADTPehYZ+?=
 =?us-ascii?Q?wTSuggG2nwDut+7HGPEbSemwkCK0gRT1aqgsVEBE/SoydwITxBxI8DojKCDN?=
 =?us-ascii?Q?QaR0ll4nhsB8Z6TAZj99W90DB5eTW3rapoBcBp469rIN0GmusX1J0/PyngLS?=
 =?us-ascii?Q?onYdUNedHg1oGM4PWwSdUnmT4F75woNK5aRuIfCnus4dtK7rCv/7PD/Bqm/1?=
 =?us-ascii?Q?xx7ELwKxHxcXLlNm9RP/vAXIEqiVWC9UQ6COvYY3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f0e081-a140-45f9-791d-08dcebf739ff
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 02:23:44.6539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cerp+qdVN64o/zxTt6uUuSCAOOS7Rg3xzRY+ni60IyDf2bmO+ffoHA6HH5F3tvNnZ6u25lT4o/Te3eBrGIrTJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9378

IMX93_CLK_END was previously defined in imx93-clock.h to indicate
the number of clocks. However, it is not part of the ABI. For starters
it does no really appear in DTS. But what's more important - new clocks
are described later, which contradicts this define in binding header.
So move this macro to clock driver.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index c6a9bc8ecc1f..c8b65146e76e 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -15,6 +15,8 @@
 
 #include "clk.h"
 
+#define IMX93_CLK_END 202
+
 enum clk_sel {
 	LOW_SPEED_IO_SEL,
 	NON_IO_SEL,
-- 
2.34.1


