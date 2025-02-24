Return-Path: <linux-kernel+bounces-529902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C149BA42C45
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAD116C402
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D2E1EDA0C;
	Mon, 24 Feb 2025 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IGNI1Ry9"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4DC1E5B95;
	Mon, 24 Feb 2025 19:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423893; cv=fail; b=kTcdmiM9dovNl0WX/VCwjr6dEIZ1kYHYGr4k5QPf0iQQptHtMZ/3WV0m9UjpD1EuhIBT+fOyCuMQ7gGngqHGtVibMjJedr00kVYuj7HM0BZZyeD1hZQ8vVkWS+HVOIPq8BpMs44K6iumYOtResjl4faXYv7x5hY7CS+sdYHy0L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423893; c=relaxed/simple;
	bh=G+5sL2ogl3PK0gxtXxNm0EGulyVAwIM/aviHmwELMJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T8EhCTZ6ofjncSJSeLkaTGrog276mKY6Do33OdiNw3ojFHkeZZnEA9O3kmdlEHbPjBmVdljl2sJsx95xJX3ko1F8azNQrHjt9F2uEY/KmUwNR6iaoNq5MGxhct831i4klyaLZr6ea/QcBVRwmohzfC1s4IojdEywHIrArFrKJaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IGNI1Ry9; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UspN0aNiRCra6TLKBiFCXyMIfZrL0ygWYksbbbNSDftKqqlXfzPDaXB5rF02y7Jh1DuBNw42hZHlIXmGTNqgI+/Tz2AmkfMtK68QAYopcORYg3ZN4bWgqMeeqSIgl+LCl4d8Rl+UxAM9VaCUoX9cOU61rZqUWUMm2YkROqPS9IjDQQMVm9mFaPSlb3r2slIzwZW1P/yjtl6940d1HvT2IdRgygDJKQCiQqklwkLKth/5Cho3eHXVCbTjo/YikiTqyQ2q2vOuo+/pu+eN7XsoF1V2NXMzRZYD+gDnw7u7I4U7MJjiKXy7zp2L7/QxO7EghpYQU6c/S+Kl42mKUQ+mcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=furm8ePHx7GiDEpKffogWww0Jp8Tof7ype/3Y3k+3Ek=;
 b=oewEkto/2nRPai1UkwVdmtSWE3npzZ4glZiSyherm7yL84GG47NCdHX32eOMxH2XI5qTKPRm1vkEtlnIZVValnu3Gs35IdWYn759F3opvfKDUMk1ULAf8Ro3BUc36JZTRKSI0qfdJrz1Xqj2fo54zgKvQMo7yzxtnXNuwzbzYLRwsvvbVVbtu7YhxU4WZhq1MbEC08mmeSwbYbVwxfpxei+imSto7CO9MQ2KwAtukq/weJuNkGNuJME5WzKKNZ7s0GsfVAuqb1jC33hJrYt2E8uUSj+6I5gXAnt7aDpMqARKPuvxQNJ4GMVYvzsjXz4EB4s1HXZ8thyLDx5Qrm/vXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=furm8ePHx7GiDEpKffogWww0Jp8Tof7ype/3Y3k+3Ek=;
 b=IGNI1Ry9TbeVhNpYwjkCRYRY6ZkTN3czbFCQB/PSlx0M+EerGPEcq9I+fds9bHmO5m7zjjPZRq+Boc9ATbcd7EH3J3eMKdA1oWRnub1fDKQYab8iYtP9uMo2nbkcgK34IbCQHMFOt0TrBY7JJTwBLc0QIEWSR/iMZ+9yJT2Zy9z2axbryeEdUoYDfPwfmDZTNnru9aX4iJMTlFp3EBV3u4tMSHQx8n2TV7BxsNOIe0ZmASSKbPPMum++/Ozj4UC5frdtcEskMKUrB6Sh59xFxsl0iY6Ns2xgJwsGRsK5dskO3bJ+zTxVmiOMMpGP99e5aQQK12FKr7q6uEdsJCMuBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9333.eurprd04.prod.outlook.com (2603:10a6:20b:4df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 19:04:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 19:04:48 +0000
Date: Mon, 24 Feb 2025 14:04:40 -0500
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH 5/5] arm64: dts: mba8xx: Add PCIe support
Message-ID: <Z7zCyHtpKo0WAPMh@lizhi-Precision-Tower-5810>
References: <20250107140110.982215-1-alexander.stein@ew.tq-group.com>
 <20250107140110.982215-6-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107140110.982215-6-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: BYAPR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:74::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac97f9e-bce3-41a1-30be-08dd55061bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|1800799024|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?et+yRVKO0FLu7l8+VjW+mKmW8314LL2C8VXBlh9njVpW+IScpzCkBumAEQMO?=
 =?us-ascii?Q?xx1+tSlSyQ3rgbJaldMg/dXlKG1V9eRLkr/uoaGY6b9SdzwlHlDQ8JJ5NSXE?=
 =?us-ascii?Q?LHZu2uIlMKdkEtya5VshvHvuJ5q27cv96Nf+sOutG7PH+cPWCwavBfkPfuTW?=
 =?us-ascii?Q?ZabHsfzmDRp4LwQJi6duMdM0E5Xd6K3SreUgKG62p/mZCSqyfCPGsNXM3afB?=
 =?us-ascii?Q?jVLG4/ro3wWYbpo0qgDANCEPNV5rsOarz0jHgL7svfMstiiBqGm+NiUvPrCB?=
 =?us-ascii?Q?OudWdpeYGIszNf6yaW5aFOMYdgIUklU/9F2DdfTWsCdPatd5032UA/WYQl3a?=
 =?us-ascii?Q?CD/7NZHhacfcO8HHcRlJbQtnNH69H2f2JOrLA22NhbryHqTi8cvb5u8sXdSS?=
 =?us-ascii?Q?1+/oHwqn0ma7tKH2vJ5p8nycXNpqu+Eyp2em2eYIVd5YhdBRW0LA0H/ARQKJ?=
 =?us-ascii?Q?vgCd9VKgFsT+SWtK16P19585GKNhkMHOU05OG+od/WlWvMMcyPZf5hcGlb8k?=
 =?us-ascii?Q?jzss6mtbtJBRnvo+bBCGrx2QMw4hHpx0cQSWAZVDuP9QSfQTKssXmvAOretY?=
 =?us-ascii?Q?hAfkEi4lCF9h8cbOoQFDnLbYibS5YTJADL1QkV+DmGQzKjO0G/cPUnTv/CfY?=
 =?us-ascii?Q?dhePViE/qERs79tEry9fbBL9ndfI5ZEcCu78CYxH88y1UYCbWAOTUTPSkfxo?=
 =?us-ascii?Q?7G5l5hy31AY4Yy5eHmqGHlixWuoulDttNOIv+TB1VzHXSd0OUWvHw84zgo7B?=
 =?us-ascii?Q?AEL9z/szWPPbQeeYY+wlTr71YuJ1j+cJDuL6AHPY02CsplRTYEX83537LUdF?=
 =?us-ascii?Q?mld1tW92J+Tmz99CWHGj60VPJhsEeb18XggXPMvla+KB0e2QZ5V6ezE58XIA?=
 =?us-ascii?Q?O+y6GBpMRT2yBKNHapCbymi0EQJnwUjhh8M6mTQuok+wc5ihv1bKifSUn38z?=
 =?us-ascii?Q?Krk0dXdQjMIDeAL3RuZZGqMngPPm6jWWsJXPHQWCOV38BlSzvK1mXq7Dk0UL?=
 =?us-ascii?Q?EtQH5AycYwZLj16GKcz4yyxgXlJzOakjGebzA63+lbRrC0SiIaqrjBTCKly4?=
 =?us-ascii?Q?xlQ7TTofy9Nw5w3gHPEto+TicdFEbm+zaUNJuEdaMOAnSTth+6KutuKhl5n8?=
 =?us-ascii?Q?pixUOS5o89B4pOkjKuIyzxcNnTBYUuTLdXq0gr1heVbBRkosNyjU2BZumhoq?=
 =?us-ascii?Q?RP/36VzvOpMJFey7vb97f7tFrQ4RveMfui4PTAk5BrpJM+36eblO13/x3BnB?=
 =?us-ascii?Q?DSULB97WXte/HyJ80GPdWdARx53B0tSeBfRQ6V4svDe3pxqgOGPwAMpNXXnM?=
 =?us-ascii?Q?bSuhU/Ea1q2q3z/7IUb4Hdp68ddpE8MCCQsBuv8gFCeoJtsIYqDubHQsadXm?=
 =?us-ascii?Q?V5/Jk9FIM3bqN/qzEcP8eOyNZ3bm/1K6bGQoIWKjaGYqPhGAJn57mz8vrL7a?=
 =?us-ascii?Q?sFRA2aebTJXyZdnsT4FHMhFegu+z6kK9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(1800799024)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HWULD3I0RNG+glHo7pG2aEE+rNbcuoxwgv7bh7MEgKvzBzW+isSGeaa4r288?=
 =?us-ascii?Q?1si5QTMhRRBYJA9IAcyfPDNM09Uf6GsLKDNHey5E2BfNgjq25HvErSw/BOc+?=
 =?us-ascii?Q?WDZjI0nHo03CvGhdfVNukN8k3iOOdfyCawjgXc0XJZhQK4MAiJhReoo3JsIT?=
 =?us-ascii?Q?fEnckAUDbmPCHd89a1bMHrP8pqAqxbxw1rg8oCkA3D52FQppoIfBqoxm4DyF?=
 =?us-ascii?Q?4YNeJe70W83KCYUJ/chvQKlcqM7Uev02J5kfbeEyWsd0HvjSDo4IN0ek7CKP?=
 =?us-ascii?Q?NxMfDBzvSTZzvCbO7+9IRyP7/3hGAdcwmrIii9lm6LALjc2RzxnjdFbZP0Nb?=
 =?us-ascii?Q?ZjfUlWIzylbTkuKeCqcLc+Wk9qxW9qGJISKQq+bp4794UZfaK94W+eHkuKE2?=
 =?us-ascii?Q?nzMpmKYNux8ekeTJvKYDBuIxngn+TQ3Umf4bWmKwggkw5N4uHajgxBbjETIk?=
 =?us-ascii?Q?bcDqL3oSCB3MfeCw4dj9nlNL/UWmzVG/6mD7w5LG8y/xJsFWyOda+YXwGhyu?=
 =?us-ascii?Q?qksCiJzWfmK3LlICXvDrUv6UGuNJqd7Nfwc/8OtjFDppxysRV26bC40eHft5?=
 =?us-ascii?Q?D5jdRt2uDdV6wmgWGIkqw3piX9UvbmNOdIzWUauXMU6s+yrRywiXbPJT3KJk?=
 =?us-ascii?Q?1J2lhDCOpT/h6HbDSCyPNrHesqTirSCoGvVXRkn3w2C/Sbfco8gqtiCpTV6X?=
 =?us-ascii?Q?nZgFo3CoCS1eQnlYEkw3rTrv6R00lRNAWAhjhOozzVF7aJUnYCLODhiIZqDL?=
 =?us-ascii?Q?xUIxskUBU2ZyQ7DDvPXmKuVtMxZVFXy1Qm+t3N9UN6Emvp9nAfCbsjOYutGU?=
 =?us-ascii?Q?Lp3RSFhxx1IMHWkruAQBWsZO6P71ELCgi870CxrMXga0Amlm/HRx8k1YK3at?=
 =?us-ascii?Q?RTeHz1XPONgYi3jdsvF8mQHrJbCK7vK3T4zIiQMfeRz4D+BpQ9eKFUlJPlEF?=
 =?us-ascii?Q?KrmW9JuB6T/Um7fYCRYXf6ERun476eWY7uWC0xBBTPpdlTfLvEttX13afbNS?=
 =?us-ascii?Q?1V/xFYsM8CFUmG4I+eLq2RfpN2btRnp2UmdwB1Rcky6+q43GkOS2WC1CGtJl?=
 =?us-ascii?Q?K15mjFhsAI2Nt6zi/EioAb1HeCdrwhQqiyWT5xo0mFTIT4NjRF+dqpbiHj7Z?=
 =?us-ascii?Q?HXMa+dNN6DNStElU/x0neDa+/80qkd1iDygO3hkHHoObFbBvgfmcX9NrLHW4?=
 =?us-ascii?Q?kQ4HqF97JToW3Ep4ToEteOcrsJlkDM8rRrp1D1rzg5vc34zAGIP9eML/dmf8?=
 =?us-ascii?Q?yTk4+Zcj0+mJO2BKJ7N1R9Dmzb+1INCuuyRTfXBg6egM/XWF6UZ/58LzD9w3?=
 =?us-ascii?Q?MXtbnlbB4smWi2z7TiI5xTUwdJEoMg6N+6lQ1mTCH9wBBKbrZyMe1KDo35Gy?=
 =?us-ascii?Q?KXAx34s647HCyWt1kywHRZyrpGHBLebXPp+rv8ZZjzqEFdayWcUs+AjUbu3w?=
 =?us-ascii?Q?f05i+OwkfifTLb8/O4tPByjZOyxwbNwJbvoFzMy0zP3UbHk6B3ENa8RFJZk6?=
 =?us-ascii?Q?iiC0NOxwFy70qY5Yj2c+zfJcnOJc5gLdT1zj3W0V3ruo9XZqvgU5znOmi0Ih?=
 =?us-ascii?Q?YNNfvolF0T4amoILHKA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac97f9e-bce3-41a1-30be-08dd55061bc2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 19:04:48.2032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qg9VNGMufBsbYQSPGHC2TK6faSj0uLzzEdC/2NnQBADGnP75D/g7DgBGHg/Ro0VzJJgn32PMZ6zGJnmgiGm/9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9333

