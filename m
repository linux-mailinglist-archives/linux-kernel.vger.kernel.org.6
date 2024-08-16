Return-Path: <linux-kernel+bounces-290296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B12A9551EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B8F286519
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831D21C230D;
	Fri, 16 Aug 2024 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MIFSPdUF"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F01C2316;
	Fri, 16 Aug 2024 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723840815; cv=fail; b=ian/f+nxCcS/TGRYTDS7qYsHeo+QqtHMrsg8ajbU9iyogWnqVyrQdgMBfske/N2dxxCHEw+D3S3XamLInbZrqKp4aldIwgNgf3VfW4Pr/j6+jREXmVefQCViI3vyR7OSQipf59zUx7VSta4XV4JXffts0npOO7EHPdrot7s7zMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723840815; c=relaxed/simple;
	bh=Q13ACW3FEDoXe7L4KzSjKOulkmoF2kB3VPjuFqdc5nc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=agNmmUiLRHRY0D+0uEFSP6pGjnQPMH1bjIlYx5bPwk1uJ7m5cbgSrSUeo2cnMR4Fl01cPgtRxTsrwQiaESraYWXbS2ib1sAEwq0Ki+qib6UYci888w25ZsqvVlpgcd676BTZCaV407wOiP7OKf9wPX+hPuWcqrJazeApvB9gWak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MIFSPdUF; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzQWR95DCFm5JfXe7YkuMimdmZavDH21raRwiE3ZINn2mAvrHQhuN3fN/h5Hjqn2SxsLV5gCzOrptV90TvCAT2E1p/OJN5e6HH1aqXAC+k2ybIQSRixzMdyYNyWIKYVJe19KFqHamB/df9eVzG5GBbOeuPRmzrOU1Ac4KmZmML4nZZ6Z9vXnlnMpEqGXnyxJ5ONxk/R7dxnSOF5Le+e31o9M07y4po6Lh/kyGCSEbG1+lFCDT7zXIFDLLw8Gz5SCYpNV/9+z9Ufslvxm0ydgpMw6+KFfumj6q9PeMe8TJ9iCuEhoM7NjpBusIULe2MTIa8WnYmgQ0a2xjOlwy5pOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7hyNwuNQghGhmGwACi4DJOFj3CO8alsIadR02F3bvM=;
 b=TmETaboEP997I/Ol4xO9cFfHRWnNNeoanpfO/z0DEXnQnx/RFEVWK0Bco6AlIv/D4mZDoQV8JsXTFymDQ9+9CfQhiIX7E/uT93s0ActYXYdhSdyUxghS5FQwIhEsGLOZr8HRVbPLw7JoBsgZoVc2NF3FhdD/EWoGLfMONq88WNfb4uqGXBc1EiAtHGfG5R1fyn+O2kRxM04zzmczGWeyTCFdHS2j+fAI6Jm2o2s/olzruUFBz9E2iRlruP2bKx4gqFljqElJp2fbXuTKXfRm1MvOMUiRDKbh8sM/irHDqheerTN1O/a5G/T1yLDsDoPWXNQn1zK1198ZuYNGk0Lplg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7hyNwuNQghGhmGwACi4DJOFj3CO8alsIadR02F3bvM=;
 b=MIFSPdUFpZ8755oegPQcuJuIsYc+sOcipDDcXLZxsnhZMezOtJHdPInTxrPbZXrJb4ureNZY7y6HIP+H6wj1J0HFmC9v3bq8GaNn7WLpM61ojttChwAkdX4zZFvzyF7u9LoGDWzmPBMW28KlZJfdykDw8zvzK4HqelXm5rigYWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 20:40:11 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 20:40:11 +0000
Message-ID: <b21ebeb7-090a-4c6d-918f-6ce9c5220ae2@amd.com>
Date: Fri, 16 Aug 2024 15:40:06 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v6 20/22] x86/resctrl: Enable AMD ABMC feature by default
 when supported
Reply-To: babu.moger@amd.com
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, mingo@redhat.com,
 bp@alien8.de, corbet@lwn.net, fenghua.yu@intel.com,
 reinette.chatre@intel.com, tglx@linutronix.de, dave.hansen@linux.intel.com
References: <cover.1722981659.git.babu.moger@amd.com>
 <1061a60166f2fdb508aaf2dd9163b2bab3705063.1722981659.git.babu.moger@amd.com>
 <df0c32ef-a694-4e5a-9d93-54ae2b93e452@arm.com>
