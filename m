Return-Path: <linux-kernel+bounces-234975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A3991CDC8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 17:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C726E1F21DAC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 15:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7C48286B;
	Sat, 29 Jun 2024 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zcbfa/16"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C0A101F7
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719674193; cv=fail; b=Q+0ufjC3WjqwHiIxflx53FFAbxNlPLM4vgvoC2QaBOFqbxVcgvwyHMwbOG0GYNlWTt/TXauXUczeBHSHJKP5MDSBgVU2dcDgy+IdrZ/4Bx5jf2931NpfsEjeVbcqRWWmqsmGrmTVxqGzYQh/2wz8A2L5XdWuHhKkqC+6ngSbw/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719674193; c=relaxed/simple;
	bh=xdkQK63nnHMeMnw48kAEcuvNVRds2ibabc/mqIiRNTs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nFYy9JVXgR5/ErfvA3Zm4aprMxcxncV+ElGJrVan4hueMlhVj978lxLtnYjtLzmvI8oaqXPWLdcIRy4Rfa/SiGMZwwDUCp0oPitYSojoycDPJpMf6ggpx8g1xqqBjzQiHaL/SP+lr6dXOploqAIhCdTnSPa3JDckAjKZl+PmrcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zcbfa/16; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFmVVKdDjoViRbcUsuVXaJZJXtWYc3/r9xtijNhLltUshZNsCCOOG2sQZmLLlETkACAoQJF3nS9rIp2Rp5uKARME56TriwvR9hqCRGhMofwAuOha80eqZEHvmGYsZECaOFQC8Kq+wls1U0iKNykqhDlCkS0meU4PwLBhZawxMK9y/xS9JcehzcJuKWZS9s7wdC9xvFYkCUe2id0iN3eLGWfldnozOVbfGkfa0AmHyAx/mukYsvP7dqn3L+mrt4JLz/wWSKsQZVo9lnC94z1xZBaQygNjazD282rRij5/ANWPDd2imSX2zLUinEotxpK3mBp46zk3Pf/UT+PyNwioHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNrIfILvfdirqSsmU9Eqv/fxsvY2V3sVn8zfs/9cTNU=;
 b=AJvJ8hh343JG5iBL56Ko8BVPeGRmU0qCGz/HDTEAIqx126CQRmX+PJeEtkANMGdVPT8fzJ4STAQJNmw/1+RYkkRbX/hBJt7qSTPC0oSlGCLbrGjHjR+0LUuHDJDGKMT7vz2cbMKsd3EDMjiLRvIyW6QMLvxW/Hr8FZE8Ll0I9BPC2IX5wUzUia037OS/pTIkuchMPGRPY4x1rW3JkHxTEUj//B8S8XtGd528o/qb1FEB7TWNs2OeUT/HcVMhFAoz1k8QZfn73YbJfBLHwRTnfHbhLrM98oKChmGWq2dM5ZOf1Ng2Bmmw919TjXfpFTKC/jo7CPnG7ApIhhnFYD8T0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNrIfILvfdirqSsmU9Eqv/fxsvY2V3sVn8zfs/9cTNU=;
 b=zcbfa/16edr79KTCiWWABw9lomgb0yz2ydSvUzZPcdLFJNNxWpEIDR+vNMEXLFvOtJsJNu+2vRhFq8P7GWwPOl+krGYhaiwySjaPJ9pyAMhMjpwTuiF0DHFLaa8QT+B5dHVVrCqPjxZL66TyR9J+Cc69XiMm+seCNIZ5PELRg/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CH3PR12MB7499.namprd12.prod.outlook.com (2603:10b6:610:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sat, 29 Jun
 2024 15:16:27 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7719.028; Sat, 29 Jun 2024
 15:16:27 +0000
Message-ID: <76d96581-202c-80ce-eb26-8f906660c8e0@amd.com>
Date: Sat, 29 Jun 2024 10:16:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/mm: fix lookup_address() to handle physical memory
 holes in direct mapping
Content-Language: en-US
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 Ashish Kalra <Ashish.Kalra@amd.com>, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de
Cc: x86@kernel.org, hpa@zytor.com, kirill.shutemov@linux.intel.com,
 rick.p.edgecombe@intel.com, mhklinux@outlook.com, peterx@redhat.com,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, jroedel@suse.de
References: <20240628205229.193800-1-Ashish.Kalra@amd.com>
 <2982a4f2-ea8f-4fa4-81ea-d73c00fc2ad0@suse.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <2982a4f2-ea8f-4fa4-81ea-d73c00fc2ad0@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::25) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CH3PR12MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 125045c6-6d88-4fbd-d4a0-08dc984e7218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVRHeWIyZzN0cUlVV3VMM0pKZnBZSitnOTN3NDNNZWNvNWVBS2NaVURncEVS?=
 =?utf-8?B?UjZXVnNIMkpKS29KNWp0MzBEeGxtbFE4cmJ3S0F3cUdRWW5meDBTcm9ia3o5?=
 =?utf-8?B?NkRnSWVKSUlZN1hVSGo4NGRsdUQ2eEdtTDExWVZDa2pZT0QxdGZ3eXB2VmU2?=
 =?utf-8?B?WmZKQkVzTXJVY3BSSEVlVzFpNFJpYVVHcWNXeTZOaFFDdG5SWHNwWmZYeW51?=
 =?utf-8?B?Wnl5UkMwZ2JQZHE2VC95Sk44V1ExMVJFQTJJTUgvdTNpd1pSZWZ6Uk5OZTEy?=
 =?utf-8?B?WUtWVUc2ZjQxWEdTMzZBN25SWnNpaitVRmk4d0hqZWJVUnNUa2IwVEM3NEg0?=
 =?utf-8?B?SjRoTzVXY3ZsQTlzZEZwY3pPV2N0YXZsL2Y2WERMYXJSK3hvVmNiR2haTzZj?=
 =?utf-8?B?UVNhVEZkNEY5NU5sdmkwTUNWWlJYNUQyb015U0VMOWNMWlVEUFFOQVUwSnBN?=
 =?utf-8?B?dWJGOTdhOFRZNzZWY01VM0o5aXZHS2wvOHRvTGt3MHlLQTJwMTZjaUs5cnpW?=
 =?utf-8?B?QmtoY2tPSExGL2FnRGNJWWxjeDJ4T1dzTW5oc0pFMWVzOExPaCtpdGhxVHhn?=
 =?utf-8?B?WmpiRHM2Ynd4aWVQSUlJN0djUUgzWjhsQk9aV1NPUC90NWtrR2dnajZrM0NB?=
 =?utf-8?B?dHRCSUpYbm1OSFpkZU1OUG1qTUxOQk1MY01lQWI0SHZpTFlwTzllcXFYYTkw?=
 =?utf-8?B?TUZ6bXJBVWhuR29nZkwzMjVOUmZqRXNhSnBMOHlaaWMrQTZjWERYUVdZaUFt?=
 =?utf-8?B?OXh2blp2OFBwdjZiNXBpcnBiMDh5SnNHQmtKUVJQazdKcXZDUWt2aTRWTzdG?=
 =?utf-8?B?NDFTTjFjdzZVWGZSdlNCUjQzc3hQdjVZTHUydkg3dUV0d09tSWNySXhmYkJX?=
 =?utf-8?B?QnBoVXBnd1VtKy9tSG0wZThzNFpJOGV5dXNoUFBkNjBha3JRR2dBYVh2S2ZV?=
 =?utf-8?B?b3cwZVFkcVpHbWxha1VkeUljMDFaMzRib0pmUmt4TC8zZVB4ZVpuWlhHcDVB?=
 =?utf-8?B?eEF6Sk1obGE5cEt3R3E0aWJ1WDdPNWRUUVNTcC9HRVZsR1hieHQ4dUdyOVA0?=
 =?utf-8?B?bDYwek5KVWozRVBROXVZdDBDSlF4czIyUWwzVXo2NWtRbXNOMjNmUFc1MDdC?=
 =?utf-8?B?Zkp3cFQyMStOaTdTblFodHFWbDFZUk5nWldBS085emh2VGZ6OHM2b0sxbWp3?=
 =?utf-8?B?aVdCVG5tM2hOSDRvTnZlWjBDSkdCMjU5MDUwcWFLRkU1ZmxLYnNIRGxROVBZ?=
 =?utf-8?B?d3RXVmdMVU4yVTF2VHhRNGIwUGlFRm9RVlI0RGkyR3dTelE4V1FTdEN1SWlh?=
 =?utf-8?B?MDhRamw5MkxvMW9Fdlp4RUhnOUF1WUNuVU0veStjRXJCeE42RWRISDd3a1Vi?=
 =?utf-8?B?TVZvWUZuTEhEN01MWElMMDlqdVFqUVhLakxaVGpVYk52UU5YZE9KQkg0eTJn?=
 =?utf-8?B?RTNUVm8rOG1Yekp3a1kvY0xGWDk2K3FpZXhjclBsR1d1eVkwcjRPVi9DTENJ?=
 =?utf-8?B?dnNLdFBnZGIyV0hqRSthYlZ2aGs0Y0lpbTJHTjhibThBK3hUTWdHNEVIbjl0?=
 =?utf-8?B?U3VGTDlVcHJMVHdGUmkzTEtXMVVkeUdUaGdsWThEcVpqN0xoU1ZJYnBsREdK?=
 =?utf-8?B?dDl3OUVURG9DTkpBWFRTRDZqYkduazJXM3hHdExLMVZ5bnpOenVTUStJQ0F4?=
 =?utf-8?B?cnJNRTVkMTlnUVNIRloxNXJLRElXV1VzTDJxN1VOMFNkcHlGRW9rTHNlMXFn?=
 =?utf-8?B?TWkxUXZCdkM0bTZydld5TzlqWmtoNDZLWlFYRjB0WUp1VDZlVUxDbkhFZGFq?=
 =?utf-8?B?ZFVwVUpXTzU1T3E5aWVQUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzgvTllLSm1udDYxM0k1U1dxcXNVWWtweWUzcVZya25CRXp3TEhOTjJvRkVH?=
 =?utf-8?B?TUQwM3FuU2F2MGZ6Z3lzMURwcHFnYkpuSlBXN0p2SFdhRXcyd2lQdjlJOXFh?=
 =?utf-8?B?VjBrQUIrNkUzV0hMZDRZWVdQS0FYdjhsUFgwRWJlaUVIcHVGL015Z29MV040?=
 =?utf-8?B?Q3JaQ1R1TFZFdVBWYnJRUzgvekJmZVpJUFZOejF2cm5FQXdtbGlXZW9rV2Rh?=
 =?utf-8?B?US91ZkRUb01LeDl2eXhyR1NVNllSZU1IUTFUVjVTZUl0Wkx4Q2lqMVorZDN4?=
 =?utf-8?B?QVJZbTVmdkJ0SktwNGhWdVZXWXVGRythQ3I0QVZVMitiWnpYWnlRNnZBaTh1?=
 =?utf-8?B?RytMdGJuSElrSUk3M1l2T25IS2gvN2dicmJLY1kvanBZVVJyQlpIaWFTdXNU?=
 =?utf-8?B?MXJtVFhuR2RlNEp3WXdJd0VQNmNuRVV0UHBPUW9FOXNQd0lKOXdFNnZkendu?=
 =?utf-8?B?bzh0VThERnlwbXpMWjJZNDhzTXhsOGNHV0paZnNBL1NRVDIzMXVWYkNWMlE5?=
 =?utf-8?B?VkFudjByMVQydTMrWmVPYU1qSlB2MUJ2ejZNSE95bFBUWnBnSDFCNG1MNjNB?=
 =?utf-8?B?eVYvM1ROTG1DeDVFKytERDVsejY0WDRuK3dHVTdJYkdUK3cwaFF4ZVppRmRt?=
 =?utf-8?B?SFYwVDdOYkQvZTN5RzlZemlPMFVISG1GUG1HOTRLRlN0TG5FWjdkQjIzUGFj?=
 =?utf-8?B?ZzJtd0RpZGhERnBSVFp0d05wR3BFbVJ0SVVkY2JJY3J4Z01Wb1RmNWtYelBE?=
 =?utf-8?B?bjRxM012bVNva1pIYUVKemtsVTZFYmRLNHd1VUF4cDJ5dzdQcHcwdG5EcGpY?=
 =?utf-8?B?S0FZd0JKUWVSSDlrUDl0Z25jdmFuSlVpcmp4cmdiMTFkZ3JYZU53YmpESlRE?=
 =?utf-8?B?Si9OS2Zkc051UU1rV3Z1MGxyOHJRKzg3SWVyQ2F2VTF1K2l6Wm8xbW9CeENv?=
 =?utf-8?B?Ykp3QktmU3U4bFhxYVgrVjVLOE5haitmNXd3dmhVYzVUUkhjSU1pL3F4bVhl?=
 =?utf-8?B?NUZaT28yOGhxVEdJN0JVN05pNS9GTS83eDYwU2kyVDdFU2RYNTYvT1UrWXQ1?=
 =?utf-8?B?NXVkTlJvbDl5RGluSVdSdXlyWmpadDFKQjUrTlVlRE01NGJHRmRRalFTQ0d3?=
 =?utf-8?B?Z2VLYzRKb3lDWElBTmdrZUcyOUpxSEpINlVsVEExK281bU02eUx6Y3VLYVdB?=
 =?utf-8?B?eWdxdXY5ZTIxbU1KZHFSS3VZUWt2MXFpaVVnL3RId1VJbHd5YkNYemRhWm1C?=
 =?utf-8?B?T1JTc0o5OFJZSVFLWitnUGYyZVZFWW15K1B5SFFnNDVPNDdEWDc5aFlaenJI?=
 =?utf-8?B?ejUzc2V4M0ZKcjZ6R0s1TndoajdGYmZJSkhXMkhqUHVjbWxZN1Z4L3F5ZGtY?=
 =?utf-8?B?cWxZbWFYd3BOR1p5K2Y5aUhXZUo4ME9HNUJIWjYyTStsRU1ZNWx2anZ5MDlQ?=
 =?utf-8?B?Uk44TGxUemVxZU4yT2ZUU0lqYTRjNHRqSnRlNjB2Nk9lR1JPcHQ2cEtNNExm?=
 =?utf-8?B?TWFxUlBLTUZDVEd5T21UQVJCUFZCaTROcTBLVWtpM3BpVit0OG9pemt2Ymdq?=
 =?utf-8?B?dmdCNlNyUVJYSHFWajd4WnpXcEdxWGxhTVZxazJiZGkvbUt2YTVqMDF5Y01E?=
 =?utf-8?B?TXdIR1hHWkdaK1g1cGF1R0JQcHliQjZ4QUJMSlRXZkZwcHdzM2k0cnNKRHpY?=
 =?utf-8?B?SUVUY09vVWNYZWwvT05nUmhaVkFLRUlkck9nWDNId2V4VTNRWjdkN1NPMnZO?=
 =?utf-8?B?Uk5yajRXM01jMHpGQWNuOWkyeDlVY3IxZTZvc0NabENjZ2hONzJidElWTnNi?=
 =?utf-8?B?WWV0WW83Uyt1eWV4SnVsMzlwS2owMUpDMjUwdEp5dG1wa1FHaSs2eEFtUTdB?=
 =?utf-8?B?TFprS0RpT0hVRkJrN1BPdUs1QkRGQ2FMaG1TM1RGK2hqZHBHOUczbU4yUktw?=
 =?utf-8?B?K1poT21QaHNCZ1JZVDd2eU9USGxqaUlzQWt3VTU3aXRwdjBlZVNPM0tQQnRE?=
 =?utf-8?B?V1g5RGhnOHNpT25xL3hWeFNFeDM2aTUzdGV0UlQyKzl5RWVheHY0cFNWKy9j?=
 =?utf-8?B?UHpHUCtjalVsSjZYbFBsNW9zVFNTY25Bcm16dlBpZm5FV0tVaDB0WTFXKzdT?=
 =?utf-8?Q?UQVkP7uWjHGY4LD0YglgXJQhT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125045c6-6d88-4fbd-d4a0-08dc984e7218
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 15:16:27.0214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKmzBoDWasmERyl8PB6FqKMGfhQtRhG2KUxz3fRQp8wHIqM620V8aIzEBIOxaHZFW4arOSc+t2pZ0EN5A54Ogw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7499

