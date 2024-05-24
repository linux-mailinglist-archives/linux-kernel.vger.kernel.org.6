Return-Path: <linux-kernel+bounces-188869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7528CE7FB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9B31C224B2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CAE12E1FA;
	Fri, 24 May 2024 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuRFQ7QS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBA212E1EE
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564640; cv=fail; b=m2wxByyIAjLyGSO2wsbrs1pMWPLOPmAkihwq2h7hLry4lRqMIK7zGBQ+ZCGBTVivXbEZCU/6YCKLZ8CjkT9BhIdjqSJxpNGxkigs7vgRzBEmBJWp9bH9fEllWZ3vzfEG72VYhDPWMgq9Rh/W29P61D1lZaWAyWFY9H2LVzuIrqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564640; c=relaxed/simple;
	bh=B5WIPrbbk4/j7XLDmOCpEzbd70i8hGyD4LrfnqIUUyw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KFmaso3toWe6CS0u5zcE1YRgCbeHGL1gnHpz07+YuOuVM1hsN3SUX9hOUbOQtwUEhbPDUeT/H49j+pWqBokGnPu3KD7IF1o3jp3dIoaTattYX0I1aekiQ3Pal2X1ALze3mAoEU/JbVM9S4gs6OMXtCv1DJitrVAmK8nH9d3DV14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PuRFQ7QS; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716564638; x=1748100638;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B5WIPrbbk4/j7XLDmOCpEzbd70i8hGyD4LrfnqIUUyw=;
  b=PuRFQ7QSts5bq2ZrbtqN5c047lZYomCaSeLaBt+rckVWv+btMUobthXY
   YI/joDqOHCf30E5LCzAu21NcPWidQczZ3eNcerKfo31HnYhjkG0fyiBh9
   6KUOMiW/IQOumcqfrrsZgpIImrZN8bVgxKZVhqRMY+22wVi9pRBp9btSE
   2MYMUnkbf2X5GenCOxKAvYjMvP3dARBkHyJ/qLqKybCJ8AeJg009f7GbH
   da49WCnKyyFKtmImqjALWd/4ZP1+RXPC3qcmvzTDTCYdgelPgKwhkGqfR
   YLwkKeL/thwwmMp5yzsSLl5vIRUAz5z6R500kl1l5y9M7cAdteVanP2YU
   A==;
X-CSE-ConnectionGUID: NWnawtHjRkiDjLDsUobPgw==
X-CSE-MsgGUID: X8AZfLtiQ2+jXSuDgUyzOQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="24360088"
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="24360088"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 08:30:30 -0700
X-CSE-ConnectionGUID: aFR44GLERPKYcnnIomARIA==
X-CSE-MsgGUID: ugIAnHdNRoWYE/5367NoAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="34162512"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 May 2024 08:30:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 08:30:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 08:30:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 24 May 2024 08:30:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 08:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRQvbISvI5gp+BVB9ZwaNzbJsm0+KyVAUYHFeG/s1EHuPTDY2Oo2Qc7PyyfXWeV7hC7BxciiMH7GJInt4SoShaqwF7MMuP6RscMck84+HFosC8ikz9hiqDTYgkJr0haobs97C7fyA6JV6pczYaxYQnpF6kvXn3rTO/lm/bFvgtwWYu0WgenkeVPQ3+h+Ok4A64vo7T0rfeCZMNBrk3XDf+Z/JIWD9Jb4uqCW1gmvGDwjr5yDPfC1IRY3E5wzD1lJoNe8rOmIlynC4Q1z7zwhqJw0NJPSSDs3/p1+4eCkCWbG7ptCroW0cDrkNKoBVE9L/ZZnNdtlWaYGDrDUSvihEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74EbaUsP5PMeAQgw48MWEGqfDSF+OwCt1Hzj54tezgg=;
 b=kr/1PvEH37CBx8/TyYIhmAt+e3SOrugDb0BGySAYPmoqObczX2mWmbxsoHAyYsEywgSeyzMboTKcO2B2fFNnPg/gNwOY7qY9uULYXa+o4C5nfKAlXh+vQc7viN4sLhI0hFhMGvTTzM02Z/D8htxUmgo0cc7MsFTRj+rozzxOoYApeSVZ/XfuQHazrUjw3M4op9MyDS+W8L6HQVDnB0bLp6S+JY5jzqg4bXaDyvNKKTcpfjH/PQSNGBf85TYudLhPsFQ5u4YhcuNdNE9yzbXqJ6IRYlP+xJK9vdRxQ6EwBF5DGHA47ZP3N5/u6xho9FueezDVOdocApWaX/TjtSg0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 15:30:25 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.7611.025; Fri, 24 May 2024
 15:30:25 +0000
