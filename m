Return-Path: <linux-kernel+bounces-364406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C49D99D44C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABBF9B254F3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDE11ABEBB;
	Mon, 14 Oct 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s/Mc0SKq"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EB61AB534
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922089; cv=fail; b=nHgQh4YdcJx/Ndp97ez2Rvyc3wm/71OtDb9OsvdvTrpipJXOHrPYhA729kc23uet6lEPaSoosXwSAUJ89kJ27iERzuiS3frtbsK3Qv+Hw13t1PWpoCbshc2jmrVj6ONsV7HNS2dGlmZaPdyfTSMuMU8QThf5mUHp6J7WNjQX+DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922089; c=relaxed/simple;
	bh=zQIlghbMEePE0lC0w5mP5CN2n9Emx4qq/Y6+GWiacsg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FyJjvafNR4Aqhd2z9IaxVRzRXvAPvhwJ50QgJfDUjRqox+MXz1v5S66eHtWq7/oK7TWQIrUw0g5v1Qogv6nxr5eJfMbmDcF/5EiB3S9JuaHqVJvIb68hNQg9YhCCdJ64Tr/eTlC7TF3KEiA+3TlnNpfQcuFbfdSrlwEc2gi70cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s/Mc0SKq; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5+n8+f1h01jNKhG8mtEIwa8EJ41LJasRdk8zrX9h4pbgkFI5aQQwJFl+4IRjXjTxBG4BxcrJvmiwE+IzkzSybj8MWyfAoxhMt0oEhTd4KIXH6XmkKo80BbOE9zuy1iyZWXUx0R9OyT8ZeIAGObNwmolFwwenY0pFHf3CXr+ahWNG/oKRlyXal5ZODAxnjkGkU9jo9K7ypXdvJH4UBCxL4ET4a4LnZEphtCOwuXhSkfrHACJrILD6euDHuSgAfI9+zEJttFCTp2vk9Wlmylh0xlahSSvmAqL3Wn5QhKQA0VyMrabvYI56W4mUo6dhT+obdpdPYMGc5UMMx8nO7uE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVmQqwP6/iqljY64IW0XnSYqPNVALP4cdgLd4KSYEGU=;
 b=WR2uhCpQYARPNWsK0PJc+9fAV1O/FVEyneLVqxyg7gEostGpnQuDNHPWuIx+PAb8urGUrO7CoSDiffILtxvO7dJ8jJyoNr+7y7u99cCrTbecpfk23j8SqLkZdS17K3MPtljb+4X515n5vm+teJG02br265U3ANbco53Lm1yxaxxLKuJ+RH9P25X27aqOi69yESwhTO0MUAo1MfqyIwL27pN/tA+KmnMGHhYdaIzxk0uuG9701bOr07eOqrLBj9MYQUzK5rxnqWLyGERGJKF2w7+53zrFGB/0GUGjQ62LMEN/XYU5RzV5b4ZO8DWhHxXHJNUP3SY3+DN62HqSox3VPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVmQqwP6/iqljY64IW0XnSYqPNVALP4cdgLd4KSYEGU=;
 b=s/Mc0SKqDzTt8OgmOC0C2k9sVQ+bTGcyFj+01nUodf8BP6pDAZk5uzNORBEyMKNhKHvFP+ZBZ3dhQA8xpHtwkSHIKDxUAEgzS+n2NCfZZxXXXmBI87EiU+/VAu1twATYip0SuiHeiA+Mp24c/ybonfJVTeViRLLnmr10tAFwk8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MW6PR12MB8998.namprd12.prod.outlook.com (2603:10b6:303:249::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Mon, 14 Oct
 2024 16:08:03 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8048.017; Mon, 14 Oct 2024
 16:08:02 +0000
Message-ID: <1746b1d2-cef6-4c32-b94d-ddec5b8709df@amd.com>
Date: Mon, 14 Oct 2024 21:37:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] perf/x86/rapl: Clean up cpumask and hotplug
To: kan.liang@linux.intel.com, peterz@infradead.org, mingo@kernel.org,
 tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc: Oliver Sang <oliver.sang@intel.com>
