Return-Path: <linux-kernel+bounces-408266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B06FE9C7CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405E21F21A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC554205ABB;
	Wed, 13 Nov 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nrnizcr3"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CC77083D;
	Wed, 13 Nov 2024 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529038; cv=fail; b=nWExDB81/neiBHgh0qYEJpvxfSI5UNfS9/Qd21q6TPHqALGBOQpKbYuQQhixk8Zm/6sNUhkoz9afRSzjx2HrSwnDvIPMVkNV04UmuDcrqB4riLZgepLQLcuG3Nytb6JfbcW4LpMRG5gmE24GcllL4mWb4vlK3QeskskHa5sgRNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529038; c=relaxed/simple;
	bh=ZemJC8YJ28mEqOEQxYgY8hwWqAP1JgyAT/LuOoc7hr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D0VVrOBS57H5I8442Tv8y5WVyALQo2rMTlhD5Dh49PbfYOCOgDUC6v5+bGdg8xZYAl3yxJQMfSUl2Xe+Sq3COAdJzusc0YJdtsOw8T2YC5857Q1AooEdjiIWxdsctpXEeDZrNd6jN9K0Oi0bKtBuHYbAbTDaHSsT/oZ7hq7XXlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nrnizcr3; arc=fail smtp.client-ip=52.101.65.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5ww4i4T2/cEYAp1OJ9PtOWIIykoaoUespj8l6j+uo+EDqaj/bnJgU6oaaN0aKVfYnyZN9MT81xyZqIc2/2rSRZI92OIXQ6lmfEiceBZikeKo+d5H/npOegrgvBZEcGn161O3f+lZ2MmpBn1mEJOqxERcbSDXuZWc40FwDYGSvJZ1s6tQNOFH0zG5iC2L1OT0ggBlSETTe7dRCoehtnwhy+SBZ3QlO5hir809vSzt88JrLXP/lv/RB9/kPT+sR3OMyzDl5qIGMQWaCI38q5QkYs9IXzwVSnL+emosBRvwRWC2Qv0O3jpyrBsToevqmSyPI4m1DHsBwcLIXLBcdtsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9PldUhApECkBw0gCugSGYgai4VYST1gyo5eifI3R4A=;
 b=p/KGRBHu0s1GjUdVgK1Y0Jvy8a46syx1L2U41FQ4t0xsMy6+vETs6Uop3JbLH9jOB7Iw1b7XPuuC+5W1hc7sUAHOCqqS7APMh29zO9hNLf329wMjx1PcPpDB+YhVtO7KiTxc4bBcsSZj0uPuvep+Hvrnht+Rt2NcJNQkMZkzJ5BPOYrsnU/Ia61yaed7Uqhvq/w7CgwmehLYflzqh3Nf+lRZtNyFgzszT6UN/C8Nv2l12tbiZVu30lI8KaJOH1qBqHX7SjiWwQpQ6NODdOpXyyxqnlwbPq55pWqzpQ52g3GgHqYf+SDUT6vPAgobzxyemR0fv6pY9cK+B9vlwbUcnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9PldUhApECkBw0gCugSGYgai4VYST1gyo5eifI3R4A=;
 b=nrnizcr37TNt2IYF1rjdiOGCa9eIriu5R61aGYoFmqqhF64S7AobcZdvKWIhGeA7+Z3nCG52yuWyMWgKFs+wtLHFgYbbyz3q8M/tY49X+Ww2ekTlI/PwYnMkW5EcFO5Jn8WksorTLewADF9P2W6d4sH2lL/7UPGuPEScsBu3BuJZWn709j3wUcn/bT3BeCxzsmsjruwUSGnHJ0ey68q0jc5HePAs4Ga/sqdU5QCcAgaTl7bnxjRC6G9mFrjnsXy+nulqamBTenVaGKAfRRjcDCDW2wIVdLWvT4nqviEg2z7RTzUb8dimOp7mF7S+iAnxqBHVUr4ylejYPHAK0KNA6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10647.eurprd04.prod.outlook.com (2603:10a6:10:589::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 20:17:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 20:17:13 +0000
Date: Wed, 13 Nov 2024 15:17:04 -0500
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
Message-ID: <ZzUJQCeWclsrr/lr@lizhi-Precision-Tower-5810>
References: <20241113195240.3699-1-laurentiumihalcea111@gmail.com>
 <20241113195240.3699-5-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113195240.3699-5-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: BYAPR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10647:EE_
X-MS-Office365-Filtering-Correlation-Id: e324e30c-bde5-4e30-425b-08dd04202923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wbxqt6CA92Aa63bNKb8oPFQZ2zLaRmrJMt96h/9QUWDclcuA09bype7kn0r6?=
 =?us-ascii?Q?Jlt6brm6mt9OTCggm4urbcqCX/Yv0/UvXtlor3gLMRulE8OrD3tCG8d2R89A?=
 =?us-ascii?Q?lVjYKRrruVk7dSZYYE+OX0je5hQjrdt45+Iz85Nya41bbgqhXt8bc9V5sXWH?=
 =?us-ascii?Q?XL0fvzvqUFUAHvs8boqDR9zlFGcVwUqHezA6CVfUddOUsAhOonS+Dx1Su1xo?=
 =?us-ascii?Q?rnt3Z/4TMkOplAJyDTNpam2VrGBwZXnAuQDJ8Hi6XRvbWKFWzLsP9ZLjxyBb?=
 =?us-ascii?Q?sjFDZoycvMs3FxI26ww96PV+vIzWJhB7m3bR85ez12aqUqisdW649txUNtfI?=
 =?us-ascii?Q?rfDZFBWMVNhuEz/as4670SDNbeshitzQykivTHmGxR0kdTdrnNtOCKB3Wlfd?=
 =?us-ascii?Q?m2w8wp2s230gEnS5cNhbHzEymzLNdPmKJ6mJkgRjDqvmFW+64DiAnkb8tN9V?=
 =?us-ascii?Q?TNgZ6deriAAIaSsr05YO69P0UvKH4EmMsTrCTwnxfaxcmxNWUNW0C4/8obKO?=
 =?us-ascii?Q?BRIfSBqufeTKFXIiH+GKawclxLBMIoNsh9S6LuiNgwduXoZuGdX+rFK97cdg?=
 =?us-ascii?Q?0ShubulBhuGuezVpt5qN4G20VEurpdOodIJTWhg9DKm6L0eD/kixrXeGD6CT?=
 =?us-ascii?Q?uzMCG5aJcYYvrE483BdRAJEyvRkznHWfvoC9VBGaz5+mYXaREiNSMVr++Qwq?=
 =?us-ascii?Q?ezH7MhRqlz+3O4PbriAF4kNApmEHy8rrQ3MsKAwp5//QEB1JPOXO6XDzKWnr?=
 =?us-ascii?Q?Bq9vq3SxMoyF5jkQ4ljPTwBi/ftRmREs3jjTT9HOx7btEX6REqYF7qB+yQtp?=
 =?us-ascii?Q?lAzzOXyHCQ8ioHxntf5wAUsznGGgV5whqxDywmzSQktfZ0G/feZ9MmeyqHW/?=
 =?us-ascii?Q?QljS8wCsai4XjNpCn0M1ONjOITV1Tc38WSXh69JiECJ4vOP0Pn+aQRIAY36e?=
 =?us-ascii?Q?3GUhwAHmKJYQqz62sJfnuTQQlIHeFQrMnS2KD1eqT0BQcUO2m4j+3z7R4f9F?=
 =?us-ascii?Q?+hoXgDuJ1W8qPl4LqUb4vEvy3D0Z2g4R/DvyUpbwcMuFFUIM+wcJOjwC8TBd?=
 =?us-ascii?Q?62ceUaBEbP4okhNSAIYvjELHlLtE//8gGQjRIvpZEIlD4EJaPPbXdrQ+Mzxq?=
 =?us-ascii?Q?5FYrqJFEC5M8PIntw3gf44rQuIg0zruFo5X4SZt1qFj1AFKuFthXxVKsKkLR?=
 =?us-ascii?Q?IpetWtQzzHVYM8PV0gA+OxBKf3gksDXB1jt6TodsY3HnxtqrSsXRZXgfWSdT?=
 =?us-ascii?Q?5kcd+dd3A1r48Jajx9MP1s9NFOBDPcpgkTNei1H5/9qIqI1nL3C9rePOOpox?=
 =?us-ascii?Q?oop5C1EqyNEt6vQNSk2+pqFqtfstxpNySX91n09Jo5sMAbyQ2eXDaiOW5gn2?=
 =?us-ascii?Q?XM5Z/aw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dPfZZKqvbGJIOXnGj2cIbPRW3jym03Rqfd/lVDChSOvJoPe+R1zpE3MR9jah?=
 =?us-ascii?Q?cPhPe65RbP4HM4ofAtO6qWSv9tXafdJpGGjFqz7wP0OFGcvJi95GxETmwBdJ?=
 =?us-ascii?Q?ciqPPEsx36czUUJbgAOzyvcHGtFjeOQh5SNhRFsWxzCuddoVBWWgIc7AowyN?=
 =?us-ascii?Q?x15zNqW71MpP04jzPHgF76TUP9daXKOvbhSJOSvnDCPUbUsgPgILAMFiDIVd?=
 =?us-ascii?Q?bjzTy9VYGB9AGQFdr318w/XObM+ep3M/ddnBd0/XxVI5K8TW5PHgBYcPau4K?=
 =?us-ascii?Q?t8sfq5GMy+1/KIllvZKN6rVsJmDak+VVriZwFpa18ThqD0QTA0UA94eIdt/7?=
 =?us-ascii?Q?+M21sy/MIS9jHGXOAx9J6MDR23CRUYZ83R5KDQgiF3uirbPUmDM1BkjPkZ55?=
 =?us-ascii?Q?gsOTlv/WWt8xi8z+glUWNkWI0BdC1ib/Dv5ekjjDr/VGB/xA1nfYXfjsi2gH?=
 =?us-ascii?Q?gQI2vKyd9ukbCMUduSZ8aATvijSPnscAglmhQgroFYwKDUtUGaopagq77kMc?=
 =?us-ascii?Q?I18OmSKOR4PU+N0d72P3cNLDBMR8+ySDr+0qyPt2R9qUg5VueCpl0u/UYk1s?=
 =?us-ascii?Q?S9FnlKLwoI/ZYY4Ut2HtF/52FQyQfvgXIPyP6sQJc2P2CfiXlcV5lcnDpvGB?=
 =?us-ascii?Q?aGyARaDkBFD4hos1hwl24Vk9pAIXjMsMIGclATzrNupO7eBrFXuR5vqw28tA?=
 =?us-ascii?Q?pw+emrEsEgWtX+pfHd3Tsm6nuUsrVpRpIKK5Y6Srwqm+Ibz7eDjlH0Oxhxfu?=
 =?us-ascii?Q?SRVI7e2bs9isUVBOcOMw1z2SsiiSwoWknNnvFDzsS8lkBB+xS04R48JTaUA0?=
 =?us-ascii?Q?AINb8i2jvBbk/NVrpKI3co5Xrnbx/UKVMscNUg0z4GbBwckctK0Wox8H8J7N?=
 =?us-ascii?Q?PBBNwUIxgSEbIv9E72NPMSqxEFVT3Qpy65BVC7Yi30z9zVA0lX07CE0jzIuO?=
 =?us-ascii?Q?wZu1DMPkramxRhDSqWJZQyxIw4G6RCrsKImuGh+ly2rrPmvt6zIqcwD9fVeL?=
 =?us-ascii?Q?oUBy95v+QzSOBiAbKaBuxQtweId7icfot4BiLZm0i71Cl+H7zksjjNJLLAS0?=
 =?us-ascii?Q?w6HAYxe4F+j/EzVGLhz7o0Uy6SiKMAnZrrVUbqKPwlLtIhvdu/4m4QxKWriC?=
 =?us-ascii?Q?jlmPDg1HvlY5QsKZ/mW3ogbmmANDqExrLqPruW+gK9VaJzDhED990Tv1daUT?=
 =?us-ascii?Q?lOyct60OstawneG7bBmc5DXAmQ3jpglUeTkgFToWuy5YbtHsk5U7n+3zU/qm?=
 =?us-ascii?Q?rx7OY2tOWuNuu8xW0wkAdKDsYCO/c/ykthxphC37DMj5i60txH7Zt1jwl9Kd?=
 =?us-ascii?Q?kRPaVYYsdD/NSvO4PgW9ckLHlFCX+uXWSQ2o8qzy2C+M4ZeWLPRQSVa+YXbK?=
 =?us-ascii?Q?LzuPDoMt++iPrHy9n1tfijdF7PaIWoUy19kI0BWnVuwJ/FoYc8+5cttt+DHB?=
 =?us-ascii?Q?DSzEzspK6Aggm7W6w+NndN8wSOOn3Nj5TlSOk30rs3ZF/w1oOhdRENeU4gCv?=
 =?us-ascii?Q?4CASgBwuZot/dONwB8r3/sxhAxt037Cyb77euy51DrVcBXrij3yo2oDSSmeE?=
 =?us-ascii?Q?HjhagNbQLFUzVNg2B8M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e324e30c-bde5-4e30-425b-08dd04202923
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 20:17:13.4873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHycm5/Klpz02JfOftzjgNJ5g9k3AGIdratkbejAb7MNCEQjprpZzAUVt33GJUQO30dqOgkAK95isMliLedk2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10647

On Wed, Nov 13, 2024 at 02:52:39PM -0500, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Add SOF driver for imx95.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  sound/soc/sof/imx/Kconfig  |   8 +
>  sound/soc/sof/imx/Makefile |   2 +
>  sound/soc/sof/imx/imx95.c  | 401 +++++++++++++++++++++++++++++++++++++

why not reused exist one? look likes simular.

Frank

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

