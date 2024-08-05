Return-Path: <linux-kernel+bounces-275307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFDE948312
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6439E1F21D06
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A6B16DEB6;
	Mon,  5 Aug 2024 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MCtjoS4E"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163D016C6B1;
	Mon,  5 Aug 2024 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888878; cv=fail; b=fPpaPDKCCcCX87KGPEBcemt5nhJMWuYjRUtQsnPH4J2oGcFUfQV1tR5iXqWMmMM0AmpGBps9YhA1BlFQtreqT/66H+bxZPYqqDnBuQXJTZPq22Q4XS/rvXudDkHB9A4nzJyjIY9UYYLG6I1Axu2on1mjO8h3WHvC+KGjVZocn8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888878; c=relaxed/simple;
	bh=fb3ltD1vFllP7tSX+N4nWQq5eEFtKPqsEKUgZnDzxXk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DHtz8oTGQriWeVFl2Wc3hjLcJ/gVAALJGzQeK9BRbmmfWyDpsyAI2i+miJtJMFrNd6sXw9trG8FN5Mhhx1qYYkyw3uAX1nr4aMmc2/DrGGPa3TyNhT5Q2a9vgZWXHQ9Mb8jTXkytsdVEEWkNdL7bu3XqM/4mlugx4cctrrE58VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MCtjoS4E; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbO2RHD69mPotCkYr96zWxe8XAmP8HzG9OtKL9Km8GLCUVH6U52YTNfQlDu99HjpsVcTEBP3lRy9A1e2sMzijmhySwNUKBWq+vaY7cUrQP0BqpQEYfKSk9eAIswVzg7NSEUkLdqBt1PSnD3BV+KvrOh7OZuHfUYQ6zA66zHsXOCvtMZTS6oR0wIMPqDvFYjOjpyEssiNwjZdWQ626Otn1StVGMR6wMdWn73a2e2xR7KEYcKJFdSymIuJBHNLWQeMvZ4l1WkRiUuvGU1FToPos3GgwnDNs0UREHS3TQhgvNqYarrFA4zM85cE7kSPcXUXOaoP8BXgMe7v2paRz81iLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljIhUU5t+sBRrrjGDmwYH3KfH9SmqHzPKtyrLBhUvwE=;
 b=d7Usplfz5P3R2IUsYgnKtM7qmplvIRlGGV+TSPm1eyn5/c1g7cf3PsxRbDwzCIQAVjQUs2KW2C4Dw1N3HbZztNd8eSM65U4uVgoWcXnFkGFVQwwUnGXD8917a30BCWXU/d/K8YU/9QEYUIZmK1iqD7v1NxtcVsRTHyfngsJYnlv37vTx5FkrEOJBM1MQGT3UnGMRftRlPIQzpbcMAdkzz4ceHMhPVa2w+1SE9Bm7hA0T8qqBmdq3U9qzPMxXlXcKOiNXh5gIt3j+bOP6PmRFHixJTmO6cRo7jqEtgG7eequwnXNwrEY7X+zFdDlKzXTY0TbFJQkh5nPmS4jtx7oXdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljIhUU5t+sBRrrjGDmwYH3KfH9SmqHzPKtyrLBhUvwE=;
 b=MCtjoS4ERMXJxp6I5RG54SjIsOlcKdM5qYvULymgnX8kMndhA3SF5zox6S+Vw4j667tREjPuSgOER6UrfqUHRm4anqFfAPFyP6yq4PCdN3DxiRABNqvPkX9fcTxe2MDQrsGOpzj+Uf9xkq9dGT3z1fr+PmANq6G1l9BDN4ta6WjR2k4y7NreZ9hLMu6D51zlqvtOGY0LbAs0FvSq3CxlSpAqgPJdOFirQZqkxCjKfSUu18Q4BwAk7D7PYFvbT9mPWobhHPJ9ebPyJgx9qiE1HCZh5a1XjRIrS9RMX9TYx4CmPTzbWEZLkO+Mi0OG9eohT01ZexlVCgE7ddKnnSfy3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10319.eurprd04.prod.outlook.com (2603:10a6:800:231::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 20:14:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 20:14:32 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/2] arm64: dts: imx95: add DDR Perf Monitor node
