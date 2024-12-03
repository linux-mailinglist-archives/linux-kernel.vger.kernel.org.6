Return-Path: <linux-kernel+bounces-430305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1364C9E2EF7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F6428372C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFC61FA825;
	Tue,  3 Dec 2024 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XD8jDZJt"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF59B1DAC93
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 22:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264490; cv=fail; b=TbS0mM1u1GFasg5553V4/8SYlnlc2bonEvI4Z8vAO9aePCvbsUgSsVpzvLrbE1eoWkUvW6el3Hw6FvWRmv5nUeuSIlMvy7cMmGxvvCZGHnz7IFnDxSV7GOqws2Exyp9hOtMT6hicmC1pcSsfyAape0N+3TCnrAsJTBfXxB7ytNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264490; c=relaxed/simple;
	bh=MUFzYDyQKWNd3rGk+/fmHRf+MprzAasYXu8dCnyiYWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lPCkx0CMnJ+Ay1uuxKvwvWK+VBsRjHF6z+uaWFbEF3s0BkAR7O9QU6VszMdDzv8OmiJt+cpOI6jLLeuqOQKj29PnF1T3hiw4iPc7ADcIfp4I4wRi1TkgqhhdFhd5o8gQFKBhCPbbbPlr3iZqeB1gCZ+etcCTm3+88/1dIvok4r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XD8jDZJt; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WS+n49f7LnexEvEx/H3PAz7UZnpMFhgNuHhJ4jzvttGVJKX9qlfZ44F0ltwxebwJckF6P+LyracWRchM1sRNNgRYM/ZYxDdqNNET9GZU5w074QyDcNlDBapoq3OvGbR7qDKdwspF5NJ2BXtl1MY6b/U8NDHGA93C764RZlDlqzbQIQRR9WohOvydNdT5xdxBa4wdBZKkalfyDrMnTbyEa0a988xKetkb9D7EI2cvTreMgz9FoBYaNB+qYqtx6COvlsBMgpTUZ/4cNzQu3sDMZuxb6AZhg1DNe229vqJ7bsrG/ya4Qv1G6NuOKHHEyDG7nfdtuEHU9jlIElWK9YQ1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn1+Xp5HmovkPE5YA7QXKAGEuZAAp6MkWkfHS1gb9XA=;
 b=HdeRsCJh2v2dYZL5J7wU3noM1dz7elwanQ9HzGcLRVKheCLeGJe5mDLJ+lTnU2M9pRTjQQ0e71cHKgNLEW9gxCq2dBn3EM1xgCOIRJNHCmxnmn6FzG/hzKmDNfC6E8w5vvqwv21/rrhkRSvJxcMjiFvWjjAQXOlMVGYLGpi12uQ8P2wryCwVH6mt5am93hIcQAVeQT89pEaAvACaTOMJ9sCNNjKYFFSJ8ax436k6gTU+CsQQkJ5FFaQWxKtxAlU7TdiZNFsCjfgLMQs5YgfC1kr+OSHpzs4/4hGpQRC6gX2aD2bRVhXcqAfSWKiABCryt2QtK94u8QpasgZwyUlo5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn1+Xp5HmovkPE5YA7QXKAGEuZAAp6MkWkfHS1gb9XA=;
 b=XD8jDZJtc7y5yT64K7bVgaJOZwYsVVYUyq8GNFv2zn3FPu02j2xCoj0JG0iyzJbD738XgiOIOYb9TNl04GeVran+VZMYBkJeN0CosQIGh3AxQxMYKCPZ/5elOaETWEejxu8p1N5lcItgzwQj6/C9bHNb9Eykeacocuca5hq2bWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Tue, 3 Dec
 2024 22:21:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 22:21:22 +0000
