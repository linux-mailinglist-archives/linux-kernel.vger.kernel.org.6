Return-Path: <linux-kernel+bounces-574947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BABFA6EBDC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019AF3A3604
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD10253B4B;
	Tue, 25 Mar 2025 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCGoEJeb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7E52517B8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742892074; cv=fail; b=Bg32+fTkL9dfIpfss5H/j30IbstVYAGn98oLHjVHCSRTioSX3yZ7TID+fa9N3srdx9N/7shChDDeWI4hooSv4HHcUx1F8/AqwFhta3etrbf9vYgMHG1DvRnPfPkxo9dPQwL7UCswrq5hBt2+rFVhrxgGSPzVGFx7dA48QhBPJCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742892074; c=relaxed/simple;
	bh=vQJAt6brMoyMmzDw15HtjLWqzvS6Dj3ORQHa1Ih7LYE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o3BvCukCsCCGhySU5Ze4O8KfKaeMFIA+3FLiv1XEZxDI4LGsKoB4Eu5JOhgll5Cr9P6p5VGYMsQDYO+iLA3NwQLst3+apA0kCXtOHKBGvSy5dHtNkNWdVGj0jjt5GXftvjfm6U3/PpIToJdcslq9azEunnjOZ9+Z0kqJExPffnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCGoEJeb; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742892071; x=1774428071;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=vQJAt6brMoyMmzDw15HtjLWqzvS6Dj3ORQHa1Ih7LYE=;
  b=HCGoEJebo9JpYXek5YU4TUOPS2UqHYykC7X+/MGoxhOZjnP/bFo+v0mR
   0v8Be8fcFnziTUsew9ibwuUznjf38FCmEvKCnrGrxpiZdT17QEBZcstOs
   Kf2+UM+cg3y/KJL7l0L3YU/85FFlXiCTKnFAu4Ub6ko1/ZWhyeZgTPo6X
   oEBAlTOT7dsxxYEWsjcBd9usIXEMHKrygGlGuSSzyBL85LSM5CO38rWn5
   AhtVka7x6ZX8ComWDPxjYB2D01FKNIjShoFgUPS5wnj/0Ez0nEbDp07SP
   YHd5K1NcSbe6m7SBVePnlIKFoDmQwUV7/gxgbjZGbJpJz1k65eadRz/gm
   A==;
X-CSE-ConnectionGUID: gRmVK2NgSWif/xBzQ4P19g==
X-CSE-MsgGUID: ZQCCPR5VRwSOgEsbf8sw+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="54772344"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="54772344"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 01:41:10 -0700
X-CSE-ConnectionGUID: z0lFiUsyS4ezU2cqGIRlRg==
X-CSE-MsgGUID: 3SHXpWplSnGlHRuvMAKcsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="129130523"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 01:41:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Mar 2025 01:41:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Mar 2025 01:41:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Mar 2025 01:41:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eny65+Sr8hDaJjIIXnn7bY2yxIcXS8MsigCYz28VEHHEkuftKf0djtXXYTKK+/o37C26I5vR6dVjpY2m+X4f3bMB6/gV8H5i/EKQeU4M7DA48CS20VQTPIKufs0Ttg12l9AqBSUni6d/t1DZXvq+Oc4iUnOgFxfogbEwL9uFDWpJmJsEO3T+NoDCBt+YQJgsIbsT6aUh+eSHKSgBxEpJ4sn5W1xwzo3JxXgtzOjkwzMJj9ru7uonQO8PaNa8dD7/QLpN3/s5pnIZMyyxZr4kH/qZOkcHNWnWjAeqAKqxB0plVmKpd7RWHf5jVi6Qaf4qnsaafjZPyfZaNOifMj7qGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBTD/rTD/RnMeqTRxStgN8EgvQZtifwDbRV6+aa1p98=;
 b=eDFQntVdJSz7fNcel8I2JwGJnrreM/VKJ4r0HiOBxQkjeBTNbP48XfeDyqtjo6ls3y/RZBHxQ4MEQMa+pamsEjSyVNxZ0uUVR564tMz/KNR+ukHWHCOtenfVaWrcK6Hkvc7e6sUn1JQvROfMPnUN68Nc4NefrjBsSgPvyjq9q22OSkdJZIvJB8cgvPlijccqcXXGmZFvpF0k2GR+pHw3DZI+532U5KQR5Ocit8RhWrePGj7UrPVn1YmHeRb3muNEiuWaSyJfzDFS8MM7uKmSVoeBioJHsuMyBdc0G83swW4TRp7BEkSfBZ+38Tk4DFnAFN11h2H5ghP+ugiLCNwULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB8199.namprd11.prod.outlook.com (2603:10b6:208:455::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 08:40:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 08:40:53 +0000
Date: Tue, 25 Mar 2025 16:40:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yang Shi <yang@os.amperecomputing.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, kernel test robot
	<oliver.sang@intel.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	<linux-mm@kvack.org>, <ltp@lists.linux.it>, <Liam.Howlett@oracle.com>,
	<vbabka@suse.cz>, <jannh@google.com>, <akpm@linux-foundation.org>,
	<yang@os.amperecomputing.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH] mm: vma: skip anonymous vma when inserting vma to
 file rmap tree
