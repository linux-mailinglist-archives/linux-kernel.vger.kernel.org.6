Return-Path: <linux-kernel+bounces-381139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858209AFAE6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29EC28355C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F85A156F30;
	Fri, 25 Oct 2024 07:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AC6yuhTQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151D218DF7F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729841062; cv=fail; b=cFLoVmsdwRIrgiztwNyA3kolYxor2P9isol49T7nSvoP1Qf6DsQSp79kfwmEXzLVFsDYD5sSUaE6NrN9UaI0lOtcWhKZbq9SmcwImGHjZ9C3038MzSiJ0+qC20on3cHqErh209z5cDdl7ILlV678JHdhCNxKviMqjQocUVGuZbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729841062; c=relaxed/simple;
	bh=4KAvwZrsUEk3G557NXgnpsxcoBv9+xrsdgfLRfBe3cI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Oyq0SPKxkpyrWuqSGoaR2cz/0+wwu1l3hhwsmc5Xg5W602k5tbR12cpb07X1Bs/KXVUUL5cuezSbRWOtCkqM4gspSIVCjpLHYOQ93SbHBWNlU5kjahRwoz7duWGhHzyZ9sTbZ/vpkZQsUWDoYL6zKcujMaXobh7ZkT2U8jJwDz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AC6yuhTQ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729841060; x=1761377060;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4KAvwZrsUEk3G557NXgnpsxcoBv9+xrsdgfLRfBe3cI=;
  b=AC6yuhTQwFZP7d7PXEvPC5dXFW0QE7tRtZYP3j/NHiiRiLRmDzgj7/C3
   lia+NjJn3qeGqWbbJg5ZZnYfxwOtuVuFgAhE2bdubUPUtSBeYTAf2Uxab
   BbfgOYq/G0F1hS43gcmhtQofC1oCU0BYEQh0niwfBJHzHvClD8WX6XQON
   YiKXTIV5O/HvHo2zJRw+UGItbtiSU0GoegSh5CTT34jRW9sPEvFM4utIy
   zeK6BaJwa/3t6GCT8mafMa1d4xFcCpxkxRYWonTyScGCUGGKniyylHYT4
   HTyta0Z2oDu/UU4UgA6hMaklVoi5sThNNeA/YIhs3B4EyhZw6vXN0pU02
   w==;
