Return-Path: <linux-kernel+bounces-536935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D09A485F5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798F07A6239
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1076E1BD000;
	Thu, 27 Feb 2025 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BoXfII57"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4E1D4335
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675605; cv=fail; b=Mu3JcvWkt3GxIykDytKNSZ7tMTonx3p+BqioB43KDsKCd9GXWfLXAyUg1+kOjMR80+H7+lJQ6R71lbp8D4RdShyc+3joCwjY7Q4850OlhSYVIMOQdnxh0Vl3eSj0AyaExzZ+FQePwZWdj8ouSP2N7BWD50wG48tBzZqqhpIoDyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675605; c=relaxed/simple;
	bh=THgF6aSerq9RbQcoZkdnQPeTh26YiwRJTAFhoNNHkBw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VuN/yhj8dGDbNhqTP31KEI2b0JV8W2ZqF5bEl/mXZSZ2qUqLdQATBWSHljFSN7f61GecIUCnB7axe20P622QBIMiaZPTv1ZAUm/jrAdqWW9HKMsWt0uUrRJohzIvFLeFsxg9spUO2h9L4h4IWm9wKJ+IXfy25y4Jc/VnGkdegaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BoXfII57; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740675603; x=1772211603;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=THgF6aSerq9RbQcoZkdnQPeTh26YiwRJTAFhoNNHkBw=;
  b=BoXfII57EzddgT+ARf/uIt6kkjH8RjAvsMiV7HMo22yNDYGbv6wJz/tg
   aBYJ9/u8CtA6sRmBye+gEYxJBU+F4/9VzrWqzCouR9l05LyWQDoCpNVR1
   47NhpbsSAfL3/ylTXEoJISO198AIRfSfbvYSVI5KCRx/ZIO+XDRXzv0F6
   Ysp5kaSGKgJkXMYGH2lN+wcgAdaK/XyR70/GXSy3R8NyzsAVtRyHuQ3D+
   Znhua7fO7MaK1wA0ca4Wu0Wv8hhgnsBQXoPajJyglgb3s6RTeasM3BbzH
   EkV8BgfRe+9LRjJFYX76KjUkAOUVQD84QGePCiNapyxi0cv0uUGgpV4M+
   w==;
X-CSE-ConnectionGUID: B14X6gMrRKaGmBsMZ3gtYA==
X-CSE-MsgGUID: HaYt4LifQlSqWmbtqD9szQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52214230"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="52214230"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 09:00:02 -0800
X-CSE-ConnectionGUID: LA/5fqS3TQa/GlrC1I2KeA==
X-CSE-MsgGUID: FKOOmWCXSESpxRp4DET5Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154272817"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 09:00:03 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 09:00:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 09:00:01 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 08:59:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWNTTnwJUkrvEqP8GfLT5nTCUvlku12khzvxlBSpCyDJxaaTrGtJOiuW0d9ZqY/egbDSCkewRa/vDoOJ4AD0+32xvKCWrIAxoVpWC7ZaDtxsBB+lNxhlIY+tjCleRjPoxwhMZp+RV8dijoKTdGVjZWSM3pM4nbNK6LFMnZ1axHI1D5HNuQ7s7fqQS7gNCctPrkzSx5ZWWjSOfaVIefvczZ8d9W7qhDxwjgU6YsNWIK8gS4DgOA6WxEwxTjPgZKHERtr6sufz4/f5gwzm/5HFg+K9lRta9pZUORKaZS+dq5AiQtY9t4JMGDotRZqIU2HeJb+ZdNUoS7pLAN/WQN8YZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpZS93JrtxwCt93JdZ56RmH1fBxBN00PfHPaC8yings=;
 b=F1BUFrClATa9376JyuHLZrngnni267jXAKWC82/qqqV+FG2yssHtco3zpDygnLVCbR63Y5ph3836afPhrVg9ZxOAy7YW+lX+KdkoBoWfUsF2SyWzMsuxVInwANy0MewhQ32NtNcSq3f85wfmzMT5sMxFz9jFFd8hqfnYJhrSPVsu3lntZKSrdflLkrvTDKoXW4gN/7ryd0Tickan1NFTvwOH6hmwMEH+CWr+pras3GTB9VSAJhSKWAMkk8mEmEYfQ+o73o+68Biokz2hntE6W9qUp5+3Xr94ubzdVFYd16XWmHPn2Rvm2yBL49c2zPdHij978DpS8jooms949frKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DS7PR11MB8853.namprd11.prod.outlook.com (2603:10b6:8:255::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 16:59:16 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%3]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 16:59:16 +0000
