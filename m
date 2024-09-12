Return-Path: <linux-kernel+bounces-325911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C89C975FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D994282AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDF613D530;
	Thu, 12 Sep 2024 03:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UDiWJv4R"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A6013A40F;
	Thu, 12 Sep 2024 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726111802; cv=fail; b=fVTpxGZTgaicFkB884Y82A4iW8+hdcVVpBQ9U6xJGGBsh5vvEgokqcUylbPPf4sw4BW7eDPgHniPe8lY4CnGXoF43cVPnsDkILsz5YXzHMLcKbO+yzek1PzYbAd4onPO7T+Fs+XDcvjM9gg95ce9Pknm4jXf4LEqHSQwrVZakCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726111802; c=relaxed/simple;
	bh=SBW2beM5m90noueASSdFlPQ9aMnxmjxcjz0pU4D1PME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W/BBx9me8+eI/+K7/kDiSt+rYD5/LJAi9nEbFoWodhItAA/jqbPl/udIEV6GkNdIx3yQpMCk9Kqg+IB5P9QWYvlm/N40tZ5t5/oPyBPncd2WJI2YZDQ69UQZkCfwdDjXEonSO/gjAzLOVcpannbCowLak7h1cJyANWRpogsRHYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UDiWJv4R; arc=fail smtp.client-ip=52.101.70.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNG/+ejfoSMNa7etvrH3QPlITbCaLMg3b2dmyPQwOxO0MmLTDyPdV3bVjmqyREa0tQzW+0PMx56M2KLAx8cbXHdxy6QdRxrCy/sH3qJpKnN/Ta7dn8Ut6sjrq8Zwg4gqLR8eCAmP13gg5thRLo76t3RwYAztlwInhpFXcUZ5GTdGlIUOQ2o7OE8FK6v3Bv5JUMQCIQ+fs0aO5d8RudtlMDzuyBWu5fE5Xqgs2pbUFQI1roAWyVRyx5xTdmqV9Vzpk4qUhVSgvXxU2c7CSJjDgQicCjXQKdoJPIjgyw3dd8J9DTBK0MfOosS8yTQKEz3yKsefd17EQ8tuZhkPdrTyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BW+6LKNrlSotnryRbO+z4i0iPnw6KGvrc+aiR7GhMXk=;
 b=yMVqkz9x+vjCUVU7ggfktlKr8xCcZ862+Y86VHbTLjA3TRB/X0ukKN/pmcK/5ziYAYpsFyujeosnnqWmWqmPvtI4yeZP0ul3vDBZZQ16kGa+FArIL1t46R0ZeHzK3v3ZLGZh3HssjF/Pz5uXwovV8nYu0SlofANj6Zwu1dmc2idXH7IjIjbMycVQcpV6mHw5Lm7+eL2L3zYPmLmFhrUMbh3lceFqjCZkPwQmnUcU8wUrGqm9vqoATp4vsMAlfH5lZ0Bhk3HQJHoBLAzyZ4JlTZoG/7P//NzLYjQoisAUXJFGVv5FgwwZkoXAmYX+kpSukf8Y2BjY8avvMNAIlJgNKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BW+6LKNrlSotnryRbO+z4i0iPnw6KGvrc+aiR7GhMXk=;
 b=UDiWJv4RvHBn0BMKyuA3eoHS9XaKIZP4pTxoEojJn/W3MbKrRFP/Q89U+9yPNH3R5JNYRbacMW3jw8ZRFM6Ji0bap5AEnaSrqx0JJSIuWWuRdTaRe/FobJLrpOqvDLMiZVGfcwNhjFiqZN5UYNRL8mCq5+BQkzaGGJ7M9p/t0Q3238Boxcv2vFJcUD9LZidu1lC3jUVaraeFYbWdskpFCTKaGUHlis0ErOycXFpsjJbSRqiKy/tKA6zktwcmqoEN05sIBQVoWCq9QTTIXufLeSDflyOprybl6Zu1Vo2X/+ZfAikt/ir/IY5AA0McvKRjSFkq424YB71ddk6LezL+YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10242.eurprd04.prod.outlook.com (2603:10a6:150:1a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 03:29:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 03:29:57 +0000
Date: Wed, 11 Sep 2024 23:29:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH v2 2/3] arm64: dts: imx93-9x9-qsb: add bt-sco sound card
 support