Message-ID: <202503251554.34a0b29b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250312221521.1255690-1-yang@os.amperecomputing.com>
X-ClientProxiedBy: SG2PR01CA0179.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::35) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a03146-4bc6-4824-4e86-08dd6b78c11b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1qcl2NHzJ9gUaS1Y0E16f2QxlAqVNarFuvAMBnKhLinhIdyjjKdMMZlJ3lRA?=
 =?us-ascii?Q?QJr6tqW1AFFOZmRrBUHTm7JXvUZEXtOu5+S75PWUL31d/nCjNHndzxRW8I1s?=
 =?us-ascii?Q?OtU+5KLjdbf4p7fN8ll31cm/ewHAVGB6h8IqhbPfd8/u8Yb/7+7s78jfyrc6?=
 =?us-ascii?Q?B50/Y9xLvhUUf72lV1YFtqImWAnMR9bl1I911P5eECeJHg6RW6gYDYU3KzGW?=
 =?us-ascii?Q?Mz+LZvNMEHIPOnILvksgfiKLue0dU1c+0OBC3CmIlJv0gfMyJGImNwf49GUh?=
 =?us-ascii?Q?ZojswilZaQvKLEuem+KXYVuy+rznM5VI1a1Xzly0/c9LxmoO6Ce7xY5yxgKF?=
 =?us-ascii?Q?9LvmkYbNG8eGAMzeOyEHLZ+vr421l3r2zqHG0Y/g8g7R2m/7i4Jh9104656Y?=
 =?us-ascii?Q?j8jlot6UT9J29zW31vDpsoA+7JSjCpgzg+tdkOnnBgSFdXp1AaB3wuO+hqOm?=
 =?us-ascii?Q?HkgD+hGPUwt3tLQZeclarwNyQ3nhroGKM9vI8Fu9L3sDt4ZmPua+8Mf74GZB?=
 =?us-ascii?Q?hoKnauribS6ksFHxVeT/qZGGBN1v3CCSWjc/Ou+GNVxXvoGwbdFrn40dlJ4Z?=
 =?us-ascii?Q?S/GumFO4xDy9o9rvySs0Ion62vb5fUtn9vt2FnXJQGFtQZl10/MGHJr6W4nV?=
 =?us-ascii?Q?s9vYsvJ1EXN7egXQ/PGNrX5LnPWUKcIh2fjBNFHM5+IYnLJZ4jZsw8lbBxtX?=
 =?us-ascii?Q?kbJ+IS0zwErmL4KHTwk2Yo23PL0sCN824dOfMTn2Mx9zH3lMM+opZHfnXZeg?=
 =?us-ascii?Q?jeI05mn2LEMKkFzr9lAe1tm+yu1IE02Co8VX/gHMHoFQ+7IwOZET2656RwTI?=
 =?us-ascii?Q?b0pqcWj9OuT4QHhxqvHPkXDjLIejpVrGb8UjFJZW3xOd7PtXiAGniBuvtIlQ?=
 =?us-ascii?Q?/Y08dbnDSgoye1DNxJhi67lmHfq5/FNUpIHthJSRMSttSqkpuptXCWo87fC/?=
 =?us-ascii?Q?A1Q+LQKlW+oUMmFrbFh7Ld7jrnVJCIXy2KZCtIcRPez7JgzhKkmwXIuXLQtr?=
 =?us-ascii?Q?lvZBmGeC6uIqQ0IkWZgvT+a2w5XTIvk5XsDm9hu7ESH1AupTu0+N9bRcyCs0?=
 =?us-ascii?Q?AKvRoQlh+gv+rY/7eJggcZfdVj23kHVlu5C4nDsBJp73Inud33nuF0UsbcXn?=
 =?us-ascii?Q?PowTI+Qx8B7DenyX0JdgWk6LU6qcGDfLpB36NCQkpHBsTvwqo6+wB9uEOu/a?=
 =?us-ascii?Q?VPcg2usxKd5XAtWFdp1UHlUxW9M3jwqfklIK7rms64G3XTjEEQJt9swnpYjH?=
 =?us-ascii?Q?TeCoVYjCqENGSGyrZ38ooQhji0sz7wX10PO95jpc3xre5r1WD1AwtSv/HW+8?=
 =?us-ascii?Q?z0ykolH0BEN6xnCUZJ5zypykctVKSOsu3tWXL26lCG5y1Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U5GaDkCk3gLo9enNcWtUaoq3xSWTehUbcqiLVZ3Gewu0eL9GcYaeJ1Op+D+F?=
 =?us-ascii?Q?1T+CGiMYN5R3dDnRwXJWbrFvtjFhZJ2C+0xdu7ib0mpmQLG6Zz8g2XCmJbTj?=
 =?us-ascii?Q?Atwj4lZgFQBGMGmiXC40T2YhY1voqirCeKbTyH5Yf74Yf9bDvhb22EBFoMq9?=
 =?us-ascii?Q?o98qNEdpjVAbzAniwEcvDQWQj3iWBg5wecp+j/cindtuLb0YL7JLksJdTNgd?=
 =?us-ascii?Q?qikuUv5h0h4sGnfXC4SE5nfYUwtXr45cb4YlRT3S0kFpcEyuZhGQvrXiEgL5?=
 =?us-ascii?Q?1dr5vWyWqVWHYlzeul91w7KNHUb3xC5B85qC4MhMM/2YIrAJ+OG9MmbrUg5a?=
 =?us-ascii?Q?EByGLEM2B990LL9LBMpwQZ83cGS/tQ/68dTdZEZQtw6LPTJHvVtH9LNef+TU?=
 =?us-ascii?Q?iUc51QpYdRHqtn8SfWroxZpNaEFRx8zdapR4rE8F/tRpd0EgLku6qseAHscN?=
 =?us-ascii?Q?8BCE3PklnFV1tCrIkBg4PD954Ek03emcns5OC1WHMpAWw98iSNoXzoP+fDcj?=
 =?us-ascii?Q?vDfV25sF1CBWKc2JnPF8DEpde4xki45BLpJ+pLBOdek0O173/dGXMbZnL539?=
 =?us-ascii?Q?JKN4LAR0q4AMu5bsGARHz+OugXkJuynZ7TetArdxwm+9e3JeMghBKYA2oliG?=
 =?us-ascii?Q?A8iatKGGwIKNJV02zMdaZ3pts0elQPf5m5bVCLw2XShfKOz7snpuBriRwH6n?=
 =?us-ascii?Q?ojIopKinyQrfPBlFiUsMtiewFIbY/KsfOMB8XzURyHr2dnzO37h6QrWIue5o?=
 =?us-ascii?Q?Ewk9VG9I6IgyDnupcKMKNmDIkIaou54mrkbpmdEQrHhRviB1237wAFuezcCe?=
 =?us-ascii?Q?/L0KsdzuEfGC4YI1C6UNkeZiAuHqMAZXBBWxkiFJQz76rNcyKukBUlfWmKZm?=
 =?us-ascii?Q?kKuKl6E1vz8NNu/Uv3dnytwjKssaQJn+tZ2JnqjxTMtuq28wlqYBcUZl0zff?=
 =?us-ascii?Q?Pspaobip7kUis6cuSpqEq1FT8BwxYGVbXTsTC/nllbQOBeNdfQdpb5inaGG5?=
 =?us-ascii?Q?gDk1AXdRhCeeRgV5XAN4RY707X57jQVAEYToxAjPnEgbxYSsbcmvoOcLjpuQ?=
 =?us-ascii?Q?yM4+DRqQhh/IOdE0zwxWOSAQCKPi1/YIB/A/6iQqQaZcEP1j5dAzhBmMd77I?=
 =?us-ascii?Q?wXt7DsxA8/wrHt1UjpGFU757qMoqcinMD2o7dCvovnl+bPJoabrKIdiDx+L0?=
 =?us-ascii?Q?WLHuyAaEdO/b1+kdLUTzF60NxjJvpnjQnEeOMJf/RItS+Uw01DCPUftgcvBc?=
 =?us-ascii?Q?EJLiAhIDGYU0VOK5YQuEKayV5q14ma5VfjTGiX/eTeUZIBH87XDeH/aNe8L9?=
 =?us-ascii?Q?WvWxqeXmWQZbRJRrNoSM2mIBQ0ykG5cTCe95tclq7zuvC+cs1LHR8bvIuy+k?=
 =?us-ascii?Q?4ZjcuZJ6ImrkUeWtScxPN62pTs5hyrTIdnKt7IrvXdhSedqRmNeL+O3+i9B8?=
 =?us-ascii?Q?OVvmgT/2/sYLe1yrNJ04ONP77VN3J1F357TUbQkU2ztAdyyNGnu+BL1gLIDG?=
 =?us-ascii?Q?+NxR/9yNpM8vxL7o2ztK+oylxis5TMzS/ieDelXI0KcKs8hMffhfa/+8jMK1?=
 =?us-ascii?Q?et3Ge4onAxfFMPPGvXI4sGuqcW4fmQPKUiiwfYGot55AOntAmh1zpUOXqz7U?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a03146-4bc6-4824-4e86-08dd6b78c11b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 08:40:53.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKwXQ9WXnBWfgftkcGVuizyf/xzArUpYkpINsRu2aHyYQ70jLbi8gAGMgyJJqL7mDnsIqWGssqFzzKe7PmcXuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8199
