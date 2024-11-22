Return-Path: <linux-kernel+bounces-417612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 316429D56AC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A71283063
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5854A08;
	Fri, 22 Nov 2024 00:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iP6tsbxc"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953FF15A8;
	Fri, 22 Nov 2024 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732234936; cv=fail; b=euK7rJyUOL2Y+JAlmpw+1S6NeFtaw5oP/s0kCc0b22EapbXsdtYOF1xd9yESJCSbC4PHu9tGkBTe5Taf06nT+f8gTt/TaYhrZ7NQGM9B7zIYM8kMeiqR/86fSR5cxC8YbJHp3XNtf6xNfYy9vvdzqSxuWDH5XBz4a406MoRv1oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732234936; c=relaxed/simple;
	bh=z2hhN12ptoylKM7qJ1UuXNrba04mTvgIOWU1EXJYbdI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M5fS2MJjOvTqXCew0XRaON0QV4pbRBwIO9M6meBgWPKHT8inboQt0vNqnRvythpB8pHwRwZ7QRrB09VU9f7RURvp0864wEIeFMvv4uvq+3ZhN1zKQlOyUZXuM4V6okYTzr6/jtX7rtrstjyMHDW3o3w27jY+ET1JWLQEvKF6Bxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iP6tsbxc; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slyfOjsZWM1RSS8JeHsm+LphYjbPvtS5mw0MOeFI75G0LKrUqahLeltJeIyPfphJWWdOa5bcaBxbvpduPR64l+k7eVAT4NG8AYrM6FMJ4aFY3eF1djB8GylKvF5vv1b9auXZbHD17N80KC5wjR9Ew6wIPzmN05kNJNEbYzyebqSt316IFFnF5uSmNqcuYOcs0h5Zp6503vBXNiegJBRDDTfu7dJeqJK0DFjo4EgXY+8NbFQmKpj2AU5dm/dQY/3P5ss10qFE3ZL8waEr+xo9SzEQ1PxeU+5I9K9GbHLzbh87gQpjpSIkGtj+FaFsyIADxIVtaPk4IXSkMC9XaScRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7UoldWigm+aak1cpo2iugo7g8NRd4OjqFiLeTT9rjU=;
 b=O+Gsz9/47DnLjfWLf2aV3BcdJJb8MmizfAfY3Kh3e25m3K9d3VfJeouc/7MviFAKC070L0q+OnjZ69uQA0HzJUY7PznJDnMe6Jwvo6n8R8DiX8eTFr4NzS+yj6ox+Uik8r5oSlZL7BUxbT+pHbYUNTpJHnCHc0OJgphTzjSGjNhsTq2V8c+RjRNMTFCkUYsagnAiRTexjwFkGfu+wJ0AKPs17Hd1ICL4sDqdgHRd8/QOErK9gsCzxT4mnH5H/gD1/KGQb1nghBHu+BgNbWFO5jx/kivCRkMTbI4tlYMObeokTzJay6tmbqoCyMS4jx/CXzaanTcvWnIpX1O+9UqSsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7UoldWigm+aak1cpo2iugo7g8NRd4OjqFiLeTT9rjU=;
 b=iP6tsbxcLuL7Yt58MPEVIxMOjVQ75DunO7R2YkuzcFuy2bDabT9GFZSejyi0fJo+CSQ9tioGRmg4tYW48ovm4Yznr0v1HgLpCFq/Wxi476iJJbnx4aiH/9YkRRht/1VZfAXQXILpO9reTDMZzu8nW+J4frrpDjgNkSSTSFKAVzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 22 Nov
 2024 00:22:09 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.024; Fri, 22 Nov 2024
 00:22:08 +0000
