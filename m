Return-Path: <linux-kernel+bounces-325904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307AF975FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FA01C2282F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A74126C0F;
	Thu, 12 Sep 2024 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Suo0qF+R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D02524D7
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 03:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726111450; cv=fail; b=HD3BMT2cLkq3bXlAyTQ9BKPgJRKS+4quNn4RwBcRQcV6aSTvCM+eTX0jgVNjxxSo4DVsvMRxOoyU8kmf21TuSNTA0hYg+jjIYnIqz7BPWM7tHzpc348edF0JD5YPWALOAsm1IebUi2+5PMsFpf1NPopStVO3D2ADQSS2tn/DTQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726111450; c=relaxed/simple;
	bh=kDJFxlk3JW3z1TcnOzwY/DzglELrv7SHqc+JUo1r3H0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KRWf1oLja/OMpkJ0EiGxACu5IOb3uzrKg6Rfwo55ud5fdFKHbYrJWAfQoadqU2zXn1rqkMWALKcKF8aVxIo+jdfWZcXYhFnnhMmc8LgdqPbSvmhbMht5u8psa6Q8eK9haUYEYI7jvG2tMzIgfMtRQlmRdp6M5KJneiTsznd97Bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Suo0qF+R; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726111449; x=1757647449;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kDJFxlk3JW3z1TcnOzwY/DzglELrv7SHqc+JUo1r3H0=;
  b=Suo0qF+Ri2qkP4yKVhHdLelHVBrulDjJg7ItSbv2LJwha62B6Cv2TFZT
   WUAxSsE9MYpbgoYmmF0CM6s+ob6QBytrWgblsoRtj9P42yRLXVqZ+ERLk
   Mf3iX5gNIjii3Fb1lWeu4ZcxJQzAWFyp+Ynq0MMpQK2cXlP09mkfRq/Z7
   LIo2MqqYk9qqn+sUvRCgc/gY0Z2eI0k2RWoqOAOb+v9eQyCa6hyTKQ5M6
   AnUAS3w1vP0GuvPUMYsIU6tC5khWYDIpbVLe1nQODPRXo9OE6WRIMKNY3
   UX3CRepIS6zRfnxbi5X2bMCMCYwjqhtgCWeAu/WNI7Gyk/Lgj9kIXppQL
   A==;
X-CSE-ConnectionGUID: OsqWpT3mR9K11Oo9jBgzVg==
X-CSE-MsgGUID: QfXMqUGWTxCMRwDPDrt30Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24482739"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="24482739"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 20:24:08 -0700
X-CSE-ConnectionGUID: fTQz981FTZ+RS1QutSM2oQ==
X-CSE-MsgGUID: StZX54PqR4exi044kBwx5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="67809694"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2024 20:24:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 20:24:07 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 20:24:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 20:24:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 20:24:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYeeiitzcEajq3FHXirRrFtdLNCpXGbHHt2rSFjbYAoGc6htjS3cFSnlLGv7/56UY0OXiIgNid01BiUw53XZqkMP8WitSZ9YcQcQ/TopHgMGcggjEn13WFCRM8fCm0DulZoKapVifeJqBW4EnZUcC6tiAtqYcc2e28I50S8YQeEUvaGHwPts5PZFKJdwhTxt+MdNrfy+YqEhEAANdeOx66QZgMM76/Wvb+nhGRkRVqkgaqkr/ecMpJoISqFhl5pyhu9Rxryf85UXfpdC7jBUitlr4jpg7zobqSAzTxUKlueb3EJabSzMEtKbyTjek8+/qWIPMCjmwV9A97tjr4yXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHD/RSNwQ3AN0RgNR1rCTxlMq6BXBBfhE5YXIhQGZos=;
 b=xUcoho1d/mFlMqaN5KCm6zCuC2cpXzTz/DuGPfcQvXQIBKPnaREXfqfgZRO76g3gRNQbZx0sQMQ4hgj3stq8PFM9wPGlwtLLQd77eoXooIQys76wWj7XkFLLFIRnaYvcZmUT1G0iFPOc3DtJDAVsvzyx222Ocmnr9Jub1q5JYe8wFYbvyWWOo7+CHicvcHdh6DSwIBfvka3w4oSLyYDNFKo/lhOBbH6UaOJlzPAP9kB73aGHIBOmIhOTCW8rEIAJHknZSKC/KoOJAM/D887hIambHM9MnvYmsVcxHkQJu8sQsV/nq/Qt+xHrd+673fOmFdBxTNhXq22qiwoU6I44sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 DM4PR11MB7253.namprd11.prod.outlook.com (2603:10b6:8:10f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.21; Thu, 12 Sep 2024 03:23:56 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%4]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 03:23:55 +0000
