Return-Path: <linux-kernel+bounces-333662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF5997CC08
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45CE1F229E5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B791A073A;
	Thu, 19 Sep 2024 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWzgNdfh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E831A0723;
	Thu, 19 Sep 2024 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726762008; cv=fail; b=lvvLU2KvgLtmux8IgmrUmEBDGlGxYOLZ6uNil0vVDz/N7UxKii4qrM86W2BDiETbX+9772uHb2o/Aq56ICsgHO9rcGscGSeaCr/EdqvqvbvhIThvozUpO4OOLzSeN+tr5502k8OgJT4IL5zhZSIT6L5pQLCIDybIih/WDLzm0W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726762008; c=relaxed/simple;
	bh=k5BFEAreLMXxw2zNZvO1GEBuI70dczT0GLJm6qhNI5k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c/G+B+7M5ADYZWGwWTEzElL2HGIg7JymHXaDGujjz6AUNpm838byCMwahW1NPJgC3hb1jK1ehxlJliKPynMRgH+VoHVUlbuJ1abspTUD8FAkBY6uhDxcUShdHDCJ+g6Tt4U5aZ/ONs4qQkhx4vL+ZGD0ZXcySXCgxUgoe0I7X9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWzgNdfh; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726762006; x=1758298006;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k5BFEAreLMXxw2zNZvO1GEBuI70dczT0GLJm6qhNI5k=;
  b=WWzgNdfhq0kajP+dE7VXJCKpaQvUDZOwONsZfbPubQBByvH6UQB9Uyrt
   PXxZPoYG4j+B1bJwKrTfuoxouEeXa5gIoSucuq8Pc4O1HK2mOS4nM4WE8
   E6mVNBAHDK/3st+9b+gcY0+0I6nqiGWTCOcLhJJXBDK1Rl+dLKkbdjy4a
   O43RQaXngc0i78SEY0SnIQt+8dja3K03UGapMb8ng6Up73DC0Hlxi+YUs
   OPL1vAbmCD68Bx5zJ3oPIxqlFk7i4tfHeZdwC4qPSM7bt14jictjkwZfM
   pG7fxdHJFVi7EigFI87G6ziyxNDLkuMFl5KTiFmTt02QMjN+bo4nxXu8d
   w==;
