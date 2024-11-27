Return-Path: <linux-kernel+bounces-423861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E30F59DAD93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26576166728
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9A21F5FD;
	Wed, 27 Nov 2024 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4CNZ2Md"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575051FF604;
	Wed, 27 Nov 2024 19:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732734342; cv=fail; b=bUWBLW6c4dQdVV2gus4THzx0+jRkqfLEkqHwpjWcBC0EmgEokafRwAFFYj7NZ+6ZFB6fxcE46HfZ3ociGIwIhPaAdO4lEmHXpM5v5mzhSbOr4+6SR7c7hf9SZrmrv+TjbII0rr6nB3+Xo/3mXzNsszTIV0Udg7c0Mv1iQfIILT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732734342; c=relaxed/simple;
	bh=NFgItCiZywtUNj/n0bmRHT90iSHuiSd3V0CUuLm46ac=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qlii9YHZ8EK9220MqQ6GJ5b3JDWXUwdABEVDOiqHsFVuVKt4u9le6s8p6jxI7nMwK17JL4ar55+Ga9Q2ca1cjCHF7y+RLtZpkm81BwpJAdA8WM/GBvD6ZFmC9KE/9AN555O6OY4l+yO4J23x8pagG4Y4W/8EBSTkMS7NIzSem0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4CNZ2Md; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732734340; x=1764270340;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NFgItCiZywtUNj/n0bmRHT90iSHuiSd3V0CUuLm46ac=;
  b=E4CNZ2MdG3ELrd1+GRVK1+TWXLaBKkQ64s6cRGvke5iJtz9e5kNf1ndR
   RMBiuKuN9q/wv6E+o2/OUZi+D3LeMa6K+N5CMob2I7Bxj71Uea1SYn7oQ
   4JQuE2qtKzQsT/T+GcBEtFebNYi9eSmVGq6eIMMoGvYQddIN5JQA6ymf6
   4iXySb55NXy3uw3pqGcMw0VgraJlUQr2VzOgs+577JK6K1/upf+qEJApd
   k29c7V0fwfDsbABJjhxcPqzEurgCAyVA6AxgB1L6eX2xDzTSXxXeAZWAP
   vRzCNt6xREt4f/ncI5oQLrVmJL/yvZ0vqv9R7tCwsZStHKxAdk+x971nY
   A==;
