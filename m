Return-Path: <linux-kernel+bounces-342989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CDB989599
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 15:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164FF1F22310
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 13:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669F6178CDE;
	Sun, 29 Sep 2024 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUkmILeD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D8F139CEC
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727615173; cv=fail; b=d3KoiOPCrb3CrsT7BSkLIb3kmBQajYIkmjHVw9aJSsQXWkc4txDxLAWyhqFssr/8q+8MKDQSAIxURAZGzvGgpSybt5XgxUegr2lcEPwh3nf7ZekkHonaHgcqjx6MTjURq7BP5TqMTNcjV42CNSfjMd2/vyM/N8ighOYIBXSY2XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727615173; c=relaxed/simple;
	bh=ggJLtyQuYzUScx3jgtB3CXYX7sw96CzvwcY3qJYnVdk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=SHjU/D0e8KRT2JpAZv4bv2LWji3OSN7nz8EAy1S/Mf/VCsGCvPltoe2fVsZR1+5fDsB5MpisTYdfCs8fDKUWjDI5NPhryqAehkvjIZTUYVPnXcnfRPmp954Md//Uo+X96f/JlWQkqYfRp+DnlhSKNiD2eutlzeHv/Xj//vgkr1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUkmILeD; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727615172; x=1759151172;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ggJLtyQuYzUScx3jgtB3CXYX7sw96CzvwcY3qJYnVdk=;
  b=UUkmILeDz8nprl7Y60dLzJq9WOqMTUxKVwQS7t+eSMcdExdge19DOEoV
   XFYH9173rcqWV+Hubk//E8mzIuEd2OVL3AobNfb3utoYyXWMVpOACRSsx
   33KHx8vgZbsMHOlG4AD8RtImR8NbORxM/zkafdHUnhbtb51+kymNsVPPv
   BQv3HAA6QrbCVmlm0I1FlIJi47iw86aqMKZY/dNUvk3qjqiAPp4nUhqh4
   9SyMLG40CyN3epFuYYpfXN6ly17X5BA+S+WngtpZbPDZMRZu3zoD6cwvK
   yH1i6JmSrPfa4yt5GpkfdDq36ZC404kiF1OeiCWeFsz5SD6vMVJ+WLs7L
   Q==;
X-CSE-ConnectionGUID: Xo3n0zPuRcW8poy7TZVMrA==
X-CSE-MsgGUID: I6gU3YaPQW+/NoG6OUcu5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="37381308"
X-IronPort-AV: E=Sophos;i="6.11,163,1725346800"; 
   d="scan'208";a="37381308"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 06:06:11 -0700
