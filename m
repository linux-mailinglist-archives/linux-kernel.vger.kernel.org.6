Return-Path: <linux-kernel+bounces-250136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F5992F494
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C421C21C70
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C1E1119A;
	Fri, 12 Jul 2024 04:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KpaOb932"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BDB175AB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720757967; cv=fail; b=hoA13uUrOX/02leox1Oloczvu2yc/q90peg8vZznH4IZBzkwbVCUQlWNVV98ANHEFHLkfpiOdyXdbcqYaHDvxwslmQWbk+Dw02JEkKhv772y3TDxVnbwdVh5YNBbHJTqFCag0XGicFAd0czXW7ahkuC7SxoMykJi4fvXTqVn8zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720757967; c=relaxed/simple;
	bh=MP70Mxg75cDls12mwSnw4KhXIYRGskUet3YnPw2Ta+Y=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=KL92+UasVyzTvVekufUDiDvNVLlbkbmVF+GjaUQ4KDW1ZGfix/IJBugtBfvqGvz/izmN8VRDtVvvSuW/d+AlHtcZNiWC0HD+IsKmt1hu4XtO0VtMBLP8szFIFFmI47RrfwBhh/QsyKS1RucOOV6XeXYPnKBUqIrJOrZpfGInhsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KpaOb932; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720757963; x=1752293963;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=MP70Mxg75cDls12mwSnw4KhXIYRGskUet3YnPw2Ta+Y=;
  b=KpaOb932TYT8AoCpXzuI7V+EmGNdSPAbuvV8oSQ+zBFmyU8Qdj6oYZ4q
   eM2SQddPSUEwi9oTRvGLKUgkia0GtBR2WdVgApdUXu2HRFRIuP0WmzcNo
   sb2lbLzE7LaJRvfeujZ9RO0MkFL6hHJkdmy/pHH+LiEXjTuKnsyw/FG00
   mSo8Fn3GGTDdo45hQ+vQmC32ZjWBiXPbE3naQi78AIFxWAYm3N+24r6f4
   1jBhlGKwLEFUvN5WMVUEje2yw/vbjK2DrMsMqNz47ighVoowBcyd2X0jx
   Q1pWPqThwGRxn3ydgVSb1Kvtb657pRcTxW8+qM9S5yk5iTwTAC+8AtE8/
   Q==;
X-CSE-ConnectionGUID: 4QIIJldoQ9CnwEuaifEIoQ==
X-CSE-MsgGUID: xl2nrVccRT2hVjjnwxie6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18027052"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18027052"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 21:19:21 -0700
X-CSE-ConnectionGUID: U0PmLmGQQ6a0b9Xgwn6EMQ==
X-CSE-MsgGUID: iPHK1Z7bTXqMSF6mjd2rBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="79481242"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 21:19:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 21:19:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 21:19:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 21:19:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sgfn6LwOcXmSuAlw5m5GRRMK5D1acigavLAWF6oKV+iA06sr+u+4bxc3uLbSSI0UnmU1UKY+7+/Oz5730yesRwQ3ELJatODplXhybPtgSM+ARMeoAqaXpxnEWTCjFPzeFeVkf44maGTGEvqPLb4vdBzm/j6H0E45TCBUUStrn2ouCmZo9Ab5Y+Mi6gwJbo/Ta5nBPmTwFpTif8Y5SeZBlgwsvoaiUr4eYpSYXSMEwzog9O6Fl2M6dPcDIXKLksXI9ih4W6qMXyVDdaaAfLShPq9mJaJjTXjmzFHwqBEbSaw5Xc+O/RpEXJJPQVPBT4BvNeFed/aHAUb6xH28BEETUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDh2s0jVYsJ/vebjJWoXBlqRg78eoz//UTXJ3psIFBA=;
 b=XZGoszetgc1p4BMv6ZJambJ+1oiFtMWJv6MgaOzAQUODwWGFWNLBv0es/TVn/qJVO59kOtULJLRvLleAk+BTQoGYvcP3jshLGufRRBUfB7ak4U8PgpnZJ7ycL2UDJHOAMQwQlcCMK2uQSQHu6D5fHq7J2QrOaZZvXE132nSJWGZH2Cgsv34iPlNB8twdl2hZt8Fnm2q9FZV+fF0YBFblaFJEdr7ekxXekENoXV5K5pbv42Nx+MPu5XTKAN71SlETgU/m9WSJNGFub0IRvNz/Tzw+6X/4sO++sZegJ6FF8hy4I/szPUYK3FpaYbuGfGQf2Z+/DxJn6bqhSimam9/HXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 LV8PR11MB8486.namprd11.prod.outlook.com (2603:10b6:408:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 04:19:12 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 04:19:11 +0000
Date: Fri, 12 Jul 2024 12:19:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, "Gustavo A. R. Silva"
	<gustavo@embeddedor.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240710-cbc 1/13]
 drivers/leds/leds-cros_ec.c:70:40: warning: structure containing a flexible
 array member is not at the end of another structure
