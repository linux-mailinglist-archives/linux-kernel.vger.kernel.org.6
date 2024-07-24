Return-Path: <linux-kernel+bounces-260555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A7393AADE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74EB1B21D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D3C10A24;
	Wed, 24 Jul 2024 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbxnk/c0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB32917C6A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721786647; cv=fail; b=RjHa9Qh7+ZKhGOufwkJ1IFLcG4SwNGTWNCuYiIP4cUyu76QZ4fD3yUSUKDMZEkZmLVV98QO3SWN0oAcKxQrWa0T4b3g0KMJ86i4+6MGKR43PKXxH3Co8HQ7LSoRh6Kp+6iuKDBghep5xIru7/FwhytBHrapjqfzmueKQdu/r0BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721786647; c=relaxed/simple;
	bh=xwksn+xIoJ8dD1TWO85Xf9JHdlPzMUPfhMInXrqofvM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fb0jZ3ITjj8gtCnRVWMs1FBOQS0qgsEe9xMo1YGCmVqzySgUMc+Z/nj/G87/bfV1LmmIsjc1rgEfD3wofbaTi1NM65RjdM7cAGiy6++1UYnqn6iZbyQsO0pwW09UucwW3B4eFdYMpAfyojv7BCTlL9Aq3b+9IWyt6HNMckc3nbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbxnk/c0; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721786645; x=1753322645;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xwksn+xIoJ8dD1TWO85Xf9JHdlPzMUPfhMInXrqofvM=;
  b=fbxnk/c0PWk4YboWyzJW3EPONkU3w4j6qFUw6zxySuGXw7hOICJSIby7
   /7SHkGnrA/onuGrvYr10IMiaVD35/EHvRbmOXGZLltR/ixkOVkWJlVFVb
   TkOv2mR8OPEuYIGxEOAksoySyacP84kzKRpnBhc0CLwPptkNBKwPLf9Sf
   8rx6TkT5czAFeY6N5V78UZlzTKRb0NnPUPk5uRQAfDB80wtzyxjfpCmEL
   /50doy5WbYOCriSzyB5fGY+2lq0KYHP+UZ/pRnw3ELSy6J/4yUEcwOihe
   lCHhYFnucyTanSPj8osAUruBh1Wm1xW0Mc08WisVkxHR5mcvUm7iAQZbq
   g==;
X-CSE-ConnectionGUID: en6+n96STf2J5VtjnSADGg==
X-CSE-MsgGUID: BRtro4x0RnCZtfiKVv0UVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="30822867"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="30822867"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 19:04:04 -0700
X-CSE-ConnectionGUID: aS9mjzebSGK0J6gj+znTgw==
X-CSE-MsgGUID: mhhHv5jvTaybazJNXM6mwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="52118306"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 19:04:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 19:04:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 19:04:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 19:04:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 19:04:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lX9D3lFuul5ubKG6Lx0VIIHhrllAfFHM7JPifAk4URBlX7Nm9Yhg3vaovTMbzsK4leDrKc10h8G/z1hVuXZPsi5ZQidsjhRLHLhbT43clTpfyGRH3MVHwtxmHKuZ+g9G/QOO4D4K1EZb/yE+2Aknz1VqeAYN2FnRdWifVYODGpIbAMJg3sxP2SnKLMWGm7Zi+FbzaMQlUnQlSCZF9YYbIIB5JvUTM0a7UKyQXxWDBHXbDU+x70AkyDSoKpBf1dLiRq6G/rCVazVzqDEHGkDZed+gEGob/QBdEdRpAOw9L835npgd49/ZmcYcvTxd0BlsjOPxk35/TLSJV/JWdl7jzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKnME9kjqN2bFnagRN7xPEqkWMF+BqNmU33QP393RDM=;
 b=ToixRBh4OhH9ee6wwjQVAp2KG2U3DbnTLwJj4QUIoJkAUvTy0QfyOXmTdr4D4oyfKuDSFOEUDMrlcuBmYZDaC7Az8UPy2W8LH4U3qxqZUcV7YC0S3mOOd4ez3sWmwiH/qJAuYRKvgRZPd/tGIJGGDMEkcd2yp1GRwiDyc1MlakUc/rOF9KIZ4vQKLLX5NsfoGRKSmCnFemN/ummbfW5VuxpptTCipZiqufjbnZl2upOV7BpmzPAEtwN/X1LeXhOko/23Vt5eaNwNSr9yMzBU7db+SwS5U6eCNQi6wL2u+qwAUn4r7MUChvCF2pC8u5vPpeob/Yj4pPtz/Svk85VVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.17; Wed, 24 Jul 2024 02:04:00 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7784.013; Wed, 24 Jul 2024
 02:04:00 +0000
