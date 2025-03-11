Return-Path: <linux-kernel+bounces-555447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FF7A5B789
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99FD41893DFE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161011E9B22;
	Tue, 11 Mar 2025 03:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuHDxOrU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DDE1CA84;
	Tue, 11 Mar 2025 03:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741665098; cv=fail; b=T1C3T+qhIl+14PVyKcoWsRuQCQJdkU3wFddUlRxXu794SZYVqY0EWS6dbFADCzfW4Yg0/yjuEQwji7cw97LZ4bfaUPHUUBvfCgeU3ZmQYhjGfXSxwYUMfIUkSuqsMlaUaDxzrZrdBlMLhrUeNZq8F1qDz1Ge7YpTsGaZdnd2s18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741665098; c=relaxed/simple;
	bh=5hlrjvESXySOkTYcj5rpcNGoLXug+xmRD2HhtlajImk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IZw9TDThz8X7RphhSAVfYoK3DaNLmc0YpZkr+MRXRCDTPeepLg9VusW/V9ribvbiBuCVKgZp90xbLv6xCRPs8Jg7C9oFP2OieJMhD+qQDrxddKNVs65dVLtWmqzoNCSkUvAuiVcy3qFEhIRKqerBWZEpekJX8zOQubYvbNu/B88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuHDxOrU; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741665095; x=1773201095;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5hlrjvESXySOkTYcj5rpcNGoLXug+xmRD2HhtlajImk=;
  b=iuHDxOrUNGA9MmEOmb2iOf1ja+WfFSC2USl4YSpzpk3klNyxmkJEl4dW
   wPwMuJG2cOjXJtXroJ8OKdvbD6ADdsqd9NP34jmKGZVq+1z8qzOMCUrDV
   7FiWObfzJ/+LqDhkxwFPnKv410MGsRckZYPpgjmzycmuerZUkW29senHx
   nbE/5UMHxVSYOWbfYhpIJunbj0pcWNT57BpqAmo1Z6i6OM6V9MgkI7J0Y
   VLKTQeNfII5dxbaLi0tQdqk26eF6E7hWPNW9iWMk3of+GaMJ9H8fdDv4o
   rXi91DDprVV2zF+fVRVyh7PPLVjyxDRSNNlJiAFkgZe/R06cWHCDMZujr
   A==;
