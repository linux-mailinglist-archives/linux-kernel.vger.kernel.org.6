Return-Path: <linux-kernel+bounces-302977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7BA9605B6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74961282A94
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909DE19D891;
	Tue, 27 Aug 2024 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqpnUrJy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B547E13BAE4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751346; cv=fail; b=BQGCEDXocP6PLujMMr+uiexLtEib0x7bFCLNf2H8xJ3g5BHNrMwl4FIHEQ+24d4VTrWcfmhXuPiUBYF9uNJTmLyvNDXwdbVXp2SvFgbJIbv3SHouH0OMlU48sUfLYe1U3HPrKS08uXPwVZwHN/wmvFCIQbcNzEhxTmfOCdNeeYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751346; c=relaxed/simple;
	bh=gcknAl29yw9LBxArCnQwpcu/KL9Q+LZjGfwgfNeMz5Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jWmOO6AHQVn7I5vs2cIVtDMUe402/Awlp9MONohhN+RdBnsGpN62fxXsTBiv3PVVA5VB+Wb74t/+dU9hBOMbENtz7/B5Lq485ai5mFcWvlRPkrUoRJFpPTwikp5FLqbYqewv9VVqw26Zp+o9j5zDA2Yi0di6HMV9S3l5rvB0xhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqpnUrJy; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724751345; x=1756287345;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gcknAl29yw9LBxArCnQwpcu/KL9Q+LZjGfwgfNeMz5Y=;
  b=TqpnUrJydMl1Z254kJkVJichi56CS8T94EPrehoDAZyXFtgqMVGiyhlh
   HwAQdbkLXc3+WFhkFdAiuNMG70mb3aup2zxPl/exTHwsvqce0Hbgg6iVW
   0Yi3pvmWExlihH44M/oAa8Dt9YIAGCjtMIR0i92q6PhUg3tonTEEdnFuK
   twJbMyCn4IzquTXgWLRuvcd+R7WyfE+68RWa0niUZ/jc2G+FI7gXOY4XE
   0GQweRsT1XdGS18bBj4iMTOJsH1Rkv+oY8dUGlM0W5uchmIelEeTS57Nd
   QtqxyxYUyb4ZwqOq/LLtkSVFrmgvlxFx1b6FEO7/c4bPT1XzE6TlhnRNl
   g==;
