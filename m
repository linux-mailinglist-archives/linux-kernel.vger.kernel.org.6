Return-Path: <linux-kernel+bounces-365258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7251199DF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CD9283DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F35D1C3026;
	Tue, 15 Oct 2024 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJMyKpEE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BD218BBAB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978458; cv=fail; b=Rt/ZXupaXYscHXXOjN8E09Ej/0u/PnLDogkZhR5GT7vZcLfv0tdSCph0fq93qNWOUUwkVnpzK1YTauGeKBQM/do6fCgnZ5pBQN2ewqUPgEzb/ttsy35k1+xjYtBFjrlMH4mvwsf3MJDNfamKiEnwHNGfpg5u7EKYcjSTt3UU9gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978458; c=relaxed/simple;
	bh=G7MWytRG63tmiCaSK1VY976Qx40ubo3iWSJdbESuke8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=quG5eOnS9y0MabHYyy6AWbzciyshKJ63UbvD+Ap2XqlQNe5MMo7S0hqmfbSTMVJXWk1cm65Y+ULUHrhxOU3uxh+f5nUF4ZotVpLiK1Ah//kxPRjNq26L43aXCRjFifcuqnByl+DOgZMOmvr++Qj8gMzH2ggFqdqpFp80u+AeZNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJMyKpEE; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728978455; x=1760514455;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G7MWytRG63tmiCaSK1VY976Qx40ubo3iWSJdbESuke8=;
  b=EJMyKpEETImCBIJqDAsF611PBGoaT1YUp0FUGCHo1FcNq4tDc5thTtiL
   1wBufdZbdoyGzei5bfOskQFGibeeCcIge8J3Q62Wudbmz+qPko7G/uuEF
   lsrl36VTTDVYRzmwrQWE0R9uWzjnsk9Rzz2JPojnqNN9GXV3+f4ug2ql8
   WkzLBkG8eqGSNph5wZ04uV6SRpoTj/r1Y6rC4Y9S1U7+Bn/r+JTFALzaX
   S4t3vbTe/Kor0Q6vD9KK0288CHp9MgT680QVsgyRkIaYyaWi+nqCmXpnp
   0RZZempKlhEchhlnCDPX8o6r+OTwVnrlF+Pl0DvzW6/lfZ2BgcNyr4kzT
   g==;
