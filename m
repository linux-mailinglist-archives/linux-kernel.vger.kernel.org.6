Return-Path: <linux-kernel+bounces-233340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 123F991B5B5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 06:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8E91F22D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 04:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0A4210E7;
	Fri, 28 Jun 2024 04:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v9K2+pJF"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F379920B0F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719548871; cv=fail; b=jpT40teqSQDsSAR3G5GlEAfYFbLQnlqlqT+eM8Vac3KxHaGZeqoaMQIt5rH0MyKhE/Zv0ZwQKor3kI0xloGyNIl2V03eq7ZExwQooIy6Osr8WgY4MUbQkWfKcFm0smTSL745pNHKtc84P3aw5ZPG+KoBK6bj38u0dWLr1RortOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719548871; c=relaxed/simple;
	bh=gJLAJGzOsCo75yOBwlQupF5DefGfL6pXWoAkcY6aPmY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qFog7FBxiGbdksti7ji5cOCHdgE/DDlwPewQvwlEGQgg8g6bkbdXNPsLwQ1kT/zsL1TXg2wO6sP/hDt5OH7RUavHZ54pHuztg4rInBA4ZZDvybzFJ3oLXo14p9nJlZJYgY182WWGkgF28unIDw65pc8LS4guKuhC3P60jPuxBxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v9K2+pJF; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8HlXnC11gUuhT6806Gi6o/yC60x6SToNSfEbu/qKw/MbuSpt6kJoMDdVdpZPhj18piG82I6QH+4aTwwtAyj9+GUsjKe0M1/oSzCS6+KuutyduHZb5XTiD2lelicBJX47RD5Db8OrV0b4mNUiuYTUf6eNRGU/N/1BsAJjqapZ9osgDXSulWH3sJHzedLk1iOgWuD6c0/JXWyzaS4PUk2DTkKNNE7eOdjMZQuJVBX6KWtLt5FdMISZgHIIDeH5MVmFrZ6vn9YTPV7UQ7fI1tuE5XZvKjlQWFL8Mfyknr2+JVklw1eYuXK597uD7LAD7OGsfataqiryXAko3LJGWKMrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVNidd6fca0DG9D//vLls6ukydx4Sck2VBCC2felkE8=;
 b=gVIgE3fMP3iB1/hkjjULdsh57nlu2hrxOcAVsUbPUiVeY7eiamQC4IGlA/ILHu8lRqoOf9orqks6zCEcuv2NwSGJOFFU8A3HDs5WNPPsSl2eBZilzWYwqFWh4BsiJRKmpbp5yt/7cW+ZLHv9nq9W6tTADV67JunOVLl1h8ipJY11zw57FM9hA1G44wa7f584bVD5k0+6Jrn+bOJV2rxozcLpjJkQagA0CIQfbjSzmSMrpVwT4FRt/jr9+yvn11XsvntFBqoEN7+rSjq6M4+D7RD5HOn2WB6WIZglI8nFQFoXuhWUHenNfkkWgWr4/TQ6kD5RddreLADc2rl9uxxhpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVNidd6fca0DG9D//vLls6ukydx4Sck2VBCC2felkE8=;
 b=v9K2+pJFzh7AY3Vsn3juTmtvXaOHer3ilPhnw/ML9Xy514RLhGu104CWmaQKINO6Zncj3zKBJogFKsGEuB8Oozboo8AJ9yLz5669wh+YOMq6d8AqJLXHFubGRi6S/WwbXjVOQgzhc00TNdAYz3E9IDPjJlH0exs+S7dpUHE0wlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by PH0PR12MB7981.namprd12.prod.outlook.com (2603:10b6:510:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Fri, 28 Jun
 2024 04:27:46 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 04:27:46 +0000
Message-ID: <8834ead0-26f5-4228-889c-483d60e73380@amd.com>
Date: Thu, 27 Jun 2024 23:27:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] x86/snp: Convert shared memory back to private on
 kexec
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, rafael@kernel.org, hpa@zytor.com, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
 vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
 jroedel@suse.de, ardb@kernel.org, dyoung@redhat.com,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
 <cover.1718920799.git.ashish.kalra@amd.com>
 <f6c0ddfd15579674bc234d6e1b84e92768531050.1718920799.git.ashish.kalra@amd.com>
 <20240624182615.GLZnm6R4hLvnlF16aP@fat_crate.local>
 <ba22b2d8-5621-4efc-8dc4-03b92408155f@amd.com>
 <20240625035909.GAZnpAjaV72A50kcWs@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240625035909.GAZnpAjaV72A50kcWs@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::30) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|PH0PR12MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: bc030ab6-bfab-456e-60fc-08dc972aa926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWxNUzJ0eWcxQUlqaE9zcmFBbnR0SjkxTGJST25abmJtZ2FUd2JIMEN6aGNJ?=
 =?utf-8?B?YXBrcUo2YWFkeWtZK2laVFgzUmdScGJOc1J4dlNWOCtYQkpER3hXcHlSZ0Rz?=
 =?utf-8?B?VmdhOXZPN0pVSmE0c3hJdklCMldVdlYyTitRcjhYUFFXa2dHc0M2RGZSaFFP?=
 =?utf-8?B?amFheWtLL2hwdmJPZ3dRVytiMjZhSDVQSHhmWTRzSkM3Zlg3bm1icm54QXds?=
 =?utf-8?B?Yy84a2ZVdXRTbUZvcFVIenRLMHE3c2t5akZsK2VFQ2ZPTjBxcFJsbDQ0VTNp?=
 =?utf-8?B?L3laVFRsWkRGcEk3c2FNNVd0dnNuVnVybDNVZFB4dUZKMTh3eTRnMy9JeGo2?=
 =?utf-8?B?eDVKS3Q3Y09NVFlTRFBnV3FkMFhocnlSL3VPQWlERm5XMXVCRi9XbnRkMHlR?=
 =?utf-8?B?RlFsNmdDWm1veGN1REY4Z3hETHd6ZTJwVWE4aEs0TEJRcm1udW9lZlQyanJQ?=
 =?utf-8?B?RGN3dWozNjRCWUNWc2l5djZhdjRSLysyS09nakRFYWx5YS92TldYMjVveisx?=
 =?utf-8?B?c2lNQW5DYWEvWVJFaS9XZHNKVXBnYjBCUkJtN05udWJndXBNczRZL2dWM1Vx?=
 =?utf-8?B?am4xQTdhSWFiMTJqcExHQm04NzFVQkJJK1laNEkrZ3hLYk1wK3ZsN3JtVVdw?=
 =?utf-8?B?MTdUaUpETGp5WDZjeG43MzkrcXRGOC9tQ0FtdnAxeFpzVXI0WVc1M2hTUDg4?=
 =?utf-8?B?RkY2RzVNeDJVbWN5UkZ1d2x1dkIvWk1nV3RVZ0Jza3RxNDZ5dVVLclZHQ0Yw?=
 =?utf-8?B?dUJFOGZVWmplaDJHcytmM1pLUC9lRWMxczg1d2R6L0ZMeEJZTlJoblhZcXVr?=
 =?utf-8?B?UjdUYVFnVkl6SUEzLzZiVm1UVmVQcUdpSjg5bHRsS3FDdUk0Q2cxNmxKTG5I?=
 =?utf-8?B?bGdsOWRUWlRMeGxtQ1NGUkZLdmQxWk5lMVR0OXNlN09MRCthL1g4VGVvQ2lF?=
 =?utf-8?B?OXpzN0w3aHE5QytlUWVPRGpzNXp6ckxHU3hGSXhYYmxhUnBRNjI1RXV5Z3ZX?=
 =?utf-8?B?MENpdENVelkzZlk0TnNGc0diNVoxY1RWQ3Y3TXlQTFdFeHJiNTNUZTg1U1Ni?=
 =?utf-8?B?RkFFVUZYNlRPdUJGZ1dDbWovdDcrSXN3eGMrLy9mblJNakh1NmtTQXVHSXFl?=
 =?utf-8?B?V2ZnMGpaL0pRKzgrSzNCdTcxR0pWM0ptZElRMW5zdy9MbjZDaGhMdXFtTlRu?=
 =?utf-8?B?QXh2OThaTzM1NXAwMDVyNE5WbTdVRmhkbEFQWnl5RWg1ajJ5OExiMy9xMGc4?=
 =?utf-8?B?YU5hNjU1OVJRVGw2OHlKbHhZaHhvU2lsVFBWZktGOGVWWnVEV1FUcmJXYUdy?=
 =?utf-8?B?YWovZVhYWlF0OW5tRlNrT3FXQUdpNDF0VlhidzhYY0RWakdBazVKT2FzeGNU?=
 =?utf-8?B?RnErM2o3bzdTMEVKdXI3a21STEtNZURrQU03ZVZtWnFSUXpmM2JRa1M3YzZ5?=
 =?utf-8?B?aTRhMU1CaUpmODVTRlhkb2JRNXN1Y2I5SGN6am5DVkNlT3RMLzlBZjNWWDhJ?=
 =?utf-8?B?eWthYVNac0NOQTZpUUNyZTFrM3MvM2ZHSUdVdVB4eWo5a0dxaHNlQ1AvMklr?=
 =?utf-8?B?ZEN2Nk5DYTgxQUxzMG1hQmZZbm4zMUoyZU9TMTh0c3NZNHB3R0VXNHBzdDNI?=
 =?utf-8?B?WjR5OXpxY29EblUzYThpODBsK012RXNmVVNsVjQzMlFsL1MyM2pNSXRXQjV0?=
 =?utf-8?B?Yk9pSVgzdFV0TzAxaEVLMkdPb2hXUSs0TUF0cW55M3lGNjhjNVg3SGphSUt6?=
 =?utf-8?B?WXBPUWxXaW04UzFRSGt5Tlg5VVFRaW5yQVMrbFNHTFVscEZaazlra1dqMHZL?=
 =?utf-8?B?Q1Q3Y2FaWkt5UmZhVzFhdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVFuTTJYNUZrbUgyeWtQK3hlNGtwYmI3bG5LdlhVT2xibGRheE1qY3BCYjl1?=
 =?utf-8?B?VlhuNXhIQzBZUDQ3VWJpajJhWHU0WFh6SlJING4zMSsxa0hhVkxIMGMrZEd5?=
 =?utf-8?B?eGViNFVmaDIyTGpFT0hESm42SnY2ejBycGJBSW1kVm1ncGZyam15VkswUlpi?=
 =?utf-8?B?Qm9vaHU0dnp2eVJ6clV1cWIzVHIyYXpuQTQwWWNOb1VWdC9IaTZRUERiNS9K?=
 =?utf-8?B?TTVqYUNRbnVZY293OSs2V0dROU54ZHVlMW9oRzRjaEZRN2tmUXVTL1VqWDBT?=
 =?utf-8?B?R283NGhvb0twYXF1bFVxODRjNEs1NXZTSkJxQWFlYmdhWXJRa1hVTGxlZElO?=
 =?utf-8?B?ektxdnNoNlZvV1JTRzhwZ1JNc1hFR0p3cTZKQ3hwTjBhZUh4TFFGOXF6SGlh?=
 =?utf-8?B?cXptN2ZQOXoyMGJ5RGhnZXVYVnF2aGIyMVJqa1UzaGlEN3V3L3pZVjk4RnUz?=
 =?utf-8?B?VDNhVkNoT0t1TTVqSDE2SXM2WGxzQkQ2VWI2SmQ3STFDUlNSMDYwdWtuL2xV?=
 =?utf-8?B?OEQvT1NQSjRJVmRCT0Y1WnRRdnMzYWRBNGcyUWluSjRRR2poVzQwQldQRmZC?=
 =?utf-8?B?QTVXUHphQmJQQldOcVNzNS9HN0JyamcyQW5oejBpdXhkQlZKQXhONFJxU1dH?=
 =?utf-8?B?L2MyaGl2TFpuRXVUSjBvYmFSajcvVkhGVEhJQ1U4SnJXcWFCak1FQVBzZ2Zh?=
 =?utf-8?B?NzM1Rmk4dGJTQ2NNSS9Jb21oU3NWR0Z3SUxtYVNRT1lzTmtwY1MzOFdUK25I?=
 =?utf-8?B?Kyt1ZUlBK2xZdk90VlgraldPbWZQMEtQZWJSeWhLTXF3RER4ZUZ2dzNSNGdU?=
 =?utf-8?B?UEpXcks1ajlLYUdqY0dLWXNReVIxK1czV2ZuaWF2Y2xZS0RpVzN5ZytSR3Ew?=
 =?utf-8?B?L01DMFF0NUs1Q003WXVlb0ppbUtiTEN0T2pEVS9sMU82M3NJRlV3L3AvUTI4?=
 =?utf-8?B?S1FkcHp1UjMwblVOQ1BZdFBtZXBCSTNWUXlXUXNQaGRoOWZ1SHNtTWVZTTNH?=
 =?utf-8?B?N1VydVNWdXMvZEs3N3puQmxlbURLT3F0azVzQTE2YjI1b1RQb3JocWFLbzlV?=
 =?utf-8?B?U2NMZ0g0S1hKdjBpS1hVT3p4dkV5dzM1YXFjdUF3ZlpoaHpWc1M3ak5OMHpQ?=
 =?utf-8?B?YTlzZk9TbnA3VmlrUnZ2bW5kSGVJVFlkanZ6dXN5bmN0aDBOSUlaZHZTSURk?=
 =?utf-8?B?Z0NjeE1BWi9TREJnUTRBUEtYYTVoUTdYZkdDZ2sxc01TV3lzTjJidG4veFlv?=
 =?utf-8?B?WUp1akNjd05ORzRiQTVRQnBsV2doRVRKNGNxcHZ2Wm13ekRpSTBwblRlVGVm?=
 =?utf-8?B?YkxkK0pvbnlSNmRlNDdKTGhqTzJBNDdyQzAxUFJscktubEx5UTJGbEROWDdv?=
 =?utf-8?B?MnlYTWVSaTVhQVdzd0w1eTJ1aU1taVlrblUwRENQWW5wd05JRFZQYkdFM2JN?=
 =?utf-8?B?WXJhV3VUN1dOQnhqZ1hwb3lwS3BwdGNKaFo3RnM5aXlVWW5mTWxzTjI3WmZo?=
 =?utf-8?B?U1RmR2ZLc3o2NVdUdEh0MkpjaWNrcVBVeWx1TVlBeXM5OWU3U3YwOVA3dG9V?=
 =?utf-8?B?S3lsN3Y5Yi9kV0xiV1lvTlVkenpZZ3BCQUlUZk9YVnJtdmt3bFBVd1hQb0V0?=
 =?utf-8?B?WHMrbEFIUWd2eVBFdE4zVzdhZDg3Z0pzUGFYMEV5UCtzb0laUkNIK1JJcklB?=
 =?utf-8?B?WGpXSm9wNXgvN3kwenY0b056SmVhTFBkdUYxSk9QdWpoNzRaTkxsYmhYSFhH?=
 =?utf-8?B?MklnQkwybkF0a2x1YkZLMUpZODBPQThuYVRUUWd5cDJhUGwrWUMwbXNXU0dr?=
 =?utf-8?B?RGp2ZmxpRjBRby8rMFpPWlhYaDRKTWQycEpzcWd1NUdHSXNJVUxYK3FNY1Rp?=
 =?utf-8?B?OVF2L0psWXh2UHdJWDNGS0hrV0p5OTh2N2hGRis4YUxjNzR4Znc5MWVuYWs4?=
 =?utf-8?B?eEpnMjY0TkYxZk5TWVJvUUExNXljc3kyV3NUV3J1RlB0M1V3V1NFTVhUWisz?=
 =?utf-8?B?YXFLSHQ1dXIvMUtJaDFxZmxCMlpybTRuNkV1TWR2MWhlM05FUmxudDlKYzRi?=
 =?utf-8?B?aUlCa3lZc1hjNVM1UmRQY2paYkdSYTk3REhiNzAwcFkzV2RqWitUemZKUWJZ?=
 =?utf-8?Q?BXVrkmkZbO50RF83jzbPeiev2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc030ab6-bfab-456e-60fc-08dc972aa926
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 04:27:46.3715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9LLwHGY+9EojDw+MF1iK563Ehyj/KoC1HawKXnr1ZyGtf2l4jjieflXVTqmT7U+As4kMuX8QvsDr13fCm9G+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7981

