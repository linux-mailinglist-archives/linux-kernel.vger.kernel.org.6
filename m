Return-Path: <linux-kernel+bounces-570801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02622A6B4A5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8E11897F64
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6E31EB184;
	Fri, 21 Mar 2025 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eehyDiO0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2491E5707
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539931; cv=fail; b=G9LMksH6xF3wfIcgql6TDby8kIFWTMk2bfNuU+WsiFkP93nO875GzmcD10YdvindZ18NKRjS3PtYFNHDQLyhn21usBNN9ma3YDE3ApitYPqCXgj/M8wzYSWAVYtM9+grKp8zSoPvXEsJXjkyKKGKKmfiX3qkWylcTEy4lkyoKys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539931; c=relaxed/simple;
	bh=S8Nxk313TMusYaQo85HBVb7XOL/73EFNrfHurxPwD+A=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jOjsEG39LQQf3udvSGunAfLCE/CrE2pMOIwq2i97oRRlbYKJDIDqh52NzuMU7cHPmscRjeD8zmbtt2Kstn8A2LUzmwFF7g/n6EGf2CkY0rmXYNdxTEsa1ml2NRn/4iuOAFFLMNor1h5AL5a5tw2buseG1+UECkRy8VQUCmQ4mJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eehyDiO0; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742539930; x=1774075930;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=S8Nxk313TMusYaQo85HBVb7XOL/73EFNrfHurxPwD+A=;
  b=eehyDiO0MEvzXF4uw6hkPsbXwbz70+2fB+5jqcG1JDHHwxmU7KJ2kq2Y
   9MSh4WXVqcYo4mHLhBbbK1h4/VS2EzIOFn8uz9CLWjUtbaYJhlKlgkQC2
   Z4SPyTAoGO50+B9ItSLwv8/KJ0gIaQv1ipHuYfvkxbkAb77+7ylJc0Rc6
   5AcUPqz57m16SkKJtm+hXTy+kWqMA/LVSkyOeZBfv0dovMf7qh5iO7NI7
   73LYpw+sUzLYCiwok4QdCb2HR790NHJI+0pG/AMo17E2sRWc1rXdYsXjo
   81FvKtsrddTxPBXGvIg90yxtaixzvkIGbPQSy56SsEunJ5QBiXP+QGP1l
   g==;
