Return-Path: <linux-kernel+bounces-296588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F23295AC79
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EA22841CD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A5138FAD;
	Thu, 22 Aug 2024 04:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K/fOSujY"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013057.outbound.protection.outlook.com [52.101.67.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DA6249F5;
	Thu, 22 Aug 2024 04:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300228; cv=fail; b=oiy3pqmrXpE+QQxIJXfa3C7EqFi9W30aA+x6ANUGvejyyJZgVXB2BJ/DhY7BJhjEG6Y0G4otGqaOOPaECnsTazkAFkVcKj42ySNCyeoF2O7PYqCIDJP5ty+l04wqyzSzekea0dY7dI17aYsZMuiBJZVx37D+B64N7opg26Ycb9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300228; c=relaxed/simple;
	bh=AfKHjCxTjnrhlw7/qel7D48/GrrbNozACoyDc0Lsh0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=idjyuR3OMUD53lfDsU60dQvqogUHHBicOsz4fAjhmzDVoRpt6S2hGS6X3DfcBmCYOZo2o76tIHWLjlK5uX89aebDG94wCdYySZJHl+J/xB5Y/aa+srKNpH+CxEXzQymmpjjiwcGNVkRxEwhB1FRX8IHIsUQK15KzI35BDevMP40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K/fOSujY; arc=fail smtp.client-ip=52.101.67.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXXdb/3BA1Vu4suX2TsVF46cnpRL1HSGS+sCvtChD9SOge4RYcyYx3tZamxZaFGEZ/0SnIyy7El2QqUrWm5wE8abqOX9ZaQu7r6IuKIatzQSJ8SpW89IsSqNuHmVA1hSjvzdAz184nLayFVtQ5B/EwM1xUGf4oXxS8D7ug2Ltqkll46JbwYho7qe5AOV1ywkkJ/PSuPbvxUKfY4p0ADTSsUNXe7phb2Wk3cOlapVmcZrxbeBskfTR83z6Qb1eWFb34IIZtAVs5yhqLDe1gCflRG0JgOXtTf2ZieGzwsSn0hQfF++Cr2YB7FbuoQe6+oOaT0qm6NwR8lpACMACRDfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96ZZQJqv5d94MH4QtAj4jfvwKSNhjDasziFOA5K6Iag=;
 b=jxuGN2/kmtJ7AZL10hZ4T6Po/V522Cb5RG4NXkHGRQybhyQ9Z0PI/oHljaDueMGzQTmeI3u3P/uNlzU3kOHaXUZNCkgOxTpdZxRpNlbot+g3Mb7jxH0fDelwir0kV+SvAU+T29+SlNv9jh3ZhXYvQbHGNhaNI51ARHZGP3TLQZh+zm01qEN6yvbadORtGuhacKWxEdeelEcUby/hRg2ffI4gnqy5KLynbpefCyrVYI26wSpbrFu1jRhcGkRz0hR8AJmPcqF/vc+u6/POAb1hRypH1x3bj9y4PasrWO6cJqoeoMgGQqdG3/D8cTEp8tGIA1rtKZsBzIqcscLIJH/xBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96ZZQJqv5d94MH4QtAj4jfvwKSNhjDasziFOA5K6Iag=;
 b=K/fOSujYLCEDqIGjwAktqgbXFdMt0tkPc7aw1Po6cgLwOVcf4q+wLLcZ7VyOL5EX70MQJxhuefMWHcnY9MYeeFVmh5WN0biFAQbfJOjoCSncX+v2eOez8FkrL3MZmi74yfrdquLyTH2I0A8+S7Q5FyqRRoWpwRpGyx5wOzc97HaMBqJZcUoBH91l6zQuMn/lAF8lAH1dgdqktN5Z3fwJUo5SOAVSgUbJhaUtkmNIFggD2+E9jJ69YjyjxlmTj7bL+Ujx8zsmygrIzg4ba77sCzmW0L4nCneufUYKwiaEJWN2F+wTrAr2DqupUAknxh4kPHqIAeS/o+4pW1pOWYDoEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10234.eurprd04.prod.outlook.com (2603:10a6:150:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 04:17:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 04:17:01 +0000
Date: Thu, 22 Aug 2024 00:16:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com
Subject: Re: [PATCH] arm64: dts: imx8mp-evk: Add native HDMI output
Message-ID: <Zsa7tf98tHC9xKZX@lizhi-Precision-Tower-5810>
References: <20240822033318.753724-1-victor.liu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822033318.753724-1-victor.liu@nxp.com>
X-ClientProxiedBy: BY5PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10234:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1bddb6-3f7d-4c12-6d33-08dcc261456e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+z1ny/4/v5GGOhT0futqHJGAZcnU5figeiM6ZBgS868PnQyWfp3aGXulUSX9?=
 =?us-ascii?Q?TSaNbMoD024l3w9ON/ei8wOPW+hz3iIUdODzRrL9f9n9GlZDoAcxw0D35cDg?=
 =?us-ascii?Q?lpfA7+j+UcH33/6xsnwBM5Q8k+hCaNQx89x+y4+SG3Y25dbDzcBZHku76ZkT?=
 =?us-ascii?Q?dZFh0mF3jsiQ3HNFGTlO1mvwW7M5Poj88t2GDmm9NqhpYqcRQdX8LdQ2K/Qq?=
 =?us-ascii?Q?zOllGZyQCYrc+JZtH42w3de6DxiyrSe0O36cKm5rVktJ2f+EWHWaK8GuzHVx?=
 =?us-ascii?Q?ubda0b5Cj191w2kHZ6D+Zh6UTffFgKzvJympC74LD5E+TQTAZNAumVcXfAQo?=
 =?us-ascii?Q?BLI/d7ShsaRa6nX+S0dFnQzasEhPbFgnd4Ejei2gkplHrrIBcrGCPtTIyADi?=
 =?us-ascii?Q?kC1LVx1/r7FbkqZ50ECHmSVAnDHvf/BbfUQtfuzQlUr5DiJe0XGehw6vpRNv?=
 =?us-ascii?Q?oTprE1AL518NBakGy9uCpKADUT/iauguOWK4ElhpldfUbJ4fm1uj1UkcBOeA?=
 =?us-ascii?Q?DW+3mirUJIb4NMVRmTNOOdOHmLDrV0pITCuMDd3b9MdyMFs7IrVROYHLCKnE?=
 =?us-ascii?Q?g9EMl1eZgD1ABh9TD58UdJtzjWQNi+92BO5POkJRWMyut2hjuRnoCKOnvgdK?=
 =?us-ascii?Q?6/snPK4wm/s344KN+HknD46ieJd5hfBWfIl3Sq2WPJ2keyywLPD6662/7FEI?=
 =?us-ascii?Q?hS1O0gl/nZENQbZNtqegLdzXW7X8fjLecCwD0YtSkg9fYJywN7ynPXHkrlVd?=
 =?us-ascii?Q?BNY4v8ja0lHgYfbkYW1+FyZa2eu9ijKZVBSywJQgmG4p6oMNeFmMKLKlc7tr?=
 =?us-ascii?Q?1/+EhMRMo9xbNQPVUCY7WJmr78mAvEL68hZ/60dR0tYBefub0vMyNMamUBhO?=
 =?us-ascii?Q?+abUXSZ7rPOO52Madnnm8Hrf0z30FLEwL1OQvk7VwKnj5FnhPgbuAdcbNHm6?=
 =?us-ascii?Q?d6mxDPp+st9HuUYou3NajaKIwQJ7U10RguS2zKsr5LbC3zI79truTb8IKxnN?=
 =?us-ascii?Q?CgyFFPHpZYw8EqRKPaG/Lj1/QiwWEJlrtJkwA9PAkQ1lXw/mu2oJ4umJv9ZA?=
 =?us-ascii?Q?j+Wj4SbRPsARuzX1pRSRZs8qGQWs+VZaF3fpVmafJS2+U2tr4imixMYOAdQ+?=
 =?us-ascii?Q?WMeMNRPitnSRd7M6JwSoSDFaeDw5HumhS8Mjlr8r3aBqGck+kDLAfH0MoFbZ?=
 =?us-ascii?Q?wVVUUMGfugLRPSdoBvuXe6MKoy94v/MeVW3O7B+R8UCBjlEcq5iEaWOsEMbi?=
 =?us-ascii?Q?wlXGTlMXkwBxK3KQMxE7B5gnggSzHPq1+Jo8q0PGPkhjylHGtTlD/Z1fA5ce?=
 =?us-ascii?Q?aDQU33FRIeJmDFzos73W3AzubpcBsFFWK+NEDsCzm5xqBQOPNgfe5ZQgrse3?=
 =?us-ascii?Q?75+iDHJObiF733uetzlc2o3DRkq1yxf+5KeAn0zYK8bFKa1YsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ESFwr4nLQ4nBmj4C9l26PdEoS633znLX+RyWk/NIeinKQBFGmo39fTb0Avzi?=
 =?us-ascii?Q?MSY2LOIfNh4ZH4fVIh8F0Didu4yLzjbKV2Jz521WdnIkSpHyhcfnwrLdAKEk?=
 =?us-ascii?Q?RV31+2Ca8yz/1TPApINkGurgYt4C17r2DWJz+OETv38wxSDXRQCwtux4OFfV?=
 =?us-ascii?Q?0mSRoZVBEubL4d7p4fqWgxgUzs54kz1g3HKUE0C3o5bOZyW/ScBecK1Ffs4H?=
 =?us-ascii?Q?/qBQImXqBkRB+q3b2jFu6rvMJOSY6ooBHN6iSNyo7do23eiAoeGqSzhUWhW2?=
 =?us-ascii?Q?2Cer6iZbnRn9m8Efq00azXXkruaHLtYHybMpYbmOUpfGTAnhitwPGhNv1RWU?=
 =?us-ascii?Q?TCogNrC0OFFe35Q/wOFjwrukRWzSYSX5iWwcRhwXUtWsChDqhRINkKku3N6q?=
 =?us-ascii?Q?yJnZrUk1IVnL/wGeVqQf4xNEz0Egk/DwFAJtqrkFgYMoUEi35L7BhPmq/nH/?=
 =?us-ascii?Q?T0rBzwxvD2IDSRYTibEx++vFX1bNAMnqhCxCFEyguRmrpcXh0lWeFBFURM2H?=
 =?us-ascii?Q?PydAD3vghcmoK7GxaDQ5enPdxiOxbaMaonD9+LSDToFWH8xThBneY357G6zD?=
 =?us-ascii?Q?Eul82V30fItKmtc+8NkPOexq5cQ2dAjCHpemm+ZzK/W+6I+7H+DmGRhhd1Gy?=
 =?us-ascii?Q?hoqcRBrF6oDYkkNcs31Ff53hrh3nlKeR3UhsfujEqCxHgceajUPhCirWeqDl?=
 =?us-ascii?Q?9opDBmPQu0Aa9EnieHDNiWiWOv1Wpb/+TecGertCNP2tXDIcd6QGObdLEsop?=
 =?us-ascii?Q?GT2QTpt1L67pw4435LRpqiPg2pXsyLj0RdAC9vCGrCpTEIfhbxAGmx5Qtzaq?=
 =?us-ascii?Q?578itpSmOGtUAp0xxhCKvrkyH/si27Q8hmc8Prm9OrsFshYBzeWbKR6Xf+WZ?=
 =?us-ascii?Q?YLl8DlLKVjYMmsWbjAyjIzP4cbJlLe/OtdgfuSh+wSKUMwvZDSaeKDAYWJ4r?=
 =?us-ascii?Q?73jy6kgNShAyZixNbdfy2piG+cl7+fJVPeDgXi9x5lCHjXNeXE0bLzFjQChM?=
 =?us-ascii?Q?0TVf8YtW/8thE9NDyEFHl5Ns+DJ+yrz/U8Apz2qzCk6qCfVJxsRJQ0bXykw/?=
 =?us-ascii?Q?5Uij4T5vIUI3PGGYk5LeGWxnRQ9KaZuzlZvG/M392bDWQYpBQaH3Ne+u7zv9?=
 =?us-ascii?Q?edPw2gY4pzLysyt55EDHqpzw3DTGfIaIJzXvDpnphSYg7nNMYaNc8vBBc4Ik?=
 =?us-ascii?Q?AfLvbUW3F43PGZlVZQNO7N4uMbyR34ili8+EPlVjnemn8ds10e9tCgFCMlHI?=
 =?us-ascii?Q?0eW7r9YgqCzh09teMnofnrCppBzy3iBZvKcmpS+CSdRTEuCmA2KnQbnkRU9s?=
 =?us-ascii?Q?JHHYGEaYRtk7JCssttN4XPur48SQsztR0oS1/5YvQ4UoeTaxYlk9h+MYzPXM?=
 =?us-ascii?Q?HFQak7wSLTXmBwZAwF+7LkExCo4OkM85Y+fi1kPymkesyR7+RitObOCVsUKq?=
 =?us-ascii?Q?kUwqSvXTCLQWOh3Q9VlUleo+PrSj7SQsMhr9tUVpETkcbf4vrXlfGdRYqRZJ?=
 =?us-ascii?Q?wDvkaJMRM9r317bXLhYMdVREuZuDTs2PFeYNIJkaFHHC4F1SBAT/pMpQRUfq?=
 =?us-ascii?Q?hkF311a7oyW7tHUwRfEn2b9nE1G9TfCl8fXVUp+6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1bddb6-3f7d-4c12-6d33-08dcc261456e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 04:17:01.3653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0n33ryK/fneU+vCCOLXE/Ix74pNsmfWpAJq1CdzL64Z4dox2+24SM+NESQ+baDaNb/sxWiuLyXDrCCZmw2NvYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10234

On Thu, Aug 22, 2024 at 11:33:18AM +0800, Liu Ying wrote:
> J17 on i.MX8mp EVK base board is a HDMI type A connector.
> It connects with i.MX8mp HDMI PHY.  Add support for it.
>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 46 ++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index 938347704136..f118fe8ab5ac 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -56,6 +56,18 @@ memory@40000000 {
>  		      <0x1 0x00000000 0 0xc0000000>;
>  	};
>
> +	native-hdmi-connector {
> +		compatible = "hdmi-connector";
> +		label = "HDMI OUT";
> +		type = "a";
> +
> +		port {
> +			hdmi_out: endpoint {
> +				remote-endpoint = <&hdmi_tx_out>;
> +			};
> +		};
> +	};
> +
>  	pcie0_refclk: pcie0-refclk {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
> @@ -408,6 +420,28 @@ &flexcan2 {
>  	status = "disabled";/* can2 pin conflict with pdm */
>  };
>
> +&hdmi_pvi {
> +	status = "okay";
> +};
> +
> +&hdmi_tx {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hdmi>;
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			hdmi_tx_out: endpoint {
> +				remote-endpoint = <&hdmi_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&hdmi_tx_phy {
> +	status = "okay";
> +};
> +
>  &i2c1 {
>  	clock-frequency = <400000>;
>  	pinctrl-names = "default";
> @@ -604,6 +638,10 @@ &lcdif1 {
>  	status = "okay";
>  };
>
> +&lcdif3 {
> +	status = "okay";
> +};
> +
>  &micfil {
>  	#sound-dai-cells = <0>;
>  	pinctrl-names = "default";
> @@ -858,6 +896,14 @@ MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
>  		>;
>  	};
>
> +	pinctrl_hdmi: hdmigrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x1c2
> +			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x1c2
> +			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x10
> +		>;
> +	};
> +
>  	pinctrl_hog: hoggrp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x40000010
> --
> 2.34.1
>

