Return-Path: <linux-kernel+bounces-377635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CED9AC19C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB18282EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DB1158D8B;
	Wed, 23 Oct 2024 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLA9DerM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADD6487BE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672221; cv=fail; b=LNn9bCha2bHKPk0c6itz3U+8eCFz8ulpYl+Imel99dcfALie547H7LEBdB0jF+GsW+/CvLvNHcaSyQuSfUttc4Uf9sj+7vFkOVykzg7uh+K6WpekHnNN0FDuaZTSH9tsP6V0sKqHp3D61K5raNSC82b/o2vN7+bRDfWV3ZO7AS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672221; c=relaxed/simple;
	bh=aI9mKwschhS4ZU+HtZMEhpwLxsxgFdaPWN2wPAx7XsY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=VOWob++7gQ7zBAoj1ayfieiKqPOBwFHa3Ohhjv4Vd2UZAr15oL5TPQaTbTNd1afY+weB6++V0SwEDQXDgabhZSx6Iu6dj4mrcna3b/6iFAfNwUaFnbexkA++206VAo34k5pErAGK5/VxUihw3rH+OBe2bDtd+cNT6kc5gONoB2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLA9DerM; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729672219; x=1761208219;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aI9mKwschhS4ZU+HtZMEhpwLxsxgFdaPWN2wPAx7XsY=;
  b=bLA9DerMi6yHk1eVA4StVjnZLLx9BurgUjQyjaUdbd/pxCZ3pgWHkfRC
   mn1NWd3tF1yg3dOlV0/xpdeZy+1KDlEJunk5WKRZ1H/NpknXh/abtvgzf
   ebzU4F7mfE2WXcRdqkAEiewFd7jjpMOX5wXdZsJDcotr4Qa0CY3I36B5Y
   eROKw/FiTprFm/lICi1BRzFUMLtxe+3YrKgA6XtRhBQmqDWB79g8aEBF5
   G8zEgNVEYCTgwVex01axEWvXyJ04uq8inCy+KHFj/gD3j/LfZdzvLDV2v
   BXYs7NhMBwwPDupZ784kvf7RixHulXLeZOom7irLfz8SsZ/EqNvII9543
   A==;
X-CSE-ConnectionGUID: Q9Ld7I+oR8a9iQYrc/Hq3Q==
X-CSE-MsgGUID: 1/mcNEn/RauVS49ZOyyNWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29184839"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29184839"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 01:30:19 -0700
X-CSE-ConnectionGUID: mq5YtED9QLGu+5G/7TRn4Q==
X-CSE-MsgGUID: 8+XuuoMZS3WCGqDQhEd09g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80132082"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 01:30:18 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 01:30:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 01:30:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 01:30:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQ+TFhVf/YNtxt5sboCS+vH8cMDRjpD86fKt7WWpxdiE2L0tLrRrf8X6p855RY6PtwcL4KQShuUJ3cq023gyW7bxxMwy9N5seccxm567Jj4SeqX2ycID3RVnQLKTvsffWt5GwQRsUzkGNa6T/CcqWC+6shwkeRvWNdy3q0NthKs9kUeHe6BR28pfUnewXMWfFrw9SYqPe/Kq6toWHjb6twbEbj5WaA9jops5/tHkuDObvSxKS+gUKq0haoipgm452NexhAwy4ciS8qWtRoFv8KGkBV4l5XkppsumsVPLNtkfZsZpWI59ZQ4HLz+LbgkynbGr0UUWpafW1ODOWpzJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEQ3Y3Jjz2Wh5C+SmT5HAsradbGdx4mjA3R9vQO1M8I=;
 b=u+gYrF752EUbjVD09w9miz51I5PAgTK97LVMCLASvqfS1klfsGMGEqdy5QvOK+XVxW2FIDoVbpeZz0U2nFkefTu4yKzrgq45OAX/r0vHX/+QoCFVuRXZNrcBcNf5DxTtSBpIuKxgaW3x0OykSGpP1Q6IDExbRdXro+ackFH2lT5OTny7+o0+lweWO57T0BBEuEEUBG5axbIbmr/ML/OsRZE1JSFucYc/huD/fNIneG4UZ5qDa80n7dUujcWVTOcG7qeMf5g9IwIkA7QPr/ZMmRjULmwyWE/dmW5zb+cWNOrM+tBW91jCyqV9vqMMng8jwY8anjkHKT15FB1gcbmlOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB8301.namprd11.prod.outlook.com (2603:10b6:208:48d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 23 Oct
 2024 08:30:15 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 08:30:15 +0000
Date: Wed, 23 Oct 2024 16:30:04 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yuntao Wang <ytcoode@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jonathan Corbet
	<corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	<kexec@lists.infradead.org>, <oliver.sang@intel.com>
Subject: [linus:master] [kexec]  816d334afa: Mem-Info
Message-ID: <202410231602.fecf96df-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 662a6dae-965f-480b-a464-08dcf33ceb43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y9xK9sAyNaXS0uLGW/6QiFAcjyHqq43sZY6caIXrO3A+K0a1G0vKnmSUypQM?=
 =?us-ascii?Q?MCOrWGaHDL7L11CtFjPRNpex2UinpoVHFk4H9rpV7s/2UCsgtRHgh+rhG71R?=
 =?us-ascii?Q?06+mouLDbYrZv8I+Yb5xs/Tg02xGpahgm2ym6m3DGJJz7ba0YGkmU9F9GceT?=
 =?us-ascii?Q?8rI+WnzOjub3iUhdi2vY0NGuA7+PKnqguwSd2BemBapEdZt42fHpJ9gwErja?=
 =?us-ascii?Q?tu7XbCYCfH/Sk9rS6emwbowMeyYB5gbmMJZLObTCbX7rBW2T7KUhm0MnLOCb?=
 =?us-ascii?Q?QqkEfB/UbDsxjyAUfIRQnmI0RNFE3GPoek1D/KNPpqgM899/nlh3PudOS0vS?=
 =?us-ascii?Q?7lpQFcFhP8+vHPo4Cm654hhvLyW5DtCDxO1EvVu9dN4N3KWHMhaHNpO3HPqT?=
 =?us-ascii?Q?0r9iQmwkR4AAM+Lmv1hZ/mgXGSPNERq6gXWD2o1JD8Ig4U++vwcLzakBMbjL?=
 =?us-ascii?Q?gaO8peAmtLDWFJPq/DA4jY/byVBq9Q7A8HDWJG9qV9SCzgjjje74e5cuba1T?=
 =?us-ascii?Q?IzoS/eeknvHvTD3kGi5nrkAcFMT9AxpiU6Xy1rOQwjkBVG5b1av5ds2+uaAf?=
 =?us-ascii?Q?efUwfV3pUSlRY3St+X1CQpjid/CRST8Z+BsU4SCf3SmVeQjXex58qJDMVN22?=
 =?us-ascii?Q?koy6NMXflP2y+YdaKLiegO4GfKd6FUY5ajK+KRP1i7OFuYrbwV9NQNjfx4BG?=
 =?us-ascii?Q?dbJhplhWSTwjYIajyLxamlkb1cPpUpIRQl7Y/biMz8YeuAkuvD7A7grZcz/5?=
 =?us-ascii?Q?dR7sbOw6pSetHQ+Q+OIcBniwA3SF6tlQ1sgSz2vgPwa24vWBAhOcsAl+99DM?=
 =?us-ascii?Q?OFmypsFhqtpWDr+jeztrfaaHL+IY+8ghBhgAjRtsKxXE7SBebblANOyIJiLj?=
 =?us-ascii?Q?VMuFd+OePAqGG5NzHm/PRsg+mXxPgnPrNrNiETWz4o6CtB22WiEjNCP6sUrh?=
 =?us-ascii?Q?kVL6khhWIwK/LZ1T2vOdj2+y32kHT0CvV0xKvWt6nULAdT9Xw3BzlwtqLKoR?=
 =?us-ascii?Q?WjItiHgEapNCfHTujnhiDy7K9bsaPfBj/ESasDKko1esJtxSIYQRw91F5Msh?=
 =?us-ascii?Q?IES6i+1icbkbOO0xmbvYGgLedveBmpEALaOsNapL7/LB6ADE58bJibQeGyuc?=
 =?us-ascii?Q?g08uKkn80Iakbdz76FVOy4PBjfazhcDHzDlJR5XhGI+Tqp1HzeK79MBKcLyB?=
 =?us-ascii?Q?1X7tXt463A5KcxcJNGbG3BX9FVMrO8AX13Z6lX7idKNNnJ+uq2F7EAVr4GYG?=
 =?us-ascii?Q?btxLnD2SxhGdt77plrpM3v4C07ZRI5DskeFdJ5T3Ug=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?euoggbXm9f3oSWsloVX2vfGXtTGEPk7ESW7y/w9Nr7QuweB8siCxV0CtDwqv?=
 =?us-ascii?Q?cWnjgb3VAslnkFpq1o8qFav93dbwsr6w8lfg7zPiC6QJQINyy/Zs57I8pVaZ?=
 =?us-ascii?Q?4AWLa13vu6VkWantDfdwzbXCJ1YxeNXNANYjjIRUM7QgirblzfIXjwGHGGam?=
 =?us-ascii?Q?O8KDZhQnz4ZrwWU7m6Vy4caRRaZbwvi26OyJimKnU65jm0bzs9sNXzT/KJLu?=
 =?us-ascii?Q?hc7gc2lyi0G5DidjBlWIHVtX6pt187pmDS5u1remSJxp5UFHKg0NBvmlqWC9?=
 =?us-ascii?Q?QJJCsm0lKV/hG7LJYoRVufPttg+GSMJLOfA4eNQsZMRZHPy8pHiTVBHSCXO/?=
 =?us-ascii?Q?9rigcxw0q+fZbjsO3261PKdHHzy+kzzqhID4nGi7jcxNCfl7tj+pTbdzLisb?=
 =?us-ascii?Q?QGwHQjrUJE0u+Dwch9L6Tz1Dj7colnEw8HguobS4z2CtY2dtsLKuHUuUIe3r?=
 =?us-ascii?Q?Onlgu9Hzq8ccezdSqW2aP3qjhXXYkdL2f7os98o9+OVSgym5S51Ch9O/RniP?=
 =?us-ascii?Q?I+OgJ14xGRut3G7zxEo2ge1t7z+9H00IJOM4pxMXcTG5owQP2sy5oaCoxbHD?=
 =?us-ascii?Q?mwQxzfY4Q6IUC0N72v5qtQPidlFponboj9btnvTBNK4sQxDkinuzvludoR3m?=
 =?us-ascii?Q?iXwNMlUZ3Fp4GKMcFTayDjg882+NGPX0HOr04iI0m0ecvf7QL8kudJD7vQ12?=
 =?us-ascii?Q?5CO51CRFRlQyeRHwY9M7ZhpUWMTOA/c1J9Efz545nh58Npkrd59OJa3XBMbT?=
 =?us-ascii?Q?ATvkEP03NvgrOxMViTlicjrbDyx+knV/sNmyHUZpwOykE9K4S8OVFMdyoh1F?=
 =?us-ascii?Q?znb0tpyBN57g6iCU110KdYQ0+gvcvWuxpaHmBD5onjLnxG9zuSB1PuXCeDp4?=
 =?us-ascii?Q?4mhiOnjTRgiLmpupLKDuwRRZEusQuYn+XyfokFGBVpZcxCyjYjfLjyB5j1aG?=
 =?us-ascii?Q?2Dco5mMPhu/E+7LJm248tOV86GPehGziua5VgMo1b+QyKlT/8XfRVmtOyVmt?=
 =?us-ascii?Q?ZK9tMpaAYII7NR2pQvxlcXc9S42UnMCFUebSHrtLax7BMEjNiXB680f/2dl7?=
 =?us-ascii?Q?tQWaoQtQ3puqWeLxD/CH1sVsrFQ19Z8V17KDNsSe2iKnGTAWf5gMbhgrTC+A?=
 =?us-ascii?Q?WD3DJM3pqL0g9wcklZlR0+55MIP95L16xrqXp1UBPuyjNsvXiypd96IHpz2K?=
 =?us-ascii?Q?wpwoAaP0DObdvmtO7nUcnMqyURbupcASoJF48xdnmkbLyxvBLBQq2lLY390m?=
 =?us-ascii?Q?LtFjBloTP+bFubVckQLJZpiTaKtVeJJ5csiUcucU+i2k78mQiqhTxFnguJ6q?=
 =?us-ascii?Q?vEoJ5WFI00MD04c5N+V86IjId5cBATO6GhBpdJDbaYQeWC2wd4Y8fLDR7T/B?=
 =?us-ascii?Q?QRe2K27Q7PPG9SslCiwIFp4iZIoRQ9VuQn6xYYV/V6whhGoVyGq9+8SQOD4c?=
 =?us-ascii?Q?g7eUaqoEy6DGhHzeq2zZBKIG/QkaKiLSUie5gfhcxRpWoSh1I0I7iNNcdWkw?=
 =?us-ascii?Q?AbKENkeny8NsvSN5eIbNqsSYQoNQd29OKBhJE3xPfSLw67ErcasuVYvpKTUq?=
 =?us-ascii?Q?SPdcjiXtlwD94lJQKeBMFQl2DtFPSN8uHPUWs12Xe9TZ/h+YhytsaZL/3Shh?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 662a6dae-965f-480b-a464-08dcf33ceb43
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 08:30:15.1952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpsjsHHjctieX1oJYyejlaq8Uw7SUlutMsI12OWIk2YNV43z0xLq+48lQYlMyxNGHc8LLvdQWaRc+ciV4oEM7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8301
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "Mem-Info" on:

commit: 816d334afa85c836080b41bb6238aea845615ad9 ("kexec: modify the meaning of the end parameter in kimage_is_destination_range()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      c2ee9f594da826bea183ed14f2cc029c719bf4da]
[test failed on linux-next/master 7436324ebd147598f940dde1335b7979dbccc339]

in testcase: trinity
version: 
with following parameters:

	runtime: 600s



config: x86_64-randconfig-r032-20220801
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


we observed the issue happen randomly but keep clean on parent


5c28913ed04b29ef 816d334afa85c836080b41bb623
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :100         41%          41:100   dmesg.Mem-Info


and from below Call Trace, seems be related to changes in 816d334afa. FYI


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410231602.fecf96df-lkp@intel.com



[  183.284967][ T2438] trinity-c2: page allocation failure: order:1, mode:0x10cc0(GFP_KERNEL|__GFP_NORETRY), nodemask=(null),cpuset=/,mems_allowed=0
[  183.287021][ T2438] CPU: 0 PID: 2438 Comm: trinity-c2 Not tainted 6.7.0-rc4-00178-g816d334afa85 #1
[  183.288291][ T2438] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  183.289719][ T2438] Call Trace:
[  183.290202][ T2438]  <TASK>
[ 183.290556][ T2438] dump_stack_lvl (lib/dump_stack.c:107) 
[ 183.291233][ T2438] dump_stack (lib/dump_stack.c:114) 
[ 183.291773][ T2438] warn_alloc (mm/page_alloc.c:3391) 
[ 183.292370][ T2438] ? zone_watermark_ok_safe (mm/page_alloc.c:3370) 
[ 183.293136][ T2438] ? get_page_from_freelist (mm/page_alloc.c:3513) 
[ 183.293882][ T2438] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 183.294602][ T2438] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4423) 
[ 183.295385][ T2438] __alloc_pages_slowpath+0x17d2/0x1b00 
[ 183.296285][ T2438] ? __zone_watermark_ok (mm/page_alloc.c:2968) 
[ 183.297011][ T2438] ? ftrace_likely_update (arch/x86/include/asm/smap.h:56 kernel/trace/trace_branch.c:229) 
[ 183.297719][ T2438] ? warn_alloc (mm/page_alloc.c:4041) 
[ 183.298306][ T2438] ? get_page_from_freelist (include/linux/mmzone.h:1651 mm/page_alloc.c:3187) 
[ 183.299017][ T2438] ? ftrace_likely_update (arch/x86/include/asm/smap.h:56 kernel/trace/trace_branch.c:229) 
[ 183.299639][ T2438] __alloc_pages (mm/page_alloc.c:4581) 
[ 183.300162][ T2438] ? asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:645) 
[ 183.300851][ T2438] ? __alloc_pages_slowpath+0x1b00/0x1b00 
[ 183.301627][ T2438] ? kimage_alloc_pages (arch/x86/include/asm/bitops.h:55 (discriminator 3) include/asm-generic/bitops/instrumented-atomic.h:29 (discriminator 3) include/linux/page-flags.h:492 (discriminator 3) kernel/kexec_core.c:303 (discriminator 3)) 
[ 183.302230][ T2438] ? ftrace_likely_update (arch/x86/include/asm/smap.h:56 kernel/trace/trace_branch.c:229) 
[ 183.302840][ T2438] kimage_alloc_pages (include/linux/gfp.h:238 include/linux/gfp.h:261 include/linux/gfp.h:274 kernel/kexec_core.c:295) 
[ 183.303436][ T2438] kimage_alloc_control_pages (kernel/kexec_core.c:369 kernel/kexec_core.c:480) 
[ 183.304126][ T2438] ? kimage_free_page_list (kernel/kexec_core.c:475) 
[ 183.304774][ T2438] kimage_alloc_init (kernel/kexec.c:63) 
[ 183.305362][ T2438] do_kexec_load (kernel/kexec.c:125) 
[ 183.305910][ T2438] ? kimage_alloc_init (kernel/kexec.c:89) 
[ 183.306496][ T2438] ? ftrace_likely_update (arch/x86/include/asm/smap.h:56 kernel/trace/trace_branch.c:229) 
[ 183.307107][ T2438] __x64_sys_kexec_load (kernel/kexec.c:255 kernel/kexec.c:235 kernel/kexec.c:235) 
[ 183.307750][ T2438] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:82) 
[ 183.308284][ T2438] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[  183.308968][ T2438] RIP: 0033:0x463519
[ 183.309465][ T2438] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db 59 00 00 c3 66 2e 0f 1f 84 00 00 00 00
All code
========
   0:	00 f3                	add    %dh,%bl
   2:	c3                   	ret
   3:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   a:	00 00 00 
   d:	0f 1f 40 00          	nopl   0x0(%rax)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	0f 83 db 59 00 00    	jae    0x5a11
  36:	c3                   	ret
  37:	66                   	data16
  38:	2e                   	cs
  39:	0f                   	.byte 0xf
  3a:	1f                   	(bad)
  3b:	84 00                	test   %al,(%rax)
  3d:	00 00                	add    %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	0f 83 db 59 00 00    	jae    0x59e7
   c:	c3                   	ret
   d:	66                   	data16
   e:	2e                   	cs
   f:	0f                   	.byte 0xf
  10:	1f                   	(bad)
  11:	84 00                	test   %al,(%rax)
  13:	00 00                	add    %al,(%rax)
	...
