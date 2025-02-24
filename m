Return-Path: <linux-kernel+bounces-529576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE64AA42809
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C225E3B8AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD745262819;
	Mon, 24 Feb 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QtwTRJ9C"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E82725A347;
	Mon, 24 Feb 2025 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414926; cv=fail; b=Sjm25HbBIMV1ueGjRIzQBduo/tG4nkq1l+sRdJB4cBgTXLfQ3rFILI8RoMUoJGBEjt6eclfH4sYnYlQ0eondito4IVLnJYpPBN4Niwbb6Gm+uJVFZvTIMgO0YhO40qyUg66LMyK777vl9fSCsS3Qt8JuPv/UbgYhOTwK3Ruczmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414926; c=relaxed/simple;
	bh=/ZVGCEm0aSEGkxQJpOze3RoBBk6INVEJhG2QlpV+4Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CoIpFr+36/mSXPtuBCCPZ393K4IIa8PRfKwWH6pykeZtrk/1N3DeAvbfDITH4ZBoSaiEnyz2BU1CgEFftjCDGX7Pz7m4k4FgKvR95bQvDLu3xq+Zhj4TEVJxIfYPZbONYF1cxS46RsyJegiGqOotE70NssFiwr7w4z/Hq++fIbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QtwTRJ9C; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/CRO8KCjwHO6RZadoBr+g+6JjgURWORsWcEuQ7YkT6iC5tQ81qnEf9z6EOI7d6T5MQRK7lGvFtbC+8T4qxGH0WGaRD0gcqbG4ft3YbUxJCy27HVS5sjIwgq1mNfNU2SYZH5NQ48tKv3vPTGTVmX7O2oQuPW3TxAonfdFHDUmTUhsQQf5/vp6Ci3WqUvwhEp9f9S6473I/nWrYgtd6oSFrwQUZU56jihKgjAW2tkxxqUxpO4E8WVwr6UeIYTDVeGR3Wpy0no3PjxEGRCGRkolHiDp0IHWN7DAkGl4ZYwQwA/FFpN4i/1/r3bVtJECaTO+ZdFQUYhDLGMVoKuYjP9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zy2mxVP9r7Q98K+iw5IcXfgMcllMp5YFPxpwIKO3Ywk=;
 b=XjiE6Yn2CNofT0go9AeaHK+lT8A2f4LvK/ubCmWfhcEd/SV53ATKgg3PJR854Sp2UzMgJ6gSdA834MquFxfs4sLhrS9LIgpfPzMR9uwOchz+jn7vvQPtrVEMug2/+8MrUH8zD+ejqLpwenQgG0JmxOSbiu5aIuFbvLBs46l+CoZqeS1W/j9dwwx+Y5nfoHFii6sX/p2raHATIlWNeh9nEpt9AX0TZW3Ridqez5+Ios7riWHDeKwnj7wOT7Rbe+L+vtLtJtUNy5mIqunphiPzG5+xC6Dzns6yG3blWTzK0mf2L5Seg9eVNJWpL9qJjoTyAU73pdIZEKo86Zt7Ze26pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy2mxVP9r7Q98K+iw5IcXfgMcllMp5YFPxpwIKO3Ywk=;
 b=QtwTRJ9CSEGKUqIF9EdLeHs5v0YoZcBpzXN1lOUCveI9Hj/ohhDPYGUK8xbvyua6mI1cHsC0o3jKshokIYTxgLasW6cRIygtlBg1H5MxsCruCu4eDWelekIJYDSNnhqe9ba2WHOa9QWVDpqXuMCuyJDIHP/4ZBWHBbG53fApHpCYE5+eim+ZhROinX5JPAMpj8GuZ+631xX1gkBxhmgq2IplKm254He4XppcfwoLV84KRw1T3j+8/Nq9tRKEDSQq8/vNffb2Wuerb+v6FUZe1QroYt9mkfp4n+j9P1h7unYHf/yi9XNIXo2/uO2K7Nfbabl5EdlHJdvSklS/fvMN1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9730.eurprd04.prod.outlook.com (2603:10a6:20b:677::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 16:35:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 16:35:22 +0000
Date: Mon, 24 Feb 2025 11:35:13 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v4 5/5] i3c: master: svc: Fix npcm845 DAA process
 corruption
