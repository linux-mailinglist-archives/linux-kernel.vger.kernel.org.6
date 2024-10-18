Return-Path: <linux-kernel+bounces-372010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F1A9A433C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E99E286699
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEC8202F7E;
	Fri, 18 Oct 2024 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kl+UYZHX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC92022F4;
	Fri, 18 Oct 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267623; cv=fail; b=t8rX8NcltS31EPG5GBG7nAXp8+UuL8SRGPPfTn5vNHBgyxu4NchIeeY8ue0AI2+HtKpZy23MoJix9BXtv9fDE0VRs4DaXNG/9H/Ia/hi5X9Y1pd+bgT+tuzbPrJE9H+hP5ua/l5MxDIhxGofRHWBOGn9VBskit2HHgCep567jow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267623; c=relaxed/simple;
	bh=eAYfbI3tR7UWw32oChCVlXf28+GsBwwamOVQ92sx4JU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g08Z1VxM3dwTu91fjnSEdG6I7x4YjFKyXh7TXftR1GBrHdO7PdlfdAoohUQ246IaLeRjOT3CgTrjVzWp1ryCtB99ggoH8urqpcIsLgj/bcCTQ8y4AKNti4tJRsfjY/ctR0V1/ePmbF0tlZPzN8RgbTL+NXQPl+3MNzV+Gt0ahvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kl+UYZHX; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729267622; x=1760803622;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eAYfbI3tR7UWw32oChCVlXf28+GsBwwamOVQ92sx4JU=;
  b=kl+UYZHXGkE0rej31OglLtgA5mRWF9vQmqs+l9knipn5W5ZDPl0Xw68B
   BB1aeMAvhUAOsSL6ghniNpOH9itzxyME5zzrJf4TjYH/udf8OHtjqZTYn
   taG05HzI3RjVbyniYSXB3OA3moEhl7b5yM4Fb0+4xl04i8VoqsTtGO0at
   tIEtl946+8jYnRDTKfOv5viHZSgYzPba+RZJlem8Vut4D8LGCotShMufO
   LYW+SIJJftw7fKF5hxxmY+A5+r5WmQKyWl5/2YG9GyuY7/WhczxmhWq/n
   zNqHoxLRQJ2iKPvt1Ge6GVjvzRKpETSOeQo0i7SSyaWOs95pPzC4bQmnB
   Q==;
