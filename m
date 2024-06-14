Return-Path: <linux-kernel+bounces-214160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC0F90805A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869671F227E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241B619D894;
	Fri, 14 Jun 2024 00:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFQChuSQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34DE801;
	Fri, 14 Jun 2024 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718326627; cv=fail; b=qa9qgkegjt33l/L5j84b8scB9g3zlWcofZNgCchW6Z1uDZdhh+MhTpWSdQiLqA6QcqUb6EhGD+Nz+TAXFqJ9SMJUNnhzlrJhAEtc8bwUepRQXOssU3RhurYfpFlV+PgI0NHIWcikIwQLOhDlsDpMYzbggJBaSAJZeuK8xXh62FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718326627; c=relaxed/simple;
	bh=FQDMEUFEtLSsLGlQXaKYIRO7PxGG8Kl3gxC7WsKB1Fo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qHzfqNe1TIEWwJWUDpaNzJou/94VwsUiHPXsAJsB73nvbNr/o2WGKbHYng4F9okE7dYzWth9yxRpll1HkWifjWeXRza9sVrmkaE7zEz8UyQnMVHPEuTaI23dTv09fGoMIBOSuQ661P7Hfajz/K7zyL1GlSTs0D8vLMxTH/N/HvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFQChuSQ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718326625; x=1749862625;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FQDMEUFEtLSsLGlQXaKYIRO7PxGG8Kl3gxC7WsKB1Fo=;
  b=VFQChuSQGOJJDduyjtN8jxDG5y/Egp6CTskQDf4U0DZySO7H8ZFAkKLx
   yaqUeNzJ/L8V0wk1yC6nDkzTCoWNMiRyN/G/mQeaznByU5EFAAHMCDXgf
   ai9ndC/GfxM7c4dfk3rFLqfWAfLU4mxeHRSGje2lire4t7A+FVaexgbLd
   ORx3zoJZV48o3X260/t2ftTZVdapSQziZJfqZivYwLhM6Pth4cTpW5Wq1
   WUDkrCO5q7bGhJ7+0WXJjzV5Y5jxqbrc3T4xDesPIOpiPQGxj6N8bBEYj
   D8KGOGqNa14DUVVSbcKKYJpl0kyzKyH6MuzSwTRL4WsI5wadQmp0m4R2P
   A==;
X-CSE-ConnectionGUID: NE/pbwv5R9SNaWDFPMZ7Pg==
X-CSE-MsgGUID: x71M5gszQu2fFzrqpfxMeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="37717476"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="37717476"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 17:57:04 -0700
X-CSE-ConnectionGUID: SIUgM0VVQfm5zid8Q+yDbw==
X-CSE-MsgGUID: VSZ0k5N7SQmomIOmB6SG8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40191618"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 17:57:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 17:57:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 17:57:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 17:57:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 17:57:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcRYyf7URC3hTT7Z9Su5+wJNoofG3uyRFExl/0Ytee1ohKvsBMtrxsrIEwq9n0Cfr+RhThyro85x5EZp+iG6zhwtZ1d491mNh/cwTIZEAf4s8LvmiWjHqURiY+IoShV9hRBlHfdfuDx0NRiolaUJjdH1u/D/AeL7kv+qU9xOOUiDD0YeEnD7frKEcemR+WwOWsY9okYFU9DP8ikyhFnfWSEqllfG2Zel/VbDqC9anRI2fTgteBiV324P4eIUGqjphgb/mW1IhbMoWFMVdk4ycaLdAGr77p3nWlix0ZrK2T9RnLDurpmCz5kRhDdaSjsLA+bP/ADTReeqjpaPDkqBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkYxDdlPnroxL9q9N24KyEHREFs7zpVgQVyjgbdcx3U=;
 b=Aizr9N3l+ridLOLyLRcxrZuh1MBq8XIYmSqXiebahnmnIX4XJZhXWZp285mAEZxlkBujGuphV+J8SWmhfWdr2Z/1Ha4hI2T8Z/98nUDuxx59ZxmZc8LRRexpsyWzfW049w5m4pYvb3dJmcWoGtKls01ODMsdaNo/RBfrKcgp5Is4mdZXHNZcFLngWflTMTnlnLiNla6mZLPdTS6nIqskQmOJqwfgLrsHhT6Lbb+qeEoiJ7fknYQdwqx83fyaCNDBlmRR4IWacByp4JFbDSr683hi4IkkjNJUQAodGAqQ2l9akyxb9pyRoj946H2zEJlGzPxbyEplyu0TJOqjeSR5iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6861.namprd11.prod.outlook.com (2603:10b6:303:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 14 Jun
 2024 00:56:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 00:56:53 +0000
Message-ID: <da81b315-a97f-4b43-84a2-5bb347bfafe0@intel.com>
Date: Thu, 13 Jun 2024 17:56:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/19] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
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
 <0a73504f355a8b0b0b3d32f6c0e0b8909c552340.1716552602.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <0a73504f355a8b0b0b3d32f6c0e0b8909c552340.1716552602.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0034.namprd16.prod.outlook.com (2603:10b6:907::47)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b7ff26-60fa-4be3-2310-08dc8c0ce16a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXQ3VDYvYnpnTVFhOXk4RHEwNERsV0dxUlBtQ00wZXNNcjlGU1creWhiMkZF?=
 =?utf-8?B?ZGFLSXM2UVVDYlFKU3hHT0tRSC9xa0xucjk2TnVmTldqVFBxUzJUeVBzbE1Q?=
 =?utf-8?B?OFNWaTZkK0VSdER4eXZ2TWw3cEhUbDNxa2RyZFRxQVlpY3pOVjB3RU8xRTd2?=
 =?utf-8?B?SmdyTHlUaWg1YmdLMFNKTUM1T0VpMmN3aHN5SitMa0tpb2s5VU1SbWFtZ0o5?=
 =?utf-8?B?WDc2Y1ROQWNCMXhUN2pyVk52dlJ4aDZ1VkJmV3F0dFNyQXExWk1abWpESzZ3?=
 =?utf-8?B?VDNhVVFzRUZOWGNRd0tINnpwRHJRaTFnbk1JMlJzTEgxNU94RkN5VytSMEZ2?=
 =?utf-8?B?YXVSbmZpYUcwM2p3dEg4VnNOTSs0UXdaT2dwK0Q1c0xGR1pLMlZoR3FXZWhv?=
 =?utf-8?B?SnliK3hnNkV1bzdsVVJpNndNRnZmL1dVeXhPOU01OWVsT1owWmxObXkxclEy?=
 =?utf-8?B?WUdKTUh6WW9yUmxzT1FWZmlQQUtpYk5CT1BzU0hGcGpiVFhnTnc5TjhFaDk0?=
 =?utf-8?B?U1lWazJCMDJWZnVkaDBCNitGU3hmc3A1VWlwOWpmNUJYNXdSUlF6THpudjYx?=
 =?utf-8?B?VU1OdVZvNER1aHplWWpXVW80RmhRQXhWTGlVL1JJaWg4dWFvYk84dHVPQzNR?=
 =?utf-8?B?YmRJMjB1VExNb3c2YmwwZXFzVmJMN0t5SHBzcVFUWDY4eWZBNlNkTjlZTnJo?=
 =?utf-8?B?RFVFM25pdWN2V1Z2TmZ1cThCb1dNMERBQ3hDeWtGTXB4enhBWjVJNmdNZmg4?=
 =?utf-8?B?eVh2RlAyUTR2eG9WQW5CdXdpeS9Za0tULzl4R2ltNllGZlV3K0tYZ3ZDcTBv?=
 =?utf-8?B?MXROd04wSGtxQW5JY1d3WEJ6d1B6QWZWS055Sk9QMWd1OEx4aXRaTWgzdXFr?=
 =?utf-8?B?bmRFSHpzazNLa2xjUmFmZ0dET1AvelplTUVWVHhUa1JhL1J4ZlkwSWwvTFp6?=
 =?utf-8?B?V09iVk1TK04xeFZGSTc5bEhZN1pFZVlrNGp4S3RyK0pvMVJqTnJRcEJSQzB6?=
 =?utf-8?B?KzZ3bis1U1FzK21pZEk0cUQxNWs1ZWprakVmTFJvS0YrMmlrRGpmbGxLcHN3?=
 =?utf-8?B?NFFLcTdFRVlkcmtjdnBDTTlKa1BscmZGTmp3Y051Z1JYRE5Ba2JjTXFVSDdu?=
 =?utf-8?B?bUpjOGxUWHNKYlJaUkxKOFpzYW1IaytwWjd6MDZ3aDZXNWgxeXlMSDdJQ0RP?=
 =?utf-8?B?MHZ2YkJwck1YNHhGaEwzZlRZQVpuVk9wOWFOOG1lTE5HZ3o0cDErSzNlNUQ5?=
 =?utf-8?B?QUdhWUJGTFBsU2N6NTVzUWhMY2pwZXhqa204aFI4NTVwaDFIa0pQTmZnUnRD?=
 =?utf-8?B?UHpBOElRV1g0Uld4cHZnTlpPaUxYRzV1SktPams4ZzBDelBJMnJBT2FjdE9n?=
 =?utf-8?B?Q1pjVUppeExwSzRLK1ZqZ1owSS9RMkZzSUtkU01iNFV3YUlCK1JlZFJOd1Zi?=
 =?utf-8?B?S0xIcGpOYzg5bXBxcGxlaHRsUStKZ2pnV2U4MEZsM3BjNnc0NXdNWDF3cVEv?=
 =?utf-8?B?Zk1wM2JJOWNVVU52ZVJNdzZYZE56c2kxSnNXVldLWU1qN2F5WkNqUktVenQ3?=
 =?utf-8?B?RHBoYlUxSmQ2dnl4UzVES3hqK0ZEazcralZEZzI5ZTdXcGs0ZzJIMnNONHNW?=
 =?utf-8?B?b3pTdXdua3FjdEI4QXpBcENVNHUwLzk1dnYySHp0RkRZTzBpVDNycjBSZ0sy?=
 =?utf-8?Q?1RsDku3XL6xakMFI/lez?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXNCam1oem9YOGc2bGFpYlgwOHQ2TkxXbkFFRlRwWmVNQlZiSy9kRDlBcFN1?=
 =?utf-8?B?ZFdTRGl5T2pMWENZMVFPWjRFVmo4TlJSVHovU0Vya0M3ekRoQ28zNVhjTGVH?=
 =?utf-8?B?TFlKMk1vZzcwWk9zSEdJQWduN05oQWpmYmpPcHUwK0JFdytHUkc0c2pEM3l6?=
 =?utf-8?B?dnJXSkZyRFd3NW5LT01LRExaR3o2ZVJnVEg2a0E3V29hd1J5WmwrQURYQWpl?=
 =?utf-8?B?ODFvcjd6alI3TkpVSmFCNndJbEk0WVN4cWNzRERxV2RSVEUxS0Z3aENmbkUv?=
 =?utf-8?B?L2t4MXEwNERnYURTZE5TbUtMcVhmSVdJTEJObmMwaDJESUdwUVErV2tQOFFw?=
 =?utf-8?B?ZVRreTRmUjlGVzdKcTR2OTVXdXFaSFBxWVdXL3VkcjVCd29nZWZleDMwVURF?=
 =?utf-8?B?V091aGZ4VU44Ri9wVVBBUFN6SnhBbFhvNVltYnBxK3g0NlNXMHFJMlNpRDV4?=
 =?utf-8?B?Ti9jZDJmenJNNEdjV3BCWnVhaW9tbGhiY2ZpNEVSZUk5U0xiL21xYnlTQ0J6?=
 =?utf-8?B?TFhRL2xxRm5IU21kM0ErVHhrcDN1clY2aHU1cTZlN2h0NHNHeE9sNExhbkVx?=
 =?utf-8?B?TEQvWTdraHRSZ25xd3VSeVdFeTFrU0VMcUM3RDJuT1VJNnp6b201R0ZBdlZw?=
 =?utf-8?B?a3BvbzZmSE5aYnZTTllDRDRuTEZpMVQ2Nit0c0ZXSGVPd3RHamZzM0hXRWVK?=
 =?utf-8?B?MGF5ZUU1VWZpOFUzcmw2dWJGamJ1aHhQbFpSUUp1aDJkOUdqQkVKWC9FWTdq?=
 =?utf-8?B?TWwraDFKR0h6S1c2OEdYUUtKaFBkUmpzOEpzd2w2cW9TcGVLSEkwNUR0NnFE?=
 =?utf-8?B?aVlEeFZETk01T2Q1Yzh2MEUrOUJYTW91ZzhZcXFPOUczT0xja2Q0akk0RDB0?=
 =?utf-8?B?T09uL2dvMzIveHJwU0ZTUjBBV2pZRU0zNW8rcE1jeVdHYTlkK2Z6R1FvZU9h?=
 =?utf-8?B?MnEwdkJnQWNxRUNwUU1YblFnWDFVN2lFbmhSUzhXSkUvVWZNamVwK1ZoNlVr?=
 =?utf-8?B?RzhTYU1XYVlwdjQ0VlVPNnNKSXphYmgzNENUYjZPVkUrMnQ4NEx3eGhwWUpl?=
 =?utf-8?B?UUFYeElLbFBEeWpFS2tKUTBBOGRSbjR5NVp2ZWlTY1lPeTJGdlU2NUdCVmR6?=
 =?utf-8?B?QUxNY0ozOUZ6QjJ3RU5FekdNRnpLbW1KRmNjYmhsVk1Wa0FZMUo0YTVwaXRx?=
 =?utf-8?B?NEZxVm1vNFlPUjdqbG1uYXcwQzJ5S0dmaFJzT3BhMEduSStjS0dzc2ZHREtC?=
 =?utf-8?B?T1JYaWE3d1RTeXBEY0xQWENhTE9TcDNUSDRXa2ZmNzR4NEFUZDhkTVpUMzVK?=
 =?utf-8?B?Q0lpSjNhUGtseDdQeEZjNlU3OTZaS3NCcytIQmdIRHJiM2ZkQUtNbEsrL0Ir?=
 =?utf-8?B?MEZPWFdMQnhGbnV6c21kRTdEVlFxa2d4dnRkbSthbVhRdm8wNVpOOVBZUEJY?=
 =?utf-8?B?QzlsNDNBekZJSmkrUzc0ejdKUlJLdmxWeHFwZ0MwQmNBQ1luKytDU1dzQTNq?=
 =?utf-8?B?LzVYRVk3eHlXM1c0ZGpGNERCVEJJWXBZRGRuelEyRStybloyTVN0OTNmSFVj?=
 =?utf-8?B?WElzeFp0WVh3R1JXQnMxc2ZvQ0pYZWlZMXlmWEVhVHA0YnVpNGdDRm13ODVn?=
 =?utf-8?B?aU9QNHdHOVVjNG1ZRTRVZ3FhRDA5M3UrTDE3c3lRZSthOFBVOTdJUk1lYTFa?=
 =?utf-8?B?cWhnblRwa1F0c21lcHYrNUo2N2M3ZEZtM1RXd2U4dmNsTHl2UkxlaXpYMkZr?=
 =?utf-8?B?allxYnhEMlRoYVBDQTd0Tk5TOEhIeDlvTmFFcExjRDM1dGQraDFrOEl5Vkdl?=
 =?utf-8?B?UGh6TUtEcUlzNnludDBIckt6VW9zeVNuUmFyanhmMXdxcjBOMXppZTVIcGo2?=
 =?utf-8?B?YXhSWlhpZmJLeWxyR04rYU5KYitSbWxCaXNiUzZraGRmN1ZoSmJYTlBnOXJV?=
 =?utf-8?B?MkV0aWI3OWFTMkVGTUVhRGdXbUxIZE5NTFhHejg5OVVjeFc0L25XY3J2QXA3?=
 =?utf-8?B?b0UzTGFkbUZZdE5vRGxSNjJBUVd0MnE0NFF1czE0K0xZTldBaHcrRjlVK1Rh?=
 =?utf-8?B?TjV0ejlGNmU2UWgvQlRJajNnNEQwWGpwTWFWY3VDZFB3UitFeGZDU28yLzBE?=
 =?utf-8?B?clJzWkkwT0QraUtvakJMVEJjcmlOenhhbUczL0RnejBVV2ozMGdMUTRaZjUx?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b7ff26-60fa-4be3-2310-08dc8c0ce16a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 00:56:53.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xw7W1Ju7Q4BaLMFZ4ouaK15cLKcGb3GuwmqEqao7PxpobYTGxamjFhTEajtdjzwGWM1eyXQ2bqeD7LbhXtgBJtVTikdM8lD1TGWCK5VL+v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6861
X-OriginatorOrg: intel.com

Hi Babu,

On 5/24/24 5:23 AM, Babu Moger wrote:
> ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
> Bits Description
> 15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
>       Monitoring Counter ID + 1
> 
> The feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v4: Removed resctrl_arch_has_abmc(). Added all the code inline. We dont
>      need to separate this as arch code.
> 
> v3: Removed changes related to mon_features.
>      Moved rdt_cpu_has to core.c and added new function resctrl_arch_has_abmc.
>      Also moved the fields mbm_assign_capable and mbm_assign_cntrs to
>      rdt_resource. (James)
> 
> v2: Changed the field name to mbm_assign_capable from abmc_capable.
> ---
>   arch/x86/kernel/cpu/resctrl/monitor.c | 14 ++++++++++++++
>   include/linux/resctrl.h               |  4 ++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index b35d04fc761b..1602b58ba23d 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1066,6 +1066,20 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>   			mbm_local_event.configurable = true;
>   			mbm_config_rftype_init("mbm_local_bytes_config");
>   		}
> +
> +		if (rdt_cpu_has(X86_FEATURE_ABMC)) {
> +			r->abmc_capable = true;
> +			/*
> +			 * Query CPUID_Fn80000020_EBX_x05 for number of
> +			 * ABMC counters
> +			 */
> +			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
> +			r->mon.num_cntrs = (ebx & 0xFFFF) + 1;
> +			if (r->mon.num_cntrs > 64) {
> +				WARN(1, "Cannot support more than 64 ABMC counters\n");

if (WARN_ON(...))

> +				r->mon.num_cntrs = 64;
> +			}
> +		}
>   	}
>   
>   	l3_mon_evt_init(r);
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index bf99eb9c6ce4..24087e6efbb6 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -153,10 +153,12 @@ struct resctrl_schema;
>   /**
>    * struct resctrl_mon - Monitoring related data
>    * @num_rmid:		Number of RMIDs available
> + * @num_cntrs:		Maximum number of abmc counters

Maximum implies some limit and it is not clear what limit this applies to.
Can this just be "Number of monitoring counters".

Thinking ahead ... when switching between different "MBM modes" it
may be that one mode has a different number of counters than the other.
Since "ABMC" is just one mode it does not seem appropriate to
connect the "num_cntrs" property to ABMC.


>    * @evt_list:		List of monitoring events
>    */
>   struct resctrl_mon {
>   	int			num_rmid;
> +	int			num_cntrs;
>   	struct list_head	evt_list;
>   };
>   
> @@ -177,6 +179,7 @@ struct resctrl_mon {
>    * @parse_ctrlval:	Per resource function pointer to parse control values
>    * @fflags:		flags to choose base and info files
>    * @cdp_capable:	Is the CDP feature available on this resource
> + * @abmc_capable:	Is system capable of supporting monitor assignment?
>    */
>   struct rdt_resource {
>   	int			rid;
> @@ -196,6 +199,7 @@ struct rdt_resource {
>   						 struct rdt_domain *d);
>   	unsigned long		fflags;
>   	bool			cdp_capable;
> +	bool			abmc_capable;

Shouldn't abmc_capable be a property of the new struct resctrl_mon?

>   };
>   
>   /**

Reinette

