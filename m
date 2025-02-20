Return-Path: <linux-kernel+bounces-522766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7C1A3CE4C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED551895E81
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E9E7080C;
	Thu, 20 Feb 2025 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mnm0jHPq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00158D2FB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013011; cv=fail; b=mlnfZ1GWUB7BfWXGxPmOXnktcLTNGBhylRIKwBwmEJznRy+VEdQLDlpOWBdC3zHok4oWchRsdro9d5W8UMGdjqVT4azHriBb7eZgNNedGsEyWzJ3HDERtp7wHH0qOTPymJSXgcnGv4vMw8G0ab73Kiho9TcpRonjmK7bXhWkgYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013011; c=relaxed/simple;
	bh=e91y9T5LGFHjZXuTtNjB43AWOCxYl4KLt3HWr65+aRo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BHTWzh/wxPNkh95yOPWb4KKo3s1ZDP8Ya9Sk3yRN6OYCvN1uMde6WjVOzrQcTpY14/pzQWXbmVK+t/23gM0965owmS4wBjr41Oeib7J3YQKHgDe4RwiS6vEn/D27l3Fv0gqFJ7P6yBGWPA5FmyOFLVsqDCh9v6lNZJdaxXfWtWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mnm0jHPq; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740013010; x=1771549010;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e91y9T5LGFHjZXuTtNjB43AWOCxYl4KLt3HWr65+aRo=;
  b=mnm0jHPqv6mzYWyyoFLuYelT08kHHD4COCfEKN3HKwul3/kD41Yo8dbr
   bJ94rE69XuVUNn1GJ6ZD/4UxGhCwgNPRjP4VeZLeivAg6uXAWn84yI58g
   9fuMgMdle/2Rusf/piUY+ymkYhF0GSKQKk+F7dLwTDWsyWKD+cWV6/1QP
   g18yrETLpzBBHJ2eQbjOa9siiJ66JhmlPaF+h5KdcYGFvVEqsQeChXt/q
   OG6mUHh6DObLX8/DO9tOeBBpkU0LpDH81bnfqQnOY9LsjBoPJ/k9fXmTv
   B0S8TH0MUqqx4p3yztYn2+c0Zl+hglw9oAqGwxFLmKHFrCGN7iV6wNaCK
   Q==;
X-CSE-ConnectionGUID: FAB11Xu9T1yIjJgZL0ayoA==
X-CSE-MsgGUID: Nugrqhi1QcyedW6/RuNcXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40699223"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="40699223"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 16:56:49 -0800
X-CSE-ConnectionGUID: ldtukeByTc+Ezpq3lOL8eg==
X-CSE-MsgGUID: G/kHHyx9S8uht7rT3rb8+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="145768784"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 16:56:48 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 19 Feb 2025 16:56:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 16:56:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 16:56:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jY3biY92E9fvjjyqmnQWFpnDRX8iNc8kowqgLKFUdaVKFPrbP3cISwFaTnw1eQz3lfNIDCOo68cwq7skw+XW2VUsKZHSn8muDKssOgTnL/ccZufhuyD9ehrLrSfWV/Jq0TMEbkglt5/X+XFNOpcsJDPwkEenyRkbIoucbf52zdbaCkQu9F/7XsfB4ORMxL387p6EJuxwuppIkfskMvIokgyLwJ2IeU3Et/KHfz8UPEFZgiD9p/x6KfYwSFKlk06soxZD+OaCB6C3csrCgkT3KbOScRxBBElVbgviOrzXw6LEkr1IeDc7FqlNA2QPw+5eLC6Z/onh6lJL8ngUHwb8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFu+Qaqa9ApVmZ9muQOQdwZBU7NGmE+DCJnv8+uMGOc=;
 b=pSdxNtelLJ6aFoGeKzBbLJwPMtGy0FzLeTx6Di08L0t92n5bBB5flW+SCcAfm1jK2R4nb97yn8gmPeHCgqdkvawsVxw2n3+8vynG3zDx6I8axghwqIgRkvJapziiO1NPPyO0jnyY5r0L/gsKEWWR2gHrGJjH4mWSgQ88+WHyXFGjBsQKXVWeOi7pOpWCxFN/Nz7o1BneOI1WcvfUVyMnK2JAH7p6kTHDjzB6+4ba0UwyzOYwa8iSKyseXftRJVnXnI+Pe1Pv2ka4Ieygj3qNKRDRyut+NE4jD8wuW1pXTKa9jEg/sPw7557hMDEmKT5vX+tTvcaxppRD7VMPc/gG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Thu, 20 Feb
 2025 00:56:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 00:56:43 +0000
