Return-Path: <linux-kernel+bounces-256603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B42C79350FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 18:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3F31F22AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D7114532C;
	Thu, 18 Jul 2024 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqrEjFwM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28242F877
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721321858; cv=fail; b=lepQuA0wo98W0IeLppfLcl9Bu19BDddXQs0ubJxMOPxgARaCgVTrUK3uBtToDnxHjO/bHjjDq8WSalIDzWoT9kyMoimnAwibd1lgQnWqc0ORx0sWPKiiV/ZHJQTnXD8KiyOsdmTKibi23zX7iUzxBsdBDbiHOHJ4a8/ReBVUSfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721321858; c=relaxed/simple;
	bh=fvQbeVTh4BtSRbDzvc/nNdNxyKSab8/ch9oLHaBY+Vk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iwJ5q10+FgaonVfaWtT2Pz9ZeMNsfpQ6N/dKRMYFyVaw67V9DhgBjGWJcg6ZwHEQOUrgSmTXwrK9YsN44rUBiMxd8a3GL8wnTMmcRKyYH+gD+ul6CCwwZ46Ds4Z1UlNv0yqMHgLLMbVDeI58g7JIsX0bRehD2cSwkmMgYavykKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqrEjFwM; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721321857; x=1752857857;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fvQbeVTh4BtSRbDzvc/nNdNxyKSab8/ch9oLHaBY+Vk=;
  b=IqrEjFwM+dAvIzR/NVZEOWO6jvmpYPvlWEleViSx/YhDlXUObDI6kxNl
   /RDy9D+JdN7Zw2wzjwbFqqAmAETWpyTMs7aGbMXBDbjN3uqYZbD5Mx5Ax
   JqiUhnybiSQQmBPyBWrESfn2EZ3XZqW8BamRdEcWTIY0l/O0VsOopiasX
   qlxwOgZPdUP4XcTctz4hSvivN3MbNo42mkNbaAyNrpSPjWwvliEs1gZgQ
   MfR1V4+JfunSIr/nttRPiXnASUj6ozwtiKwGhpPDQghNNuCFyMV6WVMpD
   QByDHJ1H7xFwgycoht5ioOuf8Cvyq1hcAlqJaEJJOJz/8cZC+bKGKBAeN
   w==;
