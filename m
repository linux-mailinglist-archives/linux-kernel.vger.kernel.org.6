Return-Path: <linux-kernel+bounces-510187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7B2A3197E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A721887CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE945268FEA;
	Tue, 11 Feb 2025 23:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OCa1rd24"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31980267AFD;
	Tue, 11 Feb 2025 23:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316339; cv=fail; b=TWohT33wH0q4HwKjrEfutJs9I6PGwLbHHT+U67iUnVLs1IJEPt8KviR7NF7AA2sjkTbLZ4f16a3OCbUs6zy7mIKfJoOAYZBZ4/sr/b5i9boZ8fJQ526UoKrj8p1Wxm68ozXvMpp5MtYzxBq1m8ClCZi4AwZFdNFkPIZyKgORUmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316339; c=relaxed/simple;
	bh=L2y5xuaIMu+a6K9lfJG+rZ7hMNrwpqMWYtUQezdtiXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qIOC3H656LiSJ6gRaywmxvfTI+5/PfEDKCOsmJ2LwV0nVBPtnbTtXgzTwGhzES/zfxhU5ffSB8PyKGXMBaf6y4RmaFE12rUlpQzrU3rF9vQRLyNVxymMz47gH0rh9YfkMZWghWJwKSjAQCd30Aj9tEJ8Wgu/Rkxw7HKFxwl5aZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OCa1rd24; arc=fail smtp.client-ip=40.107.105.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2WMNEBZoAHL1vcwJz+B540qgC43uckHOimlEFy5Ah5tSlDqEsxFRCAdA6/ERCg2W3MMjiPKDHLw8zSe6dFttVm6xJbqc3n4lvve7Nx/feIal3zVaPR5zBYbY45axI/JBOf3xMcpvfk5z7MHCoEIIeAPbSGA6FfV1O5qldi7HnqQuj+6yxm9esGUNTei9O70G1WAcFP0hf5WXp8eunKdS1S5dVzq3Tajt0N02Gfi1jexKy/RH/pRz0pNQVyT/W2aXy07FQjrHxxOdguIrD4EVcgAAJHSy919mRehZEKo2YFlPos1OvJQiMxn2qWxEHNHuItMDTAMBb6lmkPDbdtbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUWPEdF8GFZ4adYmPCZUN2HwVdUcCPK3sqI23xsTCf4=;
 b=k0/VeLuFSMQd3tptaQojYEtnGNlH/J6NFUfZ2oQyZGbi9p6S6qKPKAit7VP9i9OQUyH9y+ZFpMYeTPEH73EKE6UDHl2pSjEF7HkjpNKKWE+AC1L82p8aW+4zdZZxjib1iuk3SVBwO5ECcowK1LEGkC/5WQwdBvSfUejneTs3Drogm72wNGgN+nRWuEoGZtfTBnqGMTfiabNPyJ9Y8LjAJUjDBZMA1SUHerY9T9d4xByuUamfeFS2fzOxrMeiEj8XgFRTtohJ3vFIiemAcoM4PEasFbynzs7Yv5k5j+duWgsnboDkj3OMJErp98nFB9zfjeHhr43j/6b9D6TrAF/4eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUWPEdF8GFZ4adYmPCZUN2HwVdUcCPK3sqI23xsTCf4=;
 b=OCa1rd24qkNwW5Q1zE0goVWCRVIz6NLBzSKUGna7VdNWfRvxPSXCKJXxZNxvaZ0951rqa08X+f7mjJ9/lhiz1NeTjdA1JcLNgwE6mmRfqkgaRPntAXGQ+wr2k69tZDjPM8Qb7OMs0KWog7HoE2rRRBOC5+ANivA28Xro48eVo8547zGhYh0qkSOusTOAzf0E19APSUpHUM147IHP/GiL8pldI0CrWnmHZNfT1WQU9LWwM0rnYvdpiG4Bsp6zkRt/FQxN92U7Gq7kLapUrbFVM4Omi6X02eRRP5L0R1gyvr94SRfC4fZOJ8X0rtzNYfUSc8e+zADnGdAgaZP5M+twHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB9104.eurprd04.prod.outlook.com (2603:10a6:150:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 23:25:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 23:25:34 +0000
Date: Tue, 11 Feb 2025 18:25:25 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>, imx@lists.linux.dev,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: SOF: imx-common: set sdev->pdata->hw_pdata after
 common is alloc'd
Message-ID: <Z6vcZVXcnM3C3hSh@lizhi-Precision-Tower-5810>
References: <20250211225018.2642-1-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211225018.2642-1-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: BY5PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 73cfe6ed-fc23-41aa-e012-08dd4af36244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rPRjQuFe94UQFsJJjGE6ggwCM7IbUR7kD+pphtlLmP4PuhtC1FImpiCNsfZI?=
 =?us-ascii?Q?okDjgA3I6baPmdLNEzgpii6ggFf4hUoLZjyAqFz53S5evVDVgra6mRXUUWtL?=
 =?us-ascii?Q?J5oNBsd9fDfVbD8BC3RPIs9YSk/HZgdbPf/Wvvc64G5stGynnKAE8vgsbF1r?=
 =?us-ascii?Q?1HGSl9FzPqhiHpjAiJdIAO1Tm0dYynEIC6cAVr5raSt0sJX9EjlmsIqHvMLO?=
 =?us-ascii?Q?0vVdAKvX9Ht0G5E3GA1orZUOkSD6MeUCMrJahWuU60gmzYLMKQlFRiXjIP8K?=
 =?us-ascii?Q?7gMaqBZyTIzXIsRyDOUUm7IepAMgFCqzkPlGdnC8bLvJ9TosOllQCnsEPfWl?=
 =?us-ascii?Q?O1xIjLIlIDEEp5BwP/iwmR9xeexylUbbMnXw3z+fM2gX2uDp+RktfsAc/LLg?=
 =?us-ascii?Q?Qq0Wkboz+t7STnzyrdr5iNpfxmYMa7wQXXHLzOiwE6O8foXH5aJJ27fM6nNT?=
 =?us-ascii?Q?j4Z7lvbF7niGP5E34YildHwjEmY9NDA5YKLdXnIer17wA+KBO5pf55pnqSPt?=
 =?us-ascii?Q?h222XlKGim7HKzUDkr8te0k44goKA66qkIQQDTvveS5DUAVT3pgCC5G484hx?=
 =?us-ascii?Q?fKoZ/B1TP6afs2t2MOI5SUqQs5uixbfA2YORYJBaj6K9UWcG2nht8xfY8C/O?=
 =?us-ascii?Q?I5C9nzIQINq2oFX1Yo8czgXUww5OZALxqKso8ydg4amU1cpWEQu8jOqzCYvw?=
 =?us-ascii?Q?NZXvJ4B8vmovW5vJJCFJuzO9EinPAP2ceZ/WMBvfUmDkZzgcKmPKjf8l/g/5?=
 =?us-ascii?Q?/hcZm5fuV9Azk8ihwfGlOfH9IQnrhcJGYJpkU+zrZSlfS91uRsnVM8v3KJsX?=
 =?us-ascii?Q?QH3mcDvBaZOZiartepgfL1oYfKY8vYcNKS2tdEtLZEw2oDfuNCgnR4u+E6+E?=
 =?us-ascii?Q?t1Hj92fOSTzCuTAPdvvxDgMEQxSc7gnUwSavymZWnj1deZMesfIbBQLdgkIE?=
 =?us-ascii?Q?TM/lMDOjdsd1u8LniRxiZ16WjKIQ15Pkmhb4V8tyH86JLQg1ipqRX2Fcw9nc?=
 =?us-ascii?Q?VnZVASvtN0m+AZmto4NbJ4vF8z1m3uM6Q/LN03bSRNzO2L9G78tG16inD7K0?=
 =?us-ascii?Q?N/eq5NZo6+0H4nOwfHLAPGswtpbBGA5dH4t8wLBGxom+L9YFF+M07BAGr4Rc?=
 =?us-ascii?Q?d99fO9kV7QoY0GE/hVoaz0hzyETY1ReVQpx0Cqeoy9CZBYRKqgmyncwk5+89?=
 =?us-ascii?Q?a6nVzFJADWdjeoDszvhmQWVy89ZIcWSRzXDBt/MCpEyZRx+JYT30bl1ZICoV?=
 =?us-ascii?Q?2xLC+hlL7FvJJkTG+qBSG8xsQ/M99Ip9qMgWjlfAK0GLT7X8NS7Duq4XqwRa?=
 =?us-ascii?Q?X43pHcoTHLned5Y+p6I5OLO0nR+lZesqFdO9SS8B9RlBFEYunXGbSvkEcTDB?=
 =?us-ascii?Q?6yEbepC6wCFRDS2r+uTPnlKMIS+p9IG3AYAIZG14fZQ6O3nHKnXPOA6GzIhj?=
 =?us-ascii?Q?q8QJcR/XBCQh+65nzrbg9Zdl0pkQT9H/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6k9A/UYF02k45JqlBQx4qz9g57gvVoGItsKHrgyfY23/z59csLnwaYsZve9b?=
 =?us-ascii?Q?amhQfkBpN5akua3mfkroCMTBsYlY94iWLIWNccoyGqTdf9BUP+gKB0HJ2RGP?=
 =?us-ascii?Q?f/CRYFYOvjfEL2dZ0ozCRg8a+OLzjy++KYGVSunYohtQHcc6UUwdcbvrnYtb?=
 =?us-ascii?Q?zdgpT+B7X6Uof8zHo84aIgHPHe5Q7+if3nO8NEDOtHzicc0FYHpPlvu0qNxv?=
 =?us-ascii?Q?iO+2WNrSScCnBdaUcPTALEcTiiDca3zwXELxp5DB29x8buCeiclJ2Eg4Ohpi?=
 =?us-ascii?Q?iv9tFEpwbrKdPRrxKcjOnDOD4/OTbRcTGeqAWUYx9UeZQfuf4watssLxo8kN?=
 =?us-ascii?Q?LKwrLfpQs5e3sUdn2dMrDePUri+FyDyzDjiPYcAiiYqq6YGIYi6lBOv1FiwG?=
 =?us-ascii?Q?8OLfOe6xa2idupF54uHESTBBDEkaLHquL4JG5YiKEYanm6phrRovuV8vd1/0?=
 =?us-ascii?Q?8JAHDJlVyhMQBss8nWw5LemaOnFPFdbyBP2IdtPIQComxR+PF722I4Q1ecHS?=
 =?us-ascii?Q?YUrQvUcwGuSbcV7c+50APgkyk1VeAhuyykqPx8GM/IRJskYl+LxaRs1DRbAz?=
 =?us-ascii?Q?CJT8X31JIThR2oKJfCtpwlHjxAGOed/cvnw5zXsIkZIAUs6Bak2zKsLon3Ep?=
 =?us-ascii?Q?49HGBY+ijEZVbFZCrN3ojMaYvd6ZNTm10aAdxK0M9d6oyiubmYdr1EfD5laf?=
 =?us-ascii?Q?1Bs72wtrw0/ARgUOtIFHWhIsJYZpEAeOvDr8jZ8U01Zd4ZIAZB9tJbgKiGOR?=
 =?us-ascii?Q?f2GLOvrE/Qv8CxR3/KURgRzbO44zod0zX6IKhr1+Thfz2kRZmU/eo85WH8fD?=
 =?us-ascii?Q?76em/r/qJbx6k3Btd8xBzRx0Q9/YM9pCW/qdUF3JbGfePagKT7rdpGxIiUlY?=
 =?us-ascii?Q?+ManBuRyiFH8Ke9hf/dbUQcv7FRNfZ55q58B5JfGxlDg8QX/vWw/P0/LVVQS?=
 =?us-ascii?Q?ZF1m7sYFCwo7AOus6+AjOpfVU2kSzIaMT+a1kd+HVCxFndUMEO5Kn0PFDVpa?=
 =?us-ascii?Q?SL0ukdomX5y+CGyeVB37Ayt573/E3gO+ZMPn9R4zKpMOE0B3r16e9fsxQk21?=
 =?us-ascii?Q?iu2a0YvJJP0f6DAkRntse+ohwU9h8y28FVw2gopP6/+xHzeL+mGdhqRDbqVP?=
 =?us-ascii?Q?feSv5pPtm7pQ6R7eEXRpPFcsbGuFJZIr/+9juNIUe7hNnHvYBORqHhAr55RF?=
 =?us-ascii?Q?aRGHdZFwH6CyCgrC7rI9CsNrCGq/InsoZRVCU1RPa49MEcNKNoRPPm55ny8O?=
 =?us-ascii?Q?JQQB9TNu5RZAdgUTZVj68hzEyJHUnk4hlrcaplWOl67rDItZ0NvqsNGum7kx?=
 =?us-ascii?Q?nK37BMhMlkcH9KII5lS9eaA5ov8rs99E6DyWKFnsVopoTFbV66/7DU935YL/?=
 =?us-ascii?Q?UunlnCRh/CGrqTPZpmp+qBBvHGQWKCB39uJ4qMQSWYAaWIxyUw7ZsSNcGF79?=
 =?us-ascii?Q?60RoH4Yz6BW3vYvwtXls0HaqAaBHP40yz4JfkOp2puU/szhd9lnO8rVpc+cX?=
 =?us-ascii?Q?ZBKwRaXi4MYIUqQK7UQHkR1DeXvwbbXfhnDwPCVk5XO1hoVtUSkgp9xPAqtp?=
 =?us-ascii?Q?2mg17YBv/ycuS4b9rW+Hej4Kodoqv7TaG0tWEHzf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cfe6ed-fc23-41aa-e012-08dd4af36244
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 23:25:34.3774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3dKzowGUAZdvx2G7EPySY5/EF4ciLjUaK7d1Em3lY/DVB2AIwECZcjq4BY3G2EO3pE2+9E9gI6tYVGbeuLOkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104

On Tue, Feb 11, 2025 at 05:50:18PM -0500, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> 'imx_unregister_action' uses 'sdev->pdata->hw_pdata' to fetch the pointer
> to the common data structure. As such, if 'sdev->pdata->hw_pdata' is not
> set before adding 'imx_unregister_action' to the devres list, we risk
> derefrencing a NULL pointer if any of the calls between
> 'devm_add_action_or_reset' and 'sdev->pdata->hw_pdata = common' fails.
>
> Set 'sdev->pdata->hw_pdata' to point to 'common' as soon as 'common' is
> allocated.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  sound/soc/sof/imx/imx-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/sof/imx/imx-common.c b/sound/soc/sof/imx/imx-common.c
> index 82057af1436c..c3594815e60e 100644
> --- a/sound/soc/sof/imx/imx-common.c
> +++ b/sound/soc/sof/imx/imx-common.c
> @@ -378,6 +378,7 @@ static int imx_probe(struct snd_sof_dev *sdev)
>  	if (!common)
>  		return dev_err_probe(sdev->dev, -ENOMEM,
>  				     "failed to allocate common data\n");
> +	sdev->pdata->hw_pdata = common;
>
>  	common->ipc_dev = platform_device_register_data(sdev->dev, "imx-dsp",
>  							PLATFORM_DEVID_NONE,
> @@ -436,7 +437,6 @@ static int imx_probe(struct snd_sof_dev *sdev)
>  	imx_dsp_set_data(common->ipc_handle, sdev);
>
>  	sdev->num_cores = 1;
> -	sdev->pdata->hw_pdata = common;
>  	sdev->mailbox_bar = SOF_FW_BLK_TYPE_SRAM;
>  	sdev->dsp_box.offset = get_chip_info(sdev)->ipc_info.boot_mbox_offset;
>
> --
> 2.34.1
>