Message-ID: <Z7yfwXh+ZmfbhWVj@lizhi-Precision-Tower-5810>
References: <20250224083908.1880383-1-yschu@nuvoton.com>
 <20250224083908.1880383-6-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224083908.1880383-6-yschu@nuvoton.com>
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dad43a4-e01c-4476-1138-08dd54f13b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IDBoe6tAjOBEzEUSz7Hpqd5fOUA49TPoAP3ALZCOGjYJzGJ4gWjPtiC5/J/C?=
 =?us-ascii?Q?U4Zihww+qOW88mchamZ0/stLfOvodk/jrfY+wq7HeX+qEtbcAllaAdWtXltI?=
 =?us-ascii?Q?ID771GnBMLRLOgUEOUPzH3PCeBUBvlT9pOWO/82hukS5jBAQ1rQPUzX4+WNg?=
 =?us-ascii?Q?1MO8uGCjvCIlCEQK2XN6IQiENLo15XI9kqJLM45DUfmx6n/cLnf9N7aA0GQF?=
 =?us-ascii?Q?e7BqZmhbX+ZHvONLNn8Kg5hakgEw8QcoeQwg7CqOa8lCE8taLhDV/sdjfV9W?=
 =?us-ascii?Q?chU0MtkgHaXKj5VRyHrG9kjYVdbijmFYojMLj27TwEWquyELuHoarC4UO8vo?=
 =?us-ascii?Q?fPYQkSRQjWgiRfyr2dYtq8mbEgc5GCfok3UsKiyTFXdHuoNT/T+r/YjTRHYn?=
 =?us-ascii?Q?ckEGuxLbYlbI45U0xXTTtoSoaUsm0XMnazSbUZgLco1UPUWr+MOUgZ2RRk80?=
 =?us-ascii?Q?RkbWDH2SHb61aMFDFgh23xy0vrVC/PH49Ylk9YOm42sI6qX04LXHmBAoxsB8?=
 =?us-ascii?Q?xP4A2vg1WfQ2jTDn1/Mbfacp2KmYtKW4bPeQzDWbb4xtS0N5zbb+468taKzf?=
 =?us-ascii?Q?Z+zHe2oLHlgOFEza1vPo1w/wVOn8N6Qxqtiq9EaoRCEM8WIVRjaozLAFFNKN?=
 =?us-ascii?Q?ndAHpsHbSwnX770Z1PMTCdmh1P1prRyXGHewpQgMfSLTwLUM2n8wano6qRZW?=
 =?us-ascii?Q?9d8fkQnRti67y46zSX0Kt13QIR/pCBrBngGtlGJLGB/tdVSgkuUtX81DLmTp?=
 =?us-ascii?Q?2rFmjgIfsoyeQ7sq5KhezRrfxej1rzEQxh9DG4QvyhZwvvm14LEappHbwGlz?=
 =?us-ascii?Q?1BNbS9AEhTTibNicNYvfjuzBi0+gygC5dbkfgWyQHNISZHLXeFqIDy0S8F/h?=
 =?us-ascii?Q?i+FhzCBJigiXKcXv/WhG0nBPJmbFB8idWwaC+/i0TI8dReBnyMN/SK6He1FH?=
 =?us-ascii?Q?iN0hv8Rrc+frhm8wYXGQo0X5ajfmpwaBsEq/jofdMsup8CegOQ4zqvExKuBz?=
 =?us-ascii?Q?NbmYjV4g7wFb948/+cRFHHfNOtYLMrbwOPChEvCzOuPy7P+Qrm7vfAbw+esH?=
 =?us-ascii?Q?QYNgUi3Tnto25FzeH36MsevUhZLdF+9W7o7a1AS2fB7uoRvc+OWgpllc90cc?=
 =?us-ascii?Q?HdRWbyGxMDvx0+NtHSXIP5DwC+svaJS4BmhSax/qmhBCs4gvF/LSGACGbLQv?=
 =?us-ascii?Q?yurNdFjE0FoYetAnNosa9GZqysEkroaU4fgDbdTsUUbt0dYl/B55huuhe5+8?=
 =?us-ascii?Q?OCJWr9Flw1253Vqc6Yy2NXQHbxMjAkjP1o6hiI5WMljuga+4rUZBimfXEfXO?=
 =?us-ascii?Q?/RT7wePnMrzaEHc0atanszWD0DXjI00AL/57IKyvPJj8rOrFoEXTCONYJFLU?=
 =?us-ascii?Q?DrokMYeBPR/XNlPiMGnAzE32Tu92P2qNng+jvYLrBmj0+R9zqk+7ugDKceob?=
 =?us-ascii?Q?gfTIyE3/hHlveqJ4t5zG7myO8CXwBaWe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8IhzZ5RUXbPCPR/5zx/Mi9OnoxTXpGcXYn86dTBM+5pR1o0h862RI5uDB5kB?=
 =?us-ascii?Q?9QJzP9KV2DDVj05fMuyWUEKKBsma6kNGoCzRSClSlPYaYktnkhI3LqItK8cG?=
 =?us-ascii?Q?21AwNrNi+ivCJ6ixABh9ymJAeubsCstxOuO4qOPnpKwnFHMP+K+yoQM57nG/?=
 =?us-ascii?Q?al6H5jV/LSnP56P6apmD0T6kLo7pkGdEtBZsaQyzwXz5Cn/qRBCus54OvpZJ?=
 =?us-ascii?Q?UWHlbv5mVQ5iDM278KsErLsWJ2hN6OLXnKnqAKVxDJSnCGFgdEDB49wZUfEV?=
 =?us-ascii?Q?XXpqlUbiFJOMpsU6huz8kHoinDHSbqvJHLzVxC7/iaryzeCH5epyB+eVWu/t?=
 =?us-ascii?Q?yrWnaAV2WL7PbHkp14OpGOmL+VXSBvu/OIcraQa8man9sz5LR7d+X6GQWg1l?=
 =?us-ascii?Q?MpCFIMLMPEAPt5iVyFky/bN1LDCJJP0hbMnRPkMbIQGje2bBXtwJAFjKy2Mm?=
 =?us-ascii?Q?hKAom5H53lrXExZjpzzBK3tuw3VPcEXUm4i6/L7djDaLz34G6x/oAhX1we6j?=
 =?us-ascii?Q?0YpOd+9zCFuuJZk+V/IY0/i/YKruLiAx23sSu56ZLkM9wgNW0+6u675M2I7a?=
 =?us-ascii?Q?VX/WiKELtxXSunLrpssjHs/KropsssZOF27HL9MIoL3OaQVL+aTb+xptxybT?=
 =?us-ascii?Q?w3A6ojbVu0uaCPPvb+jmKLnoav6Xu82HyYsqGX4LIOK5Q/BY9rY7TH5KztTt?=
 =?us-ascii?Q?gIDK9FwaHLOBiwNG6zlcVUKxLHYRgTBFGqzDWZa3alaZWyiozu+ToADZyOXC?=
 =?us-ascii?Q?Wsxlxv0fo3nmwJ18zCXjOK3sImy0ejOtEOrSXJqgtXxkk/d91nEiI6E4ibN6?=
 =?us-ascii?Q?IaxS2ghziBeSTrI18lize+hUdM+FbubMl0DBDVcpB4mZqMMxx/COLYK32tgD?=
 =?us-ascii?Q?esozLQZifyPlwkc7j4yEwBFtxamVYYGe8WziSNhEA4IHAIuzX+1FAmJlVj7g?=
 =?us-ascii?Q?1LKNEfq+6PBWR+u/5Ob7+xjWVgq19l260wuYRMvUklGALbmVGTY1SeSFGqKb?=
 =?us-ascii?Q?GSfw+qSGKLWQq3ADhtzLC+X0U8QICYYHAiTmKVZcJ7PenAZ/bhdpQjJt007H?=
 =?us-ascii?Q?t1VRBiJEO362e5ZpRZCJo817V2pMyUvYwP7hayik0ssAxhIngLq6eJOlG8rr?=
 =?us-ascii?Q?juTHEO7nL/SPhmJYAChSEDBeLH2eZQBtocrzVBfdNkqw5K2hQxtJGMY778ru?=
 =?us-ascii?Q?QeUm4ZAyezWP4g2OApWmmEiLJfzdkmNH7p3FRqmCLV0e5crUvRBTd0us9w6B?=
 =?us-ascii?Q?5ZGyw7mDUbcm860Ua8gcOc0s0iN4L0jy1szZ8O4AetOyJARHj3OuSZl3BOz+?=
 =?us-ascii?Q?IGhgThZPHG6HUf1IeDd07wJIjX8W5ZMorkV7svQBgs93LNGOKay/rHEnk7Iw?=
 =?us-ascii?Q?3ybqC3MtqU6y2CHg38Qbki6ODbAMeZ6JISqHD34tGQQTRHSiVuBP/IkqE80T?=
 =?us-ascii?Q?foLtLBgWamsnUHFYjBVDojeyn/lgHYEp9p2GOAyzOm9Bc0Km1bCj3uLYZZgg?=
 =?us-ascii?Q?6nWMUVeijguAukjbXBTeyZJXmnU4UywpdylfuRjl/S1dLaNxmYEpoW56g2bD?=
 =?us-ascii?Q?13/KALSN3XPREvoivM3mbeAYKVcO/a1TQfbv3yrL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dad43a4-e01c-4476-1138-08dd54f13b9e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 16:35:22.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hUUvSXAZ6RxUr4SKz6adq4ibPvW3jckiI7weiMaTSp20bf1JCwCkVOegpu7cQfEHq8UxiLHISDjEMZmaIWb7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9730

