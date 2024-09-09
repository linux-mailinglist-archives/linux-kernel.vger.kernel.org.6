Return-Path: <linux-kernel+bounces-322084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448549723C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7B11C21FB4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408A718A930;
	Mon,  9 Sep 2024 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrPDjcL9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584F189F45
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914220; cv=fail; b=OeoVVAMY5FEuTjbfSr90i1M2UZk3U5X5Mp/pz6nEnsBy13eQpqTYF1f1wKrWThFbY6b12nKK4slFM6dBqkuWMvodnCqrISeTqqBO9uJxfeEkqDGqKWTq/UNSkio6Pie+Lw7fezqL5Nyrs4cevdIwaoKuF3TH5tAqu9mTrK8ulvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914220; c=relaxed/simple;
	bh=Clj+u2Ro+g9lMe56WkLGABwXZMnyZ92FMLpbR0I9UOg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s5axfeAggcDJVpShoVAn/vjZCiNIBfPo/wg2iEbrkciqeMyY9W2V+l+0eMBBMoqiKIfSU0YY7sFsKngnnpOaTkIuTiHIXHmmbFPTKvONCXz3mUvlAEmed5jwDbZ6fAyl2280ua56V4CETWA9fOfgtlMGIOGnol0EUB1FSQ4F0ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrPDjcL9; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725914218; x=1757450218;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Clj+u2Ro+g9lMe56WkLGABwXZMnyZ92FMLpbR0I9UOg=;
  b=IrPDjcL9s2t3JhDpTRkGgBY6nUs5t5qo4ygCeCluXenk6nmOTI8waaEL
   IcTkNSIYoBI/nDrYwsc/qGZiVpaN4ULPguV2uWNio6f89ANIo7onKKx6q
   QvBs8u2sDChjqUeBZdxtJaK1WZEbXrhSfV7flAExBYUGBdpnMYcgSKVey
   cFKiW5rGf2XJu4qaAG5HuyptugZKD0ci8zCYZEkD9ACctEt2xYOjgiixN
   cnDGAOzfjghN3Wb//vbVW2Z9wQAodqj4vlBL9h2NKFza2kakcoisuyN7V
   hyrGZ+n3yjqC7LpTESJywEIB4OIiPoe+hJHv4ocybSk1IT3lpmoLFw1M8
   w==;
