Return-Path: <linux-kernel+bounces-250135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 018CA92F493
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCA72845CF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FF211CAF;
	Fri, 12 Jul 2024 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+ljv4/E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FDC10979
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720757864; cv=fail; b=H9J6bfPk5eieqZjZLOjV6pfbLiqm55OzRxcK05zc5Vmx8F2r3FOMTEH8aRejZiDSN2H61H087q+mVSqbrodMtNv9Jf1kxOWC0mBmDzIFj84K8rROoP+TGRRtxQIlUZcd5FQ69nfLENJvbk2OQzSjSR7cKlMt0DtIp0kZ+nXW6ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720757864; c=relaxed/simple;
	bh=FZk1C2yV2rmiPyaK9YMZupBWpmbdHH72bs451fMYmPY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=MZE9LFg2Wrs4jCz8uyTEn3OTDC1JXOuGbExLYatLjJOYrfQqj57/nAxqVACwx5gEbAKeYbM41iolE9bBUR3klizsmHfmvgE/ghybUtcVrWCOeMXaugpKtqOzVpnQU74vCppX4S6BbBg7C8mfOpXtaM/p/e8ZymILrRSx7c2+2mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+ljv4/E; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720757863; x=1752293863;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FZk1C2yV2rmiPyaK9YMZupBWpmbdHH72bs451fMYmPY=;
  b=L+ljv4/EaNzJ7mAgtn1ClJAGupLRn0JAPxrap4fPlmkD3JZArDgpBGUu
   Bkwu4j54uQxaBRKeVGJAJzPaT+ceflf82WMRqEQzzPXjmBkoq5JrmPs0A
   Igzpg5myhEgLfBQXiASfF3UL8MzUUvJkbrnv4Esq6+u8oZmOMmOIKdJGS
   dD4szy78U0nRvq2gj0FQpdxvfiyPeS/jNIyzEahkqxG9I4boEGegDDUb3
   p3uWK0FM9qR3Nk6+9wR1q13zgsuzGkOtpieXEiNAh0BrStRaw5TbdCL12
   8IxZS3XWQ/pjoZDMyef4KWpFivxjUDIpVq+9P8Mx1jEcgTliFnWRyNkDx
   Q==;
X-CSE-ConnectionGUID: 5qjb1TS5Q9G+uksPjHGXGA==
X-CSE-MsgGUID: M5txFGCfQvao8mYVR5TSvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="35727810"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="35727810"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 21:17:42 -0700
X-CSE-ConnectionGUID: pHtaj/YoSJOqpFeK5QSLTw==
X-CSE-MsgGUID: f5wBgi0/QOu6qtIkc5uzCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="53167515"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 21:17:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 21:17:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 21:17:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 21:17:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBxepoc3PHDYbDshXIkz1lCR9K1JfAMFCXGNcipjmTiX3rLu2TlQTfiJKn/5pAG+G6GE9qauEQnjXKl8O1xHaBwKhD5Z21krx7U20QliaShwmtS5ibKOy/JeTiJafzmyfbct01w2bFgSffMpQbodhPVKDkMmSSgbRbV9UCn8Cw3LQ9obFkva/2QCqdxezOY83gWR6UTELCpGyaGewFbyNtCLF5IRo9neZfyl21paQf9saeths0+HNSZZyhzG49XnZLEDTgzjMvp5VAWbNw8J/vUtluWS8PMabm4JViTFVscLBtiRflUQRGD9BwjCe0vsaxvofTp+nnseK0gCUarZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuUfwyzxgxZz+4PNrQAUV48cSRzTeRBWwvnpOmDLwZU=;
 b=HCtoQBwCB58DV4u75YeRLuiiJ5NWp8JbI0c6R8Z97mPwtrMdfpKnRwEHgfOISSbrxCHtDZitae/UF8u6RkDQxhsyscQpVdYzoMDzBYGWIGgAFvXGdbr5NilfuiIH/YuO4SJSygd0k/ObCw64wkC4qDqW1ClYGAJUrxanYj85KdiOM1sd6AERp0HYQnRHrsMJxVzxSUzwpr3quYYt6r2KAeuXoX0UzuPr+8VWHxEc9kbb8q/3Yxddc6DGu+OnDifyLCey31vnZ432qG7lokSQGQzxx9XQooFdJVO0He453NZ8t36zMCvP5uhcPrynYiJZ+AerVQ/nvpWI2GeM7ck2JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 SA2PR11MB5194.namprd11.prod.outlook.com (2603:10b6:806:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Fri, 12 Jul
 2024 04:17:34 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 04:17:34 +0000
Date: Fri, 12 Jul 2024 12:17:24 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, "Gustavo A. R. Silva"
	<gustavo@embeddedor.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240710-cbc 1/13]
 arch/powerpc/include/asm/hvcall.h:697:48: error: structure containing a
 flexible array member is not at the end of another structure
