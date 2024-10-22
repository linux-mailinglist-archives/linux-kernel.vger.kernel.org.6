Return-Path: <linux-kernel+bounces-375617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279D99A983B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75D92832CD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481AD13A899;
	Tue, 22 Oct 2024 05:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="idG+EMAc"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC88D136E0E;
	Tue, 22 Oct 2024 05:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574372; cv=fail; b=usMCDvZ/tjAdJ/9lgPsSzgyg9JMW1MIBu3pnpfZsz9zsaBAaweqvunTC6qNbuY7jA4a6gOH7oQKALogxUEsX6PCc0tr9H6krzzHVLoRHQfXOz+JVQ82e9m4dNJrRA1Y296cLJ7SvdrH5yR0xEFmFSRe1q8KpeLm3C3YYRScqbDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574372; c=relaxed/simple;
	bh=RmklbivmIr0BZeOaKwmYt0Ff58fDqWYCiiGGgTrtDhQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NBA0nMVO2DPpsr6rHaOkO9cHxTin1kLJRCXVV389K4g9cYmN/GcpB1+xNuKGepT/FwRmLm7P/sOsybPHEpw6IIDtEoXBA8L57ciuV9eWx/8g5zjmAYvuMv5UhfwGAT+Kwyuj/UvlwWh6VsTJstQhLjHtIcw5fbjhGdEPrvehHRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=idG+EMAc; arc=fail smtp.client-ip=40.107.105.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOBAX+7m8OcdureO2KsM5TRI7JAkHt7xfbX1d+TqOi989mVpdHgFIqEAykly5/71HjnPDzGYO+4zUBXlgyUADH+XG5BbKxXzIH2RV95O6xQneWuZU1DIgmOzQMoFv7Ln4FAGsoACj8DPMaMUVPMDSvWtDIS4AvpuBHwOzQA0v83DcB4ONes35xq5rzsAKWBhYfcwsZ7qDhvJwrbX93nPU4nZnEbiSPjLsOwKaxDY4qSVAxP0M40jeTtYfYBtDapjcPaoyGjVFUAmJNnezJ+4Mzieh/UVnny+BcaynzsV2mj4mm4etGzyXm7nHrywoYSk8ZGaurzzs8nbf6+oabfFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbgQu24D7lvzf1f3qcg3Z8PnbQ8cse6VxT19v5T00uU=;
 b=Pwpb8tgi3wkLyCYHHidl0jNbi2MGhdE/IfpvZIW1EX7yA4ePMwNwesZxmqMxNIVFemhgOukRLnz9N0m8jiyWHIrbMnJlQIePg2INThig18RLnywm9JXoAc4TERGQ4pB6jUmVdBg3fdrlbIKZUo7pzFBlhs8tcNxcHXRB7G6CTs8Rodjwi2JLdn426/vD9uWcNZfq0B5hTd2kGyaxTBqjrVddtlVpVTZCGrnLV1jwp+SGNZvKVnujO/qVrsHqh58E12ZnVdCblQz4oJkqBVxnVU8mcFCvhK18gb9B9f782Gfq4wIAnFH2CVX9Hw8Qh6510Hpcp46JDsrxQLLiqq7QhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbgQu24D7lvzf1f3qcg3Z8PnbQ8cse6VxT19v5T00uU=;
 b=idG+EMAcS2A3gdnTQWRb34zfcS2pniO/quFCQMKe+FnAnRDTej1rG9RYym2AAG1E/vrY1InmMsnKQfKKybgHiA6I0aA8KKjy5wotnW0SSJjyGe0wJOe0KA2ZXlAw6r0clKgJl752w0a01y8gu4gTVtKqUZ7lQBsiTlvsl3Yxhu48i7p8CsLkqVV35n1VYzgP5RTtj1rb3H1ZPxeN+aY0p/X+sWBH/KGMqwVf8Gde5OjRE02op04efSmEnHfMfXNrU3TSZGwJ9FLCMFrlOflE5n0k1SkbL4L5/V+KIs5EI+wcuqOkQj4zOp1jtCXHvsYLpXvYtUMTZSRteCeRSlxQnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AM7PR04MB6853.eurprd04.prod.outlook.com (2603:10a6:20b:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 22 Oct
 2024 05:19:27 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 05:19:27 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: [PATCH v2 1/3] arm64: dts: imx8ulp: Add audio device nodes
Date: Tue, 22 Oct 2024 13:29:17 +0800
Message-Id: <20241022052919.1946074-2-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241022052919.1946074-1-shengjiu.wang@nxp.com>
References: <20241022052919.1946074-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To VI1PR04MB7055.eurprd04.prod.outlook.com
 (2603:10a6:800:123::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AM7PR04MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 58652052-fa54-42f2-bf63-08dcf25918fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LZ/MV4tOsR2PIgmEc+DT+APVjtVGI6MjF/shjyBgn/ofxL3OP1FYl+o2B+HN?=
 =?us-ascii?Q?VVUBcReFulANy8gCoku4Rk364fDiUYS7vCRl6JI7RktKzVfl1HkFDHeC3/PO?=
 =?us-ascii?Q?kabJAQOlgm+izpu5F/z2HzqDD4CeNS8AKdHuEL/rqvspyo+ZeoMtVvpSl8CE?=
 =?us-ascii?Q?WqfKDnc9BB2le9Ta4qkNM1NmmnbHQU8Vc87XWtpVy8uK9hbG1D40dUoCHPab?=
 =?us-ascii?Q?2TUjktpHLpQtsTeqAkxIaLTQwPdY65M5gVdHmP+Wqgyv8pOMnwPYDjDQRDG4?=
 =?us-ascii?Q?KFCmAwALpZSouqDsP4PYXi2iS5ZMQZywJkz6IxpY51XleCBjxlyc+rvcwdDO?=
 =?us-ascii?Q?JsDJSDBlMgUx8lYEeucZVG7jsurD59zl00Qm8RtkM9gf0jbFlt148ua0uMn6?=
 =?us-ascii?Q?9VGmJTGhs3kPEnnVizUR2vLk7Hf+eJ5vxhmPGx5xGlzCoN8TCz13zdZkpbde?=
 =?us-ascii?Q?lPTjVw62c9tVrDHdc920PzfFOybCWbIbO78DQZ4N2QaU9QNyzvVP77wttrv2?=
 =?us-ascii?Q?AbuuYx5wrL8I6hbfsvT+Ti4fKCfF2iCLgGAsXRBJYVCgOPTxZcOQRVcE9LMP?=
 =?us-ascii?Q?XMOi/hR0rPruLWv9+lXzUkj8bxqkYpFim6OmxhBN8/f7MLa2+mpJVa7bC2at?=
 =?us-ascii?Q?jsAfzw8jkuuMbV7+nmDBWrH4JbQMMYNHSKItvx75wNEC5aRb/ffohBklsvcT?=
 =?us-ascii?Q?SdBWLe3xIn5xg7VRCCyCaF+f+ZUQsuLbVfHTySyq3jrJ/tWpPTuHL31PFy0n?=
 =?us-ascii?Q?WPkPMfc+9qWseb+KBYH3bwyWmqq7rF9IV6DtsHyhD03Mc6kPwiCiJ0Pi+sY8?=
 =?us-ascii?Q?dN4FilVQwzh/9XeoK0Uly1yMBYGWotVsOS8A6Bc78E3gPSJsJO5f+8rDMj6Y?=
 =?us-ascii?Q?r/ykuoxFgD+XinfK9u4UQYlh9AloQcXKvQzpg29Sr7+vjx90ykE9vYSPLa/J?=
 =?us-ascii?Q?gnKM0xRm6grk414iKVHss1EeEXppuo/ydXGcksMTsUYo84kb2U6/11ZIlTjw?=
 =?us-ascii?Q?uKhxAxRs+wmiDDZCGCd5vFHl0u94bEXfce+BuLg2YzmZZQScgbV9s65Pu95A?=
 =?us-ascii?Q?NvjwmcwpnRmlLDZxiT8Qf3rdch9+JQRhsC8MCqWPUgLWhBmJmTqwoiOUk0CB?=
 =?us-ascii?Q?r2hWwfJh8eHp+NbIOc06trHB3r7rMXAzXm1A4Y8Jt2l7bG7Y1fOfwRpJTuAM?=
 =?us-ascii?Q?nuE134YwxVvi5VGyWXxogaQbPzsHEtWbE8n66NtYlugqHtWaoCBWsAuAOSLD?=
 =?us-ascii?Q?GjQBwjcXd5d26Rn3RAOKzf/ud2P3BzKrR8mJxXSWXSnAwfeWv0mD+z9TNC6D?=
 =?us-ascii?Q?47Fy+qc5wysYvGXJGmlTpNAxPSrUagtHHIWlodtBKLI3BoqSnUAeIHr0vkjr?=
 =?us-ascii?Q?rLOsThwTbvFf7h2W0hDuNvZhycGu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BScOQk2JzPDulCZFsi5MxB2KkMWwPdVxVGulHMtbfTz09MAjkyE6c6NehoQ6?=
 =?us-ascii?Q?xKvWtosWkU+LSuSLYoM7x9D9Mou1FhY/lhiFffmxM0w0/Yr9wuVVnv73msaW?=
 =?us-ascii?Q?UFyO0x2oqD3vHghHd3YsmJJDFE5YEehyOo2BH7bx5Ggb6Q4FvRwA9olaYmLe?=
 =?us-ascii?Q?5PnjSBefghcwoenFbHeUDVcf0U6Up9mnxWBJi2bznPM6MEPlu6XYiMCp6WTF?=
 =?us-ascii?Q?cXbzvo0znglerXrHQy5pp1gOc/ZdPQ/O8mVnLwCRYTZTA1fjU7phoIgP9YeC?=
 =?us-ascii?Q?27H+dgdp1F5rb9NFfVNJctK/jduZuJLShsn0j4/s+mXrO3DNj/UWY9hgpeUp?=
 =?us-ascii?Q?dml8OKMHhq8g1JJeI0c9LLFYwdahMTpqqCe9dMh2D279in5cOF2jizMz/1op?=
 =?us-ascii?Q?dYkirS2wlDi2TeUx4xxyG0qMEPnYHCMgSpHHkuMsaoFqud0sBKS9Plwk7tTV?=
 =?us-ascii?Q?4SInvvk/7LPM6wZ1IMAIvJDGdh9QoXxQZp9bI7hiAfm2kX7W31FrIvXSdN33?=
 =?us-ascii?Q?OkZu8S0oO/+16k5J+pV9nOczWvU2g95Vf81OrUPQrhzm3JE7lPMReoQXTrSw?=
 =?us-ascii?Q?+Sdk8w4Vj3YUGfwmiTcunfOTGmDBIUbGN7CLkBawjluDaUfzkcy/5px9QNJy?=
 =?us-ascii?Q?aNIeih9fFVRu/jWs9XSh0S65C59PcQwOYJj3NHvmcikMmaxqCv7i4T0PMrN3?=
 =?us-ascii?Q?c+CN0J0rfaMcvOVYIpHbLn+6DCsQzzRPqEYfvA2Q47PxBjMH2uxryRd9rwj2?=
 =?us-ascii?Q?5QkxhK9EkLkH2TxUkylJ2r3m1uLCi8nJClQlCFIJnRZM+vxEDt10NWh47VEJ?=
 =?us-ascii?Q?ljynVYH9sPsZTJS55ozO6ATKg39pA4TPm2G2F7Pf19BsTCCDygvCvz5NtZAB?=
 =?us-ascii?Q?VhB+WLkp4T1k6zq20Gz/2be+UmjoZR0rdkB3Tu+na+wcRk5jXK7VTGKvkuKo?=
 =?us-ascii?Q?gKWE7wtFQMlqcxBqFZwg7VU438ots8WzlDrCRoMgUtLu5DmSaGOWcixp/Ffu?=
 =?us-ascii?Q?GAX1PxBlDXBBODUG8k4bK9RqIIPSQ7eTXjotvnnS+Hc39nZFqvzMuML+wBKv?=
 =?us-ascii?Q?nSpQgoiOBfUHTKVhpS0GRzaQyT/JXRD41YOZofvVzxl0oN2sPPnotmSmGzs0?=
 =?us-ascii?Q?Im0Zgsr9m5FdwY2nHI9q00ukRnrZUDXWDJ7uBUWszIyVukyvgKTUcKxjX/bx?=
 =?us-ascii?Q?Gxxn2RXR6wNFo0h4FtqnQVvxjAk4hWcWrFZxUkeWWd+c5QlTmhAKlC4M69Yy?=
 =?us-ascii?Q?3uXIgrvAAFYhT0sPvdE1AnmJXGfEuylHSxIGq1ENfVRhLkMEyI0Td6twRAmI?=
 =?us-ascii?Q?L7ht7nkaLcfQiTA3YVPeBP/iUJMdVrDGIGcrUox+fN6lc21b6F9NBmZOSlpd?=
 =?us-ascii?Q?doPkW384rRK77fnXVNiqrDyivWozebECvtl3UPxBm9v2ABR1S1S3fYk38oI2?=
 =?us-ascii?Q?R9So2n0ZQ3AJgCM0HFRsSSA0eQ8wVC4XFJZkHNl3sqZ4uvzkyPZ10dv/n5/D?=
 =?us-ascii?Q?mb3EI6J1Dsro+PRm3UyRtyow0WTgCLiGQINclv/HCsWQIhEisDCiaCxS/DXs?=
 =?us-ascii?Q?/hUKdijrVipIu7nyFcFEz32ZMAopBgr68jK6VYGL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58652052-fa54-42f2-bf63-08dcf25918fd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7055.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 05:19:27.1755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxVh6+lsY0MclyXaQDNiISWjajE3AeEq5BUVyp7Ev8+oFLD6x/Ry63ZYBdX4c1oUSMgceKOmEmtpXl+zpO5Nfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6853

Add edma1, sai4, sai5 device nodes bus of in per_bridge3.
Add edma2, sai6, sai7, spdif device nodes in bus of
per_bridge5.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 212 +++++++++++++++++++++
 1 file changed, 212 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index e32d5afcf4a9..9930bc1cd5ff 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -212,6 +212,70 @@ per_bridge3: bus@29000000 {
 			#size-cells = <1>;
 			ranges;
 
+			edma1: dma-controller@29010000 {
+				compatible = "fsl,imx8ulp-edma";
+				reg = <0x29010000 0x210000>;
+				#dma-cells = <3>;
+				dma-channels = <32>;
+				interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc3 IMX8ULP_CLK_DMA1_MP>,
+					<&pcc3 IMX8ULP_CLK_DMA1_CH0>, <&pcc3 IMX8ULP_CLK_DMA1_CH1>,
+					<&pcc3 IMX8ULP_CLK_DMA1_CH2>, <&pcc3 IMX8ULP_CLK_DMA1_CH3>,
+					<&pcc3 IMX8ULP_CLK_DMA1_CH4>, <&pcc3 IMX8ULP_CLK_DMA1_CH5>,
+					<&pcc3 IMX8ULP_CLK_DMA1_CH6>, <&pcc3 IMX8ULP_CLK_DMA1_CH7>,
+					<&pcc3 IMX8ULP_CLK_DMA1_CH8>, <&pcc3 IMX8ULP_CLK_DMA1_CH9>,
+					<&pcc3 IMX8ULP_CLK_DMA1_CH10>, <&pcc3 IMX8ULP_CLK_DMA1_CH11>,
+					<&pcc3 IMX8ULP_CLK_DMA1_CH12>, <&pcc3 IMX8ULP_CLK_DMA1_CH13>,
+					<&pcc3 IMX8ULP_CLK_DMA1_CH14>, <&pcc3 IMX8ULP_CLK_DMA1_CH15>,
+					<&pcc3 IMX8ULP_CLK_DMA1_CH16>, <&pcc3 IMX8ULP_CLK_DMA1_CH17>,
+					<&pcc3 IMX8ULP_CLK_DMA1_CH18>, <&pcc3 IMX8ULP_CLK_DMA1_CH19>,
+					<&pcc3 IMX8ULP_CLK_DMA1_CH20>, <&pcc3 IMX8ULP_CLK_DMA1_CH21>,
+					<&pcc3 IMX8ULP_CLK_DMA1_CH22>, <&pcc3 IMX8ULP_CLK_DMA1_CH23>,
+					<&pcc3 IMX8ULP_CLK_DMA1_CH24>, <&pcc3 IMX8ULP_CLK_DMA1_CH25>,
+					<&pcc3 IMX8ULP_CLK_DMA1_CH26>, <&pcc3 IMX8ULP_CLK_DMA1_CH27>,
+					<&pcc3 IMX8ULP_CLK_DMA1_CH28>, <&pcc3 IMX8ULP_CLK_DMA1_CH29>,
+					<&pcc3 IMX8ULP_CLK_DMA1_CH30>, <&pcc3 IMX8ULP_CLK_DMA1_CH31>;
+				clock-names = "dma", "ch00","ch01", "ch02", "ch03",
+						"ch04", "ch05", "ch06", "ch07",
+						"ch08", "ch09", "ch10", "ch11",
+						"ch12", "ch13", "ch14", "ch15",
+						"ch16", "ch17", "ch18", "ch19",
+						"ch20", "ch21", "ch22", "ch23",
+						"ch24", "ch25", "ch26", "ch27",
+						"ch28", "ch29", "ch30", "ch31";
+			};
+
 			mu: mailbox@29220000 {
 				compatible = "fsl,imx8ulp-mu";
 				reg = <0x29220000 0x10000>;
@@ -442,6 +506,36 @@ lpuart7: serial@29870000 {
 				status = "disabled";
 			};
 
+			sai4: sai@29880000 {
+				compatible = "fsl,imx8ulp-sai";
+				reg = <0x29880000 0x10000>;
+				interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_SAI4>, <&cgc1 IMX8ULP_CLK_DUMMY>,
+					 <&cgc1 IMX8ULP_CLK_SAI4_SEL>, <&cgc1 IMX8ULP_CLK_DUMMY>,
+					 <&cgc1 IMX8ULP_CLK_DUMMY>;
+				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+				dmas = <&edma1 67 0 1>, <&edma1 68 0 0>;
+				dma-names = "rx", "tx";
+				#sound-dai-cells = <0>;
+				fsl,dataline = <0 0x03 0x03>;
+				status = "disabled";
+			};
+
+			sai5: sai@29890000 {
+				compatible = "fsl,imx8ulp-sai";
+				reg = <0x29890000 0x10000>;
+				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_SAI5>, <&cgc1 IMX8ULP_CLK_DUMMY>,
+					 <&cgc1 IMX8ULP_CLK_SAI5_SEL>, <&cgc1 IMX8ULP_CLK_DUMMY>,
+					 <&cgc1 IMX8ULP_CLK_DUMMY>;
+				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+				dmas = <&edma1 69 0 1>, <&edma1 70 0 0>;
+				dma-names = "rx", "tx";
+				#sound-dai-cells = <0>;
+				fsl,dataline = <0 0x0f 0x0f>;
+				status = "disabled";
+			};
+
 			iomuxc1: pinctrl@298c0000 {
 				compatible = "fsl,imx8ulp-iomuxc1";
 				reg = <0x298c0000 0x10000>;
@@ -614,6 +708,70 @@ per_bridge5: bus@2d800000 {
 			#size-cells = <1>;
 			ranges;
 
+			edma2: dma-controller@2d800000 {
+				compatible = "fsl,imx8ulp-edma";
+				reg = <0x2d800000 0x210000>;
+				#dma-cells = <3>;
+				dma-channels = <32>;
+				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc5 IMX8ULP_CLK_DMA2_MP>,
+					<&pcc5 IMX8ULP_CLK_DMA2_CH0>, <&pcc5 IMX8ULP_CLK_DMA2_CH1>,
+					<&pcc5 IMX8ULP_CLK_DMA2_CH2>, <&pcc5 IMX8ULP_CLK_DMA2_CH3>,
+					<&pcc5 IMX8ULP_CLK_DMA2_CH4>, <&pcc5 IMX8ULP_CLK_DMA2_CH5>,
+					<&pcc5 IMX8ULP_CLK_DMA2_CH6>, <&pcc5 IMX8ULP_CLK_DMA2_CH7>,
+					<&pcc5 IMX8ULP_CLK_DMA2_CH8>, <&pcc5 IMX8ULP_CLK_DMA2_CH9>,
+					<&pcc5 IMX8ULP_CLK_DMA2_CH10>, <&pcc5 IMX8ULP_CLK_DMA2_CH11>,
+					<&pcc5 IMX8ULP_CLK_DMA2_CH12>, <&pcc5 IMX8ULP_CLK_DMA2_CH13>,
+					<&pcc5 IMX8ULP_CLK_DMA2_CH14>, <&pcc5 IMX8ULP_CLK_DMA2_CH15>,
+					<&pcc5 IMX8ULP_CLK_DMA2_CH16>, <&pcc5 IMX8ULP_CLK_DMA2_CH17>,
+					<&pcc5 IMX8ULP_CLK_DMA2_CH18>, <&pcc5 IMX8ULP_CLK_DMA2_CH19>,
+					<&pcc5 IMX8ULP_CLK_DMA2_CH20>, <&pcc5 IMX8ULP_CLK_DMA2_CH21>,
+					<&pcc5 IMX8ULP_CLK_DMA2_CH22>, <&pcc5 IMX8ULP_CLK_DMA2_CH23>,
+					<&pcc5 IMX8ULP_CLK_DMA2_CH24>, <&pcc5 IMX8ULP_CLK_DMA2_CH25>,
+					<&pcc5 IMX8ULP_CLK_DMA2_CH26>, <&pcc5 IMX8ULP_CLK_DMA2_CH27>,
+					<&pcc5 IMX8ULP_CLK_DMA2_CH28>, <&pcc5 IMX8ULP_CLK_DMA2_CH29>,
+					<&pcc5 IMX8ULP_CLK_DMA2_CH30>, <&pcc5 IMX8ULP_CLK_DMA2_CH31>;
+				clock-names = "dma", "ch00","ch01", "ch02", "ch03",
+						"ch04", "ch05", "ch06", "ch07",
+						"ch08", "ch09", "ch10", "ch11",
+						"ch12", "ch13", "ch14", "ch15",
+						"ch16", "ch17", "ch18", "ch19",
+						"ch20", "ch21", "ch22", "ch23",
+						"ch24", "ch25", "ch26", "ch27",
+						"ch28", "ch29", "ch30", "ch31";
+			};
+
 			cgc2: clock-controller@2da60000 {
 				compatible = "fsl,imx8ulp-cgc2";
 				reg = <0x2da60000 0x10000>;
@@ -626,6 +784,60 @@ pcc5: clock-controller@2da70000 {
 				#clock-cells = <1>;
 				#reset-cells = <1>;
 			};
+
+			sai6: sai@2da90000 {
+				compatible = "fsl,imx8ulp-sai";
+				reg = <0x2da90000 0x10000>;
+				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc5 IMX8ULP_CLK_SAI6>, <&cgc1 IMX8ULP_CLK_DUMMY>,
+					 <&cgc2 IMX8ULP_CLK_SAI6_SEL>, <&cgc1 IMX8ULP_CLK_DUMMY>,
+					 <&cgc1 IMX8ULP_CLK_DUMMY>;
+				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+				dmas = <&edma2 71 0 1>, <&edma2 72 0 0>;
+				dma-names = "rx", "tx";
+				#sound-dai-cells = <0>;
+				fsl,dataline = <0 0x0f 0x0f>;
+				status = "disabled";
+			};
+
+			sai7: sai@2daa0000 {
+				compatible = "fsl,imx8ulp-sai";
+				reg = <0x2daa0000 0x10000>;
+				interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc5 IMX8ULP_CLK_SAI7>, <&cgc1 IMX8ULP_CLK_DUMMY>,
+					 <&cgc2 IMX8ULP_CLK_SAI7_SEL>, <&cgc1 IMX8ULP_CLK_DUMMY>,
+					 <&cgc1 IMX8ULP_CLK_DUMMY>;
+				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+				dmas = <&edma2 73 0 1>, <&edma2 74 0 0>;
+				dma-names = "rx", "tx";
+				#sound-dai-cells = <0>;
+				fsl,dataline = <0 0x0f 0x0f>;
+				status = "disabled";
+			};
+
+			spdif: spdif@2dab0000 {
+				compatible = "fsl,imx8ulp-spdif";
+				reg = <0x2dab0000 0x10000>;
+				interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc5 IMX8ULP_CLK_SPDIF>, /* core */
+					 <&sosc>, /* 0, extal */
+					 <&cgc2 IMX8ULP_CLK_SPDIF_SEL>, /* 1, tx */
+					 <&cgc1 IMX8ULP_CLK_DUMMY>, /* 2, tx1 */
+					 <&cgc1 IMX8ULP_CLK_DUMMY>, /* 3, tx2 */
+					 <&cgc1 IMX8ULP_CLK_DUMMY>, /* 4, tx3 */
+					 <&pcc5 IMX8ULP_CLK_SPDIF>, /* 5, sys */
+					 <&cgc1 IMX8ULP_CLK_DUMMY>, /* 6, tx4 */
+					 <&cgc1 IMX8ULP_CLK_DUMMY>, /* 7, tx5 */
+					 <&cgc1 IMX8ULP_CLK_DUMMY>; /* spba */
+				clock-names = "core", "rxtx0",
+					      "rxtx1", "rxtx2",
+					      "rxtx3", "rxtx4",
+					      "rxtx5", "rxtx6",
+					      "rxtx7", "spba";
+				dmas = <&edma2 75 0 5>, <&edma2 76 0 4>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
 		};
 
 		gpiod: gpio@2e200000 {
-- 
2.34.1


