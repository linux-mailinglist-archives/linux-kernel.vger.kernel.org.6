Return-Path: <linux-kernel+bounces-335502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CABF97E6AA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DF91F21066
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB1638F91;
	Mon, 23 Sep 2024 07:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHk4Ast2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011DFEAF6
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727076856; cv=fail; b=MoqKIf0j2e8s7Un6thM3MQLMQmSrqQneTlrA/jLDaBwYus9onp/eeBTYh6TT0qeX/PKmIYNSZsxKnNXiDgtxqNSTmmXpk9fH3rAUxhCh90aymld2e+WFj8Bgky9K/3cg1xvoOiGP8rVE/qKzNihY5HCFthZVYFunU9ZDLr9K5Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727076856; c=relaxed/simple;
	bh=i0IOQTGHlG5Tb0C/r3UtcfMnxDMH4o3sdQhI9+J44l8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TG+MnEcx6ROTU/eUwM8z15Zvv0nEkn3/1W18u99zMLQV5FVMDLrJjV6eveDL1oZWTWvYleglDGKpHGD8sxCF5JZcuGvAkaWHDrtgebBCgVmIVFOFTu22VsEh3fRS3rHnh4aWSDFREGCpZj1EqAxjDvYELyfYu2dslHv3luNOAhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHk4Ast2; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727076854; x=1758612854;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i0IOQTGHlG5Tb0C/r3UtcfMnxDMH4o3sdQhI9+J44l8=;
  b=QHk4Ast2Rgj28gwPYY5ge0HNy+swfOv9gSzPu7Cq59LwaJiXL8hPZRZ9
   5KRsX000terFWGRwqhqv+xEu7sehg/NhmrJ4eMs/dkz7cTuwvrEruNMuW
   2lHkz6FXJe0W1o0hlXnGRQtcWa0BiEEZ78zjEOA4OAPVmzLjdgFf5UHlN
   ed7cUW83R5yiyeLrd4KYAEwJqyV8EiJv5+63roItCWUz2yVy3mZRSx2Xa
   BYTki+yZMv6qYy8WlZ2NnwmYglOxk94Pt7wMKI6U7ds+OVHpGwPkoNThI
   E6eFA2SifrIS97373F4ta2QWzrS1+LXbabXld146BqqUdLdrmI8g665KY
   w==;
X-CSE-ConnectionGUID: 8dLOS19+S32shDbmj3i1Zg==
X-CSE-MsgGUID: Gab8uPHPQlSLjf+dRRmh1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="25960623"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="25960623"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 00:34:13 -0700
X-CSE-ConnectionGUID: aCDUR5OOREaO9V7J/MGH8A==
X-CSE-MsgGUID: 5ufX9oKMTtydc0N+uRLEvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="101716387"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2024 00:34:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 00:34:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 00:34:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 00:34:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 00:34:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=By5e8en+N0Sj8tB8xJDXpN1zKRdHgnfK4dmuWcYDdO/csSKAMDLQhzIJaeeKowyEiXiosE9/p7SI9Mq96/FTLfFx5/g4DdpGFVm8lHtyHjSCvJrZyg3ezH2XzP3ArOktgBzsmFhE4FyC3H36c9i3YkATXhlj1U8KhJO87Y/iREi5xZf2efQOkuJwoQ6NJyXx5xpn6/nflhV55X5buJmtOX++eWaynTktSm+e98m/kwHx09Y9AxjZys9NBn0s4YmDhOOp58lFettBnrVDDwdIWr2rDXqUm4wLnKb4HaeDcM7ij7j7J1fN2EKQP9SWClVk9+OLW0pzB4IQXqBDzfiSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dvg8MZ5q7Haeb+0SgrW2BEUtuRXsZqjWszy4AquwOts=;
 b=GsrxfMgereIWSpZUzYmfCI7Epp0tROHl/y1G8VVGPUOW4e52SWHo5E5a3GfCxqsFjmoMlfPqmawKmogdO10CkCKJCKDYVYTG8Ya1ZecNEjyLHDeyXlec3+my3/op0DMxcROa5zRnHk0z5dyFGsjfJ5j/qvR+orHEJxHlhNiOSgSekb8ITKT8r4rHUc33TOGEvHSxk7Z305d/J3+vqa11br1UER/ORARmKor9ryqn/l2kUHC5MKmFb22OhyNTzr2BhT/ZWvSI/naCROCeTh22KUke2aEdWixCWfa7VbKDWPmzoeCmmMkoCvergcLg1qkBEX64M/2wI7L2bKiqTc2yQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ1PR11MB6250.namprd11.prod.outlook.com (2603:10b6:a03:459::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 07:34:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 07:34:09 +0000
Date: Mon, 23 Sep 2024 15:33:58 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Chen Yu <yu.c.chen@intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider
	<vschneid@redhat.com>, Chunxin Zang <zangchunxin@lixiang.com>,
	<linux-kernel@vger.kernel.org>, Chen Yu <yu.chen.surf@gmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] sched/eevdf: Fix wakeup-preempt by checking
 cfs_rq->nr_running
