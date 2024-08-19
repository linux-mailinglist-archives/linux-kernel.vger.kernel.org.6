Return-Path: <linux-kernel+bounces-292873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EC5957589
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A461283C3B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211E1158A30;
	Mon, 19 Aug 2024 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nMRZdUKv"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F3949627;
	Mon, 19 Aug 2024 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098674; cv=fail; b=G18vsQbuDYDxWFQSQR0c0LXmvU2PB/ODUFKvHIabr45xCrQOWwabeLnFireX9EeIzYH7ASoDqa0CULR0UUzCSg3OCYGd4jPXvk2td3IYRIC6XJzQvP/4qOTCnNz3URMlse/Vcn7Lo5sGj4lsEp8UBgYrtOWH7mJK0cTTyD3zhbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098674; c=relaxed/simple;
	bh=WoD5bO8KsauPn2fjak0HEPswtG3OfpkaqSZ+TlqNFW0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hoFnzk7CNUmPJTFvnjIM0jIBy255SEn1/e59IUHH4L3u8mhhHVhQAu2kHzatrskCQw0ttqdY7NbQDITSHXCVcU9wfBQqVA+RQQKQw0GPI52gCknkAqxUR6BdyL+Gjl03g41kbo7wXzOHpTDs+9Qzcpb0qShE0ZuoqOqwpSwm+CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nMRZdUKv; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L076XhkcbQ+GPEXmktSVmsGnPzM3ZGN7MxeYbHRKcS6PZF//lHFlwc1NDzWY3WE1GJpFKxpRsorfNdSODWjUUMuZBGKD9gMrkfZu2yCSwK9xfqDpYJZGVQ5FykTcZ628ER3cDe3K7TlgjMtxhWREAkjHPV80PigSagTy5Rkk0GMEvzYFg93eqVnljKgvL1yr1xf/M6DRhHTeoTxAqOzzHkKkSCOgqr04ZH8bUKYfEj/r1xVbkR9dRsHj2GVttbD6deRk983D4sDLY1yfNKamfS2GfbWdf5zFLyeiP3E3y21XEOf2xmjuWqvq4s1+maxm4sncGtSKssNBPQpX1vrMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atNYmZtwjKgagy+gLt8ajwnwVMxKyG3qf1T5Qr+pfgo=;
 b=rwHohHod6zZD98Km53VeM6wS+11GOlArGzrR9sC9Eus4iSTOGTEYx5S/ark715yDhwfN41oNY5NlRDAjUEesZqXirNaUW0A3uN2Trdszqj4i3THZzEODBWCiLKAexvp3N9PPzr497z+bSpYtwIHg+cA8loZT6Q4e0qqHeeOpMRfdaEBFKtoCsbB+wmzNCIlAitXtvSBZkMhKlgF3Eef/+QZSF+RoG3Vr7/lDn4QCYz+A+Dy8/k0oTDrdsQplVOxGS0RonIIC/azC1yaKlzPIHwpAbGGWd00oYT9TRpt5gClX2Tdw6PKDyritLvVaC5lfkfd+I9A4eUcOMa0IA+eP3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atNYmZtwjKgagy+gLt8ajwnwVMxKyG3qf1T5Qr+pfgo=;
 b=nMRZdUKv+DH5IYJb3N/lYSZZBgkwO55baxh3xYEjTUuINIya4VNBPKPUO9f8U3UNB2c8IsvS3iTHnL/BGOpgcqm52UuEKa//Wjr0SJuowQbicarkbSB2O0tsRmNcd1ZQTLUEyRQt+DsaZcb6T+LFe8AW7OgKzTu+B2GzgBA92xw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB8556.namprd12.prod.outlook.com (2603:10b6:208:452::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 20:17:50 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 20:17:50 +0000
Message-ID: <93c61ea8-5df7-4705-a77a-d93db8b75c53@amd.com>
Date: Mon, 19 Aug 2024 15:17:46 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 1/7] x86/cpufeatures: Add support for L3 Smart Data Cache
 Injection Allocation Enforcement
