Return-Path: <linux-kernel+bounces-271875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A891A94543E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF021C226A5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C0514B956;
	Thu,  1 Aug 2024 21:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atEFR/bp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EF7101EE;
	Thu,  1 Aug 2024 21:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722549005; cv=fail; b=NxZvgV/LwljPf5FjTdLCxfrd8kC3iQ2JFk2pUtQeptqSq9z/Pt4Yhu4kYqe9GcptPLkvrYHDF4P+uomaGyZVsNTDhnLfRPYh/3hyr4hpWHapdZEZ1vdNjso2U7iLflBeLWxI/rngqiVcfcAFHGnQ8aYgZ6gHRQ8WOtgXpGYJtV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722549005; c=relaxed/simple;
	bh=GQTIJqEEyofw1JMM8e1zynWhBRl+N6Yk+WMSvSSei7s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MoBbEwb62Adv/04LJEdl4N41b1qdwj7CczhlGU4pN6Hk3AtJBoAcjXifU73c3TBWUBceUx+6IbwMgiNjSGySMWgN1WlyvujfX9WJy/19cxRZkq8bDewOuTEDNwlpZ2SjsSpzfxKKNjNzjGQMtq16RPK2RXB/iyBdZA3tVTnjhi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atEFR/bp; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722549004; x=1754085004;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GQTIJqEEyofw1JMM8e1zynWhBRl+N6Yk+WMSvSSei7s=;
  b=atEFR/bpaLi2Z2SXaW4GrIoRTWEzB13L61b+RwlhPe1GmWhzuPbL+D4o
   fGv739E3Wg3nP4Nr9ODNvkDQPQPuodX4AYSDyQ0q7p2EHIWO+iJMQyZbo
   CfTBOrCxyd6LeG76QgDgHtx7C2VnRzwVfhlx60nDwXJcAzrHZZBzHzLp9
   NqFxX/OhGjDYSMHDpxjVRgcYyRKGg7q6d36L3SXD8pxuJ5UTi+3AwBk6h
   EP4Gi0kBp2iq9X8vmTLK48nxeJKCh7onwpHg6toVztEElS8wgIDp8XMJS
   qolYqD4ji90iH95urzD6/Pl9RKlrPFOf2/Disd2ZPJzcZlKqaPNfQn6mR
   Q==;
X-CSE-ConnectionGUID: nDyDxduKSMGDKbvnaAeWxg==
X-CSE-MsgGUID: LJoqUqtPRvS7unu2DrFPiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="23458088"
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="23458088"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 14:50:00 -0700
X-CSE-ConnectionGUID: xqOS2Hc4T4uMBMnaQFvZFw==
X-CSE-MsgGUID: BoVRWyR/QPSFaLr8Uo06Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="86120747"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Aug 2024 14:49:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 14:49:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 14:49:51 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 14:49:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0/6y/mxBUpIJul+MraMJbvkvRf4XUMhrfvOC0n34aqgUj+vF6sii/bCFrMxBwBmz67rJ3lF9hqXhFrV8ZNdI6Tqaasqym+RGDtsZDE2SxqEzleQo5O5WHd5OCbMdL+rl18VASaV5/x6UY7m8HjT3/hgnjHoJOCsdjoKrANQDS84nvGd1vu0R2pSMnKyYw+Bcwdqp0CtQrivEC59ilPEGfLeqxGZ/Sh1yNTbwgGAy7EfxTiIuQt4gpbRlZgJ/zKHZpgvBDB2dY3Ku5NuozJmTyuEHeQuf1g+wgbwOWH88mGtPQbP/vdTTY66RyicCma9KkAezgTKMPA/59MbXDy7WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxe9bScASXn6l2totp5Xhc8BPkwSEs5bKCGp+In3ssg=;
 b=Yhe8ceuQvVx2ghAk44ZpeH89vzLY0ilSl2slG3bh8JJbUvb6wRRK+KgBGXGbj71NDqrkjrCWVb8kZwqrqZe0j5K7ARDrm9l0zc64n5+IPUSf88eI3RBrTVfCQqofbUwv5ZWAO36Vw4yIohqXiBzPT4LZiaWlaArG9wFnuWtqCTcztbZxRzaqpoyohQeSaz7Ey//koYD1kL+C+TsiCdKZeArkPQ1mK0HmzmYkWgfXSPafsWtJZV1PSvFyvl45n80ElpXJ+9GFzQOFivybWPpJBSeMGWSL41g1hkQux8SfbAsMglnIb+0RTFUY/sDiYFPEy5YcAESkzalXraB1t7l4ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB5870.namprd11.prod.outlook.com (2603:10b6:303:187::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 21:49:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 21:49:47 +0000
