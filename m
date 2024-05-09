Return-Path: <linux-kernel+bounces-174093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD0C8C0A2D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA10D1C22051
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D291474A4;
	Thu,  9 May 2024 03:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="no81Tbu9"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2041.outbound.protection.outlook.com [40.107.215.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C0913C3D3
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 03:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715225615; cv=fail; b=HR3roY41ZDFdc9iqLlWPVR8cPGwxy6WUzz8L1lcnl7AoMK4JLDQU92+ZMxzTJ7+SwN7GekZOc65qWOWHMmSw3f0L8BCL1wBSaXUCIsYH4EVbvECFzJLw8AGRsKejrbFkQhsLiPPVOf8UtSlcXyGiVe7iFafO/Yv1fYHO2nKI39o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715225615; c=relaxed/simple;
	bh=ZhGzcs4QM3SyHqRLSfZvzO6lkMb84TD1IwHOHYXUtDc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omtfSCJDtlOxTmxr7GkEex3rW449WQ2RpVofS1X9K/64reR1kMJ8T0w9qzjnu1O9f5coPQ3Wp5CNTjPrvXZ+/vOafyGSDgA5nmHYgpXBZhzEL9SIQ1nqbXfvyWkCkyX+FdrQWr+B3YS3K2SAd1vmTQuvZW6NRMWUV+2a/28dGUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=no81Tbu9; arc=fail smtp.client-ip=40.107.215.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvFmBHA6PzUb1zVp/fNJ/8mVSurQ+ShZ8CWoBTbavOOZTr7mlEp133ph7FTLp+kwgGHwhd/avY9YOZVZaUWG20HXZJuepjmkpb4P/LAY1b0dJSWGjxASg85TZ7KDSzLwZnG7D21UY+ZhJNCFrx/EPq6/esw7nh59prQ9wlPbtfrCStK2Z96W5Eca0jEbzia2NYY+y+aa13IBxY1wHfuUR10jgO3taE926zYfuZt95NzlSjsV+MG781HA8hM+gZmmZfUWJjxRNoZ+MfYo79sfZJRKHEyfAkpi9qsJF++wZ/yvWDMUkxr6bsGMzxp/Oy+fWovev9ndWboF0SwYZeDhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5h6mhw5RkzKttb1dqqce10eCGu5vLJIw4Hhy92w8GWw=;
 b=JZ2DCfE6RAQaB/o8NtvD+W836djJfmu5tEhbdYRBZLf4R/H+Xq7OgOaht9BoQe3stNqaN6zBt60FxNgROHgPoZXm2B7uXGeu83cLswFLDRgJLiVlBY+/xyUqHu8CR1+EfQgD2xF0Zee/jMqqgCQYrZYNDiLWvQE4OTiQixZgWh0nTr05vVmSe4usIewQnq/hK4lyP3WNZUq5wZOZsOW9pvcL7GIa2Omccbf/Tr/gz1560nSUiUwpZBMdlOvmbJnI+UUSA5wHMDC8b/TdBOiaVChU7zj5ccTeKudOuKX7JBsgRGbSwUEBdXhvfx9pPKZSOqo6+kL1ZdC8LfnjlYYVLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h6mhw5RkzKttb1dqqce10eCGu5vLJIw4Hhy92w8GWw=;
 b=no81Tbu9IvcKQb38R2Jtmg9Ja+gBXH4iSy0Y3dptrlKR2HuJMi6Va1Eqa5fdBiftBgC8hQsUqlCQT8G3kOkMynmw6c34Tn8d6FZAuPf7Yw6QJ140ffUPihMQJC52Kq4mx47lkqQ1UsweOS4k3+y+j38UyBq8MG0HJwD4aH08kK4=
Received: from SE2P216CA0036.KORP216.PROD.OUTLOOK.COM (2603:1096:101:116::18)
 by OSQPR02MB7741.apcprd02.prod.outlook.com (2603:1096:604:274::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 03:33:30 +0000
Received: from HK2PEPF00006FB5.apcprd02.prod.outlook.com
 (2603:1096:101:116:cafe::af) by SE2P216CA0036.outlook.office365.com
 (2603:1096:101:116::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47 via Frontend
 Transport; Thu, 9 May 2024 03:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FB5.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 03:33:29 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 9 May
 2024 11:33:29 +0800
Date: Thu, 9 May 2024 11:33:28 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Barry Song <21cnbao@gmail.com>
CC: <akpm@linux-foundation.org>, <urezki@gmail.com>, <hch@infradead.org>,
	<lstoakes@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<xiang@kernel.org>, <chao@kernel.org>, Oven <liyangouwen1@oppo.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
Message-ID: <20240509033328.q2gwgaurpeg2mqqi@oppo.com>
References: <20240508125808.28882-1-hailong.liu@oppo.com>
 <CAGsJ_4xN0MBz_73wUvMp74upd9SaQ+TCRJufEj26Y619Rtr7Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4xN0MBz_73wUvMp74upd9SaQ+TCRJufEj26Y619Rtr7Zw@mail.gmail.com>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB5:EE_|OSQPR02MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: f86adcd9-af13-4427-3189-08dc6fd8cbbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzJHWXFhVGlyY0VvbnlUamU3emNSYkRMOThIWHpKMElzMFhiejNOR3JrMndm?=
 =?utf-8?B?YzJXckE4U1VTTTA1Y2pIZXFEYnBOL1o1YUVlQk4rRTNaYUszNlVucHQrRG1L?=
 =?utf-8?B?ZHliQnRjV1RWUnV1bXc5dGtaQ1BpN1AvME5nT2E0WTdYYWlaV0laUGc4WDQ5?=
 =?utf-8?B?cXZvQ0o1T2ttNTBJNUEwR0Q4ZmtEaEtPd2lyUlhWMWg2c3NLdFRLVjkwUGVX?=
 =?utf-8?B?cTFWR0xNd0pmbzZScmF4ZWlXVUZYeC9rTVBPbnRYUjFFR1RFakJSVncxNTlG?=
 =?utf-8?B?ZHhjRDR3bVlVVVZMWk4zZ3lDNXhhMVZSeHpUUXMrNGVKY3hQM0pPNGYwb1pM?=
 =?utf-8?B?WlovR2w4dXRFb0orRXBESlZHanVKdk5nNjZ0elVqK0toN3BtbUZZSzZWcnhR?=
 =?utf-8?B?OG1qS2kxT1BKeEVicHlEbmkzdHllR2doT0k1T2R1R1YzSlpyQVlndDBFUnZ1?=
 =?utf-8?B?SGRYS0VDRzZhV0dxUU5YUmNibHVmdEhVbTE0eGdRSEZQOU5DQkhNcUV6TC9G?=
 =?utf-8?B?U2twTE5MRWdIMG1JTFBNWUlWVCtaOGpnNHZRdVVraVNuMVVYNXhUaHlvejht?=
 =?utf-8?B?alJKRlJyeUxFMXhKcHgvNVdLd3UydjQvQzlJemtGWkZHVzVXTk9TOFJBRWhE?=
 =?utf-8?B?TXB3dWRCbzc4dENnZHplVnlDR1dlbHNOc2pQNUNGTi9sTnZ6aDRPYUdnWmQ1?=
 =?utf-8?B?SW9iUTZvbzhuVDhoTGJuWDl3Zms2M1FxWDdjY0JHSjMrdlp3bjA1UjVSbXBk?=
 =?utf-8?B?WC8xdmRsMDZDWFdsaiszYXhrZTRyUkRnaStBNGp4dlA2Rmdjd2x5NzZFY1Mr?=
 =?utf-8?B?a2NwaXRzc3RhTm1CY1I0TUZNa0cxVjdDM0NiN1pQWUQvNk9RUTdjNnROaWpY?=
 =?utf-8?B?Wk9BUDB6QzVIcGhQdllHaHJIRTdTNE00dGtHM3ExS3B2b0FVTGJLbWQxTlp6?=
 =?utf-8?B?alhhdmVDbmo5WWJwZ0MxZUtCZ0l5aUYrNzV0VFFwU3A0MWR5RE9lZmZudjRM?=
 =?utf-8?B?SEI1ZUVCdktZNFVncS8yTTlLTVNhZGlIdXN5VzA5M1E2NWwxZEVaUHNqcVg1?=
 =?utf-8?B?K3FmS0Z2QUl3YU1Xbi9mWkI0ZHhGV05CenkvZ2NzaWQ3NzZ6dktqUTR3RVBq?=
 =?utf-8?B?UDdWY3RuTXNldXVsd3k0SWFGQ2hUMGJrYUsvams4Ulc3UzBRdUdHbE85K29Q?=
 =?utf-8?B?RlAzTVFiTFhZZjJXOFArV0QzL01ub0RWUEdMOUc1emdtU1E5dE9Zd0dsbWNn?=
 =?utf-8?B?UEFyejdxTTNjSkdEcFpoUWtNU3RzWmhPOEE4R041U2xwdVVFMkdjbDd3cGJN?=
 =?utf-8?B?Z2NYYnk0ZExlRDBIZTZOMVBPMENkM284bVlPSjZCVmE3YktBTTFJSTBVMXU3?=
 =?utf-8?B?cUV2RXJoVFFUOGVyUXNDekJaaUlWOFRYNHZaNndGRUhSZ2FJcjNnbEQxc2w0?=
 =?utf-8?B?WkF1T3dsVi81ZDJWWUlqZjBSRFMveng5MmFMckljYTc0Ti8yMmpTa1FYZFRZ?=
 =?utf-8?B?Q29KVVhpMS91NENCVzY3UDZuZENmbHRycXNoeStyeERpLzljNkNxeFdFZVpT?=
 =?utf-8?B?T1FraTBQNndBRVN2MDhTNEdqb3REWjUzeXVyLzZYU01OUHF1N3hVWC82S1lR?=
 =?utf-8?B?MldCMUNEZTVqNWtzaVZrcHEwS09EZWdBMllDUnJheU14UnErdkFzcjkyYzg4?=
 =?utf-8?B?Z0xhVS9YeEF2Y2d0KzE2ZXFObW9CUFFWQmN0UHc5TkY0TVQ4NmtLNVplRHhy?=
 =?utf-8?B?bUg1aDdCUGdwdG5UUlU3Y2ZXZ0VwRjhmSERTd3lETXoxN0Q3d0FCRnRNdGtE?=
 =?utf-8?B?ZEtQd1hLVUNBQmJtUzE0dlVXYTIySGF0SHVoRGpCVXduV3lDS0w3aGZGR2dO?=
 =?utf-8?Q?fT6ry2li/gzfM?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 03:33:29.9867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f86adcd9-af13-4427-3189-08dc6fd8cbbb
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7741

On Thu, 09. May 14:20, Barry Song wrote:
> On Thu, May 9, 2024 at 12:58 AM <hailong.liu@oppo.com> wrote:
> >
> > From: "Hailong.Liu" <hailong.liu@oppo.com>
> >
> > Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
> > includes support for __GFP_NOFAIL, but it presents a conflict with
> > commit dd544141b9eb ("vmalloc: back off when the current task is
> > OOM-killed"). A possible scenario is as belows:
> >
> > process-a
> > kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
> >     __vmalloc_node_range()
> >         __vmalloc_area_node()
> >             vm_area_alloc_pages()
> >             --> oom-killer send SIGKILL to process-a
> >             if (fatal_signal_pending(current)) break;
> > --> return NULL;
> >
> > to fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
> > if __GFP_NOFAIL set.
> >
> > Reported-by: Oven <liyangouwen1@oppo.com>
> > Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> > ---
> >  mm/vmalloc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 6641be0ca80b..2f359d08bf8d 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3560,7 +3560,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >
> >         /* High-order pages or fallback path if "bulk" fails. */
> >         while (nr_allocated < nr_pages) {
> > -               if (fatal_signal_pending(current))
> > +               if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current))
> >                         break;
>
> why not !nofail ?

if order = 0, nofail would not be set true in bulk allocator. in such a case,
it is still possible to break early

>
> This seems a correct fix, but it undermines the assumption made in
> commit dd544141b9eb
>  ("vmalloc: back off when the current task is OOM-killed")
>
> "
>     This may trigger some hidden problems, when caller does not handle
>     vmalloc failures, or when rollaback after failed vmalloc calls own
>     vmallocs inside.  However all of these scenarios are incorrect: vmalloc
>     does not guarantee successful allocation, it has never been called with
>     __GFP_NOFAIL and threfore either should not be used for any rollbacks or
>     should handle such errors correctly and not lead to critical failures.
> "
>
> If a significant kvmalloc operation is performed with the NOFAIL flag, it risks
> reverting the fix intended to address the OOM-killer issue in commit
> dd544141b9eb.
> Should we indeed permit the NOFAIL flag for large kvmalloc allocations?

IMO, if we encounter this issue, it should be fixed by the
caller, not here.
>

>
> Thanks
> Barry

--

Best Regards,
Hailong.