X-CSE-ConnectionGUID: r44sbVQ+Rjen3qEB/9RF5w==
X-CSE-MsgGUID: chbjTq0gTA+mIzVnZ+9Knw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,163,1725346800"; 
   d="scan'208";a="73004204"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2024 06:06:00 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 06:06:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 06:05:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 06:05:59 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 06:05:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmCHRPIiFlyVOI7JSgYs6M6ljQjGP69ZsYIvuJyOWQ0m41cQhcwxUmTfWLJYWQJ8wZj0IBj4aO/RwjVfHIyU+zhsdvTsewCsIzMbSx7hTvYYKnJ44oQdFQv2tRlM8N1pnxA0xDcEF1EDD6ZPcaBTLtMeeHG+qUluAa3yYvxQsf5DWoMIx3BTruiCOsugCK4+qkHmXCjxtywum6YRhaet7yR/cn/1DdpSiDEqmSFppwfV+p/kb+a6rL3olXZo9h88bVx/KttFcRE/b/C5gSpHJ7zen+JcDmCcD3TGgHP/tXV5A1jVWl07qaLbfcA0kH/01R8YSpLYgCCE2jI/5zgA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYQJ0lmyvMRurohB69KZr2IbICtW4b8GXP4VebCjmqI=;
 b=KiSpHGZfkkYgUzYGp6ktMed1iyGNq6gMfB9XtNGDUtAgO54ZLbUJBCPpwPedUqSrsY9No+Wc11aw25F4HXYQf1tyeMHxqDiV5x9SLNIcASJnujxllcns5/8Gyua3J45UUgT4tANcbUL+07YKkgOikpNjXsNyIuHSzGlniXgVCsdewJyzHK+DOrCDE7Q8Tn38RkgguSSaHmrIjQLWeVDjSGDVht9QiqVnbmc1AMWuzceoD5c/gi/fLg1gCvo2adw+4VcN2WrC/YRqVmddJWePrJqrDPVgvdm4Xyne79tHPzU5eY3yOKJ344Gkd3FfRTzrNnlPBQ41hWqflRolojRx3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8703.namprd11.prod.outlook.com (2603:10b6:610:1cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 13:05:57 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 13:05:56 +0000
Date: Sun, 29 Sep 2024 21:05:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Suren Baghdasaryan <surenb@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet
	<kent.overstreet@linux.dev>, Kees Cook <keescook@chromium.org>, "Vlastimil
 Babka" <vbabka@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>, "Andreas
 Hindborg" <a.hindborg@samsung.com>, Benno Lossin <benno.lossin@proton.me>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>, Dennis Zhou
	<dennis@kernel.org>, Gary Guo <gary@garyguo.net>, Miguel Ojeda
	<ojeda@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Wedson Almeida
 Filho" <wedsonaf@gmail.com>, <linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linus:master] [mm/slab]  4b87369646:
 WARNING:at_include/linux/alloc_tag.h:#slab_post_alloc_hook
Message-ID: <202409291608.d9846653-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c915eea-31a0-4996-8949-08dce08774c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1eYACf1IJChRWFtvZon3GyJeN/mwHLSDH8+Zao2BJFrSe/kpZAYl0PkAGuLp?=
 =?us-ascii?Q?/pIxReswOiQk0SNs9tkbv34VLT+k4jnlLNxovQbO4gPzFgWsnBRmtnmc6GFK?=
 =?us-ascii?Q?n+ukSfG+7WHDARXkBJtzUoSH6fJDoqqQ6LiDqpu3+ZHoLKtYqFSe4EK5Lmgx?=
 =?us-ascii?Q?man+1mETC7lV28d+2/lx0QvJ0B0ORrHScDb/5qTVvuZN/R9N2aohB5MWD+Ul?=
 =?us-ascii?Q?y1ni2n4CiZEDgGTUTBT8c4+35XlTPwDRNUNJTNT/da9jYcICZvQuRW/SyrdO?=
 =?us-ascii?Q?2YH2u13SbdRdCcDQL30uhcPM0BfWufnIgwUV9G5mlb4sW6czHcpyuTb/IHXm?=
 =?us-ascii?Q?JHDiai4bpst5f2LzsfkYKYBbOgNX7XyrAF/rCOxyxnXBwyAHdBe3KnxWxZCM?=
 =?us-ascii?Q?VtvDdc9CQ6btbUuufZ+Qqzvu+970jZbsXNz37ToHjw5dLzrunZZTkdcPaKvy?=
 =?us-ascii?Q?sZqzfLT7duSUMsWEzbVc56rWAAxmN4vGWDIh0Cl0PCwaVCtAVjf/nA1euE1W?=
 =?us-ascii?Q?AEEK1xRELpjUHvc1o9ztt2TvmADVSLVJnzhQ45GraXj7SVUwGuXsM6C9D5Bw?=
 =?us-ascii?Q?KQjVSbV7p8a7fDhqokxX8L386RSjWWZQ51XY6tkw9TbkL6y+oQvhJ7k/kJlc?=
 =?us-ascii?Q?M/w4eW8YB5kXgpM+Kuqwp6VOioiQL9gVnXPsejtKH0K5LfHmlhw8pIthN3D7?=
 =?us-ascii?Q?rSHx+DJCyowxYF34zvGJi50SaHdqdtnZzPtOtCcGgQS2K04PPW0wsa2qtpg/?=
 =?us-ascii?Q?Et7HdltPzkY9tXHodlf79uJhJqVBd4O5t0Ni1cy0ZpRPUFZoHXUhC4bEV2qV?=
 =?us-ascii?Q?T3ss/mZswTOvi1WnVHAdk/Yh1wKFDJw+bd4iOpisgPANAApa0hYNMQSmqA4Z?=
 =?us-ascii?Q?GJI6+cnq/Qps+FDPYA0v3Q9TKHs+9C/OgvsmP4avKvM9245g8dUPkhL7Dgie?=
 =?us-ascii?Q?AwvB12WhKyxgqKrz4ednZC9jvCBoUZgwUy7NwbXcaZjmBc24GXG+m5z/r333?=
 =?us-ascii?Q?wIcMzQb7AgnK130XrpqXSXCHmbp0uPaZbkCuV9lSWLNgCTzfQnyXV3zX473q?=
 =?us-ascii?Q?Ngq9tKixXWmKw7y0YY+lrb5GSb+v/+RpzJLp/SLo8r09OLQ37f0DrEjZGCm9?=
 =?us-ascii?Q?wvaWSg0rYImH/llhuibu9imR4SRkZcUBzWVmtQex4iQS1lk5slzJpSjJsIqX?=
 =?us-ascii?Q?uQxTAIfyIVt/SDoQT9q0IAyrM+j5Ek3GHrvI6YVKgvMEbz8DkGV+u31B1fIL?=
 =?us-ascii?Q?jwlH3Gi+85ELxOvsIqMVhnCR68GO2p07gQS4eKnR72DUmiTxvJ5BW2ihOaw9?=
 =?us-ascii?Q?fIA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DDyCHTfmqSwgbKXLVjVM/ob3Jc+WLP9aA15ztWLtR0/LT50iP9dSRU+ypaP7?=
 =?us-ascii?Q?v2RlwqhVAaxvY7C0mAxrk4F9E4z7YUF49pyQPalyTie2o+xVPdAFsZfpttVD?=
 =?us-ascii?Q?2gpeCHfrFfeXjzR80Mhlwh/P+D2SeLfyd8OKvbIufTK9yuDZ223zOBovNCDz?=
 =?us-ascii?Q?aEnk1wWBmJEZn4pprUWp58Pv82fNUMoQCA2PFNv+JJ9dhio/W5RC4mH+0UkM?=
 =?us-ascii?Q?cx2wy44TS/7dDfQ3pr4aOC135XYiVlpRedcujk53kZkct66Dx4c1yjq8Rm8Z?=
 =?us-ascii?Q?gk507hjyiBSy1WaHX71nPmhpmoUuVYcuwPk/lGw9aSXfIup8Y9Ct3Y1052E5?=
 =?us-ascii?Q?276JF9RSyJDEGB6zLt7uvCueuImqX/vlKXvnPkJ1lV5jHwHBC3G+hJfhGh8z?=
 =?us-ascii?Q?6Mq+CyWNWRPSmQCckBdU5LlTxTmjtAdNOqmWEFI2csVXZGl+i0+/HoEEkHPA?=
 =?us-ascii?Q?xcGhAbNxxa1I4eCIX928jZqY5yuPRHbRxkE7JO+03faLabOGfSVDKxtwaYhZ?=
 =?us-ascii?Q?+qNgg/5J8VPCAMUdlInZCg4wnINTGEzakdbOjt7DBOXewvrdklpakzvFHoag?=
 =?us-ascii?Q?xJpwI2+x4w/B4rR/96bvBDK4G5WJtBsFquWQiaOXFEr4kqdkI7cRV7uGAZZU?=
 =?us-ascii?Q?VZw9ivzPwrjHJdcgg0T3uoAD7hE06Ie871H6nLz+u6pjWuE0am6ukFktQ0do?=
 =?us-ascii?Q?lXQQWGqfkvXagdeeRnM7Ts0DJxMTF2uc8Z50E0uih6aDgKc5Wwhp6BAaMAYA?=
 =?us-ascii?Q?i5YCZ65idn4QHiDhLYLoL7VFLdAFCwGPH/63NNk+Vljx1BxCHpIBIICvaHcz?=
 =?us-ascii?Q?SGssxdWooZPVU3XE2fOZL+34RGVOUaQG16bdMMWBmLvB68yOUwWxbs421cHB?=
 =?us-ascii?Q?UMwlFWgG336xw4wAVsfi/+U9LLn52xmlgyvOVn21VwgnRtlrf7ng+cdJH2i8?=
 =?us-ascii?Q?QNBroMAkNdOtJQYpapA7yATmgBpyosqR3a4pS/Lz9X6UoPB4V0rdvC/q+VHy?=
 =?us-ascii?Q?edgBx8gjPdqHoPj7ZqPGUzmQr9iln9W//Vhwgy44d+3I14keRiy6SJ9bkEfg?=
 =?us-ascii?Q?QnytrG4VfPFFXXS1SgC0RctgNMtFEBHL5K0UR2beKkx085OpesTMqsaLP0O1?=
 =?us-ascii?Q?sve+5ZWu9klySQZ9ftbqltKw/h1oDXhzENk9ZjyMl8T75oVe7xmlLdKF8DAj?=
 =?us-ascii?Q?uytuNwPO91ngJBbBt1RL37FGi1oHQDbcACzErLa2lc2hggVfV3ar42KN4krU?=
 =?us-ascii?Q?qEJYJnfsqsjqpJF5d5kFeDsBvvqgisIJ/nuAotUmkwD6EO0cKtDxK6IUs7pP?=
 =?us-ascii?Q?sYVaFUNYJLdA7rpjcNB/jb9zzW+86XX4PXXMoVSlxaREImN2TlcW7cxV9zrg?=
 =?us-ascii?Q?aHr4UYvGboFEOnnOHpRxdUxyHjBsq+QXATyo2Vkr1aQil95nF2yyfO7w6ldO?=
 =?us-ascii?Q?oyC5UkPCVLihb3rZc/KU0/Bz3+lDOHqI8LGWYO592hlyr4zKLj8LRteD8bkI?=
 =?us-ascii?Q?BO3jK8FmB002JvR32TDuzfNg1X5m7lh2GnJK539E3oAlJbhnv4RZYiK7qADQ?=
 =?us-ascii?Q?u6SQAtpH4WtADxJN18KTmIBqORZ4U5EHRfsH8H0t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c915eea-31a0-4996-8949-08dce08774c6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 13:05:56.7321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fd6j86kvAs4PJ30jnQIe1I74Ld0BfoU+7FDEFA5MS36LHeRLmSoEbPOuf8Ic6QqRwZe2s4umhPaxOsK7x7j4ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8703
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_include/linux/alloc_tag.h:#slab_post_alloc_hook" on:

commit: 4b8736964640fe160724e7135dc62883bddcdace ("mm/slab: add allocation accounting into slab allocation and free paths")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      075dbe9f6e3c21596c5245826a4ee1f1c1676eb8]
[test failed on linux-next/master 40e0c9d414f57d450e3ad03c12765e797fc3fede]
[test failed on fix               ab7ca09520e9c41c219a4427fe0dae24024bfe7f]

