Return-Path: <linux-kernel+bounces-262361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4595C93C575
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16A91F23F89
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4365319CD0C;
	Thu, 25 Jul 2024 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1c623Ea"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690ED8468
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919101; cv=fail; b=Rr/ect+uo4e486lf4zW/G/MpVZmBC2/nANNS0DF8oq3kBLhMvk6UK+nuhYZdz8G98Y614UR8w4Ag+Mi3VejaoI93/MT34MgO1vsCJjgfC7goz1b5EChMc8dwYPSAwmVpKfhzrkzJD6WPdLXfPJR7DIXpLYDJE+Ncb2qji3HCJCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919101; c=relaxed/simple;
	bh=NsCazgiS7P8TK+sPXd/bRn7nyuD+DdKLIITP+JomTnM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f2XvE3vkFs83ggFYxWKGEO4IK+Eeiq9vWPjRiBaaoZTCYRdVinvqGOvtpVWfsKytt7Rl0dvchC1+Bgo8zoSpUk5raWZ+Cotj+3anuebWUMpeENkNFH5onhrZM60WZkdVtZ0+xK3KC0FyrN0fMO9Ro+I3Y7BYrWnATcywupasZNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1c623Ea; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721919100; x=1753455100;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NsCazgiS7P8TK+sPXd/bRn7nyuD+DdKLIITP+JomTnM=;
  b=J1c623Ea5HTrGa1JapDEdUJzw9aOZyGnAGEife2LndLWMLWfHcSmZZ6O
   lTQeeL7FqrlrqGcvnpSlTGMF3rYKnj4bU1ycs4geLCacB6DfC1c8rD0Fy
   a4da1QhUv4ewnnl1rM1rhXUJRJeHaDQrslzcliyojxZFdafbBzHXGi0x7
   6Mt1JfoWB9opQz8xgYKFlR8h4gHjE7sXdZeJBHAoTV888hFBQ57K0jmcs
   i4cLrR1gUBTvz8d+IlFNFR5asgW0GtthTKxXNY5ldsjSXJ2ps5ImLRxS4
   A4lGmSdYgu6AaNBU1oTzJd5YDQqL5don9SVtxhxN6vu58CEb0C3rvLLqf
   Q==;
X-CSE-ConnectionGUID: bnrhjiYIQdq7FHff1++QnQ==
X-CSE-MsgGUID: LcaEvnnnQWqWQOwAm0ZTXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="45083690"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="45083690"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 07:51:39 -0700
X-CSE-ConnectionGUID: eAbgdRL1RKa2vECgO4OQ7A==
X-CSE-MsgGUID: zV4uv9vWQTejzLGNq6huPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="53568034"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 07:51:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 07:51:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 07:51:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 07:51:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 07:51:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+mqYUPr26n89u9go+7zm+2fc8tTwtzfusdA85vZ4dXfBjjDVixN544iS/9F6Kb9gqGLa3XNWlpxqR1h12MvyR928Fx63GElnQOLpvKykvNF2q45EfogEWsu0rsZXfyrmecE0n84U8DW5Jet4rsVVde8RiGdGUy7Fgczd56MAMPcuCWaeYgdU63+LUXZyEZ9mAtfFHftLIKUk+l4EmuqdTDogoxd9TP2tY7ne5C6xiKbmZN5RNXSiOSjUxKwHo21uIP0/C7rMUTJk0svZK2CDkGq9d5CuggvZPD0qW7xB8WaJuqArRYSNVIfJJQW4n2SpcFA2koTofR2ifAy07bo7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atRrjZVKbR/F954P4aJTOdQzHeyGnGk7Ic5q2W8LiIQ=;
 b=KfXJiNnOakoGNjEFXQxhflgGfxSVguNBzPpVerwkzI04I185VWm/gvn92yyPoLnk0e6VfTDXFbi0WnRangKBgtjiIwR9G/6b6+SImNJlWjsq0Z4HjHYQa16Jy3QMiWDb2TAlTe50sSNj8Yx4gEratJf5GYdOrCRNn6+T5+Ks314flCQ9Fxd2vMziMGSp1e8RXrNUHtF79/kpE5CUchHJbe4kA+Hafcu1K3MUiM10U4iTlYsGdf0Us2v6QP6hUvFmYPBr4YKCN5KFKmSS/Nl8dKsPss+KkoYVCbBbmuYUh7hOaERG+R9qLYR9Qxh1aEcjRcEWq9/1S8+C506Cp+V+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ0PR11MB5893.namprd11.prod.outlook.com (2603:10b6:a03:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 25 Jul
 2024 14:51:33 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7784.013; Thu, 25 Jul 2024
 14:51:33 +0000
Date: Thu, 25 Jul 2024 22:51:17 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Hongyan Xia <hongyan.xia2@arm.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Qais Yousef
	<qyousef@layalina.io>, Lukasz Luba <lukasz.luba@arm.com>,
	<linux-kernel@vger.kernel.org>, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] sched/pelt: Use rq_clock_task() for hw_pressure
