Return-Path: <linux-kernel+bounces-556312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB03A5C3EF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5D2176FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBA725C6E0;
	Tue, 11 Mar 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BNEH+sJZ"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BFE79EA;
	Tue, 11 Mar 2025 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703774; cv=fail; b=AvEXmnKG9hHUkokV+9HVCk7aIHyYCalQlGtTg9V4qd0tEwuioGz/xoPPPdHG+7KrW1bQYUdbT0e+BHd0bOXgA2xVPsu4iCZbRN9d3abB+d4vaDkMjt6ffmLCpmHTCR+z/XBnLP2cn7NCZrvSTc0r546Xn2TmnEL5neaAx6Wj1OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703774; c=relaxed/simple;
	bh=GHwGnpmgnk1xtghlnDT7NcHEGLjsXvmuTyL6wdBT0jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S5dk0lY+sWxmhJYIS7Y+1X+vmzNTwLu/XvbtB6WyrqHe12viBZo4+HPZOAlITBGlBD47z6gO43jDbB4qucrcKujhfjmL0k7dmrvFTLkxJiaT7188IAqzODiz06/d4FRie8z6ky4yYdFNdN541+GWft9GS92qFjY7oVKJuRHSU2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BNEH+sJZ; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLncpX2Cl2rG+Dhgd6edvNKjJJfV8HEHtlPxRYozz7bdb+lknRAGBb9hPGcFYQqZzTqBpJwBWFUAivZDW1L7jSnvhduJRosckDqYem+EFRQeyrU+13uWEuFkjjZKtBKFUgzJDdG2AG15lZGXC/zQlMv/l1KLIJAnE69HLJiHzwt6EqSDzTH/3Bis5MO6Z8ak4lQOtHSihrfAbJP2C7+6mAhXqYmnP9FBaHrRPaNh4BSOgujnmdS69zRA2zJ5NIbzqCYOJukPTutMD/nz2+F/NgUJVzEpGQT5/5GSittUpWAl3RbswrXXRc9L8+7ubffO8Es0umun2jmLxIEXbUiapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1Oh2kTBQIPhsH+tgki5spNkWnJkN8LF77NKI0Tn/tk=;
 b=HScYI783yVottIhMtFT3LUGoIFc53jH6h5D9vumViJIsXh+mfNbna58CX9ueYywrPJCQj+cH9eSPMfnkZhpRDinNTIHmii6hOnY9pRIl/ynF6IB/PyaXtKZ2g9ZlK3Lp0souIl1Gd3ie5vBTic57hG7x7Q0mJNULt4nw5tiIrn4ANunAt0GIek4v7GyhDllWyUIS1FTESE7YwNX4qahwiop2/sKdvo4io+4rqNf4s22KJSEUcmddtl03ZsZEbfPdVnyqy6P1zN/KtjVVeXLFv7ubRuL7fSvjkPQylHJBpa2VFuJMdVgPZInu6g4NMNWVnsCUiX0uh4P/IVxjlWGiOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1Oh2kTBQIPhsH+tgki5spNkWnJkN8LF77NKI0Tn/tk=;
 b=BNEH+sJZKpwdCe73Sg2he9H9eBVCEVewZWGryUvn19n16KLK8ECQLXkSyyy6jW7GLJNI6Otc3VU6DMZYwALuSaItYGW0Bc8+iB5/al41zKN6EoNY8B2h89ZluCGF+l/LMQpsyfoHFsJzPNjSRGlV7OyCZof/QA0jtZPKOxVqIQpgmrZ7h1RE0fBn52xnKrnrqiNgTQEWwPnPOxHnSf2/vpZugvD/I7F1obt75LOvFFTet5FTPVr2FDaHxOO1ECIS5qOiFuRbPzPnPAyf5SKyqkH22cqy7A0RuRNnKKsomxP1e+3bRpPusaaJShnboapTNrwnlyyTfEfzjVAxxQszgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10506.eurprd04.prod.outlook.com (2603:10a6:102:41e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:36:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 14:36:09 +0000
Date: Tue, 11 Mar 2025 10:36:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 3/5] arm64: dts: imx8ulp-evk: add nxp secure enclave
 firmware