Date: Fri, 24 May 2024 23:30:12 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Chunxin Zang <spring.cxz@gmail.com>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<yangchen11@lixiang.com>, <zhouchunhua@lixiang.com>,
	<zangchunxin@lixiang.com>, <kprateek.nayak@amd.com>
Subject: Re: [PATCH] sched/fair: Reschedule the cfs_rq when current is
 ineligible
Message-ID: <ZlCyhDspcZQhxlNk@chenyu5-mobl2>
References: <20240524134011.270861-1-spring.cxz@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240524134011.270861-1-spring.cxz@gmail.com>
X-ClientProxiedBy: TY2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:404:e2::28) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SN7PR11MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f905488-e51a-4f4f-69a9-08dc7c066ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7ZJ4nJrzUHXGAn8Jm76BaoL5t/Lr67BDYA8RqJNypVydTjY/S5hNTcRINS0E?=
 =?us-ascii?Q?48AOXaqI4MdoricIaVhak+JBhlXWWN03tfF1WU7mD8F4pI/FzmKzAuaAnrJk?=
 =?us-ascii?Q?9QCaoB2NEb32suUqtK/s1J8fWJ7d1XBAhA5WEa04XPzF25Z4YEeSkFPH6b5l?=
 =?us-ascii?Q?TBh6OcTYMMTmJTU5Nzdc4E+3dOxLTeKVtKzy66odwLyJcSwN2h7wzyafDnSB?=
 =?us-ascii?Q?Z/Vp0Xg3i/XkpMX0eBPK/dytk41WR9VjhHZduCwKD3vqSzLpvIHciZDF5WLP?=
 =?us-ascii?Q?I12u6AZlqTNlyGoNcVaSRMdIbPTKi7uPcIFWxEpJhy7dkWmNVky4pWZmEr1y?=
 =?us-ascii?Q?q0aSn/2TvfNPI5iVKZFNNQ1zgcRKFeu5JnJ3gXMDMDavUTJ2Iqdm6dse7hmL?=
 =?us-ascii?Q?FRDZ2h8hkKGIMJ8owU528lF8EdRS64dSN42QK/kWGuem2FWUFUW4uN5nRF5a?=
 =?us-ascii?Q?EuVSSnzFGpKnMfulq9vskXZri2lF5zx/UNJu+Tgzh0OR1aydC7mSIS/+wp6z?=
 =?us-ascii?Q?e7mlxDzVFBlxBGlTOeKYAx5qJVwDXcoIvomcldrnY8vuTZ7GtIP4pTfJzMzp?=
 =?us-ascii?Q?7tPYsdoBUVFyAoUPO4yxfIzlFuM9gs375SMK64DEiU8P8ZUwnzvce6YReQIb?=
 =?us-ascii?Q?0sWGRGhsgVgUMhrZ5QvYecBtRNicJ/PhpKaWWWjDgjQYLmEu53a1ANc3GUQc?=
 =?us-ascii?Q?4HTY/eNnoL84uKdsgqMF8Fz9z6fKYYscSRU0usg3biWDqGyyBJNt+xi9tz+9?=
 =?us-ascii?Q?lmby1iknpaKskv/qYQxNSnbx4USQNb7gpKYymRhWVRoPsERNNjnj/16bq/KA?=
 =?us-ascii?Q?MaxyPKCTfWtATw1VI559ksdWJJhN4g7RXtN0oRXlE/sP03+3+OKwwqByUaMU?=
 =?us-ascii?Q?N0+is0w0mlDr1ZQgHEt82PmUJmTujdp8exP7lnfpnDmxH+hZL4KPcPD2Rg1h?=
 =?us-ascii?Q?yR7HHvF7gsJeih7Fy5NLYhMv+M4PbHxnXY+WDLj4OJDx90JpAkCN3DYD+A2n?=
 =?us-ascii?Q?dJcOMkNE+hbSsAlLJdQE1hNmm9WIlFRIWWGUj7jVn24HsE2mwNqek//ie2k1?=
 =?us-ascii?Q?zbzDbbyTVEeVXfOsGrfdTXD0Jrb103U2RVPDM/AWvxP6f4KyQ5GFIGnFXNyA?=
 =?us-ascii?Q?vNwz+iPa6PPr7FL1+BVE2iiy2Fuc9pWcHiYaAVk7kv/PxAGFQdG5wQlYqAA2?=
 =?us-ascii?Q?L0UqNyW9NXpPq5RcQDyooU+a+EswkiE7KFdxO/kP8uNQfswDQCN71oLMrHk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SkZI9xJOU3MH07Ak6MIdP9K7F2bQCHFnVT3SM4sAEbKkkSzxx/PQMJ9OOEXM?=
 =?us-ascii?Q?TWtGX0jTaVDEnsafdKlyhkITPuc8soaqvseoBQP0eCsc7c4xUz00w1i4Syic?=
 =?us-ascii?Q?FNfka1AjEhf1PHBvaT65t4Oo2GHer98ve2GDb4H3LnEB9kRFHssS26oNsiFe?=
 =?us-ascii?Q?9dvPNGnvB4POfa7PxR73Y4nzRckH7fT3yc7r66ADSB2OHG3IocKmdYPcYW4N?=
 =?us-ascii?Q?JOb+Z7lr+dzLTZSu3bMRjCbS4Kl1EOhtssvMaNBHm5YbMzZgg+TuGWyZeqKE?=
 =?us-ascii?Q?MhKF5NotIAi67AuFurzgovdGemqwmi6Y1QJO3FKTUAd1y1nLHdVB6RrUbTPr?=
 =?us-ascii?Q?Vc4Bas3rGqEEadIF+x/f9nZgye+doa5AsZC/i2F1oyLDwmknWow1/dAv0zWW?=
 =?us-ascii?Q?RIaSPhoIpTDf1ETjgmMPQpRCisIKRVlnhcsGiANQT7NWLMxq252kCzCpJbS7?=
 =?us-ascii?Q?bniGlAeYoZYw3fqZDHN3L/oUsprTEn7/M01WXTJF84nOzc/1JwVrLikQREpx?=
 =?us-ascii?Q?mRH3+SDtvZAq9ZCIDNRNvZYPjimz08PilyJOgyfObzHI44Ta/9wWVwMjvKNi?=
 =?us-ascii?Q?si0naVSEZU18P9tQT4uBe5LbW0rapZs3aPp+lI9VHNqCH7E+jlRAhZY61rGm?=
 =?us-ascii?Q?FUtZETvUdQ3haF3j3X+XGOcrbcGXJOCqkDiXCjlBdkHtXhgKsvmwB0lfm9ED?=
 =?us-ascii?Q?xci8OuLAcHQ2o7gLrZfwrjOrQVV9uRIxVPjr784KB1VgFqt51LHdvPv2pfg9?=
 =?us-ascii?Q?N6CgsNb3Umlo+VzZBpd6wk1UEybYzD2Q/BAlkYXGqCpfcH+ytT8wOmSfK7pz?=
 =?us-ascii?Q?pEHLda3ZvUFsrytc5COrnqtRanbDwBV18dtT10rdc7OwaJhKYvW4JyJzWkWd?=
 =?us-ascii?Q?3hu99zLZ0WBSl4kfYbjI9qhTq3dkLgFvlqYXnD2csomkkBZSOZ5aZL6iykl9?=
 =?us-ascii?Q?oNdACfuVV/FDwSDE/hvdMqWh/H9gZGYwcgxU4k9A9ZZM59/zWohDNGXJMhYw?=
 =?us-ascii?Q?BNnqsaOvFFfQhVYx1zl4GMQTMAkVUIuub2OXQrvnsu82GEp1CyUFwB4ClyVP?=
 =?us-ascii?Q?AIWopTfUwkYkU7SUrpi85gAaOM9nD3monhI6Wix0E6lWY4lB1IeBmtWmtUJ2?=
 =?us-ascii?Q?eRX+wptm1jdsUCOMu+/UoObait6atnultQnS4hRNS/GTjhFQVtsiyl71mVjN?=
 =?us-ascii?Q?3sxmU6frY6NBQlRd5zU5iGrPGuexNMU8WjMPIRfJZ8GKOk+FcrphD7uillCr?=
 =?us-ascii?Q?wJj/1Xq7k17LM2QrsMqcU+zugAckSaTNv+l9ejR7/kUvGo700nmgVQARw4Mw?=
 =?us-ascii?Q?5zFxOt3a9Eybr0WJIQHA4uFw9kKqCid1m5ezoGOP94w4KMkNM2f8Tp+jjmNj?=
 =?us-ascii?Q?Zh7WxEmkYlFd4shm5Jr/2Y/U0HEy6zK2Yn6b22OUtJjEfhKlNsxqythhWwgZ?=
 =?us-ascii?Q?7dw8cfpu+UXQQVaI9AWvj7USl5UC13woMqKx3YwLhwpTLRJD2L5aZ7CwGKeC?=
 =?us-ascii?Q?iFPHiWeUtuhdX5BXEgZReNg5ijA9Nfe8TmD37Il+NJ7PW+J4mX9ReTyHPFa5?=
 =?us-ascii?Q?oPXHIPBIe0+v0vWMs0oZoM/yw6oZB2zabf5Ggf+m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f905488-e51a-4f4f-69a9-08dc7c066ef4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 15:30:25.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxXhp8rthQTS1zwRBMmrtmkHEC913Xs510AVR3kwPa7YFnw7tRahiR58UGvEmfyTz4+48N1f6BqJxAE5OS8Z9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7420
