Return-Path: <linux-kernel+bounces-370709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDDF9A3117
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879B1281981
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C51A1D95A9;
	Thu, 17 Oct 2024 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YdquMmyp"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C9B1D5142;
	Thu, 17 Oct 2024 22:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729205793; cv=fail; b=Y9VjRgMjshLmEXLPTMHj7aAmFgtLpj5B4P3CHb34oU8DIpPUu7CmnND7t5Rj/pHw8GC8W74mAikmP5U4u3ccPuVqJfxA6Qfjg7P5ynUTddmxuNxIfNDvQEjkEmeBzSxtb93N0kWpvBL/rJgrPKZhFBngfNAjAobgOeDyijH3FI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729205793; c=relaxed/simple;
	bh=+Ob1O8lXN/xwT+Gibz+qRDr9eg6SS6RdcfkKyXm+1Hg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=piN58l/rsajIsz8LBX7fvpVurzbVLmc1ped/gfCx9KlScia5kIJYvrCTKmzQ7nDHQQ283wbTe6OoGiKF0girGrQiYlWdJyyFT0V7knwPsg210Jeb6e/BLzIM8UMPSxmat9mAL564znAk/PKBdUdwD5ZfvGt1IDHKuzz9u9sacJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YdquMmyp; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlMzKv7f9vMknI13QRtEHg8tVN85wLqQ0LUYdHx6XY/vZwWl5Jtwsyblu8y2JOSvK9RwYShxOhZ8FpE23TYJX6C0hYjr0mDtN5CtuhOC8rgOeH3Ev6rcFjXNO7UgXROu/VqV9jbfGTWxhAFIevz4LTQbYvYZiKHddx0zMotC2jelfwQrBEq2qwd0vsbiWM7XYRRF4VYCFlztYfMDJ8FoHnQNl8YQgEcIiOlWtcWesnlf/POBSgvuyGFeOo1d81ZzolbMSzD5hYqNDHmkgqKm1nvKFch0vDLigEW8ELWHJ2vKmCK3FpNiorDdEzVQd0TGdRE1dqhQwJkfY9+2Hs3fQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebIguG5Vtv45ldLw1v0SpuGimywPSBP/tU8u3548hc4=;
 b=eaVzgjyVurhq2qKg10ZhjAgY3CxVSPXc+3dMe0Y6M2cRwh6wiep6Kt5nSK7TlpDk8+Dg/hiart8cVz9sNhNEGdSD+p6Gx3xtHqSHMG7vlVJXmuWTaDe8JYRzcYT+zGghr2A1MISf+hoOdyg0RXRfEaonWN48d8Mw7r/4LV1pFBswdwEPCthLTqL7OdRvJc18c7OTcxyUylWAsgntGHJ1KUVr20t07SOaveNRbagMDarCOPnc9QMHkPRxMgDwlkyUGakH8htu1tjmggDX0D+7KBh72oAY3VArjw/gQUY6XvV6i5KP5H45BhXiZGYQBVc1+l0RVnk3ahAU3nrXS5557w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebIguG5Vtv45ldLw1v0SpuGimywPSBP/tU8u3548hc4=;
 b=YdquMmypDRmpNYjLuxo5n5pVSwsytNsDaR74AqT0K99xm0DHvCAeWaE/ep1A2ut7UgiVeVmTvnFxllyekZg6DoazpWvu1VSEqboA0X1fpnVjIMWZvXE4j3Ii9u8TUxieOGmsPAwTVwgygZ2x5VeD9nwp/0m0bCp+gjs4JoYssDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 22:56:24 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 22:56:24 +0000
Message-ID: <78674f8c-963c-c6bb-ce8f-470d068299ca@amd.com>
Date: Thu, 17 Oct 2024 17:56:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 17/25] x86/resctrl: Add the interface to assign/update
 counter assignment
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
 <86c8fd4db89f264b1382cd22d7cf53c4510bf07a.1728495588.git.babu.moger@amd.com>
 <367f3877-e23c-4115-a004-1480ad2ab17f@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <367f3877-e23c-4115-a004-1480ad2ab17f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::9) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 79880347-9643-4bd5-2f62-08dceefeece5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mlh2SjBnWTRJVHVLOWVoUzBMaTBEUEltaUNyQlBuV2xDR3BWWHJmZ2FvWktm?=
 =?utf-8?B?SHpxaWpmTWNjZXdIbzl0SGtvcDNCSGZyMU1STWlFeCtrQ1RTNVdjaHZ6V01K?=
 =?utf-8?B?aWtGWGxpdmVqbHdWNm91b0VXV1Nwd012SFFRR0tWaE1IcXF4dnBGWDZmd3hJ?=
 =?utf-8?B?RmJPbzdBd3hMalg2eDJyTDZRT0tkdHQrWGZBMVNNWDRmMzlmR1dDaFArTXh6?=
 =?utf-8?B?WGlnbXh4UU0zRG5hSXA5YXlxdTZsME5aZVJOSnlIT0pzaTNoc3B0dHFNcU1n?=
 =?utf-8?B?S1JqR2VXV09lYnJzN09MZzJ4YUVETGk5K2lmMllwRFVUYnY5YnpPNjJMNVZa?=
 =?utf-8?B?d1BXVmx3WWpSTUl4aWVnV1lYWCtDU200OVpRN3o0RzlKUjQvT24zemFMcnhr?=
 =?utf-8?B?eitrQ0g4ZjR0ZWVrOVp2bnhNYkZGNjZneUVLZzFmbzN5R2JHRWdHR2pNS3FW?=
 =?utf-8?B?MmdPTkYyYkRSTTAxUlNYRjlCRXpVT051RDdvNEdHZ2diYXFxaUZTZTVFMHVS?=
 =?utf-8?B?bDNLNXFid081SjM5VVk1Tjl1cXJWT0lJSmhHNlJzZDF4dW5sUGpJaEVjaVcx?=
 =?utf-8?B?R0NFaDZpdytNMUxtTXFpV0NZRDliWmlzRkpSMElpUStoQytiZ0JiL1NCU2lm?=
 =?utf-8?B?ZzFxaGQ4bDRJYjVYc2g5R3c0a1Z1d0kyNisza3Nvd0taNElWQ0dUYlRKd0Nn?=
 =?utf-8?B?bkhpbURMUHFMM3RJQk5ROEdralBadDF1WURlbERndVNpV055WGgyaWl1ZlNt?=
 =?utf-8?B?MzZnQWhDWEowZzlGYmw4d3FvUGljd2N2VlgxQ3pFQjZ6ellMTjExMEFWdkhG?=
 =?utf-8?B?UGloakhxOVNuM3hxbUsyR2IrWGxMQkpvZFhmdmtSSVUxWjlaRlBKRU1mZkVR?=
 =?utf-8?B?Qm52ZXpycWNSc3FXQ0NJZE93dTV6bm9RL0ZMWnhHeG94YUtrU3ZHc1hIM3Rt?=
 =?utf-8?B?ZG1laFNEazJzWDczVm5YRTArcUVRMS83T0hDa2VCeGpDWUJtY3RndWJjckpC?=
 =?utf-8?B?NUxWeHRYeXRjYkQ4c1IwcnRjL0hXdWR4Y29yWE1XYzZZeExkSEkwK2Fhc0xs?=
 =?utf-8?B?ckd0QUUrck9abHZiT0s1dTdUOEZlNEFNSWJSOHBBMUFaU2dNTFdZM0NERTVh?=
 =?utf-8?B?MjR2OENsb3F0c0UvUUlPYVNhMjhudWhYNmpYSFNCRWsydG0ydzdJTklVL1VW?=
 =?utf-8?B?VmpvVmNhVXY0VFBPL05oWEtJbTZQcWh5MVdwcXhBa241cVVYcC9zREVBNEdk?=
 =?utf-8?B?N1JzQnlwV1Jxd3dFY2x5SSt5YVk2OHlXZ20yZG5jejR2cG1CVEFIdGRjVXNs?=
 =?utf-8?B?ODRieXBTNEtGNzNqbWRvaGIza0hzVzhTTzBiU1hDYm5lbkhqbWdrNnZ6Syt4?=
 =?utf-8?B?VmJTSlRsd25tUnp5ZjQ5QUtjZ3V5WUpPOFBsOFlwS2VKb3hIS1d0VWloeFFF?=
 =?utf-8?B?YjQxNVNnR0l6V0VSWElOTzQ4eUtNSHVlMmNOaFlLY1FxK3VxN2U4MS9vNDlQ?=
 =?utf-8?B?Z09wNmdaWW5CbDJLc215SXNkVkVsT3ZlSjFKM1JVeXMzMHlnTFp1RW4xVU5K?=
 =?utf-8?B?SkdSK3dXQU1BZTlLRHovRkZ1UlBsdy9SUzNpYkI3YzRUWm1DRms2bDk5ZEln?=
 =?utf-8?B?b3dPMTlKQW5wWGZIVUloNGFqSTljOGNUc0pFQTRSMkVOc0hvTm5ZbW1mSkhs?=
 =?utf-8?B?aU8za0I1d1VFd1oyMFVOQ2FESzBwMmF5MjAzaTdvMGVLMThlSnhJS0NKYmNa?=
 =?utf-8?Q?LQv1zHHZL9+7Xl5Kba1PRo8Gg9rzM/8UojybCXC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QktLUVloTlRHSndoQzUxNmhITHhvL3J2V1FjbGhPa0loMHMyd2RjaVR6bHpL?=
 =?utf-8?B?Rjloa3NrNHJOT0UwVXhuemtudmFTT1MzelM4NE1pdmtmbHVETGI0aXRtYlEr?=
 =?utf-8?B?RUNHV0pESnk3dmcwL1M3K2tvMXpHRTc2VWNJdm05NDI5UUVJK28xOVVrRmJv?=
 =?utf-8?B?T3d6WkVBSUJRN3VWQ3lVN2VmMkpGVlk4NzV3VVhvdVQ0UEc5TTQxNWpVbDc2?=
 =?utf-8?B?dmtDSUZ3VngzbXNBUVNScnZVWTlnTHlucGhwS0JiT1FnMVJoY3VSc0hjOWd1?=
 =?utf-8?B?elpFdHFlenBVWkUxN3JXWnk1UzJhSUZJUEc2RWJDKzVSdEE5dXZnalJMNEh0?=
 =?utf-8?B?YUo3MFhieWh5S3FtOVV5Ulc5eFA5QU0zb241UWgyQVM3WU9yc09RS0Fnelgv?=
 =?utf-8?B?Z3dyVjd3T2RZRWZGZkxpU2x1cDc0R0FEZXpESlpZdXJwY2VyMXJndk1iMitm?=
 =?utf-8?B?Z3B6Vnl1MjVYKzhJWmhxK1BRT2ErUFJGUmlLeWlDa2QzODFlYXhUNnNHSFNx?=
 =?utf-8?B?ckZTWmhEM3hHbFNJSEowRXNQbm0rOFlnclhHTVQySk4rZ2l5OHBhTC9QVmpS?=
 =?utf-8?B?THN6T3E4Yjh2OUZMYlBOWnRzSTdqcFlFcFhSREM4ajRWaGdGNUtnL1RXcG4x?=
 =?utf-8?B?Wkp5TGVMdHQ2Wkg5YWJRaEJjNUZOQ0c3KzZsOTVvNVJwa1l6U28ybEt0bTF3?=
 =?utf-8?B?WFNEYnMxVCtLeDU3ZlhpUG1TWk01SUFGclBNaFpmSU5LSlUwNHhBSmthdlVq?=
 =?utf-8?B?bXpFdnhWZW93d2EwUk5XaExpc2hZVXdDTkROU2NjYnNVdzBQSjQrOVVXbTh1?=
 =?utf-8?B?Sk1odllQeHR6dmdQZDI1L1lLK0dtUzYwTnd5S3Y4dEkxWm1wbjlvR054MytK?=
 =?utf-8?B?ZUN1ZTZLbHY4c1h5dVl5dWJTMmhUYWpPbkZWaGFDSG5xYlhURlJNZDdveTNW?=
 =?utf-8?B?MGZvcHNheC9xaFZmZFFFRkQvbkdGY0w4anpXU081UXBtdkJxOSs0VjJ3RUx3?=
 =?utf-8?B?bjNoek9xdDFHZnJVbjlDUnN0cUFQZU4zUG5RM3RrMlJvMkFZY2Q0Vnd2aFg2?=
 =?utf-8?B?SW40dGFLWVBlcjdGZmVLRmRHOVNGN0hRdS93Sk5HMWtvSTkxQk1jQkFZcXRU?=
 =?utf-8?B?UXpGMk4wb2pIWGpOM1NvNjRhbXBvUHNxb1pITzZZd1gxOGIxYkk2Kzhpb2hF?=
 =?utf-8?B?cFd1d3huaDBLaTRwUDJhOE1KZHNvbm8vKzVvS093QkNYZTVsWVd3N3pCWFMy?=
 =?utf-8?B?Wk9kVnFMWjhVa3BnQmdpbStkOWpVOFVZQmh4empDTm80eFJOWlFMbVFKQ2ls?=
 =?utf-8?B?MFlIUHlBT0tmbi9saTVQR3dwcldWMkpwK3dvUmIwZTVJMmlLamZraGJYNlow?=
 =?utf-8?B?L0d4TTR6QkU1dit6bklWaHVaeVFVbkVoR29McnFYMXV1dERkSDQwaHpFY0Ju?=
 =?utf-8?B?UUxvcjdLbDdGSnh1RmM2ZTZSRHFaa0k2NTM3SkloekRrQkE3ZzF0Z25SNHFB?=
 =?utf-8?B?eDlhenRyKzliV0Vabk1UdWIrcnhMR2RrSzUzbE9sRXo1VWJyeGtUdmZ4VE5n?=
 =?utf-8?B?Q3FQZWtPMzV6N0RaSTFHdWcwMHVWRm0rbnkzYktQamlMZDM0Zy92MEJucVN3?=
 =?utf-8?B?andxVnF5NFR0MHM4Q1VIS3NacVAveTBBS0tBVHhBZU5RMEFqMXJWWTcxMmtl?=
 =?utf-8?B?Z2w5NFl1L2x3WFdHZUdLWEN5aFZ2VlVXSGxFRlJkemxOdW1STU01V1JtWnBO?=
 =?utf-8?B?enpSaG1tbTFQZVRYc01SWXZMV3UyZG1PcHVOLzFpdDBYelc2YzZrekJvcFVV?=
 =?utf-8?B?NG1BMW8zRFlsMW5OT09vNVRFTVhLM0FKUVNJSUxCVVlORDBPZ05KUnBOWHNU?=
 =?utf-8?B?Z25sWGdYRjJ0TVRxeVFQSmFLK0JBNEZsdnNDWmtmN2VvVTVBQ2tvd2VkU0du?=
 =?utf-8?B?dHYzV1ZSQmFJNjVVcS9GZFRmeVJRQWNGRUd3djQ4VGNGb3lmdFVkcUJ5VXFw?=
 =?utf-8?B?VVJyVE9lSzNCdWxISXBLd1lwandZSDY3Znh3azJNUUVzblNXamk1aUE3bVZ3?=
 =?utf-8?B?czhNL3ZJNmd0VGpBSk4wR25CZjNTV0FaK252eHlxb1pnWmNoZnIyYlJxS1pE?=
 =?utf-8?Q?Z4SQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79880347-9643-4bd5-2f62-08dceefeece5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 22:56:24.5069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YoWuJ+GyTYgBdIxdVfzzjPXvzFXkjTBKpn5YrVLCuctJv6E4+RDbVfbpuFsy7Rue
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312

