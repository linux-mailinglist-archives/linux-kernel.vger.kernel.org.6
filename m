Return-Path: <linux-kernel+bounces-434583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AC29E68A5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA328161704
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398771DE2D0;
	Fri,  6 Dec 2024 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hnl10ykx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B572D1D5154
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733473111; cv=fail; b=YvY/IP681m1PwPqvmwGQ2rX78AirfArDA0CiYZ5M/orHj24uzuAPQ8DMw8GvEaZdFRDHsHiUm30xL49dtBMcTlljk5DEm9dTmLehi9QZqoUGzk1xR1/U4m0rHc4TK8frUn1mLKhUKRUTNEP0GDqSnKx0YlvmduyFBSeZgeLTqqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733473111; c=relaxed/simple;
	bh=Yik7e7Ugjlf3zhvsfBbgARIqzeegMvSbQFaDfb0agLo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=sUcqjAtWWA67HNfMqYlUK1W+eGpwTzw73cCYNeapOjWuLKfXzi1/lEpFHuo9yJpzAU0XKXbHniOdzfmGJYFnMzUxFSWEKj6ICqjaqMfNPCIj0r1WWBSGKMw7sxm59h2F5b+EPZRUpKkyh2HZc1yY4CITSp62ppmQYWSxRSXc72g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hnl10ykx; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733473104; x=1765009104;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Yik7e7Ugjlf3zhvsfBbgARIqzeegMvSbQFaDfb0agLo=;
  b=Hnl10ykx1S2TF6JxlNAgcW33GPFfqEv8d+x68cSvnIjt7nW3ncNbGP+D
   E8wQAWIGB7Mcf0HbHbwDP/EvMvFVJjQ+KfcAlqK7T67cHKD1QlhZU1/BC
   4VPwnQndmWVW4SqEaKamu3Q81uXnqIghUym7WwcTLN460IK1PBgUIPBSp
   c6fcnzFf7WmTjWJ/VCTl6PGj30U0NDCovWBJNHQ2nwwN2dfyGc6RtW1b2
   QAULQ+HxUrhQHmwCi/bryNKKcd/d7CIWUMigfXhnerEx6XRfIYxKx0+sO
   Ot/GOygDuW4OyEqDUTnqyxZcI/Et9ggX5R/o+AfDBSgjIPSYhxZTi1OJy
   g==;
X-CSE-ConnectionGUID: YaiTiajSS3ifemoqbwjE+A==
X-CSE-MsgGUID: tSgp/16MRcm7cDS8VRGzDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="45217370"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="45217370"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 00:18:23 -0800
X-CSE-ConnectionGUID: aH5K3tQAQYCR/2JIgBJSfQ==
X-CSE-MsgGUID: P4A8/L2QRvCQk60giCSq7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="94201388"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2024 00:18:22 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 00:18:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Dec 2024 00:18:21 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 00:18:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQmFqLYAVjOHUHXPfi6JA90yjMpO1Q4gTIX/g86S1r2sW+BZRW5jfOfn48+Of7lYcZpbMdk2XNfWgFg42if8SSNLp9WvbBJPV+WyJIO+uPKJx3WlieRBx54STplW5mDwD8YBbEdPyMat4wqQ29VVUzI9ffZSUqqCy2uHN3znRTlyIh2dd1KTNgrUy56TeSThFKXA5YMqhms4ngCQpsfrNVP9uxZH6LUNJTmmP8csQdX/xS2C6K3TG/e4BeZDuXOxbdZsrJTPQhxiRQgswQDVTSnR/55Fv/GlKmBEUwj29/GluIAfozYGelrbFF4RCgj7fQTYRh3JLxG5scu45CWmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxOPD7yeJxOGe4QxFMNLPYWqI2wnwNf+4sGJliugq5I=;
 b=l7I2ZdQsLqkJKynZljpDp3HI7ERnMX9EbZT5+8ssCJplTFinomtHb2CQ+vL2QCrjTOkpV3yk1rhfkikMM5Nnc5QKq+j0/An9wx9wSrhJc2MSPtD/uyj5HQ/Hig1z3k/TOvAJxvg+zbBxn3S62gLePFGieVSmxe/5Gs+oKmFmBqDFc80BPucUnzf5WEAvoJm5+B3oC0Qn5hkdBCVrM24wI8lwszOfsnCqW9r3hXO4ylieVYSjZv8F/grzy+ORdF6HQd6SBP9GHD38hCBciCsQW6canT6qc6t3b3TXDXo5hXN7PEwV0k5ZoyEs/Ic5EaHb1dBu/MJ3vW+PM1AemcnjCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 08:18:17 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 08:18:17 +0000
Date: Fri, 6 Dec 2024 16:18:08 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, <oliver.sang@intel.com>
Subject: [linus:master] [x86/vdso]  e93d2521b2:
 stress-ng.pagemove.page_remaps_per_sec 82.8% improvement
Message-ID: <202412061620.c67d9017-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: fe97f9c5-1a60-4f3d-7058-08dd15ce891e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?l3LVRDI53R1rPA90jjHxIBeDO4ovxYg0zdRaIKCYSPVaiLhmlUWaCB59CI?=
 =?iso-8859-1?Q?O2cOowoqefr6i2ZBWZCCo6iRMs7R78kZRh6SKaRx/LsEwAvhgB/9KEqxuU?=
 =?iso-8859-1?Q?nWcXo497jufWN4SUyt0bofRL/aBnGfaTfyh2iQW97kaViIIpx7SsWQVIwZ?=
 =?iso-8859-1?Q?ifvoQGjcCVuWk389TAFNcVxcVTAfeQkxjeDASnoMDU+MC4BFdknvYQVICH?=
 =?iso-8859-1?Q?TobKjBY8ow7hTqaYFqtAOthMHIhfRMqTHCeKplOqexyCcM4HCIgsPsGPuB?=
 =?iso-8859-1?Q?XzQCdUwFibtzZsDbhcFRoT4nKKrlPT/Px68nz4hsP6+AhM8TzrQ0C86HQk?=
 =?iso-8859-1?Q?W+THOs/EgyZd9S5XB1TEpedxODsFtNoF41zGtKwkRxUHjk4oxXV1jNgrOe?=
 =?iso-8859-1?Q?d5aKIOTV6xV5sEwcnETbSPQkfKL2MeG5DT8Qw1LnU079mW+9R6Ffc5NEwO?=
 =?iso-8859-1?Q?TjvuEiXYcZCEY6uYfUa04UeT95M+4zJz8HjuS5u/RECck0yscwtapQP1+p?=
 =?iso-8859-1?Q?jSXbMg/jW32F0egFHJ9eg6kds4CTZBMze5xeyxzZ0bGphMQdya7Ly4cymi?=
 =?iso-8859-1?Q?uRGzJNuGI7g61FrppsgR6/nZdCg2C3oQP+d9Gvqm2IMKXiG/HaNzNYV3RI?=
 =?iso-8859-1?Q?C5o/3q4GjJPPCu08CLXg2HWRfXQn/mo53rAJEuCieDUZlnCOW0PbMf1IV8?=
 =?iso-8859-1?Q?6FvRUCzHvOewl3ytcgvNhELwqDdoiKhHkWp+JuXgRqskUtYnLQB99WxSTM?=
 =?iso-8859-1?Q?JjamgLQCIQmdX0iuAW8dfc1hm7KPMHyfonCqXOZ/62toNVwLlWLjpEdl9p?=
 =?iso-8859-1?Q?BV4SOGwsY9BKLLh8Fqnzu4i2/I7cTxLmWAxCeoe2cA3by9TYMPsFOVQ+wD?=
 =?iso-8859-1?Q?r3PMi8W0uXIlE/nl5KizHeItr6DD3UoRNqn8qBaO0JWS1SXdG4pllAzRls?=
 =?iso-8859-1?Q?EPHswGEpFyzkj8/mVuK0/nenPYyRIJeg+7qbLAlqwuAiSh/5c7fyk1QTH/?=
 =?iso-8859-1?Q?YEsoIpCE6ymf+epVbYIpbzudSeprJ5AK3YW2sohiccOAq9uBe3VyMrJsRb?=
 =?iso-8859-1?Q?TvPaXfPc95aVtgRT7/l21vKhXCkpqUcg+1uDlXM0kWXnSl9qSKyo8LNqgD?=
 =?iso-8859-1?Q?TkMfaP6maXUum1JkLWuDb+oSOBqAlCYVe61kUgK8QOFRCQ+PkCi1AGeu0Z?=
 =?iso-8859-1?Q?KTtSpAFhoirly3XyKfZY/bA/q+MLblFxekL//SFucUdiCUljSYDry+BeoY?=
 =?iso-8859-1?Q?tw2BYez2OmRD9RoDk4Xcc+UdkV7yF621cfyc7QRmcdo/HCUo2ia5hlJW+S?=
 =?iso-8859-1?Q?JrcjsIiHXTXdEqb+mCja2bBGV+h+Z/w4NxYJyon1TtFujGPqRTo8Zcdadi?=
 =?iso-8859-1?Q?HtSbHlEncx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?aG30lrwzabH+G6VJ0kMCTugpnd4cms7Um2AoxHHmhdRIK4WXxzHGCGgdUr?=
 =?iso-8859-1?Q?ypDs18o4zOEhbF7yluX5ExnbMsj7908evRjP3CkxScl41tbstpobH/yh/3?=
 =?iso-8859-1?Q?etKbApoKdymZNPzJIiGDPg/uKUnmTLQ6tisRezH+uKAUoTPLF7JyWSTkUz?=
 =?iso-8859-1?Q?dsWSmIJGmeHFLw1nG3tlnphZI3O8hFO+HlPjicOGmDla2bnDURRPIgR7J4?=
 =?iso-8859-1?Q?M/p4QN/TsyRovaBW3uFmyplyxGgpGFYt7FhDQ5lvMdSnSUeJdbPkEUekJX?=
 =?iso-8859-1?Q?W4JqTZ51TPGUvcOnL6FbBPT2Y2REVj1JlljRCZAKRMg36veMWq2TKN96zv?=
 =?iso-8859-1?Q?7+sdV/hidIoGCP6w4nC5uS6fewX8CxodjzIzwIEX6sDjtntePgrV+OzaEN?=
 =?iso-8859-1?Q?8EAaE0fgqMbN9a+cjoSedFOyl4OcSyirD/sVaYwXDhfpkQ21lCCx2hr/fv?=
 =?iso-8859-1?Q?6pqmGJIbdsO5HK4Jg/2u8LLPKDcz+ovYVb37iBtQk+XdgIyn+D2DewQEDf?=
 =?iso-8859-1?Q?XcMgFZYMas0qAZEOkSWXUaiPiQ7790KizJZ8SclQblh+/47dBKumdAjvbb?=
 =?iso-8859-1?Q?qEif8VEZlaNPYvX6Z4qWaOOxxm4CBDj1MqYyPsguxxYY8F3TbCsksosklk?=
 =?iso-8859-1?Q?Lb2z8VKKecbhOFO7QJ3/R8zklovPkcSMaG9YmaAQHrtbsAv535pXw8nuHb?=
 =?iso-8859-1?Q?L9etm7kCodNd+QjwAq2dtqI+Bd0za2SAoH1lFatihAsvCIKUlBBBTTrtfQ?=
 =?iso-8859-1?Q?zjtOazQZTLTbz7xWxWey/mcvPDdYo1Xqz3EFbTv/TUUcQdtLIKc3qwILeA?=
 =?iso-8859-1?Q?j29Ezj89UZsLBs254fspxsCRq+CeHn9/bg5coKGeTLmCdqxd1wZ1G+8drE?=
 =?iso-8859-1?Q?+SlXaBbHYa6XIWal8nhK7t8+R7aDBleI3NJ6JSQzQwlAfvvd82XTnriogf?=
 =?iso-8859-1?Q?yfPhzZbYDZgdNrChXta+5LdKeI+hBZlbh3EFaH0iaNWGgsFY8dK9J5ytGe?=
 =?iso-8859-1?Q?9/sO+QzDLojOyFcDjpvVrm2pu393LdqGbLZ04fAgGio9aKzhzfTaRiOKWF?=
 =?iso-8859-1?Q?ZxbKclI2r3no6tCH4DTPy8y7nZ74B3HZltM/NqsjWYTJp9zqAM0V1UiW5K?=
 =?iso-8859-1?Q?NB1Vo4Hgs/s8LTlJyfDjN0iSLE5aTrz0JZFSxTJse15cJTbGlKIdFekFRc?=
 =?iso-8859-1?Q?x+cjQHKhDLDKi/jg4QZ2R/3lLmNVXTyXszqAQUZQsiM+HiqS1kifnynFzG?=
 =?iso-8859-1?Q?lSs9tEt1qZiRfCBxhqdUGTfPvX2LPbPPt88da/1jSkx+hXPCVTo1bZnc4F?=
 =?iso-8859-1?Q?88ineoUKgRdgFVmQap3noOWJrOwXCetvifLoCyZ+VwBnRCtjGryqP5TFAk?=
 =?iso-8859-1?Q?FYnbflYgreJ8DMLEcyIcy/YhK8UrNdlHxxSwRTcQ3JZQukpyJvQ9D9PxfO?=
 =?iso-8859-1?Q?kQE4cJ4r/NoT17hpxFQKaqP20jVdsrr1UURphxkREkpO++CVHbgKxhlEzJ?=
 =?iso-8859-1?Q?U7k3lACRZrtop6f2xjUbZu4PDQT8lRi10Pjcb5DRShZUtkgNwahPPq2Ar1?=
 =?iso-8859-1?Q?BkZNSltyNkG0GKx1H8nr7JF/FB11i9i8WFditO7f90AO8Fqc9Y9s4SdK+V?=
 =?iso-8859-1?Q?urEl0YmmoRgE60iURgyyrjt7xKYWwsYHzOIgfX6pJuFow2HNmlFi0wvw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe97f9c5-1a60-4f3d-7058-08dd15ce891e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 08:18:17.0284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwfXMGjZSsTpT6AsZuYodwo0dkQ4HKH/V7/DhHJvpZw2Gb5CU1cugw+Q5746q2CSq1Y9BE5WxhpP/ql9HUd1uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5933