On Tue, Jan 07, 2025 at 03:01:10PM +0100, Alexander Stein wrote:
> Add PCIe support for TQMa8Xx on MBa8Xx board.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  arch/arm64/boot/dts/freescale/mba8xx.dtsi | 32 +++++++++++++++++++----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/mba8xx.dtsi b/arch/arm64/boot/dts/freescale/mba8xx.dtsi
> index 276d1683b03bb..117f657283191 100644
> --- a/arch/arm64/boot/dts/freescale/mba8xx.dtsi
> +++ b/arch/arm64/boot/dts/freescale/mba8xx.dtsi
> @@ -36,6 +36,13 @@ chosen {
>  		stdout-path = &lpuart1;
>  	};
>
> +	/* Non-controllable PCIe reference clock generator */
> +	pcie_refclk: clock-pcie-ref {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +	};
> +
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  		pinctrl-names = "default";
> @@ -208,6 +215,12 @@ &flexcan2 {
>  	status = "okay";
>  };
>
> +&hsio_phy {
> +	fsl,hsio-cfg = "pciea-x2-pcieb";
> +	fsl,refclk-pad-mode = "input";
> +	status = "okay";
> +};
> +
>  &i2c1 {
>  	tlv320aic3x04: audio-codec@18 {
>  		compatible = "ti,tlv320aic32x4";
> @@ -309,7 +322,16 @@ &lsio_gpio3 {
>  			  "", "", "", "";
>  };
>
> -/* TODO: Mini-PCIe */
> +&pcieb {
> +	phys = <&hsio_phy 0 PHY_TYPE_PCIE 0>;
> +	phy-names = "pcie-phy";
> +	pinctrl-0 = <&pinctrl_pcieb>;
> +	pinctrl-names = "default";
> +	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
> +	disable-gpio = <&expander 7 GPIO_ACTIVE_LOW>;

"disable-gpio" is undocument property.

Frank Li

> +	vpcie-supply = <&reg_pcie_1v5>;
> +	status = "okay";
> +};
>
>  &sai1 {
>  	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> @@ -467,10 +489,10 @@ pinctrl_pca9538: pca9538grp {
>  		fsl,pins = <IMX8QXP_USDHC1_RESET_B_LSIO_GPIO4_IO19	0x00000020>;
>  	};
>
> -	pinctrl_pcieb: pcieagrp {
> -		fsl,pins = <IMX8QXP_PCIE_CTRL0_PERST_B_LSIO_GPIO4_IO00	0x06000041>,
> -			   <IMX8QXP_PCIE_CTRL0_CLKREQ_B_LSIO_GPIO4_IO01	0x06000041>,
> -			   <IMX8QXP_PCIE_CTRL0_WAKE_B_LSIO_GPIO4_IO02	0x04000041>;
> +	pinctrl_pcieb: pciebgrp {
> +		fsl,pins = <IMX8QXP_PCIE_CTRL0_PERST_B_LSIO_GPIO4_IO00		0x06000041>,
> +			   <IMX8QXP_PCIE_CTRL0_CLKREQ_B_HSIO_PCIE0_CLKREQ_B	0x06000041>,
> +			   <IMX8QXP_PCIE_CTRL0_WAKE_B_LSIO_GPIO4_IO02		0x04000041>;
>  	};
>
>  	pinctrl_reg_pcie_1v5: regpcie1v5grp {
> --
> 2.34.1
>

