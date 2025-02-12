Return-Path: <linux-kernel+bounces-510750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D39FA32176
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09D3188794E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58771205E15;
	Wed, 12 Feb 2025 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M4bepQkn"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012005.outbound.protection.outlook.com [52.101.71.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B294A205ADF;
	Wed, 12 Feb 2025 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350300; cv=fail; b=Ax3zFLcP2oitUbhkhao3E1rNqznx6tJqnbBynspCY5YAEutzfg8Q9HAOvbaqCs10wgFRurbbFyJ1kpmhAU7gWrPuGUVDjyB9O1Qvsj7677/PyBIwM2x0w1djurhmKDuPw/D9w0h/E3jKRh8JG99Lm68YN8pcPMt9RjZ4kyBh7ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350300; c=relaxed/simple;
	bh=lWwIi2jpv7qXRsLUsBdUGV9bipzflF1WNEibBIaqUgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XmLnq/clIVV4qxwykmya3P3BwdkKiYNnwlVbB701gziJsT3tlJZQYTDeiYUkfNMtbR231sbW2s0JTm2wx4yXNvhyK0yy/AfGFWWmsB5g0bFdtWowiXycQvMBohq6/e9QpiWeKBGTf8wITtpg6hGbFWybYxxZ6tC7lJaorWbqCUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M4bepQkn; arc=fail smtp.client-ip=52.101.71.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R721h2OcsWkPdJ21/U3k9tVHGhP1vvt9rgQWPAOgw9ZRLLs6lDrN01XyJ9c7UYw8y0XkfJD51nkmivDgK2abtoo4RvkX8KQSOdC9pqFA3l2m6luCBM49fUatqZ51EqQkH40TTMSRhItuXVXdZ6ebfF5/8gUsXtomxx7JnbuW0OO2DI7XVQ7QG1XUawEwr54vtHn5YHjj0IeHe6eTawoeJx1nodsNt1iEOTjDGrbNkDdlK9XIHwwA0HAYSz5A+bFVdjEq4+ZHXxNEZUsniBRQ3Zm0WyhiHVfhq4+GUHlwgathdAYSp5wMFEK2ogL8fd3gyq3OF8s39a8qQi198cgNoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdcVA6+Zfmv9xkz+7IQ0fjpZPlkSjDeq62iOeajf+SE=;
 b=spXJj5Q8GmiYTb7+tpiBVueQgnsyr+KtXtsVAb4qs9Fm5gsNlgHKEvKaqUgul4yzqcB2TwB93q4NKIbpBpBW5ktiZzJB2GLVFK1FcGVTktrMgTzClHhCZWx/udlftj/3Uy9oiw8MBCG8iPpZSuZfDyANurO2qWBq6yBU38AygSF5s2+yvG21rXM+7etFp0RDotOhJQjGuodkOsAwqsFhMMGVDYQodPhGB6H8R+TJQPbhCF8wCP/mskbqBIwRQgOmnf/vCQ/Mv/DXR1i0tcEnoEuNG86Nn8tDNYeoVjCV3pshKi76CyFW/lZAQS1HV1Q3ozS3J+uitWjaqHWD4+sUdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdcVA6+Zfmv9xkz+7IQ0fjpZPlkSjDeq62iOeajf+SE=;
 b=M4bepQknFbHG2Edlp/VZ7DyANIO+wiI+1ikpoZbHs1eJWjypYTm+de5Zos3bPUAZkG2g1knGGgGZ9lAEpctXJxse6EnSqlHn9kROX5osNFtcaqvdot0Fzgh18iiDOG3+MrE+M9sCJcq9tlSxA/9MR9ut3KpiHifJxd1Vwv3uZv/hGwEUwYDQXkfyyCMGX5oyvHmAxF2va3jik60Ea+Fm8slxm6lxgLBjolotcthSni3FzhRpookm54TIBuZA9Hw4HVOzSuukfLbVxBGwjMuSggPEJBRqS7T2101fJfgZFCjOfQEOhsmuh0xy2gd+sbrjn87wzrUQYu5oX3kbSt/QTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by AS4PR04MB9576.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Wed, 12 Feb
 2025 08:51:36 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 08:51:36 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: shawnguo@kernel.org,
	robh@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	aisheng.dong@nxp.com,
	daniel.baluta@gmail.com,
	laurentiu.mihalcea@nxp.com,
	shengjiu.wang@nxp.com,
	iuliana.prodan@nxp.com,
	a.fatoum@pengutronix.de,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v4 2/6] arm64: dts: imx8mp: Configure dsp node for rproc usage
