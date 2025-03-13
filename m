Return-Path: <linux-kernel+bounces-559981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DC4A5FBE2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F5B1887A54
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEFC26983E;
	Thu, 13 Mar 2025 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3TmmM3b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CC47FBAC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883746; cv=fail; b=HnA4RxmFxX1r/qWZlXqfi/s1gFGeizSdd/9Mf9G4EOWLkrLoVHTaUIXFfo4JIBFuOJB0p4iIO/xGD6KCbZJcGvvZbwd7GsTJP1wZBMazhjpRn0InLx+MOS3qLy7Tpt763eEWpFbCWSU3Syvmu579jUkEUmbK3mnUPmCq5M6FxMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883746; c=relaxed/simple;
	bh=uOtytfKvbeGg3XNYBywY/1H6pSAc4myNfZUfNZzPIIo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LfDueLHnl+1qeDtRb44XQXGCeVxohkvJzWhYHZCDoMcH3QIsM/jLUsZv29nq7sbM0jZiciSJYonXJiriCc3167ynVh++dBfdLLKUtm9G5Yrgn3fOAHHNa1AqPpOuhpmulAZbVBw7pqHV9uCQpjcWncnO7HuTSnFrVRO7HHPiUFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S3TmmM3b; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741883745; x=1773419745;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uOtytfKvbeGg3XNYBywY/1H6pSAc4myNfZUfNZzPIIo=;
  b=S3TmmM3bL6mEjP4eBJzj+d1jFa+PXGIDYB3mYuPNus8H5f3kjSE3ASs5
   orLG6kP9sygVERhfGmhqetjRHGEiMR8Rpks+ua1g1yn9+fbLjFjM0r0/d
   7+4Y2Fiq7NlKSln+CPzclAgIl+FDYxj9KtY6EglbZZO+cdX4baRPN1Ruw
   SlpqQ3HIoKDwAun98i3XbiBSNt7GH28bMWjJUh8b7R/o/5pC3Yh0OMI+h
   5oYOq7p0WrHEtag8sr+nDd4NEWyH4iyqOWpLXzHdZMgtattWsLlsZZ4MJ
   eXFMVNQfcVv/OSk660VEzacWu63FDjRPVQJ5I4peIMtyjk7os0KrITH7m
   Q==;
X-CSE-ConnectionGUID: UOtptHDLQwiirJpuNfXHIQ==
X-CSE-MsgGUID: 2MJN+0U0Qa2iJLnkPXj6XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="68375354"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="68375354"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:35:44 -0700
X-CSE-ConnectionGUID: 6i+5kUBESoi9Ir4JFJgQiw==
X-CSE-MsgGUID: bvDxlSHrRqGndu1hpDxZCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="120738101"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:35:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 09:35:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 09:35:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 09:35:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFbeLnCXKl3GTdTA2IeAAst98DH6JLE5xIxZ1YMJI1aFu7OU7PNPWYrHqgKCTJobzVYhtEZ3NvCSGS+Kx6j1yoxb1nqPq87Mgmxr+Ht8gYQw6US8ZhrZgyMEuBEpbBsTjFqaWJ2qVrr/VWeiNteYzCoe/l8vLc3OMsXA/JP855FbbJMKd8sshuGe1cBtMdLmtJCyNapqywsJp0HLBWeW/LKLfB38VO99iTFqMgKl/x9q5E6WMavD1ESqrVbS/Bfz+gTwknisa0HwyefbC0JJF/xTy2bQPDX3myf81yz8gRvie3bjQMfJnN3kS5ArZwmd5HlB5G8dEnwLW+nsHaHn/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRpVPEiH2YfZhYOH2kN/LW8FnUzgj8Bux+aS0p8bkis=;
 b=ZxZJzo7Vcn2Bz6JJnP80dV10FRYElk9n/0eelCY+QXKvKPoYZnm7Ura7SpVx2lc13KKP7NA/I96PhKXtRaLciYl3sw6hqwWqAmcBi21airEepbvAlTZMmwNMPkFulFfNiNsnthcLMxRZ9MGURJj2s2tWdenFFZ6dNuISDW+OBviSmnmi1YaeWqyuK76PSKCFV8VQrxhYHYV6ikYI0PuaXRybft4yv2B/jWhI2mTLuv89Hl/KtkRSzX4GjULfRseW9OWP3Zh1aRRv2E6W+EJbEuFhx379YaxIETxL4JY9adg+6Nit5tMVqwRBseiIO3T8PdAyPcswIJJiHzmDdn0J+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CH0PR11MB5218.namprd11.prod.outlook.com (2603:10b6:610:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.29; Thu, 13 Mar
 2025 16:35:26 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 16:35:26 +0000
Message-ID: <2e9900e5-e25a-4e53-acb2-d71247cd497e@intel.com>
Date: Thu, 13 Mar 2025 09:35:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] x86/cpufeature: Warn about unmet feature dependencies
To: Ingo Molnar <mingo@kernel.org>
CC: <x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>, Uros
 Bizjak <ubizjak@gmail.com>, Sandipan Das <sandipan.das@amd.com>, Sean
 Christopherson <seanjc@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>, Tony Luck <tony.luck@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Nikolay Borisov
	<nik.borisov@suse.com>, Eric Biggers <ebiggers@google.com>, Xin Li
	<xin3.li@intel.com>, "Alexander Shishkin" <alexander.shishkin@intel.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