To: Borislav Petkov <bp@alien8.de>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 fenghua.yu@intel.com, hpa@zytor.com, paulmck@kernel.org, thuth@redhat.com,
 xiongwei.song@windriver.com, ardb@kernel.org,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 sandipan.das@amd.com, kai.huang@intel.com, peterz@infradead.org,
 kan.liang@linux.intel.com, pbonzini@redhat.com, xin3.li@intel.com,
 ebiggers@google.com, alexandre.chartre@oracle.com, perry.yuan@amd.com,
 tan.shaopeng@fujitsu.com, james.morse@arm.com, tony.luck@intel.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1723824984.git.babu.moger@amd.com>
 <8378af17a73455661845830b40864ec1cbc303ff.1723824984.git.babu.moger@amd.com>
 <20240817145058.GCZsC40neU4wkPXeVR@fat_crate.local>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20240817145058.GCZsC40neU4wkPXeVR@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:a03:255::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: e93cdd29-a112-4c00-2997-08dcc08bff96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QStOTDlYWFR5TVNDQUlvMURzK0NVN2Y1TXliQjVrMHgyaU1zenRoeHE3VXlB?=
 =?utf-8?B?NytCcENJUWlpaHQ4bnZKL2RHQVZMaDZ0ZUlqc1pOTVBGUWVVRVRuVmpkSWRi?=
 =?utf-8?B?R2gwaElGWEtEZVY0RERWMGhmTmt4di9xTnN1SHJGaC9hcldoSmVaeGhGU3pY?=
 =?utf-8?B?Q0llei83NHp3Tzkxa09CVmFvMzNKbS9PZTVJek1HTTNHYitsMFdrRGdPQnZF?=
 =?utf-8?B?Mi9sTnFQZ0RvUVJBWTdTekN2UHM3QjFlMThWT1JzZHh2aEdzZTd5U3c1VFpu?=
 =?utf-8?B?TjNKa1M3VzlCRlZ2cVgvTjVpWk4vQkNBUjNYdzVYN2dKZW4ySmVoODVYWm4w?=
 =?utf-8?B?Sm92WlpUSG5jaEV4YUxQVXhzMXBSNXgvRGNaT3dvUFFjdG4xaFU1L3RhK2dq?=
 =?utf-8?B?clY2eElWdHlRLzhPL09PNzBYcytQV0RhMXluV1NrakVwbVhoL1orN1hBek1O?=
 =?utf-8?B?MHNSQTRvRmZrWFBKd2NncG9YVm0wcHFrcGZHZkJNalJrSUMzVmhqRHNxQzM1?=
 =?utf-8?B?WjFhZHcxTUl6YjNzMDBMSGFqc1B4MzduUUIrdjJPYkl5ZFJ2ODIxbHRXb2o2?=
 =?utf-8?B?b0xhTFg4K3Focys5cmRoZ3h6ZkViSm1kWXFXWWtHdmtsdTN6cnVHa3NnVU9t?=
 =?utf-8?B?MmhNdTA4V041bzVPcVJGWVBsRHpldVdpSWFEYTZIZURxZVNJcEtZc1V5RElZ?=
 =?utf-8?B?OXRRdFJrbjNCUEZOY0hRTVJFZTdieUhKQVdmWmg4cUVJQTYwNWFuUnFVRG9O?=
 =?utf-8?B?SzRSc1pxZzNqczNVU3FKa3o4U3VVL3ludGV2NXc4TzQ5UHJRMHp1NHI5c1M0?=
 =?utf-8?B?UllERFBHcXJlM0MvMzFxTm1aeHFSRTBCSTlzM05Xb2EyZmFGWnRYQndKK3RP?=
 =?utf-8?B?UFdyQUlSd0kyMVJhTTBLc2hjU25xdGY2WTRINE9rL1l5T2FoWXY1alJRWjRC?=
 =?utf-8?B?RnZXTXJyWXUrU2UydEhNRG9OcVlaY3Y1ZTZGOENHcVRCd1pVdUo1Q0QvUDlQ?=
 =?utf-8?B?dHdpeXR0em1NRHFZNWl5ZUQ1V1VXVTdLWk53aVVTZllzMG1SbVBydzRHS0VH?=
 =?utf-8?B?aHIzQWJYOHlzT2RoSGU2dDY3WEtRV29vK29oeEdnOVZIbm8zVDZxSnJvYmIx?=
 =?utf-8?B?VkhaVlF3VjFuQjl3S3MzUVl3ckRhQlE1NzdzMlE1c1dyQXI2cEc5NGhvZ3Fi?=
 =?utf-8?B?NXJsV3IreUhGUTBWdDRsU1V0SFNUT2ZGVGNqZDlFbENocGdLd1p1TWQwdW9U?=
 =?utf-8?B?eGs3NC9mQ0VyOE5kczFwSHJ6SW5pZ1JTLzJabTErSzZyS0VwUnZmRjh0Nzdm?=
 =?utf-8?B?K1RrZXdBU0sxQmlQQWNBQlgzeGVaRngxMVdrZldtR25wdGNrVXFCVjQ2cHFm?=
 =?utf-8?B?QjdHK01QYUh4ZWJDWXB4dzhjTUc3U3RqblBrSEV1UGk2RjlFYVlPaTJBd016?=
 =?utf-8?B?TWh3dUlKdzRtYlg3OFRIRlJ1RU1pM1I0Z2tVdERtN1RNcjdFcmV4bG51YkVB?=
 =?utf-8?B?bHJJWnV2WkhqSDJCSVBZREF6TlRGU1FsbFdsVEdtZlNkd053VlVvSTFRQ0kr?=
 =?utf-8?B?OG83RVRjSURLa1FkU2ZaenpOU1pscndGa2lncVhjLzlqNTlpdDBRNk9rdEdK?=
 =?utf-8?B?bUZZZWxsaFRMM3VHeEVDRkJXeXJ3ZWNlMmF3dWRGSVFtSzVTVlFaVFkyU2ZP?=
 =?utf-8?B?dmZBMXQwbHdBU1B1bnkzMU85bWhJVDZxZ1RjNFZER1VGYm44QW9seEpuNVRz?=
 =?utf-8?B?cGhPMHZTSWh6NUtwYy94dlZtbko1NjlpSUk3ZzVvdkp6TnVJbWNBb2YrdUFU?=
 =?utf-8?B?MjYyWFJBRk5UdkpJenlHZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3hFU3gwWTNzSlI5MldOTEZLdGRYUllFTEYrNXlaWE5mcHdSSlkybkhjam1V?=
 =?utf-8?B?cDhmcm5HdytEQlBJOWZhdnBENVhic0ZhUWRZS1dlQW5kK2lBUVp2cXhmQWdJ?=
 =?utf-8?B?Wkc0ZTN2YytWdC9WSE9NZEYzMS9taExYNE9ZTDE0dlBVaGhrWEhlSkplUTdT?=
 =?utf-8?B?cGxwSnNIek1FLzZEQ3hhTEt5cktzTndPbndlMlRXZ2RqMDBEU01veHdacTV2?=
 =?utf-8?B?WEFKbnJzSWIyYmtSeEkvTXVQcGpWVmRLRjRmRTIyV203aTZGSExhOHQwOUFD?=
 =?utf-8?B?R0xteGlzZTlyK3l5MUVoRkZQcy9hdldtUlhsalJiMlhhUUVieldOdUo0bHFL?=
 =?utf-8?B?Y2U3bGhaVXMzSGw1YndzN2ZaSDVJcjVWWUd3a1ExUCtiWFl5ajhjbG5OTnlN?=
 =?utf-8?B?SkNsV2JRc3QyNEhHNWZjeEc1NC8rODhuL0xWNDFwaXBVaVBLTmd3U3hhblRw?=
 =?utf-8?B?MHViM2wwZ2gxNk42NXM5OGoyVS80K0hUZmc2WlNuUHhIbk44dWl4R2dvSXJa?=
 =?utf-8?B?S0l3cDBqb1k0Q1NKKzBBcFZpLzhsRG1xazdWK3JhcFZNaW13SDFIVElDazZx?=
 =?utf-8?B?YXZ1Wi8zZ2hCMHFhUTRGUnc0Q3ZzcjkxSGZOMHQwQnljaGxHUWRmZ2xTeEZW?=
 =?utf-8?B?SjQxU2NxTDZ4dXkzSEtBVGp0M2NpdVVTZVRSUUVadHpPRmZBZmdKaVY0YU1X?=
 =?utf-8?B?cjh3NVYvajlPa2VXcDBZcE1ZZ0pQQVpTVUY1RHVEZ0JwQ2d4NmFtVEZ0Ymky?=
 =?utf-8?B?bGNYNDZNb2tjSW5HTGZCU1hoZVI2aXlkRG90L0JSUjZ4eUpiaitTeU92d1VO?=
 =?utf-8?B?YVFDZXJYRUVZdFZENVpaMDBZTS9FZFk3SU1BV0JtMk1TcmdMeSs2UjRNSDF3?=
 =?utf-8?B?WEMvbzFudjR0WGwwaXJ6dVRuUlJ4alVtRWJqU1prZDVyYVF6UG5HUG5sbGJB?=
 =?utf-8?B?RVVoYzNveXRWRXcxOHlxSFppWG10U2x3RjREaTNJWmMrZjEyOTIzK0d1bHVk?=
 =?utf-8?B?SUhxMU0zLzBnRWk4dXdxK0g4QUFCRkRUQjRKSFhtd2loYXFxOWhtak4yZkNn?=
 =?utf-8?B?d2VNVk1ZdSt2SWE2UWdvMDRRK3V5aDBnNVlOeHJwVkx5OHdzMVB1UW9aZHBj?=
 =?utf-8?B?TEt1STI0TCtMaVYyMExSQkJxck9jK1JZeUJxOEFXNzQwU1B5YzduWUhxUjNm?=
 =?utf-8?B?N3dtc3QwRmg4aDZNVFBYVlZRbEhxUkl1U2hscTRLSTUwOS92ckhXQURCNW1m?=
 =?utf-8?B?YjhzZjgwMXF2VS9VWCs0biszd1h2aWFMMnVYd25QcWlTS01ueC92ZDNiYWM5?=
 =?utf-8?B?KzNyYkh5eEtnZXE5LzZxN2N3Z0cyWG5zK3BZSVk4Q0N3WWViT3NTMVFUOGRH?=
 =?utf-8?B?S09hRWd2K25BeHo5ekxnSC9TYmlRUGJncU5ObUdmT2pmTmpOMDhNbTYxVWI0?=
 =?utf-8?B?NytobitWaHpWZVhaUXlGc2lHcUJmNXQ2Y1dVQ2g1NlA2RkdkWTdubHg2emMr?=
 =?utf-8?B?NWtZYVV2YjhBcldMc1FQMDdySk5jRmJIM0J0MG0vQXJQOWNncDFDNXdaOFI3?=
 =?utf-8?B?RysrenVBS0w0Z3ZlSDFMOUJuaXZqSU94Q0p2b3Rla0JvUDcrRkZKZnhJN2dq?=
 =?utf-8?B?WWRBeTdubmplVW1nWXJKMjVJOUxsbHFmdmFrUlBtT3YySEpwY1JEZ3lHdHFQ?=
 =?utf-8?B?alhtVitiYitOOCtJY0dDckxUM1RhVHpUSXZWY1hqanBxUkpNTzZ5MnRjNUhV?=
 =?utf-8?B?ZkUrWXJzQktzOXliMmJaeUgyQytaRVVmWmVGdkcrSUdUdlBuOHMzV1hYbXN1?=
 =?utf-8?B?ajZRc1BZSHVyMkM5eVNLQlMrWURpS3N4enowVkhnSU45Ykc1c2JHTkhTZEht?=
 =?utf-8?B?RXZ2N041R0Y2OEswLzV1NzBjcTNkNDBuWnBZcW1jUHFyR3RWemF4Y2ZyQ3k4?=
 =?utf-8?B?eEVUZGJZTVIxYnEydFhQUWFoaG1VbnRLdENIMC96V2U0MlFCOVowWVdpZFZm?=
 =?utf-8?B?bnVFbTBCaTRXR2pHQkZVVXZkMUNvY2FuRnE0Z0RlajhwSk1FQlFmMDRlbE4r?=
 =?utf-8?B?OWNGSGZROGsvV3NCVHFtbjFzbU5HdVRYNnNWUE5ISS9rdUlrT3luc3hmdDBh?=
 =?utf-8?Q?9+AQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e93cdd29-a112-4c00-2997-08dcc08bff96
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 20:17:50.1918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exBiz257++Ar3SvU0caxdldijW8xIfp7zuQXCT9hPtdiItwZptDQB8XYp5BSFTsc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8556

Hi Boris,

On 8/17/24 09:50, Borislav Petkov wrote:
> On Fri, Aug 16, 2024 at 11:16:18AM -0500, Babu Moger wrote:
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index dd4682857c12..5ca39431d423 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -473,6 +473,7 @@
>>  #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
>>  #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
>>  #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
>> +#define X86_FEATURE_SDCIAE		(21*32 + 6) /* "" L3 Smart Data Cache Injection Allocation Enforcement */
> 
> The "" is not needed anymore - feature flags are automatically NOT added
> to /proc/cpuinfo.

Sure. Will remove it in next revision.

-- 
Thanks
Babu Moger

