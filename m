Return-Path: <linux-kernel+bounces-337434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F76984A14
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1131F23523
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFAD42065;
	Tue, 24 Sep 2024 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RmnfM/eM"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8329F1B85D1;
	Tue, 24 Sep 2024 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727197285; cv=fail; b=WiWpxXTTRTWwJV+JbMJdGxRi5AEQqIVbz7yTOcmP+1cPABxt8CE/35oT2LhuINcKtBoNa2Sf0mK9ReQeiDxOajDVAcesGajgD5b4He/jOy5l8I6FG19U9Vf+6NXmoUG0Eq+47zuSiFx/R235Y6LUqafNWJcz8lYhjab32KJerVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727197285; c=relaxed/simple;
	bh=8Qm3WnYciih/K/6D1mA0u7GaWC+yxeG6TqkpKbeDBmM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZBKGahxcHseQW8AqJmqfOJMbTVLp8ks3pjymRrriiVtvEUa+g1akKfqGZZOSHKrTV+q9lx76jMYd17HigQJ1mR8INIt5gh3Q3Yg78fviwBAUvWw9uG1pb186KX2ZE13gP0qbcjUWUeQXNdcNPbprrDsk6YWB7uS0tjH5+en3Yds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RmnfM/eM; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxqPsycJ26vwutxxKvg++uam/V2aPs6+LMvJCxRtxLFJaxa0Hgpn1mFf0gQBTuQfajaz31ARHV7rJ2f+xobGjJx3M1IekIy8jhlOzCWR6IhVDOl/zD6e949D0P25MjS049hbuBaiwLuHct8dZV7qGzxKh/PIsWDcN13m+4GNVzNywBryXNJ3QuZ909T7Tn7F2jF9i7gVGrj0GrX0nrvZ3mHAMfnqDPCg05L5bPt+/j9gFfXeqHKPepoTmG7h8ik7AUeWy3WcMuOBpjMOefowD3ZyZuT+q+Tw8aH3YTNffkZU9AyKTm1DLSHiimBivcFmen4I70yy1tiwDWp0gG05rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkdUEwY8qe/TwMYC0bctTXO5RnMMNL8t7zeBm5t/GD0=;
 b=doIzKk5O5UslBzGJknARxVrj4rEzR0wd53QEukVdOcxsvDpMPt3HDDBSmnuGG9ZRngOEuzRcKahfvt/Xcp5AxR37RC3+TXfclWqLGYA5spH4MvoAmRLfYS81qCIAFZ5EPK47FxAo6oqkUP0xjopXvMNva4g9FqGxXIs9CnJmYdxCeW3owDeyfhnRgEWDbP+ItfWqcRfhKJJsjHx3/x6DRH9ruoKAjJyl4zkqeAoMhevXqEivdXGjXZdNbHGgAQrSDc0Of1RJ7U1VMk8OAuux8h+s8eLL3koIzGx+7QWU8dlsmKAvJLNP5Ajecjgo6faejy9h0YVorqG7RAVJSWPKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkdUEwY8qe/TwMYC0bctTXO5RnMMNL8t7zeBm5t/GD0=;
 b=RmnfM/eM1ahF9v6F8NvTAEwHccgBCEXEtmPYoZyckaE/y5uvLVL2C9aGbDA/SXCQLxnHBEwgGgZ+pEwY+RqHzCfRTomAVvOKP/q9b0UNrt2L1dfuVWBSPcwPZsZPZYTvy7ccEwMesNBQ1a18NfiQ8y6cIpCytMy/FsWTJVaDcUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 17:01:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 17:01:20 +0000
Message-ID: <e1e8dd73-7624-4b5b-a922-8b031b9c42fd@amd.com>
Date: Tue, 24 Sep 2024 12:01:14 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 09/24] x86/resctrl: Introduce bitmap mbm_cntr_free_map
 to track assignable counters
