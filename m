Return-Path: <linux-kernel+bounces-294639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A209B95909A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD327B22C22
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9CB1C8235;
	Tue, 20 Aug 2024 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZaJ5EwQ/"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D0F3A8D2;
	Tue, 20 Aug 2024 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724193783; cv=fail; b=cbDAj6htl43uRkPsUb26PQ8Yqlt5FYtJaM4mTUUHVmqZry/a7c9hYAmvDsB3JRyAQhHN1CulVBy0DrlYP5NSBmgZ2mfBH4oTP6ISy5psKUDi5k3m6c4ts1ABmjrbsO/hd7GNl/zM5GrCCSpy0qeXubENO3RYG8wGmh9UVgQnNcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724193783; c=relaxed/simple;
	bh=2lA9Jaa24oGxj6tCYAWg8hZF7PAzjRvMdbXT14z41HY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aiXswZ9AGFpWkv5bj6vF7rytBxevo+xFXUCoVczxj0gAvahx6qUmKO+62lUjZcyAhUMoa6GR/2tXVcjqyKXDs/9m24HJSsMNILF7ObtHsZXnA9cDeXxPTeVzEGYdc0JK79w77Yk2RNRagSACrmFdOTu6eSXhQfvWhzjpV2xwBus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZaJ5EwQ/; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9731X/Jm51rQSIaaNuT5oqoNafGLxu047rMiAaAm2NaHYeA0c+oxlrPP/t5PlAvX+2wR8CMO3QvrT5B8H9iP6SkmanZeUNV+tK3xBSg926VayEh69L5tBaWdwhL5XoIsgKLFZa0nVGqRyKkpKzNs2fvC3QQINIuBhuvt0UdvFKPNVAzV3u3DmCnaop7iNAdSxf4cSWqHvZKdiaFPgIwjgKr0WB86BnLM7c7euurc7yqty9Utt57M0SjjmrenlUByR52rSzILq7DNJNxVn+Phk8TH8utCkP+T69H5e6C+QerM0WLtawrMYsHajJ0+KuO4W4inX2oPIJ30/H/YPkw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifclGqfLXfnkJtPEpgyCpW3Ae+kUFiGSn7qOyeXiVsE=;
 b=vq1jwJIljUkQgeNJMTSzjlZcuNnHCIRxhZwx6FKReDmcu7r6BtGUwnWvO1OzHMDcQRTkjQPc4eQtAONWHEPXui6rrh+IKofQIKfvjzjfuLPQsSWW5EIaOXKKB4IOMC6vMRO1M0T+UyR4gNDsNW5bwl8wgroJJvoJU3Vh5Fqssz3SszNBZlkD5Xk/YArBiqG3gAI+ZpYABwnx6KIBXbQK+lZlAw4/EhzOuweX3jO5/LylBXr04ZhlvXsAK+M6PO8pBV2OBRpRHEfLL0RLTQ9ciBrn/uX13gpW2b2rCyJ+jNNd+GqWUjw8KclHuUiTwJpseE9dxdg/hmJe4RHw/m9/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifclGqfLXfnkJtPEpgyCpW3Ae+kUFiGSn7qOyeXiVsE=;
 b=ZaJ5EwQ/Ksi+1gkw2gWXSIGGSFamVdIu46scK7awf9bYjBjPaseCP5QaQVKsjHTZueAL4DqHgbvJnyWWyD8LkniHXVSscmqlaLamEfPZcBQmkAB6WRaOE4AOMX45J3oqtyTIaTuwnUNTaUlVhP5ljGoHvjw4hcJUXEVeerkcFRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 22:42:58 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 22:42:58 +0000
