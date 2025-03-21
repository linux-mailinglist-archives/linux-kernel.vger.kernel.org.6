Return-Path: <linux-kernel+bounces-570775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F25A6B455
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31394618C8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95F11E3772;
	Fri, 21 Mar 2025 06:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cMi+S/vz"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3D123A0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537975; cv=fail; b=DSVC++/dZ2/s+cmUZdpy6nG+cHW/XbHUgaptw3J2Iv5EOpQ+fNHwn/hY2CS6WipHnontCZpKIAj7/wPCMrZP1c2xlnvtrv33thfl8Kj4bJuxyOLxgaafcH3wEOQ+3d5kr72CS39jQS/uXRzilLezuI+8OhpOpCEkoexbgCOaax0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537975; c=relaxed/simple;
	bh=cRZAVlIsqBp8z8xHw56VDKGgk3uRP+yHr6rZ6r8WM0k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JNxwR6E46Z0F3q95tkWvu5gB8PEzW0DCMZT0rvqr9eMOQdiEONxsVkEXLbYMBiPBz4MkSTsVwASCoIKg8TqEQlzPC6gLGE3X/kil44AweONlcvmmmF19E02UImsqOlGSruB5eAoAG/a04eNLKaJyPXlH0iNk79vhj6AWUvAhPW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cMi+S/vz; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5GYiGNjgaooK0SM3GmRvRHK6U0l2snxnHNl0cG3r8Of9HPEac15Wh0uzeg9LOe8slJtA3ZuxEta0kGCgf20OLatP9uJp26BwB06KvlXLPRN/vm11qnviGDWL4Ww7QU71XWoQn3FfgJmLSOM2StnrMWskYMLWgtvlIQIaqNgrFIxgHsD3nO/yKLEz02Yh7VVDOvTiCNF16pxE55rA73FvInHvjpHwGQ2bhHp7892AYFLcFiUk80yXii6+/nbQBK8BRLbVjNvWHu7v6xpd6QMI9FXhDZCXtv6v9WOueXduxQuoA4iPYbrO48ds6qAQzO632oq4CZSx62CzmRLqX0ZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX1J9NiQOxHTtLA0Xkc0U9Xv1pm3uGotD04ZQ3DzEj4=;
 b=HLuFE2bWyjKwsDF2O17yhs5X5Odki0MPmjUqUk2XxpYSaK1H8K3b7rUrZ7xyGcFqSTHUmYefA134ISpoCmHVyc7t1xzuymionzuEOp7CfKfDfk5q/wCCK00s3bqUom7XVVubJp5VT1hwBu1Zwp/Wtr1SPuHImDhvcJ4/ycbGZP4qSw+6YJEUEnU7xliMaUl+ZWgC+bxGsbil4g24T9cAgqzDVeUTjenohzOBiuQifwlfGKJUDg42e77k+ajD3ruMwWotUCIdeicSdFS3rr8bCDtHPtUQPTkqFmaQGGXwbIpzkefchWRezA0BmC03ad3vhRIf4xEWfHMNR96J1z753A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX1J9NiQOxHTtLA0Xkc0U9Xv1pm3uGotD04ZQ3DzEj4=;
 b=cMi+S/vzuReOiyXTaEPHEGJ5MmiZ2hR06b7SRT9Bzcw6JkCghE75T0CmXB6aiKNNmlZrk1At/sIE2UE3z77Lio+oUpznhS/ZoJa9tYdAyqrKNCrlb1QhKWnJMMbKS2RCEWudAcnn8+/uciZn+8SLXFE5j56sd7asL9+Ac+TbFmyW02H7Nbq0IRgnrSQEeLshVJQbfKlpuQ39yijX3Y3hAvCmTTli4XM7jr0z1cxHgyTMwJXMXtlMyDelchc9ygX0hYFCf4x6lO9XdDd2eD1RjmFlpPVB3tUa0NKZNkmPoxVMVfv+W1PfW3XPq8+x47UPaOPK3ivUrNpJ8JEdQjKmDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Fri, 21 Mar
 2025 06:19:29 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 06:19:28 +0000
