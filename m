Return-Path: <linux-kernel+bounces-315347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1833596C157
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F56283479
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD6C1DC05F;
	Wed,  4 Sep 2024 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKJc9mcO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B126C1DCB10
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461688; cv=fail; b=J5UJC4KneGdPZBkJhPvvVyEIdP93bcotZWG0+5F2IrEA3uDGwUyDsf1iZxUHCBFtRFmNE/i2MmYUXFHYI8ubQADjUVcVlHMbaqGz/sifUJAUuLEHXXJr+BjlCKbmu2TSbuKKCBsNdWiS4H8B+i9lKO/RfD0SjY195V1hlMQsd/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461688; c=relaxed/simple;
	bh=VZW0FFlicnTHckLOTcIEuZQJA4NNB5ed89Z0f/wqZX4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rf28oWTuF5/vNTqc9DeWD4hD2vYZw/jdZQZiU+wko5jR3+rpYSSiwPOkaIEI7kFTirlPqTTtvVJgEV2/jFc4fFqSvz+A4SiIY8bK4DTBecyXDrZPvd5jSazlYXua7qEoS5F6jB++LvXh4v8ZTNgelR5yVqgcHvashmg+QRwUoyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKJc9mcO; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725461687; x=1756997687;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=VZW0FFlicnTHckLOTcIEuZQJA4NNB5ed89Z0f/wqZX4=;
  b=AKJc9mcOYp4zDEce0HTfnmpf3AcI7myNeoZWG+YBFEPmMxgA+jwk+Lf8
   TRTWq4dFIXpzrQmqQiy/zrWU2kZOvU28tzmfGvOh/aydcky5P2ciU72js
   chfUuM+gEbs91oUQuzHQzgcL2gssHX/mE/SgfkK8z3tPAD1R4inUoPya0
   QdzJfKO5OFool63VW6O/zfG9l6L7e8zwABUXrqdmPFq6LDmVpGDdII0IY
   lmQz7KDqwJLcUHycvYVvK1vFoDzVG5lsUSunCi1SenzGUx1+fu8LNZ6h9
   1oiLSrfBuayxEwVCOaaOIUr+4DCcit+XFdZppbWcsDue/hrtqfXfoyRPt
   w==;
X-CSE-ConnectionGUID: nkWNdL//QkC0h2e7MltR7A==
X-CSE-MsgGUID: j4kh5GZwTnqxjLq4JjXFrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34697734"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="34697734"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 07:54:45 -0700
X-CSE-ConnectionGUID: kJzxdUrSQFyh6y7RpGW/Dw==
X-CSE-MsgGUID: 9UUYyyaaSACKIk8soYs2KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="66025581"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 07:54:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 07:54:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 07:54:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 07:54:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 07:54:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrUzWSipeQAGQV/JlAbS+rcvEpo82hWXR0nkn/7QhfVD/FPsEfX3N1rFZ2NisiKVuxxlNnMcebhboUiXViwFY0wYF62nEGwz/ucVBn8AFQjXBJ30ztc4TWdrAr1orPBkJU9qAXxvqCz6sL0nd/XguuhPbPZvEei6t6oCWQoRoucWAki4MZSmOu3jXZD2P44IZprEmtWgXta7+ad3Bp7IacB6PXlzj2ajB45ZjltBXCa2YB4V3fJdJ8RSnipj/h7cQ4yjP0DrO5WlMGw7xb4hUS+N7jwosHiv9/yj6BMqCKPP9kF4gtrMZ/12C9XKpGaT1Qv4ewaEfaarBxzZenAP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74pKGhMTV819C/EYnn7DWUVm13TkzFccqh8kUM7X6xA=;
 b=tCPF4X5myDGTXyubR4igxY+dJDzyPY3KRua8QXUYrcrA68dmOOaVfurA7FHTfuX0JbTpDMH+04x9EcVA4YeP+gW7QgYCV3C7Jsq3ExpXHR5fLv9DEnt1Seo4JNblzBFHaiOjLJ85JDyQRL/ZZmZc7IfyDZRmJuU4frkQdjlaTy/7tnJlmZXEvxRZgs7iFinqT/nfqMtXPm40VNaPKE6u/nIq4J0eeCiMgLCaOP53eYUIUTKeSvRwNwW2iq7q6ddTmPi+3sExcQh6U3sWkc8/Ld3NDOFC+9/t1nAo9c09UgUPBhaf722THi3yT7zKR8B3h00wbsMnZXRRTbMfrTzEeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV3PR11MB8579.namprd11.prod.outlook.com (2603:10b6:408:1b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 14:54:33 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 14:54:32 +0000
Date: Wed, 4 Sep 2024 22:54:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Rong Qianfeng <rongqianfeng@vivo.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <vbabka@suse.cz>, <mgorman@techsingularity.net>, Andrew
 Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, "Kirill
 A. Shutemov" <kirill.shutemov@linux.intel.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, Rong Qianfeng
	<rongqianfeng@vivo.com>, <opensource.kernel@vivo.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] mm: Skip the reserved bootmem for compaction
