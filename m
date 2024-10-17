Return-Path: <linux-kernel+bounces-370711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9759A311E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5226283098
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72151DFDAC;
	Thu, 17 Oct 2024 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EDcbqjBD"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB651D433B;
	Thu, 17 Oct 2024 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729206132; cv=fail; b=YkS3rqRAhVgz4x21yeitqPTs0LAAv21+jIjtmwPZKq8CyBd9WAL+Bhdd8i2y6kdSViZbxp7gjp1PqgN5IuX78Baiyi9oo6DzJH99g+gqxkZqY3oPVgkhoohGPclPA8QHqEjfVh6L2UVDg3hJBOR297jcpLmf8Mu9DE/WnQFDMV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729206132; c=relaxed/simple;
	bh=vZ8SU/91yNCHrks7agWpu+B2zkpwVCNbUpvxAtOv488=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nGP7pi/reGFqgLdeVYtJ3dZE2iBqZGsNC7FfDQppVFch8zAzJRldP7M+AJ1VNrbwfRokKUk3BpSWZawkm79KOVClkiatcp+3IEZ0orc0u+8HNi2EniePC0Wv+xFczVnAVjlAo1/8zrwiIAXuSq9aZTOCne3xHFPUBuSRPQ+G1PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EDcbqjBD; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7uoulnyMNYdnHWTufqKEqSkpbHEeF75Uuw5Y0jYVhOtYPZPTJxaEfs3GfDR4Mt9JOFS+oHw/DSe9QjBAn4F4HIPgf+hT77BubqpTgQVNMYFLkPhphDfCqpIkfeZtd9ONDuwCu9KSCkrSOL40xN4phCHw9TqNB4eIzf7FNQyjpO+xHJWXLxFQl74O94c993iMXoYeXswppV9aEFuiuPVbP6pwqo+ChdLByQJDW83IqyQallLxkiHnSP76exHh0x6t3oiaw/dYXK+Un0ro/BGUixOmBePT4Of4lTvAG1pa9QuqbDl1lwsx3XqmOi4PicKutKklKpuo1smblvwdSiD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vjG73juDU88ZJHDbrlUD8JB7/9sBntvkpJVKBhLVcY=;
 b=m7qh2mUQB7YO1svNONtmPr5nPMi4k+TrTub7dq+SuUjYzXxz1sfx32lJdR/pie/xqgMlEWsoOj7WSt+vByontFJswmuTwtLmjUeFspBcq8Vj+YQYuu5/lCr8sadOwDBkiOU2ONNxwJmFB/srduvv8IMpmI4gcLgKOk6cMiJ2vUiqfTUYxXxSAF+zp1hyuqexghzUXtB+zXc0atst7+n8qQ3DAb7jDupPayqY+IHM1cHmtk2iDLenj2J+3Bh3cE0mqgWupBVv/vtEh750iDSal8Xc2XPkDHUC6HEeLLDf9Vki48nqXGadVeUG5z8eWOtkEmnUFF1hdNmS29dzSbmIBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vjG73juDU88ZJHDbrlUD8JB7/9sBntvkpJVKBhLVcY=;
 b=EDcbqjBDEqn8k9KHYCWVwzJ70hkIM9ZUJR7GQ0D/7kEeeQPLZtkOeZM6nnqYmMeZ5gQBmL2Mr16fcB0uOI5U29rY0ZeMo+l7MX1WVOoTcx/sUovOzX9jrGy3GELUqDUl/Axvu8ftFKCxTTycx961OdH+zHXg4Zzeb3DKf6GrB34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 23:02:07 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 23:02:07 +0000
Message-ID: <5aa05154-82ae-ed0b-18da-7582dd6ed2a4@amd.com>
Date: Thu, 17 Oct 2024 18:02:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: "Moger, Babu" <bmoger@amd.com>
Subject: Re: [PATCH v8 14/25] x86/resctrl: Add data structures and definitions
 for ABMC assignment
