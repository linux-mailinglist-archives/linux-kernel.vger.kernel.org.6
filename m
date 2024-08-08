Return-Path: <linux-kernel+bounces-279798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7634D94C201
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F13F28557B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB11190068;
	Thu,  8 Aug 2024 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jJUwBHTy"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010055.outbound.protection.outlook.com [52.101.69.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B76719146C;
	Thu,  8 Aug 2024 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132309; cv=fail; b=ty0xkGVmVT5cAGzRs8bZu+UoROXpPog4RAxlA8iIe4dL+X7VHm/FNIMFoHkwXsk74+M1wK7g9UL8IFdOOjUx5eHeYZ+kfhzPIUG+pXBslzExeqvI2ef6phdYKLLLAGKs9eNIcrQjoRN7U7ZCAj+D2k+VRXvNYOxOzV6NKnWo8q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132309; c=relaxed/simple;
	bh=xvtO/WaH5vk/NX16rDK6N4gg3y6Pntl2XAehOa/dfdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CYaGqlQJdOUxIOfyFLRWeFbuqSuUEao4xJWLUuDU0fSdyp/EZLriAtYBgqCrG6F9lVNhBCEVKfua636lZIOQxRFtl/RGky0jwjS+/KxTtT/OPykNLdnmC/89Qs96HdDPaezQpSQjrRfzDPwMOP8kHcRFqzmeWdQS23Y1+H60nag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jJUwBHTy; arc=fail smtp.client-ip=52.101.69.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4grbEI2sBhRyhFj7QdVnDg5HoE7rR+9VOA/RYHJayJ3nzoIINrAhDSbtsbHQMhFHH47SFGiBbcZRUVllSQK7hnHwpsyLKptEoI4lNty5AjzwrZ+Hi/8hvPnBShcRSd09KjPW+0a2HUkClfurkaD2pa6rHuToqrNQ/GhN6EUo3OeKNPLBoI2i+oNEULQpI32EAKjBiYq+5tLqEOz1K72GzTGCOi1Us4Ho9hfYtnwZisshP9SWoDKxT6VYeWVKNjxcDeOIvk0OFcBwatwG0o1JwxIDTBlsx8PpLIjP07wl/l0M15pT7wuOicyUhsSy5OjlBkvzdaXj1N587xyCmUF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvtO/WaH5vk/NX16rDK6N4gg3y6Pntl2XAehOa/dfdA=;
 b=sEGQdLlzU7vXDxdxRgB6lZgyPHMNt8XCSjBals8Yq8Uj6Qad6v06vB3/GRdcDN+APd4iGAMF34P1bMwvqVmIUJnDrJhFDK4GicvnqFArt+ia2Gq2ERh50z9lj8w6INyv2NrBMQdDmFOgZb7neO/IzPtceaDbBChJ+gzGM3PVjPy8v/J0TwBffGvCka1ygwfh/RyP1H3//5nig/RQYUmnBrSef6qtW1+hB5PmFdmxXpQSxFsoyg5LNZteWuT4b9nXb9BYMjXdnHiXTGiTm6AlwgF7+bVnkCirM3sPFi3fsRU/DaoYCe0dXLcdF2+9Zijro4D4DfgVoThbKJFX3oDfuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvtO/WaH5vk/NX16rDK6N4gg3y6Pntl2XAehOa/dfdA=;
 b=jJUwBHTyoEjWrLmJaeSfHBo0aHBikZUkLap4oAh/bk9cfqnSyJ2DiWx3r+VY2opQYpoOuz+noOtHtPXIbIampDy20jOMJbECvEVmgI3GrPGwASbKXBcRK4KWCn/uQ9/x++yH8dh9r9HSzvj5+fbDWHPaLRtMB3A1QtbkvvPWzL5fhJca0tW9xflBiPLGwPPf63GXOsRfACqCF7EGKZIAAto3fc97LqrgEnwJgJvwIsNubBwBtrktKZb3YmAu08R8XvFfz/9fyh8jrI3aN+mJag0vmLiAv95iNX2zoZqt5GioTv+umB5fCiG6qbp6VAhFvLy2zE4HsSJ7sIFSGBN5WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10406.eurprd04.prod.outlook.com (2603:10a6:150:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 15:51:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 15:51:42 +0000
Date: Thu, 8 Aug 2024 11:51:34 -0400
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
Message-ID: <ZrTphsdTZVsbiGo/@lizhi-Precision-Tower-5810>
References: <20240808153120.3305203-1-Frank.Li@nxp.com>
 <20240808-frosted-voicing-883f4f728527@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808-frosted-voicing-883f4f728527@spud>
X-ClientProxiedBy: SJ0PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10406:EE_
X-MS-Office365-Filtering-Correlation-Id: d0956c62-e089-4356-9cb2-08dcb7c1ffa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CRUsTWuV8i1lX9TYCewJFAYn63OrS1SeJmChlJ4LA0vNMte7owObatTscLli?=
 =?us-ascii?Q?9RAwt4+z5d5yCZ2by1ioUdiGzeg6eoppvrVE7RaYmEa4HcZMdLWDaeavPkhw?=
 =?us-ascii?Q?E3wSB2ynUTtq0q5vY+tqBA0CEdRDjo1Wy/4AfZah5JFbnPcDflhIhArG4QjZ?=
 =?us-ascii?Q?eSfXwlTXi65PFxbxYLUts1dTjAiIE60TgkLWWvsgDr1hACEUAnrKuZxKVVVL?=
 =?us-ascii?Q?Ir5OSC0WdYGm3QQc9kRsG9mZh5KwJLSjUBBvghnhUsLhwmp+SQAgKwbkJoLO?=
 =?us-ascii?Q?UekQOB8JUMkYMn+0d+w+a066s1vPjqO8fIauFrCVNWTfzGHxy7qrao4V4coR?=
 =?us-ascii?Q?okG9JNCRn7KPa3w5Xw+zrfAlNQQImiQLwcwPSVTyvVygwp2g6aF4z372roaJ?=
 =?us-ascii?Q?3QA1Jx/hPb13+UvvT78iyXLMrkUxpprex7cROHOzAWMudhpHLBOOSUhmvzeT?=
 =?us-ascii?Q?yu3LGyxz3H2WynLJZyQeCdmtLvym9PTmGGv0mpowWP7PsBv68CjuI3bog4cZ?=
 =?us-ascii?Q?uD9grjAykn76DM+kxpq7PHztGLwFT6s2+x7qpUW90Dx9jHBMUHGb10AVGkyf?=
 =?us-ascii?Q?DB3ShA376Gagfd4XnBnyLLhPA97kKPlvgHo3HBrpD8FBT4G9oJ1WTgow/Oqh?=
 =?us-ascii?Q?crhfH7/rs8JvaWYA0kFX/TEtw3wBHjV4dAg2Zss85IHVXdRWu92EPC9GBOXc?=
 =?us-ascii?Q?Gqkeyn9sz7taaxXfWL3d6+ZWgGozu8Ly7DAAPzvENeDUXh50kMPxiqpSZAXQ?=
 =?us-ascii?Q?KUwk62Fuv/c88IhCKOusNSzoDDUtJOIRXJvvT37vSD1yKGHYi+xFYCcE2DSB?=
 =?us-ascii?Q?Y0HIsrwzxFE2hpjrRIy73QHxYClVGcxjtNSIYsXSXX1iZj/EpDGdJQv6G6Or?=
 =?us-ascii?Q?sdfef1EmnIE0TjpE3nLm3+/5biaKdy6MSsU2K4fzcKCAlZgDcII9pyAiPtPy?=
 =?us-ascii?Q?9BGHFfhhBLwuOiWcp7FueBi4q0JoR2Q+P0VvHjwfLjeGmIKsOzN9dm3f+pJg?=
 =?us-ascii?Q?HhoEv1TbBSoEQc+X7+4Q5qyjPMyevrG/BwsoHUn09wt3jEnMkz5uIXMplxXu?=
 =?us-ascii?Q?oauOlpJkrbyhr/BXeSXFg5VDDTV5nurNMd0ooJCPXObSG01xE9y4NZeNfvJ9?=
 =?us-ascii?Q?p5JQscdqyllFgRojR3poMhk6YgEkzFQDRdFqZ8NDnpyVIT0kolH+0csa8kw/?=
 =?us-ascii?Q?AuluIqKPranS6pG4PgCpkqSMEeIwmadhBpdUBl6szrNZiiK114GGV2NItmjp?=
 =?us-ascii?Q?DdT2VBMgALeE7ht+8RCDFbDIhmIIcZ8es1fdI4nYW2DmUnY0WbGvovsU/ZJy?=
 =?us-ascii?Q?OvADtEYrl9JbCrXoYekoNw943RThInpkxOiShey8tqRbOmp6Kphtx017T+xb?=
 =?us-ascii?Q?atIUdFSUxa1h/zUVFNY8vUWXwh1GiXC3sogdMSWrgiXVGQFukQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q42eCTDamntNcy7pTcq6EtZDVKGKkhIAqmui94008qrvUF5x0xKt1KyZiPuH?=
 =?us-ascii?Q?fAFzwpuuQ93CmYocoSBfP3TrFxdUKSWbzmPuGycCKf3bOl91rdYg9ElajJ7d?=
 =?us-ascii?Q?ZBFAwebirUfWg9p3MvxMifzonny0Z5kB8v7JvewJRBT4Uxmmz6xmoOaQ19Qx?=
 =?us-ascii?Q?mqQ5ON1DRt43PoB87A4vFQ58bW381cY51vXYr//9jCD9JogRdsEaYI8keTDe?=
 =?us-ascii?Q?KA2sH2rYYmNS5zDL1p7Eh+d9MDm9YQMSIdLCoiZPhunpP4Fv8oGgZyDTfvAs?=
 =?us-ascii?Q?B2J+du+nbtPpjv19KANuN4utCGpVnuB/c2kqtSse0tHRFTYBccJiylawwEBF?=
 =?us-ascii?Q?IeV9/0bchm6L3HyF0x4uuXGHZzVtQGK5C6uoH/FcFumQxI4L4TlQG2x3PUc+?=
 =?us-ascii?Q?5M3p8rg1luO05bPQVRUcuI345ABf8o45qsqHmSpm9rX0vNc2pMfEcJLIujT4?=
 =?us-ascii?Q?aBHo+jncpTg7r0pWLeLizGiI8gWEjJMHQV85pf5OocU22nujnLRaN5UKGnAp?=
 =?us-ascii?Q?IzjmqoY6VlniLSM9WPAii+srQ7tHIRonWyLhc2Mun7DW5iP7RN/+1Sys0llD?=
 =?us-ascii?Q?ewSW1UXP6ZV3J3UocDFXBKmWChlQ8vJR/y9GDvDPWW3Ep9twHWQmKDFRCSGl?=
 =?us-ascii?Q?v0f2jyXCLf6K1M4pXvjvo/kGFleBvDXpPHXHUWAJQE0nDY4MKx8zN3eGfwxp?=
 =?us-ascii?Q?ku8bEkI8YdwKbyUT31OeEZGfm7IRnxIOX4B7/bceJZVypUb8wYo5x/XDejOs?=
 =?us-ascii?Q?2TD6f7muRyCiMcC5qRDbXwv78sDoclYUvAHusiwJuKlF1/UMHjCQM6pDBGEO?=
 =?us-ascii?Q?EJ3Coi70EqfqlekUYajHnPq81yyZmT48xj5OpqvXGUV0I3Clb8HIM4dqStEs?=
 =?us-ascii?Q?KYVfgPyeI9HSu7tCv3FYv0qIUCnOT9WBcmkdb5WJbgTMef6fSvtseia5t5w+?=
 =?us-ascii?Q?roxsd1D0ULCJv0Hizx43M+/eCkAVizEo3/CqTTVArApH3O+v8q045NFArV6f?=
 =?us-ascii?Q?EPJSZrF5N/EC5Qb7R/Zo/UNE9Qo6/KL1LiugOrzFDDVomA0t/SclkEZx7dfb?=
 =?us-ascii?Q?1bkb0iA5QDNhLZt95grBJZX6ljriCv6lwUEG6C8AaRo6iZdkpGFOUwdM7apw?=
 =?us-ascii?Q?YB3DGOK6KExE0g+FcHH4ZarC30l7fTaWCtIweFkAxLAZY/IRv1WKicJCUQbC?=
 =?us-ascii?Q?847XqFyFktQg+PTIJDvFWL7ioSu/Gq98XnP36HAH1FVkOP64+PIT9hTa7wv3?=
 =?us-ascii?Q?EsnDH+pseyS9CSnP9NbcOvfSYy/4YzEmQf2Sd3gQamxAOe4eHIN4eeDSeak1?=
 =?us-ascii?Q?+CMs4YP0fyElCIHSojv13fULSg2TqY6PSsJ2ZzrIDWsvacd1Mz1p4qIfUTLr?=
 =?us-ascii?Q?xozCPeqn/+HlqiB9q0Rm2siB9pZqX3NhcNFw6p6aKxmPzxt4fnPtht40hCCJ?=
 =?us-ascii?Q?LjNLfnrF7XC6KPXmxi/lskBWXvWgPSZnaOG8ZFF83TprHR9zSo58ZOWEdmrr?=
 =?us-ascii?Q?HyO9q1jFcBetoda3iuxMs4pgVGDldXN5GHacEpMLMKAzp7ZDpqaxusSDWgno?=
 =?us-ascii?Q?TSLnjqLe+h7ANnIsBQkrvZ/mXRS+lb93OpHwOqvw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0956c62-e089-4356-9cb2-08dcb7c1ffa2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 15:51:42.6534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZLt82lTPU9nB5tR2cU6D7VehooFfXFpNxTET5TGl+WS0lfdrH8yFCvk1SdLIsQNQ3opOaJMVEsYKTBgUnWk+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10406

On Thu, Aug 08, 2024 at 04:34:32PM +0100, Conor Dooley wrote:
> On Thu, Aug 08, 2024 at 11:31:20AM -0400, Frank Li wrote:
> > The mass production lx2160 rev2 use designware PCIe Controller. Old Rev1
> > which use mobivel PCIe controller was not supported. Although uboot
> > fixup can change compatible string fsl,lx2160a-pcie to fsl,ls2088a-pcie
> > since 2019, it is quite confused and should correctly reflect hardware
> > status in fsl-lx2160a.dtsi.
>
> This does not begin to explain why removing the soc-specific compatible,
> and instead putting the compatible for another soc is the right fix.
> Come up with a new compatible for this device, that perhaps falls back
> to the ls2088a, but this change doesn't seem right to me.

It can't fallback to fsl,ls2088a-pcie if fsl,lx2160a-pcie exist, which are
totally imcompatible between fsl,ls2088a-pcie and fsl,lx2160a-pcie.

Previous dtb can work just because uboot dynamtic change fsl,lx2160a-pcie
to fsl,ls2088a-pcie when boot kernel.

fsl,lx2160a-pcie should be removed because Rev1 have not mass productioned.

Frank
>
>
> Cheers,
> Conor.



