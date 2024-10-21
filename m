Return-Path: <linux-kernel+bounces-373653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8819A59D8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F3E5B2151C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 05:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37DC1990C8;
	Mon, 21 Oct 2024 05:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sj5SumDL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE56D192584
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729489481; cv=fail; b=NFfB2YIOrC8PYrs9Nuu3tXRotMZW0SRrTIWNkeEyvIdC5r5wQ1JTJEtD3yy23/V+ZpFv9HXZ1BLzFnTkqFOUqDAZo/xChSBX+Xcwrac/9Xaj8FlcGWTb9MZx7vEoEreHIVjeWqOEZ2OpvmHcBM0XYe/xwDYLNRuCaOJ6adfh/Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729489481; c=relaxed/simple;
	bh=9X20CN2GwEMiBcdlbgyh/NZCi5aT7UOzTtASqYsaSTM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=GORXpS50WIDEG608okqfFL0HLma+pprVeCXAyRd9x/HylBXno2rHf8jJ91E03npJ97JuwgBgbsjNibleEIUD2ZXiXU3Xx7Drmbg0AKWJp+uoWeocGlaxUlfTPMPPlzTWXV1jngNaQJGW1tZuxDZ/XW+HBHS3MFcG4ocPZ94jfGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sj5SumDL; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729489479; x=1761025479;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9X20CN2GwEMiBcdlbgyh/NZCi5aT7UOzTtASqYsaSTM=;
  b=Sj5SumDLi7IQSDJCAICLtwAXZFnejZzkjMeEOZor7hHH/NG1nNDW9nl1
   z4CUVZp3exnmlH62fmhZFCpNHohzfsx5ohUXKEzeekkihMy/G7qNlWp73
   wXTKp5pKWKuSPtjiTNt1OuP/22oow5jRYgwBeGkFYSoay5TxDGplfu+sa
   FHwD6oZ711Aqot41YmCepyJdDbP+RJQT46QNeV/395wMCtwXb1hCDwYDQ
   FqJZNU8q2hOqWV6Ys2stRXyDsfETWq83xq1eb1MhFxiTYcv6mtJx3jcEo
   Awc+8I7+mLTKbJWXVpowEWaQcLEM9sUqGJ7LP/HN/zcWYCm0ZZ5Z7Pkoz
   w==;
