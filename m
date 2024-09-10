Return-Path: <linux-kernel+bounces-323166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774069738CA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3455C2828A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0194819259E;
	Tue, 10 Sep 2024 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2Adhg2M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873C955E58
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975577; cv=fail; b=jwLdxIWpA/TckdE/wxtpxwPlAkHQUqKQDaAPKRhT0in9k55hzjpTUorg4ixnJm/380aPY3eaczaAw/5hbB5ukFHRQ599lvDRpKPsmo8owpAc9OgON72Nyq3pR0dufp6tPxY+j9mXJ3uKsJCbR3rqKHXcfTc/ZCNPF2/BSq/8TB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975577; c=relaxed/simple;
	bh=Ebs/4Ij/Ca3N0ulEqjbPdlBajxyJZA+OKcpHlWvWmko=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ce7hZ8rWMaol9alYQTd4CPZqGEMqwgKy+BkNqO8QBgcF5j3ZzQjcsac5RJzW2NegFyqkk8nPVPhEdnsjQCDDu5NzkZWgODv2RF/6Qf+LSMsnxCtOwKC/3HFk9P/siol3VOfK6YAwp372+w+oCNL00gxMLEmViFZQFMflnlZF0Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2Adhg2M; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725975576; x=1757511576;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ebs/4Ij/Ca3N0ulEqjbPdlBajxyJZA+OKcpHlWvWmko=;
  b=e2Adhg2MYd939gGSQkWRS7jqRJMfwR8wIEh8HU4V9qcjc8oKMjCZONpX
   FcMNY1/1wJWNXGX3G7DUGn43moN2eSa1N0xCc9qUXZ0JRStsR3VtpZKlI
   Rg0N0L2BHiRz9iuxY65ERfAaZ20ZhQb/NkIf3eMY8Z2JHGeRTzvL0CBq8
   xUPq8qI0AFNF/+02asPeTA2K3NrN9ZZ3ixhhoE+ZPbOzrGdx07ZDQDQ2X
   ewZ7T94KGqSNomZYL3NZ98SFLtqyhdVtmi4BWQIUYgbZ9+LDH+HOuIJA8
   8Pv4+6axs0b1kblDt1mbR+GhAEr2vKKHGknpPeacKRlN8MmtxN2V/vdej
   g==;
X-CSE-ConnectionGUID: yR6UMOP/SjWC3Tiyr00JTA==
X-CSE-MsgGUID: SluWKf/dTSSyZ7tni3h+fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="28501478"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="28501478"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 06:39:35 -0700
X-CSE-ConnectionGUID: zrEPw1DhQYaZ/E1CilZ1ag==
X-CSE-MsgGUID: 0ZHA38yPTAWHLZIUBJjuAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="66837684"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 06:39:35 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 06:39:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 06:39:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 06:39:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+hCLMt0RJVBjAmcSuqU0t86WY24jhiVUi0Zz5w+jAzRR1do191WhzslhLz2L33PU1Ry4Nf1+DgJhyNqWDKL/V9Kc5Vle8smXlMUz/c/X+3not/mt/0lJs6B5QVsAMaYCc6MMMo6tq14pJxF0CmcWJLwhelmRKCxOeunbVvUc8La37WCkjrxjzeXDkdcn5pxiFVSg1pHgEGhVO62RrwGd23oKMFynySDETJXp7x4hjJEDdKThwHtTP7bJ4vlrZo61yqwFIDtihJMCrA9N8IYW3PqlCpOc7g5Un06z3iti1Qy7YLhpgqjxPlq1tJvhUjQNPTpskLokS8WWWbeRa1lWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IIexV1R8VvTA0G/0gAd2gmU5GOsTWXSpE0pmJN/uZ0=;
 b=UoRJ7ujh948UZinL25kn4ARMBJV78iC3jgpRii4WlLj1IOMMJ/7Z5ZFTlqqlIp96xdYQIKG+jruyK3HcEJkXM2+a/o9kWSenvbI2S07buYCgV3zUW1xxTKSZL557yv9JT4kWYfpAuCHGOwZqLYG0GmSSNHY5g/c1ear1vy6Cd3hUCIVR/dZrIN9JN9wuhARpqC3wZHNtRX06cHCl29jw53Mr/C9VClqAMAepZVUwNJdjCqDy00hIZ25b3MD4KXIuXUXzKVaiq/nqgm1Uq2D+yS15rae1vGMPQfTNqk5l/7VKmz9s1Dit1jCRYSug8NlgpJubVaQ9yiRW/nG96P+9iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM4PR11MB8129.namprd11.prod.outlook.com (2603:10b6:8:183::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Tue, 10 Sep
 2024 13:39:30 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%5]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 13:39:29 +0000
