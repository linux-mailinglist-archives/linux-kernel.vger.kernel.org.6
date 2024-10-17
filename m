Return-Path: <linux-kernel+bounces-370718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5849A3130
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6068D1C21BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A05F1F429A;
	Thu, 17 Oct 2024 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y61t3V00"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06F31D5CE0;
	Thu, 17 Oct 2024 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729206680; cv=fail; b=lM59BvPqgtlvU28+vuvJgrPFozh997mMg35mAoyzbWZDvHM341QCY5xrrUPP8U4xOA+m9EIzQ5FsErUwUFQtoK5ys6GgUPtUL+kqP93lnT4+6aMQreac5mTPCok3svVlACppNpm9Mqdn43HqrCBmeELQyI2Qakw8wwpzw+fbIUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729206680; c=relaxed/simple;
	bh=aR57NsBw/J1rV1QDIekWyQvvAPMrsofthjdgao5ks84=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BzW9rMvyMSaZ3ZiRNW69f/uEXrw82vi/Ke3Snw5dSpR6gtpTCUcPjem6o/8QkRQmpaqLB1+Hvu7gSreJSKTF5h0eEJOSqJr+vSmMsn+FI2HUceJr1TmbuALbLLyo3GcPklv21ncs4kHl+uHT2o2Vqaie2gYKfFI/rfQRlCejA1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y61t3V00; arc=fail smtp.client-ip=40.107.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjZS0sCaEbB9bpMN6FOYVZDaHV9A+W/ihgR5u5xbJlR3xvLK4UkcQQ5vHHc2xL6BM0RiELv44dO8Y+Q5ttZXX91kFQ5zbl5WS9imfIIKUHsGPKKrvYf1xPNoplG79jdlzVSNt9TIJ4Dg60pRmhcVCTV/33VgqMVrwokVvEAdUcrdo3IqU/ieXW37Xhg37j81UJyB2QNwX0emtEgR4lrk1Tq2aC/Z3tXXCrzOZKhRQg0uzD0vY5IdVxVbqd7I1lk9si5alrMxLNBGyqtay3x5JciwljrJ1/aj9+vsPyU3WF308Nf7bJKWUeRJKIPk0Oi7dOOTae+9SQNX5XyYSvo4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/A22wy9ylhU+LagwrBDGqCiRbZlBA78Mh/VRhINing=;
 b=SpKGa6d6oudgP85x0qsv3sC/7YxOPGmHM+IIWQk7y6RPcTc1c5M9Uo9ZemaTbOajylHxgLRa/yaYilJj38UolwqH0q2sTdO6hNLBNN3CSMwOIMz/guXLsNMnIDz5CmaNFRo7wxcr9QlZyZQl2c6kYCTAGfXENzsNtHMX1mgGUW4H+Qyu+hK0ZuUFCfn1w+Kcv2C5SLLCh7sZP9mY5XBqyXN+X17QxzNZMv3gS2Vn8ckTgvhcGEoa74epMp1zKTZCyYX7BpychPwdFX6j9qyjxjbuJic7/P/YM7mwGIpy3Fm2rJpPP9KhMrkeZDLCXMN2oo0k1tmSKo6e2vcHvANImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/A22wy9ylhU+LagwrBDGqCiRbZlBA78Mh/VRhINing=;
 b=Y61t3V005QzXQiceMhilu2fu8d7uZOhnFoqyIoYf7AoNktsJ9dBwHuRADM5mi5syPp45h6FwCfCwnVYDv4NnqNUirXqBw8rXzt0G6lVZ8GRVwwBR25J4ZJYhjNK5zy14LjRoGBXkoIimD4phETYc5h51CX3Wrp4nrzCNYxCvDSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 23:11:15 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 23:11:15 +0000