Message-ID: <ZpCuthsR28hPyodY@rli9-mobl>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|LV8PR11MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: 678106cc-2fa4-4ea1-4811-08dca229c836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?i0jyFDRqtoMsEm0G6YdW1mFWEzN/I79/kzz+GZajQnIGd/q4/AD/8aZK1Q?=
 =?iso-8859-1?Q?LlnyXuedbkFuWz7xUKmps0tPV6PcU9xIWcJOHN2xtgUNEVUAX0GaxLX1kl?=
 =?iso-8859-1?Q?3W7U+aWKOcJv55WrFEM7144ZuSh6jvzDLeq8FHJCFqOx+m8R2JN2ZPUZMU?=
 =?iso-8859-1?Q?ebj8x1W5ktL8SCfpOqAsgKhT3myUEgRAZpSog6auhj2+kXroHC94NzM695?=
 =?iso-8859-1?Q?lQJnSD5veowgMkbDZh4qrGqS/80pobbfF/bUMa/UY4bD1lUzW59QdBamCk?=
 =?iso-8859-1?Q?L2fIgdH/Oj6qFa3ftjmVACQUEzOwSapY9LKeO17uiYFIURciq9BJSRivo1?=
 =?iso-8859-1?Q?H5I9g12nF4Df8ZOtORWWhPI8LhtPVRuyEx94t7U3Dcg/ErA/50p0GNB2bU?=
 =?iso-8859-1?Q?O95FRxYDKIctg29kNJTujjnjAQX26vmh36QTeWUopXQOOtwytfrB1P8/Cl?=
 =?iso-8859-1?Q?LuoKfetpyk5Gk9w/XoyI8uM4SoMNio8rQIdAjcGhA1iKNz1C37Arfi/Em1?=
 =?iso-8859-1?Q?+BI9FLKWHiBUED/QR9+FIQV4kJCQcpWwgFVZvmkZvdaM1oqxyygqKN0qgh?=
 =?iso-8859-1?Q?GBXF6lN7LNLnl1ZrhPsva1oJPDf0kChPnu5/AATZBbjhtu6z3FkfsBX/Vc?=
 =?iso-8859-1?Q?lqbigJdVnVsWUIhnFqz+G48HHwVvdIXg9GrozJBzHO7vQ5Oc7gnhbPUntP?=
 =?iso-8859-1?Q?9VmphpmYf9hoZ+z/lP0h5P2bE+jxsaBl4jujyaQpFp92rBNqPMN30DVXp7?=
 =?iso-8859-1?Q?BVXJNdCxxc8RPj5A8mWSZWgiEfUYXJzGTp8CW4XUZrdoLE/MmjuBEps5o0?=
 =?iso-8859-1?Q?owjnTtcvDshRk6vIk81folNDwlygKihP+87i7elxtM9IvXepP2qxPSSOGH?=
 =?iso-8859-1?Q?ojgNzJYE8TZUT0CTZKTX2OfGEyr2J0kXb0+vJiGcUdGoUR2lxaK/o6BymZ?=
 =?iso-8859-1?Q?XMLlGVtI+xsVyNocBwUiwoKRRpynobWjVWeqUKW72o4h2WIyQ5ic0SyO/V?=
 =?iso-8859-1?Q?qFmKnZHseNYv/L2I6QWPdAKmw0kZCBNKOuzNrZuoYg0jngCAkF6/H+5gZG?=
 =?iso-8859-1?Q?6bx341uMOYpUJod4O3B9AN7HoqJswlBP324Z/ecEZVKTqiFZW8iMga64Ut?=
 =?iso-8859-1?Q?3BDsc0sCDMTLtvtg6SLxGPVOseSZYMoDUjghHzraFNFoZHiB/7+z8h8w2/?=
 =?iso-8859-1?Q?fp12z1yslLRIOLFF+mcPuiSvcCTXf7o4ViktQhxbZhxIsTDA3S2JjDx70A?=
 =?iso-8859-1?Q?mtLEryYtA9MNQbXt1QWGWRu0kkObnoE8FoghyjuYWjfoYesy8zdmHBXSc7?=
 =?iso-8859-1?Q?q3in06YkhZjCvojdUj8Gg8RUNwqzmyp+B5IXaOxxFo18e+4aUfnt4Ymhll?=
 =?iso-8859-1?Q?Pgsb4vSA1p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Dmjw1mmZGxjucQ7OJ7YzHine7yeDKXIJ8aGOeuro5Fo5IEKFnYnHSri0Fq?=
 =?iso-8859-1?Q?1OIDq5VC6Mvk4cU5ZLrclPttLVEDXHc7h2HfVnvngGcNgLtr5BgOrEuoso?=
 =?iso-8859-1?Q?ERSup+/wNBphpXbrCQvSDILzMirEYAdO/eGpvXT2mPwf0j1lvgK5Ha6SAl?=
 =?iso-8859-1?Q?LwAOYGi5R3IUcHY1IlI+yKkeCUfc0irUaLV+aLzWcr5YAlPlQZn+s5KjNc?=
 =?iso-8859-1?Q?r89DVaikPxZdgpFMOQQI3V5S3KMAFqG7dqTtgcq+mtoZs/Msga/XDlfOPW?=
 =?iso-8859-1?Q?PmVX7i6lGz+tqLj8S3aVQiC27ds74g4K0P9NZYbDq1/6RQH71KV4b4s7LS?=
 =?iso-8859-1?Q?AjcwmUO1Y0vGIKR+qppFH6+BlZ2rje7ZjGiDWiFaTL3wK2oybPgvpvsPtD?=
 =?iso-8859-1?Q?LnnK8tkNsKPITr/IeUiIj/3SAEQV036oQA7aC0HbAc1vKHe6afyJ9oDhUm?=
 =?iso-8859-1?Q?xwIAb+5g9JdjcrTW7ilRua7dh30flV4a1TVil1wavXztogdZrS8kNf7HBc?=
 =?iso-8859-1?Q?1YmGL22cZpG3w1zwm1+7V2WIO18A3zlKOekL4+JSjHdok2oV6VWQDd4Gmq?=
 =?iso-8859-1?Q?oOyG0zGcOHdPXqeKVHKwzqK31FySXYl8O5Xro9ynu5Av5SolC8QpC5Z72J?=
 =?iso-8859-1?Q?KYTQC0oJFzuOFhfMTRXVJsICtTRNj1OLBgGYtejNI4qd2nt93GTsoyDgVb?=
 =?iso-8859-1?Q?DG6ZiMLiyZ754VLvjn0jsw7bd8fU08wxzCLuCuZiJlLnwmsVyJdwcR21sP?=
 =?iso-8859-1?Q?KtC4aGHOf7w4OvULq0D8VCuc2FD9C9Kydr5Hm7Lp0v865t8N2u+XfKu6GW?=
 =?iso-8859-1?Q?fLajMAIWQGqI+kkv1L5njBq9jq7oYQyBmiu2M4fo3xIHs1vCC5u32YdHEy?=
 =?iso-8859-1?Q?9S/YkAMcECggpZfd720C+pX00wYDrehBqON95kVQQ+OEqvBjRkgb15d3pY?=
 =?iso-8859-1?Q?nGbUkSppDqFCtSXmoP62jq6VQwupCv5fMlMEj5U1XkjNnhrPSO/8k2YR6c?=
 =?iso-8859-1?Q?W208pPo9ee1fDu5i7OGKg9I/BGf2mSQmLLZC4xUZFP5OKj1pvsq6DpWvMi?=
 =?iso-8859-1?Q?1UidTedgSVo5OmIs656h5SX4h1FZJCMfXHD5+xrQgjFXIAUrAwdb0WcYeK?=
 =?iso-8859-1?Q?qSWElFW56kdirQGREGSqFg9RZy2FAB59zyMcdt2jN0VcHTrJhbkVm8sRyi?=
 =?iso-8859-1?Q?c/spV10a+sYTDQbYAylUyDAbtRcGC8TGgtPc8Rv+rWg/hecEvCa8EbRC7I?=
 =?iso-8859-1?Q?qGJB7eSD7Q/9ZRa0bVcbRsVKIsK3YM5iEapUfjhESdGX99A40JsPcpyFz1?=
 =?iso-8859-1?Q?WClqHKfpT9/XGWdqtnpLrlTG5LQdSg3p6QxAJ/iup6pRYPJ3ueKVoll32l?=
 =?iso-8859-1?Q?j50iCdx6D5gKYCVyblaNjnMuqBPZe5MPMAH89sdobtUvle6wkwOm8X6ekm?=
 =?iso-8859-1?Q?fxzCx0aK9LGZpapz+dysBHDwPO/mg4w9xaCbMIiraQ/blWfnrB6Kpc+/p6?=
 =?iso-8859-1?Q?A50tQaKsn3vdirvAOsFrc8G0HbuAAPWiEJ4hCLFC13SR5+0dNTfgF9daDS?=
 =?iso-8859-1?Q?jxMuaO7by7bdSzYzxhy7rk9vmDyMYF2t2GuAcGv3WGMGl9HDC28HJHo3xw?=
 =?iso-8859-1?Q?sOV/CdwviQK4Ao+6M61kDSqgIh5ZNsP1TKNr1+Xu6pz3LxaBOnyaRsiw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 678106cc-2fa4-4ea1-4811-08dca229c836
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 04:19:11.9362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZMy3/9xfPhD2A7819xeJh8itrKx3Vf09nyb+mdxQhr6SYLPOqLceshJuvDIhofZLIS3UVXIFi4dLI30IkY11g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8486
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240710-cbc
head:   73efb8d9b6a2ba4b07021861a1760ec742ddf432
commit: d692eacf807861f523e66bd7d1c60f5dc254f4c6 [1/13] Makefile: Enable -Wflex-array-member-not-at-end globally
:::::: branch date: 8 hours ago
:::::: commit date: 9 hours ago
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240711/202407112258.ZvWw5uJq-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407112258.ZvWw5uJq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202407112258.ZvWw5uJq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/leds/leds-cros_ec.c: In function 'cros_ec_led_send_cmd':
>> drivers/leds/leds-cros_ec.c:70:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      70 |                 struct cros_ec_command msg;
         |                                        ^~~


