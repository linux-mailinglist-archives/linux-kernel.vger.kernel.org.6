Return-Path: <linux-kernel+bounces-568216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DCCA6922D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9583B7557
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0231D7E5C;
	Wed, 19 Mar 2025 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LcoMmCQX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807631D63F9
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396057; cv=fail; b=NeKBmpu+vamHomAXAGoCQDTLkQuIs8uAcNRAfn7MhW0htcnDXR3wBw6FtVBsgpjsFhO8lofXnX4GXQ1/j/5CX3DmruxpmmbZaz9U75VkGzdAbB4BSuM+3vU1AnAru64YdJ/6z8r0Rvud3gHDMmctUvP3goMhgvPZTlXnO7EGPzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396057; c=relaxed/simple;
	bh=oEZ3SB0y7FYCd8EvLQpFA7+yzGz6mX8HeLcfWo8OwD8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d7ikGxOPKQRCp7kg1KzsmnfMMWDh5Ho4NPXo4Mlz/i6j4Zmpthy6O1030rmKmUzx5C4qhxt91zlWGwjPfZMXukppmSed4afrUhLnrBOet2F1z0QApcftRoEWc7jwWpx3c7TN9BykY6SEJhqvt+b6qhLOo+TqSqo5lQ8SkqcIOLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LcoMmCQX; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742396056; x=1773932056;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oEZ3SB0y7FYCd8EvLQpFA7+yzGz6mX8HeLcfWo8OwD8=;
  b=LcoMmCQXCrKCtCnB9k4fpm/eDazqrXN+USn8uNxx0tKSs7ya3AsOD94o
   OT4Si1OrfTt2PUiDJvlvVPtrteNHYpaF0vd2rqJpoWC1XtmhppNJMGZH3
   0oCpQLzjkVfRCrW1i2Or+ACJznfpoJ19uvP4Rqo0Q2y9FID6qnZJVywuJ
   3q/QMIu8if0/fpYZ2aFg0ZDnxjpsYVTP3AXu+Ml//jKtwzjXQun8+uoh7
   2c/salNOkjOv4cxArIevZhhcpJGm4wHcrLGJ9sRm3LcN9Rnp5JvcCzet/
   gxI2sRuLOoUV5HPJc/rrBG9aD05nIAGdglnt6AZbqEfCsMHj+rQQ/YwVf
   A==;
X-CSE-ConnectionGUID: VQiOFI2sR5OWHJ3sUyYFuA==
X-CSE-MsgGUID: nr8fa55NQRqm1syE9vWG/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="42838283"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="42838283"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 07:54:15 -0700
X-CSE-ConnectionGUID: TjB5luKKREqWsy2B7FzWhg==
X-CSE-MsgGUID: khwN4rZgRVGin3MrtUqFrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122382372"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 07:54:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 07:54:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 07:54:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 07:54:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkiMKOs/Cc/Qfx21XRn6iWdHd89fhuTBeX8ER0yS6Om3dV96FTmP1uryqedyEgk87X7+zNjonmGvgjLhhkm25r7JaURpJ35VkMP9LbHRJQuzDfxXTcRtL0T3rhxyn+lH+NOgFZ+lx9Zs//jMpiHuDLfGkBq7BUXNScw1uJ/MGeEZL748nELRp0lyfYDri+Wgfm7WzuNXkb+39DYMM+EshvztUXRions+DjJmXnv6OzgkmSNtD/+8OFs5K2RxFNRZFh/k1T+NrpLs8RRUvR5yjaM1iy/Xn4Aiex6JAQUgZ3+CP813jwVYoeb2QtGiqnpAOOn3MsVtFIWqi2+c4Zk4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22sFbvn0gmpYoeVrPKtFYsEH6aYj3pFyad5eOYc2G04=;
 b=kMem6zwtxUUqT+fWsKE0ed1SeEJAS0uimh901pUuvfUDQgqnGSJbfGQjzjLhFdBhTX8LW0P2az03lVuq2QCgZupezMQLiLXajggfLkl3zIMnlVdB6q/gvBRgzYkHXHr2VCSP9GrraWhcAHfSg8c1ShKuJixzv4dh0JYLgLs4l5PGtve22AtWDcIRKxPagCND6lA0uT4p+wwvJ4kFhDpUM2C4i7HowUVn3XvsKm0YFBrktRxTu8G8TP6md/y4SEA6X5EmPp0ZO/dsMGxdHXqeaiLScdQos+OXmmCDZUEVNegFxqCUYDnJ1ymN77JMZGRpqGeGcdlSRolU/kJmJD0fpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by CYYPR11MB8331.namprd11.prod.outlook.com (2603:10b6:930:bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 14:54:11 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%3]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 14:54:11 +0000
