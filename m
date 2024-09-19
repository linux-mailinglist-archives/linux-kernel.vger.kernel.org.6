Return-Path: <linux-kernel+bounces-333655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BB997CBEE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7759B285566
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE1D19EEBF;
	Thu, 19 Sep 2024 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PW61FxAt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03712E78;
	Thu, 19 Sep 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726761672; cv=fail; b=u+3VurAyNqXkxBm54em1PqePEhEdKpmRI4XK/RVDeIkrLrhdG9PgDcsYz6G37tZmUsYn3GmCbb0xKIAL2ZGHxuiRFz5yxjSZEOvZVyayniQFlXL7Jr+BB6oAZhD7xGnOUDnbBkMeR4p/Vu7bYfl3VVrVETNlE/QUo3MsupNoLxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726761672; c=relaxed/simple;
	bh=I6hAQIt2f8j03C2EavEAwBBknj9/XL3rVDnmXKUfEUg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d/lnS/FVrbuNifcizppp23Tz1nYyisbb8zuKePjHqt1zsEI+RGSDEtxeP2ugBKrgm+fmwrmfYEWyjFd8Guabzt0D16NDSQLT/BuiSbEfTtgUyLVXeIkWPC+D4UWIjSjdoCaZrk0c1s4G9A5oTViA1anAzwcxXQ1AfrcstkU3css=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PW61FxAt; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726761670; x=1758297670;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I6hAQIt2f8j03C2EavEAwBBknj9/XL3rVDnmXKUfEUg=;
  b=PW61FxAt9uZSuFcHNR3UrY8FtM7BCH75zDiDJWqtVT6w1qxCt/69DF1f
   LJcOlPLBJ5pLF5nwMOClH3K9tx9L0ZdKfPtcFsV4mn5bHgF/Vks846evK
   w4s0amPZT1BviPTIcvaklL54XroAVItIpAMlKOyI7zu9n+0pKVqHN/+B0
   NYn05emicBDbFkuYwHvDKg5iKBsNl/uiO/6w8VWIOyjtMqH+2XAX+J+1G
   Za7WeCjI+hDu7fkVy47uBfCulyQJZhcMN8VJ5zy78ydQTdILSsnndTTnI
   1QZ5lCs5vRTzSQ4AyXugJARukjxSosd/FMRvElxBKy2tuiRjsZmhWBv92
   Q==;
