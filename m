Return-Path: <linux-kernel+bounces-312529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE78C9697C9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BE128941C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406F41D86DC;
	Tue,  3 Sep 2024 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNkIaUWp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8151D86DF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353174; cv=fail; b=JR/wZ72KXVwR4hSfk0IeEpmWwG9awv1yfUIydsjS0BToljrtKrEKsfLusl8vSJz4u73PzIHUxYyrydkGcOq0aRdjuO0HyCMVC9+zOt0loToVWm8iM380wD8Sdr84f2shBmzVSDcK1O/CIimE1UEEosXYBOQN1Tend4iTHZduALI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353174; c=relaxed/simple;
	bh=Ldfg91PT7aQWj8fI9OlzxGVmq7+aGUmfDGb5J+42ORo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SPfvq5Q3ZlNk3gvWPnG9f9MEyyWshNTjX5X7bb8vaYYGH7LISRur9YpFSoQU4jq8EGKqRrIEjlNxGRPGxoztftyVfnuK0GrBTdUZjzfaKLYipy4QT7tNWIbY+rP+kI3liFQEObDlre3V6vIn7mAmtE/p0YFzfZmwGz+im5C47QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNkIaUWp; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725353172; x=1756889172;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Ldfg91PT7aQWj8fI9OlzxGVmq7+aGUmfDGb5J+42ORo=;
  b=gNkIaUWpP1hLJkWNG+UT5l2mzd1DM5NWoX7AvUqbHCe3E7OzE53cOYM5
   Q06hHVeJ0a5TpD2AaHgYnJ+g1Lwhs165B179uDfvWEjtDGME7BljJ+eqk
   luLg4tm/rYdf3QxtUT2BN3slxJw9/eOiWTUYeFpNvk46UmpQDy6D4tmT6
   5hM74ghyFMqnZIdnz0kgGp0scILkPdOwEmDnmin9VvmrJ/bmszKfBszx3
   sujSAEcR5+wFpmF1+rudJuF95M3igoVr2H/uM2Ycj20nYYPvxXuF5IVJM
   q+EJa4WpW2tkLkQjTflbBgXI5uUW4IYqefvC3Gx974zW3t8LzFG3ILGmU
   Q==;
X-CSE-ConnectionGUID: eVozoxMSSkyTTKf1/wzFMg==
X-CSE-MsgGUID: f+FE9/+iSoegG/X/2e9+TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="26852024"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="26852024"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 01:46:11 -0700
X-CSE-ConnectionGUID: JMOKlzKEQJSkhraxt2RbnQ==
X-CSE-MsgGUID: ZhKvoIEGT52fpcFNzznVow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="95560666"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 01:46:11 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 01:46:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 01:46:10 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 01:46:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mt/QQft8TQU7HH0UStUswpW319xmRIIyQaOHGMC7VvF85vAwLRPbwlbMi84BB72MIhsVJRFGUTkFbO+wTOvPCFzGgLBIbn7fiMsyf2fJWHoZw6nBuI5006kz9xevo5CvjwEoeBNyyoFs6nPjGM+PUoJtbnuJzeYH7mxUDawj7QbH5rEM7sw3WqrJpL1FalcJIrsX8PaATiJm3vyxI0LEa0NC7tPOzl1zoqc5ansZLs4mPauF5cLZN6Y9uZkixZMfMgodSBjuy5sOJQj+jkPeLdRf9KcBG1YpF1HwLo1HjZ2ifEd2a1DIGjHgJX3apeLqOc16JwPf1Eiz7eTj7/2uMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATRxfWejHTwnCNNmu3akeKQnz4UJrKyBVSh0nVcGC8Q=;
 b=Cr4zVUpaxLB33DkLz0R8Ic+pkUbU48CpNBdd2KKdA1q3ZCzb4KSXrO93IXSaz6HK88oeJ2quJ/++pskqxAET928+U4jNVuGAT9qwp1dyG07c2UhfEwl1a6yBbY5ZCNLMiue8FAvoJPpmft/BtvC//68GClzTKoFBmJsNCltS+Hh8UqmB1SwiRMwblmVxJZSQNSgjHwtVD0zn5O5PU6wLk7aXmz/54uOCgQl/yzI+6HO01njaCiopuCZ06awwtu+wX2MwOsFWOjk6qWne/bgjLvPUogw8YCe1vWXnOMO3SfxQCe+XFO8xgMSpcXfrvETsrxMjPjoxOQYtdaUGlcy1tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BN9PR11MB5273.namprd11.prod.outlook.com (2603:10b6:408:132::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 08:46:07 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7918.020; Tue, 3 Sep 2024
 08:46:07 +0000
Date: Tue, 3 Sep 2024 16:45:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Dev Jain <dev.jain@arm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<willy@infradead.org>, <kirill.shutemov@linux.intel.com>,
	<ryan.roberts@arm.com>, <anshuman.khandual@arm.com>,
	<catalin.marinas@arm.com>, <cl@gentwo.org>, <vbabka@suse.cz>,
	<mhocko@suse.com>, <apopple@nvidia.com>, <dave.hansen@linux.intel.com>,
	<will@kernel.org>, <baohua@kernel.org>, <jack@suse.cz>,
	<mark.rutland@arm.com>, <hughd@google.com>, <aneesh.kumar@kernel.org>,
	<yang@os.amperecomputing.com>, <peterx@redhat.com>, <ioworker0@gmail.com>,
	<jglisse@google.com>, <linux-arm-kernel@lists.infradead.org>, Dev Jain
	<dev.jain@arm.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH 2/2] mm: Allocate THP on hugezeropage wp-fault
Message-ID: <202409031602.14479174-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240830084117.4079805-3-dev.jain@arm.com>
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BN9PR11MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: fd404cf6-e118-48de-7999-08dccbf4d9f0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ss3buimVgYqvQpcFqzxlJcaNmBFX3xP7EyBkxJVrg0XxwR+1tvgm0pVL0dRO?=
 =?us-ascii?Q?8RhxyBRfkiLG+Y53uDrHwXCGDmpaDPhmTW5bTXPIkRVK/04xszKacgNuc58S?=
 =?us-ascii?Q?wTR2DdPEvAUxgsR+5SEIuIo13GBiXUQucDarXfMeY2M8/fRPVh6bBY8ZHvXB?=
 =?us-ascii?Q?wNtXpRnlAwEf409GAVn/cePcfFW3bW5XdpgP+s2/WESrn9Pqe+7wVhB4F56J?=
 =?us-ascii?Q?+hqDzQySUUotxpBy7j2gNDASJplwQnmP3DV8QZyHYefSslT+DBa3fwlBJ6Ri?=
 =?us-ascii?Q?bAiQ80fc3197BakE4VgeUee8jzkFvhWMP48dWlNe1P1C7Dgs11IsLLnEt8Hx?=
 =?us-ascii?Q?AktGZAb8f+GUgdPu0m9jXE6zF2V/VkNP+miLB5plRPWOYfxEoCaQohRCy/a+?=
 =?us-ascii?Q?1/ARkTVPz+i3m5cjJHHEzIdWi8PXk61nHk+N4RuNiXSwfucZK9lbHz2iyP/A?=
 =?us-ascii?Q?HMeRuAXcbh4JiT7thU+Fc41htxYtA1jPSb7daPcm1oauRcU4o08DSR2s4ysU?=
 =?us-ascii?Q?6mvb0viAi00OEU2pTt/Lq4yIvKmSKire/HuwbEDvh1Hu2vGZOiuYjtW9T3F/?=
 =?us-ascii?Q?L+BKpDZGennyLYndkwc9YgnYLTuOKsD5/K3DV7bvsApJUO5tqLgaCskCJjlQ?=
 =?us-ascii?Q?nqoTchi7x1JZDt50StkbZ/HakV0K7j2NuOlsabH1mMAzXumUDrpEMGBvw5gb?=
 =?us-ascii?Q?nLbAP1tIm6U2BJJgNNXqY3hRFDmvQ+rkK2kGuxtpLsIHqsImv5Ex3t1ExVn0?=
 =?us-ascii?Q?sNrZp5jeneR2fNuKHbNsN+q9LITH2/cvx2j45+3NSewYN9mqJ5mMHuRL+VZN?=
 =?us-ascii?Q?hpqdU1399cfbhYgS16co+T+wzaAwnABT9gb4pvVuWumiCDwRwWNMrSEgpXfV?=
 =?us-ascii?Q?XWyAT3tZiUYsHAdqVdAFfk3klEP7UOj63HzFfhLMzXCi56L+405TTKaaDE25?=
 =?us-ascii?Q?U578FXF3lM4NJIbR8njCAQcPrIF7wuKQj26rE4926djLsw/03d0pDct4gLiZ?=
 =?us-ascii?Q?v/XuaiAAI25OBg9OGcy/dFpe9dWbQaRZpHzCF529QKVHjUkg9Mvvi+tr0P32?=
 =?us-ascii?Q?XSIxeYhyy1dBrK8vaq26ltcF2BDGF9ySm4JioIfT2Jj65flPrpxSIpdxHyo/?=
 =?us-ascii?Q?Swfbh5NtGdKUawMys7jk9fC/GbpmpNWuFdpoKJRWt0JlfEcJ+UKMhHoXikrb?=
 =?us-ascii?Q?GUUQTKhPu9tkl1zspVgADxGE/gh2CK7PW7vohnsUStYo0NihRScdhRzpZ15J?=
 =?us-ascii?Q?BF+HppFCf/sEab/C17rwutH6CNCOfl0GgNmORvzp8igF8B70o/tCWqONMuQi?=
 =?us-ascii?Q?eaw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cx9BIicrx1D4a0D4s8+20P6UhGf1BXrds7GFsOriCgtl+Jw/TeoiZjbiqhK0?=
 =?us-ascii?Q?bmMncNFj3sUrrlf4MkQoPFMLXWjROf6AbkwzyuYptr6ySxArM8ByWTtDHE2o?=
 =?us-ascii?Q?eJO012vuvBP+8qDVnnB2V8qOFmowQ/2ZKE9seRz94MUVrRoH008kP4C3dXue?=
 =?us-ascii?Q?vV23geKQiofmmGJQR4wtqyPZMax2gYpQhp+zOTSTlroD+kqKXH11zv0XlPnv?=
 =?us-ascii?Q?z+YQc7UhV84wKT4CYu+ZPfbbMXgbW0kP7agRtun7u1fqUW2+OrGFBjEio+5i?=
 =?us-ascii?Q?Ro3Y/SIJ6TBBRJKq2Ig5MCLDhS8DLQf5P5vB0ztkPzmM7GdWTXriBk/Lnj45?=
 =?us-ascii?Q?NdmSe3a1v9DB9It4f/LxMAxtQmBI1yfGcZ1X4+c9/Ks+LcHUMXFJK3HVWCxi?=
 =?us-ascii?Q?KpUIV7WeRilmtAox3vnp7w8xxCPM8BuJKVhC5IcOLGHA0bilRiZL9t8wfWHT?=
 =?us-ascii?Q?RjYxVPb6tgfS2OwRU3mDKq8pTx3XaCDnTWI1yPZF/YvotLeAjA5iwjjO8p8Z?=
 =?us-ascii?Q?zA6kDVMIvs3m9VQm9CKIOxiAHJBIbY9z+ljwDb+ggdXTU90UoiAaie6L91fC?=
 =?us-ascii?Q?Vs61b5GxB6V5DuRIxBKOyS70X+RxuGNMUejP4UfvOI5Ld6fAWsQcxbOL1UPE?=
 =?us-ascii?Q?ZDY8iABRyfojQ9VkvsG0mXttRCof/2J7v4aW8foF+fQPgYNTjH/oqXVGbrp+?=
 =?us-ascii?Q?rFtdKEWY5C14a5J/gxJrCw4cXEND/0/Fsf7/88hvL7W1ZtmU2ZY9ehRXgxEX?=
 =?us-ascii?Q?7pZ6ur8oVBaf91VYu4DXC0vct93q4DhQ769uUExCUGXAQmieDfSGBlez60bv?=
 =?us-ascii?Q?erdCg/3rh/koshT1lhhL7ohAyBCFLXZ0VgKg0YRQId2+BY3jOWU6l68bg83R?=
 =?us-ascii?Q?qGJE0UsPdzrh0ISBzmwSFf7bYlP5mWwiCTzAd+K8GObEoWa0/6g1YuasHqaQ?=
 =?us-ascii?Q?Uyfdum7d7ufV099ffy7BhXtZnGB4caebhfMTIT6SYxQjwhMzAz9KkAZbVD3M?=
 =?us-ascii?Q?OTuYyNaxalfbgHzZD8nXZe3Hh2lLwXWkrzQ5xXTUlNGEKoOVtDkXqLeJO2Xj?=
 =?us-ascii?Q?H0fCsDYFZgaqvIyatubN/CXwcHtFoEvm1QNWXe2yvzDJNnhkFRRL+UKv6mo3?=
 =?us-ascii?Q?o7BAdwoTz9Q9pYIkqVaFj9VbyPzpBFYRd/j7bxSSfXAVEEkWD9LCxbkZqh16?=
 =?us-ascii?Q?rJ0FWpdWHvv5XypbSLmSFDGz1uOEtORuRFkqWeRSusnEwTpf+BvPHYfWQBvh?=
 =?us-ascii?Q?ZKyg6JUDKyn565K8dbkBvoK1fj9Gyz6tCq/AwKNL+8aKfgiFnlqlhbCE2lwa?=
 =?us-ascii?Q?Z9b+LH41W22ZJmUjXhLk1WgUaTVYD7gnUSXHKeSgwFgGMp5k/vJPsDReASUI?=
 =?us-ascii?Q?jk9h0ubMHRusSXaZb6KnrROECaPH4Okh5kqruGG2lRGmmH/hgnvyXtskHjmz?=
 =?us-ascii?Q?djG012q6c1JYE06ZaoePo9gfo20qSM9IDiFkxe7mrSEFzTHGpfu/lDR+aJ5f?=
 =?us-ascii?Q?HAYl1xHZzU6VlDdGjUjtEDeVmvIOGMZ19JTwE4vraeXOoxxYRU9B/VDAIqMk?=
 =?us-ascii?Q?BWhGT51WPFEavhU0beiRRtjTDjxW5BTepli30vyUQpZJORjI+7nR0TY4jTxt?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd404cf6-e118-48de-7999-08dccbf4d9f0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 08:46:07.0181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMOMOI/7pvJOEjfTz3ByjDFndDyAZBCZJHQhpYY8FYu21YiWga2TBLKsB3tQstN9jnoAxVSCdbQJY4+W65kmfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5273
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_mm/memory.c" on:

commit: c636ba74f021bfe8d72845f9e53ee2b8ea16f5f8 ("[PATCH 2/2] mm: Allocate THP on hugezeropage wp-fault")
url: https://github.com/intel-lab-lkp/linux/commits/Dev-Jain/mm-Abstract-THP-allocation/20240830-164300
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20240830084117.4079805-3-dev.jain@arm.com/
patch subject: [PATCH 2/2] mm: Allocate THP on hugezeropage wp-fault

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 600s



compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409031602.14479174-lkp@intel.com


[  189.202955][T15284] BUG: sleeping function called from invalid context at mm/memory.c:6690
[  189.203611][T15284] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 15284, name: trinity-c6
[  189.204103][T15284] preempt_count: 1, expected: 0
[  189.204364][T15284] RCU nest depth: 0, expected: 0
[  189.204630][T15284] 2 locks held by trinity-c6/15284:
[189.204909][T15284] #0: ffff888164fc27b0 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:261 include/linux/jump_label.h:273 include/linux/mmap_lock.h:35 include/linux/mmap_lock.h:164 mm/memory.c:6067 mm/memory.c:6127) 
[189.205536][T15284] #1: ffff888160945c48 (ptlock_ptr(ptdesc)){+.+.}-{2:2}, at: do_huge_pmd_wp_page (mm/huge_memory.c:1816 mm/huge_memory.c:1838) 
[  189.206099][T15284] CPU: 1 UID: 65534 PID: 15284 Comm: trinity-c6 Not tainted 6.11.0-rc4-00551-gc636ba74f021 #1
[  189.206657][T15284] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  189.207205][T15284] Call Trace:
[  189.207389][T15284]  <TASK>
[189.207552][T15284] dump_stack_lvl (lib/dump_stack.c:122) 
[189.207803][T15284] __might_resched (kernel/sched/core.c:8462) 
[189.208106][T15284] ? __pfx___might_resched (kernel/sched/core.c:8416) 
[189.208397][T15284] folio_zero_user (include/linux/kernel.h:73 mm/memory.c:6690 mm/memory.c:6767) 
[189.208657][T15284] thp_fault_alloc (include/linux/page-flags.h:785 (discriminator 2) mm/huge_memory.c:1156 (discriminator 2)) 
[189.208914][T15284] do_huge_pmd_wp_page (mm/huge_memory.c:1792 mm/huge_memory.c:1818 mm/huge_memory.c:1838) 
[189.209197][T15284] ? __lock_release+0x3fe/0x860 
[189.209494][T15284] ? __pfx_do_huge_pmd_wp_page (mm/huge_memory.c:1826) 
[189.209802][T15284] __handle_mm_fault (mm/memory.c:5614 mm/memory.c:5852) 
[189.210072][T15284] ? mt_find (lib/maple_tree.c:6961) 
[189.210303][T15284] ? __pfx___handle_mm_fault (mm/memory.c:5771) 
[189.210595][T15284] ? __pfx_mt_find (lib/maple_tree.c:6927) 
[189.210875][T15284] handle_mm_fault (mm/memory.c:6042) 
[189.211134][T15284] ? __pfx_handle_mm_fault (mm/memory.c:5997) 
[189.211424][T15284] ? down_read_trylock (kernel/locking/rwsem.c:1568) 
[189.211701][T15284] ? lock_mm_and_find_vma (mm/memory.c:6130) 
[189.211997][T15284] do_user_addr_fault (arch/x86/mm/fault.c:1391) 
[189.212283][T15284] exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
[189.212539][T15284] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[189.212811][T15284] RIP: 0010:__put_user_4 (arch/x86/lib/putuser.S:88) 
[ 189.213091][T15284] Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 cb 48 c1 fb 3f 48 09 d9 0f 1f 00 <89> 01 31 c9 0f 1f 00 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90
All code
========
   0:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   7:	00 
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	f3 0f 1e fa          	endbr64
  1d:	48 89 cb             	mov    %rcx,%rbx
  20:	48 c1 fb 3f          	sar    $0x3f,%rbx
  24:	48 09 d9             	or     %rbx,%rcx
  27:	0f 1f 00             	nopl   (%rax)
  2a:*	89 01                	mov    %eax,(%rcx)		<-- trapping instruction
  2c:	31 c9                	xor    %ecx,%ecx
  2e:	0f 1f 00             	nopl   (%rax)
  31:	c3                   	ret
  32:	cc                   	int3
  33:	cc                   	int3
  34:	cc                   	int3
  35:	cc                   	int3
  36:	0f 1f 00             	nopl   (%rax)
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	89 01                	mov    %eax,(%rcx)
   2:	31 c9                	xor    %ecx,%ecx
   4:	0f 1f 00             	nopl   (%rax)
   7:	c3                   	ret
   8:	cc                   	int3
   9:	cc                   	int3
   a:	cc                   	int3
   b:	cc                   	int3
   c:	0f 1f 00             	nopl   (%rax)
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
[  189.214257][T15284] RSP: 0000:ffff88812fc0fd70 EFLAGS: 00010206
[  189.214726][T15284] RAX: 0000000020080522 RBX: 0000000000000000 RCX: 00000000ff7fffff
[  189.215167][T15284] RDX: 1ffff1102bfd712e RSI: 1ffff11075e09456 RDI: ffff88815feb8970
[  189.215605][T15284] RBP: 00000000ff7fffff R08: ffff88815feb8978 R09: fffffbfff50eecad
[  189.216059][T15284] R10: ffffffffa877656f R11: 0000000000000000 R12: 1ffff11025f81faf
[  189.216637][T15284] R13: ffff88812fc0fe30 R14: 00000000000000b9 R15: 0000000000000000
[189.217074][T15284] cap_validate_magic (kernel/capability.c:94) 
[189.217349][T15284] ? __pfx_cap_validate_magic (kernel/capability.c:76) 
[189.217654][T15284] __do_sys_capset (kernel/capability.c:230) 
[189.217925][T15284] ? __pfx___do_sys_capset (kernel/capability.c:221) 
[189.218226][T15284] do_int80_emulation (arch/x86/entry/common.c:165 arch/x86/entry/common.c:253) 
[189.218497][T15284] asm_int80_emulation (arch/x86/include/asm/idtentry.h:626) 
[  189.218871][T15284] RIP: 0023:0xf7f30092
[ 189.219200][T15284] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240903/202409031602.14479174-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