X-CSE-ConnectionGUID: yCVCNH4yS7OuLOfpfAhZZQ==
X-CSE-MsgGUID: lOz0d5wIQKqAWfKnWqo5FQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28834802"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28834802"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 22:44:38 -0700
X-CSE-ConnectionGUID: Y8NkPfQqRgarxEbt+e5Dnw==
X-CSE-MsgGUID: 4A2pn7/VQzCN8TnRDGSLrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="84478644"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2024 22:44:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 20 Oct 2024 22:44:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 20 Oct 2024 22:44:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 20 Oct 2024 22:44:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VacAtMrplt+OSx5fdhsGsdlKESJjrYt0wspu22svnOtOENWO3hMG280s4BYzaHrRtjRsbTXKoq4x7Hz2XWt8YxP/fHeou5bSHPfXvEVv8MUU7BZ7NVoYJq/8YespcROGD3FoqYXvgDQcwkWIrStFjTC/kAqvPf2JKKN5gQUSjNFaSkoT/zaM0/LeSQSJsQxI75YgXrn29cE2Qu7qK4RMOuVOVQVu8aFp/lUtd4NlCrw2q88Pp86DDhFiRRR/FwohkFAH2G6eRQ64k7oocoAOj+U73a7jL1EotfBE3AOAYeZz/UPDc5niQNFxYTk+A6IAhC8hnvvVBGbo/qo92jACTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNhlA51qhwVjQrMj9kCJhRYm17Mexf7gDoc12X9FUQs=;
 b=msQm1wvUTimlU3BreVjnM0N+xDCbqu666WM6YX/1/Vu3Mn9UE2nfgfgLWfR9+g1bsMtewjoOrguRAtgMqmYlybjnx12yxYekWg/8LbistYFeGBdTwgAAjP3Ao9uI3A4qQdocr6buWo27MdpoJI77vprJhSfH8jWIgxsLi4BBVwgwyNyqDVEIKRy/4ZrwN2NiII02543uJiLmEiNKNPmXfid8/sgCfN30GNxVuXmpAsmvzF9B+mMmBaOU2l89UivSjo0a2ACQsQX6mk3zWRd5p7C+Lfw2QBEUBmiy63eGcdVVcEM0hyziKl6vlUzs7Q8bOaMvnCxmTp5dilH/6XuEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB4988.namprd11.prod.outlook.com (2603:10b6:806:f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 05:44:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 05:44:35 +0000
Date: Mon, 21 Oct 2024 13:44:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>, "Vineeth Pillai (Google)"
	<vineeth@bitbyteword.org>, Juri Lelli <juri.lelli@redhat.com>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [sched/rt]  5f6bd380c7:
 kernel-selftests.kvm.rseq_test.fail
Message-ID: <202410211347.6d1c29b9-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:820::34) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB4988:EE_
X-MS-Office365-Filtering-Correlation-Id: cb543468-f6c5-4eff-f6bd-08dcf19370f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yPBiH4rY0RHQAwLepJoaOEGaiPQUubfydx/UtpMHeY1AvjphlqnRkB7sJTGE?=
 =?us-ascii?Q?xY4vqDEHWjOdxFooLGfnGwP5ifEg8R537h8WyuLgJN5QrXWLOuKmd6A0LeGm?=
 =?us-ascii?Q?xGOq4Lw1ZUCrGsA5/9k2ZnZgugUUxSkOiRAwOlC7W83dKRE6NxKICnPsSOS3?=
 =?us-ascii?Q?HHQ8hoAhQTdOUgvQ2Q9oGns7ankL6NNXVp9TM6dAWHVhhd0IECbct3CCZZnb?=
 =?us-ascii?Q?a2hr+mjQF/k774B8arezB01MPgdYIdzNWAsx+MboUSHJw2OhUeP+qzPVHqDv?=
 =?us-ascii?Q?PuLf+a4V4SiBwIUZROaUNK3vsla26BW/5pzXM6JlYQbDbH20ecqvDhFTEUVf?=
 =?us-ascii?Q?KjdW3oFcoTYwj3lW62PxEU1grpKNFcW7TfgBRr9z5dfWDLDDlysHhpgjjiYC?=
 =?us-ascii?Q?xJrDpB46K98KzxQHKB91lVqZVovYIgIOPDFB5KAzH5X3JqWaI34sGqXS/YzN?=
 =?us-ascii?Q?xbZrLew8PhaAJfjFiqW9hx0jJP2dJ23LkM3P8ucGVzFLpkunO1rrYpkhqnUa?=
 =?us-ascii?Q?lSk7WSJsEnbFpZ/1NVdcYnhURxaJQh3G/R3mIIS6dqmtpPJXo65MuY6dzMui?=
 =?us-ascii?Q?usOVReTrckqC93GpzpVBzDDJXhDC2fb5lJ/llWF48W8NYVj5ah29jeJ5ALHn?=
 =?us-ascii?Q?e0kCfpf9Jt+l9RSpgqot/g7MsTe81wiVWPkBbBCbNkK3qoAj6InsW0w8YzAw?=
 =?us-ascii?Q?jttM7WibJTbfW764BiGdCGeKE9Ucy5yfRxjGOFztcQqSjxiiV58dNm75mGb6?=
 =?us-ascii?Q?Ttlucdw2jEt7Xswgx7itt7AE0n4gGx3czMHUrJMhn2hCcc8OLNgcOmpsdgOB?=
 =?us-ascii?Q?9L+6paO2O5AiC3+ytaCCzhFjTVrgk3Y7sbWhxqwsinwzVEb0RMHdXaAOXmfr?=
 =?us-ascii?Q?glx9NumBNbL21dS2vgd6DAAZ6Ztopg4n4bQOUH1KYzGPOm8ryKdvPAtVB/rl?=
 =?us-ascii?Q?UEoynyNDU6NT2KBaJ+Lj18QgSAh8sJJ2660kaUdFXXsgva18nYSuKHIejinh?=
 =?us-ascii?Q?EhSM2IAJ8wR8yYfQCHuPKaKTQRU65h+eHhDUfxC6DALdw2fkWvUkF2LypMyX?=
 =?us-ascii?Q?Hy9fH2ivBU5qKAIZAHQUYcQ0s85fbdCJAHOmXWSGNHuwyZsGmIRzxXmgRle9?=
 =?us-ascii?Q?zKbRzD2C6oMoYvc9FZZATwxwaXDGqbDTnZEV0d4TrScQIHN2VH5giwav8vBa?=
 =?us-ascii?Q?sRBu8WPm5YRJ6jrpKRLCu8w395df1Nu8KIRZi/RWOgekKznvIkEbNUHFvxcV?=
 =?us-ascii?Q?9ZB6C5w0Qhhm9O8bk+xMEKbS8SJz8tRgxzCoUuvN9A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FquiveRtFZCAXW4BBV3/O1pcXb/yI88H/ckQc+WW0LPHChd3IWlMolCSLnPP?=
 =?us-ascii?Q?ETTcjXg0vzRAgFTxXap1KHCFelhgXP4eFJIJdNxeFaUitWKhmsC+zudJyJ+S?=
 =?us-ascii?Q?T9/gDYRVm5z1cnnEYx7Sh0VmW4mGBu0JszBKLFk2nIIsyqyT3ld/Tx/LFYRG?=
 =?us-ascii?Q?pLnStDLjMdIXLeK+oE+HrEqizBOUfsTxefs5IiNQEH4m2N1vmSS1gyIvm5UN?=
 =?us-ascii?Q?P43QN2KHNi2R3l66nQVLzO7JZhQ19cAO1XVvvG4JBzlLw7EaZHaNShlpUKIg?=
 =?us-ascii?Q?QsdWxx63VW3FivYdqATZCg1o/nnO924OTYr3K8wmAJLa8TmcWmpSdevx85BI?=
 =?us-ascii?Q?AAdYgqXxEAsHW9oCC4p702uI+ua1G4/l/D6fKkfSx3yACkwE22MMDEvWXxHK?=
 =?us-ascii?Q?rJWX7p9NZG5NigmLDcsNlc+0l3BQ6kz+4JSY5Mfl0vr4HWHdsQ5KbODy6400?=
 =?us-ascii?Q?tHZJzduVHJxreXDzmL3pFvFcDxQr9acD+sBY8OGB72YYfJkK9+8FiMzYbbGP?=
 =?us-ascii?Q?wwm7KlhFW71wQyiMG9dlstPp80iWWB1T9/QG9+Ja6los6UhYCrJKGq3JeiXU?=
 =?us-ascii?Q?DCZHrdzefY5yiZZsVcS+ddtfxVOcWSbUVXxwF4tfYkpaIRutk8l/ycdMK9jG?=
 =?us-ascii?Q?Cp3Gx9Aq47NfD4nr058qiwJD0JVdmYhnH5/J0JXZzDCtOCExWJX9ixjIM34E?=
 =?us-ascii?Q?BgWhNQ3uHBV/HDTpxqTQz1SnOhis8Ff8cGV+BzcxfF90df52PdmaT/V/lxRG?=
 =?us-ascii?Q?g17HS/CAdNUm5lYksk/W6yn1LIAqADfXXIp9Rggd6gmYjnifQU71Otx+lBbI?=
 =?us-ascii?Q?A98Duy/kl9PoL+BzFyabufEm2/WaeRWOSDcnjfAeZ+BZ2D0+b/SFRXvNNccK?=
 =?us-ascii?Q?B4nGAF53Oh47o6VoufWfnc2I9R4oPF3MPQA8Mp8bDIXZqWHAlUjQeTSAjDmT?=
 =?us-ascii?Q?VeI8EKx/sohqqifBwJWLglIjyNKje+UPG4lJZTUPwF4l2FDH0uHBqQHilfbI?=
 =?us-ascii?Q?9mEKHFCaNwAL0iIATxkHjTt0a5idComYhp6AyPVEy06kWmPEsNbhubQNcHDt?=
 =?us-ascii?Q?szB7DKFPQ+eNDDhmys8IXxurJe8C/a+cELbMWKKeLLHlMCfELyQie9QR6gxA?=
 =?us-ascii?Q?sp+JVgsk8hH+PSGIj0MlvDQA2phVzk8Ofcw171Pq/Zu72YZNMIA/bFiPiMvE?=
 =?us-ascii?Q?J1+FHcYLXms2k1m8DyJScOqvlUWy5ZDTXW/6Qvk2W1Ub2tTyBdtF9cuRahw/?=
 =?us-ascii?Q?QaoHmCDo3DsFcVErsLYGzhUhpXVICIwuZqMvSI8B39i9oNl4lMO9/gH12Rko?=
 =?us-ascii?Q?o3LYgsrnq5AuDLu9On2d9QA4186UcNqqfXmL9N9y347EY21eTPojN8yVLTbh?=
 =?us-ascii?Q?9znRlKpLV7INptwP4dXKJrTL7L9oviXJy5TlnY+g3pvLXGq1Gwmnv8MPiDay?=
 =?us-ascii?Q?HwP4dicsXAQXOxWY1PM7RO27UUzawcUgLRR+syOViqapYfB+kYjMLQd+MYJi?=
 =?us-ascii?Q?kAkIshOV042wHJ2t+t4OkkEczSmXzp0i3qoYzdtIC7Nyp8kM70oZLY1ITfPW?=
 =?us-ascii?Q?4ZNIdgVDWqEkPjQHWXvVRgbMF9kHq1Uo9HPDEtPpM92IqDpsWA1jxhL0Zo2M?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb543468-f6c5-4eff-f6bd-08dcf19370f3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 05:44:35.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tD6inqA+L5qFTnbT2DYvWcK2xxgtBqokM1NwcrwIvRXcAbH35lG8g35sctyRxjgI95cjCHnxdduBC9ACXp+XmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4988
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.kvm.rseq_test.fail" on:

commit: 5f6bd380c7bdbe10f7b4e8ddcceed60ce0714c6d ("sched/rt: Remove default bandwidth control")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      684a64bf32b6e488004e0ad7f0d7e922798f65b6]
[test failed on linux-next/master 2b7275670032a98cba266bd1b8905f755b3e650f]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-977d51cf-1_20240508
with following parameters:

	group: kvm



config: x86_64-rhel-8.3-kselftests
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


we noticed the issue happens randomly, 57 times out of 200 runs as below.
but parent keeps clean.

c8a85394cfdb4696 5f6bd380c7bdbe10f7b4e8ddcce
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :200         28%          57:200   kernel-selftests.kvm.rseq_test.fail



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410211347.6d1c29b9-oliver.sang@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241021/202410211347.6d1c29b9-oliver.sang@intel.com


# timeout set to 120
# selftests: kvm: rseq_test
# Random seed: 0x6b8b4567
# ==== Test Assertion Failure ====
#   rseq_test.c:293: skip_sanity_check || i > (NR_TASK_MIGRATIONS / 2)
#   pid=46138 tid=46138 errno=4 - Interrupted system call
#      1	0x000000000040299a: main at rseq_test.c:293
#      2	0x00007fc679e6e249: ?? ??:0
#      3	0x00007fc679e6e304: ?? ??:0
#      4	0x0000000000402a80: _start at ??:?
#   Only performed 47875 KVM_RUNs, task stalled too much?
# 
#   Try disabling deep sleep states to reduce CPU wakeup latency,
#   e.g. via cpuidle.off=1 or setting /dev/cpu_dma_latency to '0',
#   or run with -u to disable this sanity check.
not ok 78 selftests: kvm: rseq_test # exit=254

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


