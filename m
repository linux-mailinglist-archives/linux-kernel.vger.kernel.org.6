Return-Path: <linux-kernel+bounces-539748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0382A4A818
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C92A188AFD0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C515E35958;
	Sat,  1 Mar 2025 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+jXFLJE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F0F23C9
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 02:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740796102; cv=fail; b=nF5TNeUZTITdZtkfJSdM+L52P9+PgrLrDAwVvVK9x7+KAb1yvHHhftN6tmdpxYiiIQTeb7oWejYlGzU7M8IyftIR6pKwkFR+9CQGeY+iEFqWKCu5KHjzqgGqnTnY7kk/bTAoySZxAxhP+xMO26loPY00JO7TeIJx0oxrjr9hQzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740796102; c=relaxed/simple;
	bh=cpcQdTHrUjcn1awhhoWTx2TCnsLwaBXVoRSBgRMd8cQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gHCaXDgsA90arRAeETp7OVG7FXPZqmU9O8zV39al3SjsNhlde7T2eMibh9d6jdQ9072Bl+s8JgHelvk5iGS1fLVJHoFLpCTSJ9SM+x71gjdjeHg+zOWzdo2BlcgpxOCdpdX2c1QdfTAdBJFs4+Ubeh/yxBxk5miKNsgD35Q6jLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+jXFLJE; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740796100; x=1772332100;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cpcQdTHrUjcn1awhhoWTx2TCnsLwaBXVoRSBgRMd8cQ=;
  b=b+jXFLJEjitb+urbDX0bgYbBkzEGZqfL2gftX8qa0TGuMjwv3tquPZIe
   HGbAaI9GkdGhmBZVOYdGLW3cz0Y+QH7Wbp6JkeJoPN6bcvubz7RXpn6BK
   a8skHBBGb3i+8VO/+BkAYekra7PW7Ij/a5DBELTbjQmekfxIwKT471mxT
   qoRVs9AWJDEb4daHAuDKva7ywsaEcZek9cRtlm2/WneNWxrua0f1HlFmT
   YD51v1b1naB4BG9zrwpFqSaPB780S9hg0VI8Z180fNfOvlN968S1Wq6pa
   dK3lTJEDt5FFsWI9PT5eTlT7NOOz5bRiHrCVg47jPR3Z0fJ5LNbJGAtBc
   g==;
X-CSE-ConnectionGUID: SjJGrMfaQ32PEm0rKOVVgQ==
X-CSE-MsgGUID: +zNW5l9bRGmRPaaVC8Q/Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="40975805"
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="40975805"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 18:28:20 -0800
X-CSE-ConnectionGUID: jAuTEUuqS+25Ml4fXXAhdA==
X-CSE-MsgGUID: x6+HH+AcS6Wu9vydD+7nLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="122451646"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2025 18:28:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Feb 2025 18:28:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 18:28:18 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 18:28:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yz/H5EaStrzXatnUD8RBN8u6rTRvrokVI1JtGAdsLoNVHFTvNJBjPHM4Pe5MUprnhCRNCobe4n7sRd9vedmT9QJic6DlQy9D/4jezBJBD6HQzCLhXeGCjImbuaewn13aRmXyPTkDxnwvPBjzNYYdUrVV8lS0kG3eSLUp2IXnx233WU2+vViDBjAn0jRiBRjLXQ3vR1gHMsrXRtoXI8PpUegeG8IDqMOpqgWwx31QZZhRR3GtzLa2vYqUrS8rcNTWuOxc07Vuupk97ciqIjZ+BKyIFhZcqSG3o0XKayxnpE6fPLJ8YdRYliBlY01f5+4n1+nT/v3Jm6D/QbI2oDNx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE440zZgpLN5OJAzeMx3Ma3HbOeq/NveGYEed7qdRf0=;
 b=XBRMdsDeBJor84fI0Fdw+7jLwcdrlu0S3rETNa288ZDN8VfWottEUW6XdLzCArZSCsB0xd4QdpVe6RCwubFmTVafVeQYtAkNQVWFNeFQFcIcnMaMn+cO0QIWLBnef8BtqvmrJPzfyNLtQnFnd3KAi1gLn3M/6hnwQx8l5dxvbnVPFZoAQqSOOs997VZpPvZ9TqRjATWpsneIoQjuHuegcp2FxUre0ORmR4pSbUWnGm9l+dFhgtmV2UwCKZlRI/9seJOdMYdRYgyEHNgzIdCn5z82/7cD3bxLoi59VMvzaYTDKmV1G2K0HC5AsflQqU1UzM+04P+O7F4ghEaJ+ynNXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4847.namprd11.prod.outlook.com (2603:10b6:a03:2d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sat, 1 Mar
 2025 02:28:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8489.025; Sat, 1 Mar 2025
 02:28:14 +0000
Message-ID: <ce60836d-d482-45c7-842b-d7e28e9bf794@intel.com>
Date: Fri, 28 Feb 2025 18:28:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 29/42] x86/resctrl: Move get_config_index() to a header
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-30-james.morse@arm.com>
 <3749ab92-6f6e-43b4-8147-22775e31d21b@intel.com>
 <44cf4fb5-fa3f-42bc-ba16-46645495d669@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <44cf4fb5-fa3f-42bc-ba16-46645495d669@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:303:dd::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4847:EE_
