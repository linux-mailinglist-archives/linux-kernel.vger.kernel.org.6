Return-Path: <linux-kernel+bounces-395486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D169BBE9A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B353B210FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2CB1D54CD;
	Mon,  4 Nov 2024 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2UVmncx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6645E1CC178
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730751014; cv=fail; b=uhXjJIkVuZMjEC+pYTr+I49mYQn81EN4pNfEsXRNd6IRczP7lrFcfWPpLcCaLXEpo7JV3QYMVFKk342v7CgD2RN3ycr8nUGUqBCfODR2e3X3YLXRkmFz/88wn/uS6OwMHarbqVr+lwoPuaO6LRiQkYOmmJHJ8h6deXYxbl8IwqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730751014; c=relaxed/simple;
	bh=NPm8Yrm/vWlOjdajEFXlzzhmMUFHuHMK5UegT8UhIvM=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JuZ39+U3id5o0TLj7pbxoacQFhCoEzygprR6xUhTjuPEfDlVhJb3FQACpYCvABODYQfq6NEFDX4L6ue20sKAyb40UDjDNMtf3ZPN1gxsGYLAqAdnyfRHdPRrj/8Z3UCs0MggUtCbQ912EQSWRvVH3d8kKXvucROFILmOPyQPqu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2UVmncx; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730751012; x=1762287012;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NPm8Yrm/vWlOjdajEFXlzzhmMUFHuHMK5UegT8UhIvM=;
  b=J2UVmncxFFmNHAedJAXUjsOf7dgkGdhZvN7VAPbv/JvR/e25X+ttxsMD
   tb89ZgPxhyQ32MukK2XBfqhbEF67jzy6JTTwLIWsKp5hRHZAanuNRrTZm
   lipP1GD1Oz4UVIC/JeBiIaa+pGZOYN9+xIAOpsaF4ShQsIxE71FvXkqry
   KO8iyv7gPz562KuIPeq24I9Qdo3ou5dbGWcmW+P696NPBKsj3mE1oZ0SE
   37X5/si5adw06W60DaZPTTHgXUtOpx++ZdBmE3tn9YiuAq3zT1+lFIXuE
   0Zf5j63ygKsf6SkFgM1ZkWEqBZDOxeAM9kjgnQoWpyB8ncTTVn94gN9uT
   A==;
X-CSE-ConnectionGUID: xeX0mkcnQVWN9Tgko67Csg==
X-CSE-MsgGUID: Xz7nLIh7Sg+TjhTAojkqSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34156143"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34156143"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 12:10:12 -0800
X-CSE-ConnectionGUID: and2neWkSbWGzHRBtecmcg==
X-CSE-MsgGUID: iFRyezW6S2GFtqSPcPJo9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="83641912"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 12:10:12 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 12:10:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 12:10:11 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 12:10:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s60tKCQxhPByUjI13wd4lKYLHU68GRcXGySiTkqIyE2vdKUGj6VQYwTr5NFJ5hcUuHvAX87VLZ9d9bKbS+fra3bmpsMMzKa8Vxu7Vesjg+UMj6JyYYL4LJtt8cj1CeNz3lj7uUdWUIGskz2xVD+HMB1950+xlH/RAaD2xljsDnS7S7rqJ6C3QIDMKrWOaz7GdNsAfHZx5xTalfWOCGqDtDUW8gIpCMEpyUTZoh0IQBrNcIEGU1r77m02rjRif2oj/YsrnnIOVmGTT9drq9IfPq/17N2Wn7jAnZz1DF6nhfU0WAhi4eepOdTo3Ykq0zDvtuK65OecglNiZ/tNbpc/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IywqrfKi5ylS0Fta0UoJGt8DTuw/6wRqr6V5NyJGAbo=;
 b=FdbhKGBzKWQEWKMQmUOOxb3G504MXy+aU6kGPbJ4txxV3o9p1IybI3d6oTxufLACAwpCjB1p3EScslMg+4xElOoAsKtuCH8xzBR5tUGiT+rLxuzhlEnqyohyCOfjXqyVQxnklR0AEmMxrpZsPGXieVJU3Yhqil5lbeRj2UPAf46d6MFjx6shdDReEC3wPR/S89cE1apfdON6yqcwtuWYW8Pw6OK/audHoKVSUVvtqcAjw5Q6Ssb5XLQgXV8+uiwpWE3XDav6vxo8SybUqAxwAMJOLWb0Uk/ZfP6XV5EQBIgIxHqnfZJnWEDa3TlDNin3X+//L8qBl25qDLr64uAZBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SN7PR11MB7976.namprd11.prod.outlook.com (2603:10b6:806:2ec::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.20; Mon, 4 Nov 2024 20:10:09 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%3]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 20:10:08 +0000
Message-ID: <e9afefb7-3c4e-48ee-aab1-2f338c4e989d@intel.com>
Date: Mon, 4 Nov 2024 12:10:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/7] x86/microcode/intel: Prepare for microcode
 staging
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241001161042.465584-5-chang.seok.bae@intel.com>
 <20241104111630.GSZyitDuXnBYmEFxvo@fat_crate.local>
 <7d2e421e-7fc1-4ce1-9081-7765bf71f7a3@intel.com>
 <e2a9d121-0505-4bfa-b2b6-6cee7b909aa8@intel.com>
Content-Language: en-US
In-Reply-To: <e2a9d121-0505-4bfa-b2b6-6cee7b909aa8@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::25) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SN7PR11MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: f19e1f57-5308-487d-c6d3-08dcfd0cae17
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHlYZVArYjVBbDJoVUpLVE1NcEY5QmNoOHZzcDJZeVpTYk0xN1lVSS9POGRQ?=
 =?utf-8?B?dkdLLzV4YUJSRVNrM0JXWW1iMmp2NHJYMmJ1UFJXRVFleWptRExNOCtWQkpP?=
 =?utf-8?B?ZlZPRW5QcHZTdmRXZGxNL0o0WnNuWjJ1NE9ocVZlczlxc29yMnRLMjB6QXEr?=
 =?utf-8?B?c2FuRkJnbWFCdVZ4K1dpVUh5SHZjenBkUGp2SmN0WjNSd3VPaVgwVXBJN05r?=
 =?utf-8?B?NzRsMlVJdEtNakk0ZlBmZU9VdTgydDdZSjJUeHJEUThSS3liU1RGSS9uUUJD?=
 =?utf-8?B?eTk3bk51M1NyMmg3SjZ6eUdnRW4rd2oxOGQ0a0FOYitXc25FYUt5ZGp5SkJm?=
 =?utf-8?B?bXgvT2dlbHVoQjU1TUV0TXVRYVBURDFEdVVSczFQVGR6R1FFQ1VpZkQwK2N4?=
 =?utf-8?B?VnlmdGYzdGtia1djRFdoNXpEM1lJKzBlT0hiUS9YQnFLLytsT1gxT3NBaXNk?=
 =?utf-8?B?V1ZkMW15bUdvaUhnRUFPTS91S0xzT1luYW9tUUNQall4Vmc3Y0lVMDl0WFFh?=
 =?utf-8?B?cUdsU05yN1F5a2pGc2U1MTJBZjM4bUovVDloWXVwMGdYZjlNOEFraHo1OUxF?=
 =?utf-8?B?S3JBVEFpTU1qUk8wSEprZXBQTENrc0dLZmVKTHZMaVVUQnEwSGpNTFRrNWdT?=
 =?utf-8?B?UmdVOURPKzZxRVZmUmFEeXFWTHl3akdIYVZkZnBidG96RjJ5VVBaVVF4aVA3?=
 =?utf-8?B?RFZxVElPd2lMbFFKRWhVdlI4NEMyR0VwL3Yrcm9FbkxJUkZBY3hVdEZhOC9m?=
 =?utf-8?B?cmRGTHkvUXowRGkydUNJbTk0Qk93RVB1ZE53bnF2OFVYZVRzN0NxMTRoRTRh?=
 =?utf-8?B?VGRsaHRYbHUyWVlHQnZkeEdVejRFV2xLNGxMZmpXUVRtTTBob2IxcVdqd2pN?=
 =?utf-8?B?ZW5vK1hPVE1UVkpXclJqR0l2NlMzYkJ1SFZzbUdqN2RubTRZVWJuSEZLT21x?=
 =?utf-8?B?ZmVTNndyT2h2ZU41T2w5VzVTanNWa3hpd2pzOGwxcXlNQUVIbkVkWUsrRlpD?=
 =?utf-8?B?NGtleDlsKzhXTEoyT1ZBTXMweGs5Q2xKZjRTa0x2MGVJRnBaeXFWdUVPMGxu?=
 =?utf-8?B?WVduYTgvallFc2FMV2xEa2hSQzgzQk9vQmozR3hOcnNGMWI4UlN4MVF5bUNk?=
 =?utf-8?B?VjZ6NWtWZmNPRE9EdFNjYUZlYm1VMDI4RVJmUlZQNUZnMlJGejJBRnk5ZkNF?=
 =?utf-8?B?YUF1QVg0eUVDeW5PNEwyOHhQb0hINlZodVlnZkVTUVpBbk9MOWlLL3p0SHVk?=
 =?utf-8?B?WkNzYXFFS1dJOVFJdEcxeXBWYitwdVpHYWg2UzJIRXo0QXI5d3laY1o3U0hk?=
 =?utf-8?B?K0h5dnNsSzVvVGd5TWQvUTR1SGhHbGMxYVRJUjlCdmJSUVBHMGw0bDBUMlRO?=
 =?utf-8?B?bkxlRktoVEFIR3YxQUt0YVZiQVFxelRlWHN0aVl0dUo2WE9FUkZEN2w2ZE5Y?=
 =?utf-8?B?N215TnFTNC9jNU9KdDdRRGY1eVpBbVl2SUllOEdZQmtaakhGSmV2R0pRZEF1?=
 =?utf-8?B?Z1pDNXEvenpRa0lJSkxMaHZ4MU9ycWRvRklETWZGNUlHOVU1Z0ptSnhzUzZE?=
 =?utf-8?B?RXBqekhqMW9CVDdDTzl3ajZhbFhYUmZKcnl1bVZRNlRMRWwya1ZlWjBReWxS?=
 =?utf-8?B?UllOSDBVRFI3c2lZbGRJR1FwSWF0c3ZjaW81dnpodUpQdWhIc25RL2xoLzFm?=
 =?utf-8?B?Y2k0dW9EZ3BudnEyMDJwdmRVZ2poRmJTaFZCWG9LRWVxVEtSdSs2aERJNVNs?=
 =?utf-8?Q?PbLOqenoitcZd6EnnALfxH7scY8AkuMgJqBtMRW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDVwVERQM1NqRFlVc0ZqbXFMVU9Fd1VRczdlWG9OMzhYT3h2TGEwQ2o2WWI4?=
 =?utf-8?B?SWpPaE45RHIzbEgreXpuN21wT0diMTdGei9uN2RGWTVWUWg3c09FWlBOMG81?=
 =?utf-8?B?dDg3dGVVVjNkc09xMkptQWZwc01MNzFoS3JZdkdPZnhCRldtVzJ4RXYxQU5k?=
 =?utf-8?B?QkRMQ2FoVmtsSGJ6UmEza0xhWUw5YU0xTzdNQUc2clFTZnZZcW9SWFRDcFd2?=
 =?utf-8?B?bVBMZTRjLzY2aGRKcmZXYXdmTno4U29remdRbjNnZlc3OGRMTjJiNzRxMW16?=
 =?utf-8?B?L3ozTHZ5YW1CRWVDYzdQK2M1L0ZMM2xMdHhPczBGVTdpdnBzQVNYQ3NERjB0?=
 =?utf-8?B?RzFYdThVcnZSWE4za3h6bzhOaXUrRER5QlZ1ZURRZ1RPUThtRnNmUC9ZNnRN?=
 =?utf-8?B?R3lHVE5PWE5lbHNDVnpuS2dSUEJTSlBrNmZmdERHclFxaUVRa3ZjSU9SQTg5?=
 =?utf-8?B?QlROUDdaTzR5VXlTVUUvTDB2c3lrVjdrc2hKdU1TcUNSa00vbWdVdVhtTHFT?=
 =?utf-8?B?alBOei9VVFNNcTlYS1hXbEU4V1I4QUJDbU1zeDdLSXJ1MkQxd0tBRXZpZUQr?=
 =?utf-8?B?Wm9xTWJxdmVrUENRY0VLdGhpak5oY0dBOGZxYWoyKzZYaXd5dFVQWFBuQ1hh?=
 =?utf-8?B?akt1ZGpMZVlObEQxbkx6Tm5vZWE4NHNNalBSazZIM2JhMDBOanJkZ0JaTjFi?=
 =?utf-8?B?dEpnc3VCOGRMcG54VFlGZ3NlQ3dRMTNSZDlvc1NvcHlmd2IzNUg4eENzSG1E?=
 =?utf-8?B?UVRHL1owWGNJZ2R4RDhQUm94K3dDcGJuZjRjWVU3OXE2MGxrdE5sZmZxMmN0?=
 =?utf-8?B?ZktrWVF2ZDZDV3kyUGlUUFBCdnkyWHNCOW9JZm1zZzNyaS9yMVVveXJYQUZs?=
 =?utf-8?B?TkZmd3RTYzFQajBEQ3ZNbUdzM3JoNE8wb0hUWnJoMlZDcGNIR2NzeXhvUSsx?=
 =?utf-8?B?dnZNYmpiSnp0NUp0Y2l3c1FBdlRPUlJPeVhuTFVZaWc5R3dkSzR6WkkwUUU3?=
 =?utf-8?B?VEpMTlpHZkZQWmNXYVJYeWROVEVvTDJSaUVVaENwN0dGc3NWNStoTlFYTVdN?=
 =?utf-8?B?RFJ5UjN0K25pc2dQUXEvcW9xS3FneEUzb2JCMThSVitJajNRdktXSEhaUUxH?=
 =?utf-8?B?QzdSRTFkV1dTdHJRdUVFWEJwN2t6eHM3alVpeDBpUVJJMkpDUmJUdFd0dmls?=
 =?utf-8?B?RmVsQ3cvbGpBTTliRmlCRXg4RDcybGpNS1ZtbThhbWJ0b0tFNGpoVXVFalZz?=
 =?utf-8?B?c1BjTGlUQytiTStCQ01KZWNnTXJyK1FjOHBsN1RrY0NIQ2dKVDEwVWUrTHRN?=
 =?utf-8?B?NU1oM3JyM1R5YjQrRFlicnhMWHYyMUZDOEhrK3ZqMWNIRWp6R3BpNUFVRDRm?=
 =?utf-8?B?dEpRbXc3Q3MvNHptZENGbCtJNjVydysxbzhVMFJwSFE3eTF6aG81VjZpSDJX?=
 =?utf-8?B?VUd1a081T0FtYkJ1UGZGSGxQOG1DTDYxNDRTUzBCOG4rWVM0UEk0L0dzcUFS?=
 =?utf-8?B?QXNGdWZtV0RySyt2UnRMUENjM2VzaVV5WW9QenRZQ3NoYkVRUXErZXdJVjE0?=
 =?utf-8?B?SDhTRnM1SGZ4bkZXRTZRbkczaWY0NlpPdG1USWl1VGwvRnpBaXlUQjcraDg1?=
 =?utf-8?B?dG4xT0ZrSENLSTMvNktWaWdvZVBGZFUxS2UxWWF3RzRNQmhHMWl5QTFVMUVm?=
 =?utf-8?B?aGhpVStKd1Q3OTVCWmxWN0hCNkQ5dHFEOGkxeXVRbXZWY3NXYWtSNENuYnd4?=
 =?utf-8?B?UmFNZ3dOTjBaOUhyUmVpVFhUZnZrOWJvYnNCMDcrcERLdGwyZVJvNXhEa2ZK?=
 =?utf-8?B?TThHS1lhUUF5WnhaTHZBdTVjbitEM0pmaFVSS1djVjUwWjk5SkVZMEoyaEVy?=
 =?utf-8?B?eUUvbGJucGE0ak5UM0lJYzJPam91MXdNdFlMUkpjZUF2bXpjbVJncDRXc3U5?=
 =?utf-8?B?WGVjTkw3SWxuZVgrRFhiS0ZGSzRKL011ZEZHSzNkN21Od0NpSXpLbkU2bExW?=
 =?utf-8?B?ZFQwSmFjcjhycVIyT0VHRUVndTJoWExZK09PdjdJQXdSbi96bWpudWhzYjcy?=
 =?utf-8?B?U2NMWHhLREJhbjE3aXkzdDRHOHVPdkV5QkRiMGx1RzhCdGVxd2ViNUw0ODFC?=
 =?utf-8?B?V0ljMHhCb2RhUHNDVEtBYnBpeVU3WGVEVUlycFI4Q3F5V0FVOFhBRThjZHln?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f19e1f57-5308-487d-c6d3-08dcfd0cae17
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 20:10:08.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6HwKXjt9wbHe4r0LGSyK6jtwfT3azcAz6b4sBexYXqbRhGvB+FX+trHbRJVYXRdEJaDGbvHuYHwPM37fPGzh5HhUWQHHS2lFvZWY3bXZNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7976
X-OriginatorOrg: intel.com

On 11/4/2024 10:34 AM, Chang S. Bae wrote:
> On 11/4/2024 8:08 AM, Dave Hansen wrote:
>> On 11/4/24 03:16, Borislav Petkov wrote:
>>> On Tue, Oct 01, 2024 at 09:10:39AM -0700, Chang S. Bae wrote:
>>>> +static inline u64 staging_addr(u32 cpu)
>>>> +{
>>>> +    u32 lo, hi;
>>>> +
>>>> +    rdmsr_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &lo, &hi);
>>>> +    return lo | ((u64)hi << 32);
>>>> +}
>>> A single usage site. Move its code there and get rid of the function.
>>
>> Yeah, and it'll look a lot nicer if you use:
>>
>>     rdmsrl_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &addr);
>>
>> and don't have to do the high/lo munging.
> 
> Oh, silly me missed this function. Thanks.

Okay, I took another look and found a similar case:

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 0f04feb6cafa..b942cd11e179 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -73,20 +73,17 @@ static unsigned int acpi_pstate_strict;

  static bool boost_state(unsigned int cpu)
  {
-       u32 lo, hi;
         u64 msr;

         switch (boot_cpu_data.x86_vendor) {
         case X86_VENDOR_INTEL:
         case X86_VENDOR_CENTAUR:
         case X86_VENDOR_ZHAOXIN:
-               rdmsr_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &lo, &hi);
-               msr = lo | ((u64)hi << 32);
+               rdmsrl_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &msr);
                 return !(msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
         case X86_VENDOR_HYGON:
         case X86_VENDOR_AMD:
-               rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
-               msr = lo | ((u64)hi << 32);
+               rdmsrl_on_cpu(cpu, MSR_K7_HWCR, &msr);
                 return !(msr & MSR_K7_HWCR_CPB_DIS);
         }
         return false;

I'll be following up with a patch to clean this up as well.

Thanks,
Chang

