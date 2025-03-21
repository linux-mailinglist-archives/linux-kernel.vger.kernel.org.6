Return-Path: <linux-kernel+bounces-570779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5A7A6B45C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C134819C5013
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA671DC185;
	Fri, 21 Mar 2025 06:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FH1sbTm2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5886C1DF968
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742538096; cv=fail; b=hzuAlWSz+CJcbxA2lGEOS0ysQQ9ww+nvbZABkYZReDOnQBExbLOdkVlZzQpgcaZ476ua9omOHfc7rt56SQo8QqkAmw3C0QpYiWqOPbcr/e5Oh1lYDtWSwBbmKAzbDTODb42atpwo4t03vA1YP2pYtMqfFxTukScJbr4zC8RKWfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742538096; c=relaxed/simple;
	bh=a3rRapQfA8V2XGsJU13TkzLe6uwXz1HOcWMefNIFA6g=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KMEPDHJ2PNdVDfljelFF0f7WqlUDTGccpf5iNSF6rngJyEJxMI8IQJwCofVdiUbHuLD83PamfvFhJImR5JzQ5h0JO8+tb3E+M5teoowz5UkEyrlyouD8Musrgj85isuPEM7elW5snBRZF0bhAEg28AZkttC30NDy5yXeFr5kYAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FH1sbTm2; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742538095; x=1774074095;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=a3rRapQfA8V2XGsJU13TkzLe6uwXz1HOcWMefNIFA6g=;
  b=FH1sbTm2cZB/bDrDJIdrvkJpJte14Wlwx4/0kspRKydJMirn4JHerOHc
   hU6eLq/UsU4i0yDsli3K7h3MT7M5lVU/gRbXrRhdXdLo0RENzED9oIlaR
   7AarzhxmoV6FfuL1sG2oPHaV3l/J+z2Jaku6R0oMZh+fZ1nzTu++c5Rtj
   DRLm/ymiBwghnornNIqlMdHq1fNeEqllxidTNrDrQk8CQNDknKk8bAfRf
   5RcvGkicogGet0NLLHMWRtiMssuiTO3uBQyZlkuyITbFoqUpUoc7O1smm
   8etYXXBWb/Jd8bFv+ITHsrvu+p3RGfNFInPdjW4n1G0Tq0fRrGHu8AFX4
   w==;
X-CSE-ConnectionGUID: yrtnTx9WTjutCRNIH9b5Vw==
X-CSE-MsgGUID: lRXotVgaQwaAtjkuxhlYmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43924519"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43924519"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 23:21:34 -0700
X-CSE-ConnectionGUID: IGvXm6xDR7u4pXTbLlDztA==
X-CSE-MsgGUID: K5bCjJqCQlKJSmwv1SnlWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123284660"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2025 23:21:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Mar 2025 23:21:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 23:21:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 23:21:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qq511AgkIwP5myFg/fj8YrBLbMc/nILmeQx7aP8ESKSD4NBcVZoTTg3aA6uzaFdmISbtCOafW1di3eyAJ0lSIEW8bzzh97RK8Z4SZPO3yF9VBVnqcasWgV2sz+PTevaQswN7DJdoRJW08l6HXTwMS8/p3ZV11aYU2cSx/KNUctsEt2hyuXHV3t2t0hYVJ1JIEw6Pg3k8gIhcY2BQonCiygI/stB/XfmeSXmMtnYWRZxIERHOlyosC6LBFUwQzjZuXbs7ySYQNu+wAYYPQU/nNSn4ymstjryWmR24eYmLt7XrtmWOBhJoTSfmM5Z9MWQo+BiPElurIwFtUeA92Ol6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQg0+GBzQIuG1NsecYGdQ4n5zV/OGtUH2L3WfqXsXvU=;
 b=wysBgU1hMchi/CT8BrYSj7WTucVFZ8XD9aOtVRAR6zuUdpRZfeS7o4uHZqmEcCvGmiXVkVOUgrVBcN03T6jpT18hZgpncH7JsWx9rx9H/OD49cxaCkjoDZZlEFCEjOwTW1a/Pda+piTQJ3WDXcnVdoeORo4W28jFjzsfbg4wh5UKPR3gQkxBnIWljx7h2nw8KqpICRdlRMTfOdOLwdvZ+agN4Tvqqf8Hfhd33Z9lyBj1Hu2HeL0d/Vr33QjaXLrmtGKtFxczVyVZzUT5F3jvE60nBqkW7FZ6STDyZfl38bOsXWQEhkx8+cziOvG+TTh+X6hCcO+jxeDNvWUcY3dRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB7166.namprd11.prod.outlook.com (2603:10b6:510:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 06:21:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 06:21:30 +0000
Date: Fri, 21 Mar 2025 14:21:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "Vlastimil
 Babka" <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>, Zi Yan
	<ziy@nvidia.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH 1/5] mm: compaction: push watermark into
 compaction_suitable() callers
