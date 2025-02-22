Return-Path: <linux-kernel+bounces-526844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FAEA40446
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A78D3ABCB5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3BD4644E;
	Sat, 22 Feb 2025 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pJygW9Y+"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B0335948;
	Sat, 22 Feb 2025 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184610; cv=fail; b=nr0d+yCLBZh3wHoMBZuf8GaPB+DQBiv4ixbJlBMIiviZu+7phUkQUCNbO6jeibfLplyFFDMaVZ4kcSKBYwgzeRPsUhQfsAfNK32w3d14LbCR431xcAgtOhylFU7Ln3zEsLAfam/nhcZkM+I4AfJDomsMmCZVBB02VSRD0UCJDrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184610; c=relaxed/simple;
	bh=FZ36R0Dq2Z0oFNPtXE0RE23fvPU7g7yOA/myE7IxySQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PA9CoAcTXwMjfdCqb+k/cvG1WobITqeHTW5E81HnNIWCbvSewXolWeiMeTXb0qccobe3taWbVuKBpcpXm+EuED9osOZka3cBPFd6CP3880K09464zVmP6eWQ0dsVYmGnaWus3uEN61NlW6sYtp/J1IXkOdStOvBMHcDSPVfOOzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pJygW9Y+; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhd6NKkNeRipAoI5O0JM8JMeLs0//vgqBE+pf4rzUJ4SXHq54IHzKQLo4vgyZAtBxWL6WqUcUjAMwryOPAPSWzf6eUZ5WFZPgcJB38cJGz7mWKSCStcsoBUNGK56ezranEmmf1JmYO6w7p5yySWYUPpSD7sxVGmb0mn1ZylxZltSrxX9VShH+V7Qr2dsBO94trqqt7IdOR/DtJMsoLx4dhQmbuCeDdku0YniWenPRC68lBhhQbhnNA4V9oncyzfLTZTuCWtWp4HdnjHA6rcwCcRU4skI9IdBmae3GIh5Yuby4J9qJ2IUUZkfl+VlDEBaMYCWXnk+axER3zGPWYX7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZJMabawyt2l7a8pnhHXNLx0LK1O4ue2oaPo7bHmAeI=;
 b=tAVq01mN7zk5v+v5y/4vFtcLYOxiot8SwVJ2kDZLEbFluoCqithDCer8vrkBZbVlvD0gnfJ75AJZVzO5Rscbtx/2YvX6OFPYJyr/gTT5z73XQ34bed22RRZF6/lDRFeOskCL5dFEOJdLOUHxAPUQfzuxzMjQoWTxS6pgtwJNC8lZb4s39YVrCHhnS7MbOZkNEdgJDN+WYZnkwraap7quCUnVNvkcSAZBhuJviUnFHz4zyu5y8zUHC91e2aJLQ9L4nCWKFdzmdB0z6hC2h/WiKDP7LV4Ou2HVLaB9o1qcn/Oj9UqWVgsHdNQOoHSjHm4goRo+Qp4x6TP0KZ3CDKRQzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZJMabawyt2l7a8pnhHXNLx0LK1O4ue2oaPo7bHmAeI=;
 b=pJygW9Y+38YY2skZPWnSvjYgMQGTRzk5PI01l+/6NeDsMSlbHMztm3BxE80CUy15gEqe3R+KGbMEu0tB6B3Ih2AcVSjxT+uIt5AJKb507VAPctODEa819d4vtaeYZzvc/bS5ShyKNjD14aruprJU9tvj9C51camyACpuU8li2pw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA5PPFE3F7EF2AE.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Sat, 22 Feb
 2025 00:36:46 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Sat, 22 Feb 2025
 00:36:45 +0000
