Return-Path: <linux-kernel+bounces-554432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 921B7A597A1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15FD1188F3A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AFC225798;
	Mon, 10 Mar 2025 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bmKKX+a1"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60189199223
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617284; cv=fail; b=WdwmFkVBJCxbepkgjca2cJVPT/0sJXsc1HFlFaCssCPNJlKy46hfEVihPcOsdlkafLax6tPqhQGf23Om5grn09FPW7O6UIxCKsphLeF/BKLMQpQUKp0MUzC7Kk/0ff/EPChGxtNQ7nLdaQrzQMLzGRthpxuY8ErvesJzl3zI09Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617284; c=relaxed/simple;
	bh=20uC6wqntqiPHRLiVKztJ3mCKKWsLfnxtj8EoCJd3+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P+z29Ka2eTzFLmlOiRLY7i7oYLwtLt6FCaA2N0tcM0tSJH88yv+gMFH453ThkCT2SjljR04UxfaVYl3TVxFyaTzZfspDWEdP28hZ8PGO5ceSiavZWvqQsZw4sc43ws/FX0qSWajZsP/vH+HkrZe+GMsqcS4YM3UJBH/6yNo/Bxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bmKKX+a1; arc=fail smtp.client-ip=40.107.22.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmwFzXuVF6LLqQIJ4TaGjzB/yA/i5XlQSNJ2/VCwvLgPcfuzk49i68BIzn1taLCAzmkgjFziXUpJ/lDuM+qjo8GgG7k/JLXM+B6S0KkYtcuqW1MG2c2rtz4pZv54vSBXjBfmgG5z+zSw4GAge2RdcJ4vgCc82wyjIBM5OGPXUEz9X7eQQ/8Xz2kP7Rb983qRc6RcMRAoyZDGinKiDJUrxb1oCONYzq3jKI+U9byAaypvWqjAUz0yAjlhyLRK3fIam6aKRJTG+hiYwUu6ZkfXt835ocX4kq5zCQl3w+ZNUpKqKxwXvtv0spBl497YdMu2s0UxSSgfZgS3losCygnQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzOq8eQKTEaboOLotWT2hJ37Ea5bhnRgyRxTBH6B2fw=;
 b=U9+KZ/UyzW8D+FTt0s8PulzOvs4+BMC1z2WC8NT+BlQy/QWvckBzIr/hBMMQkRnWE4vz9emGtAvkNG0qH8RoqtaQRVgR3iD4EASnoczba7gg6E9Z0sg/AFtWQPAQEHg1/PXWW9Lx8hewdSv4RAC9wsUOeZMVkSFWtnV0ONU6YtSQKiVyKM/JKrtjxpyPaEjoNlA72vzo6VE/WJEJUrVzWlL2HV3TvBIje5FM2KkZ9Pwcbx28TAWRi5x6A6lzJXzrUz2WqaSwObBu+jIXObF83/v+vd6uklsorTbLNAkvc9HQL4T5e5oAfU8j5IjAwA4iIZ7y5MQSVjxgvrvojdHIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzOq8eQKTEaboOLotWT2hJ37Ea5bhnRgyRxTBH6B2fw=;
 b=bmKKX+a1D5u/FEhnDmoo867F+5d6gq2YXcXi0zm8O6jVt2xrAIQ4YycI4x9y+4T9I81ZkRfSpaf5b0+QMXUQaw2UJ9R3wKCfLM1DvTIM60cYNewQkYTXKBrpEj+HBuissG1I0OnWQBzzlZLl41HyfaMxcJISVQW3JmHfXlh4M/rJT2Po2qA8YwzjjwGlYhJkPHFB4l5OGMTKoelhAFoGH7DZnzwvR3RjbNYi0HByIRtdpzcSfQ7ZfGbN+j2Z+icznI0qP0rs7AUiZQNpK6oOucA37t3d/7Nm45XRPRx/ObZToroAJFT5hjIlIXOuYaREoexzH6qOkUBhtZqLEYAfEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9804.eurprd04.prod.outlook.com (2603:10a6:150:114::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 14:34:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 14:34:39 +0000
Date: Mon, 10 Mar 2025 10:34:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v1 1/1] i3c: master: svc: Fix i3c_master_get_free_addr
 return check
