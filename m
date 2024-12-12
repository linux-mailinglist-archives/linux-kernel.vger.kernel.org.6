Return-Path: <linux-kernel+bounces-443580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89769EF818
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B8629325C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1B420A5EE;
	Thu, 12 Dec 2024 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iq4OgpOl"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199F2222D70;
	Thu, 12 Dec 2024 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025158; cv=fail; b=ZBipzYdoY9AAQfpVXxsc47v8TAqJTidK22YB4QLg6JxumLqpiE2odNILOqvZyGaPvPdc+54WXu89lJ/3CkcGPKHI62XzdZlC1KEbfHTPf+4GSt9COsDaOzT+aqYxVTSr7M/mThLSTm/KkXfqIPOEIhBIV/bweU4AxzkHotYV3EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025158; c=relaxed/simple;
	bh=LlamBGweqwWAbAORPhsFxtvRcGCz5CkYLfr+kz6fjY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DyG7fCNIbL2TD5GYjd6eoT8AZBAdRhsxNoXKsiC/G3RlLLuTNnwEh0kJ/zHV3sDmJG5u5K2JuoHn9jZRJQa6/PZHnoRWu0rlPShLdbyPKTn7WiIKNhGebXTtMfx36UWHYeIXm3BaU2hLv/wICWGyAe3f9FgZsVBXarXMtg3Slyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iq4OgpOl; arc=fail smtp.client-ip=40.107.22.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxYpVe/pHeI2AmetU8p9u5Mp4TRiNQfr6xC1T/2MbPi2GnTuiTdx/MugJhPnzaQ/yPT2R+nwEf9joX1uSrqssz8NORcgAXY2Oe/s0utm1JMeiCsZJybiS948qU8ffWfgkDZq0JpUKVGkThXiEXtZgP5Vdz8mdy1y0nRKSq5bHp/yDM40xp3Y9kxwoeFBqyvxvXQPlsv/D+jqFchnOtZZnlsvO+YBt0zqgkuIRCh3j8Qeea1sI1C6ZaOWq4W9yY0x8LRv+O7xNmZ9RjmsxgSgF9XAvpuFBAL8N/k9zgYtVoDWe4fxM25xNsIoFA/OX7+OKLoGPGh8Nz+4KlFIS9B3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxbpcrKo40YnwlCl3Hc6CQ97SCtZ+W1QGCQ8bjIWCgU=;
 b=kcX9/ZYG00GM70M9kpBVdeboTYYQcENW0l/ox/HIcE1SvWkSL0BQoxxco+D0iU6q06tc9pPtOg57w0K6cg1cggr3PlKPLSUW0I7tHexvp0JnE0A5Rh51YXITh3PHeW053QVRXv7/o8UN5eTlqJzwwIFwN8KubJuwxQO1+v2Cq9OLsUF+O70nRIJEF1wj3/s30y5sdCkbXGuDFg+otrmUEQVlYa+rwwWy/E+GwQVgmzpKhnmrtY4CqPx3N0KKqEdyxbA8PPPXY20H+jpHHWQwNCgmraP8xLFWVCoPWaCXzdU6fykoR4V3GFmuJfr+QFZ3AWerHEd/ftRwXb1RwIwt2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxbpcrKo40YnwlCl3Hc6CQ97SCtZ+W1QGCQ8bjIWCgU=;
 b=Iq4OgpOlmVhTGcAstVYa+wpBRRniigETomAXU8LDsxVI3GsDq9p8xV4P8VySZdYJbUsQ9sO/1ec8a1mHc0o9reASi9BMyj1mb/Ss4krYT2E4/Mtmvm+5lXsCGdOimH9BlMpL7CQ7sjsA09UzTzlJsabgA2NKJ7wMLUBQkMV1RiaHDYqygpBhZKYs7pTdago5X4wK2Mq5fVcAsP1TdkfTCxxf0RXqCCaXubyjsDeDhkbctFbHnplX1IkIo2ub4K7/HAvjRHKPsQt4Z6+FGDVim2PDbImdjAet+u8q1x/V8yd8CdaBw9qXyaOtF3ueQj91vnvyiA5mFI43/+qK4+HJAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10420.eurprd04.prod.outlook.com (2603:10a6:800:21a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 17:39:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Thu, 12 Dec 2024
 17:39:12 +0000
Date: Thu, 12 Dec 2024 12:39:06 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: imx-ocotp: Introduce
 #access-controller-cells
Message-ID: <Z1sfuloPhKdv3Zel@lizhi-Precision-Tower-5810>
References: <20241212-imx-ocotp-v1-0-198bb0af86a0@nxp.com>
 <20241212-imx-ocotp-v1-1-198bb0af86a0@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212-imx-ocotp-v1-1-198bb0af86a0@nxp.com>
X-ClientProxiedBy: SN7P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10420:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de98531-1411-4b60-9101-08dd1ad3e409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hUK7Eg7dEAePPLYZg2FsViQtzltPV308URzo05w4L2FCpyBfE40pLWrjaixv?=
 =?us-ascii?Q?mx1YgVcuAsO2+DQG2YHL+gD2cTnyC7N8UJMJEythK8G2vQY5qxLZhHzKtXXV?=
 =?us-ascii?Q?Jcwmnwr2CWZD4SBe67nhQBMym0WUyWfk0r5BQto3iV+2t36eE07kK0yNEYhZ?=
 =?us-ascii?Q?/PB0zFnxf15362pRo0z0vjmJbpCVGvY3hX1b+4ZAgo2y5wJrHbnj/kK8NKpv?=
 =?us-ascii?Q?yzNIMHOfp4I4TtTnezQoO4HUE1SV/H90QbVsxLs+qi2LKLJD9/tS84sfVTZl?=
 =?us-ascii?Q?g8Di33JQZCyZ1CmDtr4/ndYGEn1p8MoQVVOkHJGFBro9NQIm27V+mLHtflYX?=
 =?us-ascii?Q?QvSQ0izNtFcrVscRLMCIfa/ens5z+qhiU0ndlEQy0NE15aHHY3Hh56v3WeBF?=
 =?us-ascii?Q?BfUXkF6zVI2ykgrqzn1gBiE9kK5kDyxtH13eSpSQv58eaFtR+AuDnYTlek6F?=
 =?us-ascii?Q?obRs+0k+UKf++5ezs3usgLqeUa5kWA7JYERRRJZzpBdcG+Q4D/hOAbNaGND5?=
 =?us-ascii?Q?Z/bvPt4Ts1N4iplSTGlWbbvsBYWpgjcVRDdxWF2NvT629PeqjacB8l1Z/X4r?=
 =?us-ascii?Q?UdsjIPR5PT1tUXv+N9sjZoGmNiif3HETI6d5DpAvncd9GHJc20erfrEjcblm?=
 =?us-ascii?Q?4H5K+DA7h8fcAZ2qsShLM+2dAbsVTTHFpRRZjIV20INsSQbDvDdev76ixoef?=
 =?us-ascii?Q?DhTNtUcFWjZF6qE59J9hFOHJUQ3FC6jvalJJeCc6A4wwOyOBjUEh3SF5owFA?=
 =?us-ascii?Q?plAOYScsy2f1yf2fN4Kzpxi//rRPMLVwE3tzSHv0fbDLD2YlO+m1gcJ6srRH?=
 =?us-ascii?Q?B1s49uSw2vVMdFzwugqHX/yJRTtc2/l6+mtctFvopWU1cfFd29zYAMvioaZr?=
 =?us-ascii?Q?652gv5Re0Mb08zjij3Haj6HRDYQP1UFwjk9pULEvD7miHWW2P+xTiujyL2i0?=
 =?us-ascii?Q?IRdbeNF5dqGBcze7nn2vvVFMWK1PqrK4oiByDwXDWhgF/Phnv50ylNrl9i/m?=
 =?us-ascii?Q?xUn7TlYobgY2UytuGiJxqWpa0wG/qK7NtGvmqg3InfrQD3iffCxk4tbr+7l6?=
 =?us-ascii?Q?bywf5dPsDh/pjf8FExcChH9ZZdKYTtdTzes464LTW5e9fbh10ghYrn9OSJeC?=
 =?us-ascii?Q?3EyQkW3M5GBhC/npVERyNnDA+Wp6VbING3SeXdi8t9nT9yM+NlJ7NjMpxN+S?=
 =?us-ascii?Q?NFoqKz4ttSyew+mQjKUi6gUOHu6Rw0etfN9YzvMsOWm2u+HXRAb7isaCDet7?=
 =?us-ascii?Q?w0bKJYkIaERxlxAzhf8Xu1xuZWKRvLQHKaTqY64pR6PHRyUykqx8VYLf6D9R?=
 =?us-ascii?Q?RN4rlgwj00Uos+fTBF4g5Gn1ADDr+d0SArH2xmHtXih/Uy56wOvyItkmvMDk?=
 =?us-ascii?Q?TfqP4LyaTI7QwEmzRcUWNjmzXdvHPdl9VcvucOajAhTzPnGIvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jobxkjR51vYtp2nl9JGm+BbUYpQkWMuQEQ9s+CT6oscFKFGJVdc2qB69nFvX?=
 =?us-ascii?Q?hiQhjocdXPSPDndyNIW1sY2vYyNysHom6TAeeOd4S5y5jL9/qW+nAp3UF+72?=
 =?us-ascii?Q?Eta0CVYKt3P99HVdjaqQIdul3RTp6Ns+C5TrtHwv/y9GPtje7VtC2zivczuA?=
 =?us-ascii?Q?XiP8BMCotF3fa2LjYhNEY49uQI92IxTOhFOzNI2gGiff5EgcZp5LLNjkjPQo?=
 =?us-ascii?Q?aqGmC0FsRLpgolWiaCzo3u5+M8WLxpJ5+tJYAfhAbziBnzSW47ftDWnexKfK?=
 =?us-ascii?Q?+/8wfL5VKJP9o2th1ecLlzLuwd0286h4Fq1V29J6TMmXKQuq6cTjYvkpf4Ap?=
 =?us-ascii?Q?XgPmw6K14QGuZzBYZYC+t3jR/KLfXH5z0ZQZB/Muc5p8UsBvvCDd2zcYWpba?=
 =?us-ascii?Q?1lYv5sAyTYTHGZDkFq2dGzNh1Jpnorsxppyr/DGXwwkAAdQmaoKnXKJqc+y8?=
 =?us-ascii?Q?vVYL7XX+RKNaccx9QsNMD78ysI1d141rByshCftlxvn8Iuq0lAqNONZjnCGy?=
 =?us-ascii?Q?/uL0SE/N4pzCcPHuebDIwPXfLruLJyPROT5EUrolElwekM7TuxXajqD6xXTE?=
 =?us-ascii?Q?cw7lM08UgIFpJXHcOJelu+HT+zgiwBDA6uvoDW0DvY/jVv+IllsKi01W3fxh?=
 =?us-ascii?Q?s1aw1TJS1OU6s6XLgqzLe20EykeLKgV4t79g/TnsT+dSc8VY1xJFzfaBLlpH?=
 =?us-ascii?Q?SZiLn8hCYIMGkg8quduhjWeCEWo/LuknbncOpBFMoidXbQnpug/HVFDtN15i?=
 =?us-ascii?Q?K/fK+Fyba9sN8voPgZ1BnDpVEIWzMaEPbXFnpg/rwqfwAb+sIztpGVhPOXK8?=
 =?us-ascii?Q?dfVlxedxMXijnYa7ZiwKqzCrFgjyopxmVZOUXHIdipz9xJRMIZA8z18T+IIo?=
 =?us-ascii?Q?p2pSddOiAnctbTiPBkoR3Wy6ruFNaVBULxTnB6r+RGQDl+xRjXkJV8v/9HmN?=
 =?us-ascii?Q?jG2LL7+s66F7MiOZlsreHiq8SxS/po8nxJ7Nle9kYZ1IMWQNsajtqFUZUS8O?=
 =?us-ascii?Q?+Nf63vFjwU0UEw/g7lXSyaInYC4KE9vyvhahCtTA94zG8q21JfOuytf4cJLS?=
 =?us-ascii?Q?U5BPXpklX2BHzWmLWBbC+/uBvWzgRvICkfoH8yf6yGeP65j5uM6jusUigfRk?=
 =?us-ascii?Q?CHF1JkQ8I6AiAKR7WIj2nwv05oL+VcFMUSxxJ541kLgEv2qWB5aELm4GScuR?=
 =?us-ascii?Q?R2o1CqDl2OfAblxJNhqG+BwKerZWS4tllQl80ON+I862y2N5QFT2AMg3bBjy?=
 =?us-ascii?Q?FcMr9/or+tKA6ZLU0HN93CntAIPZKpN/dFttgiDTVRSNpTHSupKqMie9Kfbw?=
 =?us-ascii?Q?wJWub16DwpnzCgmW4OTj06n3idZEqrYHp8mbwCBk3E8uwX237byjyYa7pbm4?=
 =?us-ascii?Q?PXLFmcbDJf5+gtakBXSmwv2MkyMPoENqK3+3dzhhO1TZhww9InEh15RLLSfv?=
 =?us-ascii?Q?eN2mnuwCcdgN1yFlyc9XYVayycgQumfCwoM2xWLRAL5icrMHUZZ5oPahyUTu?=
 =?us-ascii?Q?1rL2gWebnf9Wqh8fIfF0jum9gnzKtaVhnd2P6W0uCbutqBWB0iuQ/Z9cvjIA?=
 =?us-ascii?Q?298pNm5Ttey3WIIAe1EE/b81fqz+lIgiwfkdlKm2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de98531-1411-4b60-9101-08dd1ad3e409
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 17:39:12.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rr4TLfAyxZ4GuaYBvUDxasMLRNRZI3+NwgVRn45PSVBVR05bEJIwUDtqWq9bo/HNyTFFt+hzgQ5OxZB95ZGxTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10420

On Thu, Dec 12, 2024 at 04:24:41PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Introduce "#access-controller-cells" to make OCOTP be an accessing
> controller, because i.MX Family OCOTP supports a specific peripheral
> or function being fused which means being disabled.
>
> Add the i.MX[95,93] OCOTP gate index.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Nice feature!

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../devicetree/bindings/nvmem/imx-ocotp.yaml       |  5 +++
>  include/dt-bindings/nvmem/fsl,imx93-ocotp.h        | 24 ++++++++++++
>  include/dt-bindings/nvmem/fsl,imx95-ocotp.h        | 43 ++++++++++++++++++++++
>  3 files changed, 72 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> index b2cb76cf9053a883a158acaf5eaa108895818afc..c78e202ced22f1c278f7be827b71ba434832d2a7 100644
> --- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> @@ -54,6 +54,11 @@ properties:
>    clocks:
>      maxItems: 1
>
> +  "#access-controller-cells":
> +    const: 1
> +    description:
> +      Contains the gate ID associated to the peripheral.
> +
>  required:
>    - "#address-cells"
>    - "#size-cells"
> diff --git a/include/dt-bindings/nvmem/fsl,imx93-ocotp.h b/include/dt-bindings/nvmem/fsl,imx93-ocotp.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..6ef525173845fd4ee0e847cf5a17e53a14f71362
> --- /dev/null
> +++ b/include/dt-bindings/nvmem/fsl,imx93-ocotp.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +
> +#ifndef _DT_BINDINGS_NVMEM_IMX93_OTPC_H
> +#define _DT_BINDINGS_NVMEM_IMX93_OTPC_H
> +
> +#define IMX93_OCOTP_NPU_GATE		0
> +#define IMX93_OCOTP_A550_GATE		1
> +#define IMX93_OCOTP_A551_GATE		2
> +#define IMX93_OCOTP_M33_GATE		3
> +#define IMX93_OCOTP_CAN1_FD_GATE	4
> +#define IMX93_OCOTP_CAN2_FD_GATE	5
> +#define IMX93_OCOTP_CAN1_GATE		6
> +#define IMX93_OCOTP_CAN2_GATE		7
> +#define IMX93_OCOTP_USB1_GATE		8
> +#define IMX93_OCOTP_USB2_GATE		9
> +#define IMX93_OCOTP_ENET1_GATE		10
> +#define IMX93_OCOTP_ENET2_GATE		11
> +#define IMX93_OCOTP_PXP_GATE		12
> +#define IMX93_OCOTP_MIPI_CSI1_GATE	13
> +#define IMX93_OCOTP_MIPI_DSI1_GATE	14
> +#define IMX93_OCOTP_LVDS1_GATE		15
> +#define IMX93_OCOTP_ADC1_GATE		16
> +
> +#endif
> diff --git a/include/dt-bindings/nvmem/fsl,imx95-ocotp.h b/include/dt-bindings/nvmem/fsl,imx95-ocotp.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..2d21d1f690974d0215c71352168378a150f489af
> --- /dev/null
> +++ b/include/dt-bindings/nvmem/fsl,imx95-ocotp.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +
> +#ifndef _DT_BINDINGS_NVMEM_IMX95_OTPC_H
> +#define _DT_BINDINGS_NVMEM_IMX95_OTPC_H
> +
> +#define IMX95_OCOTP_CANFD1_GATE		0
> +#define IMX95_OCOTP_CANFD2_GATE		1
> +#define IMX95_OCOTP_CANFD3_GATE		2
> +#define IMX95_OCOTP_CANFD4_GATE		3
> +#define IMX95_OCOTP_CANFD5_GATE		4
> +#define IMX95_OCOTP_CAN1_GATE		5
> +#define IMX95_OCOTP_CAN2_GATE		6
> +#define IMX95_OCOTP_CAN3_GATE		7
> +#define IMX95_OCOTP_CAN4_GATE		8
> +#define IMX95_OCOTP_CAN5_GATE		9
> +#define IMX95_OCOTP_NPU_GATE		10
> +#define IMX95_OCOTP_A550_GATE		11
> +#define IMX95_OCOTP_A551_GATE		12
> +#define IMX95_OCOTP_A552_GATE		13
> +#define IMX95_OCOTP_A553_GATE		14
> +#define IMX95_OCOTP_A554_GATE		15
> +#define IMX95_OCOTP_A555_GATE		16
> +#define IMX95_OCOTP_M7_GATE		17
> +#define IMX95_OCOTP_DCSS_GATE		18
> +#define IMX95_OCOTP_LVDS1_GATE		19
> +#define IMX95_OCOTP_ISP_GATE		20
> +#define IMX95_OCOTP_USB1_GATE		21
> +#define IMX95_OCOTP_USB2_GATE		22
> +#define IMX95_OCOTP_NETC_GATE		23
> +#define IMX95_OCOTP_PCIE1_GATE		24
> +#define IMX95_OCOTP_PCIE2_GATE		25
> +#define IMX95_OCOTP_ADC1_GATE		26
> +#define IMX95_OCOTP_EARC_RX_GATE	27
> +#define IMX95_OCOTP_GPU3D_GATE		28
> +#define IMX95_OCOTP_VPU_GATE		29
> +#define IMX95_OCOTP_JPEG_ENC_GATE	30
> +#define IMX95_OCOTP_JPEG_DEC_GATE	31
> +#define IMX95_OCOTP_MIPI_CSI1_GATE	32
> +#define IMX95_OCOTP_MIPI_CSI2_GATE	33
> +#define IMX95_OCOTP_MIPI_DSI1_GATE	34
> +#define IMX95_OCOTP_V2X_GATE		35
> +
> +#endif
>
> --
> 2.37.1
>