X-CSE-ConnectionGUID: nXoFk7wqQl+cuiDB6Mj8Ew==
X-CSE-MsgGUID: A4dTrHGuQGWgbzT6ObI4ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="27801149"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="27801149"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 00:47:33 -0700
X-CSE-ConnectionGUID: aftg1EulRCSnXgLwn8e4Mg==
X-CSE-MsgGUID: vz3znwfhThyjFuZSM4/Czg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="82854511"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 00:47:33 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 00:47:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 00:47:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 00:47:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 00:47:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rt4G3W6jzcEGJ49VUnVLT5FphoHK+bvgakyODkwDO7B3DK+xWAK3YypM7fF+SkbsIco6WsWIiohospM+Soll41BT71qnXTjzlv2KO38MP4D1wtjOV0ySl6T5EF0ek9xZOwbiLkTjVEiTlNYaQvYyOGLyd+H4KMRC1ZgKWTe8Lzwa53nnwfoloqeK+N7+midbewCMsUzlyqzY+DCLDEsj9IMF24rbOXktKkdgew2tmbpufStG4dry6EmsU7y2M0ssrRM4Trhr/Tlj1dwRXItowFlG/Ymd30LNP49fHrU/Y+WQE/wCquszyM/49TGzoo9AmxE63/Gl776CmL4NfENRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xo3edAaLVXw2FIrfzio8EBrJChUNJ1jDk+YMR63WOSw=;
 b=tawZNfqDCyyUL5TfigBXEO21uYrF0gFUFrx+CSnvuZKI0B79Ou2eWu/9XqWfQ9KesbIs7MVHQciG/2qhuNDSC8HCaqnq2tgwwU0qQZ4kRIAF353UHtTuA4HLJlk90QpHeGLMpmdo44ll6BCm9aAxg7Z9TLFyaPKMzIViRMGfwz18FAqzGB4Pb4IgDL6wou6BvrWNMJkhZMei5wxFySSEtLgwLLR3Pja9L+4NWkXP0j4M6/7iov6S4Oon+TS+J/GFpnwIm6W3bq5usRDjPuJpFbj3GjYmo9MlSNiOd5O9CADK+EwN+a2TxdjTU6C4cxmoyKziJUHLXbIJjQYhTrGu9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CYYPR11MB8357.namprd11.prod.outlook.com (2603:10b6:930:c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 07:47:29 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 07:47:29 +0000
Date: Tue, 15 Oct 2024 15:47:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [peterz-queue:sched/lazy] [sched, x86]  74d850cd4c:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]
Message-ID: <202410151544.7d2292c6-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:820::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CYYPR11MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ae77e8-4dd5-457f-aa57-08dceced9eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oksP55VNXGPOL9kuTAraFmPgZzpCAiV2jucWynV2WUEKrrGryEwu7BxpBZNb?=
 =?us-ascii?Q?MjYAwioZ6DKcZdiPv6bhNnb4/a3t+lnCCBIt8Fnfp9XWONZ2X0BU5YN2mGHJ?=
 =?us-ascii?Q?t3EVasR8X/l1yRRGum6mE+BUlRUDYE2lK3fKL5KClet7G/vpztXjZXZbTEN4?=
 =?us-ascii?Q?X8qMbenwa3s/aKDyStQ6wbQbW66nNTRBr1gM2rLDw8UsWIwdNKdCtk68nWuJ?=
 =?us-ascii?Q?XKjOAgcSG41EMOOalcnQphKEWkX2cGFkhRPrFz2hyb6mZ1OTrqnJcEOGW0fX?=
 =?us-ascii?Q?TC29IesYlsYNACeT56QWlHP0DAeqPVvI+ceGptOnXm+Fg8cdkDe/Rxeb5kC3?=
 =?us-ascii?Q?EVK9Cyi47FSAGksW96l4UtTE86x5HETjMtza2x1zbVBk+4FBUBtDbHx2a8nq?=
 =?us-ascii?Q?UIDYG3IisUvusUn16AovVogDMFE7oMYNyVtCpF3EoiFwdlVRUR7rHHgL7Ac2?=
 =?us-ascii?Q?knFeKJNKBk4lix9cljKp7s1DATJRFJlMWGNjjWMI46iYvojjwlZbQWM2GWbx?=
 =?us-ascii?Q?/CdlMKt7Ti8eKqnube1N8RhoAXB5qtZqAI2ifG2BuuWtt0xNUNeiZNKnzMf5?=
 =?us-ascii?Q?rxXGN3nHkq8ZfpqOYQgq+T8UATyuLPDzsWV0SKQytoDLM2arR/QKgGjuITXI?=
 =?us-ascii?Q?4+IjvpxFOxCcz3zOlu08EYEMmA+NxEVNe1YftdjSQ1P9oNgwqoaLa7WpVL1c?=
 =?us-ascii?Q?fVO0r2L8/fCRJt4aOswXXz1ZfcoTNm84t5gyDKDIVX03IgHxkO5mBeogMJL2?=
 =?us-ascii?Q?bkaWiYzq2v7zprV5KnC52hjOfNDVNXa3TuR2v2e/aMoWTbmmn7db/kVZI1Mm?=
 =?us-ascii?Q?IxbRX9NYOTofBXGXnQqg2xUv/wJNjMl+CZeCsJT/HtWMRlso2xs3xwh+BvsT?=
 =?us-ascii?Q?oJ7CefCi7QbMmX31B44RnUVZMhtETgVUb7nvhPsVFhp4TUD7XbhTAOkaeZgj?=
 =?us-ascii?Q?vU/oa1hDMdrrotjLSOsl/32AGE3BRMOrpjHdzxxtUoxDXM+BZuyW0MvPLh+X?=
 =?us-ascii?Q?mEY1Ctj2DU8lRSohZgMI0R3w+mqk8DqGhkF2rC+E6MgpSHMOQ/HRxYv2/HyN?=
 =?us-ascii?Q?tGprHbwb9LoqJkefnM5gCbMMr+3tSFpdok7HINyIEp9L+S+G73wd7UN25j/i?=
 =?us-ascii?Q?sQLcO+hTr+ZzjjKtX9b8IFjncZBB1pnbvqPLXJT2W6HVFkYar5D38TWUTNef?=
 =?us-ascii?Q?HIxW+tXjdV1862Dp9K9++IptxWzA+X3DFOaD7aSbid/icVKTgADr/1Cc3xk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wNllrM3jzrHXr3Vm7fqPD4GcEVJE4eIqlJqUtpWEdw302862yU1mYkHTrBMH?=
 =?us-ascii?Q?gn8ok7Ioq1qOmtF5778R14A9AxkgPJisK9XsQfSDGyHzEvQcbnOMjC9fpVHT?=
 =?us-ascii?Q?Y+2+G1HwlCfXC/4vrAPWEoKKNlgz52cvtKvQqbguc8ocq08eMgLW2N/W4mKU?=
 =?us-ascii?Q?p1Zkd2blAEpUwRH5ehtxfuuv60ssnWZSff3V7S7yCvfX4FxyZNFw9+bwatWY?=
 =?us-ascii?Q?EV1VwATRWwkeEd3y5V1iLCfYht3az9lPbi0Fr2ZMjJa2DcEoeyGnOOPhmf90?=
 =?us-ascii?Q?HwhZgDYLOf9E+PxxHtzMeoAKg7nfBJMcJBeJ70ryuo4y6TrMAg+v38jWzexO?=
 =?us-ascii?Q?T5SYHimBoR26GM2idd6Lj1ehqTmYHG3bvfz1jCJ2nrgSxz7GtwVqNYVCySfa?=
 =?us-ascii?Q?DWm4+dHvD66+y6Rg8klXNT/bS5zCgyL4Wuv5nm2kcwSgAgKBAOndpsIgRVIg?=
 =?us-ascii?Q?KilRdbWvZ0G+ulUU6ZlxFiIC7a0jRn6ZM23OE356OKVnMyhjwqB4f9qhXtqc?=
 =?us-ascii?Q?/LMeIa3tMhkhyA67AOHtvBMXzMLAgkI08J9Q0CKEtWWVEOOgSnC01IoWLH46?=
 =?us-ascii?Q?Y1owQdrFBVQ9i/6WnJCT28kcg9Aplc43GlXtDdxcrbksXtyRLDHh0qqHnoN1?=
 =?us-ascii?Q?XW9Iq/D9dbGAvRCCoJ0ISjVglFgHt4I4mZIdrYtCTi/sxybLW0f1yYb+U+sf?=
 =?us-ascii?Q?que9T8BGZ7jo6VxII/RzIlHEAQoqJkWunD8SMWf8UDo6A8zr35bxmLmfxCjf?=
 =?us-ascii?Q?bbdGRCNdOnxuPki6gO1cVFr9DWbNi9ySLtnIy9OaNOLq0rgmd7uUXCr2YPY2?=
 =?us-ascii?Q?j02ZnqCbJ6VXCefwZOUSS/IRuDXuq6eoMiFno/h7D/2lQK2hpiqCM+/Gtwpk?=
 =?us-ascii?Q?0Zd/qn/t7WYXGfuoSZfOvnnT+C5/A+JrwVz4Rik/YFk3XG4oPbkw7rTBhHOP?=
 =?us-ascii?Q?Ws1Qa/fTMNEb2edeEHQMOdOMvu1uF8W8OcGE/lBKqrZrSWr8goMBG7TPsP/J?=
 =?us-ascii?Q?d/h8pi2HefL6UF/pnSMWNWzj6yvdVyTs88D0oQgroMfS5wD1M2twPjc6ZHgp?=
 =?us-ascii?Q?qKdnE6sOpR5QjTdA8Se94/m3duUNr+bvUhO2hmlAC5KPTcrBqg0ZeyatVtBo?=
 =?us-ascii?Q?LIvINmp2AMwZ6N8AmEeL5WWIh7WH68bHHnV6O08R4GaRyBD96+BlAX/znFv6?=
 =?us-ascii?Q?Q37aLXvARSCWkDLihYdX9scvJb4SsYXcMu/dCGUyAEtE6/cUHZNvN6lWiHlg?=
 =?us-ascii?Q?PEw3WBCzytnfCY248qqHy9cIGT9vpJ5Q9tR1S5Am2fX0Vy/yoa+tBFhpM3yO?=
 =?us-ascii?Q?t65crPB6i/uuWpflpdpKRXCqTPcAhc3rnSIwkMty5Hq4vC4CrIwDcSrguFp1?=
 =?us-ascii?Q?+rbW1xC5hXFSownvw8J1TJuHOqbFLshNiky88QwRzTWZClAcnckj8kbgqCNd?=
 =?us-ascii?Q?G+KHDSVKeyhAXFUMJS3SiQn7qA8pqfsan9h+S4CAG6+CJRhiohp1K/Oby/H9?=
 =?us-ascii?Q?hzT1IQaBH9gxxWtXtQvybWB76OJz4gYj/Tadw0bAUQY965UmDOG/CYYX9Nub?=
 =?us-ascii?Q?9Tjbyd6lsjXsO3Lf6zW20Ok+N72LH9FKKRcXCQrZlivDiIARtR6LiUnnAJnP?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ae77e8-4dd5-457f-aa57-08dceced9eb0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 07:47:29.5095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dd8MKiuMb+c7mTC9L0Zes2oZq7yXtIzDpcgYK78nuxYdtbsF74e/bcODLGuY58qxWrfLQVhz9XnqzGggTCnSLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8357
