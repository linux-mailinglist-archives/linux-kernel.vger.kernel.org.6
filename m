Return-Path: <linux-kernel+bounces-365025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A496D99DC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E2E1C2119A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CCB16A397;
	Tue, 15 Oct 2024 02:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="heN7jSfl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087DFC8F0;
	Tue, 15 Oct 2024 02:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728960215; cv=fail; b=lnRK2ZinQJ+IGwUsaijg4WB0xogaxRkuQ1GsONdmSbeSg3f8SF9dFGRsqq9C/ETcgEEJ9hnNZD043VwRG6VZwL5Y0phoLkUAJI2kcpSvwFQh15W9z9uUQwlttM4Cu3goWlioFbvG6ZV4JvZq+uyKQrd3c3iCjoSqz4hzLE15uiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728960215; c=relaxed/simple;
	bh=a11/WVGPnwodjlRUoXBGVxcG2DIbS8ngpYiOhPXiNGY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WypRvUXMbG7I8oUy2tcPQzSAP/jk9JKDE6HrjIKHHTjvSAoljoIlD+sjTRMLAzxWdLfcYfHp/DToeendeB2yUOH+uwJ1u3hGgSHruNemx/KeS5Ktkej1gI2kAMFtLycn8fXCWuNwf7fjmnfMlTX1i2nowLHklAB1FYic9zGOWwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=heN7jSfl; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728960214; x=1760496214;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a11/WVGPnwodjlRUoXBGVxcG2DIbS8ngpYiOhPXiNGY=;
  b=heN7jSflFPPMRcgDfEShsmWRXCg9YrqMIjoeqZs5i1KKyy59CETxErFg
   lRhk73ahQ2FGzXiKRwbsHxxcQ7amn/z8Jcr5sBwz+rQjRouAVH9J1FUWc
   Teku3KwKhVkrttjEBpvQp27cvLitzw8S5hukktjyCYA3SWKHA4ZK5cbLk
   cbW8kkavTHj1Orh4LVwUWCL7kPy/U/M1Wq9sOMBimFEE6S/Mu6UF3we2u
   6Pl5PyKnChCOcGX/k1esLBtCnjLMolOABAUT8YF9tqLN08Ahg1Z2+QIQK
   KEkUezn8N3uIR/bWAVaWnK4/egIuwvVc7Jo9ZS7D/wIglbO9KynL/OeP4
   A==;