X-OriginatorOrg: intel.com

On 2024-05-24 at 21:40:11 +0800, Chunxin Zang wrote:
> I found that some tasks have been running for a long enough time and
> have become illegal, but they are still not releasing the CPU. This
> will increase the scheduling delay of other processes. Therefore, I
> tried checking the current process in wakeup_preempt and entity_tick,
> and if it is illegal, reschedule that cfs queue.
>
> The modification can reduce the scheduling delay by about 30% when
> RUN_TO_PARITY is enabled.
> So far, it has been running well in my test environment, and I have
> pasted some test results below.
> 

Interesting, besides hackbench, I assume that you have workload in
real production environment that is sensitive to wakeup latency?

>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 03be0d1330a6..a0005d240db5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5523,6 +5523,9 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
>  			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
>  		return;
>  #endif
> +
> +	if (!entity_eligible(cfs_rq, curr))
> +		resched_curr(rq_of(cfs_rq));
>  }
>

entity_tick() -> update_curr() -> update_deadline():
se->vruntime >= se->deadline ? resched_curr()
only current has expired its slice will it be scheduled out.

So here you want to schedule current out if its lag becomes 0.

In lastest sched/eevdf branch, it is controlled by two sched features:
RESPECT_SLICE: Inhibit preemption until the current task has exhausted it's slice.
RUN_TO_PARITY: Relax RESPECT_SLICE and only protect current until 0-lag.
https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/eevdf&id=e04f5454d68590a239092a700e9bbaf84270397c

Maybe something like this can achieve your goal
	if (sched_feat(RUN_TOPARITY) && !entity_eligible(cfs_rq, curr))
		resched_curr

>  
> @@ -8325,6 +8328,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
>  		return;
>  
> +	if (!entity_eligible(cfs_rq, se))
> +		goto preempt;
> +

Not sure if this is applicable, later in this function, pick_eevdf() checks
if the current is eligible, !entity_eligible(cfs_rq, curr), if not, curr will
be evicted. And this change does not consider the cgroup hierarchy.

Besides, the check of current eligiblity can get false negative result,
if the enqueued entity has a positive lag. Prateek proposed to
remove the check of current's eligibility in pick_eevdf():
https://lore.kernel.org/lkml/20240325060226.1540-2-kprateek.nayak@amd.com/

If I understand your requirement correctly, you want to reduce the wakeup
latency. There are some codes under developed by Peter, which could
customized task's wakeup latency via setting its slice:
https://lore.kernel.org/lkml/20240405110010.934104715@infradead.org/

thanks,
Chenyu