X-CSE-ConnectionGUID: UmSZgEo1Tk64trdOg/pxXw==
X-CSE-MsgGUID: erml9LPsTI+Ie5eAj+jrtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="16420607"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="16420607"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 09:07:01 -0700
X-CSE-ConnectionGUID: j6MPa9A8R+GIcHAvepnMHg==
X-CSE-MsgGUID: 0seUidMOR1242N8ytLGR3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="79046178"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 09:07:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 09:06:59 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 09:06:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 09:06:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 09:06:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vy4z1/IUSG5qtF+rvnOiWQmw3FWC1tLX7awpNc2sJxK+f9456rfxhf4gEedHCuObfZKLoOHo4bSalXgzuOhshgQtF3HOY34/8qOH9xoy/8QaM9Jc5dYh5bZwlhG2AP62TdP1t8gm320AVrLey0az/+JVUrEexvTb9KfklsNJ4dQFkTLUixABHjKxtqFK4V8wce3CAXa3FB/g11VNm8MfbTVQeeK5jDOi/OPGKqTJ7Ue3vAbKfzE9jgm7mSZMH+gaQrhofN0o4EP635TLTF9fAs3NXSMdRzYzFWMXBT/sHLxoPlFKpMb+zRj3FyMQpl6WUrZCNXfsCHC/dos5mi4o0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rB2DGGbDxT3PVX/AR4z8+sus5nY7arzRng6zr9+kJOc=;
 b=yFpajQeAoAOY6PwK+x/nSoWA6TS0cOqjkuPgqG1ynFfrlkVrmJNCZtG735Rl+Mvo3+XyPnPBBu2TXdsYLvgMv5Y/4eQqLzsaQldF97/2RrV+cazrWHSz/72GS9okvzIhWqeWbgPpd0hZacjgcTK2BX7L+pb4qHmUupBg0fZ5pTFuemkuLx3KuJ45xZthCAujIW8gwl46si/dXL8A3dAX5pvm+loFpzKD2ERYk1soAULso36iX74udcqbfLW3US6+QiHLuTXhxPY1vo6jIt8S9nQklWeR5TnmRKwiQh2F8pvsS40hOg39ogqi5wr+Lo6fpKdLgBWKiP1ZGbDoLweJQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CYXPR11MB8755.namprd11.prod.outlook.com (2603:10b6:930:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Fri, 18 Oct
 2024 16:06:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 16:06:52 +0000
Message-ID: <9ffd9ef5-59f0-43fa-be5f-f24f200d9089@intel.com>
Date: Fri, 18 Oct 2024 09:06:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 18/25] x86/resctrl: Add the interface to unassign a MBM
 counter
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <a06e3f9b975bc3743ed8b8df04b6b52229d62bd9.1728495588.git.babu.moger@amd.com>
 <a74315f3-9250-4e52-823b-dfadf87a6142@intel.com>
 <3172b5fe-5394-92ca-4d4a-d194b84e8364@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <3172b5fe-5394-92ca-4d4a-d194b84e8364@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:303:6a::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CYXPR11MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bfd9538-e5b9-471f-4c3b-08dcef8ee0eb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmI1M1ZxcHZyYnhhNmlzZkJvRS81WHBLcHJZSS9EUHZIeVpJZUtTMm9sblpi?=
 =?utf-8?B?R04wak96Y21RMWJ2enhaOUhiaFh6REJ3Q2FqZWxEQWVvRGRxNWt1WlpYYjJR?=
 =?utf-8?B?alZhZ0xCMDMxMXRnZFd1TmRVT1dwTU9LYTdtbVlrbUlGM2tHTnE1VTVUMmxk?=
 =?utf-8?B?cS9xVjJOYnlCQkhlWXpKUnpOMkpwRVllRFhpMHFhc0NnS3ptVVduSGFhQnln?=
 =?utf-8?B?TTA3cnpnVmJjcWdTUW5NU0ZHaFo3N0Z5QjBMOGdkSVZQUmZzYnNVb3M2UzF5?=
 =?utf-8?B?R3luQ3hDL3VKK3NVRHMyeUZnR0RmY1NGSlk0QnVtNzBvVHJtd2phTitqcm10?=
 =?utf-8?B?dkZpT3V3OUFabU5Bd3NkcXhyZmRsRlFpNFhnQ1oweG5mUjJkdVFyL3NQVDhZ?=
 =?utf-8?B?YXFjNHdaK3ZIcENENmVUcWtHN2Iyb0V0WVFSM1psWHJkLzdieUdIMU5hTm8y?=
 =?utf-8?B?OGk4K3NONVlkdVBzUUdPRHJmZ2tCbVJaa25vQmk4MWdMV2hqY3J5Rm9iRXdj?=
 =?utf-8?B?NHgxejJQelZORDZ1M2hLKzZoQjhRek04OGdMZFI5N3VBeFM1VHU4Q3ZzVklV?=
 =?utf-8?B?U2FqUnFLZnlrRERpS0J5aXpBaGZ0L3lZYWV6cnk4cGFFcGhqZ25KYzB2blF4?=
 =?utf-8?B?bHlYRXdJQ0pwOS9Yb2Q2b1hERjZ3a25zMG1tK204b0haMEhnTHRhMWVOa1pF?=
 =?utf-8?B?TEN5ODg4NmtsSm1YZUJubDBJeCtRMjVXL0xzazBNTEZkY0ZDSWVZb21hRi9w?=
 =?utf-8?B?K0xyeWdPam5LR0lzMjI3Zytza1lZd3FQbElOYzRTSCsyOGhtd2VUMGloVHpr?=
 =?utf-8?B?ZDhzNnJSOWlGcTdwMk44V3I5UmpQb0pXRUExSUYvTENJZ213WUR2M2R3NEZo?=
 =?utf-8?B?U29tby9JbnZ0SGs2YkVoNFJIdUZnSDFqb3RsQXlmT2FxK2Z6TUhRTVlVWHZK?=
 =?utf-8?B?U245dlVlSXhDbEhZWU9KME9FRmxLNmgyaVlYaTJTanRYc0tLZWlCVVBoSmhz?=
 =?utf-8?B?aWhJN1BKMHpnWWxacmIrSG40dGhGbHE5cHVWQVgvK3I4V0UraTllTWNSbDRW?=
 =?utf-8?B?WTg2T1FMQURSTE9UQlNTTDluTHU3V3FFVEh6NlBNQ2JBaHRNS2VoTFVhbVZt?=
 =?utf-8?B?L1JRZldIU0Z3N0RiU1BOVmpyTVMzbC9PcEFyRE0xOXJXNWJFdzk5cGJ1WnBY?=
 =?utf-8?B?MDlTNTdBazVpUG9xc05rSDhseTNLeUZuV1lrMDNjVlF6N0UxUTEzYlUyVEx5?=
 =?utf-8?B?aDZ3OEt3cHpUbEROYTRxQjRPQmVScDlEWisyUWRlY1lLZmdQVVBSS3laZmVQ?=
 =?utf-8?B?T2tHREZWRWJlbEl0c1hVV1QreHJCTXMrM0NtNVg2UWJkMXE4WE8rRnE3Y2c5?=
 =?utf-8?B?Y1NaUVJqNVJSSlI1NFVVQi9kRTRzYmQ4bjc3LzhRTlNHczF3TmR6cXBXWk1U?=
 =?utf-8?B?NHE1NFNyc1pEK3JTZTdQaTF6NlY1N1RXQ1FaQ1E4bzQvcXZ5eW44U28yQytD?=
 =?utf-8?B?azVoaGphK2E5a2hwbWFtMXBhSzZMWEkzYkFpYVlSLzZZZnZRcExiV3E4ei9K?=
 =?utf-8?B?NHlBR0tNVHBSMk1qdFJhUzVJNFYyQi9nRjE0V3EreElyUUpTTTc5VDh2L1ND?=
 =?utf-8?B?VUNXd1RlZ2dMcE5OeVU0eEw4MDZpRE0wbW53cjFjd21YQ3BpT3VvOHpIc1lo?=
 =?utf-8?B?UGQ2SUZjL09yZHN4a1dqYWJSYjBDUkxYU3k4eTRWdWxpYnZ5ZU5LQ2R5Wk1q?=
 =?utf-8?Q?GRb7XiStLEQ8fgNyzBZExEH4OdqXtzob6qGp3w7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkVyN1c0bDRvWlBvYnM2NzdLZHkweStSQ25MdDdYbjduNklhT1NpbmNNTTNs?=
 =?utf-8?B?TVFWNGNoRHNnaHpCdXZGOXVvNjNxdXNyaVdraGVKK3E1OFBkRUo1bTZaSGF1?=
 =?utf-8?B?dXpYdXkyaG0zS1ZETnNXWElBRHZEbHJtYldCN2Rpa2lHdVZkUTRzcjdyNnda?=
 =?utf-8?B?THV0M0RhWE1nY3hIRnBBS1NNMWVxTDFiZXp5alpxYVRZdE9naUJxL2svbVVM?=
 =?utf-8?B?cmRlVnlYYnl3NDlrSE1KOHkzVmF4VVRBNENIRG8yRjZaSTlrMENGOXR1THNR?=
 =?utf-8?B?Nkh0dUtzQkJnYm0rNTV5ci9wV3VwMk1rMC9PWHBVY21ybTZ5OUxGWm1mWWt5?=
 =?utf-8?B?TDhTdHQ2cE9NelBVMHdyR1EyV3ozT1crWkhXSlJZTGJvS1hHQXArQXpIdklC?=
 =?utf-8?B?dFBBdkhnRUQvdzA5NXVkQ0V5bGVxWVVCUlVSVXBjZVVWamFtUnB1RG4xRHc4?=
 =?utf-8?B?SHlkL0ZsM1ViMCtTaytvZTJJYzFiNkR6Ny9mRUdXWk9OMWxlRUdCWkdOYTZS?=
 =?utf-8?B?UllaMHNuMjFsSHJmUktiWVJqWVlMWDJUYnRwdFFSVVUrVW5wTTR0KzRMdEZw?=
 =?utf-8?B?amgxMnUvV1dDbnNjK1AyblpMUlQ2L0pUNXJia0I3dVFPWVBZWEFkb09FVE9D?=
 =?utf-8?B?eGM5R2Z6bkJRZFZJVjcvaXcwZndnTURWNUlQcGQ4VmVmSGgxYllWbTlyWGpn?=
 =?utf-8?B?di9GV2IzVkpEblBQb3NoRFlKMko4Uis5TUlwMlQxMThoamJTbWIzeG4rU0pU?=
 =?utf-8?B?MDBjZTVJN01xVyt2MTlQdFU2YXVZakIzZlZLd3RLemE0SU03NzcyT0tyMWht?=
 =?utf-8?B?TTVpS25ZYzNFQm4rNmJYR1FYRDVlSE5wTnowcTZjeS9qRDFUSVNiZTc5NXNR?=
 =?utf-8?B?eGxDWmRGRFd3NVhWcjJrVXdJakYvdlFESlAvN2xoNVdJNSt5dEN3TGxPQlRs?=
 =?utf-8?B?RkFzbHZ1Y0Y5aDFxaUhTUlIvMjVCNE1WVktBYlN6aURpbEc1WmJtcG9maGhs?=
 =?utf-8?B?TjZVTkNBVDZjQnhCTXlhamxML2JKaEZKQ0JOUHc2MnAvRVBIb29sclFuTkVq?=
 =?utf-8?B?WUpFS1YrN2p3bE8reWgwMVlzdE52Q3JHbnZrZ3R0RENEdE15aDhsREc1cTYw?=
 =?utf-8?B?NEd4ejUzM3JmZG1RWFZ0OWpuL2lUb1UxOE1iRm1keHNZd3BzUGMrNFQrZ0JX?=
 =?utf-8?B?Vlc4alkyWHF6T1FmZkh0bmpOSjY0dXlaRmI2TGtqdHJvMGR3cWRkNTlmaG5K?=
 =?utf-8?B?ZG5uanlIaitEQWVLREVrSVAvS3hnVVJZclpUeEJZYWlFRHFWOFJ3c21MQmNw?=
 =?utf-8?B?dDZKQzk1ajFaWlFHTmR5VHczclRKdU9jbWpueXpJeWszMDZBcmluRm1Ec1Js?=
 =?utf-8?B?WmYweWZvVmd2ZUJuZUJQUXdQRmM4TWgwSnllc1hVZVpaMVRYTnhpNnRZRVJQ?=
 =?utf-8?B?ek9XTSsra3lwNFAzeWp6M2EzbnY4QnBUR0JSRTllU1RlQmFwbk9WRE9mejB1?=
 =?utf-8?B?RkNPcmpIWklna3dJU2JyVWVMa3lZN1V6MXQ4VzY5S0hqSGdYdGJ5MEhkOXNR?=
 =?utf-8?B?SnhPVHhQd090YjhoWWErVTdJK2hjTmVKTWlDejIvd29kaXR1OThwclUvTS9Z?=
 =?utf-8?B?Szc3clN2OEJEdWRZQk5Kd2doYzc0YVdVYXNLb3hnaFV1c3hmb29CUEhISHBK?=
 =?utf-8?B?L2swbTFzUGdrUUM5YURYWi9EQ1JwRTBzemswNnc1eGFwbmlXb0llSlQ0ZGVP?=
 =?utf-8?B?alRIU05RdG5tVU03RWxsQU40NTVUUUJsbG5DRlN6U0plUGIzdUlYdEdNL2R4?=
 =?utf-8?B?MDIrS0RMZFVPWEFiWkhubW0wL3RJQVBwNFhMejhjeEswMllGeWJtMTVkVHFF?=
 =?utf-8?B?SFA2eFl2VDFLSVB4VldWSlV5ejFjMjBBamJyWlhETGIralFmYmxyODUvS3pL?=
 =?utf-8?B?NHgvNytuei9ENVcrbCtSUHlDOU96VG9FVVlqUnlPdDRqVFhxb0Qrd2kxRVhn?=
 =?utf-8?B?Y29JT2JLN29VK0M1dEtKSWxjN3FtQ05kK0RpTGptU3BCRzdxRG1OWS9SN0Fu?=
 =?utf-8?B?QnpGN1NvazZhM0RsUTZXMUU2dDBHeFpwNEdIbmZ2TnBpTVk0Q20xMTVLMlVn?=
 =?utf-8?B?dVYvU3NPUFZGQWp0aTNmQTI5bC9MZWJicDdwM284clZGd3JOYTZhdXBldG5l?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfd9538-e5b9-471f-4c3b-08dcef8ee0eb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 16:06:51.9630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGiRrv1hxgD+T9Ah9g4JS11Phh5sPtp+K3wenjRrGUHmnZw5W1H+jmG5V99CDk0syG72sq0CoQgoghWNuibIGl7hYw7MidOd6KxgsGDliEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8755
