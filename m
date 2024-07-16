Return-Path: <linux-kernel+bounces-253778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 121189326D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366531C21723
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7775319AD47;
	Tue, 16 Jul 2024 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DHL6Q7qy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E419AD4B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134015; cv=fail; b=J6xbTkg/+xJKuF3PyqxSSByXWM5/aBq8QPAkzGV1Eg++LDFG3bvknbgTI0BruqlMqcziRLKcGZ2P1v8W3RsaFxCchczmMuSPYz4zVZFRNDP/XUGefDxU6u7XX9vWOOJcwgmqkNzNdr5bb3c8SSc0LxQlsMeqtZhX9242gTDOWIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134015; c=relaxed/simple;
	bh=vHttqJ3ugLzrh/8urGBB3OynS37HdA5THb7yoLLGiJ4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pVW9rowQfxDTL3pbBWk2J3nxxJjRA5ts8ikXNqml0ONQblJgFJ6QDnpIeArV4Q0gODDWfeKQlIx2ou5Pd5g1LWl8J6/jHqjh80hJQB9UTbsYs7NDLjVysn8OOMs5k1i1WdilXN4eY13g4dmfE4WnK+7hKK3sFAJorHZ8tFGXcAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHL6Q7qy; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721134014; x=1752670014;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=vHttqJ3ugLzrh/8urGBB3OynS37HdA5THb7yoLLGiJ4=;
  b=DHL6Q7qycgP8FzO7Sk2ugS8F7+1t3pU/rP5wjAk7/sF0BZTWpbj+OTdB
   khElLzwO6XvRrZf257Lh7D8NK34UpFSPfovzf3A+UdkMnYpNJZjwFQLyT
   Dc5qFPonQcCXLaFaJBTit09OOAo9SF8z9Nmg/eoH8jel9nX3ke7Md2nno
   VO43Lp1jaZMfsb18Anaz5wwbLyQbDrR4X5rxsVXYfGveTwOlGcfjDt/b4
   iBgKNtidvMRElWc0vFkFpc+LCXz0iVwWX6UGMA3uBJ89UjYYyGoXDIrOE
   YvTsZK9j1bNXYoFQA5Fvrq5IpY9xnn+f1qhDlCnuBuSfNXdeZA0WnnxTb
   Q==;
