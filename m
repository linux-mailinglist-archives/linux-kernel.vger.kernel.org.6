Return-Path: <linux-kernel+bounces-369267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5439A1B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F2CEB22361
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D22199954;
	Thu, 17 Oct 2024 06:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SbGVjIZc"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118391CCB56;
	Thu, 17 Oct 2024 06:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147894; cv=fail; b=JPXf51+1jzEWIjI8RNQI0mcqGwvypy2QPHk5EL2KvC1VKVr1GFWaQR2xiws804CF7Fw16X06QVaR2r0W27CDiaaDJtsjKKWqWgXxOwZoiFSuJDkKU9KSKcp/e6XrUWmnn+xb/iT8VjTlcZTw9vOR/wT5spCecc0G8abdpHd15vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147894; c=relaxed/simple;
	bh=fZvd/zCPHef6ZiTxYz4McV1+42+Olzdfim0lQvmVwNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m4YU5QrEQT2O9TA6o22h1vwNBIKrt0bbfqb0Ow8ds40JPc6wcFg5WrfcefXnBlVQbt4UJ+tf3ryDc3t9lbucRCtCDE48vZvHnSaGFvcDBjoeq962LI6if86pMUz7/XEOsP4dpozuX4UG/nVZ9C6Uv+Ps84P1MfcPKxxstIicO+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SbGVjIZc; arc=fail smtp.client-ip=40.107.104.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COjE9S9yOW5KHYBeWuM9xZGW3GZRew8w5JoLfJhlkGp2GDJ+QXFOUwrHV8V/YNahMNNflJSxL8wYBXPgQGW1kBZijsNkeSVmITHwfXMwM9Ih6qnclSyybxo1HPLEYnbmeDG+MD00/HV9X+fko/4kWeVPYOTPWVAjvN/uDa7dFw+WD4lVfbJpWvJscMQEwQUuN3M6m7jlCxCGz+fMw317a5BSIqQgREymKqf6YVSqKtxHfqIc37+kZd0qEVxlwTdlgE3t3DW7St8szYPztgqEsQpB+H28uwAhSe7EJhzn+gABlFxXLU5aX3rW+D+ToZnG7QTNPlBSBhPbnydjNHMS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUlbGMus6WxOxhgtcXXQhNnYBW98XmOpTtVXhH91RKo=;
 b=Nq1rRD59vRE/r2rQ222PrWIyg66VCHDh1It1Z9mxI0F2kKhbyGYT5HabqODYxlGPGgudU400UkDBCKR9edOXaM2EegfdSN/941GLLHAfJXsg+1Hk9yRpMpmZ3GfpCF1lyqcvzI0a/Z3fSad9t34xV6owGfcBqyiI/xubm2An7Dall2lyxgtjPnYRre2dcS8m+W72Fl47fTvzkD0TTQzsIIKumv71uWHXJRDIluaWD9SUFHefMQYrv2fp5JXtsFQ91LUQfI3wGAl3F4GH33iXA4S7T+TRJyBSrD4h06b56FKTOIcolecCo1aTJmKrQ8H4nB3ruFHzIoQqjbq8n2ixRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUlbGMus6WxOxhgtcXXQhNnYBW98XmOpTtVXhH91RKo=;
 b=SbGVjIZcHbzKhzNplFv4bgHC9SnpGCCNLqi5ouz4Sn9onNG9TigdoW3gAlzrwbNdymMiC/quTy4kNx55MDddi9lwPlc+w2QhFCLKLPYK3eWVbu5UGxbYFQgvhEX6javtVOWjrpvNyGpv0+qyTNL0BcqfEG926y4pd3MLSl73nQZVr5Yk8MAsKpqF9yq29XN7zMa7Rsh6mQm913e98WPZpriyD0LJ1QwXfnf9RqcNBDVlQ2G6OtI9AvwO4P81IkJbUm9XebGSOor3iwZ7DVI8clWa6I6kDyMK8NuzIl1C9InzQ3Q4UdlzIoTBFXDUNHlrQ9AqykiUv33iumHdxEFiKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by VI2PR04MB10148.eurprd04.prod.outlook.com (2603:10a6:800:224::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 06:51:27 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 06:51:27 +0000
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
Subject: [PATCH v5 4/4] clk: imx: add i.MX91 clk
Date: Thu, 17 Oct 2024 15:51:37 -0700
Message-Id: <20241017225137.1158924-5-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017225137.1158924-1-pengfei.li_1@nxp.com>
References: <20241017225137.1158924-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|VI2PR04MB10148:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b39a2c7-deb4-44f0-377b-08dcee781f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BTpFehc78MuWcjemGaGtzzrXgsWsLesY4DThDWQ7NK/YAA2vW/bUgpN7Wn2y?=
 =?us-ascii?Q?dtI7maHkR4fac4UTP6ClolKppivdyb1TCu2u/g09oRV+Z7S6XsmGtpbjjgWM?=
 =?us-ascii?Q?5hBHwHcFyg4FmO66L0LuiM4fW3z31t7cz46tS1OMJFEudcSKMoroDzfv73Q9?=
 =?us-ascii?Q?w9j3gtEsV7wYlH5Kn0rsl4uPEu+e2yWkymQxi2c1Fl2/hbfnvaBhCuOhyV7a?=
 =?us-ascii?Q?3QuBiAhAfjw14+HmZm0Z/xVA/90yoJYEGvsbZHCx9Sg/7UKwvR5yXxdC9DcP?=
 =?us-ascii?Q?WKli/qmDXxwQCibs5JQrrM3aUHk2+GEvEwOZZlOto84KxB+iEzOVsy0vxt7N?=
 =?us-ascii?Q?1JGE4umBic+9cDKx7IT+XKo5NgZv9lpCHaURBnE2cD+HexWRJ87uMC36uZH0?=
 =?us-ascii?Q?5YVfgslpFZx9cI1SpYkhTe5fQ3nMswatJWz1CoiI4NFNiV4IbC9mdC+Z/WNS?=
 =?us-ascii?Q?IwaC4ZSgUUVKmKhAhGND41JD337vISOcoZyJCnKG1MicRhmalD2x/LBdZlZC?=
 =?us-ascii?Q?q/kxA8LkoGvTereJLcAh/Yo3PGXueXBfqMIDoJo/EzZNadvKGY3XUEj28DDT?=
 =?us-ascii?Q?OX9Fp2AytGJ5cryRypiLRGpvt6+mHjhRAAK2+jDsh8oT0cMTNKw/ZWSyd4qZ?=
 =?us-ascii?Q?YeZVKs4VvNGSRhquZru2FWeAGtllVEI8BWfQElGpUkaBjTkPqk+GxDHdNz71?=
 =?us-ascii?Q?dF8SUZWo89ZL1PsCyKuZ3PVYDgKo9XM68GCpj278S0ukwV/aJpvb9MJn9p62?=
 =?us-ascii?Q?ivxOUGZkrbA38QCiJc0nILOURzYZ3y+LwTlipATrOsDPxHp9qC3Wu4k+OuT9?=
 =?us-ascii?Q?x5YK8yUV/L1idTmtA79+e3TVKKqQ+dmrqSjz3C/YuZoHE8fKQKKGAXHWTZiN?=
 =?us-ascii?Q?dWFrlUy69n+QtF8tx7cNh9N8UYkyE7fbJZcBEB+UgIJbio0KmY2ffEGz+qJ2?=
 =?us-ascii?Q?dEhcAsjWvJNy+QNMVDWjqpWfv7QfFJFTbYrQezAbSnqyHd64yMqZmUwsvcaQ?=
 =?us-ascii?Q?H8y7LVRoZfk9j+eKYMq2Ephh2fDCM7AuZxzGA56ZR8FAW6Qpsg3CmkZm2I50?=
 =?us-ascii?Q?Q8jl078X69VtW+em/m6BBJH1H/LX6ireTBIxsKBRm0vRnw1qcBU5uWxq2AXp?=
 =?us-ascii?Q?6KCqWeZM156qvWCRtehdvHVN2BLdw+r1OJ5tQeYaatnt+DXGNv2sMftKQpGv?=
 =?us-ascii?Q?VNPpgv2YqN7a4Cm5KZO2ZFJ23y2v7sy+ScfZ02tIIDQL0K/3CBDe/3Ouu9XQ?=
 =?us-ascii?Q?d2Ll9Xt7YMzASkb0J1z+ZKrGpAVQkA4U+ZOPSRk8S/Dk5NDYN7uGFUOAW8ON?=
 =?us-ascii?Q?5KZgMQuTfvlqQ9tAPih+eDQsuJUZU5htNfl38LeqSS3RaL+OEZia0aXEHDFP?=
 =?us-ascii?Q?cqMNrxKRl+lMswDePY57b+xRWt+R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6u9nUQOulr6Il/8fWSCp/upmkEFG51rKgwjK91CSRvLkiMMoATEQRabw27Zs?=
 =?us-ascii?Q?VHRex/FVf6Bena15Lbdc49o0uO3JqhCd7bQBqHK84ZrvCP/8ho3fG8IODDet?=
 =?us-ascii?Q?2zNqxhRpAW6QXIiomPffxyAhcKozDeBTUJd/Tlx/Z2ziMX5YRQYsiCZ9UlHm?=
 =?us-ascii?Q?Uw0kfmP+NPOIy/sJtWKWq7TUTtD/L5zOfftnbHsoIK1FD6P9bMzzMv3qX2Pi?=
 =?us-ascii?Q?24DxaJoQjLs2tnAp7dF793bMu88rB35tton2hcPMw7dHSchGR7wx2LOE9wxi?=
 =?us-ascii?Q?r7zA5DWnTPKrlV2N5OuZTbi4tz01yHjn9jOjJjaupQlcC14q9CHJBwnbrXYF?=
 =?us-ascii?Q?ec0Xhj65HwK93UmdQqovI2cq+l++WXIWYjfNSaRjz866nKZlg7kI4FfkyLm+?=
 =?us-ascii?Q?gisLWD3hh50mFp7qTYbo1YiYhYoO4MfxwbQIApmQz/dfQ1U6oq1HGlzaJznf?=
 =?us-ascii?Q?Ku8atTuu0BM40PGRIqe6t1AIiWNMz4RTdQBauvhVbcmAX7+vU2+c6bSh2ubB?=
 =?us-ascii?Q?GgJ5kktcdLg59Yb5iqfGF0abCBKwed81mt/RxT11AWipd6RINBe5eMHJHcWm?=
 =?us-ascii?Q?8KTB9rLQ6YjtdDnuEL9ltE1tiMyQ6zavTiqM84l2uJgmuGw1Xb/ImlUZivJk?=
 =?us-ascii?Q?HjvL7/AWolW6Bwc5WPA0H0ZXc7hN5WX1q5v4e2+/jUvEaBewGfWAYEqEgAXq?=
 =?us-ascii?Q?hTgQKUIuUTXkXyAcbtFYOT2teCcnfoJVCX91x3p3ThpZilTeJImHkZoG0krD?=
 =?us-ascii?Q?RMcA6yD7+zPZrz1TXixaxRaESiyX8XyAR31nnCRQahefj2mE9yNRsW+mzuxk?=
 =?us-ascii?Q?TsplCwxTnKqlztON4x6JfLGiFqgumCoGyK2EvYG00HABvwMKTDoCmJDs9LAf?=
 =?us-ascii?Q?P/J4khvl81Jg8dOqnNn1p6cKF2TJK2Qf8UFX70yA5UXb1REtBZ0UdOrz8X9K?=
 =?us-ascii?Q?CwgnoMreXKsTE6Nctn3ijN3QqI+eVTnPjYwGSWxTLaBnCO/ykeUEPzLtxnd2?=
 =?us-ascii?Q?gpQO65/GWMnBjpZ1wW5YOUsocQGNnI24PGyYL9IUhpqANYlBWtTHLvy6NdNf?=
 =?us-ascii?Q?J3cY/Qm5GEzQQG/fAhYtuWVG6kdKskJhVocO41u3iDd1tzP3Efd0ymgrgUig?=
 =?us-ascii?Q?PqYvTECUpAaEjhaVDPg/tnXkdv60E8UQsr6csljS4pc9qQ68yUnEvlaKJaP8?=
 =?us-ascii?Q?YD7QHlzL/I31rMsZEWUOLK32K2+XJNoDBt0w4KQvFBt+pdw5zfHkAdNhKUhH?=
 =?us-ascii?Q?kEc5uL2ZVpF4HiOWNTSkwdpKniXwDkQSLxa73imrSC3/uli1GxX0VKZd5fR2?=
 =?us-ascii?Q?lECF7mhMbukf2GIF2inCyY9Kzj04Ii4FJOFrC05rgvCRMriCS9oLYecxsZuQ?=
 =?us-ascii?Q?pkbY++d3cRMLiLRQGho2bltrlroPgKzM16tbXw+55DuEfEerTW4LVVbat5SR?=
 =?us-ascii?Q?RqG3aAT5boZVkhB9T1q6D5aRZnbdIAxbNe3D+5NBTNNFPEHsR3MOBPbCVg/U?=
 =?us-ascii?Q?Pv6HOySiCLa9suOxtmIru+xnP1WhLIjp7K1Y5/aw3vq3FJt6N3e/aGJnZZk0?=
 =?us-ascii?Q?DccFaiWAxpjpVm1seh3O4lqj7CzVhtiCOcXYac2R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b39a2c7-deb4-44f0-377b-08dcee781f67
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 06:51:27.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtteDcpww09A/fy2JM7KeGm0qqZF0THuaMXMjRoQbDmACbUWubDOvdRKxXWonyNkBsYn+0CGPiCmzs0ZgDa4qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10148

Reuse i.MX93 clk driver for i.MX91, because i.MX91 reuses the
Clock Control Module from i.MX93, with only a few clocks removed
and a few clocks added.

For clocks specific to i.MX93 use PLAT_IMX93 to flag them, for
clocks specific to i.MX91, use PLAT_IMX91 to flag them. Others
are shared by both.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 64 +++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index c8b65146e76e..4d1123f51903 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -15,7 +15,11 @@
 
 #include "clk.h"
 
-#define IMX93_CLK_END 202
+
+#define IMX93_CLK_END 207
+
+#define PLAT_IMX93 BIT(0)
+#define PLAT_IMX91 BIT(1)
 
 enum clk_sel {
 	LOW_SPEED_IO_SEL,
@@ -55,6 +59,7 @@ static const struct imx93_clk_root {
 	u32 off;
 	enum clk_sel sel;
 	unsigned long flags;
+	unsigned long plat;
 } root_array[] = {
 	/* a55/m33/bus critical clk for system run */
 	{ IMX93_CLK_A55_PERIPH,		"a55_periph_root",	0x0000,	FAST_SEL, CLK_IS_CRITICAL },
@@ -65,7 +70,7 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_BUS_AON,		"bus_aon_root",		0x0300,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
 	{ IMX93_CLK_WAKEUP_AXI,		"wakeup_axi_root",	0x0380,	FAST_SEL, CLK_IS_CRITICAL },
 	{ IMX93_CLK_SWO_TRACE,		"swo_trace_root",	0x0400,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_FLEXIO1,		"flexio1_root",		0x0500,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_FLEXIO2,		"flexio2_root",		0x0580,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_LPTMR1,		"lptmr1_root",		0x0700,	LOW_SPEED_IO_SEL, },
@@ -122,15 +127,15 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_HSIO_ACSCAN_80M,	"hsio_acscan_80m_root",	0x1f80,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_HSIO_ACSCAN_480M,	"hsio_acscan_480m_root", 0x2000, MISC_SEL, },
 	{ IMX93_CLK_NIC_AXI,		"nic_axi_root",		0x2080, FAST_SEL, CLK_IS_CRITICAL, },
-	{ IMX93_CLK_ML_APB,		"ml_apb_root",		0x2180,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_ML,			"ml_root",		0x2200,	FAST_SEL, },
+	{ IMX93_CLK_ML_APB,		"ml_apb_root",		0x2180,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ML,			"ml_root",		0x2200,	FAST_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_MEDIA_AXI,		"media_axi_root",	0x2280,	FAST_SEL, },
 	{ IMX93_CLK_MEDIA_APB,		"media_apb_root",	0x2300,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_MEDIA_LDB,		"media_ldb_root",	0x2380,	VIDEO_SEL, },
+	{ IMX93_CLK_MEDIA_LDB,		"media_ldb_root",	0x2380,	VIDEO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_MEDIA_DISP_PIX,	"media_disp_pix_root",	0x2400,	VIDEO_SEL, },
 	{ IMX93_CLK_CAM_PIX,		"cam_pix_root",		0x2480,	VIDEO_SEL, },
-	{ IMX93_CLK_MIPI_TEST_BYTE,	"mipi_test_byte_root",	0x2500,	VIDEO_SEL, },
-	{ IMX93_CLK_MIPI_PHY_CFG,	"mipi_phy_cfg_root",	0x2580,	VIDEO_SEL, },
+	{ IMX93_CLK_MIPI_TEST_BYTE,	"mipi_test_byte_root",	0x2500,	VIDEO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_MIPI_PHY_CFG,	"mipi_phy_cfg_root",	0x2580,	VIDEO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_ADC,		"adc_root",		0x2700,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_PDM,		"pdm_root",		0x2780,	AUDIO_SEL, },
 	{ IMX93_CLK_TSTMR1,		"tstmr1_root",		0x2800,	LOW_SPEED_IO_SEL, },
@@ -139,13 +144,16 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_MQS2,		"mqs2_root",		0x2980,	AUDIO_SEL, },
 	{ IMX93_CLK_AUDIO_XCVR,		"audio_xcvr_root",	0x2a00,	NON_IO_SEL, },
 	{ IMX93_CLK_SPDIF,		"spdif_root",		0x2a80,	AUDIO_SEL, },
-	{ IMX93_CLK_ENET,		"enet_root",		0x2b00,	NON_IO_SEL, },
-	{ IMX93_CLK_ENET_TIMER1,	"enet_timer1_root",	0x2b80,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_ENET_TIMER2,	"enet_timer2_root",	0x2c00,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_ENET_REF,		"enet_ref_root",	0x2c80,	NON_IO_SEL, },
-	{ IMX93_CLK_ENET_REF_PHY,	"enet_ref_phy_root",	0x2d00,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_I3C1_SLOW,		"i3c1_slow_root",	0x2d80,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_I3C2_SLOW,		"i3c2_slow_root",	0x2e00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_ENET,		"enet_root",		0x2b00,	NON_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_TIMER1,	"enet_timer1_root",	0x2b80,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_TIMER2,	"enet_timer2_root",	0x2c00,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_REF,		"enet_ref_root",	0x2c80,	NON_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_REF_PHY,	"enet_ref_phy_root",	0x2d00,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX91_CLK_ENET1_QOS_TSN, 	"enet1_qos_tsn_root",   0x2b00, NON_IO_SEL, 0, PLAT_IMX91, },
+	{ IMX91_CLK_ENET_TIMER,		"enet_timer_root",      0x2b80, LOW_SPEED_IO_SEL, 0, PLAT_IMX91, },
+	{ IMX91_CLK_ENET2_REGULAR,	"enet2_regular_root",   0x2c80, NON_IO_SEL, 0, PLAT_IMX91, },
+	{ IMX93_CLK_I3C1_SLOW,		"i3c1_slow_root",	0x2d80,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_I3C2_SLOW,		"i3c2_slow_root",	0x2e00,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_USB_PHY_BURUNIN,	"usb_phy_root",		0x2e80,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_PAL_CAME_SCAN,	"pal_came_scan_root",	0x2f00,	MISC_SEL, }
 };
