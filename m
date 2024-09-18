Return-Path: <linux-kernel+bounces-332807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4017897BF1B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 880B1B20E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34B51C9868;
	Wed, 18 Sep 2024 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4COywUzh"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73721BC062;
	Wed, 18 Sep 2024 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726676821; cv=fail; b=J0JsWYtdzhAPtnff0QbdrbANJ6rjV8GUceI2ZPgobScT76Bkp+9B7CB++EasRtd9KGMXymJRrAWH/XxUJ6U2Vy4m53UixfxM5t+fHrVXyrWgR/9bIK4X1K2mg4SDWMBy/3ekYDIhQvl0eZYhZ5J0h/jAZIsLLdyIeoE0xRxItLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726676821; c=relaxed/simple;
	bh=OCBFrcawM2hPkHZsmsDaH2MaiSEhqvLMUM49sXDp8VY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R+/lbCRGzUryljeo7IZoWInb7T1AR8kBrCAr6TgdSWgPJNN20HkWNY9u5p6HPpP5rHg94kWWxlJ5yWu7n/HsL8lUiygmt/f8OfMICP9G3lb0Ph2oRDMe2xzisgfM+3oFsCj9a345ZLH+obrLWpLHTVcJC5xFJwLPIGjsPqfpv5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4COywUzh; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0+MnczEstqh7LgK808SoiXOUAt2sAzEy2eUMAlS9hpuIxmz2QCoKCGrB2hQpjjk4LCRDftO/i/v691QMnI9aVWdgIQTCxalIfT/o1Wbq56T7/K/nfYu3vx5E9vGyi2qMZDkdbQdvyYJ/U6JMf4toWKxraCsgqdZ8GlXuws5i6pnSRdvnNGiRc6KsdI6EN1v4+kMcBtR+WdpKA6Rp40LCRM2ZIRn8Q4uXCVeg5SaZ57w0Ucx6pefRmkETxEBY8JcCsyMGGCxJgJ/CXox1ok50nV+CHhEhhGk2lEerdWOWsjmNG63s3p7M8o9HLUHatHakksIl5DjOczDIhStf+d7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qto4Rg5o3sy6OSNOl0uQyJR6hkKrW09CUYNGKkgPqsE=;
 b=rQs4Rj3WzX/m0Boh9UKHLxGJ3x5iTrywaC1OmPQJC/mhEo1IZjxDu/I0NgPLBP+zhuZugoQAV6iBeTLwBmbDtzVue5qJl8J08DLkUV4a7QWdLj+frZDRYH7+Wc4SnIdF/YDg+up/AihN2otjgelG5ZwDmxoQdaN67Kr7wscT+GiGuJ3mWgwPaXbD5otVHcOlitMBXJxDRM7KOX/rwcvkytsduhXIHtcW6CUJEjh3sTXPDcd8lboBUGVrHcZucCFbz7SQQSH9BvKPrHV8ND6RZJqAwmsItWqC6AbZp+ZI8k8w5hqGusjTfgY+s1aUor6Nr1iOpZNedEZSUPGNAazCZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qto4Rg5o3sy6OSNOl0uQyJR6hkKrW09CUYNGKkgPqsE=;
 b=4COywUzhSwXGqCFl8VGRKgkfF4SfW5GpnYnZd1TnkVV4wJbyNBtvUfMYLk1w7F3D7ErkBsrSn/DhvTi5kmgUTwWFigFxgtq0fPiPtW8COZQZyUGQapAOAQ8rnuVdTmrTnfI43qdp08whigrnRl74JKMx1aID+OE3sG1PtUJak8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 16:26:56 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 16:26:56 +0000
