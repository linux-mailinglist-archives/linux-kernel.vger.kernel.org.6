Return-Path: <linux-kernel+bounces-542646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A54DA4CBE6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D871723E3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406F422F16E;
	Mon,  3 Mar 2025 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3fQYBtVe"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE4A217F40;
	Mon,  3 Mar 2025 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029422; cv=fail; b=G1PzXhUL41zI3p1OjOe1XrCwSoqwSRCZgvf3otMwDJ33TPPZ/5jTH4ItBm6Dj5DpWPp/+/7XpgRlB7aBSJPmcjS8xWu8jJHwdyzTZU0VENCyAi4gIHFKBVJpuEUGAnUk2MtcBFpQqeT6TH9xWRqn687fbEk8Fh9UwKd6JZVIKlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029422; c=relaxed/simple;
	bh=MOvx4uJkIPaFbVcpsB3bkCDDZsEBERHQHKgF6EyWbGw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e+QGIXvjyrn0VXTmXw0dGRBDFJzWg2jaUka9LQ1PDYHlXpHw0i7MVg5AEbRxItrUxEemwgycOISLKGVHG/K/wA2dVGEnRX6fuf1IHWHv9rg1GlnVGy7++HRway348sdefjeHbDCFVvTqOp05HMLGbApjlaQ3+B8KbJVxF5rXNJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3fQYBtVe; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftrbMQKDdTB3EK6hhEE4ym4MLQNhpPGL32GoN7J0smi22s20VLC6QjLRqPXkl3R2T05cT/kq6de8GZlSkaMcAIePq04fr3995CRybIeVUBpI4ol00DkMBmIKcj11npfOmDnQUQNomGe1v/KI68AGjsLZVJjtBZoZ6KkRdpeMU2keKJXOCZN0WENv2TndpttTLbLUa4haS4OoCL4IWra9thJ98oc8Zp3JDsafEJI6DxaZ7iWKiU6dUaJUQst37MgUdqRkkPE76BOhJitDTYm1DYOZdl2baz+m//eCGReNrkor3w21s1OA2sp/v4J1NjQAoD/TMcvU4euHXmEE0Cecqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nps6kG2hVScImro4UmvGAwd4Ol+WOt0K4rCZ7rYBTMI=;
 b=LIKKuf2tQu8nT+TRNspDGa4219NucUiPr2pbj+PUls9iVMe/1Ogdp6v144AuWypJz/2i3AuPx+MZlFL9yU3bmf43t7QYnNnGZXE8p6i0U1p6fOpEulsKFb5k9Wu9JJaoAwcbHcrCRAO2K5k5vkRgAVP8l+4H9A9/mT+fPHWG+CwGRdC9afBBa1NNGaG7LI9gHLpplzByx0RB647PoWEZrrouyGMZamN6QM9U0pLL3WN5g8lSPJehd/8zfkucNAm+tCo40VEopFuCcoLknOQXXurdp1bGVxPbpOOzrOZ2NtiFREojtqWhKJINXpoV+AIta3K2yzey1Az1xLg0G5eH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nps6kG2hVScImro4UmvGAwd4Ol+WOt0K4rCZ7rYBTMI=;
 b=3fQYBtVe+Nw6UfD1PkCGjhpVUGGb2lJIJTFd6DXgfP0b+Rk47IXa5hFXGbDDqWUCfIgNOzpNG2tFsYY7JebrApGFU1U2QYFOaEa3CIZ6n8bSg6xM1vnH6x6/D9VqYASqMCAnjbCvU6dj9wa3aBvPQ+BwpaAHxXP7EtRuKDA9gLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 3 Mar
 2025 19:16:56 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%2]) with mapi id 15.20.8445.017; Mon, 3 Mar 2025
 19:16:56 +0000
