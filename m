Return-Path: <linux-kernel+bounces-570541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 838ADA6B1CC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5025A8A5374
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD5986352;
	Thu, 20 Mar 2025 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVvt1t9Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2736116F858
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514428; cv=fail; b=eSU1kWFVfNXHM+tbVsHW7GO8/6Crr8y9Bw/fJFzVMtPR248N3LmY3b33L9xewkTMtPwjxIoGisPqOxGbF3xSBKZMMCcrva3+ENj/ooK3B6xF6tvn5PQDHGg68ul8KuDDfA00W16tmgv+baukaEJgedCWWWrLhWL83EjQqAuRTks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514428; c=relaxed/simple;
	bh=HKeG9ZBvMft+hNjDNjEAkRdT6aeieB6Ats9EvsJT5wI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kZiNNSJhrM9H+Ua4xJDs4sEIaHhpK8atiYXmNYXzL1UPlXNQ9Y1jVLU6uY/ZfOwkpURAMf0kbgJK4BG/2fbWunZ9Za49HJt/trq1EHKnATv/SMzC6CjGtcu995gNp8voUNspEemoT4cIF7ZjUOer2xcK9qiVKLG7/XVj00JQiuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVvt1t9Q; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514427; x=1774050427;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HKeG9ZBvMft+hNjDNjEAkRdT6aeieB6Ats9EvsJT5wI=;
  b=VVvt1t9QN4oO/Ehu2zFnIE6vgfXCivlFdIo5PRfyS1mW1NCK7/u5d0aB
   gnn80G015NQ6yYDDhKqAg3/uiRqetaoyRfEfFzsChy4tw0H1ATBCkobbd
   9gNeNpBBY7oOAjmrpAFgJdd1BunqwxFA7kgG2pu671+GDHhsuw/wRBU0P
   uLek3lrWZnBhEWCLoJrCS+7cVWStwyhfLXEcctO3BqmPLtxU2uzUD4wzU
   41G1FZ1VsHnIniPzmFfrzQDelD8cqKxYRWham+9unf86AhlyO92mnVN8n
   igKNXtA+R4Dc1jsCQsdNsl9bKhzVyGuLN3nuvPPE89xk0y//JVHI3M1EV
   Q==;
X-CSE-ConnectionGUID: Fo4R8NnNTKWHzCTGyxTkLA==
X-CSE-MsgGUID: sYlwA/ThSniS3s0d3d/p0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43502890"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43502890"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:47:06 -0700
X-CSE-ConnectionGUID: uH0f/KPjQCqwd5PGYaww7g==
X-CSE-MsgGUID: KL8lQ/TbR3+YexxE/mEc7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="122963359"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:47:06 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 20 Mar 2025 16:47:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 20 Mar 2025 16:47:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 16:47:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHiBMFSgOt0Iil2gKfrgYgAlTJJzj3ZlEK8Ex+DpDggL1neVHzVrJCBZjrGhHAgfn0Ax9+Lsqp39GG+Dn7weS0JaaaP3gaS0zLtEMGI/n3L5im8v/WBF4m7tbARdyHoCZO1LXUXvQCMBpnSPDM6I9O63V0d+tX71Cxobm711X3f//vVX56odo91oTqybDlzUeKlkvO+XWfqMDJ3mVO5h0QLYSQeHf78n59hfBCrjX6r2fFRT+oMRlW+JvK5aUlWBccQ8qoj58k2xW2JuKF89xw8Ro1KvqJGl4v9aL8D0ujLA/AmjiElCByhY5aZjQNrrKcXIaHMw/sHsfoSGg+6vwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qoMmkrj2MuHnK5QIKKeyFWPLOyqv8HisAGXaMlaKYU=;
 b=CYw3L2sLlhTZ578uV0Ixgjc5nUtGr7Vi3kvDjVwmowgcLUwvHOHHLIS2Rxn+38X4LYK11dop+mVMXFc+BZ3wnj4Mp7Toz7OG7iJ4RaWnY8en32UMgNM9jZIcVCW1NGQOwXLhXNcRpmTQA6EPCuKfHvyJIcHoch/ePGUAYIGlK0xXTNeQX6vt356GyOKodzUQ6xpoP0w/qTKSqO9lmmAI7cDfwb6WEiO9JznAokPvJjy6dPEqSDv1KkpSd1ouTMf0Cq+hs0HFpa6w7SQCMs9hgCoRHJf+tpy0qgdhXK/cUchyarhW2y/6gT+gzuBI4HKPEaSBMJjHhUSy1MM4MPRirg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SN7PR11MB6798.namprd11.prod.outlook.com (2603:10b6:806:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 23:46:57 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 23:46:57 +0000
Message-ID: <02f06309-ccf1-45b8-bb6e-c6eb2e18c0b0@intel.com>
Date: Thu, 20 Mar 2025 16:46:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order table
 and accessor macro
To: Dave Hansen <dave.hansen@intel.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250227184502.10288-3-chang.seok.bae@intel.com>
 <7fa02be2-0884-4702-ae73-a3620938161b@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <7fa02be2-0884-4702-ae73-a3620938161b@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::24) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SN7PR11MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff4769b-0ffb-4bed-9249-08dd6809806e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmR1bnRSZWxqUFk2YlozWUZUUDJhbWRtTnVSSkowcmw4QnpnaEgxckpEbjZF?=
 =?utf-8?B?Q1JUMWg3TWdmUjN3Z2NZeVpJeExkbzI4OEJ1MFFaNzNtOE5XQWVzQS81d1RE?=
 =?utf-8?B?V1NpYWtsdk1ob3RSL2hKRk1FKzNHSml5eVhvZUZ0N2d3cWVKRExzMENSQjNz?=
 =?utf-8?B?bUZDV0VpYytVeHVwaEhJRUZOZm5Nb2ZtbUw5VnVydDZEN0tmMGlFUVN6a29P?=
 =?utf-8?B?TnRxb2J2MDRMS0tRSG54cGxkVUVyL3IvNnhhSm1YTjFaK2dDVUhRdzZzRExP?=
 =?utf-8?B?cTF3VVJYanVFNXVjbkhXZW9WN2w2V3puQ29MMUxZOThmUG45TG92TmpJRXFn?=
 =?utf-8?B?SHJXektOdmFSL2ZMcEdPT0JlOWxwMlphb0ZlZ1d3Sjl5ZDhCeGtldGlLYjFZ?=
 =?utf-8?B?YTVOVXdZeXp4bjJPbmtHSFVCdnJVZWVyWGFZZ3ZiRTFuQ0lTZHhCTDc4SE9C?=
 =?utf-8?B?aWxIZ3oxejhwS01OT2pZUzdWQmNiOC9ISkQ4M3l0TjVZQmQxRVROUlpzcDZH?=
 =?utf-8?B?Rms1MWpDcHloNTdrSnNTc3VWQnBBbHJOclJQYkZVQ3drV2V2Sy9Gb25wY1FT?=
 =?utf-8?B?cEVXU1IvQU1TN2cyRnVKQWdsWTdtWnYveE5PWXJhWGZ1UlM5aUtaejNsUG52?=
 =?utf-8?B?NnRPOGV6eXF3bkE4cjkxOFd6dGJtU0pidGtQTWxiUDBCNHFxNnErVlZFV2I4?=
 =?utf-8?B?TzllOVFuVWsvMFFBdXVxYkNVdzNLSStrTDEwTk9BYmltM2dDV3Z6V0Rjd3I1?=
 =?utf-8?B?VHd5MWlaVXoxYnVxT2taNTZwUUYvb0ZxeXA5b3BMa2xza29YQThtYlMxRGhj?=
 =?utf-8?B?aitCeFdsOFpuK1ErendBZUFJRzN5c0EyUHF3L1VWYXpnSFV2cVd3bldCNy8y?=
 =?utf-8?B?MFVIbGVmZytnNEVuckhlclE3Y3F5eGx3a2Zhcis3TlE5a0krOVM0bTJxaFZJ?=
 =?utf-8?B?WEtUei9GYXNDc1NiZmMyR25TSHNLNXRBSnFQWWV1WHJJTXBiU1ltVnQvd3pz?=
 =?utf-8?B?amR1U0Z3V2ZhWTFwZ2oxdjViWFprUnVLZlZOYUZvL3JsUDZMeW9oVDFlRity?=
 =?utf-8?B?TGRqK2hUcy9XSmlqc29zTmdKbHFEOUE1UmdpK3RTeXBTZkQrSWJ1eTU0di9H?=
 =?utf-8?B?d2JNNG5aeGNxQ25OQVhhQmQxdGZ4bUl6TUxxbEJxajlzN0Y1NHZxWlEzanQz?=
 =?utf-8?B?dHh1MHE0cVFQSjRCc29iRU55eHA5UnZoU0FRSnRCNmNQemdGekFvcXBFV1k5?=
 =?utf-8?B?Qit5dXg0NVVZc0U2MjVIblpsbEhSck1veXJZYWhEaXoxU2lTa2ZHSGN6UkIv?=
 =?utf-8?B?VFkvMWNJN0MyMk0wSkVOWDk4UzB1OW9IaUZtYW1KanRzdTVTaW5hT1Vzc0NM?=
 =?utf-8?B?ZWdYckZyYUZZWmNEOFRhangwNkNjZkFCaUg5bjdqeU9tNjErQmFYNVJHUVE1?=
 =?utf-8?B?eWttbFRsbUZiNDVhSDlXVDVadm01YWloYmJuaUZmTHVFS1dFN0EwV1lNMTRn?=
 =?utf-8?B?QXplQU5yMGxTM1h0d2ErYWFuNjZhb2lEQmluZEplVXRaZ2hQazhIK25DYmYy?=
 =?utf-8?B?T1lZZDJ4K3dsTVlFV0JMOXRnYUtHYU1ZMFZ0S1F6ZFdPOG1kcWp2ZDF6Wnow?=
 =?utf-8?B?M0dFdWI1VTFUcEZNeTVySlhnemRNcmlhTTBKWEViWXlSUXlxRXJKbHR1ZWgw?=
 =?utf-8?B?cmhJbnBmNmp1WVVmdVZEckRTN0JHMThvaUgyZVlYWjBsVWdCYWFnVmF5K1E5?=
 =?utf-8?B?Z0krUExmMFlMSHViZGtkajRtbEN6Nlh0VCswWVp4YUVKSGhuRjZmOS9xemJm?=
 =?utf-8?B?MzFsS1kweEVMZHVYS1N4bGppMm4rYjFiSzYwdEE5Yk13SDBUV2pjbEt2eDlD?=
 =?utf-8?Q?qIwBhENT6Rnfh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UENyNkwvSnNoU3F2L0VFc1B1MnVvVnUxZjRUZG1OZDVWVzdPN2UzQ2dMMGNF?=
 =?utf-8?B?Y2R6bzhzSGwwZXJGMmhwd1Uva25TQldTSEYyeENkamJ5b0lkRWx6bGZGZHpk?=
 =?utf-8?B?SUI2RTlkb25VbjRsSEkzKzQ3eDlaTlByd0NNdDA1V0tWRkhrODlCN0QvbGhT?=
 =?utf-8?B?cmdCb1NiTVlFQUE3Nm9QN2s1NDFNZUtUenIvOTZzc3dXM0w4aHdONENFRU5w?=
 =?utf-8?B?a0tGc1d0eVRjeUZLaWF5UmkvbE9JTW9JUlpNQWl3UnljOURabDl1c1NaREVD?=
 =?utf-8?B?UHhsLytxNllXVkVKa1lvWGNzTVZldDk3bUVXV2lyQURkWFlsc3drb3NTUitq?=
 =?utf-8?B?dW14ZTRGOVJIZ2hLc0lYSzVIazI4Y0RmS1JCbkJ2NCtvWThpbGYwa21Na3Jw?=
 =?utf-8?B?WU9ZUlJ0ZHZPUWFVQWIrWFlPeXBGMjY0TWpROE5uMWFiRXlWU0lWdk1NT0R1?=
 =?utf-8?B?cTdzSnoxd2U4QVVhdkhEQjZwdEVDSmtYV0U1T1ZMbUZFNWVTZUpWM1VHMmk5?=
 =?utf-8?B?cVJnQXUyMnJjUDAzN1BHb2MybCt2cnN0aHB1YTZrZ2JtS3VDQlZoZ2JjUmY2?=
 =?utf-8?B?QlF2dUVDZkZqckFHYmFRSTMvR05CQU13OHVsTWdwdUxlTXdkNjQyLzM2VXpk?=
 =?utf-8?B?STZweHkwbjdBb2pQK0VERjdYamwxcDdUZDVrT2dWT3loeTAramM3UHpvdHQv?=
 =?utf-8?B?Z3BXVUdvRGpQWHZNS2p0NkQ2cWJldVJVRUJ0NTdVZHZYbUVIaXNhREtFbE44?=
 =?utf-8?B?VStFa2ROOHFBZ0RNY0l5Vno2dzN2M0NMUnl3K0dlQXhpK2ZIbmNGTkV1bnRY?=
 =?utf-8?B?YytSM2pCNGZxaGxBM3kxc0IxMmd1UHhZT0xZc1J3cjhQZno2OWc5SFRidGR0?=
 =?utf-8?B?Y3NoUEhIbzVKbWdpTzJBR0J3ZkVSbEpERENZRnZGazJKWUNCbmVUdloyUVF5?=
 =?utf-8?B?NDhnYVVGL0NJVXA0L3RTT3JzUzBvZi9FZzR5c1ZMN1Y3azBVYzBuWE0xMUZs?=
 =?utf-8?B?VnFuZFZ4eVNhWGFPMWM3WHliWTA4eUpYL2FmbDVCT0pDVEovVWRMYWNiQi9r?=
 =?utf-8?B?TXZlNndqcllqaTB2Nkc1aVdlVXVodWlrNVBiR0hnaDBEcEZGSXFRNUVNZ0lu?=
 =?utf-8?B?YmJWaHVpbEljNm9qUDR5MDB1QjJYREI1U3V2TjNwNG5weVR4N04vZjVNSVJM?=
 =?utf-8?B?V2d2L01lYkFQd1lOSjBaVEhoRFBucTJCV0FmK1dad2I1ZzhTbTJrWEw5ZEYx?=
 =?utf-8?B?SEE4Z25SdXQxTURhYk5SYU5tZnJ1QjgzUjByV09RTm1XcERKSUhqeTg1WWdj?=
 =?utf-8?B?RkJDK0RNVzB0MWhPT3FPSXBxUXpKTjVqb0JmaDRobVdLcWNQdUF3djg5cjBJ?=
 =?utf-8?B?WkVmeTJjZlZ5QUdiU0RUMHpoTmVLYjdnU0NmRmF5bzFmNTB0ZzQvVE1PTFhO?=
 =?utf-8?B?aTcxTy9VUW9yRFlQcVI5emhCZzJ3M2Z6WDJEWVdpWFNSUGVSZHJwYmdYbkR6?=
 =?utf-8?B?SE1JNmRLa2s5YzZMR0gxdFJkSHR5WlFXUFZwL1NYMUlYcFIxS3dXaWJETHpu?=
 =?utf-8?B?aE5zUmk5b3ZHUHVwV29nSGhSVnZ0SVRkak1vZkgwdy8xSStzdzJTYnVtNzQ2?=
 =?utf-8?B?NEwrbkVabmk5WWlzWVVhN3h3R3BkUkhnaVh5Y2pqZGxFMTkrNWVCWno4ZmZt?=
 =?utf-8?B?ZnhReFdkVXNnN3NnbkpjTnowSTVkbzFrcXAza29jMTRTamgyWVVSY1o2RDlk?=
 =?utf-8?B?OGQzYUdmOVBlVU5oeDNGTHN6SkRBeWFtMmx5K1hsNFB3Vm1oWW5nTXl1QnJP?=
 =?utf-8?B?MVVBb2h4SHRvOXNkYWYrTmRidzZrU0V1QkF0UmtCczU1NVVKV3RYOU1RWVlS?=
 =?utf-8?B?VVF5Q2JMakg0akVDSjk4MkliVkhpMXozTGsyS055aDhucTdsOXRtWmQ2eVcz?=
 =?utf-8?B?QWtMQm1WY0VjbWpneE9ITVBVOU9GcG5aU0FENE1OWkZqdzZpQng2Mk91UkNp?=
 =?utf-8?B?ek1ZK3pJbjZxdHo4WXFiMHR3OU5VS3BqQ1hTbE1hTjNQU1dLQlcvYVZOalVO?=
 =?utf-8?B?bVBLSkVYbHRwazlBWnB3THFvYkJSR1BxSldxREVzOU5acGRlM3FIM29vL0Na?=
 =?utf-8?B?R01EVTNUOEJwS0RuaHVnNStNMU1XSGNoRUlwVGgybjdVSnY3MnZqckNBcUxC?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff4769b-0ffb-4bed-9249-08dd6809806e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:46:57.7186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnjOEQJxXqLFLuQkEKvaRaVw+tydyRrK2aqfKu84lxEIYnQlOUlvCnA02u4c+GZtMxkhjs7lrk97S7hhR5pIZdqHcEzyYghnpGm/5u9XxMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6798
X-OriginatorOrg: intel.com

On 2/27/2025 11:03 AM, Dave Hansen wrote:
> 
> Two, dynamically generate it. I suspect that once you have the
> uncompacted offset read out of CPUID, you could generate this in fewer
> lines of code than it takes to define it manually. I think it would also
> not require adding new features manually.

Yeah, you also suggested using sort(), thanks! Just posted a revision of 
this patch here:

https://lore.kernel.org/lkml/20250320234301.8342-3-chang.seok.bae@intel.com/

Thanks,
Chang

