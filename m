Return-Path: <linux-kernel+bounces-564264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D93DA6517A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109653A5743
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0057323ED5F;
	Mon, 17 Mar 2025 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FNAJbArA"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012005.outbound.protection.outlook.com [52.101.71.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78649149E00
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218829; cv=fail; b=IGdvz2iU2+8GSXcXrj9VN+IkDSH80TdOPNPj5I/vmO6ewBZnORFQEppxpYH3lre8spC30s5pVHjZ+CAOkX+XzDJtT2SyBnmRU7yPLUww7GEL1Go88DpC+zws0jiqL+DsDrcCw8OK8zKWbE64sRyusi/Ld7P9e7PjMuKiemoaLbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218829; c=relaxed/simple;
	bh=czY+ZLI5gl/pr5u1OEHlhY/Hn3/iuaKcU2NW9TYDc5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eLiOQdKvzYzRslmiVwZmpHLtK6fBffZ1ZtFtbohAWt7ujd/Mox/90EbM6XjmecO5pCEbTn7NEgpj9Xy0wfA/ATuiXjc5TPVoIlA+dTUu3hhDPRjjF/nDDbuiejG455ynWS5i81bPQv7xtepkdZL3WRPS++1MKr0bwYwg+6DIOUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FNAJbArA; arc=fail smtp.client-ip=52.101.71.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XO0o2UDSgqcfX7WZvkm1hqH2l1Ku0WO1T/u+Q8YcE932Duqbdc+hXdJJdWWRPR/1SDSvi3A/qUqbA565S90W6R13y9r+m/wXeQk4tHWBjWSw1kTbBDb5nLwIqmZQ8TLuU9myDsuO7j6eeP0Fv6jQ6f+9T3zRt3R1SeTzsAp0n3IixlG6PaIiWaNeRPloMfRIIAm0Wxp6cC/1HerMvHBt++8q77viwnkQUMIzE3IQM7Bnm3iyh+NKyARwLYUDb8KMn0JqwHWjfRZQmEM73uCNY8TTbOJUN331oW9Mx5M+tvDk9voJriEBkv+ka6gvmVdf7gSM2mhbRpEZVNm9zNdFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mZvNOq2tpwVY9NUx11evuRx2b5QQoHHBrENX4DfQ2U=;
 b=oJdkcDAUKb3AAtrEahU/n6O1if8QPSwtDNgUjseVSb2ONNxr07meNPonMkk6fYqK4Pj2dRSOzibghE9qQmB3JLi1nvJXcr6PZWUh0OgG7nhtS1Er+kHFSsq4y7k1PW8BRrOmPPithhUhvXOgP+DZU6zUPcLzSvXdgjamgZ+erjfpGkIA2/1hcGohRCkjLcvo4nzPmvSMFyVs72Q0khmijqVrIFVOf5kxC+Wp016ZVlsmGgZACfvyP3745u6Sq6WdmAYxjtnLcCy+ABsRjUeFJgosHiGCnlG5TON9qkQn6Tnk3KJqDZAV/NxsnJfU7P3KLGp67MI9gyWQB3ymcx5ICg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mZvNOq2tpwVY9NUx11evuRx2b5QQoHHBrENX4DfQ2U=;
 b=FNAJbArASCUxPftTTQbnWRuODUJxKnCbYT6DDoLVwAstt04Yc27vlikxJcvRRxbiK5WvvhhDTklRXdmSdgnO1saudKFCXa1Q/uBDh6WndKGPc6fNmQYBXracBEeEkaimrQ5CJuX/7Xfvgy1p8NgleFcLiIqfsLA0tLVx4QKBFxPG2x5yG9jC+51Bf9M/78kKWA5gqy8gKQX+gryHj0HcyIF0eSzj08hHeXMsHLbu6p7lqJMXzVDPqY84ohO7e+aY9o2eeXZI3XWAMTubGAEYgnmyzOPpKPek1BDE3mHHVDVd23cZMj2z91nCJQM+99sDkuXFii4pohTKgEX3O+kF6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7435.eurprd04.prod.outlook.com (2603:10a6:102:88::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 13:40:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 13:40:24 +0000
Date: Mon, 17 Mar 2025 09:40:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v1 3/3] i3c: master: svc: Fix missing STOP for master
 request
Message-ID: <Z9gmQef79VYvyIv9@lizhi-Precision-Tower-5810>
References: <20250317051951.3065011-1-yschu@nuvoton.com>
 <20250317051951.3065011-4-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317051951.3065011-4-yschu@nuvoton.com>
