Return-Path: <linux-kernel+bounces-323376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA58973C71
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6781F220E1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A617193097;
	Tue, 10 Sep 2024 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cMpqLjvN"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D243156F2B;
	Tue, 10 Sep 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982865; cv=fail; b=MpqJ/aRcMWn1Iy2bP4dSIDJt0pcOD1bb7MYJDnW263cYrb5LXQO5IIJPR3Jd+vw7CoWeJQWo4sRD0aS9A1NukD6GqUPWYEYWG2X0A+DfznrvJyWUiCgUPvs4gcJgKz7bmkO7uei2+vciPJS00bskzVTvaQzsYnu8EcO6cmmFyEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982865; c=relaxed/simple;
	bh=d0WkUAYyvHgFuouFOXXvc6IX0uGosA6N1pGRS0Ddf+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FDEuTnGSAxJ7CVhOgURUidy4Ke7xR+tCqLhd9Iojdq+p7UaJgRkRoy2URdh656qQ2Ko22cBoXPbvW25D8qAroUO5nDS+/FJlUuXA1oLa1rHOM7YAo9zmAYR55zap00CnLBctfikF30mm9LKVnGbJwgKoqkahJV/flqYGS9O161M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cMpqLjvN; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRKoHq9d0SwIHVLRdTtSTZ0hGNo7AIYrfv763qWUWDpJ1ukyu+hpuEed7t5KB0Uhxdfgwm37Y59N8v19ImRhpraIz+TNpHk7HojNSXsdknCr8RzC1waB8MDmDakUBi8EBQGG06KhKd+w0/C1HwIyK/6CoowHSMF0PIfICQHKOIPHncVm8KiZQXnmeSPkuh9n4pcXMzG22w2eeKs6EGlMnyGwQjjzzEDsbcmRU4qOABTV+F+zGJIV/ZbhBDUp2K+ghxpVkiisHGp5W48X249Mhc9aY8YNlZB0a1xRAoJvUlwEWRp661Y8TrHY0+O0mO2Hw6UiuCuwOXVgUd3v2q4jpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qz3I9vM6VCFQQW3DLibv9aalLDNBQm+eN1ZCBIbHBBk=;
 b=DffyKBEy/glVvrhAbngpaSzcCYolyr/vcEECDNBjMEARcD/OwsaQQdyK3EHtZYFRItWYwVKyUmtHjH8stP/VX6aFFaScSks3A1mhgrPYAO1gpGS5635D8ghhwBKST7XSQZTgk1MFhnCI0M2XB52MMEXw3vgsO0JFMEbubZLsk5H3qj9PoU3Ugl/Cyu6sKONFcTD5CDd4Dp8K6Il+Qn2l+1RXeWeNYdF9UxTNJ1mt9YOh9ElZSH5Ytl/ETCTtNWPdneAG4tgSiPObfY5GXLIPBz2CHAjsVl7ctRcjtqg6UbI7+38lIF5F0hecIHtHUFHkl0YY1Z8mntvEeswRuRNVmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qz3I9vM6VCFQQW3DLibv9aalLDNBQm+eN1ZCBIbHBBk=;
 b=cMpqLjvN92GpKHbJ9ETU0zuaQ+SElD7qrp8TYjsheEfrJHR3lNye/nlqNGuAfrL8RqYL/c4AdvAq6xJhJIanlTf5TfyCPXD5sPf+hf0g3n4E2nXXEaCnwefbS9UZqpy+QfO8JMY9rTgX+3BSpyVsNHBpFzYvpZAs4dKDXWRwtoBTaULxDCM/mv39WUja5vmBkjHSJkAkMq41dscW9vHFmE58EdgOM52ly9Z4TtRB3hdEFuIgs9KqtiIQ7oplVFchTRsXJTuCKhJymobus221RRZ2Ddog49aaUQzR7X1BjIaVXKdMIwoUWIjZedpb6PVArEpprJNZJ5C44n/o0s/Hgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8981.eurprd04.prod.outlook.com (2603:10a6:10:2e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 10 Sep
 2024 15:41:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 15:40:59 +0000
Date: Tue, 10 Sep 2024 11:40:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH 1/3] arm64: dts: imx93-9x9-qsb: Enable sound-wm8962 sound
 card
Message-ID: <ZuBog9X4vhZXRlkm@lizhi-Precision-Tower-5810>
References: <1725952772-30357-1-git-send-email-shengjiu.wang@nxp.com>
 <1725952772-30357-2-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1725952772-30357-2-git-send-email-shengjiu.wang@nxp.com>