X-CSE-ConnectionGUID: rdOVur7BRB+8zjTjoPEthg==
X-CSE-MsgGUID: U0pmVAznQ1iwUgXOxwRPIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="44332114"
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="44332114"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 11:05:39 -0800
X-CSE-ConnectionGUID: lJx92AAKR6G8T681xv+mFw==
X-CSE-MsgGUID: 60nL6Qo+QNSwnaCfHqrJBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="129535440"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2024 11:05:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 27 Nov 2024 11:05:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 27 Nov 2024 11:05:38 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 11:05:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZG9lksn3AJkJZiIsLU1psBEdVTWCC6dAhP31EDGQ6o7vMXwoBMb3iwQKcTq46/F6RycfxCY+Qo7hs5crVj5a6zNwQoZEsQnYuFYIbz3Hhp683kcnRgvqpZ3gZB9ZBg037fBtbOx3Otxgr26grVqWO8C3ml1N+3qXWbmDz+S+3uTuMYDPIyOuYA4o8arewxyxgs8eZTNbFDZq84IDe5gj3ER9io9FypaO8hFUoOnlScM6zKxmEJucVjm+j9cmjJHE7TdQGAajX/4URdJ7cYt1IGJzbuddDtXf27KU1XcvXzfJDnYQkLF7QL0Thl2ZJlB7Lv4oR3tZW7Xvx9dGW1OHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVSUC1hBy7Qwqh4fapIFjD6NPBgqLDPCmrNyz6GQsiA=;
 b=K02UeVwsIdJj761Lvii7+vbzlC2/W8ftTwO8tLznFuAu+TVjt55/aQ93GrjtsrslbtxvbkmHxgMpVcGaMqD+VNWNt2SjZhObfYcluhteVKvCAWKH9YVlGNsanEU2hlV3PAwrE9GUF5K3GBU+EAlYN8442TYA077NDYjQZmPmSp1T4W6l1Tmj9jg7vcHs8b/FdZuGq5pDWTUoFM7jxbyfcrktcYgMsckRss61XshgKg9eUIYl+Zf8EQtxnhNIKtfNLK6VpW1d1dJy1iMoKi6tG12WjDVOybJvxunNipjmixmNxbn4MHoVBtc/6oHacZehd1JVN51TQA+X7BKZcDvNOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM3PR11MB8672.namprd11.prod.outlook.com (2603:10b6:0:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 19:05:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8182.018; Wed, 27 Nov 2024
 19:05:33 +0000
Message-ID: <5aa7924d-b27d-4ee6-b8dd-4bae0e25267b@intel.com>
Date: Wed, 27 Nov 2024 11:05:30 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <jithu.joseph@intel.com>,
	<brijesh.singh@amd.com>, <xin3.li@intel.com>, <ebiggers@google.com>,
	<andrew.cooper3@citrix.com>, <mario.limonciello@amd.com>,
	<james.morse@arm.com>, <tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>, <jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
 <0dc08082-0f3f-4acc-9285-b925a4ce3b02@intel.com>
 <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
 <c587f94a-7920-49cf-94b1-4c52140db914@intel.com>
 <ef92f1fb-086c-4ee1-b8ec-e08ed68f963a@amd.com>
 <e065b193-dbcc-451b-98db-68a5a69e6ae0@intel.com>
 <20959b58-a882-4ef7-bd11-e8bb0a998945@amd.com>
 <1a93f4e3-d3d2-4764-90d1-728b9cb70481@intel.com>
 <36d8fe9f-0000-4d0d-a097-efddc3881a2a@amd.com>
Content-Language: en-US
In-Reply-To: <36d8fe9f-0000-4d0d-a097-efddc3881a2a@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:303:6b::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM3PR11MB8672:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ca0f3a-5f3a-4f14-7273-08dd0f1677fc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnZrWXVLZnBBanpFSGgxaXc0eTI0b3RBTHRqRzRhaUhPVWZXR1FDRTJvMlhK?=
 =?utf-8?B?a29RTXQ4cjhwWE9iZ3k5ME9ndjQwNmo1RjBUeGZTc3o1UHFqeW1meS9NT2Nz?=
 =?utf-8?B?WkxqSW5zU3JvdHNFSDNKZmlnN2xac3VZeGIwb3RlQ2xHSVRiNFRKVnZSWWZo?=
 =?utf-8?B?RUtENzR2L2R5MVNsT2g4cEM0QVJNYzBoVkFta2RFd2NVd2R4VS84UFdLMUw0?=
 =?utf-8?B?NWI0aW5WeXlDTGVOd1gyOFpCRlBsRTNpcVZDTTBPOU9TVHpKbWgzdnRFSXRY?=
 =?utf-8?B?bHZndDJ6RndPVVF5enhnOTJ5QzRLN0thM3pkTHk5aWNPTWIySXA4QTdHbTZV?=
 =?utf-8?B?UENmdTdQdVFyeGxkazE1KzFZbExiV0YrWlM1Sno1NWZiNThROG9VY21WOGpr?=
 =?utf-8?B?S2NEd0dXeE8rTTh2R3Qwc3pERjgwYXJ5TGFYRmJsUENUdDRHSG43Rk9WMXUx?=
 =?utf-8?B?RFpVbms2dzFLb1RqTjYwcS81dks5Qk5nam9VejVxWGIyVlB5WjRHelFkWnRa?=
 =?utf-8?B?SUxWVnpLR1ZOS0ltS251UnZhWmtld3ErVXVhU1hUbW94VWhYNHZ6L09LRXRI?=
 =?utf-8?B?Ty8wRzNDZWh3TTRWVWdEd1FvdFM2L3NCL0hJTVRrazIwU3JDUWtQNDRUcUNi?=
 =?utf-8?B?VThjTktFT1IwcU5JQnJoSytZMU9VTVlISHE1cUViYSs1NmNLR3h6OEIyOUY1?=
 =?utf-8?B?b1c1R1VCc2UwZUZTTE9KMEh1aHZyMngveitlWXBzb3ZFMmZRZ1JPcnFScjFu?=
 =?utf-8?B?YksrcmczRUtERzEvWW1UOHdiY05ZS01ublFZSGNJYUhFVXVNamR1d1loc0Q2?=
 =?utf-8?B?ZlU3ME9KZ1ErOERFN3lseGlLT1RsOGxOWTByODZzREFRVmZPVXJtUlJnR2lF?=
 =?utf-8?B?V2FuTnk5RzRkRlpRTG45U0lZVnkxaktCNU1KY1RrS3V2RlhxMmJZQkpyaFJi?=
 =?utf-8?B?VTFicTVxOFZFNW9maUNlY3JDbjUwRUxNcTlVQktXY2N6VzZMU0tORFQzTUxh?=
 =?utf-8?B?SjhBeGFoV1E3WnZVazJUVGdLbC8wYnpjNmhXMHpjT1p4aHB5QnpwdkVvNkFN?=
 =?utf-8?B?SUlydkNjN0k4M3hqQ1kzcHFSRWRGVXhyNWE5clEyZVR1Qm1aWktIcmtUVFZ2?=
 =?utf-8?B?c1dNNFdySVhhRGNwRVBqZVkzZ1FLMmZDT1dwM3ZKdFR6YmZkZ0FLbkdCc0c0?=
 =?utf-8?B?cnBCbVVvNCtnUHhCcmE0dmtoSTlQVFhhM3Bpa1hWYStXWHJhK0pTR0IzZ3Vj?=
 =?utf-8?B?emk5RktqOXdDODZYNnczZjdqeElQS2RoWFdFYWVCdGI4VGEwOUhwak9RWFY4?=
 =?utf-8?B?bGw4aEZtRDF4dEVOcHowQ0dSdDdTS05ZNk9oVjFnRmZRdlB6Z3B2VyswWUhT?=
 =?utf-8?B?Rk9nTXQyRmMwUDBoR1JSVW1uaTRDQVdBTFVlUUlINzZJeFlOcnZWL1hYNEJu?=
 =?utf-8?B?K2FoVmQwMkZCTnpIRHFsekUzbUVseE1pbFZhVjVVQTY3alBob25TbjBBUkxK?=
 =?utf-8?B?LzhHMmVUL05Vc0VoeHkxeUE4MjBIb3Z6MXlPeUNvWUpjQ2ZScFY1UkRlZlE0?=
 =?utf-8?B?TlFHRFQ2Nm5KS25xbGRzdVlQVkpzTExkYjN5b0ljQ2V3R2wyWlBzbE42dVQz?=
 =?utf-8?B?REFQQlJrZmlMR0NTMU9zbFBzTnJGZy9HemVjd2tuR1BJbkxJVFpSb1dmR2tq?=
 =?utf-8?B?U3FMbnlQc29aSStqdDZoa29PdWZ5blJNS0o5TGJrazNyVWsySXZFQkQxUS9Y?=
 =?utf-8?B?MWlLdmdIQU45aGl6YXg2ZHRVSHV1cklNTkdnNDNuMUxtdHJQSGtUUmJ2VjZy?=
 =?utf-8?Q?NMuNFwen9AFq6su+SK1vbwOP1goKyLxVne03I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmN6TUtodnZpRWVJbXRqbzFCNVRXWDViQU85OEtpRFlVQU1aMmNmb285cUUv?=
 =?utf-8?B?dHFzWTgrWjhwR1hCeEUyTUZTQk43RTRoalp6cnczNW4yRG5uREliczBwZlo3?=
 =?utf-8?B?cTRtdHQ4bUhyV0syMzhSY1UxaGx1b2FDZy8vRU16dWl3Q21JUkZQa3h4RjB5?=
 =?utf-8?B?cjVPNitXc2tWdUxzdk9SUXFWN0paaU9nRHhhZ3h3RnBzWHNhYTBaNVVhcy9n?=
 =?utf-8?B?aThaQkdlZmRVNDlGZjJ2ZVRCcmhKZCtwRlV1V3FqaXBLU2tTWlBFd1ZQU0NQ?=
 =?utf-8?B?d0NYSU05eEZZTnBxR0FRRWVSdlZWZjhETXNwRzZBejk1VGFxUk9TT1o0c3RN?=
 =?utf-8?B?Nm0yK3U5Y0ZDL1l3WDllMGpsblYyLzhJa2FENjJWN0NWbDdBTm41OUVLV0tp?=
 =?utf-8?B?cmpnZUc1Q2Z6UVJCYlA3eG4wQTBSQlpSNVNuY2tZcCs3MEZkdlNjRm9CTk5U?=
 =?utf-8?B?V01IMUlIeGJsbTE0RkgwakdUSU9GTXVlOHZjRnZReTM5UlNwVXlBSktMSWov?=
 =?utf-8?B?aDNraXpqKzBzVTRVQ0NXQ2U5M2tzcEJRQkx1Z1d4dXBsTkRaZVdJVGE2Ry9G?=
 =?utf-8?B?R3dBc0dSN3FCRlE4YUZpeEtUTjBiQW8yb09CS1QxQk5nN2J1aFFpK2dkUmtV?=
 =?utf-8?B?U0ZONm1tNm5IQnV4Q2ZXcFduNzdiUGlya0xIVEhiRkNWNDYwVHpvdmc2aDhZ?=
 =?utf-8?B?MCtwZFoyU2NBRmczdXMvak5GRUZEY2prYkZQU056WG9iNzdvSmJBZi9FOWVS?=
 =?utf-8?B?N05HM0E0QnR5RjlTc2F1cVJjWnVrQnlycUZCUzcrV3c1THNVL3oreXlWOURa?=
 =?utf-8?B?SndkZkFvK1VBZlpNeGc0SS9SMzkvK2JkM0hvWVc2VFN4aHg5MWpYOEhpVzhE?=
 =?utf-8?B?d0hxejA2SWxBbThHTTZzTE9VOE0wRmZnd1ZLR29KNWxHNm5QSXpCVHF3R2p5?=
 =?utf-8?B?NVhlSmtNc080cEloYWd4K1N3eE12SjIrYm1yNVZDSGVueUx0Ym9ncUNKdlRt?=
 =?utf-8?B?aWprcFU5cGt6L3h3QW5YUi90ZW8rbStZRlFRRWVtS3EvQjlOOHkydHFPRDBn?=
 =?utf-8?B?ZVozOG91N1loOHN6empqaHRYaVRCVDZFWVllTHlHWlZDTXBMbFBFZzU4Nzlo?=
 =?utf-8?B?V3cxdkovRTRJU1hRaGl5aHcwVTM4UVVlR1k3SzVtVEVqaTV1RW5wRStqNVIy?=
 =?utf-8?B?bFVESUhrblJnNWZ3N25uT2F2bjMyU25xeXA5OUdpVURaMVZ5Q3pDUnMrRzlx?=
 =?utf-8?B?U3M3WCtWeGoxQXByeTAveXNYS09uSnE1cHJJaFpibnBuSzFDcDFwZW5Wcnky?=
 =?utf-8?B?cGtsY3R2MGFobHl1clE0c1Z3MzlWRHFpSW5TaXd4eGdGUDB4ZW9MdzI2d3V2?=
 =?utf-8?B?WWV6SDhFSTRubHNRK0t0UkxSUUl0anZwZlA1OVQ3enVQc3hQaE1OT3lBSHNY?=
 =?utf-8?B?TkJVeWtTdDZnTDdlZnJBR2dqVnJzU1RxZWI3WWlDNldDZDVvK3VZTy94QWxt?=
 =?utf-8?B?eUdadGRCZHB3QmZ3UHhoS2poZXNEOEEraVNSbk1tUlRSaGV3R2wyaHZxdnRK?=
 =?utf-8?B?eHFVOHNBWE41SXBIeFV4Y0FiSWhkM2tsaWI1cHJBUE95dlFnN2JRdFBoeHRM?=
 =?utf-8?B?K05pRFhxcnQ5L0pKc0RBR25sTk9QNTd6Zk80Q2hHMFcvcS9zZVNvOEdOcXpC?=
 =?utf-8?B?V0o2RmFmMy9OWjZpTGoyOWI5MFlXemowRXBReStxTy94R2trOCtnYmdEdjlm?=
 =?utf-8?B?RzlETXlocVpSZWFHYWM2eFF5TEpIZUVoSzY2TFllMzJQT1h1Tk5FNzhZZWUz?=
 =?utf-8?B?YmQ4RlRrQWlCeGY0SXhwMGR1QVhvaFB2T1RsSVdjZXFZRm1hMFZ2S3pWbVFY?=
 =?utf-8?B?NWpYbmFOY3dmSVM5cjFqdzI1M2IrMmVjY3lsSi84UVk3SUc5Y082LzZpenlJ?=
 =?utf-8?B?anA0ejlTRWZKYURqUjFDTlRORk1lZjJxQkxncHNEQXRYSnFXMm5UM3NmMCsr?=
 =?utf-8?B?Nk5DMTk0UGx3cTVuWjF2cUVKeUdzY3E3bHNkYVRoeXVYSWJPb0plaXV2YXVD?=
 =?utf-8?B?Y0pxZlY5UzllMzlTQXA1cGFPQ2s1aGVOSXZrK0ExaVRxRTNUdHRQbERkaytX?=
 =?utf-8?B?U09wUEhNdFc5YWYrWEN3bE1QR0cwcjBoQlQxVCt1Y0lZVEhRWjExMmlYRncx?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ca0f3a-5f3a-4f14-7273-08dd0f1677fc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 19:05:33.4969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJuU0OlZAZR9FRqhij1Se5TFqXd13lR6zcC27mXTl5IwkfiI2XJi+9LiW+Ro0SvI9cM9SI+QgXSiGOjDO7Sc4v92xs+o17bmMjAHdL6pnUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8672
X-OriginatorOrg: intel.com

Hi Babu,

On 11/27/24 6:57 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 11/26/2024 5:56 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 11/26/24 3:31 PM, Moger, Babu wrote:
>>> On 11/25/2024 1:00 PM, Reinette Chatre wrote:
>>>> On 11/22/24 3:36 PM, Moger, Babu wrote:
>>>>> On 11/21/2024 3:12 PM, Reinette Chatre wrote:
>>>>>> On 11/19/24 11:20 AM, Moger, Babu wrote:
>>>>>>> On 11/15/24 18:31, Reinette Chatre wrote:
>>>>>>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>>>>>>> Provide the interface to display the number of free monitoring counters
>>>>>>>>> available for assignment in each doamin when mbm_cntr_assign is supported.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>>>>>> ---
>>>>>>>>> v9: New patch.
>>>>>>>>> ---
>>>>>>>>>     Documentation/arch/x86/resctrl.rst     |  4 ++++
>>>>>>>>>     arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>>>>>>>>>     arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 ++++++++++++++++++++++++++
>>>>>>>>>     3 files changed, 38 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>>>>>>>> index 2f3a86278e84..2bc58d974934 100644
>>>>>>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>>>>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>>>>>>> @@ -302,6 +302,10 @@ with the following files:
>>>>>>>>>         memory bandwidth tracking to a single memory bandwidth event per
>>>>>>>>>         monitoring group.
>>>>>>>>>     +"available_mbm_cntrs":
>>>>>>>>> +    The number of free monitoring counters available assignment in each domain
>>>>>>>>
>>>>>>>> "The number of free monitoring counters available assignment" -> "The number of monitoring
>>>>>>>> counters available for assignment"?
>>>>>>>>
>>>>>>>> (not taking into account how text may change after addressing Peter's feedback)
>>>>>>>
>>>>>>> How about this?
>>>>>>>
>>>>>>> "The number of monitoring counters available for assignment in each domain
>>>>>>> when the architecture supports mbm_cntr_assign mode. There are a total of
>>>>>>> "num_mbm_cntrs" counters are available for assignment. Counters can be
>>>>>>> assigned or unassigned individually in each domain. A counter is available
>>>>>>> for new assignment if it is unassigned in all domains."
>>>>>>
>>>>>> Please consider the context of this paragraph. It follows right after the description
>>>>>> of "num_mbm_cntrs" that states "Up to two counters can be assigned per monitoring group".
>>>>>> I think it is confusing to follow that with a paragraph that states "Counters can be
>>>>>> assigned or unassigned individually in each domain." I wonder if it may be helpful to
>>>>>> use a different term ... for example a counter is *assigned* to an event of a monitoring
>>>>>> group but this assignment may be to specified (not yet supported) or all (this work) domains while
>>>>>> it is only *programmed*/*activated* to specified domains. Of course, all of this documentation
>>>>>> needs to remain coherent if future work decides to indeed support per-domain assignment.
>>>>>>
>>>>>
>>>>> Little bit lost here. Please help me.
>>>>
>>>> I think this highlights the uncertainty this interface brings. How do you expect users
>>>> to use this interface? At this time I think this interface can create a lot of confusion.
>>>> For example, consider a hypothetical system with three domains and four counters that
>>>> has the following state per mbm_assign_control:
>>>>
>>>> //0=tl;1=_;2=l #default group uses counters 0 and 1 to monitor total and local MBM
>>>> /m1/0=_;1=t;2=t #monitor group m1 uses counter 2, just for total MBM
>>>> /m2/0=l;1=_;2=l #monitor group m2 uses counter 3, just for local MBM
>>>> /m3/0=_;1=_;2=_
>>>>
>>>> Since, in this system there are only four counters available, and
>>>> they have all been assigned, then there are no new counters available for
>>>> assignment.
>>>>
>>>> If I understand correctly, available_mbm_cntrs will read:
>>>> 0=1;1=3;2=1
>>>
>>> Yes. Exactly. This causes confusion to the user.
>>>>
>>>> How is a user to interpret the above numbers? It does not reflect
>>>> that no counter can be assigned to m3, instead it reflects which of the
>>>> already assigned counters still need to be activated on domains.
>>>> If, for example, a user is expected to use this file to know how
>>>> many counters can still be assigned, should it not reflect the actual
>>>> available counters. In the above scenario it will then be:
>>>> 0=0;1=0;2=0
>>>
>>> We can also just print
>>> #cat available_mbm_cntrs
>>> 0
>>>
>>> The domain specific information is not important here.
>>> That was my original idea. We can go back to that definition. That is more clear to the user.
>>
>> Tony's response [1] still applies.
>>
>> I believe Tony's suggestion [2] considered that the available counters will be the
>> same for every domain for this implementation. That is why my example noted:
>> "0=0;1=0;2=0"
> 
> yes. We can keep it like this.
> 
>>
>> The confusion surrounding the global allocator seems to be prevalent ([3], [4]) as folks
>> familiar with resctrl attempt to digest the work. The struggle to make this documentation clear
>> makes me more concerned how this feature will be perceived by users who are not as familiar with
>> resctrl internals. I think that it may be worth it to take a moment and investigate what it will take
>> to implement a per-domain counter allocator. The hardware supports it and I suspect that the upfront
>> work to do the enabling will make it easier for users to adopt and understand the feature.
>>
>> What do you think?
> 
> It adds more complexity for sure.

I do see a difference in data structures used but the additional complexity is not
obvious to me. It seems like there will be one fewer data structure, the
global bitmap, and I think that will actually bring with it some simplification since
there is no longer the need to coordinate between the per-domain and global counters,
for example the logic that only frees a global counter if it is no longer used by a domain.

This may also simplify the update of the monitor event config (BMEC) since it can be
done directly on counters of the domain instead of needing to go back and forth between
global and per-domain counters.

> 
> 1. Each group needs to remember counter ids in each domain for each event.
>    For example:
>    Resctrl group mon1
>     Total event
>     dom 0 cntr_id 1,
>     dom 1 cntr_id 10
>     dom 2 cntr_id 11
> 
>    Local event
>     dom 0 cntr_id 2,
>     dom 1 cntr_id 15
>     dom 2 cntr_id 10

Indeed. The challenge here is that domains may come and go so it cannot be a simple
static array. As an alternative it can be an xarray indexed by the domain ID with
pointers to a struct like below to contain the counters associated with the monitor
group:
	struct cntr_id {
		u32	mbm_total;
		u32	mbm_local;
	}


Thinking more about how this array needs to be managed made me wonder how the
current implementation deals with domains that come and go. I do not think
this is currently handled. For example, if a new domain comes online and 
monitoring groups had counters dynamically assigned, then these counters are
not configured to the newly online domain. 

> 
> 
> 2. We should have a bitmap of "available counters" in each domain. We have
> this already. But allocation method changes.

Would allocation/free not be simpler with only the per-domain bitmap needing
to be consulted?

One implementation change I can think of is the dynamic assign of counters when
a monitor group is created. Now a free counter needs to be found in each
domain. Here it can be discussed if it should be an "all or nothing"
assignment but the handling does not seem to be complex and would need to be
solved eventually anyway.

> 3. Dynamic allocation/free of the counters
> 
> There could be some more things which I can't think right now. It might
> come up when we start working on it.
> 
> It is doable. But, is it worth adding this complexity? I am not sure.

Please elaborate where you see that this is too complex.

> 
> Peter mentioned earlier that he was not interested in domain specific
> assignments. He was only interested in all domain ("*") implementation.

Peter's most recent message indicates otherwise:
https://lore.kernel.org/all/CALPaoCgiHEaY_cDbCo=537JJ7mkYZDFFDs9heYvtQ80fXuuvWQ@mail.gmail.com/

> 
> We can add the support but not sure if it is going to drastically help the
> user.
> 
> Yes, We should keep the options open for supporting domain level
> allocation for future.

The current interface supports domain level allocation with this support in
mind. The complication is that the interface is not behaving in an intuitive
way when backing it with global allocation. So far I have seen a lot of
confusion from knowledgeable users and I'm afraid this will worsen when more
users are exposed to this work.

> 
> For now,  we can go ahead with the current implementation.
> 

As I see it this will require detailed documentation to explain the interface
peculiarities. This documentation is made more complicated knowing that the
peculiarities will be temporary since Peter already indicated that he will
need to fix this to support his work.

Putting this all together I do think it may really just avoid a lot of confusion
and extra unnecessary work if this is done now.

Reinette