Date: Wed, 12 Feb 2025 10:52:18 +0200
Message-ID: <20250212085222.107102-3-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212085222.107102-1-daniel.baluta@nxp.com>
References: <20250212085222.107102-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0003.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::9) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|AS4PR04MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edbbc7f-5681-4546-eacd-08dd4b4274e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BfIhL8xpmgXVwVcsLMiYNTkQfjdFEEBksb3Se2qcRQpudiFHijakqSaMhbcC?=
 =?us-ascii?Q?5vKu29ZERs+/CBBIEeKQ6wFLdBwRcLEHOI0kQRw4DO458GCWXEvXKGDYqXTx?=
 =?us-ascii?Q?H4xUm8L31j9eDS8zRge5fbMSG5i8dND6L8yrXOfRbRdWFZ+V/4ocKCsOCyj1?=
 =?us-ascii?Q?sa4jhbphMdILkaUEELDX5+ydXZcVWmm7yw22TFF1J19g8BdA0mY9ulVG7s9B?=
 =?us-ascii?Q?XAUM+7cpdzzipqIkyoO5p89xbUjytRUhG1m++6f1yzlElNJW+bYmM/NmT1M1?=
 =?us-ascii?Q?q+X3yoZ3+cx4+lke4QUz4BYbHSN5XzP0+aeFxtEsaz+qwCMPg0+3p6V0HX4A?=
 =?us-ascii?Q?tIYoXcmHik76eGH66gOWcYa6cpHzpSUaisEPYPyClL7VrG2OroMZyQrEkYlB?=
 =?us-ascii?Q?PKG3F0y/2ZT0inWAPw3VxT5CNQ8JoNzIyQAROcEa/1V5vh/P78ZsEAvy06cG?=
 =?us-ascii?Q?+bE9yYyOdGD7y13riQvU+FPgqRDN42Hmo5foxfr3SdsjxHVJ6RpDZWcjdp0D?=
 =?us-ascii?Q?Q2QvALwVXsf3aOnFPW1UVP2OHuo6bfBaac6u61gs8xB/JFTPHRJO18Pt/GV+?=
 =?us-ascii?Q?4nGVWnzKtUTjVpJVAgfHT7Z2x716dsM63j+BK180vT273Euu+98Q2jw3mLAo?=
 =?us-ascii?Q?NpFnYLX3MGzBbehnKXwkoTlGCaVFQmTiWRLcXOlHy83xpsiz6wr0Zl9cn/kw?=
 =?us-ascii?Q?LDoE/Pcd3tTRUPkyt0inYRAwXOXZ1kQV7gKloiIaZCVujLD18H114q0kRxY6?=
 =?us-ascii?Q?PenAOxnGCr7VN3jmCuNC56RDlGmAUqROwbtzslRFLviFcvf6J9dnBvVW/UIX?=
 =?us-ascii?Q?Dai5B6NXVhvOMXc4Uhguldx+XCVRipC8HNs/dU0yA6dKUwcI4MXwjnMjtqOU?=
 =?us-ascii?Q?mV8lz/FqozSUI7QQ3r/DDv1YGjTC8XfH/PP5idMjhY8k7Nw2W5PG083BBTc2?=
 =?us-ascii?Q?eHMSgWek+NegqXq4Wyp7NxWrd1EdlD3PoQJTYaGbrdK+eOEaokT2+mBjlzuP?=
 =?us-ascii?Q?FBfb7+Bw7XhAzqACOyqJBUMh5Tkp+wgKV5SXjMHfcxfK/3GQryNDAMhKK/+A?=
 =?us-ascii?Q?IBLVuF3v0hSAomTjLegpq5pFr2u7xOCtD2kHOGBqw3zztX0ZYGGJN9ls+0Kx?=
 =?us-ascii?Q?E0drD4dX5TOE4r10fRYOw/T+8/TPd2q3bnPY/2BbhqYMLDaCvoFmblbL4HFQ?=
 =?us-ascii?Q?Q/Zc64hoQctQiLgfnnIoHadwibGWYONeqhwydblXk26r4Zolqg+SWO2syPaZ?=
 =?us-ascii?Q?lFe2NF/hzP7cDf4egZUbzePj2oJ2CeYa5FTWwxrwDmWD77WPL4bycGSvtlRN?=
 =?us-ascii?Q?1yZ7j1HB6+KAfqiuOBjEKGnjwGH4XiFeQREdICVJDAv5BvFf9ykOhcWr4KvS?=
 =?us-ascii?Q?xXUC1Yj+C0yR4i95r7CnyUKcemplq/llnHZIBHtvSTqnsjo6CIApAqA3GPSo?=
 =?us-ascii?Q?pRijZtJpYqfpweiqWcrX19mzYSXLW7lQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4K9KWJD6qNX+Rg0GEIK/Cgk0ieFCzDyJVFfmkBD/a9/lSwE2vEw6uINVIVE4?=
 =?us-ascii?Q?Xmxd0Phsx7sWmpWQvkw89OpXzWCyE4VeWJ6EcQvoXKQFBoI0sXn0HnysrJOC?=
 =?us-ascii?Q?rSPZmmZLY3zlkLGdxXsP6cjruD13+WUANE3gWJ1aUo6UUZinjg0YtDxeGIxd?=
 =?us-ascii?Q?bJ7HkASOP3E6Vp6a0AkjMcGBrZBDRSPP4cMJHsoXBOmjP3lcx9xWe+2FYyfH?=
 =?us-ascii?Q?RVzYQd6ByrQTVKANIbXLBiwqeiT9hWdXCWim1XUpNEKJUbB/TsjwoQB9ZJ1C?=
 =?us-ascii?Q?ey0OnGsNgW6ZWKQXQ6lf9xlK3j31PJAVWsjvFeqXS5tLXnXlmQFfDsXmKQ57?=
 =?us-ascii?Q?+k5GsqjO7CxMmaLiA5tlTjpxT0yGR1t9nhylQRdc1I6i/XytKOJ+Xxq/+wYd?=
 =?us-ascii?Q?4/30KRLzFMOxDKdv2Nfg9zDmkGdVc7Zq3dqsorgLm84YvWvJ4rF6t24RyHul?=
 =?us-ascii?Q?Azt/2viTjZ+Lp4Z8u+Hg3g4vMGRUDeL6BDY8W+bxAR2hcoeMVZcDSsFkGiS9?=
 =?us-ascii?Q?WVjj7QTjWXpPvY8g5rhuHjushVgez6ReJxjnSJMQxM1opq8iJOtJJt5a/6BM?=
 =?us-ascii?Q?NvT9tm7CVVGit9klrDzrMqPHN0LQ2iWRdSW4HuM6SfwcX+AV8Oovwh+6vwhL?=
 =?us-ascii?Q?xkZSEwELn/Izdc4WOQhB9oVA5b6gPsfgcQQd6UOBd6y9C2GTkKSCFmqkoEBw?=
 =?us-ascii?Q?X5hXLHsOio/SpZ5+RymHSNW9U1kdglnV6FS0Hky7+pDy2vzaNhhPwkfBZmss?=
 =?us-ascii?Q?D/ZXx5bUcTgzOxN7a0I7NBRtYXMGbOxRO/YLu4Ww6BA7Pj8EicgNCovOCB2i?=
 =?us-ascii?Q?fn/USDbOL7iU8TB9SjxbnGB3KwU2A0INeGjvFp99HPppjMd7lRRpusCJ6Xye?=
 =?us-ascii?Q?U5PiwH4xQ4bXVxrLiuIshmf9J2hy4pNI8BVW+Iwtt9Y9WgozCR4BnERNVKA6?=
 =?us-ascii?Q?xXm9H/vaUzPK2ja6wJiKHY0zxSS4UNbgkMgtMrJuByROa3yQit993h4V4AWZ?=
 =?us-ascii?Q?VQrabI4CMvnc7dUsLzTy+HtfexB7umjfX+k0VoUBkWFm9oS1sUqQzAV6UwUr?=
 =?us-ascii?Q?wKIBO4KR4ePh3ao+Fq2ZxR2dPQnebnx3phk8BKvw14qMOZTozeHHzknVYswy?=
 =?us-ascii?Q?dSk7rJ8taK2O0cdb1u+IukU5t7iVsX0vUCqaFAxzBIxKSAMTjfX4WWF/svCn?=
 =?us-ascii?Q?/Q3ENmGTgs0KFwCRhWIwVMs4+mYZ2jwHRlkBgVz7XRPYYfZw8fIUMzhnLLF2?=
 =?us-ascii?Q?38lp8e45scYKSWSN6VxlhoVgesEqaS6RSqYuJjMXhkEwLlHsDlTLlJ9KFNx2?=
 =?us-ascii?Q?oCaJpfqEqFKok8DVk34+z4bKh4HgS2fA/m6itUtBv5mRTqOts3CGwKgHN/e4?=
 =?us-ascii?Q?ilQUZSHvvb6jDXLNNLqxiOwJEcrpdG2NEDnCrbN74ipxCy8+OZ3RQNYIbANh?=
 =?us-ascii?Q?f8npER1bGF0RQryRVJhev7SNfR/kDZchSULgWlMvV8dKDNixR8MxnM6VaT3o?=
 =?us-ascii?Q?Sxcu/I2ss4GNfh2dTLNOz+YktoSu+TB8ITdZap1U+8e6dhPaJ1puRJvJtBVl?=
 =?us-ascii?Q?sCjyUW6LmhjJStjbNyZvIv4EZLTYgUWSO0Qzenpc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edbbc7f-5681-4546-eacd-08dd4b4274e7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 08:51:36.1087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XH9PMqMiTiIUiV5ogPDPaofVPTWB7v2etttnu/TKS3w2rtzdR1XgHXPVycYFiXFDDekf8iG1RO57CPj6PYYRHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9576

