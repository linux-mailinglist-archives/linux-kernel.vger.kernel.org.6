Return-Path: <linux-kernel+bounces-524415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B1BA3E2B5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C21F18943B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBDB213248;
	Thu, 20 Feb 2025 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TCg9R/Y8"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C4D1D5CDD;
	Thu, 20 Feb 2025 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073235; cv=fail; b=Rux7SjkBua5FBBVg9fFogIPjgH/CT+rTCJr9R91myeGZmxUCtedsg1syCw7D8+YHMcdWuUtaweeRtiRKRlFS+pmCYFKWkCthBLEWSYYORQ1UO5AgUaveGAbXl04fteAYuqb33QU/oqsg7p2UQ4ep1olk1Y17vTCrhQSUcM7lEPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073235; c=relaxed/simple;
	bh=loRHwfNWRwFrY5iDcIN2QuzrjO7DSbc/GhnL3KpNOVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ODvjTjxejlCHOihRLsPMLb4ugRcMs+VNvga4Qg074zJHgwkFNFPLbGusH7PaNU3iyA3rd2IwNHXkTi+E8sUiRQR44Vjd76ziGXHxSrfK7V5UQxMPZkJ5T1MuQ9OoSkuyQ2RJffVTf/3JPMgXU/lXPEp0Iz8me1utljFAej+vPPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TCg9R/Y8; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPZ3Od23puGuzlXDKrQRPf/Lqx6i/Vd3F6F3rmm+0bsdm4Pb5G2dXqvn/L5PwWOoVhScOn9ZzxOboEo++AbLzSX/pLBEkwUKytLQeP2jWy3XT2JSuwFWbPaVh/2IxO/W7E096FMdiMQDTQ2Uvm8ymTf20B+kghfNaip2K1ircUJndifCINS5cwm7a9e02DX1fhPyHFZ75mq5gW1N8bb4VhFMk6Jmt59LB0khKb4myvICiRz7TbJ0SKjTvmIz8tPrsDvjoJyt81N0EgmurWSslLQ9tCc51lzTUwiGGgXcFQObldEICpsy7qp5Z+aJCO1nxrVjDbkBsJFripQxA95RdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFcQIc+3aMPEjnZ37TyiNv/7Btr4RcWGtw5/M5tOptY=;
 b=mam2jEJBAjxTpSO89AMCyDGCJvZdgipNnuCA5+7KqNienlljVn1YJ2phigORUeaQHtZ571K0Uzv/oLRe73uI9L87ya72ZqG9+9lTqz/IHF9wBLPJyyYLBjFBzGYTjxmyHkIMbne+Rixaz7hXssqX/StPJ3U+X1evRbKaMrZGKsRvgbxmesJNtbzoPh7oOFSbmwRMnIKDL2Hvi8p5xckmKrgDIpyJUyTF+1mcebO0yBerXYuqsabsIrg8zYQnmCs6Ff0eKwD4h178c/aqB3Z/of7EqVFE+UAii/VvdeGSt5u4fp01MMjtz8VMy1dRti8UQKA8SdgU4hKL1C1fLtSTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFcQIc+3aMPEjnZ37TyiNv/7Btr4RcWGtw5/M5tOptY=;
 b=TCg9R/Y8t4kDzo8KAJIuFdtapzv7M4GvuxiapHK/OkdOw29bGDEMpBqBVuWBP9Kgg4n6dYYkAQr6B+TvgIEjep0fi5MnhH1c+CsduR3uxgwmWTZVVmvD9xlsSTL+Trivo8gsf5++gIJlxf6pm7RNeug1UNomn0IF2vZ0NN7kpATwdRbMKclMXb/98DAIfuCEhJK8mDfJNz4Xs05I9erbVNLJmJ7++J4YiSuT2POTdM038lhCyh3rwz4H/PJFouUSLooPgu57ZV0vi9KBDGJG3ohEjPxkT6PZKwXOYG29Gc2cN8Cyy7yF6QlAeLaQFwmjDu2pweCLVSjwka5LTim8/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10272.eurprd04.prod.outlook.com (2603:10a6:150:1bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 17:40:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 17:40:27 +0000
Date: Thu, 20 Feb 2025 12:40:20 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH RESEND v2 2/4] i3c: master: svc: Add support for Nuvoton
 npcm845 i3c