X-OriginatorOrg: intel.com


hi, Yang Shi,

just in case below report could supply any further useful information to you.


Hello,

kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]PREEMPT_SMP_KASAN_PTI" on:

commit: 13671c9499a4883f6bece7229463ff89a48709f6 ("[v2 PATCH] mm: vma: skip anonymous vma when inserting vma to file rmap tree")
url: https://github.com/intel-lab-lkp/linux/commits/Yang-Shi/mm-vma-skip-anonymous-vma-when-inserting-vma-to-file-rmap-tree/20250313-061727
base: v6.14-rc6
patch link: https://lore.kernel.org/all/20250312221521.1255690-1-yang@os.amperecomputing.com/
patch subject: [v2 PATCH] mm: vma: skip anonymous vma when inserting vma to file rmap tree

in testcase: ltp
version: ltp-x86_64-042eff32a-1_20250322
with following parameters:

	disk: 1HDD
	test: mm-00



config: x86_64-rhel-9.4-ltp
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503251554.34a0b29b-lkp@intel.com



[  557.087938][  T349] mmapstress10    0  TINFO  :  Using /tmp/ltp-2cGaEA7GG8/LTP_mmaUxM2MU as tmpdir (tmpfs filesystem)
[  557.087946][  T349]
[  557.102809][ T3834] LTP: starting mmap10
[  557.103401][  T349] mmapstress10    0  TINFO  :  Using /tmp/ltp-2cGaEA7GG8/LTP_mmaUxM2MU as tmpdir (tmpfs filesystem)
[  557.106782][  T349]
[  557.119531][T141949] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
[  557.121506][  T349] mmapstress10    0  TINFO  :  Using /tmp/ltp-2cGaEA7GG8/LTP_mmaUxM2MU as tmpdir (tmpfs filesystem)
[  557.132309][T141949] KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
[  557.132314][T141949] CPU: 1 UID: 0 PID: 141949 Comm: mmap10 Tainted: G          I        6.14.0-rc6-00001-g13671c9499a4 #1
[  557.132319][T141949] Tainted: [I]=FIRMWARE_WORKAROUND
[  557.143013][  T349]
[  557.151409][T141949] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
[557.151411][T141949] RIP: 0010:__rb_insert_augmented (kbuild/src/consumer/lib/rbtree.c:115 kbuild/src/consumer/lib/rbtree.c:459) 
[  557.164270][  T349] mmapstress10    0  TINFO  :  Using /tmp/ltp-2cGaEA7GG8/LTP_mmaUxM2MU as tmpdir (tmpfs filesystem)
[ 557.167616][T141949] Code: 00 48 89 da 48 c1 ea 03 80 3c 02 00 0f 85 a0 05 00 00 48 8b 2b 40 f6 c5 01 0f 85 44 05 00 00 48 8d 55 08 48 89 d1 48 c1 e9 03 <80> 3c 01 00 0f 85 94 05 00 00 4c 8b 6d 08 49 39 dd 0f 84 7f 01 00
All code
========
   0:	00 48 89             	add    %cl,-0x77(%rax)
   3:	da 48 c1             	fimull -0x3f(%rax)
   6:	ea                   	(bad)
   7:	03 80 3c 02 00 0f    	add    0xf00023c(%rax),%eax
   d:	85 a0 05 00 00 48    	test   %esp,0x48000005(%rax)
  13:	8b 2b                	mov    (%rbx),%ebp
  15:	40 f6 c5 01          	test   $0x1,%bpl
  19:	0f 85 44 05 00 00    	jne    0x563
  1f:	48 8d 55 08          	lea    0x8(%rbp),%rdx
  23:	48 89 d1             	mov    %rdx,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
  2a:*	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1)		<-- trapping instruction
  2e:	0f 85 94 05 00 00    	jne    0x5c8
  34:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
  38:	49 39 dd             	cmp    %rbx,%r13
  3b:	0f                   	.byte 0xf
  3c:	84 7f 01             	test   %bh,0x1(%rdi)
	...