X-CSE-ConnectionGUID: SD1LtkI3SImxAZ9qVuzB/g==
X-CSE-MsgGUID: 0EMiXgnbSNSkHCDewuGSaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="29158692"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="29158692"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 05:46:53 -0700
X-CSE-ConnectionGUID: i9Y662a2RBC8tEpRR7M9FA==
X-CSE-MsgGUID: DY0nd4IjTOC7O6oeWC/AmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49881617"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 05:46:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 05:46:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 05:46:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 05:46:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAmsNBpTyasrhOvufd/UaEzfW6T4Bh2vCOp/rYfr6Fe7Zk0dyesEE3BF/UayFP1UQurGLyZISegEm5b04wCu5aNFFZmJrFLpdSNxwgL9CtUppmeNqtJvIpy5GqITaPtmQpqID+TMjdM6KLmBr4J+JunIE//nbFLxr3YSGqU3z1PTX0jeRRsdzcq05CV2DQvvsU+le6Zk8qVwcnQ+btH6gmySvnA6K5E93+YEd400+TWl6wI0QrzOZMns3tDdQSbJkXVXmpRFriGic2/ZOETXjv7FvV4RgHNsGe6mCsLLxyQ7q/tQYkTXi6Vni59tdlbyVM6Yl+msqUbOvi9nk/b/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Kc7XjzCnfGpfWlLisSA6Rmfk9y1YyCOHYmJ/hUVgbo=;
 b=eiGLKt7mwKT1OBpjqbEzO6nhSYBlUhpJrgX96WmeWKmoCI6jK/SF/HWaUXnAxwA8SEUPgHntquUDIrSvNBxKbc0lbhBx5QEq6PW+VvHIgkGsmZnNIG3B7f6UobBvgkuh2dQPAjqqZt7MpkYTFc/oLgTlz3NajiHvmgpKeTTSi5QJCuGD4a1w7cJmf5LGAJ/lSsr5CYqCB6C0rpxuNh/BEHx/xHmg8EVw3thuLLJmpW7Ym2HPDKdV/AjTbHNN8N/nw6cx7DS++mT7hY9YQ1Ho8KAMQNRBKphrCz0NJXmSkos+njLoMSyD2tZAJ3AoeXH/Vn3dT3i0xEUnw3iwiAB2ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7813.namprd11.prod.outlook.com (2603:10b6:208:402::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 12:46:49 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 12:46:49 +0000
Date: Tue, 16 Jul 2024 20:46:25 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
	<ltp@lists.linux.it>, Andrew Morton <akpm@linux-foundation.org>, "Suren
 Baghdasaryan" <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, "Lorenzo
 Stoakes" <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>,
	<sidhartha.kumar@oracle.com>, "Paul E . McKenney" <paulmck@kernel.org>, "Bert
 Karwatzki" <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
	<linux-kernel@vger.kernel.org>, Kees Cook <kees@kernel.org>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v4 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <202407162022.5a730c37-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240710192250.4114783-15-Liam.Howlett@oracle.com>
X-ClientProxiedBy: KL1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:820:d::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 396aa120-8f02-4d90-27ef-08dca5955c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FNa6J3+EqEFxzD0uNun+/HmbS5FVrTnx58fVD3GityfBuNoUpzifSkzgORTl?=
 =?us-ascii?Q?LzvQKdiKk8wCMg0jHjxnIMR0zhWgdJkHYHkhsercOXBoEp/m1fAk2+ys+XrG?=
 =?us-ascii?Q?WaMZucOiH0i2CJrGXML2tq8uXjq7mb3VE+BsmV4igOsoCogHDP/CBHLT4aPm?=
 =?us-ascii?Q?jbk0CA7W2wmPrCeVuLkfdnl9OJKCornZqpslGsoCjRrU2QXAuBReUQj5gOd6?=
 =?us-ascii?Q?w4MaFhy20vijcJM98p8/ZnqNcdw+7khLk5b7Dj00PROKFLFc6TZd90sTO3wz?=
 =?us-ascii?Q?6666C5jzFzcoc+CWTaCXdr3JOHUffz82cucqELv9xnQRZmxZ0WusZS0GM8DK?=
 =?us-ascii?Q?5A9OAponLQyOgu9yq/OmDugNJ36ddlU1SFibhjNfKXN7Wp5c8SB85mh9yuuI?=
 =?us-ascii?Q?zHI/6PGWaw9+g6UsUiqWtqID2j5gmQi7GaS19okFteYM3Ijf7yP+BhEtgqKj?=
 =?us-ascii?Q?3OBQdGJwmnsj6ZFZApkX03avfGDgnmU8dVkMLGlEnobCtEUQHLvLI/f/axLp?=
 =?us-ascii?Q?qeBLoeUdE71fjo9gxWrmi7JDAgkiqmy5a9DPLGDHRJUK5wAXE8Nzig4MEfpU?=
 =?us-ascii?Q?0ACMjO13uVKOcE1qUJJu2JR8DSCP5Y8dqY7VNwFYpVkOsCP4RXgn397ce/5W?=
 =?us-ascii?Q?BOo3dYkpsdUwELbPLzlK0g/vXbJXyH52NCPLIOw1Rx/t8BGMXxv6U6GmO9ax?=
 =?us-ascii?Q?DVtUBy2RjFuLPapsSG+OCBWfq1h2Nvy7mrrv/vdssyEaIdlDFrEK3eqMm4hl?=
 =?us-ascii?Q?kPHu18UgnuS1jLVoGFkoANP2M0dEAtFeN/XhHywJuDNZr+v0xksRcIIfKOTr?=
 =?us-ascii?Q?L4lcQRXd7ZlJA/niAR8aKwp6XkUifphd8wqSWLQMhJf5+lqyjkNLtT32pVny?=
 =?us-ascii?Q?naR5IMBG3H0rzjhoJS4TndgpDqQ2QDSt5mhIUSvgzKKpgrb2OO+K4diAl4Sb?=
 =?us-ascii?Q?hNqXgNuWSB8SOq/AOE5roqYO9G33SSjeA2yyJ2kIT0l59yUYJeA9X8TA6YqB?=
 =?us-ascii?Q?IzhU/aldQX03GI9TQ5rBCbU/qo3wfBWrcz+Qn4QjqM8orn1kk6vZ/tfcGCUe?=
 =?us-ascii?Q?vutBdLsL6o2jypyyhHE8ilAQJ23sc3/t4hycAQ4RcsRXufcM4dXwO6EzqeNP?=
 =?us-ascii?Q?anDDklcceD7+70Deic/7v3Tfe+m7sZ4DzFHE5uAh43wYJLI8BooxJTqRcN37?=
 =?us-ascii?Q?ozx3RXMVn4cyEh8vTitUtpWGVSLAYHQqe8nhjdLdeXMuCZsYQzxre+IzGldX?=
 =?us-ascii?Q?vj9D1pxoNjnT7HLo5RxgqvaJKC3I3O95Xw88la8hW/ma8odzpxJMTVvJTpVf?=
 =?us-ascii?Q?8Oo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0yhzuHX+cOUO71iwJ1ba93dTaa6WPa1+orzPIAatLgQsEgAdSECYezJt3/Nw?=
 =?us-ascii?Q?yvZIuJSihqSmKsTr2p4nL+gDf0i571nIKpCDMsJiZ22+Jq4KdaUH288rkO6z?=
 =?us-ascii?Q?dayrZ3C28byKgw77Jn/G21Tur/WqhvIaELfxFYHw8PqzufI3kRtNYHc7OwqI?=
 =?us-ascii?Q?hAxZktNQIZmnt4NuJuSXCL2ckc2Bm7COyDjrC6VStFpPF6NvyLkz0/QIy61I?=
 =?us-ascii?Q?iOrC6bwMm+e1npAUczgjQhJvqPy5atOG8CV4t+PhYK8B/1dXRusMnMIrrqNW?=
 =?us-ascii?Q?URBSjQLFvaWLZ3gSKuTzhynlETpKAP+TEl0WwTiD/jBUC+yt6KrxFtnGsUWk?=
 =?us-ascii?Q?plPaOYidJhAmGo96IAg/alxdcygz5tlYxKbrPegCd4wPAFDe0CUaA6oZSLFa?=
 =?us-ascii?Q?VUd8Ct44B3XE7zfUaWR0aEdx0sqYLpw0MYJsCEXPZBiC7zpoDvka6Xr98xgm?=
 =?us-ascii?Q?ZOgEHDy+kXpB7prg22w64HkC5BZg63s7rb+BowCc1eiN+sIFJf6e/tuuQ62N?=
 =?us-ascii?Q?5ocyqGHtHfA0YzWiywJ6cZWFdOXoN9cysHgJe6qZx8BezypgDpVaGiD6SSFs?=
 =?us-ascii?Q?/W4f6R94d8pFmnt4c6+NiKIzPoISQ6KuuW4H73LHR5USRT+muUXD7SLe8UgT?=
 =?us-ascii?Q?BgP/khv4dUomFY1l23DDeK4KLZJTulW/oxIxPRMzmEDGurNY6PmrRKYQDOr7?=
 =?us-ascii?Q?cbhVtMLosTA8lHsxpPM0CtbjRGEi9m8Y+9Dd1Y4fW83jwNS7MPne6GNkOoU5?=
 =?us-ascii?Q?JS5N5cbwSBl0oZJHG/TQL11CHHZsbrx9mQYKOhc07cGu4tlrCvSraRj29SAu?=
 =?us-ascii?Q?dSae/I9APyRWlzO3PQJnlgTg9BEJibDChMhr3XWIWqHcgkYjv76hLSBFjWu8?=
 =?us-ascii?Q?1WzgOXDYvSGCiaEweXQwRn6o1qb+9QSUHl7+Y9YwmUbX655GHFD4SQ+ehNbE?=
 =?us-ascii?Q?YTRvheFB5MmIuN5qvAwPW5QifpE8BjnQEqst9lAWiOhbuPwk8BJDRV37rokT?=
 =?us-ascii?Q?aAbMQpAc3N0WdlQKzcdIw6b6KwyNAw3QkIjQSaE5qCYKRRe2j6GZLyHYjTpI?=
 =?us-ascii?Q?XYPtxmxEpaMrbDMqCkoyoUqO+6hJdtiLepvvCyqET5L0fuDHmfdfnjR6sdRZ?=
 =?us-ascii?Q?cpAIOHXLjXCubTr2FTxkGmiUXS9vpLvqjiau82shwR/YO9ap8mAT2vfHprRn?=
 =?us-ascii?Q?HkZvj6Z0ygIAjdKJgvJR6GERBVRJS2Sse2J5oWiWxmlyJ3igyVgzMr2m5rsQ?=
 =?us-ascii?Q?vAj4UjyRhoeff2MuDPa2sjIYzelfZbcqY/WJN724hhQEmWfmOO37PJzOGrWM?=
 =?us-ascii?Q?O6/cUzSNYM7ytaBaIDBcXXMcQhSh0NBqSkEByAyN6dDUm5PwcXBgcNFCGDuK?=
 =?us-ascii?Q?OeOG3UrWZTaf+40BZ0qVkG7+CEqVw39cWy6+vqaT4FkgTsN13oJEEDsaZfea?=
 =?us-ascii?Q?fxCRsDGf32pePlB3NUHIM5UyEz1csOCUYtt9yNGUZslmyqmv0Q+pfRVkIueC?=
 =?us-ascii?Q?p04yNMxKAGkq2oei6HIidCTzqdS/vGrjIr68g2sIrGhGmgnaspBovPKex2wJ?=
 =?us-ascii?Q?ESrwlxyviGIAVpeFlda89PpC33Oe7mNcaQT1KBeNia22URWWpdVUdHXp3D3R?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 396aa120-8f02-4d90-27ef-08dca5955c0a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 12:46:49.4015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7BIWGJo7nGZhgehJFmERkHh5B9SpohyvBYpcLrc6D3XKa86qqQV+Z753CsDNjkiYO+F1YKdm3UzqQUwbBqd2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7813
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "ltp.hugemmap06.fail" on:

commit: d793398401db9fb81084bd4fe2f782342201df18 ("[PATCH v4 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()")
url: https://github.com/intel-lab-lkp/linux/commits/Liam-R-Howlett/mm-mmap-Correctly-position-vma_iterator-in-__split_vma/20240711-075019
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20240710192250.4114783-15-Liam.Howlett@oracle.com/
patch subject: [PATCH v4 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240706
with following parameters:

	test: hugetlb/hugemmap06



compiler: gcc-13
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407162022.5a730c37-oliver.sang@intel.com


Running tests.......
<<<test_start>>>
tag=hugemmap06 stime=1721029963
cmdline="hugemmap06"
contacts=""
analysis=exit
<<<test_output>>>
tst_hugepage.c:84: TINFO: 255 hugepage(s) reserved
tst_test.c:1803: TINFO: LTP version: 20240524-71-g361f6ad13
tst_test.c:1647: TINFO: Timeout per run is 0h 00m 30s
hugemmap06.c:114: TPASS: No regression found
hugemmap06.c:114: TPASS: No regression found
hugemmap06.c:114: TPASS: No regression found
hugemmap06.c:114: TPASS: No regression found
hugemmap06.c:100: TFAIL: mmap failed: ENOMEM (12)

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f522c3ac00a4
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9119a41e9091
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7b24d8616be3
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1406ec9ba6c6

Summary:
passed   4
failed   1
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=10 termination_type=exited termination_id=1 corefile=no
cutime=2 cstime=629
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20240524-71-g361f6ad13

       ###############################################################

            Done executing testcases.
            LTP Version:  20240524-71-g361f6ad13
       ###############################################################



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240716/202407162022.5a730c37-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


