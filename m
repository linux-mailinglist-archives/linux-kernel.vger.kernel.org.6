Return-Path: <linux-kernel+bounces-351434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 994D599112B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05507B22FF3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAF71ADFFF;
	Fri,  4 Oct 2024 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fV73ptV7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF8715A856;
	Fri,  4 Oct 2024 21:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728076168; cv=fail; b=rE85ak09KzKsFC9RvdxpoTWQ+4OA23F1kklz1dqhrP0Xpp/XEdO5NRcvFuFfVQ3erIPppqkLzQXGEEJXUbO2R95otfiFu0/mby1cQ3bkYkFdZjVJnMxSO1w8JU2aaSE2soKT/WdRoAJ1L5LqaYK4QicZqx7XScW/0cQdOw5yIvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728076168; c=relaxed/simple;
	bh=B38/A5cACbtYcq3iXwGhAkva6vc47fuMk0EER/dlmF4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RPEOsfN4v28g2ebGoNo4vgyblBMEh3df0aCsslpIVj5ZQFFYwqTRj06/DObQFTuWLMAFhF4AyrIPqpRJFgRf1W1wqVmLSq//+F88yCMo1TdgKn3Gmy33gT/7qYb4OxtzsUY2Ff7aJwEJy6LGL9gXUaXNF683jc+8IEbGc4PfuJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fV73ptV7; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728076167; x=1759612167;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B38/A5cACbtYcq3iXwGhAkva6vc47fuMk0EER/dlmF4=;
  b=fV73ptV7j5mM+nCPmwa/XVxEPUIyMkLbKpNp3cVHbWUNsbi4rmzoSPUv
   hpKorSHGpIAXc+RY+uT6LkzqZh1zoQw0UHPnZQyUyKGMOTQG9n/jY9S67
   CGFDq4SQLwCBOgoIztl1rBupc1ebjHZ+AB5FSEUWlzfVw/XQ41iman+oy
   XUi0jXCaEVDCBz6+F0I0FXXLMtCk8lqGEZPIv6SbZPJKi0+7uNzG97I7x
   2l/0wOgcB86NrL5ZsOggMbhC2DDn9M1lkjfh1mNjwRQE8pibcib37sS06
   0/nWNLsozGi823hfKkGJi8WV2+z7QLU/iZ6ewDuhb49lUSSCYMOdzXNDS
   g==;
X-CSE-ConnectionGUID: NKgI7ryeRWyeh1jJYvUXHg==
X-CSE-MsgGUID: ekBZ05bFRaGqNvR2RsQ4HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27190327"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="27190327"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 14:09:26 -0700
X-CSE-ConnectionGUID: t4EnV+TLROmG0w0J42+O4Q==
X-CSE-MsgGUID: /Qk+ikqNQXSaU3RnEoq3Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="75072147"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 14:09:26 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 14:09:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 14:09:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 14:09:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 14:09:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JII1v3AOH6i0PW8EwfW1sMY9V8XA1gRAB2a8RHnu7aeRYmg2zKlvlfr8Pl7U+m/x3i1CfClsakaVrZwrE7x3RpHBj99uwSkreYcx3xb9QNExRoylftwua6gS92RmrYjX74TJ9xpGFfdV0C8ehDgDgadRYCUc4hvEH8rxDAY0mlMtyupmLd9G0RXqnwNyMcVJl11W+J3aIndqtH0wxbGbVUy9HXIu5gKWlGrZR/a0+ukvFuexWbNbcMluPcO+EwwMMM+ahQfeMzwSOUeiHtF11Ij5cdBwf57VcDkzIfTokHsWUrBeOYp9/upQiiss/9cyDU2EqACValDF0vqbnspRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMt6XTdsJGsczMXk411iyWbRbAoB/EsUKH8omi3ghtQ=;
 b=sV2plGeKtoqY244cOoW99uqhzbTVba5NVCuOgQnO74Gpz5CApbnMa33khiHvpqqDGjgvoW44fYz0ys2ReVy7RfcdeuTau6WUjTCJI+l7zF5pM79EuyxglCoaR5Hcz9e+vMKDY08Vzh/ZNI3R7OlevXo617rTKQOyJhQuWJ7L+D27dJ+vQnBzhvmoY/xPN2mz9Cdg8zxWnCnxQ5n5mXq2SQamUfoB8tnX5uLa3xDZnDmUiLDF5KZ6oAw+cx/oXwr4l4dx4cgJRCVQu0CArssA+M43ya+fw+dzxBMk7npUTWlJXJH9He1CHebzv4fvEqlLcNfx9CkVOKT5E4P/3urgbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7042.namprd11.prod.outlook.com (2603:10b6:806:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 21:09:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 21:09:19 +0000
Message-ID: <fd138377-3a69-4749-b32c-f7bc3783a611@intel.com>
Date: Fri, 4 Oct 2024 14:09:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 24/24] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
 <68c8ef0592c653c5b99cd26d982966cd4a41cb31.1725488488.git.babu.moger@amd.com>
 <faf50d1f-d3c1-4a9b-a87f-4598e88dc9a1@intel.com>
 <c43171f4-48c6-b6c3-d71e-1f23367932d7@amd.com>
 <1d987ed1-0065-4e4b-a719-65af93907974@intel.com>
 <ca7b1d14-e37d-5f0d-9371-32d8506e51eb@amd.com>
 <cd2d835b-cc63-4416-b0ee-20334b9b43dd@intel.com>
 <3b6a8ec9-5e4f-e4ff-cd01-96ecc366565a@amd.com>
 <4c212746-6d61-44aa-abc6-2d2155ee538f@intel.com>
 <1f7addbf-51e3-7f24-ad64-b8a6d9c5e0ba@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <1f7addbf-51e3-7f24-ad64-b8a6d9c5e0ba@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0314.namprd03.prod.outlook.com
 (2603:10b6:303:dd::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7042:EE_
X-MS-Office365-Filtering-Correlation-Id: d7014bb9-65bf-4f55-8da7-08dce4b8d005
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qld6Vlc4bUFXdmR3bXNMSUpjL2ZCWGxiV1NZWkczbmhvMVlnNzVnMmJNcSsw?=
 =?utf-8?B?cEkzZkgwdytScHRraWEwZndaMzF3L2VqTVZMSWpUNmx5V3RrckQwZm5EZ0g1?=
 =?utf-8?B?blRXVXNhd1plOXk0cUtnc2ozQ2RtZkFsNmZCTU82b042eTYybnBkU0ppTWRr?=
 =?utf-8?B?TjROcFl2eUROcmNaOVlEdWxINVFwbWFUVm5UUlR6ME1pOUhYUk81cllLc0Q4?=
 =?utf-8?B?bVNUZStJVUc3c21XQmE3dEhzZnNLaEtOdFdub2JwMGo4cHU2MU9xbTR3Nzhm?=
 =?utf-8?B?bG4rUDNmeiswWVpEM3NiZ3JvK2pZVUlNdGt3T0pJTE5MZjVzeTFBV3Yzb1kw?=
 =?utf-8?B?WGhhMFlYKzZEL0dRMjRlZjJuSVJ5NThsMEVsSytOS0tDZmpheFVhZ1FVSXpP?=
 =?utf-8?B?QXdLenZDVEkzNkRUVzlFNEM1akdhbWZoV2tJRTBzMnluZHIrZDlqK1Z4eU9m?=
 =?utf-8?B?djFmTmdmQW9lRXdOU1VFZlloc2dKZHg5WG5hdGZnM0VVdk0vMGZxOXdTbXIv?=
 =?utf-8?B?Z2VIbUVGQjJzbHh2TGRqVXprYWErYi9MMHI0eTB4SDZ5a0JjTnVOLzhVRnZ1?=
 =?utf-8?B?N05EU3MxcHgwallGdkc5SXpqaGUwZ0dOdlp4cVVvVWFKR21OM2NRK1p0MTNH?=
 =?utf-8?B?eHJUOFJ2MFV5dW5mdE9JK1N1TGZqbDEwQzE5L09wMDZhRVdrdllxVDFJTmUy?=
 =?utf-8?B?cXFHNUl4czZDNjU2MTJTWmowUEsxQkFCM1N5OEIvZHB2Z1N0MkVERWtlcld2?=
 =?utf-8?B?bjJRa2hhS3hSUlg3c0czNGx2UjYzUHdYRUZqVU5tNXRxajJjbXppTnh1blN3?=
 =?utf-8?B?QmRUSm9zWitXY1d4MG51T01TT1BwcGhCTko4Uk1LamNtRzZsL2hINE5uM3Rv?=
 =?utf-8?B?RXNNOXFET095K3dKbVlRSFIvUjIrbXV0bVMvbTNKZXh0dmQvcms3dHdYOFRT?=
 =?utf-8?B?MFdURmtRSEt3Z1NuQUhRVXMyVzFpTy9DRWkrSU1sakh5WjhyNFlKV1hGbDcy?=
 =?utf-8?B?MWJybEx2NHZ5Y1ZMUmpmOWtodkcrVFVVeFp1MHRWM0dGTEhTMlluREx4OVFD?=
 =?utf-8?B?K1hzck14Mzl0S3hVZGdsb25WRjNoVDF3TjNPWnNyUUxIbXhUbythckN1bEpL?=
 =?utf-8?B?VjQ3a2o3N2VCOHBrMzFoS3B1U1Jva3BMUndMdDFzdFNORWRQd05LUUt5VFN5?=
 =?utf-8?B?U0kwQXIrbVZnZ0t5c2tHYUZlcVBMaHhGTDBIbEFZRDFJSHhsUDdQWG5lZkNE?=
 =?utf-8?B?OHN5aVFpeDYzUm1LZ3BxN2NLdTJ0cWFTV1oxMk9Tbnpsa3prcWVmcVcrbDRo?=
 =?utf-8?B?b0tqUmZPUzFsbTl4bHB5T2lxdk8zQU5WV2xWVDg5ZHRhRXBUMzNXQVlQcTVR?=
 =?utf-8?B?V2ZpS0dnVHBzOUVxOVFxK1B3MjFIalM0cjJGRTluUXdQcFRtVE4vc1d1ZG96?=
 =?utf-8?B?K2tUTWhoYUhGWndzY0ozZ3JxZlVxSUl1WGI1QmV5YUVaZGs5WHg2b1RhL281?=
 =?utf-8?B?eDVISWMyQlFlNnR0T0dnWWpWbWNoVGpReTdFV1Nsc08raG1BMkIvdi9wbmZs?=
 =?utf-8?B?U2h5d2JTSy81OG0wbDJLN2I5b0FwRTZQOTJlNUVnSktlWUdwb1E2S0gxK1pa?=
 =?utf-8?B?VmtVMFQyVHBFbitXQldDVnpxc3dMOEthN3VsNzZxL3FKRHVMUXBkZFUzdkFU?=
 =?utf-8?B?NUV4aittTEhPUFNvWmJWYWpyaWlaOFZySGhjTW1DUVAwTnNVZGlmYUt3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Si9UcDBydk5pYkNhL3ZHbnlvcnZTV09zTStIU2pFUUs2VzF5SjluK2FGaHpL?=
 =?utf-8?B?QnFVanNza0NtWUNWdzBNWC9vajlaNEJ4Z0lBLzFITDZBVndDTWU4d3VTZlpL?=
 =?utf-8?B?ZXlIdCtiOGt2MENsWnR6akFDc2JiNlM4ekpwWk03KzF4WjBJV3JrVE9sNTFv?=
 =?utf-8?B?WWhoQVlyeStSeXVseCtWZm1jUFI2bDNUY0NBbXVmSmFvQTk4SENKZXhDakFB?=
 =?utf-8?B?K09pMVFJbGRzdnVuN0U2YkF4Y3pDNXhPTDZvZlFNRTJMYW03UUZuNTdLSHE0?=
 =?utf-8?B?bkNwYlVhbHcxckN2VXNJMDRTWDNJS3IzV015cDJkTnNLRUE5eEdrRHo5NFVZ?=
 =?utf-8?B?azRJK2dPT1gwNkNOdVBzcEpma3VpdXc1UEVqY0wyYVJCMWJESFBqR3VhMDJE?=
 =?utf-8?B?TUFKTys1RnBkZVFwd0xCL2IyL1BrNG5ZWTNvdTFya1NWdHMrNkNxYnpmaDlj?=
 =?utf-8?B?OUxVb0hhTWZlU1M1cVVudU94dlVUVDFmU1ZuU01vZ0dHR1dkaVFtaGhEcmIx?=
 =?utf-8?B?MTdnbDljblhQYnRPdFBYdjh4UzgzNU1WbW5xMkh4ejY5a3p0aCtKcGVnTTJv?=
 =?utf-8?B?M2xwTTdoMGZOdDczVmVnV0l6eENMVDliQzFQTHNBZUd2WjFkRlJRaUVwb2pK?=
 =?utf-8?B?YnZmNER3YkxFUDA3V3ZUSVBVMmJiTTRiUDV4RVU2SUhEU1lteFRKbENWZ2F3?=
 =?utf-8?B?RU51TmZRSXhNWklrbkdLalZsYlVSVThIakV2MzVLemUxVXl2czdWSzVlbnpZ?=
 =?utf-8?B?Slhwdnh5YndFR0dic2s1bmROelpQTjFCbDhUMnF0UEF4WDNINFdZY1FtbUNM?=
 =?utf-8?B?MU5UcGRLQ0xGRFNtSmhQc016U0RDU2N1RHNOVjRSdFJNeWg4ancxbDh2RlVW?=
 =?utf-8?B?bmFJRnA1QlRQSDlCclRQRWp3OWZjVnRndkRNbXI1b2U5YWIwMzdVWEE5T3hR?=
 =?utf-8?B?WGNHOXJvOVIraHFhcjdZRS8xYTI0UzdMTU45NEZHM1RXNGV2MzdLNnBmSGUz?=
 =?utf-8?B?ZWZqdU53OGlqYXZ4UXhqZnZqdi9zVzdrcWJUdXp1Q2Vhc1ZxTkFZNDhLZTMr?=
 =?utf-8?B?Q2VsZ0ZCVU4zdi9JVEdZSUZhT2R2dzVweDI3YVprZm5FQXU0UkUwYS9VbHhm?=
 =?utf-8?B?a0V2cDJUSkZGWnJLNjE3ZEhkSGdpOHBVV1hJaEkzRGEzT2VYemIwSnlqOU9q?=
 =?utf-8?B?eGx3R1JSL1VTUko2ZFV6NGxpRU1lTnNsMHpUQzlhRHBEbEUzNWhoeWFOaHlI?=
 =?utf-8?B?bE9UeUs0QU9GOFlKSXl0QkxwK1B6eVREMHdrVzM4eFovR1g5WXUxMFYrWE01?=
 =?utf-8?B?VFhTTDFpdlFsZHVlaGRLQytFeHRMN0hPRDEvSTBnVVlKWStoek50aW9BWFlC?=
 =?utf-8?B?cnBNelRlOEpFWDdRb3U3MFJnckU4UFdGT0tZYml2clQvNzVyK2NHNWExeklK?=
 =?utf-8?B?MVpTbkMzSmxISGhoRnRWY3BTa0RkZjMxY2VjYnVvVkE0c2NkZk5mVkk4cHdG?=
 =?utf-8?B?eFMrOXE2ckNBd28yN3hycVVNcTlTT1pFNk9rVVpkRVpTRmxSb29VWEg1amNn?=
 =?utf-8?B?RklHNXZpQkZtRTk0anFZZHRsNWZSVmdSTGduZVpzL0tYWkt3NGQ3aE9PV2Vn?=
 =?utf-8?B?VVZNVXRZcVQrcmlZdWpGRUc1NElwcDRoQXp5L1pDUlNRaHVEZHVLM0N5MWdN?=
 =?utf-8?B?bkJHTCttc1o3cHppQmFQRHFLdFNaZDFnK3JjK3pTOXdnVFlxQjJJaWV0Qjlk?=
 =?utf-8?B?Sm92aVFkUEc0UkxsOGRFVERWRU1WWk9qcDhybFFJVmNIdmRhSW8zbkZCSmE5?=
 =?utf-8?B?Q3dVM2FTdmZLOTFEVjhIQ1FmRFRHNktITkRNYmdia3JVZ1JYSjRJajBkRmhL?=
 =?utf-8?B?Snl3aU5FMU1EL0lkNGhqbXZYbTRjUTdLR01QbS9DdHdHT2J4YnNNVE1PcXVF?=
 =?utf-8?B?bHo5eG11NGt6OXVNRmpmRFhPVEl1NnhOY3BlLzBlbzRyVHhibEQ0ODd0S29Z?=
 =?utf-8?B?U1FsZHdYenRQMkNwUFd2NGpXcGVUUDlvcWxkY29KN3dxaUtJQkIvUjZxbzRX?=
 =?utf-8?B?cmg3NTJZV3BVRWl1V2VUSHdqV01ocnI2OGcxcktabkljUW9tZGZ3SHJMblI1?=
 =?utf-8?B?M25nRWRJc0FOMjZoaDBQTDQyQUQrdWlWMzAyOXhIWWdqS1BlYVp3MjdySDBN?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7014bb9-65bf-4f55-8da7-08dce4b8d005
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 21:09:19.5985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxc4Vtqd8Ptj6I28DdEJ2GPvBewK6ymKHG3ItXylAIRQ62vC8UjxBelRSzswl/vETCAk1FQNqbR9ZtqpeeKOVeNco9v1p3mT8faf0wb7RhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7042
X-OriginatorOrg: intel.com

Hi Babu,

On 10/4/24 12:36 PM, Moger, Babu wrote:
> On 10/4/2024 11:52 AM, Reinette Chatre wrote:
>> On 10/4/24 9:38 AM, Moger, Babu wrote:
>>> On 10/3/2024 9:17 PM, Reinette Chatre wrote:
>>>> On 10/3/24 6:11 PM, Moger, Babu wrote:
>>>>> On 10/2/2024 1:19 PM, Reinette Chatre wrote:
>>>>>> On 9/27/24 10:47 AM, Moger, Babu wrote:
>>>>>>> On 9/19/2024 12:59 PM, Reinette Chatre wrote:
>>>>>>>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>>>>>
>>>>>>>>> v7: Simplified the parsing (strsep(&token, "//") in rdtgroup_mbm_assign_control_write().
>>>>>>>>>         Added mutex lock in rdtgroup_mbm_assign_control_write() while processing.
>>>>>>>>>         Renamed rdtgroup_find_grp to rdtgroup_find_grp_by_name.
>>>>>>>>>         Fixed rdtgroup_str_to_mon_state to return error for invalid flags.
>>>>>>>>>         Simplified the calls rdtgroup_assign_cntr by merging few functions earlier.
>>>>>>>>>         Removed ABMC reference in FS code.
>>>>>>>>>         Reinette commented about handling the combination of flags like 'lt_' and '_lt'.
>>>>>>>>>         Not sure if we need to change the behaviour here. Processed them sequencially right now.
>>>>>>>>>         Users have the liberty to pass the flags. Restricting it might be a problem later.
>>>>>>>>
>>>>>>>> Could you please give an example of what problem may be encountered later? An assignment
>>>>>>>> like "domain=_lt" seems like a contradiction to me since user space essentially asks
>>>>>>>> for "None of the MBM events" as well as "MBM total event" and "MBM local event".
>>>>>>>
>>>>>>> I agree it is contradiction. But user is the one who decides to do that. I think we should allow it. Also, there is some value to it as well.
>>>>>>>
>>>>>>> "domain=_lt" This will also reset the counters if the total and local events are assigned earlier this action.
>>>>>>
>>>>>> The last sentence is not clear to me. Could you please elaborate what
>>>>>> you mean with "are assigned earlier this action"?
>>>>>>
>>>>>
>>>>> I think I confused you here. "domain=_lt" is equivalent to "domain=lt".  My reasoning is handling all the combination in the code adds code complexity and leave it the user what he wants to do.
>>>>
>>>> hmmm ... and how about "domain=lt_"? Do you think this should also be equivalent to
>>>> "domain=lt" or perhaps an expectation that counters should be assigned to the two events
>>>> and then immediately unassigned?
>>>
>>> Yes. "domain=lt_" should be "domain=lt".
>>>
>>>>
>>>> Giving user such flexibility may be interpreted as the assignment seen as acting
>>>> sequentially through the flags provided. Ideally the interface should behave in
>>>> a predictable way if the goal is to provide flexibility to the user.
>>>>
>>>
>>> My only concern is adding the check now and reverting it back later.
>>> Basically process the flags sequentially and don't differentiate between the flags. I feel it fits the predictable behavior. No?
>>
>> This is the point I was trying to make. If flags are processed sequentially then it would be
>> predictable behavior and if that is documented expectation then that should be ok. The problem
>> that I want to highlight is that if predictable sequential processing is the goal then
>> "domain=_lt" cannot be interpreted the same as "domain="lt_". When flags in "domain=lt_"
>> are processed sequentially then final state should be "domain=_", no?
> 
> Yes. that is correct.
>>
>> If sequential processing is done then "domain=_lt" means "unassign all counters followed
>> by assign of counter to local MBM monitoring, followed by assign of counter to total MBM
>> monitoring". Similarly, "domain=lt_" means "assign a counter to local MBM monitoring, then
>> assign a counter to total MBM monitoring, then unassign all counters".
> 
> Yes. That is correct.
>>
>> If this sequential processing is the goal then the implementation would still need to be
>> adapted. Consider, for example, "domain=lt" ... with sequential processing the user
>> indicates/expects that "local MBM monitoring" has priority if there is only one counter
>> available, but the current implementation does not process it sequentially and would end up
>> assigning counter to "total MBM monitoring" first.
> 
> Sure. Lets accommodate the sequential processing. Process the  flags
> in the order it is provided. I need to make few changes to
> rdtgroup_process_flags() to address it. Hopefully, it can be done
> without much complexity. Thanks

I doubt that the implementation would be complex but it may take some effort for it
to be efficient ... taking actions that involve changing kernel and HW state for each
flag as it is encountered vs. parsing all flags and changing kernel and HW state once.

The risk is that a simple request like "domain=lt" may take twice as long when
doing sequential processing. When users provide flags like "domain=_lt" to take advantage
of sequential processing then there may be an argument like "user gets what is being asked
for" when things are slower, but I am not sure the same can be true for a user
that just wants to run "domain=lt".

To me it seems simpler to require that "_" always appears by itself and that
any flags set by the user using "=" are combined during parsing so that they can be
acted on in a single flow. If indeed users want to do something sequentially
like "unassign all flags and then assign local MBM" then instead of "domain=_l"
I think "domain=_;domain=l" could be used?

Reinette


