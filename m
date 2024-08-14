Return-Path: <linux-kernel+bounces-285844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D9495135C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54D9285FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D730A41C73;
	Wed, 14 Aug 2024 04:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hW2qWiBd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CCE558BA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723608161; cv=fail; b=h6DlEnU3ufluyOXMvCI9IS0k9L/D97S77FAtaq+WO25W76paLaSAvAGN6UqOvlKlPJBdEHpAqWmZFfTpLXIEWCaOBNKdt6MDY86FX2KgBmPA+sPlu1quBipQaXAgPVMJsmtrUUOHEnIsrqTz9522/KrKVJSMxLwTNuJphgKjUaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723608161; c=relaxed/simple;
	bh=Mq/5og9DHUjuX/wwXfx5kNAbslnRDp6TlR4Fv50cDY0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ssTlJxse81PSioFD4B3aFDddGAsHzgWKMNrUt4zrZJxxE1dTE0NWQYxeY5x5A8lhDVhoJ7a66eKPzC9QRSZsFSawXziAWjeKr8L+EnT2vGsUFrmkfxD86vwnDQbfhdQdHp/UVXfIWnzVtGBlH9qtcNauxxBKVMprDyk/gopgpV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hW2qWiBd; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723608161; x=1755144161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mq/5og9DHUjuX/wwXfx5kNAbslnRDp6TlR4Fv50cDY0=;
  b=hW2qWiBdI/4NVPWcm9FTZzspIEK+Zen0YMPtbN54DEVDsy7jsq45tYLs
   vixY2OHa/tAsJ+4AJTlRQTGvdjbaECuhWSnBhrkbJoab9l8uDsLL7FnpF
   ADRKzE0h6ls9NrxGdkYZ8/WPCmaWoOnIKkKGABsWhaXvxA+Yv1wIY/7Gu
   eshTZyjJ0sqdy6/+iHZ/kqRIBn5atTOzJ8c8OPQ/yULUrGpZe5EUe90ak
   FlJuE+5N82WWhI80LscXMBLa664DvmW8cSn91S6IM6EbyQemW6AkqEnxy
   vGOw5zNQgT44zPrL/3/CTFFF/jQF2VnP3CtLW9AqP7yb9iynTVmaeYP4N
   A==;
