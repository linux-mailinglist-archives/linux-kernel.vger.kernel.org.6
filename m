Return-Path: <linux-kernel+bounces-171676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85458BE731
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA4E283B0C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DEE16193C;
	Tue,  7 May 2024 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VDgIiEed"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A98161313
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094991; cv=fail; b=Lmxf4EdupJQ4DrHxjUY/sz+a4MFboouRwh25N/TQKgGilfNPpPRrq3f+sAfmiyTl4dRZXrJm8VDgh2168uUAOTmViXvYnyfMFchqW0dqLoPmsdbchugC+fJ0Pu61zbxwx5pneiM63OYxqvPljJOv4BbpdvrdAWCNpG1kkk+9WYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094991; c=relaxed/simple;
	bh=xhi6hKe4QWtbfKE306o/j8wOQPL5fj/AGz37Uoglhc8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L//GbWOGV3k7ZnxYJcgqbZd8Llns1AStoGjJFNRE6d9GloeH0lMJNKWXuzCyimBX5v42/QIfAr21jKcVIvE8fGv48glwyQ8RhLDDTgIt4V9WaXvHOTxczVdq1x9sZ6K67r6Yr0kHCXePvzwmdux8/xdt5YYV269mQ7FEkklC58k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VDgIiEed; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715094990; x=1746630990;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xhi6hKe4QWtbfKE306o/j8wOQPL5fj/AGz37Uoglhc8=;
  b=VDgIiEedz0t5FlGRUmjDUHQmyu4M7aT0SQCMlLnRCXWpSGbEovEkMO/J
   fn0hIQtkgAYkINNUR5Y7SNB0JFmKseyRfeBENjK14DPDA4OwbSWnCBTcd
   CbshWBHK5Hk9HfpNtLbcU9AOUoF2IaIbIDTnzfWpnJrZiqCnVRmeIWri8
   z0j6sjdwo+wzc+UIhPdbRkmLSF8SbcB0g38MVG1a+homVDNfyBb+A5UpV
   RhJxFEEOY1m+atdf69++gBTYTzJbWq8AK9AyQdhNuv3T9RWIIqP+LeUK0
   5stMDFOnqR0h0I0uxzonFoe3+xg/RA59t9mx1ClZdn9RLzDN1ptZB9Zsa
   g==;
