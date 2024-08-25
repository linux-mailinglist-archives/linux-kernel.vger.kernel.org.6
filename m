Return-Path: <linux-kernel+bounces-300368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4655E95E2DD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 11:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED87F1C215E7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 09:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B7113CFA5;
	Sun, 25 Aug 2024 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJR3y3OC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335242AF07
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724577953; cv=fail; b=WbG5Dkx9F/ApPhcf2/KibbI/Cwo1HgedJOFD23SbU3JjTXsPnRL/gJdE/6+vooJ8RwBDO/cQ9iSrlcl5wVstZaFU0nw0AbmStGJb0VOH+i/uEWRaYd03yrqZqS/3axO1HiPo6mrecEON/U6WvtO6FqkPcEjc1prR/M8XJpUUUVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724577953; c=relaxed/simple;
	bh=iXdF0EooRafnqnrPFawAJhEtg1NJj6MTAGDvtkLVuvo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=FqsYBWp5zNDDtZgUkpyjTScJ5e/hdebFDARpS0dw8F+mH/tJ5csjWJBJlMdZaOKTgGl47dneEbIUMhmVcHjY+ytovdQdcd33GeFR8gQ+T3wd3euvz8THYNt1V8Oy5aS/rDWJm5r1bnHhCdbgss4W1466ntrAjm37NQ1RENtytsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJR3y3OC; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724577951; x=1756113951;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iXdF0EooRafnqnrPFawAJhEtg1NJj6MTAGDvtkLVuvo=;
  b=jJR3y3OCQ2V81ElCMbjEnfRJ6RLZc25yjUetn0dya0br++jvabTqPw3w
   8nhEzpKoH6Q/3yzOwuys6EM7zHB1n3M59oMgY3C+GwCUR8qmE/+9yyNAD
   Dgan0zDHASJjF09SZvzqVHsC/xQVNeQZjbNLdHLHf5RU4P0BAJuJUppu4
   X4Om+heF6jn2lxsI2HZev4T6GXXv2O4qeu86t2ZwGVU95AOXk66ROF/w0
   r4MmZ7GPWKiBY/UOVTsYBPEUjoNDML/DO+VHaepv9V5lzz+67nN40i1a8
   nNfY11tvabL0yRlKU2kNyuzgDDc5ljeDm0jBrLhOAF8AIT6azJonyBbA6
   g==;
X-CSE-ConnectionGUID: AdIon2/6S/OQGO6bmMMzyQ==
X-CSE-MsgGUID: IYT4bIu7RkWH/JmHLVw/NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="23140236"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="23140236"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 02:25:51 -0700
X-CSE-ConnectionGUID: 3sSYOl+bTOqPhAl4Oy/B6w==
X-CSE-MsgGUID: 8E214wa9RpSoPq/ak8/btg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="62756736"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Aug 2024 02:25:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 25 Aug 2024 02:25:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 25 Aug 2024 02:25:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 25 Aug 2024 02:25:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 25 Aug 2024 02:25:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFmAQr58CSqpqOBg2Sd/dI4GNeKBQ0lDaYiy2sJUap+GcjimwnqEHKFEo6TCHDhQODPgProlDV3afjezyEx+6x0WTx8O5mCKOFf9nlkAk3P7FfrkWBEHfl5pnHBmCtms6hw1d+3JUxdROmx2xfJpuFwQvaWV+zBxrJWuoEMUE/2xMzMszf0toDPz0daC4XngmYNrXzbYav09r+lAi7GZbixgtSPQFxfIIU4G095X9/iQ7o/K/xfL95fr5dtv6UomjUNWrpaFNzjDgEaMVKzraa/GSiq1d7PSZFrIIFdZVPjh7SCw5h2xTJX62WW8zFbtrMMNOdCqwhL3Hmr7W/EKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wEYefmVAqNuqUiHfJH4In620kgRCTuiIpyd4bVqEXw=;
 b=O01n0ehNx6IFWnQpfmhwGtttptxQPfCA/a16IwzkqLHffkIt2EWY1/jNQuAYnZDSeGr1iufHSNeZubDrNMCkrRF6QZiVuW0n6RfZg0Njnsrj1vaOFjcgXWXF4E+XG3k/lr3MNxgMgU77e12y4lTrSpPlDv2MslaRByHUjQogkss2InkaBAImw5HVgZltwX+xTdocXi8SyC8KfCE0yD30KoYOKaeLLIKViM5rzZfGdZr1NXU8T1UhjlAsrmIPIrUgH6v8jkR2HzgwKxgBAyNqDDrcSBwjdUqhwcEoYTaNa9EZAdazAxGt2k2feiIH3uGVC949uXErGJ2TRfn2ZJhOEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Sun, 25 Aug
 2024 09:25:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7897.021; Sun, 25 Aug 2024
 09:25:47 +0000
