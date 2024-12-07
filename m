Return-Path: <linux-kernel+bounces-436026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2189E801B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 14:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB68166D32
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 13:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269A11465BE;
	Sat,  7 Dec 2024 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nf3uMXhp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952F4BA49
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733577300; cv=fail; b=O3wMYKJtBgV58vqdJs21gVf81d1A3hCHUwQHBnqj4Grb2Lzd6XSJYRbqNRCavHAmdVaDZda+qtYQwCp5RQeBYKmnlGj6nr+f4Q+sXKM+0AKlS9YczD5or8hovXBRmI258hF5F3dG3JBD0KwCrLDzVSQf12UXjUHNi+VrdATm2Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733577300; c=relaxed/simple;
	bh=ffwzAurpGwqsOrLU0t7H7ZniG4E4/w7W6p4uumRocvM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tDalh7CLUjVBS94BqFL4J0QDghMg3wIOyWWuLYyiPlYvWcZIQCvANRD2QyX0aQrR9Pj1bOSZbW2GiaLEACy0DWb7PokcFRqKrju1TaQclAQYKvZr8HhTrWteqC29FjBbYv139DaFLaRX3gsaYRUWgnw0IIS7BCqVzF3x95eZlv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nf3uMXhp; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733577297; x=1765113297;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ffwzAurpGwqsOrLU0t7H7ZniG4E4/w7W6p4uumRocvM=;
  b=Nf3uMXhpH7VAz2mTHXEO72A1jWpsPqryb0wkbrk4AECemdf06yC2vl/2
   HIowyx28HQ1rMBuOkhN0I1Rv7SfFFl+DOehrLYQOOPaK7plbz3VnDqIcD
   /UYTqmo7u8BdXTuVa2Y096ZoyxdFAKySLo1GZTqUT+yjf+j3vylALxn11
   ze/TWV2KzeoGOm+1DgyCtHCuisCqK8nx8e97ivxyDGxqo+NOuzO6DubOb
   6xXXDEmQyKJUDupTMvL+xThETIi9PF+qwkkrL4yWZlXqI+zmajBS0KlWX
   CMlnTVXYajDzF50rgdVECmjJ2kGyGSQ61/LAVahjWW3LaVsxpc1+IV82k
   A==;
X-CSE-ConnectionGUID: 2bfN3R/OQT2x4axs797sxg==
X-CSE-MsgGUID: IRqQJKZrQyuk0O2/1c4AQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="33850932"
X-IronPort-AV: E=Sophos;i="6.12,215,1728975600"; 
   d="scan'208";a="33850932"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2024 05:14:56 -0800
X-CSE-ConnectionGUID: G5dtEdVqTqC8nuckw+ObNA==
X-CSE-MsgGUID: Ar/kFpFjQNedrgHI3fysig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="99688973"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2024 05:14:57 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 7 Dec 2024 05:14:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Dec 2024 05:14:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 7 Dec 2024 05:14:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIZAWk5OodFPnlIacLzvCGl53K4d5iR/5yUHV0ZdRfw9fdnA9qOldJs9NEGSzADzw58Q0sF9t9vAx9f9SlVOxv+RIocV2cVPVz/Bn5qbuuc5+kqpsGErkmxJQW5QPeThrlLuaso8Z0KvibYWJf0ZuiExvMzwH8cRvo436DBwR8d1CrhntPxqytXc5/Lmd6aSZjoz8tRyIPZ7ua3Tb5OU9oSk+DjILnCb7LTy12Njp5FcEQTNqNC1LP2/sgM7p3m2oVwyfejbVVtVAaOkD8S9L+0gTkkjjnbJJkOb3OTlAqaFGpNivi4lcAZX2AFCG+gZy2K6ORX82vgrlj0Fp9m3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhK/uoxQovD2XHizJiLbWjRlHOxE9TIyta5x8UW/s+I=;
 b=Yu5DPctiS+5zrTpz7G9mgjExF8WJApmGyXK7HT6d87tKx6jnwGO7lMiAt+ai6UwTu8H7C1V9MncR/7W58ySXUtxC0nPZoWksxjZRDxTr+LTDuI74cdVKihVS1VtaMAYuF4Y80uXMuzknHXssWNswcOKUGKvnQyco0mUxpwDiV3f10wTFSr+uWYFLFuM5mQac+TxlcYR8yuF5AAKzBJRnBaH4GHfH4TwDlz54J3zyYDGqGvolz0UAK7CjR9MtpxTfzyt9JAYddMFiUKc8qmqyLJVvhDIrqDSCOWeNpwSPZhvYWNfPzFrBpYlrH+2Ebhm6ZOPbv+WjWuwmckCGdvDSag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB6495.namprd11.prod.outlook.com (2603:10b6:8:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Sat, 7 Dec
 2024 13:14:52 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%3]) with mapi id 15.20.8207.020; Sat, 7 Dec 2024
 13:14:52 +0000
