Return-Path: <linux-kernel+bounces-323215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 010F7973994
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4981F25592
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D85C194145;
	Tue, 10 Sep 2024 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFRlXRKh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1616F307
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977688; cv=fail; b=oNJGCSrShFaxbR7n9toEgYirjNKQAtKS+ZDzjkPjXMd43nG0fmuAjhewdt/rUsRu8mD0mXA2HXqZG+XMv3/pmvBx2OTjySNQYHNzImUGd/qoa+AqxHz7Lymq3IM2wjrxWkE3nKPDEa3oxHtwfKAbeBiVnJ0uPJYmUVu1ssMvcWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977688; c=relaxed/simple;
	bh=bZtMD3j6bOXV8CQoP/CvBcar9RoZbfQS5E+1m8lnhtw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hQe+p/u3ecGYGf2u+GX6DhMlGI/eqUnZJFUIl0G6D/JzlDCQ6j1+kFDxoISr41CUoubBkIH723CyXSmVHBWNEUdF4tSbK/1SjSBD84hphR7ZKUjrtUmrgJZEWe9+bQIGi08FzkBbXVVgx3v94jvFN9tYa9ycBYwW/myPTXvDCnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFRlXRKh; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725977687; x=1757513687;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bZtMD3j6bOXV8CQoP/CvBcar9RoZbfQS5E+1m8lnhtw=;
  b=LFRlXRKh6bs3xJZ5xKBqjnvMwbf1+uBrWoFM0I64LsoQKYaNpkqQ/0UW
   TxfTkSebIVygizONS6qyAGS/AT3biEWq+2x4KdVPOCydooSV6VFPlG5CA
   TGCE68VpWcEU5PZTMfJmCWx3lVT4FimsvIGu8SbXzr594EJMwq1vF3GmI
   x/rMXq6oP6arTdf0Woq911uRwlF4DRPbJJ24ZUPtj16uDE7WpnYtXURqx
   okLn8mdMR6JhFnUtda3MzVkI947eDCL1ACExCI7avUv86txiUGVuBSLWr
   mMTFt/VA1ld/dOEtABrFE+FevW2HZB0y/dj6/H+apWPrCMGILImM0suwi
   Q==;
X-CSE-ConnectionGUID: FEiY25XCSOqIz29T/c7DdQ==
X-CSE-MsgGUID: blJA+r+/TeqR9DeQPA3vbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24665162"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="24665162"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 07:14:46 -0700
X-CSE-ConnectionGUID: Fn1dYGxpReCShy9WOr71Gg==
X-CSE-MsgGUID: pcdLy1F9RWKGJLJS84shgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="67805582"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 07:14:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 07:14:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 07:14:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 07:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9TckCrKA8HkALTLfO+kK8ml7LtCCotb8fkCgDQ/ZFUQ821AiXstJNMxdf7ii3N4znRhyC4Dlxm0Gbm/BH45StqdLcDbtAyruVCNikBMdfSyFG7zJ4y0h3M2HBDW9uxo9ZDUchXSu8MFT5okuKu2Y1GfqDEcxgIg33sc7R9CSjIuh5CxXHKfKSsqMhF/AGSbUmAwNfUbM3beiwc0D5apMY/PUulLyXujjOOwHNWn9EUZTQjowxh8/CE5vCqgmaUQ194/72RLxm7L4PZq3w2fXwLmSVZSLGEjxbY3zow2j6+AlNuzLOmdDDUCGXPudc/UZi0A/bX4SNtJPFvy3X60Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUUuJyYLxcmQ7nBuaz3+uFUy9Y7wbU/sjLUBjcBmdPM=;
 b=PKwal17cQyswkGl9LPewhQRqjJlAjPEoE/uSymVUQ8b2zefLCpkXsF0Bj2NBnrAYvkNd1FxB8OhwV4qQB1CikwB9sOT8T5ys+GK0HTlw587x6gH73vUDV2No9NaIhdTM0mlz5ljQZjDHdPN+Vp728OpQTKRYsUPwPIy41q/LMCE8/UO/dpKJCIKnUVLqVNQG2KQMOV1faUO/TPerGRj0lvBMl2+KSpnjfEK7P65CQONDQ1doSzCIuBE9Ip9UrQuLZD5u4Hib21gtNlK1pzdSiL8vlmjxeJp8oOEl7bXbEO8e0fX5DaqkNiXz7g+e1OgAaZ2gS2Jq0aWguHvndjITGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MN6PR11MB8146.namprd11.prod.outlook.com (2603:10b6:208:470::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 14:14:41 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%5]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 14:14:41 +0000
