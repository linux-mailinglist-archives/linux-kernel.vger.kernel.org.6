Return-Path: <linux-kernel+bounces-445076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D2E9F10E1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D772D283583
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04F11E25F8;
	Fri, 13 Dec 2024 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SXSx8HAN"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BE11E105B;
	Fri, 13 Dec 2024 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103456; cv=fail; b=o1yCsVC0e8L3ff1EIfdV9zmc462BMFtrq+7v6GY6CughJXcIXlBdgi10GaxyWrMtuHWPWbQTHNTLMdGJ02usbMYlrUq1/3DnncCG4z8h6xa3OLF5FcwPzRWV8xNtRXthhOFZCzYDS/L6goxsJtbfwB7D45Ysg1rBs+/fRMuJth8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103456; c=relaxed/simple;
	bh=keRdJ2dJWCLS9LBMPbOqoCyle2PVT75lqXU+nFN5KLw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d9e4gCYbsDchHgY4xu9eFhSF+gDH4uYfKCSViyq+YMiUlhFy7QfePHVpOLFfiCaJwieHh+pZnX2xOcjKq0cj4DrpHJg7dEUwn+WUc9akiun4BkPHhajhx8zil9yZdtk0NATN1kjkK1n63mhcO7odFgOkvymuWP4S/DhC/Po98yE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SXSx8HAN; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJNUGgszUPqT9ElDU9YP0D6FiHy4j/VHiuKS2otpcNHsRWzhElKAGB62F0vYLzfkd0auoFeCAtvZKtYOcWbatlSZixbyqsqRWMn2NYmOuZohGtQNR9NlsWlsiPOOhVQK6BNFLOu2Yd7IjcEVjeWF38b69winI/vqoV5UBMiDOqcZbFVwzoHK1ewTixfvNJ5qcUgs+xbUUyczSZ44Mx/GwrWSDFaaJtYSsy21Rf8SNPEBax7n2mv+E5BkRvYhKS0G+8WpmmOTN0pjzlSb3UJl3LhCqF+8hakefxQTo+sn5wHS0fJ6Czih6hv9cDBPNxgBp/hYYFrEvCyqcWSIpHfpnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LznOmYb+Rp6i6jA6UDUD5wqCmnhJrVvjCbzIOYaBGYM=;
 b=NGDLmHok35W2VwxvgBD5EaGYsxAbuh3B6F7LIqqb5M6gwV2kiEVC7lijcBS0khs3iaPpqzj5Sswn5muJ9HyPT6hZCRTh781xVKmfzVpOdU/XEy4zMl6HhOfUbclCyRHk4nsSJTwvANWnW8yqf/+/ue5MYEQHSbY8HnweHNI6gk+v3UdYkykigO3eH094LwiMUCJvSnzio0/As0fDYbSkC5qHYWc1z0EIeqibFmRT0bC6JHnNXHpmWhX9VJXAqPjYSLOpnWGURiBr0TGnpixPaSiu+X4bUDZM24eqEEyL5hddTYdThQcArU6LajW8NQxPbOZayGhAC+IP7xR7rouwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LznOmYb+Rp6i6jA6UDUD5wqCmnhJrVvjCbzIOYaBGYM=;
 b=SXSx8HANowkZ7qQ5L3vmH01RfzjfOvORnksNLtOL3E/1XPEPX4It1xG1/knrsuTyvKPc7tQKThPHc9NvnUodUSWtA4bIGyMch6VvL08ZWhLWVEFukU8xkbPGlMqa2F/9tVa8ezbuQSei/RhV8wFteiosqp44lm1tcmp42cRxWLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 15:24:10 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 15:24:10 +0000
Message-ID: <59b8c9e5-4394-4715-b9e2-90f99d4921fd@amd.com>
Date: Fri, 13 Dec 2024 09:23:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 23/24] x86/resctrl: Introduce interface to list
 assignment states of all the groups