Message-ID: <c7157fb7-b8d0-482b-9ec3-d60179a95882@intel.com>
Date: Wed, 11 Sep 2024 22:23:48 -0500
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
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <f92766c96c993276bec770e8a255bca6cc46c292.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::14) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|DM4PR11MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: fa8ae24e-5945-4e6f-8ffe-08dcd2da5547
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmllZ2dFckUxUzZSY3lUemlSNVVOZE5hekNCa0VlVXpNVnAyelBNVzNOVm9Q?=
 =?utf-8?B?WWhYZ0tRa2ZWbkpZRXMvd2VlK1g4VDJIcDZSTlUxTi9tS0luYVFsQmRJQVlx?=
 =?utf-8?B?SDA5ZXc2alJDbEtXZXhCeEdjem1LS2FFNFNyYThtWjdPR2syLzBIMU5Na3V0?=
 =?utf-8?B?a1IzQnRYbE8xY3U2SjNpZEw1MUgwR0pyZ1JFL1d4aDZLdTN3cHkxTzJrRUQw?=
 =?utf-8?B?aFFQS0Nnc3hXZVZNWGhXbEEvcW5IZ284NWlCTDlvalNNT2MrUFUxRGdYQzY0?=
 =?utf-8?B?cVRScGFHMW0zNFNWN28vOG5waUkwbkFWUmxmNTk1TkplVTREMjRpTUhJQVNB?=
 =?utf-8?B?ZWhyTjl2VHAxaGhmYm9wYk4vYkpMTjRmSnFxR3IxOVV6UmQ3eW5ENmp2NWRi?=
 =?utf-8?B?Y09SQzFuUVNwdFBPVXN5STI1dnJKU1hreEFhRmNRalo0eUNRdlNKdUlydDl1?=
 =?utf-8?B?RGJzenZBZ1I3QkhRVGh5TXI1MmtFcWFJd29kZERyVytJSFlwMytFQlc4YWM4?=
 =?utf-8?B?a0pCWG1yZEpLM3JINGxLT2lnTjlNcWFVeHEwcE0xQURCQjAyVUljNEc3dGV2?=
 =?utf-8?B?TU90UjUxdTNwUUQ3c1ZZRW9LWTJBa3BEd0tDanorR2NSZGZRbHhqeWVxRkRq?=
 =?utf-8?B?S2RZTnN1RDNGRElaejg2Nm4vN0pnOHJuQnk5QUdEeTVTNEpZNjhVY0tDVzlh?=
 =?utf-8?B?U0x6dVA5cEoyOXhydG9rU1krR25pSTlJTWZHVGZFTXdvTnp5R0F1bUhKNW1u?=
 =?utf-8?B?aUQvbXZFMGkwRkgyT0RzMldGbys2ZVorY2xscDVFVmFZSXY3VHkwY1lZOG1r?=
 =?utf-8?B?Q2tYWmo5UmZvMFd4SE1zRnB3b2ExdTBidjRtMldXbWtyUDNkOTFnS05xWkp4?=
 =?utf-8?B?MXBvUlF1YVkzTlUxdGk1TVhpVzFvb2NrUUNVdFBjaFBNYmJCb3AyMHczaDlO?=
 =?utf-8?B?T0k3VUFTMHluek5oSVM3NHk3WEU5VFRYSmlHallpWktJUWZBSWkwdTNPMll0?=
 =?utf-8?B?VnBscE1yclltb20yWi9VSUNzcGo2N1NnQlpQeWdjYWVTTTQrcUNjRDVOdngv?=
 =?utf-8?B?ZlZCV0xpaUt3NWdEcWp6V0xEd0EwNVdSQThmQnpHOU9sQmgxbnlNOUdlUzJF?=
 =?utf-8?B?YXV1UmNQSzR0R05iSllYT1dzenpzZWp0aFpQTVVmVXRxYmg2RmpWZDdydk94?=
 =?utf-8?B?VkV6SVFEaWJDUlQ1WUlLMm43ZnZiNkkzWjFEMkV5cUpvRjBYQzJ3VFR3RzFR?=
 =?utf-8?B?NmNHMjVsbjBpTktDZmdhbDRNK1JMYWNmTE5ZT09UK3dDTS9XcjFkcy9SUnZV?=
 =?utf-8?B?Rjg1b3FJYUlBMVVCTDJjUStjMm9oM1ZLbHdtL0dpK01IRldsZGljdHlFRUVQ?=
 =?utf-8?B?SnJGckxPZUZLOWVUcG42WE83OUJ1Rk8vUnV3V1VwbzU2a3IrbEl0YkhyMktJ?=
 =?utf-8?B?SUMzQndyRWJ0WFRwVVZPamh0UjVDK045dHpCK2o0bWh2VVVmVmYwVjlOWHUx?=
 =?utf-8?B?WUN2SWZJcDM5YlhyN2FSL1ZrTlZxak5UR3JocHY1YVFNOGVFUzNyUThEb0po?=
 =?utf-8?B?MnFzTXpST0pBTXZCbTF3M0tnSDdyRmJVcVI4VHlrYnpVMDlKMmUrMjl1dGJv?=
 =?utf-8?B?eEhqZS9xTE9waElvcWRXbE96ZkxpUDE0cUo3bFk5ZVRwK0o1UnVMTXVKREtG?=
 =?utf-8?B?bUYrMURORXdhS2llZERYcXgrdm1pTFBmVHNaMlF2RnRSNVFkd1RqQzJpMGhD?=
 =?utf-8?B?VmVHNlQ0QnpwVGVYV3dSbUE1MjFpUCtXVExYTTZEY3QyMDRSdi9BcFJQazdh?=
 =?utf-8?Q?9Dc6c42wL+Njy8iiUhj6LhLI3BbQn+Zo5lCUs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWNlNkd1Y2dTM2ZncGZXT1BPSHRFOHQ0NXIrdld6azAycUdpeTBDZGkyWUMr?=
 =?utf-8?B?ZjNxcGg2UjhpQzFUOUZDRC95NytzYmRUSFBLSkFnREVSOGZGZk5LV2oyS0do?=
 =?utf-8?B?clJheUdCckNqMkU3a3BXcTB1L1JnYWUyR21lQXg5QWlYd0RaM3pFUHNudGtq?=
 =?utf-8?B?dk5LclJMNC93bnpWeFV4MXkxZU9LRWdRenNtU1BFQXd6VERjV2wvVE50TGR3?=
 =?utf-8?B?eUhzQ0I4L1g2dzZvOS8wYVlyREhYa3o1WmRiNksrRnQ0dTlFTlV1cUhqbFdq?=
 =?utf-8?B?dWVURjJwZXFvTm1qeHRJWkpDelRIbU92MmpoVTNwWHpUeGg2cnlDK29ZMnla?=
 =?utf-8?B?dStHRGs5Y3hqaENIVTZ5UERBYTRaKy9maStSSGRCN3dkM1lJaE5BaG1BSkdk?=
 =?utf-8?B?dWVsZlJLem83ako5TkdrRUhHQkVqSTZrUnJSL0NKMlFIUFNFaGo2Y0dIOUpy?=
 =?utf-8?B?blowdndzRXo3VXVTQkZxdG9kTklpV1ZIZ1dQRHp5TXMzTU1YMlo3bHZodWdM?=
 =?utf-8?B?clo3OVlFKzBwQnYzZGF1THpGbDhJN2JDSmgvVlpPeTRMTmZYTFltUzhzL3Yr?=
 =?utf-8?B?K0p2YnFLeFFFWmd3QXBpcU4xajUwdXFjbzc1WXVGTEhiVjdqNzY5YitVeGM1?=
 =?utf-8?B?ZXpPbVp5WWtDaG9HeStSMHF0NXBEUWNyL1JtNTlFSWwzZDF1bjU5Qk5MQ2NE?=
 =?utf-8?B?ZVIrckhKZnJkMjd6dk4rSnhUT3RMV1EyMy82WU1CUTNtU1cxbzZ1OTUvMGYw?=
 =?utf-8?B?RG9wY0NmK3RTTnJVdmpmdXBXVW80ekdvOWJ0SW9kUGpCWXZWZUp6aVM0U2FI?=
 =?utf-8?B?eTRrSmRKVGJCTTRndk13MkxSNm5FWVE2Q3FiZ1BnQUtnQUFUMW8wczJoYUlI?=
 =?utf-8?B?M1g5VG5qM0ppK09sc1lxejVLZDVLZXAwdndqYkNoeFlTSnJsVHZzYUVuSzhn?=
 =?utf-8?B?ditiaHRJTTRjbzZEZ3QyRGNWTkVOWVRKQy9WeGZsUUpCUXBldTdQYkRiMnNW?=
 =?utf-8?B?Rm04QkxETUJNcFphQlY4bi9ZbXphc0kxV1JHWkJ4eUgybk5KYjhmYVRkVUFO?=
 =?utf-8?B?c0NjcWpNekZaeGNjTkRSQk1ZWTV3TTJncmoza2srWEdxdXRiS3FXbEdkU1k2?=
 =?utf-8?B?SnFmUnlQbzZHaUtRQTI5WktGdTB0NjR1RXZtRkFTYjdnRTBqempQbXhpVW81?=
 =?utf-8?B?MW5MVUIyWnRKOWdmU3d5b1pRY0MwV1psUnJTT01xWVRoMFlGY1dVMDQ5OS95?=
 =?utf-8?B?dzZkQ3B0WDhDQlQ0MndzVVQ1Y3c3bWRndWdqNmdmWUcyQ2t6ODhVeHAyRHZJ?=
 =?utf-8?B?UkM5RzdRK3JsWTdVQVZieU5Cdk56ZFR4TkExK2pCMmZZNjZFdFhNOTVTODll?=
 =?utf-8?B?UjhLcGs4UTQ3VUhmM1JUNUlpZUJES1I2VGdBdjJJRFR0anlUbmFhK2tCZFdE?=
 =?utf-8?B?SDh6eEp1Y3RpdU16WFhzai9sUGtPbFBTcldvNXgxdkdEbkVzMlhUNnBVWFZQ?=
 =?utf-8?B?bzkxR1ZuRzBGR3Z2QmVxalZ1VFlmUHdXZWVtbGsra09RN01BaFpUMHVpMGZY?=
 =?utf-8?B?Y0lydkF5SEN0bWJGTEtrUXFZS0tqUGY2dUt0d1F0dkZudGU5TGpmbG9OamRH?=
 =?utf-8?B?aEU1VGp0QWVybUlyT2wxcEc2blRqZVp0YVh5dHJtM2NaVXdVdmRYb1dnK0Nq?=
 =?utf-8?B?ZlFrN2VjU3IvaFpDRmEzY3N3dEMyRy9MNkF4a1N4cVltUzdsMk44YnYzdzNh?=
 =?utf-8?B?WktiQjB2TGpRdG1paXNmems2Sjl1YkJPQzRUSHlQc3B0Zld3MTdQSjJWRmJj?=
 =?utf-8?B?TWNMSFNlQWpOMFZ4ZjR5ZE9PMGt3TnRhU2cvV1hOcGVHM0tnTHE1VWxHNndz?=
 =?utf-8?B?MnBLNmJMQ01ySlJpMmt2Zy90L2ViSVZxck5CZC9lUmRSdjJ4Si9VYytzVzJo?=
 =?utf-8?B?OUZYNmh6QVlPMUM5SDFPSzNPR1BuNVU2TUF6ZTlKeDYrdUM5dTNZcGcrc1U4?=
 =?utf-8?B?V2MrcjAveDMyY1A1cE8ycExubnZrQ0podDNDVkd0ek5uclh1bGRMMW5HekJz?=
 =?utf-8?B?NHk5V1QwT3YydFFjb0JoMUlyU3FIamF4eGFpckpoMXpJMDc3UGNjN2wzd0Nh?=
 =?utf-8?Q?TMka7ouzYKtIXny6jKZTlbP9i?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8ae24e-5945-4e6f-8ffe-08dcd2da5547
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 03:23:55.7666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MW+3kp8QkD7aJmDMjcMoS1Fcbpv+emlfZoTHrnvukFTD5NTeoS04rkNbsXVDpLe2xf4fPM/UEy9h+mJ5p1aMwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7253
X-OriginatorOrg: intel.com

