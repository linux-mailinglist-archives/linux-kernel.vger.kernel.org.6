Return-Path: <linux-kernel+bounces-549947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E42A558E3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B31173EA4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A0A207A31;
	Thu,  6 Mar 2025 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bbJZ56Xu"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C40D151990
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296946; cv=fail; b=G3pHjDoyRNJRzhy4bLT//XhKShsEEOZeId4+/PZIDDZy43M6jNNk0GCHacnGIk8wv4GTMJQ3qpwrS8AXcxWnOSvLU21j8RwSzu5ydnVKFy4e7AO/5jYjVhByWMMlFykppjYZ8TI3wcoISoy7ZxNkYY1fmKyIJKmWP41EZuD5zzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296946; c=relaxed/simple;
	bh=szJ3mM/APoXc8WDSEgQWkWmcdcXZkO+zxi9RxAUeDq4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FY9ENe0vb2+L1ZIBm4tWNZVEnhk8HL+kA024xktuGwFrkmecqDSIloR2V3ScgEXMbgxoZ/0trQ6CO/4BbsODJUe4V02SEszq8s2zIHKi26UAo7/nc+y+LVKoYxXxoLXklPkbG5CALplEZKAdFDMMuczWREvYUchMFoi3ZcFJo9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bbJZ56Xu; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFMCdA+XnepPZ77ckMNVGQ8MoyxJ786BCx/jM9tl97FmkIl9sG9BW/YigkZ0YYBc1i6T4D880Bgqqujj7z6JNrIb69BFXTLOtGJacblB9+RCHHRInKXCB98Kjkyy5bPzi0oG+41HzP361438g/3ieTnblmHhKpRK4Vt53ZphF3m1M47XOtFVoIjIPvCo/VdAEesFwGrHluNZRmPAvyXr49xm+ymJIIfVIGRwaclLmdzyP0Olw341xsnadbmxFZKxExUNM95CBF6I9WetR+7NhSDnaqphQks1lDM2Ryt39e2JOeBOkC/Icq7uwem49TCLqfPFT8QmtBEFyaxzkWB6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szJ3mM/APoXc8WDSEgQWkWmcdcXZkO+zxi9RxAUeDq4=;
 b=gavmiMiRTb3OquYJ5C58esbnZsNcfjOt2nghC+4Xia0SF+eOnIPsvUDLJw822zBia3jdUPecDa8bzTraozfIB0nF8o0MVkP3XWaswJiQJ4kIatR8Xjq8aQl0Wa/d2pbvAtCVxiq/gkZ4y8Qe4YSvmoKdx9syx1gElthl1od14KLiQ7iANXe3TiLyxij/j2l2N147mKW18TY3eVPlczRPODMu3uUVlX/U3xXGGzoUsoz2zODACpVha4jykxQTCSos6wp1pY4oxtcNnOuUR4AqIHq9xLIzzsl5rXhhONdB8or1OHXoLPmmYwv8P/Vl/9mzxjJGFyHAq0sAYAbmtXU6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szJ3mM/APoXc8WDSEgQWkWmcdcXZkO+zxi9RxAUeDq4=;
 b=bbJZ56XuGI2zsgVdTn5s+NU6Xwbj3Dxj5L2DLEfCG2T7ugIG+IolV5je60Fy85LTzHTdqjbh1lhfmkEwV62LhU5e5J3gjUteCvXhwy5zOx6wGgY8CmN3m3a6PSDyeEB3c3mn6WyVMv1kTSof+xifcl7imJ2ijVa3F+xNUXkNbpvdAfSgvIfOWwjF2LXVIARmFR2VeKwlgIUT4c5rs6Sv7Nm72c0+TU2cpwpkUwYJ/aoSFMzR+4LF+8/lavWKvXbtlsEUYCQY+AHvJP/OHxbOj9bXy8XJueiKJLLKFN2KsWgRS3ftwHmqE2A8NlTrk7AgXujz5QDOEhTATMKUw0fBKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:35:41 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:35:41 +0000
