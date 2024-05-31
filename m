Return-Path: <linux-kernel+bounces-196202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8667E8D58C0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA10B1C214AD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0B578297;
	Fri, 31 May 2024 02:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="kEn3G7tP"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011005.outbound.protection.outlook.com [52.101.133.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEB8256D
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717124038; cv=fail; b=VIyE+F8r1uIZQZrD5pVLyzcyyFDV6AeRTGddgajdFMQkwlx1iyVDkb2TE6rnXQN0kuO9UbHJCL/P1nIStozpb4n7CoTPs6NwnlyrV/ci2j78WWNNk4Us830RO143jsSFwzUPlZy/f4eaoLZ35lCWoRFRtnt2UUJgF6gs1p1DI3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717124038; c=relaxed/simple;
	bh=CfofuczV0TiLaMRkvzDl8bmpPq2iUDR9xiBxxjUHCOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nj7LCJVZjWIYuibuTalOLaEGF0KGlfx+Qp+n/Hkk1zQ9jbnWJmbhFVp8vgl6r2bAvcPJbTKP//5X/yrEuoYONHTpqtm+ufDMADhN16SlksX4f20/AtHv/91eZWby4LI/OMzXt9A50uqI6VC3iZ2sDuIKFxLgG97S0UAnN/lHkvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=kEn3G7tP; arc=fail smtp.client-ip=52.101.133.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imRwjOcFfz8mmV4uFVtojk1rlHM+/ryGEWUQi45fl/t5KvAtBaC/T2zgne4qOey0yXKtnFH1JB3bVNn8prNAveWIaXi8kbOzW3Gf5IX/MRZ4NIIpjLW7OPvDJx9xI3AAMne7h8N/NqZhL34dnqrTKBC1hRG63dm5djX4nCT63lUmH33nX6AVu08JJs+fC2pm4Qg5vOPB6fuOPYDcjoMvZcbSu0oROVdBKqT34dHc7RIZVOJ0g2FDYbSZJdtuVAP/gRvKDekqLvCHWymQgvQrC399eaJzf+xLrttqkGfILvTcy0ORRrTqlouH4YkUjMz5KLla3T+xe+I1IuoG4WaLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTw9T4ibiqbLZk+zt/HHQIAv53ybYfpJ33iC3Y/CyaM=;
 b=DsMCYY1Pnvv3bLGmV2NWrCUIGyH7trOiwhnP1NSvlzRsS5M9uTadmH5AJh+beFrKc7OoQziTOdDGodZG50s/4ZWuVgdvAlNJec7vXHyLvqHOLQgUYzs5P7gQOCuXQYNgp2Y5yjvFwOJfIDasxRumliI2eoLgb1t/ma3Gs5QD5wBE5CsRgy/8+2rlGaPp2oHxVkeivUQMQoJ9hhtQnBYhz6RECVDI9aOpGnQQOZxHTvMDcUzng2RoUb/2HJ9LeMGGPxstbhvzpY+jmh6xwN3G5m81+JOx6z026uV0A84hR7EPGtQ6iFrvCg2MintLIA0UqH86ACp7EKMuE1lzcNIMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTw9T4ibiqbLZk+zt/HHQIAv53ybYfpJ33iC3Y/CyaM=;
 b=kEn3G7tPSzSO6yOBhoKougEtRjUPJlQpOGJQpEEJ4xNdBq9Aq9JsZ3xCIaPCBXiUoQ8Qd5H4yIQefVSZeI1xlLxFjqvZknx56N/l8vJI625VUTdrGTufaZVaJj7Om4L23KG6bh79J+eNVdpeEbCnbWmJX05Zid3ECykCf7X1n9E=
Received: from PS2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::24) by SG2PR02MB5903.apcprd02.prod.outlook.com
 (2603:1096:4:1d4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 02:53:52 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:300:58:cafe::ca) by PS2PR01CA0036.outlook.office365.com
 (2603:1096:300:58::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23 via Frontend
 Transport; Fri, 31 May 2024 02:53:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 02:53:51 +0000
Received: from [127.0.0.1] (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 May
 2024 10:53:16 +0800
Message-ID: <6de9688d-00e4-49f6-9a6b-c53f447bed20@oppo.com>
Date: Fri, 31 May 2024 10:53:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/vmalloc: fix vbq->free breakage
To: Andrew Morton <akpm@linux-foundation.org>
CC: <urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>,
	<21cnbao@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<xiang@kernel.org>, <guangye.yang@mediatek.com>, <zhaoyang.huang@unisoc.com>,
	"Hailong . Liu" <liuhailong@oppo.com>
References: <20240530093108.4512-1-hailong.liu@oppo.com>
 <20240530130318.2a78c0797c352a4d38cfb2c1@linux-foundation.org>
Content-Language: en-US
From: Hailong Liu <hailong.liu@oppo.com>
In-Reply-To: <20240530130318.2a78c0797c352a4d38cfb2c1@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|SG2PR02MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e01115e-e8b4-4cb2-2e5b-08dc811ce73d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1dOaG00SFVnZHhNL0VORzhYTVp0dEVsVzZMcUd3UUlleEpXTkxuLzRsbmda?=
 =?utf-8?B?ck4wWU94NGp3b3JKalh4M05wSXcvWkxMNjcwL3FFdURYQkx6VTZKdFhnUnM5?=
 =?utf-8?B?bXJmRnVMQmNra214V1pJZzR0bTJlQ0lib01XNFVMTFNjQ3hEN0VrNkZiTzBa?=
 =?utf-8?B?MGJGNlk3OGpodUc4a1NyZk9WeDRTSzJzRGtiUWZneWZsaUlFb1dOcG0wN0lp?=
 =?utf-8?B?b2drbkc0RlZFSXhkdklFSGZmZGY2Z3Q3djlhTEFaYmIxVnZjQXB1ZXZ0Z0Qz?=
 =?utf-8?B?NTFIeDlncFhqNXM1eFNpN3NqUkxRVDZYSlJmMUN5K2tDOG1Ydkt2QlBCb1Fi?=
 =?utf-8?B?N0RQYmVXNjViNEkvUzZEV1BZb0ZPUC91aU9FaEMyTXpJRW9EVkJrSUFZd1RM?=
 =?utf-8?B?czJoemRDRk1URDJCNmlSQlhuT3FicFlHK2c3L0tlRml0UVdGUkduYk13ekhW?=
 =?utf-8?B?bjJHUWxTb2JGSGpxeml0R1E2aDlTNktnNit6NnR1ZEROa2k2MUFzUmRJdkIy?=
 =?utf-8?B?VkhKamtXSDFiSUg4WW01ZGd5cGowRDFMRnRHamNZSTBXWWI4OUZLWko0QXJX?=
 =?utf-8?B?d01KZGtMRE9BMU50RXhBQTk5ZHJJeDNzUmd5ZzJPaFBZRk10Uzk3UkhlVnVW?=
 =?utf-8?B?a2xiMndSdDdZWlA2djhNRnY0eTFCak0zejllYmpRVDFLNWtJNUtGR2w0N093?=
 =?utf-8?B?dWFIZDVSQ1R5cXJWWmJKaFl1eWd6UmtiUHc1Yjd0K0UwWmNvdGp0dlJTdW9Y?=
 =?utf-8?B?N0JsVEZSMnhRWG52Y1J6WVFCRHRmMUpOaS9qQmF3a0JjOGdMVUM0b2JoVmRh?=
 =?utf-8?B?S3NsaEpZc2hNSVQ3Q1F5Yi9ONll2UXZ6cEhGb3hKYmliWnNUcTBjenRyOWpT?=
 =?utf-8?B?N3o0RittRkNGdGVDdXc2REFPQngvcm9pRHBBZzM4b0lTUXhTbm12UmJjOFZX?=
 =?utf-8?B?bjFBZzdPTGxhRGJwZEd0UkRiSDYrTlN0RkNIMjlYVXNkUzRCd0ZhT0hmZ2Rm?=
 =?utf-8?B?ZlVuMDdyeWNWSEp2SkxwZ2VKYnZpdTZzQnc3WUg0RjV4SVJDVm5vSWxWd0ds?=
 =?utf-8?B?UjIzUmZTdjgzc3NjTU5UVFVEdDhuSmk1WDIveUNNaUdPU2tuc1N5UlJGNStl?=
 =?utf-8?B?Qis1NDJ3NC81QTdGSVQ2dEd5eHZ1WnpjdGxoV0dneHRpeGpYSGpLeVYzNkxp?=
 =?utf-8?B?RHo1WkJSQTJnSy9UM2kyc3FybjQvREYrR3JoSUhlcUdrR3FlN2dzMmxtRndQ?=
 =?utf-8?B?KzBSQUlabHV1cVQxZ01uME1TdzdWeUp4QktkdDFLNUFueGEwTHp6RjVxRDFY?=
 =?utf-8?B?WWtzbTkzcTZ0UmtzU1R3dXFwVFZndDY4dHhDUmdtb3dEYm1za1lqWUJaaWlF?=
 =?utf-8?B?NHA1ZmJCbUYxRTBYdWd5L2Q1MU5kTS9BSzBBL0Jvb0tnK3hHVFR2WHlUdVdK?=
 =?utf-8?B?MmdTRTRVVkRFMWVpWWp6MlBEVlJpNHluM0MwdjFWM1NMQ1p5MDdFOStRUlBv?=
 =?utf-8?B?SkxiWkFHTUJXa1FjWGpGQVdsdXh6UER3NWwreTdZNzA4Mm9PbERtUVUwNnA4?=
 =?utf-8?B?cGd0cDNyRlB0cXFSVy8veFQxblJtU0REaEo3REQ2UTRzU0NmK3A3NU5Pdmls?=
 =?utf-8?B?clJSeDg4OTBBekJsRWExbjlEcUFyZXhkL3R0eFJyb0tkK2V3Sll4ckE5WU92?=
 =?utf-8?B?blBuWnlQMStoSm1IR2tvSnB3azkveU9reTc2bmcxZHFWRXZJTXhuYWVsdkF4?=
 =?utf-8?Q?/uKGpdpITzBRPPYRREbA5Gwa420bUnbVlv2rM3I?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 02:53:51.6819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e01115e-e8b4-4cb2-2e5b-08dc811ce73d
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB5903

On 5/31/2024 4:03 AM, Andrew Morton wrote:
> On Thu, 30 May 2024 17:31:08 +0800 <hailong.liu@oppo.com> wrote:
> 
>> From: "hailong.liu" <hailong.liu@oppo.com>
>>
>> The function xa_for_each() in _vm_unmap_aliases() loops through all
>> vbs. However, since commit 062eacf57ad9 ("mm: vmalloc: remove a global
>> vmap_blocks xarray") the vb from xarray may not be on the corresponding
>> CPU vmap_block_queue. Consequently, purge_fragmented_block() might
>> use the wrong vbq->lock to protect the free list, leading to vbq->free
>> breakage.
> 
> What are the userspace-visible runtime effects of this change?
> 
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index d12a17fc0c17..869e7788a7d5 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -2269,10 +2269,9 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
>>  	for_each_possible_cpu(cpu) {
>>  		struct vmap_block_queue *vbq = &per_cpu(vmap_block_queue, cpu);
>>  		struct vmap_block *vb;
>> -		unsigned long idx;
>>
>>  		rcu_read_lock();
>> -		xa_for_each(&vbq->vmap_blocks, idx, vb) {
>> +		list_for_each_entry_rcu(vb, &vbq->free, free_list) {
>>  			spin_lock(&vb->lock);
>>
>>  			/*
>> ---
>> https://lore.kernel.org/all/20240530025144.1570865-1-zhaoyang.huang@unisoc.com/
>> BTW, zhangyang also encounter the same issue, maybe revert commit not a
>> better solution. we need a map to get vbq from vb.
> 
> That patch didn't describe the runtime effects either.
> 
> Folks, please always do this.  So that others can decide whether their
> kernel needs the fix, and so that others can decide whether this fix
> might address an issue which their users are reporting.

Thanks for suggestion. I send v2 in 
https://lore.kernel.org/lkml/20240531024820.5507-1-hailong.liu@oppo.com/T/#u

I promise to make my future commit messages comprehensive, in order to help others.

Brs,
Hailong.