X-MS-Office365-Filtering-Correlation-Id: eecb34c1-39f2-4d72-e203-08dd5868b80e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDY1UW95dGo2bHh4MnNnalA1ZkNETi9JSE1iRGdEQVFRTEZEbUdvZVNqMEtp?=
 =?utf-8?B?TWlZMU54WVVhSW95QzE3VWo2YnhtVTMwK1pQYjNscHJkbmpNazg0akNBOEVy?=
 =?utf-8?B?cEVocHJZc2F4UFIvT1N2bmJBQzA0cVdwYTRiT3VrRjYvcEVmTEF5N0g4R2RD?=
 =?utf-8?B?OGxnNURIOStiTUJ6YTAxUU9rdzAvZkFMWWdmZW03SUhNZytJSk1kcEdndVZ4?=
 =?utf-8?B?S0xtSENsVWQ3VFhVc0dZUXJmdUhlQVJITDB5eDhWL0pheG5ISUZ0RjhidE1F?=
 =?utf-8?B?Q0Jta2lWeTBPUE5JRUZYNXRHRnVNTlFKU2tSVGswRUdjeUpsSWJFcHd4dFZw?=
 =?utf-8?B?UWNMT3d6YmpYYjAybDFvdFJPd1NINkh5RjMvQm1KMXpLRFBBZDllZy8rTjNM?=
 =?utf-8?B?QnloaUR6N0JDR1pIT2RZZDd6enlZaDlVdHg5TGJBc0RmYmtta2h1WTlNTU1q?=
 =?utf-8?B?UzJzb25FcE1Wc2w0SjZ5alFmbDhIVWk3SjYwZ01rZG5SK1JTMFhxQy9KMEhM?=
 =?utf-8?B?QTUyajZoMkx4RGZNZ1o5S2EvNklZOHVFbWpqZURiY0xKUzVQMTlJa1Fvczdw?=
 =?utf-8?B?cmZKZC94czdnOUVNaGQ1LzZ3SWYwWi9JK2JlTFhlNG1LVVcyZnFLWmJZTHRI?=
 =?utf-8?B?bHVOMWJhdnYzaWl4enJpcS9pUDg5dlE0WUgyR3VCRWNLVzZpMU5DUGRrZlpx?=
 =?utf-8?B?SmVsd2VhN0g3RUVIMTJpK2dwSm8vZXczMnh0WTlSQStSZjdyTVBnMTZmek9x?=
 =?utf-8?B?aUlPVlZLZUN4NHh4OGlWZ1J5YlI2elY4S25INCtqc05XVllCbU5ZNjU2V1RY?=
 =?utf-8?B?NDlYdVNYZlJTZzdyWjd2VHF5VFZ4Y2w3eXo1eWFodGUxWWhhVUVhaDlwZFB1?=
 =?utf-8?B?dUFnWm82RWpjU2kxbHZFMmdlOXNaOWNpaEtRWENGcm9MdWIxWmRUbzFRQW03?=
 =?utf-8?B?OWRzOGhuTGNkcTZrQ0wrZFU1ZVlHVzZFOFdkb2kzWjYvdVFLTWp0cUg3QlUr?=
 =?utf-8?B?RVArMTJSSzhNcDlnUEdJRWtqek0wbFN5RzBURmhhd1N1ZXdvQ09RRkV3Z0VF?=
 =?utf-8?B?ZFNUbXRFOHNKTVNBays2dzdtOHdVSlc3c2ovWFpWYzBLZlJCSTNHcWh2ekk3?=
 =?utf-8?B?YUR6ODltbW1CNFE5dk9yenE3STFJa0NPcWVhL1AwczQ3bFp2SVlnYTVwaTdw?=
 =?utf-8?B?M0hsRWg4USs3aytIR3FOVkYxdWkybjVHSk1qK0FPS1JoakkxOUMrdThKSUdn?=
 =?utf-8?B?Z3VrbmpnbU9JYlpyMkYzU1RGelBTc2RXbndQOXRTQXJjWUhOd1gyWllNOHFy?=
 =?utf-8?B?VVVhSGpZZTNrSkRuaGJBcEExWSt5NStjdTlPTW1SR3RpOFNBYzlCdXM1TWs0?=
 =?utf-8?B?Rmh3TE1MNHlNRXQyS3ZPNGtFbzdoYXhYMGFWckdlN0cwamszejRSdGpDaWFU?=
 =?utf-8?B?eEh5eDYxWTBhYkFia2FzSmFFZ0I1RmdvSk9QZXE1REJUTjlDRU1hK3JXbWVu?=
 =?utf-8?B?dHQ1UUNWVzFYT0NKRmxQTG5MNGFjcXV3TUpUQzBSU0xhbjU1dVdCVlRxOGhV?=
 =?utf-8?B?UGRnNzJ2aGN3VmRHUG9wVUZ0UW9iNzlRK1BRcjFxR01sL1ZwWGEySkNiRnVO?=
 =?utf-8?B?aXFHQ0NPUks3WStSc2xZZVdmUklhUFBFbGxZeElvOGNBTk5CdjNEdXdncTlO?=
 =?utf-8?B?MzBhTm9Nc1YyQkowanNwR2krekN0UXEwSzE2VFkrSU0yemxwNjIzaDIxeGoy?=
 =?utf-8?B?cmhleFRqU3c4eHI0UldxQ3F3ZEYrZlhKUXB4d0I0MjVBN3MxZ0pZUDh5dnFq?=
 =?utf-8?B?bGlQR3JxbDByU0IzSGgxUDlQQUJBZVZCWVFZMU9tWktwSFZKQjFrTUFRYmp1?=
 =?utf-8?Q?la3lI7YLmt27C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTBCUUprdHVSaXFNMkw1RzFTeGZDNE1EcTM2WmwvR0FpZVJIbmZIRGJweHhK?=
 =?utf-8?B?ZzRSMG9vbTVQNmNZYjZ0MDRVMDB2cDVXb0NyNmVrVkM5Z0NJUklTQTNYVTYy?=
 =?utf-8?B?OU9FVDlrN1MrZ2RLQUNSbEZqVzBnTkc2VDN0WVRSbWVWdGVDL2x4SVU3TlNT?=
 =?utf-8?B?QzBUb2owblBzdU5TZGhzTXJBY28zcXBOaXNwd1FQVmFzME9pM2x3K2RiRmVj?=
 =?utf-8?B?dStKd093NHRwcG9SYnQxemYyUFZpZWdWMmZWT2pnb1hwOERYNEZwOGdlTEJB?=
 =?utf-8?B?OFRiY1NIeWtVQ25Ya2Nham04eDdmZmJhSWVGc0RGc1pHRS9HcXVJL1BBODdZ?=
 =?utf-8?B?OTlHZWJvTm1QcDFLUjNVMUVJZXUxdFlxaklMbk9LV200aWVSNE1oSnM2VFhy?=
 =?utf-8?B?bEIwdnQyUEFaMFNXVVpabFV4bUR6SFl2ZFo5a0NMS3M0aHpjUmp5TFdOUXRG?=
 =?utf-8?B?ZTlKR0NHVGNlOTJtUXFaZTNqNkVGVE84QldjZnQyUHF0ajdtemQxdlVvMnpV?=
 =?utf-8?B?ekFXS3FjZVZ0dXo3VkdvRTZmY3l2QWlxdVlxSlo5OUZ0TWNTKzlmZWhJOEo5?=
 =?utf-8?B?LzNUaFBBUFV2OXdYNVlubXhndWFSNnVKM3J5TWxacnZxS2dldDBGWENxdWxx?=
 =?utf-8?B?SkZXUWtMVHBNVjRFSERKSnZVOUFZdXpVaEdrTVpPejlJd0s4dVV6WVQ2L1Yr?=
 =?utf-8?B?eW0yQkxWeis1a093dGI5clZ3ZmwzTkxUeTk2bER6cGxxaWp0TDB6ZEZtYUJC?=
 =?utf-8?B?R3RUUEhheEtMYXRhMUQ2cUxqenNaYzY0Q01ZUWdpSFVhTXR1RzVhT0V1NEFj?=
 =?utf-8?B?bm5oaFpHbW1oWk1PK0UvMVZQTGFKbXlFQnRZTkYwNDBlNG1OYW9NajRXVTZC?=
 =?utf-8?B?aEgyTWd5Z3FwdXd1Mkszb1RiaGhRT0pxVlVjekk3akhPQndSNjNYQkZ0bVB4?=
 =?utf-8?B?blF0YU1LZzlUQ0R4N2VvS3RmZ1JhRjgyam5CNHhqL0hvTkNjN0NIVXFvQlRw?=
 =?utf-8?B?dmI4MlNZdGpQS0pNSklYZUdtazFLbzVhOW1nWnZqSVFyTjFlTE45ZFdMVndW?=
 =?utf-8?B?eDgxRHlIeklwWC9yckhqYzFlM0NwUG9PUHBWNmd4Mmc1MHFva1ZycHdYWFJO?=
 =?utf-8?B?K2VCQWxRYUduVmY2WnBKeklMdTBUNWxwNFBNQTNDZXBmK016ZC9JRFFxaVg5?=
 =?utf-8?B?VkRkT21Ga0ZqSVJkM0R5VTFZTHdpMjFjTi8vNUEwbWdvVkpxSDJENlh0aGRZ?=
 =?utf-8?B?MmlaellHRHF1R3pwUUFLSk00S3NwVXI0OW4rUXZlQTYyVUVhSWJSa2pKQk00?=
 =?utf-8?B?MUIzb0tIRHgxc1M3UUg5eXkzRks0MWNxQlVoMitqNXNIZXV0OWxPa09aMGpS?=
 =?utf-8?B?K2NOeW9TZTZvTkE2OG5pYkE5OFFTME1ON28vMktPYVhxUzJldjhOdHBmakor?=
 =?utf-8?B?QlJCNGhSTUlOaENTVXZ5cUlVdXdPNFpncUdEWXU4eUdqNGxiZlpBaXZIRjVY?=
 =?utf-8?B?Z0k5YmVqWVB5c2t2OVVzSzh2YzloTmRORTZRZDI1ME83RzF6NUZKNnNRdDlG?=
 =?utf-8?B?TnJTMitFRTVOcjR4R2t2L28zV0dsK0FYa1NlU2xPS3JmQkhOMTA0MnZiTzJ1?=
 =?utf-8?B?MnlwS0c4UmdZNjNpOWhoQXFYRG4xblZDdE1ibFZQZ3V0Mkt2UG4xUDlEcVVZ?=
 =?utf-8?B?YmNtdGcvMmtxdGFKTnRSeXJCNXM4UDJ1ZHl5NEJPMWFEUVdjQytkV3BPcXZE?=
 =?utf-8?B?ZUNCNE5GNUhPelFKdERsWk56WjlzTE15Y2Q1TlZ2bEpBS2plc0RjdmVuTm8z?=
 =?utf-8?B?cEVuQ21XV3h2T3FPVHpDYXVLSHBJdzRXYUUrZHlzL1dWWDdXL1c2OWYzTW9t?=
 =?utf-8?B?YjhXMmxPcU9qMmFIa0swSFAvZWhyNy9KTkIrb1RFWm95N3dIcENKdXk1TFBv?=
 =?utf-8?B?YUEwWFNDNUlXK1dFYlhxYVgxR1MxdHdCcElmbW1za3k5VjIraUpYRWlEcTE5?=
 =?utf-8?B?YkozbXhHc1RadlRqN2ROTFA2WkZMSEg4WWtHb2E1VDZJREdjN2tDM0xaREZD?=
 =?utf-8?B?R051UHpWS0JSbUVVMENsOGlNZHhLZVc1cHBxQXk5Wjh1b0lhekdHVmFHTkJy?=
 =?utf-8?B?czArWXgva1Q4S0doVHdGOFVVSnBjRW5aSk9TZEpsMnlMelBqLyt5RmN2N1Rv?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eecb34c1-39f2-4d72-e203-08dd5868b80e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 02:28:14.5656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cX6nYgd+P1H5S3xjYe1Ah4yMCqr+Fr65Dh7sK8ktnsDGqHlAEpoifmdrcG0kNGgvStjySXZSLoklKT4JXu+LtMJ3LAy1ZaEKpH2f80e1lII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4847
