Return-Path: <linux-kernel+bounces-310328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D62F967B6B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 19:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE41B20F9B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 17:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D4118308E;
	Sun,  1 Sep 2024 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MDDnZSZU"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8244393;
	Sun,  1 Sep 2024 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725210823; cv=fail; b=ktO1g2bOiVbHuH7h2qCtqU4+DfkassOv/DCroD1eNKVeDO6pZt55bzjhNTUU0PFr4PYpVEHhd33x6VplWdSOAw+L+zkBkFf8LhanXPmFU2AzbjYNqs6pBKW1JrVCUF6nrCRojw4qjnAM/BThE3bhnWJyqFsIEX7bGprmZA1M9k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725210823; c=relaxed/simple;
	bh=heGqpYid01lL16LVdSVq2hM/iKH9UNF4KwhiOtEKRIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=irU4gtuwmFFQtjaZIqK9vZVg5gUkbZecOzaWdSMax5/EPbc/IT94fy0kTSzNnRKhXBESoiy9TofRjU2x02nB6b1ksVi3QqiPcDENOTgriUag8owaxoq8hAumaDvkZQi5o7BwAi6e3iTzpPqKj2xC8scmBRns1gYst6XJp2jz62o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MDDnZSZU; arc=fail smtp.client-ip=52.101.70.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQIowLauXgpXCZ7QjIaknaJ4sNrfnFdZQ1BKqaiq2tpGYjkbiHkpcBOhgmN7tHlPbheIiEQNAIVzNw1yyhGCUXV7cKx441YC6iGf4Q07Ny4Zfr/gCgzWwYAe7fbd3lU3pTyeW30N9GGEXt3x4rIEWFg2myRJ9pypKFvkcniYWnbGMalYixeB2l1vxJ+GwcxV+IicXXvCK/EqT/K7Vbgi4cLuBRwkRcugf6QrFe5RaSacBafBZi9MPHQlCACUixeQXlR68OOWsPdwgcPPyQ4zBVYScQvzP/U0MR9LTdJo72maLiavS+NcTV0MuOpjfyyM7rTn/N2YnEQMx7Od5G7xoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KWs2fhUM1D7CxSALAfAPZL20+n9k79Cxi71EdVfCnQ=;
 b=bstKyBO4ZebJNss9nz1bEAU7iL80mKaL+Zn85NpdVRtG+o95/KCB52ctcboXaFzrd6Rg+NSucDvZDlVLb5dKsoEo7W3j9G741UAH2ec8Dd2TLBIzyiKxziX3GhCfDpAt/BGtY0l6RdEbRwHNfWC0Y1weIJm9cPyckgAo18TLfYqirdcWZgmPXMfyOOIo+sKPBRM6F/FtPjvpqkF5ayCAi8ssjMUQoPc25N+DBlBmNhosbmNMpgIXENf0d25TmibMFiNIPO7pWUmpXCzq4VtsS4f/pw1eIxgmGf55w6pP67R6ASYiMUmEHq4jhdTfJJe3q8wCcPye6TfZ5efvGPwqIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KWs2fhUM1D7CxSALAfAPZL20+n9k79Cxi71EdVfCnQ=;
 b=MDDnZSZUNYGwp1Xvq0jw1osZ2A4uigLXtll6j0P825P7X2bVEirNxZeTzjR7gWWYd8PpziZaTb8Y/+RqLONPyZt4lK1amHFolRlo4nnDFxkrKyYnamAY3D5BxN5uLFr+hoaXl7MxgwdGuItsWjT3chFHxWf0fl3nRm7/+qCB6S+XUBvdmfs67jfp7J/zAk9Hq8J7WjnOIrK2INJTlc/ltX9BBPpICfVAeYwKlPaJNNON3RChhlBwg2Pyp+M5EkI1tr6UNGqGTzTq9LjoskhDlPTXQeDnmsFbe5+Wv1y8DYYTNX4aeEVJ2zpX/Ax+CqNScFgzM6ZoZ09VONra1B728g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10512.eurprd04.prod.outlook.com (2603:10a6:800:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 17:13:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.020; Sun, 1 Sep 2024
 17:13:35 +0000
Date: Sun, 1 Sep 2024 13:13:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] arm64: dts: imx8qm-mek: add usb 3.0 and related
 type C nodes
