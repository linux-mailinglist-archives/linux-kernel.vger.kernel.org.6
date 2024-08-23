Return-Path: <linux-kernel+bounces-299519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C6195D5CD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62911F22DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743BB18F2F6;
	Fri, 23 Aug 2024 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8RV71Wa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C148488
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439929; cv=fail; b=AIlUO4KDoqeEbN9PGxWszjehJNx2CAZRCpCbcNG/Zpwrs/5jEbAh3BRAwPjCeC/T/99JTWvYFUMZwQfUfuScoWc/dDStSSq4Vm8idXrGtFprySwcPGVqG0eNtr2PrXN+x9Pq5IKtKl2HNaFMXN1Bl0VmXFMFcaGZtadI+F5HoCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439929; c=relaxed/simple;
	bh=z7BieP5yPVF5hrVISINKt9u2QvUqXpIoPbBf/mJayR8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KtWuntLq+NHT+PYKHbe5Kwy1gL3pEaGXzBaY5J+4h99ZSEKN0FeY2iZcjjUdi5hHtmSYcxYmTmq4Lsc9GuIJ1zVI7D8ZZb1g5Qtqx8EzS+RR9wrHXG6WCzsWgmthDw+afweSLb6TtmJokYLxjc8mqKDynuCc+gNjmYen+HKcsmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8RV71Wa; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724439928; x=1755975928;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z7BieP5yPVF5hrVISINKt9u2QvUqXpIoPbBf/mJayR8=;
  b=V8RV71WaPVb+KgLLAIq00fz5gWaTaDP2ALRl9rWl7T7qkj7tqaSIa29E
   GdhRLDBfiFdkqSGR1yOsQA8ksa1hFQDZ0ofgUWA/ozFEDYAR4xTNlbdCE
   JATr2Y5YMjTouXRom5AUlQbTUh+fQYnJ1gOUQeArpotJyWUI0HyPD6nw5
   uREGjPPR58u1pUdBRu56qrViKjx/lPKuyaJtD3ciAbWHFNOW0bI+z/0jb
   SYbJ13DXRJTKzoiYwof8m07BUV82uJzKJG+Ejc1ioXMSf225P8yj8FYHf
   I5Mbf5fqVobYwqAuw46F+y0LLbplV3/8kOFW8FhYtRwLR9Ni+MLnBcgfr
   Q==;
X-CSE-ConnectionGUID: /VTJRBYrTySmt2YrjI/HhA==
X-CSE-MsgGUID: 4avU6aPZR4O4wKqQKBQgHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33548497"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="33548497"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 12:05:27 -0700
X-CSE-ConnectionGUID: f1oQHNZLQN6FGSogrzW6HQ==
X-CSE-MsgGUID: zb4Z78tTRa2hY6j4PBTZyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="92678526"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 12:05:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 12:05:26 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 12:05:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 12:05:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 12:05:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyEKgon2lsbvtVKD3gZ+/6azWyNrGM6ewCGCGVZHvMtc/5kIces3B+50ClOAfD0GVPgvIacrPQTI2h+bFlIj75qMeZH1ggWp2vhH4XJdOOyKg8B53/+jp0TRz0QijI0yvfjVG2TPRbSusfN2pFHrrFlAaNCmPgugKWyaVPsckutblpNTxgru7jCspMuOG9xoG6Cee9VkeMAjM26LMwVEdgKMOyQ/KTpHfSvEow1aVEgLZyNwmyNjlEmg1FN5RgtFaGKrNsrCHELnoeYgWFtcAVtA1a2La6sKwss1JuCiWJwM/cRxFkuJT3a1CPTY2okFX7WHh/97Ya9w6uYLoh/QKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1eCworCp3oZe2RZtAXaNjXrbdpMDzRHl7Wl7ooWE7k=;
 b=NMdCjavYBnkjdOCu7yH1DhzIj78RLZeBB4WsR9ZZd/ZdTnLuH4vBcCodRzitJcougVmcAsAth218BSkS/kVw0C+MYhSgIHJDXMxfYLKoZkNQRx9KmtRbnGX0VFbwDSMKu2V6IoovsqRX88fvi8HsY25sXnJE92noBw6oV4sbsE847HN0Zwnnwmwi8NTIDNhxADX/p3oBKIqtvvGKQnjY6di9lI6QaLlDPj5QSsr5kJWwZQbs70ls2ieyKX+T5DB0+YWnJGY5QqjKALoEcnj9y44OsMDJ2DJtoBb0IKP5HBw73RLlN+QyUdDvQb13S7hjj6QrmPsXS7WujQcfF8MhoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA2PR11MB4891.namprd11.prod.outlook.com (2603:10b6:806:11e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 19:05:23 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%4]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 19:05:23 +0000