Content-Language: en-US
In-Reply-To: <df0c32ef-a694-4e5a-9d93-54ae2b93e452@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: ae830fd6-e441-41de-071b-08dcbe339fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3hscnJha0tUcWlVNjdaK1V6YXVBTUZpY0pBY3BsRXltOWZJYXBLdGdSZm5P?=
 =?utf-8?B?TFNBMklrd0hhRFJrNzh1T1BCL3hHUjVNcVo4SE9sZFBrT2ZnK3ZvMk5ZcUZG?=
 =?utf-8?B?OGJsS1c5VS9tOVZFeVE4M0ZYaXpoM1dGT2FORnBIT1A2d01tUVpPOStZSmJr?=
 =?utf-8?B?aEpzOWtsVHFGVG5LZlVTSmNnK280a0dhdTdMbFRwNVNJdGpHSmVFWkxsVWtM?=
 =?utf-8?B?NW5pTXRoOWdSck5VVXFUVGNVV0pJZ1YyeFgveUJ2cnpKTzNHWFNMLzA5TjF4?=
 =?utf-8?B?MVlCajJiTTMzdDQ2ZHRyMnFGQXFTWnAxR2txWTJOR0dONFFKNVQ4cVdaWkVr?=
 =?utf-8?B?bVhGTUozaitTSW0zQkpkWVJiUlR4WWJ2TWhnaGhIWlA5bUNVb2RDVGM2ckhl?=
 =?utf-8?B?T0NHSVVhK2MzQmY0aU5EbW5IY3l2YjFxUllyWWg0RFFJZDhZd1V5VTJEK1JJ?=
 =?utf-8?B?WkorYldmR28xTGpmcktHNUdpM3JnQnh3MURldDRtWVYvcngxYm9mM1RLNjJR?=
 =?utf-8?B?bWhkd3RzRnd3VjZMNmFaWlBORHdMVU9CMXBpMGNjZU95L2ViQkw1dnU4NmVD?=
 =?utf-8?B?T29JNjdEcllGVmpkRjRMUjNnalptTHRGbk5ROTR4OTVkVjNlVFRBV1hsNDN0?=
 =?utf-8?B?MlVjNS9STE5UTGxwanV6OUUySXJhdU5keWxBRCtLTXNob1R1NlFGcXhpczFE?=
 =?utf-8?B?Qkp0Uk9FMlpZdWF3Z3E0bHUwZUR4R05GK3ppcldsM0p1Q0lPdHdtZkZuMTZw?=
 =?utf-8?B?a2JZb1ovMWc3YzdVeG1RWGVONFhkNGZiREpVY20rWEZJcXYwcEZTK3djUWJx?=
 =?utf-8?B?bHVyK2VkL1Jzcld5RHY2c2xEelNSYWFLS3dwMENwR25SbGs2MVpqc0R3Tm9S?=
 =?utf-8?B?NnVQR0oxVURmZmgvdUhZbEZ2ODdjcVBHVzRGY05WbGJmeVd1OWUwVUcvQ1B2?=
 =?utf-8?B?d1U1cWgxZmdjSndyRXV6Vk56WmJ2MmdnY3Yrb3dnbkVGR3c4Q2ZaMlNSUFlK?=
 =?utf-8?B?aDhjNkRENENhRWdVYWs4NkZxVzVsS0JUMjlzNks4cUpOWXI1VjZYdU9lVXQ3?=
 =?utf-8?B?U1B2K2hWdzRGTFRRWWw3WDZCUlVETlJyVzdvNW5mSTlGTUh0UEFMb2ZwN1JN?=
 =?utf-8?B?VkhpdkVrRkFlbjNtU0Jwc2FycEJoTGpyY0p5RXZyYXgxRmpBZ3R6OTNVQ1RG?=
 =?utf-8?B?Y2lBM0xwNlFzdUR5dWdFSGxQR3BvYWttV0VwQ1RnU0FvRzNMVmg1R3dNZFQ4?=
 =?utf-8?B?RGJTb2Nyc3p0bStORUxQRUZtakxpVGpHb29SMjh1YWxaQkJKMVlDY0F3RStT?=
 =?utf-8?B?SUJoYktLTG9TdlRUQ0Jld3JETmtKT2JjQ1JmU3IyYUlnQ0UrUFRVQXRONWNu?=
 =?utf-8?B?Wmk3bWNGSFE3TDZxdGhFNWhRaUZkMFJQOEpnS2FndGZvVEdSR1BFck92VjE2?=
 =?utf-8?B?UXVTTG5FaW5nOVRGRU1ZUnVGTnlDSEZqUkp0K3p3dXpQclR4ZFVzRGszVTUw?=
 =?utf-8?B?U3ZSZjBvTlZVemZCTWZxWXkwUnBzaWRoUlc5bFBEdUU1UGFLbFVoWHpjeHVR?=
 =?utf-8?B?VzlkMlcvNGtIQjc2K3ovNFBpS29BODZra3J6dVJmcFF3MUV3US95a3hzNjBX?=
 =?utf-8?B?dGhmUjNwOGIzN1pkazZJaENqeDhHUnZMSW9ENTdQbk15U011emQvRG8wMGJT?=
 =?utf-8?B?VjhSbmtQMGRWOGk2ODFlMkNreFlSQ21zWE9aNWgweEliajZXTnlBS2xmaXU3?=
 =?utf-8?B?cXBIWDloU3R6eWVQY3pFZmo2dHJnSzNvTWtSMzhKdE8wUVB4ejMvMGIzWlVF?=
 =?utf-8?B?dzE1V09wUzVYWGJQSWFYdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ty9vU0JGODhZTlp3NzNkMGg1Zlk2Vk9PRm4rT2ErNHhkc1FZZ3hlRUNtWWE2?=
 =?utf-8?B?UjFpRjYvemtlRCtiTEdBOWx6T0M1ZTFjR21FZVErd1J5OEpBaUJsR0twQjZl?=
 =?utf-8?B?eUQ0aFlPajdEK0JiQXNZOVpVY3hjR1QvRzJ3dDRPVHF5RXd6azBDMGJ6WHFC?=
 =?utf-8?B?TWxMTFRKNWhLQ3c4ZU5HMDNhNFljMzIybHRta2llSUJuTzBPYjBxNm5yOFRE?=
 =?utf-8?B?OVBHbUNSL1YxV1RLSnlka0FnUWRpeExVU3lZZ0pLK1JWREQ4c3E3QUhqWnFW?=
 =?utf-8?B?aUFvcnpkYXM1VEFJQ3B0a2FGb1ZOWkJ5OW5SSmc1d09EM0JaZWYvelUwT1FL?=
 =?utf-8?B?OHhpbjBQeVEwemVuMlF5MTQrRDJwRW9ZOEd3WkN5TlNEYXloeHl2WGZrNDJJ?=
 =?utf-8?B?VDBoN2NOVUdld0xJcEJBUjg5cVNUcmJ4aU44YkNXREVBc0tIQVlFa1E0Qy94?=
 =?utf-8?B?MjQ0c1lxR1owYTZqRExMZ1N1d3JwMnJZcWNkMGZXdmhhTnR2Vzl2V0lGdzZF?=
 =?utf-8?B?R3FpQkxOZmtvaXZ0UXVNLy96UTlzb1R3MW1kdW5qM09uUm4yYXRnNmRWVjg2?=
 =?utf-8?B?bXhYOEF1U0RjK0kyajNiTHlTcXc3U2J6aGRUTXpYZkZUOXg4ejJ3YTFDUE03?=
 =?utf-8?B?T3RySTJvWUFBaHZsRnNPemRNV3hkckVxbkQ3US9WMUhRbmtHejhaSFV4SU92?=
 =?utf-8?B?azNTemI2aEVhMUVQVU1BYjRRNnVXaExFb3hIVXZ6VkxqRG5NSTVkSUg1VmtR?=
 =?utf-8?B?bDAweG02eWJOcFdscDhITHZLVzlxWmxXVjR6bk1QbzNqbEZXaSs0Z3FDSTNy?=
 =?utf-8?B?YVA3WnQyeVFTWEFFSjJwc0J0eGNlOWhhS1pJczRSS0dIZmpZZ3R3cTVmTzJT?=
 =?utf-8?B?WVFUZVpEVUsxSXpYQ0pZR3V4R09ZUFR6Z1VxT01RdTZHcHkrWWFUd0h3aUJZ?=
 =?utf-8?B?NVFmLzVmNTlmZWRrUmF6R254ZkxqcEpYcEJDRFVBZnNrS2loNm5MV2tuSUI3?=
 =?utf-8?B?QXBDVVo5NHRINjNmNk0rTng3QWVCVnI0dFJKRVJSUVYwQ2VGOGxJRVVreGp3?=
 =?utf-8?B?QVVvQ2NIVVMybXpoZldTTWk4elRUR1Bjc2NMRUs3eUpDTVdwek1Fc0YvM3dW?=
 =?utf-8?B?NGhHUkNjMFBzZlkwUjhvS0ZGMkNzdXZOZHBZZmpkVGFKaHhQQ0FSU0t4OWlD?=
 =?utf-8?B?OFg3R1kwZ1dqN1dpdUZ4dWV1VDNOTE9LYkFoN2dxWWZBR01DSlRjNVUwcmV0?=
 =?utf-8?B?c0thWko0K0l4QkJoWUNTNy9iYVpaN2RFNW55ZlRoMTQyVEFvQytnTW8rMnQv?=
 =?utf-8?B?UEY3WmpPOWpQQW5HbXJqdmU1QWdFMTlCSVJ4VmxYSU1DOXdHaFYzVFpZT2xD?=
 =?utf-8?B?dXBRdGdnT29Dbi8rNE55ZmdVeWhhM2I4L28vUjZvbDlJU05MbENnOEZKRjZY?=
 =?utf-8?B?ZHkwTlNuN1FJcmtUbHlDWVdhMWtMUlBGRXhPSEdVTkFpRlZPN2FuN1VEWllQ?=
 =?utf-8?B?aE5manVUMk9wM2pRbkE5RGFYbWVuMVRVRStxNEtLZVlSazNoWFNXb1VZRlpY?=
 =?utf-8?B?OU8ydWI5TWFOY0hMVlVxSy9mYTZVa2ZNZTNJK2h0aDIySjMzd0g3OWpDRmtu?=
 =?utf-8?B?TWlFaHdYMDdnQVQ0TTRsQnA5RTVZbjFuZHlVc2pTM2JZTnBFcU9BSXhVaEZL?=
 =?utf-8?B?TjNydHAwc0g0cWdSOGFMazR1SDZtTXR4d3N3aXhQZjc3UzB6RjBKdFBGM1BJ?=
 =?utf-8?B?OGx4cnN3Z1dVdWFUM2MzMFhmdlFIaVZXNGZMc25LV3RVbnIvMktpRmJpMEZL?=
 =?utf-8?B?YnphRmJHZmNhUDUvNHlrOFZUQTJWcjArWDdyUXdWaTFTWlhNY2gvWS90T2Ir?=
 =?utf-8?B?R2NOOE9VK0NXb2VrNFRESXpwSEc1akRxaFF2VG5yMUw0cXlad01RRmx2eGRw?=
 =?utf-8?B?WnVDV1BwQm4rb3pnYkhualppSkw4cVRCMTg5NlRkaTl4K2tVK0JvU1dFYnBN?=
 =?utf-8?B?ODlnZHdBdTNMeHduSE1XVlZmQUZMK0E1dWJmcW9EZFZoL0h5SkNGZWYyS0ps?=
 =?utf-8?B?K3JaNDVETXNUR3M3S2lKTXdwUWdoTXpEdDJlVGpObW9KNy9aTHpHUFVCWEJU?=
 =?utf-8?Q?wJZ4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae830fd6-e441-41de-071b-08dcbe339fa1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 20:40:11.1400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHPXzkqG0rxE9WcZL8gJOlK0F9aC0jRhiw/sjURGKvcea4P9y2M/Pp5nzWWjtRUt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315

