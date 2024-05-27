Return-Path: <linux-kernel+bounces-190406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5D28CFDE7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FF2282E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E40513AA5A;
	Mon, 27 May 2024 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lyzL1VWy"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E73DF60
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804731; cv=fail; b=NN6s2kBT+Lihn5js0TrBs2gskjaGnoONiDdNMk8JGawxXBSupiLshshMfDvDlYHfPgOYNmJtYYn+e+XW86CzqwuPTxovgq4baJ/kyYSluZJXQlGAZbMFDXzBfh4dB79iTCv5zuXFgxrMNlGh5MeeG9uIdNeKgeoGb/6ER5DepVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804731; c=relaxed/simple;
	bh=b5Z+67XPWstl+MRBZcfbp2+kP3zXpX82i0kPnX95F70=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xj9C0L21i+JZSKggLqMyUY92a7oIr8s6nWfJ8EvA1Lhr1blwH6pUNo6mSYJXMr7qP6ts5CgDIpmlcMsQJOYg0N3cOSKg7rUht9njAXR4gmgxrasxLYMoIPeq4Rvdp9DhtcweHvKQLGRMMRxG3jkHrRzvVNkuitP09cnDCxOKmU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lyzL1VWy; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw6K6VEZkU0fgsHe5qb7fFLqkdhXVGkwC6x10qM91H2FDsYkHOHa7KqZv2vzAiPaOzOtkbRqD15bxF4AivtpJfAiCwrExJLVUEp124EuPMUOHD+N7bcpoJqHQCYFqS9tGOOQ7csaxl044/1mB72ep5hi/1GtZLt6FQbpNaCnWkr/uBLciM1xZM+jqz4E57SBc4akbufkGfIeciWvgAzhroNvMPwEYdu4q8QT9Us4ufhRLd3JksLxlUyiwe2PkOw6rn5vfUpr/GDNc0YLP4tLsOb7WS0kpW3AJWimBqqjk9Rfb54WInKNhDbs/q0baeiB2OgQlhEE2Yj7BVwnQ5HTUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PuGY8GfYzbpf7DGLzgYNvQNI54spobsGcCaxgpY9zg=;
 b=UXV+D4iB51WRO4z3+JTjdf0CiOOl0yPHiENrEniXfYw9ZQ4jh12sV/8LbzvvZ4zO1pFVaaA8cZjcL36RJ7poxz92G2P88bryaUeXhCXL4Q6bkCWLdu6ltcJKtpXtPYRxsoDjx/RUB7WKeYHXy5dEhdhwC3vPsCTtTHTly740PBV4jP27tdQ+hgx/qBfF7x8MdrQSBMWEEz9dAPoLBeoe9o8yMTCwuVewhz+tpLhU7xbikAN8S2YS9gyRtO3Aj9BhqHe3mBnGI2vRPxW2uRsntg5fCuF++zmeTaJVymlWuKHvtqTxyzalv+5lJOVUnmJnW2ReDz5QCcqxXC2sePLgug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PuGY8GfYzbpf7DGLzgYNvQNI54spobsGcCaxgpY9zg=;
 b=lyzL1VWyuSPHxP7jXNjNRanIUJUT2g2AmAzkHVaqimVedGKgXAy6FHV77lHcbOrTGTd6ZCtySC5RjxJukFGgvQ19J53Uza6qciruZkDqAfp0Ud8w5TemuL7yYqd8WS5b42Nq/OX1r28ebkyuE2gx3b2dhy425QRh/fKcrA3Q6VE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Mon, 27 May 2024 10:12:04 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::dc81:c7b9:7aec:68cb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::dc81:c7b9:7aec:68cb%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 10:12:04 +0000
Message-ID: <5bb5f183-cac5-a8de-d1fb-1562bed4f9aa@amd.com>
Date: Mon, 27 May 2024 15:41:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC][PATCH 00/10] sched/fair: Complete EEVDF
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc: wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de,
 Yan-Jie Wang <yanjiewtw@gmail.com>, Luis Machado <luis.machado@arm.com>,
 Gautham Shenoy <gautham.shenoy@amd.com>
