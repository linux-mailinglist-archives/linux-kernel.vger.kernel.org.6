Return-Path: <linux-kernel+bounces-430846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 845ED9E368A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62D7CB29B29
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAD01A38E3;
	Wed,  4 Dec 2024 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dTSaNQeB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD1BE5E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304179; cv=fail; b=kJFShNkXCelUohRBEH6afcsZQpi78XWIuKodGLm0pFEdpOUYfc5r/hmqjNaRReZqIAB+8WHTgKPuISJEH8YhnlmRBwFwjC4ocQQbbYCORm3FrVCiX3Q/ZSQN+RIoEeukOlp69A2JFx2Z5VbUIoWfbELLcNk+cRWGEZPyF9Z3k4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304179; c=relaxed/simple;
	bh=Jnj6VdAGBktaEgorfHX9vuKXgE5vA/2ZrBfmXk6F8k4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vAZfJ0z4z9r1+rQcpzWMfonjJmyExrdwrUZLmHlYDi9iMNEaxwdsfkRIv0NtDZn7lt6YqtZDPot2sPzR0oDnCazo4OjM0cq6FZh6pXLBKUb6Awi92z+F9oWP28+r2DJu6nSrKUeOfeJGiMO7o798ixuEsv+PjeZpPDj9dk2zzzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTSaNQeB; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733304177; x=1764840177;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=Jnj6VdAGBktaEgorfHX9vuKXgE5vA/2ZrBfmXk6F8k4=;
  b=dTSaNQeBylfkA5+CDWyf67ev7iJp23Cx8ukovtri/1poBxiI81FtMOxO
   55pvS9yjihQ29Bj4c/AaVr3NvvbnTlphJwqycUBd94HnOuX3xDQ4FuqUC
   1D1HwsOjDWBkwjxEiU1qFdfAUkjEE7zNwXYyi2AWuIl6lVckJfdv7APYY
   33lp+dSisGl84qtfazwJU+Gdg3wx5UkvwASOLI82Sz4oOS0rOqGR65462
   Ci99IGRODFTZtFCy9wELmw4XAVQ46XecndUwpwmVLa0w8lRibwXCJ5LOv
   sklpOAzLnP0I1xQl9y6k9+11o6XzJpyk5+mGOhc4wzeoEiRJhUCywg8wH
   Q==;
X-CSE-ConnectionGUID: py3+aJusTJ2doWb0Lx7qjA==
X-CSE-MsgGUID: kn5XUNerQgW46ylVHvedIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33481772"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="33481772"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 01:22:39 -0800
X-CSE-ConnectionGUID: L11O7HaqTjmUc4xkjCUxlQ==
X-CSE-MsgGUID: SkmOyssHRzSf3yiMPSr3Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93797029"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 01:22:39 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 01:22:38 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 01:22:38 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 01:22:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVMSN50i/nDy7SxQwbeX6MogC9gBArFjgG9XKxMdNcehZASX7gB8zLl+CZAJgW7fZXPPyqSM7tz0Gla1KBovMmmagExG9egwnCmtsn5tO3YTSmqeLP+JdriKW8SuHjOyAPugstMVHVhnhqPwm80Jyx+mpK2wQEtySWfsPLnYRgeEbPgfEa41APOeTcGtCNN3q9mYeQH//6i0sRUDkhVEVc3itp66nXCf/EpnMtPlOzYjOalmGyU4B1NJ+58I7zujCblzzHEJmXp5CdcactL4o1u2qzH1nIFcfyZ07uVCM6ConUxOpApAd3v7meDiwvvCFjtdnwZBmLesHwIE2jAeVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEgwRETmHlyVivMz+8gEXLaF63V75hEoxnfpGfFdTPk=;
 b=Fnf8XqykSZGeEImU/njtwGmk3IU8YM+oGPYhHaUnr7JLTaOTNq/QdE67S6SUavgPESjMPIXFrzYB9p/162qyKh5whc09pXOOdWh/5t0PvLkN8O9Ds7ovpKC0+GDwLFvUF4UHql7cyQwtJ6RwS1kA50LdKaQHJJ91HtbAvrXhkb/K55hwfdwynJX4OoJpJm/AQypztJkuvQg5yMhpKG8yu/HCmiDD2xSWdvn/8xkMzcR5BBjNJNgxgj5uzSCdZTkA9Y7ZtF3xcubSO+Swdi8O+7ivaOVngykw+mm4BA5Wo04s5eRr1uEDj+oTd4vXZ0H7fNkUk6SjfCcMGRD26+mLiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 IA1PR11MB8198.namprd11.prod.outlook.com (2603:10b6:208:453::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Wed, 4 Dec
 2024 09:22:30 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%5]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 09:22:30 +0000
