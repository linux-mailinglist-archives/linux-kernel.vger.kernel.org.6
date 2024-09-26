Return-Path: <linux-kernel+bounces-340973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195E09879B0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85DF21C209AD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B5B17799F;
	Thu, 26 Sep 2024 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QVzwKtuS"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D72916A959;
	Thu, 26 Sep 2024 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727379596; cv=fail; b=mWXUtGgtwB4PLLwC8MAFaHBVdj6gLVy9IkajTYF8z3EVNzXKjcNT/xvFeXzOVc7tBkZiv/nH2rHB/BcZHW+KQUA1tgHNL7J06Iz3Lw1NsXhpkJBGoGtj0fDa1zu6FyIlqFy7RjCn6mvYzT5lb7M6zl7Ao3GmR7B6qPVG4PCoJ6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727379596; c=relaxed/simple;
	bh=In2MD2mE9tlS0TWXtBRfVtqE5zh1m6b1mBnJ+22SbJE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ObgMEEPrLGHqS82OS7boaUSIEYIsE054z2TlSgxtvenYvSy3kDYNEzfGi/FkE6UZZa+RWsKRmD6PLkGvP7rdLGv0SBq+UZLQjlvTIXFYzFbADI+psNxji0iwRQV4jWT0p7X0Yp9vbVlLcWbJpGD2fqYq8HS/9lrEJ0IvRQV2l60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QVzwKtuS; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIlcgzD4IaOFKCIsuTLSMiay/G4vLedIoENTr1Zq2QmwfUNihyy0DFi60FFKjufPUhffqPL4PMIS8wZHg99GWLGjPpGOGWMFJciQ4WJvW2MTTI1U19tCPwQv71xqBv8y+zjs2fZyALq0Nj+h61qUbri9HOrpwy4lH4S0zEHvskUFeygcO8KPXpHZuhi0zYoCck5X3yrn8njy1PtX+b+RI7KBp4yCkJ8mDM0PjIniBwA0mz1CQTtKBKSVFOn/R4+ZKYB543vXmE2vO5rlLY+DO7a33+C271LtU0bDv2Ezj/KKHxtns/WM6N2G3XOxCF5/dQ1SR5naD6qiaAuIZT8B+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSx3rIvSSBzhR3+pNWdiyTIQcDITIc/YMOf8xgUa+Go=;
 b=FoXtxkBidEegQht/XSAwyXHrWdGR+BzeJGAQCmxHWYjPiJSlnOIe6sBKwsfVyyPEIfXkm0BE2mI3J+Ne6yCd60cjiaiGUu8PmxlzUqLVxDMCEJtC4RPAckYPF7BLJc3FcsuGR/NFH/Uiwf2dXgcewHTFz/HeVajrdVaPgBM1z/RifJeEnNlJFI4VYXBApJB4wUKp/lxv95UQitu8VC5XAUNiAnAKwskusdljny3GT6UhEtfCoZ9goOHy4Uit92cxSeEDf45B0HQ9h2YQIXKXZYhGfa15WelIVPwJmSykklzrXOaHyIm0lzdxVqlgFXpAKpFr9a2Rd8x2zgn9TOPkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSx3rIvSSBzhR3+pNWdiyTIQcDITIc/YMOf8xgUa+Go=;
 b=QVzwKtuSVBD5jl7c8cUxu94nVwdRyTF05ASl5Y2ORHUPb9Mzas2DGfvpqtFZqsfc6TaonTSHg8/B06Jq64oxnlUigtASy/MQhfrQ8HtEVe5YU6jJ8t/yv0zpxwu6PtKhEFAQguwZSJsL2Ocl8VfT0CtDYoriOUxCJ8xFUz9ZKRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8982.namprd12.prod.outlook.com (2603:10b6:208:481::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 19:39:50 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8005.020; Thu, 26 Sep 2024
 19:39:49 +0000
Message-ID: <773d02ba-64d0-4c03-968e-f303ffefc4dd@amd.com>
Date: Thu, 26 Sep 2024 14:39:45 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 20/24] x86/resctrl: Introduce the interface to switch
 between monitor modes
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <812a04c41c66824a212c2dbd30697fe0cad71523.1725488488.git.babu.moger@amd.com>
 <b84fee44-d52b-45c3-8664-b2215074bea9@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <b84fee44-d52b-45c3-8664-b2215074bea9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:806:28::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c00188-d2f5-493c-bf0a-08dcde62fc1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVFvb3dlaERISXRrSWpkRVBxVE9HbHJrKyt4WTFjK0MxaWl3dWFFL1ZsSzlq?=
 =?utf-8?B?WGZMb2FETEhodGtaNlQ0eDIxM29FQjR6MFArVzBvc3VLRE12TVJxR2N4Rkdy?=
 =?utf-8?B?YnZqcS90T1JSTGIxZVlIcEZzNmJHSm1mMnlzNzQwN3kyOTNmWjl0UkU3SGpS?=
 =?utf-8?B?aWE3WmJuYUZMdThPTDhZdUR2NFVVbFVzdVA4ZjZjeEl2UWM5Nk9MdW9NWlUv?=
 =?utf-8?B?N1VNZUtTb0ZEQ2ZTS1NqdEY1VHc2MGYyODU2MCtWdXkrVEtPd1pFdnA5Q1o0?=
 =?utf-8?B?UFhkQ2NwY2ljcHIyWVNvRDJ3TERxeWJtMWI0Z2VQYkYyeDNWdkRhUi9zMkRP?=
 =?utf-8?B?aEcrMWphL2V5Qk5GMXZYZUxwWnVCMEt2SW94U2xsZWhia3RyTGZIUkZNTWZB?=
 =?utf-8?B?cGhnSmh1UXU4WGpxbTZhT0ZnSkhIOGRNZXFrb0doRndvZDZEM0FMSE80a3hD?=
 =?utf-8?B?STB6enZRYzhFbi9LWTBpdktRYWRrWm5heGtDdWlldHVncFIveWRNRXF5bUph?=
 =?utf-8?B?MjF1eGZUVVVNRjdFd0lFek15ZXVQdXpKbWpBY3pMaXh1WTQzQ3I4Vk5ERkU3?=
 =?utf-8?B?NTNTMm15NXNiR1R5aU5kb0dLSHYzT3VkT3N1ZFpGQTRleUpPL1JZcm1xVmd4?=
 =?utf-8?B?cmlLdmVKNTJkQ3BYMTRsZ1VQQllpKzNzM0gxWVFLZGhSSithTXByeC92YTRD?=
 =?utf-8?B?Q084QzZFNDRxSmh5aVkxaUhuR08yQUNjZUZURDFEK0Rod0p1UTBUOGY4VXhZ?=
 =?utf-8?B?RnI4SWhZR0FhMHo0b3RFTk1pTEZrNkc0UERwekl4VDNMM2k2N1Fzd3kyS09n?=
 =?utf-8?B?K3ZJSHpDWS82Vnl5eGlueTQyMEN1TnFXQnFQZTRwWWE1bGJLVWxMaXBGVVQz?=
 =?utf-8?B?WlliaVo3ODArcEZYK1k4WU1Tam5LNitPZGFodmlnbTYreXpxWkI1UEpPcjh2?=
 =?utf-8?B?bWh4OU1NYmhsejlrOFd4bFI1M290Nm5leGdHdlZzdDhvUGtIKzlUbVo0VzJp?=
 =?utf-8?B?SGIwREV0SzdNa2IzTXZJMVBLS3pMQXNkbTZPcm9wRUNoNkl1Q1VsVm4vc3dw?=
 =?utf-8?B?QXNMQVd5OGxmS1Jsem80RWUxcVhOaEQrbG1NSkk4SUs1aGRhYTRndlE1REIr?=
 =?utf-8?B?RUlLZHVybWVKZTNkSVlUc3ltcEN1YWRndVdDM2JTb0J0azgvTGVvRHcvTEtj?=
 =?utf-8?B?WENTQkhFTlBCY2FmeXFORHVrY2xtcjZxSGlxaVZhQmd0UmlqaGh2dUh0dkFT?=
 =?utf-8?B?emtjNnAzY2U3YUkzeldNZktPTmI0VmpzWVhpV0ZUVXZsY2hhMWcvZzI4dWwz?=
 =?utf-8?B?VEkwTUpTWlNRcnBrVW1iWFRkN3A1Zys5V2ZVZ3hiODlwUUc2V3VhNWZ6ME5Y?=
 =?utf-8?B?QnZlamFLNUZTL2ZUZW9Ub3J6Q0JXWmhDSzFlbTY5UW5IQis4ZHdtdWc2YzZG?=
 =?utf-8?B?dmlzekt3eGVnZzdXRDhiY2RUUFRIY2FKb2lZYzdCUFJEVGp5NjRCYXgyMm9q?=
 =?utf-8?B?dGY5VDViaVhCRzlxOE9McDR3dnJyY0IwMUZFUUt1SWFXYWtzUVJod1ZoWWFw?=
 =?utf-8?B?WC9sd0krTDkrQUJPekpockxQQXJUdzIzRWUwUHBVV2l0TncyZitOd0cyZFdk?=
 =?utf-8?B?dTdJQmZhNnFIWGRKVHA4U0VRWWtWeXRkYlowYzk3cEFQOFA2R3REd3NORnd3?=
 =?utf-8?B?d25xa0dWSndnbGEzUFh3WVIwVUV2WWdKL01uMHI1elZxNGErNlZjbWFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDV6ME5BVVlOUTFIMS9reXAvckdJSmJkbUNXck9zcHNWNS9qVVBmSEFMOTJo?=
 =?utf-8?B?OGFNUC92Vm16OVlqV3lxaDZSRXJ5bVlPQlI5dnQ5Y3NGRjJ3bUdjR1RQN1RY?=
 =?utf-8?B?ZGRqMFhFMlpBREpFZUlmbVlMQ05GRmE5Q1U0dXlYeitSYVFrY0s1VGQwNmdJ?=
 =?utf-8?B?SXYrRzQySkRJUHpvQURKeHJxZEZITEZ4WHo3NU8xWlVvZllXdk9DTHp5Q3hC?=
 =?utf-8?B?QVo2dmRrU0l0VVd1VXpZQndiWC9sdW5jWXRnd1RSK28zZlVVRC9kSCtiVDdD?=
 =?utf-8?B?TERla3EvZWJDSmFycXpxTGFaSG9BK1V3SWpQWE9oU0lTa2ptQUxPL091bTlV?=
 =?utf-8?B?Z2ZkWVZjV0svUXhjTkJMdFNveVZXRUtQdlJ1eE1yR0lDTThGZTNWWWpSZ0Fi?=
 =?utf-8?B?SnI3aXpQcFVHdEFLeHBSekgycm1aY3hqOGZKTGw1Z2JVV2NKS2VhbkRidnBG?=
 =?utf-8?B?azRmVHFlVzJBSVM4TEpMeVBRUG5lYVRpN1NnV252OUxxZ2ZGTVRlRDQ5OGRp?=
 =?utf-8?B?NHNudndYdlNuY1dzY0FFVHFLTzhPcXplYzJGaXZTWE9WbFREMlZFOWc5MGRa?=
 =?utf-8?B?T0Y0bHdWTDhnUlh6WS9uSHJFQTd2UDZLY3JCZHBtTXVPemgxNnBBS1NWZWJx?=
 =?utf-8?B?R1lxejFuaHlXSGFyaUxINzRqeHBVU0NoK0t4aFIzTWU1c2JZYW1YUHFZcElE?=
 =?utf-8?B?TEdSZFEyeFdNbWczZmUrVm1wR2VKRkxVbHlCMEVYeWlrc09zQ2NIS0xPTlRq?=
 =?utf-8?B?YVJLcXp4RHNDRUxnV05qYnJrM3cxYWowU09TRFdTRzFTOTQ5cU01K1J2KzIr?=
 =?utf-8?B?djR0OXBVNUF5b0k3Z0h6VW9OUTVHc3p2VkZxSmxoRi9PK3MxY05qZlV0bmth?=
 =?utf-8?B?MEluZSt2RTR0SE9yY2UzRDFjRmFrOEthNW55R0xjWHI5L3dzczFjYkkzR1Bz?=
 =?utf-8?B?bGVDM1U3eTVlUzB0cUhwMWFKT09PUUlnamFtQnl3TjBiZGlMK0pCRWg0ZElG?=
 =?utf-8?B?VUx5UkxydjhFTnBpUW1SaHRGWGp0RjNaUzQyb1czRlBBa29jYjRmbU55SnJs?=
 =?utf-8?B?WHhxdW10cFZtUjU5S2lZWTZxbG9ZdzJBZUhvOWVsTTVMT1R0NmN2K215Yjgw?=
 =?utf-8?B?aWxCa09IQ29BeEtVZHlaaUwwc01NaEhUV3BYcVBPWkgzdDA2cVN0d01LbSt3?=
 =?utf-8?B?MFpReTRNZ1dsdXNzMGNXa2Q4VGVrblNPRUlvSFpHeXh1QlpBN1pTdG13TG5Z?=
 =?utf-8?B?WHVNcUlZUWFEUHN3WGdEc0FQVUw0NTVLdC81TzJ4UDJrVnFacHhkNUZkTUMy?=
 =?utf-8?B?ZTg5dEJyTG5aOEZkWjNhSnYwTFpWcEVwZ2VadWdaYkJZM3ZBZmJneE5GdW1w?=
 =?utf-8?B?S0JSZFh6YTE0VDRrQ09xUTVyYlExVDJzWEdJMHRZL0J1UGZvSVgvUFA5RjRx?=
 =?utf-8?B?T0VaY1Z3WUV5Smhkemg3TG5XU21DZkEra3l2eG1OVXc4bStncEs3VUVFNEhP?=
 =?utf-8?B?TGN5dVRSSWJuRk1XNUFIMzZqcTYvVDIybVdMQklGaWpHTXlZUXhDaEYxTVZL?=
 =?utf-8?B?RlQzV1Z0NHZBL0wzL2lQTGhMU2laTnlFMEhHeTZoVTNvT3VxaW5TemVGT2hy?=
 =?utf-8?B?SHNJUlhjUVZsOVZJU1VwL1Q2bE8zTnZnNHZDRFYxNWJiRHkzRXBzTERJSEpR?=
 =?utf-8?B?c3g2YlVqVXBCNzNweWhjWGplV3d4WFk4OTdOb3pRVkdzZ2hRckhmNllMb2NU?=
 =?utf-8?B?TjZYS0lkL3FjQnM0cjU3Q2ZzZXVUL1NuREpEYmRJWloyMnphYVUrU0hleUZD?=
 =?utf-8?B?K2FTc1RNSkk0NzFjTDhuWDlSMEtvWlhoTFNHZkRjVGhLOTZCeEhaTEFCNmk0?=
 =?utf-8?B?RkNFaFZrSWt6TkxFVUxHRGZRSDhUNXB3akk4T09LNHJPaFFuc0FJdWJRN1ps?=
 =?utf-8?B?Q0dLK0NaMG1iUWVlM3Vuc0dYTFIyNXlGa0ZGOHVVYkxSQVJqMWpFL2hKUTg0?=
 =?utf-8?B?R3ZMaVo3RUZicm93dm0yc0tWWVpmTDQ3N0RmNlNyVlVmcTBFM2ppQi9YaHlL?=
 =?utf-8?B?RjF0dm94Q3N4MGljUDE2SFdvNnB6TzRZS2ZDdG9uYUdEbmhxN1lVbDF6aWlK?=
 =?utf-8?Q?W0nQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c00188-d2f5-493c-bf0a-08dcde62fc1f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 19:39:49.9258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ci0LemXzOVtg4RT9AYRjdxE5GtNfY7ihluXYfe2iKNuqHluIu7aumds9J0INV2E5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8982