Message-ID: <3172b5fe-5394-92ca-4d4a-d194b84e8364@amd.com>
Date: Thu, 17 Oct 2024 18:11:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 18/25] x86/resctrl: Add the interface to unassign a MBM
 counter
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <a06e3f9b975bc3743ed8b8df04b6b52229d62bd9.1728495588.git.babu.moger@amd.com>
 <a74315f3-9250-4e52-823b-dfadf87a6142@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <a74315f3-9250-4e52-823b-dfadf87a6142@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::6) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2fc001-7f1e-40ae-1f52-08dcef010013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFdCUmg3L3htQ2NJaGQ5VFZvcTNsV3BUS09vSWFCOGVwSmJidFBJMUQ4WnM1?=
 =?utf-8?B?UHdoRy80OUVzOEhtbXVoOVo1aDdoNjB4WVd6SWdURGdNSGgzUjg4V09iWjNa?=
 =?utf-8?B?NGJGeVBBdGdoMzB5SkdtN1NLTnJOdkdubDZXSG1QMjg1L29HWVRmaFR4SEcv?=
 =?utf-8?B?T1JIYm81WDVLa0hRbmVvdVZ0cWhqdCtqVUpVM2NlaTdzbkVnNkRzVURnRm5i?=
 =?utf-8?B?NzN5MTN3eHk3RVFjOUZFQnQ3Um9aUUtnaGN4bHhRRlJJWjA3NEdFZ3JRcjBa?=
 =?utf-8?B?d0xVQUl4QkM2K21Ncjg4WHBkSVFpcWQwK1lpYlVPVDIyNStiTk9iclY2U3M4?=
 =?utf-8?B?VTQ4TjRrWmgrWUY4SDU0QXpnNTh3OUdydmpGckhNYnFjSEhqMi92end2NVJv?=
 =?utf-8?B?SjROWWpqbHpPNDlsUXUxdU1LWWRGTCtaVCttdFJ0akE2dnhZSFpKbkNicVoz?=
 =?utf-8?B?cVVlUjhFQW40b1dQOTUwV3ZHaXQ4Y1puUTNKTHRzbG5EOVNxM3drM29FQXBs?=
 =?utf-8?B?Y2UyRXNBMjAyclZlL28vdUQwZlBaOWVFZEZlNzdrMkJUa1p6YXUvcGxNZGd2?=
 =?utf-8?B?a0ZjZjhCaVBicVNKQ3RrbWNkd3ArTnI5ZVpWaWhpdzNIWk1hZnE3bWFNS3pu?=
 =?utf-8?B?M1hQQ09FcnJTYi9jcjd2dXlya3lqUVdNeVhPOVJVcEk3YVhHcURWTEllSkpS?=
 =?utf-8?B?NXpFZ0ZPay9wUytDN0tWb2FveGx5WVo5REJIRmZIbXIrdzRrNkVhRmMvcFBE?=
 =?utf-8?B?Wlg3aWFERjJFTkJWazFPdi9TekZSazcvV3ljSmZlQjQyS1BkK0hyOWo0M2xx?=
 =?utf-8?B?Z0hWQlc2aXp3UTdySHJrTElWTTVzUzBoaE9ySHhVNFpZTVV6U0V1VTNqT1JF?=
 =?utf-8?B?Q2JrM0dqUFErRzJTWWtESnZzdFJyMGVXTmE1MGV6L0U4T0J5TXkzZVlNZGNm?=
 =?utf-8?B?VmlwZFpBRjdhdXB3ZURhcGllV3A2QVJMaU0xbXRjcW5uRGtKTmVyYUM4d0VQ?=
 =?utf-8?B?bGJUREVYT2hrcVdaNWZUQ0FzZ0VsQzgvdk5vbnAvNVozUmJMc2JaejhveHB3?=
 =?utf-8?B?RlFWWHZDVzFTMzRTTThWMDFFUW0wRzl0REZlZE9EVGVadS9zbEhPYnVtVGFq?=
 =?utf-8?B?VjRBUCtkZ2FKdGs0d2J6VXZCMUl4K2ZxRG85aWxoWUNaYWpUcTFuZktqNits?=
 =?utf-8?B?eXlISGdtTk00RXFwWHpOR2FuZmk3a0wyRGh4bW8xNWxESnc3aVdIUncwUkg2?=
 =?utf-8?B?aFpKR1FHNytqZk5JZUdiV2xqSmR3YVZQSE9yY29tOW5HSHY0eWl1djBuM2pj?=
 =?utf-8?B?MDU5VTFnYXdDSXJnMnV0UVkyRjVRdXVEMnFpOUowQU10OXI0MDRscVQ3SXdN?=
 =?utf-8?B?VDBtamx5eDRBSXZjaHBBZkhoZVp3dFp5ODZmU2tSbGRpTVZPOWRackNGWXYv?=
 =?utf-8?B?TnZ3S2luZlE4MG1Pa00vU1JmV3VLQVYzMjZwN1Q2QklSTUdybnJiNHNDeHpa?=
 =?utf-8?B?TlQxWjNYU3J6Zk9iaW5rOWVUUEd6WkY5T1lvODduWEVDQ0xxWWFOdUZSWERy?=
 =?utf-8?B?RHM1NnpCZUYrTld0VWdtOExpOHgrcmNQZ3VXR1I1YVQyMnlPK1hmR2FESCt1?=
 =?utf-8?B?N0hWUnRmSk9vSlNvdVlSR1B4MEdzQnVQNXhYTmFJei9KQ3NnbitvNUxEcWYz?=
 =?utf-8?B?T2pZU3VkTllET3dCK2ROa00xMHhud3laTWpLMyt1MVlncEVWOVFsNUs5MEdr?=
 =?utf-8?Q?/BfCdSBGfPxA5k73Vuf31Qam6x8B475RlYATjRJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEtZbE5EcjJKdWgzbytWeHNIN2I4bTI3aEp6OVo4SmYyRXhlbXZSZTZZYVIr?=
 =?utf-8?B?d0Z0SGhueWRkbUVJZ0RrT050Nmk1M3FJRlpPUnprUHZtMTZXNXY1bGlORVVP?=
 =?utf-8?B?bHg2Zk5PMlJ2OWIzWXp4akh6aGk1OUM2emxxK0lLV2cyN2RVWWZuSzAzTnVG?=
 =?utf-8?B?a04vZVNpUVJKaEtoMFhaOTZ4VHFoN1NtNG4zMm80NUFGRTExTDBlMW1pQkRx?=
 =?utf-8?B?YW5helVXaEYvMHBVNTkwVjlMTmR1OXNJTG5velFWeHpvVFAvQmsyaDRPazVy?=
 =?utf-8?B?RmVVV21MaEZCNmh1VUxBVlVUVWRCdXhXQzBPb0I4dDZnbnVSZGx2YTIrL0VF?=
 =?utf-8?B?STh6QTUvbkhyQ3MrWkErNDdROWRCVjdxY3l3dDBSUE5waEZLdUlaQ0Q2NVJU?=
 =?utf-8?B?aHhQVGpSTFdBZkNWSzZ5Qk5WQkphMi9iWCt1WTBsSlEwb3hyY3ViWkovSG5I?=
 =?utf-8?B?dHgrYnAxQWVNcTU3NFVPL0c1QUdEVjR4TVR2bXEyTUlxRy82aVNad2FqTDJh?=
 =?utf-8?B?RHRxVHhMME85a2FlR1FaQWNOT3JOaXpqOUtGb21PQ2EybGs3bEZJZ2prL2ly?=
 =?utf-8?B?VFZDdkZ2Q1RqTm5MeE5sbUpqbFc4bTFRWTQ1eXFURzFqTU4yKzJqRnlDUE9T?=
 =?utf-8?B?aHRlRW9FUWhyOUxtWXpXSjJPWkt0MDd2TzQ5cExxOFBUQlMzcHB2UnBzZ3hS?=
 =?utf-8?B?d0hZOU51eEp4OWFnTWk2aVlmYk5TZWZ1VkZKdEVvbHhuQnRBR0xKajNMaVV1?=
 =?utf-8?B?V21HRExEeWNaZmdNOExQeWphcjJoUFg1UXcrNTg5dm9sTjR1Yk1TNkNVTDBz?=
 =?utf-8?B?elViWS9kM04vY3VDYS9tTjBUQjBjSnBiRmtjRUhvS1owdDA3bFBBV0JBdXRY?=
 =?utf-8?B?dmFDWi9aWGF4cUdEWTJKMEhXYWR0dnZIQkVrdjBrY1NBdEo3dUQwcnFXVWg1?=
 =?utf-8?B?cjIrc2lTYzBhc0QyMFVxVHkzV0tycFBBRUQ3L09XRmttOTA0eE9kbUNFQVlo?=
 =?utf-8?B?VTl0YU5wcWZ6MUI4WG1pT2JNZWdLUUpzNWNUbC9NSWdGTUhpUENLTXcvaXRk?=
 =?utf-8?B?TDMyemdqTG9Vd2ZZWlFmMjJrWmlUQlFTdTdJR2pzTzZDd0pTZWlKbSswUzIv?=
 =?utf-8?B?U2c5VUZLbEJCd0FwRlcvU1N3RnY4YVd4NXhNYkx2eTZIMm5tZWxXeTZzRzFN?=
 =?utf-8?B?WUd2cWV3akY5WW1pcWpPeGdpaG5SZEpZL2R6MllyeWRlVG5DNVovOFAwMkVU?=
 =?utf-8?B?c3pDRndYbWdCbEhXQkJFUjBrMUdxSUtTYWVnTHFMMzQvL0RhNll6bVlsella?=
 =?utf-8?B?TkM2Z0o1Ty9nQ0tlT1pDZkJKZ2tzaE1tRGpVbGY1cUY2NDFMa2F2QXFjSWlE?=
 =?utf-8?B?V3ZFU0hOU1dTSkRGUEtzQVQvblhmd1VvUHJYYzl5dHJ5SEtJdVBBeiticUl6?=
 =?utf-8?B?VW1ZcTFGT0U4TDhiK05zZ3BWc1F2RmFNcWVhbHF5R3BDL2ZzSkpBbmo1d1Bq?=
 =?utf-8?B?YnEyTENRUGcrelVtQ3lGajZzczhHUi84aXJJOGdVQ0FNS3M1d0I5T2tEa2t0?=
 =?utf-8?B?Y0ZGcTZNK3hnOStjeXFIMlM0Yjd0NEVUVjNhU054K3pxNnR0c3E5SzM4SnJn?=
 =?utf-8?B?QURraXVibko5cjA4WW5Ta2lVeFM1YUtTUjNoS3FvMm9kSGFWMW9Ub3Y2dUo5?=
 =?utf-8?B?d1hKaTFQUjJ2VkpmVCtNdDZSWFpaY1hxZkdxdGNMNE9FdWwvNmZNaVBqTWkx?=
 =?utf-8?B?K2xqYi9RWE12SVJCTnR0VkcxUE82QUkrWlBtOUlvdGZ1V3FIOFNDN3ZnUzJl?=
 =?utf-8?B?OUN3SEpWR3hqUi9UMmdxZTltSW5lWGsxMGJxcHp3bkxGMVdLZlFNSXl0OWE5?=
 =?utf-8?B?dmVxbmZiNjRqQTVVa3lNVHhCOW93dXg5L0ZrNGc3eW1ES1hBZTQrUGVRYTB2?=
 =?utf-8?B?UTVtRjBKaExoa3BMdFdiN1RxQ0QwOUV1NW1IaHJxYkk3VHo0REFGeENaUE1v?=
 =?utf-8?B?S3lIcVlSa3ZUUG5EVFlrQkQxbTBMQjRQRzBYOHZGZXRvTFQ2R2d6U1BJZVRs?=
 =?utf-8?B?QXp5UkdJblFRQ3NvcFBNQ2MvV0hnS1V4RjBDSE14VGI0UDA2NDlER0hIOW5T?=
 =?utf-8?Q?VIWg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2fc001-7f1e-40ae-1f52-08dcef010013
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 23:11:15.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMYT4FCIHhb351TmXJYQG9ilJQ7dCV8pKKce3ZSMnjCqWs7/b6XENWqa8b95zocu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524

