Return-Path: <linux-kernel+bounces-370902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 759A39A3372
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35368285592
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125DC13AA3F;
	Fri, 18 Oct 2024 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QIFHvwbO"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A4F176AB5;
	Fri, 18 Oct 2024 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729222632; cv=fail; b=ct0yZmKTUrhE73j0h0I/eXYFCQYH7LPEBxffy80PQp0t5BPpg8katExRBANhSDbug9vCsUI7PPB+au8ZQ6ZPTrvuRcjkNr/s5AOvRiKiQjPDS8VgSqxLLvzrvSqH98ClU9PlUjF2oJ/SmRtVhjF3sXaJfwshE3zwM+i8w42KA/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729222632; c=relaxed/simple;
	bh=Ll92Y+KzFTx+N6f5dQF/gPV8fhUjLKipQ6p+4GD7ni8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nzNvKmPJ7xxcX+uS7f/0V26BVe31a18KrsuH+v7tEteUUODMx784OvsdVY6zPRabjnP7NqZ79n+yR3C8gSq6qRQqi+tSLAwmNc1Z8nJ2+HawZK4v9lO8OgoXi8ctDCgBK6MLDyeivR/cBvhIKCXs4kNpblR5p/ecb4cXm7/M80g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QIFHvwbO; arc=fail smtp.client-ip=40.107.22.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I75v5Fqh6EvXNTh5Bax+TgZcfEUowMy4j9GpakYudFGG/wZRa+ByarzLctTuJJZxsrJQbPTvouhnZ7vBChvgwKV5UNz1g7Hw2kx5k5LSeA71AAI4BMB2LXJZh+QgfLg5XSKUmB0f1qUaq56PWWG85XuoulpZe8BR6wRsNE1Ooa3297rVpPvXNy9htynJ9raUzebtIuv1uQ+qx9QQQXEX3UweVRR0LVpuhxeZ802+EKeZwV3CmyJawGWeCa905BBUo+R3QU1Fxkc2wmBylnEW0E9AFV6Gym45RIhkBAf+5uNBCxVld7PmJ3jzOM1+Xo1nfww3+PvrgtmvC+ZB/17MFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xu5oPaHYfkrnjaiBOsvn6PUWAhabIJfIFulKqxjgSYc=;
 b=lpsjxzWCI9uxFSLHEEOf7EZFj7+298PvSYfMY+S+VQNOcWRkcSf3pSyfISN6mcOzNE0lhlEVdsJ/wG4AfnxkLS7N/jjkvvUDH8TMOoxlaNTNRZHpnTAGzAM8SOt/xAAfQqgG1C81IJxDI8jSX1c0AUyygMxHVQ+M60HYXpUDiqTJl3D6rLCFczw86hBBLliyezx64Nbft0vAXgp5rKGmLHHksdl3NIrziesUYFQEnz9PtrN2mVXlXqz8CVhLkvBnE+3dXDpX5/wEd/460h3h6G8DTokB12be3DdMpAA9qpyq4WZkOKHmp4F4Bb5F0UmIJ0+DbRehA6P/2AsFRsvWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xu5oPaHYfkrnjaiBOsvn6PUWAhabIJfIFulKqxjgSYc=;
 b=QIFHvwbO50Xw9layl39RURLerXnQ4QlVz5/SQjI9YwQ26ju3Six5j0Zn3NVMWvWwuHuS0ba0crBESdkWvnLAmENj3gCSdWT6k6JyjK0G+NDZ+8oZ6JQa74rXBLDxiuhDBP0dzBc6ISOtsxaKqTXQRjzSOSAGn9LN2oGSFY9UH1rF/PVeuyR8Z+rfp85Oum4AiM5FhlG6lgKgdhvfgPHkueW0gMdXyVk+2asN/1dhmnQUYBwo/dXRqjoN7HxJrfN0sQjlUTZoD5C/EQcdGLYjZ4U+kgn5UAGiq0YBiWU6r0yerDZvj2Q5YhMIMd7xJw+vXC5X7FhZCIXAwGYjV1ZRFA==
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
Subject: [PATCH 5/5] arm64: dts: imx93: Add LPSPI alias
Date: Fri, 18 Oct 2024 11:45:32 +0800
Message-Id: <20241018034532.2552325-6-carlos.song@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: fb75e697-3a8e-400a-f2d4-08dcef26214b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9U4pdLp1MA5dRvt+5aoQ1SEjgHYLvfHYUIxSuRDikto1TBBkMX7KhhyPqalN?=
 =?us-ascii?Q?eMNbRUZTXeWtyPAO6TSOWtxlzzC7vL9QZ3+evr36a1V2B7as/cFmivT78M3O?=
 =?us-ascii?Q?r32yMdkxLjkWamxySuUSwvffEY4wtXYjX8rRvSqcdLNcyvZPPW+FNaj14kD1?=
 =?us-ascii?Q?xfU+EEj9VwBobVw1nx8kxeTiREwJiDw64odKnKX3zObf8RBGRDX4bMtg2Xu8?=
 =?us-ascii?Q?Yjnp1QTdNmFxnCj3AKSukPgAuTmZBFhsS9Rgc7b0P479Fky+oqxYRO2P23WT?=
 =?us-ascii?Q?6Gv/HStKjF2V8vwxGkHQmat97uUdNumNeQmRa0QB9JAR+GP+D+byqTKrc6hR?=
 =?us-ascii?Q?voTkhhh7SRV2XsXLIL6iMfbKEQckVLa2Dgtcc6aAsBQvewIAuQ7tI3JWmc2d?=
 =?us-ascii?Q?TCnPOHfW3zi1yXyW5ouzcz6LoCaZyJooGn00GCprTRk0rG03fZdWnv2hQ5sX?=
 =?us-ascii?Q?Xb0KfKzb0rGNu+nwo7mPX53x8Ax88NtCkHKb3lGWrB+sEHN1VYpRHBqXZOPj?=
 =?us-ascii?Q?yK8KWK+MlU78nMdZDZ0R1kUDyLLmrRjFayibCX0Nid4tDot6UXVBgyGemIAT?=
 =?us-ascii?Q?0iMj+Xlke/haYGN/0UVQidPcJh77XuEBUV/+SCNhDE+D0W3BiIjAzIMT0MUU?=
 =?us-ascii?Q?yFB2SIsOivyyayF8E1iizAmSj/98axWz3Xmrvkhz68l5mjId5SBi5HyfVhdM?=
 =?us-ascii?Q?rQOV/hEoMMiTfLrWFOxzqu5xTmFKIvzpsX4duZQLTSfDaueAwfjZ/qdTV2yP?=
 =?us-ascii?Q?k+KIsq6qzpiZGv2ngVN92OZxpfMBP654o5JfqndSlcKBYARo88FI1zDEbzxr?=
 =?us-ascii?Q?Ym0gcvx96b/6qOu2zHTNjAYZqkunWrli7uU0A3DEVAPAzxC1IgtAjI6eSl5i?=
 =?us-ascii?Q?PtWru1vUHhFXxdk61tXtDaACMVttBjuJ6ut68wuooswoqKbYRUdB1cKoQeNB?=
 =?us-ascii?Q?FHM+jt1CRq0s4Ea+tWpeg5MHdIC1RtgVS/2dLlJtTHyr5NYHV5+WslkbqhLm?=
 =?us-ascii?Q?oGxWyGKeroJynKMq5H3Qc/T/Keep/T7bw8OCvZGZwQY8Dpu4UwHS7TI+dMZN?=
 =?us-ascii?Q?LOpyhkIJCBdajBLd0ZJN7y5qAQudOEt5B9D+xGoIq2Cs2ayFAB21xKPvW/zh?=
 =?us-ascii?Q?Y3efR4pwVCqU47MJj4Yr62gYwcl9NyCQag/oxynhsV8vStiQOEOWHiTFnqBn?=
 =?us-ascii?Q?Os1rilsvC8dVIQNgi+v3ESsHEZgEwDPc1Ie/Fn5jgU0tVqO1dSrGr39f7Hq6?=
 =?us-ascii?Q?22hq3humY8tC8QSv3Ezhowmdwzns3M36niURhrfqIt4bmCDlp0Pm/4mmMUe3?=
 =?us-ascii?Q?O4SBNRtUrVl9Ix4NGz6Nf0pT4vjyLl/PU6wOpERRH6Rze+XnY3Hy0f/PFPKB?=
 =?us-ascii?Q?C4cRwvk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3937.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HVmowmaoFwnVRnI1uSl83NgQ/hMGbJd28iTw+7NnePULKEg/SdELCDmyAFfp?=
 =?us-ascii?Q?OOYNl/5rXsW8BIa7WsLLejemJLnicvJlHRkrZedu6xy1fGWzQFe6VOuhoQzy?=
 =?us-ascii?Q?WQgcNdOiwjKk7yWAI/+cP1f/Qe7W5cb5WiHj1OkYFObxOIgdXvqqG/7q9D0z?=
 =?us-ascii?Q?HyBExKf3c3tO+7VkYU0dH2vrAwYj8Zp0X3dQ3RyYiP629MvYW9ppmNN+q2Mv?=
 =?us-ascii?Q?2aR8TgZYbLT2V6eVCUHSwOOGpNa+qyf6YNhwAMycXzaYt9k1D4b9/z2fu3z+?=
 =?us-ascii?Q?4rZRiWUdIiFAAPiTnlKJWXgJgQrTZlzv/JuguTOoZIeEEIsYKCUUEfE4BS2i?=
 =?us-ascii?Q?Uo/OignM7xzUuK7M0nX9MxsWx9K2hs7V2v0jomd8fkJk/uuHKZnABbLEUidc?=
 =?us-ascii?Q?y5BfU+0mHVQB1Byx1Mj3uSBE4pSkCXCjAokBVsqy230zAXRIB+sgQKfZYd+9?=
 =?us-ascii?Q?cBpz9QhUW1BpcFF5O4a6Pqx4Gxu2BpW/YEdSxoLeTe6Xx3LwfrAXMRsEFyTQ?=
 =?us-ascii?Q?Kc2qv3HAIPK789OlNAqcnM55moOTBuH+XBTr6BVaHkOHAKQaMfDmt3Z/VQAY?=
 =?us-ascii?Q?+KGiKiIuRykgiM2B3e/J3hZ8QbpB8O13CNnTrXFb1JVW458javX36GW5yA35?=
 =?us-ascii?Q?Dc3FjTdN7L83J7+xic6Ns11exA59q7pAQb6HsaU6zRs78POk1h5rf1DUtjMa?=
 =?us-ascii?Q?DGOzQtykKzBFyltTyjseb3bypE5h8cekDn8uu5qNjgiTZYjjDGR5niKt9Wr4?=
 =?us-ascii?Q?r6jz8/hRTq4s2LXuXb4jP/fsZq5OQg8IvRzbCPyropM5Uw6/97DbgUNKd3yt?=
 =?us-ascii?Q?Scx2T4ZETag4Rda3PPcgpTH+qXpV0Nt87Gdt9TS+Tl1aKNQ0xGOd6v+ISTM2?=
 =?us-ascii?Q?7n++JpmI6gVcrX6uP6VC8VdPNC6FvHfBWJIMNTklCWo+kzZImbayhRy53IjP?=
 =?us-ascii?Q?2J3BJPKpe0WkEODEHr/EHuKEDRkRbNqYzVM4IUTFgHzrO/XxA5PUVPcLBdTW?=
 =?us-ascii?Q?3crBEqkczb/zRW0Jocss3AOoSPqdhDCh23l299UQpi2ZI13s1iXNSgJQjAgE?=
 =?us-ascii?Q?fuDYfjM4Cr4puLEiBuZRsv6QRDUjL2T2R88VhpSXkxBmxEwnsoBeyC4baKSH?=
 =?us-ascii?Q?CDUhcrlD4tdgloyhh4k3AoUZfXP3nuOcoAP6YvfRVQxocsIyp64ogxL8hKNO?=
 =?us-ascii?Q?UNex8hX0icyD7a7+AHUk2B8HPjng1jmL8StCivnV57ChQG9lrkVL9lFJiZz7?=
 =?us-ascii?Q?fgnMJ2cLvd41mlPoxtygTwvU+n7aDMinlIogPpiKwlhurcpWV7HEFgKe0rpM?=
 =?us-ascii?Q?V5Anc+C+QK07sI+vF/Z+CfUaBBbMRvUM+SDmW1aAQ+FdoYFPEbSU1ujXJ1iP?=
 =?us-ascii?Q?U1FAzylcJGMsi9YOpO5hx069LLAUPRpb2FAx6IZS3WTlCom3nEp2AWSJuG8O?=
 =?us-ascii?Q?510IVO8qvAzwPxXa4qBtrpNyHHKsp/9cyDb1+VsIun7aRdOWWdSiZwUKQ334?=
 =?us-ascii?Q?q+M+lLOu948FUHZBm0/Pmou042xhOz6qO7/kF9Mll0yYzPD/MC7oBfrrXChH?=
 =?us-ascii?Q?erGBMEJCUhtPabObMfiCokPcVIKyYZZK16GM2Jnf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb75e697-3a8e-400a-f2d4-08dcef26214b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3937.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 03:37:03.2554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yi3ZPVnzBBW/EzvxaLeoWb3Lo6ggw6i+KiG4k5uKq+KUoIaJD1UwFaOoCVEJ12niy2hgBRx0lh/Wq02pzvvuUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8110

From: Carlos Song <carlos.song@nxp.com>

Add i.MX93 LPSPI alias for kernel LPSPI driver usage.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 04b9b3d31f4f..688488de8cd2 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -42,6 +42,14 @@ aliases {
 		serial5 = &lpuart6;
 		serial6 = &lpuart7;
 		serial7 = &lpuart8;
+		spi0 = &lpspi1;
+		spi1 = &lpspi2;
+		spi2 = &lpspi3;
+		spi3 = &lpspi4;
+		spi4 = &lpspi5;
+		spi5 = &lpspi6;
+		spi6 = &lpspi7;
+		spi7 = &lpspi8;
 	};
 
 	cpus {
-- 
2.34.1


