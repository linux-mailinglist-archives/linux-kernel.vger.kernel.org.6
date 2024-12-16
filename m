Return-Path: <linux-kernel+bounces-446713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A45E9F2840
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 02:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512B618812B2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 01:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF7EEAD5;
	Mon, 16 Dec 2024 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="s4fCNbBw"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013011.outbound.protection.outlook.com [40.107.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE07BA49
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734314063; cv=fail; b=ix4QxIqqnsm44ooYqx1RVuArmh+xGdLg18JG8Dlpht0ezIjUof1VAhJtnXSp7SpS+1LU1RzbMDBXlpQJTuiOThcRY4I6IX+P4BLaFskITwpCqXlrREeAzi4NLcmfeq2aCmwA482nyrSZl2ufmBT7vj4T2F4jUMbaBtB4KWXKrTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734314063; c=relaxed/simple;
	bh=Zg/vCbYiFZf/FcU84fnaaS7/zGSBgiH4yV7UgLJLBP8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hneBgGcJNnrQ3Nzl/AIIYkOWX0HWqzkGIN3tAGey7AGclJuLefwkoJsU5aVCep6yRqpZTbU5/CqdhKYx2BsTUCc+/IuFWMCT+pYzhKRS8+GsLiz5Ke+qJH/3WYCftfjvESVEoaWQaUhRL9zx8u/zKpCtPTDxlS8VkjtPdjvrjr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=s4fCNbBw; arc=fail smtp.client-ip=40.107.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmurSgS6SRb7LVwNkS6Wy3uHYaY3yBVCWLqxndXQ4KMjXlTvo/cx3AmiXP/6L6gCiUNAXqBCgx9O2bSpD8OKVd1/DdveFrbogfShsnWwWyaglCxB6DQK7BYBYvIq4iW0t2wYq7Vi1T+o6x4UIWuYsldtUQtFz3FKEpmbBT8jwe+3GPynHfEuSSy7R7ra1pPmCHAFWKSTozH8eVI27nYEWFoX+SJaUmYUVBLUuDJMcio9WL5zwC622+4QSaK8DoSoFggbHOTjB/BAi/4m5oGusi+UKs0vy1deDUONukQh7vrhVGlB9ZFhzzYaf7IkL6Vv/5W9J7QmAWDRnmwNuDPzyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T24o6D3zeg0MKEbsF1kIsG933OzgUrYY29Ev/JPwRwg=;
 b=jtCyIfZX4ScyUw9xfNID+Zl/saXqiGSLW8h7vKldn4CRo4I6ec6HRAKjxDzVtv/yt8oOocoYOfv2p+4qG4qUhOmuzatDvkxRM2hTtzyX8b7K45qlsvD6HNlS7XNJIIV0PMifgQkKdaZ458Q5sY1+4pk0jwSj8zbHyvM60iSmaKTroO1Di702cZBonGMLdPGselIkWjHDfdR+OZ6UkqdfDvWqwpTeFMnhYKnzaXTUkliAdabSFwvm6BPQtZHq8NMVEiKbCJfu6WNAGzLNpO5Lx8J6weAZsUouInBDz7OTG1GD04qyWek7duzLO4pQ/8STtroh1i49BQ6eaRqpOLOhfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=google.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T24o6D3zeg0MKEbsF1kIsG933OzgUrYY29Ev/JPwRwg=;
 b=s4fCNbBwEKvmXm3AoajsV9xV5U1zNB/REv4LyBWLx1b4kRqmf4mLvyHnUUXzBlpHkXUNokUexvq0OKRK44sXV0g9+r6Hxg7iHt42ciOgXVIaFt53TtAjRz4fp3mIn+eEfszNXN0oBb27g8xnhrCNVlQBiOjfnWRLG+JA0JL+T5E=
Received: from SI1PR02CA0035.apcprd02.prod.outlook.com (2603:1096:4:1f6::8) by
 TYZPR02MB5938.apcprd02.prod.outlook.com (2603:1096:400:1fc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.21; Mon, 16 Dec 2024 01:54:15 +0000
Received: from SG2PEPF000B66CE.apcprd03.prod.outlook.com
 (2603:1096:4:1f6:cafe::c9) by SI1PR02CA0035.outlook.office365.com
 (2603:1096:4:1f6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 01:54:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CE.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 01:54:15 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 09:54:14 +0800
Date: Mon, 16 Dec 2024 09:54:14 +0800
From: hailong <hailong.liu@oppo.com>
To: "T.J. Mercier" <tjmercier@google.com>
CC: <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <yuzhao@google.com>, <21cnbao@gmail.com>
Subject: Re: [RFC PATCH] mm/mglru: keep the root_memcg reclaim behavior the
 same as memcg reclaim
Message-ID: <20241216015414.ujbwsr6mtwgo4goe@oppo.com>
References: <20241212095646.16164-1-hailong.liu@oppo.com>
 <CABdmKX2__wuSLH2x=5=SqQR0wo86R-Xknua-q9BC44XQDjwgug@mail.gmail.com>
 <20241213022619.ph22z2mxxyh3u3tw@oppo.com>
 <CABdmKX1AE=PYB+grWH6pSjjA2_io70eSH3FjZZpbOwUEiduTSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX1AE=PYB+grWH6pSjjA2_io70eSH3FjZZpbOwUEiduTSg@mail.gmail.com>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CE:EE_|TYZPR02MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: 563ee4c1-938d-4d07-1160-08dd1d748b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0NaRmRxalVGd3B2TTY1ZzhRNWQ1Y1M3SEJwSk5WcytLNThldGNhSWxVMm9p?=
 =?utf-8?B?dXZqcWNKc3lweCswejJ5aGFpWjRGeXZreGYxWTJITThWTjZ4bzJVZjV0bmxI?=
 =?utf-8?B?RjlWTjBqRGxmQTZwZUFieTJvOE1wRDZyZGo0TjEycVoxNG8yV1EwcFl4ejI4?=
 =?utf-8?B?cU5zUVpPaEgrRW1nSDZPbmNsazFtT0pnUnRvWmZLMGVFNnhpTU14cUdUMXBF?=
 =?utf-8?B?OVR2RE51R2xRSEVuTHo1bWljODBUSGgvVnkrbnJLUWphOVVCODdiUS83OTZV?=
 =?utf-8?B?Q1F5ZzgzbVFXUzF4NEoya2hKYzdRcHFYRnRBbG8wWW1aRHA4b0JhakZuMFBz?=
 =?utf-8?B?WGZMTTc4dExBc3FqWWF1U0xmZnlma2g0NXpUUUtvbFFlQ0poTC9HVnVTZDY4?=
 =?utf-8?B?ek9IMlNXSWduMHJJYXZNQ1QxQk1iTWovbzVNWmZnbGtFVms5VGg1UmJCNTNO?=
 =?utf-8?B?am44Tk4vaVBMeGExSzdNQTFkY2d0WHlHOEoyZE9HWGVBNjZhdXRCeFRUMjRE?=
 =?utf-8?B?MU03bHBURnh1azJYL285YkxuS2lYSzhVNkRmcUFidm9QTGcxbSt0K2RjWVhX?=
 =?utf-8?B?QTBya2xMNVprUXNwbEFiUnhXQmdXM1owRXgvVWY0OTYvbk9DNk0xUVl2Zzlu?=
 =?utf-8?B?dnVWL3pYZWQyYURkdTA5MDNTYXdyNjBUTW43N25OZ3dFWlVydlVhczlkcEcw?=
 =?utf-8?B?U0V2Y1dwTjhZZHNNaFVJejd1Z2kyWmFVTW9VNWJhUnYvYXBZcUVUUGh1eUVB?=
 =?utf-8?B?UkRnanpUL3FkQzVnL1dIYkNnOTQwdzdHcDY5YTNyMjNxR2hsVVFkREF1bk0z?=
 =?utf-8?B?Yy9MZ1hJV1VYU2NVN0g0YmJMK3BTQVRRb2hwSGhFZzdJVndJMjhMNkRKQTV1?=
 =?utf-8?B?MmJ1N1RwMDJzSjhLUGkwTHpRTGl1YVN6ZzBYeGVyclNvUDAxTW1ybVYwZjRI?=
 =?utf-8?B?N09iQjk3cldBcTBkd1hKUGhsM2c3bjBFZktpdmJTVDk0MjBhczNTZTJjS25V?=
 =?utf-8?B?Zno4NVRpbmw5azVJZWVGYkcweldCKyttUlJVYkFOY2NzQVFBZk1DRDFpVkxK?=
 =?utf-8?B?STJpdkxEaDVGREtJRTRhYWxVSWRLMUIwOHp6S3FRTDRLRmdPOTE4cHBDN0JK?=
 =?utf-8?B?S1VXWnlDdzVueUUyOUdGbE5DYmF2SC8zRkxMRjhBaVJmdG1DSHR3emtCM3M1?=
 =?utf-8?B?eW5YZUZ1bThGV29EaEdyYmNQTmZpTmJwVXMxbXZVTU8ycDVSMmhzV0oxSXla?=
 =?utf-8?B?NzRSNlJiZzdTSHJmWktkSnpCM3BrM3laaHBObUdqdW9yc2pTRFdoZE1pQjBO?=
 =?utf-8?B?TnBMNU1icTBHVDN2bHRHUE5KcDN6VEFURkdlWGdRTzQxT2pGMUdGa1NodGZh?=
 =?utf-8?B?MjVCdEM0NjZoU2lwaEI0U29GbytvdlAvTUQ1ZUZtZSs3SmpPQmk0RGRseXZy?=
 =?utf-8?B?akdQMUNjWXg0RmZFdUdDRzlSWjNqemF0V3FNdzc4bmF6cGhwalcyQ3VmcFBG?=
 =?utf-8?B?VzZxeUZ0VjZpWmlnODdNWWFVRTg0dmxPS3RvbFVOZ05YTlVjUnZWUzYwWFpk?=
 =?utf-8?B?WGxzMTJGWG9Kd2FSLzkweDFBNVU5RFBEaTNoUi96Z1ZJa0MrU3JLVmtiL1FG?=
 =?utf-8?B?K25HREsrT3c4V2RITFBaWEREVVAvbDZVV2RnK05qNHBvczhTNW5aTFJzZU9S?=
 =?utf-8?B?SUZTcWsrbnl2L3FEdVU1djcxeXcvdVhSZm5xUjNpdTNxOVdMOURHTXFlclFQ?=
 =?utf-8?B?dERDZjVldStmUjB5NFRrbXlsS3EwRHhQSzhYTmdpdVFVeHJ6RmZHeURQd3dS?=
 =?utf-8?B?dlNHcHRrY1pXTWNMUWF3a1BKTTNHQkxUWTZ5K2xHS0s0MU9CQVJGV3hEZ242?=
 =?utf-8?B?c0YwVlNIVmViUW5ac0lJUnFBQ0VucXNQdUZrdkpSN0YrWjlXejlTRXRGNmFI?=
 =?utf-8?B?OFEzMGpSUDBEaFVjaUwyZ1pBSHlvV3NLcHlXVEZJMmlWbHluWXhUR0lqTDI5?=
 =?utf-8?Q?CvUaCAYWKTGZbfFDhwpGVO1mYjDL/U=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 01:54:15.1344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 563ee4c1-938d-4d07-1160-08dd1d748b9e
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CE.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5938

On Fri, 13. Dec 09:06, T.J. Mercier wrote:
> On Thu, Dec 12, 2024 at 6:26 PM hailong <hailong.liu@oppo.com> wrote:
> >
> > On Thu, 12. Dec 10:22, T.J. Mercier wrote:
> > > On Thu, Dec 12, 2024 at 1:57 AM hailong <hailong.liu@oppo.com> wrote:
> > > >
> > > > From: Hailong Liu <hailong.liu@oppo.com>
> > > >
> > > > commit a579086c99ed ("mm: multi-gen LRU: remove eviction fairness safeguard") said
> > > > Note that memcg LRU only applies to global reclaim. For memcg reclaim,
> > > > the eviction will continue, even if it is overshooting. This becomes
> > > > unconditional due to code simplification.
> > > >
> > > > Howeven, if we reclaim a root memcg by sysfs (memory.reclaim), the behavior acts
> > > > as a kswapd or direct reclaim.
> > >
> > > Hi Hailong,
> > >
> > > Why do you think this is a problem?
> > >
> > > > Fix this by remove the condition of mem_cgroup_is_root in
> > > > root_reclaim().
> > > > Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
> > > > ---
> > > >  mm/vmscan.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > index 76378bc257e3..1f74f3ba0999 100644
> > > > --- a/mm/vmscan.c
> > > > +++ b/mm/vmscan.c
> > > > @@ -216,7 +216,7 @@ static bool cgroup_reclaim(struct scan_control *sc)
> > > >   */
> > > >  static bool root_reclaim(struct scan_control *sc)
> > > >  {
> > > > -       return !sc->target_mem_cgroup || mem_cgroup_is_root(sc->target_mem_cgroup);
> > > > +       return !sc->target_mem_cgroup;
> > > >  }
> > > >
> > > >  /**
> > > > --
> > > > Actually we switch to mglru on kernel-6.1 and see different behavior on
> > > > root_mem_cgroup reclaim. so is there any background fot this?
> > >
> > > Reclaim behavior differs with MGLRU.
> > > https://lore.kernel.org/lkml/20221201223923.873696-1-yuzhao@google.com/
> > >
> > > On even more recent kernels, regular LRU reclaim has also changed.
> > > https://lore.kernel.org/lkml/20240514202641.2821494-1-hannes@cmpxchg.org/
> >
> > Thanks for the details.
> >
> > Take this as a example.
> >                root
> >              /  |   \
> >         /       |    \
> >            a    b     c
> >                     | \
> >                     |  \
> >                     d   e
> > IIUC, the mglru can resolve the direct reclaim latency due to the
> > sharding. However, for the proactive reclaim, if we want to reclaim
> > b, b->d->e, however, if reclaiming the root, the reclaim path is
> > uncertain. The call stack is as follows:
> > lru_gen_shrink_node()->shrink_many()->hlist_nulls_for_each_entry_rcu()->shrink_one()
> >
> > So, for the proactive reclaim of root_memcg, whether it is mglru or
> > regular lru, calling shrink_node_memcgs() makes the behavior certain
> > and reasonable for me.
>
> The ordering is uncertain, but ordering has never been specified as
> part of that interface AFAIK, and you'll still get what you ask for (X
> bytes from the root or under). Assuming partial reclaim of a cgroup
> (which I hope is true if you're reclaiming from the root?) if I have
> the choice I'd rather have the memcg LRU ordering to try to reclaim
> from colder memcgs first, rather than a static pre-order traversal
> that always hits the same children first.
>
> The reason it's a choice only for the root is because the memcg LRU is
> maintained at the pgdat level, not at each individual cgroup. So there
> is no mechanism to get memcg LRU ordering from a subset of cgroups,
> which would be pretty cool but that sounds expensive.

Got it, thanks for clarifying. From the perspective of memcg, it
behaves differently. But if we change the perspective to the global
reclaim, it is reasonable because root memcg is another way of global
reclaim. It makes global reclaim consistent. NACK myself :)
>
> - T.J.
>
> > Help you, Help me,
> > Hailong.
--
Help you, Help me,
Hailong.

