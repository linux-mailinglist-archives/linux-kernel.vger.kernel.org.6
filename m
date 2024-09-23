Return-Path: <linux-kernel+bounces-335741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1126497E9F8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345F01C213BA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AC8194C6E;
	Mon, 23 Sep 2024 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2hSvwm3h"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E763197A8B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727087643; cv=fail; b=hIxkhU7XZjcegkS/y340cDUs59u8SKgkDoJ8YPcKpYwylu2tEq0TuFDG3yXc2KWI9L53OxL1hUySEmn7tu7q0dhpnTDNNU8iPU9j421hcuRQ1RrEHudTs/wfQpVM5sahl2DrQ5A7Rf3u2gX8YPbpW+gS6iQbo5h5Vp8gW5wMYZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727087643; c=relaxed/simple;
	bh=qidizbp+oSWWPPfLK1CnC7+ybZsqcKhMWnCceWwap50=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aqyg50QnLwwk2wjZMMWg72RGA8XGheXKCxuKI+yPi/Vc+ypEOPKqklIN/yWHoT/R80cWl9EAPBWnS9Gwk3wZBGv39mnPVeOLS3qDrfES+0Lnuap7WK7TKQTfoLLRS6xL7uxgDzwii9gopXILAPvdUdhMRCWDrEx1+nsUVxkD/9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2hSvwm3h; arc=fail smtp.client-ip=40.107.102.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAk9VAojByrWd41B4t1XsTJbF+I+G5yuiR+gOB0tUz3iXq5puBEP9JmHg5hDWJjUHCE/e7RnumBunVFfC8rbCyq28n/E0UAUCNaiIvrmprO4j7jLfsdtWCxYFmlg10e2zd9+CyiuXI60EF7BVBr6OZOi20AlSEUPIvkao96h7RXsIvNMzYAbc1x/egWeHT3x/l6HswsUq607d70oeRl5CQtlckcDzwbBA/Z3UJVhKlIfCPNzcEmT3wy7vZEBNTTUWZ926Dc1h1XsTYRSGcehtw+Gw3KyI96oHXMm8GUgoYM37wmt4TSX4aR5gZ+RiayZJsid6BwrVfaxA9OoDLxQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irfb1lsE/USIfI+iqvbE2whCoJoienBUb6y7E3qLnPQ=;
 b=cjW6xieOiKfjHWx9bcdW7fsbCHPf1k4CF8ZMufTqw4NwKUXgqAyKOV8BmB+Kf0UFOHk2mQUsYTPZQvLMBZyhGVcaS4T8lfMRL2ZZ59A+gTRrbr317SbYUeNGZyxFydCCjlT4yweGVjg+vCoFPNX+Gct+2bJRSDIIeynGhAYD36nt6Ez8kSHSalRqFFFAU4SCMAjQX9wBDGKGyXi1DeJPm15cxPnnOdDl+0t2+pHeVJ/H9i3/WzBc5KI+rLxjcgdc7K56LQVMc7m9XjxO6leQg6fTbJDtvaNh8FcwcaRGFDCNgvrng4IbRIyJdHPURDnR2vtc7/vGdtLQ/Q+xLoiorQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irfb1lsE/USIfI+iqvbE2whCoJoienBUb6y7E3qLnPQ=;
 b=2hSvwm3hr3A/3GJxmGnHKEEt5Dbbb+PYAnLMaMcH1cHxc0dZ1byeJoDqn216LCaOb6FTF+8RkdwVNOedOgA45+23bShDMj0o94lsBV0Gu+wnxmtlK4h1SkGkX2R3x2ka2isWTX0/YxSDu16pWy37V9PKwrXowm21uTTWwwRbWe8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Mon, 23 Sep
 2024 10:33:57 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 10:33:57 +0000
Message-ID: <e9ddcfb1-b3d3-4ac7-a21a-b7543f449547@amd.com>
Date: Mon, 23 Sep 2024 16:03:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] perf/x86: Relax privilege filter restriction on AMD
 IBS
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>,
 Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das
 <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20240905031027.2567913-1-namhyung@kernel.org>
 <20240905031027.2567913-6-namhyung@kernel.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20240905031027.2567913-6-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::16) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 6595142d-d060-4fb3-ecc9-08dcdbbb3a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anRFR0dwbUtyWllpc3MzUDQ3K3RVT2JNOTFaRnpobGFXUzFpbVM3aFUvM3Uw?=
 =?utf-8?B?ZXowS3FJRExTbTcxVXpnU1U0dVluVFRibW1HRkRMTTZtR2RONXNSVUJ1V0tx?=
 =?utf-8?B?VHFMdElIUEpHK3YxaGNiUVRVWFQ1a1dsTG50NkUzUHNabFpYVTJWU1d1M3BX?=
 =?utf-8?B?c3k2S1IvYlJKcUt5alNwY1h1TmZPeHJGaldvc1Bkd09zNHgrbTdUbnp6emJt?=
 =?utf-8?B?N1h5QTBkYjZYYlZjMXM0eStjR3ozcnRabjBidGlPMS85Lzl2eGtUdW5KK2Zn?=
 =?utf-8?B?elU5RCtjQ0s1cUZwS09pcXQ1ZHYvQTBGRjBlck95bGE3UnVOVm1zOEs5a003?=
 =?utf-8?B?YmV2cUVsVE1iOFRrbEpMSFFsZGtsVi9Pd2RiZnRiOURIcHVFQm81b1FLaUsw?=
 =?utf-8?B?YWlzM20vaTBGc2JkejFnaEd5Z29YTkVNRnRrL3R2OU1EN2tzK0VVQXZoTlNy?=
 =?utf-8?B?d0tyejFGVnpwSmcwUUQ5MklqSHE5UDd6VGZ5OFBrZjJZNUd6SmlEaFlkNUdF?=
 =?utf-8?B?SGNLWUJ2L2RZYzBqTjk0QnVhai8rQ0szL0lCcFVCL2pza0FGSDUxK3IyM0ZX?=
 =?utf-8?B?MmRxd3p1S3N5ejgyMlpsd082U2ZvY1Z0c25QdDhaUmVvMUpYL2dYZzlEVVEy?=
 =?utf-8?B?dTBjeXVIVGE5ZlRvZ3lYUldiWVFzN2l4Ujc4TnRzZHNJMThDaTVuczVpU0R4?=
 =?utf-8?B?OTlDQnRISFdDSEQwSVRwckV1ZkFXNm91ekI5U3BuSURyeWh1U0dpYnIxakd3?=
 =?utf-8?B?ZGV0MDQrWWR2dlZGRGovbFU4Uk1MbCtOczJqMTRNYjRjS0NKNDFXMFlLMWcr?=
 =?utf-8?B?VUN4WWdYVG1tUThCUXdIQzNYTlZUVHZQaTNORUpVOHlWOFY0YlhkQlRzVjYy?=
 =?utf-8?B?OXFkamlFb0M0MFdqYlU5d2h1UUNtcnFYRzQ2TXB6bFg4YlVjem5TaXhDUFlo?=
 =?utf-8?B?Q1ZBOGFkRkF5S2VTbWkzbkdsdUI5TlU5eXNrclJhenZBTkJPUTZrbmV6RXBN?=
 =?utf-8?B?NVhzbUJrbFFaRXg2am9FVlNYb2ZYL3lzbTRwYnRyQUk2cHQzKytnT2NxM01B?=
 =?utf-8?B?eEpaVFF5djlqTFlNdElUdG9pZVFjTldnNGZKWTkvLzdLRUVOV2prYTNleHND?=
 =?utf-8?B?c01kUktaUlhFY0ViNjJkc0JQZ2RjS3BMaS90bStjL3VBQitsWEp5c2NyNWRL?=
 =?utf-8?B?anBIMTl1VVc4dnZCRG5tNGZJbTBjSHdoRTlFMnhONzh4WDFacXV1MFlQamJj?=
 =?utf-8?B?aS94VnNJK3NJcmdxSE5nalVYQUR4WHpHZGZZeHhkSFJkS2FGUlVrMGFwcVlj?=
 =?utf-8?B?ZjdvcGtmTS9RK1lXcndIREVoMDNod0xZVHc4K1ltenljNzljaTJYUnIxVE9Z?=
 =?utf-8?B?TTVmVVJjU2ZLZ09JYWdEQ20vUEJ5YkVMc0w5YWEzaEZrTWk1enRCdlJwbHlj?=
 =?utf-8?B?bW1kSmY2NEFsWkhTTUZvK1NQbFBzTTVkS2xRaUc0VU5lK2pTU295M1ViaVFa?=
 =?utf-8?B?bUUzQ1grcUtnWU9JdVVmU3hDSGo1c05YR2JQWmdtR2R2VU1yQWlNTkdXNVpN?=
 =?utf-8?B?L2UySHN6ZlppR0JCdlVJYW5DZGo2WWRlU2hFSXMwblhEZUJEM1JDejh3b2ti?=
 =?utf-8?B?d25jR2ZXSkFwbnFiR2pWbWtjcHQ1NFI1eDRScTAxMUViZnNEbFh2OFlPeUV2?=
 =?utf-8?B?T3VnWUoydXJaMmg0U3NDblVtSDJFWlExdWxkNjllY0JkQXdMWTZhMkRiTE95?=
 =?utf-8?B?dzhYNjJUaVJZV1dNZHdGYlU4VEh4UFRrelFjeitnZTFYZ2UvZ2RLUlh1YklK?=
 =?utf-8?B?RVlCNFRFR1RLN2dDMnAxUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3VJTy9CTjFDYk9LaVdtNWFVNHl6bWxEa1lYajk3RjhCeGJrQ2R1TFNCVU5O?=
 =?utf-8?B?eEMyQTRMTVcvTlZBSGVBaHpkcXJlUWJvUHQzQjVtdmVxVHhMTGNOeHBKMVN0?=
 =?utf-8?B?N2ZvdW81VFo3REVaUnIxVnpjeUNrbDg5RmRYTmRBdmd2ZkkwdUZuNStzRk02?=
 =?utf-8?B?Qy9kMnRkYmRVZDZXcnN2N0g1WVo5cnNjVWE1QnBTempNSzlPdGtYU2w5WW00?=
 =?utf-8?B?SEIyeXNqL2Z6ZHNlc3dTTzhwZFprYkUyZWQvS3AyenpoeXI3Mk1ISlJxWUJx?=
 =?utf-8?B?UkhweW4vanVGVU4vSkFoMURRVFFzZG5QT3g2OFI0VFhxeCtmS2tHQWc0L1hh?=
 =?utf-8?B?VTBPVlNjWDVkcnBLZzNxb0dyUTBGQnlNQlo4S0VaOGhNVmdkZk5ZZHNJdnkz?=
 =?utf-8?B?NFEzTnVjUmFRNlpCem4wQ0NrY1JFQXQ1bVp0UUNad1VhTkxuNlZ0SzFLUlVn?=
 =?utf-8?B?TWowUUZEVS9qb2ZlZ3lvYUh5R3MwamhhMzdSc2V0eFNqVHhUQ1RWL0dOZ1Rw?=
 =?utf-8?B?R08rWFNzTnFwN01WczZjZ3MvY0trQ0Fva3lmc1VCRVIrNzA0QXE5VTJFTkk4?=
 =?utf-8?B?TEVDTElZaE1Ub2ozTXZobVNPQXFGMy9DcmpmVFNOc0lrOW1xdkptM04rWDNm?=
 =?utf-8?B?SnpVVVEzaDRTNFlFR1psUGZKcXM4K1ozY3FyMWhyNExTNnh0SU1SaXFzRjhk?=
 =?utf-8?B?WTZnMFFFMWJVMUZzVXZTMHdmRnFhbTNHZmoya1Vld0cyMll3ak5IYVZJNlFV?=
 =?utf-8?B?Qm9HMW10b3crU2NHcHA2L0p1K0h2KytaZkg0Y1hQMUNhbDFubHc2aXp0ZWJN?=
 =?utf-8?B?YU1venEyYk50QnF2T0xqL21YTHhubVp0NDAzUUFnZlVCTTY1eEhKUDRRbFJv?=
 =?utf-8?B?Z254K2Y0RkVsSmpqOUlmSlh5bjNId1M3UmM5UnpqNktXTCtwWk1TREpCblYz?=
 =?utf-8?B?OUxyRVVEV1NBWWgvdzJUYVNxNXNrSElheDJ4aENwSk5reW82RU41K09PZVIv?=
 =?utf-8?B?TjloMDJySjJCVXFKSjA2LzRPQ3B1NkpxaUs4MysxbDAzMmRXejZzSWczZDJ3?=
 =?utf-8?B?Rzd1WXdjUnBEUzVDQlVJelAzWjlEN0NyaGpjbjM1UnFENDFJMWJUYjRKTFlC?=
 =?utf-8?B?bllBWlNBOW9OU0krd2dXa1ZIdS9Senl2VUZVaURLY1JiK2p1Q1I1aXhNVERZ?=
 =?utf-8?B?R1FnRjZqSTg0SDdMZmkyYlhvTjJ3bHFHb3BjcGNRTERNR2tGS0RJRVBxdmxO?=
 =?utf-8?B?eEJCcnJGbjlERUdZK3JBRlN5bUNFUlcwQ2tEV2xwZFVLUEhoWjBOa21Uczly?=
 =?utf-8?B?V2dZWks0TDk3dCs3UlpSRTVSWTl1S0dyUk5wblcvcmNzZWEvV1hFVnl5aTdJ?=
 =?utf-8?B?K1F5eHQwTEhNQkRFdWwrZURYK3BwRU52NTk2WUFGSUNJNWZsWmhNdStGMnBh?=
 =?utf-8?B?WGdMUFFHOXNlT3hqMDdRZlovaURzT1pUckpscGVNaGlZdThGNittcW0xSmRX?=
 =?utf-8?B?K2hGT0FEbzhvMjZPcFBSL1liUzRkdzNmL0Vxa0VLdUVnRmNSemcxcFVFeUtq?=
 =?utf-8?B?cWhVbzZKT2RqWC94VVU3R3VPU1diblZ2cHg3QTR2dkRoOGI4bXhibzNBRWh2?=
 =?utf-8?B?cUozZXVUVVlOWUk3djhUano3ZW12RXNVd0tLTDEwWFVoM3FpSHpYZ2JKYkpP?=
 =?utf-8?B?ajNNci8zYkhuUzVkQ2VEeUE4eFl6RXI2NHFkTzRCamlEQlVVY0JwR2R5NSsy?=
 =?utf-8?B?c1E0QlNSZDVqa3FXdzN6L3lSZXRhbnNsUzZwVytiUS9UR09XK2pzQW1FdldQ?=
 =?utf-8?B?NW1jaWc4RTJ5dzNQRm1PMzdWOVhoc0tGNnpsbExWdDl0MTNzV2hxYU51WHpF?=
 =?utf-8?B?NmJnNllzUWlIVGtWQUl4SnMxKzh6QktCN0I1ajBUNDN6TWZldll3SlAwUDlm?=
 =?utf-8?B?L29mZEVkd2gyRTFnSGJmb1Q2SzhwN2cweVVlUGg5OXgyOWpvRVlBa2RmL001?=
 =?utf-8?B?RTFrTkJ1aStHcjVaNTRMMXhXQWtwN0dtejlsSUZtZjdrNTFkL1dJRHhjelUw?=
 =?utf-8?B?S2trSjJ3NWlQZmZXczU3d1RqU09jbGdpemFnMWxFZEkwcTNZQnoyR1VudDJF?=
 =?utf-8?Q?CclzBeIZ5WKbeBrungfq/Pahq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6595142d-d060-4fb3-ecc9-08dcdbbb3a77
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 10:33:56.9840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qWKYRqr/rOJ5wlATjhLKZ6Kca7Mf8b8VAX2OwZe7B20rOqP4AelpXIxxH7CCLCkH01kDKWXKQL2ISkQnzmedw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740