References: <20241010142604.770192-1-kan.liang@linux.intel.com>
 <20241010142604.770192-2-kan.liang@linux.intel.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241010142604.770192-2-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::11) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MW6PR12MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: 838b462b-091c-476c-8b68-08dcec6a6180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WE01ZkRsWG9HcDBOYnM3NUZxUFQ2OCs1aEQrWElOS0dyM001V1RUdnFCY2dn?=
 =?utf-8?B?QlZ5L0NaV0phcVc2UE5LdzFoTGRpb2RBa0llZklnaFV0NGdCNUlJNlBaSFZ4?=
 =?utf-8?B?TWtKcTBncC82MzBub1ZUSW9Lck5adVprTzBKcW1jcW9weUNTMXBLV3V5eWFJ?=
 =?utf-8?B?RVZOL1lvcHFlcyt5dGZuNjJnY0UrS0lja1RrZmxvTGVHaWdrTWxXcjFpckNw?=
 =?utf-8?B?Wi9TV2pPK3lPUDJBd090ZzZCUThrL1ZtSExsOXJhb2Q1UXppbGE1bFNjNkJy?=
 =?utf-8?B?UHlrOUNkRy9STmN2OEMweU9qQVZKdE50SklXVXc3T1BnN3paZmg0SkZCSU93?=
 =?utf-8?B?cmkvaEsvdnZLMEhwR3FJUnMzSmJWV3FoL005TlAxSkRqdFJNckdrZGVsRmFW?=
 =?utf-8?B?QkJwMWtoQjRnSkEyUndtWUpMM0V5cWZRUExtUUJCSGxWQVJ4ckU5OHNMQWhI?=
 =?utf-8?B?MlVzRkhRUWZsZmFJRks5dHJVNGJIWHVVQXQ4SXZVaGtOQkgrd2tDWm1XN01P?=
 =?utf-8?B?cGFieW15QXU4VGx4N2c4K2ppVjJyczE2MTZSdnp2NFlaVEZ1Sk9NbXc5VTkz?=
 =?utf-8?B?Lzdkd3JpMUpjVjEzZU16R05kdnVDdUZaQnUwQ29RTzN0MWVJWXFBcWJSVEZ2?=
 =?utf-8?B?OVlGQWZPbzE3RzBlMHd2dkhHWmR4KzFIZGp0MGhOZ1ZGWGhRYk51K3JRQ0VJ?=
 =?utf-8?B?TkxTWVVtcjZJZkJtWUU0bGhXa0hDZzNwSUVUSG1KcVpNcVp2NHlpdVFKSndJ?=
 =?utf-8?B?bW5aQlZ6UkpFYXY4M25XQ1hueFF6NUpCbG5XcElRNkcvQjRodG55NXdmeSt2?=
 =?utf-8?B?MGZBT3ZneUJVQXRKbzZFWngzdHlocHpLcGlwaFVBMUxmSjBWcGdZazNMNzZH?=
 =?utf-8?B?ZUNnZkhlL25aWjFpZHVJOVQ4aEtWUjlvTXFDVmhLNUhYamdWNDBRUlpFS3pH?=
 =?utf-8?B?bHFTcnpYUWU1TllJUGFaRklWYTd0R21uUUpxeHg5Ry9qOGFGWEdJZEJxSWgw?=
 =?utf-8?B?QXk2bjhYeFduZDAzUVpiREdSNjZpSjdncFY3Yy9HbEpncVVaUUZZa1gxcDJh?=
 =?utf-8?B?WVAwb1NBUXdESDh0eGVPMVdiOWduVnZjaTcvam41NE5FckJwMTM1U0x6N1Nm?=
 =?utf-8?B?ak5BV1NPOVVMdThVSHpmZVQyT05JQ2svY0h6VTdydEtmOFBaZWRZenplRUlJ?=
 =?utf-8?B?Qlg5OU8vVUxPb1lHa0d2YXo2MVhBSjloUUY2WGVFYlZCWEhoUzdyMUYzN1FX?=
 =?utf-8?B?UlF2VTRFUjRkTTlDNWQvbm9QQ3RmL1pOdzNsYWNUM05LTkl6K3VzRXF3ZEs1?=
 =?utf-8?B?Z0hUT1R3SG1KRGdFVytuTEtMTUdTNmF3V1RESUpBbklpczRDQnVJQTl5UzBw?=
 =?utf-8?B?dURiKzRWWHB3VFVJVmtpTDFESDIzMU1NblFNUDRNV3dQeWUzdjBlREx4S05k?=
 =?utf-8?B?TnhSZWttNTg5cmtmSW41YTdkY3pBM3I0cjJiaHA4YmI2NEhOSTFrRHFmUktI?=
 =?utf-8?B?cGxaQVY4SUdtTGpHemsrRzV1RDBEQmNNL1R2RUpBTkwxeDRPZTBmMnhyR3py?=
 =?utf-8?B?clVWTWY2ekZzMXBFQmIySk05OGEvSlIzd3NxR29KbzZ1MmtodWZValhFL3Zj?=
 =?utf-8?B?RS9wQWtmOUNzTEdzUUxEeS9uZXQ5MVVTOXQ5TE1JRXpFK3EvcFAxYkpnWHlC?=
 =?utf-8?B?aUlzeUpJaFJkdEFYTzdMb2ZEdnBGT200Y2g5VTFNUGVEZ0RQdzlHZ2lRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MS85dVRTZmgzQ2ZOSVJraVlXRHZEbUR2U3ZTV3Rjd1gvcEhzV1luK0JGZy90?=
 =?utf-8?B?ZkF6Um9KRWVrU24rb1pEbFRITTRnWnJtZjNyM0xoMHNHSFFoYjM3aUk5U01M?=
 =?utf-8?B?VUN2M0N1WlRNRkJOYzdXSHZJZVg0Y2lwUHkrZ1JIKzJZQkErcnpIUkkvQUV4?=
 =?utf-8?B?WXJDTHFvTGNFaElVNnVXWDVvdGFCb1VRRlVya1JvcmQ2eUF5R0Y1eE45b3JV?=
 =?utf-8?B?VjZSWmJCZHpUakhNNXhYUUl6S0dNREpVZmIwRjdBQ3o5SXk1b1FvZ05HYnJx?=
 =?utf-8?B?K1ZlSUdNWi9sOThLY0RhZ2NPeGxSRzBMOGloYS9GajBpQy8valBoOWRqZEp4?=
 =?utf-8?B?WkhxUkFDTW1kTU9HUDhKUEN5OXhCMU1sMHg5ekdFWFdTYW5TdmNLa3Q4K20r?=
 =?utf-8?B?aExOcE9nVkEyajdJMVhjTDZwQ1VBdGNic1RTWHgxUFpvSkNUSjNmOE92RDgy?=
 =?utf-8?B?UGxiNk9uVEgwVlZ6N1JLeXFQWjhVWTkyY2l5L2kyMVNTYTlqTjJuR0NpN2Vr?=
 =?utf-8?B?UkNSY3ZtSjIxcjBJekh5cVJZOWhhRzJXcnBveHluTGw2RkJKSGpMVGt0amc4?=
 =?utf-8?B?MDVnNmZPYTFBYS9sL3o3ZmhoUkFTWlVhd3RudHJ0ZWZWMHpUVHI4UnUxNkNq?=
 =?utf-8?B?SnFtTFRwOUhreUhxdDNHa1RMb3lGWkJWSE5MTlYzVVdYS2NLSGxCQlJlYjQ1?=
 =?utf-8?B?SXo1UjlZYlVrR2U1NkdxTWpnUnh6NXB3NEY4aDJsdFZsZW9UbUs2NGtQbFhO?=
 =?utf-8?B?YzFvMFJpWHRGbDdIS1VjWnhUUHlCQy9ZbDUxUFBkaXl3bkxaZUc5a2JQam5w?=
 =?utf-8?B?eGQ1SzBibzR2THlqTjA4OHRoVm1KV2dEMmF6Qk5kZWxPOWd6Z0FKc2VveDh4?=
 =?utf-8?B?VmlPU2daelRpMzd6dlowYmw0eVYrYmdOMUNzT2xnU09Ra3JaWXdlcW1jT012?=
 =?utf-8?B?TDVnL0pUY3oxRXpmMlJYNEp6WmNibjhJOFpGb2Q0L3JST01SVlVTSmk1emNX?=
 =?utf-8?B?dDZXS01sbU45bmhRTk1Tb2lodWh3VWRURmhsQVh4WU8yZkpROVNkeVNMUHRs?=
 =?utf-8?B?VmJZRWtIVVNkb1NyVjJWTG01L2dKMk9sY1lvVXc3UzRjMXZhb0M1d0p0ZHhO?=
 =?utf-8?B?SGlQQ1JrMFdDWXdZbytoS0hteEY1TytBeW53SHFQY2E5V1VlK0dWa2FRZit3?=
 =?utf-8?B?cTdlT0xxRDVJbFlWVmZXbXI5aDZ1Q1VFYlB4U09pTGN6RHJURkZLMXBwc1Za?=
 =?utf-8?B?ZG1LWWI1cXB3Q3R1cytMVUtxb2tjZ21JNzJZR3Y4YTBQTlNjbFN4Q3BQNnI5?=
 =?utf-8?B?eTBTZ0F1T1FVVjNVdVkxeVdHMEFqUmVDVUVnN0ZaZk1ERkg1WG9kMmFCS1dt?=
 =?utf-8?B?NjE1bDBDRlJLWnB1eG1aVFBOQS83bHJabGt1WUlGeUtGOFphbmd5aHZNSnBN?=
 =?utf-8?B?cUFvVFkxVFlybE9XeklXR2htODJtYW9pVktjaVVVaGdrVjFpcG9MenlWeWtO?=
 =?utf-8?B?Wit6OHZKdnFLMWlLOGZndURRQTNvelhlczVZWnBGNUFxR3NQRHZnS3kzb1lp?=
 =?utf-8?B?ZFNuS1hFcC9ueFJTejhYZGZ0R1lkaFRqYjVXUFZEMklmWnFUOUNkQXkwU3p2?=
 =?utf-8?B?RlkrRmtzN0c1Zi9CTHJmbksrWXRJekkyb0NiYkhjV0ttVGltWEV0RWFpcFFW?=
 =?utf-8?B?WndFNFJUcStBWEVMQ2Rya281bFhGdVF2aHhxM1UzVk5uTkpubFhvb3lsOWNx?=
 =?utf-8?B?NVd4RWpMNWQrVnFVTzRVUk16RGpYZ3VXeTFGaUNHa3EvekhoNDdLcVVkZzNJ?=
 =?utf-8?B?ZE5ISGNUWXRpOGthOHdwRml0L2R6ZlpNNE1pQlJ2eXFGQndtbWFrZWZsVTBv?=
 =?utf-8?B?WExqbVhJMVkzeUllZXpNREdLcjYyU1JPSlc4STdJN3JzQjZoZ2N5eFpIMEM4?=
 =?utf-8?B?UERSMjI5eDZZZHNVRkJTYUNuWGZFMHF3bkFSdXNOUlYyeVduZ0NmRVFQTjZB?=
 =?utf-8?B?djVLNFdsQmRxdktmZVBtY1NadXZ3T0ZTTWw4UjdIMXBwQkk4TDNGU1U5MzdJ?=
 =?utf-8?B?T2h2NkpqNG1KalM1TUVobCthOHJTVmNvRGpzdzBxbnZVdW5VYTQ1MEhpTnNS?=
 =?utf-8?Q?f+MrGOyl+Lz3SvGqbZjjJKDcQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838b462b-091c-476c-8b68-08dcec6a6180
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 16:08:02.9481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUBduhX4a45G85CEl7ws8yLT4XyV3MG9VKF553vjupB68eqhdsw/Yx93m0NvyOXHiL7U2JpeZ2ki3VFzAehXcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8998

