Return-Path: <linux-kernel+bounces-196701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B79A8D6015
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D92287B25
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADA4156679;
	Fri, 31 May 2024 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="B94VJ5n6"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010000.outbound.protection.outlook.com [52.101.128.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0B018756A
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717153047; cv=fail; b=b2UftKwomr9gpzPricxQO/Z1Yjsap9h8iwXX8DhpcXuDdW8+ETH/b1rolXcuH97MgEcGQQSlJ3/2IAecyfoK+RjETlC9SzkEA24R3cT+7oDDLgfwrS5FUh1e1RjSMzPJEFXJvkmaSScnrCqFlIdsDQB2+qqBaLEzCWl8tNFED+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717153047; c=relaxed/simple;
	bh=VNL5+0Q/k4NtcP3wzyERwiL/Mn41HMUCW2ud1DmQrmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kDo2lsxnTFeT1Dniqz7Uz+bkmcltlCT3S4NxDgbfNe+NEIwG4swY9y52PeT/K90MoEiG2pPiA6RL6HHwz3DQQ2mvnMLXIByDrCT9nH8KLdnV/9gWUILFASMSP1LA+f/k6h3evTUUcn0YBLODy7tuv8xbAyPgbetfjgOgRKxUxbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=B94VJ5n6; arc=fail smtp.client-ip=52.101.128.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCVb9vatzac5sMtRiZWCRsHRxWmI5xsIVpU9Yc1V6YacTKth4ZJIWTEIe9TrTLyy3aaaPkh6/4STxc+m8EvbcDZYD03tDuKdZ08UF9wdJjZyDySsQRvCPmnt+SAQq2C3zRW6b+IWlN6LagUkUjt/8fmNMDq+lUboUiqnOk35lYEgfpdSPaX3I2gL45s5UBUMkBUgoqg1XxBNBd4b7zlEpXuOHqrX/IoHUjHGK13ndTvlX+UrRreklUYg97LcraMz/G3EQPxWfM2HSGgb4jH1P+YWjkXfmv0BxDbUQFpMhkXtpUUl9ms8TLvHmYnwifbLhtxs7/dmRxDIuOVInQjexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9rBxc/rCfszobnzgFFRX5iG/79t2sVMqpsOyA9DVDg=;
 b=G9Qaq2puJbKg1TU856ZPGUNp/h2W+PEv6sV9BXJICAQU7BBVm5VMiCoTmw3bnfEqB2HhVL2+nfYlZhWM9QnElR0d4N2VInzpe7/EotwerDVZOPbLe1P3KeOAuYKniZNRq8tb2aIB00Oj5UjC3ZsjnFQHHd7wi29cMZq3cuAxDGuSl6nyZBFJmNwSydRtkQaNfYSuQQqYgoQLmKN04XKUzqEVZw355+4T4/xlaURLsAtCzBYy5Gx50561sX9R9Mh3g9iqaKpbO3JimWXCOfydyUkV4JplOWFEDHINh8KdbgTd7xbctj/eOAqx/nAgqfTJzlvJIxNkcSGipnv4+i9/DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=sina.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9rBxc/rCfszobnzgFFRX5iG/79t2sVMqpsOyA9DVDg=;
 b=B94VJ5n6rzD3geHy4+Z0RL795oDSSr70d/R0qDWY6FcIP3YkfiAPeYhe8HU5p88JJ5tjIWSI/9CzTwV/H2nC4DsCaspmJGRlXzIi771OBHsFK/HLjdL8fjZzderiSLIUbalxZ9Dr4rArJKR2IH8DT952B7hZ0tHJfWNZ3UOkapg=
Received: from SG2PR02CA0089.apcprd02.prod.outlook.com (2603:1096:4:90::29) by
 TYSPR02MB7418.apcprd02.prod.outlook.com (2603:1096:405:37::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.22; Fri, 31 May 2024 10:57:22 +0000
Received: from SG1PEPF000082E2.apcprd02.prod.outlook.com
 (2603:1096:4:90:cafe::45) by SG2PR02CA0089.outlook.office365.com
 (2603:1096:4:90::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23 via Frontend
 Transport; Fri, 31 May 2024 10:57:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E2.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 10:57:20 +0000
Received: from [127.0.0.1] (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 May
 2024 18:57:20 +0800
Message-ID: <56e5606e-6dcb-4c34-a3b0-143a29b021f7@oppo.com>
Date: Fri, 31 May 2024 18:57:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] mm: fix incorrect vbq reference in
 purge_fragmented_block
To: Hillf Danton <hdanton@sina.com>, Uladzislau Rezki <urezki@gmail.com>
CC: "zhaoyang . huang" <zhaoyang.huang@unisoc.com>, Andrew Morton
	<akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240531104425.3262-1-hdanton@sina.com>
Content-Language: en-US
From: Hailong Liu <hailong.liu@oppo.com>
In-Reply-To: <20240531104425.3262-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E2:EE_|TYSPR02MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: ce37baf5-2246-4c8f-f597-08dc81607204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3pNWFA3NWJTWmtxOTR4Qm5IeFU4cXp5eVZQTXdZdGluYXI0Uy9IdjdoYzdL?=
 =?utf-8?B?RVFjNlNwNCtGaURXK2NtWFRwODVxeHZaNmQwZmk2R25tbVV2OHZjeUFQNUlI?=
 =?utf-8?B?aDcvd3RqWmlxM1BhejAzajhwNGRMWFkvakhlT2xuUUFCSHpDU05mOTdZTm1j?=
 =?utf-8?B?TjRtUHRQWTJNYnN2Z1pXVEtBZ2ZiZDRHdHdERlRMUVFpbU5LNndPeWZQTDZt?=
 =?utf-8?B?cTNPU09UdENOMmtWUUpCR05lNjJhaGx6RjNITzYvaXFxeHBtNFZNeElYVTJV?=
 =?utf-8?B?YU5md3Rwc2ZieUdJVitnaXBsMEFjTEYwcDdaU0VUR0dqbGx0Z0Y4SXZ2ZEhI?=
 =?utf-8?B?c3JwQWMzWkpDRHBSN0RiTzQ1OUhidEhpL04vR3Q5MjdJUkU0a3ZiWTlJL0Ra?=
 =?utf-8?B?TUUxajdXVTVNbWRIQ1htYmlycHhFNnlCSGRlWDduS3RSTGpldUlKYk51OFpp?=
 =?utf-8?B?Y1lOemlJM0VuQVZVRnJ5cWtFcnF1enlnaDR1SnJWZHdyV1VhbE9lWVp3d3BU?=
 =?utf-8?B?V05uS2VNYjRCTVRWT3dNYWdBWFZCclp0bnd3WVUxdkxDalViRHRVLzc5Z1Z0?=
 =?utf-8?B?dytsTGREc0dNbVc3Q2l0Um1seHlNVi9tV0haeWo0eUxJWnNwK1poVHB5VnVw?=
 =?utf-8?B?WWNWMnhQL2E4OWYrVjhGNXpXVFZzdXRCM3NJT3gvMmladGVxWGtqZlhXVFhq?=
 =?utf-8?B?VmR4TS9Ualo0OHExNkw1Zm9IL0REU2NPNGNsSTRHdmdNek5CemkxbUMyMDBj?=
 =?utf-8?B?R2Q2b3BmN1hXZXVXRTdRSWdqZm8vTnZ5dzRoR3BlZVlJZUhQK0pyUUxkcnF4?=
 =?utf-8?B?VTVSZ2xtNS9tYUIydkpBMm1sRkZSRlZXRE5tcGdTSXRMUE54aG95dlF1clJR?=
 =?utf-8?B?S245eTJ2TFROUUVDYk9aTjAzSFJuQ2ZVK0ZSM2JFSVgwR3MxSDh6T04xSS9i?=
 =?utf-8?B?VXFRL2c5S0FEQjdHZXNVVDJJRnp5emZMS0RaMGU5UUh1c3ZqSFB5R3lhZysw?=
 =?utf-8?B?bEhmNTk5RVp1WU93djVqK25USHI1TTRubzFRbVlCWWdBd3pLcVlUQkd4Sllw?=
 =?utf-8?B?TVpMMmlyUXFkS0tyRHg3cHVNanlBM2JtdThsbnpMYldTbnkzQ2R6T2prL1Bs?=
 =?utf-8?B?Vmg4dUVmTzAxdjJWeUk1UFhPK0V1QitOSk92RWZRc25FOUNZRDZidisxNE0z?=
 =?utf-8?B?bVROOEVMNngzOWpJdlhKSkwwUU9RVGZ0UnJtME5KTlZ4SFZXcjQ1TnZlTXU3?=
 =?utf-8?B?d1RBdzJMc3B1dEIrWXFEbWVweExnaTZDMEVtalRNS0hPZUxCNldpeERkVHJL?=
 =?utf-8?B?SWJ3N09seENOS0RORE1OWGFjN2xVWko3eTltaHM2SEhvcnlaRXBjajlhK1Fw?=
 =?utf-8?B?d0E1TnRVOERWQ08zME51bC9KNkpxRE1VK3diUGlpNy9CU1BKL3NsNWEza3NS?=
 =?utf-8?B?cFpUUkpQSFJtV1p2NjJmNnpVZDNNSE5mQThsN0JqcFI2Z0NCYWFLNEhManRD?=
 =?utf-8?B?Tk5Lbi91SzRlcWpieTJxOFRtZ1psQ2ozVDlXbVpqbnRYMng4RkRReTJXZE5y?=
 =?utf-8?B?UXIwK09CaWl5Z1FjdTVuUDBocjdYOW9hczBQK2hJNUdiY09CR1dESkxhQ05Z?=
 =?utf-8?B?SzhlSmRUYklna2J4REQ2MVlaQUd2d0lqOFNyTjZzYnloMEFGOHBORFZhL0M5?=
 =?utf-8?B?MzViTlNxS1VqakhRanhpOEVWSHFPM0ZhSmNZVS9XQWV3TlBvdmRmYzVnQVp3?=
 =?utf-8?B?cXF3U3lHWThmMm54UmJwdThwZHd3SUNGYk1kRjkrL2kvMkQwcEtLeEN0Vllj?=
 =?utf-8?B?RGRJci9PSUZHNWpWUGVNS25TWXFDQldTK1ZFYnRWT1hnOGtxcFlSazFjbjFz?=
 =?utf-8?Q?/lCCTZMWJgcFG?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 10:57:20.8288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce37baf5-2246-4c8f-f597-08dc81607204
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7418

On 5/31/2024 6:44 PM, Hillf Danton wrote:
> On Fri, 31. May 10:04, Uladzislau Rezki wrote:
>> On Fri, May 31, 2024 at 11:05:20AM +0800, zhaoyang.huang wrote:
>>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>>>
>>> vmalloc area runs out in our ARM64 system during an erofs test as
>>> vm_map_ram failed[1]. By following the debug log, we find that
>>> vm_map_ram()->vb_alloc() will allocate new vb->va which corresponding
>>> to 4MB vmalloc area as list_for_each_entry_rcu returns immediately
>>> when vbq->free->next points to vbq->free. That is to say, 65536 times
>>> of page fault after the list's broken will run out of the whole
>>> vmalloc area. This should be introduced by one vbq->free->next point to
>>> vbq->free which makes list_for_each_entry_rcu can not iterate the list
>>> and find the BUG.
>>>
>>> [1]
>>> PID: 1        TASK: ffffff80802b4e00  CPU: 6    COMMAND: "init"
>>>  #0 [ffffffc08006afe0] __switch_to at ffffffc08111d5cc
>>>  #1 [ffffffc08006b040] __schedule at ffffffc08111dde0
>>>  #2 [ffffffc08006b0a0] schedule at ffffffc08111e294
>>>  #3 [ffffffc08006b0d0] schedule_preempt_disabled at ffffffc08111e3f0
>>>  #4 [ffffffc08006b140] __mutex_lock at ffffffc08112068c
>>>  #5 [ffffffc08006b180] __mutex_lock_slowpath at ffffffc08111f8f8
>>>  #6 [ffffffc08006b1a0] mutex_lock at ffffffc08111f834
>>>  #7 [ffffffc08006b1d0] reclaim_and_purge_vmap_areas at ffffffc0803ebc3c
>>>  #8 [ffffffc08006b290] alloc_vmap_area at ffffffc0803e83fc
>>>  #9 [ffffffc08006b300] vm_map_ram at ffffffc0803e78c0
>>>
>>> Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")
>>>
>>> Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
>>> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>>>
>> Is a problem related to run out of vmalloc space _only_ or it is a problem
>> with broken list? From the commit message it is hard to follow the reason.
>>
>> Could you please post a full trace or panic?
> 
> What they proposed looks correct IIUC
> 
> --- l/mm/vmalloc.c
> +++ v/mm/vmalloc.c
> @@ -2067,7 +2067,7 @@ static void *new_vmap_block(unsigned int
>  		return ERR_PTR(err);
>  	}
>  
> -	vbq = raw_cpu_ptr(&vmap_block_queue);
> +	vbq = container_of(xa, struct vmap_block_queue, vmap_blocks);
IMO, this violates the percpu principle, why not use vmap_block_queues[NR_CPUS]?
>  	spin_lock(&vbq->lock);
>  	list_add_tail_rcu(&vb->free_list, &vbq->free);
>  	spin_unlock(&vbq->lock);


