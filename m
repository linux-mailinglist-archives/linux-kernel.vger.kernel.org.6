Return-Path: <linux-kernel+bounces-354303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E16993B87
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65C31C22C19
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 00:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B343A94D;
	Tue,  8 Oct 2024 00:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wZEv7n2L"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2894A04;
	Tue,  8 Oct 2024 00:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728345684; cv=fail; b=THgS88Hl/EOtWS0h4G8YcTwYv+b1EGU/Dqo+rNrHewtFA2P+mG1T0fF3zD+GRL3CkDYcLrHW81ub2nQM4apEJ0bAlS63n4+HEtZhSDmNx5VV3M+M+ybtx48zIu/gUQRUwfAJfZMWzUGNUgf4PujdQOaMLMWBclB/IIIhny1KQho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728345684; c=relaxed/simple;
	bh=XqiFZtyUrGMR3ze80btrBdNSMKoXgtmnJ38OSKSek9c=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u751ovTGr+AefZ4snjr6TEnxk02iZ9HAOAyeIESD8bHR3A8HTv8QwxwLGcFoop11LQC8UQOAsq5mXXdqfnSxdw5bs1tAnPS0zvlS9WALpdiGKvLke0ChefSapHrVDjX/R4FRvLFY6W5yrc47LCpjobCaQ0392D81ROWlOk7/BPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wZEv7n2L; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yivJgxVFiKofqLLmYDqFR3s0Hik1gGixXww6SlyPCYhSBVV1TMWegt04Yd0cK4KgFkiwQXsvNl4EV4z7F6YCmqpKDQ+tliVYyHAyPJXTCN5HWkLqV6ouDaSsLntd/tgeziMsK9g2MrljLbLl0P6I+51AI4NWyE5Z/2Hhw54DGx7yEsyV1wSFzteqiL3Al1e/Hc3XBDchDnwBqvA5/HypfjFzOEcHtWtpJ/A6dRFE5mqzC8W+V2TAQ/avOhfd79yOM8tG8aiA5fUlw/lvsXeCrKUjiq9K57OqPvzvtQFnXaKEsIkv/cuSNdAt8nqQT9iQk3Fsq6r2JXCfK1zTX7Hltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LLZNWiKP6OGNbhmI4WGTQuqf3JOuG+Wbha6brG7M0U=;
 b=wLrPGaYSxZZ/R8NnKtY2qJ4OLYAZivc+ljCx6m0xwVmHYMZHxuZnFQUzNorRyMI9rcKEQEKEi5PAlkTyZSvx2bE8991Sv8lqooQvXeAgNkQbZs+jfVg8Xr9iCqQGomQ4I9cQVTAYB9QoZasA8nBwYeFIuvdGZTo7TanMbLjY4QLJHuY/O5Zno3inAVtfZrn4kYaadHqeDzQ8Dk5tRmBMhhxO3iWDbwFh0iJG10fUtotnagJ6G1Bcmtw1gBjkWPXMe3slRxTRZh75HJ2IT0xv1b7+LAzuKgbZrbAEWJ75Bl92WP18IbSNWAn24sBgBszYWwgHGBt3nzO+B1J4XBdbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LLZNWiKP6OGNbhmI4WGTQuqf3JOuG+Wbha6brG7M0U=;
 b=wZEv7n2LcAKk29Vrkx3n0H7UExhD49r8KDOvg4tEZVQI1A0m785/HcoRBSIxaPIZzzNo796V+6DHX7n7WF88iBqnfiGUcG3Vj+br+V3/EB0es06xInratZ59G0qKzsCnon4c7Cq+/sNK23t48vpdmYT4S3tBf97AR0lP5/qq5FA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Tue, 8 Oct
 2024 00:01:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 00:01:20 +0000
Message-ID: <7e71b969-e0e4-51c7-da84-ab111e9be9e3@amd.com>
Date: Mon, 7 Oct 2024 19:01:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 22/24] x86/resctrl: Update assignments on event
 configuration changes
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <ff0cd2a73c78fdb7487632381b4aec642a0af5ef.1725488488.git.babu.moger@amd.com>
 <384c2074-0076-4686-bebd-ba3ac3c05188@intel.com>
 <f77737ac-d3f6-3e4b-3565-564f79c86ca8@amd.com>
 <d2147cb6-9d1a-49af-9be8-5d788ce7ee7b@intel.com>
 <c514416e-4320-3826-21dd-7e79ebc83351@amd.com>
 <33c56f32-4e56-47b5-890c-fbf1d45d7213@intel.com>
 <9621def4-2753-0f50-ceb6-3185c1789fec@amd.com>