Message-ID: <2288034e-7819-4327-852c-8c00b92a1493@amd.com>
Date: Tue, 3 Dec 2024 16:21:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/cpu: Enable SD_ASYM_PACKING for PKG domain on
 systems with AMD preferred cores
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, Perry Yuan <Perry.Yuan@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20241203201129.31957-1-mario.limonciello@amd.com>
 <20241203215454.GJZ09-LmEWPZ502B7R@fat_crate.local>
 <f71aff95-3aea-4681-9d35-9847b086cc8e@amd.com>
 <20241203221746.GKZ0-Dii5rnZppkM_e@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241203221746.GKZ0-Dii5rnZppkM_e@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0062.namprd16.prod.outlook.com
 (2603:10b6:805:ca::39) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: e7488154-015b-4d4e-edfa-08dd13e8d176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0tzZTBONGJ4M2ViRFNJK3BQNjZYdUFlQzJ4ME9aSThEbFRnbDA1S2hEZFNz?=
 =?utf-8?B?ajBWMTcvMW03bWxmWlVYM2hPeHJPeGJjeHdMTS9HSjJGK05jM1ZBbllZM2JR?=
 =?utf-8?B?eWFYbTVraVFlOTlMVWxjeWk3L0o0TjdLVlVSMmdmR2lldUQvV3NKcGtmWFZB?=
 =?utf-8?B?N2djN0pXZytSSUlvL1ZXZXZwdHlQczNkUjRRandESU44eTVXUUNOMGpPbHdY?=
 =?utf-8?B?TXFvUFBPRm1aQ3dhM3pSWlB4TW9lQjBNVk90WURNOGVlS3JNT2tKQkpHRndt?=
 =?utf-8?B?MWVvU2RCVWQyYW9ZQ2d1SjF5MUNhbnVycWphQVVHUVd4K2ZBNzBOQnpjOUpV?=
 =?utf-8?B?dnc1dm1RMG83VWFNcFo0YWdrcUMwOXgwNlgyS2ZtbXVjbzl0RHhjNS9uWk1i?=
 =?utf-8?B?R2JTV2lwU2w2eGZPOWxvNjE1bG1hcjNDK3VoeDlSWm8zTlNMWXZjSmpYOFFw?=
 =?utf-8?B?eGd1bUtyYW9lVVppOHVVaDhVMFkwUjJLbnl6d0M1ZFcwZGQ4RE1wOUw1aUlS?=
 =?utf-8?B?MXROUjM5Tzh0OVl5MXFueWYxNmc5d041VVIyQWlLN2xmVElEbGF2WHVNN202?=
 =?utf-8?B?YkdqT2k4ZFVmWkoyN2tXTklJOUljQS9YTDlzWFVvOWUrdTRmd1diZjhEVTVO?=
 =?utf-8?B?T3RxTXgzTlUvTExETEd6MFY2cVk4bzJhWGQvR0NZUEEwcG9BakkrR3M1OTR0?=
 =?utf-8?B?WTE0d3R5OEplRDd5L3cvUHAwZXpTYnBwYVptL3RMTzU5RUdNQytrS3BCb3B0?=
 =?utf-8?B?UnBOQkVyV1FDclk5bG5OOVhSR2ljZG9GMjJvTE1pODc5MUhzajlrc0hrcW9X?=
 =?utf-8?B?U2xza2UrUlRRUldUNnAzNWl0ekM0K1h3VFdlVmF3dWpDVGttcTFIbVQvN3pm?=
 =?utf-8?B?ajZTR2pWWGEyK1M3NEpOeHZ4bU85alVGYmFCQjFWNCtCQTVhSG5MNDduWUx3?=
 =?utf-8?B?cWFlTTBFMWpLM0RNYTdlVUtoK3lKUmlPMHkvam5ENFRBMitxWlpYTWpscURK?=
 =?utf-8?B?Q2U5eVZ2ZVlZRmZSUEtnMTVjMFBlTXdpelQ5bmVLRHNBL29kSTliQ1AzdTc2?=
 =?utf-8?B?Y01sWEIycHU5RWhCTnMvL2ZWbThhaVdzcC9Pc1lhcGFBMytwNkVDMm5ubXhR?=
 =?utf-8?B?YzQ3aHlSandQaHl3dWRWNDdVRXFzN3JZNW0wS1ZrNDVwdk5CQ0hPUjkrSEh6?=
 =?utf-8?B?eVBGM0lIekY4Ky9xQ2NGc0h1ODRjS3Q1YmYzV0JlMHM5dVIxRmJLMGxVeDJ1?=
 =?utf-8?B?Zy9kVFF6QUdvbzNLTThPMEM1NDlhMHVSWEYxY1VXZndQOSthaTBHSkF4cncw?=
 =?utf-8?B?Q2pPQlJOakliL01FK0EzbEZmTVNmcWxTeGtZSndWc28xM29Yc2h6TE11K0VJ?=
 =?utf-8?B?QmZrc1U4TTI1bEl6bThDaTRXVjg2bU5LdkVUVnVOVzlFUlBPVXdWYld3d1Vi?=
 =?utf-8?B?b3BmeDlKR2VvRDBxckd3NzhobmxOc0thWE9sdWlxQXE0ckdST3FNMUdsRGdo?=
 =?utf-8?B?ejNyVG9rUXQxLzhhTFJlRTN1NmY1MnRwZHV5RmZlQ3dwRFF4RXZWb2ZaWThr?=
 =?utf-8?B?YVFhTWxPTG5kRDF1UmIwa3dzNzF4NGs2VmJWbGRrdHpNZFlYZFRhZzNpNzFR?=
 =?utf-8?B?SDFMZ3lCaDdnUmlHUjRzTDVVNHVjSTRQMUZXRHVYdUw0d0E1Qjk5ZHVCR2s0?=
 =?utf-8?B?R0JBaTRVTjRsd0FNTURxNGpiMHd6Ly9Za0Y1Q0pQcEpQNEJyVVd0MGVYR3Yz?=
 =?utf-8?B?eHhKcjRrOHgrTjk0UGFSSUpzeFhvZytQT3VoUDZpaG03aHMwbWl5ZXAyNXNO?=
 =?utf-8?B?QllQME1RR3Z6UmJ2WWxpUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NG5XckhYYVBsNVhNZG1ReWZFOUd6WG4rUk9EVTlhQStYTTNzRjRBU2srNmhy?=
 =?utf-8?B?MjFLNVl1RjBuek9sWERlQVBLaFN4M3IySlZVVzUycC9NZENEVmNjamltbGps?=
 =?utf-8?B?N0RJemZIaEVoN1BWNmVBbjZva3ZYREhrcHBZNERGUUF3eVZ3NHZPSVlIZVEy?=
 =?utf-8?B?K0I5V2RiUDJ3bHppT3p2R1ZwV1V5ZDZlZ0hFcUdLbzhSc2QrKy81MjNMV293?=
 =?utf-8?B?VFV0NGRWY3pEaENOMm44WTBPQ1dVU2xTRmZ1d0k1Z1k4N2p6Z1lveUx0U3NC?=
 =?utf-8?B?TENpWUN4S1Z0NGEzbGtQUm1yejV2YUwydkJueUtNRkR0NDJJRUl0V1B4YUFj?=
 =?utf-8?B?TFhtUGhURVI2dDRKY0szRUZhdnZSaS9Mb2dRenJXVW1wVjhFenhWYnh1SGVs?=
 =?utf-8?B?cHo2bU5QRFBqNVdWd05FeGRURmZXR1lBRDJTcVZ5MUJLOXJjYlBYWlBJYzlW?=
 =?utf-8?B?Z2RnZEVJZFpkMzlUZEtCRkFtOFNpdktRNzYyS21wV0x6TFBnWUFNRkpXUDF2?=
 =?utf-8?B?MSs1YklyMnB1elZIT2twTmhUZDZZM082VzVHSDFqSk1VNG9IRUFPNHo1MnNP?=
 =?utf-8?B?YXp4VVo3RHpRUTRXOWJZT2dYODdqV3dwRWEvY3cyTjVkVU5VNGl0Tk5oa25N?=
 =?utf-8?B?a2EwdVlxRmxNWVNvQUZ1c1pZS2JHWElpZXRUbjNaQk1NZmpqQmVFM2FXZjZm?=
 =?utf-8?B?bXpWeS9TNzhyc0dIZVpISjVhOHZHS29kbjd2T3pWVEZ6M0Z4R0xiLytmVElz?=
 =?utf-8?B?WUFKLzJacVF1RjM4RFROaGhCUkRsM0w3WS9ibjBSRml0MnlhQzlxNDh0UmFE?=
 =?utf-8?B?N0hTdjFBVHJNcTJ2RHVuQ0RqWHR3SlFpLy8xMTByNTRIcS9XV2QyYzVUa2Ir?=
 =?utf-8?B?Wkd0ZXhxV3h4Z0w3SURjcitnUEIwMVk3VGVPSkFYajVCUWxXV0huTnpFeSty?=
 =?utf-8?B?SllVM2Izd2ZxVC9BUXBHWTFIMlAvam1EWWU0eUJQbmxBQk5GZE1COXpzRzZE?=
 =?utf-8?B?T1ZYU04xaytEQzVRV0pxSUVpWGVsWHpLMXpPTThNbVI5OFZMQzBoMnU3cmxx?=
 =?utf-8?B?a3N2YmtmK1JMZWpyU2F1SjhiUXpoWVdjM0ZGblFLU0ovMkVJa0NtU0V5N1Rl?=
 =?utf-8?B?c1VUL21mWllTWmlzZWh5MVROaHNvTk9RR2s2NDVHUjNXTjRTQkVKYS9nN3Uw?=
 =?utf-8?B?VEM3RmhOdXlSTUw2ZzVveEo2N0dqNEFFejQ1c0VaRjFKdnoxcDc5NlpxUnBJ?=
 =?utf-8?B?Tkg3R2Mvc2dkQm4vbW52cmk5T3kzOGREWkV0NktJSENFK3k5dG1XU2s3ZHNN?=
 =?utf-8?B?a0wzM09WNzJ6dkJQQlFBdkpycnhabTdsd0NvZW5pNmpkeXVpcjJJRHJEWnFm?=
 =?utf-8?B?bjZVRXRCeklTcEd2U28xT3h4REFUc0VONTFOS21pekNyaE5HNXhTaVB1TnEv?=
 =?utf-8?B?RFcrb2hLdzV1MFMySkgvWTVtNUhGZ3RzdkFYc3kxVm5xVWR5ZjBYbDRvN1lX?=
 =?utf-8?B?c0NxWVZYYmJwWmlkaEVaNFYyT1ptbGx1SHpuS1l0a0ZvZmoxVUpFZDZPd0VE?=
 =?utf-8?B?T1RTV3MrOEpTY3VqV05sK2hVOFJDTVJzVVN4bUJUUGJYZ09IWEVTSDg3SnZF?=
 =?utf-8?B?QmgzTHk4eE1PS1FJcjVsLzFGd1JHZmdrTy9vU0Frb09NR1hsaTRlMDdtZ3Rr?=
 =?utf-8?B?aHVHQTlLNXRxUEVCMVNJRlkwU1N6MC9mcDZrRVRQU1QrZ0Q1TDJlUG1GWkZO?=
 =?utf-8?B?YnhjYzZGelR4MjBkTEtOMVFnQ0p1V3d3ZVlEYXVSclo5Zk44ejAzNGk1L2RO?=
 =?utf-8?B?S1V2SVo5Nmo3dXlaTDJNdE00d2tyQnNmU1hlQXNnT3NPR0NaZTRVNjJ4WlEv?=
 =?utf-8?B?MEtOM3p0aGloL3NaZld4ZXRvcTRjZ1ZsQk9xMmVQczV0anBRMUNmVGR4bitl?=
 =?utf-8?B?a0pRbUp0dEltRTI4UFYxdUhYd2x0VU1DcFBqbzlxcXdpQ1BXaXl2VHFwcjh3?=
 =?utf-8?B?cFFid2NWUVAyWVpxN0tWYTRHdTk1TFJMYkcyR3dVZ0NZMVZyeHd1VDRiSExq?=
 =?utf-8?B?U3p0VHQzLzlneVBjVDdxT0JPSnkwY0s2SnI2cU5SRjNUUXFaUWFrd1hESmlC?=
 =?utf-8?Q?JgvqQN6G7+lSMVyj1gJiZOuWw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7488154-015b-4d4e-edfa-08dd13e8d176
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 22:21:22.5643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpPxKs+fQcLax82hhuE83Hqi1NjLWEGhbU6mUeqOs5F35qag+PGqYLaBBWNCR1Ra+/ULeN/bZG17HUj4P2X/mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275

