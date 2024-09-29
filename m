Return-Path: <linux-kernel+bounces-343018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051199895F7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 16:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816552833B6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 14:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA90717BEC6;
	Sun, 29 Sep 2024 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QLt9+A8y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164342AE69
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727620198; cv=fail; b=jGzCBBccylkJr4vds+6WpKz8lfoCUrbISo5OwAMXH9zPrm6gvNwclNKKLI7i/KwWbhg+fT0PzbP1LaDc+0SZs39ptTUErcVmO/XEdSbPyfQy+KfPZULI9RfZCM417+oAveLnbYJyReYQIAJQbd7wN1Y4FuimG2kp+Rd3lIs9dAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727620198; c=relaxed/simple;
	bh=VlRqkmYaPWkUC4pRb2KeQb3ws6GLlFPzRqOP8qjnM+s=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=TpuMfse3BgBZeriGMFhYaPFqmk18rrvvJiibB3XgbgCEknBxBzbSBYmx2o9yiLiEH3gZKgOkksWUI3wUFJJ3/mqqq1P6F13hhfAetbK2YWvzmBr9E6URAkUjBmari6Ee3LhkbZ8TiFP2pRtNifGBAqUxeMK+zBkamfYZk1w1C7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLt9+A8y; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727620197; x=1759156197;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VlRqkmYaPWkUC4pRb2KeQb3ws6GLlFPzRqOP8qjnM+s=;
  b=QLt9+A8ysoHY2NZFfy++ZUZ/yo6Td8MgqqbIYFGJ+LNfOOEEQmy/3epZ
   IOeyRcO0lFK2OqNqpkH3g5D0Ym06jwpuPAZLhpvmPr3EKzEHOH40ps8k8
   SoANpe0bM6i6VIrxiJHoMoZ55mxiEfWHy3Emfuo90vdxMO/7t4KEFttSD
   NU+iHLzmq/pEcR1vRURKSyZkLd9JzIa1YR70Y4pBqAcpVZpfaAT863esZ
   C23CAEZbwlzzMOKA7ADzcApS4UffmHTMcySzv54qRya3oq6ngF+PG8pGY
   /bDLmhrmNCz3ZJAgnrJHDm6P8vpPjRdosh50X8x4M5UXqM63Tda6bY27k
   A==;
X-CSE-ConnectionGUID: 8aAyMmJbQrGGJgqzWqK/UA==
X-CSE-MsgGUID: nvT01I1mQa2fTw9TPRNkOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26804249"
X-IronPort-AV: E=Sophos;i="6.11,163,1725346800"; 
   d="scan'208";a="26804249"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 07:29:56 -0700
