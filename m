Return-Path: <linux-kernel+bounces-279756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC19794C175
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B197283106
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDE318F2CF;
	Thu,  8 Aug 2024 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FE71RYLp"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE8C18E044;
	Thu,  8 Aug 2024 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131102; cv=fail; b=i/wvkXk7rsK3YYxw9xvKJgqjEw1YaLFu+mn+DAE+FU5dkqnhjcZlkkOrsXfltZVygfPtSqje/9LC2ie90Wt8bvut9GKcOZ+3XoE6DMJx3lY3Xk4pPdnsDLkjyPigPUeClq5BR6MHNxlXZRC29hXndfSMtOJqe8golyR8KtUrbwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131102; c=relaxed/simple;
	bh=s8J2btbslI5XGoEbBuQg8cYHtFQU6bWpwaTIAtD5FzU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FUMObj4uTIwNPLFSigEZKKEO+Poo+VEkZQhbnZ+gF+vzs/0MpC9fTQsP9dxzDm3Pg2/dhHZr4HXBr/53PuycrZLmW+EW8cRD2p3sHKx4unHE3E5aAsKmbnpyVOh0ntaJQLJtIhxjk8+NYCUncTp2M23zgIrenR5w3uPBpNcrYHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FE71RYLp; arc=fail smtp.client-ip=40.107.105.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGKd9smDPRYpSV0inkMqi3S2GhXbzhgKIsq8gyWYL/czFwXbRC09kn7r0VKqawrDm7rcbSLq+x4i9zgkrGQQkucfqbSmutlpuZ7EMFsg4Are/svkn3SzJdr4sUxXSN+jaFmItkTLPdA55lbAD9lwdHbLwYe2mrkmn86UdnIupCLFV78yf3eXQRE/Yl2oiBIcpY2hUGbJcYfGwRCgXRLVy2zlaJweTnbtV/n57FysFc58TcClkHFe9XbSTfwukkuy0FzPhCABeLUIDDvYqFowexfPWK0dTg9Hib75A1Z1VvIl3DWivF464VR++v45EGMEM5VB7VXmgb58S5KNR+euEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Foa+kfsftQT37KSlGTWfMEE7K0Mp+Y0RZ1DSEfuqnQ=;
 b=sHC9SOA6VKsc35aHwSEK2VZteEitORe25lWqKvLfOX8iqH7xwS4bYM3NC4IkJBggUcLHe0yQmxukbuUqoZkXowGK5A5mNQIDRQWWB80NzekokK6zX97NsfxRG9L6p72HW222GbDxgUHrVdhAW1E94SY0VO4aHjXg0JISlBLSVv0X9UGf8xoJN7z5l2LXDva7jcT9AP6TO6stRIjhHqNpbgMmAyzjmTqOKBWE3G9oiHFWEeGacTM0CT7UW1me8b9SnkmwwsWenCpWEWJJVzi/jR/o5W3+ZcSO31rcpish2oYRxZWGgfynJ1cWOehEXQ3Vxvs+2pfDRoXBGeEOh5mKog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Foa+kfsftQT37KSlGTWfMEE7K0Mp+Y0RZ1DSEfuqnQ=;
 b=FE71RYLpfeGqELqfvEsV5rvzqo0d9WcE97IKh4nsJD7pry6ip3uXUSKbh4ClVmqigDQX5HNv69k+QJQaHm5gHFWt0SvmhCKKMUaL5uE8+wD/pj6uLNGfm+G0l3+/AZNQ9tIjw+0fC5EGOfhPwFncOQsg8l5ukgIwNAbVjZ3PCVxDyZ46hnC4F2LwHUXLoZHRWgMuYQj1v+Gv0dCrbrf5sk67Hsw2B5A6j9PotuCwiE+UcOBCVJbsq6v0Fgg+sJQJcCaJvYQ/okkXF2RRx5DSwm5GxxAQOlCWj1o7G/ijHw37igaytsNSJw7M2zXfreOx3t7n4i4KFYESobQ+NEE3+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB10019.eurprd04.prod.outlook.com (2603:10a6:20b:67f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 15:31:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 15:31:35 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] arm64: dts: lx2160a: Change PCIe compatible string to fsl,ls2088a-pcie
