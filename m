Return-Path: <linux-kernel+bounces-522694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF45A3CD71
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5961E188F726
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA7225D550;
	Wed, 19 Feb 2025 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QPT13npC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5C41D7E30
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007498; cv=fail; b=mKBqCt+QyDwE7Lt/6KX80ZQKyBjB5e20jdVeYkpxyAGp15Yz+UZ82unrRjsGOW5n7mcu0OrioHRW0dB8Q9zYzP7uFpcTETJWuEaI8tNJTFwqrOOnuWo7aP4MHIAHKub9JXWO3YQwt5UcubEp/HoQ0K/zYzee9TBDiqvJSPNN72Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007498; c=relaxed/simple;
	bh=xxNw+MmRmKKBEwz/vyV3sR4QVdDIfK3J4uGJTQxs4L4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rvFBZzaePNWd4F5X8sDTUKEtb1KmEdw7+t8KjeXaoml2WXme3v2D1k+1d5o1Unz+I0fO8Jm5aQMCBNshtBIQvxL5QIY6GZM164nw2Umn0icGsmzwlpsVNKC8gD6+12OKjhD+TUO7XqHtlxBmncIZ8Ndj6cTwpn2lqqiNjPWm5SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QPT13npC; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740007496; x=1771543496;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xxNw+MmRmKKBEwz/vyV3sR4QVdDIfK3J4uGJTQxs4L4=;
  b=QPT13npCxsz4JVav+hHajEF6A+ZU+ANf+qLynj9yqD0vx/8uJBxQBGfu
   i/wkfP8xaDgYONozzusBsHRjJg4Ly+ShQLN25qcLrPasvieeENb0H3jSK
   RpKPOIY4H7OHV3Qeu3ADsfQY6CKfC6y0dkIh1J+eJc5ZkrPPl7uhONvMW
   wp3KFagEiHYgYXNEWJmg4EzazXaRLWYwVK6qz48T0McKF5LXb0LjVKltr
   a7L3vVvI8GkNdHKLtXLVhXox9szFGpwX2B+54Bqq2cUu04TM0nw1zIIzl
   K6py7Y5Ji9mW3wkvz4gebWJhOfDreYNxFSee7FfOm1zdo5YlvN3fzt1Dr
   A==;
