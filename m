Return-Path: <linux-kernel+bounces-347950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB07B98E099
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADEC1C2358C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB1E747F;
	Wed,  2 Oct 2024 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NlbSaCH7"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3E61D0BB0
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886217; cv=fail; b=D0A4LcAfJ2OZVV7vFuRMl538/q7vC1s1rzrIgbJ3MXnl0JeNpGgtcVGd+8zxuyAP3r0uFp2gsheLYcAN2zMlJ9SLtAHhwg8cpXDo15fa6eaax/9d4/8zM6aLkU6/fjndlthJHYk6fFatxZp0xtn6wNj+QQHTvb573VTXRaP+NSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886217; c=relaxed/simple;
	bh=ECdAQRLToEZPsIQKA4dxRs8Io3zoQQft13mCFmBBF98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BJ87FZYLvFat15TNGQb8ccWWr4YbvFRCfD1sYRuzH2jccAebkm39IdFno01AIM48a+nSqMssOGJ+r1fw25EUuYBgZa0NGxdYMw40EXNa/Sxs5t4OETxmD95wkoDx5i3FmD2n0dlFueKpUwBtw0FnH/mHbDszowQ+kU5z7Bi/XgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NlbSaCH7; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfgUyZh3afNDJuCcBwi0NYfDHXRDLs3hPnoEE1pqZzDq9cwjOn3fSNGIV3xNENJwa6XQuoyVAT/PXAvGpQF7STUhup/1ZL27am3uv/96/iUIJgLlDKW9YC4xMblFVuC3ZJzfVmgESaNqBDRwwpqigTaqeQENV5wyaWzgWvOZwaeDCpYAVYAaEY2SygPhLRB0sP3GRzZfZvo/I5onJMOeDS4dGuzKyK1fVfrJV0pS74jyoj6kzIm6O1SITId1ybLxMCBbgQPg0LPxisheiwVloDI5zLgp1FRLuRe5/K1xgIaFr+c7wqUw3HYgWL93AvlDpR4Le8le96PChwSsXR4NhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+ObNRdJMUscD2H+aBd+nzbAm7kbO+d2AFxjbiY2zas=;
 b=NyeCjQO5dma+gb/lB5w5Nkrv4cvbuMe1zNHz67A3Pz4Azk5gRKdHCZvoAHRiLq/zzjgU0Y1SCIDLSZVd/7E6BhVXXsGoJWB3AlRJc5rwavOr8wTGszjzLnrHofPMRBPpx/y6kb9LTPXSjeFPshO2B7/s+Y5Ki4hsdGUSxDZXULrdNhjNE6m5uT+Hds/sa1zoxQLTJf+BKueJJp9eeiAGjauOuwFKZBvDyeWeDPhYnun7Gt9Wdc1oEE5rQeYKjWyAEUIUq9OJIgEvkoTgH3UOy9t/7VEyJBCEYL71EwRiSPy5yi2MD19dySGXs0Lp3AAC7nsmBYcBREIdzKoFY5iYDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+ObNRdJMUscD2H+aBd+nzbAm7kbO+d2AFxjbiY2zas=;
 b=NlbSaCH7DH+J4wEzNFCfdDUrQXEFkdhli1NXLItTgHlnZ6vxRnSZg4NRyEwRBXgOR3phtGnQEImPb0jd3HYiddZ5omcRE0/YQuEzdhzwWr7IQkmh4PPpSjhVy8gVK+w9CJMbtmo5P5aZCvzDM/8oeWXrIWVADSFfTmovBRygO1ekPYVMjVRnZsJRfp6RqZbOTutzuzZ1wjsAbfhXp+RT1uo0UO6sc1x0Q6yMy6fjf/wAhcYP3VHN+fgcuDlCo09jAxV56bbsg/QWr6qr2UArcVuGWM0hLWIatnU1leim9pILqI2kIvlo9FQe4TKF2s/zYXkXd8nDcXG3NBhenD+cFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 2 Oct
 2024 16:23:32 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 16:23:31 +0000