@@ -157,6 +165,7 @@ static const struct imx93_clk_ccgr {
 	u32 off;
 	unsigned long flags;
 	u32 *shared_count;
+	unsigned long plat;
 } ccgr_array[] = {
 	{ IMX93_CLK_A55_GATE,		"a55_alt",	"a55_alt_root",		0x8000, },
 	/* M33 critical clk for system run */
@@ -246,8 +255,10 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_AUD_XCVR_GATE,	"aud_xcvr",	"audio_xcvr_root",	0x9b80, },
 	{ IMX93_CLK_SPDIF_GATE,		"spdif",	"spdif_root",		0x9c00, },
 	{ IMX93_CLK_HSIO_32K_GATE,	"hsio_32k",	"osc_32k",		0x9dc0, },
-	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, },
-	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, },
+	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, 0, NULL, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, 0, NULL, PLAT_IMX93, },
+	{ IMX91_CLK_ENET2_REGULAR_GATE, "enet2_regular",        "wakeup_axi_root",      0x9e00, 0, NULL, PLAT_IMX91, },
+	{ IMX91_CLK_ENET1_QOS_TSN_GATE,     "enet1_qos_tsn",        "wakeup_axi_root",      0x9e40, 0, NULL, PLAT_IMX91, },
 	/* Critical because clk accessed during CPU idle */
 	{ IMX93_CLK_SYS_CNT_GATE,	"sys_cnt",	"osc_24m",		0x9e80, CLK_IS_CRITICAL},
 	{ IMX93_CLK_TSTMR1_GATE,	"tstmr1",	"bus_aon_root",		0x9ec0, },