X-ClientProxiedBy: BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c01dd4c-88d8-4da2-614e-08dcd1aef82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C1S2wDiA3vRC71/M/X/Z2EwF02LOQv3bZhsq3LCpQk8CtdfQK1Ft5YeFDNy8?=
 =?us-ascii?Q?jBR98OyAH+4IhTHKUyt2R4Z2h0JgPTt1YIP83kXrItUJlvylXKxKZuXi+m82?=
 =?us-ascii?Q?IftfR56EXdi+1AY0bLw/KIPm2wegqGuA+vNM7n+vJc1cadLWJ3GYYy1ghxcZ?=
 =?us-ascii?Q?fFS4WCWnmfHkVr7QnWZCpQ38vYATjAN5HEdMaeIQ5S3ZwUmefVPlD+4kimaF?=
 =?us-ascii?Q?Rp1lX0dqkD3Bjcx+jynIHt6SAtZWnBKQPnv5yWZ5zSg2tDlDcSicVHIaAA0Z?=
 =?us-ascii?Q?7+BlI/yixDpuyKrHamHPA3/cDG3QcY/7Is8AQq6lWbdcRe7c55RkseuWi62Z?=
 =?us-ascii?Q?TZ7sp3uiL06OqacWNjiRN68PPgO2to4l4oeJtuBwzBLqa3XnDUZxqVsmH6TR?=
 =?us-ascii?Q?9Tyj+ywoV5kaz1Qiy3MZpPgkqHYm0Hi6FAFlnsn4UuyS4gBzUHf3l5Ys0h8Z?=
 =?us-ascii?Q?pjYooVRxQWUrkbk0C2UFORxkX2ZNZolZAKp+wKI0iBRv7LueY5SN0JWXJBSb?=
 =?us-ascii?Q?nBpz/LKz7j0P9ZHhxXQQf9Ht2QqG9wuxRjLOpUdau1f7HUgJGPLku3NBYnZE?=
 =?us-ascii?Q?mtllI4QgCpukH9oPOKaOgVNWuhJO8uEP5MjUKkcTUx+bcNUboOdloKvVKN/K?=
 =?us-ascii?Q?yT9ojWHfDvZzjDYZ0jbiV471UOdzzOGLgG6jE6XKn+dZ299pPXBk6/J6Drii?=
 =?us-ascii?Q?uXIUZVHihEjXCOEkShAy4bGHX7+GvMEqKxnexubaoLEYEmy3MJ/FMim3DIyb?=
 =?us-ascii?Q?VdCOOXg3tjt/8mVXplqiR6uToqy26HcEQv0vGw6+SPj1tFkqMYUNF3sP9Ole?=
 =?us-ascii?Q?Kq5GPjg94eenoexYjL49TKoK+kvUgYDXCIhoxFePCN6JbIs8QWVo2b1pTJSy?=
 =?us-ascii?Q?e6nAqE2tWLWt4QiT80TD/0McO924kIXy4j2sMfkzexrBaRygk36s5Ia/HJmt?=
 =?us-ascii?Q?N6Lwns5Kn2sQrfcFO6bL6hrSgt+WmeNdEzE+RZ+qGLYFLL7WsBNmsSai0tqm?=
 =?us-ascii?Q?tn66++v4Tr4ZCTFbjwMhgxSY6qOKnGokuuhLsCTHdCP21geuz0catQeXzRgL?=
 =?us-ascii?Q?MtT1dHup5ndjMIuuZ7LkU7MIase0qrppFK6IC9T+pW58KWg/XSfs/3K9a9GN?=
 =?us-ascii?Q?L/O6yrghLFEOIg3TUd3JtTIBjd6C4CU1tEJuki+nHrykqgG+qak9QJkCtbVP?=
 =?us-ascii?Q?cU0FNU7nG5e94QAkuvhsOVXaSGBErJuvVJuZcKJ/9LcARtHNQuSyNY9scs0h?=
 =?us-ascii?Q?Peo5qwOOncyhk+1u/3IPvCHRzUoL7vLQjACDIKbS09s1vVHH41pKzWCZEadB?=
 =?us-ascii?Q?35pj25+3fmaKxu/5QuGRHJPdVb+6g21HSWefedYij+TYZLO8dVH8OL5gAHQL?=
 =?us-ascii?Q?BaR9b8yOp+ihTenRV2zmc1LmkvfvpxR509te/SY3Hc57jG5E5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lYyftBAt67ZxFS3h5oEr0z9agvlCU1TX8TOHr8PvWDCQlqkI35quhIWhzNNl?=
 =?us-ascii?Q?sKdIlXXqon5FTbL5DlOXTXmF9QgNvV+zXcGmNrVblC3ZlMgJpdCqkJz9s3Hc?=
 =?us-ascii?Q?A72D3ftZB9F9vJGI41XVCSKJW+BT2BIOEcY7TZMwUbFuhNAwkwqbv2A3HMUq?=
 =?us-ascii?Q?VlS9EsBrmmwOMOnYXZqH+0M51Ai+xIxMQixyFQYt2mp6utcGR5HGteIDCWJi?=
 =?us-ascii?Q?CNkX2HrsgxtZ6ABVeoTbGlSvz3q2jt+UR8rjp71U5H0kA+uUwczzlUvOdqmw?=
 =?us-ascii?Q?+K798UKDVP10/7dphF4uSbnNzR0tOggAK9K2WVv1A9JCBzfGmVuMlDopYh6N?=
 =?us-ascii?Q?dOgDDve+R/irFl6ikw7Dr9okX1wNgzj1kw1rxXXxWywDr8NklvAmVUOw1apD?=
 =?us-ascii?Q?rt2jiPNNBdMe2GIj94uwW21wANAlQHLZ7W/E57g4eoP8fdCVC4SdYoL63TOh?=
 =?us-ascii?Q?0wegmxD/SFRuxnzwrvsABako4QmkbweoXY4GwqivhYzsGzxMARTXe8zCgmQI?=
 =?us-ascii?Q?ESNt+tSOWdltGbz7ntMd9+JMa7bqFOsZUwoAgai1jKQHJGIzpwsP80Ed/leK?=
 =?us-ascii?Q?7j7hx021LXLYdRv+NJ573bPrjf7YGpX9oD7PHCvgtnyARBn6Jkgwp0FAaJ+c?=
 =?us-ascii?Q?xz0+Z1PZiFu/u5t0SeRs2fH1Cn8GfXaiCA3T2Ve5IgnYIN97B63K5Y3LY5jt?=
 =?us-ascii?Q?X3Ofw2FcuEXK33tZWa86gVexOcCMcxomqcFbvl8pQlG76CTuo0TWs/AECPXt?=
 =?us-ascii?Q?eLFQLOjCIzXWhxHOJsnWY2Vzb70X5QPmtc4e/p+HFVE5XoCR3CYHguvf8Heg?=
 =?us-ascii?Q?3YrmqMosOE2W4sC/KapjGLVgWS6SLIbFd1CvN1vrSJ9NzpH356m6XClqysnD?=
 =?us-ascii?Q?ILioB51/fDT6Ai48F2UCwvIgEXJkdu17S9+1DnrO+N6CvCviZa1FqNj9pBDH?=
 =?us-ascii?Q?2zwD2ZzvAaZ4jXSXAe74RXNkWkmeDuDxRAgmOzJRsGc0tiPpNhk0lI/FIVjK?=
 =?us-ascii?Q?W1s/VVmmN+J2HbJ2U0f5cIKmHcfv2Ewrh5qxaxdPLcaMNZORYR4slMAN0XDn?=
 =?us-ascii?Q?9VI7GcGhgB1V7ezYIAInMGIBzt9bBuwUasEGZOayBGSPHD6Bp3nF/FHi2xbX?=
 =?us-ascii?Q?pFw9yFZGLmTKocfDIRrOpcK6XA8AHLVHzQ6YlMprYvWDLXc08GnHpQeo3o+f?=
 =?us-ascii?Q?BO7DgOgnkyeQE3iMtkXpO0/nrGkXUBJGid39gklFudI+Xodam7x3tKiAtmNV?=
 =?us-ascii?Q?soB2EQY6fZZ47BFGNgQqZvISiG6rEhhazks8jFVQzSTEkAdgKNpeGdBi0Wpy?=
 =?us-ascii?Q?AjhNq1SvLJixgO0VqHFBQVyjzEdINFYRYXcc5qi0Dwx6OpNLEhTeyY5Z0Lnx?=
 =?us-ascii?Q?BQNdkHDLq5YEtjSslmwy9kmfRXhDPzwMAMkq3tIT4OgaWbXvkKsjytsq78Th?=
 =?us-ascii?Q?FevYu1J6U7OCa+9tfHLr220miDZrE1dyNGN3g31DmIt+4BBtnzVgllZMj0ne?=
 =?us-ascii?Q?QT5gZuyxE43HB89p+KzJsbiz8QEYKJycJvHK02opvWpM+vh3TD0dFjtRK9T0?=
 =?us-ascii?Q?eJ0LUrW/20/EZRZQKuQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c01dd4c-88d8-4da2-614e-08dcd1aef82b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 15:40:59.9278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evnzw68wQujKgr22o/3Utquu+hifXZAhhkt9mvMSJ6OHsdKCUur46lm7pr1Vz9SPR6Nr232umfolhPeD0dbi5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8981

