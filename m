Return-Path: <linux-kernel+bounces-286915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E459D95205C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4780BB2414B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3A91BA861;
	Wed, 14 Aug 2024 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hpOPAdLI"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEE41B9B51
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654060; cv=fail; b=Hi3eKMd1NxTIw7lJBBSc0FZlJm4/UzFTo+GDIQzZOfo8l1H9H5ms7ZTPi+wbmwgUPqjfl7wreN1DgGpzCpxXV1zkVzqUPmeWRIGA6qjoGG8J0nmyNy1W5ViNT0O+8/5oDPWe6OEK1blrPZL6A6G1SlEWVlZ3U5lpPBfPwJwlyzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654060; c=relaxed/simple;
	bh=XryEeHjrhLYefSLFydrLheVPDGfBelZCZjTKivg2fHc=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iEo+YatYG5Hzkj/M9DeFnAj8j2nnYttcecd6XF9XeknbXhzTOuGeD19OfA8mJb10OKj0fnmb7hTibkdMODC96uKLNLLz+R4rOJ7qoIblmOI2nun//6U+aOjH88dLKvsfoG8QpbROQoRroE8Aw4ibPg0hj2SHgZo5iKmfQv1nGZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hpOPAdLI; arc=fail smtp.client-ip=40.107.249.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAGmALkU/X0EJYGoc9CGbQBI9LH21mVDYM5No2GOR0eB08GmIWXhFbkVUkYrMeNZ8RMTpbV8FApO0qiqL09U2E9MG9pyER++FtL2UsY6UrzkWWoC6aErzHxxMRJ4bPKIjR/Uv14VgbF+1ve4l8tleUV7Bh38XJq45FwUywy46DQTZZiMudr03YJxwom6tuQiRWCeny/Y9Y0x430BHGerbBUstACpAzVCrg5j7fDRVcsARE2oUExysY1qM3rvNk0t0wTeJa5SzEfDSFCU9wlk7dBadLIkkp2cMOUNUbNQRk1K6pv/tsA343xrb+X1k2t9LYaVT/RLQSJY+t3xAKY1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBV4szsV3EKaBC5CTgbe29q084F55+Q2frtgx/OtFjM=;
 b=ga1S7EWaHJYnuTC3B7/ui+L9RHCaNdW8SQBW2HGvgGt1fDh86AhKN3v1HWJ6x4wEsT9P/TE14pSx5r0BwuJkyRQLLOP0n/1cCXZQ8XXxOeJiXDy0Rj96/wDsYdDm3JhzcjwJx1ILXGwHan1LsKCY55eXUdAivf2SXxIve6rme2+GGomJC6444Ar6q2O1wIsEgKgCaXptxt+wLcJbwXhrHB73YtM0WS7mnKcJZ7q7rvmT2v76XidTf7EqSThr+5XhWqNiwxfwpwZ1hFf+GHMEIZXdQDB4b8Sh6QHji1QUPp7cQ9QfxoZoJr3Srq06GCl8FtCxvkZBzlyF5V3aHroEpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBV4szsV3EKaBC5CTgbe29q084F55+Q2frtgx/OtFjM=;
 b=hpOPAdLIP/W0u6ROAz/xkSBgbH1SEpZL4JDOKBC4ES+P9vDkkhdIblgXb3i39FYl3nPcmodKZuiV42GJ5jwGPdQo3Erv0I5D1/zr55d+tWMFv0McAVL3AgXDYyMFCfd3ZjM9xd1AAb2wEjQ4U0aK2/vWebnN79rtZqNd6k46CxopHpoN7MstVptLr58hfQEbn0uDx8R5yNMVmgWXzuw3W8FG98iEcvEnK6vFLLrjFmc023Gn7XvRe+aRKRX9BCWfuoIYFK890BFOipJr5aPNjxnzR7JywynUBVwVOpgY03OZnacGccsjrBCmnIIfNnpmKZvCMT7Zxssxn6PeYAlxrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10229.eurprd04.prod.outlook.com (2603:10a6:800:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 16:47:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 16:47:35 +0000
Date: Wed, 14 Aug 2024 12:47:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	"open list:CLOCKSOURCE, CLOCKEVENT DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] clocksource: imx-tpm: fix return -ETIME when delta
 exceeds INT_MAX
Message-ID: <ZrzfoQdm7MzQlFX4@lizhi-Precision-Tower-5810>
References: <20240725193355.1436005-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725193355.1436005-1-Frank.Li@nxp.com>
X-ClientProxiedBy: SN6PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:805:66::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10229:EE_
X-MS-Office365-Filtering-Correlation-Id: c00b3364-3fb5-4cd9-5f1c-08dcbc80cc9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	a4kicIQenqxQL289Citrynh+CxYrkfTAwCnJxiQZ+RoaYz7eIvZFCCyKXOpHvCW2orVpgkmoAqMmDy6/SysPrANYidvQ5J9t+1YmD/C5eQpJ38tBcsCRHkMm8kIenVFkujVJ/lPedw7sbkgBzTh3QqYAkA+egpAEBKvaDhT7f+gNVjLa2lZUHYDXAdzuO9FmRYe1zcgPExypNeX/niF4+J5EbHT9aWfDC+61iieVhqKoPRcvKAdj2KUWtrVpKTl5ayIfqNthd9pCgnPrnOgro8r6cpb/wgoKyOE6umIO10LLno5E2ffyG7np5xqbigRGaTvipTbOo5HdiggeaztdVTCDsIfbFCSWgz1ziTwZtMSSZYQWWzSKle8GB38A7EtITvm4JNmu+prRCC3tHpi9hMvMt7L3EnMR68ERng2KGJAkivKpTNuRiLAKpjyT1pH4iOYx733G8zC5EYcXQggAJTcZT6Ykl1LicImQd114cpMjuTZGBAFPeTgbMKAPRIms5nRFLhBhN+DGCQgdLHMvAS1eTcSPWxUTzCSVU6jNHBVW1oK9tIH8sOhTaZPrhlPt9xLOCK7rIDAw9VAKYuGvfRdTgYkXuoWArEW21DxBXPsU+5SGw0ox5agE+jifGnMPXPJEuh9JSSNh5A3rlAgNNlQFUpJuBbMWwNJ4sKCpKMSaX4ot1h3aIWzvkF/4TjIiPpga5vrSnyt7Arln0e2CcY/X0gI7qMmkEfHgU2++xDo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5IsVYNZJwCg6JbeQ6iMtY3zSlnANuyIe4YLBlzB/4IQmqXLqGN+shlCoWYv5?=
 =?us-ascii?Q?mon722W+bYaH6Ut0ys9g3khl8hPnVyDtbDfIGxtOxWMucIkkaLiSRIkHKjFq?=
 =?us-ascii?Q?hecFcQay2YVjAOHv0NTCVKTf/wraihNf40vhnRLc3bMETCkJjFHpuQlONkFU?=
 =?us-ascii?Q?3/a2jcBkxpDdSH1VA2bN5u1+7srApqOYfZo6CKPrFaqSTu35mvU8ewnHblct?=
 =?us-ascii?Q?vfbU7D1HLHk2m05u1SOW9/op/9YmoGTuYqdU128hDuOtMTdb06EQj88xTVgv?=
 =?us-ascii?Q?ScHoX0+ipuw+A7V0TOY+6mvH2SRxkPfOvlGLfzXIqE6xxYw0A3YIcX7TQYFl?=
 =?us-ascii?Q?XTxG7Qd3nbPssO8h6sUOXGRNW2sQm8SItNf1FPrMt5fuIhcVqyqp1XPETRpM?=
 =?us-ascii?Q?a0V+L249QsV0cc8TQyPPvQ404Vqs2ASfE/z7I6+4kYjw7XyrdaYyroeD3FTv?=
 =?us-ascii?Q?mP9p3b7s6dcdQHBm2BGGOax0+Zhi0hB3mf3yCV+6v9xftH+4EsmpeyD/LJUS?=
 =?us-ascii?Q?Sb1a/dUHDzl6DFY8tS11/mu/nx2YEAr1OyFXAI10TQegjDCCbxupIgiRi9dY?=
 =?us-ascii?Q?SrVyTImSJNG6KHcG+oGJrLwuAf7VvgCmG0nzgz/Ofivwsuqz1ZS2n+vQ/Rtj?=
 =?us-ascii?Q?/bUdkffvGWrl/slhR7hnjCcMJShIRmb9TYbUZDWKMFnLNalN54w/XnlPY89A?=
 =?us-ascii?Q?qlz2JsBgb0kbbHqAei1I6zg4yiSAnmrFBE6fOLozCbhY56NKYKNR/jjn/pKF?=
 =?us-ascii?Q?e33d2qA5X1WLzIY9EVMJf+Y4liIdHNBkznU0SBreN5XDsWEhBsf1pkVsQWvd?=
 =?us-ascii?Q?/rq8GBvZU3QpenshVPjeW6xMAgK5xecNJEI7HZx6lcdC82uAuelNuRFTAHe1?=
 =?us-ascii?Q?pdq9j7ceEcp8K38maDXIlmmglp5MEPOLe4tWZHSa8MKmjTSxAcj8mWzIDLVH?=
 =?us-ascii?Q?Y8wCcO075/PvpYc6cu/jm+kUKVCGW9+daw03GLyvhufylvLBXg7LFhacfSZd?=
 =?us-ascii?Q?wpVkBoe/GfJGTEoXINrabCxyVRZ5SQRTWRG01JTtyWi0D/7Ecao/la4ZLMKP?=
 =?us-ascii?Q?xI5sqOmK4pjFdnsCNE8QJEUX2yE4XtEeps5es7Js3m1f2/eRKpLYAgLNefhJ?=
 =?us-ascii?Q?Rw57Q43DSz4yLo+u5++yg9jU3Ov/W+l3DcPwyaotTebPB4mBviAjcO6Y3oxi?=
 =?us-ascii?Q?y8/NNMHLBqcYW+T3ey99Ih3fKn3/DzKsq/G4C0FCRT8sTBnVgFaP03Fn5JFF?=
 =?us-ascii?Q?RFlu951R8TuxV3XA1bsqF8flpMEwYWqJ23R0n+f+kAWRe52+1ZqLfckqlCUw?=
 =?us-ascii?Q?N0Z86M+Kg1OTOGv6o6HOoUj5nEnAnEB/KE4mKAfdRNYKGH1ODC0J9PsLGgik?=
 =?us-ascii?Q?vpX3a1ovZ0nm44nBfyKYVL6Atnx+oz+L6x57PThAmTkLFX6RR2y0SFeO/4va?=
 =?us-ascii?Q?8TKHJnr+ZmnWqJXtyCveuHiFLHsUaurmALFkvXDdzV/NnykjJOOszaiQMIh0?=
 =?us-ascii?Q?4lWqsPgafkpJO1pXDtrCZVKctDwmEWIT8uIBi1GRNnnIBnVqSLzxz1m2x0hr?=
 =?us-ascii?Q?yB20SDW9V4xkab/rV7xp/vvVxcHb3kQ00ryGSxR1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00b3364-3fb5-4cd9-5f1c-08dcbc80cc9f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 16:47:35.5718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L34eoY669dMknZBrenuNsgz2fIroFgEKKjDaYpAKqWZbPY3zV7+0lwAVDiLFjgx4QCmTMH8M6XsbjlFw10ZD3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10229

On Thu, Jul 25, 2024 at 03:33:54PM -0400, Frank Li wrote:
> From: Jacky Bai <ping.bai@nxp.com>
>
> In tpm_set_next_event(delta), return -ETIME by wrong cast to int when delta
> is larger than INT_MAX.
>
> For example:
>
> tpm_set_next_event(delta = 0xffff_fffe)
> {
>         ...
>         next = tpm_read_counter(); // assume next is 0x10
>         next += delta; // next will 0xffff_fffe + 0x10 = 0x1_0000_000e
>         now = tpm_read_counter();  // now is 0x10
>         ...
>
>         return (int)(next - now) <= 0 ? -ETIME : 0;
>                      ^^^^^^^^^^
>                      0x1_0000_000e - 0x10 = 0xffff_fffe, which is -2 when
>                      cast to int. So return -ETIME.
> }
>
> To fix this, introduce a 'prev' variable and check if 'now - prev' is
> larger than delta.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 059ab7b82eec ("clocksource/drivers/imx-tpm: Add imx tpm timer support")
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Jason Liu <jason.hui.liu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Ping?


>  drivers/clocksource/timer-imx-tpm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
> index bd64a8a8427f3..cd23caf1e5999 100644
> --- a/drivers/clocksource/timer-imx-tpm.c
> +++ b/drivers/clocksource/timer-imx-tpm.c
> @@ -83,10 +83,10 @@ static u64 notrace tpm_read_sched_clock(void)
>  static int tpm_set_next_event(unsigned long delta,
>  				struct clock_event_device *evt)
>  {
> -	unsigned long next, now;
> +	unsigned long next, prev, now;
>
> -	next = tpm_read_counter();
> -	next += delta;
> +	prev = tpm_read_counter();
> +	next = prev + delta;
>  	writel(next, timer_base + TPM_C0V);
>  	now = tpm_read_counter();
>
> @@ -96,7 +96,7 @@ static int tpm_set_next_event(unsigned long delta,
>  	 * of writing CNT registers which may cause the min_delta event got
>  	 * missed, so we need add a ETIME check here in case it happened.
>  	 */
> -	return (int)(next - now) <= 0 ? -ETIME : 0;
> +	return (now - prev) >= delta ? -ETIME : 0;
>  }
>
>  static int tpm_set_state_oneshot(struct clock_event_device *evt)
> --
> 2.34.1
>

