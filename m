Return-Path: <linux-kernel+bounces-251193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CC99301EF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236301C212B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1FC502AD;
	Fri, 12 Jul 2024 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELuCEijw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A054757;
	Fri, 12 Jul 2024 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720821952; cv=fail; b=X44JyLCEGhrw4I0hUMna2jtbpTI6NX3CgUPjOQiIa8aBn8Q12xysOHT8Alc8Kf+l7fZtdkFM3uv75BKvMRGae8jJBJWaXKrV3pto/J7ZkIdbcn4LrvQrMdt5NzVSBqPPQu7yc+MSJEyjLBOQhIFmQO2KqL/bQ/wBEoFP2tSQs6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720821952; c=relaxed/simple;
	bh=fK1Hs44hdk5INHrlX0KwOPpDFCwJcUhdX8bl7H/fpqk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sb9ZmPFPLR4XabbbjSBzRFXHIp0DKhwhRhtWcZrbBn0QpGufZawSSeV8NlGMGKqy130y7UvXGbLXAQnSnmogbW4YZfJC/bldG3Rww+/2xB70M/UtiZ5fpNgkE4fcHB3DL6MnLheX4L7c8kLRoi1/a7+zaLDtk83Ys1Sb0ILZEaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELuCEijw; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720821951; x=1752357951;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fK1Hs44hdk5INHrlX0KwOPpDFCwJcUhdX8bl7H/fpqk=;
  b=ELuCEijwuzaEMI0UfzIFGlZjpIFjpuAdKWdrlGG3Li+pfhF8K4UgNCrn
   cTMWaSddAhf93GNTiJr2UvQWTpa1M0UHzaeFjALM78cVPorp86/v2pUfb
   QzmHVyW86sW7Duh8znbZvfxWNv7zNdZkAjVRpREkeOR/k/pJ9idyrZ4qU
   PkXf0tpwj+GdcaEQ6Ad/5Pt8tFLxalv8+4z3G/cBowrk5hDOGPtl5nyHW
   II9rpaie9DkA88YNTzHejMSE/8dYqYEwD8X2LS8mL0anZSkI8hqRqUcXC
   yr7bC1D4geLms5Z9UQiusA2wqrRxo0AtqdJTiUn+Ti44mLzDf0YnXpHpu
   Q==;
