Return-Path: <linux-kernel+bounces-518052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 639C9A3892A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A093AAF4A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26084224AFF;
	Mon, 17 Feb 2025 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Iv8bsQe9"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31351531DC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809889; cv=fail; b=eD1LifP4VL3Nnnrdae7Tb5FW149LdhwWgSIxNTMyJWpU3qAcRUBlx3kBahZGLsmtwFG1ddT809lZSqHwK+wJntiTPqFlNOPgheXVZ0OWqLcBOXYa7La7yWtP6wndnWXSFqLxEYVxjeKURgxwcAU4UY/RzXVW65NVwRJRSn5tZQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809889; c=relaxed/simple;
	bh=m6z6w3sp2QnzuguWWheLjH31ejrDyeXYqL04TlQZgCI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GFzpBUOH3jgE6NAoxkrwdAmcrN1pz76Tux1lebJsRrMaJLWjaKBgnd7/PdK0ILwgQ3tDFC814vLlnqmTlTBO9cQqheQn0TW9sf2m2kEMDFuHarCTv41pdBRpPyDLJmDzDHwMViv3Sy8tf/On1E01yCXhAM2TxBa9Oa1crpTNtDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Iv8bsQe9; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2f3Z8ghtvrNK0QXBN0wcTF4mb/yQIgamXOwsqjN/P2qg5u5/Wp5iaz6iyEyQx9Fx54r7eodddCVigQl5waZ3u7h8XzL9bJi1eQ3z2cWdCtERS2Su7WTcQU2Px2a7jwianIXB1/lwdl0e3Qowvv1vHdQFDL3IxsL3GEKv5vBfsv056xCJ35gpK8LXFnuwyCpbj8X09VNZcqaGB1OimvRaGMpdNgmWKpKhjVoDrH31lg/xrbHR41tl1U6wmf0GTmHlTRSSQFf0LwiLFjyNz5Zh54fe5lzVpgT5iiVrop8i18h2An6YD0waf1GgczhYBk6YeSjlyWIAgdZXV8EigfHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIs/LOBhz5b4AieL6mTA6eclIjMAyz2uyJmseHTOPt8=;
 b=ejN3A/s8qug3mSvFwsb60D2aphwzknoWkVJhZgDWIFbW+MONatpM+PkzzUgGBiKP5LJjbK2MrCAs+QPpfQDSztatA3R52kehQQpw+Hd7GrrAfgmv85Pw0cTAen1UY5UWuYIj91I2FT/Hd8vcauV58PEm3z1NcZEcLwty3ioiVUYnponbKyTZYXkXuAx5DkdGPs+f7GW06vcjcwbcs0yuRPXdon46X3rcdQvCZrrm5qcxXXI69qLa51qsGcFUTeTS71KTAPkbuUTHZ3fI/bT23d5xjE8qR8txw8xvwIGHD2ntRGzQUhTdgztAwKWWlZ8ccyqi+K4gd/otqkNvcaZVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIs/LOBhz5b4AieL6mTA6eclIjMAyz2uyJmseHTOPt8=;
 b=Iv8bsQe9kuyQg6Gq+H7AxUPRkSd2vCSj4bv0doQu9A38FzJXDs1ARFEycIlCdOzszww+0euMVdBi42f21nWerdx9ADhfyZ4Md6PDlbgE22W6VioQouTIdWG58/+hWZZWMPvrxFO/S7ORkSnNy59nrBAALhYTzBduIlx/XrPmql4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW4PR12MB6681.namprd12.prod.outlook.com (2603:10b6:303:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 16:31:24 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 16:31:24 +0000
Message-ID: <d585f337-5ce7-4a02-b890-5f3888e59ad0@amd.com>
Date: Mon, 17 Feb 2025 22:01:14 +0530
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
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <a3b1a1fb-03a4-4f67-9f44-9157ee421913@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::20) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW4PR12MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: be0c1cf3-1c77-4bed-6bd4-08dd4f708509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkR3RWI2YzFsL3ltZURJWTNYVURNVjFSd0t5V2RQbGdPRTg1cGtGSldWMHA5?=
 =?utf-8?B?eG5nMzY0SklqaWN5N3FHVVBHaFN2T2pKZzlMZkYrWVV2N1lCSFhvWWJVcDZS?=
 =?utf-8?B?RERiWk5mb3lBOG9VU0pCYW1VYmlYSGRxVmpLdHo0QW1WQVdmT0U4YjZtaDdi?=
 =?utf-8?B?TzEybVR3M1dyL1Q4bUNGalQ0b1p0b3AzV0o1RWtQREJRT0ZXeWtmdFgrRndB?=
 =?utf-8?B?M2xHQjZMTjArK0tHZWZ1c1RuQmV4Y3VpQmFvbUFNOUFVNjhxdEtscWhpS1Rv?=
 =?utf-8?B?RG5wWUlWZzVlWWNLQmRJUlBvUFN1YjVPUlRCOWhGM0s1aXZ3enlVQnJRKzhH?=
 =?utf-8?B?ZjJOOXZ6UEJ1NG1wN3drRk1Ma3EvcDR0c1k1bTBOaE40V1RLVDIwU1FqQVlv?=
 =?utf-8?B?MjZ5Q0FMbExVVTBIN1RzZGJKRWhDMExPeE4wMkxWTnNyWEhRbUwvdUJrK0NQ?=
 =?utf-8?B?QzN0K0xnRmJSbWoxUUNUUE9JRmFnZE5CaVFzcjV1c2l6OEhxdnA5MUhYQ2hu?=
 =?utf-8?B?cVBBb0NnSjJTQjJDOEowOVVnb0Rma0VjSC8ydmd2N21CS1N4a25JcVdoWnUr?=
 =?utf-8?B?Vm1wRzVmOTUwVHdCaG8vYU5lMWlNOURMQzBqRmpNREQ4NTlGb1I4WFdpUXNN?=
 =?utf-8?B?RHJuejJFNVhXYWJnSk9haVlieGp2dXRvelRZK0UxLzhPZnh4Y3FnclVseGRi?=
 =?utf-8?B?cW9LMExydGxIcGg0VlJSZkZodXF6RDZjbVFzUDZDTVhvaG5pUTJCQy84ZkM2?=
 =?utf-8?B?WklXUHBXVDBxVU03bTA5eUs3a3ZZVGt4Vmh5dDAvVW1maHBBb00zU3NHR3lB?=
 =?utf-8?B?V3MySVV6SjAzMEMwdnN1a0VoNlF2VFhnYXVvaFJ0RnpmZE1hN1lpa1h6cHgy?=
 =?utf-8?B?eXcvMEoxRXRxOWVxOGR6bGdGbUtZcHhOcUx0SVU2OTNlTG1yMFllNHFramF1?=
 =?utf-8?B?UkZqRmpYcUQwQzE1Z1Y5ZHJMTkNXUTRTYk5qKzlhU05xa1d1Z0lSOTgxa0VK?=
 =?utf-8?B?R3hrL2puc3BhQkRyeXl2em9vV2xva0lGU2N5bng3dER4WmwxVkZTdEhsSFBO?=
 =?utf-8?B?emx1SU1nNTVZWmVLUDMzVWdjemRCa1Ezb3BiY1hOTlJ2WjBuMWtjeHRuSDFa?=
 =?utf-8?B?SUFtaWwvUjhGMlJtY2F3SHlTM21qV0VzdlFYTXc1WEJiRTNSckdvalNOSGpu?=
 =?utf-8?B?QlhKcmxIcFEwYklzcnJBdkFmS0pJVEJjM29TK0psMlJUbW05eSsxWWhiOVFy?=
 =?utf-8?B?Y1RjODFicEt6THVGMlM2N1pjTVRrSUVjT1l0WlV1U2MybDJPQ1ZLL1ExQ1RI?=
 =?utf-8?B?YzRLeWkzVm1xWEdPb08zVTJPV0JPSW1Na0VvZnhrS2RLYnZwL01PVWhKMXc5?=
 =?utf-8?B?Z0lTVmkxcy91Y2tuZW5ac1E1eDhmdmYvdGNPUHVEMTB0MHhjS2JGU3hucEtD?=
 =?utf-8?B?eWNPdkg0U1R0Z2pSQ3JLclhHZ3F6cmtqTElUS0UxdjNkSWNPQmlFWU5qeHBq?=
 =?utf-8?B?TVQwMXVPS1g5OUhjUEV6UmlsTUhLaHB6QzNWMFRtSHBFNjI2ZE5ORjFTSzM1?=
 =?utf-8?B?SExMSTRvWUxrUEE5Ti9GSHFva2tIaFR6elNvcVZEZDRBV3I2alVuMjJZbExN?=
 =?utf-8?B?NmpUUEluaXV2VWFvWEMvQ05DOC9GckEwRklUK2JJemlyWVYzK1hTeDBTMmJ4?=
 =?utf-8?B?T2lIS1k5bUM5c242WFZoT09QVGIzOVM4ODdrQjBSaWVWc2JBUzk4UExZUTc4?=
 =?utf-8?B?WmRuQmJncDBFRk1ONWxVcjQwR0kvSjhYbHVFWXpCTVE4UGlmVzVQbmJVczAz?=
 =?utf-8?B?VnRvaTVhTHRJRFBsKytheVUzdFkrQWc3L3Z3enpQYVNTdzVoTWt1cDNaczUz?=
 =?utf-8?Q?E+CJ6ckmhaD3x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWppZHRGZUJPUGpDbG1jYUZnL05seXkzWXlTR0VRS09jNldhZTRuRHBnYXJQ?=
 =?utf-8?B?MTAzWHErS1FkYXp4ZGVKRktTMWViM3cveGRRN1M4TmxqeTNmV2kvck5UUlhq?=
 =?utf-8?B?V0xtV0JnRVhiZHhjbFYxMEh4QThHenRDc1pYWlZhM0xiTW44SzM0bWFNQm0r?=
 =?utf-8?B?NlNnOVVHUVV3NWdydlE5QVdZQjJWbWdZT09jbk85NjRSdVNoQkpSZDRRR1J6?=
 =?utf-8?B?d3FpQ0RQajdrblJuR0gxQmw4VUd3b2F3dkFHRUZpczZQYkZjOVRQN09vcWU1?=
 =?utf-8?B?RmRKOHpuTE5UNGprZFRENjA5djA4MWFQQ05uV0dWM1Y4cTh6cU0yK00xakdj?=
 =?utf-8?B?RVB1S0JPbzRRaTFOMUZZKzhIV0FMWEVCbmhkajhLc0tVaUVGY0JTWGswdVZY?=
 =?utf-8?B?eWVVZmJESFl0bWhCZkNkSjlzUmxncVRTa3lHKzF6UXRKdzk1UHQwWTdHeFhT?=
 =?utf-8?B?MFltZ2J2TG9zWFEwdGZxRG1rZ2pZeGUwV3ZmZE0wbDNnZVo3aHFFalVVWUQ0?=
 =?utf-8?B?N2ZRcWkzb0pjQXRDcllWT1lGZkNuNS9Zdmd6eDdlOVFQQU0vdHI4c0duekJN?=
 =?utf-8?B?VDZqcmRLU3BHVkxUUUxqNWo4dytmcTNHeDlxeGFCOVM0b1BHMjhCOHFYR3Yy?=
 =?utf-8?B?NllPVHNzNTRpNFlIRjNzUTlsQnZ1MWEvYWo2Vm5mL3YzdGtiMzJLdVlyYkZO?=
 =?utf-8?B?RmhSMWZLSkUrY1NPUkw3M3d0aEE5TnI0ZVd3QkhrOFRvL2h5alRYalBKWGhB?=
 =?utf-8?B?ZTh1WUQ1NGVJUVRyaFVCaFVtbFJQSzdhOWlHNXpGS29WQ2FjWjNDTGszcXVY?=
 =?utf-8?B?aklMMCtSMDJyS2J2R0MrMm1oRzQxbjc0UjVYNGxETXFxREswVmk0WXlSZnJG?=
 =?utf-8?B?endUMEVrbWhwcnBjdUpiTHNUOVlFM2F2T0VXRmVVajRBK2ZpNVY4QjNybTlh?=
 =?utf-8?B?QllOOTN4NlNBd2RHcW5uZk9pcWFOQXFnQVdBT2o5YlVIQlRTWUNSUkJ1ckFh?=
 =?utf-8?B?bXNUZEpKNkFuV3NTd0VXRVd3K29zVUtpMHRueTJrczR0MThQZG9saHFBMXpV?=
 =?utf-8?B?T0RqVDZzODFQazVCOUU0SkpHemRneUwxSlhDQlQxNkRoZTJTRmpWRU8wMEZp?=
 =?utf-8?B?WW9FNVVEQkVidFJtRnI1OEEveGdjV0g4NTB2WEp3U0dLSk5teHhEakI3TXll?=
 =?utf-8?B?eTJ5anUvcXpVZHJRSjVzYXdGdnkrbDhpbE9heDU1cTVHTDNDRHMvcFZobXpG?=
 =?utf-8?B?d211OU5aekRQTnlHU2t5dHd6U1ZZMDlIamVPanhMeXg1cGhOWlQ0Z3lxdGd3?=
 =?utf-8?B?YXQ1YnNFMzlQcEl1eXRvRjhNSCtURjIzbzVrbWFzckdlSHRSWVhoeGFFaTJ6?=
 =?utf-8?B?dFA4WFFUSXZxWkZEdmg0SVNJYTRvUTVOTU1DTGhWdmYybHZMbENhdTdOR0ZM?=
 =?utf-8?B?dTdPWGxPdG0yT056OXBqWnZWUmxoblFtL1h5MWRFL3k0dCtqQzdPb3pDemF5?=
 =?utf-8?B?SG8xY2ZPZXQzSmpRWEwxUWsyZlBKTldjV0pYbXdXeThpdm8wNWV3S3pMaWtP?=
 =?utf-8?B?OXpWb2hkaEI1YVVLMjBkTUZIdllSRWFkZ0xISjFaRTVZSGNnUWRwUmo0V1VL?=
 =?utf-8?B?dGd4Y1k1VEdicnltVEJYZlJ4MnAvVUNFazJlUDRPZlQvZ0k1T3NnVHl0Ymhu?=
 =?utf-8?B?aFZiOW1oWkhSdXhRWDJZQ250c21QQTZGV0Yzdnc3OVp5T3RMT1BqTTRxTVhF?=
 =?utf-8?B?allwRFNBRDNHOC9LQVRvK29BZDljdmxwRm9VZ2ZvSDJkd1NPSzk1NVUzVGFE?=
 =?utf-8?B?ZUFZNmxkb245eUcrMi9CWFFaZW52Z2xZRXV2dDE2QXVWeG1YWkM3YStiWFNq?=
 =?utf-8?B?SGhNWGdWSjFhZG9QbEwrL1BwNFNTVW1OeUhsdVVybzA2bzBuT1k0NTFoTk5Z?=
 =?utf-8?B?TzBoVlVidVJRY2VxTFRCYVE3NVJFTFB6WWp0dTMxVm1oRDhyZ0FKTkRrL2wv?=
 =?utf-8?B?aWVNL1grZ0t6MVVnRUdFQTZ0bkN2M2Q5OWZyZzdGRDZzYlU4Skd0YkIvWXdw?=
 =?utf-8?B?d3IyNUplWWp2Nk9zS2l1N3U4NFpnYUdkYVQraTZHbTBsWkt0SjZHUDNQRzFa?=
 =?utf-8?Q?/SpaJ5lsi/epV02nHDAEYeFIZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0c1cf3-1c77-4bed-6bd4-08dd4f708509
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 16:31:24.7039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRWSZRl3ol2Mqo2Z2LTFVlqiD/ZWCCz9Aqm3CFjWkSqkrHONBE+nJzIlY6476qfXMeMV6uMeHSdLwwJ3t6odWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6681