X-CSE-ConnectionGUID: qx2YaKTIRpKw3XQ4zbtbmw==
X-CSE-MsgGUID: KjH251mBRmeaGTacY+hJLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28461885"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="28461885"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 19:43:33 -0700
X-CSE-ConnectionGUID: cKQmHv1UQ9uQWKVYNEbPkg==
X-CSE-MsgGUID: FvrJj7K0S6uEcwNY3RMBFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="81722591"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 19:39:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 19:39:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 19:39:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 19:39:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 19:39:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rh9U5RAzjut1uPYd134wCmHZCTf2vg0Xf00P9EX1tGKMi/cVU5oyRJP7Xk6i7g8zSXZ9WuZ/mS+XxN2JM6xAOvGTSwkcXlXVh4LJcB9zR4BS5D99+8bYrdb014f8gSbsbW0Cp2t5e5bL1dH625ITRi/g7hl9MK9kbl589bfWWuPuiRMwWqojzQr3zPkU4lcaQn+C5G4AtsQrbPDzVlT7+e+VnpEk1+ulo9JfUfBiFW6E2uSK/BNeJWEqkNmCAAzWvfEnv7qI1lV/AdIN9v3TwBHZjTnEk1pwZ9JqbLhQbAQzfoDweDvqF5B9dMcyVOauPhBBKhd0nXm7tFOyDsqyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1A4gNT80BuHcJYwns9OjtSKSemHXevJ3+7TPq1Mek0=;
 b=Zda5uF96T2lnO0qebDi53Y0vKCQLaY/eT1aOtRsmmnelM7L5VOlt7b/F3CwcJnjbNIqicqjLiluD9yqrkJ/+XCINnlJmSPr0rUR8iAy5BMVFhutKrqHGEqR+QiWY6DpKpi0o9aR8JJOzK24obwe5oL7vN1e8/IpFpMo+InbIxfd+KrQa889RuGm30xVWQj3ob9hhjOwERwIb8egH+7gM+95dvZ/c/0EsXoZ4hf9s/D3ZhrvO0TZ3OI9fLk90TXcMiP2nQDCzF7pvUUjjKuCeN6WfE+hegiYHLRv9kUi3XyUkLOwKJkyD68UeeV+JYCavG+U2tUh2LXT+4MYixo8xdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6093.namprd11.prod.outlook.com (2603:10b6:8:b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 02:39:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 02:39:10 +0000
Message-ID: <567bd687-a69f-46fb-ab19-3f8d95c5e798@intel.com>
Date: Mon, 14 Oct 2024 19:39:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 19/25] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
To: <babu.moger@amd.com>, "Luck, Tony" <tony.luck@intel.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"tj@kernel.org" <tj@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "yanjiewtw@gmail.com" <yanjiewtw@gmail.com>,
	"kim.phillips@amd.com" <kim.phillips@amd.com>, "lukas.bulwahn@gmail.com"
	<lukas.bulwahn@gmail.com>, "seanjc@google.com" <seanjc@google.com>,
	"jmattson@google.com" <jmattson@google.com>, "leitao@debian.org"
	<leitao@debian.org>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "Joseph, Jithu" <jithu.joseph@intel.com>,
	"Huang, Kai" <kai.huang@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "sandipan.das@amd.com" <sandipan.das@amd.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"peternewman@google.com" <peternewman@google.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Eranian, Stephane" <eranian@google.com>,
	"james.morse@arm.com" <james.morse@arm.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <ce07d802260f537b24b3affec57c2d2e65023709.1728495588.git.babu.moger@amd.com>
 <ZwldvDBjEA3TSw2k@agluck-desk3.sc.intel.com>
 <541d6c15-ed5f-8794-506c-8fa4065ca170@amd.com>
 <SJ1PR11MB60838F3FFF40AE2718ED7833FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <43654ae1-c894-409b-bcb8-065940644906@amd.com>
 <SJ1PR11MB6083379F790967B379C4232DFC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <a972dfe9-341b-416c-a245-0834583c6620@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <a972dfe9-341b-416c-a245-0834583c6620@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:303:b5::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 8014cd45-d8b7-4f5b-b8b3-08dcecc28c74
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1pBbDE2blNoRmFKbHMzdktyK0s3RzBSeHBENnBLdUVORi9lS2d3aDFYRnFp?=
 =?utf-8?B?OGM3bldlQmFsU0htamhiK1JaMEp1TzA3bFNZN00vWlYzMHQ3eHQ4M082bDQr?=
 =?utf-8?B?YkZNZVFGOHNtQ2tsTElJNHZmdktGeCtqQ0d4S0I4NEIvK045RFVxaWNGRUxC?=
 =?utf-8?B?OXFHSlh6Mk9DT1hQMkY4cERJa1Z4OXA4Ni9hOGJlTlN0SHZob1VCOE1UU21T?=
 =?utf-8?B?VGx4ZStjbEJFZzZ3cHdiQjUrMjdKQXRFV25iMnM4cllzWExzcEZSdk5hTXpG?=
 =?utf-8?B?OGJwNE83R0ZJM2hoUkZ2ZXR0Sk9ibHlLWExnSXdjYmZTOTRrZTh5YmFHR3Bh?=
 =?utf-8?B?K1B0SHR2OUJldjYyVW11L2tHVUR4SnN6d0xja21UamhydGpsT1VwVVE2TC8z?=
 =?utf-8?B?QktNVjBPakVNcWxOOGJLOWVyWVhaTzViamRNQzRlQUhxcW04MGJBZEhRSXcr?=
 =?utf-8?B?UStFU04ycjFLM2lpVVNyOVIyTlN6Y1NCbWdDOGk0RU9DOWlDR1hudzU0MjA3?=
 =?utf-8?B?eDdhVFQrWjdCQUNzWTlyTlZzeVRNVmdhWklvODA1TGd0K1ViSTFtT2RDTWdy?=
 =?utf-8?B?QWpZeCtpUU1MdTZ4UzBDN3dBcFNDYmZzK0FvNVNlL0x2NlRETzA1Q1FEbVRa?=
 =?utf-8?B?blBQc1MrZWtJejRGWElOV2lwT01GQjVHcEpNdyt4SitJOU1jZDN6SkRLZ2Fv?=
 =?utf-8?B?dDdPMldsb1V3VnFBa3o2V3R0YjZqQ21Pa2JYcTc4TEthRFpSaU9VMXB6aEtO?=
 =?utf-8?B?T1E2c0hhN1YwUEtpUzQ0alU4RmwyWWFFSk04RzB3UWpYS2dzblpFbjNiT2I2?=
 =?utf-8?B?dk93aHJKZC83YmdSd2hLaytuUm84anNHZzlKSUZORG1uTWRaTmZRL2tId1kv?=
 =?utf-8?B?bnhtU0JxMGVmTXQ2Si84RENUUVdSTFJnU0E3U1pDdGduaTNOc0o1MXNTZHdU?=
 =?utf-8?B?WC9zeHNLcGRtbTdic2thdzdZTHFvNitwY0d6M2ZTOXJURDlrMysyMVY2akk4?=
 =?utf-8?B?czdnb3ZwbnM4a0pIOVQwdTVMUlFxc2ErQklVcEV6N3lGWlQwcmxrR0g4TURz?=
 =?utf-8?B?Q1RkTExVYURWUkdUMUU1WlVhR01yT1BxemhyZHJzSVVkMkh5Uk1sRE9NQkg3?=
 =?utf-8?B?OGNEWE81Mnd1STFkcWRKZEVrTTN6NjlSaGdzUUczcEh6dEg0bHpyZUhOdHIv?=
 =?utf-8?B?NDV5K0U2amRXMEY5TlU5REtwdkhuaG1SbE5Dc2FlWk93ODU4WUlTQWh6eDJ2?=
 =?utf-8?B?SnRIQ2VnODBUc0xDTlplOTlGVXNPWmJ6YllERUg0djFLUFJGVmpqMUllSUdK?=
 =?utf-8?B?VWxuSXkvYnp4d2lHbTFHNjdUZTVzanBpUlE4V29lOHFjVzFNbE41d0kwZUhp?=
 =?utf-8?B?eUhZSXdtKzB4UW1kVEI0TVpGK1NWU1IwSmV6cDRNd1R5MnY4SHh1M1k0THpU?=
 =?utf-8?B?NENGTDZpOHZNckU5YWJtVlhFenRJUFlsMzV4YW9za3hKR0FmaU5GRzFJcFln?=
 =?utf-8?B?bWdUdExreDhVWGVBZ284VHJTbjFWOXNjY3FlQWZSU1FSUW5WTjhWMXlxTndq?=
 =?utf-8?B?dTZKWjBBbFo2ak8wSHdLcEpuUmNNTFVKbER1aGFBUnF6ZEpRS2lENEk3b3I5?=
 =?utf-8?B?WW5KVkoya0U4UGlrUk5jcXZrTGEyeWNLMnJRdzQwT1VJSWQ5Y2EzL3FwVUZy?=
 =?utf-8?B?TWIycG5VWVArYlo3cTRxTHVvR2R0YmlBUldYeVdESG9XcWVGVXIyOXZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXJKL3IwZmEzOFBDaUNCREszdEpibnA5NkhYeTVGYS9SUnpoOWV3UWpHMGpJ?=
 =?utf-8?B?WEhMUUM1MEhSMDJiQmZHTzI3WWtNYWJkdmFZWldwdXFDeHNpK3RyZVRuUWl0?=
 =?utf-8?B?dGVJUXJEWStqOCs4TG1EMEpNUXdtcEI4TDNNNjViYVFYNFQ4N1l3bUFtczk3?=
 =?utf-8?B?UndmOXhhQ2Vkd3R2bkZaV2ZCdUROVnRlMXVRR3czT3ZNQWVQa3VxYkdDMXEx?=
 =?utf-8?B?V0ViOEhPL0dLaVU0RWE0SnNEQ05mRFZVNkNPS21ZZ21MaFc5ekFEdHlpenpu?=
 =?utf-8?B?VHBqMVVQb28vNTM4SUV3RVc0dWlLOUwxTmMydm9jaTFSY3kwaFVydHBCYnpz?=
 =?utf-8?B?anFJalpRWEZpK003dXJ2bnRWd2tmZnhFcTFVUnlURVNkbnB0RUVEZHIwd25G?=
 =?utf-8?B?aWplRmp0TFF6cFNjV01YUEFyVE9lTmMrTHlsRjRBTWpGSTBkbnBDalB1cVUx?=
 =?utf-8?B?L3BVNG1RZDFjQ3Rkem50S0hFbmtFZm56ZmQySm9jNVBDbFdjb28yaDB0MEFD?=
 =?utf-8?B?VVpIZE1aUzErUjJCckVDUHZlek1mNTJsa1lsYzVzaCtJd1d1MnRSb3g2eVY5?=
 =?utf-8?B?NXJnNk1QbkZkU3lqeDNTSzNTNHk4amtZeVFKZ3Z3UnlHWmhNL3A1Rm1DaFpH?=
 =?utf-8?B?a1NDRjYvU1ZUV0wxSWN2ZUQ4SEdMWHIzbUdDdmptMmtWdU12Z3FQdjI4VzQw?=
 =?utf-8?B?ZTJENnJaYnl6TUlzYjFFaG1TRGJuejFIMUtQZjRYeU9GaHJIZ2dBY3RkR09h?=
 =?utf-8?B?eGNSOVc0NjZkQ3UxTDZpb0RmNnU2eFpFSndaZWV3WDBEZkRrMmI3RlFUMThF?=
 =?utf-8?B?QmY1ZGVYc1NaZG5QQjZOTlZ3MnJiR05BUHNSWlNQajB4S2ZoRjZ2MjJLOGhv?=
 =?utf-8?B?dVZ0ejBqeVdkRXdPdWpRVU42cVlMbWJMZktTbUtZelZISyt5bDhGaDBUMGZR?=
 =?utf-8?B?aS9MS0IwdjBUWi9ZN3FyVS9vTVpYYnE3MWRIeU9COTZwOVNScnBUYzEzZCtW?=
 =?utf-8?B?c2V3dFkxZHJRd0ovckI3bjlXY3VLeTVpV2QvR3JGa3pKWnRINVVpcUlGUHJ0?=
 =?utf-8?B?SFQ5cGJzaG5RL3VWSWFSVnEydGh1UGtQUGQ5a1VHYk5udHNURXdjY1VzQjkw?=
 =?utf-8?B?SzhpQWhlY0h4Tzd6ZkFUZVE2R25Ic0FBeG5MUnJpazBKelJia29xcWh2RHNi?=
 =?utf-8?B?bm8rb3pSZ01WTTdITUNGZStxd2c0VlNDWGtjZCt4akExUktKcXg3M2tFSzJY?=
 =?utf-8?B?Z0FQV25sUEdDMWpFamxKOXYrNFpBdVg0cHgydDhWd3g2Y25rdmcwcmtNRGc1?=
 =?utf-8?B?RndQNmNpalh3T2JMdjkvRkdha29vc2hFQ3krNHRpalhjbEcvaktBbXpOTU5p?=
 =?utf-8?B?ai9VVHN6ZVhWN01FZnhmWE1ZWFNsR04xVm01YThjaGc4bHpLNTJzUjJtdnda?=
 =?utf-8?B?V0w4c3AxZis1TndKVzZGbFd2ZVB1SEF6eFBBMnFmUVV0ZEZiOEtJbWxZNmU2?=
 =?utf-8?B?MzhyUzlQejBVSVhWUWdkVVhETkhDZGlNMmlwRW5OMzVaR2VzVE1FaWh0MEVs?=
 =?utf-8?B?d1ZBR1VvbjR0RTRSREdHR3V2aFc2dDdxL3lidVpKRks2cnlNVzZrckdBZ25U?=
 =?utf-8?B?SFVaUEYrQUtlSy9yRUN6NGtzeVZIK3kyb0pFMHVNZFB5SlJFL3o3UTdQVER1?=
 =?utf-8?B?RkpBR3N2U2VXMUp1a2Fjblo4OFJYRFFGU0ppVDZTOUh6Q200TStPdlNycVNZ?=
 =?utf-8?B?YkFaaGgwOUIrM1hrNmJlVHNwMDVkckFjRUExM1VZTjROUlF3d29OWmx0bDBj?=
 =?utf-8?B?VVp4R0ZBU1pKNWlVWUowc1AyVi85QkpoOFVCeS9UeGphdGhmZTkwTUlLQm1q?=
 =?utf-8?B?TjJtZ01KVFIvMzhjVkh3NXBaZkppVUtmOEYvYVRBTjhsOWtBc0ZOc3NZWjQ0?=
 =?utf-8?B?N0VrV3R5MTlKVGNLTCtuTmE5dU5PREhKRktwMG9XTXp3NTV1OXJsZVMyVmhF?=
 =?utf-8?B?aFlvQk5PWWlwVkpnV2tRL0piS2w3L2dPT2d4LzFYNld3REZlcXFBTFhCTnps?=
 =?utf-8?B?bTJmV2E2TGFMZk8vMHpBb0xORThpN0JPVHJsUitsNU04cWcxWWk1ZWQzejkr?=
 =?utf-8?B?MkUzVjhOYk43MTJkdVBteXdjQUluZGhyZThWK3h3c29MYmZCbVJ3aHZ5c2pY?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8014cd45-d8b7-4f5b-b8b3-08dcecc28c74
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 02:39:10.5150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jl8bD7vPde3lKGA406mChuyS38Z4kXxu4RBFYwd5b9Y5hycW1RFf9dhzEFn2CSE0uwFlduYMiGPU1UEaEdIvnN96XW4cTdxonurpVjVrJDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6093
X-OriginatorOrg: intel.com

