Return-Path: <linux-kernel+bounces-214186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA8D9080CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7461B1F23047
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCB71822EB;
	Fri, 14 Jun 2024 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6HYzWBP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9482AF0F;
	Fri, 14 Jun 2024 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329266; cv=fail; b=PhubqnWU67MqurGQmxwBS2KE+UUSA18KZ7dWJkYrXKDikYq+S4RFXnbY+86CIf21OvfnXSSn0CmyFaGHH/WcTm7HorkkGS3ws+NWANdtr5MAVn/gTLjhqnoYJuhfC8/2FcqyJvEgZIxT1K9g7GzMNAgbYht8uBsGVx9HIEq/lNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329266; c=relaxed/simple;
	bh=szaKRhwcxmqzMKk14Zz9lu5J4vwcK9UDauSMsFdqBvM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P9UsfJn0CHKe3+dV0vnNhHOxXI6rydK1Nc3ek0jV2AnIymX8gL/NzAboL3lGMih+H8BMODbR3Ad82NnPjnTJoLrUB481TNeAFS7X4bY8a+T0dE+ISq7YJzC0FeX5uLEgwoUzsegbFqX4BO3ZoJLFCDMubkJdYkJhetTu+lzxTm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6HYzWBP; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718329264; x=1749865264;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=szaKRhwcxmqzMKk14Zz9lu5J4vwcK9UDauSMsFdqBvM=;
  b=i6HYzWBPBiFNX2xTDWNKuWTE9g7osJv8VC02aEpeajLWBn2e5wdSpY5v
   x7/BfX95KamQCSVRO33xNeIOJVOLci99K4RIcme5N9J5IBzCApeEc25fR
   OaZpOsDI27rtdFqQ460iAHq7ypv18/8b7hh7HQu0hM4nVA1JWK/Le9O+6
   61cHPiMRCN8uJyyOsIcO23EiuJN8kj/PNGdefLAsIQTi3WOsII+fUNvow
   iiMCxsIfqLC0c5F/GF1U5oCbl9LLwmMX9vru1UgeGay7N3tctA2LS1msY
   sxi3LsCbB+x8kXq7NLJjpzXCR0Eh73/EXU74lD/7/S+RA2rqukTK+TVu7
   g==;
X-CSE-ConnectionGUID: Yef1nY1MRU+9HQWYHYdhtw==
X-CSE-MsgGUID: 553G9/MzR3Wf+kfoscdyZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15072089"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15072089"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 18:41:03 -0700
X-CSE-ConnectionGUID: QApqZU8cTjKR01Ok3IGjjQ==
X-CSE-MsgGUID: Plmxor2dRn6veuyuqu0BkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="41062636"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 18:41:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 18:41:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 18:41:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 18:41:02 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 18:41:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muv7bKc2Hl8ydhWyj5uzV5TAzvJweHHDZjGmMr0+PlGWkRsgHgRhSXEocxbOzw8PgGciTfOODd8qUmSZTXszhXvyHETrdxcPaTT3TyWBUDoCO7s1egdUfl4pq3rR19GECWQRRhkDi1OJGncPiksqLTwujM5cTqlmU3wbdxuuQdgiZ08+xXhIWAvHXmSfaSFHZ0QiVuG5fGbYvyKI5Ku6bnjKKnnYBcAhGmomAAzUlXYMnteo4oTeNgQPZIVBvlXz69rY5BC4bjlCW3sh0SI8uQ1by7cdTTsyGEHPYz7eN3bvRK1mnHOgQZZKFca6rW02mgnKdJN04DQIlKYVIm0v6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8bRFy7ZyZnryfv3iQ9N2bxhtDe7TUY7XX9Mv0wN3lg=;
 b=RNM8FkPMZ+Pd6K2XuB5VXB0EkmoG7MFWh3XD86QuRVZ2gIC1ZgZB3u8wfeQlwNXDnkYmbKPsfd3j7CktNsCBCYtA03j1ZdeHcKzm6C+6NqHJuqijQb5iuNgH/QS4Azve497u8yXQif5q1T4Y5uUtg1zlC3Eh9vrfbyA2iOdlWijM8NPXJ68mBysvt7Np8SdYBjs0c0UD9DdH4+DTXZdFfJqHqGTNBPwKR46YWYKMOjygoyAJlnViNmwW9dIU2WMfCHgLfI40JQpCsvcizmK+oG6WjS0lSd2t95Yr/iTwo+608IwkU5V7eMmE7PG1iZNv5mrBXPF8eKzohwJn91D4Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6885.namprd11.prod.outlook.com (2603:10b6:303:21b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Fri, 14 Jun
 2024 01:40:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 01:40:59 +0000
Message-ID: <a453b19b-a909-49a5-9512-ae69c48db6c2@intel.com>
Date: Thu, 13 Jun 2024 18:40:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/19] x86/resctrl: Introduce the interface to display
 monitor mode
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <3b9ef8bc03c1004794a087537c6f2f051760402d.1716552602.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <3b9ef8bc03c1004794a087537c6f2f051760402d.1716552602.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0385.namprd04.prod.outlook.com
 (2603:10b6:303:81::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 4471b0e9-252d-47fa-a594-08dc8c130b00
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cU52M0hFMW15dVRhWFA2YXg3cHRPTjZ6ZncyQ1E5ZFhSVGtjdnhmZHhjMTVI?=
 =?utf-8?B?Y1VCRUcra0lQN2lvMElmbmNlZTdCRnZMb2NzU1F3L3dNaklhY00rYXlRWlhn?=
 =?utf-8?B?emRiVUN2dThvVUFFMEF6ZlZkWDBPelNjY1hrQW5QMmp1R0NuUDZUSEpLTm5N?=
 =?utf-8?B?TDM2QTVUZ2FObXZYWEE1L1hUeUQxMkI3UEloVHBFNUg2eUhSZGVNYW83d2FS?=
 =?utf-8?B?QmRjd2dvcjRXOVlMZnRkcXNURFBtams0cWJsVE5kMGU4M21wY1V2ZjdOeWJk?=
 =?utf-8?B?dUhVWHQxbC84ZE1JZVFqRlkyT0tPZUQ5cEVhVVcwaVQ1bGRXK3dwZmJFQWNU?=
 =?utf-8?B?WDNBOGpibnhoeTRlSXBtaE42cHgwazdjMDJnc0NmOHJ2WUhGVlExQjNPak9k?=
 =?utf-8?B?U0h0a1lLSWdFR0tUNk1WZ2FyMGNnUXFtQTBhWkV2MmxUbVVnT3FLcXFUTy8w?=
 =?utf-8?B?cFVKZTAwVzc3cHp6ZUJGVUp3MGk4ZGg3a2pUZjBxcnczdy9lRmdhK0VNRlFu?=
 =?utf-8?B?dXdvWTBCZi9NTmJndTh1Yi93bGFYLzFUV3QwZ0lQbUJIRkRQcUtEaVAvd2hP?=
 =?utf-8?B?c3VJd0g4Vm84ZkttZ3VvdWN1ZGRpVjlBTzAzVmw0MTZ1NjhpZjBsTkQvZnRo?=
 =?utf-8?B?THdiK1FJdEl2cXQxQzc2dDVZUDEvVXlpekRFYURncXVnc2YxQzJFa2N5VWda?=
 =?utf-8?B?S09NRlhsR1lnRiszb0dBQjdmODZpSWdUWE5BTXhIY0RRYzZGVHh0SFRYVFIv?=
 =?utf-8?B?NjNRVExnbUZZaHFzSG8waGh3TjZHbVVKTXZOU2MzRU1VRTB6amkwQ1NsYjZH?=
 =?utf-8?B?ZTVKZzNPL3k0cDRXOWN1a2hnUUhZenFqL203aEFZamxESFFOR2lJNS91TXEx?=
 =?utf-8?B?SkNHMXlOSy9QdVg5T2NJa0JxZ2U3NFU5QkgrdWIzM1U1SlR3RWsvZ3czNXRq?=
 =?utf-8?B?MStrUjhYUHlnRnpGeGNMMU9UVC8wbVl4MDlLWnh1a3BDeTZBRFNPL2NKQUZZ?=
 =?utf-8?B?dTgzWmp6eFo3Y1o0UXBjYkV1UXNESTVlNk9LWHQ2R2RVbkxyajlWWFRwSUc1?=
 =?utf-8?B?eEs2SDFOcFVsT2Z6ZlBnd1FZS3BDTDkzKzVFd01oYUtUZno1QUdydEFCUWpZ?=
 =?utf-8?B?UitCdVJOS0oyQ2w0MnF1TXdiN2JjS2paS2NqWjhGbk1WcnluMkJBenc5VGVt?=
 =?utf-8?B?R2l3RHF4a0kydVB5SnJKdlNKUUM4NFAyRDVUTzdOU2xHVVE5dUZ4cDE2eUpJ?=
 =?utf-8?B?cmtWTkp5bjgvaklhRlhYd2VpYXhXYkpZTjdDRW13ejFiY0t0VWI1NFBsS04r?=
 =?utf-8?B?K3VrVVcrYTR0NHE3c1dJWEtzdFR3RnVaQnBuRmx6YjNLL2ZpR21BNlN5VTVF?=
 =?utf-8?B?WWxkYytMKzRjeVlSTlBuVFhZR0ZTc3lnSHNvdktaZXJ5Nzl3THNaK0RPcU9u?=
 =?utf-8?B?Z2hBdzI2MEw3c2Uya29BSUZUU1hDdVNOUVRySGdzcDBsVU5VbzJNTjZRQUY1?=
 =?utf-8?B?V0x4bFl4eTlZQm5RcXFmeFJHV0ZVSG5waTcrcy8zYjhMMjVDanFuN0FPY2xM?=
 =?utf-8?B?N1hOTXREU1kzamE5TkVYRHRpV2trd1UyWlBxQ3VHNEkrRnVKMEFmbnFEMkc3?=
 =?utf-8?B?MzV6bE5lSzJKeDl6bmtVMm02Sy8wR2Myd2wxdWFLZUV6MlRjZ0xqYUlsZnNY?=
 =?utf-8?B?OHZMUy9rcnY2dGtMQ2poT2VhUDhheE5HanJwMEJ3Qzlaa0xYODBPNXpRcktW?=
 =?utf-8?Q?ljxfwQbK581ZEQGu8MCmlsqK0cQaVIeonqmG7C6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWNuUnF4WEh6c0VTZ0RXUEQwcU9qczYzb0RjbGNlQnQxQnRoZk5DQXpFbTBN?=
 =?utf-8?B?QmtFajdyckMzOFFQTzBZd1RuWXpnVnpBT2JDdHVvd1l0YVhTaGlNU1ZCUHN3?=
 =?utf-8?B?aFExWjh6c2k3VTlHM05jYU5oVFFUMHRkcWI4dGk2RE1OU3czNGVBdStLeHdS?=
 =?utf-8?B?UzQ1L1g0alRlVmlhVzlFU3oyYWhsaEJzclJ2TGlJTUt0dDAwc1hTQUNrZlZw?=
 =?utf-8?B?RDZCS0ZvODNmK1dIZFpHam41bm0wSXpCYklDN0tMMGRQTmh0UXg1ZXErTXJ1?=
 =?utf-8?B?bnFEM2R0ellqVlRaNVA2MXQ2U3hjUmNJUnBSZ0x4VWpNUWhyUC9VQ05rNXVz?=
 =?utf-8?B?dnk3K0NaemV3eTZaWkdGZ1hRWnE5dFpuTzhpZ0xFVnBMNDhtT1haVC9Xckkv?=
 =?utf-8?B?R1h1Q2RLcWVkOFp1OUV0VFRGY3EyVjlyU1lKV1Q1d3BEQ3Y5MUthU2Q5UTFi?=
 =?utf-8?B?OHRRam82amxScFk4WUJKaE9qbXA5ODUvMlIyQURLc2pCZW53U3JmNFIydy9P?=
 =?utf-8?B?MHdSTEwvcXovN1lpZ3VENCtxSmpRMEo0OU1pdDJSdnAwQjFlOUNwODN1WHd0?=
 =?utf-8?B?VjgvOSs5Nk1oODJqZDdpLzZPdk5zc01RUVV2YUtLdDc2R3JnQytmV3Rsa0pF?=
 =?utf-8?B?b3FmQlhxa21xNWxYRk0vOE5oMVU5TUxvRWtWRXpNT0Q1R0NTcDluS2JZNjZo?=
 =?utf-8?B?Zm5IbEY1bG5IWm9tVG53eE05SS9Ddm12aE1LRDRET201aFFaTXcvWEpSaHVy?=
 =?utf-8?B?ajVQMnVyOGNlS2lQRnZYdC94WlEyNWgreGdFb2IxUmhaeFJVSWtaTng3b2No?=
 =?utf-8?B?OFgza0hkMFN3bm55bzJ6YXRXeXhqUVNWYTdJWkhqendpZ3hSbThpT3I0S3Mv?=
 =?utf-8?B?K2N6SG5LSjREU2dCTGRHbDdXamlLZGlvMTRraWJteWVtVHAzYWZTYjc1S0tv?=
 =?utf-8?B?L3doT2N6cWlLV1hvdXRrNTJTVmJHVmpwZVRJbXFNNWc5T1paWXRjeHFuSHYy?=
 =?utf-8?B?OXFhL3oxMUFqbTVJZE11NHJDclBsL3paL2k5V0pUZ1lwRnNZTEVjdVc5Skhi?=
 =?utf-8?B?ZjgwN3NMMEt3eHFXRFRPdkNFZ0pGbFJRaVpYT3JWRllHamxJei9Vakw3L2VJ?=
 =?utf-8?B?ckwrOS9CYnYwZ2cza0xOd0ZESWN4S1I2eXRxRFc0blNTM0RoR2x3aWtuc1Y5?=
 =?utf-8?B?cHZ0alJhRzJ4V25tR2svOUNQWm0yMjFHT2kzYzUvcXJxUEtlcHp1ZjBGckJ6?=
 =?utf-8?B?U0JwN3R6K1dhOHhGZmhsYlJwN3I4bWhWVTYyYXE1ZjkzdGZ2Mmx6WjViWFFS?=
 =?utf-8?B?WkIxYW1HaUJ2SGZoRFZKK2RQNzJCa1ZEeHdKZkVZWmx1SU41R1J1Y3JVQ1NI?=
 =?utf-8?B?TDFqaFByZXN0bnlrYWx1ckpDZ01XZE1QV0tjbjMydGhZOHpBdWJUSVc3RTgx?=
 =?utf-8?B?OUM2SGlHRUF1UkRrbzFiYXdHa3cyMThwdjE2SGdWN3ZSbCtqdndITVBuSmNH?=
 =?utf-8?B?czJjMEdoSjNuTk9GSG5mU2NvWWpvblZSRFlzZVpjY1Q1RXJwVEdLYWpVK2Zi?=
 =?utf-8?B?bnYyMEx6SFd1MkdNempHaVB4Z1pHTkhWSTllUFlpdHRQU3VnWVQvaExRRUd1?=
 =?utf-8?B?WEdMV1hmSEVaZlZLZi80Vjc1S25FUmNkbnc1cVlmSS80empzS08wanJnRzl0?=
 =?utf-8?B?OHFhRDczVEswaG02NkE5ZEVKSmM3NUkwM1M4ZEQ4YjFNVjluOTZ5TXB0elZX?=
 =?utf-8?B?Ukd6YlFZVzVtbGMxbHQ0WWN6c1R0djkwRWtVaXJ6ZndDZXRWR1J4WlVjSVVM?=
 =?utf-8?B?Vis0ZVNpUVdQNlppS1Bka1RpbnFkUlJyMWhzNVJhWlcyS0JJeG5CZDNZZ0E1?=
 =?utf-8?B?Snd3S2szYWRoSGFLK3dVMElhUkFQa3J6SEh5WjN1VFBtOWdLVjl2Sll3MDgv?=
 =?utf-8?B?R2Z0ODd5a3Z0MGY2eTc0VEJLWlVrbFpwTkIyWFU5S0pBeXB0K2ZmSjg2OUZ5?=
 =?utf-8?B?d2ZaTlZzVVNPN0o3eU95UnNDN0tqeUV1dGhRSjhrVHExNnVaS0crN0I4Nnhk?=
 =?utf-8?B?R3BodzlIYnVFY0lCdDcyellNRnpPSTJPVDN3Z0lGaDhoMEZraG9wUHJ0WE1k?=
 =?utf-8?B?cTBsSXR0VWtxMDlWaTZKQjNTVWxIV0piaFdkNjkvY1R2a3pqdXV6U1psM05W?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4471b0e9-252d-47fa-a594-08dc8c130b00
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 01:40:59.8001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAvDUBuAyjKLAfju8hJLF0zulku3AH5mbygSOfWm8UJ86i4VMCVDr7yaLIoA9aiGRazzH3jvBsOzzPpMkcizjusPUePArbdjzprynaCYYJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6885
X-OriginatorOrg: intel.com

Hi Babu,

On 5/24/24 5:23 AM, Babu Moger wrote:
> The ABMC feature provides an option to the user to assign a hardware
> counter to an RMID and monitor the bandwidth as long as it is assigned.
> ABMC mode is enabled by default when supported. System can be one mode
> at a time (Legacy monitor mode or ABMC mode).
> 
> Provide an interface to display the monitor mode on the system.
>      $cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>      [abmc]
>      legacy

Output is different from cover letter and what this patch implements.

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v4: Fixed the checks for legacy and abmc mode. Default it ABMC.
> 
> v3: New patch to display ABMC capability.
> ---
>   Documentation/arch/x86/resctrl.rst     | 10 ++++++++++
>   arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
>   3 files changed, 34 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 7ab8172ef208..ab3cde61a124 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -261,6 +261,16 @@ with the following files:
>   	Available when ABMC feature is supported. The number of ABMC counters
>   	available for configuration.
>   
> +"mbm_assign":

This name is not ideal but I am having trouble finding a better one ... I have
seen you use "monitor mode" a couple of times (even in shortlog), so maybe that
could be the start of a more generic name? "mbm_mode"?

> +	Available when ABMC feature is supported. Reports the list of assignable

Why not always make this file available? At least it will display that
legacy mode is supported and it gives user space an always present file to query to
determine support.

> +	monitoring features supported. The enclosed brackets indicate which
> +	feature is enabled.
> +	::
> +
> +	  cat /sys/fs/resctrl/info/L3_MON/mbm_assign
> +	  [abmc]
> +	  mbm_legacy
> +
>   "max_threshold_occupancy":
>   		Read/write file provides the largest value (in
>   		bytes) at which a previously used LLC_occupancy
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index e75a6146068b..b1d002e5e93d 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1071,6 +1071,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>   
>   		if (rdt_cpu_has(X86_FEATURE_ABMC)) {
>   			r->abmc_capable = true;
> +			resctrl_file_fflags_init("mbm_assign", RFTYPE_MON_INFO);
>   			/*
>   			 * Query CPUID_Fn80000020_EBX_x05 for number of
>   			 * ABMC counters
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 9148d1234ede..3071bbb7a15e 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -856,6 +856,23 @@ static int rdtgroup_num_cntrs_show(struct kernfs_open_file *of,
>   	return 0;
>   }
>   
> +static int rdtgroup_mbm_assign_show(struct kernfs_open_file *of,
> +				    struct seq_file *s, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);

Please use arch helper to just get abmc state instead of fs code
digging into arch structures.

> +
> +	if (hw_res->abmc_enabled) {
> +		seq_puts(s, "[abmc]\n");
> +		seq_puts(s, "mbm_legacy\n");
> +	} else {
> +		seq_puts(s, "abmc\n");
> +		seq_puts(s, "[mbm_legacy]\n");
> +	}
> +
> +	return 0;
> +}
> +
>   #ifdef CONFIG_PROC_CPU_RESCTRL
>   
>   /*
> @@ -1913,6 +1930,12 @@ static struct rftype res_common_files[] = {
>   		.seq_show	= mbm_local_bytes_config_show,
>   		.write		= mbm_local_bytes_config_write,
>   	},
> +	{
> +		.name		= "mbm_assign",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_mbm_assign_show,
> +	},
>   	{
>   		.name		= "cpus",
>   		.mode		= 0644,

Reinette