Date: Wed, 24 Jul 2024 10:03:19 +0800
From: Philip Li <philip.li@intel.com>
To: David Hildenbrand <david@redhat.com>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: mm/gup.o: warning: objtool: faultin_page_range+0x100:
 unreachable instruction
Message-ID: <ZqBg58DTP38wK199@rli9-mobl>
References: <202407230630.3vGhnlFB-lkp@intel.com>
 <c8db754f-57b0-4430-b22a-87f8f3758ce9@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c8db754f-57b0-4430-b22a-87f8f3758ce9@redhat.com>
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|DS0PR11MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: e570cd82-8ff4-49dc-3b5f-08dcab84d6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zOuO+UUHPhJwuu6wMXFziwtoojmMhkYUIpZBv6JGPNLmM808YNWxy4otsfpB?=
 =?us-ascii?Q?X650+Di2+p9+q2dCbyn/iqd0uPPtd9Y37qeMoPGj9aw4/EooGiP7PIP6KOqL?=
 =?us-ascii?Q?l9DLMY2ZdWsvB2Lb6I6F56QNBsRNpmIRYIOhlvGs3R5n+xXXdFHiI48PVksi?=
 =?us-ascii?Q?PoIwLHY5LJLFu9DTDI3pFZj6kTfJsqDPh5zQFTS+bt179UictZG3ObmbOrBb?=
 =?us-ascii?Q?KwCPj4cWwb1RbbU+2TC1T8zNER70Chid6gDMod3yoN9B/Y2phAgXTxoUwvIV?=
 =?us-ascii?Q?wtg6YAId8YvpELqlTUE58oKeuLU7Yp1LjolNugRMJjQ8ElXjSGIk88f5L8Ia?=
 =?us-ascii?Q?hv7FGRxzyMnbw8pOABlVp17nOYnAZuUAnhGfQG0WV0n2EFVydrcjA/p/I32A?=
 =?us-ascii?Q?imwOAjYWJli8E0rA0zfPp6eGNdHejRn3UPTrhcBPdfNqS2yKU7dIvJE83cFp?=
 =?us-ascii?Q?YBRPgCHXE5E6KIRIVGjjrfQRPfZs9S90o9xXSlvSo2bhus+erPc3wI0F68ir?=
 =?us-ascii?Q?/DsxqfYWEo9Il/Piv2IB/47nbaVkpjW9lsjDsfXjj9KLj4MDvgDnAK1flZZr?=
 =?us-ascii?Q?do4g12x9vxpGrqo+BYu9A/btSLNbHJ7NMvhFKqc110GeRutQtLiNLdZyRaLJ?=
 =?us-ascii?Q?OjElNqKIczmw++ek+F86sz5pNo8apjbJvqUJo5GDlNL0a+769xW6bGMOpmzV?=
 =?us-ascii?Q?7kSJ7biiQ1GkLZkQmwFftuKrdJNVuBe1LAmi1eyoczeZTd7WbHcDfr5e8Jxp?=
 =?us-ascii?Q?mjUgHygGRtOdsxvXXWQbs/K+5gbLDEaKhnDDwIL6MIrhy5e9/ykU+6so6px3?=
 =?us-ascii?Q?6P0JDB/nsEGBQCDEb+zt2p4zmD7EvhOnaD7xXyPid2VrapcRrn44OGRq38f/?=
 =?us-ascii?Q?FoZ2oeKLFBCh9FaCs7S+nOOoyw7zSn5oJx/Yojy2V4GxV1Shl0eqMhlC6Gaf?=
 =?us-ascii?Q?IUso+Jfuk1hfOKHHD0eDC2TMeqZxOqLCleVoeKqM1eDzNUlLyR/tppM0A57f?=
 =?us-ascii?Q?tDE3gLZYoptFyg1vFeilsRPa3p6J+4k0rmGV3C4vtpeao6Ljk2QAy+um6N+n?=
 =?us-ascii?Q?nHnRmDOawXKSavJqHDJRpBKVCGyVr+rb8m+Ozzs/GZ9S8eQeaFaZVW9+Dni/?=
 =?us-ascii?Q?f64rfWJJlCiMyyfpORba5OANhz89rsQ0UrCKoYODr+5B8RJkeGUteuKCGoW3?=
 =?us-ascii?Q?XcGe8y9ipdCUMbaQvoFUEvkadGj8Q5BMoZ7mobQzc0jBbngkIzdoEjqQjpkh?=
 =?us-ascii?Q?yZ1KaTLW7cAWj4KnawhoYrMtG9tSRK3RvEjdCxbQfAsiv8ptR5Wc5huPpT9s?=
 =?us-ascii?Q?K5Ek8ekbRgu61MM6iVHld/Mz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JX+4zlbfRZDVL4aPhCEyAyjoTvUL0YKFb+QrABS6579wuxDO2m3pBQuBu9lb?=
 =?us-ascii?Q?uDj3okN5NcQ+Q6KwEzQxPZUQN6So5DE1F46A1I5pVg9LpJnQnww6JnCeHeD1?=
 =?us-ascii?Q?xFZ6eVqHAIvgtGm5Fg2mUN3FgEDWIIqIj7wPhadsE0V5iCYn1kyMZofJBrIO?=
 =?us-ascii?Q?C/1kI4ZaTV8staUxYSD31UOdttuoLpEOoY6pOrMoqg5OsbmYyTvqs3QoUHfj?=
 =?us-ascii?Q?QDUBPlxEcZBOEQK0pUofIrTFWxC7uRpHqGqMw58KhLhLln+grnWMb7Y/Ienj?=
 =?us-ascii?Q?xnvYv8uGFZkIcyOad9mJl/ZjPHsp/GrvZZZ3FWh7c8o9ZUpBE0zi1TTFgHWa?=
 =?us-ascii?Q?Ir3VVlMRYaTbfkDbR3bZUrfc7xtd5XqFfMkI/2grbbhfPGyA0c5B0IXss+q9?=
 =?us-ascii?Q?+0soJF+VVmyTLQAAviw9PfNbLJsPIfMZjmBSJFrMh0Kdd44k+iBHeEWAeIMO?=
 =?us-ascii?Q?8wB4jsn4X/9FVFGJ50Whv1lRDri9aLaJkNwIgcZntwZk6UkE0g3ivbykfb8Q?=
 =?us-ascii?Q?BbCLHskYNXkgDzvuK7j1cAtkkVcuok0bIDAFQOlOXLSrgdXVkk/7xw3WF/nw?=
 =?us-ascii?Q?taONdNtC88Kd6Pi/Td6kkcE2rI3ni6kQDC0kd6PbEkrBh41y9AmvlLFKulCi?=
 =?us-ascii?Q?iuEybNaeBmcMDnl26SULqQi1pZ+GPNkOstnlzoXXik5aFn205uXqXcV/35qu?=
 =?us-ascii?Q?UDT/0v7o76Te7fU2UDN+/PMIDT3Mk2rpWXwLy+dcx6oowSkKdvwPTH2CUWCH?=
 =?us-ascii?Q?cQtKHIUPgPu2yXoCxRDDq0kPEIUqIV5U1V/YCDO6RHDNcOIsncoIfK6g7qA/?=
 =?us-ascii?Q?Mw6yIa0f28BStz92FZFTc3pAfXiL6LMSCv3sYRu3mxAqRZJa21kBMzKJ2/um?=
 =?us-ascii?Q?dl6jsmfus+TjbcNQPEmnl1P/L75BnKSxZxv/CsCeznJmmRelyBTUcVj/lz26?=
 =?us-ascii?Q?2pdeGTlZQS+uHSeN9uv88Zxp2rqs3d06O10RyfCv6Va3LMAo5+io8+UlfMeb?=
 =?us-ascii?Q?oJf3xIsNGzb3XA7jsAiRt2zkyXQ9gMSar2wwk1W9XbjtVHQdmuwJh6TKgInB?=
 =?us-ascii?Q?zTsD08U69/5bfnZFuCZLGUF2RgCkCQYvc98Mwu1cxFyGRCXCBe1g3ssP6bLp?=
 =?us-ascii?Q?5HFjYLNxYftuE86SU/02YukcbaIXjK6/EOvaykWKjsQksXvCP2Si42BToO85?=
 =?us-ascii?Q?YS83v2T3vuPwB6IPNclYQIUuFvvJiKsSHE1u0zJdGs1ip0/dIM2yPYvtAZ07?=
 =?us-ascii?Q?nPvXzR+dRp2KGQph2FMddsAhh/+39BTRD15UBtWKRO7OCl1IIalmDoj1YcvC?=
 =?us-ascii?Q?ywMOIISWko9M02wIrxfb30NjQ06XpEUj8sEWhAUAxsNswxRg1+SCfHcXJeCV?=
 =?us-ascii?Q?ZA4rFy3k15nT4dxUfjBT14uP0VN1jm97PAvgx5pZc9cmxM/bjOKl6SIQIpzH?=
 =?us-ascii?Q?J53x5eUaJDEzavg5qsmH6uBOZPqbEztB6qNc+Gv0VkaUBjjrbc0lSgjIGLOA?=
 =?us-ascii?Q?A0p3o5uZ4nN3I+GKfiXKNtUyHCfeT0TbKj+nZi9W9ezyUXSV27eRuYzISSy2?=
 =?us-ascii?Q?iW4ZnQ/7aqHyQkOs1WtFdtqkHa3F2ES9rD8wJiZa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e570cd82-8ff4-49dc-3b5f-08dcab84d6af
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 02:04:00.0314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGXBVSsHiZiScD04Pvqydah2ibOvtnmVPGXNtRO01uCN7UIKBwXFPRu0uyYa/gJ9XPvYjjcQE7kYyO/GePeURA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8208
X-OriginatorOrg: intel.com

