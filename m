Return-Path: <linux-kernel+bounces-261905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAC493BDA8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805F41C21B40
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC52172BD1;
	Thu, 25 Jul 2024 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xk0gzQzX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A11B249ED
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894668; cv=fail; b=cHcCA/OVl97sXWntgww2jvi/IPS6hB8bicwkFUNxpmiitucPwAiyj7LM7tCkvAW1WCznCvoFQPGK1f0Cc16b8QtgNzQUcquwd4+VRtZGJjca/4lnqz80EBU3Yaf2k9s5YaL7tEt6HoHqeuB+2Ycle2aEaNXUflmM8xmfS6YwPTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894668; c=relaxed/simple;
	bh=KcHqqGyZ54en6S2oXQbHSyKpIJNXiCbKfAsqkeCdt/g=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=KPuAlEG6msTsdH/+Afy4wICtot0taLm3dRcnZ/UP0cWo5XdUL/Rn3zzPFFPg2hC1SSlQJerm+LcF6RpVb4jHVZnyLU7Ze55qY71AmmTHBgjnCelBg2Acz78vvYSXGYamJXNG0vv+yj9aRljhPwRWyHDM+CICaYv2DOxjkp3jlh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xk0gzQzX; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721894666; x=1753430666;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=KcHqqGyZ54en6S2oXQbHSyKpIJNXiCbKfAsqkeCdt/g=;
  b=Xk0gzQzXhCVpr/nr1FzCMACoGcc9hU5Op7fLDI4o0ylurk0+zG04/4tm
   Iqy3dLz7Nq3LuCrfgF/ogyXQKD+jn7oJzSEzD6kcJIwgzp22CUbvknHLm
   T951wH9mar/xTnc+Xei5k8OS5zrQyXRlHr4KK7yVCZSXaSqGf7oOpn9Ni
   zSotOMplzeS/2E6LmPcd3etV4MU6SF0+PhtjO6uwaA56i3PuBjZOBswxz
   cLIORFzIkuv4B5BWnHeMR8N/aVCvR1Lumjrnyis6sOJ6ZyqH3JqZCuk5c
   q8eUC4i7wo29CunD2dqy6wPjOSLN/VIjFkp4lCHNODDVn9QtR5GkoUvnn
   g==;