Message-ID: <f2325a5b-96a8-4e6a-9d67-7b7a94d19979@nvidia.com>
Date: Thu, 6 Mar 2025 13:35:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 24/49] x86/resctrl: Allow an architecture to disable
 pseudo lock
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-25-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-25-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0067.namprd02.prod.outlook.com
 (2603:10b6:a03:54::44) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: de8e8e04-c052-45be-3265-08dd5cf6d83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U001d2hKenFIcjlxZVl6Zjk0Mkd6eHNIMVkrOWNmSktMZDJtWWJaTHJlQXZ5?=
 =?utf-8?B?ZkJXeFpzckhkaWRGdG1mRlNHWmxRVDBMeitMRmVzSnNKQmtqTGZhd0puWGlw?=
 =?utf-8?B?bnJNdlFlK0JZMnZJL2lmTUFzRi93Mmg4RU5ZamxPUTM5QmdOd2ppQUljM1Iz?=
 =?utf-8?B?UnBmZmdCUlFaaC9mM0dUMlA3dGR3QWFWQ3BZcVpLUVc0d29oaGFUKzNpUG4y?=
 =?utf-8?B?dTZweENZRUZBQnlGS2thRjJ4MGMxWWxsTk5VYWVYUjM5bGxvNWJiZEVwWURC?=
 =?utf-8?B?aEZ0d1pGemFUSEM4cU82cDN1NVA0TU90S2JmQklVYTNRd0k5UmtTUDN3VGsr?=
 =?utf-8?B?SlFEZlF6VWdpUjZQUVRNNG9Sclc3MGpXa1F3UDRXR2xBa0hSWjNJUkpGazBV?=
 =?utf-8?B?MzNiZkQvV3NaMWRSbXQ4Zk9Kem9lOTI1b3BGSHNIZUFZMGJkaEpsMXFJY0tO?=
 =?utf-8?B?WnIxR2R1eG9jYkI4cmltWkRGUzhzZFptUUlLSlpkZXVoTmZDczE1Tm4vT0JT?=
 =?utf-8?B?b3FvQ1drZzRBVWYwbStUZ1JJblJuQ3dVd05ua3p0NDhpUkxIdFhZSnA4SFpx?=
 =?utf-8?B?RE0yWFJmdFdDMXNMaU5kM2dEd0NEVFN0d1p0Tjd1R2RCRWFiWmxTU0Z2VnFj?=
 =?utf-8?B?VGtKdHJYbEVCMXJHL0dpbkVORlR2TS9POTJCREpaZW1ibWc2bkZDZHErRjJ6?=
 =?utf-8?B?UlJPQmQ5UmpYa3AzTXBiNG1VK1lZa0llWjNxa3drT1VxOEN5RDZLK1p5RUdp?=
 =?utf-8?B?a1c0TDRjS29TQ1hIbWJvdFZ0UzNncGFZLzk4NWVnQWFCVGVtMFByNm5kSFZx?=
 =?utf-8?B?eHpUT0ROM3BUKzVYMzVEalNWL1gvVmJKaVEvZXlkL0VmN2oxblhBbnMvbVla?=
 =?utf-8?B?V2VsajVNZ3FqMUVYcDZhTWh0TU5wWnVJOHd1b2ZFQTNrVEZKWUxzL1RLS0Nr?=
 =?utf-8?B?c3VERUMwdGlJeUkvK2R6RzhlZjR6RnN4aVFtL0RIOENMalpxZ1JrcEU2eGdj?=
 =?utf-8?B?bWhEd2ptVWhYTWN3RUVJY291TFlLYzFtT1luK2UrTi9vSk9PNmFmK01QcUg2?=
 =?utf-8?B?enFXbW02b0cvNTViN2RmNUFicU4zSVU2TXg5UmVRbEJKcjlxNmdmQkk3OHFO?=
 =?utf-8?B?c095UFFRWlo1NTViVlE1dUhoMFEycXE1NFQyQ3kwa1pvUnJ2NXJvbHA4ZGI2?=
 =?utf-8?B?bWp6dXd2N2M4VlVSbXQrNTJMSzgvUnpZMDN5NXpSKyttTVVKMEFlaGh6eVJD?=
 =?utf-8?B?Vk5Dc2NRall3QmJqVEhuOHJHdnZmVjZzcEpOWkVZdXhQNDQ1NTdWQUJES2dG?=
 =?utf-8?B?SXBTWHNZQWoxcVJyaEdQaE1aaEZhalJYTk5LTENLS2hFM3dkVEZBTjNIdk03?=
 =?utf-8?B?SCszcVQzdHpQaGVFQlQzalphd3hoMm8xVHZjeDJnUmpROGVIZDg3ZHBrUUI2?=
 =?utf-8?B?WDZYRmpjeUZLM253ZFF2YTB2UDc5L1J4Z1JxTVc2TitoYVRnZWtuNU9sVXN1?=
 =?utf-8?B?M213QjZ5U3pVeTVEdmxYWnRGOU5BUHRZQ2crek14RzhvdzZTeFdkY2ZnYkZw?=
 =?utf-8?B?dEVWT0IzWVJhbXlUV0FYSk9uUnVobWFqejkveFU0ZkxTN1NJUklTaFY5VHVI?=
 =?utf-8?B?TTkwUHErLzJ4UFhVbFBRa3ZpVGVrTlN3WURyOEdiRHdQd2VvaTd5WFRqdGdO?=
 =?utf-8?B?Tk12RCtuS2NHTlJGUDIzSXltWUhBYkJDYnBLSHBWd1JBK3lCdnNwR1RyaXB0?=
 =?utf-8?B?TkhXRzZUZS9ySUFkNnUxeWRMM3ZwdVFvWjhGVTVjSElzc2Jpb0NCTjMxQVpx?=
 =?utf-8?B?TTU5M3ZoZlVLRW4raUhUTGt0Z2FuNk5zaTBEMGtESEJxWmF3SDVNS2RITWJM?=
 =?utf-8?Q?ogFFhv38v5Uyo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGlCRTBWWmgvZ1NIQXNCbmFlSXBjTGg4UUVpTGVBQVR2YkFTZGdQQjRSZnY5?=
 =?utf-8?B?UTVlWE43ZnNLNm4xYUJMaGJLbFlpUHA4SnJSTU01ZGltMW14K1U4U3dKaHhJ?=
 =?utf-8?B?Mlh2ak9wT2lFUDF0Z0xUQ2liNzJaK2RXOGtCakIrK29GVWdraGg0dFhLZHc4?=
 =?utf-8?B?SzhrSjNZdldVT3pleEg5T3VNb0lRdDNOUGRFNXdhQW1RQllyU3BjQ0pCMTBi?=
 =?utf-8?B?UDI2dFB2aXNrQ0hZWi9KR3lXY1BLWE1uODVOTThGMjcyTHlXbzNhdkhVV3dw?=
 =?utf-8?B?TE5OalVwdWdRRDNMc2lLcEZUNDRwTGZDNS9CQlUzVmJkWHUzYUphdEo2aS9i?=
 =?utf-8?B?Q1hhc0tKSHUvbTY3dVM0Y3g3cExIQUVmQVBxYk90NGJUbk56bzdjdXVUR203?=
 =?utf-8?B?b2lzUjRuMm1nWFhwSm9Nd3MwRkZJeHVUNS9oYzRJY2ZHQXl3N2JLV3dhKzlk?=
 =?utf-8?B?Y3d1d1g1YklXbEN0alNlQlNNRlBqS3pyZWNUUlMzSDY1b3piSFdTNi82Skkv?=
 =?utf-8?B?MlVCTUF5eDZUbzRwWkU3TkV1SHJrbHVKeExHM2RNak5UWkNvbno5M2IwMk1z?=
 =?utf-8?B?VFYzT3ljSTZyQ3poMy9jSTVuQ1RReDRLU0FwSWZTbGlCaG1CTUxZejBrbWlp?=
 =?utf-8?B?UkMzTHE5T05GZGduWkg4WXNPczA2SUJnb0lxNms1T0lqQUhlL1Q2NlE5dTJK?=
 =?utf-8?B?a0Z6ZTlET01tSnErYjFLVmZjVjRIODZsS01iSWY5ZFU4K1RTTE1rOWV5TWFI?=
 =?utf-8?B?RndXNDFEOEJVRXFTeTFQVGhUVU5YNWdmZWFhSGM3ZjZWUmVyQ2tRZnFRSU9v?=
 =?utf-8?B?Z2RXNHdTaEQ4UitBcklJL05rZngwWWVveGE4cVVGREt3Q3YwZGl0Rno2dU5t?=
 =?utf-8?B?d1FRYTVZQ0NLMmw2WEJXM2xnRmlyaXhqTit3QXFKaEZLS3Z6YlpYYUtYS3Nn?=
 =?utf-8?B?UEFuZG9uRDA2N0NTbVlGSXVHMnM2aWJtQ0JZL20xeEpxUHdNM29wc0JHVTJl?=
 =?utf-8?B?eDExSEE5QkFkeXRkd0VIVVRsSWFOWUJQYkNBaW4xZmlnYXZvQ0dyOEFmN0Mv?=
 =?utf-8?B?MklWZjJ5aVZSQ1JDWFM1WmRZR2oxMzJZTWdpZkVmOFlrMzlLb0RWL2RlYmts?=
 =?utf-8?B?ajdLdCtOaEtBclhjaElNTVBQcVh3cFM1VnlQSkZVNTlUUEJyV1JEOHhpc0E5?=
 =?utf-8?B?enhxV1IwRkxUVkhhakIwRVpWSnJPN2RuM09yWTVseEdUK3FzSFlaSWRZNHFG?=
 =?utf-8?B?UW96bDBYU3p2b0lEQ0NLZkE2UTFIT3p3b0FZcTVGRmJReG5uNzJWcnhyb3JS?=
 =?utf-8?B?cWpSRUx1d1FocmhBd3V3NlBmMktUUExvbUFhbTVrVW1oSHBWYnAxeFBXQXA1?=
 =?utf-8?B?WnRscTFTMHYwbjlsSUc0d21ienJlVVVxbkprUkZGQWdzbFNsT1FKL2greVJa?=
 =?utf-8?B?NmdQZnE5WEs2NklOMnk5dUNETDduNVVuNlJScVRJMkd1L0ExMThDc29nTG54?=
 =?utf-8?B?anY5cUk2RmVMek42M0NpQlRNbjVFTGg3MUk2ZmhKdUZxbndsOXpkY1BVNHZP?=
 =?utf-8?B?N2doZStIMTMvaXRoTXh6Y05UbHpYV3JDME1lbVFVOEV0ZHo1NTBBd2tEM0dk?=
 =?utf-8?B?Y2pQU2w4L1cxV0xuSlh1QUFKM2MrWm9RSGMxQk16SXhLWU1sVDUyV3F0NWtR?=
 =?utf-8?B?MzRvSVVUN1lGQlphZCtYRVd5Q3RmbjArWGhtWUdtUHZDL2pMbGpENjZuOGVs?=
 =?utf-8?B?MlFraVpJd0NOa2hQWWdvOVVxdkJuL1Rid3ZTSElaT1VhdDhndGtXeGJ2VWRR?=
 =?utf-8?B?a3JiUmJibVBWTXhkd2JtWm9iV1dxSzNCN2c4cnZLRzQyRGkyajFhdmpPSEsw?=
 =?utf-8?B?MldhUGJjQk9aaUNVNG9iTkhZWVM3RUszUThCTmxtKzRqdURFK2crN3p1SlQ4?=
 =?utf-8?B?UmxlUzRBWUFwVEowVi9lQVU5OXI2Nk1maHhNbTBuYm1SNm56SUFISWVHRGJl?=
 =?utf-8?B?MGxSUHF3a1ZLRkxUS2VSYTJCRkkrMmlabVUxVDFVVlVENkp1SCs0djZWV1pt?=
 =?utf-8?B?VXZhL0VMc0hPanZkQW9oblBVeTlEQmk0cGhKQ3gwZDZRcG5hbk9DUjNzOWhF?=
 =?utf-8?Q?UAozIygR9chBfJC5o801FVZuU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8e8e04-c052-45be-3265-08dd5cf6d83d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:35:41.7605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFNVPUyl5z3GnXcIHy6Wx2BBvnhx1+Yox2XTWbhmHLEC8SXaqt16rTDAtytXYnsLob6g6nhzzk32jr3+8qzuIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961


On 2/28/25 11:58, James Morse wrote:
> Pseudo-lock relies on knowledge of the micro-architecture to disable
> prefetchers etc.
>
> On arm64 these controls are typically secure only, meaning linux can't
> access them. Arm's cache-lockdown feature works in a very different
> way. Resctrl's pseudo-lock isn't going to be used on arm64 platforms.
>
> Add a Kconfig symbol that can be selected by the architecture. This
> enables or disables building of the pseudo_lock.c file, and replaces
> the functions with stubs. An additional IS_ENABLED() check is needed
> in rdtgroup_mode_write() so that attempting to enable pseudo-lock
> reports an "Unknown or unsupported mode" to user-space via the
> last_cmd_status file.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