On Mon, Feb 24, 2025 at 04:39:08PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> When MCONFIG.SKEW=0 and MCONFIG.ODHPP=0, the ENTDAA transaction gets
> corrupted and results in a no repeated-start condition at the end of
> address assignment.

If there are errata doc, provide a link will be appeciated.

>
> Workaround: Set MCONFIG.SKEW to 1 before initiating the DAA process.
> After the DAA process is completed, return MCONFIG.SKEW to its previous
> value.
>
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/i3c/master/svc-i3c-master.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 4eb4b8888725..403d625e999e 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -1162,7 +1162,16 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
>  	}
>
>  	spin_lock_irqsave(&master->xferqueue.lock, flags);
> +
> +	if (svc_has_quirk(master, SVC_I3C_QUIRK_DAA_CORRUPT))
> +		writel(master->mctrl_config | SVC_I3C_MCONFIG_SKEW(1),
> +		       master->regs + SVC_I3C_MCONFIG);
> +
>  	ret = svc_i3c_master_do_daa_locked(master, addrs, &dev_nb);
> +
> +	if (svc_has_quirk(master, SVC_I3C_QUIRK_DAA_CORRUPT))
> +		writel(master->mctrl_config, master->regs + SVC_I3C_MCONFIG);
> +
>  	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
>
>  	svc_i3c_master_clear_merrwarn(master);
> --
> 2.34.1
>

