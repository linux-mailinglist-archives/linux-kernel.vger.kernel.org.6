Return-Path: <linux-kernel+bounces-337287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BC798482C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80231F23409
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218161AB6DD;
	Tue, 24 Sep 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gPQBk84T"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5886A1AB6D0;
	Tue, 24 Sep 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190188; cv=fail; b=pNsvKIK7RvnJuyfe42QUuA1kXGmmI76qSVddVX52DKQEpGA25YCDc6VQIUy+HMA+LxR5AK2A2pknAEwHmRaoqZQrgpyCtYx2kvV4FQq8nPoG/jItuNaD/SjWv/9wKkT8yWowiVGF7aMZcbasZ8gHau33SmJx+A5I8zAFAshUrFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190188; c=relaxed/simple;
	bh=Jt08BnrEH4d51maUCKg0zVJSkHAAdHFXsnI/soXM6To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UDo+72DAazyieHsurugWzkT0Lk1KQLMX/QMNNQ0l5UaYmX09lV8ZMz59mYovzDLGV/z7cEyMkHO24MudUv/YKN7a9ICJJHkQ+PwvIeTuORYJqCI0mxoOgdfk05csqnvzdSIvSyOslbjn9BFwN/eB1pfk2ksSxbOoF1YGzuKXAIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gPQBk84T reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJcXOb8uEc3r1DSN4A1NW2R+XuSmxn2n9UsM6zU4ksHOkyJLl8G0GuA3EgM/N60u8sxXaVCNHTFiEX6kGCft2g0zAWB6x8jfEXYwuWq6xku2cmnSQqXtGjuflKv+dcyED0IcmSeq63Cu6ANUe5Aw+OG/DAudBESIroPV0YNXjOCpvcC9P2FpzxHoCY9/m6q2wSvVUdiZUUsQ7WEFvJhKB37XZNCg2ZVo64te3eXWN10hmddE80EEKx42YwIeYlq5c1+/uXk/sv9AZuNVzoct6ShUSPcusx8itEgl0CzdGculv91EXkG8tXpV5F2J4Mg5+E2EOdgLP3+b6k/5M0z9bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcvrGXJ7NKhGf10CFVybgHx/goohiBqL+MwTBTeAgCk=;
 b=QLBVnw6LEfwmmcib2I5B220A8AbYwYZnoxrZJ0vu2hdv1rI074/tlRJ1HtP645jsSW/TIIYSHJjOEHjaCg3IbxP19J4MZWUXXRag0jemXKNKHEAChEWm9qQ9o2yereQ8BZMHNA2v+Km/DTzadf+mP/a8d+KkKjjgPlw4B/qbKtFcW2Ltp9ATgdMqFIq2gzaES49FfnBu3Td8YcLx0EvieuLKoUDqrGZiQb6TVcPGhFuKOwut0CJeAwGvGI9UdX/VKx/QnFPlGOD7CDj482OwYL3zST4Blcyl1vpw+QM+5EGFABwAgsSia09pzao0tb/gzgaBHkUeRFNNroVanvWOdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcvrGXJ7NKhGf10CFVybgHx/goohiBqL+MwTBTeAgCk=;
 b=gPQBk84T58vuIOUwFnzezBFYFK+a2Z9POQWZI7g9Ue81VIcKG+p2rS1dLoP1Gik/3Jt1Y2baqyvqQZDeB/Fjz5tLXQVf0R/00JpYnBl/Pby0yUsx77C9tvIotkmHiz3pDXS5XHpmc8hMPOMokvObjyUB+2X+yOO8r9hAqEJnPZl4yY9krBuOF2WxQ7vZEyfBEFGYiB0/DPleyzCJVhUri+cFi7MVy2v6QInBu29tnOls5FS+poPDtHyqxSXbnvMbDtxK/7EoHguKEnDQnI1tnQCa1yb+OTMeSHUf5eXhyrRFlE77JVgvBYUGJ11nBujsuRzIM7MEiDjoIc5NIrojUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10929.eurprd04.prod.outlook.com (2603:10a6:800:272::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 15:03:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 15:02:59 +0000
Date: Tue, 24 Sep 2024 11:02:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 2/3] arm64: dts: freescale: imx8mp-verdin: add labels
 to som nodes
