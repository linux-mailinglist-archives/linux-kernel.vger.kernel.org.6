Return-Path: <linux-kernel+bounces-519807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAC1A3A225
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA1517842F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353BC26E171;
	Tue, 18 Feb 2025 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W+CkiXFz"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CA426B2D3;
	Tue, 18 Feb 2025 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894764; cv=fail; b=ZrzwVWDacV82ZMUem5S32FiXCg/dTCoTnkAlUCEirujj5fCwpN05XpFDFQucp3gob9RMI9mit9VukX2l0QFOmv3M8pmaE7q3duqPBB1Eq2VUtrwKm1PR6VEJKsIq31+RM4udQEj6Hc+knudUlftW+42pguWusBmZn5vOu1gAYOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894764; c=relaxed/simple;
	bh=YGDv1jroqLi1hP5OoV6veN50xqLZThyLA4f6YaRjtqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kQMpbVsRoQVTjEC8cQoAlUAPu8Sg+VZVKPDC4e5YIpkccFyw3VEqiarWMrsbTwefqTg/lg6DDGWAxulXSdGWwLDeT9+QCPr3Flf7YB/p19r0k29JGt8x9ee+lW9GiAyeCuZdK/Sh5XARmWVnEeDFhrROjSa8bgdN92zJ0km/CH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W+CkiXFz; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNYOI3vpJWWn8pNZRkVI9r7QnNxjCWu81Ooxqg7dDO6IeSSCNr7o622+K77Rfq3ednrkj5UgU90tQUzAEyOIjcqChzNAIbxx7GoMrppWWzRRo6yxL7aRZTt4f9eLGZCJb/5o2IyHDSonkB36Rz+09chelQcaDlS3X+Nu47daIl7mSy9yx8su79fG7dl47HiiFUnMyzZzUqNh2pzNOCMiHIYVSHlD4TV8Z71/sF/tQUQHm6rMV2XpAKAHdozsZJNSqnX0aj8MXsg6niCzcvawy4o6P0/36I6g6ReUt+OeZiW9dqiTTUDGo6YblS1mq0tW4emjhRCQPwQjTwhVIF0tGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pdi1gpQdp/VPeunAIWhSCkktV0o0RleoUaEN5RjJBWw=;
 b=ndkQcMg1rKzXeKJYHuJDKmctPTR3LvxyeFCXuI0AjOuQZaW6/WZa+vgjtaV1PKMQvcbvQtfBHhN+NeUV9Kb1nrl8sGMiMM87B5KyCBy+2tqzvQpt53PRo2S0d+RkbKQVOuHm973Q/bgc67Rj/7BukNeRcl+YSEGLfYvdk2zWVGCtUXU6ANo3YpIUvPgoS4xhqwD4kjm8Y8XBjy0aCzL5HSq4GC+wNa1yEkLpbdiN5YtCvLM9yRUyDeIxX8oN2roAdDO3PcrN2Yu7nYG18LWpiU7s8gBjKnrjL90v0TZkT61PaD5pDgoUsYzJ0G/P/eV37yeR6hRLsiFPvkKOZRYD7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pdi1gpQdp/VPeunAIWhSCkktV0o0RleoUaEN5RjJBWw=;
 b=W+CkiXFz8g+Nm0MVSCsqt+sZLPg7TsbON1ZgMLL3mzCcZIZgJymCKmdEi8fNvVYyyaXUiLvrsPzRKcI/TtLsuKGF/ab0M4u+kqc5SLHJpANsj2BqsS15sff/u2FM5FytImOJWlRk7l0yPoZ2KUvTqco2OWGq+6pu2BWVeMsBda8ANZKcqrdsxR3etKrdDAk273QoQFZIYfbQ/gc6R3mL9OJmq5KoPi1RIgJ7Umqsuh0QUPykM20O6FvXDXbw5nkPxQcBVAZ3TP5z7fVTx56bTPCARRXR2Ailp5nFoh0VDRxMsKXSTowm/Rlk/tSAZsjeoLJtDZDajmytaukRAXEfqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8259.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 16:05:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:05:59 +0000
