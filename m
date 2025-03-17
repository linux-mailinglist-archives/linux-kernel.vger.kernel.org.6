Return-Path: <linux-kernel+bounces-563313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E81A63D72
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 04:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C714616CF56
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC02D1519A3;
	Mon, 17 Mar 2025 03:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ILQuqTt+"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4BF4A24
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742183380; cv=fail; b=FLcqFvLKANBUsHRgn2MegmB/0nKXJYKVAXDYUZ6Fa42Y+2pryXRsCktJ0QETzGTJ3GDhPCY5F0SEbQ91mOPUeZQnhbsfMKoCl+qax+voOlLvlYHlr1no+msfU6UYZaqKy+4mik1w0jhZxLQ6IdvlpYRyiPu3Nytrll2gVf8nKyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742183380; c=relaxed/simple;
	bh=cXDmS65A1qqtQrknlsdHeU9B53I7j7r3Gjcl0Fbf594=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IBXVot6urOudInIz7yJSXsKDhReXqHbXICRcKINwxlVBNJXgK3sMD0BWeZZUBM9eNaXuNDoLPxI6Xc2GLmdqp7W6j9ES4D32wRTxbkJA3rLvVVDgM9zEXSVCSPQpvimP9RvF6cHmjIH7+eiiq/A880AKwWBkrUu2MKFfEKWO1Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ILQuqTt+; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3h5AC7c2rywdl6e6c8thn/pg1MGuBsisxcLBPgOyDNLs8mDiypBoo5V3YSX01BHfhw82QqDA4rimzBI1PVDBYmty2X+i1lnUrlrFo7CnBPFQeKelBVH+6N1bgBMwez0nEPuTTEapA7ovVM5kkkV7Xb90LUPgRfAI0/sVWI2mxwrz5JFciqy+CK+pwBXFtb9QBDW3HGuTKFSRkvv7BZqv5atGWItmAk7kMD3VygYxMVrDroUpHMFuoaW3bS6DDKGpjCVrPdSR/9Wr+ZwnMBPWBatlpWF6PsYpi2VesC/ZrAi2FyiyMywI9La8T/Xhe3+BHbOhOlCi4b8lGf+YhwS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU0PHUjwrHxEZqRIplsY1sQydt5q2MZoEy4mtZ67SWY=;
 b=fqEK9sdDSzeQrXgp5257xOaGhANdr6OlFSCFSZ34CtfKdjZbWm293pl4BxY/GTIR0IqKDY6wv9dgAi0JoFkT5pFbmIHHC2GUh6Ij8BqWg9OStHgI8Q8LXvkE7+dH/7JBJ7f5rp4AHrW+xezitQei8VVjV9mgyTeI6Zl3ZOptdVCauVsyfR9twM/pb1i4shYZXer1ORAv5WWddTndalebKwuzOqZdRSwruDhLAd5zb9CjpLbyM5zotj7eYYoD61T71XTc1Md2ayI3pLalgCCnvkoTP5GsmFTXaO2cdvpQ+46ybZVhyP+8n68OUYcqxLto1IlepNu8GjduFP+LAsOQiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU0PHUjwrHxEZqRIplsY1sQydt5q2MZoEy4mtZ67SWY=;
 b=ILQuqTt+7gUf4RAbhGdgDjUhdk+sk8F8IqS4N4qljOBJCAMLr/8fXovDPX4upfWuQmR27X3ko7ft+vw2HIKU2+LONzbEMxiIkqhXiuMi1SZFOI1SEeG1j1PPc2YC7QhABSobrNy4Y4qE5zN8JQumctV1WIfAHYEd1MH92s27t4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Mon, 17 Mar
 2025 03:49:35 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 03:49:35 +0000