Hi Babu,

On 10/14/24 9:35 AM, Moger, Babu wrote:
> On 12/31/69 18:00, Luck, Tony wrote:
 
>>
>> It is still the case that callers don't care about the return value.
> 
> That is correct.
> 

Are you planning to change this? I think Tony has a good point that since
assignment failures do not matter it unnecessarily complicates the code to
have rdtgroup_assign_cntrs() return failure.

I also think the internals of rdtgroup_assign_cntrs() deserve a closer look.
I assume that error handling within rdtgroup_assign_cntrs() was created with
ABMC in mind. When only considering ABMC then the only reason why
rdtgroup_assign_cntr_event() could fail is if the system ran out of counters
and then indeed it makes no sense to attempt another call to rdtgroup_assign_cntr_event().

Now that the resctrl fs/arch split is clear the implementation does indeed expose
another opportunity for failure ... if the arch callback, resctrl_arch_config_cntr()
fails. It could thus be possible for the first rdtgroup_assign_cntr_event() to fail
while the second succeeds. Earlier [1], Tony suggested to, within rdtgroup_assign_cntrs(),
remove the local ret variable and have it return void. This sounds good to me.
When doing so a function comment explaining the usage will be helpful.

I also think that rdtgroup_unassign_cntrs() deserves similar scrutiny. Even more
so since I do not think that the second rdtgroup_unassign_cntr_event()
should be prevented from running if the first rdtgroup_unassign_cntr_event() fails.

Reinette

[1] https://lore.kernel.org/all/ZwldvDBjEA3TSw2k@agluck-desk3.sc.intel.com/

