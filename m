Return-Path: <linux-kernel+bounces-328870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E774978A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C176B2816A1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D1C148855;
	Fri, 13 Sep 2024 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADhYcxpo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB6A42042;
	Fri, 13 Sep 2024 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726260363; cv=fail; b=dFE933i+Pfm88OBppY+JqO6LJdNICwrmpItggvPS1JCZvjno1A0/A/lV6vqpr5ELZMsEc0u6SeE5vhuIKWpulIuNRBju8FH0Ber6DD9XKPLP+WvnruTMyJfQXgx3PTFydrZmVZKu9Mg9qdgeXmtXJzWdHrQM01/knIsPAD35L4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726260363; c=relaxed/simple;
	bh=ERymliSLD+uWTd+a4ixibeun4YW99AznSrNesgIBS+g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CikGmw73UNAUwo9oanxzGgHqT6Murp/1nP4zVjQZhZprI2Ik0hrHZ1zsARp6CC+RMc7QcRZvsyVhKeyddyJiyaF8d1MBfHvHaHLx+WR4cv1YKxJU3eMjuzPr/GMegjN0TlTMdc/mYC3hhDSEdf0LIO2U4gYGzEoMoZDbcH8jYLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ADhYcxpo; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726260362; x=1757796362;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ERymliSLD+uWTd+a4ixibeun4YW99AznSrNesgIBS+g=;
  b=ADhYcxpoBYcYlzUKVXeguVbqHMUv5Ij+N2EWRgte5yJJWNQLvIN8prJq
   F0prE5KEtEy8k5InC8B3qpIWpYgP+GGUtLP40hbcPksQm/63mdTKqebUj
   Wj2gCDeMiU4y11pyJl0xkmoWycWH9laMNBTBoWnjOQcBNe2YdUtNs5BkK
   aQeRQDeEZvl7AHQE8kRbQ0UYvGnRdcGMKN1FYH4UwPw1Gi0ehf0mfXnR7
   7/wTRvU6S2+fheK5MEc2xI2Vt2ptlrmqSYwrRNRpqk7uiQ+uceMEKAnoT
   DxLFpbTzjfsB84V4DRoz+yco9B12ExVNmE6t9d8g2iNmeJMDx1w0CKIud
   Q==;
X-CSE-ConnectionGUID: /Ld9Mw12Rsy91EHpEbu50A==
X-CSE-MsgGUID: sZeo4/DITLKnjWqhJ6lzUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25001939"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="25001939"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 13:46:01 -0700
X-CSE-ConnectionGUID: Ky3xZDmYR7a35gk7s/uGqw==
X-CSE-MsgGUID: bX0kgAWYTIGYKZ3eE6gCKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="91462971"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 13:46:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 13:46:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 13:46:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 13:46:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2cslrwtkjWznPKfhGhlkNCJg3jziHLGZZFRLvHp3qv5KeD68MT3wFkyoKMhVuOsg2FR44pupuUtOv5d4vlpcgih+kHZfYz0BNNeK3NFtEoJnfXsZwnR274hL7oXp8P7ssgLsOz3YAYGpRw8gBIVybmr+2rSYruPRYbTMBXUsdkSTnkvu2CWwLYO/kbVc26WGM4v+HoUyrdPdoRil5hiW3JHByD8r9Ev+b9FXmyVfeKp5gauuDAZ9PReeGcpT0AOPVLBVG+fAeMqsjPL+34jJrD9ZWEZ7xS8CVcDK4Ia2ubJz21iK1EbWUnzQ1JVx50d5Kl5aKljhn/qI8eq5I8MTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERymliSLD+uWTd+a4ixibeun4YW99AznSrNesgIBS+g=;
 b=oyMi3KMatLdxtk2JLCPZbCetESKCRXPsS94G2DbP+1AAoonN6A1kC9e01Rss3JSfe8YWBE0hlGd6dXWKQg1wIkDSeKTHH24bovY9Cj/e2AMtzC/NfJfAgnx5zsC5swzX9CuIGNB1fACJfsedOyhbbvSycqbpNT9jGWkBKSo/SidEncVc7LaPbIga1X9qOfCpS9grrSfKvZ46JCFq+mlE/8GyP+i0fgmRS6hTRMiUNz3vFk+r4fbqbF/J0H9nC/qUlN5iL+5nhE5tvuh/ZJ/842UVdAT2Kp0YVmdWxhKbV5UqtUMgjt6ULoLwu08+Mw90ryb9Ct7Lhu3oK2W3l8lX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7293.namprd11.prod.outlook.com (2603:10b6:208:42a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 20:45:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7939.022; Fri, 13 Sep 2024
 20:45:57 +0000
Message-ID: <254da029-81b2-4745-bc78-5aefeb33adb0@intel.com>
Date: Fri, 13 Sep 2024 13:45:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] x86/resctrl: Introduce sdciae_capable in rdt_resource
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <fenghua.yu@intel.com>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<thuth@redhat.com>, <xiongwei.song@windriver.com>, <ardb@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <peterz@infradead.org>,
	<kan.liang@linux.intel.com>, <pbonzini@redhat.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <alexandre.chartre@oracle.com>, <perry.yuan@amd.com>,
	<tan.shaopeng@fujitsu.com>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<eranian@google.com>
References: <cover.1723824984.git.babu.moger@amd.com>
 <cf9e47bbd66dbbdb76f0124620fad2f1b06e977e.1723824984.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <cf9e47bbd66dbbdb76f0124620fad2f1b06e977e.1723824984.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0318.namprd03.prod.outlook.com
 (2603:10b6:303:dd::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: cd319ba6-557e-4a37-11b2-08dcd43511bb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2l5QU56c1oydGdUUDZzRGFQMkgxUjRtMlFSR0pqVlUvNFBMK01YUktyMkJQ?=
 =?utf-8?B?T05nUU5sdjVFcUJGNkIzYjhRbUFIMEx1enRxYzkyOWlHVmNIQUdXYVVWbnBv?=
 =?utf-8?B?OFZTM0hFd3l0aFpLTlJvN2ptNWh4V0VMWUJPRUVZQkN2MU9tVG5CdjlNb2to?=
 =?utf-8?B?ZXNVMklobERpbVg3Zm45UEFvaUZQR3VpM3cxWitaWXVlekFSNFByS2JYMmFI?=
 =?utf-8?B?NmtOK1pOSXU4MEFYeW9OV0dWZ2NaNGdCVmpSN3BaQ2JoSndzb3k3Zkw5WVFx?=
 =?utf-8?B?ck84ZTNTMDZDZWFOQU95VHBPVGpIbVhYZEZDeml4VHA1TEJURmovR3M1NU5z?=
 =?utf-8?B?NkRwdmxCdFg2a3hhOGFRRDVGcnl1bWI5RTFYRnRBQXdLaG0zbXh5dXZrdDRx?=
 =?utf-8?B?c1BTN3hmUUEvM2thMTVpRFUwdnQ2em9ZN2NDd2puWXRseUVhb09FcHEwYldw?=
 =?utf-8?B?bDV6ZkFST0RudlJ3Y1lTR05kTVhaUWw1OTRFdXlscjVNTkhhdmN6Q3BoQjhm?=
 =?utf-8?B?cFdIUm5BQm9HKzQySWtGUGRxMEQ5d1RTb01xTHJwZVRhNGk1U3ZtMWRlS1ZM?=
 =?utf-8?B?VFdLTmNRKzNWZDc4bUMycjhaTFAzMENFcFhyT1BTM3piY0pXcXE5bXgyR3JP?=
 =?utf-8?B?R2dhQk01SktaajRqOFdjTTJMMnhla3o5Ty9DcVU3RVUwaHY5d1pvQTBuOTVu?=
 =?utf-8?B?ZkU5TXpvOVh4dmpqU2lBMEYxRkhIMDBJTTZMSU00RldGN1pGQ0tWRUphU2N3?=
 =?utf-8?B?RVBxTVBIaG1nQjhJZGdpTlFrVHFpbElJQ3hvZ3RGbXFFVjQram1KVGhOdDhI?=
 =?utf-8?B?MnJmWFFiUUxhODNHQ0xQTE9Sb3lheXJwTlI2TG83aTVIcCtHU0lDOVNvSXlq?=
 =?utf-8?B?Q21lODFvSDFKcCtjWE9yNm5OUy9UNmVoQ3Q3VGF0aEE5ZWlrenAwcVNkSVNr?=
 =?utf-8?B?YW4ycW1mTjRqZGg1VzN0djVOdFRkaEVDbGJCeTdHY1phQ240VDJiMGw1Sklw?=
 =?utf-8?B?SHBVZjVFWlJjbUZha0lOamRHbFFxSkFtMlVnVXpKNnd0TXBPdGtJcEZHQTFq?=
 =?utf-8?B?UzdLMXgrMXViTTB6czJRbUFnZVJ2THZiWWdGRm9qcmFjVFBSZlh0dVJ5b3VQ?=
 =?utf-8?B?YzQ5RDl0UnQ3NkFRSFMxQVgyUUdVcFdCeVROUy9mUUdNbnF0QlFIVkhyZVVo?=
 =?utf-8?B?cm5aSTBqeEZnZGd2UGhOYnJkelRnK1BBMnpYd1N0ZXZKZisvU3lIL0gvbkJM?=
 =?utf-8?B?NGdNUFMwMnZIWkZYelNQTWZiMUwxUDNCYnBmQkIxb1BqSTJPN2VjbmxsdG9h?=
 =?utf-8?B?bTl0ZExCTzVSUDFDcDV3Y01BZVd0VFphWEhneVRQTTNjdjRXYjZUNFZYUElW?=
 =?utf-8?B?MzlYT1FsM3BsemZ2R1RnYlF1eTJWVmluUElZZ00ranRNekppNHdKcWVlL1VO?=
 =?utf-8?B?a3NlY0IzdDJ3WHhuWUZNbjBibmFZZ0p3TUpvakRta3ZER3ptOC9HS3JvRDI4?=
 =?utf-8?B?Z2JLeDJTTEZTTWRIMGg0SlpoOUIyUzB0eWV6RXI4dUtjZ1ovUmFZRXdadmFL?=
 =?utf-8?B?bDZYVzFtcmpHckFST1pkOHFUSzlXTVNnb0k1N3l0M05GbWtvMlB2SFFhSS8r?=
 =?utf-8?B?OXk0NXVQQnIwU05sRXR2MmQyUFZOMTVPakpLbjdGaDMrQ2JadEZzWU95YnNP?=
 =?utf-8?B?SFRMdzhyT1FCVlVYWmt5VytRYkQ2c2VrVnErcVhENGp1OVhEWFdocUlBanFG?=
 =?utf-8?B?YWhvQjdOaUhvTVpxY2x6QkFlMUVkc1d0dWFiVUpEbWI5Uk56ZG9DaFg0cUdT?=
 =?utf-8?B?MFBsWmVuQ1hKZC9XU1dxZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUQzSkdzT3BhYjhGajV0YW0zUXlqNkszWjVndDFlMFFuaUU3R2tVckpaMmxh?=
 =?utf-8?B?TG5VRG5CQXA5Qk5naU8zTWNiWTArRnpWaEtFR1kzbkIzaHgxWDYwM0V3YVZR?=
 =?utf-8?B?UitQUFhIL1AzUW1SR09aT0djdGpZNXF4elk1R0YyK2x0SDdTb20yeS85YXlY?=
 =?utf-8?B?dkZsd1ZHMlBzUTI2YUJuWVFOT3dlQmFaSHcwV3N6cUtxTTJ4bWFYNi9FWlAz?=
 =?utf-8?B?em0xWmNKNjhnUHEwWHNKR0lFN0cwdmk4NExWME5zOGk1ek5yRWM1YnIzTmJI?=
 =?utf-8?B?OXdOWmxkNDl1LzEwS0ZSaXRDMGJsaWx2eXd2Q0IraTFKdEhmVUxlV1lndVI1?=
 =?utf-8?B?R0RDMk9vZXNMSnpmelBYT2ZPTWRyWVRRMkpTOTNuc2o0cEhkRWgySGtleHBR?=
 =?utf-8?B?eUtTa0h3bGxYU3RzVkpDdk1iSFpNaGwxN2xyODRoMEU2OTJpS3R1dm9NQmJS?=
 =?utf-8?B?Zk84MjhLQXlQcFBtaklFamZ0WWM1SzVCZ2tLa0lXcFFaeWUxS2ExcnhXU3ZL?=
 =?utf-8?B?VE9zRGFYTnprR2NqTHhqK0N6TUxDeWllK0J2SWtsTWNuYXdTdnd3cnJoaEx4?=
 =?utf-8?B?YVdCME01c2xNYy93c3BMNitiSFczYTlKSHpLZnN6V3lJNFZBaDFkT2N2VVhQ?=
 =?utf-8?B?SE1FRHBWZXcvVzI0akhwTGs4SXc3cU5CY1Q2MFV3cktBZHJmdjhmenpoWlpw?=
 =?utf-8?B?U25xRGVRSkhqWnRVd3JMbThzRmJLMHlrc0dyaVdRTDM4eW01L05xTVVOWWNS?=
 =?utf-8?B?Q2krdXkySzVodDdiOTBXOGVQOTNUWGRDcllMV2lSYm9ibE9jc2QrODFhZWtw?=
 =?utf-8?B?bTI1czVjLzNhOTNkWnQwcDV6anpBTEZoS2JEeFZqSkMwNTJCQUdvTHQ3eU5n?=
 =?utf-8?B?MnFaMFdMY3pNbDhmOEtDNnpJQWtUMUlNb3JLcVpKZVhxNlN2dXFHV2RCdGlE?=
 =?utf-8?B?dTNOQ01oeU1HSjBFODJtNHNHdmlXaUZTb0UvVnlRazhXNkZvbXVuMm4rWjZy?=
 =?utf-8?B?NTFyZXowY3NoelJGd0loeHJXYlV4UHhtWGwxL3Q5VEpOWnZkUWNVWmh6cm1T?=
 =?utf-8?B?YU95YVJFUHppdmh4UEk2SXBqdVJhMWVZTkFseTJaaE9La3lySVk5bTc1YVE4?=
 =?utf-8?B?a1VBdWhISTBFOG9XbmtMZWJuNVRKVk9YaDlNN2NTcCtrT0dHeG1tK29uQUpC?=
 =?utf-8?B?bEhsWXNrM0Mzc1ROWHY0RGcwZ3l2MUZWbWdPNTg5MmUyY09oN20zMWdZaHFm?=
 =?utf-8?B?R216NzEvMjd0ejBGcnA3alhMOTZrOGpvZkhpK0JGWi9OV0lXY3hXbE11QXp3?=
 =?utf-8?B?eElweXJmVy84KzRLTmdJMVpldDBjTE9WNmREVkVjSlVLVnpKV0V4WjJYNytv?=
 =?utf-8?B?bEYzZzVlM0JGNjFuZCtJcmhxdnI4NWJnWXRYQ3FZRUJ1OWwrdEZ2SjkyS0xR?=
 =?utf-8?B?M1BvVEVORXdKdTR4NFZDakxLckR1bUgxTVpsZ2M4eldpTHRQRitmZ2xnS3Nw?=
 =?utf-8?B?dUVnUEVwVC9PUG5QdXA1dWtYTGk0YUhwMktIcFFoUEFGK0x4YzFpVlUzb3R2?=
 =?utf-8?B?YWpFSURrTGRWU252bWNOVnhzZjRsZzN6aVVxT3lBaDU5a0wyVFJvNGR5VmJm?=
 =?utf-8?B?RnZwb1RqK2NQZlBrak9jN0ptUXFtVXNuZGlYTXRYM1QzKzkzcUovOXJtUzFr?=
 =?utf-8?B?c2VTUEVmb1VqSTlYcC9BalBzQ0pRd3loYnJPTVpSaTQrVWxmeXE0bENxZWtZ?=
 =?utf-8?B?RnFlMXFTYUUrSXhlSWhqaU9JY01vNmMvVFVINjNhNW93czFWOEFnUGpnNmdr?=
 =?utf-8?B?K1VRN0Z2cExMYjRYd1N3QzlwMXJXYkdvTURMQXJibVViaDFUR3d0MXM4U1Zy?=
 =?utf-8?B?elFlbzlCVGp5WldXVytzVFduRkFXM211NFNLbWgvWkExTEEyOEQydmVGOFlr?=
 =?utf-8?B?OURpaHdzTU9GcDFmbGdRUFVkK2NoNmVmRktmT1dEanM2WWxYd3EveHhwcE56?=
 =?utf-8?B?eWxEcC9VWmQ4TmZKdXppWmJqdlhtWTYwczVGOWJteWtwSGdKRWpVL09xNHAr?=
 =?utf-8?B?ZjMrc0k4aTlDck1weUFuZkhVOWttbUxyNzlnZldUcVppOEJtZHNBOStENjZG?=
 =?utf-8?B?QnNtR0ZmT1dyZkNZanFlVTFaL0x4SGJRL2NNRTRLWUdnN095YlREY25rVFhl?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd319ba6-557e-4a37-11b2-08dcd43511bb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 20:45:57.7749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kXbvt6iJsPmHsqRnf5OzmAtQ9643iXDFxFfw8zuqRT1GDmturoMr9j6QIqn2F/d+4PgUMHEhYmfTRjg8JYcx71SmyuiO4IQ0rBQGLkznH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7293
X-OriginatorOrg: intel.com

Hi Babu,

On 8/16/24 9:16 AM, Babu Moger wrote:
> Detect SDCIAE`(L3 Smart Data Cache Injection Allocation Enforcement)

(stray ` char)

> feature and initialize sdciae_capable.

(This is a repeat of the discussion we had surrounding the ABMC feature.)

By adding "sdciae_capable" to struct rdt_resource the "sdciae" feature
becomes a resctrl fs feature. Any other architecture that has a "similar
but perhaps not identical feature to AMD's SDCIAE" will be forced to also
call it "sdciae" ... sdciae seems like a marketing name to me and resctrl
needs something generic that could later be built on (if needed) by other
architectures.

Reinette