Date: Tue, 18 Feb 2025 11:05:51 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: clock: imx8mp: add axi clock
Message-ID: <Z7Sv3yawaYdKFYxi@lizhi-Precision-Tower-5810>
References: <20250217165718.74619-1-laurentiumihalcea111@gmail.com>
 <20250217165718.74619-2-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217165718.74619-2-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0110.namprd05.prod.outlook.com
 (2603:10b6:a03:334::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe707b1-aae1-43b6-acba-08dd50362241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+pV7sEQDE2zhhAU3y4StpkEP4ejp1Ky1Ag4DNofrW2qk6+fGn8ZoDr/NSQaJ?=
 =?us-ascii?Q?X6e3Epqq8GNZWXtAt0QOrLXI8CPVHYc3FwyE6+O/j1UKdEcz8wizAOXh8TF0?=
 =?us-ascii?Q?Eh2xOlb+UF7w7jHFULI1iEUzxuENXpoUq4aie65nW+pHWXbyl0DOWQCwjVJn?=
 =?us-ascii?Q?EFu9Vl/nmN9ge5hOxAgs4AvXFCfqlOiPoo3jkbpXaMrxaZy2BlSm5zcWv651?=
 =?us-ascii?Q?r0QYS3GKpHZPVh7vd1KJu8bxM59B4n7Ckb7TNfy/GXk/xVXpD376z8DFtQAd?=
 =?us-ascii?Q?cFMixtBqh2a35m5hGq0BQNK/ooQnxhEN/WC7SB4nTpaMQn7GByER/aqRPNys?=
 =?us-ascii?Q?3yfocjwElwHNZv523esT+lA6zCAFEcYnmGtUZxLEEJmIn74O6YImxIWIY9IU?=
 =?us-ascii?Q?6lK16+MJkFEIsJZK0KFpUXydZv+CdcFzYHLMgG95yJxoPE1q+CkICu09JqJd?=
 =?us-ascii?Q?CPlFbV8VfHt1OqWD0vQRbQ32I7uGt1kTI1unm6eCaduL5SQDSlRbGToir2sl?=
 =?us-ascii?Q?yjSZS1kxfCL9RvsLefQwZguNU6jV5+mI9neWpK8iFne8njfUrTGTAXyiC/ll?=
 =?us-ascii?Q?pCbqpJp0u1oSKs8J1y95OKPwGhLilfKZPeQ6tmChbjql+JD5fUeg8q0Y2Wcn?=
 =?us-ascii?Q?UCiPYRWdP5A/fGr7HvwrVOwWKhiuoZC8jpMENzPoh4cQPVNL5WFVTL8mO6af?=
 =?us-ascii?Q?jAIVRXu3ay6x6QdIb8tYFV6kEDaNO4DcO7Bg69FkGBVsx9eVnVnoQY7nwS7E?=
 =?us-ascii?Q?gHWjfn/9FBZ+H5VcEuwsyH8qeKS9Y1hYTXfNuQ1RLVlsDExggHa/RyLUwXh6?=
 =?us-ascii?Q?Me5vLyhSvwWhihyrx4Y2T0JD9AARFEUypCYqRSi0iPRHCmDKPLX4A6WiQN90?=
 =?us-ascii?Q?p1GvYxUe87eZmcvH1J2jDNz6Mqr9IPsOeFk3uF09/fNCYFDnns4RWE7A9ri0?=
 =?us-ascii?Q?TXr+wuqDzs1yggtt+XH7fzlu2iuoZMzVcQ1c9U7lkFPdeGkv09/skRQperAM?=
 =?us-ascii?Q?Yb+aaYGY9ct7YJ3X7h4jLk0LxADHBHDXWWmcFWrgtxsYjdvUSW1d9HjsoZfT?=
 =?us-ascii?Q?27Ja98aVGeo93iEc3R0B+hWjU0S3bBnasa7KElgNLRuTzLpER1CDKgMwGCaz?=
 =?us-ascii?Q?X8xe/pluRFj+WqvJxOdw8zZ+rJf6H+DoD4Qf0e8Hq+j44/bhPQqLH7RT2nHq?=
 =?us-ascii?Q?wguChAdhFWxtnwXktE0Vnz/iz5oC7xLvJ5jIYPzfHphCQMWyJDi65TeAgD+E?=
 =?us-ascii?Q?BJCLiWY9nquDqf90zOwJgOpBkStWipAHxuYRtKcPSIqLN9PsHYhnRsp4FQlr?=
 =?us-ascii?Q?CYv90scZZJlRWAdhv5DTsm2tRTvsBV7IwmlUU0YbPIT8dBS7Rw5pdHXwmMZb?=
 =?us-ascii?Q?013eR/r7gXp7mf3AjTHSvOBJMhR9vhxAwUSbD5ZfYSepPbFRPjKREAh4PERr?=
 =?us-ascii?Q?R49q8uPGOXjpK3QD61/Jb+OwAcL/sm7j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DzoAeYBV2DErUGHPdh7tqfNaYrhlKOWlr7S95iit6evyt9gHAAuDqLYhc+5n?=
 =?us-ascii?Q?XGezFeIuV5FGSR4zByXPcxD9VWHE9jlDe44rglyxwuqgOFggHxQrSoXSFvXz?=
 =?us-ascii?Q?EqHy8oK8sGwp0EBj2wYPVt2yrxDpSl+7LCCjWrCqPDCqCbq7cppP+X/5SGpg?=
 =?us-ascii?Q?l6qOKwslMHl1/INw7G4IS3wrxnxL/+CrF5LSzcYFotgUH4pDp/TUoLMfTvWc?=
 =?us-ascii?Q?ePXDKIPYh9yU5SMn02q/qsBF6Y15xYuI0I1uyff/iwxhvItJJT/F8ZTPmYLt?=
 =?us-ascii?Q?6tDucqvAHXZDJ78zj2sO4DQm7egcpARpZimdLQ0xKq8OokDD1UXf1ULqah2h?=
 =?us-ascii?Q?//oMVYt8KE7oIP60/AHqZu1o7X8NBxFnSJBGbj2i50raX2q8ihQ6OkfIjTPy?=
 =?us-ascii?Q?jPXY+ATUsHMsd/ZtsEOj45fICFh/IzVf2ZWTovKrmaJLDp7We/uIIo7Iscwv?=
 =?us-ascii?Q?BWq/ioFhxd7p+rrT6iZUm+SZWFcTnNTuSNbOweeBuPVB6P2jX88YH3iTO7LD?=
 =?us-ascii?Q?oOJJPXTSFZFr8Nt+jx+r2ff8oKJUJQJNdJJbuyfr/FfyyMGCQINq7SRRWAUc?=
 =?us-ascii?Q?uMupTL//kSm2NP6jBLPVmrAfGxjh9K8xm4+03lJQ4um15Paoyb6fRDUtHQA5?=
 =?us-ascii?Q?eC6ZsRt5KzqgHFpnPKCyhiPJTbi7z1UMzGP+uINCtzVDXAI+JN4jiPEmLUP8?=
 =?us-ascii?Q?QRceuy5shpuZcbsg1XvUGiXSUC0RseXqkvi56vIN1yJYBPEXpmD4fYOFGm9x?=
 =?us-ascii?Q?bFZn+x/AiwlF1t7pzzugkIDrRzglsmfwPJ5beoFsklO4oeuOJ5m2OHNpGqW+?=
 =?us-ascii?Q?o+G3jyDS/W7+e2R0ieyfL30bcEyshnBvA7zfFzu9ZUMcYLbQtC66RCvV+83J?=
 =?us-ascii?Q?HHFbZtAHshz75dClXgeXFwiDngfi802FdkTR91YNLCfMYc9aP0okQfNUUS5I?=
 =?us-ascii?Q?NOjW7HUrW0TKeHegtQFwPX5owgPr8I8XsbSIz8DxP555tNoMShMgl93/mjO2?=
 =?us-ascii?Q?frWxpA2TPm4jjHk1sYjCs55uLDwjWhZ0q5k+5nWaV3XqKdb06aB5HLW2Bqka?=
 =?us-ascii?Q?p0/zdBw9AHY2r4AF5GY9nQyc4mbGejM/dd47PBIKTIet6QqOm8tEd1sQ6rXT?=
 =?us-ascii?Q?RN8VBnySxl2fVtg8WUDSVEBNBQKAb95IWJ1GLKlKK5ByoR4CUF7jxneI7Tw3?=
 =?us-ascii?Q?5gBbYsItHn3lboyCkvnzj9LgrgDu1sM431T4OKtcsx+Weg7vSXsNnZV6h0Yf?=
 =?us-ascii?Q?ERxOiWPOOpTs/pvhcHOddqBaUJU/BRATSi7Vj/CFL85ewS5bfwkQzdCANaoo?=
 =?us-ascii?Q?nyQM6zSM0x6GWPtpl8vIX6Dy2VqEZj0aOi8gLc8t4AmtoeTiCRfnz3gHc6GH?=
 =?us-ascii?Q?SWeAhhu72XYOXMlG7sKAFC8mFLrlfkKafJwjiy5Mcm1R+tHdsWFaNB9JhWxN?=
 =?us-ascii?Q?YnhDGq+XXsV/kVvANqOB9FgnC9EC8ec6NNItWdxcQk8JjKuU34+JSCwFQHCx?=
 =?us-ascii?Q?QLIejxCgbOx82QWr7n0K8QPcn/RnR7LCkI0XPPjw5Sf4V7VGuMzGfFnX3vFS?=
 =?us-ascii?Q?1QekkujY3qbFXcbc71Kj9czi4l4r5dHRNLd+ZlrA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe707b1-aae1-43b6-acba-08dd50362241
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:05:59.1794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8Erxub9cmOuayKMZ1UyC0y9sAyjVO0g8MJMryTTdR7OwVVaC9XgaauNtLOV7Jp+TB3+WsSHh+7JoncE++VN7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8259

On Mon, Feb 17, 2025 at 11:57:15AM -0500, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> The AUDIOMIX clock provider takes an additional clock: AUDIO_AXI_CLK_ROOT.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx8mp-audiomix.yaml     | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> index 6588a17a7d9a..0272c9527037 100644
> --- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> @@ -24,8 +24,8 @@ properties:
>      maxItems: 1
>
>    clocks:
> -    minItems: 7
> -    maxItems: 7
> +    minItems: 8
> +    maxItems: 8

Are you sure clock axi is mandatory or optional clock?

If it is mandatory, you need update dts also, otherwise, there will many
DTB_CHECK warning.

If it is optional, minItems should be 7.

Please run CEHCK_DTB for arm64/dts/boot/freescale, make sure no new warning
added.

Frank
>
>    clock-names:
>      items:
> @@ -36,6 +36,7 @@ properties:
>        - const: sai5
>        - const: sai6
>        - const: sai7
> +      - const: axi
>
>    '#clock-cells':
>      const: 1
> @@ -72,10 +73,11 @@ examples:
>                   <&clk IMX8MP_CLK_SAI3>,
>                   <&clk IMX8MP_CLK_SAI5>,
>                   <&clk IMX8MP_CLK_SAI6>,
> -                 <&clk IMX8MP_CLK_SAI7>;
> +                 <&clk IMX8MP_CLK_SAI7>,
> +                 <&clk IMX8MP_CLK_AUDIO_AXI_ROOT>;
>          clock-names = "ahb",
>                        "sai1", "sai2", "sai3",
> -                      "sai5", "sai6", "sai7";
> +                      "sai5", "sai6", "sai7", "axi";
>          power-domains = <&pgc_audio>;
>      };
>
> --
> 2.34.1
>