Reply-To: babu.moger@amd.com
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1728495588.git.babu.moger@amd.com>
 <94cfd19bf9b16570b07649e1058b4ee55ac8c102.1728495588.git.babu.moger@amd.com>
 <6af4b2f8-c6f4-4195-8c5e-d2efe0384521@intel.com>
 <c81c9b9d-9897-4f97-9d41-37a9fbfcfd7e@amd.com>
 <e1bcfe33-98d3-4685-be40-162779863dfe@intel.com>
Content-Language: en-US
In-Reply-To: <e1bcfe33-98d3-4685-be40-162779863dfe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:208:fc::41) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c8a537-5538-4f70-14ea-08dceeffb931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mlg0VjFId3dLclpYLzJzdTV4ZHZPY1VmdWZ6Y21BaFgvYWpXWUxjZVJpb2ll?=
 =?utf-8?B?YWNIQ3Z3VTBHbmR3NlpwMnRFRGZJbDVxOHR0aVlwVy9mVzBqOEFrbjc4N0Jh?=
 =?utf-8?B?cGJ1eHJWOXZFN2ttbGZBODBDZXUzdWF4Yy9zc0ZrYzg1UURGbFVITWpnK3gz?=
 =?utf-8?B?VHpuQmhodkdvYlQ3UUh5T0NERTJvUGJBUWtJTVQzMkhBM2QxWjVDWXE4bkRR?=
 =?utf-8?B?ME11TEFmTTk3aUNHMWV5R01ZK3RralNKajhXYXVlVzhMNGx3azJlTkFKeFEx?=
 =?utf-8?B?SHRFVFkrRzJYbHNWNnBHVDJwLzBnRVJaSVEySHAwdFkxR3lGMis0aXBqelpN?=
 =?utf-8?B?dzdwS05RTDZHVGlRdFpSTGdRcnhLK2FYRGJkKzZyUnphL2F2eUhYK1lJME40?=
 =?utf-8?B?WkJBdVZsRCtkaEFTaHJITkFPWUdNTXJNUWROK3gzd3BnN2UydjA5Z29YcU8y?=
 =?utf-8?B?c2IrSnZCK3piZjRZMGVMck8xYWxxYVBrMFVjWlI5Z1h2WG9jOFRSd1pCSUNn?=
 =?utf-8?B?bUNzdjFUdHFLVitOazlyWExIMWRXMWc4eE8wTjNTUHhNNDhPdlpCeGJVa2VN?=
 =?utf-8?B?N0Zldml0VVdxclZPeTh3TGtNV3hTUXdienB2czMxUS9wKzdLbmgzYzBHempG?=
 =?utf-8?B?ZDJ1OG8yRE5OYjNXMVRSWk5qWDhhVFVSYVVtUUJxNzlkMVBJRU1VUGxrUEhI?=
 =?utf-8?B?a0N0T2V6L1NZVVZ4aUpYVHJDdks0cGZoR0k1U2sxMVJzSlN1ZG5VcjlvRFhp?=
 =?utf-8?B?UnNsenMwbTZ1RXFlNENGUXA3VDFiem1JbVk5WlhMVnVVNjd5NjRSdWt3WkJt?=
 =?utf-8?B?Q2pMbEdjdUI0MSsyK1dXV211UkcwblpqOW1LamJHRVR4K1Z2c0ZxK1ZTWE0y?=
 =?utf-8?B?NVM2OE1sL0g3SjZuZFVRSmtuQ3ExL2hiZTh1MUlrQUkxRFVYeThKb2w3RHky?=
 =?utf-8?B?ZDNBY25MYXpkZnpnTHIrNkc5TGpCRGZrUWtkL0xUR1d2VFNiOGxmWUdjOENv?=
 =?utf-8?B?VjBQZW5TbWdDZjluVHV0YmtRZFBvU3gwditTeVk5aGhjVHZzY3dQSkZDb3Za?=
 =?utf-8?B?WnUzY0twZmNtbG9rbVRmK1FMdk5NeWpKb0c3bmFldEpDbGRKZDQ5c1YzYTY1?=
 =?utf-8?B?ekxhYWlxd1NVS0UzNURXemNRRmNGOTVaZmVmSXUzVkYzWjA4Q2xySTZTeTdz?=
 =?utf-8?B?eW1TY0ZuV09jSVBaYTVUT0l3RDN6SEFnY3k2dG5pam1SazU4aFdJbC9sNHFq?=
 =?utf-8?B?eUNqY3QweGlIQTZBVFpnRm1qTS9PaGpvNGkrYmhVOXkxcG0wTkNCN0Zwcm02?=
 =?utf-8?B?b3R2MWR2akVMZWcyc2dodEovaVN1RkExMGY5OGF1eE1Xd0xDdGVzeXJpZkR0?=
 =?utf-8?B?SFFrMTdSRCtkazNMdmxQMVB3Qmovanplc3lsS1N3d0xFalpXYkRtNXFIL0dV?=
 =?utf-8?B?ZFB2a0ttQ0NXbWFDVU55S05ISTBKUS9HTXZtQXl3Y0pqMk1nQmJJMFRoMitj?=
 =?utf-8?B?dVhyc0hXaWYzNUpseHlpWEVNQ3A0SnVSWm5JVG1xV2FTNExTTEJWUFhJZkUw?=
 =?utf-8?B?NUxHMVd4a29FTmlDcnhnMEJrdi9tYlZXYjF6TG9qWFZzWHFaS3lITWV1QnIv?=
 =?utf-8?B?T3NISm00MXlIV3V0VkV5U2UwKzU3WDFackh5Vm9YakU2d0Y2ZGFNVUxacFg5?=
 =?utf-8?B?endoWGpibUFPa2ltOENZMlJENnh3dDJBazBUQzNrZ2VqeTNzSDRHd2NZYTNq?=
 =?utf-8?Q?T2Kz9NBxwsH0Y//h1pfE8tWTdbR1p3kUCvxlqTO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEg2bnlQc1hHdnllQVA3UEFKSWMwM3hKUmx4M2ttRFo4VGZ0a0RzZTJwNC9R?=
 =?utf-8?B?Qm1Ma0VpeVQwSlE0VFRPeEhhOEQ4T3BLbzVRSllwelUyQXFZWTVZVXI5QVlN?=
 =?utf-8?B?MGNnNlkrdE1BeTdCWHU1aG9WOVc5QTJmRXZlMm4rWmZLWlptdU9TLzBJVGp1?=
 =?utf-8?B?cFN0RHV0djJDN3FnZUxpNjJwRC8rVWdwMlE1RmlEY05OMGRBdzB4NGh6bVFx?=
 =?utf-8?B?by82cy9SSWVKWWlVUGdGYVd5RnNjZy9CeHZqdHhrRk9BQjNiaWZYaUI0ZUVC?=
 =?utf-8?B?N01UTHl1elRBaUdFeFE3alJ3czM4R1RhbnhYaW1FeGhaUU1LanhSSGFmS2FP?=
 =?utf-8?B?TVBvVFVobWZtaFZTMUQzdTYxSmVIZ096RmduV2VHTzJxL0pNeFVoblNGTkFp?=
 =?utf-8?B?UjNacTQ0K1Q4Z3ZRZmFlQkg1SlgwWFdIcXpjdzJ4VDRpTU55TkQ3Z0l4WUtU?=
 =?utf-8?B?cEhCS052bkQ1TENJUzlEdGJEV0VrTHZpOHh0aG5laG5WNkZrOWI2QlVwU1Yy?=
 =?utf-8?B?bm1TOThZUm44cmJ4YzBLMnYzY0gxbnU2MUxJK2JkRDVKMkxudDJMWjdubnQr?=
 =?utf-8?B?RXE5ZmtnN1BZWTU5T21lbk96OTQ4WHBKcTVTaG9VYVNrWUplcExjclpuRE94?=
 =?utf-8?B?YXQvcU1FaVBWemxJRlV2VEpwQWNjUVllbjRlUW5tSlpXTmJUVFpGYmRQYVNz?=
 =?utf-8?B?WlNPallqczFUWThVU3BrYk9kTzdoZmFIWGNpVzUyU3hORS80enJ1VHcyTjVk?=
 =?utf-8?B?TVhFb1FUMStFalVhdFBUUDhvUENDQTRyemN3MjVtRW10SmpidC9uc3l4aVJO?=
 =?utf-8?B?c0RYb0M5bzZBQkVtaHdJTG9KSjVhQWxzTUgwTW1jQWUwVmgvUFBXa2E1QmMx?=
 =?utf-8?B?UklDQ3piOTkrTDVOYUNqYXpJQ0htby9sbENDTEN5ZFdtaWg5WC9rcit0UWtp?=
 =?utf-8?B?OWxZRHl0ZVY3RVpVdGRTTUIyc082YlZvWDkvYlJrdFpVK0JwdWZIVVRSUyti?=
 =?utf-8?B?VXY2alRXVEVtaTFBMnFqTkdCWXR3U0JPL3BnaWVJRHhHbHN3Q1JSdlc2MVUx?=
 =?utf-8?B?aG9OenowcVkydy9OcUtVNjVUeTAya1lOUnU4ZGJBRGduN0lrWXBRdFJuanJ2?=
 =?utf-8?B?bmZsKzVLbGY1ZFdkQzlSOWhLS1plZVV2RGFTL3ZHbTMvYytrN0ptM0xENlRT?=
 =?utf-8?B?S2RNTmdNZGFIV2NhTnNBYnJrUVJvK29naFhrVXlDcFdMcTZNRTE3L2lOTzA2?=
 =?utf-8?B?N2pKMnU0ZmsyUmZQQm45djNRSmhETW0xYnhycjg2TmNTMWlZV0VyNDgza0lk?=
 =?utf-8?B?dlpQbkc4TWNQTXhScTdvZE1HbzBtaUxEb3Rxd2ZYNWZzMnJFdGk5V0dOMndt?=
 =?utf-8?B?R2M4YnFNNHRiWTY3NjRPblpoSnlNWWsvUUQ3MTQxUzFZemNuS0xWbHI3SjJ0?=
 =?utf-8?B?aisyU3FDaXJYOXNwVmIrZnh1WUdHQUhUak16amVsaHJkUmM3NlZvVnh0SzlV?=
 =?utf-8?B?OXZxUEE4QzJGMURHMldPcVM0S3I1WmxycE92TEk0czQ0R0pheHdjQTJ3QzlL?=
 =?utf-8?B?R3MzekJBY0JScmJzVXJuZG5YQjAwV3ZrbmttV0tKT1JSUWdSTTErKzgrY2R6?=
 =?utf-8?B?V0hKOVVBRDdwVFFSQTlRVHV3V1NVRzF2d3RFaTZwNUJPNDdVdEVyZHRLR203?=
 =?utf-8?B?dzR4YlloOVdjVHFjU1hnUHZTRTRvOUZUUCtzNS9URkYrOUExeVZjTG81bVZR?=
 =?utf-8?B?R25Eb3FUZE9FMjhoT2daQ2l1THM0M0x0OFZNRFBNSVpiY1pYWHZ5ejZXU2VY?=
 =?utf-8?B?MWJmVHZRanJ2Vkx6MHhMMGRqbVhVY2gyZG54cXBXNHpCTzF5VDZNVjQ4RWFn?=
 =?utf-8?B?aEVhbjlBQUcvSzNWUDVtemcyZDBvNWNjcXlyR1BBZEF4OFhMWjdpV0daTFFD?=
 =?utf-8?B?UUJsTTRrSk9ndnVqeEZHUnpnQ1l6YWxZbkd1VkxMd3FPUHRyZmJiZyt0UWFM?=
 =?utf-8?B?a2RXMVZBbzY2NldIbUVwUlpJUk1MQ1JIalRpTi9oaU8zVmw2QWtpOTN2cVNK?=
 =?utf-8?B?WDJOMEd2WDVKSE16Y284bWhlOW1PM3NvbXNSRHFJVmdCVDRBZEJqWEpnMjU0?=
 =?utf-8?Q?UjEc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c8a537-5538-4f70-14ea-08dceeffb931
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 23:02:07.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBn1Z81hdL3UxmH9o5nePBp8M+iYZxxRaCLC2tUXXdWKxis/cd2aJDlPvRZYllZD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524

