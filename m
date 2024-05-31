Return-Path: <linux-kernel+bounces-196508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385718D5D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEE51C24DB2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A26715575A;
	Fri, 31 May 2024 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="BsT0cn/B"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2067.outbound.protection.outlook.com [40.107.117.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6863B136E23
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145595; cv=fail; b=WltwwNPfMTQ/zMDyZ6Ji0exSsts9X+QGCAIdFjVJT91lHKukQxGAHmW04lyKanAGfs/RFcsHZxoX7I2qRDH0k0yZdDU4Myw3z4gK6j33jmHtU5QudKCGVA5iL5HpJ3rDSJtpofswqH8HObdWbojaZ74gsspymkX4tp3xqYDb5/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145595; c=relaxed/simple;
	bh=IjZ4fuNMeUjQzaxjoxMHREtG5l+I8TqJa+M3dYHd6lA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDPyexbCXqcAzIzpg5olW2xiKBFSc1xuw/9HEeXaU1kU5L5rFLU4kouFjot469IZpAlAlqL6QSl1dqsXq9YA4TUcoyUZ/H4ywHuVh5Dkhg+wrSh9PmBdeNkyfmx95jJzk3Ui8/EN10JNUY2gJTecUXbHo0LnHxRpoTS6PJwiDuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=BsT0cn/B; arc=fail smtp.client-ip=40.107.117.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfdQIQPhPleHNYPxT3xgTRW5sxg+UwfttUZl9fc9bnp6PES/ovCH51C2FxBhqvkln7BGXKs7widfnvghIhWnJBKcZIuD5VORUYSPW8C8eACHGUE3t/VkLFL2OchQcPb6BvzzMurXCrGUQDyHPOLUlY0ZaKDVDXAXDUKZX9fqE+WA7Sp9NiIKvIAs0PWECXCxcUpbeLeqk/M6cxbiqFgb/0+8wf68h49VJbmiRQFSy7jlhEiNXiZO2BnB5GRnwlBzetKmZet7HTbJph3diGOKT5Lbs/aiJZFb/nIboWN8lg4fCKntlytbp2Fc4ktmNGCQ+98sYx3iLWwNlje4TLdzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgknR7vJa5ond1M78NfFRYbFOkugJP29ZGIvYifwTpw=;
 b=Gu/yjp3X9LNfo2wesfVuP03vooIMTqm/LefeJwjNBxilVTkVcYppyDnVFcASZ0gZC9XKJai2BimCltANlih3E4inAPfe5y4ZjRAA7M6UQO1VZZvGMvhJadAZqw58yYfZgYxmi+1H4lM3/L97wHmYYooQUzcXDBMCIK49FCWVn1DArDEVgD/rnja76ZZ+Rk3zVWJNpnSGbmzt5yMT20cleoSErn4FwiniFCJOl2761rZTe0nFd3v5r+0fsmk/Xi+bfFLw8soBZ1r4Haf3dZAsm4TLscoK6MfzN5WIyXTrxzh03RpBUCMskUw8XR4jfNvHqRul3+hKB4gjS6vCXcUr8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgknR7vJa5ond1M78NfFRYbFOkugJP29ZGIvYifwTpw=;
 b=BsT0cn/BNBXZv4Ulj5AlQnhd6bedzWLwT8bwnoQ+243y6IY/RUgir6uWcAy6f6X0mgAGBq83kZ5QJpCbfVKL46eiBbaqQLw0G/mC+pYdoe+Mh7RZBHU5jqRVuUAe2aGZqz/XTfhVeFMLGDRE/MvlMagH8J09yD3aKCY7e2tqTJo=
Received: from SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) by TYZPR02MB6521.apcprd02.prod.outlook.com
 (2603:1096:400:41c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 08:53:10 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:40:cafe::16) by SG2PR01CA0132.outlook.office365.com
 (2603:1096:4:40::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23 via Frontend
 Transport; Fri, 31 May 2024 08:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 08:53:10 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 May
 2024 16:53:09 +0800
Date: Fri, 31 May 2024 16:53:09 +0800
From: hailong liu <hailong.liu@oppo.com>
To: Uladzislau Rezki <urezki@gmail.com>
CC: zhaoyang.huang <zhaoyang.huang@unisoc.com>, Andrew Morton
	<akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Lorenzo
 Stoakes <lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: Re: [PATCHv3] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <20240531085309.x2pyjm6tl5xe2swv@oppo.com>
References: <20240531030520.1615833-1-zhaoyang.huang@unisoc.com>
 <ZlmEp9nxKiG9gWFj@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZlmEp9nxKiG9gWFj@pc636>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|TYZPR02MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be7b089-1749-4c1b-dd87-08dc814f191b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XjDpj2679ZUjc4GEquv0Fa+y8KGVqAgqPu3ifIqy+0ozzZoZIQ66V4H7vbC9?=
 =?us-ascii?Q?Rr3Lr0flVSGvzw6A3k264Zp8xtDiKuf3AD/C4alFyId/nUxa0ryC+HG61w8A?=
 =?us-ascii?Q?eQoX2OhytASkyPqxHKMi6acNgyf54KGIrGwwFv/nqd3u1gTacv2HEmFvRCKH?=
 =?us-ascii?Q?ymXq/09QR+HnBnV2T47OCxPWhMruK/iCsfDY8cIgUz9EZmZwlXWVLvHItnn0?=
 =?us-ascii?Q?qzCmDvyX3j8TO0Uo3TeYwpUKnUeHom4qy/ep+6FN01w8q0y2TKQVmEbk7MrT?=
 =?us-ascii?Q?AoL5rVRsCkeiPDQW9FcgFGNRVWO7WHark9IetjYI0BWnDIl7ZF1yOhZMKQ3N?=
 =?us-ascii?Q?fJRs7xFc00X6iU7SDnnDb7zGT11CeyF1cBV9d/PqmjanRxHxxYmR0eBBKjC1?=
 =?us-ascii?Q?fwHzCPacSM/BhC+xgHaetknuzcO474SLwMx3HyfJH7rU33sIQ9bx8jCf4gkb?=
 =?us-ascii?Q?Pw1UXdzfnwmXvrX1KUrRA2YcpP4Jain2jfcphg46L4RvxeLPiigO7gRltvXM?=
 =?us-ascii?Q?87gRryauz+vURMUhJjcIl+vnRMd/3+SaPmWXEgbfEoqxoo2p2qi6qVVMiqUI?=
 =?us-ascii?Q?BemRdrgmUm5F1tzspXncMIhbrA5Exg9G/XGTAJBVcs3o2Tx9ZAlDvqQPcfs2?=
 =?us-ascii?Q?/Ghy3Kr6hTOHXRWG6L3h9X7TEHlk83OCVDza5vZwKih5Ax3aoExWNcenZN46?=
 =?us-ascii?Q?vmNJEtwoVb4yZ6tt3zKypNG2DJy1SkCafJGF5mASQFQ1kwXb4bSOOoKbnyWN?=
 =?us-ascii?Q?S7oEGSPI6t9kx+KmPy3C5ZsxqBvWigUEwE4MHiiXfKF8IXo8L9f8r3t5Ltm6?=
 =?us-ascii?Q?QVEHQ9CW8eVa+E8j/oiHocT0XjDs8dIWXQcvKtvtKh0ZKiW7soQhfvbKzhd/?=
 =?us-ascii?Q?93UBzMDubUWp09ClRH/WigmSdpGsAKby7gsXHteqsyBnqllqD60s+fAoN9Hi?=
 =?us-ascii?Q?LRy+PrTOFo68YGd4/dWvrRIrLxAAGZOFELkD27N8Y1E/xUE4mZSL0IfFyOw2?=
 =?us-ascii?Q?QItY7vrSMBSBA+tmCRV9++1YKbBnT3w/MCSmKB/PbAh6ydKE2gPfnSyjEXhF?=
 =?us-ascii?Q?D9NUvR/jJPKoz3YUuq2ojxcdzrfZkTYxy68EXqDqZWnoYqmCwy1sj28yBsNa?=
 =?us-ascii?Q?rURvjqx/PXPU307Rh4Lc0sU8VPUFRtzmjhb56jN4ruTwxGZcL7R40Mai38Bv?=
 =?us-ascii?Q?A8hr8ybxfbRSvFHtz/g1uU/DdHYhItvsLyA4I0l666NQCok+xBQWpoIQo8N1?=
 =?us-ascii?Q?9L/i/ISeYPfQN/R/IkX90MSZO9pnm8eCKoNF/AGtcWvwvYsk1wmiS22KSMj5?=
 =?us-ascii?Q?7AAG5Jt2Nsi4E07w63j/E0CM?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 08:53:10.2486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be7b089-1749-4c1b-dd87-08dc814f191b
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6521

On Fri, 31. May 10:04, Uladzislau Rezki wrote:
> On Fri, May 31, 2024 at 11:05:20AM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > vmalloc area runs out in our ARM64 system during an erofs test as
> > vm_map_ram failed[1]. By following the debug log, we find that
> > vm_map_ram()->vb_alloc() will allocate new vb->va which corresponding
> > to 4MB vmalloc area as list_for_each_entry_rcu returns immediately
> > when vbq->free->next points to vbq->free. That is to say, 65536 times
> > of page fault after the list's broken will run out of the whole
> > vmalloc area. This should be introduced by one vbq->free->next point to
> > vbq->free which makes list_for_each_entry_rcu can not iterate the list
> > and find the BUG.
> >
> > [1]
> > PID: 1        TASK: ffffff80802b4e00  CPU: 6    COMMAND: "init"
> >  #0 [ffffffc08006afe0] __switch_to at ffffffc08111d5cc
> >  #1 [ffffffc08006b040] __schedule at ffffffc08111dde0
> >  #2 [ffffffc08006b0a0] schedule at ffffffc08111e294
> >  #3 [ffffffc08006b0d0] schedule_preempt_disabled at ffffffc08111e3f0
> >  #4 [ffffffc08006b140] __mutex_lock at ffffffc08112068c
> >  #5 [ffffffc08006b180] __mutex_lock_slowpath at ffffffc08111f8f8
> >  #6 [ffffffc08006b1a0] mutex_lock at ffffffc08111f834
> >  #7 [ffffffc08006b1d0] reclaim_and_purge_vmap_areas at ffffffc0803ebc3c
> >  #8 [ffffffc08006b290] alloc_vmap_area at ffffffc0803e83fc
> >  #9 [ffffffc08006b300] vm_map_ram at ffffffc0803e78c0
> >
> > Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")
> >
> > Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> Is a problem related to run out of vmalloc space _only_ or it is a problem
> with broken list? From the commit message it is hard to follow the reason.
>
> Could you please post a full trace or panic?
https://lore.kernel.org/all/20240531024820.5507-1-hailong.liu@oppo.com/
we also face this issue and I give a more detail in the link.
However I revert the
commit fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks") :)
>
> > ---
> > v2: introduce cpu in vmap_block to record the right CPU number
> > v3: use get_cpu/put_cpu to prevent schedule between core
> > ---
> > ---
> >  mm/vmalloc.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 22aa63f4ef63..ecdb75d10949 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2458,6 +2458,7 @@ struct vmap_block {
> >  	struct list_head free_list;
> >  	struct rcu_head rcu_head;
> >  	struct list_head purge;
> > +	unsigned int cpu;
> >  };
> >
> >  /* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
> > @@ -2586,10 +2587,12 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> >  		return ERR_PTR(err);
> >  	}
> >
> > +	vb->cpu = get_cpu();
> >  	vbq = raw_cpu_ptr(&vmap_block_queue);
> >  	spin_lock(&vbq->lock);
> >  	list_add_tail_rcu(&vb->free_list, &vbq->free);
> >  	spin_unlock(&vbq->lock);
> > +	put_cpu();
> >
> Why do you need get_cpu() here? Can you go with raw_smp_processor_id()
> and then access the per-cpu "vmap_block_queue"? get_cpu() disables
> preemption and then a spin-lock is take within this critical section.
> From the first glance PREEMPT_RT is broken in this case.
>
> I am on a vacation, responds can be with delays.
>
cpu = raw_smp_processor_id()

vbq = &per_cpu(vmap_block_queue, cpu);
vb->cpu = cpu;

this would fix the case.

> --
> Uladzislau Rezki
--
Best Regards,
Hailong.

