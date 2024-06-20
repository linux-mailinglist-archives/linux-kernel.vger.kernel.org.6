Return-Path: <linux-kernel+bounces-223637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFBE9115DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDEBBB22792
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1784140378;
	Thu, 20 Jun 2024 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REudAOkL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04A36F2F1;
	Thu, 20 Jun 2024 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718923777; cv=fail; b=X89IBUdhnpDwXZebMYlTv+fMVv+SRk7nCA0i1SiF09IAo8WD0LpRxdC6OBCadxBuUcYRTUrFoCb48U+5U4vc7w6vJhKk9tIEuquacBQUJmt85fnhJYxlTKs5hBCkmVU+1YfeSwZmkEgMkuzm/B3I1BjuIMB3X+oSKx73kJX7pno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718923777; c=relaxed/simple;
	bh=ISMRhFKfZ+hjRV6UEM2lqpi5HEh8ratjuBOcUc9Beio=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vn7CW8E3tCFe+pPa8J9k9mVe+2X0bHhnaEvBF131vw7z1KnmZ7TvShkXuBs47HaHWZIdKAX/21drMkhe7vydgk+c93P1m0nLE5q0Ss6Uxoq4nUToEfhxJFvPPylugBCG2VfZea6jxUXrfKFmiCQ9Ma4ZPJ4CcwAQYPSEMlOujXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REudAOkL; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718923776; x=1750459776;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ISMRhFKfZ+hjRV6UEM2lqpi5HEh8ratjuBOcUc9Beio=;
  b=REudAOkLRSPZF7UcqVZmjgcWvCJ6NAGiHKM2AIE9ZyKQ7xC14ivY9KES
   msd+IL8SAObTTRcX1ogQ12lYWox+iMfhDFqe/Du0SM/RAhdW0E/wN/hJk
   8J/BeiedL7fEYWHKzMs8HbkpW8e2ky5fiaqQifJGC+REkUeW1fH8mlhD2
   +mncoySKZN3Zz2k8Eqvmo8hYKTNIlX4KZHpA1B3KGTZNkIUcSPPnIz4BW
   iPDaLd/9UkrAH3ubu9XLOJrOdktwzex/9T+eFA3RotD1PJxT9T9KDWPcn
   jsMZxVEqQAbagfjvHVfhx5r0EoMHiFCZwXh/FFIhmLO9qWM1QwZwqW7ci
   Q==;
