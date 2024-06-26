Return-Path: <linux-kernel+bounces-230318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504F0917B36
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CBD2845F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08A9166302;
	Wed, 26 Jun 2024 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDoK5A4R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C6315FA73
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391491; cv=fail; b=P7ilPj7NdYUflCTpkOU0vy1j6wuZA59qZnb39IvsMYkmur/HZZqkvg7jXLeBKEMByi19gMSWpN3qQKXxS3+7o1Maem6l49p4xQjSVoAcnfs+4dx5+ji+mSCu9yTKA61xDVIYLbvTb8P2CvMGSrReIzEI0eGVmMjEE8HB2WWbAf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391491; c=relaxed/simple;
	bh=anBoEFSvileDmK1sxjMg7WvuCHp76N7AzZ2tktoVWXw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UEkpB+zTfYApiBU0hJxFmsmr8yXpgwNwWwndvKQJY81AjnuDqtpiSiYA7UNPPXhgHDAifFjW8mgCuBuk5G7OilzSXL1Qw5HGDP6xboHrrPHfEOrlJHNYT8Guk72aHX1jHCFVpzI4kzuv3P+pMq1nElh1Xqu094AxNUvEdesOz1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDoK5A4R; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719391489; x=1750927489;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=anBoEFSvileDmK1sxjMg7WvuCHp76N7AzZ2tktoVWXw=;
  b=BDoK5A4RHCrH3x7uCnxqqtwbX79M9C5C4AYTFeKGpQzL789M/dTcjvoU
   rI8juBLYmH/sQpsoFLWFEctwypGmJWIHf/8jfRnHgw9PNDaQVNGOUeBfk
   IdNL4iMm2IGrCBgZTzXckaj497hYFH+wezX4JMUv8nVYNuR9LlU7FjeOQ
   9KwReQd3JgHRyqgLwI7PruMFvSwlYi772kv2COVmgkgNKFfu87M6oTlCn
   GoL/asGkJcnLK+0fde+kYrbgivJYpLzHF6uvUrujfuZvBNeaVTqf1wi4p
   vMP3cPxLRmQYCUYmRBps/ukqqBcO9gsaJLkT1eehOSkvLvgpUzyZe0mpT
   A==;
