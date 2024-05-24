Return-Path: <linux-kernel+bounces-188236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B5A8CDF8D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B130282CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 02:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC6D28DC1;
	Fri, 24 May 2024 02:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/We6DwQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289DE21103
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716518500; cv=fail; b=OJGaafvJLmmxGr1o4pV/GKzhrdyBXRuiLX3qilt8pBXWDMQHh06QWTCOHRbTmFrnIotmmdgaPV9aciZhbdZdWJM1ZOgW24pQecEvZGnBoNE4p/SJqIwXzwFSJ/hWQlZH5oRv8cI+J21l08TtPMAHvwZkufetTGTn+fxlrZRl7tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716518500; c=relaxed/simple;
	bh=Hv9DT1vponEG9plaMDBhkRfSM2yPEry89O15Mti2kzY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LJtk7mOilRUnFBDLOYJCjhxR+aE2GIP42q9uVa9yYuIdZIAsW+ly8ZsNXXB4GvUgE/ySRoIx8s55PkjNIU24CuxO1vRdpxHvZ/P25nIeQnzdhJZV4qVX6wG1LD+kD/lfum7eq+VjrD9Q2YqkGpCM/oH1YdCr/p9ffw3Bwpr1B4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/We6DwQ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716518498; x=1748054498;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Hv9DT1vponEG9plaMDBhkRfSM2yPEry89O15Mti2kzY=;
  b=f/We6DwQvbmFSxoLlL7+YeaQUvnUGyLohpiZdqmi9hOWOAVEwpZsZc8F
   x99MpZEqF18tsd8Q+fTMQ2SEsgs/CYMLu7sxlseOexRbsq8GKNC/g/rUd
   0t0QG1Nd/Qz4iJhBytAoUr5hnZmL0B0GJvhEbcmDNC3QZsFfudqPrzK7B
   ozK7JhrGZlANuD/ns6ZbYsMeXfYKpe6GWgSJBHxsmOoA9TH/6xRSTg+5W
   cHXb6CbxakJoc3eoQmN0bNlGvXpjf6uMHkZnhLXOft6xsdbFlbybIqIUk
   a+CQ7l+jGE0OJYf/q2EHDaeqCDJjQv8WFhExP4RaLPYhK6EXXjUcEEYFl
   w==;
X-CSE-ConnectionGUID: B5rETuKuTvi1pabgLsz4qw==
X-CSE-MsgGUID: /fCkJ1PHR0u+SUDcT+Lspg==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="35394632"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="35394632"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 19:41:37 -0700
X-CSE-ConnectionGUID: DDtP/fIyTvqoYEWtsMJVYg==
X-CSE-MsgGUID: qVYxJkQhT+GYn/ysduIipQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="38286159"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 19:41:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 19:41:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 19:41:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 19:41:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/yPmpeFqwEtuzQDbq55a9bAk0MY2JA/5ih3csB5pZL6gbPDd8kAmieBrE+Oe5V50xO96RtTqqvi0743Zlc2b9aBX1jqYPuujaPi/XIYYlTObVjUqv6kYD/AZxxEjRZxILqdSAyG6dQNUQMuIowVuWR74cBf1UznPaZgp/iRN+u8sPd7dmnuzEbmfKmGQK9ap6b3faPk/jmECkdmLwY3LoMaWuYjFwxciT9RmGXjE4DQnur7YYHz367d7LF1/gxi21/dCq6fMM7vWM622cM8QwZlBBG3Wm9pJl34fmUhDzZK7KXmLt3G9RF2Z4BdfZIBQ/d7xUzzc418rvBmfBA3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfM+zfIDAvPHHy7v+iA9jJp9p+ZwzGQLusgHeStk1fM=;
 b=ciUw35yRfE0yUo6YdIXgp5Y6k2P6QLAq3/PDe2WClqB78mZRkN7Tp9i7XAFBHeLR2vqjQuOAFKwYMx+m7GVKGHvGpsQcLcsYO1Rr8PPqpUrMPfxUDrw7ZEPR9WvOk9ertNiRND3klpXSRLjWYd6F85PHjtRCSnbvhjwoKzUNhAbJ8k6a9usCzyF/9gwksUo9WGhrkhJZTwBILik3BYscXqLqFs5GPbIoUlxyAjFNhgxf6jkquR0k+j85C8D1cYTWgOCV1uI4Hf250yo4dX2KwBsGzHyoYDBRp4Xbc80O6CTxrg4ymyevHvezzwVNDTzX3u3oLmWwroTkLYr7z3CBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by SN7PR11MB7489.namprd11.prod.outlook.com (2603:10b6:806:342::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 02:41:33 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 02:41:33 +0000
Date: Fri, 24 May 2024 10:33:15 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Barry Song <21cnbao@gmail.com>
CC: <lkp@intel.com>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<oe-kbuild-all@lists.linux.dev>, <v-songbaohua@oppo.com>
Subject: Re: include/linux/huge_mm.h:285:undefined reference to `mthp_stats'
Message-ID: <Zk/8a9zllk2NPtjN@yujie-X299>
References: <202405231728.tCAogiSI-lkp@intel.com>
 <20240523210045.40444-1-21cnbao@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240523210045.40444-1-21cnbao@gmail.com>
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|SN7PR11MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: bfec1c66-da7e-44ac-e612-08dc7b9b0666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D1HnzvWj5C4G4YxlK4gGsue86CIosUyx99MvmbNpbXOxwkW84Sd+0WKklFs6?=
 =?us-ascii?Q?ydS6kjl+zzdWtHHrUJx3FD1zkzt/tQxYVyHRgKOWgpzfTn4iGG69sKJ/s7y+?=
 =?us-ascii?Q?TkKhkxp4+QueTzETnuExPpp7KZUahdz0UeAAyWGZjP1XaFQH2O1r5J4hStFm?=
 =?us-ascii?Q?GiamErKG45j7nkjsVSt93DjmO7N89Y2GxzshGHvMlN5Ohg220piZMRcYrQvZ?=
 =?us-ascii?Q?ypNd4Dliw6YU9OXiuKe4vJ4Q6mdSXj3UMe1jtKErAWQdiqyH8kG1wVPHQBZQ?=
 =?us-ascii?Q?kKt/5b8pn2QGg9X6AVv4dBeppfQg7Jf2vS32pG+WWKCVLFzHjjHA59+wxsVJ?=
 =?us-ascii?Q?bWOkYM9rYOv296Z2zgN3jd3+Tzlw6vpZrHDSnwHEusoNg3Q+TCHMk7a68DjJ?=
 =?us-ascii?Q?ftFID+m+ZSwqv3dzS8gcIUnIf1rkaap6/3sB73PFNI11g7Mctw2Dr8afu3lZ?=
 =?us-ascii?Q?57wJANSrf3EacsuX7QY1CSstPZ+kjdZprnLf4kCU0X+3YkI+zUjLYoKJW68y?=
 =?us-ascii?Q?cZRJoLIwH9DsAQnuycbmV/IUgucJYJ7PSU1K7juW1QVJ0VNlXoE/KSRFQw1q?=
 =?us-ascii?Q?+tDfflwhOJX3COFNt+1rkO8jbR9Rx6+sGS4es1thJwUrozbzowfSL2McAtMz?=
 =?us-ascii?Q?n9J9CHBhEClFjKjCiPjEuL+DtcfnnNKPRvxpJCV39t0RJRSiHkRYYMWi4E9B?=
 =?us-ascii?Q?VjmoGYjtHAE1FlEtccQLFkq+7SeInHzqjxEkQxgdeBQdk0GlsUvUFJiXT5zc?=
 =?us-ascii?Q?nrE6eGjwt1wFepEpGDb3w6Ia2mp2fMo7tz0f1drmZdUxU5sVmoq3mbSRMDTF?=
 =?us-ascii?Q?VsMAUJ4tpaMX8K539+pqPnW9rRxgt+nVKHVlSdtOJLnezjheWyQCzalW43vX?=
 =?us-ascii?Q?VqEQs+5HPTFey3j9/JAt9QO+fiMBOHC+PvN/thhCXL6h4RRuCRmeFyP1K3jD?=
 =?us-ascii?Q?f26aY5gLPC5IvgeKaP9+FEHr8eC8MpZrCqXVUZVh/9KJTKrIffTV6gmtxA2t?=
 =?us-ascii?Q?u394ZmqPpjcZrKqwXVCaeef1DfoXsnUAFyNPGoc7+T8QeOV3OJISsSB/8l0D?=
 =?us-ascii?Q?ObU5iyag7e6LPEg2jap0Vw2oNa91Lavm+ANyAjL3i+yehtok308hIUYpFOvD?=
 =?us-ascii?Q?8EB5zF26Yk04rbNF0LLPpDVoW//OnIMLoWacBz90qBVAlBrHNw2rO+T+vFYS?=
 =?us-ascii?Q?WiqPhhIZWoUW39LSwCq53KluERs2zUytE5ZL++5QjVN1wSomqjpbw7FjUyk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t+e01PzlEnbjYN1xW0JNrUmwfutdZa+JQEA5W9sE6zHEj28zGdc4kgWGn97g?=
 =?us-ascii?Q?ZflEpCCgUlhv9miD/GX/ohVWroDWvM0+7nvxdyUdLHV9+72ns4tvh9uo4uor?=
 =?us-ascii?Q?EKCXde/0cXXYgGC3raO/rXfkRFjKIrYuvrRmZLeQGOL1SW3SlPHvS8c3wgF/?=
 =?us-ascii?Q?lybLOrU2nFYEqlEW53hxOwyOxagcoGSleqnchnTGW/KOkf9DNcxWCiwc9+Ld?=
 =?us-ascii?Q?4j+3e9A5gaWqBgVkxEAZipXMPueWPftq6k5nMSjpMYz24JyghcXuEzacFLiB?=
 =?us-ascii?Q?OtqERB/3QJEC7/4MRZJ4mqjGHIGdnQgObdoa2VgTy8c1C4u/xDDn8hSCJ00A?=
 =?us-ascii?Q?zeGiy3r/I0SO74O1PRSSYj04b5s/4LnshfJVv1lOGKnnFHvcwo7zmkykzeNz?=
 =?us-ascii?Q?jNHIlGcOott9+7CenMxoBGLGLLP29/Ca7wZHam0VBLlImuBfbZMI0hpJLTbZ?=
 =?us-ascii?Q?Oe6/K9A25WG7p+2iFg0Ms2UrB+3T8uBRSZrYzwQwBxbtfQVBvqQc10fnjVnQ?=
 =?us-ascii?Q?OX86p59Mvt+bT1j3haxtjx4ARizILcKQVXEsG121jSi7ZaUk+0BmQNTYF7rw?=
 =?us-ascii?Q?bakkWCqaPMcydhorceiGR5P5fi8rTz8UP/jV5eXC5XL+Fe1pYJSYiNEp39Nv?=
 =?us-ascii?Q?dAQmIhumgs0N7RG/liHaGQMZtiTRAO2kANyMlMXkzXDejHv+evPjunuifXnu?=
 =?us-ascii?Q?F/2Y4tl7CGDDcIBBrpY9trSTS9VTbzQ0ulwHKCQLsDsoy7tc5AxX7OOAFe6p?=
 =?us-ascii?Q?sdUjmFrQ+DDvCEOwco/tW4K2bUBjOUuIyVItKflVPkmNyNU1LCVd6vm3fpS9?=
 =?us-ascii?Q?/IUdon1ERrHdaOJYnUcLQPB1w2TL0pioi5D9Aa/v1TrhPjfROH1y7KX6dIr+?=
 =?us-ascii?Q?k7lqkmiTg6/3sOYEhvJUcZObNeqOVh38VTMBmXp1GoQCE0b+u4B/hyoOR7nX?=
 =?us-ascii?Q?p4qrE474Onwtvltw36S4ksbAYg1coaccgPfFO9u06P45uSJIh8uMJQnczgaW?=
 =?us-ascii?Q?wXotJQmmRFM14dvdcxyTZ2wuaJ1asu5ovtQGYn+ZF4MdIwS0+cSb7Oseb1Zh?=
 =?us-ascii?Q?2wL+eY0nbvnUHgDDkm/dewZASP7BE5w65griR9tFS1Cms/sqhtnn+N6je7ZM?=
 =?us-ascii?Q?jZsClsJ2m2aLAry/cksOMr5bYr+sLTvyNHk4QdWNH5MYlEFKlhfQk66ko6+f?=
 =?us-ascii?Q?tQIdv5bNv8WU7gbjXCAnppdyMNOw8/pWsqHxL5QamKQRsCTsppk+YM849anH?=
 =?us-ascii?Q?tYP/TjeujSAdAwvC4P/x3arzkjS0H6qDPlyaF0vscL9dgwActD1mPmBOQFnj?=
 =?us-ascii?Q?QgziNZX4tjTXMPifl80IuUpqju13ARwxfpSwaukMTOdpbM4S5IzjNbRokffc?=
 =?us-ascii?Q?RSnTwm5o+PKY8vWDOHmILbbPPTfZxXuxpW2cQZ7eltdC2j4tls/8ZvnbC+cW?=
 =?us-ascii?Q?Gz7RGllpmF7zqpl8TUXINRFvyhAIcYyYkMgTa/JyUUP343CSzjukK5ok5YEs?=
 =?us-ascii?Q?A9CMSgiBYU94Y8JvzfcYwqxqGPPmS6G4Qk98SR7R9GXxdmvs3k4VAJ1nYHzK?=
 =?us-ascii?Q?S87J1cjBj/I/eMOKk/h14b7W7sJYSNL1k3PPr84V?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfec1c66-da7e-44ac-e612-08dc7b9b0666
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 02:41:33.8313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SP9NxUvW1Ml4/HVql/0uA3gwi7rp5QZaUrXUkdkOrar5i8iQT4wwv28qSM1S/JZ0qqGBJD2xi9fvY8j2W19R+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7489
X-OriginatorOrg: intel.com

On Fri, May 24, 2024 at 09:00:45AM +1200, Barry Song wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   c760b3725e52403dc1b28644fb09c47a83cacea6
> > commit: ec33687c674934dfefd782a8ffd58370b080b503 mm: add per-order mTHP anon_fault_alloc and anon_fault_fallback counters
> > date:   2 weeks ago
> > config: s390-randconfig-r005-20230226 (https://download.01.org/0day-ci/archive/20240523/202405231728.tCAogiSI-lkp@intel.com/config)
> > compiler: s390-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240523/202405231728.tCAogiSI-lkp@intel.com/reproduce)
> 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202405231728.tCAogiSI-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    s390-linux-ld: mm/memory.o: in function `count_mthp_stat':
> >>> include/linux/huge_mm.h:285:(.text+0x191c): undefined reference to `mthp_stats'
> >    s390-linux-ld: mm/huge_memory.o:(.rodata+0x10): undefined reference to `mthp_stats'
> > 
> > 
> > vim +285 include/linux/huge_mm.h
> > 
> >    279	
> >    280	static inline void count_mthp_stat(int order, enum mthp_stat_item item)
> >    281	{
> >    282		if (order <= 0 || order > PMD_ORDER)
> >    283			return;
> >    284	
> >>   285		this_cpu_inc(mthp_stats.stats[order][item]);
> >    286	}
> >    287	
> 
> Thanks, would you please test if the below patch fixes the problem,

The patch below fixes the problem for me. Thanks.

Tested-by: Yujie Liu <yujie.liu@intel.com>

> 
> From: Barry Song <v-songbaohua@oppo.com>
> Date: Fri, 24 May 2024 08:50:48 +1200
> Subject: [PATCH] mm: huge_mm: fix undefined reference to `mthp_stats' for
>  CONFIG_SYSFS=n
> 
> if CONFIG_SYSFS is not enabled in config, we get the below error,
> 
> All errors (new ones prefixed by >>):
> 
>    s390-linux-ld: mm/memory.o: in function `count_mthp_stat':
> >> include/linux/huge_mm.h:285:(.text+0x191c): undefined reference to `mthp_stats'
>    s390-linux-ld: mm/huge_memory.o:(.rodata+0x10): undefined reference to `mthp_stats'
> 
> vim +285 include/linux/huge_mm.h
> 
>    279
>    280  static inline void count_mthp_stat(int order, enum mthp_stat_item item)
>    281  {
>    282          if (order <= 0 || order > PMD_ORDER)
>    283                  return;
>    284
>  > 285          this_cpu_inc(mthp_stats.stats[order][item]);
>    286  }
>    287
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405231728.tCAogiSI-lkp@intel.com/
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/huge_mm.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index c8d3ec116e29..09c5744d9124 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -278,6 +278,7 @@ struct mthp_stat {
>  	unsigned long stats[ilog2(MAX_PTRS_PER_PTE) + 1][__MTHP_STAT_COUNT];
>  };
>  
> +#ifdef CONFIG_SYSFS
>  DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
>  
>  static inline void count_mthp_stat(int order, enum mthp_stat_item item)
> @@ -287,6 +288,11 @@ static inline void count_mthp_stat(int order, enum mthp_stat_item item)
>  
>  	this_cpu_inc(mthp_stats.stats[order][item]);
>  }
> +#else
> +static inline void count_mthp_stat(int order, enum mthp_stat_item item)
> +{
> +}
> +#endif
>  
>  #define transparent_hugepage_use_zero_page()				\
>  	(transparent_hugepage_flags &					\
> -- 
> 2.34.1
> 
> 
> 