Message-ID: <202503201604.a3aa6a95-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250313210647.1314586-2-hannes@cmpxchg.org>
X-ClientProxiedBy: KL1PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::27) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a82559-75d3-486f-7ae5-08dd68409e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FoZydFcA20aKy/8eroER7VpjSD7TP9NQYc2ZCQRK2o4bEM6AW8cOoVziNWKq?=
 =?us-ascii?Q?GFNQMgjk0VhNkxBT1YlHnqGYyD48MZjyTrB++S/+hf7St412XT02Z1n9KqyO?=
 =?us-ascii?Q?rdfXPgukTkkV+JPdFDQcEyn5WjSLfHxjWogCd8Mvz0hTV4SLN90haAhzyJhp?=
 =?us-ascii?Q?Ngy1+3uzCrJ2NY9vcunDFPTdp7U5Fx542wf7GfxWp4hbH+DuiC8YYiwaDSsE?=
 =?us-ascii?Q?xgUD37fEF+w0kQi+T5MhFkvQVsDhaqMmA1EmW9/4Tv3D90YNL2Kiz3NQ5TWH?=
 =?us-ascii?Q?H5Ac3aBMJSKu8m+w+yzQeN7HMU806kwB48vIGJ0hizFLcHGAPsGa70iQqTip?=
 =?us-ascii?Q?E31fd4HoBiNNOTf/GW/qG2/EKBzHjgXi0SWSAe4QmSHSZn3nJ6WmJlxPnQvb?=
 =?us-ascii?Q?YX1dbojwTkP8k+ythyUPO3l7XvnhTB7/Hu0B8ejCtGcQET4o+5xOPKD5q+ud?=
 =?us-ascii?Q?Y+aGHdwNrNjv3I41x1chbexVpt/0yA8cSghN5ScD02jL2RZAW+qpoentpzPx?=
 =?us-ascii?Q?UNyq+uCzh3PzVvBdJWTcreF2JjDfuUkJCqfDMwLS28MMKG0Oies2SJ6UiZuD?=
 =?us-ascii?Q?MJ9/2CrQIG6tbmA3uk9tdV5CiX662AQHOaS6ni5YYdA5j13ZV+Z/eH2WzYbe?=
 =?us-ascii?Q?e/ID0XrpaUDC8YqYc/M/CGGUH5YemlT6RpW0qgOWqCSVaknmyhYTi8KGdhI8?=
 =?us-ascii?Q?4IqiD53mEGSL9MdX0FGAaJ3aoi0oSq6OvEkAn2iSsuN8AxL0gST8fmZRViKo?=
 =?us-ascii?Q?7d9v/DCHsEFHutx68sw/9KOhVJ0Z3cnf6XohbZqxRI8Q94jzKMTXhgNUDUsC?=
 =?us-ascii?Q?IaOVuXjaE+AXM4d7XAAX/+2vzzeV72h75jy2yZn9lTcl4Op5BOAndyjObxGI?=
 =?us-ascii?Q?KNQaulg1QCOknBh7npkCJXkxK1+MBtqLmqQkSHd5EBOecFuiOfPtg4uhG8WY?=
 =?us-ascii?Q?tjsKF4/OPDfHHnR9wMaA/5Hc3G6BGUpwxV8GRR4WREEbiFzXwEnQMX66Q2hg?=
 =?us-ascii?Q?zGcUuck54f5zLwBjk0rwDBEyuHDM+Bd1gGvVj8oa74Rghfv1ltiBoVV2/+uB?=
 =?us-ascii?Q?lULMoAolyBBVQ8vjZVEbMQJ2Zjwu/RaGsTs9DRL8Rd4r9DJMT53vz1FUzZhZ?=
 =?us-ascii?Q?1cfIYpv/5evHf2k0BANXYckrBsNQymT2EgNqzUSZgZLkWOHOgO3itzLW1TnU?=
 =?us-ascii?Q?km+16q5GUrlHvNkNgaGyCW/aGpzAC+yy3C4bF8WL5GyW0MpE3Vq6LdANJs3t?=
 =?us-ascii?Q?dsy/nhfCGryvuCRyxK6zVIDlxK+O1P5OF4aRWbTJlDP7lRV+xhKh7s9cQ3RB?=
 =?us-ascii?Q?rg3aOPI464y9qm5b0luC6qw3hFtxBGNDc/7C9Z4J0HvaxQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WXEEdTgaQkMrgsKFFS/4pBQV9jxaomFZjdZ4sPdeW+1nmt/Svu5RkbkdiStq?=
 =?us-ascii?Q?L5bdO7FeqC3vGX36UDp4mA9YsEm6zSESPXHccJ8MeZdK7fKx/IHiq/F7VDTd?=
 =?us-ascii?Q?tyJd9H+WmOmCf6hWEcbsesU3gT2GEwx80webmuKFqxNzwb4G5kkeOgbx8k5G?=
 =?us-ascii?Q?5et7xcXbQHNbDd6U7ufcnNZm5m6YVFszCNoYPphUie3MKN6QqxDxCbs32eSO?=
 =?us-ascii?Q?LzQ0lP0TWz1IZD2tasRGwnVor0XBj2z+Jg8kOtA4f9Rq7fIB3RmzSs4QEIlu?=
 =?us-ascii?Q?xMUrv6xeLjxfRN/rlvQq85srF27FQuYYlsueh+LWE+0YJJoRQibChczfafeq?=
 =?us-ascii?Q?4KKeoA/1i+Kbjlm75cWOXpYNQONQHaYQFyW24yLReUAbVMzCjGAbG+LCT79M?=
 =?us-ascii?Q?KnLj3hOu38psoEtkSkN7J0yh+9mF+bd87JMzWml+MZi/1hv/sx+9sYaVnt78?=
 =?us-ascii?Q?q0amvDTteWxEweyRsZ6Sw/2zC7/A1TXbE68ct5IBNHRo6wvn2zZpEnwUnz/9?=
 =?us-ascii?Q?RRzQwauu1z/nRtfjfUc6IT6ZzKJw7LeD9/Q/jXfN6BBSHKSM3kg6LqeOqww4?=
 =?us-ascii?Q?fI5pDUQ+hcuJkKaDn9itNwyxQVz6YguCOC4fKFCS3IqYstLBp9djqd7MNf6q?=
 =?us-ascii?Q?/ddTZu1waBh+CNij71yn7DvUk4D4H6VgtGG6YEBfXXuE2RjgIDBxxQAkfw0l?=
 =?us-ascii?Q?MngLQ2l3j8Z5BXzoWT/VB6wLpxB8jyvIieWrcZj4/r4ZX2cH97x72VmdXl/v?=
 =?us-ascii?Q?YsMaBUNWpE8frZZSmTLE0I5S4T7Pm7X7Qf1RTItUJM5anv2/zniL0MAkpUie?=
 =?us-ascii?Q?79fSCXAYFuZh031Ih/azHQJb936F+I+g0sY7v7e5wF3O05bjV9tUhDLAFu8Y?=
 =?us-ascii?Q?7eoIqPRcZnl10Q2t7X8V769qKYPtB9vRTr4+lcyuUkIJpcYr/FrLWvQJcm4n?=
 =?us-ascii?Q?NlH68uBhS1S1BRMUza+0fN0BcHRnjsxrdUu3C4rX7caItIb333J5oxkYZuvW?=
 =?us-ascii?Q?4XM2pRd3Wia+Jyt25KLmqo+RwH2P9i8Npqf3hlgiRfZMH3M3R3FoDMAWfjvH?=
 =?us-ascii?Q?Q6z8eNXA1qoLCrgD2xl/PG9IOLDRQW0haCHvG+zyacAukfpwD50O+o9EjIX/?=
 =?us-ascii?Q?Bjxip7zOvBC0t3Y67LRRK0Za3q6EhfEsetoYbUwPVe+R48Twt8lm5Ogh3+5s?=
 =?us-ascii?Q?O6bW092EM3K1K3Wh7Ww+Jh/ebUvTj0RCai3NmFq0bXDlVB+l0EsaeWpRAiGx?=
 =?us-ascii?Q?WjUyFI+O6SYSZBqujbhxUWxFsQZAXLq41jCtWaHQBwslwZYuXB85OFiECW8x?=
 =?us-ascii?Q?m0YrE8LcTHbA74HjoLbVCKPrDUSSWYsf/eNdKbLrNriTrGyc3tf5ETPsoSTR?=
 =?us-ascii?Q?DaXZvDmpO40DWLMJDhxTMllvI5lXSzxQGXxsPXgeSpeugujOVn8bZm76xk0x?=
 =?us-ascii?Q?pODh83AmJ5m7Hp9JatP4uUxEynmEK8xy6miEIf4TR283ivucgH8/H7WW3Hhh?=
 =?us-ascii?Q?CTLA94hb4qcWo9t5IDUqznGsSRwlbn1ri/jSZ5keFeDQqyCigPq/m9Cdc7ZM?=
 =?us-ascii?Q?d3vONA28Iha1Olw5JpVcR+6ut+8m8v01fYeLLzlL7t0EPhherUiEpEYcRd8W?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a82559-75d3-486f-7ae5-08dd68409e44
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 06:21:30.1660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEquTAVNgIcgdYpoEKX219AqzJ+W6zDNbtEaPMWo+rho3VxEUqfHjXZjjSOOqu1xbJ/Hp28FICz+SAz9WJRj6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: 6304be90cf5460f33b031e1e19cbe7ffdcbc9f66 ("[PATCH 1/5] mm: compaction: push watermark into compaction_suitable() callers")
url: https://github.com/intel-lab-lkp/linux/commits/Johannes-Weiner/mm-compaction-push-watermark-into-compaction_suitable-callers/20250314-050839
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20250313210647.1314586-2-hannes@cmpxchg.org/
patch subject: [PATCH 1/5] mm: compaction: push watermark into compaction_suitable() callers

