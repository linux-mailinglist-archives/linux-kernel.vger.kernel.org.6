Return-Path: <linux-kernel+bounces-259518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6899397B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 03:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7D61F22264
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 01:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F86132111;
	Tue, 23 Jul 2024 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BpXXzUCz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861A314286
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721696728; cv=fail; b=iWGy45KThnUXUVuYEhG6BFE1Zar8lkrMshAiBzfzgBdXI6NVz9vwmcmHc3Cish8X3Y9cDYh+98JuCCzUTDIM7jvnVtRE8+7dDKr6Bd4HAUEf3Hn54Us8rU/hyasGeFoPxDlgVaTQSkWySkcBbdPXC5SnflLTYxAQSQ9vNzXDzr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721696728; c=relaxed/simple;
	bh=L2cuL/jbzEibiuOBhjle95FffPOvmyr9ofldJ08RbZ0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=GIGgBmhX5pGNrAA8HSeHrcQef0QvHIhZsZYOC+9hHYENuFN5itbodrgpTFYycUB8o51vtBYNvaZLzCzO7eS5fsdPF1jHbh7JSgkw59mlbr/8wpb6sb/ZSznrcibf3lLmMEO4xrFwAJFgwjKAc5PXB7h7sNdcrm4P355efQyCfFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BpXXzUCz; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721696727; x=1753232727;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L2cuL/jbzEibiuOBhjle95FffPOvmyr9ofldJ08RbZ0=;
  b=BpXXzUCza3pZh//JqdzylPB417mO22dpLorCOxd5ax4l2SnZOX+aaubM
   YC2d3O/XwsOOmvR1h2u3qoqxH5Sy8InO19f995c6GNWpu/ONaRapyZwRh
   0WWKovGxvaqxmVBXWuMfG5z3R/Vm1h0OPQWlqDWEBTHig/IK6WS7IR7Za
   +xqewJJVqmc9ZnMVCqrNdu6lew4YQkeXsh/S3PvtOW5Hy1GSplHwZhRGa
   hZ8EFYLYNYZzgCk38LuewmSKpQiSyLGAiGi2vkqEuAENjhIL9ukJdMd9j
   H9AABnDZJk/BcB4Vd+L5HCruF1bEZGoFxCnfTEhxIysgVD+aUVM3ZtjSE
   A==;
