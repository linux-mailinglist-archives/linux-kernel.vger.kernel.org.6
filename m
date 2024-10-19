Return-Path: <linux-kernel+bounces-372593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B082D9A4ACD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 03:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B61F1F233F0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0111991D4;
	Sat, 19 Oct 2024 01:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDCXYQgN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9DF1922E3
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729300256; cv=fail; b=bzkpgHYjMxX7FP6CIJTs4sYO2JVAQK3NiCzTN0J7cJE5XmqpaVKVCZIt9t+iPu6q57MsXjH6dwMWkeJ9GedWBoBQp5n4cz/Z6XIQRa0Tr8711uTrC50GD5CSzv/IfbRz7NV59Ohc3ukw9P2l1cRfUtXXv/EardhiC9VVsb6SVVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729300256; c=relaxed/simple;
	bh=MNy3kq1zPOC3UVmE5FMqqjmGdzXWg5ZstWxB+rIQusU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Tca1V3+wM3imD9RgYE/8/aVWaGU44FuF2OPteau/pKOqWF9u7x4rUO1UqexbXTkYgIVtQ8yagbJsFcyLAR3GXa9lSC3YzOgg46LvlTp5yKGBNyQY9ORa+cEw7dmEH3Y3qsJCBneFZSLubuWmU1MXtyi2yco3Fvh4e8rCIfsF+0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDCXYQgN; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729300255; x=1760836255;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MNy3kq1zPOC3UVmE5FMqqjmGdzXWg5ZstWxB+rIQusU=;
  b=nDCXYQgN2OwL+BYjwBZG92e+xSxIJaBFbFsQzwNyZmzF6Pbsc5vawnNY
   4wx1p3FNxDZXzp5Mx/k1QKPqd/FsE8RAupMzuBHTzoQg48u8Q7AJqNNKX
   aWKg3v+kJjVZujdAnWU/HPACvvA4zW3kYOIkc11irrtSEKkmj1krnF4XJ
   hgs4JW3jIC8AqnFfW+l1p2j1pGZ/8C/QgEfxH1JwRt4Q5W23P6kNrAAy0
   Ij6gtQO6jAawaiAqYe3Gzm1izImDzPbNFKoUvpJp4K7kNFMukruPU3GRq
   r18SQ0u343Qkuqxm2tqtSf3hbZ2XvzkselQhvK+5fKF8A7i3vIehzk0AK
   A==;
X-CSE-ConnectionGUID: nnNT+nDISaGfwZhyJE6lng==
X-CSE-MsgGUID: TFi2zgJnSfmZ6LzCjWmy2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28803722"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28803722"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 18:10:55 -0700
X-CSE-ConnectionGUID: dI7jcHtOTOa10nrn/lJpsw==
X-CSE-MsgGUID: KciZ7SzcTT6MLBaB2hMpFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83844442"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 18:10:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 18:10:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 18:10:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 18:10:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 18:10:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vj88HQqsz71dOJOTyaaF519yZKsTBJ0H5ArnyiGOxHOooaJFNEUthQZKzjRlFRVnImq5SMOctG2UN4DWLcCtFxD0ZJb0K7B7/kWvqTmK2J97I0mkUB9YZbz5cPOj8//9d12LTE5/a1QLIEpdVrjQY2fHvJSbRbEf53qCzTjJanS49ymfrYnozTs6XXT/gRtoD/McEZDxYajliqRujqKMSE+7C3VT/7JTwCujnvDeJd2sS2aD0PZ1Go6UoEc0La0triXL/iZaK6DcTmlGGBccRMBTP1NFT1/vRttsPAk2hw4RCicYxLz8AItLRcz60OVhrzsn7AjH9njddX9x6X0BbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pRKQ2uWfdclKKDFmgw0xMyWbMtB2yLu5NHIFu6HHSo=;
 b=vvOtpJWmXG6W2OXHySpAlXJpP2McIoqdPcjg+/O3IvmtLYkCtsT5sYj00nZWJZxaCALqfu5Fa9tqPfahSl6p/1xpGWi6eqkUtBIpHRpkr1SJnQjRRtS1yXGwi56HCkGnN8j1Cr8FOB7FPLTHISGXpJUO22QqPZbhM64WHb3xhuf/IZ14wvAiRcle+FdjpWetkmjQ9L3lVUod/aSGNeBSL7aJbBb0QSEsEGv6a4ECv4p+JaufxE/uXnJ4RMJbdkfQydCMdJ5f8Pi9Wtxwj9fR4r15tKt2xemkntRjbKGtMb/K8swZAtiRWk7KGEXVizyKtSkcWjJXzZC72tcaVInbMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by SA2PR11MB4938.namprd11.prod.outlook.com (2603:10b6:806:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Sat, 19 Oct
 2024 01:10:50 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%3]) with mapi id 15.20.8069.020; Sat, 19 Oct 2024
 01:10:50 +0000