Message-ID: <ZpCuVKUPjur+Lr9B@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|SA2PR11MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf98781-c975-4774-7ba3-08dca2298dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ksWs1hqr2JIzifZ/JiojTnFbtjL7ffJOqv3xRDxH7kUsB57VXq3K+CdIUq6s?=
 =?us-ascii?Q?ScBFaK5ksaHO3lHVd9E+VWpn2TPzFoow99CSiEizodAYNdXDV54B2Lzh1gtK?=
 =?us-ascii?Q?BlfV/0CuvlztyavYV+cfA9PkGbTXCs8JWXzEqy0M3VcJFGz2jodtCbUamzT6?=
 =?us-ascii?Q?ZtkaZtkGxfgu71gXDMzSOHc4Cj2VQdGvsn86PB1dnMwwfupOWaBSWd3MuD5o?=
 =?us-ascii?Q?rgF7W5h1VpHeSfTAbFdDQj8qbj6xclSIeHfsS2IuRG2Fbnu2jEScKcReSu0P?=
 =?us-ascii?Q?hg+M9C5FoKUbppnEfn9q8qVkXi5dBi7+tSj0iE4plW1yCwvC01MSbme1EQ2a?=
 =?us-ascii?Q?pG6xiBvOajvg04VGTtSuGHIcYptevQ/t8wLqs3J6WpKLs3D4mvEkDWFQPvA+?=
 =?us-ascii?Q?N+WixNdt99D6LUYI03CO5V7v335Bhc1W74s0GbKN1sIB/g4jQGfHjF6Mwzf+?=
 =?us-ascii?Q?PwF6QyZGnIc5Y6dGkbftBjUSX7717GKcKiQHqEF5Jmlv1ZHbqJpjbHXUVdcB?=
 =?us-ascii?Q?1/wwEpUv8sc2oeRZepiNBCtKwh/fyNSWchw1VHj2YlHLdS8siA0qiSxKgyQS?=
 =?us-ascii?Q?b6YWhMEtvEDfaOqg9NwggeoMcVnWwi8nyZRrTgSaLcu0CgC1sOhN7bzUM07m?=
 =?us-ascii?Q?C8g2jFojsfMexoKpQucA5SVyYdAGs7y0Rzz654QQVM316BpxRl83N4o822aM?=
 =?us-ascii?Q?RwiNN+eHjfDdnEjr/Vlr1Yy5mgxkW84Q80zwoC42K2cqDmrPBEypBbWkQT3C?=
 =?us-ascii?Q?BYm60keSUTM3lB61TkNvzNfUykicZdJP5cxaM8Y5rP8nKhFVbGVwQ6KCNLgK?=
 =?us-ascii?Q?KvgErkRt3V5B52cjnYN4XQt6P6OHC5uvIsPdvLJTqlyENX+SfsusCgbvKfhx?=
 =?us-ascii?Q?9g/x+IJGQdjyOWvKY9M6Y+MnNB+w85Gid92j41bB54lECooVZVSxZVwzRGXY?=
 =?us-ascii?Q?Ul4Q8U7OAsKMGdW1KMXU04jJnboObyf/N5uW5ovLxDwYav95pGfhy4bOQTJv?=
 =?us-ascii?Q?/pdi98+O4o1BZlzGbd0kOtor8kALhCD4FHOEgFUhLQ8lGN6iuYE2296XuUsX?=
 =?us-ascii?Q?iGle2anUshedpCGpPI3X5xxr+jxMlkZkAQkub1qCm1sxOkVxPGSbgaQ6mzVj?=
 =?us-ascii?Q?LCayIYRlw8ZIZaHMALgR7iJ9P9p7sWE/htf3xPKj21y7Fmu0wfDyClcDR+SX?=
 =?us-ascii?Q?em3JYj0TKrKIb+Gv8/yWtoAGAUvvePkD0C2q7DvWG1DxTD+M16DOMNnOWFAc?=
 =?us-ascii?Q?GrzBX5uDSdrCd7FcmIXNLV6OoikCfFCJ/qaHpeMQamBAJNCeWt50if4Gt5XC?=
 =?us-ascii?Q?bBt18Mzx93W4kgQn958I9MsB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qaPuPSzY1oPNWiD8fg+/TL3HFFKekzFjHQq/qxrwGHDT7SDSSYzDRNxnGLXg?=
 =?us-ascii?Q?0D2gd0PMpVbzeBhvU+K44J1Er5k0UM67wiJ+HfkwRwcKulpfXbE3P4a+s48i?=
 =?us-ascii?Q?bzCAJsRFlsOAB3OsilBafbbRW7mAqLyeFRirWvUy39dW6Z29/Z6e6KHjZPh1?=
 =?us-ascii?Q?OU4+sS5D8lmlVw4tI0nDa2KmZUBsNAykUoibfyTB6M224cf/+aiGKmYZ2myg?=
 =?us-ascii?Q?/xlPiIO/UhOYfhj96EMI+jETDGdpguheCbeQjKHOYrp4ASWf9p2UXvY9dZiA?=
 =?us-ascii?Q?joQPJDX05pDmc6tIUfSRiwmEybKprHV566Lgx5mTzpOot//M+jLThmZtc3ni?=
 =?us-ascii?Q?5AZWnVhoZ/KkFz139NGu7R87qmiOQ6HW58/W2PPT3cFZBj4Wxi1PeKFzSdTa?=
 =?us-ascii?Q?0gY16HLpm8ZiAbMlICj85ylEEIzIYCX4GR9nU0UboZoyCG8W2CtgqEzelD/Y?=
 =?us-ascii?Q?DYaZi9MomWSxqZVZ53CsiQPbn4RHKyTyl18xwUafjWcYTduBsTWD0VoYeCVr?=
 =?us-ascii?Q?29LiX5vwYiRQNmg+jrW4GQEakeRF4TKtYiEwLMRET1F9tLfonEwYZ4e3cwJi?=
 =?us-ascii?Q?sTsoaxJGFvo34U839YemMfPAyprp9Ze5KofMwgV6w9kEl3GUR49ItBmeTYLC?=
 =?us-ascii?Q?CatSL+A0vW2/7v0xNqE+8ewru0T5NHvsMCXoMU4KSRZBPHHX9XPIXpejJgqe?=
 =?us-ascii?Q?eHlQo7LIQpUaNan5iH96KkE0INff5iq7ASIdDferl6/i1MdROrnnjsUlZldC?=
 =?us-ascii?Q?p+FS79LrupFNMyWWkOMP1DlPtVwMObvaPW6vKkhPsEgsyYxNiIScf772ueFq?=
 =?us-ascii?Q?y6ygaTdmn7VQ8MsrLmzBoIM9BApd1Yi6i7GjN9xzWvNHoe8qDZKspaCGtI19?=
 =?us-ascii?Q?4/R/wBrZnbF1rHaCCyJwMm+BmRVqqR6sv7J96mLdQXXotRdhxkiJSFxDlAF3?=
 =?us-ascii?Q?Z17RNEAyxrxTUYesLYmMX6ayH2GvAeBDM3BaHmKMWZLQX/+9hN3rVF3V1+5h?=
 =?us-ascii?Q?vZmF33lG7p4u0BOfOSF4gpNIAAjsTMfw64/y8qLrGsIiniymxe0C3x/wcuwi?=
 =?us-ascii?Q?WxHITUusIRpcSn53m5R5nIb2BEDralVKlSxyBZiByxF0Ll2MQHMdaFjxxhZ4?=
 =?us-ascii?Q?HtqZ2NAapnHvNR8GZmA9U+3zd8sPVxYu2gTxa18nYZIbEJjwglsQmUZktH8r?=
 =?us-ascii?Q?4l4ItvO3h4FmIUI8RBitNjI1GSpqPcgeZdV1E14xe2Ka+vYPSAZJolmUcgs9?=
 =?us-ascii?Q?2Eki+FQWxk+cO58B9Q0I2YUDra3N+kyk2SaSuKGbtV0SqTPvUMCuoNE92RLW?=
 =?us-ascii?Q?InjdqQYIYubxUf9zl87SV/XkLJaEnpm7bos/HKs9MJJCT9tHErADQIBCwnvA?=
 =?us-ascii?Q?tYnMAYDUNnLgVSYJLpzX1Y1bdFDMGqulDaLkx1TODhSccghY1PxofUMrLxu1?=
 =?us-ascii?Q?gW1MhUqszIbtk0PYlippYnj4+onO6b9ZDMpjdl4b64/SFbEq11XJ3cLNKqik?=
 =?us-ascii?Q?X16MkJKlX5Z1T34hP10yUltw4msmBmWsHe5RHClbAS0/dNTShB0x+EzUXj5E?=
 =?us-ascii?Q?fAMOE9rIFhjfPE0KeQrdxihLcKnM1yEJ79wUVIkg6x/mxsqJhuqd6vbLfODG?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf98781-c975-4774-7ba3-08dca2298dae
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 04:17:33.9684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAp6AwPsAhXtj6oRm5qxJjxoElx1CzuJAPQcQnbGVtyerzSe9ks9YIptTDOm4u2u39PjzTSkEs47xhnyj2LxMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5194
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240710-cbc
head:   811bc7260e24cf06adefdbf8debb2a83d213e02d
commit: d692eacf807861f523e66bd7d1c60f5dc254f4c6 [1/13] Makefile: Enable -Wflex-array-member-not-at-end globally
:::::: branch date: 2 hours ago
:::::: commit date: 15 hours ago
config: powerpc64-randconfig-001-20240711 (https://download.01.org/0day-ci/archive/20240712/202407120418.bob8U4Yb-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240712/202407120418.bob8U4Yb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202407120418.bob8U4Yb-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/book3s/64/tlbflush-radix.h:5,
                    from arch/powerpc/include/asm/book3s/64/radix.h:18,
                    from arch/powerpc/include/asm/book3s/64/pgtable.h:298,
                    from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:32,
                    from arch/powerpc/include/asm/mmu.h:378,
                    from arch/powerpc/include/asm/paca.h:18,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/thread_info.h:23,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from lib/test_bitops.c:10:
>> arch/powerpc/include/asm/hvcall.h:697:48: error: structure containing a flexible array member is not at the end of another structure [-Werror=flex-array-member-not-at-end]
     697 |         struct hv_get_perf_counter_info_params params;
         |                                                ^~~~~~
   cc1: all warnings being treated as errors


vim +697 arch/powerpc/include/asm/hvcall.h

59562b5c33d6ff Scott Cheloha 2020-07-27  691  
59562b5c33d6ff Scott Cheloha 2020-07-27  692  #define HGPCI_REQ_BUFFER_SIZE	4096
59562b5c33d6ff Scott Cheloha 2020-07-27  693  #define HGPCI_MAX_DATA_BYTES \
59562b5c33d6ff Scott Cheloha 2020-07-27  694  	(HGPCI_REQ_BUFFER_SIZE - sizeof(struct hv_get_perf_counter_info_params))
59562b5c33d6ff Scott Cheloha 2020-07-27  695  
59562b5c33d6ff Scott Cheloha 2020-07-27  696  struct hv_gpci_request_buffer {
59562b5c33d6ff Scott Cheloha 2020-07-27 @697  	struct hv_get_perf_counter_info_params params;
59562b5c33d6ff Scott Cheloha 2020-07-27  698  	uint8_t bytes[HGPCI_MAX_DATA_BYTES];
59562b5c33d6ff Scott Cheloha 2020-07-27  699  } __packed;
59562b5c33d6ff Scott Cheloha 2020-07-27  700  

:::::: The code at line 697 was first introduced by commit
:::::: 59562b5c33d6ff3685509ed58b2ed3c5b5712704 powerpc/perf: consolidate GPCI hcall structs into asm/hvcall.h

:::::: TO: Scott Cheloha <cheloha@linux.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