@@ -267,6 +278,7 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 	const struct imx93_clk_ccgr *ccgr;
 	void __iomem *base, *anatop_base;
 	int i, ret;
+	const unsigned long plat = (unsigned long)device_get_match_data(&pdev->dev);
 
 	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
 					  IMX93_CLK_END), GFP_KERNEL);
@@ -316,17 +328,20 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(root_array); i++) {
 		root = &root_array[i];
-		clks[root->clk] = imx93_clk_composite_flags(root->name,
-							    parent_names[root->sel],
-							    4, base + root->off, 3,
-							    root->flags);
+		if (!root->plat || root->plat & plat)
+			clks[root->clk] = imx93_clk_composite_flags(root->name,
+						parent_names[root->sel],
+						4, base + root->off, 3,
+						root->flags);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(ccgr_array); i++) {
 		ccgr = &ccgr_array[i];
-		clks[ccgr->clk] = imx93_clk_gate(NULL, ccgr->name, ccgr->parent_name,
-						 ccgr->flags, base + ccgr->off, 0, 1, 1, 3,
-						 ccgr->shared_count);
+		if (!ccgr->plat || ccgr->plat & plat)
+			clks[ccgr->clk] = imx93_clk_gate(NULL,
+				ccgr->name, ccgr->parent_name,
+				ccgr->flags, base + ccgr->off, 0, 1, 1, 3,
+				ccgr->shared_count);
 	}
 
 	clks[IMX93_CLK_A55_SEL] = imx_clk_hw_mux2("a55_sel", base + 0x4820, 0, 1, a55_core_sels,
@@ -356,7 +371,8 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx93_clk_of_match[] = {
-	{ .compatible = "fsl,imx93-ccm" },
+	{ .compatible = "fsl,imx93-ccm", .data = (void *)PLAT_IMX93 },
+	{ .compatible = "fsl,imx91-ccm", .data = (void *)PLAT_IMX91 },
 	{ /* Sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, imx93_clk_of_match);
-- 
2.34.1


