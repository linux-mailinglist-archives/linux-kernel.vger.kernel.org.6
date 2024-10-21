Return-Path: <linux-kernel+bounces-374605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BFF9A6D60
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3FD8280ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DA31FA245;
	Mon, 21 Oct 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VDQcZGkA"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F149C1D517D;
	Mon, 21 Oct 2024 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522591; cv=fail; b=jg+lz3SKViYZKGrJGyYbCsC4E4MLnHMvwOISpbMG0oFHvVR00c8lI4yWXot+vMO+5c9STwdKXH7R4CqKP67m8g3R9i7akUAFo4U7fkvmKjzUUfG1gVXfeGL6krLmxguuX6uLALvRYMFZEJ91gAf8yABxzykudAE57pAC8r8P0wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522591; c=relaxed/simple;
	bh=bq3/WOCMWaJ9tC6Vg7w+puyRlGO8Qvv7ei6UuSVc9o4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gm6Bo04kNXFHDx1eq3kR6+IhUJ4dPfZC+yLpoYd7XL6P643JEWwJlozlGzndorBiFGCH2pxbFlgRXGAHp5dTvHUDbWRJyflTR2vGoq8bh+SR1as9QBMtgc1QTM73gvG3APLbr4FKuW6sRUBgAHpNZjbvz2gQ1wF5iJrnll6TaoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VDQcZGkA; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qcp9jEzUwBHStfQ5FiAzwhi187gv+cSLGMn5xsPJECGiWtb8VySEYWGlMl0Q6O4D2jlNv47n+AdB7nJKULHTDEXUo1/+hgflwbOsqeverCbCOOiLr4hjz/pCawPkAhNltvU2O62aZWv6m5Un3iXUjnluUVofZKUk7QE4xlA4odJsz7Zv8n5XAua55vFPCKmkKxnDOGYhMgToeiKyITtqoF0ZiDCIMiwJl/dO1OpOUbfiKjurw7yW5RfKfBADoGvjgNqQmNZCWpBp0D4IzBNU3MiRXjSJ5UUl/926xDSFg7HzvhVgGR4H63tRuHpUpvxIbCClpLsBDM8ECWYaurg5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPROLUQQIvpLXtaRpDnF75YZY9EdJlogxzI/0vTE2Vs=;
 b=tbCPemceYwzCf6H1NHh8y5TgakQv3gNxvIr2HXjN8wwIsn6xp+1WKdLcrqvOTkrC6KNLUXabELe0kmwpyI+4UyzVmIFTcCHKo7+MVeQ1DHqR0HO9UBS0QNrXrPYd/xzPPAE7Ni2849KUsM2pOM6Nxvt5RFmcqJFbvHFAh/CNah6QWdtOSpXoEWK/ui+Qgs19vYpjapNQR1IZMGfR9vaUqVNjW/+RCwzMdYIGnNsm0fGH8scdCjQwZJ++CvcNeIeaM9MBb6MQ8aRDkI7zMbxqiv0l8IrR1umr8XvMkAi+FLQ8IMFZX/V3QCOVLpq+Cl3byTvHKyjLqwWNDQEgsP/p6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPROLUQQIvpLXtaRpDnF75YZY9EdJlogxzI/0vTE2Vs=;
 b=VDQcZGkACrsSk8rtHW3MSZof6PHZUI1+XUqTmrsA+8OIeQfJEeaj6YtBhx/2E+i1dXpD9eHM0HqhdYKvvvBAPKFfzdWsKL2iSmII7NVe9CPF1coYYyBb+P6As7NEPe8xscRdn6cQX+GeRHuYt3SgTev4wkiCS63a9SZvujQAB7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 14:56:19 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 14:56:19 +0000
