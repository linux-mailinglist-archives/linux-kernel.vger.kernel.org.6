Return-Path: <linux-kernel+bounces-333732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8FF97CD11
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37F31F2439B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953561A2560;
	Thu, 19 Sep 2024 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDWqyJV+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54661A0B1F;
	Thu, 19 Sep 2024 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726766963; cv=fail; b=ODrQSOzXurXGncBVqkFtrzOKGEE+F50cXX9g0VQOQhQ1Gv3rCqFsgRLlHOGvVaz8mvGSPfTD9459gpo92TGXDRhkU7sBYR+EYLWf/sgMbGqPUZifxDttiQPzqP2FmMyyxh0ClBmczA1f1mWMNCJEvYDEqG7rcxePoowSRItFQUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726766963; c=relaxed/simple;
	bh=ZISlziLI65KPFW76N37yZ43MB+WTlK/CiNqyxw04luc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wgb5twSq7eUeEjq+JnJq2BERjEJ2Zc1cSXWclJxFHx1MJ3/o4NGr86W9xubo5htAFrDHivlPTOLHfy3y6FjBT5LdesKFN04HcRXG2DvuH0UJCwwf0yv8FSmV0TwT0DFgm0+94pI1GtPDsVD1xhFnKfGLmHO9nwyM9QNm+VVRY9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDWqyJV+; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726766962; x=1758302962;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZISlziLI65KPFW76N37yZ43MB+WTlK/CiNqyxw04luc=;
  b=KDWqyJV+LCU7N+lO12PweE2Kyjt4hzMUJyr/GYODqsmJTC6BMdS8lqcV
   4AQI4QHlZQ+2htNKUGJk9975qYfC5WOjGgP7WUjnqOjJy0oJdXJVnoqQq
   6E59XpD1cVsyQkJfvaDaUpDvRuIMYt5CyXAqmPxodyvgEBH+pXQ9B8+eH
   osB92cq3Ft4WXsu7tVjEOzNw2F41lLU7EPtBGEDFsCyKpHSaZSvwHGtta
   a3MP+hIkQhpMlvSj4ozL/vr76NojqFrXFZwX89x/CBDsVrOIuobHqJ/KR
   yJamWvr+YBtYC65ZoSjabFymAq/9UoALXgEjM4v+o7jNpTkiujDKQ/lTg
   Q==;