X-CSE-ConnectionGUID: sCznxXxISi+i38Uzg36Tvg==
X-CSE-MsgGUID: OWo8++YrR5S4MZuSk+cpYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52201629"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52201629"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:24:14 -0800
X-CSE-ConnectionGUID: FAqoQW5nT3mGDAR2gVk5eg==
X-CSE-MsgGUID: SEA7U6RITF+8uSab0D6Gug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115768804"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 15:24:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 15:24:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 15:24:13 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 15:24:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2AwdcDQGuhEhDAw/NMXO+NkWfKK/gYEWaLunUY47ipgfycryG5iHSIG2CdRZDR/5J3ddLqLDRN2Ctr2IUqMEjw96MEQIs9N7oK7791znCpCBWihFmlhMJkjKS/TwnbghoBeBEMiH4kS3U0e6FYGtC9VpCrST50APjvyauV4Kf3F2FR6+RR0E7eazEQc85iI3eCo5TrWZTeu/KcwLPmKu23k1S3Q/h74e+keIogY1Zx5m88rZIM4qwWVGrR1uuY24++1QheZVnuwFjeUW9fVq5LCj64dwE9UnqsBMOx20pwio1uyI6Y8MaRQ3R7VFmU+L4UO6fgG3L666SSgc6dYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgs6JXOk0GnslGWPo5oWrK9vpXqHnyApsWHEo8T5dVo=;
 b=V8F8DCBllwQ7Y+4RyzL9YC59a5tz8KxGSaD65OZAbfeNnHongSqjwx8UrAhFffOTnvs19NR+QuAFd0Bx2OFF+/jNr7lWPCywxeMNq0yvdFii2qjl7KzGmnlEzo01sOYVc9eMs/9BE0KKTdrs83Vw9BioZglR558Nts+UoYSeYFI73x1GXNrWWhs9x1O0EqHUOVdOfkj/sHM/3kLJs3gvIpVwKNMm3KeqV3/biu8yyL1TaPmZtPQjrSC7T/KcXQBLC40tnQSBmcD7t41Lv+fiePNdGhDDZtWg5SpwuxnDSnUGCygKVEzY/KjcS9jmF7j7fKeuLluYLlW9DcGVtUbvzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4975.namprd11.prod.outlook.com (2603:10b6:a03:2d0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 23:24:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 23:24:08 +0000
Message-ID: <acdfa4ee-e293-49f3-8e53-900b9db63ddb@intel.com>
Date: Wed, 19 Feb 2025 15:24:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/42] x86/resctrl: Move rdt_find_domain() to be
 visible to arch and fs code
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
 Donthineni <sdonthineni@nvidia.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-13-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20250207181823.6378-13-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:303:b8::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a4548d-92d5-4ac0-3c38-08dd513c824a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDFKemQ0aFdTWnNHcS80QWhhQ2pVTmFPSWc3T3JHSGhqdEl0RUJLVnM5TW1U?=
 =?utf-8?B?ZHpzMkdzblA4elg0a2k2Y3hHMVZiUDR4cjR4V2xlYlN1NGxVeWRLRGZDTjc2?=
 =?utf-8?B?YUFtbXYyTkozaFVBanNDekVVWEVpV0w4WmM4c2RMbXJSZVhQbzBJbFhoNTNK?=
 =?utf-8?B?VHN4ZDJKZjZ4ZEIwQWVGQXdNQXFJWWhQUEM0QmZnRzc4dEM5OE5wQ1ZTMkZO?=
 =?utf-8?B?elZhWEl2akJIRmpTK1M4TmZiRmRXeTJ6RHRqWVh2WThCMlBpVnFZZS8xN05v?=
 =?utf-8?B?bWFENUYzTnBQR2hPZkdya3ZmWko1eEduNk56d1VLZEdxL1VLdFZkcTZlcTlG?=
 =?utf-8?B?SUpaQmEvR1FzQytGbGFJb0hVNlFBa05KUVNtTEZnQzZvYnJPME1zbGdmVzYv?=
 =?utf-8?B?dkZwUmNFbXJTQXprcHljdDdVb2JnZ20wRjY1S0JKOEFBUlpkZjQ4V09DcHJj?=
 =?utf-8?B?dXRDOFRESUltRUNTUUo1OWdSblpkSVJreUYzdGRSbHdIL2l5WXlwUE1MaDVO?=
 =?utf-8?B?YWh1aUdZckNsUVRHOXdndUwzeDBLRnliNGdyc3BZNjZQdlUxU0NRbEJRNGJH?=
 =?utf-8?B?RlMwS1VJYnA0bEtQMDJ6K2dUNjZSZG9HYm1KR0E5ZzhSOEQ3aHZuY1IwdGtO?=
 =?utf-8?B?UWRva3FuSjhxZ1RvUjJmK1NUUXdOYTZBNWJTTVFzMzIrVUhNbTBGSHJiaXV1?=
 =?utf-8?B?bVNMWGREeWZHaUdSak4zYnhOTnVFSUNJa20rRnplTUp0Uy81WUo5WFBNK1ZK?=
 =?utf-8?B?VG84WGdWamFXaVNiRnMyOC90ZE1keVhydXNQTk9HRmRCSDd0UGtEVEpldjVG?=
 =?utf-8?B?V0d6L0g3TS8xL1llU1hlOXV5dDYyenQyZGR3V3FVYUNlamxlbHc1VmdSMGVm?=
 =?utf-8?B?SmxONDZEZTlyWURSa1p2OWI0WkhsaDNBNDJRWEFDVzU3L094aExxajB6MnpV?=
 =?utf-8?B?UVR6aGNBWWdtT3hNYkRTd2kyQjNHLytnZGNGRFFlUnFhekN1YWNLRGZHbDk3?=
 =?utf-8?B?cTNXOGlNeU15VXFFazd2K3ljcFBWczh4SnVyRmE3Q1JZNHRZelk4R05OMzlD?=
 =?utf-8?B?NzdVWTREUHJsOXpPOWpJY09EZnJiV29UR0ZuQzRXVzY3Nk1FUGdiVldWcGRU?=
 =?utf-8?B?UXZwZGdFMGtBbk1PQlR5ZTJ5Z2ZZMjkxRVJobTBGTHZEbFFldldjRVkrVDNT?=
 =?utf-8?B?TW4zaEhvd25jUDlucm5wU1c0VXgwcDNnTStKU3JzQk5XcjZlWVRGZHNUU0FV?=
 =?utf-8?B?U09KdEdyZjluaTZiRXlmVjBFOUtKMjhid0dDY1hQZlp4dW1rQ3QrL1NVbXRE?=
 =?utf-8?B?OGlGWERiZkNvVGtEN0V5cm9EcXg3Z2xIZ3JURTlBelJaZUdFU1pXc2JaamE0?=
 =?utf-8?B?WHgwS1BrZy9pYUFHMTRIWEdmcFoxYTVHeTNnendRUWF1SkplbktUbHpsOW8r?=
 =?utf-8?B?U3R1RjNVNlRmVDRweHpHeFdFbWNiV2krQWtkOG1yOWVjWHF3d1lFTWpkd0pK?=
 =?utf-8?B?UTJiSjVEQitBaitwWUpFTjBQeXgzZU5rNFdPU0ZSSGRMN2hFdEVaWmhVM29X?=
 =?utf-8?B?L1UzUzc4a0U1SzRVSmFiSDV0Q1cydmxlQm10R0ZRSkJnNmwvdWhMVkY4ZXhG?=
 =?utf-8?B?emxlK1IyQWI3akVmT1krWXRaeVBlZ0F2Mk0xOG5BTFQ5SGQvUWhlU1ArSTlE?=
 =?utf-8?B?WS8wMW1tb2RWdEk2ZnRMWlpDakhLRVBBWEQvOUIxYllmYjVaU0tQNDV2MXQ0?=
 =?utf-8?B?MHUzcXNaRGUySGUzWGxzTld0MFVDTHpLeGxDWitRRUFhSHpLandlKzZmTE9W?=
 =?utf-8?B?c3VUVW56MHEzdXZMZjhZV0Z3ZGhxcFIvYzBHS0tWL082b29YbDRMOEZhOWlN?=
 =?utf-8?Q?ARooRgYhET7dX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG00RVFubCtFeGpBQml6MTNNVjkwdExWUGFUSnVhZ0NvYkp6MzRuNjFvQkZz?=
 =?utf-8?B?aStFUUVHaW5yNml0UGVYZStLeFZWSEQwbS9UcHg5ODRWUzdWaG8vTWtPTSts?=
 =?utf-8?B?d0dWMTBLMnF3dFUvR3ZESzJSdndFbUJmekNteHdhTmVSZllqQWNDYlRqRGJT?=
 =?utf-8?B?ZXFZaytXUXhlemw3UGkyNUdINDJpa01YTU5NTGpJV0JjLzFmejV4U3BDSEo0?=
 =?utf-8?B?ZElOdFpHaWkxbkdQbWxWRnYwWDhVNDdrR2ZucWZuYkF5V1ovWUJBSXFRNE9a?=
 =?utf-8?B?OGg2bTB6bTI2dXc4eGN3eVRibG1LVytiVzRodk80VW5HRlhOUjRMd09mQmJt?=
 =?utf-8?B?bkVzN244OUNLVkl6all6MXRrWWNYVS9BTGEzc1AxaTZhbkxhNHQxSFdlTXo0?=
 =?utf-8?B?T3NnelRJUDR3M3JwQlZyaWtzanFpeUozdU10T29DWldsVkVDNTErc1BSYk11?=
 =?utf-8?B?M1F4S1dMVFRlU256SEtHVnY3ckllVit3S3VHaitCSzRsUDRYV2lwOHhjMjRN?=
 =?utf-8?B?cVJIZVJWOXFkWDZySDBKQU8zTFZHb1BaWjdkNEd0YklVTSt4YzdCd3U4N09y?=
 =?utf-8?B?T3dEcjNIcUtKSWFuakZOOFQyNTBmNUZ2Vld3T1dBbENlbjZPQVd3V201WVF4?=
 =?utf-8?B?cHU2bHp1aTU4MGZuYUJvSCtIWjZYZk9INkJVWE9hbXptOW9NWVk2WDhncTlN?=
 =?utf-8?B?WUphOWFtU1lwRjVTb2Qxem9ZS2w0eDF5SDVvK2tKUjVvaFRRRUhOclJVSXRT?=
 =?utf-8?B?d21DdWt0UUtKcmNkT3NPUDFxZUx6cUkzTndBZzRHN3o3a0lNZkNlTVRjOG9u?=
 =?utf-8?B?anhVUm9Rc2ZBelVlUkRDYW1YbmNsVjcwN1UvSS8rSnpBMW16NkZ3OUpIcHBk?=
 =?utf-8?B?VjJaa1VlT0J6bHdaOTZkSUswMVc0MVRPYUdzVEROOHlXb0M2cXJheExzR1M4?=
 =?utf-8?B?NkR1cnF3NC92YmMvUEhUY2Fzdytub044RUhWYmtQbU9va0hONTBGRUpMSE1J?=
 =?utf-8?B?YTJmSHJiQlc1cVZaTkVVRlM2RStmQ09zUVRGUVA2TDdyaWwrbjFTZlpndUk1?=
 =?utf-8?B?Y3RyU3VmM2NHR2M5MllPMXBkZXJnVWdMeUc3bUJ2UGN0NFJiNnorQ25TQU1Z?=
 =?utf-8?B?UVRNOVVzRkNLVTFvWnczZUNLdVhqQkJYOUpMRVpHYTFsclRuK2E0M0RTUmJr?=
 =?utf-8?B?WDVQRUdpNEZxdEtYYzJvaDVJK2xSeCtyM3ZtT1M2U1RwZUd0SVN5UVZsbWJE?=
 =?utf-8?B?bmRtZkNDaVBrdWFwTHBobFRydi9oSytzdTl3RmlmSnZ0cWVSb2NPOE5oa3p6?=
 =?utf-8?B?TWppQlVnejJxQlFNWlROTkljQlN1Qmk0ejhDRUdlYnlZeFJISEo0d2RGZDdQ?=
 =?utf-8?B?TWg3NTlGRUVFanF5WkMzaWEzY0kyV3A1MFB3UExXeTRDeU5ibkYxUWY4Ym5B?=
 =?utf-8?B?ajNaVW1vN0RSeExXK1YySW4wUGl1UldnejNOM3Y4RjE1SlQ1VldzUVRIVUFF?=
 =?utf-8?B?UUNqdWFsSURBeEVjSmtEWEVydS9iMC9zV0hERW9EaEhiNVY3SXVYaDFkeFdi?=
 =?utf-8?B?NDZQZ0o2c2lMcWRjeVhaaytHVUFnSlJuQTZZZytNeDBGSytvbnhOYTNhdzZC?=
 =?utf-8?B?OHZtMm1wZ283bVlRYXhQOTQ1WmEyM2Y0MmpYd1lWekRoZjZvUkh6VnN0b2pE?=
 =?utf-8?B?blJEam80UUk1bXArWnYxRDRiZTdaUFhsanpzelVlTmJieEI4M2luOUYxWkhj?=
 =?utf-8?B?RnFIVXc5S2FYSURKVVJNOEhsZElkNSs4UnlveVp1dnlDMmZKeFFwY082bWt4?=
 =?utf-8?B?cFpnT013a1lZNFlobUdOWUtVYUlFbXZsMG9nQ2FwTDZWdWh0d2dtZTd4ZlZp?=
 =?utf-8?B?OVE4YVBiVi90djNkQUsyYXlYT25XY3NucDdYdGdWRFJBSXBGaDBPZW5vMFVi?=
 =?utf-8?B?Qjh3NFZUbTVpaEx4ekZXR1kvZnlreVhmUThIdnREZUJVR2F0anZoQ1VuR1VP?=
 =?utf-8?B?blhhR1dIeUt4N0pEcjRiNkNBZHFsYU4wWkV3ZVdoNEZ2aG1tT1VLOWRHMXBh?=
 =?utf-8?B?ZUx5bDd4Nno0ZVBETDlaQmhOcW1vNXdYbFNsODZwMTlWekN2Rmw1MjNmeTNX?=
 =?utf-8?B?M1ZiZTNFakN2RTZHNzcvaEc5ME1NQmUvNXF3ZnhhejhRMTFaZFRDMmFEMVFj?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a4548d-92d5-4ac0-3c38-08dd513c824a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 23:24:08.3475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2O08g+qnNW7rT3gvu3g2Us64fpEb22tfa9rgVjU/vvU/wCl5Aq2Eh1BRlIWxL3m3IHCuZWA/Rkd8k0YVMJP9AX7Kg5gJJm90Jii/UU2h7wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4975
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:17 AM, James Morse wrote:
> rdt_find_domain() finds a domain given a resource and a cache-id.
> This is used by both the architecture code and the filesystem code.
> 
> After the filesystem code moves to live in /fs/, this helper will no
> longer be visible.
> 
> Move it to the global header file. As its now globally visible, and
> has only a handful of callers, swap the 'rdt' for 'resctrl'.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> Changes since v5:
>  * This patch replaced one that split off the 'new entry to insert'
>    behaviour.
> ---