X-CSE-ConnectionGUID: enKvNjpsR3eEuFyMVU/2TQ==
X-CSE-MsgGUID: q0AWnTemRAWBUczYreWg+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="36403004"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="36403004"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 09:01:09 -0700
X-CSE-ConnectionGUID: wzVpn2fzQRK62j9K5KL0Ww==
X-CSE-MsgGUID: xQ4ZA2lGSEeQS3Xf2C2S1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="107456535"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 09:01:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 09:01:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 09:01:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 09:01:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZAfe5MY/nXh1ZTbpQPQLCJYiELdFv6JSYJY4ZVS0GFeY6X/jYDwyAc6cLpDxuorDoMxRaGKnk4s4oGVa/CW4t7lPh7JG2lRMGBYti9OF42/piPOMMoWN4j/5LaMq2rXJhnhGn34NgF8EuZIDsw06VR47FaDXtp6vUO1RspakCTt3k6+Faw+rl7S0TF9X0Y7vqzDzEiHXzz8sIXy+A665wW+0DVm9iYJxaT1zF5t0d4Gbek6ab8Ie1GBQ9ByhjgaIgI+zFidFJZzaQB2+B+V2Xii3d91fm3oStKt09r8eTf3BWURWPsIhSio790oT0i++gaZRTcGt1KyuidLBUvK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gtv17rSwJ4QXSIh8YMEHsVca8sCNfMw9RdqxFT87Xk=;
 b=Rpa0QtSA+UnmtGVDnGUselJTILsMWd4BGiKKLv9JNNsU72DpRU32gGCEcU0s75RH2QeBCM5cm4pC+vKHTIKh18+RkzxjAYqVJ+nVCr5yXVY56VBjm/1FicVyRjpU+zUuprf9CvDqPcrX/J0vwbIRVpt+IDyQOzcHqaa9TtFt6NShBtnMYjUVa9MHRWGLlHgfgkzYpfQVPDF6qfUu371NYlMOHNFSFh2vROmTgU8L0Z7o0e6fuhWZ4MpKPx3xrErG36IWk1/RBGCO9zSw/QcG/qIr/T5Vry1AudO3koA1Qk8W9tFEZXvkC3r5+kzTXI6wV9Ah54HYj8nvTv6vbWnTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8075.namprd11.prod.outlook.com (2603:10b6:806:303::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 16:01:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 16:01:03 +0000
Message-ID: <da731387-dd85-4c01-bc0d-936559ebb783@intel.com>
Date: Thu, 19 Sep 2024 09:00:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/24] x86/resctrl: Add ABMC feature in the command
 line options
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <a08d9391f48252410ab084ab90bd5f20b5d4a4f0.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <a08d9391f48252410ab084ab90bd5f20b5d4a4f0.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0268.namprd04.prod.outlook.com
 (2603:10b6:303:88::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b350216-cb23-471c-0930-08dcd8c44309
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXhOYTNLYTVjU2RORHBxSGczN0NGSk9pazJvQ1hMMjdCNVdVUjFad2pxMkxF?=
 =?utf-8?B?UGQrYXdhOUtRMnBtOHRkMDMvQ0FLZDh2TDZ3cjJlNkJYbyswQkxCSmNlUDBs?=
 =?utf-8?B?L29hYTZzWEppRjVQbFV3NlZRMUZRNnM3T1ZUNXFDWEZFdTNhQnEzWHduajVy?=
 =?utf-8?B?Ri9RNTRhTHZEV0NPWkd2VGJ3M0dXM1VVSnlIS2EwZVA3YlBjcG0zOTBaNTBS?=
 =?utf-8?B?dDZoQmFKUDZsaFBvbHh6WDl4bjZMdWNST3dKeGcrZlB6a1pKWmFHUUwza2R2?=
 =?utf-8?B?d1grblU1Wk55RTQ0N0hUdkJMVnduU0g1YlFDeEdJaGFHRCtOTlFieUIzcnhF?=
 =?utf-8?B?R1hRSXRxbVA2QS9aTitpSllyMG5KQzlyVjJQZkZibGE4VFlvR2RSQkdpVUEw?=
 =?utf-8?B?Um5Db3A2cUNJcHZGeGZzTXVJaE5MOHZQbVVDNGNKV2lGZmVYb3ZhQnpCd1U4?=
 =?utf-8?B?a29OQmFIVlhqb2tGWWNRYTVYUVc1U1l4MXRqVDlHUHZlRUp4QUdwTFZLOWRT?=
 =?utf-8?B?OTAwYmRUc0ZjY3lHZW5TMGg2VkVQTTdFb3RESS9OM2c0emhWQjVHd1llZFMy?=
 =?utf-8?B?bWlKVml4bzJrbVd3dHBNTVFqbFd4ZmlWemFtZ3V1a1Y4U24xekJqajNFaHg1?=
 =?utf-8?B?K0grbFNuMS81ZTA3Tytlb0Z0VGNFMTJsUHlLYStHbWNzdzkxcU0zdEFWY2h5?=
 =?utf-8?B?a216Sys4QzYzd3lqNGd6dEJhVU9BMUhhU2FvRmF2cEJtTU5DRDI4a2JNSDhz?=
 =?utf-8?B?SXlzTk5QcFdWVFptVnVWbUN5ZStEbm10akZHTFU4eks0UWpiNFhvUEdOL0c1?=
 =?utf-8?B?V0ZOMmZKWXg3cHFiOVJZM3QxcVU4MEZHL2I1ZjJtcXBRNGtEWTNmRnFwUjFt?=
 =?utf-8?B?NVk0Mk93MU5OOFpFL2hGTjd2ZUN0ei9GQ1NyNUp4S2pCenRXZU5yaDdWR0Qr?=
 =?utf-8?B?NkdCa1krRWFldnVGZmMxRWtXU3dOWXQxbTVFZkJXVXpNdXlXTFRqa0hORVpJ?=
 =?utf-8?B?YWVENXZ1Nm9VSHB2QTUvUmljN25GcXlpem9OTEFYeXRFQ1BqbjZvZVUxQUVO?=
 =?utf-8?B?T3NpZmlNV3BVNVdlQ3ZBVEtDKy9sQi9VSlRobURCUzdmNlpVMTdhVWRpV1RN?=
 =?utf-8?B?MlJ5SWJ3N3I2RHgxOHBBUWdleVAwS3p6djV6NjhRQld5ZUtJa0RJMDVHU20w?=
 =?utf-8?B?MkFkTmZjV2wwRmdyMHNEbG9rNzRXSytQSlNVQldwQzN6NFhPM2dxSGxJekZa?=
 =?utf-8?B?Ukl4Y0pZVVhyVEdycEZuK1lrb3VyRUxvdXVFYWtUYjFMY2Vnd1gwRGRFK3pU?=
 =?utf-8?B?ME1TaHJuK3hHVlZLdFU1QzRSV2xEbnVlM2RWMmxYa2dyMG9qdHU4dXY0Ti9w?=
 =?utf-8?B?ZW11Rm9PaTdPODhnK0xhVlFuVWhQcnhKRW0rdU54cC9HdkZaK2NGRnpDUG5X?=
 =?utf-8?B?WnI0aU8rVFBuOHVGNTduQlhJdDhuZVZ3OFZVRTNiTEptbEU5cUpTSmg5Ymtv?=
 =?utf-8?B?WlF0NklCNVZ5ZW94ZnpJWXpQWWZNYVA3NjB5L092UDcvYTMvbldPZkU0OWhp?=
 =?utf-8?B?c3BuQlk4elcwcDB4NzdxcDhVdk5nRitwOEVQMG1RSnNRdzN6QTJjUHpZTlMw?=
 =?utf-8?B?TFVtVWRucE9XdG9KeUZWZjhLbFpvaE13d0d6L3RTNmhBeXVsVEZ4Y1daUDZm?=
 =?utf-8?B?cFAzVzd4SW9hRGRrdDRQZmpmU0Q2SlNybVpGZmNPcXhOYlR1SDlRMGx2Y0J0?=
 =?utf-8?B?NU9LcGVYeVZMSElKNm5qMjlTMHVJTlljdkhOWHBtOThDaSt5OEFMMUZnWVBH?=
 =?utf-8?B?eTNiSno1eXUwYTY5Yk14UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3lwMHVyVkxBWVhIN3UzWHFiaUFaRVpWTlBKc0ZwV2NXQ05Rc0hjMEFDcU9y?=
 =?utf-8?B?a2IwK1BOT0grODAzOG1uK1FuMU9LdTZ3YjN2a1dZVU5PcVZQTG5vVDE5VXYx?=
 =?utf-8?B?ZzB6L0JVQy96Z1lRV3VFMVdTWUZFQmRaaURQZjVvWVU4YkZKbGhoOTNBTkNm?=
 =?utf-8?B?MDFmSEEvcDRDeWpkRmlraFo0ZjZ5TzBpRUltT0xCNE1QNERCaDIyUmJIUDg0?=
 =?utf-8?B?akx2RVVyOGFBTWI4cjRIU1dzek5VSE03Z0FWMkVrZ0RVTEVISUMxVzYzUlFJ?=
 =?utf-8?B?ZldmZmJqUlZFY1BlNldMQTEzK09TZXkrYiszU3NpMnRoTzljdFQ1SXhEbnVo?=
 =?utf-8?B?alhROThmNlp2QzQwd0FBcmVGODVjU1NpVmdNemdaUlhsY0NiYmlCQ09GMStE?=
 =?utf-8?B?RTBJK3BrczlUOCtraGcrWFF6UWFlT0k3VGRBK3JoSjdqVDdtbjVQdGZTM0NR?=
 =?utf-8?B?RFFIVkdjSmhPbmpEMGFQdGNLSnZWellGSjYvaXBYeHpVUW1ZbXZWcFhlY0I0?=
 =?utf-8?B?SHNENnNrNkM0VVZEd0lxb3ZUR1JqeTBicUhDdzlCb2tTcWpYMjI1UlA1YUZp?=
 =?utf-8?B?NE1lMlZxSHRqU2UyWktOY3RicDFaYjFOYTQ1MDExNzBJMkk0TTFtSUZEZUM5?=
 =?utf-8?B?dmhPcUQ2OVlZcloySmpiNEc2TXdvRkc4V3dlcitsQWN2ckhHOFl4RjBXRFRK?=
 =?utf-8?B?aG5WM3lnVHlpblZid00vSS94Ryt1bTNRMVBFU1lwWkFiMHY0V1Z3bjU1TlRa?=
 =?utf-8?B?UUFZaTR6UHNKVS9NdVRBZ0M1bVUvbDkvMGhwSi9rY2ZlK3VTMVBlQnhlbHpZ?=
 =?utf-8?B?TXNmb1RDYVhEazdSK1dId21CUUUvcGV3QlhDQlo1aUlqV04wc3diZ25ycUVK?=
 =?utf-8?B?UU5NVHpYYW16Q0ROSEdKUENkdVdSODJPcW0yN24wUlYzK3FJSFpERlZlZVRW?=
 =?utf-8?B?RFU4dGx5bnBFdUJiWUk1dC9oYm16YVcvVElmSnJXNS9JOWovRW1yUGVmdldC?=
 =?utf-8?B?Y2xsSVJUa0FvVDE5bGx2b2pybzFlNGdCU0VHUE03eXNRQTFwelNSZFd2QlRa?=
 =?utf-8?B?OE5Vd3l0eDh2VVFhZ3dLMlB0RXdsWWdkYzF2TDcxOG4wc3g0aGdUcitsRS9G?=
 =?utf-8?B?L1IyS2VSNGFtMWQvbi9QeVNoWWdnUkk1YWxad2lzd1JrRE9UNStvZG9Ecm1y?=
 =?utf-8?B?ZmdJNUtjaHpMQkF3OHJnWkdKVW5OR3FORlJpVitudlJaanNmeWNwQW5Lb2hW?=
 =?utf-8?B?NjNTcG12SHVZNkJOSG4zeGVIZXdiWHpyN25wcThkdXpFNzFNQW5FY28zdFVj?=
 =?utf-8?B?TjFFRUt2K3JSWTNKRENMaDlaNVdYTWh4WklNZTUyR09iOW93SzNyeVIvZHlC?=
 =?utf-8?B?SDk5b3BTVyttMWdERmlzZ203b1ZYV1IwK05sRC9LTGxZaTM5Sk9hYlBTR0s2?=
 =?utf-8?B?cVNQbEhLUzl2bW5ReTBXOERCNEp0VUFNZTRQWWdLaGYyY0pQU0RNdXdNQ1pv?=
 =?utf-8?B?OXNOYmVuaGRuUnZFVDlhY2hvaXRKWWxSR2lXYW8vVEhsNTBPWThZQ214YUl5?=
 =?utf-8?B?RUc3UDJudlUxV0txTis0WWxwdzFQR0szcGJHRHBEQXpiYVFQc043M0pYNWpv?=
 =?utf-8?B?STc0QVhtdERjanVwUUJOdjlUNlNWNEVoVlpQT0p6RTg2OFFzMEFSeFpRTUVR?=
 =?utf-8?B?ek5nUk1BWXljR2RFZVFJYitOdy9YTXNCWCtJTEtrb0treGV2a0N3WTgvbnEx?=
 =?utf-8?B?UjlUanUxalppSG0wTSsvR2RlbGpzd2wyUlhHS2RYUEVaZnJKK0JUQVBIYXBr?=
 =?utf-8?B?dkZWUGVHMTkrOC83Z2JjNjRMQkRmMEZIbGNnR2g2dXVqK1hTVEdqdm1Tc29q?=
 =?utf-8?B?R1AvYWJZajh3dWlxeTlzd2FldFBLZTBUMXp1cGYrVmg2OUlLdE5IdzV0VkE2?=
 =?utf-8?B?ZGtubDRVelV1YytPN1ZsYzd1VzVWYmhHMjRxbDlKaXg2ZHZzaE5WTVFNQkVC?=
 =?utf-8?B?b0pXdTBZZDRQdkpWUSs5Y0JuRVdWTEl5TjJPdUN2Ujd4ZE1rcFhza1ptRC9i?=
 =?utf-8?B?d3MwSE5ZNlRUM0tlclpQV2RYU1ZuYkV4N3BEeG8rSDJtaWpMODBVamNpMzU4?=
 =?utf-8?B?QVRJbUNERjhBL3VyOW9hNG96b1hlSlZ0ZUU0Y1F6ZTFtSk5Ub2NMN01vRFFw?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b350216-cb23-471c-0930-08dcd8c44309
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 16:01:03.1337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIAxG1WeJ84fE83ZG3b689NDMVMItlvPq1wS6zz1n6sQ3739eOrt3OFB9H3IQIqlOGsDGx2egEallURixYSnHcGAdmxI19hTngDgYM+A7co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8075
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> Add the command line option to enable or disable the new resctrl feature
> ABMC (Assignable Bandwidth Monitoring Counters).

This does not reflect the fs and arch separation that this version highlights
since ABMC is not a resctrl feature.

This can get confusing and I think this interface is indeed for the
architecture where hardware features are enabled/disabled (highlighted
by how the parameter is connected to the X86_FEATURE_ flag) ... so
perhaps something like:

	Add the command line option to enable or disable exposing
	the ABMC (Assignable Bandwidth Monitoring Counters) hardware
	feature to resctrl.

Patch looks good to me.

Reinette


