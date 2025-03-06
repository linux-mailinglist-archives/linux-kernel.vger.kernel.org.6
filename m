Return-Path: <linux-kernel+bounces-549932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC85A558C4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC26618966D6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3722517A9;
	Thu,  6 Mar 2025 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t3oWV0v6"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC021EB48
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296580; cv=fail; b=pLbbK9AlQxH95+F2fH3idQvCRLVy/sql1TM7pcmyZrmDymSRGiaCW/8JSBsw1tEJY3mIPreIM7X68NFvK80E1CNm7N11k4op2Vc73wGBopyizPyRGorqkZrQQ8y9qveV9IXvlL4nqdALldWgbHLqI8kWgzisJG5m3yGTejwTy64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296580; c=relaxed/simple;
	bh=fZT/91a2q6BRVBtMn0F58AtKRDHtxqsV9G6JLuZrOSQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nxo7jkLi9TYHxg5eZ6XTiPwyPxN3AkTVcjHIiKtF81mcCeG6VlZeZCBJ6CWf6+Tv3MA/pzAuXADAAxz6Fixi0IvOlVynfanDa38pD2ATTH5MAbO9nt1AkPV1pAjOOmJxN0ysZ9ijIid7UZ9lQ1nhjswBMqKo9COLLQ061QwXpOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t3oWV0v6; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFafDvkXEjkRxin9ZkL0HZcH55D7F2Ue9stdm4955ftLdv7i3Jki8Hq9jjhIZmufSibpLrRhxibl/+NXZDPT7+ups0yvoU39eoNEL+qo93zVFaBL7vZmWa9ullTQNgwj007cZFrsZMsxhzWz1g2C0NbGGGVH9hcPk/4ddtDuRDehu5gb2P/XdfGB7hcPmbMwzFq2jClzUAOFh80RGDwFSm6jXjcmi6CgHE46oF9A0OgFDIKGzuUMvuyzI9iyzw17CW2HQyl5+Ynl9b0CwAQTCjdHZFZmyAzcEodFvKfp9viO2kKQ2F6MGoBiMw+FNtYsUJVEHnkqxoz7uz9e6AKlMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZT/91a2q6BRVBtMn0F58AtKRDHtxqsV9G6JLuZrOSQ=;
 b=wXJDANdw3hfLXE5evlN8yK3h6pKUp6JHduX9OXms1ESjXFC9Y+vP3Fyy+jIKuP+mcRB9gRybYtduawDkAjxNEbnqVBuUKO6N9NRXwurZw7kxIHdw9yi2zsJInQzk5G6Rh3u/A3vjodFTx7qKHO7YaPCFNwPLhL1F/3cnEpY7Wtx/L5YffU0SFaSVkhlIADzodovE64/aEBxzJiv3zXhtR/4kIzoZL2NnaMdTz0V2jEimyaVyJ7YeefQjPbqO2VfXIYNrQevuhECE4C326rZkAzhhkxMdbd+Wrgq0lSQb+WfTQ4fapl2MZDTYZ2CLAO6ZQhtI51ESujPRFS1zT0ya6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZT/91a2q6BRVBtMn0F58AtKRDHtxqsV9G6JLuZrOSQ=;
 b=t3oWV0v657JhFHqnjbaZBQCs1UZytvbmZ4ZAEKUi3xhfIuI78oPLr3UNGm+Zpk+u7oyZ03AKfheTLvdY68ZjE5mLkk7ZimK+lQfsLNYoQe/nCKyiL0PsGG+c4t6j1vjhSWGuOgW/IfsDikeH/ujLDjTHoOpdZQCYNRJ9V0A23k4G6wfPf3j+mukElJZW9CZVfgWTX343Dv5jRkavD7hrsA8QDHA3H+GSO663vFLbpJ2zlWx9t98OUqAhjQEbSXL3uUQ1G1gJ3qzE/dHiwlaSL2M9TkemfloG0QbS+EpdTNRL9UkNHaNz1eo5ji8h1TUQSP3JeAmr1J9P5qY3rewsSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:29:31 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:29:28 +0000
