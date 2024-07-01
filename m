Return-Path: <linux-kernel+bounces-236875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C88ED91E80D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7611C21D83
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565EC16F0E8;
	Mon,  1 Jul 2024 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jwuk22Ll"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11F316F0E0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860362; cv=fail; b=L7BP2y3sd5Jdpnkc6ryFXRUyelHRf2695AK8kAzJpB+bu6pZ3SsQ84s8XUGynlaHXRGEEzKIB8CiuAundSNII12twoko+1an7hlllO4S1TQWiZ64kVv+GLC/C4jmowdzfwwbAILAtZ/QOmMVD7QfyMt505+ZDa2WEaJpp/K6H4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860362; c=relaxed/simple;
	bh=ZbtItP//NmqGoD5zomLVtKbZXOtnXb4wWPEsQggpAlk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tp4qulVhbYqyM6NPFN7Mdj+qFP9C/9voSN02x0rXvHPLaFRcb+TnBiDR71dppJF7QUdb2njLEA6R84URjUiYiwuM39V3fawE8/+s2mgE3CpyDmCtjEn3mDBqH0jXz0j9usLgxbjFJeE2oXt9oHMj5dA78DkztIox9ka2m0mGSJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jwuk22Ll; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2jdMwYcGxDL4PiAfHe9D5nlasH8/ooa+OKGU/IOCP9sceF1+LOVaGJfilrdGjpQJsnvRQwoXltnzKhR0oNk+JYOdW5EGLw9TDi6XUTfJoYYw8/xNa2s7fqMa9hn5iU/Mq3hTARAQbQ600ghVzn1VQ7isgHsZO6eoxcuiU1v0NtDsGpHjCnsaOJIs03kIBW1mz68WJcCjzcZWbiO8stJeihmNiP6/WJZc6QuqIinrO2vOxhfaPu6GhUedHfdZO/hFGZIkUpBxd6tgf5wxMs8M36h0wmT+BCgkuCaiN/tjzMbwUDYvMGebVnHUzyeyAi86oPVOBoj8SI2Cg/j+RNDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbtItP//NmqGoD5zomLVtKbZXOtnXb4wWPEsQggpAlk=;
 b=QHrRpXdyroOu2xbWQ32run1BPHVFU2H4hjreVTTpOMFrsbvu5fH6Upw0/F62vpP447D5+eY22KVXFYrA6dwIpeaH15W/9fTE7xzc0OrU+gM+TejAU9rAVCb2YQlQR7HU/zA3vH/MpOqJoZoJnZ2dpSRq/OhPyY4DEhh/Lvmmrs4BhCRPjK+P8jOp/MgICQCcu/O+egomx51booYf7nrfQJBqEMNk1+gRxpALJJzxkrbdGtQOx3hLaN/MXyo6R2EgCBbfcOJTKGe7rf6AmrenEJIZxZulNH7fZVt3NOvsXjKi/Sef5ZxPtg8HXfwL7BQtDSBzzgnvGD737xk0EeLMnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbtItP//NmqGoD5zomLVtKbZXOtnXb4wWPEsQggpAlk=;
 b=jwuk22Ll88UEOpjlEs4cycQQ6jjmkmaoxGtN+ri8HBX5/ae1p8dvXb0SkFwe+DWibWnHj+myMkRIpnGQpFxAF104bek/1pJnCceIwVbSxPOJDcZz+8cXmRvmCetMu3htrYA62rOYN8bhvOCasjRMybpgyc7yQab3vIwuThClne8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Mon, 1 Jul
 2024 18:59:18 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%4]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 18:59:18 +0000
Message-ID: <0dfcaae1-9ee7-47c5-b530-2062021155f0@amd.com>
Date: Mon, 1 Jul 2024 13:59:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: fix lookup_address() to handle physical memory
 holes in direct mapping
Content-Language: en-US
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc: x86@kernel.org, hpa@zytor.com, kirill.shutemov@linux.intel.com,
 rick.p.edgecombe@intel.com, mhklinux@outlook.com, peterx@redhat.com,
 linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
 linux-coco@lists.linux.dev, jroedel@suse.de
References: <20240628205229.193800-1-Ashish.Kalra@amd.com>
 <2982a4f2-ea8f-4fa4-81ea-d73c00fc2ad0@suse.com>
 <5cf60d52-1682-4244-b892-688b22eaf4a1@amd.com>
 <8d970528-0e57-457f-ae00-862b4d320a2a@suse.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <8d970528-0e57-457f-ae00-862b4d320a2a@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR18CA0006.namprd18.prod.outlook.com
 (2603:10b6:806:f3::8) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8ce780-51c7-499e-1b06-08dc99ffe89e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFYxV3ppSnArSVNkY0VaVzZ2YkFKMUZ5bzlyL2NPN1VkaTJEUVRxck1VbEdk?=
 =?utf-8?B?TFMrSXNBbzc1a1luV0o4YXpDS29QNW9zSUM5UHozQTV5NVFZbmQxa0h3THpr?=
 =?utf-8?B?ZkNrUU5mRnUwZzhmZmNYaDMwWWRVR216dFhvN2hKRCt5ajhnSUNVcW5QSEYr?=
 =?utf-8?B?VXNnMEs3My92Z29uSGNSRHMzNm1pc0RGMHhubG84WnlkVTFYZlBzam9QcjZP?=
 =?utf-8?B?VWFnczF6dXZwWkR0a2hRQXZkZjFSb3RpeVBJMGtLdlBLWkVMNXBtc2dycVM3?=
 =?utf-8?B?SVpRZkY5QThuVFVTSVo2NnJlNUVDZDZTOU9kZWpiV1E5S3VEMU1LWHV1VXpH?=
 =?utf-8?B?YWpqWjVDZkE5NmROOExqRENFR2Z6RmdEL3hxTG1LY3E0ZkpOR2Y3TW93bFgy?=
 =?utf-8?B?NnIvcFI0NlpBZnlvcXF6L1VFWXl4ak5tWGV5bkttaU4yYW5uL005ano4NUxq?=
 =?utf-8?B?UjNmaXhPSnY0S1cyVjJXcGRyblE5dDVlRC9weXBxYVROZ05IYm9PU1dGb2Js?=
 =?utf-8?B?WHB6cGRqUU9kRDA1WGpPV0c3OWdqTFlhayt4a2xSeVEvMVZMcHdUd05BTWdl?=
 =?utf-8?B?MUNLTS9Rd0VWTnM3MDV2RUQ5NnBSRWhLZ0oyZTJCa1pNRjcrZnkzOFZ3UTN6?=
 =?utf-8?B?Z2lxd3Z2c0ZDQzJUdVhuTkRiZjFkZHcwekJCc2h4LzFPdlp6MTZ6Um5QN0d6?=
 =?utf-8?B?L09KM1BqKzVQY3dhZ2s1S01TbXJPSEcrQVN5dDRxQUJrbno3dUFoMm4xdVdo?=
 =?utf-8?B?OGI2MGIxT1dJcGxpd2RMdUtYS2p1RDlMQTByRlRyWFdZNkIxeGFpb0dER29E?=
 =?utf-8?B?eFJTU1lBaU4rbVBPZGtQWTJJWUd0aEpDTXd6L2crVU1idGw3UWFYTStnUUZN?=
 =?utf-8?B?Nk55ZUgyY2hmZTFLTVRsVUNRcVFITGRHWmxjWEkvN2J0bjg5bDM0MFFab2Fx?=
 =?utf-8?B?b2NBOGFEdFlCWVFhOEROTitZNkVSL0lvaG95Y0JpWGZUcFYvbnpOWFZwWE1x?=
 =?utf-8?B?blNMT2ZBNFJPa2lOR1NNbDR2M04xWExkNXB6WVZOaDBKdnFWd2xmemZZSXZZ?=
 =?utf-8?B?aTAvWExlTnoxbjJrKzdvQmpOc2dGZld2eWF0bGs2bnhqeEJDR2VUNnF5bDVP?=
 =?utf-8?B?SUF3blJDY29tMEVKRVlHZ0xmMFVvNXJmRVVaN1hDZWp2eUV5cHBvRncwektK?=
 =?utf-8?B?UWxCbE1UUHRQc0VaMWJtYkIvb3pVS1VXSHJxQ3lxYUxHVnRTNkFWQ0ZCS3VJ?=
 =?utf-8?B?bFJKS3phbFh0SkpFZytmM1dGZ1BBUHdldDUvbHJDTHQ3MEc3UlJaVGRsTFRG?=
 =?utf-8?B?enhRR3REcGM1c0ZQOWlneDQ3QlNSUkdKejA3eVE4cFRvR3lSZ2hQVCtKeU9t?=
 =?utf-8?B?N0lxTkRUN1pyWlg3ZFVpSUIzc293bktjNWJZdS85bksvcEFuMWNnSHhuWFI3?=
 =?utf-8?B?YkFrckYwWStPRk9tNElOeW5jYUNsYW5adE9WYjV2TUFGeWszSkp4K2IvaUNL?=
 =?utf-8?B?SkVjeVVBU3V1d2ViS3diSkY2UEZmclluZTMrUVZ2SVNFdWJiYlZ5aGcrdjBy?=
 =?utf-8?B?aXgrYjZyTFFxdTZuWXpRM09NMVZ1MkNVNi9SWmg3UklBVjFGZXVwM1pmWi9z?=
 =?utf-8?B?WTVFWC94bHo4ZkVkTnhBd3NvTWJJVktJUzQrREdFUmZ1cXpRTkZyMmExc2VT?=
 =?utf-8?B?Q294NWVRK2dTQjhaemlQVXVrQm1QSVlCOGxXcnhJdTZkSFA2WWcrRTYzdEd6?=
 =?utf-8?B?UmtaRkhkRUtXd2ZWOUd1K3I1RVZTQUFXcmh2ck9BczQrdEZoRDc5NzBIOXZF?=
 =?utf-8?B?TDgzNkgrTWFOem0yb3l6dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTBkWHl0TWR2eHVZMnRBR3ZwOGVzQVI2ZUpHZHZMVE1qbVZ0MmtkcjgxM29K?=
 =?utf-8?B?MkpVWGM0UjBtRSt0Y1hYdG5UVGxCcFJORnZEd2ZsZnRzQ1R1WG1hQmNEaGsx?=
 =?utf-8?B?ZUMyQWozNzVHQVZhREdtdWtHWkVtNTFMRXNENk9CN08wUVljdlRVeURJd1hw?=
 =?utf-8?B?NStubnFKZm1qd2ROaDNkZ2V0dS9NRkYwWlVIbWFWbm5CckluUlNNRHhsUVph?=
 =?utf-8?B?ZkkvM2Z3RFNjeW9BNUhpRm5leFMyMndicW5PYUJkd1NybFhRS09xdHMxZGRG?=
 =?utf-8?B?aEtnbDNoUG40WVpJbjdXRkFOdHdrLzcwVmw2ZncybnpybTNEQ1NaMm1QU2Zp?=
 =?utf-8?B?ZGJRSGRyU0NlWUhwWEZ2TWtObm9qZzF2a25CZGc1bmtFa1gxc2lRak04Vm1C?=
 =?utf-8?B?THY0QzdKWG1rbWlSelg1d29wSVd1MnBOdlpZN2hsYUY4Ri9uNVQ5SXBBR1NJ?=
 =?utf-8?B?V1JVM2Z3ck14ZEphbDVvNy9QY1gwTHFsNzlrdnRSZE52QUdQbXJiSTZVdzUv?=
 =?utf-8?B?V2hFbVVIT05wYlpxWmM5RW1XRjN2NVp4aE1pMlJmaUVYL3BaMHZmTHVsdUZK?=
 =?utf-8?B?YnNwYzh2Y0pIb0U5SmU5WnlWWjZpaXF6ajRUYWo5Sk5oQlJtR1ltd0FhMktY?=
 =?utf-8?B?RDhZanRKMVNKWTZlQlNiZHZPZlF1UjYxNVBpTkthSTBlelFsTENoTzFIQWpZ?=
 =?utf-8?B?RDJTTmRCS2hGMThkd0VMTUVyRExNV3JIT2Z5ZVJGZUg0UCs5cks5K0U3cWhQ?=
 =?utf-8?B?bDlDc3RJMTZtczdiZUQxTFMvVlJqRkZMcjcwR1o0anhEV2EyYkllUHRCUnJM?=
 =?utf-8?B?REJKeWZsNXc3UUlwN1BwWi9TcDFieWdzRzI4aTMycU9rQ0R6alVxWHNvbWZy?=
 =?utf-8?B?cEJKN1ZFM1JWSnUrald0OFFFclkxSXF2YjlhV2dOZUNEYlMvK1dGN1AvYWMx?=
 =?utf-8?B?YTFtVEgxYXg3ZW9qbE9ockJCWFlLSXEwOEZHd2RJLzJWak1uVUp0TW5IK2dx?=
 =?utf-8?B?aTlvU0JiZ2ZRdTZ6Z1FLNkprQ0ozRzJ2Ky9ySHVORTVEelplalozU3ljM2FQ?=
 =?utf-8?B?RXZ1NVdHSlNvK3gwSGZVaDdLMjVHWGFhdjlhakE1N1Z3SHVSVmYwVTVGeC9H?=
 =?utf-8?B?OVgxY0pQMjZYZGNmOFAzYlZ3djBwUUREY0szNjBBdjc1SGNaVWFoUUF4Zm5C?=
 =?utf-8?B?WTRZZjRMQUVhUDlnNG9laVQ4NTdiTFZvSU1QUkVoOVNXczNlc2R2dkJlK2dT?=
 =?utf-8?B?bnBySmdhUy83bm9UekUxYTh5OEJiMmlTQWtLQWpYL215dGgxNU1uUkg2TTdE?=
 =?utf-8?B?bjZsVDByWnR2eGpwTEdUYjBWTktPRUFhaVY1U3FCMTZEcGM0U25wMHFBU2tE?=
 =?utf-8?B?bXJ5bVJ4Z1NEeXdTVElteEZSM1hJamtpeGhQeSsrTUNCUFREaUJ5WEJYMnFK?=
 =?utf-8?B?UEdMSnIzdlF1Qjg3cE1JZit0aGhrNGdUU2pCN3p6MzNYR3I4Q1ZIeTdrMFkw?=
 =?utf-8?B?bm1aRURTL3VyeGxkRDdaU3pmaFJ6NVBYazhDNHlRTHRBMDNvNHArU2p5Y2Z1?=
 =?utf-8?B?dGorNFZVcW56MWU5M0lldWJ0UnpITm51MW9nY3pmTitFemxFbHpsYm0yNFpw?=
 =?utf-8?B?TmFVNUF1RjZmeDZaZlY0NnJOOG1DSnVpa3ZyRnFkTlhxNVN4aUF0NlZOTzNl?=
 =?utf-8?B?MEFLcy80a1huRDhiVGxUaGVaanNtS2Q1Vml6elUzQ3RCT0hVU25BdEVOcDFG?=
 =?utf-8?B?QUprdmZNTldoOHFqSkhIK0dVY2tiRFcvTGxKYzlhQnZYdlU4S3o5emh4WjBx?=
 =?utf-8?B?bkZNUzJMZ0pKeWFHa3VKNTFzQ254Z2hndnF2ZzBMdjFHRVgzRHNDQnppMGto?=
 =?utf-8?B?NWdBTzNVQ3BFekJTT2FaOExDdE1KT0JYREp2eGxHTjY1eFZqNktZWUlwTHVm?=
 =?utf-8?B?bXREa0VVU1NOMXZ3ZWtMQUhXRkoyQUxHYWY5MXhnOWJHclI1cElDRDRCcTQz?=
 =?utf-8?B?Tk4yczh1N2lLS2FpeTZpYkFwUUYwNmhidXlSeHU0M05uenIyQjhNeDhZYVFl?=
 =?utf-8?B?M01OR0MyMlphajZjT2wydmpVT1NSVC93OW1kV2VEa2t6bThGdGJQNWFiUFhp?=
 =?utf-8?Q?xP7zkxm3cFXgR3RdxOTi3tF2L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8ce780-51c7-499e-1b06-08dc99ffe89e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 18:59:17.9196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlWZqs6JyedQ6faMmmry3EwOsFTVZeBljKdNwrAu8VIPDBUxC6VKXf5F3OBS2ajQuKHGhsca8Y+aWaws+tlebQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212