X-CSE-ConnectionGUID: 9n8TNsUgS6+U1+VJtZJH3A==
X-CSE-MsgGUID: f9n393ycSwidkbaLzKM5ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23377537"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23377537"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 02:35:44 -0700
X-CSE-ConnectionGUID: /Sf13sj/SKWI74DSkqNEsA==
X-CSE-MsgGUID: 9ZqcCozNQSyo/7U+GOE80w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62501718"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 02:35:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 02:35:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 02:35:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 02:35:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 02:35:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXkwnQGY+ShSkvyrHmkvkvcFAPdP034DfIyVfClH+eg2ON3g5cc6YF2VfpF85sYr3fA54N6s2sczCxT7n6iL6K1XfrrWLpP+PcpRsqXg9hILLoOAIVZTJfq7yZoj2jSqUg6PJD/X3JUg/yhnjq3IdqBB9e6ID0XUhgq/lNKFGM9n+kFi2kIdXqYGmoeEq/2qhoqnQc5SdqXQuwgZBF28uLTuPTg2Q2Uh1uZR7vEw3L1Uy1m7N7A+Yxk0Q3kI9/rdF9Jk+nvyegkiHn3Zd+vW3As2ZxTr3cfubWagBFnf4TWk1pCrDZvpE6bib+XJd1WxOVFEp49is8/wRZUFJgw9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Did0qqDd2LaIjwFgeUzUQ9L6jkyPJPH9nyUZhp9XTsE=;
 b=q6kluoPDZv0kWaB2F/G5zlxyaiy5EoP2QtfSoQlGYJ9IysB3X/ZNrHJcU2TM2vzbNTXg1lnAR2/+tVlTD4J6gaFgdzqtHPgo8v7MKSHjFdX0LQ1sLDa/JNg3Gm+3XPR7n+xbTrUhjPWAmXwtPN/8I+7ETkrr9GnqW1pmllWitHjSNVmIcYg7FPEPSUrwmPAYqj1VXrezIzhVCBxGL5y9bVqoa2wXGG+X7/+bZfjURhEWmHbnth7G8ITvplQR+Luc3OgVbQsSDnSYWeT4Y59tct0Ti70G6pLd8JXDCtVi/wklzK87Ay9w9sp694lY7NOf3kgA3rJZ/eWKAZp2Xl9RVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH7PR11MB8453.namprd11.prod.outlook.com (2603:10b6:510:308::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Tue, 27 Aug 2024 09:35:36 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 09:35:35 +0000
Date: Tue, 27 Aug 2024 17:35:21 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Valentin Schneider <vschneid@redhat.com>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <linux-kernel@vger.kernel.org>, <kprateek.nayak@amd.com>,
	<wuyun.abel@bytedance.com>, <youssefesmat@chromium.org>,
	<tglx@linutronix.de>, <efault@gmx.de>
Subject: Re: [PATCH 12/24] sched/fair: Prepare exit/cleanup paths for
 delayed_dequeue
Message-ID: <Zs2d2aaC/zSyR94v@chenyu5-mobl2>
References: <20240727102732.960974693@infradead.org>
 <20240727105029.631948434@infradead.org>
 <xhsmh8qx0y4n0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240813215421.GA10328@noisy.programming.kicks-ass.net>
 <20240813220757.GA22760@noisy.programming.kicks-ass.net>
 <20240814055330.GA22686@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240814055330.GA22686@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH7PR11MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: 698c1662-582f-4cca-858a-08dcc67b9a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Gt9E+T9X75/r+Zfl+CuTI606UwMaeeM41N7qgKlpciVV+AGQRyV6U4iN4pQ?=
 =?us-ascii?Q?ur8iEIf1qkMZziNFucvZ5FDjfNk7tGyAkku+7WHk3LJFNUingWjqHuBAw1gy?=
 =?us-ascii?Q?xANAVYitPW+O0OP0YNTvfoCl7hPNLBr6coTSyHV7KWeDM0jejvmfOiNCwnj5?=
 =?us-ascii?Q?Q+jP/OkG/DL3kDDpg1gwjKjq/k/eGn06AWqD4MoINLZcOW5HQeNCakRxl4Sx?=
 =?us-ascii?Q?u+wo8ISoGhIC0kfgZ8HIL//MvsMW161LlkiSTI/QPt7/t7nix9O80W4H0Hm4?=
 =?us-ascii?Q?o/yKlYvVC0H1/2u5ZcAgtRMRUnzrSLArFhgC/u1gcxnbzRig46gkmw4XPYFk?=
 =?us-ascii?Q?mJU7jonA48P45MEJlywkXE4EKtgDwSUJ9DO1bP3oILBPcCP8tMT6+aw4SVNH?=
 =?us-ascii?Q?sBrHaJHJpWigHH22ZPQtL/XHLa53P23NTi4B1/EcT423wbZfcYF1QU9MgkSe?=
 =?us-ascii?Q?035Wl6GTCqnrwOyv4tBL3IxWJPVF2Ppe/t+4r1E+War03ZGDvIE0VboezkiB?=
 =?us-ascii?Q?+0ACb82DYx+RgislTM3Z5oNeHhjSOVanAue2361/Xb3f28YHcsPRpyFWinMm?=
 =?us-ascii?Q?pqlAOJfFNMROxygkfEhd+6W1f6KP9S+8CjlaHNXxxp+ZcD9ow5W9BB2CAaJL?=
 =?us-ascii?Q?M7F0eHOPrYCXz/qURtrKJw6hTfixUoBeW+PKW5v7zb6cQvlU79uzndUV7vhr?=
 =?us-ascii?Q?vU5V5ChFCC9c7SAP4f7p2DeFELSO4qFi0FEiGpFcZdoSETpXB7o8jjuVuVPu?=
 =?us-ascii?Q?orxFAFcGPHsoH4RO7fTmQ83JOT9lB9ySRu8nkEFzoJeuv36GzIc/2d0hoLtj?=
 =?us-ascii?Q?WS+YnqSodVtJdb/FY00WpRa31hKZ7QMBh79qZ+j0gmGQSQWQyXY25S9n3CAE?=
 =?us-ascii?Q?r/qDIiEBuE5pM4gLBm7xNUg4+M4IEVB/+sREgIF61ExJpIz23GVoznFIW6XZ?=
 =?us-ascii?Q?SBWpv5stJWt5F9q8dOqgt6LI7aM4q4ZtuZpPHYyAJoowybF+QiY/ewbjvYmJ?=
 =?us-ascii?Q?yOdAmAvYyOCJGYJj+c9081m+GAH2bVSE22OGA+aU6NtUkxX++e+JQKUM1dl3?=
 =?us-ascii?Q?w6+dyalalPSXY4P3z08YbZWcO7VlwrKTo912Nsu562d4k0FZ+e/5FgqfZElG?=
 =?us-ascii?Q?O+mnMypqnOGHCLfZWo72ygQ23wB9N+NgMe382hXn5BPw0aTPa//sRDQ8hFfh?=
 =?us-ascii?Q?9nD2CP9S5FI/U27VqyJIdWZZwtm3KbLjr3Gfkwe7J2B66/0HuXsWVLi/adap?=
 =?us-ascii?Q?Oit71FY9EgTnVNKuclDTz/QM75LN6XHXo0ks1JoFuk09y7Y5sKI9c/AvGiTc?=
 =?us-ascii?Q?56C5vMm2fLQ/jMFIfpsqWa8ju4+iHu3Kcz5zqi7j97RN4g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wiTo9pxka6GyANRN3/H4R6qIOo1nG7kt0z3OJyZ3fH/mgmMWAD/WPKWE1NnZ?=
 =?us-ascii?Q?fJdPFp35SU7+Ae7v8HWX6pEcSN/DSVzimZOhZwSlQPSMdfyZXq59RkCsKM4V?=
 =?us-ascii?Q?6x6wobOLDScz4AmdPs8b/uiuNcAp6pk1/D2pFz/A7KMM4Wq6pXmnMYK/GhYm?=
 =?us-ascii?Q?Yg/CjJ9okI48NyZnR4vgGzs7xwpxuwPlSpxXdl2mObHqAevNGKjgRc0wCs9X?=
 =?us-ascii?Q?kn/YfNpyb2bziBl6833fVWrWRg3qMl3VX4be8OM3Mwvz136vri3aQpjXtePx?=
 =?us-ascii?Q?tOZX4wHKtRP1qSVdQ5w8wlqGvzrJxeAqD9ve3GNDGVN3r4m+ZYvAFKmQ0Z+8?=
 =?us-ascii?Q?QlMr+5+5fYiHSA7g2XFrD82sAkn+erjo/Qn+NTgGh4Md+fyXU5tSBhoBKgN5?=
 =?us-ascii?Q?lJwYrr4qULkyo1LSoMB7Q9GA0E96WaE7EZwX0zFylHgby30P9UcrSL5+aSO9?=
 =?us-ascii?Q?ZElA7mxW7r3bMDQfleiuLAipWXmG68dUoJsU+GrwBXl6IvJpVmqvyIV9SNoV?=
 =?us-ascii?Q?JEBNLu6tS3uyXx1op6zfmzaT9/MZM9F8OGglj4Dvm0zXo7l3uUdua2sf72lH?=
 =?us-ascii?Q?/Wcebpvo4W36fNAOg1H9L9UyaEmwPs2clTMTAKNj4r8adToeaX5aNC8Ke4s1?=
 =?us-ascii?Q?2dNDRhtwKt9Oi97pchZV3fIud2yXOS840OZWWPgP+pTS/mME/6F7FoQBVdQ6?=
 =?us-ascii?Q?ylcoJ6Eo/f+jX7sgSf3M6Syma9l/vryu3GN0YyW6oxWHsJ3U3dUg0B+YjtNX?=
 =?us-ascii?Q?zRMo/WGy5N2/rN0HNV/eBpJ5Pv3pxxeDWI7eWTapoJSGcWkOutQhxARd+v9C?=
 =?us-ascii?Q?cPEAO0CrNYLMkFpMQ1tPrEUUnjtO1RT9O4LXvhx2TPsqkmduD58eoV5JMZR0?=
 =?us-ascii?Q?jc+YEWSDJHmz/yfk2XYcqr8qhnoyGuwQkpctDago+GQTq8gCHi60yYdTx22F?=
 =?us-ascii?Q?5tEOuEI8Wd1eZ50jwHzwDu2PoivAXwcRiToks5o8+RYGwhxUbvhPws0Idx/n?=
 =?us-ascii?Q?Ndx+fIJIdbfFcEUNoI9J7Q4HweTvdG/MF7YZkZDc2S10OQuA6MYgTo3b6rI9?=
 =?us-ascii?Q?dJyRIXqCo0RQbbKHiMzp2zEbslFLZV528+4YDoE80jwBVwJ672X093j31xlr?=
 =?us-ascii?Q?jAfMojhpyY8CIiX5TzS31DRbe9tjTjeBFhkFBuuh2GOBwoEHELO/UXxceRD0?=
 =?us-ascii?Q?8wYFWZGvcMc79LJnFlSH8v5haHr2/GcdHkzL5EXLbzbAQhdxmhEt9N7o7bF+?=
 =?us-ascii?Q?bUSyG89FLF0INFFtO/3/jCDNamzXTPgrJ4jYXPTpOON50oB2F1Pkysdeojx2?=
 =?us-ascii?Q?ANyiA2sRlLu/w9riNTwLx0Ka0wqLpK7j0GeX9RkPArmRMjlIgWBuW1qTXRrL?=
 =?us-ascii?Q?dfcLKPODsor9uVJhAWlU392VkR7Vp7EupHPrzqcgYz7EclfXUIrdoQtkb78+?=
 =?us-ascii?Q?dXnR74lF20FH4HEE52WzwPqM+YplMHb01jI7oZRad+h8U0bJIRMz46slt5Vu?=
 =?us-ascii?Q?foZrV9amYpYt1EqtJGdCFVok5DBjmGagTo3Z5pmzHZNTWc4qZkyILWrGOWpH?=
 =?us-ascii?Q?nLfJuPTFzOKVl0x0tDqsFPUqHOT4PS7mzRf/hnM6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 698c1662-582f-4cca-858a-08dcc67b9a9d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:35:35.8672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9Jafx8Bz+PFjoG5UEp67rZvHbLdJbfC4bZ+Ywwlmub6G7B/nvilVGVQGfbeqB0ek1k5EPjFJdLpI1VYhB7hKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8453
X-OriginatorOrg: intel.com

On 2024-08-14 at 07:53:30 +0200, Peter Zijlstra wrote:
> On Wed, Aug 14, 2024 at 12:07:57AM +0200, Peter Zijlstra wrote:
> > On Tue, Aug 13, 2024 at 11:54:21PM +0200, Peter Zijlstra wrote:
> > > On Tue, Aug 13, 2024 at 02:43:47PM +0200, Valentin Schneider wrote:
> > > > On 27/07/24 12:27, Peter Zijlstra wrote:
> > > > > @@ -12817,10 +12830,26 @@ static void attach_task_cfs_rq(struct ta
> > > > >  static void switched_from_fair(struct rq *rq, struct task_struct *p)
> > > > >  {
> > > > >       detach_task_cfs_rq(p);
> > > > > +	/*
> > > > > +	 * Since this is called after changing class, this isn't quite right.
> > > > > +	 * Specifically, this causes the task to get queued in the target class
> > > > > +	 * and experience a 'spurious' wakeup.
> > > > > +	 *
> > > > > +	 * However, since 'spurious' wakeups are harmless, this shouldn't be a
> > > > > +	 * problem.
> > > > > +	 */
> > > > > +	p->se.sched_delayed = 0;
> > > > > +	/*
> > > > > +	 * While here, also clear the vlag, it makes little sense to carry that
> > > > > +	 * over the excursion into the new class.
> > > > > +	 */
> > > > > +	p->se.vlag = 0;
> > > > 
> > > > RQ lock is held, the task can't be current if it's ->sched_delayed; is a
> > > > dequeue_task() not possible at this point?  Or just not worth it?
> > > 
> > > Hurmph, I really can't remember why I did it like this :-(
> > 
> > Obviously I remember it right after hitting send...
> > 
> > We've just done:
> > 
> > 	dequeue_task();
> > 	p->sched_class = some_other_class;
> > 	enqueue_task();
> > 
> > IOW, we're enqueued as some other class at this point. There is no way
> > we can fix it up at this point.
> 
> With just a little more sleep than last night, perhaps you're right
> after all. Yes we're on a different class, but we can *still* dequeue it
> again.

Not quite get this. If the old class is cfs, the task is in a rb-tree. And
if the new class is rt then the task is in the prio list. Just wonder
would the rt.dequeue break the data of rb-tree?

thanks,
Chenyu 