X-CSE-ConnectionGUID: 3Y3Kc/A7SqOteyfWRwJdlw==
X-CSE-MsgGUID: oeoJbCN5T522t6iwL3QD6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25846405"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="25846405"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 10:29:20 -0700
X-CSE-ConnectionGUID: C1X3T0ziQx22LUcPNw6RmA==
X-CSE-MsgGUID: yw2vuY15QyiAJaYTn5aBlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="100843655"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 10:29:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:29:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:29:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 10:29:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 10:29:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+eZACyEKk8+GHhqNcgj9WCLM7M31NOCIR4nBDpdCx3aYBBJ4kDuocmS+8/v8P8dknEYHoJXMTlr2XSJDRET+vFA50AUobWHqiwbncKReVQSp4z3S1cppgnysV+jyOek/pcMqEZat0KJW13tbQTQVJGqfkH+Z1KUsapgyhrwwON6j95CcOw/d0mPlFD8uCy/5SDjEtwa+QJF5++JilCE0aG6me/cmfFPr5NUyChhCN0mkasclBczIfnb71Fea3Dxhb99yFfoYJAYj5xW3siMYgyp7QW7QA0EJibgdOJVttgWbpBvJVF79dKUAeQZwlj6e0EisfLU+B961DifuH3Xkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILOUchsur7JlakHmRFgQEnvXl743kZufho/+6bsPPEA=;
 b=B1Ms1JB3GiHm/T/nhTyCn0JE8zN4A8ibVkCGu49lsVgDwCx2kUeto+EnDGsjzsTA9XxnKsyAGbklexdkkKcGP4VbIleNiZ0uhWsR/3zYEFVXaeoCtN3869mvMGmEIcOIS4r4oMqcd8UrEpzkJpiAAFet8L+mEQBxFi5tCbfnAYEsyZH1/hAaXsO9lNWRM32betOMKGRwJMuntFq7fFgLgsUBhjILV3duppf4wuJvzncFuQA2GTl6YjMfp1uAiMYzYzU3+pn6pd8yalkzIqLD2idCE/a+eI9borefJrx1iqsMhJnqTtJVTJl63Z3K6am86ED+qLhjH2U0BcwOuiLyLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB6621.namprd11.prod.outlook.com (2603:10b6:a03:477::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.21; Thu, 19 Sep
 2024 17:29:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 17:29:13 +0000
Message-ID: <1bd79a64-f482-4a0b-86d9-4a3328e5928a@intel.com>
Date: Thu, 19 Sep 2024 10:29:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 18/24] x86/resctrl: Auto Assign/unassign counters when
 mbm_cntr_assign is enabled
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
 <5b02b069cfd7fc3ca30b1e17644d0ec73df7cef1.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <5b02b069cfd7fc3ca30b1e17644d0ec73df7cef1.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:303:b4::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: f6df2ff2-3065-474e-5417-08dcd8d0940f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzRqaHA3eGFCSWZtMzBtYXVqUDAwMFYwbjB4RjdTUUVhVzc2Ym5vaVY3R0E5?=
 =?utf-8?B?b2lNQkZ3Q016Z2xnV1h1MGZXVnlJZURWSG9xd2RkY2pyTjdXbi9IUnkvdWti?=
 =?utf-8?B?S1FTVlpKdjV5bUZUMXJHZjYxeTBnTlBCdXYyQmxEa043cnJ6b0NpbGg3Y3Ur?=
 =?utf-8?B?K2tpNnIrT3lBWTAwYS9iV3hXcmVoTW90Ly9TRUFBTmtNcnJPTnoyTjh5Zlh5?=
 =?utf-8?B?T3NpQzQwT0h5ZUpaWElrUVVaUmVKQlh4VGoxU3A5TWRZUExEeFAwM3NBV0Zr?=
 =?utf-8?B?QjZLVWRhMzI0VGtkUUt1T2ZOWTAxUDV2elJ6Y0pidW5iZGRiWFR1dW55K25a?=
 =?utf-8?B?Tnl6RGVweWZSYUtkcVY5Q3pSL2toanloV1RJY2xxREdGb0xyekQrV3cxQ3dx?=
 =?utf-8?B?MGFIQlRKQjZxc2VnY3B0WXBYRXBYSUJxb3J2NzcrV0poM29weGROakt1N0Fl?=
 =?utf-8?B?NGJqczBLS2Q4bHlzc2VnRlhLdXo0cU9pYkV3WmhyZDhuelE5ZVVwT0NLMXox?=
 =?utf-8?B?OGFQSG81MVhvTmFnZXFVNjRyYnZNNmFDc3FWY2RmQm1BL2lHZytiL1pJM2Vi?=
 =?utf-8?B?TTl4VEtFT2NKVFludlFadFM3Z2FIMm5sNDdTZFRlOXlxWFZONkJ1UmFsWm1X?=
 =?utf-8?B?aTE2RU94Q3cyRkVsUS9rcVpEM1FzcXN0a2lTREJxSGFJcFZQdkVwTFJ3RjJh?=
 =?utf-8?B?Y3FWY0MzVUFXSVVzRVg3MWRaVGtYcytKd21valpoVTdyZkZTK0p1Q1NrU3dL?=
 =?utf-8?B?dDYzWUxQcExLZUwyVDl6UytKRCs1bXA1eGRUdXBQVm1GOEhZUkJVRlVqS0oz?=
 =?utf-8?B?eTJGTFZhU3Jkc3YyaGNvTERIaWV2STdFTE0xM2xqSGNXellHM0M4bzhRdEMx?=
 =?utf-8?B?bDNoa1RYajhVWHFDTTVBdUI5Q2pNa3M2a2NWR2MrRUtKYkdzanU3Q09VU2xK?=
 =?utf-8?B?WVZnUURQT3dHR3BTc0FZV09RaXRPOURJSktZR1dUR1NzY1J0VzIwT09nb0Zl?=
 =?utf-8?B?YStpMFlManQ0dWhVNjA2QXhtRkdHVHZMU3BiaDJlV1d6WUR1d2lWMGpxL0JY?=
 =?utf-8?B?R2pBZ2lzUXFhQVN4VkJWaTBORTZzYmpsN0hZY2tKVXJVdlliUWI0T2dvajNB?=
 =?utf-8?B?Z1k1cHhreGF4R3hIWjl3aERXbWZKU2xrVmw5NE81TzlOd1hJNzRJelZTYU1I?=
 =?utf-8?B?VVJGbVRIb0ZQdC81TjRHZzMrTmJNTjl2ZDY1OVNPWlBVTXlvYVgzWlpkZmxS?=
 =?utf-8?B?RTdqckdVeXhWeTEwajNITlBDbUtxVTVKNTk4eTBib3R3KzNINVpKU2sxeHJn?=
 =?utf-8?B?ZUlFSDd4bExQQjVVZjFuM1dCQ2JKUTQ3OERLS2l5R0MyVkZUODlkTy8wcUVi?=
 =?utf-8?B?SmJ5OXNPZ0ovTUppdmpWd0lzNkRITlJXOGNrNGZCVGlsaS9KYlhMdDNnYjRT?=
 =?utf-8?B?VWxjNEM3RTV6NVp3VnhDemJxaytNS0Q2Yi9aWU9OUHViVlBBb1JiZHB2SG5r?=
 =?utf-8?B?NWF4Z01CZG5zRFVGQ0dUc25ES1hteFlRVmZoRXZjcVVlckhZTjJ2QkRTSDh5?=
 =?utf-8?B?UXFNdmhXckI0YjU4d1pNVUJMMFhyaCtyVWg2WkJmQjZ3Sk5Ta3R3eS9DbC91?=
 =?utf-8?B?QXQ1Rk9iZXdMVjRRTi9lLy9aT3BSc3hUWXBGM1dUWnMwV2dBTnJxT0loQ0hS?=
 =?utf-8?B?QnUzUW9mM2syMHN2TUtTSExQT0dpNkF3KzhEWWdwMjZhMTdvYmVmUnJ3czVB?=
 =?utf-8?B?SHBCWUVyUHcrVkpDUWdWZzJlUjJxaUtuZ28yTzB3cE5pd1E4U3hCTFZhbkVs?=
 =?utf-8?B?TnA1QkZqT2x6TDhLbElTZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eldjV3AzeHcwcDFuWGp4cUNzK0NMME12WFplVlIyUmpSVml6SUZiS1pmTXha?=
 =?utf-8?B?Wmc2anB5Nmx4RmFLSmZ1YWpQbWNkT0tQeFBFYi9kNHlwL1YzNVNsU0p5U1Uw?=
 =?utf-8?B?YlZTVlN3dzlSU1dNTHR3VkdPeGhzMWQ0dGpFSlRpUEUrUERjMlJTS3BQNzBy?=
 =?utf-8?B?bkFBYWNRdzFPZWFPenZsQ0k2Wk5rME9PbFVIWXdJYnlHamlqODNDZWgrcC9a?=
 =?utf-8?B?TnhibEdxaW1jMlR1NlBkNFRiYzFsWUtUSENZMm42eVFURmFqUi9JRGFZczJS?=
 =?utf-8?B?UmpieHRmME92ZDVndzZNbVRNWE1ydG5iL3cvYjBRVHYwbHlpTzBwRVhEelNk?=
 =?utf-8?B?Uy9JMmhxQkc0UkdBSzduaFFFT3RxTEFQRUh3Q3psUDZnRXBwUEo4eWtuQXJC?=
 =?utf-8?B?VE1RTlM4emNSdnFzVWVQcUpFV1hQNDJOcDJDdDB4N2sxa2p4ajQreTV1N2Qr?=
 =?utf-8?B?Mi9lcWVQMFJpYjNUZnFIaVY0SWs4VWk2VG5rdG9Gd3QzMHc2V0hyU1h6Rm0y?=
 =?utf-8?B?akRmZFJidmJuRmZIQWZHUkJ2anp3RDBkMjFYdS9WMkhWazVuWlRtd084a2pV?=
 =?utf-8?B?N1l0RzdWV2R4OTBkZVBqalE1QWlJQW1oN3JXRkpvT0NRMkdqSk9LbjVleUhr?=
 =?utf-8?B?bXBUV24vU0ZqQ0hFaTkxd281RElOeVh5NFVMWDc5YXNWWnJySjd4ZTB6ZDdK?=
 =?utf-8?B?L21GWHFtWnJhZ1NTdjUxcFpMcHZJSm1oWTlFa3pvbGhvMkZjNFMycy8wdHNl?=
 =?utf-8?B?cjUvSmN5UERvRXVvcC9FaWRGZ1NKcFJGTEZjSXlnTW1wUkFLWit3WVIvN0xj?=
 =?utf-8?B?Y1pnV205ZFpNR2tLdS9obTNOQ2YrKzZJcjNGYUpRUDQ5cS9YQ2M3NzB4Y0FC?=
 =?utf-8?B?M01uNlVVekpHeGJ3cXg4Tk1ScDNNTU96ZG5neS96YXhscUVxZWdPSW5KZ0ZM?=
 =?utf-8?B?bktzZk51TFpDMWJJS09RZVdHYWljY1ZSYnVhWWprQTMvSHlSRTVyR09iSmJH?=
 =?utf-8?B?QlBQZXFpbWFTMzBXeVpMNCtqTEJOVWtxcVhpTmZDNnVQTExxTkdiSklXa1Rl?=
 =?utf-8?B?bTYvQmY1UURVQzJ1ZDA4dHZucGNWYmJEU1NiNzZHUlQzSEVBbFBtdi95RE1E?=
 =?utf-8?B?eGRUUFM4R0pqSkx3dkNsRCswZ0xVTjdzbHpveEU3ZElQYS9JVFRCbjk3V2Jk?=
 =?utf-8?B?aDdxNXF4QUNxUEQwZkoyRThaUzdVRmY5SnFtMnJHNS9kVDdEc3FJRWRlbTRQ?=
 =?utf-8?B?cENLZ2I2MTlFbkVkdnQvZ01vVFN3alJ3LytoZ2h6bEJqUEJaZ00rMis3cW9q?=
 =?utf-8?B?ajNhTTNXRlNGckF5NkZnWHNKd3I5WUFzcWgydmdSc0VHSzJISk5KalBlNGZr?=
 =?utf-8?B?Q2ZnSmhNR0M5V2s3SjVNSUx5NWhwMElwNE9mSXR6TmxSRENxNWVqQ3kxWUxj?=
 =?utf-8?B?ZFdrcWoxOGVVYzNncnFrcnUvR3R4V21XWTFsdGp4YlEyOGNwN1VWdDQxOFhC?=
 =?utf-8?B?TEZXZnRXVkc2OGR3NzJyYm9Ed0k2OGJnMTJGNlhnZllaZ2dkRWI0RitCMnJR?=
 =?utf-8?B?Q3RXcmdiUU5JSmEzZHNSR0l6RW9FeDdVdFFra3VTVlJ6NlNscUpFejNZaG9W?=
 =?utf-8?B?RWlzcTlvcXJBaU9MWUs5R1FKYTFYVk5TSnZIMm4yRkNvVXZ6RFZQcElaeWt6?=
 =?utf-8?B?U2pjTnZpTkRiaXZOQ0k2Q3dWcFc5YnpESkJsRW55Z1VpS2RVbHc1QU0wRXV0?=
 =?utf-8?B?T2RBRTAybG9MenVtZG9UYVVjbEpiZmtYbkZEcGtxcC9UanJTbm1xdG5hRjVm?=
 =?utf-8?B?SmY4YkcwU0gwaU5SRFNmaFdpKzA1WUorZ1dzOHY2WUZVdmdodHQzTnU5RUVy?=
 =?utf-8?B?RmlhK1ZkZk5Cd3UyeHBYTG85aXhweWxFOWVjMjByd0FTSG9rWXQ5ZzFBRUVZ?=
 =?utf-8?B?RFRhVmUwaVhVSmtkdE94MU1FTGtUbUlTTWt4cHY5b2N4R3RPRFRMZkpGVHVl?=
 =?utf-8?B?a0dVQUkzcytxeU50RWdKdkNQVUl5R3RHQ2FjQ1pvdlhPbHBKNkJtTWx3NTdB?=
 =?utf-8?B?bXRlbXBEaENiWXk0dmg0ZW1LaGxPeVl0WUxGaiswbktKUFRxTUJVdC9Zblpu?=
 =?utf-8?B?UmdXRkFraGxYTDFZSWJJdm14eEJZM3lhaEFiV281R3BPRVgvMjZUWjkxWVlt?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6df2ff2-3065-474e-5417-08dcd8d0940f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 17:29:12.9945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bV41UCXcOfn/1nvocVJx5JByV2mKzfyeThgOY+XLlmexWM9W3y6F4iW0wIsSL0+6To206OeH+eeNH2CkgmAfb9w6VbRG+OSfANjiePRpK90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6621
