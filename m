Return-Path: <linux-kernel+bounces-282261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C143694E168
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ABA2B20E58
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8766A33A;
	Sun, 11 Aug 2024 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKUMhaBk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5996148FF7
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723382651; cv=fail; b=R96RpYmWkaCqspOvhzBsYM0tK+NEGyznL0AZdEVawuetGsA/0d/0zx/GdIkdrWyPpOy7/KodxsQ/CIoAmybGucN+vcIZQN/oY6BuXwBM06m07+NOhkrr+QL8wQMveiQjIwb5Wuh19PloeUBUSSwN2AlEReCBHmY98JhzMDXhl/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723382651; c=relaxed/simple;
	bh=zH7LZ83WHmxdyKqYBCcf6rErX4/LeNYUMO8mXq1g160=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L5GF7QrTCC/JjRvcFUJjqwkknM8w6zRlVz7Ft3gcsfQc2HwtyMkWaQ2u64dVKIV0HjkoMnewnQJue2ANJIYp3Rj2HdkEUzwvU1JcCY5ZANbNqV4PqtqDVYhbffHLjJN/GmTrb3hDMTN7XtEKGrd9ACuHnLL/Nokc8OmGg2wotH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKUMhaBk; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723382648; x=1754918648;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=zH7LZ83WHmxdyKqYBCcf6rErX4/LeNYUMO8mXq1g160=;
  b=HKUMhaBkY4PnFikT5EMYrjafBxtJvlAU6nklDoWYRw1jnN9aUpzLiafp
   kqt9rKzN5DywaXSRzJC5VyqGvSqpxJm41/1unShKQdqPOGINfJcQf0JKi
   yxpR1dOp86OS7yHPbODquC440/yTtYLa3v4e5CCJR/nJ/zF8+p7i5m0Ga
   e3/2ljHpGUewnJTbUCqjYJQ6LRh0lCwGdftKSU7GIimqMdf4srLA9OjRR
   7zwUKXwrP9GQay4zJL1bwXP7DIIoI77/mNwapDcWLoMSeBKz8tFIWDIXz
   kMnlpY/3BONwSq1bDD30BDqzXVYwdwePU7PRvNYV7fn9IkkvPq4DMjkhG
   w==;
X-CSE-ConnectionGUID: 2ij6BqbPQEOX/BS6vWC5sw==
X-CSE-MsgGUID: himJ4DPIRJ6u2+TouW6X4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21649029"
X-IronPort-AV: E=Sophos;i="6.09,281,1716274800"; 
   d="scan'208";a="21649029"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 06:24:07 -0700
X-CSE-ConnectionGUID: 8nNY4Eb1Trim5P80nRA7IQ==
X-CSE-MsgGUID: Q3UipYmvT6at4LE6o1T+Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,281,1716274800"; 
   d="scan'208";a="88860134"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Aug 2024 06:24:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 11 Aug 2024 06:24:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 11 Aug 2024 06:24:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 11 Aug 2024 06:24:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 11 Aug 2024 06:24:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdWmEC2fW5o2za+qbH0B1N0pV6Ytj7AZeRTpM1t8iv2OJMXx4nJVbmXQ5m/d0w5PBhqW/Xx6++FA/W8OBlZpocjsyr17AvQdQ3PbflSOdp+5vYrWk6bLQ5BIzin4aGALwVYnFgpJ5/QukAGKe35gZsjwlWb16/yZRo3F2GgElsEhnAHg6aH+lpbaKxPJUQm0guC7y0ku69WxgNf1m2xh/wc3N0h09R8DvNu/JvuYv39SVBpm7jiZKbT7DOJeGV9zqqhN9t3VvPrM/uFrZzPlulwV54MPYiMbAhBM3r78ooKf9gXWH7bJ8nEkDYjeWHEsgFrzFImolZbiTsvm0cuOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0rer3YgDi8a9mspx3j+27zwc38hkvSqufJ+yZVaZlg=;
 b=K/GqJ23mCsXzhOBF4o881lRZmrqmxt9G7OSzn+c/Ifm/2heRUUkD45u7BxwKTBJ4cKO2WyM2JFi+wOyLlqFFBRKFkTK+k+QoyQXg5osQTG1FvD2NWFc5ebNvy2Pd4EYMf5CwnmmX27OYdYcw05fqJs6ACBBz922r1d47JoNPavOcQsqjnQeXJu0f5s29jFt0sGX6bC2tvhXb3d1avJLIGe8KVgQEn7Rtf6KeRUFEgGDEzMFOU1GZ9NswGtyDZllsaK4mT7eFU4ebN5vLYIaBdqdmzKKvsra8iUcPtkGPv80CfyPESfYOGlCcNcq9VtYDyjQqDHseJPaL6XmQfV8QxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.24; Sun, 11 Aug 2024 13:24:01 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Sun, 11 Aug 2024
 13:24:01 +0000