Message-ID: <d254ceda-7c6a-3e45-5da3-1c95724fc947@amd.com>
Date: Tue, 20 Aug 2024 17:42:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 14/22] x86/resctrl: Introduce cntr_id in mongroup for
 assignments
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <5b8b1f354c2f4b5eda3fc7f2ba0d4d0b3744fb61.1722981659.git.babu.moger@amd.com>
 <34387cbb-4899-4edd-97e0-db66798085d3@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <34387cbb-4899-4edd-97e0-db66798085d3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::9) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3edc8b-514c-48bf-4d2f-08dcc1697067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OU1rWVI5a2dIWEdudFJ6ME83ajZNZFVJdTRnRFgwdCtma1k1akdNMlRnK25q?=
 =?utf-8?B?aUZwb2J1OXlUTUVuL0x6Y3R2bXVlUklZeGVpRUFOT3BKSGtxRWxkV2FnRS9S?=
 =?utf-8?B?NXRZNFNITWVwZ0ZTeGF5eUJxOStuTGxRS3Q2MVowUVZvZTdyVlJWVHF3TFdo?=
 =?utf-8?B?ei9UTTlRNExobXVMejA0dWxuU3JHd0lyeDhHZDczN3dXT1h2M0FWWFVWY3E4?=
 =?utf-8?B?bitMZUtoK1JPWUg2NUJLMEVpK0t4cHJJVEx2aGN3R3dCMlBOQno4aXFwS21J?=
 =?utf-8?B?M3Y3N043RDFSMFNUZEJyMHdPcXFKWjY0VS8vNlNEVlBzWFFYdUlWVlJjWU1q?=
 =?utf-8?B?dXRSMkovUUZZZ2YyL3hNMTZBK1hMNEpmY2x3d2RaZGdzNkVQWTAzVnhGRGUw?=
 =?utf-8?B?ajR6dWEwbVZ1cnZzYkp5cnN5Yk92dVhxUjBwNE1lTUZnaUUrS0NtUUVPMWNP?=
 =?utf-8?B?SXluWC9sMGxpSXlHcGtRenoxTCtvVkVhYjBhcmRwU3A2YVNxb1pDNnhxcFhG?=
 =?utf-8?B?QWVXeHdkd0RwTGhSQU11WEhpYy9JOG5NUGVjcGh4Mk4yd1hUZWozK1gwZmtn?=
 =?utf-8?B?dCtYaVhsQTR3cnlXQnFLalRqUXhGUFZzWkhLM2VwbWw3clpqeFI1UkxUVmFI?=
 =?utf-8?B?d3RpcHE0eDFjeGR4NEN5OWRtUFIrQXRGSkxTQ1ltUFZWVU03ZFFnZFlLNnY1?=
 =?utf-8?B?Y1pXZElkZi9DT0MxemJIaUFRYzBONmxWYlVUZ2lyUUNXbVl3aFlaWlpyeEQ5?=
 =?utf-8?B?U3hiYmJqVEZ2Si9PU1VYR1luSGcvWlFmTy9LNk1LU1dBK2FHYTR4bFE4WGcr?=
 =?utf-8?B?bjVidU9vNzlDRUhJY3ErWTBPRjM5Q0x0aEFzN2FpRlZCdzFkRUlERVpDcTZN?=
 =?utf-8?B?SWtGVVNFWUYya0MxZTl2bWNMalZSZnZpRjNzS25FNlNMdHBLemhtNHg0NUNW?=
 =?utf-8?B?NDRYSC9VR05HSmpCb21tNXJKNmNaU2ZkTVNBS1FJU2tRbE9DdFFBaitlbVE1?=
 =?utf-8?B?N1Z2NWJ2dlRXV3crM1h6bU8xSjdMNkx3MU1rbEE2eVduSFh0eXlKZC9QcDFl?=
 =?utf-8?B?VGNmWTc1aVBKb1F1NnJFazZseG1XNVQyY2FGWCsrWjZMWUNObEd2QUlTQ003?=
 =?utf-8?B?SWdLTlNWUGcyVW1oeGttellZdGZQMVhPSW1LUWNkWnZ1ZGRkcDJPK0hSYXRN?=
 =?utf-8?B?WVQ0TkY0UnRRWkl4Q2pMNFFxVy85ZllDaTEyQjBPUHhFeWl4NVVrNEpESWRO?=
 =?utf-8?B?VzRLTzNuNW9sdkhZZXhuZVhHY0l2cjZZS0JDK2dPbE95M2dLcEszY1BmMGJN?=
 =?utf-8?B?QlowcENqaW9sZktxL1E1SG4xUWJLWEUvR0UycjFIbXlwWkpoUnFGUmE0VHhj?=
 =?utf-8?B?QW12dDNoanA1dUhJQ2FpZDlXYmxML1FSUzFOdnArblQyS2VZZnV6NytRMXYr?=
 =?utf-8?B?dDNFWExobzAyZlVOZTQ4UGhpQXRzMktPalB4Mno0OEJIN09IS3diZlRod3ND?=
 =?utf-8?B?SmpZM0xzRmlJSWF4djJDNW1mN214NkgweFp2NWZMeFJuQ3RBU2pvN3FhaGxh?=
 =?utf-8?B?dnpORGVjK3RIRDhRcFkyKzJmRnFTU2NoNFAyVzk0YkNlMTMwRjcwQytFVktw?=
 =?utf-8?B?WG9jQ0ZGaklyNVgrbSswbHhXMUd4RGVCTno1aHhtRlJtUi85eFN6WUwrc0dS?=
 =?utf-8?B?d2I1WmpoNUFFeGVDeWxxOXlYejl6N2dVRkEwVDArUldRZnRHTDRvenh5d09z?=
 =?utf-8?B?cmFRdFBwcGd2TDFjZC83NU1NM2N1bFZITnk5RlF2MUZyTTVzUG51NkVvekxU?=
 =?utf-8?B?bXRTb0FZR3pxck5VL3g3Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUJoWnJHOWtnV1hDT2llTUkyeXJETjBRK3lpVUVwMkR3YkMvNzBoT3AvR1o0?=
 =?utf-8?B?bWRmYklnbUw4UUVldWRhaTF0cHBpOUlzc01PbGpOVFoxUStTTm5SZ1VFdnZF?=
 =?utf-8?B?T0ZOMG9rd0daL05KRExBTkVobFFOWTFEYWhML0R6SGJwMTBxbFBNMEpQU1Fz?=
 =?utf-8?B?WXZwTWhlMXpRYXJqOFA2M2V0NWpoRnRzSXRpcnZpTzhwM0RxVnk3TXJOaGM5?=
 =?utf-8?B?djZJWDU0aFkxeFhaVjUrTXB2Ry9wNHYxTHZPenZ3Z0o0NWN5N0U3S3dxTzl3?=
 =?utf-8?B?SUIrcmQzL0VhSk5GYjFXemRVVnBzWm11SG15VEtoOVRBWk1WWjFHcjdNbnJj?=
 =?utf-8?B?UDRMNGJxSzc4c1IvQ2t1VEljZldTeWdiOW9tSUNHcFcwbG14bVBrRlJDelh5?=
 =?utf-8?B?aW1KbnQ0NlB6ZWVNMTl1a05NS3h2YzJRZVJPcmI0UmE4c1JmbWhlNUJOU0lH?=
 =?utf-8?B?MUFEWGhvSUNxV1NFY1k1Z0VPWXhJc0hKZ3JwNXlSVWM1QXA3Vmg3ZW9NQTE1?=
 =?utf-8?B?UlhnTC9xTjZpOW9mWHJ4eWszOGpEbDdwQXJOR3poSHVEMjN5eUJuM1g1cTc5?=
 =?utf-8?B?Z2hrY3o5WFBLb09CZW4xdUdtNFFLa1BydzdNTEJMeWpweXB2Tk56bW13dWZa?=
 =?utf-8?B?SXpSM21ZanZadEFzZ1pDNWJ2RElydTB5dDQ0YmNvc0l4U2VMSHJxdTB2VkhI?=
 =?utf-8?B?SkhDZTM3ekM1NmJ2TTZJL3ppTnhHa2w4ZW9ZV2J4aXFySXhEVmM2RTAvaXFw?=
 =?utf-8?B?bm1FaElhQUdXRmdFck5BR1h6T0hOc0NYSXI2dHdtZW1VZm1qQnJsMDNXR2pJ?=
 =?utf-8?B?S1lMMm1mR3VYT0I1WWwydEljYVQzL1R4V2xPaythRVdNeEptVVgyMHIzam5N?=
 =?utf-8?B?KzNYQ3dTOTBUSWwvbkN6L09FWXhVcFBiTUwrSUtZY25DcFBZNFg2aVFlNmQ0?=
 =?utf-8?B?bHpUemhnTndOU1dGcWt3WkpFVW5OaURpZXpUZ01nZ0g3aExkNWpDQVFrYnQ0?=
 =?utf-8?B?YXhucG1DWDNWQ00yYkxWYjAzeHFtbDMyRzcvN243YVIyYmRaNEdHN0tkUE1C?=
 =?utf-8?B?SWpxZVZFWkxhUTZJSFI0WXI0TnlPL2RUdFV3K2lmdVJEaHpOOXV5OVlIOGxy?=
 =?utf-8?B?aFpWYlYxaE9vWGVFWHIwKzVieDB1bVJpb0YrWituZ2tmb0FmWkNzTWp3Zk1G?=
 =?utf-8?B?cVZTb2tlZm9jM3hMNFdoYXVpL3NnbjQvMmt2cUJkMHV6RG1iQ0UxQlhHc2po?=
 =?utf-8?B?VWt1cElJTm5GYnBHenlCR3BQQStkaXB5cE5hQW90R0Q4T2hZVGhLVEpWazYy?=
 =?utf-8?B?SDVmVmVFVkVMRFJaT1JOMnloQkZGWlRzZE11VXQ3Y2d5V0FLV1JwNEU2OGRS?=
 =?utf-8?B?NHhpZllyNzRDUFpTL1hlZHQvK1VjQUtiTU51Q2F6V3REc1dqQ09Mc2cyMmhy?=
 =?utf-8?B?b3JiMDVqZDVlMHIvV1BQcm13U3RlTktvZDRadnJtUUpvTzZkazlDOGFuR2wz?=
 =?utf-8?B?bDF6YlowbUhHOUoybzRJSWNPZklRaXczUENxRFY5bkJtNHpBRHQ4UE9SbU1K?=
 =?utf-8?B?cUlmUmphTlFKa1QzWDNqOHoxblVaRTJwQmJuM1lLdHZ5THQrUDF1UHhNUTlr?=
 =?utf-8?B?RU1SRWFReEozMHNhMTFYRXZlYVRQTHduajF3NVhlS2dQak9TbGFuU3FNdWxM?=
 =?utf-8?B?SEErcDBmNDQrOHVjeGRwY2tidkRUNmpQVmR0T2RJejUwQjQ2VElyLzh3NVA3?=
 =?utf-8?B?bXJ5dTFYM2xlODZrTzllMkVjblM0Q0R2em9TSWdSdTNJZUVWNEdSbnd3bUpp?=
 =?utf-8?B?cGZib3VObXZqVnRSRURwQzAwbGhNaXhLUi8zbUU2S0s0THhndXVqeHZ1THFk?=
 =?utf-8?B?VFFuMWxjSDRWQ0E3UkhiR2lSUXArcm01M0QrK1l1a0dUU2dNZEE5bUxFc2Rk?=
 =?utf-8?B?dGQyc2g1TGl5eXFFTEVEVTE0WTFRMVRRVHJjS0NEQlhMeVJaZmE2K1E3R3Q3?=
 =?utf-8?B?ZmN5MjkyYXBsQnE5eEdJUmZsd1UxenZ1SDVEV0lnODk4N2tMWGJ4WThTdDVt?=
 =?utf-8?B?S01jVGZxYXoxSmk5N1htVlRnQnBSNkZGZTZHY1o3T2FUemdRMnl3Y0pVMG1H?=
 =?utf-8?B?UnBQLzZiUmZmM2JKRHNQckoyemh4M3dvb2R4S2NiTXlpU1V2OFpwL3lWUUJK?=
 =?utf-8?Q?lEpHteJC3MHosYpGmg3Zij2shnOqKjL1ul+NopK2sSaR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3edc8b-514c-48bf-4d2f-08dcc1697067
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 22:42:58.3036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uP89RYzuztRffE0RI4QwgJagxP4JXP8Sx/mBWeso5rSpbrbVYK53UAfQJj3niY61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318