Date: Tue, 10 Sep 2024 21:39:17 +0800
From: Feng Tang <feng.tang@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton
	<akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg
	<penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim
	<iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
	"David Gow" <davidgow@google.com>, <linux-mm@kvack.org>,
	<kasan-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] mm/slub: Improve redzone check and zeroing for
 krealloc()
Message-ID: <ZuBMBcOkaKU39wnI@feng-clx.sh.intel.com>
References: <20240909012958.913438-1-feng.tang@intel.com>
 <20240909012958.913438-4-feng.tang@intel.com>
 <ZuAaDbSMtpLVJPrY@pollux>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZuAaDbSMtpLVJPrY@pollux>
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DM4PR11MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b13e323-7a75-4493-42e9-08dcd19dfed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pkBxprhMYqgGmxz/sfDcrKe5izcclVWmbbn9k08XmBUpbVGuvSv0lBnPct2J?=
 =?us-ascii?Q?XVtKeSMBN0eAdYGUfS4dKEYgJJRNRzAZGegsWkMHSgqXzdSiyolxm9ufAEOz?=
 =?us-ascii?Q?42Z9y549b2mnequOwZUl4Yyur65i4K6E35cdN1NBOXdkTRR8qTRXZew3DeJJ?=
 =?us-ascii?Q?2nICii33mgVoGoIhRmBdNYo6HhDugHiVuLjakCM77mbRhGCkquKt6AVqXjT1?=
 =?us-ascii?Q?C4cNjGhKbuD+CiNMkSFN9gbwPLLKRKCSQtbCTbDvmJuxaml1FRerMJpr627J?=
 =?us-ascii?Q?GIYaT+Nb750fonlyFTVaiwuzAEXP7aiBB25zTnFix2xsLN6PHMxN1r/5JlWs?=
 =?us-ascii?Q?BxP9pv4CxcX7TRJUpNZ7BFHZpZXmz54R/kz5p6MNsvg2GVZJuTcP8FG+bimq?=
 =?us-ascii?Q?qsF9avP9Q8JlvINcCMG0z7gJeaSqHDAfplp3lakPK0IbZVfJr1VzXLR4sLFk?=
 =?us-ascii?Q?HgeTWnknih0svSvCfM+z2bInFUXlE7/lbqUtLJbjDEJsDBCZDTW23OY7nHam?=
 =?us-ascii?Q?EC5CTAjRlahhO1G2qcxziI+aJEQIzRbGm4to9WLniHn+OfdpNvE0uv9o8BT9?=
 =?us-ascii?Q?JI0WVYWcXf0OBQzVZ849XTHODHv+QQwlqZknibo+rr9VWevN0eAOPkuHIijD?=
 =?us-ascii?Q?UnnEaoq4/OsSSCf1k01Kt5BYF0eHwK27v7oo3uashYypsHgpERFQgqdUtcs4?=
 =?us-ascii?Q?hd/bipNaqIn24PZwRDXL1NqX97//XQgGsVIALK+gec113gkIb7HtOjFll816?=
 =?us-ascii?Q?3MceTqVocHON9lSYkOr2cTQGTJUnv6gt58gX7UHYICFIlUUHP1WXKCxN2TIw?=
 =?us-ascii?Q?tO0/fgOb5ITFKxRRlJwG+GMxWtgF4tkJkJzfTlxccK5sKElbNRI3EwLZyN5y?=
 =?us-ascii?Q?JRsiClrX4uDtvgxWqQ8G0DHXBoXEGPRSN5+P4H/3WQpWJBB46Dji4jQLEadY?=
 =?us-ascii?Q?PvbwAgXZAHKu4F0PgoonbxlM75mo6y/k3UNY0ZRh5EDBuyOhZHsbZArxRecE?=
 =?us-ascii?Q?xEb44ndOQKfrlFce03fCC1xoG8zU9BvgCLfKh3kMyXE/y+eqtCz+6DCJhSlp?=
 =?us-ascii?Q?gT3jTdX3V9dFwnzPvOXXl0p3l2lV8JSmLH5kRHcVZRtMkKsbkWziLbvKytAU?=
 =?us-ascii?Q?uUez58oRONAopauPQ+h2t6eCYGYD5S+e4rO94CqRjiFey3fXhEatrUYhH4az?=
 =?us-ascii?Q?L1Y0ujrFqYit4d7DHA2ZoerOFT/oEkH25D+IQHWPGuSM4WYopJXDl2lsjXBt?=
 =?us-ascii?Q?3G6zOFo7oePK/Hm2i88rM8E3PyeaCU8+WkbwZH00cjAMyxNtMCDKCd6BqAd8?=
 =?us-ascii?Q?cDUAIIAD/xdgAbDHSDTgNXZpAhjEVXiVBWuXleqNVlUyZA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rC4b8madIUxaTIAHBLILIZcG+FZb8kdDyGPtzhA8Df9bwdrBRDd0iY7duyH8?=
 =?us-ascii?Q?qJQIztQdkdTPdGLAGhFmhf2mUa+/XI/aQthp5Y+xNntW0GVC9NwHQvIRlo4B?=
 =?us-ascii?Q?h8MoO5Bd+uU4dOX7mhtdIYfBSQ3kgSkMGPGhdLoxJmwFZNZxbgq8VJYz7cS4?=
 =?us-ascii?Q?3JV9F8UCjRka6EUAPlduKaNKq3HkCU4Mm0Jv8QFqT/hnfdPFBtXSoVuIewi1?=
 =?us-ascii?Q?UzFpfiSshBlhXYuY6dc6d/yt1iYjJY+kVnCcTt3TZwz9Er9bKlPjNIqIP6dH?=
 =?us-ascii?Q?0DpWg4uiFYT8nck9TR7ebE3d5/D9KG9OIfcz5hhKiPmlSa0qkqLewF33+RZy?=
 =?us-ascii?Q?ycJeyTBGxd+whi31bbKhph8zp+Y6YBVXfq1PRaDtb5ujXIJur3eRSREZeCp2?=
 =?us-ascii?Q?GoGsAzcWsBnUTt8X4ivczlk+Pz0hyLHIEzs4gL5dNctza83FwZgg/xuEVARR?=
 =?us-ascii?Q?3WR378TurvTRKNIwn9tTjt6Tz/IpUDLBmeyhDiKpO2joKJBHq7oUv1UME9lm?=
 =?us-ascii?Q?BVmVgHgzBr8hJlxDnUcKYnd5XuUl5dHCVwmfcIPOs33rYfg2WO9DmqWK36Ey?=
 =?us-ascii?Q?Y+tQCBg8LhuiCSmvycFtcWIJoXMt2xOpq5t0xRTUSegJo6EATtKqvrT9Q6hN?=
 =?us-ascii?Q?ns8r60zvq6Lp9MmoQ/Z/p45Vi6VGOgPN4v30dMuW2X+OezESmzJxQAeVPoWa?=
 =?us-ascii?Q?7LVfgqZbVOYEZiVgxgboGQtTC2IJ89yty62GQQCS1f+WP6rCaUr2V+jiIfzq?=
 =?us-ascii?Q?WC+brUqoEkm2Ak3Ns72klxlLvcxojE9R5mzEVr0LbyE5/Z/otSO9JmBisqxG?=
 =?us-ascii?Q?oZ1jCZamVGljVUnHOxG0X/f2zXyRBBR7Sf5rgUuLTJGA0ntgt0slHm8TtRFO?=
 =?us-ascii?Q?qVkaMAGcqq2HF7tm9D8ov4FpNJge6oKhRv/PXaBLL2g7OaQsNvXV6JrMYDbZ?=
 =?us-ascii?Q?Dzl5bPZ3YeApeT3tV8sPpSHaJM8sSYMo4qvC1F+fOJMSGZWXpJcjSWy7ZEVI?=
 =?us-ascii?Q?wtax1T/2WvI8dfBBtney2O/tx14VMRdrhsI5GbwedA1OxQQlnFgGXB4hAOB9?=
 =?us-ascii?Q?gyvkio+7bo9EmNrQogYsGHR3fN9ZN29wFqUboEJPpEoE/1jh+nxyvFrCEyF/?=
 =?us-ascii?Q?r9WAjrKrP7PBhgOHYoKCW+MEwra+exQui0MfB4B7wjPwO0y3jXQd7zAeuE7g?=
 =?us-ascii?Q?TtWDuxLig1rdegQxjLKpdNKNmoujAaTfVcLKSM/RAckFHf9QmcwdJk+Csr1O?=
 =?us-ascii?Q?TzIRrbjgQjJ70mVCd6vGK2E45bRv4hftSrJms/MJRgZ21jlmi7s24DtHTlGx?=
 =?us-ascii?Q?4R0/BvweB91Nm27wYfKrRG4S9guaSQUTnO0HWA+qoKzqVs9EW5Aj38tsugnP?=
 =?us-ascii?Q?5H4nxl7CXyM84ov45SkU2mYdQUxV7AzMGD62cgVxL57HRve050iz0d/w/Knk?=
 =?us-ascii?Q?NydnnzwkbInJ8pjanDJlFl2fW1yQpOjfpvoI2NshgWW4ZUC5sjzBWCqHBaAT?=
 =?us-ascii?Q?TfctZcXWSpOPp6Pdy4BhcUNyM1wLmQdhgbclqOxGR9o2H6v+k6gQqgTLuBXr?=
 =?us-ascii?Q?c9NE1dU/6m/cIALs0fBlafLyEbipZizCtxOmacta?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b13e323-7a75-4493-42e9-08dcd19dfed1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 13:39:29.5885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKd8XhgDasNaIoGq+xwullwMtrNfzsidLjXjDkXFZ+0OptX4zgqkiP/0EvbOJaS7HeGBccO3+5CHJUw5M+dP1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8129
