Return-Path: <linux-kernel+bounces-270770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92905944501
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB001F27B12
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E8216DEC1;
	Thu,  1 Aug 2024 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LJF4RP4i"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53089166313
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495419; cv=fail; b=W7ilPvNh/Zl0l1TVreukAslj9KYQXzedtGfjTE4/yyxM3KcW1jOO6xtiK7EG4PDecTL9M3JI1QiDHKZ9dVpDmgUQiDqRJzi9RMNTKx3GKgmWy+XJt3qX4ahqL4BRsbdfUvuQd9qf34LR4CSqmoY5wgvb3RuNingiYiDw4Y65S7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495419; c=relaxed/simple;
	bh=sWdV6LuJSdrt1n/ZNWIa2i2z5nifFq909j2Cyf8xx3U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nnxC985DPSSMe3jV3AUFszqqhFsP3tOuCFGSXnEEB76c7EAU4s4QKYH1rBNiWFHnXSw16oF4K0Sl+aokaAhP4vdlsE3792LPx21cotGe0X4NGogJPZNZDSXYBgBdeayeDELCWQGGD6x7FI3NGtW5RupmrADxSfEUXtkHCxxHAlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LJF4RP4i; arc=fail smtp.client-ip=40.107.104.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vt9gJYaia6/bqTgVizE2hAlCixdQyppChZ0qSqw1KpOXIPwjGlOwqp16mA/KSgdjyYeF862BGKxE7pDEtkAs1ckm+N2TCr9VCuayOEKt5b2q1fK7kEwTtm5SXdxfashQSpBJnc7QzIvvprIkkkNFLcpzdg6yRKzhefu0F8OOdWRKuHkmyQWBAdB2pJWoTvvTDNnLEyd88nEEVJKxSuyi2DjzBc1qF7nUar2hw6lGWElElKqGhU7sc/rJdernGJHP3VxhLqIYv6Oj+rFdxTN5aQ53P1HhjUvBseHE0AQCdBOzifPyN6nnpl9dmvTj40J5r1RL2QbtyaJKtDrnoW4otw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2gecOYpU74r7h0hfQ8e6/mXufDaLZiBVGYuVjz4VXM=;
 b=Gv0B5uvv4Ud5W3F6VLeeVhCAAP7MIYMdOShjTs4OSzBBrgiamXBQt7KB/gkT2MU2ubryCy2njvz3XboaxGWfC4tnCQ/dwdQe5jA1q3/XsbkZmwih0gwD1L92JsS/uTK3H4VeA+JHQ5cWDrf08oS08BvLmUQdHKa3TyB5WqQGaHSo8Jm3TnrLeHsjDtinBPW+1PetadxzhNe3e7ruJuI7WhOwA02Btu/mRi5tfpqJjjtWaCHEpt7Gbr1CWt2TZFnDUkpRICMzRtoiJlOpTBNqll34apVccRZEBb954Qf1Q4a6omu8KO76I0vpI8Ekol3JZwTxyekKxHMeF2Kq1QzvKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2gecOYpU74r7h0hfQ8e6/mXufDaLZiBVGYuVjz4VXM=;
 b=LJF4RP4imcLv7Mlx1dykZ0GHeEbIb4odeYi+YeOpiqQW56RgZHgfwK0K9qfhcpTG/sjz0qb6tmRwCbCqAoBJkSQxa3wDAojpzkq3ZfIfTE6txs5Nbpow0A2EoWMqle/0+XFD2ATmFRlYGOZF5WyXeV44Eo5Z6KoBVPwVgle3VJ2Or6UZtW7hKiOw9Ydd0Q22BmjgYIaEkDKlVW31iZl2iYeJi1aWCeuv2+en8JXLZQ1yjiqbOb0F8wCcg8hhnJZNJ/7q3F8Autxwu7aBebpVbh3znqdPQUiVF3/sHWXfZURVDWEBZfRevbagyLHEanxo8tiqwakUkmFIFojM5uIIVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB9352.eurprd04.prod.outlook.com (2603:10a6:102:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 06:56:54 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%5]) with mapi id 15.20.7784.016; Thu, 1 Aug 2024
 06:56:53 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	alexander.stein@ew.tq-group.com
Cc: jun.li@nxp.com,
	xu.yang_2@nxp.com,
	linux-phy@lists.infradead.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] phy: fsl-imx8mq-usb: fix tuning parameter name
