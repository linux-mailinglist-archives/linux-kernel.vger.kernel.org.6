Return-Path: <linux-kernel+bounces-333699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3D197CC88
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38791C22A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F7B19E819;
	Thu, 19 Sep 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KaSB1KG5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D95194C69;
	Thu, 19 Sep 2024 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726763565; cv=fail; b=GPcmZnkIeCcso+/fWXewF1rAeNOcCS3CFOqdqKeKHjNptRklRRoYkvich3WBjkFZ0ESRYtoSEP34DLTcP9j3InHDhjihUuLV2DHpTqwZlSp54V7U5MjKb/LmfMFskYQEYy7ZYAvk6o+AI8lmtDP0sVL9c9xoT/8Y7rFBb+8Zl3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726763565; c=relaxed/simple;
	bh=cvlh2efh4V7sxoXgqyeuBf6lAC6o4+Obs33VGzOpJfA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o2+McHSulSTmEvtNb6J715h4HAtBBEb5JVimR1iDuZw3KCAVJKRuk79umpU4bVUkMlHz0wlHrLaNaIopyjKk3oIgeydoMN4Bus8gFdLdBjF9vV6Elld5eI+X2ycAdAVRBX/bLwWRl3Tvgyp8cQSL6OmkD0fIEdjNBF3DwZHHc6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KaSB1KG5; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726763563; x=1758299563;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cvlh2efh4V7sxoXgqyeuBf6lAC6o4+Obs33VGzOpJfA=;
  b=KaSB1KG5+tR/5mCUNl2MDzkP5tbKFpt/1gQn8j4dDs2lj+iCq4JNrokw
   LEgz7Riec11RbDNNpjO4gOLEkvkgcnRacysfgL405CFHrKppQQ/pfwLQd
   7xTeQMheC0IyiPzpsliIUOqf42EPulxBir5oqytiMiuMLaElytS4SNvV0
   sbNW9BEarFBHNvsiTGJBsdBg/8ja/ODwPfqAG6QEFOHOtAirunlCMnf/J
   cQlnPMcUIAu+U9CFeH1CKfBnMrNS1NYMexEZEQ6x7ADME44tRpTgoWC1V
   J5xKkQMH+eVDTCFpKt2GDt7iFL32FzI3zlZ+pY2rDzGYkzg1w5LNZMP/G
   g==;
