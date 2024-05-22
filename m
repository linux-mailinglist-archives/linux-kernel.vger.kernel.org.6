Return-Path: <linux-kernel+bounces-186725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA86D8CC810
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0AE22848C7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C7D146D47;
	Wed, 22 May 2024 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TaIaXk/5"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B886A1465AD
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716412503; cv=fail; b=DxgyXhxKj5eMBj4uyw9guXjRfvYVPx1pIK37HCOfcmbvnjjz2Jz254jSIJEHbyPHx4HVpznb0eWYvXSwZSO9cgRhzhv1LBOwla24myiAgaKuEQFre5qYqjSM/ghVyJPx8LSn9JQwA4Cn4JVsv70G7H3FIZQA+1+YhanIF2G8e14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716412503; c=relaxed/simple;
	bh=v/8oSJFdPdrdkoH2oXqe5s3A6MpZE6SOMtwTjypSvBE=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=gvcUhssRCJ8S6f4wfsmW2lh4BJUFp0hn/2tZ89x+BRRz+CiBB/s3PUgoVtmgHk8btLttC5027kp6nb+DVyXM3YdzrEkRuJqlOcDcVKwnWcpcDxYNTUwUsFXtZV8EcrVlH4lpyMUNYunUr+AIcD7m3HTf/Ko5aA2RPhPJL3NvOyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TaIaXk/5; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T271LQJPRJfNVjxZOla3G95DixtWF/lhLsVvUV9HCZmgTisqDMH5iDeVasOk7H2ZuWEV1gE0LI1kXBBvMNzc+UHXpbmiOgdPJlBA0UOkyJMEL2wMECoXxD4BgbwPYmRIgvq6vZO+ldynv9b+0poc1zGDNthMnLWnpxnZ5M08UpERTk2w6P2ZvNDALDgtr+qbfmMSN/bYKvAGD9jfmMHH1H8AIaVhyqU9dW7wn7YWtYzppPxywyD0WxTtoY37Fsj0CH2RTdpO59IX9tMKmnA/WWLKwhVk1m5iq9GDdo9IXg5D9CFsY01aB/k+yoN8K2m177an1SY0mXQ8BFWOqhfjIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNloCY1MVMOM3D32YB56hOIs7m7H+UKSfedAPuvUUec=;
 b=SxkRUQ/7Z003M0D8Do5QI0CEIB3vAAA7kQlleeWD1HiJxLl9yYNo/1OhUqmxnBITmDIWXmkUdGg42cyefEEDCpNUY4Iw4Xx6UUUnibgT/pGLqwvVBH4lOAAyPdgNnwHcbEUjURggfC7puLQvf/cge0uZbxZAUoD2CDoNI+o+Q2GGUiKIbJLy+RTJEleFuPJDDu7FqPSgbqJD458cAaQZZrgUabF25IaGypEUHtnGJXohhVG3zhutrDyX4sP5MEEgMleCyJoGoFmT84igZCtlfeHgjlDUMfq2aWuVqlkR8Ub0Yt/NVOONqzbp1l0539uZqkaZ+1cKd2ga+K/q7ah3Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNloCY1MVMOM3D32YB56hOIs7m7H+UKSfedAPuvUUec=;
 b=TaIaXk/5Yyfq4ZhSXWN+TvHiVbENcSN9Tj8I6ERdgpxVG9KOL+1skqA16uWaPxVkOr04SyAydKtaB0+j5qzblI0rzI0PSi2w7t/cjzZSyUUoHNozdvEMaEaE68NZujMdqSPJgfrPejpzvzeVDTZB2xQMeTG+YVXJrVj/jPJV1x4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 21:14:57 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 21:14:56 +0000
Message-ID: <408e9902-d9b1-d087-a44d-fb27342cf21f@amd.com>
Date: Wed, 22 May 2024 16:14:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <ce5f7ded87868adce2f4724415313229a8bf3eb3.1713974291.git.thomas.lendacky@amd.com>
 <20240522182403.GAZk44Q7DalfDBk7Br@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 06/15] x86/sev: Perform PVALIDATE using the SVSM when
 not at VMPL0
