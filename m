Return-Path: <linux-kernel+bounces-522961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A198FA3D093
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863E51897F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0055B1DF269;
	Thu, 20 Feb 2025 04:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJLlLYc4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE3F1D5AB8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740027041; cv=fail; b=oAM9pKc5iRjfbXNYIAsVqgTkhtMb4gPkHTzP/ilBEEUXotE9OU2ZllsPuEu0L3mvuDVIT5TzGfaAB4TG30yUnXDAvdsWTdf0m4qehjCo66S3fO35kRUrrxaUrlkZZB9Gi08jeiF8Qr2V3d3ESvt+VQVsjTmWmeyPID5yWLgNEvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740027041; c=relaxed/simple;
	bh=+w1PbDYSbnow5KrgWIaOuzWJgQIWUGFBhzkfUof+EFI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OjqCb7hPxSx7T4+oJ6jLeVrk+kVMaUd1YYRGuCtFGjV8QyKLgpzsnPHKj2Nh2G7FqzcsGVaGjc+7xsuZZr7f4NdhnOer6Bst+szNmT7Y6wAAo9Y0/v2KesSbAE0XDr78qDSmspmvcKZpVUl5cRxzpwJP+97EYjkvwUu7VAIBXFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJLlLYc4; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740027040; x=1771563040;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+w1PbDYSbnow5KrgWIaOuzWJgQIWUGFBhzkfUof+EFI=;
  b=VJLlLYc4zxVySHDF3GxxBKXMUji8zjsaqikCV5GCVcAbne0p3S/YTv0G
   LmzXBbKBUkqhMmu/+DT+a1Yl/NSXpKN2rO9E8E2Mv9BtDgCXrWF3Rv13F
   nHo+JUrpsLXspYkDLb0z1XP+nbXOwA8Wg0djMC4BpuOdeapXkuPAxhVdO
   GEBDiV5yJGTEZ54Uf9+lSMdLG4A9N7fLxB3kwc+9V7vNpiN97I1bv+2W2
   VKNPelH3LYcDZcN0bgfphBRYvMJiemBn+2s09QbhIiA4GgH157nRvfKCY
   URT8YDQl2lznmKK5+0THGKqjA1f4QVQ+RVlh2aDtGRBJx5Ht8r0zEJXXp
   Q==;