Message-ID: <Z9BKUBlcF2W2oBEp@lizhi-Precision-Tower-5810>
References: <20250311-imx-se-if-v13-0-9cc6d8fd6d1c@nxp.com>
 <20250311-imx-se-if-v13-3-9cc6d8fd6d1c@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-imx-se-if-v13-3-9cc6d8fd6d1c@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10506:EE_
X-MS-Office365-Filtering-Correlation-Id: ec52da24-4cb3-484b-353d-08dd60aa1095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AtGHTxVbwb/bTcHjUClqkCHErz6YaEk2kQceljkeBQ8A0H98VnUjKrDXFzu/?=
 =?us-ascii?Q?N0sVEgTG9MVNgxTtKZHOMEsNIDIe9ZBahteCB68dHtxmhO1H3dhS5sIQrKTW?=
 =?us-ascii?Q?8adchi9wvUIZEZ1A8qJo9kzDOpCqItY5c5Y7IUWkLkmyTZqCwvTU7yuHrxEz?=
 =?us-ascii?Q?pKNaqFq3WUD7Y7fu10eamaObnG7hmi6/DoC3Nr/l0PF6wj+WFBtmwtCDgf4p?=
 =?us-ascii?Q?Xvz3/awxENNE7A14eJfPSgxUTnWZ7VIdQrI1sYD7uu5F0UzjBLPF6DNn0MDH?=
 =?us-ascii?Q?pFOnfplxN9DaxCxIYd8ZRM0wWhm0Nmm7Txi/YMocmzS6ftHpw+9z5emgsb4p?=
 =?us-ascii?Q?UgcO/iVEdJ/8w4RgS6DF7tjKXqiis2kiUUBsYhqxcqr6igAk6+BVADc1wZrL?=
 =?us-ascii?Q?MHmmBVrJF+SRivEkwHJ7qC3IPCZ2BfO3HP0RlHFCXXHjI/ovQitS67myF1KH?=
 =?us-ascii?Q?clcxYe+PqMSkZv+3g4QfK+rHdMsBvAoL5u6pyQ/J54i0cAIzbXrfpE5Pa9Fi?=
 =?us-ascii?Q?RxtwfZokTdaMysqpSMT+HvH393UfKlh3hTtk/G3slSOnkPk8iri79hrM+mET?=
 =?us-ascii?Q?HQ2Zi65N/YkmBuw9gKIVuE1Fy6m+THp5Y50hMB9iAksZ3YPhOEz8TpwsItTl?=
 =?us-ascii?Q?K3tYeM1D2qfx4DVuOXhpRzOkUIPvtTmrkajot4Q7uK+vjot8Oo+3ir/ZO3ne?=
 =?us-ascii?Q?UAczuyVvj4Y81Oznn/oV85od+Knh9sWVGC92ZxT5TbCjVRCByXDYAeX8lUoq?=
 =?us-ascii?Q?0/1Ar4bFXSUVP4usQJq6tbJhvNEuyyMHWjrauXZClE3o3AQreOyqwPWgSRzr?=
 =?us-ascii?Q?lk5Q97SdyowT7qbA6Tn4wiNTeL8fGvx2yHjn5kWA5Sqoe768p719YtXEiM5h?=
 =?us-ascii?Q?sZRJq/1m4QT9XX+/tJQDoQUJGVAjYVe9ZaFiAOcQpDMq0cC8UYUXkwHIbsi8?=
 =?us-ascii?Q?LBoO+VvhwlC6wFIovfYwQuopTAygDaWA7BjCca6ZkP7mtbUdN6ZrGVvh+e9s?=
 =?us-ascii?Q?FOT+xxAjG0yThV5BGJTqOtUs6rziv4MBL3XDYGzC0u5V7EfD1AMnb1VLjk4f?=
 =?us-ascii?Q?/kugC2D92zKmSCXx/nlDaGp2Z5UGuluxZR7U0n7eiDKlugAYfASP+YRi0uC+?=
 =?us-ascii?Q?hgL/+ye+0M8DIcHxIvheYYb5BL8ve63yqKKQIIre+HDgmoa/iTkozqvQ7OfG?=
 =?us-ascii?Q?uAPb9t0GnIKzfgtOB1Ae3kG9NKiBdKRyRnvlLv/Fgdcs/mesRHZS7EiptLrG?=
 =?us-ascii?Q?oqQing+HEL6h1SQnX8zonq8EteJfFllpERd52Ycixzi9JKF/gOsjU5RjoYbx?=
 =?us-ascii?Q?Uwn0CBS7VnoB3M3Zcv32F6wye8VTvmkfigCgGPJ8gXmkHOoaiYBgkEh6UJ0K?=
 =?us-ascii?Q?K399bDWFo15xh5Y0dp72ECOSUbgvupHmh2xBZbLlXelumnN4ZLy+e1v02oWS?=
 =?us-ascii?Q?aF4JaacaTWASnEzeqaluVXbMgXOoMS9T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nl30aAD/KKiLjKYFoTZrYaNAhBdMtM18nSr2pXdVwRiLz5NhzfAzPBX426Jm?=
 =?us-ascii?Q?lmCWu6snhMOZRFzOnKstzIuzuLcH3apPoN/vWe83rzo8i/nGgzVnxXrfiULx?=
 =?us-ascii?Q?m1StU0qJB1+PRM8Zesns2AdmXycoqsWrQlfifBKDGR3D4Fk15aLzamX5HFTd?=
 =?us-ascii?Q?lMHZrojDrpibIaMKVtUlgpjovuV+Z49olAFuZIpcwFvP20K0l6ruqBEFxdxf?=
 =?us-ascii?Q?q/9nsc1t05Bf6DvKtqc2M1iJ8PUM2AtVNs6wYRSaAJgDWI65lROHsNym1aMo?=
 =?us-ascii?Q?4K6oglsqtndhzZx9PSrriuOCc7fVuojiGUa5s86AP9pHX31MKuhoyuLnJ1Gy?=
 =?us-ascii?Q?1s/QdTQiKwcwWnLdz/mak5qnZBcf7Fh/zsMEd2NzIqhdFZEtwyHIB+/u3w1l?=
 =?us-ascii?Q?AJNPCBYGZYoxNIma07/3DKri6AX54alFuxcp21+UmhAKZW7AFrmqiECvwRxN?=
 =?us-ascii?Q?VriDsCF/aOKuvRMHIgLO93I/l+M+GmCHC/GYS2IaFSExHr+3vJTEriWjqTXa?=
 =?us-ascii?Q?ob2jTLIURV0BMYi7WnowFSvxdCqsht+2/MoarRfqd0djlUfyeeUD6GYbnSr7?=
 =?us-ascii?Q?ysoTSOoHNj4DZsSYj5JehF2psNhMY0Oe+kwMi2f4o+8Pv4Oqi8VoSlILWbsX?=
 =?us-ascii?Q?PRpx3EU3JhigqpWAhCLX2UVg/5B1wJNyRSXaAKqtLLUs1Q6918i722MR48YC?=
 =?us-ascii?Q?huYPOesygvewGnMAHESF7NjBn82lG90XLY4mr1X5bY3BPF1j915gOzSIi7c3?=
 =?us-ascii?Q?eJuSpJ+KMbD3KnJLqQ6KXIJ1JLVJv8vw/bZmP59u45+ACD0aRuW5QBShTodO?=
 =?us-ascii?Q?g1AnaXQuK/1saTqLh17ZdST4KbRg6Psrg7o2mizMCx83AXwfF5gTur3weJL8?=
 =?us-ascii?Q?1xVdoRH5Ra4A7rthx6E5PoJlHgy9ixSEK4VnoplodRIOKRKrT7shGcS5DPP2?=
 =?us-ascii?Q?LIMM0Ac6XrTG+X7HHNX0x6AapFoJ79+7WFh5gCkRodo98S4JTrabJMGFCAhv?=
 =?us-ascii?Q?2MweTmaWozICJjUy99vNX60WjFELwrwTSqQdEUK0lKlDio3AGwSpWyXDlOyU?=
 =?us-ascii?Q?4GTn0vHMPKRJ6sXWmzKrR2F8JDi3ehpO3PjUUkgG8DMH9RThwvhnRQCIes2K?=
 =?us-ascii?Q?aWERmoS5mfxiLtgliH89PkI4H3to5efSdAWktG3gc/W+ptzLX33Ou5m2RX9H?=
 =?us-ascii?Q?CxCLAlV7T00gx8Y8x6XlL6u+PMmLDoiu8a13dO2d21Hbl7dlr8ehyLqGxOLw?=
 =?us-ascii?Q?qP67cHmKG1SdB21RicHM9W4l1tHixT+bBm/kaT0paWLTG2PHWRPhjloKOEWa?=
 =?us-ascii?Q?iWZUwHrJuVhXHxrLxwsxJAjUdfEJzr/TlIM0y0nDnOGGtfl2Y5B8PISgvQdN?=
 =?us-ascii?Q?RKReOsp0dkSGkrAFjMQwE5wS2U5nVsa3qHIJ2t0wCOcXp+TkEjnS8qe5Oh+r?=
 =?us-ascii?Q?50QZsEZo4xHl7EDRkhWq4r03aBsjx3zhnhDljNcGw3gVFZ3gxiqXGLztFEym?=
 =?us-ascii?Q?YAUjSDzkoIgWCZowDiBxkntUjmtmqfHR8wUluk/ISmDz62SLpzqT33SqdnRn?=
 =?us-ascii?Q?Bg0zPV3HKYpb+TUzOuEy30LbUx+L2kEPe3SWk6YT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec52da24-4cb3-484b-353d-08dd60aa1095
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 14:36:09.6958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVRgHe01AT2XOr74ipIldWBzmGdhKe352hJs0aLM7ozhq48CTLV4g5L/US+LtMb+NIbAi51DdcWaShL0WEYqdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10506