Message-ID: <f1744c45-9edf-4012-89bc-47393b4c53fc@amd.com>
Date: Mon, 3 Mar 2025 13:16:54 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, "Moger, Babu"
 <bmoger@amd.com>, Dave Martin <Dave.Martin@arm.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, tony.luck@intel.com, x86@kernel.org,
 hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
 thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <ccd9c5d7-0266-4054-879e-e084b6972ad5@intel.com>
 <CALPaoCj1TH+GN6+dFnt5xuN406u=tB-8mj+UuMRSm5KWPJW2wg@mail.gmail.com>
 <2b5a11e3-ee19-47ba-b47e-b7de2818f237@intel.com>
 <CALPaoChXvLNMg240C7RyBvg0SxXfGf_ozKC6X7Qe4OxyEcL2tw@mail.gmail.com>
 <a3b46f6f-a844-4648-905e-53d662e5715f@intel.com>
 <CALPaoCi0mFZ9TycyNs+SCR+2tuRJovQ2809jYMun4HtC64hJmA@mail.gmail.com>
 <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <CALPaoCg97cLVVAcacnarp+880xjsedEWGJPXhYpy4P7=ky4MZw@mail.gmail.com>
 <a9078e7d-9ce6-4096-a2da-b2c6aae1e3ed@amd.com>
 <CALPaoCgN+oGgdp40TOJ9NgF9WYPdN0cG8A8BtOOMXOP6iMVfzw@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCgN+oGgdp40TOJ9NgF9WYPdN0cG8A8BtOOMXOP6iMVfzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0156.namprd04.prod.outlook.com
 (2603:10b6:806:125::11) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6d99d4-ee32-43a2-9dc2-08dd5a87f68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1hid2dyeDF2Njc4TXFUK0JRM1NhNC9qRWFVZjVWOFdFSGpBd3FBVGdaN1Y0?=
 =?utf-8?B?MnFVVzM3YXcxSkE2dFpXeTFydHhHNGtzVGRrMUF4YldjTTQzL2hjY0paYTls?=
 =?utf-8?B?RC9MSTJEenpOMGdZNHdXZHFQaWRRWEJqd3h3cjlha2lLZ21qVFJqTzNCSU5v?=
 =?utf-8?B?RXQ1anNKSklZV3p1MkhyRk5Ndnk2U2FDRm9KY2RwajBvL1RJUmhhb3BQU1B3?=
 =?utf-8?B?eVlHMkpnZkc1bHozME1YMHZHK2JSazZLekZNTzM0UU1jREwzcEg3dlFwaTkx?=
 =?utf-8?B?bW42SEd6ekJoSDN2WW9rOWZUbFNyMytjdU9TcDBiKzJqUnBueWFWcHc1OTNz?=
 =?utf-8?B?ZEFVQWFGVlVVUUp2UloxMjZmRlBkajNybUg3SG0xNGlUS3Y1VmVFMmN3SjNF?=
 =?utf-8?B?RDJJR1IxaUZpenNNdG12TE9wdmlWdHlOSGd3T0krSFdVWjFJdm5USnFYZDFG?=
 =?utf-8?B?cFp1VjhweGIxVmQxVmpuTTRxakE5aktFWDAzOEZuMStvaWROSzRUZ1U0Qm9U?=
 =?utf-8?B?S0lrVTRBRnR1R08zcEdTTFhyUlRDeWVGTEFWMGlDZE9JUWgzWi9EeHdCd0FZ?=
 =?utf-8?B?dUJtaUhkSkRIM0Irdk1xSGpRV2tRSXhOUmFDUC9YSzVMNTdEWEQzRXJ0aGMv?=
 =?utf-8?B?UFJsck9seEdNbkZyQzlSaGhEOHhrb3EwYnNFQUhYc21UQW1RaW9DeGlmTEFM?=
 =?utf-8?B?clNSWlFXaTJVL2hQaWhuMjB3Vm9kQXRGQ0VsLzdzZ2lSbFlBNGRzemJxczMz?=
 =?utf-8?B?UTRzdkRhSU1WZ1hVQ1hPZkprL0t0aDRjaGhkYkhIUEFOUUJNTzBBa2kyOHMr?=
 =?utf-8?B?ZVJwOGgxUVZPc0xKQ08zblNwUzdHd1RzejVnSGFjSmJUajhJMUNYYjBudjF1?=
 =?utf-8?B?RTFyaDhwdWNuWGNxZkt3STdySTFtaW53WVZ2V052S0pkRzU3dHNvcE53MmRL?=
 =?utf-8?B?UjVuSmxwLzF2YXIyZ3liTlZFM2ZEN2w0RkFDa2Q5T3hhOXJiRVVONkY2eUUr?=
 =?utf-8?B?djdiT2pxTkdzMFN4V0lwOXRua2JqRUJYYllSMlVYSXA2OU04RjgwcDM3TWZH?=
 =?utf-8?B?Tm04bmtuMkNUM2EyVkZBTU1CN3JHS1RPY205NXRRZmROOHMyR1VxRGFCeWZI?=
 =?utf-8?B?Z2Y2ODlZaW5ndjZVNW54QzdJeUkwaVB1MlNHbnZqUjUvQi9wMDRKSGtBVUtn?=
 =?utf-8?B?QWwrcVRvT3RSMnpIMlJla0hGYjIrVVplZGZYQUxlNS9NTU1WeHZQQ1Z6Zm1U?=
 =?utf-8?B?K01maTh2OTByT216Z1Y4UzAxSW9acXFrVWx4UXR0akZibHMyYnNkeDlobEVB?=
 =?utf-8?B?Q0thelVvV2tEKzhnN3c5L1I2cWdSNCtrZDdjbDlpZ1hPZGs5d0YyN2hqcGQw?=
 =?utf-8?B?dlZBc0JOLzA4TnpjbG1Cbmo3V0hLU1orUnk2a01hVDY2SGhIajIxSEloVjB2?=
 =?utf-8?B?R0NGbElnYTBDMXpkWDFDL2RtcmhLU29za2pLRExPc0cvazRFVDFVNHhNcmlm?=
 =?utf-8?B?eXI2Tm8zRXBncWhPZTVidUExQW1rdW55K0ltZExTL3RJNHdqZmpyQnFObUww?=
 =?utf-8?B?L1NZSFRJYzV3ZUJGWVMxWVRrYWh2NWZlUHhPU01LWUJYRnNlRWR2TThTQXk4?=
 =?utf-8?B?RXlBRk1DNmh2Z3RGRmdMQ0twbzVGN2dRSVNuTVVhVG8reERLRHdvelc1MGF6?=
 =?utf-8?B?WTdEem5pdEV6UkFTb2tGS1RlOCtFOWJHL0ptNjNtN0tvWTFtM0pVTTVEV3Fq?=
 =?utf-8?B?QUlES2JxaE1PRitJaHZvcmk1QStYRVRoNkhYLzFwUjI4RXh6ZXVuSjI5dnpq?=
 =?utf-8?B?eWdnbyt4c0plaGxidE15ZXBKbnV4ZFdkYVNjQVNYMVVFYnAxUzZqTDFpYWJL?=
 =?utf-8?Q?9Ec1e5OME+LFH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzNKRlNZbjk4dG9SS2E1SGdPQ0tRV1VLLzhWWWtVdytDSWRWWWwwK3E0U0Ir?=
 =?utf-8?B?SE5hQyt4NXQxbmRxNHVwQmNxcmM1aUpwbWJUcFE1SmVDdUkrQm5OVlB0RTFt?=
 =?utf-8?B?YkFHeTcwTUpSSEQxd2JabCsvc05pZmQzK3ExQmlMWVFTZkpwZW1xeTNLdGdO?=
 =?utf-8?B?RWF3bFdGbDZKQlhFYkFHUUFyekpVVGRQT3pJbWFtK25rSGNFdEQ3dUwzMGVW?=
 =?utf-8?B?RUllQXJMWnBkeTkyNXhwUm9oMmlOL0ZyeG56SUI5MTk3OExnY0JsUmVQYTF4?=
 =?utf-8?B?Nzcxc3V2UjF5V2FCRWtXbzlhdWZYSHZleXdkaHl5WHE5Q1E0RTN1L0YxMkFI?=
 =?utf-8?B?UVBtQ3h6emhUL2g4SXFZMVR6MjVDRTJxL0pnYmVSNUJzOGNrd1N4a0hNYm5S?=
 =?utf-8?B?bThIVkQzTTQ4Y3pNMFJBQmY4T3o4b005Si8rYUd3Qk15dzlhZ0ZkT2d5MUdS?=
 =?utf-8?B?NFQxQ1ZCS1lrQ1BqVmprTDFydm9OVHR1SnY1MTQrNkxHRkxBUmFWRUhwNndM?=
 =?utf-8?B?TVNWQk4ycXlZUm5TUVI1eHovVGhWcUtYWXQwRDczWEU1UDY1Mmt2MVVJQlZG?=
 =?utf-8?B?OXMxdmRMb3NGMmFRT21ITnU0UWZXaXlzU1NYQlhjQjR5c29YdHdHcCtYUnZK?=
 =?utf-8?B?Rzk0NTVoYUVnU2dxVUU5bGVWVVY5d0pFVkZ4cGJaalQ1OGMrYy8rdTh5eHVp?=
 =?utf-8?B?L3dCUUtWdEF4TExwYTBvSVhRQVZRdVZKeXJGZkQyWDAyMkQ3a2RzVDlzV0g2?=
 =?utf-8?B?WjlORkJCR0ZKamZmMzUwMHNuTG93SEJFTXZKNy9sVXo0ZVQ3ejZkVHlBWFVT?=
 =?utf-8?B?Q0VzWHcyOXNTZ0p5STR4VDIyZlZ0TFEydTEzQkZacWg3a3JEanV6V1VLWFUy?=
 =?utf-8?B?ZmRhdzZ3MEkxMEMxYkhQUzFEZVhtNFRYTTJ2VytHZnpsN3pBT2UwV3Z4clBQ?=
 =?utf-8?B?cUdBYm1JTk9ENTFyNnFScGJMM1pTL2xMcXkxRUpnWE5WbDVablRlbTFPZjZz?=
 =?utf-8?B?ZmtOd2JwcjZKMlVNVC9nVEpMSUdQVVNzK01ROTkweEV0SWZaUFdLREc5ZVJH?=
 =?utf-8?B?SklJU0NwbUYyMkxYeDcrSjFTK1U5OWFqLy8rWTZDUG5QN3RUNFVRbUtrYTF6?=
 =?utf-8?B?Qk1UbHUyeWIvUXl3N3UxNGpGNUU2eEJ2bkpORkhtZnVGSUN4cUt5b2FzT3Ri?=
 =?utf-8?B?c0Y1R3liQ1RQZjhZQU54UlA0VmhHTlhYOElnZit0cm54MWN4TmZrYTVGeXRo?=
 =?utf-8?B?Q0JvcFNMQ1ErZWlSQXo0ZkdLQnpIMTU5MitCS3ppQW8rZXdJS0tBMUlpSHlS?=
 =?utf-8?B?M3Q1Q3BEUjhWQmlkUDlpbjdQekV2MGdJajBKVkJmSmlTRENidWloRW9IeVFN?=
 =?utf-8?B?NHQ2UHo5dU1LK0RrbjVIc1JGeDA0V1AvVnY2OU5UWWl1Y2dCLzJSdDVVNzlE?=
 =?utf-8?B?V2JQekpTQnhvN3NTNG1UQXN0ejlCeWxyOHUvOTZIZjFRY0FGTGl0VllCYTRM?=
 =?utf-8?B?RTZaUFdFbXB0L2F5eFRIWGFqSlMrd0hOanBuWUdNeG5iQURFSUxXeFVveW1k?=
 =?utf-8?B?cWhsNXpwS2ozYWdvSUYrUlN5RlVLTjJoeHQ1UU9yMytFTXJVMjdLdlB4eDht?=
 =?utf-8?B?MUZtNS9LY2dYNU8zQlBDWWw2VXVCK0tjTnQxZjNLVytsMWQzV3VrYVVvbWdN?=
 =?utf-8?B?ZGwzN2E4VFk2UHhTZjJrY0NKZ3BvVnJxVnBPcVVzRTBiV2VRekZXQllhR2NY?=
 =?utf-8?B?ZnR6MUF4SzVxYlRnR1RoR0VHbWUzYkp3Nlh2czFiWVllalZYdXd5Kzkxb1NR?=
 =?utf-8?B?WGhXbG9vNU9RM0F4UUt3bzNtNVlIRHcxZGRXL3BFUjVFYzZrMzU0b2ZoaUhq?=
 =?utf-8?B?bUhVZ2phVHhvcGxhSHlpSWFIS1d1WTRDT0R5ZWRCOVZFamZzbFdVM05oaWlH?=
 =?utf-8?B?VjQ3ampxODJhY2VUWEF1WlljbGV1MnV6dHBLSjQzMm53b08xYjlDVW1Hbi8w?=
 =?utf-8?B?a21YRk13UWNmNkVqL213RDUxTDZZM0JPcXdrY1hUZXZaWWRRM2tvZVZSM2tH?=
 =?utf-8?B?a2xNbFdQT2p2YXdwcGJLWkMxT2ZqbUZ0bUdCVDBOQkVlQWF4NUdNdmZETFA1?=
 =?utf-8?Q?H1mI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6d99d4-ee32-43a2-9dc2-08dd5a87f68f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 19:16:56.1774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHFyNSezZBojqpzpQiceO7/MHLEUrPXsgkVuqxR1JnERM21sOgAceGRgeofoIZFm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666