Message-ID: <ZvEZ5kDNdtOK8Q49@xsang-OptiPlex-9020>
References: <20240923072156.343623-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240923072156.343623-1-yu.c.chen@intel.com>
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ1PR11MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: d1cd36ed-e465-4e17-9796-08dcdba21c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VMuZnMigy7WtJCYIDMoHjO6GDxD2XcrST90u+Wkv0X1yYTro2ZbH88EgsX+p?=
 =?us-ascii?Q?4vpdCZnhdZwZ2b+RwzYQpV5LExa91daXwoi94eY88bPL3XHAmoBgMrPrC2nW?=
 =?us-ascii?Q?Xci7/54wNYuBeahkMCaQ/RW2KUlIiSrruj7BuIkdF9itoVmen6/FnsI15r6Z?=
 =?us-ascii?Q?w6XMqoyWdFMHVp2lxZLXI0svBdob2gJ++ppxbQZjOf+yxwA6++g3hSAKhqBr?=
 =?us-ascii?Q?JlRoUZI3T4nrdzmtrk3ogjMkwB5o1mNf/tXVJzxRQ9H8adixipnW9bRbcRYd?=
 =?us-ascii?Q?KbJ7EUGIN5gtzcY4qgKJ3+njsTvXCpatsZDDk678V4rbkK0bL61rkWTd/Q77?=
 =?us-ascii?Q?T/euTFxIEtHlwqSl5lgVSrS2uZsZK07A389eFJjfOXxR+cnaVh0PqmJTczNl?=
 =?us-ascii?Q?d5YcHisz1byvnkqejOIHiHRI85N4STyEI+s/XUTcOyK2zRWBRkRZhkTBVUGx?=
 =?us-ascii?Q?svkxFX+DXkXDjlqbFGSYShNq+Ks52ts/vQWSGfUpXdKQET6LF34KKiBJSKpm?=
 =?us-ascii?Q?xog9DEQGWzp08MDJRSJR3t8ppYjPeQj11zPnhAkWb2Q3mLctIRMqQSMm78ax?=
 =?us-ascii?Q?t4I0l5bNq+LVx+G7M27re9sYCEVR5DC0Us44JFCBUo12mVka4C7rUNy5rrxX?=
 =?us-ascii?Q?SL11BhTCjF2O2ucVp8FtgXM6HIgp61pkeGQdw3DrgvPayUjxbFO1EZudWYy0?=
 =?us-ascii?Q?o1xDoWBbtiMGDEkEh2L98t52DOfMnKkZCg/liKWTSuEHxL/+U30njB5K4wSq?=
 =?us-ascii?Q?Eg5SaDAb4xlFRJu/ZqYrrEKcHzYqNkJ2QD3hxcuVzcxPPYUpKOzGshjCP2lB?=
 =?us-ascii?Q?KhAhCdWZ9k1zK9JxZ7nbgUQSRCncSRTMHr1ywQqvNXVcllFgsrOrGn+SwECG?=
 =?us-ascii?Q?Iz5MoriRFkpuEUuYt350Sn5Ymi5HpU5RE1G4zvI3jDlNNLHVVSulRMPyWV9z?=
 =?us-ascii?Q?32o9Bha71nqlikMYOoMTvzHF+hQu90hoycEw1qdjBgVXT0fRk3PJijLWE4Fe?=
 =?us-ascii?Q?J/RdlX4D6mvWsb/23OyF6QY3llG84c0cdorMry9SofqQAPEAjTuKrJYZA/po?=
 =?us-ascii?Q?aTUUYhmle1cWmdc+lPvuK/CyTRSyQiRlQihXUbd/e1vXDKLX9KtGhJzGDo+j?=
 =?us-ascii?Q?Una196/BFDQkW8S2y9j2R4tqCGZEr7XdpK+7u4Cbhh8fxR34issKfeboU7lB?=
 =?us-ascii?Q?6c2OKsl4OeRTg96jCuqffDWCr7DTcg3fRAaAX/hpNsWkiC4IYQ7vXXch5ezP?=
 =?us-ascii?Q?vCTKL53YjzrjfPgI4os/o9crof2aoKi4S5h2bTzcBFTDKH470obg10EnQL74?=
 =?us-ascii?Q?scuLw6RRtUhRFDAPBtOAu19Fq0FEcFGlCDsvfeZJDyQXyiSGDB4uvhGeLhGr?=
 =?us-ascii?Q?Ewu1/D4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uIl4MWsZ8b6hozG8dnhaFGxwXGHXouqTx5cxHCY1wwkGQExHqjUWdXui0azB?=
 =?us-ascii?Q?xKWe8L72yvRF16NSly++iCG20NZq58hM1iH1vhzk4r0kvo/sJUaj3xNBAiZ8?=
 =?us-ascii?Q?aCV6CZ6fE3euZQJ/qzAHJSnCWuozczeGwxQAg6f4Jc9cjo0KgiUdlKL4qGAs?=
 =?us-ascii?Q?nk3iiEUkTxzdAsWYvOtYmRu1b4xUnNnMjf1/n9n1qZXEMFYyPsz4sDrcJWG2?=
 =?us-ascii?Q?E2Dox4lrdcVqxI+w1gN0mx3Qq1otK7DotuIfLdj+r5VGY3Cop0161Ge/uNA3?=
 =?us-ascii?Q?zVCK3R54Kx5wwpY1+TUFYZrxAwSdsL9ZVkbh0dEXTanwN6Y70Pns9YjyOPcZ?=
 =?us-ascii?Q?nXpvixlTnZxXtbVG8nJyQ89QrdlYo2h1vdKGKYzm3XUnKpUu1C9NbQr9WAmT?=
 =?us-ascii?Q?iABPT1RVUDiFJjpqOMv97CHWUQZTCSagqwMalGM2zikqU37UxjnfuSCal4j+?=
 =?us-ascii?Q?226VsqRDeb4knNT2S9ElCchLQ6dRLdwdr80V3bdD3kzxUul/5ZRBaQujufDK?=
 =?us-ascii?Q?MP/uBekGSxjagOWc0AP2Dix8gFk4voNdQS1fRZ6XtxLuuenk2VBhG3xWxn8J?=
 =?us-ascii?Q?tiyf0Wm/ekTIovgZPHbaXGOr4ZkAa1KszFRQQieOMfdjmTC+90+AZNHcws1f?=
 =?us-ascii?Q?YgrZV8jBg0HZn9eDx4orVHcrybDrW14giqdOCiUObGFH5/1pj90BXIvYhNDH?=
 =?us-ascii?Q?pyKKoTX65200S2GJZsB/e5c4rGL2XgDSHATzM97AxahBzzPUFWK9moyOrk7L?=
 =?us-ascii?Q?qef/c1/5UM0U12yxaE54w5wValWnao7BfDt7cm4WamLZueYPWOzEe3ccCzXy?=
 =?us-ascii?Q?1G3e3PHJxS67Ygk1BRlvhIKqvUlzKOCfGSz/6Kay6YdHmg4RQSB3YdIf53ZB?=
 =?us-ascii?Q?OdYzpoxoDFYn7suBHiFDgsNMWbP9Hw1HBoZ+MwLFnrwSyQkkt7ejs+KRGTZu?=
 =?us-ascii?Q?3nwdtegkZcH2nKfZxL0FBdoyzG+sYSF7TzjecXKG5vYJojij1u9XRgmhYA7H?=
 =?us-ascii?Q?5LqSqF79QhOqL/CpQ67XcxxDvFLSxlhUzcc6vSc6D4IJIJs4yvFYsNemqhPF?=
 =?us-ascii?Q?RFMfyIWX5RQqrNm4KpYkeg2bTFm8VuRkg9AwX6rqaVJypMmQM+wgxA9Y7K24?=
 =?us-ascii?Q?6iaulicu/bGqaPiVQdUOUgXUmcqLqovijGkj1BBI4rAHEiynwv8dbzpb3Axk?=
 =?us-ascii?Q?5FVCL47JllOAs23G3b+P2P1hr45tirDrQABXyNMjmVoaIHH2vC2/cnCYYhIj?=
 =?us-ascii?Q?RS9Jmi73WVqgMigdN/Pg6+cQH3bl7J5nI+LudHwVGNxGNb/NYJPeeapqS6CE?=
 =?us-ascii?Q?yG0NT+4gFrjWAPWHARyvSebYZjWqn1oVDkTM2onQU1cbxHcxVMNeTq9xTJc5?=
 =?us-ascii?Q?al6on4wJ3eXtjxRWoiUATvPGXWC4kFY7/GMrh5+MUq7MuMyfqPOs/KldHPDq?=
 =?us-ascii?Q?bgF2833wd7D3nmad7Q7ElwaqgA4Or4ZuBKhR7zikeZRQYm0Of5A2O4zW2lKn?=
 =?us-ascii?Q?h69z7xCbQfOesv6AaRVe3aP3M4L+1PkPiggLYYU/jtP4LSwI77C4du/Vpx8v?=
 =?us-ascii?Q?uOiX6t5p1AvImX/bqSRqBLH2Wp4XXZK3Qb4Q0S5ATwlMMrOEnyqAJC07MZcH?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cd36ed-e465-4e17-9796-08dcdba21c65
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 07:34:09.0433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whec/9CzriHVPxnhh59l9xC+nWQPtQL8xBoxuPewNtqShYOjmRubnKc/0d3XuDmIEa5fwubUwwErTa6gLy01SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6250
X-OriginatorOrg: intel.com

