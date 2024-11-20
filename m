Return-Path: <linux-kernel+bounces-416231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A59A79D4250
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A201F23CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FDF1BBBE0;
	Wed, 20 Nov 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gsyw3BuN"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184AB13C83D;
	Wed, 20 Nov 2024 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732129176; cv=fail; b=QkIno7dEfAjMbo12x97XxfJDAHJROSDLxImmG86Pff2pafp9puWTqD80vpKIVaZfW+gExy72u6K7eYRIBYkhsEvUWAbCeRqdxdljXq9vMHm95h2Ng9c+csaK6OlZgGinh5fSeieY8RukJgEcv0/LitFSjrASapmMBV3ULiXuedY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732129176; c=relaxed/simple;
	bh=g/TY3w+cHO6GVLHr2MSIbs3PpXq+bFEFyZwePZhsP3Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CgcfoPo9ZYIxndWghJLlID4zCmy8jmUn16yB1G5ZdS9ChU9fWnTX5dg/Zh96gDRZhSvoZdQ3ZyQGXkhkMwENpmuRME9Rylj4o2D+RPTpEI5WTh7lET4j1/Eobe0RNuRmIKxqRnaE8gaFuHtmZPWquCLqXLyDpnJM+I86oY7wUYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gsyw3BuN; arc=fail smtp.client-ip=40.107.95.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojzISrVsasbOgs7I379r4lJrF8wOvfQl9CVPoJ5xsG2s1MpAfHgLg4H90CBbOkf0Juku3nT8POflX8LSGnfuyfiCL0Dl3MhqRMvKOSilfT7sQCvxhBp3l8gDCEKKaLd4hkHk5E9CzfyIgSjHnWeVYkp8y8AxnjdMh1ay+/PZgL3m488nS+zi2dk5hJOcxsDe67Ek6qCqoCYpp8TEFIFONEim2Yxynbb8mS2QH72r4Yb1esuiMCAhEucsrgDNetXg3cwY8YNgUs3iEpZ9PSE6+5V9lEnie0AMm+4ZsEPmvx52ot6Tt7P1dKfAVAXcYkRk0sU9+8fXvhOPprNz8fIUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7gMtUceSCEAHyI/30QOsVtseqEaazgOT67AxkZjYco=;
 b=Fi5p56Yd8WX5C+2BvcAnUQ+Alv7USxbGHK6z7vaeiMKwP+jFHSOR8v6IMq7ll0KL+Zc7PXdfOn4VJnbqDPNtWvUl2oN2LuWbaIipS2rhtqI8krrgc5JQT34gQw1PhNFSM7t7FU12+ELFIVLRBtqr/ldoub2rYhPTByPF7XT7cJcVO8YZ/gcbr4ibHAphPnyDBH6UwXfajxg+6b6H/qAWE7a15nwV6FWd1mI597LWEatPicnKlrHcPpA0PnvYAVcoHm+f+xMORsHhPt1SCreQpIK6rBccixLX4SPY8CGUBktDkTokVeMuZN5Tl2Ks/LYVm08+hvru30QSkRfVcCxl0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7gMtUceSCEAHyI/30QOsVtseqEaazgOT67AxkZjYco=;
 b=gsyw3BuNKQngQiPZ7ye6eImKdGNSOelxCGnoNLof16gNE7//FnsNeowjAMT/FVvXcX2CoTUY0jz3fH9SA+Xrp2oDiqAH3pmx6DG4QFw6Kp9rNeWF4IN5vw1idAe/vtNMfYhQzxZ3KlmHjsdenadV2H13wXdgyu9cvJzmyb18ihI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 18:59:31 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 18:59:31 +0000
