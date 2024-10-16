Return-Path: <linux-kernel+bounces-367180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C8299FF88
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D171C24733
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF99918732B;
	Wed, 16 Oct 2024 03:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lh7/TKdO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37195184549;
	Wed, 16 Oct 2024 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729049449; cv=fail; b=Iz8XvzPSprwLlLsEQqyEj7A/2Shg5bdlAd9w8x17xhntdJ1QDgphnG/CMp5JK6xZCd4/8KzUZkWP9eACxELCgw4nV7wX5111VeuT9XYovcNGByIdSGJchb3AxVnvc0T4C7YWqZsWCVEAnzTo5cKaJmtel/c+OdqBJFtOSl+ZFSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729049449; c=relaxed/simple;
	bh=tyVIXzxXgvlz3U+k2TJlLldJW3Uf8DnOEGGsok1f2ks=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tj4pu0MRz2RiiykFiWIk2EazjLN0VBusKlizQFr+wq35OXn3glrOVsaq6K+Pa2ldMD2sWAorYGziUxc570pAkjWFZ6/9VJxAe/IgSxoRsZEBOqES6e1vbqtfPjVKKrx+TEVD5sWdf6AvgVyOqyRjNVla4tM9vhD726062g6HvEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lh7/TKdO; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729049448; x=1760585448;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tyVIXzxXgvlz3U+k2TJlLldJW3Uf8DnOEGGsok1f2ks=;
  b=Lh7/TKdOMXkTR3BK1gzEFz1dpyWgJbuN5RD2XpT0xXGMW+O1wykRsmbx
   i4WruBYwRQLFRyb5REl/8u0B3ACFNVxgOymrfwsFC5Qp7XxAs+8Q9IRpJ
   MQvUhFRJTzCgZ/KE8TvBIxxvKeMq15sLaZ9vMb4Oyt7tSUyp25QxuPKZT
   yi07dUvIKuMW6eUkFb7WWxNrOarPvH823R6mDPpDXXi97n94kDLwyZxG6
   nlq5+mknKO/zoe/K4qCSY/w2ARUlCUH6B09eaj+uQMsBkxCE+JF/ukQOe
   QqcTp9SF66OILNIT5ti66ytg3m/4F8V04gIpz00aG2UdHEKmVRAzHhVLY
   A==;
X-CSE-ConnectionGUID: eI546J2hRDCxC5aPwNlYJA==
X-CSE-MsgGUID: ir1877GJQ/ywViMAome2ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28611347"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="28611347"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:30:47 -0700
X-CSE-ConnectionGUID: wf+sBPo5TMeONau1J7HQvQ==
X-CSE-MsgGUID: pYVP2N8gS7ymgXEAqMpjYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78268805"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:30:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:30:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:30:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:30:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wb1wOnW2XkAvLO8kUQFeAsGml0+0VdegqEAuVgtuq/vlul6DBWr7uzPBvikRH+xaFEawcgeexQC8UFB3GNQN3WgJF9I1w2pJwatHIKWO+tbJaxBAn3YEA+NXoDjGggRGKpRD362ZYHzG9A8o9kLwM+ONOgHpDQscP1F9ryGf9Jxxu0gU/b7Dxr/BaD3O0wRYCoF/q5nj+b0pcN78CvbY77fVovINP7KBBSs8xmr85tHitRI0xu/tYckSE5gO6qpT+ePdxnu+QkJFidDSkLJRAtNGXdDZbBk3YFuxTB56ZMSH+uOgTCIr63nChwIqSBFLF3NjYtg1s7hLSJGPKkYKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kLGuZYCbtq2LBllURNBB1Tlb1ZsOLMa3CnyPpzEARY=;
 b=UfbzlRbyAoz6+9l8SSWDnYR3qOJVLkBwGhsPr/zIBQjfAmLzHZiiDjDNCiQSHtL4yiWXVqAaTLD5KF11ED+UOagZXDKQPNTg6url4mq3lrtXhuCEiyhtsR+AplFfMhSMONG1hWjW4iGMec6ync6g9nw/1mj6K8vASNTpfChKSWxbzUEWG2E+tflyJCEO53YnUP7Hy4KYTeihWUg86UWuxq1By9ihN6Nppoz5h3M2iLCjVEL5zUIzZmcMm1nw+IT0942aTHWyCsL+0OZFi5eT5Jru8pN4i13YOYVvtjPwfnL3rr9o0TLz5HPbr05PO4YYrE5RA9D2YHKYLQKA+fkJ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 03:30:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:30:40 +0000