X-CSE-ConnectionGUID: 0SJznZC2TIybskt6eut9yA==
X-CSE-MsgGUID: YHwIpCRaTmWLcSC959NN1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29664147"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29664147"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 00:24:19 -0700
X-CSE-ConnectionGUID: 1hJoow3wSDGfzpJTE2KkwQ==
X-CSE-MsgGUID: e0BfyilDTvyDP9AkXo0aAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80494541"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 00:24:19 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 00:24:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 00:24:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 00:24:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVS8QQeR2nngvxFaHcYKT4avvIUCNb26TmQJuSkihqI8Jbm/gbWuzDyYe7DjGkFtGZyuw03QslJGD4VTPVPNW0szZf3pQSJC2VkFwHrGBuOu2dGZPyip2b2cgs10Q1fdZptfqNKOTv0fKmMC9YXMTQ8UXsdbThyfQjk7Xliao9tkkvQdNsLPspCVQ3Pn0Hh3ulQK+pdWQiSEQTrrTN5SXX/RuFm5NITAL1X3Q/NcG5h9NeWNTyIuY0N9xdTVtmRhmCYL3N9HKjT4m6HCDElUW+lUej6/6klqg7XqwoPpevZv+tPG0Sz8dEbhxKvPOAJeJlZ0hLCY0LTZPRzj273nzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kfJcxM2w0XPAO7bHxUTE04cVO0PrpH4y8KNtVIa3eU=;
 b=F0XyGQXPFVSvMyq7QpO9WEaRrOWxbCpnpI73kJU3FlcJgm9PA7ap5oFD4/5h1e7NmQxiUs52xXNmJVxfOJknpV0i+TJggiapmV9Pj/gGC5JMdJKPUnVe1nJs0eJyZgghHGMAP1tv96Bq5HW9AGN6blbcYCjaOwAqKJ+P2U/g5AnELvqNgrq0pLPuopnVt42KcV5Ra2+neh/rXgKwlTjg+TX2PnkndDXcLurAzQ9KZVpnIJsRUBJlPIQ+Ar6CQfoUUBGhcV0JlJaEpNzVv9lK/z4gmBvu6WWuT7gheIO7EQxfjngT86DdlThhvlDAJiFFD7wAiRZ19oj5Y6B1i6shCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6238.namprd11.prod.outlook.com (2603:10b6:8:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 07:24:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 07:24:11 +0000
Date: Fri, 25 Oct 2024 15:23:59 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Christian Brauner <christian@brauner.io>, Matthew Wilcox
	<willy@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, "David
 Laight" <David.Laight@aculab.com>, <oliver.sang@intel.com>
Subject: [linus:master] [iov_iter]  f1982740f5:
 BUG:KCSAN:data-race_in_copy_to_iter/print_report
Message-ID: <202410251443.19c83c0a-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: d991b64a-ec83-4b4f-6ce7-08dcf4c6053e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4jmqJfjF3S0BAkwI8LQdWj2XFMBVwUrasVyBFpYm9Yb5rLLjim2lA+kp5jKr?=
 =?us-ascii?Q?B3E3qpHbSbnmdD7qRi8toCsOdA0V7pbOYMd7zdwxIeTb+aXD8lIaYnULqDRc?=
 =?us-ascii?Q?6AKWxnHddU/43xBLkazUS2BbCK4qIn7IUWy13PczA4HdIByCqZ3c7volZcx2?=
 =?us-ascii?Q?6jNlEFvFWTGtJyhscybFcFl7HMlTylqMvGzKSRwvZIfXfWHUDqkH3gJqIYud?=
 =?us-ascii?Q?BXeZjZn6BAsfxOuSlRg8CR79wNJ5DrhKY4Jlq/WBB8MlkYzL1MQRZVR+QC1L?=
 =?us-ascii?Q?CbniOPjbddB9rDvoe416A9S5EX1lxTac6wAddoaZq9/Lv8urUkli07tZkkZ4?=
 =?us-ascii?Q?h0chP5cXumi4psj6Z6pmteKPF5kwpzO47Xz3Bj/p7kJhlpeCB9/LvJBya40X?=
 =?us-ascii?Q?ZzipaIPxe1Rp6rvVD2YL0ZPmCWaFKT4cmZ5GV/sj8Ssq25N/crNUZmyoYNrM?=
 =?us-ascii?Q?icfDQXxdEpG5HXSg01TcCpqejC8eNfDchfLpmGDjp0Oz7+DtmQqHJcjRm/EY?=
 =?us-ascii?Q?o6eE2h5ToNmWo1dj1iRdWut0eJPkd4b1VPMwQ08Xy88s5o70c2W8SCV7a9te?=
 =?us-ascii?Q?J1+nldj2KwlZTNh9fOOtTO7qRIOrdM/XRgY1RFTkr5PxO9GlRtaofwOv7gCn?=
 =?us-ascii?Q?72vg+Ub2BUcKEkp9SvvOEdOB6rXUbpUKV147APv0q56dk+7JaBoIDZoq3Dyg?=
 =?us-ascii?Q?uG6/YsC+ztVVlUBPUnMUDPd1TMZzbx92whbPhIpYpLRTl1itkAujeSwOQctn?=
 =?us-ascii?Q?DthMN2fOa1q29Bt9xXk985ce60xn8HehN64ZzXQWGwETDxP/tCbYCb4bMb1T?=
 =?us-ascii?Q?atn3b1Pgl/X99L/O/aJ+wNnwh1elHuwaG7g1Lr2cNsOiiLDY0N5ATBCqMhH6?=
 =?us-ascii?Q?Ebk+xfJ8kRkIuNYVl3KjFNM/cL/iJB6Hj09zAAd38w9NjiNxucL7rxNOVRsI?=
 =?us-ascii?Q?hj89IpmYg5XzZYZ09lRDGBigebTuUNPzO0GuuSzGspQSaNaKb2MgHXSChoq3?=
 =?us-ascii?Q?r7h3nR8pNHZO9LNdoLWBALYeBIwwMcpIfIa+9yOfZ3+uqvbYouTwxWnWTv0g?=
 =?us-ascii?Q?dByGuJFN4jwwRJUGyCwsUuy4cb9Wy5uxnSgh0qfAqs7jant7fDPa2XuBjGDj?=
 =?us-ascii?Q?kckGimDm+TUnnwzUPIVZXicI2CH7mjyKUWsTPA32hhxde5/rTpTCWLo7vr+O?=
 =?us-ascii?Q?QwTnQUHExtbttu7LqlmYtInpKKopfIvBH/iyXjRkhfsOi6gBfreRbdLoZOkp?=
 =?us-ascii?Q?YGO6lVGys+m2ZRzxuBCweoIyZUq3Q1iKpLIcIvzy1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b/89u48sYsym+z4l2qdV9A3O7N4qy9nx3H84euZdBlB2QzCjzUcbckxDLKgP?=
 =?us-ascii?Q?vHp2h8osfeADS//xv2AdnRroAwpkYjbrVo/DiwAf4M0IANVswYc4nh3HFK5Y?=
 =?us-ascii?Q?V9aSD2JhDucZxSj0cYDNgE4L4tRC1SzLhC67jNEfpkAzPJ26qCHeeBAWdVkP?=
 =?us-ascii?Q?6H85G7oTXrbJDUoYhPKb/k2skjJkyW7fUz+YNHzEyCGrafbPUVKR1n+HUNXF?=
 =?us-ascii?Q?YWYyK+gTo+Os5rw7qH9R40Ud7U3dFWbQY4nkMk0nDBThKUAQYcM1ov4gLDjs?=
 =?us-ascii?Q?p3QPWmISf4brXRkN4YEjyNIPFMv1vx+0qd8BTkA0PbomtGQpuMDPUaDylH8j?=
 =?us-ascii?Q?5PrPYvU8R3tWuKsgfEZwcXdDiI34zXxuFcp9VcTX5N32jJOAufEJYmLLF7pe?=
 =?us-ascii?Q?13igzcxAuFhOHKhniatdxA+Jfy16AD4hGaybyzCDCaeB2a12M3vQvRkG4kCd?=
 =?us-ascii?Q?oEdhXMt4hJ1OE306eyPGtPNXMLiezlZam7tVD8JjKW+V4l1JxDXZ5/PtQZfp?=
 =?us-ascii?Q?k1pzb6NmBWIzcgJvy8Csmg5x57i54+E+Tsw1nG6ZI9h2FMEy4VKv5SjK5EUI?=
 =?us-ascii?Q?ogJqpCs2L1TTJdGH+WMd05nHgvVrEZtlUbMbHd+zIz0Ki4BrqGF4ZHVkLvLO?=
 =?us-ascii?Q?o6TmbVtnfScyY1CgPueHY2VIrYe5Ws5By7dUOMlNmQVlTP5Y3h5lOEDwFjbr?=
 =?us-ascii?Q?GRBv606vb3Ou4GJp/ak2OlbXhtxATVjmQcGsoDIEWwtnJedh1cbZzESTirMd?=
 =?us-ascii?Q?xRcrUa5kXcWXBfaK4ch9ZTmuAutCwOLiJra3sLTLlE59eGtFvsG1FASPZv7y?=
 =?us-ascii?Q?sTWwSR6MGe7IMZutXGoPPI8cGyCU12nSMUfgq4nZVBspk8r/rY4XtFU25Ebo?=
 =?us-ascii?Q?GyXHXenEqPddtF6AlPMshDRPqVec/HbcD9UVhgQD8r/uSSXVIv1FrtKb38JF?=
 =?us-ascii?Q?FqUkDD4zeaXHhWMAq9vheOZ6AWq+13FfoerdLOsxj/WJJW31QzzPWb3PO8m4?=
 =?us-ascii?Q?1YaHIF2E4Bhvn8MLxjZqoUXOYZKFkjFPK3EniqsAW+H52mJltaIwhI3RYzv/?=
 =?us-ascii?Q?msMoOhzxXedg4VwCEDurFjD1KE0gtQUVkrWEUdKx2lsJMKlgPCcgVHxh3Lgx?=
 =?us-ascii?Q?rwf4w9cbyaP0+SG8OFd5ZpRa5Hv+I6Kdq4iNeqdI5+q43WGjBF85nQDc1V1r?=
 =?us-ascii?Q?55jfSMhYjCeiEvJlkrKnB3TBFa3zbLj/dZSj4xsutXl+JnE8UhiPKHj2x3id?=
 =?us-ascii?Q?XTsfUP54RA7MhI9fWc/IrAGHjwcVNomYfIwTk0QpHnxhdYKKMffxXraXP9Cb?=
 =?us-ascii?Q?LQqwnww51OvmTAVLsNxxd/68fkrvh9fkCuroV4BYyJR2yVainJ+glYMpWI2z?=
 =?us-ascii?Q?OElpUw0BRtfOzZNoEkVGwsf647ZWxzXSXDLO2iK9FY+flVDmLi4Ye6nMGMXk?=
 =?us-ascii?Q?qCRFrVkNAEQTZnb3wMcLax8gB+btS4WakhGZ90eYAAVDQilPFPDYO1WMxEqp?=
 =?us-ascii?Q?aP5Zcmeyu/Cx+iIDh5PoSmcz/mxm+PV/6BMTHRJONwiQd//e/W5Kjjc7t+K0?=
 =?us-ascii?Q?fmWrZJcxmnFIofIvxYO0Pez02JeoF/wL8UB9C200NssqfVf1Z91pPKuaZuOK?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d991b64a-ec83-4b4f-6ce7-08dcf4c6053e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 07:24:11.1598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lEwRl81wv8m4NYXFKzlOsLjJ9IU57ANW+a5TCdLtopFJzIdYTqxjQIRFBfWzPMcy0whACFMDv31SJVXOCgULw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6238
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KCSAN:data-race_in_copy_to_iter/print_report" on:

commit: f1982740f5e77090bde41a9b84e257d69ec46598 ("iov_iter: Convert iterate*() to inline funcs")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      c2ee9f594da826bea183ed14f2cc029c719bf4da]
[test failed on linux-next/master 7436324ebd147598f940dde1335b7979dbccc339]
[test failed on fix commit        a50026bdb867c8caf9d29e18f9fe9e1390312619]