X-OriginatorOrg: intel.com



Hello,


with this commit, we saw below config diff between this commit and its parent.

--- /pkg/linux/x86_64-randconfig-014-20241011/clang-18/693ed5cdf46ac062aa7713700c77019c60f0ae41/.config 2024-10-13 05:54:47.077017686 +0800
+++ /pkg/linux/x86_64-randconfig-014-20241011/clang-18/74d850cd4c5bc26ce83511b4247ea786eb73217c/.config 2024-10-13 05:42:38.439123587 +0800
@@ -120,9 +120,11 @@ CONFIG_BPF_PRELOAD=y
 # end of BPF subsystem

 CONFIG_PREEMPT_BUILD=y
-CONFIG_PREEMPT_NONE=y
+CONFIG_ARCH_HAS_PREEMPT_LAZY=y
+# CONFIG_PREEMPT_NONE is not set
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_PREEMPT_LAZY=y
 # CONFIG_PREEMPT_RT is not set
 CONFIG_PREEMPT_COUNT=y
 CONFIG_PREEMPTION=y


and below reported new issue is not observed on parent.

693ed5cdf46ac062 74d850cd4c5bc26ce83511b4247
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     dmesg.RIP:rcu_torture_stats_print[rcutorture]
           :6          100%           6:6     dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]


kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]" on:

commit: 74d850cd4c5bc26ce83511b4247ea786eb73217c ("sched, x86: Enable Lazy preemption")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/lazy

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: busted



config: x86_64-randconfig-014-20241011
compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410151544.7d2292c6-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241015/202410151544.7d2292c6-lkp@intel.com



[   98.006999][  T543] busted-torture: rtc: 00000000639e821e ver: 6796 tfle: 0 rta: 6796 rtaf: 0 rtf: 6787 rtmbe: 1 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 89 barrier: 0/0:0 read-exits: 64 nocb-toggles: 0:0
[   98.017386][  T543] busted-torture: !!! 
[   98.017662][  T543] ------------[ cut here ]------------
[   98.019330][  T543] WARNING: CPU: 0 PID: 543 at kernel/rcu/rcutorture.c:2258 rcu_torture_stats_print+0x24c/0x610 [rcutorture]
[   98.021831][  T543] Modules linked in: rcutorture torture
[   98.022825][  T543] CPU: 0 UID: 0 PID: 543 Comm: rcu_torture_sta Not tainted 6.12.0-rc1-00037-g74d850cd4c5b #1
[   98.024497][  T543] RIP: 0010:rcu_torture_stats_print+0x24c/0x610 [rcutorture]
[   98.025764][  T543] Code: 9e 00 00 31 db 48 c7 c7 a0 ab 01 a0 44 8b 35 e7 9d 00 00 45 85 f6 0f 95 c3 31 d2 31 c9 89 de e8 9a 60 22 e1 45 85 f6 74 04 90 <0f> 0b 90 48 c7 c7 d0 ab 01 a0 89 de 31 d2 31 c9 e8 7f 60 22 e1 44
[   98.029027][  T543] RSP: 0018:ffffc90000e0fdd0 EFLAGS: 00010202
[   98.030159][  T543] RAX: 17b05ce78fe5d400 RBX: 0000000000000001 RCX: 0000000000000000
[   98.031464][  T543] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffa001abc0
[   98.032751][  T543] RBP: ffffc90000e0fed0 R08: 0000000000000000 R09: ffffc90000e0fb98
[   98.034230][  T543] R10: ffffc90000e0fb90 R11: ffffffff83caa080 R12: ffff8881423b6100
[   98.035585][  T543] R13: 0000000080000000 R14: 0000000000000001 R15: 000000000000000a
[   98.036942][  T543] FS:  0000000000000000(0000) GS:ffffffff83c8c000(0000) knlGS:0000000000000000
[   98.038435][  T543] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   98.039527][  T543] CR2: 0000000000403034 CR3: 000000013e05e000 CR4: 00000000000406b0
[   98.040903][  T543] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   98.042278][  T543] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   98.043632][  T543] Call Trace:
[   98.044195][  T543]  <TASK>
[   98.044690][  T543]  ? show_regs+0x5d/0x70
[   98.045452][  T543]  ? __warn+0xa6/0x270
[   98.046168][  T543]  ? rcu_torture_stats_print+0x24c/0x610 [rcutorture]
[   98.047349][  T543]  ? report_bug+0xba/0x160
[   98.048112][  T543]  ? handle_bug+0x55/0x80
[   98.048860][  T543]  ? exc_invalid_op+0x1b/0x50
[   98.049716][  T543]  ? asm_exc_invalid_op+0x1b/0x20
[   98.050675][  T543]  ? rcu_torture_stats_print+0x24c/0x610 [rcutorture]
[   98.051846][  T543]  rcu_torture_stats+0x29/0x70 [rcutorture]
[   98.052839][  T543]  kthread+0x18f/0x1a0
[   98.053600][  T543]  ? rcu_nocb_toggle+0x1b0/0x1b0 [rcutorture]
[   98.054607][  T543]  ? kthread_unuse_mm+0x150/0x150
[   98.055432][  T543]  ret_from_fork+0x46/0x60
[   98.056167][  T543]  ? kthread_unuse_mm+0x150/0x150
[   98.057066][  T543]  ret_from_fork_asm+0x11/0x20
[   98.057974][  T543]  </TASK>
[   98.058501][  T543] irq event stamp: 421
[   98.059184][  T543] hardirqs last  enabled at (429): [<ffffffff811670db>] __console_unlock+0x7b/0xd0
[   98.060748][  T543] hardirqs last disabled at (438): [<ffffffff811670c0>] __console_unlock+0x60/0xd0
[   98.062437][  T543] softirqs last  enabled at (0): [<ffffffff810eb6c6>] copy_process+0x626/0x13e0
[   98.063962][  T543] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   98.065130][  T543] ---[ end trace 0000000000000000 ]---
[   98.237025][  T543] ------------[ cut here ]------------
[   98.238052][  T543] WARNING: CPU: 0 PID: 543 at kernel/rcu/rcutorture.c:2263 rcu_torture_stats_print+0x373/0x610 [rcutorture]
[   98.240000][  T543] Modules linked in: rcutorture torture
[   98.241012][  T543] CPU: 0 UID: 0 PID: 543 Comm: rcu_torture_sta Tainted: G        W          6.12.0-rc1-00037-g74d850cd4c5b #1
[   98.243089][  T543] Tainted: [W]=WARN
[   98.243770][  T543] RIP: 0010:rcu_torture_stats_print+0x373/0x610 [rcutorture]
[   98.244991][  T543] Code: d2 31 c9 e8 8f 5f 22 e1 31 db 41 83 ff 02 48 c7 c7 80 ad 01 a0 0f 9d c3 31 d2 31 c9 89 de e8 74 5f 22 e1 41 83 ff 02 7c 04 90 <0f> 0b 90 48 c7 c7 b0 ad 01 a0 89 de 31 d2 31 c9 e8 58 5f 22 e1 48
[   98.248211][  T543] RSP: 0018:ffffc90000e0fdd0 EFLAGS: 00010202
[   98.249268][  T543] RAX: 17b05ce78fe5d400 RBX: 0000000000000001 RCX: 0000000000000000
[   98.250758][  T543] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffa001ada0
[   98.252089][  T543] RBP: ffffc90000e0fed0 R08: 0000000000000000 R09: ffffc90000e0fb98
[   98.253480][  T543] R10: ffffc90000e0fb90 R11: ffffffff83caa080 R12: ffff8881423b6100
[   98.254886][  T543] R13: 0000000080000000 R14: 0000000000000000 R15: 000000000000000a
[   98.256171][  T543] FS:  0000000000000000(0000) GS:ffffffff83c8c000(0000) knlGS:0000000000000000
[   98.257778][  T543] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   98.258942][  T543] CR2: 00007fdbb4f90000 CR3: 0000000140b89000 CR4: 00000000000406b0
[   98.260150][  T543] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   98.261503][  T543] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   98.262832][  T543] Call Trace:
[   98.263391][  T543]  <TASK>
[   98.263916][  T543]  ? show_regs+0x5d/0x70
[   98.264654][  T543]  ? __warn+0xa6/0x270
[   98.265377][  T543]  ? rcu_torture_stats_print+0x373/0x610 [rcutorture]
[   98.266551][  T543]  ? report_bug+0xba/0x160
[   98.267331][  T543]  ? handle_bug+0x55/0x80
[   98.268055][  T543]  ? exc_invalid_op+0x1b/0x50
[   98.268841][  T543]  ? asm_exc_invalid_op+0x1b/0x20
[   98.269772][  T543]  ? rcu_torture_stats_print+0x373/0x610 [rcutorture]
[   98.271002][  T543]  rcu_torture_stats+0x29/0x70 [rcutorture]
[   98.271983][  T543]  kthread+0x18f/0x1a0
[   98.272660][  T543]  ? rcu_nocb_toggle+0x1b0/0x1b0 [rcutorture]
[   98.273784][  T543]  ? kthread_unuse_mm+0x150/0x150
[   98.274621][  T543]  ret_from_fork+0x46/0x60
[   98.275361][  T543]  ? kthread_unuse_mm+0x150/0x150
[   98.276189][  T543]  ret_from_fork_asm+0x11/0x20
[   98.277038][  T543]  </TASK>
[   98.277611][  T543] irq event stamp: 811
[   98.278304][  T543] hardirqs last  enabled at (819): [<ffffffff811670db>] __console_unlock+0x7b/0xd0
[   98.279844][  T543] hardirqs last disabled at (826): [<ffffffff811670c0>] __console_unlock+0x60/0xd0
[   98.281441][  T543] softirqs last  enabled at (0): [<ffffffff810eb6c6>] copy_process+0x626/0x13e0
[   98.282929][  T543] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   98.284155][  T543] ---[ end trace 0000000000000000 ]---
[   98.466994][  T543] Reader Pipe:  49418 0 1 0 1 2 0 1 0 0 47
[   98.468093][  T543] busted-torture: Reader Batch:  49470 0 0 0 0 0 0 0 0 0 0
[   98.469346][  T543] busted-torture: Free-Block Circulation:  6795 6795 6794 6793 6792 6791 6790 6789 6788 6787 0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


