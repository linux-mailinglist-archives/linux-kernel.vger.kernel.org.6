Return-Path: <linux-kernel+bounces-254423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A303933307
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82D7283C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51554D8DF;
	Tue, 16 Jul 2024 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jNMAcou/"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDB73224;
	Tue, 16 Jul 2024 20:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721162729; cv=fail; b=N8dKkwmlYVFqY+EwTTd0wmfJBY1Ao0piDzyHzpP9e6aZrDO6Y7L8/uRpU7Nw/YM/s5o1ZazMljj5ayvbArJF+6TPYGMFYYNiLGj/S5AgseFUf/dnBli1KZeYr7yzIcMtb7usu0rRoz04dhYt120l1PNaQN6heiHlygpFxLQwCZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721162729; c=relaxed/simple;
	bh=g/myl4PFAcGVPOrn5fnS/9YRiICJksQPuZmXOeoeQCE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PfqyXzoxaT/2zCSAWsa4IPzswSauw4cteg/8jiQFUOr/ehO61qaKqIAjFnwHDEn+Vie3FaWSO7YFWhn9sLiYZ5js4W3MIoftmnSbBPt3MidYMJ/7iOlSqjJf4CYmyjssXX7BUyjxu/2PpGa48CO0MURLf7X6eWmvjocUMrHjsro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jNMAcou/; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cods4ILP7Cx7nLqPcE4KhNTq0KDUkRlRV09G1LBKQYR+jANwYTq7JjnMKhwDTTPpwrUsC+F7w9dcsCcb5nkNMAuSBoYnzsMO+ZVGJ6nIlGJ0Sv7NtaFQyYc7CRdHVdPB+Y/BoH7JAk3xAubXGXzX+pYC840dhQbxSkRK5iwEf/RS31WWLyogywfbFeSIjQvMdF6hYLhiIZVY+YPC2wZ3NNHLQDaZZm4DP2L9OxsNx839sRuj+9MuT4pFpeRwG9s+bsnn6IIVQx3NkdfLuCnjGxtOX60W6gq0agqsbpJ7lD32gLRitwLXr59X7sP2/XXrHn+XLYnWy0BZGrGJeCzqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k4od1Lg0fmN4QIRhx1W11JuSgMXGpSslPKUSgwswVU=;
 b=N1sNPZ50GFZgTO3o6D0xdoCZu4e6kDgeC3nClZu2YpdlOnIwQtkOor7pXEBPhI1NSvcYhppHRg4EOXOy4ScQy67l26mcj1BZhWqc3blK8RZEtagsJyIheZRGwtBV+5HDAyxFmnKzaXCtg3WeiIpJf1YGdszATs+vCxKz97Hap+641dktDBiHTO3vWnZUFkwLZrm7X88hi3ENgpPygLVl9RLowEKyJkLgedgZkrVEgOwCr7iOrRSfy28NlzMZcj+13E//VsmjFTgb5EtzKpQ3udxHiKKcfH6WK1mgTM9Ynv1tYe7/zFmxqubgvfdvkKL3mnO1u7XMU9aKFCYyXUVaTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k4od1Lg0fmN4QIRhx1W11JuSgMXGpSslPKUSgwswVU=;
 b=jNMAcou/lnPXRmEvylmW2WHcpIlybTaIggZd7+/sYeJWYDE95LBwRWwl9G2qzSQYFA2jGmQDqxoeYpy5qHqYJ6qeBAjyduSqhKSz9yymQVBgG7EujZYE/NcTMLhqHdEnZszdXRhiKS1hX29vSlW1FbbKBW0OvrIP2PRBKjKFvNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 20:45:24 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 20:45:24 +0000
