Return-Path: <linux-kernel+bounces-443285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD569EEA60
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB616281029
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005A9216E3B;
	Thu, 12 Dec 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aXA7gJoN"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A9E21504F;
	Thu, 12 Dec 2024 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016405; cv=fail; b=aHGfivbPPJP1TDag6gm5Ac9xBwAM8rZLUc3aK3K5EPR9YnB162LlFRxpK+tSFoe+KtreAwnKWa5D5Asj0AqvSI/1U2FpG7jjHX5k/iRiGYJVlKOcJMN90wKoWSpEPWOpUiyYG83t7TQVZhtyERCyApoc+LKUvGQc+WZ3DPUl/6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016405; c=relaxed/simple;
	bh=aNSYouFfzw07eo8AmonaEPXC/UW40pE1CAF/7fvpZng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S14Gqg+KhEjJ2shYlMTvpiFDKfOF0elrpOHf9C+UhIA7QjsV0M3jQbVH+lhL+s8lENYbYFfpksDumvCxhfb8XiPM9bjajBcfuf/OIlFaN3JOBFrgRSzgxHRn8FYzgSC4qs1C2R/27vyuBVkWNiBYgMbL1KZvYKXZX9K6RK5Sbcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aXA7gJoN; arc=fail smtp.client-ip=40.107.22.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfWTocN0Bwo6Xii+3Iwou89aGh2X0g35ZN691gArdCCMq4OumsDnYVQEttcsyWs1M0TJJeSwcS19+r7lSGKz4Yxfnax2VFDCK75Vrp7NH2F3hnbksBShXa/DXpkJk7fqOJzWCevu7P7IOt+wuTQCWob/jsH0A1E5+9pJ3wLLeLUhvdnu+aFK05Hg2JlHmBCpVnksOhQfbgfclJKlaDJGAcFpCaFIkv88P4L5VhG2eqC4LLgWZFpMGqZYCL69Di7KRw0I+IgBRT5QLV5KXZzx4uVrvrwq+c9k7sNkwmM3Q7ccrvo0zlFoNpcUchE7m7N6LHjj6DFoOBKW0XzOBJ1l/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwP7vlgMqGUSE3r8sswYfJiHU3LZDOi2Y19wW0vMWhI=;
 b=IsuespZWpvj0hX2JQkpEiJXh8N2pch5qQpRzsxKfanALCXt6rVaByjWHRrYeQAZb4ePm6x6UkGM+l/0738W4B61eCAD0DVCRor6DfAf3AB/bfsdP2EZ9cz+PycJ2zqO4iWSP6ftIZJu5T7xImy5lsFTrtyKNwIWpP4u6InHae7KuntSWikSGdCBuLvTUdkeo9PKvla5UCqRNsdsXFcDrCdMefzmEkLY4aX9kIPIOyCaaebyPukvSK576MSffecKWQ4s54vIfOquyaR0vynbi8elh7aSi+Kkru8UuSotGTPFt07rnZhxIj0aNzyTccW846bht7c7ssX8EuyTehUNywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwP7vlgMqGUSE3r8sswYfJiHU3LZDOi2Y19wW0vMWhI=;
 b=aXA7gJoNNSpC605S3Z5SPxnCq6b5gFcLmqooVnFD0u+QqXLGw30L/w+mmUjpR9oVCskU+vVVMa73AjtWaVY6SnTzEmJgYTmD2m8WnXaB6MQbOEE1vKiVgOf002cMuk2Odp/2NpR/LrlavS1cxDRVI+uEEJLMq0/d68kv6UqhULBqjjzUxbA4AE+8/DIWLlnIOdSl1v2u9uURZLWjYZvN/q0BF4tN4NC3mA7X7lZ0qPPwFYYe6+SMGcJc5IY1aocIwcWzXEkelz4itbsOEBT/d5Q/gs9SVV1VyWIkUHu5e0eDMq+rX9Igob3VuqtuR6Zkt/kQpUlRw7PDZQ1ISLATUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8728.eurprd04.prod.outlook.com (2603:10a6:10:2df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 15:13:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Thu, 12 Dec 2024
 15:13:17 +0000
Date: Thu, 12 Dec 2024 10:13:09 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] ASoC: SOF: imx: add driver for imx95
Message-ID: <Z1r9hWH1ioR5vI5H@lizhi-Precision-Tower-5810>
References: <20241113195240.3699-1-laurentiumihalcea111@gmail.com>
 <20241113195240.3699-5-laurentiumihalcea111@gmail.com>
 <ZzUJQCeWclsrr/lr@lizhi-Precision-Tower-5810>
 <c47710a5-7e53-48b1-bd6b-c0123865aee5@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c47710a5-7e53-48b1-bd6b-c0123865aee5@gmail.com>
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fed8022-547d-4799-ed68-08dd1abf81d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VyIGSV2jhYzpQMfzEcDGJIB5gWmsCpwZF2gGoB8Y2jiM95ePJHvEqOpYQD0+?=
 =?us-ascii?Q?5fzmGaQUW/TroboNpB3+FHfflEvQ5+sUKY11L8ZXi2P5q4RcoLFBtnyRlRKP?=
 =?us-ascii?Q?tP00LCClC1O//qtPwQSC8ex63NG2R1LPOdaQa3Wt2u5Nj3+7fAgIRfkJH4op?=
 =?us-ascii?Q?2n9RpZYDTBmg0gmG8YCvl71ueeNc8av1csqJUhqA6tUWW0Bnwj6InwVxbc+m?=
 =?us-ascii?Q?EFNvy1r9ww3LMsHTha1PMnMpOte4pi42kJfVZG8XI8cO9y+UcV4lq2KY+XQ7?=
 =?us-ascii?Q?/VCjCKBWFuj1mpSLFM/dGSRzMRNEHxtEGctLlEAHDZI4P7h3Lv622VORYTm5?=
 =?us-ascii?Q?M0U72Uh+cmSkaZNqLy5rU634hYeUEIvGqSbN+X89kZDx20Drz9wqOt9oVsOJ?=
 =?us-ascii?Q?PQ+ZnnwuZFE/wSBqC3yHWrTpBmAQhRQSFisUHu+439GNxOcJD5DFg0P869Py?=
 =?us-ascii?Q?kNYpwTjbFpzHamoe2P8dZeOIOvW5zTwIGvVAOtDgdxB5eoMFSNi3/4J+X/fc?=
 =?us-ascii?Q?Oov8ah7fJhfj9W76dJ6fS6EFUEbJxh6xftAcCG6gskT4ZzzcE1UQqq7MA/nC?=
 =?us-ascii?Q?AizcEoKT7vsDZN70iHaiPWIIs6xAm+/Uwn+280ICpYCkFVDhnxFhciu8RQiS?=
 =?us-ascii?Q?D10ef1j47pOCs7iIgAIBD/Ytnq3n0mGCrlsDTLr94CIcDFDDLgofmn2XcL5b?=
 =?us-ascii?Q?BR3eYo3jxFVfnmmt6yZzXOv1l0JmZP99B76cF+U7Rrb8BY1yZAzxFZrRdRe0?=
 =?us-ascii?Q?M9wDfju7CsTAaG9rP70vS5Jg8/oxfuKA/nOuUju0QAnMMNLEVNTqtDvougFw?=
 =?us-ascii?Q?7VCdOZvdoxv8mM3j0gA3XeF4COfjU8Wn2mfjAyRNIkbJicIHmrv87JmL+ac5?=
 =?us-ascii?Q?wSpZ8iUsYFX+4LVn9OTvxPQvlwfCOXdDrWs2dOw0j39JOu7n/ieB25RORP/5?=
 =?us-ascii?Q?I0k6KtZ+JsWdcyLN+Fp7e6Fxq31NAEqXtRwrmy445BHAkP2lcgM64as4wAfo?=
 =?us-ascii?Q?eZkNt2/sLiYlnqRPDmi81rQEfhjQT5VfbUfiyqojXJr3mv/sgHVExmjF/OD3?=
 =?us-ascii?Q?5ndeGPRNNA0+9IVfKu4DjHpkRQZd1fsosEIphjaVL5z0I/GsF/gdnqZ08TIV?=
 =?us-ascii?Q?TFQGGqEQuj6N+4BPNIEu8sVpgd4AcjhfotTwyyDK/ZB1BOy/msog3UPUm7ln?=
 =?us-ascii?Q?aLjtm87L5FTo0vbeE7GMsQAxMl2ea6yjsjV/i4xUTyMHZWh0VUmBU1qcikps?=
 =?us-ascii?Q?rZxQcCVBgbfcF1ZHcTWKGfwYcMsd6OBgiCwZhQkjhXhEwdv+cDi3PHqsLPvQ?=
 =?us-ascii?Q?S88/IxbP8zn8x2kg0cYnXBYaDzDdHnh+ut7/SYE18PonT3nUeaPpsihvj3dk?=
 =?us-ascii?Q?mFF/iv3LagPCwZoWgRO9mhvq1M/SXzjWPjgkyzpjrSvgUrG+RA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uAkL7slnpKlpgcv6gGGqvzQjNWE46pSbSINktIVtWSy2O3P0XZdsrNNZsdrQ?=
 =?us-ascii?Q?RtGNPb27phozzCHbUFTASuFa74/hOlbl0iakJI06BKQBEI/j5s8HAN9/19kA?=
 =?us-ascii?Q?WnXanyJj+NkXFXQf8rDVbpfkjYutwDyWv6zyntTFwYVESd3/a7UhST306jEG?=
 =?us-ascii?Q?5uU/32qKZWh3F8VOUMUvVd0Alqc1BNVwSUCitwstZZLUq14D0KpbDEoHmWGO?=
 =?us-ascii?Q?ZKG87s+WxrmwP2OZxNiMzTKL22eTkVyb9bZeb4nGZ3+6l79AFbFJGmowRVq0?=
 =?us-ascii?Q?b12myAfrxNbTrx3us4zLgmCczzkjEaJ7/aA3TlL2XEYiUwouVulBJyVKnd7A?=
 =?us-ascii?Q?6rBLq+5XeE5f2p+8Co+OApuRa8vDvs8je8eALFQS/zKK2NpJVIBP5bWeYqZh?=
 =?us-ascii?Q?Fx30gDpDju3I8sVl6LLAdNP0xaL8bjl1wJ6o+J7X68HG7Rggy3mCw7D1FjMN?=
 =?us-ascii?Q?9o5ryFqfEk12B6t2rQ/CDgajyza4oetxb30iAoVVJFKFhkaGuq8NtIK8mR1H?=
 =?us-ascii?Q?2ADoFzYvy9HddXDG02Lox0GqJx/dJvXmsN1mG5C2mBlth8/tuBMVFE5LyogK?=
 =?us-ascii?Q?TsiaTzN5imm5I3Aa5gEGbJGM72v3BJbKpFvDNZp3SVOih5OAwpkKbDLFn+Rp?=
 =?us-ascii?Q?E4msFkeIz7FGyeqJ7N+ZvpakmLiO15jv7QIfJOq/GNUZe6MXtSnaRnWJGh3k?=
 =?us-ascii?Q?0N0GXADsN2+0vmS9/UF6t/i1vXYKR4F9J7LBM4EYS5y2C8cKWOqvPe7E2/sA?=
 =?us-ascii?Q?GprhkArzCW4eXQdhBPqwk38v3gQbgAD2Y8LoGmtA57zmEQj9hCPX59gCzakb?=
 =?us-ascii?Q?6bSkht0xB/RtbwHOWsHNwtBW98CVfwLWxDCSd38O02gkJSAreUz44tAb6N8/?=
 =?us-ascii?Q?QV8YTmXV1haDzBVFWFHwetF01Uu1PJF60N1nG4QZYlWMgCnMFIvaUwfGa+L+?=
 =?us-ascii?Q?GdZFpIhZNF4XA3AfCM6SchxelcM19NSE8gsAj38/An3KeLm4OJGAsqynCxhp?=
 =?us-ascii?Q?AJKri/+048RfmXtZkh0ADzEhhcRh52RKFEWmhpHpzh2Njz4XYpg2IxH5t7gj?=
 =?us-ascii?Q?xEaS5YZ8d3Aj77GjouCgh0g/Q3xTInrujrVhsdyY4yj9HCrecuKh45XmWrc6?=
 =?us-ascii?Q?wb+eawUEkBbk22VUAli1yph6OeHoXCuhdRVf8Qfg9BTN9Umlm1F7Cay+Kgtg?=
 =?us-ascii?Q?/MUKyLoeQixow+6iPdS24vMPWVjI8XL5Y3Q1sbJsyj+310kld4silDQl4Czt?=
 =?us-ascii?Q?oLBN5rvbA04ab5ZYOmgcIu1xEoFtxsGyWEWFpxhREVkYWF1Y+RtRMMrdrRZW?=
 =?us-ascii?Q?KL4Djpp8sUV2fmRwfZXyN80vZ5X8Wo3yW3ooQP6m/yV/tERsRJGkWlFSY6d/?=
 =?us-ascii?Q?6P8u4yOveUwzmFJYkTMLp4t6JbiEaeV5B8Zafazp1KR0iM77n1H6Hh2u5iDS?=
 =?us-ascii?Q?aXUmQhGZ7ZxjTOeVXNxdDdpTaQV4PDW3JYKfOsCBf0VUVr5Lzs2HZ9El4KKp?=
 =?us-ascii?Q?jXA/Qkn2o5YnMFf+bKWASkwn02N64apFlRlvemvU9oLQxLTPJi6fzWnxDNK7?=
 =?us-ascii?Q?icQgJqCFaHk/maKEwOmPz/TEVyflmtZemdQh42Yr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fed8022-547d-4799-ed68-08dd1abf81d4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 15:13:17.7514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtA8YndMY5i36YN+dzmcAgeeZQIjEFl/vScxI6K7SmPQkWbxq9y8AZOp0aWRF/O1VcIUIHQboWgSc1KzhGnmUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8728