X-CSE-ConnectionGUID: MVxhKtDIR4yPeOcGpYDMOA==
X-CSE-MsgGUID: 2RLfd6RCRye7UBUax1Zchw==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="30683719"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="30683719"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 18:05:26 -0700
X-CSE-ConnectionGUID: LAvqeaq5QW2wVBwW7e5mvw==
X-CSE-MsgGUID: rWBKOHo4Tu2WlaVHSVvjGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="56899161"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jul 2024 18:05:26 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 18:05:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 18:05:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 22 Jul 2024 18:05:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 18:05:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SC+IRBLkAYo42cxx+z3brVw13zsXosnbpRZzruGjc0+9eVC1ciKbJ1SjncIyFsH5ktoP3atV6IWHiSUluG5u5hd8jY6vqifZLcxQlPxsox0ywfxp67dmtdOxMxNF3Vtb0i3JabiWLGWeQ44ROqp/4qe0Rup40nm9vTCnZtq89WtRG9Rp4ofGzvQYg5F+jkddbtX1wvigNTRza90pan1iuYY+EeTZSrtg67YuxUxCgtwSCSRVuC9JQECsJa2jgb3/tJfrdKKkC7v61FRlLR5kgCBYfuc+x7eVYZbgl7YGo5XS8ghOTHtFP0ZmCbagmpaWWPg3J5ItJQdRaSCYN3p0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaajpaGm8YvCw8CuodUhBHsxPoILQNmnEnTJTQzsZv4=;
 b=itvHEH3BnCPkPUCAkF/htGZV+Nr6wWulXZHmn42NF+0RZohINg3ByR9mCFyXgfbGhDB7O8v6Gu+32UswMZaQ2m+mavT9FAG6lqSnCekepJ/VkiPK9stqrGwPcbm8nxcU3eNI73RJ7oFLl0mo7l7ymljqbdKXnxaiL3bOWGjK6rF25j90L20P/zL18XZzb8kIZfGcMXGPEpq0PL7y/nAXSzMrpBbedBXDnysIuuG65gG1HMqJjDli9RMikWjDF0mmVMLh3a2zQi3oGu0iXQQiROLY/mbpkHCy2fZ1OEtrKxGO/I/S9kVCcTZykh4cSH9Y7Bh0Blu13DbBLJUgAEo+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN0PR11MB6033.namprd11.prod.outlook.com (2603:10b6:208:374::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Tue, 23 Jul
 2024 01:05:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 01:05:21 +0000
Date: Tue, 23 Jul 2024 09:05:12 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Alex Shi <alexs@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [alexshi:mmunstable2]  934c05f8c5:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <202407221607.49138a71-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN0PR11MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 0093a85b-fdda-4de5-87d8-08dcaab386a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1/xTJBcOl4PuZOEA6ngECk+g1MGnR8d1hj71d4i1L0YgDNfK8docRIGwkkyx?=
 =?us-ascii?Q?2qRodKGkDC9Ferlrmc6UtyHLl0EpK4e3ZWgtCzM7Wd0HEVoij6+On5vSl3HS?=
 =?us-ascii?Q?R/vmnE+HG3ZyAP+/Z94NNp738HXeCRmXxuMdZkhS7Uxv1N6/FM0OeA/a7K9U?=
 =?us-ascii?Q?q33cD/6T78FasQP11NevCZlZquDkqeez4tCzcWIgxePnw10KODh/Do+8kv2F?=
 =?us-ascii?Q?Yfmt83TZrVdkIUNsKnACCrS4f3VfLu/YwwsSwkeTp02aCvnAChoRdQi7S6E0?=
 =?us-ascii?Q?nwWGoYp4p1ixY4dLYOaOKGfQVHI8UyHgOP1kGn8fh+VW2KOagH+3kJy2Gfg1?=
 =?us-ascii?Q?B4lNTHTb3uFm9PWOP/tihGSz/3hq78Kosybdu4y7u7el4wJv2sdDfraIdjvI?=
 =?us-ascii?Q?GFwgQJ5TOCNye6YWlt1a/TUs8sBAQ+0hB84o+Lfo6aX+n2OQRo/BS7mSR1dM?=
 =?us-ascii?Q?0uAWktLKEN/o1xligzm7A06TpYhciSMEhpxhTtHooeWPbk4WWeSIMmrwcsh8?=
 =?us-ascii?Q?CRV/UA+R+FhYA0MeoXrpcon07shFbKqT1/OxLhb6EG4n5gZ65RyyOKcGL26l?=
 =?us-ascii?Q?WO+Sy+VaA9sn+diFCnucqliYMVeqwJx7YhlPU0niqh4XmlAYXptglZK5VBqs?=
 =?us-ascii?Q?Vu5zM34gCMRkkuyV/yWfiNhCQMTYLatj0CLCAoVRXffIlqm4Lv7WK5PZWUV8?=
 =?us-ascii?Q?Pl1non8r36Jvqavp8U2usn5eyBlA/X9kK/hYbr7pj87HGmcI5GcNBU1DJEI0?=
 =?us-ascii?Q?e2e0qfRfa4o7oysO/vXRa35Vm5Ts71FtyueWhOs7zKZBYiMUdiP5l8p9qi2Z?=
 =?us-ascii?Q?RhCp0XBKME92eCNk7kLixJRIAh2Y4GhKbEHSAptE9BUJI/Yfs9Xo48XS0cG7?=
 =?us-ascii?Q?kzsZ/wIiFOkzJYSOtDk0wtaoJUkqiBeU6VZIN+Pfn1J1VQa/ezGwFHo0m4Xo?=
 =?us-ascii?Q?+UCv2xl4+Av5F+j0BsMwS9zZIkQVfR1A5VldsbpA7MIH14hm8m6LKoc1Ag/x?=
 =?us-ascii?Q?BSA2qABLUfLl4rY6ZU3JjfquaZeLswQGGtDlyV0nmyohvMB+YmfcpvxsLuwf?=
 =?us-ascii?Q?74+cVY7JtlhLW5Bn4dOOv8tkDn76Gj4UUJBngGTieoOU6i+DzMcBGISxcUW0?=
 =?us-ascii?Q?eIkKgSCKckjUcLrLPZqjrmlfE88dES4su0zistFI8mjfMtXXVHW2QSmqNScr?=
 =?us-ascii?Q?3k22dhCUBAY1KkyOepwn1eveYiTfIZFsv/J1ym+V8OAkCIKYd+Qz7DyOQWyx?=
 =?us-ascii?Q?6RiKxYkw1z+PDdgV7PU+7w7TMV3uwXI0lh/TWddLikztimmLyF3Z51bNCMTB?=
 =?us-ascii?Q?GKg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qtqTeQEx0b2DoqVn0V14NdTEoKFHZ2f2Cvj5aLYTkZ8/Cp1SyUlHkdIMju/8?=
 =?us-ascii?Q?CSlNnNIPbRrqtN9LJDPsPtzD3cGFFzeg7GPAojfbDOkaH9KnJQYwPsA3mdq6?=
 =?us-ascii?Q?TDpQCe5GN7n80z6zFGh/sx44lJWUc4FFAZTaL9RmtPsYb73yDYINs1ZfbrA8?=
 =?us-ascii?Q?WKTkHNnmTZrOT2IyoNSZigr3T+wN/q+mevbaDfEcYCXIJ8AsAdCFYGv+Bozb?=
 =?us-ascii?Q?ASqf0s4KqGCdOy2kCIkkpKkN55LwZGMCOlcC8mmtD03Cs6e0mqyCkNfZtpjp?=
 =?us-ascii?Q?uvzBfCXt0ykGelmEtt7m5DxGJ4wn5pwjrR02cBiFcHd/GTz6foH04vB74cLJ?=
 =?us-ascii?Q?0lqg4RPHvjJjqR1XfJLIFSpuBcCcJiYuqLjg3SKq6lX5Y2X/g9l/VyTMyXIi?=
 =?us-ascii?Q?P04mkiiMkPMT36qP+iDBkaJ+aBf/YXTDukaq0zQiaroKqHrBAfATotSltRMK?=
 =?us-ascii?Q?FiwxyqkreoVpBkx3jjX9QVu7YLqjJ8zFfQc+iA6BeAybUUz/0opcwKAY78EV?=
 =?us-ascii?Q?IRy07CW1/wE9SSfa5GlklDOnosZGfWyPK/1SWuLWUDSLkj+ZijjHu69lvKf+?=
 =?us-ascii?Q?VlE3vdzneOgizfvBBFi1MmvZpkdv8+rAr73Au9SdM09uNUkbk5oC7B6jqhZJ?=
 =?us-ascii?Q?burj83WeXcXnAEh2E3v3z1ghKS/IzYd/7f/lhfR4AVRHf9MnlKAtqJV719VM?=
 =?us-ascii?Q?pv/XVq3Y9FAUF0XCdTQgCeePjyXTJn5PtXks+a7QcI8cz0U7JuvQXZLh6zoH?=
 =?us-ascii?Q?Iol1+xyUm15+NyldrWSuT3/EE9agZMkh+8PXPNYiFh8KnBdxUJz6usN1OlKS?=
 =?us-ascii?Q?tuj2Lxt/L0PtsNSkz+1qLbBGrcSfLvSzbSnaXfBIZ6I2lTPAnqu9JjjWctgJ?=
 =?us-ascii?Q?7wb2EeU5K8J/ULtHd4eME/UHh2uaEC4hZz5Wxx2iUTSsd+hV/GNwr2uMgY2C?=
 =?us-ascii?Q?flSSEhzM7us53n1p7Wbl8302emv40wmwKOa1YmNXmvPx4TPDP2a85z5tzet0?=
 =?us-ascii?Q?ca3Gqy71Cppd1vUPv9rlUppps3JSXowHHPAU8snSgCFwisqUiTkl6Cc4wijh?=
 =?us-ascii?Q?j87cLV7fbFcTA0LybeIydc7a8oWxcBVSw/qNZIvFdLxP9Auq3emGiTuzbb7T?=
 =?us-ascii?Q?7YsZVktumX0X2IfGBsIaPk1plC7PwXsctwsajDAoKdgpXqG52PUUofQzw148?=
 =?us-ascii?Q?NcnqVHzaicX8vDINlTDqOoq9JJGALzOwjNtkeZA7pLtjvtjXiRsqbNT7+S+C?=
 =?us-ascii?Q?75RJu1H4PRaQ9hk3RY76RXSuXb9SVVSR/WZBKDP/0VHyRkxAzFvV45chsB0B?=
 =?us-ascii?Q?MlJtwpaqIwt8rzhn/JeDqbMubCtxAVduYukQsL6qDFIGu6lcGM5nbhZ0hi4E?=
 =?us-ascii?Q?2AL07ei1o16Zd1NyYahU0fSVyHVr2hIdbipZOANDTdz9txcMo/DWd9fvxrVH?=
 =?us-ascii?Q?8Fy7AO0SC2PPe3vk28GTICIurKrWlFbKpsqZxX9yEffup/D9RgTQXbZrBkFL?=
 =?us-ascii?Q?urw+xBFrbSix1B5SIvqS6vNuJDLhjoG4mWfafX3Ke6oTnu7pA79QwQObe9Nn?=
 =?us-ascii?Q?7lWzNLCI3kqLyqrMOr/wXbgQaNU+lE++mOi+rIG3FKu5WFASrA7HpsOIvAnV?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0093a85b-fdda-4de5-87d8-08dcaab386a3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 01:05:21.5891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhD+vSpzpk0ZWjgC3RBK87NDDy+4fDLr258/5RRUUSJxOjMNaCWwc2PRIs0uYte9TVMfhgZbC63jAtZLu0lcbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6033
X-OriginatorOrg: intel.com


hi, Alex Shi,

we noticed there is a mmunstable3 branch now, but there is no same title patch
there. not sure if this report is still useful, below report just FYI.



Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: 934c05f8c50fed91942a8aa9db46a0feae38594c ("use ptdesc in free_pte_range and pte_free_tlb series functions")
https://github.com/alexshi/linux.git mmunstable2

in testcase: boot

compiler: gcc-11
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | 5977eb9785 | 934c05f8c5 |
+---------------------------------------------+------------+------------+
| BUG:unable_to_handle_page_fault_for_address | 0          | 6          |
| EIP:clear_user                              | 0          | 6          |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407221607.49138a71-oliver.sang@intel.com


[    3.645340][    T1] BUG: unable to handle page fault for address: 00100016
[    3.645713][    T1] #PF: supervisor read access in kernel mode
[    3.646020][    T1] #PF: error_code(0x0000) - not-present page
[    3.646326][    T1] *pdpt = 000000002e992001 *pde = 0000000000000000
[    3.646663][    T1] Oops: Oops: 0000 [#1] PREEMPT SMP
[    3.646933][    T1] CPU: 0 PID: 1 Comm: init Not tainted 6.10.0-rc6-00481-g934c05f8c50f #1 c5190225c17d1f7c5bcc60b13088ed2c9e32ac25
[ 3.647536][ T1] EIP: __lock_acquire (kernel/locking/lockdep.c:5006 (discriminator 1)) 
[ 3.647797][ T1] Code: 8b 75 d0 e8 d8 9b 3c 00 85 c0 0f 85 a0 01 00 00 31 db 83 c4 38 89 d8 5b 5e 5f 5d 31 d2 31 c9 e9 60 6d be 01 8d 74 26 00 31 c0 <81> 3b a0 cb 44 c4 0f 45 45 0c 83 fa 01 89 45 f0 0f 87 10 fb ff ff
All code
========
   0:	8b 75 d0             	mov    -0x30(%rbp),%esi
   3:	e8 d8 9b 3c 00       	call   0x3c9be0
   8:	85 c0                	test   %eax,%eax
   a:	0f 85 a0 01 00 00    	jne    0x1b0
  10:	31 db                	xor    %ebx,%ebx
  12:	83 c4 38             	add    $0x38,%esp
  15:	89 d8                	mov    %ebx,%eax
  17:	5b                   	pop    %rbx
  18:	5e                   	pop    %rsi
  19:	5f                   	pop    %rdi
  1a:	5d                   	pop    %rbp
  1b:	31 d2                	xor    %edx,%edx
  1d:	31 c9                	xor    %ecx,%ecx
  1f:	e9 60 6d be 01       	jmp    0x1be6d84
  24:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
  28:	31 c0                	xor    %eax,%eax
  2a:*	81 3b a0 cb 44 c4    	cmpl   $0xc444cba0,(%rbx)		<-- trapping instruction
  30:	0f 45 45 0c          	cmovne 0xc(%rbp),%eax
  34:	83 fa 01             	cmp    $0x1,%edx
  37:	89 45 f0             	mov    %eax,-0x10(%rbp)
  3a:	0f 87 10 fb ff ff    	ja     0xfffffffffffffb50

Code starting with the faulting instruction
===========================================
   0:	81 3b a0 cb 44 c4    	cmpl   $0xc444cba0,(%rbx)
   6:	0f 45 45 0c          	cmovne 0xc(%rbp),%eax
   a:	83 fa 01             	cmp    $0x1,%edx
   d:	89 45 f0             	mov    %eax,-0x10(%rbp)
  10:	0f 87 10 fb ff ff    	ja     0xfffffffffffffb26
[    3.648776][    T1] EAX: 00000000 EBX: 00100016 ECX: 00000000 EDX: 00000000
[    3.649136][    T1] ESI: 00100016 EDI: 00000000 EBP: c01f1b7c ESP: c01f1b38
[    3.649504][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010046
[    3.649890][    T1] CR0: 80050033 CR2: 00100016 CR3: 0054bd80 CR4: 000406b0
[    3.650252][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    3.650611][    T1] DR6: fffe0ff0 DR7: 00000400
[    3.650863][    T1] Call Trace:
[ 3.651036][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 3.651256][ T1] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 3.651457][ T1] ? oops_enter (kernel/panic.c:642) 
[ 3.651680][ T1] ? page_fault_oops (arch/x86/mm/fault.c:715) 
[ 3.651927][ T1] ? __lock_acquire (kernel/locking/lockdep.c:5137) 
[ 3.652177][ T1] ? kernelmode_fixup_or_oops+0x68/0x8c 
[ 3.652513][ T1] ? __bad_area_nosemaphore+0x133/0x238 
[ 3.652850][ T1] ? bad_area_nosemaphore (arch/x86/mm/fault.c:835) 
[ 3.653116][ T1] ? do_user_addr_fault (arch/x86/mm/fault.c:1452) 
[ 3.653389][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4300 kernel/locking/lockdep.c:4359) 
[ 3.653693][ T1] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
[ 3.653952][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
[ 3.654265][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1054) 
[ 3.654524][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
[ 3.654838][ T1] ? __lock_acquire (kernel/locking/lockdep.c:5006 (discriminator 1)) 
[ 3.655087][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
[ 3.655400][ T1] ? __lock_acquire (kernel/locking/lockdep.c:5006 (discriminator 1)) 
[ 3.655650][ T1] ? register_lock_class (kernel/locking/lockdep.c:1285 (discriminator 13)) 
[ 3.655916][ T1] ? filemap_get_entry (include/linux/rcupdate.h:339 include/linux/rcupdate.h:812 mm/filemap.c:1858) 
[ 3.656179][ T1] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756) 
[ 3.656408][ T1] ? pmd_install (mm/memory.c:424) 
[ 3.656638][ T1] ? slow_virt_to_phys (arch/x86/mm/pat/set_memory.c:811) 
[ 3.656896][ T1] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 3.657130][ T1] ? pmd_install (mm/memory.c:424) 
[ 3.657451][ T1] pmd_install (mm/memory.c:424) 
[ 3.657669][ T1] finish_fault (mm/memory.c:4870) 
[ 3.657902][ T1] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63 (discriminator 13)) 
[ 3.658156][ T1] do_pte_missing (mm/memory.c:5100 mm/memory.c:5193 mm/memory.c:3947) 
[ 3.658398][ T1] handle_pte_fault (mm/memory.c:5522) 
[ 3.658647][ T1] ? __lock_release+0x4f/0x17c 
[ 3.658921][ T1] __handle_mm_fault (mm/memory.c:5666) 
[ 3.659174][ T1] ? mt_find (lib/maple_tree.c:6952) 
[ 3.659394][ T1] ? __handle_mm_fault (mm/memory.c:5800) 
[ 3.659656][ T1] handle_mm_fault (mm/memory.c:5745 mm/memory.c:5832) 
[ 3.659897][ T1] ? lock_mm_and_find_vma (mm/memory.c:5921) 
[ 3.660167][ T1] do_user_addr_fault (include/linux/sched/signal.h:425 arch/x86/mm/fault.c:1391) 
[ 3.660426][ T1] exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
[ 3.660663][ T1] ? find_held_lock (kernel/locking/lockdep.c:5244) 
[ 3.660905][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
[ 3.661221][ T1] handle_exception (arch/x86/entry/entry_32.S:1054) 
[ 3.661478][ T1] EIP: clear_user (arch/x86/lib/usercopy_32.c:66) 
[ 3.661712][ T1] Code: 34 b8 00 00 00 c0 29 d8 39 c7 77 29 ba 42 00 00 00 b8 63 1d 95 c3 e8 fe 6f 5c fe 89 da 31 c0 c1 eb 02 83 e2 03 89 d9 8d 76 00 <f3> ab 89 d1 f3 aa 8d 76 00 89 cb 89 d8 5b 5f 5d 31 d2 31 c9 e9 4a
All code
========
   0:	34 b8                	xor    $0xb8,%al
   2:	00 00                	add    %al,(%rax)
   4:	00 c0                	add    %al,%al
   6:	29 d8                	sub    %ebx,%eax
   8:	39 c7                	cmp    %eax,%edi
   a:	77 29                	ja     0x35
   c:	ba 42 00 00 00       	mov    $0x42,%edx
  11:	b8 63 1d 95 c3       	mov    $0xc3951d63,%eax
  16:	e8 fe 6f 5c fe       	call   0xfffffffffe5c7019
  1b:	89 da                	mov    %ebx,%edx
  1d:	31 c0                	xor    %eax,%eax
  1f:	c1 eb 02             	shr    $0x2,%ebx
  22:	83 e2 03             	and    $0x3,%edx
  25:	89 d9                	mov    %ebx,%ecx
  27:	8d 76 00             	lea    0x0(%rsi),%esi
  2a:*	f3 ab                	rep stos %eax,%es:(%rdi)		<-- trapping instruction
  2c:	89 d1                	mov    %edx,%ecx
  2e:	f3 aa                	rep stos %al,%es:(%rdi)
  30:	8d 76 00             	lea    0x0(%rsi),%esi
  33:	89 cb                	mov    %ecx,%ebx
  35:	89 d8                	mov    %ebx,%eax
  37:	5b                   	pop    %rbx
  38:	5f                   	pop    %rdi
  39:	5d                   	pop    %rbp
  3a:	31 d2                	xor    %edx,%edx
  3c:	31 c9                	xor    %ecx,%ecx
  3e:	e9                   	.byte 0xe9
  3f:	4a                   	rex.WX

Code starting with the faulting instruction
===========================================
   0:	f3 ab                	rep stos %eax,%es:(%rdi)
   2:	89 d1                	mov    %edx,%ecx
   4:	f3 aa                	rep stos %al,%es:(%rdi)
   6:	8d 76 00             	lea    0x0(%rsi),%esi
   9:	89 cb                	mov    %ecx,%ebx
   b:	89 d8                	mov    %ebx,%eax
   d:	5b                   	pop    %rbx
   e:	5f                   	pop    %rdi
   f:	5d                   	pop    %rbp
  10:	31 d2                	xor    %edx,%edx
  12:	31 c9                	xor    %ecx,%ecx
  14:	e9                   	.byte 0xe9
  15:	4a                   	rex.WX


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240722/202407221607.49138a71-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


