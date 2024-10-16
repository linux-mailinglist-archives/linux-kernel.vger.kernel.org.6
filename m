Return-Path: <linux-kernel+bounces-368861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAE39A15C7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A348A2838CA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890851D4352;
	Wed, 16 Oct 2024 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Klb5sN7l"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C10C1D1738
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729117395; cv=fail; b=BHg3GVEIFTni55NMHwTfh73FmKQKAV2C2zzJBa31OgB0ScBMXCu95xpraJ6FJ+HRCx8yMY0DWZKWY4AxW9OCnIF3F0BUR+zWeQw4o6uRbKq1cJmEovRRUL72m3xay7rmz6C8JfThce8DmaADfRynDuBSl3Qif4rLeiW2d2aJMPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729117395; c=relaxed/simple;
	bh=bVyokgaVeASEPd5JU7HmGOjFJIuGlfJRoaah90gP2es=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=loZMh1c3EQa+jrUhglqKy43CoJQLqmrg4l3YBEbOnFsECi2cmQjLu+EPFmxhmxTo6ewqr7PJ/gbSkTnZCXFyghbx5emb1iRDk8y5xrnU1oXN5N4GHO9W2HGuRK6XV5iGxS8Wi/5lbLMtqbLR5h1oXYD0ZTmOA7vwJytB964M3Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Klb5sN7l; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7HzP2LH1Meii9ttZQmF4nWTBynjEnOOV0g5HaJq1U91zH/P5Cw2CV6bCAT5lnx8jcK7uZb3pYGN1oM3wUTBZ4Fd7dXW9AhouK2Jozjm17TYXh01hwtYwYWNysg5jFrZaZNJgiMiVZEVYiliZJNn7yQ5pRqKd68V4aVPlfTGneFPaGJqgV5Gl9y8yf4RFNKZNM7MPDSaIyiT6odAnkOdscnxGQTmLsLab9rK4vrXuHtD+QmbZOVsdDyUkd3pL2yuBhaoy2h/eh+2i587m44Hil5rnbUpQbmsgnFpo1Fm3KAtCzoyAuQFev3NJncnyfP1PORlQyjH/Vdp+HPRhaP85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GOLgZA32OQLrdTnVJH7FMzMte0YOJi4nWV2NNN7Mfs=;
 b=v2dqig6a04LU7fnoqYANv3dZsLunQa1h4HIEBMwAMb5ex7rawztERpfMpo6gYL2r3bVTk/eoDWg5Tuc9M1DLrx1pM4Sj1TV2xqeKhVY9pnRI0mxQOQWGaKzS7sdaHaeJmQVEypMYcnXQW//FjHorrg673NcXyNJ1dfAy/H4JNLSjdHHD3/icOuZ0J12+30f4FJLYO0878oS3sCZllATk3vcMzENn49PcNL15euTnudC8w+oqItKyn0kTOBrZbQqru/sCKWyKgo/d/lSOwvpxapR3dAJ83ISoxGDOjPJam6kuwTBu+QYIIGDFVCST/q4yak6zplRUt0TWrHYlYv1L6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GOLgZA32OQLrdTnVJH7FMzMte0YOJi4nWV2NNN7Mfs=;
 b=Klb5sN7lI6BRjMsis8FBOfFjWeBK/LMmBO5xZT1oPfX0u4l8Xuqv5VHMC4uQLIbApJGIgI+XPOvMN/ax7tAbXb2xlQO4g17SxPRtbPvnwreRrzu5o15mQxg0AwNGNkESJRx4nfIrYGuf25JQQ8RKOYe0E7W+YDUbNUEB4X7hDv+tiY7FY+jU/4lyiXOs+GsQXriG2I1iFGGYv5sA04lIxcq8qQqVRlI8BUv6j5r89dQCzhkJy00pK0ga6AjbdYitFhyoJF0LBXD5czmFamnkteaiZM0a4VWZOcJFwH+TsiX/s8n72qDjAcd05ygT1Wd6OLBrWkQpDwvV+a+kD+kEDw==
