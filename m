Return-Path: <linux-kernel+bounces-191746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D828D1391
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A58828479C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697633C684;
	Tue, 28 May 2024 05:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i7lyMTXl"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8703A1DD
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716872564; cv=fail; b=gQSuYx5rANHgp/xWy5nV1PwyzHe5eDxCe90eXJqE7afV7JGT7J2BcGTis0X3kDjFhVCzzcD6lfONZ2sJZAEotcF3SQYrE+i5EGUhiwmWTOV1UUg2posUuKTji28/iWyE4IpbDrH8NSoLw1clMVHkf5O2VwF6dfyRTEZ9NgRQn0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716872564; c=relaxed/simple;
	bh=UUR7KzgVJkv5n2IVRHjonpPCbfhbbeESOWKOn35Npw8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hd896Kud2KFR7si+y+ePNsTI8640U6yz625vM2FN9+knobxLdtwaiP6MEXLf5AaH7nKJ6B6ACY+czYQEoFOljhA7mknDBbvSWNqiGUW21P9qGnWoBrJvOU8EeuegoPoN9kLIF60mwNubyqWWvzpp4A7cNzQV5hrgUV+lb0tX61E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i7lyMTXl; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsm2EWcSDOBl7KTrkBDJj1suFRV+tNeIn395ogW7SP2XW1me0z7GuOWjLRsIxEwF2FMv8Qeay5FkoyQeNmvVksNba4unrwH2tcvD+AYrFpPpZi7KeFnXKYklE4OzBP1EUb32p4nJxeENP6VwwBMyPFHzNBbVEwumqD0asxI6X9248gThPKXBfo/2FQ4rttUiMWX4/+l5azhxLZQwgBujbFl/qy/D7cB9p0tsaANO4JFJAa4jdMDeRk3KK2LC6Uw2I+6yStTI/fp/0p59Z+33Z34p4Gy8OnLW2d0qZTEleVH9ZhfeTJ6AduDw1h/ZHeXg+FTFvN0e3CMiWJFe+tcp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzbU3IGId21Xj/3nqeABnVNrdl5l7t28Ysb2PAyv9BU=;
 b=btH3zKbSl8l0KxLNQbY4xNILG6zQPN928rKE0+X2V2qCurZb5AkXP9HvLiMBTHeEVE7nV3qfVB1zxALh2/AP9ODs3dp/S0KxsXOtTF7jGLE/Ur+lL1SzEfgzdqEIIbi6nNP8HRyEjK6rMNUmYMhcTEh0zQVbCc3nTtrtDCVES+TUfhILwNXcywVLkUw/xHyT70nlFQSMawR2jLp2MJ0fz+Bu3kVh3KACQ7hmrOVtzNNhUbpazE8xXHiapjqxJygNdti0DSklZdYLF3T+yp9P/9X1nYbP61PEDICBbaz40olWZ1UCta7ZdfMVi1uVlDDJxUsodHdVx4PGqFSpqE7tcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzbU3IGId21Xj/3nqeABnVNrdl5l7t28Ysb2PAyv9BU=;
 b=i7lyMTXlGVBGrevzu5jZdpHNeuqa7RhI9HcwEJlguImkjfvC6QSr+gJ7FXRofQ5S1sWPH54o+u4j2NV2DiNoHha6ShRjJpzIOqjaFYgzwfpce21SKXvCmSGFbu+NS6NJTnPbJw4mn3d0l0xAb7np+fuKjqbMlbDbWzZ7k8S2Glg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 05:02:40 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::dc81:c7b9:7aec:68cb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::dc81:c7b9:7aec:68cb%4]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 05:02:39 +0000
Message-ID: <cf8fdb86-194b-34c4-f5e8-dd7ddc56d8d9@amd.com>
Date: Tue, 28 May 2024 10:32:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] sched/fair: Reschedule the cfs_rq when current is
 ineligible