Message-ID: <bd6d7f15-0805-4ca0-a2ce-8d97a8ace515@intel.com>
Date: Wed, 19 Feb 2025 16:56:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 24/42] x86/resctrl: Allow an architecture to disable
 pseudo lock
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
 <20250207181823.6378-25-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-25-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:303:2a::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d2f1f6-f0a5-4723-37ed-08dd51497183
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTNpYlJPbWNCZjlZQW1Yb2QwaXNzaEpId2Fwc2JBeXhILzN4YllSV2RtQVlP?=
 =?utf-8?B?MTNtcXQ4aGpSVUZrZFIzbzVTSGgvdkpOZHhoSTBVTEZVQVVIYTdsOU5vV0Rq?=
 =?utf-8?B?WFlCRUQvN3FCT20xVGp4dkxLTER1eXhYbllMM3JUb1A2SjZNMWtKR3hCekpj?=
 =?utf-8?B?bDdlcjYvMHhqU3JQZmJibGhEQUMvU3h6czlMbWliKzY4U1RLZjRtQjd0Wldu?=
 =?utf-8?B?VnNPem92WHpCZTllWGwyMm1CQ1N0eTBKNGtvakQwY1NlVXNTZmtNUk1kQmov?=
 =?utf-8?B?WHZnSUpFQk1CV0tVc1ExLzJCU2ZpZGVzQWQvWXprLzh4dHBFZWxmREtkV29U?=
 =?utf-8?B?RHJQNjRTb0Z1dGdiL2RlOUpNL3J5WGV0bm9LYUo3RHB2WjNZVWRBbnJZSFJ3?=
 =?utf-8?B?YXZTQXBJcDdVMXpKcnExYVJKQUhseEtmTHJaS1F6MkpQM2xKWkRnYUc1dStm?=
 =?utf-8?B?b1JqdVlSU3VYN3RhRTFtVzdkL3RKcGJZRE5TMVNhNmJKczhpNDQzSWxQREJD?=
 =?utf-8?B?bWRlZ2xEVUc5M2Q5K3lxNS9aZTVQekVKSTFNMmhDK2pmdWxVUFRxTGJxT1Nq?=
 =?utf-8?B?RmhESDgzbGRwanR5Y1EyZ1lLRWJlM3ZuRXhhYzYxM2NXcGlKK1Z6NmEyQTJ4?=
 =?utf-8?B?MVlURlJiamJPcXdiNFJTV3NINkJGNWNWRmpLbDNtVngrL0gvMmZWR1paNmx3?=
 =?utf-8?B?ZnZzT3RZajQvYURyVUZ1VHJIZnhGdm5FRG9FYTI1S0JXNlk2SjJMNFl5b3Jt?=
 =?utf-8?B?bFJxZ1NsZ0dZQzVIZStrNWxlZ1NFR3lTanBGWG1HN2QxZmdFcEVaMEtPcmRz?=
 =?utf-8?B?bjdaejdNb0IrNW9YanhNaDNydzJxZk9lZEh1c2xyQmhQbGZLTnpmWlR5dHI0?=
 =?utf-8?B?aEgxNks3K3E1Z2p3Nkcxdmd5dlllUyt5S0ZWalRyS2FiWHZZaG40YzZKVGpo?=
 =?utf-8?B?bmhNNDNmRmRZVWFoTXkyNk55a3BmVTNCWC9udVVWNTN6ZGtmM3hBS3pBek1p?=
 =?utf-8?B?TGJScTBVTk5VV3BvQ21KZ244dkpUSmRSUldQTW1HaU1RdVJTcWxoMkN4U3cx?=
 =?utf-8?B?SllrSHNQTGFjZ1dmdENLSW5kT3dtcElhcnZ6d3Jpa3V4MkhKa0FKOFIvcGsr?=
 =?utf-8?B?ZTJOOHRNY05KQlZ2YmEyT0FvL0JCSGFjU2JPMG9xdUNod3JUbW1HbURXdmJF?=
 =?utf-8?B?V05RaUxpbE9OWjlYTDg0WUdoRTJoWTY0UVA2YVFGNEIyc29NU3Z0RUt3UGZF?=
 =?utf-8?B?dHZlQVM0TTdHdGpIbTFKTUlqbUhpdlEveFhjRVZGUEc5WVIzRWdZTG5lYnJj?=
 =?utf-8?B?cHFUVW1TRnZqb25WK1NRSmM5RHN3RDRRVFhzSmQrbFh2QmJ3dGRDeEZZc3BQ?=
 =?utf-8?B?ekwzTVUxb2VZcENPK05jRElJcjNVcnFiUnVvWndUaEsyMzlLS1hPcWZWamVR?=
 =?utf-8?B?T05GOWVmcjRnbm9DV2lVcEJ4NWhjcWR3aEdqemNhYlNJcGpMMVNyQUhVaW95?=
 =?utf-8?B?SUNvZFpteG1mZ3Y5Nit6alJRcnF5RnJFUHR5RzJtbW40SEFFNDV1WDh3dENS?=
 =?utf-8?B?RmYrbXEwZ3lBclR5blNZakF3YzR0aFMyVExndTc5N1UrOW5kT2MrSTFrWGtJ?=
 =?utf-8?B?bUg0RGVWa3ZGalphcklWT3VIM1Q3aEtQYzN1bkloYTVFUnlTRHhQZVlieVRy?=
 =?utf-8?B?MXlJUEo3K1VNSE8rU3ZocWFMK1lZdGVWeXlKU3lHNXBTeEtpSUR5SmVBWEY1?=
 =?utf-8?B?V2lUZ3dDLzFEK25zamtlOGo1aUp5OXpZcURDaGVxRUVURlU2ZTliOGRVOUNV?=
 =?utf-8?B?bENydVFZVHZCUFVFZmZiNUo2cUdHdTYwUDBuWFV2OU9IQVlYUVlVbHhzMW84?=
 =?utf-8?Q?aiZrulCmz9IHN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkpuenErSkFoVEFQd1ZML3IwWHFZNG92TzZ6QzhkTFB1RVR2OVFyWWxMUFBq?=
 =?utf-8?B?Qk1ZQ2Y0Rjk3Mi9ERWUwL0RpSWY5L242aEtwS0lwYlh1a2N0VVZxWGQ2eVJ5?=
 =?utf-8?B?K1lIVHhhRHZqUktPbHZlTEN0MVNMaGVmUnV6b3h3Y1BYZ3N4dTRuQ2hnVTkx?=
 =?utf-8?B?eG40Q2RlbVo2cDhiRW53RHphRmpHNUlHU0NYUFh6bElqQkV2Y0dERk5XaUhN?=
 =?utf-8?B?MjBSZFA4SGd1c2lDbUQ2VTZVOElpVTdsYmh1SFZoNkEwUzRzZXZtVG9PcSsr?=
 =?utf-8?B?OW1sUVp6M3h4MlRuckpoTDdCWEJ6TVlzY05tUXd4ZDUxTDhlNEx2NTZqaUlW?=
 =?utf-8?B?akNXajZRV0RmdGNmTFhNSnJZbXNTWnNPTFJLN1F2bTVjSGtabEhiN3lpblhF?=
 =?utf-8?B?Rll0bEkraSt6NllmcWlRbi9ZWitkcVNaODVzbUcyalQ5d1Jvekc5WUFReHBv?=
 =?utf-8?B?UnNvRENyUUw2ZnNTMnJKMG9mNGZmaGxHSk1oSFNPYURFMjNkN1lxTDZrdHJk?=
 =?utf-8?B?RVpkYmNJVEF5L3NuS043WG5DcGNsU0ZMbnc5ekthL2M3S0dJSGpaVWNZclgy?=
 =?utf-8?B?VWs2WjlrLytRSTR3bWZ5KzZweS90cnd2ZWRlOXptS3pkYldTV2VwS2lHcUN5?=
 =?utf-8?B?akx0alNXb0ZjZGkvYmxEbzhtNzI5dkZjTHVLSU9nb3l3b0hHUDVKNUxBaDJR?=
 =?utf-8?B?T09BSEpoSVR4RUtsT1k5anhSWUR1V0FqSnIxUkRtM1g1OWFqLzRmYTFwZWJq?=
 =?utf-8?B?YzdzRXprODR6YU1WSm8wSGliTlA1Qit2RkRtaUozOXBNWE9wUUgvSXRxZVQw?=
 =?utf-8?B?Y01zYzMvTW5BZ25GTkVmZzJXZU5NSTFlenNzRlV1QUprWEZEQU9Yd1hqNEFJ?=
 =?utf-8?B?WVVyVzArK2ltcXFyc1NrYUVUNkl2dkJvWGRCaFVuMEZzQjVUWm1MQUZkVFU5?=
 =?utf-8?B?bFNUM0NOVDhsUE9lUUtuT0RlTVhKd0ZzNmNQb0dCQW9XUlQvZksvUXZaVVA0?=
 =?utf-8?B?MHZUWHZNaXFzTENtWXFHaDlBRXJKTUlDeTFtUlVHYk5rNDlmUUszOERMZjE1?=
 =?utf-8?B?RUViTG85QWY0MEQ5ZXhLajVhM2RTVktGcGRoOU5MczBtamdrSjY1Vk9VWDhT?=
 =?utf-8?B?TnlBZUlqakhDelhpaU90b3lLSjhXWGhkWTBWdWhMcktaWjNZMkhLRzdDQnNP?=
 =?utf-8?B?c3RYKzBnbkp1NCtrb1pXQkJxNm1UZlNnditidHdHSkhDT1ZRRWdsUTdCVFc0?=
 =?utf-8?B?SCsyb3g4WjQxWm93T1JHczRJWWFCZ29vU28zY3laQ2kxZFRET2dFY2VKUkJm?=
 =?utf-8?B?N1ZhUHVTN09YekR3bU5EWGZiLzNYM0ZoQ1BhRk45UUFQVmd2bmZEMGRmNWZT?=
 =?utf-8?B?QlY0clVrSHRkYmRERDh6aDdoMTFDZEhaQ2tqZFRrSVp2ejFsMTJidnV1KzZm?=
 =?utf-8?B?cW42RTZxdjFjejc0cHF3T1J4NXhoQmpyY0tQeHBCWTNtVEkwcVcveWlFbE1i?=
 =?utf-8?B?Tm5kRFMyQ1ZzSGEwYzNKd2VJRGk5UXg5UXlvdEZ2cFdKc0loUTNTQldPZDdZ?=
 =?utf-8?B?WVlFYkJEeWFzVktlYU1DVGM2c0hCTmo5L0M5TkhjdUhHUldLNTd5RW52WS9O?=
 =?utf-8?B?bVJPTE9KckdTaEhqbHZJYzFURUVOc01VS01aaXZWT3I5L21YazZDc3VscnNN?=
 =?utf-8?B?ZGFHTU5PQmhUenJ2Ujcwdmp5TWlSYjByUnhNcDRjNm9Xcm1KM3I4NnRmL0Nw?=
 =?utf-8?B?bjB1TnVNa01VZEJuM0FITGl0enlJUzE5ZUxKbU1lQU5xVnR2U1VmaDF0RzVa?=
 =?utf-8?B?bVUyd2hjSC93R2NuSGkwZU1nM2JOTU9jbm8xL25MZFhTY0U1VmFwV0VrU2s2?=
 =?utf-8?B?Sk4vZWRPcUVxd0ZIRFlKVnhJenYvQ2V3RkQzUVppV0NOb2QzN0U3WmVKSDBY?=
 =?utf-8?B?enFyaHNLQnh5MXFPMk1XWGVSZHhwRDlBWU1EbWsxQWcwUEttRGhsWTJhL05M?=
 =?utf-8?B?YktQK3FkYXBOaDd5RnNsSVd0UlBrcVAzeU1MdzUwUVd0QTJGYUFBbGFGV1hJ?=
 =?utf-8?B?OCtkSnhYbEVnYTEyeGZ1K1B6R1pPMDd6b3FUT3NLTjZTK0MxK3FEWlhSQWlO?=
 =?utf-8?B?dUhWQWh1K0FqcmNDc005ZnozVzE3bHBVUXZiZFhOazBLNUtsbUgrMXJRWVdt?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d2f1f6-f0a5-4723-37ed-08dd51497183
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 00:56:43.6977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roaxi1/6CM+hbnuHPOvodyNXOGbFm7/JPXZn1ULFUnQQGGGzdoHeS5sf0oowYixo1DFF8PDyhPO0NZwKMWr/0z9HQf4NRJ96Ek/v8UMgPLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7174
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> Pseudo-lock relies on knowledge of the micro-architecture to disable
> prefetchers etc.
> 
> On arm64 these controls are typically secure only, meaning linux can't
> access them. Arm's cache-lockdown feature works in a very different
> way. Resctrl's pseudo-lock isn't going to be used on arm64 platforms.
> 
> Add a Kconfig symbol that can be selected by the architecture. This
> enables or disables building of the pseudo_lock.c file, and replaces
> the functions with stubs. An additional IS_ENABLED() check is needed
> in rdtgroup_mode_write() so that attempting to enable pseudo-lock
> reports an "Unknown or unsupported mode" to user-space via the
> last_cmd_status file.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

