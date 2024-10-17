Return-Path: <linux-kernel+bounces-370450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F059A2CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6111F224B4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB24219C86;
	Thu, 17 Oct 2024 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zbeYCxJ0"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5E4219CBF;
	Thu, 17 Oct 2024 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191173; cv=fail; b=LjV72I7ChJALhOV+t7XyUMbSD90VTQSKLNXssX1IkDZOMqgnqV9ak3ykcteTGtJci9Qnj7aLiGjF+CO+yzStlVCatZOc+OGokFWQbV6crgVIglfgStjo6eDMdiTQH0uaVY9Y6UvNR6coIr737yjfUIQzO12rrjBnFtGg1wUJvo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191173; c=relaxed/simple;
	bh=KDIGXm3Nm6Sh8+8LeC3iRry5NWMvrJ61QZELeV6Es7U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=noUlRCNWWnTBkBIZmBXbztR3EPaeBZDULBg7TtKXQXBqhtJiZmCSZ61C/mX1spsW9lUUxRo4WT70ZI6JicEbNNDYJfCKleE3NoSrxCt7f5Wr9wkhYr7Lj7g7pWtsuNFbVgNTjGmdIsPcpkfb16v4P+SC7OKg7geMiHN+QaWyZus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zbeYCxJ0; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMUfipsUuYkSOSdEiEpo9P9852iPI3loG6JEa0O585JRBEj2Z1ZBVgXiWnF+Vv4RIj8O6Z9MfQseFBwvI1HBl5s+MYo+SeCrgntAUQYlHDqtcOHyM9bIDHcBwrrFmaiDz3AlkHavP7iK2wGFmAcQHmKjriVlboVv7Lk+hL+f6Xi8oXj2gI5c53OQwZG/IwMcFFLhn/xXMEniGWIFVlcQszg+wAv7SMhGSBUtf1a8yJ24eax5FPnDXaJRwpOmloBsQOUMDyBW7vODodhW1TcKy5dYgR5gfaGZfpUCJmEICZneh2Ru/ZQV0tFrn9jaoEnMqTD4QAJxHgYKVQJp87zY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTtSFUatlgnSEG9ZGKPO9TdCyTJF2Vh/KAnTZNl1dmE=;
 b=PwOT9IwuJIJoeKvmeEBxJXyjy7e6niQmO+kAZqGOSHmy7ozkSkAaWTDMs1R1ip26Ox+byr27TGhVQ44f1AKFfCHv+Cyj0jQJnnGvApkJfKD2jyBiM40JI3eTUm2rNPYY7+IWsnLfRFUAPYVhNM8FsPNX3Zd3Qya04KlkZ29F3OcJ7Q1Bjs3yoDXNN0CNBZzetrTAFyzPAMjcFruDotD1bJ16x8sWzOBZDKrEVtYIW7o88a9G60FTlz12yqeYld91HjMoiRNj2W+emQiKlurrYVH6GJdknNDivZVApu6xLqKqmn5TXCkLde20NRkDpECzHWzLUzJARsNnj3tN0LaQoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTtSFUatlgnSEG9ZGKPO9TdCyTJF2Vh/KAnTZNl1dmE=;
 b=zbeYCxJ040XXE/KTZTtBL+i/ZrUcWWjTmsju9r61uB8oH59VPUk084aC/5Lu45p+kD+tRFJKS+nh5At699cIKKfa7T3fL5Ja6+tJAR4uwZ+KW2QvIosAxuNDLNYFVt4Sk3bxKWUuYYx5ggfXelWtMHJ7ZGIm32q0lh+MUx6ukCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.28; Thu, 17 Oct
 2024 18:52:44 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 18:52:44 +0000