Message-ID: <ZqJmZdZtwQ4+A5hj@chenyu5-mobl2>
References: <20240725114200.375611-1-yu.c.chen@intel.com>
 <38a631cf-1f6d-4d68-887a-12c7c5808ebf@arm.com>
 <ZqJafRf/fM/whI+6@chenyu5-mobl2>
 <1152aa46-281a-42c1-bcb1-42aee8fa9368@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1152aa46-281a-42c1-bcb1-42aee8fa9368@arm.com>
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ0PR11MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b08bef-f427-46a1-262a-08dcacb9467f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lqdSv9hdYjkvWqDH7w3qWoGVaRynUjqGIr4vg+6MfvQWAzuxyWrzZdadqzGs?=
 =?us-ascii?Q?3TC+7lSrTAfmZliKtqGATHW1I2dYRg16IzExWM7GEu+rvc7VmRjeGJEpgUxF?=
 =?us-ascii?Q?cePD9bu/XOoKCyU1aGsN2PeFvQE8X04YK2j24bVnMEdk94fOoj60on8KBlBw?=
 =?us-ascii?Q?zj9QqxasTqM+61T/MPccOK6bHTlFdull3ZCnfuhOYfCuc1dKFzl4ZyfCRdC6?=
 =?us-ascii?Q?EpEcL9o1uVS281dweTXT3tdp0iYr5oXWeSQC4lKGcmV92f2AwSm61MlF27fJ?=
 =?us-ascii?Q?WBjYuFKZVYHiSD3EW2XpjMX7fm6CvreeA6SZtorAswHaAdt20VAS7szwZHOU?=
 =?us-ascii?Q?T8Hj2KRt4T02xg0iA1KUecOAHMt3fwTMXQ7UbBfvQxo09XECTWl8Ow3GJbxj?=
 =?us-ascii?Q?XtoFLBoAXFlxXlbDec76KOmSedQoJhiI7THIw7vvtCug9Py5+eibTPt7R/Nc?=
 =?us-ascii?Q?0mabIS9UDC8sWpKKVi6rybbQUH/42+0zoQCW9XVIMpMrEZtcMwxsWyxKVe6Z?=
 =?us-ascii?Q?yS1Rud8ibrVKQwbCgaRGU7FKiHhrvVkcn7+iTyO/TjNEBSaySlZ46o/b0qyY?=
 =?us-ascii?Q?1F6hx7fCANIEYhitwhwFvk7+oNbaqJugGHTgx3vk20zH3Peq5PmvSXwxMh4G?=
 =?us-ascii?Q?N82L7pJTAIXFYvFnjdTuTeAoDSTlmNuFRIid8KIavslNrLin+xSK9pSQEDmN?=
 =?us-ascii?Q?GhPnrUEh18YwsFa2abpQTSw0z3shysLvYwzhPd7oMKZhiOxiPE1vIp/rlKdd?=
 =?us-ascii?Q?qinsyjyz0Nga7Tv3vooxIbvXyWldabKFLYFx10wWNvzSzSbjAW/vwhbaz7Q9?=
 =?us-ascii?Q?TSCTTEeketEYtdSc88nb93H1EqtXMUI48QD7ey6nRFSlFk57AyinH47N+Jgi?=
 =?us-ascii?Q?qkRXoZqGo9ZtZ71YW6tpcgdfkhRQBtyB2+qOqTSC4w0cF0jGS7r5v5tKBQXz?=
 =?us-ascii?Q?0hkq1qy9rYFwtF4Lc0pQuJlSUXtDzXzCouHJ8lz2qcO6G1lKIcKxf7D2MDC3?=
 =?us-ascii?Q?SubWzXKZw1JdP9vE0T7TjFo1L2OvdGyyabnADwAXPICm2n6GVQSMPT0/o40/?=
 =?us-ascii?Q?hxCFL9JHfzIYnv5HSKwgC6BfQpWpk8yyrKYQ9/et7OdjAAkqB63IxYDrs2Pd?=
 =?us-ascii?Q?qW/2ZPt6r8XBUgi8FayAYvAhguOpQ75PtD6ShijJLbV8QB8wL84x4hYNOqIj?=
 =?us-ascii?Q?zgrQk990whgjYxYWiZhGBoMM2wQOubVamosVwmYl+7wWFydg1d06RFSWaoZc?=
 =?us-ascii?Q?y3MJAEvyKHCFw1ygGA48fwoDcvE3HHGG3LlaI+04VD/Q72EzBGXeLcHmsc4n?=
 =?us-ascii?Q?pRE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4a96XqKmI/0vjTHik1aPKK5DsVMikmUfZfG6axXTn60X5gaoHzbKDaydB7fl?=
 =?us-ascii?Q?1j2UHebAYSCwdu4+7DBHZ0Mj7yKJH9MUAWf82zJuZGedPMU8S01eZ8vSJMlY?=
 =?us-ascii?Q?0p1SvqN5E2K6tHMvCoCisPLXPeovRFpmJXbuk6nbAL8k5+9mU9YRuo/uRZ+T?=
 =?us-ascii?Q?lzohtl8a6wzGlQ/dDDiBk8mxRj4o5YC4UBPKZGVNSv15keEONCBdz5/Kpwox?=
 =?us-ascii?Q?iEFFZNaUgMBOJwO/dN+jmQNwISk0UXQdyGE9ECuCuVZJaENOozIUEvgO0Lvh?=
 =?us-ascii?Q?F/29uCKe/okfSTRjYrAFKedtmapDF1pmAysUgD2G7I1eoj0sVuWVa37e9WjK?=
 =?us-ascii?Q?nf2ge3HB/4GPfupSJWZ+IrWLM2uEF+NV2o92de0KmGn4O4JBcVw2DllpR4Gf?=
 =?us-ascii?Q?oKd0csL0r3xUaZJeL0L8sjZP7UqhOdKIQnWrrOlEgjwWTpbR9eb7gZMzxDdc?=
 =?us-ascii?Q?CKopHGgQfd5zdIHR5ay3+GwT4sU8NUsQ2hvG5ePUVJ9HFIIGds8RITDVLcIq?=
 =?us-ascii?Q?q4mCRKwfQtLLqiS7L7uaBFuhdhO+am/Gf2p/u8kOPYi61uIO2/5Ts1JN+wnF?=
 =?us-ascii?Q?9YxnXRwu+pEW7dOXyIBfa2U8RfZaVdzW4baFxF8FBkXA6Va2PsyvCs8m4g9G?=
 =?us-ascii?Q?qusIbvRJGCMRgpuMjJHaLsdh09q9CqF0Tssh1rkkCfRA8d1+pNncM1WQWkf/?=
 =?us-ascii?Q?n7EVcVnZvHEsjXIP5Kwuy59CDgdb8q3OIPIfe22pDBm6k+0jPe+TvwRBewLY?=
 =?us-ascii?Q?cR5DJtJT23LrgB4gmguRN+6Ky67+FeA/ks3SyGMnsQs7WgUGaOwogSKU+Qpg?=
 =?us-ascii?Q?0AZiw8DP5lKDvnnQsBO3qagNNIfh1Kc9O+GJg5ZTd3Np0CCmQsaMtyvVH7Mw?=
 =?us-ascii?Q?4YUklr1xOMtfK721UHeHKL6WKh/i5p3ny7wL/gQjyCaUx/oIYoyvYl8f+iJ9?=
 =?us-ascii?Q?AgK+4g12Y9MEuewt6LBZzIRbQdpqncT1RqPLCxKjw9Vl5aZhCHDfuEKCObYs?=
 =?us-ascii?Q?j3V1zj5K7vYiye5NZxJ7kXctJtmwvf7k8OtEPPEYkWD0TZQ61ogcLOjlIOV+?=
 =?us-ascii?Q?0TuRcJQp/dIg+B7cbqLli7SCtsJCINi6ASLzBnd13a3jjbZaHTwKiozVSMuR?=
 =?us-ascii?Q?JTrraLMi9nLDplpziLPOMEvQ1cq4VSUbJjJDD4u2YFIwCgy9DTZRd0uSykNG?=
 =?us-ascii?Q?N/JBcpwlwNEwc4W5plg+wQnr+T7691BNh/XQgd8OaRhWOuoE+/Lo0nI4ab2m?=
 =?us-ascii?Q?gdYGj5UoEu4Ni2kTg4rJsiyX4OZF9fWZBVb2GdQdvfDeTeGpTlDix+WnuWUb?=
 =?us-ascii?Q?k7R/PFbt4sPDF4ZfTdQemosxQwf2G0V73KsrbVWm2XuFyGdRGJWT4RH9Yw6O?=
 =?us-ascii?Q?AbJQmPD+x4Bn/4I2Byr+PSWg6wgaEDbuiwsMhgaFiPIQHerrkDCMwgz1/pl/?=
 =?us-ascii?Q?1k0u6KFijDO8T4aj8JkzcydOtV5hGJzy9QLyMBNOkWhymmTokBR0oaHVGV51?=
 =?us-ascii?Q?LsT90sNB62KgjE8/3IFdUcozVIv/hQPZBqZ4C4K5pwnj5nNdiG5U+tMw1rw+?=
 =?us-ascii?Q?mFO3+plJMn7k8af8OdpSrpN0Mx1kwNbztBwjQwmt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b08bef-f427-46a1-262a-08dcacb9467f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 14:51:33.2542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wd1cLtsOv6OI5RWhLH2GupJPBOH5swvt5p0wjO33POsnLO1WmZARtFany/UycxFRqBw+dTP6xXjaYggtaBCBsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5893
