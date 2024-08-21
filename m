Return-Path: <linux-kernel+bounces-295980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AB995A3EB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A931F21128
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520A71B2ECC;
	Wed, 21 Aug 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aRMMfR8S"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D437D14E2CB;
	Wed, 21 Aug 2024 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261418; cv=fail; b=BKWhUMqfrJmo4IyE/QA7oYG4aGzjqnaqq0aGL3GEwYwwIfpWdCnOcG5RjzUmuXSPqCW6IfUO2UEUT2kjuCML6C/DV1tBwenE/ZGxqzAD8AbV5VkLBVce4A5gg1W2BPmf1t2m/p926E9L+ISJHnE+hr87TRGdy77kA74yitZRziE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261418; c=relaxed/simple;
	bh=VnB59y+xGl4VsEkn38LUjS9UMo0yzuaylXIzbWpH2x8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HtImkzbSarADzOT92lmjYcX1hzBKIBeTOKOrx1X2R1W5otV5fl6d+3ZhODkaKsB5RweF74UzkDGEEnxgYKuea/doHxAtkCPJqbWdIvcjcXCdHW8w127FwLOb+N9VzFbdkdqEnCRMbYU9VFIR+7S01ecwiA5iDytMGm/yx26na6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aRMMfR8S; arc=fail smtp.client-ip=40.107.102.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJKd3X8Q1zJyV41Rio85gVZ+GVnddBGLCwE7FgaiksxCOrl2mSBMlfxY1LLj3iTLP4LTuaTw8R6aHuoPVRt/dBVTlv31V7kYG7Psjn6OIKu+HUOfvi78hx5CHVfaPdv/T+UP4XOe4ZmeSLHPXwAYQXsUPoAFJRPJ6+7D4jzBfzYn0cK8IexGRW5GWN6BvaiGAEW5fYGHsTiolniSb+nVLs42ArglP3A7uUf8Kcc4REfk+yZpXPEgI+AoBPiY2Yzlnimoe2e18ty7j7dKDvZT7EoI3/L5eCYdi/Ni3nqT9C7LTWZYmmsGxdW9MN+B3MB/RC/NQJv6uznRgAPDF8PZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvpGiPtK+wjXqwFF5nLXtsEIWZZC7EZ2US8DObL5+kU=;
 b=UdZ5CVtWifP0SEuOmDHEmt+DZC9I9YgM1ayfy4x7wMKiNkqt93HZnw1tp0g02h8wyFThND5za3SSGPTX/srBp5zroDoiWOsQj83K/JJi7pKzRiM+ZvSLqmwgz6cTwqHq688dz1f5m/RdyhpZ52F0wp16Y+g5Z9v4/HnunW1Z2WG/K46nYP5ulBhVGX2SqaufXnvZDAXbuXGYAJ7Q7vNeQHEDJJcJyMXRlSU5esckPcoSxw3oWWz1D1AMckdOmamSvMQOfBT/HQLGcj6HlmP2gpSn6XTn7W36BavjvK0hn7lfeVbyIfn/tBvgpVzgQmNW0/mC8RFBcHEfi75DynrVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvpGiPtK+wjXqwFF5nLXtsEIWZZC7EZ2US8DObL5+kU=;
 b=aRMMfR8S9YrkoZQ/RVr+bOhs9ke7oS5s4CbpVzCiTVDnp1MSGazIc1b2+S6utMfYQfx7m/VpiGx8gTs4btV0QdgAuuAYDe126uLUZy1NBLYGUUtfVhlND/AeX914alPWU/YlCOH/qG0LNi/lq/wNKfwDxdhdozN8qCdJ8mxipLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 17:30:14 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 17:30:14 +0000