Message-ID: <4a37ec49-008e-47e3-8aa4-462bc6be6d49@amd.com>
Date: Mon, 17 Mar 2025 09:19:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm: kpromoted: Hot page info collection and
 promotion daemon
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Jonathan.Cameron@huawei.com, Michael.Day@amd.com, akpm@linux-foundation.org,
 dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com,
 gourry@gourry.net, hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
 jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com,
 kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
 liam.howlett@oracle.com, mgorman@techsingularity.net, mingo@redhat.com,
 nadav.amit@gmail.com, nphamcs@gmail.com, peterz@infradead.org,
 raghavendra.kt@amd.com, riel@surriel.com, rientjes@google.com,
 rppt@kernel.org, shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
 vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, yuanchu@google.com
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-3-bharata@amd.com>
 <20250313203607.zod6lssjef37ynbf@offworld>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <20250313203607.zod6lssjef37ynbf@offworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|DM6PR12MB4402:EE_
X-MS-Office365-Filtering-Correlation-Id: 97750881-3e75-41ad-f7b3-08dd6506bbf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1MzMkZkbENlTjJBcFF2Z1A4WTh1S2ZoK2t5VDlLeWJ1bHdFNkxkVDZzQ1NU?=
 =?utf-8?B?SW93QXRONVJsNHEvWjNudTVEOVRVOGF6SHFYNHlZR3puRm82eDdTQjRSOStW?=
 =?utf-8?B?eG9NYnE0SGplZjFmLytxcHZDeCszYkpKOWFXa1prWU5vc0ZQWDc2MFBTTFJB?=
 =?utf-8?B?UVNxRVVuZVYzQllxT0VlTWNTOFJIRGRIWG5ZZmd6bVhaRkR5bEtpZlAwZG5B?=
 =?utf-8?B?Znp6UHJVdTJwMVViUm42MThVTVRRRGd1RVVhNmhMclNEQ0lSZEErRElhVUZp?=
 =?utf-8?B?YmFiNkxoZ3pCbHZjcW15TUhpM1hJZDBGejJ3NWVTR2ZKVXdRVk1RbWNEMlpy?=
 =?utf-8?B?TXZmVHV3d2JwWjljUE0vZFZ5VTkzbXNveWlXVHVmRlNrSXBaRlhESjNIV3FS?=
 =?utf-8?B?THVCN0lPb0ZidHN2dlVDT0lOVEFiZkw0QnNFbTFVZThoR0RJbkl4OCs4Ympa?=
 =?utf-8?B?TC9LazAyc3NGWHliWUJ1VE1lYkJYZmJzSTc2TFJOL21oWUJKeVF5MWQ0WlQ0?=
 =?utf-8?B?N3k5SWswRkdFQ3ZSSXY4ZkFyWFZ5REdiakRHSjBpZGRFS1dwUUZXU0JvaVpz?=
 =?utf-8?B?Q1JCK0k4TDFPTkpyOUIxZ2Z2RTh3czQrekExbVNBRmlaLzl6YWRnSzhwUktj?=
 =?utf-8?B?eWhRTzYwekpMSkg1WHRiVGwyYllCNCtxVDVpV2twNFVNM2owMXArUzRabmkv?=
 =?utf-8?B?MnI5d2dsVmI5Um1CNUhhV3IwSkhEOUErT1E2YU8yL0w3UzFOTjVJSno3OUUz?=
 =?utf-8?B?a0FUbGxuc2hZZjUrWXJYWW8rMXVldTNPL3BEbVJmZTNKUVZ3UDEzWVFtcHFL?=
 =?utf-8?B?V2FoTmFkMnFyb2RlN0dBVlRtZ0lmMGpNWWYxOEhOakI1TXloR2R5MzFLRFNa?=
 =?utf-8?B?cS8xbnJIdldoUFQrK04vZnUrcjZidnNZRnN6ZWl4eXc5T28yQmJVeHNnUlVY?=
 =?utf-8?B?SmR5UHNNSHlDQUwzREVvZ1ErR1lwRGJwa1ZUeElsK01HbGhSSnlzKzRhZXgv?=
 =?utf-8?B?dFZ3NFBGdjdRUnBwYVJTY0FSY3RPUnNFczhTL2tJbFBEWkF6NTA5US9FY2lX?=
 =?utf-8?B?bitlVWdRMWhPY3ZiSkt2SHRDQW9OYWx0aHNVa05FdkVOOGtLZEtETEJCRHdj?=
 =?utf-8?B?ZFdQWW5rbkZzQ01lSytOL01XNldyVDQvMVluZnZQT2ptSFpTbHdRUExjemo0?=
 =?utf-8?B?b3dvVDRyWmVMUXJURkdYWXFhZzZ4Wmc2aG04L3c0MG55QkpnNHdudTNlNm1Z?=
 =?utf-8?B?bmxlWlhYNVZVeVZTWXUrWmJIVnkxMWt0amk5OEgxbXFVckE4Znd5U3MwNWhV?=
 =?utf-8?B?eTZUQTBUZm5OVkFPWEsxQWxCOEFkakhoRjVmNjhVYXc3a2lLQ0hmMW94UFZL?=
 =?utf-8?B?SEp1QmF1VnZkR0lac0FhejUydUZFT0xvQVhCVUxXcktiTHR1SHVHVjYzWGNI?=
 =?utf-8?B?a3FiWVNVQ1ROQ1ZteXZNVXM5S0p3TEJTRHlDdTV1SGxvWXFSbFU0NExyTjNO?=
 =?utf-8?B?RkFQSTd5MHNoZkx2aTRaa01XT0hycHZUZUFFaHFNVjJQUUxrWVpiN2JIQjhM?=
 =?utf-8?B?Qk9kUTZlQklUWDVpcmhMZXhHR0ZYc2hvdmdTRlh1V3JKOWphMS9wZ0JNd2dB?=
 =?utf-8?B?N1lEdUFsNndFczRNb3J0VEgyUElSc1JNTXpLZ0c4Ny9ndmtaVDhkSk1MMHhP?=
 =?utf-8?B?WU5kV1pTNTVMeHdUcmwrak5MOFhod1J3TDV0KzdoUEwvZTdnYU95cXJKamI3?=
 =?utf-8?B?Q2tHaUVhUU5nYUM5amJEOEZaNXh1OHAyRDEybHVYM2NoWWtFNTl5OUFHZTFz?=
 =?utf-8?B?aWJKNFd5K1B6OEd6NDFNYjhIUGtkcjdUaHNIMDBtbURsUGVPOEtoQ0QvOW12?=
 =?utf-8?B?NkNWWHU4ai94MXovQjVvSm5yT1VaOWExenk5YjRCeWJZQXNGS2NLdU04cEhV?=
 =?utf-8?Q?kSYfD9+MuL0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUswTFo3cVdBZHduU2FhQS9TRDZhbExWMkIrY1dPWWZZeExJTEhaUlNsVlYw?=
 =?utf-8?B?QWZtY2piQXo0ZmR3NEFqYS9RREp1VE9Ed2J3UVNMVmpCWEFLSnBXWEhPbllx?=
 =?utf-8?B?bkVZSFZPUTNEUnByOHJnbVgvSkoxS0Q3bXdCdk9ibFd6MDRrbFVwTzRoN2xU?=
 =?utf-8?B?RGU1WXVCNVZYNUJGNHJwZW1wMk5TeUpCMHUzeWVjemZJUVZhNjBleGd5WGt5?=
 =?utf-8?B?aTBrcWNXVGFxaUtNVm9Zc0xRRVlYZlpBZVVRT0pkTjhIcTRBWkVrQng0UnJh?=
 =?utf-8?B?bTNaYk1CcG9JaUp3bm1qUDZWektIQndHaTVERExXWnlibzJQQjVRVVV6anhC?=
 =?utf-8?B?SnJiOTY3KzJ5WEFqdEszcWR2UVJtTEVKdmQ3cmljU2wrVkpWOVFoOTZwdElX?=
 =?utf-8?B?eGNPd3BOZlpkR1J2ZmlvUHhuZ0FHcjFsNk9jTjROb3JOYXk0NzBrZUZnWVlE?=
 =?utf-8?B?NmxtL0lza3YzeEZpUDdZOWpyMkhMTzlKTWtwa3hYWDZjV3JuOEk0UDdpbUZi?=
 =?utf-8?B?ekZyT1V5SSttMDdXSE1HRmJLNDl2eEp3bFdKb1NvNTd3VnhwNjRTcmZJK1o5?=
 =?utf-8?B?VFVzUU1uNFE5enVMWnVVcjViejRZUDViWlFPUDRpUTl0c0NZWmhsbERUNUN4?=
 =?utf-8?B?VmhtTGtmRWYycTFkZEQvM3dqRWZqYmViMzJaRFNVS3ZCQkpTMjM0K3NIbXZ6?=
 =?utf-8?B?YWdaV0FOT011UDRTQlpYc1NLTFNTM2J5Zno2OG9lTUlmT25GeWQ5eHVMUjA4?=
 =?utf-8?B?eSsralBLK3RLSW0wZlFDaVpNRDFVc05IOUh3MEdLZmk1dzg3QW11c1hJOWdi?=
 =?utf-8?B?Y1hDMFhZVGdacnI5RFB5M2ZrV21zNlE5ZjZKTjJpMEoyV2ZXckxjWUcwMHlF?=
 =?utf-8?B?OW1oQ0lCaURWblNRekRWaUdpOGpZa254WGEyZU82dThCa3FMMUdIeTZSZDZj?=
 =?utf-8?B?VjBJdWJ5WjNhYzRKZk1Uc1pkYjFJcTVKYzJMYkhNZ2tSOEtkbGVORFZYNFRr?=
 =?utf-8?B?ek9qLzF2bUZMZlUzWTBtNVpZWnJCNkJETDdMZG5NejBZYjVLTm1hTXFnWlNo?=
 =?utf-8?B?RnhaZHdMVWdUenlGM1dBR0h2SHFYVTRqb0RFTUxqL1FXWlBFTTRhTnRYcGl0?=
 =?utf-8?B?MWxpeElDdHk1YTF2M2ZjRmhlMVpGY0luTkl3cEpyYytWaXpjM0pMbndPZ3J6?=
 =?utf-8?B?VnoyUkNzaG1mbkFnRWZ1VWUvMEtqb241OXdFNG1KZHNhTjNNbEpOSEVDZ0Vk?=
 =?utf-8?B?OTF6dHNlQndtT0M1c1BOb1RvaC81T1REOU5ZazdnaU44cGRFMmd1NWYwQWRl?=
 =?utf-8?B?akx3RE04RStIRERjdmFXQlpPZ1Q5NGtIN1BSYkI2Tmh3NElFUnJuZGtFMTVB?=
 =?utf-8?B?YmZNdTc2M0czSmdLR2NIVkVheWUwSGw1OUd0RTlnUVlTYVhiZmVPdFZ6Mk84?=
 =?utf-8?B?OFRuR0RRbkZkWDFCZ1Q3QUpYUFNYdnpPWHVhMW94eGpUWXJyMmxVYy9BRXov?=
 =?utf-8?B?enZOcnhyQlZLZnNzWlJwalVqQ2l4dE94SDc1WHNYZUs2UXpYR20yNG1OSHBJ?=
 =?utf-8?B?UVV2UlZvaDVRUGZ0SFZPdUV5UlFQdEVJVWgybDFicWpUckw1RmU4aUo5UHd4?=
 =?utf-8?B?SWNLR1R2Rk9HRFFFbGR4ekFVNlhTU2pTdngzZTJpS0JsbG1WdHdqbFZVc3Vo?=
 =?utf-8?B?d1paTW5TVmxRdEtpdjJjTTNvRjBsaHQ3Rmc5WURXMjZKYnZ6cFpwMFNBQlpL?=
 =?utf-8?B?WndlTGxiejR4Qmdpemw1eStxN2ZJYW9mK0V3Z1FjcnpEUU80a3BtNEpWU1lC?=
 =?utf-8?B?WXZxRFhyTXF5Z08vUC9XaWFsUFNvbFBBbXU2L1EzdW1PaFNkbU9jWVFyVm1o?=
 =?utf-8?B?MlA1U3lVek0rSEdrSVUxNUVaaXlZRkY2bmZ5RU0vVTEvM0MrMElRMU9sa3FZ?=
 =?utf-8?B?NDM3ZW0vWVRaKzFYOFJxNHdFRHNWOXZ4enFBZUJuc09YelNXODBOVWFmN0lJ?=
 =?utf-8?B?bVgya0JSSXV0cjRzamk2L2Z3a09xMUhNYld1V244TnFTeDJKK0p1QVFnVTFR?=
 =?utf-8?B?cVJydHl2dGtOT0VZcmhyZDNIVGlQcEpIU214SnRMUzFKNXRBZmVMS0N2L3F3?=
 =?utf-8?Q?R7Ul8IoYDQxAFs9Hen5Ar1K7w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97750881-3e75-41ad-f7b3-08dd6506bbf4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 03:49:35.7777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umh9VX+aQJeUJ5Mo/Ux5VqYBDoT7d6+8vtEsBp6cBQmCeoYnTbMOyUo+hA4OzhF80zCZNwYtlYNnCV8G0j8Tuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402