[  183.312022][ T2438] RSP: 002b:00007ffe4d586468 EFLAGS: 00000246 ORIG_RAX: 00000000000000f6
[  183.313222][ T2438] RAX: ffffffffffffffda RBX: 00000000000000f6 RCX: 0000000000463519
[  183.314330][ T2438] RDX: 00007f3d966eb000 RSI: 0000000000000001 RDI: 00007f3d966e9000
[  183.315440][ T2438] RBP: 00007f3d97011000 R08: 0000000000000051 R09: 0000000000001000
[  183.316561][ T2438] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
[  183.317678][ T2438] R13: 00007f3d97011058 R14: 000000000109a850 R15: 00007f3d97011000
[  183.318855][ T2438]  </TASK>
[  183.324046][ T2438] Mem-Info:
[  183.324538][ T2438] active_anon:5181 inactive_anon:9601 isolated_anon:0
[  183.324538][ T2438]  active_file:0 inactive_file:0 isolated_file:0
[  183.324538][ T2438]  unevictable:85008 dirty:0 writeback:0
[  183.324538][ T2438]  slab_reclaimable:24508 slab_unreclaimable:111403
[  183.324538][ T2438]  mapped:11081 shmem:7595 pagetables:757
[  183.324538][ T2438]  sec_pagetables:0 bounce:0
[  183.324538][ T2438]  kernel_misc_reclaimable:0
[  183.324538][ T2438]  free:22807 free_pcp:846 free_cma:0
[  183.365634][ T2438] Node 0 active_anon:20724kB inactive_anon:38404kB active_file:0kB inactive_file:0kB unevictable:340032kB isolated(anon):0kB isolated(file):0kB mapped:44324kB dirty:0kB writeback:0kB shmem:30380kB writeback_tmp:0kB kernel_stack:3776kB pagetables:3028kB sec_pagetables:0kB all_unreclaimable? yes
[  183.369581][ T2438] DMA free:15296kB boost:0kB min:16kB low:28kB high:40kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[  183.373381][ T2438] lowmem_reserve[]: 0 2813 13774 13774
[  183.374261][ T2438] DMA32 free:46624kB boost:0kB min:3064kB low:5944kB high:8824kB reserved_highatomic:0KB active_anon:8kB inactive_anon:2888kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129216kB managed:2958668kB mlocked:0kB bounce:0kB free_pcp:2712kB local_pcp:996kB free_cma:0kB
[  183.378286][ T2438] lowmem_reserve[]: 0 0 10961 10961
[  183.379256][ T2438] Normal free:42560kB boost:4096kB min:16040kB low:27264kB high:38488kB reserved_highatomic:4096KB active_anon:20716kB inactive_anon:35516kB active_file:0kB inactive_file:0kB unevictable:340032kB writepending:0kB present:13631488kB managed:11224244kB mlocked:392kB bounce:0kB free_pcp:492kB local_pcp:464kB free_cma:0kB
[  183.383570][ T2438] lowmem_reserve[]: 0 0 0 0
[  183.384357][ T2438] DMA: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB (U) 1*128kB (U) 1*256kB (U) 1*512kB (U) 0*1024kB 1*2048kB (U) 3*4096kB (M) = 15296kB
[  183.386517][ T2438] DMA32: 80*4kB (UME) 4*8kB (M) 4*16kB (ME) 6*32kB (UME) 3*64kB (UME) 4*128kB (UM) 3*256kB (UME) 5*512kB (UM) 5*1024kB (M) 2*2048kB (ME) 8*4096kB (M) = 46624kB
[  183.389206][ T2438] Normal: 524*4kB (UMEH) 445*8kB (UME) 410*16kB (UME) 382*32kB (UMEH) 154*64kB (UME) 41*128kB (U) 8*256kB (U) 1*512kB (U) 0*1024kB 0*2048kB 0*4096kB = 42104kB
[  183.391793][ T2438] 92505 total pagecache pages
[  183.392602][ T2438] 0 pages in swap cache
[  183.393232][ T2438] Free swap  = 0kB
[  183.393819][ T2438] Total swap = 0kB
[  183.394352][ T2438] 4194174 pages RAM
[  183.394916][ T2438] 0 pages HighMem/MovableOnly
[  183.395645][ T2438] 644606 pages reserved
[  183.396135][ T2438] 0 pages cma reserved



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241023/202410231602.fecf96df-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