Date: Thu, 27 Feb 2025 10:59:12 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@kernel.org>, <ravi.bangoria@amd.com>,
	<linux-kernel@vger.kernel.org>, <willy@infradead.org>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH v2 06/24] perf: Fix pmus_lock vs pmus_srcu ordering
Message-ID: <qvgmqkytn44ysjbox6b2db75ri6yc3lmncpb7etiajnueeuab2@6mrdmoqqnebn>
References: <20250205102120.531585416@infradead.org>
 <20250205102448.898435571@infradead.org>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20250205102448.898435571@infradead.org>
X-ClientProxiedBy: MW4PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:303:b5::31) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DS7PR11MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fff09ee-7ebe-4c97-07c5-08dd57501196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kbZMXi5Icv15r4QNp7zGbr2yljCo0KzjL1f/8VS2t1Bdxp7oJhi9h1dmw8j8?=
 =?us-ascii?Q?cxwIPRYPqIjd/EYeZZj+2FmpsdwkHgMct5qzlpVwccSftbn2OfsysL/p2Ael?=
 =?us-ascii?Q?oiJuyYDXA7AMX8uoVl/MdhwD3n3kYAD6v8vRegIA+SY1EMZKuguQitRxUqNb?=
 =?us-ascii?Q?nJCoH6CoOpxdggvMq4QS3b86R9d5OJNmfl974AxGLmsXtzIBtAISFX7GQavV?=
 =?us-ascii?Q?KqddaweMGijLnre/gO/nt30lO9lP1BxntLW5syYWlguu4JRpHoLWCMlJS1rA?=
 =?us-ascii?Q?82CxoY9tqL+b1hyt+grUSt7sx5pLPULLkZ9DzquITFx4KyUJ+2ZoGhgKbBcr?=
 =?us-ascii?Q?WrjuzaR25NrxIbxKvOwie9orcPcWH/ytOgIHc6t7eMjthmA8kSQPNHm8rrVw?=
 =?us-ascii?Q?peUgyC30U7+Q9WWJN6up+76C3ZdA7bxQ/ChVaAND/AdCVZnjEiKIFlbLK74Z?=
 =?us-ascii?Q?LUEqB+m+ZItNqh+SJxG8UwmlFJhZMPEdej+n7bAUaoqA/JXhNS/twJ1C/T8W?=
 =?us-ascii?Q?KvABAg46DIUyuTvYh+d9L2aCVxxK4wD+fkxJhvtRoQs8qQawSc02YmR3kkAA?=
 =?us-ascii?Q?tpyRJK3eh3BlFGPGonx9HqS4nOS2PxhXN/KSTAiS8SnLmYtKM78PFoQiF5dn?=
 =?us-ascii?Q?rSi7Ae1T4BXVMKiEfNHsCFMIo+hUROHqZdZ98vJM1TbEb5PtR/EJJtxw3l9t?=
 =?us-ascii?Q?i2O/bQk43B+FvpS+iGB1NVBIoOdbFaSkYEQgUzZum/r/RTTPVNo7ZwEovIti?=
 =?us-ascii?Q?PNa3qcaf5HaGDbQBW3UYRug1YiXrQI3Som/dWITHPEkBWZAYxSbh8kH+58O1?=
 =?us-ascii?Q?hBI8XoV8SRe1Xl0ah1FCh77duEBrKZ5BM7pdG2iFgVhZrDuIR4b+XFfaFWqh?=
 =?us-ascii?Q?LuIuc9ZH7Ck7pvZXMk5aZChNnAHGMiquU6rVVtytkxdZN+jaLoaCUfKgQdtb?=
 =?us-ascii?Q?qERW3kuyL3pXvamYPaS4A1xWel0PXEVQy2Pa8AX7R82zyKgOZj7BAnUToG9E?=
 =?us-ascii?Q?VX3uLNCYlYyCRTTUOoQWPMLhqJ84Bla2HGu7FZYre2EdYlRNQeLidgcI8zjs?=
 =?us-ascii?Q?sOtvyi7GxWTwTt3Pi4cmLfOsFV7HshSOT3m31hBw4Cu6ijZAZYs7aWD62dMd?=
 =?us-ascii?Q?9FbfUrLqZb3crSCh9XYreqi1XwRGj7PdJhA/y3ewOPDi8LbrWez5irv6WPrg?=
 =?us-ascii?Q?lWshhrc416ZvdeL33JXRIIke+7xD9/rnCWRKgT43EZ3kiX6ywa6pxbz+nb5N?=
 =?us-ascii?Q?cvfn1Xdu0NQELgq4NI4WUG+UcLFNx+6szc94OEK1ZQdI/mcNk3UrGoIlNEcb?=
 =?us-ascii?Q?j7nF2x4DMifh9ZXFLx/Xp/CUIGcozvupkb5V41TinpVEZQoU8haW/b7L7i0v?=
 =?us-ascii?Q?RFdEeTFrXJgpmDnF170You1+eSec?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ESZGwQZm5Okui7LYs8rJEpt057q0uaiNtU3CTBz56D+0Y0n9R0Ypn4wcaO0M?=
 =?us-ascii?Q?K5KiRVHnnxutNoHVllLq+pQv8FP76kvOgG+I97skhs/0SqJGBR+NQ5m09O0o?=
 =?us-ascii?Q?9rSBfOkWy88l73xJUojaTfo61+mLk+kZ0vfRmHWDapv8b8/eLsekmgrHcW4Y?=
 =?us-ascii?Q?vcbj6a47ilZcN2Wy9ko+LggxOUHPmWTTbZ0XSeGbQg/jxN2xsNGxVuToawg5?=
 =?us-ascii?Q?t4I93k15x+OFE3Ld1VVz4Yxkjko7v44LduQVeWB+XXswWBPGlHhwo3hMggGy?=
 =?us-ascii?Q?VE/qzT7zJKhA1Fn0QeHUkwXRluIe/WRH8GQewB3/v1qLZ4KoBxjXDBwzYzIy?=
 =?us-ascii?Q?nuHoWFTLxkRNSapScbT2PgsWxt1AMz2mq3BezDI2Lf9fKbZmjssrFqCiEkfL?=
 =?us-ascii?Q?z+x0aCX6An4wwYhm+NQfKv8lIATCNr4Av1vJ04zdrafHgZHhX46SIdUZloCv?=
 =?us-ascii?Q?W2ci489oQFWW04Gx9NujHlrFAkfWI16P5lJJhJbP1f2PcZU+bAN6Yp6TEZQP?=
 =?us-ascii?Q?DhKm+rp73YZuR/gboCXojVpFR6JyVC7A9OcXS8PX56H/oNwpKg1wP8C5WhE8?=
 =?us-ascii?Q?fO35NUsSZQoKU9Z4SgOW1OxAeAf9ldxEqEKd52jZgJLC9KqKl9dwOM4rUU/f?=
 =?us-ascii?Q?HCILKrR5ZhTLxkn2MnLcZszqa2EeabzZo5CK5a461Lkh6VQNbPRTV9kuslH/?=
 =?us-ascii?Q?sV/V9xxIjY9yG8Toffbuh1+3R4l3RMmVhRXHsEmemXeKXnQtRUDed5WNsNwZ?=
 =?us-ascii?Q?Uu+81mA/DNNKlSeaLAc2806UMVODrfyOCeH3Cf9VGUipogLK7TtfFYYQDUQ/?=
 =?us-ascii?Q?Jri3lNMthuSvOr02NCU37xh3DLcnQKFmj8oXckqFIkjd39dBwDltz1ucz3JU?=
 =?us-ascii?Q?TSwRO9gvoARaDFdM3UTNk5kP02InbV9JcZYN9hotkIi7b+G6B5mcZl3BZ6Hx?=
 =?us-ascii?Q?R6HhExlmDi+eiqO9J53wHuE9phZethQlGDHcDtpSid+IN6Wpr5fBGZw00nhd?=
 =?us-ascii?Q?RlyUZL23VNkX8OnsdpG2sWT/xrpWIxVFUZNCxvbfm4T0xnWZ1qOUEp1euAYh?=
 =?us-ascii?Q?53rH+J+ZZ8mO4EkgFRga02OECa0d3H7XD2yFqwKxzKvtO8v6tKRIb99ARN26?=
 =?us-ascii?Q?gsBc6z7Yp7b0u/K4e2sBqEuhXFsaMcbJsDJCQfcm0j8Dyaca/vO3j3pAWV9q?=
 =?us-ascii?Q?UBYSo2VL++TtMAFLermH7mTzLGv9Z06KPh3D5Cy7KAWzj/bY6iZHX1wU26lZ?=
 =?us-ascii?Q?3JTN0t4b3azqtmw/i7lX00SC9BaEDcNDDkWj4AUdfQoMzt6gneZNYckG5tqf?=
 =?us-ascii?Q?1f2oWUI3K+Eot9fJqZ76AUwkgapIHwp1cKSWYs1ysNOj8tJ3FhIdMSrH7h0/?=
 =?us-ascii?Q?O3S4zk4/sZnmjWA1hoI8x/viY/IfzWKD7cUDNJ7noIi6u/ESzYJ1jitaTKLk?=
 =?us-ascii?Q?MGxfM0wrEVkrOebhhbOCHObI84WjFybHUj5DGIB1wmRrHvapnr9ZH3AnwVYZ?=
 =?us-ascii?Q?oHK1uSxG9afr8i1nn3ZxwrBwmWDaRtmmpbLzOFfzhAuFpj2aRu15+D/y/OXF?=
 =?us-ascii?Q?if/KA9m+TppR5LFa6LhUesg4WOrogghFo226u8KVyM66saRAfctKWu2WEzDm?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fff09ee-7ebe-4c97-07c5-08dd57501196
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:59:16.2859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSohnOQF6hFKVXK9BdK7MgYzVMgfhd3cAmQic4Fo/VzuxSz6tKCL39DLqeM1vOmqMoiNAA9b+FMwdGQ25+uMF8CYH1DsguCdmwphmu/c940=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8853
X-OriginatorOrg: intel.com

