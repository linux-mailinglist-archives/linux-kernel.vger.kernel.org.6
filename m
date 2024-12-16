Return-Path: <linux-kernel+bounces-447754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF699F36B8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F118188FBC2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF442066CE;
	Mon, 16 Dec 2024 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RjUV1aPu"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387C8200BB4;
	Mon, 16 Dec 2024 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367751; cv=fail; b=GWKAhbB8CjToCvO9/TesRJAwl+cnxMnlGKDpVMMGjXRy2jsjYb65p3izCp7r+iaqjT33cMQMquDoaCt1By6rR17DC8Gg4VGGuym7IJEf+69zsOeKBvTZ1QdFkIXIJMu2/LcsLvGwWeu/3ijfPB4P94DRDhfYjn/0gkyxWGKlwUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367751; c=relaxed/simple;
	bh=FqYxMyLQPHmqiYjJkVWIHK2PkgR4FLfq/UjZeyqKOuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EIYCc2JWweM+l87T44v+C93LnosmATkXqsgiAB4wslb8ENV3osAoHxadO2NopYvYIF3We3s7ZDDlnVf0SYrc3zBmujgjJY456paCILp75g4bpPHi/vFMRUSe7PjvINQXjRbV10NQk8DcBVuHFjbOcfvnSBb6oMU8OwTFoAoviTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RjUV1aPu; arc=fail smtp.client-ip=52.101.69.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srvwy2+lcbliOsv7u+G+EKpDHQNZrInpODWM3hkZ1hG9bApMk7UG5DslaQw0cjmJNUR3d67pRAX5z1wSRnLM+lhNlSxZsjIxNmZon3L0JCvJkN58IS5j0e6lG8ajTb/7fLkNxd0RI7DGiAGGKe9wQBIitQ0fMyPclwrF09UflMdgXIyhcrmTxIF9LJr5HYCNI8zic8bWkeQLV6A9GD33VhYKeMzgL8SeTBnf9CzDXIhzK2jR3072QI2aevdU/0G8UgB7jKMa+/SD8QoGx+3YHxLCqQyT8Qbse0m9F6ApNeCCc7Y1ubIxFi7i0kh1VsRr8uC5bKwMJOOdwNo4Jhg3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HgoCuy2agtPfX0MqdS91ayxtzRPRKXnqXwvKH4IWX0=;
 b=srr2X2lI+f1hYJM0t4SKnYTC3EfpWLVViJwhszF2hsYh5xEIQPwbLEGLpJL2mQeA/Zsz7QWY0vabaBJOhtOLEZqr9dvSVYLnyydeuAiJ0NJ9M6OJtaVgo3GDDWDe5oju8V1Hh00anb2Pp1OIy5TsmPvbEAmG4HgZ7cb7u3VMB6IBhEtpsK3vNNyfZ2J2+wX3W8/ftTu/DQCs2a5gfpHWqQAv6ehKat3lJOWB56Mq8qGBEqHIDxQUzki135OZtAqoFVJx9aP6NLyAJKo1dAoWInRXe+/T9oMOkcbJTgSKskofrkFDphk9BTcfHUm5O1OfkXVDGmVPSgwF/d2GvrsYEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HgoCuy2agtPfX0MqdS91ayxtzRPRKXnqXwvKH4IWX0=;
 b=RjUV1aPu+ie5L4nMRJ1E6jGpYeCLHdzjAg3x7AgPwnH5Vh5GE4c6Lyiqq+YryWZGxk+iPmCm694xlPIbdUQj/Ece1a+Gz9gQXcZrfQQ7vYxPAFzmkvbvZU1YjbTsmxISlLoQFxHpHdrMWENdxzAnKlevVexCE6tBc0JToE89me54Ue5wwggoOA0oT2TnfGrG5Le37UcnYlVnim4w31lPaDfDzoHh92ju4og58GT0SkiX4IB/fUht6J9jOs/H2pea+KtQdOGhkcfFEX8Ll25kcA/JW7iWzht4+uthS6c68Fp/YUISsSE9xNBkAwh5OYmsjCHcPCLHOWf+Cil6N4T5lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10625.eurprd04.prod.outlook.com (2603:10a6:102:48a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:49:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Mon, 16 Dec 2024
 16:49:05 +0000
Date: Mon, 16 Dec 2024 11:48:57 -0500
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
Subject: Re: [PATCH v3 4/5] ASoC: SOF: imx: add driver for imx95
Message-ID: <Z2BZ+WUY6ecIwhEt@lizhi-Precision-Tower-5810>
References: <20241216145039.3074-1-laurentiumihalcea111@gmail.com>
 <20241216145039.3074-5-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216145039.3074-5-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10625:EE_
X-MS-Office365-Filtering-Correlation-Id: d58dddb5-2abf-460a-b1a0-08dd1df18d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TF7S/Ych+EQ3Zk6+XDy3Nc81Hfsuvl0HPq1dHTsAE8dltqW45bQpGWmSTNTD?=
 =?us-ascii?Q?F8Pust/SjO7/hVsBwLBYnzGcsrbVFtzx/WxQQj/z9qo4JLX2J8CW3bgF6X8G?=
 =?us-ascii?Q?9CnV4oeZOcT5gfy5XYbKYcuxSAF+2Pbjaw8A/pJPVTQYlu8zAb/yGoLJZPWl?=
 =?us-ascii?Q?RHabgjCMmyevCbYZFeOZaCz5NV/1MLUKR1oJS+3lj/xx7waks5rI6G4Y1sqW?=
 =?us-ascii?Q?AXUtdPO0AhHzRgQn4oC47+2iYWlhjdUX8JKhQRO5r40c5YUUX5UcrdMolfz1?=
 =?us-ascii?Q?AO3bdkBxwKDwt4Picfbtf9B8SWFwfGvrSXZLnicEApjK9R2tHinpYJBhUMGd?=
 =?us-ascii?Q?IgVFowxx9K9lYn7yUcoiwEnF8adxIRA79eZIgiQ3SxJOq8IkYjNtkGd6Yqve?=
 =?us-ascii?Q?8X3jW7f54pKdn+V9fwUGoAHVy9VHbuMZIcQNl8JBAeiTGhvGCm2yw2qUgV0L?=
 =?us-ascii?Q?OkZFX+uRvKbREK8SlOhb3EZUMQygxXgcyAbz1SJiZp3tVMKxv+KBTidSIl9z?=
 =?us-ascii?Q?YjYXO1wAFmWiMbUB4agNlwUC6IuR0q4tpsuYXbO9o08XjcIly947yWWk6+5M?=
 =?us-ascii?Q?rcRxq1cCWPHiq2PEsmrBhvpXvMX33/9S+BGfvd3KCdLQLSJL2872kt61tCBn?=
 =?us-ascii?Q?VNptv3/8gVIS95xARNGeiXNxSNWbjcGP03uwxOAozqzJhZ4wDSxGT3e9H51d?=
 =?us-ascii?Q?jLUQ960pWgiA5z7O1e+Q3uggrqVfNbETicMQH4E/hcsa/c/uOUSRdJIBT9JG?=
 =?us-ascii?Q?wSJnnVRwZfz3UFICDSx64M7JXl1TmRrFx1Ke2Nj5y5PUIzLhztVx3jivGdzz?=
 =?us-ascii?Q?w0Z5qzYmm31OeARc9HJZiarw6kNLRpgWhtNcogJOBxYn0iVDTEmSZ8RLFmIr?=
 =?us-ascii?Q?ap3W59S0KjauL9VcL6gsyCbgY9vWhCzunE1SYZ9q5qTSG12iQNzx0S3DCSVa?=
 =?us-ascii?Q?wcHAHFQpKYQz1RQDFs6gR70F1Q6IE2Pv3KD6ZJX5LJV/V2KfDyMoX1nMlHdj?=
 =?us-ascii?Q?7Qy+Q/Lm3ITT36JjGy1ubGzkvu7KABQL08jYyPkRoWXkSIjfbPZWAsiScjHi?=
 =?us-ascii?Q?aVTRdIOCNAIUYNI97ki1OphjzJuFwfZKXgSB4wWvwyKNDPtZqTLvWXkz2Fzy?=
 =?us-ascii?Q?DLS4S3Gh5cfkaXB8dOmOHfXvI+Qbrfqs7yyvOKec5DAPsrH81ZvWiEn2d/JU?=
 =?us-ascii?Q?7K0a8ENdBz8S5hTqTtgnKsyBlvuxkgxj+RyP3mbd5nP16/7H3d/cJBKXd6sQ?=
 =?us-ascii?Q?yx4CUmw1OkUSVubhNHtoT/c+1X0rlP/+d5/JyxfDZaRoQ1fXnJQbGzTOgjLx?=
 =?us-ascii?Q?gD8BBtMAn5egXnDzqGvstgBs7CVQyFmSClNziuVll7wieQpcqN/LffysdTYP?=
 =?us-ascii?Q?5RiJyr15ScP4g9O3CQedb3FLnPZlOoc5MjxyfaCXIDttLHFnlq0xVVIykUBx?=
 =?us-ascii?Q?uilx/7xu5QbVEin4vt833tWSl2pJBhTS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ioW/xapzpMgCqKt8p4ecnyCj1i219yI7y0ad4qwk4zScSqQxigcOruoNmnyd?=
 =?us-ascii?Q?gL3aWNM7WlRGNZFRkIz7/htJOeSF+knooK6eHmCAmk5CULYKdVMItBK9fe/o?=
 =?us-ascii?Q?0ubnjcVAlsjluTdiB8wiGuALCOafNXWTGeIOq8Cok/UwbDdVsz9oN7ZhF45o?=
 =?us-ascii?Q?Mu4E8J0MMZkS4/d8hA7rlH4iQ6fP3CZ5wQALIypw3adxUynvoN0es9ziJdoX?=
 =?us-ascii?Q?PEqdFyPuwP58rWHv82kpkOG3IkE27DTOHkDM2xFWbNmEMa5RquRQNxCfAV+y?=
 =?us-ascii?Q?DbuajUbiRYFkcqDfWpr2lT9/8zE6S58GGZRgI0L3lTiOTHcNWqS9cTX6Cu5t?=
 =?us-ascii?Q?3q52XrVzSJxZhI6uwxeE1qFsmm1aovNxcb7+vNMNtfqDGNFEkRZwMuULyfhA?=
 =?us-ascii?Q?b5p9sT5ft+CeMvzPrsB5dkAQ8Ed/5W7Fw+6zhoT+zNNWhadqN6NvTgvuu/AS?=
 =?us-ascii?Q?tAmJOVEsVWIcGh7gEzYs9URfrqhz88/siZ+ajV8ahty+6FJnK9+eVhMX5y4T?=
 =?us-ascii?Q?CGNGHHp3Kjsc3hJkmwOk+axhXeiJhb1WdiNg5laCUihVtFLf5oWS8u33a1Vn?=
 =?us-ascii?Q?rMWe5QYMCJxhuA/zwJM/oq5NK29yoyzPuJF7l1pEn++/pl1Jq8w1IkDXGRvW?=
 =?us-ascii?Q?JkcXmjnDXHhI0kPrxDSPh+HX277wSNpX5cmeFWCMot4wZFkXYhVuTWfBUKM7?=
 =?us-ascii?Q?ezhW6rHaWNvQbaktea2ytq8kaWwGlA145VgvUWbwNRjeOhsn5vdc0tLES+Hn?=
 =?us-ascii?Q?qTPlRBMHNqTQ0VzA3Jm5o5M3DFk/ot3BB/+y7ItmRWD9XwOl3weP2KgySQQp?=
 =?us-ascii?Q?VSPvyK2UhxV3BYay/0k1UdAYXYrlfdD/yJJf0lpu/EFKKp5oXoGOUx1ObBBr?=
 =?us-ascii?Q?LQAb4qNUQOkGbWodVRD/uGp1YFCd4oGv2OANdy0JSODGBO9i0P6ZV7hwXEiu?=
 =?us-ascii?Q?Utvm33wSBmORI9POxDWsdVaZ6K5c90lWy3RfyvnEeutdo9ArAz3rNdmLWivP?=
 =?us-ascii?Q?iEAUjjGFE2NO/csKlK3UP+u0BBosO6J53fbFGhL5Oy/4yGz/grwis3+wk0EB?=
 =?us-ascii?Q?LcbK03KERu7KbwVYA2WJvTM2k+YA2NNlQedU2XpJzd6PkYD8hYw1PAocl1gu?=
 =?us-ascii?Q?Pptc6pUyNb6OrcgnyxW18niVEdQlEZbBJBUkyTAdPdLRaFMw7tB+mLeweESq?=
 =?us-ascii?Q?JEq8iCRbdop6PCRcIA1/XP9hKD0RRYNjjT0T+McP3pt17+DqmnuowwyBPvNW?=
 =?us-ascii?Q?7OwtAE5HKvycdzbBgbzQayZP+y9gPbKhHPQVpaF0UMUiqDOlEurj9MhdY2Mc?=
 =?us-ascii?Q?AfxaXXTQv787cBTN96f3cPe+ad69xqpxBqh/NU1VOQNhhAi/bPiR0XHJvCeK?=
 =?us-ascii?Q?wZ3cfqUpPJQ/66CHQq4AWjMKblA+UbivlKyZE+F5y2xfolKBS4WqqWbDX6ve?=
 =?us-ascii?Q?HzYc0SPuHA8JWowWV7JreEMrN5C//4UTHwFb0pDco54n+L6pHHkml9DEuWwo?=
 =?us-ascii?Q?gh/8KjklnhPwwbYZ4U7zkHi00VcEXrJltSCHHtmSxdFrmgndJ4YFwcn2QoZ4?=
 =?us-ascii?Q?7m5KMxAX19MiIsoOHwtGsTme/ONBvoomiSfxvruZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58dddb5-2abf-460a-b1a0-08dd1df18d65
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:49:05.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhugRBNatlOFyCJlr4tZqTfbkM7WMoFQzz3XBXEjzU4lWOpVFUJunmtHHruiai92S9rLUi0LqQ5B5eKhcXnUng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10625

On Mon, Dec 16, 2024 at 09:50:38AM -0500, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Add SOF driver for imx95.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  sound/soc/sof/imx/Kconfig  |   8 +
>  sound/soc/sof/imx/Makefile |   2 +
>  sound/soc/sof/imx/imx95.c  | 401 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 411 insertions(+)
>  create mode 100644 sound/soc/sof/imx/imx95.c
>
> diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
> index 4751b04d5e6f..51a70a193533 100644
> --- a/sound/soc/sof/imx/Kconfig
> +++ b/sound/soc/sof/imx/Kconfig
> @@ -50,4 +50,12 @@ config SND_SOC_SOF_IMX8ULP
>  	  Say Y if you have such a device.
>  	  If unsure select "N".
>
> +config SND_SOC_SOF_IMX95
> +	tristate "SOF support for i.MX95"
> +	depends on IMX_DSP
> +	help
> +	  This adds support for Sound Open Firmware for NXP i.MX95 platforms.
> +	  Say Y if you have such a device.
> +	  If unsure select "N".
> +
>  endif ## SND_SOC_SOF_IMX_TOPLEVEL
> diff --git a/sound/soc/sof/imx/Makefile b/sound/soc/sof/imx/Makefile
> index be0bf0736dfa..715ac3798668 100644
> --- a/sound/soc/sof/imx/Makefile
> +++ b/sound/soc/sof/imx/Makefile
> @@ -2,10 +2,12 @@
>  snd-sof-imx8-y := imx8.o
>  snd-sof-imx8m-y := imx8m.o
>  snd-sof-imx8ulp-y := imx8ulp.o
> +snd-sof-imx95-y := imx95.o
>
>  snd-sof-imx-common-y := imx-common.o
>
>  obj-$(CONFIG_SND_SOC_SOF_IMX8) += snd-sof-imx8.o
>  obj-$(CONFIG_SND_SOC_SOF_IMX8M) += snd-sof-imx8m.o
>  obj-$(CONFIG_SND_SOC_SOF_IMX8ULP) += snd-sof-imx8ulp.o
> +obj-$(CONFIG_SND_SOC_SOF_IMX95) += snd-sof-imx95.o
>  obj-$(CONFIG_SND_SOC_SOF_IMX_COMMON) += imx-common.o
> diff --git a/sound/soc/sof/imx/imx95.c b/sound/soc/sof/imx/imx95.c
> new file mode 100644
> index 000000000000..5a0e44f5bd48
> --- /dev/null
> +++ b/sound/soc/sof/imx/imx95.c
> @@ -0,0 +1,401 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/clk.h>
> +#include <linux/firmware/imx/dsp.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <sound/sof.h>
> +
> +#include "../sof-of-dev.h"
> +#include "../ops.h"
> +
> +#define IMX_SIP_SRC 0xC2000005
> +#define IMX_SIP_SRC_M_RESET_ADDR_SET 0x03
> +
> +#define IMX95_CPU_VEC_FLAGS_BOOT BIT(29)
> +
> +#define IMX_SIP_LMM 0xC200000F
> +#define IMX_SIP_LMM_BOOT 0x0
> +#define IMX_SIP_LMM_SHUTDOWN 0x1
> +
> +#define IMX95_M7_LM_ID 0x1
> +
> +#define MBOX_DSPBOX_OFFSET 0x1000
> +#define MBOX_WINDOW_OFFSET 0x6000000
> +
> +struct imx95_priv {
> +	struct platform_device *ipc_dev;
> +	struct imx_dsp_ipc *ipc_handle;
> +	resource_size_t bootaddr;
> +};
> +
> +static void imx95_ipc_handle_reply(struct imx_dsp_ipc *ipc)
> +{
> +	unsigned long flags;
> +	struct snd_sof_dev *sdev = imx_dsp_get_data(ipc);
> +
> +	spin_lock_irqsave(&sdev->ipc_lock, flags);
> +	snd_sof_ipc_process_reply(sdev, 0);
> +	spin_unlock_irqrestore(&sdev->ipc_lock, flags);
> +}
> +
> +static void imx95_ipc_handle_request(struct imx_dsp_ipc *ipc)
> +{
> +	snd_sof_ipc_msgs_rx(imx_dsp_get_data(ipc));
> +}
> +
> +static struct imx_dsp_ops ipc_ops = {
> +	.handle_reply = imx95_ipc_handle_reply,
> +	.handle_request = imx95_ipc_handle_request,
> +};
> +
> +static int imx95_disable_enable_core(bool enable)
> +{
> +	struct arm_smccc_res res;
> +
> +	if (enable)
> +		arm_smccc_smc(IMX_SIP_LMM, IMX_SIP_LMM_BOOT, IMX95_M7_LM_ID,
> +			      0, 0, 0, 0, 0, &res);
> +	else
> +		arm_smccc_smc(IMX_SIP_LMM, IMX_SIP_LMM_SHUTDOWN, IMX95_M7_LM_ID,
> +			      0, 0, 0, 0, 0, &res);
> +
> +	return res.a0;
> +}
> +
> +static int imx95_run(struct snd_sof_dev *sdev)
> +{
> +	return imx95_disable_enable_core(true);
> +}
> +
> +static int imx95_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
> +{
> +	struct imx95_priv *priv = sdev->pdata->hw_pdata;
> +
> +	sof_mailbox_write(sdev, sdev->host_box.offset,
> +			  msg->msg_data, msg->msg_size);
> +
> +	imx_dsp_ring_doorbell(priv->ipc_handle, 0);
> +
> +	return 0;
> +}
> +
> +static int imx95_get_mailbox_offset(struct snd_sof_dev *sdev)
> +{
> +	return MBOX_DSPBOX_OFFSET + MBOX_WINDOW_OFFSET;
> +}
> +
> +static int imx95_get_bar_index(struct snd_sof_dev *sdev, u32 type)
> +{
> +	switch (type) {
> +	case SOF_FW_BLK_TYPE_SRAM:
> +		return type;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int imx95_get_window_offset(struct snd_sof_dev *sdev, u32 id)
> +{
> +	return MBOX_WINDOW_OFFSET;
> +}
> +
> +static int imx95_set_power_state(struct snd_sof_dev *sdev,
> +				 const struct sof_dsp_power_state *target_state)
> +{
> +	sdev->dsp_power_state = *target_state;
> +
> +	return 0;
> +}
> +
> +static int imx95_suspend_resume(struct snd_sof_dev *sdev, bool suspend)
> +{
> +	struct imx95_priv *priv;
> +	int ret, i;
> +
> +	priv = sdev->pdata->hw_pdata;
> +
> +	if (suspend) {
> +		ret = imx95_disable_enable_core(false);
> +		if (ret) {
> +			dev_err(sdev->dev, "failed to stop core\n");
> +			return ret;
> +		}
> +	}
> +
> +	for (i = 0; i < DSP_MU_CHAN_NUM; i++) {
> +		if (suspend)
> +			imx_dsp_free_channel(priv->ipc_handle, i);
> +		else
> +			imx_dsp_request_channel(priv->ipc_handle, i);
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx95_runtime_resume(struct snd_sof_dev *sdev)
> +{
> +	int ret;
> +	const struct sof_dsp_power_state target_state = {
> +		.state = SOF_DSP_PM_D0,
> +	};
> +
> +	ret = imx95_suspend_resume(sdev, false);
> +	if (ret < 0) {
> +		dev_err(sdev->dev, "failed to runtime resume: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return snd_sof_dsp_set_power_state(sdev, &target_state);
> +}
> +
> +static int imx95_resume(struct snd_sof_dev *sdev)
> +{
> +	int ret;
> +	const struct sof_dsp_power_state target_state = {
> +		.state = SOF_DSP_PM_D0,
> +	};
> +
> +	ret = imx95_suspend_resume(sdev, false);
> +	if (ret < 0) {
> +		dev_err(sdev->dev, "failed to resume: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (pm_runtime_suspended(sdev->dev)) {
> +		pm_runtime_disable(sdev->dev);
> +		pm_runtime_set_active(sdev->dev);
> +		pm_runtime_mark_last_busy(sdev->dev);
> +		pm_runtime_enable(sdev->dev);
> +		pm_runtime_idle(sdev->dev);
> +	}
> +
> +	return snd_sof_dsp_set_power_state(sdev, &target_state);
> +}
> +
> +static int imx95_runtime_suspend(struct snd_sof_dev *sdev)
> +{
> +	int ret;
> +	const struct sof_dsp_power_state target_state = {
> +		.state = SOF_DSP_PM_D3,
> +	};
> +
> +	ret = imx95_suspend_resume(sdev, true);
> +	if (ret < 0) {
> +		dev_err(sdev->dev, "failed to runtime suspend: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return snd_sof_dsp_set_power_state(sdev, &target_state);
> +}
> +
> +static int imx95_suspend(struct snd_sof_dev *sdev, unsigned int target_state)
> +{
> +	int ret;
> +	const struct sof_dsp_power_state target_power_state = {
> +		.state = target_state,
> +	};
> +
> +	if (!pm_runtime_suspended(sdev->dev)) {
> +		ret = imx95_suspend_resume(sdev, true);
> +		if (ret < 0) {
> +			dev_err(sdev->dev, "failed to suspend: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return snd_sof_dsp_set_power_state(sdev, &target_power_state);
> +}
> +
> +static struct snd_soc_dai_driver imx95_dai[] = {
> +	{
> +		.name = "sai3",
> +		.playback = {
> +			.channels_min = 1,
> +			.channels_max = 32,
> +		},
> +		.capture = {
> +			.channels_min = 1,
> +			.channels_max = 32,
> +		},
> +	},
> +};
> +
> +static int imx95_probe(struct snd_sof_dev *sdev)
> +{
> +	struct platform_device *pdev;
> +	struct imx95_priv *priv;
> +	struct resource *res;
> +	struct arm_smccc_res smc_ret;
> +	int ret;
> +
> +	pdev = container_of(sdev->dev, struct platform_device, dev);
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return dev_err_probe(&pdev->dev, -ENOMEM, "failed to alloc priv\n");
> +
> +	sdev->pdata->hw_pdata = priv;
> +
> +	/* map SRAM */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "failed to fetch SRAM region\n");
> +
> +	sdev->bar[SOF_FW_BLK_TYPE_SRAM] = devm_ioremap(&pdev->dev, res->start,
> +						       resource_size(res));
> +	if (IS_ERR(sdev->bar[SOF_FW_BLK_TYPE_SRAM]))
> +		return dev_err_probe(&pdev->dev,
> +				     PTR_ERR(sdev->bar[SOF_FW_BLK_TYPE_SRAM]),
> +				     "failed to map SRAM region\n");
> +
> +	sdev->mmio_bar = SOF_FW_BLK_TYPE_SRAM;
> +	sdev->mailbox_bar = SOF_FW_BLK_TYPE_SRAM;
> +	sdev->dsp_box.offset = MBOX_DSPBOX_OFFSET + MBOX_WINDOW_OFFSET;
> +	priv->bootaddr = res->start;
> +
> +	ret = of_reserved_mem_device_init(sdev->dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to bind DMA region\n");
> +
> +	priv->ipc_dev = platform_device_register_data(&pdev->dev, "imx-dsp",
> +						      PLATFORM_DEVID_NONE,
> +						      pdev, sizeof(*pdev));
> +	if (IS_ERR(priv->ipc_dev))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->ipc_dev),
> +				     "failed to create IPC device\n");
> +
> +	priv->ipc_handle = dev_get_drvdata(&priv->ipc_dev->dev);
> +	if (!priv->ipc_handle) {
> +		ret = -EPROBE_DEFER;
> +		dev_err(&pdev->dev, "failed to fetch ipc handle\n");
> +		goto err_unregister_ipc_dev;
> +	}
> +
> +	priv->ipc_handle->ops = &ipc_ops;
> +	imx_dsp_set_data(priv->ipc_handle, sdev);
> +
> +	/* set core boot reset address */
> +	arm_smccc_smc(IMX_SIP_SRC, IMX_SIP_SRC_M_RESET_ADDR_SET, priv->bootaddr,
> +		      IMX95_CPU_VEC_FLAGS_BOOT, 0, 0, 0, 0, &smc_ret);
> +	if ((int)smc_ret.a0 < 0) {
> +		ret = smc_ret.a0;
> +		dev_err(&pdev->dev, "failed to set boot address: %d", ret);
> +		goto err_unregister_ipc_dev;
> +	}
> +
> +	return 0;
> +
> +err_unregister_ipc_dev:
> +	platform_device_unregister(priv->ipc_dev);

If use devm_add_action(), this and imx95_remove() can be removed.

Frank

> +
> +	return ret;
> +}
> +
> +static void imx95_remove(struct snd_sof_dev *sdev)
> +{
> +	struct imx95_priv *priv;
> +
> +	priv = sdev->pdata->hw_pdata;
> +
> +	if (imx95_disable_enable_core(false))
> +		dev_err(sdev->dev, "failed to stop core\n");
> +
> +	platform_device_unregister(priv->ipc_dev);
> +}
> +
> +static const struct snd_sof_dsp_ops sof_imx95_ops = {
> +	.probe = imx95_probe,
> +	.remove = imx95_remove,
> +
> +	/* mandatory "DSP" ops */
> +	.run = imx95_run,
> +	.block_read = sof_block_read,
> +	.block_write = sof_block_write,
> +	.send_msg = imx95_send_msg,
> +	.load_firmware = snd_sof_load_firmware_memcpy,
> +	.ipc_msg_data = sof_ipc_msg_data,
> +
> +	.mailbox_read = sof_mailbox_read,
> +	.mailbox_write = sof_mailbox_write,
> +
> +	.get_mailbox_offset = imx95_get_mailbox_offset,
> +	.get_bar_index = imx95_get_bar_index,
> +	.get_window_offset = imx95_get_window_offset,
> +
> +	.pcm_open = sof_stream_pcm_open,
> +	.pcm_close = sof_stream_pcm_close,
> +	.set_stream_data_offset = sof_set_stream_data_offset,
> +
> +	.runtime_suspend = imx95_runtime_suspend,
> +	.runtime_resume = imx95_runtime_resume,
> +
> +	.resume = imx95_resume,
> +	.suspend = imx95_suspend,
> +
> +	.set_power_state = imx95_set_power_state,
> +
> +	.drv = imx95_dai,
> +	.num_drv = ARRAY_SIZE(imx95_dai),
> +
> +	.hw_info = SNDRV_PCM_INFO_MMAP |
> +		   SNDRV_PCM_INFO_MMAP_VALID |
> +		   SNDRV_PCM_INFO_INTERLEAVED |
> +		   SNDRV_PCM_INFO_PAUSE |
> +		   SNDRV_PCM_INFO_BATCH |
> +		   SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
> +};
> +
> +static struct snd_sof_of_mach sof_imx95_machs[] = {
> +	{
> +		.compatible = "fsl,imx95-19x19-evk",
> +		.sof_tplg_filename = "sof-imx95-wm8962.tplg",
> +		.drv_name = "asoc-audio-graph-card2",
> +	},
> +	{
> +	},
> +};
> +
> +static struct sof_dev_desc sof_of_imx95_desc = {
> +	.of_machines = sof_imx95_machs,
> +	.ipc_supported_mask = BIT(SOF_IPC_TYPE_3),
> +	.ipc_default = SOF_IPC_TYPE_3,
> +	.default_fw_path = {
> +		[SOF_IPC_TYPE_3] = "imx/sof",
> +	},
> +	.default_tplg_path = {
> +		[SOF_IPC_TYPE_3] = "imx/sof-tplg",
> +	},
> +	.default_fw_filename = {
> +		[SOF_IPC_TYPE_3] = "sof-imx95.ri",
> +	},
> +	.ops = &sof_imx95_ops,
> +};
> +
> +static const struct of_device_id sof_of_imx95_ids[] = {
> +	{ .compatible = "fsl,imx95-cm7-sof", .data = &sof_of_imx95_desc },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, sof_of_imx95_ids);
> +
> +static struct platform_driver snd_sof_of_imx95_driver = {
> +	.probe = sof_of_probe,
> +	.remove = sof_of_remove,
> +	.driver = {
> +		.name = "sof-audio-of-imx95",
> +		.pm = &sof_of_pm,
> +		.of_match_table = sof_of_imx95_ids,
> +	},
> +};
> +module_platform_driver(snd_sof_of_imx95_driver);
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_DESCRIPTION("SOF support for i.MX95 platforms");
> +MODULE_AUTHOR("Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>");
> --
> 2.34.1
>

