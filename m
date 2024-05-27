Return-Path: <linux-kernel+bounces-189946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844D38CF787
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127281F21627
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 02:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F932107;
	Mon, 27 May 2024 02:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9KxVYUH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9386FB0
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716778623; cv=fail; b=HflcCnnViFHfjtVZm/i1+PhiRE34l4UGCxblR+ifDmTvb1EDoh9uGPVasBNGXOk+We7nX/0M/bX2Z4H4wQG+Xss/2XYuNjRdXB8kOdfmIDuj6RNe7o1i2iqOXOJda4/JqJB/RYE81KGsri+p//+3MS1J26PxNE4SNFW/MnmSe64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716778623; c=relaxed/simple;
	bh=d3Ju3r0M1tjl+idBj69SEAl7rpLFPQ/FNjzx1vOBfT8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=jgoZpsDLeZ3fHwIUlKF5OguccqKcx2k8Q46kB+8gkFSF93doP5tF3klh0fBjgO6UrT3w+XWEmR3jcZUQuRMzcwwCnZzrA5qygHX0O9513gRWKfQroWVlz5kG6KV4YkBLuYHODFyWiHj6DP49b+1XRRMzZ0oQ9SHxVCvHHPHx99A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l9KxVYUH; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716778622; x=1748314622;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d3Ju3r0M1tjl+idBj69SEAl7rpLFPQ/FNjzx1vOBfT8=;
  b=l9KxVYUHzK/E4vqJbJooK8ZgKVqHv0wZdOq4eFPtHA2vSsFEansOPXLY
   6XtCsDeMLarzZU20xgeye1ZaFIc9gXMrBsMFBO7H7aiWD5YfFP/+SlDIM
   /nNKAxIm+6R3q+21th9gXzZS+/InBtkpDmpjAnDmMxyuttBqVgbZl7y8T
   89z5VFXYFF7pNmzaLtxmqRA1kHdk+TB5d4oOVirnEgKcl5ZAgGsmE6fuX
   zd09JZYZw1Nj2KGTsXiZZmw7KZmqYFEgqkEgiLQLfQ1S8MPHsiXj28pGg
   pcihtMxaNaO85ightejrPwTjD1D5XSelWp2G3XK8uqih1f4404x61bWvA
   g==;