X-CSE-ConnectionGUID: 1ufyJaQ2SL27Glli9Sks7g==
X-CSE-MsgGUID: dhI3NrNZQLG6ODfgx3nDmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15697249"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="15697249"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 15:49:35 -0700
X-CSE-ConnectionGUID: Ixh4EaIQRqSsn4srhXL/+Q==
X-CSE-MsgGUID: TeD2P4KsQqGCnu5GlnWG3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="47336574"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 15:49:35 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 15:49:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 15:49:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 15:49:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNVfFUVzkBod9J2cUm/RPVXp2NVAj8zDCL4WLttNnPfK+dES19luPzxEwUlA0UFxk1ZZ6torgMWZZXZ0CPj2271nWFdyz2j+sWVv7OdcDte+XMzc94TOW3gaUs+C1tNJ3sgSq0TAr0ctnaIMSf96DGyKt0MJDUTRSMnfJF24CpFmzqxUguc0k/f1I3RGpPy6ggPllgkLXvJX1VmRyuVvYQVJf1dLEw8+6LiFP8zbthIz3CmPRBZAGnDwEqWagvVictehomRSqJAJUjVXcPPwmJsQ7fpHKBTTi4NJUUaG7q47qW8AmENNpc7chGiqpm3cFAuxjsCFoeVxFzQo9JOTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdcnWkQ3cu7bvtZltdsP4fo6Ju3OJyx5DWv5NdT5C9A=;
 b=QFJ+y1uNUIFi0VDEL77YlnB6rEyeL7fp3mzFwkXxL8hjt1cgHF99dstW7Jz9183ZUQ+CNWb/FIb2lO+2djjMZr+SpKhmFeCY4YClMT1w7NKS3X7160yhUBY1ZnwQLq3TaMJ8K6A8UAm7JwDMutx6ML27mDaZHCee8L+As+mKfwRB/bRoaNRoSZ6L/xW02hZPWrHoBAff8TlZseD2fmYzWNQO9viJdMxw53EsyTfNrFOqGS3MkB6fvE+jlEy5yIORVADmqPJAMtgyW5cHwBI3gYdmaw3d7latonhFGHsge2KCK4Q2eEM8g0qBJsYWK3DVRWX0Sf601XHptNJbahRsIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6157.namprd11.prod.outlook.com (2603:10b6:208:3cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 22:49:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 22:49:28 +0000
Message-ID: <622f93e6-14df-4718-abb2-33eaa5d160fe@intel.com>
Date: Thu, 20 Jun 2024 15:49:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/19] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <2e488812-671e-4aa9-a292-c54b174f2dd7@intel.com>
 <6e297b6e-e39b-e358-7bb5-59add62f8b2b@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <6e297b6e-e39b-e358-7bb5-59add62f8b2b@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:303:86::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eed7408-78bf-41ee-9569-08dc917b3d91
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|7416011|376011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGFrem5qSHJBQmV0TVpGQVNpRnZIaHQ4VVJoQ093TjgxR1VrSnkwVmoyUUlj?=
 =?utf-8?B?dTg3QXdXRUI2SlNZSVpSTk9meTFadXNKTnc3UkU2Z2R4VlppVEtHMzNsREhN?=
 =?utf-8?B?NUgvT0ZPeDhsMVpJc0liS25tVGpsTFdLWGdXbFBFNnR0S2tTanZaSnkyZ01t?=
 =?utf-8?B?WXU4VmZDR0FWcGhiV3NRTUhZSGxrY1VqNVhwSEZYbXUrNzQ4SW9hNEFYRXhs?=
 =?utf-8?B?a1dpNnRvMDhiL2g0THZzV1dxNHZjc1NqK1hHZXZaaC81SFo1YmJkQUNoQkF4?=
 =?utf-8?B?K05LNFpEd0lvNjhpVG9mdk4zOE5kUm96UHBYdHhpZVJzdlZQcDRiM0tyM2dV?=
 =?utf-8?B?VjBudXhnU21BUXAwcDVKVENDNHlRZW95NjdBdm1IdHpjS001b2RZL05rSDBV?=
 =?utf-8?B?STc0bmhQVE0zTnRqbDB4SG14UWJEQTdvY1BjdVQ3ZGFtdXBKYjhHOE1PTlBs?=
 =?utf-8?B?VVB4UG9QR3ZiS0hqVUlOVmVHTDhiVVM1RUV6a2JNa2djNlJjTW1WWVhKRkgz?=
 =?utf-8?B?bXBqeUFBMFhjdlllNGxWYzZHaElxcmRRMElCN0srTE0zd1hienRybWxiYjB4?=
 =?utf-8?B?U3QxUFd3cERXUjJtekF3TGtFeWlFWXluT2Yzelc0b3VUSjVZdTY1VDViTjRU?=
 =?utf-8?B?R3FtQ2pTT0p5N2Z0RllUaVp6U25BdkZYZmhOV0g4d2h1ZG5iLytWOGhoQWFy?=
 =?utf-8?B?QUl2Mm9JY1B5bTVZNHZtL21ZcmdPb0lJbXVXKzNVTXpLbUhuQ3B4YXNQUk9Z?=
 =?utf-8?B?anZRRE14QXpVWHY5MTgycDZwVU11cTdJbER6ck5vK1YveGJZUzc4R01TaW81?=
 =?utf-8?B?RVc0eWVIWlpyZGF6WmVDUTUxMmRTUkNiUGlVWHF2Z2MzMlloVEtSRjJuZGc1?=
 =?utf-8?B?TmRTbm5NdkFIc1BHcS9KR2FLek83SEdQVCtWYmhiZExQK1k0S28vV3NRMkN5?=
 =?utf-8?B?clhDZ2ovTkZ3ZlNINFZjdDVFOEt5M0YxajFoTWxYOWgvT29jbnVHWGQxc0VU?=
 =?utf-8?B?QTlPZGNUSmtQUWtHcGc4R1JjOFJVWmxhYWpzdmNvZW1EN0ttMUdGb2RKUVFU?=
 =?utf-8?B?eTBjLzlyQkN0UERMZmZlUmQwQmw0eE5vY3dnSCt1WFlLUG00eUJxaHR2NW9H?=
 =?utf-8?B?RFE3M3A0SUxhMkdVeWNEYUFjWmhZL0FaQzE1czdBbEx2bDBpMzhFVS96Wkdj?=
 =?utf-8?B?TTFVbnhYcXd5N2k1OWp5dnV6b2dDdFRlUmRtRjhndXpVUGl5UmxhV1VrT0g3?=
 =?utf-8?B?QjhyVGpEYkJKMmRURlF2UXNZUmRDRlJka09HOCtFVklDaXF2bHFESG1CeVVW?=
 =?utf-8?B?RWhMdGZ3Rmw1VjBJNDZHNDBOQXBkMCtZamdETkNiT1hWbFpIRlA1VlZOMjVW?=
 =?utf-8?B?QjRkaFl6ZGo0Zk95WFMrUHBiLy9EcDNBSXFDSmN4QWp3azFVWUZkU21YWXlt?=
 =?utf-8?B?NXBHZ1FLUy8rc1dGVUhXZFo1NzBNMkM1MGt6MXZzVjVYOFBTQmhVL21YdEJx?=
 =?utf-8?B?enRSQkJWWW1JQnlUL1VhWmJDbUR1TDk4TC9KcE4xcGw2L3hTd05TUmVtdVAx?=
 =?utf-8?B?b2MrbTQxQkU2a1ordVc1Yk9tdTlpY2JGSmxaWjVFS0VLejVwRXlMZ3I3RWVz?=
 =?utf-8?B?SDVxak5RdXpBS2tEV2tNMVcxb2hNNlV3cnR2eUxDNnhDaXNSQ3ZOaExtWWpk?=
 =?utf-8?B?QVlUdE1VY1dvZ0tOUWxMUC9CZ0tTNTlrZmJKdCs2N0dzYVdOZ0MyVGRXZzNm?=
 =?utf-8?Q?CQnP1HhjqrqUhDYY82N8zR85Rs+zQ71RSn2eIuS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGxQMHNTV0ZubnVvZ3IyU2VwaEw1ZXl0ZUd4TndTN3FOb29rU0kwTTRkWWQ0?=
 =?utf-8?B?UXNUQ09rc2NHeGFoNmx3NXQvR00xYkRFbjNJTWdKaC9lc3BtMFJSeUh2Mm5B?=
 =?utf-8?B?WkgzeTcrZEhwNGVOYkZmMjBONUFpRXljLzJnTmE3WXg1d1ZxWVZGWmVTcjd1?=
 =?utf-8?B?UDQ2U2VOWXM2bTQ0MkJTWU5uZk96cUVDMEpKL2M5RlRxUUwzcW9qcjJ4b1dH?=
 =?utf-8?B?enMyK0cyc3RoUVJOTzdOblVpZExXaUlXUVl6VW9NTkx2ejBYcXk0UE5NTHdI?=
 =?utf-8?B?NWg3Q2huR0pMc1RWR0hoYzgvSnVkMUlnT0hMMERScXNScTErTGRDTm1BMGRq?=
 =?utf-8?B?cWZVZkR3L2hMN2d2d1pqd0tGci90cTVvNVhUNHhQOWhxTlZlTHBnTjVNbjg3?=
 =?utf-8?B?aFpmdWQ0S29ncm9lZ2piODZwZ0ZMK1I1WGNiYmNXdmtOQVNxYzkwbW1uekFU?=
 =?utf-8?B?RGVSWnBTdENvd0dVOXI1UThXSzBxRHdlM1NkMStsRkE1K1p2VzR2NkhwZmJC?=
 =?utf-8?B?anFGN0VuTVpERVJBd2lndUQ3WUVOTFBneGxCZlFpRGZFeU5rUWtGeEN6QnJV?=
 =?utf-8?B?aGsxRS9XeUluSzZiS1A3azhRTWdQWW16RXd4SHdySzNKZGMvY1hwbUhDaGZ3?=
 =?utf-8?B?cyt3Z2QzTkNudUJheGdabThiWjVRTUJhaUFvL1ZvNXNQVk9qMk9tVEo5V3F1?=
 =?utf-8?B?b21Ba2RpOWRZMkUwMEs5aGVtVzVOMEpBSXMzZ0o1UGFNZG9XNWNzaWZwYVdP?=
 =?utf-8?B?eWxJbVUydktaeVl0YjBuRkcxekJ1YUpOL05nWERQOTNQTXN1alFpcEpvUWY1?=
 =?utf-8?B?L2lSMXRvNUpaSUJ1ZUsrNDhHK1lveGl3MG8xTHlrN1Via3ZkMXhjdTE5Q24v?=
 =?utf-8?B?cm94bHNsa0JWeFBPb3lPTC8zOVhpbUF1b2dSY3BnNUJ3cXlHY0p5TStkQ0p3?=
 =?utf-8?B?cW5hbkJjczJpeWRrVjZyK0lkWTBWdlZjWjBKTmhrRURjOTEveWk1TDFLanF4?=
 =?utf-8?B?WWRYMGpiR1BsMEVtVTRuRU02RmUwMzRSZVowQmNIK2pvNGNrWGhJTTBKd0U5?=
 =?utf-8?B?dVhzNnBkUGc4ZXRoR0FTdyt4VkFFMnk3YkNKTkhUa2VnY3JVWTh0WUx3bXZW?=
 =?utf-8?B?L1huOEJYdFpoU0t4TzdScXExK0plM2RHL001S3BFQXhZekJLSy84NjZYWVJm?=
 =?utf-8?B?ck83QkhCd1VGVnZXdGwvZ2JMdmxGemRtTjllZDRzZE1rMGpNUkxZZHpGaHdK?=
 =?utf-8?B?T0EwOVNtd2hUVytLMHhvUTBjbWVBTXd1T3ZwM0hDSXFKc2UxTU1ZNmpxUCty?=
 =?utf-8?B?R0hNaElmYVBVbFhBRWdKbGVlcjkxdkFTMm5zazF2STNYZm9mQitSc3BwQXFP?=
 =?utf-8?B?U1FmOG5BU1ZlOHZlWnkwV1lXUWE4N295TzBXajA1Qmd5S3d3MlIxenhLVnk5?=
 =?utf-8?B?ZVgwcXM1UVR5Uk5mOUpuK2FhNW1ZL3RSUGprMXQzS0FMcXh6ZkNnaFR3b0ZT?=
 =?utf-8?B?TWpFTDVhVm1LTkNYYXcxZFppdDcvL2J2b0JEbDg4ZnVJMXV1TWt4Y3YzNnZt?=
 =?utf-8?B?ZjkzTXYwZUo0WkM1T3RaSllhbDhBVVZsR1FUdlpaWVcvVE9iU0hZd3VDbmRj?=
 =?utf-8?B?djhBM1V0bUxib3l3K1B6cCtGN2IzWmFzYmVJY2dmOFpRVTlwekI2VkQzMXk5?=
 =?utf-8?B?eVNqejE4cFhldDFBZ1hlTGJ1NEQ2djdadzhxQ21abSsxWlp4WHdObkp5R1hV?=
 =?utf-8?B?N29oMnFBL1pRemdpVDhQY2F6azdIaVNlelM2VXJkcTJqK2dzbmI4LzBjUEhl?=
 =?utf-8?B?MTUrL3VmWVM0WG5SUTlXVnFHZ2QvTzlUNkdkTkhoRDlqUFp2amt3MVhtb3FL?=
 =?utf-8?B?eCtTVFZMa0ZEdTNnZjBGSmtaUmpZMHZBVDJhSzNPbEpBVmdIUlNkRlliOE9X?=
 =?utf-8?B?R2lRakkrSk9WWm84Z0hORko4b3BPaUg3U0dzYUJKSUdqV09rc051cmlYdmRa?=
 =?utf-8?B?Q25xUnA4OWwvQy9ZNE0wUUwyRldqTk1RaW1YTHlpRWIvQVhZYWIzRHg3aWRy?=
 =?utf-8?B?ZlhTdU5oS1M0cWo5dFRwTTFucjIyU0gwdndzcERBaElsRTlldTgxZWEyc2R2?=
 =?utf-8?B?bEo5REs3ZVhVN0pvTU8vSjlaTTZFMU9EcG9RekFlVmNOM3hyR3RxNHVoNzFu?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eed7408-78bf-41ee-9569-08dc917b3d91
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 22:49:28.1206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LXOpQU3a5D9/j2BPjLGz2unYZ1x3ivf7ybNlfAACRNcio9UqvLeNtRmBN9trPNSWOHep9IdlWI1P+UhOubOirRVLgkaZNR9lSHss9vPV3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6157
X-OriginatorOrg: intel.com

