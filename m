Return-Path: <linux-kernel+bounces-514577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5FAA358C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE1416EB85
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502F122256A;
	Fri, 14 Feb 2025 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6k/WyL3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4522222A7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521286; cv=fail; b=bMwFhnQzujcczTb28jQ7zVr5A6/VgZWCjDbRFJvFNV8dMwxWck1D1QqmQ+6f7C6aKMA496h0d+KnLsnJCc6obr2BbBTG9Tmli5VHxs5eDj27+IpoZJK+aM+7PB1jxesJWXruCZKq/Tp36Ii969IkPsp7J91kVNfotGj+kqyTX/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521286; c=relaxed/simple;
	bh=F6f/H3aURKZKV6VWUin9dCzADbPoFt4/uxVlK3qKe7E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r27QxBjAoP0UyRxoWYhPZduBNgrAmhoD9yl5teQcMRIBzWz7HzUlHWTntlbooCE2V8FH6jXGxRXyH4pC3jB3sW7LozHl2v2wEtA5MMJ8Gm167aQENRxNZP8DW6Q+QE0MlWewlvUTagDk5EjRzzvQP0xW6eG5afDj1h8HLWQaf/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6k/WyL3; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739521284; x=1771057284;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=F6f/H3aURKZKV6VWUin9dCzADbPoFt4/uxVlK3qKe7E=;
  b=Q6k/WyL3reC++USNxpw9wBmc5j+ZokWnh4RxnMqiVORrT8GVHCscyke+
   6xrAXjgMMD6lYS2fd1zttS+QwLqXbUOaQwBP8eXL4Tue3ABYcLw10Q7NC
   3x0A4YEtNg2cce4WOpAc601ili9Dns76QWpdh8RdD7gQTL43/NK+wrykF
   0JjpjLSE9sI+W7gGevxIoKFbHHxUVBkmTgsi3o9mweysFlkB9mzhbRCQ3
   AAkVFuj1tbZRFM5+4Qp6Q2RYtYcs4kdM8ZvhX46I3RLWCRmmnKL24ruyE
   fDASy7n8Qq7lM+6O6ISfgjLaKcHPi4rfZtmpmu9AtU5QU2KrRbb5P9K/Q
   Q==;
X-CSE-ConnectionGUID: oAZKtukUQ6+5OtEULkABqg==
X-CSE-MsgGUID: db76nWU7Qz6wBAfu93Gtxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="50889079"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="50889079"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 00:21:23 -0800
X-CSE-ConnectionGUID: UI67639qQ8iPr53b0V8c+w==
X-CSE-MsgGUID: y17JDYZnRSukreTjauejqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118014627"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2025 00:21:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Feb 2025 00:21:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Feb 2025 00:21:22 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 00:21:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiT8a/VGQLCo8NbJDRqMQ084JLvB/xpuldTwUHd5wr/1/Zfzp8mrlNIkHqf1jGq1kaAUi+jmnrOq6wod3n8ppxf++UhVSotIVQLsj1YyD0927F4CpsPskH/7/N5JOGav9rtpT0ZPmAnn9j/SGUrbWI0dUL5VD0fvwpErM68NgW9Us1g3ID54MJstvUApPROpwA7qzb3rQ84rMpz+YwK6M0ASk9bc8cp9tZvzVqIIBJTZ9nfievK2A1aD1oOFjoOXJxVjmmR8IHQsbychBxIdEZ3Uup5AiYjHxtIlPlVzk/pS6J4A/9bJ6Hc6TZqTdU9w8A9+kcoy0C/TrjYCttAOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A92lyeoUSceLW7ws1Ei77N8ZURN8y3DQnHLfvZzPzis=;
 b=XkaZmNL88VAIOg3JTKbQWOCIF3/6EQV307Smx/Y+3rUCRU5ImLVfrhJRqRDFPkoZamQBCtfSUXNcyMMEMm3iw36B7GquFbTq7xNvmqNr7MSDO7E3nQoRjySAB5JsU5iFurjgUu06il+5+xBSR54OQzp9t/N9fuf0w2aPIipYJOdF4953JvGojqpgDwHK/lR0QYFebCw/VVPBau6Cjj3xNfz5Z9WHPedPtFCqEErTIrhYGSwKg8WwBfjPhVR+5W5bac1ODtjZpMupxl/vYYsz+Os7F090gRtDxQCZXtwJFcpqjigMXBbgZu6TaxFQXEJdr26l97cD9qZ8qM8Tw7sIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH7PR11MB6675.namprd11.prod.outlook.com (2603:10b6:510:1ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Fri, 14 Feb
 2025 08:20:47 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%4]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 08:20:46 +0000
