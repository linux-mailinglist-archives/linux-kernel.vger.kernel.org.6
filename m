Return-Path: <linux-kernel+bounces-320215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 206F59707AF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12EB1F219B5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4843516630F;
	Sun,  8 Sep 2024 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnjeFC9g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5421F1662F8
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725800832; cv=fail; b=Rv1swrUl7ilJdlnC8bXTBRx/nCBoHWhR5MFE/qZ7ChdO+ihfkvFX5d4fRmVQZjf4dPqfZxWHvfweqF1YJ3G4GyyEMX8OH4E8raQxrtTbepxHSA1idaG3eeysf8FktTuEy2DUpKrv/lyu9Tpyz8qHdDk0LHOBFk0OEHIEFWGiizc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725800832; c=relaxed/simple;
	bh=cckcdpwkzC6zZWt1TMO2BDSfe4+9GXdGPjeePDf1vhA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PAiivhF/62dUBOdPA3AoWe1kIoDa4ALLhOVeiBqRFK5OiaBmX8mTFHz2fLGugUGBcRzM6RjqialkFvQtk1OuY6w4q6R8i3lXrJ3z5k3WBJ8qaps8EbuOtyANDOd5ZTH5/Wo7h8c2PLSFAH735yRHkLnwfYtz7h3mdJBi5i10+u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnjeFC9g; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725800831; x=1757336831;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cckcdpwkzC6zZWt1TMO2BDSfe4+9GXdGPjeePDf1vhA=;
  b=TnjeFC9gjY7/EcTZLoLv//2G3Cgtz4lmNUtuidEx9/om/wn139iZ94sz
   +hgbkcny+x83J0v7TlltwGIVrRQ1g/dmuyES2xQWq4639LJqw1S0iED+e
   d1pZSrJIa+ztoOqzNgOJ7uC2wCoz/YVYyvjB32Fwn0dBFIms+p8UofP48
   15qnyWVQEWeLMftdn1Zgvru8rFwnk8/cKjPTEnfVPwrYrTEoXCfcQ0ExW
   gf8ad5XmTKUaQNkYLBmvDobQfT/7HrEoW1aO4Tqu7SWAq13xGuOMJVRrw
   0BrSwvrVjVHWieRNviy+AsBxVbW96keVPfkVzbh9ZqsNXEIFZv0D5AeAe
   Q==;