in testcase: trinity
version: 
with following parameters:

	runtime: 300s
	group: group-01
	nr_groups: 5



compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------------+------------+------------+
|                                                                    | c789b5fe38 | 4b87369646 |
+--------------------------------------------------------------------+------------+------------+
| WARNING:at_include/linux/alloc_tag.h:#slab_post_alloc_hook         | 0          | 24         |
| EIP:slab_post_alloc_hook                                           | 0          | 24         |
| WARNING:at_include/linux/alloc_tag.h:#alloc_tagging_slab_free_hook | 0          | 24         |
| EIP:alloc_tagging_slab_free_hook                                   | 0          | 24         |
+--------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409291608.d9846653-lkp@intel.com


[    4.475119][    T0] ------------[ cut here ]------------
[    4.475771][    T0] current->alloc_tag not set
[ 4.475804][ T0] WARNING: CPU: 0 PID: 0 at include/linux/alloc_tag.h:95 slab_post_alloc_hook (include/linux/alloc_tag.h:95 include/linux/alloc_tag.h:131 mm/slub.c:3957) 
[    4.477578][    T0] Modules linked in:
[    4.478054][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.9.0-rc4-00083-g4b8736964640 #1
[ 4.479166][ T0] EIP: slab_post_alloc_hook (include/linux/alloc_tag.h:95 include/linux/alloc_tag.h:131 mm/slub.c:3957) 
[ 4.479840][ T0] Code: c9 e8 5d 1e f3 ff c7 04 24 01 00 00 00 b8 a0 ad c9 c3 ba 01 00 00 00 31 c9 e8 45 1e f3 ff c7 04 24 3a 87 53 c3 e8 e9 3b dd ff <0f> 0b c7 04 24 01 00 00 00 b8 b8 ad c9 c3 ba 01 00 00 00 eb 0e c7
All code
========
   0:	c9                   	leave
   1:	e8 5d 1e f3 ff       	call   0xfffffffffff31e63
   6:	c7 04 24 01 00 00 00 	movl   $0x1,(%rsp)
   d:	b8 a0 ad c9 c3       	mov    $0xc3c9ada0,%eax
  12:	ba 01 00 00 00       	mov    $0x1,%edx
  17:	31 c9                	xor    %ecx,%ecx
  19:	e8 45 1e f3 ff       	call   0xfffffffffff31e63
  1e:	c7 04 24 3a 87 53 c3 	movl   $0xc353873a,(%rsp)
  25:	e8 e9 3b dd ff       	call   0xffffffffffdd3c13
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	c7 04 24 01 00 00 00 	movl   $0x1,(%rsp)
  33:	b8 b8 ad c9 c3       	mov    $0xc3c9adb8,%eax
  38:	ba 01 00 00 00       	mov    $0x1,%edx
  3d:	eb 0e                	jmp    0x4d
  3f:	c7                   	.byte 0xc7

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	c7 04 24 01 00 00 00 	movl   $0x1,(%rsp)
   9:	b8 b8 ad c9 c3       	mov    $0xc3c9adb8,%eax
   e:	ba 01 00 00 00       	mov    $0x1,%edx
  13:	eb 0e                	jmp    0x23
  15:	c7                   	.byte 0xc7
[    4.482296][    T0] EAX: c3c5d12c EBX: c0100101 ECX: 00000000 EDX: 00000000
[    4.483216][    T0] ESI: 00000000 EDI: 00000001 EBP: c36b5efc ESP: c36b5ec0
[    4.484080][    T0] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00210086
[    4.485009][    T0] CR0: 80050033 CR2: ffcb2000 CR3: 04016000 CR4: 00000090
[    4.485867][    T0] Call Trace:
[ 4.486271][ T0] ? show_regs (arch/x86/kernel/dumpstack.c:478) 
[ 4.486815][ T0] ? slab_post_alloc_hook (include/linux/alloc_tag.h:95 include/linux/alloc_tag.h:131 mm/slub.c:3957) 
[ 4.487401][ T0] ? __warn (kernel/panic.c:240 kernel/panic.c:694) 
[ 4.487847][ T0] ? slab_post_alloc_hook (include/linux/alloc_tag.h:95 include/linux/alloc_tag.h:131 mm/slub.c:3957) 
[ 4.488481][ T0] ? report_bug (lib/bug.c:199) 
[ 4.489036][ T0] ? slab_post_alloc_hook (include/linux/alloc_tag.h:95 include/linux/alloc_tag.h:131 mm/slub.c:3957) 
[ 4.489677][ T0] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 4.490224][ T0] ? handle_bug (arch/x86/kernel/traps.c:?) 
[ 4.490782][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
[ 4.491366][ T0] ? handle_exception (arch/x86/entry/entry_32.S:1047) 
[ 4.491992][ T0] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 4.492524][ T0] ? slab_post_alloc_hook (include/linux/alloc_tag.h:95 include/linux/alloc_tag.h:131 mm/slub.c:3957) 
[ 4.493172][ T0] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 4.493747][ T0] ? slab_post_alloc_hook (include/linux/alloc_tag.h:95 include/linux/alloc_tag.h:131 mm/slub.c:3957) 
[ 4.494448][ T0] slab_alloc_node (mm/slub.c:4000) 
[ 4.495089][ T0] kmem_cache_alloc (mm/slub.c:4007) 
[ 4.495671][ T0] ? debug_objects_replace_static_objects (lib/debugobjects.c:?) 
[ 4.496471][ T0] debug_objects_replace_static_objects (lib/debugobjects.c:?) 
[ 4.497281][ T0] debug_objects_mem_init (lib/debugobjects.c:1386) 
[ 4.497935][ T0] mm_core_init (mm/mm_init.c:2787) 
[ 4.498494][ T0] start_kernel (init/main.c:939) 
[ 4.499087][ T0] i386_start_kernel (arch/x86/kernel/head32.c:79) 
[ 4.499734][ T0] startup_32_smp (arch/x86/kernel/head_32.S:295) 
[    4.500372][    T0] irq event stamp: 0
[ 4.500862][ T0] hardirqs last enabled at (0): 0x0 
[ 4.501669][ T0] hardirqs last disabled at (0): 0x0 
[ 4.502475][ T0] softirqs last enabled at (0): 0x0 
[ 4.507414][ T0] softirqs last disabled at (0): 0x0 
[    4.508243][    T0] ---[ end trace 0000000000000000 ]---
[    4.563547][    T0] allocated 56623104 bytes of page_ext
[    4.576043][    T0] Node 0, zone   Normal: page owner found early allocated 13853 pages
[    4.577459][    T0] Node 0, zone  HighMem: page owner found early allocated 0 pages
[    4.578644][    T0] ftrace: allocating 69614 entries in 136 pages
[    4.602968][    T0] ftrace: allocated 136 pages with 2 groups



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240929/202409291608.d9846653-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