in testcase: trinity
version: trinity-x86_64-ba2360ed-1_20241228
with following parameters:

	runtime: 300s
	group: group-03
	nr_groups: 5



config: x86_64-kexec
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | 0174ed04ed | 6304be90cf |
+---------------------------------------------+------------+------------+
| BUG:unable_to_handle_page_fault_for_address | 0          | 5          |
| Oops                                        | 0          | 5          |
| RIP:__zone_watermark_ok                     | 0          | 5          |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503201604.a3aa6a95-lkp@intel.com


[   24.321289][   T36] BUG: unable to handle page fault for address: ffff88844000c5f8
[   24.322631][   T36] #PF: supervisor read access in kernel mode
[   24.323577][   T36] #PF: error_code(0x0000) - not-present page
[   24.324482][   T36] PGD 3a01067 P4D 3a01067 PUD 0
[   24.325301][   T36] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
[   24.326157][   T36] CPU: 1 UID: 0 PID: 36 Comm: kcompactd0 Not tainted 6.14.0-rc6-00559-g6304be90cf54 #1
[   24.327631][   T36] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 24.329194][ T36] RIP: 0010:__zone_watermark_ok (mm/page_alloc.c:3256) 
[ 24.330125][ T36] Code: 84 c0 78 14 4c 8b 97 48 06 00 00 45 31 db 4d 85 d2 4d 0f 4f da 4c 01 de 49 29 f1 41 f7 c0 38 02 00 00 0f 85 92 00 00 00 48 98 <48> 03 54 c7 38 49 39 d1 7e 7e b0 01 85 c9 74 7a 83 f9 0a 7f 73 48
All code
========
   0:	84 c0                	test   %al,%al
   2:	78 14                	js     0x18
   4:	4c 8b 97 48 06 00 00 	mov    0x648(%rdi),%r10
   b:	45 31 db             	xor    %r11d,%r11d
   e:	4d 85 d2             	test   %r10,%r10
  11:	4d 0f 4f da          	cmovg  %r10,%r11
  15:	4c 01 de             	add    %r11,%rsi
  18:	49 29 f1             	sub    %rsi,%r9
  1b:	41 f7 c0 38 02 00 00 	test   $0x238,%r8d
  22:	0f 85 92 00 00 00    	jne    0xba
  28:	48 98                	cltq
  2a:*	48 03 54 c7 38       	add    0x38(%rdi,%rax,8),%rdx		<-- trapping instruction
  2f:	49 39 d1             	cmp    %rdx,%r9
  32:	7e 7e                	jle    0xb2
  34:	b0 01                	mov    $0x1,%al
  36:	85 c9                	test   %ecx,%ecx
  38:	74 7a                	je     0xb4
  3a:	83 f9 0a             	cmp    $0xa,%ecx
  3d:	7f 73                	jg     0xb2
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 03 54 c7 38       	add    0x38(%rdi,%rax,8),%rdx
   5:	49 39 d1             	cmp    %rdx,%r9
   8:	7e 7e                	jle    0x88
   a:	b0 01                	mov    $0x1,%al
   c:	85 c9                	test   %ecx,%ecx
   e:	74 7a                	je     0x8a
  10:	83 f9 0a             	cmp    $0xa,%ecx
  13:	7f 73                	jg     0x88
  15:	48                   	rex.W