On 6/29/24 05:20, Jürgen Groß wrote:
> On 28.06.24 22:52, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> lookup_address_in_pgd_attr() at pte level it is simply returning
>> pte_offset_kernel() and there does not seem to be a check for
>> returning NULL if pte_none().
>>
>> Fix lookup_address_in_pgd_attr() to add check for pte_none()
>> after pte_offset_kernel() and return NULL if it is true.
> 
> Please have a look at the comment above lookup_address(). You should not
> break the documented behavior without verifying that no caller is relying
> on the current behavior. If this is fine, please update the comment.

This brings up a point from my other reply. The comment says that it
returns "the effective NX and RW bits of all page table levels", but in
fact NX and RW are not updated for the PTE. Since the comment says all
page table levels, shouldn't they be updated with the PTE values, too?

Thanks,
Tom

> 
> 
> Juergen
> 
>>
>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>> ---
>>   arch/x86/mm/pat/set_memory.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>> index 443a97e515c0..be8b5bf3bc3f 100644
>> --- a/arch/x86/mm/pat/set_memory.c
>> +++ b/arch/x86/mm/pat/set_memory.c
>> @@ -672,6 +672,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd,
>> unsigned long address,
>>       p4d_t *p4d;
>>       pud_t *pud;
>>       pmd_t *pmd;
>> +    pte_t *pte;
>>         *level = PG_LEVEL_256T;
>>       *nx = false;
>> @@ -717,7 +718,11 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd,
>> unsigned long address,
>>       *nx |= pmd_flags(*pmd) & _PAGE_NX;
>>       *rw &= pmd_flags(*pmd) & _PAGE_RW;
>>   -    return pte_offset_kernel(pmd, address);
>> +    pte = pte_offset_kernel(pmd, address);
>> +    if (pte_none(*pte))
>> +        return NULL;
>> +
>> +    return pte;
>>   }
>>     /*
> 

