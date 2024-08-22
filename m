Return-Path: <linux-kernel+bounces-296402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EB395AA9A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 397B0B22967
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAB510A1C;
	Thu, 22 Aug 2024 01:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ktOYSyXk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A17110A19
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290604; cv=fail; b=cd+nI94/JxPnGnWQ5AUcTLCt28AGJyvVHazbtFtkY9u3kwtqBfIsS+fpZiRzE53msFVs6VkDM+aO/lbiE50j83m4hv+h9x40d/1e20CcTmvHJIEYpNXB9+hvK4ww6Xprr0gq/5eaWU9ZncQ07SqczNuNMGqPYT6e/CzAsjeeygU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290604; c=relaxed/simple;
	bh=QeKQAvrAsLBYH3rxnjsa3T/RfBj7yYRr7FVdTuw/y58=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hdVh+hSml7QN/AL5jcVdVYY1sNKoWilCrYmJ2g4fjJZ1Qn56zoPB/UXrAc4sN6BwcGRw7FnuEixFRF54RrpVDdgXqSANuLpeWC9sY5CsOiujnR+Um3cOCOCnSD/F6fJ/hWshbAD00I6aeCG8vIRkvT7snNcBMeiqu0jFxtfweqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ktOYSyXk; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724290602; x=1755826602;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QeKQAvrAsLBYH3rxnjsa3T/RfBj7yYRr7FVdTuw/y58=;
  b=ktOYSyXk08iFG1dtQCa2LqZqK8E3IUDJzMaNy9AbB4rVNRMBJPlZHkEI
   2yWF91fd3ZmpIv51xqutakbiKngBc+gXPlCfFur0wnKvHErGw7A+Kz1Kb
   HwGhP99tBy0HUgCDAs0oEnS4QzO3hzZkJOjU5rsuNDSme6ZbnwroiXl9j
   DIMCYEY2kh5h1xOiQFyuUiHkmtepycFoAbzpd33gUWG9sUmZAfOTUfs0S
   7/Fr1c18n4LtAwaGOjwsumQIXjto2iiszYzft2e9njF1VIj7Z0tNOqDbg
   4NBSFSo+A/+3JAFvQcEtY9+Zkh3nlBrjxaFeBf02HD3KNymuvBgf1Ni0P
   g==;