Message-ID: <209b58ab-3885-47a2-b1dc-ecf854fb621d@amd.com>
Date: Wed, 21 Aug 2024 12:30:10 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 18/22] x86/resctrl: Report "Unassigned" for MBM events
 in ABMC mode
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <5906d1a910c5e2bceb680c874e5e391618f6e313.1722981659.git.babu.moger@amd.com>
 <bac86fa6-bfb2-46fc-a279-c6a263c00058@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <bac86fa6-bfb2-46fc-a279-c6a263c00058@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0157.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::12) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f2332f-f69f-4a88-c471-08dcc206ea9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnBPUUg1RHNib1c2OG9jcEdFZGVWZ05yRmM3NFl4NHhzSTF3REJOK21ST05l?=
 =?utf-8?B?WkR3cGdnUGs1S1pFZGdoeEoyb3pka1p1SDBTV2Z1UUNhamdOZmVRMldnSFgz?=
 =?utf-8?B?b2NLc0w5bTFLTFJ3TnlDNGplWjk5YnAzbWhyMmFaSkVOU1dMUzFZWWc2UWJw?=
 =?utf-8?B?OVB6Q0JVL1lHbnVlZGttRVo2dUdLODhucWhVNFlYUFBtL3N1QnZSaGhyaFps?=
 =?utf-8?B?amJjVGwvZXl5cSsxZzJaZ0VIdzUzZ2N3SXhLNk5taUtNVnB2eC81dXpka1JD?=
 =?utf-8?B?YzJUTWRIN2FmMmx4VFVXRm9FZTRnL3VteFlqbERDcEJpOVlkS3g4eGdUYTNj?=
 =?utf-8?B?c1hjaVhDem94RmVPYmJzMkN6Sm1BZ0djemVzSi9lTU1XYU95RlVaenZzMUtY?=
 =?utf-8?B?OUhOZTNRZVlVWUtxVmN0VThxVFNRN2FYYlNxdFVORmZ4RE1XUDVkdGJmanZr?=
 =?utf-8?B?bUttN3I5dkJGdCtleTN3clJwTmwwWFJnaURwbEVldFhCTlBnTU8rV1N5Q0RY?=
 =?utf-8?B?UmUxb0k2Z0JQN0l3U2lXMmhNK1JxblgwRVhCNXpPTHU3cnk5MCs4aE5TeTIz?=
 =?utf-8?B?dDl0Ry8vU3VqUmR0OFZ0YlY4WjVLdkhNeEFSSDR5TUpPN25zZlEzSWdKcnBa?=
 =?utf-8?B?em1WL1ZFK1oyU2QwQUdEaE9VWkRSTXhBZCt6UjVjenRkYUJkQ21CSm5wU1lY?=
 =?utf-8?B?czhRbERIcWJxRDBpQWRBYytlSm1QaXU3ZHI5WFBjYkdXQ3AxQ0hSTm1UWlVk?=
 =?utf-8?B?WXAvVlYyMDZFNjZ0WWsrajJUaTg1UVY1SEJxWk1TajdOOThsR21yLzhKd3d4?=
 =?utf-8?B?REZteGlZMStBYXROZFR2ZUN3RlJDUmtEdmV3SHJHUjRWRWxlZWhocTN2dFdT?=
 =?utf-8?B?V1BRNXJXQXRrYVN1VmRRYXFtRHVKR1hHd3AwUEp2TEtRNXJPa3RWWHZIS1Jr?=
 =?utf-8?B?SWlHT2l6Q2ZVcno4N05LOHd5Ty9GVll3TnhIYTdaWHFPVU4ydU5PaCtDbDFp?=
 =?utf-8?B?Y0V2WllCbFFQMGxENlc3RWxOTERQRWhHaXEvNEErRnQ4Qlg0REZmUmlsVXgx?=
 =?utf-8?B?bzlyY3VYSTgrM0Y4eFF5OWtUUHZWbWZMQzdZTklDMUlpb3NURk9tVThnaDZP?=
 =?utf-8?B?QVRWVGgwQVNzSkNpd2x0UjVKb3lVYkJkN2ROOFlpamJjQmpjRHNidFh0a2pF?=
 =?utf-8?B?Mmt2RS9TTTAwSFhPR0NIbW9pc1FWWGlKZTJGMGxSOTlIYy92VTJoUkdmNDhk?=
 =?utf-8?B?eXpBRDRqeFcyS2VzM3JsbWdqSzQrS2lkMmd2TFhnbXltMFd5cU5kNjRGZlZz?=
 =?utf-8?B?OGVTb1JMWUJaMzA4d1ExbUpJMmE5TUlGeE51eFlZOEdLeDlSYjI3dmppYjl6?=
 =?utf-8?B?dzZhZDVyYWFyb3FneG9NK0RRWmVpNlV5T3VRdFpiN0RmeE1EZ3B2MjBOVTRp?=
 =?utf-8?B?eXBLSFVWT0xmb2ZsY2RVR2o0SWM5Q1BQRmtEeVorS2hVVkpVUWRySkdTSksv?=
 =?utf-8?B?YlM5ZjBiM0phVnNNK0wrUGYzclZnazY4RWZKeGpzNlMvMW5uZUxJaDlnaHlX?=
 =?utf-8?B?RXByclBiMTZqM3lXbXF4LzBJS0c5eUMvMmhhbkRnUUNjVWpJV1MxQmxjWWxT?=
 =?utf-8?B?UWlhdnNQdGNWaHM5WlFYTjQrQml2VVNFSWR1bGh5K2xxaGhHVTBaZEx2dUtQ?=
 =?utf-8?B?a2hhUFZScXpxOVI5VU13YjFUWDVEc1JXMHNudmpkRTZVME55ckkzYW0xYkl0?=
 =?utf-8?B?RE9ub3JmWlQ2YTVGMzhLWWx5QjkxNDFQOTFmcm1aV1d4c2lTSVYzK1FTbnpz?=
 =?utf-8?B?SnM4eEhMMmZDZ3orU016Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWdUUFdRTkVleUFCZnJ6TnZXcCt6SWYyb0ZqVVlwMVgzcld3TUlSbWpETHQx?=
 =?utf-8?B?dnRFWjdLbWROcGZzSkxaWDBVVndjWTJaN0txUy9kVzRlbDlOODA0OGNIRGY1?=
 =?utf-8?B?VWd3bDZzVnVFNlFzTGFnayswYm53bHpGNVhjOExhMlhqYmk2NFJnNVdoOTBC?=
 =?utf-8?B?TG12Rms5d0xvcWJPalliNDVQUktqMmtuaTVvQk4xbmgzRzdjUkR5WThRdno4?=
 =?utf-8?B?cEtzTk9xZTRWaGlCdTdRTlJ0TjNCbnFZdm1mTkUxL1dOSzhqK2tvTkFWR0Vr?=
 =?utf-8?B?UzZFUHlvb3V3a3lKakpVTXdBWE5FdHlFK2NUaDRTVC9ZQTVlVTMveUNCNXEz?=
 =?utf-8?B?RjlLNnlnN0VXR2xYNk00cHB6TVE0WlhFUDVSV2luUUVRd21rSkwxL3NNNEk4?=
 =?utf-8?B?b2U0Q0MyM3dBTDJJMjNsVks2OVFJNy9sZDFKNGtGbWI1UnhLRW9JZ2dTaWgx?=
 =?utf-8?B?T05KUHNIdEhhSWIrc01qSjJHSW5zRU1ucGF3Z2htOFhLRFlqNTFHeVRJaDNa?=
 =?utf-8?B?cGlRRldDbFhtL1c2dUJNeWVqMTZTdnB5YlQzS1Azb0RvcEM2dUc1TUg1S3d3?=
 =?utf-8?B?Q1ZHVUFsazRPQTg4c1MyS2oxVkFDN1RtVFpubmdxS0FyMmovV0l3bzRmNk14?=
 =?utf-8?B?d0o5aWFUdGtqNitldEQrWDVRVldoWEdYbll6NFBka0NhTXBPdFV3dmZCYzg3?=
 =?utf-8?B?NWNBT1pDNHZxdU1SQmNYWVBjOFFrYVNVZnJJTWxyZWNVUEs3MjhxMndxYUtT?=
 =?utf-8?B?R2lhdllvNUx0ZHgvaEo2OVVHanlLdXBiRTlUV081a29HOTMyWXMxVlByejJU?=
 =?utf-8?B?S3NCUTBUbmM3SHE5bDQ0dERESWVPZDZhcE15RFJMUnNsL3hvcmN3Q1ArMWhx?=
 =?utf-8?B?c2NPajJaNEJiWHJ3RTM4SFRpQjlacWtRRytLeDZydmkyYXpSVU8xSUdDdjV4?=
 =?utf-8?B?ckZNZ1krUlNhbSsrVUtKZVhwTjRIN28zYkJlcjhMMTJMWHY3Zk5Ic0dRUHFJ?=
 =?utf-8?B?U3ByT3I0OExwRXpZSUxTaERJZFRYSGVHUWM5VGh4blQ3Rk5SS3NNWXBWYk8r?=
 =?utf-8?B?RlE0MkpEczlSbUMrYUpQQWV4WG1WUFU4YlB2dHoyWk1raWNYNHFBRnJ5bWV4?=
 =?utf-8?B?WVlxbmZQN0d4b1JJamxSazE3VXljU1lzbjBYd3pDbk5FaS9sS1lqKzVuMWxX?=
 =?utf-8?B?N2RuL0hUSDVYdUxyVmlCZXh5Y3c3eUZsSnIxb1U1ekV6UEt4WTJPenF0T3FP?=
 =?utf-8?B?dzRtVW10Uk9JZFRXL3k2YkZXN0JZdHJsUzRCdFRmMHVzMHpKYnNubkJQaFZn?=
 =?utf-8?B?Q2k3LzN3OGFvYlNldGRGWWpNQ0t1aUJ5eFYrd3dYNXhlaC9HV1pVSDRTUW5Z?=
 =?utf-8?B?aVAvNnVrT3VhaDlCTnhWcjZNMEZZNUtmdEp1YXo5ZUdtRlJoNFpIUk9TNDFS?=
 =?utf-8?B?cHgvY2hQQnZTcE9IeGhrTTNCY3ZrNGhma25rSlpoc3pGamZLZVBjZTJaSEF2?=
 =?utf-8?B?dzNLbW9oc1BSQWhIaUpuNURlK0RFOTNNbGE0SUV2MDNIUUhXUXJKVTNjMlN1?=
 =?utf-8?B?aGR5U1AzRVhPSHVYMmZnZmxUaVpmUnUwRndiWHl5endYRzEzcVI5Y3RoTFMv?=
 =?utf-8?B?RHFPbGd6RlgwRHNLVk5Uemt2VWY3N3NvS3FqdmpBUWlmMldlMUU0WDhlNXdC?=
 =?utf-8?B?TmtLRHg4dUJGTnprTmZ1TzFweG9lREFRc0VNMWduQ1FhclFKaHJtek5CVXlV?=
 =?utf-8?B?VTlUbzhQTkY1WExTd25tU0pYN0JKdkwzSm5pVU41ZjZld1lpSTByTzBWcEY2?=
 =?utf-8?B?RmRNN2VYaHEzOHJvekhrRUJSb3JwY0pBVEJ3UGxjRXkwN2w5cjArWXJYZEtQ?=
 =?utf-8?B?Q0wwVHV1UjZOOHRQbmZUbjJwckkwTFJMSDVlUjZHUXFUbGUvTWJIT0hsSWdq?=
 =?utf-8?B?TlB0NXgxQkM1aEY0Ymwwc1VkNllSYlhySG5qTkFnTVpqU0xlRmJPcFFiekZx?=
 =?utf-8?B?bVhRM1Y3WkZPQmJFM1NWUE9TVzdpOGVESjFIeG5ONkd1ZEVvZkVUTThpYzVy?=
 =?utf-8?B?UzFJQ3o5cjgybW10YU1wbHZrR0V2UUdDOGlWYXNaQjZFU205cHFNREJuYVl2?=
 =?utf-8?Q?8wCM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f2332f-f69f-4a88-c471-08dcc206ea9a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 17:30:14.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpL+LX2mc8rAn76cQ7Y/ZHVop/95qhvv3B7xOdgVlcpYcg79U8+lWrLYRxbrLtjV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320

