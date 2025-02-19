Return-Path: <linux-kernel+bounces-521601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECD6A3BFCD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978C23AF0F5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E1E1E7C23;
	Wed, 19 Feb 2025 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NpNAPF8R"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562051E5718
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971441; cv=fail; b=sLNOFJHSTv2e995Vnts18YEY7pi2wroZTaQf9/FdrFxoJeME5SlvkOLarBV6SHd6wQZL2XBKLBMV+kMzAQvqmyJHK+WI2nRLJbTSJGF8IoIGdKtHfDmrkJtFp+vhqVb76u33JX+TOutmXTQUaKzyiazz1vZKCp31P6OcPcsOn0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971441; c=relaxed/simple;
	bh=B0DPKv7jQw7NuyJCR8wQHqEykJKcBruSMnbV6Bja4K4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SVWN/ob2qAPsSmlGCf5UBbSgeRNDa4PPiCII+ztWjGzrLzj9EGdbYzg2C3bFuhn9AE/23ci4LKQvm3uTQjpN1ghO/ARUVLEYtZ0rqfkR5FFCJSolJbYCahtcSj2pvtroroKklFeZMRpbSGb4U4qEjW+Eg5QrXXPw9eWZrmLTI+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NpNAPF8R; arc=fail smtp.client-ip=40.107.101.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDBPtxklDnWz0Ck5gog0FTEbg6orUt9ihOth1GbozKHFBTs/yaj569i/zXme8gJqxBsos8cOBw8uSI+s+BEQc9t+JS9bYDXI9vwzHFnK4HPc9GPIG67O31I11Tip6hmOQo9vQSFAiEQMHVcCkjIGhN0FOUDKib+CjPbsrlNHiYjbWMjEFRSjKkqXtvj0GxC1Esbi1/f5IqQ8tybhC8GDcrxi/jA8cil5YbOEJQNVnskfhOYDrHVBsBS4xL5lvOsFUW3Ypbsc4ROBC7j7qP27FIe9vf8b3FiEgwZejaBjE71VTWb+lCRIfkrUDDggBe7GsQKoRjk5ofLTYL1ZdskiBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnQhyl/HscOCHSJ2YHZuaB0yhIxU5broTHsbK8+pb9Q=;
 b=RLsQKoDzCeSfzWtRd+8R89fJa2CzZN60FmWp0YTYKs4TWRUH2Eu4hQVnlm12IVOlvQ/bCvL4i4puBQxWsyW40Pi3k2hnKDmNJH7U8oNm38LOhsZ2HW4zhnMtE+6ZTiMbDDa17DbhrvIhHZZ0e+83wqCHbQWRYt/wZQqEsbPRKLgLyO4q/xQj5TExYCTsFalxAAI6b6Riba0SEqNYO2pfp49E8wLf/2dmFVZd9ulP7cBQVxmwZAqS6PUb4hFbeB3OOyeo/tov9p53I59SQuL4jikU5HYvX2vakwMIaWDNZMGdn/d3c7zn/XdTSJmCDbgW4XT2bVg8AFruJxmg25qgUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnQhyl/HscOCHSJ2YHZuaB0yhIxU5broTHsbK8+pb9Q=;
 b=NpNAPF8Ro8q/dhkWQSreAfXiODyKY30uXI5gK6qK8aVOjrw4XNLL7qvfQaY3ahJ2NPDUkMTDvN3wG+Hv0nhephtWFNUkpuwEAIE7wyqvy5TVK2GeW6w64VlnvPrJsIT8r1MLf9JtRyosLwUHneoUPXWW3sZAudwwzL3WjoeRQGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY8PR12MB7316.namprd12.prod.outlook.com (2603:10b6:930:50::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 13:23:56 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 13:23:56 +0000
Message-ID: <e8dfc3df-69d6-46ba-81db-4a04484fb7c3@amd.com>
Date: Wed, 19 Feb 2025 18:53:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/24] perf: Make perf_pmu_unregister() useable
To: Peter Zijlstra <peterz@infradead.org>
Cc: "mingo@kernel.org" <mingo@kernel.org>,
 "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "willy@infradead.org" <willy@infradead.org>,
 "acme@kernel.org" <acme@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "irogers@google.com" <irogers@google.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250205102120.531585416@infradead.org>
 <20250205102450.888979808@infradead.org>
 <1f4e4bb1-ba5e-4e5f-b6e3-e7603e3d6b0e@amd.com>
 <20250212124945.GH19118@noisy.programming.kicks-ass.net>
 <57fa247d-9c85-4f20-9723-d568272651f9@amd.com>
 <20250214202438.GB2198@noisy.programming.kicks-ass.net>
 <a3b1a1fb-03a4-4f67-9f44-9157ee421913@amd.com>
 <d585f337-5ce7-4a02-b890-5f3888e59ad0@amd.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <d585f337-5ce7-4a02-b890-5f3888e59ad0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::6) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CY8PR12MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: 7461ba33-a625-4dcf-9d1c-08dd50e8a912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzJqN2F0TnFzdFozcEo3WVVvRDdhOHpZQ3ZqSWxNTmNLRUhkOHUzZ1pwc212?=
 =?utf-8?B?dFpFRmxFUm9yRk5vdmU2VExrckFXajZBL2twWUVEb3pEUm1EMW45OUExdmR6?=
 =?utf-8?B?VUk4a05tNlNvaE54M0Y5TGpBcTlsOUVydnpXanFDVitDVEFTTFRnMnVSTklH?=
 =?utf-8?B?VEpySkhDcUtJOEsvRG5OL1ZKeWE5Zk9OMXE1T3AzMWppU0Z0YjA5QVROV1d4?=
 =?utf-8?B?VWxUUVhPeWducTU5bWJWZWUrZTllQnhKK1kvYW1iQWNWU0JEK2YwKzE0SlYw?=
 =?utf-8?B?YS9jakxEL0pzUVFiK1Jib2tyZXRmQzlac3pnczFKdlJSdkI2bkJkL3RsRkd4?=
 =?utf-8?B?a2N5ak5uR25WaGJadVljbWpQSHNtNExHWUw5NzdGRC9qbm1yalRkdnJnZWU1?=
 =?utf-8?B?a1JIS2tDVXI5Q1lSMmc3eU90dllGY0RvdWVIemhJSzdYaUxpa3g2V0hEMHJy?=
 =?utf-8?B?Z3BHeHRlMG8zRHQ5ZzlpbHArUm9UbDF0a3ZCbGZROHF1cE44UWN6Qkc0NU9N?=
 =?utf-8?B?K21neVNSazloNzlwK3pHK2JZdGpuR1ZTV01iZGE4REpjL0dIR3kydHJoSkhk?=
 =?utf-8?B?MUZiR3lCWkkzTlJnWm0xNm1uRDRudUJ3MWVoNlpFeUtibXJ5aXR4M2c3bDF1?=
 =?utf-8?B?aUZqRnNpTDJtT1BDTVU3NjNTWHpkY3kwTkMxdXFOSHJHeWl6M25KS04xQzNY?=
 =?utf-8?B?eC85Z05SUWlCN2phUDRxRlRPeFlWNkFWTHZOamxYZzBnM1pJSzh3T09RRUl1?=
 =?utf-8?B?ZnR6dkxLQlFFbk9LaUh0NlM4L1FnY3RqTFB3b0hkdUN5QTJubmxFNjY3Slo1?=
 =?utf-8?B?U09NcUc4NGZoeWtTYitud2RKMHM2V3JkdjNZaCtMb2dsazQzeG9PUEpiUEY4?=
 =?utf-8?B?QnAzOEVwYWV1emhrMlUrbzhsUFlZMnhvbThOOVIwbjkxVmZVOFRkWTdYTzdQ?=
 =?utf-8?B?aVBzUUFHZERvRGhzdVEvU1EwcHl2bHJZOTJQZjg3ZXUxWDNWSlAyZ1hCSCt5?=
 =?utf-8?B?bmowZ0hBTmtMNm1GWUEzTWUxZkg5NmxSd0ZmUXlmSlk0U1NVZ0IwYVhLQWRF?=
 =?utf-8?B?WHFDajVSNGxwaFdRQWxvT2wyOWhVRU1mMnlOQjN3b3l2eCtvanNRcldDQjQ3?=
 =?utf-8?B?U3hFRHlLdC9JWCtRRFozeFhuaVpSMHVwRTd5cVZqTUVLOXYzTDQ0Z0s3RXNG?=
 =?utf-8?B?Mm9NNUhkVkJEMERzd3R6OGlEVjc4dzZEWis1dVRtWmRLNW5KdXVpMC9ORkxh?=
 =?utf-8?B?TEtON3MzZmQ0UVY2d010bStjdzNrcVNYS0xEYzRlaUNEWGZ3QzNma2xUMXdK?=
 =?utf-8?B?NVhhVmJlM0JYcFVyc1NDK1Z0aU9SREF5SWhscTJDMlk0S0ZCWWdLSG9qemtR?=
 =?utf-8?B?WERqa2RXbWdwYTV4bmhIcWExSWhXNGxDN3dXZHI5TDhKaENvSkxMbTQyWTRJ?=
 =?utf-8?B?anA3QXliQjVaeUlmWklKMjVlV2kzdnE0Znh6czc5bUhxcDg3c3gwK2tKK1NG?=
 =?utf-8?B?VGlZU1FqT3JERFR2cjVPT25xZjBvU2JaK094aFNicnVGV3VtQ0lCbzFXWGVD?=
 =?utf-8?B?dEsvSkNCQ1RhZjQ2alppTmp6VkQ3bkZlWWxKWjVzTjM1TGxDOHFuYzZNQ2gz?=
 =?utf-8?B?QUx5UkpQRURiM2pXd2hIM2FpRHhBc09LbStZb1hXczBMK2k5bjhuRWMySXp3?=
 =?utf-8?B?eHJpMXVzUFEvYUxNekx0M09xRzBFdjhsdFFzbllvNFB2TkV2Yjl4TWVqRzl4?=
 =?utf-8?B?N3FwTU1pU3FRQ3daOEV0cEY3K1FGSysycXlwWDlVbWdCUmJrZXcyUnVhZmpY?=
 =?utf-8?B?Q2NxL2tEV3IydExpTTh5ZHZYMkNMQnk1OHJOODZIbmF4N0ZJSGE0RFJMc2k0?=
 =?utf-8?Q?RBc1x6z2/Zu1U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmNQb2IydEwvVThTQjUrVmg4RzFXdkFLZktFYnM4RE1DMWNteXR6MHdoejRy?=
 =?utf-8?B?WitCTEZlaUtMT09Id0pIMy8rVWhEYkdEQjZrV1VqdEg5NWZ2b3JoemhYNFNW?=
 =?utf-8?B?VmJuZ3M2WDl3WGZ6RUM0NVBodzIzcTVvN0JQR3V4RDNISktxN0NMTC9CWjdp?=
 =?utf-8?B?N0IwUVZDeURRV2c2QzA3YzR6dDNEcmM0ZUdIblk3ZGNyNkkyZ1NIRHU3eGti?=
 =?utf-8?B?L0tFenU0TTRlZGZlMkFDQjU2T1VEZCsrUnFPM0NYUTZHUUV4Q1FrcFRpVC91?=
 =?utf-8?B?azNoM0JsNjZMV1NjUUZhQlFVODBBM3Erb1MyQ3pOV2ZYSTliRHkwS280OWZM?=
 =?utf-8?B?LzBJZVJqNWdLeG5vOVVPMDNGRFVXOXQ3M3J1cXYzakwxRms3bDY4MlE2WGoy?=
 =?utf-8?B?WnRNMlJsR29OTnd5Z2ZDK2RYNXRTMVBrbHV2ZXV3NFZNV0ZOL0tmNE1PSEN1?=
 =?utf-8?B?ZjlZREthL1lDRStRcXZwQjFwcW1yV0ZhdmZoQ29tWG5CRW4vUk5tMjBLK1dz?=
 =?utf-8?B?RVpXQnVON0RQYXI3blNxRXhnWk5xRWVDeXpCRFdxcFY2Q3huRy94WTF5SmRZ?=
 =?utf-8?B?UzEvQ1N1WEQzN1ZmUnF3M1poYWxxNGVsa0o4NmlOZ2lVcWhTUWJRK3ZZRXZO?=
 =?utf-8?B?NWZVWGFzdy9SY2JiTWVmdUNVSUd2bS80bkgwak01UTR0Ly9uV0djWVhpaGFy?=
 =?utf-8?B?bmpIemREa3lsdTNkc2dOcGNFWEhFbTRucTE1S0FEVTBSdVRzTEkrRVNpOHNS?=
 =?utf-8?B?c3MvL1RsY3E1VzdZUnJDeEFvdjRJYm5xdTV4VkN1WWRUb3JpRy9ZQ25DT2lu?=
 =?utf-8?B?a2J1LzMxTkpyQVhOSStteEZmWUtQYVpuNmluYXBkeFJ4OFNadUN1YXYrYlRt?=
 =?utf-8?B?R3ByM2VhdzRVMEN5L1poQUVtdlltWlF3VFRjbFRCbjFnTENtcHRJMTJPRDhS?=
 =?utf-8?B?WWZkUXI4bnpQeDcvbE5WNDZHcTRUaldEa2QxYmtIdHFPaTB4SWZqWjNTSGgx?=
 =?utf-8?B?Q1FyUU4ySWRzSVZDYUhNZU5vcHdXbStwak1xeHFTeDFUTnkxVmMweFBCd3A5?=
 =?utf-8?B?M3M3YkwzZEo3Si8wQ3ZHUnJrWDJrTjdmREFpVm9QSVVQaU5iYzcvSzBwMXlj?=
 =?utf-8?B?cm13V3lieUp3Y3JYV3plaVNTZCtnQVViUzhYNDBYdHFpQzhXZVg3eTZqaERz?=
 =?utf-8?B?Q2dKSzRLK0dqckpTRjJtN09vaHZ3Smw5WnRnTXdoSWRmemFXNXhYVVlzV09G?=
 =?utf-8?B?NnM2Sis3YTVRN2dWKzhpOHlEcVk5cjM1QjRzbjBYNFZFSWREeXRUbTlFZkRG?=
 =?utf-8?B?RlVFKzJucXI4dmVNaklrVEIyUjFhRkJycUVaQnh6Qk1xTWxyYTBqZ0NpNUpV?=
 =?utf-8?B?U29HQUhjV0xzcG5lc3JSOEhvMW1PdVpKeTRmMnRDY1M1YVVuT2xDcUlnWVRz?=
 =?utf-8?B?SmNJSm1jR0I2eUkzaVN5aWdtamZlNmpvVmZHem01Y05ha1dsWktHaWlmZzRD?=
 =?utf-8?B?Q3BEbGxHeTlhdGtyK2dVYmI0WXMvS2xuejhoOHlxSWdTdC8yOXl5UFZoZUlw?=
 =?utf-8?B?U2hqenhxM1NLQ3Z1dDVxenpPTVBON2wybnBwSkFhR244RmR2QTN4K29GdEd4?=
 =?utf-8?B?NXQzREcvY2hsYTAxWnF3YWc1V2M2S3R6VzlSWmlST2lWMTRzUTBiK3FKc1hK?=
 =?utf-8?B?TlF2RkI5YmZiT082Z1ROZ0ROcTJEUFBsMFR4ZHVpcjJ0WVQwbm9EK1lwTU10?=
 =?utf-8?B?bXJnYkR3RytFUVAvdXlFNE9uN1ZpTTlnZ3Q4ZnZ1b1QxREgrc1JRR2hGeVdN?=
 =?utf-8?B?ZmNscUtjYWZXZ1VWaXhMbTV0Qy9xbUlXdjY3empSWDduTmNIZ1ZuR0ZHMTBR?=
 =?utf-8?B?YW52NWd2SWxUVHFYWjZUcUxzc3AxUGRLZ2NLaCtsYk5CUEFHcVl1UUkxQ2ls?=
 =?utf-8?B?QTFiYzQvOWlqbVJMZk5sVktKdGlKeFAvVFZwVy8zS2FuQTRZZHdYVlBwY3Rr?=
 =?utf-8?B?V3FyaU1ObjFXNUduWEJISFdjV01ENHRwb1B5cW13ZFM0VWl0dDNZejAzdW0v?=
 =?utf-8?B?UWl3YnZoRkJXTS9WS1B4Wi9kVXcvQXZ2Tm1yNGNpNVdlUDJ5cWtvMExaQVhQ?=
 =?utf-8?Q?5MNtuAM4TdJSA0io44fp+HWK3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7461ba33-a625-4dcf-9d1c-08dd50e8a912
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:23:55.9439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42LDJdyqxPcd5I70ugsThyv+nJvzGr/e8zIAGeACWDeP7JouzyILoGfy8K9MYMP2sUXWJ2erqNI8OZ+1kVcjUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7316