vim +70 drivers/leds/leds-cros_ec.c

8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  64  
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  65  static int cros_ec_led_send_cmd(struct cros_ec_device *cros_ec,
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  66  				union cros_ec_led_cmd_data *arg)
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  67  {
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  68  	int ret;
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  69  	struct {
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13 @70  		struct cros_ec_command msg;
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  71  		union cros_ec_led_cmd_data data;
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  72  	} __packed buf = {
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  73  		.msg = {
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  74  			.version = 1,
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  75  			.command = EC_CMD_LED_CONTROL,
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  76  			.insize  = sizeof(arg->resp),
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  77  			.outsize = sizeof(arg->req),
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  78  		},
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  79  		.data.req = arg->req
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  80  	};
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  81  
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  82  	ret = cros_ec_cmd_xfer_status(cros_ec, &buf.msg);
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  83  	if (ret < 0)
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  84  		return ret;
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  85  
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  86  	arg->resp = buf.data.resp;
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  87  
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  88  	return 0;
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  89  }
8d6ce6f3ec9d5f Thomas Weiﬂschuh 2024-06-13  90  

:::::: The code at line 70 was first introduced by commit
:::::: 8d6ce6f3ec9d5f384e3eac92e43cfeac7a36e6b1 leds: Add ChromeOS EC driver

:::::: TO: Thomas Weiﬂschuh <linux@weissschuh.net>
:::::: CC: Lee Jones <lee@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