X-OriginatorOrg: intel.com

Hi Babu,

Subject: "Assign" -> "assign"

On 9/4/24 3:21 PM, Babu Moger wrote:

>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 ++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 21b9ca4ce493..bf94e4e05540 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2866,6 +2866,52 @@ static void schemata_list_destroy(void)
>  	}
>  }
>  
> +/*
> + * Called when a new group is created. If `mbm_cntr_assign` mode is enabled,
> + * counters are automatically assigned. Each group requires two counters:
> + * one for the total event and one for the local event. Due to the limited
> + * number of counters, assignments may fail in some cases. However, it is
> + * not necessary to fail the group creation. Users have the option to
> + * modify the assignments after the group has been created.
> + */
> +static int rdtgroup_assign_grp(struct rdtgroup *rdtgrp)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	int ret = 0;
> +
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
> +		return 0;
> +
> +	if (is_mbm_total_enabled())
> +		ret = rdtgroup_assign_cntr(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
> +
> +	if (!ret && is_mbm_local_enabled())
> +		ret = rdtgroup_assign_cntr(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
> +
> +	return ret;
> +}
> +
> +/*
> + * Called when a group is deleted. Counters are unassigned if it was in
> + * assigned state.
> + */
> +static int rdtgroup_unassign_grp(struct rdtgroup *rdtgrp)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	int ret = 0;
> +
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
> +		return 0;
> +
> +	if (is_mbm_total_enabled())
> +		ret = rdtgroup_unassign_cntr(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
> +
> +	if (!ret && is_mbm_local_enabled())
> +		ret = rdtgroup_unassign_cntr(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
> +
> +	return ret;
> +}
> +
>  static int rdt_get_tree(struct fs_context *fc)
>  {
>  	struct rdt_fs_context *ctx = rdt_fc2context(fc);
> @@ -2925,6 +2971,8 @@ static int rdt_get_tree(struct fs_context *fc)
>  		if (ret < 0)
>  			goto out_mongrp;
>  		rdtgroup_default.mon.mon_data_kn = kn_mondata;
> +
> +		rdtgroup_assign_grp(&rdtgroup_default);
>  	}
>  
>  	ret = rdt_pseudo_lock_init();
> @@ -2955,6 +3003,7 @@ static int rdt_get_tree(struct fs_context *fc)
>  out_psl:
>  	rdt_pseudo_lock_release();
>  out_mondata:
> +	rdtgroup_unassign_grp(&rdtgroup_default);
>  	if (resctrl_arch_mon_capable())
>  		kernfs_remove(kn_mondata);
>  out_mongrp:
> @@ -3214,6 +3263,8 @@ static void rdt_kill_sb(struct super_block *sb)
>  		resctrl_arch_disable_alloc();
>  	if (resctrl_arch_mon_capable())
>  		resctrl_arch_disable_mon();
> +
> +	rdtgroup_unassign_grp(&rdtgroup_default);
>  	resctrl_mounted = false;
>  	kernfs_kill_sb(sb);
>  	mutex_unlock(&rdtgroup_mutex);
> @@ -3805,6 +3856,8 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
>  		goto out_unlock;
>  	}
>  
> +	rdtgroup_assign_grp(rdtgrp);
> +
>  	kernfs_activate(rdtgrp->kn);
>  
>  	/*
> @@ -3849,6 +3902,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>  	if (ret)
>  		goto out_closid_free;
>  
> +	rdtgroup_assign_grp(rdtgrp);
> +
>  	kernfs_activate(rdtgrp->kn);
>  
>  	ret = rdtgroup_init_alloc(rdtgrp);
> @@ -3874,6 +3929,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>  out_del_list:
>  	list_del(&rdtgrp->rdtgroup_list);
>  out_rmid_free:
> +	rdtgroup_unassign_grp(rdtgrp);
>  	mkdir_rdt_prepare_rmid_free(rdtgrp);
>  out_closid_free:
>  	closid_free(closid);
> @@ -3944,6 +4000,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>  	update_closid_rmid(tmpmask, NULL);
>  
>  	rdtgrp->flags = RDT_DELETED;
> +
> +	rdtgroup_unassign_grp(rdtgrp);
> +
>  	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>  
>  	/*
> @@ -3990,6 +4049,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>  	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>  	update_closid_rmid(tmpmask, NULL);
>  
> +	rdtgroup_unassign_grp(rdtgrp);
> +
>  	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>  	closid_free(rdtgrp->closid);
>  

Apart from earlier comment about rdtgroup_assign_grp()/rdtgroup_unassign_grp() naming, please also
take care about how these functions are integrated since it seems to be inconsistent wrt whether it is called
on mon capable resource. Also, I can see how the counter is removed when CTRL_MON group and MON group are
explicitly removed but it is not clear to me how when a user removes a CTRL_MON group how the counters
assigned to its child MON groups are unassigned.

Reinette