Date: Tue, 10 Sep 2024 22:14:29 +0800
From: Feng Tang <feng.tang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter
	<cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes
	<rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin
	<roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Andrey
 Konovalov" <andreyknvl@gmail.com>, Marco Elver <elver@google.com>, Shuah Khan
	<skhan@linuxfoundation.org>, David Gow <davidgow@google.com>, "Danilo
 Krummrich" <dakr@kernel.org>, <linux-mm@kvack.org>,
	<kasan-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] kunit: kfence: Make KFENCE_TEST_REQUIRES macro
 available for all kunit case
Message-ID: <ZuBURfScdtDbSBeo@feng-clx.sh.intel.com>
References: <20240909012958.913438-1-feng.tang@intel.com>
 <20240909012958.913438-5-feng.tang@intel.com>
 <4b7670e1-072a-46e6-bfd7-0937cdc7d329@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4b7670e1-072a-46e6-bfd7-0937cdc7d329@suse.cz>
X-ClientProxiedBy: SG2PR06CA0228.apcprd06.prod.outlook.com
 (2603:1096:4:68::36) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|MN6PR11MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: eab63e3d-589d-4d87-6eb7-08dcd1a2e9a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EMSLLnUZ425zid4JCzwYww68bBGBOeNBHcVaST+NMxWc4vGZ0Op/u+FgzRB7?=
 =?us-ascii?Q?QvT4InqdSGqnqRBPtY9QBJsMtrLuR1ROVoqtDUV32R/n0nGWTyhKizb0xeIL?=
 =?us-ascii?Q?A4U6SBXymAUFOey4smlmdivU2Ro2iEFCz7X5ydZ1b7p0xw2h+rcz75aAZdqk?=
 =?us-ascii?Q?dvc9ud1XyY3ZGDBGpWPHqYQ1WstbPxNgfgCZFCYui1Vzrcs9Iyo6l7/Wjtpm?=
 =?us-ascii?Q?ggoigzDGTW4lUEYdcpyf3uGWs/uethhku8aLUURSCoryaZvIEULNn5XfHov6?=
 =?us-ascii?Q?8SSK/LyNEpatimlM41wZl9vOYvSj8RlCDGhWjdNxg9ax/NEd9y1YBBpHrzi7?=
 =?us-ascii?Q?1dx9OcKrMxAVz4td6P2tXkD+rTXU30aXoO6HZBj5qhmWxxOMjiZuSpl33i4z?=
 =?us-ascii?Q?LMkE6sOLU4dDLpE9zvq75KvuuDjwe/ujs0+5G/yhh4RfolfMkLea73a+QfQa?=
 =?us-ascii?Q?yUNPDAqlKY4VZ1Vdn1UWaHtaJT3SnGwU75A2TuQrEtnAcTpdO8CPhAFMEqNo?=
 =?us-ascii?Q?y2ny8ffI5zSHA/nd4F6O94/nbcKyC6s6RjyZ72cMJBM1gQajrKmVTvpBm29y?=
 =?us-ascii?Q?/06wLzISgFUubVfCdzRVqZt0MU3y1gJ8Woa2/1nZR05rEljiJ0FrR0xrlBQA?=
 =?us-ascii?Q?RA1HviF/pQRobZmm4zY9kxOAZpBogpnJQvNGOy1FqI56NnyD38WZtW98/StV?=
 =?us-ascii?Q?EYQPNdOnK+2hhQMWclpmm8obPsvRjEIsQ/keFIp4bH/SNKsqqoR2HPgz4Cwm?=
 =?us-ascii?Q?wUsS8dnZvJN5NfaTGREAHbPTN3iHZWziZxDTGXZnkeeFJddXKOYdYQXf3bo4?=
 =?us-ascii?Q?pV6sDxinqpTEmQ+oFoYwJyDPkdNyvSVFqX6CNcu8E5ZSZHlrMnTXFR67Veih?=
 =?us-ascii?Q?oU2XHtc4tnsyh8gwcbXPssJ3KEeoYc5GR9NKAz7zRVW5W4AUGXzkFS7kde2J?=
 =?us-ascii?Q?nuX6iVTyQBxGfLZXhRb18niRkxAQc5xNqK3H4xJMt8cTTOcdkXKPMJnKe5JF?=
 =?us-ascii?Q?zxQrkKIjZJAYIJ0JcsAvYkdH+1hu4Mw5MQ2p1xJ5o5yXTyRCMWiEdj2VL6sx?=
 =?us-ascii?Q?LMehq7+BFSz8h4Cd4qV5w6ZuNpQlPdMzKrsFg3VXyN6d+gGTPMREmAIe0mLt?=
 =?us-ascii?Q?rB445ZHaqWDmh7LN2NFt7q4S1u1l9O4PjN+Bdz7SjhLvJNYOxqhicSY6m4KG?=
 =?us-ascii?Q?AduiiZvUUM/4gV4rLBoIEeNYwlwKfIqcARJ0TT6EPysLlKLybPtNUs9tUGsf?=
 =?us-ascii?Q?ycsZn5pNhOwzzz+jnx1XyHsto1+Bk6O+YfDvtd7e/rTgh3B4e88CTW6Xm048?=
 =?us-ascii?Q?pHjfs+2mIWVZ+uipVufWJzit1wKY9mZ6BYLI3Tc+tZ28Qw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lqsuNYSJvQKjGp00kaAcoRpyuNCH/avug+eot0OTOFvwSYvGaSoU/YmL6b9T?=
 =?us-ascii?Q?QMiD6gNLAo7teR9tgas0pR8cH6eEf/itO60fj4vwSt2hx+K2DgaWSzUu5i3T?=
 =?us-ascii?Q?jsjgOO7ZCTgsiYdMEItUBGE+lcowLylMr8L44fem9QGrHE94FWGZGtf01ppF?=
 =?us-ascii?Q?QueuPd6bRFF+7pzV5/i8RNHIhgVkNa3GlInOdbceBnH2Ug8ouIAvfAYTjmZO?=
 =?us-ascii?Q?VeB09ns6qJSaCO357x/TxnLc3pexR3goAxUwsV7jJ01yban/kYHq3DxqHYZa?=
 =?us-ascii?Q?HFtBvUCaohkH7SwBeXyG7X6TP7qnrc5DLLFeruaH5mP9mWtFOKDY0X5R/InB?=
 =?us-ascii?Q?7Qwc2rb1Mi1VMgJAAWDWHQhLMtUY9mshVvPXQKgdqg2f/tvP4DeQ50nKG/Ft?=
 =?us-ascii?Q?c0+QpQSTVsr2SvJg/JzHqLb7ymZYGrIfbA/yiuQVwsGKMgzdWbgW9SJNMlQT?=
 =?us-ascii?Q?ch5Ej82+XhC+BIRObcArS7ttNNscy2s26D3bNMd98WUtRS+iPu1PGkxzR8vr?=
 =?us-ascii?Q?F/u/7AyuL+TrTqaAyhGxrlcL0fuk2S/jvATlgtIk+a8hOvtvlYUbieDG+EaM?=
 =?us-ascii?Q?ZFIhK94sTVrzPaRUWreaPgqolrkFwXaML8NdPh6BAkeb7T8v0PrpvYHfUdst?=
 =?us-ascii?Q?9lagwedchJUoueyb4E330zDF84N9vMJosPv41WmTttfKGExuUZBpL6Rh61YT?=
 =?us-ascii?Q?YOOQqioHlFf5jDCF6RT+g0zDa+XB5BMrVcSKqz9kxX5FahulgLzH8WpUxaRm?=
 =?us-ascii?Q?NJ8Ry7afv72fs27W74KvEiYh8w7tEtRgBvai7sh+3qW411ekvswJ0g5onAr+?=
 =?us-ascii?Q?43vKkwyLg/iDPc9a9Ro7gv/r2ig7AhIxzt45oyEcKr3yg0fjEBsGPnlF0iA8?=
 =?us-ascii?Q?nz8UPsqzWunc3yFwx2TI6g605VnJv3WxB5zBUjG7xIlIFrJYicEC/UyLzDbp?=
 =?us-ascii?Q?8/hztbs/a3P+tPFo2pLfteureV1Q88mISU1dyGbJkdHj1rxmkuOvb9GtZUr9?=
 =?us-ascii?Q?W9tM6RQL4INxVuXEuHMc4I6+k3g1dhXkxF5cyv6kMCYnZb5wF8BNRlPd+u9U?=
 =?us-ascii?Q?f2mXoeEzun+R1XjKJ8GpvVhGWA7XbtzEs7N3bR7KhTU8/9r03eSkVdP2emX4?=
 =?us-ascii?Q?ajJENRzIhpYnf97o2iaguwuetKOCoE7sX70XQdwS3tNHNd9vLyFwEozG105h?=
 =?us-ascii?Q?2A/ZRT8CmdrGvD0Z127+v0X2HCLb0yrIp2XuW3sB3I9G6pG+iKcKlwKl8Oqx?=
 =?us-ascii?Q?G8KXQfpwYjru/RPd1vrRaFZA0o/0f4959OzsX3H76GWjYMdLNJ4BEDt3p/Xp?=
 =?us-ascii?Q?QFFLIwPd1jsO2dnKZSVPMtOzoKPXEsupDfXxtnbgK2u2tJpAvdZvyhWcCtgn?=
 =?us-ascii?Q?+aeTdhjVL4s+cGSh5tgTxuz7nzjVOmlX3E4JAxTBKQgTTUcAq44bQKM2iZZd?=
 =?us-ascii?Q?Eb/43vfi+xagKF+wpH6D5ar/+qj4o7z8bpqwFMxpAZmeuvDbmdHtDIO9oq0Z?=
 =?us-ascii?Q?w8ANDag4jJzuCzmSODk3LPSz7zT9f634FVHnS9yGcaEoXOWu9Xt/FVcPKUk4?=
 =?us-ascii?Q?y/spyzlto4O/baChiGUMvf1iFoods8hqWgE8IKB7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eab63e3d-589d-4d87-6eb7-08dcd1a2e9a3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 14:14:41.5323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qf7DYT/r3nFTJU54YXQXw+EGoicqijPZYIm/CoO5nENZ7iV7DgTL9jxMhmdwsO5EdpCNCPZXrJhRq7TMgqMkEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8146