Message-ID: <Z7dpBK1Z7biHwVne@lizhi-Precision-Tower-5810>
References: <20250220061107.1718239-1-yschu@nuvoton.com>
 <20250220061107.1718239-3-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220061107.1718239-3-yschu@nuvoton.com>
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10272:EE_
X-MS-Office365-Filtering-Correlation-Id: f06b078a-708e-4a92-c85a-08dd51d5a9a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xAAzjsxspftVuzJgegP2lkHUjMNfTyQi9lRHLxW1Q9CPs2rRoht+Xn7wi7uk?=
 =?us-ascii?Q?+v3r4Enk+xcx4NcZGJagGI1/Doo09UVEAUk5fK07XVhXjiJDe5ahRhffJQfW?=
 =?us-ascii?Q?bafnW5J8gb9nuekdIJVglql1hnlupM7SMJGdGXzRPmHq8j8nvL2TOxJsfcoY?=
 =?us-ascii?Q?Hd9HZdK3llA4iu1CH0rIiIAWgrOKsCf8X09l8H6yMgJ49duWrZQ3lqiLZ1GG?=
 =?us-ascii?Q?r2oVDg5nplvakuvdvNHQTJF4GSDD35cPqHTnHVgRwxXq5uxxyT1a/qwynR/O?=
 =?us-ascii?Q?J6PYDoJ8z20vqx3WStLT5db92aOw5U7LNiNTAj04z7TAd6BHTaND+FYHMxh3?=
 =?us-ascii?Q?2igkuqEiMo0kaHklkZwc+y48io59wTo2MwfzNqxlzbotsTDKuXJ/f759kQ1g?=
 =?us-ascii?Q?CwNfSt8CAeVDq6a6degmhD0yb9stVLRBY9AXxGTQmbr8YTJN/nPT/TX58YDx?=
 =?us-ascii?Q?kBdwTl/QC7K0NasTBfisX4MsIEBoDqKW/Ng+k+mLfEyatndUAPwjA6GHS2ez?=
 =?us-ascii?Q?NLSYc+N5inlNLE5c5GS0Vvwl2xEAD/P9nz5C3UccPuTWyjXr1+seX+dGiGkx?=
 =?us-ascii?Q?4fPo+4HCipjIjR+0kHdz8xzFWCIcAKpWOE8YgvyyI9LwKZT+fxDrCPoF9WbY?=
 =?us-ascii?Q?k6qnvaBJ2OXYxbP1Oe7zDi0SkTrJOK0vY4NxCbVCg35lbOUBU5kXWJZbAo/W?=
 =?us-ascii?Q?iNbIOVSlCw5n4J5HVFeA9zw4I7TX0oVMYLgoS1IQab0uyyr03btNXwzjbudi?=
 =?us-ascii?Q?HfWUqd1L6wqrXvvxf9V4tuYlJnBu+/XEKeeNR0VeTKDLAIgovL59r7pDDEJM?=
 =?us-ascii?Q?e4CtnFahrqin88jQ/ybKguZlnlr477w5j/2O28WzGAHAXTyggKYU+PlWnQcC?=
 =?us-ascii?Q?4ZTTmxeJgyTVnko5CqW/UFQNMeX5h1q25/LG6bcE6DSODaoC8lkTced1gCIe?=
 =?us-ascii?Q?Io3C9ugbmaoBpKjxbJKEzYMZlan+tpGp+YKjE2pgkprJhahZkfoL/NOaUpqj?=
 =?us-ascii?Q?KrEPh0T38dD5Yxu4qy3KkBjjRk7EVe+aC/1uOlw5G9ZnC2P+1Zf+js4bRzv4?=
 =?us-ascii?Q?oIO2rEAp5juYoqS7kfR7jZRLIYmgxVcTrGGJHBaXhEsMYH28NnvlqxNyDsfN?=
 =?us-ascii?Q?5GuqW7KRh5WKEm97x/bhoadQamosNGXhr+wzI3vxpatOAk5EYDIB/UlqpDGJ?=
 =?us-ascii?Q?RCp6k4DrCRCq5A7fX82E1+rIFUxzqn478xtbLdOU1QuJsHf1JzA+0anAlmsq?=
 =?us-ascii?Q?I/lidpEJ7hlwqrOwapwFslW/2Pk5qSLNUfXDhV1e4bXF1/MYHD3MHmdblcku?=
 =?us-ascii?Q?xZDfWc4AfgjNwbTsMBQjYxacLMqUXz/zp47LrmA/C/n8/UqK4bmBrF8b3tH1?=
 =?us-ascii?Q?C+YQFBOqsIJ2mRXDCF290U62dZSMym28y+3UtcON6cjSAc/gYL3c2V4MiW7b?=
 =?us-ascii?Q?nkWip2JxYr4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m+FC5qLCHnj5KCAR0HR+8RapOLjTKibeZJqm8xKz8e4xvDbrW7kra8E/MiQ6?=
 =?us-ascii?Q?wSyZFf0NGGNikRFir+IPCwYfrEvtmn0AAZi/zzPpB2VvyMdgKydxoh9aC2zG?=
 =?us-ascii?Q?EtCnEQsfhXbyYK4q0q00ISNqA0zmHpKqOZNA8CTomc/3HmlBFGm7uZ+NrNRy?=
 =?us-ascii?Q?zR9y6sDDS9fwtNglczm139fXM6pU2ZHJC2wLtMJ+RyvFogOLhZmOBoC+3JvJ?=
 =?us-ascii?Q?7Ef8Gk74MZVTBALGHdn4b4rBGRxCogHeuz0YzqyUzmcwzSJrX/TIOzOprFsU?=
 =?us-ascii?Q?j7cdwNg1AAj14WnZRXlWv7fJvr5+3xelaqHoQYnl/m5ZX08Qzr13WM+kHZBw?=
 =?us-ascii?Q?pW/oRT6eMVjaliI45VGOjvZuVUXx9QJQV+pHlCUxgjdTwrLRBC0h7ALyKrev?=
 =?us-ascii?Q?rur5hY7U5Vd6V7dJZHG0yr7YkghRxKG4QMu9KB8Hmsvkg1Xuec1blgGkwDHG?=
 =?us-ascii?Q?QFthAYFhqEJ9Io/uun7jONdQe3mAv1kb0CU32Jc1ExODsAwLhXaAWXfkTkQk?=
 =?us-ascii?Q?kxD8Nqs0794ADm3/XIjhEPI+ZfwIhfHgJ9siFTSnv+hNMC/fFREzqK2BBnAK?=
 =?us-ascii?Q?xZkFvLlGBmO1ijGu7Vgq6clybeSnmODD/VWBtSCdD3n5IgEZECZLyQu1jGEI?=
 =?us-ascii?Q?4p7ZCnm36QTQnSshxc+D8CXMwfJNitKfAej3gh7kjzHN7GSwytQmPE6b3kvG?=
 =?us-ascii?Q?aiw7sXsSjpl5bbroE727YLK7lVvzkNT+azw63r422ASvwidUhDN5EilP/LqL?=
 =?us-ascii?Q?Ka0oZQKHb23qnOFtKsGTUYZZUnkEPGwXDrx0D0OOq8P8qBqiu5YOVdx+1hSC?=
 =?us-ascii?Q?4gwTyJRogHO2vNm2PPm2I4KZQv0S4iR9PyzBWIiJIqdV1nBVrhKRN8dvHdJD?=
 =?us-ascii?Q?5TU2/mM8XP9EtQAWhbU4jdioGjiBID7KFTRH5Q1eoThOj3w9NoBZVl/Bsl7Y?=
 =?us-ascii?Q?5QVRLENm4M/XL3KoZcobb4NE02Hy7FQ0PppIVQA+TgboLJqdE4G3Gfu+2EJb?=
 =?us-ascii?Q?IKSET6d8Ri/n+NkDcwtG8NMsxpsCInZxnTfySTGWDKDlEWg9j1Zbdn3I1qgh?=
 =?us-ascii?Q?PGtT6hbEIaVvP65YNNgnym8pnl6+ATDjp852qKAqviAed9/ZNoYSXNfDPMWA?=
 =?us-ascii?Q?vkZ55XX3FFcE6vBUcGF++uOSB3IPdbWcRyAc4l6gYdI0LGQfwPJR92ZffsL3?=
 =?us-ascii?Q?KBN0NL0lUfgsnty9y+3cqtGrA193T2xOKOGUFgy4hrVnZo+VWHGjirlaBAYI?=
 =?us-ascii?Q?5uoOVawro3V+VSNOUCh/Ytlmb19I0SF9ONnJuOdNi/VIv3qrMHE+Y34DGwhG?=
 =?us-ascii?Q?BURm6Y5I0EU9kB1WSibQi4pftiPm7JP/lnigPThUfq/Ss9Fq/BBnyJ+vtth3?=
 =?us-ascii?Q?wyReUWBsFbcr4qIK/KobJuT4u0ZDXNMWshQiQ+9VHTqo4JlDzjpqrPzg0E7H?=
 =?us-ascii?Q?ugDU72xC/nH9X9n8dcDXfTw9u/Q9MLVeGrRRtPReKbXyBxBWVJPVGZWMXi6a?=
 =?us-ascii?Q?ohwY8kTQAVIrh1OoyspyqUC+RGMTstAi15zRYO0OK0lE7fMP/y/x0aQZafuI?=
 =?us-ascii?Q?SSFLFCYBvL2/8LbEdcE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06b078a-708e-4a92-c85a-08dd51d5a9a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 17:40:27.3876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i86IHpBI5W0a+ccAxy0OZMNPdjWLVDxc4/Qt6EhzwInb8WD0IjJAY7JOSMTzE27rhxcw/mojhh8uPEVowBW/uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10272

