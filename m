Return-Path: <linux-kernel+bounces-361927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1F199AF06
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A812849DB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8C01D31AF;
	Fri, 11 Oct 2024 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CE2ki/aE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F242D28EB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687895; cv=fail; b=kdTYxeUe/oDkJVvL4QNFfDGHVb05+xBuhvZTyoS/wss+pApxLDie53mGMbqc43n4yQuWG4DNdwLAk5SAbOJEXcL8cqc05NieBqxvHtoRNgmJ0vudnf/cGSUE+52miO96IxCga2fblpTxDLSpv8H7RIBiM6FZnPm6TApgrmQ18Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687895; c=relaxed/simple;
	bh=edinjJ4bll/IIoA1i5j0hs9JcdpCmBrIGsSCXsVefb8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XKyWU+Igq8VABFogd32X3F35IDF1Pa3buiIIDOU9UGUBDrU1YSrA3c8jWDRTHRctk/ui4pmN/7dvJGPyyDRDJjLRVggbQbmTHw07U2jC+6xApltVdq8RB3+OLbnoeTaW9CrhkKeRo76QrfYuIzaY0GMGHU+u4CW7KGFUnEHGDh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CE2ki/aE; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728687895; x=1760223895;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=edinjJ4bll/IIoA1i5j0hs9JcdpCmBrIGsSCXsVefb8=;
  b=CE2ki/aEmUtZcFAMs6sEpKuybTcINWL4RnMHm1aEqqSP7gkujcmgyOni
   tNANux1CBRReD4ghxhFYt/9Wqn/q9IsBdDpXkfQn3wzZNl6jQNmJIAMY5
   6BCN9gq6XhNy+ywnoTdkuE9FHhJh5oX5QVq/HK4nyz95uHBaVRDgL33PT
   DguOnQFR38EyK4V5IJhR39Up8VsKD4W9XbceRMwJRNca5KgcQHZuiw88N
   nCdtyJ2GiIsVAcz89rZmXwaVp6szMbM2kdHAYb6/XQ9L5LywxmB+4OR01
   B8iM4bsiumMsRqeAfqDMLdXix5A43r34ld3x7WV8DsRUe591hgT9xqEqT
   g==;
X-CSE-ConnectionGUID: L+a3HFtfR4msZyjdyfUmgg==
X-CSE-MsgGUID: vv3Pby5wSiiNCx/cWozmfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28207086"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="28207086"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 16:04:54 -0700
X-CSE-ConnectionGUID: awGXE9aQTEWKBKNlpVGSWg==
X-CSE-MsgGUID: wyUObQQQSNepTAv4AApuUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77862839"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 16:04:53 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 16:04:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 16:04:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 16:04:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHyVa7/JVF9RKqqtlUEBC0mWUHnDytZYe9PMgb+NaGx/cZMtWYxuUx6HTQdi1Bgvb5W+2/6IvIeOj+Kvgdc1eCFpXbEg6xpCRRpaLTeTVmN0Vw+fq3fv6aqIF+FFsDuwhlt0ocJdPz1JkHz/5zi0ROy5RiQ2GBtU9E8gWuWUtLT09bqbJryXDDlyYe9znpjnnhxvdSJfBxBL9YKYeOTO638p34wsqLC8NWfojT4GzgBYczaX6wVC9wxp0wiPuiT3GjtiLoFB2EGzJqFGI5Lm9bH4h5+57KVBWGxWeHk4zBBdMOK3zJa+U5sqVKqmsgTxHMSnObbjLdkBF7gstSdunw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5UsrbsiSmed0eq2wcy7Bk6pf7FtP2PUx1ZihgyG9Fs=;
 b=ZRBufTHSw4vHxoAncCP+nE1/rUzZC0RhzGn2c5xPXEhgxmltRF58WKCGTEJQ1nJYCTeyryjxbANOQsWfeowGgk+Qw9KRVNM8ZTta0ck4tEPPH8ctFaCQN/2NUCZU4A+1+US9fWlyOlayXsjSiW43DYFh+An2iSdWHnBSvaghJPiJUF2jP2AcvpqOUtL/+vKVKXMHli3WR2gostwU1AEGa3ZosvOUwCayYEOdPz9rGtU7F1Grp8DxwhoT/dmCSyLJ8/UujpELb7+660o1DyJs1ULVoX5zpBsXkuwdkv4lDZjW4M1Jha7NXv6BZAb8//pXIBB/2dKFPM+PXR26z0TNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by CO1PR11MB4915.namprd11.prod.outlook.com (2603:10b6:303:93::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 23:04:49 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%3]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 23:04:49 +0000
