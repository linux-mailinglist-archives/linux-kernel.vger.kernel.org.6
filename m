Return-Path: <linux-kernel+bounces-308619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBFA965F93
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310311C22C87
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A33018FDBA;
	Fri, 30 Aug 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YPO/5G9J"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2075.outbound.protection.outlook.com [40.107.117.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9082015C12D;
	Fri, 30 Aug 2024 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015019; cv=fail; b=eCnGx3D/kb1KfysHmzR2NBXh5kN8oP3949ACOeok4FIB1/+JdRN01sxv/GTBF69gwIY2IgQBNcqeKM76M65ln3+dykRPEFBNBVTUUTOeuzwMd4x3FaLuGwfYtPu15McoLYmEclWPCjTc2v0Bk25dIerQhDQrOvSKnHJ2+06uNbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015019; c=relaxed/simple;
	bh=SpsOaemXTcQK3n2qjOQr9l4djYHA+6quYorQWIONhbA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rFtDU+09DufsHgSWfDm+g4LKNkh4wXN1L0/4YuInYAz7r7jJz90aU4a8LXC0lj8nzIhhA0PL1E4gsNaujOZUwg2SEAnSijGHY/JbiD3cC/RrTsy5QbsHKzWbRwdJbbYq+G1uaZoNFVtbTsHtvmXv6+OtGoiBwpKI9mlPwBI69IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YPO/5G9J; arc=fail smtp.client-ip=40.107.117.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1K/u8igbzniv4reoPlSyKZ5k+rrF2Z3LGAXE2EBVrvr/W7Ym97cex83j04gyWrpbzwcJD37xAYP66t96HdqWC2We9j27jH0/EOo53qkQ9IJ/+HYkKTSbaS6XulV+XujuX2aBWzIeS4l94fS5OtV195W/wGwYL3OlSrBZCYxUAMeRl0B24gGXH/cv929slfE/k3mqMvqWBKL9HOZLftm/I1Yklq5ZV1jAkknR9zkscWWwGKLSMcl8belyVhsydFWLYnaVbJrQ7dCPd2KpStlCsdxBQZOmGjqfhAwUX7dNIysvOHl2+HFht8DIH47MY9Ey1Ey+6nAfd+Vg41OsdV/uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u33YJQ197CQxZ0E4S8bLPhj/t/jYVEDkAB8H4kFJeXM=;
 b=uGFGh9AOS0Cruk3Fj/4cCosihF9sCw9Q7OKuQt2S+r9Ne3oHBhAsBLSF+ojLOnE7NO6DOV9CvpfkeHHXfdSdrPy2FCRgMBL8kAtVvv0/Vz47t1iRRi3AMHPOS/BgVSjFHi7L7pkc2ZU42y/iUVnWWKWGM9tnVsNG+wF7Fr5waT0gY12lZZZvREBLbWJBs92UluKn4lKwz7AW4qMgLMiBJzRX6aGsW47+qblPckhpDwdpiS7s6LM0ayzNCXYy5Yt0JiME3dnILr6VC6537Q2JRGN9x3JEfN8GtQgwD/sG7FvRTPVmOmW6XCci+JudJEc1S4202Ll+JsOVaUGzs16q3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u33YJQ197CQxZ0E4S8bLPhj/t/jYVEDkAB8H4kFJeXM=;
 b=YPO/5G9JTEgjrxYX0BFbt7AHuTITf7/vbAkWIXBTO0b3wZP7ocXRCFZK6FkvZT74r0Mfx0NEipxhIbCVMtmd6r81Gn4buZfbeLk4+8DZxXORVbJF4WqEM3E8Uub1idMOHTwBIDrI311luPkfyn7CqeQKTL2W5jYK+ub5Xz+pERjhvGUrvMxFbpfsS3un8DnTAzy5XCifd3crd9GIgmQVktXViUkb1mUcLPXGu45or8BQqn90CUdWJWrpoKB8qT0LQLr16RYUV4f5i4JeAkkNMoxLQ186NN91j4ztyEH1cW0ITqupQSIQFd2y1BoZGfQt9B26HbqmzhlPbDCGFD9o1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14) by PUZPR06MB5888.apcprd06.prod.outlook.com
 (2603:1096:301:105::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Fri, 30 Aug
 2024 10:50:14 +0000
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f]) by KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f%7]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 10:50:14 +0000
From: Chen Yufan <chenyufan@vivo.com>
To: =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Chen Yufan <chenyufan@vivo.com>
Subject: [PATCH v2] clk: sunxi: sun9i-mmc: Use dev_err_probe() to simplfy code
Date: Fri, 30 Aug 2024 18:49:58 +0800
Message-Id: <20240830104958.21775-1-chenyufan@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0087.jpnprd01.prod.outlook.com
 (2603:1096:405:3::27) To KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5487:EE_|PUZPR06MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ae2106-3e16-4a06-b482-08dcc8e18708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?snJVwve+71hXgEPs7mbSczbOf0Eevoekq2vgHZLp1OdKQeDKteuBfr/ah//p?=
 =?us-ascii?Q?mHk+6GGDmaQiCsDiuA3R0QTyBIEb2IlwOxmWGeSj01CxAxBPJQE+7JshuKYw?=
 =?us-ascii?Q?tMgsluNHXSjqjp2ssUtCFh3nkripJlB6bq0zNTpjeOqJWupFJ4M0ysjUICMM?=
 =?us-ascii?Q?2Hen64p0A7ZNvAC6pP4XAFDSOG0MMuS1i2jGqUPm2X7krrJm/NIz9UPMVeHO?=
 =?us-ascii?Q?wnhQtSqEw+/K2BAh15VCm4TLUgoEz5Y267XOdMZpgSSVV4JK9qeQDRvxcEVs?=
 =?us-ascii?Q?HSiYpz013iK2XjY2XfhhY4iKOUQJrkrpmQzWyaVb6FV50m6RQfT1KUP4s+dl?=
 =?us-ascii?Q?d+XL0qWlLBrMI64vp5Q9hJnDE0SuFFtsOc30p6L+scEIEwNke4BcXlxprFsE?=
 =?us-ascii?Q?dr1cGQbbmgtdO7M6xRnHTHlPfgERqxK+4pL2mE80e3kkZAxX7JulBjPFdWDW?=
 =?us-ascii?Q?7u/D1sS6go4Pcb6V9TRmCJWyYIiZ4ZqKF1t6iOFHGLqgxgBuioFoMR6Uiqpd?=
 =?us-ascii?Q?XmxclH3MAagyg1udUXiEqHw0Hz7g9CK+ZQoLg3/vZ0OO4WVjJ1nQ8czPyUIY?=
 =?us-ascii?Q?U8dHobAgpZtEoLyUjwZC/u2N9BuNSSPsgqFkwOCdPHtGA+wnUn9xsFNJHKE1?=
 =?us-ascii?Q?qJa8oDdVQCQ2QbCzJZJOOMHOomoLbSmEdRA35YqY3a1gZn1bUdXonJcU0CSO?=
 =?us-ascii?Q?9YHQxvzspuxwITVu9by9stFUq5X7Tt5C66K7LC2Ych/cLbNRi8MWgw6bCMDi?=
 =?us-ascii?Q?yf0Kf3P7YS0SN+T2MFPg2onFyTzi6oDGNAaBTxo2B6YjJ9HEKCG9MGIkpElt?=
 =?us-ascii?Q?CgXEQwW+cUSWHrcblkWbzzg+J+AHSRglZKP5Yek5473DBmW8XkZf5SReMeto?=
 =?us-ascii?Q?5qvHH15j/EFuzy6YlTbt+hXYa/C712S0gNBIZ4u07i74ee/EMaBNHpfpueez?=
 =?us-ascii?Q?1FYJeY+s84E/Tm8H+JfdjS2JQQSl5hq2+xEbLBcZsmkQwjIoWYM1Io9RJ1XJ?=
 =?us-ascii?Q?iXJ3cE6MOGsJxhuciJKL3dnF9d6i51FKZA921dVF+hksXk4oHNQXA4n7QE6Y?=
 =?us-ascii?Q?KUhqv2s93fFl/XhX3i3Cd42Sl4v8M3EGw+gdxAUIFFXR2VYWzZOWHBg4Uyhf?=
 =?us-ascii?Q?ga4W8aourDKEXc3dpVbOuqIzrPkTFm/Enr0KQpQCqz5IFX0KRg7J8Cp2eii5?=
 =?us-ascii?Q?CRklLGl36/+O6RNBb5VPF/4Vu+sOp2OCAENd4YvArHbwPWrMKV4M5Lr+sjO4?=
 =?us-ascii?Q?2VmPSeN+85annhMssb72/b7ehWiSDHO0b9bhvm98YlfZchx256/7NoLOEmll?=
 =?us-ascii?Q?gwxHiPJqMbophdD9foRm0pM8VrlAdtnUJrcD892pdjmOJGbLNmnpbCRZfSFQ?=
 =?us-ascii?Q?/IZtmFGimLMF6eO+iQX/0LOCfTk9tmkEn8P+9IokuFOsm066KrK8ZnuvHpIO?=
 =?us-ascii?Q?LwQbqMcj44Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5487.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xUZMfjC2gopzWpFN94LYXZA+XfLfIoEx0rWWpcm/Lpr3ivB5YVuX5Pyhn2cB?=
 =?us-ascii?Q?bwo6q0O2CXwwLf9MhDN4evyIDXByJWe9A9CjZSEx0ltxvnr3BYAlDqWHLviT?=
 =?us-ascii?Q?Kd5bVeyBapYb84mOQVcgFojNqT0QAdLKqTOVeGBSpcbAqeXeebz910tyJFP2?=
 =?us-ascii?Q?y3Rr0gYZyKbAOZH1PvdDzo6Kwd5FhgEm26cF0kE5y4NRI4Ah+jgZxlljKnK0?=
 =?us-ascii?Q?Au4DWJiyA/jQwQDfvemzS711m4gGyOV0TpiDOm1P8a40PSpCf+wd/ikgGcus?=
 =?us-ascii?Q?yzIDo0fG7mS9JLdj4bMF8cWVBFfvU6NP5n/nFIrvUnnsbbsLqTT83pWhlQTx?=
 =?us-ascii?Q?OFr7GcZi5I8mKOR8xmMHBRHNnYiLjZ625G9pKPbmwlm031RRrL2Zh27K47VI?=
 =?us-ascii?Q?oJBSNUOlKwF4vEFBiyYLSJMs6zeWiaIRFqd8G01xi6h+DJrgMfobxO3IRhde?=
 =?us-ascii?Q?V2fgpp2Xelxy8TM/YjkgA0KTEgirbNxHCzon9Crkpv8XmpsHU0CbGjBRHA44?=
 =?us-ascii?Q?cAmqV5Dc8zxOKuIop4Ks7jszqryubyFDPGz7HvmqOfrnRFCnYzC5BvQkoIVA?=
 =?us-ascii?Q?IoNnS9Hq6DDLef2qiPW2al/hrYj5fJrbYLZ51F94MXRsm9wplG53vpxbeZ6T?=
 =?us-ascii?Q?pBitsisab+X4Sa4urfGwidvyAl02yLKR/Aafbtj0FFGgb76Hi5wgkCWd7I6U?=
 =?us-ascii?Q?wZ8HcgIV3zPelwBP0qaB9QNQ8Qh/WMqBrt0PP3Ui4IlVrimWEWi3jzb0DdjW?=
 =?us-ascii?Q?pny5jmHXtxP2cjafL8h6Gq+czANwoB8saUm9xegE6A15XWNA6hWaXpQJOQDP?=
 =?us-ascii?Q?+ThGG1a+XAY7JSqWe79rKi8xGzPv2kaPPV2tcHNC1/+vYTpwRZjMp0lQ27xr?=
 =?us-ascii?Q?Py58ZqHXrWXUfhN8U5fPQ/1PFQZJhF9nMsCrUW/hwJ1uMehbR6h9x59xh9jl?=
 =?us-ascii?Q?NRGgM6CDq9+QWU9Q5pulPexzvQcEyyaHmWGspeNtSD1CHoujmb8litQfStVt?=
 =?us-ascii?Q?ifEEfUxb+OO6hVL14TH6C3vAY9DxFgaNoRhHC+gTm37D3mi7Vs2jamvGxF75?=
 =?us-ascii?Q?09qCQWKIP9VW1mroojyCO6esPr0+Uofd/G3yUMLsTbSJvWlvxoDxngT2XfQ/?=
 =?us-ascii?Q?9FUBQqSXu5wx24US0YapC/QOQumia/QZsLuhTiySjnrXsaSPce6owz1SIedc?=
 =?us-ascii?Q?dXfhyI1zmYcAHACsV7VEQIKaTuxY+AOLqjaviUrcpHywajE5kdgvxH0oWGD6?=
 =?us-ascii?Q?5pAqY7b+fAI+0tRxbjMxoR9I/3Y0+9Sr7lE0xQyJL5anOofR4uUMhz/Oa811?=
 =?us-ascii?Q?D12cR9nGkoMgg4/9zkDYpClc5MTBv87nkmttG1h1xGUjS8s90+/G2pGr1Eg/?=
 =?us-ascii?Q?af1nZV6hKKUfJUGTRaApXI9iglyyJntcobCmyorP5DVNTtS831MAzCdVpzDS?=
 =?us-ascii?Q?bB3PXGw0Me5qHhxkGQY7IYw35bA0qyLuUMpG66X8ATQrYN4pUEa5VZwDE31A?=
 =?us-ascii?Q?bPv74kppitPM4o3EJ+iU2RYRpGyoXbZkUKBZvFa26WNZiL16iuRg4r0JBmsj?=
 =?us-ascii?Q?6Dqi42qT8LTrJl1G3vavy60yD79KDeYTBpdMvkLx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ae2106-3e16-4a06-b482-08dcc8e18708
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5487.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 10:50:13.9993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2xaAlnhWq7008ydHB8EfUu+CzBMNRvpdZT8UkIZ64KJuKeTNQ3Zraen3/vXVXl8sdcyY5PD6tX1RFmp2dhL9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5888

