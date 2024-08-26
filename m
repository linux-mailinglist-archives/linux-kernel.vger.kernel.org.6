Return-Path: <linux-kernel+bounces-302207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F04395FB22
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24EE1F23D60
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4000E19A297;
	Mon, 26 Aug 2024 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lLHkzE54"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB0D57CAC;
	Mon, 26 Aug 2024 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705956; cv=fail; b=rUjx6L7UenuqxOWkFjPn2jF8GVhM4KqqMwdbxhsLP0Rgoq59b3itNMYP/gaqFG3E0BwlZdPml71S8c6JNxSHW5IdW0CAFujD3zAh17u2PRoeE+EqgA4LI2hsaoF7QBt1heAkyoCw8UNwobs7fVuyWR6iT2h5EOcJhYpVoqmN+hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705956; c=relaxed/simple;
	bh=YS89FHNsmCZHaqbAGk5MzXz1NRx0yGq5oC7UevXpbDs=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Shycrz9FJlowxxkEIq3pWW8Ty8lWSE1faj2yr6PZ4VluD9stxKChSPtVGIN9xvV8M6ERVK3r3j684qizGMIYZNoaUmdViDb7fCgeJjmDZMNuM0puyg/T9MKTqBhDIQPbihsl4d1IozeI8Sx+f19pFb18eAtk1eoK5LN5kovEh2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lLHkzE54; arc=fail smtp.client-ip=52.101.69.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHGa9kK/Bm1Yojvesn0jncJN7uxcZJA4TIte/fZywHZ9mrfvvZJWEYpsAZqZHC9h7ODB3GHDQuJl1LMaMsEFs6MoKn+BvYZv5tCJuzj8r02saRlwyfQ77pGjM4HAQPnX07OeK/j9o2nHpuUvL5i8a6d8M3hnDFdcdT6B3yXa+eCoxombgPBYo5zKq5aqNCUWzRENQ6CHcdWT3o2+6WVOx/cw9fgUEQsfy7MAFEjOU2dDeQ20ZmGRu8GE8YTVOTPudGkRhN9bQr8kHbU/tANnyVMRATpfxa9VSF+lhkzSA/pWw7zCnBznqYQhYZPcolkFzmRTtKBivwL0HfaQ3C5HLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YScHQcqey5NqWIgaxEL0ImEC6lgy9PH0gC+s9G0qbEQ=;
 b=na757scBDY6vgEG3tsYi7s9RS0WEsu7WGXoDxgA8oUWdz0HLouQwFpmG2radtgkliFGTcN7Nxh8DM4Jp9QUAfl28Wfeukdws7dvFEoU4QkV+Wsv9UJ5RsNwY2g/QnFN4D4Ixk9awI86VWDV93/Iw8eoWGtUtAQxi++VZ99GVNDc/EwVN7kKM4U9AJ+aitu++/oBZ5xf63iVJ6BRr52KWruj8izHbHp1RNmrwkpLGUS3VlYvU25Z/CqnfOfVa7muPwX1ddcsro6XvhnSHq2E6iaLBzxmL03wACa42x+L7jjifiJ0QBfSgkj5gp4e6yv6vLNJ/78dFbu+55nmFXwok+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YScHQcqey5NqWIgaxEL0ImEC6lgy9PH0gC+s9G0qbEQ=;
 b=lLHkzE54kitgWiAG3+Bq7PoOjHe+szhizGu2f0dmHRZz4P76NJMBo92SBxDN0VjiFtKoF+77HI3UnW6zWpXmw2N31yYoinGUHeCtCmgABApdgkJmXLHULFC3Oc/1twfRmCtOfQqerh+FMEGT6Y5ZlKY2/Y2hrE4Fh3hp7jqU+1CdyAPG4+dWeey5SEiDMuupRnyTRJSZQrMfJ37e8ysBYEcCXUBwHDiXOmd4f5fPPR/arRq5gd7GTelnjSXSqKdxLwKuL1KkSwPRSpSJMzYuO30cEg0Py8Bwmvly9v/7mvd3m6yEjM0QRE7pX2DbLjGtD6C2sEMqGJm4spw5TOR//A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10681.eurprd04.prod.outlook.com (2603:10a6:150:226::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 20:59:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 20:59:10 +0000