Hi James,

I would like to clarify that, even though the log format is incompatible 
with the existing TCG2 log format, nothing prevents TPM PCRs from being 
exposed through the TSM measurement framework.

Please note that the existing event types in the TCG2 log format are 
predominantly BIOS/firmware-oriented, which seldom makes sense for 
applications in OS runtime. Consequently, most application-specific 
events have to come under the EV_EVENT_TAG umbrella, which is 
essentially arbitrary binary data with no specific format. Thus, I don't 
see much value in continuing the TCG2 log into OS runtime IMHO.

The proposed log format aims to provide a framework for unambiguous 
hashing while allowing application-defined events. Its primary design 
objective is to enable application-agnostic kernel/verifier to 
hash/verify logs without understanding the event records, allowing 
application-specific appraisers to be built on top (i.e., 
semantics/storage separation). Both TCG2 and CEL formats rely on 
event/content type to dictate what part of event data to hash, making 
semantics/storage separation impossible. Therefore, this proposed log 
format cannot accommodate entries from TCG2 or CEL logs due to that 
design conflict. However, entries of this log can easily be encapsulated 
in TCG2 (as EV_ACTION entries) or CEL-JSON (a new content type string 
needs to be defined, like what systemd is doing today) logs.

-Cedric

On 9/11/2024 9:10 AM, James Bottomley wrote:
> On Wed, 2024-09-11 at 21:46 +0800, Qinkun Bao wrote:
>> On Wed, Sep 11, 2024 at 8:06 PM James Bottomley
>> <James.Bottomley@hansenpartnership.com> wrote:
>>>
>>> On Tue, 2024-09-10 at 23:01 -0500, Xing, Cedric wrote:
>>>> On 9/10/2024 12:09 PM, Jean-Philippe Brucker wrote:
>>>>> Hi Cedric,
>>>>>
>>>>> On Sat, Sep 07, 2024 at 11:56:18PM -0500, Cedric Xing wrote:
>>>>>> Patch 2 introduces event log support for RTMRs, addressing
>>>>>> the fact that the standalone values of RTMRs, which represent
>>>>>> the cumulative digests of sequential events, are not fully
>>>>>> informative on their own.
>>>>>
>>>>> Would each event_log include the events that firmware wrote
>>>>> before Linux?
>>>>
>>>> No. The log format proposed here is textual and incompatible with
>>>> TCG2 log format.
>>>>
>>>> The proposed log format is based on the CoCo event log -
>>>> https://github.com/confidential-containers/guest-components/issues/495
>>>> .
>>>
>>> Given that AMD is planning to use the SVSM-vTPM for post launch
>>> measurements, not supporting TPMs in any form would make this Intel
>>> only on x86 and thus not very "unified".  Microsoft also tends to
>>> do attestations partly via the vTPM in its L1 openHCL component
>>> (even for TDX) and thus would also have difficulty adopting this
>>> proposal.
>>>
>>
>> Hi James,
>>
>> I don't think the patch should be blocked for not supporting the
>> SVSM-vTPM and it is not an Intel only patch.
> 
> Actually, I'm not objecting to the patch not supporting the TPM, I'm
> objecting to design choices, like the log, that make it much harder to
> add TPM support later.  Realistically if you want a universal
> measurement ABI, it has to work for physical systems as well, which
> means TPM or DICE, since RTMR is a bit non-standard.
> 
>> 1. Not everyone prefers the SVSM-vTPM as it lacks the persistent
>> storage and does not comply with TCG's TPM specifications. TPM is not
>> just about the measurement.
> 
> I think you'll find an ephemeral TPM is TCG compliant: the NV is
> actually an additional profile in the TCG specifications.
> 
>> Sealing and unsealing data is also a critical functionality for TPM.
>> Treating thenSVSM-vTPM as a TPM misleads users and disrupts existing
>> software based on TPMs. The SVSM-vTPM is not TPM. Just like
>> Javascript is not Java.
> 
> I've already explained several times how sealing and unsealing can be
> done with an ephemeral TPM. I'm not going to get into prejudices about
> naming.
> 
>> 2. If our goal is to measure the boot chain and post-launch, the RTMR
>> is an effective and straightforward method. We already support RTMR
>> for TDX. For SNP, simulating the RTMRs in SVSM is very simple while
>> implementing the SVSM-vTPM needs a lot of changes.
> 
> in the upstream, the vTPM is already done.  There's no current pull
> request for RTMR emulation.
> 
>> The SVSM-vTPM significantly expands the TCB while offering limited
>> security value enhancements compared to the RTMR.
> 
> So would every other feature on the coconut roadmap.
> 
>> 3. RTMR as a technology has been adopted widely. It is not an Intel
>> only technology. The TDX CVMs on Google Cloud already support RTMRs.
>> The TDX CVMs [1] on Alibaba Cloud supports RTMR as well. In terms of
>> the attestation verifiers, the token from Intel ITA [2] and Microsoft
>> Attestation Service [3] indicate they support RTMRs. The Ubuntu image
>> [4] from Canonical enables RTMR by default.
> 
> So you think Intel should abandon its work on ephemeral vTPMs for TDX?
> 
> Regards,
> 
> James
>   
> 