X-CSE-ConnectionGUID: zGeuhJXKRoahYuauTXOQXQ==
X-CSE-MsgGUID: aq5sEZVSQpilh9sMI+vn1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13263276"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="13263276"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 19:57:01 -0700
X-CSE-ConnectionGUID: TOP3e+xISvO+AexChJ0Sgw==
X-CSE-MsgGUID: EOInulH4Qy2zpnh9x1aTXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="39459438"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 May 2024 19:57:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 19:57:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 26 May 2024 19:57:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 26 May 2024 19:57:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gr+pFbK/wVPbj7f10wjdeUcUWY343IIdwZk5KJ1pyPrWObvRkkFiwaRrZY/XQ3PzGOduJHwTQD/Tsub3Ih6Ogro1GTr9JAitDit4XKkiRQ2fFri9WJAmRrexS4oXiHRf3zt1sAKIMuTXkjcORncI4f90+coHRM13iGPXXsb7J/rrz6BMPPsxJEWXdWGQQ2O7jFxrsbwcOD9Md0iBTCWFlWDyxvJrPiLluP4JQG3CxgOcZ0Qo1sVg8hnyH2U8CcDTjc5zdCHjDTVIyUGi9jW8HELS6qgwnBW2qOL1j1cO6jLb4b2H4kK8ptJQDLF+39fSUAz3cNEuVJSf40nErTR+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfjdgCjT9r5MJ3gE/7Ox0QcWehiEblgRnE9paAK3EEc=;
 b=W9mVaou22yUQzVXjMOe9vKRyCEO1vW8LYN+GVqWp/aAHM3YkMchXmyq3f47Xdo922SNB6RS2t9Onze912SrsEVkRNdyjRxoMFqR0oc2d06PGjzPoeRs8ifkeGHT2QqBO3zkgycSSJ61tseIdhyMDOs8XOYvWJwobS03vZ5GzRWM84tQqRiao0SEPrI1uFciWJGtmwqdPTTEnpQLlzjUDzXO49Ks3Lq6cHDjeDR3tXSM2hnDHIaV0cLrxxbSY9QWS5/Ajk2fySmOzW7xvOM5QEi1SWaeJL5hdOb+gYaHdEaZYSFasoGzL1QYbgkdz98dyJgwS1588MRDpn/n/rQO2Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB6271.namprd11.prod.outlook.com (2603:10b6:8:95::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Mon, 27 May 2024 02:56:57 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 02:56:57 +0000
Date: Mon, 27 May 2024 10:56:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Suren Baghdasaryan <surenb@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
	Kees Cook <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@samsung.com>, Benno Lossin
	<benno.lossin@proton.me>, =?iso-8859-1?Q?Bj=F6rn?= Roy Baron
	<bjorn3_gh@protonmail.com>, Boqun Feng <boqun.feng@gmail.com>, "Christoph
 Lameter" <cl@linux.com>, Dennis Zhou <dennis@kernel.org>, Gary Guo
	<gary@garyguo.net>, Kent Overstreet <kent.overstreet@linux.dev>, Miguel Ojeda
	<ojeda@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Wedson Almeida
 Filho" <wedsonaf@gmail.com>, <linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linus:master] [mm]  cc92eba1c8:
 WARNING:at_kernel/rcu/tree_plugin.h:#__rcu_read_unlock
Message-ID: <202405271029.6d2f9c4c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: aea92da9-3840-427d-00a9-08dc7df8ac23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ePl5A5mWwVBecmmHZpDdn4xoJMuiFl6nYLkFRm5KaTYssy5mzPxgkTrrR89k?=
 =?us-ascii?Q?0OeHzQ9a4bovucKMSGRGcqLMFshufHSOV9awokf34bdtHUUVP4WMt3PAhP1q?=
 =?us-ascii?Q?ll2X3wkWF/JmvcFMYJXsI4vmPWwRy6gWE9Menuu2Ktoqh5Vf2fQN3yyZOsAa?=
 =?us-ascii?Q?lsQqad4bwEK8p2q1YHvrzvyMdyWWWhcFdVfyRmiaEOhSvaL8/Pd4UrZx0OXa?=
 =?us-ascii?Q?yzzw78ITcFLMayGOLLN+yt4wHKhbNGyS0O4FLzjgGWx6Cxg5lUXZ/4pDWdn7?=
 =?us-ascii?Q?Ko3wxRrn2+9SiOCvDzE7p/x0bJ2ErfnZZ6VbLtInS933VODIJjEAv2xhkldF?=
 =?us-ascii?Q?tkwiiTJZ2V0vbdrZ+aVcPUsp5FGJ/f0KpYBCr/85aefIaOMgH76gKJ2E9JDS?=
 =?us-ascii?Q?zaJ+7ehlFfh43EXbIVhy2Ckwhee/WMAECVzTp5S0VQfN3VPh0EqMWZF9RWYs?=
 =?us-ascii?Q?uO54bhix7Pr8LkWR78pA8CsjA6N21aAn7gDTh05+jqOPZd8KFtRykdHVFWGZ?=
 =?us-ascii?Q?5QUmxgThGmxJ6+2I5ulQxZk7hq9F6dmB2liUZIv3fb0ZGV9P3CVvN/Amhdrj?=
 =?us-ascii?Q?irQMRS8FNIe0j8AebCQsB/F8NldBFgfn4cGVSKBcssIxe+NRi+SC4LHKrFuo?=
 =?us-ascii?Q?2VTwWyZZVrA9DqFGLz4B8z2NyILbUCQf44lkjy/CFtmrIOCSSoyB05Hxt3Wy?=
 =?us-ascii?Q?knfQZNtl9lKP2Bixpij/AMgzKl43McEYBVSSSxwSIemoeooD1I4cRmHm5J05?=
 =?us-ascii?Q?YHZ2oZeXRy0jfzHgV4rxK8RnJmAW1DahDhwFTVlQ5vbENfn64e76l5IFiyHR?=
 =?us-ascii?Q?skyVaqlYPuZeuzuyMn+Kv0mYT4VbVMDpYvXquMbUSPYdW3/jUo/9zaKcH467?=
 =?us-ascii?Q?H5gjPuIEEQChwkQmOjPJh+qab9Eve+n+6bxLQSzbz04pI/4OVajvthOvVIVK?=
 =?us-ascii?Q?tKdtlcMXnZf27IzXXP4/UTYGhAd3b/gcUbmROIX4rULodqazVmKjTN4Ew7TG?=
 =?us-ascii?Q?WEqcQ6w8Srtk7QGGfSQ92YSRtRe8laEiqRVEVUFglB5gTFDbtOu0LoYGpUV9?=
 =?us-ascii?Q?uQSdMr1ftUqS6mM8phYhiMI29CCEiiPovWrMP2UhDBOHPtPjLL+A945rLKHQ?=
 =?us-ascii?Q?nGtXvTTaN1Lqhdh4iZKeEXIF179AEJu5raYiaJQQ0zVLBKb4SF3Y67OZfhxT?=
 =?us-ascii?Q?AfaCXVUl1GalR2K5OGfiF4MzwfUaFEfZuPlHSGCgk+Ur6pgyIRxGBvPqTOE?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B1f+wfIxuI8kihynTlnD944Ky11esXoA7ZE3osLqklr4bSEC7XjaLsQXWDNr?=
 =?us-ascii?Q?YlTrqIa6PJXuRhaElZTWaxg4DS+qVtoA80rkB0bj/WdAtHS3Vu2umDtBFxUO?=
 =?us-ascii?Q?Quxycfcm1Krj9Xt1IeWJOZLtxb2XlodbyFEP4fc3swlPjcXoZESxYsXoYhR6?=
 =?us-ascii?Q?QTPI8jfSyFoQOiJ5ebvHINTmauspyUL/+c8h6pFKqWhtlQAZjUa0g20KUZT5?=
 =?us-ascii?Q?S5Kha28rk+jTMT1ZH2e+vpZiN+SNRlUVqMb7juVVbRC4NW0cZvGd6/ShEddM?=
 =?us-ascii?Q?wK15A3j7ND+d6lQvSWOylmicYWhXMILrB+1kNwLI1unF4BNHm9eX82BWABNa?=
 =?us-ascii?Q?mEc4oYPTCx+3Z9NX1iXNct5tCNKcaTGqZrfB8fnKR/w1z999dggSdnjgVc/y?=
 =?us-ascii?Q?Cv8saXxgZce+3skCSD9fq0et0N6UpYrP1iH43qMFPIAeu4PO+g42FztnRmGl?=
 =?us-ascii?Q?kS2gENnYvYxNL9kkFkuK86iKFXYYHTAtvzzxdUHBuqerDWLdH+udw6Hii7bp?=
 =?us-ascii?Q?4hbCAfT5lETZ3Rp8+kuwGe/ICp8b/WJFkEnxUbvQ2pxs7j9GsUa4JSGzLJpw?=
 =?us-ascii?Q?BTUUNFQh90H+1+aD1Hkm2ARXiBq+Za0n2nxyCskPJTiNzFIlCsCxSmq31qoD?=
 =?us-ascii?Q?xs1UR4Cz55j4lYSsshWdTCC3y9xakOOF8mvK1k4QFecbFwwedcU96z8ltxDc?=
 =?us-ascii?Q?uLRH90eWNTZlXOQnKB5rj45PskLlMktFEUb0u5pom2ImOg6vgggDn1SpxQlA?=
 =?us-ascii?Q?F2W/wlGunqY0MiqhVzSu5daVJ0omCpYS2TAK+roOgf4vuLVtA8CPNz54nJF7?=
 =?us-ascii?Q?cOAZ6uTqBPAU0Hgr2sUdGeQm9ZQPO/qMA1OyYxXdJPuJpUGZooHwkAXiq3+6?=
 =?us-ascii?Q?4OU24Eh3PH8darQ1curqfJhHYmyrJ+XUSpD2yoP6cUADecmIEsui52lC/w1a?=
 =?us-ascii?Q?HH+7onk5vdlSXQZf8eRmBkLU4UdkVCg+WzoGG5sKhDxSOEC5DchnQUMjh1i3?=
 =?us-ascii?Q?uLa8Znqz2JozmT8C373PJdjZ/TYK4iNuA1tLIZORiaM6MzfbMkL+EjpVoior?=
 =?us-ascii?Q?AQDGHZ1Cpismszz/vRuxxsa0/MvBQUCMKZopwmM1tLTrJ95rnbxytKd+2SUd?=
 =?us-ascii?Q?Aco74sOBpapoVtnInEDJWtQcxtdL0u68PBM6kxc2xO0H7RUW6lTYlvVSc7MD?=
 =?us-ascii?Q?6AvYg3N40ivcP+8ley7WAIuspJWVU86AqWHbhDSYpksH3mhPBvEjyX7k2tJ4?=
 =?us-ascii?Q?/i6cIYhHQcjHi0IaIa6pLlQKbfoAcLiVIZi/nOE/hj+nViKf+3wCLDEu8ORi?=
 =?us-ascii?Q?mOxOAaIHKN1qkNEQDPmmeVxDWswfPLBsC1i43gyPLUbAMI/Qi30BfIAcF2+t?=
 =?us-ascii?Q?DZ5W+Kaqt1EWO9Q1Jbv3Tv2tBneDU9NeN2MvPbmrsfMppnQJoQw/5aPcJmrR?=
 =?us-ascii?Q?OtSM8WhrusH9aGgTMDYQE11QVVjmCvEbhlg1Z7CO7RQ67IejV9vleM60RH4S?=
 =?us-ascii?Q?nMVwtKw6CCWG7L67CVrndYg/+APOH0z2yusGwxulMs2zytX5Fd4BlMs0L/vF?=
 =?us-ascii?Q?Vk+HmmiNCLYpF/6IScX8hKb6syVQSmcaECKEOUoAcLFvLjd6fWlmavlGSang?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aea92da9-3840-427d-00a9-08dc7df8ac23
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 02:56:57.6241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QY3tniz+2znkd20XdwcpXxgb+6IKdxO0zP+56/xDzq6TN4W4QcrdM8ALHkQ/W9xaPuWqyuMP3BiBaSVHpgUgHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6271
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/rcu/tree_plugin.h:#__rcu_read_unlock" on:

commit: cc92eba1c88b1f74e0f044df2738f4e4b22f1e4e ("mm: fix non-compound multi-order memory accounting in __free_pages")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      6d69b6c12fce479fde7bc06f686212451688a102]
[test failed on linux-next/master 3689b0ef08b70e4e03b82ebd37730a03a672853a]

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405271029.6d2f9c4c-lkp@intel.com


[    2.504179][    C0] ------------[ cut here ]------------
[ 2.506222][ C0] WARNING: CPU: 0 PID: 1 at kernel/rcu/tree_plugin.h:431 __rcu_read_unlock (kernel/rcu/tree_plugin.h:431) 
[    2.508117][    C0] Modules linked in:
[    2.509538][    C0] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc4-00080-gcc92eba1c88b #1 1899fb0438e1349d8761ad4016a94aaeaa8a37df
[    2.512111][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 2.518194][ C0] RIP: 0010:__rcu_read_unlock (kernel/rcu/tree_plugin.h:431) 
[ 2.520109][ C0] Code: 00 00 41 83 3e 00 75 26 43 0f b6 04 3c 84 c0 75 5f 8b 03 3d 00 00 00 40 73 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc <0f> 0b eb ec e8 8d 00 00 00 eb d3 89 d9 80 e1 07 80 c1 03 38 c1 7c
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	41 83 3e 00          	cmpl   $0x0,(%r14)
   6:	75 26                	jne    0x2e
   8:	43 0f b6 04 3c       	movzbl (%r12,%r15,1),%eax
   d:	84 c0                	test   %al,%al
   f:	75 5f                	jne    0x70
  11:	8b 03                	mov    (%rbx),%eax
  13:	3d 00 00 00 40       	cmp    $0x40000000,%eax
  18:	73 10                	jae    0x2a
  1a:	5b                   	pop    %rbx
  1b:	41 5c                	pop    %r12
  1d:	41 5d                	pop    %r13
  1f:	41 5e                	pop    %r14
  21:	41 5f                	pop    %r15
  23:	5d                   	pop    %rbp
  24:	c3                   	ret
  25:	cc                   	int3
  26:	cc                   	int3
  27:	cc                   	int3
  28:	cc                   	int3
  29:	cc                   	int3
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	eb ec                	jmp    0x1a
  2e:	e8 8d 00 00 00       	call   0xc0
  33:	eb d3                	jmp    0x8
  35:	89 d9                	mov    %ebx,%ecx
  37:	80 e1 07             	and    $0x7,%cl
  3a:	80 c1 03             	add    $0x3,%cl
  3d:	38 c1                	cmp    %al,%cl
  3f:	7c                   	.byte 0x7c

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	eb ec                	jmp    0xfffffffffffffff0
   4:	e8 8d 00 00 00       	call   0x96
   9:	eb d3                	jmp    0xffffffffffffffde
   b:	89 d9                	mov    %ebx,%ecx
   d:	80 e1 07             	and    $0x7,%cl
  10:	80 c1 03             	add    $0x3,%cl
  13:	38 c1                	cmp    %al,%cl
  15:	7c                   	.byte 0x7c