Message-ID: <6c2a4904-af6f-49ac-b05e-65cba54f81ea@intel.com>
Date: Tue, 15 Oct 2024 20:30:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 19/25] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
 <ce07d802260f537b24b3affec57c2d2e65023709.1728495588.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ce07d802260f537b24b3affec57c2d2e65023709.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:303:2b::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d612de-033d-4e61-1ba6-08dced92e848
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXA5MmhLYUkwSGtQWUpKRU5YU1Jwb0pSQkxKUTc4ZnplN2lxN0U5SUdPdjN3?=
 =?utf-8?B?eVVKODJpdTlGU3M1eHkvbXB2RWpNQ1ordDBHb3R0NzVUaEV6WS92bGRSN3or?=
 =?utf-8?B?L0FUaVFjOTlCMnJFdXpDbWNRNE1jMllncnhxbDNaRGZtaFpmT01xbTJXNUh3?=
 =?utf-8?B?bzlua0EvVEtlUkF1VkJIZ2FtZ0tHM2lyUTljMVFMbXZtMU1URTZMcmRobzRl?=
 =?utf-8?B?UnU4bkREdk04dWFmMmtpSWc5TUZpdUhrSXkwVUVMaW96cXB6UE14N2g0QVpW?=
 =?utf-8?B?N2NKMk81WkY1Q3JET3h6emwvYkdNZXVXN0Y3ekl4RjdGWkFWYTZEZkdQUkM4?=
 =?utf-8?B?VGVFaG9FN243VTlaeENTUlExNHdZZzFUYThUU3BMUUlTYUhocGlmWWtPSnN1?=
 =?utf-8?B?R2ZNSWZLRGRXbDNTYk54L0p4aktLdXVxVGtSa3ZEbkpMaFdDTGhVaGtGOGIr?=
 =?utf-8?B?Qzk1MzhhSFh0M1crYUZwcTZYbWpQSDR3Qi9DN2ZnRTdkUHZOTHkxVCtPOU05?=
 =?utf-8?B?RnIyc3p5bEowUVh0MDZpalRhOGdVem41YlVNRXRtVXVBcVQwbVZKaHJDbHNo?=
 =?utf-8?B?d0lJRThKbkFlR0M5NkduSkJTT0UyMlVnZzQ5VDE4SVdGSFIxRlNRS29KczUr?=
 =?utf-8?B?ZWRUaityZm9YTUZCOGVTOTdKcldTT2I3SnlBQS9PaEc1WFNwdUJ3Sm83ckg4?=
 =?utf-8?B?MkFtVHFKOGNIcThFeXRQYkl4VWwycXV0UXpySktJL1FLakNESmZPRFllN0VI?=
 =?utf-8?B?aEU5NW9RbHAyN2VYMCs0WXJmVmxqb1ArWE1QZGlFQVpBMkxORU9vczlQRzhF?=
 =?utf-8?B?bmNGa0FtOW1TNUxWa0FILzBML0ZLRk52SjNsQnBCRmdzSEdJcEpaSkdZRUZw?=
 =?utf-8?B?ZzUzU3plRG5PTGdBajlNVEFmZHRWdit0ZFZNdndEWkJ2bEdJdStGT2QraEJH?=
 =?utf-8?B?ci9YR0U4cE9id2NQNkFrLzdiNXNKOEhESXIveFZoUnd3bGVaRTJSUFE5dHVU?=
 =?utf-8?B?Wk5pOExiMklLaVFrR1JnVUF5bXFZSzFqenlDWEdwMmVUdFRqckpBK2ZtVFVi?=
 =?utf-8?B?VFNOQ3R0WVI3VDZ0RERHcDE3MUZrWndDMjkyS3JFSEFzVTQ3YzUrM0RjRlpi?=
 =?utf-8?B?K2Zwb0hidExMLzg1VWZER1RkTVVGY2hzclVrVUcyRmNTaTd6enZiVlJYZlV3?=
 =?utf-8?B?RFJlckN4bVZMYUc2UDFEMGFnc0V4cmpEWWNiK1BQSWFlaWZYclB2SWNmNTdh?=
 =?utf-8?B?YkVTSk05YkJNalVDTkY2NE1TOUlzWHZMT2g1Z015NjFqVDdOdXhDV2tSREM1?=
 =?utf-8?B?c29QVXF4V3V6RHU4TjhRdENPbWY4UzZMWkJPb1NHcnZlQlFac0x1a3JJOFVs?=
 =?utf-8?B?SVJlWWRsTjF6VDZjRHZTUmdiMHc4bFh6U2hZMDNxUVV6MVc1bzd0MFFGSzhh?=
 =?utf-8?B?OXQzN0Z2ZkxIaW8rR1JFanRocUtVOE5KRXZYUHYvZTFlaTEwMGtGTG5VS0xY?=
 =?utf-8?B?Ry8xLzlMTzJkQkdrSGYrdnZISDNCVEQxQTVFcUp3ZFIvRjk3eDBucXN5eWo1?=
 =?utf-8?B?VlFsQmI1WHB5NHNUMjdVTkZTV3RGdS9BK2ZWemhnN3gzb2dPT2NWUnhFSFJQ?=
 =?utf-8?B?NFZTWUNDRGV2d0MyeHQ2ekRYYlBvTTJtcExlMHg2VEdsU0xDUzcrVVk0enVu?=
 =?utf-8?B?TEpaakNrQS8vZ3ZYRm1PMncrT2hxY3VDRmo5R2NxRzdrUGxpYWYwVW5RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjVickxTMnJtc251TnZXVWxDMFkrN3ZqdUhpNGswRGhWelJXMEhNVzlqRG9O?=
 =?utf-8?B?RTJrVklBdVBzeTNvN0Y3QTkzUlBZeW1YRERxNU4wZjk1OXlwSENNTlZCLzVG?=
 =?utf-8?B?Q1I5TEJubVJhdUoybXV2YS8vRmcvWStvY0NrdGNQRmNpK0FBUEFhTjhiVlpH?=
 =?utf-8?B?eVdWV20ya0JTZVkwN3YyZmNZeGJNVTdNOGVOTngySFlGK1dOTmVOWUs0T0Ry?=
 =?utf-8?B?dFZ1ak9lNGZvQnU3YkszTmtJcTFNWndCZzk1VUFRRVZoMlVFTmxrQkw3R0Rw?=
 =?utf-8?B?S2pISTh6eWpOVkI3MkpEV3l0Z3Vocm5JNXFvd05yUVNNOW5ZbFloZmVBNjRq?=
 =?utf-8?B?Y2FITlUrMzZlWDF2M25OQ0wzcUd4bmF6WUgxenk5WGs1R21pWnRIZWI4OEM2?=
 =?utf-8?B?dGhYYmZzWnNuK1FLajFhWXFVR1pvL3FBekJOZ0pqR3JRNEZCajBJSE83bzBj?=
 =?utf-8?B?K2dpQWpIcFFNODdORXptVkR4U0wySS9ROFdpckQ4aHIyMGZVckRBTlh6eHVO?=
 =?utf-8?B?Z1A5L0dta3JTNXBiZFNNdm9nZmlYd1FxOVIvelNYMisybmF0aDg1VkhYWFBN?=
 =?utf-8?B?aGhBYXV2RTY0NTMvRmZvMVZDMnp5bEEvbDhINDdrTkVnTFgrZEtVYWRVQm5y?=
 =?utf-8?B?eS9KUURzYTBwQUgvWXdvN0NPSmdMU3FUSDdLVTh4MG9wRDRZZ3ZlSjJweWxw?=
 =?utf-8?B?TVFjUDR1Z2JVblNNVUJnWlZOU05PdHMrVHp5VnpKam5jUklaZXRXQVJxSGt3?=
 =?utf-8?B?YWhEM1Rtc1cySzNkbmVnN3RLRkVxZmNYcEQ5cGc2cjFMRXhhTllZd21Ga2h3?=
 =?utf-8?B?UWtFSVVERXpQZzhiV3VUSi9QRytiQktVb24wcGRvZ3ZJMXpMdkNPWWN4QnpK?=
 =?utf-8?B?RWcxK3ZkOXo2Zmw1Ym5pVVgyZ3owdFdSL3ZveE9yKzVvemwwM0VJZ29ON0Ey?=
 =?utf-8?B?SllPZ0pHMERxVkozTklZRDFVdmdOcnJOZHZwL2JNUmV3eExZaGY4NzRJMGZ3?=
 =?utf-8?B?akdhL3Y2V0dPY2dWSzFjNllCZnFlUjJ6Z2ZXKzZrWVg2Z0thTHV6QkxGZ1hR?=
 =?utf-8?B?SnpwRnkraEhPcHdhcVBNNWhIc2dwUTRKODR2bEVvYUhxMHcwMnVmc1gvcWpj?=
 =?utf-8?B?eUxVcmJNNkxwUmNEajZJY011elIzc0tTQWlCUFhYM01kakVPSjhhcXBLb0tY?=
 =?utf-8?B?MjFYdHBFNmpVYXZGWW5XdTFTZFhiejdYOGxBRDYwODRDKzJ5S3h0aGR0RHBi?=
 =?utf-8?B?cldCd1ZJcmpyQVJGalB3b2k2M1BjS2tYY2IyUGJIUjl5L1JzMllEMldaL0Y1?=
 =?utf-8?B?Y3hpQ2g3eDlWazZjTTByRkV6OWxEcFlmRjR0NWNDYU0zd0p1Qy9CNm1GWUNm?=
 =?utf-8?B?SzM3TkFub3dYNGNVSUgrUTJzQ3RKNG9EendZSlAyNU9tZm5yaHJEcHRXNkFF?=
 =?utf-8?B?Yk1zNVFpeXRDTmFta29hNndrVGpLK2wrN2YzZ1ByeFk3Q0ZTQ1Y0TG1NVkFy?=
 =?utf-8?B?YlBsSm1CTkhmZzFDbFA4MTVzcHF6YXZBdkduYUsyT2E1YVExVzFkZlExSXlp?=
 =?utf-8?B?ZWdTWXlveVJoVDArVVhpM3pPa2ZmdmpzTlRNaEY5RFR0cWVtemI4SzdERmF5?=
 =?utf-8?B?THk2WDhpMHRvQVFVV0NoU2NUUzRPSWhUSjhZQ2hFTjF4NTRUNzF0d0J1NXFy?=
 =?utf-8?B?VDNSc3pzUVlqSExmUGlFWGFuUjBINXVKS2pNc0RQNDJWWGhlT1NPWXdNSDR5?=
 =?utf-8?B?cWhqWGhoM0pKNWVQSE1kcFF2TnN3SFlQbnZRODQrQTBZZVFuRGhnOHRLY1or?=
 =?utf-8?B?Z09vQytCRHhpbWZSN2p1VnpvSjBCVnFscEcwWUJNOU5IUGVGc2hiUXRkanN3?=
 =?utf-8?B?a25uUFBYZ0d0S0NvSUtzNTVCemxadkJTUHpDOWdXZU5NWVMrbDV3eStTelpP?=
 =?utf-8?B?VEpYb2hqcWp6TVluL2hkU0Y1SGZIOHEzSWIvTUI4SktiYldpSFh3cjQzMjdE?=
 =?utf-8?B?YmM3cTlVRGhPcFljeHIwQTE1dkN4UCtublc4VkY5U01LWHBDZTI2dE16cWt6?=
 =?utf-8?B?bnlkUDZHNmUxd3NYNVBzY2RQd1lCbTAzdTB0UHRGZ2VUTHM1WjhheEVMZzVm?=
 =?utf-8?B?Yk8vU0tYMDNLSnpuV1RmemxvQjNrUTFhWkNpcWduTG1nSWpSVi9KdS83U0dw?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d612de-033d-4e61-1ba6-08dced92e848
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:30:39.9040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzLuf9jedU+hs6bF4GBRDMs4oX0QYM6a09Yt6QNu4o5ic8hwNeDqqaMEWzQGokZ5fnj8BGn5ohM8Pg8aBEkwv0N4nuAEoRT/JTLu1zN4FKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> Assign/unassign counters on resctrl group creation/deletion. Two counters
> are required per group, one for MBM total event and one for MBM local
> event.
> 
> There are a limited number of counters available for assignment. If these
> counters are exhausted, the kernel will display the error message: "Out of
> MBM assignable counters". However, it is not necessary to fail the
> creation of a group due to assignment failures. Users have the flexibility
> to modify the assignments at a later time.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
...

> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 64 ++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 791258adcbda..cb2c60c0319e 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c

...

>  static int rdt_get_tree(struct fs_context *fc)
>  {
>  	struct rdt_fs_context *ctx = rdt_fc2context(fc);
> @@ -2934,6 +2980,8 @@ static int rdt_get_tree(struct fs_context *fc)
>  		if (ret < 0)
>  			goto out_mongrp;
>  		rdtgroup_default.mon.mon_data_kn = kn_mondata;
> +
> +		rdtgroup_assign_cntrs(&rdtgroup_default);
>  	}
>  
>  	ret = rdt_pseudo_lock_init();
> @@ -2964,6 +3012,7 @@ static int rdt_get_tree(struct fs_context *fc)
>  out_psl:
>  	rdt_pseudo_lock_release();
>  out_mondata:
> +	rdtgroup_unassign_cntrs(&rdtgroup_default);
>  	if (resctrl_arch_mon_capable())
>  		kernfs_remove(kn_mondata);

I think I mentioned this before ... this addition belongs within the
"if (resctrl_arch_mon_capable())" to be symmetrical with where it was called from.

>  out_mongrp:
> @@ -3144,6 +3193,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
>  
>  	head = &rdtgrp->mon.crdtgrp_list;
>  	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
> +		rdtgroup_unassign_cntrs(sentry);
>  		free_rmid(sentry->closid, sentry->mon.rmid);
>  		list_del(&sentry->mon.crdtgrp_list);
>  
> @@ -3184,6 +3234,8 @@ static void rmdir_all_sub(void)
>  		cpumask_or(&rdtgroup_default.cpu_mask,
>  			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
>  
> +		rdtgroup_unassign_cntrs(rdtgrp);
> +
>  		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>  
>  		kernfs_remove(rdtgrp->kn);
> @@ -3223,6 +3275,8 @@ static void rdt_kill_sb(struct super_block *sb)
>  		resctrl_arch_disable_alloc();
>  	if (resctrl_arch_mon_capable())
>  		resctrl_arch_disable_mon();
> +
> +	rdtgroup_unassign_cntrs(&rdtgroup_default);

Unassigning counters after monitoring is completely disabled seems late. I
think this can be moved earlier to be right after the counters of all the
other groups are unassigned.

>  	resctrl_mounted = false;
>  	kernfs_kill_sb(sb);
>  	mutex_unlock(&rdtgroup_mutex);
> @@ -3814,6 +3868,8 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
>  		goto out_unlock;
>  	}
>  
> +	rdtgroup_assign_cntrs(rdtgrp);
> +
>  	kernfs_activate(rdtgrp->kn);
>  
>  	/*
> @@ -3858,6 +3914,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>  	if (ret)
>  		goto out_closid_free;
>  
> +	rdtgroup_assign_cntrs(rdtgrp);
> +
>  	kernfs_activate(rdtgrp->kn);
>  
>  	ret = rdtgroup_init_alloc(rdtgrp);
> @@ -3883,6 +3941,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>  out_del_list:
>  	list_del(&rdtgrp->rdtgroup_list);
>  out_rmid_free:
> +	rdtgroup_unassign_cntrs(rdtgrp);
>  	mkdir_rdt_prepare_rmid_free(rdtgrp);
>  out_closid_free:
>  	closid_free(closid);
> @@ -3953,6 +4012,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>  	update_closid_rmid(tmpmask, NULL);
>  
>  	rdtgrp->flags = RDT_DELETED;
> +
> +	rdtgroup_unassign_cntrs(rdtgrp);
> +
>  	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>  
>  	/*
> @@ -3999,6 +4061,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>  	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>  	update_closid_rmid(tmpmask, NULL);
>  
> +	rdtgroup_unassign_cntrs(rdtgrp);
> +
>  	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>  	closid_free(rdtgrp->closid);
>  

Reinette