X-CSE-ConnectionGUID: lzpvIPZNQmmdApZ5Dykjvg==
X-CSE-MsgGUID: s9aPPSJKR26vfxw4hQamHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="19016254"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="19016254"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 09:57:36 -0700
X-CSE-ConnectionGUID: UK8KaSMET6iy0EZErCrUmA==
X-CSE-MsgGUID: 1r4J7M7CSIeKS8ttdSaP8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="51534681"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jul 2024 09:57:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 09:57:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 18 Jul 2024 09:57:34 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 09:57:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5pvZUtlEQT+9oMnMdzSU7z6zkWgGQa8q59YKn1iOSojpNLfTuYDhHT56BXdgRY/w4fdoRLnOvv6dw5RPa1fNF32cP/GztipK7KbHjek/2TMGVyrQ82+phjjPKAajXTXfAIHs0H+IQcRIiOwTX8+lizFX+bzc0Fmsh8mopmv9clBP3Caa+PekTAtyt3AIjOcsSEf+yXx0gaCuJJpY6fEAuBg0VHwBIZ1ew3BptlHXCnFXECy0iBFiylXgxRG/a+1u+GBA8KRpnj/OFUQc9iRsVEM9pxgdBHSIpAaAMAjrBuloQeH8vwizRT79Mf7HR0UZ1xCYIi8yEHv//+qsPP9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sn8Qr/b7luL4IWEm+OrYZvdnsHLz1icNSO0K3lnua5Q=;
 b=AbfCxyPBSVgP1r1QW/QwMcBMCnLKW7D34ev8M5hMDm7GdPerEqAjloeYcVPBzQHNkaXvtbdjZgAFjDtiTLM9gI+nWl2hTuCNuCYceYpMyKF9gwZa/l9/+bp8nBR3s7p1pa8aY3h4DbDmQJvTDxT4ibOIZB7M5cqRjHH1E0C0cTfL7WL1fIA1JJozvluCw1PIBAFF4rhIGGCoFKasQniJq5uhTdunb3OBj9uF+xqcIuCYqTlJZ7da7LAhPuBQby3dNBH3/hDO5eA6SADr0Gq4mfsQFx84WYiYxnPk3MPTngV0XsowYxO3QFp3yp9EZw0REDN3OvbFKlWOgcrIx3fbUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA0PR11MB7377.namprd11.prod.outlook.com (2603:10b6:208:433::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 16:57:32 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7784.013; Thu, 18 Jul 2024
 16:57:32 +0000
Date: Fri, 19 Jul 2024 00:57:15 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Ingo Molnar
	<mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Tim Chen
	<tim.c.chen@intel.com>, Mel Gorman <mgorman@techsingularity.net>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Chen Yu" <yu.chen.surf@gmail.com>, Aaron Lu <aaron.lu@intel.com>,
	<linux-kernel@vger.kernel.org>, <void@manifault.com>
Subject: Re: [RFC PATCH 0/7] Optimization to reduce the cost of newidle
 balance
Message-ID: <ZplJaymu/WQ7O5xC@chenyu5-mobl2>
References: <cover.1690273854.git.yu.c.chen@intel.com>
 <20240717121745.GF26750@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240717121745.GF26750@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|IA0PR11MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e34071e-bff1-4b56-f922-08dca74ab6e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ziuWYkHVr5k/3Pte8/2UJVG7PDecA4HTAb4ynXDG5xMwiCIezXhXR8X0uluZ?=
 =?us-ascii?Q?t7LZXUha8DV7EqgqQpG98/nDdaIdy8X9r7lbMRS+yqdoujWPfdmMcRTR/CPW?=
 =?us-ascii?Q?BOtQ5W0WdTyuOrF7c1tgQN7E6LE3VcW0f1a0iLzgxYVUWsCjtQ8fvscOKpX3?=
 =?us-ascii?Q?7ayMNearZaj9siy83Je1+E2uAoG2l/fSG3tHQZgzByxnp+tG197VRVidVq6R?=
 =?us-ascii?Q?mI9kRMhrfH7xrsJuaee4lXAMkb0SXg7rhj8NDCQrX/F13R/IJVCVAz+U0sW8?=
 =?us-ascii?Q?KXEXfLSnOVpQGtpd5UWZ+EMeZQD/GPBwBEazuYhKNBoSOeEwjqCpKqNZvTj/?=
 =?us-ascii?Q?h9mJXd4P21ZO6rqtxg2p5YmZp9pbazqLQF4cZT9+1x5mF25k90iEKG7M0jlM?=
 =?us-ascii?Q?HGwY6Wyj5vODZHGRlKVizkVVcDmVE6pri7Yj3CdESOM1BwLERf7G5QdkTyTV?=
 =?us-ascii?Q?lTFaZezHxSl0yWUE9AL4+OyS/jM5y6kGtiwWfOzw+5lO44kEM5I4KA9XUnGS?=
 =?us-ascii?Q?LIjX5EwEGoIGoMxnwmCljbUDvbckChscuFM8BgAhEeyqr7zaBUuDaRUSRJWi?=
 =?us-ascii?Q?/qVAeBjtYEMysn2hjNAl3nF4KiJ6TDe30I+1f8aKzbezRq8guCMF2JIsGFaY?=
 =?us-ascii?Q?VD4eajBwN7z7XLktamMO2jb59FWX8AYs7oLf0fVytS3og7pxZu4VYI6wNn+J?=
 =?us-ascii?Q?kEfkqknF5D/STFGtAq/HI/8RhzW6fPfzRji3cBB9wd1boX+s3WEaPZM+yZa8?=
 =?us-ascii?Q?OXAHk61SrDAVO+OLqJJ0f7r68r9bYQVH37GDlMdP11eXNA45j2EKXtZ+F++B?=
 =?us-ascii?Q?S7GEreOtpcqUWlshO/AaeSUYJmk7maaoI/ovCWGGh+tCDtgBFzLDidKWuxMn?=
 =?us-ascii?Q?9anJQ8hUhqf9pWtx3eT/Yg/ODeV++iBQZeVDc0PYsqv2j9dTf0REjPhTSL/b?=
 =?us-ascii?Q?7sdWjlomDz09gn+Wh0Sm4qlk/KvIQBA8RUwt9LNWb2iPmippu2wPnKeoSEx2?=
 =?us-ascii?Q?yj6Rnv6S+qAx1c7QwBKBjmZ+2jdceTS/TsC5HcXuBQd37PyR1gvnfNoOzcdR?=
 =?us-ascii?Q?Bogmfm9Qh8a8pl9Eiq7TAWjaFBzzoICCA/MI56L+7QhBocW7ItUULd/Eiafz?=
 =?us-ascii?Q?lGqAid9BtYHEC97mJkqiZm/pj5z03WNJO1K/xsGlMPTri1L+AWV3R3aXvUbV?=
 =?us-ascii?Q?BrEYbDreMUOMEVDuWTLtOULPOG6gtoq3lFy67eiwrGAxQKddLfvtYbxpH+Qm?=
 =?us-ascii?Q?gIHe91Wm2lNcb1srEuXod6NsMl0+x+MjHlE+jUha6YnHDq+Q7vp5QUYiyawb?=
 =?us-ascii?Q?OzA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SYFSvPjmofY4Nj5C4K3kcoEiLyKV8g4UHO0/3SxenByttO+NTbnh+feSYgIF?=
 =?us-ascii?Q?FqPSmfEX0x/DX78aDOB8j+0EMAV4HHZuJHegf4TtwRgl9HSPiQmYhpqKqI+c?=
 =?us-ascii?Q?oL2+38zEr9kfxp2MrQDZzTTxOfz6R2OpZkvOeqEO6ER/KzHYdggfuGtXD06B?=
 =?us-ascii?Q?CBCjUoLfbsu4tq+b33SItsZ0ZkQdgLFyVtpkUTMWNbIHkkUJE6O4hMxPV/aW?=
 =?us-ascii?Q?gz+ndtkwugEiX9hWMA4MLVXkQJcTIBN9cjTHLF/KfFmNy2x4dMrVn/AeXtSr?=
 =?us-ascii?Q?BIGi/lW2pBr8mVTbfCtVRZpAQVT0lBV59up4z8MWAUAgoIejiIJUJOkKInob?=
 =?us-ascii?Q?5uFRcR+mxoyrTuMfcTQw0bmt4fOQg+iAlRf+9qN+BhArOPwL8g+oii+uGdLr?=
 =?us-ascii?Q?9A/GBPSzTLH5LY9cNxK21p7dgpMaski2o6PQBLZn+zW9wHki03MIkaG9mX49?=
 =?us-ascii?Q?LZmkYW4WsG9dN2lPCRyysQ1FF9GPPCBbaPYL5Im23mXL0+SRmEaeIOMXYnF4?=
 =?us-ascii?Q?olrMeKdw6S6TvTiFRBcBlWpqmIO8Ew2SMdVEJDOxagie8nMrBsSqcTk3EGna?=
 =?us-ascii?Q?lFa4GB8w00UGhTQ0i5vejAt+Z2B+DJlL/jPH1XBd1zvN6jIHq2KkmTJwP8Jf?=
 =?us-ascii?Q?dIHVeaKXdsvbnuOb8UFr40lSUBak/3cJVa8uYSF1btUoUPp4stPy6ESFshzn?=
 =?us-ascii?Q?+OZShi85tFcoka42EfrRlmr+e/LiMip6x20jpCYaKLVvaja2On+aV4rcO74r?=
 =?us-ascii?Q?FV5FHnHJ+Msob4QvidAzNpIS407WcV6Ir6F0NWCfYO3eBXNX5AxOT+LvSSS0?=
 =?us-ascii?Q?RqBkdOPpEpSYUMmypYCqDAg1TVGRrNfirFrIAD8gECYQ9faJDgu37Ljd7Rim?=
 =?us-ascii?Q?vfyEovUZJXrUGqGymOT2yOEA14R22GVKnR0bSXOBpbLatzG1bqR+1xiieQP6?=
 =?us-ascii?Q?KsHOE4ZtVUAF9UxOqYpCXqck3wbvlk9mv0HluX0LAm/306RJ31y1Zi7rSUi+?=
 =?us-ascii?Q?pRM+m7NsruhL/5mqCVybbUiuM46Vt5qlljCfD6vBDgXVrseNBwc2AXBGBgpP?=
 =?us-ascii?Q?pt01EEFHM63esdl+F4IoOPJPQsSQ2WkImmBBwFeuBAGpmNBbdbrSNRqqjPLj?=
 =?us-ascii?Q?ZtGm1a5V6nv+zHVeYWFQs8BWyjs4xb0sNhhcvTkNKKhWG4NGVn5G4RzGJMXq?=
 =?us-ascii?Q?Qg47J8Kh5l7NCoa+QTXM2v2tEjeyMbErHLmOlBq+/Ee8UFiJmeGg/KeryhBY?=
 =?us-ascii?Q?BIQEge7Q6Su4IGyuFlyi4u3F0DY8GvLdjbrFH+O8p0eMMwsGAYTrQRN0GbEn?=
 =?us-ascii?Q?jWodHNjehECPEMz4marOC9SXqAr0S3AQGcCBP6zdX7OFATyCxOpkAPKHMr98?=
 =?us-ascii?Q?OL+uNoO4ERG7vUCJqQAN8qRVqJn4LKAfGNVHTdsQTnLzL+ZyPPTNQv4sUFkw?=
 =?us-ascii?Q?a+l8gyB5wRb1YC5mn1BtVupZUGpdei2+tHDKgwrykX9UA6tQtWgJLerO0hur?=
 =?us-ascii?Q?FOCqGNw7LeaqV4rr5Plh/fq5hQ27Vri03upuqp3Fen+5XB89XJ8I8VqQ8S9a?=
 =?us-ascii?Q?1pfOyMMmC6R6lF0CMclxp2isy0jvjTkH4oE7zEPK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e34071e-bff1-4b56-f922-08dca74ab6e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 16:57:31.9249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JfYGy76ufw0H7UVjbd4jYJfrg+rxtp6RRPqM+8NFPomKHSY1fv66ZWkjkR/V125UoCJzAoO/5/orhpisWRZPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7377
X-OriginatorOrg: intel.com

Hi Peter,

On 2024-07-17 at 14:17:45 +0200, Peter Zijlstra wrote:
> On Thu, Jul 27, 2023 at 10:33:58PM +0800, Chen Yu wrote:
> > Hi,
> > 
> > This is the second version of the newidle balance optimization[1].
> > It aims to reduce the cost of newidle balance which is found to
> > occupy noticeable CPU cycles on some high-core count systems.
> > 
> > For example, when running sqlite on Intel Sapphire Rapids, which has
> > 2 x 56C/112T = 224 CPUs:
> > 
> > 6.69%    0.09%  sqlite3     [kernel.kallsyms]   [k] newidle_balance
> > 5.39%    4.71%  sqlite3     [kernel.kallsyms]   [k] update_sd_lb_stats
> > 
> > To mitigate this cost, the optimization is inspired by the question
> > raised by Tim:
> > Do we always have to find the busiest group and pull from it? Would
> > a relatively busy group be enough?
> 
> So doesn't this basically boil down to recognising that new-idle might
> not be the same as regular load-balancing -- we need any task, fast,
> rather than we need to make equal load.
>

Yes, exactly.
 
> David's shared runqueue patches did the same, they re-imagined this very
> path.
> 
> Now, David's thing went side-ways because of some regression that wasn't
> further investigated.
> 
> But it occurs to me this might be the same thing that Prateek chased
> down here:
> 
>   https://lkml.kernel.org/r/20240710090210.41856-1-kprateek.nayak@amd.com
> 
> Hmm ?
>

Thanks for the patch link. I took a look and if I understand correctly,
Prateek's patch fixes three issues related to TIF_POLLING_NRFLAG.
And the following two issues might cause aggressive newidle balance:

1. normal idle load balance does not have a chance to be triggered
   when exiting the idle loop. Since normal idle load balance does not
   work, we have to count on newidle balance to do more work.

2. newly idle load balance is incorrectly triggered when exiting from
   idle due to send_ipi(), even there is no task about to sleep.

Issue 2 will increase the frequency of invoking newly idle balance,
but issue 1 would not. Issue 1 mainly impacts the success ratio
of each newidle balance, but might not increase the frequency
to trigger a newidle balance - it should mainly depend on the behavior
of task runtime duration. Please correct me if I'm wrong.

All Prateek's 3 patches fix the existing newidle balance issue, I'll apply
his patch set and have a re-test.
 
> Supposing that is indeed the case, I think it makes more sense to
> proceed with that approach. That is, completely redo the sub-numa new
> idle balance.
> 

I did not quite follow this, Prateek's patch set does not redo the sub-numa new
idle balance I suppose? Or do you mean further work based on Prateek's patch set?

thanks,
Chenyu 

