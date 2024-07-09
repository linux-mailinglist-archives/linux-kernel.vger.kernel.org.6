Return-Path: <linux-kernel+bounces-245348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0868792B190
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844E01F2155F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77A71509A5;
	Tue,  9 Jul 2024 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cCFc8Olw"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013000.outbound.protection.outlook.com [52.101.67.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E04B14F9C5;
	Tue,  9 Jul 2024 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511426; cv=fail; b=KYK9IZP4O+jJW+FNQYyzqbHttJPtp11lsnhKKw7uQDBST+CQoLEgsUfE0dK3HiyiOqo4ajWCXeSiqZB3sZL8tJ7g5eSPX3Yw//nQOL+ZZ83e9ZH9sDrTGp78Fa3L+knU4QFQz6l/i0rWFu0y7UDpjZlDnIIvQWwe8ROXWYoVOBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511426; c=relaxed/simple;
	bh=Qkq+EDKTgS39Ymv7Cq2AXAK+1WwEEYUPHFf9pjzh/r0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z1k7TnLjWQqb25ZtAU+SBjb9XTBBrNJ9gZUkpP/4voHy9Rn3VINwsu9ybn/XnzeRJlfumoFi7WZeZmygdqsMjT+Nyv758zcOQuU8oNFnTVsWguxZQzlmSuRY4pB8YAA39JXpxtMlGp1jLHs5ajDkBSHXTvKqYu/LoEq6J4CSSiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cCFc8Olw; arc=fail smtp.client-ip=52.101.67.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrfGliil2VB3n/eOI6ZgEzbRltEPZWM6H2JNbx2FRPdJhvDGgjDxB0p21f039im/GqEKNc4+jEq9yZzTCr5MTTQxYoWZMxE+jGtwsB3dtk+kWmlv1yh7mHpmtG9OGZXKX1NLCA/mpwZx3SRJK8oqH9UjvSAmW8E54fmkAvj9DoBlkjEwg/MrAQdWYB/ZvvVV9ud7SxjXtMX1JqpxM5a0EEUFqomjSPePPgXUS3ClKk7jFuZcBmbsHklEILDjCSmS8eZpQlRudvMwpmIoCTnHHgfRFy1wVr3I02Xwavy8i3gGpYBDNAhCiA/Y/HwxKzYjroVDDFji7W3BBIlH6x00GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBn19Vks+UCViAWpSjAc1lvA98Vab4ABAjYD7aKJNRY=;
 b=FYT1GpNtlV26ed/CkUzU6DkorrW5aWlSjCi983eusYYDm7PVCTlLKGUDsG7uNflMjZDUg0FWkiuMM24qWTfEqaoUlhFe4NMeRaUyn5LzyTpRy+FXcTKnDrsFoAG/zYtHwmCFZW6++XtTdbnn4kQA7ni3XY3nrLqGNCswGsn9t12jeUDbskMy/pxo3DyjslAxUIVddb4bZI/9E8c9wW7GFLgui0wP/xCH1a/fojrXlr3e8JjfSVV0SuJHAOVa+KAO6dVhjkKuIIUgl6bO3OkyvNY5cxtES+drh1m0Psd1PzcnYzNO5bUz703lzwG2HvMMOwgRHqL9nd/j34gZRatENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBn19Vks+UCViAWpSjAc1lvA98Vab4ABAjYD7aKJNRY=;
 b=cCFc8OlwPnpV91dVwCftd78rNDkTMjkMQgPK0h3EjZI78t+DZkosLjbl9jsdXYi9IFbZQCtlvJ3zfym9/S17LiOO9UmOvWVq5IQgjDuCxfxL8IfxaJkh+3TcIJTc416NjQPe1KIUWQekppw6fOsderFpuTs/tGlRmpm431Iygek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by AM9PR04MB8652.eurprd04.prod.outlook.com (2603:10a6:20b:43f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 07:50:20 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 07:50:20 +0000
From: Wei Fang <wei.fang@nxp.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	abelvesa@kernel.org,
	peng.fan@nxp.com
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] clk: imx95: enable the clock of NETCMIX block control
Date: Tue,  9 Jul 2024 15:36:03 +0800
Message-Id: <20240709073603.1967609-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709073603.1967609-1-wei.fang@nxp.com>
References: <20240709073603.1967609-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|AM9PR04MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: e412d4d1-102d-4dae-633b-08dc9febc79e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SkqObfpil0/LpQkYwIn+jGz+65/x4Ao21z4Xowkznukk5NvZU02xPcNuXua0?=
 =?us-ascii?Q?lU4FDqIP3itQEjbKQhuCXqfcPh25q67CzT2ca4P4PdIFd2QJpL+PTS+mZk3U?=
 =?us-ascii?Q?hbNbpRLhpLxT4qqI+KUwAh9NnexKaBO177YNTyHcOQkbvtLVmic9tPu+6AD5?=
 =?us-ascii?Q?EeDO96dmjHPTPHe6DO1isbNo9cPQAlLdkcdnWSjPPmWcBRcUhmpLQ/+XSi3B?=
 =?us-ascii?Q?uSJN5Wu6TGtNolHZzqUMjJv0j5bu7eSVRD+37Ovwb/rwI2FdOQYbU9niGMjV?=
 =?us-ascii?Q?us5SI6ZwZq/uu3XOAG17fPyu3NriqyRn/Uq44/pVOxPOaCCsbbprY4gcpUwh?=
 =?us-ascii?Q?c4bGGApif/l++PWKVLAcUbdEudXgcZzuGSHSp+2EzzN0z9aPg/sHhhRpg/u5?=
 =?us-ascii?Q?UrZTa/lnG4qGaZel0CljcvD5lWccn8WqwI19HcPBjHDygNRqVe4j3W5PF6S3?=
 =?us-ascii?Q?bcKB2Hy3GpjIy8kHh6ffyxG98kbKNzTus3mr4wQoWccVOngLMGTKvbyveKjz?=
 =?us-ascii?Q?QuboGkOJIASow60ZWJ67nxri52Woo3jdmdsP2hICkLEs3iUQkqXhFaSPY/K2?=
 =?us-ascii?Q?8u2OPgbtqpAcUGtRA5a6FEHlghcgnwg6bmXwdQKIKT4fRNDQVObyWJWeHYT0?=
 =?us-ascii?Q?Iu756DtqIDguT5M5zUCsESjSeduepEzl3pk1W4CPjgc4A4USaGCv/K4ulcZr?=
 =?us-ascii?Q?zF3UVe0E4nH+PG1rg6RHWNiJGfjVRyWhCVjqWFCQ0b2X8413c1ef2MUuLqPZ?=
 =?us-ascii?Q?VRVWUjhymnxmpXsX7tV9RHugSI1s1q03rXkw8h/w760nJpVJa6dRkEKDTO3/?=
 =?us-ascii?Q?HKvrsqjh0ZPZ2Ph/jZT9av5aCeYSipJe3jRRLe2JSmj6oM3M9GS+Dax2Mi5D?=
 =?us-ascii?Q?bLzGtuLwYJvpPBl2S1IaDVKA2DspzCARISAPCZ0X5xq1CIe7lH/LWofYZPmP?=
 =?us-ascii?Q?gESfSp3LRR5cQAWa5+kZNCLPYTCDpMwK+DDPBW6VI5LrenTxHonObwhINbb0?=
 =?us-ascii?Q?+Z952AZ1PSHTcWlkiNvsW2qGHnMzhnAGDAuL+oa4M53K3GOU0ocQxtHCLyeU?=
 =?us-ascii?Q?LcchGzc8oPn0ilaiqymi9JCodROAGpsgf6C6sVbWmiggKpEm/SRczjlreSkP?=
 =?us-ascii?Q?PR1Gc3c6W1UplqKsi7MT8EHAGCzyc+hkaWf7xVD2c6ejRLj/rXJHVzoqDMu5?=
 =?us-ascii?Q?kqBklXMFWaLPdqj+P4A+SpR1oExU37353cqvatdorrE4vPixJHsgAh1uiJDi?=
 =?us-ascii?Q?5GJNjf2kVZvlkdpPAXvlIakzCTyVM11WC9hskKh29hvEQUKJjCvvu0OyLPuF?=
 =?us-ascii?Q?TOX3xRCEHr6oTUe9sJRVrfiVv1QE1T+SheCvZI2pJCw2ACXKV+e+L+wDaxUD?=
 =?us-ascii?Q?CkV0o7Ydt17f1V89OG9cD6MgjHpoZgBLtVhKIFvrXr7M5ntaMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gwS+c6G23OK+UkTp/nGOx1u+lILeXM6OcNYud+8T2P1S2AnipKA7u1Vm9N80?=
 =?us-ascii?Q?1iZvJw8Ho671XYSFYvhNKb+1btmNxEtn7sIyngXcdPyg/db1RtgO/r0RqRJD?=
 =?us-ascii?Q?p9a7Zwvphcl5c5mzwslQfJYuviYXWHa0b/M+szaB12idDxwhMiQ7Yni3EflT?=
 =?us-ascii?Q?Ccl7mGBH9mr2UMcyWluzPRGKR9QfGG5TZhT//3y7jWwHda0lBRjQzubF05pB?=
 =?us-ascii?Q?43AGL2XtIp0vkosmPmWh+Db5Sh3gnMhKWC0TIDaWlZeSIReLbJBaz7CbgaWj?=
 =?us-ascii?Q?7m+syheXZ8hFyd6EnBF63vmy9g8ngxJojAeIEa3K0znttp9IHOuvw+b1TB/F?=
 =?us-ascii?Q?yOYh+0ybs4MyjP1K5J2BSNLPRhx7YSG1MfSEDXl7QMYSc72GMUZxvb7IkPgn?=
 =?us-ascii?Q?wPYZaaACeCWmqhWJiWke7MuiUjRC26Ni5NIAPH6v1acdy1rD2Pqeb/kwOnzD?=
 =?us-ascii?Q?EqFZEg308nGjNjGS5JKChZOAzO32zkskrFRzRN7m1jWxS3t11f1H9VoiOE5L?=
 =?us-ascii?Q?5QnLpmNZJdca+0lB1UUuxcsMpBUMA5EqSQrOa30ZxIvLd6R/YtlPW1LbQ5g7?=
 =?us-ascii?Q?P0yauxRSqWqdiVGjH0csRm8oxDHJ+WRkuFr9PA8mYHgiRWrMyyKQ4p4XVWTy?=
 =?us-ascii?Q?1KAj8g6pp9KQTSEDdwte7hOq22W3GBME2IMnwO2D0awccRDI3+wf09PNpDdN?=
 =?us-ascii?Q?L2a5RFnMDT0nSAN08EVoR2YLiANKMm4RxjSquO7YEGkam52zWQsSit68IwKa?=
 =?us-ascii?Q?dNZWu749k66MiGU57tAJTdP4hTTXGqiRmuuQSMNr8IF/ktfu+U5yqoa6BkUh?=
 =?us-ascii?Q?Q6dIcogRJl8daxmnEZ1uGVq1eU6bhNfbV+x+kLk3OTjfPph6eS8Ik2bkDtuG?=
 =?us-ascii?Q?WSlcceq5JZRO3BzEI5RUUvCjc3bOCF7dNBtZWRrCMFq6V7uOHOvsjGbamv8F?=
 =?us-ascii?Q?u8t1aC/DnIuZlSi1KBjXSBWJFb9Xmr2p2yrzvIq7fc1PWDRsyZFD4FzwBjTG?=
 =?us-ascii?Q?uKh94mDyKwbHVUqBdW0B3Cyioq90E7WrH5rrtB/35024W9FgA/7PobA9Uc5n?=
 =?us-ascii?Q?8f+Om4/OzacuMeJM2C1SwCKIvLtgoWdMGHdycVq/IKwTZDbm26VmLCtZ3GO2?=
 =?us-ascii?Q?FSOZihokmlMos+hBEJwfGG5Vxf9F5bxnOc2g2V9hmQSfD5A5ZNojgo5f2S2C?=
 =?us-ascii?Q?Nn01Zvs4GZEU276VM6g5RBzJgaP24mglg59jnefynMguRDQRo5dwLPz/S9Ho?=
 =?us-ascii?Q?bEs3L/vryIVzcA/1yEOo9Ti5DkXxq75QsRXEj8Rz4f1zCa93y39xWF1W5gZt?=
 =?us-ascii?Q?DC0uOXK+/3/IOnBeLLbpJlnDlcdqp8u/tn47Ja4KuJtpgk+ex7ulDIrD3hY/?=
 =?us-ascii?Q?iBP6JuFNcE4SxzL1kelikveQ31zonSrO6vsyTwtxXzhzefkSz5cnWfFkF9QX?=
 =?us-ascii?Q?kE8i/aZLAvavGxbkWZJNFZIJQKf0NsjaiIPp7kMzk7IsPRV1ztOadpCsS98I?=
 =?us-ascii?Q?ekATN5f0gJwkVXPamzlUo/UhYGbMXMYIUR5TuXR/MutoFKgwC3KD1efJcxCB?=
 =?us-ascii?Q?1ILGJ3STkPjByVTa34/SEBK4TZbCKQRPMV1N7qAE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e412d4d1-102d-4dae-633b-08dc9febc79e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 07:50:20.1129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUMU/qvDJRCoRfrTBDL21fpZtkxPFsIKUS5cYbPgcDHu0areW1sdAe6zVZPs8gfK729WOlKNgtc6VI6z+5Usvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8652

The NETCMIX block control consists of registers for configuration of
peripherals in the NETC domain, so enable the clock of NETCMIX to
support the configuration.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/clk/imx/clk-imx95-blk-ctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
index 74f595f9e5e3..07c70c0a53d4 100644
--- a/drivers/clk/imx/clk-imx95-blk-ctl.c
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -419,6 +419,7 @@ static const struct of_device_id imx95_bc_of_match[] = {
 	{ .compatible = "nxp,imx95-lvds-csr", .data = &lvds_csr_dev_data },
 	{ .compatible = "nxp,imx95-display-csr", .data = &dispmix_csr_dev_data },
 	{ .compatible = "nxp,imx95-vpu-csr", .data = &vpublk_dev_data },
+	{ .compatible = "nxp,imx95-netcmix-blk-ctrl", },
 	{ /* Sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, imx95_bc_of_match);
-- 
2.34.1