Date: Wed, 19 Mar 2025 22:54:03 +0800
From: Philip Li <philip.li@intel.com>
To: Jiri Olsa <olsajiri@gmail.com>
CC: kernel test robot <lkp@intel.com>, Tony Ambardar
	<tony.ambardar@gmail.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: net/bpf/test_run.c:511:1: warning: 'retain' attribute ignored
Message-ID: <Z9rai5s9iw2RNRSg@rli9-mobl>
References: <202503191909.SHOCLBzK-lkp@intel.com>
 <Z9rWnFnf6Wkc6Ghm@krava>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z9rWnFnf6Wkc6Ghm@krava>
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|CYYPR11MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 198466c9-bf7b-44c3-0f7a-08dd66f5e8b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ve5SUaW29DqVbb5kRsALeYTBSzOx5dGw++eqNywFDliBnK7EnpC09AJ4ftR+?=
 =?us-ascii?Q?fvlgj6ZxRw2BQ1FqiR8PPL74ZAjZ2S18IKZn1r2bHOQza5pCFghxQ4m2DOMP?=
 =?us-ascii?Q?4Xi4L40iezXZ3wPWFL3E1Oh/aj+/lWZ9HYImM5PRCNhTXnyeMyb6vPsTtZIU?=
 =?us-ascii?Q?X4mVSh8ftrXeM5wW/EHkKDQbf5n26v8dbwMaWZDeZiXrVTN/z5erw/O1wJ3Q?=
 =?us-ascii?Q?AwACFwb6QJb4CJrt8iphSP7/tKxeKv144TviSmAlX8V0OOPR5lERqRwO9uu7?=
 =?us-ascii?Q?Hgxkm+Uib61VIEvYabpH4jPywynpaaLE2Nflrsvo3AwLI5TOjoCNunw+Sx6c?=
 =?us-ascii?Q?dd9radVfEt7uBa6veLMLX4m0EWTOsIwGc4QmvG6CxUTCKZUt3WA4ep/RVNtH?=
 =?us-ascii?Q?BTWfdSo5CUh771zFnYftNdSFdOaO1uBrVAh892RzYVab1Q5ciuffJTkmFBXT?=
 =?us-ascii?Q?812dyvM6YWRTzXRAzd+Wt1Qn7yidAham+iRKWGFnNUO0bIsdQeOn15OFOdey?=
 =?us-ascii?Q?5QGcHRYjOvwsabWW9uQ05VW5WCLwb2TX0ZPaDrJ/0N2owQ3YQqMGD1qjGLvn?=
 =?us-ascii?Q?kEIAKU/FKc8d6ah2hZHEGUvhw9aHdKW4KacCONZ00lxTFZH0Xk5MZELWOm6H?=
 =?us-ascii?Q?+9SyxsAK+WaoGu8PZCwD4iI8gw9eNWl9rfC9hEsdqcfiTDp47yU+pOLWeUFn?=
 =?us-ascii?Q?3jH5Iz9C3eYotoquAf0QOprXUCaextitQczL6t8uuWfdyHWgLLypdIb/Sbl+?=
 =?us-ascii?Q?/CNvQIKfqxkk+gtCOXh47pSsphjCoAPeNQ1aFAN7zXkNjXaafbbqguJl1iL6?=
 =?us-ascii?Q?oDx5G4m/NdaE0OBa3vb5JP2+S5yiBY2Y28pyC2BpV7E6Ilb4Hu+E34sBIUiO?=
 =?us-ascii?Q?SbLIn4OpjsIJc3NSOPf+eVn5qnQjLB/zZuzcomz3o95qiROpAn6Ii6ZLjkCF?=
 =?us-ascii?Q?aHs0usOGFkUwM5TbgJ1SCaOupv639f6HqYvD8oJypYzf9e4LL49U2tzgZupa?=
 =?us-ascii?Q?aDUsQ74bbncs8vB98xHXlpYkW75cbm/gmOCsQQ1I1wOBS3wRhR6pIR2zjoMw?=
 =?us-ascii?Q?RFjnd1i4gsblHphmq/PIvzU2BnqgYTRFYYMLrgQhB4H7uKMz53ycJWj3FIya?=
 =?us-ascii?Q?KiRqHynuKVhS28H1zV5ihFvrGcdnQA/CxbOVa6I+QcAlhLubFojoWF7RLxUE?=
 =?us-ascii?Q?5WRhpnAft0fuO4V8T1u2ie+unAAARV+oTWlfPpCpb0ydG9xtV+5QxfXvTl33?=
 =?us-ascii?Q?/1akDDzDVf1fWv5E4JCdTvGE63t0leviC6NY6JSjf8btkbAla+el1TCWd6a2?=
 =?us-ascii?Q?9e2S3uNZD+eHDjlhZS7c38qCLhtMhTFztA46G/YLC5V7eg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BDumwohEDOBFByvu4V4URjZq/OEBipauSm/rNX3lKrRVzdlxjqrO5Ig1U5YZ?=
 =?us-ascii?Q?dVil6j/03VDiPLpDsMbSkP8/1G3mpC4nUYqHhgp0TvffbI3LmRcKZrPHfMDk?=
 =?us-ascii?Q?OkfGsbiwt7YQ8+lrBtBceK0wR1OlGA2dsFh1ZTgAHfKsnJEMlEYQkB9sXxOr?=
 =?us-ascii?Q?BYlkqzinFh13Cy3iRWie0XJXfX8kRN/dirBjOTQW4mH+UxCdjHhjzqhtYulF?=
 =?us-ascii?Q?fExjc6PMZRwl+WahQ5C/gnaxI5EoJelpLG9Dg+WiM0GdDWK4vnfbv1zDZHtx?=
 =?us-ascii?Q?e3ekS+bZhKo9h7c7sgl+u0sC7eZdOBZFotpUpNWMJUC6OUrHahXpHwvjvedn?=
 =?us-ascii?Q?CfWgOmka3s2++2rSAamM9Inftcrpnm6croSFnK9Dc29KGYUXYAlvTdSv2Sp6?=
 =?us-ascii?Q?1guXi1PxsOwD7mjzxul5/x1OtzUb0RiEXhT8AEqVToy5NH9w4254V3MN3YGm?=
 =?us-ascii?Q?cw5HL34rlkaaAqzmxM3OD+kVpwn3HsMscYW2M8quGJJ/7cleIndGI9wrX774?=
 =?us-ascii?Q?6cifgKiu66+4aPfswDl3HHjHG0HoS1k07NjBDh08OXo0prfEXZJ8RDC6kTZ3?=
 =?us-ascii?Q?1OazBJ/ZsQ5Som6YC57hhXEbhwiS6siViu2C3jE1HIjwqaLk9v9v3g+fLfZs?=
 =?us-ascii?Q?YeDR3JhGOtF0ylYhZxiOIJ3MlyB2JN3RvyVCesXbh2z7h+QF2kKthYLTS0XX?=
 =?us-ascii?Q?3h7jhl6QMy3XlcqWcU7Nkz9teklUQgXYaiB+Y/uG+J9a62yHSX3zDiZSGMi9?=
 =?us-ascii?Q?KmLtsWHg4fy3l9VxJ+hX3sTfH1V5k/pUBfDGIES2FG1ydiWqsu13V1DIb9IR?=
 =?us-ascii?Q?HpZlOX1OXhCGcoGqNLr3YVDOKWxgzPNkine6cSTXooZhRVccywYNqi2V4GbB?=
 =?us-ascii?Q?1sOrwwUsDlAbS9yClrx38pEthQkNgYVxEm6zqOVIyFkwIrsqmUdBekITIunD?=
 =?us-ascii?Q?vJUaocwnNLFwt94sQIs5ItOGVJc2pxGe6SU7WtEJdb8F9iDDn6TjjSeCJiIe?=
 =?us-ascii?Q?jWpHzpzMq0KAMphbRtPs4/2IlIdcu8ly8Uw/jlqzPaXcu3avrQ/gU/wGCHJR?=
 =?us-ascii?Q?VvIObHb+oAn0IFE1I1FVCcG2D4bi0OPMznLuUqdprX5ff6rJvAhsLUe8Iz+l?=
 =?us-ascii?Q?PqFNyS5IZAMG0L3jEhXPFrvRRgX2SVF+qz7+meCyx5uuJQIGubfH/KqD0kQ4?=
 =?us-ascii?Q?Q99qIRwXhXi56lk2g2NjY33322xz0oW9V5mr9BBkWmtbWi8TzFdGp7TkxUZf?=
 =?us-ascii?Q?BO5xtpymrTr9972iggZalbatPx/aExAOQ4Pc+8KYVVTK942ui8DqSPjhL+oX?=
 =?us-ascii?Q?8q3W9FOIrA5qycj67n9eWU9MRlfyxUvJhfL7g0cLxBIZxl6uXl7YJCsEgymm?=
 =?us-ascii?Q?14AofzMsGUtqrCf4kMwkrwsPkq1CqC/D7EAel3CJFZJHSDbjcp3Zkx3caxDH?=
 =?us-ascii?Q?YZog3cf4W8FdEMS1k/T7derl1cG5uYrwTFZXJSA2yLZY0xcXI1+NF6sS7Dzd?=
 =?us-ascii?Q?/0YpyTauBIFiU6Gx7LSWS3Hd+j8h9JZDV8LIA2Jiz1RR/t75dzKgLJr3et+q?=
 =?us-ascii?Q?xguD1RFmRe0GhPDDYE64ryTzPKt67AtQDQSAjKBY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 198466c9-bf7b-44c3-0f7a-08dd66f5e8b0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 14:54:11.5601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ShOYClS+7q7avRl1bUkRJtVMy2UVkgo0TpMgjq0X0gf2D2dGTvBO9l631yPfeH+qdM+Odfql/ZaeUkV4ShgHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8331