X-CSE-ConnectionGUID: ZJkNVgbaSxeNZ7ycuJsCOA==
X-CSE-MsgGUID: Yg8RkM1LRceDc4YcEJdxPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,163,1725346800"; 
   d="scan'208";a="73361160"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2024 07:29:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 07:29:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 07:29:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 07:29:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 07:29:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BltzIAdVvBcLKs7cQuFVuois93iC8qqv1OD8DiQAKMTiE+kGAgUMlV+hss612yXdgyo1fFBld4xb2Y3yF8i8HdSSoLdiuLdekGKSD/MtcAjA8rrW+0xsGaaGOfmsNxre9fc6Ps7wPtJ+zzVvFs6xtBYyou5/JR2QwfW4PmX/lEsPbzFVPcM3/IYD+BQ/h8qcZR1pr4J7O7GA43vLgQsvsAIOokSW0X20Si2nP9FOvYivFv5lZu4E/GnyStLBhqgBzuLK+BrxLtnH5xQ68qeyYRVyzEgiMG/q1n2WdLL9WT2TEeAggHdNXOZ8dqgbK7QbvOpc2l5xm7AxSUcehsN1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvoH2x4jnJAK9QBA6aGTeHAGGiUKYd8ETnQ9Vk+fX64=;
 b=TD2M/b4dYjwZZo6PmDk50eJjuk9G/K5xaEkkL5mTsB2WRbc3cCwLj+1UUWGoDagxPhJcLXCjQYtqx6/OL0o2aQP75wtNEJcewV2R8KgWCiih0ypxVTbU7q0wZbpWeICiKKQqOyu4Z6+s0w/Ky2RyHu7mBEfgKMvrOIUADE2uv2olD9EUMBxrw0p56P5kKNjTUW7yF/XKO9N0BtsNgsGTuqGMGEBkuU7lhXAWI6DQ8gTWTc5cCoSHWbF6BjQwlkyEvJlOEdiiGQq4LAE/WsBkcxF1jgzN6L6RZ05uf3mhd/hBGNadE87VWTUYyb6R3QANT3Rnh8LuhtxgXR19CbARrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN6PR11MB8101.namprd11.prod.outlook.com (2603:10b6:208:46e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Sun, 29 Sep
 2024 14:29:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 14:29:52 +0000
Date: Sun, 29 Sep 2024 22:29:43 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [kunit, slub]  4e1c44b3db:
 WARNING:at_mm/slab_common.c:#kmem_cache_destroy
Message-ID: <202409292202.ac15a5ad-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN6PR11MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6f4949-dbbc-487f-e86a-08dce0932e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9nzjdgzmh8eqwNrP4F4M4/SS90s+g3NMA67F6P9LAV2RZh5VCo/OzBMSO0rl?=
 =?us-ascii?Q?0IVb8IRKOTVJY9dYt+V5fWT11VwowXy5S/AEqpo0d/B9cWhjleHGlYbst9/4?=
 =?us-ascii?Q?gF0WfLoVg8K/rc3jWRPLrnkmqM+Zrfq2D3DMdGtx6KYHi8Wi2OVT7v4KO5nY?=
 =?us-ascii?Q?9YO3633pIEaqvibe5uWVuWl26I7E/mx5C4bT2l6R8KESe26ZlJ5zvAR4Yild?=
 =?us-ascii?Q?vcXXZaEEXMRc5I8IU8B0uA4DTYAPIzV5/HbJ0zOxBVI3vwwB7gjJP8ULNYFx?=
 =?us-ascii?Q?CATqKRV5sJUdnQj597oOqi7nsEuL37Fjnis2zTT6fSyz4/B5d1yXRJkHq9Wa?=
 =?us-ascii?Q?hrprRzl0s6daj92GWlIx9wbNjV3umyd0C2eM4OFW1ocrZleS4uL0Cp/NBaoG?=
 =?us-ascii?Q?0S8lMCCySm0MJ+tJLCvmpbYyAZuweRiNjsHMXMF7Lr5UadE9TqghrgPK8R4I?=
 =?us-ascii?Q?mNfPp64FYGv6NveiAQdmfMKde996IBCAIY4bndeyxDT2Zb7ywKfhgnvW1qpV?=
 =?us-ascii?Q?CAVNfwNDCNj684QMO9KMc035QYKKWvjuhC21np0Raz0BTxgq22JLuTpb6Tc8?=
 =?us-ascii?Q?NlP9mUu5ISqMoxyvuJxCaOEVs8aTinUGX1zPbPbVv9QR8FOi6YbkLyhfGgtg?=
 =?us-ascii?Q?QsQ6ArHuP39WdKFpBmBtrwc5HleS9Cmq1+113QwZ7gYHBHLpm0FmWhVx3nDQ?=
 =?us-ascii?Q?3vQKgyM4OvTuaF+Jcl2oXTsW8XQ/XZFXU54PArKNt6pZmb0zhLaLP5q9Sk88?=
 =?us-ascii?Q?o/tTeUpaPiTB7mX6m1zH1Yyma7tYy3fCu0DECJd0vwLHorkz+f5COudRZCbF?=
 =?us-ascii?Q?GCPk56uP9k0P427mZKZRvOW3j9X/BWWvKXODs2p25r4tBUR8fQCq4ui9tvU3?=
 =?us-ascii?Q?cZ7+5R55mR4LfDNExHNzPdHmuwRBO8ODTidO5Ua7rSGxH46/J8jIzi+OEGO0?=
 =?us-ascii?Q?B4ltWeHdsXwNuh+KnYGFA2W1VT6QwFSwqXS/9QGpKKZsmwB2Nf+aROrFDMeu?=
 =?us-ascii?Q?BR1jpkfkVMOHV1oa+mQgQ8LSTIv6Z/u+3BVWD/4nZ+MnxtHwVS4x+l0jsE/L?=
 =?us-ascii?Q?zGIviB6MdARvResbWTQgm4sIgytpf4ypbGXlUBt9wL0Ixhowr2wyk7EK8BDM?=
 =?us-ascii?Q?BhoaB8CSdFxy4/fBMTZkUxEQclKmYsJd+mlhZqprDZ1T2kUk5/hLDJxN42It?=
 =?us-ascii?Q?oWPl351h+sCh2qXksRoBQEsmSAlxE9OKadcuJjshvYsyXyimMXmxdtvwxzCU?=
 =?us-ascii?Q?OBoWiGHl4xiZmXwVIB1pqiw9lilY5zu7XlnZe8/n4erN4m1DQOROgxokSwkC?=
 =?us-ascii?Q?h5w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bAjmDRzEAzHgYLhQ/HIwq8QXdqP5CWzG5QIenZRfgqenvg/naif9xZqH274J?=
 =?us-ascii?Q?qvurhNVEg1tC30cr+Q24ZXvnwt6E3treavxfpteINfFmfuthrFw+1SqzCaYJ?=
 =?us-ascii?Q?eyaoMsb4sSGcJvGhPXTzsfz3PpBs04kNTEH8+Psds6gcjAJmEpVvhb2dXAOC?=
 =?us-ascii?Q?NuWH8NOh9ulyHGwWZ03nWt6kSw+ieQuVrlYWu193iR4Yfq6P1kyaxXkUO1vD?=
 =?us-ascii?Q?dbhPTYbwsIlRn+Ik4fZKHoV2ZKm5oFY+3zQQyVeS2QYL6vXOfdIVHdUbf1qa?=
 =?us-ascii?Q?m52P2GvLr8K2BQETnV7BZmnF7Ag4wH7H52UfXsAchr/WBjlgWacLjcg1ldoj?=
 =?us-ascii?Q?ojcIvPYTZNMPQDwSPn1NO+URa7FT3QiChGRCnBJIARnIoTFzwPLDHWRRdwOw?=
 =?us-ascii?Q?6rLE70lwk2IzkHPA9tFIpF98ZHxBUjYCq1s5LJrlCu6EXN56RglXnhEqHpcj?=
 =?us-ascii?Q?0hXu9sZyU5o7TAoOeKMEDXvUPd96DdibgqoWYZMYN84LlZeyvoelCAShUMku?=
 =?us-ascii?Q?GPidRX9pO2zzx6MqQFdHhKgRH2Ugku9vCGNDjeHfNj3AVxAAId6A2STcYOgf?=
 =?us-ascii?Q?tiQ2KccL5k9V9qc+E4xB/pu7bYJdz5Eed/M7S1A1JXW/QDbIpNp7y9It9EBo?=
 =?us-ascii?Q?yhG+twDyqbhP3xDek0lk6vmmhXTCzbR8gJg+XXXYfiOEubVRKaFM8kLPBVN3?=
 =?us-ascii?Q?bJxph9I3L1UzW4StlSejhzcUH5tKe3zU8W9QqPA753nbPZOLY/KPKte4ENr8?=
 =?us-ascii?Q?q9g00UEh+YdSCWBoWExyYKjZNFYi8oYk1+n7B2rtyI8Q1ExmeE1MgRjL8qIY?=
 =?us-ascii?Q?HS7GR/4USBNr/4pH6BV+S2eFXlfIXooiJSKhUHCjcdtqy3M9oqV2rLl6ZpWL?=
 =?us-ascii?Q?4h8gH+N4+AO4wjPL14gbRj3EMbzDB1WV4G0jPdxsODm8wS/n3r8rQIhMCbcL?=
 =?us-ascii?Q?V0v+lnF8AZLVemG+ZKDGZydej778uYCigB1ZIkVsXvwxAd1mgAJz/M5RPjXm?=
 =?us-ascii?Q?RySZLWLQQqeX6BhUq1cV+J40IdI4eJhqfAJNxFJXUfd6ZKO+yaHdvH2t7EgS?=
 =?us-ascii?Q?qpNKtY9yobOD5i+OtRHUZE3ONVc8REIug8Q4MYV43m8a2Hae8aIjhY3cp1ij?=
 =?us-ascii?Q?7Sl1OzIE6UwPxmB201bJ4Fwu/5OlS0v4KXh0VAbEqjS4mXvLp8xt0jixfJu9?=
 =?us-ascii?Q?QI/YPVM9gvrlKQCBgK5g9gcQ5E/H+ZkhxZw1NFCOz6MtDXIDxYokeR+tcDsM?=
 =?us-ascii?Q?dGcfX+bHWQzw8xZKJdNgITfIUDZk0eV0uaTOYxDae3h+M+ZvwfuxafKiYzhY?=
 =?us-ascii?Q?oNI+tY9ooDTds/rov5oXO8p8VM77PsJMm1ygPQ/OliPqPCNb3j5s8uuVG6sU?=
 =?us-ascii?Q?lAAHCoOmN7aNfnbn9PxIB5f2LOKpcZYyAS1XK7cX7vStY+i525fpOJz+A7jE?=
 =?us-ascii?Q?YBRMIMj9TPexcYRH/8VqaHqV8ZgPiuL4rescp3bMgyVbha/Q/IlnBDvNGBi+?=
 =?us-ascii?Q?2Z1iCZEZgBEh5dgUMfjYlwIvLadJmorSCUJY67ouynIcruW2o513HBCOLfrA?=
 =?us-ascii?Q?Q2w9wflcOb7zGYw/SkMKCe0C8xnuKuZrtq8MdKCkq3jet48Yle/Dhl7Tp8F1?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6f4949-dbbc-487f-e86a-08dce0932e64
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 14:29:52.4413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jMgD4fAky9t76K62bNnZMNSZMbl5/0MkV9q9dicKS/iUfUQVb88dtu5DhK0tbIozkl3xkIbH1eg85GEu3ArqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8101
X-OriginatorOrg: intel.com


hi, Vlastimil Babka,

we reported
"[linux-next:master] [kunit, slub] 2377a7d90f: WARNING:at_mm/slab_common.c:#kmem_cache_destroy"
when this commit is in linux-next/master

at that time, you mentioned
"
Hmm in slub_kunit we generally try to suppress dmesg splats in the kunit
test context so guess I can do that for this warning as well. Thanks.
"
https://lore.kernel.org/all/c393e02b-65f2-4454-ba53-ae0eab5fb279@suse.cz/

now we noticed the commit is in mainline. we observed same Call Trace so
just report again FYI. if this is not an issue, please just ignore. if there
is a follow-up patch and you want us to test, please let us know. thanks!



Hello,

kernel test robot noticed "WARNING:at_mm/slab_common.c:#kmem_cache_destroy" on:

commit: 4e1c44b3db79ba910adec32e2e1b920a0e34890a ("kunit, slub: add test_kfree_rcu() and test_leak_destroy()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      075dbe9f6e3c21596c5245826a4ee1f1c1676eb8]
[test failed on linux-next/master 40e0c9d414f57d450e3ad03c12765e797fc3fede]

in testcase: kunit
version: 
with following parameters:

	group: group-00



compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409292202.ac15a5ad-oliver.sang@intel.com


kern  :warn  : [  127.285267] ------------[ cut here ]------------
kern :warn : [  127.285361] kmem_cache_destroy TestSlub_kfree_rcu: Slab cache still has objects when called from test_leak_destroy (lib/slub_kunit.c:186) slub_kunit
kern :warn : [  127.285378] WARNING: CPU: 0 PID: 4079 at mm/slab_common.c:528 kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
kern  :warn  : [  127.285779] Modules linked in: slub_kunit linear_ranges intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal btrfs intel_powerclamp coretemp kvm_intel kvm blake2b_generic xor raid6_pq libcrc32c crct10dif_pclmul crc32_generic crc32_pclmul crc32c_intel ghash_clmulni_intel sd_mod sg sha512_ssse3 ipmi_devintf rapl ipmi_msghandler intel_cstate i915 ahci libahci libata intel_uncore intel_gtt ttm mei_me drm_display_helper mei drm_kms_helper drm_buddy video wmi fuse drm ip_tables [last unloaded: rational_test]
kern  :warn  : [  127.286640] CPU: 0 UID: 0 PID: 4079 Comm: kunit_try_catch Tainted: G S  B            N 6.11.0-rc5-00007-g4e1c44b3db79 #1
kern  :warn  : [  127.286854] Tainted: [S]=CPU_OUT_OF_SPEC, [B]=BAD_PAGE, [N]=TEST
kern  :warn  : [  127.286982] Hardware name: Hewlett-Packard p6-1451cx/2ADA, BIOS 8.15 02/05/2013
kern :warn : [  127.287121] RIP: 0010:kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
kern :warn : [ 127.287224] Code: 8c ff c3 cc cc cc cc e8 97 e4 ab ff eb ad 48 8b 53 60 48 8b 4c 24 10 48 c7 c6 e0 20 55 84 48 c7 c7 68 da ee 84 e8 89 dc 8b ff <0f> 0b e9 28 ff ff ff 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90
All code
========
   0:	8c ff                	mov    %?,%edi
   2:	c3                   	retq   
   3:	cc                   	int3   
   4:	cc                   	int3   
   5:	cc                   	int3   
   6:	cc                   	int3   
   7:	e8 97 e4 ab ff       	callq  0xffffffffffabe4a3
   c:	eb ad                	jmp    0xffffffffffffffbb
   e:	48 8b 53 60          	mov    0x60(%rbx),%rdx
  12:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
  17:	48 c7 c6 e0 20 55 84 	mov    $0xffffffff845520e0,%rsi
  1e:	48 c7 c7 68 da ee 84 	mov    $0xffffffff84eeda68,%rdi
  25:	e8 89 dc 8b ff       	callq  0xffffffffff8bdcb3
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 28 ff ff ff       	jmpq   0xffffffffffffff59
  31:	66 90                	xchg   %ax,%ax
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 28 ff ff ff       	jmpq   0xffffffffffffff2f
   7:	66 90                	xchg   %ax,%ax
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
kern  :warn  : [  127.287539] RSP: 0018:ffffc9000089fd38 EFLAGS: 00010282
kern  :warn  : [  127.287644] RAX: 0000000000000000 RBX: ffff88816590bb80 RCX: 0000000000000027
kern  :warn  : [  127.287792] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff8881c0c30b08
kern  :warn  : [  127.287937] RBP: 0000000000000001 R08: 0000000000000001 R09: ffffed1038186161
kern  :warn  : [  127.288070] R10: ffff8881c0c30b0b R11: 0000000000000001 R12: ffffc900007bf7b0
kern  :warn  : [  127.288204] R13: dffffc0000000000 R14: 0000000000000000 R15: ffffc9000089fe40
kern  :warn  : [  127.288337] FS:  0000000000000000(0000) GS:ffff8881c0c00000(0000) knlGS:0000000000000000
kern  :warn  : [  127.288486] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  127.288597] CR2: 0000000008082db0 CR3: 0000000124592004 CR4: 00000000001706f0
kern  :warn  : [  127.288730] DR0: ffffffff87422404 DR1: ffffffff87422405 DR2: ffffffff87422402
kern  :warn  : [  127.288881] DR3: ffffffff87422403 DR6: 00000000ffff0ff0 DR7: 0000000000000600
kern  :warn  : [  127.289033] Call Trace:
kern  :warn  : [  127.289095]  <TASK>
kern :warn : [  127.289149] ? __warn (kernel/panic.c:741) 
kern :warn : [  127.289226] ? kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
kern :warn : [  127.289317] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
kern :warn : [  127.289399] ? handle_bug (arch/x86/kernel/traps.c:239) 
kern :warn : [  127.289478] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
kern :warn : [  127.289561] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
kern :warn : [  127.289651] ? kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
kern :warn : [  127.289757] ? kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
kern :warn : [  127.289864] test_leak_destroy (lib/slub_kunit.c:186) slub_kunit
kern :warn : [  127.289977] ? __pfx_test_leak_destroy (lib/slub_kunit.c:179) slub_kunit
kern :warn : [  127.290091] ? __kunit_add_resource (lib/kunit/resource.c:44) 
kern :warn : [  127.290187] ? __pfx_read_tsc (arch/x86/kernel/tsc.c:1130) 
kern :warn : [  127.290271] ? ktime_get_ts64 (kernel/time/timekeeping.c:378 (discriminator 4) kernel/time/timekeeping.c:395 (discriminator 4) kernel/time/timekeeping.c:403 (discriminator 4) kernel/time/timekeeping.c:983 (discriminator 4)) 
kern :warn : [  127.290356] ? test_init (lib/slub_kunit.c:196) slub_kunit
kern :warn : [  127.290454] kunit_try_run_case (lib/kunit/test.c:400 lib/kunit/test.c:443) 
kern :warn : [  127.290543] ? __pfx_kunit_try_run_case (lib/kunit/test.c:430) 
kern :warn : [  127.290640] ? set_cpus_allowed_ptr (kernel/sched/core.c:3025) 
kern :warn : [  127.290732] ? __pfx_set_cpus_allowed_ptr (kernel/sched/core.c:3025) 
kern :warn : [  127.290847] ? __pfx_kunit_try_run_case (lib/kunit/test.c:430) 
kern :warn : [  127.290959] ? __pfx_kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:26) 
kern :warn : [  127.291087] kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:31) 
kern :warn : [  127.291195] kthread (kernel/kthread.c:389) 
kern :warn : [  127.291269] ? __pfx_kthread (kernel/kthread.c:342) 
kern :warn : [  127.291350] ret_from_fork (arch/x86/kernel/process.c:153) 
kern :warn : [  127.291429] ? __pfx_kthread (kernel/kthread.c:342) 
kern :warn : [  127.291510] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
kern  :warn  : [  127.291595]  </TASK>
kern  :warn  : [  127.291650] ---[ end trace 0000000000000000 ]---
kern  :info  : [  127.292358]     ok 5 test_leak_destroy
kern  :info  : [  127.292386] # slub_test: pass:5 fail:0 skip:0 total:5
kern  :info  : [  127.292500] # Totals: pass:5 fail:0 skip:0 total:5



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240929/202409292202.ac15a5ad-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