X-OriginatorOrg: intel.com

Hi Danilo,

Thanks for the review!

On Tue, Sep 10, 2024 at 12:06:05PM +0200, Danilo Krummrich wrote:
> On Mon, Sep 09, 2024 at 09:29:56AM +0800, Feng Tang wrote:
> > For current krealloc(), one problem is its caller doesn't know what's
> > the actual request size, say the object is 64 bytes kmalloc one, but
> > the original caller may only requested 48 bytes. And when krealloc()
> > shrinks or grows in the same object, or allocate a new bigger object,
> > it lacks this 'original size' information to do accurate data preserving
> > or zeroing (when __GFP_ZERO is set).
> > 
> > And when some slub debug option is enabled, kmalloc caches do have this
> > 'orig_size' feature. So utilize it to do more accurate data handling,
> > as well as enforce the kmalloc-redzone sanity check.
> > 
> > The krealloc() related code is moved from slab_common.c to slub.c for
> > more efficient function calling.
> 
> I think it would be good to do this in a separate commit, for a better diff and
> history.

Agreed. will do.

> > 
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  mm/slab_common.c |  84 -------------------------------------
> >  mm/slub.c        | 106 +++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 106 insertions(+), 84 deletions(-)
[...]
> > +
> > +/**
> > + * krealloc - reallocate memory. The contents will remain unchanged.
> > + * @p: object to reallocate memory for.
> > + * @new_size: how many bytes of memory are required.
> > + * @flags: the type of memory to allocate.
> > + *
> > + * If @p is %NULL, krealloc() behaves exactly like kmalloc().  If @new_size
> > + * is 0 and @p is not a %NULL pointer, the object pointed to is freed.
> > + *
> > + * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
> > + * initial memory allocation, every subsequent call to this API for the same
> > + * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
> > + * __GFP_ZERO is not fully honored by this API.
> > + *
> > + * When slub_debug_orig_size() is off,  since krealloc() only knows about the
> 
> I think you want to remove ' since ' here.

Yes! :)

> > + * bucket size of an allocation (but not the exact size it was allocated with)
> > + * and hence implements the following semantics for shrinking and growing
> > + * buffers with __GFP_ZERO.
> > + *
> > + *         new             bucket
> > + * 0       size             size
> > + * |--------|----------------|
> > + * |  keep  |      zero      |
> > + *
> > + * Otherwize, the original allocation size 'orig_size' could be used to
> 
> Typo in 'otherwise'.

Will fix.

Thanks,
Feng