References: <20240405102754.435410987@infradead.org>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240405102754.435410987@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0129.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::14) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b7b649-88e3-426b-8028-08dc7e357511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|7416005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnNibWRwY2NTV0ZBMzFKU3ltTWQ0RlE1cU1ab2RPY3J1RndLVS9TbDdtVFN1?=
 =?utf-8?B?NFd5ZWZzbmFQLzdWS3N3cjhzUGlBMytiY0FPRHpLQ1ZHcWppODVwQWN5bDNr?=
 =?utf-8?B?eStlWkkrckVsRW1jSXUrZTllM0d1TXhJc0pDSGlkODdnWXFpMmhZdE56SmFy?=
 =?utf-8?B?YVBUQStQZFZKRThNRFJhdGVCOWErcUNMUzhCVzhxSjNqeUQwSmEzYjh4dk93?=
 =?utf-8?B?WE5CWDJmcUNleCtrQlVSaWZ3TWQxOVFBTXFmT3lpelc0NGZldFliQnI1c2U3?=
 =?utf-8?B?M0RPemEwR0FReVIyRVhRSnV1SnlLMDhBeWpsaGRrdGZNc2k1YWpnajFiVjJm?=
 =?utf-8?B?YVJyREF4SWNwcUN2b2hDUnlLOXp1RHFKNGU4aXIxRU5OSENsMmVWcFNrU1JB?=
 =?utf-8?B?RkFpK0xiUDFPZVNlVkd0TGQ0UnFQN0V0QitpWkVLcEVMNFpUNkZFQ2JCa1Yx?=
 =?utf-8?B?K0llYTIzUEhxdXZBV05UL1FCQ0krZGJrcjVYU2d2c08wc2xRUDdkWmdQbEli?=
 =?utf-8?B?VEZtMEpKS2c5Q0V1V2p2RU8vbVNjdklGQWNVSWFDWEF6KzVza1o1Q1QwUXFU?=
 =?utf-8?B?ZEkydVFhQmZVdWhVU0lobmZQUlRzam0xZ1c3ZE5ocGU1YmhNNlhTTG5NZkJM?=
 =?utf-8?B?bDVPRDdMQ0I2YmpZbU9URFIzMlV3bUxvaFIydmJDdlZVcUkrTG0wL1BVdFd5?=
 =?utf-8?B?a0NzZEgxMVJXZHlxR3A4WU5sNzVCcWp1M0lxSk8zY09uZWVQdVUvTkU3MVpC?=
 =?utf-8?B?eDg5Tm9IT2lqYXQxL1ludng5TXovNG9sbU1TYUthRVVrdmtGdC96enA2ZUoy?=
 =?utf-8?B?Lzh6b2FWUnVLc2xLZWthTkg5akE3L1FTM1Y1aXpvSW5zMDlScEtWUkgweXF4?=
 =?utf-8?B?dHhHeG1VdmdySE9lUG5mc0tka0hqdHdRdmZ6MVp2OFFkaEZIZURSclErZ3FP?=
 =?utf-8?B?UVZmSzBDTXVMZ25WNFJvY0p4ekNDaER1czZkYWNWVmUyTW9LVmxuT2tVRkJr?=
 =?utf-8?B?SGJ6cE1zNnd4VGNlbnByd0VtOG5sQ0hvQnVYYnI0WEdqcUNsK1BJc2VCb09x?=
 =?utf-8?B?b1hzY2wxaE81RFRVZ3FYTHZya3NSck9FQTYzN1BxRlBMdndUd3lrM2grcnll?=
 =?utf-8?B?Qjh1cUlCOWtSM0Z5S2xFcllqZGR1STNNN0FMNEQ5YUhPZm1yb3VLN0M4VkYy?=
 =?utf-8?B?QnltZjlDUThrUUVqWXBzZHVvMDdQUVRZNEFxSXlIWXlvMHBWZk1OWlg4ckMy?=
 =?utf-8?B?YmtIL3ZLdFFSVmRSbGN6bmUyWEFsTUV2UWVHQmNhZmdUVDVxejMwUDFXNlFY?=
 =?utf-8?B?TW5NbnlVbWI2WVVoT0ZpOUE2TlZYZmJaK05QcDJZNTJwRWxGZ0c1dDd6OWJD?=
 =?utf-8?B?czJRSjlFT0pqTXVzMUlaMVBxK2xpY2UyZTMvaWQvZVdhNHFDQ3MrTTBmeGc2?=
 =?utf-8?B?NTYyWnJtalhFTWQ1TzNQN0JrNXFLMjFyeXBpRUZLMmR3dmpBL2pRN0NTSEVj?=
 =?utf-8?B?WFZKR2dnVXFRbHZvTEhqRzQwa1NHK0dxcVVNdHR2ZEJvNVNnei9YTld1Zmxz?=
 =?utf-8?B?bHNVUFBZa1FQSmorYVEvbTBVakNNSGgyTTM1S0NNR3FQbHM1UWJTRTNReC9D?=
 =?utf-8?B?ck9ha2ZDVmx6NzVFaEVIU3VuRDZwcUR4a1dYdG5zblFHZDgvL2I3M3k1NTVC?=
 =?utf-8?B?OCtZQ2hLMmFtdDhlZDYrWnZ4N254Nk1KRGhKUUUzZEFDMG1EMDJUTGR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZExTOXBYeHAxNk9YZDBTTGNZN1l1TFdsODhGSXFKU2wvQVJrb3YvT0s1YzRI?=
 =?utf-8?B?YkRhUzd4Q2toSlJ6bG9lVGpiaW92WHZwaGVqY21VaDkycyt3b3luUzlvZzEx?=
 =?utf-8?B?a2JIT2RzMmhCSldKak5oUTNIRTVmTkFJeU5vdnlaTWlWcGwrc2tIdjcxTGp1?=
 =?utf-8?B?T3FMYUtKc2ZsWFYzZ0Vsbk4yUDFXS3Ztb1dhSWQ2eXhwUTJOc0dLcjExbmRH?=
 =?utf-8?B?blFiN0NhaEs4dEdvYTFvR1JEd1piZk11YWVSdHZhMFcwNzJ6YWRMWTVkMDU4?=
 =?utf-8?B?TjVIdFdRb3NSTjRSRFl0UElvSU4wSnVmNVJ5RUtLcFZURU5qNmxZTXh5dzEv?=
 =?utf-8?B?RGo1Q1F3YXVTKzMyemhUSnhuanIzcHZXOUpnY0ZQaGp6VVVMN2w4cWhnQlp1?=
 =?utf-8?B?SDIraTUvVlA2VnRBVWovakNxbnhXdzA2a29ORGZCKzJ0a2ZRRmlyeURpT29s?=
 =?utf-8?B?clk5TkVkUys4M2FldlkvYVBIaE5VQ2d5MmpkMWUwdEtRQkRUcHkyL2JYUzYr?=
 =?utf-8?B?bzRrUWYxb0lTVWFlZ0UzZnloT2wzb01FbWNDNVlNZmhicTBpYmpOOFJWRkdH?=
 =?utf-8?B?UDBHNDBmdkQrTS9hdXdJdHI5ZmZ3a21NSUZEMmg2SmhibUQ4R3BwUXMxNUMw?=
 =?utf-8?B?NXRzdU1mUHc1N1VqaURyS1RCNWpUS0RBVWJCNUFOWkgzRkwwT2RxZkI1bUhm?=
 =?utf-8?B?QUFOQzUxcm1MMEF5QW1KMGRBbXBMMERCQjRiVVpORS94OFFCelN1TXNNR05Z?=
 =?utf-8?B?dFNzVkoyMnVXWkpLR0V4SjBaTmNzY2krZERpQy9ET29TK1dDNGNPbmxCWWRI?=
 =?utf-8?B?eFo1UGp1U1JSVktWcXVDVHVNcFlZWHVQSlFkWTJJQ0x0Sm1hQmEvVXR1elBh?=
 =?utf-8?B?QzdTd0xPTWxRYUI1MVF4Wk5qWEswdUhUWGFkTkRRU3dxRHIzclpGUXNwN3or?=
 =?utf-8?B?bm11ZFYzVlBiM2ZxVy9OZVprR2N3K21MZ2R2b1hCMHVCUmVBYXp6VHNzdEhy?=
 =?utf-8?B?K1VqbSswT0grMkZKd1ZZNjRWSmhkdlRha2tBR0Znclp6cVl3VEJXYXgzbEsx?=
 =?utf-8?B?Z2RHclErTCt6RGI4WWdXSmp3SzIzbmkxanJGMWdJZHd3YTMzL2xEaWdBRHJX?=
 =?utf-8?B?VmtNemdFTnk2S1lEWjBWZlhNQVRhdk5seXA3dmNNSzN1YUFvaGhsMVV3eHhs?=
 =?utf-8?B?VWFWclZJdllKUWM2QVl0alRhR1U0TUhNR1pOalBGaEFBNWQzby82MzR4TDdQ?=
 =?utf-8?B?MEtaN1NncjlRRlNTcjFqSTRuY1IxQXpDY2d4WjFiUzdGaVpUSWtNYm43RlFM?=
 =?utf-8?B?NTRyK3dZMzBRSUt5a080MDVDdjVPZkNqYjFhZk5HdmVPRlRUdUp2aFIzTm5o?=
 =?utf-8?B?aGVHV3RXYUI4M2dWNlRwdUovNDRlNmF4Q2czeHZHc1U4Rk5iOVFQTCtsOXdO?=
 =?utf-8?B?QjFkL1pFZGhtRm9GK0FnQVlhN1Z1bFYzeHhLTjhBU2tEL3NCb0JycUJPVU81?=
 =?utf-8?B?VHY5UDBwTThzeE44TWIxZFp0aVE0c2lqT1ZGT0dEL2p1aHlTNjZlWEpob0x4?=
 =?utf-8?B?anFtRGtoMTZ3SzNnUkZjeEYrQ2tjRTZJUzRXek1uYVN2cnlOMy9jOU45bTNl?=
 =?utf-8?B?dDNsTjdMTVNTM1p2YnVGVXc2Z3JZZk5xcHRGbWtuc2RTYWVxdnZZWnZxazNO?=
 =?utf-8?B?c3NzcERia1dVTXNibmgrQXh4d0FJR0dKVldJQnI5bUxCZUcyVWQzODBxczZM?=
 =?utf-8?B?SlBZRkxGY28yOEg2NjJoVnhxWXhZU0g3blhOaFBaSisvN3lSa3BJc24zVDg5?=
 =?utf-8?B?YlJoZFlJcktxU3dQQlYzWGdyRUVqZDdBSFNrbXJzTnByaDdFSExTdUlFbEYx?=
 =?utf-8?B?UHcrUHVLakFrMEhNRFp5ZzVKS094SjhwUTRxRm1oaHBJY2UySzNZZmwraWMx?=
 =?utf-8?B?MVVMaGdGUUxOMlJUOTRuOHFRQ0E5UDJ1dzY0SUViKzRpK0pZaTNXS0MvNzNl?=
 =?utf-8?B?MldvWUhYSEVqV3Iya0NJb3gyMzJKcmNQdTFSVXFTODJVTzFiVXRjK2NvYTRZ?=
 =?utf-8?B?ZUllYW9ySWpzZGlDWjUxWXkwQXczSlI3MkdvR3l6VDBOeE13VUZPbVpBVFZV?=
 =?utf-8?Q?PV3rx2ZgZm3E/3GxfjJzHT+DB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b7b649-88e3-426b-8028-08dc7e357511
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 10:12:04.6054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVZjstRdgQLH+JK2WOTNyorIMgudn6xaQQ6z/nDfx9hL+lE+mh/XFzgMjOGORiVUIUmLVc0+ntEeWutdqC0zNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464