Message-ID: <c49d2a03-b3f7-4d4b-9f4a-cf2eaf8df89a@nvidia.com>
Date: Fri, 21 Mar 2025 17:19:17 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Kernel daemon for detecting and promoting hot
 pages
To: Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Jonathan.Cameron@huawei.com, Michael.Day@amd.com, akpm@linux-foundation.org,
 dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com,
 gourry@gourry.net, hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
 jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com,
 kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
 liam.howlett@oracle.com, mgorman@techsingularity.net, mingo@redhat.com,
 nadav.amit@gmail.com, nphamcs@gmail.com, peterz@infradead.org,
 raghavendra.kt@amd.com, riel@surriel.com, rientjes@google.com,
 rppt@kernel.org, shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
 vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
 yuanchu@google.com
References: <20250306054532.221138-1-bharata@amd.com>
 <c6d9bd1c-9ae6-48ff-88ee-1dfe25eab5d4@nvidia.com>
 <5673b1ec-d970-4aa5-bd58-b5d3504c4eaf@amd.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <5673b1ec-d970-4aa5-bd58-b5d3504c4eaf@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::9) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e90675-20b3-45fa-2d9e-08dd684055f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NW9MN3RlS2hrUlB2QmVtbG1QMlBpbE9rUlFZbkxEUXNjQzQzb3pQeFRxZWxn?=
 =?utf-8?B?bkNUdVd3R1dCWUdqMmQrbkRxV3QxMi9HeUM3QjBUT2dILzZQc1ZXQ2JNSGpS?=
 =?utf-8?B?Z3k1QThjQnVvbkpxbWVvSk5IcUpNY090VWlYREt1M3pHUUkxR3FrZ3dGM2dH?=
 =?utf-8?B?UHByNVFlSmhyMC9hWHJ2cS9HVXBZYk5QYVk1bkN6eWlsRkJNWlp5Uy9ubmRK?=
 =?utf-8?B?SGt3dWI0bklZUzY3Y1A1Y1IvSVBCQ0l5aXF4K0JGYkwvMEw2R21tTWkydm5O?=
 =?utf-8?B?QlR0TFMwZmNYWHE1b3VUUDlCdXUvZlJzbUIzZVlXUzVUUDhsTTdxK2VoWERy?=
 =?utf-8?B?OEtTdlMyUlp3cGJ6djlpZnhJWjk2OUMxWEFVTGtTYmdIV1dTVFQwOTVUMmls?=
 =?utf-8?B?VE1tOU1Dd0lES21Qb3Z2anBCVTdML2R5TjQyWjJGeUF3OHFwZWtaWlY0ZFg0?=
 =?utf-8?B?WlBPOXJQR3pBblNDRzRXVFM1UmREYjgrN3pQczlIV3ZIdXFKZHRlTWpMM2NW?=
 =?utf-8?B?UlY5MFZSRkdPTFhXbXQvcGE2Tjl5OEowc1JrK0RIa3N1WHkvU2ZkVFBNMDBS?=
 =?utf-8?B?bVJjK3RxOVdZMHJCbkRyNXBFQVBvb0JuaGhuRjZlWlBKVHFJWHd1N2JpRStD?=
 =?utf-8?B?N3RCTlJEZlJuaG91WUVhNjVBMWtQUndHUDE1Z21vbnhVVXVuRElJZ3NNdi9v?=
 =?utf-8?B?YTFGazZLMzFSd0tHWVVsTlRHSDQ5TlIvYURMRGsrZ0xROTZEV3VlRzVOQ0dx?=
 =?utf-8?B?bkovaXNadm1mREdDbzgyZmNQZEdWUzRxR0hoMVlNVmRNUEljaWszT2ZMOGky?=
 =?utf-8?B?dU5UV21tbXlhWmZ1ZEtHMjNtTGQ1RjhqQkFXZWhMMkFKdGxiYlJMQ0s5dElx?=
 =?utf-8?B?YVJFSWhxNTNBVUtVVFFPVnZNSnlzNnBUNXZwWGhiNmU2L2JxS2NrRU5ubzJD?=
 =?utf-8?B?YzBnVDdCTStDaVRrcGpxY1YwdncraVUvZFZ2WUVRcHFpZHhqZ090Tm5nNEJZ?=
 =?utf-8?B?VFNDQzc0MTgxS1RUY3hZZmtVbGFNcFA2YThYNHRmcXUzMGJEWDRQV1NLdW5B?=
 =?utf-8?B?N2QrWTRWY3pKaXRSZ3BtYkJYN083aXJrdEdIUndaV0k2RnByWC94c2N4TEF2?=
 =?utf-8?B?NTdqVDRIZkFvckR5U2Q0elBhMmFEUTVzM3oyWnRzZ0l2MmFSanhQYjUySjhN?=
 =?utf-8?B?cVNZSGVSdU9EU1hiNWU3SHBRcWhqRGZueDdBK3ltTnJXeTMvdk9tMllmQnIw?=
 =?utf-8?B?WmZTY3Qzb05mY1BETDkxeTZGcHlYaXJTaEhhWmxOb1JOOWhYVXd1bnF6L2dV?=
 =?utf-8?B?dTY1Tm9lOGNZUTZySURSSWlqeS9uL0xTV2ZmVDdmNHI5dlkwWTBCaVVqZm5X?=
 =?utf-8?B?MGNpcWxlV0I1WlhTU0I2SFFmMk9VcDVMdDZydVNyK24ralNZRVNpNDZuMEVt?=
 =?utf-8?B?SmVjTmcyOVA0NGYwb3BlWnAzaGgxNjZaTlJGVnJTclJkY1NtWGxhOStBRWMz?=
 =?utf-8?B?N0ZRK01Oclhwd2QxejdSYlBWNmNFTkJ5TDc3QWt4RVk2eDhLdDdZRldmZkhT?=
 =?utf-8?B?b0tTaEZBVGhKczZUVW16TEJ1N3NQaE5zdmhIT25odTByRWNFNVRaQ0N3amJz?=
 =?utf-8?B?WnpoY1J2TFpSeFpZSnlGZE11RG9ZZTAvVXloRzRiWW1EOFFaS2VFdVFwMVFK?=
 =?utf-8?B?czRuaWVkeVZ2Y3hSZlFKOVc1SmFBVlVKeERNOUlkc051QTJ1ZElCc0Y0MXhQ?=
 =?utf-8?B?WlZtajlySjlQRW9DZ05tYTkvWEdqYmZ0Z0ZxZks3NHV6TlJZOHVTQXVlYWtU?=
 =?utf-8?B?STRwb09heXE3UDYyL1RQWUN4elRKTi80dldBOWZ5dWZKSnk1UnhqeVRscWFV?=
 =?utf-8?Q?ezIqMi8y/KbXn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEl4K3V6S2w5ZGcvVHF5QXlRd3ZBdmZZT2ZMSHFEUnJteDFoOFUyM0VEdjJ2?=
 =?utf-8?B?RU51UTh6QXZsM2czL2lVWHhiTE5KNkhOa29lQ24vS1VPQlVJNHc5UWkvTnJS?=
 =?utf-8?B?WmU0Z3hPSnVlMjZpSnBqblc4eW1TYjY1dElSd1JIV3ZxUFZTVVBNRzVTZytX?=
 =?utf-8?B?dzNHSDF4TlNHN2VxTk5ZaEdYMVh5K0htZllIQTV1N2RWMXZVNWMvc1hNNTQ3?=
 =?utf-8?B?K0JId2xHUmdQcGdMVjVTbnpvVVpvaUUya2VTTVY3VlllbVVWTHFsaVJEMDFU?=
 =?utf-8?B?U1A1QkVmd21CemxsRGI1dCtzaHVhczlSUXo1WUk1cTdQUVBuVTNqOWFTSjV1?=
 =?utf-8?B?bFZTYURkendrS0JIQzFLcVpnSlQrbUdXNi9XRHhtejN4VVdIRlNjbUk4RThX?=
 =?utf-8?B?ako5Z0c1amZ2TnBJS1NWY3YySWpXRmlNRVdZMVVzeFIySnZ2Y05FSXRWZzhX?=
 =?utf-8?B?NjhsNG9wNk5GK1RlWkpxT2tRVW1XczFBbkdSc1RjUVcxTlYxWC9meWFQbE15?=
 =?utf-8?B?UU56TjBUT2FhWnJnUlRVczg5RSswOHBoZFlKaDQwRDFsWGdjSzh6R0x6NjVX?=
 =?utf-8?B?UlVPZTlKeDMvRStpaGdxeWdHdVVuQ3llYlZHOWJLbmo1UU8vOWF6K0JpS0hz?=
 =?utf-8?B?QUR5Y3dmbFo1NnNzVWVaeSs0M01BeWNHV3pEY2ZxUGVVMlltcHJyNVk0NUZZ?=
 =?utf-8?B?NFpOVTdGY1hGcFQyQzhBZmlLUk9mL1JJaTBlWDJzbS9LWW8zanZDK2JEck96?=
 =?utf-8?B?cTJNaFdJdGJJeEFhOHE2L3ZBQ3VXOXRsMXZheTBaSHZHb2F6VWJOSS9KTW93?=
 =?utf-8?B?MGJSaGQydnpDOExVdnZpWjIrNkZ6VmJsQWlQRW9lM2RiRUs2OFpBQXNzYTkr?=
 =?utf-8?B?cW9GUENSQkp0V3JJK1RZa1lCSGF0NE9LVzQ5a21HVkVYdTZoL0xtMmJTRVFB?=
 =?utf-8?B?SjBON2xVM2hPUTluQ2dwQzR4ZDd2VFJ6UWxPeFVxS2NDbERPMXNkUGEzS0FU?=
 =?utf-8?B?NkxHaG1wSEZ2alo2alRHWWJyV2loSHB1R3lYdFJDb0R4RzBlcjN0Z1Nqck5L?=
 =?utf-8?B?RWhtTEV6c2Z4MzAyWkozS2oxcElCdW9RNDBETStrdGlSOGYwK2paUzcvNDRU?=
 =?utf-8?B?d0toVkFoM0hhekVyc2FEYUpzWlNRTUNMVlBrbWIvVCtwVnJNalQ2NG14VzlL?=
 =?utf-8?B?am9VeGhheU5BaXhKV3Q3TlVaYlpHbURNYWJyeHNueElSOEd2V05YSTNyOHpt?=
 =?utf-8?B?M0REV3h1N1cvNHRDWDFJZkhuNFdyaythbmpwaFVSeHdGck1LbjBTOFg4d1pE?=
 =?utf-8?B?bTdCMitoOWlESGFUaU5hbXNSckthOEhzODdHd0JjWDJCUVdLeFlkaCtWTVdp?=
 =?utf-8?B?NUxML3c1bU9RSXppWlJ2RmNIcW4xcFpUTFZUMEZjNGlTRktaN29LWXpVOWF1?=
 =?utf-8?B?cE1RQXBXZjJQQjlQVm9tUkpGZjA3OTlCK2RaQ2J5bmN3OXpaNEcrbjA2UzJk?=
 =?utf-8?B?VXc3YTdwcVByVmNkOW1WYy92bUtRQnVRYStNTDFZeUlUbm1XR2tNY0h0Ym93?=
 =?utf-8?B?dEhSZXllOHhuN29xSUxudERDWkNVZ041Nm0yem9TVldwMjBDN2tNK1krMG9h?=
 =?utf-8?B?RFBPb3ZlaHY2ZFFXVnd0dVpQREhGSFEwNXdzdDVNaWdBYjUrNDVOa2lmb2xW?=
 =?utf-8?B?ZXdTZlZTOG9lRUpPTWdMWm9OY3dsTjlCRnFsWFRCZytGVVZnRERyakVUQW93?=
 =?utf-8?B?TEd4NWR5eEJGYnhpc0t5dGxiOEpLVDVhcUFxUG1xM094Q3R4Sm1TWFQzMHkr?=
 =?utf-8?B?eVhZZ09sOUw0M1ZqOEE3TlBUVU9aZHltbFUxanJueUNNOGRmNS9tQko4cFkv?=
 =?utf-8?B?MTdmTzh5Ly8yaE83SWVNdnQwMGY5MHEwQmJVU3JvdDZ6bHFuZmxvd1d2NE5X?=
 =?utf-8?B?eFQ0bUZrakE3T1lFVWwyRlZWMWloQkpZeVJtcis5eW5NRXJST08zdGJMbzJ1?=
 =?utf-8?B?dW9YR0lFRVRvUGhhd2g3eWF0SEVZWG5DSU9CeTJtNU1hSjRhVDB0M1ltTVpB?=
 =?utf-8?B?ME9IRWJBa3lpb2RSLy85TXdLTTBOeERDWjFUYlBhR0NvSEFqd04zY2Nhaldv?=
 =?utf-8?Q?BCE0Kr1euxY+6OcOqE2GaW51Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e90675-20b3-45fa-2d9e-08dd684055f7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 06:19:28.7378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPpegk/+FGHbQATzw7Hb4XP+lf3W/wZy+ehOiprtUD/JMeCvlOI5PGmBLstqwn+on5fGZlAVO/DmCOLuNlo6JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103