Use dev_err_probe() can make code a bit simpler.

Signed-off-by: Chen Yufan <chenyufan@vivo.com>
---
The modifications made compared to the previous version are as follows:
1. Change missing dev_err() to dev_err_probe().
2. Remove the extra "%d" in "dev_err_probe
(&pdev->dev, ret, "Reset deassert err %d\n")".
---
 drivers/clk/sunxi/clk-sun9i-mmc.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sun9i-mmc.c b/drivers/clk/sunxi/clk-sun9i-mmc.c
index 91074017c04f..6e65692dddf3 100644
--- a/drivers/clk/sunxi/clk-sun9i-mmc.c
+++ b/drivers/clk/sunxi/clk-sun9i-mmc.c
@@ -122,22 +122,17 @@ static int sun9i_a80_mmc_config_clk_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	data->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(data->clk)) {
-		dev_err(&pdev->dev, "Could not get clock\n");
-		return PTR_ERR(data->clk);
-	}
+	if (IS_ERR(data->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->clk), "Could not get clock\n");
 
 	data->reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(data->reset)) {
-		dev_err(&pdev->dev, "Could not get reset control\n");
-		return PTR_ERR(data->reset);
-	}
+	if (IS_ERR(data->reset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->reset),
+							 "Could not get reset control\n");
 
 	ret = reset_control_deassert(data->reset);
-	if (ret) {
-		dev_err(&pdev->dev, "Reset deassert err %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Reset deassert err\n");
 
 	clk_parent = __clk_get_name(data->clk);
 	for (i = 0; i < count; i++) {
-- 
2.39.0


