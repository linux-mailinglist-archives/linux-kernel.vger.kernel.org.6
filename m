Return-Path: <linux-kernel+bounces-564261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ABBA65161
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79EF8165A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5370B23E33B;
	Mon, 17 Mar 2025 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YnBl61QB"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011002.outbound.protection.outlook.com [52.101.65.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C1323A9BA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218715; cv=fail; b=F4PTqIVI5MkQBy+fxXeNBf5PbmjVwN3KYWx0/L70kD1FH8nuctDPC6I/geUkQTGSZ/rcEAUVEdgvgyRPbPvgDO+kItG3P/3KW1YS7vGYV+j/o9cgpThJFeohYKFBh2q2pV2DOOeujqc9YUehuHOiUqKkvsEjzKsdw7TDm1fFjzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218715; c=relaxed/simple;
	bh=evmy0chUkPgaylx60wvhvif3tdcOpFqRICW4JusepLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tX49ljzufsXyZdzOwom9O5b5pvAv26R2vrtMrq0qEurcDgGHJnWBhOJGEFNua1kx/6NimtFQeSFWbgsK/Ow+5w483qa+vWRXh6FDSs1fGfHPbqYW/L/9wYsPCJPmJnpJ+TejCYDkSOC2/dD4H49P6qcP21sGwPtvnCBoDI0vj94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YnBl61QB; arc=fail smtp.client-ip=52.101.65.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kicWjiyzjOKe8B2jYNtBMOc9IMKvnztM2fqfzOySKByYxBVFFNalB5zNxg42gtwG8qSD8egpBGxDcnWsD6EIqrRfvZVpgT1zJb1dxbSqdXJcLJCFbz6iO1hLSlz069m+GkvwIEWIMciIx+t4c5VkOVjOtX/VbtneEkQzxV9pUn/2REuXvRPE5ND5T3S0xD7vHvmT41PIy99LhbrBb+2FQlLSkPtL/M6KhbnxkEMr2hf9eRO+d4RxfnEolyPb5OL+oM3O13zy5pse+O+jg6MHKO7OX38vQeyU1m0UC7TKvX7I0QJvvqQbbyAUSp+IsEQR4VKQrR9egc8bbsGDlkvexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipKUBnDd2jCQGSZh1b3Un2NY9/WLf0F8LVSEPahRJ/I=;
 b=Kz6yUCjZQ0ClSV8IgLTG68B+L9s3aET+rAE+5TUaK+9M0BBSzcwq+ShwwUmVJ5+htNa3a/u43ySe2gCNWU9KVpwYRpsdL0u8cIshRIECrE/Ra9nBDU2Q4KxgEOm/b5eyaBkcDPCG9hDmtWfQk+7N3+gVDQiEtjZCZ+Tva6d/wzLctlng78VJF7NmWsU6kYZdoYOB8yawYmOiem262VlR2HVIzK+3r1kcaOGvVf0OHAIsDFaUiaqzWqHL7atd0XlgU21yTiWTqVSAARwffeKt3+M8ZrR3OGJpxm1oMmCxej5UtF8Baw2hr3M2ZDkqxb5cwdScxDXz10V6/ZRYOP7iZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipKUBnDd2jCQGSZh1b3Un2NY9/WLf0F8LVSEPahRJ/I=;
 b=YnBl61QBDLvzuKn2CgJr7wvyOgqyXp6DKY54/hEKmg97ucqZMhV3aKX3yw45YXiSMgWs/96uQ3THGiZye5InpirfQPBnGX/EDQLGJhouy7JH8s1MuAsDjr/u3O/Pqn6xls3xZRAiKf/q+KvJVT5Zi1sG7edGR95kpKBKPV5or5HRAO+Tb2+aI529wUAHKQ1X7AgjpL0Olkap59n8g0phad0UKDf06SHXa2CUOkiiQTGNvbiNmxOGWE9HjVK0/3gUO8c9WWzhJVctPnnO/9YdJxlfnBWbl5Y03mgh1o7qUrmOSat2MofLo2aCDtpEjFJJInTFfncbRjY4YIJr5pTJLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 13:38:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 13:38:31 +0000
Date: Mon, 17 Mar 2025 09:38:23 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v1 2/3] i3c: master: svc: Use readsb helper for reading
 MDB
Message-ID: <Z9glzwsAuwKJSlsn@lizhi-Precision-Tower-5810>
References: <20250317051951.3065011-1-yschu@nuvoton.com>
 <20250317051951.3065011-3-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317051951.3065011-3-yschu@nuvoton.com>
