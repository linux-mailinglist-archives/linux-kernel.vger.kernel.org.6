Return-Path: <linux-kernel+bounces-176036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BBB8C2909
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7FD1C224FC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D5317995;
	Fri, 10 May 2024 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y3ioiIrf"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC61FB4;
	Fri, 10 May 2024 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715360510; cv=fail; b=Bmq6W6kCbIPmsgcNBZxIURkLCWhSgBA5gq/uTIuVEpu8upUClu2cMX0KOolZyLro3fDXyeYkp9vftbfxB8m+8KxT7fWIJX+IM4wELhnRn+R5jqHSc/JAe0RZyXt2zsRW7O9g4eJkop4bqPVXc9GyW/Edi7Ebk8RwLwcyKniQzos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715360510; c=relaxed/simple;
	bh=Hxo25Wof9xbTXe1e7TvgEQJOuqR0znITfrJqZEOed5g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P/ZhXpBoI3Jlesmo8dxD7Uo37DUoNIJDHESHKgOAaUENh9am8mshiY43b5wTu6qTjKx3Wsa88xzSZbb7Jor8BeklgaczoAW1OrNo/XOuVlz+iO7bOyQBeizbPAN8+rhTVcWRu8bUelmYUwuoqPFPNihzz1IfUraHx/RaHbLFuUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y3ioiIrf; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5MRG963BBfsayYMdUmMSMcKNa1r4oqZpWfFbhqfwLeXl3W56rsoPnzBbibRIIAMN24JAQMhTuBmnwEzgmURkNNWRJfqFTD52XkLivPNShHb7o3ARt/a00RNW74g1gmAzBkKpcahhywr4RB3R+vhDA/UG27CDqmDTXGgPU+r4PkcYFykqGoKjgo/fckxMPEQh6el7pqCTlamaFR23Sak766NOuXw3rOqo+obb9odl7/hEwmX9j6LV1VNfxT/hBLo9/+5pu1dXLIcHrMX9Y1mzCAXTCp91JDyjx4bYgIgQC9AaNuxf8OOMuW3tWyZlQE5gb1Y1jsE++2w0jQocMfpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NteStXBRpP15Dm4cwqjTm71WAGszn4y/PyNLLC3qnhs=;
 b=g0jbO1ri+sZW0W1O7QsVGq0C8nuQzAVX11vNKbQ0iArmnD0iAI0f/IOwjoAMekU0gtU4G/qL2BLAuxE7MMXO7Qt0oOQpnD7+UCgau/77QSnLlQS/36gKRG4uv8JzachBGLoyviT+OWnNIaw0Z8k9pp+X2yya4b53oZ3A0Gr8G+U4cfGokFmEphz2ypzlkUzjUokyMZ2gXF/4QzYSiYrAGkTD8IgxRO86dw2zrmhOxUsLfPfoDTug2WEoFRwJf74MVSpgiHACn1ijK3CTd+u//sLnJt5WzRa/5afS12C7H+wQg3AaTWGoptZUcyfMq/MzmgKhe2ro+aORRqisKP8n8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NteStXBRpP15Dm4cwqjTm71WAGszn4y/PyNLLC3qnhs=;
 b=Y3ioiIrf+6Msn0dvMn5lTV4UXQSI8YfzxeOxNh/V6XnoaEUhM0BplnKh9AcnLZGKB3vhgphxXqO/xRVWkNYoPS5lB+ZD8BUGs7Axh/k3fwxus92Ant8tAK1ePvMyxPuB/aJ+nzhRkHH0+p96gSkY6rgvrUcoidPnnFvcEGaY4i4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 17:01:46 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 17:01:45 +0000