Hi Reinette,

On 10/17/2024 4:13 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/17/24 11:52 AM, Moger, Babu wrote:
>> On 10/15/24 22:21, Reinette Chatre wrote:
>>> On 10/9/24 10:39 AM, Babu Moger wrote:
> 
>>>> + *			  tracked by the @cntr_id.
>>>> + * @bw_src		: Bandwidth source (RMID or CLOSID).
>>>> + * @reserved1		: Reserved.
>>>> + * @is_clos		: @bw_src field is a CLOSID (not an RMID).
>>>> + * @cntr_id		: Counter identifier.
>>>> + * @reserved		: Reserved.
>>>> + * @cntr_en		: Counting enable bit.
>>>> + * @cfg_en		: Configuration enable bit.
>>>> + *
>>>> + * Configuration and counting:
>>>> + * cfg_en=0,            : No configuration changes applied.
>>>
>>> Can this be expanded? (sidenote: It is taking a long time to get clarity on how
>>> to interact with hardware. These incremental cryptic fragments make it difficult
>>> to know how to interact with the hardware.)
>>>
>>> For example, "No configuration changes applied. Counter can be configured across
>>> multiple writes to MSR while @cfg_en=0. Configuration applied when @cfg_en=1."
>>>
>>>> + * cfg_en=1, cntr_en=0  : Configure cntr_id and but no counting the events.
>>>
>>> hmmm ... still the same (""but no counting the events") strange language I
>>> highlighted in V7 ...
>>>
>>> I think it will make things easier to understand if similar language is used
>>> between the descriptions of the different fields.
>>>
>>> "Apply @cntr_id configuration but do not count events."
>>>   
>>>> + * cfg_en=1, cntr_en=1  : Configure cntr_id and start counting the events.
>>>
>>> "Apply @cntr_id configuration and start counting events."
>>>
>>> Can it be added here which of these settings (or combination of settings) result
>>> in counters being reset?
>>
>> Any change in the configuration will reset the counters.
>>
>> Little bit lost here. Let me summarize. How about this?
>>
>> Configuration and counting:
>> Counter can be configured across multiple writes to MSR. Configuration
>> is applied only when @cfg_en = 1. The event counters will reset when any
>> of the configuration is changed.
> 
> Is is not clear to me what is meant with "when any of the configuration is changed".
> Are event counters reset with every write to the MSR, whether @cfg_en is set or
> not? If counters are only reset when @cfg_en is set then I think it should read
> "Counter @cntr_id is reset when the configuration is applied." Note this is

Sure.

> also made specific to be related to *just* the counter being configured, not all
> event counters that "The event counters will reset ..." implies.
> 
>> cfg_en = 1, cntr_en = 0 : Apply @cntr_id configuration but do not count
>> events.
>> cfg_en = 1, cntr_en = 1 : Apply @cntr_id configuration and start counting
>> events.
>>
> 
> Please use the @ prefix when referring to union members.

Ok. Sure.

> 
> Thank you
> 
> Reinette
> 
> 

Thanks
- Babu Moger

