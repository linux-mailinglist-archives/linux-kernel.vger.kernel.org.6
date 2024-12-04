Return-Path: <linux-kernel+bounces-430425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE479E30C6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CEE41641E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25FBE40;
	Wed,  4 Dec 2024 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPlv6lpb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A41E36D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733275994; cv=fail; b=UozSPVR/Mr2uBBc/DUhyBFM6HgWOqDUWlCnHVEIpTNnOK1bR/AikfAAwt5iknFWAs1TdfII9BkNL1Rsp7p0/+RZkQ/dJ/zQaBKxnWTxdu6qFOnwD3uPIwxqAuAKoEM66FYC2YNVCrgKt66K25BzBRQVwjpsYXJxqZS/duPjwTqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733275994; c=relaxed/simple;
	bh=Pw+I5UmiODxBuMhei0fpSKC7nzWJvM7jquQzOUim/RQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GfZMW3Rlok/B1vxKKNh/F5Wv6bf2E7kNicrgpZvpt1f4S52YzZVMq5dFiJbjf9PT/yfXh/JUqbjQozaO2TO0PttPbNi6QE7YuzRG7rYdg/fbgWywdmuhd8OYdA4Y0WjgQl9hm70YC7b0dBh3nsKbt+KzUUdQpkn86Mntjjb4VUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPlv6lpb; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733275991; x=1764811991;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Pw+I5UmiODxBuMhei0fpSKC7nzWJvM7jquQzOUim/RQ=;
  b=YPlv6lpbIYh8imGnhqO79uaRVoanh0j3OWatrxHutYcXPmvpssagbK/L
   OOuYFT3WiB/YaTZBo9IsTsSGFCE/3F4UTtHLYSiykcwRIQq55bGccoj/H
   roRlxYPP81cp3uuUkl0bvY5nG/WdQs1SmHq1rcz3BBXBrMF7KPFuO3vCD
   MIixZ8yg97is7tOct6UUy8ak56thZJ/AOA8LQL0vU2RYsig+dNW33rQO9
   JipG+H60hSM9qH/bO+NmrsUIpw4wzXzUB27IMC8GOo4y//oZbPJN3XWEJ
   VHjA0R9cfJOckQpwCrgEI21MK5tYU83kRYuVLzxR+8GytlLbE3aey5Tef
   g==;
X-CSE-ConnectionGUID: VmO1DUMGT2ycZYvswCKlVg==
X-CSE-MsgGUID: QseeBAIGR2iUofClWU1PNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33655753"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33655753"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 17:33:10 -0800
X-CSE-ConnectionGUID: iqsl3l5VQKqbBsI90TOSXw==
X-CSE-MsgGUID: LRDND16vQLKkVDUrkpol9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="93465251"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 17:33:10 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 17:33:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 17:33:09 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 17:33:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMTVyRoQhfKbWisbmJGJqEBndHPP/wYccM2nx2Efdl+edWaOqwKjdpeS3gKUO9VNYZSuN0mueWBKAOQu+hMtJdacjVePxQO6QEOQGmhM0ea71I7VACMTHo26C5sQ3vo6jw1Y6IC3RUY/mk0pyBcEPymcuMrKOFlslJb2fm5tbPa9cXAuwtZzfen1JsmEPK6jCURDSWGg7famP7Ixq1pytuFo06DwGdV1uVn30tgz+BaKx9p3gXoe38Lezquv00OfJXVIfbPQqMBw9pGE5InTx6bAlhSibCcwdo8Lofk8ovNQyeomgjHlIh+75NV8LGnEQQ0J+2Cz69Rwp3xv/lTK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIsdRPjAeV7qeXhhi8wLm6vzftM8nz+jYRDqSn6VybA=;
 b=QLW7u2vcXw21xLnK9j87ffzKVSpYtM1XNXVKHwGdoUObqlOVtAtTS48mYM5PrsYmxCFN4I9KsRgZrGKTVEiqHwlpKWGvTeJAU1Dt4G7tcY5J6LoqvKBzleJ43XdKtsxTo+WM1/XJhM6m0Jv68INzNFaX3zhgY5HMMkA7buQM3R5LQTtPmcjPQZPMohhJ2dk8hn34+zM5YSPas6IZLn7oI+bGl70RP8yqurO7WAr4dbBjEK3LgIOsNpXrvFjGvjY2J+TSDHxNosDX0y1LDsao3veAfojiytsS36ZEtN0Ca5UaExUb/8bI5i35oCrURwFoL7ZddJqM0IrnmUfvAB67Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6428.namprd11.prod.outlook.com (2603:10b6:510:1f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Wed, 4 Dec
 2024 01:33:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 01:33:06 +0000
Date: Tue, 3 Dec 2024 17:32:56 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
CC: <x86@kernel.org>, <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Huang Ying <ying.huang@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Kai Huang <kai.huang@intel.com>, "David
 Hildenbrand" <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, "H.
 Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH -V3 RESEND] x86, tdx, memory hotplug: Check whole
 hot-adding memory range for TDX