Hi Peter/Reinette,

On 2/26/25 07:27, Peter Newman wrote:
> Hi Babu,
> 
> On Tue, Feb 25, 2025 at 10:31 PM Moger, Babu <babu.moger@amd.com> wrote:
>>
>> Hi Peter,
>>
>> On 2/25/25 11:11, Peter Newman wrote:
>>> Hi Reinette,
>>>
>>> On Fri, Feb 21, 2025 at 11:43 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>>
>>>> Hi Peter,
>>>>
>>>> On 2/21/25 5:12 AM, Peter Newman wrote:
>>>>> On Thu, Feb 20, 2025 at 7:36 PM Reinette Chatre
>>>>> <reinette.chatre@intel.com> wrote:
>>>>>> On 2/20/25 6:53 AM, Peter Newman wrote:
>>>>>>> On Wed, Feb 19, 2025 at 7:21 PM Reinette Chatre
>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>> On 2/19/25 3:28 AM, Peter Newman wrote:
>>>>>>>>> On Tue, Feb 18, 2025 at 6:50 PM Reinette Chatre
>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>> On 2/17/25 2:26 AM, Peter Newman wrote:
>>>>>>>>>>> On Fri, Feb 14, 2025 at 8:18 PM Reinette Chatre
>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
>>>>>>>>>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
>>>>>>>>>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
>>>>>>>>>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>>>>>>>>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>>>>>>>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> (quoting relevant parts with goal to focus discussion on new possible syntax)
>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I see the support for MPAM events distinct from the support of assignable counters.
>>>>>>>>>>>>>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>>>>>>>>>>>>>>> Please help me understand if you see it differently.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Doing so would need to come up with alphabetical letters for these events,
>>>>>>>>>>>>>>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> mbm_local_read_bytes a
>>>>>>>>>>>>>>>> mbm_local_write_bytes b
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Then mbm_assign_control can be used as:
>>>>>>>>>>>>>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>>>>>>>>>>>>>>> <value>
>>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>>>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>>>>>>>>>>>>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>>>>>>>>>>>>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
>>>>>>>>>>>>
>>>>>>>>>>>> As mentioned above, one possible issue with existing interface is that
>>>>>>>>>>>> it is limited to 26 events (assuming only lower case letters are used). The limit
>>>>>>>>>>>> is low enough to be of concern.
>>>>>>>>>>>
>>>>>>>>>>> The events which can be monitored by a single counter on ABMC and MPAM
>>>>>>>>>>> so far are combinable, so 26 counters per group today means it limits
>>>>>>>>>>> breaking down MBM traffic for each group 26 ways. If a user complained
>>>>>>>>>>> that a 26-way breakdown of a group's MBM traffic was limiting their
>>>>>>>>>>> investigation, I would question whether they know what they're looking
>>>>>>>>>>> for.
>>>>>>>>>>
>>>>>>>>>> The key here is "so far" as well as the focus on MBM only.
>>>>>>>>>>
>>>>>>>>>> It is impossible for me to predict what we will see in a couple of years
>>>>>>>>>> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctrl interface
>>>>>>>>>> to support their users. Just looking at the Intel RDT spec the event register
>>>>>>>>>> has space for 32 events for each "CPU agent" resource. That does not take into
>>>>>>>>>> account the "non-CPU agents" that are enumerated via ACPI. Tony already mentioned
>>>>>>>>>> that he is working on patches [1] that will add new events and shared the idea
>>>>>>>>>> that we may be trending to support "perf" like events associated with RMID. I
>>>>>>>>>> expect AMD PQoS and Arm MPAM to provide related enhancements to support their
>>>>>>>>>> customers.
>>>>>>>>>> This all makes me think that resctrl should be ready to support more events than 26.
>>>>>>>>>
>>>>>>>>> I was thinking of the letters as representing a reusable, user-defined
>>>>>>>>> event-set for applying to a single counter rather than as individual
>>>>>>>>> events, since MPAM and ABMC allow us to choose the set of events each
>>>>>>>>> one counts. Wherever we define the letters, we could use more symbolic
>>>>>>>>> event names.
>>>>>>>>
>>>>>>>> Thank you for clarifying.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> In the letters as events model, choosing the events assigned to a
>>>>>>>>> group wouldn't be enough information, since we would want to control
>>>>>>>>> which events should share a counter and which should be counted by
>>>>>>>>> separate counters. I think the amount of information that would need
>>>>>>>>> to be encoded into mbm_assign_control to represent the level of
>>>>>>>>> configurability supported by hardware would quickly get out of hand.
>>>>>>>>>
>>>>>>>>> Maybe as an example, one counter for all reads, one counter for all
>>>>>>>>> writes in ABMC would look like...
>>>>>>>>>
>>>>>>>>> (L3_QOS_ABMC_CFG.BwType field names below)
>>>>>>>>>
>>>>>>>>> (per domain)
>>>>>>>>> group 0:
>>>>>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>> group 1:
>>>>>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>> ...
>>>>>>>>>
>>>>>>>>
>>>>>>>> I think this may also be what Dave was heading towards in [2] but in that
>>>>>>>> example and above the counter configuration appears to be global. You do mention
>>>>>>>> "configurability supported by hardware" so I wonder if per-domain counter
>>>>>>>> configuration is a requirement?
>>>>>>>
>>>>>>> If it's global and we want a particular group to be watched by more
>>>>>>> counters, I wouldn't want this to result in allocating more counters
>>>>>>> for that group in all domains, or allocating counters in domains where
>>>>>>> they're not needed. I want to encourage my users to avoid allocating
>>>>>>> monitoring resources in domains where a job is not allowed to run so
>>>>>>> there's less pressure on the counters.
>>>>>>>
>>>>>>> In Dave's proposal it looks like global configuration means
>>>>>>> globally-defined "named counter configurations", which works because
>>>>>>> it's really per-domain assignment of the configurations to however
>>>>>>> many counters the group needs in each domain.
>>>>>>
>>>>>> I think I am becoming lost. Would a global configuration not break your
>>>>>> view of "event-set applied to a single counter"? If a counter is configured
>>>>>> globally then it would not make it possible to support the full configurability
>>>>>> of the hardware.
>>>>>> Before I add more confusion, let me try with an example that builds on your
>>>>>> earlier example copied below:
>>>>>>
>>>>>>>>> (per domain)
>>>>>>>>> group 0:
>>>>>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>> group 1:
>>>>>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>> ...
>>>>>>
>>>>>> Since the above states "per domain" I rewrite the example to highlight that as
>>>>>> I understand it:
>>>>>>
>>>>>> group 0:
>>>>>>  domain 0:
>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>  domain 1:
>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>> group 1:
>>>>>>  domain 0:
>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>  domain 1:
>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>
>>>>>> You mention that you do not want counters to be allocated in domains that they
>>>>>> are not needed in. So, let's say group 0 does not need counter 0 and counter 1
>>>>>> in domain 1, resulting in:
>>>>>>
>>>>>> group 0:
>>>>>>  domain 0:
>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>> group 1:
>>>>>>  domain 0:
>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>  domain 1:
>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>
>>>>>> With counter 0 and counter 1 available in domain 1, these counters could
>>>>>> theoretically be configured to give group 1 more data in domain 1:
>>>>>>
>>>>>> group 0:
>>>>>>  domain 0:
>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>> group 1:
>>>>>>  domain 0:
>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>  domain 1:
>>>>>>   counter 0: LclFill,RmtFill
>>>>>>   counter 1: LclNTWr,RmtNTWr
>>>>>>   counter 2: LclSlowFill,RmtSlowFill
>>>>>>   counter 3: VictimBW
>>>>>>
>>>>>> The counters are shown with different per-domain configurations that seems to
>>>>>> match with earlier goals of (a) choose events counted by each counter and
>>>>>> (b) do not allocate counters in domains where they are not needed. As I
>>>>>> understand the above does contradict global counter configuration though.
>>>>>> Or do you mean that only the *name* of the counter is global and then
>>>>>> that it is reconfigured as part of every assignment?
>>>>>
>>>>> Yes, I meant only the *name* is global. I assume based on a particular
>>>>> system configuration, the user will settle on a handful of useful
>>>>> groupings to count.
>>>>>
>>>>> Perhaps mbm_assign_control syntax is the clearest way to express an example...
>>>>>
>>>>>  # define global configurations (in ABMC terms), not necessarily in this
>>>>>  # syntax and probably not in the mbm_assign_control file.
>>>>>
>>>>>  r=LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>  w=VictimBW,LclNTWr,RmtNTWr
>>>>>
>>>>>  # legacy "total" configuration, effectively r+w
>>>>>  t=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>>>
>>>>>  /group0/0=t;1=t
>>>>>  /group1/0=t;1=t
>>>>>  /group2/0=_;1=t
>>>>>  /group3/0=rw;1=_
>>>>>
>>>>> - group2 is restricted to domain 0
>>>>> - group3 is restricted to domain 1
>>>>> - the rest are unrestricted
>>>>> - In group3, we decided we need to separate read and write traffic
>>>>>
>>>>> This consumes 4 counters in domain 0 and 3 counters in domain 1.
>>>>>
>>>>
>>>> I see. Thank you for the example.
>>>>
>>>> resctrl supports per-domain configurations with the following possible when
>>>> using mbm_total_bytes_config and mbm_local_bytes_config:
>>>>
>>>> t(domain 0)=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>> t(domain 1)=LclFill,RmtFill,VictimBW,LclNTWr,RmtNTWr
>>>>
>>>>    /group0/0=t;1=t
>>>>    /group1/0=t;1=t
>>>>
>>>> Even though the flags are identical in all domains, the assigned counters will
>>>> be configured differently in each domain.
>>>>
>>>> With this supported by hardware and currently also supported by resctrl it seems
>>>> reasonable to carry this forward to what will be supported next.
>>>
>>> The hardware supports both a per-domain mode, where all groups in a
>>> domain use the same configurations and are limited to two events per
>>> group and a per-group mode where every group can be configured and
>>> assigned freely. This series is using the legacy counter access mode
>>> where only counters whose BwType matches an instance of QOS_EVT_CFG_n
>>> in the domain can be read. If we chose to read the assigned counter
>>> directly (QM_EVTSEL[ExtendedEvtID]=1, QM_EVTSEL[EvtID]=L3CacheABMC)
>>> rather than asking the hardware to find the counter by RMID, we would
>>> not be limited to 2 counters per group/domain and the hardware would
>>> have the same flexibility as on MPAM.
>>
>> In extended mode, the contents of a specific counter can be read by
>> setting the following fields in QM_EVTSEL: [ExtendedEvtID]=1,
>> [EvtID]=L3CacheABMC and setting [RMID] to the desired counter ID. Reading
>> QM_CTR will then return the contents of the specified counter.
>>
>> It is documented below.
>> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
>>  Section: 19.3.3.3 Assignable Bandwidth Monitoring (ABMC)
>>
>> We previously discussed this with you (off the public list) and I
>> initially proposed the extended assignment mode.
>>
>> Yes, the extended mode allows greater flexibility by enabling multiple
>> counters to be assigned to the same group, rather than being limited to
>> just two.
>>
>> However, the challenge is that we currently lack the necessary interfaces
>> to configure multiple events per group. Without these interfaces, the
>> extended mode is not practical at this time.
>>
>> Therefore, we ultimately agreed to use the legacy mode, as it does not
>> require modifications to the existing interface, allowing us to continue
>> using it as is.
>>
>>>
>>> (I might have said something confusing in my last messages because I
>>> had forgotten that I switched to the extended assignment mode when
>>> prototyping with soft-ABMC and MPAM.)
>>>
>>> Forcing all groups on a domain to share the same 2 counter
>>> configurations would not be acceptable for us, as the example I gave
>>> earlier is one I've already been asked about.
>>
>> I don’t see this as a blocker. It should be considered an extension to the
>> current ABMC series. We can easily build on top of this series once we
>> finalize how to configure the multiple event interface for each group.
> 
> I don't think it is, either. Only being able to use ABMC to assign
> counters is fine for our use as an incremental step. My longer-term
> concern is the domain-scoped mbm_total_bytes_config and
> mbm_local_bytes_config files, but they were introduced with BMEC, so
> there's already an expectation that the files are present when BMEC is
> supported.
> 
> On ABMC hardware that also supports BMEC, I'm concerned about enabling
> ABMC when only the BMEC-style event configuration interface exists.
> The scope of my issue is just whether enabling "full" ABMC support
> will require an additional opt-in, since that could remove the BMEC
> interface. If it does, it's something we can live with.