To: Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1725488488.git.babu.moger@amd.com>
 <a94c14653c29e89bc76727addfcdf1f9c164b95d.1725488488.git.babu.moger@amd.com>
 <CALPaoChn+dkHNTMdCwCqH=zwtBr9jJRV4jAGWeWnNOBZ1f+6WQ@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoChn+dkHNTMdCwCqH=zwtBr9jJRV4jAGWeWnNOBZ1f+6WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: 63fe467f-91ef-436c-06d4-08dcdcba82d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTZvRmo3SDU5TWQ0cm5IYkw5T1lPY3h5bzNqdi9FNXZzWkZsRTk5bkFjcWts?=
 =?utf-8?B?TFpUTGVZWFpFeUNiK1pLOGdHNFA4YUE3a0FrSnFnMml3U0VTc05FUXFrNEs1?=
 =?utf-8?B?clBYSWdESlh5RUdyQWc3U090SkwrYkpFMkcwcnppOFNTUEQrVWJEeWd1SEtx?=
 =?utf-8?B?aGVycThNODNaU2VFbkwzVnRwTUNCMC82TUxEUFhneWZaem9NWjdWR1BPZWFX?=
 =?utf-8?B?eEVGZG84N0JyL1pUcmF1MURET3JvVmY5MzMrejFaQ2NaZmpiUmpzbC9mT3pk?=
 =?utf-8?B?RStKcVBNZU9DUlJRSExGeGJvdWNHd0E5ZDFhMDVtK1dORVVjQmlPMDVMWmlI?=
 =?utf-8?B?UzlHS2JNUksxZndrTHRXQ1NGbmRhemhZZjVOc2dkeFBMWlEwV2pxNjRZc2pE?=
 =?utf-8?B?VTdrUE1JZW5PUmFwTEo5Q1N1NTNqZHdjR1Y5THRtRTI0OHQyTTE4cmtNU3lX?=
 =?utf-8?B?YlRlUFVCUWIwS1BLeVpuaU9xM2ZyUHo2TDdIRG5OdTZScG5QZ2F0c01rTG12?=
 =?utf-8?B?L2prdE9xKy9NNmNlYW0xa1lteUZzTHd5aXVqZkdTWDJMVnlkRVRxV0xBU0sr?=
 =?utf-8?B?d3JRSHNKZ3piaFZxUWRUMi9XNXJ1SFV3Z2pyUHRUQ0NNUm8vUHpZRVdEZ3Ro?=
 =?utf-8?B?VU5GN21KL1NCbHFTQ1MzdFp1b0VYWUtYb1JSdDF0cEU2R2dob0x1ZnE0UkxT?=
 =?utf-8?B?dm00bmt4Sk1COXNGVitLRW4vWW0rUnQ4SVZRdXFNRW9jSy9IdHpxVGhBV25j?=
 =?utf-8?B?aXVUbmdNTUFGMndqRVN4c3oweDFOUThnUDVlTWlnTllTckl6U2tPdzNlYWRt?=
 =?utf-8?B?N1FydHhpZVhDeGg0VnlmQzFGQ0YrNnNzR1h2M3RCUmtCVW81alpXU3BBd2JF?=
 =?utf-8?B?dEVoQldVVFZkeTdBZHF0NDFPdkpkbjI1SUVYRkpvRUxsc0xDU2RNVU04ZXVH?=
 =?utf-8?B?WE9QTk1QMHhERDhzV3QwakJHdzZMVWlETG8wMm1tOVFWL3NoTExxc1FsbUVT?=
 =?utf-8?B?cGJDNWlXMkRjQXdLaW1LRlNUdDZSeHllV1V1dHhFQmh5ZitJTVd5SDk2MFdr?=
 =?utf-8?B?dzc5V0hEbjZ6WldIWVducFExWnZKMVhjMG5CeWNyWm1raTVmVmNxT2tBYWZk?=
 =?utf-8?B?ZGxXYUxUcEpXajRoQ0JLc2NnK1pyZGo5cHlPcFhFWHNuME56MHdpM3Q4WFlM?=
 =?utf-8?B?MDJHU2JPeEs0cStmR2k5SGY5WlhlNzVCeCtZbE5CTllBbEc4RE50SkFYSTBs?=
 =?utf-8?B?V09lU3dZTnRMdmxJZmpoYlhlYjJaZ1BBTWFscmhEMER2NVYxYzhweDZyWUZT?=
 =?utf-8?B?dlBRREtsMjFkZ3o0TXRaZTBIdkhWNjZ1NUNrS1VweHZxWFZ0bHA2NHIxSWdy?=
 =?utf-8?B?Y1ZvL2R2Y1p0UkowZDRYNlRHUnRTL2Rjc3J1RTlXTjYrUGI5M0hsRnduN2tP?=
 =?utf-8?B?cnhXU0JuQk85dWd2MHIzMWNDbnpIcGp1V2tOWWxKR0RLS2J0SWZFYlQvTmpQ?=
 =?utf-8?B?Q1ZNV3ZUZFJhMGs4ODdCV1YxOFZ4WlVvTFNFK3ZwcWlLY2QrRnE5dnBkN1p2?=
 =?utf-8?B?NHJhYWd6MW9ZS08wbmFybElpOHRZUlU3cEZzRko3WjNDS1VYa0NiK0lLWDZS?=
 =?utf-8?B?ekpqTUQvbjh2RkpvaEdYWGp0ZEtGTXgvTFQ4cmdrWGVub2Nub21uaVZadENQ?=
 =?utf-8?B?c01kZDdRdmZ2eGdsN1REMFJGTVZ4Y292OWRmelZYcWhuZElBaG1HTkNLbTdw?=
 =?utf-8?B?K0wvL1F5dEgxWmsyd2V3R0ZRUWJzZENjM2tOVW1FVWphK1B3V01SQnhzOXZK?=
 =?utf-8?Q?bppZ0kiXJr2omyQsEAtUFRbzcGtDZ/fnvY6Ac=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TERaZ0ZwdDJCSmFEaDc5dkw1OVI2SWZlSVluV2pHKzR6UUdNMlE3Zk10SWNy?=
 =?utf-8?B?ME5STjVDeWRlcHJCd1lVZkI3UHVPL292ZndWWWFWZU5WSkU4VGhjWEtiK3A1?=
 =?utf-8?B?ZmlzQkRCRDZWb3gxZ0RLMVZNZzRmYjBaL2VmZWdZSStQclB3bGNiczdlb05L?=
 =?utf-8?B?Y0J3anZUdkoxdnRRdElTdzR3L1VkekZNcG9yR2NZbmtLNUh4M2owL2lGMUdi?=
 =?utf-8?B?dDVaY1k2a1N5d1BhMUtKSkRGSXlDUFlna2g1VFJObjNIM1VlbTA4YkFHM0Z2?=
 =?utf-8?B?blduWkZwMXhLeW9nMFRYbHJ6bzkzbmN1SWNRY3M5N2ZGMUFnQno3TXBMUUNp?=
 =?utf-8?B?Mlg2TVVhcU1GNS9JbVU2ZSs1SEhuRm55T0YrUGNnS1RzM04rc0J4anBxNDIw?=
 =?utf-8?B?UW1UVE12U2I5bFJuVkhXZkMwWUhhUUlyYTczVjVnUzA2QjFDNkRCaVRNNjgv?=
 =?utf-8?B?UzhTS053Q3VQNkpJcmQ0U1JoZ0FOYjNxRTUzYmc2ME12dXFWTlBiOG52a3BS?=
 =?utf-8?B?UERXZHJzT1FOWkxsaElDV0QxcXhMZnV6V08rNDV2a1NMa01aUExrb3FRbHJL?=
 =?utf-8?B?L2FSYjhHU2VMbVQzWkxlSWtwOHZGZFhvbThDdVMyZGpPeTkyaC9HK0xNMG82?=
 =?utf-8?B?RDBmWU42WmZPeUZmQS9pSTk5M3krZExYSGNEaDFoUWducEpsV2VGUGZwci9t?=
 =?utf-8?B?QmE0aGV6QUVCWjFObzROZzRKU1hxaXRNeWdNRGljS3ViTk0wYzE3MlRScGM3?=
 =?utf-8?B?YXhtVGhtTGtUTVhBMjhqcXAyOXBEdlRHUi9xMEttVjl6Y3lNQ2RuVitFUUVZ?=
 =?utf-8?B?RmozcDJLSHhtVk9FMWZ0OEk0SCtGV2VMUVg0dERic0dYb3B3STY1d2FWdWpO?=
 =?utf-8?B?c1NPN0NFeVA5MkF0ZCs5UHR4TWJTODYxTGhrZnBaazB4T0R2dmtOQk5JOXFP?=
 =?utf-8?B?N29YZnVaWHpuRmFyL0pXaGdPeFVpL1lLUE0vQk40MDVNaURESjJmeW9RV0Z4?=
 =?utf-8?B?SndWYy90VUw2R3dOajFMU1k2NnhXUklacjhOKzI0S3JvMUZyNVNHa1FoaFp1?=
 =?utf-8?B?ZjhBMVg0RjVLWXQvY2pYaHBzaFpybmRYbHBGdzU3MjcwRDVjdmFkcGdQb2lo?=
 =?utf-8?B?aHBXOERaNUlERHFycGVjVmFsaGl0dHdSekNBYzNyWCtzcHgvNlEzb0EybFdh?=
 =?utf-8?B?OEViMlZaLzhXWDJWQzVJcUpMOUR1MDBtMjBGbElGQnFtZFN0R0dJdndGdkpG?=
 =?utf-8?B?YzRvZFRiSDZPS2p1eVErOHJOdnUvQ3VIMEZKdnpXUHE0eStudjNnZ09jaE5F?=
 =?utf-8?B?VU5Pc2d1c05MMEtLQmtIZDV1bVcyZVVXUXhEYTd6eFVsSTVvZW16WWVGQTVT?=
 =?utf-8?B?NTJhVVlGc3pJRkMxS2oyeG9aSmlLT3gwMzVUUTUzOUR1WjM0TzkwZXlJczRz?=
 =?utf-8?B?V3l6UGZCT0dZeFVmSlRuSEtrTzIxOXNjS1FCejZJd3ZOdFVyeTgzb29KRnVP?=
 =?utf-8?B?RHpXREJBZG5nc0lOT0JOQldITmdyQnhFNHVBSGhYWTAzZ2pEeUx4K1NXNUxj?=
 =?utf-8?B?eGxVMlpFdjh0RUgzRUM0M05sZnBZZzB6YXJPR0h0dG9WVjJlL3RDTHlrS2J6?=
 =?utf-8?B?a1BRSXYyaWtkdmVkSVFXSnE2bzVlUFpENThPQkx2aW40ckNlQWpyYlU1R0Zr?=
 =?utf-8?B?Vkw2Sis0d1YwM3Z4RVhqa0dUN2szNG5VdWV6ZkVKSXVuVTdFUlBQWnZhU3Fm?=
 =?utf-8?B?QStwcGtpTWwzYVBkZGQ4ZjJVaXVoblVLakV4cUVqOFJra2NHeGZ3TnIwZGRY?=
 =?utf-8?B?VU9QcklkakFyWkxMWE1wbVBRWkFRc0VKcFhKOGhRR0p2MmtNOURuTTN3NnZl?=
 =?utf-8?B?cy9ZaXpGSlRwcXZncnFPdjg3Q3VqMHBlSE1XY0hrQjZVTjYveXM1cy9HT2VZ?=
 =?utf-8?B?eVJjNlAva1hSakNrc3U2QVkrOGhmWXdXelVZL01Vd2U4NmZqcDhMTVB2SlpO?=
 =?utf-8?B?UmQ5Um5ja3ZwL2Fhdlk2R0tlTjBIY0pHUFZpRGlGU01rN2ljTGN6UnZUbzcx?=
 =?utf-8?B?bzd1Q3dra0ZLZmd5bzdjUFNPVEg1UmJSRm1Dc2R2d2tLTGgxRnhUeE9nNUtN?=
 =?utf-8?Q?Zayo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fe467f-91ef-436c-06d4-08dcdcba82d8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 17:01:19.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAQFgEwHkdVL1M7Q/Rfv/6Tgw/e2C3WC4CNn0fjC186Bi13eGk+jNPlrRTyi33rH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185

