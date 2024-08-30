Return-Path: <linux-kernel+bounces-309010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D3F966523
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9BE1F2528A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02091B3B3A;
	Fri, 30 Aug 2024 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J69BMw8A"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013043.outbound.protection.outlook.com [52.101.67.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CA81AC882;
	Fri, 30 Aug 2024 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031056; cv=fail; b=GLXZzTFvI4Ky/Z7HfCKLo6y1qcy8HIhu6hz9jIagQ211evfDL7jDEtFKoB1Yp6wmnjY5QkS/X+JWp0b6Tv/Nc8HYyM+zowZpNiLxKIQy2/XF0fqEKqw2ub6bWSUfvm69SvCMTvjxLxUwaoFbYD2N2n6V6LkZ0UTBBs7nDH5VbKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031056; c=relaxed/simple;
	bh=SdOIKD0RHlVGdpLouSn+WZUSxP6YCMIk9jEmpA3DCkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GZ+80nl1rZguHwOZ1+XIFjcy8X+DkJgqDO7weyJ8bqwntXR7TKTK36nS70gWTlF6kIz+fwRORo5v1luQMmLcF1jdzcdaMVuiudNFdV8bGnPEPUripzvN1kvcoNPZsU5nCO4jDg3JJX6xJ4QUoZGmZnf7qrg33mwxMqkPbWJWwJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J69BMw8A; arc=fail smtp.client-ip=52.101.67.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGCBYtWyp0z1FKSYsf5cN+xIIvwPQWY5AYCWXj6FgnJ3r8Y7BTLm3PKg3SUlqlC0euCLlPhwjcXnrmg/1QKyVmsdbMK4G1xIiyeT47huVnAKyIBElooTkDRizAOam5tq6v045TBoPfEBDkcEwcULSF7KSW6Y+3coI/FfCB7OGcRD12ulhjr494TXm+BfDFU39fWfPoJAowZQH3AOdvn3T5A5RO18X69zpM0dwEjisAmcFcK24SvQX9M9WOPxMsmnsECqMDvfw9lJLLjJglqhJmJS8Z60wy0AsPziSwv5MkvmQukWHt914iKHzc8kouqiERfRxRYP9yuNTZ4taKvXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kW7q599Cp73CxuTJ9qsdZm014IK8Kn9VLPOphUeEvqo=;
 b=yJeTuWxYrWOVsl6wXzub2EX9le48QlUdPBGw7hx1mbceyO4CBoyup7xenWjuxgUMGav8YAZ5+l1R71e7MccYx2+SZs4k6MP8EVIG40WHN+rjvmVj4E7g1SZ/HPN7wnALoNFYsC3530RGHugfq8IzXxxvS9Fe8xvAkLtlYRGyulO1MIrj1QVraMJ8QV1yRZQ13eQ9wWa78n2vJtbR+3zjAwPGaBHHQK1sj0/UjJi67R1NlpltZi6MHyPIigUIIOuL/mIX7U0VvRAm5LaAmrH5cuSIDpjdF8tdzG+hlhWciYOGjvFzXcFJngy0bwdhd9SSOZVkROxUpIZAMetuoeGXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kW7q599Cp73CxuTJ9qsdZm014IK8Kn9VLPOphUeEvqo=;
 b=J69BMw8AEr5CasOBex1q022ti15VEJitRaa4R5wC1iF7WIyRuFE2RjNy/pa3PgdG1VMKf4Bz/0xbK5BTyXOS+JK3Yw9o81Wrn9yJjh+Yq8YebncjNpCuy0j+qxJrNccUTk7XNOk1E3MKZQiEMX93l9BLiDNTUf4DdLQW1BP1Vbjut+29kx/fd7ymVfTOVjrliqCKQq1FD0+mxle6Z0BlmMxjErbAy1URh7Agq0ZeD6sm7S3Xw54aL9o1S+emOXN/bRQfr1BSMFHnqNmuOEeAbb+PBx+jV/zL4SKrsqf9nKLNt0N7kg1WL97FUYZIE/mZBoxyGiuZHgjNqAX0SNI6QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10645.eurprd04.prod.outlook.com (2603:10a6:10:587::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Fri, 30 Aug
 2024 15:17:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 15:17:31 +0000
Date: Fri, 30 Aug 2024 11:17:23 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: ye.li@nxp.com, ping.bai@nxp.com, peng.fan@nxp.com, shawnguo@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: ls1088ardb: add new RTC PCF2131 support
Message-ID: <ZtHigyVRl7goWD/l@lizhi-Precision-Tower-5810>
References: <20240830032256.3701116-1-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830032256.3701116-1-joy.zou@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0234.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10645:EE_
X-MS-Office365-Filtering-Correlation-Id: 2265e051-bf21-4707-834d-08dcc906de52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0wBN6g3qZlt4u6J+ltejNw+1fCGbUHq7XqQsPywXV2x507GTVy2aQ3KhAjKc?=
 =?us-ascii?Q?+4YBoXltSkH76OeFt5l/D/6E9ek18I6GTB8wN/cRxvB4UeRU7L+0KY9guDFM?=
 =?us-ascii?Q?rKFnc3cTjHgX8vPZwYiBDQUKf+JNeGStiNfm+RvgTGnrBrzhUcnDuhCgRBmH?=
 =?us-ascii?Q?VnKd4t2zNfWTZRNMRaF7A5cKGyItbJ68CnALxQjKIK+VA6bbJMmMnbLAQ+h5?=
 =?us-ascii?Q?04jomoq9MAu2kdBxZyAz6Kw8xNCt/YFlzEd1eDCq1CXeFR0p33OqGYAo6zJj?=
 =?us-ascii?Q?BB46RzdcSYkLYrs6AnE+94Pu1yME4Hz0k3OgP/6Az96ZBsSmlItZwSKAAcD9?=
 =?us-ascii?Q?YOVBqsf+R4Spq+Yu+5/lMM6cRG056PM6MWkP9kqZK0HAaA9h7KIv02d89uwW?=
 =?us-ascii?Q?+t0wr5veWrDk9PYnQODtGsYAAHf36z5//0rmiAQ+wZPjuVVZP6f4mpdXObbl?=
 =?us-ascii?Q?gy2nuyvnDh6/YIpZ88fPdgzZsAee9+vuVqls9d5dGU9O0UIFyewlhZl7h9vy?=
 =?us-ascii?Q?yVvupQAVkiKdH0agZRd+M6cZEsEyjIxb3iBT9VvQT4R0hSsqdtFpD4v7Fl4G?=
 =?us-ascii?Q?mKczFg+4jy5TgKSfU0JBQiGPtEk7ZQdXQjoozb18mjVzQGd+U7qNFYj+SD9L?=
 =?us-ascii?Q?iDktNtwoezp1JJFHoUuuSZU47+AO5aZxNisXsiY6Xfif+9TowyvLxEh/iDiI?=
 =?us-ascii?Q?q9okvoSw1bjgYFeiwc8akTxmAmXAsG9Q+b4lj8UcG4qXAKcpxj6LCPsTPUhr?=
 =?us-ascii?Q?tdIXEMP3wj5bvoS88LMHecQGRNTw4+ANuYIbfl85cK3rmtkE6kIGVQjqySAx?=
 =?us-ascii?Q?bDPccTpEWEF4b1Fa5GkcDBAG8fdgVvYBDsT18tQOyWfr/rsi818IPSNsUKeQ?=
 =?us-ascii?Q?1V1OC6/AYkawf5WfaaiBymIDQ04glBHMHHJNwZZwCr3g8pQWwf4gMpgsl8H7?=
 =?us-ascii?Q?Y8mp5xyD/TjMOmh2Dp3ZP49gtfvzYPn0D6FQLLgv0JnC5vLzAtwf5jBqx3rm?=
 =?us-ascii?Q?gqu+lCPXxsr3FxLnjgOi7WG5yf0c/5n/xdIz2rx+wI5OyIEb+d91+vwWQ9sW?=
 =?us-ascii?Q?Yvr8l7LrO8fa3759z+ttWDWXycVhvYwucAs0Gy7wR/7rW3qMASSUsdWIroO5?=
 =?us-ascii?Q?MKY2PjyulHUuHbyNfKi9P6DTtOWj/ZZqEQsmXjdR45Q5oxqjqY4cVoShA+Zs?=
 =?us-ascii?Q?HJCmQn/O2CB/1flR7dj5fuhjTS6ODVeJzGjIo+CTFPJtFuZoPY5S1CVE2DsQ?=
 =?us-ascii?Q?PpCvRhJR96IYz7FibRO6laWuZxghChqoaXdyHHsRxp6KRgGgGWfCaTscNHQ9?=
 =?us-ascii?Q?GT8pip0WKEFwIh0tT5MZd5UkJ0st6dGqG21NtROcJeTqj5G9FlwJip9c9EbB?=
 =?us-ascii?Q?wm30NGf+6ycPs9dd25K/5w+lrnCCWkKCK4e4AY+VoMYmFg1gug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GlkhwlvTsQqvEAj+Ha6YZnzhy9hZebmVyzfJ/o7Gy2iSrl2kgrOIlzH4irQe?=
 =?us-ascii?Q?4lo42BMBw1NdE/GkjJVdPlpnEZx+k2UO6eU8pEfTYX23OdHX939EQs1g7FoQ?=
 =?us-ascii?Q?ZndP4iJTBjIgFoO7m1KN4HzjLZhh5EwEDj+W44mQL+kR18GfXT6HPylO65um?=
 =?us-ascii?Q?EO8+8acf4RrCIBuP0y4LWoYL+/X20qWovkMu+RL8nAGxKjOQC0CpnMASksnU?=
 =?us-ascii?Q?sxgWfzT65WK/lcMlTG7wfLi4JX7TYWSDtY86x0IY0+mXDalCE4+70vz4Dkt/?=
 =?us-ascii?Q?27KXjoAf8Jmy2Dzs8IAg1s2r3dpnM4My459+4pI04J2d7Hde1TxoPbqhpwuo?=
 =?us-ascii?Q?w9coUlk+13t5fNO3w0vFKlNdKlOYoBI2S449vAkqZghXBMxEI9iCrQkyMCGV?=
 =?us-ascii?Q?ST5Wy11seF568N4+b56uvI0fNtTqJdrsfCnFivfmwh0QsV1+dW5/dTgrdFGm?=
 =?us-ascii?Q?FDZEiE05UR0gti9FGjSa4Aovpd3+aMkb47yyL7TQSR/6CKEYzvY72G+ET0kB?=
 =?us-ascii?Q?T/72u2XVya6SqUJ95LSp22uKjY3GSMx8xkW4H2L4j8BLsz5viDfEzePuGUwS?=
 =?us-ascii?Q?htntKg23F84KE1cbOV4nU0ZcNRJtbFkfS3YSYEiEini6Ukx30zIEaWgEuLlr?=
 =?us-ascii?Q?zJSTk9Tluk/w5YbovhhInfrhlxUG4bdql60OIJVKmwxGyit1IIFisqtXqDqC?=
 =?us-ascii?Q?Iis3v3Zk5K/4QhS9wyjErBvuqJi5y2rOw+T9eD7rzDL/rP3oxU5uFRcOeWow?=
 =?us-ascii?Q?z2Ro2z/d3uxjV628sb5NubDagDTWAfeayc+5o5gRO9+l22EgqEMhk1SxqYeH?=
 =?us-ascii?Q?NmxJy/hgBPn173XtRFyf78ZyNvO2Xd/UQ4m2LQJpNXcgETWOKzv2yS8Vy7Nu?=
 =?us-ascii?Q?9fgN00cclc3YqsxInly9866Tioxe5SbAWgEjO4kqA4dWYdEdGky1TKtfJ0DV?=
 =?us-ascii?Q?TtIiBlymJf9qm8nE+6zziERQiAI1mAemE40QnNYconaj9iv8jfygCPSopYDU?=
 =?us-ascii?Q?4ibuiNfujn+rsTpw/fLstvoTHiTAzvLGaghf7IQu04vpUApzp1dOgW2CIT/i?=
 =?us-ascii?Q?evv3GebXVSJWX/+YZSSu24Una+vIW7bo1oVAOOBJs76qiwi1uzXo5SkdKabl?=
 =?us-ascii?Q?NrMI+VRpPIgClk4takTU5vglzAsZGUdSJfEsfK56onkTO6OzRp98a6f86jVm?=
 =?us-ascii?Q?4N10ki2y5ETjWkWK2MebNKmasQnwjU9IG1PAMLqOjRJbq7e1IbmY8ap2DQF6?=
 =?us-ascii?Q?qgTGPZwOVfpaBz/vXIYB10sQLUPrrRwNI3HGCcPfdQtjEBuN7kJmIb2/gq84?=
 =?us-ascii?Q?/GBH4rIZa+bykTwX2xzt7UBPTQHaME3rIHqABs4AYmBluJIWJpY9XC+u0/Au?=
 =?us-ascii?Q?20ewGO/rAjW1pTO2cWKIO+Qp7/ulwV1D9rAfIRSJ+yWJAhoHYgkISzkBV6Be?=
 =?us-ascii?Q?oYn2V/IfGIpVxvqXvBQ8g0BkM357cx4ygt2HIYepreuCqTOfswy5j24h27O0?=
 =?us-ascii?Q?iKULTYhYETgCLsl+BIlCrcsIQ0FGMrlhF9m2QiVLxrcMIIVF00gebtW4GJgd?=
 =?us-ascii?Q?b1Er5JOeSlSrA5RSDBZ6jwl5m0LYnadVtPNMgtdb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2265e051-bf21-4707-834d-08dcc906de52
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 15:17:31.8099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkLjXMGzsWR8ZrkH7sxcACnbuZl5eCnBsNz+srYWCPLlWJ/duuwtlvZYCfPKj8I6bTKZODzw3qT4Jkloy+jffw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10645

On Fri, Aug 30, 2024 at 11:22:56AM +0800, Joy Zou wrote:
> The ls1088ardb new board use RTC PCF2131, so add new RTC node.

Add RTC PCF2131 node for new ls1088ardb board.

>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
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

