Return-Path: <linux-kernel+bounces-574313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56BEA6E3BA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0631C16C24D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D912319E99A;
	Mon, 24 Mar 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gxdk+p+5"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2080.outbound.protection.outlook.com [40.107.249.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C8019309E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742845210; cv=fail; b=sY7sMFuq7wWLcFsz53oGRZeVTxG1hyDmrfdQmhkeLtoZBvJ7RlzOO4Eg/PLq+KaLUzoHpypHeBe2i396jK/3+2q+X6V3FMc2e9E5eJcIa9GFgcvOZy1rUZDH2/iviB1O3s++XhUvefuik/T4+835zd3oNNyzW5tuvlzSrvtQMNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742845210; c=relaxed/simple;
	bh=zxshkkgG6JVlvoOVT1OjmeLqmBnostBpDchyNPAhbZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KDdXRHpXPoNITumxf71GwTpn/fZYk1OlY47Zb1bou3RflfiFlAKTlYr0MYNJVMdNiWU2yAMgowRNSrGUujtGEMvpMruyUJa9UIY3++33FUE7dHZCXnBQ/M5VDV4GXmZn17Gm5CIfoHObLtZUaWkK0N1Wah+FKcYK5m6Xl8KKtLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gxdk+p+5; arc=fail smtp.client-ip=40.107.249.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjoJsZpX6jZztmzpKOZ4EbZypUTISXrRmvT70I3vr5vrcrzwPx8e2Sm2mnEtHDEp7oe8rr2koh0IQxMV7mE4tjFQfpkoG78SEv/l/1USmSrMmQ26PS4CzvatpaQGF/1ygMfWJ76sToGobEBS0MKi34LjJNqY6swT2NK68X+CO8oYv7mRNPYm9Y1s0QhrNgzMnJ4i8myiyrzsiw1nzj2wQ22XpjZDjXnbvWKUfQB8DFykKy6KPkvnkNCZxcQgK+iqf/ptZ/xH7B9vQvlOKFCWN94uJYodit05bxfg4PTQAeUyHNhkhmQZv4v1rsxjcVSWkEWSFgOWdMV0kWj/Gesnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqSxsDepaoWpYw/92onVUQm3KQMvzdZq1hnCm3+tqgg=;
 b=Uapx5YfkbObeKK6U1tZsFNbK1oCANBmAGNhFAU3jKQOGYgTGEySYUV1YXVqL/oaweWRZ8c1yHIpqk0VVjh95GmyDc9rpFD9JM1hXhWfUM4PQmAote2jgHsWHnFDFeE7oePS+OyuoiurvNmgI2eRgTwL8RTBvlG71gSjcfAreOQeKNQcRm6VtQQFX12OhDfCodXRF2CWHk1AzQBtN5rccGTCn6+vrPjo54Yj8h9Clc/YDUwanDj0LJ2QV8xv1l5h2UzAmpXfYMFwMI/4Rqny3EkUEPsxsk+4a44mhAPAKVuSgulLPx/xLJSUVkXM3MVjlec9qj1zk9Mf/ewfTKYB/iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqSxsDepaoWpYw/92onVUQm3KQMvzdZq1hnCm3+tqgg=;
 b=gxdk+p+566Aa8QTaqzll1rEkS+USWdJ9C9bkPF0dqxX2duZmDrHhn0GUbUCVRKfSToMUStiaqCuPSS0TQ43q5jwp3IkUD8Fh49EbCCi0dSVJQHwqxbR+qK2YEqsZVDClvGUyOx+feiREVLhUyCH+31gVGZC5YsAcZeihiLoSkYbQlokKeI5JjB8Wnr7WDSaoNqYeST7NV1rhscCvv+EjlZsr7MUT3xIsIaD8cxOp/YD7tu6LH73inpPQ2aLSoPJwQ23U0XrSS0BkoaBQ0kwIwbJ7UVsNBfCs0lQFfW4eDaZt0mH11tJIZy4rlfX+DnshlYBoxLf4MZNPyJO/4RKIHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8446.eurprd04.prod.outlook.com (2603:10a6:10:2ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 19:40:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 19:40:04 +0000
Date: Mon, 24 Mar 2025 15:39:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] i3c: master: Drop duplicate check before calling
 OF APIs