Hi Reinette,

On 9/19/24 12:38, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> Introduce interface to switch between mbm_cntr_assign and default modes.
>>
>> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> [mbm_cntr_assign]
>> default
>>
>> To enable the "mbm_cntr_assign" mode:
>> $ echo "mbm_cntr_assign" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>
>> To enable the default monitoring mode:
>> $ echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>
>> MBM event counters will reset when mbm_assign_mode is changed.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v7: Changed the interface name to mbm_assign_mode.
>>     Removed the references of ABMC.
>>     Added the changes to reset global and domain bitmaps.
>>     Added the changes to reset rmid.
>>
>> v6: Changed the mode name to mbm_cntr_assign.
>>     Moved all the FS related code here.
>>     Added changes to reset mbm_cntr_map and resctrl group counters.
>> ""
>> v5: Change log and mode description text correction.
>>
>> v4: Minor commit text changes. Keep the default to ABMC when supported.
>>     Fixed comments to reflect changed interface "mbm_mode".
>>
>> v3: New patch to address the review comments from upstream.
>> ---
>>  Documentation/arch/x86/resctrl.rst     | 15 ++++++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 74 +++++++++++++++++++++++++-
>>  2 files changed, 88 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index ff5397d19704..743c0b64a330 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -290,6 +290,21 @@ with the following files:
>>  	than 'num_mbm_cntrs' to be created. Reading the mbm files may report 'Unavailable'
>>  	if there is no hardware resource assigned.
>>  
>> +	* To enable ABMC feature:
> 
> The separation between fs and arch did not make it to this patch?

