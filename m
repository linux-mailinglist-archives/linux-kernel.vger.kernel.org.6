Return-Path: <linux-kernel+bounces-524716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E89EFA3E62C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C223BE97E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB532641C4;
	Thu, 20 Feb 2025 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KTA7ZGry"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4359A1E4AB;
	Thu, 20 Feb 2025 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740085061; cv=fail; b=lm950rKWMMsTMR6sFLHwxFOr/1Jf/j7R+W8aVHPCHEJN0E2VUE1a1elMaiouc3V06fd9M9f8ZuQ9vozVkGMzUf1vVoS0AwuBks7eEIxBovhgQpU7nnruTJe6h8ymBe7u+rDp/mPHrLoIhRMZruMkBI2KCzlOlU+BPBQE4195DjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740085061; c=relaxed/simple;
	bh=JjmaxybmyiTbf9t6DioWCDZGfSfSnvl1048k/afx6QI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HVshAg/4fzrfGuF15lj5kEzp0B6rPuWGtF+ROLyh7uSDNQBexuTwjO4cDdYkH/X9ZELq3yNFumMknZMooQHxua3bv0Me6E0qJoQrs7VShXggjSzStyrvSEFhnJ8UyC2XxNtewO3OIL0OmTdBeb2vAdUq/J7YTgybgVIvKeFeZGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KTA7ZGry; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Allr1P+wMbegBExV7GJHdrV/vXpoOfggM0fxJsmlbNDYdDMXlumRJqwJbWtp02jwtkG/OmZZ2eHoimySc6ooyHxhnLKLN0HwWHcLeQ5fdEWelErdl3iLB6B1rfFphmerClMrfdvQ+bm86hx9wTvn+2/HX8JWy2yU3/zHY/hoNR2yENrZcDJhEtDgOvQMnsi7C1qhKmoGdpTZfHBBp2r7dv6KTaguvASLe89VaGlCQLkeq1opBHoIj6v3HbK38RUT8TZVCFGLIGZGYcYRCBLzwsXwMKDp5RFda5LibBfjug7LXlnA4Sq2ZFXtJh+0NJvCiKigNfApl2vEV0hnhIOKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6qxq5izdS7aNN/JOlQyVXeEYLF0INmnQIZ6wezlCb4=;
 b=Jz2EqlYSOkwVt/V5Qug2rOi/8SNUcl2QUHRDhXbSgky15Mg/DruattoEMdyHvb+g7L6U8q2rRsumicnSKxNNmTQu54PwuwE91nBUgQQK7ToL3aPgoPm8uYSMX+0NBN9B0aiD2ET/ZDnXd+FNwaR+NX/xAdppjWcBfgx/5IsCbi8fntsuR6hKJhS2qXRcXqXHbrD43scETNcAlo04V5k/Mk7UcHms2cQUtISuwDxt7vmvWT9mHaxXIGnhJirPFo0PBncHk8p0HPM8FhVsVX7Yv5y7OGFHrENjdvVDoONcxL3dZkVvuFPgrlC2XGpSEFjhnrOuWKY1ivEUj5KZ10+yng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6qxq5izdS7aNN/JOlQyVXeEYLF0INmnQIZ6wezlCb4=;
 b=KTA7ZGryhhPMtoI2w/sSJsg2F5iYDdk4ULU8ndBoOiTCYX+PMt8brBps6FmQgk4Bvh98yKAFAUtCsYyyswsA361PEiABFTu37JgLim64cZyPX9TYRpwO/X18/0ivV+rSy7caLMBhR27v+PCbbuEVaoHz9HX9FfzYy446OxPOJrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Thu, 20 Feb
 2025 20:57:36 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 20:57:36 +0000