Message-ID: <Z874dh9lV7P+GpkM@lizhi-Precision-Tower-5810>
References: <20250310023304.2335792-1-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310023304.2335792-1-yschu@nuvoton.com>
X-ClientProxiedBy: SJ0PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9804:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b91e8fc-c102-4e7b-4c03-08dd5fe0b04e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6uwOLB8KLJvQCzxFd1IsTr4qfj2Cb1qMqORkJJqQzlUHS8401TrfyDVKB3vN?=
 =?us-ascii?Q?SlLRpysIy7y2beKfStv4gZpo/xVLkrsV3AMgHbt8Ht8jYPP/O6a9oeZMd1Ha?=
 =?us-ascii?Q?S29o+/GYLl43hX8Q5RkugwvtxRdi9MxVrYjzXOI5xRpILYhRkKwGKNlCWLhq?=
 =?us-ascii?Q?RZvZuxmSOeJ/hFUK/ernjomJkzVDGIazG9JL+1WqMkl+6DeDwmRAGOuo7Xno?=
 =?us-ascii?Q?rhR6QHgwmZewrr8OdvsT1W6Y46+XVIlPlTkMdKqsbX6aHMBNAmrNkBqRqg9R?=
 =?us-ascii?Q?7cvbwSlJZeUA3vfGpdw4RfigUNIUEqlC0cMXQdZmc3vDRncU5C0cS0REUobE?=
 =?us-ascii?Q?HbFkJyFoC0xPDsHGoN7jk7xKqfxJOhgOwNiQokuRkT3i0nQmKnrwFqOycdBX?=
 =?us-ascii?Q?ZW8ZETC+GxO3N+MFOZKCHNu7efoEz+vvajF+af3qGhW6CU3Efu88llOl0Qf6?=
 =?us-ascii?Q?HnwqKuIZdAjZCBmCIEHMB6zOYyudd60qoQxv9NJUWtl6FiR1G2oyG7fi2/O9?=
 =?us-ascii?Q?YaKvXkpmP2Pfw/p2M7voR8zsxIV8L19LmZ/rfEHTFTkBdaa12emu/XigJScW?=
 =?us-ascii?Q?fCXBSmjaNCupVga842fC1NQ+djgmd7AiW8z6/8BQDKZhyopRllWczB19KgVy?=
 =?us-ascii?Q?2IHCKze/9xBf+tWkmmQa+RE9KcRhxqBCUrwrtZ4qd4AX6Lfcp7LyIdkarj4z?=
 =?us-ascii?Q?pC/uYOcVPGqUmnchdtZ6z+Al37J6lkeOvrQA2vVJArHbf+bR4SFOMT+YsC0I?=
 =?us-ascii?Q?tv0XiKUVoKolnkmqs6MMjjAfMQ3mm1HhNAV+Xiug1YCJFn1sQ7DuiyffEeMJ?=
 =?us-ascii?Q?sg7mjHnXih8uYR2wlMgAsVZt/in30V//NQkU+x8EMJoqM/fEuAfua1k4NK7M?=
 =?us-ascii?Q?f4f0Z24tRROPpc0rwZlj6gAN3KHYpwF1y+OS77+FL8X6qsWIXHB1H/NF6qyT?=
 =?us-ascii?Q?XoC83kxLhORolXWEfxWOh7CBtVNEfGUVzig5bsL8c86CMcfXU2lsOBW3Bnvs?=
 =?us-ascii?Q?P1gs13LEgvVW3HzcBHhU2OsqWl2xlsj3w/TZp4424NVZQFLU8a0eHeUkVQDz?=
 =?us-ascii?Q?Zokp4lX6JrQuvQIfmxEf96Ba9lU+yDxjRQKId9y/DffzYWfDF1EXktMkoIVP?=
 =?us-ascii?Q?v8/bS8+j9oEqBLqZAhOBuYxpizhi5LmDuz0fzA8Wd8U8wCuPsmr5yt5sWV8C?=
 =?us-ascii?Q?DgpS5bqvZfEV5AdN+wFgiHIpMbHueFBifJJK/z4RoAXH5vK+VRsNGVQkW4qH?=
 =?us-ascii?Q?MKztF6ts29cwQZDhqRbmoFZKlrRrYPPLmYK+ZJd+Xm63mwzxic6SOyyfR43D?=
 =?us-ascii?Q?NjT1lkYwLmJoseOzYQyO4vZGLQG4N39n5KAiNH8SdbtlzibPiG5l3VGtH/dY?=
 =?us-ascii?Q?Dg5Uq7VfpoYt7nUN05F2hxbXK3Kge+4dkFy+CGofk4bWHCOGUYT7bM9izcBH?=
 =?us-ascii?Q?CmGtjxRlJMDfLvloJq9nohp/0dvZTKF4Lj8puJzY4OEn9QxgjKBWKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QQSwwVM4/vyZuE/Tkt/K9gvbTCPf2vTOM/cHBk9zdm+gONP1YMOMZ1xrRUVl?=
 =?us-ascii?Q?6jQa8lNo1nF56XqA1sI/XX31NjI71EqPkxSTh/aYxSKWkAUJBBqcJvFUHBjo?=
 =?us-ascii?Q?djRfedNCJ7g2Yo8UgOwuruh4wstkKiBQVF8b+9mR+tjfzBNkQdAY2dmTMIGH?=
 =?us-ascii?Q?Cvm8K8hdofHEeot5toOrr9pGZH4rNGM50chmSHbfeyftJ6Vw16jAltDoXNiv?=
 =?us-ascii?Q?1MNV17ROJn/juMsLr1FmDk6WlPfw8kQRmbWXkLjZWuKZK1/V7RUNL3NeAX4p?=
 =?us-ascii?Q?fJ5NOSx57JMI+dh0FXKuolS5EqJ1gZ66gmRbbcAaBpvXUHywMv9g3yGk3JKJ?=
 =?us-ascii?Q?uWLIbDHBDCXhhp/m/uXnJzAClr9R7kyjue4/mw8+T8N7xtg9h1EFIuyBQwtB?=
 =?us-ascii?Q?2wCFR33gu/WjWZgdxtPorR5wViitrTnSMy8c/W2iaZLNef9Oj8zqGhrTLpmr?=
 =?us-ascii?Q?ZYPkttuAMRuGf5FjE0Dnzl31Y9GPh1p+jLszmvGPfXWRFgag4QL68VQjQi9V?=
 =?us-ascii?Q?Zun6k2MdIaXka6iKARR/TsOix6KCwb+yrjPs9AouDJ3HVxq2Lrczc1J4YnlP?=
 =?us-ascii?Q?UpxzxT2P2/BPJcAFn7HFE39oREyETDaQenhLwUjx1k49I3H7vzqnEeNcXv7T?=
 =?us-ascii?Q?7TJhbMaBiUAq4nGR+FSQne7WboCMzSt7KYCkobBEu/6NNdPfaY7DaZeeGPy0?=
 =?us-ascii?Q?sXHLGdlB/1qBemFHW8d1cDZApuEo3whzE1GbKjYgWydQ3HNRuCuPk809J0MS?=
 =?us-ascii?Q?T/CqTFQesLLFpsMGPm/HkJNFCZjlgnifCi5FSmmnqkB1AGq8x+Bx4V2fAJdx?=
 =?us-ascii?Q?JwbgX8mYfqz5iVSrWFFOQhbO/JuO6lt2I5b0aAUmRwan+TGYQ3gBzpg4w4OA?=
 =?us-ascii?Q?EFveyneLJLFs+ydWKDbO+cGVz/Xh1mPyUWCTOO5/Ynhv8dWXSzsCthU3G18L?=
 =?us-ascii?Q?QJE/UQy4Armwv+ZCsMpalVWs5BMAnbWqsR782ei/tIgKz8/u6frEW+UO7Xjp?=
 =?us-ascii?Q?vhhooY7mE3UeexVu5RN1mhzGB/bJW18DIMm3xQQeTDq7mdII8Dh4iyK4mmQe?=
 =?us-ascii?Q?IsDnivpLYXNtHsWFdJ1vCblgX7vtnkx4gEy1zmkl8uHCI+9PuWlHhWFVNPsi?=
 =?us-ascii?Q?sq+L+gRcIIo2fteT3Jvg1FcNPX1FX47K9MdKtmb+QjA+ssIPxvwQfJEk8jjw?=
 =?us-ascii?Q?ikPo53tqB0GZG/IAHOPoRU9qrp7bHRy6iA+rtfYlEpq8dodhRKrwc8+zPRL/?=
 =?us-ascii?Q?i8HN8E4QfUhg6sNAL9UQayP/P7hkLVCWQDe0U336eWrxC+9x9XDBxgE6TC2P?=
 =?us-ascii?Q?r8dEzlRkQI4964ObtH2hjrmem4aIN0A4lwQxOlwdmAo4TBjdT7zfvCw/qMHH?=
 =?us-ascii?Q?cNv0pRMpdeWvwe+RQW3wCQpabLe+FaaBDz/TlNaynHgkcA/srm2nSkqVGh3+?=
 =?us-ascii?Q?0FnMhLogu1uPL5GjnxBOYBX4p/SxEBbCfoGDNTz+etMc8dI6CeBMQvqayAJ2?=
 =?us-ascii?Q?v+jubUoR+kzRob4TGtxb932dPzhaFUQQrJqBPVGug2JFxDnjs0ufbQldEkLM?=
 =?us-ascii?Q?84MvkyQ72naK5ooV4Pc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b91e8fc-c102-4e7b-4c03-08dd5fe0b04e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:34:39.5034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tTFYgf2Ukz9FMe0Yp3D11oCgBjdHlvsq1EIHZ5IAGdqtWEd9MOr1bV0Cgek01zpDAwHFvAapOWs1nrkuzRATQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9804

