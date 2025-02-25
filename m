Return-Path: <linux-kernel+bounces-530409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BD1A43317
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C763B915C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F2A13B29F;
	Tue, 25 Feb 2025 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RU7mmLlo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF7B8172A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450777; cv=fail; b=ZajDujl4tRxkhTfqaLcoStRCRwWBUlhC3tvaieICpxpg2k0i8Sexvg7AD8hUa+IfLjMRa3QCM12/hNIovBhoOn/he9tyitJHSeHluQErth6j8iX6+VX1Ng+D+hWVCTfzhYWMW4d1rRKWC7SPL7Eypy0vUc5ewHEY0nWzVUlkHXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450777; c=relaxed/simple;
	bh=skMxBmfMqhAoNtVWaQSBezmI7ZsGKZg3EUl5ZXiSY2Q=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=b5g+rRzeldYuXyD/Z6C7PLw5Y6txfPqA6JKZHbTaioz+jiHFGrrpzjjOvfC0fDiE8xhfFbuaeB2l3O9zTuZuIrF8z6FyqoUA3XxRF1udDXEuhg2A1/y9ET/5zzXqqQDQ+chS86TA0KFzurlWpIVSZf8jn5QIQR57O/vAv9fbyA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RU7mmLlo; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740450776; x=1771986776;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=skMxBmfMqhAoNtVWaQSBezmI7ZsGKZg3EUl5ZXiSY2Q=;
  b=RU7mmLloGKPXN5ETDdl8pY6vT31Bfdxu3AtAFBWga4Ibas1aTEv6DK5x
   5PD8o0XdKJCGNfP4VzSlxMzxtcf36UAWbIDzUsfdSR7DWlSVtewCeRQmy
   5L1HzhAoxLP8/yHUc0ynqmiyLkqJdU6rHJ6Vp9TF2uuoVdjwsWYyQHi2a
   X5X76r/RdwX6s2mY2elTIS7C/Rniw9JrTCtnLpO4TIthcjp9RL/Rs9vwH
   AK3IRs6uYlf9gwiQfIB3SD1958lwlkuE1ZyQDiaYphQtWeGpoYXRIERYx
   nSSwQjpTYwMT+VtKOHJJQ84vo5jlId2b/dr5+n4nIaRkZiiGUramUAF80
   Q==;