Hi Peter,

On 9/24/24 11:25, Peter Newman wrote:
> Hi Babu,
> 
> On Wed, Sep 4, 2024 at 3:23 PM Babu Moger <babu.moger@amd.com> wrote:
> 
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index f11d6fdfd977..aab22ff8e0c1 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -187,12 +187,14 @@ enum resctrl_scope {
>>   * @num_rmid:          Number of RMIDs available
>>   * @num_mbm_cntrs:     Number of assignable monitoring counters
>>   * @mbm_cntr_assignable:Is system capable of supporting monitor assignment?
>> + * @mbm_cntr_free_map: bitmap of number of assignable MBM counters
>>   * @evt_list:          List of monitoring events
>>   */
>>  struct resctrl_mon {
>>         int                     num_rmid;
>>         int                     num_mbm_cntrs;
>>         bool                    mbm_cntr_assignable;
>> +       unsigned long           *mbm_cntr_free_map;
>>         struct list_head        evt_list;
>>  };
> 
> This looks global still. Will only all-domain (*=) operations be
> supported initially?

Yes. It is supported in this series.

We have one counter at global level and another at domain level.
https://lore.kernel.org/lkml/7a24bb182897acab3daaac1cadaabca3bcc73dc5.1725488488.git.babu.moger@amd.com/

Domain level counter is used for tracking the counters status in each domain.

Global counter is released once the counter is freed in all the domains.

-- 
Thanks
Babu Moger

