Return-Path: <linux-kernel+bounces-175221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3000D8C1C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 04:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76724B21C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C291148843;
	Fri, 10 May 2024 02:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ab8O8saS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF40F5579A;
	Fri, 10 May 2024 02:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715309259; cv=fail; b=j9j2I69deB91YVS6kfkVRiq64vNNOI39D3uOObqafLELr3+lRCFnC+MfQU07u3V4Uz7FAotmRBe48bzlRE2UMsqqPCEfFb51e4WLwetfdxihKzWd7hSl+vzjUmywh9K4//ZAfjd+utYbpv2ndnMxARk642YkFnRrzvHQhWgBap0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715309259; c=relaxed/simple;
	bh=8clE1IMVwOpjplljvAUovng/Cq9/BNbhjkvE2N2PVGg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dpqr6PRS80t9lwFZ/Ep5rhP0wlMOVMHvGdKAOlchESjDem/DDQW1b2uVG5T1LOBB4ic2m8XYmEusWNRkhmocyPSbYoxj3buEAkA3sXGkGPtGTxsufQRsEZJkeSxpHV3JzSUeKNZrCbI3gz5MlaposVX5xuw/rXmWj/Ul8xRAeSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ab8O8saS; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715309257; x=1746845257;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8clE1IMVwOpjplljvAUovng/Cq9/BNbhjkvE2N2PVGg=;
  b=ab8O8saSreE0N7jgEAolG4mbJht3P+1VBCVbnbXq+8mVq8DhliBgKQAm
   D7Alb+Tfk8umv0ESASg0FTwHnjd8yeQ8K3M6vcfoFLAUCsSLN1QittOzM
   NmNqRUa8bcZefee5TJ0Pm6NRrT77ZTYwBkiVhKtuI3Nk4fi698CvVOQqT
   D5w04oGqeFpxfjIphXPN2leXkH7z8GnQc+MPvU9rg7uPjOjHiOCHsO2xC
   CBMoV5n0XC6I+NGq6ypSkI1MJ+KmPZ9LpLTjrVs132hPCKNMumVb3yuwa
   l/ljzHb35+0jxp2xmxE6Z1NL5U1fGBWeKdbb4/9RdQlniUBKcFadRtpA3
   w==;