Message-ID: <05b4e345-ad14-4ea9-a13f-2c9b3a6eb422@intel.com>
Date: Thu, 1 Aug 2024 14:49:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/20] x86/resctrl : Support AMD Assignable Bandwidth
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <e04b721a-b5cb-4089-a3ad-125a6247e5b8@intel.com>
 <1c50b589-a738-4ae6-8362-bd1ce0d0dc98@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <1c50b589-a738-4ae6-8362-bd1ce0d0dc98@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:303:83::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b177f92-ccc0-4b9d-fcf8-08dcb273dca0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3BBUzQrR2Y1NDcrNHkxK2tLRHRucXE0WnBrc2RSTEFqcG85ZTF1Y1RhbTYw?=
 =?utf-8?B?VnhMVXhOT3lXeEYyWUU3WU1QenZSVG84MzVsMlVOU0lZSllIL2JEaU1nU29n?=
 =?utf-8?B?NzBackc2bnVGdENMNlM3QzdXNTZmWlRJRjg5L2FzOHhid0hCaXc2OHY1ZWlW?=
 =?utf-8?B?WktiYWVGOG90T3J5c2NDcWd5SERtbHAvd3ZUMEZMZUVhTW02Tlc3L1FCVnN3?=
 =?utf-8?B?R3N4MlBka05SY0p2V2RXT0V5alJQcUNTREFsN2lwL2lEU2RGc3VLNDAxT1Ft?=
 =?utf-8?B?T3ZuV1BkZWo3bXZUaDZlWndGSFl6eFlMbVRONEZnL3FEcXZCWmtabVJCZ2pu?=
 =?utf-8?B?VSs3ZWVYemZyWHp4dnd0dTNqck5XTExmN1JVVjQzOTN4SGhzdy8vM210V3Z1?=
 =?utf-8?B?bktCNmJiQ2IyUHpVTzVkNjFHSi9yeW5GTUJCeUFveHpoV0pEdXhrUUpBWi85?=
 =?utf-8?B?NGVoVGpRcU8vSVg3Wkw0NWRQMDNCeTEzbDUxZEp0aFBiZEN5U045RlJlQ3Yv?=
 =?utf-8?B?ZTlGemNuenUvVmFucWFCZE5jTlJVbFVLRkxKWkZJZG9hNm15WkQwSE1ZUEVX?=
 =?utf-8?B?VERxRkxnU1BuU1dEQkdGaUE4cFFxV21JWndYeWgrTFRLdGQ4Zkd5MGVaNmov?=
 =?utf-8?B?cHVNU0J4SFdpeGFIYkI3OWRyYnFld010NnlTTDBOSjhxY3orQVhPdHFJam9D?=
 =?utf-8?B?NCtnd0FIelJQYVkxWm8vRXBZWnBDbG5jNWR5OUp3cXhrbHIrNnFPUUJ4WW1V?=
 =?utf-8?B?cVMrS3NwSEJaYmlvQ0dueHlEV2ZaK2lqaDBqTlYrS1ZMYmVXaCtvcnlRV1E0?=
 =?utf-8?B?RGJldHRDQTZTQWdQdVlyMzJPYXBORVlGc0szNUowbDVQYW82anNKS1Vwdlhi?=
 =?utf-8?B?djRWVmk5eW1CbUlJSU5ibmp0cC80Q1RGenFkS1oxblYxMHQ4TWRCY3VzZEo1?=
 =?utf-8?B?TktTOXY4RXlhN29ybmVlcFkzRGhEd1JidTdEUzluMnE2T0x1cEcreVNHKzdz?=
 =?utf-8?B?ZXZ1SHdPNGZvcTY0UkZqM1ZhT3dRTUtDNThoTmV0RExTVUtGU3ZMcU9ka2hY?=
 =?utf-8?B?ekJnZU1Yeks0RGw0U3hOS2ptRUszM0s4RmFremJIbEZ4emdrV1duejFvcEJa?=
 =?utf-8?B?eXZFbVZhczZFN0xMWEtqY0ZBTFhrdmJ1UERuNEtBT25kRGVSUktuUm52cVVH?=
 =?utf-8?B?Vm9WQmZZZlVvV2lkR1Nrb1VoN1lEeEdVUDBwU0p6a09rVE11M25MYko0ZVY1?=
 =?utf-8?B?b3lGMHpYSlBwTXVPclM0Y3VOdGxYQUIyOWc3aW1Mc3BDdmFSM0RNK3ZCNDNj?=
 =?utf-8?B?c0lvMmlGS3Zib0l1TUppQTR2bVllVDMyVFBDT0RUTFNRWi9lQWl1Zlg5VHZr?=
 =?utf-8?B?Z2RER09wTkNHamVBajhPYnpXU2NyNGFUblFNN1M2TkxMRW9NMWFmTHVBL01R?=
 =?utf-8?B?MnNra2txVFdUTW5DdVVwM0xaWnpjaTVGdktLcVBiRFQ2anp2RkNrd2w2K0NN?=
 =?utf-8?B?QzNveW1tdGhkNlEvUW43c0ZOYm1EdlBhQmlGZlJVVzJlQ3NJYk9zUEtsaFBz?=
 =?utf-8?B?OWl5by9meG1ycHgwc3RCeTVMYURxWXltTnVYYm85Q2lUYjk5ZjVGU1pzYS9q?=
 =?utf-8?B?Z0c2MXdwYTVqWDZmNDgwdzNrbmpHeGVxajhhVC81b20vcWJLYUhGY1RJU3VU?=
 =?utf-8?B?aU5IQndJYWRSa0VkcmJWa1J5elpzdUlJZ2JmMEdvNTUrL3ZEcThpNUQzYk9O?=
 =?utf-8?B?OXhBMG0xTGRlbWo1MGtUSmErTlNiYnRBcXF3N3V0V0dqMmE1YWFkbEE5a0da?=
 =?utf-8?B?ZEhWekZlM0RwR2wycm4rZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RExoWnpsR1dxVlo1bmFFYUEvdThDcURhSVJaTUg3UUphUmNMWVlXRlVDQzU4?=
 =?utf-8?B?bTVEZThtV3hYYkQrazhVemVsNU5zanplOUxTbW4reTZ2UzAra0pWajZ3VU1C?=
 =?utf-8?B?LzhBQXhXWCtVUmJ5R3FqQk9sT1o0QVNxaG53L0kxaEc4clBNQ0t0aU1XMWJj?=
 =?utf-8?B?TmEwNVF1ZU8rdWtGaFIyMzF2MmNCOUZWeFJmbmhWVFJxQkg5aHFQUDZvWDFo?=
 =?utf-8?B?WW9JdWxaeVZSVzJDVmluYlFuaXM4SnpRc0wzZnVLaWc1dTRiTjdMbUd5Z3VY?=
 =?utf-8?B?SEdDdUREdk9xUjBzVnJ4RDNhRWpaMURVRTVIS0ltVkV6QmJCNnI3WlVRWmRh?=
 =?utf-8?B?NVEyVlp2YmpPRGVYR0p0Q3daU0xMMVg4RnlQSTBudnFnVjJjQ1BrVGxtV3Q3?=
 =?utf-8?B?ZklMSkZHVnBLRlRuVlRHMXhHU2pxRnlFVmVsVHJOVUtxa3FPRVlBWGJkaFho?=
 =?utf-8?B?MHpUV0xDMko2K2dnK0JaeWhhNm9DWmY1RExSSnVIMEFyT0w1b2RIV2xleDUy?=
 =?utf-8?B?RjR4WXZwNFRDeU4xWkZHSERZc0NyOHdEVDd0ZHRQYVlZbFBGaUNMeHlqN1Z0?=
 =?utf-8?B?OUxweWROeG9uSFJSM0pNRjBxMEs1cjVHcXhjTjNDNVZWSTVGc3plZmdlNFI1?=
 =?utf-8?B?OWhPZlR0SWVQTVo2THBwd1F0MjliUVM5TU5CaGVoM1dWNmpYaHgzaWNHTk5S?=
 =?utf-8?B?N2liUzBNbzhhWDFLOHdHTmY4TXYrLzVBTElIK1hKOWlqY3paQzdObUxVUlVk?=
 =?utf-8?B?NGY3dDE0emxVOXRqYjhPYXgzR2xwR29rTkRZVGU4Y3YxSmZDZlFFbGszTXNK?=
 =?utf-8?B?U0dQS1JaTlNtYzB5YUZQalp5Q01IUWZsSFcycE13OVlDOU1mOWYwclNhNXRa?=
 =?utf-8?B?QytEUzJvWVkyNDZManIrUmVlU203cVZhUWdkaE5TRFlGVnYvbFVqUXFjQnR5?=
 =?utf-8?B?Mkk4ejMwWmpYNjN2c09FRUhLbDBvL01mblgyVTVtWUhqRjQ2VFczYXZMWlo0?=
 =?utf-8?B?dDhOZzM5UFNHcmFYbzZENm9kaXJWRUJxaXlMNHZBejh6S3dYTWtQU3d1cmRJ?=
 =?utf-8?B?Y0ZUbzBRRHBZdjZyd0tKaERPUWkyS2lhRU1tU3FNbVFQMTF2bk1EZG9Oci9S?=
 =?utf-8?B?cVdLd010R2VtanVNVFdObGlKU1M2dW1pK3hNemNIZHVaaWtOb0xCOVVtVUFh?=
 =?utf-8?B?UEZhZDdmTHJLclNCdnFvSTcxaWppclJqSW5PeG8xVmZDVVNVY0VJdXQ5SThC?=
 =?utf-8?B?YkU4cG5JZVBQTEZYNGcxS0tETHYyTlFHTkFmd0ovRWNQOG92eWRBVUpiRE1K?=
 =?utf-8?B?N09nUnB4bURXanlGaHR1dGNTTFM5M2tRcnlrZVJKbUo2SzV3ZVlEWStkM1lj?=
 =?utf-8?B?WXpXYUM5bVpzOUVvQ0I2UGdBbWR5NUw3WHdBZ1pwQlhvMlVoaG1ZS1VkaTNl?=
 =?utf-8?B?dmpadVpzZUNxaEJMUTVPTEVPUzMrcHNxNnRpT3lqTUVPdkJZWWovOUozdXBN?=
 =?utf-8?B?V0U3NlZyUmdQSzdaUW9UNUtSbWVYM3BsYVFmNWlaaU5SWkhKME9KVjBqSWRh?=
 =?utf-8?B?Zm5LTU1vSmpmZitqL2JmK3ZyalNwWjB5Mm9wUkhXOXZkSng5eHdpNjZ0cStu?=
 =?utf-8?B?S0Fsei9IOHFNUm1jWHFqM2ttVllhLzFvZHdnSUVGRDJhT2hCZG80di95TzFr?=
 =?utf-8?B?cUViRDFhaGljUlEzWTExbmFzSTVaVlg2VDNtR0VraXE5S0hTS3NsZEY1QWxE?=
 =?utf-8?B?V25VZG5ZNFFXMTdVWkt2SXV6ZFJ6MDUzMmtKd3BndEVDRzBBbk10ME1LQmlr?=
 =?utf-8?B?TlFTWHVPWTkxNUo1b29WdFl3TDNrRjJBekpQeXRITURLazQ4WjVodjc4c3B2?=
 =?utf-8?B?VlNuUjhNbnFLbGVpN3o2V3RkTThsZmZOU3lkMi9jcTZpbkN1eXp2d0RMSFY4?=
 =?utf-8?B?a3lSMHJqSHRaNkZJVTdyUURnaVJWamxST0lmV2N5V21IVmZnMEltRzdPOWFu?=
 =?utf-8?B?V05QZDhpRU9oVEk4a1NqckhYMzhMMDQ1UmlDak5HQVd0b1RvblBlY1RZZkE2?=
 =?utf-8?B?aG5SMitnOGV2ZnNxYUlvdERZazl3aDM3MDc2VWtLMHkvSmFzcHJZdm5OSk9I?=
 =?utf-8?B?TXpvaW5YYWs1azVsK0FhUGZxYkJJelJHQlpRKzU3RkxXZGIyMEdGL1AvVVpO?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b177f92-ccc0-4b9d-fcf8-08dcb273dca0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 21:49:47.3756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkF157el2eBr3qPWy9gmXuthbr92WgJ8Gn9nUp3cxvDRELGqxMDZwyWPHjxuQAsddmqVNBZEySpo2ZlyJ5BDmaZ0bHl/QtlixFRavB8wxjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5870
