Return-Path: <linux-kernel+bounces-563588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107F9A644D7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FB73AFBB3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C1621B9E3;
	Mon, 17 Mar 2025 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a722lgWJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CB921C173
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199201; cv=fail; b=qfKtB7hafF3k0Fv+iuhsYZXRluxcd5hlTd3EnS4KwyQ+MUgYi6uGsoQz84B2KQNZ7JVKq7F4O1EE1DeWsuN8wUu6xdn3i0bIngVNvPp/mTGLfnegTOqoRG4+01WVyWqrOF9BemEGXjoMosTbIZXTttCjpbMzJqXYMzh5twagQZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199201; c=relaxed/simple;
	bh=tVO8YomUxxDU3jWasC/1l3QyfAyZA3gfIksjanq5WJ4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mf35tM7rG4rSLJ3aWmj7C4v3IRfE5H3pLZN7xMEWKCfgxS8c8ppQh1ufgYYA2AvIuCVGHFRphkvnTUA1bsIz1t7+zCi0+B+gZ47Ku3uExDE1gMvDsjHPcj8epeCJb1Z3qS0vsyL9vUWRMDXN0PIE9B9xNY6zBUrcsb9miUOCjdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a722lgWJ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742199199; x=1773735199;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=tVO8YomUxxDU3jWasC/1l3QyfAyZA3gfIksjanq5WJ4=;
  b=a722lgWJTIYW7gT5tOqr0+uLNYvNgx6JvqI6bZ7bAB1Er2BPEXnUFuAT
   34wYlB/UHS3wKNTIJnDDS/0EhKWDNUIDBUzjNwZAdv9x39JqNkwDd5Vs+
   RY06io76uplrveaLu8IHgWnVkRUHbzhQS6M1zb13DfbJVmkowDtuXkYu4
   YvMEavfNU2iaUeQEOz0vM4i83FWDjr7TaXsjFfyQBLXw6DKQhCFGz0cYM
   QC2Zlr+e3eIbjs6m9u6Q5SwQd/tYoWQGuthbVsrYx6GYvgqCnCXqvH8yj
   mWpTmt6KDkjc5y3qRYyqq5lzQ77o3clC4YImEdLK1fxenBr/1kxFbwAsl
   g==;
X-CSE-ConnectionGUID: voL8gHojSJitc9/OBl3mbw==
X-CSE-MsgGUID: xelaEsIdTWuDLUBnS0vhOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="54652445"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="54652445"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 01:13:18 -0700
X-CSE-ConnectionGUID: ScHJ/Xb1RlCzJzqI7iJrcw==
X-CSE-MsgGUID: 6mzzSHR8SVKq9rZS273v7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="121676243"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2025 01:13:18 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Mar 2025 01:13:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Mar 2025 01:13:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 01:13:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjIlGRuTpeDQStb5HUoiYe70PY9WFmAdy+s53Wy/fqO1RK/ST93VXBvWjlDkd70/FzGw6MY0d5mbMcn8enV9vF25sN4rZXXUu/zeX27MW/rjQMYgeMrzNbQWp6gm55sPR7wNfdqorBSJ231fE05dK6gnrHYL6AFoKYkyqZUfsXOTmPhLDyaoG0ByC9jIapIPCOkTLMw4w4JY/rkNQIu72GFWkrNjN0H7cbjIdVflnOFFG2n2dwsh1EYaxE2d/WFIqDL+tRA7YJyjEbK+8ik9rPuy9SImccastCWmJnEzitHkLml2fIkP8pT/ER4oLae6pZgFlKNmAl5yNaS8NWgecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdM6OPoh4TpWnSIdZmt5xV3WREUoSISyM3/vhurBvN0=;
 b=PU/ex5p6uyC3ZbbxcL2f4aDf9b0sEmJfb+JmzEZnQ4IZdlZm3Z/7jeUr5HttYRgo0DzqK+vXyPcMf3F/uxU7j6jfNqv3fitLFxCdhZDIGDWUlwFAna3JBhxozhkLz1WOaNMsEfoacQdM18rS9DvPXQSwldp8K6jIlq+xJA1iq7i/DsrAYhefNyOLXAf6djfPnDhuxsDR0R3BepuXK8SLWIdghpZqlsKaNl1JCjI6mZMZlErkZnlFwuR8336+z8FyM1iBmKy+ZdeVY79Bq1Zzaw6/CEwTfg75xzc9Sib9nQCvpsm2QwL248IPrv4bcGKpTPecXW6Ge+ZWvaUiIvPGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7027.namprd11.prod.outlook.com (2603:10b6:510:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 08:13:15 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 08:13:15 +0000
Date: Mon, 17 Mar 2025 16:13:03 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	"Dirk VanDerMerwe" <dirk.vandermerwe@sophos.com>, Vimal Agrawal
	<vimal.agrawal@sophos.com>, Thadeu Lima de Souza Cascardo
	<cascardo@igalia.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2 1/2] char: misc: restrict the dynamic range to exclude
 reserved minors