As you know, this series is currently blocked without further feedback.

I’d like to begin reworking these patches to incorporate Peter’s feedback.
Any input or suggestions would be appreciated.

Here’s what we’ve learned so far:

1. Assignments should be independent of BMEC.
2. We should be able to specify multiple event types to a counter (e.g.,
read, write, victimBM, etc.). This is also called shared counter
3. There should be an option to assign events per domain.
4. Currently, only two counters can be assigned per group, but the design
should allow flexibility to assign more in the future as the interface
evolves.
5. Utilize the extended RMID read mode.


Here is my proposal using Peter's earlier example:

# define event configurations

========================================================
Bits	Mnemonics    	Description
====   ========================================================
6       VictimBW	Dirty Victims from all types of memory
5       RmtSlowFill     Reads to slow memory in the non-local NUMA domain
4       LclSlowFill     Reads to slow memory in the local NUMA domain
3       RmtNTWr  	Non-temporal writes to non-local NUMA domain
2       LclNTWr 	Non-temporal writes to local NUMA domain
1       mtFill		Reads to memory in the non-local NUMA domain
0       LclFill		Reads to memory in the local NUMA domain
====    ========================================================

#Define flags based on combination of above event types.

t = LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
l = LclFill, LclNTWr, LclSlowFill
r = LclFill,RmtFill,LclSlowFill,RmtSlowFill
w = VictimBW,LclNTWr,RmtNTWr
v = VictimBW	