X-CSE-ConnectionGUID: 0qJ5IKdGRDytyIWQT/DTzg==
X-CSE-MsgGUID: IzZpETsqTuOMi6NwrOfaUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22816742"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="22816742"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:36:31 -0700
X-CSE-ConnectionGUID: sMID69tETemuMSxhPZ0R2Q==
X-CSE-MsgGUID: O/YTmeakSQW6AaCy7ZZk6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="92023041"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 18:36:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 18:36:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 18:36:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 18:36:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 18:36:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDvpUCP6wI6entzTP4pMPYYGaM53AEucBtTPOwb+4dx5LGYGKFSDDN7aYh9iJSLRI5/qIuShpjPekbFC4SOBeKSR39qNkxs3ddrOPKpI3zxcEWyfHJEtPYt2VZE6uG8DiczLQgxmLJIYy0xt1tZ2NchM/fuekUUEdtzE2emLRRt+5QhxAlCOFP1FoLJMOJKYRGeQzoQxviaWw6pEIWnXew9q+hny+RCWNLmGzNn05+HoYfMUe6YStzn4cMt1kNlmfZlxyhICioB40gPo7dn4XiXjjmTopZNQfDOd2LRTtXdHC5ehvAILHKuiAu5B9Wzprnc5TmjVMhiK0vVxqfMIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4o7fedqF5EqTwTC1ZLduPksoljz1i9jUbhTvIX3jjaA=;
 b=Q+zgQ1NQElTbGwYS8UiN/Lp2b54/BD1hUZAH6O0W+gyGEYQvs46dysPek3s7JSmWgLPRfuJFUo/3RC/ziQley65KnRL77+yn0wDapDa6pUhHcmird29FW6XBtkuIwjUTr1QOkVHTfzILmEdpagT0irYCtLXeEDyWfSz11DojvVifJE4ZLPaCqqnATHQMH9JNLBkxDvwec9sMLKElxUgiXaXl0j6HbOhQEPWI2/1L17cVjyQhcXyaJXLsP/EHfXi0B7iNk8ZbLaZQMOp+SL0oB02bjdbs8ZBd7QfcWh4e4jTZe/0kzFY+xx5uX/L/wRGiugrnALWMGHFm7aChsU1cfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ0PR11MB4976.namprd11.prod.outlook.com (2603:10b6:a03:2d7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Thu, 22 Aug 2024 01:36:28 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 01:36:28 +0000
Date: Thu, 22 Aug 2024 09:36:16 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Mel Gorman <mgorman@techsingularity.net>
CC: Yujie Liu <yujie.liu@intel.com>, Raghavendra K T <raghavendra.kt@amd.com>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Chen Yu <yu.chen.surf@gmail.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>, Xiaoping Zhou <xiaoping.zhou@intel.com>
Subject: Re: [PATCH v2] sched/numa: Fix the vma scan starving issue
Message-ID: <ZsaWEDUHjIqktSz2@chenyu5-mobl2>
References: <20240805082228.4082656-1-yujie.liu@intel.com>
 <5s55bgrmpomlpefmvt4bz7t2myvjnbw6lnvtsnbkdphwfb7zdo@tnm7flx5jidu>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5s55bgrmpomlpefmvt4bz7t2myvjnbw6lnvtsnbkdphwfb7zdo@tnm7flx5jidu>
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ0PR11MB4976:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e12226-a7b6-4694-df1f-08dcc24ad77f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+0CniYK1RZUpb80kbvHEoS/9u13qmmBSB4STXpkV5bNhPTqjcEl+vWgjE4VL?=
 =?us-ascii?Q?OiDAlzYhwp+pq8VaUjQsJgDh9J6Ixbb/hYKU9vP75xKFlBYG+2puYzqeO+NP?=
 =?us-ascii?Q?TPJ9ZmvCftAQKpmOn7IUC3R7Izn6bhPpHtGOFIELrofADnYRyKuAUJVZVEx8?=
 =?us-ascii?Q?U2GGbFu1C+px+tKS0QGkMKtuhXJBdYSkWsYSYSLDlO4SryxQyOwuF2rQFgzV?=
 =?us-ascii?Q?2IdhLSaGX6ubrfizco7ibblrdPGNJf8FuwIAM6Lk1F9LRAU4vjWhqyHg3uDk?=
 =?us-ascii?Q?nbOEZ8MkonXFtEp2ca+oiPTvS+itAUGlBz+pmpvYYFMR5rxZVI5SorFaRNYl?=
 =?us-ascii?Q?X+waNtpdXKCbARff6Ro9Jn17KXSVaq/RwGGw94Y/owhcKYHBVGh7fT5PAvMy?=
 =?us-ascii?Q?uINavB+oLcWsoH+k8IKTizhKE+BqvVLLw0kssRO5oK+0gLN7DHL/Pwvfhe2x?=
 =?us-ascii?Q?KOWseDtfL7A8dhzW30tQS4WJiug0yv9nGnPSVSXDciOojsi1F2vtNJqfzWNO?=
 =?us-ascii?Q?PEvssfGYbzUw0USfoC27waScHHn+pPrRT8SIvtom8XAWUFItShHVMCUp+Auj?=
 =?us-ascii?Q?G9V2bHS9H6ULEpOqQJPe0IdIosDa6IKr2aXBfxqi/Stx2du9/DWQQxXuF/1D?=
 =?us-ascii?Q?t9ncndFS9ZfVCQ+YF9Y3Y2IN2rwj5+GEoYmMhlBIbIPDp3MG/tcBN03f8kGZ?=
 =?us-ascii?Q?xp2FX22JYUaiT38t1PclJkJMwIeULwb1Wfh1uWZcUH2xgirpP26lLqJ0oDgF?=
 =?us-ascii?Q?vSHDuiuSSG/RDgJxqB3PO7eBRHrI1JF1+6uVDTOR6TnLEFh90XS3etN6el8b?=
 =?us-ascii?Q?GIztH0v+p+PaNTzB/VHsoyMEdPvx8UUJWeU6ZjUqU0NifEWmZctvZQxSf5AY?=
 =?us-ascii?Q?mEpSfCx4Y6iel7mxOp4ZsZXZ8TbCWr1RIoHKNi4BTYyNvyhHfOPhbu71zCQa?=
 =?us-ascii?Q?DmI1UglbOBf+fHc+K7LC2nPcTXG8wqupR1Nv1v+GwZJoBBns+28gYeBvqO2O?=
 =?us-ascii?Q?k96N4y686yiF/UOTZuhL+9cRi/fxzO83eJ5gOnI5GPXr3od1H4q73jYBRIXm?=
 =?us-ascii?Q?A07FccX7QqkkAuUL3Ap0vt4pzzPGd5rhVsv1ylrcmnKGV1HBGkLpXvXKM2Gz?=
 =?us-ascii?Q?2qNRdUExE+3CLhl6aP/7yRne1XTyMj+odJOn5rfupA/1GG0A+bVVpfIrIxXD?=
 =?us-ascii?Q?pYlrVfp2fDiUeNgVkNlLyUwNOCpKhGdscM6tCCSUzIAP8XZN7Qfc1WUivTL3?=
 =?us-ascii?Q?2BRiOsiAW6B9xQyBd9n93rYjXchIxe7WGbOaD+dTK5dt6L+WgLVfntlGddPy?=
 =?us-ascii?Q?4HygsyIM9v9hhOvME7X7loj4c93B9OymbWUnZvQU/0mTng=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+oJgquaYoSKUUjbg2sBcd1ANgWUYtd5MaNvOs24itc4kYqMg+/g10BLgwqWz?=
 =?us-ascii?Q?CLcYtYiuM61ZgzkXfE56X7OHINlT4BvGZTtkLpD1x/6qgoO4ReRQLj2v/kWG?=
 =?us-ascii?Q?LXbsAYAX3R/iA1S4TEBYqnUzhCg9CSJtBgdFcG28IbY8lkozsjoCezylBSPp?=
 =?us-ascii?Q?LCqKt7lFRC2GX2umoUyqhO8lzbRBtQ9m+pINIIUAH2QHCrsusYVeNvkCEk6N?=
 =?us-ascii?Q?pu7T91FpjL5yWlRg0WHtUGyj/wAFG/Wt5JjMwdDZj+7s76ZF2U4vs3ka2Kwb?=
 =?us-ascii?Q?9V9uE1s1sUEseFsrx3bmIuRuObiAAOfoR1lNOvozD8k1+L+jpKDZ1a3Rdv37?=
 =?us-ascii?Q?No7TH+4/hQYaNpv3PdqaxBW4e9zZXo2xzFDm51D261PJTNLAFVx/NPrdSHZk?=
 =?us-ascii?Q?VLuY6lXwWkmkPVzNlOZBsQDBdQ+phdNaJLLIUnNblrfCw51W5/ED01d40MHr?=
 =?us-ascii?Q?FtXcS7NoI4PVBBZLvwpGSrRwqYBducpbhEQleWJL+xL3eB9dqcP/cvEGweWE?=
 =?us-ascii?Q?WmkT42ja8/NsovxATUZkTVu2aFj+LCOpCmAZ6OwIU+iX1pOWg5bwszXQORc5?=
 =?us-ascii?Q?i7NUwHOOdRtOofxiqMoXw75vRQGZhqlJydydbEPfiAoB/0g8L3MOt6HH5aFg?=
 =?us-ascii?Q?UOBz07D85ENH43M0avvCMhDueGiJKbiwJBfhuDQurPYGC+jj5jVMiRYstOiV?=
 =?us-ascii?Q?wv22N3urstM9CKw5kUy9mzZzkuIGrOXbq/dbkCmkbx7pucEMHVFtX+px7oXz?=
 =?us-ascii?Q?+5gNnH+mbOwVG/aIyWT7sjbHBM+iHaYWIC6IxVUMp+Oq10pa29MSfXk3yhBg?=
 =?us-ascii?Q?nrDNuOjbppGrwplB/8Qhha30ZnLpq8Qx83Rv3x0+oQTDAM3FqyO2SavXWbo/?=
 =?us-ascii?Q?55I5ga4gcQgTmG1hc38OiYwLvyLT/KolRwJENSuVNTN8NqXWWUD3XoNzPWmp?=
 =?us-ascii?Q?hDpmU6u0ZSLo6hyuyyqBOpV81lh9Xxjrgc95Pcicfk1MeaCV2g4v8/rLOIe/?=
 =?us-ascii?Q?Ax9/X9JLoRCEhvinPWPpkbW8ESxrFvB6MDbFkGW3Px6QjaObVts0l7uOIdou?=
 =?us-ascii?Q?2kOAoA/plMXDUtRYbef5Z4zlef8mMEVZj5C0XgjjtEsd03jRbFglu+mp7WHv?=
 =?us-ascii?Q?iTqR+v4846DmU6Em0BxomThNfCipArmkn9o8xEG+HC9ohNRquIJ08tXr7iZz?=
 =?us-ascii?Q?aG74uDysZM5DlVyMHMTVP97IWW+euWFsQWhS/sPp3jsgjwpWSUgeP5mtbEzg?=
 =?us-ascii?Q?fd7dRHMkpN/ecCvoRLh2NgWp0+CAoMN9MIncY42CgyGEERvPOOzMEdt61Z6P?=
 =?us-ascii?Q?u/scgn94omyvz0fpg/BNJk476eWWBqHXUu2cpjQAt4YNZfoN1dm3bPLcHmej?=
 =?us-ascii?Q?WuqwhQc2C8Vb6Y8jTcM3HGMauD4J8M6Uky3m1a7xTAC8k5WN0aYTRG+Nw3Qx?=
 =?us-ascii?Q?Bqzh4roadIpyuDA5IZtQb1PGUXWoCKyZrAgZPFm3X0QZ02BT6IZXusgGMAuz?=
 =?us-ascii?Q?c0FUVlycUIGoBjMPryylh5E8+9Sa1W4rL+aJst+yBwnRJZlgMC8V8qTqeQvG?=
 =?us-ascii?Q?p2BSvNLZ90bf4yurIJBChOBDaec6voHe+6J4fzYo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e12226-a7b6-4694-df1f-08dcc24ad77f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 01:36:27.9798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcPtewCy7K0pUJUCZS6KLAG3cAepAtecJVxNjfbz+M+oreVO7If+1w4LNtLVYIuF+HP1b0tO/MNlWahkf5KLqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4976
X-OriginatorOrg: intel.com

On 2024-08-21 at 11:04:14 +0100, Mel Gorman wrote:
> On Mon, Aug 05, 2024 at 04:22:28PM +0800, Yujie Liu wrote:
> > Problem statement:
> > Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic"), the
> > Numa vma scan overhead has been reduced a lot. Meanwhile, the reducing of
> > the vma scan might create less Numa page fault information. The
> > insufficient information makes it harder for the Numa balancer to make
> > decision. Later, commit b7a5b537c55c08 ("sched/numa: Complete scanning of
> > partial VMAs regardless of PID activity") and commit 84db47ca7146d7
> > ("sched/numa: Fix mm numa_scan_seq based unconditional scan") are found
> > to bring back part of the performance.
> > 
> > Recently when running SPECcpu omnetpp_r on a 320 CPUs/2 Sockets system,
> > a long duration of remote Numa node read was observed by PMU events:
> > A few cores having ~500MB/s remote memory access for ~20 seconds.
> > It causes high core-to-core variance and performance penalty. After the
> > investigation, it is found that many vmas are skipped due to the active
> > PID check. According to the trace events, in most cases, vma_is_accessed()
> > returns false because the history access info stored in pids_active
> > array has been cleared.
> > 
> > Proposal:
> > The main idea is to adjust vma_is_accessed() to let it return true easier.
> > Thus compare the diff between mm->numa_scan_seq and
> > vma->numab_state->prev_scan_seq. If the diff has exceeded the threshold,
> > scan the vma.
> > 
> > This patch especially helps the cases where there are small number of
> > threads, like the process-based SPECcpu. Without this patch, if the
> > SPECcpu process access the vma at the beginning, then sleeps for a long
> > time, the pid_active array will be cleared. A a result, if this process
> > is woken up again, it never has a chance to set prot_none anymore.
> > Because only the first 2 times of access is granted for vma scan:
> > (current->mm->numa_scan_seq) - vma->numab_state->start_scan_seq) < 2
> > to be worse, no other threads within the task can help set the prot_none.
> > This causes information lost.
> > 
> > Raghavendra helped test current patch and got the positive result
> > on the AMD platform:
> > 
> > autonumabench NUMA01
> >                             base                  patched
> > Amean     syst-NUMA01      194.05 (   0.00%)      165.11 *  14.92%*
> > Amean     elsp-NUMA01      324.86 (   0.00%)      315.58 *   2.86%*
> > 
> > Duration User      380345.36   368252.04
> > Duration System      1358.89     1156.23
> > Duration Elapsed     2277.45     2213.25
> > 
> > autonumabench NUMA02
> > 
> > Amean     syst-NUMA02        1.12 (   0.00%)        1.09 *   2.93%*
> > Amean     elsp-NUMA02        3.50 (   0.00%)        3.56 *  -1.84%*
> > 
> > Duration User        1513.23     1575.48
> > Duration System         8.33        8.13
> > Duration Elapsed       28.59       29.71
> > 
> > kernbench
> > 
> > Amean     user-256    22935.42 (   0.00%)    22535.19 *   1.75%*
> > Amean     syst-256     7284.16 (   0.00%)     7608.72 *  -4.46%*
> > Amean     elsp-256      159.01 (   0.00%)      158.17 *   0.53%*
> > 
> > Duration User       68816.41    67615.74
> > Duration System     21873.94    22848.08
> > Duration Elapsed      506.66      504.55
> > 
> > Intel 256 CPUs/2 Sockets:
> > autonuma benchmark also shows improvements:
> > 
> >                                                v6.10-rc5              v6.10-rc5
> >                                                                          +patch
> > Amean     syst-NUMA01                  245.85 (   0.00%)      230.84 *   6.11%*
> > Amean     syst-NUMA01_THREADLOCAL      205.27 (   0.00%)      191.86 *   6.53%*
> > Amean     syst-NUMA02                   18.57 (   0.00%)       18.09 *   2.58%*
> > Amean     syst-NUMA02_SMT                2.63 (   0.00%)        2.54 *   3.47%*
> > Amean     elsp-NUMA01                  517.17 (   0.00%)      526.34 *  -1.77%*
> > Amean     elsp-NUMA01_THREADLOCAL       99.92 (   0.00%)      100.59 *  -0.67%*
> > Amean     elsp-NUMA02                   15.81 (   0.00%)       15.72 *   0.59%*
> > Amean     elsp-NUMA02_SMT               13.23 (   0.00%)       12.89 *   2.53%*
> > 
> >                    v6.10-rc5   v6.10-rc5
> >                                   +patch
> > Duration User     1064010.16  1075416.23
> > Duration System      3307.64     3104.66
> > Duration Elapsed     4537.54     4604.73
> > 
> > The SPECcpu remote node access issue disappears with the patch applied.
> > 
> > Fixes: fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
> > Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
> > Reviewed-and-tested-by: Raghavendra K T <raghavendra.kt@amd.com>
> > Co-developed-by: Chen Yu <yu.c.chen@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> 
> Ok, I didn't exactly replicate the autonuma test results but then again,
> I'd be a little surprised it was affected by this issue. The rescan
> decision is a bit arbitrary but I see no obviously better alternative
> and the patch is fixing an important corner case so
> 
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Sorry for the long delay in reviewing, my backlog for upstream work is
> insane :(
>

Thank you Mel for your time to review this patch.

thanks,
Chenyu 