X-CSE-ConnectionGUID: nS84I3shTaGJVJ2eV1DLYQ==
X-CSE-MsgGUID: vut7aablS0G5gttljxIWlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="55180444"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="55180444"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 23:52:09 -0700
X-CSE-ConnectionGUID: GyMDU5pXT26AQGqV7ne3/g==
X-CSE-MsgGUID: dyJc1jiNTuWt9maP4jBn3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123776379"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 23:52:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 23:52:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 23:52:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 23:52:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSNCQBKQGpEDz///G1+d91KBfNwtYoWeFiG06pPFaLj+AjdMV8d41wdxO7TN/YPQqOuzVX5IoQgdMyF2KFNib//iQZS+T31rDtS6Rc9glqIUABK9PBw2JGidDFnsmx1t8LzXkE+l/EqCeusjcSDWmbOy8EF5vFsbeVr/dWzY/DVtrqHn1c7ZgwvJYYePIOmQ32jJZlAZJ5NQMCRsv56gJAAjuOxpdg1g1f1xGAcfeFgVdKtavmbxMXxofXgEKi9mv4MtCqinXbBnxDQHcy0m0E1Q+T7AJkOiCxLokQ+HYf02DUaJyYhtuz3Ep5HzyVRn5iikNDzyV/UQFHF2bGYl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELts+3KdOVC5lG8+vrNUYnLujYDHZlGMJuPvK8KwRHg=;
 b=dAFnSireUTZpxnOFjHSVKjOLyUjWkLaeteM4pxt7uZo5se5GukLyh6CgS3VnqkRSf5v74cVfd7EnIpWmPKlSQL0+ux6AyRv5u1AnrqYQtB/0Q8cuz59KDdl4TtySE9hMIdw+0H7DTBOYevHVxPhQsMDO7X9lglnFgXkjZiJ6X+d+KvCN9q+ArR0Z3+T7zdMVVZuxmo2Ntr6wW/GDDYEb4tOPMhdLuht11TNY2AAxe03D8Os4rdz7IrzIi+TmedvUESzgYc/VlGkwV5DHPSIZ7HZf96kBT7NYGjVVQiAZyLtWcalfMTPYncqlki+N8IefFfMM4z3SQbnm2i5KGBW2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB7769.namprd11.prod.outlook.com (2603:10b6:610:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 06:51:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 06:51:51 +0000
Date: Fri, 21 Mar 2025 14:51:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mikhail Paulyshka <me@mixaill.net>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, Mikhail Paulyshka <me@mixaill.net>, <oliver.sang@intel.com>
Subject: Re: [PATCH 1/2] x86/rdrand: implement sanity check for RDSEED
Message-ID: <202503211421.fc83271a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250312123130.8290-2-me@mixaill.net>
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: a4bc7767-c262-4bee-7f6a-08dd6844dbe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZkE2ODXqf87XyirdlGu7UUpuR+nmM5oGY0FGuW9aFpP4wHc8IcVPsMMUDRDd?=
 =?us-ascii?Q?sBXphCzJNKa69QjOl9l7HoNTSsAXDiu0D7ekajaFiVdWnUQ/q4R9NDnwqvp4?=
 =?us-ascii?Q?lLlTMjTwi6BgztxWMvU63sCT6lQOhw5aSy+mpO97tXBrIK+i3Uyw/nt5qaww?=
 =?us-ascii?Q?R8YxAiVFx1B20q4i108t7vPkbkjtaLsAd5vvR+kp4tJaTg92gec8aeI89neG?=
 =?us-ascii?Q?qZ7bBP+SIDy6MJ2I8fv1/ir2jkuY2G138elgyiN3WgmUuOw1zhvxVIn9DuDL?=
 =?us-ascii?Q?zOaMQIQ+BOu/EvM8U3erOlEI+4zk5wIrODuypAclMcG3vMF/5/lfQ6Sej3ag?=
 =?us-ascii?Q?dsKWpe/ntgvb4tChb/YC77ydhaNx42oNz5LrKk7ogz2tWT3lW/at69UtmlOf?=
 =?us-ascii?Q?SpHE/ZTfrhucy0WGsyN57klRWX24LUCXndiFz/W4H1hSKKpZos/NnKVwe9zr?=
 =?us-ascii?Q?Z8SoO0kOILHfWwnu4JqTHVkvU21xe+zYuXlCWisGQgiXwF2P0MdyovQaNBzi?=
 =?us-ascii?Q?Rumtz8BI2RWz2AKLi7u9hlmjtje42wedvtKWC9tMlnb6IDwCbfDTWhplcD9u?=
 =?us-ascii?Q?o0vF4Yyr1AOkfhEmwNtiYfKEbPEsw9cJLzpZ5j+7e1RPN1uqEw1lvVJ3YksE?=
 =?us-ascii?Q?Rpkx/j3Lb2bZl/FxqIn0rknWXdlgIhJhUH0aa4RMhLaBSEvZN+umc1iPrO5T?=
 =?us-ascii?Q?rN5Q8xxCQtd3SfiBEJb3AubT9o5H8soTClgrJK3UgCpgXFkxJPWyHlOWTgTy?=
 =?us-ascii?Q?QI3IDMBLNvJmmdSFAVcv7J5oRX8dyGoqbPad/x+pt1zjXrwWtZLw67v/KcFA?=
 =?us-ascii?Q?lFL2KOXDE6wf2kCr4u83sj8HZ7qxs46YIfKlHthqGViweGsfRSKCLeAKya63?=
 =?us-ascii?Q?O4F9wuplOsZRds11t862QpNOIlaxtPgFCn2hO/w24ctH1Zvm4t2Fl4rAL3NF?=
 =?us-ascii?Q?D1Wb2kT18fS+r87h/emFxRtrubtYQCmSKK8eL6/EhbAq90yJbTsnMQDoJsXs?=
 =?us-ascii?Q?qRS7r81FqJQxuIbJgLt7htG6Kvw6TXgftav2RQftuxmP0REcVgqHbkm3ryBQ?=
 =?us-ascii?Q?VOnGr2hYX7YUhzI2s3cnEJZZUzcWC369lPp8O5WxaTwssZOxF5LUJDEjepmD?=
 =?us-ascii?Q?o2tK3EdIlSLW76xwxM2+fl5eVtkxUYJGG3ejX4KMWDYvWI6/r36hvLUSEo/m?=
 =?us-ascii?Q?R0Bpt0RTjPPmkWswCt1l7WFQmwDp/VAgU+czUV/iOZnPtSoB44Pa68I96+iq?=
 =?us-ascii?Q?IgKimtdC/ZRMx1hw1+FGOgwJk24aIzCWxgmdLoZQxTSSd+LuaGHNqgItgxnp?=
 =?us-ascii?Q?apFAw983M6U3BebTPSI1PnbIi30T+Isok3HxBlkbCGC8yg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+WNJoJyu906Z8bQp2JT2g+2LlEfwtsdes4tNxEQgdLzG6ywdAirXo5k5mqDo?=
 =?us-ascii?Q?mH0PulF5AWSmbhdkAYf3458nhFhB3IDna65fbWtJIvC82PCOSQbfzmJgeLIu?=
 =?us-ascii?Q?78xUPYXKdl1D8zhCyAF1L9yipNPGWAk5utdDOTW+xSEKYiMUPBR78EwU0YlQ?=
 =?us-ascii?Q?KF4hVUXLARRsHJxJgrqZrYQy5LxFkcUbSVY8MFkGvvHf0iLP7BwhWlGd/Gqh?=
 =?us-ascii?Q?L3oFeFDFsB6jV0GtydaVCyAXM2CU5BrUDvec6vzRDXXHsbZMpf8EeL8HCr9+?=
 =?us-ascii?Q?aNEqdEpxSSL3tUxSZ5YVKJPvg6ihn6aivTqvuy8EcR5qvZ8x1gRygT6urI8S?=
 =?us-ascii?Q?udbkAwX+uh3Vz2ZyqLituGXD+hbxLG99aY9OVQTQlRoDdjzftFE1sAzrkw1U?=
 =?us-ascii?Q?glRxXssgkqdeaVCW7lhi+ksGN/592OU9lz3nXchv7TCWI3wz/hg1wpPJVAMX?=
 =?us-ascii?Q?iIhffNClI4W2vM0GdQhuFhqKEn5cixOHJLlaaxcbCLa9mhIHdQjKbob2SKpo?=
 =?us-ascii?Q?Hb+kuDx5eUYBmzi+lW2jxoKhFlgMGtv9uqVNxFLpv/ZJU6r7kuqEU15cf4TR?=
 =?us-ascii?Q?Yae4RppvvuWdApNVjSRWFAfvjKc5sORbjwccfYCNqnUzi2z7/2UJxubKRgak?=
 =?us-ascii?Q?USQCm10psSTwLokPeM2ri0soehzFeTJuy2dZbdtfCgPWVsrorpOCe4UhrGa0?=
 =?us-ascii?Q?8a0B8EsEcNDTTQ/d2dKnPDXq5T2KF4KUqJp4UJerBfwAGcUEDu5vJceKQqvI?=
 =?us-ascii?Q?QCgyLdnQwc/a2e5CWKWNNZCK85XSdUE32QsQ+LmI64PPY+6fsN226eShTmbP?=
 =?us-ascii?Q?92dSaM6IzeYUHJjO3o2Cc8yKqhSVSGcM+VQCP7/61bgF02DJfSq7IxZCa4mO?=
 =?us-ascii?Q?rMkqm/ezJr+Kng8y2bsU+YGZYBDDNCtFM+MqZAlpbIpIunbdPwAxXAypTj0p?=
 =?us-ascii?Q?f6J3diLgNcSx/fOcfKsWAgRBD5nsCZWqKdfXAQwfQLA0sVtx1AgS+wpBRtjx?=
 =?us-ascii?Q?yJrPKlFfx4bay8Iz1Ga2vZchVPbIptMufvQkyGoqIsjGZKoRb7R6IN6tpE0U?=
 =?us-ascii?Q?rj6OmgKMNcVVxBdyW7JJ1I7uQy4h42FyEF/3vVxHyg0Db7qjUbGIaCBP/F0w?=
 =?us-ascii?Q?eBrk4tEEwsrbjoz+n3/CsGazcdYGdivpKYuxySzG6kCcmywwDH+beY41bxhq?=
 =?us-ascii?Q?iNdnzBx/EW06mlj0C5uZL67crUD1UzBuOdSG4m2lPkKytv2W605KFUEPzqkh?=
 =?us-ascii?Q?I03CeDPm5/lAzxQ/1zfRrAYQw6RpmwisJIkA0b1MJeKBhk8QCq1u9XFvkPUl?=
 =?us-ascii?Q?XcqzOxbl3z8aQYbcwYJAvFdVCDrIhSOC2CX6K5NylZ/Xf3ga/r58k3O52R1d?=
 =?us-ascii?Q?McmAEarL1Q+fi8wgrUZOTsTijYtR6NwLVai0VW7BYZgDZlkmSsu5Hln6xC9l?=
 =?us-ascii?Q?gszVtE6jp6rPtavcqmVxhvZN2eAY6koayKxVVkDMBDn2LbeyYNk/flFYZgMw?=
 =?us-ascii?Q?Szry07cqbBiJNVbYD7ssQ3FPXWaERdx9KDL2zTFZmUvnvL1V13tSO8GsY75m?=
 =?us-ascii?Q?TzqKgwCjBQmvLjo0jChQzGsJ7PgnlOA0QBX4WUk6V3mh0nvyceEkDWHarnRw?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bc7767-c262-4bee-7f6a-08dd6844dbe6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 06:51:51.6610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ATbGYBFlJiAmqn0pr1AwVjvmphTISx6NWRBG5dfhgh9IJqJDIn57rIMWf/GymkwM5HisPZyy+HIPdhAotq6Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7769
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap" on:

commit: 1a98daa004bca11b293ae344384b120c1f3560eb ("[PATCH 1/2] x86/rdrand: implement sanity check for RDSEED")
url: https://github.com/intel-lab-lkp/linux/commits/Mikhail-Paulyshka/x86-rdrand-implement-sanity-check-for-RDSEED/20250312-204319
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 6d536cad0d55e71442b6d65500f74eb85544269e
patch link: https://lore.kernel.org/all/20250312123130.8290-2-me@mixaill.net/
patch subject: [PATCH 1/2] x86/rdrand: implement sanity check for RDSEED

in testcase: igt
version: igt-x86_64-534d75199-1_20250316
with following parameters:

	group: group-23



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 20 threads 1 sockets (Commet Lake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503211421.fc83271a-lkp@intel.com


[    0.995938][    T0] ------------[ cut here ]------------
[ 0.995938][ T0] WARNING: CPU: 4 PID: 0 at arch/x86/kernel/cpu/cpuid-deps.c:118 do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:118 (discriminator 1)) 
[    0.995938][    T0] Modules linked in:
[    0.995938][    T0] CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Not tainted 6.14.0-rc5-00157-g1a98daa004bc #1
[ 0.995938][ T0] RIP: 0010:do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:118 (discriminator 1)) 
[ 0.995938][ T0] Code: 89 c1 83 e0 07 48 c1 e9 03 83 c0 03 0f b6 14 11 38 d0 7c 08 84 d2 0f 85 a8 00 00 00 8b 15 d1 f2 01 05 85 d2 0f 84 ee fd ff ff <0f> 0b e9 e7 fd ff ff 48 c7 c7 40 c3 33 86 e8 4e fd ff ff 49 8d bf
All code
========
   0:	89 c1                	mov    %eax,%ecx
   2:	83 e0 07             	and    $0x7,%eax
   5:	48 c1 e9 03          	shr    $0x3,%rcx
   9:	83 c0 03             	add    $0x3,%eax
   c:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
  10:	38 d0                	cmp    %dl,%al
  12:	7c 08                	jl     0x1c
  14:	84 d2                	test   %dl,%dl
  16:	0f 85 a8 00 00 00    	jne    0xc4
  1c:	8b 15 d1 f2 01 05    	mov    0x501f2d1(%rip),%edx        # 0x501f2f3
  22:	85 d2                	test   %edx,%edx
  24:	0f 84 ee fd ff ff    	je     0xfffffffffffffe18
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 e7 fd ff ff       	jmp    0xfffffffffffffe18
  31:	48 c7 c7 40 c3 33 86 	mov    $0xffffffff8633c340,%rdi
  38:	e8 4e fd ff ff       	call   0xfffffffffffffd8b
  3d:	49                   	rex.WB
  3e:	8d                   	.byte 0x8d
  3f:	bf                   	.byte 0xbf

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 e7 fd ff ff       	jmp    0xfffffffffffffdee
   7:	48 c7 c7 40 c3 33 86 	mov    $0xffffffff8633c340,%rdi
   e:	e8 4e fd ff ff       	call   0xfffffffffffffd61
  13:	49                   	rex.WB
  14:	8d                   	.byte 0x8d
  15:	bf                   	.byte 0xbf
[    0.995938][    T0] RSP: 0000:ffffc90000237d20 EFLAGS: 00010002
[    0.995938][    T0] RAX: 0000000000000003 RBX: ff656fe452696248 RCX: 1ffffffff0c67895
[    0.995938][    T0] RDX: 0000000000000001 RSI: 0000000000000132 RDI: ffff8883e2e28060
[    0.995938][    T0] RBP: ffff8883e2e28060 R08: ffff8883e2e28060 R09: fffffbfff0ef9094
[    0.995938][    T0] R10: ffffffff877c84a3 R11: 0000000000000001 R12: 0000000000000132
[    0.995938][    T0] R13: ffffffff873f8440 R14: ffffffff873f83c0 R15: ffff8883e2e28090
[    0.995938][    T0] FS:  0000000000000000(0000) GS:ffff88845ba72000(0000) knlGS:0000000000000000
[    0.995938][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.995938][    T0] CR2: 0000000000000000 CR3: 000000045b26c001 CR4: 00000000003706b0
[    0.995938][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.995938][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.995938][    T0] Call Trace:
[    0.995938][    T0]  <TASK>
[ 0.995938][ T0] ? __warn (kernel/panic.c:748) 
[ 0.995938][ T0] ? do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:118 (discriminator 1)) 
[ 0.995938][ T0] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 0.995938][ T0] ? do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:118 (discriminator 1)) 
[ 0.995938][ T0] ? handle_bug (arch/x86/kernel/traps.c:337) 
[ 0.995938][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:391 (discriminator 1)) 
[ 0.995938][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:574) 
[ 0.995938][ T0] ? do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:118 (discriminator 1)) 
[ 0.995938][ T0] ? __pfx_do_clear_cpu_cap (arch/x86/kernel/cpu/cpuid-deps.c:109) 
[ 0.995938][ T0] ? init_ia32_feat_ctl (arch/x86/kernel/cpu/feat_ctl.c:189) 
[ 0.995938][ T0] x86_init_rdseed (arch/x86/kernel/cpu/rdrand.c:85) 
[ 0.995938][ T0] identify_cpu (arch/x86/kernel/cpu/common.c:519 arch/x86/kernel/cpu/common.c:1922) 
[ 0.995938][ T0] identify_secondary_cpu (arch/x86/kernel/cpu/common.c:2014) 
[ 0.995938][ T0] start_secondary (arch/x86/kernel/smpboot.c:199 arch/x86/kernel/smpboot.c:283) 
[ 0.995938][ T0] ? __pfx_start_secondary (arch/x86/kernel/smpboot.c:233) 
[ 0.995938][ T0] ? startup_64_load_idt (arch/x86/include/asm/desc.h:215 arch/x86/kernel/head64.c:549) 
[ 0.995938][ T0] common_startup_64 (arch/x86/kernel/head_64.S:419) 
[    0.995938][    T0]  </TASK>
[    0.995938][    T0] ---[ end trace 0000000000000000 ]---
[    0.995938][    T0] RDSEED is not reliable on this platform; disabling.
[    0.995938][    T0] Masked ExtINT on CPU#5
[    0.995938][    T0] Masked ExtINT on CPU#6
[    0.995938][    T0] RDSEED is not reliable on this platform; disabling.
[    0.995938][    T0] Masked ExtINT on CPU#7
[    0.995938][    T0] RDSEED is not reliable on this platform; disabling.
[    0.995938][    T0] Masked ExtINT on CPU#8
[    0.995938][    T0] RDSEED is not reliable on this platform; disabling.
[    0.995938][    T0] Masked ExtINT on CPU#9
[    0.995938][    T0] RDSEED is not reliable on this platform; disabling.


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250321/202503211421.fc83271a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