Message-ID: <2c3e2a70-7a78-4b80-a2fd-eaf609c2afea@amd.com>
Date: Tue, 16 Jul 2024 15:45:19 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 13/20] x86/resctrl: Add the interface to assign
 hardware counter
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <add3032b43cd06b538f57249fe0b80a9b5e5fda5.1720043311.git.babu.moger@amd.com>
 <3f93f294-5d13-4805-9954-07c93845e836@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <3f93f294-5d13-4805-9954-07c93845e836@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0030.namprd11.prod.outlook.com
 (2603:10b6:806:6e::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b153185-7ac4-488b-804b-08dca5d83744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXlPcUcwVDZiTVVUTnN4U1BMSE1UY3NEeVF3U2lnRUJCWHhnYmRnT29Fd29T?=
 =?utf-8?B?VGdCRnBDQ09aS3Y2cFRSZFNxaWh0NW10eDA1ZFVXUHE1OGdXQkNQeEUzUExX?=
 =?utf-8?B?SG5RckdkU0tvNjQ5Yy9UT1NNczJGVUdabW1rcEx3ZG5PWFNRandoK2NUUkNo?=
 =?utf-8?B?ZVNhL2U5cXpMZVVudlkyTkYrcy9nZ0V2VldobStTdDNqY3lkemQyWWQ0eGtH?=
 =?utf-8?B?TndLYjlsekIxRit3d09KZHE2WUZEb2NCWVkrOEFSVzl2bUpvZFhqVlNSRFBn?=
 =?utf-8?B?N282TU40MkNYTFZua0c3c3IyWjE2OXlZZ3ZyL1BzNG1uT2w1NUpoSVhuMGR4?=
 =?utf-8?B?RE1vNFhIVjRncGM5WTRUZTJHd0VDMGpYNGNUcm91R0FlVXd5RlNBVEMyVGlM?=
 =?utf-8?B?V3g4Rmlaa0NPQTltbjc1b3dvSkdnblkxV1RCZERrOGNoRFdwY01Md2R3bU5m?=
 =?utf-8?B?NmRBQ2ZHUmxQK3ZtM200eWZzWmhya2hTYi9FeFFsMVlkNmwrUmFDU1dIKzlH?=
 =?utf-8?B?Ry9iM1JYeTZIV05EVEhBaW9XaFZHbVlRcXQ1RU91cHdCTzc2VWxkb3JZOWpw?=
 =?utf-8?B?dXhGaCtQbDJJa2xjVS9XZkE3dHB3bkp0RU5vZ1k5dDcwK1lsOWxWaFZIYmpS?=
 =?utf-8?B?cFhpNFl3bUhtYWVLNmhuSWtMWkhSNkw5NmZIOXlBejNiWWh5a0VHNlUwWWdL?=
 =?utf-8?B?UkN2Y3BxSG5iMXBLQjZhNW9ZVnNQS1FXRCtBMkN6eG5sM3N4eU9xaEFqaDZ6?=
 =?utf-8?B?YWJyWUcrdUpJUnhjQVJDTkFJZVJvY00vSjJ0blJOb2NGUCt6T0l0NXVuQ1Nv?=
 =?utf-8?B?OFVKYVAxMkNnc1BxU0Y1SFBxWThFcHZwYkdMR3JISzlYY0JkWExuaTQ2amFM?=
 =?utf-8?B?alZ3ay9WQklKL3FFQVBFNmZBakZDenNaOXFXRDMrQ2hRK1BDcmI5VlpzME0w?=
 =?utf-8?B?ancyOXN0M2xPK1hwWHA2SjRYV3c2V25YQjVPUmFUeUhmM0J1NXZGc1F0b2VX?=
 =?utf-8?B?Z281V3dYSVRJZVhwYWkrL2IvdHR0UUJHaHMrNDVGQzZhTGFmVWJ3a3BmWksr?=
 =?utf-8?B?V2NlRkFiWUpMSEZZVXN4Z1VsMHZCL3FKbmRNYjhPTDBzN1UxaE5SUnNXWVBZ?=
 =?utf-8?B?a1c5cjhyZXpiYlZaNjhPbDZZa3dLaWZqeFVualV4bDcxM1BkQmpEK2U1NlpD?=
 =?utf-8?B?aEJMd25YMFBoWXhTZ1dybG8vUzZhemkwNkFnOUk3dkp4emxuVkIza2dnc01U?=
 =?utf-8?B?ZkNIRVU3WWxuQ1VibXJYRVc3TWZvOHpoTkhjczI3UTExSjZESEtGcTJOc0JR?=
 =?utf-8?B?R1VzUVpXSzVIOVVzYkJaOGgrZ2NZenhwQzhzNlRrbE9LRWJkdUEwNTdDK2hL?=
 =?utf-8?B?dVBJMURLS1pnbXZlL2VjWVFsRktLaStXSXlHRXFGdXpQQlhLaWtGM3kvL0kw?=
 =?utf-8?B?Wm1KSWdlL3hOMXE2b3hTUVRDY25OWnBMYmptMnpIRUVPeHpWYS9uRmp3eXBi?=
 =?utf-8?B?dmJvNGFFVnN0U011aDF4OGNkNFFBSWowK0FpRWJtTjVGYTFZenl5R3JiSkNo?=
 =?utf-8?B?b25lSXQ2R2w5czdBdDdWQUhFeWFBNUlyOXd3eGFralpuUmpINGVpQXRkL3ZZ?=
 =?utf-8?B?MkhBSFpLbFhSMHVLbFZpT0NPNk83NklqNWFwa1MwVTFacERaSG9Sdkpka1Zz?=
 =?utf-8?B?cGtLV1MwTWJYZzFLcUhWYXllZlR4OWFlSzVBSVJ5ZUxiaFhrTGFwN3Rtc0JL?=
 =?utf-8?Q?54OKNg0JAWC6QTLDok=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cktxNFVzdWNCMnhHRWtOQXAxT3FZY0RRYkJ5ZVRCUlFaazFxZnVod1ZGUUpU?=
 =?utf-8?B?ZkRsd2VFN3NEaXZtTTBwSFlUSERCV2o2Wmp0bmNaRW5Wb0Z1VE5lSmhpTUVM?=
 =?utf-8?B?U0xjQzFEaGw3ZFMvWStUV2l1cE4wTmNWeURTeEl0SWFsQ09seG1zcStzQXFk?=
 =?utf-8?B?TTdGb3JlZmI3SVlteG40WnhaaWQ4aklNV2kzbWhUZHFSbW1SMWQ3T0dad2hp?=
 =?utf-8?B?R29HSHRiUm9nM21hcnljVkUrenQ0cVVjbXlqQm5NdEVVK2J2ejBjeW9CSmZL?=
 =?utf-8?B?QVhSbE0vWG9iMThsQ0FBZWRiUDVRL1VDczJybHNTTERmTjN4cUNuQW1aS3l3?=
 =?utf-8?B?diszd1AyS1Y3a3RFUXBiWUZyT0MyaDZqN0JuRGhiNFU3OEpjTFVhU3orMDB5?=
 =?utf-8?B?bEgreUEzQXhXSlhvQXVOM3FSeTRha2hlRVVYVHExYVo0dHJ3NDIxOUQ2VkxC?=
 =?utf-8?B?eFVJMzZaWG8rRjR1RzJ0UjhEYWY1bEVwS3ZNTnJXeTJmZG13Q2VxRVNrSGR4?=
 =?utf-8?B?M2xUcThXSXdSU3dDdzgzSnBhNGRNWm1DVExnWXRwbUF0U0UycUpUdmxpOXdT?=
 =?utf-8?B?aTlYRENDQ3ZHY2Fyc095clRIS1FjMXB0bXFUQUdGRUNnb3BVbmZzc3RrcXBC?=
 =?utf-8?B?TU5IZklhaEcveXQxNVFjNzdKSU5RekZ6eWdxZGZ2dytqQURPV3BFQ3NEVUhq?=
 =?utf-8?B?ay9HaVk2Ty9IdkJPMkZMYjR3emtnZVV6ZkYwZUZyenpSZG9DNCs5TWtvZmw0?=
 =?utf-8?B?NlhmQlNtTU9FOXRhVWZtOUYraDVOUUdiYmxjd1ZNc05sZS9sMlF2VVlVVTFp?=
 =?utf-8?B?M1JvNzE1RWxOZFJhaUZYQ1g5ZE5ERG5BSjMycU8wTStVT241Mk1Nd3lhVEZh?=
 =?utf-8?B?SWt5ZXhRVW00alhwbm5ITXY2c2s2cUc1WGR0VEpCZDRJc2dWZThyRzZLeG9i?=
 =?utf-8?B?N2xsNkRnbENJenpVaVBkbUxWSTRoZG1uRXlLOHFLZEEvLy90TFB4b1g5NXBJ?=
 =?utf-8?B?MmxLZmVKRnhqZEhrZ01tRys3OW5vWUFqYlliMWJyUmthMmYwVXlJYTFMVFdX?=
 =?utf-8?B?cExaaTJYZkpIdGVNb1pyVnhmdnNEeElRYWJHMWpnNFF2NGVjTWtWd2ZoZm5T?=
 =?utf-8?B?VWcyWGpCOWo4YXA3VmdhTDZRdjRBMHRlRUJKZXROR2Q0b05DdUlpMTYyL0hK?=
 =?utf-8?B?OGJmWkRPUzRKaXMzc3IyWFFYR3p3L0VRaVliMDFhemc5Rkp5cWtqZmlhVmxq?=
 =?utf-8?B?SlhLV1FTTUcvdXZEL2pMSWZtYnFyS2p6aTZ2TXh3VHR1NFo3QmVFeTN5b1gx?=
 =?utf-8?B?RUpWTnF1K2JtVVlZdUhsd0FkN3VhT2h3cmh2NnlxZmZRRTlFdHZsdGl2U2dR?=
 =?utf-8?B?TCtNTjJHL0lIRW1ObDJDTEJVbUltRnpuWnNWaHZURURHSlRkRXRpTjRoNVpK?=
 =?utf-8?B?U0VkU3hINWZ6NmJrQm93c3BmcWR2cEhvb3pTQ1lBOFp0cTk3VmpMWWh2VWNN?=
 =?utf-8?B?ZUVvdE5xNEVXdWJlTjk4ZkRDZWxrak82MSs4Y3hZYmsrQlNpbEpONHdhcFhw?=
 =?utf-8?B?dnljTU1pcVJ3aWl3NzJRS1FQSjJqVlk3WGRidDd3N3RRMkt3V1YvVHZ4TEJj?=
 =?utf-8?B?MUMzR3JMcW9Hc1VuNENvWFdrVFh0MXFNOGtuUU9lZWVaTTJQQ0ZvWXpVT0Qz?=
 =?utf-8?B?K3BjTllEOHkybi92V0dreHljYUdzWVVkZGMyS1dGaGE0K2c1L2cxRXo0QWdu?=
 =?utf-8?B?YUduOHRDVGRKcVB5aWR0b0pVT2ZSSzU3L1hOZ0xqWHZkejJzZiszSWlYZm01?=
 =?utf-8?B?ZzMzSEtwbUkrRlVObWREUndVVUZRaHFsMWcvcVlTcHF5M1NMOUFEOGdFUkJ2?=
 =?utf-8?B?cW9BaFJhZ3BudVc2ajNtaVlYU0JMU1djdk5qbFVWVGNoWFhJZGR1LzJMTmlk?=
 =?utf-8?B?YjZROEhKaHUrdmtRcEU4SkpFVE04ZXd3Q1lZN092Q1UyRHQzdGY3YUNkaFgx?=
 =?utf-8?B?WkR3SUprMDMrSmZNYXE2Szczd3prREtsYzVOQmE0eVhyQkZaMUR4VFBqWnE2?=
 =?utf-8?B?cUZCdE42RE5PSGdTbWcydGVPTFRDemM4KzRvSi9paSs5bldDVEQ0V0ZLNXNU?=
 =?utf-8?Q?lc3Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b153185-7ac4-488b-804b-08dca5d83744
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 20:45:23.9980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Cl2+nD/yE5/cmwYzC91dDEJf4detGJoJXqeTenuXARh0WsFZMfViUdbkWsK+4cM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868

Hi Reinette,

On 7/12/24 17:09, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/3/24 2:48 PM, Babu Moger wrote:
>> The ABMC feature provides an option to the user to assign a hardware
>> counter to an RMID and monitor the bandwidth as long as it is assigned.
>> The assigned RMID will be tracked by the hardware until the user unassigns
>> it manually.
>>
>> Individual counters are configured by writing to L3_QOS_ABMC_CFG MSR
>> and specifying the counter id, bandwidth source, and bandwidth types.
>>
>> Provide the interface to assign the counter ids to RMID.
>>
> 
> Again this is a mix of a couple of layers where this single patch
> introduces fs code (mbm_cntr_alloc() and rdtgroup_assign_cntr()) as well
> as architecture specific code (resctrl_arch_assign_cntr() and
> rdtgroup_abmc_cfg()).
> Lumping this all together without any guidance to reader makes this very
> difficult
> to navigate. This work needs to be split into fs and arch parts with
> clear descriptions of how the layers interact.

Agree. We need to separate it. Will do.

> 
>> The feature details are documented in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>      Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable
>> Bandwidth
>>      Monitoring (ABMC).
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> ---
>> v5: Few name changes to match cntr_id.
>>      Changed the function names to
>>      rdtgroup_assign_cntr
>>      resctr_arch_assign_cntr
>>      More comments on commit log.
>>      Added function summary.
>>
>> v4: Commit message update.
>>      User bitmap APIs where applicable.
>>      Changed the interfaces considering MPAM(arm).
>>      Added domain specific assignment.
>>
>> v3: Removed the static from the prototype of rdtgroup_assign_abmc.
>>      The function is not called directly from user anymore. These
>>      changes are related to global assignment interface.
>>
>> v2: Minor text changes in commit message.
>> ---
>>   arch/x86/kernel/cpu/resctrl/internal.h |  3 +
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 96 ++++++++++++++++++++++++++
>>   2 files changed, 99 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 6925c947682d..66460375056c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -708,6 +708,9 @@ void __init resctrl_file_fflags_init(const char
>> *config,
>>                        unsigned long fflags);
>>   void resctrl_arch_mbm_evt_config(struct rdt_hw_mon_domain *hw_dom);
>>   unsigned int mon_event_config_index_get(u32 evtid);
>> +int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, u32 evtid, u32
>> rmid,
>> +                 u32 cntr_id, u32 closid, bool enable);
>> +int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, u32 evtid);
>>   void rdt_staged_configs_clear(void);
>>   bool closid_allocated(unsigned int closid);
>>   int resctrl_find_cleanest_closid(void);
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index d2663f1345b7..44f6eff42c30 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -202,6 +202,19 @@ static void mbm_cntrs_init(void)
>>       mbm_cntrs_free_map_len = r->mon.num_mbm_cntrs;
>>   }
>>   +static int mbm_cntr_alloc(void)
>> +{
>> +    u32 cntr_id = find_first_bit(&mbm_cntrs_free_map,
>> +                     mbm_cntrs_free_map_len);
>> +
>> +    if (cntr_id >= mbm_cntrs_free_map_len)
>> +        return -ENOSPC;
>> +
>> +    __clear_bit(cntr_id, &mbm_cntrs_free_map);
>> +
>> +    return cntr_id;
>> +}
>> +
>>   /**
>>    * rdtgroup_mode_by_closid - Return mode of resource group with closid
>>    * @closid: closid if the resource group
>> @@ -1860,6 +1873,89 @@ static ssize_t
>> mbm_local_bytes_config_write(struct kernfs_open_file *of,
>>       return ret ?: nbytes;
>>   }
>>   +static void rdtgroup_abmc_cfg(void *info)
>> +{
>> +    u64 *msrval = info;
>> +
>> +    wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
>> +}
>> +
>> +/*
>> + * Send an IPI to the domain to assign the counter id to RMID.
>> + */
>> +int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, u32 evtid, u32
>> rmid,
> 
> u32 evtid -> enum resctrl_event_id evtid