On Wed, Feb 05, 2025 at 11:21:26AM +0100, Peter Zijlstra wrote:
>Commit a63fbed776c7 ("perf/tracing/cpuhotplug: Fix locking order")
>placed pmus_lock inside pmus_srcu, this makes perf_pmu_unregister()
>trip lockdep.
>
>Move the locking about such that only pmu_idr and pmus (list) are

s/about/around/ ?

>modified while holding pmus_lock. This avoids doing synchronize_srcu()
>while holding pmus_lock and all is well again.
>
>Fixes: a63fbed776c7 ("perf/tracing/cpuhotplug: Fix locking order")
>Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Without this patch, I occasionally see the locking issue below, but it
doesn't always happen. I'm running with this patch and haven't seen the
issue since.

[  268.195731] ======================================================
[  268.201945] WARNING: possible circular locking dependency detected
[  268.208165] 6.14.0-rc4-xe+ #59 Tainted: G     U
[  268.213777] ------------------------------------------------------
[  268.219988] kmod-unbind/2509 is trying to acquire lock:
[  268.225238] ffffffff8b40b310 (&pmus_srcu){.+.+}-{0:0}, at: __synchronize_srcu+0x21/0x270
[  268.233374]
                but task is already holding lock:
[  268.239241] ffffffff86381de8 (pmus_lock){+.+.}-{3:3}, at: perf_pmu_unregister+0x25/0x2f0
[  268.247372]
                which lock already depends on the new lock.

