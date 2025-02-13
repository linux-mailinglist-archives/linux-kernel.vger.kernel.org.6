Return-Path: <linux-kernel+bounces-512298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81301A3373C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE7A3A6122
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 05:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558D02066EF;
	Thu, 13 Feb 2025 05:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPd4Cyfq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5333E205E06
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739424494; cv=fail; b=J+3sGQ4qtyTudC2CgpdGOdV13isxnmkY3OvqYPybZ/rwHb22paXfjUzh4xBU9NU0cL4mtmqm9KKiUZmiHqf6bkbEtkrn+hkIFJ2fTyyn5EQMaAQYyqIyQ9A39/KB2n2J6GOoUAbrC1o6BhP5F5+GZxwO6kvRyrgmYgmkg9bwZO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739424494; c=relaxed/simple;
	bh=Lj3+WlvyHQGfzWHmDYTh/ZmNQE7W9W8UtNhmDp+Ms1w=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=OgJdzflHHlUMMmutiB8WvYVEQAGnDbQNVV8ACcLKjcvo5JGvsqqgoO175AQCuIYBsJqqHt2uLeF++y01lYUCK5R+5Ww7yjRbcfMrx2dx13hilCpcTkazFqHouS5hQ8IhuO5uasMXdjzZ2IEBZy23k3lzRNIQQrXt4FMBJblQAqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPd4Cyfq; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739424492; x=1770960492;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Lj3+WlvyHQGfzWHmDYTh/ZmNQE7W9W8UtNhmDp+Ms1w=;
  b=RPd4Cyfqv0FXhczDFDBGX3lDarzyvATmecKLfXQ3L6P3ADMZ/iWZITIY
   Km7ixKAF+mw6zuvCGO/7tVGy5RV2bHW3YprAV371hQwy/QLehykiPNNcU
   GHwPaD8wu5gvNbxWLe9Llpl/naB6+CA+mTIrWVtspatzJAui6XCNRtk0b
   epwY82Dl6bBZ+Svd6TuUcwHC/IjXmj7dQommPDMZmeF4cz0Wl26mLL7ur
   tAJv5zATww3MFGoeayr4H5rg8OfM72oTvWNZ8tKNAkm1ziJuJ7pAeSK5x
   HYrS1bCB2lV1f9s24t3xD/r0KlmA2DpF6PmyTeYrdFqoiOYrygxGbXKi1
   A==;
X-CSE-ConnectionGUID: jNE6ZnSzQyuUEXDd1Sat8Q==
X-CSE-MsgGUID: YlQEbi8kTZWpecttHBXJXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="43764479"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="43764479"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 21:28:12 -0800
X-CSE-ConnectionGUID: LPpivtxjQm2noI9360SvTA==
X-CSE-MsgGUID: Xm7XwTLtTtqybsN1Mm08HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="112895661"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 21:28:11 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 21:28:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Feb 2025 21:28:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 21:28:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhmG+YilajsZ17++Wk8iV3YQXPYVOtVKFdYhhbVz2RrUITONp2s+GDAHBrnqbk3WhZlYTnP4VxJ/FnkKEw98xcDoPKWx3Hpo/XZlkAN1N98rN4X6XQaHgZwxUrHYIvfgzLFZi32QIZOocpaHcxqBAQXxF90lx+7VwpG8hg8ybE78SS20Eo6Yt3B37YCrV2J1LQ4Xc7rtrKXcvypbq0KkXxm4XgEKFbRCYB1EXp5AsLSxqtsOdfCz85/HBEV5paCbgIBnzujtyDeAjiM45vdKA8CJpwOnHFYm6MD1ocXFtpC77bS6PCySnPwNG44FbOsNHAI25XK36WK/CzYY1Ss9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xKbJb5kUHwxbRRY6CHFnuRzyRXOoONZqvuC9rXwSGk=;
 b=TpjyTcAEb5PLM8w1MrE2EveRwJXOxW0JaG4rI+Lv67SyDsEslxiBAJfj2HKuDMzUmudGhUAs5pOSL4ZF00k+n0SD7GtdaVVOUQ+1G8vnZpThMjMtae3SrCLUbc4Z/4hC6PeJOTTNlnXW121DB2QW4hLAG+q6yds16aQDpyjov35hULbD9/QIbv4nMsJGO39BgpeYBgAkAbiiiBKGEE9eXEQdIFq6MkU8COk35H/p7jCm+K6M9e2Dnj+UcCsb2fu+aQVNOLQTPlymcATI4iv2LEZI0B3IU4hQ170YdnBuMfvE4MbsGw6oHybQmMpgejHM/X8zfp/s05E4dUVVcwzMsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by IA0PR11MB7742.namprd11.prod.outlook.com (2603:10b6:208:403::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 05:28:08 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 05:28:08 +0000
Date: Thu, 13 Feb 2025 13:28:00 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
CC: <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: ld.lld: error: Function Import: link error: linking module flags
 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)'
 and 'vmlinux.a(xprtsock.o at 797124)'