Date: Thu,  8 Aug 2024 11:31:20 -0400
Message-Id: <20240808153120.3305203-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:217::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB10019:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dba2dd1-f968-41b1-2d0e-08dcb7bf3057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8OF0NCJJZlH2fxzZ5U9QL6+omv4hO6TYKjAeixCCgdL9wym4ePqOgWGLic2I?=
 =?us-ascii?Q?HjfOuaO6C37tHsmN3+aEWifgmLi12celYCuOHqwlZbM4bqEjx/1Pp+0Trb15?=
 =?us-ascii?Q?WESE3Xlpmuf9gyKQHOXRoZ9JRaiU1sRTjN5LXaSGZyNtKsq0uaVs5uYSNmyh?=
 =?us-ascii?Q?30en6hfmVn77q7bHQ4U5wjepCVegBJm9iPlCV5+SPUOESoaI7mtiPNMjjpLI?=
 =?us-ascii?Q?+b0GxrwpaFS02pLp2DoPMZokrjS0ERIHOobi8IQKdbazIGNM/GKZ6rZA0DIZ?=
 =?us-ascii?Q?cl3uoWcierGQ2psguew0vZqLuGzp/YgX2STPEmosdTuA6eLYa39OVXOuzb4D?=
 =?us-ascii?Q?B7ZPyIVhKs803KpVqBjQjGHbRVoWUgNLy8eCkZJ2NA24tp4Qh44kdYga3c/1?=
 =?us-ascii?Q?5oUYPoBnYaC9A6EIrktQ7JX7wZSPY5wqvR44Us7/sZJxXvTFdr7fQ9SwWFre?=
 =?us-ascii?Q?0BBeqvbqkcTDoehxj64VkN56Gy0OeQEvxTFsd+XB601CV/5vJIEDUESVezk1?=
 =?us-ascii?Q?2WJeQ519REWH0p2EB0S4/8ADFadX0e/gQBPMYQ1FhTFUWxIWD34zSKijRo2z?=
 =?us-ascii?Q?WEffcnHQm8yv29Iv9G/MxyEgCqotnp1ujezfiYPjz0qPDHeMLV2xlzqmwiS8?=
 =?us-ascii?Q?10bx5BR/A1jiiXipBrbal3TXTSCiFtHyFkJWbVuaXjc0p9AQPNyPF1W/5G03?=
 =?us-ascii?Q?wqMp5SMYuSsbXf1sQukUNWrPy6o0mIlaR1758c8jkTJST4VtpLr5bI9exeWj?=
 =?us-ascii?Q?+jEBgUPWNrc4qP5FakkAN/IK7jBQhTpNBGyBvUDGJlqzaaXD8XbnsVk47hEF?=
 =?us-ascii?Q?Z+MjecfGZIAjk8I+oYQt2IX6Hc805V7SLQK+9atCSQGF7+pASUq27ZzK55BJ?=
 =?us-ascii?Q?78/zonbIPTNCgp1bjyNUufzj4pxna84GLXAdG74vsFVbEXf+3bq5UWPa3ctJ?=
 =?us-ascii?Q?nLL2a1UVz6zwWgxc0kW3hEyI5Z0RHL3JoRlDQDFh4adXTGBFkifjLB/LGwC4?=
 =?us-ascii?Q?SAd00h0NZFjKBR6iIUhHf+npcqola4mVJZfsZv+sTpTkFSE/BDwYXOoyEuwq?=
 =?us-ascii?Q?8K4PEpcAHNuPdxcN3+C/cC8PAkg4uJauG2OtNPuUKOBk65PPY0rgTzCKzHfv?=
 =?us-ascii?Q?3Avq2QoQmcMJ7xEM1DyeiSwaev9ua7TEttMWhOfg3wP/SjlQB8LJ8qVWRUqa?=
 =?us-ascii?Q?6YDVADH45qPEn1JQmEAInQXkwvtBLqL4ekibBJOrwd1BYHcgY0cwbTfmktYN?=
 =?us-ascii?Q?wyp9dr89PtAiBjMhAX+CgET64/CLomcQMgesXnfj/iNPw+QPCLnfe4SFv/Dy?=
 =?us-ascii?Q?qREjXktUaQotJmh8Tr1ffAVYKKZ6ywfn/a5WBxn15BWrXqbytc9YBv/hExJM?=
 =?us-ascii?Q?R2ZhIVn5QIeMGcfepGVu2XU/SvZN1T9Wf21N+TNdMZJzMHHLjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4u6xG/WEC1IjpKfwLbyvIjBDgeGHF+Mn3c073pGyaKlEKj1pBYzOAz5TrKA2?=
 =?us-ascii?Q?oSfN1DxDWHf7HiFc4B6tpKdJ17n6g8xqdvbh7Iml2Ki1lDEZHBdSShskvsnu?=
 =?us-ascii?Q?JuVE5DVY+uwhuaW31Kn0b6aqytTtigYm+2kUnyw13Wwa1WGwpNxxWmT7vLfL?=
 =?us-ascii?Q?jL7cELVm6QD60k7coN7EQ5k/B7ECgHYMjvYT3Qc+x199DqGNqMnCJ5JeJeHE?=
 =?us-ascii?Q?qPUrvA5EwOzEi31RpTlXyDQb3FzF5sFz1+J87BVMvGqYihgPvxW7tClRDWOO?=
 =?us-ascii?Q?g3wbhNmRWXBFlJvBhMFkcLp+2vE1/ICHsgSTZTUQ2D1PN2uUkycnZ6YggFZY?=
 =?us-ascii?Q?sBjbl1usW4dc/it+j465MFzQ1ZWoczAf244mxpvvB4EvRCFqmjse6Bk+qank?=
 =?us-ascii?Q?EPDkcMWAAr8r6gasxtj/qMlIwZru5Cyfp+NZ8HrNkJ0DM71d3LsvxbBr8zWu?=
 =?us-ascii?Q?SHffuIgvYqY45D6nRJdddR1/khSi2LoJu8BC9UE6Dc8Dwvs+H0mXugzWx9fs?=
 =?us-ascii?Q?yqYM+KqFnJ8gzyJoYNVAX92hjgSJlBZDmY7P0bZ+xAauklLsKTBFXK0Mj60s?=
 =?us-ascii?Q?HmnqRFA6JVfjhXwm4ro+KpfKV7JS1HvkW2CIKzQvDG9ps5JDWDwYjh0B/3Z8?=
 =?us-ascii?Q?gl4eMlYXtYosur62eFFQVDcjhmvYINhZX3K5QQPlToMkW7EFdXrwKOU9j079?=
 =?us-ascii?Q?dCzg/qg9hORzxBeF6cl1pN7kMdEVDZNK1ID8Pqy0dR4WplwkrcJ7GlPBWREh?=
 =?us-ascii?Q?LO2kCzPv62mfyACTFDtaPCCTxjqXx8kTnwkQIR8atrI+2v6uzqiWk7+thZmZ?=
 =?us-ascii?Q?uuKZCHnnfbk38+vpQqo/jGAacvGEvAh1uqFD4QnBpM54KRLMsepXceEaeI46?=
 =?us-ascii?Q?Vrntz4vr7rsKejvXoDtUuN6gWcuF4VMSoSeDsEPJFGOrUOw1ijtSgMM9Bskj?=
 =?us-ascii?Q?WXBFXLvsvlFjIlKm9ot+3Q69Ar8LlnGWoKI2ODpAu6yFieKL8+Ts7WulToCK?=
 =?us-ascii?Q?sqAkjQUGsAwxhamf3PegSzBuWieKdt0T0gQFPOAnBffzmgDyrGuVNTAHD3Ht?=
 =?us-ascii?Q?9hnO2XDiWLNZr8nHQhK08LNf64r4t9/ple+LV+VzTC2hWzkK+pSgytdmV/p4?=
 =?us-ascii?Q?i3WmyimRe+Jpu2qwOYCD9W7Ox/0wwP2MjdHcRpd18QCYClZiKEnyGa17acW6?=
 =?us-ascii?Q?t11IjDzf8JKU09xnHdCXv1esPGS6vAqve0p82/wiJ9nqqvl7JBQ1O9qpOAes?=
 =?us-ascii?Q?vBk8jCP0mMWMRYZT9XcCGKPpggo2or1gb6VLa+BzOfMq3RZVh5BlSM3z958j?=
 =?us-ascii?Q?u2kt61dOv3w9f9GUTSA/yfPga4cBgmiFrgv6JNGYQAkoMMjCXQU3WsvKSc1F?=
 =?us-ascii?Q?Z6fVMK7a3zH4whX9wAR8OZ4fxsokIG/7SbibHailxY/V0YqvNgihC0eVAcpk?=
 =?us-ascii?Q?N7pkt0suU3CPjvKG5wr+TPYa6ii57wS29gFcEGcS0tXUiMxZBZF17758CYa1?=
 =?us-ascii?Q?8n970vUTegRZ2wx7eW6Iwt9TXO3YJtjJwBlhlLmZU6WQhEJBULQy7D5mPweK?=
 =?us-ascii?Q?46PCt0exWMcCCD7GQwI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dba2dd1-f968-41b1-2d0e-08dcb7bf3057
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 15:31:35.9030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXSDZcBYilb3lVJYPnP25qvYjPCaqoFmBsM3XC1JVGro8Y253If4UOHEHk0rvCRfL1/8GDbw35/LRoYpryORJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10019