Content-Language: en-US
To: Chunxin Zang <spring.cxz@gmail.com>, Chen Yu <yu.c.chen@intel.com>
Cc: mingo@redhat.com, Peter Zijlstra <peterz@infradead.org>,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 yangchen11@lixiang.com, zhouchunhua@lixiang.com, zangchunxin@lixiang.com,
 Balakumaran Kannan <kumaran.4353@gmail.com>, Mike Galbraith <efault@gmx.de>
References: <20240524134011.270861-1-spring.cxz@gmail.com>
 <ZlCyhDspcZQhxlNk@chenyu5-mobl2>
 <06649B84-DA1D-4360-B0C4-79C81A34BC08@gmail.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <06649B84-DA1D-4360-B0C4-79C81A34BC08@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0185.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::12) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: bce49751-cc0f-42a4-2669-08dc7ed36606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFhJT3d5RmxMdmdZSlo4cGM3ZzF3ckRlQnI0YmJYeVZKTzFBY2dJUWJQcitq?=
 =?utf-8?B?MExUZ084K1g4Y0xnWHh5ZnlicEtFUXlJN3FzNHk1RjY3MittbFc1a1pnU3M4?=
 =?utf-8?B?czVqS1d6RmI3Zm5FTGJvd0Z3b2diVlRGblh1MStudmFJRU1iT0daMnN0eDU3?=
 =?utf-8?B?OXByK3NYSFJvN0VFNEpsblE3QmNVcUJLNnkyQjgyRzNMWEhNZkk1VUJ1alZm?=
 =?utf-8?B?SUVONHZKWWhkSzR2dVZLd2lwK1VmdUtxZDhENjdVbGpLT0Nwb0xFSUdheUlw?=
 =?utf-8?B?a3MzWDF3Vm9ONXY5YmdQODcwN25ib2JtRXhVOWVJK2ZhNFdaQ3hNeVVVZStY?=
 =?utf-8?B?cWVCMG02aVhzaHJtWVB0YXpXZG5uTFYyQlJjNUJpTitTdHFEazdkQk1TUERD?=
 =?utf-8?B?MEZDcFhuTlU0b01EUVdaMXFaL2pFRHJzcFE2SHFBT2FETW8xVGI3SVBlMk12?=
 =?utf-8?B?dnRLRFZOVDdDaFpQNFNLVS85TUJWQnl4dGNOOVk1ZTZScm1SMWRDcmlXMEZa?=
 =?utf-8?B?cVpzNW91ZUs0VDVYWi8wNlllZTFMTU9VVEVjYTR5bFZXRDhrRlNjbUhUanlK?=
 =?utf-8?B?UnR5UVh1UXFzK21mOTNSbk0zc3ZYNlVyZVgwTUYyWGd1WlJOZ0dxbkR0dWxD?=
 =?utf-8?B?OGVWbjhGOTF3NUxDV0had3ljbGlzODZMQVNPeHQwM0tEd3FTREhleTBNRFI4?=
 =?utf-8?B?Y09kOWpPZ3diRS9Ja1dVUUtMNDB5dU0wN1JNYXJDRUNGMkFEN1pRdmlxOTBL?=
 =?utf-8?B?bHUvNXYyY0IxcWxnSlNVTnN2MzRndU5ueFBoajdNWUVmcG9pWGxzNDdTS3Zr?=
 =?utf-8?B?WVptUllUd3FPWWdhNFE2ZVFxS3dXbVFjMThQd0xrbjZaNUFIMnFLUUZqS2Fj?=
 =?utf-8?B?OWhWeTY3M1BCRHVhazJCU1l3U2UzQ0FNbk5zcDdhaGZ3U1dWN2lINmpMTXdj?=
 =?utf-8?B?MTdKNU13ZXY4ckV1eFgrSHJwUUZseGx4a214K0hDWmdSZ3N1eHZVL2U5UWRq?=
 =?utf-8?B?czJWRTVBZ2thODBwbHhVSkZOZjNYU1YzbEZvaVBwTWRjVEVCaFNlcmFPNHNE?=
 =?utf-8?B?NzNtOExQdWNueFdscTRFUktlaFJEbHhhZG9IcXlKOFFnQVVtbXJha3JOdU5a?=
 =?utf-8?B?OW00dlR6MHJPeXhwdmd3aEhkeHk3S1RwMlc0ZHd6c2Q3ZlJZZGFBSjF5a3o5?=
 =?utf-8?B?VDVGYWs0bXV6eFlkdklHUDg4SDRycy9XRS9ZZ3BYZ2tJN2VPSmR2MS9Oc1lW?=
 =?utf-8?B?eEdkWk1JUEdtYVdwUkZVdXd6eWN1Q1FGQW5YYkJGQUNrMjlYbWkwSW9FeGx6?=
 =?utf-8?B?Z3VwK0NHNlA1b2owbUNkUDVROVJ1dGFkbitZOHRhNXFneGhCWWphTkcvSEpY?=
 =?utf-8?B?eGV6VXYyRGUzVE1PS1UvMDJrQ1J4R0k1Z0svY0NFYXZER0RSSE5vck14QTgw?=
 =?utf-8?B?ZkRVN0ZXSEY0MXhtV0Qxdjk1VXI2WWwvK3RwUlFob2N6Ri9tNU9OT1ZCSzlC?=
 =?utf-8?B?MlF1SHVhY1Jza3YyaFBIRmJvQXo5UThJSjdPTit2cUhpYkEyUFhlVnNqUWN1?=
 =?utf-8?B?bHQ0N21rYVZRU0ZPNi9BZTFUMGJMbUQ2T3A2L09wREJDLzlnVjBKVjV0YTRw?=
 =?utf-8?Q?FVaoq+JNbfc2LrFNHblOf2hhNv95m51d8Kl+U1xLN5sw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWdraVg1RHN2WXhUOWZoNlg2WDkvd2tSWmNzOVJiaW1IRVdhczVnREZRMSsx?=
 =?utf-8?B?Q1d4UVJPMUx2bG0xRWZJNnovOE8zRlZlaUtXWVdKci9GeWg0RVFiamc1ejVV?=
 =?utf-8?B?WVZCQzVkaUFqSTBDVUxrellOWmg1QndPRWpHNE9KSi80YlFudzdoem5Sa2pm?=
 =?utf-8?B?MG9nK1NsQVg0Qzhub1BpRnRnZ0k4ODIvMkZEcDJEbkVnRzVVNGZ1RU5uTkNE?=
 =?utf-8?B?SExRWXYvL3Fmc0ZvdVkvNytXZXhJWDNYemlOTWVRbXdwUUh6TEZXakNLc0or?=
 =?utf-8?B?THhqR3dmT1JYUmRFcmE2aWdyRjI3Y1VxcENMVW9jTXdNcS9qVU9jVWs4am1v?=
 =?utf-8?B?MTYrTHpjNThUcTg0MFg4N3VXQnhsUWNrNFFkaC9rQXV6VHpUSW5RMXZQSit0?=
 =?utf-8?B?U2xuV1dzRXNKZWhER3dxOCtrOStmT1N3eXZmN3huWEpCdEJGaTVnTlYzV1Bm?=
 =?utf-8?B?NWViZ2hCeUwzTTVFTUd2b1B5aGs5MktKM2NsVUFSc3RoRHBtM2RSKzFWYjZh?=
 =?utf-8?B?dVhob3RxS3l5QVVaWWdZazk2U0pxMDdpMEdvUW9WOEc5RUlBRFgrdEF2Smhw?=
 =?utf-8?B?eTRFL0hsSkRmYklYQVNmbDJRbnAwUGExOExxYXcrRzZpb0JQWTRHR25qOXdk?=
 =?utf-8?B?SmgxNUJwZ1ZlK3Vkb2lZVXJWbzlaeVFxcTRKZUFGZEpIV2RZbDkvMk9nY2ZQ?=
 =?utf-8?B?NWZZbS9Rc3FhbHl4N3JpZTIyOGY5akdNZ0czQ2NFK1E2WVlyMmF1TnJDWG9w?=
 =?utf-8?B?VWxQV2g1Z1J0UURpcE5XMXl3YzZHemNLdVJidnNpcko5TnNqY3ZXajV1WFBD?=
 =?utf-8?B?OUYrdFZ4YzNBY2wwa3RQY1BRdHJCTGM3V3MyU0kxT1ZIeC9Eanp2VDZldUkv?=
 =?utf-8?B?V1RnR0hPM2p0WVVYZ1hSY3BLc0Z6VjY3NzJyWXVjZkZvdWxXKzQwNWJaclY2?=
 =?utf-8?B?c1R4QTRPeXlXdmpUTGc5MENiNE43V2kxVVVKaUI4bVZmb0VCUTF2RFJuTDZB?=
 =?utf-8?B?L2tPUkl4b1htVkFKdUZwT2YrUGllR2RWSk5zN1JUSnV3cWlCbFV2bytYK2Jq?=
 =?utf-8?B?M2prRm5sb2x6aWtBNWZ4Q3p1RkpGUVVINnRzc0FNQVhRdUVsZElHOGtHYlZU?=
 =?utf-8?B?ZGw1YVFKRHRXUWFtV2FkMXYwQUF5MXNzNFZ1Z0tSdERFT1RVbHRFQWFKTzBC?=
 =?utf-8?B?LzVYRkJmc0U3UUZjZmZUcWRyY0FoUHlJVy9kY1VkODZ1aURRbGVWTEt5SkFX?=
 =?utf-8?B?YmZ4aGRCUzZRNEYzV3VJRWRSd2NpL3h5MlFURUNwb2ozcGJRTlZlZkErZGhM?=
 =?utf-8?B?N3F2elRpSDZNQ0EwZ0lnK0Y2NVZ2N1dsZlUzWGVLVzdmN0JSSHBtUnJsVXRF?=
 =?utf-8?B?eTlPNXBCWmZYcVlXTHp0Ym9xUGpydjdsa08rU0w2bmY2dUdVblh2czZ4cXdk?=
 =?utf-8?B?UU1ycGNWWmZKVHFYWkM3bXlLeE9GNUk1QjBMdjFzVHR6NXpPQVkrclh3aUpO?=
 =?utf-8?B?d1JUK1p3dGl4Tk5ibSsrbTA4NFlta014M1JyRUZYc0FOSVREYXhqSW5IZWph?=
 =?utf-8?B?THZRL3RqLzZRWFlzWjlDRnpEOXNiVlFhVlB6RmpINUVBVlNiTlJjS3JpbHhu?=
 =?utf-8?B?STN1UXZOSVBIUDVtYVByZTh4UlJObE5GMmt6c3FxZktKa05aUFYvU2E1SWJN?=
 =?utf-8?B?STh2OFFKVCt3QS9zWFBxc0pzN1N2bytYTGZUR1JaakxEU1c2VE90R1JSeEpE?=
 =?utf-8?B?WlpXcmRBeEQ5ZUN4anVmall0VldIcC9WcDRrTmZvMmVtbTBrenFFSndlU0o2?=
 =?utf-8?B?YzRVVWpIaUorSmlQSjdNZC9qSGVYQUFUTjg4K1IwYWROMXNjWEJ1cGFjVGRm?=
 =?utf-8?B?Y2ZvcVg2VXczMzNWN05CTGJrbHRJK2NkMlJTOGFvWjlJekUzY21mR3RqZU5q?=
 =?utf-8?B?Sm1UdzNoNFRhVFYrL1ZBMzRySmZ4bElkM1lQWCtOMG1Pc0VQazNDQU1xaE5X?=
 =?utf-8?B?OElTOTM3R3NEdTdQeUdEeGNkdThZQmR2Z1pLWUhyQjVyeEJ2VjhwYTl6V1Nm?=
 =?utf-8?B?UU5HcVQ2RmY3aEw1UUEyc1VrQmIwNHlRYytUenNkSGhUUDZBbnlJVHdUdzdQ?=
 =?utf-8?Q?mtCJU315g2lV1q5/KpBaKyg7R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce49751-cc0f-42a4-2669-08dc7ed36606
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 05:02:39.8243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2htipXHrUTC2tudWCnxq4OrOo7r1GV3DQILsQZ1z6Ik+oH4SmZPGZD+yOjz5H5r7fHEc517UVczfJjkMRdXvgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463