Message-ID: <88b93600-ace7-4a0c-a61f-7f11d3f38b0e@amd.com>
Date: Wed, 18 Sep 2024 11:26:52 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 4/7] x86/resctrl: Implement SDCIAE enable/disable
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: fenghua.yu@intel.com, hpa@zytor.com, paulmck@kernel.org,
 thuth@redhat.com, xiongwei.song@windriver.com, ardb@kernel.org,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 sandipan.das@amd.com, kai.huang@intel.com, peterz@infradead.org,
 kan.liang@linux.intel.com, pbonzini@redhat.com, xin3.li@intel.com,
 ebiggers@google.com, alexandre.chartre@oracle.com, perry.yuan@amd.com,
 tan.shaopeng@fujitsu.com, james.morse@arm.com, tony.luck@intel.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1723824984.git.babu.moger@amd.com>
 <d40df35b8f25b1ce009863da5b53f43640fb426d.1723824984.git.babu.moger@amd.com>
 <e85178fb-7258-4bd9-b9a3-0114c1c41111@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <e85178fb-7258-4bd9-b9a3-0114c1c41111@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:805:66::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: b0bfed23-57ca-487f-9d9e-08dcd7feb65d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnBHVXRPQU95a2NSajFvYnJHc0Nvb3hkRzFLclpoNk9LWlJqSkJiWHhBVVZ3?=
 =?utf-8?B?YlZGNzZZSUl0aDJOMFNuSkFZdWdPZFZkQnFqN00yWmZpMmxTWGY3ZkEwNWtv?=
 =?utf-8?B?SUJjQkw5UmlhRXBFZkdHWnZ4SnRGRldibHZNSHBPcUVWQ2pvRzNUVHB1UmY1?=
 =?utf-8?B?bmNVMG1vSjhLSlFGTmRUdXFEc05pc1ZsRldFY25EcHRSSUhuZFhGclFINGcr?=
 =?utf-8?B?Sk1vb3UvMENKdmk3WHY0cHJGa1gyUFEzeFZYSVpuejJua25MUUl6MkIwY2JW?=
 =?utf-8?B?amxlZHpsemt1RVhDYVIzMkJWRCtmSWp0WHhOZ3dudWxXbEJxNEo2VG5XcG8r?=
 =?utf-8?B?VDNhWlQ0dm5uRnM2UHdHZEQ2Tjg3QTc3RzRHVUxuVmxrTllXK3lmU1lUR1Y3?=
 =?utf-8?B?cFJJd2dNTm1qTXo1bksyS1A2bjNoMkNCUmFTMGhrL3JHMzcvMDhBbVpLVkdm?=
 =?utf-8?B?Njl0VExXKzRrdk1kZUN1NDV3RHlSU0RySnJRNXpoOENXWk9VUUJqY3IyL01U?=
 =?utf-8?B?UFZQYlRVNHpMMFFvaWdSMmNFektTZXQvN3lFZHFIZU9LM2tFSS9waGk5SHpI?=
 =?utf-8?B?QzAydi9lQ0xXa1VKbTM1SXlsZmFWMjI4LzVOcWNlWlBjWVByNnB2T1dYRTR1?=
 =?utf-8?B?d1puU2hSNFZWK1hUWnZteDhBMVBHNldoRGVUTHVMREhRc21mZlUzOG9jdzFZ?=
 =?utf-8?B?Q1kvaytFTmFaaFJMT0pSbG16Zm1kQ01la0dBRUZ5ZU5CSXJ0VUtja3p2Ty8r?=
 =?utf-8?B?U1BJdGlUQ2JMaGJ2Wm5IdkhuK0RqSEFIaFJzZ1o1WnNBRGRTU0tyMEJENmxu?=
 =?utf-8?B?bjhMaXpzaDh4RXQ4cHZ6Qm9TK0R4ank4eDhkN2JPRmJwYXdUVnNjWnhHK2s5?=
 =?utf-8?B?VTJkTFp1ZWxGVUcvalN1UWpHUDcxSjA2b0lVZ1RtRDRwKzhjRkZaTzVXQnNw?=
 =?utf-8?B?b3dwYTFRVzNDZ3hMMUZib25XZTBmTEpsOXpxRTVoTHY4UzltSkVHT3JQRTI4?=
 =?utf-8?B?MmRYWlMvV3BTMG1yOHpIYnkyNlo2MGlJY21Fc2dKYVlKK2YramRWVXA5SUNq?=
 =?utf-8?B?U2tVTmhDREthT25kMWhYU2g5MEJDek1HV1Yyd1V4Z0hkd1hZMklVN1ZOdEp5?=
 =?utf-8?B?UzZocDVubFg5NklaaW1Fbk9pRzVyS1MrS01tdDhLcFM1bjN2R2s5b3VrUU5T?=
 =?utf-8?B?YW5NTE91NWFLMnFjL1VYaUFvOG1aNmNkNUsrUThyYTFZcEViRC9HOVZVeWM1?=
 =?utf-8?B?cWp4dWI1aXp4cVRveWh6SjNnRVJMMEJYbmtFazBQQkU4VTJHMStoRGFOZ1BN?=
 =?utf-8?B?TDV2ODhkQ3B4TGk2VmxvT1MvL0VjZGJPUUxBTXNiSnZnNnpKMzlGMkNVcTF1?=
 =?utf-8?B?cTlhazhRNGNJbGhTUjBQelB5TExRa1JaMUJNNzlDUHZsNm5oK2M2OU5RZ3pM?=
 =?utf-8?B?Wk1CU1I4TnA4UnlzdUFUb2kyUnlWZ2dtbEpCSGxmWTZzd1pHaU1kU3RHUS9m?=
 =?utf-8?B?WWNDdzFZVjNsS2lYSG9GZmpXYVJGMVpQd0M4Q3h5L2lEVUpQOGxRNXplQUNr?=
 =?utf-8?B?aDltSG1HMzdLZUtnUmNvKzFjQm53NUZSWTROMmJVNGdTdnpGZnpSdVZBZTQz?=
 =?utf-8?B?bldzRnIvL2h0eEtpbEgxVHpLOGV6RCtrbllnd1Y1S3kwQlhRMThNRURrOW9a?=
 =?utf-8?B?aXN0eEEwSmV2WXdqMmREUkxDbC9JWUt6emlYU1oyNXVQeG5FN0pqMm1LS1Vk?=
 =?utf-8?B?Z2lTa2NYTHBYYnB1SU82SU1OREJBZndlY3RSTkRJWFJrNytuTWJqUWdPclR2?=
 =?utf-8?Q?+NBW+78aUfO8CVI9eUD1lTWC9O7VEfHlDPUGA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGx2dDhUVnpudUxvQzIrRU9LNzN0clA0cmpUcWlhcWFydlJBelo1TnBXNkJN?=
 =?utf-8?B?RFo1OHQrU3hya0NBRVhXSmppcFZwY3Z6M3lJejE4Q2FIbkJtY1JqSFdkNUZ6?=
 =?utf-8?B?YzBnR1d4eE90dFd3MHl1VUlmdnRQOHp0NUJhYndwZkZZOXhjOGN4Sml2aXRY?=
 =?utf-8?B?SitpWHFSWVp4a0JMUnU1LzUyM1FnOTV5akp0ajM2dlBSYUxBNTI3OVNBV2dQ?=
 =?utf-8?B?cVlPV1lxSEVmdStPeG01dzA2MnI0b0pab0JaRTd2aDFXQ2NUTlByYXcyWnhB?=
 =?utf-8?B?L291M1kvVldYZjVuMHRETDVqNFlnK3cxMjJwNExWNGRxb1g5L0VLeURwVkNC?=
 =?utf-8?B?VjdGaWJ3OWdGeHFlQ0QyWlRXTkJsOVRkYTh5U08wejMydXB6N0VWanhLc2M4?=
 =?utf-8?B?U0VJMGY0N3VRYkNIdU9WRFpqTUE2S3BKbDg2MkVlQlIyUTVublRxU054ajQw?=
 =?utf-8?B?V3F4WmF5NUsrT3pOVUUzalFvcVowL01uczVTSi9ERnRmYlY1YkU3MTlQZDRw?=
 =?utf-8?B?bTh5Z2MrMFJtb1ViS3NYVncyZVZndjYvRWMyYXA5dVpZbGxOUEM4K2YyOFYr?=
 =?utf-8?B?cm9ka0lEa2tLVE1DaVJqRzZtUFNKdjFsNFJzQXc4RTA4ZEF6K0U5cnRrVmI3?=
 =?utf-8?B?MUJFVlNidGtvMTlsWFlSdjN0eERJbzRaQUpWUEFJUGgrTzBScnV0NkxaZ3Va?=
 =?utf-8?B?b3MzZXcvVUVJeGJXQU1EUG9EbGFhY2RDMnJpSjYrNkUvNlR5M0g2WCsrek1s?=
 =?utf-8?B?ZDRNcU5nQmN4QVM5cGdYQzd4RzN4SzRZL2U1djlSNTNNZzZtT210WkhOckFn?=
 =?utf-8?B?SFV6YUhPUG5wM0N1ZXlGZkRNcXpKTm5aSENxa1QyOU1Od0ovNjU4SlJhZlZO?=
 =?utf-8?B?TzZwQ0VFNnRENWxGSm5DQnJ1RGN4SUg2ekNOYjJWT2dMdzJQQXdJM3hwa1ph?=
 =?utf-8?B?NlhiaUd2VWJ1T2FvZUduZlF2b1VSOEhaV3hlZXJzVmgzaDVqSjhxZUJzKzR0?=
 =?utf-8?B?TXVXRm50VTArK3JRdmdJWGhjVkF1VnZFWnBBZ0twN0svRS9OMTlvR1VsMjk2?=
 =?utf-8?B?bW0rKzk2SmJpU05ySjdlTWFSS29ITVhqcGlDZVhxeHZDZWVlVDh4U0JGbmV4?=
 =?utf-8?B?bGZqbW8rciswV1JCR3dOd0ZIWVFSTTAwdXVnaDIrSWNrN3FhcmVpelhVQVpi?=
 =?utf-8?B?VUZ3U3V3WnIvSjlxaVRpZ0pQRjV0MjIyUCtBMktoNi84YXBLRkI4dFdUMkdN?=
 =?utf-8?B?c0VmTndPSVppWDg1Z1lQWWhqeGRWWG4xdFZaa3hPelZvdnYwaWFlR0pOWith?=
 =?utf-8?B?c2dveDNMUFZRZStYdXUvT2xYV0phbTVTK3ZrMzlIVE1ZWDlrSDFqZUx4RlVq?=
 =?utf-8?B?dkVXdm5COGxjWWhRN09iZ3JwU2xqZ3FRR2U5VnBkQ1BJL25HdnZKVUc1ampG?=
 =?utf-8?B?N0FYRkNQc241dVpjUlFxMnh0Rmk0djl6UGxrQ3FmQXRpdUt5RitXSHpIQ21P?=
 =?utf-8?B?WEltV0J2SDNNcm5EZEhXbnFXdnlBZ3I1L1VOelI5YjFZNDR5S0ZZTWJ0OUVj?=
 =?utf-8?B?NHpobUt5UkM1bFFSVDV5dUNXeWNLOFhkamg5aDQzdnI4QVFZSEZmdEI5TjA4?=
 =?utf-8?B?aFlaaWErSmN5UUd0TG80U2NHK0ovc1p0TWNnWTJLT3N5dnBVV1ZxdG9XMnNU?=
 =?utf-8?B?NjNiMjJCYmozem5MdzVteURTbUVnaVRhcXBPVFhZbmxGRVQxZDJKSWxEMmN6?=
 =?utf-8?B?OGNTeU9TS1RvQUpCM05EbXp5K2hncW9jaWxXQ1p6NHNzMkc2MVQ5N3JIUDMw?=
 =?utf-8?B?by85Mi95c1lndFhRdmhlQUNzOXo5b3VyWWpvbTh4Wlpva2ZXZ0RpSWdIREM2?=
 =?utf-8?B?amFwSHV6STYxNEN1Q0FQUm9LcnRzVll3VDB1cnQxc2h2QUN6bEREVlZMMGxC?=
 =?utf-8?B?dVVsWC9xTlRMdUNmRURrN1QrbjVVTjR0cTlvSEYwYnNHZnpQSXVEN284MVAz?=
 =?utf-8?B?RExJbDdEbW5UZEdoMTI1NENPQzk4NDNPMFBpcVB5OWF3Z0VscDgzSngrSlAx?=
 =?utf-8?B?L1prdVRiWHE0cDdRZ1U1d2tPdzM3TWZmeU5IM0tjUlBKS2IyTGI4RWx2MFl3?=
 =?utf-8?Q?4UxA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bfed23-57ca-487f-9d9e-08dcd7feb65d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 16:26:56.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tprxfs4O86iH5ir2zTZLel3z9S0Sg0hbYWKHlLqJr01RQ9LIM0C+Lrd14jLK4bG+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085

