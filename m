Return-Path: <linux-kernel+bounces-418858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC549D6669
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 00:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3927160F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FF71BBBDC;
	Fri, 22 Nov 2024 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ywQ47duH"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893161885BB;
	Fri, 22 Nov 2024 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732318585; cv=fail; b=epUdltfKVlcDD6wgjvldDR3Asxf57/5iwh15XeRvLPSIg6eu7DmWXBKMGMN6a6tOL477Cqip7lGTzANCimJ5R8UqnlE/1ndJefHymxSvK2nEYEIPZlnDMtnYju5SolFfwqtUSE7DV/5SrZAujRKLl/UxsFLu5F5kLv/erIaLx44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732318585; c=relaxed/simple;
	bh=y7k7oDWm7SjB1F5ZeH+tUgtcNe4q6670ElGToyNnlVU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o7wmdtXWRZ/BkxGP1hwMUX9S4PxLkdeuPFMHts1r2LWIgZdgCxzKfaWBWy5vsSXea0ScNZeZBFQGCORBGVzGIswqmG3YJRN1lHsdH422gV+j6y78oPCweYjbf6pX/PvUSQcXiYXaUsKJ8S+tE0ToW3/1Bw6w/ivxEHWAhMqHyM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ywQ47duH; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/XriSb9/0QH3J4FbBUr/2RWxyoyxUZ28L1Agl3OLlRmQHq74bDXq/LtB2R+k5HDCR7gsvz7pRa0ZnkwKxTK7CfInmXIc4jRf3zefDjg0UrfKaxNLGSeb9E2A0JMeSVPiKqxwVbQyC8uXRR4J3EdwewWNsukf96IGY07ckzw3QRdP4vCyhH/Wml6Jv5sTY7A2NB6SsqGnrvrpgzkXNZZ0+8Qlv6m2mftqHQMaRv1fVM9mkUu045HgGvIdOFcCG02t3RlS34YWuw9YGKBoHltWCpgVWpF8GODcR6KgTZMxo1E6yRaUYgduyOhjXHK6KnUo4uZku/fZZrSjtR0wrNtsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcw63pxxk1n7e2Sxpxeglm3e9XPCC4nDgUsUc+qCIRA=;
 b=lMvL0NylwYLkQWTynsjAv98u58d/aDsb2YFVo6cE17RfOMVvjm4Q0VkIv0PSv1t3Z6ukJqkpk2GBVNwFrXbEMgdj410ShSF8vg9so9B0RhL1q0aTCctzwEXPGBnBpAloVS/Nz1tVoBOUmniXJCN6Lgs3zGNkHDNVkSC7GeRliiLpqJNWh+hugkZgtn1vGtjxLGiR8Sbi7xt8SMcFjqhfEeCWw72rjc30s4Q1h/L4sRcm3IB9deadq16t3JQUgqj5ufY4x4TmifhBRmqvcILu/SndqAY5PHy1vGAq+sqcbdaqM+GJLS6vwCZV0IZKOJR2OuWC55T35T4CSQhtotiBbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcw63pxxk1n7e2Sxpxeglm3e9XPCC4nDgUsUc+qCIRA=;
 b=ywQ47duH6yz8DcQClORVBWXyJHZmEC04PwbhQMczC6YT5s/Lv8JmDzGgVC6e7zKEpAmlxuEdfrVKNMO0zJeF3hWpIYLnVsunLkStE4EbaLB9pQpd+rzvvblV8hik6+ppM3M1MUceUEjgiLDNxsFCQTkpMY+YkuHvr62nKFhErGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 23:36:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.024; Fri, 22 Nov 2024
 23:36:19 +0000