Hello Kan,

On 10/10/2024 7:56 PM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The rapl pmu is die scope, which is supported by the generic perf_event
> subsystem now.
> 
> Set the scope for the rapl PMU and remove all the cpumask and hotplug
> codes.
> 
> Tested-by: Oliver Sang <oliver.sang@intel.com>

I have tested this on Zen3 and Zen4 EPYC servers,

# perf stat -e power/energy-pkg/ sleep 1

 Performance counter stats for 'system wide':

             91.97 Joules power/energy-pkg/

       1.003791633 seconds time elapsed

Looks good to me.

Please feel free to add,

Tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks,
Dhananjay

> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
>  arch/x86/events/rapl.c     | 90 +++-----------------------------------
>  include/linux/cpuhotplug.h |  1 -
>  2 files changed, 6 insertions(+), 85 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 7764f739fa0a..0ae9fd5e619c 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -148,7 +148,6 @@ struct rapl_model {
>   /* 1/2^hw_unit Joule */
>  static int rapl_hw_unit[NR_RAPL_DOMAINS] __read_mostly;
>  static struct rapl_pmus *rapl_pmus;
> -static cpumask_t rapl_cpu_mask;
>  static unsigned int rapl_cntr_mask;
>  static u64 rapl_timer_ms;
>  static struct perf_msr *rapl_msrs;
> @@ -369,8 +368,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
>  	if (event->cpu < 0)
>  		return -EINVAL;
>  
> -	event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
> -
>  	if (!cfg || cfg >= NR_RAPL_DOMAINS + 1)
>  		return -EINVAL;
>  
> @@ -389,7 +386,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
>  	pmu = cpu_to_rapl_pmu(event->cpu);
>  	if (!pmu)
>  		return -EINVAL;
> -	event->cpu = pmu->cpu;
>  	event->pmu_private = pmu;
>  	event->hw.event_base = rapl_msrs[bit].msr;
>  	event->hw.config = cfg;
> @@ -403,23 +399,6 @@ static void rapl_pmu_event_read(struct perf_event *event)
>  	rapl_event_update(event);
>  }
>  
> -static ssize_t rapl_get_attr_cpumask(struct device *dev,
> -				struct device_attribute *attr, char *buf)
> -{
> -	return cpumap_print_to_pagebuf(true, buf, &rapl_cpu_mask);
> -}
> -
> -static DEVICE_ATTR(cpumask, S_IRUGO, rapl_get_attr_cpumask, NULL);
> -
> -static struct attribute *rapl_pmu_attrs[] = {
> -	&dev_attr_cpumask.attr,
> -	NULL,
> -};
> -
> -static struct attribute_group rapl_pmu_attr_group = {
> -	.attrs = rapl_pmu_attrs,
> -};
> -
>  RAPL_EVENT_ATTR_STR(energy-cores, rapl_cores, "event=0x01");
>  RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
>  RAPL_EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
> @@ -467,7 +446,6 @@ static struct attribute_group rapl_pmu_format_group = {
>  };
>  
>  static const struct attribute_group *rapl_attr_groups[] = {
> -	&rapl_pmu_attr_group,
>  	&rapl_pmu_format_group,
>  	&rapl_pmu_events_group,
>  	NULL,
> @@ -570,54 +548,6 @@ static struct perf_msr amd_rapl_msrs[] = {
>  	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
>  };
>  
> -static int rapl_cpu_offline(unsigned int cpu)
> -{
> -	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
> -	int target;
> -
> -	/* Check if exiting cpu is used for collecting rapl events */
> -	if (!cpumask_test_and_clear_cpu(cpu, &rapl_cpu_mask))
> -		return 0;
> -
> -	pmu->cpu = -1;
> -	/* Find a new cpu to collect rapl events */
> -	target = cpumask_any_but(get_rapl_pmu_cpumask(cpu), cpu);
> -
> -	/* Migrate rapl events to the new target */
> -	if (target < nr_cpu_ids) {
> -		cpumask_set_cpu(target, &rapl_cpu_mask);
> -		pmu->cpu = target;
> -		perf_pmu_migrate_context(pmu->pmu, cpu, target);
> -	}
> -	return 0;
> -}
> -
> -static int rapl_cpu_online(unsigned int cpu)
> -{
> -	s32 rapl_pmu_idx = get_rapl_pmu_idx(cpu);
> -	if (rapl_pmu_idx < 0) {
> -		pr_err("topology_logical_(package/die)_id() returned a negative value");
> -		return -EINVAL;
> -	}
> -	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
> -	int target;
> -
> -	if (!pmu)
> -		return -ENOMEM;
> -
> -	/*
> -	 * Check if there is an online cpu in the package which collects rapl
> -	 * events already.
> -	 */
> -	target = cpumask_any_and(&rapl_cpu_mask, get_rapl_pmu_cpumask(cpu));
> -	if (target < nr_cpu_ids)
> -		return 0;
> -
> -	cpumask_set_cpu(cpu, &rapl_cpu_mask);
> -	pmu->cpu = cpu;
> -	return 0;
> -}
> -
>  static int rapl_check_hw_unit(struct rapl_model *rm)
>  {
>  	u64 msr_rapl_power_unit_bits;
> @@ -725,9 +655,12 @@ static int __init init_rapl_pmu(void)
>  static int __init init_rapl_pmus(void)
>  {
>  	int nr_rapl_pmu = topology_max_packages();
> +	int rapl_pmu_scope = PERF_PMU_SCOPE_PKG;
>  
> -	if (!rapl_pmu_is_pkg_scope())
> +	if (!rapl_pmu_is_pkg_scope()) {
>  		nr_rapl_pmu *= topology_max_dies_per_package();
> +		rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
> +	}
>  
>  	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
>  	if (!rapl_pmus)
> @@ -743,6 +676,7 @@ static int __init init_rapl_pmus(void)
>  	rapl_pmus->pmu.start		= rapl_pmu_event_start;
>  	rapl_pmus->pmu.stop		= rapl_pmu_event_stop;
>  	rapl_pmus->pmu.read		= rapl_pmu_event_read;
> +	rapl_pmus->pmu.scope		= rapl_pmu_scope;
>  	rapl_pmus->pmu.module		= THIS_MODULE;
>  	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
>  
> @@ -892,24 +826,13 @@ static int __init rapl_pmu_init(void)
>  	if (ret)
>  		return ret;
>  
> -	/*
> -	 * Install callbacks. Core will call them for each online cpu.
> -	 */
> -	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_RAPL_ONLINE,
> -				"perf/x86/rapl:online",
> -				rapl_cpu_online, rapl_cpu_offline);
> -	if (ret)
> -		goto out;
> -
>  	ret = perf_pmu_register(&rapl_pmus->pmu, "power", -1);
>  	if (ret)
> -		goto out1;
> +		goto out;
>  
>  	rapl_advertise();
>  	return 0;
>  
> -out1:
> -	cpuhp_remove_state(CPUHP_AP_PERF_X86_RAPL_ONLINE);
>  out:
>  	pr_warn("Initialization failed (%d), disabled\n", ret);
>  	cleanup_rapl_pmus();
> @@ -919,7 +842,6 @@ module_init(rapl_pmu_init);
>  
>  static void __exit intel_rapl_exit(void)
>  {
> -	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_RAPL_ONLINE);
>  	perf_pmu_unregister(&rapl_pmus->pmu);
>  	cleanup_rapl_pmus();
>  }
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 2361ed4d2b15..37a9afffb59e 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -208,7 +208,6 @@ enum cpuhp_state {
>  	CPUHP_AP_PERF_X86_UNCORE_ONLINE,
>  	CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE,
>  	CPUHP_AP_PERF_X86_AMD_POWER_ONLINE,
> -	CPUHP_AP_PERF_X86_RAPL_ONLINE,
>  	CPUHP_AP_PERF_S390_CF_ONLINE,
>  	CPUHP_AP_PERF_S390_SF_ONLINE,
>  	CPUHP_AP_PERF_ARM_CCI_ONLINE,