Date: Wed, 2 Oct 2024 12:23:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Han Xu <han.xu@nxp.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, imx@lists.linux.dev,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mtd: nand: raw: gpmi: improve power management
 handling
Message-ID: <Zv1zfJVzg1GYnzeA@lizhi-Precision-Tower-5810>
References: <20241002153944.69733-1-han.xu@nxp.com>
 <20241002153944.69733-2-han.xu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002153944.69733-2-han.xu@nxp.com>
X-ClientProxiedBy: SA1P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::24) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f16612-2a43-45be-a6ca-08dce2fe8dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bPJa/TFp8F6IxdJHbhlzPnzhRzehymXxIr8v1/z0BxAXQiw4P+KLm5wRb0rD?=
 =?us-ascii?Q?3rUmN2TA/tVHGDH2Qn/2RkgdSP0X1SmpSttugB3W0mpBz6oSldVMgGYxzajT?=
 =?us-ascii?Q?Qi0QqhPaP5JT0A0rlZQC/OVHd5vAfjHzQs+27xm9VOQSTAXpRplP/s2gyfxK?=
 =?us-ascii?Q?T2M1LBru56R9Q1ESVvk/Bb9SYfKuUc3hzxFgud1j6Y85Rhz000/M14MhN49S?=
 =?us-ascii?Q?zMaEgCtZ/xW4hGVimxVrU6AuYOO3tD9mkRz+M8T2Mj078MM7j3oH7u/vE4nc?=
 =?us-ascii?Q?i2OvgAiyniDDrZ7klK99RSCia9p7WdqoFCU78mDlZwv+gHYD919tew5EW6XB?=
 =?us-ascii?Q?ClCGe/2ZQTZJVxbi+Y1kQVZsl3YYFLmCgf9f9VqULooKx4w/QH1Bfv0+IQJC?=
 =?us-ascii?Q?3YUTT4BiUQ9PqYQKPawsjq/sORAe7rl3E1xGvr3VuTKIJcb73TjayYFqixt2?=
 =?us-ascii?Q?bWsWYIFpmmN4KHU0KUSjiLK6A3Ssti9Qm4B7otSP7S65LPsg8mHE5d19Ez08?=
 =?us-ascii?Q?9CDoSDKJDZFkFjbMXJIA/4+ILQnHiVHbC7dZS6YI0baBXwvF+XGd2VOVxx50?=
 =?us-ascii?Q?5Ks8nCIiBIwE0ytu9gz+exbmyO83oKtXYRE8/pdIopW9X/Bdph1W3/eTnpyN?=
 =?us-ascii?Q?b6VpQt+EbPoPzrRr+d2RW5Rmk9oXwOgX9BoMYiq/FJwSMeuPNNQ5voPI9nIL?=
 =?us-ascii?Q?7gwEImp+RvCoKJvn5mvV0Gs2UvoFi2XbqH6zm6sQ+aYkQVNr9iSILHXuil8t?=
 =?us-ascii?Q?w/M9WKqTaE1Pa2kClx2+K3qvuCXZPQVIKFGt4JcsH0HHITM8CDBM/Z6F3XqS?=
 =?us-ascii?Q?Be5rAdQY/sb7wn9s/lk1DcfTKKi8WYz5toN+0t+dN4cNnoqYTMR6ZVLkHyn2?=
 =?us-ascii?Q?kgEase85qR8yNx/UeepomtkHlYAIeClrPGRulHftoZekN2GCi/FmP+6NDOP4?=
 =?us-ascii?Q?32qhjjQJbB/HmHvGaa5NOiXZ7Jc3IlGLNg2+K/cLMoJR1UBj36uZVDEo9VED?=
 =?us-ascii?Q?Jowx7HcPkcskfxwNmzAhIhooDm3vjURMeAgsu5KPidrzPwHCbf+AK6Y943GA?=
 =?us-ascii?Q?HYy5Hi4Ymg6qdZ7AayCZnad90gPwxsuMHxeNfpLyqCNXw6Mqjg+jSoURoq64?=
 =?us-ascii?Q?Kl5NV5BE4uj02meVKFeZ/s/u9GjxAO53fXskVlm0blIrSw0rgiix9CASzDKQ?=
 =?us-ascii?Q?BxtfejE6G7jQcrEtV1Jd59LsTYWUcmYP/VJlF7VA5RfVnDfCQRC5SJuo1ryF?=
 =?us-ascii?Q?+aqNhxLM/YLns005VcSnMvTegRU1zAnEq9n9k5HPUxjZQMdwEC8zHCiWLDKV?=
 =?us-ascii?Q?CXx0TW68StYlHJJbYns8IzA9MygNv06Lc3tPlL3kziyLiQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vvcgaEamzuijqdIRPO5GvNNy+tGdFt6sZ+p+bTW84Z1bIbbIcjiw3BmN4u9g?=
 =?us-ascii?Q?JpWHf56ci8MjfNG4pozNntKLCHHaNtbL3W5EcZjHcQ7UMQ4eJnLYJ1Gc6DeC?=
 =?us-ascii?Q?H2BJrCekYuO3NjtttJIMDla7HlhjO3tLJqS9pUp7pM8hUecUgzZDBQSPjbgD?=
 =?us-ascii?Q?BGgERplAlu5MJ3/FWINoffCjxoi7HBmouLNvyP8wJN5i/tmrKvKSl0aZicmC?=
 =?us-ascii?Q?M8Sj29VIjz3+UTCIejCUJrgQcOxshvEBeEHpHrcODL22+fZfeLOxrgHAiFpo?=
 =?us-ascii?Q?nbSrtSLqgalt4m9H83cJKJndbYhJeq9S9602agDWhDM76SnBUOJzW6QjPgk0?=
 =?us-ascii?Q?EGIbbU4Wsic+85u1fwjjB+Ppk/0eUFITG4jMqVUUz0KlSGt83fAQ9Lc9RDVb?=
 =?us-ascii?Q?rWBYY/cDhMMOJe0E20nh1NZFjJqgUK3Rfkh9v4Qg6Zsvpd44DTDJqTTw9iPH?=
 =?us-ascii?Q?OdXHmYX7+GpssA1gX4/2NpVyM3pzGH9TRrGUbo1Ux0sTorZwXVNd8JcxMvta?=
 =?us-ascii?Q?VSUkSDnv73x0tpNY8fvb2kxZOD4KeTVEESsRcv+w8ujZhp2g1gTWQMTvgPgK?=
 =?us-ascii?Q?NPiqRyWzmctEdufC9SyP4g8d5p78MpM0qno7diXYo2wGBiUjdqgEzpvsG1cY?=
 =?us-ascii?Q?94CcBBhCZiC6M4WQBpG71Vcc5F5YirQjECgUn/PfsNFrT62hZMBdrxDbBxHB?=
 =?us-ascii?Q?HXIGQ6fOmLL4d2IhVDxEXyU/6PuAc9URoUpT1SA8m0md1E33f2WlSDQB5e1k?=
 =?us-ascii?Q?YHWYkKGh0krcOVQAf8ERHk07bhWRf/9ak0Si6mf5DB4GlPMn+Xko+rzqZIPw?=
 =?us-ascii?Q?ZFYWg/ihAFAEypPbFW+YJDNbid9PdcRdM8YDY9bunw1f/rAx5OPGE1RzNJ5W?=
 =?us-ascii?Q?cnPEIxiKcZ0CIyNF1WTyuy5kvqnE4OHYiSLLH4L3qpJI88Ezdckp7n1x6b1y?=
 =?us-ascii?Q?U0FBKmCgISc0DH4ro+ABDxD9IBpG3edZReBjYk6hFyuSFyrVTTf51gcZ7CSR?=
 =?us-ascii?Q?s0vV82m8MxymBTd/uuNHOURLMNHuDTr0Fo1guCnmydinePodOHf0I4/a/Fcu?=
 =?us-ascii?Q?X64mFLMDGJldHffUgg0gOP9BjxwMaMbiiYIXJrftjSfXdOdWsjnLfqBx9kYY?=
 =?us-ascii?Q?Kmax+mXSX6BBeg4esnqN526w4qUenQhx5shrJtppQPinCwgxAg0Dhl4aaep/?=
 =?us-ascii?Q?l1V/NFRD/maCOgJaBgIxdZ0jiHJD/iou7UZKsXOlyI4w9B5s1T3vKEqkdY8N?=
 =?us-ascii?Q?qXnKuXK+QhozVLpcF+mR10VRnAGUKk3YSoUG1MfKtruL5O2FDF4DL6EOHEnF?=
 =?us-ascii?Q?iP7tMmUq7imf/mh6BzwXCCfvURqsW9dlPmxaeNIMBpQ/VnM1R9L7HaAW0Pnu?=
 =?us-ascii?Q?MuaBNvatP3s0kk4A4XLynXc8gBKR8b26KbYz5+MppTBu0UBlEcnTz9l1tIFq?=
 =?us-ascii?Q?S58nfFX7WSSVB4zXAJJ9cn1wcyxqSH8n4sOgm3P/BN8QL/ju4qHvIHKZwVi2?=
 =?us-ascii?Q?UOUCPJPiFe5acmvhPXdRojb67D5BLYJlnur3giujn1IfID9x34345DYyqTwn?=
 =?us-ascii?Q?GGSBafKVFmU7tFIdzswWtWfp3k2beuev5GZ7sddF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f16612-2a43-45be-a6ca-08dce2fe8dcd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 16:23:31.8291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36SEECIX7a1Oon3IKoplI7yAI6rgpUB1Gg2oFqTojTZl8zAyj6v/KumSYm888y692gK15gHelA0sLxF0wtleVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720