Received: from BN9PR03CA0046.namprd03.prod.outlook.com (2603:10b6:408:fb::21)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 22:23:10 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:fb:cafe::20) by BN9PR03CA0046.outlook.office365.com
 (2603:10b6:408:fb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 22:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.1 via Frontend Transport; Wed, 16 Oct 2024 22:23:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 15:22:54 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 15:22:53 -0700
Message-ID: <f90a2900-74a6-4264-9bf6-2f8d51d21980@nvidia.com>
Date: Wed, 16 Oct 2024 15:22:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: stop leaking pinned pages in low memory
 conditions
To: Alistair Popple <apopple@nvidia.com>
CC: Andrew Morton <akpm@linux-foundation.org>, LKML
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Shigeru Yoshida
	<syoshida@redhat.com>, David Hildenbrand <david@redhat.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Minchan Kim <minchan@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>
References: <20241016202242.456953-1-jhubbard@nvidia.com>
 <87ttdbofpw.fsf@nvdebian.thelocal>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <87ttdbofpw.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3341a3-de9d-4c64-1f03-08dcee311e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1RGVWJpdThONXNrY1BmbGUvblo5SHB6NXdvOWpQSUQ4dWZBQVEzaWM2eWVQ?=
 =?utf-8?B?MC81UVIxYzloZ2xBbWcra0xyTC9UTS96amlycURXMmMzenBYaG1RRHNiQ3hm?=
 =?utf-8?B?UlA3RjJSRlE1dW1NeVg0NWZ4a0NpQ3psZWs0enp2bFBPQ1Q0eWVjQWJMU3N6?=
 =?utf-8?B?a084ZzdJNk5CNnRzQmE2dW4vc1ZGQ2VTVk0ycFoyNUVtK0grangwNXd0WTJC?=
 =?utf-8?B?UzVDQW5uS0RaUzFiWVNhVnBoYnhBajl3RkMwRDRCd1pONGgyVWdZSTFIQklz?=
 =?utf-8?B?aFlMTVZFdW1HQ3pSNnlRdVFSSWFBQWJmVXI3TzNlYitMbGpYSG12TVBxZE1v?=
 =?utf-8?B?U3VYYzBsUURmYVFHczAvWEhzNFhLU3J1REhHVmN1bSt3RlI4RnBoaCs2cVNK?=
 =?utf-8?B?WEx1Z2ZvcVdpRGNUcFkwa2JvZElad1dhQU1MUmRJeXNQdlRsNVFiT2pxMUFN?=
 =?utf-8?B?Mnh5MXRKeWpSWmZVTENmcUQ0MFFaVUl3T2Vvazh0Q1FYTUZnU3diWmxRTmpF?=
 =?utf-8?B?eFRGUTh0T2VxK1R3UWZFZm40STU1VFU3WFc1UmZzemJ5ZEFQa0sva3ZpdGdr?=
 =?utf-8?B?U3hnbnoyQUdOM2tNb1RjekUyMFJnNk5JOHZ6U3VhcGEyUmlDS0VLOTFRQlhp?=
 =?utf-8?B?Zzh2Y2t4djNsMVNENXUzcEd4OEt3VUhZQnlGWDdLemdZWjJKS0Y0YzVTZk45?=
 =?utf-8?B?QUpGbWJDRVdyakoyYjZtY3RnVHFZZmRJanVrdFpzU3p6dzZkZVhkS3lDcmJi?=
 =?utf-8?B?S1lsWEVXeDhsOWtUYUZ3NktUbjN6Sjk2WHFzQ0Fpb2ZYbGhSNHR5NFFZaG1S?=
 =?utf-8?B?MHIyRFdMdlA4bHF6a0pJTHdRYkRub0tGeDVhUUI3WmRxRThNcmFGY01OQVlY?=
 =?utf-8?B?OGZHQ3hjNXl5bzFaaGZLOS9sRHFKb1Vpd0tpTGFJcnZFMTVCdUJySEdnQm12?=
 =?utf-8?B?RUczQkFlTkR0eDg2bDdDT2xNSDJsbW1BTGNQcUZ3YStwTE5JVm8zOXdOVmRw?=
 =?utf-8?B?bE9ka0xuUExwY3NmV2lTRzEwN2kzdVhFTkxnZXNQSVlMWFBJL3YvQ1R4RTNt?=
 =?utf-8?B?VWd2aW42aTc3L0FLZGdDZW1tMUV1VGtvWjVWd2tadkRaNktMczlNQUZhRzJ0?=
 =?utf-8?B?RjI4U1VCQXdUcjB6dnBla0FkVG5pZ09LclBsWG1mc0lwQXhadnVMUDY4SExa?=
 =?utf-8?B?RFpMT1FnK05pMWRNRGg1WHFGVzI2WU9PL3lKY3g5TUh3UmVCUnRyT3Z5QUUy?=
 =?utf-8?B?K0dIdnRSak9adXpyelovY3ZNbUtxSUQzeGgwWkVUQ3lCYnVkTlhBNFNNUXF5?=
 =?utf-8?B?UzNQZWx0UExiUWhqcGg2NUQvNlhDS2FYNU45MFlKcWY2ZE0wYlhDVTU3NjVD?=
 =?utf-8?B?S1lMZEh1bmNQM2dMTFpCVzd6VXFSMmpBK0VWSHZoQ29OaUdycVlWdHRXWnBz?=
 =?utf-8?B?elBHcmdvVkY0UzNBemFjNllpTUpySEloenFqaFdCdG8vaHMrMWswZ0tZNzA0?=
 =?utf-8?B?WWEzMWVFaGxzZGEyTG05cmQ2akdZZVlCb0ZHQXJYSjd5Ulo4djhIQlQrTklX?=
 =?utf-8?B?K2FCdm9WMlg5VnNwWWUxUTF2Z21TdGZnWGkzbHJFM0tTdjROZ1MrdkMreDQy?=
 =?utf-8?B?K2IwQjk2d2o4SjZUNWdPdlVwTXJVZjhXUUc5NDhJRldlL1IzNXAxK3ZpS0c0?=
 =?utf-8?B?WVVYRG1EN0R2bzZ2eE1QMStrY0NiUExLcWJub1dRWGdPYk5jWFlxc3V4NjVV?=
 =?utf-8?B?cEp5d2JVNHUvdDBxUG8rOHFML2k3NE90bzdrR25YS1JnTC9mL2tyOERHYUN3?=
 =?utf-8?B?OUZiNjZQN0dCdm4yQnZjcTFNTkp6bWYzNnZURHVjak9ZMVV4cUh4L3phV3d4?=
 =?utf-8?B?emdEVUEzVHFuYkNaSGhUeVg1cGR2eUxQZHR1ZEp1cmcyYkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 22:23:10.3180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3341a3-de9d-4c64-1f03-08dcee311e14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822

On 10/16/24 3:13 PM, Alistair Popple wrote:
> John Hubbard <jhubbard@nvidia.com> writes:
...
>> diff --git a/mm/gup.c b/mm/gup.c
>> index a82890b46a36..24acf53c8294 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2492,6 +2492,17 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>>   
>>   		/* FOLL_LONGTERM implies FOLL_PIN */
>>   		rc = check_and_migrate_movable_pages(nr_pinned_pages, pages);
>> +
>> +		/*
>> +		 * The __get_user_pages_locked() call happens before we know
>> +		 * that whether it's possible to successfully complete the whole
>> +		 * operation. To compensate for this, if we get an unexpected
>> +		 * error (such as -ENOMEM) then we must unpin everything, before
>> +		 * erroring out.
>> +		 */
>> +		if (rc != -EAGAIN && rc != 0)
>> +			unpin_user_pages(pages, nr_pinned_pages);
> 
> I know this is going to fall out of the loop in the next line but given
> this is an error handling case it would be nice if this was made
> explicit here with a break statement. It looks correct to me though so:

Yes, I'm not sure that adding another line of code for cosmetics really
makes this better. At this point, smaller is better IMHO, and then the
next step should be something bigger, such as refactoring to avoid the
tri-state return codes.

> 
> Reviewed-by: Alistair Popple <apopple@nvidia.com>

Thanks for the super fast response and the review!


thanks,
-- 
John Hubbard


