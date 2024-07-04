Return-Path: <linux-kernel+bounces-240355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA4B926CA0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 02:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986DDB214BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5B4A20;
	Thu,  4 Jul 2024 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W7UofdPL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0E4366
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 00:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720051575; cv=fail; b=npsydziJAzeP1+G4px1yKR5V4VCgcya19j/g/GluLVb4LhEr6qx5xlEtYWcfmrkfmWLHIRejLKkDlfgphVL+k6PUJal49bzpMXR3dpiUKq24fLpDuX5M+F0O+6SRfmkodlZ42F/DqLMP38RHtHsSN+XKhhTSIy0+ENrQG73xo7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720051575; c=relaxed/simple;
	bh=MEMIZUm+6u1d6rc5h76SOMVh/NrlZeRw+a0ElnJ7KTs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CoXt6DaG7+dEaBmReVvr0EF40BLoleC9KThzAjG+rtGA4gYIC/3dZas5BfBqCEm00XONCPE6wtl9Vw9n7HoykaLtUHAYdxH8kWopBjZ07VVLek857aTT4Csda+rEkzJUz9hjF3pOnkqmKrazL9kwAzIhYX2O3ZnLSk/1LCsHG2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W7UofdPL; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720051573; x=1751587573;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MEMIZUm+6u1d6rc5h76SOMVh/NrlZeRw+a0ElnJ7KTs=;
  b=W7UofdPLkq9XesuKQbnrkIzE5Rxv/zJW+mDnj23Dohg7FtjODAzekR1H
   /8lUjxhDnxST0yzvABX6TNxecS+7Yi30GvT9thv9QiifwfUy16rayG4v4
   Ptj7jtP7HjZLGHu4XRfTk+AXF9MM+ero84/ApmTVPzSlmYRtJhfBBS9UF
   jXTu+wqpWmLaco/QjTx4Bep0o124ezAnvoJ4Qdz4Ezy9zGAokdrJisLLY
   6PgI4J/SEYu2LE1dA0tabDhrwguAMfrq3rWDIwHo7eMpuo1eyI934dtl8
   pO5kUrNm0NtK+yVeulAxlsEQmOKO3nvtCeXk9OK6z0nt/uzSsXlcwYDXz
   g==;
X-CSE-ConnectionGUID: egWEFMN2TZmsZKQcJNL//Q==
X-CSE-MsgGUID: dcWLQ9o1SaeV0rkppGjZMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17444174"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17444174"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 17:06:12 -0700
X-CSE-ConnectionGUID: KXQS4jxDTOO/xN60fugmvg==
X-CSE-MsgGUID: I/9j4A7YQ5W1f0LMAW8Jmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="47075377"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 17:06:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 17:06:11 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 17:06:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 17:06:10 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 17:06:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdpuIam/gZWp5BRRdqwQVwLXSZvW1lBVcmHhN0pUg1pzgkfbHh6LvdD1Go3hAWaGYj/8ywYlvtxTHyvErufIRA3wZEPredgKQFv5RxHRZMDvEQHdm1b5gkyZBEa6JlCCHk/Fac6N//RGdF3ACndgwty9nmoMIxkvOnANnuBIrUIGqD/cMVJqehl8LAAmLXnSaEWwmyP1t5A8l1pNWyXGIa3cDfbtislMj/vHDndIYelU9aBoli+0PWeXU395wsu56TPRShUM7rIBck0V0JBFvRdNN3RHRr7f4t6vsegd3Bqcy0i4+z1UOTLrr75T2pWkaylTAYbPL3SPIFHo2DkwJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iESAhLqzitNDk8nIpPjnlNmct6mfe+5ZOrTX00tNwjQ=;
 b=kTotPy5ZPM/yAWwcxX/kK8N/RIDvJr7oRUBRg9JaVLSkvexANfHAzMP5aLflHJ2yZizoFkuFL85vYnUlC9yBdKfM1MSSYlSS/cLLNX1D4/NwfF+zsFQxT5imKZdX08BkNuI09SUp0aSW+aqoKinH9OvZfctltEnzcu+o9Nzelo5heQFzCPiyNzmMbWUCfiF5vitPs5mzPQjcoyLDo+FC32VSN21UiBGOVR6cXghUWQ573ngifn0SnKSbIPwuj1JBBIhQEHawMbYtzg3C9Z40auKzMxDz42Ou/LFbiNaa7Nip6AJJuwzrBJZ644M5kF+UMLZTYL81IO9bKBMdWgHHqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH8PR11MB8016.namprd11.prod.outlook.com (2603:10b6:510:250::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.29; Thu, 4 Jul 2024 00:06:06 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%4]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 00:06:06 +0000
