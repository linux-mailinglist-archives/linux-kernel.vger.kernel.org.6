Return-Path: <linux-kernel+bounces-549978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60855A5596B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8334C7A4872
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1CD279342;
	Thu,  6 Mar 2025 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B4esvILV"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4686155342
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299071; cv=fail; b=Ci7uV1gVtdhbaeXTmV0/i/6pg9AXwobxqgbt8X9pYeuIokQOfwyMsVveEIZmDgmmj9//GuOEIM/qU4FpCRBmOYqyUQU1qYKNxMI1qqtswqa4+hotVcrqneJURhizSqQmTA1SPLZqJRluifLbewMQIxGFLYTmLdRvimx85/B2e70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299071; c=relaxed/simple;
	bh=VP/8iEpxG5EdngFsgr55mzZJeDen+M/5cwpeT6gz9Gg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eako96uxR0JMcHaW5BHwR1MrEgm3xgNr114CVh3RpCb09AdtY1o/7PMUuZ3Nhqv/mhvtEIBnR7Ar3fMlxDwr8J0IotWNU3bwmbJblFYzYtPrDeehEGA9w8QF+X6r8N7yhZXDkBm3IVORLsaHW8rge9B7r/W5HJXGbXyiiJp1gUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B4esvILV; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORlzSsbVUzCubSHPAqfyVQWEoq1dFg/t8Cwi04USrsMWd3S2kngZ47O+vY6pxiRZARgJdKtI3PVH5/QK9AOPOBsEbfRfnsTgxfL2EUwA5e9a15Kx8zyObjkZ7vh2yKup/dM3dcHyltO0thWFe495drOF3zaZhhr6ygZHtc9fSjTul7kgrWdTyLO/Ffov+v6sj4cr9yL7UnC/u8Kb5m3QldsxJnEVcWAosD1TLS3dLrqqkJ1h7S+N+jtkt6BGEk/70CXTcH6JrsqFGIfxguu89O28LV8krsNJJFjaYJmtY+OEkLhrkf07Qcv0K90A8zB04XKPTjfNd+Bws5YgDoYH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyOMAbkknhdhsfcQ6zIg1MVy1nfMRgSHqE2Jq8gbwuI=;
 b=Lb5zphP/D7Ox1k3uaIUvNlHX9CUhvmMGl1lyrYfPDq1rLmHvm1gt0sMrSNxVL7EBDvTo2gtRDKjAzRiclpqvOWMj/36dWAzbOC7j9tAzEs396r/fwjskxWmhuKTL5t9MrAI38dgV5NUnTCTdtSx22WuhYZ2hM88xLKPw8HBHzguBHD5rqSonxBCU2Sv5Qa6RQzlCzv+NC6v2wvN4iNGLFcaPnv9p6+WoxS6PN2SV2UM+xYDT6rR2pFZVfEmEZzx8T7XDCWoHZhP5ETnS5omTTTpt2pH9OWfajYaPAS6Ln2D+2uTUcF970r7PsVrZ2YpgcwiBlY2jfEEts0sc+Sw0JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyOMAbkknhdhsfcQ6zIg1MVy1nfMRgSHqE2Jq8gbwuI=;
 b=B4esvILV2b26eKmbsEVbMVXRgzdv1i4usqZRHqvJxgAW/ZbShhwROYg2iRZ/fwI6viGqyN2EkHyu1j+DNeB/4gbf6FfOjX64+K1b2kmWDtivM0ZwF5xWYWgglYDiyuyGbd2YyFwuRgD9JvlC6hyvIiYAss5WLC/rZJYxvIr6BDZN9Er3uH9tvBGBju+cbNVToQjbfopU9cxmhOzRpQGkGlcPZjzKJOPTf1jxyIT3XVjLTuk5EcSHMlTncJtuuZq4XULh3QvnaHFN6NgbD+RtGoENB9MWvtXyR62bvar4+8FyrpAMOCwlIgFMyUNTyzUORIlHunk6UrJRtc4Q1aweow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 22:11:07 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 22:11:07 +0000
