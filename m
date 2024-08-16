Return-Path: <linux-kernel+bounces-288951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A707954090
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B8F1F22245
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F5F824A1;
	Fri, 16 Aug 2024 04:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aj+3g/Ys"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB7C78C6D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 04:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781312; cv=fail; b=UbywYgqKcbLQwgJ308gU0iOk0F+EqOXTBMUrxbuutS/TxUG8RJfBHYuDtoJ49LZMifHUaGQRY+YNDN/qC4edec0rOiCLtP2RcZNhJxXa6xIHgfryh0oIqfTlkpqWBikZEgpmdi69bVM/aJ3bSwnrKAM5XO1qXujfbq4ZsX6N2yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781312; c=relaxed/simple;
	bh=BuXLjlHlXWVSyoMeXHcN+4krBIlFBlXgyBFPygvy1+E=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Mq33pAROsj+VYd2sWVDyMgfEwcIEeQW5pAJzdEqYhBNaYpjw9iUYeY+mirf2JXUt1wSQvvhEfmHHmxnjn04QB/vKS9Ji8sS2EOEC+9eYTJ2byVFCLB7E6KqacozePddEhODxwVdGbbqbWvPrXU54VvOvmqgIuu1LfCYIxepZVmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aj+3g/Ys; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723781311; x=1755317311;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BuXLjlHlXWVSyoMeXHcN+4krBIlFBlXgyBFPygvy1+E=;
  b=aj+3g/YsxhqB0hZc4ZKcMMjZ1DoiE7CyVX2oA/nBeC8IBJQozIQw0hPZ
   IVN0Tk0PB+Jgo/XLvH/rK4lLqwNh1BTcSRPPWCeoQqhYV2W/+WD5HlkF1
   wt3mYZN0bTr5FF3yCd4nNwvSmjfMef7me4q1IZLKX9PD7a3rLpH3SUPyJ
   D875q7yY1zX8ERZV9C9SCCu8FQzqg+OkTzgtXFpmVhgyTx6/09aAevzEH
   pNnv/OVyBw42w8NP6EGwowc56Dk7fbSQ3HPYxW+l+DWpVbEiqhPo8ymuY
   Hud5limdSy4DGSzzAOywYO4cB6SgCjzSPaTiZ/IL8/+vQLev5TRH00Vi3
   g==;