Hi James,

On 8/16/24 11:32, James Morse wrote:
> Hi Babu,
> 
> On 06/08/2024 23:00, Babu Moger wrote:
>> Enable ABMC by default when supported during the boot up.
>>
>> Users will not see any difference in the behavior when resctrl is
>> mounted. With automatic assignment everything will work as running
>> in the legacy monitor mode.
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 6fb0cfdb5529..a7980f84c487 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -599,6 +599,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
>>  		d = container_of(hdr, struct rdt_mon_domain, hdr);
>>  
>>  		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
>> +		resctrl_arch_mbm_cntr_assign_configure();
>>  		return;
>>  	}
>>  
>> @@ -620,6 +621,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
>>  	arch_mon_domain_online(r, d);
>>  
>>  	resctrl_mbm_evt_config_init(hw_dom);
>> +	resctrl_arch_mbm_cntr_assign_configure();
>>  
>>  	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
>>  		mon_domain_free(hw_dom);
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 66febff2a3d3..d15fd1bde5f4 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2756,6 +2756,23 @@ void resctrl_arch_mbm_cntr_assign_disable(void)
>>  	}
>>  }
>>  
>> +void resctrl_arch_mbm_cntr_assign_configure(void)
>> +{
>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> +	bool enable = true;
>> +
>> +	mutex_lock(&rdtgroup_mutex);
> 
> As before - this lock isn't available to the architecture code after the filesystem code
> moves to /fs/. To prevent concurrent calls to resctrl_abmc_set_one_amd() I think you need
> your own mutex.

These calls are originated from domain_add_cpu_mon sequence. It holds the
lock already. We should be good. I will remove the lock.

> 
> 
>> +	if (r->mon.mbm_cntr_assignable) {
>> +		if (!hw_res->mbm_cntr_assign_enabled)
>> +			hw_res->mbm_cntr_assign_enabled = true;
>> +		resctrl_abmc_set_one_amd(&enable);
>> +	}
>> +
>> +	mutex_unlock(&rdtgroup_mutex);
>> +}
> 
> Neither of this functions callers are in filesystem code, could you drop the 'arch' from
> the name - it isn't part of the fs/arch interface.

Yes. Sure.

> 
> 
> Thanks,
> 
> James
> 

-- 
Thanks
Babu Moger