Date: Fri, 14 Feb 2025 09:20:19 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
CC: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, <linux-riscv@lists.infradead.org>, Andrey Ryabinin
	<ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, "Dmitry
 Vyukov" <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
	<kasan-dev@googlegroups.com>, <llvm@lists.linux.dev>, Catalin Marinas
	<catalin.marinas@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, Will Deacon
	<will@kernel.org>, Evgenii Stepanov <eugenis@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/9] kasan: sw_tags: Use arithmetic shift for shadow
 computation
Message-ID: <tuwambkzk6ca5mpni7ev5hvr47dkbk6ru3vikplx67hyvqj2sw@rugqv7vhikxb>
References: <20241022015913.3524425-1-samuel.holland@sifive.com>
 <20241022015913.3524425-2-samuel.holland@sifive.com>
 <CA+fCnZeBEe3VWm=VfYvG-f4eh2jAFP-p4Xn4SLEeFCGTudVuEw@mail.gmail.com>
 <e7t5yzfw3dq5stp5xjy5yclcx6ikne4vwz7d6w2ukfw2b7gr6t@oomoynf3b2jl>
 <zjuvfdbl7q76ahdxk3lrgaznk7vjj43f5ftzfgrnca6dqtcd5x@5qj24womzgyq>
 <CA+fCnZfySpeRy0FCFidLdUUeqp97eBdjAqQyYPpz1WxYwcsW9A@mail.gmail.com>
 <aqhm7lc57srsfuff3bceb3dcmsdyxksb7t6bgwbqi54ppevpoh@apolj3nteaz6>
 <CA+fCnZdjTkreTcoo+J8wMhwDuAFM4g33U5BFy0OPtE0UCvyJbQ@mail.gmail.com>
 <CA+fCnZcoVdfXVN8VBFLx835cV0eGAT6Ewror2whLW761JnHjNQ@mail.gmail.com>
 <sjownmnyf4ygi5rtbedan6oauzvyk2d7xcummo5rykiryrpcrt@kasomz5imkkm>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sjownmnyf4ygi5rtbedan6oauzvyk2d7xcummo5rykiryrpcrt@kasomz5imkkm>