in testcase: trinity
version: trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06
with following parameters:

	runtime: 300s
	group: group-03
	nr_groups: 5



config: x86_64-randconfig-013-20230914
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


we noticed the issue (1) doesn't always happen, 8 times out of 18 runs as
below. and there are other various random KCSAN issues for both f1982740f5
and its parent. but for (1), seems quite clean on parent. FYI.

f1b4cb650b9a0eeb f1982740f5e77090bde41a9b84e
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :18          17%           3:18    dmesg.BUG:KCSAN:data-race_in_copy_from_iter/print_report
           :18          44%           8:18    dmesg.BUG:KCSAN:data-race_in_copy_to_iter/print_report    <----(1)
          5:18         -28%            :18    dmesg.BUG:KCSAN:data-race_in_copyin/print_report
          1:18          -6%            :18    dmesg.BUG:KCSAN:data-race_in_copyout/print_report
          1:18          -6%            :18    dmesg.BUG:KCSAN:data-race_in_do_raw_write_unlock/print_report
          1:18           0%           1:18    dmesg.BUG:KCSAN:data-race_in_end_dir_add/print_report
          4:18          11%           6:18    dmesg.BUG:KCSAN:data-race_in_inode_update_timestamps/print_report
          4:18         -17%           1:18    dmesg.BUG:KCSAN:data-race_in_print_report/start_dir_add
         15:18           0%          15:18    dmesg.BUG:KCSAN:data-race_in_print_report/timekeeping_advance
          1:18           6%           2:18    dmesg.BUG:KCSAN:data-race_in_print_report/timespec64_equal


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410251443.19c83c0a-oliver.sang@intel.com


