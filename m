Return-Path: <linux-kernel+bounces-350660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C809907E5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EA51F25110
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C5B21B421;
	Fri,  4 Oct 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="izym0GRK"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012022.outbound.protection.outlook.com [52.101.66.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9002E1C3040;
	Fri,  4 Oct 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056208; cv=fail; b=dg7f9iyBcaCWtT0sZi9nPry2Z1mNvtFuDiDOTogTooxMIhLO6+sFd9cIXWmDZFur8mQAGIHT6hSRCTxiiaB+tvPRjfJVDicTcmyO2Q8XANqfJCL4p0laX5PK2Ony5eG3QJUXTNRy7YHFnRfmyMgV94wG26Ui6xxWSVqY0hyhplU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056208; c=relaxed/simple;
	bh=r6BvrRMImv5bwKprdqoqRN4sHKK6VKYk5kTQ9se6mXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XOTWalGqUSceHZtGrNgnq2/nr9TYy8XtJZJRwtCrom/6tZBjA8h0dkVN0HPol7cQXZ50WbXJuLR6xY4aRv9UDL4fgqvVMBhJGMKLNsCDVHxg/cPbDsUTh7on7w/SAPgMTJyNcEojnqCQgxgZc+Sn/lkCmNLehiTQsRmCKP7Z7Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=izym0GRK; arc=fail smtp.client-ip=52.101.66.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJ/Ccuy5etaeVOZfON30cZKOeNfmm1YmEaaFraT7+AoiqdSTedQn24zDI5Pu0x3K2uBjHseOgl4kRkM3/OjLeuJjzpladYgyM/gnJ98OzzEFd8fTNXXNXe5FvviPyaAadFOBYcXi4FfkxMBWCLhPXT44MEonY60dRKiQYyQCkaw0pfLVwVZCzdtPPtrdd38si9pBWKVoBiMieLj92JacD7uHTtXCRgl2u3oLomzq+Qh/KnnAzwcFOW+sDvex8YwiLSUpAAfJGOh0zZrdE5S0kdcSHC7M4v6N+XJLO3PIM0vJvEgoJG48y21eJXlFNzCSt/EnWTQAtbRF/yGAQSshlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEYC3YPqVqFVv2MTJfKw6vNuxP5rm717Bcg6US2iYZE=;
 b=MyiHrdVEaUVWUNdNwVjQw7x61gm+7VSGT3Ps5jsGT8rP12NsAJxO1zHDbBNnbO1Qth7fw8c6YNri8XjaJDsClAgCNmtEQw+RAWoLMzoFZPBLUtuXOxxq2AnOAAgptbTuzYAYZAiw8NF971cgUODScpxIIqNKOO6H7EAXJl9yY8fXwCp2zIJ9ZFNCd3zrX+EY7rj+QKcUN/Mo1Nh0u1GIUPE5sBUNwTUEBddwMO4gXr3ifGJ+V9pT0bT8qn2DDQCRxXefQiNHXzgDm278t0a4FWh0YSrNXwridke6HN4QCO9/kPVcCDB+UKhR7a6Ybmd8N/CKf27QlCwKMIHMAMj9OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEYC3YPqVqFVv2MTJfKw6vNuxP5rm717Bcg6US2iYZE=;
 b=izym0GRKe04ciESJJYQG2PrWgDa8VBpBKgOxEAO1CG38NAgd+rURHogg1arXr4qRJJkj/DTLvjuAZtTx8zxTLqW/fGrPkwRWLtzFcdwIAdiuAgilADuNGlw2c0qX/3s5KNAChOk+SWE3zYInoXQnStX4uTBCNpRveXE4+tyS14HSCi0FjCprB4sVz/2weJho5P2yhKxLd2blaJpAM3wm6ZL6fOCx963Y5lxmequd9UbHicVoSstErcJLZ/H6LTVo8nSTsaYCgQxmxfJWs6kGU78t9vR1off295Nt1meSzmfEw0yhubDpVb0hMVmULGex2jrf4cHxWZTxfJo/ClQX/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB10747.eurprd04.prod.outlook.com (2603:10a6:102:48a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 15:36:37 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 15:36:37 +0000
Date: Fri, 4 Oct 2024 11:36:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: interrupt-controller: fsl,ls-extirq:
 workaround wrong interrupt-map number
Message-ID: <ZwALfcJYTOuXqPuP@lizhi-Precision-Tower-5810>
References: <20241003214315.638668-1-Frank.Li@nxp.com>
 <gre52gkd325yfnjwoqyfot4yrb3rim4pi2ye3hjcp4bd7yimba@tq2drzuwlc6f>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gre52gkd325yfnjwoqyfot4yrb3rim4pi2ye3hjcp4bd7yimba@tq2drzuwlc6f>
X-ClientProxiedBy: BY5PR16CA0008.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::21) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB10747:EE_
X-MS-Office365-Filtering-Correlation-Id: 53246040-9954-4034-b4a7-08dce48a55ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?14icp139CN+tn1zzbvnLnplh8fNYlbHMKOn4vkob5NwVj9ZcObF2Ilfxv681?=
 =?us-ascii?Q?ur5j76ZVatBP/DdvHlbKBpGOrBJUv48QhdxdHu7BxX6utGXrJ0HLgpIJ6anX?=
 =?us-ascii?Q?NCliSurugrgntsh40gn1qfwamf4sSyQWW7w6gB3OzJgn8KjHxF2UsKC8J0Nv?=
 =?us-ascii?Q?Zf9reH/VXpPyF6Yvia1ZudB6ZwpV9hGbFM5xVBdgrhraVjKNVrgv6uIS7zOO?=
 =?us-ascii?Q?RgoJJsfWidSGzSYLrNHyvCgqnSans+y5h+955ySYNGf2pwBxkhizbJ4+q9cC?=
 =?us-ascii?Q?+Lo7EDr/NXLlxocxVZ5i+lQsEcYjm63HE24oj1CCzEo8aeRKJC4Cme6qzMQB?=
 =?us-ascii?Q?AacpkIEYm9renadxNF6ZmmhUMHqO4G7eaPaO/fvxuTcksGOOUu31Hh4ZRhUX?=
 =?us-ascii?Q?sCOGz4QunAnlJZ2QlfAyftnryeYk015SR5jnf5OLoDZpxMSfs08eReVczcWc?=
 =?us-ascii?Q?OxJRLSimeQ8g0sX8m6rRjtcOWGjWBBGEpL1rkvC29Tzz6quqt1pkNZP+ejfz?=
 =?us-ascii?Q?CtH4K6Ekgw9tsvfbGb9BNC3dhBwLF6AeSi8Ci9LdCX8qxRbdgWyN2epnEVFp?=
 =?us-ascii?Q?XRsR3c49ib3piatiljf+zUCRR9NBRTBmAvV8WbpIoiPXmmZvyWwTAC2ZNVE+?=
 =?us-ascii?Q?ePQ8tm3Opmh9oTrlyQLkE4R2lPrsRhC2K36eY7Sm22G/upzvWrwlzGQ2Awft?=
 =?us-ascii?Q?/yOaGFf0Hq4MF8ex747j1ebZVSE7RHzi+MrFCVRlXVvhZa1sj2PqPGGLkOzM?=
 =?us-ascii?Q?+8Lz7SSdlwr7+npLESea4MpGD0GgSelMXS6Ml/PhCnoN4nD5RAMpK95hZyrb?=
 =?us-ascii?Q?A3G80kz5ohyGisxdLWY+BwrLA70sYYtXfqEJPGZ++XPAN3eQz/xmb4VYXlUk?=
 =?us-ascii?Q?du+lJ0cZbAVQgRS6wTkKnHy7QHlVrQ5JNeXROwafkQN05ioWuSMSwfP7uOca?=
 =?us-ascii?Q?GyVwsTyazBXrTfDPNLPcK7CTkoiFlGXdBYaC+VgS667fkucTWCwYK1OOX1QP?=
 =?us-ascii?Q?XdtRCBb3f40o6h9p4MvDx4fBpkwgYdVTiuWQxY7UBp5QLA1+hp0X93H6ibxj?=
 =?us-ascii?Q?QhdCn08qmsEAdJkvrlLWTO0/xdFSRXj8rO/6BZDn1vUVzA2NmekJkb9BSbOJ?=
 =?us-ascii?Q?8s4IgAqfM17OHkSHSqPLS5ZSE4WEKOSnj6e+BSSKVTwh48qMb+0Hbn5Cbtge?=
 =?us-ascii?Q?a1MjJ1fNVRUtzYd/lcJIcWYhdt2HL5WKYrI/4bKFltAORQCUvi2cDs9JFDGQ?=
 =?us-ascii?Q?Bx3QQNhQAHa0178m+hHk85YMX8kujPfkMSa+7DFzsTzJxe5L4HrSzkcDgiHe?=
 =?us-ascii?Q?s9Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/aVm/5JwqOpqdPvnq+PZaKYokr7TQOuUqSP2Qfv+tW7ErJhE9uDQufbXp9Qf?=
 =?us-ascii?Q?B3D6oS4yCwZUvZWcvUfPUYkQmYrfDTIO+Wj6tZeBrVelAnVp7HkI783BlRDx?=
 =?us-ascii?Q?CUxAivLr18DgSSzeuPQaMUpLValm0QHFvZyRfm0aK1rF0ACnqCJqt8P3kHgy?=
 =?us-ascii?Q?8BVFDUWGKBB1oSPMVRsZeBMor9D7WNegRlbbmdxHewvP/cVS8au6pWzdOmHC?=
 =?us-ascii?Q?ofd5zOeFZ5mQQVrqDiBxiY55lBTEbfNrSRjy9zMqgxZq1nHFtjUcPyOGWyEg?=
 =?us-ascii?Q?yKDLq/PO8u5UvlJQ3mYEyztZriTD2DmNE4n/6WgKYuQ9iydbeuiILcxzgbQ4?=
 =?us-ascii?Q?cJQFtXEI4NgJ/MUavYMAXE1Nn2dU/i+tufxM6Akl9zwt0v+GDagrwGxSurIa?=
 =?us-ascii?Q?o+YVujSnEn2k/w0+m1YDE1bBWU7yCll17p8Ep6RDslYgoOTAwbtGzI30g6KT?=
 =?us-ascii?Q?S46VNzLll5KDasW9ErZersK+r/dV1ZrLdvYJtNvGMH7osPID/DAKePIMscFN?=
 =?us-ascii?Q?aaPV/cS8lNt7KZQbDs0a+LjvyQQqVoJ2cQV7SMc0jvkOMa1RCDbMd85xXQgQ?=
 =?us-ascii?Q?XtFmWC4sV0PZWPZpIy9uC6PGOsI0s3E27yH35cHZuvbOwSkQB4DkZSzmLloT?=
 =?us-ascii?Q?mblBRK9JPcAwNnpwv8I51Oy8ys956CFZ37CmUWchuP7M5/08PyWpWeETnYkA?=
 =?us-ascii?Q?oJMtwWUBa2AbUOutEwGVWw32n/us7wxkx2MYHqVpDgmkorE/JJOaU5lkSWHU?=
 =?us-ascii?Q?v6TEELazngxl+wuNfjkl5sa1t8dDfPLWgp5cnpB+ZHAILjulHuSuVo/zIPvZ?=
 =?us-ascii?Q?hDv7zkNyzGpIzvQ29DAOdZmKMDUmuBeHtc+3CP5qtyEq4lMGQrW8pjBcIGpk?=
 =?us-ascii?Q?O6JK7IQRvUviENbqIeonL9P9Wsy3fTvvRAhdQZxx/KPnB2W+GBNjf4YdtCOI?=
 =?us-ascii?Q?DzvR+dZV621ZqvVXrzjgB898DIy/AlO81p1pAivTV0DAowI9MHXDYJ3U0Avn?=
 =?us-ascii?Q?DO+nsh0Ov4r0P6yjmjQw6TpNbikryETmD0KExrQQvoOAmxMpTgcG0KY2/KCS?=
 =?us-ascii?Q?syis+LSZfd2/IMpU77suOhVRxdosyOI131aRUSUvMCCPSFO1gymJb/LMecGS?=
 =?us-ascii?Q?JPYB4CPQ5ryKlhLlLka6pkNO+eD1BNTCEX1ge76ANSr3tMQVUR5ZkKBD1YKH?=
 =?us-ascii?Q?xWoKN7HM6mXgK/D67NAEfwHBdtV9xXlZszJCbtDkqed99HCMvVpKqe7djpcJ?=
 =?us-ascii?Q?8y/3k7KJU9YqvgdbUnlyhwRh9flTRu8Ce4NtlTwj3HbXeqesa93cgtaFj3ZM?=
 =?us-ascii?Q?nFhNGRQxE1tFnhNG8vAWXLRvk3Jdo6z8f07MIacJyObt3klcd4Sxe+OARVdE?=
 =?us-ascii?Q?0TZN3jNMrJSfSOFgVXzXRUU0GHGzY8EXG/SlZChUyQrmpSHI2IWKUXSNIo34?=
 =?us-ascii?Q?eNbLaaJim55EnDzY8/fL15Lb0F/TGx4bCdMNor50jO9RkaxUyq3mPch5S05a?=
 =?us-ascii?Q?opEMwfbRgePVpNF7sRJE4byQ4antkZp0kJhskZotAAOM/iD1FJhmX+sDhPi6?=
 =?us-ascii?Q?0uEp/lX2vnPHWuj5l+k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53246040-9954-4034-b4a7-08dce48a55ac
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 15:36:37.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIuvwttNwKxeC+HD3WnH23GzqpXPhJpUh/8kVAld0Q37nCRc2P51tBAkej8qMd3PUgMNDzGpwhxjHejZo75erQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10747

On Fri, Oct 04, 2024 at 08:43:23AM +0200, Krzysztof Kozlowski wrote:
> On Thu, Oct 03, 2024 at 05:43:15PM -0400, Frank Li wrote:
> > The driver(drivers/irqchip/irq-ls-extirq.c) have not use standard DT
> > function to parser interrupt-map. So it doesn't consider '#address-size'
> > in parent interrupt controller, such as GIC.
> >
> > When dt-binding verify interrupt-map, item data matrix is spitted at
> > incorrect position. So cause below warning:
> >
> > arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: interrupt-controller@14:
> > interrupt-map: [[0, 0, 1, 0, 0, 4, 1, 0], [1, 0, 1, 4, 2, 0, 1, 0], ...
> > is too short
> >
> > Reduce minItems and maxItems to workaround this warning for
> > 'fsl,ls1088a-extirq', 'fsl,ls2080a-extirq' and fsl,lx2160a-extirq.
> > Other keep the same restriction.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v1 to v2
> > - remove duplicate function in commit message
> > - only reduce miniItems for after 1088a chips
> > - maxItems change to 9. Otherwise report too long.
> > ---
> >  .../interrupt-controller/fsl,ls-extirq.yaml   | 27 +++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
> > index 199b34fdbefc4..1bfced6ed620c 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
> > @@ -82,14 +82,37 @@ allOf:
> >              enum:
> >                - fsl,ls1043a-extirq
> >                - fsl,ls1046a-extirq
> > +    then:
> > +      properties:
> > +        interrupt-map:
> > +          minItems: 12
> > +          maxItems: 12
> > +        interrupt-map-mask:
> > +          items:
> > +            - const: 0xf
> > +            - const: 0
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> >                - fsl,ls1088a-extirq
> >                - fsl,ls2080a-extirq
> >                - fsl,lx2160a-extirq
> > +# The driver(drivers/irqchip/irq-ls-extirq.c) have not use standard DT
> > +# function function to parser interrupt-map. So it doesn't consider
>
> Same issue as last time, double function.
>
> Please run scripts/checkpatch.pl and fix reported warnings. Then please
> run 'scripts/checkpatch.pl --strict' and (probably) fix more warnings.
> Some warnings can be ignored, especially from --strict run, but the code
> here looks like it needs a fix. Feel free to get in touch if the warning
> is not clear.

Thanks, I forget add --strict this time.

>
>
> > +# '#address-size' in parent interrupt controller, such as GIC.
> > +#
> > +# When dt-binding verify interrupt-map, item data matrix is spitted at
> > +# incorrect position. Reduce minItems and maxItems to workaround this
> > +# problem.
> > +
> >      then:
> >        properties:
> >          interrupt-map:
> > -          minItems: 12
> > -          maxItems: 12
> > +          minItems: 8
> > +          maxItems: 9
>
> Are you sure it works? I see 12 items in fsl-ls1088a.dtsi.

interrupt-map =
   <0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
   <1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
   ...
   <11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;

Total 12*6 = 72 data.

Normal each row should be 6 data.

but when GIC have #address-size, <2>,  dt-schemal split at at (6+2=8).

"interrupt-map: [[0, 0, 1, 0, 0, 4, 1, 0], [1, 0, 1, 4, 2, 0, 1, 0]"

So 72/8 = 9, I just realize it can divide to whole number.  so minItems
can be set 9 also.

>
> What's more, I do not see your errors/warnings at all.

I using below command

pip3 install git+https://github.com/devicetree-org/dt-schema.git@main
...
Resolved https://github.com/devicetree-org/dt-schema.git to commit 0934678abc36614cd3c5165ca49ba78b881ee2fa

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8 CHECK_DTBS=y  fsl-ls1088a-qds.dtb

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8 CHECK_DTBS=y  fsl-ls1088a-qds.dtb
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC [C] arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb
arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: syscon@1f70000: interrupt-controller@14:interrupt-map: [[0, 0, 1, 0, 0, 4, 1, 0], [1, 0, 1, 4, 2, 0, 1, 0], [2, 4, 3, 0, 1, 0, 3, 4], [4, 0, 1, 0, 4, 4, 5, 0], [1, 0, 5, 4, 6, 0, 1, 0], [6, 4, 7, 0, 1, 0, 7, 4], [8, 0, 1, 0, 8, 4, 9, 0], [1, 0, 9, 4, 10, 0, 1, 0], [10, 4, 11, 0, 1, 0, 11, 4]] is too short
	from schema $id: http://devicetree.org/schemas/soc/fsl/fsl,layerscape-scfg.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: interrupt-controller@14: interrupt-map: [[0, 0, 1, 0, 0, 4, 1, 0], [1, 0, 1, 4, 2, 0, 1, 0], [2, 4, 3, 0, 1, 0, 3, 4], [4, 0, 1, 0, 4, 4, 5, 0], [1, 0, 5, 4, 6, 0, 1, 0], [6, 4, 7, 0, 1, 0, 7, 4], [8, 0, 1, 0, 8, 4, 9, 0], [1, 0, 9, 4, 10, 0, 1, 0], [10, 4, 11, 0, 1, 0, 11, 4]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/fsl,ls-extirq.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: fsl-mc@80c000000: msi-parent:0: [16, 0] is too long
	from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#

Frank

>
> Best regards,
> Krzysztof
>