Date: Sat, 19 Oct 2024 09:10:42 +0800
From: kernel test robot <lkp@intel.com>
To: Hugo Villeneuve <hvilleneuve@dimonoff.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Rob
 Herring" <robh@kernel.org>
Subject: arch/mips/boot/dts/ingenic/cu1830-neo.dtb: expander@0: $nodename:0:
 'expander@0' does not match '^serial(@.*)?$'
Message-ID: <ZxMHEvD+ALXo+vQm@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|SA2PR11MB4938:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb78d57-120c-45ed-f2c1-08dcefdadf2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YDuHuUIQUEPVIK1Qz9FwVix//twfiSJo6HExbI/p+yH30GABvz9lIfEhAfiL?=
 =?us-ascii?Q?JYvvqg5dMvE57P6TahapInBhQDxY7iaKdkyzD2A339P38QH7dPbQbdw1+abw?=
 =?us-ascii?Q?jPhxAeuDLtk603dmChX2Mp7ncSDchzGLWych5Gz6IQ+eUUfiLzDM8+5OCbP0?=
 =?us-ascii?Q?5ZfRg6Ffm9BeQ6sExjwwkqfddBf6RpI3z+Zl8/XNoHlnigotJmKi7TrWZy75?=
 =?us-ascii?Q?23Xpwx237+22w9Ikiiy8/TGr3eCKA6I5Set4G5Am9fGp5Z+ksGAg2iLVDz68?=
 =?us-ascii?Q?8pFcaySGGgcAYaP8LsB2rx1rdRH9jw+z9MxCpzKtgyjb8ft6y6eV9NcnkVP7?=
 =?us-ascii?Q?oidrz3ZZ577On1pi8/RKKnOidv6rdKbaHU8XEvgRVEzZaLY6X62jSJdBrOov?=
 =?us-ascii?Q?Rw/eVFP2IGH8xYaUv8/vSa39QDpiGT/9R5An77r5+NMUiZ3/hhBIcHhpS78W?=
 =?us-ascii?Q?D5lk8Fgnnh9tE/BAApoQL0af0LKrm6SWJpDBOe2coMn2C9oujz7KkrZ6Iwc8?=
 =?us-ascii?Q?reLfW8zg3EXEsyOeGM24lvMy6rLGPP+CMoxG4k41mZRN2PflVqzd/LxVmE92?=
 =?us-ascii?Q?qJxayn8w4XZK20hghQ2nkmzZ4YQlvS+BMIAiqXEzgK6ylZd2Dt9gLh5cV2Sh?=
 =?us-ascii?Q?Yu4a3/eRyBYd8dowvYRo9J3knf3fSb7GWTdjqVprn4AFRsw4NZ/H6LXrY3z9?=
 =?us-ascii?Q?xZ7VwibETAdRgTRxNyqI3LhvxcOm9jD97IUYlv3wHF+XfWLvTpOoqW/NNE4+?=
 =?us-ascii?Q?s/bnPJrbN7bh3hOkePPtuipXKBp+BePvswqvlRTDgoMZW6Rdur1dxc6PjqTf?=
 =?us-ascii?Q?a66ifQJlI0p9t36zVzd5ia/CSKPWbEOi0kkoEHhjJSvt1+k8WZhJPHsqGuq6?=
 =?us-ascii?Q?04+nglcYdFtv9Ch8IQbzT8nZ1RXnn3LVhvsoTxoqch2p9H5fuXXaz1GSeXGY?=
 =?us-ascii?Q?KedDsVgeozQEprtbSmcAWqClVrmJ5S+U1Sk2OKRhAKWSc586N4h40yaCg9f5?=
 =?us-ascii?Q?Q+SXGQmvpSne+DhbXMujAULMKahprqhgxLx/qU8N4aJr7aFeH4xUlNSF7abB?=
 =?us-ascii?Q?+EZWyP8UyZgdYOveTgykgtPFLIyMSOdm8EskkJQ+Xd75IpIdMTE3Lswo+eGA?=
 =?us-ascii?Q?9lycqbdBc8gjhQY6zhTWRT2fUrkr3MjD0/mn/cY1XQ7f+PlmhSZxHrUaeEst?=
 =?us-ascii?Q?ImzNcEEQF1yWDYyl/i+Y6M1bpHepWND+zI2qgCzqkBCr9MNYIG7dRO3Fjlf/?=
 =?us-ascii?Q?k5QbggKNXXNeumzljmRutr/4S0k6Eacqvo1T3tFvwD1/ESTgxjf7yVVukRxR?=
 =?us-ascii?Q?AkLWWRGblnHx9kyi7K/3ohzj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+/9aHRF7iU5e9lJFKBXBjaQ5eVVKU/nIQp0mwTuUTCN5E5XwDZdkM0VU6rwD?=
 =?us-ascii?Q?A/NikUvx1TBYsoXQa5N/znh/ZTi0rgNZp7wdgsPdy0wnJhR1+jrccYf6O0p+?=
 =?us-ascii?Q?2M2P6AjtlIYNAfrc9QQ/NQ05E17VhAYqYd8KPbS4elFPIc9utFyV0VCfB+2K?=
 =?us-ascii?Q?cC+ZhLyfnvQnJtdRYYSkkmW6xkjl7DxOFluEE8CVjboKFlrHhYhunyix43Zi?=
 =?us-ascii?Q?n+s0XGegHPiEysExbNsoLDs46DxHssD1udCVGzvQvoeSGvm3VQntVSTZKeDK?=
 =?us-ascii?Q?OakmAL1BPC639Qz7jCddLjQhBwTqk9dhI4+N8apqQdY7I2E6Q63NxYDk8uil?=
 =?us-ascii?Q?vaXPPC1a6+aiQ1AUI/+/kIuo1TNOvry4dkh/oafclenNJ3HTPRE3qUsYd6bk?=
 =?us-ascii?Q?8zgavGTU7YytNRXyjjBzCuGGlHa+ICX4NPahtICzfdSOHmDw9AieXle9DPJo?=
 =?us-ascii?Q?0OU//HfYlQdT+K1msIMU4Sb5hCHU+V9xOm/lOyU17Im1K+flCcdagTxDCGCj?=
 =?us-ascii?Q?sNEOHQ2oPBmYmRqXJo1tFNVpGdolvyaw10Tl8s79KeQbtjp4gIiC6Rp3wDVN?=
 =?us-ascii?Q?T5gb3t19Zbjx581VX9szzE3g/DNpOa545THS8eHeFvvQ2tgDzDcjRsuOnAAx?=
 =?us-ascii?Q?P4MdYWSkz++MwnHu3hG5/mciu05btq3dsx0DaVkD1orZTvC1GtNJm/d6+ITU?=
 =?us-ascii?Q?BW9BfnGUp5QcfjRh9xJE7dSdJ7+07/Cs5wQh9yBXZENilvEcaWaA9GKjYckC?=
 =?us-ascii?Q?+dL3TkjPABzTYQTLJc1fn6yUnF1pILZnyC0ly9CcFuql8wZJ97L9z1TGd1TX?=
 =?us-ascii?Q?/xpRS5e0GizU1ZYRObTGc7MkKrPGzyT5NLyWGCgcKCfLq/3GCXoVjPLA1Pdv?=
 =?us-ascii?Q?CUJOzOEgdWzyGND+NsAIufSzkuvIQi1LbfMyBVoDhPQWziP1rQyl/0Rl5EXf?=
 =?us-ascii?Q?se03gS6rAILeO6cu3S9zaH5ozEVSFlDzWP4WJTffCzZz8LBGKI+lbS8dt2Gb?=
 =?us-ascii?Q?hbZzD7I3MCJ5vKK9WNp2T8p3Zvn4UTihNhO7FOczjA/FTTpbSTPJwiR2s2RN?=
 =?us-ascii?Q?vum/1WHuqEIO4sK9/x6SW+q2j0yrS/WGQ0gTTkM33jNzbfWOdQPzFEGulzxq?=
 =?us-ascii?Q?YD+00T9sYCwegEgv3SQ84zs+smWzutZcvLXxbEIao9o8344TDNWkWH/aM5HB?=
 =?us-ascii?Q?bdUgO6Dmtjt1Pa/vePbu1nfYxToV952oz/eoannvIXaM+9xWifkdPcpPIEns?=
 =?us-ascii?Q?wVZRbOznE7yBAOEu7c0XzUVxPm50o1RDV2qfES2FqOtvyNeH8KAlio8f9TyT?=
 =?us-ascii?Q?3cmfrhNcf+1Pu/Ns736q5/wnJkzxXfLm9n4+FcAcRUVeDkSJfevNxr32mUp7?=
 =?us-ascii?Q?WsS4oEKNAcnH1xqbzEK5P6KYUoVO0+5Lgw5rb1KW1rug3IhS7QxWPp5Bt2ut?=
 =?us-ascii?Q?vX5+9dJ8to509r9VLeilRK1WR1FzOCKfgRaTi4rGo2JDZ6aZnacVdLcQsl/s?=
 =?us-ascii?Q?oQjuZKGkpDYFk6vbp+MFvZlR+1dlH9f2HqUdhh4xHPi4D+kIWA+CSpS8jIyE?=
 =?us-ascii?Q?I3fHSz8i8vhD92jbpzm0nPR7tBnw+h1lA/apuDn9ohlzz6gSFv29oMqA39Wl?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb78d57-120c-45ed-f2c1-08dcefdadf2b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 01:10:50.7540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4C1k2rZK0YlV0yk/cTSfX5lPEPOrdOio+DGhviewRrqC+q30Nwmad3wYcuM9JgVIbTgH0UJF3qn1qc0ZXg+esg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4938
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b04ae0f45168973edb658ac2385045ac13c5aca7
commit: 0d447e927ee86e9ff89010085a47a275c2bb5594 dt-bindings: sc16is7xx: convert to YAML
date:   1 year, 1 month ago
:::::: branch date: 3 hours ago
:::::: commit date: 1 year, 1 month ago
config: mips-randconfig-052-20241019 (https://download.01.org/0day-ci/archive/20241019/202410190534.u1V9W5Lw-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bfe84f7085d82d06d61c632a7bad1e692fd159e4)
dtschema version: 2024.10.dev6+g12c3cd5
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241019/202410190534.u1V9W5Lw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202410190534.u1V9W5Lw-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/mips/boot/dts/ingenic/cu1830-neo.dtb: /serial@10031000: failed to match any schema with compatible: ['ingenic,x1830-uart', 'ingenic,x1000-uart']
   arch/mips/boot/dts/ingenic/cu1830-neo.dtb: spi@10043000: compatible: 'oneOf' conditional failed, one must be fixed:
   	['ingenic,x1830-spi', 'ingenic,x1000-spi'] is too long
   	'ingenic,x1830-spi' is not one of ['ingenic,jz4750-spi', 'ingenic,jz4775-spi', 'ingenic,jz4780-spi', 'ingenic,x1000-spi', 'ingenic,x2000-spi']
   	'ingenic,x1830-spi' is not one of ['ingenic,jz4760-spi', 'ingenic,jz4770-spi']
   	'ingenic,jz4750-spi' was expected
   	from schema $id: http://devicetree.org/schemas/spi/ingenic,spi.yaml#
   arch/mips/boot/dts/ingenic/cu1830-neo.dtb: spi@10043000: Unevaluated properties are not allowed ('clock-names', 'compatible' were unexpected)
   	from schema $id: http://devicetree.org/schemas/spi/ingenic,spi.yaml#
   arch/mips/boot/dts/ingenic/cu1830-neo.dtb: /spi@10043000: failed to match any schema with compatible: ['ingenic,x1830-spi', 'ingenic,x1000-spi']
>> arch/mips/boot/dts/ingenic/cu1830-neo.dtb: expander@0: $nodename:0: 'expander@0' does not match '^serial(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/serial/nxp,sc16is7xx.yaml#
>> arch/mips/boot/dts/ingenic/cu1830-neo.dtb: expander@0: Unevaluated properties are not allowed ('sc16is752' was unexpected)
   	from schema $id: http://devicetree.org/schemas/serial/nxp,sc16is7xx.yaml#
   arch/mips/boot/dts/ingenic/cu1830-neo.dtb: spi@10044000: compatible: 'oneOf' conditional failed, one must be fixed:
   	['ingenic,x1830-spi', 'ingenic,x1000-spi'] is too long
   	'ingenic,x1830-spi' is not one of ['ingenic,jz4750-spi', 'ingenic,jz4775-spi', 'ingenic,jz4780-spi', 'ingenic,x1000-spi', 'ingenic,x2000-spi']
   	'ingenic,x1830-spi' is not one of ['ingenic,jz4760-spi', 'ingenic,jz4770-spi']
   	'ingenic,jz4750-spi' was expected
   	from schema $id: http://devicetree.org/schemas/spi/ingenic,spi.yaml#
   arch/mips/boot/dts/ingenic/cu1830-neo.dtb: /spi@10044000: failed to match any schema with compatible: ['ingenic,x1830-spi', 'ingenic,x1000-spi']
   arch/mips/boot/dts/ingenic/cu1830-neo.dtb: i2c-controller@10050000: $nodename:0: 'i2c-controller@10050000' does not match '^i2c@[0-9a-f]+$'
   	from schema $id: http://devicetree.org/schemas/i2c/ingenic,i2c.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