On Tue, Mar 11, 2025 at 09:09:34PM +0530, Pankaj Gupta wrote:
> Add support for NXP secure enclave called EdgeLock Enclave
> firmware (se-fw) for imx8ulp-evk.
>
> EdgeLock Enclave has a hardware limitation of restricted access to DDR
> address: 0x80000000 to 0xAFFFFFFF, so reserve 1MB of DDR memory region
> from 0x80000000.
>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 17 ++++++++++++++++-
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 13 +++++++++++--
>  2 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> index 290a49bea2f7..a25d71bf2c26 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
> - * Copyright 2021 NXP
> + * Copyright 2021, 2025 NXP
>   */
>
>  /dts-v1/;
> @@ -24,6 +24,17 @@ memory@80000000 {
>  		device_type = "memory";
>  		reg = <0x0 0x80000000 0 0x80000000>;
>  	};

space line here.

> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		ele_reserved: ele-reserved@90000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x90000000 0 0x100000>;
> +			no-map;
> +		};
> +	};
>
>  	reserved-memory {
>  		#address-cells = <2>;
> @@ -259,6 +270,10 @@ &usdhc0 {
>  	status = "okay";
>  };
>
> +&hsm0 {
> +	memory-region = <&ele_reserved>;
> +};
> +
>  &fec {
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&pinctrl_enet>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> index 2562a35286c2..c79a5de227b3 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
> - * Copyright 2021 NXP
> + * Copyright 2021, 2025 NXP
>   */
>
>  #include <dt-bindings/clock/imx8ulp-clock.h>
> @@ -154,7 +154,7 @@ sosc: clock-sosc {
>  		#clock-cells = <0>;
>  	};
>
> -	sram@2201f000 {
> +	sram0: sram@2201f000 {
>  		compatible = "mmio-sram";
>  		reg = <0x0 0x2201f000 0x0 0x1000>;
>
> @@ -169,6 +169,8 @@ scmi_buf: scmi-sram-section@0 {
>  	};
>
>  	firmware {
> +		#address-cells = <1>;
> +		#size-cells = <0>;

Needn't #address-cells and  #size-cells because no regs in children nodes

Frank

>  		scmi {
>  			compatible = "arm,scmi-smc";
>  			arm,smc-id = <0xc20000fe>;
> @@ -186,6 +188,13 @@ scmi_sensor: protocol@15 {
>  				#thermal-sensor-cells = <1>;
>  			};
>  		};
> +
> +		hsm0: secure-enclave {
> +			 compatible = "fsl,imx8ulp-se-ele-hsm";
> +			 mbox-names = "tx", "rx";
> +			 mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
> +			 sram = <&sram0>;
> +		 };
>  	};
>
>  	cm33: remoteproc-cm33 {
>
> --
> 2.43.0
>

