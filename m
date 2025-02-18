Return-Path: <linux-kernel+bounces-518563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20274A390ED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 03:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C10B67A32B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 02:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77417E0E4;
	Tue, 18 Feb 2025 02:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KxX0bCSo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B302556E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739846789; cv=fail; b=dmq/S47jizfLCrP5WZHtjQdbD1EsoC/KJ1TK05OdfywVqHY4EwvjvV/vf9CtodE8m3Ers6QwBcJsUQd0+tZF4NTbSUrO1B+9HZ87/HB3ZGr7KXJegHGmQfmP7lYRRlZOOXI8CKMHwElPCj4WT3aRZ4bEhCWB60umvqQzQU7I23o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739846789; c=relaxed/simple;
	bh=g5GUbvdrcw3oq7kRI+2A+88f1/1FBIHxpHBpsdm/m1M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aENpvWRq6gJE6+CqnLWfaltKzaFLuyLRG7fxfpdoeUK2S5hsi1LcYvwqhlBkQZR7WOyjQs/3n0c7RDUBlQyX7ocJEEOGVwRT16/kJcJdFejrgzhPHbkejO687uJcTsYWzHVzpAKRaPz9RxbgtJEuKM0fv9z52MDAVKoBitBAl9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KxX0bCSo; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739846788; x=1771382788;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=g5GUbvdrcw3oq7kRI+2A+88f1/1FBIHxpHBpsdm/m1M=;
  b=KxX0bCSoaSd/2bDLwg8a1FNDVHOQRTbtWipehzAo56jvZiHXvI2NEPNJ
   GWXJQ4poH0edJg2nheyqIOMA2NKCHzQfuIZbus/AVKE46dxFmjLlIQW0P
   R9Dhcl4nTlSTgfX2agir+psqdyVcT23Zuvfu7ODAM4BUVMQRZZBZNF3c3
   534BEwblghXMcXsBdAKO4w2whMPCQJmrIdOi3zF2ttd7jx1zq2SHGCp+n
   OOmIjjPv3uc2OZwIKNpKzOW4K7FpK5y12ZM3JmNnFy4xWgo8uGGPWnbf4
   LcV2beo1LnVHNJ5kJFWKxTS3GMQmiYvxnYLYZzpPMEykzL4QIaoaCCk2U
   A==;