Hello Chunxin,

On 5/28/2024 8:12 AM, Chunxin Zang wrote:
> 
>> On May 24, 2024, at 23:30, Chen Yu <yu.c.chen@intel.com> wrote:
>>
>> On 2024-05-24 at 21:40:11 +0800, Chunxin Zang wrote:
>>> I found that some tasks have been running for a long enough time and
>>> have become illegal, but they are still not releasing the CPU. This
>>> will increase the scheduling delay of other processes. Therefore, I
>>> tried checking the current process in wakeup_preempt and entity_tick,
>>> and if it is illegal, reschedule that cfs queue.
>>>
>>> The modification can reduce the scheduling delay by about 30% when
>>> RUN_TO_PARITY is enabled.
>>> So far, it has been running well in my test environment, and I have
>>> pasted some test results below.
>>>
>>
>> Interesting, besides hackbench, I assume that you have workload in
>> real production environment that is sensitive to wakeup latency?
> 
> Hi Chen
> 
> Yes, my workload  are quite sensitive to wakeup latency .
>>
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 03be0d1330a6..a0005d240db5 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -5523,6 +5523,9 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
>>> 			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
>>> 		return;
>>> #endif
>>> +
>>> +	if (!entity_eligible(cfs_rq, curr))
>>> +		resched_curr(rq_of(cfs_rq));
>>> }
>>>
>>
>> entity_tick() -> update_curr() -> update_deadline():
>> se->vruntime >= se->deadline ? resched_curr()
>> only current has expired its slice will it be scheduled out.
>>
>> So here you want to schedule current out if its lag becomes 0.
>>
>> In lastest sched/eevdf branch, it is controlled by two sched features:
>> RESPECT_SLICE: Inhibit preemption until the current task has exhausted it's slice.
>> RUN_TO_PARITY: Relax RESPECT_SLICE and only protect current until 0-lag.
>> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/eevdf&id=e04f5454d68590a239092a700e9bbaf84270397c
>>
>> Maybe something like this can achieve your goal
>> 	if (sched_feat(RUN_TOPARITY) && !entity_eligible(cfs_rq, curr))
>> 		resched_curr
>>
>>>
>>> @@ -8325,6 +8328,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>>> 	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
>>> 		return;
>>>
>>> +	if (!entity_eligible(cfs_rq, se))
>>> +		goto preempt;
>>> +
>>
>> Not sure if this is applicable, later in this function, pick_eevdf() checks
>> if the current is eligible, !entity_eligible(cfs_rq, curr), if not, curr will
>> be evicted. And this change does not consider the cgroup hierarchy.

