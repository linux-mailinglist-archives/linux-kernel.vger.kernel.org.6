Return-Path: <linux-kernel+bounces-311844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 361FB968E7D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 21:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9613EB2222E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057481AB6F1;
	Mon,  2 Sep 2024 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HKxN4fT8"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780F01A3AB6;
	Mon,  2 Sep 2024 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725305892; cv=fail; b=fiW/BN5zVM3tXyppcrhBrG02A5wUrOxBX5q1Y+GizyQkTzfwmmub20VyJ0U0uHEXqPOAk8+K7ud77nOJUnsj6hkV1Kmug7zKydpnobD3Piz91lNudu1XjVhKwqwgS8RH+J40QdDwIREbxRzeBWdw+4BoJotsq9MovPVG0YtrNWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725305892; c=relaxed/simple;
	bh=0JqGlrRJtOT4Eu8AKzGR/DHMppv9VxsaunoX+cI6z/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cgfSqzxLtN05KFkzsHwHwsLdPPKnlPAITr6Ocu8lwVjoV/6YvwrnHlMD+lXZOmxf4CatNkrZbPrVuOhHL6iYetD//xswI9Dc0MK7g6ueA3ZkaPh5soNnztUvFatw8O3AIPi/UHXHVrPxE00A99WmwM3i29VVYv3kG1/hmKrY7rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HKxN4fT8; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZPNxLzhgw6Vnw6m9WRa1TP8qk794Ar3vZQa07TG7uTAJ/KhLqpwW6I4DUlYWiEnv2KKgS+4Hxtz0KasnPfOXYpL0RxtPot/uTma0o29CaQVWnIgp77uiDXNiW74x7Bvj0ZdAN2pu/oB0Nx5KVZpZkYiv8/68KwPrnrBL/8Mbn+/zERtRP410F+39N5NHisBW5ZZCK9jJQyvXjvjzF6b0Fn2geJOctnBlBkaGPi7T5ksfQknmb79Es43AZw0cS/v5HvQIU1cIyhcOA98BiSMAEc2t9mb8WU0OvFgbrbO8sAMbbd33dX6XjHwbDtk+iLT91jSt7MAUsUkh/AZ3BRMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYXOFqJMehsNdBG9WwTYe9M6adhmO8nEnHyaWeV4NGE=;
 b=WgZ0CD2Uy8MyMq3+iejuLmFDuOjxnoeHY9LBtderaHKQNf+yyxPzJ1xy7c6dGxAm98tr5QZrKoH30A2kTn2SdNYnj4fjjeq7QW8L0xIRwLtPkk/4GdIqyb8mkQj1UtQ6Bq+zitd3TO4XWfxoUKDGddDmAO52RLbBru3tik0nT3tFoXIO25NG3Jh3BAMIr0+sKTvjIVg/wm4PVALGxy1PwmpicXJyIdzF5HmLYic0EhcZTux0I1IKs4xK0IsPtgTlZefobS1jLYJTvG1+Gi2lNUV7H94K6P37efEd1kNeCMYCC3ycHQLz/MvMGAs5x78hwhmrqjCLq6Dqx+NC/v0CZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYXOFqJMehsNdBG9WwTYe9M6adhmO8nEnHyaWeV4NGE=;
 b=HKxN4fT8dJzW9qmDxe+CqKmNWlB2JQFDFGK4qei4liQFijzlYWaSbmltY9rsJLSq3BK6pztdNcN53eMkABxIsEsuN9lOAqbLw9U2oIxHkbOEHflv3jTq0/MXyixvvGy2FlPRDFCSU0568t9fM2lxRjPqHuR1aIedjMrBIB3olKemjZoI31RWev7XndW0jx5NWBTFwKP6GviHKOEIx9aVcwZhyfWndvhSLqal9yP6rDFsOQqCJKGrh4NGujbhomn2GlKY0KDMhNdoSTvJ+2H7E+0Hw4DIFjNSCURNMA+A1Vek7NlY8dHMqm69n751ypZDcoUJcLbwNLv5mkgMMhNZAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9822.eurprd04.prod.outlook.com (2603:10a6:10:4ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 19:38:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 19:38:05 +0000
Date: Mon, 2 Sep 2024 15:37:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: ye.li@nxp.com, ping.bai@nxp.com, peng.fan@nxp.com, shawnguo@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: ls1088ardb: add new RTC PCF2131 support
Message-ID: <ZtYUFeWwHfo6J8nt@lizhi-Precision-Tower-5810>
References: <20240902103626.1414595-1-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902103626.1414595-1-joy.zou@nxp.com>
X-ClientProxiedBy: BYAPR08CA0050.namprd08.prod.outlook.com
 (2603:10b6:a03:117::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9822:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ea8595-8e6c-45f9-76a4-08dccb86c436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3KikyQ2EFmz6xkUpEvlGS+CphGI62amr2NHvSQTNflwqMVlaJoP9Xm9F1+6a?=
 =?us-ascii?Q?PrvNWLCqR92bz+zuf8NxSS7+mdNP7fpUvcmepKFAAr+QncbQDDi0YxpDcGBe?=
 =?us-ascii?Q?vYijXkKv+V3/3LBRvEDFAIW1lcQ4D1dgxiORNwIBlfsm4gswffVVbXyfEkjy?=
 =?us-ascii?Q?tQQXE3ip6RsmW+uGcu+NMmz/X+BegANzNIpKGK1frjBbmnTjnzDuOa72Isda?=
 =?us-ascii?Q?uc7+1QOUMdcbnfB66oQ4MuorpRaZxrRAD2MW3LjZtDH4dSSOr766wJgjIpfP?=
 =?us-ascii?Q?O9n/7L6AMliqUEpBMtXF37zkfpjVJkHUtv6XxaDNy1rHOSDiFTEAFSosVleY?=
 =?us-ascii?Q?4l+SNq5gKq7fYajwwfV3AZPbPjT6WSPMh9CZaY7/xHuP9V4VOslKulkz4KR7?=
 =?us-ascii?Q?fVNTIxbzmiVoxBRlUosAKuGM5K/t2FgEHwGvMVI3lkGnaVezSHVWtoY1vmeB?=
 =?us-ascii?Q?m9VcSWGxRHGS6x/zMCYSWTujDqrFgIv4yhcE8Z5iF9GxD3JvkufdVhb9mRvo?=
 =?us-ascii?Q?FKV1WMElQbThg5NdP64l+03FanUoKRfDKNgCuw8a1Ac6MdDk0l2KX1CO70RS?=
 =?us-ascii?Q?sY7sg16r6tb4znC8IIy4GBQZu5Tstf5j7TZSVWCCM+UDG/JEwmdYywmc8vgQ?=
 =?us-ascii?Q?2HCy7n1A+2IKVZfJbYVuXiorjEOxAYpOtt1RPTlr2JNBgn97ArapZ09Rwe6w?=
 =?us-ascii?Q?13yAOXjrZ2Ohmo99Z6/NFp6D7w/6e17eOjOTaIYqiWwWclQrosBGDyHYzFbb?=
 =?us-ascii?Q?Wei1m8M43upRbhdRzw+FhZpMTk4pV8FPjughz+q4wvZBxAE7qBJ1HO3rScLe?=
 =?us-ascii?Q?JYD4zFF7YqX5fYmSd6zhBjWRFlvWo+dmAP+qVZtabog5Mbi18xdtzYen5Z58?=
 =?us-ascii?Q?ccPJoozkZnRmyAQbpYiOwzwmHtCQ6esber0R1EYHlzqJMsX5429xsCVAGBHS?=
 =?us-ascii?Q?qBizbzulFh6nROL2dMnObGtcAB38wU3wL0cyKQgZrrVo+Dqkm4/cioZ4Iu0I?=
 =?us-ascii?Q?KN3e7TeqrvImBrICF9MziCdRKT+inWBsvmFSbiCX2TSkkI9zfCOslIkfwbsP?=
 =?us-ascii?Q?sXojApgh6Fen+caYCYZqYTNRyh2aZKwxIdNHSnvphJ3etF4X+/2DZ2XuPaVz?=
 =?us-ascii?Q?aRmifqQckPtRAaZdYzzZuvH6ODeCTwboxt9DekNXtG92gJStA0/MoyraIJn/?=
 =?us-ascii?Q?X/Jqb9+c8nWH1CnUIiplc/cRNImJrTGFoCc5JVkTv81D9NGvsvdcdmcXtoZ1?=
 =?us-ascii?Q?UjFa+UJXJm4966jEPSKbphVBLRmeiESNeW6X4T1l04yfZppOiim5Q3a6N/KR?=
 =?us-ascii?Q?Wnm04qQGoVDNyn6pgtyBsco1RF71uXX6upJDjcOLXzlq9vaqLeUVzwGLdknX?=
 =?us-ascii?Q?Hmy9o4gA+c6iQ1SnzdGHbLUGYW+iYRedBLtBAC+ZqL11leqr0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xmc6gbUff0iuoYx7rhueOSpV3UoxVGaoO+dKoxSiHzaggfiDMtW7lrZ/24ig?=
 =?us-ascii?Q?TKJJ+3zdiK4K19fZosfiZjek74CWv5HqFxtG23swcCsKsCtxsM5vuFVO0miY?=
 =?us-ascii?Q?WQ8cigv4TnSvw4nnOjLaLWn4lQT29QSsdX4S5L2qnd1d7JQaftlIyFQuoGff?=
 =?us-ascii?Q?+yoqsiozmVYTXfNjwuCjVosQ/k6C+fZZbzDRtL8fk+7gDef1WB6i7uaTArmv?=
 =?us-ascii?Q?g4Lxj+lyhaUcXwDZ5YqQ0QvWNk7NzARnsd3m7TsNBSYley1dsiAA6i0IEVJc?=
 =?us-ascii?Q?aL6+W8Ib4EGKrLJitG+j+qXs5PjeN4YEI12ri63FNFJkWtNjfi3Oeo3744q8?=
 =?us-ascii?Q?1DuOPllfuOavhh9xBVRNnpFsZz4MhkGx4d02DQt1rQg8lFsUAanVL1YnKdaB?=
 =?us-ascii?Q?FoCXAR+lQnUjt5nN+7O2ehSa1UnRRoKxtlXUgVUAYD5qqSwUef7UNS4gEagr?=
 =?us-ascii?Q?NcSddKte0c5xoSZj/ri65HEYuXqIzdynbyO2TPdyxMSKCa0f+m01taxX4wXt?=
 =?us-ascii?Q?rspW7LXvI1doe4ICFezaVhzHPFCSr5A/1tKkcKEy9sdOQDHZ9R4xyUoJGOGf?=
 =?us-ascii?Q?lFOh15r02O1pfCS9xYB4phbzv9L8tVpnCMd2WSJuAestAQztPnMj1krPnZ4r?=
 =?us-ascii?Q?f+okyRcltkcBIU9PpgNuvlgIB9/rz3faH0qC7/IwsLlh1gUnJ1XvBdN02AMA?=
 =?us-ascii?Q?31xU76jrwJsJUkp9HHRKMmLNVuXxfSj8L0AD7t2O/+K+eST5wTwZbrTknt/P?=
 =?us-ascii?Q?v1xU/EXpVWEMA1Z0EY/HRJJkGARmYvv6rAydvH35hdOeZO56GA1m7CmDnISw?=
 =?us-ascii?Q?pLBzr/hCmHZb236T4UUKs3+gUO1Y66AEbgQk6IOEk0miQzCzVl1cmNeiR2Ou?=
 =?us-ascii?Q?CcNEYktr0OMvwmGO86+DZTSVaVz0GmseDC3en60ndCpNAeTnCBZSj0pE9MH1?=
 =?us-ascii?Q?9tliuoF1RST3HWFyRGle/nJhlWL02aQ6zFK6mVLvSqI713NTyQevs3aOTICZ?=
 =?us-ascii?Q?JdOR7IjyHRGJjtGZqFdkelCVAYk0I7xr5AQ8FluNtiTh80Gx8JP/JKyh4NhE?=
 =?us-ascii?Q?HSPUBAbYIwoO1cbgM0yBkAlYG0J3ZQfd/V7GUGNBwjKp28Ph1m4AKe72eJiK?=
 =?us-ascii?Q?gjLxbWPXcja35l7DE15VMYLiRWVnFIXVwoujQPFy+5vk8g1T7/o+s5QUo0wH?=
 =?us-ascii?Q?vW7lXDPs4iLi/DzFfJALrqYbfWCSDRpw9O/2BESGtez+TFWFOOtblok3o+p0?=
 =?us-ascii?Q?TL51Nbc/RgJQzcXAHyurDOsb7qcJD2+aYi1His9DtjdD7V5VZX9ARll2rIMG?=
 =?us-ascii?Q?PN1WteWoFiBwVilJIJ940n4NfksinnS9AIEdLWm7Fp8FzkpMqeCLcECLqUru?=
 =?us-ascii?Q?5+yBZ8tdDL/iLzOqLiJwousRYrXddnryE0KvUifQdgK86MfhCVrTcS4VxkFo?=
 =?us-ascii?Q?wTx/QAnaj8TERcnqB3DUuYtPTQh5eAIg3uE7dE/t+JV09hYOz06rTYzpmghH?=
 =?us-ascii?Q?FP7A9IkCw0W7OxNa3lJfpy/1KgQTNG+bHE9J08Iqd9xTkM9bOwE+d6jgqm0C?=
 =?us-ascii?Q?Di+4Ah5A45+i7+MSca8YUoP4ANARLv8KibfdgjFf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ea8595-8e6c-45f9-76a4-08dccb86c436
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 19:38:05.8907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVvRrlimt0D1pb3sabL3oqsXNA0Ab5hvw8AgxQ0EvCJC7Ugxh9rPV8labj7J4nwEnGDrsSzeueXmCFCneL6gBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9822

On Mon, Sep 02, 2024 at 06:36:26PM +0800, Joy Zou wrote:
> Add RTC PCF2131 node for new ls1088ardb board..
>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes for v2:
> 1. modify the commit message.
>
>  arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> index ee8e932628d1..2df16bfb901c 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> @@ -170,6 +170,13 @@ rtc@51 {
>  				/* IRQ_RTC_B -> IRQ0_B(CPLD) -> IRQ00(CPU), active low */
>  				interrupts-extended = <&extirq 0 IRQ_TYPE_LEVEL_LOW>;
>  			};
> +
> +			rtc@53 {
> +				compatible = "nxp,pcf2131";
> +				reg = <0x53>;
> +				/* IRQ_RTC_B -> IRQ0_B(CPLD) -> IRQ00(CPU), active low */
> +				interrupts-extended = <&extirq 0 IRQ_TYPE_LEVEL_LOW>;
> +			};
>  		};
>  	};
>  };
> --
> 2.37.1
>