X-OriginatorOrg: intel.com

On 2024-07-25 at 15:18:50 +0100, Hongyan Xia wrote:
> On 25/07/2024 15:00, Chen Yu wrote:
> > Hi Hongyan,
> > 
> > On 2024-07-25 at 14:16:30 +0100, Hongyan Xia wrote:
> > > On 25/07/2024 12:42, Chen Yu wrote:
> > > > commit 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
> > > > removed the decay_shift for hw_pressure. While looking at a related
> > > > bug report, it is found that this commit uses the sched_clock_task()
> > > > in sched_tick() while replaces the sched_clock_task() with rq_clock_pelt()
> > > > in __update_blocked_others(). This could bring inconsistence. One possible
> > > > scenario I can think of is in ___update_load_sum():
> > > > 
> > > > u64 delta = now - sa->last_update_time
> > > > 
> > > > 'now' could be calculated by rq_clock_pelt() from
> > > > __update_blocked_others(), and last_update_time was calculated by
> > > > rq_clock_task() previously from sched_tick(). Usually the former chases
> > > > after the latter, it cause a very large 'delta' and brings unexpected
> > > > behavior. Although this should not impact x86 platform in the bug report,
> > > > it should be fixed for other platforms.
> > > 
> > > I agree with this patch but I'm a bit confused here. May I know what you
> > > mean by 'should not impact x86 platform in the bug report'? But it closes a
> > > bug report on qemu x86_64, so it does have an impact?
> > > 
> > 
> > It should not have any impact on x86_64. I added the bug link here because I checked
> > the code while looking at that report. But that report might be false positve,
> > or at least not caused by this logic introduced by this commit, because
> > CONFIG_SCHED_HW_PRESSURE was not even set in the kernel config[1]. Maybe I should
> > remove the 'reported-by' and 'closes' tags?
> > 
> > [1] https://download.01.org/0day-ci/archive/20240709/202407091527.bb0be229-lkp@intel.com/config-6.9.0-rc1-00051-g97450eb90965
> > 
> 
> Yeah, it might be a good idea to remove the link to avoid confusion, like
> you said HW pressure is not compiled in.
>

OK, will do and send a new version.
 
> Even if there is pressure support, before your patch the big 'delta' should
> only result in a HW pressure value that decays more than it should, and
> should not be able to block tasks like in that bug report, so it's very
> likely that it's unrelated.

Yes, for x86_64, the rq->avg_hw.load_avg is even 0 as it does not have a chance to
get accumulated.

thanks,
Chenyu