X-CSE-ConnectionGUID: wJDsWbk8SuugSjQRRAHMeQ==
X-CSE-MsgGUID: ngTPZ2ipS/O4Ty+7fQY+zA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24362760"
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="24362760"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 06:07:10 -0700
X-CSE-ConnectionGUID: xV0+sRQeS+Gm8OdCjsxzSw==
X-CSE-MsgGUID: slkMqTK4QoaB3kyvi2VrIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="66107003"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2024 06:07:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Sep 2024 06:07:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 8 Sep 2024 06:07:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 8 Sep 2024 06:07:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7pNFX51RTdvhzxXg4KtGLTPW4qSL8gdVXBBQHhBQoTUYD8k3v7Ys/mtTZw2qfQWZCUc2rwlnD+WBoD69PDyk/DG50nH8I5Hqtrdent0RtSEHI7jAK4iLGAUmTluDKXr4i1XCn0vWWNd9vrkZgitn5jie4j76NSt+y3pybQ1NFWvK57McYhXPkltmZD5gQnSZqkTLiXxQIXDTuDFXLJ7FiwkqLD9ZpeLNT1ctgu9Kb3y8Ewj+uFqUVB0CQZWs8/7izd7DyGToXDkrzdIIVZLM+Qteds6OChraY0JS/fph3xbQlAzBzSvDSMlT36KqGNGrFEDjshbFrjYX4RZDqwE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sM8RU8b6JZmgCC2UQ0MALoKrNJL5lm8yFy7fsMPaUDw=;
 b=nCnAum92GbcI7vnz6UH+eG+k2SyiuLnkq5hZV4/aDzmrNG7c6ty8kqsODZ+cHiCiY2MkKeY9bPOrbvBbf3dAMAtlsKMCFE42hcqaG9gbrUJ5w9cltpe2VYGRd7HfApsSm3ESctCGP/SGoxBF51Dmjl3iSlD9bEv27lwUEww+MV87Xq8m+Tl5iK4MG9Snmd1dmb8hNubriM7xxufRDU6Ls3PDSYbWClNTYGzRlhFlgpd/JUO/Co90iERKGk3B7p31iO+6vVT5EagxUKZ9ALCyyvjM8r6V66Mu/q/PyiHL4SKJ2TOk4p81SRLGFDKMtuxcq5I8WPqr9S41ZXc/fqPJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB7520.namprd11.prod.outlook.com (2603:10b6:a03:4c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Sun, 8 Sep
 2024 13:07:05 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7918.020; Sun, 8 Sep 2024
 13:07:04 +0000
Date: Sun, 8 Sep 2024 21:06:55 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, <oliver.sang@intel.com>
Subject: [tip:locking/urgent] [jump_label]  de752774f3:
 kernel_BUG_at_arch/x86/kernel/jump_label.c
Message-ID: <202409082005.393050e2-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f03587-eb98-447d-414e-08dcd0072283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?II3bjAHe/7EECpP8tIraobhD8pxN8teJ5+XcB9muus3CuXyIZPWsmGEo049V?=
 =?us-ascii?Q?tyzh/34TtpUgrlZ375/wH87PHeGBj1q6Pi3ngns3pTNVzwSnQeYjEbSX9htN?=
 =?us-ascii?Q?fuiOzmK41cPJaZTYFSPwIClMKF08vWfwXNnRuZDxts8bUHXKVvKbmyUVF2K8?=
 =?us-ascii?Q?fG2wNpxjIWTfYl9GylSmr3lMGMjgxRDoN5ip/yn2suExqaDqKBQNNpkrWgWP?=
 =?us-ascii?Q?T25582Bbi5aIKaT4UJcPoFHNZk5zjmLwtKfI4Tl3ZEkWrH16dLjMfWtPK8Li?=
 =?us-ascii?Q?0VzEMzmpNi5AqLrMJ5/E5X7VOkg6IzrqgNiqlDYVtGpyaulFgcSxOc70kNRB?=
 =?us-ascii?Q?F5sNIvUByM9UXjMN8rSvDPX54lgcwKeCbww8ok6/LEEpqdhc1mQypaGjEli0?=
 =?us-ascii?Q?Qw9ddgl292WXLuvEAUBrwSFbay0GQz92MpX/e0TwDL+NgzRbH1NF1u5APab3?=
 =?us-ascii?Q?TjsAwN0tjoyM3VKGGTt/J3y+2CQfe4FdJdBaz0yQAL3H2QpyBciYC8p3sAOY?=
 =?us-ascii?Q?3MzOwLTwuBoME2zFnrTbAzJUqKv0ivvD0zytCNznDjFwyjRse4979PBV5F9z?=
 =?us-ascii?Q?M6w+rewdJvHoI83jYwrvPxBIZoGKoXxPeP/jWH+7tLOvCP764QQDERI6nVPF?=
 =?us-ascii?Q?APGq3f7wIEfbCmY964N1tocchh+SQF/7JoMwVmYAwFQsTW3knCM0bXSbjVgr?=
 =?us-ascii?Q?X2+KXx5JOPx9nJBLCD+7uLu47Qtr4rjCPxBNJfFFjLi4tmg6TO9dVTeklF5Q?=
 =?us-ascii?Q?G6P70g3jS/kbOOlVsRBV62Dd9fTKE9cjVYoySGBtuZICwju32xZJCoOF0ACx?=
 =?us-ascii?Q?lbS7/kZy9o24lGwuV65bpQc5y1UTyaQ969j7lnLxcYjK93HVLzP9XAQ1DoZ2?=
 =?us-ascii?Q?AyECbl2SJXGzhp/T4p9MsthlFmtHTeW3whCAcGd4fq/NINGDYBSIUQ9gL0Hv?=
 =?us-ascii?Q?CfgRcK+JEBQokEwxFcKW86+i0+n8g/F4cKBUVoZB2cnEUVJQaqeV/Ke/+ZPg?=
 =?us-ascii?Q?NP+xVOAiU4f5hHUayHYKPaJw58+Rmt1419pBEI95F+6riwWRlnstHjN7mA5h?=
 =?us-ascii?Q?bUcMNzcPZh0pqb1yxS7JARPJVChjbvPVMDvSI75j8HFE9izVRH2Jc0A6rRg5?=
 =?us-ascii?Q?B4vWQUZ4xtFKVsHHxjDEJSNJlRkZmTIjMPOZxtSGLFWhtKVglpd+0Qye6W/O?=
 =?us-ascii?Q?qhksgxUEHgLDdlCONxNBel6kpiYymAkBwOpj9JDlF66ziwZFxZNZlQZ7Tq8w?=
 =?us-ascii?Q?XqJVycCrhC7HmdXxs4HSTcvAvHiacT7WpPmTDglKKW7S4uIjVN3c24NZ1ZoZ?=
 =?us-ascii?Q?3lZF2Y2Uz2fX1d2059gSUyexM7337E09UQ3+s69mTqIXZYFYPnwmLQLlsyMR?=
 =?us-ascii?Q?pk/lAzc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WR5BrvfB/aaeGO3Bz1d7aiDgVxFbXXMmpBX8wFUFbXskke2zuDQQiW+p757A?=
 =?us-ascii?Q?p1V62lhuAuEiMPbcM40rlDZtqZeKXfBIPHwbD362tmLn6R+5krSKDK55FF44?=
 =?us-ascii?Q?W1KV0Wj63HxMTIxRy5UWhrtgD5nnY1O0oIg4p4KTBCB00mVICiFcuFsSmlSX?=
 =?us-ascii?Q?Kl7Lb5z5Wacara6xDNuDkaG99IuUbEGgauHj3Y9aOuGdp0FlQwFZ3LnLpKNY?=
 =?us-ascii?Q?IjJf3S0EuH+WOTG1xL3/jVzHqBDgRmoCd9X8fPeOfTsEWotqNDWTnUxqIVIS?=
 =?us-ascii?Q?/jexP2behStK97JGEsytQABLxw2c1+CmN8O+HZucrOSXE69+wU2W+KxRp1/e?=
 =?us-ascii?Q?GUW4qYFJqp7L+tPxi6CD0TI+jc2cY+G+6Lc+hyHw8XVVHkZbGnJMSMCbY2KY?=
 =?us-ascii?Q?EmgTUD9Kgz95qScfzfktR5w1TYHmbEfFB18NY8SFA7eYDUou3pdLD+g3kYBk?=
 =?us-ascii?Q?vOpz0bXisKFDtd6K9KDxdnzTwb6tBKbgBmF9/MbU2mZA8k4JJ4WnfkdNzmr7?=
 =?us-ascii?Q?9vfcHCJ5Zsx7U15+lVT3lkM5OoMT2Th9qYq5cSIoAmMAkinlu5E+b6y4E2ld?=
 =?us-ascii?Q?ffxCRsGureruf/uZ58gteBCXyONErSE5iAJVASccrah13bpRlwrSbdfdf9LZ?=
 =?us-ascii?Q?7tKYm3k7aY8vrWQRizPmnHIIlSHwT/Nzd0AGdJjE75fr/ahwoMdmnvQMROIE?=
 =?us-ascii?Q?lbc1xUiYUvUJ9kX71oSovBkchZFTtLTZK9y+Ym0w6rx5P11DrqPQG34nqjM4?=
 =?us-ascii?Q?qaUvKNNRQmb831ZMRPmLANmKb3Wzzdnw/J9VBzeDjW4cu4LkqIzav+WdVQRz?=
 =?us-ascii?Q?UMLTskfvDb1uMl38oT1rXnaHyVhnlHn/ZvDL+SXtkucaia3DKfbydDuz71iA?=
 =?us-ascii?Q?/Kv09V7lM00h+YU1boIESeYeLlEVKOI6wqY6NarcMUKugLkwxnJQtVoG/Tuo?=
 =?us-ascii?Q?hD0+57JYQmFX7WL9pegdajEWN1jCEGsRBKqhPLntzTKGL3BTa1Yguqn/tSCC?=
 =?us-ascii?Q?zlyHh3UzRoUue58nneXJbH4kJgmPa/F5BRb+uLqNANvYwTpITgbBvEdZFvti?=
 =?us-ascii?Q?38oZ9slxMoXP/OzK46dlOnL9nlo09CWMy6bjKtzFmZwbVYhbobT6M5YMTDQ+?=
 =?us-ascii?Q?BaV3X0O0vg6eDxukzEWSNovnT/mpA6YUPoi4/kcMHGt3EHlcY5Y3+vUfrYOD?=
 =?us-ascii?Q?of/ICbh9IkKTl4/YTGwlIrPhp2HPCEdhheutNIKwUlpyWBBrTl62r+1Ai3Xj?=
 =?us-ascii?Q?FDdkuYbOSaRzHl6MR1OF9t7CbWSevduh64Hvs2oTLTCvRqq5Z9duNy9bZYbp?=
 =?us-ascii?Q?jKheAjDYi6vXDs8XG+VrC1aXZpNW01nqCrWetIrPpLOZvWHgAyj6dCMME+jk?=
 =?us-ascii?Q?UKDAVwp0FKl7CqeUsz5fCuyl146TjdaA8b1Nbi8qO/fQwyUCoHDiKdCQvo/D?=
 =?us-ascii?Q?zb/1N2WG26jXcZN0lLY+LAtlck8gDLV/Lhyi9seC+tFsE8eZPntd7Cz3Xhbz?=
 =?us-ascii?Q?f3pH6D5HSbRlRZKfnNKb2YZ6cwvxmVK+PoXEBBrfPBaRrg0Gad26c8u+UXm2?=
 =?us-ascii?Q?5Fb8v/LHWj/lb16wFIiH6eKEL7Vy0EFqXS6XIyIX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f03587-eb98-447d-414e-08dcd0072283
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2024 13:07:04.7518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7X5NnBEIOJjTtLYaAbVB33tjgS6+F+VHegGC6NZ2aLuZ2CW7UghZKgP5lKOHRp5mYh7T/OpTJBwRyJhG4YXj5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7520
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_arch/x86/kernel/jump_label.c" on:

commit: de752774f38bb766941ed1bf910ba5a9f6cc6bf7 ("jump_label: Fix static_key_slow_dec() yet again")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git locking/urgent

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------+------------+------------+
|                                            | fe513c2ef0 | de752774f3 |
+--------------------------------------------+------------+------------+
| boot_successes                             | 12         | 0          |
| boot_failures                              | 0          | 12         |
| kernel_BUG_at_arch/x86/kernel/jump_label.c | 0          | 12         |
| Oops:invalid_opcode:#[##]SMP_PTI           | 0          | 12         |
| RIP:__jump_label_patch                     | 0          | 12         |
| Kernel_panic-not_syncing:Fatal_exception   | 0          | 12         |
+--------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409082005.393050e2-oliver.sang@intel.com


[   30.932699][   T61] ------------[ cut here ]------------
[   30.933988][   T61] kernel BUG at arch/x86/kernel/jump_label.c:73!
[   30.935400][   T61] Oops: invalid opcode: 0000 [#1] SMP PTI
[   30.936825][   T61] CPU: 0 UID: 0 PID: 61 Comm: kworker/0:2 Not tainted 6.11.0-rc3-00004-gde752774f38b #9
[   30.938908][   T61] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   30.941185][   T61] Workqueue: cgroup_destroy css_free_rwork_fn
[ 30.942549][ T61] RIP: 0010:__jump_label_patch (arch/x86/kernel/jump_label.c:73) 
[ 30.943854][ T61] Code: cc cc cc cc cc e8 de 44 f5 00 48 c7 c7 a5 22 44 89 4c 89 f6 4c 89 f2 4c 89 f1 4d 89 e0 41 89 e9 53 e8 72 7f f4 00 48 83 c4 08 <0f> 0b 0f 0b 0f 0b 0f 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90
All code
========
   0:	cc                   	int3   
   1:	cc                   	int3   
   2:	cc                   	int3   
   3:	cc                   	int3   
   4:	cc                   	int3   
   5:	e8 de 44 f5 00       	callq  0xf544e8
   a:	48 c7 c7 a5 22 44 89 	mov    $0xffffffff894422a5,%rdi
  11:	4c 89 f6             	mov    %r14,%rsi
  14:	4c 89 f2             	mov    %r14,%rdx
  17:	4c 89 f1             	mov    %r14,%rcx
  1a:	4d 89 e0             	mov    %r12,%r8
  1d:	41 89 e9             	mov    %ebp,%r9d
  20:	53                   	push   %rbx
  21:	e8 72 7f f4 00       	callq  0xf47f98
  26:	48 83 c4 08          	add    $0x8,%rsp
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	0f 0b                	ud2    
  2e:	0f 0b                	ud2    
  30:	0f 0b                	ud2    
  32:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	0f 0b                	ud2    
   4:	0f 0b                	ud2    
   6:	0f 0b                	ud2    
   8:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
[   30.948232][   T61] RSP: 0018:ffff9ca6001f7cf8 EFLAGS: 00010282
[   30.949577][   T61] RAX: 0000000000000090 RBX: 0000000000000001 RCX: 373e749642a76800
[   30.951426][   T61] RDX: ffff8f8d6fc2e100 RSI: ffff8f8d6fc20b88 RDI: ffff8f8d6fc20b88
[   30.953270][   T61] RBP: 0000000000000002 R08: 0000000000007fff R09: ffffffff89653620
[   30.955116][   T61] R10: 0000000000017ffd R11: 0000000000000004 R12: ffffffff88e02ee1
[   30.956953][   T61] R13: ffffffff88e02ee1 R14: ffffffff87ff0855 R15: ffffffff8a4bd53a
[   30.958780][   T61] FS:  0000000000000000(0000) GS:ffff8f8d6fc00000(0000) knlGS:0000000000000000
[   30.961357][   T61] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.962842][   T61] CR2: 00007f73b3af0660 CR3: 000000010098c000 CR4: 00000000000406f0
[   30.964667][   T61] Call Trace:
[   30.965625][   T61]  <TASK>
[ 30.966403][ T61] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 30.967440][ T61] ? die (arch/x86/kernel/dumpstack.c:? arch/x86/kernel/dumpstack.c:447) 
[ 30.968374][ T61] ? do_trap (arch/x86/kernel/traps.c:129 arch/x86/kernel/traps.c:155) 
[ 30.969404][ T61] ? __jump_label_patch (arch/x86/kernel/jump_label.c:73) 
[ 30.970605][ T61] ? __jump_label_patch (arch/x86/kernel/jump_label.c:73) 
[ 30.971801][ T61] ? handle_invalid_op (arch/x86/kernel/traps.c:175 arch/x86/kernel/traps.c:212) 
[ 30.972977][ T61] ? __jump_label_patch (arch/x86/kernel/jump_label.c:73) 
[ 30.974314][ T61] ? exc_invalid_op (arch/x86/kernel/traps.c:267) 
[ 30.982068][ T61] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 30.983273][ T61] ? mem_cgroup_sk_alloc (arch/x86/include/asm/jump_label.h:27 mm/memcontrol.c:4783) 
[ 30.984463][ T61] ? __jump_label_patch (arch/x86/kernel/jump_label.c:73) 
[ 30.985683][ T61] ? mem_cgroup_sk_alloc (arch/x86/include/asm/jump_label.h:27 mm/memcontrol.c:4783) 
[ 30.986825][ T61] ? mem_cgroup_sk_alloc (mm/memcontrol.c:4787) 
[ 30.988009][ T61] ? mem_cgroup_sk_alloc (mm/memcontrol.c:4800) 
[ 30.989188][ T61] arch_jump_label_transform_queue (include/linux/jump_label.h:125 arch/x86/kernel/jump_label.c:138) 
[ 30.990552][ T61] __jump_label_update (kernel/jump_label.c:518) 
[ 30.991727][ T61] __static_key_slow_dec_cpuslocked (include/linux/mutex.h:196 kernel/jump_label.c:321) 
[ 30.991734][ T61] static_key_slow_dec (kernel/jump_label.c:327 kernel/jump_label.c:341) 
[ 30.991737][ T61] mem_cgroup_css_free (arch/x86/include/asm/jump_label.h:27 mm/memcontrol.c:3739) 
[ 30.991743][ T61] css_free_rwork_fn (kernel/cgroup/cgroup.c:5378) 
[ 30.991747][ T61] process_scheduled_works (kernel/workqueue.c:3236 kernel/workqueue.c:3312) 
[ 30.991752][ T61] worker_thread (include/linux/list.h:373 kernel/workqueue.c:948 kernel/workqueue.c:3391) 
[ 30.991757][ T61] ? __pfx_worker_thread (kernel/workqueue.c:3339) 
[ 30.991760][ T61] kthread (kernel/kthread.c:391) 
[ 30.991766][ T61] ? __pfx_kthread (kernel/kthread.c:342) 
[ 30.991770][ T61] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 30.991774][ T61] ? __pfx_kthread (kernel/kthread.c:342) 
[ 30.991777][ T61] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   30.991782][   T61]  </TASK>
[   30.991783][   T61] Modules linked in: drm fuse loop dm_mod ip_tables
[   30.991815][   T61] ---[ end trace 0000000000000000 ]---
[ 30.991818][ T61] RIP: 0010:__jump_label_patch (arch/x86/kernel/jump_label.c:73) 
[ 30.991823][ T61] Code: cc cc cc cc cc e8 de 44 f5 00 48 c7 c7 a5 22 44 89 4c 89 f6 4c 89 f2 4c 89 f1 4d 89 e0 41 89 e9 53 e8 72 7f f4 00 48 83 c4 08 <0f> 0b 0f 0b 0f 0b 0f 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90
All code
========
   0:	cc                   	int3   
   1:	cc                   	int3   
   2:	cc                   	int3   
   3:	cc                   	int3   
   4:	cc                   	int3   
   5:	e8 de 44 f5 00       	callq  0xf544e8
   a:	48 c7 c7 a5 22 44 89 	mov    $0xffffffff894422a5,%rdi
  11:	4c 89 f6             	mov    %r14,%rsi
  14:	4c 89 f2             	mov    %r14,%rdx
  17:	4c 89 f1             	mov    %r14,%rcx
  1a:	4d 89 e0             	mov    %r12,%r8
  1d:	41 89 e9             	mov    %ebp,%r9d
  20:	53                   	push   %rbx
  21:	e8 72 7f f4 00       	callq  0xf47f98
  26:	48 83 c4 08          	add    $0x8,%rsp
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	0f 0b                	ud2    
  2e:	0f 0b                	ud2    
  30:	0f 0b                	ud2    
  32:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	0f 0b                	ud2    
   4:	0f 0b                	ud2    
   6:	0f 0b                	ud2    
   8:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240908/202409082005.393050e2-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