X-OriginatorOrg: intel.com

On Tue, Sep 10, 2024 at 03:17:10PM +0200, Vlastimil Babka wrote:
> On 9/9/24 03:29, Feng Tang wrote:
> > KFENCE_TEST_REQUIRES macro is convenient for judging if a prerequisite of a
> > test case exists. Lift it into kunit/test.h so that all kunit test cases
> > can benefit from it.
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> I think you should have Cc'd kunit and kfence maintainers on this one.
> But if that's necessary depends on the review for patch 5...

I added Marco Elver, Shuah Khan, David Gow and kasan-dev@googlegroups.com 
for kence and kunit review. That should be incomplete, will add more in
next verion. Thanks for the reminder!

- Feng

> 
> > ---
> >  include/kunit/test.h    | 6 ++++++
> >  mm/kfence/kfence_test.c | 9 ++-------
> >  2 files changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 5ac237c949a0..8a8027e10b89 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -643,6 +643,12 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
> >  	WRITE_ONCE(test->last_seen.line, __LINE__);			       \
> >  } while (0)
> >  
> > +#define KUNIT_TEST_REQUIRES(test, cond) do {			\
> > +	if (!(cond))						\
> > +		kunit_skip((test), "Test requires: " #cond);	\
> > +} while (0)
> > +
> > +
> >  /**
> >   * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clarity.
> >   * @test: The test context object.
> > diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> > index 00fd17285285..5dbb22c8c44f 100644
> > --- a/mm/kfence/kfence_test.c
> > +++ b/mm/kfence/kfence_test.c
> > @@ -32,11 +32,6 @@
> >  #define arch_kfence_test_address(addr) (addr)
> >  #endif
> >  
> > -#define KFENCE_TEST_REQUIRES(test, cond) do {			\
> > -	if (!(cond))						\
> > -		kunit_skip((test), "Test requires: " #cond);	\
> > -} while (0)
> > -
> >  /* Report as observed from console. */
> >  static struct {
> >  	spinlock_t lock;
> > @@ -561,7 +556,7 @@ static void test_init_on_free(struct kunit *test)
> >  	};
> >  	int i;
> >  
> > -	KFENCE_TEST_REQUIRES(test, IS_ENABLED(CONFIG_INIT_ON_FREE_DEFAULT_ON));
> > +	KUNIT_TEST_REQUIRES(test, IS_ENABLED(CONFIG_INIT_ON_FREE_DEFAULT_ON));
> >  	/* Assume it hasn't been disabled on command line. */
> >  
> >  	setup_test_cache(test, size, 0, NULL);
> > @@ -609,7 +604,7 @@ static void test_gfpzero(struct kunit *test)
> >  	int i;
> >  
> >  	/* Skip if we think it'd take too long. */
> > -	KFENCE_TEST_REQUIRES(test, kfence_sample_interval <= 100);
> > +	KUNIT_TEST_REQUIRES(test, kfence_sample_interval <= 100);
> >  
> >  	setup_test_cache(test, size, 0, NULL);
> >  	buf1 = test_alloc(test, size, GFP_KERNEL, ALLOCATE_ANY);
> 