Message-ID: <ZtSgtqEFSOzE06Vx@lizhi-Precision-Tower-5810>
References: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
 <20240701-imx8qm-dts-usb-v4-8-03cdbc8c44b6@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701-imx8qm-dts-usb-v4-8-03cdbc8c44b6@nxp.com>
X-ClientProxiedBy: BY5PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:180::48) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10512:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d605fe-3403-4915-4fc1-08dccaa969bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GyNMXloCPRIUpd3D2Qi+wQltphGtyWltQEP3MTWafpra0cctISyuJkDAhnti?=
 =?us-ascii?Q?2znbPkCE8sEkhRFcQsfrsh5QaXqtwZkuGjk/g2Npx339yCw04FAw5j+SbjH1?=
 =?us-ascii?Q?4oNAedR19ekY5K/zy7VPz5zZCofwOMdeWinT9nBC3EvpH92/CkAaXxVnjK55?=
 =?us-ascii?Q?3xd2KGjq6iToglnpJHwUVK7gjQ2LX3W5Kfq4C5uDj2FxPYzQE4F1MIQGKchN?=
 =?us-ascii?Q?7yRbS6bifYJFbeHpc9Jdhp/6FMvii9gl6FWR7uQeJuZWjEQd9Q/RWTbF1+Ex?=
 =?us-ascii?Q?VYjskkNJcxUnneJWpqmg+N3ZNQQqoX8wYnkpCi7KtxdIG8+v4Rai5cJaAWjc?=
 =?us-ascii?Q?fRixWtaGKBTqtqnHc7XDwnxgRC43ugvYJ2tel/HSPBpKSfCLr/Yvs4M6lWhn?=
 =?us-ascii?Q?hLn1JMKyoOhYQI+FV0w4RzrAS6O/Cx/GpkRVeRAaJleSGlfjZAGHddsXO9ps?=
 =?us-ascii?Q?zvq78tUx8V847e+LYxntlWVI6++1ivYN4X2LHfu7bjYz/nGFhzEzJTdvl59D?=
 =?us-ascii?Q?5ujcCM5F23ZiupX1N6ZKRRFtTXLuCohoM3htkXqdxhivR1TGpe1BjxV3KH56?=
 =?us-ascii?Q?XjzTmArwP56aQyalst3gHP5iBjURQjenUm4nnqdytLrDcyA9cdsxrE8D0dag?=
 =?us-ascii?Q?WMjlx36MpqkfXycssdtD/8JkTEJhNVQiwxqWNGS5W5c5EmCngcB5TdgJForK?=
 =?us-ascii?Q?nUhy1xCxybf4N1Y4zbeHi1euXxuFtOKsAa/35YdcgkWSj+AmH8sY1EQU08kV?=
 =?us-ascii?Q?Klf4hqGnQ6+BZHvrDOTudgNC7XksfTV1OL3WlgyZQcyQzHY/rj2DqF09zHWh?=
 =?us-ascii?Q?6BxhZkxfPeJ3OBAhmy9GBl52w+TFTD59yBYLJwjgDyt51DZfBlPN0dGql2ov?=
 =?us-ascii?Q?MMVWqaPcsmVjj8xdkOJiEaCokY0nOL38cobM2/0vf5XjabvGrCPh/d17NjQm?=
 =?us-ascii?Q?aaDfWcruqkuo/d4muWlCm5PtQu7ixHo9vT0rQoHcr7voETU+X9a8ABWCgqmM?=
 =?us-ascii?Q?hCTtEyX33GMSyPy8xspY4v6RtnSH5vHpzjaoeG13T+YKtJWgsycvc2OoRuJJ?=
 =?us-ascii?Q?uWSp3Pj7yLLOmYRDB51N/p0gdTbaLi1aGKqkEBZCnpuzZmMxYm4XKHts1piA?=
 =?us-ascii?Q?o+174LFw1sfZXqpz7LDTE80Zcn82A+Uohh5lNawzcYEDADdgoGIrS+n5Waim?=
 =?us-ascii?Q?RFO38pItm9gIDEYUXEOr1Iev14YfaUF6M6tB8T0ET+uw0cGiRllUPAqgq59W?=
 =?us-ascii?Q?IQJxoXPy4Fbli6Pf4Hgaqry8URAMa8ekhA5sqtfGlGD7/Su0dKnn+rPI40uH?=
 =?us-ascii?Q?eJvzWUs//hwgo1row6H+yWiqeRM5WzyOlIY5tZ3C5jRgm8kogFROm37+VlP5?=
 =?us-ascii?Q?ywWXqXWcj/NkSdjnSsCJfqD3hRMBYjafSP2G6+1uRB+NWIhB8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U++LRb4SHibJzBzpsfUX+UYdgkC9d5hcNpvdUO6ddeGFKBsdrFdGM63Tcm1N?=
 =?us-ascii?Q?kn/NirP6qJxUrN6R/7QOPalF/3Neontfwd2deoA2iHBJUMMAFqO1KxS4Uvr7?=
 =?us-ascii?Q?GXqXYDsXT4kGEpnn9unWyWTtY9vppmpq059yaBS6iqjuqrjkIFGMJFtfaGE2?=
 =?us-ascii?Q?l4D+YHFprDQyYM9SRb3of8LyP7rNz1khDVgUG8RHMHv0MZKq6FzZnov8laBR?=
 =?us-ascii?Q?GYduqUwW1ZHUdcQe+pzNonpEfWYJc96oGWJq3DeYr7f7gk/6Ey40GOGwR0yJ?=
 =?us-ascii?Q?ggtBOnkASQ8av8Ma9oeEmuiJALmX5LJdBM4SKyn6Mh0A457mgmrDi4HhkubV?=
 =?us-ascii?Q?FyaYwv5k1kFCWn8ed0aTtAQawArTwJqSOOQeePlcxTeK3Z1kZQq1X1COHSCO?=
 =?us-ascii?Q?EDeGtf7xusWNWsvDT8tGv7BQxmrdQJ20vIy0xYMnyF3eRDtR3kdPHuk6igvK?=
 =?us-ascii?Q?BZhURlT6v+Add4hQOrU15GbrhthRvR7RZ6IN5bCH/MprIMMZ4+eii2rHeLVQ?=
 =?us-ascii?Q?jB22bhBtQX53QyYsUhlAorh4X/Hjnb8m+0uOSwCa2mCqsl2TyrJFT7oHGTxJ?=
 =?us-ascii?Q?Av0j3ydNJa/IVZjnwJ07L1I6Z79I3vcsM8dOc97bMU34U9kkmgBMnASZqEHY?=
 =?us-ascii?Q?6yY8OxV/D0KYAaAWFW1jIkz53FIlvV/eJJBH+5y5uhXdOHoQOixW/vOkSa4z?=
 =?us-ascii?Q?5uZrhhjD5sK1jSsI+dmQWT37izqQo7HcjLYNYbysdVwaTFIez3LvD9fFZB04?=
 =?us-ascii?Q?yrb+c2CGtrCV8uMEOCq5+Y8Yb5qbvolH2zEVMICDLrqp6+AIv+5ovW4fWIHI?=
 =?us-ascii?Q?iRqDFiSxgpNGF48uccf1xi1RsUUFJ5f30QLyj9etw/LL/mrP4x0vFN7eRXkQ?=
 =?us-ascii?Q?mxApOhi17cbhi+KhTG3pbQIUB1Q5gaEOubbfMmhx+2kFUGKsZ1OI6nAWIwkY?=
 =?us-ascii?Q?KhM8t+WaMN6yZ4mSj4KFtbw4s6PXKpX3HCGskFiJDYna5KnD1BWzHF3d7Wto?=
 =?us-ascii?Q?aQrhxERpDgutC0Yhxt3w0lSf/p1d90ADt+c5hK/m1eEWmn7nYmWPPoiOhUiL?=
 =?us-ascii?Q?ypy9ugLum2aN0W34piq40hAgdBDP3csRts7ab9nbYB6b0bxZCs1UMZ3qH8NS?=
 =?us-ascii?Q?m5NIeXWCpUXTWjTexh1T0F9dgOew6871WLGDdMntjO/gInUFvJ+Ud/RkUqQP?=
 =?us-ascii?Q?5loPRrgxeTa+gisXuNY4H2cdU/G/nz8WGmesWsmDMJUcDBtbXdQdj20b8Jel?=
 =?us-ascii?Q?nb+/P4QplS5IFf28fl44W35pyptWe02+hwpdIwk5hjWK2sA06sVQncuNzJUX?=
 =?us-ascii?Q?yZ3RmSGZxe9LS5DDWDQb8JnpoRtGHo2HC082nVfP95GTuCD1ESAU+P4iR02l?=
 =?us-ascii?Q?v89DhzFBgpaxEeoNKDo+5DgXRlmGNEi3tXK/o2DafN7DgZePu6VbduaqU775?=
 =?us-ascii?Q?chAK/N+2Lfg4KqcXgnQR0Bcbqaj/hWRpKJtYnbRpud6AiIbDRk3NAPqqUm3F?=
 =?us-ascii?Q?dbUdDkhgpnW3dF7RWy8u8JZGAovxyMAGyWW8Q6SFNNV2TJDbqdOoDrDa6+sd?=
 =?us-ascii?Q?ZpymMw8Icvnu076Ozjde3gQiS07SPWqhSjzmaU9z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d605fe-3403-4915-4fc1-08dccaa969bf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 17:13:35.3587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XviAER0cmieHvN7Em48qYKrr9DLa1OGeMUOE8/sl2iL6nxhcszb2vk9aIU8u/9jtIUucu08T2NVBSJgz+3tOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10512

