Return-Path: <linux-kernel+bounces-299713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06F195D914
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 00:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE0B1C222AC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646AB1C8709;
	Fri, 23 Aug 2024 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H3KGQEeo"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E97C191F8F;
	Fri, 23 Aug 2024 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724450777; cv=fail; b=jBdbWTSPssi5fRT7RAW2gdZbEMAgaAhHcxL3u/74qQiSosTLDNHnKYAX2QuAEwhDe0p9gm+KC8xdzFLIPP9zMRSOjChYNNqhajnTxYMBoQ9mfgeWWi/EdQJiqwTV7+7nIhhkmYpBFuKkPQ9tM0BR1i/6S8OR95HwoNFQSuDYRJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724450777; c=relaxed/simple;
	bh=w5G7WgmSpdm9zbAhGqK/A/Z9socqjA8dbcAYZ8KOsT8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i6w7UFn8i7drjlIER5qkMwPDvjbMLLQVBhJjS9CpE+/iZnZnfN8RtI0xfKlAOs0xlWI1tZDqrahCmIro73Lb0e4PL8TCsKRfYTWo+yf78WB63kKcwBY3j/S3fl2+TDrLvGYIpIrzmCayAmg2EtRuHmhpvOimkbYMqK2/iciQ/Go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H3KGQEeo; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tkwx+FzQkh/ppwfz0C0BPv14TcclGA+SkiBOtqam3qQ7ddd0j0ecV8wztUchhwB1XzJxxMZlKI5oEPeR9dASKsdAf7b7EpjjuAiXri8zt5jmh2s7yJO4gNG3uLkPoQN6G9DCvEHaOYo+b1tI/U6HljVRlY4Ll5i1HKH8r+8AMDNc7RVIXrG/rT7PszELmj4rnKrp1X7RBLP0jcp6kJnWhHl8Swd7xa7OCloeOuthLgtrM7CADwcp5kmlzoVnyk/HpCp2OqZXf8rF42ySqsEZnee6g+RbfW4YXnqSv0RzX50FJBcNVwo+OxQrsT+JnkrL8Znt9jQ/wwnzpFrdhJTXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0ET8yuh8yNLMfwh1AWG3zc1S5hlWrulyqO4XHzIZC8=;
 b=X28quWxHANnN6M2m3PQelRlpUK+cUNb13Fb/ablJAVPV2josftSc1UDt+pR4F16QfTeiwGrHDICefXcYYw4RbX14GoZt115U9sMmL+DJ3OLhAgEFYPaL9b1JtPHRSsZVATI1oqaYAOFmay6JMm0g0sOE4fO4KOH0nEizj4N8BJb3wRiWHl6rCMnTPldG/s5sxSgdcsarOrEd/ym5A9RCWTa3c2yGcSS19KxOzppVuuT/xjgIr/m5ZnJENB0bq+DI8ZEz/DLhXHVjPhTcyprZpYtuVgczNNBL6BcUXfP/tqYF6zPV+FMCWEHgikOin9KAbHl0J3s0yqVyp1jiWXRKCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0ET8yuh8yNLMfwh1AWG3zc1S5hlWrulyqO4XHzIZC8=;
 b=H3KGQEeoARLLUEYYKBOxl1Aia39KGLEyFEhFOfeofH7L4Assht78ZJYUSc4MyLtIdUeUMlkP1at7+z9R76aKin2yPcvV9Cg4OaO81rr/TOY5fUa4k/AkEKJuWz7gEsUp8WhOo98LfylpZoXb24v4/9FEknLRs1gwTADrSfexTQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 22:06:12 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 22:06:12 +0000