Hello Peter,

On 4/5/2024 3:57 PM, Peter Zijlstra wrote:
> Hi all,
> 
> I'm slowly crawling back out of the hole and trying to get back to work.
> Availability is still low on my end, but I'll try and respond to some email.
> 
> Anyway, in order to get my feet wet again with sitting behind a computer, find
> here a few patches that should functionally complete the EEVDF journey.
> 
> This very much includes the new interface that exposes the extra parameter that
> EEVDF has. I've chosen to use sched_attr::sched_runtime for this over a
> nice-like value because some workloads actually know their slice length (can be
> dynamically measured in the same way as for deadline using
> CLOCK_THREAD_CPUTIME_ID) and using the real request size is much more effective
> than some relative measure.
> 
>  [[ using too short a request size will increase job preemption overhead,
>     using too long a request size will decrease timeliness ]]
> 
> The whole delayed-dequeue thing is I think a fundamental thing that was missing
> from the EEVDF paper. Without something like this EEVDF will simply not work
> right. IIRC this was mentioned to me many years ago when people worked on BFQ
> iosched and ran into this same issue. Time had erased the critical aspect of
> this note and I had to re-discover it again.
> 
> Also, I think Ben expressed concern that preserving lag over long periods
> doesn't make sense a while back.
> 
> The implementation presented here is one that should work with our cgroup mess
> and keeps most of the ugly inside fair.c unlike previous versions which puked
> all over the core scheduler code.
> 
> Critically cfs-cgroup throttling is not tested, and cgroups are only tested in
> so far that a systemd infected machine now boots (took a bit).
> 
> Other than that, it works well enough to build the next kernel and it passes
> the few trivial latency-slice tests I ran.
> 
> Anyway, please have a poke and let me know...
> 