Message-ID: <cb646736-1ebb-4273-b90e-734a318b59ca@intel.com>
Date: Wed, 3 Jul 2024 17:05:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arch/x86/microcode/intel: Remove unnecessary cache
 writeback and invalidation
To: Ashok Raj <ashok.raj@intel.com>, Dave Hansen <dave.hansen@intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<tony.luck@intel.com>, Yan Hua Wu <yanhua1.wu@intel.com>, William Xie
	<william.xie@intel.com>
References: <20240701212012.21499-1-chang.seok.bae@intel.com>
 <20240701212012.21499-2-chang.seok.bae@intel.com>
 <0aa05063-c9ed-465d-a7d2-e5fa0bc6379a@intel.com>
 <ZoWZG75hFpfK6kkv@a4bf019067fa.jf.intel.com>
 <6332f158-005b-4c3c-8709-350dbee23f7a@intel.com>
 <ZoW8kYwp2GeM64oy@a4bf019067fa.jf.intel.com>
 <bd0b19e8-ff72-4a6b-9f7f-400ddafddacd@intel.com>
 <ZoXDxldNlTYRo-0h@a4bf019067fa.jf.intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <ZoXDxldNlTYRo-0h@a4bf019067fa.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0023.namprd21.prod.outlook.com
 (2603:10b6:a03:114::33) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH8PR11MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 58592115-c06e-46f5-eb60-08dc9bbd19ae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGgySFdiU1lPNXdKV3MyY3NESFhQRnBsU1dDYzZIaEI2NUF4NHlaSjRVNWVD?=
 =?utf-8?B?bUdSMXhXaG5mMFN2WGxMRENoUkE3UHZiZnI5VnZUd2dnb2JUYWZNL1Y1ZDRL?=
 =?utf-8?B?RFNIcGY0NWVxcXdseW9iK1pqL0FxaFhSNXMzeHhzRGhub1pEdzhnSllUNytF?=
 =?utf-8?B?SHVVOWZCTzc3NHVVS1lRSFdXMUx5TGNrSU85ZkRFd0tqMDA5WDhjWHFyaVhx?=
 =?utf-8?B?NnJsUXNrdG5RdW1PTWNPNTlQbGQzcUpEL3BleTlTS0pycXNvMTJqWlhEZ090?=
 =?utf-8?B?cFdYQnVEYmF3SC9ySWtlMzBSK1BYdHNDd1BCVE9GbnRvYVRQalViNEpDVVll?=
 =?utf-8?B?QVhDRUMya3N6UzE2OUhEbzJVVHdBdnA0ZU9VZ1FTc0EwTjFhNWdSSlRFUS9i?=
 =?utf-8?B?SGU0cVRCQWRpMHluSW4ySGVOaDdvd255ZXR0aklZMnBidG8vNnBPV0tUNEtK?=
 =?utf-8?B?cDlETVd5T2UzSzhuaGN3QVVtNnVucU42c1FHZVBkRjZsRXBRTmFyNXdjdzZU?=
 =?utf-8?B?WWNWelh3aTYrWFlhV2d6NmVTWW0zaDBJQ3BQZEoyK25HQXF1VDRKRG5Jd0xu?=
 =?utf-8?B?OGZWeStHcTF4c1kybFVvVE9PWDB5cVJQcmxTK0tFa3lGOEpxRldTaW1Sb0NU?=
 =?utf-8?B?Y2ZiMFJmTEIwMTZmZElDN240RVhEaGtZOTk1aE5TVlhRTXVhcEVRcmUvVmQ1?=
 =?utf-8?B?aXJvMWRMTEF6Y2hqN1RGNlo4Ykx3ZmRDVUVwNUZTRzhGV3hjL0g0eTg0bDM0?=
 =?utf-8?B?TVVTWExxSlJhZHdvMWtIY09lSUZSYUwyN1E2UUdHcXVYWlJxY0ROVDdwcUtu?=
 =?utf-8?B?elhmNkFndnRVWmdHNjN5YzVYZVhRQnpLOHVYUS9MZ29PME5VOHFSb2tKMFJ0?=
 =?utf-8?B?MEo1ajlQMzVxL1k2ZHc4a1JXU2x1UE8zbXpnRG9ZSXhKaDlpV1oxTVlNWm1H?=
 =?utf-8?B?TVpvSldkMSt6ZnpzMVhhUzFiTER0ZU1aWnM3clBkWHI1cHlrRnpNVWxOTnFo?=
 =?utf-8?B?Wkk0Qm9MazNQRWV4cVZFN2VJdEttTEpTN28xeU9VUGE0QmdnQjRhQ1hqN1FD?=
 =?utf-8?B?NXJsUGszVnhWbkh5bzJOQVl6bm5xL0p3QUdvMVFMZE1vakJYR1lJbGRqK0Jh?=
 =?utf-8?B?aUZMT0l6c1BVMnAzWW1sT0tPakNRdFc0VUV1eGxxUzYraDAyaUYzQ2syZG5Q?=
 =?utf-8?B?U1JCZ0xpN0xwajk2U01OK3BNdzlBdzE0TVhJaUNqQ0Z2c1hlNjZpS245cVox?=
 =?utf-8?B?MEFlKzFSYnpuN0JwY1FZeW1EZEZNeFd5RlJaQ1Z2Q0FxK0N0dkhEUXNnVmtw?=
 =?utf-8?B?elV3Mm1pWnhkMXNQcFByVFhlSWNwU2x6c2pGWTU2U3plQjVZN2FDUVJmZ1dn?=
 =?utf-8?B?UzhjYllSK3Vlb1Vjd2pHWmphWEhqKzJyVyt4VlZyQXRjWUNDL3pJMUhQSFFz?=
 =?utf-8?B?MEIxWE8yZS9ScWpOQzRsZFhFMkVMbE1zaytERXFnN0k4bXc4UW9lWmF0cjVa?=
 =?utf-8?B?WGdESk1BRVVRMGdLM1NyMTlRdGQ3ZWVENThGR3Bnb21TNFZnN0t2d1E5WE9K?=
 =?utf-8?B?SFY0T2djcTZSbWZCL1cwWVpUMjhiQVhZZksyRytwcTcxQzFpSTRVZExDQTU2?=
 =?utf-8?B?bzNzMzJaYmtvUkhicGVXS09SVDFldE1UTnIzbmo1eG9xZUQ5elpMcWx0Vm1B?=
 =?utf-8?B?azUxeDJ1NXFmVzBSUzgvaVJ4eGJoMzFhTy9MeG5meGNJK09GOExHNEoyYUoz?=
 =?utf-8?B?UVVvL2gyQkRuRExSek5vQk1FY01kbmo0UTlWdGRRRnNuMXJuSTdGampBNmFY?=
 =?utf-8?B?ekFKOVZLakNUYlN4YW1YUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b09hbFIwRHFmVHlwZXE2R0diaXZjSGxlNkdGTWNrdEFlRUdFUlcwM3Y0UFky?=
 =?utf-8?B?emdHQncrQ1A1b3kzOWhJazQvRlV0V1ZrOG1meUdsTzh0YlpCb1BMS2pSeUFi?=
 =?utf-8?B?Y3REMk5vOGNabWZlTzlXNFFUaXlJR3B0NEl0RGVBdjZnVzlFZkNZSTk4dktt?=
 =?utf-8?B?RGRucTlOU0hPMlVlSFREY3VSUHlJem54ZnVWNmdpdmVhTmxzWC8yZmpZdDZk?=
 =?utf-8?B?OENSSmlBUE1uNnRXdStlNXpKY3owK1hKQmtUcnJpU0VpU0ZHUjdwRXNxUW1N?=
 =?utf-8?B?MnJwOTVLazB5eDFhaDVpYjFENG5USXcvQlU1bzlwS2JGMjNLblphWXhjaEtZ?=
 =?utf-8?B?Wmh1ZlRrRitOSkY2K3pnZlBRem9TTlBvaVBVQkpNcWJFY1dpVSs3VnBUQmJj?=
 =?utf-8?B?Skc1UHZtYVN0eHdtU0hDWWJxUTRMaGxnaS9FWW9uMGIydEdGZy9yeTBoazBK?=
 =?utf-8?B?dFR0emE0anlQRUN4NXJTWkNIbzlvcVFiMGpQRHhLWnpDOHN1bmNlSU8zZWw2?=
 =?utf-8?B?eU9VWXBNQTVDQ2ttVWdnZUxPN21EVmlIRjN3VHdDSXZ4NWJzcGlYVU9lVnRU?=
 =?utf-8?B?UlJ1NFRaZTMrRjArS3JkUHhNVXU1VHh3bzA1SWJIeVkyWkFIZ2thMjdaZkl2?=
 =?utf-8?B?ZWJod2t3YTZHME1uUDhyT1ZYR3lFNVZ4TENMaE8yM00xdERiY3JneHdEdGVK?=
 =?utf-8?B?TElFYVRYNVh5R2ZRLzdkTm83Z1JLMENOancyU2JJNDljNExwbTJCRm50STdz?=
 =?utf-8?B?RFVJZmRFd1JTOTNXa0VZUFY5YjdHR0lCY3p3RFRnNEF5aVU1aDFpOXdoOFhr?=
 =?utf-8?B?S2o4L0pSY1NFd0tGc3g1dS91RFZMQktIRXhGS1lGTWZtUWRFT25HTnVjN05C?=
 =?utf-8?B?Tkg2Tnd4Qm1hdzRsMnhxT2FJUWxoOUo5TWc5VXFQRHlaWENpS0ErWlpDQUNF?=
 =?utf-8?B?OVJJelNFeE1VeXU2aHZxOFd0UjNHdHVFUE1MaVk3cCtKeDlraE9wV3N1dldO?=
 =?utf-8?B?U2Q0SlpXR2FzcWVBTGZUbVNBV2Z5dDRyYVBjcCtGbUN0eUJhZEhPWGErMUlo?=
 =?utf-8?B?ei8zSm9rODdvTm1BTFlsb0JLdzRtQWxrZ0VVZ3RxZlZjcHlIRnV5OU4rRU1O?=
 =?utf-8?B?Rm9nNUhEVFNRdm1saXQrdy9WV0dmQWFiRVJrTVpYNFdFU1d3M3BtZUdBWTFw?=
 =?utf-8?B?c0VHUDNZNFNKQTdGRVY0ampoVmRacFg0bVN6SERERHVlNzJDSTZEL1kvcXNx?=
 =?utf-8?B?R1FOOTQvdVZ0SU5yblFRU2I3Mk9yWFludEs3ZzVGVVpBLzdzdlJXT2tWNnhE?=
 =?utf-8?B?aVI1aEQybEkrbGhDUy95aUZNVG1wdVBtK0hlTXhEYlU3SWdpTFM5b21LSHJH?=
 =?utf-8?B?NTJMQ0dBbGZXblVjVm1MOXgvRXRTcVhsU2xPSVZsWkpCVTcyNklIUysxYzNP?=
 =?utf-8?B?eW1Da1hIcEJIYTdaZ3hpVnVWdHBwNHJkenBlUjhsWlo5VEJ6UWZQWjRPZldK?=
 =?utf-8?B?S1ZTUU1mYlFYdUVXTWpXQmdRVzg1emh2dVpLQWoxekZCdW4wSHZ1NHNYWTda?=
 =?utf-8?B?WmNQOVdsNzdwMU5ZSFg3ay9tWHJ6RCtWMlpOdFhHQk81NHE1NFlxaGxMREp5?=
 =?utf-8?B?VkEyVFYxMmdjaDdwYzdzMzdHeHBiVEZKOWZIN2ZLRWdJRmIrZXYzKzlac3Jq?=
 =?utf-8?B?WDVYRU1JN1p3NnhEY1lFNVdRd0diRzhxY3E3MHJiTWc0Rk55LzJ3empIcExo?=
 =?utf-8?B?TEZaYjRINUY4T0ovZnZub3dZWlpqYjdVU2dkOUdsZEdOUEh3VGtKcUdHTG9F?=
 =?utf-8?B?V1N2eEhJMFloaW82aUFheWF2bThrUVhFZDRiL1cxUU9ZQ2lrbzdZRmlSemNo?=
 =?utf-8?B?Nzc0bGcxOGx6UThFNGxoaVRzdzV2OHBmTVUrZDNFWXZISVhaUzlaRUlEaUhX?=
 =?utf-8?B?bXNYN1ZKYUlJRHZvbWh4Rmd2a1JSQm5ITkhaOXJnZFY4K0VJTzlEckN6clFm?=
 =?utf-8?B?a0p0REI0bWxqcS9aZUxCcmpYL2Z6RlFZeDBrWno1eGQ0VmNHQlRTcmFqNmlV?=
 =?utf-8?B?SFV2Y0s1cGRNa0tjVWF4UEZuOVdGU1dqR3kzREhVM3ZPQmNJNjgzS0YyR21l?=
 =?utf-8?B?cWRBM3RNS1JQK1gwVjFadHpuTHlnWHA2bGFaOERHY3N2YUhPMkFMQzdLNDNO?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58592115-c06e-46f5-eb60-08dc9bbd19ae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 00:06:06.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC9v0uwn3Y5UAJHczqq25v4lRp3Vd3NtNtRPSb+ybF2p+wBiss5IxuaDDny4ZE9hMI+IaglRr/bsBDDe5oiHOkIY0ClQp9H9xpk5rFa4oSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8016
X-OriginatorOrg: intel.com

On 7/3/2024 2:33 PM, Ashok Raj wrote:
> 
> When wbinvd() was introduced I do believe we added to both early and late.
> Although I don't recall entirely.

Yes, it was added for both:

$ git show --source 91df9fdf5149
...
diff --git a/arch/x86/kernel/cpu/microcode/intel.c 
b/arch/x86/kernel/cpu/microcode/intel.c
index 87bd6dc94081..e2864bc2d575 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -600,6 +600,12 @@ static int apply_microcode_early(struct 
ucode_cpu_info *uci, bool early)
                 return UCODE_OK;
         }

+       /*
+        * Writeback and invalidate caches before updating microcode to 
avoid
+        * internal issues depending on what the microcode is updating.
+        */
+       native_wbinvd();
+
         /* write microcode via MSR 0x79 */
         native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);

@@ -816,6 +822,12 @@ static enum ucode_state apply_microcode_intel(int cpu)
                 return UCODE_OK;
         }

+       /*
+        * Writeback and invalidate caches before updating microcode to 
avoid
+        * internal issues depending on what the microcode is updating.
+        */
+       native_wbinvd();
+
         /* write microcode via MSR 0x79 */
         wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);

Thanks,
Chang