Hi Reinette,

On 10/15/2024 10:29 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/24 10:39 AM, Babu Moger wrote:
>> The mbm_cntr_assign mode provides a limited number of hardware counters
>> that can be assigned to an RMID-event pair to monitor bandwidth while
>> assigned. If all counters are in use, the kernel will show an error
>> message: "Out of MBM assignable counters" when a new assignment is
>> requested. To make space for a new assignment, users must unassign an
>> already assigned counter.
>>
>> Introduce an interface that allows for the unassignment of counter IDs
>> from both the group and the domain. Additionally, ensure that the global
>> counter is released if it is no longer assigned to any domains.
> 
> Needs imperative tone ... "Release the global counter ..."

sure.

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> ...
> 
>> ---
>>   arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 56 ++++++++++++++++++++++++++
>>   2 files changed, 58 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 900e18aea2c4..6f388d20fb22 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -717,6 +717,8 @@ int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>   			     u32 cntr_id, bool assign);
>>   int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>>   			       struct rdt_mon_domain *d, enum resctrl_event_id evtid);
>> +int rdtgroup_unassign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>> +				 struct rdt_mon_domain *d, enum resctrl_event_id evtid);
>>   void rdt_staged_configs_clear(void);
>>   bool closid_allocated(unsigned int closid);
>>   int resctrl_find_cleanest_closid(void);
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index e4f628e6fe65..791258adcbda 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1945,6 +1945,62 @@ int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>>   	return ret;
>>   }
>>   
>> +static bool mbm_cntr_assigned_to_domain(struct rdt_resource *r, u32 cntr_id)
>> +{
>> +	struct rdt_mon_domain *d;
>> +
>> +	list_for_each_entry(d, &r->mon_domains, hdr.list)
>> +		if (test_bit(cntr_id, d->mbm_cntr_map))
>> +			return 1;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Unassign a hardware counter from the domain and the group.
> 
> Not sure ... maybe "Unassign a hardware counter associated with @evtid from
> the domain and the group."?

ok.

> 
>> + * Counter will be unassigned in all the domains if rdt_mon_domain is NULL
> 
> Please use imperative tone: "Unassign the counter from all the domains ...."

ok.

> 
>> + * else the counter will be assigned to specific domain.
> 
> copy&paste error?
> "assigned to specific domain" -> "unassign from specific domain"?

ok.

> 
>> + * Global counter will be freed once it is unassigned from all the domains.
> 
> Needs imperative tone.
> 
>> + */
>> +int rdtgroup_unassign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>> +				 struct rdt_mon_domain *d, enum resctrl_event_id evtid)
>> +{
>> +	int index = MBM_EVENT_ARRAY_INDEX(evtid);
>> +	int cntr_id = rdtgrp->mon.cntr_id[index];
>> +	int ret;
>> +
>> +	/* Return early if the counter is unassigned already */
>> +	if (cntr_id == MON_CNTR_UNSET)
>> +		return 0;
>> +
>> +	if (!d) {
>> +		list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +			ret = resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
>> +						       rdtgrp->closid, cntr_id, false);
>> +			if (ret)
>> +				goto out_done_unassign;
>> +
>> +			clear_bit(cntr_id, d->mbm_cntr_map);
>> +		}
>> +	} else {
>> +		ret = resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
>> +					       rdtgrp->closid, cntr_id, false);
>> +		if (ret)
>> +			goto out_done_unassign;
>> +
>> +		clear_bit(cntr_id, d->mbm_cntr_map);
> 
> Please see comment to previous patch about the duplicate snippets. Snippets can be
> replaced with single function that also resets architectural state.

Sure.

will combine rdtgroup_assign_cntr_event() and
rdtgroup_unassign_cntr_event().

I need to rename the function. How about resctrl_configure_cntr_event()?


> 
>> +	}
>> +
>> +	/* Update the counter bitmap */
> 
> What is the update?

Clear the counter bitmap.

> 
>> +	if (!mbm_cntr_assigned_to_domain(r, cntr_id)) {
>> +		mbm_cntr_free(r, cntr_id);
>> +		rdtgrp->mon.cntr_id[index] = MON_CNTR_UNSET;
>> +	}
>> +
>> +out_done_unassign:
>> +	return ret;
>> +}
>> +
>>   /* rdtgroup information files for one cache resource. */
>>   static struct rftype res_common_files[] = {
>>   	{
> 
> 
> Reinette
> 

-- 
- Babu Moger

