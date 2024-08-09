Return-Path: <linux-kernel+bounces-280342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C421C94C8FD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CDA286623
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0062A18B04;
	Fri,  9 Aug 2024 03:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kq8a5XGI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A12F22
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 03:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723175708; cv=fail; b=Ckaw3h/xpCNydQCVHAdA+j3u8wanWzhdZ1M9BJ5RqwBPQAGX9WWu2FX5qDxFc/70lIkEqF124Plg8zf4heiXiWu/T2jW4XWijGnsVCYdCkeTYWy/F2XmJykdPk1rT2eXEZMIOUt2h6B5K4DR+Qb0gHs+xnA2gfjLLeQIahf/6ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723175708; c=relaxed/simple;
	bh=urbEkRIpBKeQrG36inp8AFpHorwO+buae9TqAQhdwns=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YQkLD50/q3O0yCYmWuVF3ZUVupZ+ZlDNMrqlw/aFAucAAXUm8wJNTSirN4BvYC8c40OdH08AQ12c5cTXQZ2xiyZ631ymTJBxNsQJwBzwWaN/bmUxVbhdUox8RNYl615pSeTlc1xoBQpxBXHqeJ2xQ+AJw8Tg43WFmvLo0mcgwkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kq8a5XGI; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723175707; x=1754711707;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=urbEkRIpBKeQrG36inp8AFpHorwO+buae9TqAQhdwns=;
  b=kq8a5XGIqBwSHCQp1NjpYQCqKVdutmVr9BPuTqFmyUihKaZkHG9C/VH/
   cX8x/DhtEtOS/A3/pSq7jArPmAZVrNnSMUvWAZGu52GRGak2SXmjWH5+0
   0AtdmqaNUM/QFlZZt/AYdpRadCdzXSUGXzLn1fVE+Z2B4Xu2yTmzOcx3K
   Hg8bv+4IAm95+ZN25YcfC4ZK65erKRcpKjWcg5u5OWHNsldxOyGIndsJB
   W3xO7HZsbHNwNanxM2aUOn2FO8UC+sX68YrG7Mr6cizGJl1GnxejZYFsP
   IbsYZRodlJyr3BpIU7taTf96J8l+frE+tHmiQ2vmT7UbcA+kIle4qotU0
   w==;