On 14-Mar-25 2:06 AM, Davidlohr Bueso wrote:
> On Thu, 06 Mar 2025, Bharata B Rao wrote:
> 
>> +/*
>> + * Go thro' page hotness information and migrate pages if required.
>> + *
>> + * Promoted pages are not longer tracked in the hot list.
>> + * Cold pages are pruned from the list as well.
>> + *
>> + * TODO: Batching could be done
>> + */
>> +static void kpromoted_migrate(pg_data_t *pgdat)
>> +{
>> +    int nid = pgdat->node_id;
>> +    struct page_hotness_info *phi;
>> +    struct hlist_node *tmp;
>> +    int nr_bkts = HASH_SIZE(page_hotness_hash);
>> +    int bkt;
>> +
>> +    for (bkt = 0; bkt < nr_bkts; bkt++) {
>> +        mutex_lock(&page_hotness_lock[bkt]);
>> +        hlist_for_each_entry_safe(phi, tmp, &page_hotness_hash[bkt], 
>> hnode) {
>> +            if (phi->hot_node != nid)
>> +                continue;
>> +
>> +            if (page_should_be_promoted(phi)) {
>> +                count_vm_event(KPROMOTED_MIG_CANDIDATE);
>> +                if (!kpromote_page(phi)) {
>> +                    count_vm_event(KPROMOTED_MIG_PROMOTED);
>> +                    hlist_del_init(&phi->hnode);
>> +                    kfree(phi);
>> +                }
>> +            } else {
>> +                /*
>> +                 * Not a suitable page or cold page, stop tracking it.
>> +                 * TODO: Identify cold pages and drive demotion?
>> +                 */
> 
> I don't think kpromoted should drive demotion at all. No one is 
> complaining about migrate
> in lieu of discard, and there is also proactive reclaim which users can 
> trigger. All the
> in-kernel problems are wrt promotion. The simpler any of these kthreads 
> are the better.

I was testing on default kernel with NUMA balancing mode 2.

The multi-threaded application allocates memory on DRAM and the 
allocation spills over to CXL node. The threads keep accessing allocated 
memory pages in random order.

pgpromote_success 6
pgpromote_candidate 745387
pgdemote_kswapd 51085
pgdemote_direct 10481
pgdemote_khugepaged 0
numa_pte_updates 27249625
numa_huge_pte_updates 0
numa_hint_faults 9660745
numa_hint_faults_local 0
numa_pages_migrated 6
numa_node_full 745438
pgmigrate_success 2225458
pgmigrate_fail 1187349

I hardly see any promotion happening.

In order to check the number of times the toptier node was found to be 
full when attempting to promote, I added numa_node_full counter like below:

diff --git a/mm/migrate.c b/mm/migrate.c
index fb19a18892c8..4d049d896589 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2673,6 +2673,7 @@ int migrate_misplaced_folio_prepare(struct folio 
*folio,
         if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
                 int z;

+               count_vm_event(NUMA_NODE_FULL);
                 if (!(sysctl_numa_balancing_mode & 
NUMA_BALANCING_MEMORY_TIERING))
                         return -EAGAIN;
                 for (z = pgdat->nr_zones - 1; z >= 0; z--) {


As seen above, numa_node_full 745438. This matches pgpromote_candidate 
numbers.

I do see counters reporting kswapd-driven and direct demotion as well 
but does this mean that demotion isn't happening fast enough to cope up 
with promotion requirement in this high toptier memory pressure situation?

Regards,
Bharata.

