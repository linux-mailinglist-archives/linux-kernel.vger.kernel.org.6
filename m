Return-Path: <linux-kernel+bounces-323380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53EB973C80
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3BAB1C23C14
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C51E19D084;
	Tue, 10 Sep 2024 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bv+5rqep"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D28143C4C;
	Tue, 10 Sep 2024 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982969; cv=fail; b=kSTn5ScOQbSRgU25UAK/ul3ZG1zaaVe/6MUj9CfklE+H2vcI6To3AoL9EbbACRoaD3fhqckW8u3OfHm+84ut94juYXIF6iI/KPfpfDgM7ceXv/JJwvhg5nL877FAS9gzSSXhILEgg887/VllSEPeHqOo/ox83luRv/JbfJ3LuGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982969; c=relaxed/simple;
	bh=IBZUKSgLgav2L+fSTtWQvngF47CV73aUF0T9Qq25B9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tyia2YTFyN7H+sd6xyItFL3uQlZ3++ospqsZo3rRy2/+oQZXiZYuvw8AsvHak9f7pdQx0chhFs3YH2VICRBsbRKJxXuPVr60Bdswf/k+gEoZ5jIaYABRtoZXs4rflCUKSruPMkFJNr9J/xgRNUGVorbDLkwp2NsSByZB0NofebU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bv+5rqep; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mviFu+uwer3YpEesRkC+p6db3ttuRNWekhHQWJlRoVdulsrGBpQtFdkRqathMj0E1J9NEDUdVdppUHdBsJyK+fPd1R1NviyDoTvNLYJZXgIwJQVNv6zwZbJ+s5Tmm5b66aHWz01xnUl6pgsQodxU98YG8vXOHyLxuVBFdrZoWN9BsTZ7mdjmZPb95xNhFyfm5mlLaQCSSpUxlW34DzGAHEZ0DifqNVj2PYcgoRaCEJA68xv12gDZY67r0dXa10I+2CFL7/cYaLVBDoLjtcSGEdtLlnNHUvtCDEc9EgkE9rQuipFEAByIerH3eM86Jp14vE8E3tkNiBaUZEr8AXeeBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVd15gwzMmbX4IDq0LM7jcTcnroH7sFB5JbUnPRPzZE=;
 b=jgdmcvVMYlzF/+5cJ20GL9mkft1p90q14n0FdurK/MGkZ2yWtFxxXBBRrY1B+RptCeyR+/k96GUSCIC1GiPV4Wdory53wGtkja6yaJiKJz0JIQF1nhHjR7ZUF1+EyYjx5n2xXn81RHOCJPEXm06h/biUHQUdyLgJB6LlYeLL9AkTX8Scz4srIa0gJXchL/ZYDj2HNPjSEWZHz740eT0m3nxogSTVOkcyftjmJmQshrR0OD9apvrMPpAeW1szXSC7y9SsZePkAe9UD7TBqHHWOATAeQZyWOUprR6SIwaWZq66cmrE63VypTpcImOP+I2j1LHBBOPCXe/T3pXvC/3jrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVd15gwzMmbX4IDq0LM7jcTcnroH7sFB5JbUnPRPzZE=;
 b=bv+5rqepjo3sZ1avZqmG8GRdCISPfbgCRsrH5gAGFYr3Ng8jcQn6RXTnjSoGCCV4hf1oJA/vPaFieD7oZ6OHxxlRwR9rRsOzbMBo+PUxITd2iAa55ejRu/5EwoygP4mEb8+cPj7l+4wHkoJCFE4UO1EVZ8gLziG3OeYr4m4F3U0jgxlDGssRXSyg5nb8nFsly0m3prqw9TkpNq5Gr0jYmtUjBiVcU94Og9M0pYVvzAmRtTqJBV59EykdGDqPl5csPckcKcwbYdy1Ny/qLJNtSNbuTC5+60wgZvhepGC5ShH/JBmbCvh2lhnCcsFwNbdqN/MnnWJAQWkSajMHcsJveA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB8061.eurprd04.prod.outlook.com (2603:10a6:102:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 15:42:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 15:42:44 +0000
Date: Tue, 10 Sep 2024 11:42:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH 2/3] arm64: dts: imx93-9x9-qsb: add bt-sco sound card
 support