X-OriginatorOrg: intel.com

Hi Babu,

On 7/17/24 10:19 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 7/12/24 17:03, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 7/3/24 2:48 PM, Babu Moger wrote:
>>> # Linux Implementation
>>>
>>> Linux resctrl subsystem provides the interface to count maximum of two
>>> memory bandwidth events per group, from a combination of available total
>>> and local events. Keeping the current interface, users can enable a maximum
>>> of 2 ABMC counters per group. User will also have the option to enable only
>>> one counter to the group. If the system runs out of assignable ABMC
>>> counters, kernel will display an error. Users need to disable an already
>>> enabled counter to make space for new assignments.
>>
>> The implementation appears to be converging on an interface that can
>> be generic enough to be used by other features discussed along the way.
>> "Linux implementation" summary can thus add:
>>
>>      Create a generic interface aimed to support user space assignment
>>      of scarce counters used for monitoring. First usage of interface
>>      is by ABMC with option to expand usage to "soft-RMID" and MPAM
>>      counters in future.
> 
> Sure.
> 
>>
>>
>>> # Examples
>>>
>>> a. Check if ABMC support is available
>>>      #mount -t resctrl resctrl /sys/fs/resctrl/
>>>
>>>      #cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>>>      [abmc]
>>>      legacy
>>>
>>>      Linux kernel detected ABMC feature and it is enabled.
>>
>> How about renaming "abmc" to "mbm_cntrs"? This will match the num_mbm_cntrs
>> info file and be the final step to make this generic so that another
>> architecture
>> can more easily support assignining hardware counters without needing to call
>> the feature AMD's "abmc".
> 
> I think we aleady settled this with "mbm_cntr_assignable".
> 
> For soft-RMID" it will be mbm_sw_assignable.