Message-ID: <fdfe13ae-1fb1-417c-88f5-6b0973338c34@amd.com>
Date: Thu, 20 Feb 2025 14:57:31 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 23/23] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: Dave Martin <Dave.Martin@arm.com>, "Moger, Babu" <bmoger@amd.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 tony.luck@intel.com, peternewman@google.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
 rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <fe1c0c4cebd353ccb3e588d7ea2fe9ef3dff0ef2.1737577229.git.babu.moger@amd.com>
 <Z7YBxNIWb7dqOnfi@e133380.arm.com>
 <1ccb907b-e8c9-4997-bc45-4a457ee84494@amd.com>
 <Z7dIfWAk+f4Gc54X@e133380.arm.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Z7dIfWAk+f4Gc54X@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0079.namprd11.prod.outlook.com
 (2603:10b6:806:d2::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d99056a-8ae5-477f-3727-08dd51f13402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODc3cGxxek9kRCtGWjhGVVJOUzFodG5NdWt4bFM1Y0hYRllTazU0Nk95RVp5?=
 =?utf-8?B?OTFiNEtLNkJkZlBNRThZSUswckVDVW50VCtzYkhQRTdtdk9yeTdSMHpMTmlB?=
 =?utf-8?B?S1BjSVJ5TnlVTDlmWW9leWlFTFV1K1pIaGhicnV1WUxNaU5wOHA2OXhmTms5?=
 =?utf-8?B?WHY2OXZpaXhkb1RCSlNkQW9kVElpenlzNUEySkllZ1FwdTFMd0dEb3lCa0NT?=
 =?utf-8?B?YVd3aklQUW5zcnhUeUoyRHJiUmRSNytzMWh1T2dZYUFBTEo2UFd4RmIzQXcz?=
 =?utf-8?B?S0pBcmVPOTl2TzVkbEdRSjhrOFFDWlA5NHFDbVk3V1plOEIvcllTSU9tcVBO?=
 =?utf-8?B?aVFCaEQ4blpWdnJjZHVzQlVXUk9sZVZHUEJ3c1dOa3VhaVhiUXNlcmFzMWds?=
 =?utf-8?B?T0U2MHF0ZEpuVVZkTHhnUWZYbnUyMGRkNmZDZnVLY0FzN0R2aGFKbGdnUllS?=
 =?utf-8?B?K2prb1lWZWVkZm1TOWxIOXhkdWxwTXRUUGhxeWR2VFlieWdMTGxmTytFUHhM?=
 =?utf-8?B?YXpaWExpMmJacGhSOVVOb0gzby9nZG01dFRyL2xqa1o3U2hVZDY2WDNlS2RB?=
 =?utf-8?B?bVV0bXdoSjdSRGRUbkM0UkV3MGhvYTBtekwxMDVudS82SnJEWGZWeWZYK1dY?=
 =?utf-8?B?b1FEdlpZdEdSbENTbW12RitmOHBCR3gyTkUzT0FwN3N2QW9aVXFsT01iSFI2?=
 =?utf-8?B?VEU1SlM3ZjAySDZJcklvdHpsaWJHK0FLK1RGOG8yS3FvNmQ1UzBpcWd5TmxB?=
 =?utf-8?B?QXBYeklLUXF1Mmhmc1lCNWg4S3ZXUWlXT1lNK2ZUdFpibE1QSW1oYWppQkxh?=
 =?utf-8?B?VG13U01MQ0pVQWFwck1Wd0ZUbFhQVmRRT0xYa0UxMzRkQldxYXNqc21EblFQ?=
 =?utf-8?B?d2dIa3ArUFlxRThZMkgzaHpNWmFlZnRaeGdGV0owSlpMd2RCQnV6SmFCTFgv?=
 =?utf-8?B?NVBCeHZqQXNMNHMzMkh1bmduaThwMGRaSVRlNUFFOXI4dnZvN25rZitiTG9w?=
 =?utf-8?B?RHBBejhzZVRqa01OWWFqS1ZubUMxdURER2w1Wi9WOCtkYlZYOGVOVVBHbUFC?=
 =?utf-8?B?bWllUC9ZNEI4N1JoM0pNYnE1Vk5JSHR6ZnZYMzhQc1c5d3hiSTlQSElBbzdh?=
 =?utf-8?B?Q2ZrOGNpdnlYWjgyZGx1NThWN3htcGh1K29OUXFIT3NZa25iZElkY1VWQ2hP?=
 =?utf-8?B?T3hFTFRIY0Y4TVR1UzRQODUrVXFyVERqakNSaG42WVZOR1hYTUNkbkpta2FR?=
 =?utf-8?B?TDNjOGRwaTZhV0hReFNsejBINUFOMEJlWnFBZnhUU0pheEh1cDVwdkFQSzhv?=
 =?utf-8?B?eEQzWjlYWExGS1JIcG9velUwMElPbVExQ3o1Mk0vOVRVRHZ2UkdVcEpUR3Ns?=
 =?utf-8?B?bmM2RHYzWXkybXhRWDNkVVlFZFhzeDBMUDNKMk1US3dzbjEvSmdjTlJNcXhE?=
 =?utf-8?B?UWlvaTY1VWlycS91aTVPNFhlY0lsMGlBemhSR3VsNlptanZTdS9nc0dxUW53?=
 =?utf-8?B?Zy9vNXhzY2FjdVk4b1FnMGwxTXFiUWhRR1hPNGJNOUlMVjB3MGpLYUNUU0xO?=
 =?utf-8?B?bFc5aHdJWHVvMzBQVEtpVGdoOHhDUmdHNlJSTDFDV1d4U1ZHUVBEOXRkYWhz?=
 =?utf-8?B?T0lkNmhIdGEvWDhBM0RDWUJNVlhQbXloWEh0WG84K3FUdkJ4eGx1Nk9wQkVC?=
 =?utf-8?B?R0sxck83eVcrTkRXeDEvc3NMVGowWHNKYTRocEtzRlM2bEtBRjVVYkJLWlFl?=
 =?utf-8?B?ZDV3MHM1WXlFQkE2TktQbkhURnJkR2dEYzJKYUVuN2l0THJ1WHUzTDJidmRN?=
 =?utf-8?B?SWxWMHlEKzBuY3NIZFlONFdENTYwR3NGdG9iTVFuTmdnNG5JSWRpRkdRY0Vx?=
 =?utf-8?Q?p/adj+HNuwTJG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVFZREJlS0Y3WEZwNkI1YXFzejQ0NTUwdzNLM3E0bFB3WE9yMERmOU14d0Iz?=
 =?utf-8?B?QkFtL25rTGxHUms0QnZ6YTZ4ZWd2b1ZwTFMwZ0FSZ1JWakp5REJNMGpNWXli?=
 =?utf-8?B?UzErSUxNVTdWanA3S01kNUR2ZFJTeHc2UzNydkNWcHdDa3hteDArNXNNNlRI?=
 =?utf-8?B?dVBzajExdENialhGZUgzQ25tdjNtR3dhOSs0eVREcGRLcmNvcjZuSEQxd3l6?=
 =?utf-8?B?R3BQOS9xTE1MN3hFcitjdjlVaElyY2NLaG05VW5EZG1PRmdyVVFOVERVc1V1?=
 =?utf-8?B?L1Q0YStrZDRESjVQRnNFWlF1cENVWC80elhUVjh3TVFMYmpjNGtrTW1tcWpP?=
 =?utf-8?B?R2YwOWlINVVUKzNxY1FBcXZjQ0F3SVY0RXdLZkFWWGNGcnFNT2NJZFlGcWhP?=
 =?utf-8?B?U1R0dEtkNm9kUDhBc0gvbG1IQ1dtZnErUEtMc3h6WUQ0NUQrUEl6Q0pZeHlH?=
 =?utf-8?B?UFhJVjVWZVBQMkFlRnZycXZpc21lbHkvVzkyTWhtWmdxTjlGUWJNNE94NHVZ?=
 =?utf-8?B?bmc4ZUZqanNSZ2NvRGRYUjg0RTlsRGZXOG12T0tEOTcwUndnZmJGUFNaQlE3?=
 =?utf-8?B?Snd0SVJ3RTF3S3Z6SWZNNUtLQUxwQSttRzVPSnVTZ0tNTkZlY1hYdEZYaVNs?=
 =?utf-8?B?aGhDQkdseFJRaTlnbElkTkkyenBZeVZrb3JIeEd0OEJLWkVVOXV4ZURKSS81?=
 =?utf-8?B?UmNIbXJoeUhWWFRYUXd0RkRhYmt2S0JIWjNYMmFCMGx0K3VTMDlhdU1GYTBm?=
 =?utf-8?B?a29ZUFNwem9STm9UVHZMRFpza1ErMi9uUjBhdmNIcHNpV0hZZVhhbmRnQ3ds?=
 =?utf-8?B?RWlUem5wR2xKZjhXa1NiR04rRFQxYTlySjBoTHhVQm1DZC9lUStweWd2aGtq?=
 =?utf-8?B?VGpDZ0VGN2pMTDd2Q3F6THFnZVl1STNFNWRiU3hlK0F1WVEvMDdNUVgva3Vo?=
 =?utf-8?B?eUFRNEQ0MTlYVWFWWlI5d3lIU2o1UXRKTk9LcHgwUmJZTnlaWjNkSVpudlY0?=
 =?utf-8?B?L2Q1TlBYVkVzWnAyVWJBZjdlOWk2T1pMbUdSTG40bldpWjVVSjB2WWJsNmtE?=
 =?utf-8?B?Rkl3cjg3empGajJXeHBXN0lhTFdnQ2FNb3BhYjJCdERLMFBLSE55OTNSWDBI?=
 =?utf-8?B?SUdNd0NVZFNFM0Rvdk02SXBLZDF4eGk3UG9FWW5ad0F1Y1R3cVp0ME5HWENj?=
 =?utf-8?B?amkzdUZteFRGSy9EbHVTb1puaExTVlA2Q3NhWTIvT1ZlcWVsaVNwdFE2Z3Q1?=
 =?utf-8?B?a3dEVXh4UmtYeHZoNTc3QWp0SFYrUGdoQlU3SjFueTc5MGJJUG14c2sxZy94?=
 =?utf-8?B?bVdhWkhSU0VrTUExZ0JHc094eEd2bTVSVEh6ZFBvYng5cXUwZlVha2h3NWZW?=
 =?utf-8?B?VGN0d1I0MW8rR0F6UmVuUnZDUy9rMXB2REtjcncxWWRlZlliZFUwZHdXd0lU?=
 =?utf-8?B?eHViMVhaWlFWMmJ6Zk5WZG1Ic1phNkVkY0NmVXhPbVB6R0pLcGNLVXhsdGFW?=
 =?utf-8?B?WVhCbzBBaUw2UWdKSnpLMWFmNjAzTTUxVTFJZ3JJUWtHV044ME5jSHkrMkFt?=
 =?utf-8?B?aHdwKzlUeDZxMmE0Q2psUEZrYy8xdEh6dk9nWjJJdURrMGZRanhEWVRkcXBX?=
 =?utf-8?B?NEx0dVh0dVBpYTBWRENZYjJPS1VsL3YwZm1OdTFTaFQrNkJQOUJTZFBoZW0z?=
 =?utf-8?B?Y0tSSjVIdVZkV0tsUEtybVZOUFhsNlRnTm9PdVhnVm1ldnlsb0Zub0tQMjVC?=
 =?utf-8?B?VkYraHQ1c1dEeXEzWFZsQ2ZETmluWExOT3Q2RnR5bnNIQlEvbVZXOEJzZE1a?=
 =?utf-8?B?YVpEMldCQkNZUGw0bkRqRlJwaUhZOVJGa1JscjdNVGt6b1RtM3o1STZxQThY?=
 =?utf-8?B?aGE1RVlScEJuSG96Y1R0OE1ONDZJSmtMMG4weFZlSXh3c1Byb0ZENFFDMEda?=
 =?utf-8?B?Smt4NXMrTlY3bmJOQmtiR00vQUxFTnhDK0VMWi9sdVNaQ2VpWkR5N3J0dUtN?=
 =?utf-8?B?N1RCMFZUc0xxM2MvamF3TnE4MWdYUXVYVjhFNlRCODM3NGVsRmJaSjM4WXZM?=
 =?utf-8?B?MFJiOXEwTlJzYjl1dXFPTm1ScmJ3dGZPbFdPYmQ1MGo2MWxpWkc4SC9WYXRP?=
 =?utf-8?Q?uJIg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d99056a-8ae5-477f-3727-08dd51f13402
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 20:57:35.9980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sodG7UcvVN28aw2Pl441QQWD5yYIH+PY6cDn8TuEgVcIo2o5xx5YtPpCQwghg4Gu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461

Hi Dave,

On 2/20/25 09:21, Dave Martin wrote:
> Hi,
> 
> On Wed, Feb 19, 2025 at 06:34:42PM -0600, Moger, Babu wrote:
>> Hi Dave,
>>
>> On 2/19/2025 10:07 AM, Dave Martin wrote:
>>> Hi,
>>>
>>> On Wed, Jan 22, 2025 at 02:20:31PM -0600, Babu Moger wrote:
> 
>>> [...]
>>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> index 6e29827239e0..299839bcf23f 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> @@ -1050,6 +1050,244 @@ static int resctrl_mbm_assign_control_show(struct kernfs_open_file *of,
>>>
>>> [...]
>>>
>>>> +static ssize_t resctrl_mbm_assign_control_write(struct kernfs_open_file *of,
>>>> +						char *buf, size_t nbytes, loff_t off)
>>>> +{
> 
> [...]
> 
>>>> +	while ((token = strsep(&buf, "\n")) != NULL) {
>>>> +		/*
>>>> +		 * The write command follows the following format:
>>>> +		 * “<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>”
>>>> +		 * Extract the CTRL_MON group.
>>>> +		 */
>>>> +		cmon_grp = strsep(&token, "/");
>>>> +
>>>
>>> As when reading this file, I think that the data can grow larger than a
>>> page and get split into multiple write() calls.
>>>
>>> I don't currently think the file needs to be redesigned, but there are
>>> some concerns about how userspace will work with it that need to be
>>> sorted out.
>>>
>>> Every monitoring group can contribute a line to this file:
>>>
>>> 	CTRL_GROUP / MON_GROUP / DOMAIN = [t][l] [ ; DOMAIN = [t][l] ]* LF
>>>
>>> so, 2 * (NAME_MAX + 1) + NUM_DOMAINS * 5 - 1 + 1
>>>
>>> NAME_MAX on Linux is 255, so with, say, up to 16 domains, that's about
>>> 600 bytes per monitoring group in the worst case.
>>>
>>> We don't need to have many control and monitoring groups for this to
>>> grow potentially over 4K.
>>>
>>>
>>> We could simply place a limit on how much userspace is allowed to write
>>> to this file in one go, although this restriction feels difficult for
>>> userspace to follow -- but maybe this is workable in the short term, on
>>> current systems (?)
>>>
>>> Otherwise, since we expect this interface to be written using scripting
>>> languages, I think we need to be prepared to accept fully-buffered
>>> I/O.  That means that the data may be cut at random places, not
>>> necessarily at newlines.  (For smaller files such as schemata this is
>>> not such an issue, since the whole file is likely to be small enough to
>>> fit into the default stdio buffers -- this is how sysfs gets away with
>>> it IIUC.)
>>>
>>> For fully-buffered I/O, we may have to cache an incomplete line in
>>> between write() calls.  If there is a dangling incomplete line when the
>>> file is closed then it is hard to tell userspace, because people often
>>> don't bother to check the return value of close(), fclose() etc.
>>> However, since it's an ABI violation for userspace to end this file
>>> with a partial line, I think it's sufficient to report that via
>>> last_cmd_status.  (Making close() return -EIO still seems a good idea
>>> though, just in case userspace is listening.)
>>
>> Seems like we can add a check in resctrl_mbm_assign_control_write() to
>> compare nbytes > PAGE_SIZE.
> 
> This might be a reasonable stopgap approach, if we are confident that the
> number of RMIDs and monitoring domains is small enough on known
> platforms that the problem is unlikely to be hit.  I can't really judge
> on this.
> 
>> But do we really need this? I have no way of testing this. Help me
>> understand.
> 
> It's easy to demonatrate this using the schemata file (which works in a
> similar way).  Open f in /sys/fs/resctrl/schemata, then:
> 
> 	int n = 0;
> 
> 	for (n = 0; n < 1000; n++)
> 		if (fputs("MB:0=100;1=100\n", f) == EOF)
> 			fprintf(stderr, "Failed on interation %d\n", n);
> 
> This will succeed a certain number of times (272, for me) and then fail
> when the stdio buffer for f overflows, triggering a write().
> 
> Putting an explicit fflush() after every fputs() call (or doing a
> setlinebuf(f) before the loop) makes it work.  But this is awkward and
> unexpected for the user, and doing the right thing from a scripting
> language may be tricky.
> 
> In this example I am doing something a bit artificial -- we don't
> officially say what happens when a pre-opened schemata file handle is
> reused in this way, AFAICT.  But for mbm_assign_control it is
> legitimate to write many lines, and we can hit this kind of problem.
> 
> 
> I'll leave it to others to judge whether we _need_ to fix this, but it
> feels like a problem waiting to happen.

Created the problem using this code using a "test" group.

include <stdio.h>
#include <errno.h>
#include <string.h>

int main()
{
        FILE *file;
        int n;

        file = fopen("/sys/fs/resctrl/info/L3_MON/mbm_assign_control", "w");

        if (file == NULL) {
                printf("Error opening file!\n");
                return 1;
        }

        printf("File opened successfully.\n");

        for (n = 0; n < 100; n++)
                if
(fputs("test//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;9=tl;10=tl;11=tl\n", file) == EOF)
                        fprintf(stderr, "Failed on interation %d error
%s\n ", n, strerror(errno));

        if (fclose(file) == 0) {
                printf("File closed successfully.\n");
        } else {
                printf("Error closing file!\n");
        }
}


When the buffer overflow happens the newline will not be there. I have
added this error via rdt_last_cmd_puts. At least user knows there is an error.

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 484d6009869f..70a96976e3ab 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1250,8 +1252,10 @@ static ssize_t
resctrl_mbm_assign_control_write(struct kernfs_open_file *of,
        int ret;

        /* Valid input requires a trailing newline */
-       if (nbytes == 0 || buf[nbytes - 1] != '\n')
+       if (nbytes == 0 || buf[nbytes - 1] != '\n') {
+               rdt_last_cmd_puts("mbm_cntr_assign: buffer invalid\n");
                return -EINVAL;
+       }

        buf[nbytes - 1] = '\0';



I am open to other ideas to handle this case.


> 
> 
>> All these file operations go thru generic call kernfs_fop_write_iter().
>> Doesn't it take care of buffer check and overflow?
> 
> No, this is called for each iovec segment (where userspace used one of
> the iovec based I/O syscalls).  But there is no buffering or
> concatenation of the data read in: each segment gets passed down to the
> individual kernfs_file_operations write method for the file:
> 
> 	len = ops->write(of, buf, len, iocb->ki_pos)
> 
> calls down to
> 
> 	resctrl_mbm_assign_control_write(of, buf, len, iocb->ki_pos).
> 
> 
> I'll try to port my buffering hack on top of the series -- that should
> help to illustrate what I mean.
> 
> Cheers
> ---Dave
> 

-- 
Thanks
Babu Moger

