Return-Path: <linux-kernel+bounces-358473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0334997FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3260FB2564B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E4E200129;
	Thu, 10 Oct 2024 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HX3niNu4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA98200121
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728546397; cv=fail; b=D2SFL4a72eMc616N4wep2v6OJGn+VuJoUrl/kfWgrb9CnRVhjkZSQbllAjkzb9/hV1wj1B2Btmh6slfN+jveiBzdZqV8Y1KaSH4xvsMne3lq1+wwut3/xFg92wshsCDDnC7ErUNXcqrUXK69UP5vNFgM6HQ8nk/8Pm/dQXRG8e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728546397; c=relaxed/simple;
	bh=42pDsWOVT0IsG9xXMMSI2GtkKHWEFYX0VnGAJ3HtIvw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=bYbLJTw45tYjqRM+Mu7GMasy4YJkyw7wfpuanh7gQMbmIyv4M0Xee7acKGnbEuYhmWI4u7uL05J2Hyt3SAFA8pbV0VUvHAq4nlhp/vzhX6cEM83d5poy1A1wriyPXNhhJC06kk0dATespORmjxqPP4Ott9S5vO6VVP9OsrvEEiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HX3niNu4; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728546396; x=1760082396;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=42pDsWOVT0IsG9xXMMSI2GtkKHWEFYX0VnGAJ3HtIvw=;
  b=HX3niNu4GDfYG3HSk6StTktoMaak6cljw9kUfr/XFHczXP7ZR2igNwng
   NflLFUsl0DIV4m3FSTFw6Tw2OilG+T/MIOR2lR5noS/SEky+TWVYsMapZ
   Qyc+QTFvglW6h/PFGaPBRB2sST43lv//+Vc3VG0zg3JBobyOhgwD1N7PH
   kKpcrtpwe5e0b4Yd0LkAOZDZi+WjJzM3ZHk+rwdhoMkvvQnVQUNf9eOMF
   S3zHJap+kc9fQsN7NK4JcKz3/QDO+D9p9gWDez6jPqXBl/HjvJaQkwXIr
   ctPjD9A4koQ81GVMkNrswXYJBxPz2EcIkas1gKkOGXVg10u4Qdv3qlGGH
   w==;