Hi Peter,

>>>> Apparently not, it ends up with:
>>>>
>>>>   ------------[ cut here ]------------
>>>>   WARNING: CPU: 145 PID: 5459 at kernel/events/core.c:281 event_function+0xd2/0xf0
>>>>   WARNING: CPU: 145 PID: 5459 at kernel/events/core.c:286 event_function+0xd6/0xf0
>>>
>>>>    remote_function+0x4f/0x70
>>>>    generic_exec_single+0x7f/0x160
>>>>    smp_call_function_single+0x110/0x160
>>>>    event_function_call+0x98/0x1d0
>>>>    _perf_event_disable+0x41/0x70
>>>>    perf_event_for_each_child+0x40/0x90
>>>>    _perf_ioctl+0xac/0xb00
>>>>    perf_ioctl+0x45/0x80
>>>
>>> Took me a long while trying to blame this on the 'event->parent =
>>> NULL;', but AFAICT this is a new, unrelated issue.
>>>
>>> What I think happens is this perf_ioctl(DISABLE) vs pmu_detach_events()
>>> race, where the crux is that perf_ioctl() path does not take
>>> event2->mutex which allows the following interleave:
>>
>> This one was only with perf_fuzzer, so pmu_detach_events() code path was
>> not invoked.
> 
> I think the issue is, unaccount_event() gets called for the child event
> after the child is detached. Since event->parent is NULL, unaccount_event()
> abruptly corrupts the perf_sched_work.

