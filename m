Return-Path: <linux-kernel+bounces-525266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BC0A3ED53
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF417ABAD7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069191FF1C3;
	Fri, 21 Feb 2025 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XCvhTo64"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661EF1FBCAF;
	Fri, 21 Feb 2025 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740122702; cv=fail; b=LFDHkwJvziyaDpp+iQCmmGeXML6ISsiRpDujT0gu3P3Sgkj0bhJCUajsLN1a/9fh2tqf48pFf9OJ0kAda24D0+60RaUiUoZbwS5e2v57oSwE1Az36qMBuqBJ4jKOTWecsahpKzmSAtw0JGMLhyK7b+mUCqShKslEC2tYdP5i+mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740122702; c=relaxed/simple;
	bh=yhHnM/oryUgOfsZTnf+kz6InVMeT8KssRRt5mOxSYGc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fq6RJ5R7CGf2c0N/ZvtI37gyY9Ce2VOkwA8QBR9AVUnaFYoWx+IfgTltLr5fjUqDCO4dmRNiXj3flc8P7hVDH8Jb13iZryNk3cIO53wYS/4lI6rmnb7Aqk+fTCDVp9ksH4O+Np5/hlYp1F1k+91/Yrit3b5aqUKLxgNdDMZ5bYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XCvhTo64; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740122700; x=1771658700;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=yhHnM/oryUgOfsZTnf+kz6InVMeT8KssRRt5mOxSYGc=;
  b=XCvhTo64Sw+DldFzBd9NhWIE1b65up2CEY2wV2C8cpVGme6m5icuf9i+
   UMFmuJB24T1ZnuhPPY7BVoXeUm7Hx7Mzqm1YfjWlRWkMO9XektS8Wk4GR
   TLqXa7Lg4kBSLRkKKXPWofu3VBCOqFrgViOJIVT8CFvUtvefNbcfYbSg3
   DODubdn67KMrK6Ao7Xsu2XwS0CchTbXL/cIuXh2YPftEA9EeXG/fee+ln
   rQv02NKBpu05dD74DVAa7zksgRyvTrdmzazwawIZRUtXe7sKIFejgiA8h
   j9uHYZlpVXejF/nAnruNHRzSB9Z0f83KOxyQEyaqz6ie4SnCOLYafOLhF
   w==;
X-CSE-ConnectionGUID: gDurvFFPRE2LXb5nBrShEA==
X-CSE-MsgGUID: TO71kXJFSMa9/KaDNKfUFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40851370"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="40851370"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 23:24:59 -0800
X-CSE-ConnectionGUID: M5juLm/vSdSFrSwkGPjNOg==
X-CSE-MsgGUID: XZF/GbiXS/mQTSBKEUioEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="120266675"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 23:25:00 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 23:24:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 23:24:58 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 23:24:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCU3f6Te+G3475WYoIncCwgS8h5FW9fP/l7NZRWCpbNATXdw7fwQty9xHIqfL+sahoGM+THn/mMei7wSAZ3SFbbaUWrrORMbEyVuluR0VuCDxcbfWbh2dUlEkR8trthqGjS9zrCIJaTOcQbTw1Xqjy8gH4yN3tXbR2A52/8rFYtqSYJSKgmuFDKaoiDP1dPEQ/rWfgnAjO57laLfBCgZindwijG2oRIlrrUloYp8tYiiRit4RDS7ye1globyB73PqXpKSMHCe7KqnoUvS/jYDTslgWd4pVn1rHBapkAExlx7C8FkHcmnLteCOufgOAfO78wvUR4IAnd9s/WnA7uI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCW54wRjg5+oduSukD4nF975D+s2hpRzkml3SLH7ypU=;
 b=YUplbPNOnITOWaYgDeXwmspP6ru9vrB95w1G5fGj+Wp/q0G9ancNrN2tuclDtlHYn7OhDuXOp1+FM2wNSRYM8F1kkDVaA0i3UnTnerbOw/uOKQlhZRKMkH5N1PhIbJzTnD0OpA9HJPVEsWtwiXqG1zXZA3JsC+328fZIY+oqvXeCLu435ViFTeIjnGDByaaklJ9oqPNC2xBd7RlEjGW35hVncsvy29dy9lditgBaVRro+EaTzjl6lSzEkyWhuvh4lBM1kVv41dxjEkEBOa6tHiiVUQaNYMvOwYDl0MHv3QqPlx2Y4Jwakd4tr3O8TDYG1fzYSFtWkOk9AETKvafXeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DM6PR11MB4676.namprd11.prod.outlook.com (2603:10b6:5:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Fri, 21 Feb
 2025 07:24:28 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 07:24:28 +0000
Date: Fri, 21 Feb 2025 08:24:13 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
CC: <kees@kernel.org>, <julian.stecklina@cyberus-technology.de>,
	<kevinloughlin@google.com>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<justinstitt@google.com>, <catalin.marinas@arm.com>,
	<wangkefeng.wang@huawei.com>, <bhe@redhat.com>, <ryabinin.a.a@gmail.com>,
	<kirill.shutemov@linux.intel.com>, <will@kernel.org>, <ardb@kernel.org>,
	<jason.andryuk@amd.com>, <dave.hansen@linux.intel.com>,
	<pasha.tatashin@soleen.com>, <ndesaulniers@google.com>,
	<guoweikang.kernel@gmail.com>, <dwmw@amazon.co.uk>, <mark.rutland@arm.com>,
	<broonie@kernel.org>, <apopple@nvidia.com>, <bp@alien8.de>,
	<rppt@kernel.org>, <kaleshsingh@google.com>, <richard.weiyang@gmail.com>,
	<luto@kernel.org>, <glider@google.com>, <pankaj.gupta@amd.com>,
	<pawan.kumar.gupta@linux.intel.com>, <kuan-ying.lee@canonical.com>,
	<tony.luck@intel.com>, <tj@kernel.org>, <jgross@suse.com>,
	<dvyukov@google.com>, <baohua@kernel.org>, <samuel.holland@sifive.com>,
	<dennis@kernel.org>, <akpm@linux-foundation.org>,
	<thomas.weissschuh@linutronix.de>, <surenb@google.com>,
	<kbingham@kernel.org>, <ankita@nvidia.com>, <nathan@kernel.org>,
	<ziy@nvidia.com>, <xin@zytor.com>, <rafael.j.wysocki@intel.com>,
	<andriy.shevchenko@linux.intel.com>, <cl@linux.com>, <jhubbard@nvidia.com>,
	<hpa@zytor.com>, <scott@os.amperecomputing.com>, <david@redhat.com>,
	<jan.kiszka@siemens.com>, <vincenzo.frascino@arm.com>, <corbet@lwn.net>,
	<maz@kernel.org>, <mingo@redhat.com>, <arnd@arndb.de>, <ytcoode@gmail.com>,
	<xur@google.com>, <morbo@google.com>, <thiago.bauermann@linaro.org>,
	<linux-doc@vger.kernel.org>, <kasan-dev@googlegroups.com>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>
Subject: Re: [PATCH v2 12/14] x86: Minimal SLAB alignment
Message-ID: <jjwojlm7ie5f4whsbmhowrxy2upxhrflu3za2sdrnvafyjc746@vhzl7vnvvgh6>
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
 <7492f65cd21a898e2f2608fb51642b7b0c05ef21.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZdidM3Sj_ftw6pmtzw-tjy0LLD+2aqtzSewQTOUXMs2hw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZdidM3Sj_ftw6pmtzw-tjy0LLD+2aqtzSewQTOUXMs2hw@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0341.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::30) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DM6PR11MB4676:EE_
X-MS-Office365-Filtering-Correlation-Id: a2358c54-17fa-4914-67c7-08dd5248c67b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXA3bENzbS9ySmxzVDZuRlNNZ3ZkdmNsNmk0TG40UnJUSXhXaTZsa2tzVDI1?=
 =?utf-8?B?eG1uQlE5ckR5Tk9UOWRwbW1kTytxcmRBQnZlZk9aYmJjajBybENwdFp5V2lj?=
 =?utf-8?B?Rk5JTXNudWVNa2tDcngzOVNoYXZ1Rm1wR3NDWmorRmFvUXB3QXFTcDZVcEFi?=
 =?utf-8?B?dWFJOVhITGJVdGZwaVF4K1lTOUxFZXBkWStpc3RqcmExUlRERmdYVjZ5dXdl?=
 =?utf-8?B?UFRTOEQxUmxCVjVNOHQ5WXJXS081YlUzK1lkU2RxMEoxbG9oTUN3NkpTOERs?=
 =?utf-8?B?VDZJWW9Rc0RJVmxVVWNPZ2R4UlZBaTBsWVZXd2xvZjJVT2c1cUpaUm5qTGlJ?=
 =?utf-8?B?b2g1UnQrY2JESVg1VE9JaDFJVHNtaCtISTFJbW1wTWtTZG5mWDd6azc0b204?=
 =?utf-8?B?UmhJT0srcC9jZ25UUHhkbDVTa1hucDJBSExaL3BoNU5SejdURkFvQXdWWEJ2?=
 =?utf-8?B?bC9sWEtrZUhyVHI3NmVCQUZaajdENnNnRWFkcXpIL1F5RnYwSXVPUWxGT3Vq?=
 =?utf-8?B?TFUvbXRhYjVHOXd6SnJkeFBDR09NcDB3SmhPb0Q1R2ZEdlJQVnpOaC9YY2RB?=
 =?utf-8?B?eGt0OGdmbG9qSVYycC9MVURVeUVkNWprcDU1ODUzajl5b2VHcm56OUZZYnYw?=
 =?utf-8?B?Y2JNWWpSa3RMdHpaRUxRK1F2VE5aQzNnVmg3QTRTVEVRenFONEZ1ZkFrNUpl?=
 =?utf-8?B?eWpaVzJPc2RsY0RqenpkcTFYYjRiSGMyWXRibUlTcEZJWndWRGxQMyt5QmJ6?=
 =?utf-8?B?Y1VMczBhRUgvY0I2NllISzljV0V4MElybkphWXhIREMzNXhGcnBQdHdiWGwx?=
 =?utf-8?B?R2cxMHRQYkNEemdyRFhVWEdEVXJxaUZOVUw0blZHeE15L2hjYzBiQnRYaWhv?=
 =?utf-8?B?UHNHSm5mQ0Rmck1HYlNoaCtmMDVMRkVlVXRDSnJnQ3RDSUl2Uzkxa1U3aFZI?=
 =?utf-8?B?YVh3ZlI1SGF4M3BUVlpLSHVYMlZQV09hWGZoeXprRVFwN2UwVHZyZ0JpbE1C?=
 =?utf-8?B?bGZKblRWelN1RkhVZmpLd0Q1RUpjd0o1MWJrVlRacmtmclRiaTdlRWdkUnp2?=
 =?utf-8?B?eWZvWTBRbms1REM1cS9hMkxxSG9vZVFQcmxKYXZJc1dRcGhGb1hHNTBVcXpr?=
 =?utf-8?B?QzgrRjRMbHNNQmtBZUNRUE5Ob1pJcTFabTlPUWxENlprL3NSajhnWUVKVVNR?=
 =?utf-8?B?a3BSYi9Rb2pOSVNGeVJGMEhNbkRxUTZtSzQrUE5ub0s4VlA0T3Zkd0w1eVdm?=
 =?utf-8?B?MlI1R2dJSXNmNTJkYmRPWVpxVHdIeU05Y3FlcHRNM1hwYnNCdWlPMWtVTjln?=
 =?utf-8?B?elVrVmNjYlZVM0ZtMGxjeU5ESEtnRnhNUmROQzdMYUJpMnBSMHZIOFBadmxo?=
 =?utf-8?B?SlU0ZGN4ZDRoRVVCUisxRmNrWXdLU2hYSlByRExwREs0UXVSYzhUYithZGJl?=
 =?utf-8?B?a1J2SHNVQVJIMUQzNktsTmRVNEY5NzlWWlMwZ3hYcXFzOHdnRlg2Z2xUeTNw?=
 =?utf-8?B?TkIwVlBBY0dSSHY2V2Y4cXBFZ1c4SmhnUlNnWjg2V1lFU2dsWHYxb0xuVjlJ?=
 =?utf-8?B?MkJxMXVka0hEMmNSajFWSHNJbWEwOTBVUGc2eFEwTG5sWHRTZWVDSUY3cWt2?=
 =?utf-8?B?bEpLc3BreFNnU3Z6ZXFsSkNiTVNydzVWMjEvczhjRWVFK0p2UFc3ZnpLUzV2?=
 =?utf-8?B?VU9WdzFIS2ZSZEdBa0FBMDU1MEEzMGNJWkRtcTdrR1ZDSEx6Zzd5VGpUTWpU?=
 =?utf-8?B?d1NiY0tPZWc5TEVDNHhBRGhHenFzbjlVTXNDa0lQOGZpbm9NQXhLVlBGK3J2?=
 =?utf-8?B?T3NYemIvVFkrU0o2aDI5ZHFOUUVTdTk5c0J1cWRkZ1FqL01XTWovV3NFWnFD?=
 =?utf-8?Q?8t+TYou9Z369g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFBIUU16cW4vdDNDQitqWUY2N0hkbXIyeHgya1NmSVRwMmh5Ukl0MUlrVW85?=
 =?utf-8?B?SFppc3ptZWxEaVVySkMrcUd3TkN6UlEzWjFFNmVkNFo5ekdEOS9RbUZYWXNo?=
 =?utf-8?B?d2srd0pBWngxL1p3aVdOMFZKcmZZa2g4SVZVNE1hd1J6MW1seHJNS3N1VEJr?=
 =?utf-8?B?VTFHVURIcnROUTRpR0g3QWJnZmxobnpXbDhlVFp5RDhoWitCcGpTN3VNbkZs?=
 =?utf-8?B?d1gzQ3haRTl5NHNxckFxVEJzTXBPbVVqTWxiSkt0R3NmRzJJMDJrOTRybVF0?=
 =?utf-8?B?VEZaV1dXdTZSUEZMU2FlSEtwM2xZZmJwQXBYendVZk00RFVsNWtyRkQvb0Jp?=
 =?utf-8?B?aVQwSkNXQ1g2bTd4a1F6SW5mVlhvWUNoZE9jV09DVUtleitqdzI0YTNYdkxi?=
 =?utf-8?B?Y1JmaXdDU2tqQVJjZHdMQVVlWW1sZmRkWCs2T1dmNWZZTmdISEZ2bzl3R1Rx?=
 =?utf-8?B?ay9pWnRBdEJJVEhnMnRhamZtb2lSaHVydHl3bUpINUttZ2hlMUJTU3gxY280?=
 =?utf-8?B?SmwyYnhSTDQ4WFFaZ3JFc1BSOWxHMEx6am5MTFJsbjZGdHl5bGpEOHRvRGMy?=
 =?utf-8?B?dmN5YWh3dEJKekdnUmtDZE0wZTBFbklHOHpuUVVxVVk1ZUVNL1RYU2FoaUc5?=
 =?utf-8?B?alVJUjBJdi9hZmQvYVVZZ2hQVlF6THNhT0VNSWQvd0RlUXFXZkhtVWJESHp2?=
 =?utf-8?B?N3o0dEdDSUtsYXdPRkVGOHdiOUlFdlk4SnlsQkc1WlI3bC9IK0VVYjFpMlJs?=
 =?utf-8?B?YUhRejVWTGo0V3NrK2xSaUJhR2x2UWtvNE54ZkdHeVkvajh6WjNvbmpBU3Bh?=
 =?utf-8?B?ODhWR291WGlVY3kxNVlIMURzdDB0dWh1dGpNb3hycHlxbXRSK2E1ZGZYYzZB?=
 =?utf-8?B?ZlZjcnFWSCtHU3lETDQ0VzRucDNYQ2NrS2kzRnhFanZRNEdsU3Z5d3JsWmx3?=
 =?utf-8?B?cXM2ZVhwMnNBeEhCbnpzdUhJZmV1MHZLUDVyWXY1YnVUNEw3RXBiRmFoOGRM?=
 =?utf-8?B?dERNT3BSQ2M5Vmh2VWppSFFzcjdIcEpYN01qV0RjTFk1ZGRIN2lmenhmeU5z?=
 =?utf-8?B?WDBDcExJc0Z6azBHUjI2MXJPRXVHMEhlaG1IRTg2aEFqVFdOTkxtemNrM1Rs?=
 =?utf-8?B?UWM3VFhpVVZPc3RqdFJBSVVZODFwdTdmbjhTWkxNYThrbUdYRHBEVWtmWEY1?=
 =?utf-8?B?TFQvdGFmVzZsSGh0V2d4QkxZMzE1TVA3a05rNE4vTmFsdU1IelJ2bUNMSEFo?=
 =?utf-8?B?NFFTN3V4eXduRysrRkM4R3BROWk3MkhSdG9YRWtzUU53ZEZROGFBSFNscGRQ?=
 =?utf-8?B?Sm54dmRHdGYvNTRGaCtScXNFdWp1Znd5YUtRQ1F3dG9kMzdWVmIyNXc1dDc0?=
 =?utf-8?B?N0xscGVZUm9jbG1HYlVPYkY3ck5zNjAxbVducExxY0kwS1pmU2hTdE9TcWNL?=
 =?utf-8?B?Y3ZJY1NMa0c0MGZPclNldmRUS3BnMWVDS2xzVHMrNTlMWjZFR3g3Z1l6MmJ1?=
 =?utf-8?B?SjNwby95ck1Ld3FreGQwbHZGZURKcllLVUEveVpUblNQTUwvMnlPcWpyZTF2?=
 =?utf-8?B?aVpvLzRXOXVTbURBU2NiVWF2RlM1V1R6NVMwSDFQemdhTEl4eSszT2I1bW02?=
 =?utf-8?B?YnErWjhaRzZvL0RDcFhseE1KME5iTHVqWE5LZWtrcmd0MHlic0VLVFpkaFAr?=
 =?utf-8?B?SXB6OW9LdkVpeE01T1JMUHB3YWdrR2IzaFU0Tm40MFlVZGNlY2JmWitYbFZw?=
 =?utf-8?B?bmNnWjlUMUF5QkxlQ3MwK3F4OGhodFBLRk9IMkFWaWVEajBOcldaM2pVTDla?=
 =?utf-8?B?WUl2OTgwcS9DdGFSTlNlOUp4SVB5RFVIa1V0ejlqLy8za3FhdTBZNXJaS1Bl?=
 =?utf-8?B?MHBBQi8vMTJ6VFUwQmZNc0YzNEN6MlAwNW8vWXlSUVBTb3Z3SjdBVlZjTGxH?=
 =?utf-8?B?dHZSU0xGWHhmMStuQmwwdnU1TGYvZTFsZUFzMmwxNHUyb1lnV0lwak05STUy?=
 =?utf-8?B?WmQwT0tzUDc1OXFCTVA2Tm9DMlp1N3MxMWh0ZkFrM2JsSE5yVkRMTUtSM3ls?=
 =?utf-8?B?WUV4SFRpbTJGUXFoR04wdGIyYkI1U3FBQjdMeDFXSkpUMFJmeXlrR0gxbFo4?=
 =?utf-8?B?YnJSR2tOandGM2dPSE9VZDUxMnk1VVJ6VUU0dSt6QzUvNnNFM2tXVXNpUjJh?=
 =?utf-8?Q?H0JZ7QaBEJejjSCLZII0Nso=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2358c54-17fa-4914-67c7-08dd5248c67b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 07:24:28.0911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWmWjLDbQzM63vCaTwqoyoxxOd9TWQve0GZNXfAJe8rsxMxdWPytdLHWwyDILyJmgFsgyFRF2ociV2a/97SqE5At/eMjeOfMQFAGCCBVyFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4676
X-OriginatorOrg: intel.com

On 2025-02-20 at 00:30:48 +0100, Andrey Konovalov wrote:
>On Tue, Feb 18, 2025 at 9:20 AM Maciej Wieczor-Retman
><maciej.wieczor-retman@intel.com> wrote:
>>
>> Adjust x86 minimal SLAB alignment to match KASAN granularity size. In
>> tag-based mode the size changes to 16 bytes so the value needs to be 4.
>
>This 4 should be 16.

Thanks!

>
>>
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>>  arch/x86/include/asm/kasan.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
>> index 8829337a75fa..a75f0748a4b6 100644
>> --- a/arch/x86/include/asm/kasan.h
>> +++ b/arch/x86/include/asm/kasan.h
>> @@ -36,6 +36,8 @@
>>
>>  #ifdef CONFIG_KASAN_SW_TAGS
>>
>> +#define ARCH_SLAB_MINALIGN (1ULL << KASAN_SHADOW_SCALE_SHIFT)
>
>I believe ARCH_SLAB_MINALIGN needs to be defined in
>include/asm/cache.h: at least other architectures have it there.

Okay, I'll correct it.

>
>
>> +
>>  #define __tag_shifted(tag)             FIELD_PREP(GENMASK_ULL(60, 57), tag)
>>  #define __tag_reset(addr)              (sign_extend64((u64)(addr), 56))
>>  #define __tag_get(addr)                        ((u8)FIELD_GET(GENMASK_ULL(60, 57), (u64)addr))
>> --
>> 2.47.1
>>

-- 
Kind regards
Maciej Wieczór-Retman