X-CSE-ConnectionGUID: rEC1l3H7RS6tPFY77oPpHw==
X-CSE-MsgGUID: Daq5RxFZRXioYAJ0Ho9L/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25614176"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="25614176"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 09:03:40 -0700
X-CSE-ConnectionGUID: OcGg40CmQ86HO4/kPuBlPA==
X-CSE-MsgGUID: dC/ks8INQRq4bBuyQOC+Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="74765003"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 09:03:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 09:03:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 09:03:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 09:03:35 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 09:03:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxjD1XAa250Gz9w7uJ7EPS0GO0iPx7HQLYto2BsVk/IbT1Sp2NVGhO/fB8G5nsxbSry70VpavmaCgh20pd1CLp2Psasr3lDQfbxZYXhMhHB+iZAf9X6FnSU0rtvotIJG9nkUZu/udIxG5KFTq+bOpWWUndUIjFe0ypGO7Xjtu43kBX4j0JstGP3Jirb3TdlC5b9j+2KMpn8TfIQaZ5eqg3b413F1IBv6TVHWZKtpydkFHN0TG7WDjQDqN/fNxeHQimPMmhhoHiGpHFYsNXxCC9Ja4+H3OEIsumooGS+I13b6cUoeGCz4X17K9ni/OsvTw0dUX+ihcfVQN64qBTgGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ch8LwQSoxzIlyphxZnARK/3jvQ8DdkaWqNiiU7luymk=;
 b=WZdLCKMy8WUmVaqXvy95JRkt44tLQRlbzHgShoq2sRsQKcMHjfBSZpqrjhobA4SDzcLVqRYFvepg+A14vvrn9M7vvW31PXY9f1XBtBYcVKnh/w/xtPb7XdkCChDOInSQcGVV0SzjRcq4z8b6xb1iKwQQvZd+KTuDBkDyxhEFiMdeNZ1YrE/oE3hatYRv6qaM9yn7DfFMRLUPNdlJvj017JOKaw2YSQz0oK8xokp5LE3febJBSWaPrLc37wO0TVLqnmdajreWWHRT739SZPlP/TcS8TUFcSvRNJaCsnYNeXzS6oOnO08P/l0E7WE45m6h6jLthPmPQWVcEttXVOdG8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB5959.namprd11.prod.outlook.com (2603:10b6:510:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 16:03:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 16:03:29 +0000
Message-ID: <e644751a-6d10-4964-9761-9475fcc3560d@intel.com>
Date: Thu, 19 Sep 2024 09:03:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/24] x86/resctrl: Consolidate monitoring related data
 from rdt_resource
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <2f0543ef8c04e24b94fd10d9792533554954ae72.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <2f0543ef8c04e24b94fd10d9792533554954ae72.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:303:8f::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b489c1-dcdf-430d-ec56-08dcd8c49a4a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFVrTFZrelJUWXJtU2FIL0Q0eFdseHlidnppaUF2VkZmSzIyeFZvRmpJNENY?=
 =?utf-8?B?TFdiQ0RrYk5VdXhiOXRtakJSMmZxZVc4MUNzRGwwUUpZWkFhSUxoZ2JWV3Q1?=
 =?utf-8?B?SjFWK0lML3p6NWpvZnZ4d1hjdW04N2R2SHlLQzR3ZWFRSU9ETEhYa0x0ZnlV?=
 =?utf-8?B?ZndFcTludWVEM0FIaE90UXJSYUhXeVoxNGg2d3VmNnQ1SjA1ekxHRCtvVjZE?=
 =?utf-8?B?Y01QVTVFTjRKTjJKVzVaZHpQSk1UOHBScWVNWU1POTh1QlljL1pCOWJ1dU9s?=
 =?utf-8?B?WVJ2aERYaDJNaHNYU3AySTRaMEtMRlhNQ0Nhd0VMZ2lsSk1FSC93RTlSNERP?=
 =?utf-8?B?TGt6cXZOS09PbDFWM0UrMys4WXZINWUwdElZSU9zVG92UUZwdGJGMys2aTdt?=
 =?utf-8?B?Rk1RQWFobkc1aVkwOWVhYzU5L2ZuMmN3NUxDYWdWM3Qyd21XN25vMkNHQjNG?=
 =?utf-8?B?R1ZiQ1lVTUNaTTB4YUZmTENscGFmOWl3ZDJyRGN6VWthbGpNOWNoNFU3MGRs?=
 =?utf-8?B?STNNU2duYjRZYXFxU2gzaDNvanpiaU5tOWhDaXBLOUtlZEpxcEpFKzU2THcr?=
 =?utf-8?B?clAyV3dySG9scEFhOGh1YlY1cjJUeXYxQlYvSk51Tld4dkx6ZitMMHpkamxq?=
 =?utf-8?B?R3h4NTJ3eFBtc3dzWUR0bEJ2dkJSQ0dRcVYzM1Fldzl0b1Nib1psOHBXNlRW?=
 =?utf-8?B?OWIzNmEyOWFTZ0VJM0tMUnR3akxhS3UySkZmNXlMOTA1RG95U09sNVk3aXQ4?=
 =?utf-8?B?MUV3eHBJcVUvTDd5TVFJZlU1Tlp4b3FhdkdER0szcEd5a1YzUlZ3OXpWTEkr?=
 =?utf-8?B?S0o4L1p6TkpRT1RoSWtMQ254T0dpUmJHUjF4RXcrNGxKVFpvMHhwUmRiUWN1?=
 =?utf-8?B?TWhDSGYrQks5NkZWTVh0R2hHdFdOMTdaemtRQXJMeVB0ZWJaQzFSQnVVZHBE?=
 =?utf-8?B?M2ZSaEVSMG9XelUvOWFsVHVQNWlZZlVkZDJLYjJCZWlPWDJkZkNsakhOYWxJ?=
 =?utf-8?B?NmlVYjFwbHpwTHVOakJyYjdreEN4ZUNSbkNhTEhmcDdhbHJxSk13dG1sZ3N4?=
 =?utf-8?B?NkxFZEg4akR1Y2t6amU3aVpiTm93NmF2MzJxVExZQkk0SzFIcnZ3MXZmQUVv?=
 =?utf-8?B?MVZDeXVrVWphQ2RlUWt4VlVoSWZBVTVLVURLQTgyaGs3VTdTVkRqZ0piYmJk?=
 =?utf-8?B?YWM1K01mNTRzR2VmRDY5dFZTMno4WEhtOHplMkZBSHl0UUZiWG9oT3NrQ3Fi?=
 =?utf-8?B?ZE9jbjY0NDExVzN2NWVmT1NGOXF1K2w1amFnZjg1K1dVWGQzbCtaSDJ6Z1Qx?=
 =?utf-8?B?c01rZlRoUVR4SFAySGFNcWtLVDd4V3lKRk05clJrRW92QlYvanRoWklhSGxH?=
 =?utf-8?B?RXhZMmk0WmFWTzliSEZRcm1xK1FMTHE1STdrem91NmNzQnM3T04wcGJGVlVy?=
 =?utf-8?B?YzN2Y3F1V01kYTdTNmMzMGJ4ZVhTOXFGY0p1SmJsZlFaVHkzZnNtemlhUlcy?=
 =?utf-8?B?VW9zZ0pJWi9GR1NLMGVzZWVJZXlsMko5L0FaWTR6dnZxUVdjSlExbmJGTThp?=
 =?utf-8?B?eXc1enJzZlQzVlk4UGZPa0VSZ2ZVMC9vbmxWOVB5Yml1eERoUS8zVWdvdS9i?=
 =?utf-8?B?QVZLTDcyUEdqS2dsWHl2cGFvK00xWDg3M3Y4cGFmbFUzaXh3Y2xWS2oySFht?=
 =?utf-8?B?Y0lEZXpIYkU1TU14YVAxa2JqZWVzZkxyOFd2ekM2RU9yeTZPRDRhWkF6dVVB?=
 =?utf-8?B?Vy81SWRlMk9PcjJucytVRElWcGVLRkdTaVBjL00zVGxuejM4RW1rQU5OSzVs?=
 =?utf-8?B?VEU0bXYyRWhUNDJIdGpZdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1dwVC9LRFo5WllHZW00VUFvQkV1WDBuSXFNT0R4dDFQdTQ0a2FEWTRjK2Rz?=
 =?utf-8?B?N2w2dGxyREhlNTE2RDljdk15Y1NialhmL0pwai95M2NXZnVmRlV4WDdiN1Zm?=
 =?utf-8?B?Z1prb3BNZE1ybnl5ZTEzTHRsQ1BxVWRyMXcyZFFWVFFsaXF0RjlJQnZjejBH?=
 =?utf-8?B?RkhrKzVUNFVxVkRhL1cyd2x0a1VkaU5hS1ZsSEhieHVWZ1pxRzI3MlNGRmlH?=
 =?utf-8?B?MDNrQXNwQVMwd2pTSEdGOVIyVUpmTzFQMFZ2UzZ4V0crMlFEL1JNbjFaUmNx?=
 =?utf-8?B?NStoRHZhVE9OdHVqT1BZMG5sVThUOWZYanVkWnZtck1SNW5OU0UvRkhwUUVZ?=
 =?utf-8?B?STc5U1R2Y3VEdjFCWDRldHg1alJIdXFDblYrRHdWamJVblk0Z3QvZm5HdUgz?=
 =?utf-8?B?M1lEVlpaRXptYlR4WllMWURBQ1RSVUdQcDlpQ2tmM3JXdEo1ajRzOVdyTnVU?=
 =?utf-8?B?QWt1a3hTcWk4YWFhaVlkT2xoM3dpSVlIMytvb3VOQm5PS21qWXhaQks4cTk3?=
 =?utf-8?B?Nm02djAxY3RmL1dsSUY4SktGdEJUTmVhVG1hWUpaMUkyclJXazBUY0ZlMVZ3?=
 =?utf-8?B?VFFpaHFabFVzRmxOcWZxRTd0LzhpU3gwaUpmeHZVQy9rbUw0MXB6QzA3cVdH?=
 =?utf-8?B?ZGtmNVgxOHV3clpJVVZ1Rk1scWxuYXExR2tZQ2g1dFM1Qm9Bd2llWHcvdEs5?=
 =?utf-8?B?STMwUkgrZUplOGdoMEczbWRIMmprbXZJNkhRWjF6ZlJiOTJlcWd6ZmF0SElr?=
 =?utf-8?B?ZytzV0k1YVVnL2VxRC9WcHdEc2ZoNlhmV3JFOEttTUlQbjF1OWJnS05Pajc0?=
 =?utf-8?B?QjYwZ2I3NFY2bkMzOXAvb0xFV215cS9PRjZ0UWJBb3AzSGNFMDFnVFhiSWM5?=
 =?utf-8?B?QS9ZSkMrN0gxQVFHcmxCNWRpMjdxVkJZR2NxOW14VmxOREY5bU96QmtGMXRP?=
 =?utf-8?B?UUFBS0ZHeVJGQW0rZVQ4d21PTHQwQW5LQ09NdUtuTHc5SWdhNFN2ZHNub1Er?=
 =?utf-8?B?a2NQLzg0OElveWlzcXR1aFgySUxiUFFLRU9VRjdVcUU3ZVhBaUlBYnNoajBP?=
 =?utf-8?B?WHloZkxtbEU0NTc1anJlTldFVFBCNmhmWWpOQ0s1NlpkREluSzlkZE4yQU1i?=
 =?utf-8?B?RU85OGhkRzNZQUUyNlNvUlhJdkVwMnp5M2RoWEVYbnBUa0VQdTZJUDVyMWpT?=
 =?utf-8?B?cmlYK0l3SWpBR3BYcmdCNmVwUUd0NFJ0WEQ1NC9QM05BU0RVZzNzMkZqVXJK?=
 =?utf-8?B?TE5FaFFaaVJNNEJpSXZvZXlSS1c0ZlUrRCtHNzhQWFdoL3RQVjRiRzlXYlAv?=
 =?utf-8?B?K0pYc0h0NkErTU1Naks1REYrbWdqNkQwcXR6VS9MeVFPWmc2QjJsa0hyMEpq?=
 =?utf-8?B?SHpQa2MyQzRGaGROMTFLNHI0NzVVRzFUa1FYbFdzdGJGL2hmR29wSDFtZlBG?=
 =?utf-8?B?citQSlVXM3pkLzdXOFhUaEpvNjc4S3BEV2p1Z3BVT1MrSHB6VTRscGM4OW9N?=
 =?utf-8?B?VEZ6QmpTUEtrTjJRWVd5N01HU2JMSTNhQ1BHK3NYUGlteWt4MnRWVVYvU3o0?=
 =?utf-8?B?dWRUcWdaNTdMcTZvRFZ4U0FUR2pjdytDQVMxWElUcXZsbVNhUFpFdEJTQ2VW?=
 =?utf-8?B?Y2hVazJMOE11UDMzOGUzdDJ3V1VnZXM5Ky9taVB0a2lKUCtLUkZ5ankyQ0R2?=
 =?utf-8?B?RThWVXZKNmRJZGFSdXVOeEtzQjVxRVRJZGVsQmpOZlpRcTNTekt3d3dKRjF3?=
 =?utf-8?B?ZldxUFN6aGtzbHZPemVKeWhxcTlYUDRqWmJOS0xMeEpSNjUxZ1UvTUFCQlBm?=
 =?utf-8?B?MXJUdHRaTnN3cXlIRytRYzJNN1dhSlFmTzFtcEx4L21hdk8wdGhIejd6bjBq?=
 =?utf-8?B?SHFwdzdrakhlV0c3WVF6VnQvNE0yUG5BWml0VWZtSUtvN1NUVExkV09ZSlhC?=
 =?utf-8?B?SnRtWjdla2lVeER4YkxhaWFOalJ6bjVEUWxIVmFPWHhmWjJOcGR4dHFnamdZ?=
 =?utf-8?B?ejZoaWxZNkV4TWxWc1BRNHdLbTZoajl6WXB5RGx2UHo5RW1yUzVtUUhQVEVH?=
 =?utf-8?B?WHp4YzFsVTZXaEdXOTJyQm9XOWZWYmZoVit5MnB2S0FZNFNQaGVjN2VSQW42?=
 =?utf-8?B?SnMzY0g2MGJGRVlLc2xDenQ1LzZIUXh2QnZPWXlUNkNWQm9QK1hHY2FubGRS?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b489c1-dcdf-430d-ec56-08dcd8c49a4a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 16:03:29.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQnOFaWVkTeW4+Q1LpOBIM6hndboTJWL0i/vovW6Wi2GDEnzA2O9mrtPxHTi2JhTBwEVw9Ehn0Sa5uRZDKaCHfE90IeC8sDSwNXDDGanlJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5959
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> The cache allocation and memory bandwidth allocation feature properties
> are consolidated into struct resctrl_cache and struct resctrl_membw
> respectively.
> 
> In preparation for more monitoring properties that will clobber the
> existing resource struct more, re-organize the monitoring specific
> properties to also be in a separate structure.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette



