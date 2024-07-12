Return-Path: <linux-kernel+bounces-250137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCCF92F495
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6C01C21A30
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D856125D6;
	Fri, 12 Jul 2024 04:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LG9L0dZu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AE210A0D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720757987; cv=fail; b=rAdwgE3ek2n6bHHLOKMQ+IlvR6IBEjcKDmyWY/1sZWhg5AOc4ZcwMN433wYHnKVcliMm8eRXslYyhmvyVMVor3jHHwO2l22cLYyn93F2OPtfY9oEZ5mWbm3gHx+kpDDUttFXMCvZqNPWU64Rz++RMDHvji4XO2Fe0ECRYcMQplE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720757987; c=relaxed/simple;
	bh=CaqdvuMhVNPT1FoQIEEenaMfYbyG4IB0eFzGBCj/MNo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=UiSWX5+eA4xNVKGEXX59H4B7jEcSN3E64gNU0YcfPuSq3wOvHwKO2bIQtdvfO8Ox8YZqJIc62UG5SakK8NfliuJd6uPnF4h5q3L+yx3Il855zXvWPZvNtrVN3pOrlM2Am1UOdNpaf/VH7ck9lAa1yrcYsfyZMd2gM5jSRQXq1kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LG9L0dZu; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720757984; x=1752293984;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CaqdvuMhVNPT1FoQIEEenaMfYbyG4IB0eFzGBCj/MNo=;
  b=LG9L0dZusTfZ2COhAKNbEt3erkPwMFZkwYLAD2aJVR5yaI3mfk6Liovd
   RSxEnfLwrYzbAesmDwC1eu58qtgMkdnzUssu0rViSQ1847XhDCDWL2ZWt
   unVhqfaZTfojld2wacM0Vmm594kl+BJlx4Xfi7o/RI9IQFhl97872Id7P
   ZYMEqY8ERPjT98B+Hy2Uo3LQV3sp+uKf5Hqsx6MiO/84JgP87n0FnISYe
   uO3/G35TNa7QMDtggRB6iFDcekKcPYUf++1f/vuP927/3fC0s3/awIK2S
   f5PrFyHoNi0v93o/3ErVfRNeHymVWbyj7f6DdmJjBBt0+rCDIOeDtG4J5
   g==;
X-CSE-ConnectionGUID: SgY1Eiy/TQWYIarDS2a14Q==
X-CSE-MsgGUID: kL4Fb/8ZSViKSShc9YFsPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="43599880"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="43599880"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 21:19:44 -0700
X-CSE-ConnectionGUID: Jg/wyBMASAasr1TsM8uAdw==
X-CSE-MsgGUID: 7MBz1NSlSra7YDtEREbkRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="79905610"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 21:19:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 21:19:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 21:19:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 21:19:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbMcyMLl8Xv7tz1XVXQnqsgcEmyc9ikTTNOFc0AFBBQcJN8vX3UERP8gl3eFzeGM0FU1C2IcUUrtMNNrEAYRlLwKVdJ0dWTGAcN68gUnAhLhkyJhZRxDDQPXly8tNiVje4EshPRE0rq6mL/BXZlAnoLsigIBRGrpejeNWeacvcO2OGLujx2noh/a4e/s0QPjVVBYrE7s1TPWdqKm6ymD0hPAb4B2wq622TZz+EIfmRhG8rtqItHPkAXhNG/JZeKk/DRLuJ/gSnGn0G+5rZ4KEZUX7M69Zk1cj2CbdRMlQKM01eff7HTK4sXalVyruiLdRJ8EhhTRmOVzHPeDIRPDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oygfKIq9GyUmLk/GoMUnP56L3tP89k4JtFIe9UFGesU=;
 b=rHYo+3DDaXFfoywgtRDlyjUUwGqBm8R9GQbmV1jaR+yaKwUYBgkesRH4xhzsC0j9ew8V+9RQMjyjC2Zy8nnvkKlVfJZTCwxAAfSb8blfx3MKhjiFZuMvwFcgl5i1KkLZjKyTN1M0Uh7h/mYK6/TmkqZcKy3DsofSNee1IQ6IXpygsj5aJQlvlcWkHYnIgXW7x4bw2MGQXPvZhj+HTFtG5AVQMFyhxUDzjz76uytUC6S6Ka+v9yv3LT3uadmWhGleDxJ42BfaNiA/f6O2btaIixPSw/nI80f52hMLO9Q6+NrE9Wf8ltprP/L+gbnHk38uEeuj3OQhusuml7u+FpR13w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 LV8PR11MB8486.namprd11.prod.outlook.com (2603:10b6:408:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 04:19:36 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 04:19:36 +0000
Date: Fri, 12 Jul 2024 12:19:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, "Gustavo A. R. Silva"
	<gustavo@embeddedor.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240621-CbC 1/11]
 include/linux/tty_buffer.h:40:27: warning: structure containing a flexible
 array member is not at the end of another structure