Message-ID: <3d32c528-24fb-e701-a70b-331d1a04493a@amd.com>
Date: Thu, 21 Nov 2024 18:22:03 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 20/26] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
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
 <4ec00fe60cd42c1f22c98c9f5c2f5d3ceb9f8d58.1730244116.git.babu.moger@amd.com>
 <79b8049a-b213-4d86-a021-cfd9f7389f5b@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <79b8049a-b213-4d86-a021-cfd9f7389f5b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:806:6f::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: f275bcce-230f-4bfc-30d0-08dd0a8bb397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmVIU3NvdktwK0hvVDVUS0JtcHU3NEM4dmN1U3lQRXNrMm9VbUw1endwVmNw?=
 =?utf-8?B?b0NxWjVhb3BLMGhTWUdtUUd3cWE3M3JUQ0QxTm84MGtNdjM5YnozWHl6K2lh?=
 =?utf-8?B?N2NiWFVuOHUxa2lmNE5kdjZHSVVzMGV2c2w3MGZyaWNIZU13M0dSak5zeTVP?=
 =?utf-8?B?TXllR0t0d0wvZElOV1hSRzJDYUJZalNwNkdjV3BWbmNhcGNCd2Y0SW9QcllG?=
 =?utf-8?B?eWtOZFd4OVNNQVJoTVhlN00rSyt5bTFzOXg2K0p6ZDc1MnduNldYYmczWWJC?=
 =?utf-8?B?OHJ5a0xtVnFYcnU1U290Y202RnV6MzAvaDVWaW9maE5XSXhwNyt5d1gxYWhW?=
 =?utf-8?B?emhPS0d6anZHb2VhWlJYRU1uUFI3ekt5TWJYaHozZExacUhTcXJtdEk4Um9N?=
 =?utf-8?B?bzJGeHc5cUYzdlpSQ1dwbVVzdWp2TXRGN3ZxbTFENHlQZmI1RDZoeHBUZHRl?=
 =?utf-8?B?TEFIY0R5SnJDTEhUMG5SWE8yV2Q3K2tRc25KMUgwa2YrdzhmK3Y2dVBHRE1U?=
 =?utf-8?B?Y1ZrdXVvVE54azcwSEZZN2pETzA3blRUcXZ1NmxjQWFrUnJCY0NWWGxPdjFh?=
 =?utf-8?B?VDk1WVlZdFRaQis4NTRtbFBJUzVIRGZBS203N0diWWdRRWFaZFN2Rmo2Zk5v?=
 =?utf-8?B?SU9kTUZBVGFta3YxUWtyOHRVT3dJazBFcFY2bDdRUG1Qb1hGK0tjVzhtZ2VU?=
 =?utf-8?B?Yk5iVjErcjczTzVNRVl4VWRTUnh2WUNpdXdnZjdDalQrZ2MrTlVtY2gvOEY1?=
 =?utf-8?B?RzROeHp5SXg5ZzM0NXlOQlc0ZjVrYW1QaW5wRVFGUndvMmh1Vk1JSnE4c25Y?=
 =?utf-8?B?RlZyUURLYWJVZlgyM284SzFPcW83V1hRQnFoUDVwZERTMFc3dXZEL2lxVDNB?=
 =?utf-8?B?N1BEUXpxMW4ySW9ReXJzUWNTVHNFTUY0NVVFTUQyNG94YjIzNHU2YUFnakp2?=
 =?utf-8?B?Uy9wcVNNVE5BRTlkWkhUWUpVZ3JzUWFjL0dZcys1L0xuVnFDUVBDemJqUzZ5?=
 =?utf-8?B?K3RnamhXeHFrRFFQRDYybTBrSWdMOGJwSXZtdzJFMHdsMmMrUmtEQjZJSFJ0?=
 =?utf-8?B?WGtTTkF5R1ZZZnZEK0QvajVtQjhxYVJuenBSTzQwNWpBcTJxQm1kZk5RTWZ4?=
 =?utf-8?B?b2I4SEEzMGZlMDJGRzJKbzQ4VjNhYUNvQjczVlZDaWxIQkF0SWJUUGJDUmNM?=
 =?utf-8?B?bjFJNkxyTnlwRXJzOG5LcmtzMVVwaHMxZVJmMnpQK0Y1Wmkvc21EclVPZEtq?=
 =?utf-8?B?b2VheFlBY1B1VHFwVzFSUm43U0RnV2hhVi9mdG1xejhrU3lsZnNGak1WcGp5?=
 =?utf-8?B?aWVrL2ZoRndua3N2RnpNNExHUXFaZWIzR0ZjQklLNDU1TXdrWDE3N2JlQ080?=
 =?utf-8?B?TVh1T0UzajNkcjFVWE5yR0VxZEdicHY4TjZTYkpZRG9YYTNGS3Q5ditOVWpC?=
 =?utf-8?B?ZVo5Ujl4MHc5cDdKVW5pT1RNSlV5SXNBZktleFlDNVB3Mmt3eUF1dUVrUUky?=
 =?utf-8?B?YzlPR2lDMlYvaXZtWGZIcTFJRXBsa1QzM29wT1EzZ3lORFNZclhCd1NTN2d3?=
 =?utf-8?B?NU9xeHR0VllPblJGRXh3UzhrRitSMHhmN3ZnMlRxeFRzWWt6cGdTZWxIcER4?=
 =?utf-8?B?QWlVb1lLd2JZREdUZ3Q2RUFlckdEYlN6MytaSjJDL3Bnbk12bEkzbm1hVHBS?=
 =?utf-8?B?TllWMFZaZGNQVjJDVHRPUGxFVi9HdEZYZ1A0aThqTzNETStUZXVwZnZ6UW8y?=
 =?utf-8?Q?xlywqBLfhelDTCCmtqZGQ7u8T8vQvu3Hz/qWMgJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDJCZ2k2M0FHR3RuczdjbnZiYXBibkRwVkdEekdyaUh5RnBxTWI1TVc2R0N6?=
 =?utf-8?B?Rnd6d3hIOG15c2owNmV4U3ljRHZGUWE4YjNZcWVaZ3F6aEhvTHV0alhPT0pm?=
 =?utf-8?B?QTZGS0xHeENhLzk3SWJ5Qk0zL1pqeXZnWHhhZlNVb1hlWElkR2lQTDR0RkdY?=
 =?utf-8?B?UjFua2NUUzQrNENEcjBJK2JBVnRVa2RUazhTQ21UQXIxNURqQ3pTL0ZtUHVW?=
 =?utf-8?B?dFBROElBQTJpS2RKeTRGdHJzSCtFeTRoeFJmeVhGNWNvcVBHWUlkNDUzdVRl?=
 =?utf-8?B?Rnh2SG9kVWhPdGxMMjdXMkJyT1JIZHBBU2RLM2hPaUR1dGl4R1ZwUDY5c0k0?=
 =?utf-8?B?Y05JWThhcmhjZVdSZENRZGNyeVYvRFdXbFc5anR2WERZWTZlb29JdjNPTlVG?=
 =?utf-8?B?eHR0OTJ5MVdoT2RWK3FreVJ1dGt0K0I2VlBmSXM5cFJGc0dOZHRGbXliSW8v?=
 =?utf-8?B?VjhGT0UwRmlQMjRKV2ZYSCsvNTdKR1c4bStKbTg1cnB0cmF2UEZKM0RTWTcx?=
 =?utf-8?B?TFgrSlhaVkJ6SGkxQ1R5MjlHbm9yRHpYamtOdksxYm9VcTcvWTRNL1lOY0FE?=
 =?utf-8?B?TlZwR0FXTmJXOXp1Y01pZy9zZndadXR2UDRRZEdGd1JLSnYxUGQrSmgrU1VQ?=
 =?utf-8?B?Zy9GZnR2S0g4REVNaWhBelhDdURQS0cwQk1SeGo2aG93ZkNCSFJPY2llSklW?=
 =?utf-8?B?SG5jdzFKeUhjTDVQZ0o1Zys0dCtvdk1NNXBNZFp5YzVYbnJOUGtXMzMyKzND?=
 =?utf-8?B?djlaMmVrOWFiWElJV0UrVlJEU04raHFxcm5TcXEzRVI2LzFMK3JLaHNJL2Zm?=
 =?utf-8?B?U3M5d2REbGpLM3FMTzZ0d3IvVFNyNG1wbFcxcElaUHBHVlQ5VHB5Rkx6WjVX?=
 =?utf-8?B?S0hlclo0dllmOVBTRFVudXp1NEhRbFBmekxBMmxFMkdtMjBpa2ZOZERQTTc2?=
 =?utf-8?B?c0U3VUUyOGoyL21nWTRXOVo3L0twK0p5TnVHYldSMFhjeldQSWZTL0xTQUtE?=
 =?utf-8?B?UDFKc1pCWXg2dEtHcGV1SkFvMVQ3SnRhZExQSTRiWVlOZUFuVmZFOThGWVVi?=
 =?utf-8?B?T1NvaFFEZ0dsa0dxeEhmV25tTkpRdmR4U2s3cnd2OHVzVXUxNERhMDVvcVF1?=
 =?utf-8?B?WTNBWkYzVFVYQkNEM3N1WWJNejUzbmpDalJQcFFFUHRsQnRpNVdBa0R4bFoy?=
 =?utf-8?B?dE8zNjNJYmdTczRWV29tWEFwN3JuVnBrbW9MekFpZUVhV1RxaklmeEduUDRz?=
 =?utf-8?B?Vm5rY1Vtb2tHcUkyNTFnN0s2NXU2a0h6anV0VndhT2tLOURmeE5HNi9UN1FJ?=
 =?utf-8?B?L1Z2R2phQjgzc3YrSXFWVC82WDB5SldONWt1VWQyMzBIYU96V1E0Q1p1V0xl?=
 =?utf-8?B?RjRFeUlNQVlVWDQ0UjlZTWFvQ0hvU2FZNHJmc0JscWRKSE4yZ29xekRobGQ1?=
 =?utf-8?B?WkEvZHY4UC9NWjd2M2VQTXpucVZ1VTEyNXdqQUd6ZEpWVVRoQ3VEUllPNHF5?=
 =?utf-8?B?N2xvU3J3RlhTSVpHKzM1WlZGV09EMlJHajJ2TnZtWXp0OUpJbW94UDA1bFRF?=
 =?utf-8?B?UzMwWml1QTB1cnBRKy9QeUc5SXlrNkN2WGRTLzJKRDVTcWNhQ2MrS3VaR3ox?=
 =?utf-8?B?bWRIYVg1MGN5Misvc0NjVVJBeVI0UFF1eXVQZis0SGJTN0dGZXkrbVlueDVZ?=
 =?utf-8?B?eXZJcDhrQVZFRzBXT0RLTkljazZ1NnY4MWxCRjNySVpkeEhHM3JuYU9GZFZn?=
 =?utf-8?B?NjBzNlNibVBSYStrNWZZaVhQemhrcXBNbzhHNUViUjg5RGhsdkliVVFRcEd5?=
 =?utf-8?B?OGxnY1Bwc3ZuU295QUNOdGFHaTdrbjRvNUxDYVdNL0MwU1hERXQ5aWIxNzYw?=
 =?utf-8?B?WHNveThaaWhIb2tEYlpHTkc0NlQ5V2ZDaFNtMmdQb1NodHN4V0FZMVYvTUt3?=
 =?utf-8?B?RFNwVjdaNjVra2VneElQbWpiU2lzZVNNNUpVQjdzc2xJclNidWFKQ2FhSEdC?=
 =?utf-8?B?YXIrdEVZWTREcWhpVGI1dVVURkxqby9UZkJpakEyNEk5TVJpL241elVqNEg4?=
 =?utf-8?B?eFV2Tk0zaWxGWFZQUDFKWjQ0Y0szMG1oVTRXZVpQTzlLQ1JNeml5cEs4N0k4?=
 =?utf-8?Q?CwuE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f275bcce-230f-4bfc-30d0-08dd0a8bb397
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 00:22:08.8247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUuzVr5y85eDRCoFNmxNJPqgrv3qpv0q+kTh+dJNQPpQ78L1nejC+T7ZQGR0ZKfh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433