Message-ID: <ef92f1fb-086c-4ee1-b8ec-e08ed68f963a@amd.com>
Date: Fri, 22 Nov 2024 17:36:14 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peternewman@google.com, maciej.wieczor-retman@intel.com, eranian@google.com,
 jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
 <0dc08082-0f3f-4acc-9285-b925a4ce3b02@intel.com>
 <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
 <c587f94a-7920-49cf-94b1-4c52140db914@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <c587f94a-7920-49cf-94b1-4c52140db914@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 0deead78-77ba-4ef0-554f-08dd0b4e7749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXhRTDhIRVFwNWNPbHp4aHo4M0JyUkpyQzFjWTA2azBEajV1cFpNZ3luNWls?=
 =?utf-8?B?T1FuYUpMbFdMZXpYU0NPaEZnS0FXVnY2RHFjcVJCSnNCaXlhV0Z3Uk9HeDVr?=
 =?utf-8?B?bGR6aGFqb0ZCOXNqSWUvUXFGVERqcTMrb1FGVFhoS0lGV0poTlJscU5ySjlh?=
 =?utf-8?B?R0RJU0JvUFF4bzk1bElBeTZyNkpYd1dxeTVWc1R1VFM5OGttWjhXanNDS0o2?=
 =?utf-8?B?OUVwUkVTL2h5MTJPQ2FmMXVpcHBwUncrbk1iN1FwaU41MlN1MENSNC9qNWNr?=
 =?utf-8?B?MndsQW9uRGJTZ2t2dElCdWp6ZVRrdXNZNEFxMFlEd3lYYURWWXg0eDlYTmJK?=
 =?utf-8?B?SXBtQTVzMzhFRW5waWFlREI1aUJaOWFnQmFncGtqcUMzR2lPb2ZuSkRUN2hJ?=
 =?utf-8?B?bHBjaFNHZk1Kd0dWMC9VbXJMZWdMQWVySjJMQUd5ZllSVFdiZmRNcmhVU2ti?=
 =?utf-8?B?UjUvZjdyU1BhT2VIV0JnQ3pmRjBFNjRCWmdJSlg2NkpQc0FZMXFHaHMwTU5j?=
 =?utf-8?B?MmtrN21Wb05kN1FwYTcxWlduNnhqWmd6NHFCR1d3NjlLZUVhRTNQWVgxcWZU?=
 =?utf-8?B?NndEWXltdjdNWmxVWm9zalUrZTZMMmpNV0Z1Tk8rQ0VHNzlUT0pCZVlTT2Nw?=
 =?utf-8?B?WUZUY3lYd09lTmduZGRvbHRQZldLY1ppNU9EVi83TDllZWFoRHIzNUMyVGdz?=
 =?utf-8?B?S2UvbWVoejA5Z2owRkUzSkwyWVlZbk5oUHhUTUhEOUlEUWxIeUl0ekl2bG5F?=
 =?utf-8?B?aWl1S1FOa00wYzVrSVZ6MFVWLzBpTG15aUV4MVlneVl0VDZ4V3pnN3dtaUhl?=
 =?utf-8?B?RlhtTFBCNGFCMlFkQ3lxbCtDQmpqVTl6REphaWhJTHAzeFZJMFZsb1FiMmlr?=
 =?utf-8?B?MWJIRU5uODNUVnlTZXRlaDJCTk9PZm1lM1cyWGJHT1dGQzNkbTlKd2ZjSUxM?=
 =?utf-8?B?RUlscG1vL3l1NGRtenZsWFY5dEhycFVsbHplSjlTN3V1c1ZYdG9yQmthL3ZD?=
 =?utf-8?B?ZE00WVBwaWFnNURvNUxnY084RU5seHFVTUl3K090S3NCYWY3SlVFL3pObSts?=
 =?utf-8?B?R2VOZmY3NTY2dXlvWXJIaHhiOURUeDMrdTRTTFRhbHA1d0x6clQrU1YzVDJP?=
 =?utf-8?B?U2J6Q0MvcUVZR2RzRG4rOXdiZlBmZXhkcHVmL3lISXdhZnVra2lVN0w4SGZl?=
 =?utf-8?B?Qm9MY29ySytGd2p5QVI5cCt3SXUxOXg4MzlYUm5acFpJWUlqaFJNSUVqemFx?=
 =?utf-8?B?bGY5ZFNqbGRTRmFzZTlSNEtQb2RzRmN4MFBQN2pDeFhnWUU4Q09Bb0M2NWEy?=
 =?utf-8?B?WXlMTDljekpJdDF5UmNkY0hPOXF3dmQzUVhvbVQ4bS9MdXZEUnZkQm8ydmpW?=
 =?utf-8?B?VVYxL0ppaXU3SEFjQ3cxVmVhaWN5bitvUkRYZzJ0MXp1ZHZiRVpEVmVuaWJO?=
 =?utf-8?B?M2RoUG9PcTFvWVUzYm1HSWVYYXZzaDJ5TGZFNkJNMkdxellRc1l3WFhqTENi?=
 =?utf-8?B?TzVValN1RElqQjhXSWthUEZ1YWVwcDlHZzg2QjFrck4xUGJMaXBLVTNLSFha?=
 =?utf-8?B?YTJPSUZoNVpSb0hoTnF4NzB6QXY3TXpxNm81VUFVVm1kWmdnMURNcXdZR0RQ?=
 =?utf-8?B?SW5ydVFHYzhjaU5hS3dOWThSY0xnYUpnYkRad01jdHJ6UXcxNm9DT2RDbkxJ?=
 =?utf-8?B?eERlTDlncUJBOUpKUk5IbVVmR2RPTjNwUG8zOWpqc0FncmtDTXc2ZkFocVJ4?=
 =?utf-8?Q?x5CHk5a9jLGTvyj/q8XdGNJCAFBZDS6zdI877v+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlBhNGVjV3d4eE4xczZSbTdhWmdySzFPTHBNL2hNQ0RlekhUSzVBQWExRVJC?=
 =?utf-8?B?dERTTGUxeWd4UnBmaHh2ek1jZHYwaUxSc041QW1hY1dHTk1EemdObmxrWDc3?=
 =?utf-8?B?Skl2cWJwY3UwRTVmR3llMXFJa0hEL1RzY0JnbWdvb0szWHVzaWFPU050TU1O?=
 =?utf-8?B?VnJZYS81Z2tTcGJ5ZzZqSEpBdjZHM3lHRGh5aEsyT0tLQXhOeWxvTksxSXow?=
 =?utf-8?B?dnhSeXNqalFFMGlwQXp6L2g1ZG1IQUpZOXU1UDlZay9GL1djVnVkMkxBcS9W?=
 =?utf-8?B?aWhOOVVyeGs4SkdJZlJJZW1SaDF6MlpWTEE2YlRRT3B2dG9xOWxQS05BVFlm?=
 =?utf-8?B?ZnBsU3hnMTBGei80djZaM0dXdGFSbDJmdUFLbWxneDFYQWJkNVp5dVBDUkdQ?=
 =?utf-8?B?YXZmSDM1L0JtVWZNNWU1cVBhNmdGL0RHUEpXVk1rWmVqaXZubnpYSXZ6RWR5?=
 =?utf-8?B?cnBTclhLWHlpSy9yY2g2b2RucFAvaGNzRmNUZG16UlNHNTcvd0M4OU4xRFFE?=
 =?utf-8?B?bDJNbzFIZitSWlFYMm1jUmpnZG92ZlUzVk9aTUlHTkJ6aXNIamxPektuWkN4?=
 =?utf-8?B?N0NDSGJOTERteTBRYW00Qm1wYmZZc1dBMkZwQ1dLczFhRzBaNkVaQWNibWR2?=
 =?utf-8?B?M2RoalovMjFYZjI0dDM4KzdralNJMGhwRXZIaHI5NUNTZ29qSFAxcldmR3VU?=
 =?utf-8?B?K0YyN2xJdGFYZVZ6Y2x5Q0doUUZaT05vem5reVZIWTB6bCtNalFBVUVaa0FO?=
 =?utf-8?B?QUtlVTRNNG9KN1h5TkhJWk9mY0p2WHNyTzVmcWJNOFNkaGlVbkdHWm5ocmhH?=
 =?utf-8?B?UVREM3B4azVhTEhlZi9pdmZ2SFpCOEZaMFBqLzV1TVVmUlQyWUlTOUUyb2c2?=
 =?utf-8?B?MHo0ZWhvTkQwNEsvYXFUa3pHM0VyOGZHeitjeXYzTDdlM05uRTlRYmJqVCtt?=
 =?utf-8?B?TjIrY05idE9kVG03dkcyRUMzNmxwK2FOSGFwY0c2MkxxTlF5ZWlQWjNKVkRJ?=
 =?utf-8?B?eFJrSDFBcUZYaUhKRUV1aUVrMzVCQ2RvR0NrVlY2eHBBOE5XMzZyZ2JybVo3?=
 =?utf-8?B?dHRZMW5GeWlwMHNPaFZRSVJzM0JUM1ErTDZ2dDdIa2FoQlRESFF3VHFreHJT?=
 =?utf-8?B?UU5vVEVkY2Z5UkpnYlEzeFhVRGxTWUJtK2I3ZTJma3hTTisrSmpqTlpHanRM?=
 =?utf-8?B?WmJmaCtuT3QxNGtSQ1pubDMrM2ozMzVBZG9QYTQwT2VWZnppcDNxdURLRXZD?=
 =?utf-8?B?N2YrZThXR1hSU1ErcFVBaFRYY3JiMW5jajltaXdEdnJBN2NlNU9WRGxFN2ZV?=
 =?utf-8?B?bnVScDcyaUhBczVyK1B2OFRsNE03Vm1EMHBqL3RQT0kzdm9lRFNBRHp2N0xo?=
 =?utf-8?B?SHhJNDQwcnNVRTdYSnpIT21GT3RZWHlocmFxVFpqTFFPSmlBRkhlb0xtdVZu?=
 =?utf-8?B?RU9lUHRIRmJjTXFhZ3lXUUtMVVh4VUVTbXZWTXpnVGJzU0s4NzhoWU1mTnhD?=
 =?utf-8?B?dWN0b081OWQwdGFxMjJTWTFZL0xZbjdudDZkYXRaZXg4Y1B2QnZWK1ZhcFha?=
 =?utf-8?B?d0Z5cGY1UmRBK2ZzVTByRUVkZGNBdFRGR1ZJK1ZzOU8xeHllOGNMckFFN3R6?=
 =?utf-8?B?TlFCMDhJZFp3aVl6TkJTN0k0UTRlMld1dWpzcWpjSGVoMWhGelF6WHZjUitx?=
 =?utf-8?B?UTgzbEhUclpWZE5adllYS0J5cS9wZ2lZRXplSUMyUi8yMnAxYmNyTlJTSzVO?=
 =?utf-8?B?SUNxdzBIV3dUK0lOMW5aVWNkUlo0MWhCZThUcDhwOEljbmEwL0YwR0JSaHRR?=
 =?utf-8?B?YjVOUFY5dEpSbVY4NDhiZU5GWllIdzZvbXJDQlVKQnhPRjdvTW0rVFhncC9p?=
 =?utf-8?B?R2E2YWY4WFBTK2lmZUVlWkl0ZmR6UFZ4LzJVZkhQOUsvZnBtRXkxOGJJTUZP?=
 =?utf-8?B?aXdDWjQyOHJDR01ZWFo1WXlJUyswKzVmZUhqamYyQUgycTl6RTYyTVBuaDNF?=
 =?utf-8?B?VWljaDREeFlXenZFNkZJU3NQMlVoZHVrekhLZTBXQWd1ZGdlaE5zVjUrbTVh?=
 =?utf-8?B?THgxQ2NydHAxeTNnaHcvSjdmZEU2eGh2RkMyQzZoTnJqVUFJekFvTnZ1UEs1?=
 =?utf-8?Q?ZRdo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0deead78-77ba-4ef0-554f-08dd0b4e7749
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 23:36:19.5129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tP6ru0mkQvYBcPVEhhxm0lBch+7LiAZUio+ISOhvmYBUWDJzwSNOHnt5KXhmLgwX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830

