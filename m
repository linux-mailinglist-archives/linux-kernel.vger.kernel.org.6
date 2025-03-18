Return-Path: <linux-kernel+bounces-565287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 173EEA66531
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FBDE7A8D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EE2140E30;
	Tue, 18 Mar 2025 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ML1hi8nC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F198248C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261743; cv=fail; b=WFtCkoTOPFpl7OdS2G6w+7nDoX8OZueDXJx8wBG7tHJ52QfLTz9LKimFwBe3wspaYw7fRfIu8fsSzh5HI5mJBlBdAWwgU7mEllStD7qqWuObaceahXxgEBQO4Kq+MteBhOOLW6NenKmGRaXXTJRihGjJGdSIVoRLIsR8lBbfqXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261743; c=relaxed/simple;
	bh=BbZ4f1WoB2n7Pa+suWoUr7g35uhmeYMJGhac2rFxJVw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YLG1BimsNM/gWiMsvum/kvpVDpxoY+jUDepAzPZRT3YTLDe7R5sL717iPo3VWViEtmlVNK2lrP57zAOb+dM74TuRv/vCcc/Eqk+VWW6T//HNAbJd43ei6lgzY1YJnUdG+KuwzzfT+5veuk0ykM+htFleTcmXwnexlNCCsUJ4QFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ML1hi8nC; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742261742; x=1773797742;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BbZ4f1WoB2n7Pa+suWoUr7g35uhmeYMJGhac2rFxJVw=;
  b=ML1hi8nC8quZf00iJ1pMUsnuCdE64gcYhNWZVVT7icjUqbap+La7LWPp
   V4uVGW21V9UXAYGcGxpzWlntuKlq31IZ8NCFYrsTZ8SjXYg2Xhdds4P/5
   5i5VIUnsk576ZxQ0dXfIRqg9rcshPFx2lT4OnYVNQe+czqKrX3QZzvFM4
   HSeTIPNHh1TVZRSTYCjOvDaLehhAYjSlBglT74b0wAWOA+X3ydMJ5x/ko
   h5R2nCsVDvZ9UIJm4pdk8ulcXmwW2hLxbSRkKahmzaL6g/tGSH9sHeXyP
   gfz1o4wy4SQKXQN78SLwyz0pJw5PtzXfEI4kMHhTfU87CJBzVbSoQVg/4
   A==;
X-CSE-ConnectionGUID: auDQJTIYS+mHP5U4E2L14A==
X-CSE-MsgGUID: pG7FJxngT8mHUmvDQCxUlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="46146684"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="46146684"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 18:35:41 -0700
X-CSE-ConnectionGUID: x+uGKV0yQayttYkZgHCMgg==
X-CSE-MsgGUID: HuPrEeIYTsSFwrE8W6IgQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="126301229"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2025 18:35:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Mar 2025 18:35:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 18:35:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 18:35:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2knpfo3AlhPIn+L81XJYNOEwshKxKnhCMEB6BIzo1t1KUsXjt9oRYtxC++eLYMFItKIdyS9g5UDTVn2G+6s7Qm+n9GtqtVhNlZzsh5uGkcq1afMk7D0WGLNj7ie9clrJFoC6LhnBD6GEbKYoAR4DzcZpL4HR4xsfw9TkhJVOCtAsQD/1/ou5PHaswKcLusFaHQwlo0QhuBEzGKz7yv5KzpBK7cj5eHwvRBkEHOxSA+sEBCDC4smmt9/QMbuXPADa8d3r6NeROFIqsJTADS0VbJFg8P0fMmb1wDWZ1XrQXl70SDwhHdTfINKGPfvD/If807w2rQ5VKQhXRRFnfqV/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roT09gO+u9zkIG82R8/3wpSk6CzuHaZnZblS+dOjd4g=;
 b=EbxhU/9fvB5Ux4AwsPv8CWEoEDdU1wlAoWrrygAt6QFjEJbBbKMpJfraIv9Mt7Px1jrPorQcso1ZdLrwMQvFU76vj8jGGotQR8tYtt+Jh/mE6au1/dYV95P+rnhLrl+uecW34Xo02lUFly6xSXb9spqOlYZ9Ihg25qc9yaI/NbooafgnOJixTqEiIJn4iUr2g4nDrbZWrQtvEViKMiyR8zVKVWNQpPmVhosSrnzIjmsbplqn0QlwwNMC2F+FanjYxhymiFc0uLu5d/OpAZbjQ+vSKjTxIcE7ptS112YkYM7dW1gHs67LR6wh4WMkjYCGfUGDVCHtZbxNIp+4Im6ULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7564.namprd11.prod.outlook.com (2603:10b6:510:288::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 01:35:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 01:35:37 +0000
Date: Mon, 17 Mar 2025 18:35:35 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Alexey Gladkov <legion@kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>, Alexey Gladkov
	<alexey.gladkov@intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel
	<jroedel@suse.de>, Juergen Gross <jgross@suse.com>, <Larry.Dewey@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC PATCH v1 1/3] x86/tdx: Make TDX metadata available via SYSFS
Message-ID: <67d8cde71e75b_201f0294a@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1741952958.git.legion@kernel.org>
 <ddbf49381eb5d1779e218e022ffc144db5da003e.1741952958.git.legion@kernel.org>
 <67d4bee77313a_12e31294c7@dwillia2-xfh.jf.intel.com.notmuch>
 <nvnjhx235xbsrnq3t6zbkgogsdizbigrlgqyx6muyj6k2g34gq@zzn6bqvoha45>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <nvnjhx235xbsrnq3t6zbkgogsdizbigrlgqyx6muyj6k2g34gq@zzn6bqvoha45>
X-ClientProxiedBy: MW4PR04CA0140.namprd04.prod.outlook.com
 (2603:10b6:303:84::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 7936f333-5a99-40e8-411e-08dd65bd2f53
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tO9cmCkVfSvz7TRozGvAbnT6C3KxEeL7qPxuGz9tKnh1PW6kmp7aFrpmDZ8p?=
 =?us-ascii?Q?QIN++ahlG+J8fuu9NUwaNjdZex2YtJyH9/Fu56YO3cui9eZEqJtopPYEhTIf?=
 =?us-ascii?Q?rhfEx6r/WC19OU2BSjunlxety9Mb142MBMeZ8LMI1P1JzLScjqL9jymdtlEP?=
 =?us-ascii?Q?OOo9o+lT3HAoYdzKRn2o/IPNpKLjrw2iORDKmkwfAB7VGKNqllkrUf3zdm/N?=
 =?us-ascii?Q?witmflzhgDwAnFA2d5PFSgdxIH07z+RTtAYW0aHuUrb5fQb7GR6fH/oqcloN?=
 =?us-ascii?Q?vlHG7sAnUD0KHHYXkZ/dzL/MalHeODr4b2M2vcCmZOG5/tIwt1VIi1bKqXHY?=
 =?us-ascii?Q?u4YgDAmSK+km+lecDOs47RcYd5qLUZJnD1zYxhdmpP9aFfyrMMaY0YHZXcgc?=
 =?us-ascii?Q?G5t+4DuD8PCWLtyRE2bk89A+C3iTekqoylB5MBS+cJuW3JYjHpnpGSmH3WrQ?=
 =?us-ascii?Q?33IG780BdGF4SKZvAENbMhEFnmJIRmYyWzfMQbVhkOL1LZZqHct+BBsfC3mj?=
 =?us-ascii?Q?aQ5lrSWsBkRNjyvbEiPSdok/SkbceyI8uAtH1x2+5QbZ9YPxw6OSfrJsmwor?=
 =?us-ascii?Q?jMzMzotsB8DtjZ8ULo+cVNSCfB5vBCj8lANtmerdS9E5walHl+dn4VSWJSDR?=
 =?us-ascii?Q?jG/AwG6S1EWIa+JcrQ/fbZQqITfrtROW9DSj+ZCc6OX6TP8sDS+Y9ep1ooVU?=
 =?us-ascii?Q?47dAvaIgZzyTlBwmfLLcvskMaHbTnK9fyz78+P4i06/KaFn/UxOKR6fnCCde?=
 =?us-ascii?Q?Lh4kgG9JDco9IU62Jxc1KdUWfQ+4zSubIIbZIe46TqlwrsniaIeLVfsRV3VX?=
 =?us-ascii?Q?lKRaGLB0fOz0ogTgoc8LSnTiUFO5/MKUOnasqQVV+lgIt9Uxtj+hvbj7OGKR?=
 =?us-ascii?Q?26SxEg2aMwad/RyLGc8hKIV14pLLNAUEmMmLHLEC9X+XtegVH09U9BbCNeCM?=
 =?us-ascii?Q?Nmhv8GkGzrRCOPyB3ryRpbbDnLrH7oKcXwRs9lRHp5rfv8IZS+GqwWtShUkb?=
 =?us-ascii?Q?MSlHBk9B85cHfOHYoBGc3quOzU8e4OCKaZLH3qT/HGB0N3iUlp029EwVLlPT?=
 =?us-ascii?Q?HCRApLXmMcpnbQKYy0PzUJI2VGcS2H+bP2ESYVgsE4eTrJQ8x+XIAOGXfxqP?=
 =?us-ascii?Q?Bnt0SOX/+SdQc4pZcd/WPhwoQJy4GeXMZGJ9nY9SJIcXQQKCRL/G7lj0sR7O?=
 =?us-ascii?Q?7Mz7WldrspAECNNeKZcLjn3ZavY0eLNQEI0IBKBKaHdpOqzbhICckWwWN4mV?=
 =?us-ascii?Q?tYYyg68uSOdfXFeikiQ8uxxnV4hrJjo3e/81iJB69gWY95Ee1xlE/ka1LDi3?=
 =?us-ascii?Q?zZl3OHYsjaD1lWyFelnVj89ObpbI7/0s4lPAEelqnr8Xol3Wz4Ky4/ftT9mf?=
 =?us-ascii?Q?9XntcIqQwcphABKTy2g1YaPqKl2oDR0r6u2sP4nfbflmG4Oc1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SKRIOKIZYQ0DUvevlrK8j5+jS/bfX8dXduBqsZtzt6dG9/U52teLo4+qRPwt?=
 =?us-ascii?Q?iXFIS9OXbXJXcUFRLXWUe7TBdIK9IL9s8hfspn3Ev3UBue9AVpfuUz/6qI7t?=
 =?us-ascii?Q?gO4JuAWeOwusaC7LeD1ixDCuBLG46LILHByG7YPOd6L2MmNIev876+xH21Fo?=
 =?us-ascii?Q?pXTrzB/Jiywg6YgBgnUVYeiMtqFiyT6QWdU/YR2Il+q7H/NHEE4u9mlUXBsq?=
 =?us-ascii?Q?xVizqg65+ZKRp1iBEFVtRp2lfaGQ9SRTsiJ6UkJ+1zSEGmgl/15DPGY1Zx10?=
 =?us-ascii?Q?ByPAn0iJkDT6Fo16E54GcdYE3uiaqiXb4RmNtICGrWEHWUfV+u3fP7NS50tE?=
 =?us-ascii?Q?Hdw/0p7GY4Qo7cF/saphqqlI1Rk/5lVDV8XJN6AZnIz5jGO6SDZUsjYqt4CF?=
 =?us-ascii?Q?H3w3b7H7y0IlKEFIuQjZTWwBNbNNb9BR4KrriuYcKiMIOM/zs77AJoXVV9Id?=
 =?us-ascii?Q?gMW0GXTi0+HuPI2Vv7lWHvEt/QxL4EsEVwGxZ3qhohA/6x1RddopnO5Y9k5q?=
 =?us-ascii?Q?z3BUVGi66wSyHb1996rHi6jD9WzZZPBDtt02XSIIxXLHnVfjkGnliKba2C/2?=
 =?us-ascii?Q?O4JpvI5455Y7U0FnjYx+fe7iKgSCPyo7kK9UgkoT4bFOMh0Bt2k0jC9EJjc4?=
 =?us-ascii?Q?U9iiU/WfUXYY7/zYtNA62XIC/x35RXqPIGfltpMO+51gmMacgvvUCFeMloKX?=
 =?us-ascii?Q?NMEJUTr3ITBdHK/lyakMJfMfXFmemaYH0fJeiaPRzbf1+THFgXGj+wwhtQRC?=
 =?us-ascii?Q?sEn+eRtfVZi2QdJJ9qTeo8MHC+LLTGAMTWWZlo1WzElpTTvC35BdtyyXX+Xa?=
 =?us-ascii?Q?NqWUe/A1I8Nzn+goVI3Ntz3+KUwmh5LeyZK6FaUsJhNc9EtvGhcWgwRuwe6i?=
 =?us-ascii?Q?cqUTz3vNteAFLeV7Ngyn8LtX3VkAQF512XUi4SpO1hWdtZJIKVXHrcDZCxBv?=
 =?us-ascii?Q?zsJ3MNAya8FL7R6eN7NPMHCHLZCOK81cRxgQzCAMX/Uy7o5vWAK5FqgzsjmH?=
 =?us-ascii?Q?8/7OdBWFp2w4j6NbSgiqA7W9yII/ihoOfwmXuyfrIi1eDxaVizro9F41UWel?=
 =?us-ascii?Q?SmrlUkmgr7FL0C3Xv5+VnTMswHNvXw/KlORNgG/kmJSWdAV0pD4LRTAMKhds?=
 =?us-ascii?Q?E9+sxOxaTY5a4wmrI8pEOLT5ck/14+U09U34eLkUN5/Ez5bLJMiPiQ9NFqOH?=
 =?us-ascii?Q?z/cJawaJWL4dMyrngNP0QIgoTAycxlaAqlosUYo7OtGgXz2Pdp0Fp9zGpsV4?=
 =?us-ascii?Q?qUQmGRmYduQJwTmnSk1JiEoMfApr06j6ozr9Pc41pZAucadjkurIL498LfXX?=
 =?us-ascii?Q?HcF+Ai821khEvBxRBRf5xt6mDZjfC5ofxSH6EOqPjad0u0mND0goSUf50Mrx?=
 =?us-ascii?Q?kI1MFIbPZzbvlO99NZ0ca90VUe50EVGpnMpcAXQaUNYuq7pWsFosu6+2iCwZ?=
 =?us-ascii?Q?OM5ljd0/JnTbs7MmB7mZmk6TsV7osvUzElgBSdWmWpbv96BvGxRpZ4kj06R4?=
 =?us-ascii?Q?upq1Xh6d8J5kW6sz/UGI8NIoVedWZmJUUjtMfNdd0OVMyZhTv6K7WXq9KOVA?=
 =?us-ascii?Q?BMK8Vnb6ekOFQUR/aNTY688eTW0/Nfl4wKsh1m2m7dVNuQ2ZD+3Pp8Meeso6?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7936f333-5a99-40e8-411e-08dd65bd2f53
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 01:35:37.5110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkrZy/2WEsfgCTBi/regO+9Q8lPzM7naDT2tpI2ptO4Brkw5Dx00HfImN5Z2q8gAJNIzki6xFGv83X3QyM7uipFkAvk5Z9AMaz7ngWWh7SQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7564
X-OriginatorOrg: intel.com

Kirill A . Shutemov wrote:
> On Fri, Mar 14, 2025 at 04:42:31PM -0700, Dan Williams wrote:
> > Alexey Gladkov wrote:
> > > From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> > > 
> > > Expose the TDX module information to userspace. The version information
> > > is valuable for debugging, as knowing the exact module version can help
> > > reproduce TDX-related issues.
> > > 
> > > Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
> > > ---
> > >  arch/x86/Kconfig                  |  1 +
> > >  arch/x86/include/asm/shared/tdx.h |  2 +
> > >  arch/x86/include/asm/tdx.h        | 12 +++++
> > >  arch/x86/virt/vmx/tdx/tdx.c       | 74 +++++++++++++++++++++++++++++++
> > >  4 files changed, 89 insertions(+)
> > > 
[..]
> > > +__init static int tdh_sysfs_init(void)
> > > +{
> > > +	struct kobject *tdx_kobj;
> > > +	int ret;
> > > +
> > > +	if (!hypervisor_kobj)
> > > +		return -ENOMEM;
> > > +
> > > +	tdx_kobj = kobject_create_and_add("tdx", hypervisor_kobj);
> > 
> > So this "/sys/hypervisor" proposal is clearly unaware of some other
> > discussions that have been happening around sysfs ABI for TEE Security
> > Managers like the PSP or TDX Module [1]. That PCI/TSM series discusses
> > the motivation for a bus/class + device model, not just raw hand-crafted
> > kobjects.
> > 
> > My other concern for hand-crafted kobjects is that it also destroys the
> > relationship with other existing objects. A /sys/hypervisor/$technology
> > is awkward when ABI like Documentation/ABI/testing/sysfs-driver-ccp
> > already exists.
> > 
> > So, no, I am not on board with this proposal. There are already patches
> > in flight to have TDX create a 'struct device' object that plays a
> > similar role as the PSP device object. For any potential common
> > attributes across vendors the proposal is that be handled via a typical
> > sysfs class device construction that links back to the $technology
> > device. That "tsm" class device is present in the PCI/TSM series [1].
> > 
> > [1]: http://lore.kernel.org/174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com
> 
> Dan, could you elaborate on what is actual proposal? I am not sure I
> understand what 'struct device' can have info on TDX module version be
> attached to it.

Confused, you do not understand that devices can have sysfs attributes?

Documentation/ABI/testing/sysfs-driver-ccp describes a device object and
sysfs attributes for SEV-SNP firmware status.

For TDX, the proposal is to create virtual device to stand in for the
lack of a PCI device that fills the same role as AMD PSP.

With the expectation that all TSM technolgies (SEV-SNP, TDX, CCA, etc)
register a device, udev rules can trigger off a common class device
uevent. That proposal is detailed here [1]:

[1]: http://lore.kernel.org/174107247268.1288555.9365605713564715054.stgit@dwillia2-xfh.jf.intel.com