Date: Sun, 11 Aug 2024 21:23:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Oscar Salvador <osalvador@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>, Peter Xu
	<peterx@redhat.com>, Muchun Song <muchun.song@linux.dev>, David Hildenbrand
	<david@redhat.com>, Donet Tom <donettom@linux.ibm.com>, Matthew Wilcox
	<willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko
	<mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 6/9] mm: Make hugetlb mappings go through
 mm_get_unmapped_area_vmflags
Message-ID: <202408112137.e013a399-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240729091018.2152-7-osalvador@suse.de>
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 190a1e8d-3cbf-4aff-f291-08dcba08dd43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pcRVOLEyO3l435f0/JfKV70v6Po9Iqscto0NRDD8hF+j2V4025QUmu4Hn6sV?=
 =?us-ascii?Q?8yh9wRzd8fy7n67aJePZeq7iNe5LjWPhujRhe82ikPG9qSfqIw5ymWPAzTGV?=
 =?us-ascii?Q?/aaA7/+AFkar7wWKwz/G6kwtxlpe+FKr1CPmcKyYJbQB/yuFMFoEOE4IDATc?=
 =?us-ascii?Q?6sdL15dZkJ0lk35XCMvYiTMyjIIeGE9fzwjTMauaRohPD1zIPTkLS334MgL5?=
 =?us-ascii?Q?m7fr/0YAOHti+1jZImdXOV4z1cBXBLFJ1bWVEbgaBxvZ7qjlLsTwj3MW7aKN?=
 =?us-ascii?Q?dD66/5HgzV0JoxNDweH2hbkWKbAMK4j1wJ80/bN3uGKULSWCSPFALh+OiPjF?=
 =?us-ascii?Q?/0ia8G1dnuwOOewGqI65mZQaIXU+fllmIwuwcyqlu4MgdQOo4SQBULnxGotO?=
 =?us-ascii?Q?e2k1MSP+e5lxOK2OmmPE7Xv35w/cjL7wplT48iu1Zk53EQX4jb7c/zcArr7T?=
 =?us-ascii?Q?pwk2cc58ukS4EtBQGRScnirmdgFPnUmEOLsedVOSeBeKSfkuz0nfeCftSD7E?=
 =?us-ascii?Q?ZuL3fYdStGjxc1oJPkVuSl5EZbAmwK+CKQv2X5rxlu3xwUw+Rqt339NmkP5J?=
 =?us-ascii?Q?6C8ZFBf/tQs6JmxObiMmCZosbxEFXRxUSdqfKK1vgCsHuso/cID57znYIKbi?=
 =?us-ascii?Q?PP0eR81V9MuyVaH0rEmVLOnaOG3kEnJiawqPscJBmCXoP+sT91CLQrMl7LC6?=
 =?us-ascii?Q?VWH1DNs3qEyQfIco48B800D2A7fQ8M/1chf+GSPQeM4ekT3KcuIVDVwWBS9S?=
 =?us-ascii?Q?nv16aDlett8DjsFmtcGMTvqpYm/VU3A69tzNBgmfotTPi7ih+GG9B0m3lopG?=
 =?us-ascii?Q?gddsunVkUj0sc6zZ2J64E5TYsfYxWdFhlGYq+a+ZxDIJDJlhiE/IiOO5J2Ff?=
 =?us-ascii?Q?mHEqvH1JbPSFhyFB6vHAGX/CSN8qf/ZtU7J4dxXqWe8URrtLRBAVSh22U3Un?=
 =?us-ascii?Q?H9LIp/dlZV2/reQ9eGKdaKH9t0nV1Msur/85Q/0LxxDRspXS6/J6ppELTFhq?=
 =?us-ascii?Q?LhEaCf27cWJJKUXGchWVcytniYWwn2iskwqyBazBFQ1ZnHDlj9JJh6AHUZhU?=
 =?us-ascii?Q?xl8ZriLKslzjv5lPWiULBzMKMO+nU8yL1zSC7qjd33e54Ok4TRiQaHbyuwZi?=
 =?us-ascii?Q?Uwlf1dB5ypj8UmTKrpMQn9IpvhgwAY7eRp7scn+pcy4QQXvAjbjhe2RCUluh?=
 =?us-ascii?Q?Q0vNvN8d/HBRIDwkG1KK5ZjWx29tZQVOunNnLWcgCRtfapzwZyEijzFNLgH/?=
 =?us-ascii?Q?hEtCYvAeUUYYVPtad1/pvhdWVX0x8pVwDS6Y26oglnp97SbRFngDn/9gUNxa?=
 =?us-ascii?Q?pEB2j79SnBpN5tMVJj+tmhxA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OXt5icqYRHXMnl6F6SAyGO5BVfJ2nN1TH2Oaop2Om5yaLm/UjEBTXKshOITT?=
 =?us-ascii?Q?WtazFnbIzvILuzHgC2d04FcwPVfXV6mCWwAgJeNUbFSE91LczfkjLGmy2/MC?=
 =?us-ascii?Q?loDTI/E9PHhoqlTaxJZgJefCGPId/Ucno+D5TPFPG0OavGPggPjwase1gioH?=
 =?us-ascii?Q?6YEhiV1krt/hz2tKai87yVbVgtRRMxEBDBppSxNvHUkA4mK87DkYxvbFFzaE?=
 =?us-ascii?Q?/2FfNN2gVVQEX7068Y84WDpyMb9fchCmQGpvPjWuUCHl4MtGlnwuYyFalDhd?=
 =?us-ascii?Q?f2ah50vkprIe4v7squ7l5WV/oVNQbLiEP/ozMFlUkOhNuGGinkvYsl8k7p6a?=
 =?us-ascii?Q?uA6oFjGVieD3W8XX2vcHEFDM8ZMIuZlW+GJ2wz0dKAaw8nNnZFI1HA8n+VDe?=
 =?us-ascii?Q?LQm1Z/yQ/mNAnf9KZmztzBfJEGHV4eDyTa7ZUvciBBQkV8ElVENlysaFTIOW?=
 =?us-ascii?Q?TRnRGkqd0Ooj2z76kWuXPS+tA2kqCyeaARY3ETjoj4JKGYZHPHinlaDTYt0p?=
 =?us-ascii?Q?ewStqHrWQmddCfYIkvz4GgHjeftB0qq75XtQoatPojo7wtS6K+DzZDMszclH?=
 =?us-ascii?Q?AW5scsU0LHKN86Nvi/RdgToBCGFn97TsRLLyxFS/XVMYTp3jNckJf5zDpJt7?=
 =?us-ascii?Q?3LgMqLgB/wRqbqX0usyBjptBaYAk6O8TwWe4YhOD6TYdDLCO7vLhFeH6zYH7?=
 =?us-ascii?Q?BiPiKn89sQOOSnEERI5l8C+xfXajKCqAZx/vXjVF1CfMmY8xYJn3shqH9xro?=
 =?us-ascii?Q?5LXI5EH04o6HBIYut+4p8sV6eovBc97l+Crzp+NZ96OvHsSlTOZu2uF1O9OI?=
 =?us-ascii?Q?AhVM3gaZbqnygJvS1mA0s2BCp7DFJnH6Aob1W0yDwAFL9Teb7JgjFDpiRaqx?=
 =?us-ascii?Q?7PWiGIdlqQY66GlARoSLSU+djHtWqCzTMV6PyqJYMfuRDpS2e9zIAoPdgN/l?=
 =?us-ascii?Q?YEP8+p1Lu4iADwCIcPzzPBlVnN61zu1L7v+0b9u+5Z6z3bMuQJvX7XkESzIs?=
 =?us-ascii?Q?dGJYtGR20tboLBEqboPP+FOZ04aVDk2nQmLmFiMhMRDQ1jfh7WU1z5nH7KgX?=
 =?us-ascii?Q?8vKcdSaJeUBcOlajE8ZvEvQmtpBI/PxWCQBiUOBYEXvAdgqjheFzm7tuTGQq?=
 =?us-ascii?Q?1lIw32wMhZ8aSwu618fYgf1tYafFPs41jZqRre/vTwki8FV9SvSofuZXN+Vm?=
 =?us-ascii?Q?wgbyGb3xpPzPr2PIPYVnQptCmq1SegIalozHX9ApiybjJe1YT+yVzd2GwgbI?=
 =?us-ascii?Q?3iZyDAr3NA3zTBPbeJE5zlNiJocU4tRR9QyhT9k7c/uxh57WDFCDWYYdXxRb?=
 =?us-ascii?Q?8phFq1tq6OiXpVt/RkcZOXsUjNL2dRaawcNl5cgF8e8E2N4TC7AgKpo6YV6n?=
 =?us-ascii?Q?uG4yNF+zopiVLw6ufWLD6+JWmVeAQ1JIEk2SG1H5+4gdiuTRLaq2L/RveICY?=
 =?us-ascii?Q?aV39K/Re1iSFPnX/sEb41kPge6n5vcuEbkEIETJkL9uIsmZ3/EvXUKoE5E/M?=
 =?us-ascii?Q?Sb3xteCv+8aApdzNweYqlz0YH0P1CuZzjJG0o3ZjYsFHQpbT9VOdFvT6nxJG?=
 =?us-ascii?Q?92GPkBgG/7x/D3Xg45sTx0HsbFtvLwj368sbl4Rj5tVjM6tSxD+tlAaVjupM?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 190a1e8d-3cbf-4aff-f291-08dcba08dd43
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2024 13:24:01.7719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wS3sMbTyDTxfHB6a/7gnOTd5OBFDuKBkQ/KUWwUchKbUKcOpu6r0Fxxlj5SyReFoHgIb31zEFJanZRRzw7+ylg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6019
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 535f03fb3da2b7b2fe5089ee5d1a291774a298e3 ("[PATCH v2 6/9] mm: Make hugetlb mappings go through mm_get_unmapped_area_vmflags")
url: https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/mm-mmap-Teach-generic_get_unmapped_area-_topdown-to-handle-hugetlb-mappings/20240729-171449
base: https://git.kernel.org/cgit/linux/kernel/git/s390/linux.git features
patch link: https://lore.kernel.org/all/20240729091018.2152-7-osalvador@suse.de/
patch subject: [PATCH v2 6/9] mm: Make hugetlb mappings go through mm_get_unmapped_area_vmflags