X-OriginatorOrg: intel.com



Hello,

we reported
"[tip:timers/vdso] [x86/vdso]  e93d2521b2: will-it-scale.per_process_ops 65.0% improvement"
in
https://lore.kernel.org/all/202411122153.ab7a1dfe-oliver.sang@intel.com/

now the commit is in mailine, we found some other improvements. just FYI.
`

kernel test robot noticed a 82.8% improvement of stress-ng.pagemove.page_remaps_per_sec on:


commit: e93d2521b27f0439872dfa4e4b92a9be6d73496f ("x86/vdso: Split virtual clock pages into dedicated mapping")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: pagemove
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-----------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops 77.5% improvement  |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory                |
| test parameters  | cpufreq_governor=performance                                    |
|                  | mode=process                                                    |
|                  | nr_task=100%                                                    |
|                  | test=mmap1                                                      |
+------------------+-----------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241206/202412061620.c67d9017-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/pagemove/stress-ng/60s

commit: 
  05a6b8c190 ("x86/vdso: Delete vvar.h")
  e93d2521b2 ("x86/vdso: Split virtual clock pages into dedicated mapping")

05a6b8c190f00792 e93d2521b27f0439872dfa4e4b9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     12368            +2.7%      12697        vmstat.system.cs
      0.34            +0.2        0.52 ±  2%  mpstat.cpu.all.irq%
     37.31           -10.0       27.29        mpstat.cpu.all.soft%
     58.47            +9.4       67.91        mpstat.cpu.all.sys%
      1.57            +0.7        2.25 ±  3%  mpstat.cpu.all.usr%
 1.137e+08            +4.7%   1.19e+08        proc-vmstat.numa_hit
 1.134e+08            +4.7%  1.188e+08        proc-vmstat.numa_local
 3.472e+08           -11.5%  3.074e+08        proc-vmstat.pgalloc_normal
 3.465e+08           -11.5%  3.067e+08        proc-vmstat.pgfree
      0.32 ±  4%     -10.0%       0.29 ±  3%  sched_debug.cfs_rq:/.nr_running.stddev
    344.76 ±  6%     +24.3%     428.50 ±  3%  sched_debug.cfs_rq:/.util_est.avg
    224.94 ±  8%     -16.2%     188.41 ±  7%  sched_debug.cfs_rq:/.util_est.stddev
      1709 ±  4%     -10.6%       1529 ±  2%  sched_debug.cpu.curr->pid.stddev
  36028349           +83.5%   66103762        stress-ng.pagemove.ops
    600446           +83.5%    1101693        stress-ng.pagemove.ops_per_sec
    116458 ±  4%     +82.8%     212899 ±  2%  stress-ng.pagemove.page_remaps_per_sec
    331468 ±  2%      +3.6%     343508        stress-ng.time.involuntary_context_switches
     13356           +17.0%      15624        stress-ng.time.percent_of_cpu_this_job_got
      7916           +16.0%       9182        stress-ng.time.system_time
    128.03           +77.1%     226.78        stress-ng.time.user_time
      1.71           -26.3%       1.26        perf-stat.i.MPKI
 9.031e+10           +36.0%  1.228e+11        perf-stat.i.branch-instructions
      0.33            -0.0        0.30 ±  2%  perf-stat.i.branch-miss-rate%
 2.836e+08           +27.5%  3.616e+08        perf-stat.i.branch-misses
     72.76            -4.5       68.30        perf-stat.i.cache-miss-rate%
 1.095e+09            +6.8%  1.169e+09        perf-stat.i.cache-references
     12439            +2.5%      12744        perf-stat.i.context-switches
      1.35           -26.4%       0.99        perf-stat.i.cpi
 4.682e+11           +36.0%  6.366e+11        perf-stat.i.instructions
      0.74           +35.7%       1.01        perf-stat.i.ipc
      1.71           -26.4%       1.26        perf-stat.overall.MPKI
      0.31            -0.0        0.29        perf-stat.overall.branch-miss-rate%
     73.05            -4.5       68.55        perf-stat.overall.cache-miss-rate%
      1.36           -26.5%       1.00        perf-stat.overall.cpi
      0.74           +36.0%       1.00        perf-stat.overall.ipc
 8.825e+10           +36.4%  1.204e+11        perf-stat.ps.branch-instructions
 2.749e+08           +28.3%  3.528e+08        perf-stat.ps.branch-misses
 1.072e+09            +7.0%  1.147e+09        perf-stat.ps.cache-references
     12072            +3.1%      12442        perf-stat.ps.context-switches
 4.575e+11           +36.4%   6.24e+11        perf-stat.ps.instructions
 2.771e+13 ±  2%     +37.1%    3.8e+13        perf-stat.total.instructions
     11.56 ± 10%     -30.8%       7.99 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
     12.15 ± 11%     -34.6%       7.95 ± 11%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.anon_vma_clone.__split_vma.vms_gather_munmap_vmas
     11.95 ± 13%     -37.3%       7.50 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.anon_vma_clone.copy_vma.move_vma
     11.46 ± 21%     -35.7%       7.37 ± 15%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.madvise_vma_behavior.do_madvise.part
     11.45 ± 10%     -32.1%       7.77 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.move_ptes.constprop.0
     11.52 ± 10%     -35.9%       7.38 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.move_vma.__do_sys_mremap.do_syscall_64
     11.69 ±  8%     -35.8%       7.51 ± 10%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.vms_clear_ptes
     11.63 ± 10%     -38.3%       7.18 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_expand.vma_merge_new_range.copy_vma
     11.30 ±  9%     -34.2%       7.44 ± 12%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_link.copy_vma.move_vma
     12.20 ±  4%     -40.9%       7.21 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.vms_gather_munmap_vmas
     12.30 ± 11%     -32.6%       8.29 ± 18%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_prepare.commit_merge.vma_expand
     11.58 ± 13%     -34.8%       7.55 ± 14%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.39 ± 73%    +148.4%       0.97 ± 34%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
     12.30 ± 28%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
     10.15 ± 47%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
     11.51 ±  5%     -32.9%       7.72 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
     12.50 ±  4%     -37.8%       7.78 ± 12%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
     11.90 ± 11%     -36.9%       7.52 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
     11.66 ± 10%     -35.0%       7.58 ± 12%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma
     11.82 ± 12%     -36.7%       7.49 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
     11.34 ± 10%     -34.8%       7.39 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     11.83 ± 16%     -29.1%       8.38 ± 22%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_page_range.unmap_vmas.vms_clear_ptes.part
     12.08 ± 11%     -38.5%       7.43 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
     11.43 ±  8%     -35.9%       7.32 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     10.51 ±  9%     -32.4%       7.10 ± 16%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.37 ± 13%     -29.8%       0.26 ± 15%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.07 ±  8%     -63.0%       0.03 ± 22%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.70 ± 13%     -28.8%       1.21 ± 14%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     25.61 ± 25%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
     37.90 ± 49%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
      5.67 ±  8%     -36.3%       3.61 ±  9%  perf-sched.total_sch_delay.average.ms
    319.38 ± 45%     -68.2%     101.42 ± 26%  perf-sched.total_sch_delay.max.ms
     24.31 ± 11%     -34.6%      15.90 ± 11%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.anon_vma_clone.__split_vma.vms_gather_munmap_vmas
     23.03 ± 10%     -35.9%      14.76 ±  7%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.move_vma.__do_sys_mremap.do_syscall_64
     23.27 ± 10%     -38.3%      14.36 ±  8%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.vma_expand.vma_merge_new_range.copy_vma
     24.61 ± 11%     -32.6%      16.58 ± 18%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.vma_prepare.commit_merge.vma_expand
     23.02 ±  5%     -32.9%      15.44 ±  8%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
     23.81 ± 11%     -36.9%      15.03 ±  9%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
     23.32 ± 10%     -35.0%      15.16 ± 12%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma
     23.63 ± 12%     -36.7%      14.97 ±  7%  perf-sched.wait_and_delay.avg.ms.__cond_resched.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
     22.67 ± 10%     -34.8%      14.78 ±  8%  perf-sched.wait_and_delay.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     24.16 ± 11%     -38.5%      14.86 ±  8%  perf-sched.wait_and_delay.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
    980.33 ±  7%     +42.5%       1397 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.down_write.anon_vma_clone.__split_vma.vms_gather_munmap_vmas
      1214 ± 12%    +139.2%       2906 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.down_write.move_vma.__do_sys_mremap.do_syscall_64
    722.17 ±  9%    +125.2%       1626 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.down_write.vma_expand.vma_merge_new_range.copy_vma
      1642 ±  7%     -47.3%     864.67 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.down_write.vma_prepare.commit_merge.vma_expand
    406.00 ± 12%    +182.7%       1147 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      1323 ± 11%    +207.4%       4067 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
    595.17 ± 11%    +225.3%       1936 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma
      1895 ±  8%     +36.0%       2579 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
    588.83 ± 10%    +156.7%       1511 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
    918.50 ± 14%     -44.3%     511.50 ± 10%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     18409 ±  8%     -69.0%       5700 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
    183.50 ±100%    +357.1%     838.83 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      1674 ± 17%     +35.2%       2263 ±  7%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     11.56 ± 10%     -30.8%       7.99 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
     12.15 ± 11%     -34.6%       7.95 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_clone.__split_vma.vms_gather_munmap_vmas
     11.95 ± 13%     -37.3%       7.50 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_clone.copy_vma.move_vma
     11.46 ± 21%     -35.7%       7.37 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.madvise_vma_behavior.do_madvise.part
     11.45 ± 10%     -32.1%       7.77 ± 16%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.move_ptes.constprop.0
     11.52 ± 10%     -35.9%       7.38 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.move_vma.__do_sys_mremap.do_syscall_64
     11.69 ±  8%     -35.8%       7.51 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.vms_clear_ptes
     11.63 ± 10%     -38.3%       7.18 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_expand.vma_merge_new_range.copy_vma
     11.30 ±  9%     -34.2%       7.44 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_link.copy_vma.move_vma
     12.20 ±  4%     -40.9%       7.21 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.vms_gather_munmap_vmas
     12.30 ± 11%     -32.6%       8.29 ± 18%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.commit_merge.vma_expand
     11.58 ± 13%     -34.8%       7.55 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.39 ± 73%    +148.4%       0.97 ± 34%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
     12.30 ± 28%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
     10.15 ± 47%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
     11.51 ±  5%     -32.9%       7.72 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
     12.50 ±  4%     -37.8%       7.78 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
     11.90 ± 11%     -36.9%       7.52 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
     11.66 ± 10%     -35.0%       7.58 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma
     11.82 ± 12%     -36.7%       7.49 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
     11.34 ± 10%     -34.8%       7.39 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     11.83 ± 16%     -29.1%       8.38 ± 22%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_page_range.unmap_vmas.vms_clear_ptes.part
     12.08 ± 11%     -38.5%       7.43 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
     11.43 ±  8%     -35.9%       7.32 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     10.51 ±  9%     -32.5%       7.10 ± 16%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      2.31 ± 31%     +62.4%       3.76 ± 19%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     25.61 ± 25%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
     37.90 ± 49%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
     24.92           -22.5        2.39        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
     30.02           -13.7       16.35 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
     33.99           -12.3       21.68        perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     33.99           -12.3       21.68        perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread
     33.99           -12.3       21.68        perf-profile.calltrace.cycles-pp.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
     34.00           -12.3       21.70        perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     33.92           -12.3       21.63        perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn
     34.02           -12.3       21.72        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     34.02           -12.3       21.72        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     34.02           -12.3       21.72        perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     11.42 ±  2%     -11.4        0.00        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma
     11.12 ±  2%     -11.1        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
     11.03 ±  2%     -11.0        0.00        perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_store_gfp.do_vmi_align_munmap
     10.46 ±  2%     -10.5        0.00        perf-profile.calltrace.cycles-pp.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_store_gfp
     10.68            -7.7        2.99 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__put_partials.kmem_cache_free.rcu_do_batch.rcu_core
     10.62            -7.7        2.93 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__put_partials.kmem_cache_free.rcu_do_batch
     19.24            -7.6       11.61 ±  3%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
     10.89            -7.5        3.40 ±  3%  perf-profile.calltrace.cycles-pp.__put_partials.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
     16.90            -7.5        9.42 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__slab_free.kmem_cache_free.rcu_do_batch
     17.02            -7.4        9.60 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core
     40.03            -7.1       32.90        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
      7.00 ±  3%      -7.0        0.00        perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes
     40.72            -6.7       34.03        perf-profile.calltrace.cycles-pp.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.64            -6.6        0.00        perf-profile.calltrace.cycles-pp.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma
      5.80 ±  2%      -5.8        0.00        perf-profile.calltrace.cycles-pp.mas_destroy.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma
      5.32            -5.3        0.00        perf-profile.calltrace.cycles-pp.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      5.20 ±  6%      -5.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof
      5.09 ±  8%      -5.1        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.__kmem_cache_alloc_bulk
      2.33            -0.4        1.88 ±  2%  perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.commit_merge.vma_expand.vma_merge_new_range
      2.70            -0.1        2.61        perf-profile.calltrace.cycles-pp.mas_preallocate.commit_merge.vma_expand.vma_merge_new_range.copy_vma
      3.17            +0.1        3.29        perf-profile.calltrace.cycles-pp.mas_store_prealloc.commit_merge.vma_expand.vma_merge_new_range.copy_vma
      0.62            +0.2        0.87        perf-profile.calltrace.cycles-pp.mas_find.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.move_vma
      0.55            +0.3        0.84        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
      0.90            +0.4        1.33 ±  2%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      0.59            +0.5        1.06        perf-profile.calltrace.cycles-pp.mtree_load.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64
      0.85 ±  2%      +0.5        1.33 ±  3%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
      0.54            +0.5        1.04        perf-profile.calltrace.cycles-pp.mas_store_gfp.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.move_vma
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.mas_find.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.mas_prev_slot.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.move_vma
      0.67            +0.5        1.22        perf-profile.calltrace.cycles-pp.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.61            +0.6        1.16 ±  2%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.move_ptes.move_page_tables.move_vma.__do_sys_mremap
      0.65            +0.6        1.22        perf-profile.calltrace.cycles-pp.mas_find.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      0.58            +0.6        1.16        perf-profile.calltrace.cycles-pp.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.68            +0.6        1.26        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_link.copy_vma.move_vma.__do_sys_mremap
      0.51            +0.6        1.10 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.unlink_anon_vmas.free_pgtables.vms_clear_ptes
      0.53 ±  2%      +0.6        1.11        perf-profile.calltrace.cycles-pp.anon_vma_clone.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      0.00            +0.6        0.59 ±  5%  perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
      0.00            +0.6        0.60        perf-profile.calltrace.cycles-pp.mas_next_slot.mas_find.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.53 ±  2%      +0.6        1.13 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_clone.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
      0.00            +0.6        0.60        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.00            +0.6        0.60        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
      0.00            +0.6        0.61        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.00            +0.6        0.61 ±  2%  perf-profile.calltrace.cycles-pp.__call_rcu_common.mas_wr_node_store.mas_store_prealloc.commit_merge.vma_expand
      0.00            +0.6        0.63 ±  2%  perf-profile.calltrace.cycles-pp.__call_rcu_common.mas_wr_node_store.mas_store_prealloc.vma_complete.__split_vma
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp.get_old_pud.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
      0.00            +0.6        0.65        perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma
      0.00            +0.6        0.65        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_clone.copy_vma.move_vma.__do_sys_mremap
      1.10            +0.7        1.76 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma.vms_gather_munmap_vmas
      0.00            +0.7        0.66        perf-profile.calltrace.cycles-pp.__madvise
      0.00            +0.7        0.67 ±  5%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core
      1.06            +0.7        1.74 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.commit_merge.vma_expand
      0.34 ± 70%      +0.7        1.04        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes
      0.00            +0.7        0.70        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
      0.00            +0.7        0.71 ±  5%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.commit_merge.vma_expand.vma_merge_new_range
      0.00            +0.7        0.71        perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma
      1.21            +0.7        1.92        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
      0.00            +0.7        0.71        perf-profile.calltrace.cycles-pp.__call_rcu_common.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.move_vma
      0.82            +0.7        1.54        perf-profile.calltrace.cycles-pp.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64
      0.00            +0.7        0.72        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap
      0.00            +0.7        0.72        perf-profile.calltrace.cycles-pp.security_vm_enough_memory_mm.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.74        perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
      0.00            +0.8        0.75        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_link.copy_vma.move_vma.__do_sys_mremap
      0.00            +0.8        0.76        perf-profile.calltrace.cycles-pp.thp_get_unmapped_area_vmflags.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64
      0.00            +0.8        0.76 ±  4%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.anon_vma_clone.__split_vma.vms_gather_munmap_vmas
      0.72            +0.8        1.48        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
      0.76            +0.8        1.54        perf-profile.calltrace.cycles-pp.kmem_cache_free.unlink_anon_vmas.free_pgtables.vms_clear_ptes.vms_complete_munmap_vmas
      0.00            +0.8        0.79        perf-profile.calltrace.cycles-pp.mas_walk.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
      0.08 ±223%      +0.8        0.88        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.do_munmap.mremap_to
      0.00            +0.8        0.81        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.copy_vma.move_vma.__do_sys_mremap
      0.00            +0.8        0.82        perf-profile.calltrace.cycles-pp.mtree_load.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      0.93            +0.9        1.78        perf-profile.calltrace.cycles-pp.vma_link.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      1.01            +0.9        1.92        perf-profile.calltrace.cycles-pp.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.14            +1.0        2.10        perf-profile.calltrace.cycles-pp.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.handle_softirqs
      0.82            +1.0        1.80        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      1.07 ±  3%      +1.0        2.06 ±  2%  perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables
      1.16            +1.0        2.15        perf-profile.calltrace.cycles-pp.find_vma_prev.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      1.56            +1.1        2.63        perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.00            +1.1        1.08        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma
      0.97 ±  2%      +1.1        2.07        perf-profile.calltrace.cycles-pp.anon_vma_clone.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.00            +1.1        1.11 ±  3%  perf-profile.calltrace.cycles-pp.vma_prepare.commit_merge.vma_expand.vma_merge_new_range.copy_vma
      1.21 ±  3%      +1.1        2.33        perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma
      0.00            +1.2        1.17 ±  3%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma
      1.12            +1.2        2.30        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      6.85            +1.2        8.04        perf-profile.calltrace.cycles-pp.commit_merge.vma_expand.vma_merge_new_range.copy_vma.move_vma
      0.00            +1.3        1.30        perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate
      1.60            +1.3        2.92        perf-profile.calltrace.cycles-pp.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      0.00            +1.4        1.38        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.mremap
      0.54            +1.4        1.95 ±  2%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      1.22            +1.4        2.64        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_store_prealloc.vma_complete.__split_vma.vms_gather_munmap_vmas
      1.21            +1.5        2.70        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_store_prealloc.commit_merge.vma_expand.vma_merge_new_range
      7.13            +1.5        8.62        perf-profile.calltrace.cycles-pp.vma_expand.vma_merge_new_range.copy_vma.move_vma.__do_sys_mremap
      1.46            +1.5        2.97        perf-profile.calltrace.cycles-pp.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      1.52            +1.7        3.20        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
      1.08            +1.7        2.76        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma.__do_sys_mremap
      1.52            +1.7        3.21        perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      1.68 ±  2%      +1.7        3.41        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma.__do_sys_mremap
      1.25            +1.9        3.14        perf-profile.calltrace.cycles-pp.vm_area_dup.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      1.82            +2.0        3.79        perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      1.97            +2.1        4.10        perf-profile.calltrace.cycles-pp.free_pgtables.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      7.84            +2.1        9.99        perf-profile.calltrace.cycles-pp.vma_merge_new_range.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      2.55            +2.3        4.86        perf-profile.calltrace.cycles-pp.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      1.79            +2.8        4.62        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
      2.72            +3.0        5.68        perf-profile.calltrace.cycles-pp.move_ptes.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
      2.06            +3.2        5.23        perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      3.73            +4.0        7.69        perf-profile.calltrace.cycles-pp.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.06            +4.3        8.34        perf-profile.calltrace.cycles-pp.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.move_vma
      4.96            +5.2       10.16        perf-profile.calltrace.cycles-pp.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
     59.49            +6.9       66.40        perf-profile.calltrace.cycles-pp.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
     13.34            +8.0       21.34        perf-profile.calltrace.cycles-pp.copy_vma.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.39            +8.3       15.74        perf-profile.calltrace.cycles-pp.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.move_vma
      9.63            +9.7       19.37        perf-profile.calltrace.cycles-pp.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
     63.25           +10.3       73.56        perf-profile.calltrace.cycles-pp.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
     63.76           +10.8       74.57        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
     63.84           +10.9       74.71        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.mremap
     64.52           +11.5       76.04        perf-profile.calltrace.cycles-pp.mremap
     43.57           -26.2       17.36        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     43.88           -26.1       17.82        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     25.56           -22.0        3.60        perf-profile.children.cycles-pp.mas_store_gfp
     17.86           -13.1        4.78 ±  3%  perf-profile.children.cycles-pp.__put_partials
     12.35 ±  2%     -12.4        0.00        perf-profile.children.cycles-pp.kmem_cache_alloc_bulk_noprof
     33.99           -12.3       21.68        perf-profile.children.cycles-pp.run_ksoftirqd
     34.00           -12.3       21.70        perf-profile.children.cycles-pp.smpboot_thread_fn
     34.02           -12.3       21.72        perf-profile.children.cycles-pp.kthread
     34.02           -12.3       21.72        perf-profile.children.cycles-pp.ret_from_fork
     34.02           -12.3       21.72        perf-profile.children.cycles-pp.ret_from_fork_asm
     12.24 ±  2%     -12.2        0.00        perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
     38.40           -11.8       26.57        perf-profile.children.cycles-pp.kmem_cache_free
     15.00           -11.0        3.97 ±  2%  perf-profile.children.cycles-pp.mas_alloc_nodes
     39.81           -10.3       29.48        perf-profile.children.cycles-pp.rcu_do_batch
     39.82           -10.3       29.50        perf-profile.children.cycles-pp.rcu_core
     39.83           -10.3       29.52        perf-profile.children.cycles-pp.handle_softirqs
     10.96 ±  3%      -8.8        2.15 ±  2%  perf-profile.children.cycles-pp.get_partial_node
     14.39 ±  2%      -8.5        5.89        perf-profile.children.cycles-pp.___slab_alloc
      7.64            -7.6        0.00        perf-profile.children.cycles-pp.mas_wr_spanning_store
     40.06            -7.1       32.96        perf-profile.children.cycles-pp.do_vmi_align_munmap
      6.64 ±  2%      -6.3        0.33        perf-profile.children.cycles-pp.mas_destroy
      6.18            -6.2        0.00        perf-profile.children.cycles-pp.mas_spanning_rebalance
     41.58            -6.0       35.63        perf-profile.children.cycles-pp.do_vmi_munmap
      5.23 ±  2%      -5.2        0.00        perf-profile.children.cycles-pp.kmem_cache_free_bulk
     21.80            -4.9       16.91 ±  2%  perf-profile.children.cycles-pp.__slab_free
      2.97 ±  7%      -2.4        0.59 ±  4%  perf-profile.children.cycles-pp.get_any_partial
      0.55            -0.5        0.08        perf-profile.children.cycles-pp.mas_ascend
      0.45            -0.2        0.23        perf-profile.children.cycles-pp.__memcpy
      0.24 ±  2%      -0.2        0.06        perf-profile.children.cycles-pp.mas_next_node
      0.28            -0.2        0.11        perf-profile.children.cycles-pp.mas_prev_node
      0.69            -0.1        0.54        perf-profile.children.cycles-pp.mas_pop_node
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.call_rcu
      0.06 ±  9%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.ring_buffer_read_head
      0.05 ±  7%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.task_tick_fair
      0.05 ±  8%      +0.0        0.08        perf-profile.children.cycles-pp.mas_node_count_gfp
      0.08            +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__free_one_page
      0.04 ± 44%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.10 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.sched_tick
      0.09            +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.mt_free_rcu
      0.02 ±141%      +0.0        0.06        perf-profile.children.cycles-pp.mod_node_page_state
      0.14            +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.vma_merge_existing_range
      0.06            +0.1        0.11        perf-profile.children.cycles-pp.vm_stat_account
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__free_slab
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__x64_sys_mremap
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.find_vma
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.mremap_userfaultfd_complete
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.try_charge_memcg
      0.05            +0.1        0.10        perf-profile.children.cycles-pp.userfaultfd_unmap_prep
      0.14 ±  2%      +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.vma_modify
      0.05 ±  7%      +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.clockevents_program_event
      0.07 ±  7%      +0.1        0.12        perf-profile.children.cycles-pp.x64_sys_call
      0.05            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.__rb_erase_color
      0.04 ± 44%      +0.1        0.10 ±  6%  perf-profile.children.cycles-pp.ktime_get
      0.05 ±  8%      +0.1        0.11        perf-profile.children.cycles-pp.mas_nomem
      0.01 ±223%      +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.fault_in_readable
      0.01 ±223%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.15 ±  2%      +0.1        0.21        perf-profile.children.cycles-pp.vma_modify_flags_name
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.rb_next
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.anon_vma_interval_tree_remove
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.mremap_userfaultfd_prep
      0.06 ±  6%      +0.1        0.12        perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.06 ±  7%      +0.1        0.13        perf-profile.children.cycles-pp.kfree
      0.05            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.cap_mmap_addr
      0.14 ±  6%      +0.1        0.20 ±  7%  perf-profile.children.cycles-pp.generic_perform_write
      0.15 ±  6%      +0.1        0.22 ±  6%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.ksm_madvise
      0.10            +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.mas_next_setup
      0.07            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.flush_tlb_batched_pending
      0.08 ±  6%      +0.1        0.15        perf-profile.children.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.mremap@plt
      0.12 ±  3%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.16 ±  2%      +0.1        0.24 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.16 ±  4%      +0.1        0.24 ±  5%  perf-profile.children.cycles-pp.vfs_write
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.get_jiffies_update
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.__mod_memcg_state
      0.08            +0.1        0.16        perf-profile.children.cycles-pp.free_pgd_range
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.mm_get_unmapped_area_vmflags
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.14 ±  3%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.08            +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.unmap_single_vma
      0.17 ±  4%      +0.1        0.26 ±  6%  perf-profile.children.cycles-pp.ksys_write
      0.09            +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.vma_dup_policy
      0.19 ±  6%      +0.1        0.27 ±  6%  perf-profile.children.cycles-pp.writen
      0.19 ±  6%      +0.1        0.28 ±  6%  perf-profile.children.cycles-pp.record__pushfn
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.__mt_destroy
      0.30 ±  6%      +0.1        0.39 ±  7%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.30 ±  6%      +0.1        0.39 ±  6%  perf-profile.children.cycles-pp.cmd_record
      0.30 ±  6%      +0.1        0.39 ±  7%  perf-profile.children.cycles-pp.handle_internal_command
      0.30 ±  6%      +0.1        0.39 ±  7%  perf-profile.children.cycles-pp.main
      0.30 ±  6%      +0.1        0.39 ±  7%  perf-profile.children.cycles-pp.run_builtin
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.06 ±  9%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.discard_slab
      0.29 ±  6%      +0.1        0.38 ±  7%  perf-profile.children.cycles-pp.perf_mmap__push
      0.11            +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.19 ±  4%      +0.1        0.28 ±  6%  perf-profile.children.cycles-pp.write
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.__init_rwsem
      0.10            +0.1        0.19        perf-profile.children.cycles-pp.__thp_vma_allowable_orders
      0.09            +0.1        0.18        perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.09            +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.can_vma_merge_after
      0.10 ±  3%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.userfaultfd_unmap_complete
      0.10 ±  3%      +0.1        0.20        perf-profile.children.cycles-pp.mas_prev_range
      0.10 ±  3%      +0.1        0.20        perf-profile.children.cycles-pp.vma_adjust_trans_huge
      0.26 ±  2%      +0.1        0.36 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.27 ±  2%      +0.1        0.38 ±  2%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.10 ±  3%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.lru_add_drain
      0.18 ±  2%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.28 ±  2%      +0.1        0.39        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.19 ±  3%      +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.12 ±  4%      +0.1        0.24 ±  5%  perf-profile.children.cycles-pp.stress_pagemove_child
      0.10 ±  3%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.security_mmap_addr
      0.20 ±  2%      +0.1        0.31        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.15 ±  3%      +0.1        0.27 ±  2%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.65            +0.1        0.77        perf-profile.children.cycles-pp.setup_object
      0.12            +0.1        0.24        perf-profile.children.cycles-pp.can_vma_merge_right
      0.21 ±  2%      +0.1        0.33        perf-profile.children.cycles-pp.madvise_vma_behavior
      0.18 ±  3%      +0.1        0.31        perf-profile.children.cycles-pp.free_unref_page_commit
      0.12 ±  3%      +0.1        0.25        perf-profile.children.cycles-pp.remove_vma
      0.14            +0.1        0.27        perf-profile.children.cycles-pp._find_next_bit
      0.22 ±  2%      +0.1        0.36        perf-profile.children.cycles-pp.free_unref_page
      0.14            +0.1        0.28        perf-profile.children.cycles-pp.__vm_enough_memory
      0.14 ±  2%      +0.2        0.29        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.17 ±  2%      +0.2        0.32        perf-profile.children.cycles-pp.mas_next_range
      0.15            +0.2        0.30        perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.18 ±  2%      +0.2        0.35        perf-profile.children.cycles-pp.__rb_insert_augmented
      0.16 ±  2%      +0.2        0.32        perf-profile.children.cycles-pp.khugepaged_enter_vma
      0.16 ±  3%      +0.2        0.34        perf-profile.children.cycles-pp.tlb_finish_mmu
      0.18 ±  2%      +0.2        0.35        perf-profile.children.cycles-pp.alloc_new_pud
      0.18 ±  2%      +0.2        0.36        perf-profile.children.cycles-pp.init_multi_vma_prep
      0.28 ±  2%      +0.2        0.46 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.28 ±  2%      +0.2        0.46 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.18 ±  2%      +0.2        0.36        perf-profile.children.cycles-pp.static_key_count
      0.10 ± 17%      +0.2        0.29 ± 20%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.22            +0.2        0.42        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.11            +0.2        0.30        perf-profile.children.cycles-pp.mas_put_in_tree
      1.86            +0.2        2.06        perf-profile.children.cycles-pp.shuffle_freelist
      0.19 ±  2%      +0.2        0.40        perf-profile.children.cycles-pp.tlb_gather_mmu
      0.22            +0.2        0.43        perf-profile.children.cycles-pp.mas_prev_setup
      0.24 ±  5%      +0.2        0.46 ±  3%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.27 ±  2%      +0.2        0.50        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.27            +0.2        0.51        perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.32 ±  2%      +0.2        0.56        perf-profile.children.cycles-pp.__x64_sys_madvise
      0.31            +0.2        0.56        perf-profile.children.cycles-pp.do_madvise
      0.22            +0.3        0.47        perf-profile.children.cycles-pp.down_write_killable
      0.24            +0.3        0.49        perf-profile.children.cycles-pp._raw_spin_lock
      0.62            +0.3        0.89 ±  3%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.28            +0.3        0.54        perf-profile.children.cycles-pp.refill_obj_stock
      0.27            +0.3        0.56        perf-profile.children.cycles-pp.__pte_offset_map
      0.38 ±  2%      +0.3        0.69        perf-profile.children.cycles-pp.__madvise
      0.80            +0.3        1.13        perf-profile.children.cycles-pp.mas_leaf_max_gap
      2.21            +0.3        2.55        perf-profile.children.cycles-pp.allocate_slab
      0.33            +0.3        0.67        perf-profile.children.cycles-pp.get_old_pud
      0.32 ±  2%      +0.3        0.67        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.40            +0.4        0.78        perf-profile.children.cycles-pp.thp_get_unmapped_area_vmflags
      0.45            +0.4        0.84        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.38 ±  2%      +0.4        0.77        perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.42            +0.4        0.84        perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.42            +0.4        0.84        perf-profile.children.cycles-pp.mas_prev
      0.45            +0.5        0.93        perf-profile.children.cycles-pp.obj_cgroup_charge
      1.58            +0.5        2.08        perf-profile.children.cycles-pp.__call_rcu_common
      1.14            +0.5        1.66        perf-profile.children.cycles-pp.mas_prev_slot
      0.58            +0.5        1.12        perf-profile.children.cycles-pp.rcu_all_qs
      0.68            +0.6        1.25        perf-profile.children.cycles-pp.vma_to_resize
      0.53            +0.6        1.10        perf-profile.children.cycles-pp.zap_pte_range
      2.44            +0.6        3.04 ±  2%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.61            +0.6        1.21        perf-profile.children.cycles-pp.__get_unmapped_area
      0.62            +0.6        1.27        perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.74            +0.8        1.52        perf-profile.children.cycles-pp.zap_pmd_range
      1.27            +0.8        2.06        perf-profile.children.cycles-pp.mas_next_slot
      0.82            +0.8        1.63        perf-profile.children.cycles-pp.mas_update_gap
      1.08            +0.8        1.91        perf-profile.children.cycles-pp.mtree_load
      0.94            +0.9        1.81        perf-profile.children.cycles-pp.vma_link
      1.02            +0.9        1.95        perf-profile.children.cycles-pp.do_munmap
      0.70            +0.9        1.62 ±  2%  perf-profile.children.cycles-pp.vma_prepare
      1.04            +1.0        2.03        perf-profile.children.cycles-pp.mas_wr_store_type
      1.08 ±  3%      +1.0        2.08        perf-profile.children.cycles-pp.native_flush_tlb_one_user
      1.10            +1.1        2.15        perf-profile.children.cycles-pp.__cond_resched
      1.23            +1.1        2.33        perf-profile.children.cycles-pp.find_vma_prev
      1.24 ±  3%      +1.1        2.38        perf-profile.children.cycles-pp.flush_tlb_func
      1.14            +1.2        2.33        perf-profile.children.cycles-pp.unmap_page_range
      1.10 ±  3%      +1.2        2.31 ±  3%  perf-profile.children.cycles-pp.mod_objcg_state
      6.88            +1.2        8.11        perf-profile.children.cycles-pp.commit_merge
      1.05            +1.2        2.30        perf-profile.children.cycles-pp.up_write
      4.68            +1.4        6.06        perf-profile.children.cycles-pp.mas_preallocate
      7.15            +1.5        8.66        perf-profile.children.cycles-pp.vma_expand
      1.50            +1.5        3.04        perf-profile.children.cycles-pp.unmap_vmas
      2.13            +1.6        3.68        perf-profile.children.cycles-pp.mas_walk
      1.56            +1.7        3.28        perf-profile.children.cycles-pp.unlink_anon_vmas
      1.49            +1.7        3.22 ±  3%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      1.71 ±  2%      +1.8        3.47        perf-profile.children.cycles-pp.flush_tlb_mm_range
      1.42            +1.8        3.28 ±  2%  perf-profile.children.cycles-pp.down_write
      1.60            +1.9        3.45        perf-profile.children.cycles-pp.anon_vma_clone
      5.84 ±  3%      +2.0        7.84 ±  2%  perf-profile.children.cycles-pp.__irq_exit_rcu
      5.07            +2.1        7.16        perf-profile.children.cycles-pp.mas_store_prealloc
      6.12 ±  3%      +2.2        8.29 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      6.15 ±  3%      +2.2        8.32 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      2.02            +2.2        4.19        perf-profile.children.cycles-pp.free_pgtables
      7.89            +2.2       10.07        perf-profile.children.cycles-pp.vma_merge_new_range
      2.08            +2.2        4.30        perf-profile.children.cycles-pp.vma_complete
      1.94 ±  2%      +2.3        4.21 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      2.58            +2.3        4.91        perf-profile.children.cycles-pp.mremap_to
      1.88            +2.4        4.33        perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      3.44            +2.6        6.01        perf-profile.children.cycles-pp.mas_find
      2.76            +3.0        5.76        perf-profile.children.cycles-pp.move_ptes
      2.57            +3.0        5.62        perf-profile.children.cycles-pp.mas_wr_node_store
      3.80            +4.0        7.82        perf-profile.children.cycles-pp.move_page_tables
      4.11            +4.3        8.42        perf-profile.children.cycles-pp.vms_clear_ptes
      3.34            +5.1        8.46        perf-profile.children.cycles-pp.vm_area_dup
      5.00            +5.2       10.23        perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      6.20            +6.7       12.91        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
     59.58            +7.0       66.56        perf-profile.children.cycles-pp.move_vma
     13.42            +8.1       21.49        perf-profile.children.cycles-pp.copy_vma
      7.45            +8.4       15.84        perf-profile.children.cycles-pp.__split_vma
      9.70            +9.8       19.50        perf-profile.children.cycles-pp.vms_gather_munmap_vmas
     63.30           +10.4       73.65        perf-profile.children.cycles-pp.__do_sys_mremap
     64.30           +11.2       75.48        perf-profile.children.cycles-pp.do_syscall_64
     64.37           +11.2       75.60        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     64.86           +11.8       76.66        perf-profile.children.cycles-pp.mremap
     43.57           -26.2       17.36        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.50            -0.4        0.07        perf-profile.self.cycles-pp.mas_ascend
      0.39            -0.2        0.19        perf-profile.self.cycles-pp.__memcpy
      0.63            -0.2        0.46        perf-profile.self.cycles-pp.mas_pop_node
      0.98            -0.1        0.93        perf-profile.self.cycles-pp.___slab_alloc
      0.14 ±  2%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__put_partials
      0.05            +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.13 ±  3%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.get_partial_node
      0.17            +0.0        0.19        perf-profile.self.cycles-pp.rcu_do_batch
      0.07            +0.0        0.10        perf-profile.self.cycles-pp.rmqueue_bulk
      0.07 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__free_one_page
      0.04 ± 44%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.06 ±  6%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.mt_free_rcu
      0.06 ±  8%      +0.0        0.10        perf-profile.self.cycles-pp.x64_sys_call
      0.06 ±  8%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__vm_enough_memory
      0.05            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.flush_tlb_batched_pending
      0.18 ±  2%      +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.setup_object
      0.05            +0.1        0.10        perf-profile.self.cycles-pp.kfree
      0.05            +0.1        0.10        perf-profile.self.cycles-pp.khugepaged_enter_vma
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.ksm_madvise
      0.05            +0.1        0.10        perf-profile.self.cycles-pp.security_mmap_addr
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.vma_dup_policy
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.madvise_vma_behavior
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.mod_node_page_state
      0.06 ±  6%      +0.1        0.11        perf-profile.self.cycles-pp.remove_vma
      0.06            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.mm_get_unmapped_area_vmflags
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.mas_node_count_gfp
      0.06            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.mas_prev_range
      0.07            +0.1        0.13        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.fault_in_readable
      0.07            +0.1        0.13        perf-profile.self.cycles-pp.pte_offset_map_nolock
      0.06            +0.1        0.12        perf-profile.self.cycles-pp.vma_expand
      0.07 ±  5%      +0.1        0.13        perf-profile.self.cycles-pp.mas_next_range
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.mas_nomem
      0.07            +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.free_pgd_range
      0.08 ±  4%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.cap_vm_enough_memory
      0.21            +0.1        0.27        perf-profile.self.cycles-pp.mas_alloc_nodes
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.__init_rwsem
      0.07 ±  5%      +0.1        0.14 ±  2%  perf-profile.self.cycles-pp.lru_add_drain_cpu
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.08            +0.1        0.15        perf-profile.self.cycles-pp.can_vma_merge_after
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.__mt_destroy
      0.07            +0.1        0.14        perf-profile.self.cycles-pp.unmap_single_vma
      0.09            +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.userfaultfd_unmap_complete
      0.02 ± 99%      +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.obj_cgroup_uncharge_pages
      0.09 ±  4%      +0.1        0.16        perf-profile.self.cycles-pp.vma_to_resize
      0.16            +0.1        0.23 ±  2%  perf-profile.self.cycles-pp.mas_destroy
      0.08 ±  5%      +0.1        0.16        perf-profile.self.cycles-pp.__thp_vma_allowable_orders
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.get_jiffies_update
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.userfaultfd_unmap_prep
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.__rb_erase_color
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.mas_next_setup
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.vm_stat_account
      0.09            +0.1        0.17        perf-profile.self.cycles-pp.vma_adjust_trans_huge
      0.09            +0.1        0.17        perf-profile.self.cycles-pp.vma_link
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.cap_mmap_addr
      0.00            +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.11            +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.11 ±  3%      +0.1        0.20        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.10            +0.1        0.19        perf-profile.self.cycles-pp.thp_get_unmapped_area_vmflags
      0.05 ±  7%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.discard_slab
      0.11 ±  4%      +0.1        0.20 ±  5%  perf-profile.self.cycles-pp.stress_pagemove_child
      0.12 ±  6%      +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.vma_prepare
      0.11            +0.1        0.21        perf-profile.self.cycles-pp.__get_unmapped_area
      0.10            +0.1        0.20        perf-profile.self.cycles-pp.can_vma_merge_right
      0.12 ±  3%      +0.1        0.22        perf-profile.self.cycles-pp._find_next_bit
      0.13            +0.1        0.23        perf-profile.self.cycles-pp.do_syscall_64
      0.89            +0.1        1.00        perf-profile.self.cycles-pp.__call_rcu_common
      1.59            +0.1        1.70        perf-profile.self.cycles-pp.shuffle_freelist
      0.12            +0.1        0.23        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.12            +0.1        0.23        perf-profile.self.cycles-pp.static_key_count
      0.14 ±  2%      +0.1        0.26        perf-profile.self.cycles-pp.__rb_insert_augmented
      0.15            +0.1        0.27        perf-profile.self.cycles-pp.commit_merge
      0.14 ±  3%      +0.1        0.27        perf-profile.self.cycles-pp.vms_clear_ptes
      0.14 ±  2%      +0.1        0.27        perf-profile.self.cycles-pp.zap_pmd_range
      0.08 ± 17%      +0.1        0.21 ± 21%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.15            +0.1        0.28        perf-profile.self.cycles-pp.mas_prev_setup
      0.15            +0.1        0.28        perf-profile.self.cycles-pp.tlb_finish_mmu
      0.15 ±  3%      +0.1        0.29        perf-profile.self.cycles-pp.alloc_new_pud
      0.17 ±  4%      +0.1        0.31        perf-profile.self.cycles-pp.vma_complete
      0.15 ±  3%      +0.1        0.30        perf-profile.self.cycles-pp.unmap_vmas
      0.31            +0.1        0.46        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.17 ±  2%      +0.1        0.32        perf-profile.self.cycles-pp.flush_tlb_func
      0.17            +0.1        0.32        perf-profile.self.cycles-pp.init_multi_vma_prep
      0.17            +0.2        0.32        perf-profile.self.cycles-pp.free_pgtables
      0.18 ±  2%      +0.2        0.34        perf-profile.self.cycles-pp.vms_complete_munmap_vmas
      0.17 ±  2%      +0.2        0.33        perf-profile.self.cycles-pp.tlb_gather_mmu
      0.14            +0.2        0.30        perf-profile.self.cycles-pp.down_write_killable
      0.18            +0.2        0.34        perf-profile.self.cycles-pp.do_munmap
      0.10 ±  3%      +0.2        0.26        perf-profile.self.cycles-pp.mas_put_in_tree
      0.17 ±  2%      +0.2        0.34        perf-profile.self.cycles-pp.zap_pte_range
      0.19            +0.2        0.36        perf-profile.self.cycles-pp.security_vm_enough_memory_mm
      0.21 ±  2%      +0.2        0.39        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.21 ±  5%      +0.2        0.39 ±  4%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.20            +0.2        0.39        perf-profile.self.cycles-pp._raw_spin_lock
      0.21 ±  2%      +0.2        0.40        perf-profile.self.cycles-pp.vma_merge_new_range
      0.22            +0.2        0.41        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.25            +0.2        0.44        perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown
      0.20            +0.2        0.40        perf-profile.self.cycles-pp.find_vma_prev
      0.21            +0.2        0.41        perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.24            +0.2        0.44        perf-profile.self.cycles-pp.__do_sys_mremap
      0.22            +0.2        0.42 ±  2%  perf-profile.self.cycles-pp.__split_vma
      0.25            +0.2        0.46        perf-profile.self.cycles-pp.do_vmi_munmap
      0.24 ±  3%      +0.2        0.45 ±  2%  perf-profile.self.cycles-pp.unlink_anon_vmas
      0.23            +0.2        0.44        perf-profile.self.cycles-pp.mas_update_gap
      0.24            +0.2        0.46        perf-profile.self.cycles-pp.mas_prev
      0.24            +0.2        0.46        perf-profile.self.cycles-pp.__pte_offset_map
      0.26            +0.2        0.48        perf-profile.self.cycles-pp.mremap_to
      0.26            +0.2        0.50        perf-profile.self.cycles-pp.refill_obj_stock
      0.26            +0.2        0.50        perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.59            +0.3        0.84 ±  3%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      1.41            +0.3        1.67        perf-profile.self.cycles-pp.kmem_cache_free
      0.29            +0.3        0.55        perf-profile.self.cycles-pp.get_old_pud
      0.27            +0.3        0.54        perf-profile.self.cycles-pp.mas_wr_store_entry
      0.75            +0.3        1.01        perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.31 ±  3%      +0.3        0.58        perf-profile.self.cycles-pp.move_ptes
      0.34            +0.3        0.62        perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.24 ±  4%      +0.3        0.53 ±  5%  perf-profile.self.cycles-pp.anon_vma_clone
      0.33            +0.3        0.63        perf-profile.self.cycles-pp.unmap_page_range
      0.34            +0.3        0.64        perf-profile.self.cycles-pp.vms_gather_munmap_vmas
      0.33            +0.3        0.63        perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      0.35            +0.3        0.66        perf-profile.self.cycles-pp.rcu_all_qs
      0.34            +0.3        0.67        perf-profile.self.cycles-pp.obj_cgroup_charge
      0.36            +0.3        0.70        perf-profile.self.cycles-pp.copy_vma
      0.43            +0.4        0.80        perf-profile.self.cycles-pp.mas_preallocate
      0.44            +0.4        0.82        perf-profile.self.cycles-pp.move_page_tables
      0.51 ±  2%      +0.4        0.94        perf-profile.self.cycles-pp.mremap
      0.52            +0.5        0.98        perf-profile.self.cycles-pp.move_vma
      0.39 ±  2%      +0.5        0.85        perf-profile.self.cycles-pp.vm_area_dup
      0.50            +0.5        0.97        perf-profile.self.cycles-pp.mas_store_prealloc
      0.56            +0.5        1.07        perf-profile.self.cycles-pp.__cond_resched
      0.80            +0.5        1.35        perf-profile.self.cycles-pp.mas_prev_slot
      0.70            +0.6        1.26        perf-profile.self.cycles-pp.mas_store_gfp
      2.42            +0.6        3.00 ±  2%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.49 ±  2%      +0.6        1.08 ±  3%  perf-profile.self.cycles-pp.vm_area_free_rcu_cb
      0.70            +0.6        1.33        perf-profile.self.cycles-pp.mas_find
      1.01            +0.7        1.69        perf-profile.self.cycles-pp.mtree_load
      0.92            +0.8        1.70        perf-profile.self.cycles-pp.mas_next_slot
      0.96            +0.8        1.76        perf-profile.self.cycles-pp.mas_wr_store_type
      0.61 ±  2%      +0.8        1.43 ±  5%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.93            +0.9        1.79        perf-profile.self.cycles-pp.mod_objcg_state
      1.20            +1.0        2.15        perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.92            +1.0        1.88        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      1.07 ±  3%      +1.0        2.06        perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.93            +1.0        1.93        perf-profile.self.cycles-pp.up_write
      0.88            +1.1        1.96        perf-profile.self.cycles-pp.down_write
      1.04            +1.2        2.25        perf-profile.self.cycles-pp.mas_wr_node_store
      1.98            +1.2        3.21        perf-profile.self.cycles-pp.mas_walk
      3.14            +1.5        4.67        perf-profile.self.cycles-pp.__slab_free


***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/mmap1/will-it-scale

commit: 
  05a6b8c190 ("x86/vdso: Delete vvar.h")
  e93d2521b2 ("x86/vdso: Split virtual clock pages into dedicated mapping")

05a6b8c190f00792 e93d2521b27f0439872dfa4e4b9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    190921 ± 33%     -54.7%      86412 ± 98%  numa-meminfo.node1.AnonHugePages
   1646807 ±  8%     +15.4%    1899738 ±  8%  numa-meminfo.node1.Shmem
      8.91           +75.8%      15.66        vmstat.cpu.us
      6696           -13.1%       5821        vmstat.system.cs
   2432208 ±  5%     +11.3%    2708211 ±  5%  meminfo.Active
   2432208 ±  5%     +11.3%    2708211 ±  5%  meminfo.Active(anon)
   1688617 ±  7%     +16.6%    1969438 ±  6%  meminfo.Shmem
      0.42            +0.1        0.49 ±  2%  mpstat.cpu.all.irq%
     23.58           -10.2       13.34        mpstat.cpu.all.soft%
      9.00            +6.6       15.64        mpstat.cpu.all.usr%
   6712201           +77.5%   11912497        will-it-scale.104.processes
     64540           +77.5%     114542        will-it-scale.per_process_ops
   6712201           +77.5%   11912497        will-it-scale.workload
  1.51e+08           -17.1%  1.252e+08        numa-numastat.node0.local_node
  1.51e+08           -17.0%  1.253e+08        numa-numastat.node0.numa_hit
  1.58e+08           -15.7%  1.331e+08        numa-numastat.node1.local_node
 1.581e+08           -15.7%  1.332e+08        numa-numastat.node1.numa_hit
  1.51e+08           -17.0%  1.253e+08        numa-vmstat.node0.numa_hit
 1.509e+08           -17.0%  1.253e+08        numa-vmstat.node0.numa_local
    411571 ±  8%     +15.4%     474976 ±  8%  numa-vmstat.node1.nr_shmem
  1.58e+08           -15.7%  1.332e+08        numa-vmstat.node1.numa_hit
 1.579e+08           -15.7%  1.332e+08        numa-vmstat.node1.numa_local
     15460 ± 20%     -50.0%       7727 ±  8%  perf-c2c.DRAM.local
      1290 ± 21%     -59.2%     525.75 ± 10%  perf-c2c.DRAM.remote
     12120 ± 17%     -67.4%       3954 ±  5%  perf-c2c.HITM.local
    874.67 ± 22%     -68.0%     280.25 ± 11%  perf-c2c.HITM.remote
     12995 ± 17%     -67.4%       4234 ±  5%  perf-c2c.HITM.total
    608101 ±  5%     +11.3%     676847 ±  4%  proc-vmstat.nr_active_anon
   1309878 ±  2%      +5.3%    1379799 ±  2%  proc-vmstat.nr_file_pages
    422218 ±  7%     +16.6%     492139 ±  6%  proc-vmstat.nr_shmem
    608101 ±  5%     +11.3%     676847 ±  4%  proc-vmstat.nr_zone_active_anon
 3.091e+08           -16.4%  2.585e+08        proc-vmstat.numa_hit
  3.09e+08           -16.4%  2.584e+08        proc-vmstat.numa_local
 6.014e+08           -18.6%  4.898e+08        proc-vmstat.pgalloc_normal
 6.008e+08           -18.6%   4.89e+08        proc-vmstat.pgfree
      1.93           -17.1%       1.60        perf-stat.i.MPKI
 2.968e+10           +16.9%  3.469e+10        perf-stat.i.branch-instructions
      0.60            -0.1        0.51        perf-stat.i.branch-miss-rate%
 1.776e+08            -1.5%  1.751e+08        perf-stat.i.branch-misses
     60.23            -1.0       59.25        perf-stat.i.cache-miss-rate%
 2.991e+08            -9.7%  2.702e+08        perf-stat.i.cache-misses
 4.953e+08            -8.0%  4.558e+08        perf-stat.i.cache-references
      6662           -13.2%       5785        perf-stat.i.context-switches
      1.81            -8.3%       1.66        perf-stat.i.cpi
    219.96            -5.7%     207.38        perf-stat.i.cpu-migrations
    936.13           +10.6%       1035        perf-stat.i.cycles-between-cache-misses
 1.549e+11            +9.0%  1.688e+11        perf-stat.i.instructions
      0.55            +9.0%       0.60        perf-stat.i.ipc
      1.93           -17.1%       1.60        perf-stat.overall.MPKI
      0.60            -0.1        0.50        perf-stat.overall.branch-miss-rate%
     60.37            -1.1       59.28        perf-stat.overall.cache-miss-rate%
      1.81            -8.3%       1.66        perf-stat.overall.cpi
    935.38           +10.7%       1035        perf-stat.overall.cycles-between-cache-misses
      0.55            +9.0%       0.60        perf-stat.overall.ipc
   6976466           -38.8%    4269582        perf-stat.overall.path-length
 2.958e+10           +16.9%  3.457e+10        perf-stat.ps.branch-instructions
  1.77e+08            -1.5%  1.745e+08        perf-stat.ps.branch-misses
 2.981e+08            -9.6%  2.693e+08        perf-stat.ps.cache-misses
 4.937e+08            -8.0%  4.543e+08        perf-stat.ps.cache-references
      6640           -13.2%       5764        perf-stat.ps.context-switches
    219.31            -5.8%     206.61        perf-stat.ps.cpu-migrations
 1.543e+11            +9.0%  1.682e+11        perf-stat.ps.instructions
 4.683e+13            +8.6%  5.086e+13        perf-stat.total.instructions
  48168157 ±  2%     +33.7%   64403512        sched_debug.cfs_rq:/.avg_vruntime.avg
  70412389 ±  4%     +37.4%   96766502 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.max
  28097019 ± 15%     +43.7%   40387759 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.min
   7724113 ±  7%     +41.3%   10914825 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      2.39 ±  3%     +13.4%       2.71 ±  6%  sched_debug.cfs_rq:/.h_nr_running.max
      0.39 ±  3%     -17.3%       0.32 ±  7%  sched_debug.cfs_rq:/.h_nr_running.stddev
   6853324 ±  5%     -58.7%    2833845 ± 67%  sched_debug.cfs_rq:/.left_deadline.avg
   6853168 ±  5%     -58.7%    2833148 ± 67%  sched_debug.cfs_rq:/.left_vruntime.avg
    132125 ±  4%     -63.6%      48091 ± 26%  sched_debug.cfs_rq:/.load.avg
   1008002 ±  8%     -37.3%     631898 ± 30%  sched_debug.cfs_rq:/.load.max
    302594           -53.7%     139969 ± 23%  sched_debug.cfs_rq:/.load.stddev
    178.71 ±  2%     -54.0%      82.29 ±  8%  sched_debug.cfs_rq:/.load_avg.avg
    467.72 ± 11%     -34.3%     307.50 ±  3%  sched_debug.cfs_rq:/.load_avg.max
     86.56 ±  8%     -71.6%      24.58 ±  7%  sched_debug.cfs_rq:/.load_avg.min
     75.82 ± 16%     -21.3%      59.68 ±  9%  sched_debug.cfs_rq:/.load_avg.stddev
  48168196 ±  2%     +33.7%   64403528        sched_debug.cfs_rq:/.min_vruntime.avg
  70412504 ±  4%     +37.4%   96766528 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
  28097019 ± 15%     +43.7%   40387759 ±  3%  sched_debug.cfs_rq:/.min_vruntime.min
   7724117 ±  7%     +41.3%   10914825 ±  5%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1.94 ±  4%     -18.6%       1.58 ± 11%  sched_debug.cfs_rq:/.nr_running.max
      0.34 ±  3%     -43.4%       0.19 ± 14%  sched_debug.cfs_rq:/.nr_running.stddev
   6853169 ±  5%     -58.7%    2833148 ± 67%  sched_debug.cfs_rq:/.right_vruntime.avg
      1074            -8.9%     978.25        sched_debug.cfs_rq:/.runnable_avg.avg
    698.32 ±  3%     +12.6%     786.04 ±  2%  sched_debug.cfs_rq:/.util_est.avg
    246.11 ± 30%    +363.5%       1140 ± 51%  sched_debug.cpu.curr->pid.min
      1243 ±  4%     -30.4%     865.08 ±  8%  sched_debug.cpu.curr->pid.stddev
      2.39 ±  3%     +13.4%       2.71 ±  6%  sched_debug.cpu.nr_running.max
      0.39 ±  4%     -17.7%       0.32 ±  7%  sched_debug.cpu.nr_running.stddev
     10749           -11.5%       9510        sched_debug.cpu.nr_switches.avg
      7402           -13.0%       6438        sched_debug.cpu.nr_switches.min
      2864 ±  2%     -11.3%       2540 ±  4%  sched_debug.cpu.nr_switches.stddev
      0.00 ± 28%     -85.0%       0.00 ±173%  sched_debug.cpu.nr_uninterruptible.avg
      7.84 ± 13%     -60.9%       3.07 ± 83%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.allocate_slab.___slab_alloc
      7.01 ±  5%     -47.9%       3.65 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      6.85 ±  8%     -48.7%       3.51 ± 10%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      6.65 ±  9%     -44.7%       3.68 ± 11%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
      6.60 ±  4%     -43.3%       3.74 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.24 ±  3%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
      6.58 ±  8%     -43.8%       3.70 ± 10%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
      6.45 ±  6%     -45.3%       3.53 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
      6.58 ±  6%     -44.3%       3.67 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.04 ± 15%     -44.4%       0.02 ± 38%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6.61 ±  9%     -40.7%       3.92 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_page_range.unmap_vmas.vms_clear_ptes.part
      6.85 ±  7%     -48.0%       3.56 ± 10%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      6.43 ±  7%     -43.7%       3.62 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      4.17 ±139%     +91.7%       7.99 ± 98%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      2.04 ±  4%     -68.9%       0.63 ± 25%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.05 ± 70%   +6562.0%       3.06 ±133%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown].[unknown]
      0.27 ±122%    +148.9%       0.68 ± 49%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      6.55 ± 11%     -43.8%       3.68 ±  8%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      6.27 ± 19%     -58.4%       2.61 ± 44%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.70 ± 55%     -77.4%       0.16 ± 87%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.19 ± 14%     -55.7%       0.08 ±  9%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.06 ± 17%     -50.9%       0.03 ± 27%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.22 ±  7%     -41.2%       2.48 ± 12%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     11.26 ± 23%     -65.2%       3.92 ± 71%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.allocate_slab.___slab_alloc
      8.71 ± 42%     -54.1%       4.00 ± 17%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
     12.96 ± 10%     -36.6%       8.21 ± 31%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
     13.77 ± 18%     -30.2%       9.62 ± 10%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     20.68 ± 13%     -44.8%      11.42 ±  9%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
     19.13           -37.0%      12.04 ±  3%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     19.86 ± 10%     -24.7%      14.95 ± 13%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
      1.08 ± 19%     -28.5%       0.77 ± 15%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      9.12 ±  8%     -40.6%       5.42 ± 25%  perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     15.97 ±  5%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
     17.14 ±  2%     -24.1%      13.02 ± 15%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
     20.92 ±  7%     -21.1%      16.50 ± 22%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
     20.26 ± 10%     -34.8%      13.21 ±  9%  perf-sched.sch_delay.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      6.32 ± 26%     -26.9%       4.62 ± 23%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      5.28 ± 35%     -69.2%       1.63 ± 95%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     15.42 ±  7%     -32.8%      10.36 ±  7%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_page_range.unmap_vmas.vms_clear_ptes.part
     24.98 ±  8%     -41.7%      14.57 ± 14%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      4.19 ±138%     +99.4%       8.36 ± 98%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     13.79 ± 26%     -77.4%       3.11 ± 16%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1.42 ± 62%     -69.5%       0.43 ±162%  perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ± 70%   +8782.1%       4.09 ±103%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown].[unknown]
      0.94 ±119%    +120.9%       2.08 ± 44%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
     11.34 ± 23%     -46.9%       6.02 ± 30%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     16.84 ± 24%     -39.3%      10.23 ±  4%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
     10.74 ±  4%     -32.4%       7.26 ± 26%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     25.73 ± 29%     -39.4%      15.60 ±  6%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.99 ±  6%     -42.8%       1.71 ±  6%  perf-sched.total_sch_delay.average.ms
     46.68 ±  2%      +9.1%      50.92        perf-sched.total_wait_time.average.ms
     14.02 ±  5%     -47.9%       7.31 ±  5%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
     13.69 ±  8%     -48.7%       7.03 ± 10%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     13.30 ±  9%     -44.7%       7.35 ± 11%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
     13.20 ±  4%     -43.3%       7.48 ±  8%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.16 ±  8%     -43.8%       7.39 ± 10%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
     12.90 ±  6%     -45.3%       7.06 ±  9%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
     13.17 ±  6%     -44.3%       7.33 ±  8%  perf-sched.wait_and_delay.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     37.41 ±  5%     +32.0%      49.36 ±  6%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     13.69 ±  7%     -48.0%       7.12 ± 10%  perf-sched.wait_and_delay.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
     12.87 ±  7%     -43.7%       7.24 ±  8%  perf-sched.wait_and_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     13.34 ±  9%     -44.4%       7.42 ±  8%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     74.86           +21.3%      90.77        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     10.49 ±  9%     -29.2%       7.43 ± 11%  perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    551.67 ±  6%     -70.7%     161.75 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
    202.67 ±  6%     +93.2%     391.50 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
    415.33 ±  3%     +80.5%     749.75 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
    505.67 ±  5%     +62.8%     823.25 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
    268.00 ±  6%     +67.4%     448.50 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
    960.67 ±  3%     +86.4%       1790 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
    409.00 ±  5%     +87.7%     767.50 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
    382.67 ± 17%     -42.9%     218.50 ± 13%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      5734 ±  3%     -75.2%       1419 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      1010           +99.4%       2015 ±  2%  perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      1032 ±  8%     -18.7%     838.75 ±  8%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1256 ±  5%     +68.3%       2114        perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     12.33 ±  3%      +9.5%      13.50 ±  3%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     11262 ±  2%     -12.8%       9820 ±  2%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     41.37 ± 13%     -44.8%      22.84 ±  9%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
     38.26           -37.0%      24.09 ±  3%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     39.73 ± 10%     -24.7%      29.89 ± 13%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
     34.28 ±  2%     -24.1%      26.03 ± 15%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
     41.84 ±  7%     -21.1%      33.01 ± 22%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
     40.52 ± 10%     -34.8%      26.41 ±  9%  perf-sched.wait_and_delay.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     73.15 ±  8%    +139.5%     175.19 ± 20%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     49.96 ±  8%     -41.7%      29.15 ± 14%  perf-sched.wait_and_delay.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      7.84 ± 13%     -60.9%       3.07 ± 83%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.allocate_slab.___slab_alloc
      7.01 ±  5%     -47.9%       3.65 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      6.85 ±  8%     -48.7%       3.51 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      6.65 ±  9%     -44.7%       3.68 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
      6.60 ±  4%     -43.3%       3.74 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.24 ±  3%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
      6.58 ±  8%     -43.8%       3.70 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
      6.45 ±  6%     -45.3%       3.53 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
      6.58 ±  6%     -44.3%       3.67 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     37.37 ±  5%     +32.0%      49.34 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6.61 ±  9%     -40.7%       3.92 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_page_range.unmap_vmas.vms_clear_ptes.part
      6.85 ±  7%     -48.0%       3.56 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      6.43 ±  7%     -43.7%       3.62 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      1.23 ± 19%    +259.8%       4.44 ± 87%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.05 ± 70%   +6562.0%       3.06 ±133%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown].[unknown]
      6.79 ±  7%     -44.9%       3.74 ±  8%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      6.24 ± 18%     -58.3%       2.61 ± 44%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      5.24 ±  7%     -22.0%       4.08 ±  7%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     74.80           +21.3%      90.75        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6.28 ± 10%     -21.1%       4.96 ± 11%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.92 ± 36%     -49.5%       0.46 ± 66%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     11.26 ± 23%     -65.2%       3.92 ± 71%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.allocate_slab.___slab_alloc
     12.96 ± 10%     -36.6%       8.21 ± 31%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
     20.68 ± 13%     -44.8%      11.42 ±  9%  perf-sched.wait_time.max.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
     19.13           -37.0%      12.04 ±  3%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     19.86 ± 10%     -24.7%      14.95 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
      0.85 ± 28%     -45.1%       0.46 ± 57%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
     15.97 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
     17.14 ±  2%     -24.1%      13.02 ± 15%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
     20.92 ±  7%     -21.1%      16.50 ± 22%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
     20.26 ± 10%     -34.8%      13.21 ±  9%  perf-sched.wait_time.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     73.14 ±  8%    +139.5%     175.18 ± 20%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     15.42 ±  7%     -32.8%      10.36 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.unmap_page_range.unmap_vmas.vms_clear_ptes.part
     24.98 ±  8%     -41.7%      14.57 ± 14%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      2.89 ± 70%  +49242.1%       1425 ±103%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     18.64 ± 19%   +1693.9%     334.34 ±115%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.05 ± 70%   +8782.1%       4.09 ±103%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown].[unknown]
      0.85 ±138%    +126.4%       1.93 ± 60%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
     11.34 ± 23%     -46.9%       6.02 ± 30%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     16.84 ± 24%     -39.3%      10.23 ±  4%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    116.19 ±  9%     -81.3%      21.72 ± 12%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     21.62           -15.9        5.72        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      9.70            -9.7        0.00        perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff
     19.06            -8.9       10.16 ±  4%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     19.06            -8.9       10.16 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     19.06            -8.9       10.16 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     19.02            -8.9       10.14 ±  4%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     19.01            -8.9       10.13 ±  4%  perf-profile.calltrace.cycles-pp.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
     19.01            -8.9       10.13 ±  4%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     18.99            -8.9       10.11 ±  4%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn
     19.01            -8.9       10.13 ±  4%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread
     16.92            -8.6        8.28 ±  5%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      8.60            -8.6        0.00        perf-profile.calltrace.cycles-pp.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      8.31            -8.3        0.00        perf-profile.calltrace.cycles-pp.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region.do_mmap
      7.32 ±  3%      -7.3        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      7.21 ±  4%      -7.2        0.00        perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_store_gfp.do_vmi_align_munmap
      8.49            -7.1        1.40 ±  4%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
     10.87            -7.1        3.78        perf-profile.calltrace.cycles-pp.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      6.63 ±  4%      -6.6        0.00        perf-profile.calltrace.cycles-pp.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_store_gfp
      7.70 ±  3%      -6.6        1.14        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      6.13            -6.1        0.00        perf-profile.calltrace.cycles-pp.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      5.77            -5.8        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core
      5.65            -5.6        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__slab_free.kmem_cache_free.rcu_do_batch
     38.61            -4.3       34.35        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     39.23            -3.8       35.38        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     39.77            -3.4       36.36        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     39.82            -3.4       36.44        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     40.41            -2.8       37.60        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     41.54            -2.0       39.57        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     22.26            -1.1       21.20        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.09 ±  2%      -0.8        1.29        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.mmap_region.do_mmap.vm_mmap_pgoff
      2.73 ±  2%      -0.4        2.32        perf-profile.calltrace.cycles-pp.mas_preallocate.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      0.98 ±  4%      -0.3        0.71 ±  3%  perf-profile.calltrace.cycles-pp.rcu_cblist_dequeue.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      0.83            -0.1        0.78        perf-profile.calltrace.cycles-pp.mas_prev_slot.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.81            -0.1        0.76        perf-profile.calltrace.cycles-pp.mas_next_slot.mas_find.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.59            +0.1        0.68 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.handle_softirqs
      0.99            +0.1        1.10        perf-profile.calltrace.cycles-pp.mas_find.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.85            +0.1        0.96 ±  3%  perf-profile.calltrace.cycles-pp.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      0.97            +0.3        1.22        perf-profile.calltrace.cycles-pp.mas_rev_awalk.mas_empty_area_rev.vm_unmapped_area.arch_get_unmapped_area_topdown.thp_get_unmapped_area_vmflags
      0.53            +0.4        0.93        perf-profile.calltrace.cycles-pp.security_vm_enough_memory_mm.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      1.26            +0.5        1.75        perf-profile.calltrace.cycles-pp.mas_empty_area_rev.vm_unmapped_area.arch_get_unmapped_area_topdown.thp_get_unmapped_area_vmflags.__get_unmapped_area
      0.70            +0.5        1.20        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_preallocate.mmap_region.do_mmap.vm_mmap_pgoff
      0.72            +0.5        1.24        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__mmap
      0.71            +0.5        1.24        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__munmap
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.mas_update_gap.mas_wr_node_store.mas_store_prealloc.mmap_region.do_mmap
      0.00            +0.5        0.54 ±  3%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region
      0.74            +0.6        1.30        perf-profile.calltrace.cycles-pp.mas_find.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.__mmap
      0.00            +0.6        0.56 ±  2%  perf-profile.calltrace.cycles-pp.mas_pop_node.mas_wr_node_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.__call_rcu_common.mas_wr_node_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.__call_rcu_common.mas_wr_node_store.mas_store_prealloc.mmap_region.do_mmap
      0.00            +0.6        0.59        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_store_gfp.do_vmi_align_munmap
      0.00            +0.6        0.61        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
      0.00            +0.6        0.62 ±  3%  perf-profile.calltrace.cycles-pp.__call_rcu_common.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.00            +0.6        0.62 ±  3%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__mmap
      0.00            +0.6        0.62 ±  3%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__mmap
      0.00            +0.6        0.63        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.mmap_region.do_mmap.vm_mmap_pgoff
      0.00            +0.6        0.63        perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      0.00            +0.6        0.64 ±  2%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__munmap
      0.00            +0.6        0.64 ±  2%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__munmap
      0.00            +0.6        0.64 ±  2%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.zap_pmd_range.unmap_page_range
      0.00            +0.6        0.64 ±  2%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.zap_pmd_range
      0.00            +0.7        0.65 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.__mmap
      0.00            +0.7        0.65        perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.00            +0.7        0.65 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__mmap
      0.00            +0.7        0.67 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__munmap
      0.00            +0.7        0.67 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.__munmap
      0.00            +0.7        0.67 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.zap_pmd_range.unmap_page_range.unmap_vmas
      0.00            +0.7        0.68 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes
      1.19 ±  5%      +0.7        1.88 ±  2%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt
      1.20 ±  5%      +0.7        1.90 ±  2%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.8        0.76        perf-profile.calltrace.cycles-pp.mas_store_gfp.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      5.35 ±  2%      +0.8        6.12 ±  5%  perf-profile.calltrace.cycles-pp.__put_partials.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
      0.00            +0.8        0.77        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      1.11            +0.8        1.94        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
      0.00            +0.8        0.83        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
     25.58            +0.9       26.48        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.00            +0.9        0.94        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      1.54            +1.0        2.57        perf-profile.calltrace.cycles-pp.free_pud_range.free_p4d_range.free_pgd_range.free_pgtables.vms_clear_ptes
      1.53            +1.1        2.60        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff
      2.16            +1.1        3.25        perf-profile.calltrace.cycles-pp.vm_unmapped_area.arch_get_unmapped_area_topdown.thp_get_unmapped_area_vmflags.__get_unmapped_area.do_mmap
      0.00            +1.1        1.12        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region.do_mmap
      3.28            +1.1        4.43        perf-profile.calltrace.cycles-pp.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      1.59            +1.2        2.76        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__mmap
      1.74            +1.2        2.92        perf-profile.calltrace.cycles-pp.free_p4d_range.free_pgd_range.free_pgtables.vms_clear_ptes.vms_complete_munmap_vmas
      1.60            +1.2        2.83        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__munmap
     26.48            +1.2       27.72        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.80            +1.3        3.10        perf-profile.calltrace.cycles-pp.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      2.48            +1.3        3.79        perf-profile.calltrace.cycles-pp.arch_get_unmapped_area_topdown.thp_get_unmapped_area_vmflags.__get_unmapped_area.do_mmap.vm_mmap_pgoff
      1.92            +1.3        3.26        perf-profile.calltrace.cycles-pp.free_pgd_range.free_pgtables.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      0.73            +1.4        2.13        perf-profile.calltrace.cycles-pp.rcu_all_qs.__cond_resched.zap_pmd_range.unmap_page_range.unmap_vmas
      2.67            +1.5        4.19        perf-profile.calltrace.cycles-pp.thp_get_unmapped_area_vmflags.__get_unmapped_area.do_mmap.vm_mmap_pgoff.do_syscall_64
      1.97            +1.5        3.51        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__mmap
      1.96            +1.6        3.54        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__munmap
      2.82            +1.7        4.47        perf-profile.calltrace.cycles-pp.__get_unmapped_area.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.17            +1.7        3.84        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff
      2.45            +1.7        4.19        perf-profile.calltrace.cycles-pp.free_pgtables.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     27.23            +1.8       29.02        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      2.50            +1.9        4.44        perf-profile.calltrace.cycles-pp.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
     46.69            +2.2       48.87        perf-profile.calltrace.cycles-pp.__munmap
      3.10            +2.4        5.47        perf-profile.calltrace.cycles-pp.__cond_resched.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes
      3.23 ±  4%      +2.6        5.78 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page_commit.free_unref_page.__put_partials
      3.33 ±  4%      +2.6        5.90 ±  5%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_commit.free_unref_page.__put_partials.kmem_cache_free
      3.36 ±  4%      +2.6        5.94 ±  5%  perf-profile.calltrace.cycles-pp.free_unref_page_commit.free_unref_page.__put_partials.kmem_cache_free.rcu_do_batch
      3.38 ±  4%      +2.6        5.96 ±  5%  perf-profile.calltrace.cycles-pp.free_unref_page.__put_partials.kmem_cache_free.rcu_do_batch.rcu_core
     28.34            +2.7       30.99        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      0.00            +3.0        3.04        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff
      0.00            +3.1        3.07        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      7.61            +6.5       14.14        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
      8.34            +6.6       14.90        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
     33.51            +6.7       40.18        perf-profile.calltrace.cycles-pp.__mmap
      8.83            +6.9       15.70        perf-profile.calltrace.cycles-pp.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     11.89            +9.1       20.95        perf-profile.calltrace.cycles-pp.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
     13.14           +10.1       23.19        perf-profile.calltrace.cycles-pp.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     22.16           -15.5        6.65        perf-profile.children.cycles-pp.mas_store_gfp
     24.61           -15.1        9.48 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     24.26           -15.0        9.26 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     26.96           -12.0       14.99        perf-profile.children.cycles-pp.kmem_cache_free
      9.71            -9.7        0.00        perf-profile.children.cycles-pp.mas_wr_bnode
     26.88            -9.6       17.27        perf-profile.children.cycles-pp.handle_softirqs
     26.86            -9.6       17.25        perf-profile.children.cycles-pp.rcu_core
     26.84            -9.6       17.24        perf-profile.children.cycles-pp.rcu_do_batch
      8.95 ±  3%      -9.0        0.00        perf-profile.children.cycles-pp.kmem_cache_alloc_bulk_noprof
     19.06            -8.9       10.16 ±  4%  perf-profile.children.cycles-pp.kthread
     19.06            -8.9       10.16 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
     19.06            -8.9       10.16 ±  4%  perf-profile.children.cycles-pp.ret_from_fork_asm
     19.02            -8.9       10.14 ±  4%  perf-profile.children.cycles-pp.smpboot_thread_fn
     19.01            -8.9       10.13 ±  4%  perf-profile.children.cycles-pp.run_ksoftirqd
      8.62            -8.6        0.00        perf-profile.children.cycles-pp.mas_wr_spanning_store
     12.22            -8.6        3.61        perf-profile.children.cycles-pp.__slab_free
      8.59 ±  3%      -8.6        0.00        perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      8.38            -8.4        0.00        perf-profile.children.cycles-pp.mas_split
      9.82 ±  3%      -7.4        2.46        perf-profile.children.cycles-pp.mas_alloc_nodes
     10.89            -7.1        3.80        perf-profile.children.cycles-pp.mas_store_prealloc
      6.17            -6.2        0.00        perf-profile.children.cycles-pp.mas_spanning_rebalance
      8.21 ±  4%      -6.2        2.04        perf-profile.children.cycles-pp.___slab_alloc
      5.73 ±  5%      -5.6        0.12 ±  8%  perf-profile.children.cycles-pp.get_partial_node
      5.61 ±  2%      -5.3        0.29 ±  2%  perf-profile.children.cycles-pp.mas_destroy
     38.62            -4.2       34.38        perf-profile.children.cycles-pp.do_vmi_align_munmap
     39.25            -3.8       35.42        perf-profile.children.cycles-pp.do_vmi_munmap
     39.80            -3.4       36.41        perf-profile.children.cycles-pp.__vm_munmap
     39.83            -3.4       36.46        perf-profile.children.cycles-pp.__x64_sys_munmap
     10.37            -1.2        9.16 ±  2%  perf-profile.children.cycles-pp.__put_partials
      1.16 ±  5%      -1.0        0.12 ±  5%  perf-profile.children.cycles-pp.get_any_partial
     67.75            -1.0       66.73        perf-profile.children.cycles-pp.do_syscall_64
     22.34            -1.0       21.36        perf-profile.children.cycles-pp.mmap_region
      0.96            -0.8        0.14 ±  3%  perf-profile.children.cycles-pp.memcpy_orig
      7.87            -0.7        7.14 ±  3%  perf-profile.children.cycles-pp.__irq_exit_rcu
      8.26            -0.7        7.56 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      8.29            -0.7        7.60 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.43            -0.4        1.00 ±  2%  perf-profile.children.cycles-pp.mas_pop_node
      2.75 ±  2%      -0.4        2.35        perf-profile.children.cycles-pp.mas_preallocate
      0.38            -0.1        0.31 ±  2%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.10 ±  4%      -0.1        0.04 ± 57%  perf-profile.children.cycles-pp.__memcpy
      0.35            -0.1        0.29 ±  2%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.31            -0.1        0.26        perf-profile.children.cycles-pp.get_page_from_freelist
      1.41            -0.1        1.36        perf-profile.children.cycles-pp.allocate_slab
      0.07 ±  7%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.write
      0.19 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__free_one_page
      0.42            -0.0        0.40        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.15            -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.11            -0.0        0.09        perf-profile.children.cycles-pp.rmqueue_bulk
      0.36            -0.0        0.35        perf-profile.children.cycles-pp.security_mmap_file
      0.21            -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.mt_free_rcu
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.__get_random_u32_below
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.mas_next_setup
      0.14 ±  3%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.sched_tick
      0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.can_vma_merge_right
      0.10            +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.ima_file_mmap
      0.37            +0.0        0.38        perf-profile.children.cycles-pp.setup_object
      0.25            +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.28            +0.0        0.31 ±  2%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.34            +0.0        0.37 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.05            +0.0        0.08        perf-profile.children.cycles-pp.__kmalloc_node_noprof
      0.05            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.alloc_slab_obj_exts
      0.39            +0.0        0.42 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.39            +0.0        0.43        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.05            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.mas_nomem
      0.03 ± 70%      +0.0        0.07        perf-profile.children.cycles-pp.vma_link_file
      0.09 ±  5%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.khugepaged_enter_vma
      0.07 ±  7%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.arch_vma_name
      0.03 ± 70%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.userfaultfd_unmap_prep
      0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__mt_destroy
      0.06 ±  7%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.memset_orig
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.unlink_file_vma_batch_add
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.unlink_file_vma_batch_final
      0.13 ±  3%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.testcase
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__init_rwsem
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.mlock_drain_local
      0.12 ±  4%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__x64_sys_mmap
      0.02 ±141%      +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.cap_mmap_addr
      0.13 ±  3%      +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.may_expand_vm
      0.11 ±  4%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.vm_get_page_prot
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.get_mmap_base
      0.10            +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.unmap_single_vma
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.11            +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.mas_prev_setup
      0.08 ±  6%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.security_mmap_addr
      0.11 ±  4%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.strlen
      0.08 ±  6%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.up_read
      0.08 ±  5%      +0.1        0.15 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.10            +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.x64_sys_call
      0.59            +0.1        0.65        perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.12 ±  3%      +0.1        0.19        perf-profile.children.cycles-pp.lru_add_drain
      0.08            +0.1        0.15 ±  2%  perf-profile.children.cycles-pp.strnlen
      0.08 ±  6%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.refill_obj_stock
      0.09            +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.mas_node_count_gfp
      0.13 ±  3%      +0.1        0.21        perf-profile.children.cycles-pp.userfaultfd_unmap_complete
      0.12 ±  4%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.downgrade_write
      0.12            +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.21            +0.1        0.30        perf-profile.children.cycles-pp.mas_data_end
      0.17 ±  2%      +0.1        0.26        perf-profile.children.cycles-pp.mas_next_range
      0.18 ±  2%      +0.1        0.29        perf-profile.children.cycles-pp.sized_strscpy
      0.15 ±  3%      +0.1        0.26        perf-profile.children.cycles-pp.static_key_count
      0.14            +0.1        0.25        perf-profile.children.cycles-pp.tlb_gather_mmu
      0.23            +0.1        0.35        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.14 ±  3%      +0.1        0.26        perf-profile.children.cycles-pp.tlb_finish_mmu
      0.19 ±  2%      +0.1        0.32        perf-profile.children.cycles-pp.vma_merge_new_range
      0.13 ±  3%      +0.1        0.25 ±  2%  perf-profile.children.cycles-pp.kfree
      0.16 ±  2%      +0.1        0.29        perf-profile.children.cycles-pp.__vm_enough_memory
      0.17 ±  2%      +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.17            +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.vma_set_page_prot
      0.19 ±  2%      +0.1        0.34        perf-profile.children.cycles-pp.remove_vma
      0.18            +0.2        0.34 ±  3%  perf-profile.children.cycles-pp.mas_prev_range
      0.21            +0.2        0.37        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.27            +0.2        0.46        perf-profile.children.cycles-pp.mas_prev
      0.27            +0.2        0.48 ±  2%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.27            +0.2        0.48        perf-profile.children.cycles-pp.up_write
      0.35 ±  2%      +0.2        0.58        perf-profile.children.cycles-pp.down_write_killable
      0.32            +0.2        0.55 ±  3%  perf-profile.children.cycles-pp.obj_cgroup_charge
      1.53            +0.2        1.77        perf-profile.children.cycles-pp.__call_rcu_common
      1.22            +0.2        1.46        perf-profile.children.cycles-pp.mas_prev_slot
      0.98            +0.3        1.24        perf-profile.children.cycles-pp.mas_rev_awalk
      0.00            +0.3        0.26 ±  2%  perf-profile.children.cycles-pp.mas_put_in_tree
      0.35 ±  2%      +0.3        0.62        perf-profile.children.cycles-pp.mod_objcg_state
      0.38 ±  3%      +0.3        0.68        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.33 ±  2%      +0.3        0.68 ±  3%  perf-profile.children.cycles-pp.down_write
      1.34            +0.4        1.70        perf-profile.children.cycles-pp.mas_next_slot
      0.57            +0.4        1.00        perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.63            +0.5        1.09        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.71            +0.5        1.21        perf-profile.children.cycles-pp.perf_iterate_sb
      1.28            +0.5        1.80        perf-profile.children.cycles-pp.mas_empty_area_rev
      0.50            +0.5        1.04        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      1.23            +0.7        1.90        perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      0.91            +0.7        1.58        perf-profile.children.cycles-pp.mas_walk
      0.54            +0.7        1.22        perf-profile.children.cycles-pp.mas_wr_store_type
     70.02            +0.7       70.72        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.12            +0.8        1.96        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
     25.60            +0.9       26.50        perf-profile.children.cycles-pp.do_mmap
      0.06 ±  8%      +0.9        0.97        perf-profile.children.cycles-pp.mas_update_gap
      1.55            +1.0        2.58        perf-profile.children.cycles-pp.free_pud_range
      2.17            +1.1        3.26        perf-profile.children.cycles-pp.vm_unmapped_area
      1.59            +1.1        2.72        perf-profile.children.cycles-pp.perf_event_mmap_event
      1.17            +1.1        2.32        perf-profile.children.cycles-pp.rcu_all_qs
      3.32            +1.2        4.49        perf-profile.children.cycles-pp.vms_gather_munmap_vmas
      1.75            +1.2        2.95        perf-profile.children.cycles-pp.free_p4d_range
     26.49            +1.3       27.75        perf-profile.children.cycles-pp.vm_mmap_pgoff
      1.81            +1.3        3.12        perf-profile.children.cycles-pp.perf_event_mmap
      2.50            +1.3        3.82        perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      1.93            +1.4        3.28        perf-profile.children.cycles-pp.free_pgd_range
      7.33 ±  4%      +1.5        8.79 ±  3%  perf-profile.children.cycles-pp.free_unref_page
      7.21 ±  4%      +1.5        8.67 ±  3%  perf-profile.children.cycles-pp.free_pcppages_bulk
      7.27 ±  4%      +1.5        8.74 ±  3%  perf-profile.children.cycles-pp.free_unref_page_commit
      1.81            +1.5        3.31        perf-profile.children.cycles-pp.entry_SYSCALL_64
      2.67            +1.5        4.20        perf-profile.children.cycles-pp.thp_get_unmapped_area_vmflags
      2.93            +1.5        4.47        perf-profile.children.cycles-pp.mas_find
      2.84            +1.7        4.52        perf-profile.children.cycles-pp.__get_unmapped_area
      2.52            +1.8        4.30        perf-profile.children.cycles-pp.free_pgtables
      2.51            +2.0        4.46        perf-profile.children.cycles-pp.vm_area_alloc
     46.82            +2.3       49.10        perf-profile.children.cycles-pp.__munmap
      3.43            +2.5        5.97        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      3.96            +3.1        7.11        perf-profile.children.cycles-pp.syscall_return_via_sysret
      2.76            +3.2        5.98        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      4.36            +3.3        7.69        perf-profile.children.cycles-pp.__cond_resched
      0.00            +6.2        6.20        perf-profile.children.cycles-pp.mas_wr_node_store
      7.83            +6.2       14.04        perf-profile.children.cycles-pp.zap_pmd_range
      8.37            +6.6       14.94        perf-profile.children.cycles-pp.unmap_page_range
     33.66            +6.8       40.42        perf-profile.children.cycles-pp.__mmap
      8.85            +6.9       15.74        perf-profile.children.cycles-pp.unmap_vmas
     11.92            +9.1       20.99        perf-profile.children.cycles-pp.vms_clear_ptes
     13.24           +10.1       23.36        perf-profile.children.cycles-pp.vms_complete_munmap_vmas
     24.26           -15.0        9.26 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      2.04            -1.0        1.09        perf-profile.self.cycles-pp.kmem_cache_free
      3.60            -0.8        2.84 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.84            -0.7        0.12 ±  3%  perf-profile.self.cycles-pp.memcpy_orig
      1.31            -0.4        0.90        perf-profile.self.cycles-pp.mas_pop_node
      0.83            -0.4        0.42        perf-profile.self.cycles-pp.___slab_alloc
      0.35            -0.1        0.22 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.24            -0.0        0.20        perf-profile.self.cycles-pp.security_mmap_file
      0.25            -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.mas_destroy
      0.18            -0.0        0.15        perf-profile.self.cycles-pp.__free_one_page
      0.42            -0.0        0.39        perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.13            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.get_any_partial
      0.67            -0.0        0.65        perf-profile.self.cycles-pp.shuffle_freelist
      0.21            -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.mt_free_rcu
      0.06            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.khugepaged_enter_vma
      0.07 ±  7%      +0.0        0.09        perf-profile.self.cycles-pp.testcase
      0.07 ±  6%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.ima_file_mmap
      0.14            +0.0        0.18        perf-profile.self.cycles-pp.setup_object
      0.05 ±  8%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.ksys_mmap_pgoff
      0.12 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.may_expand_vm
      0.09            +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.strlen
      0.10            +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.vm_get_page_prot
      0.10 ±  4%      +0.0        0.15        perf-profile.self.cycles-pp.lru_add_drain_cpu
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__x64_sys_munmap
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.can_vma_merge_right
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.free_unref_page_commit
      0.30            +0.1        0.36        perf-profile.self.cycles-pp.mas_alloc_nodes
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__mt_destroy
      0.06            +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.mas_node_count_gfp
      0.09            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.mas_prev_setup
      0.09            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.x64_sys_call
      0.07 ±  7%      +0.1        0.12        perf-profile.self.cycles-pp.strnlen
      0.08 ±  5%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.unmap_single_vma
      0.07            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.cap_mmap_addr
      0.10 ±  4%      +0.1        0.16        perf-profile.self.cycles-pp.userfaultfd_unmap_complete
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.security_mmap_addr
      0.10 ±  4%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.unlink_anon_vmas
      0.07 ±  7%      +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.up_read
      0.54            +0.1        0.60        perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.arch_vma_name
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.userfaultfd_unmap_prep
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.vma_link_file
      0.08 ±  6%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.refill_obj_stock
      0.10 ±  4%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.vma_set_page_prot
      0.11            +0.1        0.18        perf-profile.self.cycles-pp.static_key_count
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.__vm_enough_memory
      0.11 ±  4%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.downgrade_write
      0.11 ±  4%      +0.1        0.18        perf-profile.self.cycles-pp.mas_next_range
      0.18            +0.1        0.26        perf-profile.self.cycles-pp.mas_data_end
      0.10 ±  4%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.remove_vma
      0.19 ±  2%      +0.1        0.28        perf-profile.self.cycles-pp.mas_wr_store_entry
      0.11 ±  4%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.__get_unmapped_area
      0.12            +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.vms_clear_ptes
      0.15 ±  3%      +0.1        0.24        perf-profile.self.cycles-pp.sized_strscpy
      0.13 ±  3%      +0.1        0.22        perf-profile.self.cycles-pp.vma_merge_new_range
      0.11 ±  4%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.kfree
      0.12 ±  4%      +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.tlb_finish_mmu
      0.12            +0.1        0.22        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.13            +0.1        0.23        perf-profile.self.cycles-pp.tlb_gather_mmu
      0.14 ±  3%      +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.do_vmi_munmap
      0.13            +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.mas_prev_range
      0.19 ±  2%      +0.1        0.30        perf-profile.self.cycles-pp.down_write_killable
      0.16            +0.1        0.28        perf-profile.self.cycles-pp.cap_vm_enough_memory
      0.84            +0.1        0.96        perf-profile.self.cycles-pp.mas_rev_awalk
      0.36            +0.1        0.49 ±  3%  perf-profile.self.cycles-pp.vm_area_free_rcu_cb
      0.17 ±  2%      +0.1        0.31        perf-profile.self.cycles-pp.free_pgd_range
      0.18 ±  2%      +0.1        0.32        perf-profile.self.cycles-pp.mas_prev
      0.19            +0.1        0.34        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.19 ±  2%      +0.2        0.34        perf-profile.self.cycles-pp.free_p4d_range
      0.22            +0.2        0.38 ±  2%  perf-profile.self.cycles-pp.unmap_vmas
      0.94            +0.2        1.10        perf-profile.self.cycles-pp.__call_rcu_common
      0.20 ±  2%      +0.2        0.37        perf-profile.self.cycles-pp.perf_event_mmap
      0.22 ±  3%      +0.2        0.39 ±  2%  perf-profile.self.cycles-pp.vm_mmap_pgoff
      0.14 ±  3%      +0.2        0.31 ±  2%  perf-profile.self.cycles-pp.thp_get_unmapped_area_vmflags
      0.28            +0.2        0.45        perf-profile.self.cycles-pp.__mmap
      0.29            +0.2        0.47        perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown
      0.25            +0.2        0.43 ±  2%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.24            +0.2        0.43 ±  2%  perf-profile.self.cycles-pp.perf_event_mmap_output
      0.37            +0.2        0.56        perf-profile.self.cycles-pp.vm_unmapped_area
      0.24            +0.2        0.42        perf-profile.self.cycles-pp.free_pgtables
      0.24            +0.2        0.43        perf-profile.self.cycles-pp.up_write
      0.25 ±  3%      +0.2        0.44 ±  2%  perf-profile.self.cycles-pp.mas_preallocate
      0.23            +0.2        0.43        perf-profile.self.cycles-pp.mas_empty_area_rev
      0.25 ±  3%      +0.2        0.45        perf-profile.self.cycles-pp.vm_area_alloc
      0.26            +0.2        0.46        perf-profile.self.cycles-pp.security_vm_enough_memory_mm
      0.38            +0.2        0.59        perf-profile.self.cycles-pp.do_mmap
      0.32            +0.2        0.54        perf-profile.self.cycles-pp.vms_complete_munmap_vmas
      0.26            +0.2        0.48        perf-profile.self.cycles-pp.mas_store_prealloc
      0.29            +0.2        0.52        perf-profile.self.cycles-pp.__munmap
      0.27            +0.2        0.50        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.2        0.23 ±  3%  perf-profile.self.cycles-pp.mas_put_in_tree
      0.19 ±  2%      +0.2        0.43 ±  5%  perf-profile.self.cycles-pp.down_write
      0.35            +0.2        0.58 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.30 ±  2%      +0.2        0.54        perf-profile.self.cycles-pp.mod_objcg_state
      0.29 ±  2%      +0.2        0.54        perf-profile.self.cycles-pp.__vm_munmap
      0.05 ±  8%      +0.3        0.31        perf-profile.self.cycles-pp.mas_update_gap
      0.41 ±  3%      +0.3        0.67        perf-profile.self.cycles-pp.perf_iterate_sb
      0.43            +0.3        0.70        perf-profile.self.cycles-pp.unmap_page_range
      0.41            +0.3        0.69        perf-profile.self.cycles-pp.perf_event_mmap_event
      0.36 ±  2%      +0.3        0.68        perf-profile.self.cycles-pp.do_syscall_64
      0.39 ±  2%      +0.3        0.71        perf-profile.self.cycles-pp.vms_gather_munmap_vmas
      0.40            +0.3        0.74        perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.57            +0.4        1.00        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.64            +0.5        1.13        perf-profile.self.cycles-pp.mas_store_gfp
      0.82            +0.5        1.34        perf-profile.self.cycles-pp.mas_prev_slot
      0.81            +0.6        1.37        perf-profile.self.cycles-pp.mas_find
      0.79            +0.6        1.38        perf-profile.self.cycles-pp.mas_walk
      0.50            +0.6        1.10        perf-profile.self.cycles-pp.mas_wr_store_type
      0.87            +0.6        1.50        perf-profile.self.cycles-pp.mas_next_slot
      0.91            +0.7        1.62        perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.85            +0.7        1.56        perf-profile.self.cycles-pp.rcu_all_qs
      1.19            +0.9        2.10        perf-profile.self.cycles-pp.mmap_region
      1.43            +0.9        2.36        perf-profile.self.cycles-pp.free_pud_range
      1.59            +1.3        2.92        perf-profile.self.cycles-pp.entry_SYSCALL_64
      2.31            +1.7        4.05        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.95            +2.1        5.01        perf-profile.self.cycles-pp.__cond_resched
      0.00            +2.5        2.46        perf-profile.self.cycles-pp.mas_wr_node_store
      3.39            +2.5        5.92        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      3.96            +3.1        7.10        perf-profile.self.cycles-pp.syscall_return_via_sysret
      4.02            +3.2        7.24        perf-profile.self.cycles-pp.zap_pmd_range



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