X-ClientProxiedBy: BYAPR08CA0059.namprd08.prod.outlook.com
 (2603:10b6:a03:117::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 201a24d1-b899-4083-45d4-08dd65594560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RoS9ypZ2yhvNSxpcEnVV58a1mevh/6FZsOHVBwIJ2aQFWEP7XONHlusudsZp?=
 =?us-ascii?Q?XWIywTNSa0hx/6Xq/0MVav9tmX6xpfVrlMdwk1CKKM0LLBeNOF434gg51s0E?=
 =?us-ascii?Q?momdebnNCyGtMFxhDCLzOf3M+SpIWgm87W9NlFPuLbbtFNUFuLZPD6meR166?=
 =?us-ascii?Q?ry9TtAIm4vN/On2cktWZocBEV3ybjAVYACpsrEHXIeX+oLr0snh/48ogNW9r?=
 =?us-ascii?Q?CQsmxbuEXXG/vIaCp0L2fU9jnUZ+n5Yiokmrehmaa96FoJM8Z8BghkEt0zIV?=
 =?us-ascii?Q?yrJkmW2uekBR999uWUjBrBLFRac6cSCUooSngW9F9GIDU37jdlEiOtxI00Jf?=
 =?us-ascii?Q?aU+UpB9eZlHUH1sKyRA4p9dbJ626sCiWSRjdMisoGsbJft5RFOgx1+IbmqDD?=
 =?us-ascii?Q?r3B1Og6eW5/YmT/mpbmXoL87jMbdfkEtb8qcGHW1oXryXrw4oiIJTxpHPZPs?=
 =?us-ascii?Q?1la02F44W3Hstg5pyA0gJk44cST1tJ0wWzZKcL0Pt+5LtIV0o1eeEEY7vJzt?=
 =?us-ascii?Q?VO/VhVtICThzdv0wPjMhXQ5h2rZeREmW4aKcqGx+377XINmrgXsUl74Vnunu?=
 =?us-ascii?Q?R7HDhyfskfKezKdJ9FF2hASsczDOhv4/tGz7+7t4C1Hw9jKJIXpEV8m5tyed?=
 =?us-ascii?Q?8NIVCvzA63Rys8ow1ohlTdTvx18uC/zVI5BRXOjUq32A7//GbWslkXHj6lc2?=
 =?us-ascii?Q?jmI3HznoYOUaFje974G/vSBm3AiIBeAB1dvXiwoQACWR3LHIMwwQjUVE6shr?=
 =?us-ascii?Q?QVgqKVdxwX/w4nIggjzKb7Es2KGu+09LAES2g8x95LjZccdwahLv6th34CdQ?=
 =?us-ascii?Q?sXQ78atN+ZU7e3Cm9tVSixyHAcHO55WDbOcRuxfkq461rsCrwNDe5cPIQcTn?=
 =?us-ascii?Q?/KeGhrKkSUyjyBlUK+MjC9A/bB418Acs6tLzZdWLANNAXAy5CmAruDNRN4+E?=
 =?us-ascii?Q?iPc8G4m/sjZzA1k2x3Ipq+9XvJXv+dbik5E+NTJOxguoOO1ymmUo3++4KRyT?=
 =?us-ascii?Q?B1M3JVctcTsThPnHhCwxKkqlZJOvsvgNbhAnq0ZGVhfpT4GjJVSOcm4kIrMp?=
 =?us-ascii?Q?Zeln3XnNX6a+OY5njdVup3mecDnU0pKF2DinJG+hD59+77aUKphbiRB2LKgd?=
 =?us-ascii?Q?NZMCZNJuqYamKVT/AXx4S/q7OlJEsVkCO0x0y8y+HGzEQFhseqZp0AwsrHi4?=
 =?us-ascii?Q?PkFNn49EZAFTiKJmLjvGlcAyR/+IXttEWf9brmfFwA4y75dVSLXUDfU+22d9?=
 =?us-ascii?Q?GJj4Zp3yT0zxSvOHR5PLoXYCh0B/m5kX/D0acT33DSAP6ruOz6tQCBiWLT0K?=
 =?us-ascii?Q?pn8x37XbJvG/g12M2qRW8FAfL4wp+EDGuw7QKNjE+jwscAYUxA/astgv8LXU?=
 =?us-ascii?Q?zLwOLbjf/RQXOb+smbQIHBJn5yeucvnxUw0ik3tErGz/7EME1pazHolm4H7a?=
 =?us-ascii?Q?5XP+islwRz8uj7CpfOrCKwWoOp0TVShv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9DVmFzX+WbgHYDLSLRl92ZKL64rXGym8xDsFiFnYlGbPbMANs9TGpgjrbJor?=
 =?us-ascii?Q?xQnDuT+63Rpj1oeU/o45GI6wjaFrlXZZfcHxHjTrXxzXG1MWLN3aYdrWCw+s?=
 =?us-ascii?Q?bYg6JWJihjAns6OFv7P+sDLAW/xQfYFsnE5HgPlIQsqQtQaivIKjE40f6RM8?=
 =?us-ascii?Q?JLm2XeLSE7hLR0FXHHku/q3yQmyiPKEj3vgtGoi9vJBrgcDKdiFIb3upReyz?=
 =?us-ascii?Q?1V36DY/exyMHFM7bynQmVvyuM9BkgdvF/n23yBVbWRDjqqRNd6wbAQeBumnl?=
 =?us-ascii?Q?uRQeODRiF7Ycrac1qHA2/CxuS5c4Vx1XIZzWAzZkbcsv2PvQ6jOy0Rlryrf0?=
 =?us-ascii?Q?i8C/6oebSxUGdBRKUK+QSIvWqQrHPn2ib/Izi4BdgmesvnSIbL4wnkZrEEgY?=
 =?us-ascii?Q?met+5GUqpGb6wdRivMRS6jyp0Lkit4qeLQV1/vxqF57fw6jolGo2VPuW7DhF?=
 =?us-ascii?Q?yffcxrk1zmgWm8ubxcjiFN7hq8FqanFS0tBJPr6bMqNgOOKkEUTEf5YYCAnM?=
 =?us-ascii?Q?PCkYBKTejWOZIfNSHwy9JvW9582qNlVb0wTHBO4ChNF0UWRecWpoA3DZlD3H?=
 =?us-ascii?Q?Av5neOG4ff6xOVkNYdYLa8sYBBvTz9Nb37pmCE/16VDOFBmPoqzJ9t16GeP/?=
 =?us-ascii?Q?rBHJmmuEyLE2vTU+kEyvGsLqo+eOKYe0C+CJEEtZx/R4OerhzZuMwELsAeHG?=
 =?us-ascii?Q?6F9joPOGTLNoD+pXWWJTmblwQdwrjlV/88Z73Nz7zrqNbxIJksl/pMA9iD3K?=
 =?us-ascii?Q?9rWRqeU37T5MCQi3fu7/7ceIbKpScNVVf6ylrl9Z30MI6pEUBmif1YWFRmoJ?=
 =?us-ascii?Q?TdoreB7uIR92UvmAtVdm4+Orymw5b96Dc1t9ZkVEDFuJsWOzakTy3Tixantr?=
 =?us-ascii?Q?k6KtxsXl2WEpxGFJvZEAAUHtncu7fm4eFNLJZ90s5GeG7aKsp9+7YCTeGFNK?=
 =?us-ascii?Q?Vnbm881DqHWApB1IePFFpjcGbF3XZnFLg4CcGxmW1A99YUbl6qiwdMPlfSsd?=
 =?us-ascii?Q?Yn6bmA0JmBb6LMtR2czapSs3fSWsnjnW971AfzDXUKQWhtIIcMZT9v9Xbp6r?=
 =?us-ascii?Q?HaqjXudW1H/7mV462tbF8UH/0hNZjMo7L4GZmKqAIFUKybg9ch+EXKIJV0AH?=
 =?us-ascii?Q?Yo7pJB3sUcEFDvreSMenw06xV415GKJcKOvYijLjyiQp9+eeHNLZGKpaQDbi?=
 =?us-ascii?Q?guD2Il3ae+Ey44oL9DdMtpMx6Ty3ewrtwuu4wi49RZ+k4ss86P47StPLiytb?=
 =?us-ascii?Q?NcED+7H64RKOVZkog44eIms3ESXO28ej4tpKV6zc4hk29tKCpVakc6s/LmRf?=
 =?us-ascii?Q?ocUhBlH7BrAimfMKR+3HlGJR/p4k0lRa7mDnBiY16dths0Y1nqC+bEvcDk32?=
 =?us-ascii?Q?WWH+nVBxDXAKgrm/dM88L16/3NPFbdvpnseO+E0eFLqUEFVGF6czNqJjJ8Pn?=
 =?us-ascii?Q?2OVuisujlVBavr/pZI+tmfo2CZfWAt+WQ1jbmUi/ohpzyyzFq5TYU63unzy8?=
 =?us-ascii?Q?bcf6Wr0FAbJrgxIPn2OvL3BQymK0EO8+TkNJntVmUWrycBsDh9jFRz6WqwME?=
 =?us-ascii?Q?utWs0CtUZLbJjF3pLmc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201a24d1-b899-4083-45d4-08dd65594560
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 13:40:24.8391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDfU/4gK3PjnzZdPoAU6cRci7pGvOLjBbKZ5zZIQ9Wouy3ZThZc5KFf56aj2ra6OVkVX1f/MPUkUgI6XBCUT3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7435

On Mon, Mar 17, 2025 at 01:19:51PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> The controller driver nacked the master request but didn't emit a
> STOP to end the transaction. The driver shall refuse the unsupported
> requests and return the controller state to IDLE by emitting a STOP.
>
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")

Current framework code don't support master request. So it is not fixes.
needn't fixes tag.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 57b9dec6b5a8..e0cd3ce28b7f 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -592,6 +592,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
>  			queue_work(master->base.wq, &master->hj_work);
>  		break;
>  	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
> +		svc_i3c_master_emit_stop(master);
>  	default:
>  		break;
>  	}
> --
> 2.34.1
>