X-CSE-ConnectionGUID: L9Tn1gumTXe2qohc2dIbRQ==
X-CSE-MsgGUID: p5EjcXo4S6i+mTqmlk9Yhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21445501"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21445501"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 21:02:40 -0700
X-CSE-ConnectionGUID: ij3K5GyZSBe3KrZAF0kObw==
X-CSE-MsgGUID: QgXIvgVFR16XCR59yguqow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63806554"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 21:02:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 21:02:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 21:02:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 21:02:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZ4sPbXI5V3JzJXNFd/jG2Lvdb2yIwl8UMtoPkr8f550NWl0HXoEcs3S8DNXjJ8mPzLp0f01+Q68ydTlxW0CJh2ayG0pSiK69nrTegQyGF2j4gEIGNJhQ/HnO/VooGd07gmkPbEquAcGwX1GD26oYSU6K3h5jFWtcBACuAhceSOIIR9gQ4SHurYyl6E+V68MqlvxE+0HGSKkKVhIBRzl5bphL05/3bCWCBU52lE52xWw15FFbqzn/gjtKjfVI52Pm+BttuRJFl1AlX362n413z+FfiZcj1MaVX6bW4RP3yR5YFE0Uimj3I7OAunMTM5kJzBVdjTAbS9IKIu2uOhwiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45C+VsnMSk+95fPCeZn5hToxfvTksOFba1nk+v6KwtA=;
 b=Nvx/FBJB3tCu0p47aH0vssEOIsBj4mPDGTv5q5CMiqSdxTX3HNJ7FvTVD3l9LuuPCD21cG2ZzaMmZSWSuPQYdpkUcgEWDW/fZjXe7yrFSfeWGr9+jyRNkUlPNpQUJWmeB39rHEeOGAsupFm7JbKdYIUZl+o7ePJu3C8jXwa1jCzWu9rTa3K/EnWMtdoo0Bc0PGyMEV6gjUNIigT6K25w63dY3Z2KsvcY5dSvpYKljF16td4zG8uuuGrcR4u8i+57Zwc3PDNXoIxEaiq8jQ+3yqKomEZZgYqjJK/J06/ZvcCoMg9MlnbgTVo5eytDGWNIZv5opXflcri1Aiy7VUNpzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4955.namprd11.prod.outlook.com (2603:10b6:806:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Wed, 14 Aug
 2024 04:02:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 04:02:31 +0000
Message-ID: <b4765250-eb0f-4306-bb4d-45f45f1a0a04@intel.com>
Date: Tue, 13 Aug 2024 21:02:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/39] x86/resctrl: Allow an architecture to disable
 pseudo lock
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
 <20240802172853.22529-24-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240802172853.22529-24-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:303:6a::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bd9eb3-35d0-46e8-e9b1-08dcbc15eb98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWJlZmhHK1VFZC9hMTRFUU1VUXpBOVhYc1hEOHo1SEhLT1NGOWdXK3hxTU5G?=
 =?utf-8?B?UlBmcGt3eS9ycVQ4MjJYWDE3M1dWemNiTzdSZ25ncXZtajlpMXpzVndPZlNM?=
 =?utf-8?B?dmliSnNGUmdTb1h4L1cwcEljOXdORDJxZFBCd0FzNzB0bW04c3pzL3lPa2F4?=
 =?utf-8?B?NklXNGU3c1l6OGE4U2I0ai9wbDZ4bG5UcGZMQ3NWYnFyaG5GVitiTHczWUk0?=
 =?utf-8?B?WExva0ZLQlpOMVV0QnhIdmM0cThydGFjT21WNlBkeExPUDVxcDZ1WURaSWFC?=
 =?utf-8?B?WURPUWJ3NkNEK0xFWDliclhOQ3lDdzNua0VyWk1YaFVBN3BzK0FaZklTWENV?=
 =?utf-8?B?VnE1d3Z5OHR6c0R5cU9xSmFXM0V2MFVnaElFdHU0UTdRMXE5aUtQcnRFeE1U?=
 =?utf-8?B?UzRzL0lpT2d5NTcyUDhFcEQzbURBUDZ6WHp2a010SWVKVzAwYjdDNTZhT0d2?=
 =?utf-8?B?d2szN0VzZDlkRk9tRUMxdEs3ZldlL21yNFlmbGxoV0Y1d2ZmRG1GYWkyYXVF?=
 =?utf-8?B?S0Q2MzhzaFowYVd3OEZqeDBVck5hNW41d3NpRldxT3FEbDdxSUVRQlpsdVFQ?=
 =?utf-8?B?QzJydnZEUVorR1ZselpIWUp6amlhcmNwcEFCWWo5cmI3NmJ1cFNPTW9CdTl2?=
 =?utf-8?B?TTVqeXBmVG9hMTlrbFFjTFJaaHVzc3lTM0RqaU1SY2hpT2NOMFVGQ1ljRExt?=
 =?utf-8?B?Vm5hVUZRMHpsMUI2SmtOb1RuM0hRK2lUMVl5WEt5T1poMEdkUVMvWXFGR3Jz?=
 =?utf-8?B?VXNBYlB2c01TdzRZbU1MUGI2bHdjWWxveUhMNEt5ZCtleG1abFZVVHJuRFBY?=
 =?utf-8?B?dUUveTdmVisrYmpVNUJNakZvcWZUU25TL29jSE9HZHR2YzIwMmRpZVRVbkxC?=
 =?utf-8?B?YWphQUVEM2YyeFZjWnRuQzRHZlgrb2tTdzBXZU1RUzRKSGEvNXk0L1E2Y1Yx?=
 =?utf-8?B?UHk4OFdZb0EzY1A1VkYxMUZYMy81dzJMT0Y4cy9GQlNqZlIzaVpOODV4Wi9w?=
 =?utf-8?B?VGNZY2wyRmpPZzh2NlVzZWxuekJ6QUNaZkppR251VnRhZElZZU9rWEJQL1Bm?=
 =?utf-8?B?R3BBR0lHb0ZyblQ4S1YyVlA4Nm1Yd1liU29uSkw1TVRsV09YM0NtLy84SnJq?=
 =?utf-8?B?eXRSOVhMSTRRS285aG9kME92UFVPdU40K3k2b3hYb3RsV0kwTjV3MXZ4TmxU?=
 =?utf-8?B?KzY4NTNwWGRyWE5Xd2RTRDB4RWx2UGpLZHhFVU05blo0VDkzOUh4K2RmUEZO?=
 =?utf-8?B?a043TUtQSDBFUmszTEhYdWRJVnNTQUpZd21adW8yL09PTVpUSGlkbjdFMlM2?=
 =?utf-8?B?ckJ0S2ZPSDUvc2tQeTRXV0Q5RTFQVWRaamV2TGUwQndhNEhmU09SOUgzaDg0?=
 =?utf-8?B?dm1MaUNFN0FaejBoV3BRK3E0b0Vkc2FxdEM3dDhmMmJiQWp3UlA2bXdZRUE2?=
 =?utf-8?B?K3lVVEZURGpGNEswc0FzQkZCdU5KSm1iQlpCY3J5TUttbFdRUUozSzdEaXlL?=
 =?utf-8?B?UWtIRzduRkRGYVBsTVRwZG5zUndPSWpRNWx3ZmpjUEo4Z3MzcFJDaG4yaXpD?=
 =?utf-8?B?djJVWHNDVGppQW5DdlBBUVJjMlRHVDI2OFZkTmt1YUZLSktkdllGRG5YMndC?=
 =?utf-8?B?K2YwRTN1UWZLNEhvcHprVDhWcFdmbFFiYUNjc3RrUjc5M3pCcHVoWUpaMVJi?=
 =?utf-8?B?UW05NEtkM3ppLy80aWNvU2RWK3hINVNVOTZicG9sUlhMbDY4bm0xQ0pCdFBu?=
 =?utf-8?B?RUI2VkQvMWE5elhiLzJzWm52QWErYzFISGhGV1VFZzVqcTlPZm5JTlJxdWE1?=
 =?utf-8?B?L01yZGs0akpSd3Qvb3VIdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGMyTHZtTWg4TEdKL2tjYytaaFNtTkltMHoyZjZ6c1VkUXRJcjNGVEVFUm5t?=
 =?utf-8?B?U0plVlNWYjUzWmptYXhUdVhyNk53RTJXU1A5VkdIeE9HQUh5SThVQzd4MGlC?=
 =?utf-8?B?ckREZURKeXBzWTVidG41WlVhaWxIQUxNZFFlWTZyU2J5VEo2MnhoVm5zOHRB?=
 =?utf-8?B?cjdIeVhXeTlQSFJLaGZiRjUwZ2hpdFI2V09JNEdId3JVZzJrU2F0LzEzNW92?=
 =?utf-8?B?ZEY2QnZjdkh2ZjA5WmhVUXpnY0l6MjYyb1hPT2U1MENYaEc2UmpjY0JubU5T?=
 =?utf-8?B?Vm9ZWDJTNmQxS3NtVjhWdHg5b1lCSnUyblFLczVuMjZFTGxtQ3FldDBzSEFy?=
 =?utf-8?B?REhRZjJkZzVXVVp3RFdqMXNCbG9KUVBKd1ZmdDR0SHltZWxhakVsU1F5bGNL?=
 =?utf-8?B?WGtNQTRTYkdCZk1VSUF3UnBGRUlmS3ZOZXJqdkp1YlJzNVl3S3BaWi8rSFhT?=
 =?utf-8?B?QUE2U1lEZ3Z4S0N2QmpKZTliTDRLQzJWVVBsd2VKTzVGb2c1SlBVT0NocXJk?=
 =?utf-8?B?OUd3djdyQXpVZkF2Ri9TdUtsNnJrSVE2VnN4dU1kQjBsKy9WQnN0Y1orRmlM?=
 =?utf-8?B?YkRGcE9oeVhsYmZieGluL2lYSE1GaVZ1MG45dnNMYWxzYXRiak5hTERvZzZ6?=
 =?utf-8?B?L3l6NDZ3dkVldXVMY0NiTTgyelpWVUhRNkJ1eksrdXg1V2crSHJzakJmRWo0?=
 =?utf-8?B?aE4wSm1Xclp5enF1RnhqdGtmSytOekpWUDdmbFBscXljTzluc3lUZ1BWNUEv?=
 =?utf-8?B?ZzQ0KzJFY1BsTGppZlNEU1piYktCa0tQNWpkLzZlWEdIT2Y1N1dyZzd5UkJX?=
 =?utf-8?B?OHNOazdyS2tCM250bEthNzJkQW1sYk5Ed1U3eG9VUzZlRGt6dEVqbmRiK29x?=
 =?utf-8?B?bUpxME0yODFOV3BIL0dWS1h3b3dMcE5yTlp0N0NHUCs2VGZ1Rk8xRHdIUnRM?=
 =?utf-8?B?QjhmanZQamhVWkZUYzJXemNzbkozUGFCcjlJdG1GNEh3SmVHWFFBdUpVTlF0?=
 =?utf-8?B?ZHBLWkI0UEZIbi9jWnFmVDFQRWxXc0FFTStJR0JvVTRZUTgvVGlxUXVSQ1Fv?=
 =?utf-8?B?RGwyYnBrSkRaTjlYaVFyRjhWaXBhR3NzTXNJa0tqckE5alppTGZHaE5VczMv?=
 =?utf-8?B?UWNldWRsL2xDZnc3OUNHVElOcXBtbzZrNG9hakhla2MwZDEzaWFrNmcySGtH?=
 =?utf-8?B?VkFqbXBYem9ReXJEaEFmU0xRaTAyYmZza0EraExxL0h0Q2lTYmpZNE00R3JB?=
 =?utf-8?B?SWpoZndKUkxBOUcxNCtPekpEODNJYjF6bDViTmJuK04rSjVaYjg5dk1EOGVz?=
 =?utf-8?B?bk1xMzdGUFMxbDhhckNDRmRvY1BDcEt2WUFoSXgwcDhhaFpkbzJoRy85cEgz?=
 =?utf-8?B?KzVUUDNpaDlVYlZMYzREM3BrTGttcEd3RFBjcnkwWnZ3cTNHaVRCc1liUTh0?=
 =?utf-8?B?Z2dHTGhRUnB1a1lIYTVrNEE1RmdoZWxBdHBEVjd5ZUdFU1YrdU80Y2RFZ3F3?=
 =?utf-8?B?REVGdmdhbldTRVlkVDZRVW9RaEROdzdQUjlrenZJRTU2M1lFVVZlOEdBRzd6?=
 =?utf-8?B?ekdHYzJ4RHVzV1lZSm9Ha00vYlNVYThJNTN0YzkzYk5kRlk3VW5DaFVNRUJi?=
 =?utf-8?B?M3Q2WFhNcWExdkVuS1VoenZDWmkrSHNVKzhVUGpyRzl6KzduQzB0TnBlWndl?=
 =?utf-8?B?TmpUU0JlbzR4aURreHdWUlBFaWdVRGljZEJ3SXd1RWpQblJnYzVteFRQL1l4?=
 =?utf-8?B?NFJ4dDNSWVpyWlZ3dTMyMThZOTE2aWtYa3cwK2I0S25WZVYyTk5KSmRsUFo1?=
 =?utf-8?B?SFlMQlVQRytpUXFiN0U2d2tuMjd5bURyR0Uvakl4OGZZa1EwVjUvYUNkVTlw?=
 =?utf-8?B?R2F0L09sRys4YzRzMXVOQUFIeGJsWlBqaHhsTTFkUkNZK0MxMmFKKzQwckhi?=
 =?utf-8?B?MG9HV3c1VE9UQnB2SE5ld2tKUFU4RHNJZjJXZi9vMkZYbWdpcDUwOUhYMjhE?=
 =?utf-8?B?WUhBNGN4Z0JhaXJhakRzV3V6M21xS3h3QThhQ3dTZmpYcTRNVTVTQklJQndD?=
 =?utf-8?B?b2ZtaWJOeEVrSUJmOWNRaHJBMG9mbjRMOHFvbFBDeFRSY0crWExNbU9TUUxH?=
 =?utf-8?B?bXV6MmtreGl5c2JBWm9ydVovNUJHUUkzUGthUW1BSnhnZzdFZ241MGdWUE5L?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bd9eb3-35d0-46e8-e9b1-08dcbc15eb98
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 04:02:31.3740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1CeKYI2a9NzMBk2OqXk3Ysa5vfB3dsL2x2jN4WYssnCyDaAz2qfKonpm41T2sdZQ8HQ0ltQpk4rNYahWl8UcT2MHbTTNw6rv9tGxslInCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4955
X-OriginatorOrg: intel.com

Hi James,

On 8/2/24 10:28 AM, James Morse wrote:
> Pseudo-lock relies on knowledge of the micro-architecture to disable
> prefetchers etc.
> 
> On arm64 these controls are typically secure only, meaning linux can't
> access them. Arm's cache-lockdown feature works in a very different
> way. Resctrl's pseudo-lock isn't going to be used on arm64 platforms.
> 
> Add a Kconfig symbol that can be selected by the architecture. This
> enables or disables building of the pseudo_lock.c file, and replaces
> the functions with stubs. An additional IS_ENABLED() check is needed
> in rdtgroup_mode_write() so that attempting to enable pseudo-lock
> reports an "Unknown or unsupported mode" to user-space via the
> last_cmd file.

"last_cmd file" -> "last_cmd_status file"

Reinette

