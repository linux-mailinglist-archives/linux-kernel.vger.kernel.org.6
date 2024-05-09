Return-Path: <linux-kernel+bounces-174095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3698C0A34
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E038D1C20FA9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125AC147C9F;
	Thu,  9 May 2024 03:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MwEVhFIG"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D080D26D;
	Thu,  9 May 2024 03:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715225823; cv=fail; b=Elp40ORb+NCp2fULQ5Uhob/O1MFTH9ixnzNRN7zvLaoKh64t2RIcbS2/zHZQwbSYonc5IPfKtAmZOmjw+LeYlD5g0Qt14KmUFIC8sSwIfK4IyHkJGiV9U4DiYh9MWhw/e41dJM8GXCjKpT90AfKHtfAFEoOiGPtRupet1ShXMsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715225823; c=relaxed/simple;
	bh=CMMiFv+tFWyAUaXXCCBKDCOdTMvP0EKuR4IQBcAYTZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nVj/hamIWXuVjYNa0ecT+rHlayrMkdGpJS00KxdHtqnMa1yaevMOE/xG9NNKoNH+I/I06AcoYwcHH/zp9L+w4vCQuoKul3SneFOeqCSYzpJpqgL9pK/oZ1aDjidM4Mz7G5O72mXGuBFz+yDs89ajFKLZLHraQzZW+bUPf2yBX4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MwEVhFIG; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVSeagLm+wvjggQpe8JpFFAzngqwD+v/l8H+oF5EEBAfhZHor7bqxsKUziho+3GPwZIXAfgh5n+R7RK3MgWtsAc/zs6PtDruFcNGr/PW3dAvYq9c88MR2m3WIhuff2R46Aus9mCztsIzfVLIR3no3NqSrwe1DqYeZoJIJgbPEqdEIz0e5p0JYbMoWHVwcRKNcDUdSMYfe87alCAePCl2oi/gHyVdJHm/6Y6rbIEtGOMd9h5Y+HriI5mVK5nIy+k8VZnLV480FgruzeS4hIoeBz766LvRP/NkJ6opxJFfFFcSR6QDLQycckooJbdEwp00zGJhaQuLiTe5BQahTmWnnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dd4PSbQSWg1irPQRfJWXWC3DUwULrI3KJivBWNY04eQ=;
 b=nVeSa24b+R61JEL+WfvM/KfZlaZ7JU3+A+iHM0hg6ZsA9v0ESi6rIE+OqRTqpWsxMO0rXlr9jsvZATHwEkJTJkdmSJHYexMPjwHBhgs6W11TeRTWlaCuFCrYKm6s3ye/Q3DoPMGmud6zR8htygn1V7Rp9HaxQTZLxSQhufDAH90WcpBucv2n1GCO4ZFWXNXZEaliEzvWfUdRD9zQJYUzch7YNpuqz41Bl/LqnCETsaGwfw0XAHz3vGpzy8IJd7Hk+BYPewcNj848Z7rH88bvApr7Plycszp6FBUeCJig2JkD2xG3/71b2uwxTA1fNWHJeyDU975wjpKzHfJHG9o1gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dd4PSbQSWg1irPQRfJWXWC3DUwULrI3KJivBWNY04eQ=;
 b=MwEVhFIGxRuvcSDd5sCYTiGR6RX+cIwSDsES5F9jbigLO2+P86/LMVaZMtcUy5qWtT4Vaz32g1IpgrVr1evPsLIRgeZc/pd3YO7SHEuAAOq8kedtZa0jg90r69J/94rZvm6EcFMVx3rhwxb2fO1mH5G9h+vCL15ba0uDQ0uNlJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB9213.eurprd04.prod.outlook.com (2603:10a6:150:28::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 03:36:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 03:36:58 +0000
Date: Wed, 8 May 2024 23:36:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx93-11x11-evk: reoder lpi2c2 and lpi2c3
 label
Message-ID: <ZjxE0AWyFo5KL39A@lizhi-Precision-Tower-5810>
References: <20240509015709.3668405-1-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509015709.3668405-1-joy.zou@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:a03:333::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d3d173-0b35-4eca-aa1b-08dc6fd94781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|1800799015|7416005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T9Jj8lWIsptLKBEBy9Z9o0L/5aMFrIOjkDlfHyZKL70uIEWgzC+ShJ12hqpU?=
 =?us-ascii?Q?lhFmv/JSikJlzN511NOVEencOe9VHPAA4wL4a+eFFH1QoK2VUYMK4ekDrFQV?=
 =?us-ascii?Q?dX2fQh3d7cxU/R1AOszgrBL0oUT9TF2GFKL1jOT/ha5XYB6f2IGGRo2dDLdM?=
 =?us-ascii?Q?zVIQmbOVqM6ilU5T5DnKMXM0Ifniv3S5Q9V9khfZ0JmB0WyCcqmBiNWBzrB6?=
 =?us-ascii?Q?B0h7qLZ6U34980mJwtql1hTzgjHs4UbZELQFcY3STrC14W5D6xLr89F9c+qw?=
 =?us-ascii?Q?YdfWzon7YfQDCmUsmaW3RIvmkg2d0vmi+AYBRAZNiawdaJDquw+5orfULqWE?=
 =?us-ascii?Q?qZmhyoDGmgLZkmLxSqtWkAG/VTCT9Iaow3+L+C3amQJuxacwbMfP/vBULBAY?=
 =?us-ascii?Q?m1aAcnDcX5r4xHWqY1ciIt0SlECB3ohAypnrTcqesB1n3iWcvKKhWb9XlByu?=
 =?us-ascii?Q?9oD1ayL50iBPMEmsuSu6KiPy1T6jO+UNOmnTUijPm/u/vPVmUbXU59xowegc?=
 =?us-ascii?Q?tC4i6OqI10QLurh+p2dD/tCTzzK2TFXSjVgl0WaloAFyFx2pq/6vDaeAfiZm?=
 =?us-ascii?Q?3VTGwHrRVu6HbY0x13AZ3GM6yldx2M6CpWFsPsyBh2s4h+pOWCZ3VugBW3Th?=
 =?us-ascii?Q?+m40JN27VwUTfICxkagH1n1c1Za/dM5WJXysLlenDScGxJfhLa9SDs4E29No?=
 =?us-ascii?Q?53m/XwTBiFYwE2G8S7Gx7wKdzyRQhk6Vk2dWfJmS56wUDW8oVrIWB9lcIxnT?=
 =?us-ascii?Q?9Shdy2Vfaeoe0NQq4Az7OA0KPiMIrcXM4m1SrUp8fPi+0Ur5bQzMRrYhaKk7?=
 =?us-ascii?Q?jnH/b+Z3n0qh/ncl/iXyhovPgN+IRCCEs3Z+BS5dDb3D+a2fqoH1s6Op55B+?=
 =?us-ascii?Q?Fatyn3AbVCxZGmdI0kOSTfHcPZqcwAA2nI3g/8QyWAsqqGUWDUTMgVyNgFhC?=
 =?us-ascii?Q?5cE9O6mCbpP7wMyfGWQ42DAHGFpbQGny8jHUqMltlCoRAqP2A1R4iNoU1C1G?=
 =?us-ascii?Q?/LsyajxkQvZFF4OJ5n58rez7qbA/7tk3b3o4Cf6A9m1UTsrbCm2S0twaQSHF?=
 =?us-ascii?Q?UtVp0W6Bbz5TVeCeB2k7mmYTaelTG5TIyLmyV1h0iZNTDd7ThcCOR5oV1NqH?=
 =?us-ascii?Q?QxkKYzOzk7DBxwJxgmHolEprgs2bv7hZgDbs5pDQ9BVA6SkU3gk/ddivpywV?=
 =?us-ascii?Q?EoE8TbbLU8UZLu2ihsFwPCWwDITJPG3aFcpzMdflvlwzGwTYFnRf3MRZD3f8?=
 =?us-ascii?Q?bg/4LZ8s90pGAvcI3fhFuD2ommjb4NgCX6OrABln7qZZGqxzpEOoTtQKRja8?=
 =?us-ascii?Q?PdjAiuTgnOmH5FYLeLrV7/bnP9WEk8SNCRC6posZcjBn+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F1qg+9z/Ch2EMpOLwCJzV0OJJcULnlnCyEWgzLeFd3mqeV+CJIHECRziyM1F?=
 =?us-ascii?Q?laPGG2dOUx8lhdFjYQOquaR3zrDNbE2VmTpcXFGuRafPrGPaOikZKsJT6OPa?=
 =?us-ascii?Q?hdNaN3yo0mVBCDy0bYrYWkzsIwdyGFHyRY6aRf4bGgDofhTanMc1fvtCx2i+?=
 =?us-ascii?Q?gqZUqlmoZtztP8LMLcF/rWxrsBIXdQe+E0LBNnebk21av9swFAYnCq+50yQ+?=
 =?us-ascii?Q?5c7h2h+vmLWnamWhYKJP3rn9IIezKeDeeMHzeqwQauGS4z9m3GlnZ+Rjo3cx?=
 =?us-ascii?Q?jK5mVSEP6Pi8GPOE6yrTMedRhtr6U+347zQQwkdlmDtLgcRRd8+++Ev0fU50?=
 =?us-ascii?Q?YOmQyQ+VR+R63DmzhBGjc9PlSzZT18Jj08Wdc0mFMVGuzW3cwBiN2gH8QZVY?=
 =?us-ascii?Q?fb4+lU492ayHoobp94ZmxiEtb6ihtziWGpnft8Y9QnyNRk/ow7GgbS7vfOet?=
 =?us-ascii?Q?ZE+uAaWqVhI1VQOCkEVVb06VYgIx3+MqLYd4hW/kmtFwXj7PHJcAX08nyw5f?=
 =?us-ascii?Q?Q+QNGWGw1TDvjQ8uxXswAABeSB+jWAxx9uVJXpAizu/ehQZJej6RdtO8fuy9?=
 =?us-ascii?Q?Z8LVxsTrkTc+zUzDwCV560N+Ig+GzHqx1STeA5UsgeE/g9CFiWEOR7mzzQ6Q?=
 =?us-ascii?Q?B6OuVqGZpmhTtE2FQ0bJ6zd6ZZHXmjrjzWoat1ePAZ6Zzxk1lpL4zwi1mAYd?=
 =?us-ascii?Q?yh0hKZ9YZ0E2lZ0T6+BNwF9cdYLL0GfVuLxES0MJ1cUKoef2MF0uPLfx7nfS?=
 =?us-ascii?Q?UjZOD5NrnPwxzGGhjWkYe2IYYqEvUzqKyk93fNvq6xNCPzVu8MuEOGm7inFY?=
 =?us-ascii?Q?ch7IPtgk092ntykmftGzj9A0szmRSd3cvt4+sflRSsIhZRrl3XFZj90Hm/qf?=
 =?us-ascii?Q?tMspmOv2QsovecgTwcdZgfPEKuqZWovdH/JG8JJvoHWUk/pZPxyvMxXQL9YC?=
 =?us-ascii?Q?3g8B/B8wflGBpZ8ikaIfk4Wvwy843UJInWDysbOwMOUiNWBut47F33ANBD+y?=
 =?us-ascii?Q?I4FC9tGm3G9vi0UNC0iDLUb0lX0hoBEqSiGbfpLMX9HrzKWfrwJy19d3bwif?=
 =?us-ascii?Q?omyOiO+Ntw84+YsuUh4VG5vN+KJy1yF1fyt6QYQifsXFNOrU09HoRfBhH7AJ?=
 =?us-ascii?Q?wOMNs6ZMZ9Kbi27Ebn/8+bWCV8LbWKrz3N97COQUwvMn13134p2EuvfpkaG0?=
 =?us-ascii?Q?sE3iVPC4kmfh08yB6TwqIm4hQKG8zGi+0Cwm7jZLWGDW9RuujFroIKhU41M2?=
 =?us-ascii?Q?tKdfk3K8Qs3djd7t+R5JudcELSGzES9P5i7hed6geHFYtBTcf5H7wMzlG1Bc?=
 =?us-ascii?Q?W6cMzukocb6zxUztsug0ni0L/T3xLimt22eOdQvcL1wIKMGXsr4NxJunvGVC?=
 =?us-ascii?Q?lZ+x2ALXFDrNu3JoNacZiWhsIF8LFqfaYkTARhFIW7AMUyehIQt3+AJo8yUp?=
 =?us-ascii?Q?UjPUtEJcOlMKvRtnEzgimjxyJ23FFQNRwkNvYA/ZBwgeMv4kyVCnzcGeGaUE?=
 =?us-ascii?Q?l4c8fS32FJBzDXasIc8uihwEf6Rem2N4RdiU9jvx6IOTvpq2kThGKfShFD+l?=
 =?us-ascii?Q?73E2H4YcUwv042dGNJx+qHJKLWCadxrqAcRmhm8d?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d3d173-0b35-4eca-aa1b-08dc6fd94781
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 03:36:57.9138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0WlEIaOQ5VZSGDF08tn6d7IPp2YEEx5ORhr85Xamdh2xqoXzGHGcakG5YStj2oOiS7zensAJF10OrYj5QKVBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9213

On Thu, May 09, 2024 at 09:57:08AM +0800, Joy Zou wrote:
> Reorder lpi2c2 and lpi2c3 label in alphabetical order.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  .../boot/dts/freescale/imx93-11x11-evk.dts    | 217 +++++++++---------
>  1 file changed, 105 insertions(+), 112 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> index d400d85f42a9..6be1eb920c02 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -105,6 +105,104 @@ &mu2 {
>  	status = "okay";
>  };
>  
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
> +		reg = <0x22>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pcal6524>;
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
> +				regulator-min-microvolt = <610000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-name = "BUCK2";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <670000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck4: BUCK4{
> +				regulator-name = "BUCK4";
> +				regulator-min-microvolt = <1620000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck5: BUCK5{
> +				regulator-name = "BUCK5";
> +				regulator-min-microvolt = <1620000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-name = "BUCK6";
> +				regulator-min-microvolt = <1060000>;
> +				regulator-max-microvolt = <1140000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1620000>;
> +				regulator-max-microvolt = <1980000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-name = "LDO4";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <840000>;
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
>  &lpi2c3 {
>  	#address-cells = <1>;
>  	#size-cells = <0>;
> @@ -113,6 +211,13 @@ &lpi2c3 {
>  	pinctrl-0 = <&pinctrl_lpi2c3>;
>  	status = "okay";
>  
> +	pcf2131: rtc@53 {
> +		compatible = "nxp,pcf2131";
> +		reg = <0x53>;
> +		interrupt-parent = <&pcal6524>;
> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +
>  	ptn5110: tcpc@50 {
>  		compatible = "nxp,ptn5110", "tcpci";
>  		reg = <0x50>;
> @@ -304,118 +409,6 @@ &wdog3 {
>  	status = "okay";
>  };
>  
> -&lpi2c2 {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	clock-frequency = <400000>;
> -	pinctrl-names = "default", "sleep";
> -	pinctrl-0 = <&pinctrl_lpi2c2>;
> -	pinctrl-1 = <&pinctrl_lpi2c2>;
> -	status = "okay";
> -
> -	pcal6524: gpio@22 {
> -		compatible = "nxp,pcal6524";
> -		reg = <0x22>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_pcal6524>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -		interrupt-controller;
> -		#interrupt-cells = <2>;
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> -	};
> -
> -	pmic@25 {
> -		compatible = "nxp,pca9451a";
> -		reg = <0x25>;
> -		interrupt-parent = <&pcal6524>;
> -		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
> -
> -		regulators {
> -			buck1: BUCK1 {
> -				regulator-name = "BUCK1";
> -				regulator-min-microvolt = <610000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -				regulator-ramp-delay = <3125>;
> -			};
> -
> -			buck2: BUCK2 {
> -				regulator-name = "BUCK2";
> -				regulator-min-microvolt = <600000>;
> -				regulator-max-microvolt = <670000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -				regulator-ramp-delay = <3125>;
> -			};
> -
> -			buck4: BUCK4{
> -				regulator-name = "BUCK4";
> -				regulator-min-microvolt = <1620000>;
> -				regulator-max-microvolt = <3400000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			buck5: BUCK5{
> -				regulator-name = "BUCK5";
> -				regulator-min-microvolt = <1620000>;
> -				regulator-max-microvolt = <3400000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			buck6: BUCK6 {
> -				regulator-name = "BUCK6";
> -				regulator-min-microvolt = <1060000>;
> -				regulator-max-microvolt = <1140000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			ldo1: LDO1 {
> -				regulator-name = "LDO1";
> -				regulator-min-microvolt = <1620000>;
> -				regulator-max-microvolt = <1980000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			ldo4: LDO4 {
> -				regulator-name = "LDO4";
> -				regulator-min-microvolt = <800000>;
> -				regulator-max-microvolt = <840000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			ldo5: LDO5 {
> -				regulator-name = "LDO5";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -		};
> -	};
> -};
> -
> -&lpi2c3 {
> -	clock-frequency = <400000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_lpi2c3>;
> -	status = "okay";
> -
> -	pcf2131: rtc@53 {
> -		compatible = "nxp,pcf2131";
> -		reg = <0x53>;
> -		interrupt-parent = <&pcal6524>;
> -		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> -	};
> -};
> -
>  &iomuxc {
>  	pinctrl_eqos: eqosgrp {
>  		fsl,pins = <
> -- 
> 2.37.1
> 

