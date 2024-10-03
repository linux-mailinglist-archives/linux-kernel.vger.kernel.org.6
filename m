Return-Path: <linux-kernel+bounces-349190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CD098F254
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3F91C21591
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6AB19B5BE;
	Thu,  3 Oct 2024 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2V9Ho5F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE8FDDA8
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968675; cv=fail; b=avgg6KvSCUG7JW/ZGTAiP2qLtVmG47TRClMMs5BKOp/XMuCJVI6Q/N+ujeNzselxQlQPslzCxRzVNPfLbvDPvQp/+n3OIm1+1Ri5KD9eSGgSx/8fRmML9FOB9/As3cALx/0vjaX+V6UTsgRamX/FHjwUPTsf+VlmNdEtPCDYMpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968675; c=relaxed/simple;
	bh=60jXuVsVkwEMQbzGDArBUKKV6BtjL0MBrxv3fwb4IRQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uWyopaN0UwaHauoMfiugSR9f4mVxYMEIEJJivCbIUKuXBopHlxTY8/zJkRwVHy8iCLQY3UF2cX1hSW+MICgmkYQ9dsOD9XW0Wu0WTyauKhPBeWj1vrbMczV+7Et4LNaaQ1TuPA76JqFhrFMtinXVSVKnfagK4et4dslTf07Hv7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2V9Ho5F; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727968673; x=1759504673;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=60jXuVsVkwEMQbzGDArBUKKV6BtjL0MBrxv3fwb4IRQ=;
  b=Q2V9Ho5F+3cD0b3AgB+bF/K3+x0U5NMKBOnoZiVJaMw2vpwjHMC4y++X
   ccvHwPY0Sb6uKKta9kYagf8OBn+Yc6Vf0pd2OuyFpLX/Ccf3mjrwEZ2ON
   imoGLhZrSOMcHcGoAGDTW09s9cq4sXUrGfGYBpcdP9K3bDS5VIAzoDqt0
   zEkoSXTKAiai+pXSFz5mOUqLxbQgoY6qQAIw0nhKpCvcjK9YIZtkrTjeU
   zqtQPc1HU8nbMhVZr2E+JyaKZAVfluN7oevoBAjgucpRcd9On3rYNn3hS
   OXUXL4dR1Kd/l2kopiTlVboi3NYmVGBzQ4JtphamIZ0TALKhG87LFNpZt
   A==;
X-CSE-ConnectionGUID: bkChzG51SH+ZQgdJCfo+1A==
X-CSE-MsgGUID: 5Lp0uH95SKW8FYk863eqgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27047653"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="27047653"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 08:17:53 -0700
X-CSE-ConnectionGUID: 7qpTd4z7RJ67hKzjZKx7Ug==
X-CSE-MsgGUID: Rhkpjp3HSVOO5buL5HeJgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="79233530"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2024 08:17:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 08:17:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 08:17:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 3 Oct 2024 08:17:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 08:17:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrk/Qiz7aIpQjbMaby3I35OHE5IVme1NmXXy1IR/GG0ooPXYC2wDAeScdav873bHpcx0L6j0Ib1+vybYxUcGf+5Uy8t/9bD38U7yC9njsPy+Ot6t3qqWDf+ZRtQoDBDnkjziQjI/de4k4AHxIgAlWSfhK1Ao0AoHSZdAE8lfAK9tPAVIXOZ9fC3RFTpvh2qtM2CCtDB7bg819mzKz0lZQbdIXjhV+0RECWlTH26ksKfRCSa5kUJBXyil+8NO8DeueFW7WEZcATJ5NU0s0DaerHJKzvKLDLWi443WsQPGZJawLHMSJMM+jkQEOLh3Jefn0eUyBAFBG/9eohpOKUgnNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnEj3GHItUjFIvQM/aZEZ2eSFXzI9j8vbitY9yT6HJQ=;
 b=uTs0OVAWqTvh2RbefZhp2GvGDX9KYMfHLPKZc+K8isoOUrMDKfsj4QaEFjdztm1cCAc/A7cK8lsJye749BkUtTVKCxW80JPk+ncl4ZWWzl3Brnku8bc2atd9kwhhhOJUpdykRUruY4B7aCGmhp09ICUX0nk3T2xve3DkdWVLE366RMENXglUsp3Y0aTq8ps3ZUeJ8ygoAAfYj5micyf/C+LQpNwICcCGNP6gemg5vgWBSOXJS+HxN47/In8tIoDUGO6Kz+mehWuMA3Ah8AAUv/C+GPMgvtbiYCrrpYa1UbqVVr2FF6WOsnHmQ1xtZLL7hHIZDVRQBpmOArh2VEtf+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB8091.namprd11.prod.outlook.com (2603:10b6:8:182::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 15:17:48 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 15:17:47 +0000
Message-ID: <5b49b43e-f94c-4294-84a0-ebc413223dc1@intel.com>
Date: Thu, 3 Oct 2024 08:17:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] x86/resctrl: Avoid overflow in MB settings in
 bw_validate()
