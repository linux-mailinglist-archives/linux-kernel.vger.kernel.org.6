Return-Path: <linux-kernel+bounces-549887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8837EA55837
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B97117A69DD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65325207DF0;
	Thu,  6 Mar 2025 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oX9fMwgK"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CE01FFC47
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295052; cv=fail; b=ekWCvazxNDlawh9tH9BZBhba7KNtA4gb9TjwGxsC+VAYqbISwkEr2XtVekPAsPcUI+bhHC0mMC72gi2Bg1VvdImSiS8NSMMUJtlTzlksj06XA9qMtrpcXzCWEETMlGf3+FHlgxzhgfDEEzOgEs3zEFDHBxdcl9dfFNGN69M1FII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295052; c=relaxed/simple;
	bh=hwCVobVsaoMRhNe9kGT61Ag6UbkY7N2B1Avhx0C3hZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OxyEUpMdLqMKpreJHVD+1PQvmm6f0OrA0NQQqDd9/VMfZbYpyRAOriiRvGKdamm8i+gcMcnuAvaxDHoOFK9TwLgYOawC1TNBnFZaPOUyFRePrkTi18AjK1P4oVHkuYkCZRGP8bNTGq4VJsLC5VBzsn/J3wHlpx0/WFxEELTFkPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oX9fMwgK; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bm0Va2cmvxvhMIeG8uEjaOZFDDfayHts5LFJYLeiaAaD2+KUz14WcMFYzffKCGUsTkKbOpr6g2im89lrXh0ZNvfGF7QDEEA65VzCULGwEL5C9n8QIyZGSplaqAHD8w2XM7WTt6wP+SMkJ3nYUAXhl1mqmn7O5empBebMsmCKnXXks/RLIiVomYbC7zEQtk68Ebiwwz7sTF8NEWh5BH0Kqth5HyaMdKGyEVpa4kqR+Fgjbj0BNdZ9vvqG1i4DGjoBqPL59eJdp9NN2PeQioezHXxCDekrr+L4lndv+JoNh3iJDjG4OjJh5Uu9xe8tsFy3dfZNNYtlTqw/tTIesWuu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwCVobVsaoMRhNe9kGT61Ag6UbkY7N2B1Avhx0C3hZQ=;
 b=YpCHR/MIzlPxGfc6h0OubGKsxdoJU35pTIQH4v9SoCRnwaMuzzknEuj2+5vBCIZke/34zGj+wDA/lwMUkAkeFfpKUZGVjn+zfBFAXTznSR1//+nOFRh4GOi+6CMfgkP8myEZX1+DKoFHKBceWP2gLSLa5RsbDzVy2BrUmkIKFdhCUe2g1e/XwAVS+eurv+PjQ5RGs4IXw1lZVM6iHL5H1tX9mLXRxA8dHRoejjUtLL1S+bYReIuhIkbRAXpy6wwAqpicIS0f+MJnyvrhWWaJBS1x9esrvAvKIUb+ZoBdPQ4XH10k3yXvg1W4HWj6HkX5KevkblSD1fugdrA4MAxeIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwCVobVsaoMRhNe9kGT61Ag6UbkY7N2B1Avhx0C3hZQ=;
 b=oX9fMwgK4VRT7EuCI9m6grA3NM30uer00Ktl9Awg/3LNr5WQc34slBfoc7Uaa7CXGAUvp91MhocRsCMnndJkt8YowhaGKtHwn2nuRJKmfrg++HvBbF8HlL3N/p+l+yL5T4DxfjlloQpWwfXV3MnaoET+CkR5tE50boV0NZ23aAKVoZF0THFkO1ueOzdAer5xrLE1lDdVunEqJBrXCwXv7AMXtH9Y85V0Vbgc07O/RmbGXOELmv+8lvUDnlW4aqRXWLDsS3C+kBwEIbcOBIhH10oNZ8f1QBiWb04R6XKv/IHaWQF6Es+SMwC19G2YhmdyjhlQc1boogsQOqjm+bzZZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:04:08 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:04:07 +0000