Message-ID: <f9be6c60-88ea-4f95-9d6d-860f57d820ed@amd.com>
Date: Mon, 21 Oct 2024 09:56:15 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 24/25] x86/resctrl: Introduce interface to list
 assignment states of all the groups
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1728495588.git.babu.moger@amd.com>
 <a7a62f49523aabba1afdeb469c8df393e182acd8.1728495588.git.babu.moger@amd.com>
 <6752082b-9069-4424-a7d4-cb4480f09213@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <6752082b-9069-4424-a7d4-cb4480f09213@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0123.namprd05.prod.outlook.com
 (2603:10b6:803:42::40) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c7bdae-cce4-4cb2-cbfa-08dcf1e0856f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXcwNHpsc1ZVWWdPbmV0SWtVSG5nc0hzYUxhTk41bDk3ZDdUbEFpU21rZ0wv?=
 =?utf-8?B?K3JBRlRjemZJWFBZSkMrcTBkRFJmdktvZy93VnZLSzZ2TzlpcnNUV2pVM1hm?=
 =?utf-8?B?OG5Bb1NMRWlsUXFvUFJ1Qlc5MHNVcndWVVhPY2pNaUZvSm1LK1F2dGlmbjVq?=
 =?utf-8?B?a2VTZStkODMxemxSdk9FZ0NiaWl0bytOV1RwV011NDN2b1dVZ3laNHR3V1M0?=
 =?utf-8?B?QnA2QjdDcWpWNUJ0U1VONm5ZQXpQTXluUGkxMVNmTVVKUGwrbnMzdmxKUWJq?=
 =?utf-8?B?c0d0U0NrRFN6VXdPdFdhRjhlWFJIV25kalQrMXlhL0FnbkdzeTh1ejhITnp6?=
 =?utf-8?B?SjNGNDRjMEhPK0xGTGhrMHRaT3pRODBNa3BVS1RsTmlBMHg3YUFiV2Z5dlhy?=
 =?utf-8?B?K2crRk5MaGZ4K3pXc2MzMmRSTXVzSll2TFlTRWRKY0plaW84M1Z2UWlTZkJX?=
 =?utf-8?B?aGxNZTVQNlZGQjZ0TktGRFdnaVJqNjZwMlJFY1RBb1dZZXhkTVB4Z1JvcktS?=
 =?utf-8?B?RWlkRXZFTWR1aVJtMmZBblZJM1RsSEl5RkdxamZmRDM5MytBQUd4NEtwUmg3?=
 =?utf-8?B?YW9aSmlzaHZTRlRsQ29pRjcxNmhCV2xCM1BxMytGWmQva1lHUnpGVVNVZGMx?=
 =?utf-8?B?QWFxdVRYbUZTWVhJcFpsTzlRZU1NTlBqUDdvZnp6WFJWTVBoNndPMTZOSHZU?=
 =?utf-8?B?b0lpT0g3dUN6a3I1Mmw0RHZseFcyUi9XdGFKSWdrai91OFM4bTNXb29uaDNo?=
 =?utf-8?B?NUVzZlpoTWQ2cGVOQVBWdmJGY0FXZThTRC9OdkVSMUdId25TbFc3NUN3emEy?=
 =?utf-8?B?RitqM2VtWVRMSldYOEdsaHZnSDFWNUNhS3p1UHZtVTBramlWVWVIUjZWYjNi?=
 =?utf-8?B?L1p4OTc3Zzh2V1BVOEtSN3BXUGpXbDRVUGFsdjF1d3JmRDAyQkR2NUxLZml6?=
 =?utf-8?B?L2FkWE5IU2R3bnEyNlIwMk1vQm1OaHEyd0VwajJaKzhPcjhPTDdkN1RPdnpE?=
 =?utf-8?B?VWo0c0FpemVhWWh2MTFRWURCLzNRZnBwQ2xHaENNU0Y1TzIwZXcwWmJXZkpZ?=
 =?utf-8?B?dTVHV3BPTFFPS0dJVnA3bm1Zb3BWbGtlY0M1MktOOTB6cU1DZDdhV203UHI3?=
 =?utf-8?B?VFp4WWlJUDV3bzdnRVJTQ1p0d2p6MkdqRDNzbytKS2lTUEkrTG1xWjNEWVRk?=
 =?utf-8?B?YXNtNXVlaFVWS2xQUmUxOXM5bTl3emdtYms3YW8zaGE2WVFjcExYZzlFSmsx?=
 =?utf-8?B?Y0EwL2FSd3pBWlVUbmhhWHc4eEo5azEzMG1zNEp2MjF3SmhWekVOS3k2dnVP?=
 =?utf-8?B?TkNRYy9vVXNxTWJDSkJUcVErYjl0dmZNSEFBaEM1ZVd4S3lqNUphMVNpWU9Z?=
 =?utf-8?B?R2hVVnJYeUNhSlJ3SlNidS93RUpOdU0xZXRrbVZmOEQzK0g5TktlZ096MTlI?=
 =?utf-8?B?QlRCeE11b09MMll0OXh3WnBSWnM1UEE2Ulc4TmVMTkZtVWdUQjcyUk9IcE1y?=
 =?utf-8?B?dVAxUlkxUEw5MEpobHNpaXNLN082RWgyNkRweFAyVFlZVUtKUWlxMi9JVkxH?=
 =?utf-8?B?SGZYTDY5cUtYNldjcnZLSk9yZHRDeFZuRUJFTEtRaEVvVERXV205VGpEbmh3?=
 =?utf-8?B?QmRJTzlXWkNNSXBTei9KclljeE5xakFETGg3S3JWbkVnQ29PSlBiaHpQNjVB?=
 =?utf-8?B?eVZRTVdjbWlhdHRqblhRdlE1V2h1NmlXZERGa0o0M2lLcFBHRXBvK1lwMERr?=
 =?utf-8?Q?myYJ4TkC5Y+1EqYmJW9uqJfSoNcPUW38/IY8hI/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MW9oTVRIMUFUUzg3OE15Z0JZUU40UEUzbHo1a2JYdlZDeVdETC9YN1QrWWVh?=
 =?utf-8?B?VkQvMzNkYmh2K1ZLcE9YMElQc0tscWxUdmNPVHBpK1A1bmsxMHN3VkVzMUJr?=
 =?utf-8?B?T29QTWtFNExTVnlUcmNMbHppYXphSUpjVkZaNHArMmMxMWFkbEsvRCtrc1VE?=
 =?utf-8?B?STVOeW12RUEwVjRROXhDeVJKcVRLYzlPMGxxRE1kV1B0R2JqVDFtS2U5bmcy?=
 =?utf-8?B?UnR5RlIxZ0tCbmFJME1sWmtMWE1icEtvWmZWSHVJUWFHZXNhbWcxWU00YmFm?=
 =?utf-8?B?M2ROZWluTExIK2gwS3p2TW9jZ0pwQ2xaVXlONDBabE8vSU1mQ3pIWTdZNis3?=
 =?utf-8?B?RitraTZhMVQwQnlIUEJnSnJBaDRKanV2M1JDbUdGZDV1NDhCdXRXYmRzc3Q0?=
 =?utf-8?B?UzdSV0JFTEFWYzVUcXZudTNjSEhSaWRiby9KS1l5RGpBYnlJZnFiN3JacExJ?=
 =?utf-8?B?OXJUZ1ZJQjNsRFBvSk80eUhEZ0ZvNDg2dnZ2WmhJNlJWYlR2OGVTbnBwZTZE?=
 =?utf-8?B?ZE1jTi83OVY2UnhCTGppVDF2UUJtaXphNHZBUG5QaDNNSmxCVDFUYmZOWkpV?=
 =?utf-8?B?dXVocmlCQ3NOUlIxY3BhUFlOUmhaNEJIckwvS01HMzcxejBtcEtTS21yOWVR?=
 =?utf-8?B?UVIvdnZ5d0gydXp4ZEtHT2o2aThFZmNsRFAzTWVzM2k5VlBmdnBvYnhqN0Vx?=
 =?utf-8?B?ODU0QTlFVThBT0ZOTHgyc05vL0NLODNFdnNObUlMQ2g3THVralB5ZlJXdnF6?=
 =?utf-8?B?WE1vdDJpaTg0QXViblU0NVltZytBMitoNGFnakJ0aVpIYTFQZUdRSTFaL1FM?=
 =?utf-8?B?RHhtc2lIT0ltKy9nYmx0Q2hmYUFPYlBxbVdmYU15SVk1ZjhtdnVzSDFrZGR2?=
 =?utf-8?B?TVQxMHNqanpWcDhON0lWSUl5UTRsS2dFcmRtY0hrYVVPMmp0eE54SGY2OXdr?=
 =?utf-8?B?SHhqaTVTUmxHdDZBMTlnbnEwQTVCZVltSTJPaEdqOEZtTmtVQURSNTIvdDJZ?=
 =?utf-8?B?eVBsR1BMbjR6ZExEdmJJdXlOQWZrRmc1aUN6Mmp3ajcyeTBjLzNleXBGR3Qz?=
 =?utf-8?B?TFl1aHc1UEhXZ1Q2b2NJTWhjenZpUEtMRitYTStVSGZRSjIrTTZ4QnBGdjho?=
 =?utf-8?B?Rmk1WUtBdElDa0FjUmhlcVJQamZwRTVmdGlQWEs5WjVlQU5Zc01DUW9iekl6?=
 =?utf-8?B?TjdUaXU3OHExTkRnVUcyajByYzhDT2NFbnRuYUxQWThXTUV4WGQ4bGN5aXVr?=
 =?utf-8?B?T1h3MmhmK3dxZ1ZMNkRLZnZqZk1Yc1dpZ1ZRK3NLYTZUWis0RVo1Sm55T1Jv?=
 =?utf-8?B?dkFJUzR5Z09jRUNMWGVERTNWNkxTK3NIazllNzYvZnhTVHBheEZzZVRRbUcx?=
 =?utf-8?B?aytkUU5SQmpkb1VReDJjQ0h0M2tjRnJaOStJWWFVd2oxbzFGSGxDc3p4Y2l5?=
 =?utf-8?B?QzI3YitwZEUxaXRRdG05S3RtWHBYSHF5NDVMMWc2djZOWU5JTTVRTWhDa2tF?=
 =?utf-8?B?eTd5K0lPVlhMcHVuOHBTNkdSSUwrbW45UjJHQlVQR0hRSzVPL0pTOVBpNHly?=
 =?utf-8?B?TGYxL1VPQlFqMzNlNEVDeVB1ZnZPcmVEbndULzI2TVVEQ2R5cW5HWXl2Rkh1?=
 =?utf-8?B?WGpXRThlZ04vOTA2bC9PamJEMFpZYjE1cG9mMjZQODk2azQ4NlVCektWOWV0?=
 =?utf-8?B?QjZUcFVlZFhRZ0VWWWM3QW0rYXF4RmxFZDVYWFlVcXQyZkN2ckJrQjluZVBx?=
 =?utf-8?B?Q004Wm1Hakc3aTZsRHNpM3VETVZjenViZjZvbi9hanVjWWpmR0pxTUQzM2I1?=
 =?utf-8?B?c2JFT0RkMkpQVk1mVGpyd3A4RHNQU0tFU2Q4MStIdHVONDJtd3BGdVNTZ0Qw?=
 =?utf-8?B?Rk1xeTYvSnp6WlVWbkdNRHhITjBXQlgxUGZYWm80SVM4Y0FWV2w3MDErM1Bp?=
 =?utf-8?B?cjdIaDg1K1NTRXNqVHJwRHI1OU40MWFvbVdDdUFaTzBVT2lsWEZJL1AwQ0RJ?=
 =?utf-8?B?WkFSN0d4ZURheEE4WnhNR1FUaWs1NUN6UHB5cndOdDExYVhJR0xCNjloSU9T?=
 =?utf-8?B?TFJrbWRTcDI3MWltZkhEc2cwWDJQVlFyLzJ2cVROTkttRk1uZzdKQzdzbnBE?=
 =?utf-8?Q?9XTs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c7bdae-cce4-4cb2-cbfa-08dcf1e0856f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 14:56:19.6047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSJ6LEFHv5jmKsehoRN2fqbrjCfcEGpnoaGXA0iveS660t9St8Ll64XT30wGJx+Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523