Hi Reinette,

On 10/15/2024 10:25 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/24 10:39 AM, Babu Moger wrote:
>> The mbm_cntr_assign mode offers several hardware counters that can be
>> assigned to an RMID-event pair and monitor the bandwidth as long as it
> 
> repeated nit (to be consistent): RMID, event

Sure.

> 
>> is assigned.
>>
>> Counters are managed at two levels. The global assignment is tracked
>> using the mbm_cntr_free_map field in the struct resctrl_mon, while
>> domain-specific assignments are tracked using the mbm_cntr_map field
>> in the struct rdt_mon_domain. Allocation begins at the global level
>> and is then applied individually to each domain.
>>
>> Introduce an interface to allocate these counters and update the
>> corresponding domains accordingly.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v8: Renamed rdtgroup_assign_cntr() to rdtgroup_assign_cntr_event().
>>      Added the code to return the error if rdtgroup_assign_cntr_event fails.
>>      Moved definition of MBM_EVENT_ARRAY_INDEX to resctrl/internal.h.
>>      Updated typo in the comments.
>>
>> v7: New patch. Moved all the FS code here.
>>      Merged rdtgroup_assign_cntr and rdtgroup_alloc_cntr.
>>      Adde new #define MBM_EVENT_ARRAY_INDEX.
>> ---
>>   arch/x86/kernel/cpu/resctrl/internal.h |  9 +++++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 47 ++++++++++++++++++++++++++
>>   2 files changed, 56 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 6d4df0490186..900e18aea2c4 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -67,6 +67,13 @@
>>   
>>   #define MON_CNTR_UNSET			U32_MAX
>>   
>> +/*
>> + * Get the counter index for the assignable counter
>> + * 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
>> + * 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
>> + */
>> +#define MBM_EVENT_ARRAY_INDEX(_event) ((_event) - 2)
>> +
> 
> This can be moved to patch that introduces and initializes the array and used there.

