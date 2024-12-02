Return-Path: <linux-kernel+bounces-427809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DE09E0729
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02AA173EED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EA31FDE11;
	Mon,  2 Dec 2024 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iRkSoE/N"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE11481C4;
	Mon,  2 Dec 2024 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151773; cv=fail; b=L1wmnWe5S1YS5TO6+phUy2Oyc9aIfjJut6mopJekyXo9y7SMMh5xm5Pi5KtYhMhGTupFwxlAuPcvjoQoKd+w+pzmXYz/i5BgQNVUho/HG7LpSSCcg/2Q/r9DiZTZXcVP5HvKP/ISSgPuLT7ELg6QDpYPUnrlwIJkARleil6vxfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151773; c=relaxed/simple;
	bh=bmyVq/eP4xpC/gEdMe57mAgUUzXBpiJYJOjv7tLvx/Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ie0/LunjS2PIYUkNJfUOKDaqj4zHtidEoixFRDUg5PnFoYwVx7c58Dc+2DeufbtIDiuCJ6wprSi8M51k9dYpO4yfOjQ3a5Igy0xHa3brpFVfVU+YeOQVdFvFWEwYlZlboUluGSKKb1DcdeJdA1kgShN6pvjIGRkPmbzVqlKsd7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iRkSoE/N; arc=fail smtp.client-ip=40.107.101.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATGzOlHMjKpr/aTMMtBWo7xcztNV28sLuyFYH3fWYVgW7UGtj+0AAn1Uj90JKVBuPsM0rUpVq7qe46XdPCsCh5bhqhKsJWXjMYiyKi0Uenmx3Y+lzXlPs5aSOl94auhsoQ2JYQEem0TbIymcr8zvj8H6rsaNjPMNThpJKFHpqWZW1Sv5u1U3pwm6vXiTAYrJX1GDq07QUBLSEV8XU+16OJwPeQ1jl57QVtnZy4jDAq4Z6ehRvVl5C/7rk+M+ivkbmeagysUJ4DiZSmATeB5P+NbwtnnZpufatg4x0MduPoBcG/jj/IuxFGP0c/wFz48h7XHwINEf6Ex0mlyBJbOaPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNY7rcT9wila4t8HW8C3fyhuOUIuQynE6R3xCRxClq4=;
 b=gjIrnJ9teRKIkKooOI7FQJgd+f6gEqkLhxeiVxyE66fYqowCV1eALBkBCvBXpBdUo0/xXEmsY1Ls8YXkTRe0HD92QzGY5tlplhT16f+3ZsRiSqWu9D6Sr9wHYw3eGMEu83Bg0wJMIcjdsgeziy9soiJex7PiSA8f97KUF0wvwSJMRBdedybKJqufUSbNqejeaGB8ruWZTQu3hioKA4oautMc0th6H46WKfMb4velWHt4QWP25EQbbAsr07WKvZ/pqYblrKL8vA1It2rMfNZiytHloLigIXpQ3cLmJGbAaczc/VACwOWtriKQIUrUKyJKb84uOjSnOCZ3iZfJ3cJuMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNY7rcT9wila4t8HW8C3fyhuOUIuQynE6R3xCRxClq4=;
 b=iRkSoE/NeY92nO7+AxAmg5eydM56F7qt1sY+f9Js/zlPUW74qUlpxecCQtGp1vqnqYAv7/EsQ/ThIYESsUAVqSdv36/Bj0jU7RDBHL/lI76VEw8rCqnOgTipjR4P9tGJ0Q5+VC3PG/GTwfDVmbJlIyZqMYXnGTkHLjHZYLx/Erc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Mon, 2 Dec
 2024 15:02:48 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 15:02:48 +0000