Date: Sat, 12 Oct 2024 07:04:39 +0800
From: Philip Li <philip.li@intel.com>
To: Matthew Wilcox <willy@infradead.org>
CC: kernel test robot <lkp@intel.com>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Linux Memory Management List
	<linux-mm@kvack.org>
Subject: Re: arch/x86/mm/pat/memtype.c:128:39: error: use of undeclared
 identifier 'PG_arch_2'; did you mean 'PG_arch_1'?
Message-ID: <ZwmvB1+bfWAaSSps@rli9-mobl>
References: <202410051828.Pb7a79Gu-lkp@intel.com>
 <ZwEvBunv7-JtcLdn@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZwEvBunv7-JtcLdn@casper.infradead.org>
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|CO1PR11MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: a91058e1-6e89-46f1-829f-08dcea491b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vOv2MfhdAPAxOQs7RApgJpf9iB1QZNBwLbm+vXjuTNB6xbbirWB1RQTbG3R0?=
 =?us-ascii?Q?Ymqai7ieyE7wePTcF7yijC55mDTB3eRb6mXqp5mD0wpvqh/vg+bl8yzbnBHM?=
 =?us-ascii?Q?VdQ+Itca2d6cqRQ/5d0AujIZeMAVxSXceI3XuUJztH3aQuZM0/StxFvOeqVS?=
 =?us-ascii?Q?6f0eyuh3BvCcFCuMErrOa2vbf8+YhW7p6Fcd1nOjAryh83sf/QYKMvycYA2v?=
 =?us-ascii?Q?J1M3YbmrGrSuuYRYtlCh1igkcC6Pz95AKyCshvRfh+VomjeESYAxRYtSlr7N?=
 =?us-ascii?Q?DLROI9/tjHByZH1OedzmdyFJDi2XZLcmU40t6+Oc8m9DOmUBZDCWxtT29Sk8?=
 =?us-ascii?Q?nLe+9vxF1FHwON7dVCRDlBQhYzyKRlG6OpuV3VmOBrYu8abAYTd6mNdpP+Fn?=
 =?us-ascii?Q?18wuOKWJd/F90LJQSrID3HtCv07P4JJZzGBtMi0yjdKRe2PLm1aBIwt1BHlX?=
 =?us-ascii?Q?EkNWoSOEBf+4M3VrRehPxytuUv3ppXeBCoC5+tXgEWdHsX4ghqGBnu4xGVl9?=
 =?us-ascii?Q?UAYMrq3avi7UkJOR7KCtZ93znC0oEeiGxAvpa/t1EZHuFmLog2P/SUw1kzJu?=
 =?us-ascii?Q?3w8B1TMP2+CGxxjHkJJgtSpytccyGR2KggeRqlqIWnFDoLXuhxmrCCvX/4FA?=
 =?us-ascii?Q?uUASycrgD0iy9kTPO7Va8QYQ+3yFIqfLBfgLzukYVYQ/7maIZHM6TqW2jRU2?=
 =?us-ascii?Q?avHemWCflA04V47DClmL7RBRihPjgpSkKhORDU+VWdrdGq77R2+S59ZxX690?=
 =?us-ascii?Q?Vme+j7adQ2d95HLREjEpLuzNUvggRYD+g7Um8FtybXv0uL+jnuJzhvk69yIg?=
 =?us-ascii?Q?2XJ9su56nKSR0dMmtiPfgyG4BhiQhzz69mGYe1f7sMik2Te85C9gDmioZ/7D?=
 =?us-ascii?Q?rJZr+72bHYML4lXujF+VP6OdQML8vSu4F3TjsRnc/HEJqDBoZcveGLdrKBBJ?=
 =?us-ascii?Q?Wvp2F3gLPwuMmo92iFCDNpLLd0EANr2SCtoB2N/sCCo29f5/R/koYE01P56Z?=
 =?us-ascii?Q?h30cX/NP3Gbl01iSGyaYiTRjPESRIcJKO6XN+HqhCPJLTFVKXzIIUmXhxUhm?=
 =?us-ascii?Q?uitZwnjkhCPSM0EAtnxAs2/3UgArc6apxbh9WCGN/FVVAPHwgKqzMA99qrsc?=
 =?us-ascii?Q?3bBgqeXHl3tEWes/6gj3iVJzh3TSNlpA5GBbt1w1t4h8BKTZigMs0aq8yPhT?=
 =?us-ascii?Q?bAVplP27WxvhfPzQkpsNCY3Du4bjtg1fShG2fAWwHtja4Y0zx8A7SVrMHMM?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q+bIUAIcYXp+ia5ZjfhNBXT7eRKy7/dKG0TzsnyqiUc9DEHsZ9KNnIb4Dycn?=
 =?us-ascii?Q?zvF+xRQ9VpNlt/nzDQzJfK2aJLuV35StCP6jot6K74zxFCFZr/e5tkAliprE?=
 =?us-ascii?Q?MP2rYjc6Jo3INUnu4gIbxsupBY+CAmkxGEwXVcnlpaFlWZNQylUN3STpLbIm?=
 =?us-ascii?Q?GdT6MmP812qxwxT+Be3cZAC5zJCzhyyEmxxqmP6mzKTibV/OZhjZMM0Rx5a5?=
 =?us-ascii?Q?hemFXQgbSvbCzyygtexYGGe3MqxDEACFQDU/VN0xP2dCOQxmbzgxrsiCTr8w?=
 =?us-ascii?Q?iZt+a2eihQqk4jvWI4+xb+Hogj9WtWz0G9iP0Q9DANiGL7MFh4NvL4lXLrY7?=
 =?us-ascii?Q?RZBlDmynzP06SSBCfXswB6vlfSoa1FwNUfpXmbZ0jJUTEk/xP+3DtquppAa/?=
 =?us-ascii?Q?lMtC8ybd3N/QIxMCYlcGlJZEjpiopxMpARSDUrnOmS3fZsCaJqN5h+QMeJkD?=
 =?us-ascii?Q?vE7zM7LrJZ4OmE2xtr9A+ImX2C63mZ6z38VfJL6aiTViVw/lCwgulaZmiRXo?=
 =?us-ascii?Q?3wqX49ohIAWFCuYK1+7boTvbp9qjBWZyfwb4GKe7jF4GWNA0RMHad2ZpQBi/?=
 =?us-ascii?Q?M347HW4bFhgfJCm5nLZOzopo2zWuPsgu/84crPisJdAZuKTTD7QZHpDzyBEZ?=
 =?us-ascii?Q?jRK3raAvbRO3VYAZ4r82WUm7MTe7baEQxfcXXLUHEiSRByoO2xEkbZkMKxfL?=
 =?us-ascii?Q?5YlMBSQpqSWTDY79oyee5hSpiSYrTrlaYkq5pX6wJQ2MTz5oCOamnUeDiy5D?=
 =?us-ascii?Q?16ymAko7yNrNccs8sGGpT3PKDNyd25ExOIUmNd9Cq+Dpnk87ub6MPg4Zxu17?=
 =?us-ascii?Q?1Ws/jIj4BsBGcghpiTITElCha0l++1U0Ud6cuSQEBudYp/0CrzXaDAkQP0nZ?=
 =?us-ascii?Q?WDCmm9IVtYSOFcQecBqEvp/w8JRrVZIohKwrykwnZCmcoyui+l8EDC06h2SS?=
 =?us-ascii?Q?UvKN0w19HvaDdnz41W8tISNePFY7+KMSCpD8UwKckL7Xz2usWNw2x7S9k61E?=
 =?us-ascii?Q?SkaKJ1dpt0OfYU3SD1hnTbUEfGKaQbkVN5vqSJRYUkFlLHMZ2SvbGfWkQTl5?=
 =?us-ascii?Q?59Usk1MZaTWL473bRmh5wYytCdRFClbOP3zylr4gj/dkZqUvT3sjHwpBczuF?=
 =?us-ascii?Q?Z9qHlGd7dDgCl7jEVq7AKKCbj0mi8KUL/nVb7276nWF4ncNjZ6qFXdEO5bX9?=
 =?us-ascii?Q?NnZ+2mrLdpR0hhIWgcHAVIJIlYEFhYheBpZpTPoh+pUql6p2aV3noBaD+DHm?=
 =?us-ascii?Q?mqFCCUXR6ulq7uFFd++CbVYTrHWLe22psVoEbMoQEDDoG5HLI95TVqYs5uY2?=
 =?us-ascii?Q?xKbDbjTJ6eB1ErG0ETspoL/uKKzG1fe36aReffeiHE2R0X8dmdX0R0aE1crl?=
 =?us-ascii?Q?Mml4t7fyGw65z0wFgPaOYxkuI2H3z/XIu9cSmCmG+BhC9YVBIUyfWuDL+YiO?=
 =?us-ascii?Q?AN5Xz7I+rvQjh+ouvR6BeMX+HMyWpUXsCqcV1CN1JcmzDcJAtz5yfMnseydY?=
 =?us-ascii?Q?buLu3/GOzFOAN8Ae6p+xUcnW32qqKKeTjjV5qjDYv9pJoRegGrLS8UwbjVhx?=
 =?us-ascii?Q?e/Df59+AIGkskHPz05cfc06fSUy7x5+bKMHvwnjZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a91058e1-6e89-46f1-829f-08dcea491b6b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 23:04:49.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNjuAJidGJ1EGE+Uw7I5UPND3WN52I28jPj5PbD3KC+JTEEK/C3SQB/+8ZR/FRczRJib0GrpLx0sMKhvQSbTsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4915
