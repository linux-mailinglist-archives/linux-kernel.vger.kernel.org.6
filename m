Return-Path: <linux-kernel+bounces-180577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED2B8C7064
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721071F21BC2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B0B4A20;
	Thu, 16 May 2024 02:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2s1wUe3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE75C443D
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 02:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715827368; cv=fail; b=FsygoATz2E9qp7LfKleD5voi0FgTOxO6IBfFHZVB1T//SDD8U0jmUTa60iGYWgoaYPXzbVPLuQn2bUDQfKmcj5YhgPIfcEvsrQv4EOIFKXN6OGtxkD8/IYkjn7agIVy6Vo7tMLYgrJ7RxpeCSySNT1DUHA+Dz5Nt8W6TRFeyXr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715827368; c=relaxed/simple;
	bh=e19pT83QsUmMPRK/X77+7umk7zqMcAxjnT+JHTrtJFQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=My8mojiGKY8WZmHJBC5nm81Jqh3xdCYItrcXYWkBKuPzmGZoQgt236f/+Sl46yscdaGINpxW+ce/qN+fu1pvv5Ddi5Caib4xgk1F52yc85WpQYgWGXDkKDzdK6DWOOMlQBe85t7chKXocyE9mCLNTGIPtTQW5CBOSppgCYNGwdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2s1wUe3; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715827367; x=1747363367;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=e19pT83QsUmMPRK/X77+7umk7zqMcAxjnT+JHTrtJFQ=;
  b=D2s1wUe3qZb7xnm09nMTnQkLg/I8ghEB6h6doJMmDY4MMcWzuOVR+a1W
   JDPTShhx0bTwzKli/PRY8qzmpZozJdU9Z4BoszuVbnb64KBE0X7wViyJF
   DjAW97tw5GwcC7t10cdMRXWHLICtQCzhqX1o0mdTfTw7qv2UTjdhZnyx4
   fTfkZvbZa9AuWqZzKNf8KvNm0mMaRTDohk37neyb0y22PiSFMEOx5eaBX
   jNvqc3oB9hU9FTecfBJYpK/agQLQ6yUd78qFRRbKNhZP/sgZ/e4gPC+b2
   A5/nVjIbTPFHlsVNfA/pRkIvmOjH/X6NGfYbhs+O2nnIoDwII6YF/oUev
   A==;
