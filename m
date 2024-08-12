Return-Path: <linux-kernel+bounces-282563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC0994E5D7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13CC3B214AF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AB214A4DF;
	Mon, 12 Aug 2024 04:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNwQZpIj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3805E13D538
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 04:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723437810; cv=fail; b=ErLZxMhTop4DRi6cjCUeTwiGBDWjHlGMhh62os63BQ+dGrTPmUF/glir8xmaJtuicDgEpZj6YIjBIUHt/V7BvcuNk+7ix4zvHEERqeCXifHQZ8ZmTvClHu3ehVoPO9vMPxtSevyikORZrj4FYpHqUOX+/Z6fYVr1ebutlbW78G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723437810; c=relaxed/simple;
	bh=QXwnfbwh0elQysKXzPAXL5ojleBgYmrzB8LTF40u7go=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c+OVB2zOBBMMbqp3s0sx1gr4CG/1wZkLStc6gaUyFUe/FtiuNfO4Sr1+HJRPQFHngV2VcpDWhZMLVihYl8MvzYEr34vRN+AD3ClQgkuu5nn5eGWyBS9VtDFnuM1uMEunRUlcAE4bIE7AOIqxX/bbTR0V0CDbuF/LJrUB4TMttEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNwQZpIj; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723437808; x=1754973808;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QXwnfbwh0elQysKXzPAXL5ojleBgYmrzB8LTF40u7go=;
  b=QNwQZpIj3eOrCc9vxzOxP3NxrdkKh185ndAP803mt3Fruj01Qay60PY5
   I1YBIlIFbHUY/7D2xgUCEfmLLWk/5NOaZWAQqUPlpZlYvAM6taKnMsE78
   VHACygnixgPGxo+9FPq535AVs7zW5+yyx4iOkNmgwVKnafyMai5GQt6IQ
   OZnXNV1JOA+yu9GErGCcpHep7juvDQ5yGsGaNSU5Gauf31zk7+thpW8Zp
   8fq2rMOPOGY3x9q8IWykJjXewcOEhoJtNK+QNxTLOtoUeH5V9jO0ThtL3
   2QHENOjqvWBouRIYY+gekqTSPpYUf8kzlSVExImendGvfoJukpgTKcRcn
   g==;
X-CSE-ConnectionGUID: 3O4bG9lPRFe6j8y4n7W95g==
X-CSE-MsgGUID: HFY51obGSLuDgkFmSMClWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32922760"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32922760"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 21:43:27 -0700
X-CSE-ConnectionGUID: HXTtirjKQ5mdr+eoLJ539A==
X-CSE-MsgGUID: IE/VJEelTzGYEKRkTBCTuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="57798504"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Aug 2024 21:43:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 11 Aug 2024 21:43:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 11 Aug 2024 21:43:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 11 Aug 2024 21:43:26 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 11 Aug 2024 21:43:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UI+Y7a/EgQ3goI+N8mzuGRlxUjBr5RhcdLpHsOa6t+Q+r+Z3RYjf6DMoLIycZE99/iap5qtBeZRrkiL5yDAZ/OgQ/3J/fboPvolOwsWEYRsDh2ercNZTwNSi5DFt/ghEufmO4oSNxRMIxkNGGei5XQX4aHRssDVCdoJHZpX4IoR4kYVY6Z9XGkoTVTH9o73upLuMphZxckvEPRaFVa58MhUEP92E79llLnKAM9TavYOMq25ChIdOisvGuJwubG8GKKmwEZHwMr+xuYiASVa9B4Hb6tRhALY63d4KdynWY7RmlLIdjZuE4ISzgjbxGcuTp/qyoNTnMsNnT6yOWe8EQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLSolXcyOHRwBhD+OEMcnCVrYdCaLl3wYd9jNQuYCLg=;
 b=Pa2a7bU4BzEF1RWau87GtczbGjyzB3nz58UtDDTRHB0glAMAz6s4hBD5FXEi334mAL39K2DbzfFU0G+wpfex2q28+r+pOyn8DFuj+nQnMqRPa0nMH4bFj/Uu1URtFJQXuwO5rNB2nKlDiB6bmVtKDhGGmFtSaSwZxF2QXc0TRwzKwnjD8jYeYvSVGrkhgRbPE1FnbTKyialX5uuXAVs455ZXbf4UKTqCoCDSirYp8dPQvfHW/LGjntnbWeh0aRzgPxJXxLXQB/K7onQ3kG+IC9L+DPB/5HibdTl7eHthzsEt5nlhOkvcjtJI3GUZU17XHiYdksMLrc2jfpHA7feNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY8PR11MB7945.namprd11.prod.outlook.com (2603:10b6:930:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.32; Mon, 12 Aug
 2024 04:43:19 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::47aa:294c:21c9:a6b8]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::47aa:294c:21c9:a6b8%4]) with mapi id 15.20.7828.029; Mon, 12 Aug 2024
 04:43:19 +0000