The above line will be referred to as [1] below.

>>
>> Besides, the check of current eligiblity can get false negative result,
>> if the enqueued entity has a positive lag. Prateek proposed to
>> remove the check of current's eligibility in pick_eevdf():
>> https://lore.kernel.org/lkml/20240325060226.1540-2-kprateek.nayak@amd.com/
> 
> Thank you for letting me know about Peter's latest updates and thoughts.
> Actually, the original intention of my modification was to minimize the
> traversal of the rb-tree as much as possible. For example, in the following
> scenario, if 'curr' is ineligible, the system would still traverse the rb-tree in
> 'pick_eevdf' to return an optimal 'se', and then trigger  'resched_curr'. After
> resched, the scheduler will call 'pick_eevdf' again, traversing the
> rb-tree once more. This ultimately results in the rb-tree being traversed
> twice. If it's possible to determine that 'curr' is ineligible within 'wakeup_preempt'
> and directly trigger a 'resched', it would reduce the traversal of the rb-tree
> by one time.
> 
> 
> wakeup_preempt-> pick_eevdf                                      -> resched_curr
>                                                  |->'traverse the rb-tree'  |
> schedule->pick_eevdf
>                                    |->'traverse the rb-tree'

I see what you mean but a couple of things:

(I'm adding the check_preempt_wakeup_fair() hunk from the original patch
below for ease of interpretation)

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 03be0d1330a6..a0005d240db5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8325,6 +8328,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
>  		return;
>  
> +	if (!entity_eligible(cfs_rq, se))
> +		goto preempt;
> +