The mass production lx2160 rev2 use designware PCIe Controller. Old Rev1
which use mobivel PCIe controller was not supported. Although uboot
fixup can change compatible string fsl,lx2160a-pcie to fsl,ls2088a-pcie
since 2019, it is quite confused and should correctly reflect hardware
status in fsl-lx2160a.dtsi.

- Rename fsl,lx2160a-pcie to fsl,ls2088a-pcie
- Only keep intr interrupt align binding doc
- Remove unused property apio-wins, ppio-wins
- Rename reg-names
- Add IO map range

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 102 +++++++++---------
 1 file changed, 48 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 927ecf66a7404..386b4fcfa16e6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1166,22 +1166,21 @@ sata3: sata@3230000 {
 		};
 
 		pcie1: pcie@3400000 {
-			compatible = "fsl,lx2160a-pcie";
+			compatible = "fsl,ls2088a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
 			      <0x80 0x00000000 0x0 0x00002000>; /* configuration space */
-			reg-names = "csr_axi_slave", "config_axi_slave";
-			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
-				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
-				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
-			interrupt-names = "aer", "pme", "intr";
+			reg-names = "regs", "config";
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names = "intr";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			apio-wins = <8>;
-			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = /* downstream I/O */
+				 <0x81000000 0x0 0x00000000 0x80 0x00010000 0x0 0x00010000>,
+				 /* non-prefetchable memory */
+				 <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>;
 			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1194,22 +1193,21 @@ pcie1: pcie@3400000 {
 		};
 
 		pcie2: pcie@3500000 {
-			compatible = "fsl,lx2160a-pcie";
+			compatible = "fsl,ls2088a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000>, /* controller registers */
 			      <0x88 0x00000000 0x0 0x00002000>; /* configuration space */
-			reg-names = "csr_axi_slave", "config_axi_slave";
-			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
-				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
-				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
-			interrupt-names = "aer", "pme", "intr";
+			reg-names = "regs", "config";
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names = "intr";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			apio-wins = <8>;
-			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = /* downstream I/O */
+				 <0x81000000 0x0 0x00000000 0x88 0x00010000 0x0 0x00010000>,
+				 /* non-prefetchable memory */
+				 <0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>;
 			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1222,22 +1220,21 @@ pcie2: pcie@3500000 {
 		};
 
 		pcie3: pcie@3600000 {
-			compatible = "fsl,lx2160a-pcie";
+			compatible = "fsl,ls2088a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000>, /* controller registers */
 			      <0x90 0x00000000 0x0 0x00002000>; /* configuration space */
-			reg-names = "csr_axi_slave", "config_axi_slave";
-			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
-				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
-				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
-			interrupt-names = "aer", "pme", "intr";
+			reg-names = "regs", "config";
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names = "intr";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			apio-wins = <256>;
-			ppio-wins = <24>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x90 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = /* downstream I/O */
+				 <0x81000000 0x0 0x00000000 0x90 0x00010000 0x0 0x00010000>,
+				 /* non-prefetchable memory */
+				 <0x82000000 0x0 0x40000000 0x90 0x40000000 0x0 0x40000000>;
 			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1250,22 +1247,21 @@ pcie3: pcie@3600000 {
 		};
 
 		pcie4: pcie@3700000 {
-			compatible = "fsl,lx2160a-pcie";
+			compatible = "fsl,ls2088a-pcie";
 			reg = <0x00 0x03700000 0x0 0x00100000>, /* controller registers */
 			      <0x98 0x00000000 0x0 0x00002000>; /* configuration space */
-			reg-names = "csr_axi_slave", "config_axi_slave";
-			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
-				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
-				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
-			interrupt-names = "aer", "pme", "intr";
+			reg-names = "regs", "config";
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names = "intr";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			apio-wins = <8>;
-			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x98 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = /* downstream I/O */
+				 <0x81000000 0x0 0x00000000 0x98 0x00010000 0x0 0x00010000>,
+				 /* non-prefetchable memory */
+				 <0x82000000 0x0 0x40000000 0x98 0x40000000 0x0 0x40000000>;
 			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1278,22 +1274,21 @@ pcie4: pcie@3700000 {
 		};
 
 		pcie5: pcie@3800000 {
-			compatible = "fsl,lx2160a-pcie";
+			compatible = "fsl,ls2088a-pcie";
 			reg = <0x00 0x03800000 0x0 0x00100000>, /* controller registers */
 			      <0xa0 0x00000000 0x0 0x00002000>; /* configuration space */
-			reg-names = "csr_axi_slave", "config_axi_slave";
-			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
-				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
-				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
-			interrupt-names = "aer", "pme", "intr";
+			reg-names = "regs", "config";
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names = "intr";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			apio-wins = <256>;
-			ppio-wins = <24>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0xa0 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = /* downstream I/O */
+				 <0x81000000 0x0 0x00000000 0xa0 0x00010000 0x0 0x00010000>,
+				 /* non-prefetchable memory */
+				 <0x82000000 0x0 0x40000000 0xa0 0x40000000 0x0 0x40000000>;
 			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1306,22 +1301,21 @@ pcie5: pcie@3800000 {
 		};
 
 		pcie6: pcie@3900000 {
-			compatible = "fsl,lx2160a-pcie";
+			compatible = "fsl,ls2088a-pcie";
 			reg = <0x00 0x03900000 0x0 0x00100000>, /* controller registers */
 			      <0xa8 0x00000000 0x0 0x00002000>; /* configuration space */
-			reg-names = "csr_axi_slave", "config_axi_slave";
-			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
-				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
-				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
-			interrupt-names = "aer", "pme", "intr";
+			reg-names = "regs", "config";
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names = "intr";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			apio-wins = <8>;
-			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0xa8 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = /* downstream I/O */
+				 <0x81000000 0x0 0x00000000 0xa8 0x00010000 0x0 0x00010000>,
+				 /* non-prefetchable memory */
+				 <0x82000000 0x0 0x40000000 0xa8 0x40000000 0x0 0x40000000>;
 			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
-- 
2.34.1