In-Reply-To: <20240522182403.GAZk44Q7DalfDBk7Br@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::20)
 To BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c5dedd-80ce-4d7a-3222-08dc7aa43b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tk9reWpuc3pXOS9ISmVIOWlnMjlhYU5BWVVvNm5QUEVCV0FTa2I2NDU3cDc4?=
 =?utf-8?B?Tk5TZTNzUGZNTkVGdDNhY3I3b0V4YjhmaWhvVnNCOEx4THRLSmxpRnR1b0VV?=
 =?utf-8?B?MHBjZnhsaUcwUWZCYW0vanlsUnhITGJRSUdndjczd1lRV2llQVhQajNzOUo2?=
 =?utf-8?B?QXFhOXdWMHJGZWpxVWl3dFR0ZXcyWTNGa2dLNTJ4NUZQU3g0dWRYN1lCUVkv?=
 =?utf-8?B?Qlc4YTNIN0c4ZXdpN1hyc2JoVGNwNjhyckRQa2d6cGd2MGpwV1g5M1N6dUND?=
 =?utf-8?B?ZUw3ajNOVENvbWROb0FNMTZQUHR5SzY2U2JqL2FLb2xKQStrRjFTUXZwWFJN?=
 =?utf-8?B?emNsdmpUQWhyQzFvOXo1T2VzMDlmR2ZEdEMvY3h2TERkMlkxaXNpRElGblNv?=
 =?utf-8?B?dFU2eXdUemlSeDh5a1g1VHpUbnV1WTc4NjJiQy85L1d1UEl6SXJneC90QnNH?=
 =?utf-8?B?Z0NhNnF4ZUE4UDRZeUVlcTdyT091clZMc3NDeVpoMGl4aW0vRXJZRWVxNTc5?=
 =?utf-8?B?YlpoM2RiQ1gxRGJzK2E3T2dLbmQ2eHpuRHdiS3V3dVU2TDlNbk83aXlaMnZz?=
 =?utf-8?B?WGZacUQvVWVxU052WE5rMXZ2TmhxNWptYktIUDExTTNGMVBTZlh4cmpkTytu?=
 =?utf-8?B?SFFhZWJvK0lIQURRd1NMbmNZVmk4bC9uTGJrYUhHWXVpRld3ZDduVHgwcTZC?=
 =?utf-8?B?K25TaWhOUGhBOHgrek5SeEVsUW1QS1dGQ3k0cHdxZ3JSLzNrSWJCZzN0dmlM?=
 =?utf-8?B?MEtuU25ZRVIwOXNHa0xPblhrMW5ndGZMM3ZVWWx1NWhiV28wMHNHSWhlSi80?=
 =?utf-8?B?cXZOcmViRDU1WmtUcXFHZGNTRHZnZHprNVJLcDF0ZkYyeWZTMGVQMUJBMUlY?=
 =?utf-8?B?OFcyUE52ZGVzSGU4R25HeDB3L0t6RWhkSDBVZ0orM241V1hJT0MxMmdxRUdy?=
 =?utf-8?B?dHpOWndjeXFsN2pxNkRpbG14Y2ZTY0Y4RkhKckE4d0NrOHNVRHlGVTNyL3V0?=
 =?utf-8?B?aFZGWnpXcHFmQWVvenA4RkRuaERZNU1hQlFOVzBhbDRCME5XVHAyWGdJUzFI?=
 =?utf-8?B?WmZ1aHRWYzNWQU94VnA5Y1Z5VCtqWDJSWWhUV25tRUFLQmc1MmdzdG01bysz?=
 =?utf-8?B?NlhBMEVRbzI1Q010VHdNTkUzWXM4bkVPcGRNbm5HMHpLQmtKR2MvZHFKTlN4?=
 =?utf-8?B?aGtXTjZVVUJ2SzlscjFBVUw5S2FVMHBDOVZUanBzczU1WExZOUxLSi9hVkda?=
 =?utf-8?B?eG1WNnVXWEVIVGoxMWhwazNYTUdVc3MyVXNKdEZyS3lCVXU1UTBYNEUxOHZk?=
 =?utf-8?B?cWlIS3J5aDZQaTVvSEVxY2ZMc21zL21jSTdzaUd0RHNXWEhKWjZ0NUo0Nmh4?=
 =?utf-8?B?MTUzU1BhQ3FxWE9CbUpJWkVZNVVHc0NyUzZ6VWRBVHQrRVdJVzRjK2NtdmJY?=
 =?utf-8?B?ekY1cEMweHBJeEFoL2pRajNKTFBSYWVCNEFYODZOZ1lhc2o0Y001WG1XQ0Nn?=
 =?utf-8?B?OHdQRGwyTGcxT2NFNEJwUWNuc1Rnbk5JQWFuSGhkS2wrU2lLWVBlT2o1TFoy?=
 =?utf-8?B?eHlqOXZKL1ZCZloyRldUZ084K01ldHhRMGZDV0lISWlsUjg0SlJWR3pMbGpZ?=
 =?utf-8?B?QmNjN0VBdGRXY1hkWnhtdXhncWZmZUZtVFZPR2lVV0RvRCtQK01Ob2VGVGs2?=
 =?utf-8?B?VDdWenFCRi81SSsybWpuWGNYbXpLNlRld2pacjBJYzdZKzBycU9TaitnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlBkQ2RkTzdsQjdnTWVpQ2tQdEZCNU14VUVuQW5UVy81VDlTOGVYQlgvdWZs?=
 =?utf-8?B?SE1yQ05BK1JYVDlxb0tnNGV1TC8rbkZhb1FMckxxWCsyaXZCS0dlOWR2bnVh?=
 =?utf-8?B?cWNKSEU4UlBON255ZWxySXVlOW95Tk9pYTh6VUFwTFlhWklaTTNaSTJ5aHRq?=
 =?utf-8?B?Z0sxNSs1bFlsZS9QSFA5TjRNOXE0c1JaZERkR3VCWFF4VThDdG96WVJJeE4r?=
 =?utf-8?B?bm5CUG5qOUdQTVhNYngvZjRyb1MvL3gxb3VudmNWMzFMTGxnb3JidWZEVmc2?=
 =?utf-8?B?eUFkUjBQQzNPSzFTOEU2UElZTVRiQU9kTU9BdVZBTlZBQUpRWW8zb2NRa0hT?=
 =?utf-8?B?TmRrSWw4ZFRxZmRuaWVDWXZDcjZ0VGtLVGgvZlh0VVVUNEFlZVJVakpISVd1?=
 =?utf-8?B?Tjd3aldTSmlKLzdjTHZrVU1BTEpqNGlCYTRxRkxqYW5OcmJSM3NjMkNmRTNZ?=
 =?utf-8?B?dzRvLzI0a2ZjZUlleXhGUGF0ejduTU9pQ0xKbXdDYUx1T1NSWDVENXJtMm9B?=
 =?utf-8?B?MXJJVENoOFUvNkNIR3hiU3J1bVhhdW8yRWozSWtuY0dHSTIyUkc1bXVjblU5?=
 =?utf-8?B?VER3MnhhMXlpWGlxd2hVU0syVVMya1ljZ2dtbHlWa0tiWS85S1oxc0hYMHlr?=
 =?utf-8?B?M2RVczJHN09jMVRVMUFxT0N5RWoyZUFNYXdEYVI0ZENIS1U5SWhtTVp5cjZH?=
 =?utf-8?B?T3VjUUNydGtzUXZQSEpLckQ0MEo4NjJtQXlXT2RDMUR1dHFRLzhBZU9VOS92?=
 =?utf-8?B?ektoVU9JRWthNytlOFo0ai96QUNyNUpwZjBuR0RDQS9QRzVPcll0TWdzLy9p?=
 =?utf-8?B?d0lycHRyV3AvNmU4UEgvVUl3K3RNZGxMSFFwcVNUM29IRGYxZ2R4MmZvTmE1?=
 =?utf-8?B?RkdxM08wY1BaVzVWRlFYeFFjS3NaRmdsTnRPdm9yNGlPamVsR2FPcUpTUGZB?=
 =?utf-8?B?dkxpZUh5T3pyQlFRUjVtMlVRNkJDRDBJT2RNM1lIUXF4dVJxdHBzSFM5Vllu?=
 =?utf-8?B?SndJYmhkcVoxVDV6NThZZWtmdDdhL1NaS1ZmN3c3bk9UbG51eUlqUlp4T2I3?=
 =?utf-8?B?cmpWUVVjVGFGamxkMGd3WXlOYit3RDlqTWhIU0FBbE5LMVBFNGZVOGZjS3pq?=
 =?utf-8?B?M210RlhRZzJwRStCdDhNNFBGNk92N1Z2SFNWNEhQNXV5S0J6eXNwVEdkRi9N?=
 =?utf-8?B?K05TY0dZb1JrbnUwNzNYR1lIaFFWRXR5MDdvVU5OVlFGSzE0UkdOeWx2Z3hV?=
 =?utf-8?B?R2V0ZExPdk81TWx6dlAzTXZFQ3F1NlplQnErNkRyQzgydmhIYzUxTEg4Qjd2?=
 =?utf-8?B?Zi9rcFRPbXlseGJ4eVlCcm9ieWUvMmdZNjVzSUxRVTVRUlMwYlNJajBxMjRR?=
 =?utf-8?B?NXFnM2daTG1iNHJNaUQ1YkhqNW90cGg1OU5ORUdOaWpnNG5NaGVlUXkyaml2?=
 =?utf-8?B?VjhweGlFZXNMRVhDRm9wc3d5VVNLait1MVQ4ZFdaazZNa0dWOVAwVWxqRjZI?=
 =?utf-8?B?S1UwekRmN0wxZWxhUHI4SzFZWi82V2xxWHd1SGpYQW9UTXFJb0wxZDBYSXNF?=
 =?utf-8?B?N0RrbjZNTmNtY25aLzA1dlkrNDFHNEgrREJESFdKMnJvUVh1VEtJM0tqbEht?=
 =?utf-8?B?OE0reG9rdWw3ekYwSTRTdnUyODhaZlFRUzQ2amJCempBbFRFYWYvMzZIaGhK?=
 =?utf-8?B?NE1aaUJld21OVTVlY1lkZjlyVHJ2enZRN3VQbk15eGo0MFcvcDJOM1U3ZzA3?=
 =?utf-8?B?RnZYVFFPR2lQbmFqSmF1UFdoM1pjUjN3THVXRlJjVkdJMm5TcjVSTlNwNUM1?=
 =?utf-8?B?WEJGVnV0MXExNHFZVERWbTl2cFlGL3B3TFB2OFN3ckJNWW1FMCt1OGlLd1FK?=
 =?utf-8?B?bTFOTFk4ZXUrSnhGZDdYSmlrdjVmTm8yVXpDa1UwbGcwRldSdkdLUktGQlJV?=
 =?utf-8?B?K2NWVkdseS9OTmFrYXowQnhQUjMxL3RMMUZZaWl5dHpiN2ZuNkhUOTQ3QmdI?=
 =?utf-8?B?SW9LL21BeXJaajYvOTBKd3E5WTgxQkU2dllEaDJIWWxjTDZXdGl3dmZwSWpK?=
 =?utf-8?B?SFRIbkk3bG4rWjlmYlZya2pUSUV3NFlDcDRSbnB4Rk1kNm01UUpIQS9kUGtx?=
 =?utf-8?Q?BMdxgyEYdrxHkGEDmo7GwrdC7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c5dedd-80ce-4d7a-3222-08dc7aa43b4b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 21:14:56.8899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWjoe5xHOlE+F1gmXX6BvWubqAXQ0vxAS9wdh+psaL41kSTR9a24lFggaLD5buorG9FrOe/tIVWDG4LCjhR2HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8054

On 5/22/24 13:24, Borislav Petkov wrote:
> On Wed, Apr 24, 2024 at 10:58:02AM -0500, Tom Lendacky wrote:
>> The PVALIDATE instruction can only be performed at VMPL0. An SVSM will
>> be present when running at VMPL1 or a lower privilege level.
> 
> s/when running/when the guest itself is running/
> 
>> When an SVSM is present, use the SVSM_CORE_PVALIDATE call to perform
>> memory validation instead of issuing the PVALIDATE instruction directly.
>>
>> The validation of a single 4K page is now explicitly identified as such
>> in the function name, pvalidate_4k_page(). The pvalidate_pages() function
>> is used for validating 1 or more pages at either 4K or 2M in size. Each
>> function, however, determines whether it can issue the PVALIDATE directly
>> or whether the SVSM needs to be invoked.
> 
> This all talks more about what this is doing and I'm missing the "why".

It's sort of there in the first two paragraphs. I'll re-word it.

> 
> It sounds like when you're running a SVSM under the guest, you cannot
> use PVALIDATE but the SVSM should do it for you. And you should start
> with that.
> 
> The rest/details should be visible from the diff.
> 
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/boot/compressed/sev.c |  45 ++++++++-
>>   arch/x86/include/asm/sev.h     |  22 ++++
>>   arch/x86/kernel/sev-shared.c   | 179 ++++++++++++++++++++++++++++++++-
>>   arch/x86/kernel/sev.c          |  25 +++--
>>   4 files changed, 253 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
>> index cb771b380a6b..32a1e98ffaa9 100644
>> --- a/arch/x86/boot/compressed/sev.c
>> +++ b/arch/x86/boot/compressed/sev.c
>> @@ -130,6 +130,34 @@ static bool fault_in_kernel_space(unsigned long address)
>>   /* Include code for early handlers */
>>   #include "../../kernel/sev-shared.c"
>>   
>> +static struct svsm_ca *__svsm_get_caa(void)
>> +{
>> +	return boot_svsm_caa;
>> +}
>> +
>> +static u64 __svsm_get_caa_pa(void)
>> +{
>> +	return boot_svsm_caa_pa;
>> +}
>> +
>> +static int svsm_protocol(struct svsm_call *call)
> 
> Function name needs a verb.