On Tue, Sep 10, 2024 at 03:19:30PM +0800, Shengjiu Wang wrote:
> Add wm8962 sound card which connects to sai3. The connection
> of SAI3 and wm8962 is controlled by PCAL6524HEAZ module, add
> gpio-hog for it.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../boot/dts/freescale/imx93-9x9-qsb.dts      | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> index f8a73612fa05..336333919a74 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> @@ -61,6 +61,15 @@ vdevbuffer: vdevbuffer@a4020000 {
>
>  	};
>
> +	reg_audio_pwr: regulator-audio-pwr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "audio-pwr";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&pcal6524 16 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +

sort by node name, it should be after regulator-adc-vref.

>  	reg_vref_1v8: regulator-adc-vref {
>  		compatible = "regulator-fixed";
>  		regulator-name = "VREF_1V8";
> @@ -88,6 +97,22 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>  		enable-active-high;
>  		off-on-delay-us = <12000>;
>  	};
> +
> +	sound-wm8962 {
> +		compatible = "fsl,imx-audio-wm8962";
> +		model = "wm8962-audio";
> +		audio-cpu = <&sai3>;
> +		audio-codec = <&wm8962>;
> +		hp-det-gpio = <&pcal6524 4 GPIO_ACTIVE_HIGH>;
> +		audio-routing =
> +			"Headphone Jack", "HPOUTL",
> +			"Headphone Jack", "HPOUTR",
> +			"Ext Spk", "SPKOUTL",
> +			"Ext Spk", "SPKOUTR",
> +			"AMIC", "MICBIAS",
> +			"IN3R", "AMIC",
> +			"IN1R", "AMIC";
> +	};
>  };
>
>  &adc1 {
> @@ -136,6 +161,28 @@ &lpi2c1 {
>  	pinctrl-0 = <&pinctrl_lpi2c1>;
>  	status = "okay";
>
> +	wm8962: codec@1a {
> +		compatible = "wlf,wm8962";
> +		reg = <0x1a>;
> +		clocks = <&clk IMX93_CLK_SAI3_GATE>;
> +		DCVDD-supply = <&reg_audio_pwr>;
> +		DBVDD-supply = <&reg_audio_pwr>;
> +		AVDD-supply = <&reg_audio_pwr>;
> +		CPVDD-supply = <&reg_audio_pwr>;
> +		MICVDD-supply = <&reg_audio_pwr>;
> +		PLLVDD-supply = <&reg_audio_pwr>;
> +		SPKVDD1-supply = <&reg_audio_pwr>;
> +		SPKVDD2-supply = <&reg_audio_pwr>;
> +		gpio-cfg = <
> +			0x0000 /* 0:Default */
> +			0x0000 /* 1:Default */
> +			0x0000 /* 2:FN_DMICCLK */
> +			0x0000 /* 3:Default */
> +			0x0000 /* 4:FN_DMICCDAT */
> +			0x0000 /* 5:Default */
> +		>;
> +	};
> +
>  	ptn5110: tcpc@50 {
>  		compatible = "nxp,ptn5110", "tcpci";
>  		reg = <0x50>;
> @@ -194,6 +241,12 @@ pcal6524: gpio@22 {
>  		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_pcal6524>;
> +
> +		exp-sel-hog {
> +			gpio-hog;
> +			gpios = <22 GPIO_ACTIVE_HIGH>;
> +			output-low;
> +		};
>  	};
>
>  	pmic@25 {
> @@ -286,6 +339,17 @@ &mu2 {
>  	status = "okay";
>  };
>
> +&sai3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai3>;
> +	assigned-clocks = <&clk IMX93_CLK_SAI3>;
> +	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
> +	assigned-clock-rates = <12288000>;
> +	fsl,sai-mclk-direction-output;
> +	fsl,sai-synchronous-rx;
> +	status = "okay";
> +};
> +
>  &usbotg1 {
>  	dr_mode = "otg";
>  	hnp-disable;
> @@ -443,6 +507,16 @@ MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
>  		>;
>  	};
>
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins = <
> +			MX93_PAD_GPIO_IO12__SAI3_RX_SYNC		0x31e
> +			MX93_PAD_GPIO_IO18__SAI3_RX_BCLK		0x31e
> +			MX93_PAD_GPIO_IO17__SAI3_MCLK			0x31e
> +			MX93_PAD_GPIO_IO19__SAI3_TX_DATA00		0x31e
> +			MX93_PAD_GPIO_IO20__SAI3_RX_DATA00		0x31e
> +		>;
> +	};
> +
>  	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
>  		fsl,pins = <
>  			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
> --
> 2.34.1
>