Message-ID: <ZvLUmqM5FWqKPxoi@lizhi-Precision-Tower-5810>
References: <20240924114053.127737-1-francesco@dolcini.it>
 <20240924114053.127737-3-francesco@dolcini.it>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240924114053.127737-3-francesco@dolcini.it>
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10929:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a6a3442-d491-41c7-83d8-08dcdca9fa75
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?F14ftD/3uyk6NLgsGYwa2Xrx+RWe7kaiSzG3XjxquQ/Zmah5a8thCBdJNV?=
 =?iso-8859-1?Q?QOad6u0V65p7an+FFSPV0xu2nVVw9VMBUN+erpNpuOZZwcGfOleJyIA3yI?=
 =?iso-8859-1?Q?m/Wb6XL05ZrtBeEaAuUCcyXFBjgZJSADWKPC9gtna8uhmE07sH6nISUAPS?=
 =?iso-8859-1?Q?7h/EfZUGmd8IcHRA18ipoNUPBV9hz2XO0TVxKsH/eUU3sYxHwot0+L5tGk?=
 =?iso-8859-1?Q?UfpmSoznbFxlQzT2o1B7+bRH9sQOYldncevaJ2NyiSEYietn88oXX88Sm2?=
 =?iso-8859-1?Q?avJol5h2mKxuAJOcNyrXwUXj83sTkAFd98ccR5IJMm9hK3bCf/xFGok5mo?=
 =?iso-8859-1?Q?bpA9J6HPh9jN1v67AdxwaNRwrGznvCts79HbV1gHhvKxTwzTWXwGjRntU5?=
 =?iso-8859-1?Q?UwVj+QoC7LkvU4BQHwedj7qEKz1oYNebPqLuqSmgJ0CbtT5C5wIdtwIw7B?=
 =?iso-8859-1?Q?KfGZMSHBpXt7WtyysqOdp4+oq0gaJx6MS4E8/oOHAstbyHm6ecfyo1sYd0?=
 =?iso-8859-1?Q?ChtzRCQeM8GsmDaNZLzBptflyY1dKoTWiw0Jd8jHzadFxXgpvo5UlJXOPS?=
 =?iso-8859-1?Q?n+tNTRAlxG0J29HiNXDj3WtN86C9jfe+OFh0FxBZ3sl23IPuAtohaSGkAC?=
 =?iso-8859-1?Q?NT5ltukpXKXGj/AzripTN0G7+qZkoCTyoivxZBCoyJUp11BE+vy+DNrEJy?=
 =?iso-8859-1?Q?sR32rnxvlTZ7+LwHPYX2SnG3Nsd5ORrip4/qq+7IUYasZsYKY3Ekak/jJW?=
 =?iso-8859-1?Q?uPdbG2mIZcEkx5Vpxw6H/IUvAsr3DeUdowuosn1KKlX02pJuQF6wbG8OAX?=
 =?iso-8859-1?Q?IaRmt31YmjkQU4M6AixAEFzw28/QA6hxNHywfq+ozjJVi2anQZKuhE7q+n?=
 =?iso-8859-1?Q?cqyeM2zvOfESU4aLJi6ZxaAGG20PuK+t7AdPYjhgwSf5tW4+yucgCZdPV3?=
 =?iso-8859-1?Q?wMZGgqCVawxA8daEC7+Jy0ENgUx8QE3ETBp1bx7gRA2HjIbdz2pqgzfXm6?=
 =?iso-8859-1?Q?ErqbY6fwwOSNKLbavGs8BAHVVutOKj3PuXJL5AuH9ViPgJBDuLUfVLhGsK?=
 =?iso-8859-1?Q?E5j8ivNXN3uurxU5NdbrlSXx5oK5XIxQchIOD5iWF2QxNmeXXF9QUXnyGc?=
 =?iso-8859-1?Q?hfxW8n04jP3xJZwKEuMuvBeYu/0dWNKfg8wNIU+tQTQg6ttom9b7oPUU6d?=
 =?iso-8859-1?Q?hMU4FIR4pg0r77ou6AaoJ1mrr/YZy0dsD77ZF590obdSObey7Dqwp/EFeC?=
 =?iso-8859-1?Q?QvOhZaDeilIaJKb8FmYLIsB3vvrSY/b019i3LJiUWTn9NwCAk3yF1G7cxE?=
 =?iso-8859-1?Q?ZHKeyKemiMLE55xmOk4TteHpFsBTDtT2VATsgE5wDQUgBjoPIWdjMHZeFT?=
 =?iso-8859-1?Q?SkJCil98xidLbSsQZ91Ekk8BQYgGio5A=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?lqdylvJAVWvE/Rtex9IkJX/bqkRzHK3MOeaRfVhLstKqccIijk/wQZwLQz?=
 =?iso-8859-1?Q?eT82io9FudHSqOSnNUMfH79Bd+wt45x6sVFBJche08p3P5BT8heESpTYYg?=
 =?iso-8859-1?Q?jEuDXaeMpScE2ls1OvZqN6G4QP+R/OTxxr8D/pmtSAWGZ2+2b8tnjkdFFR?=
 =?iso-8859-1?Q?DBkw4gIRhZrUuoKOzoPa6QSGu9r5z9cSfsgsc+ehW5S+jppWBUOrQdUwq3?=
 =?iso-8859-1?Q?P06XAEG8oblk9kAgwslwYjxxPUeYnpwmo0U/6tr6hC8ex8f9lV3Bdo8XWL?=
 =?iso-8859-1?Q?aNdB2lXDZYaC/MvTkmPqggJMwJeTRqTzmcanae5PIj0Fj9NL84Xt8qU5fW?=
 =?iso-8859-1?Q?or4Pbaj2ZCzf5ppf3AGL2cNBOBTYNdRXMUhbKZ10i5TCHIjuX3KC9YvIM7?=
 =?iso-8859-1?Q?kFpVuDQWGxLeFVmuefhwNs6cpHCWa/0hhy478e5+l+TrAzGJoONpMF11iH?=
 =?iso-8859-1?Q?0GUDrN4s1BFx6g84JHg8F3BiiFzZL6Ooudno62HJtE9gInxjAejdOSQEyT?=
 =?iso-8859-1?Q?EI9AkmcFLzKLfXhWIV/Ac6vG3Sd6jyoEx+ei23I2HLp4g/8skHPMJw7+li?=
 =?iso-8859-1?Q?uyquMp7Ofu4Wvhdi6fqfDC7Y3xSMyGRpIrj2HN18WxUjSqV3d1FuU7ybN7?=
 =?iso-8859-1?Q?xKekr/t6xCW0x7SgwezrhpxXd+of0QMwsZKns2tZWXpVpZ0KiOP5rlimh+?=
 =?iso-8859-1?Q?O85jOX8Xf7nGVKKoWyo5AAX8fHQZ4Jb7AQ8C6VFm0HYCvRo3+q0rFcI22N?=
 =?iso-8859-1?Q?f+TYjSZNmiIpXpjGCM+qdrsHj3tcIAJmme9ccShqk/tSR6xKnU6ay+A6R1?=
 =?iso-8859-1?Q?p1ZPapWmZ8B4x0FxB27q4kcJ0ghYNbYjCiGdyjB6MqwkS6SLKSp+LCHAg2?=
 =?iso-8859-1?Q?ocyi5nFlniQ5lffnu+IqGy+fp2iz0lPAuwOafXVqU8WSQ51XG7RHU8H3A7?=
 =?iso-8859-1?Q?pYF6m8e/YvfactVYG3LS6xyoh1Tjlnbn2IKoP77g0TnceRmXesTpMYn4VX?=
 =?iso-8859-1?Q?CxnX03CQdf5SgJWrqqZ5+d5m7uJLmizRtsj07ZVUIabQnyaj+GkCzgpqvA?=
 =?iso-8859-1?Q?fJMd6H3D6Nh763TqhoUpig+WY7JpRMMRqSPIJiIGBAHcIUHv4C3RqxYPpL?=
 =?iso-8859-1?Q?RrOUH7yYq0cg9/ki6PMLWIoDg/dA+LHiG1q2v1LzLcGAFHTE1yO5VzTaeQ?=
 =?iso-8859-1?Q?Dl9+AEK58sEQUtqfOyrL6Yo24Orp+8Cfl75nHXcbfzYgquL+UgvmUYrhsH?=
 =?iso-8859-1?Q?BAFUZp8WTnW1g49ZbjzzXPFxtfEzktynFpfLhUJ/7Kr9EgtO5Ggd/vALAN?=
 =?iso-8859-1?Q?i2yIlOTwzyrmyhbMIMsssPoSJXeurhY7lYqrLZOAbak1RUJau3Hc9exsiC?=
 =?iso-8859-1?Q?P+8HccGC/nOhah6mTcfg6TJg69IDCXTVW1oYz+chuzm/cvCY/3pk0u5+px?=
 =?iso-8859-1?Q?26e1z+8Z2ymXmUIR99bSMnTzivMfNhcrEAConblE10v3R1B768YqZ4+8+5?=
 =?iso-8859-1?Q?SVp9OPpMLLbju9DfhDNKPdI7sZIWa9MF/0jqimOtlMobDSZd9/hnY4ZaGb?=
 =?iso-8859-1?Q?gEK2W+xNTpObL33Ocntad5BATw7KYKrNGMnc3XxtT997dlWjrVoriwqiXQ?=
 =?iso-8859-1?Q?SxNptE9heRDCo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6a3442-d491-41c7-83d8-08dcdca9fa75
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 15:02:59.1477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kehHFDvdPTudida1+ncKk3XE91sl2ZkVyDwtrIbjHGAibPZaEew07j2oIMginCTG0RaPi7k7zxWfMHKOV8jhEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10929

On Tue, Sep 24, 2024 at 01:40:52PM +0200, Francesco Dolcini wrote:
> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
>
> Add labels to ti-ads1015 and fec ethernet mdio node to make it easier to
> reference them from other nodes.
>
> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> index a19ad5ee7f79..e9518b7c7aa8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> @@ -320,7 +320,7 @@ &fec {
>  	pinctrl-0 = <&pinctrl_fec>;
>  	pinctrl-1 = <&pinctrl_fec_sleep>;
>
> -	mdio {
> +	verdin_eth2_mdio: mdio {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>
> @@ -591,11 +591,12 @@ hwmon_temp_module: sensor@48 {
>  		vs-supply = <&reg_vdd_1v8>;
>  	};
>
> -	adc@49 {
> +	verdin_som_adc: adc@49 {
>  		compatible = "ti,ads1015";
>  		reg = <0x49>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		#io-channel-cells = <1>;

Why add this? it is not related with what descript in commit message

Frank

>
>  		/* Verdin I2C_1 (ADC_4 - ADC_3) */
>  		channel@0 {
> --
> 2.39.5
>