Message-ID: <4363899d-2203-5829-9074-beb6c0e583b6@amd.com>
Date: Fri, 10 May 2024 12:01:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 03/17] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
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
References: <cover.1711674410.git.babu.moger@amd.com>
 <63134ddf18208bbd11bcec0ec75c33ef6e5635b2.1711674410.git.babu.moger@amd.com>
 <ac22b96d-c4bb-42d9-bac8-22b9e032b59e@intel.com>
 <80b33bc6-7b70-4853-92a0-718c2d8728d3@amd.com>
 <753844b6-b68d-4b05-89b0-3ac36e1c8564@intel.com>
 <be20ffe1-ef8c-41fa-b359-9ebfaa326ebc@amd.com>
 <50d006e0-8488-4579-ab4e-701e1a8f410a@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <50d006e0-8488-4579-ab4e-701e1a8f410a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:806:20::7) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d85f28-b478-4fe4-7d7a-08dc7112dfa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTcvaGRzc1VxdXVETklpM1lOSjk4dW02L0dEZzBueVVKeDBya1pnTHB6Mklv?=
 =?utf-8?B?VDZGTzRtNFE2czVpeGtQbnAvYlA1L2doSVRkRk1uTU5WQ2ZCK05vUU95ek5X?=
 =?utf-8?B?OUpsUXpSQXZRK213WWZ4SnZFQnpoVTRKY0wvblFiRlRxSklQcDdLRWxnNTNC?=
 =?utf-8?B?bXl6eTh3Nkt5TDRvbm4zQ2ZYUEVVa3JyVUcrb3g3MUVLVU9YT0l2QXNGV1V1?=
 =?utf-8?B?YTdMQVppaWtTalMwS29xVW14aHlNc1BwREU5d1BSS2lXWC94eTZrbzJwOExa?=
 =?utf-8?B?bDFrZVIreDdRUDJhalhhRkRLMmVTYUl2VGdvbENqRU1iS09nOVhqSVZHR0N2?=
 =?utf-8?B?dnI5UUYzcVFTOW5aRmxkUjZwT3ZvNEJhOG12V2l0bUg0VExVdHVYb1hUUjl1?=
 =?utf-8?B?ZVprY1QybWI0Sjczc0doQjNyYVN3QkpPZHhQbXkrbUxhczBBVnU1UTQyTW5x?=
 =?utf-8?B?TC80V09JT3A2UU54WFkxRUpoMjRjY09vcElrRGFHR2FuSjdwVENUVU1sdW15?=
 =?utf-8?B?empJcSs0WUpYZWwvaWsybUpRTVRpUW9oSktycXl5bSsrVXp0b0lyZnZJNFlE?=
 =?utf-8?B?UFFTRUpjeUVuYzMvMFRlRFdHdzN4RlpYSVo3c2hkbDFJVEpHV2I4WjBKcWtY?=
 =?utf-8?B?YkdweXNwS1IydUw4ODBZdEVwWXlHYkFJWko2SklFNG95RTdFNmhGMFlxM1Nt?=
 =?utf-8?B?UXpuVTQ5M1drQkY5M29lY0hLZndxV1BIUjliQWo5a1MrcU1VOUFFTU44M1pr?=
 =?utf-8?B?YW54MG5mUGFNN1p0eTUwaldpcExZUGR6VE4xdGpHWUVZeEtrZ0JmaGk2VVhU?=
 =?utf-8?B?aXJrbFpadUdqaXpOTXNKRTBnbmtwZ3lFbGdvMXNXMjdXT0tQNm9ycEcrTHpS?=
 =?utf-8?B?a0ppQlRia0t4U2tmRC83SnhUaUZzYUZObXhac2ZPR1l5Tjc4UVpvNEgzMG1T?=
 =?utf-8?B?emNCMjRYT2JXTC9yYW8rejFiTlJLUVl1ZHZHR2R2Uk5vU3pjNVVWdHBhcVhu?=
 =?utf-8?B?b0M0aU9tL2haaVlJdVBBQnlIRE9vbTBxMVc2UFNhOFBObnQxb0tKZCtzWUJz?=
 =?utf-8?B?TnBzWlE3UTFzbzhwNE1yZGJrVkpxN0lKUXNaU0c3NU1Ud0diNk9NbDdiaFMv?=
 =?utf-8?B?S05wLzc0S0hXRXRHUTNzanFKZXluRGtIQW5nNVlUaVBYanRtWjVYOTdtVzFQ?=
 =?utf-8?B?Q0VnVm1XczJIdDQ0ekJmdGU2MWE2OEVJa3RpdnRYNUt2SnozWDFldXJweFdL?=
 =?utf-8?B?Qzg1eHpnNVVBanQ2K095S0RaQzU5T1JnamIwNmFhdU1lQjcwZnV4SVFPY2cr?=
 =?utf-8?B?eUpaaUkxZU56T1pvRXNFd0NLVmhCL29IaitncW04NWN5U0x4eVR5WWx5a0FD?=
 =?utf-8?B?OU14bkRGc0Q1ZUlORHJZaWNnZ05HNGswMWtFc2tSdTJCSWlFaTB3L1hCclF0?=
 =?utf-8?B?WkdhS3EybVkrVUlqS0Rrd085b0QwK0pqVytxek9vOXpDYVByNlpqVGwwVVlv?=
 =?utf-8?B?TWk3VmNlQU5qWHpPa3Qrdmd4SVh5MjI5eGZnMG1IMlVLcjkxRVl0TENyK3Mx?=
 =?utf-8?B?NjJiVS8xdWZ1dnlmNHhUeTdjdVpxUjhpclc3ekdjQ3Q4Y0M4WlZHay85VFMr?=
 =?utf-8?B?L0JRTC90T09wYjk4VGNBSXluOC9nbHorRDFLSmVLOVZGUU5FVEhSZXhWZFV5?=
 =?utf-8?B?dUJCcG9JcStlY0p5Y3U1TDR4bmdBMTl5WVRuZFcvQm9TZnJxSEdoTytBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3p5ZmpETzNmaElGYmc3S0s5QmJ2ei8wbldaWnNVRzNwT21WMVpubWJPeGlG?=
 =?utf-8?B?MFNzZjFDbDFoUHVhQUp1YkhlWnJiOHRvbmhKQkhTeXNEUWoyZFNWak04MTNT?=
 =?utf-8?B?TFdOQWdvN3l6bkw1eEtVSkpCVTRLQ0JkdGNJWVQzeGd3KzdUZWZXVm5veHVt?=
 =?utf-8?B?SCtzTkMrM1lCdGZKa1B2cWZaelAvMDA5Q2xCZjFweW1tTER0Z0pmQ0tUUktx?=
 =?utf-8?B?NWtjUGgzQ3g1M1dOeTNRVW51VzR1YVl3Q0VUa3dmYkVJdFF1ZkhTZENvRmZF?=
 =?utf-8?B?V3hMT0lwaFlHck15UnkybEFWTTBUQzZOaGNlcjR4THh5Vm5pMnd1QnBRdlFN?=
 =?utf-8?B?VUF6YVd5cDZVdVhkTWtIWXU3bzFZdGxuOVVraEdybjUwVDErZUxJNThyNHNH?=
 =?utf-8?B?NS95SWkxR004eEtDRUJGd1lTSEJKU1NISjBiT1BsWkM4VndmY09Ja250NmU4?=
 =?utf-8?B?NEtNaVZWYnJBUmhFMFViVGlSMjk2YXhVcUNkc0docHJldmFCUlRxekdaNnBr?=
 =?utf-8?B?NlVvazdnNlI5bzVGQkIrWlAvSFNCb0RpYVFsNUlxV3MzcG9UTzY0RkZyRWdj?=
 =?utf-8?B?YVJETnIyS3o4WnNycXRIR1VuK1prbzhmeXhzR2R4WDVoblBuZEZrOVY2RUhF?=
 =?utf-8?B?YXRLL0VpS3dMUDQ5MU9jelA5dy9vNVZhSENJNDlBbTJNMUdXT3orZkxBYkM3?=
 =?utf-8?B?UXdjTHJqZW5BREkxRkZqTTlTQ3RnY2lSMkQxWExqWWFySHcyOGtNZU9DWjZS?=
 =?utf-8?B?elFDT0xSOUtRRmJ6UXFLN2Z1dUlaSWZlTHlzNjcxcEhqc0ppSkxXN1JqQ09B?=
 =?utf-8?B?OEhoMFVNbmZOaWVZYWJFaXN4NzdnVXU3V0NheGQycmZDbjZpL1Fub2tMOERi?=
 =?utf-8?B?ZG5XQW5JekV3SUdEUDZoczZqMVlJcTRWNnZaS01qMzFxQWkrN2NkamZ0Ylhv?=
 =?utf-8?B?Q2V3UjVTVnVlUlhvTzNkcUFTaWZYSURDemFxaEJ4dnE3YnVhS0tnZlJQQ0sr?=
 =?utf-8?B?V1JncGZnM2pVWHFEUEhKSlVEZmFidEUvcERrUGkyT2UwMXd6dlZTZnZwN21C?=
 =?utf-8?B?bGMxN2h0MUNtN01HRFFsWlNXMEJiRXFXNmxBZ1hUa3dzVjJVN2UrQ3ZVNnhM?=
 =?utf-8?B?Mk5kbGxOZmhPbUlndFNCT1NWSVVDdGdMM1dpeE95RXlRREFnZzQyeENXVDlp?=
 =?utf-8?B?N2JCeHF0MS9NS0EvZkZLb09YQ1VSaisrRXBKZ0lGUTA1WFkyNk9pT1Y3NVN6?=
 =?utf-8?B?ZGljRDluSEY0NTUrNzlUcGtVdEQzdVlMczJDS1BxMXFJcjYxbXNWZWp2ejZM?=
 =?utf-8?B?ODlETFg4bldVeXJDSWV3dkdGN1JWNU04Rm9RclJyNHY1eW1wQlRxakVrOUNG?=
 =?utf-8?B?aWRiaGJJZFN3ZHZBNXZOY3lHanpVZnB4ZU1aMTA1anZyUjRndkcxOFE5L3l4?=
 =?utf-8?B?VktWdUp0QXQ1RGVIanpGN1lKVFZWMDNmVEZvWGRtUzdyR0Z2T3VSQ3ZLdkNs?=
 =?utf-8?B?eVEwWjZuUzllZWM3cmpKYUJXdXBDMHM5RmE1b3R3dm5sZWJ3V08zMytsMnl1?=
 =?utf-8?B?SlZHZU1UcUVzNUVZTHRCdW1DZkhrdHJmL0dLSnR5NFZEQitqSGlxaFNpVVVG?=
 =?utf-8?B?eW9BSm5tUXpadEJHNjJud09UVGdSbXhwSHdJanRCQkhXWHFIWlJyL1o2WCtw?=
 =?utf-8?B?Sk1VNktFK1JxTEVHcWpNc1JQakFQTDBLSHdObWRBT0trWFllZFUvQXJHZ2dp?=
 =?utf-8?B?YktDeVNtQjNmOFFCN2NneUlEWUNLakxTOVh5Z2FzdVlrMVkxWGVtakl5bmFH?=
 =?utf-8?B?ZVphY2p6eUVsKzY0VzRiVktDaFQzR3IwRnFSa1RNZzJhdVEzangzWTV4RldZ?=
 =?utf-8?B?Vm82U1VQdDd5ZFRoQlFrUFB2UDVZU2Q0ZFIyeG5ZRmdFclRTM1V4Q09CQ0hs?=
 =?utf-8?B?bC9uUmtBT2llR2FzL3c3clR5SnJLWkNjcU9pT1o5YytBRWdaUnh1R2FFYWsx?=
 =?utf-8?B?Umx4bm44MXNhZ1RYQm44Mmo5UHFQMlRUZ0ZBRDZaSFFFZFBUUy9GSEtFOVRz?=
 =?utf-8?B?SkxUVWNPOHI3MGsrLzZsMzhkWk0yYzBQcGowamVUbGhuV2NYSk5mTnRCQXNO?=
 =?utf-8?B?bmtsZGZZSnZtbGEwa2wxU1JnYnU3eEVBVG1YVzUydTltN3NGV01YbVh4REhh?=
 =?utf-8?Q?soEwO+Dqc7lVRy9ejBiI0EugLzUzHA/XHPU5MFgSHlaJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d85f28-b478-4fe4-7d7a-08dc7112dfa6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 17:01:45.7643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlolCrGRD+w4L6JZcDDkZdSGlBWN4y8ycc2EeZZ5qbrgRbmLQWINnBKLZR4+JqmI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142