In-Reply-To: <9621def4-2753-0f50-ceb6-3185c1789fec@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0044.namprd12.prod.outlook.com
 (2603:10b6:802:20::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0c5329-2899-4d7e-7658-08dce72c56de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUNoU2k2bFl5bmorYTNRK05xRE03SmhYUzlhQW9BWlNwSm5XRHhTYTJwaDEy?=
 =?utf-8?B?cDNhTEM3UnEvWjhyazcvLzZncVAxOTVhTFJoQU92bVVDL2d6NVZseDN4MVVp?=
 =?utf-8?B?b0FRcjBzOFlialNyOU16bER1WUxmeFBYSUV4cEpKZzJxbEl1TDRCV3E0ZXVQ?=
 =?utf-8?B?VmdreWd3RDg0Z0FRU2todDNaanp1Y2dSdi9uRW9XY2tmN2QwOWJ0OHBsaHdP?=
 =?utf-8?B?RzdPdERSdEFHS0Y0T28vYkV0OVBsZC9xTUIvbGZhVHR0cVdialo5NlhZdjFw?=
 =?utf-8?B?bTIvRFZvd3dXTGRTVERUb1VoQzNFQ1NVQm1vWDJIalFIV0U1MXNXQ1dqcmNR?=
 =?utf-8?B?R0FmTkJKWU1WRHhtZnZNZmR1SlNjeGF5aE14cVVMc1NxYjNVU3dSQmRlUU1F?=
 =?utf-8?B?N1FnMnZiSk01ZjlaNHJXRzZZcFhIaDhSU0hFcnJtazFVWmJzQWRuMXI3SEQv?=
 =?utf-8?B?bjh5QzRlbWVxV1NCK1hDbmhuSjBaV3Z2elZHYVlYVWlVZlQvdjh2V0tnNFNk?=
 =?utf-8?B?c1UxZDR4SG1ZVkgxb2dtRDZlV054dlRoUVBqSjAxSmhBeExZY1EzMDV5Zjcw?=
 =?utf-8?B?V0R6cDZQZ0xyYUpyVUFOQnJiK3IvWldCK2NpSzJVZUFKZW1NbUt2S2Y5NENK?=
 =?utf-8?B?NWpBcG9yNFpjRENiTEhWc2dtK2cva2xJK0gwUHBudjNvRE5hV2pjTW9saDQz?=
 =?utf-8?B?WlVLaWsvSlducUlBdjNWbGNaWWNjL3N1ZGxpZUZReFZVQTNrUUdiY2dmOEVS?=
 =?utf-8?B?ZmdPSW94ckxseDJBS0tnOHExMy90OXIyWVBPVlFLeHlBQXFpRnJwT292MFhH?=
 =?utf-8?B?Q1ZRcURmMUNha3BoNmpEeHVWQlRramJjSEo5b0o3SHEvWmRRYXNrZElUbDMw?=
 =?utf-8?B?WjlhYTdrUWM5bStCWldDeG54VWxEVmR2MUt0Y3NHa2Y0VjVlUGoyV2szTmg5?=
 =?utf-8?B?QjZZUU1teDlpWGtpelJxMGliNW5KbnB0U0RVY0tad3c2bE53SENPdUYyeE0r?=
 =?utf-8?B?cmN6LythMFZtSVlIVjhzeDIxaVpvSVpMT1NWMG5NMEdOYjJoOThmSThBRlFl?=
 =?utf-8?B?UjB5cEF3eExKYU1TSE5hKzBMN0RwY0JFeExscDhCVnJYVHNFWElZcTQwTzZS?=
 =?utf-8?B?ZkNDOFpuWkJ4WXYwTXAyMitkTVVXQVRmZFYwV2JNZ2lzRUcvZXRreENHcnBv?=
 =?utf-8?B?ODFJemx2VUJCci9YMmFkQVFzbER1Nis5TStBeVU1YS9uQ1hFdndxbXFMdEVp?=
 =?utf-8?B?WUlHVk53WDh4T3JjZUJDSlpmSWJWdmFpZVNRR2JtWUtEdTRGTTluZFZsenNa?=
 =?utf-8?B?K0xPcS9rZVpFQUQ4N3REc0NqREhTMGFjeTArb284SkZxV1JZYzhzdmNwYXFt?=
 =?utf-8?B?TjhOOFk0M1NkckxGOWtlMDArTXJzVVlNclRYcWR6YlBVbDVDRE1hL0RQcUxy?=
 =?utf-8?B?NlJkNG9pVUZxS2NSNFZ4MFBMWmlseWFqbGJjdHA3b2ZnbEk2c1hRd1FJQ01a?=
 =?utf-8?B?SEU4T09icUhTcmhTWU5ZNUdFaTZuQW10cWNNcWpyUFRRdjZPaWV0bXRaWVlj?=
 =?utf-8?B?d0JIei8wQ0xwNlZubkVvRVpoWmhDQXNRNHVVZGJTNlZ4UVZiUnJZWThOa2xL?=
 =?utf-8?B?QUxhdU80c3hHcGNuUE5lV256UkE5Vy9MWXhVT3FESmgvcEswcDNxWGhiYy9y?=
 =?utf-8?B?Y25CK1BMU1UyMDMvOU1ISlY2N2ZKLzBZaUYycjlMNUsza3VKT0sxZWNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHRYL3JLaW1QNEM3bmJBTDNvUFJFbU1QeHBZOWZIVThZbWU0dnJ0cUVncHVi?=
 =?utf-8?B?SWFpc2o4SWd6Y2t6NWJ6c3dRWnVoZkpaeGRtRlB1VW01b09EWjR3OS9rQU92?=
 =?utf-8?B?ZytIcjlUaWVhMCtYTG5IZWUwdFZEbFZ5RGl5V3hMRlpYamxWR0tBbjZBekJy?=
 =?utf-8?B?ODdTMGhyNThlQkhiRHBkTU1ZcU1JdzNHQ3NaKzRpcEZHUzBWaDJNTWE2MU0v?=
 =?utf-8?B?b0RpN0s3cGtkOWFadWJlcmNMUU9yODViTkdCdHl0bkV6bnAwVFBzTzhzQ3Bz?=
 =?utf-8?B?OVRyZVpBTEdpeWxGZkRtc05tTGxrTy9pYTVPSDh2Qjl2bEpncUpDYVlpL2FY?=
 =?utf-8?B?TVZvb0hRanU1UVdqRDRGYjZGckhsYjB2T1hiekRGS3hlS0pwdUcxcWVyNUNE?=
 =?utf-8?B?blVWeEY0OUFIeWk0THZ3NFJJMW5QUE1hY240OU9oVnJBSnZvbzU4bjFkUWdK?=
 =?utf-8?B?V2RIYVVPY3pQZUQyRy9HRjNPbE5BOHNBMXhHdTlqRHAvRDVXQmhic1RpbkhE?=
 =?utf-8?B?Q1FnWW1YMXNSVUxjcllmVWNvZUhUR3JBR1FScWdyRzJ1R3VjaVVlZWdpUGZs?=
 =?utf-8?B?REdwRXp5RTE1QnpySmlqcmNWZ0kvNkxjVm5xL05nYk96d3BLNUxqazBkRGg2?=
 =?utf-8?B?a0plNXh0NWw1RFpCU2N6eVFPVVBlalA0YXl3OXQzVndJSys5LzN1ZzdaOTJE?=
 =?utf-8?B?L1Rxckt3aDZoSXo0NEZXc05WUU12WjRwbDNjVzZjSmhPeCtKOTYxYzZRZlRn?=
 =?utf-8?B?NXhGclladTI0T0pPOGhteHY1c2VkWDlBVW8rUndzemtUd21MUitMNUhvQnRP?=
 =?utf-8?B?dXdFMUlkMWZ3cnYvRFBCeGpKQnphRE12L3RBZXkwWUI5VHhkMUZLZHBsSWcv?=
 =?utf-8?B?ZGxwTjU0a2JkWEpSOGlGalZZQWZnWXZENm1LU2JxQUVXNWZNYUNIaWRXZW56?=
 =?utf-8?B?QVhnanFGc2kxalk0WUhVUGlqZVRkdWNJRzlIbS9pUnZQc3NYT1JWRTlDNlEy?=
 =?utf-8?B?SWhzM21jNEpma0lTT2x0Y1BWNU1WVXNnYlZuSE95K0tMS3ZCMHozUkZ4WVJv?=
 =?utf-8?B?aTRWU2p5eEhneVg5bHpBWnMzWjBnb1RYbUc3VnpCUGI2TkxqRHdzRlB0Uksz?=
 =?utf-8?B?YW9qdENxbGxUUk15NlQyWnUxVmt3aDZnU1ZXd2x2ZnpqSTFacmRDMFFKUVFy?=
 =?utf-8?B?dXNIeFNNanRYTzRROWJIL0VqVFQyZE1MK3BNaXozVEg3bktORGpvaHJNTkxD?=
 =?utf-8?B?OGhreVR4NTB3RUJjbDZyTEJMSGQ3N3UzRjF2MlpKTWJIaUdmVjFRejNVRmVz?=
 =?utf-8?B?VmtPeHBqc2YrZnhiRVJqUWdRSnQ4b2M1VE1CbXY1WXNqM29yWEpaWGd4U3Zm?=
 =?utf-8?B?U1V3MlFnUGtNcU9TZU9UcndoVFBKdzc3bGZiRllDVVhFbFE1KytNTFVHR2Rr?=
 =?utf-8?B?aFNtdnBINFR4aVJDVTQ1blQxbHRKVzhVSUozanhlaVZaRDR4VE1zNEx1eFhJ?=
 =?utf-8?B?YU50S0IwL3NKRzBsN01iSjRiZ2ZWRVNvbFlGaGlEMGI4SDdRenZnNnhUbkg5?=
 =?utf-8?B?UG5VTk9VUWJyVGQvYzU2bTEzY0l0SjVHN3RXMEJ3NGpvU1M1TW84dFNLYlds?=
 =?utf-8?B?aUJzeEQ5R29JZGk3WTdON2dENXRoOUxtd2hWSWNBVGZzdldOcEpzYUNpcDB3?=
 =?utf-8?B?K2dDY1Y4amlYRlMrK0pNS25XZVlSNjE2Qm1ET1NUNDZwVjAzY2dEZjhrWmtX?=
 =?utf-8?B?RGpGa3dRNmRVN05hQ3ZwRi9hQ2JyVTZmL2NySEcyTko0QmJNazByNFo0RkV5?=
 =?utf-8?B?a0l0Qy9aTzU3a3owWS91eGpnTE91WGRRSzZWMzlpR1lIUEx1TVBWNGdjYVdD?=
 =?utf-8?B?TGwrQURtcm0wNTROUWVieDQ3SWlGbUFFUktyZlhQMWplQngyVlNhVVAybjA1?=
 =?utf-8?B?OXJjOWpWMC81WUV2YWFiSmowbXZvZmJyM1lBRGRTUDZTUXZIdGxzUHJrY05L?=
 =?utf-8?B?SUh2eEE5UXFxb3ZISVFEbldCc05LMThwWGdweWtCcHdQZHlJTlV6MmlLdDl0?=
 =?utf-8?B?elJPUHppQmVka2dLRkVZbXRPUzVKMWlydVdUc1hPQXRjZktwOUJZN3E1a2Ez?=
 =?utf-8?Q?eZ6M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0c5329-2899-4d7e-7658-08dce72c56de
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 00:01:20.3442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msBD0TMU75ZuPbnSycCUJ+a2+PvF0CX6xNCinYXGmA9jWPl+C90BUP81PM4ApiUA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650

Hi Reinette,

On 10/4/2024 10:02 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 10/3/2024 9:17 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 10/3/24 5:51 PM, Moger, Babu wrote:
>>> Hi Reinette,
>>>
>>> On 10/2/2024 1:20 PM, Reinette Chatre wrote:
>>>> Hi Babu,
>>>>
>>>> On 9/27/24 9:22 AM, Moger, Babu wrote:
>>>>> Hi Reinitte,
>>>>>
>>>>> On 9/19/2024 12:45 PM, Reinette Chatre wrote:
>>>>>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>>>
>>>> ...
>>>>
>>>>>>> +}
>>>>>>> +
>>>>>>>     static int rdtgroup_mbm_assign_mode_show(struct 
>>>>>>> kernfs_open_file *of,
>>>>>>>                          struct seq_file *s, void *v)
>>>>>>>     {
>>>>>>> @@ -1793,12 +1802,48 @@ static int 
>>>>>>> mbm_local_bytes_config_show(struct kernfs_open_file *of,
>>>>>>>         return 0;
>>>>>>>     }
>>>>>>>     +static int resctrl_mbm_event_update_assign(struct 
>>>>>>> rdt_resource *r,
>>>>>>> +                       struct rdt_mon_domain *d, u32 evtid)
>>>>>>> +{
>>>>>>> +    struct rdt_mon_domain *dom;
>>>>>>> +    struct rdtgroup *rdtg;
>>>>>>> +    int ret = 0;
>>>>>>> +
>>>>>>> +    if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>>>>>>> +        return ret;
>>>>>>> +
>>>>>>> +    list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>>>>>>> +        struct rdtgroup *crg;
>>>>>>> +
>>>>>>> +        list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>>>>>>> +            if (d == dom && resctrl_mbm_event_assigned(rdtg, 
>>>>>>> dom, evtid)) {
>>>>>>> +                ret = rdtgroup_assign_cntr(r, rdtg, dom, evtid);
>>>>>>> +                if (ret)
>>>>>>> +                    goto out_done;
>>>>>>> +            }
>>>>>>> +        }
>>>>>>> +
>>>>>>> +        list_for_each_entry(crg, &rdtg->mon.crdtgrp_list, 
>>>>>>> mon.crdtgrp_list) {
>>>>>>> +            list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>>>>>>> +                if (d == dom && resctrl_mbm_event_assigned(crg, 
>>>>>>> dom, evtid)) {
>>>>>>> +                    ret = rdtgroup_assign_cntr(r, crg, dom, evtid);
>>>>>>> +                    if (ret)
>>>>>>> +                        goto out_done;
>>>>>>> +                }
>>>>>>> +            }
>>>>>>> +        }
>>>>>>> +    }
>>>>>>> +
>>>>>>> +out_done:
>>>>>>> +    return ret;
>>>>>>> +}
>>>>>>>       static void mbm_config_write_domain(struct rdt_resource *r,
>>>>>>>                         struct rdt_mon_domain *d, u32 evtid, u32 
>>>>>>> val)
>>>>>>>     {
>>>>>>>         struct mon_config_info mon_info = {0};
>>>>>>>         u32 config_val;
>>>>>>> +    int ret;
>>>>>>>           /*
>>>>>>>          * Check the current config value first. If both are the 
>>>>>>> same then
>>>>>>> @@ -1822,6 +1867,14 @@ static void mbm_config_write_domain(struct 
>>>>>>> rdt_resource *r,
>>>>>>>                       resctrl_arch_event_config_set,
>>>>>>>                       &mon_info, 1);
>>>>>>>     +    /*
>>>>>>> +     * Counter assignments needs to be updated to match the event
>>>>>>> +     * configuration.
>>>>>>> +     */
>>>>>>> +    ret = resctrl_mbm_event_update_assign(r, d, evtid);
>>>>>>> +    if (ret)
>>>>>>> +        rdt_last_cmd_puts("Assign failed, event will be 
>>>>>>> Unavailable\n");
>>>>>>> +
>>>>>>
>>>>>> This does not look right. This function _just_ returned from an 
>>>>>> IPI on appropriate CPU and then
>>>>>> starts flow to do _another_ IPI to run code that could have just 
>>>>>> been run during previous IPI.
>>>>>> The whole flow to call rdgroup_assign_cntr() also seems like an 
>>>>>> obfuscated way to call resctrl_arch_assign_cntr()
>>>>>> to just reconfigure the counter (not actually assign it).
>>>>>> Could it perhaps call some resctrl fs code via single IPI that in 
>>>>>> turn calls the appropriate arch code to set the new
>>>>>> mon event config and re-configures the counter?
>>>>>>
>>>>>
>>>>> I think we can simplify this. We dont have to go thru all the 
>>>>> rdtgroups to figure out if the counter is assigned or not.
>>>>>
>>>>> I can move the code inside mon_config_write() after the call 
>>>>> mbm_config_write_domain().
>>>>
>>>> mbm_config_write_domain() already does an IPI so if I understand 
>>>> correctly this will still
>>>> result in a second IPI that seems unnecessary to me. Why can the 
>>>> reconfigure not be done
>>>> with a single IPI?
>>>
>>> I think we can try updating the counter configuration in the same 
>>> IPI. Let me try that.
>>>
>>
>> Thank you very much.
>>
>>>>
>>>>>
>>>>> Using the domain bitmap we can figure out which of the counters are 
>>>>> assigned in the domain. I can use the hardware help to update the 
>>>>> assignment for each counter.  This has to be done via IPI.
>>>>> Something like this.
>>>>>
>>>>> static void rdtgroup_abmc_dom_cfg(void *info)
>>>>> {
>>>>>       union l3_qos_abmc_cfg *abmc_cfg = info;
>>>>>           u32 val = abmc_cfg->bw_type;
>>>>>
>>>>>           /* Get the counter configuration */
>>>>>       wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
>>>>>       rdmsrl(MGR_IA32_L3_QOS_ABMC_DSC, *abmc_cfg);
>>>>>
>>>>
>>>> This is not clear to me. I expected MSR_IA32_L3_QOS_ABMC_DSC
>>>> to return the bw_type that was just written to
>>>> MSR_IA32_L3_QOS_ABMC_CFG.
>>>>
>>>> It is also not clear to me how these registers can be
>>>> used without a valid counter ID. I seem to miss
>>>> the context of this call.
>>>
>>> Event configuration changes are domain specific. We have the domain 
>>> data structure and we have the bitmap(mbm_cntr_map) in 
>>> rdt_mon_domain. This bitmap tells us which of the counters in the 
>>> domain are configured. So, we can get the  counter id from this 
>>> bitmap. Using the counter id, we can query the hardware to get the 
>>> current configuration by this sequence.
>>>
>>> /* Get the counter configuration */
>>> for (i=0; i< r->mon.num_mbm_cntrs; i++) {
>>>   if (test_bit(i, d->mbm_cntr_map)) {
>>>     abmc_cfg->cntr_id = i;
>>>     abmc_cfg.split.cfg_en = 0;
>>>     wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
>>>
>>>     /* Reading L3_QOS_ABMC_DSC returns the configuration of the
>>>      * counter id specified in L3_QOS_ABMC_CFG.cntr_id with RMID(bw_src)
>>>      * and event configuration(bw_type)  Get the counter configuration
>>>      */
>>>     rdmsrl(MGR_IA32_L3_QOS_ABMC_DSC, *abmc_cfg);
>>>
>>
>> Apologies but I do still have the same question as before ... wouldn't
>> MSR_IA32_L3_QOS_ABMC_DSC return the value that was just written to
>> MSR_IA32_L3_QOS_ABMC_CFG? If so, the previous wrmsrl() would set the
>> counter's bw_type to what is set in *abmc_cfg provided as parameter. It
>> thus still seems unclear why reading it back is necessary.
> 
> Yes. It is not clear in the spec.
> 
> QOS_ABMC_DSC is read-only MSR and used only to get the configured 
> counter id information.
> 
> The configuration is only updated when QOS_ABMC_CFG.cfg_en = 1.
> 
> When you write QOS_ABMC_CFG with cntr_id = n, abmc_cfg.split.cfg_en = 0 
> and reading the QOS_ABMC_DSC back will return the configuration of 
> cntr_id. Note that when abmc_cfg.split.cfg_en = 0, it will not change 
> the counter id configuration. when you read QOS_ABMC_DSC back here, we 
> will get bw_type (event config), bw_src (RMID) etc.
> 
> union l3_qos_abmc_cfg {
>      struct {
>          unsigned long bw_type  :32,
>                    bw_src   :12,
>                    reserved1: 3,
>                    is_clos  : 1,
>                    cntr_id  : 5,
>                    reserved : 9,
>                    cntr_en  : 1,
>                    cfg_en   : 1;
>      } split;
>      unsigned long full;
> };
> 
> We need to update bw_tyoe (event config). When we write QOS_ABMC_CFG 
> back with abmc_cfg.split.cfg_en = 1, the configuration will be updated.
> 
> if (abmc_cfg->bw_type != val) {
>         abmc_cfg->bw_type = val;
>         abmc_cfg.split.cfg_en = 1;
>         wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
>     }
> 
> I will send you the code later today.
> 

Found out that we cannot do the way we disussed above.
Event update can be either local event or total event.
We need to update the counters that are only assigned to event 
type(total or local). That information is not avilable in the domain or 
by quering the hardware. Need to search in resctrl groups for that 
information.

Updated the patch for that. All the update is done in the same IPI.
Will send the series later this week.

Thanks
Babu