X-CSE-ConnectionGUID: 4BfYjun6TuSnu+43VabmcA==
X-CSE-MsgGUID: fEeUfZ2uQCuwjZTkjYG0Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28003252"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="28003252"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 00:46:35 -0700
X-CSE-ConnectionGUID: gOsLIppHRXmfQznW+6HhVQ==
X-CSE-MsgGUID: WWDrJQxTQFisYdeK+TRsdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="99835674"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 00:46:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 00:46:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 00:46:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 00:46:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2p2/3auaf6D5FmscGKQ8uGjbEJnggtf2GVFBHwD1hLBaLZkhj8ADqxAweFJIsePKtC06Jo1trIuIw5oNI0Y+4zqxD3wd7WXvwVzwuK6haKuV801LtDdE+eslP0gDcMlJ95wPc06xoTmgwBFaL2P9+DMw1j95c+yC7eCQHUsfYT09sR3zPQuNpZzh9pB/807L6JRMlOt0i0BQvOCrboctOrkDrzfvz2sO3HwoyxnO+k30joTfl//LgOFA9EotoBNxE0INQn2/06/ZsMxMzvfTvQGvp7PUU6bWDwCl1nn90o+6N28hp7zbH5BAe8xWCz9pZRPw9QHUK+DdHq0+8ej2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YZegb/2CUmyz2nLlp8lU1pcdspkJoC0fqjbQ5unmZs=;
 b=mkbtkAcwSe45LHx10MYHyZzvVAl3dibCmWzYJ136qXdbgCfezuc11JouU8OrwZgW+jLNooSU5n6jwwBQ3vvKHIM7u4s1lfR5HfxrR6AKGdp/GlsKxUDsoyT2JKjHzqex0isllDJslCub6hdRMNQCVSd642NerVLMDI9gKCK3BPoPJxvpAFWi43kClHicYNV+JeC/NY0Su8kyFEwcq2p+CD7BT/K8eK1bhb30CebGUDioo6rQqpQccQTx4MT4C75IeGhT5VZKwCfkz6Rc/+A1eUttzTEAbzR/RJoY6kqp+cfF6bjOuzcklfj/JW/k7mFE9EtvO8yDwuFURuJbyybFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7100.namprd11.prod.outlook.com (2603:10b6:510:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 07:46:32 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 07:46:32 +0000
Date: Thu, 10 Oct 2024 15:46:21 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Guenter Roeck
	<linux@roeck-us.net>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
	<boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Brendan Higgins
	<brendanhiggins@google.com>, David Gow <davidgow@google.com>, Rae Moar
	<rmoar@google.com>, <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [vbabka:slub-kunit-fix-v1] [kunit]  4b30efe586:
 Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN
Message-ID: <202410101542.ad347b41-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0189.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f8fd9a-4db2-4ad6-3eb1-08dce8ffa84f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZL9jpMsUQXphOPIF7SB6JgzvfcvdX+tyyniUoOFtC7lnvjPLwSUOO1dHwWfs?=
 =?us-ascii?Q?Q/twZEn6f7Hzldbpj4pWd+Qv0Ir6Sr4X/RzjTaL2WXcW8rFGiQm3Qa6UGWpA?=
 =?us-ascii?Q?06ixSbCe/uaNFJJBYaJYrXQX8Zl8QZMQhPzJB6Wu0UFQv0JlKN02m/e8fTDv?=
 =?us-ascii?Q?wqrqwCyhg8bY+an1h4va/pe8DT1nkOC/QrapOKfBEFM0yNFiJElyKoNgnfkt?=
 =?us-ascii?Q?YcU7EO76tRNYW0LHQlN6pjKqSBOBNdolji/Mtx8o3dRg7X0J9uUIXZ9oe2bz?=
 =?us-ascii?Q?yLLy+DkGSCdkeFuYl8g5iTWS6xBt8Y9MCRYVJrpUMFu+4+cnUMiLQMB6Gowu?=
 =?us-ascii?Q?hG+LGR7iovEDS+d9us6did//jePul8vlMbt7TDCmAXj4USyrhwi7dUlVaBW1?=
 =?us-ascii?Q?LlzER+yst6tEjcpcmigtiTA24XbaqT/QnGllzohkFg+xnSLqogJzgzNtVq4p?=
 =?us-ascii?Q?+votDi3iiz+zh6qW7zA5ElC0CRmrnFXVf2Bjexw3jDZ3mq8op1Bj48Ej0gi6?=
 =?us-ascii?Q?pu23kzeySggRdvX7hCDdGa1WEcG5hyPOXmb6v7+F0K48jU8Np3Za2L58l4dx?=
 =?us-ascii?Q?0EFol+OGGSt8jVk7aslVwedVstycVEpZhT4J0Qmld4NiMUrLX8rcrLV9FSYf?=
 =?us-ascii?Q?guoywPP6iZRZ6dUgN0MrtGnjWKhtF5XYdSITnIAiLGRM0XdUblwg7RicZbAT?=
 =?us-ascii?Q?HmTFJzssI0Uq8CxJXtZVmLxiLcQxgoUrvgTcRICbZzKfQyAJSZ5FwTiOaNvB?=
 =?us-ascii?Q?LTo6tUDwuQv6JmEOc2yAZwVq4+ilcc9XijRJMnL4uWq0cjokcZY2ddobFhJM?=
 =?us-ascii?Q?/+5vISL4xo12hnAiW6jbpxTZUiD+LugmwO7ZEUtUbvJ59cXM/v6AAt7c8+ZB?=
 =?us-ascii?Q?W4/JpMfzkM0CmD4bZ7w2POtFRGVaEVQbx/8Tl1GYNpbqFdpAoNXsDnGCOzEG?=
 =?us-ascii?Q?wGi7j57AEUmUHXQsZXl6DjKsISGRLTTA/5aXnRCKLqElYB3p9hKWjkXVTDMj?=
 =?us-ascii?Q?dMT7pXlmo2fAM8AJfurpqj06mx1Kz71YB8qrFcSYuPmC6DBOChLOYhtlZa2j?=
 =?us-ascii?Q?rG6JYpOPdXoqOATgRdVquWZs5d88AgjSTOVVXKhR6TC13ZlzWl5hhelS7Eyp?=
 =?us-ascii?Q?tPU3jzbwKRZGnLd0Ac/nQEwsZPQ70C1VbxJjxSBpuNyloeY0UGZ6bhE62Bj7?=
 =?us-ascii?Q?eqDz2FMR92Onb0cDBGKF1kWyCT/dg3WKgEYyHXAdmnHSjg9vawGanSDklFg?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gaUsolQ2BYaMPcGRN/AnAXWKdQoxiuBwmyUgB60X0imZ1U8WTsfNFlvsGzwD?=
 =?us-ascii?Q?BodYfwoLktEX3BA7DWLVSPISa7jcpNBlWDXWCn/ElehMDpIyRCdsNaYEuaFJ?=
 =?us-ascii?Q?Pi+5a4EvDSYMy8hnugwlCBWzYT/SNbxGvDcQXaeylBYZ9FW8o3DN9pgEBRK7?=
 =?us-ascii?Q?5EOCJhVLQjMaGTiccWfCMw2usJeAekESnwDYsMD9BZdFy/GZqaLZvHa52kmO?=
 =?us-ascii?Q?cqbAcB6F6Rq2yJMdJ7zOJwwdM/yHHBJZqihThCTIDuthBCXbG8m05WKkOutB?=
 =?us-ascii?Q?zwg614UZajOqLjn97ZDW0UR1aZPu7beL9UHY7xhLJ+Ohd+00CkAWPYca3QJh?=
 =?us-ascii?Q?CuVp8ilA7FvU5kut029ST6cP/3FjciNN+GgzsASI9hnlmq6zU5A2Q3l9F8Aq?=
 =?us-ascii?Q?I5ovg7m1uH4sptTeC7mqkfRl6cXGEU4Ct5B4S7uQl23KYctU4WPY6Sizl0tx?=
 =?us-ascii?Q?2IbnF/mJWQ82QJIHfA86cW8jqkyVCGEpjiyltKK8tLWx2oL1I1To8m/8dq/X?=
 =?us-ascii?Q?JaNkuJqQ9Hwft1lzQ9ys/POsXiIN3nJgV7yYS6m5ekWWYr2pMK42iUQ81EEt?=
 =?us-ascii?Q?3whkN0K1YLC6aIjahA0nyJpxGgeL1i4yk2J1b5jX/DgjIArc89fPIbl16KcV?=
 =?us-ascii?Q?Vh3jK9pvno6cGR0DlxOSz0uDWSN544p0dGX0ADiVuQgZd2AP2X+SmTfKwyi5?=
 =?us-ascii?Q?ayv1FOeyEnjNvJP0DPmkK4Ko/GtbEmLJKo3JPTsrpu1Q1KiIXcVg+qmz/W5A?=
 =?us-ascii?Q?98cdopGeT5+JXmJZb5cfFkysQaMmsC9KusXYmgeJukGH97Vr23M98NFiAFH7?=
 =?us-ascii?Q?FDMKQXg1Ls32qOJFVg521fFmoQ+uGk+fLpN32XfEItes0q7CofiC4HnOrVkN?=
 =?us-ascii?Q?duKGWNrkhsLEjbCLE2BIQV8LQJjySTiLyBJLlp335OfdABCj9japW9IyUkji?=
 =?us-ascii?Q?KmrmtaNKwSBDOHnkD3kI8acxCYCNzP0qWYOUbNp0Gspc9oTuKPb14o/T52EN?=
 =?us-ascii?Q?Fwf0oR+yk8cS9yE+y98Y5jb01zO7+vNpwW7z4lFnrclwRCr6eH2rHGnXiGUH?=
 =?us-ascii?Q?pV9ZsnXoUv6CgPyGVznnIzESeJoj0QAQ34XQsBOCflqroqmM+0uqooKMYujI?=
 =?us-ascii?Q?NWW5Xj6NT8xWBvpQAC4s09VUGUMjoMiPODmjeAH1keArnmj6mMWMoXVjGfOP?=
 =?us-ascii?Q?KCTwC9+wB9RJ+fAg9Y2vM/4ijFCYV9fg54JpJPAWjyHotFJgdwIE6ATrwLhC?=
 =?us-ascii?Q?RzSEGpGyiBzUNcq1Uy9X9cgYojOHUCEI00qk/vK7QAjbo6C8v6QRpMMsbPMH?=
 =?us-ascii?Q?JZwJxzpDlvJAFfnjl66mPrHBPJQclAadYHWWBnuZnapm+aT7KEiVALxaYgOc?=
 =?us-ascii?Q?ByrbEceu3ZoHEhG9VpdttkAfd+GlEpAVF2X2jEK4wDhm4ko880t01V2JCTk5?=
 =?us-ascii?Q?+QAHwtBr9eANB0JKrRqQExDLeIBCUpYMTqggcCRnjIurnESE9IS1fH8OrErG?=
 =?us-ascii?Q?BVrhWSJumwluoMpSW+GEgJm+GtEiWIB7yFEnyiVbSxNbpLQHISC+UnXIp7Xv?=
 =?us-ascii?Q?OD3lodJaM8SF3CiVK0YyPlR/gDIXqrKVDw+c7JNJbMOTekl7V3wu6O3sIdLb?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f8fd9a-4db2-4ad6-3eb1-08dce8ffa84f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 07:46:32.0736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spKqw2QUuCrvHA8pPHh8TMincWt1dbdxEGR5iE+mZArOC6PM/xohGZ4YuAwVGJkat/VKwFbQoOaLSsFGt1gB2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7100
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN" on:

commit: 4b30efe586f89319cc6d258ca11022273e33657a ("kunit: move call to kunit_run_all_tests() after rcu_end_inkernel_boot()")
https://git.kernel.org/cgit/linux/kernel/git/vbabka/linux.git slub-kunit-fix-v1

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------------------------------+------------+------------+
|                                                                                  | 2c61269169 | 4b30efe586 |
+----------------------------------------------------------------------------------+------------+------------+
| boot_successes                                                                   | 12         | 0          |
| boot_failures                                                                    | 0          | 12         |
| Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN | 0          | 12         |
| KASAN:maybe_wild-memory-access_in_range[#-#]                                     | 0          | 12         |
| RIP:kunit_merge_suite_sets                                                       | 0          | 12         |
| Kernel_panic-not_syncing:Fatal_exception                                         | 0          | 12         |
+----------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410101542.ad347b41-lkp@intel.com


[   26.739545][    T1] PM: genpd: Disabling unused power domains
[   26.749167][    T1] Freeing unused kernel image (initmem) memory: 5116K
[   26.749818][    T1] Write protecting the kernel read-only data: 186368k
[   26.752543][    T1] Freeing unused kernel image (rodata/data gap) memory: 496K
[   26.859076][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   26.859779][    T1] Oops: general protection fault, probably for non-canonical address 0xf9999599999999e2: 0000 [#1] SMP KASAN
[   26.860605][    T1] KASAN: maybe wild-memory-access in range [0xcccccccccccccf10-0xcccccccccccccf17]
[   26.861265][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc1-00003-g4b30efe586f8 #1
[   26.861938][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 26.862671][ T1] RIP: 0010:kunit_merge_suite_sets (kbuild/src/consumer/lib/kunit/executor.c:315) 
[ 26.863128][ T1] Code: 8d 3c c4 4c 89 f8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ff e8 03 12 61 fe 4d 8b 3f b8 44 02 00 00 49 01 c7 4c 89 f8 48 c1 e8 03 <0f> b6 04 18 84 c0 75 12 49 63 c5 41 c6 07 01 44 8d 68 01 49 39 c6
All code
========
   0:	8d 3c c4             	lea    (%rsp,%rax,8),%edi
   3:	4c 89 f8             	mov    %r15,%rax
   6:	48 c1 e8 03          	shr    $0x3,%rax
   a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
   e:	74 08                	je     0x18
  10:	4c 89 ff             	mov    %r15,%rdi
  13:	e8 03 12 61 fe       	call   0xfffffffffe61121b
  18:	4d 8b 3f             	mov    (%r15),%r15
  1b:	b8 44 02 00 00       	mov    $0x244,%eax
  20:	49 01 c7             	add    %rax,%r15
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
  2a:*	0f b6 04 18          	movzbl (%rax,%rbx,1),%eax		<-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	75 12                	jne    0x44
  32:	49 63 c5             	movslq %r13d,%rax
  35:	41 c6 07 01          	movb   $0x1,(%r15)
  39:	44 8d 68 01          	lea    0x1(%rax),%r13d
  3d:	49 39 c6             	cmp    %rax,%r14

Code starting with the faulting instruction
===========================================
   0:	0f b6 04 18          	movzbl (%rax,%rbx,1),%eax
   4:	84 c0                	test   %al,%al
   6:	75 12                	jne    0x1a
   8:	49 63 c5             	movslq %r13d,%rax
   b:	41 c6 07 01          	movb   $0x1,(%r15)
   f:	44 8d 68 01          	lea    0x1(%rax),%r13d
  13:	49 39 c6             	cmp    %rax,%r14
[   26.864463][    T1] RSP: 0000:ffffc9000001fe40 EFLAGS: 00010a06
[   26.864908][    T1] RAX: 19999999999999e2 RBX: dffffc0000000000 RCX: 0000000000000000
[   26.865480][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   26.866060][    T1] RBP: ffffc9000001fea0 R08: cccccccccccccccc R09: cccccccccccccccc
[   26.866640][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881451e7000
[   26.867222][    T1] R13: 0000000000000001 R14: 0000000000000001 R15: cccccccccccccf10
[   26.867800][    T1] FS:  0000000000000000(0000) GS:ffff8883ad800000(0000) knlGS:0000000000000000
[   26.868425][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.868896][    T1] CR2: ffff88843ffff000 CR3: 000000017491d000 CR4: 00000000000406f0
[   26.869465][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   26.870038][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   26.870617][    T1] Call Trace:
[   26.870865][    T1]  <TASK>
[ 26.871081][ T1] ? __die_body (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:421) 
[ 26.871400][ T1] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:?) 
[ 26.871706][ T1] ? exc_general_protection (kbuild/src/consumer/arch/x86/kernel/traps.c:751) 
[ 26.872119][ T1] ? asm_exc_general_protection (kbuild/src/consumer/arch/x86/include/asm/idtentry.h:617) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241010/202410101542.ad347b41-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