X-OriginatorOrg: intel.com

On Wed, Mar 19, 2025 at 03:37:16PM +0100, Jiri Olsa wrote:
> On Wed, Mar 19, 2025 at 07:30:45PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   81e4f8d68c66da301bb881862735bd74c6241a19
> > commit: 7bdcedd5c8fb88e7176b93812b139eca5fe0aa46 bpf: Harden __bpf_kfunc tag against linker kfunc removal
> > date:   9 months ago
> > config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20250319/202503191909.SHOCLBzK-lkp@intel.com/config)
> > compiler: mips-linux-gcc (GCC) 11.5.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503191909.SHOCLBzK-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202503191909.SHOCLBzK-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> 
> hi,
> we hit similar issue before:
>   https://lore.kernel.org/bpf/CAMuHMdUaYP3-2JHk-OE9B-AWNU3ikhBdLyWDm0R8DwQpUS9eCw@mail.gmail.com/
> 
> solution was to upgrade gcc

Thanks a lot for the info, the bot didn't handle this at that time. I will
fix the bot asap to avoid such false positives.

> 
> jirka
> 
> 
> > 
> > >> net/bpf/test_run.c:511:1: warning: 'retain' attribute ignored [-Wattributes]
> >      511 | {
> >          | ^
> >    net/bpf/test_run.c:557:1: warning: 'retain' attribute ignored [-Wattributes]
> >      557 | {
> >          | ^
> >    net/bpf/test_run.c:566:1: warning: 'retain' attribute ignored [-Wattributes]
> >      566 | {
> >          | ^
> >    net/bpf/test_run.c:573:1: warning: 'retain' attribute ignored [-Wattributes]
> >      573 | {
> >          | ^
> >    net/bpf/test_run.c:579:1: warning: 'retain' attribute ignored [-Wattributes]
> >      579 | {
> >          | ^
> >    net/bpf/test_run.c:608:1: warning: 'retain' attribute ignored [-Wattributes]
> >      608 | {
> >          | ^
> >    net/bpf/test_run.c:613:1: warning: 'retain' attribute ignored [-Wattributes]
> >      613 | {
> >          | ^
> >    net/bpf/test_run.c:619:1: warning: 'retain' attribute ignored [-Wattributes]
> >      619 | {
> >          | ^
> >    net/bpf/test_run.c:623:1: warning: 'retain' attribute ignored [-Wattributes]
> >      623 | {
> >          | ^
> > --
> > >> net/core/filter.c:11863:1: warning: 'retain' attribute ignored [-Wattributes]
> >    11863 | {
> >          | ^
> >    net/core/filter.c:11876:1: warning: 'retain' attribute ignored [-Wattributes]
> >    11876 | {
> >          | ^
> >    net/core/filter.c:11889:1: warning: 'retain' attribute ignored [-Wattributes]
> >    11889 | {
> >          | ^
> >    net/core/filter.c:11910:1: warning: 'retain' attribute ignored [-Wattributes]
> >    11910 | {
> >          | ^
> >    net/core/filter.c:12096:1: warning: 'retain' attribute ignored [-Wattributes]
> >    12096 | {
> >          | ^
> > --
> > >> net/core/xdp.c:713:1: warning: 'retain' attribute ignored [-Wattributes]
> >      713 | {
> >          | ^
> >    net/core/xdp.c:736:1: warning: 'retain' attribute ignored [-Wattributes]
> >      736 | {
> >          | ^
> >    net/core/xdp.c:769:1: warning: 'retain' attribute ignored [-Wattributes]
> >      769 | {
> >          | ^
> > --
> > >> net/ipv4/tcp_cong.c:455:1: warning: 'retain' attribute ignored [-Wattributes]
> >      455 | {
> >          | ^
> >    net/ipv4/tcp_cong.c:469:1: warning: 'retain' attribute ignored [-Wattributes]
> >      469 | {
> >          | ^
> >    net/ipv4/tcp_cong.c:495:1: warning: 'retain' attribute ignored [-Wattributes]
> >      495 | {
> >          | ^
> >    net/ipv4/tcp_cong.c:514:1: warning: 'retain' attribute ignored [-Wattributes]
> >      514 | {
> >          | ^
> >    net/ipv4/tcp_cong.c:522:1: warning: 'retain' attribute ignored [-Wattributes]
> >      522 | {
> >          | ^
> > --
> > >> net/ipv4/fou_bpf.c:46:1: warning: 'retain' attribute ignored [-Wattributes]
> >       46 | {
> >          | ^
> >    net/ipv4/fou_bpf.c:88:1: warning: 'retain' attribute ignored [-Wattributes]
> >       88 | {
> >          | ^
> > --
> > >> net/ipv4/tcp_bbr.c:300:1: warning: 'retain' attribute ignored [-Wattributes]
> >      300 | {
> >          | ^
> >    net/ipv4/tcp_bbr.c:333:1: warning: 'retain' attribute ignored [-Wattributes]
> >      333 | {
> >          | ^
> >    net/ipv4/tcp_bbr.c:1028:1: warning: 'retain' attribute ignored [-Wattributes]
> >     1028 | {
> >          | ^
> >    net/ipv4/tcp_bbr.c:1040:1: warning: 'retain' attribute ignored [-Wattributes]
> >     1040 | {
> >          | ^
> >    net/ipv4/tcp_bbr.c:1082:1: warning: 'retain' attribute ignored [-Wattributes]
> >     1082 | {
> >          | ^
> >    net/ipv4/tcp_bbr.c:1091:1: warning: 'retain' attribute ignored [-Wattributes]
> >     1091 | {
> >          | ^
> >    net/ipv4/tcp_bbr.c:1102:1: warning: 'retain' attribute ignored [-Wattributes]
> >     1102 | {
> >          | ^
> >    net/ipv4/tcp_bbr.c:1130:1: warning: 'retain' attribute ignored [-Wattributes]
> >     1130 | {
> >          | ^
> > --
> > >> net/ipv4/tcp_cubic.c:130:1: warning: 'retain' attribute ignored [-Wattributes]
> >      130 | {
> >          | ^
> >    net/ipv4/tcp_cubic.c:143:1: warning: 'retain' attribute ignored [-Wattributes]
> >      143 | {
> >          | ^
> >    net/ipv4/tcp_cubic.c:325:1: warning: 'retain' attribute ignored [-Wattributes]
> >      325 | {
> >          | ^
> >    net/ipv4/tcp_cubic.c:342:1: warning: 'retain' attribute ignored [-Wattributes]
> >      342 | {
> >          | ^
> >    net/ipv4/tcp_cubic.c:359:1: warning: 'retain' attribute ignored [-Wattributes]
> >      359 | {
> >          | ^
> >    net/ipv4/tcp_cubic.c:449:1: warning: 'retain' attribute ignored [-Wattributes]
> >      449 | {
> >          | ^
> > --
> > >> net/ipv4/tcp_dctcp.c:90:1: warning: 'retain' attribute ignored [-Wattributes]
> >       90 | {
> >          | ^
> >    net/ipv4/tcp_dctcp.c:119:1: warning: 'retain' attribute ignored [-Wattributes]
> >      119 | {
> >          | ^
> >    net/ipv4/tcp_dctcp.c:128:1: warning: 'retain' attribute ignored [-Wattributes]
> >      128 | {
> >          | ^
> >    net/ipv4/tcp_dctcp.c:184:1: warning: 'retain' attribute ignored [-Wattributes]
> >      184 | {
> >          | ^
> >    net/ipv4/tcp_dctcp.c:194:1: warning: 'retain' attribute ignored [-Wattributes]
> >      194 | {
> >          | ^
> >    net/ipv4/tcp_dctcp.c:244:1: warning: 'retain' attribute ignored [-Wattributes]
> >      244 | {
> >          | ^
> > --
> > >> fs/verity/measure.c:121:1: warning: 'retain' attribute ignored [-Wattributes]
> >      121 | {
> >          | ^
> > 
> > 
> > vim +/retain +511 net/bpf/test_run.c
> > 
> > 391145ba2accc4 Dave Marchevsky         2023-10-31  509  
> > 400031e05adfce David Vernet            2023-02-01  510  __bpf_kfunc int bpf_fentry_test1(int a)
> > faeb2dce084aff Alexei Starovoitov      2019-11-14 @511  {
> > faeb2dce084aff Alexei Starovoitov      2019-11-14  512  	return a + 1;
> > faeb2dce084aff Alexei Starovoitov      2019-11-14  513  }
> > 46565696434095 Kumar Kartikeya Dwivedi 2022-01-14  514  EXPORT_SYMBOL_GPL(bpf_fentry_test1);
> > faeb2dce084aff Alexei Starovoitov      2019-11-14  515  
> > 
> > :::::: The code at line 511 was first introduced by commit
> > :::::: faeb2dce084aff92d466c6ce68481989b815435b bpf: Add kernel test functions for fentry testing
> > 
> > :::::: TO: Alexei Starovoitov <ast@kernel.org>
> > :::::: CC: Daniel Borkmann <daniel@iogearbox.net>
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 

