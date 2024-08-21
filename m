Return-Path: <linux-kernel+bounces-296159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E15F95A664
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB64C1C21E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD21170A3F;
	Wed, 21 Aug 2024 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jDWt+Qvb"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FF813A3E8;
	Wed, 21 Aug 2024 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275094; cv=fail; b=rTzOaj3P3M4BsvomO+tnqjI7iBuUaR3e139E28Cvq25hdT8OJJRJHTmHe6LJFdAKMJL09R/afuM/vJWCkD+BlubAf9MRNf6H8MDQYSWO9KJZ2rBcMWOIfjfCbH5/1etP9k1EQS9oqtqUPo0mVzCRcf1MnYLF3Mgn+WllgogUsUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275094; c=relaxed/simple;
	bh=K835O6cIJPPwbaho2CY8o/u5p60wE+V+/8dKhYROfiQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KYbK0/dVZ+NlbxvyIyaP2jVbJNW1NjUwmxrzRL/kDf0QON65ViDTRjVRn35K5GFI5wlhQqp+o/1Vweou+h30ZMMpF94yiQI6FIAsPGeBAVT5uGnNdPsAo5aaABjdEZ8nG/B/xHjD33e2iTc1vZFI18foy6y1mE5LZYMR6mVwsZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jDWt+Qvb; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGuC1JfeeKa6Mpx0NZUO/Jcrz17iM0bKDZMJRrsREgAF4oLSI9AEh0jNcWi6Z6jxvMHfHlvLzRFNK8bH4dWcOAqx8rFsVZmuAGYvKYonADb7ZMV2w5nU8FJkAgRSGGIfIY8HWnu6jab6ulkuNPxFebeETAnX1pHVjl0kBoajuf1CqE6bLFLPjWbMRTGOVTuhm8AuKtbeyyNAxBdnmp0GlmCpNBo1mzLd4KggHxUGFifkDS4sXWK1UnwjpS2xGZ94vf46o5ns0u3+Ts1I/n0f0t1fizbRqv+0nTCYsDzJKVuKILlEBTIadsrLldPmj7hOMRCjfPcQYcFlrgEXB1M5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkqmNtc43V/j5UaGJNfTKuC9gVON0XiNGqlO76zI8Yc=;
 b=Ua1mph3xRun9186JtZwCIDNuvmCBehe0s+UUuW3aPXfBMnWblQ6gZ5KpYKgsMk7dM9x7EQ1gowudALB7IvT5rASaGV1vWag6QRm8mVuW3P9/8DdFPuf8TaEPEPe8ZgM9070oHmqM8psW11i2XVDbHnuS+3cEAYQtHri1htDxurJc4xm6sU5UCz/T+jsaGgISFvQMXhPrZ+RPdhL2vPTJ53Tx4ScwdDfZADri/QdyETqiLe/CFad4HIj/4AKSnutycVGaKNEDEV2DQgQHC7kxtDLh2BY+bISaMCBAhY4KfGD4SGQzEbiKtMATcNJXPsNpYkOdRegRbj4U1Kr43x8sQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkqmNtc43V/j5UaGJNfTKuC9gVON0XiNGqlO76zI8Yc=;
 b=jDWt+QvbaN8pWhUkhehOsGHGGiNoXu07vP3jOdoOQK6O/EhBHz7p2urwMWQotJJjUwkOACe9WcEvbLmvNSjVPfnEoz/qWHGVAU5xCOzezWP64meALrXfevx3u0vX7Qw9IkXxLA1ekfLV+D5zJ5H2QmfsQU6MK3heDWPzkEC8sfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6613.namprd12.prod.outlook.com (2603:10b6:8:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 21:18:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Wed, 21 Aug 2024
 21:18:07 +0000
Message-ID: <4233a036-bef7-4873-bd3d-9b3ce22b8b26@amd.com>
Date: Wed, 21 Aug 2024 16:18:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] platform/x86: asus-bioscfg: add dgpu tgp control
To: "Luke D. Jones" <luke@ljones.dev>, platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
References: <20240716051612.64842-1-luke@ljones.dev>
 <20240716051612.64842-3-luke@ljones.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240716051612.64842-3-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0005.prod.exchangelabs.com (2603:10b6:805:b6::18)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: d26e9f6c-028a-4cfe-3e8c-08dcc226c020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2dtZWJ2ZXpsUnh0QVpjaFQyYlpYOVpwQ0tieVo2NVJHNllvQVYwblduUC9r?=
 =?utf-8?B?RGJvdjM2OTVKSjRDVXV2THQrSU5ydWo3c2x5OHhCTWVrazRQeFJCekFzMjJN?=
 =?utf-8?B?K2V4dDIydkYwcnp1ZXBRSzJxa0pHdldmbXRPb1oxNFFJbW00b3JObDdnbDlL?=
 =?utf-8?B?emMyL1dkV1cra1ZmUnR0MzhQR3Y5WnVPMTdaNk5RWEdxKzJ1V0VCYjBFUzlP?=
 =?utf-8?B?eStoaWtvM2haWmZEdTZIbEdETzZ4MEdLa0hCYW9tZE9sWjdJZ3NIUTNobzM4?=
 =?utf-8?B?YVdDaEdweGxNVkRXaForb1lTUnRLamVsNUZtdU0rdG0ySEp2MUlWczJxZ0pR?=
 =?utf-8?B?aFRrdUdXdVg0SFJBbzdOYkd2OG05SUphUlBMY3ZlSmVtMmV6aFNId3dlYW5T?=
 =?utf-8?B?OG1GVllQMDRTQS9NbmNnekErV3JZQlR1cllKUWFlODdhR3FrSkdXTUFUY3Y3?=
 =?utf-8?B?YXE2Lzh1SWVCejQ4ZUhpV2xHUGVJcGZEZC9wUG1hNnZMWmZvS3A4clBRVlZH?=
 =?utf-8?B?YkVkMFVQT0hjclVkaDVGeU01RVZ6VlBvQmNHSWVLTmp6S0NEV3R5NXNhT1B0?=
 =?utf-8?B?VHhaSmk1SUlHZTY0RHY0REJxUnl1U1hiOG9yRjQvK3NlTElIQ1l1R2NHZ0hi?=
 =?utf-8?B?VjB2eSsvemc1SUdYcHVabHFCd3M1dkIzdC94ZytmcnM1enRaQjBCc1ozTzA0?=
 =?utf-8?B?M2Y4UFdsdEFjMVhhSHFHcUFhU0trZlZ6QWhRbmYrUnlDSnFWYVhlWE1RR0Mr?=
 =?utf-8?B?QU1nYjN2SE0vNUFwV1o2clFjMEVTRVJkdDBzaFN6TDlPMVFXQXpmbXd6dFhP?=
 =?utf-8?B?TUR6UjdhZjVHQmF3UzY1QUkreVYybVc4aXYxVjBZOGV3Skc0SS9SU3NkdzRL?=
 =?utf-8?B?WHFTTGNuQTJ6WVdKNHJORFI4d25JSFpMNmRiVDUyd1NGb2trZkZIanVUY0dY?=
 =?utf-8?B?d2ZENGd4MHUvamZRUzBZVGVWUjNvVnRzVU1IOEZ4Vk5DRUowd0dtdHRNaDB5?=
 =?utf-8?B?R0RWVnM4a1ZVS1dnMFBiNW5JSis5N2hGTWVOVktncUs1REd5emFKZnh0WGJs?=
 =?utf-8?B?UUJnZ3B5NFdqY1poUGFRNVp3b2ZvZDgvQmlGM0RhSVBVOGxVRGNsU01QdjJz?=
 =?utf-8?B?QTBUcjMwSE9uL2Q4UHZYYW5tNVVGTmlRbkNHUW5EVWV2OFcxSnMyYnRwcis0?=
 =?utf-8?B?WWFyZ3NJNFNxL2JCaDVBSmRqYnNyd2JBakVQWXUySzNUZTNwb1hIRUZyTWRi?=
 =?utf-8?B?Y2NqSllHMDhRcjFMNGsyMWx0Q3RTNlMrNkwzbDR3OExoVTNuRllJaWRreTBJ?=
 =?utf-8?B?MHRKZEEzMTNJZHRRMDNuRXBXUWo3NHZ5NE84bTVmN2xsSGcyRC9UNkxlVWNj?=
 =?utf-8?B?bHRaVnVOSHRHeDg3amNCUVVkUTFFa3lRZkc5b1BQZzA1WklBOFY3eEU3cU85?=
 =?utf-8?B?RERuVnFudFdCWjZtTjhuZ01UdGVTMWhFbXIxWSswQ3F6VUhDK1R0VDJ6dExJ?=
 =?utf-8?B?S0J3Um5aQ0VERWRxZ2VvSGFIQStXcWtiSDg1TnJwRWpXYmFvRXVrZDJiTTN4?=
 =?utf-8?B?US8xQ2sraUR3aGM4alVUMjNsZlNCbFJUL21MbmxENGl5QmVlVDg5K3QzSktF?=
 =?utf-8?B?SUI0emRKUk91a3BKRG1aaTN6SUs1Z1Bkaldsd2pTRzZXelJzY0lDYzdZY0tC?=
 =?utf-8?B?WFRvQmNtL1FSaWVodXQ2dStDRWl6MXpieW40dm9nM3had01Ea1dBbml3U3hy?=
 =?utf-8?B?NlY4TGR1V01hUUxaWlhJUUxKMUhjTnAwbFByZ3BjWVdicXRXRDFPUDAzTU8z?=
 =?utf-8?B?SkhlSVRGNnFJK053dTVldz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aStZNjJGTjZ3cFBONFZhN2szR1d2aUFSb0lDNytiNXFibDY5UUZXR3huVXFC?=
 =?utf-8?B?aGp0K0JXeXpDQ3VldG82aURZM2ZWTE5NUWxVT3lYVkE1OCt4eW43MHVrZ3pV?=
 =?utf-8?B?MjdIWjBpNkdWcFI1UTR4MWVkZEsrekhObnFMV1RoamN3STR1Q1VyMG5QUUhL?=
 =?utf-8?B?U3VhYzE3OUlYMHF6cS9MaW1YODd0NmNRZCtuN2o0VGgxSDdTQ2NVOGZPYkdW?=
 =?utf-8?B?TGNPbUpkMVdTQkZ6RjlRTE5rajE4SHlTandhZnM1WlV0bit1QXV4M3lmQ0NY?=
 =?utf-8?B?M3NMa0JkVGpDZnlGbEhrY0RYRUhSQ3p5dGUzbDA1ZkFVdDJFRk01Y3pwM1Vs?=
 =?utf-8?B?Q1BmRWZXdElMTU5mbVZUbUxQbWU0cEdWUjFMRU5TRVNETkVrNWNQeDdWQm1F?=
 =?utf-8?B?RTJ1WVB3WmgzVmQ0Sk94WkhzRHFUSHJaY0pKbE5VcHJmZktsaXFSSU9IOWln?=
 =?utf-8?B?SVBKVi9rYmhXWkdYTEs5UGVXeVFLYWEreW9JZWh6Q00rNERXcytUcElub1ZD?=
 =?utf-8?B?SWptWUY2UUZ6YTdLalo1ZDBnUFZqWHA4K2xwQ3NDa05VOE01ZjQ3K2xncVNQ?=
 =?utf-8?B?MkxubzlPTnRNaXlXNzVQRFhCQVh3Sm9nVjY1QW55SjlGVGQ0K3FvYTFhSGNG?=
 =?utf-8?B?cVlDZU8rbHFmeUdybUQrdWxXQkJmalJadTVjVGtua1dOT1dCc01Yd3lzVXA3?=
 =?utf-8?B?ZjIzVmJCb0dEbHMwM2lFSW9QM1grQmxFZ3lhVGJBK2tNZTgwZnBSL0V0a3RE?=
 =?utf-8?B?NXNSbGM0MUNMREsrM1k3TnE5Q3FkTGxqR2JkWGN6bWJEa010Z1l1V1phMXQv?=
 =?utf-8?B?bW0zMVNpWTF0OXpiandOSGZiS2JkN3BqWEZzeWlweUpZcGJ1NjRGQ3RZQk5R?=
 =?utf-8?B?bVpGVGs3bkZxYVVoNmIxcVJtL0hTL3ozYmdpcUV3dTJTWXlNRU55Y0Qzanhu?=
 =?utf-8?B?cWdOYytsOFV2MEFLSTRaUS94QlQ4SkZqQWFIRXJ2bjcwMUwwclJ4V1B0R0lq?=
 =?utf-8?B?UE9kWTlYeTFTWVBjcjM1QjVuM3ZtcVZlZzZHbDVHTTZUWUZpRnlmYkt2VTJz?=
 =?utf-8?B?YWUzLzU2VEJZTnBkTUN4TjIzMDBXa3hZOWN4R2FNMjJuaStVVlVFTHBuTHFk?=
 =?utf-8?B?Qm9VZjRJRUxCdmMxZEhFQVJFdjUxQ2tzY0Vnc3M3amNRSmtCL0pDYVhGYXdP?=
 =?utf-8?B?dW02QXRQeWtLV1kyU1Bnb3N2aURBRm1DbXI1WnVISmIwOVd3eXVBZkZHNW1Z?=
 =?utf-8?B?UENXWHJvQUVQN01wOUNnSnBpWnUwanFZN2J3UU5GdHFwQlRDT0JSckw4ZktP?=
 =?utf-8?B?bVJLQWRDTytRMWdpTk90ZlVZTnZCd05wcjJoVTROSDdib0J4ZWtPbUhNb0Vz?=
 =?utf-8?B?SThGamE0NnpNTFJ3eFN1MHhiSmdGQ2pJNjFjbDJONW1ReHR3eU1iTjBtVStj?=
 =?utf-8?B?WVZxZWh5UG9ncVE1dlpWdytyUVdMSE4zMmhwWmptNk5YT3QrSWF1SGtWNm5U?=
 =?utf-8?B?akJKWjc1Ums1OStYM2JFUi9oU0ZaT21mTjlCWDArWVF3QmYvQ3pJRjlxMGpX?=
 =?utf-8?B?TGhmdjBVMUhRRWV3RWZCYzFybWQ3bTZmNVMzU1p1N2FpVE1PU0JSUldwZDhE?=
 =?utf-8?B?eTRBV1prazRNdS9Da0g5VmxqN3JacWQydGd0SFNNNndlRzk0cWgrUHpkWXMz?=
 =?utf-8?B?ZE1jZmdqdVp1emtDQUJvdEZBMHRkRmZVYlNIU09VbVdHclFKbGx4TXUwQ0Ra?=
 =?utf-8?B?MlRHOGhVNWFmd1ZzT3lybWI1RmVaR0RYSWVCbHJuL1hHN2pGUHZjQUFqQjRz?=
 =?utf-8?B?REcydHUraURzWDBzTkRXOVZlbHQyRjg3WkpEQmdJS25XbHFMMTFQNG42WHJs?=
 =?utf-8?B?SnpPbXFFQUN3eVRycnJpeTJhZXJIOXp6bEtIdXJKb0l4T3Z3YlQ1R1J3OXAv?=
 =?utf-8?B?SUhyWG5VVGFESzhIbzFIMzd3RnVvTjJoSW5EM3I3U2pTTHpwcHkveElhdTJW?=
 =?utf-8?B?bTJ6cGtZaytkVWFzSVFDUWthNEJFTkNHUHB0UzBaL25oVm12djhEREdqckw4?=
 =?utf-8?B?K2R2RjJuTWRYdWZ6djY0YVc1NEs4TjY4elZQZU1HRStHQTkrYmZoaklWSUNh?=
 =?utf-8?Q?Ij/wl6fSUsGWse2nj6JDxlp1Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26e9f6c-028a-4cfe-3e8c-08dcc226c020
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 21:18:06.9521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOyr+oA8k2VUPNTmdoT7bXVao+JXvKZT2hdDA2P473SQH6+zgIzrNSNQZwpX5cMUDm5NggvSKSs64FxpjwHHeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6613

