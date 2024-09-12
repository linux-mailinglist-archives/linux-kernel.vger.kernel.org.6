Return-Path: <linux-kernel+bounces-327097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF179770FA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D5DDB22E46
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAAD1BF815;
	Thu, 12 Sep 2024 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJyW2y77"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C55515573B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167668; cv=fail; b=OnTGctchNkToTEJfag2b9cC4Y6xtkhXJ51Nrv3uchYQBIO3lAbyZll6touY9BXfBHjLBSamVZQiMR2X31QQ5RykrpFPjCkUfX+cP0htKW63asAWC0WvQllRpr00IWrWxGK1DOqXer5sGNnXXMNwHk+pGwf2n8xV6r8YbUK67iwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167668; c=relaxed/simple;
	bh=pH5gUeg2g1mhdHgmLpGSZDPYldb+7r6DNB1alYAT1ho=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nETclnuX0QiqC5J+Lk70tMgsjI6BKUEpl4NlAC7VFv1cMMWSgZNl6cpkyYsQa0HqdrWTulO/OcQt0jXqv0YICW/0+LQrz9vuohhPOZQeUjrYixB4QEswvbOyz9VTEfTS9aCiFRK7f9ET8TIlvMvh9fisuc3xmo5+GRXddttmyPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJyW2y77; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726167667; x=1757703667;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pH5gUeg2g1mhdHgmLpGSZDPYldb+7r6DNB1alYAT1ho=;
  b=ZJyW2y7760t/bRw0N6DB4a/7Kr3XWyBux73Uwf/n8RPQ/NavwSkzLGBs
   K3iTZp2iu3glU/Z4rIDQfdGfRZZq+hpcY9G/QoR05y8Gw1rdFJE/WcSdk
   v5APSAnvdPqWvJqyBHcjDAqUhspIFX6oDKJWTsXRvJKtMIXRg45HgJrnb
   0EVqT9vhZIQl7ug4+TH3gLujoW6DNfRLSu7RotJFASRjDLpNMx/H06D30
   IedLa9mpGbZEgX6509T0wgs28etsju0MPY/vA9diodl/4LA87WmWy3FPn
   1uznCZ7TUL5x6Cctqccp/LvXcd4Vvgi+j5opoDgs7C+uxFXt49RBymn5/
   Q==;
X-CSE-ConnectionGUID: c/RDKz60R2GZFlbf5cPEWg==
X-CSE-MsgGUID: hPPATBFtTz6sXWtC/Xz8JA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="28823754"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="28823754"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 12:01:07 -0700
X-CSE-ConnectionGUID: tWbOH0rqSoyoiQCNg564tg==
X-CSE-MsgGUID: VY0VTwAoQbqGa7u7kuGDog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="72158984"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 12:01:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 12:01:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 12:01:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 12:01:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPMe6IBIcecNjz5OL8TSLT3EALWfvWVfdueQhdvgiZjoTp5AROj3l6ZbDkdF9YJyWg5cSXRsENLI+t0aY+4JzCS6pNrsSZQvLOyDVsfRi360qOt3RLa3gSRyfMXoxnTpmSG0JpDHb3yey6vuatbOSeq1yxDWUBD6H8u0F0kO3Wi/1k6AuQG+L7kV7HlzHAH2Ctl7s45azqUTNjVzuVa/O3TMzR7gxoF3nFHfKgxn7ORKssXOaTKRdpRyDn4uecGps3pJ7diA1lDbGkxIbTj6CnlSGGFP6kvVLgA1/Wlb6oKj1Ep0hghTx18Gam+NLza8XCk5xW38tvT1L2r45bYnjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZCKaBkWBHYOtehIE+BYdSOIL9O/B2YDR5FvJEm+4Rg=;
 b=FDrbrnc79PHcfWtXtKPYO1Rd8MSpbCDrko+nzFMA8Ner09JoOjX6nCN2VX9BFnbT3PZnoG3mOh7XUCxzJO+n45NY2OR4rX/OiczT4vfNqKcgXi/4P+yrVe1KFT7CcAWAkPHwAFwrE2Lb2n89YGSLuTzj+OVihjlbrtjUe6BG+vKM55baBDNURL7PwYRWwD9nthRv122wOrJlt7qnlQyehoDffi+X18G1j52oqFyKjpqzTiMFeFKjkKk6DoQj68n2V2Kbae3AF2JCk3Z2yRCDmhx1Hxk1MAabL3JdsIAJZgtXyDMn67mLggak8XquwJNLb6i35g2EYw/cT/dB4Hdi9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 SJ2PR11MB8585.namprd11.prod.outlook.com (2603:10b6:a03:56b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 12 Sep
 2024 19:01:01 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%4]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 19:01:00 +0000
