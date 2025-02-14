Return-Path: <linux-kernel+bounces-514504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1286FA357D2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBCD3AE1B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533AC2080C7;
	Fri, 14 Feb 2025 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afyrXKzn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AF3207DE9;
	Fri, 14 Feb 2025 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739517801; cv=fail; b=LueFg4Gl1EY7lcFpzx44hbSIHQKT3rpgF3M9vHCApLawYCkagdn6cvMMKxeKnHX6X8iYsAElazYD9k7JhhGtpSw7e4ewGvIKfui/W9FPibug9VT+/66YxrJ5I9+MvEw8peFYz+VJoWcw6+XgakMx+QgCOILh0VhgXAdpUqBe/XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739517801; c=relaxed/simple;
	bh=MrZqN1on+/rUK9Ecvd2GEyMjYaCyeiLRVoJ/Dt5doZI=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y7OKpTr55JUEkPQtusYLRzaEqMeuBfz95Cs64kwJGWutGepCH8FJD9ZtggKjRfoUzVXyfV0SGxxKZcMcSs/XvPw0Y/oQXn7LUCtGJTQEJNk0Su6KwwuKHxHTeeh02w7ovgUhE85ISSAs6Qy65H3ZeDHp0Zryin7pV51DgDANeLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=afyrXKzn; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739517800; x=1771053800;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MrZqN1on+/rUK9Ecvd2GEyMjYaCyeiLRVoJ/Dt5doZI=;
  b=afyrXKzneepL+0LtfL4Xawr2hAzFo2b0O1GZqCx6QURpXUgagSYq+eOw
   7ss+3Eoavb16kkppLWHeARRTEio8SfK1EB9NjvmPU75Zt9gnq+LE2T97Q
   kJp59axt65NWZCeKezPx4C2a9UGuU+bhzMhHEVI6tuwuF5xB3TL/wufJI
   Pjx4pM4T+0jBXJemB9G5HcDvVzT6uKQB/2lp+soYrcnehDJOTES7pa6RB
   DwUcwYU1Odg70Z4hOdvjKC/o3PKDIhwPx4uw8v3+XhjhrBTtWJptVbZ43
   yqqA64gnwzk+E5Gs76m1kibiJI4Q9YiZGG4o6qBlntRvOW3l4u3jMseRO
   g==;