Date: Wed, 4 Dec 2024 17:19:44 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Baoquan He <bhe@redhat.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, "Kirill A. Shutemov"
	<kirill@shutemov.name>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<x86@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <Z1AesNxMFwuZQ7WY@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
 <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
 <ZxmRkUNmx863Po2U@yzhao56-desk.sh.intel.com>
 <Z0WzHZ+fNn6WuH/E@MiWiFi-R3L-srv>
 <Z0bt4HXAKqM3C1ZW@yzhao56-desk.sh.intel.com>
 <Z0iJ+DTPA2IkVDx7@MiWiFi-R3L-srv>
 <Z0lWkrsXSpDVfW72@yzhao56-desk.sh.intel.com>
 <Z03BbH5PgNrE81dz@MiWiFi-R3L-srv>
 <Z07YJlxK9/piXLhK@yzhao56-desk.sh.intel.com>
 <Z07dzP6ZdW3sNahj@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z07dzP6ZdW3sNahj@MiWiFi-R3L-srv>
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|IA1PR11MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 871a7551-e081-4fb1-ac60-08dd14452d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PV7JBNX6/8u+9P4ozFh2eGwE/c8bbpPxbyXbsJKxlMJf6Cn9k7550Oe+Gzqq?=
 =?us-ascii?Q?tPtmDuHHy16giZX2bC/5pI3MdKWCms/kXvoNHtJ2bDZuZauH/cUgbh/EWXnR?=
 =?us-ascii?Q?D5a7BhdL3Ehb9bNn0MMUcxZEqoEaNFU//4JC8LtGwNwS2eplcse6OxZZ5kj0?=
 =?us-ascii?Q?IXa9/qd9/xbj/L+c7NZuBfdaAH7pMjI9naMSvmZoky8ua1wMk44bnx6n5M6o?=
 =?us-ascii?Q?FU77uAosXN7sNfEss3FmbugJ/X5LpFPwrmyYySMv+59ivmLOkfTGs2s3qnXI?=
 =?us-ascii?Q?3gPxZ8g3nAjbzkjwX6+NB4bYiv927hS4QncqPAPxl/ODJMNf4k2Cl+LYlr2O?=
 =?us-ascii?Q?/njnjQcNt4eQCR2MFslUWTBGEAHX6KG0sZbAotMIdki5uK9k7lM1DkxFsyNA?=
 =?us-ascii?Q?f7p1uzVDT+QSBrpmWqt3jWuvye2OvFEPTOtdNIk2XC5OqITgslUnJVelRuke?=
 =?us-ascii?Q?3eX9ZHdolNzOdAD0qSV3vTiSmRh5NT0S/rwk0nz9J1I9qsI6AnmjqYgySDdC?=
 =?us-ascii?Q?W65xd16xBYrfQeC4kjq6LsKI6qWd0ySlQHhjwhL1rRjppCxbE2tFUCC9Lpxt?=
 =?us-ascii?Q?Yt/tL2aQO1U+TQu/hqUKrdAVN9d+TM+V0WnDXLdXGJkgjbXrlnV2LdEhD3FM?=
 =?us-ascii?Q?IPe82j+pE5/hLy9FS3usvlRha1V5vK7B0F2PNoXQsuIXpvyy2VEuv1lGCjWI?=
 =?us-ascii?Q?+CZDNtZ5pBr7pDOZfl3+/EbbkJbnd/lNzG5/KdD4ih9hUsA1rggrZ/RuT0PT?=
 =?us-ascii?Q?h47XhnmktYSbuwk6B5GrtBz+M03kJWrNFify6mN0Uq6lt5rsBDGTjy/9U9Vs?=
 =?us-ascii?Q?Ig7+6PMK9mxHZ+tTi04BHRWFWwDwB3qMtum47G/y0UyH9g0+odNHhVBY5nBV?=
 =?us-ascii?Q?VjmYjWSruHxhjp1m0mAt3D3JZ0hpAtO4u3lL77u52qKb813TdmYpu/VUdzPQ?=
 =?us-ascii?Q?1g7UfVlcDT3MyGlcVkqX6GqQwBgwvjGBsmCPFg+hpYouP6qsK4gHNCIYUgIC?=
 =?us-ascii?Q?5RZenujQWECHGbuFDE94hswqGKnC6fDtxB8LPdx5Rggnw5D3IVNNQVCdvwY6?=
 =?us-ascii?Q?icrjLIVFsd2XI6PGfQHP7W25HSClj2UCeca8pYCfS6vt5yhPWK8bO/Bxw6S8?=
 =?us-ascii?Q?ez51qe3YP5cx2pFDd02S9SJA1u748xJ8uQd/BXsmG1npduebSgRmlCgjXprx?=
 =?us-ascii?Q?IFdf7ukO7uAJbgJqq/t9UjOwz2Ap/rbGeA857uxiVYX9fUNv1rMsDSuw5HdC?=
 =?us-ascii?Q?iVUSLAnMAr3tOS4JxRiFkHtXEWYe8i8x/RBEn/onFcI2ux2YIbKM5C+wAEgd?=
 =?us-ascii?Q?8rU+xhgmTkBTwRyw0NfPiG3cC/9sy/QUQIhPQcmxRIwXrg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3YH9+O9Psh6ug3sfsC4lMnQZvfscnofX0BmXrF1IHEFcobrdpHLN9KatWall?=
 =?us-ascii?Q?vM4SVFiUjg+QwXSJkiXsn+41UNejo92MkFLpGfebDR/xwU6rYFas/yswYZcB?=
 =?us-ascii?Q?6FDXyMokcTdOZETNM3ngDe3dC9N7UsLD9W7sjO2J2bx2ClGwqNjRIIf+utvV?=
 =?us-ascii?Q?kc2VrpEqNpWrzLIY/YevcRdpkeyQb2Zk0bkUmMXJGJ36Y5PaWDcqzF582KnV?=
 =?us-ascii?Q?G8oH1+4OK8OXQbKgP2cqqZryuzYfVDHOjycaDemSIndAT+c5rthm8/8IP9i5?=
 =?us-ascii?Q?Yc4+a9XZlBC3Lpj35kYzqqorSfzWsT7DNCn3dtEQ4KjvR52YiL4O0Qn0ZFuS?=
 =?us-ascii?Q?vjdvqozFLIebXnCxbUp3Jwm6JIU58BOvOOMFK322osZ3ziGkN+0yypZXue4A?=
 =?us-ascii?Q?rTH17iE4ZVwCfbX9E4qezw5Rr79mDn9UUI6ty5o1+6UPRiO+oJeUJ2SNm9A8?=
 =?us-ascii?Q?Bg84YaqoLgyLPLrPU6JvvmYjtU/vXFCj26lRC5lO4x6GOql7/Orv66Nbr5v8?=
 =?us-ascii?Q?5IGMUuJbnv3rLGw9TxO+pb6J0kYUAt4O5M6mcncUpuds3jnJJPUxotJ3kNOT?=
 =?us-ascii?Q?BUJItlUDOEJGwoaElNE1NyWX9J9UGzVkndSZXtjLTzySKRTjMpo8O3nUic97?=
 =?us-ascii?Q?6m/TNl1IwAZGNEU4jH72a/Hp8Z99h/q/iYI994+e6pKmyg277blcLrc8hqgH?=
 =?us-ascii?Q?eJmFnmrlc4YRvhkR7Jg43iQYGX3JKV3+Gc0n5J67tYZW0gMqGrKQx8oDlHVY?=
 =?us-ascii?Q?c5Pp19NdGk7HXC66WDNK/Qx1ypHn7bHnjNqogZtZOQBKleWqiUYiGrKhZPf5?=
 =?us-ascii?Q?Zyj/dku8gezzleRP7HSMXOUr8oAAPDA1anaElB5G37vC/J1dc85inWt0n2Vm?=
 =?us-ascii?Q?JPeK5NCEBQv1w6HZRnolH4ENwwiPY1XFBilSaqxyq1WGnDcJHwl9xeMF3ki/?=
 =?us-ascii?Q?/E1T1FORVc6noIBeyUYPl8qgNledsj71gvQ2WJIV2gZ4CbZwnrSYlOIVJgI9?=
 =?us-ascii?Q?/etGXg8qexDBeEc11k/QPrtEenDes1tYmUJsjwFwr3PGR+bV1TqjavSOu8Ut?=
 =?us-ascii?Q?3X/R4Uhxq4GEVirBgiskd4y4dacF3ophUOPUQffAJ23Smy9xLzOKsiLyegs4?=
 =?us-ascii?Q?7wlx/hCFdmmRx2yRegNU97oBcDR9zF+Ej7nnDkjc3M4ZuibAYhj64WRlvkGZ?=
 =?us-ascii?Q?g7hpeuLsTv58wN6w8yglB0DGVYq8gd55qpKCDaFb/DGnvyeuz3bnh/SJpPY8?=
 =?us-ascii?Q?mTd8Z9fsy+n75X10JiCBx3zg4ABZZowJlDQuT2VRWYuW+rwmxnLxk7uwYCDS?=
 =?us-ascii?Q?htZNs+LGIPeTcQHQUmKTq6nAlLsZ62XlNAHUbLmqGKI9Hcw9Arlxqtow86Jz?=
 =?us-ascii?Q?1u/l3wPob00fv3SKLIPkpyHM8483Jrp4gpr6grr6ZGTR4gsTBx86v1QqZGW5?=
 =?us-ascii?Q?qWUECTgZDGw/ijFyfjO6a98pM5CFNuJcqnG3hTUrQ74/j52GiAdJRmY3Cq3t?=
 =?us-ascii?Q?/ZYVKx2cegQGErEnSiwjFx+yViRFvjVVb5+maBvMKtyiCmOYz9pI4q+j7oDb?=
 =?us-ascii?Q?t46L6EDVDuTWqinHz1Nje+FNEsWoETEVI3QbxVIO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 871a7551-e081-4fb1-ac60-08dd14452d5e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 09:22:30.4180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xIVFos9FFRLOK3/O9g1EcV/dpDAwoLASJw8hSrn+Tl/toqxxGp5n6KraAzdBrbdWqxvk9z338SDpFFhudR6RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8198