Date: Mon,  5 Aug 2024 16:14:15 -0400
Message-Id: <20240805201416.2974996-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:217::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10319:EE_
X-MS-Office365-Filtering-Correlation-Id: 213367e7-efd9-4498-de31-08dcb58b37f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pup45gybgnUQ69omP4oOxqMQ7EQ9Y24MkqOfwAOVVR1xlC+n6DMAaHDl9RAa?=
 =?us-ascii?Q?tcKdsf3jjLu2TuNfFIz06LFSIxazd9isaV50Af5vQwnuKaJj4aGlySBAOHRu?=
 =?us-ascii?Q?kr0y36pbQZvC0h99odU0ggCr4FtSgOLS/xjZVMc74iIQWBlxUa+5D+KQo41b?=
 =?us-ascii?Q?2TE7JA+HZMCHUy6eFgLc7fqaikFVX/r+sZhM1W1QUpHk0FVnw0nGazQRuAPJ?=
 =?us-ascii?Q?Yq6wdknLYKZux1FhGSmKdf2Xrp2zjczUgQGL75gnawR9nBdhud/dfL/VjvUF?=
 =?us-ascii?Q?GXVaasDSrwXOgMKtmgEfuUVIrC4SJ9fMKIZ42RIibdXjQcN6i8z8um/A+h+S?=
 =?us-ascii?Q?qjQKPWjfUUt5dicvj6/+zkYHvR/QCIqFUo8IzAlqUhclFyTvu0qXWmLyY6k9?=
 =?us-ascii?Q?3D1pTf5ulG4YeLT3jzO/njeiGZmJhl6oXZUzBdICUiDW4czcqfdyNkkDRCOH?=
 =?us-ascii?Q?N65LAOq0mZiqGZQwP/reFHa/1lbpnIu+kMI0mADHmMtMWXLMTh9L59oEzk1G?=
 =?us-ascii?Q?4/j87hpKdI8XXaG2bkT4SujE7IidmZ5Q5XpMGBIVk3K58+iS9egOGKGtPV94?=
 =?us-ascii?Q?Mq+78NfDMxzdOws5JosQbTRl2vAM+1TMWn9Cy/j89uFdj1nzRr5ft/VXTIBX?=
 =?us-ascii?Q?cWcVN052bcYMsVGOErMT98mK6k1Ah9leNQNBHK14dXwBsk5rmt1hzDbJZQGV?=
 =?us-ascii?Q?eK6pEZob6o2PyTpi4ZJDPD7BywGHOor4BNSom0j3Y8cJzjd0WbcOEJEIXvdm?=
 =?us-ascii?Q?npmhSK9o6ROb9gumhrkHY/X9nlbjQTKt9xEZpAfeLPg5hmxAQJLDZHk5aes6?=
 =?us-ascii?Q?rmddwgBxu8RVTnGXjY6BnA/a78LD/7mMhdk5bysZRDS7voqAbCLpDp/HVRxv?=
 =?us-ascii?Q?lE/5+ZBLOO6Wgemy6XV8dnZbt9uo3aZoA1fgmF7SZhcc6Ua8nnnjtrjJ7hSF?=
 =?us-ascii?Q?46o3qSeSa7aJUwPIKix088mwDij5odyM78rulRwuRjFltnUyOiFGZ/73rHt6?=
 =?us-ascii?Q?tuh4yVvzwyP1XHCRcgiLLpfWyfV9+hP6+kk1oj1pMYaQYn4EkSivt2/wAcGh?=
 =?us-ascii?Q?eYfhxODqgc1+JscqWZt7FHyDI/Zh1PjCrx7PX+YF9Kgmo8t699uRSrzWzc91?=
 =?us-ascii?Q?vnr03QuBVQIiU+zxkCmW8AiIA2+xWIxHaBfgLata6g9Kr9d6E085d+pJhBzS?=
 =?us-ascii?Q?gf6tkR75338YE9KOJGLrHvzb1fcQshGr5S8qWPZtWZJmujOTyZLP8Qc2wQhG?=
 =?us-ascii?Q?LCpltXKjzysb5Ix73OImYZIog7owNmOcfWbDsOvQ/9581aopNSrXXV4lqfAb?=
 =?us-ascii?Q?AFauiYN52IRAmRPZydXJhzU//zW8VhdrTdEpbo00p9t+5lpKoaIOmBXNLDo7?=
 =?us-ascii?Q?I6g1HW0xlN5DDqO6HbDx/bK6tZD5SYk3GqXWwBzA4Qsiz92YXuBN5fNbsGsL?=
 =?us-ascii?Q?0Rb/uPjm/Qk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DB+SFW0DM59DfskDt+fzu94b2NA/3KIxWoLmm7V8K2kgy8d00ZiwqYL3G0DT?=
 =?us-ascii?Q?jx+3KoYUFQ0rbfIQag8rDsOOus+qIJuxmJQzFhDA/M5gQsq8cpO1F/tXo4r2?=
 =?us-ascii?Q?sIUUK2QP3HId98GzTRV9nyUaVdFv62iI0BnPUT9i9F+U+fIYpECSY4S2nNCi?=
 =?us-ascii?Q?5me+VSDoFF9wdHIDx1WjnBSFBUCcweBuxjOVcH8sk4DvDTaodas0kWaN/3TW?=
 =?us-ascii?Q?dPmjRrR8ZPWZoV9i73gEXmO0Y/6C6OR8Sk/G50wfE1/zAvLucesNAXHoyPR/?=
 =?us-ascii?Q?afzlPz4aHP/Rk2zpS9ToVMhMhshwfjyUVRTDRYGcPjUm9JJuq3a+bQB5YV/D?=
 =?us-ascii?Q?TzEftbKatXiwhBx1IA7Y6WP/HSDUA5ktzAf53ePRnXbLDRW9zfwee8ks6cMS?=
 =?us-ascii?Q?GAKLm0pvg63ZOreTADi7APv/5+3CNQZz6Jw5sHrWW5VvWR/E2hmhWklRWVde?=
 =?us-ascii?Q?vYbhrs1mOoTFXaAlf1ZBZ7yF6bQJYpKqcsXezzLKQ1vDsKtuViEhiW+PnyXg?=
 =?us-ascii?Q?XeFOE5MDRQORBdhX3nkz4139QIArQiJypa2c3ihvm3SxsY9D8eR7IltjFDRJ?=
 =?us-ascii?Q?nhgkTec5Vctqmegmfj0rdw+Qmd0Ii4NDtNSz6btzwVzrjcsGo0qNXuQPJwV3?=
 =?us-ascii?Q?DAsNPzq31LN52aQFtswlcqOIoOE/l4UGZMrzBcNFob8J9kbZkze4s4AM8IIy?=
 =?us-ascii?Q?tADc9jwuH/IhfIeWo6Cwq3LUY7OZRgUCettgcftWjUkb+kxJ9SZa1a57oq+j?=
 =?us-ascii?Q?MBIlt5/wf55e5sjBt/+nCY0mcXrrNKAjzx3UMbcvvCJsfVQdTSfarmonbh8U?=
 =?us-ascii?Q?2EoKVMp56kiHNIGhHeSVHygA/Hc0iIePaYwOfZO2bNItzRy8wTlIT8caly8z?=
 =?us-ascii?Q?75G9ndXIJB7XSwIGpIbVUiYCekmeZjjz+lclClqvzl4odKp1tGX6LDoi4DRP?=
 =?us-ascii?Q?yKWw//U084hW3ZeXXk3v5lYi48JWYnHTfoZRUt74ElwpmHC3nAW6f81C95D5?=
 =?us-ascii?Q?DnJE7GG3rlL3I2WWSVQs0t5liTHUUCBuSg5MFH/BjRflnYAs/HAD4+CCnfsH?=
 =?us-ascii?Q?0B2WTzPRcKi9Z6jb5NTWcFv0V3VKFxkOncPVeACRsAph0Ghu3NslHDyyQydc?=
 =?us-ascii?Q?zX3dIK00n32FprRTnxhxcD2OgoIfY0D2kGMWCCPR4TWnWDGDIj9AdKm8PCUt?=
 =?us-ascii?Q?qP3KRbgpb3rZgPmd8FAanoECClAgm0WOXbogt/HMJFwjD7xhIpWaeF4ZEHx5?=
 =?us-ascii?Q?GgzB/FoIhzxygtBQx68EMwVknlbp4QpraA3kwdef/IT2LGivXlT3odly592i?=
 =?us-ascii?Q?0zGRcQhkA5gJXwn/Rsc5Zyou6m0gm1pSRXkfcUWWvGQ2rwHeWHD378BJ2xPS?=
 =?us-ascii?Q?1yPNoIibefDqnpAWYqv1y8XLyf7ActxCoOOhcPm7jkbdwfS1ZN3gOs98Q/PN?=
 =?us-ascii?Q?BAvMvnHXG3YPGbuN+owhR2o47m0XBt/Fo5V70JwbgYZxSgO719uQR4pyYUw7?=
 =?us-ascii?Q?246eUMTYh1L1o5+++WEsH+dB1W9EGwTJMHcVV7h46YBB+O3ZCtWKDo+xywEj?=
 =?us-ascii?Q?fq+ZUxrDq9t/7jxuPgY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213367e7-efd9-4498-de31-08dcb58b37f0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 20:14:32.6303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYJlPmq6a31NbN5Si2IOrW7mx4PYEDPrx4ULwcLGKiw5vnuHG8vWsu+iJHZ0veQ/3iWW52UkPMjp8o3h45fh4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10319

From: Xu Yang <xu.yang_2@nxp.com>

Add DDR Perf Monitor for i.MX95.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 217565c960bba..d25465c947822 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1555,5 +1555,11 @@ sai2: sai@4c880000 {
 			dma-names = "rx", "tx";
 			status = "disabled";
 		};
+
+		ddr-pmu@4e090dc0 {
+			compatible = "fsl,imx95-ddr-pmu", "fsl,imx93-ddr-pmu";
+			reg = <0x0 0x4e090dc0 0x0 0x200>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
-- 
2.34.1