X-CSE-ConnectionGUID: bFfwQiQuTz+Jfna/9e7R6g==
X-CSE-MsgGUID: hQbwQebNR5GJeSQswJQe5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="36872365"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="36872365"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 09:32:39 -0700
X-CSE-ConnectionGUID: QgC0T2ZmQcW9eyLf8Y3buQ==
X-CSE-MsgGUID: foAL9VB7Tx6RT0qOk5rbvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="100725326"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 09:32:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 09:32:37 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 09:32:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 09:32:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 09:32:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxrjBlvlUH47pBgq/ZHGdMUfRU57SoetV5LMeJrqZP40jNyQVLYBqkeyDlhzGvZXdHoldK9MdDfjKES5LpfYkflx3ixkySNN3UtJFQo0y6zx7n6Hk3BKTeoIVoHmvZvoNXGDqQc9f9R/mNsCxkOIDj9EveVOt73IEr9yIUjVadsEKsCu99R7M2Girwr7EiKLwvyYP7BJQQ1AMZEF+KeYnQiAh8O/ua4DJXtyjlYCpkaIVgZ2tSCIOIEEysYZ8SC66wBvHUYVc3U6tckE6lbysIi7Iw9ezGauLyL3rTmWVt+HYOpvH3l5IPfo1O5G0nJ8vnn1yD1Cu9Srdo59WxOsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCVfVF/pGynGcHPVdgiE2lHgzhIihb1gRXSQg8IkAqA=;
 b=CngUSnvDabSt0/+cf3nFNuWKcbs2C1/Gtpn8xFp35QCzgD5d5HwkAWFlgSsyqIjnU0UC1s6GSSBZNPdGOv0VDP/cexTS+p+sHxQcw0wlQu05i45dh98NO7VXAzSqZuPhhU3zURMAo/gpzB2fAK7SgBNIBgD39ANcAiRADjwGYQk6dnPenAatuvZiNUGvD6MQPb0fh19g/9oags5NUaKm8Hw+D1nsAw951GbMQR1unzuQiAglLf63bFz2IYPIhpM09gRulWbT1jDXqiSmojHuBJniDrDPvFhvdrO5nLr+mtdsE00iu6WPK++G+o7mtNQ/AHU2KYIObnd7y7tGwEshwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5119.namprd11.prod.outlook.com (2603:10b6:a03:2d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 16:32:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 16:32:33 +0000
Message-ID: <721157ca-fb54-4f18-8bcd-76ebb021d484@intel.com>
Date: Thu, 19 Sep 2024 09:32:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/24] x86/resctrl: Introduce interface to display
 number of monitoring counters
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
 <e7e411b2055c50e036e5c2a833e36aa6d3016d3c.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <e7e411b2055c50e036e5c2a833e36aa6d3016d3c.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:302:1::42) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1b0171-7ebc-49e5-43bf-08dcd8c8a998
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2lpRkc3TTRTcGJxMENlT2haYUppQmo2VjlNbHZITjBzTnFpMXBMTzB6aUNt?=
 =?utf-8?B?M1BlQlZONFJnMi93STEybDU3UTBpYzFsdGRLUzlHcy9ESi8rY09tZStiMHND?=
 =?utf-8?B?YmhROGxBWS9HS2pONmtHeEJkRGZZc2pHUWZyQ3h4MVBnR2JtbUc5L3lWcE1q?=
 =?utf-8?B?Nkl5a3Q0ZWI3WHRYNnpaUXB1bzlDbkZKWnRibThZR0J1ZXVMVHhQZGZQUEli?=
 =?utf-8?B?SklZRElLbVhNSmd0N2svYlRpVTZTNzBEVlN3ZW90eXUvZzl3MWZnTVdZOEY1?=
 =?utf-8?B?NkFiY0FRZ24wTlp5SVBZZFV0MHcrZnkxelZ2TmNETDBPSDZJZSt4QmgzNFFr?=
 =?utf-8?B?dW1vVXZiNEpFM0dBOEMvVkhZRm10UWtFVDZFSDYxZVZKcXBlcWRCeUY2TEl1?=
 =?utf-8?B?Wlh3Rm81THpjUlpKa1o0THdvVkZXZktCK0ttRDdaZFhCK1JPZmVCZ1BVeWxN?=
 =?utf-8?B?WnMvMmRwbUZ3SnNZM09IWXUzN05XN2hDem9HWnlFK0RvOWlvYU1VOExBNTcy?=
 =?utf-8?B?OGV5NDhSckNiNzZJVHFLNGJ0MFNldW9YQS9FTDNRdXFUdGVHYzBvckhQODU1?=
 =?utf-8?B?bFREYUJjVVM1UkRlVVNuWmVKK3ZKZmN6UHVGRHV3M2RYRWlNbG5jcHJpL0tu?=
 =?utf-8?B?SkFlSFo5U0RHRVBsanJCZDhMNVRBSDRtbjdGUXRzWEVlZTZ3ZHZUL1d4Q0Ev?=
 =?utf-8?B?SFJMMENodjRqU0VxU2JtM2tFclExTWFOL1ZiYTkwSW40K0V5VjduOXRkSWFQ?=
 =?utf-8?B?bkVRcXRxenVwMHZmUTl3dnYvb093ejVPSVRReVE1NEZXUDREVzJrQlNseEk3?=
 =?utf-8?B?RFRWbWdBVlEyQXgwVS9DV1pyTCtYNEdNKzVJdytBbWlHS2lQUE1KQjNMSmJq?=
 =?utf-8?B?UktTdit1eVd3UzdzM0xWVmVwR0tZTVJlenpVTm0xK2tYb1dLck9vV0RkNGE5?=
 =?utf-8?B?ZmxwSmRvN0k5OWpjcUlDTzFiYkhzRUhlRDJxYnc4OTB1RGQ2VDdqcUU5T21h?=
 =?utf-8?B?Y2ZVUkovbUZwblI2d2dUcUlCZmswUTRQeDdxdURsTktyV0dmV2d6NXVWRmw3?=
 =?utf-8?B?YWwxK2lIMmJ5clhzSUQwUGZXQ2RFcVVpUTRCL2dyMUs0UC9JVXMxcXBBSDVy?=
 =?utf-8?B?Qy8wM1d4N2RuaXhCdU5BTzlkeU9IRUxoV01FdzVZWjNjNEV2QnY4V1prNE56?=
 =?utf-8?B?RlVsVjh6M1FkZ2FtQ3MyQzFvaWVneUd4bmNNOG82SW1DbktIOGU3aHZ2NXhx?=
 =?utf-8?B?OEFnZ1h2QmlmRDdjbCt2ckZmbUlkZnFCQWdrV3JUcURkcjhjVUR6ZWR1VnNq?=
 =?utf-8?B?RktrZ0o3aFpDL085WDUvNXpraFZMTGsyRFlEZ244UFErWTVwaTRqeGVlZjF5?=
 =?utf-8?B?aVZybldmUThnNUp0NUo3Q05NWWxwdVhPL1owVCtBa1kvWUprZHIrZENVNDlK?=
 =?utf-8?B?dUVheGJldEhhSHM3cEpuNDM1VStRWkE1VmxTMHlxOTcyVkFzM2pRY3JGbFpG?=
 =?utf-8?B?UExybkRyN3gyalZzNTk1Q0gxeXlWNkEwN2UvdlZENWhrbGRQMGZtdWdVcGdp?=
 =?utf-8?B?dFV6OERyNVI0V1ZTNGZLYXBEUFA4MWNZK1Y3aXFFTzZHZWsxaEk1NVBVVmN2?=
 =?utf-8?B?YU9hRTgrVmVhMHVGU2p6VVR1VlhPdlIreGFvcGZtS0hoMTNGclVwSXc2aC9j?=
 =?utf-8?B?R0ZaZ09xV1F5UHhRU3M1VG8xZnRwRmlJZkJ3VlVEUmprMUprWTBxZnhTK3p5?=
 =?utf-8?B?MDhmTWswbmcyN3AyLzRQc0FNUk9WY2VjNHJoSnA3ZHFWYVVaRGVrY3hMZ1Mz?=
 =?utf-8?B?Y0MrOEdzdmhOVWxrMWdPUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTBJRCtMS3VveXg5RFFTaWRkeDdTYTllM0ZCb3hlMGJRZ1RZTkRjRFN2enVF?=
 =?utf-8?B?Sm9yZHNrSzZZMUFZMEp5b1BQQzM3cnRWTGwzNVA5WmppZ1ZWZkhJenQvWGUv?=
 =?utf-8?B?MzlLeVhoU1VxOGpWc1BNanN5Qjg4am5IZEFPend6K1FlaDd6aXNvVDV1ZUZG?=
 =?utf-8?B?WTJycEo5VmdpOHRXWURqVzZRY2FLZ01CQ2xuelhHOGwwVXo5VHc0QUVtWmxV?=
 =?utf-8?B?SHRJNGw5aFVLcUtFU0J5U1ppQ3ZRRXZERGU4R0pmdWxlZXhPTVhGUEJxSU1D?=
 =?utf-8?B?OE9IeEZFUHVGVlpXL0xsZTI4WjRNVll3bVMyMjA0R3lJTHNQcWtHdGh1eXk2?=
 =?utf-8?B?Um00YTFQd3JJK3llUXM1N0tRdXhyMFFtUCt5OEtPYmtQSEF3blZtR0RGdkFN?=
 =?utf-8?B?Z2lBYVhvdzIyVGNtMU9ZeDB0Vno4dFU3WTVXWWpEY0I1WENFTUhLbW93dEpo?=
 =?utf-8?B?WHQ5VmFIR1hJbTZYQTViVnlkeGd3cE9kc1ArVWpLNlRZRnNXZXZ5amFzbHVF?=
 =?utf-8?B?RWdZN1gwdEFYVWxmL0NISGJtV2I0MDVnYWFDUUNLQ08vcGp2eFVzemJOVERp?=
 =?utf-8?B?ZnN6TjZYbEtjQlQ5SWIxNnlhY21QdnY4OUNvaElZTmQxbUJ3anJYUklVTTkv?=
 =?utf-8?B?YWxZLzV0MC9ZdERkeHdvZ0R1d2FmOGJ4VUpwdEpFSHFWVzVtYUw2T24xcGFn?=
 =?utf-8?B?cHBwOFppWmFwaFpjajlmQ0MyUGl4M0R2eVFKN25zUXNNaGVhZTJzSjZua2ww?=
 =?utf-8?B?Zi84Wkl6WEJFYi9pNFpqZXpkUlZmZGEyTEI0amVtMFZjRUpsNnVFVGJXUE1F?=
 =?utf-8?B?TXFZZm12YWhMN05zS1VrRHlNYXhiWDFhOUZDY0dUSWw4TDZYTmY0TWs0Z2U1?=
 =?utf-8?B?a3QvNjhNUFZzYXZzYU96MDJicnBGNjZ1OVduTzNYK0QvazR3bWlzenJpbUNE?=
 =?utf-8?B?WlJuTzg5bGljRjRRNG5Falh5NS9ZT0h4WVlUVlFURy9rclFCQkMwVmtrS25h?=
 =?utf-8?B?RjNMcTA0dW0zaXg2OFJLL3hqWG96V0xnTDNxejQ3V3BGUFZ0MHhXdUxsd2Qz?=
 =?utf-8?B?UlRxaUp1bVhObWpuajdGV04zcGUwOVB1Yy9BVW45WHZOcXdwNnp5OGFWaHgv?=
 =?utf-8?B?SWhjZVFsZVViTFVxdVUwQk02dE5KNjRhR2NVZExDRUp2Q0svNWhzN3p5ZERq?=
 =?utf-8?B?OGdhQ3p6YVlxTkdpRFRFR05zVnY5R1MydjZlT3QwYWVvdlpaUE14cHpGK21w?=
 =?utf-8?B?QmZWVEVvY3pPQkpsUm5xemxPdFRzdFQzaVdCcnpEeW9GRHFTb3dyY0pPT1Fa?=
 =?utf-8?B?VVRaMy9OOVNxSjZIcHQxMEJ5QkpGUDMwMXdTRVp5dW5ZaFJ4VURyS1MzQjd0?=
 =?utf-8?B?Z2sycnRBeGRuUmlKYi82Zjd5by9INUhQa2l6TlZXQmtkNFVjNE45NWFFYmZB?=
 =?utf-8?B?YnpFbzRxaWErRFpGU2xubDZTVzJJRjNnaHZMUHB2UmlFeTJ4M3FQVGlWbHlK?=
 =?utf-8?B?SWk3bnpBdHZFNXFOTlhuTHpxdWdibk9KbmdiWWE0WHRZMmNBUkgwcWFOMVpB?=
 =?utf-8?B?N2RDSXdYblZBUlAwcVRCQkd3S09nZERsVU1QeGRjZlVBNTkvd2d6bnMvK2N4?=
 =?utf-8?B?Z00wRXdqdW1UVXJNS2dHaTdUS3FtOE1YNlhtN2tDRGJ1Y3dWSEhCVWVVTzF2?=
 =?utf-8?B?czh4OXZDYVV1MnlZOTc5YUExYkI4V3MzTy9SSXJtQVllRjRON2RwekNGZGpD?=
 =?utf-8?B?MTh1aTJVK3I0NUhTQXdSaUxPc0lPUzRXdGM2clB6eGgvR2tTNDFtYmZjL2V3?=
 =?utf-8?B?ZXo4QjhxaW9hNmhGTUFzNWdGcGtnejVlSHVqVUloaXVQYWFqaUJXM3Q3bmU0?=
 =?utf-8?B?Y05BVC8wK1dxd21NSUNib29RYnhCNWNvLzBQM3B5dEIrZ3A2NWdGZEcwU0Vu?=
 =?utf-8?B?T0w1UDArR0RyeVluTjY2bHovUnBEc0IzUDFGaGgxU2ZoNG9CYVcycDR6b2pW?=
 =?utf-8?B?bnhOemM5bWROeG5nbWRLbmhaRFRTZUlsSVBqTkk3NVhmQzlpSUt0Sy9xWXkz?=
 =?utf-8?B?Yng1bldWY2xMWWVhV3NTdEhRQkg3R3ZZSXpPV0tZOXhhVWI2TnlhdCtGSXZ0?=
 =?utf-8?B?RzRwNUVkRm55aGFleng0ek5kbGU4V3VpUTF2d0YzaG5pOGowYkVVTzhXaGd4?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1b0171-7ebc-49e5-43bf-08dcd8c8a998
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 16:32:33.1373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSedyMlXjK/0BTBFQh7tDFXKr/tCYOBEn6NiqF9yy59aBAZNbe0YwQyArTK0W3COkRVljnVhGJh3q9ljTlZbIbmjwjWJ7rc3h1Jw196T/Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5119
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> The mbm_assign_cntr mode provides an option to the user to assign a
> hardware counter to an RMID, event pair and monitor the bandwidth as