Hello Boris,

On 6/24/2024 10:59 PM, Borislav Petkov wrote:
> On Mon, Jun 24, 2024 at 03:57:34PM -0500, Kalra, Ashish wrote:
>> ...  Hence, added simple static functions make_pte_private() and
>> set_pte_enc() to make use of the more optimized snp_set_memory_private() to
>> use the GHCB instead of the MSR protocol. Additionally, make_pte_private()
>> adds check for GHCB addresses during unshare_all_memory() loop.
> IOW, what you're saying is: "Boris, what you're asking can't be done."
>
> Well, what *you're* asking - for me to maintain crap - can't be done either.
> So this will stay where it is.
>
> Unless you make a genuine effort and refactor the code...

There is an issue with calling __set_clr_pte_enc() here for the _bss_decrypted section being made private again,

when calling __set_clr_pte_enc() on _bss_decrypted section pages, clflush_cache_range() will fail as __va()

on this physical range fails as the bss_decrypted section pages are not in kernel direct map.

Hence, clflush_cache_range() in __set_clr_pte_enc() causes an implicit page state change which is not resolved as below and causes fatal guest exit :

qemu-system-x86_64: warning: memory fault: GPA 0x4000000 size 0x1000 flags 0x8 kvm_convert_memory start 0x4000000 size 0x1000 shared_to_private

...

KVM: unknown exit reason 24 EAX=00000000 EBX=00000000 ECX=00000000 EDX=00000000 ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000 EIP=00000000 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0

...

This is the reason why i had to pass the vaddr to set_pte_enc(), added here for kexec code, so that i can use it for clflush_cache_range().

So for specific cases such as this, where we can't call __set_clr_pte_enc() on _bss_decrypted section, we probably need a separate set_pte_enc().

Thanks, Ashish