Message-ID: <ZuJgLFBAWBOd//70@lizhi-Precision-Tower-5810>
References: <1726106381-1138-1-git-send-email-shengjiu.wang@nxp.com>
 <1726106381-1138-3-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726106381-1138-3-git-send-email-shengjiu.wang@nxp.com>
X-ClientProxiedBy: BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10242:EE_
X-MS-Office365-Filtering-Correlation-Id: ef639a58-253f-4b7b-11ac-08dcd2db2c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?duULSPZFJBa5ZacAnI+8i1Z4BnURH+XzF4IqoYgwOEC33jDQqaBa6zuFEokP?=
 =?us-ascii?Q?K7sC1zn2KVpSrFRK6HX+rHkazEEqUPRUQFAE36s+ZvaqpdbYQuOgt5TNgff1?=
 =?us-ascii?Q?bLT44hFGzBtbyYLIGbI3YxoRSABLlrlvWYQIYh6YXNLrjbgSp3Lsp4OopRmI?=
 =?us-ascii?Q?JC6MmczSC666a9FL6XEsFKwstCUffwwnnny4hLL958HrW+r1FjtELAxyORza?=
 =?us-ascii?Q?5ECNfmIrDVsy8VowcXOMVFI5wuSRaG8V3WuK3Lj4hyfDt7X/k7A0oUpIHVeB?=
 =?us-ascii?Q?mTq9Jx4OGvNrW2zC3XV55ForoZpzbkCFktN5SM+w7pY6ZYl34NS+KSE217P4?=
 =?us-ascii?Q?6QMkd0UN0PpIh2w53nXa+36sWFGndHBoh9yjtpIMixNzcf6dDbxn6SM7o6R9?=
 =?us-ascii?Q?MxHbZ34Eck0minYo182bXmtTCo5QwRb8f7Y9uCCOO3Sbye9bhD2hXOjxve1y?=
 =?us-ascii?Q?V97mX9Rnqm9JPZqJQH2xthzzXhdF722RBvEA+z1bXPWC3djlJoJL0nTKNene?=
 =?us-ascii?Q?SDmzxYskonWIz+d5MRPPbTsN8jxlviL2GrcdtAT1YZQqS0FuoKpPDannYRAZ?=
 =?us-ascii?Q?J4GNpfl8xWIlEAjP2g31GG/7uM4o9x8RwuXUeMwkMW+mhMPRrSk9Mf4sCoMs?=
 =?us-ascii?Q?WN/ITwznBkI1arF9WG81tLUoBloVdjaTCz4rhga/vgOhpH/A26hRSk71xocO?=
 =?us-ascii?Q?VeXQyIXCBtHYALCq4bpKh75Cs4MZ1qpoMVNk+sUsCfmtAuhAMJDP9ZOfvCnU?=
 =?us-ascii?Q?MrFIV3DAaxRS7SBExg3ZXP50gwjU6CkhCWjQ34VdeMY/ZOUoZXTfn6EKu0uZ?=
 =?us-ascii?Q?mlHCFEYyEFLR43Kko6MAjw0RIN+k6mIULAaFmsyW91Odn++FASTGeUYw1CEQ?=
 =?us-ascii?Q?0EhRy2YQqCcBD9nNB916apxpbCxux3pDJRAcmWlz5cFRkY6ZWhlTEG7of0SH?=
 =?us-ascii?Q?k6KjAbo9TwLZSsTa76fxfnaDBuZTrIPL73QmGsctXqPzbpe3ff5CE5QyB7u1?=
 =?us-ascii?Q?oktcaqYg8SRL8QrvuiYoweNNk63xq/v/WBFmoxKSBNz01wtBeKt+FdSbih9Q?=
 =?us-ascii?Q?/oYhj9TESbiXbVz+JvZQvx1vdaRqi/mdcTvXvFr9iU7XEQP3aXfKgNL6+s5A?=
 =?us-ascii?Q?5T6OmUfqhFTebJvZydL9MXKYhjQupfw8Xs1a7xSfLk/OfglSF/Zdba8zb69H?=
 =?us-ascii?Q?URlLtCfYWJg6unme022EWYYTXtkYHNQEvBjnjHjvG+aqdR/NIZpi9fK9aakr?=
 =?us-ascii?Q?YB16e4mZeIa116gRc/yuzBg5iiT27tpNvIUPkuG2U7mduAHpBUbdbfgh26cg?=
 =?us-ascii?Q?3qt2mtnTKUaWSOGuD9oOxk+alCQcsgjiXhX/Un7HSYyX2DK6Fh8Y9zhlJnwZ?=
 =?us-ascii?Q?fQGpfTMISwCYvB4XGpJ7Gr+hitP5HPbVjTrpPz/V22dg/bFN2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tRGmrPtAqNaotx5ZYgXjRWq0doMWLIzzPmGmuol8cirnALiGPpjKB5vXF56s?=
 =?us-ascii?Q?HEFh7cThqSQzukxKUOH9T3oSMOfwv2HftgbFf7FHTCIYaa86nuwKlkg0osM/?=
 =?us-ascii?Q?ho1lhTDRf2dynO5VA38RBvX3S5FENTNGnK/5EDsCaTDDs2cWG5GTo02wax+u?=
 =?us-ascii?Q?I4WhJrWoaL3V9BoAwrDKstLrI8sVItzYCx7+moV+nFtNWyBHr+IhIPd5p+vq?=
 =?us-ascii?Q?PO/dK8rdHl9nIT2Q9rZdN+3cW9dRFkjDNfAGEAPk92J6RnCQ7pceke/fWtsh?=
 =?us-ascii?Q?3OwuY3boOLs0qC0n9AcftV3WEkJuCDoc4VrevHv3VNT9h9BbO5WfF5ISRTvF?=
 =?us-ascii?Q?6s+Ur1BL3UToeRnF8DczKKihQwprw+Als9Ju0BIJ+eQDtEcNyA4npcYQqN6a?=
 =?us-ascii?Q?lL0UFO2ITiCi9IqN1ebWsK9FzZNg+aZnbXENXtFV3eHek5YkBGleLFSWWkpv?=
 =?us-ascii?Q?7wMZlFMblMtnYQdh+EiC8uqBbiOdBWs9ukYKa6QfVG4/8ZHUzlBVfdDcjVhm?=
 =?us-ascii?Q?drY6TA3Xn0pUFBI189VrUlLI9GJdIMeubRFtnVf6xRDZxtanaAqwB0kn8ti0?=
 =?us-ascii?Q?ExXWXvHRYHcQzSItky97JcVEuJPt6CoOGX5rTnWLQX98FsHNsTC1Z2hFEEap?=
 =?us-ascii?Q?Cgyd7ynV+A843cDUY7rWS5Iwjwa7jvQz2g+JmPwqpqqiQrAGyU2L7jcleRvC?=
 =?us-ascii?Q?lBIUPPQpqOk0yvdgcDq4XjvMioiVhrmLIt633Wm2Iv9qINPMeeaoQrf477MJ?=
 =?us-ascii?Q?YEVcMCw2dPtMBbEDjMZwtYk2RjxQbuuRxrBF76Hg70sguLzmwOG6RFlpt+Yh?=
 =?us-ascii?Q?R6xlbUND50Dxb/9kQsVaJ2TOpyRQfVuH/xnip3h3FzIrfNJEoShITvCESD8U?=
 =?us-ascii?Q?KdFssyl9V5FcRoQzych7bNBhhEn5NtGfT4QBpyYMIJH6r0NQFbJSjptlwk9w?=
 =?us-ascii?Q?lsUwWQFRrZTdx5MeJwBNDawvDjLbq02WEJtLRWhJEIrFAxAu4MFCJdJ8vY5t?=
 =?us-ascii?Q?lmMpMuOho171Xn7JzdbNf41cXtA0DeXL0s6iQoikkf6tlpZwf7I54iMe7uh5?=
 =?us-ascii?Q?VWWQcqA0FpGBiH9raf7dlnz2jmaXh9p5eb9mgTCvjoB8fRR/LzLpyCZNu8/C?=
 =?us-ascii?Q?dzvdEHQOY7a0RqMyt5jUMWZ0s48nfE1Bt2gvTJHtNAaNUBszzcs/Hp+eiunq?=
 =?us-ascii?Q?IfJcvNYGY5aT5rLZdTo3CicvuusRE0+qFhzICiJWI3qR/sNrX35uCQPSsSof?=
 =?us-ascii?Q?9NvBT7AbGVII2wtId+9GOeMwJle3vnktM0JprGhKuCpLd1byh+kmA1QEzsoI?=
 =?us-ascii?Q?ZtkPfzXOLQWo0zQJl1Yh7FqP8guYJ7fytcoitipYmru7X3nGcfAq2MTIhsUP?=
 =?us-ascii?Q?wp5gmAj/wVvMPVFq7N5O1asyeHEOSdEFtqRde3jX6RMclTkgIN/4ZcMsIoGz?=
 =?us-ascii?Q?z+pkvIcl1wzynYyCgJ1dEpnVp24Ga32rwuJgKRN4HJo8ynLzX/qj5NIZLicF?=
 =?us-ascii?Q?azbpDHQYeqqtI3Qc8H8sZfDop138DQZQRm+tgrW0pW8Ff/yh9mIanfZPq5E/?=
 =?us-ascii?Q?/5S87wnbuITwOKqLISVoyd2MTv2mI+CuM2j+L9xK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef639a58-253f-4b7b-11ac-08dcd2db2c9f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 03:29:56.9901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: de99TZ1Mw4UACC0HCYHHurfLM165fC/+YSAUp9EPyF6Ae3eIt4kob8hNjFAjVpHQqiLpmif0gDIgQhOGerPfzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10242

