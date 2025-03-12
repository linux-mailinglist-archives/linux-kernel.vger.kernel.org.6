Return-Path: <linux-kernel+bounces-558153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 672A4A5E259
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31983A5209
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7E824FC1F;
	Wed, 12 Mar 2025 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQ4LZuse"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BB123A9B4;
	Wed, 12 Mar 2025 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741799677; cv=fail; b=HFbgMyrW3bqD7Vlk6tnxlROcdvd54K9qdH/nObO+TZDMg2l3sGyDHjLzJT43bqVl6ukVCh7gvwvUh3Wu9J7l7rE4Askf552IfDePC8xNDrHVkcLNKv2cFQDMR7VcdNW2Mr6lFte1GuV6E4x1UbakL8AmzxlutuViZ06dmVzwZpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741799677; c=relaxed/simple;
	bh=cBr5O9NO8MH3UVmS2Wm3PfSG6lKOzwppQ/gWMhUM9LI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dJDvirc9xNngZFrrpwnJNeIqxdeqo7G7uJOh8n2lkE57uE2+nMnJnSBUzwfYWuMb54yQuZxjqc3q0YAkG2EROu6Azqh+EDzxIGkBTsAljSknskTGqWA4LOT/A4/0wFG1ObB4etybUS1WnJm9nXOQ8I5Y0rtL17KEN00fJEEaDRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQ4LZuse; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741799674; x=1773335674;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cBr5O9NO8MH3UVmS2Wm3PfSG6lKOzwppQ/gWMhUM9LI=;
  b=QQ4LZuse1aogr7Y+g6+F+Og8V0W+71PQOgefnNNb8nOX7KtSpW1+SvcM
   pKYxO/nwSYPgkF+0PEw0kEjIVFAc4oeRI0qfDRD3tNw20QlAgFpu9Arzo
   B5g3R3tdGiP3eZ2cKo950n3HrXpwrkSBySFnozZmXgnmFylXx/a6YY79C
   jflUQP93yXKtdE++vt/QejIvvz6zl5SpxM/Ce7w5kl2aCrxpOWxLucK/O
   Xt/RaLe/fc6IXx6BIdd70aIlHJ9ny1VrC2b7gl94xaCbX/g732AamTpTH
   V3W5GouLofMXdf/+yYebNgm/cpfTePSYlchuJTtAwr3WsmYgJoT6E1xCA
   g==;
