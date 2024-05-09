Return-Path: <linux-kernel+bounces-174089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B491D8C0A20
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19FA1C21C8B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9773146D71;
	Thu,  9 May 2024 03:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="FQfDhjbN"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2067.outbound.protection.outlook.com [40.107.255.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF46D517
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 03:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715224963; cv=fail; b=Ow7S9jgwRB73a8LRm0fboNkcRNfMk5oeyE9shPCVUqYAQ/RaX5ZUMAXdLTLyt+kDBxjLm6E/RljeNX9G9RhIqIZbhbRTu5jCjGkYb+1VHegDQHIsAhUEo1QGdU/26Y4A0npM3Gqbgc+9wOmwpyaFzFgpJ9YUcOE4awVLV8dv3v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715224963; c=relaxed/simple;
	bh=wRcsWkKyUuh1PpAgZf9a98EnxuIfN07ZHvf4bBzyubI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4Z+H+QtDh+QuAFiWedmRE6n4dTkhnrYgfPnVCtbzu1+71jzTLrB5WvqNR8PEMsHKSWoDnJssHosfmATNUT+jrNcC0n9n9Axh1eD08FR93EqmvtGitQEyPX43PwIlCvdhV9ekFMAKjsYTab3MOzFg1/P//K5UET0WfHW1w39CfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=FQfDhjbN; arc=fail smtp.client-ip=40.107.255.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+92uK2a3KCd0FU6I2YI9A8dJyl1bk1zKHolSkg7Kw1dCZtlEqBzZtELQ3oAtv99gPuyqvDy/lJREbTxj4YQE593jtykS9dL/5CR08Hk96D7Id+WHeOuJbTFudp2SGhq53Kqv4FGHWWrm4sMmWVYGFtl/L9cL1veLhh5ggDhnsynwNTJhbPh0xfM2QcDzZo21suyY1l/psMum96Fb+L7vDxJC5jbMjcK0m2jdCK6Sr0tqQXvkR0+Z8EQdaPnhwv9gCJ1FrNhUS5mPyEybRScS6HjaE2E9s6/9IE6hKFcodGdC5veIPNESEtY13H9o6lI0AiPf4ajqKUB5nIx1+LT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDy3DBx4GNoLB/Vj8n3bqvRKYtIvbm70I84kBSSdlQM=;
 b=LMOGuJUe47+ZCTDVfi6bduPJWkAv+1guiYzCx3CDNqXyWWwDuNYtivW4bhGrcGMSWrmn+ofdV3sSFaxmYfzvJAikSBioobXN1SuuugdPG3dcaUlxt++LM+cGbgw2n5hEvqMPQv7dFXM952uH4zqKT1PCnHqwR9riNyzK7GvkRhdZSWrRbF5irCs9DNg4FWss92Vdfh5SKOJOdvksUIIrB4cbolFjWFIjWljSX4Ui2gHXGsR1o6XSaA2Ik2+mmvexpR2WXwHkr4Pls30UpY+MA4dnSF8e4rFMw2sIVVhe8VA7xKJOCP1RRAACi4YEwgmnSEWIak9gJZWfo7eKSLl9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDy3DBx4GNoLB/Vj8n3bqvRKYtIvbm70I84kBSSdlQM=;
 b=FQfDhjbNtSHg6QeQo9A6u5Oqc6jyy4AkTL9WqwUsn6N+ademTdkAf5YMeYuMlu8K6tlJeIKmUgPOjbtNE8WhbLo4GhkERyOQ71W+UzZpUMlIW6UIvwGYXuEKAkAqKr+JdX1TDlwSS7DIVlx8Cl68fTSHcDNH/hO2+mN3a1gQsC8=
Received: from SG2PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::31) by KL1PR02MB7521.apcprd02.prod.outlook.com
 (2603:1096:820:118::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 03:22:38 +0000
Received: from HK3PEPF0000021B.apcprd03.prod.outlook.com
 (2603:1096:4:40:cafe::e1) by SG2PR01CA0127.outlook.office365.com
 (2603:1096:4:40::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Thu, 9 May 2024 03:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021B.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 03:22:36 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 9 May
 2024 11:22:35 +0800
Date: Thu, 9 May 2024 11:22:30 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: Barry Song <21cnbao@gmail.com>, <akpm@linux-foundation.org>,
	<urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <xiang@kernel.org>,
	<chao@kernel.org>, Oven <liyangouwen1@oppo.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
Message-ID: <20240509032230.72vtl2cjtg72ydds@oppo.com>
References: <20240508125808.28882-1-hailong.liu@oppo.com>
 <CAGsJ_4xN0MBz_73wUvMp74upd9SaQ+TCRJufEj26Y619Rtr7Zw@mail.gmail.com>
 <20d782ad-c059-4029-9c75-0ef278c98d81@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20d782ad-c059-4029-9c75-0ef278c98d81@linux.alibaba.com>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021B:EE_|KL1PR02MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: e7106abe-e28e-408d-00ac-08dc6fd7462a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|7416005|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFZldlhIY1cxSXN3N3RUOG55U3R4RXpSTndWNkJHZmVPSERMOFlrbnE2UnBr?=
 =?utf-8?B?Tldjb2JuazBadEVWK3VhMWoyS0Q2K29rU1FKc3pXY2xlWGYrdFdNcGozem5I?=
 =?utf-8?B?eVBvTlB1d204djhBU1BzR2x2Z01lVFp4NXhzcU02OTN5RE5LT2Q0SkJLTE1l?=
 =?utf-8?B?Ry9GM25xOGpaQkZBSUowNFVvY05hV2w1WHRXa2d6VHUrUUZRTmlxOU5paVlq?=
 =?utf-8?B?dnFNSk9PM1ZEWjhIM01qNGtneFZ6OWtyNHVFdUhQcXE2MUUxUmVaNDJTdWxH?=
 =?utf-8?B?bVFpbnhQQmcxK2svc1p5UTZwM3lmY2I1TmRodlRwcGsxYWZiVDVwQ29vSG13?=
 =?utf-8?B?T0dGUVA5cnoyWXMwWnY2d2ZKV3VPZ2lYWGhMaHltNzJhSWx1WFRLaDlmVG5Y?=
 =?utf-8?B?cVFRODBQNjhlSGcwOE9oYXJtbE1ZOFlXVWE3cjBUWEZiM0RubjY3aCtqampw?=
 =?utf-8?B?WXJxY0ZMcHBTY2RSaW1NcjljQTg1Mkh0aG0wU3gzQ2IwU2hweGxyMXJuaHcx?=
 =?utf-8?B?T3ZXU28rYmJBeU90cDJ1Rnh1QWwxbTRzSDlVdnFHWHYyTks4Y1E5eUhMV0h4?=
 =?utf-8?B?NUJkWDBTUFFZYWZxL0Z2ZUtwajZYSGVwd2c2aUZEUEc0N3ozM2pIVFBTVnhz?=
 =?utf-8?B?Sjg4WVo2MU5JbSswbE9oZFViaXIwTldFaENZYkdrRG4zWWdSMzhPYXF1UlNa?=
 =?utf-8?B?SXo0eFZsSTRySTREWU5XWjA2S3VVeEs1ZDY5RE9hZlZkWHZPVFNzaDF5Rm1r?=
 =?utf-8?B?UEZYeE1wQ0llRVFjV0hIY0FZTDFCalpReUJvSzR6RkxkZjMyNkM5T3lDMUti?=
 =?utf-8?B?TTgwNkhWRE5TZHVVUC9wT0w3YWRVNXNWOVBWVllzSUlEU2xOSk93Z0xCaFdh?=
 =?utf-8?B?WEtzYWpiVzlxYzlwT3YrQ1A2anVDaEtpLzluWDZoWTRDVEFtWkFqZFJyUDkv?=
 =?utf-8?B?L3RCemVWZkpValNkWEh4N1k0d2Rka0N5R2lyek4zWlQ3eFJid2N3NThzeEhk?=
 =?utf-8?B?TjYwMGZSQlk2OCtldU1QNXIrZlhabGFEZlBVVlZLNjQ0KzB0bDQ0R0xDVUpy?=
 =?utf-8?B?ZndSaGdaTHBJRUtzZ3BkMXNVT29oenBWZmpsM3YzQ1hkZ0JnV1JSYm4rbWF2?=
 =?utf-8?B?NWlZREI3bm5SV3laNTVhWWhqN3VsdWlscEFEakFhamRwTUpqTDdzc3B0RzFW?=
 =?utf-8?B?ZmlwZm5yNFZoRlpsb1AzZVlBR0lhaE82ZXNBM0xoTDNoKzhiTVJONVROVWIv?=
 =?utf-8?B?VUVKcWdqcDRCRklUZVk4TnhBOER6QnpKSGxLSTFYZzFpRU5ucjBxNTFzQWV1?=
 =?utf-8?B?VGxnUE14Skt3bHpmYlR2QWF4ZGZBVlh1dlFNa3RNbmd5eVByN3hudnMyRTF2?=
 =?utf-8?B?VGVCd1dIVG5ZdFdhYTFjekxYbWdqNFJkR2k0ZUw1Y3Nwbk9LcHhZL201ZVAx?=
 =?utf-8?B?V09yWnJmOXMzZ3VHbTZ6MktHcXRERUVpbUJMdU5DVExmUnladkVYaXJTTnp5?=
 =?utf-8?B?UVNReC9TMTNkalZIRXNSbWZYOTBMcm1rMDV1S2pBWTRFcTJQdkNJejE4M2J6?=
 =?utf-8?B?SGNnMkNvZUFCMjFPWGw5OTV6MzR6enJYdmJ4T2cySkIzY1grK0Y4YzB5eDNW?=
 =?utf-8?B?bzdzUUNWV0s4SUY2NTBsc2p1eHRqRU9wbDRVdnlyeXpXQnZWZEg4OHp4M2hv?=
 =?utf-8?B?QW1NN1lMR3BaZmgweUJPcVM0clNkNzAyNUg4MW1KbkcvUngrNHFqZmJKZlBh?=
 =?utf-8?Q?VCRXgiJgyweu6HW9GSeTa7Np41EVmfr6S4eW1oW?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 03:22:36.4014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7106abe-e28e-408d-00ac-08dc6fd7462a
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021B.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7521

On Thu, 09. May 10:39, Gao Xiang wrote:
> Hi,
>
> On 2024/5/9 10:20, Barry Song wrote:
> > On Thu, May 9, 2024 at 12:58 AM <hailong.liu@oppo.com> wrote:
> > >
> > > From: "Hailong.Liu" <hailong.liu@oppo.com>
> > >
> > > Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
> > > includes support for __GFP_NOFAIL, but it presents a conflict with
> > > commit dd544141b9eb ("vmalloc: back off when the current task is
> > > OOM-killed"). A possible scenario is as belows:
> > >
> > > process-a
> > > kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
> > >      __vmalloc_node_range()
> > >          __vmalloc_area_node()
> > >              vm_area_alloc_pages()
> > >              --> oom-killer send SIGKILL to process-a
> > >              if (fatal_signal_pending(current)) break;
> > > --> return NULL;
> > >
> > > to fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
> > > if __GFP_NOFAIL set.
> > >
> > > Reported-by: Oven <liyangouwen1@oppo.com>
> > > Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> > > ---
> > >   mm/vmalloc.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 6641be0ca80b..2f359d08bf8d 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3560,7 +3560,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > >
> > >          /* High-order pages or fallback path if "bulk" fails. */
> > >          while (nr_allocated < nr_pages) {
> > > -               if (fatal_signal_pending(current))
> > > +               if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current))
> > >                          break;
> >
> > why not !nofail ?
> >
> > This seems a correct fix, but it undermines the assumption made in
> > commit dd544141b9eb
> >   ("vmalloc: back off when the current task is OOM-killed")
> >
> > "
> >      This may trigger some hidden problems, when caller does not handle
> >      vmalloc failures, or when rollaback after failed vmalloc calls own
> >      vmallocs inside.  However all of these scenarios are incorrect: vmalloc
> >      does not guarantee successful allocation, it has never been called with
> >      __GFP_NOFAIL and threfore either should not be used for any rollbacks or
> >      should handle such errors correctly and not lead to critical failures.
> > "
j> >
> > If a significant kvmalloc operation is performed with the NOFAIL flag, it risks
> > reverting the fix intended to address the OOM-killer issue in commit
> > dd544141b9eb.
> > Should we indeed permit the NOFAIL flag for large kvmalloc allocations?
>
> Just from my perspective, I don't really care about kmalloc, vmalloc
> or kvmalloc (__GFP_NOFAIL).  I even don't care if it returns three
> order-0 pages or a high-order page.   I just would like to need a
> virtual consecutive buffer (even it works slowly.) with __GFP_NOFAIL.
>
> Because in some cases, writing fallback code may be tough and hard to
> test if such fallback path is correct since it only triggers in extreme
> workloads, and even such buffers are just used in a very short lifetime.
> Also see other FS discussion of __GFP_NOFAIL, e.g.
> https://lore.kernel.org/all/ZcUQfzfQ9R8X0s47@tiehlicka/
>
> In the worst cases, it usually just needs < 5 order-0 pages (for many
> cases it only needs one page), but with kmalloc it will trigger WARN
> if it occurs to > order-1 allocation. as I mentioned before.
>
> With my limited understanding I don't see why it could any problem with
> kvmalloc(__GFP_NOFAIL) since it has no difference of kmalloc(GFP_NOFAIL)
> with order-0 allocation.
>
I totally agree with you. so I fixed this in vmalloc or not in erofs. However,
there are still some extreme scenarios that cause vmalloc to return NULL,
such as vmap failure. Let's see what the mm experts think.

>
> Thanks,
> Gao XIang
>

--

Best Regards,
Hailong.