Message-ID: <096cdf1b-bc79-4e88-8ae9-99a373245ef8@intel.com>
Date: Fri, 23 Aug 2024 12:05:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] x86/cpufeature: Add feature dependency checks
To: Sean Christopherson <seanjc@google.com>
CC: <x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Uros Bizjak
	<ubizjak@gmail.com>, Sandipan Das <sandipan.das@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Vegard Nossum <vegard.nossum@oracle.com>, Tony Luck
	<tony.luck@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, Eric Biggers <ebiggers@google.com>,
	Xin Li <xin3.li@intel.com>, <linux-kernel@vger.kernel.org>
References: <20240822202226.862398-1-sohil.mehta@intel.com>
 <ZsfJUT0AWFhoONWf@google.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <ZsfJUT0AWFhoONWf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:303:8c::29) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA2PR11MB4891:EE_
X-MS-Office365-Filtering-Correlation-Id: 08003469-ba51-4e16-0afc-08dcc3a68a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUI3V3VzU0F3YVdhQWZoNVpad0VVQkc1aDlFbXh1VnNKOFZYVUNPNzBvczZE?=
 =?utf-8?B?RE5zVkp6dkI1R1Y1c1I3aktma1JYN2JyRFE2SmxpNnpMU0JObHBycjRsemlq?=
 =?utf-8?B?ZmRWa0d0M0tIQVNUNHo3R0ZwbXNGMjRmdU1OeHlGbXJoSWxzR2pEN3JGbEM3?=
 =?utf-8?B?MVExayt4RGJmMkczQ0N4UDNmVk5nSWUyVW9LcUlOdVdZZ0I2clhnNk9qWDRX?=
 =?utf-8?B?bThOeXcwMDJtZTM3cGg2NzMzcHIzYjdPaWtDNVJyc25ySzhSclI1bFdKVlVZ?=
 =?utf-8?B?MVpOdDdaSUo1Rmo1dFVzRlI3UHg0TkNWT1FKOUVIMFFkK05NTGFsY1ZCakVD?=
 =?utf-8?B?b3RnL0NacHJ0UTdiWllDY2ZvVUkwSDlibG9QN0FMSHdlRHVlaDhwYmdnNnpy?=
 =?utf-8?B?VFJzOFhodkkzTmRFdWhGVEJMTVorWDE2cDVOVTN4dlNZR21PRVBDTjRBZkJu?=
 =?utf-8?B?UnZtZlBTM3dKNTdCeGp5dWtId29TeUxMTVhhaHVzYVZ6a0lmVUZXY2ZqQlhC?=
 =?utf-8?B?NjZ3THUvalV6N2Nmb3ZxYnQ1U3BDQjZyNy9VRkI5UEVrRHZFZyt2Uzh5ZkRj?=
 =?utf-8?B?TmEyY2ozNGJuVVFBTnNNaXBRT2xMOXA2bWNDZUk3VEdOWWxnV0NTUG5PcUh6?=
 =?utf-8?B?OENFNXB6Qzk3RW8wbVRRUnRDaVJIeFpPbHJuT1hqU3VueENBK243RThBNGhU?=
 =?utf-8?B?cHpCaXVrMkFQcGNoY2E1emFXdlJDL3dOcDJQdUJrVDJ4UHdNcVFoUGoxcmgv?=
 =?utf-8?B?OC9WTE9GVWIrQmN4TUt1STE3SURJdXJ3ODVSRW4ySmUrNm9NZ3FUdDZQeHgx?=
 =?utf-8?B?M3VySndpQ1cxZ3VDTGlVUklXM2lCWjhXOVZlY0xaODVUNHkxVXJPOFh0NzFB?=
 =?utf-8?B?YVdrSVYzMExWQ0VUUk5tcFkvZGlRVkVpVWlRSFZMQlN6YnBpcGwwWjk2UGtr?=
 =?utf-8?B?TFpGMzViNTRRbnB4NU9sVVhkRi8rdHI3UGkrWVppb3dqNEp2L3ZORkFDN0g4?=
 =?utf-8?B?RHdocFBZTUEvbE5jYzFpV1B2Tk9KR1JIU1UrQy9MMCtQT0FidysvSnlDUmZV?=
 =?utf-8?B?R2NEK3Z1OWk0UlZIUDF2dXdmSWdPQzRpVmlWQ1BCa241MGlrK0wxZmtqWmRH?=
 =?utf-8?B?MUpFT2tDSHRZQWw5RTNGS3lmQjV0ekpwUlIyQTNOWVJyTkVSZjFscWpIYngr?=
 =?utf-8?B?Y1poS0NhazU3ellQMERnUmNHU0tMWDFHNDhLMVRQWjlrRWswUHdVdEc0dkRl?=
 =?utf-8?B?MWNrWnFvVmxYTHE1TGxQUHVrNE5EQ1ZTR3E1Z1ZxQmUzNkVyK1p0V3hSRUp4?=
 =?utf-8?B?ZVhNQWcxQi85VVJQaUNVNFNQQjA0MXpsYlE1K0RNZkRicVlJMEw0eFJHWU1C?=
 =?utf-8?B?VkRhMGp1ZlcvNjVYR2tFSitMWWRDMExHZW45NE5hK3RDUllJcVJwZWRsTC9q?=
 =?utf-8?B?NHpBMGtWYnVHakFUdS9hWDFjS0RHeWhMdW1XcVhMZGFFcGU2RUcyQ1FNRzRD?=
 =?utf-8?B?UG8yNUd4eGgxQlFzU3djL1QzdjJiVDFURHJzZGZLYVJIaitVcG8yTzk5eU1R?=
 =?utf-8?B?RTRhcUsxcmRRYWVkRXRNZ1JwUGFGbnV5enV3VllmTVg0dnZPZTREUzZJMXZI?=
 =?utf-8?B?eEorTEZnaElxNXV6N0RFK2lSZG14Z1VpMXFsREJyMkVZeC84Z1NmUTFaR2lk?=
 =?utf-8?B?WC80WGpnRGZBNlgrdHU5M2VNRmN2bWFDV3lWUFZ0Snp6cDNZRHJKbEdHc0tv?=
 =?utf-8?B?WjJnWk9VYkZrWUh0ZEJLWitIWnF3VWM3T3BWYk1NdzBBSjBkWmVvZGdYcFhG?=
 =?utf-8?Q?JibBGUgfrAVcJoWRMGSaQWYG08HhzbVKvZb7Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnFxZTFZNDNoMnB5MGNybkJFMEhjTmRiNDhnQ3BLV2JkUHJFR2JXMWxJSmhS?=
 =?utf-8?B?RzY0MHFNNUgwNEJvNTdaSUsyaitUR0RmeG1DbkZYeU5kN3V1RU8vb0tZcGp0?=
 =?utf-8?B?LzJGL25MeFBXZlc5Q2M2cEYyWWowaDhjVXA0NlJEOEx5aEpzam1CM0hRUkRh?=
 =?utf-8?B?M21iV1JNcFpBU2c1L1dkZVFkV0JzdmsxRGJjWGVFK3pFZXNhVS9EbUtMU3JK?=
 =?utf-8?B?alVqRWcwcnZkZ0ROQ0FXOVpZM0pxTnowaitTMkFqQXYrZndLdS8xUkhtd3JF?=
 =?utf-8?B?NHlLM2hTUSttTG9MN0pHR3VBb2wzTzlaUmxSaXNIRDNLTWhscTlhL1pFaENi?=
 =?utf-8?B?cXhyVEpIVHQ5dW9SVXh4UVJVYjZYR3RMdks2QjVRS0U0OFJSRWFpK3JCVS9I?=
 =?utf-8?B?ajlUTW5PS0FnRlQ1Uk16R0FUTGRoQlVmcTBMUnN2MFhsTWdEZTYvTTk5ME9v?=
 =?utf-8?B?WlVQYUhQeTQyKzlMRDA2OXlqQXgxd0NvUlNSZWxuUlRDc0NiV3pBVFlkNTNC?=
 =?utf-8?B?aFRBMFQrcEwvaXhGaU9zb211cFNHZW5mUlBpRk1OZEpBM1ZYN091dDdkWXBK?=
 =?utf-8?B?c25mZk1neCthWjhtTXIxRkJ5NVhtaDRCRnNVWVViKzVHNmxybDNiaFpNRHpk?=
 =?utf-8?B?bU5XV2FvcFpSWmlWcGd3NHIwdDl6ZmJnRmtTeGVHaDBITTBYQTBsNVBadjRF?=
 =?utf-8?B?NkxlKzhLZ0VUbTBpNGpJRVJuWTVuRW93Q0lvVVFSaVlYcStBWVFXS29IU1hO?=
 =?utf-8?B?NWpKeTliWFkyOGVWQ2NnM2JwVjg2R2VmSm1MRUhjZDN6T3NPdm9DVUZ2UEFa?=
 =?utf-8?B?S1FuY05USXcrb05wazl4QlBOcXJOZmcwMHlHS0tHNzI5WkREemk5bW1lU0dV?=
 =?utf-8?B?MGRGUWZNRS9SZXIyZHowRTIwWnZjcGZsaFJQeXE2WDNVODQvRCtIek0zTG1n?=
 =?utf-8?B?eGdza3c3RkVCWE9penI1dmN6aU1JcHdmYzltS2dxcHJhd2pZVUJIME1INWlC?=
 =?utf-8?B?aXhSMVVjL0JQSnlFT05iTmtuZkpUVHYwN1F1ZE5YMC9oSFc3SlRtcGxnYlIv?=
 =?utf-8?B?RmpERkxWeWM4cTFwNm9KSUVRb2trU0d4ckNOR3ZoMnpZTE96VDlDbnVnT2dn?=
 =?utf-8?B?eThBZkVlbGVIQzYxa0tIZWZ3VXg1K1pGblh0TU1WZEZXdW1sckt0eVVMaXNL?=
 =?utf-8?B?bGk3UElxcEdCQ1VudEVrLzlZbng4OEJOaTRiU1c1WXdJMnNPVnJrbHFRZUw4?=
 =?utf-8?B?WHY3OTJHWExWVmluTTVlS0lVYWxJd25naXl5ck9VTWhVMk8yVko4M05abFMr?=
 =?utf-8?B?WTlsTHY2bmFyQUY2T3I4dlJ0b3NmNnllTndpc3p4SGZ6cVEvc1RtQy8xVWMw?=
 =?utf-8?B?bmliNlJsZzBwNE5DaXZJN2d4SFhOSDJPaWVkWTBSMHVBblh0VEtIbTc2RlZU?=
 =?utf-8?B?TC9xTWZDbnFiM1JkTURUUFFGQlU2WnBqSENiU29UMnh2ZVNCVDVUYi9kQUli?=
 =?utf-8?B?akt0cGEvd29JZXpvUTNHcXNJZm5vU1lHU2NEbFIrSVNmMm02VDFLbGxMZEM4?=
 =?utf-8?B?RFBaSDVsWFJFUHhoRGZGbGFvdDBSbjV6TFI0MEJhK3I3Rm1rdVloZlJ0TjRQ?=
 =?utf-8?B?VDNSM1AvVlFHSE9MRCtqc0tHaCtKaytabWRXSThkVWdmS1diYVBOZ3NyRlU2?=
 =?utf-8?B?dG9kUGkzdEQxTVphN1JHT055VE5Mdm84dGpGT1ZjcnJ1QmE5eVZHQTY0VGtk?=
 =?utf-8?B?eHh1S3RxRUhsNmRyZjc5WDZzR0l4Ny9HeG9SYm45RDZqblE0clJ1R2JzSjMy?=
 =?utf-8?B?VUZCY3N0YVlQcHd3K05MT0pLVFR6YzhoMDFNRWRkUUtKMUR0akpGYWVBTm9Q?=
 =?utf-8?B?VkNYM1RGa0lWcUZRTDVROVprMHlCOUdhRU5hbklpUDMvL0w0UUV3M3dWMi9j?=
 =?utf-8?B?SUR2WkhGN0FCWXphZ0NsajJvdzFXZE5wSTcra3VqRFExU0haQ3dpc0h1eDlK?=
 =?utf-8?B?NjJwSVpFUURReU8vWlIxVTZGUzhickQ4d3lUZHVnaFNMTGxwYVoxK2QwUm50?=
 =?utf-8?B?eDVIeG0vQndVZzNwbS93ZC8xajlCa0FsWWVFNGtZTU9pWFRQVXdZV3oranhT?=
 =?utf-8?Q?k60C1txmNSyANpGDPIPo15N2R?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08003469-ba51-4e16-0afc-08dcc3a68a43
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 19:05:23.2772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Pk6ubwuj5TxJip462NofX18XgLiN0WHQETB9Axjcs2prxLaCjWVHRE9VMU7lW/mZVfmfBiu8FWE1rXJLkdiLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4891
X-OriginatorOrg: intel.com