On Mon, Jul 01, 2024 at 11:03:34AM -0400, Frank Li wrote:
> Enable usb3.0 and related usb type C nodes.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 87 ++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> index 7ceea79f658db..aa874576e974b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts

Shawn:
	Can you take care this?

Frank

> @@ -6,6 +6,7 @@
>
>  /dts-v1/;
>
> +#include <dt-bindings/usb/pd.h>
>  #include "imx8qm.dtsi"
>
>  / {
> @@ -109,6 +110,21 @@ lvds_backlight1: backlight-lvds1 {
>  		default-brightness-level = <80>;
>  	};
>
> +	mux-controller {
> +		compatible = "nxp,cbdtu02043", "gpio-sbu-mux";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_typec_mux>;
> +		select-gpios = <&lsio_gpio4 6 GPIO_ACTIVE_LOW>;
> +		enable-gpios = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
> +		orientation-switch;
> +
> +		port {
> +			usb3_data_ss: endpoint {
> +				remote-endpoint = <&typec_con_ss>;
> +			};
> +		};
> +	};
> +
>  	reg_usdhc2_vmmc: usdhc2-vmmc {
>  		compatible = "regulator-fixed";
>  		regulator-name = "SD1_SPWR";
> @@ -321,6 +337,44 @@ gyrometer@69 {
>  		compatible = "st,l3g4200d-gyro";
>  		reg = <0x69>;
>  	};
> +
> +	ptn5110: tcpc@51 {
> +		compatible = "nxp,ptn5110", "tcpci";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_typec>;
> +		reg = <0x51>;
> +		interrupt-parent = <&lsio_gpio4>;
> +		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
> +		status = "okay";
> +
> +		usb_con1: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			power-role = "source";
> +			data-role = "dual";
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					typec_dr_sw: endpoint {
> +						remote-endpoint = <&usb3_drd_sw>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					typec_con_ss: endpoint {
> +						remote-endpoint = <&usb3_data_ss>;
> +					};
> +				};
> +			};
> +		};
> +	};
>  };
>
>  &i2c1 {
> @@ -525,6 +579,26 @@ &usdhc2 {
>  	status = "okay";
>  };
>
> +&usb3_phy {
> +	status = "okay";
> +};
> +
> +&usbotg3 {
> +	status = "okay";
> +};
> +
> +&usbotg3_cdns3 {
> +	dr_mode = "otg";
> +	usb-role-switch;
> +	status = "okay";
> +
> +	port {
> +		usb3_drd_sw: endpoint {
> +			remote-endpoint = <&typec_dr_sw>;
> +		};
> +	};
> +};
> +
>  &sai0 {
>  	#sound-dai-cells = <0>;
>  	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> @@ -791,6 +865,19 @@ IMX8QM_SAI1_TXC_AUD_SAI1_TXC				0x06000040
>  		>;
>  	};
>
> +	pinctrl_typec: typecgrp {
> +		fsl,pins = <
> +			IMX8QM_QSPI1A_DATA0_LSIO_GPIO4_IO26		0x00000021
> +		>;
> +	};
> +
> +	pinctrl_typec_mux: typecmuxgrp {
> +		fsl,pins = <
> +			IMX8QM_QSPI1A_SS0_B_LSIO_GPIO4_IO19		0x60
> +			IMX8QM_USB_SS3_TC3_LSIO_GPIO4_IO06		0x60
> +		>;
> +	};
> +
>  	pinctrl_usdhc1: usdhc1grp {
>  		fsl,pins = <
>  			IMX8QM_EMMC0_CLK_CONN_EMMC0_CLK				0x06000041
>
> --
> 2.34.1
>