Message-ID: <c718d066-507b-43ee-b3a3-7b7f0e387fb3@nvidia.com>
Date: Thu, 6 Mar 2025 13:04:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/49] x86/resctrl: Generate default_ctrl instead of
 sharing it
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
 <20250228195913.24895-9-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-9-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::26) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec54d46-5bd9-4d5b-9181-08dd5cf26f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTdhR29ob0VWUVM1UnBidWcxZ1BISXZMNjBXenZlRzRrSDlJazhpV1JEUE1B?=
 =?utf-8?B?Z0FoTjA2T1BEMXFyMFl5K3dpUVJnbGJ4WURlN2paRzVRS1AxT2xhSGRsNEVl?=
 =?utf-8?B?NkF2SE5VRytwdlZWYnpicTNubmhTWWdCLzNWcVd3YnpWUVAxcDVKUk9ybHFN?=
 =?utf-8?B?TEZMUXpGZktkNk1nRlM1U1VlZEd3Z0xPTFZpNFhsNnI3MnFxODlIZjZWTEpO?=
 =?utf-8?B?TFZaMUtwZVpYY0hUNjlLNm5RR0VFQW1JRmcvUWtkSXQrRThLaU5OaklRZjFG?=
 =?utf-8?B?bkZWYVhOVTVFOXJHRWkwRGlia2EzaEtDcCtWeUdoSWlrRHdoa0Y3MGI1N0da?=
 =?utf-8?B?MGVyeDRiNXdFSWJRM1dCKzc0Vi9nVy9SRElJRUhmdmQydW5vcjg4U0VBcUYy?=
 =?utf-8?B?TGNsWTI2NlRad244T0lXWTBKNlM0WTl5c2tDdlFaRTBpR3hjVlJ5KzBoSDF4?=
 =?utf-8?B?NnJORTI3TEJDQUlyUmhlVHlJaVRjeFlBaFNTTjBSb2RGT3NvSXpBRnFxU2dC?=
 =?utf-8?B?cXFQcmltdGtoR0dDSzhjQWJ1dzl1TDE1YzRPbjk3T2Q3eXdGSlJqWm55RlB4?=
 =?utf-8?B?OHRySG1OSGN4TitYRWFNV1hwaVZVWkZhNG11SVdzYVppblV6TmZDL1RrcTBp?=
 =?utf-8?B?RWd5c3MzY2Vrd2dTQjBtVjJhWmhrWUxkbWhPcGVycm1PSmIvdmpwTEtTSWhp?=
 =?utf-8?B?UUtvb2o5dkFlaFRTNzU3WmZOdGkwSiszOFZCaVU0bDlVOWs0bFZDS2JRSUFJ?=
 =?utf-8?B?UjNNNlFmMytZRGY4TVFkbUd2R0UvUFN5bEdONXdiNGVnbnpZVWdFQ0RFMmF4?=
 =?utf-8?B?eEoyQXVrcUVPRXM4aG5jN3NUcTczMDhqVlFzb2NOZGNBeXVBQm9MK2g5T0lT?=
 =?utf-8?B?SHdVQTlLbFJwYk4weUVrSDVySmJTUDZZUkJDTU4vc0w2RzFFQnFaSHVEV0pR?=
 =?utf-8?B?cnFwM3hWM0JDcm9ndktodkNXY1BRN25Mc0NIYjZvQ01nejNDYk9uRUdWNDNS?=
 =?utf-8?B?SHVBVzZ4NlB0Vm94b0plT1FCd0NvMUF4U3luVU81UlpwTjgxTnVBQmw3WEVT?=
 =?utf-8?B?N0NOOU5rd2xYQit6N08yYjYxczJKRzNTMUtuU3MyOFNRaW9PamVZNDZXZDd4?=
 =?utf-8?B?VXo3VC9SZGlnMEZzUmpCU0dhbXdnOXBvYmt5cVphQWVWbjhPT1ZwaUgxNDNQ?=
 =?utf-8?B?dW1ucGNWTnFuaXdMNkZKQzVVc2YxdkkwZUVRZWFkOW1IS2haR1I0QkdOZ2Zm?=
 =?utf-8?B?SmZvZnRSYU81ZmpCeVlGcnhIQzJ1MnFDcnVwci9LbVphSC9vdWdpOGVjOEsv?=
 =?utf-8?B?ZE5qT1JEaWZTM0E2NS9YWVZuMVkxR0swUlpad3A3ZXlDMTlxUzZRTTE5NjRv?=
 =?utf-8?B?K0E1SlFRRHo3dC8rTDVSNnRxTmF6S1Z5RkR3bFdNR2RMRVB5Rkl1QU5GOVdB?=
 =?utf-8?B?Wnc4L21RaENqc0pFV1hraXgvRUpCQXNrV2QrUURjQ0VoVERnZ2QvN2k3d3Rm?=
 =?utf-8?B?RnhaUlZkMkdxYytYQXNtUUNVTzlFblViYXVUbXY3YWtTYWRQdHoxUTRsRWho?=
 =?utf-8?B?OTdqRFVKQzU4REpFblQ0ZUZNbFZUalY4L2JSQ2hKVDdBS3U1eUpTRGRIMjZw?=
 =?utf-8?B?bUJaNEExWUZseVo3RmtudWN1VnNIaGtvV3hBQ2tkaitranczVzByR0ZrQUVk?=
 =?utf-8?B?UFUxRVFGdGVoL2ptNVppSkZFTnZSUlhLdkxOS3B6NCtDTlpxMitMSXJmSjk1?=
 =?utf-8?B?Q2tlbmFFRFhUZGJSMS84UDlOdy9iUEtnbEpYU0p2K01qSjl1VDhHNHlzR1BJ?=
 =?utf-8?B?dmNIVHFGWEZ6dDJSMHhBWTE1aXFsOE1QczhzMEgxUFdiZkFTcXFCdWNMOEV1?=
 =?utf-8?Q?WRWjb9zb3NdZR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHVEbHpLYk9kVTJ6TlN3WThRNnJWMlg0c3pWMFBLVnhkYlVTQkh1OGtUYjVh?=
 =?utf-8?B?MWR4Y21VRkxDREZuakFtNzFZSDBKbkNNbVdLakVhMjZ0NUdwRGFTb1pjY3Vs?=
 =?utf-8?B?M1kxVzRXUHhybFZ6TkZ6aVZkTUdTdlhmRzU4OUI2UTdCSjdwQmtUR05hZTVN?=
 =?utf-8?B?SERpS295ejI0RkJxSWlOSUFndXFDNkphRSsyeWE5L0hKSmovSktwbnBWclVq?=
 =?utf-8?B?RHYvYW9SVzB5KzRQL1A1ZWVTVUtENFJud1pMcXdqSy9nazFkMUpWUWkvNUJY?=
 =?utf-8?B?bkozeHFJZ3R6UXdMQ0lPazFVbGFCNmxLZTZjRmovSzNIWCs3UVEyUlVyYW53?=
 =?utf-8?B?aHhmNC9OS3RhTHEwMnk5STRRTlRrcW5UaCtGaHB4cHpYWnNuV2lSUms5aE1r?=
 =?utf-8?B?SEhucXFJbHE3YXdsT0hqMGtyRkwxTW1FUktRZ1c5SERId0Y2NjFBT2FaVnFi?=
 =?utf-8?B?ZjJqR21JVTc5WjExenp6MXNrUnJWbEVnU2VoU0wvUHh4TlY5TEtFQytGVlUy?=
 =?utf-8?B?YXloZGYrQUtORWJVVmNqN2Q2NkNoS3dqZXNPc1kvZzJkcDNENTcvQmVpZ2Zo?=
 =?utf-8?B?WW9uQnZWblFDWDltMTBJc0QwRVNHck9uYzh6ek81SXhwN2kwc2ZxZm1BbE5T?=
 =?utf-8?B?RGtnbWtMK0RpWkhOa25UQVJuK2hRQmZPaEFXVUJjaVRaVmsxdUtSM25McGxQ?=
 =?utf-8?B?TEttT3Z0MFVzeWJIZ1VScDFZckNTeW8zSG9mSGhxV2FsZmR2S2NYNlVOTmE2?=
 =?utf-8?B?dUhnREVqUEUrdHRpT3lpa3hGWXpEUUhBakJZenFQQmxFWlB2WUlQbGMwUVdM?=
 =?utf-8?B?NWI1WlduRDJ3THZxOTBnY1M4YnRxR08zWTBMMFV0SnhEL1MwWnd1V2V2YzF1?=
 =?utf-8?B?NXZsbHMrL0l6cU9JN0VjZWl2cW1aVldVL29iOTBTQXMxbERRRE1LY09BQXRD?=
 =?utf-8?B?OGxGUUJ3alExd21wYW4zenJCMnVGSUkxZnJNc1JLTWJURzB6RzFKakJSZU1V?=
 =?utf-8?B?a29HZDExY0RJMzZjZVQzOEZsckxnaU1mbVhSbkdxT0JaUXhJMkhrSDhpN2Fa?=
 =?utf-8?B?Nld1RjYvcjhYUVJGM1VtQTRqU08rWWxoc2tnTEpxWmp4bytJS1lnaENrTUVJ?=
 =?utf-8?B?MWlWdmhDRnlCRzl3K1RMSDhGVDUzamlBNHlJbG1pWkNvZklEY1ZscFZpekxa?=
 =?utf-8?B?dzJTT212R1A5eGJUUHdLdVpzeGtHTHViOWxjMEhFV3ZYemY3V3hmQ2tYbFJ5?=
 =?utf-8?B?NkxOcHlkcnNZZHdZSmdaZGNvdzhCSE1lMVRid0VGRVJtdEgyQTJJcm5lUm9n?=
 =?utf-8?B?VkJ6bFpqUGQ2bnppaVlBZ1hydFNxdHk2MDlqdE1tS0JpSmFrT2owTVVRRTc1?=
 =?utf-8?B?LytFM1d5bGVzT3JNQmRpTVRxOHBjby9VYWREQ2MvaDhpSHNKTnAyM2RoN3JF?=
 =?utf-8?B?dzVCcEFzWFkvK3k4anJ5YzRCNTY4Tjk3NFhGQ3hsNW9MOFNtMCtLM0JVQmVj?=
 =?utf-8?B?Wi9iaW9JYUd4N1ZNTFFjTUtkcHhuaDVTNm1pdlpGRHYxY09ibHUwVjdBbzE4?=
 =?utf-8?B?UFdrZ3VGS2RvSWpVK3QwMTFnNisxMmJ0WFpabXVxWFpZWWh2NXZ3cURzTHNL?=
 =?utf-8?B?VTllaXhaQTltdHFINXBIaGFVSnMxVndZY0JOYURLcXkvTDRsQjgwTFN5YkJH?=
 =?utf-8?B?ZnhqT0JxNWRERXJ6aGtCa0FQb3RGSXlhK1Y4eGJnSDMydEgwTU1sbW0wYnVP?=
 =?utf-8?B?WDNIYkZtOVZIcmNSU3NKUEhQYno3S291TGZBemZhUzNDeDYraFdVRlc5dUpz?=
 =?utf-8?B?d0hWL1JNd2JTQUxQTUJlcUUwTk9HNkFtdDErdUIrN0RoVEJRTnpxYWl4SnJq?=
 =?utf-8?B?WnhyVHVHMG12TE5xclhaTEN4cDUvWE4wU2ZLM2k2cEdqb1NVRkhGN0c0b1VV?=
 =?utf-8?B?KzdjVDZjQTErR05YQzhtRzJ5WGFmOUZncDRzWGIvY3hmaXc2Rmh0eEIxUmFj?=
 =?utf-8?B?ODVOYlF6TElFaWI2RE56Rjkza0NRMWpkYUFnOWFNMWF2SlhIb0dHZ2F1Mktk?=
 =?utf-8?B?M08rNVo3TEIwTlJ5TFBhRk1CZzNGSnFLUWozRENnR1BTVWw1VGJuR3RPejh6?=
 =?utf-8?Q?MeScyxNjhOjhNIIM0puG8rUb/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec54d46-5bd9-4d5b-9181-08dd5cf26f66
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:04:07.8878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rSQ+qsGP2bUhzW2IMSHJabKS9vAsg7v2I3Hj94PIZHNuKgyl7kNP4qU4cDa7MZeuLHShIqGcuJYO+1KI69Yxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662


On 2/28/25 11:58, James Morse wrote:
> The struct rdt_resource default_ctrl is used by both the architecture
> code for resetting the hardware controls, and sometimes by the
> filesystem code as the default value for the schema, unless the
> bandwidth software controller is in use.
>
> Having the default exposed by the architecture code causes unnecessary
> duplication for each architecture as the default value must be specified,
> but can be derived from other schema properties. Now that the
> maximum bandwidth is explicitly described, resctrl can derive the default
> value from the schema format and the other resource properties.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


