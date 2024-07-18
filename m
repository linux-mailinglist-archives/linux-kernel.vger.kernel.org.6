Return-Path: <linux-kernel+bounces-256208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F47934AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1213EB22D69
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F1C80BFC;
	Thu, 18 Jul 2024 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="htYjai+p"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FDF81720
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294008; cv=fail; b=Twi2fC/maIF+vVYaJW2mMKtEg5ES81EZ7Kx6w5hIk6KoiqSKJxxgXHNsXjLYBvTNGria9I8It1XXLvAQNUBQjwdsty+GSC4ysakcYKdy3Mi4Dwz9W1sX9CDq6sA8UeyCl+zE/ZnNS9SH9dJxkLrcla8sGKNnXQzWTqoKHWVX+qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294008; c=relaxed/simple;
	bh=gwK9rqDRuR5aQaj4cd+AOFq/4qWreDTjsta86tg4hSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XnfyaZlPoN/vlTnvhr4a2e8uss8HxwH5YTTG+8C3hWGVxSL6jKDDSyED9qJvg7hYuqECv1Xlwzz8flquFZT10NVH4iwTY5Yy4PoxAD1nat7L4twAshqtgo8EWHskCW9zZdjwrVpmgcAr9W4ZJZ2JZJkfVvnCEA71So7c+dSrZQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=htYjai+p; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQ2GjhSqt+OMVZ1nS5p06PZ3m629x1BQTqNXX3almXsPp/kxzwKqbL5YYXD27vy9ig46/T/V+wi7JWjh9lvAf4X23QNaHpjCdayjlXLbNi9tC2MwRaDQZ2iZ3aNAdmuybbzJjPXyoJLyTrl0A6L2K6zF2/c7b6ZG2Xoo+Ahn+TElfazTa33URfsNQszPyyb+so5qYsXOi1CIrXYuj+AQlcaF+PvuYJzWHmrhOOB38O6mWk0omMcBf7vb76x6xOkxOPkUjI/sQ4jUlisRa9dZUydY4y5rG0PA/s/KS5L8FclJw8qQYYZuRZB2ZIS/PJEmxOK3eIpVdMmI5Tp2fMG3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUlN195iaHMb95XQfoOEzASW5021qCHYsHsY16K2Zj0=;
 b=c+hKPeki0sh69khoyegCpF8bGRQUeK/AG86NXAWRB7n+XwarAIh9vB5G+w8y3LP0pPx3zx74VqOcKvbgWQ4gb/GqWUqMBpPGJFRMnKfNEkhD4j1yhqq+C99ABeAn8/LxiMwx7rxYgYkV0b8OHyGM4PCr9TMIK53VZrqQk8MIKv/KOhY8Kd4B79QcBmQLACRiizEIi+kGLaCN04SzBedDh2+4dkjdcxz/RAGxcOtPS7Q592mJd1WedNU0MZERRWOrCQeuVvausA2VKPLUh6+K0UBIiejM0YqLYFPs3/4Ah9z6Csszf2ajiQ4iXYcC34LC0+Zs+a4JbpBwZy6xPuBPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUlN195iaHMb95XQfoOEzASW5021qCHYsHsY16K2Zj0=;
 b=htYjai+pCXbmuQEASdq8ZwVkL8NHmgC5B74xD3jVMF0NKKbosXik2zAyATxmlWaYh36yGpfC/YEJoZASr1tY9vMmiHkbpQmYPiN57LNN0NQKc7XkEjlaxBP96sZ2V/qqJT0OKP67vqU6hBpI942djsZojYrqzItR98G4Zwh8lug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VE1PR04MB7456.eurprd04.prod.outlook.com (2603:10a6:800:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 18 Jul
 2024 09:13:21 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb%7]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 09:13:21 +0000