X-OriginatorOrg: intel.com

Hi Babu,

On 10/17/24 4:11 PM, Moger, Babu wrote:
> On 10/15/2024 10:29 PM, Reinette Chatre wrote:
>> On 10/9/24 10:39 AM, Babu Moger wrote:

>>> +    if (!d) {
>>> +        list_for_each_entry(d, &r->mon_domains, hdr.list) {
>>> +            ret = resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
>>> +                               rdtgrp->closid, cntr_id, false);
>>> +            if (ret)
>>> +                goto out_done_unassign;
>>> +
>>> +            clear_bit(cntr_id, d->mbm_cntr_map);
>>> +        }
>>> +    } else {
>>> +        ret = resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
>>> +                           rdtgrp->closid, cntr_id, false);
>>> +        if (ret)
>>> +            goto out_done_unassign;
>>> +
>>> +        clear_bit(cntr_id, d->mbm_cntr_map);
>>
>> Please see comment to previous patch about the duplicate snippets. Snippets can be
>> replaced with single function that also resets architectural state.
> 
> Sure.
> 
> will combine rdtgroup_assign_cntr_event() and
> rdtgroup_unassign_cntr_event().

That is not what I suggested. I attempted to clarify in response to patch
with original feedback:
https://lore.kernel.org/all/c36e0c76-1666-4a31-984e-1ee6aed2e414@intel.com/

> 
> I need to rename the function. How about resctrl_configure_cntr_event()?
> 
> 
>>
>>> +    }
>>> +
>>> +    /* Update the counter bitmap */
>>
>> What is the update?
> 
> Clear the counter bitmap.

Could you please update the comment to be more specific? What is
written can be seen from code.

Reinette