...

> @@ -395,36 +395,6 @@ void rdt_ctrl_update(void *arg)
>  	hw_res->msr_update(m);
>  }
>  
> -/*
> - * rdt_find_domain - Search for a domain id in a resource domain list.
> - *
> - * Search the domain list to find the domain id. If the domain id is
> - * found, return the domain. NULL otherwise.  If the domain id is not
> - * found (and NULL returned) then the first domain with id bigger than
> - * the input id can be returned to the caller via @pos.
> - */
> -struct rdt_domain_hdr *rdt_find_domain(struct list_head *h, int id,
> -				       struct list_head **pos)
> -{
> -	struct rdt_domain_hdr *d;
> -	struct list_head *l;
> -
> -	list_for_each(l, h) {
> -		d = list_entry(l, struct rdt_domain_hdr, list);
> -		/* When id is found, return its domain. */
> -		if (id == d->id)
> -			return d;
> -		/* Stop searching when finding id's position in sorted list. */
> -		if (id < d->id)
> -			break;
> -	}
> -
> -	if (pos)
> -		*pos = l;
> -
> -	return NULL;
> -}
> -
>  static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);

...

> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -372,6 +372,40 @@ static inline void resctrl_arch_rmid_read_context_check(void)
>  		might_sleep();
>  }
>  
> +/**
> + * resctrl_find_domain() - Search for a domain id in a resource domain list.
> + * @h:		The domain list to search.
> + * @id:		The domain id to search for.
> + * @pos:	A pointer to position in the list id should be inserted.
> + *
> + * Search the domain list to find the domain id. If the domain id is
> + * found, return the domain. NULL otherwise.  If the domain id is not
> + * found (and NULL returned) then the first domain with id bigger than
> + * the input id can be returned to the caller via @pos.
> + */
> +static inline struct rdt_domain_hdr *resctrl_find_domain(struct list_head *h,
> +							 int id,
> +							 struct list_head **pos)

Could you please provide a motivation for why this needs to be inline now?

> +{
> +	struct rdt_domain_hdr *d;
> +	struct list_head *l;
> +
> +	list_for_each(l, h) {
> +		d = list_entry(l, struct rdt_domain_hdr, list);
> +		/* When id is found, return its domain. */
> +		if (id == d->id)
> +			return d;
> +		/* Stop searching when finding id's position in sorted list. */
> +		if (id < d->id)
> +			break;
> +	}
> +
> +	if (pos)
> +		*pos = l;
> +
> +	return NULL;
> +}
> +
>  /**
>   * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
>   *			       and eventid.


Reinette