Sure.

> 
>> +                 u32 cntr_id, u32 closid, bool enable)
>> +{
>> +    struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>> +    union l3_qos_abmc_cfg abmc_cfg = { 0 };
>> +    struct arch_mbm_state *arch_mbm;
>> +
>> +    abmc_cfg.split.cfg_en = 1;
>> +    abmc_cfg.split.cntr_en = enable ? 1 : 0;
>> +    abmc_cfg.split.cntr_id = cntr_id;
>> +    abmc_cfg.split.bw_src = rmid;
>> +
>> +    /* Update the event configuration from the domain */
>> +    if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
>> +        abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
>> +        arch_mbm = &hw_dom->arch_mbm_total[rmid];
>> +    } else {
>> +        abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
>> +        arch_mbm = &hw_dom->arch_mbm_local[rmid];
>> +    }
>> +
>> +    smp_call_function_any(&d->hdr.cpu_mask, rdtgroup_abmc_cfg,
>> &abmc_cfg, 1);
>> +
>> +    /*
>> +     * Reset the architectural state so that reading of hardware
>> +     * counter is not considered as an overflow in next update.
>> +     */
>> +    if (arch_mbm)
>> +        memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
>> +
>> +    return 0;
>> +}
>> +
>> +/*
>> + * Assign a hardware counter id to the group. Allocate a new counter id
>> + * if the event is unassigned.
>> + */
>> +int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, u32 evtid)
> 
> u32 evtid -> enum resctrl_event_id evtid