This check uses the root cfs_rq since "task_cfs_rq()" returns the
"rq->cfs" of the runqueue the task is on. In presence of cgroups or
CONFIG_SCHED_AUTOGROUP, there is a good chance this the task is queued
on a higher order cfs_rq and this entity_eligible() calculation might
not be valid since the vruntime calculation for the "se" is relative to
the "cfs_rq" where it is queued on. Please correct me if I'm wrong but
I believe that is what Chenyu was referring to in [1].

>  	find_matching_se(&se, &pse);
>  	WARN_ON_ONCE(!pse);
>  
> -- 

In addition to that, There is an update_curr() call below for the first
cfs_rq where both the entities' hierarchy is queued which is found by
find_matching_se(). I believe that is required too to update the
vruntime and deadline of the entity where preemption can happen.

If you want to circumvent a second call to pick_eevdf(), could you
perhaps do:

(Only build tested)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9eb63573110c..653b1bee1e62 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8407,9 +8407,13 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	update_curr(cfs_rq);
 
 	/*
-	 * XXX pick_eevdf(cfs_rq) != se ?
+	 * If the hierarchy of current task is ineligible at the common
+	 * point on the newly woken entity, there is a good chance of
+	 * wakeup preemption by the newly woken entity. Mark for resched
+	 * and allow pick_eevdf() in schedule() to judge which task to
+	 * run next.
 	 */