Message-ID: <f082bba6-6efa-5d3c-5670-d4a24d4fc5da@amd.com>
Date: Fri, 23 Aug 2024 17:05:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 16/22] x86/resctrl: Add the interface to unassign a MBM
 counter
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
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
 <09da6e20b695086558d6cadefbc4830961e6e60b.1722981659.git.babu.moger@amd.com>
 <e2b9bcd1-4b5d-4eb9-8e3c-604a4c5cafe8@intel.com>
 <f4d5ddac-9399-4581-b914-ddebe1824463@amd.com>
 <5e1426cf-f966-447c-8455-88b70ab324d9@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <5e1426cf-f966-447c-8455-88b70ab324d9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CP2PR80CA0263.lamprd80.prod.outlook.com
 (2603:10d6:102:42::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d0b98b-2f92-4156-6922-08dcc3bfccda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dG9UMFZIQWF6OEFENDlqa0E5NTM0Rm5EZGtDbGxXNHNGeFpaM3lNZWJyTEJj?=
 =?utf-8?B?UDhLU3UxTlJ2cHUvY2VBNzIyVC9wS1puenNDN0FmWlFpMXI2Z2lmU1VON2oz?=
 =?utf-8?B?UTBCK3VyMHo1QTd6NkNhQldJV1ozcmtHMGdxTFp5YjBHNmdXTFlVZTVuWkh1?=
 =?utf-8?B?OTVpSmNOZ3NDY1NncDJqdTVWRHFvUFVwK2FoMEJBWXF1bDNLUFlxZmh3RStt?=
 =?utf-8?B?R29lNFl4bUwvUUJZanlmWXpUcjUzTTRaQloxMXgreXhGUU54ZTJtZmFJSDFS?=
 =?utf-8?B?c2dnUnlFcVlCc3lPRnVpWU5KOUxaQ0IraUxiZGgxRUdHcXJiY01ZWUJQZllC?=
 =?utf-8?B?TmcvRTNNa2gzcWZBZGtoS2hrQ3Z3RVkrVmwvQU9sMkJhelVKanoyRUp6TjVY?=
 =?utf-8?B?MmtuVWZvTVltOEkwaWZaK05tdDVmQ1lweEtGVnNmOWNBYTRYY2E1RklIZWxl?=
 =?utf-8?B?Rks2ZHp3bWt4VTVXejlrd016SHNhd2EySFp0YUFYVFRYSVNKVTlnSW1OanI2?=
 =?utf-8?B?SUlpQkZROUVLK0JtWkdGL3Z3a1QzU3VnYU5CRXBuRllkVEFCSThVNlVYRWRT?=
 =?utf-8?B?R3dZSlg3M1d0am9PZ2tRbGkxUndYd1NRZytFQjhJUWx1WFhFYXZiY25KOENX?=
 =?utf-8?B?NjU5QXBvZnA2RWRET3hiT29LMzl4bUJuYXd4eFhZQzJyVXk4YnZHY0J5aGda?=
 =?utf-8?B?bytCVWp5REdBR1p0MjVUMUJEVytRUUlHWXpKV3dwNmpHZkQ5QU54VXdkelFU?=
 =?utf-8?B?ZGwzT1ViWVQyWUJEbmJ6S2N2dVp4bmptSTJib2NvdEs2cGlSZ3hXWVFHY0No?=
 =?utf-8?B?cnI3U3lvNlFVY0ZJMFlPRlFONkhuVGlrS3RwbnZ5RUMzclc1TmF3eDdSM3Iw?=
 =?utf-8?B?K0kvOHJlZk1KQkpRZTlrZitTOER2bDJpNCtpZnZHVittTzI5RDFhMHpBOGFO?=
 =?utf-8?B?ckhGbDhNMTc0Um9FbVp4TkhNN3ArQ01hZ0pSZmZVcGhPM1JWcHRzVE9PZnhM?=
 =?utf-8?B?MVZBaHFuZk5Xell4ZU1xWVhEN1pVZExGb0tBWGxqSlVOV21hbjg4TU5GSERJ?=
 =?utf-8?B?b1kwMEd5eVNoWHpWZklTMFp5SHcyTmZKOFRTdTlwQUlrZUtNU0FoK3VvajIx?=
 =?utf-8?B?Z2haYjBwalRnWXVwVnpsMGMwblVQVzBabWdXbjFYRW9CeDQ5S2JvSjJKTVZX?=
 =?utf-8?B?ejVhQUtXenZ6ckgxcjFXdzFXZ2UxMkRHdXY4WmFhc3hWTDlENFFhMFRjbkNU?=
 =?utf-8?B?Y085S0Qxb1k4VHQwQzVwSVhScHh2T0pSVzhFdzlnWnJla2ZVNjZMa21XdU9n?=
 =?utf-8?B?SHZodEF4TmFWcU8yTWM1WUJjVEVvcU5sOFIwN2pVMzFPSE02RzltRlVIbnI0?=
 =?utf-8?B?aWtUUEZUUGxmcDlJTnNCNFJUS2NIOEdvanVpTUNtZ1Z5T08ybHdWMmx0Ky9m?=
 =?utf-8?B?U1NKZW9zSG1IVEVzUElFZk5LNi9EVW1uSG1zWVExU1RnYlh4dkplaFBtOW5B?=
 =?utf-8?B?NXJQaG5WOVpldnlpTmZBUmdmMkgwT1RqY3phVit4S1RhOUpCdDQwd3BnOXhF?=
 =?utf-8?B?VE9XWXA3c0M1QXhXWEd3aERzVHNwZjZ2Z0MvTHhhamFiOXJxWW9pZDN2a09m?=
 =?utf-8?B?azEwSkxDME0zaWdaY2tMcVhEQUpRZHU4MEE1SlpOeWdibThmMUVVbEF4NXNP?=
 =?utf-8?B?eTFheVdIK0c3VVkzZytoLzFEdkE3ZGs4K001TW5kYUxDVVNsTFpIUHZDaHkz?=
 =?utf-8?B?NzlzUUY3Y3N1OGVKYXdaa1NKUTl5dkNwTVg4aDhaZk0vTEtJRlFaeS9mcys5?=
 =?utf-8?Q?8sfLCFvSetUV4SBmbPN1Mm+E44b8PbrY/uHPU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T01BOTRLeFM2akxHMyt1T3RjdU5MVkt3cDduakhoZXZROXRxNGgrSWViSThu?=
 =?utf-8?B?K2NZTW1nWjRjaGJUbnhrS0xVMmx0YzZDemJVWjk5cFlGcVJmRkNYTEM3Q1ho?=
 =?utf-8?B?VmJXQWdMVzhrazBEaVgveEc4V1Y5eVQ3aHBSUGN6bEY0Lzh3UjdxbVVNL1Vy?=
 =?utf-8?B?akFiYllRWWZxQURGc2hZRXFsU0hTd2l2Z3dXOTFMeFJNYUp4a3l3ZTBxTkJo?=
 =?utf-8?B?V1dzRlBMcGx3ekdKeHNiQWlXSVBnQ2FwYzdFL2tnYlpGU01TcEhFUjd4U3hy?=
 =?utf-8?B?b1AzamJYV1BCZGpCVkZrdWFWYXRXVlpFVzRaV0dDRjlmTzJIeDhWMnNLL2Iv?=
 =?utf-8?B?ckZaY2tZU0oycElCak1hQ2xJNXpyWTlFMTlxZ1VqUHlSNTVhcmV6cldueEF3?=
 =?utf-8?B?eGU5OFYzOGJQdG8xWEsvbHA4OGxTbksya1UxRXNFUnFrSzl5cEExV3hKalJj?=
 =?utf-8?B?Tnk4RlVld2gzTllRK25Dblp5d1lJZGhDYWJYSTNIa293Vk5hellGTm5oS0Zj?=
 =?utf-8?B?SGwxQzM2L0pXRy9BaHNGbkxiYlJGcEpIODFKVGFzNm0wOWJmZ09QMmdqVTRm?=
 =?utf-8?B?MU9ONVcyNHJzRUZEbTh4TU1vc1lrVys3eGJZblNVQkprYUtXS0FJRTZ5Z1NH?=
 =?utf-8?B?VzZpNStNSFF6dTJFd1U1N0pvaG9qajIwemJhZTY5cG5YVlBqS3BxbHZ5aVRw?=
 =?utf-8?B?NlVPUEVuRHdYNW9DTi92NUxWTFBaRWtwMDdIaWc1QUpHYWxoN3NLZFIvRHYz?=
 =?utf-8?B?c051ejZRZWFZUFlpcVFKSWdhd0VGTFhiWk1uZTlEb3kxTFVrTnZXbnlBNEli?=
 =?utf-8?B?RUxRaS9JVFVXMDJPNytTZTNpckFISHlpVUZZVFp3WkZkL2pNYVI2UWZPTG81?=
 =?utf-8?B?cE5DdWdMMHpVZUxrQ1BDTWQwN3NMSEZ2SUJITGlmemgxNGU3bndGaFZXcGpo?=
 =?utf-8?B?QzZ0eEFWVy9sS1B5RVFpeE9adTlkeDNUd3I1cXI4bUJ1aWhYbFU5SXhQYUNu?=
 =?utf-8?B?eUVXUXZTNU5LVmZ3eGcxS2srUW5ib2N5VjlsU1o3d1A1S2x0WHdTQVhiMTJL?=
 =?utf-8?B?MGRURkF0dXREYWhYVzNRbnEvd0hpK1VkZ1JYSi83MXNZNmpsTGw4eTB5NjNH?=
 =?utf-8?B?U0tkWmtWVmVWYno0RG1ldk13UVNaWGNmMlUwb005YjdLM0pFclRoOUw4TllJ?=
 =?utf-8?B?V2dlbmRDMG91eHhtMldablk3QkxrelU0TjBkWGh0Si9UWldXM1I2TTZxYkk2?=
 =?utf-8?B?dTFJRjVPRGFaWklKcVZmWDdQcDhFUklhQ2hzVnFpWFQ3YTVnVW1hSlJCOG5h?=
 =?utf-8?B?OE5EL3gxbVJ1c2orTDBZN2xuRW9aSmlHTnR2NlROTWFPR0lCUHFpcGRCd0cw?=
 =?utf-8?B?TWY2bFZVUXhWQ0FLU0tLajl2RDBpWVNjVDg1dytvanhpdVJCRmZZY3YrNmFZ?=
 =?utf-8?B?MTcxY0R0d1FBbWlqV3UxUTUzMCt5NkU2MGhoSUsweklERGZ5VDNpS0dmSSs5?=
 =?utf-8?B?b3gvdGI1d3hYNkswOW04aGR1dGU5bjhZaGVVemxhSElOSWlhU0loaHBGWXhP?=
 =?utf-8?B?SmlqSERMSWxlVmIrRVk2TXA1bFZqOXFDdXlxcDBGRVNUQjZJV2xtNHlDUzA4?=
 =?utf-8?B?djNJUmJ0emhhcnVOSnpqeUJmOEJDeGZhU3Fpa1ZKdE1oN0h6R3F0cXZ3bjJD?=
 =?utf-8?B?bnBSeU1BaDlsZDE3RlFmOUhTaXJKQ3NkeXNVVzlHd05NUU9URC9sazYzengz?=
 =?utf-8?B?cUlia1J1bk5idTZMMTNhQ1FWSnVBbE02R3dyckkvMi9ySnVvcTNHcVE3TXZ1?=
 =?utf-8?B?Rm9UYjFrTE1PcmV5OVhmd2cwcU5zdXFwVHdHQ2JMNUs0OFFoRVh0d0pEVity?=
 =?utf-8?B?d3Q2b2VBd3JNc2I5MnMwWXBnQ0g0VXZ3ajFxQmdhdWtGZ0NFMUJ0UHQ5enpJ?=
 =?utf-8?B?UmpXZ2U5L21mY2x6RUJrRVZ5aWJOemhpa1J1aWYrbmdiMS80ZEFveXEvZUwy?=
 =?utf-8?B?SXhPTDFIR3FiU21Rd0tZcENZb2syL1k4dlBVaFFjZ3N4UGJtYkY5REFXTGdm?=
 =?utf-8?B?bjNWMHpFeGNMT1pDWG9KR2hlRDhXdk1JUG5QRXdsaXNUWUhnUnZsZ1A4Ykxl?=
 =?utf-8?Q?qZhu/qxBYmYbi+XQFe0Z7q+7L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d0b98b-2f92-4156-6922-08dcc3bfccda
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 22:06:12.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 929U3wcxcvDljb4iqMJWXD/SCrSMlt7l2/Aj8Rqfj+cVkZWXzquH5lkVjXjF+u6x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736

Hi Reinette,

On 8/23/2024 3:18 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/21/24 9:01 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 8/16/24 16:41, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 8/6/24 3:00 PM, Babu Moger wrote:
>>>> The ABMC feature provides an option to the user to assign a hardware
>>>
>>> This is about resctrl fs so "The ABMC feature" -> "mbm_cntr_assign mode"
>>
>> Sure.
>>
>>> (please check whole series).
>>
>> Sure.
>>
>>>
>>>> counter to an RMID and monitor the bandwidth as long as it is assigned.
>>>> The assigned RMID will be tracked by the hardware until the user 
>>>> unassigns
>>>> it manually.
>>>>
>>>> Hardware provides only limited number of counters. If the system 
>>>> runs out
>>>> of assignable counters, kernel will display an error when a new 
>>>> assignment
>>>> is requested. Users need to unassign a already assigned counter to make
>>>> space for new assignment.
>>>>
>>>> Provide the interface to unassign the counter ids from the group. 
>>>> Free the
>>>> counter if it is not assigned in any of the domains.
>>>>
>>>> The feature details are documented in the APM listed below [1].
>>>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>>>       Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable
>>>> Bandwidth
>>>>       Monitoring (ABMC).
>>>>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>> v6: Removed mbm_cntr_free from this patch.
>>>>       Added counter test in all the domains and free if it is not
>>>> assigned to
>>>>       any domains.
>>>>
>>>> v5: Few name changes to match cntr_id.
>>>>       Changed the function names to
>>>>       rdtgroup_unassign_cntr
>>>>       More comments on commit log.
>>>>
>>>> v4: Added domain specific unassign feature.
>>>>       Few name changes.
>>>>
>>>> v3: Removed the static from the prototype of rdtgroup_unassign_abmc.
>>>>       The function is not called directly from user anymore. These
>>>>       changes are related to global assignment interface.
>>>>
>>>> v2: No changes.
>>>> ---
>>>>    arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>>>>    arch/x86/kernel/cpu/resctrl/rdtgroup.c | 52 
>>>> ++++++++++++++++++++++++++
>>>>    2 files changed, 54 insertions(+)
>>>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>>>> b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> index 4e8109dee174..cc832955b787 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> @@ -689,6 +689,8 @@ int resctrl_arch_assign_cntr(struct rdt_mon_domain
>>>> *d, enum resctrl_event_id evt
>>>>                     u32 rmid, u32 cntr_id, u32 closid, bool assign);
>>>>    int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, enum
>>>> resctrl_event_id evtid);
>>>>    int rdtgroup_alloc_cntr(struct rdtgroup *rdtgrp, int index);
>>>> +int rdtgroup_unassign_cntr(struct rdtgroup *rdtgrp, enum
>>>> resctrl_event_id evtid);
>>>> +void rdtgroup_free_cntr(struct rdt_resource *r, struct rdtgroup
>>>> *rdtgrp, int index);
>>>>    void rdt_staged_configs_clear(void);
>>>>    bool closid_allocated(unsigned int closid);
>>>>    int resctrl_find_cleanest_closid(void);
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> index 1ee91a7293a8..0c2215dbd497 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> @@ -1961,6 +1961,58 @@ int rdtgroup_assign_cntr(struct rdtgroup 
>>>> *rdtgrp,
>>>> enum resctrl_event_id evtid)
>>>>        return 0;
>>>>    }
>>>>    +static int rdtgroup_mbm_cntr_test(struct rdt_resource *r, u32 
>>>> cntr_id)
>>>
>>> Could "test" be replaced with something more specific about what is 
>>> tested?
>>> for example, "rdtgroup_mbm_cntr_is_assigned()" or something better? The
>>
>> Yes. We can do that.
>>
>>> function
>>> looks like a good candidate for returning a bool.
>>
>> Sure.
>>>
>>> Is this function needed though? (more below)
>>
>> Yes. It is required. It is called from two places
>> (rdtgroup_unassign_update and rdtgroup_unassign_cntr).
>>
>> We can open code in rdtgroup_unassign_cntr. But we can't do that in
>> rdtgroup_unassign_update. But, I will check again for sure.
> 
> Similar to rdtgroup_assign_cntr() and rdtgroup_assign_update() discussed
> in previous patch, it also looks like rdtgroup_unassign_cntr() and
> rdtgroup_unassign_update() can be merged.

Yes. We can do that. Thanks

-- 
- Babu Moger

