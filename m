Return-Path: <linux-kernel+bounces-566806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FB4A67CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21328833DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A623D2144A5;
	Tue, 18 Mar 2025 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWoGRV/P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387D21422F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324820; cv=fail; b=l6ivKqKzzPaTTpOrDAYQW1/HIWIcdVWBAaVLHFzIGOztRG3YTZhGwYWDdlIjFt1rcfL0QrSonBur/gounuCDhmzm49NBxS5gnJCR9vKmxOWC5fUsuUJEYKVxie2dPuUR/+WTrjZDMOZXNPy3O2hf70W7+XgK6tWVXiLz2MvWlmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324820; c=relaxed/simple;
	bh=u4YZtDfGUSON0iIfRa+5OkosHNfHUOTNp+WQoaYbcc4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NF8ew/ZOoZs21j+dpiOfm6ivPc0oTiHaCmmIvuAMtqFwvL5eG8n/ZiQOmUJaMgZ6WIE+7pyWE/sl3z7lDxdQ743i+6mESEodo9g6Ys/zedqCk6hvPUxHUQCV+hdHdT8AYl/kfAQM34+rnXGnk3bS01eSuU6NkuvE2AGMO5DIStg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWoGRV/P; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742324815; x=1773860815;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u4YZtDfGUSON0iIfRa+5OkosHNfHUOTNp+WQoaYbcc4=;
  b=RWoGRV/PPaib9CiEhGysxr7scyHfxD9kHBO6AdGMkKGATRxN+bsjB6oa
   DECnntfAT59DPyut8T5MrdhiT83c5jytda8tvaTARbzvEhe0kRYDZtjdC
   Aot9BaiAtHxi5cPtlsFAGeBsT3S8gDVRjmhWruyE9pVtqxJGhSMtw3ChH
   Zs3WEC7Bn5Y/nlalP4UdJnAAaNV6Hw6AYPRQ+PouB+lSm6ZZix8K6ggHP
   kfe4xiDMG89zsGEkI3M5b6ExfcKdLw5EWGYQn38+45Gx2EifDtahoiS4j
   XHgQh+NYq7SX3jYuApxHCcAKvp8snD9LMWm4UMdVovbP+coi6kUmqd5Vb
   w==;