Code starting with the faulting instruction
===========================================
   0:	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1)
   4:	0f 85 94 05 00 00    	jne    0x59e
   a:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
   e:	49 39 dd             	cmp    %rbx,%r13
  11:	0f                   	.byte 0xf
  12:	84 7f 01             	test   %bh,0x1(%rdi)
	...
[  557.167620][T141949] RSP: 0018:ffffc9002edff800 EFLAGS: 00010202
[  557.169827][  T349]
[  557.178054][T141949] RAX: dffffc0000000000 RBX: ffff88810b878308 RCX: 0000000000000001
[  557.178057][T141949] RDX: 0000000000000008 RSI: ffff8881051ec2f0 RDI: ffff8887de397c58
[  557.178059][T141949] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed1020a3d868
[  557.178061][T141949] R10: ffff8881051ec347 R11: ffff8887de397c20 R12: ffff8887de397c58
[  557.185709][  T349] mmapstress10    0  TINFO  :  Using /tmp/ltp-2cGaEA7GG8/LTP_mmaUxM2MU as tmpdir (tmpfs filesystem)
[  557.194702][T141949] R13: ffff8881051ec2a8 R14: ffffffff81c1fa50 R15: ffff8881051ec2f0
[  557.194704][T141949] FS:  00007f318f741740(0000) GS:ffff888759880000(0000) knlGS:0000000000000000
[  557.194707][T141949] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  557.214407][  T349]
[  557.220440][T141949] CR2: 00007f318f917710 CR3: 000000015f928002 CR4: 00000000003726f0
[  557.220442][T141949] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  557.220444][T141949] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  557.220445][T141949] Call Trace:
[  557.220447][T141949]  <TASK>
[  557.224320][  T349] mmapstress10    0  TINFO  :  Using /tmp/ltp-2cGaEA7GG8/LTP_mmaUxM2MU as tmpdir (tmpfs filesystem)
[557.230618][T141949] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:421 kbuild/src/consumer/arch/x86/kernel/dumpstack.c:460) 
[557.230624][T141949] ? exc_general_protection (kbuild/src/consumer/arch/x86/kernel/traps.c:751 kbuild/src/consumer/arch/x86/kernel/traps.c:693) 
[  557.238606][  T349]


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250325/202503251554.34a0b29b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