My bad. Will change the text.

> 
>> +	  ::
>> +
>> +	    # echo  "mbm_cntr_assign" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> +
>> +	* To enable the legacy monitoring feature:
> 
> "legacy" -> "default"?

Sure.

> 
>> +	  ::
>> +
>> +	    # echo  "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> +
>> +	The MBM event counters will reset when mbm_assign_mode is changed. Moving to
> 
> "will reset" -> "may reset"? Please also be clear on what is meant with "MBM event counter".

It "will reset".

> Note that "counter" has a very specific meaning in this work and after considering that
> it is not clear if "MBM event counter will reset" means that the counters are no longer
> assigned or if it means that the counts associated with events will be reset.

How about

"The MBM event counters(mbm_total_bytes and mbm_local_bytes) associated
with the event will reset when mbm_assign_mode is changed."

> 
>> +	mbm_cntr_assign will require users to assign the counters to the events to
>> +	read the events. Otherwise, the MBM event counters will return "Unassigned"
>> +	when read.
>> +
>>  "num_mbm_cntrs":
>>  	The number of monitoring counters available for assignment.
>>  
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index bf94e4e05540..7a8ece12d7da 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -895,6 +895,77 @@ static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
>>  	return 0;
>>  }
>>  
>> +static void rdtgroup_mbm_cntr_reset(struct rdt_resource *r)
> 
> It is not clear why this has "rdtgroup" prefix since it is not specific to
> a resource group but a global action that resets all counters.