hi, Chenyu,

On Mon, Sep 23, 2024 at 03:21:56PM +0800, Chen Yu wrote:
> Commit 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
> introduced a mechanism that a wakee with shorter slice could preempt
> the current running task. It also lower the bar for the current task
> to be preempted, by checking the rq->nr_running instead of cfs_rq->nr_running
> when the current task has ran out of time slice. Say, if there is 1 cfs
> task and 1 rt task, before 85e511df3cec, update_deadline() will
> not trigger a reschedule, and after 85e511df3cec, since rq->nr_running
> is 2 and resched is true, a resched_curr() would happen.
> 
> Some workloads (like the hackbench reported by lkp) do not like
> over-scheduling. We can see that the preemption rate has been
> increased by 2.2%:
> 
> 1.654e+08            +2.2%   1.69e+08        hackbench.time.involuntary_context_switches
> 
> Restore its previous check criterion.
> 
> Fixes: 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")

we applied this patch upon 85e511df3cec, confirmed the regression is fixed.

Tested-by: kernel test robot <oliver.sang@intel.com>


=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
  gcc-12/performance/socket/4/x86_64-rhel-8.3/process/50%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/hackbench

commit:
  82e9d0456e06 ("sched/fair: Avoid re-setting virtual deadline on 'migrations'")
  85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
  1c3386188ad9 ("sched/eevdf: Fix wakeup-preempt by checking cfs_rq->nr_running")

82e9d0456e06cebe 85e511df3cec46021024176672a 1c3386188ad9007c9975470c817
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    623219           -13.1%     541887            +0.3%     625154        hackbench.throughput


> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202409231416.9403c2e9-oliver.sang@intel.com
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 225b31aaee55..2859fc7e2da2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1025,7 +1025,7 @@ static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  	/*
>  	 * The task has consumed its request, reschedule.
>  	 */
> -	return true;
> +	return (cfs_rq->nr_running > 1);
>  }
>  
>  #include "pelt.h"
> -- 
> 2.25.1
> 