Message-ID: <202409042247.af2035c5-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240902122445.11805-1-rongqianfeng@vivo.com>
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV3PR11MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdde88f-2323-49b0-0c8a-08dcccf17c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QccpCwHoXtaU6gd3EMm8RisFWd6bQXwVl8VpwNSvs8bkp+Ci0zIeJ/mMihoj?=
 =?us-ascii?Q?UQVymb1cNt/R4JG7ca+6IcZYfP5v3//jeeDTbAjd+qSFsgitbPzqDh4Lg/En?=
 =?us-ascii?Q?IrYg0YtVRrr2mISXpZ55v/mCj9UgQWggQgY9CfP2H9NZAQ/RNH4U9JCF6Toh?=
 =?us-ascii?Q?YcAu/4S88aY05u3XQc44ijLlVkSxH56+9019zRLawMhcH4/lNro8YOQUjoii?=
 =?us-ascii?Q?t5fABgefndIGxUBArGxPPy47WBbtb6ee6B1ud+qfUE98d7WitwkHLmqEAFon?=
 =?us-ascii?Q?iC58Jfvwak+w54SV3v/+M8GAprn2qeWdxy/iq8cst4ll69qBUMImJYVmd9N2?=
 =?us-ascii?Q?EsSApX25hgQ3WOvIMXuEPhEcKz705H1DJnzexvuvwdJWpbotNRZAGkKZYaDu?=
 =?us-ascii?Q?Y8ybfcZYAbootTIeSjiBM+zfwITBNevQkkiTgaosUuFHOMgIY8NVVyxTEG5t?=
 =?us-ascii?Q?zbTm8GpVyaU1gxbrHqpI6OzW6Srka/haAosZyuope7nPAuelGHwFA/swugWF?=
 =?us-ascii?Q?qthvYNZ19CRAFgSs7xktI7L01dlUaYAakmqWzDk4Ez0hBKQ5+0YN+xPbUejB?=
 =?us-ascii?Q?11y+qldHCYF64YsAxvl/6JjEO+rEXET5LR2Hw1j4Ozz0nnyNXi7iPepgD9Ol?=
 =?us-ascii?Q?ATvPtTLo7hWAEhmBYC7cO1F1WAr9TOnwREfyA/XqAjJiCeU6a2kR6GgBkQF7?=
 =?us-ascii?Q?N/mUDdjnVxQY2opj4ilePAuViD5V0TkD5YrYEbP7e6xTx/p0re6TpCraXl9/?=
 =?us-ascii?Q?kZV19Ng4QM+1V/mRpirP58s5VEIqkcWYlqDBbxMVnmlC3tkghBMywSsrlZle?=
 =?us-ascii?Q?LudzUoivJ6XUYd2Kgy6P+PR5XspAjm/loAHelOp1yn6IruJ/ehihI27cbOk2?=
 =?us-ascii?Q?tTdxEuQgdQkFmhwoQg8W6NH2PuYNgbZC+HpoIHOtvbnHwfQaGKnWj3NIudiV?=
 =?us-ascii?Q?WPFlHqzx/QUF/u+GI3tnq4Izb5CDTxdYffA+bpR3gCOCsTwoFvHkvmZFXHQV?=
 =?us-ascii?Q?PTEgUdGKZQQvzi6DE3kmIpoFmfT1CNsw7NbJPcSBt8/rNQUc+bON7X1FzNLL?=
 =?us-ascii?Q?ZhZiIu5JYST2Z1chuAlO8MW9EbwX+UYoM8/PSzBJNxPhALhDWPP+OL8gM8r4?=
 =?us-ascii?Q?0UZ34ZKBZdQFKCIzuG85g9+mjJ6x3EHlfE1PKsxV8yH0U1NGjatfZPkJN3h9?=
 =?us-ascii?Q?YNPsTkbrVZtL/ylp5MxGSGXZaZ2lzPeGGA0uM4V/2kdDxLUW+xnm5z3fpP2Q?=
 =?us-ascii?Q?R8rZtUoxZIjNVGaNPbtXzg1QlLi3BGmh/sJnndS0p3WQ/ICT+IFhqjzCLcV1?=
 =?us-ascii?Q?xHI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?75bs0+8/W/Y++dbPM37CW9bDQ/HvWPEDo8aKUfYP6u3iwTz/35mO6kjuRo9o?=
 =?us-ascii?Q?f6xzAifA3eCqEqYlOdOlqwG7pB6JzPbEMjAvLyxwr6tgE4fAaphQz45etFzM?=
 =?us-ascii?Q?2iKoIQdX/+RJ06uCIhRKL/qvOojxlD6+HCJS+ne5k7SO1cJg3kkfI4j8HLa+?=
 =?us-ascii?Q?SS0o3hbRSSHEN2i+HAYgRkhCnnCR1/Xz+aqD6MQwRSSvNj4Z1e9FudjlYpoY?=
 =?us-ascii?Q?VgUfrOumihuP/PgQvhLj4ku236ILkymt0tjte3B6wmOAvHbifAVXNIJmWpLE?=
 =?us-ascii?Q?7dffjxB0L/0yXT+4L6psL3+zpMvsM1tkGfzogctEOAFyJhHVupAWUIMSgSP+?=
 =?us-ascii?Q?K/z1wIYyXeNWUuqtkd1s9U/fCbn7tMo5/Lh4BsQcYvAbnJVBT87kRBgeaaxh?=
 =?us-ascii?Q?EthZCaak1N1P+ugktyp4IOcpO/byg6HOYpCurv0UwVQKXSFBz2W+x6Rb7ZNW?=
 =?us-ascii?Q?JRzNd1iHXhBF0r4rih+E3Qs8RQhSSWdUuLprj6E1FL86JpF51TUAF38+Nn/U?=
 =?us-ascii?Q?dE8tMX4XtC+5l5FlDo5ZqCmGU+Pi7W6p9HJnqmXfxCHI9NX5/8qT1vD/4gj9?=
 =?us-ascii?Q?Gc/+nNLZZPPmOdh2oAu+jqmVqxfEIiS11OZZl+WBpK2J3HLB7pQgCkan3ja0?=
 =?us-ascii?Q?u534i54UauGFfLbmvBqnnjBrTClgWzAyvOJU5hZARJvgaLbccDYhAhSkvYWm?=
 =?us-ascii?Q?r8yDCh4mglBCmkzqJS58oEoPR3aAF4+95e/XHM7lK1m/oNPOuxN9WWo27B2A?=
 =?us-ascii?Q?KH+xuCsVsz7j3HU8hp65YkoeeciHeMoMEuoinEGMHhgAY6KP4XCwHYVPKQig?=
 =?us-ascii?Q?eVU1PDwiInzj+lVbNGd2VpVAYKQHpVVLifXtZRGIjjY/HyJHqRypQFpQ6Gfh?=
 =?us-ascii?Q?2uNQYgHcAlij5YwgDXRevTHUdbIW9ClrGxa82dGdkYPNEC7GVoCsOwCrUziy?=
 =?us-ascii?Q?YGUg9dHqXP4qshsthZInRAn/YDFWbw/3NavGBQdCKQIoovU5yAb6cOt9s8t2?=
 =?us-ascii?Q?Nb0ywNdyhJPJXO8x3NVXF6JoyYysXb8BjnwQ4Ctq96PkNf8CpGpj49OHRKkq?=
 =?us-ascii?Q?jU+sj2PKPgYn25trtYha1AcQ74nDNl0Tpc/CdBZkdNjJRMiSinW7Ny7HfxZ7?=
 =?us-ascii?Q?WrShCNcFnJqy7f8+MIuavk/sPIwAmqAEFTDE62FP5Z2lA6l87D/y46RNXgwU?=
 =?us-ascii?Q?KOFHWjSPwRzP2RiKpDwm767EimZ24UhDVhicQAUPkMclavnEdafg1mBt28ZQ?=
 =?us-ascii?Q?aCvD9qgDjfWHSWvQUhKopFfDQsrN+crcjWOxYco++1o1GvSEpz5186ihJpSs?=
 =?us-ascii?Q?zdiinbBYdwMPJ9CVb+MYu/qMuAOwN+GcYzLRm+m+3VqsjSrsK529273cIGUw?=
 =?us-ascii?Q?amI+jWRfmcrKxZkyn/FVkCjRs87buil1EJzbQMaaqqtuWyPqVI+i9mMeneDp?=
 =?us-ascii?Q?yUlZlks7ufvlwkPzrpHF49QEaLiUzZoscYP1Y4RgkEultHomLHiJSkChRfAs?=
 =?us-ascii?Q?WVtKmKLubk2I36uaGNfp+2EjBGGplUEpUYwSCxe3j8G8z2kPBEJOSS53CLEP?=
 =?us-ascii?Q?Jiw6TgT9FvRHyELHb6ZKvEkt7Zj/uyXpqdKLTVXznPAHmEWvQQa6KavPUeiO?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdde88f-2323-49b0-0c8a-08dcccf17c79
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 14:54:32.9051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBK6lW8iJdjahllySDsXUOFg9gAC+bU/lvL78rT7N9uKObe52U3agzRwPFBs8UZb4iaYCk8sSC1yg7EF2gkaIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8579
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_arch/x86/mm/physaddr.c" on:

commit: f28b14e8a99199dd7a5a22c621168f9c8788352a ("[PATCH] mm: Skip the reserved bootmem for compaction")
url: https://github.com/intel-lab-lkp/linux/commits/Rong-Qianfeng/mm-Skip-the-reserved-bootmem-for-compaction/20240902-202706
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20240902122445.11805-1-rongqianfeng@vivo.com/
patch subject: [PATCH] mm: Skip the reserved bootmem for compaction

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------+------------+------------+
|                                          | b69256811d | f28b14e8a9 |
+------------------------------------------+------------+------------+
| boot_successes                           | 12         | 0          |
| boot_failures                            | 0          | 12         |
| kernel_BUG_at_arch/x86/mm/physaddr.c     | 0          | 12         |
| Oops:invalid_opcode:#[##]PREEMPT_SMP     | 0          | 12         |
| EIP:__phys_addr                          | 0          | 12         |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 12         |
+------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409042247.af2035c5-lkp@intel.com


[    7.664934][   T32] ------------[ cut here ]------------
[    7.665373][   T32] kernel BUG at arch/x86/mm/physaddr.c:81!
[    7.665816][   T32] Oops: invalid opcode: 0000 [#1] PREEMPT SMP
[    7.666289][   T32] CPU: 1 UID: 0 PID: 32 Comm: kworker/u10:1 Not tainted 6.11.0-rc6-00524-gf28b14e8a991 #1
[    7.667024][   T32] Workqueue: async async_run_entry_fn
[ 7.667427][ T32] EIP: __phys_addr (arch/x86/mm/physaddr.c:81) 
[ 7.667767][ T32] Code: 5e 5f 5d 31 c9 c3 0f 0b 68 18 6c f9 c1 e8 5a 69 4f 00 0f 0b 68 28 6c f9 c1 e8 4e 69 4f 00 0f 0b 68 38 6c f9 c1 e8 42 69 4f 00 <0f> 0b 68 48 6c f9 c1 e8 36 69 4f 00 90 90 90 90 90 90 3d 00 00 00
All code
========
   0:	5e                   	pop    %rsi
   1:	5f                   	pop    %rdi
   2:	5d                   	pop    %rbp
   3:	31 c9                	xor    %ecx,%ecx
   5:	c3                   	ret
   6:	0f 0b                	ud2
   8:	68 18 6c f9 c1       	push   $0xffffffffc1f96c18
   d:	e8 5a 69 4f 00       	call   0x4f696c
  12:	0f 0b                	ud2
  14:	68 28 6c f9 c1       	push   $0xffffffffc1f96c28
  19:	e8 4e 69 4f 00       	call   0x4f696c
  1e:	0f 0b                	ud2
  20:	68 38 6c f9 c1       	push   $0xffffffffc1f96c38
  25:	e8 42 69 4f 00       	call   0x4f696c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	68 48 6c f9 c1       	push   $0xffffffffc1f96c48
  31:	e8 36 69 4f 00       	call   0x4f696c
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	3d                   	.byte 0x3d
  3d:	00 00                	add    %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	68 48 6c f9 c1       	push   $0xffffffffc1f96c48
   7:	e8 36 69 4f 00       	call   0x4f6942
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	3d                   	.byte 0x3d
  13:	00 00                	add    %al,(%rax)
	...
[    7.669203][   T32] EAX: 00000000 EBX: 0000fd5f ECX: 00000000 EDX: 00000000
[    7.669353][   T32] ESI: 2e7fe000 EDI: ee7fe000 EBP: c3223e74 ESP: c3223e6c
[    7.669353][   T32] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010287
[    7.669353][   T32] CR0: 80050033 CR2: 00000000 CR3: 02617000 CR4: 00040690
[    7.669353][   T32] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    7.669353][   T32] DR6: fffe0ff0 DR7: 00000400
[    7.669353][   T32] Call Trace:
[ 7.669353][ T32] ? __die_body (arch/x86/kernel/dumpstack.c:478 arch/x86/kernel/dumpstack.c:420) 
[ 7.669353][ T32] ? die (arch/x86/kernel/dumpstack.c:? arch/x86/kernel/dumpstack.c:447) 
[ 7.669353][ T32] ? do_trap (arch/x86/kernel/traps.c:? arch/x86/kernel/traps.c:155) 
[ 7.669353][ T32] ? do_error_trap (arch/x86/kernel/traps.c:175) 
[ 7.669353][ T32] ? __phys_addr (arch/x86/mm/physaddr.c:81) 
[ 7.669353][ T32] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 7.669353][ T32] ? handle_invalid_op (arch/x86/kernel/traps.c:212) 
[ 7.669353][ T32] ? __phys_addr (arch/x86/mm/physaddr.c:81) 
[ 7.669353][ T32] ? exc_invalid_op (arch/x86/kernel/traps.c:267) 
[ 7.669353][ T32] ? handle_exception (arch/x86/entry/entry_32.S:1047) 
[ 7.669353][ T32] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 7.669353][ T32] ? __phys_addr (arch/x86/mm/physaddr.c:81) 
[ 7.669353][ T32] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 7.669353][ T32] ? __phys_addr (arch/x86/mm/physaddr.c:81) 
[ 7.669353][ T32] free_reserved_area (mm/page_alloc.c:5895) 
[ 7.669353][ T32] free_init_pages (arch/x86/mm/init.c:927) 
[ 7.669353][ T32] ? populate_rootfs (init/initramfs.c:691) 
[ 7.669353][ T32] free_initrd_mem (arch/x86/mm/init.c:987) 
[ 7.669353][ T32] do_populate_rootfs (init/initramfs.c:?) 
[ 7.669353][ T32] async_run_entry_fn (kernel/async.c:136) 
[ 7.669353][ T32] process_one_work (kernel/workqueue.c:3236) 
[ 7.669353][ T32] worker_thread (kernel/workqueue.c:3306 kernel/workqueue.c:3389) 
[ 7.669353][ T32] kthread (kernel/kthread.c:391) 
[ 7.669353][ T32] ? pr_cont_work (kernel/workqueue.c:3339) 
[ 7.669353][ T32] ? kthread_unuse_mm (kernel/kthread.c:342) 
[ 7.669353][ T32] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 7.669353][ T32] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 7.669353][ T32] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[    7.669353][   T32] Modules linked in:
[    7.683090][   T32] ---[ end trace 0000000000000000 ]---
[ 7.683500][ T32] EIP: __phys_addr (arch/x86/mm/physaddr.c:81) 
[ 7.683844][ T32] Code: 5e 5f 5d 31 c9 c3 0f 0b 68 18 6c f9 c1 e8 5a 69 4f 00 0f 0b 68 28 6c f9 c1 e8 4e 69 4f 00 0f 0b 68 38 6c f9 c1 e8 42 69 4f 00 <0f> 0b 68 48 6c f9 c1 e8 36 69 4f 00 90 90 90 90 90 90 3d 00 00 00
All code
========
   0:	5e                   	pop    %rsi
   1:	5f                   	pop    %rdi
   2:	5d                   	pop    %rbp
   3:	31 c9                	xor    %ecx,%ecx
   5:	c3                   	ret
   6:	0f 0b                	ud2
   8:	68 18 6c f9 c1       	push   $0xffffffffc1f96c18
   d:	e8 5a 69 4f 00       	call   0x4f696c
  12:	0f 0b                	ud2
  14:	68 28 6c f9 c1       	push   $0xffffffffc1f96c28
  19:	e8 4e 69 4f 00       	call   0x4f696c
  1e:	0f 0b                	ud2
  20:	68 38 6c f9 c1       	push   $0xffffffffc1f96c38
  25:	e8 42 69 4f 00       	call   0x4f696c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	68 48 6c f9 c1       	push   $0xffffffffc1f96c48
  31:	e8 36 69 4f 00       	call   0x4f696c
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	3d                   	.byte 0x3d
  3d:	00 00                	add    %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	68 48 6c f9 c1       	push   $0xffffffffc1f96c48
   7:	e8 36 69 4f 00       	call   0x4f6942
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	3d                   	.byte 0x3d
  13:	00 00                	add    %al,(%rax)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240904/202409042247.af2035c5-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