Hi Reinette,

On 8/16/2024 4:38 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/6/24 3:00 PM, Babu Moger wrote:
>> mbm_cntr_assignable feature provides an option to the user to assign a
>> hardware counter to an RMID and monitor the bandwidth as long as the
>> counter is assigned. There can be two counters per monitor group, one
>> for total event and another for local event.
>>
>> Introduce cntr_id to manage the assignments.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v6: New patch.
>>      Separated FS and arch bits.
>> ---
>>   arch/x86/kernel/cpu/resctrl/internal.h | 7 +++++++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 ++++++
>>   2 files changed, 13 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h 
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index af3efa35a62e..d93082b65d69 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -41,6 +41,11 @@
>>   /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
>>   #define ABMC_ENABLE_BIT            0
>> +/* Maximum assignable counters per resctrl group */
>> +#define MAX_CNTRS            2
>> +
>> +#define MON_CNTR_UNSET            U32_MAX
>> +
>>   /**
>>    * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring 
>> those that
>>    *                    aren't marked nohz_full
>> @@ -210,12 +215,14 @@ enum rdtgrp_mode {
>>    * @parent:            parent rdtgrp
>>    * @crdtgrp_list:        child rdtgroup node list
>>    * @rmid:            rmid for this rdtgroup
>> + * @cntr_id:            Counter ids for assignment
> 
> Could this be:
> "IDs of hardware counters assigned to monitor group"
> 

Sure. Will do.

-- 
- Babu Moger