Hi Reinette,

On 9/13/24 15:46, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/16/24 9:16 AM, Babu Moger wrote:
>> SDCIAE feature can be enabled by setting bit 1 in MSR L3_QOS_EXT_CFG.
>> When the state of SDCIAE is changed, it must be changed to the updated
>> value on all logical processors in the QOS Domain. By default, the SDCIAE
>> feature is disabled.
>>
>> Introduce arch handlers to detect and enable/disable the feature.
>>
>> The SDCIAE feature details are available in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
>> Injection Allocation Enforcement (SDCIAE)
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> ---
>>   arch/x86/include/asm/msr-index.h       |  1 +
>>   arch/x86/kernel/cpu/resctrl/internal.h | 12 +++++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 ++++++++++++++++++++++++++
>>   3 files changed, 74 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/msr-index.h
>> b/arch/x86/include/asm/msr-index.h
>> index 82c6a4d350e0..c78afed3c21f 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -1181,6 +1181,7 @@
>>   /* - AMD: */
>>   #define MSR_IA32_MBA_BW_BASE        0xc0000200
>>   #define MSR_IA32_SMBA_BW_BASE        0xc0000280
>> +#define MSR_IA32_L3_QOS_EXT_CFG        0xc00003ff
>>   #define MSR_IA32_EVT_CFG_BASE        0xc0000400
>>     /* MSR_IA32_VMX_MISC bits */
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 955999aecfca..ceb0e8e1ed76 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -56,6 +56,9 @@
>>   /* Max event bits supported */
>>   #define MAX_EVT_CONFIG_BITS        GENMASK(6, 0)
>>   +/* Setting bit 1 in L3_QOS_EXT_CFG enables the SDCIAE feature. */
>> +#define SDCIAE_ENABLE_BIT        1
>> +
>>   /**
>>    * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring
>> those that
>>    *                    aren't marked nohz_full
>> @@ -477,6 +480,7 @@ struct rdt_parse_data {
>>    * @mbm_cfg_mask:    Bandwidth sources that can be tracked when Bandwidth
>>    *            Monitoring Event Configuration (BMEC) is supported.
>>    * @cdp_enabled:    CDP state of this resource
>> + * @sdciae_enabled:    SDCIAE feature is enabled
>>    *
>>    * Members of this structure are either private to the architecture
>>    * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
>> @@ -491,6 +495,7 @@ struct rdt_hw_resource {
>>       unsigned int        mbm_width;
>>       unsigned int        mbm_cfg_mask;
>>       bool            cdp_enabled;
>> +    bool            sdciae_enabled;
>>   };
>>     static inline struct rdt_hw_resource *resctrl_to_arch_res(struct
>> rdt_resource *r)
>> @@ -536,6 +541,13 @@ int resctrl_arch_set_cdp_enabled(enum
>> resctrl_res_level l, bool enable);
>>     void arch_mon_domain_online(struct rdt_resource *r, struct
>> rdt_mon_domain *d);
>>   +static inline bool resctrl_arch_get_sdciae_enabled(enum
>> resctrl_res_level l)
>> +{
>> +    return rdt_resources_all[l].sdciae_enabled;
>> +}
>> +
>> +int resctrl_arch_set_sdciae_enabled(enum resctrl_res_level l, bool
>> enable);
>> +
>>   /*
>>    * To return the common struct rdt_resource, which is contained in struct
>>    * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index d7163b764c62..c62d6183bfe4 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1789,6 +1789,67 @@ static ssize_t
>> mbm_local_bytes_config_write(struct kernfs_open_file *of,
>>       return ret ?: nbytes;
>>   }
>>   +static void resctrl_sdciae_msrwrite(void *arg)
>> +{
>> +    bool *enable = arg;
>> +
>> +    if (*enable)
>> +        msr_set_bit(MSR_IA32_L3_QOS_EXT_CFG, SDCIAE_ENABLE_BIT);
>> +    else
>> +        msr_clear_bit(MSR_IA32_L3_QOS_EXT_CFG, SDCIAE_ENABLE_BIT);
>> +}
> 
> (hmmm ... so there is an effort to make the rest of the code not be
> resource specific ... but then the lowest level has L3 MSR hardcoded)

Not very clear on this.

I can separate the patch into two, one arch specific and the other FS
specific.

> 
>> +
>> +static int resctrl_sdciae_setup(enum resctrl_res_level l, bool enable)
>> +{
>> +    struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
>> +    struct rdt_ctrl_domain *d;
>> +
>> +    /* Update  L3_QOS_EXT_CFG MSR on all the CPUs in all domains*/
> 
> (please note some space issues above)