Message-ID: <6e74f535-895d-405f-8048-ec89ddeefef7@intel.com>
Date: Sat, 7 Dec 2024 05:14:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] x86/cpufeature: Add a debug print for unmet
 dependencies
To: Ingo Molnar <mingo@kernel.org>
CC: <x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Uros Bizjak
	<ubizjak@gmail.com>, Sandipan Das <sandipan.das@amd.com>, Sean Christopherson
	<seanjc@google.com>, Peter Zijlstra <peterz@infradead.org>, Vegard Nossum
	<vegard.nossum@oracle.com>, Tony Luck <tony.luck@intel.com>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
	Eric Biggers <ebiggers@google.com>, Xin Li <xin3.li@intel.com>, "Alexander
 Shishkin" <alexander.shishkin@intel.com>, Kirill Shutemov
	<kirill.shutemov@linux.intel.com>, <linux-kernel@vger.kernel.org>
References: <20241207004126.2054658-1-sohil.mehta@intel.com>
 <20241207004126.2054658-2-sohil.mehta@intel.com> <Z1QI6UukVy9uJLrs@gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <Z1QI6UukVy9uJLrs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:332::7) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0a6071-488a-4e66-2704-08dd16c1227f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VytmU1FzdGNMb0JYeFViekhwN1dBcHlNVWJsckx4Wm9SVGFERzNva3lCRVJY?=
 =?utf-8?B?Z2tDUGcwUGpYemI3YWl3VEQ3djFTbXUxOTdzUlpjTkdMaEprMzZPTnArS051?=
 =?utf-8?B?ZytXOU1wTjZXejJnRWVPWTBzSkJ4RmdwV3UyMDBnL2xlU2lJTVkvTjMzT2hn?=
 =?utf-8?B?blFYdVFUOEx0bnVldDVDVFJJWVY0VTJBL1dERmdvbXltdHBmMkxKYnE0TUNj?=
 =?utf-8?B?R0MvWTdzRHQ3VXdQekhGRVAyYm1UT1ZDK1RkK29mM00yU3BiT1JzRVR6amNr?=
 =?utf-8?B?REhzcWFYT0ZIaWthcGZuTDh3RjNyeHhhT25GSURyU3RkaU5EQ1QwaHhIU3p5?=
 =?utf-8?B?QlVwY0Y5RElJc3FlUHBSbjhsUUZuUThES0NrZ1lMREJTV2pWMTQ3ZTBNeTFa?=
 =?utf-8?B?cmNvRitEaG1kQmIwb1JQOWtTZzdETnBYbGJtcHZVWkpMeUtCYjJidUt4ZFoz?=
 =?utf-8?B?akhDMXF6bGNnRDJhUDEwRXVpam0wT2lianYzdEdseW80VW4zeHAwdFMvZmdh?=
 =?utf-8?B?Q0tWVjBsRC8yNGpjMXdwL3JTSFpvZTFnQW5wbEI5bUxwbXJ6RHJFelViTisw?=
 =?utf-8?B?Z1o1WUdHSENxU3pRazljWXRvWXdudHBKVExReFRUNzR1MTlNZDRkWU00MVlt?=
 =?utf-8?B?S0RKd0VwdFF0TlhkZG92NkNhWktsL0E4Uk9INTVQOEJ0U09iRERqSnlTWjlW?=
 =?utf-8?B?V2RxQWRUMXhkOVppTlFTWEhWZEMyZ3VZa2VIaGxiS0RvTDZJQnVhYXhhTk5H?=
 =?utf-8?B?UnRTSUVCRDgyNVlWSzZDbXFYazhOV2pxd0xUdGU0a3E0NkwvYXZBODhOeFNZ?=
 =?utf-8?B?R0NPNEVic3BMSnN5YkNFeUd1dU5JbnZFTEZmM3VWUE1ueUUvT0pPTW9qMlVL?=
 =?utf-8?B?UXNTYk9tcVF1aTNpMTBnSWowOTdBY1pZUjRuemhXQUd4TDlHQXplZTNSeXMz?=
 =?utf-8?B?Qit5c0MvbXYzd0c0L1NHVFQ0amlLR1JNK01EVG14WkFBRnJBbytBeFFYdE5n?=
 =?utf-8?B?U2hXblZMZkY4bUJrVFNwYjJsUTNLUFg1S1JQWENDSmFqMWMyRVc1TzcvZGFD?=
 =?utf-8?B?b0N3YmtOdmtGVTZrTUorOElDYmZxZlV2L2E3MzNJR1pBR20xRDhFZnUwMi82?=
 =?utf-8?B?SnZRTFV5OGVFdWNFVVFyc0tkaTloUzVGMi9sVXZpckhxcnNmY01Qb2IrSmpC?=
 =?utf-8?B?a3ppWloyN0xRWkR3SXZnT3hULytwRCtyMDgyQmtNU3RSaE5MQlZHa0lzSU1r?=
 =?utf-8?B?Y05EUS9zWDdCWVo3T0tUMERZRXFCcmg3WHdaOERrTHZXckF5UWx4K05YY2NG?=
 =?utf-8?B?RHIybjBXYVpIbkU4N2VLUGxTSHZrcXZpKysrVjg3eXV3ZGg0eGdaOVlCbjFz?=
 =?utf-8?B?MlRCakxrUWpZM2JmZXZQNHBpWU96NXJMY09zbHI3bUF0aThQTis4WEhGeVpx?=
 =?utf-8?B?UHZ1dmlmNzIrRmdCdHNZUm9pQnJ3TVMwQ05VcmVIYW5nQ1hpNi8wZUNRaHpH?=
 =?utf-8?B?M3lzNEZMem9JUDJuMXQwblNiTXlUMng3cll1NTdCTFFKYzllZ001MlZlVTJ0?=
 =?utf-8?B?bDVDcTlnSnRibFJpSFFwRFlqUjBpR2ttdzF5aS9aNDBwUTdrM2FCeUtMcHdz?=
 =?utf-8?B?NHB3a29tSCtxRnRLemhjSmo0Sm1qcnk3Z0tmODJtUitSYzA5U081cmJhTEkr?=
 =?utf-8?B?eWxDd2ZXMXNjOGl4ZGxQOHdkL2s1UnpsQUZiSVBUQVp3U2JpZzRzRTJwUFJV?=
 =?utf-8?B?YnBHYkVJUnJ6RmJDbkUvMzNxR3E3TUx2ZVZhUG95aDNoUElOc2h2NGlCa2RB?=
 =?utf-8?B?SElSSEVOWk02Qmk1UDVyUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnE0aEtkZi9KZVBBZDJpU0NRRHFkNkJVWUo3cW52ZG5hVERDV0NNcS90Q3JS?=
 =?utf-8?B?b1lCRUY5MjJUeEpyL2JPZ3RnR2FWdEdCRzF5bjR2NWl5bUhVWloreDhPZDNy?=
 =?utf-8?B?KzROOXdmQmZ2ZTVvQjhkSjFGbzdScFpXemFqQXRsSm50VEcxRXlCV1JDaVFD?=
 =?utf-8?B?QmdoaUdjNW1Va2RjdHdLUXU0SG1jOGdnM0ZOREg2a05aNW5lTWlYaXBhNlN0?=
 =?utf-8?B?QXpSTCt3Vzh0dHZxVGk3RytDMGZOVVc1Vldza0dCS3R4YVdERVRIN1Nid0F1?=
 =?utf-8?B?RHlEOVhTOEN3MGp5dUFzR3k1Z2Vrdlg2NDBBaVVSdm8vMUphYWNsWlBzOHNG?=
 =?utf-8?B?TTByL3VqQUJLeGNJcEpMZW5iZmxHclA4SCs4NkQzK0hJK2lqZCtNeWZWS2U3?=
 =?utf-8?B?N2k1OTlkNEJOUFRJVUdXVXd2N1ZLY2cvVkw3dlBacTd6WEc3a1RMUXlLdVp2?=
 =?utf-8?B?KzNudHZ4Q00vdi9sazhrZzRielhNNy9ZWGtWSGMvYUhJamgrb3EwazQwRlZU?=
 =?utf-8?B?YlltR0wxeDlYNWdnK0lWTG1nOWljNXpOUHJ4SitpMDZUaE9ISnh5dVZZYmhY?=
 =?utf-8?B?eHJ1MDZIdG0xZTFrZDhWVENPL1dtMjVxR1N2Q0VxM0JMYnZGREFiY0MxUFFM?=
 =?utf-8?B?SXR2S1hHTTM3ZlBtclFWVXdaVzhENzR3aVZ6Z2Z0YWE1U0Z6RU1oSitzWDNa?=
 =?utf-8?B?MHpFZWFsZFdVakJ3TjR4eEhFMXpHb09QQkJlM2cwYXN3MHEvaGNYaXRPVUhE?=
 =?utf-8?B?UTlhSG80NHF6TVhjcmNuUGZmYXRXSmdSRVZ6VWFsYWpDeWhKNmpNTHpibXc4?=
 =?utf-8?B?QWpobjQzaWt0YWNKR25iN1lnbzJVK3pOdEJIdlRNSUZ6eEdoWERVRkdZcm1w?=
 =?utf-8?B?cy9qNnFOK2xVTzJqYzdFWHh4MGQvekdwWU1OU0YzNGZoeHBwcXNZd2ZVYkpv?=
 =?utf-8?B?RTZnQ3ZGQ01vL1dITmhTUGM4UE9RNDcxVDdUZjA5V0dGN1dqbWxXUFF2anBQ?=
 =?utf-8?B?N1BQc2Y1bVBYZkNicXJQV0IxTVozRVhQZkhvKzZwSlZEWTJ2N3Urd0FCdmM3?=
 =?utf-8?B?VFI1YjF3WUhsWFlMa2ErRS9taHBENWNMaWRSbTB0OEpYcHQxOHFHd2k1c0Vo?=
 =?utf-8?B?ekE0Nk9ERGpRVTc1eXcyNVBqcnNaaThqYUtRWmlYRnZXWHFvNGwxZmRnQ2ZP?=
 =?utf-8?B?OHdNY2lXVUcvMWRUbTc4T0RjTy9jTFlyZnEvbmhqekw5U3hqTFVBbFNLckdh?=
 =?utf-8?B?T01KbXNHdUU1UHlvOEthaWo5TWFYUzUzclFQMDR0UlJXMHB3a2NyVUZZckJY?=
 =?utf-8?B?Q0JSTzR4d3FQQ2ZjU1hYc3BSa3d4RlFWd0tZa3ErUXdjMnhEUzhKU205U2lZ?=
 =?utf-8?B?alIyMlEwTFdrN2FXRVVBQklrZmxQZE9lNnNRcTR0WW8wTUVZVUFNMWs0QUxB?=
 =?utf-8?B?bm5JTndWc05iK3FRQkdFWEN3UmNabVlWeTd5bmRlZ2hNNXk2Ny8ySitLY3I4?=
 =?utf-8?B?dHRXb3dKeTJzeEI4NVJUSGlraUdwZGFRT1l0Yy8vY3o0VzhvdjdRWExpcXpr?=
 =?utf-8?B?OGFESCt4SE5xZk85WXo1eVJBU2xpMHhCTVJkYXRZakFMeGFYdlVzaVdQeXBk?=
 =?utf-8?B?QUJKVEV6QWExMExISUFLbU12VkVvZjd4Qm0yb0lINVJYOXljRThoRHNFREEy?=
 =?utf-8?B?YnVkUnZpajJlUXBlanFGcWplQWtJTUlvclBnZ3hoajgvWUdUeFRRZTZiWWR4?=
 =?utf-8?B?Mm93aDljS1I2cThsSWFLUTlZcFJ3eWp2ZzJyZmY1YTM3QXFqRHk3all3c1BO?=
 =?utf-8?B?UDRnTlAxZ09pUjNMNWZ6MDBvSlE4RHVTT1Z2QmdWNUpyS1BBUGpNcnErblpM?=
 =?utf-8?B?Tk45TTIzUWYraXhuNGFiU1VpUzM2ajFKVnpKWGROekNhNnEyelpXY2UvaGtz?=
 =?utf-8?B?TGZoYTErRmpYc2pQRCtkc3JtTzdkd1ludHowTWkxdDR6UWdmUWhXcFEyZjg4?=
 =?utf-8?B?L3BWZ1FPL3VTY2Ztd21neS9tQ0diV0dOdEV3R3dJVk1CWkpVcnJkMzNyNHhp?=
 =?utf-8?B?b3kyZkZDMkRMT01wcGVLWjVoMnByT3g5UmIxL2RMZE5DVVd4YmZoSkZ4T3R3?=
 =?utf-8?Q?V/N5PqlnrBTMc5FMvRwE56CwB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0a6071-488a-4e66-2704-08dd16c1227f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 13:14:52.1475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiasJQpFpxPWiOMLawgI2D/XJhwOTeiq4ZTc9XOwYx78ZCp7zkJxcE2crwqC8sqONRB6ceAKeY6gXFL2cdORNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6495