Hi Reinette,

On 10/15/24 22:40, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/24 10:39 AM, Babu Moger wrote:
>> Provide the interface to list the assignment states of all the resctrl
>> groups in mbm_cntr_assign mode.
>>
>> Example:
>> $mount -t resctrl resctrl /sys/fs/resctrl/
>> $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> //0=tl;1=tl;
>>
>> List follows the following format:
>>
>> "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>>
>> Format for specific type of groups:
>>
>> - Default CTRL_MON group:
>>   "//<domain_id>=<flags>"
>>
>> - Non-default CTRL_MON group:
>>   "<CTRL_MON group>//<domain_id>=<flags>"
>>
>> - Child MON group of default CTRL_MON group:
>>   "/<MON group>/<domain_id>=<flags>"
>>
>> - Child MON group of non-default CTRL_MON group:
>>   "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>>
>> Flags can be one of the following:
>> t  MBM total event is enabled
>> l  MBM local event is enabled
>> tl Both total and local MBM events are enabled
>> _  None of the MBM events are enabled
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v8: Moved resctrl_mbm_event_assigned() in here as it is first used here.
>>     Moved rdt_last_cmd_clear() before making any call.
>>     Updated the commit log.
>>     Corrected the doc format.
>>
>> v7: Renamed the interface name from 'mbm_control' to 'mbm_assign_control'
>>     to match 'mbm_assign_mode'.
>>     Removed Arch references from FS code.
>>     Added rdt_last_cmd_clear() before the command processing.
>>     Added rdtgroup_mutex before all the calls.
>>     Removed references of ABMC from FS code.
>>
>> v6: The domain specific assignment can be determined looking at mbm_cntr_map.
>>     Removed rdtgroup_abmc_dom_cfg() and rdtgroup_abmc_dom_state().
>>     Removed the switch statement for the domain_state detection.
>>     Determined the flags incremently.
>>     Removed special handling of default group while printing..
>>
>> v5: Replaced "assignment flags" with "flags".
>>     Changes related to mon structure.
>>     Changes related renaming the interface from mbm_assign_control to
>>     mbm_control.
>>
>> v4: Added functionality to query domain specific assigment in.
>>     rdtgroup_abmc_dom_state().
>>
>> v3: New patch.
>>     Addresses the feedback to provide the global assignment interface.
>>     https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
>> ---
>>  Documentation/arch/x86/resctrl.rst     | 44 +++++++++++++++
>>  arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 76 ++++++++++++++++++++++++++
>>  3 files changed, 121 insertions(+)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index d9574078f735..b85d3bc3e301 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -310,6 +310,50 @@ with the following files:
>>  	The number of monitoring counters available for assignment when the
>>  	architecture supports mbm_cntr_assign mode.
>>  
>> +"mbm_assign_control":
>> +	Reports the resctrl group and monitor status of each group.
>> +
>> +	List follows the following format:
>> +		"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>> +
>> +	Format for specific type of groups:
>> +
>> +	* Default CTRL_MON group:
>> +		"//<domain_id>=<flags>"
>> +
>> +	* Non-default CTRL_MON group:
>> +		"<CTRL_MON group>//<domain_id>=<flags>"
>> +
>> +	* Child MON group of default CTRL_MON group:
>> +		"/<MON group>/<domain_id>=<flags>"
>> +
>> +	* Child MON group of non-default CTRL_MON group:
>> +		"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>> +
>> +	Flags can be one of the following:
>> +	::
>> +
>> +	 t  MBM total event is assigned.
>> +	 l  MBM local event is assigned.
>> +	 tl Both total and local MBM events are assigned.
>> +	 _  None of the MBM events are assigned.
>> +
>> +	Examples:
>> +	::
>> +
>> +	 # mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
>> +	 # mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
>> +	 # mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
>> +
>> +	 # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +	 non_default_ctrl_mon_grp//0=tl;1=tl;
>> +	 non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>> +	 //0=tl;1=tl;
>> +	 /child_default_mon_grp/0=tl;1=tl;
>> +
>> +	There are four resctrl groups. All the groups have total and local MBM events
>> +	assigned on domain 0 and 1.
>> +
>>  "max_threshold_occupancy":
>>  		Read/write file provides the largest value (in
>>  		bytes) at which a previously used LLC_occupancy
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 395d99984893..fa7c77935080 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1269,6 +1269,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>  			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
>>  			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
>>  			hw_res->mbm_cntr_assign_enabled = true;
>> +			resctrl_file_fflags_init("mbm_assign_control", RFTYPE_MON_INFO);
>>  		}
>>  	}
>>  
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index cf2e0ad0e4f4..cf92ceb0f05e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -970,6 +970,76 @@ static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
>>  	return 0;
>>  }
>>  
>> +static bool resctrl_mbm_event_assigned(struct rdtgroup *rdtg,
>> +				       struct rdt_mon_domain *d, u32 evtid)
> 
> u32 -> enum resctrl_event_id ?


Sure.

> 
>> +{
>> +	int index = MBM_EVENT_ARRAY_INDEX(evtid);
>> +	int cntr_id = rdtg->mon.cntr_id[index];
>> +
>> +	return cntr_id != MON_CNTR_UNSET && test_bit(cntr_id, d->mbm_cntr_map);
>> +}
>> +
>> +static char *rdtgroup_mon_state_to_str(struct rdtgroup *rdtgrp,
>> +				       struct rdt_mon_domain *d, char *str)
>> +{
>> +	char *tmp = str;
>> +
>> +	/* Query the total and local event flags for the domain */
>> +	if (resctrl_mbm_event_assigned(rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID))
>> +		*tmp++ = 't';
>> +
>> +	if (resctrl_mbm_event_assigned(rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID))
>> +		*tmp++ = 'l';
>> +
>> +	if (tmp == str)
>> +		*tmp++ = '_';
>> +
>> +	*tmp = '\0';
>> +	return str;
>> +}
>> +
> 
> Reinette
> 
> 

-- 
Thanks
Babu Moger