X-ClientProxiedBy: DUZP191CA0030.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::19) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH7PR11MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: 211262af-5c3a-4f36-df49-08dd4cd07b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUtkTHFZSmJ4RmNaNi8zZ1l1QS9hT1BERGFiVlh4L3NXclVCTzJTZnpxaDZy?=
 =?utf-8?B?UW9SSnVVSUx0VU9RbnduUjhsU1RHem41b2hIRHMwbzJCRHJpbTdMVDVPODVU?=
 =?utf-8?B?dkM5bFA2RWxGRHoyTGd0MkVIWlpHOU9OSTZFMUZrZzU3ZzRZaWVvcXBObkVI?=
 =?utf-8?B?UmVKdWIvVG93RS9ZU1g1SGlyUnBpZWwwNVd4UHI4OXhqTFErME1XeCt4cW9N?=
 =?utf-8?B?VURxRVVKeHRrTDdoMU5sUUtUWUp0Um9xWDhRUS9pMEJZeEkyblZEUE1ITXZ2?=
 =?utf-8?B?N3EvNFBBTDZLOXBCZHlLQjVMM0JlSjFFaWY4dUtSeG5xREYvWmcyZE42WC94?=
 =?utf-8?B?QXZ0dTZnQTRHclRBenRHN0QrRlZuWEVYWjdjOUIvSjhpNFFHUGUyeEZ4dHV3?=
 =?utf-8?B?a3k2ZjhPTHE5c054TWpwbW4rcHhoYmxPMmRGTEJIekhudzlFK21lUHdtZm00?=
 =?utf-8?B?VGtUb1JyTHd0OUpJajdSWVhGY2toR003TlgvbTJxR09jRks5TFJUbDF2anVt?=
 =?utf-8?B?MXJ4SkdvNWw0VnVSN0RtSTdnanhGMXRyUFNHYkJaTEc1M2xnWVlYVnVRb0ZT?=
 =?utf-8?B?bzNlQWVqaTZ3V000MVlmMmg0NHMxZnE3Y3NDd0QxaHE5QkZrUk9lcmxET1Uw?=
 =?utf-8?B?SnFkQWFqSk9OOWVlakUrNVUwdVRDcFlwVHpwSXpySFdhZkE0ZkJNTFhtSkpk?=
 =?utf-8?B?Q3ZtMld5UWl2Wjduak02RHBHcGxVWGdlckx2WGlleDk4Vm81N24xOE9Wb2U3?=
 =?utf-8?B?a21YMzlQSU5OU29tbndBYmpXWkZCc1lkUmFpMStMTVBKMTFBZk1Md3c2SjI3?=
 =?utf-8?B?OEVUUjlwRWRHbFU2R1A2TCs4RHAxelgxTWNkNWJ0QzFVb3NmMWx1cyt5S2l0?=
 =?utf-8?B?a1FPdGNCMXpDRnFkNFMwZ2ozYlhhZFd2Nk5mVWdHWlRzeWFQTHZmNExMQmlR?=
 =?utf-8?B?bUF3UTRiYnhBK0FPMUQzTHlsdFovNS8zTlBRdk1WTVU2Z05TUmxjd3BiY016?=
 =?utf-8?B?V2IxQ2kyZU51cHpSZWVaVk9XTTRxL2drR25zL09vejNzdlpPcmhDRldGa0t5?=
 =?utf-8?B?bm01cS9yY21SbzZqMU82MXZVamNYTVJNbHFkekZpa0N3VEw4YkQ5RnRpakV5?=
 =?utf-8?B?L0FsSVpLUncvSGtzc0VRS1YwL2E2NC8ycm5kSW1VMTQvcStTQUx3R1VEa3lD?=
 =?utf-8?B?Yjdma0JBOGVNZE15eGorSU8weFdJT0RhM256ZXBNYlNRemxwVDRmWk9wWjNC?=
 =?utf-8?B?ZG03a0pHRU1oTTZWdWFmbVNrd0lFT1pGTUF4ODdnTnE4NVFra25HNTdWdTl6?=
 =?utf-8?B?YkhweXQvK201UzBqNHN5NHlNZWxDZDdLRHVrTkhzRDQxakczbXkrRmhsbFYw?=
 =?utf-8?B?M0J1NXdCNm8rMHJmQmxKYzBOeFBPTmlBUkRlQkthSXg4WFZSOUpXQlRKVkZ6?=
 =?utf-8?B?WjlUcVF5cHl4Ky9EWlVvWUlLRTN2YU94TGpKYnYzSUVmZHNGNFNUZ0o4YzVi?=
 =?utf-8?B?T0ltZzRmcjNIczhwZ3pMbFppbFlVWkloQ09NeXJBUmFEcGhGcnFtcDFnWkF0?=
 =?utf-8?B?OHQ0UHVXT0VHaXdSdVhiYjRPeGpzS280cWJ4elRINlhkWlptQ0FXcEZVMFA4?=
 =?utf-8?B?UXhXQVRNOTBZYm5vYVNzdmVaVnZwanVyMjgyZmJPeExDZVc3NlgwaTdqWlgr?=
 =?utf-8?B?ck9hZmhVdlZvRk1OT2tzc21EWjRXRUNHV3E5K3RDWTBpVEVsYzliVlpmQ0RN?=
 =?utf-8?B?dGdyZE8wbjc1ZE51bVZJMnJFT08xbUUvNlFiZS9sRy9oMm1XYVFFb1ZJMkpw?=
 =?utf-8?B?a3Jlb0ZjRW1DTTVGczBKM0FGMEljL2VlTWRMMFRtdE5rNVBHMXhRaHBpVHdL?=
 =?utf-8?Q?6wM9ivKo8lFdK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTNUOXZCLzY3dFUxbUw4eWxhMHFwNE9JWDFmdEVrcnVKamNzY0x5UXBYNjNN?=
 =?utf-8?B?VEZXVytVSk5JMHFZZC8vZHVNdE5ydGw2OXR4RzZkdTFQU0psdCtzb0IzTVRk?=
 =?utf-8?B?NFBqY01KK2xDdGttbi81OWplVUhLbW5DNHgvRmFOTG0xbGxmWGJLMlV0OE05?=
 =?utf-8?B?L0hteGlGYXlINXU1N24rMjdZNlVaNi91aGZ4ZmVFVk92SkU2YWRvUGlqSjFy?=
 =?utf-8?B?MGJiaEs4U1RvaGRpd09WNTVmTFpkSnkycGdIMktoeExGY2loQS93NTdrR3ds?=
 =?utf-8?B?cnE5Tzl1MXBEMlQvY01Ib0JsaHRUdnZ4UWZCYWZlMS80aEpHNnErTTdKMHg2?=
 =?utf-8?B?Umx0K3lIMWNGaWFlMElQNUR1eE4zeExKOWJJVXdHTU1wbEpTOUNUcDNjUDdE?=
 =?utf-8?B?bDZELzZQcGhSczVEK1Jwc1RNV2g1V2U3OTY3TkxRZDRmMXN3VGE2SU1jKzg5?=
 =?utf-8?B?YkFIRHNjbTZhYWt2NXFlY2hsSGJtY2cva3V1WEwwdjBNL1FjSGxPUVMyWDh3?=
 =?utf-8?B?SGkzVkVxQStUYkp4NEg0STFmNFN6bXBZMFQ4ME5tdFlsT0ZzVVlrU29CYkZx?=
 =?utf-8?B?VUFnNmZicklncEZqelVmb2R2VGp5YW9DRjhqbmhOcW5JMzc5b1ZTQXJVM2N2?=
 =?utf-8?B?ZFRxZVB2RGxtbWJQb3BmRmYrTmFsSmNZNUF4emQ0TXhJaWMzdUF0dUdhVXVV?=
 =?utf-8?B?NEtqeXVFQTZyUDZZdE9MaXEwZ01taGdTVmZleFVrYlhFWjhJOXpsbXpKSnYv?=
 =?utf-8?B?TWw2K3QyR1ZFbWFmZjM4RVlCTzVMbDZJajBvR3dzUFdhMzdGamFFdG5PbzV0?=
 =?utf-8?B?bDN0S3ppU0ZiNUNxN1BVbUxJYm5xVzVRWFZISFl6N01NRGkwdnNHa2lnSXBF?=
 =?utf-8?B?dHp5ZmtwZEpuSjEzTWljOXdkV2VvSi9nMGxpYmVvWVllWmF0Y3l1Rmp2MG9r?=
 =?utf-8?B?UkJCeERVaWNod2E1dDMrbk80MmFXVDJkWExTVGhxNU8zKzFHKzVWc0IrbHFu?=
 =?utf-8?B?OW91dVJDbElYVkpzWlFBZVMrcVczTUVIU25Xc2Z2Y0VnTGtBenFneXJCK1Nm?=
 =?utf-8?B?cHE0aGpabTJJVk9CVWlJY25YZTJDbm1SRU8yQi9kZ3FER3FlUnhLTGdGMUZS?=
 =?utf-8?B?d2l2ZzI5RCt4RXY2NFNzcFJIY3VRRHk5b0xLNkZ0eXZ5a3VIY1JpZ0xHdzI1?=
 =?utf-8?B?Z3RRRFBIK2J0YnFGbDZFdXpiUlJSa1NZYWhWdDFoVU5jVXB3QXhCWksrYzlB?=
 =?utf-8?B?Qm5oL1RzRlRSSUFpNkFKTGFqRm12RUkxaHhhR1RQdzIxT2FPT2NxYURnWEhH?=
 =?utf-8?B?eVJuTFNad0FlckhYald3SDdnMi9icThmMk5hbGlTa1FUM25kR0E1azFNS1Nr?=
 =?utf-8?B?Vy9oaTYyaE5PZDNwbmdaSzlmRFVQNlozOHZQbjMrWWxvazlKckYzTmxMeEIz?=
 =?utf-8?B?S2dvZ2MremRlZE15UEFyOXpJL3NtZWVseDVvSStuemY3SVpyNWhNV2drdVNR?=
 =?utf-8?B?ZnY5MXl0aXJxajVrL1dmaVoxaUtkcUxucmFrL1RSMXZpQ2YvWS8wYkF6VnJy?=
 =?utf-8?B?ek03c3lDSGxoUlgrdnFseDdNY1lSaFIwSTR1bWw2d0QzcndoY2EzazdjZTJB?=
 =?utf-8?B?RHVZVHdHMXNCWmxPMUliUE5GQmx1dVk3dk1vZ0wxbWw2ZE1XQ2hJY1krazVo?=
 =?utf-8?B?UXZhcTZRNjFVc1E5Wmt3ZHhrUC8vMFZoSFJtN1NGMEZaNDFYSE9ZNEVycWk3?=
 =?utf-8?B?bmMxdGxVZ0hpYmlhemNGQ1BZMEFaUTczN1ZNNEtvTkcvWnRkUWVQalFQNW9p?=
 =?utf-8?B?MkVFL3VaUXk4ajBhd3d4ZmtFRHVpeEZiV2NkTG1ta3d4Y1JodnViZnFxKzRQ?=
 =?utf-8?B?VE83ckNHdFdKenI0RVQxbHA0S1FBZWt2NldiaUpVWXRRazZmZVFWdEVGUzFp?=
 =?utf-8?B?ZC9rS0VlS0N6SDQvcHU2ZjQxWnVyREhhMXM4d0ZmbkhRU3pabm1Jbmt3Ymkv?=
 =?utf-8?B?ekRqN2J5SE9pT3FxbGhnR29qc3ZTQy9ZazJIUU5rZzdoN09JTEVqK1BUZkZR?=
 =?utf-8?B?dWtEbHk3RTFvMFdDcnE5cmZ6TDVzNk95VllYV3ZTYlFxS2QyTjhVZzlUV2lR?=
 =?utf-8?B?aSt4cTUrUFNJTUlvYUVqOG5pUkRWQVBlR3EzZ3pnbk9QMW5oaWJqWlcybi92?=
 =?utf-8?Q?v7nZzhZAiuFsj6oNogCNR8g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 211262af-5c3a-4f36-df49-08dd4cd07b9f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:20:46.9026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uFMNza4xilRO9sl7NlI0LeYjRq4A4DAjraaQwFjuRfoNcSlbAHQ1oPMXMYUve01Mta51GruqsUC1LZIoibZmsfB4pdcOrUBZzoLD685xRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6675