On 17-Feb-25 1:54 PM, Ravi Bangoria wrote:
> Hi Peter,
> 
>>> Apparently not, it ends up with:
>>>
>>>   ------------[ cut here ]------------
>>>   WARNING: CPU: 145 PID: 5459 at kernel/events/core.c:281 event_function+0xd2/0xf0
>>>   WARNING: CPU: 145 PID: 5459 at kernel/events/core.c:286 event_function+0xd6/0xf0
>>
>>>    remote_function+0x4f/0x70
>>>    generic_exec_single+0x7f/0x160
>>>    smp_call_function_single+0x110/0x160
>>>    event_function_call+0x98/0x1d0
>>>    _perf_event_disable+0x41/0x70
>>>    perf_event_for_each_child+0x40/0x90
>>>    _perf_ioctl+0xac/0xb00
>>>    perf_ioctl+0x45/0x80
>>
>> Took me a long while trying to blame this on the 'event->parent =
>> NULL;', but AFAICT this is a new, unrelated issue.
>>
>> What I think happens is this perf_ioctl(DISABLE) vs pmu_detach_events()
>> race, where the crux is that perf_ioctl() path does not take
>> event2->mutex which allows the following interleave:
> 
> This one was only with perf_fuzzer, so pmu_detach_events() code path was
> not invoked.

I think the issue is, unaccount_event() gets called for the child event
after the child is detached. Since event->parent is NULL, unaccount_event()
abruptly corrupts the perf_sched_work.

I haven't verified it. Will do it tomorrow.

Thanks,
Ravi