Message-ID: <31b0966e-a795-488b-8277-b5bc0f3558d0@amd.com>
Date: Mon, 2 Dec 2024 09:02:43 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: Peter Newman <peternewman@google.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, fenghua.yu@intel.com, x86@kernel.org,
 hpa@zytor.com, thuth@redhat.com, paulmck@kernel.org, rostedt@goodmis.org,
 akpm@linux-foundation.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 perry.yuan@amd.com, sandipan.das@amd.com, kai.huang@intel.com,
 xiaoyao.li@intel.com, seanjc@google.com, jithu.joseph@intel.com,
 brijesh.singh@amd.com, xin3.li@intel.com, ebiggers@google.com,
 andrew.cooper3@citrix.com, mario.limonciello@amd.com, james.morse@arm.com,
 tan.shaopeng@fujitsu.com, tony.luck@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
 eranian@google.com, jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
 <0dc08082-0f3f-4acc-9285-b925a4ce3b02@intel.com>
 <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
 <c587f94a-7920-49cf-94b1-4c52140db914@intel.com>
 <ef92f1fb-086c-4ee1-b8ec-e08ed68f963a@amd.com>
 <e065b193-dbcc-451b-98db-68a5a69e6ae0@intel.com>
 <20959b58-a882-4ef7-bd11-e8bb0a998945@amd.com>
 <1a93f4e3-d3d2-4764-90d1-728b9cb70481@intel.com>
 <36d8fe9f-0000-4d0d-a097-efddc3881a2a@amd.com>
 <5aa7924d-b27d-4ee6-b8dd-4bae0e25267b@intel.com>
 <CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com>
 <4bf82744-da09-43c3-b8f1-7fc203d1c1c3@amd.com>
 <CALPaoCjL6FEmVgX-h3_GQEVZNAT3FcH34t9o1PwbUacVzXjZPg@mail.gmail.com>
 <18adb251-b340-4820-a808-e1583b44480a@amd.com>
 <CALPaoCjvpp3eKKV9L_UJ5Axp1u8XBDtgsuHrhOJhmDrFVphrzA@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCjvpp3eKKV9L_UJ5Axp1u8XBDtgsuHrhOJhmDrFVphrzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0058.namprd12.prod.outlook.com
 (2603:10b6:802:20::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b312f5-5dfc-4b0e-b310-08dd12e2625b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU1rbjZkRUM0V3N0NkZKa25OdjlMa0hJVzNmZktvK3g3MzJEZWVtZXh0NGFy?=
 =?utf-8?B?eUNkaTFFSVFYa1dGNU9qL0RObGZnM2VOaVVnNkJBRWhoQjVPZVFxMGJ6Syt5?=
 =?utf-8?B?ODNIdUhiaTZRT1JWSlBXQ0Jyc0ZXTTRIMFI5a1NFZ2IyY09taW8xN0VsNGFw?=
 =?utf-8?B?b2VFVjhPR3BXYmJnR2VJTkdManhIZUhNa3gwcEphUm1vVVoybi9hLzZMVlp0?=
 =?utf-8?B?M3lHK0djSzlYVnZySFczMUM5M0FSTWhVdFZFVXZEVitsbkVDeXd2ZEZ4bllF?=
 =?utf-8?B?OVNJZ2hOMWs2eVJMMktFaHNrMloyM1J3VjMxTlZsVGlDTnR0NnFuQ2NqdzQ1?=
 =?utf-8?B?K3J5N2M3Z0ZnKzkwSE5IWmJraXJIVzVwTkpoMzFxZlFlR2tqamZyQ0QzS1J5?=
 =?utf-8?B?R2g0WStLbmViaGh2YTU4MGV5anRFd3ZVbW9lSlplTUl2OTF3ci9JclVPcDVP?=
 =?utf-8?B?dGkxczJyY09LdjZZU0MwbEF3eTNRbmxtOU5vS1c1TzJYQjgwczNyVEE0UVAx?=
 =?utf-8?B?NmFkYnBKMGxkd205NTBlQ0o1KzZGbUJYTGhUVXo3ZVlyY1dTVzkxUnM0OGlJ?=
 =?utf-8?B?YWlUOEpSVW83MHhpdE1BS0dLaEhxQld3TWpRU2dwSVNPNUh6UXlycGU3c3Fz?=
 =?utf-8?B?djhuNXcyYkNEQSthUVhpSkNOckdWVUNvMSswdi9aT1VVMHNJaFpwVkFuVU1n?=
 =?utf-8?B?VUErWDQvbFJTNzlyR1g2dVFaRnpKbHR2UU1zRTlSRkdZVE0rcGROV3V5cWdQ?=
 =?utf-8?B?S2FFT2ZWME9VeGx6WEVYYk9KRkFPZFZuU2lsUE5TbXhyQ3hWNEpaWjBqendM?=
 =?utf-8?B?aUZqV1VXcGNsTVFHRXE3MTFPSHFVTGlLdUR1M2xxOXpkQy9BOWxBRFNVK2ZL?=
 =?utf-8?B?aUdXenVVMDJGY0hrYlp1VHREbUlYMG9ybFhJM0dwREdzRFM5WWNtMG5PTGRZ?=
 =?utf-8?B?M0NzUkIrWUp4VExGcVRaVWtnWUFXbzJhYnZEMklHeGRwUDJBSnN4cG9Ua0p3?=
 =?utf-8?B?Q09ET0liam5USjVGYXowd250TEpKMGlYQU1DZUxuWW5hQitQTEF6aGlnemRn?=
 =?utf-8?B?WnNMMjBSRGtLK3grVlhWZG83MmZndWcwRDRySjVoSkVON0pvNGpBMzVsK2hE?=
 =?utf-8?B?MUI3SUlIenp2bk9GeGNuSEZFUW1NWEY4bFFvWE1PcGhnNXU5M0poekJCQXU4?=
 =?utf-8?B?VHFWbm1EbHhtTzBTL2I3QnVhL0xPcnVIZVlwZUI1blFubFZXWGhORlJDUVBN?=
 =?utf-8?B?aTdYR3dkVktsSjE5Mkd6NERXbVFzUHBRU1h0YmtWUU1qN0tNUkRISjdwazE1?=
 =?utf-8?B?SUdTeTR1Uk1mdTNGak1hcUxJWG4zWE5tUGpaVk1jaWoyM1Bnbkt0RldBNitO?=
 =?utf-8?B?M3l6amY5R3dCd1FMcEl1ek15K0tqU29PUDFpY0o5bENLWlN2QnVaSFRmcVZr?=
 =?utf-8?B?WnZFTFliV21acU0zS0RUNVdRNTBDOFA4Mkp5dTdjMFNjQU03R2ltZDJOSUNB?=
 =?utf-8?B?ODc5N2EyVEh6UlNKUkptS0pHR1Zpdk8zQzRvbUdKTHUxTlhHbnZ4TEpFUTZ3?=
 =?utf-8?B?S1dnYlpzSFV3K0VlNTVHZCtJSG45dkljT014NEErYjJ6V09DZlUrVUp2R0JR?=
 =?utf-8?B?eWRWUlZIT1BxK0FjUm9URHVDc3p3dUFhTldSaDZXREFtanhzbCsxMENNanEw?=
 =?utf-8?B?TkN0UlJEb3lTdHJZaG81ajhzK3g4OVBubStadTNRMTRSdmxKU0ZjcCtrT3pB?=
 =?utf-8?B?THNhakxuV2krOVlxeW8ybnBFcW1xQW0zSUs0bW1qVmRiZkprUkp3Rll3bWpy?=
 =?utf-8?B?Y3VoUjlhOWVERVJLcW9aZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWRyLzdhRlp6aXl0Q1hWYVpHVW5OOUlrK3F3d3dGWmdOK0k5YlJpNjZMNUh4?=
 =?utf-8?B?ejhNak1Bb0hVOTFZUEF1K1FCazR3cjZ0RzQwQVlDUW95cHo5L1ZVVzFyVWsz?=
 =?utf-8?B?ZkpaTTRWREg3UlZYK1ZCK20wdVRMRitWMjlXblUxRFZUU2cwQmdpRm5qakdq?=
 =?utf-8?B?RmhYN2thUmlOMlp1UWpFLzViVEZWOUgrV0grcHZGVkc4cFErNXpyWEN0R1hP?=
 =?utf-8?B?Qzc1ZEpBd3d5RFpkeXB3ZWRvQVNZb3pOem40bFNHTFpWWnpKWmJpNi9uNGJ6?=
 =?utf-8?B?TWdZSEdpSWtlSUlMRm8wOTk4RWZJSmVtSThWSHZhazl2ekJ2cUdxaEVrd1ZQ?=
 =?utf-8?B?aStuSXg5T0FkWHVQMDNLb1BrdnhLdGQzV1o5U3QwQXlidkc2Vjk5Y2xWZ3Zv?=
 =?utf-8?B?Y0ZMNDh0SVhOckdHbW1ickVFNkxSR1BFdFUvR09IWGlxSm52SmNndTJDa2lU?=
 =?utf-8?B?RmIrNURBS2dwV1FIRFhqTWtIZndwakRvQmJ0QUc3N2h1V2pVbDVaQjlPNjZq?=
 =?utf-8?B?Zm0vYzFIYm9xSEVyV2RRZ0tZT09NeHhiSSt1Wk1jVFMwOStid0ZPbHIvcEow?=
 =?utf-8?B?NmpMRGRzUml3NUtIOEprUkVoYnlmQUFpV05QVmhvNGdYTzVSRHplKzY3VWsr?=
 =?utf-8?B?Vk9OY2wxNlJBaVZVakhFd2tVV0ZIaVIreExULzFyYmJGM3pWRXpPL2d1WTZ5?=
 =?utf-8?B?MEhlcEFpelVURWI5UzlrYlAxL2FaeHpMN1pWUGl5UE1ab21SMmtNVkQxZ3cw?=
 =?utf-8?B?QnRvL1ZaUXdObG5keVQvZlM5ZVVocEVLZE9WT3QrNHpoZW1NN0ZNcGdvK25n?=
 =?utf-8?B?Y2MzZlJhRHBhWnR6ckZJT2FTSWo3NTJTMUZOYzdoT1QySDkwVnhjbHordktP?=
 =?utf-8?B?eENFeW4vVnhXMk4zNTRDUUhDQ2JsMHJmZkZtaUxRTWlZTEFXY3ZEWGkrTGtQ?=
 =?utf-8?B?R2FSMVJxUE1mWEExalhZa29UV2tRdENDVit1L054VkhxelVGT1poZzVGakFF?=
 =?utf-8?B?eVo3S0tocDcvb1RlRUtLU3JBeCsyZFlDdC9ZbTJDNVd2UFBFMG0yalRySWQ0?=
 =?utf-8?B?NmVNNndKZ2Nxc1lGM3ZMTFhKVEU4L1M0dUdHSjMwVTk3emdSamg2SlErRUY2?=
 =?utf-8?B?bUZiQ05wNXV3SXBHMHJDb1FEZXBCek5kVi9LNWhWeHZWMVlRU2kzaHZKS2Vn?=
 =?utf-8?B?Ty9rWmN1aFJEMWRjTmtxdTBHL1VTZDhrb1FEVkw2SS9iaVozdjQvQm1UU0du?=
 =?utf-8?B?ZkhxU091VGw3SGtVUTNGRFgrOC9oN2QxQ2cyMkcxMGF0SXJGckkyVjFrRjE1?=
 =?utf-8?B?Y2NpT0x5QWlpZ2ZTbVdna01CNlBaUjd5QlRpMzVhWmZaZVhsWGFGbDNhajhH?=
 =?utf-8?B?bzV1R1lhYktjQkQxdjlSVisrbkJqNjNUSTJHK3BoSDRKZy9SUFVTUVZTTThs?=
 =?utf-8?B?WFZZaDl4NDdiVU9CVUc4c29EeDhXMWxoYjNNQVJRcjBxWDhqdmYxOVF2Zldj?=
 =?utf-8?B?MXJqd2F2RkFiOFA1cFhEV2VnajlIK0lHUENCazluZGFqaXNLOUtueHA3dVNk?=
 =?utf-8?B?cCtRUVlucnlIVTFOUVlHUGNLb0dlTW1XQm4zRGZqcUoxUUtCaHBMZGNidzdK?=
 =?utf-8?B?OWhoa1BqS0tFQWxnZFZ3UnVKWkNlbHlDOGJrbmh2UWVVb3FOSnh0eW81cVcx?=
 =?utf-8?B?MHNNK2tydWlPcEhxN0RpOTNSOGdNWFJBTEZBVCtrWUZ3Q2s0SGR2M1lweDll?=
 =?utf-8?B?Njh2Q29ETlEvLzhSS2xhcEVUakdFYUdvZmYvL011d1lUaVBQUVFJMVErWmRk?=
 =?utf-8?B?S3NQRlMwK1MxMU9uY25PUUlLVkJCdWo0TjRRSzJJMC8vYTA5OU9BenZPWmJw?=
 =?utf-8?B?aWJ2bFNUV3MxZjkvbmtsVWo2eVhmc1hJSnR5M0JURkQ4R3E1SVRMWGQ4ZnhU?=
 =?utf-8?B?QUlVY0k5a00yS2dIb3hUUmwxcFBNT3FLZit1MW5ram52VG1najluejlNS095?=
 =?utf-8?B?alpRSzkrdGdVOGQ3RzBCZDQ3aTJKWVFDQzhkd0lSc2ptQWEzMVFCejhBRUd1?=
 =?utf-8?B?aE1jc2tjV0I3M1JwWmdIZjk5Mk1UK2wzUDRKYTV4aTFTRHB4ZTBWd1FTTUdC?=
 =?utf-8?Q?44Yw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b312f5-5dfc-4b0e-b310-08dd12e2625b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 15:02:48.0798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uWxDQFjXs76Lztcovs1ssaYV5zvnEY0RjPZlObhbqVEcOsuYBFiaEGEnw5VUfqV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137

Hi Peter,

On 12/2/24 04:43, Peter Newman wrote:
> Hi Babu,
> 
> On Fri, Nov 29, 2024 at 6:06 PM Moger, Babu <bmoger@amd.com> wrote:
>>
>> Hi Peter, Reinette,
>>
>> On 11/29/2024 3:59 AM, Peter Newman wrote:
>>> Hi Babu,
>>>
>>> On Thu, Nov 28, 2024 at 8:35 PM Moger, Babu <bmoger@amd.com> wrote:
>>>>
>>>> Hi Peter,
>>>>
>>>> On 11/28/2024 5:10 AM, Peter Newman wrote:
> 
>>>>> In my prototype, I allocated a counter id-indexed array to each
>>>>> monitoring domain structure for tracking the counter allocations,
>>>>> because the hardware counters are all domain-scoped. That way the
>>>>> tracking data goes away when the hardware does.
>>>>>
>>>>> I was focused on allowing all pending counter updates to a domain
>>>>> resulting from a single mbm_assign_control write to be batched and
>>>>> processed in a single IPI, so I structured the counter tracker
>>>>> something like this:
>>>>
>>>> Not sure what you meant here. How are you batching two IPIs for two domains?
>>>>
>>>> #echo "//0=t;1=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>
>>>> This is still a single write. Two IPIs are sent separately, one for each
>>>> domain.
>>>>
>>>> Are you doing something different?
>>>
>>> I said "all pending counter updates to a domain", whereby I meant
>>> targeting a single domain.
>>>
>>> Depending on the CPU of the caller, your example write requires 1 or 2 IPIs.
>>>
>>> What is important is that the following write also requires 1 or 2 IPIs:
>>>
>>> (assuming /sys/fs/resctrl/mon_groups/[g1-g31] exist, line breaks added
>>> for readability)
>>>
>>> echo $'//0=t;1=t\n
>>> /g1/0=t;1=t\n
>>> /g2/0=t;1=t\n
>>> /g3/0=t;1=t\n
>>> /g4/0=t;1=t\n
>>> /g5/0=t;1=t\n
>>> /g6/0=t;1=t\n
>>> /g7/0=t;1=t\n
>>> /g8/0=t;1=t\n
>>> /g9/0=t;1=t\n
>>> /g10/0=t;1=t\n
>>> /g11/0=t;1=t\n
>>> /g12/0=t;1=t\n
>>> /g13/0=t;1=t\n
>>> /g14/0=t;1=t\n
>>> /g15/0=t;1=t\n
>>> /g16/0=t;1=t\n
>>> /g17/0=t;1=t\n
>>> /g18/0=t;1=t\n
>>> /g19/0=t;1=t\n
>>> /g20/0=t;1=t\n
>>> /g21/0=t;1=t\n
>>> /g22/0=t;1=t\n
>>> /g23/0=t;1=t\n
>>> /g24/0=t;1=t\n
>>> /g25/0=t;1=t\n
>>> /g26/0=t;1=t\n
>>> /g27/0=t;1=t\n
>>> /g28/0=t;1=t\n
>>> /g29/0=t;1=t\n
>>> /g30/0=t;1=t\n
>>> /g31/0=t;1=t\n'
>>>
>>> My ultimate goal is for a thread bound to a particular domain to be
>>> able to unassign and reassign the local domain's 32 counters in a
>>> single write() with no IPIs at all. And when IPIs are required, then
>>> no more than one per domain, regardless of the number of groups
>>> updated.
>>>
>>
>> Yes. I think I got the idea. Thanks.
>>
>>>
>>>>
>>>>>
>>>>> struct resctrl_monitor_cfg {
>>>>>       int closid;
>>>>>       int rmid;
>>>>>       int evtid;
>>>>>       bool dirty;
>>>>> };
>>>>>
>>>>> This mirrors the info needed in whatever register configures the
>>>>> counter, plus a dirty flag to skip over the ones that don't need to be
>>>>> updated.
>>>>
>>>> This is what my understanding of your implementation.
>>>>
>>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>>> index d94abba1c716..9cebf065cc97 100644
>>>> --- a/include/linux/resctrl.h
>>>> +++ b/include/linux/resctrl.h
>>>> @@ -94,6 +94,13 @@ struct rdt_ctrl_domain {
>>>>           u32                             *mbps_val;
>>>>    };
>>>>
>>>> +struct resctrl_monitor_cfg {
>>>> +    int closid;
>>>> +    int rmid;
>>>> +    int evtid;
>>>> +    bool dirty;
>>>> +};
>>>> +
>>>>    /**
>>>>     * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor
>>>> resource
>>>>     * @hdr:               common header for different domain types
>>>> @@ -116,6 +123,7 @@ struct rdt_mon_domain {
>>>>           struct delayed_work             cqm_limbo;
>>>>           int                             mbm_work_cpu;
>>>>           int                             cqm_work_cpu;
>>>> +     /* Allocate num_mbm_cntrs entries in each domain */
>>>> +       struct resctrl_monitor_cfg      *mon_cfg;
>>>>    };
>>>>
>>>>
>>>> When a user requests an assignment for total event to the default group
>>>> for domain 0, you go search in rdt_mon_domain(dom 0) for empty mon_cfg
>>>> entry.
>>>>
>>>> If there is an empty entry, then use that entry for assignment and
>>>> update closid, rmid, evtid and dirty = 1. We can get all these
>>>> information from default group here.
>>>>
>>>> Does this make sense?
>>>
>>> Yes, sounds correct.
>>
>> I will probably add cntr_id in resctrl_monitor_cfg structure and
>> initialize during the allocation. And rename the field 'dirty' to
>> 'active'(or something similar) to hold the assign state for that entry.
>> That way we have all the information required for assignment at one
>> place. We don't need to update the rdtgroup structure.
> 
> It concerns me that you want to say "active" instead of "dirty". What
> I'm proposing is a write-back cache of the config values so that a
> series of remote updates to many groups can be written back to
> hardware all at once.
> 
> Therefore we want to track which entries are "dirty", implying that
> they differ from what was last written to the registers and therefore
> need to be flushed by the remote domain. Whether the counter is
> enabled or not is already implicit in the configuration values (evtid
> != 0).
> 

That is correct. But I wanted to add the "state" explicitly. Makes it easy
to search. We can overload it if you want both.

int state;

#define ASSIGN_STATE_ACTIVE  BIT(0)
#define ASSIGN_STATE_DIRTY   BIT(1)
-- 
Thanks
Babu Moger