Message-ID: <f284ce29-6afe-40ce-ad81-b6b2cec9199c@intel.com>
Date: Thu, 12 Sep 2024 14:00:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Qinkun Bao
	<qinkun@google.com>
CC: Jean-Philippe Brucker <jean-philippe@linaro.org>, Dan Williams
	<dan.j.williams@intel.com>, Samuel Ortiz <sameo@rivosinc.com>, Lukas Wunner
	<lukas@wunner.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, Mikko Ylinen
	<mikko.ylinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <suzuki.poulose@arm.com>,
	<sami.mujawar@arm.com>, Chong Cai <chongc@google.com>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
 <20240910170959.GA213064@myrica>
 <f6b0a1d2-c730-4b20-a8f3-afd9a7cf822a@intel.com>
 <14fc2ce22d224f05f4d382cd22f5242297e9fb86.camel@HansenPartnership.com>
 <CAOjUGWfgYoXBzUB8wFvO5LDq+=t7hAEksu0EA4Dc7FwbmUJp7A@mail.gmail.com>
 <f92766c96c993276bec770e8a255bca6cc46c292.camel@HansenPartnership.com>
 <c7157fb7-b8d0-482b-9ec3-d60179a95882@intel.com>
 <0b334090c4bf21740b19371664ad0d78b66830c4.camel@HansenPartnership.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <0b334090c4bf21740b19371664ad0d78b66830c4.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:180::27) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|SJ2PR11MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db25102-81f7-4c72-150f-08dcd35d3e05
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEVrSGQ1N2o5cmdsbmJOZWtZam5WRHI3Y2RDZUYxOUJyYlI0UWFzSTVwTzUy?=
 =?utf-8?B?d2lONHQveklpU29ZNE9xQUhzcDNUN2FNTGZGRlNOSEk2VGZwMmVQTzlWWnhM?=
 =?utf-8?B?V0lPblJ5OGxmeGRja0VYaGp4WTVxYnIvTVBxdEhSeVU2ek9IbC91Z3RTRkQ2?=
 =?utf-8?B?TnNEdHpPbmxPN0dLYjh1Sjc0ZkU0NG1MT2p0WFl2cWFUR0Z1bkxZQUEzc0tF?=
 =?utf-8?B?WE1BWmN2NGNyY2p3UDAwWlVZc0xRRlZUVk1HanVUUjFvaklsVU9YK0FNUDlT?=
 =?utf-8?B?U3RqVTYzc2dtamh1VEYxTlgrWE9weENYUEpFVmlWRjRIQjBqcVJwUFllZTJR?=
 =?utf-8?B?c3pJa0dueGUzK1o1YXh3M2JaZmJVemxqWWs5bUtFRmZvaVpBRUxLR3J2T3pJ?=
 =?utf-8?B?alFkVENJSllsZDV3VmNKSDduODY0VEdSYXdjV1JGRnhHNE83ZzlCM0FTU3Iz?=
 =?utf-8?B?bnVBWm5qWUh4NzdnaUEwS0VKaFFEMzZuVFZEQ1l2elFOTmhuTHY5MnFTRWZC?=
 =?utf-8?B?SFkrRTREMFJLMEUxOThxalBBcmpXRDNGQW9JVW5QaVFQb2F5cU9ad25oTnJ2?=
 =?utf-8?B?WVZYdkZtOUVEUGlmLzBFQjIyUS9CT2MxRTYxYWRGK2x4Szk3VXZ0T3dIbnNi?=
 =?utf-8?B?S2lMNHNrUnNxcEJqSmtaV1NYQXYyTTVRMHIxTjZkL3lIL2pFN0RMT2dJMlhy?=
 =?utf-8?B?U3dFRHlSUVd1ajR5eUlOQ2pCNnBnSnlORlBYWVduRzg2SENmREVhR1RISEp2?=
 =?utf-8?B?RlhSZ0VKMXRMNldEbWU1OHdCQ0M4SThxV09qT1Vac0RBbzJuMzFpeGw5RXhZ?=
 =?utf-8?B?SG9XTjU4emlmL0xzTlh1VmlXRWpoa2ltT1J3VkZIamxjNjdlWjNjbmRuR042?=
 =?utf-8?B?TE5NNnFYdnEzTDcyM1NqZWhkRmJNNGUvaWRDdWhVVGhyMkhvM3dwb2M0cDRy?=
 =?utf-8?B?aXo3dW9VZXhaWmVBSTIvREh1WkZRZk5QcGhLcm9GRlpuZ2kzcktlY3FRVXo4?=
 =?utf-8?B?WC9leTlaRllpN1Y2TE12dUU5cXpjL0RRak4rVmZvVWYxUTJJQmNCUnYvMWV5?=
 =?utf-8?B?U0FPbmdVSUgyOXNuTkxLcTJONHlkM0I1UllXQ3FBclN0RFRCbVJ2aHhaZnZk?=
 =?utf-8?B?UWRqL3FDOTJxNmErWjZKcWNkOFU4VXpxMy8vYXBiN2d5ZFJvSGxFaCsvWFli?=
 =?utf-8?B?MWx3UVhyTG1HRTJ0SUFUNFdFZHBRMmFPL1F6dyt1a1dLK0Q5bjhpeDdBUUNn?=
 =?utf-8?B?bHErK21xQXFFUy9UeXVYNkN1d2M1cU9xMzBwS054aFRQdDV0R202djVTc2pZ?=
 =?utf-8?B?ZHJpMUNhZVpnU2dJMmdkclhlN3VDZUdteTZmOVJ2Sk55R2Q4dkxSZkVmRVRI?=
 =?utf-8?B?NXRTeDRNUmlyTU1lOVFTRmE2L1FCbmxkTlFNa0h2amM5d1JBenVHVVVXY3pO?=
 =?utf-8?B?RU9DaXBzelh2TGoydUlNaXZCT09hVzN6cmpPc1BKUlY5bDJJdG5LWVNkZHNl?=
 =?utf-8?B?UkRKWU9RR3BJU2RiVHZ6bml1alYrWmdNZDg5d3Nrb1dIbjVJNDJJL0lISmIx?=
 =?utf-8?B?enZFUGVIVk5qV2JVdXV0R3hZdTNrb0tJOUV4ZGhEZW9CMDF0d3VvVW03S3dL?=
 =?utf-8?B?d1lIUGxDR1RQb2ptMm9ITVVHOXBGVExzSEs4ci95a1lhWnBuZlJiblBBUFM1?=
 =?utf-8?B?alJBckhpcm9NTTR4ZlIyOGMvNFhpalYrYngyM1F5RXJMVlh5ekFyN3lPYURE?=
 =?utf-8?B?Qk9oenE0L01sN0lpN1MxS0hEdVNMUGxGUTY4Q25weGMxZGNwb3UwRDhRN3gv?=
 =?utf-8?B?QXBONmlLOVh2NzhWK2Ewdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S05YYVhmeXdpZkIwRDgzck52Q1RueDkydlhGaGl4cURyVElObGlFdDU4c3E3?=
 =?utf-8?B?anU4MnNxRWR4R2NieFFpSFd1Rmx6U3haWXl5UTJGRVR2TDJDczhNL3Q3MCsw?=
 =?utf-8?B?SXM0M3BiSDdlQVpDWGJIL0F4VXJCT21iN1hLVDJ2c3dLaXNmMXlFbklvUk9q?=
 =?utf-8?B?cnBZc1k3ZElDUlcxUE9VVGdmQ0p3V29Ga2puOVgzK3RlZU5GQ29qT0VxRFAv?=
 =?utf-8?B?UUR6bmdKY3NZayt2NFQxSjFDK1BhMFFFNUp4ZWdka21ZdEhhSzFCOGozampP?=
 =?utf-8?B?S0d3a0VoLytPSlNib05Ja1lEOENNZTR3QkF3RE5kWWNoNmhJR1ZQZW5TdXg5?=
 =?utf-8?B?OHA3T004ZGpUNklRY212QndjL25EUzllMDFYYU9HdmxLRDl2NjUwbzVpOFNS?=
 =?utf-8?B?NmFtOS9uRVNHT242bUU2YmE1dXp2aUlkYXJRVkNjR0RZQlQ1aVlhZTFOSk82?=
 =?utf-8?B?b2tBVVd3ZXNxcEVqdVc2c2FxTitmU05vRit1SG9rc1ZSeU5vRGp0Y2M1emZk?=
 =?utf-8?B?OC80VG1MSllPSnhSSXBwcWg4V2s3K3crK1EyUGkxMFd0bGM2dGNIckFZUE85?=
 =?utf-8?B?alhoUkxRYkR1eGVFeEJPTmpEV2lWTTRqaXZpM1lFakZrUzNlNEprdVA4OTlZ?=
 =?utf-8?B?ZjdyRjlERDcvTVBUZ1hic2EwaTZVRmJXeGh0a3JsOFBTY2ROV0R3MlFIbWFX?=
 =?utf-8?B?QkI5ZkhwdG5IcE1jcGtZSVZuSkd0LzBmd1RPbE5nWEpTYy9oZHBXcHdkRG5G?=
 =?utf-8?B?V2g3OVZIM0JQOFVoYVhXRDFrRlVzamZRV2diRTBGQXVrVitnTjIySEtlKzdF?=
 =?utf-8?B?aGZZeDdoMGJJOWZvSm9idUswbG52OFlYOE4vUFVoUkc4OG9ReSsxYnppSVV4?=
 =?utf-8?B?QlZkZmVKRUFmeitIbDlic2R2SlhxdlRkSG0vNmVxVUw4eEhnclVPbkU4RVZ2?=
 =?utf-8?B?YW1xMDFUV2xkaG1qeXR1MWQvUUNad0YwME8wck90QVNuZng2OUo5RjA5c2tR?=
 =?utf-8?B?YU9TVjMxOEJXVEpXdEJINGFPOTY4VUFPQ2Vjc3NJOFZFK3kzTk9OSlJOaXBF?=
 =?utf-8?B?VEZpcDlrQm5JUUxoSWNET09IZUliTHNqdWNwQmZnbzgyOG9vUnR5cys0UmVs?=
 =?utf-8?B?RlVCamVTQ0Zyb3hvcnp0MFRtZTA4MmROYWNjL2owdXdEZFdvZjlqelJEVXNq?=
 =?utf-8?B?UW9ZOXdFdS9XWUNvWVBkVkZpaldXZkkzVTY5VGZyRklGZC9Wc01RVWR6VStM?=
 =?utf-8?B?R1FIZzB3Yld3bDhOYXNIc0xHR3NVSEFVNnIra09RNWoyT0dsUjUzU0ttUXBs?=
 =?utf-8?B?RGNCeWdLdWU3OFNOSkJ0STZwUTRlcjEwMVE3ZnErOE5vemZJL2U3ZncyZFlR?=
 =?utf-8?B?VFBpTThQczU0VHI1Mm53dGw2VUJnamlRSFQ2WUxZTCtBTmovS1ExZnN2eW5N?=
 =?utf-8?B?TUREMzNOTHVqbVBJRExya1N1aUtkMS9hR253SDZ3S3ZVOUNNOEZCNVgyVkpw?=
 =?utf-8?B?WXlPRjZzc2pSTTltdDRJYTl4Uk5leTdlbXNteEdLOWxhVjJwWVgyMDBoV05a?=
 =?utf-8?B?eHhaNm83MHltV1pwb3pmQTZSTk9yanFsM2FaY3JVdVlDa3daMnptK2M0LzRT?=
 =?utf-8?B?aXMvVDRuZ1ozOEFyalE5K2k0MHlrdDdwTUpYQ2p0UElDWDRjWlFrc3hYdGd5?=
 =?utf-8?B?azVHaXk3RDNRTnRKT1RobVFQMC9EVVBxYVZPNGhsWU5mRUxmNDVjWXhjT2lz?=
 =?utf-8?B?QkVZZ0lBekc5OTA1UDdWK1Q0NWZwYjFNNER1bXJlRzlxQVo4b051NTdueE1w?=
 =?utf-8?B?alRzSEo0M1hySG5VM053bTMxV2NkMURSamtRMjU1T1RNbitNdGJGWGxHMmRw?=
 =?utf-8?B?K2dDL3pxd1daUlV1K054Qnl4UUxDdklINVFHWWhJUmRCVVVMdngvRTJ0cUU5?=
 =?utf-8?B?Q3BNYmc0QlpyNFRad3c2L2RUY0w5UmlKL2d3ZXpQMlNlNG8wK3k5S0R4TDJL?=
 =?utf-8?B?RTdaZzBwdFM3K2JwdUVIKzhLWGEvRUdTOHZlUU1MVWFnSzlNZkNuQ1BHd3Ri?=
 =?utf-8?B?ZzVnb25YNW9zL3FsSUxTZEdEQmF0UHFBeDcyVVF4N3dqWkZDKzdkUk41TklT?=
 =?utf-8?Q?dIqsTW7KovuCZy03eGGXW3pAR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db25102-81f7-4c72-150f-08dcd35d3e05
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:01:00.8057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOHOE7iiL8rRTS+HqLLuH/+evhBEVhHzgrCZnN/bBLU0D+2FrkP9MxyURW8agk40PGktuhmofIuOWgSI4mj9aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8585
X-OriginatorOrg: intel.com