Message-ID: <075faedf-4c1c-4762-be82-2dc6280fab98@amd.com>
Date: Fri, 21 Feb 2025 18:36:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 16/23] x86/resctrl: Add the functionality to unassigm
 MBM events
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, tony.luck@intel.com, peternewman@google.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, jpoimboe@kernel.org, perry.yuan@amd.com,
 sandipan.das@amd.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 seanjc@google.com, xin3.li@intel.com, andrew.cooper3@citrix.com,
 ebiggers@google.com, mario.limonciello@amd.com, james.morse@arm.com,
 tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
 eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <36262057667c27acad777836cc1497b19cb7c06d.1737577229.git.babu.moger@amd.com>
 <9746fc25-1657-498a-a290-45baaa8d8c19@intel.com>
 <1ad70161-2046-4c7f-92c7-809b01c8c957@amd.com>
 <1faef062-ed33-46da-9378-7a224dbee811@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <1faef062-ed33-46da-9378-7a224dbee811@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:805:ca::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA5PPFE3F7EF2AE:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d37fae-f71a-4688-0129-08dd52d8fc52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUFvWUV5REFQT0RKc2ZDbUJQcFd2bVpzUmFYbkZWbXhybStOVzM3YzROQS9X?=
 =?utf-8?B?MHB2UWhsTkdlYW04c2o4VHUzMTdJUG02RThuaW5HeFdWMW1wMDZiSnZSSzVS?=
 =?utf-8?B?MXZkdkJGVVg0YVlVOHdjaG5YU2hBRm9qejgreXRTRDlEN0pVeDBOdXljRk1H?=
 =?utf-8?B?Z1RESXFQSEpUM2tjTW1uUk14bnZ6VlEzV212VWtkU0ZLRWxTT2RjNFhiY05J?=
 =?utf-8?B?WjNaRXJFTHA0OXpiSWZDakFyN3FSVXdGYi93enZUOUU2ZmxlQUo5RzdzVzZi?=
 =?utf-8?B?b2RCd0tkaStCd3p4Q29JRktIZ3JXYlZ0NExsdHk4MDFqQnMzMGljWUphOVM3?=
 =?utf-8?B?ZG1EbW1WbUh6ZG5Cd2g0WWlMOW9OYm9DSjVmMHhERm5wSHVuMVBCL0doZCsv?=
 =?utf-8?B?c0I1UGVEc0hsc0svWlJjSUxsaE1kZ05sK3p4YytyM3gxZ1hNNzlvVmlqS0E5?=
 =?utf-8?B?K2E5YmlrRndYdnczOUJPejZhU21YdXJWU09iVjJqcXBLdmpxa0RXRlJmdGlY?=
 =?utf-8?B?NTkxTjJxWFkwWGMzdUJOTE5PSy9yWW9iV0p4K1RBajkvQmxjVHRrT09QUEE4?=
 =?utf-8?B?K3oyaEgxVjlpZUREMWJHbkI4UFRuTS9RaDNXQ2NYQ29tb2pWNHJEQTNKMm4w?=
 =?utf-8?B?UUsyL0Q3bkpiUGhreTk4dWpaeU1ybmFhRDlFODJTUCs0NkZ2OEFHa0dhbXpS?=
 =?utf-8?B?TjhLMTQ0VW9vaGQ4ZEp1TmpPOXFUZ3ZDTlJDSkZQV1EyT3R2QVdrREJGSkph?=
 =?utf-8?B?czF6bE9JWkxvU3NpdkYvNGQraDJtWkhzQkEyNVozYUNEdXVmL0wvaE5JMUh5?=
 =?utf-8?B?MG1rdFV3R21OOXlDbmRJOVJyTWtKaDRKVWF3M1BqM29PVWtlMFR0OFdHWUdm?=
 =?utf-8?B?RTd6a2FST3NlNWFwWFRXcXVmNmRXa043Ky9vMnM4dEN6b0FvWlJhUUlzbzFN?=
 =?utf-8?B?WW5BYVo5b3ArcjRKbW1WZWFOVGlRMEc4YkdmSXFQaHBxbTdkZjducXMxaGor?=
 =?utf-8?B?Q1YycWNHRlJRcjRieWlhYmpDZmRMaUsvWS9zK3NnWkVUTU5PWndQYWVVcjdO?=
 =?utf-8?B?UHJWeFJLZ0FJMU52a3haN25uaE00UHE4UUY4L1BTWHlMTk5YSmVOK2pXMGNv?=
 =?utf-8?B?OTN4WEg2Uy9PMXVGbEc5TEdGcnhaQjRyam84ZGVOVnRvTi85bWhnL3NpbDF0?=
 =?utf-8?B?ZGMrU2Vpb1plcUlkTi9jcTFVeFl1N3d2OFJhZkpWdnhsamtrUlR4S2x4MFRB?=
 =?utf-8?B?amhnUVovS1Zpb1UyTmpJVFlXdFBRU0t0TUlQbjFlQnVYOC9ycTdCUktDdFNG?=
 =?utf-8?B?ZTM1bmMwQlMyRzkwMFJaU0dTSDU2OTh1Q3d5MkRlNFhPYkdHSlFxNU9XKzl1?=
 =?utf-8?B?NDBTQjdHRHJrSlRFUU9lbHJ3S29CZXlhTlIzZHVzTUR4NDFtc2htbVp2Lzdy?=
 =?utf-8?B?Umk0S0NSZWFEVFVrVGRnR3lvUjFlYXArZ0d3OGlaYzUxb0d3R2pRR3pjbk1R?=
 =?utf-8?B?SVYzb1U0UkFCTGRpMXdHYTZkdXJVQ1FaY3NqUTJha3lOUlduR1Z5SktGTEUv?=
 =?utf-8?B?cGNkWXFxb2ZWQmJBbzZFV0xCcjJ5ZHcyWXNVVUxKOWlNRXArUVNyc0VCand2?=
 =?utf-8?B?bk9yOHBvemozd1p0L0VneEtVVFBwOUtkbFJxKythWWtFaXl4Q1hHU2QwVGF1?=
 =?utf-8?B?V01Fei9vZi9mTFVGc0t4ZzdpRVJERzRkSHNzUkEwOEE3VnUxTnpLeUVFUXA4?=
 =?utf-8?B?cU9qU2o0QkZHSVZNL1VNbnlYZHZtcVRiWEx5UVYwMFE1NlgzTkg1L2ZuU1F2?=
 =?utf-8?B?Nng2UUVuMCt0RnU3dCszTnlGeDhDZ0t6TUROUEFzWnd0WU84WEZjZEpodEVl?=
 =?utf-8?Q?FYFQmhNikVBQ4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmFIM3V6S0tCUEJEZ1hna3VJNHd2NDZBN3JOVGlCNlFhcFBFR0kwREI3WjEx?=
 =?utf-8?B?M3VrdUFCUDBzbjE0emk2ZXp5dFlDZXl6WGxPQ05Sb1U1T1BHNXRlZWh1blNt?=
 =?utf-8?B?ZkFSU1F0ZnhxWUZoWmE4MEpuazBBS0VxeVpoZTlUeE4zeEJoZ3lGSjVMdzcz?=
 =?utf-8?B?NkVnNEN6bjZkRFNuNGNIeVRCUmZXbDlUa01rbk10aU03bGVwYnZzYkQ1R0pX?=
 =?utf-8?B?QngveXJRWGR3aXAxOVJHcVJ4ZzBVTkNLU2RhZlJ1L1p3TjZDM1kwbEFnamRJ?=
 =?utf-8?B?WkV2cDhaQmdoSHEvVGQrSnRKdk13ZUEvcnVTM2NjcHRyU09iMndRZ0J1ZlV2?=
 =?utf-8?B?SWZmbWRpYnZuOUVoNW1wZjd0M0tBQ05HTmhJdzJBNVRSN0N3NGFXcU9BL3l6?=
 =?utf-8?B?V0R4SkNGTWUxZlVFenZjbnNqaE9NSlN3L0hxc1E5YU92di9idG1WNkUxLzc3?=
 =?utf-8?B?T3gvVTlteU9DOURZU3k3K1RyQ3ZBeUlqenB6VjZGanEwb1FQOFoyN2h3Lys0?=
 =?utf-8?B?emtvMjNGQTR0bWYyYWEySUtPeHZ5TGtyN0M0QWtHT1h2VXZJQ3VZUTlnL29r?=
 =?utf-8?B?aUJOd3d3UHhnQ0VFVStYUzF6elZGV0thMXNLT2N1eE9CMGFuWHoxaktZUGtT?=
 =?utf-8?B?eXFtbDVXcDNQa3IxbGpLc0c4WTZFL2lDcTZDczNScDBqbDBDc3M2YUxDRVlu?=
 =?utf-8?B?ZkJoZExKUXY3bkt2OUFYdTY0QS9VWVNHS3o4Z0hYa1E5NUZBdklBRFRicnRW?=
 =?utf-8?B?T1Nqd3ZoSHNUU1VuOW81ZkxuRmloQzN4T1NETGIvRmFwNnRXR3hEZ1R3UWlF?=
 =?utf-8?B?eHlqMDEweEJhSEZkWmd3Y09rVjE3M21jT2xzS3pkdGtKc3gvNkF1NFB6eEhi?=
 =?utf-8?B?bmtjV0VMazlveHJRa2V0c2ZhdjVVdmxickowdW8vbXcvQXppSzRTYk9nS1lV?=
 =?utf-8?B?RW44dVljc3hLYnc4SlRJOXJmdTAvaVZOOExoVjBXUzFyWUNJdDZ6NUdxTnVa?=
 =?utf-8?B?bkExUXVHTVdGNEFZdm9wYnpsTWNOcU1VWU1zR1pEcEExaVo4NVZPOGk0a00r?=
 =?utf-8?B?bkNscmNidFZnWDJFVHJOUnNGcUhJY1hMSmdZUEYwOGxhQzk2ekFWZGxnRjZH?=
 =?utf-8?B?eS94d3l2SFBZN2UxNXdtZFZMR2F1YkpMVW1GZVd3NTFBZmIvcVhDVGIwSFdS?=
 =?utf-8?B?akwwa3Y2WFAyVzBHYk03aU5EbDhNSGttRktqK1FsaFljVFVYcnhtWkU5Qloz?=
 =?utf-8?B?ZnJWb1lOZ25RMG1CMkFEU2xEc0tkYnYvbXE2N0JvM252K0FNM2NhSUpZRGRE?=
 =?utf-8?B?OHo0WkthbEJ0SkFEdlYrVDJEM0U5MzFnNTl0TTYxTWVEQldYekJobTFkcW1F?=
 =?utf-8?B?L3pIaURaNEJFeG1OZXZ3YkJwejhmQk9JbzlscnVveXdUejg0YjJkQUMwazBt?=
 =?utf-8?B?MExoVWs1UUdELzlDS0hiT3V2Vkw4SW5odjJPL3FzV2xFSmhNNUMvVzNSUUVB?=
 =?utf-8?B?N1UrMzRxSUVHVG11U3JRNlkwNHRtTFJjVEtMK2RmV2N6NUJhbEE0VGl5TVht?=
 =?utf-8?B?VjJiTlZxSzlkT21YS0xKUmFMZEtZL2x5SExDQVlFNjZZMXg1S3ZDQTFpakh5?=
 =?utf-8?B?dXVzTmsyLytwR0dCcFh4cTNuSHBSTjBCc3YvZ1lVVUFHYmxkenYxbHkzUjh1?=
 =?utf-8?B?a3hWTGRQZjdNKzZlRnlyT0ZvRkloOHFPSTg2bFc3ZUV3N1U0dnFHTzZoSVA3?=
 =?utf-8?B?Ky9lSEswQ0NwMVQ4UlQzekJrbjk3NzNteWgvNVhVcEhYczRzWjdUWmt2d2xr?=
 =?utf-8?B?NEtrSmtKNit2WHNEbDEwZGVLMzJSTGd5QVFENkpxWHgwblhHVzJCdERYRTJU?=
 =?utf-8?B?RXAxZEcvNDdxZXpFVU5yZzB3WUxpSU92enRqYzBiS2R3VUtsckF6dE45MmNI?=
 =?utf-8?B?ZVFidUlrb3lWOHUvaHp5UnlyMHVzUHNodk1UQ1hoaVVwSjVBTWJvL2dBRGF3?=
 =?utf-8?B?T2wvdTE2Z3MyK3NiU1NHMVRzS3pYdkN2NlZNL2paQjg1SG9iSktCRWszcFcw?=
 =?utf-8?B?UERYQ0R4ZjJKZyt6eWtrcVIrckNLZFNuRzFwN3FBQ0w3anpySXhJL3A1Zmcz?=
 =?utf-8?Q?K82o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d37fae-f71a-4688-0129-08dd52d8fc52
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 00:36:45.7939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdrjMzHnVd/RmqINwoUaq9Z5gXyhMdw9c4Q/bJvx5w8GBir801RHYzPdfBzkBJAC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE3F7EF2AE

