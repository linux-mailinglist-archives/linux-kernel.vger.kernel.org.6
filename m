Return-Path: <linux-kernel+bounces-361500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC2999A8FB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594481C21486
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0046819A2A3;
	Fri, 11 Oct 2024 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BmGrpwdf"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9E11990C7;
	Fri, 11 Oct 2024 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664547; cv=fail; b=QLIbGgZoorVcOH0eNLFgyNpzbEuwO/axn0IP5EoF3F6KROKcx1zYD9gibW/JwGRRXEnopah+qs41MB0ASAt37OK7/e2W2eaC6vXsvRot8ToEgnlFkL1BXe+YFlC5CqfYqB25gOCofHXQ2EkuI3VFk8YtFR6evhglTQJyt0n2gss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664547; c=relaxed/simple;
	bh=5pl7HCFDhY+dR5fkFE3i9bkZkho8jhIBvW94XshvQnw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uC5D8l7kBrFN4RbOnoN10rWfJ6DHBp2UaE2NtHWO7RBB9ySbdbJlrWPjAdJm+ab56GEt9Dm/i52qtB1KHNHD/6mk1FmoQRWkml4tNByTcl5ivFFop/Xbkc0+m4Gx2N8BaiTHu0kNBCBup3+955DCQFxrfxZFA5Lu74Cs098xukY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BmGrpwdf; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoMyP48619r6EHccnKjE8olHTgwdRfgNUEMLsSbLGRI6nOeSyCsaBfWfZpv/21NAR6R3XDxUQwv6UNmRnYrK6L9lrZPFm4F39SWQBx1R/jafzAp2OnZwAtgeZFDPrqIqQB+pivBQOW5DQ2ji18SxfaBB0toLEtx3a8T4parfUYN/4e50IbAhp2J2IhI9UcnOfogcGdhfSRdj2YCMQq6dkJCk99AKqW1h97L20/t6HK3dIkbb9jmRZRDEgri+By3FYryi9hHN3W7DIjk8X93bxcaZhLfV5pAZzVzEgojh47u6uNRsIG/lO4ZGX6f8HxgmFNaFdRuRTidGHkrBS2eu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxuiFzu59Q02fj4zr9t3F+x6QO14TKQHAGvmsEcLZNA=;
 b=nm3HEyXmOxqP0W0noT4wb5iWSditp8LeGT7BvmJnoym73LYEOrMROkMFYvZYV92NL6VC1Ft27wOLlEZfNlrK/j9cq4BZgkfZyoAOr04I5klhGsdhdYCMXxt7z0hlnyKD1/DOzqyf8UKlmpQ64I15JF7qlorY4WciMWmJgt/MXZY6w2LAGvh2JFLpJWqc73lVwaU3f5jau+hWALell46PLp5BaKA5hWBjMbK9VFNmDeaooYXio/t3yK+TCtcEsQkPi4KfZV6YeWv+tsPQE19P3p8MKo/Zh69NzjtQLi7+QZkqUPpdSJb0t079pV+drsw2S/DsqR0LooauaTJD7Iod7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxuiFzu59Q02fj4zr9t3F+x6QO14TKQHAGvmsEcLZNA=;
 b=BmGrpwdfCHgqsKmCukXg3FPtnKG2qvO7GUPPgXG1d6Tpk9p2PGcOPHEONYvViMiEi8v3lCvCp03KHcg9v5ReWcMc5a65FIsQpodPOS1l/EhgQANqyqojx8EwrbGbAEw1zbl7tJvUppSOWZz6mAhq8vEgAUIcblmsjsCmcjH39Po=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SN7PR12MB8602.namprd12.prod.outlook.com (2603:10b6:806:26d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 16:35:43 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 16:35:42 +0000
Message-ID: <f8a3a683-0cdd-d1bb-1904-521ce5a96dac@amd.com>
Date: Fri, 11 Oct 2024 11:35:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 1/2] x86, KVM:SVM: Move sev specific parsing into
 arch/x86/virt/svm
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Pavan Kumar Paluri <papaluri@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-coco@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Eric Van Tassell <Eric.VanTassell@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Dhaval Giani <dhaval.giani@amd.com>
References: <20241010121455.15795-1-papaluri@amd.com>
 <20241010121455.15795-2-papaluri@amd.com>
 <20241011162120.GDZwlQgKTFi22JZ5If@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20241011162120.GDZwlQgKTFi22JZ5If@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::15) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SN7PR12MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa2d6d2-4578-4a75-072c-08dcea12bfc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2xuaEVlY01YZndmTkFLOGN3aHJzcjVsc0RVcGJZTjBjVWloeklLSVpsL2JW?=
 =?utf-8?B?ZEhqOEpFQW9DOVNMaFVaM0lJT1kwcjJPVDdnT3ZXRkxkNnd0NEFsaHFobGtW?=
 =?utf-8?B?VTd6Ti9jVGVkL09BTldwZWQvVVlnRE5PS1h6aGh2NVhKLzNkd2paamFuTFdj?=
 =?utf-8?B?dGtBNncrQTVidkxFbG1vK3AvbW1ZMzdUUDdJaXhTUXEyWkNRUnAwdlgzMmRR?=
 =?utf-8?B?Zis5TjArL25mMHlyZGtzSkN2OUxSZW55L29XZ1hKQWJIMUVLNG10ZmZEbjRq?=
 =?utf-8?B?ek1iWHduV2MzNlk4VEhoR2dLUUFpRGpVZjExTE1LeGkyWmtTNGtrZ0drNDEy?=
 =?utf-8?B?ZEFSZlFoaHE3NWZ2bVZ0ZXdZd2ZMbDkxT2FlZUcrM3lkMDJES3NleDNhTS8v?=
 =?utf-8?B?OGtLWmZkQldWR1ZsN1I3cDYrZ1NkOU1SRjBtcnB1TWwwSG9wZlRGTVFsbkFx?=
 =?utf-8?B?dS9KbkJ1Q3o4bmQ3eVBLNzZDcS9PZmZBcVBOajRXVU9XSy9PN1FpaDhQR0Yx?=
 =?utf-8?B?VW9ZblFpdm1mV2RMVitYN2ZpUGs2QWZlM2dHT1pyaUp5S1NlNGpEVTVORTZu?=
 =?utf-8?B?VjhqWTNITnBPYzc0OWlDNk5qbjBtNG4rM0xFcnEyYlFqWW9oWkc3NTFsenl0?=
 =?utf-8?B?b0FNSHh0WmNObndBVTB4QUVTT3NIY0plVHJLdGVuV1dkdEs2eE1NVkl0VGV5?=
 =?utf-8?B?a2wvcDhJOEtNbzlOSUpPU3l6MUMzaGRTaENNbEZmRDdZaitXZ0RFSVBLZWFh?=
 =?utf-8?B?K1ZlbXh4RWxIYU1md0lKcG5DRndIblhsblAzRkdPYnZRblVQeENMVzJNQnhI?=
 =?utf-8?B?M3AyOWJxOEhVYk02NEo4WEtWUDlLWHo2WFlIRnVZSU1WckMyWHdKTlVIWUlu?=
 =?utf-8?B?dUpCWVM1aTJER2p6TjJ4Z01zbHVrblVyU3JIMUt0QTZFZ3g0TjRZbENQTXEz?=
 =?utf-8?B?Wk5JanI3UnlFNm1LcGlsR29RNEdlLzFXUVU3OGlUMnZYeDQ2alRmbVV3cUxY?=
 =?utf-8?B?eEZwKzBLa2V5SXQwSHFlLzJHNHdoRUdQL0w2ZTMvTFNCdFUwc0pTZWE5N3dj?=
 =?utf-8?B?dFhMTm0xRnJ1dXdGeXVKRjZURkNiaFZ4MmMySjUrQkEwS3NIWGFPcGROYVF4?=
 =?utf-8?B?eEFta2g3b3VEamt1QU1OMU03eUI1U3ZUZ0V1anlUcXIyL1kvVll2WnJyRTdS?=
 =?utf-8?B?bWp5UlliV0x0ejNVbVkxT2FMVXM5a29LeDhucFk1TC8xTXJQZkxCblJ6c3Z4?=
 =?utf-8?B?dWYvQnJGU0xPTXJvS1p2VkJBaElKZ3o2Q2pQWE5HN2owaGd5V2VhZWhyQ1R0?=
 =?utf-8?B?a1RnSmt5UFpKUE9DK01hUFRvK0NTL2pyUGhGRjRYWlNhb0xha2FleTVQSWx5?=
 =?utf-8?B?V1J1YTBEZnZRVWxnZGlDbnd5MytwOWhBMm42TXo5cjEvbTI3aEd3YWhKYWEw?=
 =?utf-8?B?YXVmMGZWMHRJNDdyQ3RYdTlsRFh0ZEdXOHh5NGY5bjFybVR4Z1R0a0xGZm82?=
 =?utf-8?B?TExwRnJXZ3Z2R0wyRXZSekprL3Uvb29PYWNrUGJ3YXMvcHRMQ3BTRTlVSW9O?=
 =?utf-8?B?MGRiVVhrazZTN2RQa0Q0QXR6RytlbG9PTDczNktXNEcvV0NtcHd5YTJkV0Yz?=
 =?utf-8?B?dkdOOUhaQURpenJ2YjFacndUcnd1VTJzSERZbDVYOTNGVmJzT2dXSjVaMWtY?=
 =?utf-8?B?R1ozMjVWK3dLNHRRT01KS1J0Z29FVnhhMjVPdkpybmx5bVNWU0FrWFJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE81K1RKSDkxOXU5NTRvVTZTK2tzQW5UVUdhelFtRTVXc2ZicVdJUGVITkdr?=
 =?utf-8?B?U081ZGpNTVNlRVZYVmEzMVVMWGhNaFN4TUo2azcwMWU1UkRTR0J3OUZkUTFB?=
 =?utf-8?B?bGl3YWYvaHF5ZUJVY3pkazN2dmJTNmI1WUNjVTZxamNxN2krUW81ME1TdHJU?=
 =?utf-8?B?MVhmRUhSWVNFN01sakZyMSt3dlZacHNVTXRTVEdhdGRPU09aM2hPODdWQzI3?=
 =?utf-8?B?UisxUGRxamZSVmxDOG5QVGkwbjFET1BkSkFKb1FwUmFnSFF1ZCs3Q1l2RWYz?=
 =?utf-8?B?VEc3aWt0aVdURXJGVlpBRGZqTVdwYTZOQzA3SUNieVBTRVdXaXRWZnhvdnRn?=
 =?utf-8?B?V1Zaclo4eVhaMmNubmNMbDBJeHE5aEFvTm12c0JQbVQ2SWZNR2s1YVlZMG5X?=
 =?utf-8?B?cDJxL0h2VUkyemZpTFhqanlXa0pwU2hNUTBva3RmZXJjZUtUUmVKV3dpZmxY?=
 =?utf-8?B?a2RBeWt3VU9xWHkxVWM2bHk1dVI3UWlFaERZNklTTXBXNzU5dFhPN2tBbDFs?=
 =?utf-8?B?QkcvcWhMMk1NdkhsQkNkSGFXQ0ZNMVc1d3VQLzhSMXU5RnU5bWk4Y01EclBV?=
 =?utf-8?B?N0RkWkRndE8zUzdMbnpmelZhd2kzMDdSc2o0YStHQ0dzVllZUnRqelNKNHQr?=
 =?utf-8?B?RUdOdEl1TkdMczhZdEpZOTliOFBJQ21Jaklpcnh0anNicG12M1R5QlNvUUZa?=
 =?utf-8?B?NlJaY0FWblJKVEthNm1ObjlGcmZjS1ZXUWFHRHBwSVVlUXdrTFk0MEJCMkti?=
 =?utf-8?B?NVkxNkF1c3RrTERsU2RxcklUcjM3TjlkaVNINE93VitBb2UxdVNOYVdkZnc3?=
 =?utf-8?B?eEl1NnlBc3Y3SlpnKytyOTNZcmsxOVlxTGN0NHJYakJCVEpmOWoxZ2I4WlRM?=
 =?utf-8?B?aTZlUG1TSHpiYmFvZEhscUlNcjE5TDVMUHY2UHM4YW51ZGtJLzJhTDJmbkc0?=
 =?utf-8?B?cGp0VnRTRGd5cE16UnJhRU9jVWpOdnk0c3RJWGdTVkJRL2Y1eW5DUlpmbTNW?=
 =?utf-8?B?YStEMDBtcU5QbGE5RktFS0VFeGVnRHlpd0JTZ09FcHVJUXUzQjJRank0MmlK?=
 =?utf-8?B?ekR0ZnIwRm1RODQ4T3RuaEpVT2ozZVdsUGw5L2NiYmwrL0dtakdENHNOQUlG?=
 =?utf-8?B?clc1YVFuOEZtL2hUSnF5Y3p6TDIwVC9ROTkrOEdtZTV1OUJ6bVZLT0tSSTVT?=
 =?utf-8?B?OExHV1Q1d05rTXRXOFlsbmJ6RlRvU0tqUDF0a1NLdWpqTkk0bFJRaFpVMzls?=
 =?utf-8?B?Zk9kTUxnQ003dlhoaUFYR3BRZHRWWEZGQk4wb1NSNHJKUTcva2t1UG42OFJO?=
 =?utf-8?B?OWs5V21YYVJJd0x5YWhGM2w2U3piVWRJeGQ5MUFHSEs4S3FqYTVGRWhhbUZx?=
 =?utf-8?B?blpab1owck1sR1BaMVQxMkNDWE4wdFRiNzJEQWF1R3JEaHJmM1g5TGVWNWxm?=
 =?utf-8?B?cVAwN3B5amM2ZWxRVUVFaTVONkVESm04UkUwZHFZK0JncUt1aFRBYk1xTlNB?=
 =?utf-8?B?MEt4V3p1bzBiSmtEeWFrRDBZeDhtUGk4SFhCbnJ0bkQ4K0d0d2hiQjd1SkRW?=
 =?utf-8?B?NW5Ycnk3ZUFia1RuM3lvKzBQMFVMZGQ0Y3BrYVprQ2wyWko2S2xFWjZCd2o1?=
 =?utf-8?B?MDFaK25QWEkvN1hSYU83Y1lDai9LUElnVEF0STBNUXhrUnhrZHdtbnpTZi8z?=
 =?utf-8?B?MmMrZ3BuMGpid1B2eVBEZ0craEY3ZjZwdGVoakpzaVBHNStRRmwxUnRlRGFk?=
 =?utf-8?B?TnB5dFZCZkdBZ1FIdE5VMnIxTmtKaU1obmRjYXNZOFhLaFJNOHR1RjJCS0pR?=
 =?utf-8?B?U3praFJlbVB1VTRhaEVUd3N4UkQwMGFoRSsxOWx2UmhOV1VCb0lOM0RMUFJ6?=
 =?utf-8?B?UU9Zak0rMnVDdWt0SStwSGV6WkZ6anFsT2IrN2tFTEZ1OThoS3VjN212VDNx?=
 =?utf-8?B?dHgzd3VoOEVXUDhUaFFkOXUwZTFxaWF3eTdZWkI3QXJHYzJKWkxZQU9XWjhm?=
 =?utf-8?B?UTRNcm43TzhiN05sK0pSSmJXNG5MN1BtZDhwL1NBR2tsekhORjFJMXdDSjZj?=
 =?utf-8?B?MUtEVFlIdXRrSDVHc1VLZ1RRV0pvOW0xZFVQdUk5OUV0MnU0OS84SWY2OWUw?=
 =?utf-8?Q?ifPBEMNESNnalxpUPtn8yscnM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa2d6d2-4578-4a75-072c-08dcea12bfc3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 16:35:42.8809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+9pib1G1TV8WkwTlMVB/WZ3+JDLH42BCPWsUE/bWB7e7VBLkyaqGTh25kvyZ39aYEr2XtXXva7NLdlzcpHU3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8602