Hi Reinette,

On 8/16/24 16:42, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/6/24 3:00 PM, Babu Moger wrote:
>> In ABMC mode, the hardware counter should be assigned to read the MBM
>> events.
>>
>> Report "Unassigned" in case the user attempts to read the events without
>> assigning the counter.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v6: Added more explaination in the resctrl.rst
>>      Added checks to detect "Unassigned" before reading RMID.
>>
>> v5: New patch.
>> ---
>>   Documentation/arch/x86/resctrl.rst        | 11 +++++++++++
>>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 13 ++++++++++++-
>>   2 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst
>> b/Documentation/arch/x86/resctrl.rst
>> index fe9f10766c4f..aea440ee6107 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -294,6 +294,17 @@ with the following files:
>>   "num_mbm_cntrs":
>>       The number of monitoring counters available for assignment.
>>   +    Resctrl subsystem provides the interface to count maximum of two
>> +    MBM events per group, from a combination of total and local events.
>> +    Keeping the current interface, users can assign a maximum of two
>> +    monitoring counters per group. User will also have the option to
>> +    enable only one counter to the group.
>> +
>> +    With limited number of counters, system can run out of assignable
>> counters.
>> +    In mbm_cntr_assign mode, the MBM event counters will return
>> "Unassigned" if
>> +    the counter is not assigned to the event when read. Users need to
>> assign a
>> +    counter manually to read the events.
> 
> This seems more appropriate for the "mon_data" section.

Sure. Will do.

-- 
Thanks
Babu Moger