X-OriginatorOrg: intel.com

Hi James,

On 2/28/25 11:51 AM, James Morse wrote:
> Hi Reinette,
> 
> On 20/02/2025 01:27, Reinette Chatre wrote:
>> On 2/7/25 10:18 AM, James Morse wrote:
>>> get_config_index() is used by the architecture specific code to map a
>>> CLOSID+type pair to an index in the configuration arrays.
>>>
>>> MPAM needs to do this too to preserve the ABI to user-space, there is
>>> no reason to do it differently.
>>>
>>> Move the helper to a header file.
> 
>>> --- a/include/linux/resctrl.h
>>> +++ b/include/linux/resctrl.h
>>> @@ -384,6 +384,21 @@ void resctrl_arch_mon_event_config_write(void *config_info);
>>>   */
>>>  void resctrl_arch_mon_event_config_read(void *config_info);
>>>  
>>> +/* For use by arch code to remap resctrl's smaller CDP CLOSID range */
>>> +static inline u32 resctrl_get_config_index(u32 closid,
>>> +					   enum resctrl_conf_type type)
>>> +{
>>> +	switch (type) {
>>> +	default:
>>> +	case CDP_NONE:
>>> +		return closid;
>>> +	case CDP_CODE:
>>> +		return closid * 2 + 1;
>>> +	case CDP_DATA:
>>> +		return closid * 2;
>>> +	}
>>> +}
>>> +
> 
>> Could you please add the motivation for the use of an inline function?
> 
> Putting this in the header file means it isn't duplicated, so its behaviour can't become