X-CSE-ConnectionGUID: QdNEAJa0T1yUFU6QUFpNuw==
X-CSE-MsgGUID: kPJ6S1RgTl2cRPoiuNy/zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19419979"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="19419979"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 01:04:25 -0700
X-CSE-ConnectionGUID: DYoFOuvvSqK8Rn7IPmBwBA==
X-CSE-MsgGUID: 4nGEgZr4SRGTR2PNSpR62Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="52764165"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 01:04:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 01:04:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 01:04:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 01:04:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cU2U5+bVcI7PmcLkFK1wZyi87iDfBHj/ZJwAATgboZMoGsvR236QjHXhFAFXTafaGj3USpd8IGwFCC1epFY4OMRj/oQlkc3zxTuToNTdMokOEmZMnbh8uHzsL1a+xUgKZCsiQcLPu4mIGx0z3WWrmf/dgZevqdeJOLupoMtqRWmsgO3vAbVtf+tawlec3iFE1pPS3QHB/gvJDdWSdwE4DaBipSz5vI6UQMZvP4yT0uQh9FfZadMPm5ULnvPxv0V5g5jSfKI4IMHBUTM4BqNruJsdwfVuiqYo7X+yrIKT0a9D35iBjJEJ/otC+tc1ww6HGuasNMOc2hBxFejgsJ7MOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQSGuExmG0jW3vyIZgDl/+atKxVcpDy7VPB+XlXlvO0=;
 b=t/6LdJzqAFFFjqbxM+6/6I4+vFJI7TA+flvCprLaHAD6H3lg/jAdAAE+ZgZDNYu1Tg4hAI6a78g2hjbrLD26kaLSNXtaWGx1MbH28MbfavRAmEecap2lhtiF+JCOzw2DAAO0DRI6cFcIdJcttS13jCidZqoZLhuH9gpEksGAI0P0vnqCs0bwpCvzmIIrsw2yaaEHEsZFk4O6KLxwL6NowrruEGVJJvU8fgWsFCfckP71PdRu+npNTsMbbl8CTY9yrOpc6PsSIqRhAVnMoqro4FTehlYu8N7y8i+cP1ailPECp8vWkS44fICUHZ3IIgN6b5rm8SPSoQTCtY4NUGkrhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW6PR11MB8438.namprd11.prod.outlook.com (2603:10b6:303:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 25 Jul
 2024 08:04:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 08:04:18 +0000
Date: Thu, 25 Jul 2024 16:04:06 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Hyunmin Lee <hyunminlr@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Jeungwoo Yoo <casionwoo@gmail.com>,
	"Sangyun Kim" <sangyun.kim@snu.ac.kr>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Gwan-gyeong Mun" <gwan-gyeong.mun@intel.com>, Christoph Lameter
	<cl@linux.com>, "David Rientjes" <rientjes@google.com>, <linux-mm@kvack.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [mm/slub]  306c4ac989:  stress-ng.seal.ops_per_sec
 5.2% improvement
Message-ID: <202407251553.12f35198-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW6PR11MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 80da3ba7-a151-4b5f-6374-08dcac80623a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Y1cc3cNu2IV3ivcEoM1zpmYntl0/irKg9JE5qDUb0bGPL/6g5BgdKMf/km?=
 =?iso-8859-1?Q?XoEm5lCMRYMiq4EvyTx2Wd6rZw58P7+uqux8Ds96B7OsLU9z495cPamswY?=
 =?iso-8859-1?Q?O6QCFilX1rFzwOvdNopYKOScevbe+slSGX6QDJ5wOcgmuKKmju9PSl2SIu?=
 =?iso-8859-1?Q?BfIcjD5FglUCenHKrZuFlTiqwVxAAEdrAo//jf4ugrQAI6KXk1V9VWAofW?=
 =?iso-8859-1?Q?/WCgGBKuXGc5uOdV2IsKSRjc3tTH7Z52cbgnhzCgULJnx20PJ5oRWnPH1B?=
 =?iso-8859-1?Q?MUSAe3S7RZheXZ8fLGiBQVoXldk6EQdVWNwVNzeYzQ61aXrKLqaPoBeeSu?=
 =?iso-8859-1?Q?4iog6QLUD8L789tEL3xWhkFBNtKsIuCemliVmaAqmHC4uu70wqmhEXj8Jp?=
 =?iso-8859-1?Q?fadoWizuLmm+n3GtQtOuof+vrcijfjXoByhOV/dwAZ7/v5iaJxJqCvHGZU?=
 =?iso-8859-1?Q?VcLu/OFyiHcqqacSGHA5sbWo/vMu/VCto51nhzS0zDTsBfqs0m+fCFkI+Y?=
 =?iso-8859-1?Q?WYplgmyC227W8IFpIqasG9UQXSZ9I2Xt3EYGXp6DZyWWSZ0YSquBvVrRoJ?=
 =?iso-8859-1?Q?8j1PUP7/IWj8A/DsMfRNsAZj7uILTFkUkibc4I1ffadr1bvLD5TDrgEleo?=
 =?iso-8859-1?Q?Y59z+65P0kvvwYKJMB6WMyHFvkz7o7sOuhYxXw/DqpQuNP0d5dBiVVTz3H?=
 =?iso-8859-1?Q?aw2nQ0LVcp990QVQNl3aXh9QVPxeoSyiSwSxYg2hLFdr6XosSZZ6zKMe4K?=
 =?iso-8859-1?Q?V31ShEfSyC5IpUxVkXtczpXhrN+syqYyiWXQH5ClukwPukN0923/sqNaHB?=
 =?iso-8859-1?Q?ymRrtfxs1vltJJwtH+xXgnnjh2kXC/zzXCbr08XLDYa99D8CZg90gpmnfs?=
 =?iso-8859-1?Q?1zRzvdEyrRyMOphuBXT6qLI8DvkgQgUUZVy5v7bNTwgWNJxz598iJ9aCKX?=
 =?iso-8859-1?Q?ONXFjdH5TVtdeAk0Fq7TAjbhkj3nTHInYxdUMoMgRwQuC+hD9azm8+i8Kb?=
 =?iso-8859-1?Q?CKzEldm/b00M2WS5oChk0TO/aJld5FKtq2OJP/uauzZZ+q/z7jq8QDLtS1?=
 =?iso-8859-1?Q?iTIt5KuU0q9XL1X5bsPnUhXtu7G7Kd3v6rc17ubV9Afsaqlz+VnW6WSizl?=
 =?iso-8859-1?Q?dq2guThZU8KAfzrZCWRh4eJZVKxoHSvGMZRzNObcCkZTbcwy+6+UZTNWUr?=
 =?iso-8859-1?Q?ea5iQpaOziXgymj0ZyHcLjHlpnsdfaKfs4QtfnNVSVKkiDx27SvWAkhkMi?=
 =?iso-8859-1?Q?rGSFFdCHbQZUYjwJDzRThc03EgveSsl0+8C65vrbiOv2NQ6qcccf4+VnY5?=
 =?iso-8859-1?Q?7kexrdzvy7kO2XfzupdeWf9g/7ibT2x78Id3RW5Nnut3w46b/oGGmo+l55?=
 =?iso-8859-1?Q?BCfi7caq0V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NxZqKHwhz6xtM3EKVHFmbyTFEyjK/I0E0VQG5OtAfsipiU+rjQLuj0G5i/?=
 =?iso-8859-1?Q?iikDO2pGzRWrdmjsvA2zSsU2rXFKNNTeiIS7YpQ4L1s5TBoDt14XbVLTI+?=
 =?iso-8859-1?Q?92HcbyWGk5V5v/v06FYir+BqLzXEB4eI5cGdIIQbCOTh1igoTtoE1xS+Bc?=
 =?iso-8859-1?Q?y61BN6GZEBWOqGIf4pkOKMlO0HRwIzocqW/EYZeALIvkbYLY4joX2ene5y?=
 =?iso-8859-1?Q?DWUUDw9xw1/i7JYUALQmnFoLlsMxEzTtrx6mxtThDvXHnNQDp8xcOzzv0D?=
 =?iso-8859-1?Q?0tWU3bOsizoTPBKmdKj/RS0wQIHPsBl8zlMdjfqc0Wu0L0TIBfgoASyqR2?=
 =?iso-8859-1?Q?fBVLNtxJRaFZkqx/vx/LNaMb/OudduKyP7PI9nMs8vHaOI+k5PQSNgk9Lh?=
 =?iso-8859-1?Q?CU/n0/Cw4Erwt31coLbRudqa4wvzU9Mo4co7M5QCskMmOO9me7yR6/3eZq?=
 =?iso-8859-1?Q?YCjV2RqfWhh7GuwD6BL7NyGkj4M9vqAFLHZdYQB/70zW+QhpiRbYgwhsr8?=
 =?iso-8859-1?Q?ce1oqsyAeT2cHdDfEQk6dmkTJ6Y7Ngm/GwEdS2BWWNWjmZZDw0jQKUBcB3?=
 =?iso-8859-1?Q?E1Xw664fyOKNGRneWBM7iEY5Yz61KtErzUG/9L5IAGjBHuIooE9fDM6roQ?=
 =?iso-8859-1?Q?AgnLrRfUDvwFBnJ5eexuH3GmIfK+0kz2zDALKZEV5XpVTjhwhSeaRKvpWj?=
 =?iso-8859-1?Q?NU0xpLyaOKMeMmYFJbu8wGOYl/6fL/Ko2L4HensMkRNmXGK6h842+O1oyp?=
 =?iso-8859-1?Q?r8Cj6880r8423HiYPIBgbYWNmGEvIKKze5McZE6s+1LW17CURYW6mdKqpO?=
 =?iso-8859-1?Q?dUtDAYfwujbFJ8fzFdggMHelWBuFOCc2IPWKw0gO40WTrpKvjUSfNVaAaa?=
 =?iso-8859-1?Q?i5Jiqr+YNlj+f4Gsxjemy6N6Y7BpdSoZ6S34T6K8EWNbXRabEXkuiOQMV1?=
 =?iso-8859-1?Q?Z+ZCK955hPghsVs1lNNQLi2vmYEPYQ/Oigy2ETeHe0s/8TYyNMP67TuAws?=
 =?iso-8859-1?Q?lda8u0M4GE7Nrxw22AGtU/SCQQnzJet2e8ZLDrM2H8KMDwH7WqvLTHmGC5?=
 =?iso-8859-1?Q?aRs954uQQB0w1ehObE1b2kWJtKHncfIzvjhzlouio6zOUYVhIZqlD0Y9Mq?=
 =?iso-8859-1?Q?6HvVm4Lac9CHBmFysJtDdfoH/pA6YxXrmLzOMQBqLIzGyzhqDdPvDsLoQM?=
 =?iso-8859-1?Q?bJCPtU2UysuJ5wQngPSk76T02hblGuxAh304/GpJn6Y91GR3LeKLztr+47?=
 =?iso-8859-1?Q?VzFjm/121rlXBl3jE/4KnwMDezxo/q6iujX0lLNuTpdNyzdRKUcYVjcO1h?=
 =?iso-8859-1?Q?jVEhH43lAn9aRXUyLPdl///75lngDCb9pF84fQiXsI33Hho7LIKl55TkUA?=
 =?iso-8859-1?Q?Jat2uO9QJcdXvmgNTXedskBPXObX5zi2gIzjmD3bWIowKAb4mciTgATTZq?=
 =?iso-8859-1?Q?lv2BZ98KYfQ0t+E5nJu5fuOUcLsHDlCeHPK6dwEB78L9qq2HukfGZNFj8/?=
 =?iso-8859-1?Q?bAmSKXN9IIViyWAYIb2z/viDvVzBbhWkWojIUkAT/z8L63cv9BQz6TB8jZ?=
 =?iso-8859-1?Q?p/R8rr9Zl7Dd5y6aAWta94WQsUDw6HfkgzaByu4qPrj4TpxL2HjWJiNmLr?=
 =?iso-8859-1?Q?SBFgdjGbZCGPRIYZTH0MAmlUJQGHS0JAIOsnIaJF70t77SrYXZZJl+iQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80da3ba7-a151-4b5f-6374-08dcac80623a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 08:04:18.6670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzlBWvuQObWmZcERanBKNqWlPm3qzb0V91rBa1eFNxvkbujkNJR2lj/CQVEAnTODz9nvB7dyPxFfDKVSi6a4sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8438
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 5.2% improvement of stress-ng.seal.ops_per_sec on:


commit: 306c4ac9896b07b8872293eb224058ff83f81fac ("mm/slub: create kmalloc 96 and 192 caches regardless cache size order")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: seal
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240725/202407251553.12f35198-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/seal/stress-ng/60s

commit: 
  844776cb65 ("mm/slub: mark racy access on slab->freelist")
  306c4ac989 ("mm/slub: create kmalloc 96 and 192 caches regardless cache size order")

844776cb65a77ef2 306c4ac9896b07b8872293eb224 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2.51 ± 27%      +1.9        4.44 ± 35%  mpstat.cpu.all.idle%
    975100 ± 19%     +29.5%    1262643 ± 16%  numa-meminfo.node1.AnonPages.max
    187.06 ±  4%     -11.5%     165.63 ± 10%  sched_debug.cfs_rq:/.runnable_avg.stddev
      0.05 ± 18%     -40.0%       0.03 ± 58%  vmstat.procs.b
  58973718            +5.2%   62024061        stress-ng.seal.ops
    982893            +5.2%    1033732        stress-ng.seal.ops_per_sec
  59045344            +5.2%   62095668        stress-ng.time.minor_page_faults
    174957            +1.4%     177400        proc-vmstat.nr_slab_unreclaimable
  63634761            +5.5%   67148443        proc-vmstat.numa_hit
  63399995            +5.5%   66914221        proc-vmstat.numa_local
  73601172            +6.1%   78073549        proc-vmstat.pgalloc_normal
  59870250            +5.3%   63063514        proc-vmstat.pgfault
  72718474            +6.0%   77106313        proc-vmstat.pgfree
 1.983e+10            +1.3%   2.01e+10        perf-stat.i.branch-instructions
  66023349            +5.6%   69728143        perf-stat.i.cache-misses
 2.023e+08            +4.7%  2.117e+08        perf-stat.i.cache-references
      7.22            -1.9%       7.08        perf-stat.i.cpi
      9738            -5.6%       9196        perf-stat.i.cycles-between-cache-misses
 8.799e+10            +1.6%  8.939e+10        perf-stat.i.instructions
      0.14            +1.6%       0.14        perf-stat.i.ipc
      8.71            +5.1%       9.16        perf-stat.i.metric.K/sec
    983533            +4.7%    1029816        perf-stat.i.minor-faults
    983533            +4.7%    1029816        perf-stat.i.page-faults
      7.30           -18.4%       5.96 ± 44%  perf-stat.overall.cpi
      9735           -21.3%       7658 ± 44%  perf-stat.overall.cycles-between-cache-misses
      0.52            +0.1        0.62 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ftruncate64
      0.56            +0.1        0.67 ±  7%  perf-profile.calltrace.cycles-pp.ftruncate64
      0.34 ± 70%      +0.3        0.60 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     48.29            +0.6       48.86        perf-profile.calltrace.cycles-pp.__close
     48.27            +0.6       48.84        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     48.27            +0.6       48.84        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     48.26            +0.6       48.83        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.00            +0.6        0.58 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     48.21            +0.6       48.80        perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     48.03            +0.6       48.68        perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     48.02            +0.6       48.66        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.__x64_sys_close.do_syscall_64
     47.76            +0.7       48.47        perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.__x64_sys_close
     47.19            +0.7       47.92        perf-profile.calltrace.cycles-pp._raw_spin_lock.evict.__dentry_kill.dput.__fput
     47.11            +0.8       47.88        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.evict.__dentry_kill.dput
      0.74            -0.3        0.48 ±  8%  perf-profile.children.cycles-pp.__munmap
      0.69            -0.2        0.44 ±  9%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.68            -0.2        0.44 ±  9%  perf-profile.children.cycles-pp.__vm_munmap
      0.68            -0.2        0.45 ±  9%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.65            -0.2        0.42 ±  8%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.44            -0.2        0.28 ±  7%  perf-profile.children.cycles-pp.unmap_region
      0.48            -0.1        0.36 ±  7%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.42            -0.1        0.32 ±  7%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.42 ±  2%      -0.1        0.32 ±  7%  perf-profile.children.cycles-pp.exc_page_fault
      0.38 ±  2%      -0.1        0.29 ±  7%  perf-profile.children.cycles-pp.handle_mm_fault
      0.35 ±  2%      -0.1        0.27 ±  7%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.33 ±  2%      -0.1        0.26 ±  6%  perf-profile.children.cycles-pp.do_fault
      0.21 ±  2%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.lru_add_drain
      0.22            -0.1        0.15 ± 11%  perf-profile.children.cycles-pp.alloc_inode
      0.21 ±  2%      -0.1        0.15 ±  9%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.18 ±  2%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.unmap_vmas
      0.21 ±  2%      -0.1        0.14 ±  7%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.17            -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.unmap_page_range
      0.16 ±  2%      -0.1        0.10 ±  9%  perf-profile.children.cycles-pp.zap_pte_range
      0.16 ±  2%      -0.1        0.10 ±  9%  perf-profile.children.cycles-pp.zap_pmd_range
      0.26 ±  2%      -0.1        0.20 ±  7%  perf-profile.children.cycles-pp.shmem_fault
      0.50            -0.1        0.45 ±  8%  perf-profile.children.cycles-pp.mmap_region
      0.26 ±  2%      -0.1        0.20 ±  7%  perf-profile.children.cycles-pp.__do_fault
      0.26            -0.1        0.21 ±  6%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.19 ±  2%      -0.1        0.14 ± 14%  perf-profile.children.cycles-pp.write
      0.22 ±  3%      -0.0        0.18 ±  5%  perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      0.11 ±  4%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.mas_store_gfp
      0.16 ±  2%      -0.0        0.12 ± 11%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.14            -0.0        0.10 ± 10%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.08            -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.msync
      0.06            -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.mas_find
      0.12 ±  4%      -0.0        0.08 ± 11%  perf-profile.children.cycles-pp.inode_init_always
      0.10 ±  3%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.shmem_alloc_inode
      0.16            -0.0        0.13 ±  9%  perf-profile.children.cycles-pp.__x64_sys_fcntl
      0.11 ±  4%      -0.0        0.08 ± 11%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.10 ±  4%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.do_fcntl
      0.15            -0.0        0.13 ±  8%  perf-profile.children.cycles-pp.destroy_inode
      0.16 ±  3%      -0.0        0.14 ±  7%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.22 ±  3%      -0.0        0.20 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.08            -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.___slab_alloc
      0.15 ±  3%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__destroy_inode
      0.07 ±  7%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.__call_rcu_common
      0.13 ±  2%      -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.perf_event_mmap
      0.09            -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.memfd_fcntl
      0.06            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.08 ±  6%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.12            -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.11 ±  3%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.10            -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.uncharge_batch
      0.12 ±  4%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.05            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__d_alloc
      0.05            +0.0        0.07 ± 10%  perf-profile.children.cycles-pp.d_alloc_pseudo
      0.07            +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.file_init_path
      0.06 ±  6%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.security_file_alloc
      0.07 ±  7%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.errseq_sample
      0.04 ± 44%      +0.0        0.07 ± 10%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.09            +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.init_file
      0.15            +0.0        0.18 ±  7%  perf-profile.children.cycles-pp.common_perm_cond
      0.15 ±  3%      +0.0        0.19 ±  8%  perf-profile.children.cycles-pp.security_file_truncate
      0.20            +0.0        0.24 ±  7%  perf-profile.children.cycles-pp.notify_change
      0.06            +0.0        0.10 ±  6%  perf-profile.children.cycles-pp.inode_init_owner
      0.13            +0.0        0.18 ±  5%  perf-profile.children.cycles-pp.alloc_empty_file
      0.10            +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.clear_nlink
      0.47            +0.1        0.56 ±  7%  perf-profile.children.cycles-pp.do_ftruncate
      0.49            +0.1        0.59 ±  7%  perf-profile.children.cycles-pp.__x64_sys_ftruncate
      0.59            +0.1        0.70 ±  7%  perf-profile.children.cycles-pp.ftruncate64
      0.28            +0.1        0.40 ±  6%  perf-profile.children.cycles-pp.alloc_file_pseudo
     98.62            +0.2       98.77        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     98.58            +0.2       98.74        perf-profile.children.cycles-pp.do_syscall_64
     48.30            +0.6       48.86        perf-profile.children.cycles-pp.__close
     48.26            +0.6       48.83        perf-profile.children.cycles-pp.__x64_sys_close
     48.21            +0.6       48.80        perf-profile.children.cycles-pp.__fput
     48.04            +0.6       48.68        perf-profile.children.cycles-pp.dput
     48.02            +0.6       48.67        perf-profile.children.cycles-pp.__dentry_kill
     47.77            +0.7       48.47        perf-profile.children.cycles-pp.evict
      0.30            -0.1        0.23 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock
      0.10 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__fput
      0.08 ±  6%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.inode_init_always
      0.06            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.08            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.09            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.07            +0.0        0.09 ±  7%  perf-profile.self.cycles-pp.__shmem_get_inode
      0.06 ±  7%      +0.0        0.09 ±  9%  perf-profile.self.cycles-pp.errseq_sample
      0.15 ±  2%      +0.0        0.18 ±  7%  perf-profile.self.cycles-pp.common_perm_cond
      0.03 ± 70%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.06            +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.inode_init_owner
      0.10            +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.clear_nlink




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


