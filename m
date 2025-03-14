Return-Path: <linux-kernel+bounces-560772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E8EA60953
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D7FC7AC2FA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5453156C79;
	Fri, 14 Mar 2025 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="waDNCSOn"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F08022339
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741935224; cv=fail; b=BGUGclRwgq+wger7/ZZikveZtzwOo71wB/j/CS6ojd1qfgUIAfxHuaHkRbK8tFLPtB8G3pp+HIWoiwQ2J2ndfsJAYKbiYvgvCNh4aOuJPDeYSYiWUj1+feR1pmV9Ky/SmRXSNC7DTxiex2Z6CP/cUVbOYomxmpmsRygYJDSy6Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741935224; c=relaxed/simple;
	bh=99cJ0l5/ug3xSS2PldacefvzMO0F5i4bjsezlUnrKCg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=q37W0/gp1LdcDVH6ZMqFQpRN56Wi/QghkGMP4fPcfQlGaq0Oc4yUUVV8MxIGwKt68bpClwkxDWafB3EMCeO4XWTw6tEB0/LP7LCBMyq4noy4J3GIQZPVl8mNW5CDySrz4UP+GAwhwuqr+2KFcuWASsOcylz0Hz/c3YZ3ucQslMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=waDNCSOn; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGl6PlINSQ+Z76E202lsrxmRY47C+6jKFOArFPgtBiDIMwOJ9cRgN9nz200LIY2hS5kd1R21OCGLMh4sdbLU49uh5/8XyNwW2ogopHOxQKs60rRjsISjoaRtq6WRE15FcREmCE62s84qZnKtEly0O6ydddkYTSLUm9WxzjZef5MlZ/rsJEe63ypAVHd9UAZhXVa252Mq5i8Hje6GulyXUG27lxZsaF1vZv0S63xBeTHg8Qyfkg9n7lYKOZYlmhkrvvyiuziEZnlpFizssBgvPtdcvRMhfnpSUZW6zvGtbggCEuV6McI3EGHZqA6NeCpvi/5iAHUXc6Q/85vGP+ULDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnFyzZnqMoky8Ia5bG8t1qzz0EqjBcV6mjGfZUxjJQk=;
 b=rOorjmrUZdtJUm4CtlCDas45mOs+hqML4BdzCZExg7VsfZvlUjrtR65nu0QFAC1sq1EsxpwQFX8CKIPyj/gjpLUaebxRpPX1YBzW7pXYVCT0fQ/37JFJvpqZ954jBbt5i1v1ByfAQOgP+Cj2oiE5d6NG6flG+idyUZ8t7ScXoVOdMid+jeGdK91yoG61qDTyHG5MIu+r+Xrsb60HbogSUJWF0nHO2klU4l8Ad0wVgRKysjUpjXdEq53LYxQx0gx3oJGzrFKPhTwg6x9dpy0lsTTY1iZKnkIE4IDT8ZCrrVJgD1kfpkt1B1u4oh92JdazQxMxpZD/NMP++Q4vCIsQkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnFyzZnqMoky8Ia5bG8t1qzz0EqjBcV6mjGfZUxjJQk=;
 b=waDNCSOnSM5t/DuXjubLDH9mX6QUbqLOb27F/QRMXFSZ2xbRzfeH37evlo6Ot0kqJcgEnalYS7fRgw/siuIdPHhmf0ApDt+S9MlDK+GWhH1XWZWltB4WwFjFcWljufMck+gn5jmGmdKjkkTV3THdlK+WEwI6wlbSsCF0r/NGg1l3e0HsFX1/bylHu5ei+PHpaDevbyMwKQX+Q03FCO7T0EXTUDCR/9FgfrOWCj8CkESz/VJTKJ1d2BuXqO0JIdcJ2hbGdvC6cc7w6Zua0D7t5tEH62xlMwFs4pujHuRGKPdvHbiPtcHJAXtxLpNv0OCXOKEzY86eEpvmEdfZw61xmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10483.eurprd04.prod.outlook.com (2603:10a6:10:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Fri, 14 Mar
 2025 06:53:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8534.025; Fri, 14 Mar 2025
 06:53:39 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	marex@denx.de,
	imx@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] soc: imx: Dump higher 64bits UID