Message-ID: <c7e0d029-0a64-4b27-bd62-cf9a3577d7ff@intel.com>
Date: Mon, 12 Aug 2024 12:43:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] c0bff412e6: stress-ng.clone.ops_per_sec -2.9%
 regression
To: David Hildenbrand <david@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>
CC: kernel test robot <oliver.sang@intel.com>, Peter Xu <peterx@redhat.com>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Huacai Chen
	<chenhuacai@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox
	<willy@infradead.org>, Nathan Chancellor <nathan@kernel.org>, Ryan Roberts
	<ryan.roberts@arm.com>, WANG Xuerui <kernel@xen0n.name>,
	<linux-mm@kvack.org>, <ying.huang@intel.com>, <feng.tang@intel.com>
References: <202407301049.5051dc19-oliver.sang@intel.com>
 <193e302c-4401-4756-a552-9f1e07ecedcf@redhat.com>
 <439265d8-e71e-41db-8a46-55366fdd334e@intel.com>
 <90477952-fde2-41d7-8ff4-2102c45e341d@redhat.com>
 <6uxnuf2gysgabyai2r77xrqegb7t7cc2dlzjz6upwsgwrnfk3x@cjj6on3wqm4x>
 <5a67c103-1d9d-440d-8bed-bbfa7d3ecf71@redhat.com>
 <CAGudoHH4NGgPdTe2yL33TNNFriPM9mVM=0_iuh5dLuesZXQMAQ@mail.gmail.com>
 <5c0979a2-9a56-4284-82d2-42da62bda4a5@redhat.com>
