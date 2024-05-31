Return-Path: <linux-kernel+bounces-196698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2C68D600E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D7B9B23463
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373CB156644;
	Fri, 31 May 2024 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="TS+7fAET"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2081.outbound.protection.outlook.com [40.107.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4534018756A
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717152733; cv=fail; b=V3UsKwG9RrD0oapp6XWQfaDeKtsUBNY6wq7Ydct5SKPjBeAjntuouG3A6lQmklEL3NgpLX03tH+6MQ4EU+jgedb6T1/AgSMMxW9ks5tUBU7Qo/DbC9f+10NMOtcjYxuQPAMhv0WGpHlpcvcMDVToIHu19HWfRvRgcOBuHVcmhKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717152733; c=relaxed/simple;
	bh=9ZKkRw1Nh61X2Gdrt0UdfCXGYdaLrAp4FnvRrDaJWPY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOr9KRi2mQYmitc+w9LYVL3RkSlvebuFVJyjpPJ9zfU5kYlzAT/egAsPgjFhpOJJJcnIFCAMSOCpumtVhkiCckREUwFS83Ce2sUxm4Rhsdo7lk7CR3ugeXFqwjsY7ac8WtELrw3zD3C6RXiC+/CcNvxlMzB87NObZqj0OKYnjd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=TS+7fAET; arc=fail smtp.client-ip=40.107.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsT/hEUc3NG9imI6Jp56zahZ6FVQSUrJSbtBeegItu4gv7sUZsX65zc3w8wvVBZO2FEotRtLp7AkVX49bm39lKKnyiatGIQchqtOmW6nTrlR+J5PZq0ZxFNTloV/hop6SHo5ugZ4B5Wq/GBKFjpI1pyCsSEbTupDyiruQ12IChsCfvwLB6u8R8Ez+3WReleeLNM8J/ZK6s4LeQy4O5cTUGM6/H5WBScft7wnnsse/o6AaYK6VizyjlwYfbxAR+gbv/x9cTBw5Esbw7gEeryOmb6HwGe1cO6QPfIusqE6VBC2OFHzwrc187JPRF84xMsm+qmGzwV0tZlLjs7029h6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpwGwvYsX9FS3Z1xMFLY4yjARrUbN+yHSAtMqGPH6+w=;
 b=QTWCuSIOHIdqrale6cHKiel9Jwmc3cgliq4RJMNbcl53T4DFZgAuqzE8eLR2JcUEKzkGRLCPBrkR9Iaxyn7O0iy2GhwXLYqLTYZN9UOy0rGj+YKrhnQNYv1YgmNI4AZUQ5sUfc9jZO5vgok6pEL+hAyQyFwzFzzqyYTE+0iO3SoXUFimEDAhsyzrPsZ29wkMd4FdiKcTUtPi5tReJ4gWXpj15cWqs8rXybpxz/gzcSHJNcOKDCw3ak48PabIAAElvP+SjcWvS7eQWom+MRm99sE1raC+PHF4Ip/y3T+w/XVAHl7qj4nJmxMIs1OCKY9r2kH8RLGydBGmx9U6d6v+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpwGwvYsX9FS3Z1xMFLY4yjARrUbN+yHSAtMqGPH6+w=;
 b=TS+7fAETJ/jaIChEb174vQIfxJJYhF+RzF59OuH3hC35YtJhT2uYt0xmLOqr6gqkLuiTkKAIyXNseerMrHeo5041cN/F7ttLulVlamwENlkzA9Kr4154b1GM/wRtTffZBkDTpegQPPSTtEz+krNLJJYLb5ck4RQu3dHwnl+OFNI=
Received: from SG2PR02CA0057.apcprd02.prod.outlook.com (2603:1096:4:54::21) by
 TYSPR02MB7702.apcprd02.prod.outlook.com (2603:1096:405:33::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.24; Fri, 31 May 2024 10:52:08 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:54:cafe::2e) by SG2PR02CA0057.outlook.office365.com
 (2603:1096:4:54::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23 via Frontend
 Transport; Fri, 31 May 2024 10:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 10:52:07 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 May
 2024 18:52:06 +0800
Date: Fri, 31 May 2024 18:52:01 +0800
From: hailong liu <hailong.liu@oppo.com>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
CC: Barry Song <21cnbao@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
	zhaoyang.huang <zhaoyang.huang@unisoc.com>, Andrew Morton
	<akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Lorenzo
 Stoakes <lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<steve.kang@unisoc.com>
Subject: Re: [PATCHv3] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <20240531105201.3afxxv3jzifuymmi@oppo.com>
References: <20240531030520.1615833-1-zhaoyang.huang@unisoc.com>
 <ZlmEp9nxKiG9gWFj@pc636>
 <CAGWkznGak0txoOEq1SYL9Ymax04Tac2nVCSYiC+L8qQ6bqryZQ@mail.gmail.com>
 <CAGsJ_4ywu+WgOz_nxaeCa2qzv2=qDa8ZJWOUYb4LqVUq2qeCxQ@mail.gmail.com>
 <CAGWkznE1tChV=idAEH7AQG7Uw8e411yZMfjKknuSH1GG8SSXDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznE1tChV=idAEH7AQG7Uw8e411yZMfjKknuSH1GG8SSXDw@mail.gmail.com>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|TYSPR02MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 405cb4b0-885e-4d09-34cc-08dc815fb763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2Vic01WVlB1OG5ZRHF4ZWRJRGRwTXo1b0k0T0toM25PTG1FWDFnZkhmQmR2?=
 =?utf-8?B?YWhTNE5UQzdRblJTbUtQU2pDdkhFZ0hUQ0NHczByL0lsbHIxUEtOaHhPUlBv?=
 =?utf-8?B?QnRacUhVNHZDakpKeE1WeVVESVdkbGVJTmFtWW5Bb0R3SFJGZThISEdCUnc5?=
 =?utf-8?B?QVJKYUN6QldHZnZDaFhUeVRjZXd4Wjc3b3hyekJGT080MGorV2JIbXJyVzRk?=
 =?utf-8?B?V2U5R0Rwb2ZkNG4xYjkwSUdzRCtKeHFsMDR0aVZLOC9HKzNsYlNhS3ZMbytR?=
 =?utf-8?B?VFlrLzM2UHMzR1Q4TjhvRnMxemZod0FURmFGdGxWZk1kY2FpSnNNS3JaMG5t?=
 =?utf-8?B?VTEvTWgwY2thbTZpN3c4VElXVG94bzFaem9UbnE2NTRpMk9ublVBVVdjTTBQ?=
 =?utf-8?B?WDlsMFJaZThjTlFjZGd2OTV4bVd3dHZLb1YyeGRmZk9PdEhOUEJreWxWZDll?=
 =?utf-8?B?N0xkbjBib2ROMGlsVUpsUTlzbG1FSHJmOWNxUTNJVm40citYYVlmR3gvSm5M?=
 =?utf-8?B?S090cmRWcjlpTnNzL01DbWhzVmdScTk4anVZM2N2UldGd2pIR3duWHN1WmRK?=
 =?utf-8?B?aUhwZ1lVWUg4ZUhTNTNMNHFDV1AvZ1hGQkF4NkVPOFhHbTZ3OU1xQ3dYeTdU?=
 =?utf-8?B?cWVzdVUwaGRLLzZQeDdoMkUyR1ZBL1lIKzBEV2pPS0RWMnlSU3lxSmhKYlNl?=
 =?utf-8?B?UjlBWFdVenVQMjNCYkRDeFdQcWZhcnNSUWVJTFNOMFFmUnZ1REtJNjd0a1U1?=
 =?utf-8?B?MTJVSlFuSTNYMW4ybWV2cDYydFFzZG9FYzdxZE5TbnRrck9FUy9hSWRGWTNQ?=
 =?utf-8?B?cFUrWCtVZGdOamxzZHJlUGtrV1pHME5XQ0ZiZ1VYSmhrMGVTOU10eFpvUUhs?=
 =?utf-8?B?Q2R4SjJSQVlmWEhBTHBzSDgrQXJzZlQ0V280eS90MlZGU3NkTy9LcVRxV0No?=
 =?utf-8?B?dG5SNjV6ZW5MenJYV0ZFL01ra3ZrNlpyN2dLMWo3bHhoVEMwQlFYdUxaMDJt?=
 =?utf-8?B?b2QvMG5PRWQwdDJrNUNaYWR5V0NyaE04VFJKQlNqVlRxeXNWdEZlNEgzMWpa?=
 =?utf-8?B?NFBHdndvQTFKM0lzSVFUL1lWeEV3ek9xSjhsRGZ3OVQ5eThxK01vbXdGNHR4?=
 =?utf-8?B?Y1N0OW1kaFVJajlWaHQ4VTg4REI2V2cwWmN6WEhzNDdXSjB3YW5kR0luSDFZ?=
 =?utf-8?B?SFdvUTI4TTQ2bzRKcEJSZTVRVWcrZDNFODJ6Mm9XRyt2cXZ1WVJidE5rM0Rs?=
 =?utf-8?B?cjlZaFlMdklES2JIcEFTeG5kTFBoVzk5dUUyKzNtVWxHTUE0QnFaaTliK3lX?=
 =?utf-8?B?Njh6ZTNQV1k0aHVqWVNaWnQ5Z3JNUUE5UEkrbmhXbCs5MWpjNlQ5cU0wUjh5?=
 =?utf-8?B?c0FDYnV2R0hORGZVbnllWG0xME1rRjZtYmp5N3dML3hEWjlhNlZMRGthZnpL?=
 =?utf-8?B?ckNkdjFYbExUYWdabGpxb1Y4RHFjTGR1T0ZnRkdrdTdmcXFTZzhaUVpDZ3hJ?=
 =?utf-8?B?ZGpsOTFSU0hFMHBmR3ZSVlVyaDlWOGVoY3RIT2pIY3BKOEJPS3NsQmtvQXFB?=
 =?utf-8?B?UGpqQnBlZEdqNkdrVk43UDFtbTZhOXJqT29HRGxlRVIxQ3pGaTh2YkZEMlFH?=
 =?utf-8?B?NFhldUdEczJsTi9YcE05R055WmNjcURoNmFiSGJOWUNyeXJLYnBpamVXbHlJ?=
 =?utf-8?B?eW5DR2VXak1mejdhMEZZL21BMFBxMmVFUnVXcWxBTFVqaVJBRFdWZG5CczZZ?=
 =?utf-8?B?Y3NkbnJyek9VS2dTRWQwanJ6ZGtCc1FCUUozUXMvQjlhWEhEd1FlZWJNRUVK?=
 =?utf-8?B?dmFwbmFONnFQc040d2ZNU3pTMUZuMHNsT25rckVQZUJCMFRkVUNMcUV2MTU4?=
 =?utf-8?Q?oKMS1LNwGHZMT?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 10:52:07.7282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 405cb4b0-885e-4d09-34cc-08dc815fb763
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7702

On Fri, 31. May 18:17, Zhaoyang Huang wrote:
> On Fri, May 31, 2024 at 5:56 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Fri, May 31, 2024 at 9:13 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> > >
> > > On Fri, May 31, 2024 at 4:05 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > On Fri, May 31, 2024 at 11:05:20AM +0800, zhaoyang.huang wrote:
> > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > >
> > > > > vmalloc area runs out in our ARM64 system during an erofs test as
> > > > > vm_map_ram failed[1]. By following the debug log, we find that
> > > > > vm_map_ram()->vb_alloc() will allocate new vb->va which corresponding
> > > > > to 4MB vmalloc area as list_for_each_entry_rcu returns immediately
> > > > > when vbq->free->next points to vbq->free. That is to say, 65536 times
> > > > > of page fault after the list's broken will run out of the whole
> > > > > vmalloc area. This should be introduced by one vbq->free->next point to
> > > > > vbq->free which makes list_for_each_entry_rcu can not iterate the list
> > > > > and find the BUG.
> > > > >
> > > > > [1]
> > > > > PID: 1        TASK: ffffff80802b4e00  CPU: 6    COMMAND: "init"
> > > > >  #0 [ffffffc08006afe0] __switch_to at ffffffc08111d5cc
> > > > >  #1 [ffffffc08006b040] __schedule at ffffffc08111dde0
> > > > >  #2 [ffffffc08006b0a0] schedule at ffffffc08111e294
> > > > >  #3 [ffffffc08006b0d0] schedule_preempt_disabled at ffffffc08111e3f0
> > > > >  #4 [ffffffc08006b140] __mutex_lock at ffffffc08112068c
> > > > >  #5 [ffffffc08006b180] __mutex_lock_slowpath at ffffffc08111f8f8
> > > > >  #6 [ffffffc08006b1a0] mutex_lock at ffffffc08111f834
> > > > >  #7 [ffffffc08006b1d0] reclaim_and_purge_vmap_areas at ffffffc0803ebc3c
> > > > >  #8 [ffffffc08006b290] alloc_vmap_area at ffffffc0803e83fc
> > > > >  #9 [ffffffc08006b300] vm_map_ram at ffffffc0803e78c0
> > > > >
> > > > > Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")
> > > > >
> > > > > Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
> > > > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > >
> > > > Is a problem related to run out of vmalloc space _only_ or it is a problem
> > > > with broken list? From the commit message it is hard to follow the reason.
> > > >
> > > > Could you please post a full trace or panic?
> > > Please refer to the below scenario for how vbq->free broken.
> > > step 1: new_vmap_block is called in CPU0 and get vb->va->addr =
> > > 0xffffffc000400000
> > > step 2: vb is added to CPU1's vbq->vmap_block(xarray) by xa =
> > > addr_to_vb_xa(va->va_start);
> > >             fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully
> > > utilized blocks") introduce a per_cpu like xarray mechanism to have vb
> > > be added to the corresponding CPU's xarray but not local.
> > > step 3: vb is added to CPU0's vbq->free by
> > > list_add_tail_rcu(&vb->free_list, &vbq->free);
> > > step 4 : purge_fragmented_blocks get vbq of CPU1 and then get above vb
> > > step 5 : purge_fragmented_blocks delete vb from CPU0's list with
> > > taking the vbq->lock of CPU1
> > > step 5': vb_alloc on CPU0 could race with step5 and break the CPU0's vbq->free
> > >
> > > As fc1e0d980037 solved the problem of staled TLB issue, we need to
> > > introduce a new variable to record the CPU in vmap_block instead of
> > > reverting to iterate the list(will leave wrong TLB entry)
> > > >
> > > > > ---
> > > > > v2: introduce cpu in vmap_block to record the right CPU number
> > > > > v3: use get_cpu/put_cpu to prevent schedule between core
> > > > > ---
> > > > > ---
> > > > >  mm/vmalloc.c | 12 ++++++++----
> > > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > index 22aa63f4ef63..ecdb75d10949 100644
> > > > > --- a/mm/vmalloc.c
> > > > > +++ b/mm/vmalloc.c
> > > > > @@ -2458,6 +2458,7 @@ struct vmap_block {
> > > > >       struct list_head free_list;
> > > > >       struct rcu_head rcu_head;
> > > > >       struct list_head purge;
> > > > > +     unsigned int cpu;
> > > > >  };
> > > > >
> > > > >  /* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
> > > > > @@ -2586,10 +2587,12 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> > > > >               return ERR_PTR(err);
> > > > >       }
> > > > >
> > > > > +     vb->cpu = get_cpu();
> > > > >       vbq = raw_cpu_ptr(&vmap_block_queue);
> > > > >       spin_lock(&vbq->lock);
> > > > >       list_add_tail_rcu(&vb->free_list, &vbq->free);
> > > > >       spin_unlock(&vbq->lock);
> > > > > +     put_cpu();
> > > > >
> > > > Why do you need get_cpu() here? Can you go with raw_smp_processor_id()
> > > > and then access the per-cpu "vmap_block_queue"? get_cpu() disables
> > > > preemption and then a spin-lock is take within this critical section.
> > > > From the first glance PREEMPT_RT is broken in this case.
> > > get_cpu here is to prevent current task from being migrated to other
> > > COREs before we get the per_cpu vmap_block_queue. Could you please
> > > suggest a correct way of doing this?
> >
> > not quite sure if you have to pay the price of disabling preempt.
> > Does the below Hailong suggested fix your problem?
> >
> > vb->cpu = raw_smp_processor_id();
> > vbq = per_cpu_ptr(&vmap_block_queue, vb->cpu);
> emm, it looks like 2 could race with 2' which also leads to wrong
> vbq->free status, right?
>
> taskA
> 1.  CPU0:
>     vb->cpu = raw_smp_processor_id();
> 2.  CPU1:
>     vbq = per_cpu_ptr(&vmap_block_queue, vb->cpu(0));
>
> taskB
>  2'. CPU0:
> static void *vb_alloc(unsigned long size, gfp_t gfp_mask)
> {
>         rcu_read_lock();
>         vbq = raw_cpu_ptr(&vmap_block_queue);
>         list_for_each_entry_rcu(vb, &vbq->free, free_list) {
> >
IIUC, for_each free_list is under RCU, so ..
> > >
> > > >
> > > > I am on a vacation, responds can be with delays.
> > > >
> > > > --
> > > > Uladzislau Rezki
> >
> > Thanks
> > Barry

--

Best Regards,
Hailong.