From: carlos.song@nxp.com
To: miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com,
	alexandre.belloni@bootlin.com,
	frank.li@nxp.com
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH] i3c: master: svc: adjust the first broadcast speed
Date: Thu, 18 Jul 2024 17:13:29 +0800
Message-Id: <20240718091329.3788619-2-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718091329.3788619-1-carlos.song@nxp.com>
References: <20240718091329.3788619-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0203.apcprd04.prod.outlook.com
 (2603:1096:4:187::22) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|VE1PR04MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: c61224b3-90b2-44f5-ffd5-08dca709de2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?93bdetkHO6Y3epcENCDNupmT6VOltfh2y6YpoGcEjOcHuSJnyt4GuSMk1tML?=
 =?us-ascii?Q?uzqUcpSYqI79DMir30MpPW1jys5SZoBFCJb1Put0okAzIVJzZ1o6By81O8No?=
 =?us-ascii?Q?LbKUJD9+Eg+bwekq1kRfCJhr2/bG56y10YHg251WrOgEKCbCSh5+jimXScRX?=
 =?us-ascii?Q?gMOPE2cEZkwSiAQgU2BACgQpNEjQts9GwJgpXCFfMlcKiquEPX/sYdzkpEfp?=
 =?us-ascii?Q?7wEciy1ktPxxcL0iJJrLsrsfDwdivdLwo5YcOtCkTS7XIyoBLBfuy6nEzjdd?=
 =?us-ascii?Q?IAGY76c+QY6VMKdAhuiC3lFInMfsRTRIp8QirAjUfjF32ppmwTQfUMYuPILR?=
 =?us-ascii?Q?HE2/uJyyTGITqRmKJBRhzvSGPO4hcOIeNts8SsDrSgCRJMsD9I4SLoJtrDT1?=
 =?us-ascii?Q?WQ5cAN57FXsJZ4b1OuVZkPPMJqVKCbQsBSXYS5mRZ/1XILE+dRuLjIT841ve?=
 =?us-ascii?Q?0J3ISz25AUutBBFZ6Wq3KJjtmaTFaP6g58WviUnlODE7M/8zb2Dn5OOw9qqk?=
 =?us-ascii?Q?69a61vZjiYig/1gBlobLutS1D71E20nYUwxQSOdUSoMKLy8ehDbTOFK9PFuu?=
 =?us-ascii?Q?VXu2f1HWWvk34gXy1nh8TCX2vA3Li+pazdBRtTW0/443vfB4aMTD5aHDKt7W?=
 =?us-ascii?Q?idsMsmNseUOrRTtktyenmUp67ncDpmitgVXLDiRWR0qbnKtDgMHLBAO3RWo3?=
 =?us-ascii?Q?EVcCS1VC2Ws7+9mETv9Y3+qUTPekOJSALuzE31MW03qfcSZiKNKchVjB1b81?=
 =?us-ascii?Q?lqTAR7XRVK/PEQBgC2aatGvSC8d/b5E3JsdAzocXZecydGS4L22c9cVmdO76?=
 =?us-ascii?Q?xjnQgrKj+Ne+2xlY1Qcn9Gd3Jz8Gk9GLL7Bwfxn7SiRPXZEuFEpzioZy712E?=
 =?us-ascii?Q?fSWq77AA5rMUJwqmtb9dSiCeYsFHVMz/VulOOt/2ey9riuLoiy6wp650Msod?=
 =?us-ascii?Q?auk6GPSqdMai2ZetVDPLW/T7B/qNK3pR1X9gAIb+5rvPDu/D6ug835eCXgRh?=
 =?us-ascii?Q?SBUCtCUPEKcHT61S2QjtZFi7eWd8eqElAmObSSrAW9Hf7wU0PX27v2K4U3qD?=
 =?us-ascii?Q?Gf3JGSeGzXTsLVCzK+RuKPZp57WgtNI3YVvK1eYzDoPVNX6AzaA7CGODrldx?=
 =?us-ascii?Q?ufUc8i7CZMergXMn+hU9w75kZdt38BTf8eCnHCPuxD3F1VNIm0MtFSwXdqzA?=
 =?us-ascii?Q?x3Rol6j6lYdIzi9Kl0Xqo7MCqb3NuXcj1nujVzIqWSL4azFzx5qt6OgOLd/J?=
 =?us-ascii?Q?QseBXdrxrNXtv3p4UnwAMbj1Cpb7OPWltuj6/r1eufxrwUZqNGJeUl9ponFt?=
 =?us-ascii?Q?NOA6th3v7LCWRK6mLYOJb4rnUJtLV88Kjf1jKgrgMoozABdXSDay3RJEDF83?=
 =?us-ascii?Q?lYOK9CP1pSPhQWLxhIynGfYV/f6MXcpXf3+QHeC0qyau/tNkzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wW4QDVF4ZJZj6YgcRDqFy9gcqiHXLRDrTnAc844Bh98El7gfJ6R79+fgMzig?=
 =?us-ascii?Q?qS2hEVEUn6w1m0BUr+3s5K99CdMR+GRozgMV155JnrZ1ZrjVvF84bgVDg5/v?=
 =?us-ascii?Q?GyeFL5ewG//2YAwZ4jF4obPvRx8WaAYfBhwCkUzH6LNWoxwhm5ajZYzVTuCP?=
 =?us-ascii?Q?iZuAt+T/6psMhAPcG0zgCp25OWf/NCDiQ1+M3xaD2kmZnkmlNaIUT88icgI0?=
 =?us-ascii?Q?RXRCBCM4YMJkC7KXNyjVPJdA6wGRigR2a68JbTh2jO/v2RZy5aLkn6Bsb0cj?=
 =?us-ascii?Q?+yibr+w/Xm4gEQWMjzXRENuuY9V3FRWu/yvDWb0F6RbfwF1jc9bxHsPMA6u9?=
 =?us-ascii?Q?kkbC4zaAM2JGMlSl8lT727zff7hd15uz8l3d2kh/CRrSLW8F8pknsns0DfZL?=
 =?us-ascii?Q?9Yx9XX1aUc4bXLpPKT686C7v0HKNHdb/wi63lbJDG/c/U9MKYoZwSXmbiRHa?=
 =?us-ascii?Q?wStKf20lKycfEVchdALFeuLiH6ozkpOnpJHwAaPfRaqJ6nMpW0LLvKu8cRGI?=
 =?us-ascii?Q?PpHR/p2pUomIZIKJSYtbvKsaeWTEZYL5/9AkU0tsTuOGReEqQGHqoy2seBlU?=
 =?us-ascii?Q?ShvS62mi/bpyN0sg8c+FxHhGxujDdJUC5OigMcUJhDRi3MXMyhALKnGv527p?=
 =?us-ascii?Q?a52umks1Ap/A0hNMfH2KJEhOyrJ5Fm/6p/IggS0t2LCUBGihup1yfsI6SnIQ?=
 =?us-ascii?Q?YDHRPb6zB6wQ2kgkhrxO35SUovDkZ28gltx+bPh3sjUytkNUeT6wLNpavDpz?=
 =?us-ascii?Q?TFk1r4zsxnOfi/4SbEKoPYp+3htwQRPeTfLNWy2QFRHEPLlptti38A1RI9sk?=
 =?us-ascii?Q?jNkyVWW66cH5Xz9J1sHA/p/tChFzOzCURCuxdfC4CrItscEyPHPtlKaLnTak?=
 =?us-ascii?Q?2DnEKjVxOBdphuFgqxHsVelA3A/c1ai6U2N4HsSiON6h40nafsG3WUk3oavj?=
 =?us-ascii?Q?6sEQ0tYlxr3t2/HGqjA1ZSoyKv4mNYV7fByq3DKvwwgrVfT459TIy6a/BU1F?=
 =?us-ascii?Q?V3fSyhj4PNdv5vR/nLX1lPfp8DnPjP9MzU0yB27SvsPm22GJAgPLBsRCv5U1?=
 =?us-ascii?Q?bPXKR+ZXDCoL5cXoSQqgw8wBu/neRVGOO8jF1hiUYR9YIJ1HM8TGlmv/14Vc?=
 =?us-ascii?Q?lNjt9OBP9c3X6f81wfj0Zg87dSI/jLTv4Sr+v0MKOrLrxIiAGHs4iOarcGsh?=
 =?us-ascii?Q?Q7zUiI1oznCvCfBz1GXdamRqflQBenMwA970E9Oa51gzwWYO+ljPN88UIUG8?=
 =?us-ascii?Q?LHo0740q4jAsjUOqIkMwqPhHXG+ED5BYaCOVkf4ooNxP63nT1GJJapBcHplJ?=
 =?us-ascii?Q?FMpLf4Xdp0o3bQvdHrT6L1fQffKklHXKUr1PyeV0ABn8boGqFh0ahnb3G88O?=
 =?us-ascii?Q?Z1KMfacLdhNkCv0BwyUyZLFSD9wN7GoqadLvEG6mHk5GM4VluYh38InsQu5Z?=
 =?us-ascii?Q?o+VIe477b6otV2EctVTuknnVF+jTREEGpTSMItsanlgZXwu+X4afuxJpcngW?=
 =?us-ascii?Q?PhTHdnmZcgz77SsoqIv4MSJTXMO7NqqPICN3Ap9+as+VarWkUWO4NaUVkDng?=
 =?us-ascii?Q?Jt6tek8jntUf2R0F6xdb4BMopYVPd+zH2p0OBehi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61224b3-90b2-44f5-ffd5-08dca709de2d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 09:13:21.0640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itbjIQzCnvXwPBlDUedblSfHeQt9Gpgt6SNfIasDhonmLbRLMHGAfZ3FEIku5GEEPhSzlltCSUZAChzjEOTvjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7456

