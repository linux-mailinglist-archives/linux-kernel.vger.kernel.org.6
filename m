Return-Path: <linux-kernel+bounces-424861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246DB9DBA60
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17912813E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9535B1B21BF;
	Thu, 28 Nov 2024 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfBRjcDl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51541B86E9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807184; cv=fail; b=qA61hEAXQW5MFUcgfs8aw0altMlWeW1qZmIqOsQcAUyYpM+Vcmylre9xu8D49FVhcLEWw//CZ7D+lsylj3CQvPQhBNqIQWsQ2GgzsvxK9zK2MmRxlYS3lWGStW5lvytjRdz6YWy/bdkG2wN00rX3g0GmYH3W3wcBbce/VpopuxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807184; c=relaxed/simple;
	bh=Rd8Tv24oP1AspEWXkI0g23NDP942h+5VUVOs0fj+GpQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=lgGJqhVTGRhVla+GFgPdCn2uF5zf7mVXJyQc1iiJC8U61lwnhhcGCnDW/eDoMmKJav9dz1VWnoJ84lX+X6PgwnGa5h0ZcAd2gn25cs2i4eFV17jKW4nUpprboTdJvx3p5aRSPTXqbzvhWd0df76IJhD3l4P4kDGIbxXJ6+xEhpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MfBRjcDl; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732807180; x=1764343180;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Rd8Tv24oP1AspEWXkI0g23NDP942h+5VUVOs0fj+GpQ=;
  b=MfBRjcDlIP0JGC/Nsyk6K/oBqSj9/bul0tMG9G2rDadxlt8mV+hv+VWw
   b/nIYuh0Zbn3yYWEgiIqEANxIzWXQ88MDcTuC31+23xBwQSoQqa5ae2u1
   3ePLFbz2PqCDhl64AkZFlLXFrR3fsQmmZJzWVPgv6Js3xYhTf6SPOJENp
   4zKF+4og0JO+ik/0h1vwyyVHgSJeD9bzOHbW7cdRqOYrYyIamG23RM5Mt
   BSN2ANVreAnKvQ6ykcpa6mcKf3XqNWi3D7bTfX4OzUNTwXUnVDLmvD0M6
   cU5DgGLDzPcd85ikGq3Qzfv7lYEpfJs0CuF4YpTzD6ilHgVM5Bu7ateIm
   A==;
X-CSE-ConnectionGUID: RkbG/lmkTMGS1BHwqtd+rA==
X-CSE-MsgGUID: GN7U3/vmTKmBS8rZ1hSvhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="33287362"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="33287362"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 07:19:40 -0800
X-CSE-ConnectionGUID: r//lT6WBRCy0B8QeflHMPg==
X-CSE-MsgGUID: eD5JZhojTGCjY5/0MzPGUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="97025515"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2024 07:19:40 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 07:19:39 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 28 Nov 2024 07:19:39 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 07:19:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhbPVjbkCtUjAFNDA8R06Uz2zLAwNBr4P4YkJmiEuwGKT+0kerc6Ra0Wf7sYeBkgH6AMX10Pv0gcPVQidCyul9w+9fwQvDUcb2l16yDe7v6zXtv7LyZDMqMinchrLq/yIcZ7iFkfUfMv3YVa4HEQTnDHTeGjDjyXEX0FrjC2cMtsHhd+Ky2Ua/pkTvXlbK4uXQhY98j/h2zvuTRJ26d0aLLEUq7lC8aJQg2KNpCSlbbqfAdfWbmCQGt5FLwZJfWUCf0zESUdP2zfg0q+2qD1d6bxNpO9HMiI01pkZ0svd12GgPxmFv3EFsutsdRUqSPin1EJ1D/0hhKm6zjxvNNYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRCRqeh9NwXZb0nPOLbKP1ppESgmvxru2gP4L+d3fyE=;
 b=D7c7FHhd8+ZWAR/Jj2L966wNDpxWbx8phX5zBP95Ws9r0I6EWmvwqjZZoWzv2yj1zBXNqeY4LokGOFrlTrxRfIqnRhQmWoSWTsFTD8tKD3D3AhxFuKr6V57XHxG9d7k5j1jy5dJ3xhGMZF29AgyGgkfeIAvL0DmQ2quaCPHydHTewBMOrgbrVYAmKBWYiyg9ezS83HgUyqwlCRUOeEzd0DkjTQS/9OBJgfGyvPYQ+jzjFre3fcHzSirpF2w4hGswo24G3f25huDlHNo/Zhn6cG5iqd7XBkpDWjvrxfWUNA9W/JnUwKmFgoI6GzBluKRf1p9xWhFw1X3lKdI7wznNCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Thu, 28 Nov
 2024 15:19:36 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 15:19:36 +0000
Date: Thu, 28 Nov 2024 23:19:26 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Wangyang Guo <wangyang.guo@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>, "Lai
 Jiangshan" <jiangshanlai@gmail.com>, <oliver.sang@intel.com>
Subject: [linus:master] [workqueue]  85f0d8e39a:  aim7.jobs-per-min 8.6%
 improvement