X-CSE-ConnectionGUID: DThTekGWSsCo4+fhDRpjhQ==
X-CSE-MsgGUID: 1ky/XofGQ0aFg+L1YuGu4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="46249217"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="46249217"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 12:06:54 -0700
X-CSE-ConnectionGUID: Hze5mH2LQ3GnHH0BmB5tIQ==
X-CSE-MsgGUID: 9zVO63eAQ1WjYMoxEoaAZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="123105499"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 12:06:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 12:06:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 12:06:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 12:06:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ryg0p14Wy/mBEHXkyWAi9VxAkJ9z0c7X/3d8Hh9VZxTGu5yzGeG9uqZVkH71i2+LNQ4XSSQA4UAhTgtjpQ7aJodr3LjfSrsbBGPySuHYpdOBYAj1uGH9VgffxVWfSgOGKe5Y9g0FH0+9b30GgnH8TXs6k6oUHUF6tIG0BgDUEQ7hMHvu5xaxXU2ZF/AZhZjQUhs/jW4gwLcc/BYkf+V3xDGLCgDnLfrIIjbvS6xp3m8N8sZlNlyG31Sx1eF5Hx/xBIOjqGnHXRCwNzbReKXqs6183neSlAUU1xRnMwyRHzbyTGJakJrYewBVTPqik2lXcQPJcFiBht4oyIS26wuNpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zdJUTqYNky9OhMNV1UoVecHl3B/AHp0fMU411vW8MQ=;
 b=HFDZigGoczjgPC6pocZOdom/+QC53Hi88RP4GX0+4p050zBKQ/t2W4stg80F2I2FZtU/S0QP9H7e1sYfMeRr9YNjotmqyUhD7fwpItd089U0c+ZCg/wgp9D/ggK8NrEE4bHkM7eiTLZT809IydfnKGMtXQfi3Wdr1kF6TXViy37HtlTMgJDxK+cVGDRVFwvAb8PjKBa0JkVGaf4o/sLAOH6TPbN1X96SMCtcr03Y25VLZj8W/+1O9ouiWpewAZ+/nZjDFQOsiEd6pwzAv26Yuv+QVluCrkq36LF86UYoI11bsEMFpFttUIkQsFxAYrGFZ8GMtloIro7RGzTDTL118g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7635.namprd11.prod.outlook.com (2603:10b6:510:28e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 19:06:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 19:06:50 +0000
Date: Tue, 18 Mar 2025 12:06:47 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, <dave.hansen@linux.intel.com>
CC: <kirill.shutemov@linux.intel.com>, <linux-coco@lists.linux.dev>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <vannapurve@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [RFC PATCH] /dev/mem: Disable /dev/mem under TDX guest
Message-ID: <67d9c447ddcfd_11987294c6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250318113604.297726-1-nik.borisov@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250318113604.297726-1-nik.borisov@suse.com>
X-ClientProxiedBy: MW4PR03CA0319.namprd03.prod.outlook.com
 (2603:10b6:303:dd::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d90f3d-e76f-4c8f-111b-08dd66500985
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hlUKuA74BGgza29Y+0yDgLNNNDGL6H7GFneyEJmwNnwPXXtqd0TtxNTfBZkx?=
 =?us-ascii?Q?fF4JZWYF9BSBoSELFLouwd/oS70SM7XpTDfO6bzE/vxrziFncy9JzqrB6dX0?=
 =?us-ascii?Q?X/BpcSa4yhp+c4xvF/ul24biyPBpvpcT9LxPFHanhT2kZu64zTdIUoSFsx5L?=
 =?us-ascii?Q?PjxBM6MpCI1Sov7KSqP5v+ryuGYeGn01oLZnKKzBdg/Mtsu9Ft1U3UvbJfmp?=
 =?us-ascii?Q?pmAQ9UQq59EGfjxH+okGjb7iP8QjYJLBDL1kTTH0nyxN6t1bEXOS4XP0lnhN?=
 =?us-ascii?Q?4+VsQ5QkvRMI3huXAZhibpqq9YuxNlEcPvIUthskn9i2iP7s9FGmuVQGQDGv?=
 =?us-ascii?Q?KoAkr9L2gYJ2rSn/0q4f5Uzyqw05I3hqmfjgfBIIxL2/YhYA76YpJGGa2HIl?=
 =?us-ascii?Q?1rpHQMsFehqDVTD7tVHzcGS5VGZFS8QJy7CRwHIF2GPPlz09Jf8v+CWPyonz?=
 =?us-ascii?Q?bROx6aMnXnYoi7jzhbZo8yDulGfUon1qDjDDFGiul88gOnFGj12HAgcfKpeZ?=
 =?us-ascii?Q?Bchlh1GP4o3le0bgDrFDwb+wvQYqESNAht3iEADgK0PNwth77usSpfGz17as?=
 =?us-ascii?Q?Yh+gODfm5C+n4RrGIlf6jkQUbs+1Cv14FC+xDun07tCTY313l2L00UQCy9NR?=
 =?us-ascii?Q?2rioBg9yOa98IYJzdnM4McPbSmJlPMOmCiwSxSKl33ea/Nc7LskCgjVJIjQT?=
 =?us-ascii?Q?W9lKm1e5EYP9tNmcI7i8eicZYWVK6lTZZ39n2WKWSIRyersPd6H51s+FC5vD?=
 =?us-ascii?Q?bBT1yLXMY058GoxkMFBDI79IENzvWzQP71nQtUXTqSMCm3ciwInVAvEejMUa?=
 =?us-ascii?Q?2XSLg5XNHHasbJantjrXLuMNNGZ8X8y9uLXBkdyS0BZQ9lnyI9zJyUUKCLWy?=
 =?us-ascii?Q?EB57xdllS0sxxFMhsc5dWr94JkOUMIZVMsneCKMmgj7tBPALQwVOLd4Cw9Fh?=
 =?us-ascii?Q?FzOdT/PvZmw2ueMO3Y4ehLr/pzFHvqZANQZdCpD8h2H8U3iKNSsWcbbCKgCl?=
 =?us-ascii?Q?LFOS/L4kpBPa9aLg2i3Ofv0W0uzC0ccIf5HBzf8aeNfti4z8SCozuuXkZ5cr?=
 =?us-ascii?Q?Y0XFhJsZsLIYihsZMxqUKyOfnQIXYuxUMmPaCeVlXSiA+ki/MZHddvn1ej8S?=
 =?us-ascii?Q?QT/rR7c20nA5oIOPDOxixXA0uwmm7l5jxjgPUNv90R5TuAv+PsbhFXJwJ448?=
 =?us-ascii?Q?NiowDAqbeAf6AnUozxPtq2I/Z971jJqTKFiNq0Ef2bL2lbDyMFnEYRytE4SJ?=
 =?us-ascii?Q?qtk6QAxZV3NvpQkLMDvtt6TrejNuWsli7EwgIKA2uBW8l7LYCSaW+fjG435P?=
 =?us-ascii?Q?7hbpgVucS3shV7P0+e4PIyEr0G6SmoZ5dFN9Y/APmlA590YdkzYWEj5sxnB1?=
 =?us-ascii?Q?B3c6gcAxbBaVEoZtY+Isi1nxV9CE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AOtMUH2d1Hmv8mevWbCWyUS/Zb1dLP6d3jZDD8h5vjfJq1Hnzhmm3EqHCpeD?=
 =?us-ascii?Q?7vAI8GTW1rkj+dKdkA89C+g3/AUoWdsjDjBP7iSoCn1AM2387H+Rv/d1bxLS?=
 =?us-ascii?Q?/sOL2uK7Epvs8T+71HCEhgW9HVUYDuqY97kq4Q68JLWwu3bdZ5xGFX+Gx1dq?=
 =?us-ascii?Q?MuCGlpwKuTdLC2YIDUhN7jkifPfHjVcugTvFVWeKO9jdMW0HyiLWicca7AWW?=
 =?us-ascii?Q?ZzeJHcstBkDlU0P3++KMfHPB8DYO2QTcfoWwwkYOgNVtDSkf+ABspXwU79iF?=
 =?us-ascii?Q?6uX5trHFzFtw4tZb8s5Dwi10LJb5W6vTpu632b6+Qiib+c7zBiIgSIDEXhOU?=
 =?us-ascii?Q?C2MBC+OM626PgOrLwMBQHJxT7tpFCTv7CJeIBbECEPPc4ZqTRp3dipMXm4II?=
 =?us-ascii?Q?JiQwTjiabp5FdKCB1hAh65wD9T58lqtsiub5GGe0huj/Cg1KMubUWsvF7Jeo?=
 =?us-ascii?Q?ssE0mzEneacH/nb5OyIjqTPTcCLbleflxyf5w1bBsyOwQ/0PLXsB8nZMf2at?=
 =?us-ascii?Q?AC6u6dbXC/ytRuIT1eNJP35UPgHN2m+gszW3ykKwXPh39QtT6rm75qPAw+ev?=
 =?us-ascii?Q?JHs4mvzg7bVO4eOEWGaEXthfEJFcFpuiK8U1QOO7EsmPNb7DJLoJpWFpoeo+?=
 =?us-ascii?Q?ymATImXTJjxWMEHvKQcPSZT0SBSaarfJquadH5rpj3gJGtIRhuOtK4WsPERZ?=
 =?us-ascii?Q?7/952u/ptPe7lRB6Q8/w4rCzeibfvHYqlR54Ij21MSXsqSp4BpUInS6kZvJQ?=
 =?us-ascii?Q?g3wB4GotfcHP2ok2uqihqA+9eNUcxp8R8lbTcXNaO3AGRJBN0YCuaK/0WrnX?=
 =?us-ascii?Q?P1jv+Kq/rPNLiUna/GtA0n0YljruHzjMD+zQSmvUNtJZUQ7YC4RnM6/Bh6sh?=
 =?us-ascii?Q?oZqvQd8T6ljJ1s2aEFNwYTm2nhXNEb+lRSFMywuJIed4Xkhu7ltUhHeYkUkM?=
 =?us-ascii?Q?1k3zmh0SMshe/y/C+ppifQ8Y8qZcdod9Ea1rpq3TAJEW5z3fKczRn7O4wY8G?=
 =?us-ascii?Q?NzQgTwyd0n+Yf7WQw0vjaApqoEhBWD5g+YYRBHYUzrbl2a4idZhgjTY0FISE?=
 =?us-ascii?Q?38Bq7lbtmxGqSeY4iWtl0rX6pS66UQZlQVl+6Qb81f2xh4ePF7yxsQpUwclG?=
 =?us-ascii?Q?Wt4f4aMTlE2IIcCArImUfbja09sz2FLBgkE0gbO6m2KeR4vHPtS0gp8uk389?=
 =?us-ascii?Q?LOmS6jQv/8iqoZyY89Tf4Aj4+opgRYRuKUmKWZTdgyYkfQT0o9u47rgOcV0S?=
 =?us-ascii?Q?q4gUKdb3haDM4nBpqQO8kuawtZD+ryfBHeM/kkVa6DtOIccNJE6lSXCww+Un?=
 =?us-ascii?Q?2bXCRCdpYwAHgETj6Hxzlnnat0SBeQh0JWTrrY8vYANFZcpS9qWikJwY5Gxl?=
 =?us-ascii?Q?3KWALj5owPgjVMSwXeAqSXgoY4gBlUrgceQEsAbWatyA+FBh7yYzI+9IMx6v?=
 =?us-ascii?Q?1q6xlUrDJkz6cKQwu+9MPcmXXBZQWWei2E1ylXbZW8WVSTxSmfilTlNXnS8I?=
 =?us-ascii?Q?sOxJJo8BbrsQ0MEQ92TgYTCzceBrEz1x3cAhU2WMGuF7rjt/Z0B+U+Myme8D?=
 =?us-ascii?Q?tc27V+siJgyq03b+5xnixOdlvhgMttPsYbX0XI3IkryD/4LCqixZF+kAIgmv?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d90f3d-e76f-4c8f-111b-08dd66500985
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 19:06:50.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGtku9UIybub/ApKU297K8edRgn9IsOer6JYhn4EkPF+zEZn1gR+u2Ap3k6gscg1V+2m9Vka4UBCJeOR7Yq/9mjRcSImj6ce3C/QxuqkFQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7635
X-OriginatorOrg: intel.com

Nikolay Borisov wrote:
> If a piece of memory is read from /dev/mem that falls outside of the
> System Ram region i.e bios data region the kernel creates a shared
> mapping via xlate_dev_mem_ptr() (this behavior was introduced by
> 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()"). This results
> in a region having both a shared and a private mapping.
> 
> Subsequent accesses to this region via the private mapping induce a
> SEPT violation and a crash of the VMM. In this particular case the
> scenario was a userspace process reading something from the bios data
> area at address 0x497 which creates a shared mapping, and a followup
> reboot accessing __va(0x472) which access pfn 0 via the private mapping
> causing mayhem.
> 
> Fix this by simply forbidding access to /dev/mem when running as an TDX
> guest.
> 
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
> 
> Sending this now to hopefully spur up discussion as to how to handle the described
> scenario. This was hit on the GCP cloud and was causing their hypervisor to crash.
> 
> I guess the most pressing question is what will be the most sensible approach to
> eliminate such situations happening in the future:
> 
> 1. Should we forbid getting a descriptor to /dev/mem (this patch)
> 2. Skip creating /dev/mem altogether3
> 3. Possibly tinker with internals of ioremap to ensure that no memory which is
> backed by kvm memslots is remapped as shared.

It seems unfortunate that the kernel is allowing conflicting mappings of
the same pfn. Is this not just a track_pfn_remap() bug report? In other
words, whatever established the conflicting private mapping failed to do
a memtype_reserve() with the encryption setting such that
track_pfn_remap() could find it and enforce a consistent mapping.

Otherwise, kernel_lockdown also disables useful mechanisms like debugfs,
and feels like it does not solve the underlying problem. Not all
ioremap() callers in the kernel are aware of a potential
ioremap_encrypted() dependendency.

> 4. Eliminate the access to 0x472 from the x86 reboot path, after all we don't
> really have a proper bios at that address.
> 5. Something else ?

