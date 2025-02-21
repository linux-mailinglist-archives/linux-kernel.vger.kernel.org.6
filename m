Return-Path: <linux-kernel+bounces-526459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73E8A3FEEB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E52A3AAF40
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C4F2505BD;
	Fri, 21 Feb 2025 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7mubpkP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C231E9B09;
	Fri, 21 Feb 2025 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162971; cv=fail; b=kRX5XBtmo1PWpDZbotaokk5XHsV4woTOiJT6Oqi/+T5FG6IDXQcy5r7kSyv5GieO2gSohuy6LfOseRy6/+aI+SLBtFa8dkEitJym8ns/S55PHIcvtP/iW4GS9E8k0XzxPXEksjkR3jpaLM8zO6iflTn1sFyNWZ6f3S3NsXJ0nK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162971; c=relaxed/simple;
	bh=cO0aHXh+Cs98w8iEQMJO4dPTAtv9980yfeMUPHqnv6w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RJAc/uez4HHCdHSox4P2RBa10wQXFHRl2niHdgtTTJyU3ZoaEjBt3iol+nueQzpRNmJNl5PvR7AJMMkqQKEiq4VpZbndgG14aSqFc18X9gO1bNcYuVsTYri4m3sqqtdzLL5P627FVPlU82BQ4kQkTfoikEhOAz5IhZs4YNkCLZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7mubpkP; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740162969; x=1771698969;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cO0aHXh+Cs98w8iEQMJO4dPTAtv9980yfeMUPHqnv6w=;
  b=j7mubpkPlmOwGbfMlQw1jm9zaTsZ520lFQZ81cdX4QRf/ixmbztMc+lQ
   9ithwNqyYMJ7ulk00t19u7Qy9vnqHdFR3BvYNX2NjM6+ICo9uMK1IrgDE
   DisLzYNP0TQsO0Ghhp31RkJOZgSF3hJhzd1zspHy7Fec7gP10EJ3S8ZBO
   qNJrLnVYwi2TxhAnZ6oC98viIN89lutCricTW8xF2ScJSbdKGppyIm3Ce
   aa6EDKKU1Uirygt8PHUCH0mSj5KtqK9ADIPyePgP4UiNSe9rJgQiB30SP
   r6d0H0IAHvrxk5OzKMiGjMdk9NTLO2CpVJOtwReiKMdZgu8VzqBsdUVcL
   Q==;
X-CSE-ConnectionGUID: yiVy07C8SjW1WBZwOXbx9Q==
X-CSE-MsgGUID: IgJ9NiQBSwCkKpulUmOqlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="63463438"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="63463438"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 10:36:08 -0800
X-CSE-ConnectionGUID: Lc2TZC+IQOqDQ5/K9pfHlw==
X-CSE-MsgGUID: ApHZT0Z+SUyr1n3Oi2GyQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152641905"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 10:36:08 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 21 Feb 2025 10:36:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 21 Feb 2025 10:36:07 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 10:36:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvFbIoyl2+NDqDDhIE+ag/KU8xzTsxh62VuVW14qTqqK7i2rlhw7/kAG/zHGd5N4XOs7gEizUAX5Rg1i+M2o3KKualh3LUyDePqAa8z37GMi5p8jHMsToOnVIgPj5cA1Nxq1ORSkHOMoIKaSSyjOFLI8XBlAGHpv07Ej7WSuaGbm/blgNrPf6nqM1wuZDvK8usaPQdD3jng+1np8rdnWI76Ko+JKYGMA6gH0pv8Nlc2Yl0hVcpIUqoHP6VScMeRjeZuMskbzHtWryucBThZ5fXqEr46UIM3eQk8kMRb5jPMEeHpkw4IdVttP0wMSh7UDDyUly2yCabXfreovfxrr6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVaagt4TFc3cjWA7rAvSzRBn41jGZD3ISYvmSulkDsM=;
 b=nbnBvnFCueUWRbcsZKGfPgfj0j7Dcf6fM+r3W8BcKFb0lxsSxJ///JgJnopQ4wIz9/VUTWk/2/S6X6T9sdUTKteTuFqyHWBDr8X3ZMb1lewEmVQheki3ndOpRTh6umIFSkG9T5yWTEIAgLnwqT5xgwlXMvBN5ia/srlAq43Gq1Y+GMp66Om7sqPE5bTcIx7ECLEaOfzW+sT4Trv3e2Q0F53gBh1DTPQSkJj+Ys2Ztl7XBlryeq1qKiTM1oUVddyIKdag36yd37wgWE43GNjptkiOFA0p3/kWLcu1l0R/Mas4XOOkrW2KZjS8ELGqBwcvAguwIDTg6509Xyt+TH5Duw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7693.namprd11.prod.outlook.com (2603:10b6:208:401::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 18:36:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 18:36:01 +0000