Message-ID: <Z+G1Dn2XOx9gLRTw@lizhi-Precision-Tower-5810>
References: <20250321193044.457649-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321193044.457649-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: PH8PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fc4c6c-f093-4c47-43b2-08dd6b0bac96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pNMkL3USB6CzJgvY5hW4kym9LqYLJ1F8JYsDsPRWXwO2l6NH/eUMRGK3q1H+?=
 =?us-ascii?Q?+GV6+Ld6s9p8ah6qcPCLYKMA6uwwdk3ZOuKh5TQ9uRMZTp3GG0sVjhMtiMi5?=
 =?us-ascii?Q?Xdk26p3Uvf512A230KmGdgLgJyiAoLA2rr7mBze0HgaeZmsroExYIuQ8XYCi?=
 =?us-ascii?Q?NH/Mhruy2qzwLtwepFLmpaUrjcZxjSLTRMLgHhR7yBARiF02VlW0WhOUYek3?=
 =?us-ascii?Q?pH9kocanhpAiAqUEvXzlqWsR6GPS3IkMr7zDCAv4wDKSgno4EApaQxo0gQ4S?=
 =?us-ascii?Q?4/fNkSlBjdgEPYEs1JaAa2ip5Sa26aNtuE+ZvccHwtKGUrCLTj3i9+6zZR3r?=
 =?us-ascii?Q?GoxAwXi6hwc30Gy4xjqV7k0o/VPmKMFi0H/fvlZf0MBee0FLNSI1wY76zH+v?=
 =?us-ascii?Q?/DtoAHKijBCpexmwlFd77sjrPwq7yq2rE/1JuaOxQsHI6a5hJL4apbP/afEA?=
 =?us-ascii?Q?PBfE7CCMQ/kvkzQNtfOszdNNvsSnXLEbKafxSbA9GZPhSfJgornATGtJcGHS?=
 =?us-ascii?Q?MQcFLMUGxz89RcXGfnc33FKGY3uTISddX6pB4fpGzfSggrRi+vTCDmHOOGVV?=
 =?us-ascii?Q?9D32lNeQKMSLxvL3mvkA5jK9loAD7Ks0cE/lnrC4AMUtOJaFL+X9ZyguQJe8?=
 =?us-ascii?Q?deZaGg6A8sBe4QS8DrcDRSR8EStE4mwdYhUOpGwYIdCHZxRnwvklhrTdehyp?=
 =?us-ascii?Q?R3semxFfgEMqzsSqM8ZZYOqE+23nyCDdCESpB083UQwGBEOZVh7Bqr8Ezl3S?=
 =?us-ascii?Q?+hGF5A+XYZe8eRmkBfn8HOxpSgO6qvObOU+UioD8BA91ODg1BIZtA7kRJEdz?=
 =?us-ascii?Q?5iYp6WMI31Q6mUurlucKgBoBqAp4CRms8XwE7kxUZaJOyGQ8xhrL5XIJPKPi?=
 =?us-ascii?Q?ldpZB6FJTZnYFfmQxgavQp4CIxlE6AyF59ApB1HBvADpXg9k7e4lt4HCWGuV?=
 =?us-ascii?Q?cK10IkSVw4ZfpMW68puZJCin48sGsW3BBI3J6BiZ+P+mCcBpdAIxgneo9Qid?=
 =?us-ascii?Q?Fd5MgizBWHG8i8YjAZnEYqgogFvurBqiAZvP6AilAc2gIGg+Nf2UC9x2HacK?=
 =?us-ascii?Q?eOWKl5fxZb8+Djgm3iCnll+4DVtLdzFuWoKEbELjoECYG6EFx6HvjzM7JI2M?=
 =?us-ascii?Q?db1LeVLOWCsUdiffusaO/Bn8j8BtQNk9AbScPofCpfRpWFxBVjG4/lwO9SbT?=
 =?us-ascii?Q?3Uh6amndaTDbE3a06Y98/yBi6bQV7VCZAX9oxLXVrRx3Koq6pnANgSvDyHRA?=
 =?us-ascii?Q?GM8HgwateLFmY1UMoN5dDNAdZtfI3mlmdbHOQc1KcU83WKrlz/86yWubkGtD?=
 =?us-ascii?Q?4JAyVNn4QFNz3aDaSdZ1K5Gx/W4ojEdENZK4ANMGNyWqkULjjIFCtXMo/Vbn?=
 =?us-ascii?Q?P440efZ8dNCCWTj6DKAX6+chILrOkzDLVOBT7Nz1hvhRJRdLiHZPuQGZIvGU?=
 =?us-ascii?Q?UKbTVc08LD2DeTT9X0UzvzSq9THsMn5E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P28LbQRlSBf1FUH25aKqcIIuYQoJoTSohDe+wulub/zDYKjiaVLqGvHrMxYw?=
 =?us-ascii?Q?/LIoAX74JgCjEdz5gj3N0WUVUuIw35dYUO09/KI2Xsd34OzDjFPUJAj5bGSs?=
 =?us-ascii?Q?nur3pTIvucZGO1tP5nHbhjimEhk46lB6PDq9TslXuaJsu/EhzafVXa5eYWA0?=
 =?us-ascii?Q?FBTzLGTfCKUfgIVKtHdr719BueFrc4H4fOyaydbVxznY1h/AJJJiXy50fVkG?=
 =?us-ascii?Q?A+IoikcbwivfAaAPohfOg8fDKX12sWTeUxVfVqA4KeR2rfs7uEqsZil6noQK?=
 =?us-ascii?Q?dv9EygsXnqXsxuwNcv87+r4YU1pnExaRef2A6z9d435UDkkGgC5D/R1SDgs5?=
 =?us-ascii?Q?+MZHgEwZvpPf+x0Qxd1iO6DQVjPX5Z5gHUEJY0nqsUbjyba3Vc/H0X1343ZJ?=
 =?us-ascii?Q?98ZyQfjciapAJQoUWIUl1nDQiNubWh6BxGQR6VWu4DM2WLQDOHruaN9+lpAn?=
 =?us-ascii?Q?gbcObXxcV2Lwe6FuPx+l7LtplHu9CPICTh+8h/9gPW+lDrl3i5mzMJSQptCl?=
 =?us-ascii?Q?BO/yiRPVx+A3Tq9kcExwDLxPWqfUYI76f2Mn86W2UlAjCPgL32YwHl2znDWG?=
 =?us-ascii?Q?A8YXkE/wEwUpbkUXtzvbPWt5f+Q7vE4A91pmzhItO7OUPDxitAtaDiQodCQs?=
 =?us-ascii?Q?Tuhbarrw1t7oiLEH5TBj1HeJjx0cHtZyGCLNZTlHQ+zmKLa0GAKsiLW7BMnC?=
 =?us-ascii?Q?Pj4GO2+GFbbVkZjq9fQrlhgtVinOIIm/ko61SKpl92y3glVa9p6ZD9xYouHx?=
 =?us-ascii?Q?N2QHzALmIQtRuSWc3m+QcagxpkvRpEbp9odWLm6pOUzXT9q/TjnQ9c0Ov6ep?=
 =?us-ascii?Q?OYpIMz20FNlf6IcXtFLdGM/inSAd6h+5hy7ZcoVMwxlxNB4lJNiWOXKLioCo?=
 =?us-ascii?Q?wHrN47noUrA5EoY8xRZhx0EaQv5M5RaA8YZYKREXWY1Uc/vwgpS0WlEoslSa?=
 =?us-ascii?Q?qGzJYoTs9qxe4kghtPwTcnMDdzA5Id+1McdIxO2ol9ty3btbzjjpphduE18A?=
 =?us-ascii?Q?KbNOkmIimY7K8/uBb7hv9CFVXdlf2LdJ4aUl12vPgafpiFuIfcV9JFh7ek09?=
 =?us-ascii?Q?l0Y2X9L1Icfa6hSyx25izSGy9+XQebYXpBiNM7noFIqIG+pKvWTkd9DJOA8L?=
 =?us-ascii?Q?g8RZxsaXGgRe6acxEIrXEmjlwl0vSk2EyRdfeu6MyNEowJ0YgBh7ewcjYiOQ?=
 =?us-ascii?Q?aC8ZXXa+Zv33/6Z6xQhX6QtQQpVcsMb9tC3Cl21xidlWyx1Zc5h/mGcz1/4V?=
 =?us-ascii?Q?6xYVuCywP507yzvQeRKGX1QZd2adiDWRkOIuWTLD/YTe1KuG5pYhYGxnefvD?=
 =?us-ascii?Q?TRrSR7DLmpHMoPfIWeMzR51S9UQY9mNEq8f4S6PwdSWFohLYq9Ta1al7diDN?=
 =?us-ascii?Q?Baq9ma2JEyoMTpZjwdpBGTYvRWhmAxotQjjEn7MJ7EhfdOIJU7cLAzSv4Q4M?=
 =?us-ascii?Q?EZBzy1UZvrAlhrXbcFbpBkHH461btMQJ8xi7wh5RT+5C5P70T6JVLnxUQabZ?=
 =?us-ascii?Q?fcyiqIS6dWDfyrgqU1jv/5zajdqLD8imKrXcznCyIEkUp3/gmzrnieWxKpIx?=
 =?us-ascii?Q?nEvwL8tSmmKJcLofu3yJgW9bVyXLTVxuOBYPQpXF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fc4c6c-f093-4c47-43b2-08dd6b0bac96
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 19:40:04.1735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t70VoD2NQ8v/8FNn1e9oIcoVhIKOsoai3uclhtFrvfnnt54wTRGBZC5/NUvKuE3mKCmtWP60iebGysa3MQm1Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8446