On Wed, Oct 02, 2024 at 10:39:44AM -0500, Han Xu wrote:
> The commit refactors the power management handling in the gpmi nand
> driver. It removes redundant pm_runtime calls in the probe function,
> handles the pad control in suspend and resume, and moves the calls to
> acquire and release DMA channels to the runtime suspend and resume
> functions.

Use  imperative mode

Refactor the power management. Remove redundate pm_runtime calls and pad
control in the probe function. Move acquire and release DMA channels to
the runtime suspend and resume because dma engine use DMA channel used/free
to do power saving.

>
> Signed-off-by: Han Xu <han.xu@nxp.com>
> ---
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 66 ++++++++++++----------
>  1 file changed, 37 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> index a7d79679248d..76e4b89e2451 100644
> --- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> @@ -15,6 +15,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pinctrl/consumer.h>

order by alphabet

>  #include <linux/dma/mxs-dma.h>
>  #include "gpmi-nand.h"
>  #include "gpmi-regs.h"
> @@ -737,9 +738,8 @@ static int bch_set_geometry(struct gpmi_nand_data *this)
>  	if (ret)
>  		return ret;
>
> -	ret = pm_runtime_get_sync(this->dev);
> +	ret = pm_runtime_resume_and_get(this->dev);
>  	if (ret < 0) {
> -		pm_runtime_put_autosuspend(this->dev);
>  		return ret;
>  	}
>
> @@ -1301,10 +1301,6 @@ static int acquire_resources(struct gpmi_nand_data *this)
>  	if (ret)
>  		goto exit_regs;
>
> -	ret = acquire_dma_channels(this);
> -	if (ret)
> -		goto exit_regs;
> -
>  	ret = gpmi_get_clks(this);
>  	if (ret)
>  		goto exit_clock;
> @@ -2761,15 +2757,9 @@ static int gpmi_nand_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto exit_acquire_resources;
>
> -	ret = __gpmi_enable_clk(this, true);
> -	if (ret)
> -		goto exit_acquire_resources;
> -
> +	pm_runtime_enable(&pdev->dev);
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
>  	pm_runtime_use_autosuspend(&pdev->dev);
> -	pm_runtime_set_active(&pdev->dev);
> -	pm_runtime_enable(&pdev->dev);
> -	pm_runtime_get_sync(&pdev->dev);
>
>  	ret = gpmi_init(this);
>  	if (ret)
> @@ -2779,15 +2769,12 @@ static int gpmi_nand_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto exit_nfc_init;
>
> -	pm_runtime_mark_last_busy(&pdev->dev);
> -	pm_runtime_put_autosuspend(&pdev->dev);
> -
>  	dev_info(this->dev, "driver registered.\n");
>
>  	return 0;
>
>  exit_nfc_init:
> -	pm_runtime_put(&pdev->dev);
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	release_resources(this);
>  exit_acquire_resources:
> @@ -2801,22 +2788,23 @@ static void gpmi_nand_remove(struct platform_device *pdev)
>  	struct nand_chip *chip = &this->nand;
>  	int ret;
>
> -	pm_runtime_put_sync(&pdev->dev);
> -	pm_runtime_disable(&pdev->dev);
> -
>  	ret = mtd_device_unregister(nand_to_mtd(chip));
>  	WARN_ON(ret);
>  	nand_cleanup(chip);
>  	gpmi_free_dma_buffer(this);
>  	release_resources(this);
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
>  }
>
>  static int gpmi_pm_suspend(struct device *dev)
>  {
> -	struct gpmi_nand_data *this = dev_get_drvdata(dev);
> +	int ret;
>
> -	release_dma_channels(this);
> -	return 0;
> +	pinctrl_pm_select_sleep_state(dev);
> +	ret = pm_runtime_force_suspend(dev);
> +
> +	return ret;

needn't define varible ret

return pm_runtime_force_suspend(dev);

>  }
>
>  static int gpmi_pm_resume(struct device *dev)
> @@ -2824,9 +2812,13 @@ static int gpmi_pm_resume(struct device *dev)
>  	struct gpmi_nand_data *this = dev_get_drvdata(dev);
>  	int ret;
>
> -	ret = acquire_dma_channels(this);
> -	if (ret < 0)
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret) {
> +		dev_err(this->dev, "Error in resume %d\n", ret);
>  		return ret;
> +	}
> +
> +	pinctrl_pm_select_default_state(dev);
>
>  	/* re-init the GPMI registers */
>  	ret = gpmi_init(this);
> @@ -2849,18 +2841,34 @@ static int gpmi_pm_resume(struct device *dev)
>  	return 0;
>  }
>
> -static int __maybe_unused gpmi_runtime_suspend(struct device *dev)
> +#define gpmi_enable_clk(x)	__gpmi_enable_clk(x, true)
> +#define gpmi_disable_clk(x)	__gpmi_enable_clk(x, false)
> +
> +static int gpmi_runtime_suspend(struct device *dev)

remove __maybe should below previous patch.

>  {
>  	struct gpmi_nand_data *this = dev_get_drvdata(dev);
>
> -	return __gpmi_enable_clk(this, false);
> +	gpmi_disable_clk(this);
> +	release_dma_channels(this);
> +
> +	return 0;
>  }
>
> -static int __maybe_unused gpmi_runtime_resume(struct device *dev)
> +static int gpmi_runtime_resume(struct device *dev)
>  {
>  	struct gpmi_nand_data *this = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = gpmi_enable_clk(this);
> +	if (ret)
> +		return ret;
> +
> +	ret = acquire_dma_channels(this);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
>
> -	return __gpmi_enable_clk(this, true);

It will be simple if

	return acquire_dma_channels(this);
>  }
>
>  static const struct dev_pm_ops gpmi_pm_ops = {
> --
> 2.34.1
>