On 12/3/2024 16:17, Borislav Petkov wrote:
> On Tue, Dec 03, 2024 at 04:02:29PM -0600, Mario Limonciello wrote:
>> Preferred core classifications are available on "non-heterogenous" designs
>> for a few generations.  There isn't an indication they're supported which is
>> why amd_detect_prefcore() was made.
> 
> Not surprised.
> 
>> That's already called during the boot either way because that is used
>> to identify the boost numerator.  The boolean value it finds is cached, and
>> the next call will use the cached value.  So I don't expect this change
>> affects boot speed.
> 
> So with this addition, amd_detect_prefcore() would get called *three* times
> where you need to call it exactly and only once. And all it gives you a one
> bit of information which states that the system has preferred cores.
> 
> So why don't you define a synthetic X86_FEATURE:
> 
> 	X86_FEATURE_AMD_PREFERRED_CORES
> 
> run this code *once* and *early* enough so that every user can have the result
> ready, if you have preferred cores, do
> 
> 	setup_force_cpu_cap(X86_FEATURE_AMD_PREFERRED_CORES)
> 
> (it needs to run before alternatives) and then in each user, you do
> 
> 	if (cpu_feature_enabled(X86_FEATURE_AMD_PREFERRED_CORES))
> 		/* do things */
> 
> instead of what you have now?
> 
> Thx.
> 

Sure, that sounds reasonable, I'll try to find the most appropriate call 
site for it.