Message-ID: <ZpCuz7PvauxD9L5e@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
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
X-MS-Office365-Filtering-Correlation-Id: 463636da-0848-4f49-2487-08dca229d6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kUrxmVnNYzzHtMQBBer43JTB7ewlFms1+UqhL/NflW32bPRW4F4+iY3GnqEv?=
 =?us-ascii?Q?DcOwAs/39eBHafBhCyxU+b0K1jxJM3I4O/l3S0+ehTYcmbdwnmqPbeUsbvY8?=
 =?us-ascii?Q?t6cfsdCcIa/9zCAkbianGnJxpp+NVZYDq3OSLVJ/z9AFOtKgCNBirTUdZf0w?=
 =?us-ascii?Q?3BA4apAqBNm3nx30/Etc6CfifBYRUw1HxjwcdXtFCnKBlDtKiBW1vEqeTE0r?=
 =?us-ascii?Q?6RQqduTPMSNVjiSHUNEkuw0xnb3R30D+aW/pXAo2PJ4WSQMUzaknwUG3fa16?=
 =?us-ascii?Q?BkR1KTs+78HUFGBre+ErmA5Ii3tlTUIVItpwe2MrH0yNnTlp+i1vHXuaD8IU?=
 =?us-ascii?Q?dh176g3DJta81A5hxkQxiZ395BA0/zqbaqjNg0rv12a6mJjTjqyVL7N+NjmM?=
 =?us-ascii?Q?aqH/JAbb+n4HnbssakzZfNXDMOKCUDDCIslsILoDtD8LWYeyH/+mghVKqewT?=
 =?us-ascii?Q?K81CpMUqP9ZSKXvqzBnp65Lg9cwfYaY881WXcDT8Gsk4GrhzX67gKbFroD+A?=
 =?us-ascii?Q?WLzAhP0GdW8WVLL1ZUp4Jt5IyxHkA6FGljxE37RM1asR1/qpVDiik4Gmongt?=
 =?us-ascii?Q?3V9ilktywwi/Aqx4j3UTI5h1iQHB7/HBZdHgweEXhZUJImJl3s+cpS9B60Le?=
 =?us-ascii?Q?oY6hNMP8PCK9LET8D9Co2ifHFoseKzqdetz5MN46BQi2wTkRY9esmLor9Sx5?=
 =?us-ascii?Q?4Faedfm2v0EhdmcYJwkDV3a7HLd7/VqWBnoM7zg3jDJsF6+fNu3r16W+csXr?=
 =?us-ascii?Q?0zcJGd/ClrCoRbydc3Bh4q6gAFnaRNu0rk2Q6uzDLaChC8KzjEWtRjnLAiOE?=
 =?us-ascii?Q?vF8+8Hq7+cO0ylrUXUNTqrDgVjg6Yn0cvoyiu7t2V/mLXnP01VKkw/UQ/tlZ?=
 =?us-ascii?Q?KYK267NTl48Sk82nmKmVlfnohJzL6sijoqO7Rvbyc//i/YkUkwGVPuLwIIU2?=
 =?us-ascii?Q?GM6sNNS+Jx5L7SJtvlS1E1UoUNFkr3gGGp70KQP9u3hUE6cXbsh8cQfc3IKl?=
 =?us-ascii?Q?ghl6z958Ql65GLPjdvCpAsAGWpUyECtELR1HIGBXI8yrCeDv1Kh2jnCmE+Q+?=
 =?us-ascii?Q?vUP3/Pei6ZRdvUNm7hfr+9DFOkq6LwwDSBLZjyJn1adtXEScxmlhmL97nANR?=
 =?us-ascii?Q?BPIh8ywbcHOOM/o9cTzmgbYYwLQbZ76oRjX/N2oVwdetCdxjzRJVViNRuJe7?=
 =?us-ascii?Q?ttbYrbghtgDji1hRP1cQnpO6KjZIm2yx4DSCazo9G8501HCWd17a76/V5JuX?=
 =?us-ascii?Q?ickkJkdbul6PKWrry6UqsUSml/XI9pK2NP7gdW/k2boCfaHyWHA45wzQT4He?=
 =?us-ascii?Q?s5Ug+Y0pXZQK7Dz4M+isRenl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U4GpVnSGeOv9R5YSFEN5DBV1Nw0DLXEg4AXGehm9TWmQlyVexhlaMaAjpiuy?=
 =?us-ascii?Q?KupvB5I7ATVCiygoOJPgbkYevnqVd+6HKIWMB8wbsixDKkbDabmHHUWdEjAx?=
 =?us-ascii?Q?KXJVONOZCE+x1MS9qgEo1HJBxkgNC/GrglMrwaziDdGD1K9eg4ZMIXZT5Uaz?=
 =?us-ascii?Q?exhO38J6e2QEUOY452whz4x+NuWE+B+bfENABRddMKlWucdn4KtGhrFyXMNN?=
 =?us-ascii?Q?HKrlVmnpbvnmbMdEEO6OdZ3im/q8SQ5s9HzimP/N7m756Bs3qj0CF3CZj20f?=
 =?us-ascii?Q?RZYbeaifeOeRtMxqx/POeaPgG1zVasIdZSx3cUydsprIJXfEwNixp1/Kk3Ii?=
 =?us-ascii?Q?37ddocKLW7YEaMVtecg8ytymicq3qM/fp9fcnxMAmZTPdXqF2T5K7tyxs4SI?=
 =?us-ascii?Q?Z87W/vre33QAM+ZHV9UdPOCzarO06q18X/WNGvKaFavxt3McZBQbTeRkJqHk?=
 =?us-ascii?Q?K+PjfyXuzKL/oKhC3RXTWsDErUDaKFVHOGGJtkuSgadv4xTuapK08rzyN5ES?=
 =?us-ascii?Q?p0HKfWzZU1qvaoQ4V49GRr71RKd8olF/FpSW5UenQ2mNgIGqa3YrzT5NfJQh?=
 =?us-ascii?Q?sepSNdSziMDgeYnS+HPiTVoxCqwIYPUme9UZ7t6EeBSaYh0ht1alZf6P9F+2?=
 =?us-ascii?Q?oP6R8rl+R/ktXL40MwhaVkNuvqSGPMJcxa/qKSI7KCTUKM56YWBxsHGXSAkV?=
 =?us-ascii?Q?4PCTHk3E0y7/wglyCSGIozl/YYKMVH5hWakst5ZBqfisVRldGpQN2HIrByht?=
 =?us-ascii?Q?sh1iV6rd4GWnn3QUjXTUDX3kbcbW3opfnB19zsNnsaCyWMsrj2B3tiq+2Kvs?=
 =?us-ascii?Q?wyRHMmZsMxD+259OGsKJRQV7Pr8qPniMbUu5sDWaUJzOL7FEz6qNkNAO6p4L?=
 =?us-ascii?Q?ditOqIjTPXI6B7yirtuP+yxfCqz1fUajbyvBFZ0jZdLAaZ8TpKUAIIneMGcx?=
 =?us-ascii?Q?JvroweJcmWBWs4evjIJ4bn88GREu24uNFV9dvu1uHkv4N9NcrID1/4yLViZq?=
 =?us-ascii?Q?ho8E7mScaUF25l/6Af+d/D6JHyTJrlhBt0DR97xrYxEHyzuSALktmiZ1pooF?=
 =?us-ascii?Q?bLQwyKT/Tunn61muuWjI81DmlsAZrJeH8hxdWz3BP5bi3ib3kS5JLf2uP7u7?=
 =?us-ascii?Q?BYCHVU/WcvsohBnaNJ6AIkjEv7RyZ2gi2o8XvDqcyMesfCh1qtKP6w6AHc+q?=
 =?us-ascii?Q?UrUqx8/us1kzma7yOHuLA9JP4uDFeh+d163gBQvlsjzOYpz76SaXcqnSVCbB?=
 =?us-ascii?Q?H+ghoYgoIjka+wNT/wLuqPVs6qiVi9KPWwR0YmX+zIm4IMXwYCCv1QzwAAeX?=
 =?us-ascii?Q?AnsH/zld3sW9+LzUhcHjOu3Qr/wCVFXkXborybtwHkBpdYkiMk/MmvHCKhM/?=
 =?us-ascii?Q?3sonfU+0ajQLFCtznfxFxZr36XvsQHdNSY/eKMpvwls+ZjO8j/q8bfQKygUg?=
 =?us-ascii?Q?w8TVLKKAMrH+CSKAcu4fd6NxbD2i8jmt/dkLllG/kcmGO7rnsxu/SNw8BEhy?=
 =?us-ascii?Q?5FUe6RliJvQMZLp3DJEtVAeO8SXYH2i0uzNd+y/y+jbMzbWbAvFueK3VaAe8?=
 =?us-ascii?Q?QINpsoCnf9xhgiYfJCWr5SnoWyKTty+av8H/txLN0g16m4kUqwIYw1j0WN1v?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 463636da-0848-4f49-2487-08dca229d6ae
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 04:19:36.1978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uS4nJUnblMNGAw778XPePkm7Tyu2jHV3g47VczkeN+WM4QRpVkyzjVLuGD2e1SYN7fpn+w3ZE24hSx95cCxwjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8486
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240621-CbC
head:   30867ef8ad076c11ed274d76f99e8bb0346790af
commit: 18c8dad6dac24de88b5379ad4e367e50d06a96ec [1/11] Makefile: Enable -Wflex-array-member-not-at-end globally
:::::: branch date: 5 hours ago
:::::: commit date: 2 weeks ago
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240711/202407111807.R0HzhFNt-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407111807.R0HzhFNt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202407111807.R0HzhFNt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/tty_port.h:8,
                    from include/linux/tty.h:11,
                    from fs/open.c:14:
>> include/linux/tty_buffer.h:40:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      40 |         struct tty_buffer sentinel;
         |                           ^~~~~~~~
   In file included from include/linux/security.h:35,
                    from fs/open.c:19:
   include/linux/bpf.h:2002:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
    2002 |         struct bpf_prog_array hdr;
         |                               ^~~
--
   In file included from include/linux/tty_port.h:8,
                    from include/linux/tty.h:11,
                    from fs/char_dev.c:24:
>> include/linux/tty_buffer.h:40:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      40 |         struct tty_buffer sentinel;
         |                           ^~~~~~~~
--
   In file included from include/linux/security.h:35,
                    from include/linux/perf_event.h:62,
                    from fs/exec.c:42:
   include/linux/bpf.h:2002:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
    2002 |         struct bpf_prog_array hdr;
         |                               ^~~
   In file included from arch/openrisc/include/asm/tlb.h:24,
                    from fs/exec.c:74:
>> include/asm-generic/tlb.h:351:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
     351 |         struct mmu_gather_batch local;
         |                                 ^~~~~
--
   In file included from include/linux/security.h:35,
                    from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:94,
                    from fs/select.c:22:
   include/linux/bpf.h:2002:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
    2002 |         struct bpf_prog_array hdr;
         |                               ^~~
   In file included from include/net/scm.h:13,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:45,
                    from include/net/busy_poll.h:15,
                    from fs/select.c:33:
>> include/net/compat.h:33:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      33 |         struct sockaddr rt_dst;         /* target address               */
         |                         ^~~~~~
   include/net/compat.h:34:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      34 |         struct sockaddr rt_gateway;     /* gateway addr (RTF_GATEWAY)   */
         |                         ^~~~~~~~~~
   include/net/compat.h:35:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      35 |         struct sockaddr rt_genmask;     /* target network mask (IP)     */
         |                         ^~~~~~~~~~
   In file included from include/net/ip.h:29,
                    from include/net/busy_poll.h:18:
>> include/net/inet_sock.h:64:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      64 |         struct ip_options_rcu   opt;
         |                                 ^~~
   In file included from include/linux/if_arp.h:23,
                    from include/net/arp.h:6,
                    from include/net/route.h:28,
                    from include/net/ip.h:30:
>> include/uapi/linux/if_arp.h:118:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
     118 |         struct sockaddr arp_pa;         /* protocol address              */
         |                         ^~~~~~
   include/uapi/linux/if_arp.h:119:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
     119 |         struct sockaddr arp_ha;         /* hardware address              */
         |                         ^~~~~~
   include/uapi/linux/if_arp.h:121:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
     121 |         struct sockaddr arp_netmask;    /* netmask (only for proxy arps) */
         |                         ^~~~~~~~~~~
   include/uapi/linux/if_arp.h:126:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
     126 |         struct sockaddr arp_pa;         /* protocol address              */
         |                         ^~~~~~
   include/uapi/linux/if_arp.h:127:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
     127 |         struct sockaddr arp_ha;         /* hardware address              */
         |                         ^~~~~~
   In file included from include/net/route.h:33:
>> include/uapi/linux/route.h:33:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      33 |         struct sockaddr rt_dst;         /* target address               */
         |                         ^~~~~~
   include/uapi/linux/route.h:34:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      34 |         struct sockaddr rt_gateway;     /* gateway addr (RTF_GATEWAY)   */
         |                         ^~~~~~~~~~
   include/uapi/linux/route.h:35:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      35 |         struct sockaddr rt_genmask;     /* target network mask (IP)     */
         |                         ^~~~~~~~~~
>> include/net/ip.h:48:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      48 |         struct ip_options       opt;            /* Compiled IP options          */
         |                                 ^~~
--
   In file included from include/linux/security.h:35,
                    from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:94,
                    from fs/file.c:10:
   include/linux/bpf.h:2002:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
    2002 |         struct bpf_prog_array hdr;
         |                               ^~~
   In file included from include/net/scm.h:13,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:45,
                    from include/net/sock.h:46,
                    from fs/file.c:23:
>> include/net/compat.h:33:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      33 |         struct sockaddr rt_dst;         /* target address               */
         |                         ^~~~~~
   include/net/compat.h:34:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      34 |         struct sockaddr rt_gateway;     /* gateway addr (RTF_GATEWAY)   */
         |                         ^~~~~~~~~~
   include/net/compat.h:35:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      35 |         struct sockaddr rt_genmask;     /* target network mask (IP)     */
         |                         ^~~~~~~~~~
--
   In file included from include/linux/security.h:35,
                    from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:94,
                    from fs/namespace.c:11:
   include/linux/bpf.h:2002:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
    2002 |         struct bpf_prog_array hdr;
         |                               ^~~
>> fs/namespace.c:4747:26: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
    4747 |         struct statmount sm;
         |                          ^~
--
   In file included from include/linux/security.h:35,
                    from kernel/fork.c:52:
   include/linux/bpf.h:2002:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
    2002 |         struct bpf_prog_array hdr;
         |                               ^~~
   In file included from include/linux/tty_port.h:8,
                    from include/linux/tty.h:11,
                    from kernel/fork.c:80:
>> include/linux/tty_buffer.h:40:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      40 |         struct tty_buffer sentinel;
         |                           ^~~~~~~~
--
   In file included from include/linux/security.h:35,
                    from kernel/sysctl.c:32:
   include/linux/bpf.h:2002:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
    2002 |         struct bpf_prog_array hdr;
         |                               ^~~
   In file included from include/net/scm.h:13,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:45,
                    from include/linux/if_vlan.h:10,
                    from include/linux/filter.h:21,
                    from kernel/sysctl.c:35:
>> include/net/compat.h:33:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      33 |         struct sockaddr rt_dst;         /* target address               */
         |                         ^~~~~~
   include/net/compat.h:34:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      34 |         struct sockaddr rt_gateway;     /* gateway addr (RTF_GATEWAY)   */
         |                         ^~~~~~~~~~
   include/net/compat.h:35:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      35 |         struct sockaddr rt_genmask;     /* target network mask (IP)     */
         |                         ^~~~~~~~~~
   In file included from include/net/inet_connection_sock.h:21,
                    from include/linux/tcp.h:20,
                    from include/linux/ipv6.h:101,
                    from include/net/ipv6.h:12,
                    from include/linux/sunrpc/clnt.h:29,
                    from include/linux/nfs_fs.h:32,
                    from kernel/sysctl.c:53:
>> include/net/inet_sock.h:64:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      64 |         struct ip_options_rcu   opt;
         |                                 ^~~
--
   In file included from include/linux/security.h:35,
                    from include/net/scm.h:9,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:45,
                    from include/net/sock.h:46,
                    from include/linux/tcp.h:19,
                    from include/linux/ipv6.h:101,
                    from include/net/addrconf.h:61,
                    from lib/vsprintf.c:41:
   include/linux/bpf.h:2002:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
    2002 |         struct bpf_prog_array hdr;
         |                               ^~~
   In file included from include/net/scm.h:13:
>> include/net/compat.h:33:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      33 |         struct sockaddr rt_dst;         /* target address               */
         |                         ^~~~~~
   include/net/compat.h:34:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      34 |         struct sockaddr rt_gateway;     /* gateway addr (RTF_GATEWAY)   */
         |                         ^~~~~~~~~~
   include/net/compat.h:35:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      35 |         struct sockaddr rt_genmask;     /* target network mask (IP)     */
         |                         ^~~~~~~~~~
   In file included from include/net/inet_connection_sock.h:21,
                    from include/linux/tcp.h:20:
>> include/net/inet_sock.h:64:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      64 |         struct ip_options_rcu   opt;
         |                                 ^~~
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1683:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1683 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~
--
   In file included from include/linux/security.h:35,
                    from include/net/scm.h:9,
                    from include/linux/netlink.h:9,
                    from include/linux/ethtool.h:19,
                    from include/linux/phy.h:16,
                    from drivers/base/property.c:16:
   include/linux/bpf.h:2002:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
    2002 |         struct bpf_prog_array hdr;
         |                               ^~~
   In file included from include/net/scm.h:13:
>> include/net/compat.h:33:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      33 |         struct sockaddr rt_dst;         /* target address               */
         |                         ^~~~~~
   include/net/compat.h:34:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      34 |         struct sockaddr rt_gateway;     /* gateway addr (RTF_GATEWAY)   */
         |                         ^~~~~~~~~~
   include/net/compat.h:35:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      35 |         struct sockaddr rt_genmask;     /* target network mask (IP)     */
         |                         ^~~~~~~~~~
>> include/linux/ethtool.h:170:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
     170 |         struct ethtool_link_settings base;
         |                                      ^~~~
--
   In file included from arch/openrisc/include/asm/tlb.h:24,
                    from arch/openrisc/mm/init.c:33:
>> include/asm-generic/tlb.h:351:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
     351 |         struct mmu_gather_batch local;
         |                                 ^~~~~


vim +40 include/linux/tty_buffer.h

8d29e0024437ae Jiri Slaby 2021-07-23  34  
8d29e0024437ae Jiri Slaby 2021-07-23  35  struct tty_bufhead {
8d29e0024437ae Jiri Slaby 2021-07-23  36  	struct tty_buffer *head;	/* Queue head */
8d29e0024437ae Jiri Slaby 2021-07-23  37  	struct work_struct work;
8d29e0024437ae Jiri Slaby 2021-07-23  38  	struct mutex	   lock;
8d29e0024437ae Jiri Slaby 2021-07-23  39  	atomic_t	   priority;
8d29e0024437ae Jiri Slaby 2021-07-23 @40  	struct tty_buffer sentinel;
8d29e0024437ae Jiri Slaby 2021-07-23  41  	struct llist_head free;		/* Free queue head */
8d29e0024437ae Jiri Slaby 2021-07-23  42  	atomic_t	   mem_used;    /* In-use buffers excluding free list */
8d29e0024437ae Jiri Slaby 2021-07-23  43  	int		   mem_limit;
8d29e0024437ae Jiri Slaby 2021-07-23  44  	struct tty_buffer *tail;	/* Active buffer */
8d29e0024437ae Jiri Slaby 2021-07-23  45  };
8d29e0024437ae Jiri Slaby 2021-07-23  46  

:::::: The code at line 40 was first introduced by commit
:::::: 8d29e0024437ae9184ae24f817ef0fda80b8cd3c tty: move tty_buffer definitions to new tty_buffer.h

:::::: TO: Jiri Slaby <jslaby@suse.cz>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