Hi Reinette,

On 5/9/2024 10:18 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/9/2024 3:34 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 5/7/24 15:27, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 5/6/2024 12:09 PM, Moger, Babu wrote:
>>>> On 5/3/24 18:26, Reinette Chatre wrote:
>>>>> On 3/28/2024 6:06 PM, Babu Moger wrote:
>>>
>>> ...
>>>
>>>>>> + * @mbm_assign_cntrs:	Maximum number of assignable counters
>>>>>>    */
>>>>>>   struct rdt_resource {
>>>>>>   	int			rid;
>>>>>> @@ -188,6 +198,8 @@ struct rdt_resource {
>>>>>>   	struct list_head	evt_list;
>>>>>>   	unsigned long		fflags;
>>>>>>   	bool			cdp_capable;
>>>>>> +	bool			mbm_assign_capable;
>>>>>> +	u32                     mbm_assign_cntrs;
>>>>>>   };
>>>>>
>>>>> Please check tabs vs spaces (in this whole series please).
>>>>
>>>> Sure. Will do.
>>>>
>>>>>
>>>>> I'm thinking that a new "MBM specific" struct within
>>>>> struct rdt_resource will be helpful to clearly separate the MBM related
>>>>> data. This will be similar to struct resctrl_cache for
>>>>> cache allocation and struct resctrl_membw for memory bandwidth
>>>>> allocation.
>>>>
>>>> Did you mean to move all the fields for monitoring to move to new struct?
>>>>
>>>> Struct resctrl_mbm {
>>>>            int                     num_rmid;
>>>>            bool                    mbm_assign_capable;
>>>>            u32                     mbm_assign_cntrs;
>>>> }:
>>>>
>>>
>>> Indeed, so not actually MBM specific but monitoring specific as you state (with
>>> appropriate naming?). This is purely to help organize data within struct rdt_resource
>>> and (similar to struct resctrl_cache and struct resctrl_membw) not a new
>>> structure expected to be passed around. I think evt_list can also be a member.
>>
>> How about this?
>>
>> Lets keep assign_capable in main structure(like we have mon_capable) and
>> move rest of them into new structure.
>>
>> Struct resctrl_mon {
>>             int                     num_rmid;
>> 	   struct list_head        evt_list;
>>             u32                     num_assign_cntrs;
>> }:
> 
> This looks like a good start. It certainly supports ABMC. I do not yet
> have a clear understanding about how this will support MPAM and soft-RMID/ABMC
> since the current implementation has an implicit scope of one counter per event per
> monitor group. It thus seem reasonable to have a new generic name of "cntrs".

How about renaming it to "assignable_counters"?

-- 
- Babu Moger

