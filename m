Return-Path: <linux-kernel+bounces-174373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6F58C0DC7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27CE1F22CAA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E80B14A636;
	Thu,  9 May 2024 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="a6emw48k"
Received: from SG2PR03CU006.outbound.protection.outlook.com (mail-southeastasiaazon11010001.outbound.protection.outlook.com [52.101.133.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDEC101E3
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248245; cv=fail; b=r9DSjp5wS8bA4D8mREJ/1YdyOlYO7luyTmGcoc5nNJmuSWWe/zNq7DHY8rClkSx2deWm4qSH0AECgfTm6DNERysyFVppPKEHHf5Y1N67Bn5NsmOMSmOZE4rmRmX+3StrM9cut0KwzlLciQ6sL5WK9RSSefmjs8wlQu2bnBGPi38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248245; c=relaxed/simple;
	bh=+bq+oXL4xxQ9EWm5RteLOgm0f3Kkzeb51lKw7lrkx+Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZljKZ6azpxYpPl1loGuT9CwIkyHMYpCg5Rm3VUDWFkN++PowKybORoI5YMZlgXKeCeGHiNpC4wOcuQTGHaflcw3BtNYh6GeQziT6CdawCD5mJeuUmvwJEUaDbFnjaBJ4+AQdRliw+fUM1u/29kHTBVhmov36nVlBZASdPIpLxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=a6emw48k; arc=fail smtp.client-ip=52.101.133.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=io8j3GwHyoCBETH/0VHVe6nHZXT7uRiwkmbjKlP7h5h+QkLt0UjejYixxNc6h03c7cqp+Zn520oUW/EI3OUlMvF9WR4I2QmaoBCifGrKeHrwbgoXD9I5GVlb0LPPVAjUYIBmJWK+4DNl8rx8VEwAzrq8zPlZVFp0UW3LS2CCNMqyLqKD5FDX209L9tfBxk0kMxy3TZKa/3D/nQRzj6kljk/HDD2Ysz8gv4N6g0Xzn2M4HOAnPqrUP2zRrogZ32v1zEai4tuTRO+O4xkoVIv2vszxecmwasRqsqE2peVn2cD8DpifIuTdq+QBs+WzgiDJ5wOyDenCJjVmkp4Itd4vNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBAHCqNjS+nRL8okVH68OkxP7wlmg4Nzy9MajaaT8OE=;
 b=nHCkKQo8pYqEA25IEWI4jLawB7QZ2wOnPKlVbgftzpr+J+L+mp2gE98rYRmFkZZd+tzD3PUF30dk6Ly7zRqxzVDTljmCww9EK3H/8tOX+9gaCIdWiUWzLmoBhtwS37BoB9HSn8TbRuqsXX/S//lW2NxlsmHeIR/ZwbriPhi1s004mTPHdomkMXpOTkvhyy1m0L4sknyp3DtF6q+Us83+YGr5FgGGJyalNVYaZ5f5+UWqkJusHe9hcYtlVvkt2z9kgB9+LyLEkGfKmkKTt12VC5rsu44hFrWOa424sC9LlO9yrGlgtCe80NWhONQB4+s96wVv+mAuUMcsNak+kdzt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBAHCqNjS+nRL8okVH68OkxP7wlmg4Nzy9MajaaT8OE=;
 b=a6emw48kMIfhKP/jvG8mEuz+98ex8d1NivtL5bZnshlu19rMxqebgNz3vKGax9kc0bFctxloZPe0izlFujv0/ntTzuk3xSwD4Wug0W+6t1YxpfRnj/+BbrMwXVnUXuPO/OGH5yoYxXCuUHM057+4nW4SVIC76+yAlDnfyZ2K9xc=
Received: from KL1PR02CA0028.apcprd02.prod.outlook.com (2603:1096:820:d::15)
 by SEYPR02MB5559.apcprd02.prod.outlook.com (2603:1096:101:54::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 09:50:39 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:820:d:cafe::3c) by KL1PR02CA0028.outlook.office365.com
 (2603:1096:820:d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Thu, 9 May 2024 09:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 09:50:38 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 9 May
 2024 17:50:35 +0800
Date: Thu, 9 May 2024 17:50:30 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Barry Song <21cnbao@gmail.com>
CC: Michal Hocko <mhocko@suse.com>, <akpm@linux-foundation.org>,
	<urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <xiang@kernel.org>,
	<chao@kernel.org>, Oven <liyangouwen1@oppo.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
Message-ID: <20240509095030.t3gnhkuntj6t3w6p@oppo.com>
References: <20240508125808.28882-1-hailong.liu@oppo.com>
 <Zjx_6F3Fti_EBD_e@tiehlicka>
 <20240509080636.bauxbgpqdluzpein@oppo.com>
 <CAGsJ_4wLF2+O2ydr8EvPqgrsOPsWStUxpzRvi3rJpktU_FSP1w@mail.gmail.com>
 <CAGsJ_4xqg7+xwsbXpU1yp_HkTBcpJwRN-ErEwzOZx915hgsyrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xqg7+xwsbXpU1yp_HkTBcpJwRN-ErEwzOZx915hgsyrQ@mail.gmail.com>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|SEYPR02MB5559:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7e2c8d-e4cd-440c-23dd-08dc700d7b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yImaRPJplACeYLZB73H5azWMxlUFcN1FWzF7asqNufGJctwAvQg5PoWljtr3?=
 =?us-ascii?Q?FANeTahEFyZ2wIDiRGEUt/olmTou0YLfpnyp0YHgAPxqdW+VCnvuY241X+Nq?=
 =?us-ascii?Q?zwH7yJ/9Cukdr7weVEbXpt0Cau8gymgxCiOvvepsfODlBdAZYMpdwziz7Bwa?=
 =?us-ascii?Q?t2ZV1ekmYrA+0Gp390fXSjzPxMEDXp8IEPMI+BJEEdHB40dPrIQHwXHejSqZ?=
 =?us-ascii?Q?uN2rcB7CsaP/fHKFXNhLL9IQ0WDCJpPZ8VxCyYdzOMWLDV9j1WHjIquE/l1t?=
 =?us-ascii?Q?uHqggBH9cL49Buuk1qKB0n3Ue9pBFimX25mvHo7D2/tk7wPHFMw2ylUpCLFS?=
 =?us-ascii?Q?NVeAvQoR04Sjy8NlzeK2czp9G+jLmBHHAI2+TnvnOoKiMq6lsULLHZPQSdu2?=
 =?us-ascii?Q?HTuvgjL4+XbaErP3r/KFtAEyQhY1wSd6bNYTkGgwaDam3iOo/O+qCyGFegLt?=
 =?us-ascii?Q?tl6pjsTnsa93RdXusZb8k2wDCjw0PFUOP5u3I56Nb8z/vQyrlgVdOjXGQemf?=
 =?us-ascii?Q?selFgGsiZxGo8S+E03OaTx94s4mXNKG3DsxVzk4x+M1fClMbhFTIv0RrfQG3?=
 =?us-ascii?Q?t4mYluhtBkmIAU5pFyR9f+bmsOUmxfT78vwgLuWE3J7GUUfaqrNlXcZveuMN?=
 =?us-ascii?Q?/6b+3yKIUrYfyx8RUf/hfky6Lk5WktZjUjZCZ9mRbcMMqMnBefzbSqSapJpe?=
 =?us-ascii?Q?AkFT/fhFniPXapSmlIHWm4Qq0iasXi4BO0uRRO6oEBAHiMqXpu8JhUYt4NQ0?=
 =?us-ascii?Q?xLyborQJ5VvYKvn/RKjNIuRmmJLFTWx41IeobXHHG28EkbjtbG11askqBxAm?=
 =?us-ascii?Q?GcnmBFm7AprxiWS8VO6FadByqY6lwYzQKL8dY+w8M30ELKWy6pCJFAi9yHoh?=
 =?us-ascii?Q?J2Fnf6wTwAoKPVz5Cs8XpOiYyANHDmRSDGxEW2HuIeKiNdnYFUdIHlzlGAYZ?=
 =?us-ascii?Q?UbE0zE4qhb/f3rVnWsg73pmA7BF6DXh9V6IpyNHQ9afyA5X3Vt2/dPYKmXVp?=
 =?us-ascii?Q?t18mdWAIDl4e7a0CDiyoCdN1JOrhT7zdDCNdmD9c23LhJG91syJXVZ8Zuz08?=
 =?us-ascii?Q?fOWKtmECQsomS2E6tuNHpDKkEHfF2gd7EA+GY8ilvRQzgob9/moYVPqRCxVq?=
 =?us-ascii?Q?o03dI5wsrTkLpTVXXLu+cDeu/GxzraGk5qR1FIgPl9zBICXk+8sh+Jz1+hkC?=
 =?us-ascii?Q?3G2TkQL5WwHcrNnJx+DxuWb3qPCFjdUGzuPwk3wF9HF+r2V3SIQh6IJUwUeR?=
 =?us-ascii?Q?NIlb7HVcw5buwueF/fTGgP1r4LW6UMW7jhEV6qo3w/CzpIgV2r2K6wmybjt6?=
 =?us-ascii?Q?JRCg/UA8Iat3zcWNMJYvw6LL4dEqdezWRt4SFd87z5sRNWhjcV3lfhTM+izB?=
 =?us-ascii?Q?EkzT+SHg2rPEeY3Qb4Oe5pPZ2gkL?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 09:50:38.8462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7e2c8d-e4cd-440c-23dd-08dc700d7b95
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB5559

On Thu, 09. May 20:57, Barry Song wrote:
>
> Upon further examination, it's not a bug, but we can still utilize 'nofail'.
> The current code is very hard to read about gfp and "nofail" :-)
>
> maybe:
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6641be0ca80b..7c66fe16c2ad 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3498,7 +3498,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  {
>         unsigned int nr_allocated = 0;
>         gfp_t alloc_gfp = gfp;
> -       bool nofail = false;
> +       bool nofail = !!(gfp & __GFP_NOFAIL);
>         struct page *page;
>         int i;
>
> @@ -3555,7 +3555,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>                  * and compaction etc.
>                  */
>                 alloc_gfp &= ~__GFP_NOFAIL;
> -               nofail = true;
>         }

Thanks for suggestion. I think that makes more clearly. Will
try it in next version.

--

Best Regards,
Hailong.