X-CSE-ConnectionGUID: R6Kp//q1QkWEw+B1JlrLzQ==
X-CSE-MsgGUID: Y4ioR4+USjOzS5y77H1Ytg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51004007"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="51004007"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 20:50:39 -0800
X-CSE-ConnectionGUID: haJnd9LzT3uAwY+E7cP5Lg==
X-CSE-MsgGUID: /xsfnilrTuiexa5SmBlu9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152126146"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 20:50:39 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 20:50:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 20:50:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 20:50:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAUpb4HZmCHjMd7uWOYxDJDuYM6kkaCfIDwhtRdLwV5GlzwVj5GvAZLDywN4OxE3QutGCFx4LCQIbzDjlZSRRdxCwroA2LxAoBINmk15iD8SHmVErsvUeKLu/YbM7J1kIqh7L38/Spb9cc5KmpWFxyZT36P+NGE162jpdMc2nZGHLZx/5mW7ZvpEBOXXViktjbJY1FAExUjLxt+VqQ6a/6gCMGv82h0677marQIhre+7qnom95tRFnz6RZfI7fS5SmNsiCKqgSiXQ35M6kx5gVf6MvghRrkABV/NGItLsj6zJ53KBi92fO60Nse9FjBG15OlBRHR9Q94fi8ZcAqhEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RElYxSsJcQgVr7mTUbsBo5tVOaqsUV+zlONH9uR0nU4=;
 b=ntuB0hEIWZ9qWJWYBH2BNB59M9Q8DtGEkaf+LiCHOi4lVvXwvCh7n4kMM7YVYd2ggY1nqMBw1cvShz+gbDC9e9cQI5E/t050QogVcoRaMpR2VrAp2iPUhUa53VIP6TA+feEFQrzwqva1HLSX7TfHMZkv6Y30SlFvxksEu7bzgGRCJtFMEJ1GLD7S0jmlRr2/YQguejmFCefA3tqhJP+vk6NOFQ2p69WoM5Gn0f7J08ICaHxrs5zztRqFhkOTOibMm2eWJ3AATj6p10gb/4SzDuOHgUvs8RTZYbxSR93Y8mWOzhk9rI1SFW9rHzt8S2duvnQxPiZmoBsneO6oH4AG1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4860.namprd11.prod.outlook.com (2603:10b6:806:11b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 04:50:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 04:50:06 +0000
Message-ID: <51f61480-1b5f-460b-917a-402272c3ab22@intel.com>
Date: Wed, 19 Feb 2025 20:50:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 36/42] x86/resctrl: Add end-marker to the
 resctrl_event_id enum
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
 <20250207181823.6378-37-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20250207181823.6378-37-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:907:1::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ca66d4-35da-481c-d9cc-08dd516a0c04
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NERibVpJdW0wcnhua1ZjeGViT3NWUVFoOGRuMFNPMXZETVRzV2NQNElsVE44?=
 =?utf-8?B?K2x1ZDAwdEhxcjRqMHdGMlJXbEVpamhTTkUwK2ZMNGl5Qlc1bTRHOVhLbk9i?=
 =?utf-8?B?elRsNnQrMXdNRW4vclhEN29nTVp1RnBUVEJERUZEdmRpelNVMmsrMEVBZVNo?=
 =?utf-8?B?Qnp5RHJIUkRzcFRkTVhXWHQ4YzdZM3JDS3lYRjU5d0FnZWZpRDQxeDFjMDRN?=
 =?utf-8?B?alAxOW4zUHN2NkEybGZISTdnUVlLVy9LZkRLVTFlbkltNm42bEUrTC84azIw?=
 =?utf-8?B?QWY1aDh4dENpTnFwdFc1bnNrNng5Wm1YeG15cWg5ZWJiY3A2QU5uSEQyV3N3?=
 =?utf-8?B?ODJweHFQM3hhSHFaZGE2ZmRiL25uMW1kUWRUWXI5emNQbDlhRnAwbno5V08v?=
 =?utf-8?B?cEJDY2RKTnJFVkJYa1gzNkg2bDNyUXpKTitQa3VESzYzOTd5YnRSSTBSaFJ5?=
 =?utf-8?B?MUJpS1FNbGNhbFZjNDVsWGoycjJhT1MzUUViZXZzamZIbC9CbE96cGkzTm5M?=
 =?utf-8?B?Z01ENUNlVjUwbS9IU0w5WFdlenloNTIwR1JjL0F6SHVoaUZqdG0zcjZVL05E?=
 =?utf-8?B?TlhMU2Q3L2JFSlBqZjBOQTh4RGM0M1J5bDZtcFFnbE5aU1VqZzRNSFBjRXR4?=
 =?utf-8?B?L1VtM2dZZGdrTzZzTUFPNFIwTko2TEZOQW1DT3FFZFJVS3R0ZXdjZlQ3MmFF?=
 =?utf-8?B?cGVQTnFhUU45NHB4TmJ1WXN0eC8xUUJMaHY0UGo0OFlSWUhzMmN1SDBPemJv?=
 =?utf-8?B?SEtHbVN6KysvcTUxSjhqWmpWMFdhSTNIb09hSkxKYWV4ckMrZ3ZQaHpPOTQ1?=
 =?utf-8?B?dHJIU0tQYlRic083T0VIbWt5Y2RHZTl2d01JTnpFQkIyWDVwemVEbWQ4OVVl?=
 =?utf-8?B?a3BaaUY0WGF3NXVhN0pjREFRd0F2WTFHSkE0ZjBOUlV1anBmMGE5YTdQNGZo?=
 =?utf-8?B?WWIyV0ZtVnBaNXBvOWFNSXg0V2VRekF3U1Y5Tkh3RWNvN3B6bHc2dGw5VnM3?=
 =?utf-8?B?ZVNQQXRlRnVCZ1VEazVhem1sMFVWL29sK0pLd2kvRS83VCtLREE0OWZaVnpW?=
 =?utf-8?B?K1FqcXI3TmZ4N3VNWXNFeVpQU2hrUEpmM1pQMjdOT25maklIbXhMVUUxeXY3?=
 =?utf-8?B?NGc2RUNWWm5uajFGQWk3SXJSWVlocWhjbms2Vy94cThMLzlQenk2bUFrYTZj?=
 =?utf-8?B?aXdEVVJvYVFQSERIdkpqT2RmUC85U1NGUnM2VzZNYzNlZER4Y1FwMFVJR1Rn?=
 =?utf-8?B?bnM2cy9wOEdVN0xoR2NBWW1Yc1hyTlNpb2JwUHZ3WDBYb0c4LytoVnVrelJX?=
 =?utf-8?B?RGt0RlZGRmNMa0Y4RzNkSnAweDlCVjV1ek5Jc2RGcU9mRFIwQjQ5MlE1UFZE?=
 =?utf-8?B?N0tPYkVzMFVYc24rU0dlKzVoWUtxdkt1VzlKcGxtZFJvRk9LVU1PZEdIQWho?=
 =?utf-8?B?SnhWTUROcXFPWWo3TllETWh2VHJQaU9yb1k0aWtUUXUrWmh2M1RSMTMvTkZn?=
 =?utf-8?B?UHM1bnBjcTNhK0dhNWs2TW1nWDd5dHBaQ29adFg4UkU0N05pUGxnbkV6U1Jh?=
 =?utf-8?B?TTk4bVp1OElxYiszUnZyWC9KRWlGMk5MOUxsT1pPREZ2aFZ0c2dONzFKMHRH?=
 =?utf-8?B?c1c4SlRtazBzNTdmQkRwV3Bsd00rbFNqbFZFb0hWRDljalc4a2FWZHltYnk4?=
 =?utf-8?B?b0E5cUpjOEJmUEZjaXNkcGd6QjRVVHNvRnA5S1VmcEVvQko2b3hWRm5TS1NM?=
 =?utf-8?B?ZnhPMGJCekUvOHJKRk4xRnZ4VjZYMkF5cmpOaWgwayszYldwUGV3cUQvRHNM?=
 =?utf-8?B?cXpoNGVrbU5kZ0d6OThqMjB1MFpGYXN5Q1hiNG0xbnJVRm91V3NJaytRUXBK?=
 =?utf-8?Q?JCYkmB7PRb4xp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q013d2x2U2pPWlVjeGxNbXVDd2tJUHVBQVBzQTFMQkczZUFqL05ZUkN2dnZL?=
 =?utf-8?B?ZWJLejNwUjEvaUdDTk5XcVN4WDAyR1U2a2FhTjA3c3VNYVplaDdicTBvQWZh?=
 =?utf-8?B?djJZR3ZYWWlsT3RSNUw3UEYxMS94RTZMWWNURjErYWtHdFRtZW5BYUp3amF2?=
 =?utf-8?B?eFIySS9Xc2MyRDM4Wi9WRWpxMHdSNXN1VmVLQlVQcW9oWVpmZzZ0cnowbzdp?=
 =?utf-8?B?WDJxYzNHR3dtYnE0SFo3b2Zac3o4cjlHTFBKejZnWFpPWTIxR2F1bGR1V1VK?=
 =?utf-8?B?clZxWUpsT01mK0JNNUxwVG1HRzIrVDBHTEplQzh5cWtqMlU1S0o2QlRaTFlR?=
 =?utf-8?B?SnR6NGVCN1JOc2VTU25kL3UrM2xJUldoNEJwdGMzcmtiT3h2d242RlBvRjhh?=
 =?utf-8?B?U3ZSZ3hCYjNhUkFhK2k0enl3cFFsUVEwMENwWmNxSmhNN1dHQlhhL0gvTGU2?=
 =?utf-8?B?K2w0N3VmQ0RYQnplZzJGd1MyNlYwSnlFcmYvaStFQjNvM0lWM1p3NC84ZExU?=
 =?utf-8?B?bTdHdXQySzNvUDlwRldzSExLUVB4SnNWT0x0cVF2MytmamxwcTdxalJXQmhB?=
 =?utf-8?B?a0VPcGl1c3kvYVFyZjMzYk1JaGtDKzhRQllUM0l5Y2ZKUnkrTkNNOS9URjcr?=
 =?utf-8?B?YnRXTmlJdk1CQlBGTnBKdUErVzYyamdCL0kvQytLTG80RVBBZDQ5b21YenFa?=
 =?utf-8?B?akxzZkJreVZVOEthak10RG1ZYW51RVNsMzRHWjdlb05Rc3I4djRSRE56VmY0?=
 =?utf-8?B?N0p0YVNOZ1puMzFQTjhCRERWd1dxTS80bE5RbHJjakM3NldHTWIxbTJsKzJ3?=
 =?utf-8?B?STZHWXFrMHRtR0RtdmVBYjdNaldiOTBIZ3NMemVoUVA4MGFXUkVOczAwYjBq?=
 =?utf-8?B?Qm9wemI2MVB0S09TczljbVZxY2c4U2paWXhiU3lQV1BCUEhQR2tpb2RXRkw5?=
 =?utf-8?B?ckNvTGpYbUdKU1hvSEZFQVhNcDQxdlFlb3k2N3FlOHBKNkorRDZDY3VxQzA1?=
 =?utf-8?B?dDhtWUVqdG40YWQ5WllzeXI4ODZ6TzM2QnovVHRsNGszOXk0Q3BlanBUcW9W?=
 =?utf-8?B?YmZCcTlCN1ZjNnhEMmJYT1dqeTFmeW1IbnpkN3VZVkt1Wk5sa2o4RTM2Tmh3?=
 =?utf-8?B?NXRQbWlkakRsQXBUT0lSenQyOGplZDE4VkxxT0pEREFYSC8razBJRnZGb1F3?=
 =?utf-8?B?M0Y2b2lKVFRXSVZyMXlKWTl5YWVVMGcvQWV4MEMvVmRoYSt3a2JtbHZERk5Z?=
 =?utf-8?B?L2JhYTlOVnJJVzRSbjl1RmIxVTh0dGsrVmowUk41VkdMTXlha0dhZ2htS1dS?=
 =?utf-8?B?SW9JTFA3ekRseFdkS09nL1JjL2JPZHpXTis2TjRGWXNpTE0yQVh2Y291cW4x?=
 =?utf-8?B?SGlRZzg2TTc5ZTZ5MW44a3c5SmR5cis5VHNKUUdHdnBZQy80eHNWcm9TYlll?=
 =?utf-8?B?b05oQ29EbFlWMVk5allyYkhnTFhNNnJqZVYvZ3lWVFRKK1JCR3dPVlNrRkY0?=
 =?utf-8?B?anBOekZFOU9PUmlaY0ZRUDlSQ2oxa2JENFU2VWh6OG1jU2Y5cjRKME5oRmJZ?=
 =?utf-8?B?SjR2b1hQVjFHWGxsT0xzOXR4VSs4SHhuejNnY044UjBKZ1pyNVg3cDZCcVV0?=
 =?utf-8?B?NTdyUjZ4eitOVFlTUlNCa2FMOW03K3MzK0ZldVg3OElDRGNWMkZoaDF6aW5E?=
 =?utf-8?B?eTdHN21lNWp3YTRFRFNiQlpXQ0NXdHlLT1pjZWRLZ0t0eHE3YmZ1dVRMazd0?=
 =?utf-8?B?OForS1V3Qkl0N2hJZGJuM3JUU2hQQkhDTlJBM21Td3k0ak9UMGtTU0h5QnZJ?=
 =?utf-8?B?SXA3YVJldWpLelJxaW1lYnFieVRuTXZNaE1QQ0N4VGZoQkpCSXpQVHp1M0tT?=
 =?utf-8?B?OER0WTZUaE9uV3grV2JUNk15aFdSRVhqZDZoSHhZRFFxSE83U3Q0Sk1BTDYr?=
 =?utf-8?B?ZTVYV29xZnF2TFFxM29yZzFLOElMdkJNMHVJbDBEeTFPdEZ1cmVYajBJd1lN?=
 =?utf-8?B?VnYrZy8wTis5a2lHM0w5SmtYanh4RzVKbFZ1MHFaYnA4N05ScGc2K3pKTnNt?=
 =?utf-8?B?R3FEdGtucEExSnNtZHFCa29RazgxbnljNGljcmR5dHdnUGU2WlZMZWVFZGhU?=
 =?utf-8?B?THZ3cmx3TTg2cU4vOWJwMkVGdjlXTk5SZEc3cmxTY0ZQamhaNGt1NERVSkdC?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ca66d4-35da-481c-d9cc-08dd516a0c04
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 04:50:06.7865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6Yk90RP0Tr7xeGeb+0+6/56dyQcqNG/ZYe6MVO/HVYzRnlUNcRnQCAHp1MsUqyrZaWokTqsMTuQl56SWGiSzHehmVAdMKF/uPktX5zL6QU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4860
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> The resctrl_event_id enum gives names to the counter event numbers on x86.
> These are used directly by resctrl.
> 
> To allow the MPAM driver to keep an array of these the size of the enum
> needs to be known.
> 
> Add a 'num_events' define which can be used to size an array. This isn't
> a member of the enum to avoid updating switch statements that would
> otherwise be missing a case.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