X-CSE-ConnectionGUID: 5TK5J9iIR5qo57HJ4uHSbQ==
X-CSE-MsgGUID: NxF/WWLAQtuCSFdr+P3rkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="65883168"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="65883168"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 18:46:24 -0800
X-CSE-ConnectionGUID: LdKT04I5S5mZj0QVpcMhRQ==
X-CSE-MsgGUID: GSOgdvHfRFGJi3evkO7QVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="114190829"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2025 18:45:09 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 18:45:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 18:45:08 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 18:45:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mackBBxRuzvf7I5MKny4ecDxn9/G84FtOkWbebWXpxvDx7PM8eeR3ivlgmZmNbcOkbNA7OwaJjCI/xxvxnO8wVBWEEMKy0AxD25jmUMTqJrN7g2xLpWRt/4X0h7SPkDURm6jj1EY94OWRmTyEtDWGZN7s2HvAh4KYgdM3n6pKaCkJrJGmCsQz7hqcJ4qgWEHMEUaisoyBxbirLfy+4Aue/0kOh+cvUYr1c+Nnnq9HQfpAkSIOAgWwEM1K+MLl5cBTVcIvEto42CBwwKUm+5m9e0IeaFhvg4Ww+rdt/obqnx0nB0EvO3n0kKLBNSnLe9FQxzW77EAhlaJEBu0RfmnEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjuimJUwR/Q1RurqU7dxzGtC6GSd7XBXlgXlXuIGb94=;
 b=vkzjlNV4ByIkxVhV/BS8snYRE+2T9/wWNBkWMJGp954vfVO2VKANtLjRLDc3YaBWnwXgUlLiPV+3sqgOibUJdfDCOvXUKVHBVH/IOljlA+1QalDUmSBK8cw7wi9tcQDUQWY2exx4r2U5nwPhJ3HTr6d5eTVmbgURkLFbUPnsju6DQXchoyUX4aNhcHT8Kfq2/EteoTRPk3GFYpV6fKZwsnK0JG+hf5zFgh1rQXB+PS/kCPl0XlfpMfrL6lfqCn8kzCzvD5SQfZj66HMxk5bHeli3gIrYCQHjwJoRMcfbHkt8fgf3NnaXGVPU2cnhhoqyP3NA4eg67YV2mLLgHR+pRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by CO1PR11MB5155.namprd11.prod.outlook.com (2603:10b6:303:91::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 02:44:37 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 02:44:37 +0000
Date: Tue, 18 Feb 2025 10:44:30 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Philip Li <philip.li@intel.com>, Elizabeth Figura
	<zfigura@codeweavers.com>, kernel test robot <lkp@intel.com>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: include/linux/thread_info.h:259:25: error: call to
 '__bad_copy_to' declared with attribute error: copy destination size is too
 small
Message-ID: <Z7P0Di/nCSVdjifN@xsang-OptiPlex-9020>
References: <202502072019.LYoCR9bF-lkp@intel.com>
 <2421077.NG923GbCHz@camazotz>
 <Z68CX3HMEUW00WYi@rli9-mobl>
 <9791da8a-fb5f-46d0-a86f-66738293d155@app.fastmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9791da8a-fb5f-46d0-a86f-66738293d155@app.fastmail.com>
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|CO1PR11MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: c9732b2b-e24c-438a-d35b-08dd4fc62f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6r0ydciALqWNQlkAQOjIoBvmYjY4OFd3GC6IfuyUcaUKraNMxNmVBySx7vwh?=
 =?us-ascii?Q?dN9u2LjBU7s0ZwyoCzV1Xsr36PBxrg/85JKAuzIMYJmDvXJ6bYrJGMHH2wlI?=
 =?us-ascii?Q?lDdV+mi8lkQvVaOWjpEcjg2ClOBxbD69ECWcIHynZpm22K5MgVtrFy0+KXjn?=
 =?us-ascii?Q?akyLyARGPDUI1IekW+s6nsWkz4z8ScW0ZkA7oq54NEKVfsm+mz6ThfE9hvKg?=
 =?us-ascii?Q?Uc228Uoflq7mME1cdTGf+mFyiQ3ErweqU/+GI98m2sT7u5czNrlIOLzlQV2y?=
 =?us-ascii?Q?dDqWLHEIVEpehTVk3/eQXNVapDr4fRYajupoeM+ZyJuB6/GYKgytBaX1gMcp?=
 =?us-ascii?Q?iytIIa+v+Tcdpqn6ljVk6QlEt+89+rupN35Ewo+Vsn9+1pNTQgUMRdVsEmWL?=
 =?us-ascii?Q?skRbSUBU8BZt5NlZ7HW45FlaDt6frrS0ePU7RdVNqrtl/UNpQ9oMgvCs6ndC?=
 =?us-ascii?Q?T6jXXLsMPnSvgBH0764tUtOIqJUBb9Qi7RD1YPDvbhMB3HloJ/FHb4+3HXv3?=
 =?us-ascii?Q?OHzp2NseH1/dkoU6rPT0/u52hG49V3caJDkw873TotPpH8JNqCmjGO+egY2u?=
 =?us-ascii?Q?/IWJGLC3huoNfQ+29WK6rB7j17vdG1bBw7oX6KIKifE8DcG/2KARBQmtOgge?=
 =?us-ascii?Q?I/pTVPmZ5NVOq7mQaU2cU4rFCAzbaYyHgKV8erl3dWvAinnfgxywWmVq8rKA?=
 =?us-ascii?Q?5S7P2vQ/O8KHy67tqVQ9ckoI8SlUIPY8UA8XNgMHeygicZKprlKN1hHKWvZZ?=
 =?us-ascii?Q?I+cNx/2zJ8izwWWWziiA77m7SVsSnmo3CPQX7keezbc6fHdxxgL6XY/hVsqv?=
 =?us-ascii?Q?eMbQfBGDulLbhdJgIyI2liTgUvp/G0aUPqsJuvMd2ot+MI120dT6ohRB4Jfn?=
 =?us-ascii?Q?3oeMLBxGxEptH4URA8PZnZOA+la0ATu6HdmWD6GeO5jj+0uHf53vuHHIVo9j?=
 =?us-ascii?Q?GCiboed6U3G4ZQLqWaVAzf5LkuO83rpnLFbB25ewEfRhmjIViszKj34vYOaN?=
 =?us-ascii?Q?MjWkzaFEwxjRQ62cMaFz+pKa/OVVm/OY0nEnYhAZCBWyfJQSiddAI9vjyZdg?=
 =?us-ascii?Q?MsWNg8tAm00j9oZxgeRIsMTOfFvUoe8ofG4gXNxl0BASIZFg/Hs+xS6aF3bN?=
 =?us-ascii?Q?Jreqf9fmDiZoFkUFdu074zgsyAEwXdHeLQkoAqOgKWdgvjCxjFbs/RONyQDT?=
 =?us-ascii?Q?hdVoBTOJ/CN3JKG7ie9EPBoj4aOBXLZjpzLpRD1CTT25PXfISqVHdye8OA1G?=
 =?us-ascii?Q?7JPpNXytDl6mpLskSijfw+ocZBgYbF3Vw5nUHyLZzG9EGijhf4cuttJ7Dr3D?=
 =?us-ascii?Q?UP2HWKtpuX2V4QsphKIAjf7NS9ALJz5d2/lktPpnJzZfu8VauEu53+T91BVR?=
 =?us-ascii?Q?6FiZUFJXpEC0k3FUAwOgshnP6n3a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pSKNWm8Jo2+t6AeYxtbcsGftidkGS9r0Uej/VFpkI6FjcCUXuR4JKnwoPwr2?=
 =?us-ascii?Q?+hD3xsLbYawruP6kOX+nPaxGw9nwc2br0bZd3kRXgtG3JjkQHQ8yQvLuelsh?=
 =?us-ascii?Q?vh02Vsef1fOWoodv/hGUwyWto7ZaXw7PVPfnd7HonqjawDdavx9otEDyv+9Q?=
 =?us-ascii?Q?sQP2E9ygKqAXHECJyKH+LWkV5B/CjGurZv67PRSA2VXkW56HbOe02bBJ8ioo?=
 =?us-ascii?Q?DlJqcj7BHRseuQtcIXplK8K79UoGYCGXCvQGhPIHF+KfE7nQ4fmdpJRxlRnF?=
 =?us-ascii?Q?OnNruukw0LyUOEF3oDCjj6KpY6ZSf39d8puMD+aJOo8y/ItyAFkSw0XQfOoe?=
 =?us-ascii?Q?YrAW1rl2CQvrVjMNXpRjSyL2kz8yVNDArH+P1OzQPJBcX0WFGwmBo9QZV4my?=
 =?us-ascii?Q?7ZblxGfF72/I1D/4ESm/P6UEhPDki1LU4pSxfn04ulExpdGePDgj8Sc+o4Gv?=
 =?us-ascii?Q?BWGAzSyXaKOuOboErztV0flclmY8SlxHo+ZxsHF242FeuwpV6eUYL03rpnrv?=
 =?us-ascii?Q?ntZHfce+Cj46okWsd09+xnbIy+PyqvFQx3hdY+z3KutfoWrquJgQ30GFQXe8?=
 =?us-ascii?Q?1WjKp9PMHnQ9B/EqpQ6W8iMJboAAnZzLfNBhQc8AQaP/cvqjxL84FOgeX+Zk?=
 =?us-ascii?Q?Abw3qPBHdW4N0wv49LrTRC0h9rx5XxFWMjQLVGh8nXN4+K/5oJa2JIpqutrU?=
 =?us-ascii?Q?K+7d0h7gOdF0nJjdzn0wrx9WjIEB5PKO1esE0VSum06e/ikjzfq8y+pl9F9+?=
 =?us-ascii?Q?twQGs3gH01H3he+BU6q9tLicqI2Jfc7rkPe4w1sgnk/7x8XiIm+pHJCzfL26?=
 =?us-ascii?Q?Zn9fkFj93o8Lai+D1FmoaCc299UvhPTlxDySiGBfeWEp3vZXVovXyutKm2gA?=
 =?us-ascii?Q?fVTljOs8pVS2MV3Ed1JTzK72GW8llaqXvbIiTRNErUlQPtSWjV7K9OXtWgcw?=
 =?us-ascii?Q?cGlg0FxMfXqHo4CpvhTftrVZsoNtEzw0L7LsyxwR1OrqNdpIJZuBLgHbNVAu?=
 =?us-ascii?Q?+A56voXZDj5oogGGnPiN/Ce6szkYJ6A4Ve7uYdrx6gXgQTf8GsZpCI8+Zd4q?=
 =?us-ascii?Q?giln7+ju+c05qnIU6MWSsQsI2grGV3AiAirvTEcDPPunNRzC0ilWteE7BDpG?=
 =?us-ascii?Q?pOagRq06xpGZZhmH4kP0B10EpzeWAPQzB4m4v2Lh6f/UahjEjqfxcLsFaOn/?=
 =?us-ascii?Q?HdaSdwsxIrLJZWGBv8TimSUzidQmwDgd3CjfJ0cnwcM5NnYHWsUsH6mCFEee?=
 =?us-ascii?Q?ZJ8DXvE7RY2R25n7RJATflyph75mImiJZ5ChTtFtNeVn3d/1zDCJ/64KtanF?=
 =?us-ascii?Q?zi7fEK59w+TuZTNAZbuyE1CHAoTo2gskH0OUbbT0m5jExayeZaeixzl9hx92?=
 =?us-ascii?Q?dH678oeMNQffwtst9Pe3dZxCej5u9h6tzN3PiZZYsR5ZvdyAB2eDPIUyPxaA?=
 =?us-ascii?Q?xeckcvXpQBY8AuwNS93rZgZ497UXy2LRepRNSdwSrS75p6dC6nQastcPeUDZ?=
 =?us-ascii?Q?7J71EwpTk1vZ08/wEjb6x0QffgeOxFOEqCpAxMeGj8tC+mIX+eObswd1zPSA?=
 =?us-ascii?Q?ONzC8zCLoBaWvRVn7wJWbHr20qIW3KZT7Zo1PD6MRNuZ52+xci+Li60TY92t?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9732b2b-e24c-438a-d35b-08dd4fc62f3d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 02:44:37.2277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwJZ+mvyirNd1talmshwbMnbvDf+hc1zi1+6MVu628VCH4OBqUS0j7jttVj88lpJZxpUy5oi24+aY0LRsuldpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5155
X-OriginatorOrg: intel.com

hi, Arnd,

On Fri, Feb 14, 2025 at 12:22:33PM +0100, Arnd Bergmann wrote:
> 
> 
> On Fri, Feb 14, 2025, at 09:44, Philip Li wrote:
> > On Mon, Feb 10, 2025 at 02:39:46PM -0600, Elizabeth Figura wrote:
> >> On Friday, 7 February 2025 06:11:47 CST kernel test robot wrote:
> >> >    In file included from include/linux/spinlock.h:60,
> >> >                     from include/linux/wait.h:9,
> >> >                     from include/linux/wait_bit.h:8,
> >> >                     from include/linux/fs.h:6,
> >> >                     from drivers/misc/ntsync.c:11:
> >> >    In function 'check_copy_size',
> >> >        inlined from 'copy_from_user' at include/linux/uaccess.h:207:7,
> >> >        inlined from 'setup_wait' at drivers/misc/ntsync.c:888:6:
> >> > >> include/linux/thread_info.h:259:25: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
> >> >      259 |                         __bad_copy_to();
> >> >          |                         ^~~~~~~~~~~~~~~
> >> 
> >> This was caught before and mentioned in [1]. The suggestion there of changing "args->count" to "count" doesn't help.
> >> 
> >> Somehow gcc 12 thinks that the array_size(count, sizeof(*fds)) parameter is constant, although it's finnicky and depends on exactly where __builtin_constant_p() is evaluated.
> >> 
> >> The bug goes away with gcc 13. Is this worth trying to work around? I don't have any ideas for how to do so.
> >
> > Thanks for the info, at bot side, we will ignore this error to
> > avoid further reporting on old gcc.
> 
> gcc-12 isn't really "old", we support gcc-5 through gcc-14 at the moment.
> 
> Maybe the change below would address it? (Not sure I handled the
> "+1" right here, but something like that should make it obvious
> to the compiler what the check is).

yes, below change fixed the build error we reported. thanks

Tested-by: kernel test robot <oliver.sang@intel.com>

> 
>       Arnd
> 
> diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
> index 055395cde42b..ae13aae9194b 100644
> --- a/drivers/misc/ntsync.c
> +++ b/drivers/misc/ntsync.c
> @@ -873,6 +873,7 @@ static int setup_wait(struct ntsync_device *dev,
>  {
>  	int fds[NTSYNC_MAX_WAIT_COUNT + 1];
>  	const __u32 count = args->count;
> +	size_t size = count * sizeof(fds[0]);
>  	struct ntsync_q *q;
>  	__u32 total_count;
>  	__u32 i, j;
> @@ -880,15 +881,14 @@ static int setup_wait(struct ntsync_device *dev,
>  	if (args->pad || (args->flags & ~NTSYNC_WAIT_REALTIME))
>  		return -EINVAL;
>  
> -	if (args->count > NTSYNC_MAX_WAIT_COUNT)
> +	if (size >= sizeof(fds))
>  		return -EINVAL;
>  
>  	total_count = count;
>  	if (args->alert)
>  		total_count++;
>  
> -	if (copy_from_user(fds, u64_to_user_ptr(args->objs),
> -			   array_size(count, sizeof(*fds))))
> +	if (copy_from_user(fds, u64_to_user_ptr(args->objs), size))
>  		return -EFAULT;
>  	if (args->alert)
>  		fds[count] = args->alert;