Maybe getting a bit long but how about "mbm_cntr_sw_assignable" to match
with the term "mbm_cntr" in accompanying "num_mbm_cntrs"?

>> Expanding on this it may be possible to add a new "sw_mbm_cntrs" feature that
>> will be the "soft-RMID" feature while also reflecting the "mbm_cntrs" name
>> so that when user space enables that feature its properties can be found in
>> "num_mbm_cntrs".
>>
>> The "abmc" kernel parameter remains but that does seem separate from this
>> resctrl fs feature since it is explicitly tied to X86_FEATURE_ABMC surely
>> making it architecture specific.
>>
>>>
>>> b. Check how many ABMC counters are available.
>>>
>>>      #cat /sys/fs/resctrl/info/L3_MON/num_cntrs
>>>      32
>>
>> This is now num_mbm_cntrs
> 
> Sure.
> 
>>
>>>
>>> c. Create few resctrl groups.
>>>
>>>      # mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
>>>      # mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
>>>      # mkdir
>>> /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
>>>
>>>
>>> d. This series adds a new interface file
>>> /sys/fs/resctrl/info/L3_MON/mbm_control
>>>      to list and modify the group's monitoring states. File provides
>>> single place
>>>      to list monitoring states of all the resctrl groups. It makes it
>>> easier for
>>>      user space to learn about the counters are used without needing to
>>> traverse
>>>      all the groups thus reducing the number of filesystem calls.
>>>
>>>      The list follows the following format:
>>>
>>>      "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>>>
>>>      Format for specific type of groups:
>>>
>>>      * Default CTRL_MON group:
>>>       "//<domain_id>=<flags>"
>>>
>>>          * Non-default CTRL_MON group:
>>>                  "<CTRL_MON group>//<domain_id>=<flags>"
>>>
>>>          * Child MON group of default CTRL_MON group:
>>>                  "/<MON group>/<domain_id>=<flags>"
>>>
>>>          * Child MON group of non-default CTRL_MON group:
>>>                  "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>>>
>>>          Flags can be one of the following:
>>>
>>>           t  MBM total event is enabled.
>>>           l  MBM local event is enabled.
>>>           tl Both total and local MBM events are enabled.
>>>           _  None of the MBM events are enabled
>>
>> The language needs to be changed here (and in the many copied places) to
>> be specific about what setting the flag accomplishes. For example, in
>> "legacy" mode user space can be expected to find all events enabled, no?
>> Needing a new feature to set a flag to accomplish something that is
>> possible in legacy mode can thus cause confusion.
> 
> Yes. It is possible to do it. But I feel unnessassary.
> 
>>
>> If I understand the implementation reading "mbm_control" will fail
>> if system is ABMC capable but it is disabled. Why can "mbm_control" not
>> always be displayed to user space? For example, what if "mbm_control" is
>> always available to user space and it can provide specific information to
>> user space. For example:
>>      t  MBM total event is enabled but may not always be counted.
>>      T  MBM total event is enabled and being counted.
>>
>> On AMD systems resource groups will have "t" associated with monitor
>> groups when ABMC disabled, "T" when ABMC enabled and a counter assigned.
>> On Intel systems monitor groups will always have "T".
> 
> I think more flags will add more confusion.
> 
>>
>> For "soft-RMID" the flag could possible continue to be "T"?
>>
>> I am trying to find ways to communicate to user space consistently
>> and clearly and any insights will be appreciated. We really do not want
>> to add this interface and then find that it just causes confusion.
>>
>> It is not quite obvious to me when the new files should be visible and
>> what they should present to the user. "mbm_mode" is now always visible.
>> Should "num_mbm_cntrs" not also always be visible? Right now "num_mbm_cntrs"
>> appears to be only associated to ABMC, should it not also, for example,
>> be the file that "soft-RMID" may use to share how many counters are
>> available? Its contents will thus be dynamic based on which "MBM mode" is
>> active, begging the question, what should it contain when "legacy" mode is
>> enabled, should "num_mbm_cntrs" perhaps show "0" to user space when
>> "legacy" mode is active?
> 
> Its good we have this discussion.
> 
> How about we go with simple way for now. The mbm_mode will only available
> when ABMC or Soft_RMID(MPAM feature) is supported. Same way for the
> num_mbm_cntrs.

If ABMC or Soft_RMID is supported then user can still enable "legacy" instead.
What will num_mbm_cntrs and mbm_control display when user enables
"legacy"?

Reinette