On Thu, Dec 12, 2024 at 01:11:29PM +0200, Laurentiu Mihalcea wrote:
>
>
> On 11/13/2024 10:17 PM, Frank Li wrote:
> > On Wed, Nov 13, 2024 at 02:52:39PM -0500, Laurentiu Mihalcea wrote:
> >> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >>
> >> Add SOF driver for imx95.
> >>
> >> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >> ---
> >>  sound/soc/sof/imx/Kconfig  |   8 +
> >>  sound/soc/sof/imx/Makefile |   2 +
> >>  sound/soc/sof/imx/imx95.c  | 401 +++++++++++++++++++++++++++++++++++++
> > why not reused exist one? look likes simular.
> >
> > Frank
> the SOF drivers do indeed have some similarities, but each of them has their own quirks which IMO makes it a bit harder to add the 95 support. We need to figure out the common parts and then move them to imx-common, but I believe this can be solved incrementally.

You should create common part firstly, then implement equal function with
existed part. Finially add imx95 part.

Frank

> >
> >>  3 files changed, 411 insertions(+)
> >>  create mode 100644 sound/soc/sof/imx/imx95.c
> >>
> >> diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
> >> index 4751b04d5e6f..51a70a193533 100644
> >> --- a/sound/soc/sof/imx/Kconfig
> >> +++ b/sound/soc/sof/imx/Kconfig
> >> @@ -50,4 +50,12 @@ config SND_SOC_SOF_IMX8ULP
> >>  	  Say Y if you have such a device.
> >>  	  If unsure select "N".
> >>
> >> +config SND_SOC_SOF_IMX95
> >> +	tristate "SOF support for i.MX95"
> >> +	depends on IMX_DSP
> >> +	help
> >> +	  This adds support for Sound Open Firmware for NXP i.MX95 platforms.
> >> +	  Say Y if you have such a device.
> >> +	  If unsure select "N".
> >> +
> >>  endif ## SND_SOC_SOF_IMX_TOPLEVEL
> >> diff --git a/sound/soc/sof/imx/Makefile b/sound/soc/sof/imx/Makefile
> >> index be0bf0736dfa..715ac3798668 100644
> >> --- a/sound/soc/sof/imx/Makefile
> >> +++ b/sound/soc/sof/imx/Makefile
> >> @@ -2,10 +2,12 @@
> >>  snd-sof-imx8-y := imx8.o
> >>  snd-sof-imx8m-y := imx8m.o
> >>  snd-sof-imx8ulp-y := imx8ulp.o
> >> +snd-sof-imx95-y := imx95.o
> >>
> >>  snd-sof-imx-common-y := imx-common.o
> >>
> >>  obj-$(CONFIG_SND_SOC_SOF_IMX8) += snd-sof-imx8.o
> >>  obj-$(CONFIG_SND_SOC_SOF_IMX8M) += snd-sof-imx8m.o
> >>  obj-$(CONFIG_SND_SOC_SOF_IMX8ULP) += snd-sof-imx8ulp.o
> >> +obj-$(CONFIG_SND_SOC_SOF_IMX95) += snd-sof-imx95.o
> >>  obj-$(CONFIG_SND_SOC_SOF_IMX_COMMON) += imx-common.o
> >> diff --git a/sound/soc/sof/imx/imx95.c b/sound/soc/sof/imx/imx95.c
> >> new file mode 100644
> >> index 000000000000..5a0e44f5bd48
> >> --- /dev/null
> >> +++ b/sound/soc/sof/imx/imx95.c
> >> @@ -0,0 +1,401 @@
> >> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> >> +/*
> >> + * Copyright 2024 NXP
> >> + */
> >> +
> >> +#include <linux/arm-smccc.h>
> >> +#include <linux/clk.h>
> >> +#include <linux/firmware/imx/dsp.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of_platform.h>
> >> +#include <linux/of_reserved_mem.h>
> >> +#include <sound/sof.h>
> >> +
> >> +#include "../sof-of-dev.h"
> >> +#include "../ops.h"
> >> +
> >> +#define IMX_SIP_SRC 0xC2000005
> >> +#define IMX_SIP_SRC_M_RESET_ADDR_SET 0x03
> >> +
> >> +#define IMX95_CPU_VEC_FLAGS_BOOT BIT(29)
> >> +
> >> +#define IMX_SIP_LMM 0xC200000F
> >> +#define IMX_SIP_LMM_BOOT 0x0
> >> +#define IMX_SIP_LMM_SHUTDOWN 0x1
> >> +
> >> +#define IMX95_M7_LM_ID 0x1
> >> +
> >> +#define MBOX_DSPBOX_OFFSET 0x1000
> >> +#define MBOX_WINDOW_OFFSET 0x6000000
> >> +
> >> +struct imx95_priv {
> >> +	struct platform_device *ipc_dev;
> >> +	struct imx_dsp_ipc *ipc_handle;
> >> +	resource_size_t bootaddr;
> >> +};
> >> +
> >> +static void imx95_ipc_handle_reply(struct imx_dsp_ipc *ipc)
> >> +{
> >> +	unsigned long flags;
> >> +	struct snd_sof_dev *sdev = imx_dsp_get_data(ipc);
> >> +
> >> +	spin_lock_irqsave(&sdev->ipc_lock, flags);
> >> +	snd_sof_ipc_process_reply(sdev, 0);
> >> +	spin_unlock_irqrestore(&sdev->ipc_lock, flags);
> >> +}
> >> +
> >> +static void imx95_ipc_handle_request(struct imx_dsp_ipc *ipc)
> >> +{
> >> +	snd_sof_ipc_msgs_rx(imx_dsp_get_data(ipc));
> >> +}
> >> +
> >> +static struct imx_dsp_ops ipc_ops = {
> >> +	.handle_reply = imx95_ipc_handle_reply,
> >> +	.handle_request = imx95_ipc_handle_request,
> >> +};
> >> +
> >> +static int imx95_disable_enable_core(bool enable)
> >> +{
> >> +	struct arm_smccc_res res;
> >> +
> >> +	if (enable)
> >> +		arm_smccc_smc(IMX_SIP_LMM, IMX_SIP_LMM_BOOT, IMX95_M7_LM_ID,
> >> +			      0, 0, 0, 0, 0, &res);
> >> +	else
> >> +		arm_smccc_smc(IMX_SIP_LMM, IMX_SIP_LMM_SHUTDOWN, IMX95_M7_LM_ID,
> >> +			      0, 0, 0, 0, 0, &res);
> >> +
> >> +	return res.a0;
> >> +}
> >> +
> >> +static int imx95_run(struct snd_sof_dev *sdev)
> >> +{
> >> +	return imx95_disable_enable_core(true);
> >> +}
> >> +
> >> +static int imx95_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
> >> +{
> >> +	struct imx95_priv *priv = sdev->pdata->hw_pdata;
> >> +
> >> +	sof_mailbox_write(sdev, sdev->host_box.offset,
> >> +			  msg->msg_data, msg->msg_size);
> >> +
> >> +	imx_dsp_ring_doorbell(priv->ipc_handle, 0);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int imx95_get_mailbox_offset(struct snd_sof_dev *sdev)
> >> +{
> >> +	return MBOX_DSPBOX_OFFSET + MBOX_WINDOW_OFFSET;
> >> +}
> >> +
> >> +static int imx95_get_bar_index(struct snd_sof_dev *sdev, u32 type)
> >> +{
> >> +	switch (type) {
> >> +	case SOF_FW_BLK_TYPE_SRAM:
> >> +		return type;
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +}
> >> +
> >> +static int imx95_get_window_offset(struct snd_sof_dev *sdev, u32 id)
> >> +{
> >> +	return MBOX_WINDOW_OFFSET;
> >> +}
> >> +
> >> +static int imx95_set_power_state(struct snd_sof_dev *sdev,
> >> +				 const struct sof_dsp_power_state *target_state)
> >> +{
> >> +	sdev->dsp_power_state = *target_state;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int imx95_suspend_resume(struct snd_sof_dev *sdev, bool suspend)
> >> +{
> >> +	struct imx95_priv *priv;
> >> +	int ret, i;
> >> +
> >> +	priv = sdev->pdata->hw_pdata;
> >> +
> >> +	if (suspend) {
> >> +		ret = imx95_disable_enable_core(false);
> >> +		if (ret) {
> >> +			dev_err(sdev->dev, "failed to stop core\n");
> >> +			return ret;
> >> +		}
> >> +	}
> >> +
> >> +	for (i = 0; i < DSP_MU_CHAN_NUM; i++) {
> >> +		if (suspend)
> >> +			imx_dsp_free_channel(priv->ipc_handle, i);
> >> +		else
> >> +			imx_dsp_request_channel(priv->ipc_handle, i);
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int imx95_runtime_resume(struct snd_sof_dev *sdev)
> >> +{
> >> +	int ret;
> >> +	const struct sof_dsp_power_state target_state = {
> >> +		.state = SOF_DSP_PM_D0,
> >> +	};
> >> +
> >> +	ret = imx95_suspend_resume(sdev, false);
> >> +	if (ret < 0) {
> >> +		dev_err(sdev->dev, "failed to runtime resume: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	return snd_sof_dsp_set_power_state(sdev, &target_state);
> >> +}
> >> +
> >> +static int imx95_resume(struct snd_sof_dev *sdev)
> >> +{
> >> +	int ret;
> >> +	const struct sof_dsp_power_state target_state = {
> >> +		.state = SOF_DSP_PM_D0,
> >> +	};
> >> +
> >> +	ret = imx95_suspend_resume(sdev, false);
> >> +	if (ret < 0) {
> >> +		dev_err(sdev->dev, "failed to resume: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	if (pm_runtime_suspended(sdev->dev)) {
> >> +		pm_runtime_disable(sdev->dev);
> >> +		pm_runtime_set_active(sdev->dev);
> >> +		pm_runtime_mark_last_busy(sdev->dev);
> >> +		pm_runtime_enable(sdev->dev);
> >> +		pm_runtime_idle(sdev->dev);
> >> +	}
> >> +
> >> +	return snd_sof_dsp_set_power_state(sdev, &target_state);
> >> +}
> >> +
> >> +static int imx95_runtime_suspend(struct snd_sof_dev *sdev)
> >> +{
> >> +	int ret;
> >> +	const struct sof_dsp_power_state target_state = {
> >> +		.state = SOF_DSP_PM_D3,
> >> +	};
> >> +
> >> +	ret = imx95_suspend_resume(sdev, true);
> >> +	if (ret < 0) {
> >> +		dev_err(sdev->dev, "failed to runtime suspend: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	return snd_sof_dsp_set_power_state(sdev, &target_state);
> >> +}
> >> +
> >> +static int imx95_suspend(struct snd_sof_dev *sdev, unsigned int target_state)
> >> +{
> >> +	int ret;
> >> +	const struct sof_dsp_power_state target_power_state = {
> >> +		.state = target_state,
> >> +	};
> >> +
> >> +	if (!pm_runtime_suspended(sdev->dev)) {
> >> +		ret = imx95_suspend_resume(sdev, true);
> >> +		if (ret < 0) {
> >> +			dev_err(sdev->dev, "failed to suspend: %d\n", ret);
> >> +			return ret;
> >> +		}
> >> +	}
> >> +
> >> +	return snd_sof_dsp_set_power_state(sdev, &target_power_state);
> >> +}
> >> +
> >> +static struct snd_soc_dai_driver imx95_dai[] = {
> >> +	{
> >> +		.name = "sai3",
> >> +		.playback = {
> >> +			.channels_min = 1,
> >> +			.channels_max = 32,
> >> +		},
> >> +		.capture = {
> >> +			.channels_min = 1,
> >> +			.channels_max = 32,
> >> +		},
> >> +	},
> >> +};
> >> +
> >> +static int imx95_probe(struct snd_sof_dev *sdev)
> >> +{
> >> +	struct platform_device *pdev;
> >> +	struct imx95_priv *priv;
> >> +	struct resource *res;
> >> +	struct arm_smccc_res smc_ret;
> >> +	int ret;
> >> +
> >> +	pdev = container_of(sdev->dev, struct platform_device, dev);
> >> +
> >> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> >> +	if (!priv)
> >> +		return dev_err_probe(&pdev->dev, -ENOMEM, "failed to alloc priv\n");
> >> +
> >> +	sdev->pdata->hw_pdata = priv;
> >> +
> >> +	/* map SRAM */
> >> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> +	if (!res)
> >> +		return dev_err_probe(&pdev->dev, -ENODEV,
> >> +				     "failed to fetch SRAM region\n");
> >> +
> >> +	sdev->bar[SOF_FW_BLK_TYPE_SRAM] = devm_ioremap(&pdev->dev, res->start,
> >> +						       resource_size(res));
> >> +	if (IS_ERR(sdev->bar[SOF_FW_BLK_TYPE_SRAM]))
> >> +		return dev_err_probe(&pdev->dev,
> >> +				     PTR_ERR(sdev->bar[SOF_FW_BLK_TYPE_SRAM]),
> >> +				     "failed to map SRAM region\n");
> >> +
> >> +	sdev->mmio_bar = SOF_FW_BLK_TYPE_SRAM;
> >> +	sdev->mailbox_bar = SOF_FW_BLK_TYPE_SRAM;
> >> +	sdev->dsp_box.offset = MBOX_DSPBOX_OFFSET + MBOX_WINDOW_OFFSET;
> >> +	priv->bootaddr = res->start;
> >> +
> >> +	ret = of_reserved_mem_device_init(sdev->dev);
> >> +	if (ret)
> >> +		return dev_err_probe(&pdev->dev, ret,
> >> +				     "failed to bind DMA region\n");
> >> +
> >> +	priv->ipc_dev = platform_device_register_data(&pdev->dev, "imx-dsp",
> >> +						      PLATFORM_DEVID_NONE,
> >> +						      pdev, sizeof(*pdev));
> >> +	if (IS_ERR(priv->ipc_dev))
> >> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->ipc_dev),
> >> +				     "failed to create IPC device\n");
> >> +
> >> +	priv->ipc_handle = dev_get_drvdata(&priv->ipc_dev->dev);
> >> +	if (!priv->ipc_handle) {
> >> +		ret = -EPROBE_DEFER;
> >> +		dev_err(&pdev->dev, "failed to fetch ipc handle\n");
> >> +		goto err_unregister_ipc_dev;
> >> +	}
> >> +
> >> +	priv->ipc_handle->ops = &ipc_ops;
> >> +	imx_dsp_set_data(priv->ipc_handle, sdev);
> >> +
> >> +	/* set core boot reset address */
> >> +	arm_smccc_smc(IMX_SIP_SRC, IMX_SIP_SRC_M_RESET_ADDR_SET, priv->bootaddr,
> >> +		      IMX95_CPU_VEC_FLAGS_BOOT, 0, 0, 0, 0, &smc_ret);
> >> +	if ((int)smc_ret.a0 < 0) {
> >> +		ret = smc_ret.a0;
> >> +		dev_err(&pdev->dev, "failed to set boot address: %d", ret);
> >> +		goto err_unregister_ipc_dev;
> >> +	}
> >> +
> >> +	return 0;
> >> +
> >> +err_unregister_ipc_dev:
> >> +	platform_device_unregister(priv->ipc_dev);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static void imx95_remove(struct snd_sof_dev *sdev)
> >> +{
> >> +	struct imx95_priv *priv;
> >> +
> >> +	priv = sdev->pdata->hw_pdata;
> >> +
> >> +	if (imx95_disable_enable_core(false))
> >> +		dev_err(sdev->dev, "failed to stop core\n");
> >> +
> >> +	platform_device_unregister(priv->ipc_dev);
> >> +}
> >> +
> >> +static const struct snd_sof_dsp_ops sof_imx95_ops = {
> >> +	.probe = imx95_probe,
> >> +	.remove = imx95_remove,
> >> +
> >> +	/* mandatory "DSP" ops */
> >> +	.run = imx95_run,
> >> +	.block_read = sof_block_read,
> >> +	.block_write = sof_block_write,
> >> +	.send_msg = imx95_send_msg,
> >> +	.load_firmware = snd_sof_load_firmware_memcpy,
> >> +	.ipc_msg_data = sof_ipc_msg_data,
> >> +
> >> +	.mailbox_read = sof_mailbox_read,
> >> +	.mailbox_write = sof_mailbox_write,
> >> +
> >> +	.get_mailbox_offset = imx95_get_mailbox_offset,
> >> +	.get_bar_index = imx95_get_bar_index,
> >> +	.get_window_offset = imx95_get_window_offset,
> >> +
> >> +	.pcm_open = sof_stream_pcm_open,
> >> +	.pcm_close = sof_stream_pcm_close,
> >> +	.set_stream_data_offset = sof_set_stream_data_offset,
> >> +
> >> +	.runtime_suspend = imx95_runtime_suspend,
> >> +	.runtime_resume = imx95_runtime_resume,
> >> +
> >> +	.resume = imx95_resume,
> >> +	.suspend = imx95_suspend,
> >> +
> >> +	.set_power_state = imx95_set_power_state,
> >> +
> >> +	.drv = imx95_dai,
> >> +	.num_drv = ARRAY_SIZE(imx95_dai),
> >> +
> >> +	.hw_info = SNDRV_PCM_INFO_MMAP |
> >> +		   SNDRV_PCM_INFO_MMAP_VALID |
> >> +		   SNDRV_PCM_INFO_INTERLEAVED |
> >> +		   SNDRV_PCM_INFO_PAUSE |
> >> +		   SNDRV_PCM_INFO_BATCH |
> >> +		   SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
> >> +};
> >> +
> >> +static struct snd_sof_of_mach sof_imx95_machs[] = {
> >> +	{
> >> +		.compatible = "fsl,imx95-19x19-evk",
> >> +		.sof_tplg_filename = "sof-imx95-wm8962.tplg",
> >> +		.drv_name = "asoc-audio-graph-card2",
> >> +	},
> >> +	{
> >> +	},
> >> +};
> >> +
> >> +static struct sof_dev_desc sof_of_imx95_desc = {
> >> +	.of_machines = sof_imx95_machs,
> >> +	.ipc_supported_mask = BIT(SOF_IPC_TYPE_3),
> >> +	.ipc_default = SOF_IPC_TYPE_3,
> >> +	.default_fw_path = {
> >> +		[SOF_IPC_TYPE_3] = "imx/sof",
> >> +	},
> >> +	.default_tplg_path = {
> >> +		[SOF_IPC_TYPE_3] = "imx/sof-tplg",
> >> +	},
> >> +	.default_fw_filename = {
> >> +		[SOF_IPC_TYPE_3] = "sof-imx95.ri",
> >> +	},
> >> +	.ops = &sof_imx95_ops,
> >> +};
> >> +
> >> +static const struct of_device_id sof_of_imx95_ids[] = {
> >> +	{ .compatible = "fsl,imx95-cm7-sof", .data = &sof_of_imx95_desc },
> >> +	{ },
> >> +};
> >> +MODULE_DEVICE_TABLE(of, sof_of_imx95_ids);
> >> +
> >> +static struct platform_driver snd_sof_of_imx95_driver = {
> >> +	.probe = sof_of_probe,
> >> +	.remove = sof_of_remove,
> >> +	.driver = {
> >> +		.name = "sof-audio-of-imx95",
> >> +		.pm = &sof_of_pm,
> >> +		.of_match_table = sof_of_imx95_ids,
> >> +	},
> >> +};
> >> +module_platform_driver(snd_sof_of_imx95_driver);
> >> +
> >> +MODULE_LICENSE("Dual BSD/GPL");
> >> +MODULE_DESCRIPTION("SOF support for i.MX95 platforms");
> >> +MODULE_AUTHOR("Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>");
> >> --
> >> 2.34.1
> >>
>