Date: Fri, 14 Mar 2025 14:52:25 +0800
Message-Id: <20250314065225.442717-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10483:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a5eabc-39e0-4abc-918e-08dd62c4f314
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RkFXd/Ec/Fgp6Z2O+TUUsnj2TgRdlddsweV1k8ZawFk2eKhP0kTWQ2qp35pw?=
 =?us-ascii?Q?V08wmQraNsnWRPr8dPCUaX8lvIze9YYFZ/yctxOKPqmWpCrpB60KdcYo+0qA?=
 =?us-ascii?Q?fwgjOekKtkcGxdVlB7bzKFdTOFp1vVXn99NY6kACC1CMyEvddi1ObGRR5VGu?=
 =?us-ascii?Q?Y7psRU/CODXfRpPL98XgcMzsw4Q2l7HISc+Xs0cuzAY7WbqWI/wvrwQp1DFg?=
 =?us-ascii?Q?qj1F2nxbbXwGy8x55hzCuiXY+iWqwC7lw6PYVO/YYPm+vw8Fn5BCdD4CD1bi?=
 =?us-ascii?Q?PIRVnkSODe80402fBpVchOI9DlR1rN6TpG0AHBy3NcGcUnP0ZRZLJwhBI7tv?=
 =?us-ascii?Q?FkN5P9Hqv51UcnePR6lJPfUVI0qx2vBuc5j3Xz5f5vjxt+jgwpdgR1vG4WIm?=
 =?us-ascii?Q?inXifMtTfMr5P4JiicjFohKK9DHin0w+lqwFxds/qA14D4xtx3H5LluOkVaJ?=
 =?us-ascii?Q?j6en+PEDgEiqdF5gHYy/4cxReQEMkOFr+Xb6MvssO6sPSIjRl8WUFwOsnU16?=
 =?us-ascii?Q?zaDhXdiBxiQQFRPBPPgBUxjLkNiFIu0ME3XRCGYntvimBRJZykTrXZZiexAK?=
 =?us-ascii?Q?vht4PbeHvfFPchA8AcrzZ1cUtEbnddaVuZy50bMq1x0sAAwNEMpsNp18f4IB?=
 =?us-ascii?Q?KzPBuAGTegRFisQO2kpF6zbNhnU07Ab7kYpQynRM68QOYrg4mT3+LBC+kuYn?=
 =?us-ascii?Q?bMrpcbGo3XEjTww0hRr5w4k11J+PloBfps7whbisbeP/yxu0VbWT4wSi+AQX?=
 =?us-ascii?Q?NhJQZJB5+0tHPvOVGpieDoqC8SL7mPIRmal/hB6WhCYbydJY+KyQHFj9Atcx?=
 =?us-ascii?Q?sNS4K+KOqiiSwfNXGOUjMzbP7wvB4AceYWHbDtT7ZKHOtMYsuU785/L9nZFZ?=
 =?us-ascii?Q?5csEhknlmLNedGM9HQwBzBvAe23BQwWS1akC1SMwMkno/5MJp60rpPB3RcnX?=
 =?us-ascii?Q?2EQmmZfHKsUIcdTlLSykDTpKJHImIU2FkWa530mMTwN4wO9W/vKYoeQSOBFB?=
 =?us-ascii?Q?T/MNV0FOX90KTbQkmeTt6sijFcl/lysrDk0v+7mx0rsVO5Lu/Gaj7qfDN+Qe?=
 =?us-ascii?Q?rhfN058roSNxWxQL6OX7LOPEGIyMM+V7ZMWg8UMllGIuE3oZHCC+sI2IlAe+?=
 =?us-ascii?Q?Z4bNjLO6WkOas3cVS3N5BMdw+laIpDZmjSuV/m5WKeJ2g8l0gZJhHWO90bjI?=
 =?us-ascii?Q?u/A5iYe7lUbtOajekTtts33ZfVXv2ZxsrOL4kab92BHK9eu4nZPbdl5t7kbM?=
 =?us-ascii?Q?H0uTaoFAB9pG8tJUIKvhACrAwz92IZ0Lza5uvBYZwOyvBMnHWsfH74ntMh1O?=
 =?us-ascii?Q?IWTMtXOuaZi0wdS3HvDK8Fu/4nBRJ4CGX5K8XUeJdXuJ2L6t9fPCr17iwW3y?=
 =?us-ascii?Q?ecTnvNJwLlI+OyddzmocKtyoFZ2FWT+j0NCtvZ3Ch/XGp6yB64SoyNQC0mAv?=
 =?us-ascii?Q?fGf8wXHqj4vd1GUkRIDA2Syp0CNmWBTA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IMWs2TBSRXoVCO9/+CjCBtB26VWdoHSbR29nJNy8coXYdnrkaVuRUCVZ9DIz?=
 =?us-ascii?Q?9wASLuVNBY75dQWNsdY/VklNuxZDN+A8czifV0GwFh3IZSm6xSLziheadA0a?=
 =?us-ascii?Q?3rXe160X8+AdsX1boXWJBWfVdcp/v7m/0gjPCifdh4q21Po3klMk94e1ysXP?=
 =?us-ascii?Q?/GO7OUNCZj5M33YlDB524sl2ZQmnSeHNH+MFRHWatPLrsYXbqm4nsZETLk4Y?=
 =?us-ascii?Q?93dVT7krkacSg4RnY8kAv+grP3dchlJ8c8FcP5TDHC0jaEFC2X62F7BymikN?=
 =?us-ascii?Q?wqYwIK5aDxCr/IPR8XVBzf1knU0nXjq074JKHZIUlL+zDTGyTGPPlxMwGmGc?=
 =?us-ascii?Q?0jnbMAC9ihwDE2Aay6RivI3yfzFHUwIWzQli5VFcPnavREmrIIm9IoTUPiic?=
 =?us-ascii?Q?wt6bCCp6l9aZWwAHdlelx9Iy9aTLVyp3FhIUrLSuQwf5t4zz0hUWXqvp+7S1?=
 =?us-ascii?Q?FIuYoTvARBXvBE78ilbwSqbgO424s+Dgb4w9NOL92fEZHgRClRbJDfuB2N67?=
 =?us-ascii?Q?hg/5OUB4WPkb7eKVM6679nq0hQTMZNF6ShqiEyAqQ5kIflVYQ+tUTx0oqVJy?=
 =?us-ascii?Q?uxt3i5IsvTXlpTfRCEBlm26BYJwL5TWgkMwuZQ0yP8vWnj6MgAd3Ce3UK0rj?=
 =?us-ascii?Q?Rvuvagin3GCT5xEmSOIZhW32EvV/MXk0AI6v0PgviH6b7zwuemwW0UJbC2tE?=
 =?us-ascii?Q?qdMSNT576kqzgBtzoVX75Z/b7ooXmiXI8GRRAj6XHaVGmJvyJKzbiVqxDZl4?=
 =?us-ascii?Q?njPIyyjLb7zd2DgcN4wV7BQyWXk1Rg5TpKPdaR4CwokXgpB1B9adw9B7bjq9?=
 =?us-ascii?Q?ILRFM/MfstYaOAy4sJQQSCWDRGbUMYn5eTXst2LsAa8t6w09IYGeNn8G/Fu4?=
 =?us-ascii?Q?QUiKpAjyLUATT0Ol0MnjMjAxdDpsE7FrzQzfj2fx4j0KUT8sKI0IQJMkYjb0?=
 =?us-ascii?Q?TonnA/kSZVbQPRFhTG+GX/vvNTroR5PoS7zKjfN78KT0+Tm9c6+TRf4XG6K8?=
 =?us-ascii?Q?uUUyOOq2uak+M9Xg9Gg+nwMtYMjcxb6aYrncTb3d9RaEBDgkOIzkisGTDsRd?=
 =?us-ascii?Q?iDm7ElFE6De0sdpRe37wYZaXzl7KicZ3Lu1w2OJ9cHyoyOScxyKvyOcEi9FP?=
 =?us-ascii?Q?AtN5rJKHmarsNp3BDXigfOeqlUFvhCvWhdxlh+q22qmB57SUbNPLFFBr40x6?=
 =?us-ascii?Q?ojFTPCUGjkzkEOuxArYLVUxMYFVLqOokNUISgtBNFh9/QFnJ1PthC952ps2f?=
 =?us-ascii?Q?i2qsa9Ma9JsjW7d3aBN4W//fycSUgOLHMZ/2uOwwFm947yzMjmZWwChDIj9O?=
 =?us-ascii?Q?p/OoBwSMoY3WScam6B3ua/ShoH8Lf7vPwrCWcG9a6IegP+F9Bj1PAnYIkSPP?=
 =?us-ascii?Q?wo/g3zufoo0f/C84TrOOK5zVSUFOBUqF/17YcugJ0845BkK7khvYUIhWZ9BK?=
 =?us-ascii?Q?zuF5VlU/hnkDxZGVZNuoBtj7BP3NCNJ/XjZZuTrjlMGZntOpOfFm0ZSDKthG?=
 =?us-ascii?Q?6bC1+cirklKm+1mEHBhruwzd9ddqFNjCFtKLJD8p8NdVefUK4bRHeGbmk1IX?=
 =?us-ascii?Q?juquAHTKk2kiudeG0zkLLQovcBr/ggL0MeLJAmnL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a5eabc-39e0-4abc-918e-08dd62c4f314
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 06:53:39.0331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0azjYfpiOZlqly6m9/NcL1FdYh6BRJaXW7Xroz1rD4Zh+tjAVgUVck7DKLivEW4t8NSBoIShuPGIHNaHWCkSPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10483

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP UID is actually 128bits and partitioned into two parts.
The 1st 64bits are at 0x410 and 0x420, and 2nd 64bits are at 0xE00
and 0xE10.