On Tue, Jul 23, 2024 at 10:28:15AM +0200, David Hildenbrand wrote:
> On 23.07.24 00:56, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   933069701c1b507825b514317d4edd5d3fd9d417
> > commit: 631426ba1d45a8672b177ee85ad4cabe760dd131 mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly
> > date:   3 months ago
> > config: loongarch-randconfig-001-20240722 (https://download.01.org/0day-ci/archive/20240723/202407230630.3vGhnlFB-lkp@intel.com/config)
> > compiler: loongarch64-linux-gcc (GCC) 14.1.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240723/202407230630.3vGhnlFB-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202407230630.3vGhnlFB-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >     mm/gup.o: warning: objtool: get_user_pages_remote+0x160: unreachable instruction
> >     mm/gup.o: warning: objtool: get_user_pages+0x12c: unreachable instruction
> >     mm/gup.o: warning: objtool: get_user_pages_unlocked+0x138: unreachable instruction
> >     mm/gup.o: warning: objtool: __gup_longterm_locked+0x3d8: unreachable instruction
> > > > mm/gup.o: warning: objtool: faultin_page_range+0x100: unreachable instruction
> > 
> > 
> > objdump-func vmlinux.o faultin_page_range:
> > 
> 
> I'm afraid I don't know how serious I should take this report :/

Sorry, kindly ignore this report which could be related to tool chain upgrade to
loongarch64-linux-gcc (GCC) 14.1.0.

We will further check whether the issue can be reproduced on gcc-13.

> 
> The commit is 3 month old and was found on some toolchain with some
> randconfig on some architecture, in code that is not particularly
> architecture specific.
> 
> I wish I could even understand from the report what is happening here
> ("unreachable instruction" -- isn't that the compilers fault if it generates
> that such that objtool would complain? Why is that a C code issue?)
> 
> Please, someone shout if I should take a closer look at this.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 
> 