Message-ID: <c81c9b9d-9897-4f97-9d41-37a9fbfcfd7e@amd.com>
Date: Thu, 17 Oct 2024 13:52:40 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 14/25] x86/resctrl: Add data structures and definitions
 for ABMC assignment
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1728495588.git.babu.moger@amd.com>
 <94cfd19bf9b16570b07649e1058b4ee55ac8c102.1728495588.git.babu.moger@amd.com>
 <6af4b2f8-c6f4-4195-8c5e-d2efe0384521@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <6af4b2f8-c6f4-4195-8c5e-d2efe0384521@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0204.namprd04.prod.outlook.com
 (2603:10b6:806:126::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: b83340e2-694c-41eb-f3de-08dceedce2c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHY5QURwdU1maDR6NHFqeURTS2Z6ZFBIQmhTc3NTY1g4bjY2Wm9LelNuRlg1?=
 =?utf-8?B?VHcvaW80UlVoakhOdkk1QWI2V1hJVFNXaVpDTFZweVdxTHdheU81dEVaN2xD?=
 =?utf-8?B?MGdjUm8raCtGRSsvM0JnejNpQUNVbUl1UHpEcTJ6dXA0T1YxK2dhSXBmdFZk?=
 =?utf-8?B?dVp5enZrUGIvdU1ONHBwUlYyc1cwY0I0M3o2OWwyQkVnTUo3eGxNMFh0c1hu?=
 =?utf-8?B?SFFIMmdRYlZ6SGd5SCtmc2pxM0FsODNkWk1EVVlSblY5NUFjbUxKTVhIL3FG?=
 =?utf-8?B?VkQ1NUlyTTdVVHhXQ1h3QS95VC85cW5Uc3V4T3BrdW9hTlpDZlc0VHlZM1lH?=
 =?utf-8?B?cVRpUHQ4Tno2QzRKODh4aWZIcHA0M3RXKytXbTNmYUxoendBOURhekIyUWlx?=
 =?utf-8?B?U2U2TEpUYjYwVU0rOVFLNlFBam8ybFRKZE9RSWdpOU1zL3JsaG4zaVF6R3RC?=
 =?utf-8?B?WEhPUk5LdDVCa3hUOHNiR0x4SkU3SnJwYU5EQlV4VnkwU1N3Q0xLZnNXd21N?=
 =?utf-8?B?eVFrQmdNWEdlVDhzeWUrR1RiN2lYOFJrWDRDejI0azlKbk0zQW4zU01QNDIz?=
 =?utf-8?B?akNpWlM0bjFGTkJPTGFROWRwckphU1RVejlmWlRXWlJRR3F4TFY4ai8wN04v?=
 =?utf-8?B?VTFFUGRTTDdVVUJaVEpUa1NreTJ0bGZVditTQ1k5a0ZCdEwvUU15ZWtNUTBp?=
 =?utf-8?B?TnpDcDhPcFpvd1FLZGw2a2hnaloxbTY4RElmTllIUWpjK2x6Ujl0ZjlyQVRN?=
 =?utf-8?B?b3V1bDVYUDgzMG5rK0NtcXJKS2dZRGIzeDV6dmxPRHVGcTF2RVZvVFN6Vk5O?=
 =?utf-8?B?aDVYK2hEOCtPTXJPZFNyWVJVVFRQQ0tvNElUemYxMi9oR2E3RytjVk1Jc0xk?=
 =?utf-8?B?MzBpU1lnQUFiZDNpbW9HNEEyWWl5VVFUbkNoNlVRSkUvcHY5a2crNEZQL3Z1?=
 =?utf-8?B?Nitzck90UW1qZFA4UkxYMFNMc2dqWjBNT3VHa2s2bHJ4ZWZtKytSd0tiV3g2?=
 =?utf-8?B?ZVFaL3JpWVp3MnZhRHhGZWZwRHBYZFFzRFVQbklWblhZN25IQThjMWRoeVhN?=
 =?utf-8?B?VTZJQkdVNDBVczkzeDdHUEtZZ0pKRU95SXd5dkxhVENwY2NsQWpvYzZWcllT?=
 =?utf-8?B?bldFTFJCZndSQ3psT2NmZDFMNDFPclJGMEZyYlBuK296MlNrOWNHTFZaMWl0?=
 =?utf-8?B?c1RmRnVST2JxWEpEc2w1ZEVVODNYY0NoM3lXQWdLWUFWdmpWSlBDTmt3amI4?=
 =?utf-8?B?dk01Zk85blJwV0d5SHNIMnJYMVFXUWc0NlFidGxaR3l3S3crdS9RcUE1RUZs?=
 =?utf-8?B?SXUrSTFWUGk3ZERGTFQ1RkFNZ2NVamJuZkswY04yY0E0YXRhTmt3Ky8ra2tH?=
 =?utf-8?B?aU82N0hweE5aMkpCTnJyNVVFNHJ2OHpDUU1tZHdWdzlHMVN6eS9xcjdLQTNq?=
 =?utf-8?B?SHZ3dW5DY0xlVXRialMraGF0SjByczBxWjJqRGZJd1pobnhWUVBQWEtpNjUx?=
 =?utf-8?B?NmtMbjZhTjkwYmgwbThNa1NORXQvV0c1dFkzckdoLzd1bUpjTlN6R2U0M3pz?=
 =?utf-8?B?NG5pZGl6ODU0M0t4VVpFQ21uZkpmMDJCeGwxcitybFUvams1ZWowUjJMZjZY?=
 =?utf-8?B?eFU0RCtwKzdYNzl1MmZJTy9BYjU4OXpuV09QMENXQmNrT0c3c0xFUW1VN1pN?=
 =?utf-8?B?RzNDOFZKZ3JDR0hoV2pSRFlGYmtLTUdpamlXeGZJemUzY1ViVy9laitxb1RI?=
 =?utf-8?Q?ybhvb+ka4CglTR3I4hjqayU7lpZV3hyViNYE2Wc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFdWYXJpSmovaXF6SzgwN2x2cUxWNitFZDlRdnM4WjhzbjFPaWVISjFrLzRE?=
 =?utf-8?B?VUtZWU1FZ3hMaFRQV3k0dkFOSjhhVzlFWDVZUGxGRUY5aXo2SitQSFpOSnRK?=
 =?utf-8?B?ZHQ1SXh6czdJNjJvSVNlMzkycnkya21QR1Vpb2dSVUx0RFZBL2Z0RDNqOE9E?=
 =?utf-8?B?cW95RUR0MXBvaTI2OW9tWmdlTWF6V0g0aE1nSVZ5NlR1SlQ2elhZSXJPekM5?=
 =?utf-8?B?Z3YwM2NqYlh4S2Q3UDZlNWZRSE9YQU5FYzlHbUtnUjJLNTN0SXo2SnRKWDdh?=
 =?utf-8?B?YjMyczVIR0p1MENWYUt4OFRSdUZ0ZDJiQnVBWFkwWGlKL2ExTE9aNDFyRSs0?=
 =?utf-8?B?RHJaeHMwTTI4QUIwb2txR0xiNXkwNnovWTdKdWFkU2FiWHE0ZUFPTkl0cnR6?=
 =?utf-8?B?dzNRZVArNjc2amMwVDdHNWp1bVRzZzVVcFJKK0ZjSTZKd0JMR1FJWHovVkNi?=
 =?utf-8?B?K0g2ZG9ZNEptTGswMDF4ZU9pVGs3b1hWK0pBYkZBRnBKdTZMUTFFS0ZaK3VO?=
 =?utf-8?B?TlpYVDAxMWhiRG1sdllmaEEvSDI2ZXBMdlRZYzlDbVBpOVpucmxGbHkvSWdZ?=
 =?utf-8?B?bWdjQnVnR0w1bHoxNUZpUG53eFZpRk5xV25iQVBVUUVMOXVzMDY5byszck5W?=
 =?utf-8?B?d2xGR2pLRzhYcURCQ0EzRTVkVkNFVWJwaHJ4REYyZ0lIVjJtN3IzVUlIVyts?=
 =?utf-8?B?aXNCdXp2eXh3eUtZQ0xHV1ZNdHV5b0E1aDh0dHA0YlZoYmEwM2tkRGRIQjha?=
 =?utf-8?B?MGRYSzZXM3Nib2M4M3Qwd0pmbWJ2N09pWkdqZUk0MXhBanhCbFgvekh1OWtz?=
 =?utf-8?B?M1lYdUlzRjc0RmVpOENYZWhnYTlOdXpjMlRJelZRVzg0bEM5c01NUDB3NTRS?=
 =?utf-8?B?N1JXZVc4SHBxcTNVK0NGeUU1L0tyNDFmbTFhbWJLUExBSUV4cVdiQU9LTzg3?=
 =?utf-8?B?QVREbDRvMi9oZzZJQUVZSHFTYzFpVjNMcmtTZSs3ZkF2Z3VLdlZDc0g5VGhH?=
 =?utf-8?B?eTFjdGJmeHUrVGlIUkpaekVwL1MrSU96K1M5ZmMvUVlWU0VSZytQazhQWjIx?=
 =?utf-8?B?UTFJY1h4cnBtY2o0eDJFRlN5cDNFbDdOWmJOR3F1TGU0NmwzclhqK2JnS2tv?=
 =?utf-8?B?MTk3Sk11eWNQdlhCZWFDeWdGdkxRbHBVdXA1RHBMdStKRVF1SExKZnZxQUtC?=
 =?utf-8?B?S1lsUDZaT3hJMVAzWlBOSFh4MVdVcFlLZXBMRzhCL0Y5bjJDbWtLUHNPR1Zz?=
 =?utf-8?B?eVFBd1V2c2NHekxqbWNvcVhtQmFCanFzd3c5TGxpR2kzbEg1WUszMW1ZdU0y?=
 =?utf-8?B?WkF3YThyaDlUSmhZMGUvS2FxUFFwODNEVnEra1REK3I1UFMrZ21yUUNsS0NY?=
 =?utf-8?B?b2NmcytDS3R3YTB5Y2dMVWVnWGxDTTZ1YndOa0dOTUtNSlo2UElVOFVaMzRW?=
 =?utf-8?B?Y3FKNFJRaERvSmNoNlFldTVFeEordThKR0JndjBaZnRLZ3F6WnlnMSt6TkR2?=
 =?utf-8?B?R2hjS1pXbTIxNG14NHppZytjb2FTczFXUjNzMFhGOFRtcGhIeDJDM3A2enE0?=
 =?utf-8?B?YThUb0ZUNFZUQXY1VFcxVDE1TC9MTFZTdDhWb05VeHJ3cnVrUHI1NWRPSWVN?=
 =?utf-8?B?NnNRYnZEN21DaXU3ai83bm81OFJwbzZORDRJYzl4YW94NEFNeGQyQ21MVlpp?=
 =?utf-8?B?RW0ybThDa0hNRWd3R3JSZGdPcUZOQ2UveE1EZ2xFRCtObkxjLzh4Mmt4UDNi?=
 =?utf-8?B?YmJZU2hoSGdLUGN5VlNhOTM5ZFBqb3BQbGhxYmhxUE1tTEVZUm9UK21NWnhB?=
 =?utf-8?B?bnVKRmpRaUxvYnJ5Q2grK3RyMTRxS3FVLzFKMXpLdU5LT3p5YytuMThFZC9J?=
 =?utf-8?B?VStsaVJNOWg1dEwxS1hwanFMaEdQblpoRlRtNVNqOFhvN2tkNVJmWEh1bFFI?=
 =?utf-8?B?VmczL2xDK203eTlzcTdwNFJBYkdDWDIxdUcwY2JjMXpVOTRjNFQwVGxBdGZM?=
 =?utf-8?B?WE9xa0tlb2pRRlcrQjFlb2p3SDdCajVHb0I2NTE3SXlMMDdhWmNUV2Q5MlZk?=
 =?utf-8?B?UHlHOEdsb1pIMzUwcnlReWhoU1l2OTFpKzVBbDF4TFVjNm80VW9xbzFiSEc3?=
 =?utf-8?Q?do+I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83340e2-694c-41eb-f3de-08dceedce2c4
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 18:52:44.6266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toSzxK6HAAPPqHSGHL7d6Uqqa7E4rLK57ehJVBhYcsWRPWuRmKDFspIs+Byae0YC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875

Hi Reinette,

On 10/15/24 22:21, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/24 10:39 AM, Babu Moger wrote:
>> The ABMC feature provides an option to the user to assign a hardware
>> counter to an RMID, event pair and monitor the bandwidth as long as the
>> counter is assigned. The bandwidth events will be tracked by the hardware
>> until the user changes the configuration. Each resctrl group can configure
>> maximum two counters, one for total event and one for local event.
>>
>> The ABMC feature implements an MSR L3_QOS_ABMC_CFG (C000_03FDh).
>> Configuration is done by setting the counter id, bandwidth source (RMID)
>> and bandwidth configuration supported by BMEC (Bandwidth Monitoring Event
>> Configuration).
>>
>> Attempts to read or write the MSR when ABMC is not enabled will result
>> in a #GP(0) exception.
>>
>> Introduce the data structures and definitions for MSR L3_QOS_ABMC_CFG
>> (0xC000_03FDh):
>> =========================================================================
>> Bits 	Mnemonic	Description			Access Reset
>> 							Type   Value
>> =========================================================================
>> 63 	CfgEn 		Configuration Enable 		R/W 	0
>>
>> 62 	CtrEn 		Enable/disable counting		R/W 	0
>>
>> 61:53 	– 		Reserved 			MBZ 	0
>>
>> 52:48 	CtrID 		Counter Identifier		R/W	0
>>
>> 47 	IsCOS		BwSrc field is a CLOSID		R/W	0
>> 			(not an RMID)
>>
>> 46:44 	–		Reserved			MBZ	0
>>
>> 43:32	BwSrc		Bandwidth Source		R/W	0
>> 			(RMID or CLOSID)
>>
>> 31:0	BwType		Bandwidth configuration		R/W	0
>> 			to track for this counter
>> ==========================================================================
>>
>> The feature details are documented in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>  arch/x86/include/asm/msr-index.h       |  1 +
>>  arch/x86/kernel/cpu/resctrl/internal.h | 33 ++++++++++++++++++++++++++
>>  2 files changed, 34 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index 43c9dc473aba..2c281c977342 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -1196,6 +1196,7 @@
>>  #define MSR_IA32_SMBA_BW_BASE		0xc0000280
>>  #define MSR_IA32_EVT_CFG_BASE		0xc0000400
>>  #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
>> +#define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
>>  
> 
> As Tony mentioned, also please correct order of this MSR.

Sure.

> 
>>  /* AMD-V MSRs */
>>  #define MSR_VM_CR                       0xc0010114
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 86e3e188c119..de397468b945 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -602,6 +602,39 @@ union cpuid_0x10_x_edx {
>>  	unsigned int full;
>>  };
>>  
>> +/*
>> + * ABMC counters can be configured by writing to L3_QOS_ABMC_CFG.
> 
> "ABMC counters are configured by writing to L3_QOS_ABMC_CFG."

Sure.

> 
>> + * Reading L3_QOS_ABMC_DSC returns the configuration of the counter id
>> + * specified in L3_QOS_ABMC_CFG.cntr_id.
> 
> First and only mention/use of L3_QOS_ABMC_DSC in this series. If this register
> is not used then references to it can be removed.

Sure.

> 
>> + * @bw_type		: Bandwidth configuration(supported by BMEC)
> 
> "configuration(supported" -> "configuration (supported" 

Sure.

> 
>> + *			  tracked by the @cntr_id.
>> + * @bw_src		: Bandwidth source (RMID or CLOSID).
>> + * @reserved1		: Reserved.
>> + * @is_clos		: @bw_src field is a CLOSID (not an RMID).
>> + * @cntr_id		: Counter identifier.
>> + * @reserved		: Reserved.
>> + * @cntr_en		: Counting enable bit.
>> + * @cfg_en		: Configuration enable bit.
>> + *
>> + * Configuration and counting:
>> + * cfg_en=0,            : No configuration changes applied.
> 
> Can this be expanded? (sidenote: It is taking a long time to get clarity on how
> to interact with hardware. These incremental cryptic fragments make it difficult
> to know how to interact with the hardware.)
> 
> For example, "No configuration changes applied. Counter can be configured across
> multiple writes to MSR while @cfg_en=0. Configuration applied when @cfg_en=1."
> 
>> + * cfg_en=1, cntr_en=0  : Configure cntr_id and but no counting the events.
> 
> hmmm ... still the same (""but no counting the events") strange language I
> highlighted in V7 ...
> 
> I think it will make things easier to understand if similar language is used
> between the descriptions of the different fields.
> 
> "Apply @cntr_id configuration but do not count events." 
>  
>> + * cfg_en=1, cntr_en=1  : Configure cntr_id and start counting the events.
> 
> "Apply @cntr_id configuration and start counting events." 
> 
> Can it be added here which of these settings (or combination of settings) result
> in counters being reset?

Any change in the configuration will reset the counters.

Little bit lost here. Let me summarize. How about this?

Configuration and counting:
Counter can be configured across multiple writes to MSR. Configuration
is applied only when @cfg_en = 1. The event counters will reset when any
of the configuration is changed.
cfg_en = 1, cntr_en = 0 : Apply @cntr_id configuration but do not count
events.
cfg_en = 1, cntr_en = 1 : Apply @cntr_id configuration and start counting
events.


> 
>> + */
>> +union l3_qos_abmc_cfg {
>> +	struct {
>> +		unsigned long bw_type  :32,
>> +			      bw_src   :12,
>> +			      reserved1: 3,
>> +			      is_clos  : 1,
>> +			      cntr_id  : 5,
>> +			      reserved : 9,
>> +			      cntr_en  : 1,
>> +			      cfg_en   : 1;
>> +	} split;
>> +	unsigned long full;
>> +};
>> +
>>  void rdt_last_cmd_clear(void);
>>  void rdt_last_cmd_puts(const char *s);
>>  __printf(1, 2)
> 
> Reinette
> 

-- 
Thanks
Babu Moger