Message-ID: <dd52a51a-e0b1-4c5d-89d2-8732d4e9e2ff@intel.com>
Date: Fri, 21 Feb 2025 10:35:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 11/23] x86/resctrl: Introduce mbm_cntr_cfg to track
 assignable counters at domain
To: James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	<corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <tony.luck@intel.com>,
	<peternewman@google.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<akpm@linux-foundation.org>, <thuth@redhat.com>, <rostedt@goodmis.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <jpoimboe@kernel.org>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <xin3.li@intel.com>,
	<andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <tan.shaopeng@fujitsu.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <30652061d4a21eb5952a1323b76ca70927412a30.1737577229.git.babu.moger@amd.com>
 <aef8e061-8754-4bf9-86eb-18c0bacc6476@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aef8e061-8754-4bf9-86eb-18c0bacc6476@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0366.namprd04.prod.outlook.com
 (2603:10b6:303:81::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 192f9918-5ad2-42a6-e77c-08dd52a6971e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVpVZXJ5cTkza0NnRStScmpOb2ErWldxM1FtY0Z1WFo0WGh1eTI0S2pScmNs?=
 =?utf-8?B?TXpnY1NtNGt3aDFsVGlhNyt1Mnlyc29OUjhSaytVNUJ5bFpxSkNKMjlmcUNx?=
 =?utf-8?B?R2FGblB1Nm0vM29TeEtxR2ZjUHpxVGJpMVVtcXFDUkFZckxaZklsdUxldUJ6?=
 =?utf-8?B?V0ZUUXVDb014ZERKVVdVd0dIUHo0Z21DSEIzQnZtNEdEZ2R1MHJJZDhsbFZB?=
 =?utf-8?B?bzNWWFF4SnVObHZGeFgrbDdHU0ZEd2ptYVdnTncxZWliNE9mb1VaMzJUNmZl?=
 =?utf-8?B?R0pOakZ0c0Y3QVJYNGdJenRjR2VWeC9HSkVXNFVjbzJTVEdXVVNoVlRUdzND?=
 =?utf-8?B?QndIQlZQN0Z5ZFVSQTVjdmlidVBINXJ5aGJwcVBjamgzalA5Z3ltVkV6dWFr?=
 =?utf-8?B?MEg0eFBUbUxLNUNSU3NnbHNOTzVnc1BUU090UjBiakZUSUFlNHhCSWlNa3ZP?=
 =?utf-8?B?UkMzWHluWm45SnBYQmlDNWpvdVQ4RHRQc3BZeVp6QzRmbGRaY09yYkloaUhm?=
 =?utf-8?B?UGhvWmhYZE9oSEZlUGV4MUljZmt6ZUw4SUVSQmtBNUZUcTFPVlZtWkQxczM2?=
 =?utf-8?B?N1pvMVFpV2U2dE9IdjI3NUtGOHFzVnFwQ2J6V2xTVUJvdmdSV3BWb3pXSU04?=
 =?utf-8?B?TktOR0xwYTlJajBjQSs5cXA4MlFXb0I3bHhmOStydTBiT0tVUE42N00rcHB4?=
 =?utf-8?B?YjVibXFJV2VUMTlKVjRlMU1zUnVaV29WeWMzTlIzdDkydG1xVzJGMTQ1T3hu?=
 =?utf-8?B?MlR5bE4xRm1GckY0RUgycjJlS21WcTlSRXNGRXBJdTdoQWthRWV0cHFnTFlr?=
 =?utf-8?B?WUF0UmZDbnFmSzIyS1N6UFVKd3lDUmFWdU1keFEvZ0RsZkx0dmhhbnY0T0Uy?=
 =?utf-8?B?aVc4WnMwL29JaGNMd3NxWUdwRG9WYjNldFRrYWxlRUxyeUM2d043dHVPR0tX?=
 =?utf-8?B?M1FuOVI1Z3p3ZE1zMlZFVkMveHQvTDdJR2t6cmRzOFdSbzVpenlkK1Q4em1V?=
 =?utf-8?B?dzF2K0VGQVJRR214N2FhSFZ2Y1NaRWNsTXlsdDRuZHVDa0Q2QjZqSHhlSlJV?=
 =?utf-8?B?d3IybHgvUmFzOE9YU21GVU9wOENCLzdlQ3N5VEx5UHBWZEdYZTYvZWNmUXBK?=
 =?utf-8?B?cWRHNy9lMCs5dHI2Vm5XQVY1UmZyOUZmYTVXbm5nSW1hQ1VORStxb2FaLzF0?=
 =?utf-8?B?aXc0TVRCNlBWZGpDYXFjcUc0Y05MTGpRdVcvZWdnK3ZHeGswa0swQ3I3N25z?=
 =?utf-8?B?WEhlRm5menQzeEw5Mlp4V0hzWjB2aVFYSWxqZmRnR2pCWmZIajdDTzBoYStX?=
 =?utf-8?B?UE1qendtc25xMnBYclNoQVZ2dVdqb2VsTUNJaTl5TXZQYTdtL0dWVDBrNnRI?=
 =?utf-8?B?cDU3WGtxRi94OHZYUEozQTZjOWNTR1dWZDcrSW9STUxUZUVZK21yVHdLN3pq?=
 =?utf-8?B?Y2xXaWNYS1ZmSTNVaVNGZHZabTNUaFV4bmJqL1pONnJyOCtiRjc3UDExbXhL?=
 =?utf-8?B?UXE4OWxKRXl0eG13eG1TUGtHVXNUbWlvV251YWVNZDA3d2NWTFVYRng2b2ZO?=
 =?utf-8?B?K2w5cUxYNjMzTE5tWUZCWDBCZEZTWmtXU1VGbktYUmg2T01VN3Qzb2JjQ1cw?=
 =?utf-8?B?QmprMUQwblNtaGhHUFVhU2JGNzduYnlQOXhiM0J2QVhJK3JwYkkzVUliWnMx?=
 =?utf-8?B?SHMrek5LUEpyaGNVWXNVcnFlZTNJNXQxTzZZS0ZRVEdsSXNXVU1JcXV1SjVh?=
 =?utf-8?B?bEtUZDJIcGJYWjZwV1l6b2E4Um95bWJBVStSczVxWUd0akFIbERYVDBqT3hs?=
 =?utf-8?B?ay92akRkZ0x0WkIzZnZnN1RqYnZTdGczRUVJSFJhZ0JDczlaK0M4V1JRN2Fl?=
 =?utf-8?Q?MADF+kt1p/5jh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amJQQkVaZjIrcFZWQld2Q2ppWnZDLzRUT2crMnJ5M0JnNDdSU3B2bTg4cDZa?=
 =?utf-8?B?eTNsKzk3a0JBYU1BWmZQK1FTKzdudFJDSU9GVkdYQXFnQ0JJdlRXYnlQQkZr?=
 =?utf-8?B?OVBYU0VaRm1pemNxbHEwUHFnN2NhWGlhOWdEc0E2S1U5Nm9hUkh5VHVoaTZp?=
 =?utf-8?B?NDE4ZkRoYnI3aGYrOUtNTGlLMkNBWFdHN1FpUHVLQmhQR3FxaU43RmRkZ3dQ?=
 =?utf-8?B?RXJRbUdzc09PaVJUSE9xTU5OcjMyZldLMExERXhycUp6M0hrM0QrNG92dVp0?=
 =?utf-8?B?VDIySzNXb1YrTDdYcDZFZWgzbVB4OXBvRU5jaWJDSWhPc2hKZytzdC9pMzQv?=
 =?utf-8?B?Skg2WDZDZ2IxbkVwRnlIb1dIWUZiL3NCS2JhOHIvVzhzcG5XcHMvekc0U1py?=
 =?utf-8?B?ZHpFV09yd0JydHhQcGI3eEUzWDBQcFpEeERDWE9LamdjSy9tSXpmYzI5MUVo?=
 =?utf-8?B?Z0NsVXRCMzZTNFpmUU9HcWdZd1EwbHMxZU9zMXRGZUhJTE9HWml3VHFRVTlK?=
 =?utf-8?B?R0FHMUNkemluai9HbUVzNkZxWUVWWElxSE51M043OXlOd0w1OGlTUzFFQWUy?=
 =?utf-8?B?czErQzJzdE9UMTlHMXNsWkRkcmVra2thQVN0YmlLRCtVVVVsY1hyUThxWFZn?=
 =?utf-8?B?QUlyR2ZGSmcvN1pZbXY4cW5uS2F0ZGpITnE0N2Y2VHliY1lMZjAvM1RtZ3p3?=
 =?utf-8?B?YThaczc2cldzNFluTHZ4RElOb3pyVGpKWTAzWWI2YWlwcnVnSGxZNWV5UzZI?=
 =?utf-8?B?ZWZkZzhpcjdIZXNqNWJGOWNxK0lkamMwbURnTXlUbTVHRnpHRlhIbTR2MkdJ?=
 =?utf-8?B?T1hMNnkrRncwWnEyL01acEJmVzRZejZDd2xLemZQYUpaR3hRVDAwMmhqWCtW?=
 =?utf-8?B?ZTQwRmFOeUJJUTdkczdqUjV2N3ZmdWQxWDlKWEt1em5Hdk4vZzFHK2tkNnYr?=
 =?utf-8?B?SUxlck9UaTZxSFRsRUVIQUsreHVYdnVGYlhZV1NBeWsvZytzVndQbzJJK05C?=
 =?utf-8?B?VjZEVENrL2x2R2ZxL2k5NUV2a0lmTlB6aWhQWjdmNTdZUS9HWTMrQ0wxd1d3?=
 =?utf-8?B?Ynlybm5VbmpZZHY4K29WSGpGUkdXeWJTaDJiZVUvNE1yTkRSQXBwT3h4OEM2?=
 =?utf-8?B?VEVPNkU5emhuaDdGRTRGQmFHUDhGUXZlVnRER2JxaTZCdmN5dFZDbDNrNEpq?=
 =?utf-8?B?aXNHVUkrRngwcTBSUHhHbFFIL3hvNENDaWFxc3kzSTB2dXJKSkw4V085R3VN?=
 =?utf-8?B?Q1dpZHJTRlBPQmEyTm9adVJnbG9SRkVobXprWHpDT3FUd1FMdUdkOTNhSGxw?=
 =?utf-8?B?NUs0bDVDNDNSWEc5RmtCaUFYQ3QzaVNKSldBaXVjd0hZQVRZVERYSGVWZHV3?=
 =?utf-8?B?Y25ySytpOXZwcjk1Rmd5VmhGODJOZ2QxUzk5QXFudGFySTRPMGduOWFhNDlD?=
 =?utf-8?B?akZoajNlUUR5WEZjamVWSjIyU2x0bHV0YmwzZXk2azJiRzVVQVRuTkFSNWJS?=
 =?utf-8?B?Slk0bStpM0IvY1NnOHg1a0NDZHQxemJzWUtMY2cxZlJBbkNxTHh0UjZPYWtn?=
 =?utf-8?B?YW5uM2t2RVhSODJnaW4vbk13bGRXeTFhSmFLRlZjMVpCTldUY3R3aVVMb204?=
 =?utf-8?B?MVJqL0I0R2dVcG9oQ0x6dHg1ZGEyVk5UbzB6UXI0ZGtERVVSeTZsNUxrTmV5?=
 =?utf-8?B?OFZxNTFYYXpDLzRLQmlScmc5bUhRT0xTUDkxZjZsd1BPU2pyOGhsTTNvT0tL?=
 =?utf-8?B?Q0N2L2dxMzJDcm0rTEtqWWk4bUF3WFhKdVFwNktReVFXTGp4dFZTTCtpT0RK?=
 =?utf-8?B?OUxkbEJpaHJ4bzRYMUV1Und6bGZQeklCbGtibUtCQzlSWGtDRjlqYzVjN0lH?=
 =?utf-8?B?MGhsOVE0a2dWc0IvcC9ZRlpBN3cvUEQrVC8yTG5QOEcvcXFUaDdHaXZWS3NV?=
 =?utf-8?B?aGk4b05jQldkOW9PV2NqRXE2Rml0TWt1cUxQMnNaUTRVcGdDQTVFdnErMmR5?=
 =?utf-8?B?bDh2VlVCV1grVllsSGxiaEJSdFB0NTU0R1JsMVdFdCt2WW4rbHJ6K3JBcTRj?=
 =?utf-8?B?eXNzWEg2UFlKY1R4MGFOZ01JdnNIa2ptakl5dXRwRG5mN3FlSk5mMGZlUXE4?=
 =?utf-8?B?R2JEaFYwVngyTlFXakRPK2EzVm5NanhvS1UrTnNEUlM4R0ZLWjA0UlY0OHlm?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 192f9918-5ad2-42a6-e77c-08dd52a6971e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 18:36:01.1425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JWRhwCrDtisph6XagcSR3KLcJ9tPgY/GNV5gwsOediCttH+VLPEeEBut/Fhvek0jcIhvYaIcJO7Rldlf1NjV56D9QfPDzot5/cSthQrtRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7693
X-OriginatorOrg: intel.com

Hi James,

On 2/21/25 10:07 AM, James Morse wrote:
> Hi Babu,
> 
> On 22/01/2025 20:20, Babu Moger wrote:
>> In mbm_cntr_assign mode hardware counters are assigned/unassigned to an
>> MBM event of a monitor group. Hardware counters are assigned/unassigned
>> at monitoring domain level.
>>
>> Manage a monitoring domain's hardware counters using a per monitoring
>> domain array of struct mbm_cntr_cfg that is indexed by the hardware
>> counter	ID. A hardware counter's configuration contains the MBM event
>> ID and points to the monitoring group that it is assigned to, with a
>> NULL pointer meaning that the hardware counter is available for assignment.
>>
>> There is no direct way to determine which hardware counters are	assigned
>> to a particular monitoring group. Check every entry of every hardware
>> counter	configuration array in every monitoring domain to query which
>> MBM events of a monitoring group is tracked by hardware. Such queries
>> are acceptable because of a very small number of assignable counters.
> 
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index 511cfce8fc21..9a54e307d340 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -94,6 +94,18 @@ struct rdt_ctrl_domain {
>>  	u32				*mbps_val;
>>  };
>>  
>> +/**
>> + * struct mbm_cntr_cfg - assignable counter configuration
>> + * @evtid:		 MBM event to which the counter is assigned. Only valid
>> + *			 if @rdtgroup is not NULL.
>> + * @rdtgroup:		 resctrl group assigned to the counter. NULL if the
>> + *			 counter is free.
>> + */
>> +struct mbm_cntr_cfg {
>> +	enum resctrl_event_id	evtid;
>> +	struct rdtgroup		*rdtgrp;
>> +};
> 
> struct rdtgroup here suggests this shouldn't be something the arch code is touching.
> 
> If its not needed by any arch specific code, (I couldn't find a resctrl_arch helper that
> takes this) - could it be moved to resctrl's internal.h.
> 
> (If this does need to be visible to the arch code, one option would be to replace rdtgroup
> with the closid/rmid, and a valid flag so that memset() continues to reset these entries)
> 

Thank you for catching this!

Reinette