Dump the whole 128bits for i.MX8MP, by introducing soc_uid_h.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/soc-imx8m.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 3ed8161d7d28..02d8c85e9a28 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -24,13 +24,15 @@
 #define OCOTP_UID_HIGH			0x420
 
 #define IMX8MP_OCOTP_UID_OFFSET		0x10
+#define IMX8MP_OCOTP_UID_HIGH		0xE00
 
 /* Same as ANADIG_DIGPROG_IMX7D */
 #define ANADIG_DIGPROG_IMX8MM	0x800
 
 struct imx8_soc_data {
 	char *name;
-	int (*soc_revision)(u32 *socrev, u64 *socuid);
+	int (*soc_revision)(u32 *socrev, u64 *socuid, u64 *socuid_h);
+	bool uid_len_128;
 };
 
 #ifdef CONFIG_HAVE_ARM_SMCCC
@@ -49,7 +51,7 @@ static u32 imx8mq_soc_revision_from_atf(void)
 static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
 #endif
 
-static int imx8mq_soc_revision(u32 *socrev, u64 *socuid)
+static int imx8mq_soc_revision(u32 *socrev, u64 *socuid, u64 *socuid_h)
 {
 	struct device_node *np __free(device_node) =
 		of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
@@ -102,7 +104,7 @@ static int imx8mq_soc_revision(u32 *socrev, u64 *socuid)
 	return ret;
 }
 