Message-ID: <a1feb895-a28c-46f9-a5fc-5152df8f3b51@amd.com>
Date: Wed, 20 Nov 2024 12:59:26 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 23/26] x86/resctrl: Configure mbm_cntr_assign mode if
 supported
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 vikas.shivappa@linux.intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com,
 maciej.wieczor-retman@intel.com, eranian@google.com, jpoimboe@kernel.org,
 thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <2964648aa19f9d961c76c83a25f10fe3993abf59.1730244116.git.babu.moger@amd.com>
 <af70578b-e682-4e7d-8373-61f61fafdc0c@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <af70578b-e682-4e7d-8373-61f61fafdc0c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0002.prod.exchangelabs.com (2603:10b6:805:b6::15)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c30ca1-5c08-40d2-c43c-08dd099576ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blVhOTVwUUlTRGtTTElKTlZHQkEvODZwZFp0cDRuN1JpYlc1dm9ZeUQzTTRJ?=
 =?utf-8?B?RllsakpvbFVyRnF5TCtiNW5LZjU1L2pYZWxzN1ZzNVV2b0NHdFY2Ums2cHNI?=
 =?utf-8?B?eDl4TDhiQjgrdkw1VEtqSGh5Y0lsVjE0UnlRYUxHaS85ajhQOHM1L01Wa055?=
 =?utf-8?B?UllURnI2amR0alRaVFlnYVNULzZRRVFnaitKU244VWZjejJYcm5sdTlrTDJm?=
 =?utf-8?B?dk91QkhEL0p0U0JMZjc1Ky9kZmwwSW9XQ292emZFcmRPM29OYno2elVnU2dH?=
 =?utf-8?B?MnJ4ZURiQVJ3RUs0eXVVN1RRcHoxQnlpYmRRMjU5RDF0bFdBRmVCcVRqRHdQ?=
 =?utf-8?B?VDB6UEJkNkRveFpPK1YvRDk5RHkxVERPcjBxOC9qejVoVUJtaUNobmcyckZO?=
 =?utf-8?B?VUhyN0txaWxRZkRBYW9TcnhtUzBZaUFpK2JiSy9udEtaN2k4TU53K2sxKzhJ?=
 =?utf-8?B?ZWFYZ3h2T2JGc2srRmdHYjJWTzVrZWtVVm4ybGx2d09pR1lONnkwaVprMy9y?=
 =?utf-8?B?N1VWdGJ4NHFTdW1Sc0tMU0pxRFljTWQ1R3RBUHVqTkRaZjlmekdRT0FWMDdY?=
 =?utf-8?B?QldXTityVkpDbnU5UjZYbE1YNjdSTE12Zk4rK2xsWU9nWXp3VWFOTmp3bGNB?=
 =?utf-8?B?NGswZVRkNVdlK3VnN0Q4NE5zN0lLTllWdndML0hNWUhDSzdIajZTR0FWNmh3?=
 =?utf-8?B?OXY0Q3Iyb2NLVG1HY2NQNy9DaHlkbW1UcHIrbHBHczV4RFIxckFnUVNhTlhX?=
 =?utf-8?B?enFoMVlNZ3dIUWRFczkzQVVVWEZuMmhnV3VpSlRDa0J3VkVtbThEQmlVakxp?=
 =?utf-8?B?RmpneFE1YXdJUVp0S29LKzdIQUxIYU9wZVBrWXlxUGtmZEFUekx1VFRrcEpB?=
 =?utf-8?B?NHZJdzlSS2V6cjZIMEg0OFFjSXpZdVE3cURiSTltUHlxT1ZCejZXQ3kwanV4?=
 =?utf-8?B?VXN3VkYrRFpnUDVrcko4aGFoeGhNTkg2SUdXNzRJZktnNS9INHBwRlNyWWdj?=
 =?utf-8?B?K2dKaTg2WHZsQUxIV1ZjaFZkajlsbFNTa04rUUtXOFY3c0dNSnpnc2NpRWth?=
 =?utf-8?B?SURWVWFPMStMalpEZWJVdEZhQzFKMW9tUlVwTytLeFhyVjdvRUhtTXF5TjRW?=
 =?utf-8?B?R0pjMmFKNnNpWjQrLy9BVEdWaE1JaStJZmMzWTJMWFFzSkVITWpkNjBrWk1v?=
 =?utf-8?B?KzhFcGQrbGFNM0xKTlB2OStEYkhvYm92bk5mOHR3MVhuM2xxek5Yb01lUjZS?=
 =?utf-8?B?enpQOThjcUd6S2FkR2IzOW9qNDQ5SVd4QVBtMXFQaVRSRU11eVIyRFBDM1VP?=
 =?utf-8?B?MHZnWEZyWVdmb3VrWnhTSFNpTnZlRHNtQXVFSWdGVlQxVWlvanZZdlJxcVR3?=
 =?utf-8?B?M3p4bXEwZVU0V1ZGTzRzNHBpQjBnVlBJdHd1bzdSeG1SR1FSUm5zWDk0OXhX?=
 =?utf-8?B?VVVXaDZvcW9kWkpwb28zQldXWmdFM3ptWngvU3BkZjVjcURqc0VhOXM5NUw0?=
 =?utf-8?B?cXlwK3pzSERud2dFUmtGQlBiWTRaMkpZYkhrQnF2S0EyekZTbUh6U2gzdUta?=
 =?utf-8?B?TTk5UlFDTGtUZzFMbEwwbTE1TVFKQTVMMkhZRGEyTlByTjMyYnJUTzgxTjli?=
 =?utf-8?B?Z25BZUNkQTBzZ3duS081NUFqN2lCRDV0MXNaQkQ3L1RPMjlDazBtRjg5bXNn?=
 =?utf-8?B?WEVibWMxN1Q5U09lVHJtN3JEbHFoZWIzUGN4MlhiN0p3bitBL0tiNG1YOGJa?=
 =?utf-8?Q?AWA9GotT9l7bUOh5LZOfIKTdM6ekeLHGmwis5ML?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1hHSklFR1dMNHdrVDhndzFXNXVGSE5NQjh5MnpFV3VFU0ZKSWprQ0JqaU9G?=
 =?utf-8?B?c0F5RVJmMktxY3BQanpYRUpRQmRUR0d0REp0MDEzK3kxUmlXdjEvODZDRkN5?=
 =?utf-8?B?MDhFNjNUT0hBRnUrRXNrQUZCUlZ4Rm44Ri9vZXo5ZUFnVTI2cFdEL3g1KzRC?=
 =?utf-8?B?cnVKU0xvQW1LSE5COHU0TGZoRWtSSlRWQjgzeE1ib1dRaTdZOG9EejhGMDNY?=
 =?utf-8?B?eDRZb1owZmFHWVVjWmgzaWZnRzRGU3M1aEtNOEdmUmVTSmNka2RQY3lPZHUy?=
 =?utf-8?B?M0NaVE03R2FHSXBnOWxBaW53Y2hKeWxRd0REQkxuWkpIc1AxZ2E5aHVjd0JK?=
 =?utf-8?B?RHpuOWlGeko0NEZ6SVU1bVVGbHVMYnBPd0NqUXhXOC9mMmIwcUlIOTg5ZGtH?=
 =?utf-8?B?SWQ0dXp3TWtSSDIyZno3MHN5RkROOWMraUxIYklGMnFuSWZEcHBoMFZGcG1j?=
 =?utf-8?B?WkV5QmdJS1RiRTlZMVFOWkMrS2ZYY3A5TlBzcFg4WHJjaGxKcjkraExyM1Iw?=
 =?utf-8?B?c2JNYXNWSXlYQTNQZ2taWXZHMzdiZEp1Q3VzTnIxdTNEVTdwVE5yTDNFL3hq?=
 =?utf-8?B?RGs2Y2xwdXdhZXJPdTFTUzlhbS9mZDE4aGVMS1ZhZzR1cHhUeU1hdUxBbjI4?=
 =?utf-8?B?N2tqai9sZnhyMFp0U2YrcndaTk1icURjSFFWTE56aXZxQ3B3a2ZvMGJNcVJu?=
 =?utf-8?B?d1JucWhKSnFENnZFVFovZWFIWU96ZkgycytrSGZYMlpTNTRRb0xSOVVyaXkz?=
 =?utf-8?B?Mk8xYnVLcVpCakpiNEdQdHZSRERiWnRrSTlSQnRnM1hMSGNIeEVvc2w0VnpN?=
 =?utf-8?B?cFF3c0h0L2tKaXoxTGwydHRZWlY0QUs1eXJlNWRwaFVMOVNqWDA5MGNXOGI5?=
 =?utf-8?B?eE5YV0dzN3Urc0hLZ0lvcTE0RWhjaEhhU3hLZ0NNUUhSQXI0MUhaak5YV1Qv?=
 =?utf-8?B?UHRQYkN2T3ZHWmdIWHdkWSs4UWJjNXBiYm8zRThYSXcxdGwwWmx1Z3UweW92?=
 =?utf-8?B?dzlqZ0Y2WUpMLzB6NzVmTzJwZFFtQ1BRZHpTendqU2Q0elVzV3ZiUktjL0tk?=
 =?utf-8?B?T0ROUHUremIwVTZsTm5EOEIzekhHK3Bod0tIVm9sVHBRbUZDMlpteFZ5YjlN?=
 =?utf-8?B?dGdGWUxxUzRsS2JtbmxSWW8vUDNNYnlEd2RHVmw4ZU83V2Y0STJlbU1UMUlN?=
 =?utf-8?B?OXZPT2xRclF6Nm1uS1ZIR3p0QnlkUjVGOE1WTHJwQ20vRmV6MWMyeGxZVWJ6?=
 =?utf-8?B?cTBFVGxPc3NxY0JVajJYUm4ycUNNSjVWNWRIT0VmSENlSEpTR2JDcW1xM0xu?=
 =?utf-8?B?WWtRZkRZUnJOc0lkRVByM2JycWgyZnFzQWUvVE9zbXhiellmN3h2N0FkRUNi?=
 =?utf-8?B?WFJUVEQ3cUVHWksyZVFKbzZ6OGMvS2wzWW9lK1FjTzN1aU56VmUwWEtiblR4?=
 =?utf-8?B?OGhPcVlLYkhpYXhlMzV0L090WU9wUndsZ2JFVUpjc3lFTFdoK3E0NFEyN09x?=
 =?utf-8?B?VjdrN2hQMU4wUzBNU0dFZmdDRnZIUk1QYjJjTS81NWVEVzY4ZDEwRGJSQ3Fi?=
 =?utf-8?B?Y2N2SmtRQTdIUVcvQkxmZTFPMEc4M3lGU0ZWbHU3VmRtRmVQTHlSL3dIVENt?=
 =?utf-8?B?WXhzS3VaVHptQm01ZUhJMzJRTEpQZUx6NnBRK3QybjByb3F1OU5aY0V3cXVx?=
 =?utf-8?B?R2ZwZlZmNTVmODFqemt3OHFWYXUrdkFVdGtmMFAyZUwwaVNlamF5SXdlNGEz?=
 =?utf-8?B?bUY1WDBlOExYaXczVGNkZ0o5am1reVNNWXJibmd2a1ZjMjJXcmJIb1ZvaUZQ?=
 =?utf-8?B?SldBcUVGV0E2eGJjeS93QnhEaEo3OFFHU1E4eGg1clQ4ekRuRkgrdlpteHIw?=
 =?utf-8?B?REVWMkpuTm1LSWp5MnN2MDIvWmtpeStCSTVvcFJGcEpvaU1hanVaSEFMVmxW?=
 =?utf-8?B?aFRCOWovbkFENUdIOWR6VWVjL0U0cmQzbFVoOFVJVktpTmJaZU9uRkVBSEhs?=
 =?utf-8?B?N0NYdFFoeTg2cmlWbXljNHB0enNpaDF6a0Q1bnpDRXd1eFBqNTZEcHgyY0hk?=
 =?utf-8?B?YzBQWFI5aGFxTDdBZ2IrcFBXVkh5RGxORHpUUHV1UFQ4ZS81cE1VL2pUL01h?=
 =?utf-8?Q?JIzI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c30ca1-5c08-40d2-c43c-08dd099576ff
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 18:59:30.9577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5N3g4cxPRIv6iXwkRG7bQhq6Iblj1BBF0RfmEkk2VW+lpLfsToE667/73QAHhWgg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137

Hi Reinette,

On 11/18/24 13:23, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/29/24 4:21 PM, Babu Moger wrote:
>> Configure mbm_cntr_assign on AMD. 'mbm_cntr_assign' mode in AMD is ABMC
>> (Assignable Bandwidth Monitoring Counters). It is enabled by default when
>> supported on the system.
>>
>> When the ABMC is updated, it must be updated on all the logical processors
>> in the resctrl domain.
> 
> This needs imperative tone.
> 

Ensure that the ABMC is updated on all logical processors in the resctrl
domain.

-- 
Thanks
Babu Moger