On 3/20/25 20:07, Bharata B Rao wrote:
> Hi Balbir,
> 
> On 18-Mar-25 10:58 AM, Balbir Singh wrote:
>> On 3/6/25 16:45, Bharata B Rao wrote:
>>> Hi,
>>>
>>> This is an attempt towards having a single subsystem that accumulates
>>> hot page information from lower memory tiers and does hot page
>>> promotion.
>>>
>>> At the heart of this subsystem is a kernel daemon named kpromoted that
>>> does the following:
>>>
>>> 1. Exposes an API that other subsystems which detect/generate memory
>>>     access information can use to inform the daemon about memory
>>>     accesses from lower memory tiers.
>>> 2. Maintains the list of hot pages and attempts to promote them to
>>>     toptiers.
>>>
>>> Currently I have added AMD IBS driver as one source that provides
>>> page access information as an example. This driver feeds info to
>>> kpromoted in this RFC patchset. More sources were discussed in a
>>> similar context here at [1].
>>>
>>
>> Is hot page promotion mandated or good to have?
> 
> If you look at the current hot page promotion (NUMAB=2) logic, IIUC an accessed lower tier page is directly promoted to toptier if enough space exists in the toptier node. In such cases, it doesn't even bother about the hot threshold (measure of how recently it was accessed) or migration rate limiting. This tells me that it in a tiered memory setup, having an accessed page in toptier is preferrable.
> 

I'll review the patches, I don't agree with toptier, I think DRAM is the
right tier

>> Memory tiers today
>> are a function of latency and bandwidth, specifically in
>> mt_aperf_to_distance()
>>
>> adist ~ k * R(B)/R(L) where R(x) is relatively performance of the
>> memory w.r.t DRAM. Do we want hot pages in the top tier all the time?
>> Are we optimizing for bandwidth or latency?
> 
> When memory tiering code converts BW and latency numbers into an opaque metric adistance based on which the node gets placed at an appropriate position in the tiering hierarchy, I wonder if it is still possible to say if we are optimizing for bandwidth or latency separately?

I think we need a notion of that, just higher tiers may not be right.
IOW, I think we need to promote to at-most the DRAM tier, not above it.


Balbir Singh