On 7/16/2024 00:16, Luke D. Jones wrote:
> Implement the dgpu TGP control under the asus-bioscfg module using the
> fw_attributes class.

A layman will probably have no idea what a TGP is.

Can you please explain what TGP is in the commit message?

> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>   drivers/platform/x86/asus-bioscfg.c        |  9 +++++++
>   drivers/platform/x86/asus-bioscfg.h        | 30 ++++++++++++++++++++++
>   include/linux/platform_data/x86/asus-wmi.h |  3 +++
>   3 files changed, 42 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-bioscfg.c b/drivers/platform/x86/asus-bioscfg.c
> index 0b34e727aab4..551b7dbd8fe7 100644
> --- a/drivers/platform/x86/asus-bioscfg.c
> +++ b/drivers/platform/x86/asus-bioscfg.c
> @@ -52,6 +52,7 @@ MODULE_ALIAS("wmi:"ASUS_NB_WMI_EVENT_GUID);
>   #define NVIDIA_BOOST_MAX	25
>   #define NVIDIA_TEMP_MIN		75
>   #define NVIDIA_TEMP_MAX		87
> +#define NVIDIA_GPU_POWER_MAX	70
>   
>   /* Tunables provided by ASUS for gaming laptops */
>   struct rog_tunables {
> @@ -443,6 +444,10 @@ ATTR_GROUP_PPT_RW(nv_dynamic_boost, "nv_dynamic_boost", ASUS_WMI_DEVID_NV_DYN_BO
>   		nv_boost_default, 5, nv_boost_max, 1, "Set the Nvidia dynamic boost limit");
>   ATTR_GROUP_PPT_RW(nv_temp_target, "nv_temp_target", ASUS_WMI_DEVID_NV_THERM_TARGET,
>   		nv_temp_default, 75, nv_temp_max, 1, "Set the Nvidia max thermal limit");
> +ATTR_GROUP_INT_VALUE_ONLY_RO(dgpu_base_tgp, "dgpu_base_tgp", ASUS_WMI_DEVID_DGPU_BASE_TGP,
> +		"Read the base TGP value")
> +ATTR_GROUP_INT_RW(dgpu_tgp, "dgpu_tgp", ASUS_WMI_DEVID_DGPU_SET_TGP,
> +		70, 0, NVIDIA_GPU_POWER_MAX, 1, "Set the additional TGP on top of the base TGP");

  Could you expand the description for these in the next version?

>   
>   ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE,
>   		"0;1;2", "Show the current mode of charging");
> @@ -534,6 +539,10 @@ static int asus_fw_attr_add(void)
>   		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &nv_dynamic_boost_attr_group);
>   	if (asus_wmi_is_present(ASUS_WMI_DEVID_NV_THERM_TARGET))
>   		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &nv_temp_target_attr_group);
> +	if (asus_wmi_is_present(ASUS_WMI_DEVID_DGPU_BASE_TGP))
> +		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &dgpu_base_tgp_attr_group);
> +	if (asus_wmi_is_present(ASUS_WMI_DEVID_DGPU_SET_TGP))
> +		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &dgpu_tgp_attr_group);
>   
>   	if (asus_wmi_is_present(ASUS_WMI_DEVID_CHARGE_MODE))
>   		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &charge_mode_attr_group);
> diff --git a/drivers/platform/x86/asus-bioscfg.h b/drivers/platform/x86/asus-bioscfg.h
> index 403563c25f53..2da55a91ff0b 100644
> --- a/drivers/platform/x86/asus-bioscfg.h
> +++ b/drivers/platform/x86/asus-bioscfg.h
> @@ -113,6 +113,22 @@ static ssize_t _attrname##_##_prop##_show(struct kobject *kobj,	\
>   static struct kobj_attribute attr_##_attrname##_##_prop =	\
>   	__ASUS_ATTR_RO(_attrname, _prop)
>   
> +/* Requires current_value show&|store */
> +#define __ATTR_GROUP_INT_VALUE_ONLY(_attrname, _fsname, _dispname)	\
> +__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);		\
> +static struct kobj_attribute attr_##_attrname##_type =			\
> +			__ASUS_ATTR_RO_AS(type, int_type_show);		\
> +static struct attribute *_attrname##_attrs[] = {			\
> +				&attr_##_attrname##_current_value.attr,	\
> +				&attr_##_attrname##_display_name.attr,	\
> +				&attr_##_attrname##_type.attr,		\
> +				NULL					\
> +};									\
> +static const struct attribute_group _attrname##_attr_group = {		\
> +				.name = _fsname,			\
> +				.attrs = _attrname##_attrs		\
> +}
> +
>   /* Int style min/max range, base macro. Requires current_value show&|store */
>   #define __ATTR_GROUP_INT(_attrname, _fsname, _default,		\
>   				_min, _max, _incstep, _dispname)\
> @@ -156,6 +172,20 @@ static const struct attribute_group _attrname##_attr_group = {		\
>   		.attrs = _attrname##_attrs				\
>   }
>   
> +#define ATTR_GROUP_INT_VALUE_ONLY_RO(_attrname, _fsname, _wmi, _dispname)	\
> +do {										\
> +	__ATTR_CURRENT_INT_RO(_attrname, _wmi);					\
> +	__ATTR_GROUP_INT_VALUE_ONLY(_attrname, _fsname, _dispname);		\
> +} while (0)
> +
> +#define ATTR_GROUP_INT_RW(_attrname, _fsname, _wmi, _default, _min,	\
> +				_max, _incstep, _dispname)		\
> +do {									\
> +	__ATTR_CURRENT_INT_RW(_attrname, _min, _max, _wmi);		\
> +	__ATTR_GROUP_INT(_attrname, _fsname, _default, _min, _max,	\
> +				_incstep, _dispname);			\
> +} while (0)
> +
>   #define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname)	\
>   do {								\
>   	__ATTR_CURRENT_INT_RO(_attrname, _wmi);			\
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 889336a932fb..c54264653d75 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -128,6 +128,9 @@
>   /* dgpu on/off */
>   #define ASUS_WMI_DEVID_DGPU		0x00090020
>   
> +#define ASUS_WMI_DEVID_DGPU_BASE_TGP	0x00120099
> +#define ASUS_WMI_DEVID_DGPU_SET_TGP	0x00120098
> +
>   /* gpu mux switch, 0 = dGPU, 1 = Optimus */
>   #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
>   #define ASUS_WMI_DEVID_GPU_MUX_VIVO	0x00090026