[   24.333001][   T36] RSP: 0018:ffffc90000137cd0 EFLAGS: 00010246
[   24.334003][   T36] RAX: 00000000000036a8 RBX: 0000000000000001 RCX: 0000000000000000
[   24.335270][   T36] RDX: 0000000000000006 RSI: 0000000000000000 RDI: ffff88843fff1080
[   24.336551][   T36] RBP: 0000000000000001 R08: 0000000000000080 R09: 0000000000003b14
[   24.337799][   T36] R10: 00000000000018b0 R11: 00000000000018b0 R12: 0000000000000001
[   24.339130][   T36] R13: 0000000000000000 R14: ffff88843fff1080 R15: 00000000000036a8
[   24.340412][   T36] FS:  0000000000000000(0000) GS:ffff88842fd00000(0000) knlGS:0000000000000000
[   24.341739][   T36] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.342448][   T36] CR2: ffff88844000c5f8 CR3: 00000001bceba000 CR4: 00000000000406f0
[   24.343331][   T36] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   24.347498][   T36] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   24.348260][   T36] Call Trace:
[   24.348621][   T36]  <TASK>
[ 24.348958][ T36] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 24.349447][ T36] ? page_fault_oops (arch/x86/mm/fault.c:710) 
[ 24.350008][ T36] ? do_kern_addr_fault (arch/x86/mm/fault.c:1198) 
[ 24.350582][ T36] ? exc_page_fault (arch/x86/mm/fault.c:1479) 
[ 24.351065][ T36] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[ 24.351550][ T36] ? __zone_watermark_ok (mm/page_alloc.c:3256) 
[ 24.352049][ T36] compaction_suitable (mm/compaction.c:2407) 
[ 24.352532][ T36] compaction_suit_allocation_order (mm/compaction.c:?) 
[ 24.353127][ T36] kcompactd (mm/compaction.c:3109) 
[ 24.353618][ T36] kthread (kernel/kthread.c:466) 
[ 24.354105][ T36] ? __pfx_kcompactd (mm/compaction.c:3184) 
[ 24.354658][ T36] ? __pfx_kthread (kernel/kthread.c:413) 
[ 24.355121][ T36] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 24.355567][ T36] ? __pfx_kthread (kernel/kthread.c:413) 
[ 24.356032][ T36] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   24.356505][   T36]  </TASK>
[   24.356837][   T36] Modules linked in: can_bcm can_raw can cn scsi_transport_iscsi sr_mod ipmi_msghandler cdrom sg ata_generic dm_mod fuse
[   24.358098][   T36] CR2: ffff88844000c5f8
[   24.358662][   T36] ---[ end trace 0000000000000000 ]---
[ 24.359178][ T36] RIP: 0010:__zone_watermark_ok (mm/page_alloc.c:3256) 
[ 24.359726][ T36] Code: 84 c0 78 14 4c 8b 97 48 06 00 00 45 31 db 4d 85 d2 4d 0f 4f da 4c 01 de 49 29 f1 41 f7 c0 38 02 00 00 0f 85 92 00 00 00 48 98 <48> 03 54 c7 38 49 39 d1 7e 7e b0 01 85 c9 74 7a 83 f9 0a 7f 73 48
All code
========
   0:	84 c0                	test   %al,%al
   2:	78 14                	js     0x18
   4:	4c 8b 97 48 06 00 00 	mov    0x648(%rdi),%r10
   b:	45 31 db             	xor    %r11d,%r11d
   e:	4d 85 d2             	test   %r10,%r10
  11:	4d 0f 4f da          	cmovg  %r10,%r11
  15:	4c 01 de             	add    %r11,%rsi
  18:	49 29 f1             	sub    %rsi,%r9
  1b:	41 f7 c0 38 02 00 00 	test   $0x238,%r8d
  22:	0f 85 92 00 00 00    	jne    0xba
  28:	48 98                	cltq
  2a:*	48 03 54 c7 38       	add    0x38(%rdi,%rax,8),%rdx		<-- trapping instruction
  2f:	49 39 d1             	cmp    %rdx,%r9
  32:	7e 7e                	jle    0xb2
  34:	b0 01                	mov    $0x1,%al
  36:	85 c9                	test   %ecx,%ecx
  38:	74 7a                	je     0xb4
  3a:	83 f9 0a             	cmp    $0xa,%ecx
  3d:	7f 73                	jg     0xb2
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 03 54 c7 38       	add    0x38(%rdi,%rax,8),%rdx
   5:	49 39 d1             	cmp    %rdx,%r9
   8:	7e 7e                	jle    0x88
   a:	b0 01                	mov    $0x1,%al
   c:	85 c9                	test   %ecx,%ecx
   e:	74 7a                	je     0x8a
  10:	83 f9 0a             	cmp    $0xa,%ecx
  13:	7f 73                	jg     0x88
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250320/202503201604.a3aa6a95-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