Hi Reinette,

On 11/18/2024 11:18 AM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/29/24 4:21 PM, Babu Moger wrote:
>> Assign/unassign counters on resctrl group creation/deletion. Two counters
>> are required per group, one for MBM total event and one for MBM local
>> event.
>>
>> There are a limited number of counters available for assignment. If these
>> counters are exhausted, the kernel will display the error message: "Out of
>> MBM assignable counters". However, it is not necessary to fail the
>> creation of a group due to assignment failures. Users have the flexibility
>> to modify the assignments at a later time.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v9: Changed rdtgroup_assign_cntrs() and rdtgroup_unassign_cntrs() to return void.
>>      Updated couple of rdtgroup_unassign_cntrs() calls properly.
>>      Updated function comments.
>>
>> v8: Renamed rdtgroup_assign_grp to rdtgroup_assign_cntrs.
>>      Renamed rdtgroup_unassign_grp to rdtgroup_unassign_cntrs.
>>      Fixed the problem with unassigning the child MON groups of CTRL_MON group.
>>
>> v7: Reworded the commit message.
>>      Removed the reference of ABMC with mbm_cntr_assign.
>>      Renamed the function rdtgroup_assign_cntrs to rdtgroup_assign_grp.
>>
>> v6: Removed the redundant comments on all the calls of
>>      rdtgroup_assign_cntrs. Updated the commit message.
>>      Dropped printing error message on every call of rdtgroup_assign_cntrs.
>>
>> v5: Removed the code to enable/disable ABMC during the mount.
>>      That will be another patch.
>>      Added arch callers to get the arch specific data.
>>      Renamed fuctions to match the other abmc function.
>>      Added code comments for assignment failures.
>>
>> v4: Few name changes based on the upstream discussion.
>>      Commit message update.
>>
>> v3: This is a new patch. Patch addresses the upstream comment to enable
>>      ABMC feature by default if the feature is available.
>> ---
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 +++++++++++++++++++++++++-
>>   1 file changed, 60 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index b0cce3dfd062..a8d21b0b2054 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2932,6 +2932,46 @@ static void schemata_list_destroy(void)
>>   	}
>>   }
>>   
>> +/*
>> + * Called when a new group is created. If "mbm_cntr_assign" mode is enabled,
>> + * counters are automatically assigned. Each group can accommodate two counters:
>> + * one for the total event and one for the local event. Assignments may fail
>> + * due to the limited number of counters. However, it is not necessary to fail
>> + * the group creation and thus no failure is returned. Users have the option
>> + * to modify the counter assignments after the group has been created.
>> + */
>> +static void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
>> +{
>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +
>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>> +		return;
>> +
>> +	if (is_mbm_total_enabled())
>> +		rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +
>> +	if (is_mbm_local_enabled())
>> +		rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
>> +}
>> +
>> +/*
>> + * Called when a group is deleted. Counters are unassigned if it was in
>> + * assigned state.
>> + */
>> +static void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
>> +{
>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +
>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>> +		return;
>> +
>> +	if (is_mbm_total_enabled())
>> +		rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +
>> +	if (is_mbm_local_enabled())
>> +		rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
>> +}
>> +
>>   static int rdt_get_tree(struct fs_context *fc)
>>   {
>>   	struct rdt_fs_context *ctx = rdt_fc2context(fc);
>> @@ -2991,6 +3031,8 @@ static int rdt_get_tree(struct fs_context *fc)
>>   		if (ret < 0)
>>   			goto out_mongrp;
>>   		rdtgroup_default.mon.mon_data_kn = kn_mondata;
>> +
>> +		rdtgroup_assign_cntrs(&rdtgroup_default);
> 
> I think counters should be assigned *before* the files exposing them
> are added to resctrl.

Sure.

> 
>>   	}
>>   
>>   	ret = rdt_pseudo_lock_init();
>> @@ -3021,8 +3063,10 @@ static int rdt_get_tree(struct fs_context *fc)
>>   out_psl:
>>   	rdt_pseudo_lock_release();
>>   out_mondata:
>> -	if (resctrl_arch_mon_capable())
>> +	if (resctrl_arch_mon_capable()) {
>> +		rdtgroup_unassign_cntrs(&rdtgroup_default);
>>   		kernfs_remove(kn_mondata);
> 
> ... and here remove the files before taking away the data exposed by them.

Sure.

> 
>> +	}
>>   out_mongrp:
>>   	if (resctrl_arch_mon_capable())
>>   		kernfs_remove(kn_mongrp);
>> @@ -3201,6 +3245,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
>>   
>>   	head = &rdtgrp->mon.crdtgrp_list;
>>   	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
>> +		rdtgroup_unassign_cntrs(sentry);
>>   		free_rmid(sentry->closid, sentry->mon.rmid);
>>   		list_del(&sentry->mon.crdtgrp_list);
>>   
>> @@ -3241,6 +3286,8 @@ static void rmdir_all_sub(void)
>>   		cpumask_or(&rdtgroup_default.cpu_mask,
>>   			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
>>   
>> +		rdtgroup_unassign_cntrs(rdtgrp);
>> +
>>   		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>   
>>   		kernfs_remove(rdtgrp->kn);
>> @@ -3272,6 +3319,7 @@ static void rdt_kill_sb(struct super_block *sb)
>>   	for_each_alloc_capable_rdt_resource(r)
>>   		reset_all_ctrls(r);
>>   	rmdir_all_sub();
>> +	rdtgroup_unassign_cntrs(&rdtgroup_default);
>>   	rdt_pseudo_lock_release();
>>   	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
>>   	schemata_list_destroy();
>> @@ -3280,6 +3328,7 @@ static void rdt_kill_sb(struct super_block *sb)
>>   		resctrl_arch_disable_alloc();
>>   	if (resctrl_arch_mon_capable())
>>   		resctrl_arch_disable_mon();
>> +
>>   	resctrl_mounted = false;
>>   	kernfs_kill_sb(sb);
>>   	mutex_unlock(&rdtgroup_mutex);
> 
> Unnecessary hunk.

ok

> 
>> @@ -3871,6 +3920,8 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
>>   		goto out_unlock;
>>   	}
>>   
>> +	rdtgroup_assign_cntrs(rdtgrp);
>> +
>>   	kernfs_activate(rdtgrp->kn);
>>   
>>   	/*
>> @@ -3915,6 +3966,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>>   	if (ret)
>>   		goto out_closid_free;
>>   
>> +	rdtgroup_assign_cntrs(rdtgrp);
>> +
>>   	kernfs_activate(rdtgrp->kn);
>>   
>>   	ret = rdtgroup_init_alloc(rdtgrp);
> 
> Please compare the above two hunks with earlier "x86/resctrl: Introduce cntr_id in mongroup for assignments".
> Earlier patch initializes the counters within mkdir_rdt_prepare_rmid_alloc() while the above
> hunk assigns the counters after mkdir_rdt_prepare_rmid_alloc() is called. Could this fragmentation be avoided
> with init done once within mkdir_rdt_prepare_rmid_alloc()?

It seems more appropriate to call rdtgroup_cntr_id_init() inside 
mkdir_rdt_prepare(). This will initialize the cntr_id to MON_CNTR_UNSET.

And then call rdtgroup_assign_cntrs() inside mkdir_rdt_prepare_rmid_alloc().

what do you think?


> 
>> @@ -3940,6 +3993,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>>   out_del_list:
>>   	list_del(&rdtgrp->rdtgroup_list);
>>   out_rmid_free:
>> +	rdtgroup_unassign_cntrs(rdtgrp);
>>   	mkdir_rdt_prepare_rmid_free(rdtgrp);
>>   out_closid_free:
>>   	closid_free(closid);
>> @@ -4010,6 +4064,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>>   	update_closid_rmid(tmpmask, NULL);
>>   
>>   	rdtgrp->flags = RDT_DELETED;
>> +
>> +	rdtgroup_unassign_cntrs(rdtgrp);
>> +
>>   	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>   
>>   	/*
>> @@ -4056,6 +4113,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>>   	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>>   	update_closid_rmid(tmpmask, NULL);
>>   
>> +	rdtgroup_unassign_cntrs(rdtgrp);
>> +
>>   	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>   	closid_free(rdtgrp->closid);
>>   
> 
> There is a potential problem here. rdtgroup_unassign_cntrs() attempts to remove counter from
> all domains associated with the resource group. This may fail in any of the domains that results
> in the counter not being marked as free in the global map and not reset the counter in the
> resource group ... but the resource group is removed right after calling rdtgroup_unassign_cntrs().
> In this scenario there is thus a counter that is considered to be in use but not assigned to any
> resource group.
> 
>>From what I can tell there is a difference here between default resource group and the others:
> on remount of resctrl the default resource group will maintain knowledge of the counter that could
> not be unassigned. This means that unmount/remount of resctrl does not provide a real "clean slate"
> when it comes to counter assignment. Is this intended?
> 

Yes. Agree. It is not intended.

How about adding bitmap_zero() inside rdt_get_tree() to address this 
problem? Also need to reset the cntr_id in rdt_kill_sb().

-- 
- Babu Moger