Hi Reinette,

On 11/21/2024 3:12 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 11/19/24 11:20 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 11/15/24 18:31, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>> Provide the interface to display the number of free monitoring counters
>>>> available for assignment in each doamin when mbm_cntr_assign is supported.
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>> v9: New patch.
>>>> ---
>>>>   Documentation/arch/x86/resctrl.rst     |  4 ++++
>>>>   arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>>>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 ++++++++++++++++++++++++++
>>>>   3 files changed, 38 insertions(+)
>>>>
>>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>>> index 2f3a86278e84..2bc58d974934 100644
>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>> @@ -302,6 +302,10 @@ with the following files:
>>>>   	memory bandwidth tracking to a single memory bandwidth event per
>>>>   	monitoring group.
>>>>   
>>>> +"available_mbm_cntrs":
>>>> +	The number of free monitoring counters available assignment in each domain
>>>
>>> "The number of free monitoring counters available assignment" -> "The number of monitoring
>>> counters available for assignment"?
>>>
>>> (not taking into account how text may change after addressing Peter's feedback)
>>
>> How about this?
>>
>> "The number of monitoring counters available for assignment in each domain
>> when the architecture supports mbm_cntr_assign mode. There are a total of
>> "num_mbm_cntrs" counters are available for assignment. Counters can be
>> assigned or unassigned individually in each domain. A counter is available
>> for new assignment if it is unassigned in all domains."
> 
> Please consider the context of this paragraph. It follows right after the description
> of "num_mbm_cntrs" that states "Up to two counters can be assigned per monitoring group".
> I think it is confusing to follow that with a paragraph that states "Counters can be
> assigned or unassigned individually in each domain." I wonder if it may be helpful to
> use a different term ... for example a counter is *assigned* to an event of a monitoring
> group but this assignment may be to specified (not yet supported) or all (this work) domains while
> it is only *programmed*/*activated* to specified domains. Of course, all of this documentation
> needs to remain coherent if future work decides to indeed support per-domain assignment.
> 

Little bit lost here. Please help me.

"available_mbm_cntrs":
"The number of monitoring counters available for assignment in each 
domain when the architecture supports "mbm_cntr_assign" mode. There are 
a total of "num_mbm_cntrs" counters are available for assignment.
A counter is assigned to an event within a monitoring group and is 
available for activation across all domains. Users have the flexibility 
to activate it selectively within specific domains."

Thanks
- Babu Moger


