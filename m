Return-Path: <linux-kernel+bounces-279833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 927A994C25F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832A81C22211
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C22618E02A;
	Thu,  8 Aug 2024 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jWffMtFu"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2056.outbound.protection.outlook.com [40.107.249.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652991A269;
	Thu,  8 Aug 2024 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133717; cv=fail; b=c941eBwuVQbcoj/IURPXj+0Xp33fhuCvzDqU+1edeznUgDs97GES44rbi+JdaIja49bsr8zmJ9pT6zOUmnjd3CaPVYCZ54R4PZ0VmyD+FKOi10ABpPPHJ1ikC+92qHxhuA1ldqYyEKRdQbUEV+BqS1An86/DokwCxrTITUzIpAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133717; c=relaxed/simple;
	bh=VIifYJygM2ej+DFM5KwMS3g9Liop9KoinjPXE8mtE0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VI08CuvOmSSbdzwMKESSTTshkJYt84Xr1fUqvoCKL1SK9dQ2bcrCC/TNYRHJLEt9/1BGSXRGfyCDoA9eYum1tOAA/Qwnvc+FpfwoA0yZdV2yGHIWzWTPxnoHjpezhzfQXhs85hBnswQTa48BimyP3M/mdCmxaSJyChf15VFAWHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jWffMtFu; arc=fail smtp.client-ip=40.107.249.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qd2S6CH8H0YDtRjH0bXiZd0FA4SqsOrdcXZ2Aru0lkgLJmwbpekL3leeIaa8S2bKxlAeTuTmh5JU0zFteQ55PZY2xF7uZ1uQ6Txqnhph9V6vKoo3ZAOU8GyF31SaxQrBofL/DMCu/d4CYLeoL7nunF8ig0z4WZzrxjV53LV7IxM73qQ1PyUtIp7i/6H+GJ8568cTbz+cLbTLarw3S9Bq1SivSGAUFKfjvmKOLdVnHnuXgLX+pohXUTktr2+KraDVKUhSH46Y/+JVoywr7RytjC4g+Im8JxJxDpz7X/JPv5DY0jQchRWTaXlb5zfaf1zLaeXlRbPsbpE9HrgG3WnjXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIifYJygM2ej+DFM5KwMS3g9Liop9KoinjPXE8mtE0Y=;
 b=rIOp2WoH8WhCtqtmkLrJcazFyPNpelPHv2et4cazKPAKbAHwG6a9hH5B4R2FPNHix9hWAHH8+BLngJc+dPCATk6hunqhQCAqAM4VcOpO6Li25vt902clcHBvg70JRXtn6xUwsHiz8WTUjXtA7Qq6E0xtFwTS+mI2EeRpOga7q0qZMvIymwl5R09L78FX/nadpHzVjuC7YIql1RWzO6MIaHc8/tifWoxTuN/LBw49INdpZJ0QK+0pkivdAMY7zMkzEk8vu0vPRnl2fiZ6rJ6KxbobXtdVw7HK3cCknUYxOD5G+ZhEaVMRffQwPfa9VNdEET/sNq8PT1TiQ19GmgfaZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIifYJygM2ej+DFM5KwMS3g9Liop9KoinjPXE8mtE0Y=;
 b=jWffMtFutvJdpLWkrYQa9QGA31fYHvVV1Ah/UCdRGvtmDqUhEPCLl+cw/z64UFhrx7th1O+FTu5SVafrZ16kGdxWryVsPITb0oADG3YxacBOzhAQHdWobGjNCG/Xe1t2NH+dbrlsd/4ZPZtErlw8U9jeP6Pn2ov+H3QjIjrUpdHzkDAp3zm8a/nKM1Ig9/OWsShycWdxjciV9CuqPACvBnycC5NTcbboQHQwCd9xzi97U4qYAvwqP4aAHISJs5Y0ZQ83LvpBm8BBzfXwn+1KfWWcvFmtAw15rEStpsmoMoH35SIJ6J+Y5sRWs93vsG/sCyupFG7mlAvpYCFBRBkFxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7037.eurprd04.prod.outlook.com (2603:10a6:800:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12; Thu, 8 Aug
 2024 16:15:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 16:15:11 +0000
Date: Thu, 8 Aug 2024 12:15:03 -0400
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] arm64: dts: lx2160a: Change PCIe compatible string
 to fsl,ls2088a-pcie
Message-ID: <ZrTvB/3GGIhEOItT@lizhi-Precision-Tower-5810>
References: <20240808153120.3305203-1-Frank.Li@nxp.com>
 <20240808-frosted-voicing-883f4f728527@spud>
 <ZrTphsdTZVsbiGo/@lizhi-Precision-Tower-5810>
 <20240808-linoleum-evasion-ad7111a2afc4@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808-linoleum-evasion-ad7111a2afc4@spud>
X-ClientProxiedBy: BY5PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: c2bb61d5-6810-460f-8421-08dcb7c54722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LbOR8rl0JGuv+s8kFRnEyAkAIJCc4GHfwGQQA0E/cAfy1ZDXIk7qSoIOkm4u?=
 =?us-ascii?Q?/uTnElahMU74Lhd++oC6bhOuawmuU8nXu6sFMLgyFHwNchDHf4BvfXv6HDoo?=
 =?us-ascii?Q?0otAiE696sx+vaECJLb6mlSLc6r1UFeWMUFtZmDcK6HkOwqfM57hLD6Wx5gC?=
 =?us-ascii?Q?04+6+8TKwTJonmc4n1/cz/NGMEDwoSw2kQyYb1idJpB6X9Te98HRh/NglybQ?=
 =?us-ascii?Q?KsZIWtAR9KkkNAcwZ2X8pXyqYAffTAawGWQFz59tBoO59unV5zVUlDQTO/FF?=
 =?us-ascii?Q?XpZhZ6M3GPcARz1CHPHu7+fS3e4D0C+lmXMxPES0qbfF6jL5BaygWuy4ZxQe?=
 =?us-ascii?Q?WbZoV0ASnZfDv521rLlF+5rdIGW0GDrpn+O+qEVhk8A2YBoMmQHae4HwCa6d?=
 =?us-ascii?Q?/gTvux5ZzfoqdaBZ46E5jwHkt1CmDNz5DmcCL3U0I6wQXI32SUH2yR46O5Ho?=
 =?us-ascii?Q?b/n3k5xzPxybZrpkCBFrBUulc1iA10B8kAZUw+7BrvjvdxkPUCWnJewJuW8v?=
 =?us-ascii?Q?zchN7PyQ/VHJ0P3JCGysZkjMfT9bvVqYqnnJECArBZXBKGGvkCgF08VJf1Qk?=
 =?us-ascii?Q?w5jiFVCvuKDx5V9peuSUpLwNsUI2geXW0NW9IrjUxGgJVVQyfgjBqTDImTG2?=
 =?us-ascii?Q?8bxakBrextUNLn4qt6DTxMfqB7ZY8zCtH7tiqbZJZpO+xtAkLz4Ppq8Xu86W?=
 =?us-ascii?Q?nauyHRnIbrsnh7U0CUL6EDWlbVS1mD1Nf9byAwe1rIuIB1dO84xfdam8uUDW?=
 =?us-ascii?Q?Ovk42j/VODRpzFgcIz3zIeA9ZHA22uvySInyQ4AaAI11SGUKPl/MwqaZ/601?=
 =?us-ascii?Q?LasTQuBLmG8Lct0IwgRAzJBiqwwcJq52AiTwd4+ZceJmsHWrlJiof/goIePq?=
 =?us-ascii?Q?yApHHO6B/ifnlrV6gTF7zZwfqQT5kxnTyKiYfFjo7EagMuz9eejjITmf0+0/?=
 =?us-ascii?Q?AHH1g0C7JBC3lqXVQVbRI//npfOJCuAZ+jMGuVaQbky1GS7Jv0H/tpG+X7Yg?=
 =?us-ascii?Q?C3ZgZE+kCWxiZpaMZ451qCh6F62EiUbT4K3YGEQkSGvGaIVkDbXAzHXFlEKM?=
 =?us-ascii?Q?pXKQIH+HYAlaSMtShyXWDYzQErKRTZ10BH/7Sajiv1GWKDYqVUCsOdxQAp03?=
 =?us-ascii?Q?fqVpJ+Q7/j0F3GX/MIqscCrVb85r/+q5MMXKQAwCN3khGAIhzt8a3eG26RbB?=
 =?us-ascii?Q?U7oDUQMBFsVLHmCTVH4UJ9Og5o3Ln6kOYvAkTtkTUvkncziSlEymVsCJMCW6?=
 =?us-ascii?Q?Nnyrhv8+Gn84ClUS+GwLLnmU5JaFXDqOglAUwgjfl5C0tQ5Py7LdMJguuto+?=
 =?us-ascii?Q?URL4MkpGnfRfBfA+ArWtcbex6IKZOKz0eIypVKSLvVOaGy8BhSH52GHZgHIa?=
 =?us-ascii?Q?kdv85F1Rk5xJNkJFKRmYlAJ4+ePKuHswIrinw7KXb9xA3e7CTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xslZ/oiqvSmsPh3yV9/1kooa5IoI8zlgza6nS56wJQ8x+znwRu1EuNLxrlSV?=
 =?us-ascii?Q?SQy60v4/HR14BOuf6kL/bbfhksk2Lax4dKIE4U39Up56S+D+TUnfEXwMtf/j?=
 =?us-ascii?Q?jMlY5UNPMw1rQugVWvMguTuT/Bf8A6cy1psUpqRrBZJI4nF8G3lLWyeH81Rk?=
 =?us-ascii?Q?G/U/CRZ9tzDSVoTMKKc2xVV/SVASqcOBjNeVpZZswNAe18m1HGg7xRBZAXde?=
 =?us-ascii?Q?v4FIGSqyiUmNUNWV/gSap1y3iW2mP4wUSwlScPUNvmocvglLneEg00DuKowl?=
 =?us-ascii?Q?c4jF9XK0bwZfpYAsE1bA7gVKB0W4TbrOcT5f7Q7dt35bG+ayz+ZG/yb5AqPg?=
 =?us-ascii?Q?XhGE5IxLJju9rmPHXiI2rtlngZ4fB/jigF5SlJStphf95m88TTiqvXNFIGSo?=
 =?us-ascii?Q?IXBtP4ixa7XOIGriiegg+puciLGny3KBgf9EyTtcASDeZ5mdKY7TUBL5CUWB?=
 =?us-ascii?Q?NQWohkDOBJEdb1j/M1RIQauWKGeCKMK1+St365k52613rxGydXfJooLmO9mV?=
 =?us-ascii?Q?6itPKol/wnsjwMmsr7Hzx1d3Q3vGMx2is1GkVYuoOT6VKWBu9WdwGmk7evDq?=
 =?us-ascii?Q?DtOKrcR2NjnICIgDYBiUmgerteKQPIIOSwVkHOpWv8dyuAyMJ3mcNhxp9xJH?=
 =?us-ascii?Q?u6vlhxidTZkNihC5ApmABGlZ8QYhPdD5BEXBTm7nV7zCfWo74dzhf8mjx5Mt?=
 =?us-ascii?Q?a5EFDieefzTJ1xSmTExQWn4sgtlnkvDP5tn617OQZ3qEgyY5P8cC5wBNOM5l?=
 =?us-ascii?Q?gGVoy+0bpz1bPXeAfVu20dHSsDFq+9H3AefB7xW3BsXwdZorcm1hd5U8Lq8Y?=
 =?us-ascii?Q?R47NMKUSUPiI/kHl9wunbivjrbbHdWmW7uETJfbyomeSRFCxzUIUL4N+/9fJ?=
 =?us-ascii?Q?8RHSIJe6ocRbCR9OtcgVENVSABN8cRDk6Jy5E5sKHHBrWXjCeFzyNw5Hf0EM?=
 =?us-ascii?Q?llw5ATsAg103d95GgTLILSOvklPuzmyt+frOqsT7NEFE05SliW5CPaJMmUF6?=
 =?us-ascii?Q?qwF6aSMD4Z6EFd4BID2Gdpcjq3Exdkxqx7bXwto58ONKsc25AZ2Ek+NS0LIk?=
 =?us-ascii?Q?w/p0XvUyVaerPQbpqrOSt6kGdaWkyKrgxFuVpdKajh4bSd7ttVR2mDWcuV8n?=
 =?us-ascii?Q?niFLRl1W5L8SR5k4xC+oF2HFIvWJiHc+WtMzhXQntgn6yNkH6ZVxnKQB9kIy?=
 =?us-ascii?Q?kMzhF4Cx+zPxPmtdZTbkBJi3I6ajcbsREgZy1RwScgXHmsUT4usa9He/evnz?=
 =?us-ascii?Q?BaF8r5U+HgEozK7gtqoLMcZwfX8ruJJnm7uSU4fSqJhmNkFQV1Cx03XFC8iO?=
 =?us-ascii?Q?9ZNdvVyHEVnM7vtj57aQFtuarn0Gh/plru3jwQ8dHuvjVBDhYFACp28QvV6+?=
 =?us-ascii?Q?Jm2OuEcVC/FyVby4BoBOgYc85oA8WLazik1jOKu8S8vxOzQVcwg2dm/FzQcU?=
 =?us-ascii?Q?rx9TWrz7E/DbQuVoUosDYLo2XhVGkOUHdJYqNrLlCDNol3chJQPKXnjjlKbi?=
 =?us-ascii?Q?tVsZm70Gi4g/VcfwKuCcWHZYxzqB1Xh4IHjyR1FFauAOFYeB0sknrAtFkn7A?=
 =?us-ascii?Q?WX5cPrHShw2lse9HR7I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bb61d5-6810-460f-8421-08dcb7c54722
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 16:15:11.0396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbb6/27ItlDJS8GFgwcMXXYTjoeyQLy8fgFQ+Dq9HR1OIRmQJBxIvjHkDtJ9h7qTEqXiFYvm0t3JYP/BEnSqTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7037

On Thu, Aug 08, 2024 at 04:55:14PM +0100, Conor Dooley wrote:
> On Thu, Aug 08, 2024 at 11:51:34AM -0400, Frank Li wrote:
> > On Thu, Aug 08, 2024 at 04:34:32PM +0100, Conor Dooley wrote:
> > > On Thu, Aug 08, 2024 at 11:31:20AM -0400, Frank Li wrote:
> > > > The mass production lx2160 rev2 use designware PCIe Controller. Old Rev1
> > > > which use mobivel PCIe controller was not supported. Although uboot
> > > > fixup can change compatible string fsl,lx2160a-pcie to fsl,ls2088a-pcie
> > > > since 2019, it is quite confused and should correctly reflect hardware
> > > > status in fsl-lx2160a.dtsi.
> > >
> > > This does not begin to explain why removing the soc-specific compatible,
> > > and instead putting the compatible for another soc is the right fix.
> > > Come up with a new compatible for this device, that perhaps falls back
> > > to the ls2088a, but this change doesn't seem right to me.
> >
> > It can't fallback to fsl,ls2088a-pcie if fsl,lx2160a-pcie exist, which are
> > totally imcompatible between fsl,ls2088a-pcie and fsl,lx2160a-pcie.
> >
> > Previous dtb can work just because uboot dynamtic change fsl,lx2160a-pcie
> > to fsl,ls2088a-pcie when boot kernel.
> >
> > fsl,lx2160a-pcie should be removed because Rev1 have not mass productioned.
>
> Please re-read what I wrote. I said to come up with a new compatible for
> this device, not fall back from the existing fsl,lx2160a-pcie to
> fsl,ls2088a-pcie.

According to my understand, It needn't add new compatible string if nothing
difference. for example, it use fsl,vf610-i2c for all i2c without add
new soc-specific fsl,lx2160-i2c.

So far lx2160a-pcie is the same as ls2088a-pcie.

Frank

>
> Thanks,
> Conor.