A different manifestation of the same underlying issue (perf_sched_work
is getting corrupted because of event->parent = NULL):

  WARNING: CPU: 0 PID: 5799 at kernel/events/core.c:286 event_function+0xd6/0xf0
  CPU: 0 UID: 1002 PID: 5799 Comm: perf_fuzzer Kdump: loaded Not tainted 6.14.0-rc1-pmu-unregister+ #263
  RIP: 0010:event_function+0xd6/0xf0
  RSP: 0018:ffa0000006a87828 EFLAGS: 00010086
  RAX: 0000000000000007 RBX: ff11001008830ee0 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: ffa0000006a87850 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000000 R12: ffa0000006a87918
  R13: 0000000000000000 R14: ff1100010e347c00 R15: ff110001226c9a40
  FS:  0000000000000000(0000) GS:ff11001008800000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000595fed7d3e12 CR3: 000000016954c005 CR4: 0000000000f71ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? event_function+0xd6/0xf0
   ? event_function+0x3d/0xf0
   remote_function+0x4c/0x70
   generic_exec_single+0x7c/0x160
   smp_call_function_single+0x110/0x160
   event_function_call+0x98/0x1d0
   perf_remove_from_context+0x46/0xa0
   perf_event_release_kernel+0x1f3/0x210
   perf_release+0x12/0x20