Could you please be consistent in this series in how you refer to
an RMID, event pair ? For example later it becomes RMID-event pair.


> long as the counter is assigned. Number of assignments depend on number
> of monitoring counters available.
> 
> Provide the interface to display the number of monitoring counters
> supported.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v7: Minor commit log text changes.
> 
> v6: No changes.
> 
> v5: Changed the display name from num_cntrs to num_mbm_cntrs.
>     Updated the commit message.
>     Moved the patch after mbm_mode is introduced.
> 
> v4: Changed the counter name to num_cntrs. And few text changes.
> 
> v3: Changed the field name to mbm_assign_cntrs.
> 
> v2: Changed the field name to mbm_assignable_counters from abmc_counte
> ---
>  Documentation/arch/x86/resctrl.rst     |  3 +++
>  arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++++++++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index a7b17ad8acb9..3e9302971faf 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -290,6 +290,9 @@ with the following files:
>  	than 'num_mbm_cntrs' to be created. Reading the mbm files may report 'Unavailable'
>  	if there is no hardware resource assigned.
>  
> +"num_mbm_cntrs":
> +	The number of monitoring counters available for assignment.
> +

I think it will be helpful if the changelog and the above doc notes when this file can
be expected to be visible since its visibility is not connected to visibility of
"mbm_assign_mode" that refers to it. There also seems to be a conflict here where
"mbm_assign_mode" documentation contains section about "default" that refers to
"num_mbm_cntrs", but "num_mbm_cntrs" may not be visible if "default" is the only mode.

Reinette