X-OriginatorOrg: intel.com

On 2025-02-13 at 17:20:22 +0100, Maciej Wieczor-Retman wrote:
>On 2025-02-13 at 02:28:08 +0100, Andrey Konovalov wrote:
>>On Thu, Feb 13, 2025 at 2:21 AM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>>>
>>> On Tue, Feb 11, 2025 at 7:07 PM Maciej Wieczor-Retman
>>> <maciej.wieczor-retman@intel.com> wrote:
>>> >
>>> > I did some experiments with multiple addresses passed through
>>> > kasan_mem_to_shadow(). And it seems like we can get almost any address out when
>>> > we consider any random bogus pointers.
>>> >
>>> > I used the KASAN_SHADOW_OFFSET from your example above. Userspace addresses seem
>>> > to map to the range [KASAN_SHADOW_OFFSET - 0xffff8fffffffffff]. Then going
>>> > through non-canonical addresses until 0x0007ffffffffffff we reach the end of
>>> > kernel LA and we loop around. Then the addresses seem to go from 0 until we
>>> > again start reaching the kernel space and then it maps into the proper shadow
>>> > memory.
>>> >
>>> > It gave me the same results when using the previous version of
>>> > kasan_mem_to_shadow() so I'm wondering whether I'm doing this experiment
>>> > incorrectly or if there aren't any addresses we can rule out here?
>>>
>>> By the definition of the shadow mapping, if we apply that mapping to
>>> the whole 64-bit address space, the result will only contain 1/8th
>>> (1/16th for SW/HW_TAGS) of that space.
>>>
>>> For example, with the current upstream value of KASAN_SHADOW_OFFSET on
>>> x86 and arm64, the value of the top 3 bits (4 for SW/HW_TAGS) of any
>>> shadow address are always the same: KASAN_SHADOW_OFFSET's value is
>>> such that the shadow address calculation never overflows. Addresses
>>> that have a different value for those top 3 bits are the once we can
>>> rule out.
>>
>>Eh, scratch that, the 3rd bit from the top changes, as
>>KASAN_SHADOW_OFFSET is not a that-well-aligned value, the overall size
>>of the mapping holds.
>>
>>> The KASAN_SHADOW_OFFSET value from my example does rely on the
>>> overflow (arguably, this makes things more confusing [1]). But still,
>>> the possible values of shadow addresses should only cover 1/16th of
>>> the address space.
>>>
>>> So whether the address belongs to that 1/8th (1/16th) of the address
>>> space is what we want to check in kasan_non_canonical_hook().
>>>
>
>Right, I somehow forgot that obviously the whole LA has to map to 1/16th of the
>address space and it shold stay contiguous.
>
>After rethinking how the mapping worked before and will work after making stuff
>signed I thought this patch could make use of the overflow?
>
>From what I noticed, all the Kconfig values for KASAN_SHADOW_OFFSET should make
>it so there will be overflow when inputing more and more positive addresses.
>
>So maybe we should first find what the most negative and most positive (signed)
>addresses map to in shadow memory address space. And then when looking for
>invalid values that aren't the product of kasan_mem_to_shadow() we should check
>
>	if (addr > kasan_mem_to_shadow(biggest_positive_address) &&
>	    addr < kasan_mem_to_shadow(smallest_negative_address))
>		return;
>
>Is this correct?

I suppose the original code in the patch does the same thing when you change the
|| into &&:

	if (addr < KASAN_SHADOW_OFFSET - max_shadow_size / 2 &&
	    addr >= KASAN_SHADOW_OFFSET + max_shadow_size / 2)
		return;

kasan_mem_to_shadow(0x7FFFFFFFFFFFFFFF) -> 0x07ff7fffffffffff
kasan_mem_to_shadow(0x8000000000000000) -> 0xf7ff800000000000

Also after thinking about this overflow and what maps where I rechecked the
kasan_shadow_to_mem() and addr_has_metadata() and they seem to return the values
I'd expect without making any changes there. Just mentioning this because I
recall you asked about it at the start of this thread.

-- 
Kind regards
Maciej Wieczór-Retman