X-ClientProxiedBy: BYAPR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:a03:114::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e530a1-f642-40a1-83a8-08dd65590181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UrRF4orU5nTYoLoyhUYwnDMFiqx3oARZDYF8YOxod2PPSUrsK74il6U4Tx9/?=
 =?us-ascii?Q?t9ymutbX0eiT2Zw7knQDUeA3C3EVQ5Ie8j9dMQvQJyfGlNN3H1amesWfUoqH?=
 =?us-ascii?Q?9Qq+qen7dsccHRRWIuObCZ7N20O7nu9khse3aI3ky6GhBV2S/NU5XHAw/LJZ?=
 =?us-ascii?Q?bbR5EUzHDbExcVTxONIYp9NZn+zoiHZMoxe3pZzYj+wG+9qpI+2hQNDTtf0F?=
 =?us-ascii?Q?pQmTShp6GlyZDLeGoPZfDMzJLW0zzITVsHS9qfA8kYtKXPuLyYc9NP+JGa2g?=
 =?us-ascii?Q?ncB63U5ecMQJKxAdPReBPaCzGqGereeau9vncVFkanGLX6ljzgZDNCPGUKpU?=
 =?us-ascii?Q?0QbylOsrkWeqJoX5/2EzYvi2DRACCYvwfwKOezmLJnqOHRThXxGcYHd3VMm6?=
 =?us-ascii?Q?OJZ9glnc0qxhX/rozztF4sCUpge2bI7Mazc6sl+gkBLvazRl5gmk8RY3YFsT?=
 =?us-ascii?Q?1lP/zHAeFLIaNDhuyt+FWpUBMrOnEH+DUSlDRV1VlxtdNC3XAaB/NBMUbsIQ?=
 =?us-ascii?Q?ZiXOBdNDWs1eAcYUlGc0X5fmyP7EFhQu64g2zCZ+cxJfOXuX8ZPIe4ii7inq?=
 =?us-ascii?Q?wnhoyh32nAKIB1fk5lbcOxD2KmF1a8i9w/RdtWdJg2jYh/bJibrXA1K8drzG?=
 =?us-ascii?Q?AZhNKgLa7LMnVfAmbNQKfe7vr/EAj9Y3JBa5Vjjs4dKuxdUsipF8C7/R5l3a?=
 =?us-ascii?Q?Yl5NvTfwRNc3OAEVl4CVMoIFOMWcAVoUF2QQDipIie8sC8+QnaM0dFjUegCg?=
 =?us-ascii?Q?/w3k495FPS5msZGCwoGnQGr3XW9isCBPhRPcFxweUUoV/lGrYKv/sfv2tCKA?=
 =?us-ascii?Q?rI7ur5LD6Gx5mEPV85I6y+8iuLKZjPzRRYdlrWwWgd6WrPQTHUmzasb5jjWz?=
 =?us-ascii?Q?gyCnQdozSh0V2XywDshNZT7p7gpTtoBbBSIOTsbPVIvM1uUaK08PvJDCfUKi?=
 =?us-ascii?Q?JcyfH8f7bd1R4Cm7Bwu9yy0+jk9nfLlNLtsl6Ps8+3O77igYI/2vofdbkvMj?=
 =?us-ascii?Q?z1E+6sDSR6//o+SVw+jIvSphszDlh6oVmLTYYgfGIZcK0Rkp74EtJqxj5lEu?=
 =?us-ascii?Q?KDat5sqSkPyO0Ybb0Afuqq1ebNIbDqiDDQvu5LRaTYwKuY5BnfVacZ3rw3KW?=
 =?us-ascii?Q?r+2rPrpu/UzkUF3ZLyBBgadqm0aAy0VyubL5TAcmbNtl52SsuQI11inKLX8P?=
 =?us-ascii?Q?KvzHiDYOF9/ezoOqUqzQwoiDPrVbavBo1HbX0eFtJsf3OHpYbxViTDXo6dnd?=
 =?us-ascii?Q?jgTRBXFmBLf46B8XdMX654GI4CFCO5AfKeh7OjLLc17K6K41jbQuWf23tXRp?=
 =?us-ascii?Q?Kb8HkhzVIoxEsDrFD/zj4bLkoAJm/gXayl9/RVjF1m4sWqyZj/NdKKPfRWVw?=
 =?us-ascii?Q?cG5cxXHVzTW3GmdJ4q/pvKQ8+vN5p3MhdUueawcAbe/kZCNraw3ia91x1vGL?=
 =?us-ascii?Q?Snoj4EB+vvwADkGq9ktKZ9F3tk8NzPik?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GLty92q5yZ/2RG8EM+KA+YLQvKp2CqtaMx3cjlaf4zmQQ28apYTKUGqZmTrF?=
 =?us-ascii?Q?5Uzcby5Daw1XOemXYMzD37CfIBqAQqoYgDjVZw3LjZcVWRKedgfGL3LcxuF8?=
 =?us-ascii?Q?Y1PcBIv26naIUHAAg5nzyCtBh+UNuC9seiqPNQpkP9aJrVCoHaLrOHGCzv6R?=
 =?us-ascii?Q?nXvFhH3vs+sqyLjwsLRgkvqMiBmXPIriAycMrcnqBtRdDEcci46xVKYNSCka?=
 =?us-ascii?Q?Nf3vf+nAXSsJr+j2zaF3Dr65HgCFULj0K3GBhHDcbMZ7b89p3XvGNWEzLZvU?=
 =?us-ascii?Q?/rCrvZWrUhIf2cDWiRU8/F6uZ/+CqKIl/pCf5pvpyjAcT2wIljoJwRuqzgdr?=
 =?us-ascii?Q?j0IFe3BWoUAyjqmGeaSxbcUzi5cxX4daKH+Sdd9v+wfalPNULgSj37/fZuM+?=
 =?us-ascii?Q?2bCZdnO2MFYNik67EpxMh3j5L3IZTC2KUnYVjU6xuJKjHfa2voLuISiIIZ4B?=
 =?us-ascii?Q?iwQHMOIOdRmaeVVWYLCgxGGhnSEQeFhX12AnhG6cCsruppvlSn/ZGOcgR8CK?=
 =?us-ascii?Q?r0gEArOE4O9CygCTOHpBJzFCUeOOFhIKdLFE2PmKr6n6/+WoqLJH5P4F9xoU?=
 =?us-ascii?Q?riKbix1iElRGZnEwB2kv2D9FYLlLyRpUNbEJSKX+/iIzaAEaml9B/EWd+2lY?=
 =?us-ascii?Q?bP0JPS/NMq+9CsdNekL4xOxzMo/CeNuGxMFeyf0n8iAM+RUY6pBvbICkoR/a?=
 =?us-ascii?Q?KkQxkSUHA4pxIE5ESS3cg17O1YFNjzFo0XTdqAKcNwsJKVE/j3NqdR3H4PNv?=
 =?us-ascii?Q?y+SDbKgwZ+6zXdgTxg25fbM9Q9T3T+hh3dY6ewd9ZcyQUIK+W3EEMlOGwIqm?=
 =?us-ascii?Q?bhgoZYtGAndopiYFGS1LMeJZcarTX5GnPc1sDAHHIwcY7/woK8aQg1Wp+FZj?=
 =?us-ascii?Q?Q4FWMyIYIunHToO2hOqpq3EXvQ+7OZZ7gzEQAhffASUdifmxDkGSpjSAnQiD?=
 =?us-ascii?Q?rJJR0jFoCohUuAAwWzxAtJf6Xqv6/CzIZI+iIqoohWxwbnAS3k3wb1sftMjl?=
 =?us-ascii?Q?M2sC65ME0hV77VPbTVLa9nWxodh9k9GHl2k0FJqLymt1Vd4nhbq3aN9tDDOu?=
 =?us-ascii?Q?MbQyXxcQenytn3rhXOXF4ix1cknkBpwko746oXAtCTnmhUqL3QkePXf1aHY9?=
 =?us-ascii?Q?604TdlBVjGitm604PpMN6F3Iqgn6CBOkqrjtVbO34fum9vBG9dhQCcd24VxG?=
 =?us-ascii?Q?RxfXTJAmnr6ZN6CceXI7XSCzWF6tYQVGo8Y1DhlVvvJnu/3cavCoYeW/34xf?=
 =?us-ascii?Q?JKrc3YKy4bRMjTmcJGvmYzm3uyid4xAnGG+8/bhY4JUwRgBWWlxEWmPsurtf?=
 =?us-ascii?Q?Oc0NhfwEZpZz+8JJOx2f7bcdDf2BGh+eEYubnRRczDxpYjaIFftYVA7FSDgG?=
 =?us-ascii?Q?1lKPN4RnOehuExS7McLnEP5g+c5+M/l1VfRfByhAKk5Zjs5sRcMrfsA0CJ38?=
 =?us-ascii?Q?0+cxyGXcnb4uB+boES2zM4Y6mLh6+rrBgqGI4BTNWYje+hlczP0dXn90gkGg?=
 =?us-ascii?Q?3cbuNsfnbm2ItA+hiUrreKXFM89oT7pRTT8PYgGaLv8JGGJiWdWcjvYRGVxJ?=
 =?us-ascii?Q?2fP+8KBQHvy/G4WFjmw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e530a1-f642-40a1-83a8-08dd65590181
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 13:38:31.0751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYEkjQOIBPGFM5TajBA65+TGjcG/SqUnaLUAoeg0l75Rv3xyRwHNmqVI5ZaJKsI0AHtLykwzeQ1QH+kJBp6TNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8749

On Mon, Mar 17, 2025 at 01:19:50PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> The target can send the MDB byte followed by additional data bytes.
> The readl on MRDATAB reads one actual byte, but the readsl advances
> the destination pointer by 4 bytes. This causes the subsequent payload
> to be copied to wrong position in the destination buffer.
>
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")


Cc stable?

> Signed-off-by: Stanley Chu <yschu@nuvoton.com>


strange, why this issue exists for so long time. Maybe we just use first
byte of IBI data.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/i3c/master/svc-i3c-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index a72ba5a7edd4..57b9dec6b5a8 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -425,7 +425,7 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
>  	       slot->len < SVC_I3C_FIFO_SIZE) {
>  		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
>  		count = SVC_I3C_MDATACTRL_RXCOUNT(mdatactrl);
> -		readsl(master->regs + SVC_I3C_MRDATAB, buf, count);
> +		readsb(master->regs + SVC_I3C_MRDATAB, buf, count);
>  		slot->len += count;
>  		buf += count;
>  	}
> --
> 2.34.1
>