On 9/12/2024 7:15 AM, James Bottomley wrote:
> On Wed, 2024-09-11 at 22:23 -0500, Xing, Cedric wrote:
>> Hi James,
>>
>> I would like to clarify that, even though the log format is
>> incompatible with the existing TCG2 log format, nothing prevents TPM
>> PCRs from being exposed through the TSM measurement framework.
> 
> Well, the PCRs are already exposed through
> 
TPM predates TSM so has an existing implementation for sure.

> /sys/class/tpm/tpm0/pcr-<algo>/<n>
> 
> but they don't have much meaning without the log.
> 
Consolidating PCRs under TSM is not a requirement. But if it's 
desirable, it could be done. When it comes to the log, the assumption 
here is that we will switch log format after TSM takes over. The preboot 
log can stay where it is today. Yeah, it would be kinda ugly without a 
unified log, but the separation of semantics/storage is more important, 
because otherwise it will be very difficult to enable new applications.

>> Please note that the existing event types in the TCG2 log format are
>> predominantly BIOS/firmware-oriented, which seldom makes sense for
>> applications in OS runtime. Consequently, most application-specific
>> events have to come under the EV_EVENT_TAG umbrella, which is
>> essentially arbitrary binary data with no specific format. Thus, I
>> don't see much value in continuing the TCG2 log into OS runtime IMHO.
> 
> And the IMA log, which is runtime and isn't TCG2?
> 
By "TCG2", I refer to the TPM PC client profile that defines the EV_* 
event types. I could be very wrong but I thought IMA content/event types 
had not been defined until CEL came along. Though both TCG2 and CEL were 
designed to be extensible, adding new event/content types would require 
revising the specs, which is a very high bar for new applications, and 
is one of the major reasons for introducing this new log format.