Message-ID: <Z62C4NRymp/I4Bfz@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|IA0PR11MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a92433-121b-40ab-f1fa-08dd4bef331f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yzMU/68ZIlkj70p0a9dnMr7EZjMdSQ8GvleWw+RRhf7r7df1VyxIirNQfeB5?=
 =?us-ascii?Q?3AEyn5rIaEVqV3WeXIvXN5Vi0p6FhoTb03gbTTu3ukIx8aLqawb4GGK1qmZp?=
 =?us-ascii?Q?Hl1t2DWKnO344b6aoSSX1x3DIXUDDVW/AYxaoFepJeEPpv987TIlGOUu8CrU?=
 =?us-ascii?Q?62I2JVe9Cqy6dVbzZQn9z6cXDqyt65ce3MMcwN4Uu5zOqZlmBIXCdIavtPz9?=
 =?us-ascii?Q?zeGakm1bTtLEsf1hUU6+D7xi3KJRe+OcVbyASLhK5Z9brGCpuEygzt1vGnR5?=
 =?us-ascii?Q?hTUZTLf3eRUechUi4DDumeZ3gq9Lt6DkwQ4BNh/XkxhFDgTFLpmB1njI3tyB?=
 =?us-ascii?Q?VaDXHVEviT1V4X/4M1YDlzRaBaq7da6hLox/s468wvvZwp1Eaz/WMK0CzCUY?=
 =?us-ascii?Q?2dx32j1qYjCB2ovPV621CIsEaqy1RFhyFIHbx96C/FPo9LaSD240OyCUsAl6?=
 =?us-ascii?Q?wBUhZsOw9otubYn5a6mZJrZ7D+Lrfa2KqQ30NeH4J+aGs4dIuY/nQooYTl2j?=
 =?us-ascii?Q?cvKiE1fWC7tfjuuH+u1+zpRHh+5mgu6gD7buMOekWV5ina4PAeYlKUz03HNj?=
 =?us-ascii?Q?cX6klRIC4pLSnAgfaA52gDYoZ7jwEKWw2bLGNobWkJf+3/t2DyIuyFCyuAc/?=
 =?us-ascii?Q?j4CyxLlsJovwB78Hp30ntbXB4I8VQlWEajI7kBrN2/DJf7hlAIHrCxl0ssWF?=
 =?us-ascii?Q?1stzWSNEjcjz85dVL83IKj+LrnrkpW755gpIVeUq5KfdpFM161V5WElvorZK?=
 =?us-ascii?Q?YqcHLhCXvtAk4Rro22JHebXs1rh92nUWQxKH9Ci3fYBfnUpHvCRvbXtlD/0i?=
 =?us-ascii?Q?tYmledWcwj6Sa6A10tXZthEW50p69va0E5aypwC2AbETC0LnyiHd4eieMU0Y?=
 =?us-ascii?Q?5Y8Wv0IYjJ7EIA4w35Zy+gvrUHyyhtBkoDH9T+ydXVMv3F6zvmEyDVaxizHw?=
 =?us-ascii?Q?tpWsxO4XimjlsjAsOpVN7bqX5YeKxPu+37eGExcYj676vKG2cWjsqzS6RM7d?=
 =?us-ascii?Q?nqrXE6XvFsBLpjAMqtO85wWIF+PbgPXVQc6ZqHwPWIAcbaIWaDoo1MZ1eFeJ?=
 =?us-ascii?Q?xYGzCy5BDGz3KfmEhzVf4MRdbJ9LteiPatgYgbSeVLr9HA4ihoqeSJt+KCvS?=
 =?us-ascii?Q?lGi0e+9YOA9jyoRjpQADTSrVvJEwYfu8wX2CVhcXXeDQs8CpUK1kzOiDkEw/?=
 =?us-ascii?Q?Y+tK52YUrpDCa1UI1NFYasyNTIVt4nrRiZr/7yD6h0qhRfqJViJV9OpzAi9O?=
 =?us-ascii?Q?EcohaR76YtT7XyzEmbBsZOvdSqN6OOh4ZRF9BvgCQ4fQPwaXxABMNy5YI6r2?=
 =?us-ascii?Q?u39l1PLxIxhpKUV+seLmucs3Kh+e0H/iCycE88TwOJkMDg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WTxOR1DnFlRFHPlGCnpdPPeN+1plhCLvGN1K4Yge3mxRJhEfNvBboFQ/QxKV?=
 =?us-ascii?Q?Ynzshy2Sdk2Q/favTEqIb8tW2WvierdZ8hpQZDGlobKEUmrwOL1r4herLyuJ?=
 =?us-ascii?Q?J4wgO61F35g9yGxbpqlBbQFk39cGUT+9bIRycjCmxcvPmGyyH9S8RGsZRDoZ?=
 =?us-ascii?Q?eo2+USI/qlDaoNoFFTeI/4ysuA+6E8oTPq4qZOJv4JgR64FUoUmLicoEDYKn?=
 =?us-ascii?Q?4ZL+ONVZggkqUDoX41M6ojrcsrxj0G7SPojVmxh9URk5JcVGJKSIPsL4Oqni?=
 =?us-ascii?Q?XH74ogr93Czioj0J3srqMZYmWwKkTKDNSbkZeKtWWF8bFKJTPdf42t+MvYTb?=
 =?us-ascii?Q?zAJCjGEARNG7uS2zMq9KgsPWpVgJo3eLlgXSmd9Ul026zpswqXQWp+m7e6dS?=
 =?us-ascii?Q?04EjWANqLVzieDXSAcfGiPZ+Jfay4lnVNp7TlXk3zeEFnJetzxjbUO0tLmKB?=
 =?us-ascii?Q?gdNbK9lLupN6OTSgTIjII9PV13i+PjHIwm4hSsn3+qbnEHS4B5MeGD2WxJoU?=
 =?us-ascii?Q?9tQb72FCou88W9EcAPTZv18m53is0wWPEB3KV5spsLEjjk9rbSDIwIdKQVjN?=
 =?us-ascii?Q?PDWf88EE1dqAjUrC8idDKCP8u82De/InYPujqq/52wa5ZErMZsE9sT9ssvQU?=
 =?us-ascii?Q?7aAkBxrXjvEqLtwDdB++7RRpzd6Yt8IwYYSbqkL8me6oM8rS8G5VEPg+syus?=
 =?us-ascii?Q?b92XIHHNLM59JTYNCSBkFeGp6O0T2/6DAYcqn4Jhv3ad14NoaiYOIlHaeBR0?=
 =?us-ascii?Q?aDVDw5leYpiHVN7DHfFPnPu7RvwRZKrMZ1xyHBPPYrM01FnAGP70WUIBcWMC?=
 =?us-ascii?Q?UIcWNskQtKEGca65H1v3FkcbBr3v40iNlyUMT+vqArzeEIMSBQIv+AE5Z0Dt?=
 =?us-ascii?Q?ZNF58Wwi9DH31bZ+/dfPCXfeTYscPi1qV9Ax7Qyg9B4cQdoDc3yfwqZqvYuP?=
 =?us-ascii?Q?2ae2ynelHjR86WZUIAgFSUhJ7kNO/dxv64n58gocNhbeDX+GZCUvFwmnVkHj?=
 =?us-ascii?Q?1lXKHSK40uesSnj69DvZRvq7oDqOseJ6UQ6ouELAi3BmISSUi3K1Ih7OBXIQ?=
 =?us-ascii?Q?B86d1QGnrwIy6INLXLOhHHle9EUhFfoF/9B8tVpwRLXbAeU5f6LvhAtu9teu?=
 =?us-ascii?Q?bf+GK3RJxw4QMsTGRo46FwafY5EbeYSRbb5l/YiQXhuuboeD/JKPabp7TeGL?=
 =?us-ascii?Q?Y+JAK4620wRIPf90MoGyJh8TTchn3PTBwxhsHRqZ8JTgh9+FAV85JmH83pZT?=
 =?us-ascii?Q?a34ZQrTK0DBNmiZ4CN5bSqvziQbYe8MxDZIOWb0U/gkpM+e8PbDhHzca0Noi?=
 =?us-ascii?Q?eKp6co/pLoAB8k0lA/rJDMw4QQQm8l/cVh3jW04fLYIrrYtct4H6JTyoyMNh?=
 =?us-ascii?Q?gSnkPPb2oNgyyFXOVsbY1w+9X6XZkR3uQzEW71VYgzyATx05wD9QsCHgizvG?=
 =?us-ascii?Q?I+obzDp6nejCtmJv2aO/gQS/YmK8fkABm9SPLOPvLFcc4mYgigMS9brut2hS?=
 =?us-ascii?Q?MssWc0zOVvRwTan6YkfySCSDZIabrhJC7ZhrgiqntKQaRUoxOu5YPMwAEZRs?=
 =?us-ascii?Q?jsmqm50w1vMcWSOmT3kF7txGCey/Bn1Cu2OekAlEVBFBmexOQfaDusWKBZya?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a92433-121b-40ab-f1fa-08dd4bef331f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 05:28:08.6512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kH/wUfmUOLNHzGgs5chAIpI6qXBKZYUVoYYV31Q67tQsyrF8vywRbeii/W45fFJ9YVXbSM6WKFEZUzAy/hvjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7742
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9946eaf552b194bb352c2945b54ff98c8193b3f1
commit: 695ed93bb30e03e9f826ee70abdd83f970741a37 kbuild: fix Clang LTO with CONFIG_OBJTOOL=n
date:   8 days ago
:::::: branch date: 4 hours ago
:::::: commit date: 8 days ago
config: riscv-randconfig-001-20250209 (https://download.01.org/0day-ci/archive/20250209/202502090914.AnKPmldC-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250209/202502090914.AnKPmldC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202502090914.AnKPmldC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(xprtsock.o at 797124)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(xhci.o at 751764)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(page_alloc.o at 694044)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(ring_buffer.o at 690504)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(tcp.o at 791604)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(trace.o at 690564)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(slub.o at 694284)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(dir.o at 703464)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(ip6_output.o at 794544)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(spi.o at 748404)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(skbuff.o at 786204)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(namei.o at 695544)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(filter.o at 787284)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(auth_gss.o at 798444)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(af_packet.o at 796884)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(xdr.o at 797904)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(ip_output.o at 791304)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(svcsock.o at 797544)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(svcauth_gss.o at 798624)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 681384)' and 'vmlinux.a(xhci-ring.o at 751944)'
   ld.lld: error: too many errors emitted, stopping now (use --error-limit=0 to see all errors)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


