Return-Path: <linux-kernel+bounces-400158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4469C09B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31FBA1C23AF3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B1A212D21;
	Thu,  7 Nov 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mirxz8+I"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794AC210196;
	Thu,  7 Nov 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992225; cv=fail; b=gqRYaCLBVy+kYoYttxwtEyHAtDTD44cwrfiBeH7g/wFoKaOR/46Ojx5/+L509aK3bJ4d8fHS8272h/tJ+HYdgSRGWqqlVSnjN52tITF8yfz1GR6Imzt391a3lMYDj6SzQWi1jOBpZyDug/AxXI3qxoRVY88oKn/meV5XrL//D5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992225; c=relaxed/simple;
	bh=ifsXlbFs4UNCXWTPHOoIjOVn+hTh4S/PN1t/Lp0f/sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VRK0Budt1m5aNhIWZUtKPOjN45YZytHIIBA6ob2Pp/UgeNWvG/OV6oPDASOHSkHa4i7l3rC0dqTJ1COJ+hgbb528fGjvIVgONZ7TXDvwzXWb6cY0wMk9CAlio9hO1VbPvdU15GsDi1pE2vx0ScuFlWyMSQoBuAelvkPCeSilbSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mirxz8+I; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DG821RRxvqqHlyvAzCIEDZL6uwXRuM7w3Uc5PzCfaGBqIKZnRQ5ORxAEZKedKCjYP2C1wqAsNfGvLDOIx0ndSdl7FgAhbDD1oTpz+ogiYEvhjxNzly5+DNlcWPY3g5GZGNhUCuxb8WBIM7SR7QIEAh4+NY/0rG+LXiNKSpRHGUnfskBYgavTcXRGuf5i8uklhmfYu6Nc7JkyYvA0qJKD7Z1+cL9/+7h4xGOXlDHOMYrAZm3bWFxptcanFBKtYTvEOnwqcCcNtCETD3VOXJVFv2F+twdl+v6WdarMUz2K6OhJj99bEUSMJNFNkFy/lNxYeqD40bQ3HW1IkjUouPHmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+25wX4VyQVBtnN2SXAbpe1ec12iQcNDrCjIwmGUnQE=;
 b=q5GEXgIE6CGiQSnF+BMXHRUaVk9Z0ffpE9K2wdDEdQ4Ci/0XjGdZIhnFp+Ylfs1RnQeBeFwdlSF6mv5ExdPUvvk7pNgesRMWF6aNYPzcpP6M2B9cUOrECpPaXYx5xfbme70lIZ0yYYAwcjJFr5HabPd/HL69GPiEOthKkMZqOppWMFEUzoXBWqe2w072pR36KmzsGs0oNcZDz704OrgbtwBT2nf6sH8Z9C425vR+53ropn/KaX5L05Fbta1S4Owlz1XqTLhP4KkNjEYREj7IkvjBqwNznQgqBWjrwVsb+uENpx8VG80glBmfbMHACBW5+n/0zif2PG0pGx5XEPDtjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+25wX4VyQVBtnN2SXAbpe1ec12iQcNDrCjIwmGUnQE=;
 b=Mirxz8+Ivdot+cqtpKRijYZvtehlLSH97GTAAeP4Et+pibcM+HJ2N8+EpXVrMYu27m9oYiqNdfJn6PiXpAVFfF5Unw0CwkWig6814TOP8Fk2KOoOWkmJLd00GKyH3xfiglBI8bLU11Guxo4DbwR8B2xF70JKogRhH0GwgI4+8pbvauxoZoxTUwyypcV5FzPApLeANQ5+fntr76ze1hvt5gb92mkX5oJo94HLeLUdblhoeg15xjgUrOndfG+PSRH2hcdUk3IG57Rn1tG0GAUSIhNt6lJiAsleZTlR+56h0S3iL0s5HYbhPsAApTze03lcENfrdsVTd6VPq6r6LajD2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6780.eurprd04.prod.outlook.com (2603:10a6:10:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 15:10:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 15:10:19 +0000
Date: Thu, 7 Nov 2024 10:10:10 -0500
From: Frank Li <Frank.li@nxp.com>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, joao.goncalves@toradex.com,
	frieder.schrempf@kontron.de, marex@denx.de,
	hvilleneuve@dimonoff.com, peng.fan@nxp.com,
	alexander.stein@ew.tq-group.com, m.othacehe@gmail.com,
	mwalle@kernel.org, Max.Merchel@ew.tq-group.com,
	hiago.franco@toradex.com, tharvey@gateworks.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	ping.bai@nxp.com, ye.li@nxp.com, aisheng.dong@nxp.com
Subject: Re: [PATCH 3/3] arm64: dts: freescale: Add i.MX91 11x11 EVK basic
 support
Message-ID: <ZyzYUkBH8rH4bTZN@lizhi-Precision-Tower-5810>
References: <20241108022703.1877171-1-pengfei.li_1@nxp.com>
 <20241108022703.1877171-4-pengfei.li_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108022703.1877171-4-pengfei.li_1@nxp.com>
X-ClientProxiedBy: SA1P222CA0047.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e352e8-d17b-4769-c192-08dcff3e4a98
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?AjBo+c3a5s7rwGl3dOSt05isc4P7AAc3QNZlTQYXUt0ttEfyQ5eN8UIfI4Nu?=
 =?us-ascii?Q?JaH30vvnd1PmVSyPdcsKdkgq++6OMk/FUiAMPKQSdX6gyBTQW4VUhI/vqkWj?=
 =?us-ascii?Q?obfE6s8CYCwVHlF+8M7Ud388lTbHqTqsnMcOkwP+e/0DS6xlykSbEjzWQGpB?=
 =?us-ascii?Q?8NEMU5cEI917enEw2RFCPe1GOosvH74v6o02r1N5dvsojvMAQ5QL3qlZ3tO/?=
 =?us-ascii?Q?E1VpZD/pMqstF0FL7GEpgZA+HsJPVRCgWDFAkqmg40UQ9QXkXC5pkopU0ATP?=
 =?us-ascii?Q?zAE/kq9Lrsh0t6YMHYgd9/lo3rqOYcBWyrwbP0AWcfZzhmEvw3alrV12NHec?=
 =?us-ascii?Q?sweKkafAmIIB76XbSXGgQ22HjXhf2UpcXY5EmGbIZyqdgz+2sGASbszHA3KP?=
 =?us-ascii?Q?7Gz0qClBFxMZ9qVpWCuBCR7ZH86iR58MjQxGwEW+MeHsk3/B/6G+3q7s6Ypx?=
 =?us-ascii?Q?6pIPuC4dvmUW0AeqdeU9GNVwBln4EEGxe4EBlLEgG5aBYb9qHOWRFxB28nTN?=
 =?us-ascii?Q?StSGjc+ZTFOrjYe9PVkfouNWJgdsMizvJDW9/KhFruMsUiVEo8OTAEnQK+e8?=
 =?us-ascii?Q?jiuh1o6MFR/eUpeayuxS+3YHFKOztdDwH2A8EcQkwPbXwkWH2dIsKtS4AcDS?=
 =?us-ascii?Q?+S4i1SjjalJ8mFzpV7bHNdOk+9cT6LQll09nMYpAKgaxN1hMO1N34X3B6v1m?=
 =?us-ascii?Q?B9SfpITEEVuBrLjfGRq9JEpgNxXSDEo69xAO4Yygmd25ge7ehjyhxt9ocqHs?=
 =?us-ascii?Q?rM2SPDmtqYhF5cFJBP+LkP5BMEQW+zrxkHIx2/BkZNdEN/W6n/h6ekzrTVhz?=
 =?us-ascii?Q?zE2fl8gU03Twd1d0PMv0bioSp32LVAIBZAVKXwZmv65vengLeu0UPecckNS5?=
 =?us-ascii?Q?3Z54nGSVlyEjMjMzfcif8URUHJUyCTGetovdfrhriTXZHw0en3KAop+ti/sm?=
 =?us-ascii?Q?dZTGjnjcL0n84Whl/Ak7L6pZr2bB3yjzFZmV9NpPZmGCcgWaGXQjOZAtNNby?=
 =?us-ascii?Q?jnw7grZEIpzNLMVauMLw9qfGFqrZ3cg2REORdbkd19l+kB3inviwFh0GGbYo?=
 =?us-ascii?Q?ka9uGNMqc679FtoDCeOzD5FeuK9uBzXJJCvGrVyK0SYkbfabYe/siCaYh6xS?=
 =?us-ascii?Q?ZqdtZ7fpJGP0eI4eyulccdUURGtWUaPmgNiLFuSbdqUi+mXMdk4m1CbKTTjF?=
 =?us-ascii?Q?vxw9QhqzRvzJbE8r3JVr/cAFynFPDuGEqUuI4u6x0tbcBpgI6s1aCsK22Ee8?=
 =?us-ascii?Q?7OjOeUOIXR9HH67xSiLu+Y+wvr+HTg31UtT51I1mpiVhED0tZwGYJp8/jdbF?=
 =?us-ascii?Q?/iWvHcf5mUqel+ivch8g1IhK/4osgAG3Qx7wLNEvbplGmXG+rzj41qUe06tB?=
 =?us-ascii?Q?vMTrUX4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?xhE/5CQxW3VEEDQILiL2Cr3CSclz/t/HiC4SPYsWowo8FQGubxC6PMejVzpw?=
 =?us-ascii?Q?LTee5thbMSldiFWAX+HJB0LOYB7aIJivcvcnaX/b5vhjYMxia5cyhoIUX8UQ?=
 =?us-ascii?Q?J2O9U5sxQmgkXhM0I/0QTYd8tZqsNrtQr/MIacyps9ArqTsXPjsBqFhv21yU?=
 =?us-ascii?Q?ECj/ojz5AphIoFr1VEE/H2rQ7lg4QmAAdgBzAFaX9gYH+WLUeaw5vRtvddwY?=
 =?us-ascii?Q?sLkoLnkfS3Gmc+PKCiRLuNqDA6nzOPCE0dV3rtuOK/Dh4OKP6RFCB++sTN+5?=
 =?us-ascii?Q?d1PHEXlyIWApQ/0ZL/TbQLyFYTupw2O9oVrkmFvSmhdjmm1VM3LJvPQGYVQZ?=
 =?us-ascii?Q?ao4gNqFPFVMkr41f1usnaPaELU+meqB91+QnVr++fP6B0c5jKioVBnEbB8Yr?=
 =?us-ascii?Q?6CSUy3ORv1Mzxg0pmiCjIDig/hS9jkoc7Vqglb7KcNtKOAuOcYriRaLBuu5w?=
 =?us-ascii?Q?LcHP0J9wqt+wOzOH6L8Z2rUhHSe1Fll7sO4DSvd7FDxJ96OHlL9Z9Qj5Mciw?=
 =?us-ascii?Q?WJY29a3x27/MCPAMQrn9NBtX+8UKwXdsbazBeOcw3M6Wakgilfd4bxXOnjAF?=
 =?us-ascii?Q?WyUQ+L9N7Le+TXrJKA+sqIrrBUfqdHwRN2Ky2dt6/qIQ0EPdg+1o4HCcHqM2?=
 =?us-ascii?Q?jtyxxjpODVVpN+j9PYbv13JBafOjdhIarQHs5968uxOOJwLL4WtalWvjmsYD?=
 =?us-ascii?Q?dnKi2fcs0+aEnVZPjMWixeUtgaHvgml1DZGSu4yLqJHzTbx1WDQQFBTGDxbn?=
 =?us-ascii?Q?LhZ44BBjHHdVBfFiYUcpqNDiOyQNlqLrkRpoQAkTjVUV26mlKQ1nu1OlYzLf?=
 =?us-ascii?Q?inVC9UThWnsyJZCRm5RIJiVk9nuJjBv6/0M528kPTjSVjLJClqcrub+ipzpk?=
 =?us-ascii?Q?yZTPVNQRjaVElV+gCVfc08sJxf7CjWRYDoKTKuncFogOt5RBiAQ0vernMtHY?=
 =?us-ascii?Q?kr62KSI3e/raO6iRxAxL3+bAeYM0xzUXy9v+ifDuhf+mfO+CfGrWZAkORUFu?=
 =?us-ascii?Q?VQFC6SmJSm02vpF6SnQ6SyA2DOa6Yuu/K/KlcLivLMcd1IDoVxtaAecmpwxb?=
 =?us-ascii?Q?9x2kxU75PNIGrYXVkwljkK9hAQFCDL+Vcg1wlts/WLVHTVCz8vL6nbEPs3KQ?=
 =?us-ascii?Q?rTIudjwpz69sjeuh91Hmm363WLr83cT2/fBvIcTkHTLYaWoOPkrHf0PCjHBa?=
 =?us-ascii?Q?wGEIeSUAfGKbWE76ZDGSMarM5icbVSkZOhT50pM0tsvSMwZ/h59vqKBC0EAw?=
 =?us-ascii?Q?OPKiVSn8Wn3T8BlyRjLOkAtwzn+2ToAXXRMY7wRF1URx6fyzeVSccXCAd0cZ?=
 =?us-ascii?Q?u6EUaIG+rNGmM4KdvR+p/1b7gVuKU+Wvo44faKf/bIwtgW5nioyRFUzFjz8V?=
 =?us-ascii?Q?RbpaTBewZ2ameiVpjSUaRtbx2m3kPxgeSFJqBVExbqzKcmNKZ3F6qOWkH07/?=
 =?us-ascii?Q?h34T1RoMVf3XJCLgyfnUq9s+mPFL5BVzRD8rygRJHSCLLTrt6DUJM6csAruA?=
 =?us-ascii?Q?FMuV8rV+441fZvqvPHvNXOviblP1UCHSsiWnMYBJI206MHgX6/6owaCQyFWC?=
 =?us-ascii?Q?8pE3+stARRI8pOsm6Wk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e352e8-d17b-4769-c192-08dcff3e4a98
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 15:10:18.8492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5ida3tLOmXc4lwUz04R17IORmOsFA/L0BCWl1W9453AwsVc8W9/YFrFUCJ2682ay/yflNzWesS34WxZ2LNVLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6780

On Thu, Nov 07, 2024 at 06:27:03PM -0800, Pengfei Li wrote:
> Add i.MX91 11x11 EVK board support.
> - Enable ADC1.
> - Enable lpuart1 and lpuart5.
> - Enable network eqos and fec.
> - Enable I2C bus and children nodes under I2C bus.
> - Enable USB and related nodes.
> - Enable uSDHC1 and uSDHC2.
> - Enable MU1 and MU2.
> - Enable Watchdog3.
>
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Most part is the same as imx93-11x11-evk.dts, is possible to base on it
or use overlay file to overwrite iommux settings.

Frank

> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx91-11x11-evk.dts    | 820 ++++++++++++++++++
>  2 files changed, 821 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 42e6482a31cb..9174c9e215d5 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -256,6 +256,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-iris-v2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx91-11x11-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
>
>  imx93-9x9-qsb-i3c-dtbs += imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
> diff --git a/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
> new file mode 100644
> index 000000000000..c58dd4f1e745
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
> @@ -0,0 +1,820 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/usb/pd.h>
> +#include "imx91.dtsi"
> +
> +/ {
> +	model = "NXP i.MX91 11X11 EVK board";
> +	compatible = "fsl,imx91-11x11-evk", "fsl,imx91";
> +
> +	aliases {
> +		ethernet0 = &fec;
> +		ethernet1 = &eqos;
> +		rtc0 = &bbnsm_rtc;
> +	};
> +
> +	chosen {
> +		stdout-path = &lpuart1;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			alloc-ranges = <0 0x80000000 0 0x40000000>;
> +			size = <0 0x10000000>;
> +			linux,cma-default;
> +		};
> +	};
> +
> +	reg_vref_1v8: regulator-adc-vref {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vref_1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> +		regulator-name = "VSD_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		off-on-delay-us = <12000>;
> +		enable-active-high;
> +	};
> +
> +	reg_vdd_12v: regulator-vdd-12v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "reg_vdd_12v";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		gpio = <&pcal6524 14 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_vrpi_3v3: regulator-vrpi-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VRPI_3V3";
> +		gpio = <&pcal6524 2 GPIO_ACTIVE_HIGH>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		vin-supply = <&buck4>;
> +	};
> +
> +	reg_vrpi_5v: regulator-vrpi-5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VRPI_5V";
> +		gpio = <&pcal6524 8 GPIO_ACTIVE_HIGH>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +	};
> +
> +	reg_usdhc3_vmmc: regulator-usdhc3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "WLAN_EN";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&pcal6524 20 GPIO_ACTIVE_HIGH>;
> +		/*
> +		 * IW612 wifi chip needs more delay than other wifi chips to complete
> +		 * the host interface initialization after power up, otherwise the
> +		 * internal state of IW612 may be unstable, resulting in the failure of
> +		 * the SDIO3.0 switch voltage.
> +		 */
> +		startup-delay-us = <20000>;
> +		enable-active-high;
> +	};
> +};
> +
> +&adc1 {
> +	vref-supply = <&reg_vref_1v8>;
> +	status = "okay";
> +};
> +
> +&eqos {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_eqos>;
> +	pinctrl-1 = <&pinctrl_eqos_sleep>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy1>;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-frequency = <5000000>;
> +
> +		ethphy1: ethernet-phy@1 {
> +			reg = <1>;
> +			eee-broken-1000t;
> +		};
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_fec>;
> +	pinctrl-1 = <&pinctrl_fec_sleep>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy2>;
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-frequency = <5000000>;
> +
> +		ethphy2: ethernet-phy@2 {
> +			reg = <2>;
> +			eee-broken-1000t;
> +		};
> +	};
> +};
> +
> +&lpi2c2 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_lpi2c2>;
> +	pinctrl-1 = <&pinctrl_lpi2c2>;
> +	status = "okay";
> +
> +	pcal6524: gpio@22 {
> +		compatible = "nxp,pcal6524";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pcal6524>;
> +		reg = <0x22>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	pmic@25 {
> +		compatible = "nxp,pca9451a";
> +		reg = <0x25>;
> +		interrupt-parent = <&pcal6524>;
> +		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <650000>;
> +				regulator-max-microvolt = <2237500>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-name = "BUCK2";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <2187500>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck4: BUCK4{
> +				regulator-name = "BUCK4";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck5: BUCK5{
> +				regulator-name = "BUCK5";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-name = "BUCK6";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1600000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-name = "LDO4";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-name = "LDO5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +&lpi2c3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_lpi2c3>;
> +	pinctrl-1 = <&pinctrl_lpi2c3>;
> +	status = "okay";
> +
> +	ptn5110: tcpc@50 {
> +		compatible = "nxp,ptn5110", "tcpci";
> +		reg = <0x50>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +		status = "okay";
> +
> +		typec1_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			power-role = "dual";
> +			data-role = "dual";
> +			try-power-role = "sink";
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +				     PDO_VAR(5000, 20000, 3000)>;
> +			op-sink-microwatt = <15000000>;
> +			self-powered;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					typec1_dr_sw: endpoint {
> +						remote-endpoint = <&usb1_drd_sw>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	ptn5110_2: tcpc@51 {
> +		compatible = "nxp,ptn5110", "tcpci";
> +		reg = <0x51>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +		status = "okay";
> +
> +		typec2_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			power-role = "dual";
> +			data-role = "dual";
> +			try-power-role = "sink";
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +				     PDO_VAR(5000, 20000, 3000)>;
> +			op-sink-microwatt = <15000000>;
> +			self-powered;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					typec2_dr_sw: endpoint {
> +						remote-endpoint = <&usb2_drd_sw>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	pcf2131: rtc@53 {
> +			compatible = "nxp,pcf2131";
> +			reg = <0x53>;
> +			interrupt-parent = <&pcal6524>;
> +			interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +			status = "okay";
> +	};
> +};
> +
> +&lpuart1 { /* console */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&lpuart5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart5>;
> +	status = "okay";
> +};
> +
> +&mu1 {
> +	status = "okay";
> +};
> +
> +&mu2 {
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	dr_mode = "otg";
> +	hnp-disable;
> +	srp-disable;
> +	adp-disable;
> +	usb-role-switch;
> +	disable-over-current;
> +	samsung,picophy-pre-emp-curr-control = <3>;
> +	samsung,picophy-dc-vol-level-adjust = <7>;
> +	status = "okay";
> +
> +	port {
> +		usb1_drd_sw: endpoint {
> +			remote-endpoint = <&typec1_dr_sw>;
> +		};
> +	};
> +};
> +
> +&usbotg2 {
> +	dr_mode = "otg";
> +	hnp-disable;
> +	srp-disable;
> +	adp-disable;
> +	usb-role-switch;
> +	disable-over-current;
> +	samsung,picophy-pre-emp-curr-control = <3>;
> +	samsung,picophy-dc-vol-level-adjust = <7>;
> +	status = "okay";
> +
> +	port {
> +		usb2_drd_sw: endpoint {
> +			remote-endpoint = <&typec2_dr_sw>;
> +		};
> +	};
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
> +	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	bus-width = <4>;
> +	status = "okay";
> +	no-sdio;
> +	no-mmc;
> +};
> +
> +&wdog3 {
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_eqos: eqosgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET1_MDC__ENET1_MDC			0x57e
> +			MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
> +			MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
> +			MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
> +			MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
> +			MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
> +			MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC	0x5fe
> +			MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
> +			MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
> +			MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1			0x57e
> +			MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
> +			MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
> +			MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x5fe
> +			MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
> +		>;
> +	};
> +
> +	pinctrl_eqos_sleep: eqossleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET1_MDC__GPIO4_IO0				0x31e
> +			MX91_PAD_ENET1_MDIO__GPIO4_IO1				0x31e
> +			MX91_PAD_ENET1_RD0__GPIO4_IO10                          0x31e
> +			MX91_PAD_ENET1_RD1__GPIO4_IO11				0x31e
> +			MX91_PAD_ENET1_RD2__GPIO4_IO12				0x31e
> +			MX91_PAD_ENET1_RD3__GPIO4_IO13				0x31e
> +			MX91_PAD_ENET1_RXC__GPIO4_IO9                          0x31e
> +			MX91_PAD_ENET1_RX_CTL__GPIO4_IO8			0x31e
> +			MX91_PAD_ENET1_TD0__GPIO4_IO5                          0x31e
> +			MX91_PAD_ENET1_TD1__GPIO4_IO4                          0x31e
> +			MX91_PAD_ENET1_TD2__GPIO4_IO3				0x31e
> +			MX91_PAD_ENET1_TD3__GPIO4_IO3				0x31e
> +			MX91_PAD_ENET1_TXC__GPIO4_IO7                          0x31e
> +			MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                       0x31e
> +		>;
> +	};
> +
> +	pinctrl_fec: fecgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET2_MDC__ENET2_MDC			0x57e
> +			MX91_PAD_ENET2_MDIO__ENET2_MDIO			0x57e
> +			MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0		0x57e
> +			MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1		0x57e
> +			MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2		0x57e
> +			MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3		0x57e
> +			MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC		0x5fe
> +			MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL	0x57e
> +			MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0		0x57e
> +			MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1		0x57e
> +			MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2		0x57e
> +			MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3		0x57e
> +			MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC		0x5fe
> +			MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL	0x57e
> +		>;
> +	};
> +
> +	pinctrl_fec_sleep: fecsleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET2_MDC__GPIO4_IO14			0x51e
> +			MX91_PAD_ENET2_MDIO__GPIO4_IO15			0x51e
> +			MX91_PAD_ENET2_RD0__GPIO4_IO24			0x51e
> +			MX91_PAD_ENET2_RD1__GPIO4_IO25			0x51e
> +			MX91_PAD_ENET2_RD2__GPIO4_IO26			0x51e
> +			MX91_PAD_ENET2_RD3__GPIO4_IO27			0x51e
> +			MX91_PAD_ENET2_RXC__GPIO4_IO23                  0x51e
> +			MX91_PAD_ENET2_RX_CTL__GPIO4_IO22		0x51e
> +			MX91_PAD_ENET2_TD0__GPIO4_IO19			0x51e
> +			MX91_PAD_ENET2_TD1__GPIO4_IO18			0x51e
> +			MX91_PAD_ENET2_TD2__GPIO4_IO17			0x51e
> +			MX91_PAD_ENET2_TD3__GPIO4_IO16			0x51e
> +			MX91_PAD_ENET2_TXC__GPIO4_IO21                  0x51e
> +			MX91_PAD_ENET2_TX_CTL__GPIO4_IO20               0x51e
> +		>;
> +	};
> +
> +	pinctrl_flexcan2: flexcan2grp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO25__CAN2_TX	0x139e
> +			MX91_PAD_GPIO_IO27__CAN2_RX	0x139e
> +		>;
> +	};
> +	pinctrl_flexcan2_sleep: flexcan2sleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO25__GPIO2_IO25  0x31e
> +			MX91_PAD_GPIO_IO27__GPIO2_IO27	0x31e
> +		>;
> +	};
> +
> +	pinctrl_lcdif: lcdifgrp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO00__MEDIAMIX_DISP_CLK		0x31e
> +			MX91_PAD_GPIO_IO01__MEDIAMIX_DISP_DE		0x31e
> +			MX91_PAD_GPIO_IO02__MEDIAMIX_DISP_VSYNC		0x31e
> +			MX91_PAD_GPIO_IO03__MEDIAMIX_DISP_HSYNC		0x31e
> +			MX91_PAD_GPIO_IO04__MEDIAMIX_DISP_DATA0		0x31e
> +			MX91_PAD_GPIO_IO05__MEDIAMIX_DISP_DATA1		0x31e
> +			MX91_PAD_GPIO_IO06__MEDIAMIX_DISP_DATA2		0x31e
> +			MX91_PAD_GPIO_IO07__MEDIAMIX_DISP_DATA3		0x31e
> +			MX91_PAD_GPIO_IO08__MEDIAMIX_DISP_DATA4		0x31e
> +			MX91_PAD_GPIO_IO09__MEDIAMIX_DISP_DATA5		0x31e
> +			MX91_PAD_GPIO_IO10__MEDIAMIX_DISP_DATA6		0x31e
> +			MX91_PAD_GPIO_IO11__MEDIAMIX_DISP_DATA7		0x31e
> +			MX91_PAD_GPIO_IO12__MEDIAMIX_DISP_DATA8		0x31e
> +			MX91_PAD_GPIO_IO13__MEDIAMIX_DISP_DATA9		0x31e
> +			MX91_PAD_GPIO_IO14__MEDIAMIX_DISP_DATA10	0x31e
> +			MX91_PAD_GPIO_IO15__MEDIAMIX_DISP_DATA11	0x31e
> +			MX91_PAD_GPIO_IO16__MEDIAMIX_DISP_DATA12	0x31e
> +			MX91_PAD_GPIO_IO17__MEDIAMIX_DISP_DATA13	0x31e
> +			MX91_PAD_GPIO_IO18__MEDIAMIX_DISP_DATA14	0x31e
> +			MX91_PAD_GPIO_IO19__MEDIAMIX_DISP_DATA15	0x31e
> +			MX91_PAD_GPIO_IO20__MEDIAMIX_DISP_DATA16	0x31e
> +			MX91_PAD_GPIO_IO21__MEDIAMIX_DISP_DATA17	0x31e
> +			MX91_PAD_GPIO_IO27__GPIO2_IO27			0x31e
> +		>;
> +	};
> +
> +	pinctrl_lcdif_gpio: lcdifgpiogrp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO00__GPIO2_IO0			0x51e
> +			MX91_PAD_GPIO_IO01__GPIO2_IO1			0x51e
> +			MX91_PAD_GPIO_IO02__GPIO2_IO2			0x51e
> +			MX91_PAD_GPIO_IO03__GPIO2_IO3			0x51e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c1: lpi2c1grp {
> +		fsl,pins = <
> +			MX91_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
> +			MX91_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c2: lpi2c2grp {
> +		fsl,pins = <
> +			MX91_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
> +			MX91_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c3: lpi2c3grp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
> +			MX91_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_pcal6524: pcal6524grp {
> +		fsl,pins = <
> +			MX91_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX91_PAD_UART1_RXD__LPUART1_RX			0x31e
> +			MX91_PAD_UART1_TXD__LPUART1_TX			0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart5: uart5grp {
> +		fsl,pins = <
> +			MX91_PAD_DAP_TDO_TRACESWO__LPUART5_TX	0x31e
> +			MX91_PAD_DAP_TDI__LPUART5_RX		0x31e
> +			MX91_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B	0x31e
> +			MX91_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B	0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX91_PAD_SD1_CLK__USDHC1_CLK		0x1582
> +			MX91_PAD_SD1_CMD__USDHC1_CMD		0x1382
> +			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x1382
> +			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x1382
> +			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x1382
> +			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x1382
> +			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x1382
> +			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x1382
> +			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x1382
> +			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x1382
> +			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x1582
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD1_CLK__USDHC1_CLK		0x158e
> +			MX91_PAD_SD1_CMD__USDHC1_CMD		0x138e
> +			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x138e
> +			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x138e
> +			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x138e
> +			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x138e
> +			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x138e
> +			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x138e
> +			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x138e
> +			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x138e
> +			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x158e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD1_CLK__USDHC1_CLK		0x15fe
> +			MX91_PAD_SD1_CMD__USDHC1_CMD		0x13fe
> +			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
> +			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
> +			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
> +			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
> +			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
> +			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
> +			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
> +			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
> +			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_RESET_B__GPIO3_IO7	0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__USDHC2_CLK		0x1582
> +			MX91_PAD_SD2_CMD__USDHC2_CMD		0x1382
> +			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x1382
> +			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x1382
> +			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x1382
> +			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x1382
> +			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__USDHC2_CLK		0x158e
> +			MX91_PAD_SD2_CMD__USDHC2_CMD		0x138e
> +			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
> +			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
> +			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
> +			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x138e
> +			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__USDHC2_CLK		0x15fe
> +			MX91_PAD_SD2_CMD__USDHC2_CMD		0x13fe
> +			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
> +			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
> +			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
> +			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
> +			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_sleep: usdhc2sleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__GPIO3_IO1            0x51e
> +			MX91_PAD_SD2_CMD__GPIO3_IO2		0x51e
> +			MX91_PAD_SD2_DATA0__GPIO3_IO3		0x51e
> +			MX91_PAD_SD2_DATA1__GPIO3_IO4		0x51e
> +			MX91_PAD_SD2_DATA2__GPIO3_IO5		0x51e
> +			MX91_PAD_SD2_DATA3__GPIO3_IO6		0x51e
> +			MX91_PAD_SD2_VSELECT__GPIO3_IO19	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX91_PAD_SD3_CLK__USDHC3_CLK		0x1582
> +			MX91_PAD_SD3_CMD__USDHC3_CMD		0x1382
> +			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x1382
> +			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x1382
> +			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x1382
> +			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x1382
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD3_CLK__USDHC3_CLK		0x158e
> +			MX91_PAD_SD3_CMD__USDHC3_CMD		0x138e
> +			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x138e
> +			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x138e
> +			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x138e
> +			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x138e
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD3_CLK__USDHC3_CLK		0x15fe
> +			MX91_PAD_SD3_CMD__USDHC3_CMD		0x13fe
> +			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x13fe
> +			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x13fe
> +			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x13fe
> +			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x13fe
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_sleep: usdhc3sleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD3_CLK__GPIO3_IO20		0x31e
> +			MX91_PAD_SD3_CMD__GPIO3_IO21		0x31e
> +			MX91_PAD_SD3_DATA0__GPIO3_IO22		0x31e
> +			MX91_PAD_SD3_DATA1__GPIO3_IO23		0x31e
> +			MX91_PAD_SD3_DATA2__GPIO3_IO24		0x31e
> +			MX91_PAD_SD3_DATA3__GPIO3_IO25		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_wlan: usdhc3wlangrp {
> +		fsl,pins = <
> +			MX91_PAD_CCM_CLKO1__GPIO3_IO26		0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai1: sai1grp {
> +		fsl,pins = <
> +			MX91_PAD_SAI1_TXC__SAI1_TX_BCLK			0x31e
> +			MX91_PAD_SAI1_TXFS__SAI1_TX_SYNC		0x31e
> +			MX91_PAD_SAI1_TXD0__SAI1_TX_DATA0		0x31e
> +			MX91_PAD_SAI1_RXD0__SAI1_RX_DATA0		0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai1_sleep: sai1sleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_SAI1_TXC__GPIO1_IO12                   0x51e
> +			MX91_PAD_SAI1_TXFS__GPIO1_IO11			0x51e
> +			MX91_PAD_SAI1_TXD0__GPIO1_IO13			0x51e
> +			MX91_PAD_SAI1_RXD0__GPIO1_IO14			0x51e
> +		>;
> +	};
> +
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO26__SAI3_TX_SYNC		0x31e
> +			MX91_PAD_GPIO_IO16__SAI3_TX_BCLK		0x31e
> +			MX91_PAD_GPIO_IO17__SAI3_MCLK			0x31e
> +			MX91_PAD_GPIO_IO19__SAI3_TX_DATA0		0x31e
> +			MX91_PAD_GPIO_IO20__SAI3_RX_DATA0		0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai3_sleep: sai3sleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO26__GPIO2_IO26			0x51e
> +			MX91_PAD_GPIO_IO16__GPIO2_IO16			0x51e
> +			MX91_PAD_GPIO_IO17__GPIO2_IO17			0x51e
> +			MX91_PAD_GPIO_IO19__GPIO2_IO19			0x51e
> +			MX91_PAD_GPIO_IO20__GPIO2_IO20			0x51e
> +		>;
> +	};
> +
> +	pinctrl_pdm: pdmgrp {
> +		fsl,pins = <
> +			MX91_PAD_PDM_CLK__PDM_CLK			0x31e
> +			MX91_PAD_PDM_BIT_STREAM0__PDM_BIT_STREAM0	0x31e
> +			MX91_PAD_PDM_BIT_STREAM1__PDM_BIT_STREAM1	0x31e
> +		>;
> +	};
> +
> +	pinctrl_pdm_sleep: pdmsleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_PDM_CLK__GPIO1_IO8			0x31e
> +			MX91_PAD_PDM_BIT_STREAM0__GPIO1_IO9		0x31e
> +			MX91_PAD_PDM_BIT_STREAM1__GPIO1_IO10		0x31e
> +		>;
> +	};
> +
> +	pinctrl_spdif: spdifgrp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO22__SPDIF_IN		0x31e
> +			MX91_PAD_GPIO_IO23__SPDIF_OUT		0x31e
> +		>;
> +	};
> +
> +	pinctrl_spdif_sleep: spdifsleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO22__GPIO2_IO22		0x31e
> +			MX91_PAD_GPIO_IO23__GPIO2_IO23		0x31e
> +		>;
> +	};
> +};
> --
> 2.34.1
>