[    2.524112][    C0] RSP: 0000:ffff8883ae809db8 EFLAGS: 00010286
[    2.526188][    C0] RAX: 00000000ffffffff RBX: ffff888100ac04ac RCX: dffffc0000000000
[    2.528109][    C0] RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff888100ac0040
[    2.530810][    C0] RBP: 00000000ffffffff R08: ffffffff878bc007 R09: 1ffffffff0f17800
[    2.532116][    C0] R10: dffffc0000000000 R11: fffffbfff0f17801 R12: 1ffff11020158095
[    2.534888][    C0] R13: dffffc0000000000 R14: ffffea0004037400 R15: dffffc0000000000
[    2.536108][    C0] FS:  0000000000000000(0000) GS:ffff8883ae800000(0000) knlGS:0000000000000000
[    2.539082][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.540110][    C0] CR2: ffff88843ffff000 CR3: 00000000056ce000 CR4: 00000000000406f0
[    2.542812][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    2.544109][    C0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    2.546833][    C0] Call Trace:
[    2.548013][    C0]  <IRQ>
[ 2.548772][ C0] ? __warn (kernel/panic.c:240 kernel/panic.c:694) 
[ 2.550219][ C0] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:431) 
[ 2.551982][ C0] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:431) 
[ 2.553266][ C0] ? report_bug (lib/bug.c:?) 
[ 2.555068][ C0] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 2.556133][ C0] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
[ 2.557753][ C0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 2.559780][ C0] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:431) 
[ 2.561383][ C0] page_ext_put (include/linux/rcupdate.h:339 include/linux/rcupdate.h:814 mm/page_ext.c:537) 
[ 2.562887][ C0] __free_pages (include/linux/page_ref.h:210 include/linux/mm.h:1135 mm/page_alloc.c:4669) 
[ 2.564182][ C0] ? __pfx_thread_stack_free_rcu (kernel/fork.c:346) 
[ 2.566080][ C0] ? rcu_core (kernel/rcu/tree.c:?) 
[ 2.567681][ C0] rcu_core (include/linux/rcupdate.h:339 kernel/rcu/tree.c:2198 kernel/rcu/tree.c:2471) 
[ 2.569661][ C0] __do_softirq (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:555) 
[ 2.571612][ C0] ? __irq_exit_rcu (kernel/softirq.c:613 kernel/softirq.c:635) 
[ 2.573327][ C0] __irq_exit_rcu (kernel/softirq.c:613 kernel/softirq.c:635) 
[ 2.574888][ C0] irq_exit_rcu (kernel/softirq.c:647) 
[ 2.576112][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043) 
[    2.578091][    C0]  </IRQ>
[    2.579130][    C0]  <TASK>
[ 2.580154][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 2.582143][ C0] RIP: 0010:clear_page_rep (arch/x86/lib/clear_page_64.S:20) 
[ 2.583920][ C0] Code: 1f 46 c0 fd e9 26 ff ff ff cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 b9 00 02 00 00 31 c0 <f3> 48 ab c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90
All code
========
   0:	1f                   	(bad)
   1:	46 c0 fd e9          	rex.RX sar $0xe9,%bpl
   5:	26 ff                	es (bad)
   7:	ff                   	(bad)
   8:	ff cc                	dec    %esp
   a:	cc                   	int3
   b:	cc                   	int3
   c:	cc                   	int3
   d:	cc                   	int3
   e:	cc                   	int3
   f:	cc                   	int3
  10:	cc                   	int3
  11:	cc                   	int3
  12:	cc                   	int3
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	90                   	nop
  23:	b9 00 02 00 00       	mov    $0x200,%ecx
  28:	31 c0                	xor    %eax,%eax
  2a:*	f3 48 ab             	rep stos %rax,%es:(%rdi)		<-- trapping instruction
  2d:	c3                   	ret
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	cc                   	int3
  31:	cc                   	int3
  32:	90                   	nop
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
   0:	f3 48 ab             	rep stos %rax,%es:(%rdi)
   3:	c3                   	ret
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	cc                   	int3
   8:	90                   	nop
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


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240527/202405271029.6d2f9c4c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


