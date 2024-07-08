Return-Path: <linux-kernel+bounces-244001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AEB929DC2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40A41C21B2A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A78A39AEB;
	Mon,  8 Jul 2024 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abxTTkEr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9539F849C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425288; cv=fail; b=K4o/hTANcWkNVTqd0JWhEcBl7etOBL8xXLPnbmxwZBgfQmyIhorV2iF8H/rifzYg4wOC2ogPWbz3XaE5spuE5erQviptdpYrxmhKSS+t2itxdtp0oulf8Ei9ZIL10UAFuD5c7CKX9+UEJextDsxzM5atPVEnZXNcvHcAB2O/osc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425288; c=relaxed/simple;
	bh=ksj7Ki4yt3xOLK9Ei4k3eoBhgXjezB7sesZHMjMuDyk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UVshrdzfX6NCYZevcbgVjKhtjd81LmcvkNnELQ6sHd3fjQiJzwpJSvgaRGtrTYyvmFwre1Va3dHe7pZpthxoHSszM6vWU3H69hXhssLVK3AhYbDNAXkatvau86q4f7s9fs4On92ycIB2ud8p4OnD04U/T1PcgBaWCPBID+IUhWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abxTTkEr; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720425286; x=1751961286;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=ksj7Ki4yt3xOLK9Ei4k3eoBhgXjezB7sesZHMjMuDyk=;
  b=abxTTkErx6/Cw0n31t4oY6FibFQrt35VVDgD7fPtS19AU6CBS+X0RS5d
   5peJJTd5l3wS5jXJ5xANqX5gpHUz6kzqQJjprwaovrIbp68POUe0wZsgR
   86xaG+hGfBEJKQ8B0iJLKBKsSyM3O+xAgXUzczciyNFkw8fARhWvCKUU+
   QKi/V9wyU0v7mEfG83q1mgOXBWuhEzNiR0BpBjl2WcRuisqKjGsrcIq1V
   rGnrhvFuAM9wJoVhiFWfrEXrFWYN7+e8TB/gK8huuLrjtYk9gIuN+I6gP
   DfjDEaymw0uBA1jl2ztaUc5iMtO/kq1mLNzfI7fs6V0z58mICTdElpd8A
   Q==;
X-CSE-ConnectionGUID: /NRunrzLT4yS/Od9kyHpHw==
X-CSE-MsgGUID: hWmVZgEKRLOrD8G/f1V7ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="43034455"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="43034455"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 00:54:45 -0700
X-CSE-ConnectionGUID: 3dTwRc/lRwinqkmFGR0Yrw==
X-CSE-MsgGUID: i4gLTuvpQm67Kd4XB9s8Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="70632151"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 00:54:38 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 00:54:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 00:54:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 00:54:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqqE6S1wQzeIVgB/pjVxMh1eYnLVoLdN+ogwqnTIIPmX0w64FM798F2CaRaPlbKeaX4ANGgjjUpez9RBAWVoEWgkeV36gdDfwf9h+1RnjYdDWEmEUmRkz+bHhvKpCKAi0RgMKBV9RVnQlwPaB76lbVVgIjdcX1kxQ5xZ1efaKW008JadG1WsBcz4AIte+4OT30j4tEBuLOHeKtouAFAEPzS8xFYgB+jU1gB2OFcZmGmY7Kd4MnJoaouGNBfXeuYXgo6PcYPKlcJq9ROTBXtZLejUHSuxUW5qXqlh6YOE9n7aSOsIa22q7UzLTwjNxiLsPzUD6GeTopbrl/UbLLhgUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LA0Ysu6UU+vE6zBS8mNeqe8r2Z2Sxmgnwk1LWgR/pQ=;
 b=Alr1uXpKB18TcQS//cHxIHJfSD1AsnKuGi7jCogLgPbxtLHAIHYprInD6Ghsm8ZaS8RiiHxX+e3iGAjJijkbqDnpKgjJdQNNDOFatfV+mK+frYM+OE696CQM5wNYUdJQgjvCUow9KTLlaBPrU+hEzpDNHVqpLdc8FFvGWD2r3nCpT6+4LJwCKKmHHF4fTbU5qvOMk2XZCq1faFbJ+mXwwvYVS77TiHiPFazZnHnObc890tBPuT0gjdxoyNmqiVRQAS4cZYYGW7fYwc8+J7Q0fH709Z667xKbdCLLlJrXkodrE6J7rERsgxOgbFWgaWumwC+PqAoqFOzixgaU9Q2egQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB8490.namprd11.prod.outlook.com (2603:10b6:806:3a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 07:54:29 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 07:54:29 +0000
Date: Mon, 8 Jul 2024 15:54:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>, Tejun Heo <tj@kernel.org>, "Lai
 Jiangshan" <jiangshanlai@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH V2 4/5] workqueue: Put PWQ allocation and WQ enlistment
 in the same lock C.S.
Message-ID: <202407081521.83b627c1-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240704034915.2164-5-jiangshanlai@gmail.com>
X-ClientProxiedBy: SG2PR02CA0096.apcprd02.prod.outlook.com
 (2603:1096:4:90::36) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: bb03a47c-c225-41f5-b984-08dc9f23322f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XuulqkEZ0st+0NLXriFhJ50qq//r7rL5tHbN1Qhq4kDFSFMCzmZ2IEZQjvA0?=
 =?us-ascii?Q?6Vu+HfxTsMsf1GWxssber67fhknNhXoxEQWGeI+REwSXGHJHpkWPBbDlS/Cg?=
 =?us-ascii?Q?P1RadabL3h2GnUJnTaj1IBuKoQQL32MpgUPP0y+hngwlYClrE9M6NBjxRDNR?=
 =?us-ascii?Q?ClR6VpS5dByH19b5sVaTtEM6/SXAYPVCL5PEzLLK4nqoNdoLhVoxmgH2pvoF?=
 =?us-ascii?Q?PF165yew9N+F1IT54vDbnT4/MkjcVvjcpRL1gXkbIzIluao+fnOKGDNNdDM8?=
 =?us-ascii?Q?T4TdUU5ACNL1yXsmeqksz3nBJvUCrYNHhBJi9wpeWqvirpwhHdbO0TmTcY9T?=
 =?us-ascii?Q?+H5INyUZTXfX+N5bhvvCPIlQbHC1WN+UgAJ6rKJ9zPnrrFrAZ5i1Fx3cvZdY?=
 =?us-ascii?Q?sppvy7nc4pzNtV+tddXT2IgUL/OVyy+udBJGwXmfcK8WpBGTSJ3aIBibb21P?=
 =?us-ascii?Q?Z69OapwE2/IUbZIENDGKB/h+CadqxD6+lVfZURMZC7S54J2NMAF1A9p3xa0Z?=
 =?us-ascii?Q?IFH1RbS0KtE5cT0j31b0dCUbZNHOu/xsQT+Xsam+wdv8qy6j2HROR1CfenwU?=
 =?us-ascii?Q?ovtkW6GUU2n/wWXSevRA4I9ebk+dZG4o79vRTuJHwD6KPCDDFChXhtVgT58c?=
 =?us-ascii?Q?dTq6crWW8swRBh9yx6Pu0tMiQzCWMK7SOsdBVVKS1k8za3iYBp11LJelfgqg?=
 =?us-ascii?Q?Kc5DnOo9l1YYiJFYXWfWa9N6vvfAwE+kxE04btY8i00BQPAHAcVVbxlbVr7J?=
 =?us-ascii?Q?+SlPd0RlSvAUdBGw8rqedUqQyDWB97M5NcCB9MVnl7F5wbp5madRG2uERhTV?=
 =?us-ascii?Q?rfgfINaEUwzAWQgQWLpxN1FnDgRfvhj4jiT4C/VAob/+FyZ251r3zKZbq0iZ?=
 =?us-ascii?Q?lw1DaMU4FSa6A/uYaWM76wRAWe/oTxS5a6eywpul2xCGtQbwyRs2pMDPMvcD?=
 =?us-ascii?Q?XuIvworOzB7GcGGFaxNJWnN+0fNHtXoH6mz6JkDCSNrqJrFCnmt7P0IJnVrl?=
 =?us-ascii?Q?biZ91YTZiNwy2b6/oI2GSwc4moXX/6wUt/CRxpu1n28gYPPbpQuB1TpEAq7P?=
 =?us-ascii?Q?bjsvSTurVcLUezSPjgZuDKnqPI0PB/Iw5gtcwsCT5kOdPo6HrAcIuxhv5GMP?=
 =?us-ascii?Q?/4ohmTZAGrskD8GEpyJa8H7qcAuZuR6kDyOb6pSNYh1oABQ1g28KMWCl1t7G?=
 =?us-ascii?Q?tysB4+f3KtqdbC4aUsOF4ibAjePy3xN+o+npNz24iUJWlu4MUNUMIeifQd7T?=
 =?us-ascii?Q?NIqOfPB8YDYOv9WTv0sWgxG7S3GMdl4eNUMYQeWUGxkASlDJ+3jjnbOqPfNb?=
 =?us-ascii?Q?60QFKO/IPyk/Xs5xoohboIAv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yWYLLY89g9Qxdx2YDeHENsrsVAt3g+qXVMIKLK/ba8Ai8iMfJopgFaJT2QnC?=
 =?us-ascii?Q?CaskQaOTmzBppcU1kKouxNftAeOZCsNPgOHINFEL40hXcECcnvhwn6IDWcKm?=
 =?us-ascii?Q?Xk2Veoj3Nww2GRYcNKdRVgL2QgwKmB/48ojCBCMpq/HjrrrBDljfWXqbD046?=
 =?us-ascii?Q?MHUvlR8jTnuzRuP52TOBHDa83HANPoLIXI2wcd9wuIR2O5MvTsfR1lyZu8Vx?=
 =?us-ascii?Q?pyxU/EP5bfvo9BbT350GdyNef4kcbCKX/FgVtyLHxBukMyrH5j9xYoUhxu1j?=
 =?us-ascii?Q?NX9Djg4qEwGK7kx8s2NBkfuk94L/49Bd4iWExQDH5lLXUFYm2aa6PYxqb9Ld?=
 =?us-ascii?Q?UEJjGhA+0o94MT/BpKYx51VAFXpgDS6F6EMU4WIudgHiSmn0QY2IbLZkR995?=
 =?us-ascii?Q?1IPbXYFt7yDfZlgN1nzwVhneQJLj2FdyNBHmxlvhCOU2QdX2B6xu7H7Oe667?=
 =?us-ascii?Q?0We434EmC4E/OmhuAjOM41o50HPgkJAuk3sbCRc94bDGCiDGGQ8hSzeWOO7v?=
 =?us-ascii?Q?nlplJclPZ1hT6KuObguzUFNYyv6H93GuncawYMoYpwR6pzamkg3DiB63BUto?=
 =?us-ascii?Q?9mgO4ozxxyX2zgddzTb0TlDzvA6TLGsnKCWo/0xPa9/6tzFkJ7dluBX6uI0/?=
 =?us-ascii?Q?3zK7Xa2wRTXJt2RGvGLG3Firuf8CaIJrPmVe/vvxxODrBtxHwlZ7wj68N/oC?=
 =?us-ascii?Q?qj6SwqYv7N7+Y2xzIYMTcGjzZv+wv+wqmfp5+pTFHQV0kkpPnewlUa1jlcZn?=
 =?us-ascii?Q?mRK9HYNOVuLa88wNFG++ZSgvIMja+URNQpInLNbVt0zgYzIILUBVVaJMVMbi?=
 =?us-ascii?Q?91H1a9tknAptKa7dOGtpewqVMOAQH7Bo/9wTZeVRrycNHo7j6t2OOSsxz15d?=
 =?us-ascii?Q?ZWt1NsEdff1Qmq/7jgsVAscTIx30WWZTstEno5uj7J0yyOdlRt/Q0WtEKl1w?=
 =?us-ascii?Q?aUIwjbDmXawI36oukLHh24KGmGJdcyd0+PmN9hUSgHm81B8X9PTrTNB53SGa?=
 =?us-ascii?Q?5VzlquXE9dizMwQxhoJfNBPga2aHycXPgO636cuGwpCYGSw65M5OHdvM/RwA?=
 =?us-ascii?Q?sLo2PpNzYyDjVBeOKVojU380MO1af35J9Wd7s8KOmeCb8GZRNu+3gJDPJJI7?=
 =?us-ascii?Q?6hJIeGxCspjiJWPd1xDBm4KtVw1aQ61aqGKU5lN4KDfCCSoJpD9aA0bibmXZ?=
 =?us-ascii?Q?51SBmZ3NpyFGbK6qle90LCZZtN+rGUvTCKEgOqQGOgqW6dyYXXHpO7Q7mz+r?=
 =?us-ascii?Q?8viqWa38pFJWSMIEZBpssFsGh7hnrc1/iCyKeS3WkjNfSD/1m4ds/TOQjLUb?=
 =?us-ascii?Q?PmD0aw/4L9MVO2fd1OvzPdB3NJ9ZAKgqsUzSGkRLWGChno9o/VPcwYbK8aOt?=
 =?us-ascii?Q?uQDHGG8COHrUTW8XPfZMii1Hd5wIw9HlUGyC3a3khgHN5ZrWLnkrUXE1YiQl?=
 =?us-ascii?Q?b5nxEGNNI5OifUWGtceQMLtB0qw802imJnLgvgr2kv/LD3Nhhp2ahUh6XwLL?=
 =?us-ascii?Q?iv2seqwNETY09ZW2hILNlxakNbegBzDErGI13M2opZjRECXCPZeTKEnp0SYx?=
 =?us-ascii?Q?5KZvwfNH6oN1FD4rf+NYMASlqwU6dCA7vJQ04kJhGMctiJOW50VvG0fBeXw4?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb03a47c-c225-41f5-b984-08dc9f23322f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 07:54:29.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kXJLhEuFMXzOzpc7kNwwjIQUh/HM5pug/HvKu4WSw206+jbMCVbKvQtT2CunVBkNHJ1ZT9x+PzpAB7gZXiCQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8490
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_recursive_locking_detected" on:

commit: 1d4c6111406c8306a9b87ba6c496996cd4539cfd ("[PATCH V2 4/5] workqueue: Put PWQ allocation and WQ enlistment in the same lock C.S.")
url: https://github.com/intel-lab-lkp/linux/commits/Lai-Jiangshan/workqueue-Register-sysfs-after-the-whole-creation-of-the-new-wq/20240705-043238
base: v6.10-rc5
patch subject: [PATCH V2 4/5] workqueue: Put PWQ allocation and WQ enlistment in the same lock C.S.

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: default
	torture_type: srcu



compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407081521.83b627c1-lkp@intel.com


[    2.233457][    T1] WARNING: possible recursive locking detected
[    2.233457][    T1] 6.10.0-rc5-00004-g1d4c6111406c #1 Not tainted
[    2.233457][    T1] --------------------------------------------
[    2.233457][    T1] swapper/0/1 is trying to acquire lock:
[ 2.233457][ T1] c27760f4 (cpu_hotplug_lock){++++}-{0:0}, at: alloc_workqueue (kernel/workqueue.c:5152 kernel/workqueue.c:5730) 
[    2.233457][    T1]
[    2.233457][    T1] but task is already holding lock:
[ 2.233457][ T1] c27760f4 (cpu_hotplug_lock){++++}-{0:0}, at: padata_alloc (kernel/padata.c:1007) 
[    2.233457][    T1]
[    2.233457][    T1] other info that might help us debug this:
[    2.245549][    T1]  Possible unsafe locking scenario:
[    2.245549][    T1]
[    2.245549][    T1]        CPU0
[    2.245549][    T1]        ----
[    2.245549][    T1]   lock(cpu_hotplug_lock);
[    2.245549][    T1]
[    2.245549][    T1]  *** DEADLOCK ***
[    2.245549][    T1]
[    2.251678][    T1]  May be due to missing lock nesting notation
[    2.251678][    T1]
[    2.253463][    T1] 1 lock held by swapper/0/1:
[ 2.253463][ T1] #0: c27760f4 (cpu_hotplug_lock){++++}-{0:0}, at: padata_alloc (kernel/padata.c:1007) 
[    2.253463][    T1]
[    2.253463][    T1] stack backtrace:
[    2.257461][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc5-00004-g1d4c6111406c #1 c89023213b7b89ade58aa28d4c172b811b00908c
[    2.257461][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    2.261462][    T1] Call Trace:
[ 2.261462][ T1] dump_stack_lvl (lib/dump_stack.c:117) 
[ 2.261462][ T1] dump_stack (lib/dump_stack.c:124) 
[ 2.261462][ T1] print_deadlock_bug (kernel/locking/lockdep.c:3013) 
[ 2.265464][ T1] validate_chain (kernel/locking/lockdep.c:3859) 
[ 2.265464][ T1] __lock_acquire (kernel/locking/lockdep.c:5137 (discriminator 1)) 
[ 2.265464][ T1] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 2.265464][ T1] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756) 
[ 2.265464][ T1] ? alloc_workqueue (kernel/workqueue.c:5152 kernel/workqueue.c:5730) 
[ 2.269463][ T1] ? __might_sleep (kernel/sched/core.c:10126) 
[ 2.269463][ T1] ? is_dynamic_key (include/linux/rcupdate.h:779 kernel/locking/lockdep.c:1257) 
[ 2.269463][ T1] cpus_read_lock (include/linux/percpu-rwsem.h:53 kernel/cpu.c:488) 
[ 2.269463][ T1] ? alloc_workqueue (kernel/workqueue.c:5152 kernel/workqueue.c:5730) 
[ 2.273463][ T1] alloc_workqueue (kernel/workqueue.c:5152 kernel/workqueue.c:5730) 
[ 2.273463][ T1] padata_alloc (kernel/padata.c:1007 (discriminator 1)) 
[ 2.273463][ T1] ? nhpoly1305_mod_init (crypto/pcrypt.c:345) 
[ 2.273463][ T1] pcrypt_init_padata (crypto/pcrypt.c:327 (discriminator 1)) 
[ 2.277463][ T1] ? nhpoly1305_mod_init (crypto/pcrypt.c:345) 
[ 2.277463][ T1] pcrypt_init (crypto/pcrypt.c:353) 
[ 2.277463][ T1] ? nhpoly1305_mod_init (crypto/pcrypt.c:345) 
[ 2.277463][ T1] do_one_initcall (init/main.c:1267) 
[ 2.281464][ T1] ? next_arg (lib/cmdline.c:274) 
[ 2.281464][ T1] do_initcalls (init/main.c:1328 (discriminator 1) init/main.c:1345 (discriminator 1)) 
[ 2.281464][ T1] ? rdinit_setup (init/main.c:1313) 
[ 2.281464][ T1] kernel_init_freeable (init/main.c:1364) 
[ 2.285464][ T1] ? kernel_init (init/main.c:1469) 
[ 2.285464][ T1] ? rest_init (init/main.c:1459) 
[ 2.285464][ T1] kernel_init (init/main.c:1469) 
[ 2.285464][ T1] ? schedule_tail (kernel/sched/core.c:5346) 
[ 2.285464][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 2.289466][ T1] ? rest_init (init/main.c:1459) 
[ 2.289466][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 2.289466][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240708/202407081521.83b627c1-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