[  130.227943][  T404] BUG: KCSAN: data-race in _copy_to_iter / print_report
[  130.229246][  T404]
[  130.229742][  T404] read to 0xffff88817ef9b000 of 4096 bytes by task 373 on cpu 1:
[ 130.231136][ T404] _copy_to_iter (arch/x86/include/asm/uaccess_64.h:107 arch/x86/include/asm/uaccess_64.h:107 arch/x86/include/asm/uaccess_64.h:133 lib/iov_iter.c:27 include/linux/iov_iter.h:51 include/linux/iov_iter.h:247 include/linux/iov_iter.h:271 lib/iov_iter.c:195) 
[ 130.231994][ T404] copy_page_to_iter (lib/iov_iter.c:379) 
[ 130.232961][ T404] process_vm_rw_single_vec+0x1b3/0x21f 
[ 130.234196][ T404] process_vm_rw_core+0x1b5/0x29a 
[ 130.235426][ T404] process_vm_rw (mm/process_vm_access.c:283) 
[ 130.236279][ T404] __x64_sys_process_vm_readv (mm/process_vm_access.c:291) 
[ 130.237362][ T404] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 130.238214][ T404] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  130.239264][  T404]
[  130.239689][  T404] write to 0xffff88817ef9b000 of 4096 bytes by task 404 on cpu 0:
[ 130.241242][ T404] print_report (kernel/kcsan/report.c:396) 
[ 130.242084][ T404] kcsan_report_known_origin (kernel/kcsan/report.c:504 kernel/kcsan/report.c:694) 
[ 130.243157][ T404] kcsan_setup_watchpoint (kernel/kcsan/core.c:678) 
[ 130.244094][ T404] __kcsan_check_access (kernel/kcsan/core.c:754 kernel/kcsan/core.c:958) 
[ 130.245182][ T404] _copy_from_iter (arch/x86/include/asm/uaccess_64.h:107 arch/x86/include/asm/uaccess_64.h:107 arch/x86/include/asm/uaccess_64.h:127 lib/iov_iter.c:57 include/linux/iov_iter.h:51 include/linux/iov_iter.h:247 lib/iov_iter.c:273) 
[ 130.246089][ T404] copy_page_from_iter (lib/iov_iter.c:439) 
[ 130.246997][ T404] process_vm_rw_single_vec+0x1ac/0x21f 
[ 130.248212][ T404] process_vm_rw_core+0x1b5/0x29a 
[ 130.249458][ T404] process_vm_rw (mm/process_vm_access.c:283) 
[ 130.250377][ T404] __x64_sys_process_vm_writev (mm/process_vm_access.c:298) 
[ 130.251449][ T404] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 130.252273][ T404] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  130.253467][  T404]
[  130.253888][  T404] Reported by Kernel Concurrency Sanitizer on:
[  130.254959][  T404] CPU: 0 PID: 404 Comm: trinity-c3 Not tainted 6.6.0-rc2-00007-gf1982740f5e7 #1 bb9ae1a50ddb3ba41c398efbc8f00fb454c7c863
[  130.257249][  T404] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  130.259159][  T404] ==================================================================



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241025/202410251443.19c83c0a-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