Message-ID: <202503171507.6c8093d0-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250307-misc-dynrange-v2-1-6fe19032ef76@igalia.com>
X-ClientProxiedBy: KL1PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:820::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c025d9-e794-43eb-76bb-08dd652b90fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aSSVa/gSseqcGjGSL9brToDXPCgpMqO1nsPy4G+M9JDUWui/osCDNh5iarHj?=
 =?us-ascii?Q?3iaczAhhA6lQ1CMW7e8TQd/SV+Ogc5Nb1l7rjHzuQHR3NLqEpZdPXb/sq7sk?=
 =?us-ascii?Q?dresE6zIgugu/Eenm9Z0kwwO+D/T3CYL7mCiTdcFOdzTAK6CfvttBV3QGlg4?=
 =?us-ascii?Q?C5JBMy2j3RReAWilUOf8ZC8ER2AWrxPfC5fWBFrc5xfS97wVI7wPsuFSMXbB?=
 =?us-ascii?Q?71AgF0/ps6VHRrLZTROSlPY5z37LZ2620fZILRy4mmhkHiH8RwGq362FR3hq?=
 =?us-ascii?Q?IlzJ2ntLOVDWr0vJXqPXYAX5XzXq5/K+AtNgTTBh7v+ANvdCNhf2DwFMYsd/?=
 =?us-ascii?Q?8V1eQwPCf9MHJOzxVJzn3YNtJQ1LQ2cLexPK7bYT09xqaO4fsQPsKsvtI0a7?=
 =?us-ascii?Q?YTpOI3dPInVgTKe8oAQ+3pV0et62MxWyEzTZUNaCloqknSInQbAEV8CWM6oZ?=
 =?us-ascii?Q?xkgE5AMdjicu2hv5188J+Vb4y47RHEoeXLTvsValG1yxDntg7se6WS9YNJUN?=
 =?us-ascii?Q?zewp+DUVRuyU5KD8+tz5WGBGn8s48lwyXFci1+oNEMPxB1sQMUD//2dQpAjC?=
 =?us-ascii?Q?MUHJFG4XMmEeb3c+9DEPHwax38UluqSnQrFnDfJ+txXoE8i4TqEPYdbAGXLu?=
 =?us-ascii?Q?2CFPqQeieiexNzmvno5ug/qgcU0uWXGMCBK6IWVFjAKKcj5R/vPKWHbrid92?=
 =?us-ascii?Q?pViiVu/SLLOf+i47cYqc70JSh9T2F8+x9I81kDOSaOo8M7B9fkokFL3Y7vrI?=
 =?us-ascii?Q?CNxyaqAXew4E/JHByLW17TfpL3pQr68PF2A2RycDrY2tSnJSsObepUGusxC0?=
 =?us-ascii?Q?Rsj3R99SyQP1cdgJl4B6obWa9/FpJrQSbKroBON5Y5iQz3f2kYRO61M9rXdl?=
 =?us-ascii?Q?nY9zUNR68GuYKWR/RuAfEw8ekeIlkpYRN/UsW5wRzhFKu3AceANeSbUTg00k?=
 =?us-ascii?Q?eHw1bW4RDxe1Wb34zfKdfTTYfB8MDyORC3czNgK8Jfm8gCmYvH071Zy81AWK?=
 =?us-ascii?Q?5RHtA+McyIY6gnjXN4oZ5AebwMFnDolh+uSiPrQbOJRiSroAHCoOgbZT20Sr?=
 =?us-ascii?Q?5oyHt/rxlebhOsjmiGpcXd/DSZcTIzNjHp8na6bw80KEdwMp5d1y5I0EmvQ3?=
 =?us-ascii?Q?NuLTx0hZCJeS+cZ+OOVXjobtd5uH6pzdASIc8tR9PWC+VnEzf+0V9gaHY+2O?=
 =?us-ascii?Q?QoAuQw7rJPTOtXlp0GyBq5cxHuoaR6yRkziMzcootlnb9DUZvTaRp8G/0+Xj?=
 =?us-ascii?Q?JoGd5RahWGX70XFI4C4OLgNtsgP0d2aFirbn9C6UaAMawqjRqPdGJAprxG5a?=
 =?us-ascii?Q?H/inDujdRvytCOTomCH4Vf19z/imGHnVQBUrxJgWMieJoA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yka2pgdo4NHx6EeBdVTXTH/id107v+PWS86tAKoOjzwSVGlB1kFI0qTc+pdF?=
 =?us-ascii?Q?Fm0MIM0gBOSfkvor1748o9YbAMIs2e9HCiPCDv0VqdImnQlOZEud1d7My3Dy?=
 =?us-ascii?Q?deRVH4+FPO8KdTy82GGaj5h/s0zC1GajwYHVkDMOJFfbvFDCQ8t3OS6GhgKY?=
 =?us-ascii?Q?elmb/b2E7J+6n7WAN8g6aaF+dqgSRTeP6ndHnw2wUS3LxKazwAh5FmOhbE5K?=
 =?us-ascii?Q?swhmlbHBaFBkbTozudkTu/u364gGxKrweI+f+bsKNAnGDPecLh+H2bokc8RG?=
 =?us-ascii?Q?3xnIpYdUsAdsxgkqAwv+DxRMZZtYOFjX8yxBb+V7tGeIPMFL3hJvhX1wGREC?=
 =?us-ascii?Q?vYD8D73TQeBpZjMdUgtyaN3UyGHoV5A17oIT2DUVBoElQjYOtyuDM3Q5QZx2?=
 =?us-ascii?Q?J22LTVJLqkZoLL0w29Hr0EgX0MMGH/pqh8pZEgSRl1Py+jO+6zj+eec+joWQ?=
 =?us-ascii?Q?at0oIPxMaNGuDHtQdC4MrYIDCYF76q1Re6Hw1PwKkQNYsSZHird+52BOumgn?=
 =?us-ascii?Q?2YbeHaoyCj1S5jshNEhWImXLl9uyPnpPdWYOJrFnkDDfuq+S4bWFxDbj9PRT?=
 =?us-ascii?Q?pFncrrtKo9OfAnBLwroGZKbNqgQvrS6LDJxM/Oc0PyUxdbD7LD+BabIg4dIm?=
 =?us-ascii?Q?V/bXWp82GBMUcHTNSY7Z+qr/vS2SYGWlM175mpUrWOICwn+ohzm+EP/EKiQc?=
 =?us-ascii?Q?QDjJo7Ql8FBrjp2UAMjwiqyDH3B8YEumf0f+HFV7m4RhIkrqAbNu+DqsYZsU?=
 =?us-ascii?Q?svFh1y7QQ13PxKS7I31WvlfMmh7SxJtwJ4BetPS6FuvqNeMhUpq8Tof7e/u7?=
 =?us-ascii?Q?b7Y+Gg+lBxTz/yahqF5eQ6mPd1PvRiaBxOVXCD8WcyXpW9GNviTanVMymqP4?=
 =?us-ascii?Q?tKQX+rJTeQC9DRcZmxLh8QcDRtEVGugIW8YsSgcAkZrhwWbU/7wgInHH9H+G?=
 =?us-ascii?Q?AN+2EjsGmvrLc5GjN1r52oEnaDTsIFi1Z0BXUYCeWtj8G72u1SpdrKrwPAl7?=
 =?us-ascii?Q?WR8v3PaQEc43yiPnXQuLku/JJ2Yel3tw+ApWJcjnsktKYpsUWDFw+IAs/O2E?=
 =?us-ascii?Q?noByZ+pYNQoFEy/9pgLw/We5CXzd6TW/TSbRE0881kAKHCZxmX89DWxyGBD4?=
 =?us-ascii?Q?H+/lUAYNDG1dbjGtbYPU0237fBhSCZw9JBjd4SdKZZ7dyxE5YEmiIRPYz5RH?=
 =?us-ascii?Q?txo53i/G0psGeULTefLTr2N3Cr65/PBnVg6i7WYTGSPI4NBuPOfwq/i6uqsr?=
 =?us-ascii?Q?hDl//lMZMjrFgZZ5lockduPDwK8pIExR6PmUMIudth4tcSpag3gppk8NrawT?=
 =?us-ascii?Q?BP2hEcrVHp/GaI3+ab3oVdIY4mmTQm+xfC0W0j/gciRAH0xeBdiUNKEVg20G?=
 =?us-ascii?Q?+8iwUgCcofGQ/h2U8XEFoPib590EoKegxfwtwhPLxklKPkDwhh+Q7whTzyH5?=
 =?us-ascii?Q?QA+SHVWsn49W4Zc6JKXmx+Ag9KwwCtDl51j7bfLrh118WhGTJpI+G/IQTton?=
 =?us-ascii?Q?TdLDZqfeTqfEgFlHVHxW/eaCt4i7XI2U+IcABUDyLmhrjf4iwgMKLf6ZO3WQ?=
 =?us-ascii?Q?MjEuHGROeIRhIaeeSd3OutslKheDXsIB/7ENc8C4TGRe+6MGWbKjzQhOQquF?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c025d9-e794-43eb-76bb-08dd652b90fb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 08:13:15.0045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UPd8mgZ6SPN6/Cej2W0GgsRqsgMQAqmVooZasgZMH3GsceeLkK6FTkUSs5AXHfW/XcCA0q5LqIGzRSsyJ4Fmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7027
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.sgx.test_sgx.enclave.unclobbered_vdso.fail" on:

commit: 47b2b7ca1ce4d1dbbaae0334436869c9e987d03c ("[PATCH v2 1/2] char: misc: restrict the dynamic range to exclude reserved minors")
url: https://github.com/intel-lab-lkp/linux/commits/Thadeu-Lima-de-Souza-Cascardo/char-misc-restrict-the-dynamic-range-to-exclude-reserved-minors/20250307-231711
patch link: https://lore.kernel.org/all/20250307-misc-dynrange-v2-1-6fe19032ef76@igalia.com/
patch subject: [PATCH v2 1/2] char: misc: restrict the dynamic range to exclude reserved minors

in testcase: kernel-selftests
version: kernel-selftests-x86_64-7ff71e6d9239-1_20250215
with following parameters:

	group: sgx



config: x86_64-rhel-9.4-kselftests
compiler: gcc-12
test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake-E) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


here is a comparison with more details, cases failed upon this commit while
pass on parent:

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/group:
  lkp-cfl-e1/kernel-selftests/debian-12-x86_64-20240206.cgz/x86_64-rhel-9.4-kselftests/gcc-12/sgx

2397d61ee45cddb8 47b2b7ca1ce4d1dbbaae0334436
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :9           67%           6:6     kernel-selftests.sgx.test_sgx.enclave.clobbered_vdso.fail
           :9           67%           6:6     kernel-selftests.sgx.test_sgx.enclave.clobbered_vdso_and_user_function.fail
           :9           67%           6:6     kernel-selftests.sgx.test_sgx.enclave.pte_permissions.fail
           :9           67%           6:6     kernel-selftests.sgx.test_sgx.enclave.tcs_entry.fail
           :9           67%           6:6     kernel-selftests.sgx.test_sgx.enclave.unclobbered_vdso.fail
           :9           67%           6:6     kernel-selftests.sgx.test_sgx.enclave.unclobbered_vdso_oversubscribed.fail
           :9           67%           6:6     kernel-selftests.sgx.test_sgx.fail




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503171507.6c8093d0-lkp@intel.com