X-OriginatorOrg: intel.com

On Sat, Oct 05, 2024 at 01:20:22PM +0100, Matthew Wilcox wrote:
> On Sat, Oct 05, 2024 at 06:11:14PM +0800, kernel test robot wrote:
> > commit: 7a87225ae2c6c317c7b80cf599e5cf0eee699196 x86: remove PG_uncached
> > date:   4 weeks ago
> > config: x86_64-randconfig-003-20241002 (https://download.01.org/0day-ci/archive/20241005/202410051828.Pb7a79Gu-lkp@intel.com/config)
> 
> Hum, works for me with both gcc and clang-17, but that shouldn't make a
> difference here.  The config has ARCH_USES_PG_ARCH_2 selected.

Sorry for this false report, it can't be reproduced. We will look into
this to resolve the issue in the bot.

> 
> > compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410051828.Pb7a79Gu-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202410051828.Pb7a79Gu-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> arch/x86/mm/pat/memtype.c:128:39: error: use of undeclared identifier 'PG_arch_2'; did you mean 'PG_arch_1'?
> >      128 |         unsigned long pg_flags = pg->flags & _PGMT_MASK;
> >          |                                              ^
> >    arch/x86/mm/pat/memtype.c:123:29: note: expanded from macro '_PGMT_MASK'
> >      123 | #define _PGMT_MASK              (1UL << PG_arch_2 | 1UL << PG_arch_1)
> >          |                                         ^
> >    include/linux/page-flags.h:106:2: note: 'PG_arch_1' declared here
> >      106 |         PG_arch_1,
> >          |         ^
> >    arch/x86/mm/pat/memtype.c:134:23: error: use of undeclared identifier 'PG_arch_2'; did you mean 'PG_arch_1'?
> >      134 |         else if (pg_flags == _PGMT_UC_MINUS)
> >          |                              ^
> >    arch/x86/mm/pat/memtype.c:121:33: note: expanded from macro '_PGMT_UC_MINUS'
> >      121 | #define _PGMT_UC_MINUS          (1UL << PG_arch_2)
> >          |                                         ^
> >    include/linux/page-flags.h:106:2: note: 'PG_arch_1' declared here
> >      106 |         PG_arch_1,
> >          |         ^
> >    arch/x86/mm/pat/memtype.c:152:19: error: use of undeclared identifier 'PG_arch_2'; did you mean 'PG_arch_1'?
> >      152 |                 memtype_flags = _PGMT_UC_MINUS;
> >          |                                 ^
> >    arch/x86/mm/pat/memtype.c:121:33: note: expanded from macro '_PGMT_UC_MINUS'
> >      121 | #define _PGMT_UC_MINUS          (1UL << PG_arch_2)
> >          |                                         ^
> >    include/linux/page-flags.h:106:2: note: 'PG_arch_1' declared here
> >      106 |         PG_arch_1,
> >          |         ^
> >    arch/x86/mm/pat/memtype.c:155:19: error: use of undeclared identifier 'PG_arch_2'; did you mean 'PG_arch_1'?
> >      155 |                 memtype_flags = _PGMT_WT;
> >          |                                 ^
> >    arch/x86/mm/pat/memtype.c:122:27: note: expanded from macro '_PGMT_WT'
> >      122 | #define _PGMT_WT                (1UL << PG_arch_2 | 1UL << PG_arch_1)
> >          |                                         ^
> >    include/linux/page-flags.h:106:2: note: 'PG_arch_1' declared here
> >      106 |         PG_arch_1,
> >          |         ^
> >    arch/x86/mm/pat/memtype.c:165:28: error: use of undeclared identifier 'PG_arch_2'; did you mean 'PG_arch_1'?
> >      165 |                 new_flags = (old_flags & _PGMT_CLEAR_MASK) | memtype_flags;
> >          |                                          ^
> >    arch/x86/mm/pat/memtype.c:124:28: note: expanded from macro '_PGMT_CLEAR_MASK'
> >      124 | #define _PGMT_CLEAR_MASK        (~_PGMT_MASK)
> >          |                                   ^
> >    arch/x86/mm/pat/memtype.c:123:29: note: expanded from macro '_PGMT_MASK'
> >      123 | #define _PGMT_MASK              (1UL << PG_arch_2 | 1UL << PG_arch_1)
> >          |                                         ^
> >    include/linux/page-flags.h:106:2: note: 'PG_arch_1' declared here
> >      106 |         PG_arch_1,
> >          |         ^
> >    5 errors generated.
> > 
> > 
> > vim +128 arch/x86/mm/pat/memtype.c
> > 
> > 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  125  
> > 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  126  static inline enum page_cache_mode get_page_memtype(struct page *pg)
> > 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  127  {
> > 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16 @128  	unsigned long pg_flags = pg->flags & _PGMT_MASK;
> > 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  129  
> > 35a5a10411d87e arch/x86/mm/pat.c Toshi Kani      2015-06-04  130  	if (pg_flags == _PGMT_WB)
> > 35a5a10411d87e arch/x86/mm/pat.c Toshi Kani      2015-06-04  131  		return _PAGE_CACHE_MODE_WB;
> > 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  132  	else if (pg_flags == _PGMT_WC)
> > 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  133  		return _PAGE_CACHE_MODE_WC;
> > 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  134  	else if (pg_flags == _PGMT_UC_MINUS)
> > 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  135  		return _PAGE_CACHE_MODE_UC_MINUS;
> > 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  136  	else
> > 35a5a10411d87e arch/x86/mm/pat.c Toshi Kani      2015-06-04  137  		return _PAGE_CACHE_MODE_WT;
> > 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  138  }
> > 0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  139  
> > 
> > :::::: The code at line 128 was first introduced by commit
> > :::::: 0dbcae884779fdf7e2239a97ac7488877f0693d9 x86: mm: Move PAT only functions to mm/pat.c
> > 
> > :::::: TO: Thomas Gleixner <tglx@linutronix.de>
> > :::::: CC: Thomas Gleixner <tglx@linutronix.de>
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 