X-CSE-ConnectionGUID: gOnCKXi6THCEuJRhhwYG8A==
X-CSE-MsgGUID: ZrwbkhP/QFSIW0MVD870Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="21926802"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="21926802"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:08:31 -0700
X-CSE-ConnectionGUID: Y4eFNShuS466SsASyrI4kA==
X-CSE-MsgGUID: S//6NzJzQx+aP2bYQxKSew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="64406026"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 21:08:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 21:08:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 21:08:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 21:08:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7bLSDiZ86juXJJWkUvIZrK3I+bnDz8/ZiZ2dJDd1zsOObyuI8S2kakzmIhN4kGBVkrJ1SBnkM34SeF9MgLTBI02cinnFpAYSEe03wzTEC5ylir27pI6edfvnCH5qlj183ChvilJhEkNvFsD6Uf/5V7k0oSz4FzBtF16vvLv9xwaRI0HT4JH6yRLwWRp1k3/TBAVfZ9NQESuY6YqNk5ej5i/ygPoGMfeB1NEDDoQAbE8rOZnebrzO737Q8O1zX7JF64XlVyhuEwsjOZdL/2GVOqET/kC61i4/PpXnSWQ1g5h+K5U6q00yhogE79Ef9Mrt14PiL+f+edYSVHHVpZ2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14Aq9LwHGDeSsEzyY7EmbkBXmKg+tkezb1fUuNgGaYA=;
 b=fEm1OrGu/hUzyK/Zq/xaqklr46kRRNknVxBPUj3bkhwpvaQJmoeg11pdQyi4M37r8hAnqHkQ5mfTdM7H+SME1zvReWwsexcAprdhDmZ0Zw3wVOKj5SBZ3htW8Tup6kPKFfEY1nuDnalrNwS58XAh3gEy5lezsTyyE2Q1eYfUMOZ4gfYqFQnG3N36fn/kU6X3MDoxcSbbjwXnC5AzATqFd5cJ1ZOlhmv4WAePSUoVDy/Zj7iq8MMopXBztofCtRCsSVQKY3iZsiTPfEY+IQPD53lCZgCTW0juZhjDtnnBh2YxV8Y8ni32Ej+DNECujCwrAOPzfGECiRZKvMNL2wZCZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7953.namprd11.prod.outlook.com (2603:10b6:208:40d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 04:08:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 04:08:26 +0000
Date: Fri, 16 Aug 2024 12:08:17 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Tejun Heo <tj@kernel.org>, Lai Jiangshan
	<jiangshanlai@gmail.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [workqueue]  b188c57af2:
 sysfs:cannot_create_duplicate_filename
Message-ID: <202408161132.7c52d91a-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f607233-6707-4d47-adb6-08dcbda91422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YJKQLThT/a5rUFUzxcK1I4NqpXmo7ZC81q5oM4CRRcgFc8eVnaL5v3X9Fbdu?=
 =?us-ascii?Q?LSM7XSsZMTyitBBSggxhsiFp1lCvzPadMd0u7pMC2945naku8xZFmidAnT1w?=
 =?us-ascii?Q?Ady1g4ToLFQ3stXBKaW5Ic2B20qGYvTai5WASPKR9nGj8O9DPZzNb93q1glu?=
 =?us-ascii?Q?BlWEm34RvJetpV9nt/JnwXaVAljd2CDDotN67z8yAxSGo39R8G5FeDb0G83f?=
 =?us-ascii?Q?+bBPZA5e09OVUau6jKeIglxtJwcual45V/qUxXS5CeM7HXrnWNb0uwcczAZk?=
 =?us-ascii?Q?o44Skn4xPiBh2ystF4nRXufYqJ0O9vHInlm7Mukif6Xl9/4RST/2iHl5pGmN?=
 =?us-ascii?Q?zGujjdh9okwTpP5IgP6rmt8zNSzF0S+8xDcl6ZZD+eH2A206/BYuGmqMpXpV?=
 =?us-ascii?Q?u5U1CMDAchhwEgGy7nEPc5c8Gzw526uZzcCAEfnTBiqDrZPtAAukpkJyUGQQ?=
 =?us-ascii?Q?ZNLMPDTrXNgX3opfFE2Lwqivq9VeyRlcpXImfIrXT8nu/gMo/zcYD10uqAYJ?=
 =?us-ascii?Q?iovey9DqGae5Q1UTz5CMWU2SMm+UuVnlzUtRDLin7wOd09uMZLatsOSJObrj?=
 =?us-ascii?Q?7GLDmf8c9DzeNK0jQSGUJno86A2ZM1eMsd0hb+Xa2UVRu013EkxAAPGynsIk?=
 =?us-ascii?Q?aO/+2g7x/swG5azSB1vUlPQxSadHvUEokCS+dFu2VGO56wqete5lLS6myZgm?=
 =?us-ascii?Q?PXW9Y/iv7d1ihcldc46yMSYuCkv17XGKeVzPM/LBqUKoyFL0LMLWk9kV/15t?=
 =?us-ascii?Q?0ejvdk8tJZHX5vmTDQzzcGstZdrhRxmYuEiG65gyqPPAfO9wVWO4IDyX//yi?=
 =?us-ascii?Q?mcUfPBd9d6D/K65reRXNCEc/AzT5MzBwEs0CtQX3q2BS/CZVDXBD6UoFBuY/?=
 =?us-ascii?Q?2eaJ7ps4fouvSXRdU/Rmwmg3gXyuu6v0C+BRItzIW6jdu9/P9uscHv+1TBjt?=
 =?us-ascii?Q?TcW+eCT7s/nURrdr/cvIQ4TfzUil0H+0Lw62SQ7XDHK0C7ot7JvZwNxnXwmi?=
 =?us-ascii?Q?9zhg5wTFALwJJy+3MhqBjay91PW3RVJBed7TfYV1m6E3dqn8G1csbUxwIp6t?=
 =?us-ascii?Q?8ldds7DZ7tdfFxdIeNRrdY8ZRMYHCMu+A7BuAh41oPBVtksQp4n2sDJaJfic?=
 =?us-ascii?Q?CnmQBkYVxTWNekgITjjsUz82iWzn5NutOY7y/wV7Xn6nPV+v2HDOPlqV9OhV?=
 =?us-ascii?Q?q3011fb/Vj2n/5fHvHzdx2KuP2WdVAag/Sg/u+l+jYFllNBeL3jZ/sN3+8BF?=
 =?us-ascii?Q?6zLTQgqkxn/9Cf5QtwPpH7fU1kCBqUAls/dlppHy6M5lWgfMzDe/JfVMhT4o?=
 =?us-ascii?Q?F11Wb4NhbYc9PXa9pOcdMe+S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jjx0U0knFBm+5OKcY57ATxos2UBsvxOm47EQQVXVcwVf1WZUFnXejtKekN0N?=
 =?us-ascii?Q?JS31BqropktbFG4XsgeXtbdzULJbv2lU7PrKduwK/QL2xjTCfh0cnqVX68M6?=
 =?us-ascii?Q?sb9ZuwCmb6Vnq6Y3XryctPrGHaiYrvIaqb4XuhvdjO89G636M1tzBms1ZKHh?=
 =?us-ascii?Q?Pfl5uaN/RmrotzRX07UGUu1MXxhe6lMQTcmpGHvZjU0+NTOfNOoi8qm2/Dzp?=
 =?us-ascii?Q?iOIctdQMOyR72J39CumLCL6wB9pLLKHA0ECbI+oqH0ZAxuAXtkQM9n0V6HMI?=
 =?us-ascii?Q?YjLBFMouHCN69ysbYUBfmoZayIHFiP4oayrFdoCRyTs8ZlCJjPn/q6/ZjHG7?=
 =?us-ascii?Q?rudjDVIuQN7ABWrHF7xSvAXlnxMQI1QoPbVob+kRbAmOOHBBTvRhrjj3I2hq?=
 =?us-ascii?Q?+862oWaQy2bvLceNNMTMiXf8Piq2l1xnuJuH7c4jeXgVRUAJhNwSq3Pem/8e?=
 =?us-ascii?Q?9hvn4ugv1KmkXIAqIEzQSrv7VLgdawU8tDoQpjhQQNR7zV5ObkDK6IFVe02G?=
 =?us-ascii?Q?qMYiW+ZsEsPujREjHBCXaohNAlbrJRdBZgjJ1lfqDKkWm36zuQ04zN24k4pb?=
 =?us-ascii?Q?gWJxZGNPKbRfBE+ClY8U3VyCx4YH0ihARAdB5UBK2YB9XU6vhHzd14rkVjGX?=
 =?us-ascii?Q?R4Biks4swc0mSmUaaUeeWK9OpAus9JCVhAhGKVpOGz0m9WwphP7W7+8oXQ0E?=
 =?us-ascii?Q?h1G+al3wbN4n4zsWAIFlvVhIHr/lvu0YI5FOrnO5rNTFl4+TX7/ktQjwpfY6?=
 =?us-ascii?Q?/aGIIzKBU+EOmYpDoREDgn0fTVjhgi/clg0X3O0GW6DfRzWo8dAEsRL+jOu0?=
 =?us-ascii?Q?wrEv9wplhUqNXSWZS+n8q3pf2PGJUldHrvYrs0WtR5RUu6hX4pVUQb7ukReN?=
 =?us-ascii?Q?atlXNRqXhpjKClgH3o4qI99AxkResi+2/3LsdlncGYNgcekzL5yxEC5r+LXf?=
 =?us-ascii?Q?7Yri0yITrIYn0vVvs/TetT+Li8KQNYlxbTy0RmyxLdulFyQwKqmCYhhZJKiH?=
 =?us-ascii?Q?Kpq82igEA+wSdy6mape8S8p6cbypOyvUtO3HiMkyVaMh3WOkn9CokYVZmY/v?=
 =?us-ascii?Q?Mqq/88qHDVfQGR0C/0IPzI4FKTEvpCX95Fziy9XrKMLyBqz1G+MIrAlq76y9?=
 =?us-ascii?Q?/wg+yOWe0T3uGLpJv/iz4n8ro6z7PX2TEwWC1OK5P6jRXs3C+X7XHdD4MoKk?=
 =?us-ascii?Q?nxh1BkMfrkOOYJPeab9n0kpc0ask3XIo/hwPha45DoqUHJtl8WRhts6olJJv?=
 =?us-ascii?Q?+EP2PFp9UJut7MJQSpyR5XmnYlWIGEys3UHGHoKdmKzMze+1PSMriQTGRUNu?=
 =?us-ascii?Q?4Z+wUsXZ25M15oJj25IlReOPXgAQBZ8zXlB77zhDzIwZRnaJbF+zDh+M7iSy?=
 =?us-ascii?Q?mZQ0dlADCmlIuut9xFmMB7jME6G8pN5V08VFCHfCtk7AxqJI3ZlM+tvvKG2v?=
 =?us-ascii?Q?SZQHfE5cVrlqe0jCz6tD4Ib5tI4MheNqJVOgR/a1BxWnQ8DPBdVoj1GA4oVn?=
 =?us-ascii?Q?//k6fSXKFL1rEaFMfcK9mwmcBq5uJIIX+8kAUuP4C5D0ab+S7+v7t7ePb6Yn?=
 =?us-ascii?Q?7Z0kztPUtpVV0BW8OdY6DiiOlspu/yeB0lUt+ETmTOHivCspig5KStHXeJsy?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f607233-6707-4d47-adb6-08dcbda91422
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 04:08:26.5504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DD/QfmIEyyQsNH5q1gPD6JYIo7Gx7FomHIoLXNjl3LjQhxmxTdw6b4n2SXhvGtxak2Bncxk7RM8KjFWISnPJYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7953
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "sysfs:cannot_create_duplicate_filename" on:

commit: b188c57af2b5c17a1e8f71a0358f330446a4f788 ("workqueue: Split alloc_workqueue into internal function and lockdep init")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------+------------+------------+
|                                        | 946c57e61d | b188c57af2 |
+----------------------------------------+------------+------------+
| sysfs:cannot_create_duplicate_filename | 0          | 12         |
+----------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408161132.7c52d91a-oliver.sang@intel.com


[  OK  ] Started OpenBSD Secure Shell server.
[  116.454031][  T134] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
LKP: ttyS0: 211: Kernel tests: Boot OK!
LKP: ttyS0: 211: HOSTNAME vm-snb, MAC 52:54:00:12:34:56, kernel 6.11.0-rc1-00003-gb188c57af2b5 1[  116.612859][  T177] scsi host0: ata_piix

[  116.885461][  T177] sysfs: cannot create duplicate filename '/devices/virtual/workqueue/scsi_tmf_7698144'
[  116.902822][  T177] CPU: 1 UID: 0 PID: 177 Comm: systemd-udevd Not tainted 6.11.0-rc1-00003-gb188c57af2b5 #1
[  116.919869][  T177] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  116.937535][  T177] Call Trace:
[  116.952146][  T177]  <TASK>
[ 116.958139][ T177] dump_stack_lvl (kbuild/src/consumer/lib/dump_stack.c:121) 
[ 116.966343][ T177] sysfs_create_dir_ns (kbuild/src/consumer/fs/sysfs/dir.c:32 kbuild/src/consumer/fs/sysfs/dir.c:63) 
[ 116.974637][ T177] kobject_add_internal (kbuild/src/consumer/lib/kobject.c:74 kbuild/src/consumer/lib/kobject.c:240) 
[ 116.984066][ T177] kobject_add (kbuild/src/consumer/lib/kobject.c:430) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240816/202408161132.7c52d91a-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