X-OriginatorOrg: intel.com

On 12/7/2024 12:35 AM, Ingo Molnar wrote:
>>  void filter_feature_dependencies(struct cpuinfo_x86 *c)
>>  {
>> +	char feature_buf[12], depends_buf[12];
>>  	const struct cpuid_dep *d;
>>  
>>  	for (d = cpuid_deps; d->feature; d++) {
>> -		if (cpu_has(c, d->feature) && !cpu_has(c, d->depends))
>> +		if (cpu_has(c, d->feature) && !cpu_has(c, d->depends)) {
>> +			pr_debug("x86/cpu: Disabling feature %s since feature %s is missing\n",
>> +				 x86_feature_name(d->feature, feature_buf),
>> +				 x86_feature_name(d->depends, depends_buf));
>>  			do_clear_cpu_cap(c, d->feature);
> 
> So why not make this a pr_info() at minimum?
> 

I was hesitant because the feature disabling may be inconsequential to
the end user. Also, the printed numbers would not make sense unless they
have the kernel source handy. But maybe it's better to inform and let
the user decide.

> Since this new logic will disable certain feature bits on random 
> machines, I'm sure there will be some surprises. I'd sure like to see 
> this printed in the system log of my machine if it happens.
> 

Sure, will update the print as follows in the next (hopefully final)
version.

pr_info("CPU%d: Disabling feature %s due to missing feature %s\n",
	smp_processor_id(),
	x86_feature_name(d->feature, feature_buf),
	x86_feature_name(d->depends, depends_buf));

Since it seems almost certain that we are going in this direction will
merge this patch into the previous one and send a combined one next time.

> It might also inform firmware & distro testers that something wasn't 
> set up properly on the firmware (or virtualization) side.
> 

Sohil