DSP can be used with various frameworks (e.g audio firmware, rproc).
Currently 'dsp' configuration is intended for audio firmware but it
doesn't work well with board level DTs (e.g imx8mp-evk) because
board level DT enables audio related IPs (e.g SAI) while audio firmware
needs this IPs disabled (because firmware will configure them).

So, configure 'dsp' node to be used with rproc. This way users will be
able to use board DT to use the DSP as long as they don't clash with
Audio IP configurations.

More comples usage of 'dsp' node (e.g by audio firmware) will need to
create a separate dts file (or an overlay).

This change follows the approach taken for other i.MX8 boards
in commit 391a319c81f6d7 ("arm64: dts: imx8-ss-audio: configure dsp node
for rproc usage")

Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 00924e0836db..2f94c55e4999 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -280,7 +280,7 @@ reserved-memory {
 		ranges;
 
 		dsp_reserved: dsp@92400000 {
-			reg = <0 0x92400000 0 0x2000000>;
+			reg = <0 0x92400000 0 0x1000000>;
 			no-map;
 			status = "disabled";
 		};
@@ -2414,12 +2414,12 @@ usb_dwc3_1: usb@38200000 {
 		};
 
 		dsp: dsp@3b6e8000 {
-			compatible = "fsl,imx8mp-dsp";
+			compatible = "fsl,imx8mp-hifi4";
 			reg = <0x3b6e8000 0x88000>;
-			mbox-names = "txdb0", "txdb1",
-				"rxdb0", "rxdb1";
-			mboxes = <&mu2 2 0>, <&mu2 2 1>,
-				<&mu2 3 0>, <&mu2 3 1>;
+			power-domains = <&pgc_audio>;
+			mbox-names = "tx", "rx", "rxdb";
+			mboxes = <&mu2 0 0>, <&mu2 1 0>, <&mu2 3 0>;
+			firmware-name = "imx/dsp/hifi4.bin";
 			memory-region = <&dsp_reserved>;
 			status = "disabled";
 		};
-- 
2.43.0