X-CSE-ConnectionGUID: vMOYKPyTScCJzVEgcgcAaA==
X-CSE-MsgGUID: o20MG1thQXefVmEwa2RPsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="12254670"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="12254670"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 01:44:48 -0700
X-CSE-ConnectionGUID: BgHB9OXNTTuQmQKksKOsMA==
X-CSE-MsgGUID: 5n+Nsn7xTOm2ucEeO+W19w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="44003056"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 01:44:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 01:44:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 01:44:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 01:44:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDkl2fkJ0b2QbXvsb50iJ0JOSLbKteAkaudNANG3afGFyQVEjh1f9/syjwGWtnbDDR/549Sq/fyyt3ohuWUFgb6pwQrsiv1UdKfmJ2WjXS9tLpowNN2U8u02C3dSb1DgRuIZ4IMDofuAz2kR0rSQ3xVjx0K5SfA0V7lP2AXtK7esfXKVeI92SZGWbOlvlYTBf9D4+opNgnoPtO0Aczi4+wBL8g5t3uli58JfErxd0mS+XhxNyc00Kwr3bPYt6GJL02Q0QhiHPKITHT43i5sEluIcByUqqTRk/dkaTjopgNRrBEgc2l+TUHCAIfrB07a9WLk+H+aRDXv+6yI2pdoOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbyjpuSdv2N3bVv395OHEForF1fOvyp6VVbUdDLuDBE=;
 b=GffZnd8EeC02f8Ui2KtdDKeJwR73k+MRlxIgyQHpeCzsbB5DsqyUUF6VUAX/F6GiK6XtumHRyFbEu6tERJ/tvrto9K+eIt9PO8nSmDFBvYRrXpyJ+Zrg7RTKIDoC1DD/kTle/Y0T6G09LxDFdpUpXhWSlXnda6qTnxI0czBvHa9tOKRFeGNiYXJALdvOwuLLx3j169W1XTkK5zuLKWb6ormBf5xgJW/5RjEJvxrzTvtTTB7G1uTzlKqOtKgSpP6iv3P+v537Lhe1IJgQ2imJK0kP5iOyjY3EDZfgIhn6eoeBDdTGTL7MgQ58DVVMzZjioOd9lU/QpGAWquUZ/DnoYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SJ0PR11MB8294.namprd11.prod.outlook.com (2603:10b6:a03:478::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 08:44:45 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 08:44:45 +0000
Date: Wed, 26 Jun 2024 09:44:37 +0100
From: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Xin Zeng <xin.zeng@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
	Yahui Cao <yahui.cao@intel.com>, Kevin Tian <kevin.tian@intel.com>, "Herbert
 Xu" <herbert@gondor.apana.org.au>
Subject: Re: ERROR: modpost: "qat_vfmig_suspend"
 [drivers/vfio/pci/qat/qat_vfio_pci.ko] undefined!
Message-ID: <ZnvU9bTsh6CUMYO7@gcabiddu-mobl.ger.corp.intel.com>
References: <202406220635.PsQbyfY9-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202406220635.PsQbyfY9-lkp@intel.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DUZPR01CA0205.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::18) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|SJ0PR11MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0a7343-e4e6-4bd4-5ea6-08dc95bc3ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|376012|366014|1800799022;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iBi1OA/z+4qvtq8QzeYorIlABYs1tTqOR0+z6jxhiCqPT1sNE9TeKjbLtMrQ?=
 =?us-ascii?Q?J/fRS/rBKTkRJixM0Y7oLw3uqwZb88lMJ2LrZJ9mnCfUnlhNQDWbgIJUybS0?=
 =?us-ascii?Q?eUA/T/U26t0wtxwI23CLPqxeDrTQdi70knHrKcHTmXKfstJAEM8hlkLcR2qW?=
 =?us-ascii?Q?H+GpPTRAG3azoEkSbAzd6FoX2wFGOCgXw+FZMaMg0huIKfsmL4419WMasqcP?=
 =?us-ascii?Q?DwsnsgH/e3CgcGT9A1xT+rsdMuJOaLehSilPVWIaSyqBywAWiK/LLbzv5xFk?=
 =?us-ascii?Q?mBD75HTncPU+ON/q7dEVBBy6tqClyFpvejjQKZJr8rQvdVP5424Z+K6LDIFq?=
 =?us-ascii?Q?hykxCkcXogiOEGA18W/qpuc8BtKU2WCW17LN6tTZlRZJKtW+B43TcGSAKbi1?=
 =?us-ascii?Q?jnn+UHoYkc148eLGevzLySUihXxWdvTZa2PeJMz2PFU/sngAOitBujBOFLyo?=
 =?us-ascii?Q?t3p2ukKvroMOVTaAFEyO9QVSdI/ppMpaaut76AMnI1Pd0DTzFU3EVsiSyYkX?=
 =?us-ascii?Q?i+e2Taxqfx15qqWHGlO7fnEHnPLEauuq4IKhajSUEjYe/EmqmCDhMf4BsmA2?=
 =?us-ascii?Q?Gtr6R+pjkjsF9NdsjyjJmY6ioEJpOYEQxlMKnuc/i654t1/7elt6G5eoqR4t?=
 =?us-ascii?Q?9kIM/+ZiI2kb1ozO8H984mGV7w03LVX7HjfDX6+3ZuPHiH5JLApFH6t+x4c5?=
 =?us-ascii?Q?jNVZkVqTpV2mz8KfWtkd0V8y9xffBZdYA7mdx/ZZu0G3ZCLTNDYqBBBIk52L?=
 =?us-ascii?Q?FKXdEvt6OSsoQAVKPz19WQEBtxb64mZHKaJAtbT9unn8vNPKuh8/TuL8tPYC?=
 =?us-ascii?Q?eCgxJzOW6bxycwnfdoPvxTVNJRlXL9S+tel0J2gZBOCqIgzKmmryJzivi00Z?=
 =?us-ascii?Q?TWR03n2CkLGPpZ/TsV4HSQxwxmNHyXFiicXZIBdeZ0o3Xars3h6fZomzeQRk?=
 =?us-ascii?Q?W9ib+5F/cSjK1nETxLAQldBPTEzXqzu8EHhjWm7O+3M0Q9WNFy9p8a2Tqwdq?=
 =?us-ascii?Q?BSrcEKEGKcIN3Jok/FEy79J4oro2/3Vi3mPl4grPIhk8tOySymGJ7UecJ+VS?=
 =?us-ascii?Q?I/dpNa+vVRBt6Tdwelo70O4ifMuXd9LAnNBSUPpm3PNKZ7VN7SjYnD6pv6X1?=
 =?us-ascii?Q?nf1bdZKcwu+aZ0CKPPftJi3wW1J88eqh2hMVQ15oL8uIhx6lpsIbQr3ZE8GP?=
 =?us-ascii?Q?a3ukQTT9UzE35Odh8ny02grq9k6YKqliGKbZDrYzaM2miAEUr6we9rikTfA3?=
 =?us-ascii?Q?4ZAwyDnpcJFYJ/J0QgBOh1M0Zhc33waWmaUjB9XJxyjsSAZ8wKHiPTf/cNc5?=
 =?us-ascii?Q?GwGGtES3ETpXOFlGn8O0P94A?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(366014)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YfPsAxNeMD4eWiazW681Psm883uFrIY54JEDJ41vyXZvrbmRK041tjHMe9AT?=
 =?us-ascii?Q?dxPoLZMSyKWI9ZgfyJeygsptSoNHxZfiJnFVoDtwY82fnJqIJDIVFfYUe/PZ?=
 =?us-ascii?Q?WT+ZWkUZXaRMUKPh+SenWw8wR1e7GLd8hfUlK72bb64dI3OH4ctUdKvoCdI1?=
 =?us-ascii?Q?P/ElG2m6u/D0Z8e4+lr80NkG98nUahRgZVt1uZRJRarXviIIX9F7bUbhNt30?=
 =?us-ascii?Q?OOJDHWHIygUWpwWH+yo0sOI4VV13m6Sfe+LQfvLmPOhylEQHFJxIJbqEhnmF?=
 =?us-ascii?Q?lWLhyQQYTAaqoYgKAtFyzGf+cZscNUcbgJfzcAI1Sv+FgoKqD7kqyScpXa47?=
 =?us-ascii?Q?ohnBTvrJqDAEBvO9qYy0P7+yCyoAh05Ni9oq6y/7uatduWwEXrK8zrP+t1L4?=
 =?us-ascii?Q?ucsbKJ3uBI34n01AIj3KC7hRkIGHDjzqGq167wWqVBk6ttRdkAA5y7oh9Wva?=
 =?us-ascii?Q?QNe7buABBiPi+qHg+/XPc2Pgdfijq5l9TioX5ZoCy3oU0VXDtqjNEewC2z/Z?=
 =?us-ascii?Q?6cm6ScVOSV8jVrNDjoZlhpnhKU15OgSeqwMlKxjAetSQ4HSn0wH3xejS6gsy?=
 =?us-ascii?Q?n4kG/UmTN2j38uPZ87R2/Jbdz/ABf0b8LeqiqvdIHN9yooTz0O9m3jlGTZvg?=
 =?us-ascii?Q?nQqpTzexOGmOv1TqdrC+Ivz6xg/bu1OqHgXXP4tn2qjaeN5CnZjhlMqXxq9a?=
 =?us-ascii?Q?Xboh4ECexkqBcHMQsHJlq88RYmMwd0X/aatFuLoCvcwFADmPQaXxyzhEshwK?=
 =?us-ascii?Q?BrtUbU3bpf4sUCZ0aht5J2ftHg0hBzhHW+3TPMdA6sBPhxrgmVwribRhIHbh?=
 =?us-ascii?Q?KwEca5QO7x4NY6WrRrPAWxHJ1RpcoYDXQJxTUt8AhUaD4iXcvDnTxNEtD2CD?=
 =?us-ascii?Q?+cumlR5oE4q+LYIWOWE9otop6s0HOFQkbu5sfFrZojroPJDluTLzZnN5sa9+?=
 =?us-ascii?Q?kDeqHwQMWRKyY17rbQJDpPpmpD2NeuEDAb2OEou63lmnwuEQEmHLUuLJc33d?=
 =?us-ascii?Q?IFso04RJUiXbAhtQ/j/9uXTbYjbOULt9TZm+Sxc5wfz9tTxH2nz/sZu0rtKT?=
 =?us-ascii?Q?Y3m6aYrY+3jtFjRbxeZI99OLBaGgL0Aefx02qzFzODx2alqJ9ygX9AdIupdA?=
 =?us-ascii?Q?YdblcvOGZq1WQyXNu39RtUslbFLDmpjXI0cawIHNxxv/SRYbrHSF7nspL5Vu?=
 =?us-ascii?Q?wGQ2HqnlATzO+kAPdYLAZAe9rKfU/H7Cz59DBbtdaq2wP+k+PtO9kT8XugZo?=
 =?us-ascii?Q?+PftCLMdQTSuthmVfpjl/JMzl4KqRPY50vCD0zwRjnYi4Fr5Egwuml07RHQ1?=
 =?us-ascii?Q?mXQ3tS8etb30g1crkx0dD/nMKAQh3WTpK3lxaXdvlmgEhB8mJ7On+Iiir2Ri?=
 =?us-ascii?Q?6Rlz5hfBc7gsC88ISqofC68hHMygqbZr/veR1foOthlPSSpPFo3l4hm1jBF4?=
 =?us-ascii?Q?IQW/vjOjS7AqmJ0pNE5tlVz6WWxWxnphEqCOuMql+H7wxd9JSe1pntuN6XLD?=
 =?us-ascii?Q?BYHBHyebzeAfi2d9t4sCxTyRzX7o4cXvorXTMa2qkG9E5ldN+qbBb6QrQ78K?=
 =?us-ascii?Q?tK1dwpKXQUVfU+I51t0wwsCX9vUI9JlfQz+J3YB+MvL4TpTRj5R6Zk/x7S0y?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0a7343-e4e6-4bd4-5ea6-08dc95bc3ac3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 08:44:45.3096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/0CmLCT6gtQVvcJn4UEwkDeJaTioriF4iJ2h1/vLmA0uuTCq7K1POrw9fV1dltdO7xQyYAnZPjZ3l6zcsN1h/c2xHOLvmHeLaoRCV+Ox/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8294