X-CSE-ConnectionGUID: DcABFEvnRLSowdDnUpyvGg==
X-CSE-MsgGUID: W09Q50n8R8ymJK04OKg/lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41443550"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41443550"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 18:32:55 -0800
X-CSE-ConnectionGUID: zMP4AyB4T+aKRc6biMltOA==
X-CSE-MsgGUID: QvzALE9ZSWCvXxW33Ikafg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="121184402"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 18:32:54 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Feb 2025 18:32:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 18:32:53 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 18:32:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKbLeziTRjrK0FfCMd6wU/gRjbTx+ZgzeC7wmaMPpMgQGO2MgKiGa2VJuOorVLDCGLo0b3PZu0KwD0JPDxgcCiPVRVac27PoHuRUbxxfWQkj70BuWZldeOKWGkrRh/u9Q1PnhG7zir3Zk+4i5v3FCT4JvdDWtizxYiF83RO7DBXtdcwDYByyTA+viji0rYFSwpqp5IMjym7LcFucdJu6WWVRqMYzUBZkOSHSZgJekSNYAN1LYlptUFCly+iSPx2kWprqdWIz5B1jiaPS/JqonViUew92RvfTjKrpERyMPhiG38EgMgRV63BxflIYjfYxFEmgoLxM4oBk/LiGlSz3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDomcwdK1g2ldPE/EUpPe8crQRw2e8QZ98cC1q93h4Q=;
 b=vC7HTt86zXodyBETRzmhckQn6hdbJ34dOwSKy6k61Krux6/0pHXuQuFTBsXxIXUbCupkBGPCspQIz+xoA/plY4r2wO4y28Doo+dx00X8xWnz67u9RujsUGzMjSOm2CGUc2em13c9EGq9L3dAIYEuA5KUBiMB0ORShWVotTuDyAfXFx+CT75EX89D+V9EZUZqK6+eAfyJP+DoRLEg+c9WgkHGASXfcZjWsy+j0l1wPQ/VjuQjevsg7lrwRoRhfwBacXJEN3X/q3QZajgZ0T/pCnawX9ozoEK8k0dmn1cYyLjuw+sd3F+z9rdZS8ol+uWA6T1vvg20ynjIqpFiumS9+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW6PR11MB8392.namprd11.prod.outlook.com (2603:10b6:303:23a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 02:32:24 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 02:32:24 +0000
Date: Tue, 25 Feb 2025 10:32:13 +0800
From: kernel test robot <oliver.sang@intel.com>
To: zihan zhou <15645113830zzh@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Vincent Guittot
	<vincent.guittot@linaro.org>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [tip:sched/core] [sched]  2ae891b826:  hackbench.throughput 6.2%
 regression
Message-ID: <202502251026.bb927780-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW6PR11MB8392:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e59d01-e39c-4f01-e6c1-08dd5544a315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?WMKZ57n5aOYIa8SloCxXJ1PjeiCuY924UTwTQ2uzO3xuGtIFabwSCeBZF9?=
 =?iso-8859-1?Q?jyD46WUrkTYgKBkiWAhmLK3ZrTcg1Vy9YFBHT0lTyFAjAFbY2+TLwfTxOR?=
 =?iso-8859-1?Q?FesEpEuuI9CJJCvbx41Pmaehx+ArbMT+xtLzn6UpSu6mv1MGuFjtgAoa6S?=
 =?iso-8859-1?Q?k/1GeIT1Na6y67KwHLrZ8hplcO0wgPVvO7o4ty2+fmHEPjQ34+xIpIQaGz?=
 =?iso-8859-1?Q?yXkjhfzklYJzf0FBPeuQ9Ac+AdQy6Q99sOeiYS4xiBV5I2efHcPLoQtQ4L?=
 =?iso-8859-1?Q?5WUt6kg+mtaXuXf/HGv6tcD/PTvitarPxqAcBUa5xiR+uvwCb4T9taAwgO?=
 =?iso-8859-1?Q?nurPePrVwrG8XaftLZFkbb9w4isFWdMJTyO8WcEJn0Lol7zbP35tU2+HGO?=
 =?iso-8859-1?Q?MXPulnQFz7Q297TiGlW5pPrmzKI9H4DWNkbwrZ2yQu2uld4eyvAzTavsSt?=
 =?iso-8859-1?Q?06f+01ItW2mmE8bOQD8RYhVgK018S5yBgU/WI+5rPAcdO+zUd6ekEs7KMX?=
 =?iso-8859-1?Q?WlFboFKvCDSRpW9817NPwkh1qRj2lnw6Cp6W8iJrV7YFMKFa40wdY/1d2P?=
 =?iso-8859-1?Q?fJ+AuzfgKU6+QsjcWcs9D4zMCmSNmPPo1gu+Lj3ansmDbRKmAJlBQBFEja?=
 =?iso-8859-1?Q?2yDE5TZaQiXGgz2+9Y0rHRoCJTm/eUNEtRQ/jo4g1mbhVSk+3ixWmvAosB?=
 =?iso-8859-1?Q?vCie2RDlkIJeduPWeVLwJm8mCic+yvpGp26vHEdn1ysak5Z7gj9fJ/J88P?=
 =?iso-8859-1?Q?V5vGExzFDkmMrSckXskGeO62WNHTBZEqCoqTLTI/+uPMdJRmFvh/sAb/16?=
 =?iso-8859-1?Q?5PBw+DnkB+ru9PQ3wri0m/u54YtqVVCT004UW7TgfUnlS850DrIp/yX8CB?=
 =?iso-8859-1?Q?nsJgCLsyBRJ0inVArlT4wBl/+miaVJf0fsztSkXi7UflCrSNUr+9c9b8Uk?=
 =?iso-8859-1?Q?y3P+3nDI0Gs45pqY/IKXf4pR6/TSCisF3lMwnEmgr8/ny58kPgvkk5/4hP?=
 =?iso-8859-1?Q?hPseBwciTpM2Q2zdyhX9lO4PJqoAgYlhHaduWioCJQeZxhuZyGl75t4F+i?=
 =?iso-8859-1?Q?PWQb4L07NzTYn9MrIz7YFG31+zAnhiUPEYGeK2UBfBVGkohwLh9vbjgdDP?=
 =?iso-8859-1?Q?JAL14wErYHIoZayAj/eXX3bwvb8eiGRgdmWnHsffyzh4fMZ59idsk9LNx5?=
 =?iso-8859-1?Q?fT70TZY7coLxKzJWkg1ItR7QPpTfzSURGanIsTwJ4nnJdS7nO1jHY8muXU?=
 =?iso-8859-1?Q?wDECp08mgCWijyvfjPcLVApS/Q6TpU4PsGEr/ApiI3gJLV+xD7bwxZHR4y?=
 =?iso-8859-1?Q?n9ozldJGd1nO4CbprHy7JcNN5TOMHiNuoTIh1MMYQ4VnKpzUKUJXSU0rqm?=
 =?iso-8859-1?Q?OX5Wvr6f7HPHFzN/n8mnKlwPWjUTRLIw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?pcP9qMadDCfOsKVTw0jIFLgIUm1Qq2NqZ2LAXPjPZvfJFS07gQ3V3YG238?=
 =?iso-8859-1?Q?eNvB2LeSQpohtnJ1VkS02Xr5N8rZxE3I5c/9essEktBbXVseROXtKpGyz/?=
 =?iso-8859-1?Q?aOEWl2mCOeErdN5+3/ZqDdZDwMgwP9PovM+iSyVBKkfIOzjgZm+aLFTpSa?=
 =?iso-8859-1?Q?OrdXloJSJc6NHY5i6nxL2jW2EO2Yom55ptGCUueMWyu9+bELeGDofaqnE5?=
 =?iso-8859-1?Q?4a3y7N+AVF5ut4O5ml0NUlzoVmXtRETpxRze1LPnAILLPuUN95I4+2PXCI?=
 =?iso-8859-1?Q?xRy1KILz4s0+1LiLGXhpVUxWyHEGNX5lKXln9LtQly0vRM8l2Zz+a2Q/+K?=
 =?iso-8859-1?Q?FKb+9sEaVBx4In9pwHQCKI3mwsni0zzaccjZhVLYgTq1NODiQmSL1cb3Hy?=
 =?iso-8859-1?Q?26tnsWDrIRR2p3Z9/fOzNgbGn30btCx1rfnjL9Aq5D6Bj/s5GIyx1RVir/?=
 =?iso-8859-1?Q?1s6yRhaR0M69CH393bYoBFQY5USYYfuGBEW5NWmQ7rKtzX5Iun29f8u1Tw?=
 =?iso-8859-1?Q?EcFl/48/dN5VUP/olbLNiYQ8x0Drmsz4Ol/48QUQD4f4GvM+gzUf6GrPKD?=
 =?iso-8859-1?Q?/0Xn3pSoNsbApv69JqPeLZXmZGA8PJSKMAMaGqO4EizenqjiBcJW+TBJP3?=
 =?iso-8859-1?Q?Tgh0oyUA0dPP/K7oznzWAS/BhLvcn8qFMDYbAT351apVBuc3iS6ABpDo00?=
 =?iso-8859-1?Q?PuOd+aEuXSd385ZkW2wxX3Jw7aZQooSUowZ8rpmkusKxWtrwALi4U4OTLI?=
 =?iso-8859-1?Q?QZ3iWBNiH0QEaRseMtyisdjYJ2XsafmfLCn13GxkRL3cGzA4qyU7hpdRHJ?=
 =?iso-8859-1?Q?Y/jw+fN4+c5M9qLchaeyY7WvunR31ZXM3NgO/pWCjF+kSrYUUm14O9jEAA?=
 =?iso-8859-1?Q?lDapJdTfqu9NEY6jYAOe3i32Od9ZcpjR1zbIpHOzt7sdGF1J7+m38+Tbp7?=
 =?iso-8859-1?Q?bKDxaQIGKqs/KgUjy+MF43YHgUPdaB0CmCdaBF99O/Y9SNSgRIEc3awdeY?=
 =?iso-8859-1?Q?475laIZ7hZp3zDPeePk4RTwyyc2SVnsYPGfHY4ESOcNG4Nv7q57N5irN9G?=
 =?iso-8859-1?Q?D4yKfUerGlAJH69bsVWtoH3uHRAh66HIcUvb1WPYoZs9Bs0ny9BOtgb8kp?=
 =?iso-8859-1?Q?d9W9UJWwr3TRQQ9fc/ZA53O81qO6n1/+R4etNqjNGdICS5kjZVifzlRzzs?=
 =?iso-8859-1?Q?NUi9ADznnmsfwxtZ/LnFVOEmyTKsOaXSUF5O8UgTGEnILnJoGJGfDw1YO2?=
 =?iso-8859-1?Q?PvjRkJmenddS6K04yZGpDE7Aqc7nrnQgNMq5ktcY6KYsdBiC0wjzSFTeJ0?=
 =?iso-8859-1?Q?EW9qRVI5rLgSAk00Jcgjj0LoG+ndUlWdm824jjjVPEIKznl9USeF4SvP5d?=
 =?iso-8859-1?Q?ScTfWaKIuB4pteC1G9p452b2IjXTG/6eNos/WeGfytMRmTUW7zivoxVYan?=
 =?iso-8859-1?Q?123HkLHLtQeTqTCt6sPtXi0cNXtnPFOaUXv6WKhfcuJqbC+EcelhkfvXnT?=
 =?iso-8859-1?Q?QbpbP/plFPequnr6vCYTB5C3QC147o6eBuI8wLmyVWX2uSq1jKcc6S+gD+?=
 =?iso-8859-1?Q?mI7wGc9dMlRcSfk2Y+sUpFuk43YN0mtQlBbNpDCxftWlRopPnbQb8mW0rS?=
 =?iso-8859-1?Q?CKEb4L9yaAs/3ERJGQ+3WZyfFmtx9X4DcIkjepibobfuR3F3Vuo1P3Sg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e59d01-e39c-4f01-e6c1-08dd5544a315
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 02:32:24.2868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVI+ynESK4VCzAxemFZYgldqGgZ52KU2frmoW9HM16GVMzmx5prWSonKQUI9PcaUsTE8/anD/V18jp2juWTgXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8392
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 6.2% regression of hackbench.throughput on:


commit: 2ae891b826958b60919ea21c727f77bcd6ffcc2c ("sched: Reduce the default slice to avoid tasks getting an extra tick")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core

[test failed on linux-next/master d4b0fd87ff0d4338b259dc79b2b3c6f7e70e8afa]

testcase: hackbench
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	iterations: 4
	mode: process
	ipc: socket
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.membarrier.ops_per_sec  10.5% regression                             |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | nr_threads=100%                                                                           |
|                  | test=membarrier                                                                           |
|                  | testtime=60s                                                                              |
+------------------+-------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502251026.bb927780-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250225/202502251026.bb927780-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
  gcc-12/performance/socket/4/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/hackbench

commit: 
  f553741ac8 ("sched: Cancel the slice protection of the idle entity")
  2ae891b826 ("sched: Reduce the default slice to avoid tasks getting an extra tick")

f553741ac8c0e467 2ae891b826958b60919ea21c727 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      5457 ±  6%     +30.9%       7146 ± 11%  perf-c2c.DRAM.remote
      1156 ± 17%     +76.3%       2038 ± 19%  perf-c2c.HITM.remote
    790654 ±  2%     +22.8%     971104        sched_debug.cpu.nr_switches.avg
    659209 ±  2%     +24.6%     821703 ±  3%  sched_debug.cpu.nr_switches.min
   1706905           +20.0%    2047861        vmstat.system.cs
    296017            +5.8%     313318 ±  2%  vmstat.system.in
     15076 ± 48%    +121.3%      33360 ± 35%  proc-vmstat.numa_pages_migrated
   3389933 ±  5%     +15.3%    3907919 ±  3%  proc-vmstat.pgalloc_normal
   2565152 ±  6%     +27.9%    3280218 ±  5%  proc-vmstat.pgfree
     15076 ± 48%    +121.3%      33360 ± 35%  proc-vmstat.pgmigrate_success
    781.28 ± 57%    -100.0%       0.08 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      3394 ± 51%    -100.0%       0.08 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.18 ± 74%   +3280.0%       6.22 ±125%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     42.40 ± 41%     -62.7%      15.83 ± 60%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     86.80 ± 42%     -89.4%       9.17 ± 97%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
    977.49 ± 51%     -99.9%       0.95 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      3397 ± 50%    -100.0%       0.95 ±223%  perf-sched.wait_time.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
    433157            -6.2%     406447        hackbench.throughput
    423258            -6.9%     394005        hackbench.throughput_avg
    433157            -6.2%     406447        hackbench.throughput_best
    411374            -6.8%     383238        hackbench.throughput_worst
    143.13            +7.3%     153.65        hackbench.time.elapsed_time
    143.13            +7.3%     153.65        hackbench.time.elapsed_time.max
  39754543 ±  3%     +56.8%   62349308        hackbench.time.involuntary_context_switches
    623881            +3.9%     648284        hackbench.time.minor_page_faults
     17045            +7.7%      18350        hackbench.time.system_time
    900.50            +2.5%     922.71        hackbench.time.user_time
 2.019e+08           +23.3%  2.489e+08        hackbench.time.voluntary_context_switches
      1.61            -2.3%       1.57        perf-stat.i.MPKI
 4.411e+10            -5.0%  4.192e+10        perf-stat.i.branch-instructions
      0.41 ±  2%      +0.0        0.44        perf-stat.i.branch-miss-rate%
 1.744e+08            +1.6%  1.772e+08        perf-stat.i.branch-misses
     25.15            -0.6       24.50        perf-stat.i.cache-miss-rate%
   3.5e+08            -7.0%  3.255e+08        perf-stat.i.cache-misses
 1.398e+09            -3.8%  1.346e+09        perf-stat.i.cache-references
   1677956 ±  2%     +20.8%    2027400        perf-stat.i.context-switches
      1.49            +5.6%       1.57        perf-stat.i.cpi
     46084 ±  8%     +44.6%      66621 ±  8%  perf-stat.i.cpu-migrations
    935.91            +8.3%       1013        perf-stat.i.cycles-between-cache-misses
 2.175e+11            -5.1%  2.065e+11        perf-stat.i.instructions
      0.68            -5.2%       0.64        perf-stat.i.ipc
     13.38 ±  2%     +21.7%      16.28        perf-stat.i.metric.K/sec
      1.61            -2.0%       1.58        perf-stat.overall.MPKI
      0.39            +0.0        0.42        perf-stat.overall.branch-miss-rate%
     25.05            -0.8       24.23        perf-stat.overall.cache-miss-rate%
      1.49            +5.5%       1.57        perf-stat.overall.cpi
    926.46            +7.6%     996.92        perf-stat.overall.cycles-between-cache-misses
      0.67            -5.2%       0.64        perf-stat.overall.ipc
 4.382e+10            -5.0%  4.164e+10        perf-stat.ps.branch-instructions
  1.73e+08            +1.5%  1.755e+08        perf-stat.ps.branch-misses
 3.475e+08            -7.0%  3.233e+08        perf-stat.ps.cache-misses
 1.387e+09            -3.8%  1.334e+09        perf-stat.ps.cache-references
   1662988 ±  2%     +20.6%    2004942        perf-stat.ps.context-switches
     44600 ±  8%     +43.7%      64072 ±  7%  perf-stat.ps.cpu-migrations
 2.161e+11            -5.1%  2.051e+11        perf-stat.ps.instructions
 3.105e+13            +2.0%  3.169e+13        perf-stat.total.instructions
      8.54 ±  2%      -1.0        7.54        perf-profile.calltrace.cycles-pp.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      8.46 ±  2%      -1.0        7.47        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      8.30 ±  2%      -1.0        7.31        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg
      4.38 ±  2%      -0.6        3.81 ±  2%  perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      3.20 ±  3%      -0.3        2.85        perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      3.00 ±  3%      -0.3        2.67        perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      3.40 ±  3%      -0.3        3.10 ±  3%  perf-profile.calltrace.cycles-pp.skb_release_head_state.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      2.30 ±  3%      -0.3        2.00        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      3.25 ±  3%      -0.3        2.97 ±  3%  perf-profile.calltrace.cycles-pp.unix_destruct_scm.skb_release_head_state.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      3.07 ±  2%      -0.3        2.79 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      3.05 ±  3%      -0.3        2.79 ±  3%  perf-profile.calltrace.cycles-pp.sock_wfree.unix_destruct_scm.skb_release_head_state.consume_skb.unix_stream_read_generic
      2.50 ±  3%      -0.2        2.29 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      2.18 ±  3%      -0.2        1.99        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      1.99 ±  3%      -0.2        1.82        perf-profile.calltrace.cycles-pp.clear_bhb_loop.write
      1.95 ±  4%      -0.2        1.78 ±  2%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.read
      2.68 ±  3%      -0.1        2.54 ±  2%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
      1.55 ±  3%      -0.1        1.42        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      1.55 ±  3%      -0.1        1.42        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      1.35 ±  3%      -0.1        1.24 ±  3%  perf-profile.calltrace.cycles-pp.__slab_free.kfree.skb_release_data.consume_skb.unix_stream_read_generic
      1.04 ±  3%      -0.1        0.96 ±  3%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      1.12 ±  3%      -0.1        1.04        perf-profile.calltrace.cycles-pp.__check_object_size.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_write_iter.vfs_write
      0.62 ±  4%      -0.1        0.56        perf-profile.calltrace.cycles-pp.__build_skb_around.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      0.72 ±  3%      -0.1        0.66        perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_free_hook.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg
      0.63 ±  2%      -0.1        0.57 ±  3%  perf-profile.calltrace.cycles-pp.skb_unlink.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      0.57 ±  3%      -0.0        0.52 ±  2%  perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_write_iter
      1.17 ±  3%      +0.2        1.32 ±  6%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.42 ± 50%      +0.3        0.76 ± 22%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      1.36 ±  3%      +0.5        1.88 ± 21%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic
      1.38 ±  3%      +0.5        1.91 ± 21%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg
      1.43 ±  3%      +0.5        1.98 ± 21%  perf-profile.calltrace.cycles-pp.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      1.63 ±  3%      +0.7        2.28 ± 21%  perf-profile.calltrace.cycles-pp.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
     36.49            +0.8       37.34        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     35.51            +0.9       36.43        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     38.59            +0.9       39.52        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     38.32            +1.0       39.27        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     34.44            +1.0       35.42        perf-profile.calltrace.cycles-pp.sock_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     33.04            +1.1       34.12        perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write.do_syscall_64
      8.58 ±  2%      -1.0        7.58        perf-profile.children.cycles-pp.unix_stream_read_actor
      8.35 ±  2%      -1.0        7.36        perf-profile.children.cycles-pp.__skb_datagram_iter
      8.50 ±  2%      -1.0        7.51        perf-profile.children.cycles-pp.skb_copy_datagram_iter
      4.40 ±  2%      -0.6        3.83 ±  2%  perf-profile.children.cycles-pp._copy_to_iter
      5.77 ±  2%      -0.4        5.32 ±  3%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      4.41 ±  3%      -0.4        3.98        perf-profile.children.cycles-pp.__check_object_size
      4.80 ±  3%      -0.4        4.40        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      3.24 ±  3%      -0.4        2.89        perf-profile.children.cycles-pp.simple_copy_to_iter
      2.98 ±  3%      -0.3        2.64        perf-profile.children.cycles-pp.check_heap_object
      3.98 ±  3%      -0.3        3.64        perf-profile.children.cycles-pp.clear_bhb_loop
      3.44 ±  2%      -0.3        3.14 ±  3%  perf-profile.children.cycles-pp.skb_release_head_state
      3.31 ±  2%      -0.3        3.03 ±  3%  perf-profile.children.cycles-pp.unix_destruct_scm
      3.09 ±  3%      -0.3        2.82 ±  3%  perf-profile.children.cycles-pp.sock_wfree
      2.42 ±  3%      -0.2        2.23 ±  3%  perf-profile.children.cycles-pp.__slab_free
      2.59 ±  2%      -0.2        2.42 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
      1.78 ±  3%      -0.2        1.62        perf-profile.children.cycles-pp.entry_SYSCALL_64
      2.76 ±  3%      -0.1        2.61 ±  2%  perf-profile.children.cycles-pp.skb_copy_datagram_from_iter
      1.38 ±  3%      -0.1        1.25        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.30 ±  4%      -0.1        1.19        perf-profile.children.cycles-pp.obj_cgroup_charge
      0.65 ±  4%      -0.1        0.57        perf-profile.children.cycles-pp.__build_skb_around
      0.66 ±  3%      -0.1        0.61        perf-profile.children.cycles-pp.refill_obj_stock
      0.73 ±  3%      -0.1        0.68        perf-profile.children.cycles-pp.__check_heap_object
      0.59 ±  3%      -0.1        0.54 ±  2%  perf-profile.children.cycles-pp.rw_verify_area
      0.66 ±  2%      -0.1        0.61 ±  3%  perf-profile.children.cycles-pp.skb_unlink
      0.55 ±  4%      -0.0        0.51 ±  2%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.28 ±  3%      -0.0        0.26        perf-profile.children.cycles-pp.__scm_recv_common
      0.16 ±  4%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.is_vmalloc_addr
      0.16 ±  3%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.17 ±  2%      -0.0        0.16        perf-profile.children.cycles-pp.put_pid
      0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.manage_oob
      0.11            -0.0        0.10        perf-profile.children.cycles-pp.wait_for_unix_gc
      0.06 ±  6%      +0.0        0.08 ± 11%  perf-profile.children.cycles-pp.os_xsave
      0.20 ±  3%      +0.0        0.23 ±  7%  perf-profile.children.cycles-pp.__get_user_8
      0.06 ±  6%      +0.0        0.09 ± 17%  perf-profile.children.cycles-pp.sched_clock
      0.06 ±  6%      +0.0        0.09 ± 14%  perf-profile.children.cycles-pp.check_preempt_wakeup_fair
      0.09 ±  5%      +0.0        0.13 ± 18%  perf-profile.children.cycles-pp.__switch_to
      0.08 ±  4%      +0.0        0.12 ± 21%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.15 ±  6%      +0.0        0.20 ± 10%  perf-profile.children.cycles-pp.__dequeue_entity
      0.25 ±  3%      +0.0        0.29 ±  9%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.09 ± 10%      +0.0        0.14 ± 15%  perf-profile.children.cycles-pp.pick_eevdf
      0.13 ±  7%      +0.0        0.18 ± 14%  perf-profile.children.cycles-pp.__enqueue_entity
      0.08 ± 10%      +0.0        0.12 ± 27%  perf-profile.children.cycles-pp.wakeup_preempt
      0.01 ±200%      +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.vruntime_eligible
      0.01 ±200%      +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.___perf_sw_event
      0.01 ±200%      +0.1        0.08 ± 27%  perf-profile.children.cycles-pp.put_prev_entity
      0.31 ±  2%      +0.1        0.38 ± 12%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.22 ±  7%      +0.1        0.30 ± 12%  perf-profile.children.cycles-pp.set_next_entity
      0.14 ±  5%      +0.1        0.22 ± 22%  perf-profile.children.cycles-pp.pick_task_fair
      0.14 ± 44%      +0.1        0.24 ± 15%  perf-profile.children.cycles-pp.get_any_partial
      0.27 ±  5%      +0.1        0.37 ± 15%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.33 ±  4%      +0.1        0.47 ± 22%  perf-profile.children.cycles-pp.enqueue_entity
      0.30 ±  4%      +0.2        0.46 ± 26%  perf-profile.children.cycles-pp.update_load_avg
      0.48 ±  4%      +0.2        0.72 ± 26%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.51 ±  3%      +0.2        0.75 ± 27%  perf-profile.children.cycles-pp.enqueue_task
      0.48 ±  6%      +0.3        0.75 ± 23%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.49 ±  6%      +0.3        0.76 ± 24%  perf-profile.children.cycles-pp.__pick_next_task
      0.60 ±  4%      +0.3        0.89 ± 25%  perf-profile.children.cycles-pp.ttwu_do_activate
      1.67 ±  2%      +0.6        2.23 ± 20%  perf-profile.children.cycles-pp.schedule_timeout
      1.64 ±  3%      +0.7        2.29 ± 21%  perf-profile.children.cycles-pp.unix_stream_data_wait
      1.78 ±  4%      +0.7        2.53 ± 21%  perf-profile.children.cycles-pp.schedule
      1.78 ±  4%      +0.8        2.54 ± 22%  perf-profile.children.cycles-pp.__schedule
     36.58            +0.8       37.42        perf-profile.children.cycles-pp.ksys_write
     35.60            +0.9       36.51        perf-profile.children.cycles-pp.vfs_write
     34.52            +1.0       35.49        perf-profile.children.cycles-pp.sock_write_iter
     33.31            +1.0       34.36        perf-profile.children.cycles-pp.unix_stream_sendmsg
      4.37 ±  2%      -0.6        3.79 ±  2%  perf-profile.self.cycles-pp._copy_to_iter
      3.94 ±  3%      -0.3        3.60        perf-profile.self.cycles-pp.clear_bhb_loop
      2.27 ±  3%      -0.3        1.98        perf-profile.self.cycles-pp.check_heap_object
      3.29 ±  2%      -0.3        3.01 ±  5%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      2.03 ±  4%      -0.3        1.76 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      2.50 ±  3%      -0.2        2.25 ±  3%  perf-profile.self.cycles-pp.sock_wfree
      2.61 ±  2%      -0.2        2.37 ±  3%  perf-profile.self.cycles-pp.unix_stream_read_generic
      2.30 ±  3%      -0.2        2.09        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      2.37 ±  3%      -0.2        2.18 ±  3%  perf-profile.self.cycles-pp.__slab_free
      1.04 ±  4%      -0.2        0.86 ±  5%  perf-profile.self.cycles-pp.skb_release_data
      2.19 ±  4%      -0.2        2.01 ±  2%  perf-profile.self.cycles-pp.mod_objcg_state
      1.31 ±  3%      -0.1        1.18        perf-profile.self.cycles-pp.__kmalloc_node_track_caller_noprof
      1.33 ±  3%      -0.1        1.21        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.04 ±  3%      -0.1        0.93        perf-profile.self.cycles-pp.kmem_cache_alloc_node_noprof
      1.13 ±  3%      -0.1        1.02        perf-profile.self.cycles-pp.__alloc_skb
      1.38 ±  2%      -0.1        1.29 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.74 ±  3%      -0.1        0.66        perf-profile.self.cycles-pp.__skb_datagram_iter
      1.11 ±  3%      -0.1        1.03 ±  2%  perf-profile.self.cycles-pp.sock_write_iter
      0.80 ±  3%      -0.1        0.74 ±  2%  perf-profile.self.cycles-pp.write
      0.60 ±  4%      -0.1        0.54        perf-profile.self.cycles-pp.__build_skb_around
      0.84 ±  4%      -0.1        0.78        perf-profile.self.cycles-pp.sock_read_iter
      0.69 ±  3%      -0.1        0.64        perf-profile.self.cycles-pp.__check_heap_object
      0.62 ±  3%      -0.1        0.57        perf-profile.self.cycles-pp.refill_obj_stock
      0.82            -0.0        0.77        perf-profile.self.cycles-pp.read
      0.80 ±  3%      -0.0        0.75 ±  3%  perf-profile.self.cycles-pp.do_syscall_64
      0.51 ±  4%      -0.0        0.47        perf-profile.self.cycles-pp.__virt_addr_valid
      0.46 ±  2%      -0.0        0.43 ±  2%  perf-profile.self.cycles-pp.kfree
      0.59 ±  3%      -0.0        0.56 ±  2%  perf-profile.self.cycles-pp.__check_object_size
      0.44 ±  2%      -0.0        0.41        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.36 ±  3%      -0.0        0.32 ±  2%  perf-profile.self.cycles-pp.rw_verify_area
      0.43 ±  2%      -0.0        0.40 ±  2%  perf-profile.self.cycles-pp.unix_write_space
      0.37 ±  4%      -0.0        0.34 ±  2%  perf-profile.self.cycles-pp.x64_sys_call
      0.34 ±  3%      -0.0        0.31 ±  2%  perf-profile.self.cycles-pp.__cond_resched
      0.29 ±  3%      -0.0        0.27        perf-profile.self.cycles-pp.ksys_write
      0.30 ±  2%      -0.0        0.28 ±  2%  perf-profile.self.cycles-pp.skb_copy_datagram_from_iter
      0.18 ±  4%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.18 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.unix_destruct_scm
      0.21 ±  3%      -0.0        0.19        perf-profile.self.cycles-pp.__scm_recv_common
      0.25            -0.0        0.23 ±  2%  perf-profile.self.cycles-pp.kmalloc_reserve
      0.15 ±  2%      -0.0        0.14        perf-profile.self.cycles-pp.skb_unlink
      0.15 ±  2%      -0.0        0.14        perf-profile.self.cycles-pp.unix_scm_to_skb
      0.07 ±  9%      +0.0        0.10 ± 19%  perf-profile.self.cycles-pp.pick_eevdf
      0.09 ±  5%      +0.0        0.13 ± 16%  perf-profile.self.cycles-pp.__switch_to
      0.11 ±  7%      +0.0        0.14 ± 10%  perf-profile.self.cycles-pp.__dequeue_entity
      0.08 ±  5%      +0.0        0.12 ± 22%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.02 ±122%      +0.0        0.06 ± 17%  perf-profile.self.cycles-pp.native_sched_clock
      0.13 ±  8%      +0.1        0.18 ± 14%  perf-profile.self.cycles-pp.__enqueue_entity
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.vruntime_eligible
      0.27 ±  5%      +0.1        0.37 ± 15%  perf-profile.self.cycles-pp.switch_mm_irqs_off


***************************************************************************************************
lkp-icl-2sp7: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/membarrier/stress-ng/60s

commit: 
  f553741ac8 ("sched: Cancel the slice protection of the idle entity")
  2ae891b826 ("sched: Reduce the default slice to avoid tasks getting an extra tick")

f553741ac8c0e467 2ae891b826958b60919ea21c727 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1.08            -0.1        0.99        mpstat.cpu.all.irq%
     67.18 ±  2%     -11.9%      59.20 ±  5%  mpstat.max_utilization_pct
      3401 ± 19%     -31.4%       2332 ± 18%  perf-c2c.DRAM.remote
      2396 ±  3%     -23.1%       1844 ± 18%  perf-c2c.HITM.remote
     29248           +14.3%      33418        vmstat.system.cs
    788485            -9.1%     716631        vmstat.system.in
    191106            -1.7%     187946        proc-vmstat.nr_anon_pages
    535277 ±  2%      +5.6%     565009 ±  4%  proc-vmstat.numa_hit
    469052 ±  2%      +6.3%     498763 ±  5%  proc-vmstat.numa_local
     51285 ±  7%     +54.3%      79119 ± 31%  proc-vmstat.numa_pages_migrated
     51285 ±  7%     +54.3%      79119 ± 31%  proc-vmstat.pgmigrate_success
     16417 ±  7%    +131.4%      37986 ± 78%  proc-vmstat.pgreuse
    505.28           -10.6%     451.92        stress-ng.membarrier.membarrier_calls_per_sec
     97160           -10.5%      86939        stress-ng.membarrier.ops
      1618           -10.5%       1448        stress-ng.membarrier.ops_per_sec
     55094 ±  5%    +277.5%     207976 ±  9%  stress-ng.time.involuntary_context_switches
      3195 ±  2%      -8.3%       2931        stress-ng.time.percent_of_cpu_this_job_got
      1921 ±  2%      -8.3%       1761        stress-ng.time.system_time
   1047923            +5.9%    1109900        stress-ng.time.voluntary_context_switches
 5.501e+09 ±  2%      -7.8%  5.074e+09        perf-stat.i.branch-instructions
     30090           +14.4%      34431        perf-stat.i.context-switches
 1.041e+11 ±  2%      -7.6%  9.627e+10        perf-stat.i.cpu-cycles
     10683            +6.7%      11402        perf-stat.i.cpu-migrations
  2.73e+10 ±  2%      -7.6%  2.522e+10        perf-stat.i.instructions
 5.406e+09 ±  2%      -7.8%  4.985e+09        perf-stat.ps.branch-instructions
     29571           +14.4%      33836        perf-stat.ps.context-switches
 1.024e+11 ±  2%      -7.6%   9.46e+10        perf-stat.ps.cpu-cycles
     10498            +6.7%      11203        perf-stat.ps.cpu-migrations
 2.683e+10 ±  2%      -7.6%  2.478e+10        perf-stat.ps.instructions
 1.631e+12 ±  2%      -7.7%  1.505e+12        perf-stat.total.instructions
    698086 ±  4%     -12.0%     614339 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.avg
    918198 ±  7%     -13.5%     794083 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.max
    650282 ±  4%     -12.9%     566525 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.min
    698086 ±  4%     -12.0%     614339 ±  3%  sched_debug.cfs_rq:/.min_vruntime.avg
    918198 ±  7%     -13.5%     794083 ±  6%  sched_debug.cfs_rq:/.min_vruntime.max
    650282 ±  4%     -12.9%     566525 ±  4%  sched_debug.cfs_rq:/.min_vruntime.min
     13.48 ± 36%    +250.6%      47.25 ± 40%  sched_debug.cfs_rq:/.removed.load_avg.avg
     77.26 ± 17%     +91.9%     148.27 ± 24%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      5.08 ± 33%    +246.5%      17.60 ± 35%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    212.33 ± 20%     +30.1%     276.17 ±  7%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     30.44 ± 21%     +89.0%      57.52 ± 14%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      5.08 ± 33%    +246.6%      17.60 ± 35%  sched_debug.cfs_rq:/.removed.util_avg.avg
    212.25 ± 21%     +30.1%     276.08 ±  7%  sched_debug.cfs_rq:/.removed.util_avg.max
     30.43 ± 21%     +89.0%      57.51 ± 14%  sched_debug.cfs_rq:/.removed.util_avg.stddev
     15701           +12.8%      17719        sched_debug.cpu.nr_switches.avg
     11778 ±  7%     +20.3%      14165 ±  8%  sched_debug.cpu.nr_switches.min
   -202.17           +21.0%    -244.58        sched_debug.cpu.nr_uninterruptible.min
      1.43 ± 36%     -99.6%       0.01 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      0.94 ± 23%     -91.9%       0.08 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      1.60 ± 68%     -99.9%       0.00 ±223%  perf-sched.sch_delay.avg.ms.io_schedule.migration_entry_wait_on_locked.__handle_mm_fault.handle_mm_fault
      1.39 ±  8%     +71.7%       2.38 ±  7%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.membarrier_global_expedited
      1.95 ±  5%     +23.7%       2.41 ±  5%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.membarrier_private_expedited
      0.89 ±  4%     -16.0%       0.75 ±  3%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      0.01 ± 25%     +75.0%       0.02 ± 34%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.06 ± 11%     -37.5%       0.04 ± 40%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.80 ±145%    +478.8%       4.62 ± 52%  perf-sched.sch_delay.max.ms.__cond_resched.__mutex_lock.constprop.0.membarrier_private_expedited
      5.29 ± 41%     -99.9%       0.01 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      6.37 ± 13%     -93.7%       0.40 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      2.22 ± 49%     -99.9%       0.00 ±223%  perf-sched.sch_delay.max.ms.io_schedule.migration_entry_wait_on_locked.__handle_mm_fault.handle_mm_fault
     10.40 ± 13%     +32.1%      13.74 ±  5%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.membarrier_global_expedited
      4.55 ±  5%     -34.9%       2.96 ± 42%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.98 ±  4%     +33.4%       1.30 ±  6%  perf-sched.total_sch_delay.average.ms
     22.34           -12.3%      19.59        perf-sched.total_wait_and_delay.average.ms
    102076           +18.6%     121096        perf-sched.total_wait_and_delay.count.ms
     21.37           -14.4%      18.29        perf-sched.total_wait_time.average.ms
    515.07 ± 36%     +63.2%     840.46 ± 16%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     11.25 ±  5%     +56.4%      17.59 ±  7%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.membarrier_global_expedited
     15.80           -13.5%      13.67        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
    487.31 ±  4%     +16.4%     567.38 ±  2%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      8.00 ± 26%     +95.8%      15.67 ± 20%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1384 ± 12%     +58.1%       2188 ±  8%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.membarrier_global_expedited
     10678 ±  7%    +270.1%      39521 ±  4%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.membarrier_private_expedited
     85629           -12.4%      75039 ±  3%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      2443 ± 44%     -58.3%       1018        perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2099 ± 55%     -76.1%     501.21        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     15.94 ±  9%     -86.6%       2.13 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
    515.06 ± 36%     +63.2%     840.45 ± 16%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     15.25 ±  3%     -85.0%       2.29 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
    427.24 ± 78%     -99.6%       1.55 ±107%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     10.38 ± 53%     -95.2%       0.50 ±223%  perf-sched.wait_time.avg.ms.io_schedule.migration_entry_wait_on_locked.__handle_mm_fault.handle_mm_fault
     48.58 ±185%     -94.2%       2.80 ± 99%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      9.86 ±  5%     +54.2%      15.21 ±  7%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.membarrier_global_expedited
     14.92           -13.4%      12.92        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      1.30 ±  8%     -11.1%       1.15 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    487.30 ±  4%     +16.4%     567.36 ±  2%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6.13 ±141%    +268.5%      22.60 ± 17%  perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.membarrier_private_expedited
     25.13 ±  9%     -91.5%       2.13 ±223%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
     25.92 ± 12%     -86.1%       3.61 ±223%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      2260 ± 59%     -99.9%       3.00 ±118%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     13.02 ± 43%     -96.2%       0.50 ±223%  perf-sched.wait_time.max.ms.io_schedule.migration_entry_wait_on_locked.__handle_mm_fault.handle_mm_fault
      2443 ± 44%     -58.3%       1018        perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2097 ± 55%     -76.1%     500.54        perf-sched.wait_time.max.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


