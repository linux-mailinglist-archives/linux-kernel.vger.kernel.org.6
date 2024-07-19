Return-Path: <linux-kernel+bounces-257406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 613C1937979
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 17:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D8E1C221A7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83CF1459ED;
	Fri, 19 Jul 2024 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B2KWfsxc"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC511448C9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401289; cv=fail; b=kh34JKDxzuNfoS8JIZko5yTOeGBG9QrYqcIkhcecKdmdnnllWtGhv/UqS30CM9yAdA8NvU4BHfNT8S7wYFQe0S/eSGGovjr1ejY1rXT6izt5WVKZn/JLHKkalNNVVC1o5oIXYVe6bv8uVjbU898aKiVUt7E0QLlw4R4ltlpMHFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401289; c=relaxed/simple;
	bh=wkp2/fiks1BKZJFHOI+WodWWADbRpANGXkkP6Ja/BFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ELy+g5AM1KyLX7ZvVd5rTeHSrGpJHCNlffF9EGtTnZQ4BOWmrneLEe7UEJmTtjwsLOowkYL/0L+r5ZqH3hQPA/ZTwwlzs5uDf7fjVK7PHnY8cqqIt0KXyPedt1ZuJHS/QkI9zRFo+FKTd0xhimxCqtEcC0yWEPyj+thfhA4h/Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=B2KWfsxc; arc=fail smtp.client-ip=52.101.69.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFNQegCLvXBdzyfwDJZaeb6L5DEAu9/OTlg5G39rOIP8qcILirOA29hnTvzrO1EYYcE6s9DEbE+wIp1xADB3W5ORtH49+MLSKAGC8PD8zYZGclM2DDQK1s4FjnsZdh2Mc3LTYh1DojIU2/IycRx3bI3/rsFh2qBVdUIhuf/TScZ36t1P9uITrxLdzzjD78geAV60CX+DA5cHyv5+BoWGFayxWneFnVBoMKatT1n3QxSzq6lX6YL0bc1JR/z5x9UF/YGlz3bge1WSvgZFE8TVC2zCtSTBpYKOK9wROgQ9awInFLPxNXqYM160vLXW1ocXmJY4novf+i/uAnuFCxm3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/Ek12ve/7Ct1QBER9DSToIiTl8zl4yRCCRDVkbpgRg=;
 b=Dt8bctEms+J7tdWwrA2IcIOHT2P0eIn7XoeZxpu3d2gjsppNtuPlIyL0LP0n+Ga8afbi8vab0nRahhXd0Tja543Js4Ym7VFEB6C39I7QECemQmk8Tv2C7aazzjmx3pumtXF0X44PDH8E8rWeaPYJSw8hBYo1XbkhUukAnskoDbr35uQZL2MkNJ4VfLi7LyC2jZ2eSleuSVmOjygh750yP9PYAgHr7N8aiIlmBj6cH/Y0p/CrmOLJqq2u4E5WcXWO3ceJaI9VVsFKbYPxUYUsqFH9h4lkXSIMgdnWmAaE1naHVlTViuMQjmzQCRuDXL/AqA58TtuI90HVQ0q3hmGkYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/Ek12ve/7Ct1QBER9DSToIiTl8zl4yRCCRDVkbpgRg=;
 b=B2KWfsxcX+34fCOzjedSvqVWUlAQZSNNlOYG0RQtmCFgrIn0hVbu9i+the9QkczstE2Snl8wKz/Bk1daxOMevND6k2nYa6sA6M7PY4Hff9Kaj+ZpVAxaG2mypeDS87rcZgOa4miv4SBk3A+/BxfNMFhOCAV+KpAuryQkS4zqGQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8525.eurprd04.prod.outlook.com (2603:10a6:102:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 15:01:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 15:01:22 +0000
Date: Fri, 19 Jul 2024 11:01:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: carlos.song@nxp.com
Cc: miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
	alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-imx@nxp.com
Subject: Re: [PATCH v2] i3c: master: svc: adjust the first broadcast speed
Message-ID: <Zpp/uv0yeEhld6We@lizhi-Precision-Tower-5810>
References: <20240719080351.842848-1-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719080351.842848-1-carlos.song@nxp.com>
X-ClientProxiedBy: BYAPR01CA0026.prod.exchangelabs.com (2603:10b6:a02:80::39)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 30322cac-5aa4-4896-adc3-08dca803a70c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hqz2RhPP9tKJFhxyIyEJ1X7CRqperOMlmUe2Y86kHHYxyK9HPeWbujewzU4v?=
 =?us-ascii?Q?Yz3mkIiui+gcKSUj/kt9kMDli1UrfPOj9qce2Tngqi45o4zt35MiB2pi0QJb?=
 =?us-ascii?Q?fdMmkMqhX3P9Ifo0UBLcZFoZjSaCoORqUnchF6PO2WN9CP9GvKc/pbm6a7s0?=
 =?us-ascii?Q?AnL5gwHYl7vFihYNcD84qB1A0w+s60afuOXRUfs8joh3VzlmkNx+K8li6Vd4?=
 =?us-ascii?Q?mDoK0VsoU/8DG52/ZLLZGyIOHQMZR9P3exlJR+PiGOIsxiOOss90rKOgxCmL?=
 =?us-ascii?Q?6Y5/gJIG5aTZCOuJqYSaqzeTXlKiuwP1LXmF8jjWEMQLr81H/BkjQjz78EEJ?=
 =?us-ascii?Q?+04tWTGlYZA+nrWlIoaVx/8pGg2Z9Zt0z6fpImBoo7+Y2pwPYxqyz13HVlQY?=
 =?us-ascii?Q?/25XW5gLatPe3APUW0quHGRObE6RdLRg9D+66lgjwKwa4m1zW3+TPtlqI07G?=
 =?us-ascii?Q?7yXcoTah3qYFbVLyb2fAqBEsFK0IlqyHF9bHdyLdALrFKyNSTi9eKeWhAFMk?=
 =?us-ascii?Q?0m93lsdu1CfZYa2yKjgaEB9PV+tEnMTwn185xEqoAmdBIVvLHWZE/iu7YDUh?=
 =?us-ascii?Q?MrUECtedzU0zBarFQ86LdGXfbmAOyTpPccpih1kgRIC+UDDi/MWgi6bibiIe?=
 =?us-ascii?Q?QRk1OBWxOboyEqXPJEphGKZhS6tShbQLD15Jw6l2AeBrxVnTL4JbYHFC8VhN?=
 =?us-ascii?Q?Pi2JjqyXsc9kCzYybfR7Z1Bh+5aboFaUebxujF5WuQlskBxecXzMjUaVGvDl?=
 =?us-ascii?Q?fCG0iDzwuC4e3xj7ithaeEsarUZfJZErKkeKieXFS0QGsl5+66zRFEBUlidM?=
 =?us-ascii?Q?rjeIcyLzHagjjiLR1uunluauAnWtSoogP4Swz8XelKCgIaRbba7rjJ10n81M?=
 =?us-ascii?Q?h29DwvJkKyZb1hUKFMGT/6VY0NIixLIMW+cqX6OeAPXp7mqv+Bzj5E/KHVEq?=
 =?us-ascii?Q?J5ua/JSb6hAimGOeSRhLRoQm1aYQJSOR/p6c1cLd2Ph9q96UJ9IRg4F25VBO?=
 =?us-ascii?Q?AaE33E6JbVsNAeg5gp2mBRCQ4OFhIhLD5pEGE5NqWVmPdVgzIQQG7kxOeADn?=
 =?us-ascii?Q?TEG/UmUBRHLWe3F/FTnyULbNe/XmB6er//xQL9MxpvuAW38ijtE8KWcKJtj+?=
 =?us-ascii?Q?jK4KJyU1R13BSBGJSTxijoQyopG6wdxfgg9LWDMx3wO7UkCgMpLU8R0Vja9s?=
 =?us-ascii?Q?BaPjXCkwPiLMGp02PDlbfw8rY3F965/SHZeZYx03nu2clemlaD+QvAbD/JmX?=
 =?us-ascii?Q?HZsnp25MnyAuslMQwnrdnki6cU0YULzYIZ6JFsyElLZyKUW7/5XsI6sAIU15?=
 =?us-ascii?Q?IlD6ZBip2qvGNWzBOYQ+l3T5tkb3YJkKnG9PXyhYubUTOhzNSvYlt2VpqIx/?=
 =?us-ascii?Q?QzmMhK3fo+g74e3C9SoYc+gDiyMksgO1bnLMdnLkItiyQffWCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x2k/W0lQxu9FOTOKbOh3pjNzMXT8bT/IFhH2WX9iWw/ipdZnN8nVWPnH3ykp?=
 =?us-ascii?Q?77cFhifeKHGEmmec8WfqA3juHDG1x40uvkVH8mI7SN/hzkjJf7EW8NyVznjO?=
 =?us-ascii?Q?fhUBWrnccutkypfKd1/qvtlhAUMKCdH/5c+sdDUZy0knii+/NRF6HM7cIGFR?=
 =?us-ascii?Q?1Lv9cLwhS84rJecLEYBvH6GttW+m+zy1MYuCRDfAa0NGGI8CMHT1k228K/jx?=
 =?us-ascii?Q?KIaeOyGvDhfxZWkbBrEGpqc5RU1mImfatKkpcFR3yN1OivpltWMckveX1zz+?=
 =?us-ascii?Q?yaXw4x1y4OMtDTw20sG2Bq6gCp+gdkiKa810dj+FhnnNU/qWNTTTqrKQ0WlV?=
 =?us-ascii?Q?uUTtGQCuROPL9ebJBAdjODqIhSoOJq0ygQjxI2x5Wmv1o2X+DTd9CD/q9z+0?=
 =?us-ascii?Q?n87J9A3R7k8sFPjWFMwu1+YUlmRKQU2vPsLHVN0X/+gk3oq8plRHIGvOCyhj?=
 =?us-ascii?Q?5CkNpMv3bSCv04r2BOFgTYSn/mNzoowT/qcgSHZEoV07VbLd06MwjEKtwwDR?=
 =?us-ascii?Q?jHXA5kMJUJUdWiX6U9PeuUtEL/xf786NnzBiXC0ml1//T1F0brrxT9sPbACp?=
 =?us-ascii?Q?YFILmwxChwOnSGXA/okosjuvqpGKgXPbjG2azRLWny3IIi73aMK4SsR9rijm?=
 =?us-ascii?Q?zHFrjkaQqZmHN2Lq7UJMD0NwfZT6j2Nyll4BO57abs8rvKVDrg7ZEGf8a+AC?=
 =?us-ascii?Q?gkYiblnagqUTVmaiEmXO7JGiDY6m7iAR7isLjUuhPgJWdqdqiIyfWvXIjCms?=
 =?us-ascii?Q?b/Jw6hFVD8Yfgl7+0He1yOwoWoE2EQw0085VQKLeqy8nTfPSgCUh0jM486Wy?=
 =?us-ascii?Q?CYwHE8y2/TV5yvIRSLVQ803V9f7NTEi8LcoogRi0xcYaY1hrQWHvS2l0DOLH?=
 =?us-ascii?Q?6KMRyoEl5EoBSbe8PBh+JppYZkW94vbuKk5rt666AJnLAQaTLX0i1n8U5kek?=
 =?us-ascii?Q?dxgkXZosS9MnuaC+RiXBOsxbL1Fe44++6OozNMkp/FBMFkwI9ugMhcH204Od?=
 =?us-ascii?Q?hQCHpPPzyg5Lsx4TwvZWVF42Gp8HStDZnagUsn+MAKvEkyItyJubu02+F/t9?=
 =?us-ascii?Q?uzIB2bZlZ5ZwRcFsVwovWgGFHO0fu8reYb3J3n31hhZbidprQDS6HpHh1Pwv?=
 =?us-ascii?Q?5u48vgBdeFSAG8POu/ETGfpPZgrMCSgJJJ6tFthXbekNjWb17lLZNI6VCsGr?=
 =?us-ascii?Q?8aOfQh27aQkNBVSP8YxBekiydHARljZ25IliHhO3E1JdIMa2xZ/J2rKa0pyJ?=
 =?us-ascii?Q?f8+UZSCaIKY/WpXg0osF4V34vn0fBsprmtZf+B/28HKA8U/w362cOpcyG/Q2?=
 =?us-ascii?Q?nhtZwTWxxA6m1Lur0ma7zGAL4EQjZD41W7HNcm/dJpIqs+s4WpX9O+cIfivg?=
 =?us-ascii?Q?P2OiZuGv1RK8VAf0ewzOxbgA5/I97lokOJ+r+A5oQMadcRyXllXa4/Z27P+T?=
 =?us-ascii?Q?VkQ+O6iorp/L7YrDbcTvO6plbbmvaaAspx+W/4avXGtivfGRf9gGCiwEOsz1?=
 =?us-ascii?Q?uu6swQCT3DvzRXELMD94e4jqeFHi6zjS22oZfaseoIBDCsa88cXIGYFF+Y06?=
 =?us-ascii?Q?AyEWqc8DSxdxjdWN5gM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30322cac-5aa4-4896-adc3-08dca803a70c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 15:01:22.1727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVf27iWuMHmoTQmzfZ2te9V9fkhh3YVuEQByAXTlK3gWhsmR4c/MZYzWA7CU59RPYURGv/zvHKpVFU6JxzjsBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8525

On Fri, Jul 19, 2024 at 04:03:51PM +0800, carlos.song@nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
> 
> According to the i3c spec 6.2 Timing Specification, the first
> broadcast open drain timing should be adjust to High Period
> of SCL Clock is 200ns at least. I3C device working as a i2c
> device will see the broadcast to close its Spike Filter to
> change to i3c mode. After that I3C open drain SCL high level
> should be adjust to 32ns~45ns.
> 
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
> Change for V2:
> - use slow_speed instead of first_broadcast
> - add default_speed variable in svc_i3c_xfer to avoid set default
>   speed every time
> - change start_xfer if else for easy understand
> ---
>  drivers/i3c/master/svc-i3c-master.c | 55 +++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 78116530f431..7cd3a9a4d7dd 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -142,6 +142,7 @@ struct svc_i3c_cmd {
>  	unsigned int actual_len;
>  	struct i3c_priv_xfer *xfer;
>  	bool continued;
> +	bool slow_address;
>  };
>  
>  struct svc_i3c_xfer {
> @@ -214,6 +215,11 @@ struct svc_i3c_master {
>  	} ibi;
>  	struct mutex lock;
>  	int enabled_events;
> +
> +	unsigned long fclk_rate;
> +	u32 mctrl_config;
> +	bool slow_speed;
> +	bool default_speed;

I think you needn't two varible 'slow_speed' and 'default_speed'.
	default_speed should always !slow_speed

Frank

>  };
>  
>  /**
> @@ -531,6 +537,43 @@ static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static void svc_i3c_master_set_slow_address_speed(struct svc_i3c_master *master)
> +{
> +	struct i3c_bus *bus = i3c_master_get_bus(&master->base);
> +	u32 ppbaud, odbaud, odhpp, mconfig;
> +
> +	master->mctrl_config = readl(master->regs + SVC_I3C_MCONFIG);
> +	mconfig = master->mctrl_config;
> +
> +	/*
> +	 * Set the I3C OPEN-DRAIN mode to the FM speed of 50% duty-cycle(400K/2500ns),
> +	 * so that the first broadcast is visible to all devices on the i3c bus.
> +	 * I3C device with 50ns filter will turn off the filter.
> +	 */
> +
> +	ppbaud = FIELD_GET(GENMASK(11, 8), mconfig);
> +	odhpp = 0;
> +	odbaud = DIV_ROUND_UP(master->fclk_rate, bus->scl_rate.i2c * (2 + 2 * ppbaud)) - 1;
> +	mconfig &= ~GENMASK(24, 16);
> +	mconfig |= SVC_I3C_MCONFIG_ODBAUD(odbaud) | SVC_I3C_MCONFIG_ODHPP(odhpp);
> +
> +	writel(mconfig, master->regs + SVC_I3C_MCONFIG);
> +	master->slow_speed = false;
> +}
> +
> +static void svc_i3c_master_set_default_speed(struct svc_i3c_master *master)
> +{
> +	/*
> +	 * The bus mode is already determined when the bus is initialized, so setting initial
> +	 * configuration back to the controller. No need to set it in every transfer, just
> +	 * restore it once time.
> +	 */
> +	if (!master->default_speed) {
> +		writel(master->mctrl_config, master->regs + SVC_I3C_MCONFIG);
> +		master->default_speed = true;
> +	}
> +}
> +
>  static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  {
>  	struct svc_i3c_master *master = to_svc_i3c_master(m);
> @@ -624,6 +667,8 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  	      SVC_I3C_MCONFIG_I2CBAUD(i2cbaud);
>  	writel(reg, master->regs + SVC_I3C_MCONFIG);
>  
> +	master->slow_speed = true;
> +	master->fclk_rate = fclk_rate;
>  	/* Master core's registration */
>  	ret = i3c_master_get_free_addr(m, 0);
>  	if (ret < 0)
> @@ -1251,6 +1296,11 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
>  	for (i = 0; i < xfer->ncmds; i++) {
>  		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
>  
> +		if (cmd->slow_address)
> +			svc_i3c_master_set_slow_address_speed(master);
> +		else
> +			svc_i3c_master_set_default_speed(master);
> +
>  		ret = svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
>  					  cmd->addr, cmd->in, cmd->out,
>  					  cmd->len, &cmd->actual_len,
> @@ -1346,6 +1396,11 @@ static int svc_i3c_master_send_bdcast_ccc_cmd(struct svc_i3c_master *master,
>  	cmd->actual_len = 0;
>  	cmd->continued = false;
>  
> +	if (master->slow_speed)
> +		cmd->slow_address = true;
> +	else
> +		cmd->slow_address = false;
> +
>  	mutex_lock(&master->lock);
>  	svc_i3c_master_enqueue_xfer(master, xfer);
>  	if (!wait_for_completion_timeout(&xfer->comp, msecs_to_jiffies(1000)))
> -- 
> 2.34.1
> 