Content-Language: en-US
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <5c0979a2-9a56-4284-82d2-42da62bda4a5@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY8PR11MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dbeb634-216b-413b-c083-08dcba894988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3E0bEtxV2RwQUthMlJpT0w5ZFlWUXkzYURlOW4wTGRTYUtSbGx0WUpvZWJH?=
 =?utf-8?B?MitFaFVtaHlpZS9xZ0VkbXkxTnc2Z2FvQi9GMUNtTVMrUmtpU3FPdlhIKzdx?=
 =?utf-8?B?bHNmeG9UWFk4U1k2bDRqZ0RGdk1YQm5kOWNxOWREZFhBUkxHc1k3Yk10QTI2?=
 =?utf-8?B?c01wR0FneW1XaFZOMmR2bGFESFUwZE01VDhSSmJhRE96WExoK2Y2aTlEbm55?=
 =?utf-8?B?MnlRK0F3TjVKbGc1b3BxdmZ0Z05TTEYwd1ZwZFBzVjg4bUNqWkNRRmpTbVNM?=
 =?utf-8?B?ZVY0NFoyU3dKODF2SFFLNlJOQVFVcTN6Y1hBWWcvbVZRdDF5WTR3N0ZWc05y?=
 =?utf-8?B?Smtzdk9YUElDMy9jNzRzRm9mcWRQbFVUeUZUM1VvUzBTaW1tTmlIZDZ3S1JL?=
 =?utf-8?B?WTR4U1Q0UG1wZWhHbnZNNjNlRU1icEdUdklJUG1OVHFJNTVnbmlXZGJQZXJ5?=
 =?utf-8?B?aEgwRFlIT2RIZ0NBY3AyZGFlMUIrd3ZjSE96dXExakJYeHovWVVVUVVNUGU3?=
 =?utf-8?B?T0cxS0F4S2h0SUs1WkZjWGJ2d1BwMDBxelhseEZXSDBnV1g1b25PV0FCVUVV?=
 =?utf-8?B?NHlFMnlqcVZFR1JFL0tLNVlRTkNUTnJuRmNnNzljRkdSVmxJQmd1aFdXTXAv?=
 =?utf-8?B?Yjg4bFB3bkRTTG8xVHpGOUpCbzVlMklUQWVGN09EUm5hY2hvalFjOTZnWVRQ?=
 =?utf-8?B?amNHY3o2aFpxbThrYTdsRHZFZWIraVpHQXY0eFBjOUxkakdnQU0veDhCWEQ3?=
 =?utf-8?B?REFiakkrSjlUcHRTMi9SUGxhMEMzR3g2K0RteVlKU2treEM2RERWSGM3ckpl?=
 =?utf-8?B?cDF0LzBaOVM1UlpQblhzSUg0ZlhHYzRHQ0w3ZlBZTnU0VUxwWkFrT3VETVhx?=
 =?utf-8?B?TjdIOVVUMEZyRDFwb2dhTjFTQnBTN3lFcWUxWkIzNTZiSVNrUTRrb29mdVB0?=
 =?utf-8?B?UE5RWXNHWGpabWI2bXJWWGhISTZGaHJkL2JUeGYxcXJLWnlhQlpMUlVkdVV1?=
 =?utf-8?B?QmRZUkV2NTZ0ZVFrTnh4NEF3OWZQNTc2QmU0dGVyWmZ4RmdBazdSZDhVcm1q?=
 =?utf-8?B?eURQOWdHR1REN3NEY1A5RnAweE1ZdDZtMzZpaGRrbWJGcTNiRDBJN2lKRjBM?=
 =?utf-8?B?aExRZzE5WVFkOVN2NkxENXBFT3FSemFHcXlYcVB6MWJBYVBEMkYrWTZNMzY4?=
 =?utf-8?B?ZUpqQ2hiM0EwR29md2VjT3NHeGJVbWEyZjZNcXRxQlM2SFRiZFEwRzdZdFhK?=
 =?utf-8?B?dllVVFNZR2Vpc0pNNXg2M3RwdkVoOW43ekhISXBWa2t6dk9PVEVzZDR6TnN5?=
 =?utf-8?B?YnVodkwvM3JveThhRm5xM1BGcEo2NlBYV2JpM1E4Z0ZKVXkyNE00QnRyWFJm?=
 =?utf-8?B?WWszZ0NNNHlpdWRpR2xwWHVPU3pTUUcxVzFjZTBRZUdBYXlTcFlXaHlTWjM1?=
 =?utf-8?B?SHJSNVRzUGQzUUxyOWRZV2h2UUorS3RvK1ZlT0xMdHhqUDF4cjBXcDJCayt3?=
 =?utf-8?B?WElzRXU1Vk1Nd2dEYUZoNjdpNjNhQVJnY1ZUTUdHN2QwRnNsZmNaRG4zWHU1?=
 =?utf-8?B?Z2t1emZ1K3YzaWFmam9tR3AxUFJkcFB6RjBXSWJPcUZidE1iZmh4UkFGVDM2?=
 =?utf-8?B?ZmllakZScmc0VDByYTVMRWZZMXZxeGl1MzI5Q2JHUEZoakxsSGpFdm03VG9T?=
 =?utf-8?B?V3lLbENxdy9yOEx4Qko0dG5GZjU5S0U4YjcrSG55TXlZZ1V6QWVpSU4vQ2xw?=
 =?utf-8?B?SUg5Z2MzRUpkQ1BhRzlWSHFqMmpKZmJGS3ZBcjkwdnMwajRocmhCU2syaHJy?=
 =?utf-8?B?RTFlbFUwWCsrTGE1TVRNUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3EzWDA4T2dJS2Fnekp2YWFrUDBXYW04dHkrRnl6Ly9XSHU5ZHp0OHJxZnVp?=
 =?utf-8?B?R3Q2UFhUdnhrTkdKZEw3VzNjRzBITTZwanZMUjhIU2MvK25BWUs3RGkzVkFZ?=
 =?utf-8?B?aUQ0RGdoYjJPRVBDR2wvdmVDUEY3QVdiNFQ2ZTEvc2FJaXMxamNERDJZRHdk?=
 =?utf-8?B?MVd1S00xVjdIR3VLQnJieWFIeXR2eG9rcTNIRGVqd1ZBeG1QNnJSYkpOcFVI?=
 =?utf-8?B?RkNUMHVRS3lKUVh3ZjdNNTNIazc1SFBBamhoOVZyYXV6MmxmaUt3ckVWYVZV?=
 =?utf-8?B?c1RHMk9hM1YzUTNhNHduVHdoTDlrOEdGcndsWTV2MVIvUENCZmZzZzVhVVN3?=
 =?utf-8?B?eFFnOFZBKyt3akVTb1M0aktWV3kxQ254d3Z1V1ZUMEUzc3lkdXVBdXFNYXlu?=
 =?utf-8?B?bmNib0tBRDhwSnluSWNmeXBaQ3k0NXN5aDBWSW5BRmIraU1DR0Q0c3FuZGd4?=
 =?utf-8?B?YUc0NmFoNFVocndSczU4eGxNTXNJYkxRcGVZY01wQTFheU1pRjAyNjR5d2dR?=
 =?utf-8?B?L1YvdVk2VFJzeFF1T1psUGhESzJ1ZktxNkxDN3lUSEF5MGdsMDhvMHE3UE9H?=
 =?utf-8?B?cVQwUzRNWXZycXJkYmJqdHRtdmM1QlQ0d1pieFFpbXd3cmFtNzRKSUFMdnZW?=
 =?utf-8?B?U2daVzVjS1NzNG9CRzllcjJWREg3bGpZMWN1ZVZFcGNubkR3anM5L2JjZUMv?=
 =?utf-8?B?T3YwSDJURmd0aDF3b3JLb1Vwd05aQWV1QXYvR0JpTnpBNjIwZ0I2WjlDd0pK?=
 =?utf-8?B?T1luU051b3RJY1E0NzJVS3BzZDgzUFRqUTFNcUlRTkdWMUlaWWs5UjNZUnlY?=
 =?utf-8?B?dHFjaVE4c1hBSjZXUWplUG1nM0dMaVZ4aHhCZFBwcFZ3N2ZjSllqVXV0M2s1?=
 =?utf-8?B?KzJIbkxqSXgzdEJxSHNQVGhhSENIcnl1aGJQYkprNCtFSlM0UVRHYkhBVkxF?=
 =?utf-8?B?bUdjUkQyZ2NZOVFzVXRNOURKVW5VbHU5QlB1czczS2V0V2x6Yk5BR1RSTkk1?=
 =?utf-8?B?KzMxU3BJWDJiKzFvTmFoS0RvZThCRjMyZk5RcFBidkNXc2pVTnNHMkZ3V29R?=
 =?utf-8?B?eGk0aXRCTXVSNGJvN0FYQjV6dnZGYzVmSkdiUWlQSGNwc0lsNG9XT2hjNDMz?=
 =?utf-8?B?cXRVc0lXU3hFRkFxNkpHYnFvUjNiS0JtR1dTeU1VSW80VHR1WWZYbHFDL00x?=
 =?utf-8?B?dERyL1ZCRTB3MEZNcktOVVp1UTVnSklJZnBlOXVlQ21xbnMxbEZhRVllbWI4?=
 =?utf-8?B?VU9HN1dGVlJxaEx4R293emtLSEN3eVo1V2VDMVNzZEFBVGZoNDF2UHFtSWRn?=
 =?utf-8?B?ZHU4bCtYYm5icFRjUEFobk1MTDhpbkVDbExLMFMzRnJSM0Rad0tOUHF4d1c1?=
 =?utf-8?B?eVBzZ0Zjb1ZEVjNzWjlCWHZUbHBXakkvdGhnU2tRWHY3YVF4MTFwMmQ2MFdY?=
 =?utf-8?B?ZW1wbHFOTHppQWd3TnVLdGNCZ01OSHFvQ2dIckNXbHRtUGlCVW14cjVJWWV5?=
 =?utf-8?B?d2phSjQrd3Jja1Jsei8xZjN3c2FzT1Izelg5VDUrR01OY0R3WE4xL2JKUVdm?=
 =?utf-8?B?cUFWTExQcGdJelpoUHgwS202SHpZNmNKM0dybXlqWWQzM3YwdHhHSEJwbDE3?=
 =?utf-8?B?S0U5TGRGS2xwQ1hLSTU2djBkWU9nQVBXdm1EV0pzakpxTmxRSXJhWFFjZWJi?=
 =?utf-8?B?NFhpaTdtZ2RCS2VISnFDdVZjQ0pLYTZWQjB6aTdrNHh5UDQ5QmVYckFtTHIx?=
 =?utf-8?B?NkhKRVE2Q04wYmhtTFV2bWVOc0IzM1M3cHJWbW1CNVpnTjI5TTdQS1NLRkYx?=
 =?utf-8?B?VStUSlAzWUtCb1NUUGdaYklIOVJPRzVvcEJWWkFTLy9NRzZyaHNrMzVGRCtP?=
 =?utf-8?B?M1k2bCtyUGRRd05HcUZTZmd0MktCeVZSSVp5YXpwQTFNSnh0SFFTdW9haWNp?=
 =?utf-8?B?NksxeXpNZVZPRUgxTi92b1crKzcvdUVveHNiTHJqL1lMRXJ3akVOaXVoMll1?=
 =?utf-8?B?YnZYdnQvTXpDVXhMY0IxaDZMUW5lZ3o5cDVZa3NTNlJnaFBld3RzUGxLMlZ6?=
 =?utf-8?B?NVpOekVPbjBLOHQyeFMyRHltN1p5cnBDWG96Q24yMTkxR3MvUUJnZHlvamJv?=
 =?utf-8?Q?rQ287SEvtcrevaCwfM5vfrIS9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbeb634-216b-413b-c083-08dcba894988
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 04:43:18.9475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbDKyrr7A4eH+igWN7udgfcvWbfJtti0oHzTWcGsZwmuFrsJDMtCJr4TXq1GzTwo85RjWC5+sgKcOWjALgr3Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7945
X-OriginatorOrg: intel.com