Message-ID: <dd7e7cf7-fa1f-44f0-9edf-6a6ede719bf5@nvidia.com>
Date: Thu, 6 Mar 2025 14:11:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 31/49] x86/resctrl: Remove the limit on the number of
 CLOSID
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
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-32-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-32-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0377.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::22) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: d5cb5bba-67de-4c7f-031b-08dd5cfbcb17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzJkWkhFc1hscHJicEtobE95NlhLV1JIazY4Zmx0WmdTUjRmcUwvdE1PQitq?=
 =?utf-8?B?ekNpZjAxOHBmMkRmTlgxUTNuTDdMbWd3emp5MWVYUWx6MDFPMWZSTjZ6SUdR?=
 =?utf-8?B?Q2Jkb0dQamE2Y3Q3K3ZiQndoeHlvME9EWDlLRUIzUnBNRnYycDgvSjFjS0l2?=
 =?utf-8?B?bkJHN3VoTG9wSGpPOG1ZL285WWUvMWU2VzVkUWY2WUhWVzVVcDVpV3pLZXhs?=
 =?utf-8?B?czRuTU9BMEN4bTVId1hxT3VSVjh3ZjhzTzh3M2RMVFo4VHFxc3Bka1NNT09o?=
 =?utf-8?B?UFpETVQvWVlERUc0SDVLK0hadWZCc3kyVmVFT0wyenphdTJjcWFzZEZIZHUx?=
 =?utf-8?B?OWk2bVBobElTV0NBa0czbUNEL0hGQ1hHL0pHS3M5V0E5Q0N1MDFtZktKVFZF?=
 =?utf-8?B?TmNNYmQzWW40dU9BQjBXNTM4Yy9reGpNeiszTkpiQjUxeGU5RHBWTHhSQmdk?=
 =?utf-8?B?MFVWK0ZpTUdqZTJvTlQyVXVRdk85TVZWV3FQdHlQQVB1RElBcEZTNEYxNi9G?=
 =?utf-8?B?b0NGNmRDdkVvU3BUTFRVUVNleGgvSXFRWmtibkxSZFpEMEo4dlVrbXc4RWlU?=
 =?utf-8?B?b2p4V2xEcEQwS0pGN1B2VUxzODZVNHZEbllWSVJoRWVhN24ydTdmUm8zSnl4?=
 =?utf-8?B?Tk9teVRCbzFkdjVLZHZvWjBzdHJuWDVuc242RHFOMEF3Q2NNQnhYamJpdGNF?=
 =?utf-8?B?RGY4OVhTckphbFhSVFI5RFVQYTVUdXduTUpBSjJ2RzZxcGN3VWlpSnlVR0VN?=
 =?utf-8?B?V3pHdVltYzhjTWxNN2ZJa2wvdEIrbzdjcWJpdzVaRzErWEI2T3VLMmNxSlAy?=
 =?utf-8?B?SlovcW4xU05WcjB1MGJtdVRkRDZQWVpFdWV3Q1FFZ1pJSUh5aXYwaUJuNEg1?=
 =?utf-8?B?aE9IbFpxczJOdktrWVlwbG5YWHdxRHZCK2owVzVVU3M5c25PUUFrTHovenRI?=
 =?utf-8?B?Zk1XRXJmV3FnS1YrUENxT2RPODkwdWdSVmtJWEswdHlUMzRiZVZLZjlpNG9Y?=
 =?utf-8?B?a2pXVTBubXEvUFpINmZscDBsWVRmZEl1RjRTSlVvc1YycmFja0lJUlo2RXFQ?=
 =?utf-8?B?K3RxZU81WFJpMjNpb0s2WjY0elRsNzhJU0ZzZ0luQWhlU0hMTlVzdllPZ1dt?=
 =?utf-8?B?aVlBdkp6REhRK0c5eFJoQk9ETkQ2NDUrUVFMNjk4YzVoU1A1Q3RXNVJDWFJx?=
 =?utf-8?B?Rk4yVW9kOFBKTlRXR1AzYjBVSVdCRzd5VURsUmhDNDZKWm1aOWRkWGtXc3My?=
 =?utf-8?B?NEVnYkZYaFdLcUwyWWJRL3lvSHYvL01zaWJMaGY3SzRJZUFuNEM1ZGdmd2o4?=
 =?utf-8?B?aVJ2YS81U1AxQTVpTXNGV1JtMGZhbUowK2ZTYmZYUHdiYTdyRzVGQ09DcDN1?=
 =?utf-8?B?MGJZUHVJRmF6b3BlTUFRTHFSbHo4VVh5WWwwYStWSG9rbFdlR1AzclkwRWMy?=
 =?utf-8?B?WVZxNVg2TUg0OEFZTFA1MUVRMUhrTEEzK0YyejFNYVZPVisweHplSzFaS01a?=
 =?utf-8?B?M0doekF3YmpLNmxZVUN5NHZibGZmZVJ1U2piUldsVGhoSVk1RFlSUDdaRkli?=
 =?utf-8?B?MzMvMlhHVjhuNGJJUVdKb3VUSXA1ZGhSUllwbS83UmJjamxEb3pDR2J5cllG?=
 =?utf-8?B?RWxJNG4vcU1JOTdUQlNhQjlxWGZHVStoQ0JJNlhseStFNlB2K3BnSVNYbTBM?=
 =?utf-8?B?TXNsR0FycE1pNDRjQSt1ak5Wc1ZiOEdma3pDK1NpOGRSVzZRZ2lLZGZ2c1hE?=
 =?utf-8?B?M2MycUt5UEErdjBIM3dLb0dXcm9oUGttUVA4QXJBc3RMQ2Rmd0xOS0lYKzcr?=
 =?utf-8?B?QWRXekptd1o4cGd5U1U3UmVIZExvUVFheEpXK2s5elhhT1ZoVHloY091K2Mx?=
 =?utf-8?Q?J3CS5LW3ccsBA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXlDVzJoLzBaclFZMVplT1BMZ05xSWFldlhKV0s0TnlESGs2amVzWm9hZXVO?=
 =?utf-8?B?RlVBcUhWOSsrdjlKWElrL3hkK1QrUE13dGxocFNvOElDSXV5dnF4aUpFVUtv?=
 =?utf-8?B?RUE3VUlFR1dRVGhyeG9sNXRLOGdRVlNtSGhzdFRWNVdqVVg5WEI5MFdySUd5?=
 =?utf-8?B?QlZFaDU5RjFGTCtzRldUUHJJeEVUZVJRRnlIMG9xWGhrSStPQjN0MTIxRzRN?=
 =?utf-8?B?L3dnb3VPMmc4N0pGdS9YQVhxNkpHNUdWZDBEazlqWUdQWjM2UkZhZkdxNTZz?=
 =?utf-8?B?REhFdHgxQUxvb09TV1RlT3phK0lhNmRwV1d3NS8wcGZtN2RLT3RLVllTbDBq?=
 =?utf-8?B?cTRnZGxldXpNV1d4V21NMUV4Rk9RK2tKQ2s3eWc5MjNnYmk3UzFudVJrQ1BP?=
 =?utf-8?B?V2xMRk9RWnNUMDlCckJnandaZ3lnd2NQNlRqMmdNYko1a0R4bFEzejZjcTRv?=
 =?utf-8?B?djdWbXo5RGE4UGkxZXVaZjBaQXc3NzdhQThEeXN1ZUpsMGMxR0tEbEhnNkFn?=
 =?utf-8?B?RGRGZnVKRDZaaW1ad2h2c0FYQTRtYXNPZDE1RFRHM21KNkhmSFJOVG5IUDdn?=
 =?utf-8?B?VWF3Tm9hWXROejRtczZCZWJ2UHcrWUIwVkhNUVgzZkRNWklMdlZsak95bm4z?=
 =?utf-8?B?TWJNcUg2RmFtR1YwbjJOYThLTWpsd3FTaEhGZDN2bnVrZEF6SWdoZTZMOEFq?=
 =?utf-8?B?dml6dE01TzBpajhCN2p6Zjg0aWpPZ1ZPV2JXWCs1d3J1OCtEU2JOaGdjbkty?=
 =?utf-8?B?aFpkMkVMTSswMmVGbGx1SXFVeUFPc0k1UTJyVkhOeGcwZWV1aDdKbWlPMklP?=
 =?utf-8?B?OW5Ea0R3MHdWNnJJa2c4bFk4N1VIdEZ4L1lZWkFBdmpwY2RJU240TWUzRE5k?=
 =?utf-8?B?ZnB1STR4d0VUT2kzMjVPOHV6SEJqdGZYTWRqYm1rQU1MMGQ2dEx1STFEZGZC?=
 =?utf-8?B?WlhoZTlJb3NISjMyS3RaNFU1c3RaM1Q4cXJreU9GcGxLNE9ZVFU3ekdPVTRK?=
 =?utf-8?B?RVFjWDZ4QmRKeHZYdlU3UElJRkxwN2N3d3AzYUZXVnRzNW9xWnZtdThwZ0Fm?=
 =?utf-8?B?SVRMbWlWbDlEYzVqQVluTEg2dE0xcjc1WmtrZGJpMTl4a2xaSXE2aEtqYmRC?=
 =?utf-8?B?UEwwMEZ5V3BYcnN3L2c1YkxuTFRHSkhUU1QxaERGUUozQ0ZJSm9GdHZBQ3N3?=
 =?utf-8?B?Qkl2UHdKZ3U2cFRoa0ZEdi9SK3hWSzR5SWUzTHJnZ1BQL3BrTDJEYkdpdDVB?=
 =?utf-8?B?bXNSUVhVOUhXcFc5dFJwTkJWY3pSRXZGK0szeGZEa3A5dW4rY25lYVpkcTdD?=
 =?utf-8?B?V2lZNWdCY3ZLUDZRNkVtN2RrQzYrNWw4Z1dKY24vMlNYa3pqTkdSdDJzMUZz?=
 =?utf-8?B?bTVQYkFzVEh3dkt4VFp6OFJTQWp0OWpxaU5XTng1S0M4ZXl6RTlvcUt3aFFs?=
 =?utf-8?B?VkNSa29JWGpsZUpMd2xWT2c4VXl5bTZaR2JvL0JRL0U4ZzhZRThDaHFmbXdv?=
 =?utf-8?B?dEJQSEFSQVBLTUNmekRwOTU1dE9EMUhlME9ReWVQVkc5WGJoZXJ1YVdoYXll?=
 =?utf-8?B?emVQdm1wNWNOL2E4dnRVZFh4V1haWEZPaXJ4QUtXVVozdmJSMnJmRjBYc3NB?=
 =?utf-8?B?NUM1amU0Q01uaVdtL3F5VW9vSEdQdmNpV3lCMlBzUGhQamJwR3lrSzgxcG5l?=
 =?utf-8?B?OURmRXdnT0o1R29Fb2tROVJ3cDlZMGllMko1YkRjc2pzZFZxeUlUSmxZQWRq?=
 =?utf-8?B?YzBtT2dodGQvak5CeStkZ0MxclVWbkUrRzlaWk8zUVVTdm0vZzV3ekErbWFK?=
 =?utf-8?B?Ym0wb2phb1BxT24zeFZOR1o1MkVYZ29Nam1sN1NtVFp0aHV1NTkwYmE2Slcw?=
 =?utf-8?B?aGpNWUdJVjR1OW11TzBWWXE3YkM0clR6OTdGZFlqWU44R3h1QSs2NHBocXhC?=
 =?utf-8?B?akx2b0ZLOTVocjlrMG9VQ1ZmOTlOKzZVK1IrVVVrL3hrL0lhMWJMT3VHTVJF?=
 =?utf-8?B?ekVBTDl5bXJLUDNpNVFxaUlnaVYxVlRSUjRSN0ErekRjeCticjRXUG9NK1Nl?=
 =?utf-8?B?MzN4M3lZTkcyTzBnRm8wWjZMMldUbGtlL0lxNzNxL3NmZDYvSmhJcnhvUUEz?=
 =?utf-8?Q?P8iFe3dHdbJ3X5gb6tLSezRw5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cb5bba-67de-4c7f-031b-08dd5cfbcb17
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 22:11:07.1979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPmqTQFcYYa+g6D7pC7zP+w2dCz06UKEWpck5L3DlQxINwXU+9PpvhV422qKGY310M8xsvIvRq6SP8KLhnPRcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455


On 2/28/25 11:58, James Morse wrote:
> From: Amit Singh Tomar <amitsinght@marvell.com>
>
> Resctrl allocates and finds free CLOSID values using the bits of a u32.
> This restricts the number of control groups that can be created by
> user-space.
>
> MPAM has an architectural limit of 2^16 CLOSID values, Intel x86 could
> be extended beyond 32 values. There is at least one MPAM platform which
> supports more than 32 CLOSID values.
>
> Replace the fixed size bitmap with calls to the bitmap API to allocate
> an array of a sufficient size.
>
> ffs() returns '1' for bit 0, hence the existing code subtracts 1 from
> the index to get the CLOSID value. find_first_bit() returns the bit
> number which does not need adjusting.
>
> Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
> [ morse: fixed the off-by-one in the allocator and the wrong
>   not-found value. Removed the limit. Rephrase the commit message. ]
> Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua

