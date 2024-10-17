Return-Path: <linux-kernel+bounces-370595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B779A2F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58AE282B89
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB461EE030;
	Thu, 17 Oct 2024 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbFOLqIL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DB61EE00D;
	Thu, 17 Oct 2024 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199612; cv=fail; b=lOYmICJ3lmp25pswT38XZP3eeCUsXZPx4sGwm+TLRT/eHsDV8fbLngHFBMZAoBCKGWyD4GRy3QTdhDYI9WwdLHWN8Mc6prIBs15soXe9sFV5Q6NkbkmHlmvK4rrgzKK5ICOkEAt2PYsfEMkE/lMV1FZoryqzcdqvqHxzMVh2TfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199612; c=relaxed/simple;
	bh=FKQCiVt3WPfATyOTc3Uc9JOz9gPw7AGJhxCqqFn5Ufk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jmY89w/91eiel47TyKhp1E7h+Up/IKPjico7JAA4U58fx5qgr0AwSviUEcbaZRsEA9YvH5s/ByW1ccn6tX2S6PywsMFsQFujK8PRLLJBHpOar5S/bMMp5s5GevwNu6gtnoEV8xxNnCICOyAait52OtrOU27JApGRA7HbWFgg5A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbFOLqIL; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729199610; x=1760735610;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FKQCiVt3WPfATyOTc3Uc9JOz9gPw7AGJhxCqqFn5Ufk=;
  b=nbFOLqILbkGhQYhKyG4KpkIa9xMHFY4MDIMe105AONFMJllgGtg6bmjy
   INCQaVeaneABElX5V76wz6Rub7ZNS91wn0DKyfEcnai3pIyOgtVWIisiv
   hXVOQE/owP31ETa3ZvhHfJw7PlJQFBOQY0z+3sR6KAZPUpLGu7i+RC4JK
   Bu3fIfPU52jqu2TQEKcvDlTHHkQh6wMpjLmQAmc/8RUDF+cjmpXvBgWAe
   FtdarE6qBjc5euBrXRni+8hg+Wcv0ybntPsdA/cxfYGi101QkEtVPHr7R
   8N7eey4ljssG+Js2bhMjt1W6mAubcocl5bsMhZlkCad9SKok9qur/9Lba
   Q==;
X-CSE-ConnectionGUID: SE3Tv1FWT469xXluvVMr6A==
X-CSE-MsgGUID: 4s9rjrltQiSY+pjZ45RH9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="31578234"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="31578234"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 14:13:29 -0700
X-CSE-ConnectionGUID: cZzaMX3ESrSZPIdZVVLR3g==
X-CSE-MsgGUID: XxIz2+5aSweBLQfqagSX7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="78716140"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 14:13:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 14:13:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 14:13:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 14:13:28 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 14:13:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=horKtSG+VHJ83JbxNs/+/6zLoW1cK+dBWA11GqBgJghV6l2Eg52dF8/UNMw3yEa1V1SmvbUpz7Ur9l/VZ3DuFo+lUP+57RkTLvUeB6agDZXLJoeiaZquicGFddLlM8w6m2gPxnWeaQuJ5iyU3TRsy3yg+3ovtEK8zSqM2VVGBPmKWP8PsGE/umlP5gNTY+LsF4IijYoN/OaodMp7j337Yra3gvcqyuPcR/zj2Eg3PYVY/g55ScrYFZvrE53jw3G8FuSh/5FJHDsbSxCzFv3WCSywGoemdurxla2pdKdKBi3aObiPqDn4xLtn9ikM0Ju8Z2mJ/AZ7UMtZqcA5ec02rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CoILUfRWiuNtoNv7YhMpI8uVEOSxJYHfZXDk6ehwDI=;
 b=OGI22ciIKFc9NtC9+Q93N8dWJJ8ubKsD0rpIbfkp+vLnevk0KHhvbZvOPH6xTqruxpFDx2ry0IEgiNSfhrpwvPjxcY+UB8Q6yT+R7AgnanhlP9lAD44vj1aDEGIMgsYuxS5UDyQQuNAPFbySI5LnwBB9E7JNa7Ga4in959Ee8jE4L9Bsg03a9D1kZIfWAgaZ33flayBX/2nusws1ZMbpTm48X/Pt5GdREY23gqZkNGdcO/LjcxcGteUz2iUJMsR582QszqacK8O9kAg8xHd6gom0Oa/z5XeMFyZ3OAmEBYaOF5IdxpxNlfpzXHVl0xJEgDOel8gUnSI3m/NFYRM3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 21:13:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 21:13:24 +0000
Message-ID: <e1bcfe33-98d3-4685-be40-162779863dfe@intel.com>
Date: Thu, 17 Oct 2024 14:13:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/25] x86/resctrl: Add data structures and definitions
 for ABMC assignment
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <kirill.shutemov@linux.intel.com>,
	<jithu.joseph@intel.com>, <kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <94cfd19bf9b16570b07649e1058b4ee55ac8c102.1728495588.git.babu.moger@amd.com>
 <6af4b2f8-c6f4-4195-8c5e-d2efe0384521@intel.com>
 <c81c9b9d-9897-4f97-9d41-37a9fbfcfd7e@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c81c9b9d-9897-4f97-9d41-37a9fbfcfd7e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:303:b6::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 2964506b-7628-40ac-9a06-08dceef08957
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0hpVWpPdzJmdW80akllTmVXKzJhQUZnd1owM3E3TStVRGJuL29oSyt6ekdF?=
 =?utf-8?B?c3ZzZ1FHbnZsT1dueFh6eENmSjg0MWxzdDRZY0FhSVFmWnpRK2NuSVp6YXpR?=
 =?utf-8?B?TlBVMDgzS0o3UFh1U0NtdWJwRmgxcE03a084RnhZRHRzdUw0dHB4cCtvVGNP?=
 =?utf-8?B?RGpWcHBiZFJZRnMxeVd2S1pqQytKY2VZajFzbm5wUW1uRGUyeFN4bHJOazAx?=
 =?utf-8?B?TDlPQnB3dE1kWE5IeHNlZ21RMHBxRVJYQXNlZm53bTQ4cXAydXdrTEVMaGVH?=
 =?utf-8?B?TmZ5REg1R1p0U3JLL3ZnaU9HSDFSSDNaS0lpekZPb3Z4OCtyMzRoT0FNcGpE?=
 =?utf-8?B?WUVoS0VxYWx1VGlESzBmaXludEtjdk52a3NjdVBYVmp1bHV2TGZJY3E0Tklu?=
 =?utf-8?B?RGoyZitXdEVmNUhZMDZHYVVkcmQyM1g2b0svczR2Y3o1bHdXQjFjUWxwaTVy?=
 =?utf-8?B?Nlo4WDhaUGFMeFNYdTM5ZVoxQlBhVE9SSEVrNUZQeFpaZ0ZJZ2tXTzdsUkVW?=
 =?utf-8?B?WmtoZUozNnJJYnJseG56TFBtd3cxdjdmaVkyVkxiZmdSYzVDRmloYStVV1VP?=
 =?utf-8?B?MzFpRDYzQm9acHZSMzJ3OEFtbC93cjdHL3FyY3UyT2gwUlJyMCtOOElBRkJJ?=
 =?utf-8?B?MHBFOE82L0lON2FqcWxTVGl5cUZ0QmFBakpTWVFkMHk2U2MyZ3pRRnNJaE5W?=
 =?utf-8?B?aTFpTHdaNlZNRjlxdmZidUtmMWFUVTFqcXFhL2tzUmdTZm1DVnZ2SU5ZRXVt?=
 =?utf-8?B?bGIwQkVQV2RCakdXa1owV2xxNWtNR0VtYnlURUxteGpKZUpEUm02SnN6VkhJ?=
 =?utf-8?B?R0I4VjdTcEorMEg5REVRSzZIUFc2WDFZUy9FQ1h5NWNBZHVBUDNEaythMHRH?=
 =?utf-8?B?eHhPcFk4VWJmS05Xck4xU2ZoYjh2Yys5MVlLVnQxeUt6YlpPcm9UeHNvUks3?=
 =?utf-8?B?ak1FSHBUNW1pZ1JsMkZTUWtkcG9DSSsvTWJkRGZFUEYxSmxnUlh1VE43RVo4?=
 =?utf-8?B?aEk4TWZzVTI0WkszS2k3Zk00dk5qc1NYNFF6ajEvVjk0bnJUeEJocW5iaGdt?=
 =?utf-8?B?VU9YODl3Umx1Qk14NTk0cUM5WE5qVElYc0lTMUFRZ05pcHpQdTAwbFAxNG5y?=
 =?utf-8?B?djVqOHhKZlB4djRZZVIwNjJFa3Q3MXgyQzI2YU9FWThhQzEwdWcrTU9lVGRn?=
 =?utf-8?B?blYrNmtaek80ZGRSSHM1VzBvdENqR0FlWlhkR0ltUGxtWm5KUy9oSHQreGpN?=
 =?utf-8?B?QjZKMWUvVlpzMUxLYnR4bkI0N1d1bnBQK05zZThuaDQ0aVM2SytIZTUyYWd6?=
 =?utf-8?B?ZGxCRytmZmdoZC9GdlVsaFNzZGs5NFdubEYvSXFxd2pUWkQ0cDFpRUs3VGli?=
 =?utf-8?B?L2pHZTh1enJxZVlkajI5cVVnc0FiK2FSdGFGeWMraHp5SnRlYW55dzhWOXFw?=
 =?utf-8?B?bU42QU8xOFc0Smt6ckZydXlQeTBvT3BjRU43VUpJT2RxbUZLeWc4UE92MDNz?=
 =?utf-8?B?dkk1enAxQ0g4U3RmaGdYYTkySkNLKzV4MEdtNzgyOFJPVXM5OUMwMkZLQyt3?=
 =?utf-8?B?Z0FKK3k3MGNGRmIzb0JoblI2ZGhFaWpSOTk0Uzd0TUoyM2YySkpkd2ZoalVu?=
 =?utf-8?B?RkVkT2ovbjlEL0sxWFZveGNwNjFhNTdSOXNlaU11UTNoVW9EdkRIellpMTR3?=
 =?utf-8?B?V2Q2Vmk3SUpUcEs5Uk9yc0M1YnZhUDVsMlMrWmVxY3dLcnVPQUtOZXVDZnFN?=
 =?utf-8?Q?Wl5M32V2wIJ9hFfXYq/Wi8w5g433Z+SeHfsZGkY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHJZekFFaUh6Y3VxN0Zub01hWEhqRlU0MFE4RkVwYm5UbmZTNmljSnNsTVJT?=
 =?utf-8?B?MDI1TTd6VEdqY3gzbnRZMlI3d3hIU3RoUDJUMk5GZHhuRnRLUmdyaEZ2QWFC?=
 =?utf-8?B?N3VtejlJNEw5V2dFWSthN2dWNW5nbTREb3ZBMUtZNWJCd1duS3hLSU9xZmJW?=
 =?utf-8?B?eEZ4ZzIwOEtVWjRmbVh2UW9CNHJhQjhiWndGRWplTDFJQVpnNUd3c0psZHNF?=
 =?utf-8?B?TnR3S2VZRVZpMGhKSGlyM0pPdnovM3RNVUFUM2J3VUpIRUFxVktFZ01sWnZI?=
 =?utf-8?B?eTdka3VrdjBhQ3RqMXAzL09WSXdyQURmUGk2eFliUlZEME1jcEZadmx6WnVq?=
 =?utf-8?B?WEtJOW1VVWJDSUEvMGk2MUQ2WmxMblpTWmJpNG9jNDEzdXFORUJvSDRNcTRP?=
 =?utf-8?B?Q2xRTWpkOXdobzh4K2I3ekxCVDNmWU8yWHJJVGl6eFUzQmVXbDZwSHNseHdt?=
 =?utf-8?B?cGFGTVczcGFCMGF1YmRCNVh1bkFhd1lLbFprU2YwVkdJZjBLSk5nTEs2VkJv?=
 =?utf-8?B?blRhL2xkODBxdjBBVFZPNFg5aWNVelVBVGVEamtxSmE4c1poMnpYL3ZQRURB?=
 =?utf-8?B?cVZzdHBZTDYvYWJDRStXU2t2R1hienkzMmtmaWlFZjR5VENrR29FbDNpYWwy?=
 =?utf-8?B?aC9penpmR1V4dU9FelA3Y2FjUDVCYlpuTWlzOU9aL3ljRUhMRExkT0JoRE0z?=
 =?utf-8?B?ZVh5K1dXSVhGZklIZkhCZTBKSkpCenhoWWJWRmhnd05HUEJpWjA4MDlsY2VJ?=
 =?utf-8?B?NHBMdStadGNzN2x2Q1pZRW5KWGJKNHJjeTRFZWpFa2VWNlJsS0lOcFVTbWR6?=
 =?utf-8?B?dm5MZGQySDBOWHRDckRubzdYNWk2L2Q5S2puRU9QMDZYa2NVQU5xL1VPR3Mv?=
 =?utf-8?B?Qk05ZjNGOGxwTEd6U0tWTHkwSzBTVkQ3eDVUNkNweGdlNXBlUEVzU01FWnQ2?=
 =?utf-8?B?MXFneTBxdW9MajRya3orRTRRQlY5OWc2VFVXbXJoT2RzazhiY3RUZUpTQXpV?=
 =?utf-8?B?TEZqcXVEcGJaMmJQbW9xL3hJV1ovNW9vazRoY2FkQWlvOU9GZklmL2JnTzBj?=
 =?utf-8?B?TVdITjhRUDVPTDIyTnRkYkNJYk1vVWxsVms1Sm9HU0kwTmNINXo2dTNScG5I?=
 =?utf-8?B?dmlDNkU2M0NEMHFNSktQemszVDNQc3ZEQmozNzJYOXF4Y0lNVkN1eExXYTRC?=
 =?utf-8?B?blR2UzczeEYzcmVDZTBPdGg4TjZXeTVHUytkbEk3TjBCaEhob1VBODhJUmVO?=
 =?utf-8?B?SDg5T0EreXhpeS9lUmt2a2hXV1BrNXh4YlRLSXZ2QXBjMFFlYnRrZEFsWGl3?=
 =?utf-8?B?d2JUc2F3c2pkbE0rTGJCcTh5UkRFelJpUkMrRjRrUFovUlBCV1ZPSzNGaUlR?=
 =?utf-8?B?U2srVm52a1ZoUDNESFFJYWVISzJweGpacmJrY29JbmpBcDQ5TnN5eTdJcjdQ?=
 =?utf-8?B?bFhLRFF5VVptdGwxOC9JcWxlRlZYZ1J6SW11V2ZvS0FMZ0dkbzlEQ3I0UWVI?=
 =?utf-8?B?UWp1aHNOVUxjRE5XUmVheE9vR042VjZoMVpBenlPc3JKaDlDTUc5eXd5RTRv?=
 =?utf-8?B?b0tENWJvbVp1Sk5vakY5MzdaT2Q4TURDZjI0MWtWK0Rqa1JaUVZTaklkQXd2?=
 =?utf-8?B?ZllyZTZSWG5YWU9XMHBhVE1vc0p5ejgrRDU0Rk1pOU5qWXE4ckp1em5TUmdK?=
 =?utf-8?B?SVpURzRVVUNKbzN6V0RENitwZjJhMHVIQXIvVHlGa2l2YUlYb3V6R0J1SmNC?=
 =?utf-8?B?SDhVdU9oelN6eThhTVlPbjdvb1NsakIzdHhqUTg3RjdRZDhjY2hhZXVsUGEx?=
 =?utf-8?B?ZDNXa3F5MWlqRXFZTXZITGpxVkNBT3Z4RHVGRm5zbkhWNEpaZTJpaFVYVWtC?=
 =?utf-8?B?OGczNmdIMWErMjZtVWFpMDlkZGJqVEw5YnE1WmNlaXRsQW9EZm8wNmZGU0NP?=
 =?utf-8?B?U1lKL1AxbXpqeEZCYXZySzFiM2trYUFHY3pFR2sxQlp4RFl0OVo5cFlLZnlV?=
 =?utf-8?B?TEdFS3JPeDNsZUI3Qld5SUVqbVpKM3lxVHlmRFdqLzNnMXZYNEtlS1dZYjlE?=
 =?utf-8?B?cHAzU2hKZDl2bTVUWUhCMXhOOXBZVmdtU0ZyYmxMd3NYUXRsWEFENk9Ic2Fv?=
 =?utf-8?B?em1zNy8vN2RjM2lISmI2aldpeC83a1hFbUw0QWFYekc5MGR4YTY0aFZtcHJ6?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2964506b-7628-40ac-9a06-08dceef08957
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:13:24.5961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNuTzkFiK6SkzI7HfF/JCVwjaG1V3+A5CYi/WnLLUE7/YEhMPfOKR6aQ1b6C2S5uvmrNC38gdc/K9Xdy9wt9KkkrxHZVx/xoso2R3g/UosE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7540
X-OriginatorOrg: intel.com

Hi Babu,

On 10/17/24 11:52 AM, Moger, Babu wrote:
> On 10/15/24 22:21, Reinette Chatre wrote:
>> On 10/9/24 10:39 AM, Babu Moger wrote:

>>> + *			  tracked by the @cntr_id.
>>> + * @bw_src		: Bandwidth source (RMID or CLOSID).
>>> + * @reserved1		: Reserved.
>>> + * @is_clos		: @bw_src field is a CLOSID (not an RMID).
>>> + * @cntr_id		: Counter identifier.
>>> + * @reserved		: Reserved.
>>> + * @cntr_en		: Counting enable bit.
>>> + * @cfg_en		: Configuration enable bit.
>>> + *
>>> + * Configuration and counting:
>>> + * cfg_en=0,            : No configuration changes applied.
>>
>> Can this be expanded? (sidenote: It is taking a long time to get clarity on how
>> to interact with hardware. These incremental cryptic fragments make it difficult
>> to know how to interact with the hardware.)
>>
>> For example, "No configuration changes applied. Counter can be configured across
>> multiple writes to MSR while @cfg_en=0. Configuration applied when @cfg_en=1."
>>
>>> + * cfg_en=1, cntr_en=0  : Configure cntr_id and but no counting the events.
>>
>> hmmm ... still the same (""but no counting the events") strange language I
>> highlighted in V7 ...
>>
>> I think it will make things easier to understand if similar language is used
>> between the descriptions of the different fields.
>>
>> "Apply @cntr_id configuration but do not count events." 
>>  
>>> + * cfg_en=1, cntr_en=1  : Configure cntr_id and start counting the events.
>>
>> "Apply @cntr_id configuration and start counting events." 
>>
>> Can it be added here which of these settings (or combination of settings) result
>> in counters being reset?
> 
> Any change in the configuration will reset the counters.
> 
> Little bit lost here. Let me summarize. How about this?
> 
> Configuration and counting:
> Counter can be configured across multiple writes to MSR. Configuration
> is applied only when @cfg_en = 1. The event counters will reset when any
> of the configuration is changed.

Is is not clear to me what is meant with "when any of the configuration is changed".
Are event counters reset with every write to the MSR, whether @cfg_en is set or
not? If counters are only reset when @cfg_en is set then I think it should read
"Counter @cntr_id is reset when the configuration is applied." Note this is
also made specific to be related to *just* the counter being configured, not all
event counters that "The event counters will reset ..." implies.

> cfg_en = 1, cntr_en = 0 : Apply @cntr_id configuration but do not count
> events.
> cfg_en = 1, cntr_en = 1 : Apply @cntr_id configuration and start counting
> events.
> 

Please use the @ prefix when referring to union members.

Thank you

Reinette