Hi Namhyung,

> While IBS is available for per-thread profiling, still regular users
> cannot open an event due to the default paranoid setting (2) which
> doesn't allow unprivileged users to get kernel samples.  That means
> it needs to set exclude_kernel bit in the attribute but IBS driver
> would reject it since it has PERF_PMU_CAP_NO_EXCLUDE.  This is not what
> we want and I've been getting requests to fix this issue.

I'm working on some IBS improvements that impacts this change as well.
Is it be possible to hold off this patch for some time. I'll try to
post my patches soon.

> @@ -1111,6 +1127,12 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>  		regs.flags |= PERF_EFLAGS_EXACT;
>  	}
>  
> +	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
> +	    perf_exclude_event(event, &regs)) {
> +		throttle = perf_event_account_interrupt(event);
> +		goto out;
> +	}

Throttling can give surprises when the sample period is very small.
For ex,

  $ ./perf record -e cycles:uh -c 192 -- make
  [ perf record: Woken up 52 times to write data ]
  [ perf record: Captured and wrote 23.016 MB perf.data (705634 samples) ]

  $ ./perf record -e ibs_op/swfilt=1/uh -c 192 -- make
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.608 MB perf.data (19 samples) ]

It seems like the IBS event gets throttled (and disabled) before the
cpu get a chance to go back to userspace), hence we end up with very
few samples.

Thanks,
Ravi

