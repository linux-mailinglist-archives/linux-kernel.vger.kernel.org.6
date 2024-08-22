Return-Path: <linux-kernel+bounces-296428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8AD95AAED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB141F23462
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4815417C8B;
	Thu, 22 Aug 2024 02:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BB90ab9S"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D471CD0C;
	Thu, 22 Aug 2024 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724293348; cv=fail; b=Ue4eoeqOjcw3AP1KjYZ8UnyQT4IcE/0i4ZSU89q0k40/0GrZMS1h5CXW15oV2IKdG4PYUXDPd6OzgUSirrzQOztXFgRy6kRLmmZ01yTAKIEztqqu20/FeMvhWr7Ogyy8Pdb4vuVCYG9hCnSHvvAEwrY+eU1kc41dx/HltPz1YMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724293348; c=relaxed/simple;
	bh=qEFJyTuY6FAyPfMrB9E5hoqyoUxN7DP//+0eXzb2xsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=av2AcBy5TnGk+fZDquUF/F36yKQv7Ce2EQkupp8z3muI/UkRRlNnDAInEAA2oGZAG0J8KPGdGcGoAcRnoF86FwnG89WBpiTzHHKxreO8NKVMSMfb4l9MS7DFofVV/hXb+Izk/h3XLJs8G4wFp2SZLm83pHb6cYlTKs+hXKhrM2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BB90ab9S; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IilxbFo99H5iD7o990fJYyn1IX0qrAQAyAg0IM9BlMTFm1Dt4I9BMDplWQXUB2hB1AUHzlhqQ6LhPOewdacRship1EmTAvGt3gn8/998gGTiioZhHbezNeu8VcELRoYLtjljdZPUDJrZk2mMFQpq2sAlMn2ChaYeUurdUOC8aBeMFnb85YAMZNZJP1isFiiCvl/BSS6/U8OpWgKb+sqrPu7u8vCLlXnCgZgIL+mXAm0azZbRBvT81bT0u6Y8xH9xzJrhsHrzbQLSmQyhntjMyP9qgdEy0l/4GKPznXXbssQECoO3HWGMGdX0jwLuV/Tjmma7m0kEqr5/XYoWe0iu9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXWilJfpHOckFmGixWIdHC98B0FAWAJn6NHQr09wFJ4=;
 b=uIxxTLD4U3wpYrtJo3ha4qE2tYcr8fNxXHdR9C4Zrdncgx24bcmX+ru7DjSZyMllZ7Tfznq31iBVZe7kRgWsHv2y6a9RnhXN51QAAdkyOt2P/4xhOZ1QgR3CheFWGuoVWx9n48kDQ8FXgXy/IcPWsBQhQWzTy7pqP1nJFJLF2DVMrVkasgFRI3iUFiRIGyDbvSgwO8/f/lVzeI2teX/c7TCEDRKYNbL3AmKOZlnreGUdFdy5a8oTrpwttGhJmBVb8frc9ueuDrquNhteZkHjts9XNOHgKDYQGad5FX0AENqnluU8KtD6AO8W36re4ZsXokcRuNIM0TMasITDy013kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXWilJfpHOckFmGixWIdHC98B0FAWAJn6NHQr09wFJ4=;
 b=BB90ab9S3HgjpvVg8ukgPNxv8ydHHZj4Rg8qeC4D5HY1ZgkH8/ehSltaAppXJ9nnFGf9jYi4hYw7Vk1HI2G5y0cnUtuTkqFjYXoauc2YYXVWAv3g+LFbFIHJv0hmfl0tvNpSS1ZhDHvqUTH6lobIJfr6Yw3ttzfT5B4/ZCK1wQsy8I/ZJ3pxunAWyfO8php97VnkYA5VTUmvDx8BVpuZIY0UQZBuC9ooh2oBcn2hOQNjWuX2bFatQDPYZ+lj972GtfUBkqVp8o3WC6bw6s2nMZvyOsgv59vBDfvvHWDArxWEopVmhNWOgQQvz5/wakpQ0hhU4hrXiVDpyUwnx5FMlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB11011.eurprd04.prod.outlook.com (2603:10a6:102:480::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 02:22:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 02:22:23 +0000
Date: Wed, 21 Aug 2024 22:22:15 -0400
From: Frank Li <Frank.li@nxp.com>
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Teresa Remmet <t.remmet@phytec.de>, upstream@lists.phytec.de,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8mp-phyboard-pollux-rdk: Add support
 for PCIe
Message-ID: <Zsag13yYrqoQF1oI@lizhi-Precision-Tower-5810>
References: <20240821-wip-bhahn-add_pcie_support-v2-1-9c92d8488ab2@phytec.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821-wip-bhahn-add_pcie_support-v2-1-9c92d8488ab2@phytec.de>
X-ClientProxiedBy: BY5PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB11011:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ba0112-ca38-4488-00fd-08dcc25141ae
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?lkmLq2vwzTKQCyHXkyFqh1Pd6nXeDn1heW703W4sI8vdZw4UfxmKxjtxCsJh?=
 =?us-ascii?Q?AI4Gx4xLRSyfLUUbBDWzxLcoJnOEF7jDoL153qO9DH997cM8rLlT76HPGUvW?=
 =?us-ascii?Q?g2nHDoPILzmWM2d65IeHodzyiZmdkFwXvT3z2OIxLdUigNlzw0DHdalYBBqa?=
 =?us-ascii?Q?g5lsSMYpR+TTG90MQf/digyC9LoNOVIDhWyyOaJWKJxOddJBpCoP5pSTsHwt?=
 =?us-ascii?Q?/UgfKTdo++e55/Ro+dCW/07eXzXMlueKpuaKDD+yxXtO7bKYSYewwcjfWUeG?=
 =?us-ascii?Q?SC+HpQl2u4lkdBcGMkg/jERbmzr1c9uB0D6SHKWjrSnI8z0onhQTmVJ/lGM2?=
 =?us-ascii?Q?JjoQxk1L7rAw1NAZI/5BpSen5yuChXGkNon7g7oOXgJEtRm9dHxq2fAijxB9?=
 =?us-ascii?Q?3TLYNsd4b8NjND/Hk5AAINj/FEEndKVd0Nyiqd+dS1dnrn76Hon/vtIaj1CX?=
 =?us-ascii?Q?nNrnNBcecdNuBEw93DODskZ7e+3u0l+bOV0RQe7t3A64ZSlxSFhn38iaVCup?=
 =?us-ascii?Q?RzX0RGpHEHh3+8xFq6Evx3pfznTB8sFnPNpu2/tyxFbVZd/0f/bYZGQmIcDd?=
 =?us-ascii?Q?JT7GPk8F1y6TCU77Ue4b7G3tBT2Ush5l+uEv3GnSjZF62UiIgqMeJD06Cz5p?=
 =?us-ascii?Q?sw6TMAh/tmlsPDWrcBwJoozWS2bnc8V9vv9mWp+WSCRxGnpInhnk+JIQw3pH?=
 =?us-ascii?Q?lH07CNevBkPZBIa/UEvv6kqyRP9m/QTCZo5SeWIaz0xuzUAX6cttR0e8u8KT?=
 =?us-ascii?Q?rNWSAeRwpNlTT0M63Q6UiFoqQ65jig3jINfO8qlXD0gb/meLopriY06b0sgF?=
 =?us-ascii?Q?+szKGOQVpCL2Bebvzxat+qwmiElTkHYkr6u9ohcuPQjDzbytrre/wKlNlchr?=
 =?us-ascii?Q?u2LoTIqsQ+5iYLa3LZ2arPyeSD2bu6oTZKhpQIVjRDo3BuJ6S8zGHfMVoRc/?=
 =?us-ascii?Q?H+o2g0QWgzOCI27TXIVazIk2xIGfz62YIf3qL85CmfCfreAdDOEUIfbaMiPg?=
 =?us-ascii?Q?f6ENeQ0iGBdz+MU/Ar2HZiWU2cld51gWWgxYLUQLdiOuXQb00yN83cZdAv78?=
 =?us-ascii?Q?URcKNhmNh87FR6t5Pyrh3u6jZOyxkeOS0gPYsQO2l39lekpmGOUY2i5uDRi3?=
 =?us-ascii?Q?S4MMHqMKrVWx0V6hf2pxSMJDHB+Zf8YfnoWdyGtraOpM9415q/ulR6DH3hNR?=
 =?us-ascii?Q?barXVBLuUl6gWOJ79sOQWCemEJ0mzmPCKpQKRBYhtC7f7Qietg4UqSQcvr2H?=
 =?us-ascii?Q?jNYIlmgjxVYVEovGB0/eDKSl86RG4FXuQQX0TUnFxBWEmwIpODvxby2eDPiZ?=
 =?us-ascii?Q?wT/ziUT9yLUuZZjjdsUnjTndoh1vah2Xeot0TFE2EFzz0/qaLKHw4TPDnPbq?=
 =?us-ascii?Q?iii28u7XnJGu38oeYjfJ2ixb45DfXIFdudGXMdT47lasJnzeAg=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Kse2QXg2SAjXjV8niqZgFdwWSFuGS/QOfEt9yy2L61t9FDaR3x55vGg9uoQo?=
 =?us-ascii?Q?gbp4B7XwfslussrXLJDshIQXwAmHwhlE8qAsJpl6hXV4hLWLWXFFTnNRU2Y0?=
 =?us-ascii?Q?w4gM6Q2BdlRIZqh0PoVtJMF/dbLIMc8MmZ8JFst+GfjWZjiga0QiE20+WoKJ?=
 =?us-ascii?Q?UZ1jbc9lW6BAOszsQN2FS7sQPSojIf+DTLBBE7NDqeeX+MtHQmJWl4mon4/3?=
 =?us-ascii?Q?x7pJhMcH0S/bALMr1MAamP+6NqvxHBS6kBWC73a2M9gMfnKmUYDLvvctkTHd?=
 =?us-ascii?Q?xI9DGzKX3n3spvCuM//RTT8MBSLM1VfpzxL1VL5d5h7hc9C1vqsVUvVhbA5a?=
 =?us-ascii?Q?LqSonC//DvHv9ZJ/wbRNZY6rhP/Q2FKKUhWBPR1u2TRL0Z6z8SVB7dZ3Cyi+?=
 =?us-ascii?Q?hPiEp8teONWzsm6crXtWl+XRU4IuVIhCd3nPtdNzVeqDq5QLG6TEmaeYxNBG?=
 =?us-ascii?Q?PXbzAqGHLyg2AzpN1I0sSW+3h07D6I/9hgSZSo0MCL7DrlFlu6bZUnPGw+EB?=
 =?us-ascii?Q?ZNJflba4iKT/YpOO8so18BHTmxkdqb9lT1B0oGFVwoSOnr/3h8Q77xkQH4jr?=
 =?us-ascii?Q?nyUlFm/inqCC05zu+B4TtcFQQbCZo42wlomY2dpGRt5gphnhCjReVFC/EoJr?=
 =?us-ascii?Q?ivJtBlLAvyVTPYgRoT8q/ojDR+clYe2gW6g5wzAdS0N74qECQ4TXHTARvBtO?=
 =?us-ascii?Q?eoy/SKy3nEFoZ6bGaIfsMDpJAoVvRtTE9hlfojwCxaSs5F8qoDxwC4WQArY+?=
 =?us-ascii?Q?GK+qwP8tUEw1wgzs3dyX9vVatbipC/gVF42vtK55LQAuVLHdrTLF/qiFXSbd?=
 =?us-ascii?Q?jhJv8LFtT+TyLvMILsuqM+kH/85Ts4jyVsPZDJTYGG/4X2pYc78L8djSz8Px?=
 =?us-ascii?Q?vSeJr9zvtsaeldfAr1JMzG2MH3BYHP23+k0F29VHJqz/a4JAg5fNDxwgQLqS?=
 =?us-ascii?Q?IFFOSUckyx0HU+jVF4MdEQwDRmNAR/o53i+C0tuRZ7Knxyp8wn9gvFDW4z7W?=
 =?us-ascii?Q?HAmUOaxGYhuWc0svNHm5EYC7/Fggw1DRwlIOqv58qd8Xn+rDj2tSRv7NTlzj?=
 =?us-ascii?Q?xP0S1tTpmHaghNGADoTD1s7+Rugd2Ii6/OAZjlNt2Wc1RXrYU8h0JrlON0CU?=
 =?us-ascii?Q?rU4MhV3zw+qZoUWojybMhZTIS1O1+0clZtCAQCvCcAnQmYcJIgcqFDZ30mcb?=
 =?us-ascii?Q?TlYLN+NE/yaAh4i7SM5V9aKO4Yjt52ncJXLeWHnJJYNHlBnmRj3LcBQ+SLm5?=
 =?us-ascii?Q?g0VHzUjvVC5Qx3E3cwdlXasm1CiFfqmfizsJ+iQJUuYB/sxfsj+yQBacehwP?=
 =?us-ascii?Q?iT9PecfJvrJAkXfAJ0P7ymEIB0SIU8dOIoA9fVJp7OSRKQribAsZp9F5NBiy?=
 =?us-ascii?Q?WOnlu6Agweim+7z9hGgnldLOXBFxy7e0sxxcPtkUkqTc6xLa5jaCvk46X5as?=
 =?us-ascii?Q?TTNiwsGONKYnRbGW0OoET/szbwOrpU0cX26C+FjyRUgFqJztn7SQyasiSf8g?=
 =?us-ascii?Q?NG5eTEuo7pMZ9LHaqxWtKYVGWbV+OqRMhNQlkA+J02PIhI//IuOzi/MySDKo?=
 =?us-ascii?Q?Qen1vuIxff5RK51ZKSJ875jFlnPXDhwdo8SrEH/e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ba0112-ca38-4488-00fd-08dcc25141ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 02:22:23.1157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8B1AqnF0S/v87FZTMtvreRQ77fItXwcMMfOvK1106LfxPfjF2tL+yNlD6OAoDxS/oOHSjcvvdeeor5nSdjObA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11011

On Wed, Aug 21, 2024 at 05:23:45PM +0200, Benjamin Hahn wrote:
> Add support for the Mini PCIe slot.
>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
> ---
> Changes in v2:
> - change pcie regulator to reg_vcc_3v3_sw
> - add wake gpio to pcie pinctrl and order the gpios
> - Link to v1: https://lore.kernel.org/r/20240813-wip-bhahn-add_pcie_support-v1-1-c1bb062b4e1f@phytec.de
> ---
>  .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> index 00a240484c25..b50b04dca2b2 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> @@ -6,6 +6,7 @@
>
>  /dts-v1/;
>
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
>  #include <dt-bindings/leds/leds-pca9532.h>
>  #include <dt-bindings/pwm/pwm.h>
>  #include "imx8mp-phycore-som.dtsi"
> @@ -195,6 +196,23 @@ &snvs_pwrkey {
>  	status = "okay";
>  };
>
> +&pcie_phy {
> +	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
> +	fsl,clkreq-unsupported;

vendor property should be after common property. So move fsl* between
clock-names and status.

Frank

> +	clocks = <&hsio_blk_ctrl>;
> +	clock-names = "ref";
> +	status = "okay";
> +};
> +
> +/* Mini PCIe */
> +&pcie {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie0>;
> +	reset-gpio = <&gpio1 8 GPIO_ACTIVE_LOW>;
> +	vpcie-supply = <&reg_vcc_3v3_sw>;
> +	status = "okay";
> +};
> +
>  &pwm3 {
>  	status = "okay";
>  	pinctrl-names = "default";
> @@ -366,6 +384,15 @@ MX8MP_IOMUXC_SD2_WP__GPIO2_IO20		0x12
>  		>;
>  	};
>
> +	pinctrl_pcie0: pcie0grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO08__GPIO1_IO08     0x40
> +			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10     0x60
> +			MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11	0x60 /* open drain, pull up */
> +			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14     0x40
> +		>;
> +	};
> +
>  	pinctrl_pwm3: pwm3grp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_SPDIF_TX__PWM3_OUT		0x12
>
> ---
> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
> change-id: 20240813-wip-bhahn-add_pcie_support-b9bd75fc4d98
>
> Best regards,
> --
> Benjamin Hahn <B.Hahn@phytec.de>
>