To: Martin Kletzander <nert.pinx@gmail.com>, Fenghua Yu
	<fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <a8c3ef3e3d35924781280064a9f8c7dd2ee60565.1727782826.git.nert.pinx@gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <a8c3ef3e3d35924781280064a9f8c7dd2ee60565.1727782826.git.nert.pinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0252.namprd04.prod.outlook.com
 (2603:10b6:303:88::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: d15adbd8-830e-4ba0-001f-08dce3be89d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aml5aytJWUg3VkRKbkkrOStHMldoeWt2YXNCTFlod1Z2eVgwSGlzSUlUZEhQ?=
 =?utf-8?B?UXc1UVVScXFJUHhFTjNHdFFUSUxzakNPSitiUHVJekFWbzRHZlZRVmlTbG1p?=
 =?utf-8?B?Z1RNNGdQSHpvSy9CRDV0REJ1ZVFFWG83QkJoT0VjL0YzWkNhZldsZVlZOXY4?=
 =?utf-8?B?OUNLMG0zSG5YZFFLMytQbGFieUx3TnFuVVNQRG9HM2JRanJKY3dBRVptZ1Nt?=
 =?utf-8?B?YWZxMWpRSmlWQ1BVNjdZMHZmQkd5UFJtTittTzVWTnZmZG8wcGM3dVFLMUF4?=
 =?utf-8?B?MGd0SXdWaEJTMXFVV1ZIdDFSdmJqNWQ3ejN4TEM1Y3RhWnZYS211MC8vTXhN?=
 =?utf-8?B?V0Myb3p2NmMwMExGWWxWMFByRU5pWUhlcHdiVk5welh2RmFWVmRZSW1NMkIz?=
 =?utf-8?B?YlZXcHZyajZWd1RaUUZVUEdvbVBOaTRGN2IvMm1kQWNydFZ4S2I1STNzQi80?=
 =?utf-8?B?VFEwMm1lWHFpNlVZVnh4bHo5UEVMOFgvenBZTXNxOEhOUENZQmJ1TWtQZzhC?=
 =?utf-8?B?dVY1NHR6SDRYY21wL2FWU1YzWHdrNXRHRUNaUmtmTUVUQWdxS2xWa2JJRVhw?=
 =?utf-8?B?aFBtR3U3bStGRU5jcy9ncGdJam9tQ3VnU2tRakNUV0pocjJSZnZqK3c4RXRP?=
 =?utf-8?B?NGMyS1hRWVVIZks3V2YrNjl6QzRWMDJ5aXBsWDllQ2ZFb0JmakV3UXhXRmZi?=
 =?utf-8?B?ZlVhM3dvQmg0d2V0anI3YWdpUVV5bWxMMUE1dVAwUmR1WjdUY1dzRkdnRWpK?=
 =?utf-8?B?ak8vbzNJOVZFREZhWTIvQW9XWVJUempMSFU5MTJLVldyRFMvNzBpZWVBQ2dx?=
 =?utf-8?B?aVhZL0xzQjQzbFpGRU1jS0J2cWNCcHVqRzBIU1YvZS92YUs5YUdiUGhDTHhT?=
 =?utf-8?B?Z0ZIMldiSHRNbFNLYlROdGZ1MU9oVyt4bGFIYVF6cXBDcmYrUGVORnF4Y2xK?=
 =?utf-8?B?cEpuSW1MQjFqVG5iY21Ba3lFYzRrdkNtekYzWUE4RkRtbUhwWTh0ZjU1eEd6?=
 =?utf-8?B?SDRHN3ZuTUFqNmViVG5rZVZKaWhEU3hqM3MwVGFuTVJPVHFLNnpJMkVnTllv?=
 =?utf-8?B?R3JoZ3ZNcFNOeFkxdjRmNVRja2dObURra2FUb213ajFkMm1LTU1jS0Z6Nmh6?=
 =?utf-8?B?ellORUtxd2hVaGZWZDZsVnFZeTBnL1NUc2VzeHdPSURxaVp4L2ZaSi9hNW9V?=
 =?utf-8?B?MFdXdXJGTkNKaDNielRnYnZrWklrL1JIT0YzWXpvSFVIeU8xaE9ualdVYm1E?=
 =?utf-8?B?bWhmajRLZVNpdkd2UGV6TEozV2hYalhnR1ZZcGdqNkwrRTV2Z3RxaElHd2tt?=
 =?utf-8?B?bFRia3dNU3Q4b0lQQWpLeWZ0RGZWYTlDVmVaODA4KzBaL3cxVUFodkp4VEhn?=
 =?utf-8?B?eERia3B4dVVIVmQ0VzB4Ym5pbWV0YXFuWXVyekdnVWNZSVQwS1dkbERVRFVx?=
 =?utf-8?B?Q1UyTE5IUWprTnQxOTAzL3FnOU42K25iNUp4ZjdMV3JyOE9kNkl4YVZuNWI4?=
 =?utf-8?B?R3c0b2VnYUVVQzZ1TmEzWXR0TWRob3JwRkZPOWpJdlBuS0JEVHRIalNwZ0VC?=
 =?utf-8?B?bjNjd0Z6TUhsYUxBNWtLZ0ZkbkpYR0oycUJ6bmt4cW9TTlhObm9YcHArbjZm?=
 =?utf-8?B?empiRHVHTVpubFM2bzhjbzdYdWp4RjM3M3pSTkkyY3hLT3BncnpLb2ltMnhF?=
 =?utf-8?B?NE0wVFhWMXZKcm5hN0xJd0dpR2gzNzdnY01SLzd1RllzTmtDVmpsb3hRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODQ2VUpIU1ZDT3NHWHpZYlYycmZqU0ZxWDg1OUtvemV0TXIzbmhNZGE1UTQ1?=
 =?utf-8?B?TWJMcWY4d2h5YjM0ek9CNE9kV0tCR1J0UXRrdlV2eWJ5OFEvOWlnZksvYVR0?=
 =?utf-8?B?Mk91czlMY0hBWXhScVRWakZrOEpmbUNnMzMrOExqN09zTlNtMU9ERDF6bkRM?=
 =?utf-8?B?RGtwaElXZmdIZ3dvR29xV0JOVklFQSt6bTU4NG1MT09DUkxZcFFlTG9kdFBk?=
 =?utf-8?B?dmV2WVI5VnpDM1ZsTDkzQm5NeVJxc1M1K2VDRU5pSnVOU29UQXUyRFB0YWg4?=
 =?utf-8?B?SDQvODVqaCtkUldsSVhBRTB4UnNkT0dXY241VW15b2ZmZUs1bldZUXVLa3NC?=
 =?utf-8?B?S3pCazgxbm5HZXJ6TTlYUVRXUzUwZ2hQV0ZuR3JiQmxzQkFWd0MzdWZNMWdq?=
 =?utf-8?B?eUQ3V0tIbTdKRXQ5eWZ4NkhZUDVlN3VZSE5KdTBYcGk4V3k1VERZVlVGYUxp?=
 =?utf-8?B?YkhCVGdkMGN0QUlrbHJubEtDL1pnTzBVTWNQUHVyRnp3SnNYVExEa3FJYmpP?=
 =?utf-8?B?S25RSmpubkRYU1IxZ3BlRG4vQTBHRU1aZWYzcFRYS3doQno1U0taNDFTNW96?=
 =?utf-8?B?VUhqaXNoNmRjR1o3RXRMV0NoWDZyamVGYlJCZlZkcU42WkYvT1FMeDUraStz?=
 =?utf-8?B?dDVVc1J0TmhzNTFya3dPbDVzTlRXQlNCNnJBUzdLU3NiWVl1MU9TemRWbmtp?=
 =?utf-8?B?TnBtMWlYU1htNHFaM1hQR1R2TzJUV000KytubE0vWlBTVFczMExvZ2x6Z2NZ?=
 =?utf-8?B?eUVIVUcyZTlIWTg2ZWZVQmIyVVAvSE0rQUVoU29qR3VYZVRxdGg0SmV5QUo5?=
 =?utf-8?B?UzJoZDV4NHg0TmdKZTUrVkJkbEVSRlh5RXVTM09KOW5xekJRWEQzVkJPdGZi?=
 =?utf-8?B?bTFqMkhPT3JqSEFsYXY5aGNSb2U1VDNrc0srMmZVeTNQamF5akczRUlCUGxI?=
 =?utf-8?B?RUM1RVBiTFBKazB3Z01YM2srNEpqQzVWZitpTWlYOGVrcWpjbFE3VU12WVAx?=
 =?utf-8?B?L2dNcGVVUjA0VHRqby9ITm5QejhtTlBkUTBoaExaQ1ZFVU9Vd1Y4WGpGUzNV?=
 =?utf-8?B?NllwRHFpeXdUOXQzZ2NQN1YybjVraWNiUXZ3N1hOSDY5OGozTE9rWTNxVEhJ?=
 =?utf-8?B?QkdHTWJ2SWFBQWQxYkMrWVdaMERLbHhRSjhScWRwcnlvL3JGODhNemo0eVY0?=
 =?utf-8?B?N2tjajNEN1p1KzZPYzNIMUhzUUdFM1Z1OEpZTEp2UVlGeXMvS3RoSzVKdFBX?=
 =?utf-8?B?UEEvbGJQYWMxSjg5WExiNUtUS0hoNGFIRHp1Zi80MVVsNnNDUHRMYmNCNXRN?=
 =?utf-8?B?eXpDbzBXMURFREcyMXphc0Q0K20zbHJBd0xTS2pvN2w4NnFMdkNFZ3BUVVln?=
 =?utf-8?B?MVFuM1EzMTVOSVhDdUtiWEMvM1BIRVR5QWdIQ1p3KzNWYU9nRUJnaWlUMmFl?=
 =?utf-8?B?RkYrd3IwWVpDeno0aG9HQzBSREtCWTl0WE9ReW55azdONndyUWszTXNVaE5l?=
 =?utf-8?B?Zk5qOG1kUUowczJoTHpYRGVpdnF2TnQ2SnNJdkFSRFVRRHg1MTZjblZVSzQ5?=
 =?utf-8?B?ZTBsNHd6SXJPS21meWNFZGpZcmpKSStwR0s2bXJEbkNacFROY3Y4R0hDRWtI?=
 =?utf-8?B?UURKejg2dG9BdFpwS0JqWGl0L1M1TEJmZktRZ0pJaDlxL0xDQnNBRmNLL3dB?=
 =?utf-8?B?MW1URW05TVl6WFU2ci9WQnBTZFh4Z2xNd1VUR1F0MTliOVdDWk8yNzhOQ20v?=
 =?utf-8?B?dkk5MGlYcWt0NkZoV3hha0FHTDZUVFRFZWc5YVJXb3ltamZsdXFlWnlxMDNZ?=
 =?utf-8?B?TVRVQkdZanhtUnJFYkN6YXpJQ0NNdVUydmYrd0FFTTllbUY4Q0lTMVZ1WG5m?=
 =?utf-8?B?SFBsUGhjS25wSW5uSHk0MmV1U0VLL0R1N0MzSENyOTkyVTF2ZW9Ja0xZN25x?=
 =?utf-8?B?S3hKeTl2RjlNQWE0ZVh2a1A2NUw1ejdsWU44T2ZsKzhQUSs5UTF0c2xITU5F?=
 =?utf-8?B?c3IraXFWRzEwTjRoMFBlc2xnUjJHbkxoc1FMVkhxSnNkU0diYU9rQUJhaU13?=
 =?utf-8?B?MzhTUXFkUGE3ckw4N0tHaEY3VHNuQ0taRDlHSEh5cFY0bi85V1BUSDFrNnNV?=
 =?utf-8?B?Vm1YRmwrU0lOT1JCTkZPRkdaL09OWGdvZU1td0lQV0Vuc1YyckE3M1loRjdV?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d15adbd8-830e-4ba0-001f-08dce3be89d0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:17:47.6574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAumBUguYd8l1AQvG+YcgYNfGF6JCYDVUB4rvEeiSEywSy7mjZbcTeu675gYenwncALScIKahC+hzfWa0JFr8jICxx5CP/fg3/usGCIWUxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8091
X-OriginatorOrg: intel.com

Hi Martin,

On 10/1/24 4:43 AM, Martin Kletzander wrote:
> The resctrl schemata file supports specifying memory bandwidth
> associated with the Memory Bandwidth Allocation (MBA) feature
> via a percentage (this is the default) or bandwidth in MiBps
> (when resctrl is mounted with the "mba_MBps" option). The allowed
> range for the bandwidth percentage is from
> /sys/fs/resctrl/info/MB/min_bandwidth to 100, using a granularity
> of /sys/fs/resctrl/info/MB/bandwidth_gran. The supported range for
> the MiBps bandwidth is 0 to U32_MAX.
> 
> There are two issues with parsing of MiBps memory bandwidth:
> * The user provided MiBps is mistakenly rounded up to the granularity
>   that is unique to percentage input.
> * The user provided MiBps is parsed using unsigned long (thus accepting
>   values up to ULONG_MAX), and then assigned to u32 that could result in
>   overflow.
> 
> Do not round up the MiBps value and parse user provided bandwidth as
> the u32 it is intended to be. Use the appropriate kstrtou32() that
> can detect out of range values.
> 
> Fixes: 8205a078ba78 ("x86/intel_rdt/mba_sc: Add schemata support")
> Fixes: 6ce1560d35f6 ("x86/resctrl: Switch over to the resctrl mbps_val list")
> Co-developed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Martin Kletzander <nert.pinx@gmail.com>
> ---

Thank you very much.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