I am not following this. How would making this part of a .c file of fs/resctrl with just
the prototype in include/linux/resctrl.h result in this function being duplicated?

> different. If its in a header file, it has to be marked inline otherwise every C file that
> includes it gets a copy that probably isn't used, and upsets the linker.
> 
> Calling from the arch code into the filesystem prevents the arch code from being
> standalone. This is a useful direction of travel because it allows fs/resctrl to one
> day become a module

Don't we have this already with all the needed CPU and domain management (
resctrl_online_ctrl_domain(), resctrl_online_mon_domain(), resctrl_online_cpu(),
resctrl_offline_cpu(), etc.)?

> 
> Today, the compiler is choosing to inline this:
> | x86_64-linux-objdump -d ctrlmondata.o | grep resctrl_get_config_index | wc -l
> | 0
> 
> This kind of arithmetic for an array lookup is the kind of thing its good to give the
> compiler full visibility of as its good fodder for constant folding.
> 
> For so few call sites, I don't think this is really worth thinking about.
> Forcing this call out of line makes the kernel text bigger, but only by 32 bytes.
> 
> 
> I've expanded the last paragraph of the commit message to read:
> | Move the helper to a header file to allow all architectures that either
> | use or emulate CDP to use the same pattern of CLOSID values. Moving
> | this to a header file means it must be marked inline, which matches
> | the existing compiler choice for this static function.
> 
> 

Reinette

