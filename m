Return-Path: <linux-kernel+bounces-370901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93809A3370
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF5E285549
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFD117BEAD;
	Fri, 18 Oct 2024 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HtjtAEpY"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607661714A4;
	Fri, 18 Oct 2024 03:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729222631; cv=fail; b=bAtbMXGK2iq4lvu2bTVYyxcWfmLMQaaFBpxJ4w7hEWFUnYdth2/TVpG2J2teODkqPvr+gVNyDVIuxqVyiptPsToasz3Bt+rVTpw1Tel0RXDNuqyu9MX5FP76R9tjZaDgmpbTFBThfYlnXPiK4E7D88iWNJks7X4CG6YYpTRaAH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729222631; c=relaxed/simple;
	bh=sLK0/e/dfQkW0gMequ90IiU4RQb4Cl7T8sxqQcnBkBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LiiTEJJ0Ai/fA2hBs1fG4p8g+3/iD16Ok6We9Jc3CC53eMXD0N0s9/DAg5/2CnMB9nJvkVOOBkuqIBbE08gMHFngjT7w3yqM8P1W7sxjZ4pqoWJ37qUX5t42gu7WNcKGedpWmz8WIooNyvTDe0iE+QhtrZ53RTC0WBw6SHZZDt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HtjtAEpY; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DP7gXnD+Ecw5x2hNfxANpOMnvdpTHVNBVqOr+g1WC5nH9tzcdxr+Qag5w0opPQ8UTzqZjDUOpw+zIQFQGd36eTR5HfAkNiELZTGGKUfpY01LkTucRHUFZOLE1ebw3H9HOmWqdXHreHUUVycSuAufIO6Xu4WC+3jOiObdZ0g5AkLR4aHnvPjb0TvptKWq0UPQ47yvUpXQmysG8AdHq1908pdXdLovU5bpnuWAJ7jUnW8k2yZ0/B3603xd1UPN/PjuPOzzpDHX8V16YYPm/koJx+Pf3utEfnEHO/M3JL6LGOnRtKbdklEWiSTS/5FwpuYqNKOw3hOnWdhPdgrDQbEapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnKaYB34U5PXIsmZ/rUCEYaBKjA3f30yg9LBsciBTDs=;
 b=aEX22Uxs7150HEHaqCmt+YRWFhxUGf1tM3nTzOcczjmvMQkcEML7i9/8IM9wTKetadsGUZD6aqG/opmpqmCoFlCh6wi7i1n9y1MYpMF5kcpXVGOWGGOjsAzn0KE6JKTIQN3MlLBQ7vd5oSdElcqnB+73LZ2r2tbN6lUhakO9b4nOz6s0x6lmmPEkivZZi5Z/wY8VGRXpkXzChth8MoneM0sRvpdyyhbETiivAVWm1+ZY+EYk2c3xFwBMQSxS5/A/wHuKEOkoyrON8FAJUBWnfdL/ejj/jGA7BGOALnyivpR9//hjul7PfnDRkrHvqBIBkIeH42oFxU5ymhNwllfYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnKaYB34U5PXIsmZ/rUCEYaBKjA3f30yg9LBsciBTDs=;
 b=HtjtAEpYS1mJOPJof2IUy+mtFQQxawmDkS3Xe87RtCiGohUbkJHGKSiJglhv5fOyXcOpoKdBcAKmUnYnPyw1u4OvCqdoodEH7nze/tG3QLI9j5pSBqRsCRyYDd1EseQiV1V/ln9Sabun81KFDVrs+pJQG69RfQYiS0JdyKwn2PA9MTJIs+US9twmIFb/dCeCLK/aby4Mc9TmKldAsc54J1URrwpREw0aJKgAAlZxVxbSDYXcHjIVTQgSe1KBOgfU0vwF2Q9ORtUnSE2gye8UbRcWcVcwJpQNkBBI+w9XyreZz6vProRSHiza4EYEysLnK4aLHvl9+Iz/LeLuLhiSqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR0402MB3937.eurprd04.prod.outlook.com (2603:10a6:208:5::22)
 by PAXPR04MB8110.eurprd04.prod.outlook.com (2603:10a6:102:1bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 03:37:03 +0000
Received: from AM0PR0402MB3937.eurprd04.prod.outlook.com
 ([fe80::4e37:f56b:8a3e:bff0]) by AM0PR0402MB3937.eurprd04.prod.outlook.com
 ([fe80::4e37:f56b:8a3e:bff0%4]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 03:37:03 +0000
From: carlos.song@nxp.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	haibo.chen@nxp.com,
	frank.li@nxp.com
Subject: [PATCH 4/5] arm64: dts: imx8ulp: Add LPSPI alias
Date: Fri, 18 Oct 2024 11:45:31 +0800
Message-Id: <20241018034532.2552325-5-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018034532.2552325-1-carlos.song@nxp.com>
References: <20241018034532.2552325-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To AM0PR0402MB3937.eurprd04.prod.outlook.com (2603:10a6:208:5::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3937:EE_|PAXPR04MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a983d6-66f4-4002-40e4-08dcef261eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WJBiRuF55hmwig36V3KMYwK9Q9Uc7ygmbusSJG6MD7QTbxsGXA9eTgiHmkW9?=
 =?us-ascii?Q?nqSZagjZed/AtumTDX50tkPrKn7ktaUNOszbywUutD/g0SBEHxbloGKH7coU?=
 =?us-ascii?Q?MzdmrJjRrAh6fKyiQNyEEBxXLtLjFUV9O1yEw9IWZ2n6v6fNrwMv0BPG8RBg?=
 =?us-ascii?Q?ZbeBahcRoPPqzZp00BFnfWLeGbM3sj6orIymYU7c+co4M7vYz7UoY7fWxBvl?=
 =?us-ascii?Q?Ne/Lbd/MHcrBL6eSJIqKKvI9P6eg6yf/9Aev+NYIfDMLIQKfJrdx/zWfuavs?=
 =?us-ascii?Q?lHbdFs2NSgiyCktI0WK9CjeChOXJgFHwgY2qpgyben2qxLO6a4205pUF7awY?=
 =?us-ascii?Q?DyYC3+0Sp1UluES1XJ0pRiEDfwxvggFSUqPL2bIvQlXiiRINiX4C0Ql9OdRb?=
 =?us-ascii?Q?hRFFTLKWjD6zFWzDlkWmBFdlJUf4oo006NMGFhlObmG+c1Juohkb9SbpgihO?=
 =?us-ascii?Q?xUSBlNFYnbAp7cPUxgMxG3SjFKA9JWVY0vLyNN6Tm796kPi3gehtCVc4jxan?=
 =?us-ascii?Q?eUvnxydJXeXfL1W+aGjORsdwapR+pCaSCjMI81PVMG+NbkMdOM1BHnzCjlGf?=
 =?us-ascii?Q?wSl1bxHpYjwmxIGvPGL+pirxPM15ZL3PjzBd1+VIa5MB8Kr5CGTMFIjt9Kse?=
 =?us-ascii?Q?WpHgQEkGB7to04sW0vynTN37Tw7g7dZtFddDIHZr16YpfAQrjtv6vRwTAfNL?=
 =?us-ascii?Q?tsTcHu5+pZA+ICnumPYGmdvY4OvJalDxcuHmHBPbAfwDV6El83CvLLyFQp6s?=
 =?us-ascii?Q?mt5MzeYMZWXc2Lzs3b+tiM9P0OM9urFvVCv1yw9Vz5qcjBldeU8eZzclVUjo?=
 =?us-ascii?Q?curkuj2JPO7L+TumCPJQ3sResnZJV4gpX7h0i1o1Z1uroxodotA1+vLLPZj3?=
 =?us-ascii?Q?mhhDsWVHBsbTzo9UgioUgTOUcNFqTq0Rc9i2v/wlvArDhUsJ19gIDSoJslec?=
 =?us-ascii?Q?jPBb+ExWn7YjeAijZFvQ00/+udHRp064Sj3q41ganyX5JQ2WFnLGYwBNYq+d?=
 =?us-ascii?Q?yJAarLdSVGu+67JRh3ajyKTve1MpCDBACxFBxMr4+ddQAabzjpLPBfDvOIPU?=
 =?us-ascii?Q?SwID4q4m6Tc8zXs78+sd0Z+SjGV/D0J9HQz16kQNnU394QDe7/Es5FQdJb7q?=
 =?us-ascii?Q?c1u0v93QvtMpC05uMvk3ssrXADpB9sC70kf/R1TYAPRBZBSbrNwyM3gikQIS?=
 =?us-ascii?Q?YL/pZvz2/ke99bnJC9HCZ30ijzQQqZ7cwxTzolYj4apk3lEf7nB1ETsYNb7i?=
 =?us-ascii?Q?sPSVsA5SRMzsUiVlCW6aJWAZyQ+bmWqoPaXG4QoPj5XuBzTmgf76wB58q0F7?=
 =?us-ascii?Q?+SB1UAvuOEUCalzr0oLOPafn6IgMWWGFCg3H29m1Zx7sUx/SIQs4Ztv/ELcI?=
 =?us-ascii?Q?KrARWew=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3937.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y27q5En2dqK6XLfHXpOPPAIuNca/LsYqvUu7Pns2XKBZ/rjtmUAYANTx+Fsr?=
 =?us-ascii?Q?ErUl8soawi9WdtKr6gAdhQoMLofgQECeeixoeFSyAvjL1GmPhvi0WA+VraQp?=
 =?us-ascii?Q?UE8raU4fI75xxRAgiEMwS31c1WQTBEKZBqYx/+kFAdMXo/Lxk8yP7XYLZrQb?=
 =?us-ascii?Q?gECD35V1dDcYTN4AuBW1IZlaFCrMjP3OZF0EjR2qb+L9gXxMaNhvgt0ey+OW?=
 =?us-ascii?Q?3gG4ygxro1p5cPAL/r2mUDL/yFgD5iBciMqUJHPNoW6HakiVwZaQ/UhRmTC9?=
 =?us-ascii?Q?a86de7y1whvFWq56jmkvC1fNElUC5PdAT8F+TK9PPEZjTFieEvFcP4UMg1Rp?=
 =?us-ascii?Q?frx5feDLVrzNbN8HeO0pC72gKx2KSC4stCQZY/8S66SxMbHsUIciLRx77Ac7?=
 =?us-ascii?Q?M8DVaTvjHYuO6QhQ1EmOwLeEBHJWWX8y4JVu9/CYdgszhxAhTlxrWG/o74Rg?=
 =?us-ascii?Q?H/gewVToBjqS7MZqqR+HNNYIBnsRV27RhiDwDfEQFKopV/ThnvYxihVK4964?=
 =?us-ascii?Q?zJERKfKJXix93A61L5Azvx4IahMesVPyEGtoWsdSmtt1V2CufOhRh0w4IWcz?=
 =?us-ascii?Q?M1u9L2CfYMgYePdmoJXIpxCnxEOsY8briWvmaOVVoMABOn56L/UhzMj/6FRN?=
 =?us-ascii?Q?DqCSIdQONQ/yTnWkTa2sdYw6XxwfAZbevQgj5o1x21RG4hmBXYArSALd/xWk?=
 =?us-ascii?Q?coLN1nF8JzbAkKGCdkbBVHJd1pJP5i6Vx+UcRHdYTTYJJX7lssZtr4zZjKIv?=
 =?us-ascii?Q?3baUmkIeoY3AbcfZZL8L7PlbTOsCb+b4vG/8qy2VJKRb8YvRRJVC/DqoPQqx?=
 =?us-ascii?Q?4wvNSHB6FrzKW8dth+gxUBui+6m2f0Kpa0ckJNCySizBVI8EgdQr89g+DcF3?=
 =?us-ascii?Q?e9iysaxJP9arciKqgY9mIaqeXlcoIT0/4/m1ZacoPkmSC9RhYlGkQevmQ/BM?=
 =?us-ascii?Q?3nAZJ8HfWhCvFVe13lbjqTAlpulauc8ozhfcHUJFYmg/EtlDEeue0aCzbIWl?=
 =?us-ascii?Q?Kxj32MQxwLZedCZYZABej7JptxjMZ5/8qbsmohScp+k3hGgBDkTNwgoia9em?=
 =?us-ascii?Q?XOpp6Q0vRL8fqsOVj5cUVKuRv6Enl3lcE51T6Pm3Z/nJUfQoAv85dDhtpHQX?=
 =?us-ascii?Q?9T/z7GAmuZS4wcDL0jdL44CzrxJEH3A9SNifots+KQmheu8jR9aowQYyEW9X?=
 =?us-ascii?Q?JlW9i5OEIKrqq/R0ANlmym428+g5QxAY6Db/f921MnSHrRnEb8Pg04T/dVuJ?=
 =?us-ascii?Q?4umNocpFCwWr6Nh6jEIxcEtOIx3fNFF5Jn8vbSlo28xlMv8kvtPs0IMHBwXs?=
 =?us-ascii?Q?9+2EWggx60fMohT7rBXVYNzQAERu6eWrDl+nZRYoMymf2N8CzPi8CZhit8C7?=
 =?us-ascii?Q?FzbXM4Cv3PkDQdYcmEHjhWZugXJqvnjzjXhk70MRqU9UtchxusorchXYYLEm?=
 =?us-ascii?Q?Y6yXU7/s1ncEZZw9V/GO8/Ciz2oSua2mdVQApi5T9NofBhcTfa9qRfbKypEJ?=
 =?us-ascii?Q?gMQaWFHlL4DbXgAZEOuMI+665vrl4opD2IsocGP1zVoVursRAJ0RgI7YN1T1?=
 =?us-ascii?Q?dXLetaE+t/1HsdpQexuNiAEWkMnWX4Gz4eUl9Ed/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a983d6-66f4-4002-40e4-08dcef261eb7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3937.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 03:36:58.6850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaQ9Beqzj3WoKt1uiIcn2ts4u8X6Q+19+/d3LKTuDyQ9+F7KqbqYN9ME+aB+W6RcJNSaFlYELFAuBd7ipt6sJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8110

From: Carlos Song <carlos.song@nxp.com>

Add i.MX8ULP LPSPI alias for kernel LPSPI driver usage.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 43f543768444..6728f23b385c 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -28,6 +28,8 @@ aliases {
 		serial1 = &lpuart5;
 		serial2 = &lpuart6;
 		serial3 = &lpuart7;
+		spi0 = &lpspi4;
+		spi1 = &lpspi5;
 	};
 
 	cpus {
-- 
2.34.1