X-CSE-ConnectionGUID: VaXAAqryRXeHNB2R7FMIoA==
X-CSE-MsgGUID: TKhj5yz0T5+Q3Ps8xuxQ4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14705908"
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="14705908"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 08:16:29 -0700
X-CSE-ConnectionGUID: i/U+33KrQ3C3HO6C/eDPsQ==
X-CSE-MsgGUID: Frb4BMGkRXyHtZQvahdGgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="59724880"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 08:16:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 08:16:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 08:16:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 08:16:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 08:16:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8vbnM7YMhtO7UtrALkXmVLdD0F0ChtSgcoZD6KGTe4aoo9g0LDpZK+OlUJ0kfgFwH5Qpp+2rSTXFf29ZJa9nu5C4Qkg09TV0q7TM01lHiCr1JhEnF0YYMe/MHYxLHRuvM3MwE35yS/ADuJzSTzxQ3f5SIZEbOwMBSYEi9MWd9vnH5QjzXe+R7S/bZ7vaB1cWGSl3mO1ba7I2LE7I/7cmEnkeNEHOk+6flzVxk5KiPiT1xucqmPE/XkYSkVZuNAfXHNWRaN01OUMQgDlCBQlPGBxmifEi9wJTt93K3+AjY7eHcRoptclOpvTTUFxz7v0etG3WD6yIT7IfqbwQT675A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ad4FNMN1TFz+SE4SyURqBUcfel0nRFdNZR7Lan2GvEQ=;
 b=eBeKgzfK9nPPdGFlzterKX8nodi1V9j657JMihT3C+ZJMmj+6eVH0f6oNQvKxEFA3kx9uGMKwpwmgqTFcUdc+rX1Mx7DAs9k64gECQOUGao1H6ecAlzjEfFIHaUBcPSsujOhrM3p93KhWxEyM3E55HTfr3fUDKPwnP60WSDVHqktfPw7S50Z7LbeWOlKlA5YJaXJ6mOVF6Y6TCCX/ca4slH9lR2hDkbZp9xRWvPbUffJsx4iaq1GYmD6xPw5f4jPmceNTwlJBkbSrffnVLnd3Jvx1L+ACswJ90EyCM/ZbhZYUH/bmB8ZAqu+3yWExb2n268S5pHnZuE+H+A8EYR+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA0PR11MB7402.namprd11.prod.outlook.com (2603:10b6:208:432::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 15:16:18 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:16:18 +0000
Date: Tue, 7 May 2024 23:15:58 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kprateek.nayak@amd.com>,
	<wuyun.abel@bytedance.com>, <tglx@linutronix.de>, <efault@gmx.de>,
	<tim.c.chen@intel.com>, <yu.c.chen.y@gmail.com>
Subject: Re: [RFC][PATCH 10/10] sched/eevdf: Use sched_attr::sched_runtime to
 set request/slice suggestion
Message-ID: <ZjpFruUiBiNi6VSO@chenyu5-mobl2>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.934104715@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240405110010.934104715@infradead.org>
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|IA0PR11MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: b3bed1dc-3322-4dad-a569-08dc6ea8a519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BY9KZMve1pa3Eb5TKkgkjA4ouvbKseDQ7vNEG+BPaoJqYLMKXfu2y1zkjjsv?=
 =?us-ascii?Q?j/Ze4wgSIU/r97PdUqrcy8Gx72Q84hURwnaQgCVy6UQs5WjrRuLnp3qO/8cA?=
 =?us-ascii?Q?C+lmyiY9hHvy+HhNw2w8st1z1U5+CU51APCSrzbpE6Ihd9yv0ms84AioiJrO?=
 =?us-ascii?Q?5Lt7BdLavoamTAuK/LNkHTkz8V3H+LBBG3VR0QEocNx725ItJN7vkotx4Syc?=
 =?us-ascii?Q?yoisFlXiSq8VdLXYIwR+iPkkKka3bB41McOe/ZyucAFrwu41B16eNG8AK7yp?=
 =?us-ascii?Q?EFkMtmOtdnOoQ0KIOH9HjDV5l9Tjglg3Q4U/91CHGP0Lz0zwH2+5587hFNjn?=
 =?us-ascii?Q?4KAKZjMghxOYXNRBvEmLsyjG81DTS/NL3nW2m+OYBIT7C/uxbi69xGHh5g7K?=
 =?us-ascii?Q?Ybl+VSshfppmbZm2mM5HpgPYoyjqAszTL6liNshNf3gmaYREwcETNuTwOVce?=
 =?us-ascii?Q?SJNoPeFhSfoc1ekEoHo6HYAMCMa9T2UIeFHz27bWHTCCHGWALZzfjknseziX?=
 =?us-ascii?Q?/E2oZgqETRuNISaY06+XnvhT9Iu2lfEGq9LXFkV6IlegPg4i3FRb3Z25vSHQ?=
 =?us-ascii?Q?/4+57gwoPLAk/MSxn3M+jTEUWesGpVYx28j7DS7UBibcpuPQlFHKbEfiEIC7?=
 =?us-ascii?Q?j9VSUO5U29mN2Kp0jGC8/lvlNWrgBTrWvfVLiMmqCDDdf36zqjNMTbO7eFPe?=
 =?us-ascii?Q?lnEn8QA0ec7xyemU3dAEfkOLDEi2bYCUG8R4uJaV/oCbU3o7/FHLSulnH3Q1?=
 =?us-ascii?Q?ROUcn8S2jm7NgbsIfx2P3PmzgAaUDe1uc3wFNP8Z0EEnUkmpXbrKGE/jAObf?=
 =?us-ascii?Q?IzLDOTUVi/eCA0Y4JKfGejROIU7sc17nz2d63mWOkDz6C8WKIIU+x5giE6kC?=
 =?us-ascii?Q?boLEuPAeuH4l7HKmR74aRvUOJUMZC0aJihQLa7c7h3OGfD+iWKCe8nuU2kf/?=
 =?us-ascii?Q?rzJA9QK+jLuu5JOIoO7VegVF36Z9IN1rlnlUO4/HlXcxHV8i+3X/Ux7CkqRR?=
 =?us-ascii?Q?/+l3gip8TjT8fkYWaiKnvabUWhHeIqYbMK2H14QpnKmCk8bF47A9LjmJf7Ac?=
 =?us-ascii?Q?Yx60lami2IhsfRmW2ZhE3xWCYVd2PeMV2yqyj2yEg3ljAxH9mxt+xTHNmpK+?=
 =?us-ascii?Q?Tq3MybX9on/r/P9TtSYwPeqWfAEKbJ5DVYbvXy+t+j1iTJhyenNOr1HwNyYI?=
 =?us-ascii?Q?SyILnI3r6pEXUgnlTpAedkjcswL+YETgNXYeG+k25zdKyY7xXS4P4VZrypoB?=
 =?us-ascii?Q?LXDBVrIcaPO3mmd+iwFawNnuKycElVfWtzLS+oEJgw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ge6C2brLjq3J1nkCvVh7WBIniVjSC6YPXlt8hLpBCZ+5vGg9Agky0VDcbUMV?=
 =?us-ascii?Q?LSyzI/ivE7brgc2ZuNTDB4nbxqU7gEbhbcqc4JF5kxMNQa7doWZ5wAJc+eF/?=
 =?us-ascii?Q?Mgjn+0e5EjbupRb8piVuNQKOA+ZXgfHzLiOw2NIt6UatRzinyXhmdfNcjwnr?=
 =?us-ascii?Q?4bITKIkiuU5HXJoyyxoLSM8xc2bU4AR2lrbEqwc+o2KlkUHLM+OnctXaCbyX?=
 =?us-ascii?Q?h+KD9mqWooEigN6DzmyrkyMe56FbWIsFjtqMLWawAedWiWfntaZ3KkM7w03H?=
 =?us-ascii?Q?8r1D2yk5CPcpzulSI2k8cKnySrDkRqBHEPmRx4amkxcNqySVyQh577jFf1yK?=
 =?us-ascii?Q?6Lww4NuGd625N+FV8pP6wVrM5JoE4hlrTJtqMRtXC+7VIvdix7aFGSg+QniW?=
 =?us-ascii?Q?hvbgrW5UT5btmlF8r9okvNOmRs2tMtkzF+6aMhXg6X4jCUTlSO7JJXe5G/eJ?=
 =?us-ascii?Q?ti1YI0yxzGhopd9GuNDMhBWqnX2LClI8bZ/cK+AlKtn9louU8rg+T2E7aBJc?=
 =?us-ascii?Q?YpW5A6gARDEKho8JLk2CPYb5uhi6lveuMu3r/cRRZc0Z4etBAcKNRALL3IEe?=
 =?us-ascii?Q?B8IdwZKcOS8uYso7Yh1OFupfz3UuyrTJfht1PajkBqzIKmfUSn/jcrSuino0?=
 =?us-ascii?Q?NE6yRtaYF2FxQIWoaqD60U+FTz82xbb2iMeuiNYyq1+WE6AWQwwnz8oABLgI?=
 =?us-ascii?Q?bvLcAU8UNIxp5I+4MdehKmgU8afK73YxQUGT2iqopzJt50WRFlORkx8JNAqL?=
 =?us-ascii?Q?YmbfWQy5dZgMj27hwHD8nQJ8nnXf4gWn0+tDrv4FR2ycbI5a4yP7GoujwpUG?=
 =?us-ascii?Q?XPAOhYmnH166D0pJqkYUWeP5waxQBjuiRjvPKLhJpfSMkVfZIiSq4IxIU9ZT?=
 =?us-ascii?Q?pibrWeraJRnAPoaupWx9TFmO8CZbn7HX5P1CQW9JvQyV3q6ddjaAX/nxW8ZK?=
 =?us-ascii?Q?9LfQfe2uRY3MqWqFPAXrd0dVxy0pvxAjxdcjHlWBhjbS8eDVLB3nqYFrk2un?=
 =?us-ascii?Q?zT9WdWNj3PWT87lXvkBYyXwKrP8CfuQlR1wgJgl7Q0ZtLyRzD3YBqaYHoMVT?=
 =?us-ascii?Q?f4DASBKLHhMsEsmyYCJSZP5TSwpsdxyGR1Tt0UL9kt4vbf72e/iKJQPNbT8o?=
 =?us-ascii?Q?23uuUCkmW7rIhNsmO9P16WRzR5YG5CwITrDLABu2+7t89Fkn7UeW6R4fSqJR?=
 =?us-ascii?Q?ovqUV8qcFE6qnRC3lJxAs5tfHLn30C/zUPJJ+qg1e9VLVLYOBBb43f/Eejeo?=
 =?us-ascii?Q?wqnL5+RfMApBD6vkeM6UNUwC2OqT/tIbOBAu9oQTon2T/qd01wcJA2FpILu6?=
 =?us-ascii?Q?Uc4Ng3dJ4mtL47iyVuki5gTZlDNCzUm+cDvHelfCRw/MfwOCl5wEg5iNe2Pv?=
 =?us-ascii?Q?zwePhmNd4b72smSD6sGX7M3f9BSDPzUcbIMbo14ES+9xPWCPeMMKdT2idM/X?=
 =?us-ascii?Q?L8NA0Op+3XZDxPbnNaTeiVUirRUA4cx9ChyNuaabwXpNsB482sWSmFBCcLrQ?=
 =?us-ascii?Q?jkROjSJ4j2aB4FeX6zh3Ub0BDCzYzzcagO3Q7f2Y9NbjBmlMddGtCqj3ZvSJ?=
 =?us-ascii?Q?PWz/CgC0E+cNTzml650yRCJn49wUIG9uLLsYWC+l?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bed1dc-3322-4dad-a569-08dc6ea8a519
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:16:18.5324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WZKKcPnRFOJT3cFN6Eh9nGerqBeUfZxYFMRyPB1qYy3VidDRlfV/rhMvsW+86hkZfWQHc3XgR4IFEMO/ZrYcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7402
X-OriginatorOrg: intel.com

On 2024-04-05 at 12:28:04 +0200, Peter Zijlstra wrote:
> Allow applications to directly set a suggested request/slice length using
> sched_attr::sched_runtime.
> 
> The implementation clamps the value to: 0.1[ms] <= slice <= 100[ms]
> which is 1/10 the size of HZ=1000 and 10 times the size of HZ=100.
> 
> Applications should strive to use their periodic runtime at a high
> confidence interval (95%+) as the target slice. Using a smaller slice
> will introduce undue preemptions, while using a larger value will
> increase latency.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>

Is it possible to leverage this task slice to do better task wakeup placement?
The idea is that, the smaller the slice the wakee has, the less idle CPU it
should scan. This can reduce wake latency and inhibit costly task migration,
especially on large systems.

We did some experiments and got some performance improvements:


From 9cb806476586d7048fcbd0f66d0101f0dbb8fd2b Mon Sep 17 00:00:00 2001
From: Chen Yu <yu.c.chen@intel.com>
Date: Tue, 7 May 2024 22:36:29 +0800
Subject: [RFC PATCH] sched/eevdf: Use customized slice to reduce wakeup latency
 and inhibit task migration

Problem 1:
The overhead of task migration is high on many-core system. The overhead
brings performance penalty due to broken cache locality/higher cache-to-cache
latency.

Problem 2:
During wakeup, the time spent on searching for an idle CPU is costly on
many-core system. Besides, access to other CPU's rq statistics brings
cace contention:

available_idle_cpu(cpu) -> idle_cpu(cpu) -> {rq->curr, rq->nr_running}

Although SIS_UTIL throttles the scan depth based on system utilization,
there is requirement to further limit the scan depth for specific workload,
especially for short duration wakee.

Now we have the interface to customize the request/slice. The smaller the
slice is, the earlier the task can be picked up, and the lower wakeup latency
the task expects. Leverage the wakee's slice to further throttle the
idle CPU scan depth - the shorter slice, the less CPUs to scan.

Test on 240 CPUs, 2 sockets system. With SNC(sub-numa-cluster) enabled,
each LLC domain has 60 CPUs. There is noticeable improvement of netperf.
(With SNC disabled, more improvements should be seen because C2C is higher)

The global slice is 3 msec(sysctl_sched_base_slice) by default on my ubuntu
22.04, and the customized slice is set to 0.1 msec for both netperf and netserver:

for i in $(seq 1 $job); do
	netperf_slice -e 100000 -4 -H 127.0.01 -t TCP_RR -c -C -l 100 &
done

case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	60-threads	 1.00 (  1.60)	 +0.35 (  1.73)
TCP_RR          	120-threads	 1.00 (  1.34)	 -0.96 (  1.24)
TCP_RR          	180-threads	 1.00 (  1.59)	+92.20 (  4.24)
TCP_RR          	240-threads	 1.00 (  9.71)	+43.11 (  2.97)

Suggested-by: Tim Chen <tim.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c     | 23 ++++++++++++++++++++---
 kernel/sched/features.h |  1 +
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index edc23f6588a3..f269ae7d6e24 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7368,6 +7368,24 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
 
 #endif /* CONFIG_SCHED_SMT */
 
+/*
+ * Scale the scan number of idle CPUs according to customized
+ * wakee's slice. The smaller the slice is, the earlier the task
+ * wants be picked up, thus the lower wakeup latency the task expects.
+ * The baseline is the global sysctl_sched_base_slice. Task slice
+ * smaller than the global one would shrink the scan number.
+ */
+static int adjust_idle_scan(struct task_struct *p, int nr)
+{
+	if (!sched_feat(SIS_FAST))
+		return nr;
+
+	if (!p->se.custom_slice || p->se.slice >= sysctl_sched_base_slice)
+		return nr;
+
+	return div_u64(nr * p->se.slice, sysctl_sched_base_slice);
+}
+
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
@@ -7384,10 +7402,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	if (sched_feat(SIS_UTIL)) {
 		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
 		if (sd_share) {
-			/* because !--nr is the condition to stop scan */
-			nr = READ_ONCE(sd_share->nr_idle_scan) + 1;
+			nr = adjust_idle_scan(p, READ_ONCE(sd_share->nr_idle_scan));
 			/* overloaded LLC is unlikely to have idle cpu/core */
-			if (nr == 1)
+			if (nr <= 0)
 				return -1;
 		}
 	}
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 143f55df890b..176324236018 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -50,6 +50,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
  * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
  */
 SCHED_FEAT(SIS_UTIL, true)
+SCHED_FEAT(SIS_FAST, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
-- 
2.25.1