Date: Mon, 26 Aug 2024 16:59:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: imx93-11x11-evk: add io-expander
 adi,adp5585-00
Message-ID: <ZszsmMhwy+NzDZ6W@lizhi-Precision-Tower-5810>
References: <20240826205334.975272-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826205334.975272-1-Frank.Li@nxp.com>
X-ClientProxiedBy: SN6PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:805:de::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10681:EE_
X-MS-Office365-Filtering-Correlation-Id: 926e3ddc-bceb-4709-b6af-08dcc611eea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7k1orcTHMoewJzlcpR/CfnwHX4AfbMFl4Lxa94Tq5/Ywz/qRZSTD3DaXx+PF?=
 =?us-ascii?Q?9EZpqym2crXkFecirnMrQbGyrUXRMIo6kWI12SCin1MGe17S+pJZu02WgW4Y?=
 =?us-ascii?Q?jZlcFcyrgWw897yhSJ40ZyuphUlqb05nbekH5DgnSzS2+mXJtQPhmG/a3QNs?=
 =?us-ascii?Q?HNq3gio2mx6A6Q35bjxliBnXUez8Z7JDaJFmxomejQNO/rWrmyg7mwo+WXYX?=
 =?us-ascii?Q?AVcj9rJYRJGtuDjkBeg+HeR1NZz3bv+r6TWvHG8bfVA3RpyKc0Or2fHKGcu5?=
 =?us-ascii?Q?seehFBjpxzfQU/YMviMxIOu/wwA05Wwpw0c7yhoPidBe2oJNL+d14XRo2G9E?=
 =?us-ascii?Q?+FGAgpcbh3XH+eep8bfhyDsYKz+YvfwhfuSDKytInSm8PQZ2lM/GdsZk75+b?=
 =?us-ascii?Q?PhJuEEgclfDvoj44q4PI7qHEfYibQmXy+wVSLrZU/xiDurz+B00u0cKb3RCT?=
 =?us-ascii?Q?HrM6E/po+c5I6Nk/LJ40+m1kJlokStb47uoKM+FQAr4gfgypXKscDZSm7gXQ?=
 =?us-ascii?Q?2jccU3HCAxxSjLtyVaD6m27VReGEn2ZXMcDdSpap4wUIx3iNc0NSbZbXmpus?=
 =?us-ascii?Q?XwpEPgFxSvbO9hMOwkSXMw7xICr+MKm9kJdwTmdn6/QW8EuGHwVOmXU0d0a/?=
 =?us-ascii?Q?+ZupOAbvhlkaGcIoZe6ezq4c7JviaarfjPLh9zDROg9f1LS9KOQJ6k+Rpk0T?=
 =?us-ascii?Q?Q8qsUccvH1LprfmKrVcqERz+StoXIL79XI2GMp/LXbCNY55/67ETq0FnTB1d?=
 =?us-ascii?Q?AuUWoWm5sOq6lt5qhCP7A1yk/3ssUcY4MwfDRkrcb7YAbEGOws+98E5lbtV/?=
 =?us-ascii?Q?1q4nO0I6ueBy7ExHzRk7V8Prz5w3J3DpVdXiOgXnME68ohENO3MJAfIW5GRR?=
 =?us-ascii?Q?JY5H1ykFkzCcWNk6EEwEwR4MKpM6RxjV42j98t1kd43qrTgs6Zxlm6LDioPt?=
 =?us-ascii?Q?PWinTND4mPcllOtiqm4rg9NIJwPXNInKsqeyK4+a1XBdANuoHb+PM6vPMBVO?=
 =?us-ascii?Q?PC83ZROAeHbGsdWxNKNQxMVE1O9e7jXZJwo1yREO5QU9IRG2R9+Bn6Fb0/hW?=
 =?us-ascii?Q?i8TBI7vTxbtGc5tLYBJnQ43zLt6mkz24ZduuIWVfH24UOLVWl5rHXoaNrOEw?=
 =?us-ascii?Q?KR/Hv0mrzSRwQrPA4Ni9YTISlrH5LoAieGiq1LpGxyXsPMt3wj89aQLvS9N+?=
 =?us-ascii?Q?WemJf38lAgG678olEcs/K9U1xOq+sk+ZC+hyDW1JoCpSuDBNtddRFywXA79q?=
 =?us-ascii?Q?10oRzlMJUkOcR19dd8lnk+P6vgzPF+2yxpF+NN9QVINgpKduJ+tgk3QooSvt?=
 =?us-ascii?Q?KepsI/+j7LCDDMcgpRrh7N+3XrnIr9GFgMxB3VoUIVEoGuA4RSeTMSD+WPAU?=
 =?us-ascii?Q?k9OUetL6eb2oxUqjD6WHTT3daETKE7QIqMGeE3WAkXKlgrb3Oc3XpRFIxDdL?=
 =?us-ascii?Q?xpS5sbUWLmo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+67YaJhhd6Jm6UHzukTtfoIDgfg4LbMW6cVoB9+QOQr82rra6d/x/uBEsAiH?=
 =?us-ascii?Q?383UWmXNP8UlraBG8Phg8OI6BrkJo9bEEPlX9YpKM3ikdsgyUKL8YZJUPLky?=
 =?us-ascii?Q?pjHflDu8okzhBPaW/qe/LiLDOHWIiRXxXpIseTPyFpM5BGio1QbahzpbYFT3?=
 =?us-ascii?Q?ZSgzP11M0XDa7T6yEF9SgNAdyHMWP6ZPlKKplaetaNGeJjvGe9EKTbUzUaxL?=
 =?us-ascii?Q?4d7epvtaC1fIrs1WIX0pgSkBjKbdXjcMB3vW/R5kQ6U64Z/npxtYr9vl79rk?=
 =?us-ascii?Q?aMhYUwGLsYHfm0VAfcjIzkB16VmVZmkKBi2rZK19gZFUoef/G86q52V+yzch?=
 =?us-ascii?Q?wxLZNW5hOHVqawS/vbFacp0F5st2L3B5xGRHAI6ijGnxk/Vy+KTI3SsB65zB?=
 =?us-ascii?Q?o/iOrK+dggQLUZ6OdTq7vKiNJAm/BuNQ6yWjDVzmiGw9MV7gg0/Rriu0OHnx?=
 =?us-ascii?Q?WBnz5w7tmc3FYMxtJvPsYKODbhkSCwamDBm+L0nXeUg1t9NawIA7QPxbvlgE?=
 =?us-ascii?Q?xzC23xpAXF76toFe0zOU5cfQeACly14QYYiHlMNhrkw3H2z5z0BrwKfAvi2k?=
 =?us-ascii?Q?CkeMTXuxPRkujpOm65qcSlTKKOKVRGK22moIhhS11OkJHRf7C7c/5MvbyXzm?=
 =?us-ascii?Q?Z3k6G6VXhlG+rXO4fixpoNkIwb20J8ikVRwn9h4p0t65HyPp/Yohfu2gby9i?=
 =?us-ascii?Q?mr0hxBujZcNZCBEXyi2YASa6AJ6aPiKKgJsjkDJKrM0gKYn4d1paxDu6I1Ft?=
 =?us-ascii?Q?aevjHwdEgVC10BYam628sM8r8tBh8ESYtRfKnr64i0qk02Hm1HjC6t0xF26J?=
 =?us-ascii?Q?367IO6TlOgw9KhvYTcFaE3DB3wHEgQMfhO0edDuHcdi7ehBJKMgPs1qvdiui?=
 =?us-ascii?Q?+NC+V/ZEUysY2YWH043CHL4p4F4R/jFKQaGTwB0cBybNwAMdGFrBJ/QEZfuh?=
 =?us-ascii?Q?7/wPnT2lXHevEfem2G7RztnpOWxiowu0rViA2V0b0SgTdQ0+A8lPAaNH5Z/Q?=
 =?us-ascii?Q?VnQl0KIDzY4kGiJ5AMdnBH13AZxLEy1k8IkKCjr43uUmuHCPPdXtBYt+2ARS?=
 =?us-ascii?Q?D6OtKNAOoELNjQ0hJ15TM5vLSVdIw0pijWZ43CjNkJbeJqoiGZ1GhxPhzXKL?=
 =?us-ascii?Q?EHmlt/7yUTGpH/+ZCjH9yeMqToIDY5QBmc+AGy0FcbYTrpoHRF2L95++WnaL?=
 =?us-ascii?Q?sF2COGJlyjvcsxjBz3wmhcxLu8zXt5/+l/E8XvN4xS98AmwwfGOTFLvdbD4+?=
 =?us-ascii?Q?q7VQtePxYUKGDFTEx3EmwH2rUWguciNM2446duoolo4U6Qszm2geymNiSYu8?=
 =?us-ascii?Q?jxoPFYNCp10UKBCEr5eCBKaXVw9dbyEIxa1HSJjFgW3z8w779wYX2KHwNJBb?=
 =?us-ascii?Q?NvrfgHayJ44Nb/FPMKwSaFEW9003sxsbVZDpxjKnu34zWvTjAlT1VIPosOm/?=
 =?us-ascii?Q?v6/vTYlDJ+5yyW5XGf65qXiak3RMW4xGZVQLhlwQnuwKrapJCfH49N7D096b?=
 =?us-ascii?Q?PKgHWLTOLP7f+KvRrX+MAthqRz2BK7r/Ufbi02zZXAg42B/OEoDOLKjOvD6o?=
 =?us-ascii?Q?BR7fjXuVyimuANFLA2o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926e3ddc-bceb-4709-b6af-08dcc611eea4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 20:59:10.1202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6M5KU4TjcU3H12BPr1pK8ICGqthPPzyai54M/rxG1czj2R15lDEFHL6xxOY92hYfNY97YHTZSk+Mar3P85nPYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10681