2025-03-11 18:27:45 make quicktest=1 run_tests -C sgx
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-47b2b7ca1ce4d1dbbaae0334436869c9e987d03c/tools/testing/selftests/sgx'
TAP version 13
1..1
# timeout set to 300
# selftests: sgx: test_sgx
# TAP version 13
# 1..16
# # Starting 16 tests from 1 test cases.
# #  RUN           enclave.unclobbered_vdso ...
# Unable to open /dev/sgx_enclave: No such device or address
# # main.c:188:unclobbered_vdso:Failed to load the test enclave.
# # main.c:287:unclobbered_vdso:Expected 0 (0) != setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata) (0)
# # unclobbered_vdso: Test terminated by assertion
# #          FAIL  enclave.unclobbered_vdso
# not ok 1 enclave.unclobbered_vdso
# #  RUN           enclave.unclobbered_vdso_oversubscribed ...
# Unable to open /dev/sgx_enclave: No such device or address
# # main.c:188:unclobbered_vdso_oversubscribed:Failed to load the test enclave.
# # main.c:360:unclobbered_vdso_oversubscribed:Expected 0 (0) != setup_test_encl(total_mem, &self->encl, _metadata) (0)
# # unclobbered_vdso_oversubscribed: Test terminated by assertion
# #          FAIL  enclave.unclobbered_vdso_oversubscribed
# not ok 2 enclave.unclobbered_vdso_oversubscribed
# #  RUN           enclave.unclobbered_vdso_oversubscribed_remove ...
# # main.c:402:unclobbered_vdso_oversubscribed_remove:Creating an enclave with 198705152 bytes heap may take a while ...
# Unable to open /dev/sgx_enclave: No such device or address
# # main.c:188:unclobbered_vdso_oversubscribed_remove:Failed to load the test enclave.
# # main.c:404:unclobbered_vdso_oversubscribed_remove:Expected 0 (0) != setup_test_encl(total_mem, &self->encl, _metadata) (0)
# # unclobbered_vdso_oversubscribed_remove: Test terminated by assertion
# #          FAIL  enclave.unclobbered_vdso_oversubscribed_remove
# not ok 3 enclave.unclobbered_vdso_oversubscribed_remove
# #  RUN           enclave.clobbered_vdso ...
# Unable to open /dev/sgx_enclave: No such device or address
# # main.c:188:clobbered_vdso:Failed to load the test enclave.
# # main.c:509:clobbered_vdso:Expected 0 (0) != setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata) (0)
# # clobbered_vdso: Test terminated by assertion
# #          FAIL  enclave.clobbered_vdso
# not ok 4 enclave.clobbered_vdso
# #  RUN           enclave.clobbered_vdso_and_user_function ...
# Unable to open /dev/sgx_enclave: No such device or address
# # main.c:188:clobbered_vdso_and_user_function:Failed to load the test enclave.
# # main.c:545:clobbered_vdso_and_user_function:Expected 0 (0) != setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata) (0)
# # clobbered_vdso_and_user_function: Test terminated by assertion
# #          FAIL  enclave.clobbered_vdso_and_user_function
# not ok 5 enclave.clobbered_vdso_and_user_function
# #  RUN           enclave.tcs_entry ...
# Unable to open /dev/sgx_enclave: No such device or address
# # main.c:188:tcs_entry:Failed to load the test enclave.
# # main.c:578:tcs_entry:Expected 0 (0) != setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata) (0)
# # tcs_entry: Test terminated by assertion
# #          FAIL  enclave.tcs_entry
# not ok 6 enclave.tcs_entry
# #  RUN           enclave.pte_permissions ...
# Unable to open /dev/sgx_enclave: No such device or address
# # main.c:188:pte_permissions:Failed to load the test enclave.
# # main.c:623:pte_permissions:Expected 0 (0) != setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata) (0)
# # pte_permissions: Test terminated by assertion
# #          FAIL  enclave.pte_permissions
# not ok 7 enclave.pte_permissions
# #  RUN           enclave.tcs_permissions ...
# Unable to open /dev/sgx_enclave: No such device or address
# # main.c:188:tcs_permissions:Failed to load the test enclave.
# # main.c:725:tcs_permissions:Expected 0 (0) != setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata) (0)
# # tcs_permissions: Test terminated by assertion
# #          FAIL  enclave.tcs_permissions
# not ok 8 enclave.tcs_permissions
# #  RUN           enclave.epcm_permissions ...
# Unable to open /dev/sgx_enclave: No such device or address
# # main.c:188:epcm_permissions:Failed to load the test enclave.
# # main.c:788:epcm_permissions:Expected 0 (0) != setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata) (0)
# # epcm_permissions: Test terminated by assertion
# #          FAIL  enclave.epcm_permissions
# not ok 9 enclave.epcm_permissions
# #  RUN           enclave.augment ...
# #      SKIP      SGX2 not supported
# #            OK  enclave.augment
# ok 10 enclave.augment # SKIP SGX2 not supported
# #  RUN           enclave.augment_via_eaccept ...
# #      SKIP      SGX2 not supported
# #            OK  enclave.augment_via_eaccept
# ok 11 enclave.augment_via_eaccept # SKIP SGX2 not supported
# #  RUN           enclave.tcs_create ...
# Unable to open /dev/sgx_enclave: No such device or address
# # main.c:188:tcs_create:Failed to load the test enclave.
# # main.c:1240:tcs_create:Expected 0 (0) != setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata) (0)
# # tcs_create: Test terminated by assertion
# #          FAIL  enclave.tcs_create
# not ok 12 enclave.tcs_create
# #  RUN           enclave.remove_added_page_no_eaccept ...
# Unable to open /dev/sgx_enclave: No such device or address
# # main.c:188:remove_added_page_no_eaccept:Failed to load the test enclave.
# # main.c:1571:remove_added_page_no_eaccept:Expected 0 (0) != setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata) (0)
# # remove_added_page_no_eaccept: Test terminated by assertion
# #          FAIL  enclave.remove_added_page_no_eaccept
# not ok 13 enclave.remove_added_page_no_eaccept
# #  RUN           enclave.remove_added_page_invalid_access ...
# Unable to open /dev/sgx_enclave: No such device or address
# # main.c:188:remove_added_page_invalid_access:Failed to load the test enclave.
# # main.c:1682:remove_added_page_invalid_access:Expected 0 (0) != setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata) (0)
# # remove_added_page_invalid_access: Test terminated by assertion
# #          FAIL  enclave.remove_added_page_invalid_access
# not ok 14 enclave.remove_added_page_invalid_access
# #  RUN           enclave.remove_added_page_invalid_access_after_eaccept ...
# Unable to open /dev/sgx_enclave: No such device or address
# # main.c:188:remove_added_page_invalid_access_after_eaccept:Failed to load the test enclave.
# # main.c:1797:remove_added_page_invalid_access_after_eaccept:Expected 0 (0) != setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata) (0)
# # remove_added_page_invalid_access_after_eaccept: Test terminated by assertion
# #          FAIL  enclave.remove_added_page_invalid_access_after_eaccept
# not ok 15 enclave.remove_added_page_invalid_access_after_eaccept
# #  RUN           enclave.remove_untouched_page ...
# Unable to open /dev/sgx_enclave: No such device or address
# # main.c:188:remove_untouched_page:Failed to load the test enclave.
# # main.c:1921:remove_untouched_page:Expected 0 (0) != setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata) (0)
# # remove_untouched_page: Test terminated by assertion
# #          FAIL  enclave.remove_untouched_page
# not ok 16 enclave.remove_untouched_page
# # FAILED: 2 / 16 tests passed.
# # 2 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
# # Totals: pass:0 fail:14 xfail:0 xpass:0 skip:2 error:0
not ok 1 selftests: sgx: test_sgx # exit=1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-47b2b7ca1ce4d1dbbaae0334436869c9e987d03c/tools/testing/selftests/sgx'



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250317/202503171507.6c8093d0-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