Message-ID: <ZuBo6zNQcWTTNrzA@lizhi-Precision-Tower-5810>
References: <1725952772-30357-1-git-send-email-shengjiu.wang@nxp.com>
 <1725952772-30357-3-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1725952772-30357-3-git-send-email-shengjiu.wang@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0109.namprd05.prod.outlook.com
 (2603:10b6:a03:334::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: c39f8a99-8a85-4971-9771-08dcd1af3694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p4d3Q0gFsnrRiVMQC3C4meAJW94hBhixsPnSARjKsQ82SZOI6lC7KERCaQpx?=
 =?us-ascii?Q?QBnWPiOFFJTRQP/ZxsUUbjISOJnKh+5QjlBMT22Qnz5PN0/H9NNI5PBVQnRD?=
 =?us-ascii?Q?rhb27zLxYb0Ynq/V1vFsy6DMIslXsaELi58foaxNztWT36J7rqdLh8+eQZN7?=
 =?us-ascii?Q?qa6EtWF4mbabVLIvpm95i56zfIOF8hfiD+vcSBgr6QBCJ+YhPLxu4jhBH4zL?=
 =?us-ascii?Q?EWoCPEPink4sSW/uqk5S+36CTb+NZjzbqmzmV+EAJFingKnxzdHihcJWd9ro?=
 =?us-ascii?Q?CvrBk+YRTv+ztyuDSXqyWQMimdsULPen4KQurWNY7yU9OIKRFsZTsk1B50SC?=
 =?us-ascii?Q?2ikaCEONgWIbngK0VZRkMX0mbMTIcTVZyy5deVVR7jNBken/GFyO7T3zIVC4?=
 =?us-ascii?Q?bXKiZSZdRHWSKBprbWJzGaGEFiKth6sBnOhEXcizLLy8B2e8fJSUQ0nk2UrU?=
 =?us-ascii?Q?+NYmwwcEC0dtwLFC5unp6sPcEZZbyMQ04qqGgPtiorf2bbLEZiM3ufKqeTqW?=
 =?us-ascii?Q?KFWjjILx2OpvqBKENnWJhSuwT5lTZb5tz5zyZh/vl4/tKuThKljsIcJI3Cd3?=
 =?us-ascii?Q?ZIbqLELo9IFLMdPdtLCJ4XW9J6IUFNWdYc5ca2NjGKO7t4np8OJlgCZv0AxG?=
 =?us-ascii?Q?mnSjM+CVRau75rlOo937yX9o1akXi2ZmjZno/wWnx1hGZCUYmJ6GFu993dul?=
 =?us-ascii?Q?QOxcu9fNFbwTAnH/m4m5doi1agumuioqNeN6UNDG4wFIK4UbnfLIdZrn0A1p?=
 =?us-ascii?Q?huVC8Lk2fu/huU+9gZ48rDDvsdG2ygQlMnvV+jpIL+V64RBJPpTn+Mhf/2hO?=
 =?us-ascii?Q?D05LGQlkPpzOEumEgwyzmeJ6H8sR6tC4K3Ts/lwLHHmpQ2TAtA91d7CW6Bax?=
 =?us-ascii?Q?N8KUC/IRAf3mhrqMaJESlOMRZg63Mg4QV3BOP21U/2UFvBUzkDMq8TOXrlCh?=
 =?us-ascii?Q?54EtVn2wSTNAK+BeXoej/7m13ewGmJqtzJhvdIa6OTWRs4msCc3Y92En7Oto?=
 =?us-ascii?Q?ebX8JW529Tvn6uLV2Wp0tOqVRVRl2elaSZ+lZrD7jpiKcDzF1eF8YlNCjcA7?=
 =?us-ascii?Q?VYGZ/ORKDQZpCHSybZfTqZ0XOYgpEWBJelU8vNG0TweKMe+I6+qlSqxBbM0z?=
 =?us-ascii?Q?11x3wQvvOaFcET4Uiz7plvt/pMpsjwsZ9GNgPzqXcQ9o2ycSxAafHx+RJGz4?=
 =?us-ascii?Q?NHPw5iM+3ygtMcEM5r1g6Sr5Pu1gOH3HCDozz3uKUrLZY8xuACKAoQM4hDJf?=
 =?us-ascii?Q?n0Jilp5X+KzbLt4Z/y7nzArk5ppKKBQ/LYpZmlXXZ8n99u12eDVjaDii0IF2?=
 =?us-ascii?Q?LNsSRMOhe9iZPxAi8kJvxtsyZLkTWz5YKw4OyjJfQmFRt//WkyacEgczuD4M?=
 =?us-ascii?Q?i71cCfv/6wjcYiQlJImaEx/jF6bBfkU2uZ0MFUnfoFMbKh46sw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zSDVx1vqTnZcs+tRHzJKOGusfkWf+UvSKFyc5peWGhPTjI0B3N3cucm6qutZ?=
 =?us-ascii?Q?pedMMfqFT2VFahT5uHrjQK3fZjiA/P3UPBgl712Exy+sGksNv4BbrGVPbzCT?=
 =?us-ascii?Q?MXllds3qopSBvWYs8DY8iUQ9rdLaKxkgIYe/lwdTEKy6kSlruNHgh4eHnTYj?=
 =?us-ascii?Q?jUXOZHY3ARhN9WHgMdH85RGijXAt/Zs9Sr+b8m2Oj1/u9nES3TK0bvw8GLI4?=
 =?us-ascii?Q?31/dFexZ2UfrkUfFwsNUet9SknEim/ClEHREDtadmR6UtrESJh5nrkj8tJIz?=
 =?us-ascii?Q?lbD1hZ8j2IOXQQdDWgSkJ4Lh2ynU5CYNOMPwvygAG0LruTBApG0gxMeJNEeQ?=
 =?us-ascii?Q?hyjztV8vZPp0eVjgzR+eXnvvVdwLB66as+Uep1Z4fn65HTOb4iM8vWMLIHcq?=
 =?us-ascii?Q?hB/hlVup4bBb+JIyEbHT2+cO6A60Tsr+BnNRR0EJwPwtxa/YlBVLBHmkjDEm?=
 =?us-ascii?Q?glBhFiCwfh7E2J3/3qjaEAZTQpHh4VPbct+lKRnEXhN/nzEjKupEqDvmcFOH?=
 =?us-ascii?Q?FeRvYOl1APJfJ/r+7q1yGEG9nYfK42iGq02/W77jIvcRwrP+QANqeHaziY65?=
 =?us-ascii?Q?er2XHrUA0c2HuzfHod7G01VtneIz5ZUWjPqv32Y4PiX4rKnWKu+tsbEU8gLt?=
 =?us-ascii?Q?c0vvE5Koig445hpbQxj8KCFDTBkFNHA3THconeio7LDWu1378nhtEbKJhhZ3?=
 =?us-ascii?Q?mZJT2Wl0jq9bgFSQulzBDj466ACCueq8atUjSKazqzLphwoN+P1wCwRMH2s/?=
 =?us-ascii?Q?UpC6Jfbfs2bQIjYUjOTfylk978bojF5iOfn902SiJFN2NvU9Kb14UYrAXJj5?=
 =?us-ascii?Q?WhqVa0MTUY6OWgsHXkXmJk1dm2gBrAlX7t0VuwYrfZklTaiVnQJtqdVeGXvO?=
 =?us-ascii?Q?8+3/GOK7RkdIRTS9licHGIV4XNEuuiR9FSEVkPo4i5IyNwx79iIiukN8X28W?=
 =?us-ascii?Q?Sf2OXiL7QnXUVJgnVy+RgVt4AC/sBCtY37qKGH3MEoRkzhde6R82xF5lCpyy?=
 =?us-ascii?Q?0WtW4YsG5gWyTzagiL30SQ67r7g6zvwJ9AU5KewqE7XLwu1VcfZIaH3Jsjpi?=
 =?us-ascii?Q?M+RR2vifqdNjwETzV41EJ2yRTIy9ezphOvGF5ITukLWTbDuicqxTg0ff7+J+?=
 =?us-ascii?Q?guVEIV7HXNruBzUIiyBatjUdBUjLlpCySCRgZsc1CoRSy/HgFc+cR676JmtB?=
 =?us-ascii?Q?lbCyYihUg9D1xhFehM7B71oLcmvcSvUlMLzpHEicrLD0D3RaQZoG/a0/tiVf?=
 =?us-ascii?Q?L0eSAmT3Jmqs4BCoJO+gSbaZp/sRAXxoVIFIrptricxv9H4zRuOpIWn2CUd4?=
 =?us-ascii?Q?guQabdYrQHfSmavcmg4UvJU7QaFRu048cw9WH5z2B/MuuyuKAdFWuuhiamFN?=
 =?us-ascii?Q?fEYnHMRDqovrbvu3sSiv/5u2gsPlmPyt+iopK9djuPx65biQK+pDqfdkbmP/?=
 =?us-ascii?Q?WkAepBlElrXg1XVCVoHKKAbzYlRQ/lpn1qkqcnErY24tUSithScq16w8zOuQ?=
 =?us-ascii?Q?0gwoS1WmKNjLdxfQL8TEjSbVygov3fne8GGWHFXIAKqvloG/jPyJQUOsyavz?=
 =?us-ascii?Q?t0gTOzjWse60H6WZpKqqkFu1mTzRZoXmy5kEUuIg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39f8a99-8a85-4971-9771-08dcd1af3694
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 15:42:44.6324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 830sNhT7AySqUfEeA5h2/IL5pHuamaC2uVF8RAERUZTEP64kDF7qPV6hVkO8c1PPJ8qQdyWn9Y30q1+EM2iHyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8061

On Tue, Sep 10, 2024 at 03:19:31PM +0800, Shengjiu Wang wrote:
> Add bt-sco sound card, which is used by BT HFP case.
> It supports wb profile as default
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../boot/dts/freescale/imx93-9x9-qsb.dts      | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> index 336333919a74..d213a5343803 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> @@ -98,6 +98,30 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>  		off-on-delay-us = <12000>;
>  	};
>
> +	bt_sco_codec: bt_sco_codec {

nodename use -
order node name.

Frank
> +		#sound-dai-cells = <1>;
> +		compatible = "linux,bt-sco";
> +	};
> +
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