Sure.

> 
>>   /**
>>    * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
>>    *			        aren't marked nohz_full
>> @@ -708,6 +715,8 @@ unsigned int mon_event_config_index_get(u32 evtid);
>>   int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>   			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
>>   			     u32 cntr_id, bool assign);
>> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>> +			       struct rdt_mon_domain *d, enum resctrl_event_id evtid);
>>   void rdt_staged_configs_clear(void);
>>   bool closid_allocated(unsigned int closid);
>>   int resctrl_find_cleanest_closid(void);
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 4ab1a18010c9..e4f628e6fe65 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1898,6 +1898,53 @@ int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>   	return 0;
>>   }
>>   
>> +/*
>> + * Assign a hardware counter to the group.
> 
> hmmm ... counters are not assigned to groups. How about:
> "Assign a hardware counter to event @evtid of group @rdtgrp"?

Sure.

> 
>> + * Counter will be assigned to all the domains if rdt_mon_domain is NULL
>> + * else the counter will be allocated to specific domain.
> 
> "will be allocated to" -> "will be assigned to"?

Sure.

> 
>> + */
>> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>> +			       struct rdt_mon_domain *d, enum resctrl_event_id evtid)
>> +{
>> +	int index = MBM_EVENT_ARRAY_INDEX(evtid);
>> +	int cntr_id = rdtgrp->mon.cntr_id[index];
>> +	int ret;
>> +
>> +	/*
>> +	 * Allocate a new counter id to the event if the counter is not
>> +	 * assigned already.
>> +	 */
>> +	if (cntr_id == MON_CNTR_UNSET) {
>> +		cntr_id = mbm_cntr_alloc(r);
>> +		if (cntr_id < 0) {
>> +			rdt_last_cmd_puts("Out of MBM assignable counters\n");
>> +			return -ENOSPC;
>> +		}
>> +		rdtgrp->mon.cntr_id[index] = cntr_id;
>> +	}
>> +
>> +	if (!d) {
>> +		list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +			ret = resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
>> +						       rdtgrp->closid, cntr_id, true);
>> +			if (ret)
>> +				goto out_done_assign;
>> +
>> +			set_bit(cntr_id, d->mbm_cntr_map);
> 
> The code pattern above is repeated four times in this work, twice in
> rdtgroup_assign_cntr_event() and twice in rdtgroup_unassign_cntr_event(). This
> duplication should be avoided. It can be done in a function that also resets
> the architectural state.

Are you suggesting to combine rdtgroup_assign_cntr_event() and 
rdtgroup_unassign_cntr_event()?

It can be done. We need a flag to tell if it is a assign or unassign.


> 
>> +		}
>> +	} else {
>> +		ret = resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
>> +					       rdtgrp->closid, cntr_id, true);
>> +		if (ret)
>> +			goto out_done_assign;
>> +
>> +		set_bit(cntr_id, d->mbm_cntr_map);
>> +	}
>> +
>> +out_done_assign:
> 
> Should a newly allocated counter not be freed if it could not be configured?

Yes.

> 
>> +	return ret;
>> +}
>> +
>>   /* rdtgroup information files for one cache resource. */
>>   static struct rftype res_common_files[] = {
>>   	{
> 
> Reinette
> 

-- 
- Babu Moger