X-CSE-ConnectionGUID: vbq4FENZReW60RR14tk2wg==
X-CSE-MsgGUID: QwiyOkGISXi49egzoee55g==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21461166"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21461166"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 20:55:07 -0700
X-CSE-ConnectionGUID: ff4tRwLlRIiMhma3ONc5Ig==
X-CSE-MsgGUID: dGnN+bd/RlOYNtBBoCsf/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="62082424"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 20:55:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 20:55:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 20:55:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 20:55:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTyhflgzq6PCJ7+xpg6makS6JsnBXOm1oVihhpUao/ibJjBE4bp7wjjWo9TJMVquXLHZG3TZKiGagHwKncZtmUPkqcak9LfpcnMH3U+m9WpZd4HE8mRXaHRMnNuFVmy1GDH4zZtydUkNbAyRSYhhO5JRON899MXzT6CLxMplJqWpc09u0/UXPg/lhgkajnTP7DVrIUtbkOLfhjNtn5jpjV7M+Al/Dc9d6kRMCbeH47F7NGkfzU++sTFORCVShxUKfu64CPIFQMFDD4MuQE/AnarEF7TjM/M+fvmHpAs4XzwOvWtRmMSdoEOoGpYgSk/xpXEvWBou4PbSJddj28ERbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhHiSpl1sz/QVUGtkXJTJz60f+4GKE4crCluSFqrtsU=;
 b=mK0WDyqTaFZroe0b0HLe33Q49NSXbhGlMQbwVYGmLiBNMKVx8atUMi2vwjBFcqpPW1uHjGW+Gzqcj1F0KDUEan6JK4JFgDDK8V2IBMeXEzDwvmluzPEDRCj79tG3zBOHJyjIelHRKBfTxqdl6/bRYlskKE1PVOp8IOihkC954V/uYiXRvUcLQMaJVPdktDHxufuF6FiAvyASAVqSdOFkhy6rNHfmcGscGJDuEuwcufd9PtmVW4jcLxQDF9/5nnTXHME/f8F1G7b+oPmLeD4KUp0i1IlQUBPIbcG3VGTlIc8o4QuziWTvaDzGQZ6/MoiNuYtCvUe3DpajY9wzoSxsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8333.namprd11.prod.outlook.com (2603:10b6:208:491::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Fri, 9 Aug
 2024 03:55:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 03:55:02 +0000
Date: Thu, 8 Aug 2024 20:55:00 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, <dave.hansen@linux.intel.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <max8rr8@gmail.com>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>, <jhubbard@nvidia.com>
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
Message-ID: <66b59314b3d4_c1448294d3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230810100011.14552-1-max8rr8@gmail.com>
 <87le17yu5y.ffs@tglx>
 <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <877ccryor7.ffs@tglx>
 <66b4f305eb227_c144829443@dwillia2-xfh.jf.intel.com.notmuch>
 <66b4f4a522508_c1448294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpmyhvr.ffs@tglx>
 <66b523ac448e2_c1448294ec@dwillia2-xfh.jf.intel.com.notmuch>
 <87seve4e37.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87seve4e37.fsf@nvdebian.thelocal>
X-ClientProxiedBy: MW3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:303:2b::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a63615-e870-414d-96d1-08dcb8270c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xWN/dIxK8uOMj52WJeAq9iS7++yTYzLUNyjFFXFrgRTBZnyND7kuxVpiQgjJ?=
 =?us-ascii?Q?FRMUkGFZ6uF9piFYsnWOnmy3D3y18YNswu/gI5kC7VzaSSYLSGKh4LJo6rsl?=
 =?us-ascii?Q?cdQOhK6vFukQNYTruN+EDCcI1QF5fDwWyKEGg0eZJHk0uuMTou9/3b+G0uC4?=
 =?us-ascii?Q?ltnb++IhAx63Z8N2r/GAx7NbtPEJektSmf6OGM6EVfIWuCNTxp9lHQUnqog+?=
 =?us-ascii?Q?1feX3I1f9mwLP3GO4IQ/Y52cy6fdDkN9jrPu+6Z65mVZSWxdbR0sOYfRolKO?=
 =?us-ascii?Q?GZTbjUkchmVeRbytpGjF8j/v18Klm+VFsh9+GLqWIEGkyyRmdus/wTH+2Jgt?=
 =?us-ascii?Q?+AUieV+1Lkyg4aYwdOTOAG6HfuWqdxiXYtMAZqXmMAynBLCPw3m0sE/sTezY?=
 =?us-ascii?Q?smYKuJosbIF/YgOsz4PR3Bi3NlgrAMASVYTmEshaR/AYOruzpDbnrV5aIF8H?=
 =?us-ascii?Q?ILIO3BsRZexk3T0NTU5GR1AAEcklbJjT7yCF7OwuscMYj/+Gv/MR36/fPMMF?=
 =?us-ascii?Q?S8YgbJ+59UGxXtu7gKHz1r/4Dp5ZxY8mrakqmBuSbWV4YyXb98g/Xu2P6ueW?=
 =?us-ascii?Q?ywxPPgu2pTiOfjGdKUPNcw6fUrMV5fXYk8Va3b0jdEEp9Q9B8bPrO5fJoe7a?=
 =?us-ascii?Q?/8hBi5zn8+/VWGKl0/GBeOPf7cGrYLCUQXvg6vW6XXUjebGew67jL+u2hvb6?=
 =?us-ascii?Q?hY1j/aMSQwhZyWG4XGbqEj2hDExAIqnWXs7bNISpj6PD/Dc6+vl3TO6K/D+z?=
 =?us-ascii?Q?3EMfyqr+NdBQiW9cZUQmDZG4BtH0LrXzQ9EsPg5BqggawpJPuJ72Edo+D4Si?=
 =?us-ascii?Q?vBrezifntFK6ZWHUvzVMhXbaKLVWgcm+lrqiWNLrhj8XcGzcixwgjN+GBqfZ?=
 =?us-ascii?Q?65iOgBvAL2CWypCvqGXq8wF4ybKAFrivnuu//DI/P/C1F3YOSlYIjp3ydioJ?=
 =?us-ascii?Q?uX1ElaK13c2k54oG/RAK9TwSL4uWLgud8PWcV1zvgOt12bZN9YJI1J9ShYG7?=
 =?us-ascii?Q?D+RLiRrzugL4T+bPOAwmXibpiCorEGPBskN8/aKpZrkCwRtygYf2q1uG+/2n?=
 =?us-ascii?Q?Mbpsm7SuBcWwZsEACAel6dfCIS/k+9yQE4f1LbJzgDVB+oioAoSBKbNy84py?=
 =?us-ascii?Q?nqGUXMT38UnmP0/jJ9Pj620aWdIKHwDGBOjKaKHshlCn7ELkJVjn5CN+LTh0?=
 =?us-ascii?Q?71iERSMmQs4eJTtSKdFBlo0PLAJ7/jwAARAzNoUGZErLzvUbX0FDm8LBT9lE?=
 =?us-ascii?Q?XviTyUjjg+5gCXhzkl8IRQmRLBy4czh4QW6QaQK1+E5T0oblzhjUiiitZUMK?=
 =?us-ascii?Q?yhcDlE6uNudXRSJ4It88/MJonqLguRTHObNmRIH08PA6ag=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5J6R2kblhs5et7N8+o7Vjl3iwVt9bAI7cJxHxpbjdBUBtXX7K/54LsE/zHqr?=
 =?us-ascii?Q?JpEgYKccL3qdRwqdJr8rQ0iAekYLQA8rKqDGTyLGXChEbh2/h+tihWHr0tOp?=
 =?us-ascii?Q?mdlujYMOqDbI/oCAOLiEj8VoVB5htLswX5MMErWFcfZWJYUe9eso09HGvvoB?=
 =?us-ascii?Q?38OZVPCYUhADOWZybHouyelHlDSCvRxtXqc1n+agB840vMkkwfIV94lZF/5U?=
 =?us-ascii?Q?fr9Fq1wcjcUtnhZyr3gw4eMp2k6Q1VKMP9eJM+kAKPWHVzUlkP4Q7tmo8vR9?=
 =?us-ascii?Q?4kXx/6vkzGomQGMDJf5gFlUE4x5tCttHPpomTbfBCOKU32iVM6yYst6dmoj5?=
 =?us-ascii?Q?jGCKtImzln8xIK7voIMRqI90DBqt7giusBpotT2BIszr5TiYGB61Zw6T7bsa?=
 =?us-ascii?Q?eDgyWXTEmRnoz806q4wTnQk1CFz6klaj137Cyqy36i7/unsdd2iOSt8CsuBN?=
 =?us-ascii?Q?ww+kbYwHJ3udYmzna7KW8L8aX5e2UZNqqhkPbtVMYjOsWl7Xlods6S7Wb1kN?=
 =?us-ascii?Q?hMnUKLYw9g1nn8oDRVzgUcB/rnitchKv+1XS/yhkHyMnfncuWOkfBQGTpzWx?=
 =?us-ascii?Q?qaybIWxu57cIdigZ6jyyDDaTaE17VoHChLLZb7ai3iPeMeeg9YqLWuvGtsZI?=
 =?us-ascii?Q?UXdtglEmTKGWefs8fGEXuUHW7RiXEvfePQzo4Kncvl/oZjhUI8TxZHNtI+ac?=
 =?us-ascii?Q?qhT/aykAz7oP0L5jMYl1YJ4E1bOa1sNw4HOoL+H4tlHEZ2XvMBDJYMQ4uKqs?=
 =?us-ascii?Q?rSw4/ji/4ZooC0hLbYPSKzlG7mNS9XWEo2CLVn87RrT6rx5Al1bKX6bxB/wM?=
 =?us-ascii?Q?sV46MK2A6vlWFIUk/hlKQ2MWylGBjvaErbRo0qVwrFthGBRh36KsNkCC1TI0?=
 =?us-ascii?Q?7ASMU8Ov4fWFal3XprNdoyFVj7ybgjhatxzqI9QTPjztNheMzTv+qmdzESKg?=
 =?us-ascii?Q?qIMZKPO+2M6bPFVIWxiJ2Aw99cSk9Og9+KQf1FkL9cC4PDXdXanxFDAW8mfa?=
 =?us-ascii?Q?L+AfDIYRcRTMa+C0RJbb2pw3eNrfSJRF1H6JYxkEQEo45Xt4oDPT143jjHGg?=
 =?us-ascii?Q?l8XPdnIgA7DKXPp6jv+2gc+EApaOgwT1qh2AIRQ3p1EM4PlX++kNnHUp+9Pu?=
 =?us-ascii?Q?0j//nfP/J18WVFph8oY5JCjrueCSOaXY7OOXJREhcPCLm0BNM2CEw83Y7zyW?=
 =?us-ascii?Q?fWyye2wzAR8temNQfKDrzloR3ErkVA3ukZXXONkddqSj7kaU/tbDt1g5bVcT?=
 =?us-ascii?Q?zo0X3F9Onhc4p01tunStSVG70oDJXQ4+yAEYS3dsxfsHn0S2BLRTpvbpDSKE?=
 =?us-ascii?Q?9xrk2ehvnZwpybCRyEVrDOLI2OmqbP7kZgu5MTKYT+vA4k419WbGKR58fru5?=
 =?us-ascii?Q?8IRr+x6huBPx/ITDv59+FV37LLbumr8qtsda8RlDWa8FsBOFJjfMqETSEloc?=
 =?us-ascii?Q?FQ2qZczr11fSqirg2+rtF2rKNnZ3wMqAuJUklx7QrDaAYTaFWovC5kBt4nzP?=
 =?us-ascii?Q?yHz3EJG++oKv8Xjih0IVwX9VoIndF/98ffO2kKErad3IErwZTxlij7sjgGja?=
 =?us-ascii?Q?NWZUyQJEHTS9AhU1cIXmcXVPumGqHwPppK/nL6JLWuF8cRqy7VjE3gAnR4sA?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a63615-e870-414d-96d1-08dcb8270c30
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 03:55:02.8910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7h0QG5Abso5aXl+9sW6qy+86PVeFpnP3KJTFwE4yH5VJQmNkSY+3wDO7NrlevIOkjKXUzxIxIIBJMcdiXTdwq0vpGMu7efj9V5ZUCASKoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8333
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> 
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > [ add Alistair and John ]
> >
> > Thomas Gleixner wrote:
> >> On Thu, Aug 08 2024 at 09:39, Dan Williams wrote:
> >> > Dan Williams wrote:
> >> >> Apologies was trying to quickly reverse engineer how private memory
> >> >> might be different than typical memremap_pages(), but it is indeed the
> >> >> same in this aspect.
> >> >> 
> >> >> So the real difference is that the private memory case tries to
> >> >> allocate physical memory by searching for holes in the iomem_resource
> >> >> starting from U64_MAX. That might explain why only the private memory
> >> >> case is violating assumptions with respect to high_memory spilling into
> >> >> vmalloc space.
> >> >
> >> > Not U64_MAX, but it starts searching for free physical address space
> >> > starting at MAX_PHYSMEM_BITS, see gfr_start().
> >> 
> >> Wait. MAX_PHYSMEM_BITS is either 46 (4-level) or 52 (5-level), which is
> >> fully covered by the identity map space.
> >> 
> >> So even if the search starts from top of that space, how do we end up
> >> with high_memory > VMALLOC_START?
> >> 
> >> That does not make any sense at all
> >
> > Max, or Alistair can you provide more details of how private memory spills over
> > into the VMALLOC space on these platforms?
> 
> Well I was hoping pleading ignorance on x86 memory maps would get me out
> of having to look too deeply :-) But alas...
> 
> It appears the problem originates in KASLR which can cause the VMALLOC
> region to overlap with the top of the linear map.
> 
> > I too would have thought that MAX_PHYSMEM_BITS protects against this?
> 
> Me too, until about an hour ago. As noted above
> request_free_mem_region() allocates from (1 << MAX_PHYSMEM_BITS) - 1
> down. Therefore VMALLOC_START needs to be greater than PAGE_OFFSET + (1
> << MAX_PHYSMEM_BITS) - 1.  However the default configuration for KASLR
> as set by RANDOMIZE_MEMORY_PHYSICAL_PADDING is to only provide 10TB
> above what max_pfn is set to at boot time (and even then only if
> CONFIG_MEMORY_HOTPLUG is enabled).
> 
> Obviously ZONE_DEVICE memory ends up being way above that and crosses
> into the VMALLOC region. So I think the actual fix is something like:
> 
> ---
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index e36261b4ea14..c58d7b0f5bca 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2277,6 +2277,7 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
>         depends on RANDOMIZE_MEMORY
>         default "0xa" if MEMORY_HOTPLUG
>         default "0x0"
> +       range 0x40 0x40 if GET_FREE_REGION
>         range 0x1 0x40 if MEMORY_HOTPLUG
>         range 0x0 0x40
>         help

Oh, good find! Alternatively if you wanted some kaslr + private memory
then something like this? (untested):

diff --git a/kernel/resource.c b/kernel/resource.c
index 14777afb0a99..2eeb8d8a40d4 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1824,10 +1824,11 @@ static resource_size_t gfr_start(struct resource *base, resource_size_t size,
                                 resource_size_t align, unsigned long flags)
 {
        if (flags & GFR_DESCENDING) {
+               u64 kaslr_pad = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING << 40;
                resource_size_t end;
 
                end = min_t(resource_size_t, base->end,
-                           (1ULL << MAX_PHYSMEM_BITS) - 1);
+                           (1ULL << MAX_PHYSMEM_BITS) - kaslr_pad - 1);
                return end - size + 1;
        }
 