X-CSE-ConnectionGUID: zoMwrsN/Re2TMVLYVn9Xiw==
X-CSE-MsgGUID: Yqbg+TbJTMi2YzuiavYkRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="35823035"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="35823035"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 15:05:50 -0700
X-CSE-ConnectionGUID: eYqHwg3LQourz3NPXyxJEA==
X-CSE-MsgGUID: gxEFx6yTQKmO9sLOccY4Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="53403784"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 15:05:48 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:05:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 15:05:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 15:05:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwKTeiNCD3XGPzMwr3MgSwrx330qda7X0aLK4ZKx7xMy4JIplLVS/7lF3bMNWmENBalrPHvQkJ9n2XyQlVn+8ao8KLSVfG31iPiartgKNDEk7HKBIDsVCJhMLuVJEnsyDEZ0Q728+xH8ZMNRedxWtCVO+5ibZw17EKysTbfq/nzthZCBf6njb1aciq4P5F0Pp33SMjZjHhXwco8SHuuiZg5/zkLI9nuc0JXw2VTb7SpUYyZ4hhqYPGAu4wt2nfzbksLMKdokpsaXagTSmnCF6MtSjf6nZpjOAENVlJ08C+qbfgNVznbllJF8I6OaBPPRucNm+k6LWAFwHfkZdx4P+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kj4obUhkVJMO4sazz9ptqGbk7w/YRekDh+BnbD5bmvY=;
 b=WLgBUwr8fvsW06KnznEi0+Kdqk1PfMOnnHXmlEB7EmOoLgYsE9bts4+P4annVfvtUVWostr0QoUjORJuV5lgCxW+gI3AvTL2oLE8jf/P+Uw5aYQ9MK2UImY3IfzkVd0itsCsigcPxdv/tsIpfvQHBGUv+FuLhFOyUu9lm4WnpY+MpAWZtq6WFDiyNQaguMx0nzTApB9t/KJNcUdtVIn1CnZQdlnO2xR6WSk/dYXt2Adl69/TfecpIrwXW2iOi1L/HxB86GFlyVpHpz72i7OP6Z7zrsPw/XREeI3zRtcaIn3/tSnPZvlDH/F3y3+ClR2Hy/URefpIL+TMJ5arI6SH3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7599.namprd11.prod.outlook.com (2603:10b6:a03:4c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 22:05:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 22:05:44 +0000
Message-ID: <ca8c5934-c531-4d5c-a765-8722e0eae5ba@intel.com>
Date: Fri, 12 Jul 2024 15:05:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/20] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <ed24fa5b599d6f0abe53a72613f7afd2dc9aeb1c.1720043311.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ed24fa5b599d6f0abe53a72613f7afd2dc9aeb1c.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6e2b4a-697b-49b3-96da-08dca2bec693
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1RUYmN6RWJrWVhjRjlVZDF4WTBpZURWSTJ4Y2IzWFJ1ZGwyTDR1STBsREhN?=
 =?utf-8?B?TEZsWXpYSmRXZWM0alB3VXVZMjBOS0FNaHFIY3RZK21SYTUzMGlHNytRSU9z?=
 =?utf-8?B?RWphdkozVUF3Q25iem5XVHdWa0Rhdm5MM2QrZWcrQW5lQzZYenpGRExQQzZL?=
 =?utf-8?B?bHFIVk50QVRDbFA0ZXVuNUZUZ0grMndQbHVNVUd6KzFaMEpnc010VXBSYXNV?=
 =?utf-8?B?eG13cnplcy9Lc3N3WnA3VDhSc3B6OHFhZnlIdWg2czVQc2VvMkZtSFBIRE9p?=
 =?utf-8?B?dStscG9xVVpLdFBDRHplVUhDSjl5eU9ZRUg1S0s4d2MyWllyS0JaSzJrRTRj?=
 =?utf-8?B?dmtJUDZjR3dPOTBBY2V0NTZwY2VjM0hocUpsbFZnVVZnOEtQR3VhRUtBTVZE?=
 =?utf-8?B?OGZEQWdjUzJWbjdYa0swVWhwUHJIRFJlSUpXMkVzckx2Unk1eHJ0MXoveUZD?=
 =?utf-8?B?WlQzQXhHejFtWmVCRVA1ZFp1eCtCVWNzYk5GMkFKZXg3NUJ3WDlDWEFIMkI3?=
 =?utf-8?B?VnhJRkV0TVkxdW5NcUxZMkd6Y0JCODd6cDd5MzJxVUd5SThqeWdmWTByNDI3?=
 =?utf-8?B?MERGQUZUa3VpZUU5akdtcmRwK29aZjZ2UEtPZDRwUmlNSDB2RXJPdFh3T3VJ?=
 =?utf-8?B?Ti9kOWJyYTQvUlpPbFd0UHRDZXh6MkU1ZHVMTEJGSXZuRkJXbHhxL3I4Z0RV?=
 =?utf-8?B?Tk1hcTNyUjhVdENIc0Z4WHdDbWNUT1NDcVhrN295bFd0ZVhIT0EvR0U5ZlFB?=
 =?utf-8?B?MjluRlZnRTdMdWRxUXh0cHZLbFluN2lSdUhTdjVoYjBuSEpVZmJqOUMyL1lo?=
 =?utf-8?B?T2dJQlNOQ0ZjVUNjODZ4UGgvU1BZMVlkNTZKS0tJUXF0WXVCYlJxNG4rcHZi?=
 =?utf-8?B?cU56ZEI3bENnZC9ocGwvcDN0c3d2TEtORjdnOW9CWTFKWkVha3FiU0ZEbE52?=
 =?utf-8?B?Z0NTdlZxbGFYSGd3QXV2UFl4TE5sME1GZmFQZHdlOTY5WElyRWR5OTJHK2tk?=
 =?utf-8?B?d2lxS2JaTEJubC90RU90dEMza096T1JZaDFYcU0vTWdDZVJrb3R5UEVFKyth?=
 =?utf-8?B?SkhrVUxIdVo4NGpZUUsvYnZoSVFCNUxUZFJtSlVKZ3RLMlB6aENwa0ZqS1Ar?=
 =?utf-8?B?anMxL2VDdmlvZFhFZXpTc2lxNmdMVHlnUlpJUFpOWHBmNFFITGVtS2p0WWdD?=
 =?utf-8?B?dDZxOEZSeXpEL2YyUHdqK2U3Q1IrRzlHajJIZ3ZrMWIrUTZ0TEtzbFBid1oy?=
 =?utf-8?B?Zmc0SEhsbFdjNXoxU2lYd1ZMVXJNWE5oK1lDRjgwUjl0THErSG52QmpFSVZD?=
 =?utf-8?B?a0lSSWVYOHltVTFhTHZndGNwZ1ZraUwwbUcyVCtGZk9xV3AyTkpIRUFjNm10?=
 =?utf-8?B?Z0Z1b0ZPSjRueVhxVUJZR3Z3NHRrcmtvUTdlWmI5cVRnNGsrY09NSnQvTkp2?=
 =?utf-8?B?Y3NiUG9LYm5PenIrbU9CUS9SdVZUMXlXOXZKc2VrS3pzUFlCcCtWVU5xZTlN?=
 =?utf-8?B?RHhpVFNGdTQvZzBDbkxTT2VLcXJwRCt4ZmlYaEplNkl0NGcvMmhkaFNHV0Q0?=
 =?utf-8?B?dGtXbS9ZM2NQeFg1V2RoYkJkSTM2OHU3ZU1uR3hzcXd4bGtUVVZyRjE4cllT?=
 =?utf-8?B?Ykw5VmhHVkt4SDBJOHhRby9hNUVUWjhjeGZUN25YTXIvbVpvdzExRjR5ME8v?=
 =?utf-8?B?eHY4Mmk3cGN1VmNaeXAwVzJQOExoUmNJUzVxZjUwNHZFMXgvZXpxSGpmWWps?=
 =?utf-8?Q?YEuIJXXktBHOG6Bud8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTA3VkdvdW1mRlMzdWVlVHFNNDU1aUNzKy9rR3UxdnVFTXYxSk9nUWFJak1u?=
 =?utf-8?B?bEZ3WnR3Mk5BdFMza3BxenZJOFBRK3dQamMxM3ZYTHE4aTJYb3JUcDVJVFJ4?=
 =?utf-8?B?bEtFS0k3WFhUSk9qYVdON2I5OHB3cjVZWi9ic3dlT3FVOVV4SnQvdkxoaXhX?=
 =?utf-8?B?bzlhb1hJWnFCa3BobDRQZFhTZWRxVmJQTldubkF5R3U0NXBWQzJrbjdPSzA1?=
 =?utf-8?B?U2owTzBPVlluOFlZa2RoZTQvOFZxTUVMd0w4WlE3cGNpV0tZUncya3djODV3?=
 =?utf-8?B?YytobGwrUkRJNU1mcHExSlpVc2JpbEVzQ3BDN0tiR2laOVE1Nzk5NVNKREtC?=
 =?utf-8?B?ZFVheHZrd3lyeVIzdE9ISGFaQ2VSY3lvanFadTZTT0pEUXV2RFMrdXNsV3hh?=
 =?utf-8?B?Q1pHN20xeDZSbWNCUjM1TkNBTEF0akdzRmZ6aE5GdWpPSGRIUHk0V0RvakZ4?=
 =?utf-8?B?aHRxMDdmdS9qeVlaNTJOTHNlaU56Tmo5NVZGR1BzRnFZUDBpQ08vdlpBV0ZB?=
 =?utf-8?B?aVhMWWRIVGlreFRpVHRTU3V4d3d3TTFaYnFwUFREMzJ0U1hud1V2bU5sV1Fz?=
 =?utf-8?B?cmFERE5hSXpobFJjK0RMb2lWVDJSYVloWW9WYXdOb0pVZ2IvbTlNSnBhZ3pE?=
 =?utf-8?B?aU9HUHdjTkZxZys3LzRGelJwSnpZMkxsL2c5cmd4L0tuM29oVWp3VlU0MVV1?=
 =?utf-8?B?b2hyMmlVZnhJVDZ3OGhRQ2xSWTQzcWFzVEdtYzRFTnlhM013b1p2dzVwdGdJ?=
 =?utf-8?B?MjVva0s1V0l0VkY4V1N2ak9kY25YWXNsMk1mOVNMcDhUVnBkVmw0RTBuNTN4?=
 =?utf-8?B?WTBxeGZPcXdyKytBc0hMcUFDRnNBbktBcldpbHdqZnoyeWt6bjlDUlRCWWgz?=
 =?utf-8?B?TVhkcXk0RUg0eGpQczdLRXVVRERsSTYrcWpMN2M5ZWxkRGYxeWZIODA0UzV2?=
 =?utf-8?B?UXhNTDRVRURFc1RCYm9CaHNHeUpRbGxCcGpkZElPZmR0bWFoQ1A3M3VQWnpL?=
 =?utf-8?B?T0p1MDkwdTZjSkVld3FMRjZkcjltZWRSWEIvQUJTSHFXZWhxTUgxQ1hyTFlu?=
 =?utf-8?B?K3VqQXNyUnZDR3YvM1E3SFJ1K0paTVZiV3pDNlVLRFBnaHRuUWgzZWVZWEsx?=
 =?utf-8?B?MThTL0cwR3BnR0dySUlRMUZaN1ZyZ1NmZHZidi84djdYUm9hKzU5Tk5jWFVU?=
 =?utf-8?B?MlNYUXYwZmNFU3RZVE9LeDdMN1YzeVkyWFlqMXA2UlFuMGRzYzc4czg4SCt3?=
 =?utf-8?B?ZzQ4dlpSZkpWUjRHbjI1OU5BdmJYclgzYk1xVEJ2NkVKTWhTdGVFcjRiNjB0?=
 =?utf-8?B?NW1GSU9TSlRaaFJLaWMxNFBrUlBTZmZCNkNFbU1yMlR3MkdUYWlhOXo2SmdT?=
 =?utf-8?B?WU03bjZ6ZjJKaEVsVVJWVXl1VHEwUDFQcXoxNVk5Tm9iOVI3Zk5xWS8zcVMy?=
 =?utf-8?B?WlU2OFpVUUNLWG1Dc3NUZ3QxR0xOZ3VwSEhBUWl1bnlCVTRBa0RIdnkwOEow?=
 =?utf-8?B?NmUzdEU5am9RK0dGV2kvMWF4akViZDV4Tnl1dmxBTzVXVThPbit6RHdrUklq?=
 =?utf-8?B?YWE5dVM1VGRITE9UdHdGclQ2cGRPVWJZS2JzMmJxRUc0YjBOZmozdWxvRzZs?=
 =?utf-8?B?bThoVzAraFdjVmZsWkNXK0I2OUdYeWovU1AwcUdDZHl2SjJyUHk3WGo2WFZH?=
 =?utf-8?B?MUlaUTVDQ2Q0MnBUVGVYQ1RzSkpNVHE3ekZJU0EzOU9ablJXVURrN1NvU251?=
 =?utf-8?B?V0dlRC9mOTUzQUlWWEFBUk1FZEF2VDZ0c1BKcy9xWUIzS0tGbHNxdWp6Y0Rw?=
 =?utf-8?B?N3ZjSUFiOGtuUkc5VGhVeHNCWElBd2pHeW9oVWp4MldVbGFsUWNsYnIrRjAv?=
 =?utf-8?B?T2VoS0J4alpPclFPMEdGbS8wR2dmdVRHbjJrS0pHRkRrd1l0UmdHYzNTeU9U?=
 =?utf-8?B?cWpYNk5ZZ3lxSG5ETjlIb2xqZFhCWmNmN1J2cU4veE5YV1QrQVV2YjhxSWxj?=
 =?utf-8?B?SjZ1dUFtTitMNkVEQkZ3MXVmT2dDejhmL2tiUzhweHIyLzJvam5rWDc0WWxt?=
 =?utf-8?B?RWxLa0ZBbGsycTJ2cmlSY1BqWUVqck82Z1dCRE5ubWM4OXFWMExaakVNeEhs?=
 =?utf-8?B?aE5lL09jQklSU0FqbGY5bUYxcjZWaTNnNXZKWHd1bGU3V1VMeDgrYVRFQTcv?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6e2b4a-697b-49b3-96da-08dca2bec693
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 22:05:44.0249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JOqelW0XChH87L44uz2AeJmK0VWdICWbGkPuUumGeuR1N/G+anbIMtbWY7fGMwPfOnylkYBCkdqcKfOiOX6lm8jqqHGBHuSoRWeC0CggTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7599
X-OriginatorOrg: intel.com