References: <20250307000204.3581369-1-sohil.mehta@intel.com>
 <Z8resWzgtZaTuzEN@gmail.com> <ed81aa4e-6ebc-40ad-af45-289cc7138c0f@intel.com>
 <Z9KwG9t2OVhoapZc@gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <Z9KwG9t2OVhoapZc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:a03:255::25) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CH0PR11MB5218:EE_
X-MS-Office365-Filtering-Correlation-Id: 437c336b-6336-4a17-bd95-08dd624d0f25
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmxQSWcySEIybG9OMWtINXBFU2Y1OW5ZOHBjbTM5OFI5RkhaWWxTdDVsNkNr?=
 =?utf-8?B?ZVBLMURvc0xuM2MvaEhMeEgwNXNscUk2RDZZek80clVSTW1wZlMyMEFHQjRz?=
 =?utf-8?B?R3VwWHZhbFBGVzFmTTNINFJUWHI1cEZTNjkvdFZMZHJjT1A2ZDN2VG1pcmFJ?=
 =?utf-8?B?azJmbFB5bU5sSVYxVnN4WGN2VnZreXliOUhBVjlUMmtiNGxxTDhnNmpDV1k3?=
 =?utf-8?B?WEErenpFa3MrUzNOL2pPK0NLamErQ3JUaHQzU3ZTRHRxTnlkdWN1VUNYT2Qw?=
 =?utf-8?B?Wk9YZG1SL01pYjlKRGNBMS82ZjF2MGpTR2MvNlEyM01RZEU5cDIxMExGOGJt?=
 =?utf-8?B?dFo5cU41YlJPSnZXOUZrUWxMZ0pwZTZDU2NrNGV4M0dQcnFpeVp3MlpGOTJ1?=
 =?utf-8?B?REFRQnJVaWphN3luV252RkpFS0h0NnlOTm5hbHF4KzhVdFQ3TDFad3NaK05v?=
 =?utf-8?B?eXZnQWRIVTg2cWZpWlhtaUpmWDRMcUNSY28zdHBXS1RkU3RpWmhGUWgrSFZN?=
 =?utf-8?B?K2kxSS9ZeWNweWhuT1ZGbGJxc00zdmtocXRSTCtSRkl0clpGVnRiUVJyejZ4?=
 =?utf-8?B?bWJFWnFqWGNwT0NLWEFGMW4ySk9OQktUNDl1QndwYy9mUmgraGkxaEZrVVJE?=
 =?utf-8?B?MGVjSkVQVWNyajEwVGd1VG54a0ZpWVlhZEV3V0o2cjVDbkNkekRKZXR0NWtZ?=
 =?utf-8?B?NlB4bDBtaU5mZnVtQm9nMDZVTEVCVkVNL2pWcUNXOEtJQ2YvTXJjL2c5Sk5T?=
 =?utf-8?B?aWpCbmhmSllVNDd2WHVhdXdEZm1JNVAxb1dXdnpoNkprSm1BYi9BYjNYMFRl?=
 =?utf-8?B?Z2FBWXVuUFlKcTRFc0htZmh5L0hEUmNxS0NLS0daakZnRzF5WlgxTzBZUFNv?=
 =?utf-8?B?bHhDQmVVeWRweGx5eHYydTRwdktzSDNRQVhyalN1cUVyTFlNOHcyWjVZb1Zl?=
 =?utf-8?B?aDF6b1BUQ0FTUTgrRnFma01yYlRDMWh0ZHRTS1ZMNkQ4R2d3b2R4RzZYbk1t?=
 =?utf-8?B?a1FKaUpKNXliTU00UUhpL3JPb1JvQjhtNmFJQlZVQ0FrTXdZVDNxKzVsRTJL?=
 =?utf-8?B?Z05YSW1ja1Q0eU5MbjYvRm5JbUNzWXZsYWVtSkhiUTJmOUhoTVVad3VwcGhU?=
 =?utf-8?B?WmZpZmFhaHBjWWF3UnNBQWwzd2hIYnBoUDN3T05LSHo3RWNGcHRVVGQ4SWN3?=
 =?utf-8?B?WkoyaFMwZEY4S1BlVnRhd0E2UXRKSDZIWUtXaFNEV05DUWpSQVh3ZXJCMHFl?=
 =?utf-8?B?dm1NVFFPTGpnR0ZIZVpTaGhERTFXZ3lSa21HZWNwQXhCdTByUWc5ZDkzSGRv?=
 =?utf-8?B?cTFqN1dnNHZSd25KVDk0VmYzMDZ2S0FGOXlFNWpKZmlrN1N0M0NwWEdXS2Ix?=
 =?utf-8?B?Y0VEK2g2eFNnR2ZuWk1rdFVUdFBJQ0lDQXhobWhSNmN2b25LVjV2QUQ2NXdG?=
 =?utf-8?B?YUd3YjE5aktzaGdQblpraXBqdU80bU9TSXpvNmVtRUtSWjRNN292dm5VUkhZ?=
 =?utf-8?B?SEFIcHM4SXVkblRYWG5sNzhkYWpLUDlTd0F4QWhGRytqUXNVVXBjVVlZZnZ4?=
 =?utf-8?B?dW9JTjB5MzduclBRQktQTDdLNGdYUjhxLzJITDRrN3J3RlVienZDb1hLK2lF?=
 =?utf-8?B?eHpUT2JlYVJaNEtIRGRRZWRQNkZNZmNWTGF4TVVmaDdaSnJDbWRhOTd6QTFO?=
 =?utf-8?B?cjR3ZjlnWXRGK2ZONEJwSTlOdFBSbW9BY0l0NEpWMzVwWFBzWS9CVWNxVi85?=
 =?utf-8?B?L21Melc0akIwRjg2K096U0JWT0JLdlMzQ2lKKzlvblFBcjVsVWNSVnRXZ09p?=
 =?utf-8?B?MlFTYjljZ25Xa1NwYWZYTHA3M3oybWtRU1l3L0tXcTduV2tNQWJtVXBoRkxq?=
 =?utf-8?Q?OevH+6IzlXLyP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3dROGdldlgwNVh2ZWdEWGVwQk4xRU15ZGgxb1JhSXdaeSsvcTJwYkdIdEZp?=
 =?utf-8?B?V0NaRWlRYTJ6bDN0TVJLS2F5WGMxbGZPVlM5elUyRGIzMS9XUDBVTzM4WHNs?=
 =?utf-8?B?Q3FiTDRQL2tUYmYxRjB1cFl0eDhBSDdOdytIMDVwU2VMK1RtdjUwTXFIbDVh?=
 =?utf-8?B?Um9rdnJaTG0wYVVkalR5U1pIUUc5NFNOamZVRlpPanRQakF0eGk1RTJNdytQ?=
 =?utf-8?B?MVpRVmVqUzRrM0x2bE5HYlI3bG5xZXNxVDI5eUk4TXVyckRBaEo3NjY5WDZz?=
 =?utf-8?B?dVdra3o3bmJKVzlra2ZvWGhESEcxUFV0WnRmOTgyN2lzMnpnR0hUbGhJNUND?=
 =?utf-8?B?R3NqVjlFWUZMSDZObnhKR0tVMC9BOTNDVUgvNldhMmZsU0JOQ0tJemIrZEln?=
 =?utf-8?B?S3laSzlVQmUvTmNKeXdlOTNNSU1Gc3c4M3JoODZ4YktQSmVJNnE2Z1FjZU01?=
 =?utf-8?B?VjNrNnZUdEVQbWlDbWZrdmJPVnhvSEN4QXpPU0hjdVVBUnlzcVNsb1NSWVJQ?=
 =?utf-8?B?MlpKbVdwajRPUHNRcTBxQjU3ZWx0M0poVC9XZWFXNU1GS1JxVmx3eUZ2Qk1k?=
 =?utf-8?B?VWRSOWlGQTN4Qk9aTkQvRFpXczFQR01NVVZmcTN0NjZ4em53bFFyVmxNRE8r?=
 =?utf-8?B?b0k1dVg1QWdzNDhVNk1EWHROZUF4K2VLQkFvV1g2VkZWOGN0cWZ0OTJ2UGI2?=
 =?utf-8?B?eTBRSkRsTnVXZTNpeEhPUllBRWZSSjFSKzE1WWV1dU1LTStSMnVhdzdyWjFq?=
 =?utf-8?B?dTd6N05HNTZXdHEvaFArRFJLWWtJUlFnbExJbUc3Kzdkckk4YW0rTUNSRTlj?=
 =?utf-8?B?MkdVSjROOUprRXQrQkZ6YW5PTEw1aHczRmNjQkhEUHJBNmhlOC9nUHlsYlp0?=
 =?utf-8?B?eG5hcm1wWjExcm9GQ3NBQ0IxTlBSVUxqUHhUSVUwNlFHcGJxUXJRZzQyN2tS?=
 =?utf-8?B?N1BYUy81TzJrZjlCbDUyQkJnV1g1dHVPQXZDdkVKOUZ6SktaekJtTGZYT29m?=
 =?utf-8?B?QVlkWDVrRlBBREtjM0MwWEt5SDVMeDVvVXQ1VGNWcHhab0dpOSs0Q1I1TTUv?=
 =?utf-8?B?ejA3YTVnODlOdVlsU2Z5LzYwK0tnTE5aZ2VodFp5TEtOZDdzYkVhM3F1YnNX?=
 =?utf-8?B?SlFoNkFrckFGcGIxeDVuV3grc1BpVTZVenRtV0dWeEIvZDY5Y2JxU2pHVXRi?=
 =?utf-8?B?Nk5LYUVpMVFodzI5L2tmK1lEYTdGNWhhbUtFRGFsQmw1Ti9tYTJNWTNLS0s4?=
 =?utf-8?B?ckdtRG5ncGVHakpNTUdPZzZOV2V6QzVCTnB4NmFTNUVxNnJBSWg5VmtCQWNN?=
 =?utf-8?B?WStYZUEraitOOEx5WjhyRzJldHFkcTJibzdZQ2lSSHAwYmF3ZDhUcGxWMTcr?=
 =?utf-8?B?UmV2TjdRR2JKRUpLamdXQjRJWE9DbS8yUmhmWmk1S00xdXNwNklHMjBIL1Fy?=
 =?utf-8?B?aFZpQjZLaTJJbHRXSnNhZGp5S2M3YzlTT1dxU2hWKzkvZ2hyV0tuTEo2NVgw?=
 =?utf-8?B?bWxPWUFBNDRJYXIxRkJNOWt2QnU3WUc0OEFCOGpXUnZHcFNDL0kzWC9vb0hO?=
 =?utf-8?B?eU9SbkNEd29yRFZrUWZFT21uSlMyeWpZdThGMzcrQUMxOUtGUENubnlHV3Ni?=
 =?utf-8?B?RVF2QXBZc0Y2S0Z4cDVaTlBwNEJ2NkpncEozWXZBak44djlERjl3WFJMa2N2?=
 =?utf-8?B?b1orWkpkUUhyQ3IyWHZyVkpyUW8zejFHcmlxRVNaVCtvU3M0WWpLbytvQmlu?=
 =?utf-8?B?a0JoRzV5NFQvUTZCTDlXT3NxZm9sRC9HUDR3citOaTd2RUJIdkoyTngzVlEz?=
 =?utf-8?B?ZG5yTTQzdjJqZ2hsdWJzVTJoVitZZVA3SDhjSTA1M21Da0R0bm5uU2U3Nyt3?=
 =?utf-8?B?WVRvVGpCSFg1R2REZElVZC9Ba2tTSlZEU1I0MzJYNS9lajZLNGFjeUtXY29W?=
 =?utf-8?B?bkRNZS9FRUNqOTVqSG05c0lCOStMcXAyYkx3QmpxeGEwbjNrMmxvamYvMW9v?=
 =?utf-8?B?YWFxVkV1TE1sR2VtUzF1WFhySVNIY3RDWit2SjZYRkJwNmxadDVDU1pDMUlB?=
 =?utf-8?B?ckoyRStRcXNwSmVqOEJndng5K2JSUzU5YllsbVkvWGNJTFFPUGlteVlaK1B6?=
 =?utf-8?Q?T+etTzD5wE1K9nLpwMw+nQYNp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 437c336b-6336-4a17-bd95-08dd624d0f25
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 16:35:26.4215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gm4rX7j/+j+CYhXsJN8pmxjnwlpLh3H37EoogTdXdIheZbnq+LH9r7PLIV7jHE4+Ii2T4CMwY27cZDUfLZw21Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5218
X-OriginatorOrg: intel.com

On 3/13/2025 3:14 AM, Ingo Molnar wrote:

>>> I'd make this a bit less passive-aggressive, something like:
>>>
>>>      x86 CPU feature dependency check failure: CPU%d has '%s' enabled but '%s' disabled. Kernel might be fine, but no guarantees.
>>>
> 

...

> Yeah, so I really wanted to sneak in the 'dependency' part - because 
> it's not necessarily obvious from the text, and most syslog readers 
> will have no idea what it's all about.
> 
> I don't think line length should be an issue for a message we don't 
> expect to trigger normally. Clarity is more important.
> 

Sounds good, I'll use the one you proposed as-is. Will send a new
(hopefully final) revision soon with the changes.

> Thanks,
> 
> 	Ingo