Message-ID: <202411282320.c3393d33-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0237.apcprd06.prod.outlook.com
 (2603:1096:4:ac::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB5326:EE_
X-MS-Office365-Filtering-Correlation-Id: a8408e97-5391-4b0f-3942-08dd0fc0117d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?7H2CkGCrkSHlNMV4KSA6ZjI+i8YB1KkhGuRRzkdEyLhJYivKE1jVOIOgHs?=
 =?iso-8859-1?Q?QtHBefVZe93Wy4NrlLiPATUxMDaHnpHfMjHdl1biamtqbar0p1QP4VKnK7?=
 =?iso-8859-1?Q?a4yspEQEtQehS2m/7aRZ08uiGdo/rFM34lu0fr4JI/8YPIg4epDHjXoB+g?=
 =?iso-8859-1?Q?aUPbrPt/VwMFwvhiNRLLQid51ua2Wd2X1PgSr/K43h+JYyBNWi/cMcjN3D?=
 =?iso-8859-1?Q?hkqGCNOapc5gmOxHTVNs7Lz/FqW+098ioZG/TOO+OB/klLylt7I22aVk9e?=
 =?iso-8859-1?Q?10GSNXA+AzLsNvxebjyyQzVpSaaOwcJFOV/c1acyNJ4lJUxQZVN0r8Hqxd?=
 =?iso-8859-1?Q?m5MHueHm1xWkdxUTvIKmWOHRU7tdIYz83H0WWEcQOXzTyn2ahwouXidSEB?=
 =?iso-8859-1?Q?d2AjB+mobJBP/USeLCl2X2dPWwYojuLQ29wRVl6dKlsfmHRj1UFROE1fGZ?=
 =?iso-8859-1?Q?kdx6/gOEOQI0bk9uYdzZQKHtMOkunONCa+jt3yBO/8HoowV1PmuBReH6y7?=
 =?iso-8859-1?Q?LydmfNr9yuEQ05UPabMoXlkWKYYPhtF8uMI53S2TAX2islngDU6mc8++h/?=
 =?iso-8859-1?Q?X68yIdH97i8vZ4ufWBPsO4bfvyJXUI3sTFbgg7xRbugwo4bLRoyLVmxEma?=
 =?iso-8859-1?Q?vPQhEDsRLYDXmW4F8Agp9eeswnKICj9Zf+Aur6iIzHC1mYCJIYwdqGwsD7?=
 =?iso-8859-1?Q?hkXb7XPHC6+XgMAIan51zdzed/q9sSeZP7aZBEMwtupb3qm2iCjPm55TEM?=
 =?iso-8859-1?Q?g/7ehA6k3d899cPFAEEttvr8/m6PPLkT/NWwBzm0gnm5+YHKh4hgC2nsYe?=
 =?iso-8859-1?Q?ivnlL5KnQ2ey0/OeFpAWXdzz2ul229cNxeBI+QjJRrvg7ZMH/jZyekb47m?=
 =?iso-8859-1?Q?5p0hAOUCh1YZnT1WBYeO8NI82YwBFIyceM7maRKWlCEqyfWFYi57gwxD8R?=
 =?iso-8859-1?Q?DYDCwJ9XNYABDIDWO3wHaJz5UxYwyNzKMqbBvGHtOyjA3adrJ79xvMtVZ/?=
 =?iso-8859-1?Q?+gkO/L/N4TwSiJ9cpAMzwrQ5bNphjycKT2NmLNm6XZORbxwWZTq4HNoXM5?=
 =?iso-8859-1?Q?DAABB5odLt2QSIgwf8ZOzivSOeEcwdOxcdrxdUwY8I4DdmjOJkAgl/f8xj?=
 =?iso-8859-1?Q?rCtodzBe7nVT2rKPY40nkRE9SOzhjhtztCTuW/QbMmlvMS+hhjzGXnSCeY?=
 =?iso-8859-1?Q?COYAMiCF1VVxnGoraey7e8hhm9sDCgHxrLpxWnOIgGojTk0lcOOi6uoZmJ?=
 =?iso-8859-1?Q?EugGSMgi9vM3ImMTiIciJHxaC6ZvF0K5PWJIWkn2AW5WSfcOpnexSLEmVw?=
 =?iso-8859-1?Q?3blMuNJkAXRUt51nRznzGCBE6+umWmH7sLjhp6c9kbuu4UYAAMzBJsuSIE?=
 =?iso-8859-1?Q?nqhGB1RLT0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?90BoTZk3gayRFbt4r5WQHwIOQr8PJY3DMMXIxMSKlmmr2ncSqpGXcIGF2p?=
 =?iso-8859-1?Q?FnGE4b6bYhSd7gyEbNP8pVyx79/hHgD0k4udMtWtsnQC7hUSsulZD1oLCE?=
 =?iso-8859-1?Q?nHIgYHEA7AoVf61byq99OXbeIWQtWx+CxxM1FXv3GafooiSpyIPwuehco0?=
 =?iso-8859-1?Q?chEQAPmOaBwOil1nLu3OqX1A/yxQ3ZICG3ojZwHX94apfPTwGehtPOYhus?=
 =?iso-8859-1?Q?P8msln81wyqgHm5Pl1L/dOlXQldwZAsm9W4fxHvrAtzbdofVdEHKyetd73?=
 =?iso-8859-1?Q?Xuc+Ljd028Ue/ZvxnGMO1vkryzSr3NsFA3aC/RN13XtqQxO3tqkhHrd5kh?=
 =?iso-8859-1?Q?hCIUNQFafvcw+yPUtmXpTUzlYQD4kxDMudGVsDm9DeRHvLTDmhPulOZceE?=
 =?iso-8859-1?Q?UejIofY1I72qB7KPXRGqpH259XAuqCk/G7o8Pq0Dw2CTPoi+VVQmgAyyFT?=
 =?iso-8859-1?Q?idTCVUOzcT7Q09Q2BsbAiugGGDjbftiyJwvMesqp8LaWG3B6ZyGU+wy7eV?=
 =?iso-8859-1?Q?wHkmQ4lUgM+N9099V+c7Q6B/cz4ndrCzUrSkmWFP40yd1H6KhIdtnzHEsI?=
 =?iso-8859-1?Q?YseokPE3KLwpuZUdieAFH2n9XzyfXh7/JW9ef0Vo0wkXY5TAIoGflHo17Q?=
 =?iso-8859-1?Q?woJRkGR1xjsasvmQph1woTZQGx7SbZxsIalpRYnYPHTKuzCe3J3LFoDE4c?=
 =?iso-8859-1?Q?vNvdBJ5oALEFRJhZWiozXWZn1xtI3zG0EU2Ch/sc4G0mqjXmp/Z05LO+Ky?=
 =?iso-8859-1?Q?PxChRXj9Z8MOvU56MQ2BIuwNeQri3FonVNGmxmjdvdtNYJgT1bvOGYm51A?=
 =?iso-8859-1?Q?gw24yOwO8eqqmIC5CnJKwfMDqyTsLm2P/Sj/e/RQaZEigdLKqFCPZRWl0N?=
 =?iso-8859-1?Q?Q0QIlBlVE6jiCoOB6N8hm3cdxsbA0p6oXYmw1fhV8APBJLsNMN19Z5Y1lq?=
 =?iso-8859-1?Q?jKYvM1t04JIAM/N2Kr9mgvH7utNxE7NruWwwyROeEaJ9iVelgNDByLKSbq?=
 =?iso-8859-1?Q?OLWVu/WhzylpQ9G0ckn+dC5+1yuWsQU9/2yh44c0doHXcu52ZXnHg9RD2n?=
 =?iso-8859-1?Q?i3Tl2LexKH8u80juKhCYjEDevv5AZFkqH5VuKMbyZB7GHTfLSPTX5TZovn?=
 =?iso-8859-1?Q?OwYE+1GwvrlOK5e2hpZDqmUgGJfX7UjXwHAc2/bla6bwVeRXsnv5OPIzUi?=
 =?iso-8859-1?Q?OCk+lqkDNdKoSWVIczWIP8XNmjNcAjva1rLHqj/h7qjFPlgH4XG4XzMQCR?=
 =?iso-8859-1?Q?z2KZ44iFRXJ22ORiEiE56b8OIephVuTcRzk0qBRnqaLkObNuv4C8daCN4C?=
 =?iso-8859-1?Q?xi+6qOzZQUUPHhY3GU0SuFkDmHVToGjSuRTDYDu5Snl2a/6ncKOrSfJb0/?=
 =?iso-8859-1?Q?1yqsH8zGn/erbj8Jsm/mG5S7N1AUxhlHn/9X6jYYG4sKEjMo7375UcSs4w?=
 =?iso-8859-1?Q?C7r4bQ6WQ0AW/uQ+ssJjReN7k4zVzeB4qDiZNaVjQg0+2wYYsXWLbPGtp0?=
 =?iso-8859-1?Q?Uj3bhqGv8v7ePeth46s380iBhmnrU0bkgcQAlVcGMWi7Gq8SUGPrqj/Nc7?=
 =?iso-8859-1?Q?8U1hcicQ6BprFvkEqKWa8xTtBInKB+zRsBcDy+E4WA+useCZo7u5+Znjdc?=
 =?iso-8859-1?Q?/iCdq4/rbm3dnvnEIqfQ4S77p0x7Qsd5pCNmiJoRx0s4Sw9gDbu2lgbA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8408e97-5391-4b0f-3942-08dd0fc0117d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 15:19:36.1832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwnaugSJxx4IqnZtJWadnL43/9XpH/7n8ldX3wqmWSU6P4oGG73+zROdCJOk8s26C170xJg0GqBU619WRmX2VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5326
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 8.6% improvement of aim7.jobs-per-min on:


commit: 85f0d8e39affb7b88401b1e0542230a7af985b96 ("workqueue: Reduce expensive locks for unbound workqueue")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: aim7
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	disk: 1BRD_48G
	fs: xfs
	test: sync_disk_rw
	load: 600
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241128/202411282320.c3393d33-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1BRD_48G/xfs/x86_64-rhel-9.4/600/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/sync_disk_rw/aim7

commit: 
  581434654e ("workqueue: Adjust WQ_MAX_ACTIVE from 512 to 2048")
  85f0d8e39a ("workqueue: Reduce expensive locks for unbound workqueue")

581434654e01ec79 85f0d8e39affb7b88401b1e0542 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.05 ± 21%      +0.0        0.09 ± 32%  mpstat.cpu.all.iowait%
    217.72 ±  7%     +15.8%     252.20 ±  3%  sched_debug.cfs_rq:/.load_avg.avg
    155676           +14.2%     177722        sched_debug.cpu.nr_switches.avg
   1574224            +8.2%    1702935 ±  2%  vmstat.io.bo
    708757           +11.9%     793027        vmstat.system.cs
     42088            +8.6%      45722 ±  2%  aim7.jobs-per-min
     85.58            -7.9%      78.85 ±  2%  aim7.time.elapsed_time
     85.58            -7.9%      78.85 ±  2%  aim7.time.elapsed_time.max
      7865            -2.4%       7676        aim7.time.percent_of_cpu_this_job_got
      6708           -10.1%       6031 ±  3%  aim7.time.system_time
      1424 ±  2%     +12.9%       1607 ±  3%  perf-c2c.DRAM.local
     31026 ±  2%     +15.6%      35862 ±  2%  perf-c2c.DRAM.remote
     31332 ±  2%     +16.3%      36454        perf-c2c.HITM.local
     17260 ±  2%     +15.3%      19904        perf-c2c.HITM.remote
     48592 ±  2%     +16.0%      56358        perf-c2c.HITM.total
      1.68            +9.3%       1.83        perf-stat.i.MPKI
 1.281e+10            -1.1%  1.266e+10        perf-stat.i.branch-instructions
      1.17 ±  3%      +0.1        1.29 ±  2%  perf-stat.i.branch-miss-rate%
  81010944 ±  2%      +8.0%   87466198 ±  2%  perf-stat.i.branch-misses
 1.162e+08            +9.1%  1.267e+08        perf-stat.i.cache-misses
 5.259e+08            +6.4%  5.594e+08        perf-stat.i.cache-references
    728100           +12.1%     815950        perf-stat.i.context-switches
 2.234e+11            -1.5%    2.2e+11        perf-stat.i.cpu-cycles
    164153           +17.1%     192277        perf-stat.i.cpu-migrations
      2051 ±  4%      -8.5%       1876        perf-stat.i.cycles-between-cache-misses
 6.335e+10            -1.4%  6.246e+10        perf-stat.i.instructions
      0.42 ±  3%      +4.9%       0.44        perf-stat.i.ipc
      6.92           +13.4%       7.85        perf-stat.i.metric.K/sec
      1.83           +10.5%       2.02        perf-stat.overall.MPKI
      0.63 ±  2%      +0.1        0.69 ±  2%  perf-stat.overall.branch-miss-rate%
      1924            -9.6%       1738        perf-stat.overall.cycles-between-cache-misses
  79954174 ±  3%      +7.8%   86228443 ±  2%  perf-stat.ps.branch-misses
 1.148e+08            +9.1%  1.252e+08        perf-stat.ps.cache-misses
 5.199e+08 ±  2%      +6.3%  5.528e+08 ±  2%  perf-stat.ps.cache-references
    719025           +12.0%     805179        perf-stat.ps.context-switches
 2.208e+11            -1.4%  2.176e+11        perf-stat.ps.cpu-cycles
    162026           +17.0%     189566        perf-stat.ps.cpu-migrations
      8053            +8.9%       8771        perf-stat.ps.minor-faults
      8055            +8.9%       8772        perf-stat.ps.page-faults
 5.452e+12            -9.3%  4.945e+12 ±  2%  perf-stat.total.instructions
      0.02 ±  5%     -16.8%       0.02 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.down.xlog_write_iclog.xlog_state_release_iclog.xlog_write_get_more_iclog_space
      0.17 ± 42%     +73.9%       0.30 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.xfs_ilock.xfs_file_buffered_write.vfs_write
      0.32 ±  7%     +19.6%       0.38 ±  4%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.xfs_ilock_for_iomap.xfs_buffered_write_iomap_begin.iomap_iter
      0.04 ±  8%     -21.2%       0.03 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.13 ±  4%     -18.4%       0.11        perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      0.21 ±  6%     -15.1%       0.18 ±  2%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__flush_workqueue
      0.28 ±  9%     -22.4%       0.22 ±  5%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.xlog_cil_commit
      0.12 ±  4%     -17.8%       0.10        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      0.18 ± 17%     -31.3%       0.13 ± 20%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.17 ±  9%     -16.2%       0.14 ±  4%  perf-sched.sch_delay.avg.ms.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
      0.12 ±  7%     -18.1%       0.10 ± 15%  perf-sched.sch_delay.avg.ms.xlog_force_lsn.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
      0.03 ±  6%     -17.2%       0.03 ±  7%  perf-sched.sch_delay.avg.ms.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
      0.02 ±  4%     -16.3%       0.02 ±  5%  perf-sched.sch_delay.avg.ms.xlog_wait_on_iclog.xlog_cil_push_work.process_one_work.worker_thread
      0.05 ± 89%     -69.4%       0.02 ± 24%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.10 ±  5%     -16.8%       0.09 ±  2%  perf-sched.total_sch_delay.average.ms
      3.81 ±  5%     -14.6%       3.26        perf-sched.total_wait_and_delay.average.ms
   1294764 ±  5%     +20.2%    1556681        perf-sched.total_wait_and_delay.count.ms
      3.71 ±  5%     -14.6%       3.17        perf-sched.total_wait_time.average.ms
     40.05 ±  5%     -19.6%      32.22 ±  2%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      5.40 ± 10%     -16.1%       4.53 ± 16%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     10.78 ±  4%     -27.1%       7.86        perf-sched.wait_and_delay.avg.ms.__cond_resched.submit_bio_noacct.submit_bio_wait.blkdev_issue_flush.xfs_file_fsync
      1.09 ± 19%     -20.2%       0.87        perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     53.70 ± 13%     +51.0%      81.10 ±  9%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.21 ± 52%     -34.9%       0.79        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__flush_workqueue
      2.05 ±  3%     -10.2%       1.84 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.xlog_cil_commit
      3.62 ±  3%     -12.2%       3.18        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      5.23 ±  4%     -13.1%       4.54        perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.04 ±  5%      -9.6%       0.94 ±  2%  perf-sched.wait_and_delay.avg.ms.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
      0.43 ± 24%     -19.2%       0.35 ±  2%  perf-sched.wait_and_delay.avg.ms.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
    355.33 ±  5%     +18.4%     420.80 ±  2%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      1579 ±  8%     +20.7%       1906        perf-sched.wait_and_delay.count.__cond_resched.submit_bio_noacct.submit_bio_wait.blkdev_issue_flush.xfs_file_fsync
    234039 ±  5%     +24.5%     291312        perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     12.00 ± 56%    +116.7%      26.00 ±  9%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    249.17 ± 15%     -35.2%     161.40 ±  6%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     57383 ±  5%     +22.0%      70033 ±  2%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.__flush_workqueue
     21437 ±  7%     +36.5%      29266 ±  2%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.xlog_cil_commit
    618266 ±  5%     +14.4%     707119        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
    261732 ±  5%     +23.6%     323389        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     15467 ±  9%     +30.6%      20207 ±  2%  perf-sched.wait_and_delay.count.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
     54946 ±  4%     +41.4%      77690 ±  2%  perf-sched.wait_and_delay.count.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
    107.83 ± 15%     -17.0%      89.52 ±  9%  perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
    707.19 ±112%    +228.7%       2324 ± 38%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_iomap_write_unwritten
    214.66 ±106%     -60.0%      85.92 ±  8%  perf-sched.wait_and_delay.max.ms.__cond_resched.submit_bio_noacct.submit_bio_wait.blkdev_issue_flush.xfs_file_fsync
    225.62 ±100%     -55.9%      99.39 ± 15%  perf-sched.wait_and_delay.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
    208.38 ±112%     -55.5%      92.83 ±  5%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__flush_workqueue
     39.79 ±  5%     -19.5%      32.04 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      1.05 ±  3%     -19.5%       0.85 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.down.xlog_write_iclog.xlog_state_release_iclog.xlog_write_get_more_iclog_space
      0.80 ±  3%     +15.6%       0.92 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write
     10.72 ±  4%     -27.3%       7.79        perf-sched.wait_time.avg.ms.__cond_resched.submit_bio_noacct.submit_bio_wait.blkdev_issue_flush.xfs_file_fsync
      0.96 ± 21%     -20.4%       0.76        perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     53.67 ± 13%     +47.6%      79.23 ±  7%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.00 ± 63%     -39.1%       0.61 ±  2%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__flush_workqueue
      0.98 ±  8%     -18.5%       0.80 ±  5%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.xlog_cil_push_work
      0.54 ± 34%     +65.2%       0.90 ± 20%  perf-sched.wait_time.avg.ms.schedule_timeout.___down_common.__down.down
      3.50 ±  3%     -12.0%       3.08        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      1.07 ± 14%     -14.3%       0.91 ±  7%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ±136%  +2.3e+05%      21.35 ± 92%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      5.21 ±  4%     -13.2%       4.52        perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.76 ±  4%     -13.3%       0.66 ±  4%  perf-sched.wait_time.avg.ms.xlog_force_lsn.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
      0.40 ± 25%     -19.4%       0.32        perf-sched.wait_time.avg.ms.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
     97.03 ±  5%     -14.0%      83.41 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
    707.86 ±112%    +208.1%       2180 ± 44%  perf-sched.wait_time.max.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_iomap_write_unwritten
    202.54 ±114%     -59.2%      82.56 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.submit_bio_noacct.submit_bio_wait.blkdev_issue_flush.xfs_file_fsync
    204.92 ±114%     -58.5%      85.10 ±  6%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
    201.73 ±116%     -58.5%      83.64 ±  6%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__flush_workqueue
      0.53 ± 21%     +58.5%       0.85 ± 37%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
    361.77 ±132%    +226.4%       1180 ± 30%  perf-sched.wait_time.max.ms.schedule_timeout.___down_common.__down.down
    207.72 ±112%     -57.4%      88.51 ±  6%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      6.28 ±116%     -56.7%       2.72 ±  6%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.21 ±207%  +2.9e+05%     600.22 ± 81%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     75.67            -5.8       69.84        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq
     77.64            -5.8       71.88        perf-profile.calltrace.cycles-pp.__mutex_lock.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq
     81.66            -5.7       75.99        perf-profile.calltrace.cycles-pp.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync
     82.43            -5.3       77.11        perf-profile.calltrace.cycles-pp.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
     84.14            -4.6       79.58        perf-profile.calltrace.cycles-pp.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write.vfs_write
     86.66            -3.4       83.30        perf-profile.calltrace.cycles-pp.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write.vfs_write.ksys_write
     92.61            -1.2       91.43        perf-profile.calltrace.cycles-pp.xfs_file_fsync.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64
     94.75            -0.9       93.86        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     94.65            -0.9       93.76        perf-profile.calltrace.cycles-pp.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     94.77            -0.9       93.88        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     94.99            -0.9       94.12        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     94.99            -0.9       94.13        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     95.18            -0.8       94.34        perf-profile.calltrace.cycles-pp.write
      1.01            -0.1        0.91        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.osq_lock.__mutex_lock.__flush_workqueue
      1.03            -0.1        0.93        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.osq_lock.__mutex_lock.__flush_workqueue.xlog_cil_push_now
      0.93            -0.1        0.84        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.osq_lock.__mutex_lock
      0.92            -0.1        0.83        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.osq_lock
      0.90            -0.1        0.80        perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.88            -0.1        0.78        perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.90            -0.1        0.81        perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.51            +0.1        0.58        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter
      0.78            +0.1        0.86        perf-profile.calltrace.cycles-pp.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write.ksys_write
      0.70            +0.1        0.80        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.66 ±  2%      +0.1        0.77        perf-profile.calltrace.cycles-pp.xlog_cil_commit.__xfs_trans_commit.xfs_vn_update_time.kiocb_modified.xfs_file_write_checks
      0.99            +0.1        1.10        perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64
      0.70 ±  2%      +0.1        0.82 ±  7%  perf-profile.calltrace.cycles-pp.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io.process_one_work.worker_thread
      0.74 ±  2%      +0.1        0.86        perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_vn_update_time.kiocb_modified.xfs_file_write_checks.xfs_file_buffered_write
      0.91 ±  2%      +0.2        1.09 ±  6%  perf-profile.calltrace.cycles-pp.xfs_vn_update_time.kiocb_modified.xfs_file_write_checks.xfs_file_buffered_write.vfs_write
      0.95 ±  2%      +0.2        1.12 ±  6%  perf-profile.calltrace.cycles-pp.kiocb_modified.xfs_file_write_checks.xfs_file_buffered_write.vfs_write.ksys_write
      0.98 ±  2%      +0.2        1.16 ±  6%  perf-profile.calltrace.cycles-pp.xfs_file_write_checks.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64
      1.22            +0.2        1.40        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.21            +0.2        1.39        perf-profile.calltrace.cycles-pp.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.27            +0.2        1.46        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.26            +0.2        1.45        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.64            +0.2        1.86        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.66            +0.3        0.91 ±  3%  perf-profile.calltrace.cycles-pp.__folio_end_writeback.folio_end_writeback.iomap_finish_ioend.iomap_finish_ioends.xfs_end_ioend
      1.96            +0.3        2.22        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.96            +0.3        2.23        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      1.96            +0.3        2.23        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      1.99            +0.3        2.26        perf-profile.calltrace.cycles-pp.common_startup_64
      0.80            +0.3        1.08 ±  2%  perf-profile.calltrace.cycles-pp.folio_end_writeback.iomap_finish_ioend.iomap_finish_ioends.xfs_end_ioend.xfs_end_io
      0.82            +0.3        1.09 ±  2%  perf-profile.calltrace.cycles-pp.iomap_finish_ioend.iomap_finish_ioends.xfs_end_ioend.xfs_end_io.process_one_work
      0.82            +0.3        1.10 ±  2%  perf-profile.calltrace.cycles-pp.iomap_finish_ioends.xfs_end_ioend.xfs_end_io.process_one_work.worker_thread
      0.44 ± 44%      +0.3        0.75 ±  3%  perf-profile.calltrace.cycles-pp.sb_clear_inode_writeback.__folio_end_writeback.folio_end_writeback.iomap_finish_ioend.iomap_finish_ioends
      0.69 ±  5%      +0.3        1.03 ±  7%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq
      0.73 ±  5%      +0.4        1.08 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync
      1.52            +0.4        1.92 ±  4%  perf-profile.calltrace.cycles-pp.xfs_end_ioend.xfs_end_io.process_one_work.worker_thread.kthread
      1.53            +0.4        1.93 ±  4%  perf-profile.calltrace.cycles-pp.xfs_end_io.process_one_work.worker_thread.kthread.ret_from_fork
      2.14            +0.5        2.64 ±  3%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.04 ±  6%      +0.5        1.54 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.remove_wait_queue.xlog_cil_force_seq.xfs_log_force_seq
      1.04 ±  6%      +0.5        1.55 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.remove_wait_queue.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync
      1.05 ±  6%      +0.5        1.55 ±  4%  perf-profile.calltrace.cycles-pp.remove_wait_queue.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
      2.37            +0.5        2.89 ±  2%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.38            +0.5        2.90 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      2.38            +0.5        2.90 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      2.38            +0.5        2.90 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      1.02            +0.7        1.75        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state
      1.71 ±  2%      +0.8        2.55 ±  3%  perf-profile.calltrace.cycles-pp.sb_clear_inode_writeback.__folio_end_writeback.folio_end_writeback.iomap_finish_ioend.__submit_bio
      2.10            +0.9        3.03 ±  3%  perf-profile.calltrace.cycles-pp.__folio_end_writeback.folio_end_writeback.iomap_finish_ioend.__submit_bio.__submit_bio_noacct
      2.20            +0.9        3.15 ±  3%  perf-profile.calltrace.cycles-pp.folio_end_writeback.iomap_finish_ioend.__submit_bio.__submit_bio_noacct.iomap_submit_ioend
      2.24            +0.9        3.18 ±  3%  perf-profile.calltrace.cycles-pp.iomap_finish_ioend.__submit_bio.__submit_bio_noacct.iomap_submit_ioend.iomap_writepages
      2.06 ±  2%      +1.0        3.07 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.sb_mark_inode_writeback.__folio_start_writeback.iomap_writepage_map
      2.76            +1.0        3.78 ±  2%  perf-profile.calltrace.cycles-pp.__submit_bio.__submit_bio_noacct.iomap_submit_ioend.iomap_writepages.xfs_vm_writepages
      2.76            +1.0        3.78 ±  2%  perf-profile.calltrace.cycles-pp.__submit_bio_noacct.iomap_submit_ioend.iomap_writepages.xfs_vm_writepages.do_writepages
      2.81            +1.0        3.83 ±  2%  perf-profile.calltrace.cycles-pp.iomap_submit_ioend.iomap_writepages.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc
      2.13 ±  2%      +1.0        3.15 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.sb_mark_inode_writeback.__folio_start_writeback.iomap_writepage_map.iomap_writepages
      2.01            +1.0        3.03 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.remove_wait_queue.xlog_wait_on_iclog.xfs_log_force_seq
      2.16 ±  2%      +1.0        3.19 ±  4%  perf-profile.calltrace.cycles-pp.sb_mark_inode_writeback.__folio_start_writeback.iomap_writepage_map.iomap_writepages.xfs_vm_writepages
      2.02            +1.0        3.05 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.remove_wait_queue.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync
      2.02            +1.0        3.05 ±  2%  perf-profile.calltrace.cycles-pp.remove_wait_queue.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
      2.33 ±  2%      +1.1        3.39 ±  3%  perf-profile.calltrace.cycles-pp.__folio_start_writeback.iomap_writepage_map.iomap_writepages.xfs_vm_writepages.do_writepages
      2.53 ±  2%      +1.1        3.62 ±  3%  perf-profile.calltrace.cycles-pp.iomap_writepage_map.iomap_writepages.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc
      2.40 ±  2%      +1.1        3.52 ±  2%  perf-profile.calltrace.cycles-pp.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write.vfs_write
      2.11 ± 10%      +1.1        3.25 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.sb_clear_inode_writeback.__folio_end_writeback.folio_end_writeback.iomap_finish_ioend
      1.88 ± 15%      +1.3        3.17 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.sb_clear_inode_writeback.__folio_end_writeback.folio_end_writeback
      5.55            +2.1        7.67 ±  3%  perf-profile.calltrace.cycles-pp.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range
      5.53            +2.1        7.65 ±  3%  perf-profile.calltrace.cycles-pp.iomap_writepages.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
      5.56            +2.1        7.68 ±  3%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync
      5.59            +2.1        7.72 ±  3%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync.xfs_file_buffered_write
      5.60            +2.1        7.73 ±  3%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync.xfs_file_buffered_write.vfs_write
      5.80            +2.2        7.95 ±  3%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.xfs_file_fsync.xfs_file_buffered_write.vfs_write.ksys_write
     75.70            -5.8       69.86        perf-profile.children.cycles-pp.osq_lock
     77.64            -5.8       71.88        perf-profile.children.cycles-pp.__mutex_lock
     81.66            -5.7       75.99        perf-profile.children.cycles-pp.__flush_workqueue
     82.43            -5.3       77.11        perf-profile.children.cycles-pp.xlog_cil_push_now
     84.14            -4.6       79.58        perf-profile.children.cycles-pp.xlog_cil_force_seq
     86.66            -3.4       83.30        perf-profile.children.cycles-pp.xfs_log_force_seq
     92.61            -1.2       91.43        perf-profile.children.cycles-pp.xfs_file_fsync
     94.65            -0.9       93.76        perf-profile.children.cycles-pp.xfs_file_buffered_write
     94.78            -0.9       93.89        perf-profile.children.cycles-pp.vfs_write
     94.80            -0.9       93.91        perf-profile.children.cycles-pp.ksys_write
     95.21            -0.8       94.37        perf-profile.children.cycles-pp.do_syscall_64
     95.23            -0.8       94.39        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     95.25            -0.8       94.42        perf-profile.children.cycles-pp.write
      0.27            -0.1        0.15 ±  3%  perf-profile.children.cycles-pp.flush_workqueue_prep_pwqs
      0.23 ±  2%      -0.1        0.17 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      1.14            -0.0        1.09        perf-profile.children.cycles-pp.update_process_times
      1.18            -0.0        1.13        perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.16            -0.0        1.12        perf-profile.children.cycles-pp.tick_nohz_handler
      1.23            -0.0        1.19        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.22            -0.0        1.18        perf-profile.children.cycles-pp.hrtimer_interrupt
      1.39            -0.0        1.36        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.45            -0.0        1.42        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.42 ±  2%      -0.0        0.39        perf-profile.children.cycles-pp.nohz_balancer_kick
      0.24 ±  2%      -0.0        0.23        perf-profile.children.cycles-pp.nohz_balance_exit_idle
      0.14            +0.0        0.15        perf-profile.children.cycles-pp.xlog_cil_committed
      0.14            +0.0        0.15        perf-profile.children.cycles-pp.xlog_cil_process_committed
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.__close
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.up_write
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.__cond_resched
      0.08            +0.0        0.09        perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.dl_server_stop
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.sched_clock
      0.08            +0.0        0.09        perf-profile.children.cycles-pp.sched_clock_cpu
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.xa_load
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.xlog_cil_alloc_shadow_bufs
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.xlog_state_release_iclog
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.__switch_to_asm
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.bio_alloc_bioset
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.brd_insert_page
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.mutex_unlock
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.set_task_cpu
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.switch_fpu_return
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.task_h_load
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.xlog_write_get_more_iclog_space
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.xlog_write_partial
      0.19            +0.0        0.20        perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.10            +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.10            +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.enqueue_dl_entity
      0.11            +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.filemap_dirty_folio
      0.07            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.xfs_btree_read_buf_block
      0.07            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.xfs_map_blocks
      0.13 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.writeback_get_folio
      0.13 ±  3%      +0.0        0.14        perf-profile.children.cycles-pp.io_schedule
      0.09 ±  5%      +0.0        0.10        perf-profile.children.cycles-pp.reweight_entity
      0.11 ±  3%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.menu_select
      0.12 ±  3%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.filemap_get_entry
      0.13 ±  2%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.llseek
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.pick_task_fair
      0.16 ±  3%      +0.0        0.18        perf-profile.children.cycles-pp.xfs_inode_item_format
      0.08 ±  6%      +0.0        0.09        perf-profile.children.cycles-pp.wake_affine
      0.12 ±  4%      +0.0        0.13        perf-profile.children.cycles-pp.kick_pool
      0.18 ±  2%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.iomap_writepage_map_blocks
      0.14 ±  2%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.queue_work_on
      0.13 ±  3%      +0.0        0.15        perf-profile.children.cycles-pp.__queue_work
      0.10 ±  4%      +0.0        0.12        perf-profile.children.cycles-pp.prepare_task_switch
      0.15 ±  3%      +0.0        0.17        perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      0.18 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__filemap_fdatawait_range
      0.11            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.20 ±  2%      +0.0        0.22        perf-profile.children.cycles-pp.iomap_iter
      0.10 ±  3%      +0.0        0.12        perf-profile.children.cycles-pp.dl_server_start
      0.15 ±  2%      +0.0        0.17        perf-profile.children.cycles-pp.xfs_end_bio
      0.11 ±  4%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.18 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.writeback_iter
      0.09            +0.0        0.11        perf-profile.children.cycles-pp.available_idle_cpu
      0.08            +0.0        0.10        perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.18 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.iomap_set_range_uptodate
      0.12 ±  4%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.wake_page_function
      0.21            +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.19            +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.25            +0.0        0.27        perf-profile.children.cycles-pp.xlog_cil_insert_format_items
      0.04 ± 44%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.xlog_cil_write_commit_record
      0.14 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.folio_wake_bit
      0.14 ±  3%      +0.0        0.17 ±  3%  perf-profile.children.cycles-pp.activate_task
      0.09            +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.xlog_state_clean_iclog
      0.26 ±  4%      +0.0        0.29 ±  2%  perf-profile.children.cycles-pp.xfs_bmapi_convert_unwritten
      0.03 ± 70%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.xlog_cil_set_ctx_write_state
      0.26            +0.0        0.29 ±  2%  perf-profile.children.cycles-pp.iomap_write_begin
      0.25 ±  3%      +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.xfs_bmap_add_extent_unwritten_real
      0.36 ±  2%      +0.0        0.39        perf-profile.children.cycles-pp.xlog_cil_insert_items
      0.28            +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.iomap_write_end
      0.22 ±  2%      +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.schedule_idle
      0.14            +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.select_idle_cpu
      0.31 ±  3%      +0.0        0.35        perf-profile.children.cycles-pp.xfs_bmapi_write
      0.22 ±  5%      +0.0        0.25 ±  4%  perf-profile.children.cycles-pp.detach_tasks
      0.26            +0.0        0.30 ±  2%  perf-profile.children.cycles-pp.wake_up_q
      0.18 ±  2%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.select_idle_sibling
      0.30            +0.0        0.34        perf-profile.children.cycles-pp.copy_to_brd
      0.28 ±  2%      +0.0        0.31 ±  2%  perf-profile.children.cycles-pp.update_curr
      0.18 ±  2%      +0.0        0.22        perf-profile.children.cycles-pp.xlog_write
      0.23            +0.0        0.27        perf-profile.children.cycles-pp.xlog_state_do_callback
      0.23            +0.0        0.27        perf-profile.children.cycles-pp.xlog_state_do_iclog_callbacks
      0.23            +0.0        0.27        perf-profile.children.cycles-pp.xlog_ioend_work
      0.14 ±  2%      +0.0        0.19        perf-profile.children.cycles-pp.__wake_up
      0.38            +0.0        0.43        perf-profile.children.cycles-pp.brd_submit_bio
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.evict
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.xfs_defer_finish
      0.35            +0.1        0.40        perf-profile.children.cycles-pp.__mutex_unlock_slowpath
      0.33 ±  2%      +0.1        0.38        perf-profile.children.cycles-pp.enqueue_entity
      0.27            +0.1        0.32        perf-profile.children.cycles-pp.select_task_rq_fair
      0.37            +0.1        0.42        perf-profile.children.cycles-pp.dequeue_entity
      0.42 ±  2%      +0.1        0.48        perf-profile.children.cycles-pp.update_load_avg
      0.28            +0.1        0.34        perf-profile.children.cycles-pp.xlog_cil_push_work
      0.30 ±  7%      +0.1        0.36 ±  4%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      0.26            +0.1        0.32        perf-profile.children.cycles-pp.__wake_up_common
      0.16 ±  4%      +0.1        0.22 ± 39%  perf-profile.children.cycles-pp.xfs_trans_reserve
      0.47            +0.1        0.54        perf-profile.children.cycles-pp.complete
      0.14 ±  4%      +0.1        0.21 ± 40%  perf-profile.children.cycles-pp.xfs_log_reserve
      0.46            +0.1        0.53        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.39 ±  5%      +0.1        0.47 ±  3%  perf-profile.children.cycles-pp.down_read
      0.18 ±  2%      +0.1        0.26 ± 32%  perf-profile.children.cycles-pp.xfs_trans_alloc
      0.53            +0.1        0.61        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.10 ±  7%      +0.1        0.19 ±  4%  perf-profile.children.cycles-pp.xlog_force_lsn
      0.54            +0.1        0.63        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.56 ±  2%      +0.1        0.65        perf-profile.children.cycles-pp.dequeue_task_fair
      0.58 ±  2%      +0.1        0.67        perf-profile.children.cycles-pp.dequeue_entities
      0.78            +0.1        0.87        perf-profile.children.cycles-pp.iomap_write_iter
      0.56            +0.1        0.66        perf-profile.children.cycles-pp.ttwu_do_activate
      0.61            +0.1        0.71        perf-profile.children.cycles-pp.enqueue_task_fair
      0.65            +0.1        0.75        perf-profile.children.cycles-pp.sysvec_call_function_single
      0.62            +0.1        0.72        perf-profile.children.cycles-pp.enqueue_task
      0.99            +0.1        1.10        perf-profile.children.cycles-pp.iomap_file_buffered_write
      0.70 ±  2%      +0.1        0.82 ±  7%  perf-profile.children.cycles-pp.xfs_iomap_write_unwritten
      0.97 ±  2%      +0.2        1.13 ±  2%  perf-profile.children.cycles-pp.xlog_cil_commit
      1.00            +0.2        1.17        perf-profile.children.cycles-pp.try_to_wake_up
      1.09 ±  2%      +0.2        1.26 ±  2%  perf-profile.children.cycles-pp.__xfs_trans_commit
      0.91 ±  2%      +0.2        1.09 ±  6%  perf-profile.children.cycles-pp.xfs_vn_update_time
      0.95 ±  2%      +0.2        1.12 ±  6%  perf-profile.children.cycles-pp.kiocb_modified
      0.99 ±  2%      +0.2        1.16 ±  6%  perf-profile.children.cycles-pp.xfs_file_write_checks
      1.23            +0.2        1.41        perf-profile.children.cycles-pp.acpi_safe_halt
      1.23            +0.2        1.41        perf-profile.children.cycles-pp.acpi_idle_do_entry
      1.24            +0.2        1.42        perf-profile.children.cycles-pp.acpi_idle_enter
      1.29            +0.2        1.48        perf-profile.children.cycles-pp.cpuidle_enter
      1.18            +0.2        1.37        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      1.28            +0.2        1.47        perf-profile.children.cycles-pp.cpuidle_enter_state
      1.66            +0.2        1.88        perf-profile.children.cycles-pp.cpuidle_idle_call
      1.96            +0.3        2.23        perf-profile.children.cycles-pp.start_secondary
      1.98            +0.3        2.25        perf-profile.children.cycles-pp.do_idle
      1.99            +0.3        2.26        perf-profile.children.cycles-pp.common_startup_64
      1.99            +0.3        2.26        perf-profile.children.cycles-pp.cpu_startup_entry
      0.82            +0.3        1.10 ±  2%  perf-profile.children.cycles-pp.iomap_finish_ioends
      1.53            +0.4        1.93 ±  4%  perf-profile.children.cycles-pp.xfs_end_io
      1.52            +0.4        1.92 ±  4%  perf-profile.children.cycles-pp.xfs_end_ioend
      2.14            +0.5        2.64 ±  3%  perf-profile.children.cycles-pp.process_one_work
      2.37            +0.5        2.89 ±  2%  perf-profile.children.cycles-pp.worker_thread
      2.38            +0.5        2.90 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
      2.38            +0.5        2.90 ±  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
      2.38            +0.5        2.90 ±  2%  perf-profile.children.cycles-pp.kthread
      2.18 ±  6%      +0.8        2.95 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock
      2.82            +1.0        3.83 ±  2%  perf-profile.children.cycles-pp.iomap_submit_ioend
      2.80            +1.0        3.82 ±  2%  perf-profile.children.cycles-pp.__submit_bio
      2.81            +1.0        3.83 ±  2%  perf-profile.children.cycles-pp.__submit_bio_noacct
      2.16 ±  2%      +1.0        3.19 ±  4%  perf-profile.children.cycles-pp.sb_mark_inode_writeback
      2.33 ±  2%      +1.1        3.40 ±  3%  perf-profile.children.cycles-pp.__folio_start_writeback
      2.23 ±  2%      +1.1        3.30 ±  3%  perf-profile.children.cycles-pp.sb_clear_inode_writeback
      2.54 ±  2%      +1.1        3.62 ±  3%  perf-profile.children.cycles-pp.iomap_writepage_map
      2.41 ±  2%      +1.1        3.54 ±  2%  perf-profile.children.cycles-pp.xlog_wait_on_iclog
      2.76            +1.2        3.95 ±  3%  perf-profile.children.cycles-pp.__folio_end_writeback
      3.01            +1.2        4.23 ±  3%  perf-profile.children.cycles-pp.folio_end_writeback
      3.05            +1.2        4.28 ±  3%  perf-profile.children.cycles-pp.iomap_finish_ioend
      3.08 ±  2%      +1.5        4.62 ±  2%  perf-profile.children.cycles-pp.remove_wait_queue
      5.55            +2.1        7.67 ±  3%  perf-profile.children.cycles-pp.xfs_vm_writepages
      5.53            +2.1        7.65 ±  3%  perf-profile.children.cycles-pp.iomap_writepages
      5.56            +2.1        7.69 ±  3%  perf-profile.children.cycles-pp.do_writepages
      5.60            +2.1        7.73 ±  3%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      5.59            +2.1        7.72 ±  3%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
      5.80            +2.2        7.95 ±  3%  perf-profile.children.cycles-pp.file_write_and_wait_range
      7.97            +3.7       11.70 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      9.29 ±  2%      +4.4       13.71 ±  3%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     74.56            -5.7       68.81        perf-profile.self.cycles-pp.osq_lock
      0.18 ±  2%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.13            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.flush_workqueue_prep_pwqs
      0.24 ±  2%      -0.0        0.23        perf-profile.self.cycles-pp.nohz_balance_exit_idle
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.try_to_wake_up
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.write
      0.08            +0.0        0.09        perf-profile.self.cycles-pp.__flush_workqueue
      0.09            +0.0        0.10        perf-profile.self.cycles-pp.down_read
      0.08            +0.0        0.09        perf-profile.self.cycles-pp.prepare_task_switch
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.__switch_to_asm
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.task_h_load
      0.06            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.enqueue_entity
      0.07 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.06 ±  8%      +0.0        0.07        perf-profile.self.cycles-pp.__folio_start_writeback
      0.11 ±  3%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.06 ±  7%      +0.0        0.08        perf-profile.self.cycles-pp.__folio_end_writeback
      0.09 ±  4%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__mutex_lock
      0.10            +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.folio_end_writeback
      0.09            +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.11 ±  3%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.update_curr
      0.08            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.08 ±  5%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.available_idle_cpu
      0.16 ±  3%      +0.0        0.18        perf-profile.self.cycles-pp.__schedule
      0.17 ±  2%      +0.0        0.19 ±  2%  perf-profile.self.cycles-pp.iomap_set_range_uptodate
      0.20 ±  2%      +0.0        0.22 ±  3%  perf-profile.self.cycles-pp.update_load_avg
      0.29            +0.0        0.32        perf-profile.self.cycles-pp.copy_to_brd
      0.02 ±141%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.select_idle_cpu
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.menu_select
      0.41 ±  3%      +0.1        0.47 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.47            +0.1        0.54        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.58            +0.1        0.67        perf-profile.self.cycles-pp.acpi_safe_halt
      9.27 ±  2%      +4.4       13.68 ±  3%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