Peter suggested the following format earlier :

/group0/0=t;1=t
/group1/0=t;1=t
/group2/0=_;1=t
/group3/0=rw;1=_

Interpretation:
/group0/0=t;1=t  : Assign a counter with event configuration 't' to domain
0 and 1 on the resctrl group0.

This format does not indicate which index should be used for assignment.
Based the index we can read the events from either mbm_total_bytes or
mbm_local_bytes.

Currently, we can assign two counters to a group and events can be read
from mon_data/mon_L3_00/mbm_total_bytes (index 0) and
mon_data/mon_L3_00/mbm_local_bytes (index 1).

To address this, we need to include the index in some form. One approach
is to incorporate this information into the group's name.

Like below:

/group0:0/0=t;1=t
/group0:1/0=l;1=l
/group1:0/0=t;1=t
/group2:1/0=_;1=t
/group3:0/0=rw;1=_


Interpretation:
/group0:0/0=t;1=t : Assign a counter with event configuration 't' to
domain 0 and 1 on the resctrl group0 and use the index 0. The events can
be read in group0/mon_data/mon_L3_00/mbm_total_bytes and
group0/mon_data/mon_L3_01/mbm_total_bytes


/group0:1/0=l;1=l  :  Assign a counter with event configuration 'l' to
domain 0 and 1 on the resctrl group0 and use the index 1. The events can
be read in group0/mon_data/mon_L3_00/mbm_local_bytes and
group0/mon_data/mon_L3_01/mbm_local_bytes


What are your thoughts?
-- 
Thanks
Babu Moger