in testcase: trinity
version: trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06
with following parameters:

	runtime: 600s



compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | ec3b0c2006 | 535f03fb3d |
+---------------------------------------------+------------+------------+
| boot_successes                              | 6          | 0          |
| boot_failures                               | 0          | 9          |
| BUG:kernel_NULL_pointer_dereference,address | 0          | 9          |
| Oops                                        | 0          | 9          |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 9          |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408112137.e013a399-oliver.sang@intel.com


[   38.976763][  T448] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   38.977518][  T448] #PF: supervisor instruction fetch in kernel mode
[   38.977981][  T448] #PF: error_code(0x0010) - not-present page
[   38.978411][  T448] PGD 800000012c3cc067 P4D 800000012c3cc067 PUD 12c3cd067 PMD 0
[   38.978949][  T448] Oops: Oops: 0010 [#1] PREEMPT SMP PTI
[   38.979343][  T448] CPU: 1 UID: 0 PID: 448 Comm: trinity Not tainted 6.10.0-12075-g535f03fb3da2 #1
[   38.979990][  T448] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   38.980725][  T448] RIP: 0010:0x0
[ 38.980993][ T448] Code: Unable to access opcode bytes at 0xffffffffffffffd6.

Code starting with the faulting instruction
===========================================
[   38.981530][  T448] RSP: 0018:ffffc9000108fb58 EFLAGS: 00010246
[   38.981977][  T448] RAX: 0000000000000000 RBX: 0000000000200000 RCX: 0000000000000000
[   38.982550][  T448] RDX: 0000000000200000 RSI: 0000000000000000 RDI: ffff88812ce36600
[   38.983124][  T448] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000073
[   38.983692][  T448] R10: fffffffffffffff4 R11: 0000000000000000 R12: ffff888319920000
[   38.984258][  T448] R13: 0000000000000003 R14: ffff88831996fe00 R15: ffff888114c42000
[   38.984826][  T448] FS:  000000000109a880(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
[   38.985465][  T448] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.985942][  T448] CR2: ffffffffffffffd6 CR3: 0000000114c52000 CR4: 00000000000406b0
[   38.986515][  T448] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   38.988705][  T448] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   38.989257][  T448] Call Trace:
[   38.989493][  T448]  <TASK>
[ 38.989709][ T448] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 38.990001][ T448] ? page_fault_oops (arch/x86/mm/fault.c:715) 
[ 38.990343][ T448] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
[ 38.990680][ T448] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[ 38.991046][ T448] __get_unmapped_area (mm/mmap.c:1932) 
[ 38.991458][ T448] ? find_held_lock (kernel/locking/lockdep.c:5249) 
[ 38.991796][ T448] ? do_shmat (include/linux/mmap_lock.h:122 ipc/shm.c:1643) 
[ 38.992098][ T448] do_mmap (mm/mmap.c:1325) 
[ 38.992394][ T448] ? do_shmat (include/linux/mmap_lock.h:122 ipc/shm.c:1643) 
[ 38.992712][ T448] do_shmat (ipc/shm.c:1658) 
[ 38.993016][ T448] __x64_sys_shmat (ipc/shm.c:1694 ipc/shm.c:1688 ipc/shm.c:1688) 
[ 38.993337][ T448] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 38.993670][ T448] ? lock_acquire (kernel/locking/lockdep.c:466 kernel/locking/lockdep.c:5761 kernel/locking/lockdep.c:5724) 
[ 38.994000][ T448] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 38.994366][ T448] ? local_clock_noinstr (kernel/sched/clock.c:301) 
[ 38.994720][ T448] ? local_clock (arch/x86/include/asm/preempt.h:94 kernel/sched/clock.c:316) 
[ 38.995061][ T448] ? __lock_release+0x11a/0x290 
[ 38.995511][ T448] ? lock_release (kernel/locking/lockdep.c:466 kernel/locking/lockdep.c:5782) 
[ 38.995833][ T448] ? syscall_exit_to_user_mode_prepare (kernel/entry/common.c:199 (discriminator 1)) 
[ 38.996289][ T448] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4299 kernel/locking/lockdep.c:4358) 
[ 38.996715][ T448] ? syscall_exit_to_user_mode (arch/x86/include/asm/processor.h:702 arch/x86/include/asm/entry-common.h:91 include/linux/entry-common.h:364 kernel/entry/common.c:220) 
[ 38.997105][ T448] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 38.997436][ T448] ? do_shmat (ipc/shm.c:1680) 
[ 38.997749][ T448] ? syscall_exit_to_user_mode_prepare (kernel/entry/common.c:199 (discriminator 1)) 
[ 38.998189][ T448] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4299 kernel/locking/lockdep.c:4358) 
[ 38.998606][ T448] ? syscall_exit_to_user_mode (arch/x86/include/asm/processor.h:702 arch/x86/include/asm/entry-common.h:91 include/linux/entry-common.h:364 kernel/entry/common.c:220) 
[ 39.000911][ T448] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 39.001243][ T448] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 39.001574][ T448] ? syscall_exit_to_user_mode_prepare (kernel/entry/common.c:199 (discriminator 1)) 
[ 39.002016][ T448] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4299 kernel/locking/lockdep.c:4358) 
[ 39.002445][ T448] ? syscall_exit_to_user_mode (arch/x86/include/asm/processor.h:702 arch/x86/include/asm/entry-common.h:91 include/linux/entry-common.h:364 kernel/entry/common.c:220) 
[ 39.002840][ T448] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 39.003201][ T448] ? syscall_exit_to_user_mode_prepare (kernel/entry/common.c:199 (discriminator 1)) 
[ 39.003644][ T448] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4299 kernel/locking/lockdep.c:4358) 
[ 39.004049][ T448] ? syscall_exit_to_user_mode (arch/x86/include/asm/processor.h:702 arch/x86/include/asm/entry-common.h:91 include/linux/entry-common.h:364 kernel/entry/common.c:220) 
[ 39.004443][ T448] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 39.004767][ T448] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 39.005087][ T448] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   39.005501][  T448] RIP: 0033:0x4648b7
[ 39.005775][ T448] Code: 00 66 90 b8 29 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 5d 46 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 1e 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 3d 46 00 00 c3 66 2e 0f 1f 84 00 00 00 00
All code
========
   0:	00 66 90             	add    %ah,-0x70(%rsi)
   3:	b8 29 00 00 00       	mov    $0x29,%eax
   8:	0f 05                	syscall
   a:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
  10:	0f 83 5d 46 00 00    	jae    0x4673
  16:	c3                   	ret
  17:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  1e:	00 00 00 
  21:	66 90                	xchg   %ax,%ax
  23:	b8 1e 00 00 00       	mov    $0x1e,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	0f 83 3d 46 00 00    	jae    0x4673
  36:	c3                   	ret
  37:	66                   	data16
  38:	2e                   	cs
  39:	0f                   	.byte 0xf
  3a:	1f                   	(bad)
  3b:	84 00                	test   %al,(%rax)
  3d:	00 00                	add    %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	0f 83 3d 46 00 00    	jae    0x4649
   c:	c3                   	ret
   d:	66                   	data16
   e:	2e                   	cs
   f:	0f                   	.byte 0xf
  10:	1f                   	(bad)
  11:	84 00                	test   %al,(%rax)
  13:	00 00                	add    %al,(%rax)
	...
[   39.007086][  T448] RSP: 002b:00007ffe45cb7dc8 EFLAGS: 00000246 ORIG_RAX: 000000000000001e
[   39.007608][  T448] RAX: ffffffffffffffda RBX: 0000000000007000 RCX: 00000000004648b7
[   39.008147][  T448] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
[   39.008683][  T448] RBP: 00007ffe45cb7df0 R08: 00000000010975f0 R09: 000000000109a880
[   39.009185][  T448] R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000001000
[   39.009547][  T448] R13: 0000000000000002 R14: 00000000010b0e20 R15: 0000000054001fb0
[   39.009912][  T448]  </TASK>
[   39.010094][  T448] Modules linked in: polyval_clmulni polyval_generic ghash_clmulni_intel intel_agp intel_gtt
[   39.010801][  T448] CR2: 0000000000000000
[   39.011091][  T448] ---[ end trace 0000000000000000 ]---
[   39.011399][  T448] RIP: 0010:0x0
[ 39.011649][ T448] Code: Unable to access opcode bytes at 0xffffffffffffffd6.

Code starting with the faulting instruction
===========================================


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240811/202408112137.e013a399-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