X-CSE-ConnectionGUID: 7dI/BbDtT+yo8ut8uGL8Xg==
X-CSE-MsgGUID: D8QhIv55QKuyNokMhbNLNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15740275"
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="15740275"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 19:42:47 -0700
X-CSE-ConnectionGUID: 2w5IQS0fQe+rLCSNkMyJRA==
X-CSE-MsgGUID: q2Bs065zRqavJPlxCVIsaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="31839991"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 19:42:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 19:42:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 15 May 2024 19:42:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 19:42:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cu9GDlZRsfZQMZeu+urAVLizKuqr5sPulohdblaz+UPXUyTm6dZ+l0oMaOs1rGz/EULcTtcODLOf80AwfN8a0V9+x0N2U1PKR4cojBwiX8eYWN5JWoCobCL8SarsUzMAvX4ID2PRjNcGRrMRVwKTGf++MKMu253lxmPB/hft9zgoP4AwwUNJbL9WifdfyNLjQ5Pd3ULFQkF9hO8brQW/LL/s1h2Oyx/lnjVgjnbx47fcidd10KSG0IK+Y3BSsmc12/yxk9jBzmhuKmhI2S+mu1fmBDF/mr/tQDaPqqCRDI7AAAcL0v3oSN/vnwyXj/z7st8Tc7fTCXA2X32rxWUJLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPSIY08X8ESvw7jE91V3yu+rAfcqoxZ1nJXjzoBOlY8=;
 b=X/gYKyxTH8R1gZBuHcVRXvqDuDDniZhEW5HGRoHfb3rfkjDfpWACN6INcRj0C3iyUIrJ++s3f84LuUp56++uwGxxqPsW3FbBdnuIZbkw2W4WDL50T7lyvuep7JMpzfSdP+tkUZ1cpzVzWFd7A2g/2T8vmPuXJDGePo/BheQwG9Jjpd7B9ipN5X5Bw1m6rBXChUKA378A8Dl4Sxgs6ah3XEw59g5E6kUN4mPkJq3RfGqa75D8/4sXHLKDbIPCXA3uCTewMx6lXB1kzFOaS8Z0yXmjWRyfyg+kdtKq25MvWqq2P4F3B4gncMF4v2UPd48irN76t40GOlFq2AJVpkkbsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA3PR11MB7656.namprd11.prod.outlook.com (2603:10b6:806:320::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 02:42:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 02:42:42 +0000
Date: Thu, 16 May 2024 10:42:34 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Frederic Weisbecker <frederic@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen
	<anna-maria@linutronix.de>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [timers/migration]  61f7fdf8fd:
 netperf.Throughput_Mbps 2.7% improvement
Message-ID: <ZkVymlX8xZ76fdfd@xsang-OptiPlex-9020>
References: <202405151553.6423572f-oliver.sang@intel.com>
 <ZkTDNsKXs0VCHiaf@localhost.localdomain>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkTDNsKXs0VCHiaf@localhost.localdomain>
X-ClientProxiedBy: SG2PR02CA0092.apcprd02.prod.outlook.com
 (2603:1096:4:90::32) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA3PR11MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 957e2d34-25e1-4446-0309-08dc7551dc11
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Ivy4u3YSPVz8fGa+SsU40/ctO3BumdZHtiLZgjkjxGPdYIXcIDizmX8Fv/?=
 =?iso-8859-1?Q?MB/s7DO9tZZdvwzAVme9nKoakWGCWXoTJ9SJRLx+LR5JxWtHVRh9qDAQ7X?=
 =?iso-8859-1?Q?yPhVheMNWZF1MQByLO5fwFyTPJ6+qpew5SaJTubBU9PlHlpazazKJcCDLn?=
 =?iso-8859-1?Q?Nu76ua602GCuTqiaO5ZH5NuDCKhBFCH4+fVhanpkFLXlF45Ht7rcRN5O4s?=
 =?iso-8859-1?Q?6YE9leXnrS/dL7RNwItoGz6tQmlSzn03eGudgaJtGuukWgEkaW3QMGXheg?=
 =?iso-8859-1?Q?SvRQEZzn+5Vxhy4b3jCTbrd20TYXma7JMerWG5Sy4CMcB0R8QUwYvgGNI3?=
 =?iso-8859-1?Q?zaR/dfAOAuTMAMaXq44abPuylmLzIJBKUQHrH8MX3LCmYeK31gjqJ48CA/?=
 =?iso-8859-1?Q?Ke0A/++ufeTZB6zex/uey8UVY8P5qggp1ICpLevL8YWuQcl2EYImitavhe?=
 =?iso-8859-1?Q?WvPSfX3n3I12CdJnZ5rdjN4E5TKRYc4n53twJ1duC4qqBO2Tp/rmvK9NKq?=
 =?iso-8859-1?Q?k3k/RB7+cpiDlrjNAii6VdrCQ1SY97OphsP6QsrsVljIA+Rpgo/0tDZceB?=
 =?iso-8859-1?Q?pdaT2s5AThfK4jwDl+lf6n1OrCrmBQ31hh9GRUz0ZSi2lkv7S9W3L9mD3Y?=
 =?iso-8859-1?Q?zLIeQd08gJQaDqXaVX2IRmgN7v9J+JtmgQj61vXAOf2Q/UUjvi2hJsjGvw?=
 =?iso-8859-1?Q?qukcOg5jXjCEhLMzKDTeBvia3FEuCCwW+EGbGvT8bTCLVQLiGEdmSTpZKo?=
 =?iso-8859-1?Q?a95jirEWrr4o7eIkFUHNO14HNZWkxAEQGODhCwBBiUwTMg+bJol2f3OwdB?=
 =?iso-8859-1?Q?RpB709/7Mz5fs2LAvH8r+qLmcg0wuwmo2kSWLefkGdO8yBL1tZc2spfQJR?=
 =?iso-8859-1?Q?P8MVvtORGYF5NQXIh9lhjV2b6ApNuVR1eQY+HIUTs/X/vZUc7HD3KUIJt3?=
 =?iso-8859-1?Q?zDYsyJ/wR5GvyZqS97MM60YQraHZRqiH5eZWhBWv6Z3XrN/BUzlZooO7de?=
 =?iso-8859-1?Q?kRsclSXMRLJGu34x5yWtu5QxhXsGlWOUmbvaqAiPG6/kleGDgoWMvPE2br?=
 =?iso-8859-1?Q?P7A5OJWwQ8nP/fbtAsP6xZoUKjk+8bhXaEVz7O8uZolyXG3IFIT5T0onee?=
 =?iso-8859-1?Q?Fm74rWjirSgUUjAXkawSn0w7ry4BTXva1mWH8Lb/yeS6vyMFO4973RDX9v?=
 =?iso-8859-1?Q?khqG15jxvqu+zM1Vq/AIx3xFWT+pkZx13IILS6HNkVYRSrEBH87d3sFSOw?=
 =?iso-8859-1?Q?NBk+JNP3poHmVCaY/PjCenaFHtfV0sEAAR2EMtRyk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?A4eJrqolR91NqQfgpXWmmy11/hS78sM9dKJz/F0gFD2Z4PuXgu1ESOGQei?=
 =?iso-8859-1?Q?Kwdpy5kDLlbUwHIvZeU03kaE5x2VaPnZ13XU5N7XaZwpvGMviVEgg1gLPF?=
 =?iso-8859-1?Q?7Q618NkOKsmT6RafbpSBdz5LMz96FCiIf2HNmjUgf6Qa+R9FY48gxAC5WC?=
 =?iso-8859-1?Q?fnzGEPBTnBeJZwsdjdWik+auv5EXTWFbKSBai04csTuOuh/9GEePDHxx50?=
 =?iso-8859-1?Q?6fqqy8gUVa0SR6CmNW+dKFnkN+Buw3PEeuRSBMi7z44It9BpAtVEBrbz+o?=
 =?iso-8859-1?Q?Szd+NDu8ALqzGup1TBhwNxz8tlbvap4E/Q9+j+tk6papnybKsKzOyNW5e/?=
 =?iso-8859-1?Q?qQ+7LQe3iaztc9z9vuUyu01e5lTZX0fwcG2VbzlZqeF8jUw3O3N0jRIN40?=
 =?iso-8859-1?Q?kV8yd9QDuT/IbjbBMzo+ZkGkj5REmqWqfpt14J/d8cJNw4LTLixTE+r/rp?=
 =?iso-8859-1?Q?OCQBvbtPrb9OcHSGikgS4ZX0TnAacTxwN8s+WqcWJOMJiW7JMj90yCQ2pu?=
 =?iso-8859-1?Q?VVIsTBj3WT+q2olBCfJoeL9nwe5s5xuSnt7lfYNZB0rDNrawuro7RB2aac?=
 =?iso-8859-1?Q?AjHsID77YzizhQtA6dm5Cxflzvx4AemAStxCDRqbX4FKPGM4LStCEJ8kCJ?=
 =?iso-8859-1?Q?33JWQsr4tEWr0qd3lLn74Z9JnyTQ31VhqA+60TpUzEonwPBBMuzs5lG2Hm?=
 =?iso-8859-1?Q?NvkSjA5XHPzKeoAVm1tIQXyaHEPYJVgDv34tQS4b5CLfG6iNtLHc5vBxEf?=
 =?iso-8859-1?Q?+k0YiHu+fYKIJBRz3S0toEfhQSBLCqyW6DNHBIZm9hW6ozoQK2/gE+yC86?=
 =?iso-8859-1?Q?c1yEe/R3usTJv/eWlx9WYmlj23kIbZooH913XPzooj+fGDuxwWfD3GIn2t?=
 =?iso-8859-1?Q?cnL/gJhr44NR3xpGdTzovqS5IRacQWR9KTrCfW7Gh3D6YmGsg8N+aecu5G?=
 =?iso-8859-1?Q?ewFYQWuACpwPTQDxQYn3mp6huS49t9Bpb0TZxByyr2ZTS2aLnurlN4SOUK?=
 =?iso-8859-1?Q?iIFdaI+Tpa4rf8WyEjzLGQhAKNapwkkWLOo29m23h+joX3k0V+Xlx6vs1w?=
 =?iso-8859-1?Q?gHhzx+IgNi2KR3l9Zf/ZsoOkIX7CDNXBA0MRhK2PKCJslz63el/uI989j9?=
 =?iso-8859-1?Q?WUm/cM6owajhet5UXshKpqmumFvHisGeFc+Mqcu0eLFPoqVJzIOapu5oX9?=
 =?iso-8859-1?Q?+880QOUzLP8SejD36qNpCR2v7tUTdIHGS74Xn2xin5HpFl4we7Oh5/T/Uk?=
 =?iso-8859-1?Q?WDNaHSmpmS4k6QdMuO1g4ggc5Fo6GDOAbFKALaFGljEe2L3u8v+F+yaHSl?=
 =?iso-8859-1?Q?WnmmyeXXYISlwqNfURqMmbrpzGdYBJklYZHAQvd9j34PSYxcEZkm26MOb/?=
 =?iso-8859-1?Q?ERL3vS7r/w5wQgfcalR8UqRW/9yP4XYumlyxS2s+/L/Ot8++jAItlai+y2?=
 =?iso-8859-1?Q?Pd6JCuWK/wLxp5YZSItbRUZuYERRLxe2jPDvzaXIhURkmuAJzfDlT1Z1Af?=
 =?iso-8859-1?Q?vpgiXYecHizIUwc/T8Wn4DjxKKfpRzD9K9B0jn+sbbvRglk8B3xafefUF+?=
 =?iso-8859-1?Q?aeJBh6WR/TnIiyldTiczsekNhyGquVEvCkm9LA3gs9QXfbgldT0o7JX8f0?=
 =?iso-8859-1?Q?x1+xkTqhdxEps/7wI1n30iiH1TrF2L1Gc8ss4HCmI1Khs2FcBntRHSlA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 957e2d34-25e1-4446-0309-08dc7551dc11
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 02:42:42.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQT2gFH32pqgq33+ZdFNMSMioO6wJROY4tkW4OAUF2H5VVjgZ2c6XlGdxph/JXoTMWjfWWmKAze0SehonH5fZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7656
X-OriginatorOrg: intel.com

hi, Frederic Weisbecker,

On Wed, May 15, 2024 at 04:14:14PM +0200, Frederic Weisbecker wrote:
> Le Wed, May 15, 2024 at 04:06:50PM +0800, kernel test robot a écrit :
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a 2.7% improvement of netperf.Throughput_Mbps on:
> > 
> > 
> > commit: 61f7fdf8fd00ce33d30ca3fae8d643c0850ce945 ("timers/migration: Fix ignored event due to missing CPU update")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> Nice, so this means the previously reported regression with netperf due to the
> new timer migration code is gone, right?
> 
> For reference: https://lore.kernel.org/all/202403011511.24defbbd-oliver.sang@intel.com/

I believe so.
previous report is for 7ee9887703, the scores are:

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/200%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/SCTP_STREAM/netperf

<---- (1)
  
57e95a5c4117dc6a 7ee988770326fca440472200c3e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      4.10            -1.2%       4.05        netperf.ThroughputBoth_Mbps
      1049            -1.2%       1037        netperf.ThroughputBoth_total_Mbps
      4.10            -1.2%       4.05        netperf.Throughput_Mbps
      1049            -1.2%       1037        netperf.Throughput_total_Mbps


for this report, we just have same test's score as:

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-13/performance/ipv4/x86_64-rhel-8.3/200%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/SCTP_STREAM/netperf

<---- (2)
  
cffaefd15a8f423c 61f7fdf8fd00ce33d30ca3fae8d 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      4.05            +1.1%       4.10        netperf.ThroughputBoth_Mbps
      1037            +1.1%       1049        netperf.ThroughputBoth_total_Mbps
      4.05            +1.1%       4.10        netperf.Throughput_Mbps
      1037            +1.1%       1049        netperf.Throughput_total_Mbps


from option lines (1)(2), only diff is compiler version which we updated to use
gcc-13 recently. but seems no impact in this case.

what we can see from 2 tables above are, 7ee9887703 just has same scores as
parent of 61f7fdf8fd (cffaefd15a), and 61f7fdf8fd just has same scores as parent
of 7ee9887703 (57e95a5c41). these mean the regression is just resolved.


> 
> Thanks.
> 