X-CSE-ConnectionGUID: wN/SMVAQTKGmdwono6fY4A==
X-CSE-MsgGUID: vzEaGrLWRyKOKq7lt/0kUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="50884234"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="50884234"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 23:23:19 -0800
X-CSE-ConnectionGUID: YE3Xd+ZrT6uwWRB2IILtTQ==
X-CSE-MsgGUID: SeFJcfX2SSGZD8por9LOaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117516176"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 23:23:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 23:23:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 23:23:17 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 23:23:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvifC/9b0FkZmMn14ZnBYOHFZv2k+1OxFwmM4+jbVsoywxceRGMblra8zXB2lpJO1uriDDidm0z7VkSdKqhVbAm9+Hf/0O23Kfqn4FZuYcOqWMf72sjfFHT8q4R7iRY/mN3a4BOcu1QeZ1XZ+h3uwqgPjhk6MzS67exK15xa5Y1hRRPdyTX8YlaPQY7LuvrLpqaIVRnZy4f0sXg0oxXs/kYD2HwcbpEGbYhHSTkDUnPsAOyUqpeVzcfWk0qbhOi92b3SG0a3aZBIwx5KRiEJbJyQz3qc2XgNDEWp+IkoVkLnDXeI7uBuvivP2LXeIXLwS38u/zPjl+jxzCXxGXaw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAm023Gw6KY79uBZ2Wv8PFjUaVX1jIYZmryHnDpLsow=;
 b=Al7FaqSNuI6zMBclRnTzXKn2kd1pFQgpNrI7UrALGKqUf+fcV+kyKGQLJ/66x8KTOMM6pFbw7u1w3CF/YsicR0si6DFmSCJS5ywBiSifVo+yK427/9Can+pgRlseKzRAfNt2QvWc1qPu7hzFye/krXh51kBY/gVtFkciggvJvhStl1WvlYz2HMP7VP7CIGNxI5hAWuamGe4XqTM5U1fXIK+OxQWjSpzayOCjCM5MO9F1tkGFhSGsRzf2VvOS97jyzOdwq3ogaShaVc+foJGeQE8nSzdvDOSph6BgvrnBQ2fyb65lfyZZ3/ZOKUfunEF09DsqGB8BMTjhyaTmH31qHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB7930.namprd11.prod.outlook.com (2603:10b6:8:da::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Fri, 14 Feb 2025 07:23:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 07:23:12 +0000
Message-ID: <27557e4d-c067-493c-817c-34fb2bb1fda0@intel.com>
Date: Thu, 13 Feb 2025 23:23:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
From: Reinette Chatre <reinette.chatre@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>, Dave Martin <Dave.Martin@arm.com>,
	"Moger, Babu" <babu.moger@amd.com>
CC: "peternewman@google.com" <peternewman@google.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "thuth@redhat.com" <thuth@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "xiongwei.song@windriver.com"
	<xiongwei.song@windriver.com>, "pawan.kumar.gupta@linux.intel.com"
	<pawan.kumar.gupta@linux.intel.com>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "perry.yuan@amd.com" <perry.yuan@amd.com>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>, "Huang, Kai"
	<kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Li, Xin3" <xin3.li@intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"ebiggers@google.com" <ebiggers@google.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Eranian,
 Stephane" <eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <5e9a5b3e-793c-4873-a1d2-33b62614ec31@amd.com>
 <Z643WdXYARTADSBy@e133380.arm.com>
 <SJ1PR11MB6083759CCE59FF2FE931471EFCFF2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <b0380521-75f8-4f88-8dd5-c4746748e628@intel.com>
Content-Language: en-US
In-Reply-To: <b0380521-75f8-4f88-8dd5-c4746748e628@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:303:b4::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b7cc524-34d0-4c80-716a-08dd4cc87081
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0pvWlVzeFFLOXY3QWU3M2x1Rk52dEE1T2U5MVkxQno0R2VrWlViUTlWbHFB?=
 =?utf-8?B?Z1VpcnhXZnhnTUtyazBjc1FjTmMyN0p6ZklhNWFIdWlaNGdKRzhPelV5cVQx?=
 =?utf-8?B?ejBjdk0zRnNzTEZPZHNDS0N3MWZ0aEFZZlg0d1IvOFA2S2RpRVlnOXlZcjds?=
 =?utf-8?B?ZlR6elZ4aFlxQ0dibGN0UG5QNU9IWS81UDVpaXREMEJYMHZLaDBPcWNYZXp0?=
 =?utf-8?B?SklQQ25IM2ZrZG84bkY1LzVMV1Z2QnowUVFENkRKSzIzOGJ6VlBxV2lZOE04?=
 =?utf-8?B?dTh4VnhiREs0RzFYNXduRG04WW80WnQ5blFER1JVaGtWSkVkL3ZBeDdWN2xS?=
 =?utf-8?B?QmFPbDFHWk1vT0R3dlo5RHQ3WlJ5Z09ETEFnNFJQNjFNU2Q2N29jQlNyOHkv?=
 =?utf-8?B?REZUbUN0K3hOQVFSbmRHTDZBKzNQM05oaWZzQkQxT1g5Q1U5cnMwZmdETUFs?=
 =?utf-8?B?UWFhWnprdGhNcmN6RWtBS3hQRTd5OTJKVS9hZzNxSjFWUkE4QlNyaXEyeERU?=
 =?utf-8?B?ekNCUXlVQitwTW52Q2JMQndiUmlMMzhlMStCSG9UQm05aDBBTlkyUEp2ejdR?=
 =?utf-8?B?Z0lXd0dza0lMTEVWa0wxakFUR2thdWhLL1IxSk1ZdG9hNVkxY2pmc2xQMWZt?=
 =?utf-8?B?SG8zZEZuMFV1K1lqMW4yNzExbDVhd0VTN0FzbEw3N3FMNngvVG9PN2JaRTNx?=
 =?utf-8?B?bHN3UE14Ujdzd1JDSFpTQnprRWhLRytFN2liR3IxeXNjSVN0NVErMlQ0eG5W?=
 =?utf-8?B?VFVmQjJ3RlBhNEJsaXhNWjN2bCtwbWQxcmlLOUJmaDNEdkl4L3RET1dxY0VI?=
 =?utf-8?B?RlhBWVRJVTErYXlmVW9JOGVuYnRNYjJMVDNwdnhDd2dxTDZLUWhvbmg1MHg5?=
 =?utf-8?B?WjUxRWpYRzA0c2txNEZ3cjFIRkoxNXRlUzl2ZHdjTjBBUlZlZGdXcnYwNEF5?=
 =?utf-8?B?L0VzbFdqcWtHeHR6bGczWWRURU9aTDN1Q2toajZjVFhvcFlld3I5MlVtQTN2?=
 =?utf-8?B?c3pEZEtGYXFBSWZOa3lWVkpYZjhOTkZINVZFT1JSQjBveVNndTh2TkVRNzMr?=
 =?utf-8?B?NzVFWnQyZ1V4djhTNlhDbjZoRTM2YncxYVFoQlF6aXk1SmZKSjBucmVuOGdx?=
 =?utf-8?B?cS90NG1mZDBYWXVQd1A2NnN1M1JoQkVKelRiK2lLNTZrQnh1ak84M0N4WFk0?=
 =?utf-8?B?VlY5Q0k4TzdZcFNBTHVqbzBCcThSUzhuRTFBWlZmVloycC82T0YvOGNhMkcv?=
 =?utf-8?B?MVlVdHF3V2VlTHJBUS9jT2ZzdDYvb0JjcXcwVU9qRzc0emczSW1PZDdBcDFp?=
 =?utf-8?B?YUllbDFUWjFMdHdldFRGZVFJdFlETDhPWGZCMEtnOUo0YSs2THZqWnM1OHNt?=
 =?utf-8?B?TUVRR1pWT0NMczFCSjJRcjZtbkxPaWRrWkMyQlpPdU50cC9DUFJjOThnTStw?=
 =?utf-8?B?dlAxRzBTSnhxa0lwUkF1eHlENXRCU3JiRy9QS1NKWTFuRjdqM3hGeG1iVmdU?=
 =?utf-8?B?UmQ4cEVyZDJBdlJndDNlU2x2T0xVWlZsM0FVQ0Y5SitHckpyaGxBOGlScEVO?=
 =?utf-8?B?U0JsNXBaTGtBZ290UnJiOFJpMlAwYkxUM0RVZ2U0ZEE5QlBaWkx0cDJvVy9P?=
 =?utf-8?B?Y083UmVHUHl3WnpNenViSDZnZWtBQ2t3TldPZUswTHViUS9oNVFlYmhTZEVI?=
 =?utf-8?B?TGhqNno5c2NKelVXWWR0bG5uempYNVNhbWtEZFY5SU5NZEZueUdUdDUwNnhV?=
 =?utf-8?B?TDBJR0lFb25kMzdNWm1tb2tvOFRzak0zTFhyeWVoWmcwSSt1YkdQYXUvbjZi?=
 =?utf-8?B?Y0ZReFcxVzBuS213MTdrelh1bHEwYmRuazRLa1VVaFFsVUlKQU54ZVpqelJo?=
 =?utf-8?Q?sP00AYfKvL48F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0ZrU2Vjd0oxSEJ5Y0NpTXBkRit3czBnTXptNU9jVE54MExjdFJiS2NSR1ZK?=
 =?utf-8?B?N29LUHV3eDR5NUV5aXBucllnSEt4ZEtnYUhKOVdRY1NKZWgwRkpINTBlRTlM?=
 =?utf-8?B?aUpsQk1TVkVHOWJxZ2tHTXNUdjk0RllvL0NYSEJyRWJ4M2tGTHlieDFqOXZv?=
 =?utf-8?B?Nm9Sem9jY2JSNVJWRTdPME1KY0VBK1FzL05yN1M4OWI1d1dJVWlianRlWFUw?=
 =?utf-8?B?U1YxQ3FwUEwwWE1LNlpMS1F3VEhMRnlUU1Y0NjRSYlpvN2s1ZXRURHVYaWF5?=
 =?utf-8?B?RnN4YWlkOElPcnZuMG9UclhkYUVlbjNyNWN1ZVQ1QWZ0T3VPOERhZDc5RGVS?=
 =?utf-8?B?UWlESTlYMy90eUF6NGFWMytzTXdham00NDk1cktoREJ6b0w2NzhDdm9NU1Uw?=
 =?utf-8?B?NTFaY0RhUEpiWElBVmZKRUh0VnFjdnhGaUt2bk41RjN1SVdsU0pvMi9zZ3Zl?=
 =?utf-8?B?MnpTa2JOWWQ2VGJYV0JldWZKY1VCWXliekpzVmJKVW5QRDNuTWlaMmNEdmlh?=
 =?utf-8?B?RERYcGVCdXh4VHJFV1pCYlA4TGxna3V5Z0lYYWtLZ3lTRmpPLzhpekxvczFS?=
 =?utf-8?B?T3hiZldweUZGWHpqNXZYVUZab2V1bWtmakdvbmFZSHpBME5HaUhBUG41TFZ2?=
 =?utf-8?B?TVRBOFdxTkl2enNOU2xXaTRHYUVXWUtjL0dLR1JSUkRSV2RaUGFWRGlKWTlv?=
 =?utf-8?B?OUlldTNBQW9JNzgzUjJTdGQycW9RaElrNDdDOEMrdEh6VDhhcXNlb1g1Q0h3?=
 =?utf-8?B?M2U2UkhoclJQbjFuOWFxSFRhL2hKalFhQ3EwUTFIdnl3a3Jwek5uL3E0MHA4?=
 =?utf-8?B?bThRQXRUa3Q3eVdMaG9GRWRnWWFpVTg4Z3YwUFVPU2x0aFV3LzNVb3ZIbmVv?=
 =?utf-8?B?REtuY0JicE9hNjJEL2Y0ZExZSDVlRDB0Y0puKzE4MFZibGhUL3NjbXRwRkYx?=
 =?utf-8?B?MjZuRlpjcXhKYm5VVGZpbG5XMjg3RURiV2xqZHVGMVZta0VIT2F3ZGptL0hI?=
 =?utf-8?B?cUk4N1VRTkhQM3hxN3BHRE50c0pIcjlUY1Q1S0gydHBIdDhWbytnYzJ1bGVu?=
 =?utf-8?B?Y2NYdTlvbnZHWmFlZEt2aVF2U1VXNGJDWkpYRkk4dTY3NUJ4c2t1aGQrZVhx?=
 =?utf-8?B?bndaME5LUmRUNXFvYzl5ZHFjaHhkWXAwR1JjMmw5d2gzeWtTVmVGa29qUDQw?=
 =?utf-8?B?T2xJT05OdGVxcWNRRnNiY0l3SXpac1A0Rkxjc0hkY1BqS0YyRkhGQ1k4MnRq?=
 =?utf-8?B?WEduSlVUdlZTalN0RVB2WnZiMklzUDJpcVVrVFU4REwzWEFxM1Roc2tEbkJI?=
 =?utf-8?B?L095eXpOTDRBMVJzb1FzMGQ5NS95ZmtZTzhSUng5eno5WmVLdmFaRmM0bjFZ?=
 =?utf-8?B?M2VoQXZJdzBzNVg1ejgyemhGU1h2U1pLY2RzTzd0TWg1aDBmMGUzZlhHMHgw?=
 =?utf-8?B?ZU5LNlkyYjY1MFdpS2ZnTUpOVjY1bWVJR2E3MFFpbWxwd0dGUHljNnZGZVlY?=
 =?utf-8?B?VEtSSVlUQWM3V0lmTFlXTnEzWXl6ZlBTSWdOT1hKRlRjbktPOWpBWDllLzVr?=
 =?utf-8?B?T2UzUm9WcVFyWHdqNkNZaTdreHdlTUxsUW8vbHZlMWozcHJHVlU5WG9yelRR?=
 =?utf-8?B?VTlMc3NvQXFqVGwybzBjMEZQd3ZZRmhKdjhBWGVhNjcwTUw2cXVkeXN5TUlx?=
 =?utf-8?B?aEYvK2N4OVlWYWRaNGVjRnlsRVZRNFd6VUwvZzBRajhScFJMVEN0TlpqWmFy?=
 =?utf-8?B?bktGakNKL3lhVDRIbE5yZlFUNHVTQWw2Ukcra1pjenJYbDJaZHJlZ2w2QXI2?=
 =?utf-8?B?cHRVKzBtSTE0UW5mZGdZU2E1T1QyK25vQ1ExQlBCbm1pUDVtNjRDak9wNURV?=
 =?utf-8?B?OEJvaENTMis5c3RFazZwMlJablJjcXJ0aFZXVWtzSWwza0hleU9Tc0lySFpF?=
 =?utf-8?B?TkEvdlN4bjRBZHIwWUExRldvckJzcGxMSE56WXlrUUprOTlpWm0wTUlmSHlX?=
 =?utf-8?B?VVZaQjhFemVKRXk1c0ZVNnJ2SURNVktlaVFVKzNlbXFTTm9INXJXNkZGRXls?=
 =?utf-8?B?VjVuQ3hqOUpRMXhyVlNWVkpJVklLYkFLUEZ0cjRxWHIyZWNNMnI5VHRaWE9C?=
 =?utf-8?B?bjlFYTZwS2lpdDFTem1VSGFYSm9kOEl2OHZ1N041MHRwWmt5MDcvOC90c0Z5?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7cc524-34d0-4c80-716a-08dd4cc87081
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 07:23:12.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoKLR3auR4Yg0pf9tr9mBD0XPJ4vgXPfxOmm+NmagGJzKmLErt+aFohh1L3Nbmpiw+jXj1E2tZk3yJSzGEqLjcjMTHwBrc+tIvNCWBYQbXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7930
X-OriginatorOrg: intel.com



On 2/13/25 10:34 PM, Reinette Chatre wrote:
> Hi Tony,
> 
> On 2/13/25 10:39 AM, Luck, Tony wrote:
>>> Yes, although there is some hard-to-avoid fuzz about the precise
>>> meaning of "local" and "total".
>>
>> Things are only getting fuzzier with mixed DDR and CXL memory.
>>
>>> As Reinette pointed out, there is the also the possibility of adding
>>> new named events other than "local" and "total" if we find that some
>>> kinds of event don't fit these categories.
>>
>> Not just new names, new scopes too. Patches coming later this year
>> that would present:
>>
>> $ cd sys/fs/resctrl
>> $ cat mon_data/mon_PKG_00/llc_stalls
>> 779762866739
> 
> Thank you for catching this. To support this would not be possible for
> the current plan for mbm_assign_control since it does not have a way
> to distinguish domain X of the PKG resource from domain X of the L3 resource.
> Sounds like we need to include the resource name in the mbm_assign_control
> syntax?

ugh ... please ignore this message. This is not needed since mbm_assign_control
is already associated with the resource.

Reinette