On 8/22/2024 4:27 PM, Sean Christopherson wrote:
> On Thu, Aug 22, 2024, Sohil Mehta wrote:
>> Arguably, this situation should only happen on broken hardware and it may not
>> make sense to add such a check to the kernel. OTOH, this can be viewed as a
>> safety mechanism to make failures more graceful on such configurations in real
>> or virtual environments.
> 
> And goofy Kconfigs.   But yeah, lack of any meaningful fallout is why my version
> didn't go anywhere.
> 

By fallout do you mean that the observed behavior when the kernel runs
into such a misconfiguration or just the general lack of such
misconfigured hardware/guest?

I tried experimenting with the behavior for the last entry on the
cpuid_deps[] table:
{ X86_FEATURE_FRED,                     X86_FEATURE_WRMSRNS   },

In this case, even if WRMSRNS is not present, the kernel would go ahead
and enable FRED, which would cause a panic when wrmsrns() is exercised
in update_task_stack().

I agree to the second part that such conditions are more likely to
happen in pre-production environments. But I still feel that for the
rare case when something like this seeps through it would be better to
disable the feature upfront than run in a kernel panic or some other
unexpected behavior.

> https://lore.kernel.org/all/20221203003745.1475584-2-seanjc@google.com
> 

The code is very similar to the one I proposed. If we do take this
forward, would it be fine if I add a Originally-by tag from you?


>> +void filter_feature_dependencies(struct cpuinfo_x86 *c)
>> +{
>> +	const struct cpuid_dep *d;
>> +
>> +	for (d = cpuid_deps; d->feature; d++) {
>> +		if (boot_cpu_has(d->feature) && !boot_cpu_has(d->depends))
> 
> I don't think checking boot_cpu_has() is correct, it's entirely possible for a CPU
> to have divergent features from the boot CPU, e.g. if a feature is dependent on
> BIOS enabling (or disabling) and BIOS messed up.
> 

Yeah, makes sense. cpu_has() would be better suited as you have done in
your original patch.

>> +			do_clear_cpu_cap(c, d->feature);
>> +	}
>> +}
>> -- 
>> 2.34.1
>>