On Mon, Mar 10, 2025 at 10:33:04AM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> The return value of i3c_master_get_free_addr is assigned to a variable
> with wrong type, so it can't be negative. Use a signed integer for the
> return value. If the value is negative, break the process and propagate
> the error code.
>
> This commit also fixes the uninitialized symbol 'dyn_addr', reported
> by Smatch static checker.
>
> Fixes: 4008a74e0f9b ("i3c: master: svc: Fix npcm845 FIFO empty issue")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/029e5ac0-5444-4a8e-bca4-cec55950d2b9@stanley.mountain/
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/i3c/master/svc-i3c-master.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index f22fb9e75142..1d1f351b9a85 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -940,7 +940,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
>  					u8 *addrs, unsigned int *count)
>  {
>  	u64 prov_id[SVC_I3C_MAX_DEVS] = {}, nacking_prov_id = 0;
> -	unsigned int dev_nb = 0, last_addr = 0, dyn_addr;
> +	unsigned int dev_nb = 0, last_addr = 0, dyn_addr = 0;
>  	u32 reg;
>  	int ret, i;
>
> @@ -998,10 +998,11 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
>  			 * filling within a few hundred nanoseconds, which is significantly
>  			 * faster compared to the 64 SCL clock cycles.
>  			 */
> -			dyn_addr = i3c_master_get_free_addr(&master->base, last_addr + 1);
> -			if (dyn_addr < 0)
> -				return -ENOSPC;
> +			ret = i3c_master_get_free_addr(&master->base, last_addr + 1);
> +			if (ret < 0)
> +				break;
>
> +			dyn_addr = ret;
>  			writel(dyn_addr, master->regs + SVC_I3C_MWDATAB);
>
>  			/*
> --
> 2.34.1
>
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

