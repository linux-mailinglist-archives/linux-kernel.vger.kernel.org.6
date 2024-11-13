Return-Path: <linux-kernel+bounces-408284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8F89C7CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E074D28300A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01640206955;
	Wed, 13 Nov 2024 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TDa8mwgc"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2088.outbound.protection.outlook.com [40.107.103.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A2E189BB3;
	Wed, 13 Nov 2024 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529463; cv=fail; b=GYOwWkSlwnlvRD8QLMo2LsVu3a1oLREKEhIwfrI8XXlcx+7IvOLAyGpSk28OupSC+4HqiImq6n3J+b0r2UfK0Z4DQnpBdBHh0AQLnp1i5Ks//KgHbDrSkuk/OcUq9DpAkenz93aJhei5CDCgSVTj35Cf0WtlPeRPbUE6C4CXpEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529463; c=relaxed/simple;
	bh=9VYj6HtZDKK8uj0sa2h1UEhAXYH+9JXkbxQFW9mo66Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ylhq/UBP3brU40hyDD4JW/FGio2w5ctjv4nyliJx8qdrPHWQUMnT2QtiWapRNpgAHwadenQPBGGZE4A3a8o1n3NX86eQzDAtVz4ibz/Q/rzSDGrfcy54P9I5CYunF/xyongi3Y9XieyyWCijRSAqLLl9zcwtg0e4L/SkaqZKJmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TDa8mwgc; arc=fail smtp.client-ip=40.107.103.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igQvMqJ15ov3D14bVHs2X4l9FaOEk2lYOS5vHI7f0F29vTA9tIPWLRRL4oFEC9agnSMBniv/emOEnkvrZ2xneRE5vibGSt90qHTNb7TsroBDLdqm25Btt+vpoPWlLUoyUmeLov1HPV5pki59khz93MaxDaiRoiU/a4Jnkzvqmd9Gn3dbkJrKVvCyoigmQRg38aDAQN1TEMaQCr0y4JApwnm9CJLHfOtE8gaQ9xeM+Cd+oUspt4ubX11e0A0BfdVB3dKSLNpk2B0hm/JmMzHOW1c+16blrjZofsU45bB1pqhwEX4jJuwvg2zMvJ7zM37K/k+l4F6AO68P6ManiKSVWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLwJzzaUHTcE/Co5khBY+4E+ynebkMar2qLPE8yVRiw=;
 b=ROWuGofv4xJRkh4tDuL6nthVEd7VNDYl9uboGBRU7RrBzoNMDliDgB6Q2xKDoFwbjOUMk1gEaZb6MJMxzUPZQ05lrPvwqjbIZ0FjVISBtnM+Qxf30Iplp/tLqUcLKTt8kPLwIJadiDBcYI84hq9uPoZZPQSmsgiSPgpqShjOOGDS5iWiuh5TR7I9U66I1EqWcOYCy9MFRKfW4NkXrumelR0pSSPCr2nOmtu90nVbbgDGnKGpQ1nqdxKx4wFsDAMyRJ6AJf6BBrZ+qNGeCS/JllFTAIp7XnOCpjz7ATbmZIBwIs3y+l+DaxS3KjhPs+IeuczWw+Samr2ICI/HjeW/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLwJzzaUHTcE/Co5khBY+4E+ynebkMar2qLPE8yVRiw=;
 b=TDa8mwgcP0GZ4V6Bb+w+7mb5KAdVCdt0tfi22nnDV4GUgGii1ZTATOYvpM4bJABxKcChOcTCoST8ztwwDwPAtiVDFSI9Fwm8hOBkfEwJw+4QOQzJ/BJzfc6Gjdo4cBFgVeF4S705ihWXVfhz2Je/UZ+fMSygMNQIrkrFVdpqQ77RG0M9WAThubulIsJKGtHxnYhJCAgzvtXn4JHrjGIseGbHFh9S1D/wpcUzQBtVrGNG6ObaxNxUlu+O8QTCVpNV3twKqfd3u5+JtK2i/2v7CZKwFFXDpdOoFv6kPM9j5vRU1n7zEnspuLM4wDKgo6F9htflconwuizo7jy08JV59Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10245.eurprd04.prod.outlook.com (2603:10a6:150:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 20:24:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 20:24:16 +0000
Date: Wed, 13 Nov 2024 15:24:09 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imxrt1050: Fix clocks for mmc
Message-ID: <ZzUK6TgrX/W/XzBy@lizhi-Precision-Tower-5810>
References: <20241113193634.3487554-1-jesse@rivosinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113193634.3487554-1-jesse@rivosinc.com>
X-ClientProxiedBy: SJ0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10245:EE_
X-MS-Office365-Filtering-Correlation-Id: 42dc3adb-fffe-470f-769d-08dd04212586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TDXC36/pLPbDQ/7GVbEYDOWcvSU7WkjxNfNA2ljum6S6+rKrFWU5CvWlSoqO?=
 =?us-ascii?Q?Kpd3g8f8QhgjSBUNPadsIIEi9wWuxWlK8Wb0DddFahVqGIXrObRP1PpdpW8h?=
 =?us-ascii?Q?iGj2DfAQOrTxwHrOlRMsExKEFVP2ZJAyjJBFvz2r5SW7t0vnvolUbCVMEHyw?=
 =?us-ascii?Q?6Ms3g1g/Tosp55PVt3IaUqwBGGVx7LbESWS/F6YMciieJ6qGBSJy2XZJknVn?=
 =?us-ascii?Q?+gQFqJbDrvIuFerUoAfm9XnOCtWgvgofrBzeJwJqN8RP2Ao3E09F6q05cXEt?=
 =?us-ascii?Q?GJzlHapLWkE9ma/MAcFxCfBp9B/Zdz7xE5k5C21/msLyc95X2U/rUuMqtHlF?=
 =?us-ascii?Q?Dxwnw7d7L3T1ubCKHT28whU9Q6xE1/qulhl0yZ07JuHidAFmVXz1OcsLxAth?=
 =?us-ascii?Q?feAZO75UnJ+9nbfvtuGzRgFslssw5uYT0yCmrTwymjer4NkA0rrwgRHFpAxZ?=
 =?us-ascii?Q?mWxgvto8X5QL2nJzHLsS3zeDXqYckwXUTWQUwEwsawimxuioQFJsflCB8BqX?=
 =?us-ascii?Q?mtT3fmSk+hlHIS2ZonS+x4KHmBOnokYKrJ/5IB9jsj8DkrFD3hp+gWk5qf6N?=
 =?us-ascii?Q?/bplfCBqZFa79X42QLhn/39VlsFevhYSlwPpW9qHBMSmwkk5dQSsCvBzI2qI?=
 =?us-ascii?Q?Z/nddQXlNnWuT8pGnF/cZTQiaczn+wUDLIOp0O/iXZoII4zjoztfqNSho//F?=
 =?us-ascii?Q?HpJzRCwLURGBQCGodtV7YiyExbNIZ1r3pppgQxSOaLotHYAR0gSEjRDLScrh?=
 =?us-ascii?Q?PhG3QBni3uLxhBBPSnjAqTXLQ5fPueum8+Zbakfy6F8F8DA9H8PKDyzOIo2o?=
 =?us-ascii?Q?k5vKtdBPWgTsMiWAJ0iKbtkniUjVoMXWUJ/49m6q9J6+2FUgH3sthZnT96M1?=
 =?us-ascii?Q?KZoZFxKdGyg6Xru00M2pAC9i+XUKF+VcFvIIGu1uzzIyTJXM68rNCTCHmfQ6?=
 =?us-ascii?Q?bSYsZ6lDAoc2+lPWFjZKRPAm1Bt70+qFciFV95P+3MiBkeSuyEEhfYwsc/1Z?=
 =?us-ascii?Q?a/IJL8qnYOoKLNOBxhzGD8AuhA8VDxQw52ywPF9xxq82AF2HDKwW5o8czM/u?=
 =?us-ascii?Q?nhdn3IrC7/THbSMClFCZACHdNcbXbXEneTpgEwWc3kEJ29w+OoTRdYrWhrG8?=
 =?us-ascii?Q?b1XU/O49Xdi9NkDUC9WcZqFUeX4p/0gpifF6lo2Y41Lo6PT4z7wZ7niQ24QH?=
 =?us-ascii?Q?a6fUhmfl6zVYSjxg0cjEwlce4uUUCSo4Jg2W3I+U6JM9TPcV7GfsyHrDfMKM?=
 =?us-ascii?Q?TvY8lbUoTo/HaAU/5KqkkbgeXe+0oJ6bqJsw1wtuaiXmfy5Uu7ZiK8nHM4gr?=
 =?us-ascii?Q?iGPAtY22Qdc3nDzKx3ugJtWoGDZXEFz9V8wMvzUQ35K2fIt2DYl6f0WpcjV2?=
 =?us-ascii?Q?xL2PGZk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JuOJdV7C+pJ6G9tG+fJJwHcB3D/AhE5UUOutyY2yFqP/5KdsCoufFkPjzluE?=
 =?us-ascii?Q?qzbO94DtHP64NMxSk3pCmwzfqfmG33aawGzF3sZuIEYMU5P0pcfacE9NJE7c?=
 =?us-ascii?Q?7zQaXS6QKn5sC6xuxL7RDurz+YFUh0tsDhRshVCR1oLAKzYcLRpEWDVKVOXS?=
 =?us-ascii?Q?AElbh5gweb2doTK1K6HwqPtwlGWlYnN91ey/cGZ64YLAFJN6nTw5tdy+MYUk?=
 =?us-ascii?Q?CkTEcdCiaAJNikqmSfOTX7LbiumSxr9Eof62xK2WYt63qwq8tHgT/kw+7+F8?=
 =?us-ascii?Q?6HqiXjRbccHfqzVc+D/xoGEj6I9xvAllPUGkMkGPDBB8LWq3NrtEyS1qeqRf?=
 =?us-ascii?Q?sm4rO+2Ld4IRnN26uuLwkAcoBLFGFbg37oQ/3R20bxech5/juIg9W6YJ3lZ+?=
 =?us-ascii?Q?YDsZ0v62Mn6+l+q9xYjXZCQmUuQ4DoBxucd4L205Gx1wKpjOpEjH3Tx4svv8?=
 =?us-ascii?Q?+A06r2EKSSbpdE9g//PJM8a3VfL3U75xsdZyaS9Ng5izw0QRUrTsgdzaLjV+?=
 =?us-ascii?Q?lk3b7wCNvqjlUMzd8gJ6yiduF3JLzP+PIuYSZygFr3H813bWnNzP5hzL4rFF?=
 =?us-ascii?Q?61zJxocJbWNKwy5cKWvIFonRijEIjEDbtx8dxSLm7TnbjC1tpBJyAw+qbBn0?=
 =?us-ascii?Q?kfPUVv/jGL7B0vvh8/gh2p3bLlcKcPdO5MwLa85cq13CY2fl8WCcBEpfyBT1?=
 =?us-ascii?Q?gIqWvNH07ugr5B7/RgLVFM+9dW1UiJAZpIYrd2LKjZIanagJMpLZoI8pfEUN?=
 =?us-ascii?Q?TAed1ePwGd34HGnm38YeMdMzlrjqk32dZ3z921MqE+eXb8p2eszTrt1sG2Rd?=
 =?us-ascii?Q?RyvwFoKRXbvFcuWj5XZFB37iDhXuN3F3cpAFkQaJ6+HdtGMlRmwqs2bTmONH?=
 =?us-ascii?Q?W2y9s/U0B8OVCddIvGM6E4toMv3PLjgflc5Wnq8/tZj6sBS6mHCUiIDVv+6u?=
 =?us-ascii?Q?uIjBWisOHS0ICJVnnMUiLHZOt7KdCiFXg3OfL6LAiF9T0uXyCwfb40prbIem?=
 =?us-ascii?Q?Awoa6mjul5GiQZClQH7UmoD/7ydxZR3SZw5+vjR9GJdeuf26b6hfEs4csVNe?=
 =?us-ascii?Q?U686eiLmxPciG4/wim0aZa4EqWxF2kEYj9MPgxHNZtN0zxst51uVnzBzQMDV?=
 =?us-ascii?Q?FdlrCH43TxHwrhfjZZdp/ct7YAs+eeNnh5F6KU7S+wvAtgvrEZHP49SmoZUx?=
 =?us-ascii?Q?olRTdE6Pty464GVi59mkWbNwPc2PH55we8ZRnKKHxLk0Cby5SFuaMVYwj4fZ?=
 =?us-ascii?Q?xxQcm8qtGi2qK8/ub7OgQIMmCFjU/IjX/8YzbPxx6MA4B/0iRiQF/jVY8sBh?=
 =?us-ascii?Q?AnREOcyJk/tuLRM7EocJNp3/o3G0F9hV54c0IFj7OiTe9FTw0eFnW6jHT8T0?=
 =?us-ascii?Q?NV5PUchysgQcEEeWEBWnyLy1/yvSYrxGqrGyS34v//wFnJXiH0BRwlVMzrNS?=
 =?us-ascii?Q?uvjJjIiGv5r1LijXiKpoTP1uTncLrrgdMDfq09q2Ar1PJfbeKy6o+/3XfszS?=
 =?us-ascii?Q?rDk9f77ZCGzRn2l+ccLv2YmQbrnEMvSwsnfiXJ47CJf7u3hu3EonrJw0LsUg?=
 =?us-ascii?Q?eTAseqD6R+2IcwLJ7yg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dc3adb-fffe-470f-769d-08dd04212586
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 20:24:16.7481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CulvHhNYHqD4b2WLNvphS9HBWFa1PjbxJZ9U2OBJ74fIvRIOELBNn6keH9OBYK6SkSkqX++1NQcVohq7Il2EUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10245

On Wed, Nov 13, 2024 at 02:36:34PM -0500, Jesse Taube wrote:
> From: Jesse Taube <Mr.Bossman075@gmail.com>
>
> One of the usdhc1 controller's clocks should be
> IMXRT1050_CLK_AHB_PODF not IMXRT1050_CLK_OSC.

wrap at 75 char

>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---

need fixes tag

Frank

>  arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi b/arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi
> index dd714d235d5f..b0bad0d1ba36 100644
> --- a/arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi
> @@ -87,7 +87,7 @@ usdhc1: mmc@402c0000 {
>  			reg = <0x402c0000 0x4000>;
>  			interrupts = <110>;
>  			clocks = <&clks IMXRT1050_CLK_IPG_PDOF>,
> -				<&clks IMXRT1050_CLK_OSC>,
> +				<&clks IMXRT1050_CLK_AHB_PODF>,
>  				<&clks IMXRT1050_CLK_USDHC1>;
>  			clock-names = "ipg", "ahb", "per";
>  			bus-width = <4>;
> --
> 2.45.2
>