X-OriginatorOrg: intel.com

On Tue, Dec 03, 2024 at 06:30:36PM +0800, Baoquan He wrote:
> On 12/03/24 at 06:06pm, Yan Zhao wrote:
> > On Mon, Dec 02, 2024 at 10:17:16PM +0800, Baoquan He wrote:
> > > On 11/29/24 at 01:52pm, Yan Zhao wrote:
> > > > On Thu, Nov 28, 2024 at 11:19:20PM +0800, Baoquan He wrote:
...
> > > Oh, I just said the opposite. I meant we could search according to the
> > > current unaccepted->bitmap to make sure the destination area definitely
> > > have been accepted. This is the best if doable, while I know it's not
> > > easy.
> > Well, this sounds like introducing a new constraint in addition to the current
> > checking of !kimage_is_destination_range() in locate_mem_hole_top_down() or
> > locate_mem_hole_bottom_up(). (powerpc also has a different implementation).
> > 
> > This could make the success unpredictable, depending on how many pages have
> > been accepted by the 1st kernel and the layout of the accepted pages(e.g.,
> > whether they are physically contiguous). The 1st kernel would also have no
> > reliable way to ensure success except by accepting all the guest pages.
> 
> Yeah, when I finished reading accept_memory code, this is the first idea
> which come up into my mind. If it can be made, it's the most ideal. When
> I tried to make a draft change, it does introduce a lot of code change and
> add very much complication and I just gave up.
> 
> Maybe this can be added to cover-letter too to tell this possible path we
> explored.
Ok. 