-	if (pick_eevdf(cfs_rq) == pse)
+	if (!entity_eligible(cfs_rq, se))
 		goto preempt;
 
 	return;

--

There are other implications here which is specifically highlighted by
the "XXX pick_eevdf(cfs_rq) != se ?" comment. If the current waking
entity is not the entity with the earliest eligible virtual deadline,
the current task is still preempted if any other entity has the EEVD.

Mike's box gave switching to above two thumbs up; I have to check what
my box says :)

Following are DeathStarBench results with your original patch compared
to v6.9-rc5 based tip:sched/core:

==================================================================
Test          : DeathStarBench
Why?	      : Some tasks here do no like aggressive preemption
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
Pinning      scaling     tip            eager_preempt (pct imp)
 1CCD           1       1.00            0.99 (%diff: -1.13%)
 2CCD           2       1.00            0.97 (%diff: -3.21%)
 4CCD           3       1.00            0.97 (%diff: -3.41%)
 8CCD           6       1.00            0.97 (%diff: -3.20%)
--

I'll give the variants mentioned in the thread a try too to see if
some of my assumptions around heavy preemption hold good. I was also
able to dig up an old patch by Balakumaran Kannan which skipped
pick_eevdf() altogether if "pse" is ineligible which also seems like
a good optimization based on current check in
check_preempt_wakeup_fair() but it perhaps doesn't help the case of 
wakeup-latency sensitivity you are optimizing for; only reduces
rb-tree traversal if there is no chance of pick_eevdf() returning "pse" 
https://lore.kernel.org/lkml/20240301130100.267727-1-kumaran.4353@gmail.com/ 

--
Thanks and Regards,
Prateek

> 
> 
> Of course, this would break the semantics of RESPECT_SLICE as well as
> RUN_TO_PARITY. So, this might be considered a performance enhancement
> for scenarios without NO_RESPECT_SLICE/NO_RUN_TO_PARITY.
> 
> thanks 
> Chunxin
> 
> 
>> If I understand your requirement correctly, you want to reduce the wakeup
>> latency. There are some codes under developed by Peter, which could
>> customized task's wakeup latency via setting its slice:
>> https://lore.kernel.org/lkml/20240405110010.934104715@infradead.org/
>>
>> thanks,
>> Chenyu


