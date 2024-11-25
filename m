Return-Path: <linux-kernel+bounces-421296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD9A9D8938
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7453116281E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03001B3935;
	Mon, 25 Nov 2024 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b2IVlaGs"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013005.outbound.protection.outlook.com [40.107.159.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5171B4147;
	Mon, 25 Nov 2024 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548210; cv=fail; b=bYfteD0t8KuPTW+jNTfzYF+S9a8EZ+9gMNBweC8hvHL5mh2fWgBpLqmQHE7tvz6l8gscgIH+xQtD6U4Ikqa5u4omiF0QI3xw6ilUhBWlDq6mMA8I5UqB4u9R2+5EHpwsU4XIJiljEQf2P3XGyXzGEraXWc9vA9d+kZrhk8dKq8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548210; c=relaxed/simple;
	bh=b7CPYGbDdkJ3P0t7x8I32GSiFjMdqxl2iHsUrYvwPYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=km76wCwPcjFRfdhTgoNjVnH0RPGk8ZV+Ga108y+jWui/4K8Ab37LvRAjqKBfSvIqP+xnNV64dW7obezgZ9bG9BU49RQ+UBQaEToMB+olRcgAX5jnVDkQEHk8psgZfd5T1fFU7uaZXUNcP32naIj04aiBV8XS/iltYg7V3/eC1Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b2IVlaGs; arc=fail smtp.client-ip=40.107.159.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t63YelZPaGwbXL6KRmPVtT09/FYQE+NWbvIp8FkY7yEfLElRMGiGenpYCcSm3MufHkdJ/rOZHi826giBqCZyr4YRv8dzdh6Uan3MqjVjriz3jm3N536JOPKovll7mIXMy5+bR3IkDggwZNcNs6i212DpGM/Mx7IMUhjhO7kGnAPtear8ddtXiznRK+FqtQLfgjJ3CYL+At923IhWmAMTKRRdmlbB9qR/RYM5msikqFlETnMmj0tj+d9RsZW0rz64BotfD1EEzYwekpr9GTg6DFoKfDW48cDHNFUzMrnU+cQ4eLtyRtLk8Egqp42oyJF9yoDrdfoMaPIF5EldJwrvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gp0P84h5mRvokb+TSG06tPzgdvFJkBHf1YOE8W+FUyk=;
 b=FV0LxwjWimnU/Y2NEBYppAhEXjzXteWp7TL0pmq+5sxfPqSyttvPy76XyLU8kkoMCOVfy10DCgBEP9kNGQ/+INzVvRCl7zAD2EgXe5TdgadJ6gSBrvGmSawuFru2gQk361qAKTZE0cEF63fX95yBckIAul1RP366p1HJfKyniTY3WVtwxBrq4ygZ0nCmwhDeOSAha3t4BMMLnftVD/BQq8RpH2Mf4T6hhmyZuiy/KcRLXlcoKUBwLqL3ICYKNJ1/XUYInxKk+uUsn8VrwmgYRmLmQT0wzpVycIgs0zahhon12VV7w1gPw9S2VUlolF5cgOMxN68yzdslmAEGIS118w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp0P84h5mRvokb+TSG06tPzgdvFJkBHf1YOE8W+FUyk=;
 b=b2IVlaGswXmt/5AJgQWurXX+GGU/u07jCV71Vr5Xmfyh38drv1Jpjt5khBuMBbWcnAwc0NH7wJpCOrp62qLb6U418h0fZ9sE0Qx+LF25MSukUq3qmnkLv0t5uZnHfO6Is0JS/pcuC+z1SfpTPIfEIYfNheekcCrBWo8rPh9bqdfH7QKwNuJ+rcJ/uGaPBNNBguD7acO4VfV4/srbb0u59Z3pG4Jz6d6Ba46PfH4+7iHzqSn6AtXrKrwb4uMSTzssha7Q+ub9xeSrMw13SjGCQMJqDYT0IOmcFagGmub64x5BC17GSfPDRnLvO7K96DIcM9Myc6Hcj4rTKICZ4GMJWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by DB9PR04MB8075.eurprd04.prod.outlook.com (2603:10a6:10:25d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 15:23:23 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 15:23:23 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de
Cc: robh@kernel.org,
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
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 3/6] arm64: dts: imx8mp: Add DSP clocks
Date: Mon, 25 Nov 2024 17:24:23 +0200
Message-ID: <20241125152427.136883-4-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125152427.136883-1-daniel.baluta@nxp.com>
References: <20241125152427.136883-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::13) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|DB9PR04MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ebe405-96bb-4563-6b97-08dd0d6519b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uxEIuhAFdfaehxlr4E/NFO8uZhdu97FyMPu0H3GvSydzkcU1872yDEfAxjVb?=
 =?us-ascii?Q?4TUVpzwUNieJLxzlxE0wkb6VqHFWwvH/E8tu8FBJc2Lhz6+kQ81GfyCZnmpX?=
 =?us-ascii?Q?xa44xgf+Upf5LolU0KNWr4TwUpn30gLyzyakvuFCqoXsaKn3HjQqI8SFdtYF?=
 =?us-ascii?Q?I7ux7uhCVUz0GYkzRksKmgxSxU7EXHN4mNYG06YBM4L3QBW1YMT6rJ+GerTV?=
 =?us-ascii?Q?8Q9ImPdJKylbYdxUThj2+4GxXl4Uzlo9MPVzbIH7eWoYLqhOusijrAQjX4sl?=
 =?us-ascii?Q?8h4YVtMOuez70Q+hFPGkgW2nz7DxBq/9AMptbSHuTgVDrglfY7gC6cdVaM9p?=
 =?us-ascii?Q?axYj4z30PfiMjy1vU7VAdP1E9z+uwK6KDbgM3jburl9mx1Vau7mZvKjv9m5J?=
 =?us-ascii?Q?m/VlIT66SBUoiDuGcpgpabP2x+NO7VqwHnjIGf4EJL5tLU2Zm6VynSwYAuA/?=
 =?us-ascii?Q?Di4r575mMfm1Ee5z5PZ0o63jet6TrOU1L13aa7M82mNnhzscHPZZtNVOqDa/?=
 =?us-ascii?Q?TDAIcGyEe7wpZSWFF+Fmu6DkEs7Mqqo2N7vTMJ2AmLMvO/+/nq3SG0VehAV/?=
 =?us-ascii?Q?zElq7Zw1677JvwVxlHu+c224KwYmSKztM+c8e53fmmCZhZ9WECRYMct1CQz1?=
 =?us-ascii?Q?4Os86/WP9Lhm4T/LMXNMjJbIgllc9k6WE/NeJqBm1hIgzJx3XsCqZ7CBvToO?=
 =?us-ascii?Q?PTvkM0rjuLlLgGcQCz7R/UVUAeEzB0QggvDdzSvebH9qORKQmkDkWiHo8UPH?=
 =?us-ascii?Q?53GK1oUA7SamY3TluHvBzsWaN5uqjjvKqEEu1gKGYH1KO1JjOJ8EphI7wGOs?=
 =?us-ascii?Q?fWmo3O34JlT+coVBFemSsiw1bcZOw/MQBw2uU/0i2tNPMBM/ZZ6JFJpCan7S?=
 =?us-ascii?Q?oO0PGaTCDy/7pMDLO7SsuJvhd3rwFUK5t0jTjclkFWJJ4+FECTnoQHNmQIbV?=
 =?us-ascii?Q?Hugj5jP9eXrfL9IyX5j2m8arpL2j0IXKNG/z20ovjF7IHH3sGM2iTQCKhbQ5?=
 =?us-ascii?Q?KhXPBtwsYh4lLF2Aacxa0AWW+P0mf6ZRVuyFTkR0af0ApCeBYCBkCZz+VsMR?=
 =?us-ascii?Q?sE+WM0C052phUK0Mc9blC2QF1yh/JbdAlji0Py+bZelk9GQwIEE+1WwRsyUx?=
 =?us-ascii?Q?aybNtNR7Ga+zf//B8NREjzLzhoecvGbtrMm9lO3cLCn+YtK6ctgJyW3PlbGB?=
 =?us-ascii?Q?VC5M5H8N5bd3Mz+L4oYG9MbcFkKdBdQW59YG8O6Ynkdc37FxaS6I+d6K47ae?=
 =?us-ascii?Q?ltb+hMa6EI8KM8m3DZIbQGUmknk+5aorWlHWtbqJPo0KIku0clgvRdYgJkMZ?=
 =?us-ascii?Q?qXZrdxvGyL1V/de9V9HIcLEfxbVboE7J4+i9efnmgsPXWJnmGBS5iDRWXbeK?=
 =?us-ascii?Q?st/Qx3bPNJLO9YTQs9gxHwg9SD1cV0Tf8mSSwlDviDKnY9g9UA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UF45Hpkvhvixzl39o8g4/W98nP11GH60kxSLwoM8t0Js+lkS3DOPWnEDqRAN?=
 =?us-ascii?Q?IyxZ5e82uao9WZkpoNinthAO83Nm98wK9QYsFr9FzyAmu7MQXZxSkPPdzUT7?=
 =?us-ascii?Q?RjU9WPzD6QcAOa4jFUarS7OHCiUxEUdRUTiQAZ/c/aw/jQ73eaEcY/AgYlWi?=
 =?us-ascii?Q?+iE3KnmKxjduscJB9u4ckwfPKBm1faTm+9qEKcPgQyiYWMX0yUhbQ2cEz21A?=
 =?us-ascii?Q?vm9KOxddBPlJeCenJzzjNqjWSJEtyW3MXr1QrZ7phmvUNfYqHANrIIBDhrU0?=
 =?us-ascii?Q?R4ZjBQJ3Mkc0Fg8bllZWrMa+lkyb30KjRwudqRupDGAc24iQXFcrPM+YroTu?=
 =?us-ascii?Q?oeM2dx8Oxw02w/ZLtcnAdrpWPNYaL3sAew0/gjZZWS5z87UOflC5yYmMhPSC?=
 =?us-ascii?Q?3N6vTGNqnHAeB7pvJMTOebPs4woiRKcI8tON6gOPhNDTKWgEGwjcXIewmB64?=
 =?us-ascii?Q?rBCWJFupI7BRnHgjYhOzzV9BoiBJorfZTP6s5jZq8GwkOD8ZJAE8BTwW9cZm?=
 =?us-ascii?Q?y6fpNGEVOIVwryEN1ZnKBD2vnBo+Cc+H5Vus56ELGRPZA4Gkc3h7B/N9zDXy?=
 =?us-ascii?Q?6v7qMmsLjUrAfMlNuSoRPGXUd0sL+94Uadq5TEuHkCxMKiEcRER+jazc3c46?=
 =?us-ascii?Q?KAW+Nj6UrAzhTxgJnnVINF1Hoc//kGN6SCDdCQ0X73/GnQ7qdIPDSPe7o8KW?=
 =?us-ascii?Q?JK6gaW5T77QPEbMpN0F2C3KuQ97tv5iriCXaQNoMak6ruMn0FW3xeqWFiz+k?=
 =?us-ascii?Q?V6CXj/peNTYmOiTxhBfKe8OeS1AehBdBbOxFdDQh8ww3h2/RQSzVxynAgzpF?=
 =?us-ascii?Q?e1CwnX9///IA4/sPH6Hwi3s6vAFGvhgjYkR+GsSQceb9kffcq6ywCGQk8vbn?=
 =?us-ascii?Q?xKoQ7AJaV7raPIdKTyz/ZaOQ4xAyHysjd9RK8uv4mdCMOBjuVUUItRRo9vLY?=
 =?us-ascii?Q?Pv4lFqzAOv4vv4v1Gddd6QXJEotSyL8ycvWXMMJk3qQzYi0iAlxgnUioT+HF?=
 =?us-ascii?Q?cMUqrcMLxw0DZef1iXdgiHC8tg/Bz1tTVEoZ2EsqToBgZDLFMJs+aqafJKwV?=
 =?us-ascii?Q?cnwzvfuSG+Bd26C81HvF+2AkhboLj22Fy2F79hedE74H2F4c6XOc5DXcQclu?=
 =?us-ascii?Q?GRuQS2ka98N2Go7QbqJp8oXmqTBbFf43zwRJD3vT3VMpjYCcOfhJebBO4Uro?=
 =?us-ascii?Q?L/kLqXZgAn2wIgPIIYj50XAaNaMd7c08nCiOVCjJwAkk3WDVocn0VaCGwpq2?=
 =?us-ascii?Q?a+SnjdzLh4WrLVpLVp8T3ZqAba2F+zh0dDTfN9qsASYt/hg7N9lvBXdsAfLW?=
 =?us-ascii?Q?dzU+tphfYQrPNajAoWELjoM9H/QG23N8Uo7x4nUGWTR5JutzbrBLF710Eg7M?=
 =?us-ascii?Q?0DjaG7lS+lhw3RWmUP6yr6pga8oDzl3bA9v46Ke6QxKDoGpjjBOAxWCNbHHg?=
 =?us-ascii?Q?juMnID5O7IMshLMHlWsP28iCEPLPQ/yXE4j3AgkwKhChnwBlQVJXZyOxcxhY?=
 =?us-ascii?Q?F4uVx9cm3n2nTiOoVLNApTNoEoZqbgsKSsvNZTbLYfxWV3FcnFFBoXJeF/xq?=
 =?us-ascii?Q?AaPGIen+bo1l8YjYbFiGoF2TIqEhZjA61TPXJEBZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ebe405-96bb-4563-6b97-08dd0d6519b3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 15:23:23.2653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joKNBvrRjVEtIDAkj/dKtvgS/vTKRd1Q6ImfBJmxtgV5areNhY+2mphXIP+DqThXnUUkX4xtTTbfqYJv+mdQ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8075

DSP core needs ocram, core and debug clocks.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 2f94c55e4999..b42e6430123f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2416,6 +2416,11 @@ usb_dwc3_1: usb@38200000 {
 		dsp: dsp@3b6e8000 {
 			compatible = "fsl,imx8mp-hifi4";
 			reg = <0x3b6e8000 0x88000>;
+			clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_OCRAMA_IPG>,
+				<&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_OCRAMA_IPG>,
+				<&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_DSP_ROOT>,
+				<&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_DSPDBG_ROOT>;
+			clock-names = "ipg", "ocram", "core", "debug";
 			power-domains = <&pgc_audio>;
 			mbox-names = "tx", "rx", "rxdb";
 			mboxes = <&mu2 0 0>, <&mu2 1 0>, <&mu2 3 0>;
-- 
2.43.0