Date: Thu,  1 Aug 2024 14:57:16 +0800
Message-Id: <20240801065716.3819399-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: be26117a-ff00-49da-4c6d-08dcb1f72043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dpSdFuGMfCnTTwPoaFFLV9vQTjNhlzCT+rMg3yQaj64fA8S8HEdXfrkX/vLP?=
 =?us-ascii?Q?9t0FqIcFyxKpNg4WIoGNnMMN4RENY2CMlL+9IdPUg3f5DllSr/yIU3MJoe5L?=
 =?us-ascii?Q?k+rTMr6ZEB94oAsiJ7JK5rILzxcyRjJzzsWjKzgTSBB02zuMKa6tx9ljy/+z?=
 =?us-ascii?Q?YljOwBTZph63lrTvm8S5sU66CRR68MyUbclLLepCFXCsGPy//wM3CNdWQ7Kd?=
 =?us-ascii?Q?XQtRPMIHCuYLmzBmdlmuxmph4dQJo73cDKUk/Ds25MGpiUAW56ieTmqGRrNO?=
 =?us-ascii?Q?EBDEw8DEbr7hVVs0ZFmIFKCh/iDOFpUua2w0kjwytplUegN/GMRZzuUEVOLB?=
 =?us-ascii?Q?XvQz1SdA+mSFTQk6jCpcZaQ/U4RFMStOwYbIL7CHO/RgcNstfMRwf4jjHqnh?=
 =?us-ascii?Q?Vrod6NtoKVI6riKcRV5FBeIyEXeaWIHR/fIY8feQ1HVrbJv0cEGmDP8fl5Ok?=
 =?us-ascii?Q?acyjolkZSCaBzDzEaokiYXkutKipLaeP5dl56IaqFZ0FrTtEzz4IPu1f6r0p?=
 =?us-ascii?Q?G94QVfcFTy5Jypa/PmMUAkCPcrW71WT8WDMJoGdL4Vr0yYACDcWdz43jkVYx?=
 =?us-ascii?Q?gUnTFQzJsdtcHSQACqVtAwbqRUIc/jEX0wPhNzqFLzJKVSP7BejtjoNHzkHX?=
 =?us-ascii?Q?j+rdQUrtnd60xqe8gdC5iRGCndPTCuX2VMO0ml8A8R8DAQEQRS6KtQ7eSoIG?=
 =?us-ascii?Q?dnKmudoaQYLpp6HQSA+K2ph+4GN463U3BU+OEyv5fTfc39b4fv/9OdVByd4Y?=
 =?us-ascii?Q?4WZFGi7g0tt3XVk/Qg0xVF77n9sfG11I1/4R0a2R4He4vYNzHd7gJRrZjXvJ?=
 =?us-ascii?Q?xjcOQuliSN+HbzVi0m7vjcgZZcK0LGokFusW+81TT31BDxjYs+9cS5vISTsk?=
 =?us-ascii?Q?fPHQA0XDkTR+YG/PFi8Neut7xpUuO9htPPjk1nC3eyySAPfUuSaJ/jeRL9ci?=
 =?us-ascii?Q?d+GNyayvntYWuyEeNCqIHX3cFFCmAM3IEzskyaMRS9rxmvr1qwh/BoIJGeqf?=
 =?us-ascii?Q?EC2HbB2nHC6XAHMQUd12e0weF0tyn2fZh18VAefzuL0t1/1208GkLA+lJvT6?=
 =?us-ascii?Q?MPfZuHVyfi7zgQ04L5uOQPASiZExLfrLg+8PG+C9dLdTDJ8VmzTU7MBW8OY5?=
 =?us-ascii?Q?saAmVrq5YTcpG9jupBEOOAliGTvS0tEqHVqLCAqwzteDRvnnYkEQHuKDDN4r?=
 =?us-ascii?Q?1W1vf0C4y4BlQnyA72s6GemGBJ6zDMYiJVnmmvPk8hKBgr2P8aN3vqav3gJz?=
 =?us-ascii?Q?5qZoo1zbPp+1zmdh/3l0JJZNYAc0w/GW8UMSmgks7qsl4RjjcnTFJHUqPvl5?=
 =?us-ascii?Q?1isOXQRaRvoWPMUP0f5jIW7esfz3C12tguUXJZSQ/MzdiNIQSxFRWQtQqzch?=
 =?us-ascii?Q?mlb/Ayn0HuS25m1eWBf9dUutcnulbNwjfSqZo2JHyUwKonw4hw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LyJ9MqqKx43JSgaormPCBdfpZGZdRaxettv9VDBinO/4IMhy70QkE5F8dlf5?=
 =?us-ascii?Q?zZTH9isUegtq8fyHzUvaHFkXZU42N7Lxby+qPwXtekNGw4bPqVwXmlsUXlr8?=
 =?us-ascii?Q?rN5NVKDsASWksg2wlYKp9JkEMYWnD0O6kRu798DqRrPwwTbfFsZ9SC0wy1VF?=
 =?us-ascii?Q?FGJ2MwDyJ4F3hDs8xBOtlzMGRlM1Sc8rzXF77AaKmM3RgQbSub9ROh9Jflzg?=
 =?us-ascii?Q?aNvi6/9iv/MKuX9oXeu/XuHke1ckZW68uDtmpJwBdbipHly6C2e7rq50m83s?=
 =?us-ascii?Q?9WlVk52wRXYS48oTGqBuLR3q/o+BJspsiUvoYbzvdSVhFbXV9lz1Hq4DtqUq?=
 =?us-ascii?Q?ou8iW4WY8T5i7FqEJq7HuMQDmTtv4dvBeq0qLdC7L+J6q6IkXm6piE8BdsXB?=
 =?us-ascii?Q?5baAUKH9Xxc4W3wqkUl3iIgt1jAWEv0B4WeWl5YwyiDsa1L1e+Yuv54Xjqdm?=
 =?us-ascii?Q?leT5yDaTphLCYz5zml7Bxq6kOrGs0bwWPP9UOF7bdWR43e4/CgAmRDEsdKRj?=
 =?us-ascii?Q?LhyZYmvAv6LcJrmkiRZRO12IZNbdOmAArMsLYVBQ610DNzXMVv6TXZKFGfXA?=
 =?us-ascii?Q?nvz8/rqU7PT7KvYY9cNYY4TXHNaq6j8Of/veS4o3BoewEe4JWP42sA+pSikg?=
 =?us-ascii?Q?7D+nLLqhHSNH97pQsoakiVInkQLhS1laczNBUJPr1oXOJGAC+1NejZJmbail?=
 =?us-ascii?Q?9u8LNWiasSbJmwrl8QfSBYFpxTEk9+9WZ1PkIv5jwyexisqrKeUuSJtdJdVz?=
 =?us-ascii?Q?UAUwITc9wAev8ERVsJNwpf5q5KVZH08dVSywa9CMtVAKkCRns8oDxUdgt0cx?=
 =?us-ascii?Q?H7HTsO7CKBTqeNFPP9IGTcIT7IZJWVVJqgYbvTzD+05XPUfl0RXEZdJRIWOq?=
 =?us-ascii?Q?LQVBjzJCffJmWFn+45hNJTqrulxeSTUmqbKXW3gvul6aqAULi+ZavbMtGv5t?=
 =?us-ascii?Q?NVrcuxooVLCuXp9yjaCSyGv+YKdCh9rmWv4ai9q5ohwZXfAPCo4hkixCWxWz?=
 =?us-ascii?Q?9MgeCqaU8G2pDVWHMWrDiedDk581cUMhoEOV3tn7xvBp8c2zaGfqBTON9m95?=
 =?us-ascii?Q?mVUAkQihu0TvEPSEfuYNsZZiTU816JqqquEjOzfFHlNf4QFLTz/F7XQhLaUD?=
 =?us-ascii?Q?vGL0q5LAwuduDglTmnNm5rDFZL+XxASzFs9OvLaeALRU6zUv7OvUR/NbnMwu?=
 =?us-ascii?Q?yRTgusgo75qH78pfifrzV6B19CTAhBMBTA3faebS+DNASA/Su4pnIRoq8yYP?=
 =?us-ascii?Q?KNDDvERsG/H0niGZHp0uCBhSEq3ZBasluM/nBKwietp7FVBbpm2RAn/hr5kg?=
 =?us-ascii?Q?7y3eP6a8hjG7IhXWk+Ev/1YAInpdJITYe4lMYDoYm+9kUr39MlmDGdp3pWgO?=
 =?us-ascii?Q?Wsb1XNha/OWUSDW20w6T7BqX40b80pOodoLnaiqeLySMhcwZYPMeChBURdX7?=
 =?us-ascii?Q?k0F6gkTYrixi1eBuXWtpaXlc6mv8m799WD9CrXP9T5ch801qn5wPthFMTQ8m?=
 =?us-ascii?Q?cz+meaaprkhYyxneONGP7BvaPk3vbNaoq6Ur/hQVMc3kc8zMsvgIxi1WQw+0?=
 =?us-ascii?Q?74wmxWJpnG3USZVIPQGVxoCNqJ9gud5T6PX56DxD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be26117a-ff00-49da-4c6d-08dcb1f72043
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 06:56:53.9304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lfr026KBGOHaG5SBnyWfxNF1OUN1+H+tuQ7wjagDSyeZV10caK/UJ2Qjcl3FVn682vx9Fhuq3tcB76+1ZJO/5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9352

According to fsl,imx8mq-usb-phy.yaml, this tuning parameter should be
fsl,phy-pcs-tx-deemph-3p5db-attenuation-db.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index 0b9a59d5b8f0..adc6394626ce 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -176,7 +176,7 @@ static void imx8m_get_phy_tuning_data(struct imx8mq_usb_phy *imx_phy)
 		imx_phy->comp_dis_tune =
 			phy_comp_dis_tune_from_property(imx_phy->comp_dis_tune);
 
-	if (device_property_read_u32(dev, "fsl,pcs-tx-deemph-3p5db-attenuation-db",
+	if (device_property_read_u32(dev, "fsl,phy-pcs-tx-deemph-3p5db-attenuation-db",
 				     &imx_phy->pcs_tx_deemph_3p5db))
 		imx_phy->pcs_tx_deemph_3p5db = PHY_TUNE_DEFAULT;
 	else
-- 
2.34.1


