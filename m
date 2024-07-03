Return-Path: <linux-kernel+bounces-240289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBEF926B63
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17B41C21BD6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B2C18E746;
	Wed,  3 Jul 2024 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JyW69U+9"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1604D14B966;
	Wed,  3 Jul 2024 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045097; cv=fail; b=bX5IUC4Do3Qw7dg/+EIxfzQUIkWsCFYwPyLTx/3LdmAthaOatVf+bnEZWU4/fbRqPcJkrbEWA0Yt/CwgyLMh0f7j7Tnj4G2Qwo16SAqwj8ypmvxTqE4xcNsgibAJwG7cvlS3L3pe2vYTc2v//plzS0ChSTeCC4L+kxUyBJufDSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045097; c=relaxed/simple;
	bh=RxTcnVrJcq6HgAf+6jaTJggJj8Fnc+MBoAxnBOqsuq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q5KVBkjiOQUvDddWDXc5tf7E2jzhqapoGn0PYecXB9ISo9OB8ypu21sJ6wjmrUsIqOdEzvE8Br28uMuQSHX3XIh/jXMH69prqS7iLvrreQYg/x1eFE7O6KKJHPM5Z4DnFUSBYQyry5K6F0MmZ8LWVjHd3yfvj3ESu8mus8FAorY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JyW69U+9; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDoc7SJ62S8Ijimli7rJ9kP4OkxpvcMR/nOVj6kAwA63TIsq6mQbe+gO3b06+QEAutITP7K6LOciXSlCI8qP6Jg6hbPXc28SV8EzGIfq4N6qjT9+qB18omMPnlq0XKLuWXAUCwyQvRxsqND7S4SuFnuYO+BjLvs80pO5z1tSvH60rKVwONAF+ZMJvUjAyZkqcucZXID4o4MlfY0yrVsTI40WAb4TNLDCkj8i/jJ8DMfH3TZyNX8TxNeTpQVmpd2tskOOuKw6BgGzIUPCE0NryiWivx/DHa3gDyb7nD7OODId7rHz/KAZ3K2gKG8SH7WgUd0KFphOyZ9SkutTwKT7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySrODcG0sL6Y2T4y+wc4M0sJUXeBDtOFQ9MI/ZHQHVM=;
 b=PGAPz93Ggz8rB3g7RnsLFcB/e5VxzT5eJ8yFbEOFR0Jc91hT754xB3M5iiAEgECzDB94JU41YoQu7UFK0HDlvrckIadGruwAsG1w8Qm7WSd6o+if1wqfd0UGF/irSBnn7chUJnp0l5BnhnKTCsq0AMhGUnA3okYXCNEXDfdwGT0751YRW7YfiEIQ1A+42KbBSj17R0BM/TLxRyrkLHYuGrFxnJnSag5T+jE+K2qOHnMDPPcRKLN9NCDl+soZ5WDm0KlAjGCwpxBTp2sTCH7ndCC7wznXW4EYVPPeX3oilqQafUeYaqoPgGPeOwqqQy35YTPDrB5FdE8ytvkdjL5UNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySrODcG0sL6Y2T4y+wc4M0sJUXeBDtOFQ9MI/ZHQHVM=;
 b=JyW69U+9/dJVuvExB9cHMCh5XdQz8Ma4r++/7y33dOvSRTbU4LYQ07vgSnYffmvHDM+LmggvG/0ztT6Mgp41lASSsmh48bTG9Rz57azWr+LFTWu4Cv9yTiWruIaCkwC7JFxEbpqU8asoPJljO3aj9/MTrz83CxLf2ACrLihWsCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8839.eurprd04.prod.outlook.com (2603:10a6:10:2e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 22:18:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 22:18:12 +0000
Date: Wed, 3 Jul 2024 18:18:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
Subject: Re: [PATCH 4/5] arm64: dts: layersacpe: remove undocumented
 fsl,ls-pcie-ep
Message-ID: <ZoXOHLlJ1QG9NKFI@lizhi-Precision-Tower-5810>
References: <20240703205847.2826263-1-Frank.Li@nxp.com>
 <20240703205847.2826263-4-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703205847.2826263-4-Frank.Li@nxp.com>
X-ClientProxiedBy: BYAPR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3d7c65-5888-4e89-0bce-08dc9bae06d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qd++NaXEAqgvrPdlebJaLJ0kzatrihfZMjCuDRtVzheKiDXpwlvWrbkSJzu8?=
 =?us-ascii?Q?0lg9glOSrCbZfuZOPq0GDI++twT+02QQLKwoGTvcaLnHPFVT9NuUmAGONI5S?=
 =?us-ascii?Q?KbVbRcHLQ2BqWQUbh1y+dt+gF3L9WCyUR7OgiYa5pgP9Lq+wTRqg03UdpMU6?=
 =?us-ascii?Q?ilwlBE7Otb8z7SA+JJZRsJL2pLixze1C3t3ad4WdS+lc8wAxmtqb/tRN2GLR?=
 =?us-ascii?Q?dKa9BBSIObYT9vLSurx9Z1kyHs57xdunhTVW+jJaiUOIxaTcP72DhfL4Ao/Q?=
 =?us-ascii?Q?ruPbMmKHMfOgPzY1bHt5hmCG4v5OLo+Ln9PD15QmZpSFtWuZYko5oBe83uA6?=
 =?us-ascii?Q?qP9SQzQJ+te6ejNY8BowsSj9IZcyuj3HSyItMLLcI4nQFXIjtp+jTHnEarlg?=
 =?us-ascii?Q?8TQ3GzXCydWHlI0wf613jaoglPzfr+CcGOsVifT+TsWQFbPslKWK01UD53Yh?=
 =?us-ascii?Q?d5KcDJzgtxO1LQChz4W9J4to7GdRyDsIlgoR71+byneUjv6cQFZ+CEWgenIv?=
 =?us-ascii?Q?Owx7qdxQKBy2PiwxMlZPT8Q08iCN3sW4ZrzX6rIu1R1JvK6q7TYpsaVTSkUq?=
 =?us-ascii?Q?fqndbZ+bjYn2mQlNSQJger+fXl2aE8hA81B0Jg0P3xXy+FXbgWM0hBgxeqy3?=
 =?us-ascii?Q?9a/shheN27Gk+WllzbloTOz1veUNmOXKROk4vh3B+jLlY/0I+U1MQXHNpiSd?=
 =?us-ascii?Q?F02icDzSkpps50ZsUEW98sP1p1P1+5FZ1xkxEw8Sb3FWN0/xOAePswXY3/HZ?=
 =?us-ascii?Q?+3IjKT5WnIwXyGPSBP2JyvsHa92GeEYB8P5/pl/BKhLev8dSlxY43Psm1wC3?=
 =?us-ascii?Q?82Pstk8Ksed1P2nK2GO470wOb2rjl2JJd+1bj/+nMhPS/zCTz8PxT5kLZW0u?=
 =?us-ascii?Q?dbzY4ylIIxm1lquVR6VVAbzRF5HiCWEsNbcI3/PV3dXY+6+0qkbGn7iC5xDw?=
 =?us-ascii?Q?yA2KUtTaA/x/k0J2YPUFlZObYdbJPkrMtYeGmyx69kE1Nf9chrV+Jg7mO9q/?=
 =?us-ascii?Q?0dmKrzIkueM5WL8Ew8LLrOe+6xvBdCwWbL5ksN1Z2tiR3JQ/t+W9Z+zVs2wF?=
 =?us-ascii?Q?4YpPvdjLzgzsgSPHwAuMlR/5LhB9hIQYT2D9ZgoQeiFZiZC8qqwZS6BCx7AP?=
 =?us-ascii?Q?COzX/gdMKD+8j8xAs/bCV270BVrKcKOv+nndfXdWZT2ObQA4uh5Wy9xDDZc1?=
 =?us-ascii?Q?lD2wMhlKoOigItGXcf6PSXwwQPMqYPUFzu+A0MbQ0gT4O+TZapeScyosjety?=
 =?us-ascii?Q?asiBYP1HdtJl6lC1cg35jIpgS1ZUs5jJKZB/AIg4wDrTPE/J7Se9wKuzC4Tp?=
 =?us-ascii?Q?9mgsDLHMancS2I+rtglRYoITMrLy03dY2wWzZIzijh01zb52xxuyLfoDL/Eq?=
 =?us-ascii?Q?/iAbwj4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?obfNx2Y1UBBQD399QtoTgZufj7JYSJyt9uPpMOoyFsmzvJkZ91u4CSlDh9QN?=
 =?us-ascii?Q?YOx5xvNN7IiDdeAfcWPUsAiU5Rvi5Ow4pnwmT5OF1C/QRdFI1GPGO66EYN8H?=
 =?us-ascii?Q?Qofor5m+KuvO11eRIx7izsYbi3JtRAZcPeQ99cm3YzKfmFi5VZS9KZbHl8FS?=
 =?us-ascii?Q?tKPEYNQjIgo4X5NXE1Bu0bV4KhPnPS/m+qPigNVnBcUu+Mm0lxjJNFFmEcd5?=
 =?us-ascii?Q?ss95C88GhalfWO36VBhu+id0WezaGjx2891WTidQ338+Q766q3yuZZL/tvH2?=
 =?us-ascii?Q?Ix6TDAUIcEm1LUretJYdVCfyyfM3shljGxdu/hGvlyd5AODeIIkfba31jD7l?=
 =?us-ascii?Q?R5MKuk9sJKVUFa4bO+CEwLAjHqucm5TpsslUHHIk7BGXv5iHWfxRvhNIP/5V?=
 =?us-ascii?Q?7BydV6lwEVDBAR6iK0/qHE7mJZzVINJ6quafScF3/Yh97KFRtqj8/C0mlVVA?=
 =?us-ascii?Q?gd/6s1VePNpPt3m4V7uTMYesAA0FWXvBO5dR16UHEyUceYVsxAHGEPBTP92Y?=
 =?us-ascii?Q?/V3M8QXLJn3EvA8bUPpk3LU4VaKCKvLuBBccwSKDKf9APexdXSmc06+ywcmU?=
 =?us-ascii?Q?FL4i3jOEIQH03aBrYK0/td1r5BzdknQtdwSe79wKIp1soi8bCpNFufqiaf4Q?=
 =?us-ascii?Q?c8rKYtFZjvtYqLUV923RwzPvRI1fXNYyVz0U+BcFh+o8t7u9YrHnAp7x55ST?=
 =?us-ascii?Q?ueNywamKY4W4otyUfNmERavwf4vujnYpTTQmSBRIFm/4X0vBsY3L3+AFMtUR?=
 =?us-ascii?Q?PyV7FJEpM9U8oZct9KQ0Rk/LEqqRaFXcmWKZGZge4UmQJTmAlJSI2hoEiaal?=
 =?us-ascii?Q?W1XPAPnZLL5bVk3mO4fXvAaLNqpZ5wWfIoCKb+z38+l3WrGPlmgDQTpn7F3Z?=
 =?us-ascii?Q?U7Zgd+sFuAvcSpe4dxvY/5HeX1K9QkhaTKP7WFuoaS/5kGFX9cCAYs/e1P3r?=
 =?us-ascii?Q?JM/lqYYsk/teBwvC3yL/1UCXRvO0DLhL3bxmdTpa/62rucGu4xgaG8KLvvj3?=
 =?us-ascii?Q?hv4X1iEXFUrGc0/pim2dj2pWUaQ+mKVJFrRjHotryiQr4AdvWLC9S7zCNoZm?=
 =?us-ascii?Q?LOd/yD2cxMvOakvHqDc6ipetiDTUo1KY538VENrIW4drYKVaoAvbSFO19Dcd?=
 =?us-ascii?Q?YLgs3hs3tx3c6Frno/eGQwKs2ueWARrHCw8mNnDzQkbBHHFBnVWlPOLfd05X?=
 =?us-ascii?Q?Gd5DdYoDHXapfoPvONPqdbkr2B7QJSFGoYWm/Z0eLQlNBc8GXJkx93KpVVKZ?=
 =?us-ascii?Q?Wr1G4FQl9Bx2GM2k1PqEb7Cs/tzEZQcyhU6XnUOhgN/oneBCwvCrTUvmgnrp?=
 =?us-ascii?Q?VP1e9I05W/eBEQvxgNu8y25/Pb0cmFqXg/xvrfsGgkdV59/yctJ5h1CA4Vcf?=
 =?us-ascii?Q?6+jo9sqhdCGYV/b1Hj2qouH8TR6IKgS5SmTbSo2GUnMg9L2tf2tHN1hVrYKk?=
 =?us-ascii?Q?ssAi06Jt2GObwgLjrT+08jzUhKuEnakCHQ+VLdGR+mPU1D4Cnb7bm9zuTIwy?=
 =?us-ascii?Q?9+czOfRYaTsaDbHHXqhKoQkgDCvqktiWJB8ET8vIFSdImm0l0UxZ5klDGkm3?=
 =?us-ascii?Q?Zd3XSyJzmkhmHJf6ny9Ds69hmo8Ix5KP2jP7xOWi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3d7c65-5888-4e89-0bce-08dc9bae06d8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 22:18:12.2294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: na5T/kIPYrRqRNsOHIIeCUIze5jOHPHzwJj7cw/uFZ3BYnLkMTJoxwoYYpgtJ42SdFQPklACbe6o/9UErBxSmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8839

sorry, miss spell 'layersacpe', will fix soon.

On Wed, Jul 03, 2024 at 04:58:46PM -0400, Frank Li wrote:
> Remove undocumented compatible string fsl,ls-pcie-ep to fix below
> CHECK_DTBS warning.
> arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: pcie_ep@3400000: compatible: ['fsl,ls1046a-pcie-ep', 'fsl,ls-pcie-ep'] is too long
>         from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 +++---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 1ae73708bdc60..c77613e98e539 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -820,7 +820,7 @@ pcie1: pcie@3400000 {
>  		};
>  
>  		pcie_ep1: pcie_ep@3400000 {
> -			compatible = "fsl,ls1046a-pcie-ep","fsl,ls-pcie-ep";
> +			compatible = "fsl,ls1046a-pcie-ep";
>  			reg = <0x00 0x03400000 0x0 0x00100000>,
>  			      <0x40 0x00000000 0x8 0x00000000>;
>  			reg-names = "regs", "addr_space";
> @@ -859,7 +859,7 @@ pcie2: pcie@3500000 {
>  		};
>  
>  		pcie_ep2: pcie_ep@3500000 {
> -			compatible = "fsl,ls1046a-pcie-ep","fsl,ls-pcie-ep";
> +			compatible = "fsl,ls1046a-pcie-ep";
>  			reg = <0x00 0x03500000 0x0 0x00100000>,
>  			      <0x48 0x00000000 0x8 0x00000000>;
>  			reg-names = "regs", "addr_space";
> @@ -898,7 +898,7 @@ pcie3: pcie@3600000 {
>  		};
>  
>  		pcie_ep3: pcie_ep@3600000 {
> -			compatible = "fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep";
> +			compatible = "fsl,ls1046a-pcie-ep";
>  			reg = <0x00 0x03600000 0x0 0x00100000>,
>  			      <0x50 0x00000000 0x8 0x00000000>;
>  			reg-names = "regs", "addr_space";
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index c9459e251e59c..c453b59598f17 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -588,7 +588,7 @@ pcie1: pcie@3400000 {
>  		};
>  
>  		pcie_ep1: pcie-ep@3400000 {
> -			compatible = "fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep";
> +			compatible = "fsl,ls1088a-pcie-ep";
>  			reg = <0x00 0x03400000 0x0 0x00100000>,
>  			      <0x20 0x00000000 0x8 0x00000000>;
>  			reg-names = "regs", "addr_space";
> @@ -627,7 +627,7 @@ pcie2: pcie@3500000 {
>  		};
>  
>  		pcie_ep2: pcie-ep@3500000 {
> -			compatible = "fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep";
> +			compatible = "fsl,ls1088a-pcie-ep";
>  			reg = <0x00 0x03500000 0x0 0x00100000>,
>  			      <0x28 0x00000000 0x8 0x00000000>;
>  			reg-names = "regs", "addr_space";
> @@ -665,7 +665,7 @@ pcie3: pcie@3600000 {
>  		};
>  
>  		pcie_ep3: pcie-ep@3600000 {
> -			compatible = "fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep";
> +			compatible = "fsl,ls1088a-pcie-ep";
>  			reg = <0x00 0x03600000 0x0 0x00100000>,
>  			      <0x30 0x00000000 0x8 0x00000000>;
>  			reg-names = "regs", "addr_space";
> -- 
> 2.34.1
> 