Sorry for the delay, I was waiting for all the basic issues to get fixed
before giving it a test but since OSPM is this week and folks would want
to discuss the series, I'm sharing the results based on the current

    git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/eevdf

At the start of the testing the HEAD was at commit 3883d848e41a
("sched/eevdf: Use sched_attr::sched_runtime to set request/slice
suggestion") and I'm using commit 4c43611fe406 ("Merge branch
'tip/sched/urgent'") as the base for comparison.

tl;dr

Mixed bag of results. We have hackbench and netperf slightly unhappy.
stream is as is, no surprises there, and tbench and schbench seems to
have a swing from being unhappy to happy as we scale. I'll leave full
results below including some experiments around
sched_feat(RESPECT_SLICE) proposed here
https://lore.kernel.org/lkml/20240424150721.GQ30852@noisy.programming.kicks-ass.net/

o System Details

- 3rd Generation EPYC System
- 2 x 64C/128T
- NPS1 mode

o Kernels

incomplete:		peterz/queue:sched/eevdf at commit 4c43611fe406
			("Merge branch 'tip/sched/urgent'")

complete:		peterz/queue:sched/eevdf at commit 3883d848e41a
			("sched/eevdf: Use sched_attr::sched_runtime to
			set request/slice suggestion")

Note: The above mentioned tree is prove to force updates and the
commit IDs reflect the state from when the branch was last updated
on "2024-04-30"

o Results

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:        incomplete[pct imp](CV)   complete[pct imp](CV)
 1-groups     1.00 [ -0.00]( 3.42)     1.32 [-32.19]( 2.87)
 2-groups     1.00 [ -0.00]( 1.28)     1.39 [-39.10]( 1.70)
 4-groups     1.00 [ -0.00]( 0.93)     1.50 [-49.85]( 1.28)
 8-groups     1.00 [ -0.00]( 1.00)     1.67 [-66.81]( 1.39)
16-groups     1.00 [ -0.00]( 2.69)     1.68 [-68.05]( 1.79)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:  incomplete[pct imp](CV)  complete[pct imp](CV)
    1     1.00 [  0.00]( 0.41)     0.98 [ -2.50]( 0.38)
    2     1.00 [  0.00]( 0.48)     0.96 [ -4.17]( 3.05)
    4     1.00 [  0.00]( 0.43)     0.96 [ -4.18]( 1.45)
    8     1.00 [  0.00]( 0.97)     0.93 [ -6.77]( 0.97)
   16     1.00 [  0.00]( 0.21)     0.91 [ -8.88]( 1.74)
   32     1.00 [  0.00]( 1.11)     0.92 [ -8.31]( 2.67)
   64     1.00 [  0.00]( 1.81)     0.96 [ -3.80]( 2.41)
  128     1.00 [  0.00]( 0.44)     1.02 [  2.43]( 0.92)
  256     1.00 [  0.00]( 0.26)     0.96 [ -4.35]( 1.07)
  512     1.00 [  0.00]( 0.12)     0.97 [ -2.87]( 0.64)
 1024     1.00 [  0.00]( 0.32)     0.97 [ -2.59]( 0.26)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:    incomplete[pct imp](CV)   complete[pct imp](CV)
 Copy     1.00 [  0.00](11.28)     0.80 [-20.19](15.70)
Scale     1.00 [  0.00]( 5.61)     0.99 [ -1.27]( 6.81)
  Add     1.00 [  0.00]( 6.76)     0.91 [ -8.97]( 7.97)
Triad     1.00 [  0.00]( 4.76)     0.88 [-12.27]( 8.45)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:    incomplete[pct imp](CV)   complete[pct imp](CV)
 Copy     1.00 [  0.00]( 3.28)     0.95 [ -4.61]( 3.81)
Scale     1.00 [  0.00]( 2.00)     0.99 [ -0.87]( 5.04)
  Add     1.00 [  0.00]( 1.44)     0.99 [ -0.51]( 2.12)
Triad     1.00 [  0.00]( 2.41)     1.01 [  0.63]( 1.45)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:     incomplete[pct imp](CV)    complete[pct imp](CV)
 1-clients     1.00 [  0.00]( 0.33)     0.99 [ -0.85]( 1.65)
 2-clients     1.00 [  0.00]( 0.58)     0.99 [ -1.18]( 0.35)
 4-clients     1.00 [  0.00]( 0.32)     0.99 [ -0.78]( 1.27)
 8-clients     1.00 [  0.00]( 0.31)     0.99 [ -1.31]( 0.97)
16-clients     1.00 [  0.00]( 0.53)     0.98 [ -1.95]( 1.11)
32-clients     1.00 [  0.00]( 0.50)     0.97 [ -2.94]( 1.29)
64-clients     1.00 [  0.00]( 1.71)     0.95 [ -4.86]( 1.14)
128-clients    1.00 [  0.00]( 0.82)     0.99 [ -0.67]( 2.55)
256-clients    1.00 [  0.00]( 3.88)     0.92 [ -7.65]( 3.27)
512-clients    1.00 [  0.00](43.49)     0.94 [ -6.35](49.81)


==================================================================
Test          : schbench (Old)
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers: incomplete[pct imp](CV)   complete[pct imp](CV)
  1        1.00 [ -0.00](34.42)     0.76 [ 23.68](31.33)
  2        1.00 [ -0.00]( 6.45)     0.83 [ 16.67]( 5.84)
  4        1.00 [ -0.00](14.87)     0.77 [ 22.73](16.44)
  8        1.00 [ -0.00](11.30)     1.07 [ -6.52]( 9.55)
 16        1.00 [ -0.00]( 6.33)     1.03 [ -3.45]( 6.11)
 32        1.00 [ -0.00]( 2.18)     0.94 [  6.25]( 3.77)
 64        1.00 [ -0.00]( 7.23)     0.99 [  0.51]( 5.93)
128        1.00 [ -0.00]( 6.76)     0.95 [  5.00]( 5.17)
256        1.00 [ -0.00](11.05)     1.22 [-22.33]( 9.70)
512        1.00 [ -0.00]( 2.15)     0.77 [ 23.20]( 2.81)
--

o Regression Breakdown

Following are some data I could gather for the regression
observed:

- Hackbench

The runtime of hackbench with EEVDF Complete is 24.81% more
that that on the current base kernel. Following is the IBS
profile comparing EEVDF Complete on the left to current base
on the right:

Command: sudo perf record -a -e ibs_op// -- perf bench sched messaging -p -t -l 100000 -g 1

Overhead  Command          Shared Object             Symbol                                             Overhead  Command          Shared Object             Symbol
   4.42%  sched-messaging  [kernel.kallsyms]         [k] osq_lock                                          6.30%  sched-messaging  [kernel.kallsyms]         [k] osq_lock
   3.76%  sched-messaging  [kernel.kallsyms]         [k] _copy_from_iter                                   4.06%  sched-messaging  [kernel.kallsyms]         [k] _copy_to_iter
   3.67%  sched-messaging  [kernel.kallsyms]         [k] srso_alias_safe_ret                               3.98%  sched-messaging  [kernel.kallsyms]         [k] _copy_from_iter
   3.18%  sched-messaging  [kernel.kallsyms]         [k] _copy_to_iter                                     3.85%  sched-messaging  [kernel.kallsyms]         [k] mutex_spin_on_owner
   2.80%  sched-messaging  [kernel.kallsyms]         [k] pipe_read                                         3.50%  sched-messaging  [kernel.kallsyms]         [k] srso_alias_safe_ret
   2.72%  sched-messaging  [kernel.kallsyms]         [k] mutex_spin_on_owner                               3.33%  sched-messaging  [kernel.kallsyms]         [k] inode_needs_update_time
   2.69%  sched-messaging  [kernel.kallsyms]         [k] pipe_write                                        2.39%  sched-messaging  [kernel.kallsyms]         [k] pipe_read
   2.49%  sched-messaging  [kernel.kallsyms]         [k] syscall_exit_to_user_mode                         2.36%  sched-messaging  [kernel.kallsyms]         [k] syscall_exit_to_user_mode
   2.40%  swapper          [kernel.kallsyms]         [k] poll_idle                     <----               2.30%  sched-messaging  [kernel.kallsyms]         [k] pipe_write
   2.31%  sched-messaging  [kernel.kallsyms]         [k] inode_needs_update_time                           2.23%  sched-messaging  [kernel.kallsyms]         [k] mutex_lock
   2.14%  sched-messaging  [kernel.kallsyms]         [k] srso_alias_return_thunk                           2.07%  sched-messaging  [kernel.kallsyms]         [k] update_sd_lb_stats.constprop.0
   2.13%  sched-messaging  [kernel.kallsyms]         [k] aa_file_perm                                      2.02%  sched-messaging  [kernel.kallsyms]         [k] ksys_write
   1.99%  sched-messaging  [kernel.kallsyms]         [k] native_queued_spin_lock_slowpath                  2.00%  sched-messaging  [kernel.kallsyms]         [k] aa_file_perm
   1.99%  sched-messaging  [kernel.kallsyms]         [k] do_syscall_64                                     1.98%  sched-messaging  libc.so.6                 [.] __GI___libc_write
   1.92%  sched-messaging  [kernel.kallsyms]         [k] ksys_write                                        1.94%  sched-messaging  [kernel.kallsyms]         [k] do_syscall_64
   1.90%  sched-messaging  [kernel.kallsyms]         [k] __fdget_pos                                       1.92%  sched-messaging  [kernel.kallsyms]         [k] srso_alias_return_thunk
   1.89%  sched-messaging  [kernel.kallsyms]         [k] mutex_lock                                        1.76%  sched-messaging  [kernel.kallsyms]         [k] entry_SYSCALL_64
   1.88%  sched-messaging  [kernel.kallsyms]         [k] entry_SYSCALL_64                                  1.62%  sched-messaging  [kernel.kallsyms]         [k] __mutex_lock.constprop.0
   1.62%  sched-messaging  libc.so.6                 [.] __GI___libc_write                                 1.48%  sched-messaging  [kernel.kallsyms]         [k] __fdget_pos
   1.61%  sched-messaging  [kernel.kallsyms]         [k] vfs_read                                          1.47%  sched-messaging  [kernel.kallsyms]         [k] vfs_read
   1.54%  sched-messaging  [kernel.kallsyms]         [k] apparmor_file_permission                          1.31%  sched-messaging  [kernel.kallsyms]         [k] native_queued_spin_lock_slowpath
   1.43%  sched-messaging  [kernel.kallsyms]         [k] rep_movs_alternative                              1.29%  sched-messaging  [kernel.kallsyms]         [k] apparmor_file_permission
   1.40%  sched-messaging  [kernel.kallsyms]         [k] entry_SYSCALL_64_after_hwframe                    1.25%  sched-messaging  libc.so.6                 [.] read
   1.36%  sched-messaging  [kernel.kallsyms]         [k] ksys_read                                         1.22%  sched-messaging  [kernel.kallsyms]         [k] mutex_unlock
   1.35%  sched-messaging  [kernel.kallsyms]         [k] vfs_write                                         1.18%  sched-messaging  [kernel.kallsyms]         [k] rep_movs_alternative
   1.24%  sched-messaging  libc.so.6                 [.] read                                              1.17%  sched-messaging  [kernel.kallsyms]         [k] entry_SYSCALL_64_after_hwframe
   1.23%  sched-messaging  [kernel.kallsyms]         [k] srso_alias_untrain_ret                            1.11%  sched-messaging  [kernel.kallsyms]         [k] atime_needs_update
   1.15%  sched-messaging  [kernel.kallsyms]         [k] __mutex_lock.constprop.0                          1.10%  sched-messaging  [kernel.kallsyms]         [k] vfs_write
   1.15%  sched-messaging  [kernel.kallsyms]         [k] atime_needs_update                                1.08%  sched-messaging  [kernel.kallsyms]         [k] ksys_read
   1.11%  swapper          [kernel.kallsyms]         [k] psi_group_change                                  1.03%  sched-messaging  [kernel.kallsyms]         [k] srso_alias_untrain_ret
   1.03%  sched-messaging  [kernel.kallsyms]         [k] copy_page_from_iter                               1.01%  swapper          [kernel.kallsyms]         [k] psi_group_change
   0.98%  sched-messaging  [kernel.kallsyms]         [k] update_sd_lb_stats.constprop.0                    0.96%  sched-messaging  [kernel.kallsyms]         [k] copy_page_from_iter
   0.95%  sched-messaging  [kernel.kallsyms]         [k] psi_group_change                                  0.93%  sched-messaging  [kernel.kallsyms]         [k] psi_group_change
   0.91%  sched-messaging  [kernel.kallsyms]         [k] copy_page_to_iter                                 0.79%  sched-messaging  [kernel.kallsyms]         [k] copy_page_to_iter
   0.89%  sched-messaging  [kernel.kallsyms]         [k] rw_verify_area                                    0.76%  swapper          [kernel.kallsyms]         [k] poll_idle		<------ poll idle jumps up in case of
   0.86%  swapper          [kernel.kallsyms]         [k] acpi_processor_ffh_cstate_enter                   0.71%  sched-messaging  [kernel.kallsyms]         [k] rw_verify_area			EEVDF complete
   0.77%  sched-messaging  [kernel.kallsyms]         [k] mutex_unlock                                      0.71%  swapper          [kernel.kallsyms]         [k] acpi_processor_ffh_cstate_enter
   0.77%  sched-messaging  [kernel.kallsyms]         [k] security_file_permission                          0.69%  sched-messaging  [kernel.kallsyms]         [k] try_to_wake_up
   0.73%  sched-messaging  [kernel.kallsyms]         [k] select_task_rq_fair                               0.67%  sched-messaging  [kernel.kallsyms]         [k] select_task_rq_fair
   0.71%  sched-messaging  [kernel.kallsyms]         [k] __schedule                                        0.63%  sched-messaging  [kernel.kallsyms]         [k] __schedule
   0.70%  sched-messaging  [kernel.kallsyms]         [k] entry_SYSRETQ_unsafe_stack                        0.61%  sched-messaging  [kernel.kallsyms]         [k] entry_SYSRETQ_unsafe_stack
   0.59%  sched-messaging  [kernel.kallsyms]         [k] syscall_return_via_sysret                         0.61%  sched-messaging  [kernel.kallsyms]         [k] security_file_permission
   0.57%  sched-messaging  [kernel.kallsyms]         [k] dequeue_entity                                    0.52%  sched-messaging  [kernel.kallsyms]         [k] update_load_avg
   0.54%  sched-messaging  [kernel.kallsyms]         [k] current_time                                      0.51%  sched-messaging  [kernel.kallsyms]         [k] native_sched_clock
--

Further pinning the workload to one LLC domain (CCX) shows poll_idle
jump to top:

Command: sudo perf record -C 0-7,128-131 -e ibs_op// -- taskset -c 0-7,128-131 perf bench sched messaging -p -t -l 100000 -g 1

Overhead  Command          Shared Object         Symbol                                                 Overhead  Command          Shared Object          Symbol
   9.14%  swapper          [kernel.kallsyms]     [k] poll_idle				<-----             3.55%  sched-messaging  [kernel.kallsyms]      [k] pipe_read
   3.02%  sched-messaging  [kernel.kallsyms]     [k] native_queued_spin_lock_slowpath                      3.53%  sched-messaging  [kernel.kallsyms]      [k] pipe_write
   3.00%  sched-messaging  [kernel.kallsyms]     [k] pipe_read                                             3.48%  sched-messaging  [kernel.kallsyms]      [k] srso_alias_safe_ret
   2.97%  sched-messaging  [kernel.kallsyms]     [k] pipe_write                                            3.37%  sched-messaging  [kernel.kallsyms]      [k] _copy_from_iter
   2.95%  sched-messaging  [kernel.kallsyms]     [k] srso_alias_safe_ret                                   3.15%  sched-messaging  [kernel.kallsyms]      [k] syscall_exit_to_user_mode
   2.83%  sched-messaging  [kernel.kallsyms]     [k] _copy_from_iter                                       2.76%  sched-messaging  [kernel.kallsyms]      [k] native_queued_spin_lock_slowpath
   2.56%  sched-messaging  [kernel.kallsyms]     [k] syscall_exit_to_user_mode                             2.62%  sched-messaging  [kernel.kallsyms]      [k] srso_alias_return_thunk
   2.23%  sched-messaging  [kernel.kallsyms]     [k] srso_alias_return_thunk                               2.59%  sched-messaging  [kernel.kallsyms]      [k] do_syscall_64
   2.21%  sched-messaging  [kernel.kallsyms]     [k] do_syscall_64                                         2.44%  sched-messaging  [kernel.kallsyms]      [k] __fdget_pos
   2.05%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSCALL_64                                      2.34%  sched-messaging  [kernel.kallsyms]      [k] entry_SYSCALL_64
   2.04%  sched-messaging  [kernel.kallsyms]     [k] __fdget_pos                                           2.20%  sched-messaging  [kernel.kallsyms]      [k] _copy_to_iter
   1.87%  sched-messaging  [kernel.kallsyms]     [k] _copy_to_iter                                         2.18%  sched-messaging  [kernel.kallsyms]      [k] aa_file_perm
   1.82%  sched-messaging  [kernel.kallsyms]     [k] aa_file_perm                                          2.16%  sched-messaging  [kernel.kallsyms]      [k] vfs_read
   1.67%  sched-messaging  [kernel.kallsyms]     [k] apparmor_file_permission                              2.08%  swapper          [kernel.kallsyms]      [k] poll_idle   			<-----
   1.65%  sched-messaging  [kernel.kallsyms]     [k] vfs_read                                              2.03%  sched-messaging  [kernel.kallsyms]      [k] apparmor_file_permission
   1.63%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSCALL_64_after_hwframe                        2.00%  sched-messaging  [kernel.kallsyms]      [k] entry_SYSCALL_64_after_hwframe
   1.59%  swapper          [kernel.kallsyms]     [k] psi_group_change                                      1.85%  sched-messaging  [kernel.kallsyms]      [k] rep_movs_alternative
   1.56%  sched-messaging  [kernel.kallsyms]     [k] ksys_write                                            1.83%  sched-messaging  [kernel.kallsyms]      [k] vfs_write
   1.54%  sched-messaging  [kernel.kallsyms]     [k] ksys_read                                             1.82%  sched-messaging  [kernel.kallsyms]      [k] ksys_write
   1.51%  sched-messaging  [kernel.kallsyms]     [k] vfs_write                                             1.72%  sched-messaging  [kernel.kallsyms]      [k] srso_alias_untrain_ret
   1.49%  sched-messaging  [kernel.kallsyms]     [k] rep_movs_alternative                                  1.71%  sched-messaging  libc.so.6              [.] __GI___libc_write
   1.46%  sched-messaging  libc.so.6             [.] __GI___libc_write                                     1.70%  sched-messaging  [kernel.kallsyms]      [k] ksys_read
   1.42%  sched-messaging  [kernel.kallsyms]     [k] srso_alias_untrain_ret                                1.58%  sched-messaging  [kernel.kallsyms]      [k] atime_needs_update
   1.30%  sched-messaging  libc.so.6             [.] read                                                  1.56%  sched-messaging  libc.so.6              [.] read
   1.24%  sched-messaging  [kernel.kallsyms]     [k] atime_needs_update                                    1.56%  sched-messaging  [kernel.kallsyms]      [k] mutex_lock
   1.20%  sched-messaging  [kernel.kallsyms]     [k] mutex_lock                                            1.35%  sched-messaging  [kernel.kallsyms]      [k] psi_group_change
   1.04%  sched-messaging  [kernel.kallsyms]     [k] psi_group_change                                      1.26%  sched-messaging  [kernel.kallsyms]      [k] copy_page_to_iter
   1.03%  sched-messaging  [kernel.kallsyms]     [k] inode_needs_update_time                               1.20%  sched-messaging  [kernel.kallsyms]      [k] select_task_rq_fair
   0.99%  sched-messaging  [kernel.kallsyms]     [k] rw_verify_area                                        1.16%  sched-messaging  [kernel.kallsyms]      [k] inode_needs_update_time
   0.98%  sched-messaging  [kernel.kallsyms]     [k] copy_page_to_iter                                     1.16%  sched-messaging  [kernel.kallsyms]      [k] rw_verify_area
   0.95%  sched-messaging  [kernel.kallsyms]     [k] select_task_rq_fair                                   1.12%  sched-messaging  [kernel.kallsyms]      [k] copy_page_from_iter
   0.95%  sched-messaging  [kernel.kallsyms]     [k] copy_page_from_iter                                   1.06%  swapper          [kernel.kallsyms]      [k] psi_group_change
   0.92%  sched-messaging  [kernel.kallsyms]     [k] __schedule                                            1.04%  sched-messaging  [kernel.kallsyms]      [k] security_file_permission
   0.85%  sched-messaging  [kernel.kallsyms]     [k] security_file_permission                              0.96%  sched-messaging  [kernel.kallsyms]      [k] try_to_wake_up
   0.68%  swapper          [kernel.kallsyms]     [k] do_idle                                               0.86%  sched-messaging  [kernel.kallsyms]      [k] entry_SYSRETQ_unsafe_stack
   0.67%  sched-messaging  [kernel.kallsyms]     [k] dequeue_entity                                        0.80%  sched-messaging  [kernel.kallsyms]      [k] mutex_spin_on_owner
   0.67%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSRETQ_unsafe_stack                            0.79%  sched-messaging  [kernel.kallsyms]      [k] __schedule
   0.66%  sched-messaging  [kernel.kallsyms]     [k] update_load_avg                                       0.79%  sched-messaging  [kernel.kallsyms]      [k] syscall_return_via_sysret
   0.65%  sched-messaging  [kernel.kallsyms]     [k] syscall_return_via_sysret                             0.75%  sched-messaging  [kernel.kallsyms]      [k] current_time
   0.62%  sched-messaging  [kernel.kallsyms]     [k] mutex_spin_on_owner                                   0.66%  sched-messaging  [kernel.kallsyms]      [k] __mutex_lock.constprop.0
   0.60%  swapper          [kernel.kallsyms]     [k] acpi_processor_ffh_cstate_enter                       0.63%  sched-messaging  perf                   [.] sender
   0.60%  swapper          [kernel.kallsyms]     [k] __schedule                                            0.63%  sched-messaging  [kernel.kallsyms]      [k] update_load_avg
   0.59%  sched-messaging  [kernel.kallsyms]     [k] current_time                                          0.59%  sched-messaging  perf                   [.] receiver
   0.54%  swapper          [kernel.kallsyms]     [k] enqueue_entity                                        0.56%  sched-messaging  [kernel.kallsyms]      [k] file_update_time
   0.52%  swapper          [kernel.kallsyms]     [k] menu_select                                           0.55%  sched-messaging  [kernel.kallsyms]      [k] touch_atime
   0.50%  sched-messaging  perf                  [.] sender                                                0.52%  sched-messaging  [kernel.kallsyms]      [k] x64_sys_call
--

This jump up of poll_idle seems to be a higher order behavior change as
a result of Complete EEVDF. Looking at "sched/fair: Implement delayed
dequeue", can there be a case where ttwu_runnable() in try_to_wake_up()
can stop task migration on wakeup and queue it on a busy queue where it
was marked for a dealyed dequeue?

When looking at per-task statistics from sched-scoreboard, I see a 41%
decrease in nr_migrations going from base to Complete EEVDF. I also
see the cumulative wait sum shoot up by 88%.

comm: sched-messaging                    incomplete	   complete	%diff
Average of avg_atom	                0.118341601     0.036585796	-69%
Average of avg_per_cpu	                0.446550378	0.668355323	 50%
Sum of nr_migrations	                    1414593          829870	-41%	*
Sum of nr_switches	                    4013420	    3563675     -11%
Sum of nr_voluntary_switches	            3912865	    3562547      -9%
Sum of nr_involuntary_switches	             100555	       1128     -99%
Sum of nr_wakeups	                    3913621	    3567097      -9%
Sum of sum_exec_runtime	                95557.37505	101666.7651	  6%
Sum of sum_idle_runtime	                1928546.553	975487.7551	-49%
Sum of wait_sum	                        69884.24284	131511.9207	 88%	*

For tbench and netperf I could not get any concrete culprit from
perf with IBS or per-task stats. I'll continue digging. However, it
could just be similar higher order effect where poll_idle steals
cycles from smt sibling running the task.

---------------------------------------------------------
- Experiments with sched_attr::sched_runtime on SPECjbb -
---------------------------------------------------------

I tried some experiments with sched_attr:sched_runtime on SPECjbb.
With the base kernel, I was not able see any changes in the SPECjbb
results with various sched_attr::sched_runtime set for various
threads. However, with Complete EEVDF (contains RESPECT_SLICE), I'm
able to eek out some performance improvements on the workload.

Background information on the threads of SPECjbb - txinject drives
the workload by injecting transaction. MapReduce, ForkJoinPool, and
the Backend threads are responsible for the main business logic of
transaction processing. There are GC threads from Java and a
compiler thread for what I presume is some form of JIT compilation.

I've used following naive strategy:

- Set a very small slice to txinject since I would like to push as much
  load as possible, as quickly as possible.

- Very small slice to ForkJoinPool and MapReduce threads so they can go
  ahead and pass the load to backend threads.

- Very small slice to compiler threads so thay can unblock whatever is
  waiting on the JIT compilation.

- A very large slice to the backend thread so it can process as much
  data as possible in one go.

- Maximum slice size to the GC thread purely because it should not
  interrupt other processes.

With the above setting, I see the following trend:
		EEVDF Complete vs base
Max-jOPS		 +7.05%
Critical-jOPS		-15.62%

The key takeaway of the experiment is that, with EEVDF complete, I'm
actually starting to see some behavior difference with different values
unlike with the current tip:Sched/core. I believe it is RESPECT_SLICE
helping to keep tasks with large slices on the runqueue beyond the
0-lag point.

Note: These results are from naive experiments. I'm sure looking at the
per-task statistics and deciding on the slices more judiciously can
further benefit the workload.

On a parting note, it was not very straightforward to set these values
outside of the application without any application modification. In my
case, I was consuming "task_rename" evvents via trace pipe to find the
relevant pids to then tag.

------------------------------------
- DeathStarBench and RESPECT_SLICE -
------------------------------------

Following is the trend I see for RESPECT_SLICE on DeathStarBench:

Pinning	   #instances	   EEVDF_COMPLETE
1LLC 		1		 9%
2LLC		2		 3%
4LLC		3		-1%
8LLC		6		-5%

Dropping RESPECT_SLICE and using my original RUN_TO_PARITY_WAKEUP
https://lore.kernel.org/lkml/20240325060226.1540-1-kprateek.nayak@amd.com/
still shows regression for larger instances pinned to larger number of
LLC domains with EEVDF Complete. This remains to be investigated as
well.

I'll update the thread with more information in the coming days.
--
Thanks and Regards,
Prateek