X-CSE-ConnectionGUID: M8dgC7k+TVyuKQhIhpwHjw==
X-CSE-MsgGUID: KBcFU1j6R3yT7818fZEYhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="68250990"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="68250990"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 10:14:27 -0700
X-CSE-ConnectionGUID: Y12gILPoTYik0yV2sFLxvQ==
X-CSE-MsgGUID: ZAY1t/zuRQWCiXhbRp3j4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="143895421"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2025 10:14:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Mar 2025 10:14:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 10:14:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 10:14:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5sRUEHCrhD5ZYNH9c8QGNP5qTC+n+DiNI0remvUHlfJBRvUkHeZg5yS7p7eM/SpT1+oQOs3asQyiWW/DCOR+1XNJtKdUdoEgDQz6wflCT8DczNn7Gzg8E73zELNIkNVFN6WRikJVCuuXl0FPG+rlmMG2jXOfdcAfsj/79YR3GXte73OSQo+crqRh14eJ3EiFZAft7uqQ2EXyBaxleimE5cMIqJPTYuiHdd2fwzu2Fu2lDxlnH29fIeefZw1hpt6h3c8qEMNhblaVoj1YimYpmHnKFKgushf9MSE4chbGZDIgj5QDZdk4MDDWAQBtq1QXKOCX8KUwRZHXU4j26vccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEO8BQhrOYf2f2S8iwn3XOco5ZRynI4BD1+czWqe+Hc=;
 b=KtQqPD1mqWvPWbal3F6MNXoIy5zI5Togw1xCdZEvZWyN+XgJ5LLms5hwu31W9wESeLkzdL5i1i+exCFD1eN7iCYYSFM4oGZQElU2iagUZwPeegBb3fAU+N2FAlo5HbnApnlyie9WrNCgdrtSqgcW5X8lzKEKQpxRSCzaSMnSWRj1tgadrA84v0rJ5znBwWx4Haj4i0ftqpERa82Pvszk6ZuVGeIYYo6CATn3LP0SxEOI0tRjJPTSk4xrdnTPwpi5p6l7SLGbQppLOLGFGQYZKrEPlN2jISlIN6TqaOoDJVJZt6jU4vBo2f3/QzjzbGGg3LsKFaYkSyfmu2DpjBqSDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7854.namprd11.prod.outlook.com (2603:10b6:208:3f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 17:14:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 17:14:08 +0000
Message-ID: <1db8ad73-5194-4821-844a-8fd7cac72ad4@intel.com>
Date: Wed, 12 Mar 2025 10:14:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: <babu.moger@amd.com>, "Moger, Babu" <bmoger@amd.com>, "Luck, Tony"
	<tony.luck@intel.com>
CC: Peter Newman <peternewman@google.com>, Dave Martin <Dave.Martin@arm.com>,
	<corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<xin3.li@intel.com>, <andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
References: <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <CALPaoCg97cLVVAcacnarp+880xjsedEWGJPXhYpy4P7=ky4MZw@mail.gmail.com>
 <a9078e7d-9ce6-4096-a2da-b2c6aae1e3ed@amd.com>
 <CALPaoCgN+oGgdp40TOJ9NgF9WYPdN0cG8A8BtOOMXOP6iMVfzw@mail.gmail.com>
 <f1744c45-9edf-4012-89bc-47393b4c53fc@amd.com>
 <CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com>
 <d1ca9220-1ab7-4a39-819a-03a6069b7ac4@amd.com>
 <CALPaoChLL8p49eANYgQ0dJiFs7G=223fGae+LJyx3DwEhNeR8A@mail.gmail.com>
 <a4ab53b5-03be-4299-8853-e86270d46f2e@amd.com>
 <c1c0a99a-a467-4ae6-80ee-04b6a9cdb6e5@amd.com>
 <Z890Q2GoP6GecwW4@agluck-desk3>
 <04e47d0e-6447-451e-98e4-7ea65187d370@amd.com>
 <6508cf67-3263-432e-892c-9b502b3c6cd4@intel.com>
 <f8a20ed8-6e30-4cff-a96b-8df89a605081@amd.com>
 <d07a70f5-b1ca-4766-a1d9-53988dd9164f@intel.com>
 <14c14b11-5b45-4810-8e46-019c8a67fc90@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <14c14b11-5b45-4810-8e46-019c8a67fc90@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0155.namprd04.prod.outlook.com
 (2603:10b6:303:85::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: 559ab600-f030-40f2-ffe2-08dd61894cc6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUFVL1RxeUNndExuZ3hmS0V2TVpkaGZxYTZKWTF5aGdSRG9HSmhGZCtwUWFp?=
 =?utf-8?B?S3pKaU9Ddll3dkwxTGZvVy9CZndOL1RhL1ZncUREY1h5VURxL1ZqSlp1Y0tU?=
 =?utf-8?B?SEw3SnVHZThtME5VY3JWYS9GT1dtdlRHVTVUV2hoSU1WdU1ESldXUDMyY3Iy?=
 =?utf-8?B?M3lQQ1NueFNDQyt0QzhBS3gzQU1qVFdUd01BelhHY21hWHRyNzhtbjkwQ0pm?=
 =?utf-8?B?WTgvQ3NVZFZmbXdPcFRoc2JOaHk0NHRGWEVFOHhHQ0xXb2htT2EvK0VJMWJI?=
 =?utf-8?B?cC91MTNQQmpkaFQzRm9FeXJ6NWc4OXVlQnVyQ25zbytQNjlJUVZJTmN3M0hD?=
 =?utf-8?B?OXl4MW16UTRNMldwTjRRN2RNVU1rYkE1V2V4aHA4dVJoZSt3QUJtdk0vVUdn?=
 =?utf-8?B?MzlmaDNwL051RUhLdmJudjBRNVVYaG5qVDN1MDhZVXcyNkNrbTlKZDFTK1M2?=
 =?utf-8?B?Q3dTa3lpQnA0NURhc2FaLy9FellrUFRESTVIdUo0cEVtbGVmRHJQQ0xzNGJT?=
 =?utf-8?B?WkRIUG43dHV6RVh4ekY4OUJnaVo1QXNqWjRvVW5WSk03bU1weUQ3Umdodmd5?=
 =?utf-8?B?L1p3MXJjZWJmdmhGTW8yRmV3eTZGaHo2c1dBVGRmSm03WnJEZlVkcjJYdEox?=
 =?utf-8?B?ZzR2eFh1WHFXdmpHK3NEd25RRnQvRzViZU1vWlo0NTFvSEFwMHBvNXVZeTNC?=
 =?utf-8?B?VVcrMUYyM2FTMm9ia0hzTmE2cHd5bnFlWFV5QlQzQlVVTUNsVHR3V0g1amZH?=
 =?utf-8?B?MDFhOXVlTHdEb3lwa29DREcvaE5GNFZxWnBHOVVtNXBZQXhCSkVaYVM5dkJ4?=
 =?utf-8?B?OTVqRXQxbFpXQklGUjJxUHo4N2pLWHVsVExBaGNhWHpWSU1ManhEci9NWm1S?=
 =?utf-8?B?S1pXbloyRUw0TzdORHRUNkVmOE4zTHRFaWxKV3RZREkrY1Z2bmtQcmhYbExK?=
 =?utf-8?B?eWdtK1RkNmN2d2FZcG94U0s5OS9hSzhaVXFwWnRsVHNMZDlOUWZvQ3JEK0xS?=
 =?utf-8?B?alNXODQwUEZsOE9vY1dac0JPUTR6Mjh1YUNwQms5aHRibHA4NFlWZTZON3pY?=
 =?utf-8?B?WitSWmxSS1laUzhoc05FanhSeFJCdHZPakM3b3JUMmxhU244Q1VHcHR2cTVS?=
 =?utf-8?B?elJwQnJXb3N1dExMMlFOR3Y0ZmlST1kxd2hqWWtYK1FqSXBqN21UQThVVWUr?=
 =?utf-8?B?WE5vREE2R3BoYU95b3NucVVUNGFSNnFzN0V2bkF0alRzVHZub3ZxRWZDM1BJ?=
 =?utf-8?B?bDZ3YVg1VjRGQTYrcnA5M2ViK1F3UFJVTkxSb3FlS1hGR0V4ekhPY3N0YWFE?=
 =?utf-8?B?cEtYSkZNYVhWcGNRRlFnRXJTR3ZwQTdHR3V5R0lMd0tzcEJ6R3ZsZXhrcnZY?=
 =?utf-8?B?K1FQeENzVXltQ0ltWjhRZWd0bmcvSEttVU83eERlZmRpM0FIQTFoV1RqU3lB?=
 =?utf-8?B?OFFaOUNxa3RUcXB5WGFPejJRQUt3VTBrekRpZ055ZjIzaXRaQ2FUeTA5b0FU?=
 =?utf-8?B?WDAvSlo1WkRrT2U5elB5aUsydnJqTkFka0N6enZYVFZaTkxYcW1FYjduYmZB?=
 =?utf-8?B?SFRzdU9LcmxFeHhvOFFYZU9mQXFRZjFFMnZoRzlhbEgvczd1blVQbkFFbmdn?=
 =?utf-8?B?bnovZnZOejBtVExYTklaR3cxNHJhSkl5SmpIc2N0b2dGV0xWQmtQUWIyNDQ3?=
 =?utf-8?B?Q3pwM3pGRjNhZTZOaWRFSGNtU2toS0YrK0VzazgyNnpzVmh0end0TmJjai9Q?=
 =?utf-8?B?azlyN3NnUHlGZjlMcElDenVma3NxWmgwWit1d0tZQVJ3T1NFWis4TkZqaG1T?=
 =?utf-8?B?TUpVeTI0VmdTZkh4Y0pLMmtDQUhFeWxEejFrc3did0ZNL1k4aVJSU0pHQUl2?=
 =?utf-8?B?SUZGRG9HMGtTNy8yL0I4VU5JZzFJdG1aNXdTSkdKZWtscHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWRvVHlqcEdZdG9OK29aeWVCMEFCTTJEOWx4bkE3RHI4d3lIbDdGQWluVmph?=
 =?utf-8?B?Z2U4VDQ3R3RjWUZMb25LMWpDL3hMNHVsNHVITDFWQ3kydDhRWTBxQkV0NWxl?=
 =?utf-8?B?QXA4V3pYdHljMVIxbDNtcWpYU2JwbzBYWWpLMEF5V0dqbHcxVlBkVVlhcnFq?=
 =?utf-8?B?NTVKRXhqRDB0clJibFB6V1FsTUpaVTh3UXV1bnN1QVl5TVBKakgyeHJPUHFw?=
 =?utf-8?B?NXlqUGVhcWdsdSs0Y3QwR2ltYlNyZkt2SHBsekZndzF3ZlI1T1VaamZHOWc5?=
 =?utf-8?B?NXI0UWR6TW9MNGZDSUptQ0hBMDFTVHZtV3NXeEhDV041N05uQ216Z1JGbVJy?=
 =?utf-8?B?c3hrSkVsVjlTQ0N1bjZid3RyYS96eWJueHJDS0p1aDFkRTdVb3pjRFNyRG96?=
 =?utf-8?B?ZzVGVUpkdWVhaW51VzVoanowM0IzV0duaDRxNUpubElEVFEyZHN6L1N5b1FX?=
 =?utf-8?B?T29JSTIzdmNncHdxdjIwTjllNEVwaVkyTW9kNWNjOVJZZVlKelR3b0c4UHlP?=
 =?utf-8?B?cW55dlUyMHpTUG5ndksveTRwVW9OYWdIMUxSZlA4ZnozdXVWdkVGZ3V1aEh1?=
 =?utf-8?B?OWxPbWd4RHYybDhmVnU5L0FQSStsSWtTYUNqMmZzWHpMUUlLWHRQbTFUVXBR?=
 =?utf-8?B?VS96TkNRUEUxOWFkSWMvT1RDYkRnbmRaSXZDaTlDVEdnWk0vK2dDT2d4Nzlu?=
 =?utf-8?B?QkpTYkY0Um1EMU9wYjhNa2locE01aCtKNTdhbnB6S3Z4OXpoTEpPMzd5UlV1?=
 =?utf-8?B?L3Bwb3l0K0g4aXdLemRiQUl5dVhkOUU1VjRZL3lpNzljUS9JR1czaTlGOUdM?=
 =?utf-8?B?a010bjkvZ0hURWFTWXhlZ2hpOXNIdVBDZkIwTnFkTFVBcnBQWmxtM3VnaHVI?=
 =?utf-8?B?cGFubGk2Nm5PT0huZ2xxbjE2eGxvNEZaektJTmE4eTJjS0RhUlJwOUZmUXoz?=
 =?utf-8?B?c3BxZWNjRlNkN3MzZFhBOVJDaTB6MVNySkp1Ty8yWHB0YnBQYU9YZTVQWENu?=
 =?utf-8?B?OURHenFYaTk4OEFlcHIzbmZoYXZaSmN3NHlLbmZlcGtXSGpKTnd5NVZFamdF?=
 =?utf-8?B?c0FnODFvWlNtREdRWkladWN5MGd1bTBva2dta2RBYk9yUkdFYjNOQWRxNFc3?=
 =?utf-8?B?Tld3cW1QcDhsNEZpbURMcUU5QkkzN2NQWTFlRGoxMy9weVRRVHg2MmIrN2RS?=
 =?utf-8?B?ZXFmYjhDdHRIUjBTMzZFQ3lmU3FZZEV0OU4zd2loODRaTnBGMkpMMDIyWTdR?=
 =?utf-8?B?RG9RWGlMQnl1UXpwYit2ZTBlVGNzRTBnZjhDZHNIU1gxZmg2NWZMQW8yY3ha?=
 =?utf-8?B?R2Izb2RzY3VEQkhPWkhHUTRYelBhR0lVZDFTeW1hV2dzVHJKcC8rTE40L1ZJ?=
 =?utf-8?B?blI2Yy9XcjVacXRhYVA1S05yQUJKWmZyNStWM24wTUMvN1daVzk1QjlUT05r?=
 =?utf-8?B?R3RHajNNMGpaWGVVWml5bWtjaUtYMkVOUGlhRUpxaWtmV1FoN08zRXNXRjBK?=
 =?utf-8?B?MGxydUZqcFJlNnphTFJCRUcxQUttQkNPSU5vcnY4QVpBa0NuSFJlMmp6cVRs?=
 =?utf-8?B?Z1dnSW1xOTlUVWl2QndheVFqaWJFOHBueTlKNU1aN2tMbmZlNmkxU3Q1RkNh?=
 =?utf-8?B?cEdZZEM4SnM5OWJVQjMwSTUrVURQVDcvQUtUSHhmYWZKUExCWjZFWWtBem1R?=
 =?utf-8?B?SEMzTUY0ZFZpM1BURnBzNHNjZDg3RDNGZ2hjT2FXVWZPcjlKUUI2ajFwMXRD?=
 =?utf-8?B?cXdmYWp4T0drTjlOVnl5bk5La0N4SXZ3bWtYMzJoa1VXYitJYWFSZTdHU2dj?=
 =?utf-8?B?dUNzZTAzMlFldkszZDFlUUg5QzVQbWZHQlhlWDVGVkxJRTFaNURtWjhRNTdW?=
 =?utf-8?B?c0dHampabkU4MVZtWU5HTWJFR3ZwSzJRQWVQVmdyS1FoQjRCMzQvWk9HNzRG?=
 =?utf-8?B?ZVNSdFRGczNDdExtOG95NWMwZWtPU1BYMHpxVk1OdXhPa0RCK1NuTlJLZU52?=
 =?utf-8?B?dEtDZXJXZ0tUQ1NGblo4bkZCYjhRc3lpZGVrWlZINThhTzJINVdUaU4rbUcv?=
 =?utf-8?B?eVJ3cFlMTHFNMkU4TU56aEd1Y0l5Z0ZqVzhnb25uTzNwVkNVMUk3KzBMUS9Q?=
 =?utf-8?B?MUU2ZnNBQlBLOVlSNlQ2Sk85YjRMOVZZQkVldE9OMzl5QjR2alcxaGJldW9Y?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 559ab600-f030-40f2-ffe2-08dd61894cc6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 17:14:08.5707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ba0K7Io380f7/6gczqaaVp+qBFDvUQB+cp7q0sMAXnU5+UjqO/gEln6imBQpqVyt1/9AWZfIJEbsT4Hk13QhTj0VelqWhczV2QrBwqYtFnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7854
X-OriginatorOrg: intel.com

Hi Babu,

On 3/12/25 9:03 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 3/12/25 10:07, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 3/11/25 1:35 PM, Moger, Babu wrote:
>>> Hi All,
>>>
>>> On 3/10/25 22:51, Reinette Chatre wrote:
>>>>
>>>>
>>>> On 3/10/25 6:44 PM, Moger, Babu wrote:
>>>>> Hi Tony,
>>>>>
>>>>> On 3/10/2025 6:22 PM, Luck, Tony wrote:
>>>>>> On Mon, Mar 10, 2025 at 05:48:44PM -0500, Moger, Babu wrote:
>>>>>>> Hi All,
>>>>>>>
>>>>>>> On 3/5/2025 1:34 PM, Moger, Babu wrote:
>>>>>>>> Hi Peter,
>>>>>>>>
>>>>>>>> On 3/5/25 04:40, Peter Newman wrote:
>>>>>>>>> Hi Babu,
>>>>>>>>>
>>>>>>>>> On Tue, Mar 4, 2025 at 10:49 PM Moger, Babu <babu.moger@amd.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi Peter,
>>>>>>>>>>
>>>>>>>>>> On 3/4/25 10:44, Peter Newman wrote:
>>>>>>>>>>> On Mon, Mar 3, 2025 at 8:16 PM Moger, Babu <babu.moger@amd.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Hi Peter/Reinette,
>>>>>>>>>>>>
>>>>>>>>>>>> On 2/26/25 07:27, Peter Newman wrote:
>>>>>>>>>>>>> Hi Babu,
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Tue, Feb 25, 2025 at 10:31 PM Moger, Babu <babu.moger@amd.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Hi Peter,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 2/25/25 11:11, Peter Newman wrote:
>>>>>>>>>>>>>>> Hi Reinette,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Fri, Feb 21, 2025 at 11:43 PM Reinette Chatre
>>>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Hi Peter,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On 2/21/25 5:12 AM, Peter Newman wrote:
>>>>>>>>>>>>>>>>> On Thu, Feb 20, 2025 at 7:36 PM Reinette Chatre
>>>>>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>>>>>> On 2/20/25 6:53 AM, Peter Newman wrote:
>>>>>>>>>>>>>>>>>>> On Wed, Feb 19, 2025 at 7:21 PM Reinette Chatre
>>>>>>>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>>>>>>>> On 2/19/25 3:28 AM, Peter Newman wrote:
>>>>>>>>>>>>>>>>>>>>> On Tue, Feb 18, 2025 at 6:50 PM Reinette Chatre
>>>>>>>>>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>>>>>>>>>> On 2/17/25 2:26 AM, Peter Newman wrote:
>>>>>>>>>>>>>>>>>>>>>>> On Fri, Feb 14, 2025 at 8:18 PM Reinette Chatre
>>>>>>>>>>>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>>>>>>>>>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
>>>>>>>>>>>>>>>>>>>>>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> (quoting relevant parts with goal to focus discussion on new possible syntax)
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>> I see the support for MPAM events distinct from the support of assignable counters.
>>>>>>>>>>>>>>>>>>>>>>>>>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>>>>>>>>>>>>>>>>>>>>>>>>>>> Please help me understand if you see it differently.
>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>> Doing so would need to come up with alphabetical letters for these events,
>>>>>>>>>>>>>>>>>>>>>>>>>>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>> mbm_local_read_bytes a
>>>>>>>>>>>>>>>>>>>>>>>>>>>> mbm_local_write_bytes b
>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>> Then mbm_assign_control can be used as:
>>>>>>>>>>>>>>>>>>>>>>>>>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>>>>>>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>>>>>>>>>>>>>>>>>>>>>>>>>>> <value>
>>>>>>>>>>>>>>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>>>>>>>>>>>>>>>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>>>>>>>>>>>>>>>>>>>>>>>>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>>>>>>>>>>>>>>>>>>>>>>>>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> As mentioned above, one possible issue with existing interface is that
>>>>>>>>>>>>>>>>>>>>>>>> it is limited to 26 events (assuming only lower case letters are used). The limit
>>>>>>>>>>>>>>>>>>>>>>>> is low enough to be of concern.
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> The events which can be monitored by a single counter on ABMC and MPAM
>>>>>>>>>>>>>>>>>>>>>>> so far are combinable, so 26 counters per group today means it limits
>>>>>>>>>>>>>>>>>>>>>>> breaking down MBM traffic for each group 26 ways. If a user complained
>>>>>>>>>>>>>>>>>>>>>>> that a 26-way breakdown of a group's MBM traffic was limiting their
>>>>>>>>>>>>>>>>>>>>>>> investigation, I would question whether they know what they're looking
>>>>>>>>>>>>>>>>>>>>>>> for.
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> The key here is "so far" as well as the focus on MBM only.
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> It is impossible for me to predict what we will see in a couple of years
>>>>>>>>>>>>>>>>>>>>>> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctrl interface
>>>>>>>>>>>>>>>>>>>>>> to support their users. Just looking at the Intel RDT spec the event register
>>>>>>>>>>>>>>>>>>>>>> has space for 32 events for each "CPU agent" resource. That does not take into
>>>>>>>>>>>>>>>>>>>>>> account the "non-CPU agents" that are enumerated via ACPI. Tony already mentioned
>>>>>>>>>>>>>>>>>>>>>> that he is working on patches [1] that will add new events and shared the idea
>>>>>>>>>>>>>>>>>>>>>> that we may be trending to support "perf" like events associated with RMID. I
>>>>>>>>>>>>>>>>>>>>>> expect AMD PQoS and Arm MPAM to provide related enhancements to support their
>>>>>>>>>>>>>>>>>>>>>> customers.
>>>>>>>>>>>>>>>>>>>>>> This all makes me think that resctrl should be ready to support more events than 26.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> I was thinking of the letters as representing a reusable, user-defined
>>>>>>>>>>>>>>>>>>>>> event-set for applying to a single counter rather than as individual
>>>>>>>>>>>>>>>>>>>>> events, since MPAM and ABMC allow us to choose the set of events each
>>>>>>>>>>>>>>>>>>>>> one counts. Wherever we define the letters, we could use more symbolic
>>>>>>>>>>>>>>>>>>>>> event names.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Thank you for clarifying.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> In the letters as events model, choosing the events assigned to a
>>>>>>>>>>>>>>>>>>>>> group wouldn't be enough information, since we would want to control
>>>>>>>>>>>>>>>>>>>>> which events should share a counter and which should be counted by
>>>>>>>>>>>>>>>>>>>>> separate counters. I think the amount of information that would need
>>>>>>>>>>>>>>>>>>>>> to be encoded into mbm_assign_control to represent the level of
>>>>>>>>>>>>>>>>>>>>> configurability supported by hardware would quickly get out of hand.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Maybe as an example, one counter for all reads, one counter for all
>>>>>>>>>>>>>>>>>>>>> writes in ABMC would look like...
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> (L3_QOS_ABMC_CFG.BwType field names below)
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> (per domain)
>>>>>>>>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>>>>>>>>    counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>>    counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>>>>>>>>    counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>>    counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>>> ...
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> I think this may also be what Dave was heading towards in [2] but in that
>>>>>>>>>>>>>>>>>>>> example and above the counter configuration appears to be global. You do mention
>>>>>>>>>>>>>>>>>>>> "configurability supported by hardware" so I wonder if per-domain counter
>>>>>>>>>>>>>>>>>>>> configuration is a requirement?
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> If it's global and we want a particular group to be watched by more
>>>>>>>>>>>>>>>>>>> counters, I wouldn't want this to result in allocating more counters
>>>>>>>>>>>>>>>>>>> for that group in all domains, or allocating counters in domains where
>>>>>>>>>>>>>>>>>>> they're not needed. I want to encourage my users to avoid allocating
>>>>>>>>>>>>>>>>>>> monitoring resources in domains where a job is not allowed to run so
>>>>>>>>>>>>>>>>>>> there's less pressure on the counters.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> In Dave's proposal it looks like global configuration means
>>>>>>>>>>>>>>>>>>> globally-defined "named counter configurations", which works because
>>>>>>>>>>>>>>>>>>> it's really per-domain assignment of the configurations to however
>>>>>>>>>>>>>>>>>>> many counters the group needs in each domain.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> I think I am becoming lost. Would a global configuration not break your
>>>>>>>>>>>>>>>>>> view of "event-set applied to a single counter"? If a counter is configured
>>>>>>>>>>>>>>>>>> globally then it would not make it possible to support the full configurability
>>>>>>>>>>>>>>>>>> of the hardware.
>>>>>>>>>>>>>>>>>> Before I add more confusion, let me try with an example that builds on your
>>>>>>>>>>>>>>>>>> earlier example copied below:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> (per domain)
>>>>>>>>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>>>>>>>>    counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>>    counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>>>>>>>>    counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>>    counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>>> ...
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Since the above states "per domain" I rewrite the example to highlight that as
>>>>>>>>>>>>>>>>>> I understand it:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>     counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>    domain 1:
>>>>>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>     counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>    domain 1:
>>>>>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> You mention that you do not want counters to be allocated in domains that they
>>>>>>>>>>>>>>>>>> are not needed in. So, let's say group 0 does not need counter 0 and counter 1
>>>>>>>>>>>>>>>>>> in domain 1, resulting in:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>     counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>    domain 1:
>>>>>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> With counter 0 and counter 1 available in domain 1, these counters could
>>>>>>>>>>>>>>>>>> theoretically be configured to give group 1 more data in domain 1:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>     counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>    domain 1:
>>>>>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill
>>>>>>>>>>>>>>>>>>     counter 1: LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>     counter 2: LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>     counter 3: VictimBW
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> The counters are shown with different per-domain configurations that seems to
>>>>>>>>>>>>>>>>>> match with earlier goals of (a) choose events counted by each counter and
>>>>>>>>>>>>>>>>>> (b) do not allocate counters in domains where they are not needed. As I
>>>>>>>>>>>>>>>>>> understand the above does contradict global counter configuration though.
>>>>>>>>>>>>>>>>>> Or do you mean that only the *name* of the counter is global and then
>>>>>>>>>>>>>>>>>> that it is reconfigured as part of every assignment?
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Yes, I meant only the *name* is global. I assume based on a particular
>>>>>>>>>>>>>>>>> system configuration, the user will settle on a handful of useful
>>>>>>>>>>>>>>>>> groupings to count.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Perhaps mbm_assign_control syntax is the clearest way to express an example...
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>    # define global configurations (in ABMC terms), not necessarily in this
>>>>>>>>>>>>>>>>>    # syntax and probably not in the mbm_assign_control file.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>    r=LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>    w=VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>    # legacy "total" configuration, effectively r+w
>>>>>>>>>>>>>>>>>    t=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>    /group0/0=t;1=t
>>>>>>>>>>>>>>>>>    /group1/0=t;1=t
>>>>>>>>>>>>>>>>>    /group2/0=_;1=t
>>>>>>>>>>>>>>>>>    /group3/0=rw;1=_
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> - group2 is restricted to domain 0
>>>>>>>>>>>>>>>>> - group3 is restricted to domain 1
>>>>>>>>>>>>>>>>> - the rest are unrestricted
>>>>>>>>>>>>>>>>> - In group3, we decided we need to separate read and write traffic
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> This consumes 4 counters in domain 0 and 3 counters in domain 1.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I see. Thank you for the example.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> resctrl supports per-domain configurations with the following possible when
>>>>>>>>>>>>>>>> using mbm_total_bytes_config and mbm_local_bytes_config:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> t(domain 0)=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>> t(domain 1)=LclFill,RmtFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>      /group0/0=t;1=t
>>>>>>>>>>>>>>>>      /group1/0=t;1=t
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Even though the flags are identical in all domains, the assigned counters will
>>>>>>>>>>>>>>>> be configured differently in each domain.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> With this supported by hardware and currently also supported by resctrl it seems
>>>>>>>>>>>>>>>> reasonable to carry this forward to what will be supported next.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The hardware supports both a per-domain mode, where all groups in a
>>>>>>>>>>>>>>> domain use the same configurations and are limited to two events per
>>>>>>>>>>>>>>> group and a per-group mode where every group can be configured and
>>>>>>>>>>>>>>> assigned freely. This series is using the legacy counter access mode
>>>>>>>>>>>>>>> where only counters whose BwType matches an instance of QOS_EVT_CFG_n
>>>>>>>>>>>>>>> in the domain can be read. If we chose to read the assigned counter
>>>>>>>>>>>>>>> directly (QM_EVTSEL[ExtendedEvtID]=1, QM_EVTSEL[EvtID]=L3CacheABMC)
>>>>>>>>>>>>>>> rather than asking the hardware to find the counter by RMID, we would
>>>>>>>>>>>>>>> not be limited to 2 counters per group/domain and the hardware would
>>>>>>>>>>>>>>> have the same flexibility as on MPAM.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> In extended mode, the contents of a specific counter can be read by
>>>>>>>>>>>>>> setting the following fields in QM_EVTSEL: [ExtendedEvtID]=1,
>>>>>>>>>>>>>> [EvtID]=L3CacheABMC and setting [RMID] to the desired counter ID. Reading
>>>>>>>>>>>>>> QM_CTR will then return the contents of the specified counter.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> It is documented below.
>>>>>>>>>>>>>> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
>>>>>>>>>>>>>>    Section: 19.3.3.3 Assignable Bandwidth Monitoring (ABMC)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> We previously discussed this with you (off the public list) and I
>>>>>>>>>>>>>> initially proposed the extended assignment mode.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Yes, the extended mode allows greater flexibility by enabling multiple
>>>>>>>>>>>>>> counters to be assigned to the same group, rather than being limited to
>>>>>>>>>>>>>> just two.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> However, the challenge is that we currently lack the necessary interfaces
>>>>>>>>>>>>>> to configure multiple events per group. Without these interfaces, the
>>>>>>>>>>>>>> extended mode is not practical at this time.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Therefore, we ultimately agreed to use the legacy mode, as it does not
>>>>>>>>>>>>>> require modifications to the existing interface, allowing us to continue
>>>>>>>>>>>>>> using it as is.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> (I might have said something confusing in my last messages because I
>>>>>>>>>>>>>>> had forgotten that I switched to the extended assignment mode when
>>>>>>>>>>>>>>> prototyping with soft-ABMC and MPAM.)
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Forcing all groups on a domain to share the same 2 counter
>>>>>>>>>>>>>>> configurations would not be acceptable for us, as the example I gave
>>>>>>>>>>>>>>> earlier is one I've already been asked about.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I don’t see this as a blocker. It should be considered an extension to the
>>>>>>>>>>>>>> current ABMC series. We can easily build on top of this series once we
>>>>>>>>>>>>>> finalize how to configure the multiple event interface for each group.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I don't think it is, either. Only being able to use ABMC to assign
>>>>>>>>>>>>> counters is fine for our use as an incremental step. My longer-term
>>>>>>>>>>>>> concern is the domain-scoped mbm_total_bytes_config and
>>>>>>>>>>>>> mbm_local_bytes_config files, but they were introduced with BMEC, so
>>>>>>>>>>>>> there's already an expectation that the files are present when BMEC is
>>>>>>>>>>>>> supported.
>>>>>>>>>>>>>
>>>>>>>>>>>>> On ABMC hardware that also supports BMEC, I'm concerned about enabling
>>>>>>>>>>>>> ABMC when only the BMEC-style event configuration interface exists.
>>>>>>>>>>>>> The scope of my issue is just whether enabling "full" ABMC support
>>>>>>>>>>>>> will require an additional opt-in, since that could remove the BMEC
>>>>>>>>>>>>> interface. If it does, it's something we can live with.
>>>>>>>>>>>>
>>>>>>>>>>>> As you know, this series is currently blocked without further feedback.
>>>>>>>>>>>>
>>>>>>>>>>>> I’d like to begin reworking these patches to incorporate Peter’s feedback.
>>>>>>>>>>>> Any input or suggestions would be appreciated.
>>>>>>>>>>>>
>>>>>>>>>>>> Here’s what we’ve learned so far:
>>>>>>>>>>>>
>>>>>>>>>>>> 1. Assignments should be independent of BMEC.
>>>>>>>>>>>> 2. We should be able to specify multiple event types to a counter (e.g.,
>>>>>>>>>>>> read, write, victimBM, etc.). This is also called shared counter
>>>>>>>>>>>> 3. There should be an option to assign events per domain.
>>>>>>>>>>>> 4. Currently, only two counters can be assigned per group, but the design
>>>>>>>>>>>> should allow flexibility to assign more in the future as the interface
>>>>>>>>>>>> evolves.
>>>>>>>>>>>> 5. Utilize the extended RMID read mode.
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Here is my proposal using Peter's earlier example:
>>>>>>>>>>>>
>>>>>>>>>>>> # define event configurations
>>>>>>>>>>>>
>>>>>>>>>>>> ========================================================
>>>>>>>>>>>> Bits    Mnemonics       Description
>>>>>>>>>>>> ====   ========================================================
>>>>>>>>>>>> 6       VictimBW        Dirty Victims from all types of memory
>>>>>>>>>>>> 5       RmtSlowFill     Reads to slow memory in the non-local NUMA domain
>>>>>>>>>>>> 4       LclSlowFill     Reads to slow memory in the local NUMA domain
>>>>>>>>>>>> 3       RmtNTWr         Non-temporal writes to non-local NUMA domain
>>>>>>>>>>>> 2       LclNTWr         Non-temporal writes to local NUMA domain
>>>>>>>>>>>> 1       mtFill          Reads to memory in the non-local NUMA domain
>>>>>>>>>>>> 0       LclFill         Reads to memory in the local NUMA domain
>>>>>>>>>>>> ====    ========================================================
>>>>>>>>>>>>
>>>>>>>>>>>> #Define flags based on combination of above event types.
>>>>>>>>>>>>
>>>>>>>>>>>> t = LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>> l = LclFill, LclNTWr, LclSlowFill
>>>>>>>>>>>> r = LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>> w = VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>> v = VictimBW
>>>>>>>>>>>>
>>>>>>>>>>>> Peter suggested the following format earlier :
>>>>>>>>>>>>
>>>>>>>>>>>> /group0/0=t;1=t
>>>>>>>>>>>> /group1/0=t;1=t
>>>>>>>>>>>> /group2/0=_;1=t
>>>>>>>>>>>> /group3/0=rw;1=_
>>>>>>>>>>>
>>>>>>>>>>> After some inquiries within Google, it sounds like nobody has invested
>>>>>>>>>>> much into the current mbm_assign_control format yet, so it would be
>>>>>>>>>>> best to drop it and distribute the configuration around the filesystem
>>>>>>>>>>> hierarchy[1], which should allow us to produce something more flexible
>>>>>>>>>>> and cleaner to implement.
>>>>>>>>>>>
>>>>>>>>>>> Roughly what I had in mind:
>>>>>>>>>>>
>>>>>>>>>>> Use mkdir in a info/<resource>_MON subdirectory to create free-form
>>>>>>>>>>> names for the assignable configurations rather than being restricted
>>>>>>>>>>> to single letters.  In the resulting directory, populate a file where
>>>>>>>>>>> we can specify the set of events the config should represent. I think
>>>>>>>>>>> we should use symbolic names for the events rather than raw BMEC field
>>>>>>>>>>> values. Moving forward we could come up with portable names for common
>>>>>>>>>>> events and only support the BMEC names on AMD machines for users who
>>>>>>>>>>> want specific events and don't care about portability.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I’m still processing this. Let me start with some initial questions.
>>>>>>>>>>
>>>>>>>>>> So, we are creating event configurations here, which seems reasonable.
>>>>>>>>>>
>>>>>>>>>> Yes, we should use portable names and are not limited to BMEC names.
>>>>>>>>>>
>>>>>>>>>> How many configurations should we allow? Do we know?
>>>>>>>>>
>>>>>>>>> Do we need an upper limit?
>>>>>>>>
>>>>>>>> I think so. This needs to be maintained in some data structure. We can
>>>>>>>> start with 2 default configurations for now.
>>>>
>>>> There is a big difference between no upper limit and 2. The hardware is
>>>> capable of supporting per-domain configurations so more flexibility is
>>>> certainly possible. Consider the example presented by Peter in:
>>>> https://lore.kernel.org/lkml/CALPaoCi0mFZ9TycyNs+SCR+2tuRJovQ2809jYMun4HtC64hJmA@mail.gmail.com/
>>>>
>>>>>>>>>>> Next, put assignment-control file nodes in per-domain directories
>>>>>>>>>>> (i.e., mon_data/mon_L3_00/assign_{exclusive,shared}). Writing a
>>>>>>>>>>> counter-configuration name into the file would then allocate a counter
>>>>>>>>>>> in the domain, apply the named configuration, and monitor the parent
>>>>>>>>>>> group-directory. We can also put a group/resource-scoped assign_* file
>>>>>>>>>>> higher in the hierarchy to make it easier for users who want to
>>>>>>>>>>> configure all domains the same for a group.
>>>>>>>>>>
>>>>>>>>>> What is the difference between shared and exclusive?
>>>>>>>>>
>>>>>>>>> Shared assignment[1] means that non-exclusively-assigned counters in
>>>>>>>>> each domain will be scheduled round-robin to the groups requesting
>>>>>>>>> shared access to a counter. In my tests, I assigned the counters long
>>>>>>>>> enough to produce a single 1-second MB/s sample for the per-domain
>>>>>>>>> aggregation files[2].
>>>>>>>>>
>>>>>>>>> These do not need to be implemented immediately, but knowing that they
>>>>>>>>> work addresses the overhead and scalability concerns of reassigning
>>>>>>>>> counters and reading their values.
>>>>>>>>
>>>>>>>> Ok. Lets focus on exclusive assignments for now.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Having three files—assign_shared, assign_exclusive, and unassign—for each
>>>>>>>>>> domain seems excessive. In a system with 32 groups and 12 domains, this
>>>>>>>>>> results in 32 × 12 × 3 files, which is quite large.
>>>>>>>>>>
>>>>>>>>>> There should be a more efficient way to handle this.
>>>>>>>>>>
>>>>>>>>>> Initially, we started with a group-level file for this interface, but it
>>>>>>>>>> was rejected due to the high number of sysfs calls, making it inefficient.
>>>>>>>>>
>>>>>>>>> I had rejected it due to the high-frequency of access of a large
>>>>>>>>> number of files, which has since been addressed by shared assignment
>>>>>>>>> (or automatic reassignment) and aggregated mbps files.
>>>>>>>>
>>>>>>>> I think we should address this as well. Creating three extra files for
>>>>>>>> each group isn’t ideal when there are more efficient alternatives.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Additionally, how can we list all assignments with a single sysfs call?
>>>>>>>>>>
>>>>>>>>>> That was another problem we need to address.
>>>>>>>>>
>>>>>>>>> This is not a requirement I was aware of. If the user forgot where
>>>>>>>>> they assigned counters (or forgot to disable auto-assignment), they
>>>>>>>>> can read multiple sysfs nodes to remind themselves.
>>>>>>>>
>>>>>>>> I suggest, we should provide users with an option to list the assignments
>>>>>>>> of all groups in a single command. As the number of groups increases, it
>>>>>>>> becomes cumbersome to query each group individually.
>>>>>>>>
>>>>>>>> To achieve this, we can reuse our existing mbm_assign_control interface
>>>>>>>> for this purpose. More details on this below.
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> The configuration names listed in assign_* would result in files of
>>>>>>>>>>> the same name in the appropriate mon_data domain directories from
>>>>>>>>>>> which the count values can be read.
>>>>>>>>>>>
>>>>>>>>>>>    # mkdir info/L3_MON/counter_configs/mbm_local_bytes
>>>>>>>>>>>    # echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>>>>>>>>    # echo LclNTWr > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>>>>>>>>    # echo LclSlowFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>>>>>>>>    # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>>>>>>>> LclFill
>>>>>>>>>>> LclNTWr
>>>>>>>>>>> LclSlowFill
>>>>>>>>>>
>>>>>>>>>> I feel we can just have the configs. event_filter file is not required.
>>>>>>>>>
>>>>>>>>> That's right, I forgot that we can implement kernfs_ops::open(). I was
>>>>>>>>> only looking at struct kernfs_syscall_ops
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> #cat info/L3_MON/counter_configs/mbm_local_bytes
>>>>>>>>>> LclFill <-rename these to generic names.
>>>>>>>>>> LclNTWr
>>>>>>>>>> LclSlowFill
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I think portable and non-portable event names should both be available
>>>>>>>>> as options. There are simple bandwidth measurement mechanisms that
>>>>>>>>> will be applied in general, but when they turn up an issue, it can
>>>>>>>>> often lead to a more focused investigation, requiring more precise
>>>>>>>>> events.
>>>>>>>>
>>>>>>>> I aggree. We should provide both portable and non-portable event names.
>>>>>>>>
>>>>>>>> Here is my draft proposal based on the discussion so far and reusing some
>>>>>>>> of the current interface. Idea here is to start with basic assigment
>>>>>>>> feature with options to enhance it in the future. Feel free to
>>>>>>>> comment/suggest.
>>>>>>>>
>>>>>>>> 1. Event configurations will be in
>>>>>>>>      /sys/fs/resctrl/info/L3_MON/counter_configs/.
>>>>>>>>
>>>>>>>>      There will be two pre-defined configurations by default.
>>>>>>>>
>>>>>>>>      #cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_total_bytes
>>>>>>>>      LclFill, LclNTWr,LclSlowFill,VictimBM,RmtSlowFill,LclSlowFill,RmtFill
>>>>>>>>
>>>>>>>>      #cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
>>>>>>>>      LclFill, LclNTWr, LclSlowFill
>>>>>>>>
>>>>>>>> 2. Users will have options to update these configurations.
>>>>>>>>
>>>>>>>>      #echo "LclFill, LclNTWr, RmtFill" >
>>>>>>>>         /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
>>>>>>
>>>>>> This part seems odd to me. Now the "mbm_local_bytes" files aren't
>>>>>> reporting "local_bytes" any more. They report something different,
>>>>>> and users only know if they come to check the options currently
>>>>>> configured in this file. Changing the contents without changing
>>>>>> the name seems confusing to me.
>>>>>
>>>>> It is the same behaviour right now with BMEC. It is configurable.
>>>>> By default it is mbm_local_bytes, but users can configure whatever they want to monitor using /info/L3_MON/mbm_local_bytes_config.
>>>>>
>>>>> We can continue the same behaviour with ABMC, but the configuration will be in /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes.
>>>>
>>>> This could be supported by following Peter's original proposal where the name
>>>> of the counter configuration is provided by the user via a mkdir:
>>>> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/
>>>>
>>>> As he mentioned there could be pre-populated mbm_local_bytes/mbm_total_bytes.
>>>
>>> Sure. We can do that. I was thinking in the first phase, just provide the
>>> default pre-defined configuration and option to update the configuration.
>>>
>>> We can add the mkdir support later. That way we can provide basic ABMC
>>> support without too much code complexity with mkdir support.
>>
>> This is not clear to me how you envision the "first phase". Is it what you
>> proposed above, for example:
>>       #echo "LclFill, LclNTWr, RmtFill" >
>>          /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
>>
>> In above the counter configuration name is a file. 
> 
> Yes. That is correct.
> 
> There will be two configuration files by default when resctrl is mounted
> when ABMC is enabled.
> /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_total_bytes
> /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
> 
>>
>> How could mkdir support be added to this later if there are already files present?
> 
> We already have these directories when resctrl is mounted.
> /sys/fs/resctrl/test/mon_data/mon_L3_00/mbm_total_bytes
> /sys/fs/resctrl/test/mon_data/mon_L3_00/mbm_local_bytes
> /sys/fs/resctrl/test/mon_data/mon_L3_01/mbm_total_bytes
> /sys/fs/resctrl/test/mon_data/mon_L3_01/mbm_local_bytes
> 
> We dont need "mkdir" support for default  configurations.

I was referring to the "mkdir" support for additional configurations that
I understood you are thinking about adding later. For example,
(copied from Peter's message
https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/):


 # mkdir info/L3_MON/counter_configs/mbm_local_bytes
 # echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
 # echo LclNTWr > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
 # echo LclSlowFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
 # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
LclFill
LclNTWr
LclSlowFill

Any "later" work needs to be backward compatible with the first phase.

If the first phase starts with a file:
/sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
... I do not see how second phase can be backward compatible when that work
needs a directory with the same name that contains a file for configuration:
/sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes/event_filter

sidenote: I think interactions with the "event_filter" file needs more
descriptions since it is not clear with the provided example how user space
may want to interact with the file when adding vs replacing event configurations.

> 
> My plan was to support only the default configurations in the first phase.
> That way there is no difference in the usage model with ABMC when mounted.
> 
> 
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>>
>>>>>>>>      # #cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
>>>>>>>>      LclFill, LclNTWr, RmtFill
>>>>>>>>
>>>>>>>> 3. The default configurations will be used when user mounts the resctrl.
>>>>>>>>
>>>>>>>>      mount  -t resctrl resctrl /sys/fs/resctrl/
>>>>>>>>      mkdir /sys/fs/resctrl/test/
>>>>>>>>
>>>>>>>> 4. The resctrl group/domains can be in one of these assingnment states.
>>>>>>>>      e: Exclusive
>>>>>>>>      s: Shared
>>>>>>>>      u: Unassigned
>>>>>>>>
>>>>>>>>      Exclusive mode is supported now. Shared mode will be supported in the
>>>>>>>> future.
>>>>>>>>
>>>>>>>> 5. We can use the current /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>> to list the assignment state of all the groups.
>>>>>>>>
>>>>>>>>      Format:
>>>>>>>>      "<CTRL_MON group>/<MON group>/<confguration>:<domain_id>=<assign state>"
>>>>>>>>
>>>>>>>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>      test//mbm_total_bytes:0=e;1=e
>>>>>>>>      test//mbm_local_bytes:0=e;1=e
>>>>>>>>      //mbm_total_bytes:0=e;1=e
>>>>>>>>      //mbm_local_bytes:0=e;1=e
>>>>
>>>> This would make mbm_assign_control even more unwieldy and quicker to exceed a
>>>> page of data (these examples never seem to reflect those AMD systems with the many
>>>> L3 domains). How to handle resctrl files larger than 4KB needs to be well understood
>>>> and solved when/if going this route.
>>>
>>> This problem is not specific this series. I feel it is a generic problem
>>> to many of the semilar interfaces. I dont know how it is addressed. May
>>> have to investigate on this. Any pointers would be helpful.
>>
>> Dave Martin already did a lot of analysis here. What other pointers do you need?
>>
>>>
>>>
>>>>
>>>> There seems to be two opinions about this file at moment. Would it be possible to
>>>> summarize the discussion with pros/cons raised to make an informed selection?
>>>> I understand that Google as represented by Peter no longer requires/requests this
>>>> file but the motivation for this change seems new and does not seem to reduce the
>>>> original motivation for this file. We may also want to separate requirements for reading
>>>> from and writing to this file.
>>>
>>> Yea. We can just use mbm_assign_control for reading the assignment states.
>>>
>>> Summary: We have two proposals.
>>>
>>> First one from Peter:
>>>
>>> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/
>>>
>>>
>>> Pros
>>> a.  Allows flexible creation of free-form names for assignable
>>> configurations, stored in info/L3_MON/counter_configs/.
>>>
>>> b.  Events can be accessed using corresponding free-form names in the
>>> mon_data directory, making it clear to users what each event represents.
>>>
>>>
>>> Cons:
>>> a. Requires three separate files for assignment in each group
>>> (assign_exclusive, assign_shared, unassign), which might be excessive.
>>>
>>> b. No built-in listing support, meaning users must query each group
>>> individually to check assignment states.
>>>
>>>
>>> Second Proposal (Mine)
>>>
>>> https://lore.kernel.org/lkml/a4ab53b5-03be-4299-8853-e86270d46f2e@amd.com/
>>>
>>> Pros:
>>>
>>> a. Maintains the flexibility of free-form names for assignable
>>> configurations (info/L3_MON/counter_configs/).
>>>
>>> b. Events remain accessible via free-form names in mon_data, ensuring
>>> clarity on their purpose.
>>>
>>> c. Adds the ability to list assignment states for all groups in a single
>>> command.
>>>
>>> Cons:
>>> a.  Potential buffer overflow issues when handling a large number of
>>> groups and domains and code complexity to fix the issue.
>>>
>>>
>>> Third Option: A Hybrid Approach
>>>
>>> We could combine elements from both proposals:
>>>
>>> a. Retain the free-form naming approach for assignable configurations in
>>> info/L3_MON/counter_configs/.
>>>
>>> b. Use the assignment method from the first proposal:
>>>    $mkdir test
>>>    $echo mbm_local_bytes > test/mon_data/mon_L3_00/assign_exclusive
>>>
>>> c. Introduce listing support via the info/L3_MON/mbm_assign_control
>>> interface, enabling users to read assignment states for all groups in one
>>> place. Only reading support.
>>>
>>>
>>>>
>>>>>>>>
>>>>>>>> 6. Users can modify the assignment state by writing to mbm_assign_control.
>>>>>>>>
>>>>>>>>      Format:
>>>>>>>>      “<CTRL_MON group>/<MON group>/<configuration>:<domain_id>=<assign state>”
>>>>>>>>
>>>>>>>>      #echo "test//mbm_local_bytes:0=e;1=e" >
>>>>>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>
>>>>>>>>      #echo "test//mbm_local_bytes:0=u;1=u" >
>>>>>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>
>>>>>>>>      # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>      test//mbm_total_bytes:0=u;1=u
>>>>>>>>      test//mbm_local_bytes:0=u;1=u
>>>>>>>>      //mbm_total_bytes:0=e;1=e
>>>>>>>>      //mbm_local_bytes:0=e;1=e
>>>>>>>>
>>>>>>>>      The corresponding events will be read in
>>>>>>>>
>>>>>>>>      /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>>>>>>>      /sys/fs/resctrl/mon_data/mon_L3_01/mbm_total_bytes
>>>>>>>>      /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>>      /sys/fs/resctrl/mon_data/mon_L3_01/mbm_local_bytes
>>>>>>>>      /sys/fs/resctrl/test/mon_data/mon_L3_00/mbm_total_bytes
>>>>>>>>      /sys/fs/resctrl/test/mon_data/mon_L3_01/mbm_total_bytes
>>>>>>>>      /sys/fs/resctrl/test/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>>      /sys/fs/resctrl/test/mon_data/mon_L3_01/mbm_local_bytes
>>>>>>>>
>>>>>>>> 7. In the first stage, only two configurations(mbm_total_bytes and
>>>>>>>> mbm_local_bytes) will be supported.
>>>>>>>>
>>>>>>>> 8. In the future, there will be options to create multiple configurations
>>>>>>>> and corresponding directory will be created in
>>>>>>>> /sysf/fs/resctrl/test/mon_data/mon_L3_00/<configation name>.
>>>>>>
>>>>>> Would this be done by creating a new file in the /sys/fs/resctrl/info/L3_MON/counter_configs
>>>>>> directory? Like this:
>>>>>>
>>>>>> # echo "LclFill, LclNTWr, RmtFill" >
>>>>>>          /sys/fs/resctrl/info/L3_MON/counter_configs/cache_stuff
>>>>>>
>>>>>> This seems OK (dependent on the user picking meaningful names for
>>>>>> the set of attributes picked ... but if they want to name this
>>>>>> monitor file "brian" then they have to live with any confusion
>>>>>> that they bring on themselves).
>>>>>>
>>>>>> Would this involve an extension to kernfs? I don't see a function
>>>>>> pointer callback for file creation in kernfs_syscall_ops.
>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>> I know you are all busy with multiple series going on parallel. I am still
>>>>>>> waiting for the inputs on this. It will be great if you can spend some time
>>>>>>> on this to see if we can find common ground on the interface.
>>>>>>>
>>>>>>> Thanks
>>>>>>> Babu
>>>>>>
>>>>>> -Tony
>>>>>>
>>>>>
>>>>>
>>>>> thanks
>>>>> Babu
>>>>
>>>> Reinette
>>>>
>>>>
>>>
>>
>>
> 


