Return-Path: <linux-kernel+bounces-333753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A49FD97CD6A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 20:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6479C285314
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC32F1C683;
	Thu, 19 Sep 2024 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khdVm1GY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F162E17545;
	Thu, 19 Sep 2024 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726768837; cv=fail; b=Pr7jXCMgB8DSW71/vKlWvw9kLbUBFs5gA6JGrm8IWKi2PovvVHpfJhZzjvePOiuez5IFfqhccJX40+A5cFIj6UBIIp0k4+UuU5Rr5A0IjVh3KJQmxXcr5spmagQZP7/0BEGlfn0+Q8U2WsQzIY2HAYwdgftyA67x7qr9O9yR5EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726768837; c=relaxed/simple;
	bh=XI+FN/odn9l5FyXUxFcyG3cDehAo5CybekyKZxcWonM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=av43Ez2Xavkk60H9Ub7Dloisg0NXJWOf1aR4oOBP5Niz5EsfhB4ksVwTDEZqQTCSp3GeCYlwabLozkeMd/8sf3d/MrgOrSyVX9DbkbzGp5hJNsctkfyuUnzd3fSs04r1sV9s818k3Rn3qGPyPRKCpB12yXT0UgaP1ktlIg5z+4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khdVm1GY; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726768836; x=1758304836;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XI+FN/odn9l5FyXUxFcyG3cDehAo5CybekyKZxcWonM=;
  b=khdVm1GYI6P3PZVwdO1dfAR4z/FyhSMYODKdzzw92KFkDpNg8WZGaGyb
   bhMJ8wi54WXGUZeFs2TjxLnZeJ1P7kai5mYcTsZ1++qbCZ7HygWhvPdJ0
   l1LayzZiXDZNDfIXfYQnamMemN0pZAzigl/dg4zP7EdtWAcV6opVGs211
   JnoXByAa1Pq0YElwTo/M+oRdTZaugV5Rgd4Lb99VRdTHIyUpv0QErcyym
   n2mECykv4CjEKmSGXy4C7670I7/gHIplj4r+exQC1p95QvxKffHQRldpE
   gHhmT1xCHCh22vUEfNEsNuhImQkbSxNl1KbYgYfGfgnvTZrLFs6J9URV9
   A==;
X-CSE-ConnectionGUID: pz/Rlll4R6mYBf0m0pZz4Q==
X-CSE-MsgGUID: 1UMctC67QSKqFAlyffVmrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25276887"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="25276887"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 11:00:35 -0700
X-CSE-ConnectionGUID: d8feYuIJSlek+XSWAkyCUw==
X-CSE-MsgGUID: KzB6jrFWTmefZs0cJp6REQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="100847938"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 11:00:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 11:00:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 11:00:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 11:00:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 11:00:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxEd1V5tEBdTiZd5aDFbECTo5IpKOoj1DhwwUlRY4tV4NO6kwg581eM/LDwz2PFCCm9/MsyEoJaE/7RYGqr+OHUt2i+507OIKdWH06s+jUCTmr1CZTWoast9DU/4bIt0R4tteqT4LYQbkuTJUR0+p9NqZD4JkuP0s45HL5WMg0fVBzqR/Rn2RltP94L21j06HGw7wK+QF40eR7zcTQVC/8pfnrcSSdWDoa7uDxIlLooS9irPJxtaqlcqSnLVV4UYkXmtPu1RoXs0J/UlJdFQWBCftggvsTPKlAqvDWGUzHprJTYad7khLSKPjJut78lfZervUK8oqK/1XOVhB4+sWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SF0KIE3/lmpUHg3eRImbGeEGCpo38bFmd4LwO3WkSF0=;
 b=CDUtROZVS3v5Xa9uXIkLclFPnR5/R+JxbTC9wZjpBoFdSI0uNUVOh53T0VedOFcVX9EPFOtW1oTeR36THOrh9ulZDQ8QLAH1HUAJWpiS2gDXvGLJ0bgIDoGQvQ7w2sek7vj2ujVs172swMYFPxZXr5bAaqpfxCGQ+R6VrDMETq2ZKerzJkC4GIQYHx37vXAPAHuERtQPEDJHvTtUSaecS8pWK1v6lDPRF8oiEQCsLBQiEfr5yRWpwh24KcG6cqKV31i294eFJ5/LivW0Zbj6T6fnyI99yjvxrmwijwVS+Z7FO5uohR7MsHtEMSn8rIACEjwiwvT38N8W9ZHPX86F1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB4528.namprd11.prod.outlook.com (2603:10b6:806:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 18:00:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 18:00:29 +0000
Message-ID: <6a806972-568a-4959-811d-7a666901da66@intel.com>
Date: Thu, 19 Sep 2024 11:00:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/24] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
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
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:303:b4::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB4528:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b6d0d7-b7bd-497c-59f8-08dcd8d4f2ab
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUQ1UW5Uc0hOREZRTWloYlJTWDNDMVZlNVRxRDBoK2J1UnBhYiswMnZicXU3?=
 =?utf-8?B?RHFEaWZrd2J0bDhEVW1XT0ErYlJqaWFKN3ZZOE9qZkRkWC84Y1Fnelpma1pB?=
 =?utf-8?B?Tlk1TGs0d1gvVS9ldWM1SlhSSEFKRVJQSFNRQktVSmRybzg4eTkvWHZkdVVH?=
 =?utf-8?B?NXdrUnlFWTVoeURVYlFLMFBmUWgwcmRURFdMQktyU2M4TWJIWjNlRHFxL0FC?=
 =?utf-8?B?a3pDT3RRMnhzYWRwYVo5K0hWWkNBYW9QV240ZVl4eUhTQWJMYWYvVkEzejA3?=
 =?utf-8?B?WWczWjBmQzNnSzlQUDhtcXdnZVU2STNnSmxuQ01hL3pjaVBqTkNBZlkzRTFq?=
 =?utf-8?B?Lzd1RzFSZjc1c21uanFUODAyaGlDbU10VStPdTMzTzFSOUhGdnBZd2phVm55?=
 =?utf-8?B?Q3BTbDArbStnSk84VTZBL3RKMHR1R1QrdWVheGRlUlg2WVBSTzF1QlBEWGR4?=
 =?utf-8?B?MVZCRmVJZEZmMjRmWlVvbUo4VHQ2dldGNTJac1VaVytxdEEzRTlnQ2U4T3VO?=
 =?utf-8?B?QzZMUjhWYTR5WVZvLzd1a2xjaGFCR2RHanpnN2tmalNmNVlNRTFrT2lNOWR1?=
 =?utf-8?B?dytYTkhSSnl2anh6cmJ0MWd5RFNGeE1DQUtoY1JHazd1UGdabjRkOXlPVG9G?=
 =?utf-8?B?NzNWSnpnc3ZzVTJsQWllK2doZzVHa0ZJQzdmaEI2cHk0SExJZHZBQmdJS0JP?=
 =?utf-8?B?OFl3NVErUUY0MnNyVkxyalBUK3RnN3RTKzFWU1dzRXdVYUtoWXpCY3ZYR0xJ?=
 =?utf-8?B?cGJjbzhUVUhhTkw1Nlgyc0NoT2JFL05rcy9NcEoybVIvSWErM1BoVTdiNUtK?=
 =?utf-8?B?d29KKzloN1grTjRUTldQeWNGcHFhRWJPWjNLR1Z4NkNmZzhFeEN3VUVOTW54?=
 =?utf-8?B?U29LTndTeDhhTCtqVE1HSDRaTjJ6dC9wR0FIekh0ZEZlTWpMT3BSd0p0QnFX?=
 =?utf-8?B?ckRCMnh6ck9EdWthWnpzVngvVE5IVW5IZHY5QzZVNlg5N1ExNzEwOXRRTzFG?=
 =?utf-8?B?UnNMQ3pkWWJCbWpjdG5idFN6bTArYUdCYjlWVk1EVVNJVEpOTWNYOUR2blE3?=
 =?utf-8?B?R3pJQTRPanNoY0dPTXhPQ3ZBM0hqTHlTSDJUN29henR3QVJWajJoZXg2NWhB?=
 =?utf-8?B?eHJuRDlvYnUzRWFzcWUyY3hselFGWFhaYlFESEczbVhkaXFObUNlL2VvZXF6?=
 =?utf-8?B?UGJqY08zNGRpQzVFS3hNeHNLQkpXQ3l4ZTJFTWtPem51SGl4YXE0alFwc0Yr?=
 =?utf-8?B?SkR0bmNhbjhsQXh2WVBYSjg3M3d5MUJ0aUFVWngxa3p1clgxQTBVNU00UEJy?=
 =?utf-8?B?U0VDdEEwVTh3S3Jwd1JrVmUrcUZQM2ZnOU1pUlFlS05idFlsT1k3bzhsVzZW?=
 =?utf-8?B?ZlJaQmExd1JneWxaa1o2TWZBMW5IZzg2TGpPL3djYTB0UnoxZlhaUkxVKzk4?=
 =?utf-8?B?MFBrMHRnRmpyNUxCOG5ZMEpjUVFnQUZyTnJyOGhBTUdwcWIxcm9QbTd5YVNP?=
 =?utf-8?B?eldyeDhLdUFnNk5EMkw3Vm50TE9LUDduNEYyK0FRQ0x5d3hVcUVmRVVDWVhq?=
 =?utf-8?B?VUVubzNDTW8zaXEwQWVIMm1WN2pkK3lHaGRPYm9VL3ZweVE5TnRHVUo0OFdF?=
 =?utf-8?B?c3pOVy8yN1dqU3VnZ3ZtWStXVUQwMm0wQWIvM2JpNS9hWHQvS1BzQ01jdyts?=
 =?utf-8?B?akE1UDJWVjlEcGl6OUMvSktVNzdTcG5MK3M1cjZoSDhTTHAyT25oVzFVckpV?=
 =?utf-8?B?NnF6RTd4NjZ3RVRjN3JLNnNvSEFQK1IrSmIweGQyemhpa1NpRDZnQ08zUkQ5?=
 =?utf-8?B?ZmE3SzhiMjR3TnNCNlRzZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2pDVVZTc0pLK3czZ0E4R3lqUml0OEtyZExaUWtHM1g5RlhUMU9LejhESXlk?=
 =?utf-8?B?L3d4QjhnVGd4WHYxd3dDdXRsK2d6TlNJUHFrcFJtSHdKd3BQVDdnanh3Q3dX?=
 =?utf-8?B?R2ZSSjlZNnNOaVF4T2k1L1IwZTBtZFYwTm1VM21jcFNsVjJJbkU4Y3BmcUVu?=
 =?utf-8?B?cG1TUHZ2amsycEtjN2R1ZG0wTkxKY091Y3hWTW5DalZUNXFUODF5WGNhSktW?=
 =?utf-8?B?OHFueE15NDg1U3d5ZnR4Tyt6ZmN1M1lWZ05HaXFmcGJXUHdoQ0NQWW14Q2Qz?=
 =?utf-8?B?OXJqN3VqbDUzeTJCYUZNTXZkRlZOcStiTVdCWjl5M0dOd0FkRjM2c3d3OHJp?=
 =?utf-8?B?dW85MDJ0cDV5V0JxSDZXSzI2a1FBSGJQZFg5SG9RVllkL2tnK20xekpnRVBo?=
 =?utf-8?B?ZUl3ZHphVGFDNWk1VkNuK2V4UEFNZ1VhOXZMWDFBcVlJaUR1WE5xY2RUNlMz?=
 =?utf-8?B?NmZqOURGMTk3NnpDNTNBSVlNdEtPVFFFRVFVMm1rZXlLZVlPNUhFSU4yQ2VI?=
 =?utf-8?B?NU5NZ2NhN0V1dWNSNElybXgyTEdtUEl1TTZiV24zcHloRDVHSHpqZXk0M29r?=
 =?utf-8?B?NlA2WHFDeHQ1ZnhXa3VzNDdONndYNXBhRTYrOTBzbDlwaW5WV1MvZFV2KzhP?=
 =?utf-8?B?aktWYlBsM3drejlDYUc1alE0clE2Y1NFVjVPd1BiVllpVWlndEoxaG03RTRC?=
 =?utf-8?B?WHhrekJJblVoOWRrR050Nm02bUJjbTl1bVNnT3FkeHZRL3ZpU1NrWjJFT0tl?=
 =?utf-8?B?aWJhQ21RM1Zkc29yNUFHbVNkbGdtaFUrald2cUpOQ0VEM3M2M2hWaGJlQStC?=
 =?utf-8?B?R0Y0K2R6c25GbjVDeWdsVFBZbDhhSDY1a0FBMk9yTjlxSXQ4S2tacUZWamZu?=
 =?utf-8?B?OEpuMGViZmZrcktHYTJHSWY2cFpHSHhNb0lVczh1WE5jLzc1WHZ3MXFjSDVp?=
 =?utf-8?B?VVdoRVd6WHNBazRvdzlMQStzWFNMY0p1L0xNYlA3R3lBUE1Cb3hldlhSYllP?=
 =?utf-8?B?VTlkMmNlQ1lqN2RUTmFKbDM3emI3YWVYMVNPR2d0eXJvK0VxQUlpUk1ISExh?=
 =?utf-8?B?bEE5YmFLeEs2OHhJWGg2ZmpyN2JyMkducUZmbVBIVWsyVG9CYy84cnZwV2J5?=
 =?utf-8?B?Tnhlak9YbDVWWXlLcktHMnJLckFMRkNEbk1KcExzWjl1QzNsaDdKdlFrclhW?=
 =?utf-8?B?ZDFDeGYyQ0FhRGgxbnovak56SEVPTDdLNzlsK3hIT2FVOVV4NHJZamxTNjVx?=
 =?utf-8?B?VUNRdWZLL2gvVmlvbTlHbk9pWUtTaXpTbTBEUmxQQkhRZ2ZGUEtQOHBXdXYx?=
 =?utf-8?B?SHpiNW5KRFdJTkpaNThKQkdnU2JUK1JyNVdOdWEranV1MjF1ZWpjYTVPZ2RI?=
 =?utf-8?B?V0p0TUxQWkV1V1FNcHJ6aEcwSXpNaHRFWWlSUW9ZRFJuay9XMnRiWE44LzN2?=
 =?utf-8?B?aFEzODU5M21henhmck1Ra1YrSW11YVBuOHRVYlEyTXlhdlNzKzI0WFFINmVJ?=
 =?utf-8?B?ZlFzenV1eFA1a2VvU0NqZHR0YXhKS05GSDRMUEx3Q1haamZ3eTh0YkhVdFdW?=
 =?utf-8?B?SWRjNGtVU2srdFlNOUpZVWRUZnlnOTNBdXdkZHJkK0VESFZwMTk3QU9lKzlJ?=
 =?utf-8?B?WGdpdDNYbFFaVEdrYjhCTG5kMElWZk92MTM5dlNYdnk0a0lJdGQyZVpqSEcv?=
 =?utf-8?B?WUN6cDAzRzVEdG1kek51TmlMc1FORXYzbnYrb1pOc0pwanlqNzRsejBKb3VM?=
 =?utf-8?B?bmFMZ1RRblhOM1BxaC9jbzFFcmdUbjlsc2U1eXhUcFk0bWR0UmZjaFRubGVm?=
 =?utf-8?B?NjhLTWgrTUZTWS9DWm0vOWpSemxMVUo0NTJYaHRCdU1zdWlKT0F6b0pHZStL?=
 =?utf-8?B?blJtZTZkaXNlMml5ZEdsOG9zMDl3ZUNsWDB6bm1kTHJYa2VnVGt4eXBYeE1Z?=
 =?utf-8?B?TWExNUpCeXBmOE9oS1dkdCtyYk1zVUUyMUlZTDV6NXFpeHhXWXpPcjNaajlC?=
 =?utf-8?B?S2JXUzFXWmozVkp4Ri9lZ2h0VWxMMHRBdWVRdmx3cGN5NUF5anFKanc5ZlhG?=
 =?utf-8?B?eTVvaDczMTdIYW43U2hwSnZ4UmYyaXBvaHQ2ZHdqd2cvYW84QTRObE5LNWo3?=
 =?utf-8?B?dGwwUU1JM2l3WEt3ZExjYllDTytLMEVnWHFTb3lsOUNQSGZEQ2crOVVKTy9E?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b6d0d7-b7bd-497c-59f8-08dcd8d4f2ab
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:00:29.6793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfhU/yMEKGI5jbUrBKxuZ4c/C6+hhG+RGTBp2crD0AN2JgY/HqKoAPNjXpt/P+8W2GJ0183/zsFXLYbQm2QCiWCBRWmnBTPnAOsbSzkei0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4528
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> # Linux Implementation
> 
> Create a generic interface aimed to support user space assignment
> of scarce counters used for monitoring. First usage of interface
> is by ABMC with option to expand usage to "soft-ABMC" and MPAM
> counters in future.
> 
> Feature adds following interface files:
> 
> /sys/fs/resctrl/info/L3_MON/mbm_assign_mode: Reports the list of assignable
> monitoring features supported. The enclosed brackets indicate which
> feature is enabled.
> 
> /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs: Reports the number of monitoring
> counters available for assignment.
> 
> /sys/fs/resctrl/info/L3_MON/mbm_assign_control: Reports the resctrl group and monitor
> status of each group. Assignment state can be updated by writing to the
> interface.

At this point I think the architecture is settling with the remaining work focusing
on polishing the code and making it more robust. To get confidence in this big addition
it will be valuable to hear from Peter and James to confirm if soft-ABMC and
MPAM can build on this.

> 
> # Examples
> 
> a. Check if ABMC support is available
> 	#mount -t resctrl resctrl /sys/fs/resctrl/
> 
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> 	[mbm_cntr_assign]
> 	default
> 
> 	ABMC feature is detected and it is enabled.
> 
> b. Check how many ABMC counters are available. 
> 
> 	#cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs 
> 	32
> 
> c. Create few resctrl groups.
> 
> 	# mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
> 	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
> 	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
> 
> 
> d. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>    to list and modify the group's monitoring states. File provides single place

"modify the group's monitoring states" -> "modify any group's monitoring states"?

>    to list monitoring states of all the resctrl groups. It makes it easier for
>    user space to to learn about the used counters without needing to traverse

"to to learn" -> "to learn"

Reinette