Regarding the IMA log, there are several options to integrate it into 
the TSM framework:

One straight forward option is to dedicate a RTMR for IMA use. This 
series allows off-log extension so nothing else (except mapping the PCR 
to the dedicated RTMR) needs changes.

The second option is to change IMA to use the new log format proposed 
here. Of course, it'd require more changes than the first option - I 
don't believe many people would like it at the moment.

The third option is "virtual measurement". We can define a virtual MR - 
say "mr_ima", to replace the current PCR. Then we back mr_ima by a real 
RTMR by logging the value extended to mr_ima. That is: when mr_ima is 
extended by value XYZ, an entry like "mr_ima extend <hash_algo>/XYZ" is 
logged to some native RTMR. Later on, the verifier can replay the RTMR 
log to calculate an mr_ima value that matches the IMA's log. This is 
actually an example of sharing an RTMR among multiple arbitrary 
applications. Events from different applications can be distinguished by 
the prefix ("mr_ima" in this example), and a layered verifier can be 
built - the bottom CC-specific layer verifies the integrity of the log 
without understanding IMA, then the top (CC-agnostic) layer verifies the 
IMA log using calculated "mr_ima" value by the bottom layer.

>> The proposed log format aims to provide a framework for unambiguous
>> hashing while allowing application-defined events. Its primary design
>> objective is to enable application-agnostic kernel/verifier to
>> hash/verify logs without understanding the event records, allowing
>> application-specific appraisers to be built on top (i.e.,
>> semantics/storage separation). Both TCG2 and CEL formats rely on
>> event/content type to dictate what part of event data to hash, making
>> semantics/storage separation impossible. Therefore, this proposed log
>> format cannot accommodate entries from TCG2 or CEL logs due to that
>> design conflict. However, entries of this log can easily be
>> encapsulated in TCG2 (as EV_ACTION entries) or CEL-JSON (a new
>> content type string needs to be defined, like what systemd is doing
>> today) logs.
> 
> But that's my complaint.  This specification:
> 
>     - Records are lines ending with `\n`.
>     - Each record (line) is hashed in its entirety (excluding the
>     trailing `\n`) and extended to the RTMR.
>     - The log for an RTMR is stored at
>     `/sys/kernel/tsm/<MR group name>/<RTMR name>/event_log` and consists
>     of these delineated records.
>     - Lines that are empty (containing only `\n`) or start with `#` are
>     skipped (not hashed or extended).
>     
> Is completely incompatible with pretty much every current log format.

Unfortunately this is true, because this log format has different design 
objectives than pretty much all existing log formats. Another notable 
difference is this ABI is log oriented, vs. most existing log formats 
are digest oriented. A log oriented design allows applications to 
generate identical logs regardless of the underlying CC arch.

> Given you have fairly elaborate decorations for the register formats,
> what's the problem with simply having a decoration for the log format?
> That way you can use the above incompatible log for your purpose but this
> framework can support existing logs and expand to future ones as they come
> along.  All this would mean initially to the code is adding the decoration
> file (easy) and ensuring that append_event is handled by a log format
> specific component, allowing for expansion.
> 
Using CEL terms, ELCD (Event Log Critical Data) could be easily 
encapsulated in both TCG2 and CEL, but ELID (Event Log Informative Data 
- i.e., lines starting with '#') is not. One use of ELID is to support 
off-log extension, designed to help migrating existing applications. The 
`SYNC` lines (necessary after off-log extensions, see Patch 2 for 
details) would also require special treatments from the verifier. 
Therefore, converting this log to a TCG2 or CEL log is NOT always 
doable. It'll be better to convert log format only when needed (and 
before any off-log extensions have been done).

-Cedric