On 7/1/2024 1:38 PM, Jürgen Groß wrote:
> On 01.07.24 19:57, Kalra, Ashish wrote:
>>
>> On 6/29/2024 5:20 AM, Jürgen Groß wrote:
>>> On 28.06.24 22:52, Ashish Kalra wrote:
>>>> From: Ashish Kalra <ashish.kalra@amd.com>
>>>>
>>>> lookup_address_in_pgd_attr() at pte level it is simply returning
>>>> pte_offset_kernel() and there does not seem to be a check for
>>>> returning NULL if pte_none().
>>>>
>>>> Fix lookup_address_in_pgd_attr() to add check for pte_none()
>>>> after pte_offset_kernel() and return NULL if it is true.
>>>
>>> Please have a look at the comment above lookup_address(). You should not
>>> break the documented behavior without verifying that no caller is relying
>>> on the current behavior. If this is fine, please update the comment.
>>>
>>>
>> I don't get that, in this case the PTE does not exist, so as per the comments here lookup_address() should have returned NULL.
>
> There is a PTE, but it is all 0.
>
> There is no _valid_ PTE. No PTE would mean that the related PMD entry (or any
> other higher level entry) is invalid.

Then what is the caller supposed to do in this case ?

As the return from lookup_address() is non-NULL in this case, accessing it causes a fatal #PF.

Is the caller supposed to add the check for a valid PTE using pte_none(*pte) ?

Thanks, Ashish

>
> Remember that the W^X checking needs to be performed _before_ a new PTE is
> written.
>
>
> Juergen