On 10/11/24 11:21, Borislav Petkov wrote:
> On Thu, Oct 10, 2024 at 07:14:54AM -0500, Pavan Kumar Paluri wrote:
>> Move SEV specific kernel command line option parsing support from
>> arch/x86/coco/sev/core.c to arch/x86/virt/svm/cmdline.c so that both
>> host and guest related SEV command line options can be supported.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Pavan Kumar Paluri <papaluri@amd.com>
>> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/x86/coco/sev/core.c          | 44 -------------------------------
>>  arch/x86/include/asm/sev-common.h | 27 +++++++++++++++++++
>>  arch/x86/virt/svm/Makefile        |  1 +
>>  arch/x86/virt/svm/cmdline.c       | 32 ++++++++++++++++++++++
>>  4 files changed, 60 insertions(+), 44 deletions(-)
>>  create mode 100644 arch/x86/virt/svm/cmdline.c
> 
> make[5]: *** No rule to make target 'arch/x86/virt/svm/cmdline.o', needed by 'arch/x86/virt/svm/built-in.a'.  Stop.
> make[5]: *** Waiting for unfinished jobs....
> make[4]: *** [scripts/Makefile.build:478: arch/x86/virt/svm] Error 2
> make[3]: *** [scripts/Makefile.build:478: arch/x86/virt] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:478: arch/x86] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/mnt/kernel/kernel/linux/Makefile:1936: .] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
> 
> $ ls arch/x86/virt/svm/cmdline.c
> ls: cannot access 'arch/x86/virt/svm/cmdline.c': No such file or directory
> 
> Looks like you forgot to git add cmdline.c before committing.

But the patch includes the new file, so how can that be?

Thanks,
Tom

> 

