Return-Path: <linux-kernel+bounces-439576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CBF9EB148
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DF8280D21
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0691AA1CE;
	Tue, 10 Dec 2024 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mcReIG3N"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241591A9B34;
	Tue, 10 Dec 2024 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835260; cv=fail; b=PQjh1K53hxc7RoCaTSpglzQLHPrVQtN5VnrOlRirbRJooLAy+i96LcV06XxJN+djghrCa3zFZBR97G9hgQgXbGGITKzfP9v2fxf6diiMVISWKRn0EXGz9A45nkTyfAONbptBA6T0hzzTf+vbZRv7gDu7tEu+JrD5Upi9S+ZvbX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835260; c=relaxed/simple;
	bh=CjdnPZqjZNBQOYv8naOB8WLAV5ZkBRcNSCWZW15/Phg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=It1T9iRqBLwbi2FMFLWbMdgWt2TAQVNgXkdrP2yNc5AGdyY/lMg91OeHaJe0ADKVc470fWR3IepHHAUIymB7n1s4tHLn3A2XjyHCC0fSeEtZBvcS1rccnfaJ+zKbbYPW1hOkw6wSnQ8s7mnqjwsAxhA08KM5LGusTOMgXLPPLhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mcReIG3N; arc=fail smtp.client-ip=40.107.104.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGKsEDysUW5nVK8UY0zKiTej8ZRoHEu8F/sZgx3e5BSmGV/Y+lCignUEBEgMkGwL6nsmi4jmcnp9A5yionJPQNpK0UuLj2y/sYPZIUvNeSZ6L/tHR1o2DpTEP31hwZhq9LkeMjy0kbdqU5NFqy4AkoYw2qjrTkhQNE8W3uxkWOY1KVbNi5sY1uJd9cVPE/USkmUwcjl6hWOiKcol6fgtDLsrfuqRnkBqGfbvvfDGMQ/HpOOoi1fezHrnbQhRuQKBQeARRh4UYqks+RzSCIPTQ7cdjGKakJYJo8AwoznW9Ia5qnLPAOnNApm5/4SZZGzQYndh2D3PhGEtFWQJH9xZ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wb9a6mJjiz5RjSyVKbvzwDYVi8GP7rysyEqwmrE10Ik=;
 b=nkwymmJV7iTWEpPLB3JD63dmcXGZ5tjZ6abprFUgJ/thOsKrUruqCvc8FON6hTP6R7bfZjakxx7ytDtxgkL1lH0hct0q8UqnTRG7EnW/uZnuHPixrIBiJzcVXoO2xH0XjyGCuXVZM6avztVoc/HnGi4sGofJbime/1nO01p81Xo7fCXjlhporDplSymDXrWVxclPZaHz38VdKVSZnEJuhAd5gBLdx2Gc8s68zp0OJcCv0U7nhDp6wS5iVpmq1+B26XsiiIBO2xVbaQXvmjvfFk1q8OLUfWYLsByW/+DSSOm82DQb6CZlq5g9Jg4Gf0GyMUk9R2OSYX+fyvcKcA9RZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wb9a6mJjiz5RjSyVKbvzwDYVi8GP7rysyEqwmrE10Ik=;
 b=mcReIG3NUmRJ2lXL0+8BnSplFUa7icyw90GRVAMinzYq3oPJ7TKtK+sXeOq2aacYj7mCmEAuMrXOgdgRKmNLrCVLY4zTVFB7yLPJDhZMPE87O6NwhPgkNWG9INuXVHDrvOvAuqGED2P/SueIaZGXtWlrTIkCMYMWGo0wvQhFNxR5EUnp7GqS40mB1svi/bF9h1EW04gPL7LFQswvpMWVZqHVvaSYbWw1rD+DOb5TG0ko1BOplqVhKU6Epq7qsVFBRWQlCKVyooHSFyLjmdF6FdkHZk7yBkbNcQIWfdM2f7YmQ3wB8isinbzKbk0Qh4YfGQftToxYXfuy4gXrUKRTNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by PA1PR04MB10793.eurprd04.prod.outlook.com (2603:10a6:102:485::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 12:54:13 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 12:54:13 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
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
Subject: [PATCH v3 2/6] arm64: dts: imx8mp: Configure dsp node for rproc usage
Date: Tue, 10 Dec 2024 14:53:34 +0200
Message-Id: <20241210125338.104959-3-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241210125338.104959-1-daniel.baluta@nxp.com>
References: <20241210125338.104959-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0040.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::20) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|PA1PR04MB10793:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a03593c-be46-4c95-b7d0-08dd1919bf4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ZIqsA+CIhmEOClDu2uw8vVlOWefCe67C5NORdNiG8RLPboNb31JHGA5E60B?=
 =?us-ascii?Q?aWVeQ5YR/eEeiMN6INbp4mY2ElMzS2BPAq+ImWOOGHqfP7B8RklMul1zXyW0?=
 =?us-ascii?Q?wC7bnwn/8x0vTZfE6XyNHTS5L9R+rCsMp6E73CBTFLoDYcSTff8fxpkuYPJj?=
 =?us-ascii?Q?qLJpsQceVISfsIwShWgNoOeNv+NKxea97Z5yHB1+BS/hgc8cBBl4ZCu/DlRv?=
 =?us-ascii?Q?YEtxiR3L5rplL5h9+8/xwcHzwZYD63cT81j58nivIRBD8phC+uVfm4/OmjXw?=
 =?us-ascii?Q?ce1rSsmqyyoccVm3rpf1G+pjzE7lXp7Az+ahzZoFf26xF+6U0LeqR1A3grsf?=
 =?us-ascii?Q?cNbZ+ei/zrVro9G4jAu919OVHPOPj0+a8jQgtZkfAHT64s6nbQ2KjShxQyv5?=
 =?us-ascii?Q?3AtNzODoNJmGeSmwIuN5yvqyAkS61FJBgsrvCKnmUBSCizVxRfWOfUcbFEzT?=
 =?us-ascii?Q?maZKE3nTZjcYvxPtUopaaDWLCJ/qzujFbkSCkJJ83hT3MRmg9NCLUKwAUDjn?=
 =?us-ascii?Q?YBbT/AWg7hQTqAnWAI3hBq75zIlHydhqf0AWzr7yNRBKqfowDGGEOb8z4mT0?=
 =?us-ascii?Q?1kGh5873w6m3fEEcgznOBG6SoIBtL824UapGdiPonmsFuOTA5pz2Xo0QzMLt?=
 =?us-ascii?Q?mw4u7QMs6eGPUjDG6UC0mvafs/t4ad6xyq8F7Ht2s+5xdeFZLCIN6Buh2+rP?=
 =?us-ascii?Q?9fZYEu8jWZviv1K23NofVaw1EnGfY9+/NhxzPU2Txlo0evhCVccoxfEnfkke?=
 =?us-ascii?Q?xPYvHUjMaegvSA778/9zhic6nNOB62xIHSleGfNdHT7PRVlKBAwOGXWdedNv?=
 =?us-ascii?Q?Zq/M7DVALMDa2xKwB8PuBJFcDssUvuN0pKexkLuBqsePWP4pUkD1aKLT0IXb?=
 =?us-ascii?Q?omzM/JKENNCSr88xfM9Py+uYxZWyqAUmig5Hm0QD0fDazg4nmRmS+vT1J1zw?=
 =?us-ascii?Q?2j9tmLowIZ+cgbEoDRy6YXob8t878AUS0NdbON1XmiGc5qDofBxzVwGhQ4Jo?=
 =?us-ascii?Q?T+KJwgGvOvHd/QIiHebMl5s8iX3HCflkHwYG+fWLHkhKhPt7mLgvpn7Vc1u0?=
 =?us-ascii?Q?OED50HC9fcBgIPsZLqBfUufqTk3sqIel55Q6V49uBKoKf18axfwYeoefDwL3?=
 =?us-ascii?Q?dLmDtlkRQ29cLp58bPsYMNExpedVe7fV2zzVgs9126uBnqZIbOuSJXhYmLQM?=
 =?us-ascii?Q?ELLfB0kcCGIIch7oG+aJIIIov+sgj1Bwk19C/hRTMG7uJyzIyoWVQHF7VrQu?=
 =?us-ascii?Q?q68WfbfzVW4yLMnoYmAAZ5F9n5EUK1gOzqV0G+WRo3ea/wpmlHXzFjFI6W9m?=
 =?us-ascii?Q?a+7fdPjpFig4oTF2Ib77wZHqoJ6AcbSIF03vBGOU7FcGpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OrqAADMZTkFGlZv00/F6qg6/jhSWOF+N8qvlNQBC0uyS38KNDCv37iTH6S2b?=
 =?us-ascii?Q?yCQCUXu9xToWJdK0lBDu2YCRHN4I3o7tndBYA5xKVFm+J0rN/DI1YuG/bQRC?=
 =?us-ascii?Q?vFFFvFqkaaTzmBsLJCbDq+Ns5Hn8cjbMTXh34skTy5bcQeDFv5XBX7/6zM6y?=
 =?us-ascii?Q?5NstJHw8SkBY2epvj2aap+BHUwVamkiadm4n9Bi3/Gk5hhJDkCGIWE5EZwkQ?=
 =?us-ascii?Q?qdivrgnzwa6G7PgvhnQoGEnV/BS8P4FDLHNjUMke0JZUYNIFibNOw5MIyp8M?=
 =?us-ascii?Q?b9VmXKWZM6Jua9MWzyS4ZG3cCAqUs4Hkov0zQOdakHoTGTV0/ODeCAL8l32r?=
 =?us-ascii?Q?rXLmdNSjNwQX+iPpbAo2KzISYKHrJ/IBhNlAv0c2YS1L0sVHtVLe8fQKzHDY?=
 =?us-ascii?Q?U9gXqd0fWCXsjlgGrzma62HiL9CTd3J3Fxz0bx060YBDVgNYYz2sO9dJiIbV?=
 =?us-ascii?Q?ZZh44Iaf+Q4zgVarJtZ5SjjUN758+KvkhWjeeTE1QYB/PytPo/1SGWox6Nl8?=
 =?us-ascii?Q?3nDOujtjRDnBwjwNoLEXFvxvbEACN6lL8dimyPG1RVyYGyHIB59FRDiqtx2v?=
 =?us-ascii?Q?15bxi5e1Jze8x5IndGKdX90vdunrz2EyNo5FrSggbp6C+E07oatMlpCkxy2v?=
 =?us-ascii?Q?/QoeYhIhBhyWYkJo0cq1LR49vx4fmgtz5r4hUZD7llTKI9vsGFihYd/7Rbtb?=
 =?us-ascii?Q?FVKnoRGCDwu3r8BDIVCjasXBY+Yje9Mxs5Tk6dVDKaoHaPcwewnr8tWUP7xy?=
 =?us-ascii?Q?m1/262kgrDEYcXrpvrIlv+Q9vWN2HDPJzY+FJvCSwZXWGC54Jwj6y2n/iGVW?=
 =?us-ascii?Q?MMkXtGGwsHjEdezcc6oxvs9uH21LMu56du1fjEefOT0TQLDuf1QJO9uoX7Nj?=
 =?us-ascii?Q?mZ+EMa3hYvJ9LF6qomp6Oy5WDogsDqbclWnTEgMm1srNMYDHXXS6gz5OMhhF?=
 =?us-ascii?Q?yFvvkBAjX4gFe+XpaHa1jEarxc5+PTajOdUB0LHprResj0Jv6VfLG6AN/9y8?=
 =?us-ascii?Q?A2LTglyg4agLj8V66AoP8dbB2a+KbpLX3/okp5MLJlDA3pvAq9i022ho7Mdm?=
 =?us-ascii?Q?DPHkD3437j0ZruexTnzlZXcDTWWX2qZIEpvHlhu2cr3dElVrd3VkHKvU9zHw?=
 =?us-ascii?Q?Su2MrJd1KBNmLNYyaxZhLQdf0K9QtyGOgg64ORQQxKBjVcQku/2kJ2B9RKYK?=
 =?us-ascii?Q?dk5CiUyaaXYmv7UMrFk/OJEJkZ4NYXSQuzHqJDOSkla6GKVXjlS5LZst0Le6?=
 =?us-ascii?Q?qIFJdG/z583gdsKoxD4FgyrcFFQFeCDKerMdQpEYZEgd+kHjvp1Uf3aFc1wR?=
 =?us-ascii?Q?YgJ+LsE21arcYC2DTJm3VLEXhr9Zkwg+rwwQbJyOhh8GQOzi9wJukbxs/Ng6?=
 =?us-ascii?Q?OEGX2zLa+84nev6jO52f8aBxGwKNJJH0b2+lKINukg5nJGCtbs7uev4K+Abk?=
 =?us-ascii?Q?ituWbWFm5Fj56ZAYd1x3UKBbTjGBTow+BinHYaTuDvAaQeT9hEnH3dkpBU2H?=
 =?us-ascii?Q?MvbdUj7QTeg70G+PSoKy7ArI7UW5/rEyzq2VGM0TjGq5WVerWPkYoKzM1ypo?=
 =?us-ascii?Q?FbVkNTWkzUUB5USs7FT+sI1xHAP8In/z4QTxFu9z3PgCGxNbbeYDvJFXWU+B?=
 =?us-ascii?Q?MkW7qaZJYiLAy76K0O/MRpnbXhmbkjVcWqB3FA6JNkDS6gX/3t3NI6gJjZo1?=
 =?us-ascii?Q?hiP/+A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a03593c-be46-4c95-b7d0-08dd1919bf4f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 12:54:13.3681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYeqaQWAHZ0sYjcWAVum7WvanTP0MUUe0VtPg+6qlOT7q8UMNRP40WiKNHjgrG9EFf2P0EVbagv1LBrDPtiG0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10793

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
2.25.1