On Fri, Mar 21, 2025 at 09:30:06PM +0200, Andy Shevchenko wrote:
> OF APIs are usually NULL-aware and returns an error in case when
> device node is not present or supported. We already have a check
> for the returned value, no need to check for the parameter.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>
> v2: added missed updates (hit 'send' too early in v1)
>
>  drivers/i3c/master.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index d5dc4180afbc..fd26c4bb8b34 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2276,7 +2276,7 @@ static int of_i3c_master_add_dev(struct i3c_master_controller *master,
>  	u32 reg[3];
>  	int ret;
>
> -	if (!master || !node)
> +	if (!master)
>  		return -EINVAL;
>
>  	ret = of_property_read_u32_array(node, "reg", reg, ARRAY_SIZE(reg));
> @@ -2369,14 +2369,10 @@ static u8 i3c_master_i2c_get_lvr(struct i2c_client *client)
>  {
>  	/* Fall back to no spike filters and FM bus mode. */
>  	u8 lvr = I3C_LVR_I2C_INDEX(2) | I3C_LVR_I2C_FM_MODE;
> +	u32 reg[3];
>
> -	if (client->dev.of_node) {
> -		u32 reg[3];
> -
> -		if (!of_property_read_u32_array(client->dev.of_node, "reg",
> -						reg, ARRAY_SIZE(reg)))
> -			lvr = reg[2];
> -	}
> +	if (!of_property_read_u32_array(client->dev.of_node, "reg", reg, ARRAY_SIZE(reg)))
> +		lvr = reg[2];
>
>  	return lvr;
>  }
> @@ -2486,7 +2482,7 @@ static int i3c_master_i2c_adapter_init(struct i3c_master_controller *master)
>  	struct i2c_adapter *adap = i3c_master_to_i2c_adapter(master);
>  	struct i2c_dev_desc *i2cdev;
>  	struct i2c_dev_boardinfo *i2cboardinfo;
> -	int ret, id = -ENODEV;
> +	int ret, id;
>
>  	adap->dev.parent = master->dev.parent;
>  	adap->owner = master->dev.parent->driver->owner;
> @@ -2497,9 +2493,7 @@ static int i3c_master_i2c_adapter_init(struct i3c_master_controller *master)
>  	adap->timeout = 1000;
>  	adap->retries = 3;
>
> -	if (master->dev.of_node)
> -		id = of_alias_get_id(master->dev.of_node, "i2c");
> -
> +	id = of_alias_get_id(master->dev.of_node, "i2c");
>  	if (id >= 0) {
>  		adap->nr = id;
>  		ret = i2c_add_numbered_adapter(adap);
> --
> 2.47.2
>