From: Carlos Song <carlos.song@nxp.com>

According to the i3c spec 6.2 Timing Specification, the first
broadcast open drain timing should be adjust to High Period
of SCL Clock is 200ns at least. I3C device working as a i2c
device will see the broadcast to close its Spike Filter to
change to i3c mode. After that I3C open drain SCL high level
should be adjust to 32ns~45ns.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 47 +++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 78116530f431..2d68c8d34089 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -142,6 +142,7 @@ struct svc_i3c_cmd {
 	unsigned int actual_len;
 	struct i3c_priv_xfer *xfer;
 	bool continued;
+	bool slow_address;
 };
 
 struct svc_i3c_xfer {
@@ -214,6 +215,10 @@ struct svc_i3c_master {
 	} ibi;
 	struct mutex lock;
 	int enabled_events;
+
+	unsigned long fclk_rate;
+	u32 mctrl_config;
+	bool first_broadcast;
 };
 
 /**
@@ -531,6 +536,36 @@ static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void svc_i3c_master_set_slow_address_speed(struct svc_i3c_master *master)
+{
+	struct i3c_bus *bus = i3c_master_get_bus(&master->base);
+	u32 ppbaud, odbaud, odhpp, mconfig;
+
+	master->mctrl_config = readl(master->regs + SVC_I3C_MCONFIG);
+	mconfig = master->mctrl_config;
+
+	/*
+	 * Set the I3C OPEN-DRAIN mode to the FM speed of 50% duty-cycle(400K/2500ns),
+	 * so that the first broadcast is visible to all devices on the i3c bus.
+	 * I3C device with 50ns filter will turn off the filter.
+	 */
+
+	ppbaud = FIELD_GET(GENMASK(11, 8), mconfig);
+	odhpp = 0;
+	odbaud = DIV_ROUND_UP(master->fclk_rate, bus->scl_rate.i2c * (2 + 2 * ppbaud)) - 1;
+	mconfig &= ~GENMASK(24, 16);
+	mconfig |= SVC_I3C_MCONFIG_ODBAUD(odbaud) | SVC_I3C_MCONFIG_ODHPP(odhpp);
+
+	writel(mconfig, master->regs + SVC_I3C_MCONFIG);
+}
+
+static void svc_i3c_master_set_default_speed(struct svc_i3c_master *master)
+{
+	/* Whatever, setting the controller to initial configuration */
+	writel(master->mctrl_config, master->regs + SVC_I3C_MCONFIG);
+	master->first_broadcast = false;
+}
+
 static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 {
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
@@ -624,6 +659,8 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	      SVC_I3C_MCONFIG_I2CBAUD(i2cbaud);
 	writel(reg, master->regs + SVC_I3C_MCONFIG);
 
+	master->first_broadcast = true;
+	master->fclk_rate = fclk_rate;
 	/* Master core's registration */
 	ret = i3c_master_get_free_addr(m, 0);
 	if (ret < 0)
@@ -1250,6 +1287,8 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 
 	for (i = 0; i < xfer->ncmds; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
+		if (cmd->slow_address)
+			svc_i3c_master_set_slow_address_speed(master);
 
 		ret = svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
 					  cmd->addr, cmd->in, cmd->out,
@@ -1259,6 +1298,9 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 		if (cmd->xfer)
 			cmd->xfer->actual_len = cmd->actual_len;
 
+		if (cmd->slow_address)
+			svc_i3c_master_set_default_speed(master);
+
 		if (ret)
 			break;
 	}
@@ -1346,6 +1388,11 @@ static int svc_i3c_master_send_bdcast_ccc_cmd(struct svc_i3c_master *master,
 	cmd->actual_len = 0;
 	cmd->continued = false;
 
+	if (master->first_broadcast)
+		cmd->slow_address = true;
+	else
+		cmd->slow_address = false;
+
 	mutex_lock(&master->lock);
 	svc_i3c_master_enqueue_xfer(master, xfer);
 	if (!wait_for_completion_timeout(&xfer->comp, msecs_to_jiffies(1000)))
-- 
2.34.1