On Mon, Aug 26, 2024 at 04:53:32PM -0400, Frank Li wrote:
> Add io-expander adi,adp5585 under lpi2c2 and lpi2c3.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

I forget mentions adi,adp5585 binding and driver already in linux-next
tree.

Frank

>  .../boot/dts/freescale/imx93-11x11-evk.dts     | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> index 60eb64761392e..7629b6b44aa43 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -302,6 +302,16 @@ ldo5: LDO5 {
>  			};
>  		};
>  	};
> +
> +	adp5585gpio: io-expander@34 {
> +		compatible = "adi,adp5585-00", "adi,adp5585";
> +		reg = <0x34>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-reserved-ranges = <5 1>;
> +		#pwm-cells = <3>;
> +	};
> +
>  };
>
>  &lpi2c3 {
> @@ -310,6 +320,14 @@ &lpi2c3 {
>  	pinctrl-0 = <&pinctrl_lpi2c3>;
>  	status = "okay";
>
> +	adp5585_isp: io-expander@34 {
> +		compatible = "adi,adp5585-01", "adi,adp5585";
> +		reg = <0x34>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		#pwm-cells = <3>;
> +	};
> +
>  	ptn5110: tcpc@50 {
>  		compatible = "nxp,ptn5110", "tcpci";
>  		reg = <0x50>;
> --
> 2.34.1
>