With the above trace as reference, something like below is what is
happening. (Code paths are based on my understanding of traces, I've
not verified each an every bit :P)

  Assume:
  task1: event1
  task2 (child of task1): event2 (child of event1)
  task3: event3

              CPU 1                                             CPU 2                                                               CPU 3                                                       CPU 4
  
                                                  /* task3 sched in */
                                                  perf_event_task_sched_in()
                                                    if (static_branch_unlikely(&perf_sched_events)) /* true */
                                                        __perf_event_task_sched_in()
                                                            ...

  task2:
  perf_event_exit_event() /* event2 */
    event->parent = NULL /* by perf_perf_child_detach() */
    free_event()
      _free_event()
        unaccount_event()
          if (event->parent) /* false */
              return; /* won't get executed */
          perf_sched_work <== OFF  ------.
                                         |
                                         |        /* task3 sched out */
                                         |        perf_event_task_sched_out()
                                         '----->   if (static_branch_unlikely(&perf_sched_events)) /* false */
                                         |             /* __perf_event_task_sched_out() won't get called */
                                         |
                                         |                                                                            /* task3 sched in */
                                         |                                                                            perf_event_task_sched_in()
                                         '-------------------------------------------------------------------------->   if (static_branch_unlikely(&perf_sched_events)) /* false */
                                                                                                                             /* __perf_event_task_sched_in() won't get called
                                                                                                                             So cpuctx->task_ctx will remains NULL; */
  
                                                                                                                                                                                         close(event3)
                                                                                                                                                                                           perf_release()
                                                                                                                                                                                             perf_event_release_kernel()
                                                                                                                                                                                               perf_remove_from_context()
                                                                                                                                                                                                 event_function_call()
                                                                                                                                                                                                 /* IPI to CPU 3 ---> */
                                                                                                                      /* ---> IPI from CPU 4 */
                                                                                                                      event_function()
                                                                                                                        if (ctx->task) {
                                                                                                                            /* task_ctx is NULL whereas ctx is !NULL */
                                                                                                                            WARN_ON_ONCE(task_ctx != ctx);

                                                                                                                            ^^^^^^^^^^^^

IIUC, event->parent is the only way to detect whether the event is a
child or not, so it makes sense to preserve the ->parent pointer even
after the child is detached.

Thanks,
Ravi