Date: Sun, 25 Aug 2024 17:25:37 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [kunit, slub]  2377a7d90f:
 WARNING:at_mm/slab_common.c:#kmem_cache_destroy
Message-ID: <202408251723.42f3d902-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW5PR11MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac4dfde-dd76-4faf-fdba-08dcc4e7e708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dFa1sYv++ARRT67lpo1xr0XdxqJuM6k3wfHBrvjf26SW8i23b3ITHUTupLLj?=
 =?us-ascii?Q?576tvQ/IlEJH4eUmODaLJCh0FU2BCN/8IYztb9bssdcT8dqTSFTlyGrqRpA0?=
 =?us-ascii?Q?nEZPPo5BQia8jEaBlYNZNIcPH9eD/9kPxzMG6HHvfv/D4+YAT0/tuUcmpvDw?=
 =?us-ascii?Q?E/RO5DrBrPqn1kq67gcQiUR2G6EupUVkXXG8I6qoE8jOV9vB67LyYC5iiFhM?=
 =?us-ascii?Q?lETokV5nJaZaUzOfs3Rm6gH+sFATd16loa/gE59OjL7N/l2CiwSawgXEBOEK?=
 =?us-ascii?Q?xJC79taqXiyhcf+pSeoevBQIkj1iuQFmBljnbvkElRVIcsSl0oyKKYJgIknX?=
 =?us-ascii?Q?RVR15HZrgfK0lAV76Vhy0bha0ysg8cEMkt/O8+LWPVAyUNCGbF3vCPiGa7Hv?=
 =?us-ascii?Q?SKxzXkMbIigDR04hxrteb4Xui8Hv8FuzVkAp5yx9HxA1bWdwfBF141g7Hz1n?=
 =?us-ascii?Q?ksMHj9tUqgrVOhcxsLGEqeqcr//bhfFDHKbnlMY2sve1hM+xRcxEl7SzZLLK?=
 =?us-ascii?Q?z6ei2rop4Nw9czQmZEk6Ka0vPOoXggtUwd8CRqjP5pjZmSq4Lrd8GRvwZxGY?=
 =?us-ascii?Q?OgzaWGJIhKOoSiemly7yp//MSmfRWtt0JWJ0sSetmA/kqmmnMzYQXRgn4/+J?=
 =?us-ascii?Q?Y4iOOeyuQuEleboXIPW6gY685WyINUGnmfPZ8FqPMB9WBw1JtKLAjxiDLesF?=
 =?us-ascii?Q?f7UhTe2rywwQlbcyuaJOk0ozVl54KtSwtIHfjEz3V3GmFaA7/aJN19Ri9rfx?=
 =?us-ascii?Q?Ut3iz1KSKZ4JduJ45FH0tCuB2OegP/OHYcymv2nLc6hW/ltzD00gO9k29zlQ?=
 =?us-ascii?Q?GyZiUTGlzM20lyOgJfEbjMbct0baj5BR0+UmfNAob3pwjf3ONxM5TpH0NK5+?=
 =?us-ascii?Q?OiRhtOm388D0TKea7nL/BoB6RbIO9LYum2C5YIlf7XYGtDCcrIFYOLSOTx5E?=
 =?us-ascii?Q?5ZZxXwGkKss9azM1HRcocI19Z0X8dYVy4twWaTv43cgp6P7VT6k50J9bfaKC?=
 =?us-ascii?Q?g8G0DID7JIeEsifz88wxR3+qpuwUkYpIE50Mh2gWNiLv2LnVCB7tc+AQVorC?=
 =?us-ascii?Q?criwiPnWJ5SuvwiBWU+XmCXC6F6SJ9K+J9SY6LBrFUCArG+xSX91Jk0IO1Py?=
 =?us-ascii?Q?cB+KNlcZmstPMuOvXmTJp/T6YjZtwQ2w89J1fEip16IcE3Hi1Bt0sPU2xkqc?=
 =?us-ascii?Q?ESrVNHOn/LLcus8Gxv66IHfzNlCy83BmckuSvO4YqEvXNSJH0RMYPHiFH7Lq?=
 =?us-ascii?Q?jNuiDncU5KzSBIi637Hi4mNjKi5vvJpCdmPxLlhGkYzlWwJG4Zc/LG9Fi+fw?=
 =?us-ascii?Q?/0s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WuAPEoaa2dTE4Uzm1vbSC9ZjhGAvku4cdA06IIeQ3sGOXB+4XrQYCpw2Ho8U?=
 =?us-ascii?Q?KE1/6uxHSIJPThYSeWqn1fBKM5kNPBB11xZq+MqxWBfBRMn2yqgIbrKm4sdG?=
 =?us-ascii?Q?nMf+MksB9E/Q2oTTqYgRd/LAUVP37ZaqFWy+5t6CBXmuE7qqSZVLwzfjso7E?=
 =?us-ascii?Q?qB3IlxLDtYlh5WaaCTGd4tu8eGBSmM7zMzC1KSOkYWatArfYvvvRajOEXoom?=
 =?us-ascii?Q?5l4dlcIF+sSC3xvGiZcSlA47wmf3m4uwZJZuKbo256eb8okErbGDRbsoFGf6?=
 =?us-ascii?Q?JfdlxPwQnBg3jzGT/Z5VwePVPCqYkzG3aUQvQnUL4lDHShEaagxZ49rVL9jv?=
 =?us-ascii?Q?+1ZWnQgKGQSD70lLxeZCTTBXXXdWoVShG9BqCG7ZE4YUNJuEWn/hqzrG9Os1?=
 =?us-ascii?Q?NDE2DqgsMLoH1tYhotZQiKzN028LXpUtxfH/6gKJCjVKGBO2Lf/83Ol9xkRA?=
 =?us-ascii?Q?vzbrPI8EjdjqbYq41mDb9zOuUzu2qxue7aQYLz8e4IhaWbZPha/IgKlOgPoy?=
 =?us-ascii?Q?k22fQUvtd/LpYKeclhKJOajoaKMoJ7PGpuJaeI7xWvnV1R2hbW6Uixt28CbX?=
 =?us-ascii?Q?hPjQhMSV6TvtGf5kXaqmym4UGdk//VgymluBWR5ITfUi8pjoZFRTOjAVT6po?=
 =?us-ascii?Q?egIEfSfAoWrqgzOzDE/3pQ/eMIOrbN0hTm8y+OSSEIUb9PjQKIHLvPxNY/J/?=
 =?us-ascii?Q?yYaj7/4i/jqRVdlxPdP/NtK6I8GH7DjAvP/bjmp+Be5ffsCY6bQPUxzLHMO0?=
 =?us-ascii?Q?pfkhAW7n/z1Oom3c6pHvDt5fzat66ET3iwO7wrV0RaxQxLwXH7bT9nh36jOc?=
 =?us-ascii?Q?Io7JVqcE5wdhWqnTx3mYRST4jool/Jyl+CjQQnHmrMTDbMZjiyUFW3lZOhvG?=
 =?us-ascii?Q?6+k+uK6plFDe7mjfu9SuS2l6WObofSdKEncnILjoo2FlBrgtZFHHHkHrsCBa?=
 =?us-ascii?Q?VXgKVKznIP+jGC9O5ZOxU6aYEqbAMYKI5jXWbDd6FF8qdwmbc8ZyYX+6h+Ip?=
 =?us-ascii?Q?vyitTLQipMOGhOmiHZ8lQ56OVCrtdX+A3Q0sw+VMNkEYP9BEarm56JVtJgRO?=
 =?us-ascii?Q?eybeGSViIf36HEsOqI26uHg00aLgLTcnAlLl4RkZBtzl18Cs1kNvEkR3iVtj?=
 =?us-ascii?Q?lumm/+DB6ljIv2oMr0C/OYwQNRV37+vXKuNZbY5BxOAXgFHfEVEpTAXfY913?=
 =?us-ascii?Q?EXvFbzc2pjZJ4sF7Xap+xpSkQLUVV5a2TbB/lrvlj2S/Z94fduztwryxoc37?=
 =?us-ascii?Q?NDdwuLNjXT8NzoFcARGT00pE9nz9QhvafFnHKLFMydREe6EHY1Oxm7Ki0Igu?=
 =?us-ascii?Q?Rwi2beDpzcXvBKpcYSM7GptBkxSF//DLzC7R/Qyh7PndfO3WGFN9Vbz7adKk?=
 =?us-ascii?Q?x7m9Wkb2ELtlIyW/4JnI8+dLLAtOHf0Bj0t2HgL293ZRTxaMBwHeaRGtgmKs?=
 =?us-ascii?Q?NvLJ6JoLuuoaKb875em4q1Mj5877YCr8VRrieQHwSeRiRdeqOrFVcgsAvZo0?=
 =?us-ascii?Q?1lotuqMpVJc6PhPXlTTHB8gT5hcfJMlPxEVHkVMVKXulW/4p7BJLlG8bcNzp?=
 =?us-ascii?Q?Y3xCagO8sFRBsvtZmTbIZ8u6EwPf0zAHj2AS49ZCTlhIODwtmMIS+gJn6KFI?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac4dfde-dd76-4faf-fdba-08dcc4e7e708
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 09:25:47.5444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XcJAmkhs5bVojxj3AtRWvlS7R0mzPJPxlJTpQ+w5i1JU+kXyAlsqGSnA8u2jg6JT1g5IkNgyOw6mdfu9gmGnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5810
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_mm/slab_common.c:#kmem_cache_destroy" on:

commit: 2377a7d90f5bb2ccc302b5fb0e6ba4c67cf24ddd ("kunit, slub: add test_kfree_rcu() and test_leak_destroy()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master c79c85875f1af04040fe4492ed94ce37ad729c4d]

in testcase: kunit
version: 
with following parameters:

	group: group-00



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408251723.42f3d902-oliver.sang@intel.com


kern  :warn  : [  402.601850] ------------[ cut here ]------------
kern :warn : [  402.602683] kmem_cache_destroy TestSlub_kfree_rcu: Slab cache still has objects when called from test_leak_destroy (lib/slub_kunit.c:186) slub_kunit
kern :warn : [  402.602700] WARNING: CPU: 0 PID: 4936 at mm/slab_common.c:528 kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
kern  :warn  : [  402.605758] Modules linked in: slub_kunit linear_ranges intel_rapl_msr intel_rapl_common skx_edac_common nfit sd_mod sg libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm crct10dif_pclmul crc32_generic crc32_pclmul ghash_clmulni_intel sha512_ssse3 btrfs blake2b_generic xor raid6_pq libcrc32c snd_soc_avs snd_soc_hda_codec snd_hda_ext_core snd_hda_codec snd_hda_core snd_intel_dspcfg crc32c_intel rapl snd_soc_core snd_compress ahci snd_pcm libahci intel_cstate ipmi_devintf ipmi_msghandler nvme intel_uncore wmi_bmof intel_wmi_thunderbolt mxm_wmi wdat_wdt snd_timer mei_me libata nvme_core snd ioatdma mei soundcore dca wmi binfmt_misc drm fuse loop dm_mod ip_tables cts xts [last unloaded: rational_test]
kern  :warn  : [  402.613823] CPU: 0 UID: 0 PID: 4936 Comm: kunit_try_catch Tainted: G    B            N 6.11.0-rc2-00008-g2377a7d90f5b #1
kern  :warn  : [  402.615894] Tainted: [B]=BAD_PAGE, [N]=TEST
kern  :warn  : [  402.616872] Hardware name: Gigabyte Technology Co., Ltd. X299 UD4 Pro/X299 UD4 Pro-CF, BIOS F8a 04/27/2021
kern :warn : [  402.618338] RIP: 0010:kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
kern :warn : [ 402.619412] Code: 8c ff c3 cc cc cc cc e8 57 e0 ab ff eb ad 48 8b 53 60 48 8b 4c 24 10 48 c7 c6 20 21 55 84 48 c7 c7 d0 b9 ee 84 e8 a9 d4 8b ff <0f> 0b e9 28 ff ff ff 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90
All code
========
   0:	8c ff                	mov    %?,%edi
   2:	c3                   	retq   
   3:	cc                   	int3   
   4:	cc                   	int3   
   5:	cc                   	int3   
   6:	cc                   	int3   
   7:	e8 57 e0 ab ff       	callq  0xffffffffffabe063
   c:	eb ad                	jmp    0xffffffffffffffbb
   e:	48 8b 53 60          	mov    0x60(%rbx),%rdx
  12:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
  17:	48 c7 c6 20 21 55 84 	mov    $0xffffffff84552120,%rsi
  1e:	48 c7 c7 d0 b9 ee 84 	mov    $0xffffffff84eeb9d0,%rdi
  25:	e8 a9 d4 8b ff       	callq  0xffffffffff8bd4d3
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 28 ff ff ff       	jmpq   0xffffffffffffff59
  31:	66 90                	xchg   %ax,%ax
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
   0:	0f 0b                	ud2    
   2:	e9 28 ff ff ff       	jmpq   0xffffffffffffff2f
   7:	66 90                	xchg   %ax,%ax
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
kern  :warn  : [  402.622288] RSP: 0018:ffffc9000300fd38 EFLAGS: 00010282
kern  :warn  : [  402.623454] RAX: 0000000000000000 RBX: ffff8881ac7a88c0 RCX: 0000000000000027
kern  :warn  : [  402.624796] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff889fc3230b08
kern  :warn  : [  402.626072] RBP: 0000000000000001 R08: 0000000000000001 R09: ffffed13f8646161
kern  :warn  : [  402.627396] R10: ffff889fc3230b0b R11: 0000000000000001 R12: ffffc900009877c8
kern  :warn  : [  402.628741] R13: dffffc0000000000 R14: 0000000000000000 R15: ffffc9000300fe40
kern  :warn  : [  402.630015] FS:  0000000000000000(0000) GS:ffff889fc3200000(0000) knlGS:0000000000000000
kern  :warn  : [  402.631431] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  402.632653] CR2: 000056455377c3b0 CR3: 000000209c662004 CR4: 00000000003706f0
kern  :warn  : [  402.633979] DR0: ffffffff8741b384 DR1: ffffffff8741b385 DR2: ffffffff8741b382
kern  :warn  : [  402.635257] DR3: ffffffff8741b383 DR6: 00000000fffe0ff0 DR7: 0000000000000600
kern  :warn  : [  402.636580] Call Trace:
kern  :warn  : [  402.637518]  <TASK>
kern :warn : [  402.638397] ? __warn (kernel/panic.c:735) 
kern :warn : [  402.639368] ? kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
kern :warn : [  402.640432] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
kern :warn : [  402.641445] ? handle_bug (arch/x86/kernel/traps.c:239) 
kern :warn : [  402.642443] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
kern :warn : [  402.643469] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
kern :warn : [  402.644529] ? kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
kern :warn : [  402.645601] ? kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
kern :warn : [  402.646668] test_leak_destroy (lib/slub_kunit.c:186) slub_kunit
kern :warn : [  402.647868] ? __pfx_test_leak_destroy (lib/slub_kunit.c:179) slub_kunit
kern :warn : [  402.649054] ? __kunit_add_resource (lib/kunit/resource.c:44) 
kern :warn : [  402.650182] ? ktime_get_ts64 (kernel/time/timekeeping.c:195 (discriminator 4) kernel/time/timekeeping.c:395 (discriminator 4) kernel/time/timekeeping.c:403 (discriminator 4) kernel/time/timekeeping.c:983 (discriminator 4)) 
kern :warn : [  402.651224] ? test_init (lib/slub_kunit.c:196) slub_kunit
kern :warn : [  402.652347] kunit_try_run_case (lib/kunit/test.c:398 lib/kunit/test.c:443) 
kern :warn : [  402.653447] ? __pfx_kunit_try_run_case (lib/kunit/test.c:430) 
kern :warn : [  402.654525] ? set_cpus_allowed_ptr (kernel/sched/core.c:3025) 
kern :warn : [  402.655563] ? __pfx_set_cpus_allowed_ptr (kernel/sched/core.c:3025) 
kern :warn : [  402.656629] ? __pfx_kunit_try_run_case (lib/kunit/test.c:430) 
kern :warn : [  402.657662] ? __pfx_kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:26) 
kern :warn : [  402.658854] kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:30) 
kern :warn : [  402.659920] kthread (kernel/kthread.c:389) 
kern :warn : [  402.660818] ? __pfx_kthread (kernel/kthread.c:342) 
kern :warn : [  402.661706] ret_from_fork (arch/x86/kernel/process.c:147) 
kern :warn : [  402.662601] ? __pfx_kthread (kernel/kthread.c:342) 
kern :warn : [  402.663457] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
kern  :warn  : [  402.664326]  </TASK>
kern  :warn  : [  402.665053] ---[ end trace 0000000000000000 ]---
kern  :info  : [  402.666287]     ok 5 test_leak_destroy
kern  :info  : [  402.666297] # slub_test: pass:5 fail:0 skip:0 total:5
kern  :info  : [  402.667126] # Totals: pass:5 fail:0 skip:0 total:5
kern  :info  : [  402.668029] ok 1 slub_test



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240825/202408251723.42f3d902-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