X-OriginatorOrg: intel.com

On Sat, Jun 22, 2024 at 06:39:23AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   35bb670d65fc0f80c62383ab4f2544cec85ac57a
> commit: bb208810b1abf1c84870cfbe1cc9cf1a1d35c607 vfio/qat: Add vfio_pci driver for Intel QAT SR-IOV VF devices
> date:   8 weeks ago
> config: x86_64-randconfig-076-20240622 (https://download.01.org/0day-ci/archive/20240622/202406220635.PsQbyfY9-lkp@intel.com/config)
> compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240622/202406220635.PsQbyfY9-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406220635.PsQbyfY9-lkp@intel.com/
...
> >> ERROR: modpost: "qat_vfmig_suspend" [drivers/vfio/pci/qat/qat_vfio_pci.ko] undefined!
> >> ERROR: modpost: "qat_vfmig_load_state" [drivers/vfio/pci/qat/qat_vfio_pci.ko] undefined!
> >> ERROR: modpost: "qat_vfmig_reset" [drivers/vfio/pci/qat/qat_vfio_pci.ko] undefined!
> >> ERROR: modpost: "qat_vfmig_save_setup" [drivers/vfio/pci/qat/qat_vfio_pci.ko] undefined!
> >> ERROR: modpost: "qat_vfmig_destroy" [drivers/vfio/pci/qat/qat_vfio_pci.ko] undefined!
> >> ERROR: modpost: "qat_vfmig_close" [drivers/vfio/pci/qat/qat_vfio_pci.ko] undefined!
> >> ERROR: modpost: "qat_vfmig_cleanup" [drivers/vfio/pci/qat/qat_vfio_pci.ko] undefined!
> >> ERROR: modpost: "qat_vfmig_load_setup" [drivers/vfio/pci/qat/qat_vfio_pci.ko] undefined!
> >> ERROR: modpost: "qat_vfmig_open" [drivers/vfio/pci/qat/qat_vfio_pci.ko] undefined!
> >> ERROR: modpost: "qat_vfmig_resume" [drivers/vfio/pci/qat/qat_vfio_pci.ko] undefined!
> WARNING: modpost: suppressed 1 unresolved symbol warnings because there were too many)
A fix for this this has been already merged into Herbert's stable tree [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git/commit/?id=a5d8922ab2aec39336ebc78d7cefe3b84647b058

Regards,

-- 
Giovanni