Sure.

> 
>> +{
>> +    struct rdt_resource *r =
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +    int cntr_id = 0, index;
>> +    struct rdt_mon_domain *d;
> 
> reverse fir

Sure.

> 
>> +
>> +    index = mon_event_config_index_get(evtid);
>> +    if (index == INVALID_CONFIG_INDEX) {
>> +        rdt_last_cmd_puts("Invalid event id\n");
> 
> This is a kernel bug and can be a WARN (once) instead. No need to message
> user space.

Sure.

> 
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* Nothing to do if event has been assigned already */
>> +    if (rdtgrp->mon.cntr_id[index] != MON_CNTR_UNSET) {
>> +        rdt_last_cmd_puts("ABMC counter is assigned already\n");
>> +        return 0;
>> +    }
>> +
>> +    /*
>> +     * Allocate a new counter id and update domains
>> +     */
>> +    cntr_id = mbm_cntr_alloc();
>> +    if (cntr_id < 0) {
>> +        rdt_last_cmd_puts("Out of ABMC counters\n");
>> +        return -ENOSPC;
>> +    }
>> +
>> +    rdtgrp->mon.cntr_id[index] = cntr_id;
>> +
>> +    list_for_each_entry(d, &r->mon_domains, hdr.list)
>> +        resctrl_arch_assign_cntr(d, evtid, rdtgrp->mon.rmid,
>> +                     cntr_id, rdtgrp->closid, 1);
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