X-CSE-ConnectionGUID: o6ZME07EQlicLF8s4XFUqQ==
X-CSE-MsgGUID: AnEe+OXvTR6/q9+115kUnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24786883"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="24786883"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 13:36:56 -0700
X-CSE-ConnectionGUID: acr5Ky9hTwqted+VPU5gsg==
X-CSE-MsgGUID: THFt7lHOR/aAiCAuGQ15rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="67054182"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 13:36:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 13:36:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 13:36:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 13:36:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfzCkXHItiWp+xL11gwf4gQwqvdzFNXhgBUjo9+63FkSH2GMaZkw8ognBZyleYE7boWCAdPigtXb05k9BdgVm4+8Lkj34moLbdMuJWcTB0Smt1+weAE89dz7CJ13YoKa9g0CLnwiyB0fBR3F6OZo20k6XqThbqY4QVGUf8ujSYK+PIGcLOpDSzGWkBonrMrrNuYMVa7/7h5jFX02NLNbqbflK+c7Yo4jQGjr83NjKI2dU1MFpU02ZQnl16BIdayfkeIa3N0/9HMORtFPgjG2ymH1w8/NLAmQllSb+6O2puQ3Lk5bQpHXXcvASDvaDHJetT6+nehDIJKOIi4bOwH78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qxLX8JjRdqW/DKcTUMzP0ISXTSwJZTZwBKBHE5KN4I=;
 b=K2srVhqx4NYbw0iOrSWqHweVdBZAGUtei0MwlQX8VEiq1X8zTpREiFEpPzUZbpaABrc/5XOTXRtC9Dh9ifaVyOiarlT+/hFMVDgtteJDlCQ51w4GSfxGBz1isKTaaICs8jt8tZ03nAHvn5JTkaGgG7+iJ5WRohiidLtQFSF+RepibK2kN8iylQPmJ9jFVae6LLq4+EgMihyvlOAMRBILIr4OG7ZcwsdB4x86FvP2cpjqgqMhz8Md2iu3mKTPY0HgQCVXz7dppjdv5VyQV/NyuJ8HNsVDuAVuIJQMZ9TOTK3teFEIoEDT5XnbBujw/lbi/4cgoHI5d22MLdoas7lkOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB6571.namprd11.prod.outlook.com (2603:10b6:303:1e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 9 Sep
 2024 20:36:51 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 20:36:51 +0000
Message-ID: <a97f1b6e-66a1-4d52-9cfc-ac424263dbf8@intel.com>
Date: Mon, 9 Sep 2024 13:36:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lib: Export the parsing functions and related data
 structures of the PLDM library
To: Shawn.Shao <shawn.shao@jaguarmicro.com>, <linux-kernel@vger.kernel.org>
References: <20240909071721.1768-1-shawn.shao@jaguarmicro.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240909071721.1768-1-shawn.shao@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 53fafd76-c6b3-478c-db92-08dcd10f229d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eU9za2toaDdvK3h0M0xRZllvSERxNk9IajdVZWpLT25Id3Bjemc5NmhmMDFF?=
 =?utf-8?B?dms3clBoNTQ0ZW1SK1NwSWJOK2ZpQlk2SVV1TVhJRDlHOFRRSG5MeFkrd1Yz?=
 =?utf-8?B?RmkvejFoYW8wSm9LNVNRRGI3WWN0c0pUVzN6UlF1NWcwb1k5MkRnVDhseXlZ?=
 =?utf-8?B?MUdWTXRZSHVVbEtmeE9WM2RzQ0hXM3NUUDM1Q3hqZDZ6aHNLYjdnVGR0Vjhu?=
 =?utf-8?B?M015MFh4RGJNZFA4SFBvWHg5ZThvYVJWUGJxR2RQWDJYK3o4RVBQMVpuODE1?=
 =?utf-8?B?UzBjZWNvUG1DNGNibHZtNjFTNjVYZGgwd2RrNmlXMjA1YnRaYmQzUkJicFpW?=
 =?utf-8?B?ZlU4cnllcSt5bitZS01tT05tRm5oL2QranUxeHdJV21xdXZmbWJwYjBYZmVm?=
 =?utf-8?B?MGVaMWJvRVFtY0hxTlVkQjNjTXhIZE8wcDBQM1BKZkxkSXlZOTRPbmZBSHFh?=
 =?utf-8?B?ckh4UGlWeWRwYmZtMzJnbGlFVjhLNjltNVlBQjdlVFRjSkpxSXRsYVo4a043?=
 =?utf-8?B?ek1EVlpJWVI3YWRXTkU1czFWM1hmaFlXb3JiZklkSDNpNmx5ZjYrb1FVbVBV?=
 =?utf-8?B?Q29oaldKa28wR0l0ZVhIblJtT2pxN0pxOENGa1FNbndqUGRZWnBEY2hYTFZS?=
 =?utf-8?B?cHVNcndYSTBBSTdOUVNFTU55SXIyN0NxeHJUNmtLNnRvSXNPQU5BdlZRQjZi?=
 =?utf-8?B?YzkwM1NKSTFlT1ZVbVNiM1ZYRnpuYUlJdG4ya050TVZMTjBhd3NXYlg0NlZ0?=
 =?utf-8?B?UlhtUy80b0NKOVkybm1RWFZGYmdYZjh2R21Ua05DZnE4eE54d21CTGFpN1pG?=
 =?utf-8?B?Y3grZXE5SEY0RzlWUGFzRitSQUtTVTFLNW1vQWw0VmQ2OTFUdmE3bjgwYjJ3?=
 =?utf-8?B?aDNyWUN1aE1MeHBEcnBvcUVLelZYVllCaS8yU29NYUZPeGhoTFdKM1A2Zll2?=
 =?utf-8?B?NXJYdmhUQ1RoMzllb0JPMXFyakhpdGpNTHhvQnRDZnhhd2NNV2dRV1RJUlB2?=
 =?utf-8?B?Y1NOazkvdHZrQW9OWVI0VUdvOUFiaVZLME00c0tUUWhZaXFPTTBHU3ozV1cy?=
 =?utf-8?B?STZRUEtoMlB0SHZkSjJvaXUzS3dQdHFaV2E3ZGlrdm9TWFVyT2pGVXE2NytP?=
 =?utf-8?B?aGE4RGt4Z1RkeUNlRDNTSTE5dElWbHB5YVowQ2x0MHpJZWhkSjJvbEhKY0w4?=
 =?utf-8?B?dVpRaUNEV2s5VlVyakdtTXM2VE9HVGpxUjVsZDVDOVBrQ3B6WlNvUVhBZ0Ny?=
 =?utf-8?B?dllCQUx6cUZPM21DRzl2N3dJZ0l5QkV1Q3RiZXA3T1RkelBMOEZjTHNJTVRB?=
 =?utf-8?B?WDIrV2ZjbDhJVDhQWFNOSUdqejVMK2NONWhwditvVnk0b0pFaUxWMGViYXBY?=
 =?utf-8?B?UGplWXdWaXRFekprWkFKcWJXMzNEZlF3Mk9ZMHVPZG52VjhWTEJ5YlQ4MHVI?=
 =?utf-8?B?NWhvdHZudFMzOW5LSkk1Q0J0ZzlSWnRxOG5UTDBXNElST1FWMjJNWitySHNk?=
 =?utf-8?B?MVZ4cnVsWUx2SThHMXVpVnpWWktRWXhRK1RSZ0Fqc1JReisxdVdoQXJSRCtq?=
 =?utf-8?B?TTUydWRoRkJwaDA3SkhLU3cySy9Bc3ptUEhTSXUwL3BTZmIxZmlObnhmZGJz?=
 =?utf-8?B?SkVtMHByVWFZL3hpeUU4ZXpDam9DNS9UUXBZalkyV2dkekZ5ZnBQcHZRZ0tv?=
 =?utf-8?B?Y2ZBbCtNVjlFNmhqcW42ZXo3aDNnNm5ma3I2OWtBaG5pSVNUVEkwZnBhTFVm?=
 =?utf-8?B?MzZxT2ZOazd2Nm52S3BUTnBZejhYWUFKbjhPeU56R0R3QVBvMUtkYkIraGp0?=
 =?utf-8?Q?2y2QXTd74fC++QlzNJWFCiGoqIrmsnCOE0y7U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU5sM3NCMWo0WVdhWWVEaE5iZnNhY1U5MW56eXE2SU5MMTYvbDBLMTZpZjZn?=
 =?utf-8?B?a09PaFMyajZjeXJrclJwZ1NvaWtmdXp1MnlnakZtNnMrVm9rck5aYitWZ1Vl?=
 =?utf-8?B?K2pCY1VhNjVqZFVxZ0tMVzllWER2TlZxMVVjdUhnL2xsTWVKTDZqUlZHR3pt?=
 =?utf-8?B?VzhaVlA4MktzL09hUVhzdWVWVlVKeUxwTnFlUEJMcEFPVGozRWVXV1o3ejlC?=
 =?utf-8?B?aFptVk1DMGU0cGdFUnJ0K2Y2YUlTSkVMRGZFdDdJL01OT3IyV0NrSiszYlZ6?=
 =?utf-8?B?NmRGOEVCODV3eXo2MFVGb0pRTGsxTml3NGNPbWZ6Uy9KRm5JL1hpbGtGOC84?=
 =?utf-8?B?TUQ4d2FuVk1keUNXRUluRitvYTRHRUVZM1VYNDdZT2pMYzBldTFvT003YnNs?=
 =?utf-8?B?VjdwNXRJelFseldicVo4OENqYXV2Zjl3MFNUUmp4REEwWE9MTTBBalVmSXdX?=
 =?utf-8?B?U1lkWTVZYStsZ0phczJTdVp3eHdCSUg1NFAzS3hNcy8yMUZ3UjU5bUhzbFpF?=
 =?utf-8?B?aG1zNEJTNXlCUkxlR2JqeTZwbEtoMHdzM09iSHRJS2tJemZvQzk3NU04SDYz?=
 =?utf-8?B?MzJ2OWs5R2hTNXdOcExWREZEcERneHQ0NDdxcU5MMU9LNG1BbTJlMCtGR3Fq?=
 =?utf-8?B?RVlEU0V4a3Y4SUQ2Uy93WDZybEZtbk00ZS9rZEdJd2p4azVmMlJQNVY5WXBu?=
 =?utf-8?B?cFlrUlFVWms2QU90MVVTdG5VdStIeTc2VG1JNzFOelpad2E5V2gyakE3bk44?=
 =?utf-8?B?d281RmhZcXc5c0Z6TFpWZTFrbC9YZ2NuVDBQaXc3anZKOE5mdXZZc2dpNjJE?=
 =?utf-8?B?T2hkaktRMXRWOTRyYko2VHJPaEZ4cGVhT2dENHBjUHhRVmJseERnRXJSWG96?=
 =?utf-8?B?QitHaHFGMW1lN0Zna2VHSndvQzVIdjBRTjJPZEtzWHNPTjlMclpSdUJNSENU?=
 =?utf-8?B?MCsxdzVST3FlREdadzRsL3Z2eGlLazFqc3ZXSUh2eUJCNlRxZitUSXJsdzNH?=
 =?utf-8?B?bHB0b0hmUGcycGpnaThEbDArOXVWYm9zUVVjbDlSbEI0MXVxUlRjd3dGSG8w?=
 =?utf-8?B?d0FnUjlGSVM1SFFBd2FJbFB5TjFMbEZvUVJlWE1jNk9qTUlOR1V6U01IWXBR?=
 =?utf-8?B?TWZTZnE3cExxYnFGeVVabzI5dzYrUWN3U2JUT09MUm11TmZQMUVCblVYUjEv?=
 =?utf-8?B?N1FBb3dMZ0MramR0aHMzV3ZuMVJvVGRwMVp3akpEblc0K1JQbzlFS2pJNEtJ?=
 =?utf-8?B?YnBVN1lGUjdmOUtiZjNKSmNSa0xRMEtydk9RV0dlVVB6TTFmTTA1RWNQVHlN?=
 =?utf-8?B?LzBFSjNqMFZ6cHJSUm5ETDNHNjU0VjRoWVhPbDBrYkZ3TzhxWFFqd05rY3Iy?=
 =?utf-8?B?SzJzS3J6dE4yME5XRGpjbFpQSUM1NGxKM0RHNDl1akFWUVhDZmlOMiswVlpX?=
 =?utf-8?B?Z2c2NkdQVEh6b2U0RnNYT0hJOEdrcFFTOEE1N2QzSTRJN1VkR1YvMXJoQmdm?=
 =?utf-8?B?ZkE4UURGaUhlNEtEV05QYzdoenpJL29FWWcyWnBKVWVCNWFqUHpOa0tNV0RW?=
 =?utf-8?B?VjdjMjY1bGtsMi9FWHJ0M1VtRFF6VWdzd3V4eUdKQnFXYlVjd0c3dHB6QSto?=
 =?utf-8?B?V0hmTkJ4RTlvakxQK2RxSEN0dVE1UWg4UjdHUW5xdDZqVmUyaVpuTFkxdFoz?=
 =?utf-8?B?VWdKRjY0M2pDRXFxOTRKTURBRXpOWGNyNEhWRURFUVVnTTF5dHF3bWJVS1dF?=
 =?utf-8?B?UVZxOTl1YXVSUlJqS29tRFBNMkUvK2ZYNC9OTFVnMzByT0dpUVJRL1ZMeTg1?=
 =?utf-8?B?cmpqMHpqLzkxQXBpMG1nQ24zUTZDYnlZTzVZb2RSREtycitoRzA5K2xTc3FY?=
 =?utf-8?B?akVYRFg4OVBXNngyRloxN3hWQzVmbG5SWFNOYXArRWZpMHdpOWlOZHo1YllB?=
 =?utf-8?B?dFFFSlZDa0pnWStmcG9FTjdsbDVNUWQ4QTlBUXBkYkdDa3drYkpTOWVibXcy?=
 =?utf-8?B?dmZoRHJzN3RJa2VLTisvQis5SlUzRHJ6THRQT0Fhd3VoM2tZZGlZM3JFbWQ0?=
 =?utf-8?B?V2lHWmsyY1BPRFZId2dUU0hIUEg5VnBvS0t1S0xkd1RaVkk1YlpXdFNYWU4x?=
 =?utf-8?B?S0hmRlF1TTJ3L1NGaTRrVFpucnNFVmxKS21iQ293SllRNWZQQlRpdDVXRlVh?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fafd76-c6b3-478c-db92-08dcd10f229d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:36:51.6697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6QhC3ZfBoXl8y1QYDppkwkO1J7Z3YjXHJcGECthxRmIKvi/djRlB7uHqH++MZJbaNHjKuXhUCjsReAh/xlJNgL/5WaoEqpRfcf7t1fVC78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6571
X-OriginatorOrg: intel.com



On 9/9/2024 12:17 AM, Shawn.Shao wrote:
> From: Shawn Shao <shawn.shao@jaguarmicro.com>
> 
> v1 -> v2: Updated the commit message, added a description
> 	of the changes related to `DeviceUpdateOptionFlags`, etc.
> 
> The PLDM library is used to implement firmware upgrades,
> but the current library functions only support the
> `pldmfw_flash_image` function to complete a fixed
> process of parsing, sending data to the backend,
> and flashing (allowing users to implement custom
> logic using `pldmfw_ops`). However, this poses
> significant challenges for device vendors using
> PLDM for firmware upgrades.
> The following scenarios are not supported:
> 1. Only using the PLDM parsing functions, as the
>    current library does not support this operation.
> 2. The firmware upgrade process differs from this
>    fixed flow (the firmware upgrade process may
>    vary across different vendors).
> 	|-> pldmfw_flash_image
> 		|-> pldm_parse_image
> 			|-> pldm_parse_header
> 			|-> pldm_parse_records
> 			|-> pldm_parse_components
> 			-> pldm_verify_header_crc
> 		|-> pldm_find_matching_record (xxx_match_record)
> 		|-> pldm_send_package_data (xxx_send_package_data)
> 		|-> pldm_send_component_tables (xxx_send_package_data)
> 		|-> pldm_flash_components (xxx_flash_component)
> 		|-> pldm_finalize_update (xxx_finalize_update)
> 3. The current PLDM library does not support parsing the
>    DeviceUpdateOptionFlags parameter, which is defined in the PLDM
>    specification to facilitate the transfer of control information
>    between the UA (Update Agent) and the firmware.Please refer to:
>    https://www.dmtf.org/sites/default/files/standards/documents
>    /DSP0267_1.3.0.pdf P37.
> 

Thanks! I'd prefer the DeviceUpdateOptionFlags to be separate, but I
think the changes are good.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