-static int imx8mm_soc_uid(u64 *socuid)
+static int imx8mm_soc_uid(u64 *socuid, u64 *socuid_h)
 {
 	struct device_node *np __free(device_node) =
 		of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
@@ -131,6 +133,12 @@ static int imx8mm_soc_uid(u64 *socuid)
 	*socuid <<= 32;
 	*socuid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
 
+	if (offset) {
+		*socuid_h = readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_HIGH + 0x10);
+		*socuid_h <<= 32;
+		*socuid_h |= readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_HIGH);
+	}
+
 	clk_disable_unprepare(clk);
 	clk_put(clk);
 
@@ -139,7 +147,7 @@ static int imx8mm_soc_uid(u64 *socuid)
 	return ret;
 }
 
-static int imx8mm_soc_revision(u32 *socrev, u64 *socuid)
+static int imx8mm_soc_revision(u32 *socrev, u64 *socuid, u64 *socuid_h)
 {
 	struct device_node *np __free(device_node) =
 		of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
@@ -156,7 +164,7 @@ static int imx8mm_soc_revision(u32 *socrev, u64 *socuid)
 
 	iounmap(anatop_base);
 
-	return imx8mm_soc_uid(socuid);
+	return imx8mm_soc_uid(socuid, socuid_h);
 }
 
 static const struct imx8_soc_data imx8mq_soc_data = {
@@ -177,6 +185,7 @@ static const struct imx8_soc_data imx8mn_soc_data = {
 static const struct imx8_soc_data imx8mp_soc_data = {
 	.name = "i.MX8MP",
 	.soc_revision = imx8mm_soc_revision,
+	.uid_len_128 = true,
 };
 
 static __maybe_unused const struct of_device_id imx8_soc_match[] = {
@@ -211,7 +220,7 @@ static int imx8m_soc_probe(struct platform_device *pdev)
 	const struct of_device_id *id;
 	struct soc_device *soc_dev;
 	u32 soc_rev = 0;
-	u64 soc_uid = 0;
+	u64 soc_uid = 0, soc_uid_h = 0;
 	int ret;
 
 	soc_dev_attr = devm_kzalloc(dev, sizeof(*soc_dev_attr), GFP_KERNEL);
@@ -232,7 +241,7 @@ static int imx8m_soc_probe(struct platform_device *pdev)
 	if (data) {
 		soc_dev_attr->soc_id = data->name;
 		if (data->soc_revision) {
-			ret = data->soc_revision(&soc_rev, &soc_uid);
+			ret = data->soc_revision(&soc_rev, &soc_uid, &soc_uid_h);
 			if (ret)
 				return ret;
 		}
@@ -242,7 +251,11 @@ static int imx8m_soc_probe(struct platform_device *pdev)
 	if (!soc_dev_attr->revision)
 		return -ENOMEM;
 
-	soc_dev_attr->serial_number = devm_kasprintf(dev, GFP_KERNEL, "%016llX", soc_uid);
+	if (data && data->uid_len_128)
+		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX%016llX",
+							soc_uid_h, soc_uid);
+	else
+		soc_dev_attr->serial_number = devm_kasprintf(dev, GFP_KERNEL, "%016llX", soc_uid);
 	if (!soc_dev_attr->serial_number)
 		return -ENOMEM;
 
-- 
2.37.1