To: "Luck, Tony" <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 peternewman@google.com, fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
 rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, andipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1734034524.git.babu.moger@amd.com>
 <865b7f067bd0a1e90a07950fc4edce8dcf1c99e1.1734034524.git.babu.moger@amd.com>
 <Z1tqQaflpkcGRVzx@agluck-desk3>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <Z1tqQaflpkcGRVzx@agluck-desk3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0015.namprd05.prod.outlook.com
 (2603:10b6:803:40::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: b49b00df-766a-4058-e5e8-08dd1b8a315f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFNwVzlkLzRVMWhrVWNPM1ljUXJBOUl3eHFtdExQM3g1UTRUUndpbVFMYmZ2?=
 =?utf-8?B?dGF0RnpEdkkyaGhhUGhOSmZJTnVQOFZtRlZlRElLWFgyS3hZQ25LRVVDbjFU?=
 =?utf-8?B?ZTRJWmUwYzd3Z05xcmI1NzkrQmt6algxcm5sUXR3M1NmYW84MlF1N0ZSNTZx?=
 =?utf-8?B?bGx4Yyt2YzB6TnMwR0pMSVIwL2JicEowTklCL080Rk5JZDFFb21vRDRNcVNS?=
 =?utf-8?B?WkxWRWk2ZEF2UHdqRWdMVllkSkFFLzJwOHlNOEpCZUV3T29xNUZYalRIaDgw?=
 =?utf-8?B?cUdPU0RtdEFuOUFZVkFRZFIxRlRuTWY4ZEt4OFhKYlVTZE1tdm1zTzVUSENL?=
 =?utf-8?B?RFR6SUZtRXAxU0w2THpFL2NuNWdwODVOWDZ0N0FYc04rQk84UXVKaEpjbEVL?=
 =?utf-8?B?aEE1c0RtaVNEYlVGZVV2ZUNaU0dKTElVdTNVNEZyRGdESUw0aDdtOGExdDVE?=
 =?utf-8?B?bGJDVWh0UWx1ek1iT0hiSlZONmlOWXdXMnRoblN0VHl0N01qZVV1d052ckhW?=
 =?utf-8?B?NTl3NThjdVBVdStuQ2ZkMkU2UzcxQ0plbE5pQTVTMDFVT3BBU3lYekp3aEtk?=
 =?utf-8?B?TmxXRE5MaytqMXplQkRweHVTNHdvanFidEQxeUNJenhROGFRNGN4bFlaNUdt?=
 =?utf-8?B?ZVJPNjdWaDM5MWlnRXNDN2p5Q3NoWisrWUdJSkl2cG9LMW03amExRm15TENw?=
 =?utf-8?B?SDBPaW53Wk9JSjQ1ZmROQWxtR1hicjFPRHBxL0MxVU5OMHFnMnFqUE5jVzJL?=
 =?utf-8?B?SUdlUDVVR0NXNnpKbHZzM2t1MlVLWjUwRi91c2xYQVVNSVBpY21sR2VPeURs?=
 =?utf-8?B?eFJEdWljTGx4dWtJbDBGMDdZcGRxUjQ1UGhYaXRBbEV1WXI5bm9BWXB3c3hL?=
 =?utf-8?B?RUVoOEhDQzZVN1Qxd2dCTnNBNkQ3QTBIblNzOEI3ZEhBNnRJNE5XeVo0Y2RR?=
 =?utf-8?B?KzRmWGYwbEVoUU9Zb1VUZ2FjajlUSS9tc080UEwyT3BIamlGcGtvM3dZL1Ux?=
 =?utf-8?B?QlN3anlRM0x0aWtxaXlBN09jSzNSSGVobWxCWm45MGZCTkpzaUxwaGJuYTdJ?=
 =?utf-8?B?bUo0aXVvWEx6bnlzVWRITlV1YXN3REtHMXoySStrcUdNTy8xZ3IwVVlTQVhB?=
 =?utf-8?B?cWY1dU9JK01JTFo1bi8vTC9kekFra09DZ1pjY21STnlZRVI4YWIycDQyS2lr?=
 =?utf-8?B?T3F1eGN1N3VMTHBmaTZzdFdTT3QzcXJ1SlJpUlNuSVpLTmlKdndDSk90ZVJ0?=
 =?utf-8?B?MjBIU05MRnY3b2pHaENNZVZPZkx4MXhHeXV2TkwwNlVsTVg3eUh0c3dmbzND?=
 =?utf-8?B?Q2Y5RVcrOFMwNnRZWFF3V3hkaWtLOW8xRlNxRmxRMzhtb0hCOFhEQWxvaGhr?=
 =?utf-8?B?MVNrYnZGUXZKcEx5S29ZSVA4dmdLcllDa1RJMndYQXU0R2M2c0JRSDQ0VUZm?=
 =?utf-8?B?T0orUXl0aFo1Zzl2dW15WUIrME1PZHFwK29BdlRPWEV3NjZtellaclYyNy9i?=
 =?utf-8?B?S3pJZHVVU3VZb2hSN0xmL1lIUGZHRml5eFlrbmZXVXRiS0lWV0xZdzZGQ1pV?=
 =?utf-8?B?YXZpVzN3eTdnV2c3QWtMUkM1Z29NdnVvSmJHbTJ6VkJOTERkVDBQeDFoY0s1?=
 =?utf-8?B?UkRqSXhZa2dqVHNCQXZNc3d5OXRlV1hFQ3U5N0ZkeTgxbWF4N1RHWEQ1cGhj?=
 =?utf-8?B?QXpZemN3Y3Mvc28vZEoxV1l5SkEzQTRnUVhJUm9JalpvTEhzNkRXL3QvcUg0?=
 =?utf-8?B?SUlZRkJ2OWljbHF3SmpxNkxYT3ZsZkVzaEZRNlVja1hXN2ZyYlJIT3U4TGc1?=
 =?utf-8?B?NlhSa3JCaXp3SU5ETTJaUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWRuY0VVbXJ0a2RCQW5oZHNxYTR6RG9XOVZLeHh1SzhaV1FzcTZVdTNJMmIy?=
 =?utf-8?B?Z0t3andQc05nWkVnaTh3TytLbmlJQ29PYVpOTGIzZXYxTWZJb3dneWFJQjlC?=
 =?utf-8?B?VkwrNW4vckhFS3VwQkg5c0NxM1EyTVgxTmYyWTdQRStHU2REWDArTzVPNEk5?=
 =?utf-8?B?SHNiUGd6dUhTU2ZWenFQVWFDWWEvQ3BMYzgrb3h2Mk9WL1JWcmNFcURBbGo5?=
 =?utf-8?B?L1VqNTBRMEFxOUFzM2dPMTg4YXBQU1d5NVNhYVJmMURlVnFzRndxN05ReVpn?=
 =?utf-8?B?NVJ2K1htZyt3VVdSaGdRUVYvVk5GNWRkdlVuOHdhWlppdEZDUE01K0s5WjdS?=
 =?utf-8?B?Tk5CVCtBbWU1UG5rN2d6U0lGZU81Z2JjUklicm5kdUl2QlZlMWFoL1h3akhZ?=
 =?utf-8?B?Yk4rOWUvTE5XVVFnOXN1YjdvWVlnM2l6Y2l6STA4TVA4bmVOYUNKa2Evckox?=
 =?utf-8?B?SEdJMXBERnhaTFVtZHhyaDVlb1Fud3h3L0ZMNmIrK2NSZVVjZi9aamU3Witu?=
 =?utf-8?B?b1drU3Z5VklTRHo3d1prTTljanBvbzQyUXVjUDkwaHZNZ09FYjBQa05zYld1?=
 =?utf-8?B?THJ5cVJRejhETHY0enI3ZUJzMmNjWXoxUEV1RzRVdTlZdTQyOW1WRUd5K0ov?=
 =?utf-8?B?TDFhdHUzM0lWWUc1c0VvbWJuTVdraUY4VjV0Smt2RHkyK3BwQ0l0SUs2bU8y?=
 =?utf-8?B?OUJIOG9hbnJLK0s4TnBHLzlxdmlEMmIxaEUraUpXaHF4UVordGpXNmtKeG0y?=
 =?utf-8?B?b2trcGZJNTUwTnRvRFdMMFU2b1kyVGFHYmFNMjNsRDJlczNoSTFweHp0MjZo?=
 =?utf-8?B?cEZFYTl0R3h2RCtyWGxPV2pXNkQyY2pEOTludEttU2JsYlc1Uk41bDByTU9T?=
 =?utf-8?B?VzlWWkpBTE5YUTdxTk5QRG4wLzEwLytJREhTWlNheHlNUmN2ZHBTYnFDTmo4?=
 =?utf-8?B?eVg0MGlPTXVxWG1PUlF3a1RCVXEzMDFPcW02bHpTTWlOSHlSbTZsdHc3bUhG?=
 =?utf-8?B?cTAvd2NkTzJVYlU2d1pVejNCTnhPZFhFOWtpVER5RG5qM09BYWRrdW5jZ0Ix?=
 =?utf-8?B?R1hBSkt2NEN5WXNhYW1YL01WOVBrWTBRQllJMDEzODFwZTkvblorREgyQk5l?=
 =?utf-8?B?MFlsUDZPQkY0VHdwVFpxSlhRMnZjOCtGc3ZSWmh0Z2R5R2tkeVc0azhjamhU?=
 =?utf-8?B?QUozZ3puanVnNnJ6cEdFQStGSm1YVzJNYXpTUlJVcU14dTBKRmhvMUxlNmcw?=
 =?utf-8?B?N09udHBRQy9iRVZjWkdBS09KVlRzaFBtdm1pamxYejh3clRiWXZ5OUNFQXVM?=
 =?utf-8?B?R1EyVm5OTWNoM2xQL0F2ckZQaU5JcEppdVYxNTh1ZnVDajlaclh2Zjh5OXY4?=
 =?utf-8?B?QldLenRXMTZHQmNwa1VBTzl0NWpXb1hUU21mcFNYWENKTTJKMmJGK1BTOFph?=
 =?utf-8?B?clZRU2VtSmJ4YU1FVHM1OTBBVkVxOEJOdHB0eHlUSGJGQndVUitwRzBPNnQ2?=
 =?utf-8?B?OHdxRzlreE10c2EvSUt0K1FXNTlOY2V4L1BqSFUwaWVqY3FWL2FwLzlYakRN?=
 =?utf-8?B?dERjakYvQ29MTXQwWENldFlJdFFHL3ljQ2tvZXhCNHBMaHVWbWh2WVgzKzVu?=
 =?utf-8?B?SjdsR1lHanJ3Y3FKNTg2blU3RFhQakxWdmZBZFFVZlRDeUpsVEFpYUhZSnZN?=
 =?utf-8?B?TzlMbWFud2VMVUs5UjIrWFptSGJNR3ZMMXJ1cXdMNE5DR2pNMFkvS0dvU09a?=
 =?utf-8?B?QTNTc1BzaDc3QUtkaVErVUVoeUE5NlgreGRhdE1wTExIL2U2NGNjaWovRGNx?=
 =?utf-8?B?cHNyN0JtWDFyWjZtWUhFMWdUNHRKWUE2SENMd3IwSGQ5bUhXMTd3UDI5Wmlj?=
 =?utf-8?B?TW15RmtmWkkzNVNGQlNPWFpiN3R2VFVVWkxMc2RHK3Z0MnQwTFRubGdTZklQ?=
 =?utf-8?B?WnowblRQZXJHd3lWY0cybUx3YWVJUHBZdnB4SDZYd0hTNW11blplT1JSZkVG?=
 =?utf-8?B?OVhMa2Nna1hoUlQxYUYvOVAxR1I1czdCRHZuUG9nWHlFR3BEZVB5RUc3Q0d4?=
 =?utf-8?B?MTRWSTdJT0pnZGxXaVdjT2NDMnV4bm5Id29lYXQ0MDZ1VGk1V2dxWWY5SjQz?=
 =?utf-8?Q?j/+k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49b00df-766a-4058-e5e8-08dd1b8a315f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:24:10.5983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sP4zEd0A9XV9vRRwk+IusIffsG+2nOWrMkjrP/Q9sMUfayaObHTHJWSW9KwMoNhS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022

Hi Tony,

On 12/12/2024 4:57 PM, Luck, Tony wrote:
> On Thu, Dec 12, 2024 at 02:15:26PM -0600, Babu Moger wrote:
>> +static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
>> +					    struct seq_file *s, void *v)
>> +{
>> +	struct rdt_resource *r = of->kn->parent->priv;
>> +	struct rdt_mon_domain *dom;
>> +	struct rdtgroup *rdtg;
>> +	char str[10];
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rdtgroup_mutex);
>> +	rdt_last_cmd_clear();
>> +
>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
>> +		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");
>> +		mutex_unlock(&rdtgroup_mutex);
>> +		cpus_read_unlock();
>> +		return -EINVAL;
>> +	}
>> +
>> +	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>> +		struct rdtgroup *crg;
>> +
>> +		seq_printf(s, "%s//", rdtg->kn->name);
>> +
>> +		list_for_each_entry(dom, &r->mon_domains, hdr.list)
>> +			seq_printf(s, "%d=%s;", dom->hdr.id,
>> +				   rdtgroup_mon_state_to_str(r, dom, rdtg, str));
>> +		seq_putc(s, '\n');
> 
> Other resctrl files with domain lists use ';' as a separator, not a
> terminator. This code results in:
> 
> //0=tl;1=tl;
> 
> rather than
> 
> //0=tl;1=tl

Agree. Will correct it.

>> +
>> +		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
>> +				    mon.crdtgrp_list) {
>> +			seq_printf(s, "%s/%s/", rdtg->kn->name, crg->kn->name);
>> +
>> +			list_for_each_entry(dom, &r->mon_domains, hdr.list)
>> +				seq_printf(s, "%d=%s;", dom->hdr.id,
>> +					   rdtgroup_mon_state_to_str(r, dom, crg, str));
>> +			seq_putc(s, '\n');
> 
> Ditto.

Sure.

> 
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&rdtgroup_mutex);
>> +	cpus_read_unlock();
>> +	return 0;
>> +}
> 

thanks
Babu