On Thu, Feb 20, 2025 at 02:11:05PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> Nuvoton npcm845 SoC uses the same Silvico IP but an older version.
> Add npcm845 specific quirks.
>
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index d6057d8c7dec..c58440061d5a 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -133,6 +133,22 @@
>  #define SVC_I3C_EVENT_IBI	GENMASK(7, 0)
>  #define SVC_I3C_EVENT_HOTJOIN	BIT(31)
>
> +/*
> + * SVC_I3C_QUIRK_FIFO_EMPTY:
> + * I3C HW stalls the write transfer if the transmit FIFO becomes empty,
> + * when new data is written to FIFO, I3C HW resumes the transfer but
> + * the first transmitted data bit may have the wrong value.
> + * Workaround:
> + * Fill the FIFO in advance to prevent FIFO from becoming empty.
> + */
> +#define SVC_I3C_QUIRK_FIFO_EMPTY	BIT(0)
> +/*
> + * SVC_I3C_QUIRK_FLASE_SLVSTART:
> + * I3C HW may generate an invalid SlvStart event when emitting a STOP.
> + * If it is a true SlvStart, the MSTATUS state should be SLVREQ.
> + */
> +#define SVC_I3C_QUIRK_FALSE_SLVSTART	BIT(1)
> +
>  struct svc_i3c_cmd {
>  	u8 addr;
>  	bool rnw;
> @@ -216,6 +232,7 @@ struct svc_i3c_master {
>  	struct mutex lock;
>  	u32 enabled_events;
>  	u32 mctrl_config;
> +	u32 quirks;

struct svc_i3c_drvdata *drvdata;

>  };
>
>  /**
> @@ -230,6 +247,14 @@ struct svc_i3c_i2c_dev_data {
>  	struct i3c_generic_ibi_pool *ibi_pool;
>  };
>
> +struct svc_i3c_drvdata {
> +	u32 quirks;
> +};
> +
> +const struct svc_i3c_drvdata npcm845_drvdata = {
> +	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY | SVC_I3C_QUIRK_FALSE_SLVSTART,
> +};
> +
>  static inline bool is_events_enabled(struct svc_i3c_master *master, u32 mask)
>  {
>  	return !!(master->enabled_events & mask);
> @@ -1811,6 +1836,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct svc_i3c_master *master;
> +	const struct svc_i3c_drvdata *data = of_device_get_match_data(dev);
>  	int ret;
>
>  	master = devm_kzalloc(dev, sizeof(*master), GFP_KERNEL);
> @@ -1868,6 +1894,8 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>  	}
>
>  	platform_set_drvdata(pdev, master);
> +	if (data)
> +		master->quirks = data->quirks;

	master->drvdata = of_device_get_match_data(dev);

>
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, SVC_I3C_PM_TIMEOUT_MS);
>  	pm_runtime_use_autosuspend(&pdev->dev);
> @@ -1960,6 +1988,7 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
>
>  static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
>  	{ .compatible = "silvaco,i3c-master-v1"},
> +	{ .compatible = "nuvoton,npcm845-i3c", .data = &npcm845_drvdata },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
> --
> 2.34.1
>