Message-ID: <eeb10b74-1974-4a15-804a-220cba163d85@nvidia.com>
Date: Thu, 6 Mar 2025 13:29:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/49] x86/resctrl: Move monitor init work to a resctrl
 init call
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-17-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-17-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::26) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3f3659-d609-4e37-8a77-08dd5cf5f9ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnA3WjJvc3o0VVVwZTE5dzVWcFlTRU9SK2p4cVppY1ZpTTZpbk1aTGh1aTA3?=
 =?utf-8?B?YUxPeXNsV01GRUIya0UraEoxSDcwclY4ODk2Y3l6VE5LUHRpbm05d0Z1WHV6?=
 =?utf-8?B?REI3WjJaZzN6U0llNUtBbzRlTnpSTCt6aUxOMnAxbzBoOVJPVHh2Z2t4enJE?=
 =?utf-8?B?ZzllYlFDdGxSV2s4b2NVdkVmT0lOZUNnOWxEQ2lrRXFpZ28vOWViRXFFRDFy?=
 =?utf-8?B?MWgyeUpZVVA4a2pLc25BMlBBMVY3T3R5OVJxQ2pVSTlTbW00ZG1wMXAxb2JM?=
 =?utf-8?B?a3NLNk1KNWlVYkVCbWJxWjhhcC8zM3J4djdFdCtlWFVRRE41aFhLQ01VMWdD?=
 =?utf-8?B?bVZLdmI5UkNOd2czN3c1dSswVDNiMGxIbXQ3WjJnWlpXTC82NFBmd0cvMmpS?=
 =?utf-8?B?alI0ZmZVTGhQT1BDL1FWMHZaVzAwME9IN3loZmxoR2tKSVpGM3dDSE5FZzl5?=
 =?utf-8?B?ZWZYOHZYR25OQTdTdE91V21PaE1qTlVpNEZDN1djYmVWZWd5WURNM01OU3BR?=
 =?utf-8?B?NG9LVXlzZldYOEV5OXFiVUExUnM2d3lqY2ZYa0hCbTR1YW5pdWYwV1dNVVRW?=
 =?utf-8?B?MVhpL3ByMnR3OUNkRnVSeDlxMlFxcm5PQjFTSEoxS2U0WjFoQkk4cktkaFA4?=
 =?utf-8?B?blV4ejlUd0dtRnVIZm9Fem5INVJuUXZDYysrNjY3MlRxclNHb3A2YllDWk9S?=
 =?utf-8?B?ZkRPcVVmeU5HZWU2Qit2SjZFSHJlU1g5d1Q5SVlCZysvOHRyY3YxM3ZNNENV?=
 =?utf-8?B?M0JjTW1WdGc5Tnp1cEg0MUZLV1RTcGhxdG5lSUZhTHNFYTdZb2JUQ0NKMTFZ?=
 =?utf-8?B?R1V3dnJFZVdUczFNckVIZTlNdVFWaHFMcmZDdkZsOFZSckYvUFdhSVVCY2w0?=
 =?utf-8?B?bVpjTWxRdlZNQlBhUEFuUWVoNUgxNFNGSHp4WVdjeWlNaWhMVW1EbkczTDcv?=
 =?utf-8?B?TUJWMHpNN2VIalJSeFNpVEp6QXpNeUlzV3BrZC94ZHBuZ1hhcXF0NUtHcnFJ?=
 =?utf-8?B?cHRrTzZIVEd6VCtaL3ZEM0xZRzZtaE9DbVBEVUlqNzVsaVFkZFhJcUk5NkRH?=
 =?utf-8?B?clpYckVOZTM2MDZ5NDY0WCtPZ0NkVVJHamxtVDF6dnVCdkR2V2xHcG9MRmo4?=
 =?utf-8?B?ZUxHbnFCbU5WbGNhdW5xVm9WN0xzYlBhNkNCQk1WOVh6bHduN3EzamY2V2tr?=
 =?utf-8?B?NW9DZ1MrcStXdm1yMytWS0c4ZStrRGxxN01wT2lpVmFwNW5za0YyUkFMM2Ni?=
 =?utf-8?B?ZjBuNmFZUy8zUGtPQ2xZWnovZ1RmZFpMK0kyR25EaC9ZUjM5ZWpjWWJidjRL?=
 =?utf-8?B?aW03NkdFcnI4T2NiUGVLbm44OTZlMm1MdFVlcXBrdTBKZkZkRlpFdDA5TDZP?=
 =?utf-8?B?N1NKWDFOTnZXNVBGclJ2Tjg5REptakdoUitqZHRpaXVvMDFVSjVWdG9CVUZE?=
 =?utf-8?B?NUlxR1IyMVhZU3NiLzdYQ3BUUGRWVFZzZXg0cWtCVWkrQXZFK1U5ZTVPM1RG?=
 =?utf-8?B?TTdJRE14NWdMZ2hYb3YwbGgyNDY3Z0lkUldxTGJyWXBuVUtTQ2tvVWl2UHFQ?=
 =?utf-8?B?dGlQcTcyYTNYdm1wSmRPZy9HUjd5U0JjOXczNXB6bHFOSXZDNVB2VmRXWkpS?=
 =?utf-8?B?b1JhZXlHVmFhdk5SOU9RclEzKzdlTWN5TUJWRE5jbFhJZVhRd3ZBTkdBZ1Vp?=
 =?utf-8?B?ZnU2TzlLSUxtcitHWTVSL1NSbityejJ6WldqeW5KSCtQeGRiZjdKRW5aQ0ly?=
 =?utf-8?B?T0d4UlhNbmRzQkEwYWluL1IvZG52ejdVeCtGRGQ2MDdQTk1ua1VrVDB3ZFo5?=
 =?utf-8?B?TGxob0hUN0NxcG8vYll1MkJFaWhWMmJWSDJTRlluRGRTN0NqdDJDd2dsTHNu?=
 =?utf-8?Q?FbU2CHnUMurmD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmtocnpPcE8zNXQ2OTVkU1ZEUWsySGt4YndXVFVDSjZweGpBYUpqbklTM1lz?=
 =?utf-8?B?OVFrMmg1QzJOTmloazZlMW4zZGl1TjJsRCtndG1LTFdJUFhxczluYk9pN005?=
 =?utf-8?B?cy9MN0ZUaDRCVGRuYTEydGovSys4bnl4WVJCUERjSVE5dVR4QXBCNjBVTDht?=
 =?utf-8?B?L2Mxc1g0N0txWjN5YWNwMGxZZ1FseVR6N2tKazh0RUVFS1hkNW9EOHFqdFMx?=
 =?utf-8?B?b3JFVXZXdlRwcFc1dW9DbG0rRFhaR3I3V0hKVXVTcy9UWFJycWVUMWJSSDhM?=
 =?utf-8?B?U3ZRTnk0bnVzSjJzZjVDSEF1Q3pNVHpoS01YTzF3WUhQV2xQMFd0cld1Z2NQ?=
 =?utf-8?B?TGQ2VVRTcVdISWFybDNGa0dSWGJmQzB4cmpySStHcjhhWXUrb05DTGlBK09q?=
 =?utf-8?B?a1ZJa0c0dlg3dDE4RW5PK1dLM3ZtcDVHTXMrYkJadFdWRHY1N2xpYlFyVlpo?=
 =?utf-8?B?ZEw1L3NndU1rcnRkVlo0cDRBR0RWUkhtS2NBbElPVWRObXhSb2g2dHdBeW1w?=
 =?utf-8?B?QStYamZOUjJ6RjhkdCtxRTF5WkFUQnpxcnl5VEJJZndmZXYvN0FuMW1maGFi?=
 =?utf-8?B?SW1kQ0UvSWRLa2djOFJzK2NCVDdVN0RycU5QcmQrUGkxak1mcDArOWdRcC9w?=
 =?utf-8?B?cWFRNDZYUitBUGZFNUc0SFFHQ1B4RWpFOHhvVTVTOEwzQzhLaUhhVGs5b1Fk?=
 =?utf-8?B?M01sR3RFRERCdHl1aXdsRGhsM1RHcG8xVHc0Y1RIL2FjaFNGNkFKWEFpNHlt?=
 =?utf-8?B?aFBuMVppVWN6eVZGSDgyejVBQlRCYlBxUkRJcjFyQ3h3NWNFVXJsTlgyMXhL?=
 =?utf-8?B?TmZ2R3RqZWpxUVZjdUY4ZTAySXZFR0E2RCtranRkMUdxZHY3ZzlZeTgrM0pJ?=
 =?utf-8?B?SHM2SnFyOFRZTCtPMmxXZ1FnOFFNUzFwQitrZzVDQkhyZGZqVnpPeTl6S0du?=
 =?utf-8?B?Z1I0R3ZlUERjL0UrRE9IUy9zMUVjNkxkQkxseHF5K1QxMDF6UFd1TjY0L1Rq?=
 =?utf-8?B?VGVlZ0xmalg1VmpsMzdiUmhSNXIvWS81TU9zMGFiNWN3UjI3RW1MRUZ4WUky?=
 =?utf-8?B?aWl6SUlGVjZhUkFhc2IxMy81dUxXN2RXWFY1bHZCUi9jV2h4S0FUSDFLcTM0?=
 =?utf-8?B?Tzc4UDNRaitUWnFJRjlmUzRHdDV3dG13KzFpVnQ0N0hCYStCRys5VjhnTUhJ?=
 =?utf-8?B?bm1ZVElPdVlmU3BKSU8wK2NGOFpqQ2xsd1I3ejgzbGNMOFFwRHRibVdiZkxD?=
 =?utf-8?B?VjJSOUZFYXowQ3FpZUZSUXhGc2pSYmZGd2pTZkhPaXA5L0FpK2duMXlEbDVJ?=
 =?utf-8?B?Z1BWS1RDZVFYV24veDA0OTRqVkt3dms1QXBwZHZjT0FYU1NBeFowV2w4bEZZ?=
 =?utf-8?B?REpGU3VYVzZZZHliRmhDUEVYcHhPOVpxcy9RTnEzNFJKT2t4YXBJbHhIR1d3?=
 =?utf-8?B?VCtHNEVmcXp6SDFHb01hazR4UDJNems0eW5WTDFRTHpVYkxLdk1Ubm5Uc0gx?=
 =?utf-8?B?ZnR5T1kzYTRYblFkbWpMcG1mMFJZODFGTzJvSXNuZ1FvMllEZldxZnJIMXUr?=
 =?utf-8?B?ajhtVHdZSlA5b2RkcXR4RU1OMUJmdE9MeklFaCtZbnZJOTNucFAzZFRmbjQ4?=
 =?utf-8?B?UnorWjNtREU0QkQwUGJadTNuZjQvbmNocjJLYVYxdVl5QkRmT3ErdGRKSnVN?=
 =?utf-8?B?WFBzWkFRTENwMWFFMzhQY0twY1NJdkRWNit0R0c2RXNwOFIySHJ1aEtNZUU1?=
 =?utf-8?B?bEFNa1kydFgwcWM2R2pzTVNnelhJRElkWFJzdVA4QmRzM3BVUHBMQ215Q29H?=
 =?utf-8?B?OEIvMVpwc282VmhuTXZ5YXZBcS9HelowaGVmcERVUzlPNjhORW84UGFPNEdG?=
 =?utf-8?B?UVE4NXpzTUlpTktEV1hRbXJwdEFSbTBWYnJEQXRhSm95RGxGV28xczIreEoy?=
 =?utf-8?B?SlQ5WGVSdE43WXUvUEo2RWhrUG1SUnZIS1ZuNzZuOW5DUnJ0cERDelVqNG53?=
 =?utf-8?B?YWhxMWZpS3gwOG9WR2ZOQmF0eXJvWW14amZ5a1Q2dFp3RS84K2thVVhoTkw5?=
 =?utf-8?B?VlA0UjhxbG1BOVI4T3RlRFlwcDE2TXdTaWkxWGxRZHMxVjIwaFB5bWc2RUFR?=
 =?utf-8?Q?wkCyuyS5Wp8QmPLXnkKpWigSv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3f3659-d609-4e37-8a77-08dd5cf5f9ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:29:28.5665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXgtvWI3NzQe2DIH6C4xVS3q0LxEUywgmWxALMkJV7FpY7fpC6DFCfS0gFju/l9M3jnkOd+Sjj9c2/oQ+us4zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961


On 2/28/25 11:58, James Morse wrote:
> rdt_get_mon_l3_config() is called from the architecture's
> resctrl_arch_late_init(), and initialises both architecture specific
> fields, such as hw_res->mon_scale and resctrl filesystem fields
> by calling dom_data_init().
>
> To separate the filesystem and architecture parts of resctrl, this
> function needs splitting up.
>
> Add resctrl_mon_resource_init() to do the filesystem specific work,
> and call it from resctrl_init(). This runs later, but is still before
> the filesystem is mounted and the rmid_ptrs[] array can be used.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua

