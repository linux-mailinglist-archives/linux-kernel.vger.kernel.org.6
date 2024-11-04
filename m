Return-Path: <linux-kernel+bounces-395393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7686E9BBD54
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A921C21080
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C181C4A2F;
	Mon,  4 Nov 2024 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M52BrDfz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5FE18BC37
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745307; cv=fail; b=e5mvSwZ61+m3fSUeB3PcJfjIsogYuh/GpQd6YOLHc3CyFzemO7NkpHyBoAd7UVUXJuurgrdGWal9UFVX5xcw1+lvo16c8+e+sl7AY60zVIeAZNig5+WERbzpG/eGZFGNgRD+N+Fy3kdHhpf3+hDpbjTND4ZZl4PtBh6iR8QZfwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745307; c=relaxed/simple;
	bh=3rmltyrIOOqQ8ds9I7RLKBSfClJXU90J6HsFF4S7UFw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IAVY+ze6FD05uN1vx4l3eRHNeRwNv1wJqjKw/j/0WG/Ni6msODBQty9BSKVYPYI2d0MpW2GJ/Kb4iy2xPkg8/GRm5ciZSUaseVdWNpGRUagofS414O2DSvNsFMQXZH5nj8CtdyfdGum69PtkwHltENs63YVg3kWziD1x4yIFlWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M52BrDfz; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730745306; x=1762281306;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3rmltyrIOOqQ8ds9I7RLKBSfClJXU90J6HsFF4S7UFw=;
  b=M52BrDfzJH4KDCauxasWqGjjJXlZWU+2pCpb2PyaElgvHi+wnJ5f4XF1
   e5HXAxF8qgk+oNHL/P01zmKN46Edkhdioq5eYA991LEc3lTGVMVEi5Oay
   kGRpgWAEAUb0usLhqqmFHWMIRTajfLE9yMa55P7mpWy5jleq48uWO9kMX
   xvYjzYB9TFXZsnM56scxadnVhzgZi7596n0VKY5WGpYBt+a4VVbYBU7Iv
   DwIiaWDUkIZyjKkivF/5JAoJtaNUG8bfGaXyWlMvB4umUAanCuqlY1t7l
   9YCO8wgHr3sQT//cQV82W04FG1cuu+3Fd5nNB1cEnTBwspen6NtfmHnaD
   A==;
X-CSE-ConnectionGUID: sEJT+n1CTVKDQsyEqD2Yag==
X-CSE-MsgGUID: dUx0dqbrT5CH8P7LSYeTAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="47966631"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="47966631"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 10:35:05 -0800
X-CSE-ConnectionGUID: LOycrQz5SpOuiwPavE6ZWw==
X-CSE-MsgGUID: 6KKrvRX7T5K0MylVJH42kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83624963"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 10:35:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 10:35:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 10:35:04 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 10:35:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2tA3NkibPeNweKVpzqd/CAJNs+1V/ruoqk/hsZmyZWWaPFlb6TjYtvVfTB/+HU3hczIsuoVlWhDpxCZY86urVUPTXP+WIKSLoJdxQvw4c4rKMHhMH4Y+IpywAFtPrG5WAC53JKqiDCRSi6M0nzleSMqFwSZYRNodh7m4p+MCmLHwz9eOMYGf8NhHD41Pv6hHV5i3EQiCgkiAALqGucQagFBhF2Af2bex0r6jY3fB+4S1daAGCGqeYKDZkroKxJYNoJCai+61ML+DEZOcCwiT6LQdk565aXRmHyzfqDqbrygTGJr+NbBNuHy+MCy3Dlu6FZDjNMQaJarD7W9BdgcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRXTNzFwbyNCB5ytDAwwBwc1TewR2J/KUjfOb98q/7U=;
 b=H4OOVFIgHPpQGTZCju92RjasMoVOA962XHG/VuEhSLeJkk+QndX4+kGLCsk78dPJ0s0QkPiraTW5+XmcS8LJs/QD+PKify6dUqTbcehdEsfJKHgJ0kpueWIyAP7gVJb0RzLM1L5ZKb4tRWHLqL+1KxLn4K2XiOIb1sOk6SiA65q/EnMQcoN0AKJYwiCcsfcWJlrVoJPwrNcrivQmg8VR9vQEh/prXfYxqv8G5LqHZMa4SkyzHO6MYxmUAbxRLMplTHMko+iJI9KuOIkSeq/h5SKXAsb9JuHIrEI4nrDoC3mu635yTqkeeqed3jN6LxtHwafHFaDs3AeMZT9Rsgg7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SA3PR11MB7654.namprd11.prod.outlook.com (2603:10b6:806:305::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 18:35:00 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%3]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 18:35:00 +0000
Message-ID: <e2a9d121-0505-4bfa-b2b6-6cee7b909aa8@intel.com>
Date: Mon, 4 Nov 2024 10:34:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/7] x86/microcode/intel: Prepare for microcode
 staging
To: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241001161042.465584-5-chang.seok.bae@intel.com>
 <20241104111630.GSZyitDuXnBYmEFxvo@fat_crate.local>
 <7d2e421e-7fc1-4ce1-9081-7765bf71f7a3@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <7d2e421e-7fc1-4ce1-9081-7765bf71f7a3@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0001.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::14) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SA3PR11MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 678751a3-f8bb-4746-6744-08dcfcff6394
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVNjWU9CZFlKd2JwOUFjNE81bnBBNGF0OC96U1NtL3lTcEhXanA4bHZrRWJO?=
 =?utf-8?B?VjR4UnBiaHBhb3VQNmV2T1NSaSswZk1qMFlpWE80TGtDT3BPQytvR3BCZE5H?=
 =?utf-8?B?U2ppcDIxSDMvUkRnZ1g4VVhZRUtHTUVFTmpUTFEzNy9lSDZWQktIRVBUS0o1?=
 =?utf-8?B?alFlL3YwVXBacWs3Zy85OVpmTjY1QUNqcFFGb2tkaldQWjIwdHA1a25jWmFJ?=
 =?utf-8?B?alYrKzRqTlp2QzhWODM3V1dKbEs2N0hJaTlmNzJ6cVVwUWpuakwvdG1MSitS?=
 =?utf-8?B?ZzFEUlUwSEp0cUlyWktUUkZEUWtTZzAyUmJKblU0SnNiUlcrcS9SWDd3NlJO?=
 =?utf-8?B?eGpkZ3cxb2dQWko2MU1HU21GOWxiSEF3STR6QlhiMnJaMXM1L3pLVVdzZlVP?=
 =?utf-8?B?Q3I5VjE3aHkwTk83eHdvcXcrc21Ud2RDUldqcFY4dDNKOWdXQk9acW8wRkhO?=
 =?utf-8?B?cTlDTFBqaUV0bWNRYmNXeXVNTWdPUFpFeE4yMG1paDNDMFZXZEVZSStjT3RL?=
 =?utf-8?B?emZTajBXM3NQZHRCQnd2c2RiM3VKUHF6UHhXMWh3R0lpVXJWRzRQaGluQVhO?=
 =?utf-8?B?OFVhQ2FPQTFSb2dRSEMvdjY5clZGV0tacFpoVkdjT2phVVJYS2VNdUNqZENy?=
 =?utf-8?B?bnhZNzVqdmV4L2t5ZFlPbUFhQUMzOU96cXNGdEpwelNPM0l2bVdkVWlUY0NN?=
 =?utf-8?B?QXVTN0VFVEMvNHVFNjZpN1ZDUmR1Y3NrOWUvNFlnWFVUNkpKM05tYnRYZHRz?=
 =?utf-8?B?ZjVMTEVwcHV1ZEVCSi9yT1Y3anFkdEhRT01CMGYyZUIxbUhTYTFwS29SWnBs?=
 =?utf-8?B?bXI0cFZsMHBYZ29xYnZ1ZS9JQ1p5N0tOR3drV0wydDRmM3UwWTlhNzk3aGZq?=
 =?utf-8?B?SjZ5cWJjQUNmTzRLdVhJOGxQUEx3VUNId3EzQnV3R2UvYUpHM1VHQkx5VjNv?=
 =?utf-8?B?dWdlTXpsNUp4SkJ1bTJzTmhOcncxTkl5b0UraUR4ZmJrUk8rYmNuSFB3RXhz?=
 =?utf-8?B?eVpTMzd5SmlJQnBiSUVWQ2QvZTd6dTJma0E2bXFTeGt6SE9NN0VuOUZoellK?=
 =?utf-8?B?Y0FkN29nU3NjWXhpWHNyRHk3bEp1TUg2Z2w3RkZybDJ6QzRVdlhVVFZJb3J6?=
 =?utf-8?B?WUNKalVKSmZsSVVTWTV0alphYTRPcnQ3a3hoUlV6dnh0dE1PRE9Sa05xU3dU?=
 =?utf-8?B?WUV3Ym9uNkNsRnRabnlPSUhRaU5MSkMwczZ3TVFnZW93NUZOYmZHcFc2UHNk?=
 =?utf-8?B?NkJOREFDay9SVFhnaUM1cGNWVmkwL3d3alVXMXBJZnY1OGFHK3FDZ2VDQWZa?=
 =?utf-8?B?d1J6a3MxWFQrRnhDQmpidytjdVhNS3phamZUajZFc1JXR095VzdlQ2U0ZFB5?=
 =?utf-8?B?ZHdjT2p5Z3U4OGNSd0c4OXkxbDcyaXBMbG9DMlV4YWRnaTkveFhwZnhpU1hB?=
 =?utf-8?B?aFNFeVZYV2hmUzEyYnQzZ1Yzb0t1cS9zd3VianJtMCtGRk1Odm0yamxsYWNR?=
 =?utf-8?B?dXp3enoyWThLZXp5S3pWTlR5alJ4R25wNVFJZFA0MTN6dUdYQjlWckNjQjFS?=
 =?utf-8?B?c0JTN256UEZ2ZVA1VmdyeUt3UVlFVWFPcHcxczlzNk9WRGZoYVNhNnRDVFoz?=
 =?utf-8?B?c1h4WERhRStrYTFUWGVaT3FEci9JY2xORFMrVHFyUURzNVR3amd1LythQ1lw?=
 =?utf-8?B?aWtaSzBBMDlGY3JOS1RUMHJqZzV0ZWd3Smp3WlI0VXpyTkRUalRISG81Zlho?=
 =?utf-8?Q?CP9VfMldBECAk5ef4+JlxLY9eP44AkmYeZI7x6A?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFQ1R3czbWpVaXNjNXlQTlRlMHB0c2VRdEJyeUhsQkFCaGtrVWNxOXY3ekl1?=
 =?utf-8?B?TmxqcFE5MUU5NlZYc2ZGdklzQUZwWk1FSGdPbFRtWFdWWTk2UCtRVkJzMzRk?=
 =?utf-8?B?R1dRWjhWVjcxOEk3cVozcGt0bko5R2w3cVhZVDlud1diZlorVER0cjNJd2NE?=
 =?utf-8?B?WFI1MmZMTUcrWXBkNHAyMk1lcDNYSHF0aUxlV1lIbENjcERreGIrMTlqZWR4?=
 =?utf-8?B?WFlxYmdMdyt4a3l6VnUyLzFIamYzUjZWd1ZUb0pnUWg1L05nZzNXOWVsZUZJ?=
 =?utf-8?B?Zm5KcjdwTG5yd29xcXN1UW1UOUFnZDdZMnN3UzZrVm9GUUtubWp0SjVwR0Qv?=
 =?utf-8?B?QWR1UFhMM2V3bHplS1NUU3hXR2NiQlh0c0x0UXZLcHpydVUwOFVZYWMrWWY5?=
 =?utf-8?B?dXV2Uk12R2hEd2RlampJbEs5NXRUbWJabm1FcTdxRzY3RDUycHVUWWkrUi92?=
 =?utf-8?B?c1l1QTNPdlBjNVB1Nmkwc1plTHJ6eUJua200SlF1YU5DQ29NSDJHRElkclpH?=
 =?utf-8?B?SUtJb0ZEVEpvTGx4RVpVOWFBM0MwNEtxT2pDbC9xT3gxZTBJRkFXMnJIb3hv?=
 =?utf-8?B?QWZhek8xUWdEUHkzZC9pRFI2UmxXTi8wc0R2bDh4RU5PRklFbTdYU0pKaTVl?=
 =?utf-8?B?c1UxOTYwTEk4WUFpNmVrdGRkNnp4TVUrL29aeFM5TVowRk5BUWZXbllJbU1s?=
 =?utf-8?B?V2lzT21jeHlxS2c2RlpIZ2p5VnlDa3dGTzR6M0FILzdNaUM4WjJ3UXBoNWcr?=
 =?utf-8?B?SFhQUHVENmRxUlE4NDdVaXV6d0I4S0VZd1dxRW9TN3k3NDRaYUpyVDJMa1pK?=
 =?utf-8?B?ZmZUVXJHVTJrYmpQOXhzUHJLbFVrR25zZGdZbDladFNJeGl6Tm5xNldhQnlL?=
 =?utf-8?B?Uk5oN2JpTGU2b1dJK0l5RU9pYzU3d3QxVGlPSktGNFNlc3VhelVGZ09qWEZT?=
 =?utf-8?B?ZGVVL3gzYzZTd1VaVG02dGRsRGlweWpvamg0N2NXN044WStOUHZkZW1wc2NT?=
 =?utf-8?B?YmpodU9VZFRGR3hNNU1TUkl1aEd0dGlFSUQxaFg2anVLcFJvVFZxM0RwQzhO?=
 =?utf-8?B?QUczV1lGUUpsM2J3d2lHSmlSUTZhTW1WZ09wL0NqQ3QveXUzRFpkMzhoVVR4?=
 =?utf-8?B?K0tJaFVFR3JSTFM2VFc1VDZZcExMcEczMHY4Y1J3T3dBWXowK25aRklCYk1Q?=
 =?utf-8?B?NjFVRENKT0NLRktBdnM4d2xGWmF5YklFanRaOStiNlRFNHdtd2I1am9HVGxE?=
 =?utf-8?B?czZsZS95dk05OG9OdWQxOEVnUTFqWmZmcjdMcWhYdFFJQ3ViOHhubWM4eTdK?=
 =?utf-8?B?QzMzY081cGlZRWxSTUxITVR0aGVyUGtDSm1OUmtvQ3Y4ODRtVWFjOXFtay90?=
 =?utf-8?B?V2JWaDVNSFV5ZVpGZXF4Z09PTDJ4SjVxVGlMcW1QOEp1VlovMGhSSEZYcVBs?=
 =?utf-8?B?TG1kNmF3a0R0Yk43cmxtdmhRSmlTVHpkYThRYUQwNGQ0VTY1VFAwRkxVd1Rq?=
 =?utf-8?B?a3BaUEtkUGRmYVdRd25CZkIwYldYeEJGNkFLT0pxTUxMak0yVmd4QU5pSE5M?=
 =?utf-8?B?TW1EeU4zcFVZL0dsenFocFVWK0xLMGdKREozNmVZNEtnT1NLV2VHL1JIOUtp?=
 =?utf-8?B?eUxISXBzSzhxM1Q4Mk5KOXpvWmhtSmFuM2tNcncwVU9zaXJ6bjRBdXU3Z1d5?=
 =?utf-8?B?R20rNThXdGtzaHF2ZTdQVFJkSmxYanE2Q3QvRVZ4VW1jd1lnRXhud2U5cHBY?=
 =?utf-8?B?RW4xMDlkWnpNaUFRZ1E1cHYremdlZitZUlV5ZWJRUkNVWW9hUUthRDhJR3Nv?=
 =?utf-8?B?M0IzeGhaa2QzUHNRb3pPbVN1ZE5yOWdMajF0N3Q4dy91Z3VPYU9yUVRvY215?=
 =?utf-8?B?SXRYZ21LYmRZOStFbnNtSEEraHhqSnpHNXRCOWNHdGxtRHRRWTFZSUxrUHVF?=
 =?utf-8?B?bENiM1hkMU0rbnFYWk9LeUtINGl0SzVJU1MvZE1vTTRPTy9SZm1DZFlGTnk3?=
 =?utf-8?B?cEZWK3g2eUY5eStKMVRTNVFObUJVSEwrYytvM21Ec1NRSjQwREUva3hYZlhl?=
 =?utf-8?B?dHF1bFF5eEduUXpDRXNIMmVpWW5PTmlSWEhQMGhPTExQcEpkUTQ1MDZ1bWJz?=
 =?utf-8?B?WGpvNC9TMDF6VzRwd0d2eXM3MTNlODIwdHE0aDl1UC8zc0d3Mk1mVjFRL0N6?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 678751a3-f8bb-4746-6744-08dcfcff6394
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 18:34:59.9848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLV/myXptHwf5gPnl60SDb/3YRFTAVS4pm3uaw/LtYUDpa4tFzwh6QB0DdBHR40swG32J5NLbdQaSK3WcleXkkFP0x/J+00dZmTNG2s149o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7654
X-OriginatorOrg: intel.com

On 11/4/2024 8:08 AM, Dave Hansen wrote:
> On 11/4/24 03:16, Borislav Petkov wrote:
>> On Tue, Oct 01, 2024 at 09:10:39AM -0700, Chang S. Bae wrote:
>>> +static inline u64 staging_addr(u32 cpu)
>>> +{
>>> +	u32 lo, hi;
>>> +
>>> +	rdmsr_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &lo, &hi);
>>> +	return lo | ((u64)hi << 32);
>>> +}
>> A single usage site. Move its code there and get rid of the function.
> 
> Yeah, and it'll look a lot nicer if you use:
> 
> 	rdmsrl_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &addr);
> 
> and don't have to do the high/lo munging.

Oh, silly me missed this function. Thanks.

