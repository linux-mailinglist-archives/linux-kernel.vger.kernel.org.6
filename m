Return-Path: <linux-kernel+bounces-549893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C92A55848
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303781679D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513DC27C878;
	Thu,  6 Mar 2025 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mULNpIun"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19BE27C859
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295109; cv=fail; b=NE3u60zxhc13AOsu7/Ax5efop5v9oUtm5LYTSufjoEKXPxifhanH2297qjP9e8EX7cb9N9OmzaGyj4FsS3QGvwMWzEivj9sEnQ8kO59hTpT7uCdJqpVPyK3vc6Yi+j3lAhjzE+iDpDmJRTZGWVH+KweVY8534k3Nh/3/4Kq+FL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295109; c=relaxed/simple;
	bh=i9sPgPThkGimSPcnW9RVohWb1Ks6aSeDADK6xJKxzj8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bd3GE98csjRwNQNYxVBr3ML0zkraXQ1uCRjmT4TGJZfGD7kPALOXkUNSUw5P4n6mQFTpwc9MWQ18REB2P/x/Ql/211cKEzLr9xXsUKV+APD6y+DREjmYNPZP/7xRRvJO2VVK5HPSXqhstiD9Bog1ufAxwAE6sXvBuB1lbKDSVEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mULNpIun; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFMH4Q13mimxNxzPtgom+Ic9pRwOatpkXN6L5g4KOIs3QZ2N6blqMSlvRQE24vPl7WGRINxq8tcTDXVo03aU7yQWwQYEjakxCo57k8wwg1uEJIBbdyhsErPjSVO2Rr6T37RLZxykyRJdVHiyAAxeYlSBGRDXeDOVN7TtS1GENP7JAqCxETpufY6t9xTJzMfsU2dDlp14moMerfev2BVMdEW8WNOO0mT5xxoo4YHFUBj4LraJAuO+sUFIyK27x1ewofCoZuMHNKK0yXjWRrLsbcQfTsGYGoe7trt+r6g3Krv4+nOJNW8ri/ry0fh9SFd2bE9eee4yjXU94lz5O/FYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9sPgPThkGimSPcnW9RVohWb1Ks6aSeDADK6xJKxzj8=;
 b=G14JPxLtT78pWTmZLJIAQIXirxDhu3JOHDs+4rk/iwgQ3aclBuyrGjvsyhu1/dy29gTgwWCfP00v7/TQfaaQuYbVD7W3DVfqq8M3RLc2LDGpEuAO2yJ6nukUppO5GjZTW0gDk0azvhZfJUXo+AncOwe2tcCG0CdsnTBQHFGV8SqQctzThn+ckPse7zB+1KHbkGB0r5Gc8s7T+oTgMW7idqHfgiufPPi1SbyQPHFzjArgOpFf0XUJJkOZEVwsO/rYX5tKU5dGdfd87y06HllVmYET8Xu0eNrVRn2LqcbUHnHzAMvFb9Oo06blCRMkty7DsQGQoxU0GOrP3L2HNzGbLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9sPgPThkGimSPcnW9RVohWb1Ks6aSeDADK6xJKxzj8=;
 b=mULNpIunOOJcJibQyRM2QrynAHYaPHOv65hmM6WQYC6Xz2umlAJE0lZ5tizbJwC2uzt0phFJ45LB7oNR3VGImNfK9sWpoF0Y0mTaAq8jrvs026+AycaU9xMvgsvI7VBlRyUEh+WazyFGRr7n6YzMRe5yV7UD/7NOIAgiIHNOSxUgAvShYtt5wbBYvN7McsGrBBe6ZdB0aLm4ncyoqB9CV5U5D7T+FQPZyyNZbz9XxcVzixT1D0G3eZ4Wz3krczyvuSXDYIsW3SVja/vVNQDrERFcdFsq3ZFi/I6TTLKqz24TBj/T7LA1hNvo1h8P984230uBBn14lZHkh8kTF6mRDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 MW4PR12MB7237.namprd12.prod.outlook.com (2603:10b6:303:22a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 21:05:04 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:05:02 +0000
Message-ID: <0690a4ae-00f5-446c-bf62-6b3f65e6c48b@nvidia.com>
Date: Thu, 6 Mar 2025 13:04:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/49] x86/resctrl: Remove rdtgroup from
 update_cpu_closid_rmid()
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
 <20250228195913.24895-11-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-11-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::21) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|MW4PR12MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e5e204-887d-4a60-d5a8-08dd5cf28fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWNGQStEWWVmMldtR3pUclpxaVEyTld0bWk4aVd6a08yWW5kV1I3N3FmR3hK?=
 =?utf-8?B?VFRhQ0J2MUR4M2UvNW5XUEZQeC9qUWFYa3pxM283YStqS2d2RUJITmZ4Z0dN?=
 =?utf-8?B?UTdBa2swSDcwdUo1bWI0UnExUnlSYU1BL05scnB2aXYvZWtzL3ZUdnQrRWwr?=
 =?utf-8?B?dVp6cG44NURHbkNsNmVRYjdQUStMa2JudG0rVFpvb0lxcHFremFEMjZDTGk3?=
 =?utf-8?B?a2g1Ym5ydUd0SEpLdHJ5ODhlOFVRb2VhZjdFU3Z4NDArbUQybUx4RG92T3BB?=
 =?utf-8?B?Y1FzQjI1Y09hNXZwUUViU3QxUzZvNTZHNG52eUx5aWJSSjh1ZWNjVHkwRjR0?=
 =?utf-8?B?eFNyR2dlQlVzMCt2ZDJONFdYZkpmYU1nQTFYYzRQYjlobEduMGNVb3NxY0pS?=
 =?utf-8?B?MnErUEFVNmYxWmZYVGlNOUdrZWtjVC9TTGxNbHNORjE1aFYvcUJIVTFWOEEw?=
 =?utf-8?B?YjBwNnhBTkZXeVYzUFRsUEJWTFpqTUYyQURRWW8wV0lPZ2doTkpLK0UwcW55?=
 =?utf-8?B?VGJ6bytoZXVEVFM2ZnBxRGRNNXJ5cDFqcHZ5WGl5dnFMQ2JWQ2J2d2JYeDgy?=
 =?utf-8?B?akNoRU8zZnRPUVZVZG01bW5MWnFoVUQzMnNPcmtITWMvV0FxM25IT2QzOTR0?=
 =?utf-8?B?dXA4SU5jaEEvbzk1SUw2amxLRE9jOHNkNnU3ZUZUM05RL1FpbG11aFJUYXA2?=
 =?utf-8?B?ZThpdlVSVk8rZjVKcHNLL1E4M0o2b0hzT0Y0YWROelZhSDJqUmhiLzYyVGE4?=
 =?utf-8?B?WER1bkp0aDdLejIydTBYL1ZjMng5ZWxZV2hySHNwcUJHeVc0MTlhWUNrNjVz?=
 =?utf-8?B?Y2s4VytDT3FnYVBWNEpYbExNYndYK0U0T2RYSitxeUNmRHJSTGlBa1Raa2lU?=
 =?utf-8?B?WnhLUEp5dkM4OXQxMUt5MmtRNmVMSTQ2T055NWJRdFQ5amJXSnZYTFE5MVk3?=
 =?utf-8?B?WE5naGlDcjBILzlPWWpUQ0RUWXhwclUxdkFqZUEvcEN3MlVpT3BGNzJVVjVq?=
 =?utf-8?B?TzJ0R1hlVmRzbGVybmtqK0hmSi9BMng1MDBibkVoaXBIZ004WGRFcDBZekZx?=
 =?utf-8?B?aVRpQmtNakFtQmVISExNNjExV1ZyWVBRazRFTFpqaGM2L056cllmMzkrR1kr?=
 =?utf-8?B?QVBPOXVCVmZxMUlQelN6ZDdkNjhZZEo2eTV3OUpCQjBOUlN3YU56T1NkbTZl?=
 =?utf-8?B?MmV2My9BNk13eTU1eC9DQ2dUeFNxSklUYmZKeXg2MGhHa0w0UUdlZ2RuY3pC?=
 =?utf-8?B?RHpmTnArZ3AzSGxjbDNLNHR2dkROTzQ1dzIyeFUvQzFDOEhscXRPWTNMMGxL?=
 =?utf-8?B?YlhIUmozY2tDRFE1ZWJPejl0ZnBGbUVDd2NHSktidUpza2NYTzBadFZCWmU3?=
 =?utf-8?B?N25VVXNFZ2tBaHpMVVQ4eTVjelV4cVZEZ2xJOTk0eThzWTFaRzlUaGE2VFVt?=
 =?utf-8?B?ckw3d1RidzU5dEc0ZjBhOEllKzh3bTRYWW5WcDJBQ1pyU3VmSzVKaldkRkdX?=
 =?utf-8?B?dkhGRk1mKzgwMWM2Ym1MZG5uS2FUVW1kemdYakJ2blVsb1BsdjRWZVhWMzVj?=
 =?utf-8?B?czlleGppVjZTMWd5ZzJ5UXpoSFFTUG5xVFBFL0hOdEZ5NFBWY3dqRmhnRWQ5?=
 =?utf-8?B?aVRLQVpyaU9DV1I2VSt4OW5Dc0IreHFZdkdWZE81RlFueWxYQ25YVlVwdGp0?=
 =?utf-8?B?eW40dWxyRkNORlRZakdxVGdUVjBJeGp3am85dUJ2czg0T3p1YjRqVXE5RG1L?=
 =?utf-8?B?Q3VQdm1MYXY0WElTaGM2dzdZWjdoYm1lWkNvMVA2a0JPOW96KzZveFpyVGhm?=
 =?utf-8?B?ZnRKTllxSlZSMXFRSURuZFQ4Q1k1b2RqbTd3QVlvT0pSZytsZFgzZ0dKNUZw?=
 =?utf-8?Q?OBF/CQmGeANTc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0QvT2x5N1d6VnY3V0FpUE5qd29lQkVuN2haZmdpeDdES2VTSTJNcnRxL2pP?=
 =?utf-8?B?U3QvS3N5T3ZXWGRHOTNoM05zNndYYlF0YllxandoQ1p0NGZTM1JoczNXMnN1?=
 =?utf-8?B?ZXh6YWlaRWxLRTRYb2pRdFJDQnI2c0JIZlBOWWRzRG5jNW00Y3RCVGFDeTRm?=
 =?utf-8?B?Q2RYT1FGQTR3SEZUVXBkdElHb09aSk1IRFBlbXJsKyt0NHptVlV5SnEvamhW?=
 =?utf-8?B?aGZDbDJGdVpnRjV2T3pwaDIyRElQaWtHd1k4OW1oNVlORXNWTXZIZE9TaG0r?=
 =?utf-8?B?aFNCR3BkMm1nZHlEUnQxYU9RYWNxbHFwVWhGamY4ajlXRC9DVWVnaTFLWm9r?=
 =?utf-8?B?V25UTzluMmtMSXVFUXYwWmI2L0g1RjlLTzREUmFCVzF3U3dLWDlFKzg1YmRB?=
 =?utf-8?B?aFZPTFYvNzhmRm81MXhBRHZIWjJaMjNxcHM4ektmdjNTYmtvaUdlVGQ4VUc1?=
 =?utf-8?B?NlorMERsMHlrUE1neWJmQmZLTTRLRDFXdGVtMTNvbDUwMFBJSjlWQkZETTFH?=
 =?utf-8?B?bFZ3Z1EwcUU1NmtEK1dSdVBta0Y3TUtpbW9wYlZrK2tXMU1ZSS9ISDdseDdP?=
 =?utf-8?B?Ym9CR0JUeXpjYS8wOGJEaUxGNVBzTTlMNHA3UUJ0NW8vWm9CaUVGeXNKWWwz?=
 =?utf-8?B?MExDT2RXa25zNnpmbGJvdHV3bDhhVkZ1c1BydVRxZWJjNGwrTkpseThCbzRK?=
 =?utf-8?B?Mm5nQWdLaGdWUHllM1lXSmx4MDVLRUR3NS9INVdXSzhiRFZYY0QvVXF6UmFG?=
 =?utf-8?B?U3BvYnZYeGhaaDB4U2psY3NrUDA1ZEcvTGVvV01WZHNWdG5DODhNcmwvSnJp?=
 =?utf-8?B?L3pKYWVXOVppU25QY3RsMzlZNldieHlMUEU2K00rczVsZ1FvdDMrWmZwNzBk?=
 =?utf-8?B?UVd1anM3SFBvNmd5VWZvT09tb0J5RkVzWUZrTW1aUWo1MjVPYStJY1FSM095?=
 =?utf-8?B?S0tCZnNzeGNMMmdYU25rczdxQjZqTlhtRDc2Nm1UOWZxLzZkT250WnY5Y3Nw?=
 =?utf-8?B?Nkp1ZXNNK1JZd0NCZ2ZjU0l2RTBMWW5XUU1kSmVLR2F0R0xqYkRNZGpyRDM3?=
 =?utf-8?B?cnlwN3NMcVgvcS9EN0xjclRKenk4WTUyWldEWUxwbzMvMXdJVWJLclpyVTZq?=
 =?utf-8?B?aWJwdys4dlRjYXZTM0lGQTMrKzY4eUxhSUNyN0ZXRHczd1pRNmQwcXZiMlRF?=
 =?utf-8?B?TUgyTHdkWXZZQnFaTXJCbnROdDJKRldsbEFWaHF0S3lmZ3FJOEFZdmlSYlFz?=
 =?utf-8?B?Z3kwZmIycDA1M2cySUdlRDExWlR4VU53bnk0SGNucVFmT2RaMDR4VWpDS2tN?=
 =?utf-8?B?L2E4L0NpM1hFTUhucGoyVEpDWWxZOFllbHhhR1JjNWZxV2NKSUZuTG9ReTRx?=
 =?utf-8?B?Z2JDVkZ6N3ZJcUpHM255R1I3d3pVVms4QTd4VjNzWlk4dU56RU1Nb05ncmMx?=
 =?utf-8?B?Q0hyN1QzUkhlUXBoa2pYV1pXczZqV0tRdmZDMEFLR3JjcHVNZkw5QUs1R3FB?=
 =?utf-8?B?RXdWZ1BPZVdaWVgydkFZbWJSb0UzdFBoeXVsYmhocExZTVFEMVRGVnkreE8v?=
 =?utf-8?B?YXhJMXpYekwyRFBTUVlaTUJSRURHdHJLSWU4Z0UzUzViQ1FCb0ZJa1kvMEV2?=
 =?utf-8?B?MmtLK2FXK256dVh5VllTOVB5SnBkU0tDbml4MXZ2a1V1LzdFbGJudmVhQmI2?=
 =?utf-8?B?WFlvRWNlM2p1VDU2SjR1TnJZZDZNeS9ibEJVZWk0eWNHUS9PbUQxODd0QVEz?=
 =?utf-8?B?cS9ZcHY5b2Nzc2F5ZHJleG0xMjcvSFl1dkdlazdyekxmQmM5VVV4VnZxTzBB?=
 =?utf-8?B?T3F5bUdyMVRvdXQ1MFBBdVRJTU9OZjNoRFNmV2pOeXhDYjFsNnArSzFLMUg0?=
 =?utf-8?B?OUcwbGgra1RRb3k4Nk5yNGhJd1lIenh3SzFGbHpTUHUvc2ZPMFZHeWJPR21J?=
 =?utf-8?B?b3BzTklURjZpTVdNRHMvNFd2ZnQ4L2luV3VKNWZHTDdXVGdFbWRTMHJlaHgv?=
 =?utf-8?B?djRBY2EzRHVtc3AyQ3h6clUwcHg5eDh2b1AwV2xlVHREV3JOTHdaQkhJWHJn?=
 =?utf-8?B?OGdsR1M3TG1scEpIUUpmd0xaL2dhRXllQTI2Q2E0bWxzV0JDVjRXUzBHRHlV?=
 =?utf-8?Q?4KHv03/jmAVkOr5r85C6lNRHb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e5e204-887d-4a60-d5a8-08dd5cf28fb4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:05:02.1077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClMR/a/QJvZaPSDY+0PfXoMlrlErnrN0bjZ9ftumusbNEsT+ZZ/C2M2QWFFni7AJ+BopifPE74Q/xr27QKBXGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7237


On 2/28/25 11:58, James Morse wrote:
> update_cpu_closid_rmid() takes a struct rdtgroup as an argument, which
> it uses to update the local CPUs default pqr values. This is a problem
> once the resctrl parts move out to /fs/, as the arch code cannot
> poke around inside struct rdtgroup.
>
> Rename update_cpu_closid_rmid() as resctrl_arch_sync_cpus_defaults()
> to be used as the target of an IPI, and pass the effective CLOSID
> and RMID in a new struct.
>
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