Hi Babu,

On 7/3/24 2:48 PM, Babu Moger wrote:
> Add the functionality to enable/disable AMD ABMC feature.
> 
> AMD ABMC feature is enabled by setting enabled bit(0) in MSR
> L3_QOS_EXT_CFG.  When the state of ABMC is changed, the MSR needs
> to be updated on all the logical processors in the QOS Domain.
> 
> Hardware counters will reset when ABMC state is changed. Reset the
> architectural state so that reading of hardware counter is not considered
> as an overflow in next update.
> 
> The ABMC feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> ---
> v5: Renamed resctrl_abmc_enable to resctrl_arch_abmc_enable.
>      Renamed resctrl_abmc_disable to resctrl_arch_abmc_disable.
>      Introduced resctrl_arch_get_abmc_enabled to get abmc state from
>      non-arch code.
>      Renamed resctrl_abmc_set_all to _resctrl_abmc_enable().
>      Modified commit log to make it clear about AMD ABMC feature.
> 
> v3: No changes.
> 
> v2: Few text changes in commit message.
> ---
>   arch/x86/include/asm/msr-index.h       |  1 +
>   arch/x86/kernel/cpu/resctrl/internal.h | 13 +++++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 66 ++++++++++++++++++++++++++
>   3 files changed, 80 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 01342963011e..263b2d9d00ed 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1174,6 +1174,7 @@
>   #define MSR_IA32_MBA_BW_BASE		0xc0000200
>   #define MSR_IA32_SMBA_BW_BASE		0xc0000280
>   #define MSR_IA32_EVT_CFG_BASE		0xc0000400
> +#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
>   
>   /* MSR_IA32_VMX_MISC bits */
>   #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 2bd207624eec..0ce9797f80fe 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -97,6 +97,9 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>   	return cpu;
>   }
>   
> +/* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature */

Please be consistent throughout series to have sentences end with period.

> +#define ABMC_ENABLE			BIT(0)
> +
>   struct rdt_fs_context {
>   	struct kernfs_fs_context	kfc;
>   	bool				enable_cdpl2;
> @@ -477,6 +480,7 @@ struct rdt_parse_data {
>    * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
>    *			Monitoring Event Configuration (BMEC) is supported.
>    * @cdp_enabled:	CDP state of this resource
> + * @abmc_enabled:	ABMC feature is enabled
>    *
>    * Members of this structure are either private to the architecture
>    * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
> @@ -491,6 +495,7 @@ struct rdt_hw_resource {
>   	unsigned int		mbm_width;
>   	unsigned int		mbm_cfg_mask;
>   	bool			cdp_enabled;
> +	bool			abmc_enabled;
>   };

mbm_cntr_enabled? This is architecture specific code so there is more flexibility
here, but it may make implementation easier to understand if consistent naming is used
between fs and arch code.

>   
>   static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
> @@ -536,6 +541,14 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
>   
>   void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d);
>   
> +static inline bool resctrl_arch_get_abmc_enabled(void)
> +{
> +	return rdt_resources_all[RDT_RESOURCE_L3].abmc_enabled;
> +}
> +
> +int resctrl_arch_abmc_enable(void);
> +void resctrl_arch_abmc_disable(void);
> +
>   /*
>    * To return the common struct rdt_resource, which is contained in struct
>    * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 7e76f8d839fc..471fc0dbd7c3 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2402,6 +2402,72 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
>   	return 0;
>   }
>   
> +/*
> + * Update L3_QOS_EXT_CFG MSR on all the CPUs associated with the resource.
> + */
> +static void resctrl_abmc_set_one_amd(void *arg)
> +{
> +	bool *enable = arg;
> +	u64 msrval;
> +
> +	rdmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
> +
> +	if (*enable)
> +		msrval |= ABMC_ENABLE;
> +	else
> +		msrval &= ~ABMC_ENABLE;
> +
> +	wrmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
> +}

msr_set_bit() and msr_clear_bit() can be used here.

> +
> +static int _resctrl_abmc_enable(struct rdt_resource *r, bool enable)
> +{
> +	struct rdt_mon_domain *d;
> +
> +	/*
> +	 * Hardware counters will reset after switching the monitor mode.
> +	 * Reset the architectural state so that reading of hardware
> +	 * counter is not considered as an overflow in the next update.
> +	 */
> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +		on_each_cpu_mask(&d->hdr.cpu_mask,
> +				 resctrl_abmc_set_one_amd, &enable, 1);
> +		resctrl_arch_reset_rmid_all(r, d);
> +	}
> +
> +	return 0;
> +}

Seems like _resctrl_abmc_enable() can just return void.

> +
> +int resctrl_arch_abmc_enable(void)

resctrl_arch_mbm_cntr_enable()? I'll no longer point all these out.

> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> +	int ret = 0;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (r->mon.abmc_capable && !hw_res->abmc_enabled) {
> +		ret = _resctrl_abmc_enable(r, true);
> +		if (!ret)
> +			hw_res->abmc_enabled = true;

The above error handling seems unnecessary.

> +	}
> +
> +	return ret;

resctrl_arch_abmc_enable() should probably keep returning an int even though
this implementation does not need it since other archs may indeed return error.

> +}
> +
> +void resctrl_arch_abmc_disable(void)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (hw_res->abmc_enabled) {
> +		_resctrl_abmc_enable(r, false);
> +		hw_res->abmc_enabled = false;
> +	}
> +}
> +
>   /*
>    * We don't allow rdtgroup directories to be created anywhere
>    * except the root directory. Thus when looking for the rdtgroup

Reinette