[  268.255577]
                the existing dependency chain (in reverse order) is:
[  268.263101]
                -> #1 (pmus_lock){+.+.}-{3:3}:
[  268.268717]        __mutex_lock+0x1a4/0x1300
[  268.273019]        mutex_lock_nested+0x1b/0x30
[  268.277489]        perf_swevent_init+0x15d/0x610
[  268.282142]        perf_try_init_event+0x111/0xba0
[  268.286971]        perf_event_alloc+0x1024/0x3eb0
[  268.291703]        __do_sys_perf_event_open+0x3b0/0x2460
[  268.297046]        __x64_sys_perf_event_open+0xbe/0x160
[  268.302305]        x64_sys_call+0x1eb0/0x2650
[  268.306689]        do_syscall_64+0x91/0x180
[  268.310918]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  268.316524]
                -> #0 (&pmus_srcu){.+.+}-{0:0}:
[  268.322215]        __lock_acquire+0x3339/0x6980
[  268.326777]        lock_sync+0xec/0x180
[  268.330645]        __synchronize_srcu+0xaf/0x270
[  268.335291]        synchronize_srcu+0x64/0x2b0
[  268.339776]        perf_pmu_unregister+0xed/0x2f0
[  268.344523]        xe_pmu_unregister+0x94/0xf0 [xe]
[  268.349604]        devm_action_release+0x49/0x80
[  268.354257]        devres_release_all+0x180/0x240
[  268.358996]        device_unbind_cleanup+0x1b/0x1b0
[  268.363910]        device_release_driver_internal+0x44a/0x5b0
[  268.369693]        device_driver_detach+0x36/0x50
[  268.374435]        unbind_store+0xe0/0x100
[  268.378571]        drv_attr_store+0x6a/0xc0
[  268.382782]        sysfs_kf_write+0x106/0x160
[  268.387176]        kernfs_fop_write_iter+0x359/0x550
[  268.392180]        vfs_write+0x64c/0x1030
[  268.396234]        ksys_write+0x11a/0x240
[  268.400284]        __x64_sys_write+0x72/0xc0
[  268.404587]        x64_sys_call+0x2c4/0x2650
[  268.408885]        do_syscall_64+0x91/0x180
[  268.413102]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  268.418708]
                other info that might help us debug this:

[  268.426746]  Possible unsafe locking scenario:

[  268.432715]        CPU0                    CPU1
[  268.437277]        ----                    ----
[  268.441842]   lock(pmus_lock);
[  268.444932]                                lock(&pmus_srcu);
[  268.450633]                                lock(pmus_lock);
[  268.456243]   sync(&pmus_srcu);
[  268.459419]
                 *** DEADLOCK ***

[  268.465375] 4 locks held by kmod-unbind/2509:
[  268.469779]  #0: ffff888135689420 (sb_writers#6){.+.+}-{0:0}, at: ksys_write+0x11a/0x240
[  268.477911]  #1: ffff8881107aee88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x221/0x550
[  268.486829]  #2: ffff888111cc41b0 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa2/0x5b0
[  268.496547]  #3: ffffffff86381de8 (pmus_lock){+.+.}-{3:3}, at: perf_pmu_unregister+0x25/0x2f0


Tested-by: Lucas De Marchi <lucas.demarchi@intel.com>

Lucas De Marchi

>---
> kernel/events/core.c |    4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>--- a/kernel/events/core.c
>+++ b/kernel/events/core.c
>@@ -11836,6 +11836,8 @@ void perf_pmu_unregister(struct pmu *pmu
> {
> 	mutex_lock(&pmus_lock);
> 	list_del_rcu(&pmu->entry);
>+	idr_remove(&pmu_idr, pmu->type);
>+	mutex_unlock(&pmus_lock);
>
> 	/*
> 	 * We dereference the pmu list under both SRCU and regular RCU, so
>@@ -11845,7 +11847,6 @@ void perf_pmu_unregister(struct pmu *pmu
> 	synchronize_rcu();
>
> 	free_percpu(pmu->pmu_disable_count);
>-	idr_remove(&pmu_idr, pmu->type);
> 	if (pmu_bus_running && pmu->dev && pmu->dev != PMU_NULL_DEV) {
> 		if (pmu->nr_addr_filters)
> 			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
>@@ -11853,7 +11854,6 @@ void perf_pmu_unregister(struct pmu *pmu
> 		put_device(pmu->dev);
> 	}
> 	free_pmu_context(pmu);
>-	mutex_unlock(&pmus_lock);
> }
> EXPORT_SYMBOL_GPL(perf_pmu_unregister);
>
>
>