Sure. Will remote prefix.

> 
>> +{
>> +	struct rdtgroup *prgrp, *crgrp;
>> +	struct rdt_mon_domain *dom;
>> +
>> +	/*
>> +	 * Hardware counters will reset after switching the monitor mode.
>> +	 * Reset the architectural state so that reading of hardware
>> +	 * counter is not considered as an overflow in the next update.
>> +	 * Also reset the domain counter bitmap.
>> +	 */
>> +	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>> +		bitmap_zero(dom->mbm_cntr_map, r->mon.num_mbm_cntrs);
>> +		resctrl_arch_reset_rmid_all(r, dom);
>> +	}
>> +
>> +	/* Reset global MBM counter map */
>> +	bitmap_fill(r->mon.mbm_cntr_free_map, r->mon.num_mbm_cntrs);
>> +
>> +	/* Reset the cntr_id's for all the monitor groups */
>> +	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
>> +		prgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
>> +		prgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
>> +		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list,
>> +				    mon.crdtgrp_list) {
>> +			crgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
>> +			crgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
>> +		}
>> +	}
>> +}
>> +
>> +static ssize_t rdtgroup_mbm_assign_mode_write(struct kernfs_open_file *of,
>> +					      char *buf, size_t nbytes, loff_t off)
>> +{
>> +	struct rdt_resource *r = of->kn->parent->priv;
>> +	int ret = 0;
>> +	bool enable;
>> +
>> +	/* Valid input requires a trailing newline */
>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>> +		return -EINVAL;
>> +
>> +	buf[nbytes - 1] = '\0';
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	rdt_last_cmd_clear();
>> +
>> +	if (!strcmp(buf, "default")) {
>> +		enable = 0;
>> +	} else if (!strcmp(buf, "mbm_cntr_assign")) {
>> +		enable = 1;
>> +	} else {
>> +		ret = -EINVAL;
>> +		rdt_last_cmd_puts("Unsupported assign mode\n");
>> +		goto write_exit;
>> +	}
>> +
>> +	if (enable != resctrl_arch_mbm_cntr_assign_enabled(r)) {
>> +		rdtgroup_mbm_cntr_reset(r);
> 
> Should this reset not happen only after the hardware state was changed
> successfully? If the arch change failed then this may lead to inconsistent
> state.

Sure. Will move after the mode is changed.

> 
>> +		ret = resctrl_arch_mbm_cntr_assign_set(r, enable);
>> +	}
>> +
>> +write_exit:
>> +	mutex_unlock(&rdtgroup_mutex);
>> +	cpus_read_unlock();
>> +
>> +	return ret ?: nbytes;
>> +}
>> +
>>  static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
>>  				       struct seq_file *s, void *v)
>>  {
>> @@ -2107,9 +2178,10 @@ static struct rftype res_common_files[] = {
>>  	},
>>  	{
>>  		.name		= "mbm_assign_mode",
>> -		.mode		= 0444,
>> +		.mode		= 0644,
>>  		.kf_ops		= &rdtgroup_kf_single_ops,
>>  		.seq_show	= rdtgroup_mbm_assign_mode_show,
>> +		.write		= rdtgroup_mbm_assign_mode_write,
>>  		.fflags		= RFTYPE_MON_INFO,
>>  	},
>>  	{
> 
> Reinette
> 

-- 
Thanks
Babu Moger