X-CSE-ConnectionGUID: w0uPYZ9jTOCP74STrfa2KQ==
X-CSE-MsgGUID: 8hRkXE4ZTbepW8IUpohknQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11105203"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="11105203"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 19:47:36 -0700
X-CSE-ConnectionGUID: PgkL4Bx0T6iJzTrttqmG6Q==
X-CSE-MsgGUID: casoXnD8TCGrY29CxD3rsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="29461231"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 19:47:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 19:47:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 19:47:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 19:47:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 19:47:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FawEBkg+xFleaShmbu0F/tHopxbEpol2t9Eei+950cfZUgz31sECZ0le2PjmH0TlAdJd316Nk5oNxePcdiEGYaD7IrH1TK924xksCHOhfFe9b3IPWDUk8DkJVWjqiqqBrebffZaR4/ToZ2lcKyFB81tXI9wzMHEoSYDXTlJn+HNrLyetGlvK8USCNVqzPrHSS3vNawgdJ7idRl6jhZe8inJnPyFiaaCZTcr/XVpRmSeYGAT9ikpaYH2yGKp2WF7NVp18RvPTBlo6BjsnSIEnw9BGE3oXDcOm1Fz2KdLLam85YEkwY11ULQd7r1BhyKK9l4gnE33KxnFSH8vQUu0VDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0yE/3O398Gro1QFG+RhseHtynb2M4QpxsO8U0yAi9Y=;
 b=ihPuDWFnQvQ0RKRfhleGN8cWQ5XGOsx7xKhHsc5oydzNcOvYHmgT5UoGp++QZgLE/Lj2y+CsjFFJk+CrA83ZyjBRjsOkOBN1a5I+vC+MyD98VSNtijvqfq35H/9r05u4ADDUWBuQfA10hGyU2BuAqOu7rQQoL8i+Jo0SfmRTETtLZPUWhyXeEGAKSn611GkIDH+Dn5nivi/6UZhGThC5YI1lBgzcpV4ruPfDhJPLRoYfDlIsaEU5l24prZPhDcdX323qFvYRvzVwf5z8AvlM1WbUJG8LlYunQW+rWIuoIWGDTWhNtpJcjtHIwXq11KsrzqaZHGoKDSyQg0ho/4nIbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5147.namprd11.prod.outlook.com (2603:10b6:806:118::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 02:47:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 02:47:27 +0000
Message-ID: <6a6418f4-9167-4da0-bbd1-740b226f4c39@intel.com>
Date: Thu, 9 May 2024 19:47:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: <babu.moger@amd.com>, Peter Newman <peternewman@google.com>
CC: <corbet@lwn.net>, <fenghua.yu@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>, <james.morse@arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <CALPaoCjZ3oLdKymJjASt0aqtd0GGOme7LavvYOtPYTb_rA-mYQ@mail.gmail.com>
 <b35dc4e9-7e8b-42ed-9a51-ae50d521cf4b@amd.com>
 <CALPaoChxYoJx8eR48EkSKf-hu2p2myQJLZEhj_Pq6O4R15-=5A@mail.gmail.com>
 <6edffe1b-e9a9-4995-8172-353efc189666@amd.com>
 <ab2a6a4b-3740-47c6-9443-e6bb7a0c1adb@intel.com>
 <CALPaoCiYFKeASPMDwzzaHLw4JiMtBB6DTyVPgt0Voe3c3Tav_A@mail.gmail.com>
 <b725e4ca-8602-eb26-9d47-914526621f52@amd.com>
 <380a91e1-248a-7d35-4da2-2bad2ddc6005@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <380a91e1-248a-7d35-4da2-2bad2ddc6005@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:303:b6::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5147:EE_
X-MS-Office365-Filtering-Correlation-Id: 277cd638-bd9d-48b4-4a96-08dc709b8741
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nk5nSDhOUXRqbEtaQ3ZRUjV4ZTJMRWIzWmQ4cDlhNEg2L1VPUkcrSklGY3cx?=
 =?utf-8?B?QXNIVVNjM2RJcTljZ3ZNdkhNNy9RbmU4TjN5NHd0aU0rcGozV2dlcnBYOTdM?=
 =?utf-8?B?WHN6SytuV01YSjZZUzQ1cmx4c2JFM201ZFdHblhnUWk1cnVQK0JNNHpzSHRl?=
 =?utf-8?B?NmU2YnR3TVlwNDZKTU5kcWF3UHU0NUpqUWh2b2I1LzlMeGsreS94eGtqVWhR?=
 =?utf-8?B?Q3YvblVWcU1BQVFMQU1vN282ejY3YXR2Tm82b3o4NkpjQVlkQThObnd3bldi?=
 =?utf-8?B?OG53emx2NFNRRjBMZVgvV3hWV3VNbDRyckkyTVJrKytOMXFvMHdzT0JockxH?=
 =?utf-8?B?SU9LRHNqQURFc3FuekRYZElDYXk1b2c3SE51eit5VFNKZzBFWm13QVUzS2Qv?=
 =?utf-8?B?YjdpV2l3Z1JmZjFpZmtVbnFJam1uSVFWSjF4b1BqcFAvMFJwTUxCOVI5dFdQ?=
 =?utf-8?B?dUlXei9oS2svZ0hwMklkSUFnakpENmVjTjlUM1dTSTAvR09LN1JjVU1aQWlF?=
 =?utf-8?B?T042N043aEpOOWhOYlpzWHV4UjhyMFozMWM4eFBmZ0xjSFQzVFgyVUFpRVBx?=
 =?utf-8?B?cXM3TDg3VEFGNFBnL2VuTjNHSWdaa0tmd1o0dTNGcVBzbS9XYjZSUVpvQnFv?=
 =?utf-8?B?SjRvR003NkxtZXpHcitKZzRhOUw2dUNGQzUveHBtNUc4bXhqVDMvU2NKZlZM?=
 =?utf-8?B?OHBoaE5oZlRIaDgxL3EwR2NlNUZLZUYzMXVXdTlRYUg1dVdmOGE0UGMxWWw4?=
 =?utf-8?B?R2lHb2VhY2tlRWRqRWVsTnZiWENic2hVNjNwNDQ1SWVkbys2VzYrMEhZNmpG?=
 =?utf-8?B?RmJRSWZFYVhhdmdUN0JxQW5MWXNoczdDLzh6YzBFWTlRRTZlbDhGWTVFVXZC?=
 =?utf-8?B?R1RxVlMxRUhHZU53OFNHQlQ2Ym10ZDIyaXltVTY4Nm1RZUMwcXdOVHFYNzE4?=
 =?utf-8?B?c25hdVYvMkpzY1lXek5Hd01YWHpRQkFXQlY3NmFzWmJHWlJHUThpS0R2aWdl?=
 =?utf-8?B?dFhHQktQdDFad3FzOHJlUVlhR1R6N2xZWG5nQ3gwaUx6dFZGZTRNMzRES0Vj?=
 =?utf-8?B?YzFYcXFiTkZIcVZrNHV3bWUxSG10SitmbThtRlBaTmYrN2Q4OUVCY28ycW4y?=
 =?utf-8?B?V1FqbWVHZlBXQWMzR0JxRWcxSlNHcDZ4a3dtWDFTUDJQbXRlTUtPek4rN3hz?=
 =?utf-8?B?NTZ5a1NkOGNnWEowQWhOcUozYjZGTyt3Y3JxeW83TkU4QTdubm5UOUVGZWd4?=
 =?utf-8?B?cWZwY2tWU3A3Y1RseG9yM2FiSHRuWEhHem1BS2E3Y0p3OUhGL052TWxQUEVa?=
 =?utf-8?B?bEJ6d0FiYXpCWVpBMUkwcjV2clhBaG45NDk4U0VKenZJM2p3cWpaZ3dtVmFL?=
 =?utf-8?B?ajVtNUkvOWxQL29wTUJjZGd5aUN2a2pNU000ZCs1ZkVYR3BtWEY3NFY5L1Nj?=
 =?utf-8?B?bTJWbXRVOTRWWm1EQWt0a2dtN2NzOElFdlVYbVBjT0FEVVBvRHFuVXJqUkNG?=
 =?utf-8?B?ZEtkYjVGNGl2c2gyVDhaV3NzckZENWdtdFBYRTVGS1hreHVwUTNLaW41WlpG?=
 =?utf-8?B?QmRRbHZ3SnlDczFKZUMyUFJWY01LS2hqZTFhTTZ4RXhtYkJUN0YzcEJTK1N5?=
 =?utf-8?B?QWF3ajNwaCsrYW1ZQlJUbTZLbEhlM1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmM3TWdGM1BGd05PT0l2YXBJTnZ4eENXaGc3cnNkb2RqQUkrQlFYQU4zNWlB?=
 =?utf-8?B?b3RCTW5IUmIrS3JKVDlmT25vM3NydWh0T3RnQ3NaaG5HaG5vMEY2MTBOUmhl?=
 =?utf-8?B?WklPZE51QVJWVzUwdjQ4SHZqZ1k1aWtmamVTQUNNN3drVlBDelFEUzJZWFln?=
 =?utf-8?B?U3RXM1l4SHV5ZnQzVmNLTXUwSFAxR3RYKy9WV1hhdHNZeVdVODg4eWZnRCtr?=
 =?utf-8?B?bGp5OEROQUcxUnQ3K0xNalY0Vnhmc1FGRG5OVEdsei9FYU1BS3B1Nk5QaTBN?=
 =?utf-8?B?NjluRUQyMzhJMTBIdUw0N2NCS2ZmV2tvM3pGeEk5OC9uZFg3R2JOaUR1UlMx?=
 =?utf-8?B?TWpyam54WjViYklsUUtxUS9ROWxlN2VRVGpobWJwbU5aemxZZ2ZRdTdZN0Qw?=
 =?utf-8?B?U2psUUpaMDdlbWFIWUYxNDU4dGduZWZDN2ZrT1VINkhQZExNWmRtUzM1L0M5?=
 =?utf-8?B?V1Z5MjVvOXFRQUFtRnpYL1JYdkp2KzRhWXpZSHovRHA3U1dSTkNuZ3huMU11?=
 =?utf-8?B?TTNLWEEzeWZUa0hCOEFyUHdoU1k2dWdsSnRXY0FtcUo4WlZSWjRick9rdThB?=
 =?utf-8?B?bXlZd2NNdStRajFiSWZzcll3bkFVS1V1bUFqZG1TZ1p0NGI0dlhTeGVPeXhx?=
 =?utf-8?B?eDNud3dwYVFkbnBOQzU1TUR4cjVTS0dLelhxdDY1UnMxWnhpd0NyWmV3NEdh?=
 =?utf-8?B?aUhwekJnUHJYL3pna3hwZHlYUldtcjRRaXhXM2p0TGJxdERzMDIyR2JVWWxr?=
 =?utf-8?B?NEZtU1RkTVJFYW9jQWlRbEFCYnZ1UWxVR1VmZnJnT0UwVW80c0pvdEdFc1Ju?=
 =?utf-8?B?UnBjenlraUtJNjJGendNaHQ1UE9VNFZ1d1RuZEdGRmlqcDQxczlFVmZYM0kw?=
 =?utf-8?B?dzJpbEtKckZ0NmE1OUdhQ00rditVNFlxNGU4dk5pZXhhSUN2aExPdldnaUVH?=
 =?utf-8?B?Mk5aSmpTZDBJcHlyVlpTclpKTy9vd2U2MFpyaHliMWdnellvNkJZK29Xand4?=
 =?utf-8?B?a05YbDNGcG8wSTVCTjNobk1iV3ovQUoyQWE5SUNiQzhyVVp1M0VHaTJCdU95?=
 =?utf-8?B?Z3JZaVpKYjNqcmdqWDQyY2Z6Z0h3TDF4RzJQTmJDYU1zVmJoVGdTMVlIYTBD?=
 =?utf-8?B?cHhiSmR3THN1aFZ2c25CNmFxeGs0WHZCTlM1RHFXNmZSbFp2Z3NxVjVocXpO?=
 =?utf-8?B?VE0reC9xVmZybWU4ZHFST1E3eHhpMktYZkpOVldCNldkL2UzQlBiNTVNY2Vq?=
 =?utf-8?B?UTBrcE1nbkdzWHVnR00xU0oyQmpMYjdJeHRNeEJXUjc3cDRjYUVkR3VvV0xL?=
 =?utf-8?B?Z2IvTDlhMzh5WUtIUVNIM0dGQldrS0dCdXlNRzdNandld2ZpVkdmN0cxZEh2?=
 =?utf-8?B?bzJ3RUNCRlVFbmRMUHdyS1ZoWkhZdWk3Y28xQ3RSWWdkLzFUYW8wMU1NSy9m?=
 =?utf-8?B?cEJpOWZQZHRHS2ppOHZ0dmF4VCs0V3RhOWZ6emdhaW5TcjZEeFZxN3dKM3Np?=
 =?utf-8?B?STlIbDV2b01YUldvQVFzbC9OOUtuUVFKMllCOTZueUVsMEcvZHlabnZDNy8v?=
 =?utf-8?B?TzVscVNBVk1BM2ZUaGNjNXFHRVQ2UGhCeFZZcjJ3UmZ4T1htU1NTZEc1UGU4?=
 =?utf-8?B?WE9SNlc0ZXJ3NWF2bE1nMFhHU1pJdmVTM1dZT1BiY3N2S1lDN3A5aTFiQ2E2?=
 =?utf-8?B?ZzFGdzN6ajJmbEZIZ0ZTZ244K1NlTStNc3UvcGE5K1IvS3hyY3BxRG1HTkpC?=
 =?utf-8?B?dVpGMDZEeE5vcmR3S3lHMFVEVlJ0OTJXa0RscC9QUjlUdDNaRkxPUjF5ejRy?=
 =?utf-8?B?dkdObUNxNnpSWlRUelI4YmNFMUNnZXZZcWUzaTZMZWpxbWMwMUxZNXVXcUlt?=
 =?utf-8?B?WmNHNDdxR0FQZjU4aEREUzhndmQ0YjdnbktWT1BPSzhyQ0w3RXNIcThMQW5I?=
 =?utf-8?B?WVlIUktSQ0tQdTVvZUpDT2ZTVkV1c2JVZllwSFRIUVAzQ0hZODNucUFyMXo3?=
 =?utf-8?B?QXpMSTJIUjRZMkhsSFNjUGxMU3lrTFVZT0hYdlJDdWoxOWRIZTE3MkNYRTZz?=
 =?utf-8?B?Zll1YlZYSCtoR1RMdWFRbVdFRkdiRFV5WVdodDd2ZXFTaGpOdG11U2dBWC9G?=
 =?utf-8?B?akhPTkVYOUxOVDh2Qzd1SlRIaU1YOUtPVExTZ1VtNEVFSjBTU0RMQ05IK0xZ?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 277cd638-bd9d-48b4-4a96-08dc709b8741
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:47:27.2471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcYCLYI8tQEHepuAc5zStNjQdkL08IqoySB2A/ijzwNHoD4NgMyaBqgGdgiCSiviIRcNZncv7uh+NDJeRCS8H0UmgtuD4jBTIxTpV4LOKiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5147
X-OriginatorOrg: intel.com



On 5/9/2024 5:57 PM, Moger, Babu wrote:
> On 5/3/2024 3:44 PM, Moger, Babu wrote:
>> On 5/2/2024 7:57 PM, Peter Newman wrote:
>>> On Thu, May 2, 2024 at 4:21 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>> On 5/2/2024 1:14 PM, Moger, Babu wrote:
>>>>> Are you suggesting to enable ABMC by default when available?
>>>>
>>>> I do think ABMC should be enabled by default when available and it looks
>>>> to be what this series aims to do [1]. The way I reason about this is
>>>> that legacy user space gets more reliable monitoring behavior without
>>>> needing to change behavior.
>>>
>>> I don't like that for a monitor assignment-aware user, following the
>>> creation of new monitoring groups, there will be less monitors
>>> available for assignment. If the user wants precise control over where
>>> monitors are allocated, they would need to manually unassign the
>>> automatically-assigned monitor after creating new groups.
>>>
>>> It's an annoyance, but I'm not sure if it would break any realistic
>>> usage model. Maybe if the monitoring agent operates independently of
>>
>> Yes. Its annoyance.
>>
>> But if you think about it, normal users don't create too many groups.
>> They wont have to worry about assign/unassign headache if we enable monitor assignment automatically. Also there is pqos tool which uses this interface. It does not have to know about assign/unassign stuff.
>>
>>
>>> whoever creates monitoring groups it could result in brief periods
>>> where less monitors than expected are available because whoever just
>>> created a new monitoring group hasn't given the automatically-assigned
>>> monitors back yet.
>>>
>>>>
>>>> I thought there was discussion about communicating to user space
>>>> when an attempt is made to read data from an event that does not
>>>> have a counter assigned. Something like below but I did not notice this
>>>> in this series.
>>>>
>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>>> Unassigned
>>>>
>>>>>
>>>>> Then provide the mount option switch back to legacy mode?
>>>>> I am fine with that if we all agree on that.
>>>>
>>>> Why is a mount option needed? I think we should avoid requiring a remount
>>>> unless required and I would like to understand why it is required here.
>>>>
>>>> Peter: could you please elaborate what you mean with it makes it more
>>>> difficult for the FS code to generically manage monitor assignment?
>>>>
>>>> Why would user space be required to recreate all control and monitor
>>>> groups if wanting to change how memory bandwidth monitoring is done?
>>>
>>> I was looking at this more from the perspective of whether it's
>>> necessary to support the live transition of the groups' configuration
>>> back and forth between programming models.  I find it very unlikely
>>> for the userspace controller software to change its mind about the
>>> programming model for monitoring in a running system, so I thought
>>> this would be in the same category as choosing at mount time whether
>>> or not to use CDP or the MBA software controller.
>>
>> Good point about the mount option is, we don't create extra files for monitor assignment in /sys/fs/resctrl when we mount with legacy option.
> 
> I think we still have not decided about the "mount" option for
> switching to legacy monitoring. Mount option seems safe at this
> point. 

I have not heard back after sending [1] so I do still believe that users
may want a way to not have soft-RMID running all the time without impacting
monitor and control groups.


> We don't have to deal with extra files in resctrl filesystem
> with dynamic switching.
Reinette

[1] https://lore.kernel.org/lkml/ea56c630-80f4-4564-beb3-2b61e810a558@intel.com/