Sure.

> 
>> +    list_for_each_entry(d, &r->ctrl_domains, hdr.list)
>> +        on_each_cpu_mask(&d->hdr.cpu_mask, resctrl_sdciae_msrwrite,
>> &enable, 1);
>> +
>> +    return 0;
> 
> It seems that this will be inside the arch specific code while
> resctrl_arch_set_sdciae_enabled() will be called by resctrl fs code. It is
> thus not clear why above returns an int, thus forcing callers to do
> error code handling, when it will always just return 0.

Yes. It is returning 0 right now. Keeps the options open for other arch's
report error.  Looks like we heading to make this generic feature.


> 
>> +}
>> +
>> +static int resctrl_sdciae_enable(enum resctrl_res_level l)
>> +{
>> +    struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
>> +    int ret = 0;
>> +
>> +    if (!hw_res->sdciae_enabled) {
>> +        ret = resctrl_sdciae_setup(l, true);
>> +        if (!ret)
>> +            hw_res->sdciae_enabled = true;
>> +    }
>> +
>> +    return ret;
> 
> Same here ... this will always return 0, no?

Yes. it is returns 0 always on AMD. Keeps the options open for other
arch's report error.

> 
>> +}
>> +
>> +static void resctrl_sdciae_disable(enum resctrl_res_level l)
>> +{
>> +    struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
>> +
>> +    if (hw_res->sdciae_enabled) {
>> +        resctrl_sdciae_setup(l, false);
>> +        hw_res->sdciae_enabled = false;
>> +    }
>> +}
>> +
>> +int resctrl_arch_set_sdciae_enabled(enum resctrl_res_level l, bool enable)
>> +{
>> +    struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
>> +
>> +    if (!hw_res->r_resctrl.sdciae_capable)
>> +        return -EINVAL;
>> +
>> +    if (enable)
>> +        return resctrl_sdciae_enable(l);
>> +
>> +    resctrl_sdciae_disable(l);
>> +
>> +    return 0;
>> +}
>> +
>>   /* rdtgroup information files for one cache resource. */
>>   static struct rftype res_common_files[] = {
>>       {
> 
> Reinette
> 

-- 
Thanks
Babu Moger