Hi Reinette,

On 2/10/2025 12:30 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 2/10/25 8:23 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 2/5/25 21:54, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> subject: unassigm -> unassign
>>
>> Sure.
>>
>>>
>>> On 1/22/25 12:20 PM, Babu Moger wrote:
>>>> The mbm_cntr_assign mode provides a limited number of hardware counters
>>>
>>> (now back to "limited number of hardware counters")
>>
>> How about?
>>
>> The mbm_cntr_assign mode provides "num_mbm_cntrs" number of hardware counters
> 
> ok.
> 
>>
>>>
>>>> that can be assigned to an RMID, event pair to monitor bandwidth while
>>>> assigned. If all counters are in use, the kernel will show an error
>>>> message: "Out of MBM assignable counters" when a new assignment is
>>>> requested. To make space for a new assignment, users must unassign an
>>>
>>> To me "kernel will show an error" implies the kernel ring buffer. Please make
>>> the message accurate and mention that it will be in
>>> last_cmd_status while also considering to use -ENOSPC to help user space.
>>
>> If all the counters are in use, the kernel will log the error message
>> "Unable to allocate counter in domain" in /sys/fs/resctrl/info/
>> last_cmd_status when a new assignment is requested. To make space for a
>> new assignment, users must unassign an already assigned counter and retry
>> the assignment again.
>>
> 
> This is better, but can user space receive -ENOSPC to avoid needing to check
> and parse last_cmd_status on every error?

Yes. There was a problem in passing the error in 
resctrl_process_flags(). Took care of it now.

Thanks
Babu