Hi David,

On 8/1/24 09:44, David Hildenbrand wrote:
> On 01.08.24 15:37, Mateusz Guzik wrote:
>> On Thu, Aug 1, 2024 at 3:34 PM David Hildenbrand <david@redhat.com> 
>> wrote:
>>>
>>> On 01.08.24 15:30, Mateusz Guzik wrote:
>>>> On Thu, Aug 01, 2024 at 08:49:27AM +0200, David Hildenbrand wrote:
>>>>> Yes indeed. fork() can be extremely sensitive to each added 
>>>>> instruction.
>>>>>
>>>>> I even pointed out to Peter why I didn't add the PageHuge check in 
>>>>> there
>>>>> originally [1].
>>>>>
>>>>> "Well, and I didn't want to have runtime-hugetlb checks in
>>>>> PageAnonExclusive code called on certainly-not-hugetlb code paths."
>>>>>
>>>>>
>>>>> We now have to do a page_folio(page) and then test for hugetlb.
>>>>>
>>>>>       return folio_test_hugetlb(page_folio(page));
>>>>>
>>>>> Nowadays, folio_test_hugetlb() will be faster than at c0bff412e6 
>>>>> times, so
>>>>> maybe at least part of the overhead is gone.
>>>>>
>>>>
>>>> I'll note page_folio expands to a call to _compound_head.
>>>>
>>>> While _compound_head is declared as an inline, it ends up being big
>>>> enough that the compiler decides to emit a real function instead and
>>>> real func calls are not particularly cheap.
>>>>
>>>> I had a brief look with a profiler myself and for single-threaded usage
>>>> the func is quite high up there, while it manages to get out with the
>>>> first branch -- that is to say there is definitely performance lost for
>>>> having a func call instead of an inlined branch.
>>>>
>>>> The routine is deinlined because of a call to page_fixed_fake_head,
>>>> which itself is annotated with always_inline.
>>>>
>>>> This is of course patchable with minor shoveling.
>>>>
>>>> I did not go for it because stress-ng results were too unstable for me
>>>> to confidently state win/loss.
>>>>
>>>> But should you want to whack the regression, this is what I would look
>>>> into.
>>>>
>>>
>>> This might improve it, at least for small folios I guess:
Do you want us to test this change? Or you have further optimization
ongoing? Thanks.

Regards
Yin, Fengwei

>>>
>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>>> index 5769fe6e4950..7796ae116018 100644
>>> --- a/include/linux/page-flags.h
>>> +++ b/include/linux/page-flags.h
>>> @@ -1086,7 +1086,7 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
>>>     */
>>>    static inline bool PageHuge(const struct page *page)
>>>    {
>>> -       return folio_test_hugetlb(page_folio(page));
>>> +       return PageCompound(page) && 
>>> folio_test_hugetlb(page_folio(page));
>>>    }
>>>
>>>    /*
>>>
>>>
>>> We would avoid the function call for small folios.
>>>
>>
>> why not massage _compound_head back to an inlineable form instead? for
>> all i know you may even register a small win in total
> 
> Agreed, likely it will increase code size a bit which is why the 
> compiler decides to not inline. We could force it with __always_inline.
> 
> Finding ways to shrink page_fixed_fake_head() might be even better.
> 