Message-ID: <674fb148d58aa_3e0fe294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20241031085151.186111-1-ying.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241031085151.186111-1-ying.huang@intel.com>
X-ClientProxiedBy: MW4PR04CA0293.namprd04.prod.outlook.com
 (2603:10b6:303:89::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b225217-5829-482b-176b-08dd14039a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9t8IyMlbmU/z2+Vkzo52sbgqj4xtSgBRS83WLWL+wbhCwQAfabcb1TmDffhv?=
 =?us-ascii?Q?cKQeCJf3oN3w0n/cv7Urv3OTF+Btdtso0J3gIzHMeDUR45M0Wme7OBvahQqU?=
 =?us-ascii?Q?l3YnZXnxwpaEP6OdyXizJvEqJBsV94A01bwiS/kp7cBTRryqBljCrA/jlCPd?=
 =?us-ascii?Q?+yNEGKWEIJN2ufk2Tct2TBoLQX1PSu61xaMOA7yPs//eHKIhSG5j1VHw+Uzh?=
 =?us-ascii?Q?XueAZ3Nl4Ai6x3AJALnkOSvc2IluwvcgVwzbBTolw6SFOHZOz2p1Svb2H9Lp?=
 =?us-ascii?Q?Tg8KzkE96KO3x+qEUmDVTaxeB8eOpxN0gb950y6gZxWxHU3xPYtN8diTtQDB?=
 =?us-ascii?Q?AEmUuSDTk1ovyZmJ6jPBXJ3OpjrtbJ1K9gfaRdG7VeeowkMgyVHtLkfzt/TJ?=
 =?us-ascii?Q?00zfiLlnKOA5IayV2yYc32ZB/cnfQ+lbitgJxdym82F8uM5F/7v0ej/EsgmX?=
 =?us-ascii?Q?b7UGgsJYGeNNldxaSjDmvKqqXL77kMJ+IgLCW2lrFX4tjxqLKoQsex/Npv5q?=
 =?us-ascii?Q?WEBCgmg9f9ksKqgJJZUxasHC7CMYFlLR+yqXXZw7FHP2G3LLuZQRch12Jx2H?=
 =?us-ascii?Q?fd1pbJ7A5bFW/oDQ0MYQ5C+6scItnocyo/KDw6QsNzkiZWWhcxvgPL42DnQl?=
 =?us-ascii?Q?DpIiDMTe2KmLIJWrRPNDHtUPC3d8P1TYdFUnA6UFjloTj4Nk+BXUCw+/kp/g?=
 =?us-ascii?Q?xyRVM+V5D1cxb4Us8YE9qxqQWE5DQvWdZyu14U6+WX33R+ddKtexLVe4Of3N?=
 =?us-ascii?Q?TuwDThrlOMzj6qeLNIv2gRA+yrinlRfJHY2y7gue/FFd5UcuzuqCqccfNj5D?=
 =?us-ascii?Q?BgpYAe1sQ6yVHFrfR+JhXD4yh51ZWAxw9KVP6HuAU+r8Gz6vxsZQ91CaQWXx?=
 =?us-ascii?Q?DoWxSROx1dkWhDCwhQIbJCMrcu6glLIncIT5+O1VjNzqRnJ9408uW1ZXVGNH?=
 =?us-ascii?Q?PBtuB9qQ8BrOwn1T5nEhcVVouY34s4WpaPlvUCYKkzDJljqufpxE48KemV/k?=
 =?us-ascii?Q?h91tl17VYfNZZR4xNSkIqlDZJasAM+fDTkhUkeY3Vx/MqVn0e31LXFKmH330?=
 =?us-ascii?Q?RhlUjylSoPrUDyruUiBaucj95Wy6Zk8Sl6b6jM6JHUEmycjpcu7fCzAPDTx2?=
 =?us-ascii?Q?dMxJIPlYDRmYdXSKRUVhySIj2pXq1yPPF6nuqe/haEKjBHmC1qhED/Yxn06q?=
 =?us-ascii?Q?eek9CDVDL01WKGkwUtqNoxMArLO9XqCo06v/1zTGRcHBUZxLtTM47GnwAVPy?=
 =?us-ascii?Q?jUaFlOvCSBHysIRymmsCkrJJGxklubCibpoE9BRueulb+esxsq5Ff2p27uai?=
 =?us-ascii?Q?f7d+fYnMxXPBplIWxGPbFv/zDITdXsaA+j1JHern9rk04w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qaKseEfBcQw8XDjIdO9zXdASl245MJy0rZrrrf0JNevhm8tAaUKCv56xgih7?=
 =?us-ascii?Q?pdze4ytG+AzJhyzotKFtL4RzZIYugMppThaHL0gkeDBj1mjSGkrmmT28h8U+?=
 =?us-ascii?Q?XgSSrF9G2s6wQin7WqbIq8j640SvwgRTpV41SId/7pG8gZ8xgZB1GHWri2MN?=
 =?us-ascii?Q?n0UaRCWTmVWFGQSTapaJ42AZ/o0hv/1wNV0ZJP1T1jGLLOfw1p8k7J7CSAex?=
 =?us-ascii?Q?WAtkJuM/I+MjZ5YyMQfATrzauChVTYYG0iq0PmvvgOf0xPwh5uuHOn5gZ2+j?=
 =?us-ascii?Q?NwZGEpoKVA/Tub37QsM6SCIt+2tKOXiZRYEGkj3OFOvLbAgbuSKJZyWRl0es?=
 =?us-ascii?Q?EdAXYrBnAKoO3wyhCl8BsyLKvctHzYQvjq/yt9ubGwnLxCPDNDfJC2A1a1Uj?=
 =?us-ascii?Q?vKguKkh4A95sNvI+cgku1tjcPqBxOu3g7fYTz1UL7Ws5zc7n856qyqgLKTLi?=
 =?us-ascii?Q?QLa+MhWhH8J094B3ySvxTtz7nZvxrVXcBwYjUSj8gJcMvAaFFi/0jLsc4lbD?=
 =?us-ascii?Q?/z3KjOrRCsv1q5CuOZYiivEt+YGZOQqzn6wtIhXRdCcOqBgLllL38IRuMKj/?=
 =?us-ascii?Q?aCxml3fXnJpubIJKoVL+sKr2urJbvmPQSPoOB1khkD5MhrYvh9SQZICSIhTs?=
 =?us-ascii?Q?sMrJx06Eos7WKewSwESobjdZQ8pS1MOppGB/UsZUltDWwlQEQ/NVgdGEDjc2?=
 =?us-ascii?Q?puy3sayj/hE3kUoLtW4Tlxj3rnVLcE1h727w00CLPoR/FjfCS4Ui0c1eLdSn?=
 =?us-ascii?Q?BsNshHtgjuEtcZLg7O1XRyYKriGm39b7yt6xEXez7jiUhwoEJXrGr5568NvX?=
 =?us-ascii?Q?i10LPyRAMNCkEMZM3IXk0Y+WWMF2SkfoZjdrMnrpkIvTDBw6PZbCbYJwWj+p?=
 =?us-ascii?Q?mAsz7LNZuxyQY30jdMuFx2flRtZyNgkO1RDj2n/2qSrtXPCnT3TuIQprEHKX?=
 =?us-ascii?Q?JQVsQELPAdmrd/dCbtmnxY9Z+0X/nZL5dtDcL9aoQnZM2wGmAGpVYK3Cz6Rj?=
 =?us-ascii?Q?FGXeAVIBmmqMJ+KVRbxeHtL7pqUR/UgsQBiJzdFb7cVdla2Of5CwOPgoE8lq?=
 =?us-ascii?Q?p1/kwu6cNW1IBWe4xOycs1UfpL1pXtqsuwhp1rQCjZy2iLj2R5tcfIxs26ZK?=
 =?us-ascii?Q?BEbuGxUAB9jeOgQZGZa5g+nSTG1hphSaXPOoTZaxOiHUfeOt2PSPi6aG5sSP?=
 =?us-ascii?Q?YNIjTaw2fA1x1smlFtjeE/3r04cakWb509ZWqeDYrKFfTu59jBtY206loKIu?=
 =?us-ascii?Q?pLr76Px7TOWJ/87QAv665H4qfR2n7EVE34CfgFpQk1xigipx1Rryxbn/2kQ5?=
 =?us-ascii?Q?0uZpGwDGhgqUxDIcTOido4Voql18oQhORoUyk8ZnbDRbJYgcEBcRkwsW3Ero?=
 =?us-ascii?Q?3u1SoIZwUGMWkSLydzlZ4AQGQpsqEMN2mp/U3s3PYi9kLztuOWe+NXRjkefU?=
 =?us-ascii?Q?629x3dotBHQY1js28t8Jd47Ufl1+YBBSfIstDJyAJBmWXFRmgR5mcMSn6Tan?=
 =?us-ascii?Q?clr+GiqLKj4IlHfTtWTc1oORUU7VYmMJCPn+rz7DxRZoQo0ejBJ8eggmKhdk?=
 =?us-ascii?Q?DjSL8InI6Av+fr2DxQLnD/AzKjAvx9hBvkAaNAjzTgfmFfXGHO0Q6LCKzA3a?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b225217-5829-482b-176b-08dd14039a4e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 01:33:06.4270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpIqsB4e1alC3pA0ZMY6gSiAB2Q+5ByjrjyEuS4fPQrSZIrwElr6q6ErFDmiXAzKvaDEwUavCHY1NHSQwsypyOcG7JLVznMQyIITw2q/hgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6428
X-OriginatorOrg: intel.com

[ drop Ying's Intel address ]

Huang Ying wrote:
> On systems with TDX (Trust Domain eXtensions) enabled, current kernel
> checks the TDX compatibility of the hot-added memory ranges through a
> memory hotplug notifier for each memory_block.  If a memory range
> which isn't TDX compatible is hot-added, for example, some CXL memory,
> the command line as follows,
> 
>   $ echo 1 > /sys/devices/system/node/nodeX/memoryY/online
> 
> will report something like,
> 
>   bash: echo: write error: Operation not permitted
> 
> If pr_debug() is enabled, current kernel will show the error message
> like below in the kernel log,
> 
>   online_pages [mem 0xXXXXXXXXXX-0xXXXXXXXXXX] failed
> 
> Both are too general to root cause the problem.  This may confuse
> users.  One solution is to print some error messages in the TDX memory
> hotplug notifier.  However, kernel calls memory hotplug notifiers for
> each memory block, so this may lead to a large volume of messages in
> the kernel log if a large number of memory blocks are onlined with a
> script or automatically.  For example, the typical size of memory
> block is 128MB on x86_64, when online 64GB CXL memory, 512 messages
> will be logged.
> 
> Therefore, this patch checks the TDX compatibility of the whole
> hot-adding memory range through a newly added architecture specific
> function (arch_check_hotplug_memory_range()).  If this patch rejects
> the memory hot-adding for TDX compatibility, it will output a kernel
> log message like below,
> 
>   virt/tdx: Reject hot-adding memory range: 0xXXXXXXXX-0xXXXXXXXX for TDX compatibility.
> 
> The target use case is to support CXL memory on TDX enabled systems.
> If the CXL memory isn't compatible with TDX, the kernel will reject
> the whole CXL memory range.  While the CXL memory can still be used
> via devdax interface.
> 
> This also makes the original TDX memory hotplug notifier useless, so
> this patch deletes it.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Drop my Reviewed-by as I now realize that my reading of the changelog
for commit abe8dbab8f9f "x86/virt/tdx: Use all system memory when
initializing TDX module as TDX memory", and the presence of the
"is_tdx_memory()" helper lead me astray. If the changelog had said "This
approach requires *but does not validate* all memblock memory
regions...", I might have been spared.

Until the new "convertible memory ranges" (CMR) enabling [1] is settled the
kernel just takes on faith that anything memblock thinks is memory is
TDX compatible.

So, the first thing to fix is rejecting non TDX compat memory at init.
Then teach is_tdx_memory() to actually know about convertible ranges.
Then add support for attempts to hot-add memory that might not be TDX
compatible.

Given Dave's comment about locking and the need to consult
is_tdx_memory() in more places, it seems reasonable to replace the
tdx_memlist linked list with an xarray with ranges recorded by
xa_store_range(). Then this implementation only needs rcu_read_lock()
for locking.