Hi Babu,

On 6/18/24 2:02 PM, Moger, Babu wrote:
> On 6/13/24 19:54, Reinette Chatre wrote:
>> On 5/24/24 5:23 AM, Babu Moger wrote:
>>
>>>     when reading, then the read will come back as Unavailable.
>>
>> Should this not rather be "Unassigned"? According to the docs the counters
>> will return "Unavailable" right after reconfigure so it seems that there
>> are scenarios where an "assigned" counter returns "Unavailable". It seems
>> more
>> useful to return "Unassigned" that will have a new specific meaning that
>> overloading existing "Unavailable" that has original meaning of "try
>> again" ....
>> but in this case trying again will be futile.
> 
> Hardware returns "Unavailable" in both the cases. So, thought of reporting the same without any interpretation.
> 

I do not see these as the same. When a counter is assigned and its
read returns "Unavailable" then the user reasonably expects that
retry will work.
When a counter is not assigned then no amount of retries will result
in data. How is user space expected to distinguish between the two
scenarios that return the same error with such significantly different
meaning? rdtgroup_mondata_shows() can just peek into the monitor
group state and see if a counter is assigned and immediately
return "Unassigned" if no counter is assigned, no? I see no need
for it to IPI another CPU and try to read a counter that it already knows
will be futile. This seems unnecessary and the generic "Unavailable" is
not helpful to user space.

Reinette