On Thu, Sep 12, 2024 at 09:59:40AM +0800, Shengjiu Wang wrote:
> Add bt-sco sound card, which is used by BT HFP case.
> It supports wb profile as default

nit, miss "." after default

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../boot/dts/freescale/imx93-9x9-qsb.dts      | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> index 10f3366b8253..f44300225656 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> @@ -12,6 +12,11 @@ / {
>  	model = "NXP i.MX93 9x9 Quick Start Board";
>  	compatible = "fsl,imx93-9x9-qsb", "fsl,imx93";
>
> +	bt_sco_codec: bt-sco-codec {
> +		#sound-dai-cells = <1>;
> +		compatible = "linux,bt-sco";
> +	};
> +
>  	chosen {
>  		stdout-path = &lpuart1;
>  	};
> @@ -98,6 +103,25 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>  		off-on-delay-us = <12000>;
>  	};
>
> +	sound-bt-sco {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "bt-sco-audio";
> +		simple-audio-card,format = "dsp_a";
> +		simple-audio-card,bitclock-inversion;
> +		simple-audio-card,frame-master = <&btcpu>;
> +		simple-audio-card,bitclock-master = <&btcpu>;
> +
> +		btcpu: simple-audio-card,cpu {
> +			sound-dai = <&sai1>;
> +			dai-tdm-slot-num = <2>;
> +			dai-tdm-slot-width = <16>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&bt_sco_codec 1>;
> +		};
> +	};
> +
>  	sound-wm8962 {
>  		compatible = "fsl,imx-audio-wm8962";
>  		model = "wm8962-audio";
> @@ -339,6 +363,16 @@ &mu2 {
>  	status = "okay";
>  };
>
> +&sai1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai1>;
> +	assigned-clocks = <&clk IMX93_CLK_SAI1>;
> +	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
> +	assigned-clock-rates = <12288000>;
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
> +
>  &sai3 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_sai3>;
> @@ -507,6 +541,15 @@ MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
>  		>;
>  	};
>
> +	pinctrl_sai1: sai1grp {
> +		fsl,pins = <
> +			MX93_PAD_SAI1_TXC__SAI1_TX_BCLK			0x31e
> +			MX93_PAD_SAI1_TXFS__SAI1_TX_SYNC		0x31e
> +			MX93_PAD_SAI1_TXD0__SAI1_TX_DATA00		0x31e
> +			MX93_PAD_SAI1_RXD0__SAI1_RX_DATA00		0x31e
> +		>;
> +	};
> +
>  	pinctrl_sai3: sai3grp {
>  		fsl,pins = <
>  			MX93_PAD_GPIO_IO12__SAI3_RX_SYNC		0x31e
> --
> 2.34.1
>