X-CSE-ConnectionGUID: ilUfw8wWS7+ALXVX3UyQRw==
X-CSE-MsgGUID: ngxUpOf1QqalV7PvVIgtlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="54062178"
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="54062178"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 20:51:34 -0700
X-CSE-ConnectionGUID: 2nUH/MNUQI60sR1ZPMISvw==
X-CSE-MsgGUID: 12CHVsieSSuchTUdQ6LrVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="120889927"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 20:51:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 20:51:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 20:51:32 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 20:51:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lo68pV32oR36QPTXj/gajSbY30fm/0yj0Die/6G+fU3yzLnbGThDv5MJf11DHR9QZdPHg0JX6Xoeb4o98G4uVWL8leDFFaUvuHwO6WTIgPB1D8RAT76s6bD6APlLGF6Y2XU2Yh2FdmI/8Crs2yN7c428hNMlbOyPzD0ws3AsgYvbheDRp8bAeDuHLiYMMNFQaCj9TBTFnztNk56CTCoIxEx/Ma0EydAVWR+BENyWXwSv062fX+StSISpL49XPSuRdQ85HET8tv71g0BPYL8KDhyoKUpKpLk1x9JmIVkXH1yr8hk/xscwI9nAT6tu9l4eg8RcuYaVIefKMqUonWaIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AiBmSgNNahc3lweLo8RbP+bCG3kBc98mURrok8qiy8=;
 b=iQceYrFf6D37fhU8dsVN7Fauegcy3CoYlwCOvGyNqLJbSK2rwdWe6azJ46MMXMFLjWJw+vfEKePYHR4uzGE51MOe9DUKI0z/TbOuEdJtnxx/xJQnsRMOU9q2BQ8P2f4Vt3U+T15+ZNDH4ZPvTi6xCP3RnGAPhdc++9AFabd4cWAoUbcHM37cCZ8l0h9mDp6GeiilyRDMK5DjXHDQgpo+DIoUx1WC8l1qHt+H1hCIQQ7LZSJdy5u7yvOQUQaHquvy14lAQk/5seBJ8U1DiR2WKONAuYeBqYWqX+kD1Q9U6VErW5OJVv9oKOCDfSxq55XhyWfjZzJ9aqlryzXCu/RS4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB8246.namprd11.prod.outlook.com (2603:10b6:208:445::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 03:51:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 03:51:26 +0000
Message-ID: <6508cf67-3263-432e-892c-9b502b3c6cd4@intel.com>
Date: Mon, 10 Mar 2025 20:51:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: "Moger, Babu" <bmoger@amd.com>, "Luck, Tony" <tony.luck@intel.com>
CC: <babu.moger@amd.com>, Peter Newman <peternewman@google.com>, Dave Martin
	<Dave.Martin@arm.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<akpm@linux-foundation.org>, <thuth@redhat.com>, <rostedt@goodmis.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <jpoimboe@kernel.org>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <xin3.li@intel.com>,
	<andrew.cooper3@citrix.com>, <ebiggers@google.com>,
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
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <04e47d0e-6447-451e-98e4-7ea65187d370@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:303:6b::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f12ff5-fe68-4830-9569-08dd604fffac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU1MeTRuSmFzMUkvV3BINkV1M0xPeWpIWTNvTWhWcDJKd1hqZzVNZ2plUEx4?=
 =?utf-8?B?cDlmSm96QUNmWi9xcThxT2UrejVibWpHN2NjZ1pSNDduNUpkZHp4TFFpODhW?=
 =?utf-8?B?cSt1bDBzb2FLdUFWbkZZS3p5bzRKVmNRdVlGMXFrb3dXdkFha2dMeW1qY0pj?=
 =?utf-8?B?cjk0aDF1amVQQjhmWjJTR2RUNUVFNjdZUzVZOExtbUp2TVBkVlNPVXA4RGgy?=
 =?utf-8?B?N29rNHJpMTZsVUxzbzZ6cFFSRGh3UGJTM1FId0ZDUSsrbmx3MTM3aTMrQzF2?=
 =?utf-8?B?dU5ZUzg0aC9aQVZsNHFpbzFwQzlEeHRKYmpWSDhXYnRSOXJRd0QyT3Jwd2FZ?=
 =?utf-8?B?Mk81V0tKNjBEL0djTW1zeFpORncwYnRXUmVqZjVqTEhvUG9tVlN6K0xNdXkw?=
 =?utf-8?B?VmdvVmpnRXJBUzhnUkhhTysyd0lZOTVUL01LWjZRUnVjRVVBWDBTOUVFS2l2?=
 =?utf-8?B?S0R4WnFOQUk2MTJqZmJQZVp3M2UvNnBUejBYSjk0VVpHTGd4cWErbTZUY0s2?=
 =?utf-8?B?Q2Y0aWtBYUwySEVFU09qS3o4QWZRTk1kMFo1U29VT0J1TWJRZnZlU0dJc3Fh?=
 =?utf-8?B?aWU4M0VnZm9nWmRrQlpaaGtWeU1EbjlVc1JRYk9aZDlXZU91YVBjQUFDdm8r?=
 =?utf-8?B?aWwxQ0ZGcmlKREk3dXFnS2d3WmI5d3pQVE9vZ21zQnQyaGlNdVU2ZFBUOE1V?=
 =?utf-8?B?TEVoTFBWaUxObmJSbVpTTWRnK25YbW9QZVpJRS9OdjJoY01menhCSXExUkgz?=
 =?utf-8?B?cHF2WGRCSWJTbzhDNXFpeTFnYnBvWkJRalhYUHdzSlNaSzIzTUczVUlrUFQ5?=
 =?utf-8?B?eGZtOFg5TkNaU3JqZVBjdFhKanoyVFJseHBnazhCK3BnR05mYmFwNHBMZFpL?=
 =?utf-8?B?NVQzV1pac2UwUnBEUjgra1NIaXQyS1NCTnNRMjFFL05qTFhyTms5Yk9uR1lM?=
 =?utf-8?B?dllGc2FvbW9NbDFvKzZSd2tjTlZrRWdUcXRET3FvM3lKaHR1WDkza2k5M0Z5?=
 =?utf-8?B?cG8rOGwzVldIZDZoUm9Ob3Y3dDYxdldoN081WnBLMlFXWmtqWEhacnNyTFc0?=
 =?utf-8?B?UmZ1UDRjdDRoVXhscGJ0NlB1d2NQWGZ0cWRFc2hDZTZaQ0wyL0NQZUZEajFO?=
 =?utf-8?B?M0NOTG9ETENPeENxWHlEdlFsNzM3ZlRtMTlvbWp6UHp2Z24yQmZpZmtZRTdM?=
 =?utf-8?B?UUZENmQ4ZGs1NW5qWXV0VVcwbDJjWFMwMytITERqbHkxOStkbExqdUo1Mm9D?=
 =?utf-8?B?b2ZRSSsyclorSWpNWnNkcERTb0hyYnBFU3BsNXlteXA4cGh5c0RFVlBuc20z?=
 =?utf-8?B?LzlpcnBoemFvdmtPR0xza2ptTnp2RzFOSmpBeDBadUYwRndRSjhWck5FVDUy?=
 =?utf-8?B?aUw1U3RTN05yalVOdUxkbHZyempzZkluRU84OU5ld2Z1d2FQSEwwZFhQMFYz?=
 =?utf-8?B?U3lUZlAycDNvcFNOUFJaM0EvN3FMckxyREgwbDFLWlJ5R2lzWWd0WklvUDc3?=
 =?utf-8?B?Z3Z3SmpsTmdFYk1uNnh0VUpiMFYxanE3ZWpqajJPcDQzVURQRngrUnJLdmlS?=
 =?utf-8?B?ck5zOFhHcjhIVTkyRUV6ajJFOVlEZERSRXVHWDVWUWtMV3UzTWFwVkFvRDNB?=
 =?utf-8?B?OExhVWg1ZGc3YTZZdEVvNlFDY1AzRTVvc2x6Wm5HWGZJVnhNdTByeFZwVDBY?=
 =?utf-8?B?eHpWeXFkSjNnYysyaHhqaHUycGU2RDFlS2J1NzB4WC9LVnF2RlZlQkxQT2VJ?=
 =?utf-8?B?akJORmZ4b1FoOW11WCs0WmhqdUpqYnBiNkxtdnNJSXNXUmJBd0hrdjhRbmdI?=
 =?utf-8?B?aWp0eUZ0bUpnTDFuR0phY2NpQVNWNXREd01mMXBGNGxZTFczREdLMTQzN1hK?=
 =?utf-8?B?N0hoL3VnQjF1dU5aSWZoRDQxSVEreWVHcXI0bFZBbDdrTFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnliK2xac3lVRUhzQTFrbXVtczFzUEhIaFhSQkp5ME42RzdnekZ3Y2JXYmhP?=
 =?utf-8?B?ZEF1VGpYRGtKY3ovS2dTR1ZLeVgwN09xSUtzVjBxV1VvYk94S0tZeEtGWlBC?=
 =?utf-8?B?Z3A3c2RvaUhCYzBXdU9DWEQrcUJUR3dQN0g0SVlXcUFucEdNbDA1em1oZmQ4?=
 =?utf-8?B?b1BhV1lyaDFTMkJkY3FjUmdIa1k3eThhS0JJY0ZqdmFqY1dweVRqbUpQbWgz?=
 =?utf-8?B?UXN6MkJnYmtuU0xVRXdBWUorQnZ6SDVIdDM2bzRKUitnaXdnRGxyNkxaVzVS?=
 =?utf-8?B?Z3JlSVViTWQrWG1GekFRQmhQU25RNWpKMDlVVm1FRGNRRzNpTEZacGNpVlM5?=
 =?utf-8?B?Z0NMN3BqdGZwMm1uS0MyTjlMVmliNUlCeWd6ZEJNVnBWUlRReW5XZDFpaTl6?=
 =?utf-8?B?bkJXd1ViNXQxVVJORStPdjdLczNIeXRlUlgvNnZYcXJ5V0NxbDVMQkdEbnFN?=
 =?utf-8?B?RkJOaU5CZDRNYk9RR3piWG5OZ0VBUytSME45eDRGdG85MHpQTHg3WXVaSjBC?=
 =?utf-8?B?NVdyVVdTTkkrWlkrV2NiQmh5czU2WEV4SDdsZ043MDk3M0c1TEJJbjlDTW1K?=
 =?utf-8?B?c3k3eUVkbnhmOVFILzdqb09sYW5pZTNGQ1FGMnAyQ0dZTExtWWRVZ0IzdHFw?=
 =?utf-8?B?eGtTSHpHNlo0NW1kdyt0ckxkRjIxM0l4MlZQOStTdE9rdFNrUWtpUG5rSTMy?=
 =?utf-8?B?SXZBTXRzbHdJa3RERXhTVnRibU5iY3NZa1BTMTYzaDd1VlVzY28rcUNTL0Zm?=
 =?utf-8?B?aTM0SGdFQTc5TVBLZU5EdGlNckM5L0QzWTlpWWl0cTVkbEY0dGtaQmZJanp1?=
 =?utf-8?B?ZURvSXVZaU9nWUVHSUpwZUUrbGZYQ0V3MkJObUxLZy9jM0ZVU2liY0NuK1Nw?=
 =?utf-8?B?Y2xoeXJONTRWU2xPcHJWVVZQYjFFNjcweHpZNXJrRURaSGx5cm1qQk5tZEg3?=
 =?utf-8?B?UndtT1FoRzgvVm12MVZ2b0VZcVhLOTFSekQwZ0JKd1NpWVgyTUpwd08zeExC?=
 =?utf-8?B?T3BGYUNXRVZtcDU5OTVxczR2NUVqaFUvaEFjdldXb2xRNERISXY5NVRLR2RB?=
 =?utf-8?B?dXp3b3QvOGRHUHMvS002dXJTTmVYQXBvM0RvUUpKWUUvWU1DS0haRUlaUHRW?=
 =?utf-8?B?UWZqT2Y4YWVIMWF6SGJkeUNtS0dHM1ZRK0F0ZHcyV1IrcEM2eHRWdFJ0M2ZL?=
 =?utf-8?B?SkYzOWxTd2YvbkFHV25UU3BFUXhJOFVpdUMzOGlWWld6NFA5aWg1Z21iS3Jl?=
 =?utf-8?B?SUQzS1hqUnphZDEyNEgyak1ERm5lT1Z1UzZBWm00em0rb1ZiWVlOZVVCMVdT?=
 =?utf-8?B?Si96VzQ5Uk1QaTBYbkhsdlgxZ1JaVWdNekVxS1oyekFjcUN0VDNRQU9PN0VB?=
 =?utf-8?B?L2ZlSENFZHR3NG1aMU94aXRqR01EcU9IcUxxTUQ0aVhsR0liUEpVckUvSVFJ?=
 =?utf-8?B?cUE1NzlYbStQSCt1V2hiaUJqMmtudzlPc2t6MDBwckpwM0N5TFpNTWlaYWJD?=
 =?utf-8?B?R09WOFczRm12TER0cVZ4SVFBZ09OV3BPMGhPVnBuWHplWk4xc2l4RVl2cE1j?=
 =?utf-8?B?Y0hGeUE2RjdnaElvd2R2N0FBUUpWMG9ITG1zWlFMSENQQWZ1VHcvRDFuL1E5?=
 =?utf-8?B?LytnUUphV2EwNURxNEpZRmlja0NHOVdUcWhEME1Jb3ZsVGtKMUNKSyt0WXE3?=
 =?utf-8?B?eWdCdXAvZDdKSXBhVnFCdTdybUZYa3pKcnB6VFE2YlpqanRwb2hCcC9nYUtC?=
 =?utf-8?B?akMyV0hqdDJuZk5lazhoMUVDSkhyMGtPOHNlMmQwV08xZEtYUW1VcWMyaE1U?=
 =?utf-8?B?am1oMnJQckY2aFJub3lYRjBBMWF6SXRzVXg0ekl1eWo2M1MrbzRmVlZUaTJs?=
 =?utf-8?B?RVNtcmRyUVZtTTUxZ1prc3NXcklTVllIZkl3Y2pTUjFDZFAxQUtlQTRKY04w?=
 =?utf-8?B?eHN5MEpoYklqenBiWW9KZ0V2WWJOelhBRUE1a1VIckFxeFpwelcvODdqQVdt?=
 =?utf-8?B?ci94MkpxeE9oVG1EbExNbjVCNGJFUzBOY0ZFdUJqRTNrQUJDT3NIWEtEa21S?=
 =?utf-8?B?ZDZTT3lwcnlMOTR4d3MvdW1aL0RFMUw4RVI5a3ZNWDA3ZGJGT1RVRHQ4VnBr?=
 =?utf-8?B?Sng5TWN5VGZ6TUJKWWZiNkRFQVNXUnhIU1N5cE9vMHE5aE9PYWJyalB0aHBR?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f12ff5-fe68-4830-9569-08dd604fffac
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 03:51:26.6264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcf8yuQXycDuIdkwxhClXzeBLcBwrLjftHq43aVlIuXFGLM5TVG5JZaHWuseGbZBEx/UZCddx+P5+AiRJ2QzyrKe2ZTxhyVojRQQ8drRKHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8246
X-OriginatorOrg: intel.com



On 3/10/25 6:44 PM, Moger, Babu wrote:
> Hi Tony,
> 
> On 3/10/2025 6:22 PM, Luck, Tony wrote:
>> On Mon, Mar 10, 2025 at 05:48:44PM -0500, Moger, Babu wrote:
>>> Hi All,
>>>
>>> On 3/5/2025 1:34 PM, Moger, Babu wrote:
>>>> Hi Peter,
>>>>
>>>> On 3/5/25 04:40, Peter Newman wrote:
>>>>> Hi Babu,
>>>>>
>>>>> On Tue, Mar 4, 2025 at 10:49 PM Moger, Babu <babu.moger@amd.com> wrote:
>>>>>>
>>>>>> Hi Peter,
>>>>>>
>>>>>> On 3/4/25 10:44, Peter Newman wrote:
>>>>>>> On Mon, Mar 3, 2025 at 8:16 PM Moger, Babu <babu.moger@amd.com> wrote:
>>>>>>>>
>>>>>>>> Hi Peter/Reinette,
>>>>>>>>
>>>>>>>> On 2/26/25 07:27, Peter Newman wrote:
>>>>>>>>> Hi Babu,
>>>>>>>>>
>>>>>>>>> On Tue, Feb 25, 2025 at 10:31 PM Moger, Babu <babu.moger@amd.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi Peter,
>>>>>>>>>>
>>>>>>>>>> On 2/25/25 11:11, Peter Newman wrote:
>>>>>>>>>>> Hi Reinette,
>>>>>>>>>>>
>>>>>>>>>>> On Fri, Feb 21, 2025 at 11:43 PM Reinette Chatre
>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Hi Peter,
>>>>>>>>>>>>
>>>>>>>>>>>> On 2/21/25 5:12 AM, Peter Newman wrote:
>>>>>>>>>>>>> On Thu, Feb 20, 2025 at 7:36 PM Reinette Chatre
>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>> On 2/20/25 6:53 AM, Peter Newman wrote:
>>>>>>>>>>>>>>> On Wed, Feb 19, 2025 at 7:21 PM Reinette Chatre
>>>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>>>> On 2/19/25 3:28 AM, Peter Newman wrote:
>>>>>>>>>>>>>>>>> On Tue, Feb 18, 2025 at 6:50 PM Reinette Chatre
>>>>>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>>>>>> On 2/17/25 2:26 AM, Peter Newman wrote:
>>>>>>>>>>>>>>>>>>> On Fri, Feb 14, 2025 at 8:18 PM Reinette Chatre
>>>>>>>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>>>>>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
>>>>>>>>>>>>>>>>>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
>>>>>>>>>>>>>>>>>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
>>>>>>>>>>>>>>>>>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>>>>>>>>>>>>>>>>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>>>>>>>>>>>>>>>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> (quoting relevant parts with goal to focus discussion on new possible syntax)
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> I see the support for MPAM events distinct from the support of assignable counters.
>>>>>>>>>>>>>>>>>>>>>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>>>>>>>>>>>>>>>>>>>>>>> Please help me understand if you see it differently.
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> Doing so would need to come up with alphabetical letters for these events,
>>>>>>>>>>>>>>>>>>>>>>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> mbm_local_read_bytes a
>>>>>>>>>>>>>>>>>>>>>>>> mbm_local_write_bytes b
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> Then mbm_assign_control can be used as:
>>>>>>>>>>>>>>>>>>>>>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>>>>>>>>>>>>>>>>>>>>>>> <value>
>>>>>>>>>>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>>>>>>>>>>>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>>>>>>>>>>>>>>>>>>>>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>>>>>>>>>>>>>>>>>>>>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> As mentioned above, one possible issue with existing interface is that
>>>>>>>>>>>>>>>>>>>> it is limited to 26 events (assuming only lower case letters are used). The limit
>>>>>>>>>>>>>>>>>>>> is low enough to be of concern.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> The events which can be monitored by a single counter on ABMC and MPAM
>>>>>>>>>>>>>>>>>>> so far are combinable, so 26 counters per group today means it limits
>>>>>>>>>>>>>>>>>>> breaking down MBM traffic for each group 26 ways. If a user complained
>>>>>>>>>>>>>>>>>>> that a 26-way breakdown of a group's MBM traffic was limiting their
>>>>>>>>>>>>>>>>>>> investigation, I would question whether they know what they're looking
>>>>>>>>>>>>>>>>>>> for.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> The key here is "so far" as well as the focus on MBM only.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> It is impossible for me to predict what we will see in a couple of years
>>>>>>>>>>>>>>>>>> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctrl interface
>>>>>>>>>>>>>>>>>> to support their users. Just looking at the Intel RDT spec the event register
>>>>>>>>>>>>>>>>>> has space for 32 events for each "CPU agent" resource. That does not take into
>>>>>>>>>>>>>>>>>> account the "non-CPU agents" that are enumerated via ACPI. Tony already mentioned
>>>>>>>>>>>>>>>>>> that he is working on patches [1] that will add new events and shared the idea
>>>>>>>>>>>>>>>>>> that we may be trending to support "perf" like events associated with RMID. I
>>>>>>>>>>>>>>>>>> expect AMD PQoS and Arm MPAM to provide related enhancements to support their
>>>>>>>>>>>>>>>>>> customers.
>>>>>>>>>>>>>>>>>> This all makes me think that resctrl should be ready to support more events than 26.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I was thinking of the letters as representing a reusable, user-defined
>>>>>>>>>>>>>>>>> event-set for applying to a single counter rather than as individual
>>>>>>>>>>>>>>>>> events, since MPAM and ABMC allow us to choose the set of events each
>>>>>>>>>>>>>>>>> one counts. Wherever we define the letters, we could use more symbolic
>>>>>>>>>>>>>>>>> event names.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Thank you for clarifying.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> In the letters as events model, choosing the events assigned to a
>>>>>>>>>>>>>>>>> group wouldn't be enough information, since we would want to control
>>>>>>>>>>>>>>>>> which events should share a counter and which should be counted by
>>>>>>>>>>>>>>>>> separate counters. I think the amount of information that would need
>>>>>>>>>>>>>>>>> to be encoded into mbm_assign_control to represent the level of
>>>>>>>>>>>>>>>>> configurability supported by hardware would quickly get out of hand.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Maybe as an example, one counter for all reads, one counter for all
>>>>>>>>>>>>>>>>> writes in ABMC would look like...
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> (L3_QOS_ABMC_CFG.BwType field names below)
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> (per domain)
>>>>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>>>>    counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>    counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>>>>    counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>    counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>> ...
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I think this may also be what Dave was heading towards in [2] but in that
>>>>>>>>>>>>>>>> example and above the counter configuration appears to be global. You do mention
>>>>>>>>>>>>>>>> "configurability supported by hardware" so I wonder if per-domain counter
>>>>>>>>>>>>>>>> configuration is a requirement?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> If it's global and we want a particular group to be watched by more
>>>>>>>>>>>>>>> counters, I wouldn't want this to result in allocating more counters
>>>>>>>>>>>>>>> for that group in all domains, or allocating counters in domains where
>>>>>>>>>>>>>>> they're not needed. I want to encourage my users to avoid allocating
>>>>>>>>>>>>>>> monitoring resources in domains where a job is not allowed to run so
>>>>>>>>>>>>>>> there's less pressure on the counters.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> In Dave's proposal it looks like global configuration means
>>>>>>>>>>>>>>> globally-defined "named counter configurations", which works because
>>>>>>>>>>>>>>> it's really per-domain assignment of the configurations to however
>>>>>>>>>>>>>>> many counters the group needs in each domain.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I think I am becoming lost. Would a global configuration not break your
>>>>>>>>>>>>>> view of "event-set applied to a single counter"? If a counter is configured
>>>>>>>>>>>>>> globally then it would not make it possible to support the full configurability
>>>>>>>>>>>>>> of the hardware.
>>>>>>>>>>>>>> Before I add more confusion, let me try with an example that builds on your
>>>>>>>>>>>>>> earlier example copied below:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> (per domain)
>>>>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>>>>    counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>    counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>>>>    counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>    counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>> ...
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Since the above states "per domain" I rewrite the example to highlight that as
>>>>>>>>>>>>>> I understand it:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>     counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>    domain 1:
>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>     counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>    domain 1:
>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> You mention that you do not want counters to be allocated in domains that they
>>>>>>>>>>>>>> are not needed in. So, let's say group 0 does not need counter 0 and counter 1
>>>>>>>>>>>>>> in domain 1, resulting in:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>     counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>    domain 1:
>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> With counter 0 and counter 1 available in domain 1, these counters could
>>>>>>>>>>>>>> theoretically be configured to give group 1 more data in domain 1:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>     counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>    domain 1:
>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill
>>>>>>>>>>>>>>     counter 1: LclNTWr,RmtNTWr
>>>>>>>>>>>>>>     counter 2: LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>     counter 3: VictimBW
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The counters are shown with different per-domain configurations that seems to
>>>>>>>>>>>>>> match with earlier goals of (a) choose events counted by each counter and
>>>>>>>>>>>>>> (b) do not allocate counters in domains where they are not needed. As I
>>>>>>>>>>>>>> understand the above does contradict global counter configuration though.
>>>>>>>>>>>>>> Or do you mean that only the *name* of the counter is global and then
>>>>>>>>>>>>>> that it is reconfigured as part of every assignment?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Yes, I meant only the *name* is global. I assume based on a particular
>>>>>>>>>>>>> system configuration, the user will settle on a handful of useful
>>>>>>>>>>>>> groupings to count.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Perhaps mbm_assign_control syntax is the clearest way to express an example...
>>>>>>>>>>>>>
>>>>>>>>>>>>>    # define global configurations (in ABMC terms), not necessarily in this
>>>>>>>>>>>>>    # syntax and probably not in the mbm_assign_control file.
>>>>>>>>>>>>>
>>>>>>>>>>>>>    r=LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>    w=VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>
>>>>>>>>>>>>>    # legacy "total" configuration, effectively r+w
>>>>>>>>>>>>>    t=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>
>>>>>>>>>>>>>    /group0/0=t;1=t
>>>>>>>>>>>>>    /group1/0=t;1=t
>>>>>>>>>>>>>    /group2/0=_;1=t
>>>>>>>>>>>>>    /group3/0=rw;1=_
>>>>>>>>>>>>>
>>>>>>>>>>>>> - group2 is restricted to domain 0
>>>>>>>>>>>>> - group3 is restricted to domain 1
>>>>>>>>>>>>> - the rest are unrestricted
>>>>>>>>>>>>> - In group3, we decided we need to separate read and write traffic
>>>>>>>>>>>>>
>>>>>>>>>>>>> This consumes 4 counters in domain 0 and 3 counters in domain 1.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I see. Thank you for the example.
>>>>>>>>>>>>
>>>>>>>>>>>> resctrl supports per-domain configurations with the following possible when
>>>>>>>>>>>> using mbm_total_bytes_config and mbm_local_bytes_config:
>>>>>>>>>>>>
>>>>>>>>>>>> t(domain 0)=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>> t(domain 1)=LclFill,RmtFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>
>>>>>>>>>>>>      /group0/0=t;1=t
>>>>>>>>>>>>      /group1/0=t;1=t
>>>>>>>>>>>>
>>>>>>>>>>>> Even though the flags are identical in all domains, the assigned counters will
>>>>>>>>>>>> be configured differently in each domain.
>>>>>>>>>>>>
>>>>>>>>>>>> With this supported by hardware and currently also supported by resctrl it seems
>>>>>>>>>>>> reasonable to carry this forward to what will be supported next.
>>>>>>>>>>>
>>>>>>>>>>> The hardware supports both a per-domain mode, where all groups in a
>>>>>>>>>>> domain use the same configurations and are limited to two events per
>>>>>>>>>>> group and a per-group mode where every group can be configured and
>>>>>>>>>>> assigned freely. This series is using the legacy counter access mode
>>>>>>>>>>> where only counters whose BwType matches an instance of QOS_EVT_CFG_n
>>>>>>>>>>> in the domain can be read. If we chose to read the assigned counter
>>>>>>>>>>> directly (QM_EVTSEL[ExtendedEvtID]=1, QM_EVTSEL[EvtID]=L3CacheABMC)
>>>>>>>>>>> rather than asking the hardware to find the counter by RMID, we would
>>>>>>>>>>> not be limited to 2 counters per group/domain and the hardware would
>>>>>>>>>>> have the same flexibility as on MPAM.
>>>>>>>>>>
>>>>>>>>>> In extended mode, the contents of a specific counter can be read by
>>>>>>>>>> setting the following fields in QM_EVTSEL: [ExtendedEvtID]=1,
>>>>>>>>>> [EvtID]=L3CacheABMC and setting [RMID] to the desired counter ID. Reading
>>>>>>>>>> QM_CTR will then return the contents of the specified counter.
>>>>>>>>>>
>>>>>>>>>> It is documented below.
>>>>>>>>>> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
>>>>>>>>>>    Section: 19.3.3.3 Assignable Bandwidth Monitoring (ABMC)
>>>>>>>>>>
>>>>>>>>>> We previously discussed this with you (off the public list) and I
>>>>>>>>>> initially proposed the extended assignment mode.
>>>>>>>>>>
>>>>>>>>>> Yes, the extended mode allows greater flexibility by enabling multiple
>>>>>>>>>> counters to be assigned to the same group, rather than being limited to
>>>>>>>>>> just two.
>>>>>>>>>>
>>>>>>>>>> However, the challenge is that we currently lack the necessary interfaces
>>>>>>>>>> to configure multiple events per group. Without these interfaces, the
>>>>>>>>>> extended mode is not practical at this time.
>>>>>>>>>>
>>>>>>>>>> Therefore, we ultimately agreed to use the legacy mode, as it does not
>>>>>>>>>> require modifications to the existing interface, allowing us to continue
>>>>>>>>>> using it as is.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> (I might have said something confusing in my last messages because I
>>>>>>>>>>> had forgotten that I switched to the extended assignment mode when
>>>>>>>>>>> prototyping with soft-ABMC and MPAM.)
>>>>>>>>>>>
>>>>>>>>>>> Forcing all groups on a domain to share the same 2 counter
>>>>>>>>>>> configurations would not be acceptable for us, as the example I gave
>>>>>>>>>>> earlier is one I've already been asked about.
>>>>>>>>>>
>>>>>>>>>> I don’t see this as a blocker. It should be considered an extension to the
>>>>>>>>>> current ABMC series. We can easily build on top of this series once we
>>>>>>>>>> finalize how to configure the multiple event interface for each group.
>>>>>>>>>
>>>>>>>>> I don't think it is, either. Only being able to use ABMC to assign
>>>>>>>>> counters is fine for our use as an incremental step. My longer-term
>>>>>>>>> concern is the domain-scoped mbm_total_bytes_config and
>>>>>>>>> mbm_local_bytes_config files, but they were introduced with BMEC, so
>>>>>>>>> there's already an expectation that the files are present when BMEC is
>>>>>>>>> supported.
>>>>>>>>>
>>>>>>>>> On ABMC hardware that also supports BMEC, I'm concerned about enabling
>>>>>>>>> ABMC when only the BMEC-style event configuration interface exists.
>>>>>>>>> The scope of my issue is just whether enabling "full" ABMC support
>>>>>>>>> will require an additional opt-in, since that could remove the BMEC
>>>>>>>>> interface. If it does, it's something we can live with.
>>>>>>>>
>>>>>>>> As you know, this series is currently blocked without further feedback.
>>>>>>>>
>>>>>>>> I’d like to begin reworking these patches to incorporate Peter’s feedback.
>>>>>>>> Any input or suggestions would be appreciated.
>>>>>>>>
>>>>>>>> Here’s what we’ve learned so far:
>>>>>>>>
>>>>>>>> 1. Assignments should be independent of BMEC.
>>>>>>>> 2. We should be able to specify multiple event types to a counter (e.g.,
>>>>>>>> read, write, victimBM, etc.). This is also called shared counter
>>>>>>>> 3. There should be an option to assign events per domain.
>>>>>>>> 4. Currently, only two counters can be assigned per group, but the design
>>>>>>>> should allow flexibility to assign more in the future as the interface
>>>>>>>> evolves.
>>>>>>>> 5. Utilize the extended RMID read mode.
>>>>>>>>
>>>>>>>>
>>>>>>>> Here is my proposal using Peter's earlier example:
>>>>>>>>
>>>>>>>> # define event configurations
>>>>>>>>
>>>>>>>> ========================================================
>>>>>>>> Bits    Mnemonics       Description
>>>>>>>> ====   ========================================================
>>>>>>>> 6       VictimBW        Dirty Victims from all types of memory
>>>>>>>> 5       RmtSlowFill     Reads to slow memory in the non-local NUMA domain
>>>>>>>> 4       LclSlowFill     Reads to slow memory in the local NUMA domain
>>>>>>>> 3       RmtNTWr         Non-temporal writes to non-local NUMA domain
>>>>>>>> 2       LclNTWr         Non-temporal writes to local NUMA domain
>>>>>>>> 1       mtFill          Reads to memory in the non-local NUMA domain
>>>>>>>> 0       LclFill         Reads to memory in the local NUMA domain
>>>>>>>> ====    ========================================================
>>>>>>>>
>>>>>>>> #Define flags based on combination of above event types.
>>>>>>>>
>>>>>>>> t = LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>>> l = LclFill, LclNTWr, LclSlowFill
>>>>>>>> r = LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>> w = VictimBW,LclNTWr,RmtNTWr
>>>>>>>> v = VictimBW
>>>>>>>>
>>>>>>>> Peter suggested the following format earlier :
>>>>>>>>
>>>>>>>> /group0/0=t;1=t
>>>>>>>> /group1/0=t;1=t
>>>>>>>> /group2/0=_;1=t
>>>>>>>> /group3/0=rw;1=_
>>>>>>>
>>>>>>> After some inquiries within Google, it sounds like nobody has invested
>>>>>>> much into the current mbm_assign_control format yet, so it would be
>>>>>>> best to drop it and distribute the configuration around the filesystem
>>>>>>> hierarchy[1], which should allow us to produce something more flexible
>>>>>>> and cleaner to implement.
>>>>>>>
>>>>>>> Roughly what I had in mind:
>>>>>>>
>>>>>>> Use mkdir in a info/<resource>_MON subdirectory to create free-form
>>>>>>> names for the assignable configurations rather than being restricted
>>>>>>> to single letters.  In the resulting directory, populate a file where
>>>>>>> we can specify the set of events the config should represent. I think
>>>>>>> we should use symbolic names for the events rather than raw BMEC field
>>>>>>> values. Moving forward we could come up with portable names for common
>>>>>>> events and only support the BMEC names on AMD machines for users who
>>>>>>> want specific events and don't care about portability.
>>>>>>
>>>>>>
>>>>>> I’m still processing this. Let me start with some initial questions.
>>>>>>
>>>>>> So, we are creating event configurations here, which seems reasonable.
>>>>>>
>>>>>> Yes, we should use portable names and are not limited to BMEC names.
>>>>>>
>>>>>> How many configurations should we allow? Do we know?
>>>>>
>>>>> Do we need an upper limit?
>>>>
>>>> I think so. This needs to be maintained in some data structure. We can
>>>> start with 2 default configurations for now.

There is a big difference between no upper limit and 2. The hardware is
capable of supporting per-domain configurations so more flexibility is
certainly possible. Consider the example presented by Peter in:
https://lore.kernel.org/lkml/CALPaoCi0mFZ9TycyNs+SCR+2tuRJovQ2809jYMun4HtC64hJmA@mail.gmail.com/

>>>>>>> Next, put assignment-control file nodes in per-domain directories
>>>>>>> (i.e., mon_data/mon_L3_00/assign_{exclusive,shared}). Writing a
>>>>>>> counter-configuration name into the file would then allocate a counter
>>>>>>> in the domain, apply the named configuration, and monitor the parent
>>>>>>> group-directory. We can also put a group/resource-scoped assign_* file
>>>>>>> higher in the hierarchy to make it easier for users who want to
>>>>>>> configure all domains the same for a group.
>>>>>>
>>>>>> What is the difference between shared and exclusive?
>>>>>
>>>>> Shared assignment[1] means that non-exclusively-assigned counters in
>>>>> each domain will be scheduled round-robin to the groups requesting
>>>>> shared access to a counter. In my tests, I assigned the counters long
>>>>> enough to produce a single 1-second MB/s sample for the per-domain
>>>>> aggregation files[2].
>>>>>
>>>>> These do not need to be implemented immediately, but knowing that they
>>>>> work addresses the overhead and scalability concerns of reassigning
>>>>> counters and reading their values.
>>>>
>>>> Ok. Lets focus on exclusive assignments for now.
>>>>
>>>>>
>>>>>>
>>>>>> Having three files—assign_shared, assign_exclusive, and unassign—for each
>>>>>> domain seems excessive. In a system with 32 groups and 12 domains, this
>>>>>> results in 32 × 12 × 3 files, which is quite large.
>>>>>>
>>>>>> There should be a more efficient way to handle this.
>>>>>>
>>>>>> Initially, we started with a group-level file for this interface, but it
>>>>>> was rejected due to the high number of sysfs calls, making it inefficient.
>>>>>
>>>>> I had rejected it due to the high-frequency of access of a large
>>>>> number of files, which has since been addressed by shared assignment
>>>>> (or automatic reassignment) and aggregated mbps files.
>>>>
>>>> I think we should address this as well. Creating three extra files for
>>>> each group isn’t ideal when there are more efficient alternatives.
>>>>
>>>>>
>>>>>>
>>>>>> Additionally, how can we list all assignments with a single sysfs call?
>>>>>>
>>>>>> That was another problem we need to address.
>>>>>
>>>>> This is not a requirement I was aware of. If the user forgot where
>>>>> they assigned counters (or forgot to disable auto-assignment), they
>>>>> can read multiple sysfs nodes to remind themselves.
>>>>
>>>> I suggest, we should provide users with an option to list the assignments
>>>> of all groups in a single command. As the number of groups increases, it
>>>> becomes cumbersome to query each group individually.
>>>>
>>>> To achieve this, we can reuse our existing mbm_assign_control interface
>>>> for this purpose. More details on this below.
>>>>
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> The configuration names listed in assign_* would result in files of
>>>>>>> the same name in the appropriate mon_data domain directories from
>>>>>>> which the count values can be read.
>>>>>>>
>>>>>>>    # mkdir info/L3_MON/counter_configs/mbm_local_bytes
>>>>>>>    # echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>>>>    # echo LclNTWr > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>>>>    # echo LclSlowFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>>>>    # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>>>> LclFill
>>>>>>> LclNTWr
>>>>>>> LclSlowFill
>>>>>>
>>>>>> I feel we can just have the configs. event_filter file is not required.
>>>>>
>>>>> That's right, I forgot that we can implement kernfs_ops::open(). I was
>>>>> only looking at struct kernfs_syscall_ops
>>>>>
>>>>>>
>>>>>> #cat info/L3_MON/counter_configs/mbm_local_bytes
>>>>>> LclFill <-rename these to generic names.
>>>>>> LclNTWr
>>>>>> LclSlowFill
>>>>>>
>>>>>
>>>>> I think portable and non-portable event names should both be available
>>>>> as options. There are simple bandwidth measurement mechanisms that
>>>>> will be applied in general, but when they turn up an issue, it can
>>>>> often lead to a more focused investigation, requiring more precise
>>>>> events.
>>>>
>>>> I aggree. We should provide both portable and non-portable event names.
>>>>
>>>> Here is my draft proposal based on the discussion so far and reusing some
>>>> of the current interface. Idea here is to start with basic assigment
>>>> feature with options to enhance it in the future. Feel free to
>>>> comment/suggest.
>>>>
>>>> 1. Event configurations will be in
>>>>      /sys/fs/resctrl/info/L3_MON/counter_configs/.
>>>>
>>>>      There will be two pre-defined configurations by default.
>>>>
>>>>      #cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_total_bytes
>>>>      LclFill, LclNTWr,LclSlowFill,VictimBM,RmtSlowFill,LclSlowFill,RmtFill
>>>>
>>>>      #cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
>>>>      LclFill, LclNTWr, LclSlowFill
>>>>
>>>> 2. Users will have options to update these configurations.
>>>>
>>>>      #echo "LclFill, LclNTWr, RmtFill" >
>>>>         /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
>>
>> This part seems odd to me. Now the "mbm_local_bytes" files aren't
>> reporting "local_bytes" any more. They report something different,
>> and users only know if they come to check the options currently
>> configured in this file. Changing the contents without changing
>> the name seems confusing to me.
> 
> It is the same behaviour right now with BMEC. It is configurable.
> By default it is mbm_local_bytes, but users can configure whatever they want to monitor using /info/L3_MON/mbm_local_bytes_config.
> 
> We can continue the same behaviour with ABMC, but the configuration will be in /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes.

This could be supported by following Peter's original proposal where the name
of the counter configuration is provided by the user via a mkdir:
https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/

As he mentioned there could be pre-populated mbm_local_bytes/mbm_total_bytes.

> 
>>
>>>>
>>>>      # #cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
>>>>      LclFill, LclNTWr, RmtFill
>>>>
>>>> 3. The default configurations will be used when user mounts the resctrl.
>>>>
>>>>      mount  -t resctrl resctrl /sys/fs/resctrl/
>>>>      mkdir /sys/fs/resctrl/test/
>>>>
>>>> 4. The resctrl group/domains can be in one of these assingnment states.
>>>>      e: Exclusive
>>>>      s: Shared
>>>>      u: Unassigned
>>>>
>>>>      Exclusive mode is supported now. Shared mode will be supported in the
>>>> future.
>>>>
>>>> 5. We can use the current /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>> to list the assignment state of all the groups.
>>>>
>>>>      Format:
>>>>      "<CTRL_MON group>/<MON group>/<confguration>:<domain_id>=<assign state>"
>>>>
>>>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>      test//mbm_total_bytes:0=e;1=e
>>>>      test//mbm_local_bytes:0=e;1=e
>>>>      //mbm_total_bytes:0=e;1=e
>>>>      //mbm_local_bytes:0=e;1=e

This would make mbm_assign_control even more unwieldy and quicker to exceed a
page of data (these examples never seem to reflect those AMD systems with the many
L3 domains). How to handle resctrl files larger than 4KB needs to be well understood
and solved when/if going this route.

There seems to be two opinions about this file at moment. Would it be possible to
summarize the discussion with pros/cons raised to make an informed selection?
I understand that Google as represented by Peter no longer requires/requests this
file but the motivation for this change seems new and does not seem to reduce the
original motivation for this file. We may also want to separate requirements for reading
from and writing to this file.

>>>>
>>>> 6. Users can modify the assignment state by writing to mbm_assign_control.
>>>>
>>>>      Format:
>>>>      “<CTRL_MON group>/<MON group>/<configuration>:<domain_id>=<assign state>”
>>>>
>>>>      #echo "test//mbm_local_bytes:0=e;1=e" >
>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>
>>>>      #echo "test//mbm_local_bytes:0=u;1=u" >
>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>
>>>>      # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>      test//mbm_total_bytes:0=u;1=u
>>>>      test//mbm_local_bytes:0=u;1=u
>>>>      //mbm_total_bytes:0=e;1=e
>>>>      //mbm_local_bytes:0=e;1=e
>>>>
>>>>      The corresponding events will be read in
>>>>
>>>>      /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>>>      /sys/fs/resctrl/mon_data/mon_L3_01/mbm_total_bytes
>>>>      /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>      /sys/fs/resctrl/mon_data/mon_L3_01/mbm_local_bytes
>>>>      /sys/fs/resctrl/test/mon_data/mon_L3_00/mbm_total_bytes
>>>>      /sys/fs/resctrl/test/mon_data/mon_L3_01/mbm_total_bytes
>>>>      /sys/fs/resctrl/test/mon_data/mon_L3_00/mbm_local_bytes
>>>>      /sys/fs/resctrl/test/mon_data/mon_L3_01/mbm_local_bytes
>>>>
>>>> 7. In the first stage, only two configurations(mbm_total_bytes and
>>>> mbm_local_bytes) will be supported.
>>>>
>>>> 8. In the future, there will be options to create multiple configurations
>>>> and corresponding directory will be created in
>>>> /sysf/fs/resctrl/test/mon_data/mon_L3_00/<configation name>.
>>
>> Would this be done by creating a new file in the /sys/fs/resctrl/info/L3_MON/counter_configs
>> directory? Like this:
>>
>> # echo "LclFill, LclNTWr, RmtFill" >
>>          /sys/fs/resctrl/info/L3_MON/counter_configs/cache_stuff
>>
>> This seems OK (dependent on the user picking meaningful names for
>> the set of attributes picked ... but if they want to name this
>> monitor file "brian" then they have to live with any confusion
>> that they bring on themselves).
>>
>> Would this involve an extension to kernfs? I don't see a function
>> pointer callback for file creation in kernfs_syscall_ops.
>>
>>>>
>>>
>>> I know you are all busy with multiple series going on parallel. I am still
>>> waiting for the inputs on this. It will be great if you can spend some time
>>> on this to see if we can find common ground on the interface.
>>>
>>> Thanks
>>> Babu
>>
>> -Tony
>>
> 
> 
> thanks
> Babu

Reinette