Yep, taken care of based on an earlier patch.

> 
>> +{
>> +	struct ghcb *ghcb;
>> +	int ret;
>> +
>> +	if (boot_ghcb)
>> +		ghcb = boot_ghcb;
>> +	else
>> +		ghcb = NULL;
>> +
>> +	do {
>> +		ret = ghcb ? __svsm_ghcb_protocol(ghcb, call)
>> +			   : __svsm_msr_protocol(call);
>> +	} while (ret == SVSM_ERR_BUSY);
>> +
>> +	return ret;
>> +}
>> +
>>   bool sev_snp_enabled(void)
>>   {
>>   	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
>> @@ -146,8 +174,8 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
>>   	 * If private -> shared then invalidate the page before requesting the
>>   	 * state change in the RMP table.
>>   	 */
>> -	if (op == SNP_PAGE_STATE_SHARED && pvalidate(paddr, RMP_PG_SIZE_4K, 0))
>> -		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
>> +	if (op == SNP_PAGE_STATE_SHARED)
>> +		pvalidate_4k_page(paddr, paddr, 0);
> 
> That is a bool so put a "false" in there.

Ok

> 
>>   	/* Issue VMGEXIT to change the page state in RMP table. */
>>   	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
>> @@ -162,8 +190,8 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
>>   	 * Now that page state is changed in the RMP table, validate it so that it is
>>   	 * consistent with the RMP entry.
>>   	 */
>> -	if (op == SNP_PAGE_STATE_PRIVATE && pvalidate(paddr, RMP_PG_SIZE_4K, 1))
>> -		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
>> +	if (op == SNP_PAGE_STATE_PRIVATE)
>> +		pvalidate_4k_page(paddr, paddr, 1);
> 
> Ditto, but "true".

Ok

> 
>>   void snp_set_page_private(unsigned long paddr)
>> @@ -256,6 +284,15 @@ void sev_es_shutdown_ghcb(void)
>>   	if (!sev_es_check_cpu_features())
>>   		error("SEV-ES CPU Features missing.");
>>   
>> +	/*
>> +	 * The boot_ghcb value is used to determine whether to use the GHCB MSR
> 
> s/The boot_ghcb value /This is used/

Ok

> 
>> +	 * protocol or the GHCB shared page to perform a GHCB request. Since the
>> +	 * GHCB page is being changed to encrypted, it can't be used to perform
>> +	 * GHCB requests. Clear the boot_ghcb variable so that the GHCB MSR
>> +	 * protocol is used to change the GHCB page over to an encrypted page.
>> +	 */
>> +	boot_ghcb = NULL;
>> +
>>   	/*
>>   	 * GHCB Page must be flushed from the cache and mapped encrypted again.
>>   	 * Otherwise the running kernel will see strange cache effects when
>> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
>> index 8f180fd3cbf0..e6f1ed3f6ce3 100644
>> --- a/arch/x86/include/asm/sev.h
>> +++ b/arch/x86/include/asm/sev.h
>> @@ -187,6 +187,27 @@ struct svsm_ca {
>>   #define SVSM_ERR_INVALID_PARAMETER		0x80000005
>>   #define SVSM_ERR_INVALID_REQUEST		0x80000006
>>   #define SVSM_ERR_BUSY				0x80000007
>> +#define SVSM_PVALIDATE_FAIL_SIZEMISMATCH	0x80001006
>> +
>> +/*
>> + * The SVSM PVALIDATE related structures
>> + */
>> +struct svsm_pvalidate_entry {
>> +	u64 page_size		: 2,
>> +	    action		: 1,
>> +	    ignore_cf		: 1,
>> +	    rsvd		: 8,
>> +	    pfn			: 52;
>> +};
>> +
>> +struct svsm_pvalidate_call {
>> +	u16 entries;
>> +	u16 next;
>> +
>> +	u8 rsvd1[4];
>> +
>> +	struct svsm_pvalidate_entry entry[];
>> +};
>>   
>>   /*
>>    * SVSM protocol structure
>> @@ -207,6 +228,7 @@ struct svsm_call {
>>   
>>   #define SVSM_CORE_CALL(x)		((0ULL << 32) | (x))
>>   #define SVSM_CORE_REMAP_CA		0
>> +#define SVSM_CORE_PVALIDATE		1
>>   
>>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>>   extern void __sev_es_ist_enter(struct pt_regs *regs);
>> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
>> index 6f57eb804e70..b415b10a0823 100644
>> --- a/arch/x86/kernel/sev-shared.c
>> +++ b/arch/x86/kernel/sev-shared.c
>> @@ -40,6 +40,9 @@ static u8 vmpl __ro_after_init;
>>   static struct svsm_ca *boot_svsm_caa __ro_after_init;
>>   static u64 boot_svsm_caa_pa __ro_after_init;
>>   
>> +static struct svsm_ca *__svsm_get_caa(void);
>> +static u64 __svsm_get_caa_pa(void);
> 
> Are we being lazy again? :)
> 
> So I know the below is bigger than two silly forward declarations but
> forward declarations are a sign that our source code placement is
> lacking and if we keep piling on that, it'll become a mess soon. And
> guess who gets to mop up after y'all who don't have time to do it
> because you have to enable features? :-\
> 
> So in order to avoid that, we'll re-position it to where we think it'll
> be better going forward.
> 
> Btw, this is the second time, at least, where I think that that
> sev-shared.c thing is starting to become more of a nuisance than a code
> savings thing but I don't have a better idea for it yet.
> 
> So let's extend that ifdeffery at the top which provides things which
> are called the same but defined differently depending on whether we're
> in the decompressor or kernel proper.
> 
> IOW, something like this, ontop:
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 32a1e98ffaa9..9d89fc67574b 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -130,16 +130,6 @@ static bool fault_in_kernel_space(unsigned long address)
>   /* Include code for early handlers */
>   #include "../../kernel/sev-shared.c"
>   
> -static struct svsm_ca *__svsm_get_caa(void)
> -{
> -	return boot_svsm_caa;
> -}
> -
> -static u64 __svsm_get_caa_pa(void)
> -{
> -	return boot_svsm_caa_pa;
> -}
> -
>   static int svsm_protocol(struct svsm_call *call)
>   {
>   	struct ghcb *ghcb;
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index b415b10a0823..b4f1fd780925 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -11,20 +11,6 @@
>   
>   #include <asm/setup_data.h>
>   
> -#ifndef __BOOT_COMPRESSED
> -#define error(v)			pr_err(v)
> -#define has_cpuflag(f)			boot_cpu_has(f)
> -#define sev_printk(fmt, ...)		printk(fmt, ##__VA_ARGS__)
> -#define sev_printk_rtl(fmt, ...)	printk_ratelimited(fmt, ##__VA_ARGS__)
> -#else
> -#undef WARN
> -#define WARN(condition, format...)	(!!(condition))
> -#define sev_printk(fmt, ...)
> -#define sev_printk_rtl(fmt, ...)
> -#undef vc_forward_exception
> -#define vc_forward_exception(c)		panic("SNP: Hypervisor requested exception\n")
> -#endif
> -
>   /*
>    * SVSM related information:
>    *   When running under an SVSM, the VMPL that Linux is executing at must be
> @@ -40,8 +26,47 @@ static u8 vmpl __ro_after_init;
>   static struct svsm_ca *boot_svsm_caa __ro_after_init;
>   static u64 boot_svsm_caa_pa __ro_after_init;
>   
> -static struct svsm_ca *__svsm_get_caa(void);
> -static u64 __svsm_get_caa_pa(void);
> +#ifdef __BOOT_COMPRESSED
> +
> +#undef WARN
> +#define WARN(condition, format...)	(!!(condition))
> +#define sev_printk(fmt, ...)
> +#define sev_printk_rtl(fmt, ...)
> +#undef vc_forward_exception
> +#define vc_forward_exception(c)		panic("SNP: Hypervisor requested exception\n")
> +
> +static struct svsm_ca *__svsm_get_caa(void)
> +{
> +	return boot_svsm_caa;
> +}
> +
> +static u64 __svsm_get_caa_pa(void)
> +{
> +	return boot_svsm_caa_pa;
> +}
> +
> +#else /* __BOOT_COMPRESSED */
> +
> +#define error(v)			pr_err(v)
> +#define has_cpuflag(f)			boot_cpu_has(f)
> +#define sev_printk(fmt, ...)		printk(fmt, ##__VA_ARGS__)
> +#define sev_printk_rtl(fmt, ...)	printk_ratelimited(fmt, ##__VA_ARGS__)
> +
> +static DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
> +
> +static struct svsm_ca *__svsm_get_caa(void)
> +{
> +	return sev_cfg.cas_initialized ? this_cpu_read(svsm_caa)
> +				       : boot_svsm_caa;
> +}
> +
> +static u64 __svsm_get_caa_pa(void)
> +{
> +	return sev_cfg.cas_initialized ? this_cpu_read(svsm_caa_pa)
> +				       : boot_svsm_caa_pa;
> +}
> +
> +#endif /* __BOOT_COMPRESSED */
>   
>   /* I/O parameters for CPUID-related helpers */
>   struct cpuid_leaf {
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index bb6455ff45a2..db895a7a9401 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -138,7 +138,6 @@ static struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
>   
>   static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>   static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
> -static DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
>   static DEFINE_PER_CPU(u64, svsm_caa_pa);
>   
>   struct sev_config {
> @@ -616,18 +615,6 @@ static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
>   /* Include code shared with pre-decompression boot stage */
>   #include "sev-shared.c"
>   
> -static struct svsm_ca *__svsm_get_caa(void)
> -{
> -	return sev_cfg.cas_initialized ? this_cpu_read(svsm_caa)
> -				       : boot_svsm_caa;
> -}
> -
> -static u64 __svsm_get_caa_pa(void)
> -{
> -	return sev_cfg.cas_initialized ? this_cpu_read(svsm_caa_pa)
> -				       : boot_svsm_caa_pa;
> -}
> -
>   static noinstr void __sev_put_ghcb(struct ghcb_state *state)
>   {
>   	struct sev_es_runtime_data *data;
> 
>> +
>>   /* I/O parameters for CPUID-related helpers */
>>   struct cpuid_leaf {
>>   	u32 fn;
>> @@ -102,6 +105,8 @@ static u32 cpuid_std_range_max __ro_after_init;
>>   static u32 cpuid_hyp_range_max __ro_after_init;
>>   static u32 cpuid_ext_range_max __ro_after_init;
>>   
>> +static int svsm_protocol(struct svsm_call *call);
> 
> You get the idea...

I'll do a pre-patch that moves and reverses the __BOOT_COMPRESSED ifdef 
and then re-apply and adjust the patches based on this.

> 
>>   static bool __init sev_es_check_cpu_features(void)
>>   {
>>   	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
>> @@ -1186,7 +1191,65 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
>>   	}
>>   }
>>   
>> -static void pvalidate_pages(struct snp_psc_desc *desc)
>> +static int base_pvalidate_4k_page(unsigned long vaddr, bool validate)
>> +{
>> +	return pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
>> +}
> 
> There are those silly wrappers again. Kill it pls.

Done.

> 
>> +
>> +static int svsm_pvalidate_4k_page(unsigned long paddr, bool validate)
> 
> Will there ever be a pvalidate_2M_page?

Not really. There is a multi page state change request structure that 
can be a mix of page sizes and will operate in large groups by looping 
through the entries.

> 
> If so, then you need to redesign this to have a lower-level helper
> 
> 	__svsm_pvalidate_page(... ,size, );
> 
> and the 4K and 2M things call it.
> 
>> +{
>> +	struct svsm_pvalidate_call *pvalidate_call;
> 
> Too long:
> 
> 	struct svsm_pvalidate_call *pvl_call;

Sure.

> 
>> +	struct svsm_call call = {};
> 
> I guess this needs to be
> 
> 	struct svsm_call svsm_call = {};
> 
> so that you know what kind of call it is - you have two.

Ok.

> 
>> +	u64 pvalidate_call_pa;
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	/*
>> +	 * This can be called very early in the boot, use native functions in
>> +	 * order to avoid paravirt issues.
>> +	 */
>> +	flags = native_save_fl();
>> +	if (flags & X86_EFLAGS_IF)
>> +		native_irq_disable();
> 
> Yeah, this'll change.

Right.

> 
>> +	call.caa = __svsm_get_caa();
>> +
>> +	pvalidate_call = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
> 
> That's almost a page worth of data, we don't zero it. How sensitive
> would this be if the SVSM sees some old data?
> 
> Or we trust the SVSM and all is good?

Correct. The SVSM can look at all of the guest memory anyway.

> 
>> +	pvalidate_call_pa = __svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
>> +
>> +	pvalidate_call->entries = 1;
>> +	pvalidate_call->next    = 0;
>> +	pvalidate_call->entry[0].page_size = RMP_PG_SIZE_4K;
>> +	pvalidate_call->entry[0].action    = validate;
>> +	pvalidate_call->entry[0].ignore_cf = 0;
>> +	pvalidate_call->entry[0].pfn       = paddr >> PAGE_SHIFT;
>> +
>> +	/* Protocol 0, Call ID 1 */
>> +	call.rax = SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
>> +	call.rcx = pvalidate_call_pa;
>> +
>> +	ret = svsm_protocol(&call);
>> +
>> +	if (flags & X86_EFLAGS_IF)
>> +		native_irq_enable();
>> +
>> +	return ret;
>> +}
>> +
>> +static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr, bool validate)
>> +{
>> +	int ret;
>> +
>> +	ret = vmpl ? svsm_pvalidate_4k_page(paddr, validate)
>> +		   : base_pvalidate_4k_page(vaddr, validate);
> 
> 	if (vmpl)
> 		ret = svsm_pvalidate_4k_page(paddr, validate);
> 	else
> 		ret = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
> 
> No need for silly wrappers.

Right, changing that from previous comment. But are you also asking that 
the if / else style be used?

> 
>> +
>> +	if (ret) {
>> +		WARN(1, "Failed to validate address 0x%lx ret %d", vaddr, ret);
>> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
>> +	}
>> +}
>> +
>> +static void base_pvalidate_pages(struct snp_psc_desc *desc)
>>   {
>>   	struct psc_entry *e;
>>   	unsigned long vaddr;
>> @@ -1220,6 +1283,120 @@ static void pvalidate_pages(struct snp_psc_desc *desc)
>>   	}
>>   }
>>   
>> +static void svsm_pvalidate_pages(struct snp_psc_desc *desc)
>> +{
>> +	struct svsm_pvalidate_call *pvalidate_call;
> 
> shorten to "pvl_call" or so.

Ok

> 
>> +	struct svsm_pvalidate_entry *pe;
> 
> See, like this. :-P
> 
>> +	unsigned int call_count, i;
>> +	struct svsm_call call = {};
>> +	u64 pvalidate_call_pa;
>> +	struct psc_entry *e;
>> +	unsigned long flags;
>> +	unsigned long vaddr;
>> +	bool action;
>> +	int ret;
>> +
>> +	/*
>> +	 * This can be called very early in the boot, use native functions in
>> +	 * order to avoid paravirt issues.
>> +	 */
>> +	flags = native_save_fl();
>> +	if (flags & X86_EFLAGS_IF)
>> +		native_irq_disable();
>> +
>> +	call.caa = __svsm_get_caa();
>> +
>> +	pvalidate_call = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
>> +	pvalidate_call_pa = __svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
> 
> As above.

Yep.

> 
>> +	/* Calculate how many entries the CA buffer can hold */
>> +	call_count = sizeof(call.caa->svsm_buffer);
>> +	call_count -= offsetof(struct svsm_pvalidate_call, entry);
>> +	call_count /= sizeof(pvalidate_call->entry[0]);
>> +
>> +	/* Protocol 0, Call ID 1 */
>> +	call.rax = SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
>> +	call.rcx = pvalidate_call_pa;
>> +
>> +	pvalidate_call->entries = 0;
>> +	pvalidate_call->next    = 0;
> 
> Or you simply memset the whole thing and be safe.

We could, but that is clearing a 4K page each time... and the SVSM will 
still rely on the entries and next values.

> 
>> +	for (i = 0; i <= desc->hdr.end_entry; i++) {
>> +		e = &desc->entries[i];
>> +		pe = &pvalidate_call->entry[pvalidate_call->entries];
>> +
>> +		pe->page_size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
>> +		pe->action    = e->operation == SNP_PAGE_STATE_PRIVATE;
>> +		pe->ignore_cf = 0;
>> +		pe->pfn       = e->gfn;
>> +
>> +		pvalidate_call->entries++;
>> +		if (pvalidate_call->entries < call_count && i != desc->hdr.end_entry)
>> +			continue;
>> +
>> +		ret = svsm_protocol(&call);
>> +		if (ret == SVSM_PVALIDATE_FAIL_SIZEMISMATCH &&
>> +		    pvalidate_call->entry[pvalidate_call->next].page_size == RMP_PG_SIZE_2M) {
>> +			u64 pfn, pfn_end;
>> +
>> +			/*
>> +			 * The "next" field is the index of the failed entry. Calculate the
>> +			 * index of the entry after the failed entry before the fields are
>> +			 * cleared so that processing can continue on from that point (take
>> +			 * into account the for loop adding 1 to the entry).
>> +			 */
>> +			i -= pvalidate_call->entries - pvalidate_call->next;
>> +			i += 1;
>> +
>> +			action = pvalidate_call->entry[pvalidate_call->next].action;
>> +			pfn = pvalidate_call->entry[pvalidate_call->next].pfn;
>> +			pfn_end = pfn + 511;
>> +
>> +			pvalidate_call->entries = 0;
>> +			pvalidate_call->next    = 0;
> 
> You did that above before the loop. Looks weird doing it again.

It's because we have to break down the 2MB page into multiple 4K calls 
now. So we start over and enter 512 4K entries.

> 
>> +			for (; pfn <= pfn_end; pfn++) {
>> +				pe = &pvalidate_call->entry[pvalidate_call->entries];
>> +
>> +				pe->page_size = RMP_PG_SIZE_4K;
>> +				pe->action    = action;
>> +				pe->ignore_cf = 0;
>> +				pe->pfn       = pfn;
>> +
>> +				pvalidate_call->entries++;
>> +				if (pvalidate_call->entries < call_count && pfn != pfn_end)
>> +					continue;
>> +
>> +				ret = svsm_protocol(&call);
>> +				if (ret != SVSM_SUCCESS)
>> +					break;
>> +
>> +				pvalidate_call->entries = 0;
>> +				pvalidate_call->next    = 0;
>> +			}
>> +		}
> 
> I have no clue what's going on in this function. Sounds like it needs
> splitting. And commenting too. Like the loop body should be something
> like svsm_pvalidate_entry() or so.

Sure, I'll add more comments or expand the comment above.

> 
> And then that second loop wants to be a separate function too as it is
> calling the SVSM protocol again.
> 
>> +
>> +		if (ret != SVSM_SUCCESS) {
>> +			pe = &pvalidate_call->entry[pvalidate_call->next];
>> +			vaddr = (unsigned long)pfn_to_kaddr(pe->pfn);
>> +
>> +			WARN(1, "Failed to validate address %lx ret=%#x (%d)", vaddr, ret, ret);
>> +			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
>> +		}
>> +
>> +		pvalidate_call->entries = 0;
>> +		pvalidate_call->next    = 0;
> 
> And here it is again. If anything, splitting and comments are needed
> here at least.

That's because you can only pass a certain number of entries to the SVSM 
to handle at one time. If the kernel is in the process of validating, 
say, 1,000 entries, but the CA can only hold 511 at a time, then after 
it reaches the 511th entry, the SVSM must be called. Upon return, the 
kernel resets the CA area and builds up the entries in there again, 
calling the SVSM again when the area is again full or we reach the last 
entry to be validated.

I'll add more detail in the comments.

Thanks,
Tom

> 
> ...
> 
> Thx.
> 

