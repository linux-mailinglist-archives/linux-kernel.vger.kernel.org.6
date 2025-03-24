Return-Path: <linux-kernel+bounces-573214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C8DA6D459
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C546188C786
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F065F18DB3D;
	Mon, 24 Mar 2025 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T79Msh4G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AE436D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742798395; cv=fail; b=aF1YmRS1TYcIIAI/HFwdXPWjurO9MfxCq3dZl4pXQ7vXa1GarOc+AoDHaSR1bTznQxX2Ag1iNB54ECovSV/M+UIwKOLtIPo3Rt6YiYepXIHQL3REmR8GFoeFkbPVVkDYqB7MC+eM8Fje+a+tvJk/vzIWPfW212YQchaIVS1wmfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742798395; c=relaxed/simple;
	bh=v5R/qQvP4SF1xHmdAwSYZT9sawfqJPDg0/FHXiLcvEY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=MmGigCX8YWcyqXYED1gSo3Q7ZAsRQAvjSZ50L/qG4B4ELjFUtbpsStIlI9anhrwOTTAwoMXahLIQCfD3V17Z3aQj4YZZ4p+fqqDuM7sxWt1UXtMragQd9CGKAFYN7OyFDuVKRaiB+U+sFA3vPIAphU78NaXPFHVpOXxX31E/R2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T79Msh4G; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742798391; x=1774334391;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=v5R/qQvP4SF1xHmdAwSYZT9sawfqJPDg0/FHXiLcvEY=;
  b=T79Msh4GVT/FezWavWaiMKOCzl0tNYIF3LXB020UY+e3aJE1jtNSh9LD
   pXIFzp3I5VCt93RZdPA2jjbeinIJe6h1Ey2ZgaCVUy5Aw5dkSQh28E2q5
   +AgG6bzBE8riwBbi3ICLIr0QSLfYOj881+iFQv56508TVWWfSKyd4KHU9
   9l1O+cp8/YRd4+a8lqDjXx1d50yIfrlRNrSKoOxc0t7SHtiDjBEvVbvHZ
   z/GSd6YJcGtfVBNCO9uZLI5hK9/ZAEwV6CXY2xJMQnfpl52+dpu1HPrtn
   zMinULpe+1N4zyk6eFWr8NiJ71WDjaGpydG6KXQuLewsGeoNtzq7XAaKq
   w==;
X-CSE-ConnectionGUID: V+TnR+a4Tm6zgC+ckwTDxQ==
X-CSE-MsgGUID: rQL60e/kTkeZr3vZNJy2Zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="47858589"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="47858589"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 23:39:50 -0700
X-CSE-ConnectionGUID: qSEjPW0TSlOPSwiq8XOsLg==
X-CSE-MsgGUID: bUbXn25qSs+JvnPzivSB/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="124736272"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 23:39:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 23 Mar 2025 23:39:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 23 Mar 2025 23:39:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 23 Mar 2025 23:39:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfJjdG4BiJLnK+Zi6Yu7ct/NxASXbSrGNrtSCxnxPtd8I8bv9AJ5VNLe65yM6rX7FpFMd3dUWtURwiLj+C5aRUsGjjGvNOLEWtt8anwy/DLFP+LAhUXV+d8Z+g1Qs9qPeUqRG8ducgvq113Cnahf5H3A0ZXSsNMY8P4nnxDNbfVr1tmFFEsTmD/lt9H2FBs0oaAzSQvmPigwRvf27SRIwNA9PedlNBumLOpPnBy7T4j5q6xP+CY2MVSB2teE32OhbYI2gkrBAXThPBnfNATyHUkNKNqTL1XAinzJzLKrXyD27xaY/Lg0TgZkw8bQso4fe0prfD9hT9VgyqD3T+YOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaKci0D/5vj0Nv5ujorVYO65MTXUT10hkuP+YLz4Kio=;
 b=MaPF8xi0yDaCV2uUvD3esD0fB7mRiIBzOLm/uT9qaO/3GxZnzdJO7ay1uoIXXoqz90w7+J9oRso8WEeWL9rn95V2em9cK7vkA3J9g/KI9JbHBy0YRuu2KwvfuvgzxdKAyHyImlCfDI7lAZyULEfNx//uokJQyLnPcDCb8I6x+mhPLc7rzQpjdthqa7JM+vLuQWYYQRH4rYF0EEzVoIuNEnPl6Q6euN6A56NnBV1UdgWAE5lbc/JCr8MSCaKdtFnNchkYITm2ndZGx0hsMdp08YZ40X9pO6CkVLTw4qBmR4mqg4OuZ1e3SMqqeqr84xLnwfozSHHa5KtJKkd1vhQ+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 06:39:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 06:39:45 +0000
Date: Mon, 24 Mar 2025 14:39:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Eric Dumazet <edumazet@google.com>, Benjamin Segall
	<bsegall@google.com>, Frederic Weisbecker <frederic@kernel.org>,
	<oliver.sang@intel.com>
Subject: [tip:timers/core] [posix]  1535cb8028:  stress-ng.epoll.ops_per_sec
 36.2% regression
Message-ID: <202503241406.5c9cb80a-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: ef91ed5a-6e67-440c-30a2-08dd6a9eaa2d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?t8ZdnVHI6QwcVuF/LSvx35xS64ZPQEscO4cxnZpX0V/1jUndByhv+jD7F3?=
 =?iso-8859-1?Q?qdgwbTNHemb/9pyEnu/0+jfI+5L1Tz1B+wbUXlVVaSAAB3bY4ixt2cSkBy?=
 =?iso-8859-1?Q?BTOfTXZO/d9vmCmqMK0CkHBUHsq3o3xZU5qvhrw8vmSYyOZYciv2iE9hYY?=
 =?iso-8859-1?Q?HUARE0G8BVtsFA6MhGA+Kx2CRMmrdU36hxh8Lz8iDc5HtKti5igQvEc5HB?=
 =?iso-8859-1?Q?HO3pKDry3Qse3eObVLyll4iabKsTKPB1HnCIZnCejUKSTIYHP1SSExmlZp?=
 =?iso-8859-1?Q?A2C7ZnzU6jt6amszggjV52LgNqu95eXYU9LNX3kOE2csQr7nWWHJ306eJS?=
 =?iso-8859-1?Q?gzhYCOCfGYLJH+JOsNDmZ8vgVWXFemYSUAd5tAP7OFBBVyxuiEnJ2bvRuJ?=
 =?iso-8859-1?Q?KYvNw7vBcEHcuE4h6NbKHgfsvl3BDVQ2roYnEdA1RDv1SnkpQNXi9s/Rqa?=
 =?iso-8859-1?Q?tqMXGYRcloBZ4HAEujBP/g0X6J+DSqUtNGhPa2uMJOE7jP9pC3ws4n+U8m?=
 =?iso-8859-1?Q?hqe3FD03LBJANwIb/B+EmkDch/p4k66JFTzLMNeI7IALcewOqTbocREJaa?=
 =?iso-8859-1?Q?D4udzfjbwIyJW0MxbFmifJPlgXZn/LnNP5AOHq89LhI7HusRKEwdfuXIuA?=
 =?iso-8859-1?Q?XW43pljsZyHNofC+Fl9zzytaXWCAs/hGVJkDKxGgPVe6Yz1x89gD6b32RE?=
 =?iso-8859-1?Q?Slp/kESd8H82hqymrF39cb6BbsDuJiivg1YbND5rMIi6mDUkdzPjPYHN0Q?=
 =?iso-8859-1?Q?jcTtBx89cRufth1bZc2aL5u8VwaI+u4Jth6oKNaA/VLeCunmvrXVgD6/gt?=
 =?iso-8859-1?Q?XX9qyTMfeNetPLMlV2fiSjhs2sPeUKiq47b+VEE8dHe16v55yP++wpyG8X?=
 =?iso-8859-1?Q?K3/+mQk9URqb3VMiIH7TAr/VH3gIJJnOVBESXqGKdpnjy049drzIib3aTU?=
 =?iso-8859-1?Q?uidHtiUVFwmkh1901qma3mDfYlXhttBB9Op7q3DTpl3mJvijcM1knDovJv?=
 =?iso-8859-1?Q?aGCTsx1R3YuU7lip8iPh3mB+SqEj8wTLt4S+4gtsOLg9HlTDZQkmY1upBI?=
 =?iso-8859-1?Q?4GvdrsEx1PNh3cu6Ctg6NXSaFh6AYtyvWAD8CCHAn4GST4j6ZtJUh564Vc?=
 =?iso-8859-1?Q?Z7EqxPUaRqAvlv2LBw3v/PP7wMP0NETLhqeFcCxyoTQF+thXJYHM52uCPb?=
 =?iso-8859-1?Q?Kjr6c2S+satm+Pa41B/LoYmHpWkm3WTNWM6Y1zaVvI6hQAG0s3LjR69Ses?=
 =?iso-8859-1?Q?UbmFvvb8h7+WBWcXkyN6pVYF0b7e8aVq+wSJtnALNKcrEpLW8hWzruwPD0?=
 =?iso-8859-1?Q?r1Pkq3/dfnQIu0aQ4V1TAPdEN0BgQ3Q6JZ0co/KltlmrG/PkDZdgf5/dNl?=
 =?iso-8859-1?Q?B6qX9zDgXhki09psW7Va20SfyvY2oAvw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?24Oz7fpSrR9aILThwktPByH12QVmepXv/72OJfsVizwMXQSfOzlYpX/rIw?=
 =?iso-8859-1?Q?n0fSae+nYjLq3rlvPYInPNvpqojL1nRoJosseAzAR5JNxVIdDDCFDWYCyc?=
 =?iso-8859-1?Q?VpgeJ5UqNT8No/WFsOC8J3sagendarApnjjup5wG+2PkMTeICBi2bjJfzj?=
 =?iso-8859-1?Q?xkro/EA6T2cW11Un5WZfBveyS++Be0xuzKtVv+PiqmiXaRtInobx2ckh6b?=
 =?iso-8859-1?Q?KtEqzQN9FkQ3rTVg7UxFHrBa0TwfYT939iBrWIH144BZ6Oa88S1uZu76lF?=
 =?iso-8859-1?Q?mRDrJ0IQAr2C+2KzVjs+v1aGskQp71ndGmDApi2ERCV97T+KQWywpXrBIE?=
 =?iso-8859-1?Q?QZoRdNUrVKHmNanOOBTXO01j8HV1utKb66wJ0zZ+XSISF/A1vZpJ8vRsBO?=
 =?iso-8859-1?Q?aQz9hErDamhKDWCkqvznD3NXwZnlg1r2iia00POw0JXGLl23OiWHfS5VtW?=
 =?iso-8859-1?Q?p226ncL2JhaojCDYE9McUoZHwGSwCjGBi9kISzTyxnOSiC8cpMfgFfLwnt?=
 =?iso-8859-1?Q?IiS+pggdm+uaYRUuhmINeR+RqQYHje8sCpPTD99+1T+0LcC8jgsFETR2oF?=
 =?iso-8859-1?Q?DFsiQXRDlDpGuj3AMtIN8whvwbMea2TTO2NZkjjA3ZC4+nX11vUpPPViED?=
 =?iso-8859-1?Q?l6P86GY9P76/MCP2LqON7n27yexMVBSgCLxnG/Xc21PidANDPqUgVqPzHB?=
 =?iso-8859-1?Q?ChNylo0y6kkkYQcO4WSLIyFuvnB1jr0KMLqiktFGciQfqh6TO1imTtUObN?=
 =?iso-8859-1?Q?xTO3nFqWRvbEqvsqcLUb1VQRzPFJlaw/pkxobcwa8TnTWoGza5LaFsKw3x?=
 =?iso-8859-1?Q?refnDNptaO+lqC1RS/SsL6YV52v3WCbhqTDeMhgMVoIiyvHutWR2TGJhHD?=
 =?iso-8859-1?Q?PnFBwTYTWzu8bCy2q//hwDrzRs12OrHws34+oFkBYP96alFzxPcuvodhaR?=
 =?iso-8859-1?Q?oZ6mRo8d6uxd3Z+JxutbqDZPP5MrSHCx9EzU7jgyet8e6cDs4pjOicdi2v?=
 =?iso-8859-1?Q?9vVG33PVPRT45F4OK3RXz2eJTCiU8YCNdaajQtKTJFUa7DhrgvIshYDc9m?=
 =?iso-8859-1?Q?XNY+QZYxv74sMyYk1rvsgpprRfHjRZSeEnpMVjzUSYe9gV75KPDEJCJJdM?=
 =?iso-8859-1?Q?jyQg2o3pes/oqczVhCFdiDTOXDzVC9XbMYGsPGvs3bX9NPHtPGCQfWXN1X?=
 =?iso-8859-1?Q?JXscdzC0/1fKI+g3rHZ7bAhE/k91siiyckbUDmrZJSEfPcstdBUcIIy0HY?=
 =?iso-8859-1?Q?1Ewy3SgjUnZEioD1lGyJ2nWpLD3BjQk1Bc4lpCOnC0TkolSVtkb/X/dWnw?=
 =?iso-8859-1?Q?nu3zo0XyxOKucNsUOg99Q6kptgZ816kkj1DgcJFz+kOVxu6BXyrBEVlZbD?=
 =?iso-8859-1?Q?Hs6+56I7xJEBNS/Z972v2ZDhdr8lO39xe5e/HXH+XoW0ajE95bKzJ549Jm?=
 =?iso-8859-1?Q?S/9Tpv0au+HoaRbJpUGM+4bxfv3fCpIoDq0iE5vvNXe/DeQguhlSEXzf+o?=
 =?iso-8859-1?Q?brAgwMGI5jyZa5M0ld8H8bZ+lKVtXfob/h5lNP3hNM5ZgRvAut8UFmdmtF?=
 =?iso-8859-1?Q?rkVbLYCP2E8vY2kDKKNAvTLTe/AvaNSC6kMy4Hga4747P4qK3VyVWVNXBr?=
 =?iso-8859-1?Q?pcGpKQKxsHqzJEypzPOQtFhFn3nfcGdc6kQX7pEMEOCzQKB7ITfMSnGg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef91ed5a-6e67-440c-30a2-08dd6a9eaa2d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 06:39:45.4982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2JqF4W8/pJdIuckkivEdCE5J1DVrg7k3EUQcn3msDlVL11L0bRDlegQ/OcOlc+5V3q+GK+UpF6HMYUDwTvF1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5120
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 36.2% regression of stress-ng.epoll.ops_per_sec on:


commit: 1535cb80286e6fbc834f075039f85274538543c7 ("posix-timers: Improve hash table performance")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git timers/core


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: epoll
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.epoll.ops_per_sec 124.9% improvement                       |
| test machine     | 256 threads 2 sockets GENUINE INTEL(R) XEON(R) (Sierra Forest) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                    |
|                  | nr_threads=100%                                                                 |
|                  | test=epoll                                                                      |
|                  | testtime=60s                                                                    |
+------------------+---------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503241406.5c9cb80a-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250324/202503241406.5c9cb80a-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/epoll/stress-ng/60s

commit: 
  feb864ee99 ("posix-timers: Make signal_struct:: Next_posix_timer_id an atomic_t")
  1535cb8028 ("posix-timers: Improve hash table performance")

feb864ee99a2d8a2 1535cb80286e6fbc834f075039f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2580 ±  7%    +113.6%       5512 ±  6%  uptime.idle
 2.503e+08 ± 19%   +1174.1%  3.189e+09 ±  8%  cpuidle..time
    965881 ± 22%     +57.0%    1516318 ± 12%  cpuidle..usage
  48355626           -33.1%   32367066 ± 19%  numa-numastat.node0.local_node
  48387809           -33.0%   32398849 ± 19%  numa-numastat.node0.numa_hit
  47299728           -33.1%   31637160 ± 22%  numa-numastat.node1.local_node
  47323998           -33.1%   31677662 ± 22%  numa-numastat.node1.numa_hit
      5.71 ± 20%     +72.0       77.67 ±  6%  mpstat.cpu.all.idle%
      0.36 ±  2%      -0.2        0.12 ± 18%  mpstat.cpu.all.irq%
     88.37           -69.2       19.21 ± 21%  mpstat.cpu.all.sys%
      4.95 ±  4%      -2.7        2.20 ± 15%  mpstat.cpu.all.usr%
      7.17 ± 25%     -58.1%       3.00        mpstat.max_utilization.seconds
      6528 ±  8%     -80.3%       1282 ± 50%  perf-c2c.DRAM.local
     25918           -92.8%       1864 ± 31%  perf-c2c.DRAM.remote
     27117 ±  2%     -68.6%       8524 ± 32%  perf-c2c.HITM.local
     18359           -94.9%     944.58 ± 32%  perf-c2c.HITM.remote
     45476           -79.2%       9468 ± 32%  perf-c2c.HITM.total
      8.15 ± 14%    +858.2%      78.13 ±  5%  vmstat.cpu.id
     86.98           -77.4%      19.66 ± 21%  vmstat.cpu.sy
     98.89 ±  2%     -84.1%      15.75 ± 20%  vmstat.procs.r
    768987 ±  2%     -95.1%      37670 ± 17%  vmstat.system.cs
    209597 ±  2%     -71.5%      59763 ± 21%  vmstat.system.in
  87617311           -36.1%   55996474 ± 18%  stress-ng.epoll.ops
   1458844           -36.2%     931227 ± 18%  stress-ng.epoll.ops_per_sec
  23167102 ±  3%     -97.7%     541929 ± 20%  stress-ng.time.involuntary_context_switches
     32989            -5.4%      31202        stress-ng.time.minor_page_faults
      5901           -76.9%       1365 ± 20%  stress-ng.time.percent_of_cpu_this_job_got
      3420           -77.6%     765.67 ± 20%  stress-ng.time.system_time
    138.74           -58.0%      58.20 ± 19%  stress-ng.time.user_time
  23490375 ±  2%     -96.8%     762147 ± 19%  stress-ng.time.voluntary_context_switches
   4047201 ±  2%     -58.1%    1695268 ±  9%  meminfo.Active
   4047201 ±  2%     -58.1%    1695268 ±  9%  meminfo.Active(anon)
   6632349           -35.2%    4296645 ±  3%  meminfo.Cached
   4994255 ±  2%     -47.4%    2627103 ±  6%  meminfo.Committed_AS
    826943 ± 27%     -79.0%     173492 ±  7%  meminfo.Mapped
   9014037           -11.3%    7993381 ±  2%  meminfo.Memused
    328931 ±  5%    +211.1%    1023179 ±  4%  meminfo.SUnreclaim
   3104430 ±  3%     -75.2%     768720 ± 19%  meminfo.Shmem
    484360 ±  3%    +142.8%    1176077 ±  3%  meminfo.Slab
   1755625 ± 32%     -69.8%     529877 ± 58%  numa-meminfo.node0.Active
   1755625 ± 32%     -69.8%     529877 ± 58%  numa-meminfo.node0.Active(anon)
    377524 ± 48%     -81.2%      71066 ± 79%  numa-meminfo.node0.Mapped
    159257 ± 11%    +229.0%     523897 ±  9%  numa-meminfo.node0.SUnreclaim
   1293413 ± 36%     -91.7%     106929 ±192%  numa-meminfo.node0.Shmem
    231196 ± 11%    +158.8%     598232 ±  7%  numa-meminfo.node0.Slab
   2291699 ± 22%     -49.2%    1165268 ± 32%  numa-meminfo.node1.Active
   2291699 ± 22%     -49.2%    1165268 ± 32%  numa-meminfo.node1.Active(anon)
    453283 ± 25%     -77.6%     101593 ± 51%  numa-meminfo.node1.Mapped
    169108 ± 18%    +194.8%     498594 ±  5%  numa-meminfo.node1.SUnreclaim
   1810819 ± 24%     -63.4%     662050 ± 33%  numa-meminfo.node1.Shmem
    252608 ± 13%    +128.5%     577128 ±  6%  numa-meminfo.node1.Slab
    439128 ± 32%     -69.9%     132285 ± 58%  numa-vmstat.node0.nr_active_anon
     94937 ± 48%     -81.2%      17880 ± 79%  numa-vmstat.node0.nr_mapped
    323574 ± 36%     -91.7%      26744 ±192%  numa-vmstat.node0.nr_shmem
     39869 ± 11%    +227.1%     130412 ±  9%  numa-vmstat.node0.nr_slab_unreclaimable
    439127 ± 32%     -69.9%     132285 ± 58%  numa-vmstat.node0.nr_zone_active_anon
  48387857           -33.0%   32398745 ± 19%  numa-vmstat.node0.numa_hit
  48355674           -33.1%   32366962 ± 19%  numa-vmstat.node0.numa_local
    573170 ± 22%     -49.2%     291167 ± 32%  numa-vmstat.node1.nr_active_anon
    113887 ± 25%     -77.4%      25724 ± 51%  numa-vmstat.node1.nr_mapped
    452974 ± 24%     -63.5%     165522 ± 33%  numa-vmstat.node1.nr_shmem
     42276 ± 18%    +193.4%     124048 ±  5%  numa-vmstat.node1.nr_slab_unreclaimable
    573170 ± 22%     -49.2%     291167 ± 32%  numa-vmstat.node1.nr_zone_active_anon
  47324233           -33.1%   31677233 ± 22%  numa-vmstat.node1.numa_hit
  47299963           -33.1%   31636731 ± 22%  numa-vmstat.node1.numa_local
   1011581 ±  2%     -58.1%     423533 ±  9%  proc-vmstat.nr_active_anon
   1657746           -35.2%    1074278 ±  3%  proc-vmstat.nr_file_pages
    208502 ± 27%     -79.2%      43425 ±  6%  proc-vmstat.nr_mapped
    775765 ±  3%     -75.2%     192295 ± 19%  proc-vmstat.nr_shmem
     82134 ±  5%    +210.4%     254960 ±  4%  proc-vmstat.nr_slab_unreclaimable
   1011581 ±  2%     -58.1%     423533 ±  9%  proc-vmstat.nr_zone_active_anon
     22120 ± 43%     -70.6%       6501 ± 92%  proc-vmstat.numa_hint_faults
     12945 ± 53%     -89.1%       1410 ±102%  proc-vmstat.numa_hint_faults_local
  95713574           -33.1%   64078178 ± 18%  proc-vmstat.numa_hit
  95657121           -33.1%   64005892 ± 18%  proc-vmstat.numa_local
     45928 ± 22%     -45.0%      25255 ± 33%  proc-vmstat.numa_pages_migrated
    335648 ± 12%     -65.5%     115662 ± 36%  proc-vmstat.numa_pte_updates
    383375 ±  3%     -18.7%     311501 ±  4%  proc-vmstat.pgfault
     45928 ± 22%     -45.0%      25255 ± 33%  proc-vmstat.pgmigrate_success
 1.855e+10           -51.0%  9.092e+09 ± 18%  perf-stat.i.branch-instructions
 1.252e+08 ±  3%     -52.3%   59710873 ± 11%  perf-stat.i.branch-misses
     39.80           -15.7       24.06 ± 11%  perf-stat.i.cache-miss-rate%
 2.409e+08           -52.5%  1.144e+08 ± 26%  perf-stat.i.cache-misses
    798933 ±  2%     -95.1%      39139 ± 17%  perf-stat.i.context-switches
      2.53           -55.6%       1.12 ±  3%  perf-stat.i.cpi
 2.189e+11           -75.9%  5.273e+10 ± 20%  perf-stat.i.cpu-cycles
      6147 ±  9%     -96.1%     236.94 ± 17%  perf-stat.i.cpu-migrations
    911.39           -45.2%     499.82 ± 12%  perf-stat.i.cycles-between-cache-misses
  8.65e+10           -50.0%  4.321e+10 ± 18%  perf-stat.i.instructions
      0.40          +129.6%       0.92 ±  3%  perf-stat.i.ipc
     22.06 ±  2%     -88.8%       2.46 ± 24%  perf-stat.i.metric.K/sec
      4581 ±  5%     -27.9%       3300 ±  3%  perf-stat.i.minor-faults
    613522 ±  2%     -75.8%     148218 ± 22%  perf-stat.i.page-faults
     40.00           -13.0       27.00 ±  6%  perf-stat.overall.cache-miss-rate%
      2.53           -51.9%       1.22 ±  2%  perf-stat.overall.cpi
    908.65           -48.5%     468.05 ±  6%  perf-stat.overall.cycles-between-cache-misses
      0.40          +108.0%       0.82 ±  2%  perf-stat.overall.ipc
 1.825e+10           -50.9%  8.955e+09 ± 18%  perf-stat.ps.branch-instructions
 1.231e+08 ±  3%     -52.2%   58818328 ± 11%  perf-stat.ps.branch-misses
  2.37e+08           -52.4%  1.128e+08 ± 26%  perf-stat.ps.cache-misses
    786402 ±  2%     -95.1%      38556 ± 17%  perf-stat.ps.context-switches
 2.153e+11           -75.9%  5.197e+10 ± 20%  perf-stat.ps.cpu-cycles
      6033 ±  9%     -96.1%     233.55 ± 17%  perf-stat.ps.cpu-migrations
 8.509e+10           -50.0%  4.256e+10 ± 18%  perf-stat.ps.instructions
      4498 ±  5%     -27.8%       3246 ±  3%  perf-stat.ps.minor-faults
    603733 ±  2%     -75.8%     145885 ± 22%  perf-stat.ps.page-faults
 5.261e+12           -48.8%  2.695e+12 ± 17%  perf-stat.total.instructions
   1908185           -90.4%     183760 ± 39%  sched_debug.cfs_rq:/.avg_vruntime.avg
   2085734 ±  2%     -82.8%     357857 ± 33%  sched_debug.cfs_rq:/.avg_vruntime.max
   1755250 ±  3%     -93.5%     113981 ± 44%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.91 ±  8%     -75.8%       0.22 ± 13%  sched_debug.cfs_rq:/.h_nr_queued.avg
      2.29 ± 13%     -41.8%       1.33 ± 17%  sched_debug.cfs_rq:/.h_nr_queued.max
      0.57 ±  5%     -25.8%       0.42 ±  6%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.87 ±  8%     -75.0%       0.22 ± 13%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      2.21 ± 14%     -45.3%       1.21 ± 20%  sched_debug.cfs_rq:/.h_nr_runnable.max
      0.56 ±  5%     -25.6%       0.42 ±  6%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
     11.50 ± 11%    -100.0%       0.00        sched_debug.cfs_rq:/.load_avg.min
   1908185           -90.4%     183760 ± 39%  sched_debug.cfs_rq:/.min_vruntime.avg
   2085734 ±  2%     -82.8%     357857 ± 33%  sched_debug.cfs_rq:/.min_vruntime.max
   1755250 ±  3%     -93.5%     113981 ± 44%  sched_debug.cfs_rq:/.min_vruntime.min
      0.62 ±  4%     -64.5%       0.22 ± 13%  sched_debug.cfs_rq:/.nr_queued.avg
      0.33 ± 10%     +26.7%       0.42 ±  6%  sched_debug.cfs_rq:/.nr_queued.stddev
      1001 ±  2%     -68.0%     320.45 ± 15%  sched_debug.cfs_rq:/.runnable_avg.avg
      2014 ± 10%     -38.4%       1239 ±  9%  sched_debug.cfs_rq:/.runnable_avg.max
    119.25 ±108%    -100.0%       0.00        sched_debug.cfs_rq:/.runnable_avg.min
    729.40 ±  2%     -56.2%     319.46 ± 15%  sched_debug.cfs_rq:/.util_avg.avg
      1476 ±  8%     -17.0%       1225 ±  9%  sched_debug.cfs_rq:/.util_avg.max
     90.17 ± 94%    -100.0%       0.00        sched_debug.cfs_rq:/.util_avg.min
    461.66 ± 14%     -81.6%      84.96 ± 31%  sched_debug.cfs_rq:/.util_est.avg
      1464 ± 14%     -48.0%     760.79 ± 13%  sched_debug.cfs_rq:/.util_est.max
    358.79 ±  7%     -39.1%     218.62 ± 17%  sched_debug.cfs_rq:/.util_est.stddev
    440504 ±  5%     +77.0%     779768 ±  4%  sched_debug.cpu.avg_idle.avg
      7249 ±  9%     -32.7%       4875 ± 14%  sched_debug.cpu.avg_idle.min
      1611 ±  4%     -68.5%     507.80 ± 13%  sched_debug.cpu.curr->pid.avg
    736.86 ± 13%     +35.9%       1001 ±  7%  sched_debug.cpu.curr->pid.stddev
      0.91 ±  7%     -75.9%       0.22 ± 13%  sched_debug.cpu.nr_running.avg
      2.29 ± 13%     -41.8%       1.33 ± 17%  sched_debug.cpu.nr_running.max
      0.57 ±  5%     -25.5%       0.42 ±  6%  sched_debug.cpu.nr_running.stddev
    377262 ±  2%     -95.0%      19038 ± 32%  sched_debug.cpu.nr_switches.avg
    421952 ±  2%     -87.1%      54289 ± 29%  sched_debug.cpu.nr_switches.max
    327735 ±  5%     -98.5%       4957 ± 37%  sched_debug.cpu.nr_switches.min
     22410 ± 34%     -55.0%      10080 ± 27%  sched_debug.cpu.nr_switches.stddev
      0.13 ± 54%     -86.1%       0.02 ± 32%  sched_debug.cpu.nr_uninterruptible.avg
    225.08 ± 27%     -92.7%      16.38 ± 44%  sched_debug.cpu.nr_uninterruptible.max
   -215.92           -94.0%     -12.92        sched_debug.cpu.nr_uninterruptible.min
     92.39 ± 14%     -94.8%       4.79 ± 17%  sched_debug.cpu.nr_uninterruptible.stddev
      1.07 ± 64%     -99.0%       0.01 ±189%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.allocate_slab.___slab_alloc
      1.35 ± 43%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
      1.02 ± 24%     -90.9%       0.09 ± 54%  perf-sched.sch_delay.avg.ms.__cond_resched.__dentry_kill.dput.__fput.__x64_sys_close
      0.13 ± 41%     -98.5%       0.00 ± 48%  perf-sched.sch_delay.avg.ms.__cond_resched.__dentry_kill.dput.__fput.task_work_run
      1.19 ± 24%     -94.5%       0.07 ± 68%  perf-sched.sch_delay.avg.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.09 ± 80%     -98.9%       0.00 ±122%  perf-sched.sch_delay.avg.ms.__cond_resched.__fput.task_work_run.syscall_exit_to_user_mode.do_syscall_64
      0.72 ± 34%     -90.0%       0.07 ±122%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
      0.14 ± 63%     -99.0%       0.00 ±105%  perf-sched.sch_delay.avg.ms.__cond_resched.__mutex_lock.constprop.0.do_epoll_ctl
      0.11 ± 48%     -68.9%       0.04 ± 27%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1.24 ± 44%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      0.14 ± 89%     -99.8%       0.00 ±331%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.11 ±131%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      1.60 ± 20%     -98.5%       0.02 ± 62%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__sock_release.sock_close.__fput
      0.81 ±131%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      0.02 ± 80%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.14 ±214%     -99.0%       0.00 ±103%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.task_work_run.syscall_exit_to_user_mode
      1.60 ± 21%     -99.4%       0.01 ± 51%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.path_put.unix_release_sock.unix_release
      1.27 ± 42%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.05 ± 62%     -96.3%       0.00 ±104%  perf-sched.sch_delay.avg.ms.__cond_resched.kfree_rcu_work.process_one_work.worker_thread.kthread
      0.27 ± 22%     -42.3%       0.16 ± 32%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc_pseudo.alloc_file_pseudo
      1.01 ± 27%     -94.1%       0.06 ± 72%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.sock_alloc_inode.alloc_inode.sock_alloc
      0.98 ± 25%     -93.4%       0.06 ± 43%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.sock_alloc_file
      1.20 ± 26%     -99.7%       0.00 ± 45%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.ep_insert.do_epoll_ctl.__x64_sys_epoll_ctl
      0.23 ± 61%     -99.0%       0.00 ± 41%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.ep_ptable_queue_proc.__ep_eventpoll_poll.isra
      1.44 ± 22%     -99.8%       0.00 ± 56%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.ep_ptable_queue_proc.unix_poll.sock_poll
      0.80 ± 23%     -91.4%       0.07 ± 54%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
      0.09 ± 20%     -98.7%       0.00 ±174%  perf-sched.sch_delay.avg.ms.__cond_resched.kvfree_rcu_drain_ready.kfree_rcu_monitor.process_one_work.worker_thread
      0.12 ± 41%     -99.4%       0.00 ±110%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.__ep_eventpoll_poll.isra.0
      1.20 ± 29%     -99.6%       0.01 ± 48%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.do_epoll_ctl.__x64_sys_epoll_ctl.do_syscall_64
      0.12 ± 76%     -98.1%       0.00 ± 61%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.ep_insert.do_epoll_ctl.__x64_sys_epoll_ctl
      0.11 ± 14%     -98.0%       0.00 ± 31%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.ep_loop_check_proc.do_epoll_ctl.__x64_sys_epoll_ctl
      0.11 ± 32%     -97.1%       0.00 ± 60%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.ep_send_events.ep_poll.do_epoll_wait
      1.85 ± 32%     -99.9%       0.00 ± 92%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.eventpoll_release_file.__fput.__x64_sys_close
      0.85 ± 43%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
      0.00 ± 10%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      0.04 ± 20%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.95 ± 42%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      1.34 ± 52%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.05 ± 32%     -92.7%       0.00 ± 85%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.14 ± 79%    -100.0%       0.00 ±331%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      0.15 ± 96%     -98.0%       0.00 ± 35%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.18 ± 45%     -98.9%       0.00 ± 45%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.87 ± 44%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.13 ± 77%     -98.9%       0.01 ± 19%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.13 ± 49%     -96.5%       0.00 ± 13%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.11 ± 38%     -94.9%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ± 41%     -56.6%       0.01 ± 13%  perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.10 ± 77%     -99.6%       0.00 ±182%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.93 ± 21%     -98.2%       0.02 ± 48%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.24 ± 25%     -52.7%       0.11 ± 54%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.29 ± 30%     -96.1%       0.01 ±142%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.07 ± 23%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      0.18 ± 72%     -97.9%       0.00 ±120%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.05 ± 59%     -89.3%       0.01 ± 23%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.26 ± 37%     -99.6%       0.00 ±134%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      0.03 ±  4%     -80.8%       0.01 ± 35%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.04 ±  4%     -86.0%       0.01 ± 25%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.do_epoll_pwait.part
      0.15 ±  7%     -76.1%       0.04 ± 46%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.do_epoll_ctl
      0.17 ± 51%     -97.6%       0.00 ± 14%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.05 ± 38%     -86.6%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 19%     -69.8%       0.00 ± 10%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.09 ± 52%     -95.3%       0.00 ±  6%  perf-sched.sch_delay.avg.ms.schedule_timeout.unix_wait_for_peer.unix_stream_connect.__sys_connect
      0.04 ± 50%     -92.5%       0.00 ± 33%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.05 ± 13%     -86.9%       0.01 ± 51%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      5.17 ± 33%     -92.6%       0.38 ± 39%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.alloc_skb_with_frags
      7.13 ± 43%     -99.4%       0.04 ±207%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.allocate_slab.___slab_alloc
      9.23 ± 19%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
     17.86 ± 75%     -96.6%       0.60 ±153%  perf-sched.sch_delay.max.ms.__cond_resched.__dentry_kill.dput.__fput.__x64_sys_close
      3.17 ± 77%     -99.9%       0.00 ± 36%  perf-sched.sch_delay.max.ms.__cond_resched.__dentry_kill.dput.__fput.task_work_run
     13.74 ± 12%     -97.5%       0.35 ± 24%  perf-sched.sch_delay.max.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.51 ± 89%     -99.7%       0.00 ±119%  perf-sched.sch_delay.max.ms.__cond_resched.__fput.task_work_run.syscall_exit_to_user_mode.do_syscall_64
      9.06 ± 24%     -98.2%       0.16 ±112%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
      3.82 ± 22%     -91.5%       0.33 ± 41%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      2.75 ± 66%     -99.9%       0.00 ±101%  perf-sched.sch_delay.max.ms.__cond_resched.__mutex_lock.constprop.0.do_epoll_ctl
     11.29 ±153%     -83.3%       1.88 ± 42%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      7.69 ± 39%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      0.71 ±105%    -100.0%       0.00 ±331%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.54 ±155%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
     14.15 ±  8%     -98.0%       0.28 ± 47%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.__sock_release.sock_close.__fput
      2.28 ±106%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      0.13 ± 90%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
     18.33 ± 65%     -97.3%       0.50 ± 71%  perf-sched.sch_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.75 ±199%     -99.8%       0.00 ±100%  perf-sched.sch_delay.max.ms.__cond_resched.dput.__fput.task_work_run.syscall_exit_to_user_mode
      4.78 ± 30%     -91.9%       0.39 ± 32%  perf-sched.sch_delay.max.ms.__cond_resched.dput.path_put.unix_find_other.unix_stream_connect
     16.34 ± 12%     -96.8%       0.52 ± 45%  perf-sched.sch_delay.max.ms.__cond_resched.dput.path_put.unix_release_sock.unix_release
     10.67 ± 15%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      9.21 ±221%    -100.0%       0.00 ±104%  perf-sched.sch_delay.max.ms.__cond_resched.kfree_rcu_work.process_one_work.worker_thread.kthread
     13.01 ± 15%     -96.9%       0.40 ± 27%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc_pseudo.alloc_file_pseudo
     11.88 ± 11%     -96.6%       0.40 ± 91%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.sock_alloc_inode.alloc_inode.sock_alloc
      4.24 ± 30%     -91.4%       0.36 ± 28%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      5.20 ± 27%     -92.7%       0.38 ± 44%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.sock_wmalloc.unix_stream_connect
      2.99 ± 35%     -91.4%       0.26 ± 55%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.sock_wmalloc
     14.05 ± 13%     -97.6%       0.34 ± 36%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.sock_alloc_file
      2.62 ± 38%     -89.3%       0.28 ± 55%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.do_timer_create.__x64_sys_timer_create.do_syscall_64
     13.78 ± 10%     -98.7%       0.18 ± 91%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.ep_insert.do_epoll_ctl.__x64_sys_epoll_ctl
      3.84 ± 78%     -99.9%       0.00 ± 36%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.ep_ptable_queue_proc.__ep_eventpoll_poll.isra
     13.52 ± 18%     -98.8%       0.16 ±104%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.ep_ptable_queue_proc.unix_poll.sock_poll
      3.76 ± 22%     -90.9%       0.34 ± 21%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.getname_kernel.kern_path.unix_find_other
     13.73 ± 11%     -97.3%       0.37 ± 36%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
     11.95 ±196%     -96.6%       0.41 ± 29%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.sk_prot_alloc.sk_alloc.unix_create1
      0.80 ± 36%     -99.9%       0.00 ±174%  perf-sched.sch_delay.max.ms.__cond_resched.kvfree_rcu_drain_ready.kfree_rcu_monitor.process_one_work.worker_thread
      1.59 ± 64%     -99.9%       0.00 ±101%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.__ep_eventpoll_poll.isra.0
     13.47 ± 12%     -98.0%       0.27 ± 65%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.do_epoll_ctl.__x64_sys_epoll_ctl.do_syscall_64
      1.76 ± 83%     -99.8%       0.00 ± 59%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.ep_insert.do_epoll_ctl.__x64_sys_epoll_ctl
      6.39 ± 23%     -99.9%       0.00 ± 45%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.ep_loop_check_proc.do_epoll_ctl.__x64_sys_epoll_ctl
      4.63 ± 39%     -97.4%       0.12 ±138%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.ep_send_events.ep_poll.do_epoll_wait
     10.35 ± 18%    -100.0%       0.00 ± 86%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.eventpoll_release_file.__fput.__x64_sys_close
      6.07 ± 19%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
      0.01 ± 64%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      0.64 ± 30%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      6.63 ± 16%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      9.38 ± 24%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.62 ± 24%     -99.4%       0.00 ± 84%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      5.56 ± 60%    -100.0%       0.00 ±331%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      1.54 ± 86%     -99.7%       0.01 ± 83%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      4.87 ± 53%     -99.9%       0.00 ± 33%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.60 ± 35%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.93 ± 56%     -96.8%       0.63 ± 99%  perf-sched.sch_delay.max.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5.69 ± 69%     -99.1%       0.05 ±201%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      3.30 ± 66%     -98.2%       0.06 ±125%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      2.15 ± 40%     -99.5%       0.01 ± 12%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.04 ±111%     -75.4%       0.01 ± 14%  perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.37 ± 80%     -99.9%       0.00 ±182%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
     14.71 ± 17%     -96.1%       0.58 ± 41%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      7.30 ± 13%     -94.3%       0.41 ± 31%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      7.52 ± 24%     -99.8%       0.01 ±135%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      1.92 ± 61%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      6.67 ± 45%     -98.0%       0.13 ±154%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      2.15 ± 59%     -99.8%       0.00 ±121%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
     14.55 ±169%     -96.4%       0.53 ± 59%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.66 ± 34%     -95.8%       0.20 ±210%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
     22.51 ±112%     -95.9%       0.92 ± 99%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     22.25 ±105%     -88.6%       2.53 ± 41%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.do_epoll_pwait.part
     12.34 ± 11%     -96.4%       0.44 ± 46%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.do_epoll_ctl
      3.61 ±101%     -99.3%       0.02 ±147%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.33 ± 39%     -95.5%       0.01 ± 76%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      2.72 ±123%     -99.6%       0.01 ± 34%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2.91 ± 78%     -99.3%       0.02 ± 42%  perf-sched.sch_delay.max.ms.schedule_timeout.unix_wait_for_peer.unix_stream_connect.__sys_connect
     24.69 ± 84%     -95.8%       1.03 ± 62%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.58 ± 73%     -96.0%       0.02 ± 86%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.05 ±  2%     -84.4%       0.01 ± 50%  perf-sched.total_sch_delay.average.ms
      0.44 ±  6%   +2883.9%      13.24 ± 14%  perf-sched.total_wait_and_delay.average.ms
   4187000 ±  5%     -97.2%     118266 ± 20%  perf-sched.total_wait_and_delay.count.ms
      0.39 ±  7%   +3249.7%      13.23 ± 14%  perf-sched.total_wait_time.average.ms
      2.22 ± 21%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__dentry_kill.dput.__fput.__x64_sys_close
      2.59 ± 22%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.79 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
     10.43 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      2.60 ± 42%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      1.13 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      3.54 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.__sock_release.sock_close.__fput
      0.07 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      3.56 ± 17%     -99.2%       0.03 ± 42%  perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.path_put.unix_release_sock.unix_release
      9.85 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kfree_rcu_work.process_one_work.worker_thread.kthread
      2.23 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.sock_alloc_inode.alloc_inode.sock_alloc
      2.17 ± 21%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.sock_alloc_file
      2.70 ± 21%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.ep_insert.do_epoll_ctl.__x64_sys_epoll_ctl
      3.15 ± 19%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.ep_ptable_queue_proc.unix_poll.sock_poll
      1.80 ± 19%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
      5.06 ± 56%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kvfree_rcu_drain_ready.kfree_rcu_monitor.process_one_work.worker_thread
      2.67 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.do_epoll_ctl.__x64_sys_epoll_ctl.do_syscall_64
      3.94 ± 31%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.eventpoll_release_file.__fput.__x64_sys_close
      2.21 ± 67%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      2.15 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     98.19 ± 31%    +133.2%     228.98 ±  7%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    102.21 ± 58%     -56.1%      44.92 ± 12%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      0.12 ±  7%  +16208.6%      19.68 ± 23%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.12 ±  6%   +1262.0%       1.61 ± 22%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.do_epoll_pwait.part
      1.15 ± 22%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      3.48 ±  2%     +21.3%       4.22 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     79.21 ± 17%     +23.8%      98.06        perf-sched.wait_and_delay.avg.ms.schedule_timeout.unix_wait_for_peer.unix_stream_connect.__sys_connect
     19.77 ± 21%    +920.4%     201.76 ± 45%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     89.17 ± 53%     -99.3%       0.58 ±130%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
      1227 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__dentry_kill.dput.__fput.__x64_sys_close
    587.00 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
    106.58 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
    367.67 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     20.75 ± 24%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
     10.50 ± 48%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      1159 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.down_write.__sock_release.sock_close.__fput
    146001 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      5554 ±  9%     -82.9%     948.08 ± 31%  perf-sched.wait_and_delay.count.__cond_resched.dput.path_put.unix_release_sock.unix_release
    517.58 ± 37%     -99.8%       1.08 ± 88%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
    630.58 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kfree_rcu_work.process_one_work.worker_thread.kthread
    358.25 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_lru_noprof.sock_alloc_inode.alloc_inode.sock_alloc
    736.92 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.sock_alloc_file
    668.08 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.ep_insert.do_epoll_ctl.__x64_sys_epoll_ctl
    528.67 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.ep_ptable_queue_proc.unix_poll.sock_poll
      1350 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
     36.92 ± 27%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kvfree_rcu_drain_ready.kfree_rcu_monitor.process_one_work.worker_thread
    821.33 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.do_epoll_ctl.__x64_sys_epoll_ctl.do_syscall_64
     72.67 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.eventpoll_release_file.__fput.__x64_sys_close
     58.67 ± 27%     -99.7%       0.17 ±223%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
    303.75 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
    118.83 ± 28%     -99.7%       0.33 ±187%  perf-sched.wait_and_delay.count.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
    148.67 ± 45%     -99.8%       0.25 ±173%  perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
    367.75 ± 74%    -100.0%       0.17 ±223%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
   1049759 ±  4%    -100.0%      67.08 ±331%  perf-sched.wait_and_delay.count.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     93.92 ± 19%    +795.8%     841.33 ±  2%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1522 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    754.25 ± 25%     -59.8%     303.58 ±  7%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
    146.25 ± 41%    +148.3%     363.17 ± 10%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
    878820 ±  6%     -98.9%       9322 ± 22%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
   1161349 ±  5%     -93.3%      77876 ± 21%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.ep_poll.do_epoll_wait.do_epoll_pwait.part
     77.50 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      1434 ±  2%     -17.5%       1183 ±  3%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    109.25 ± 18%    +662.5%     833.08 ±  2%  perf-sched.wait_and_delay.count.schedule_timeout.unix_wait_for_peer.unix_stream_connect.__sys_connect
     27163 ± 37%     -91.0%       2448 ± 62%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    838738 ±  9%     -99.9%       1097 ± 46%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     29065 ±  3%     -30.1%      20320 ± 16%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     30.52 ± 32%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__dentry_kill.dput.__fput.__x64_sys_close
     27.48 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     28.30 ± 82%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
      1002          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     15.38 ± 39%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      2.94 ± 39%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
     28.70 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.__sock_release.sock_close.__fput
     55.40 ±114%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
     32.98 ± 12%     -96.8%       1.05 ± 45%  perf-sched.wait_and_delay.max.ms.__cond_resched.dput.path_put.unix_release_sock.unix_release
    635.38 ± 68%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kfree_rcu_work.process_one_work.worker_thread.kthread
     23.76 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.sock_alloc_inode.alloc_inode.sock_alloc
     28.32 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.sock_alloc_file
     27.57 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.ep_insert.do_epoll_ctl.__x64_sys_epoll_ctl
     27.30 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.ep_ptable_queue_proc.unix_poll.sock_poll
     27.89 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
     46.49 ± 62%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kvfree_rcu_drain_ready.kfree_rcu_monitor.process_one_work.worker_thread
     27.07 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.do_epoll_ctl.__x64_sys_epoll_ctl.do_syscall_64
     21.24 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.eventpoll_release_file.__fput.__x64_sys_close
    278.04 ±146%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
     55.47 ± 39%     -99.2%       0.45 ±331%  perf-sched.wait_and_delay.max.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    197.28 ±183%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      9.23 ± 97%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      1868 ± 37%     +98.4%       3707 ± 14%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.28 ± 57%     -98.8%       0.02 ±133%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.allocate_slab.___slab_alloc
      1.20 ± 19%     -91.9%       0.10 ± 52%  perf-sched.wait_time.avg.ms.__cond_resched.__dentry_kill.dput.__fput.__x64_sys_close
      0.19 ± 35%     -97.5%       0.00 ± 47%  perf-sched.wait_time.avg.ms.__cond_resched.__dentry_kill.dput.__fput.task_work_run
      0.16 ±101%     -96.8%       0.01 ±196%  perf-sched.wait_time.avg.ms.__cond_resched.__fput.task_work_run.syscall_exit_to_user_mode.do_syscall_64
      1.08 ± 28%     -93.2%       0.07 ±120%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
      0.18 ± 45%     -98.5%       0.00 ±106%  perf-sched.wait_time.avg.ms.__cond_resched.__mutex_lock.constprop.0.do_epoll_ctl
      1.37 ± 40%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      0.12 ±135%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      1.93 ± 14%     -98.4%       0.03 ± 56%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__sock_release.sock_close.__fput
      1.09 ±100%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      0.16 ±183%     -98.1%       0.00 ± 85%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.task_work_run.syscall_exit_to_user_mode
      1.96 ± 14%     -99.0%       0.02 ± 38%  perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.unix_release_sock.unix_release
      9.80 ± 20%     -94.2%       0.57 ±110%  perf-sched.wait_time.avg.ms.__cond_resched.kfree_rcu_work.process_one_work.worker_thread.kthread
      0.31 ± 19%     -49.6%       0.16 ± 32%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc_pseudo.alloc_file_pseudo
      1.22 ± 23%     -94.6%       0.07 ± 64%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.sock_alloc_inode.alloc_inode.sock_alloc
      1.19 ± 19%     -94.2%       0.07 ± 40%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.sock_alloc_file
      1.50 ± 18%     -99.2%       0.01 ± 36%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.ep_insert.do_epoll_ctl.__x64_sys_epoll_ctl
      0.39 ± 58%     -98.5%       0.01 ± 73%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.ep_ptable_queue_proc.__ep_eventpoll_poll.isra
      1.71 ± 16%     -99.4%       0.01 ± 44%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.ep_ptable_queue_proc.unix_poll.sock_poll
      1.00 ± 16%     -92.7%       0.07 ± 49%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
      4.97 ± 57%     -95.6%       0.22 ±174%  perf-sched.wait_time.avg.ms.__cond_resched.kvfree_rcu_drain_ready.kfree_rcu_monitor.process_one_work.worker_thread
      0.20 ± 51%     -98.7%       0.00 ±112%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.__ep_eventpoll_poll.isra.0
      1.47 ± 21%     -99.2%       0.01 ± 36%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.do_epoll_ctl.__x64_sys_epoll_ctl.do_syscall_64
      0.23 ± 40%     -97.8%       0.01 ± 60%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.ep_insert.do_epoll_ctl.__x64_sys_epoll_ctl
      0.18 ± 16%     -96.3%       0.01 ± 38%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.ep_loop_check_proc.do_epoll_ctl.__x64_sys_epoll_ctl
      0.19 ± 28%     -94.4%       0.01 ± 45%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.ep_send_events.ep_poll.do_epoll_wait
      2.09 ± 29%     -99.8%       0.00 ± 58%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.eventpoll_release_file.__fput.__x64_sys_close
      0.03 ± 78%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      2.18 ± 69%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.54 ±141%     -98.7%       0.01 ± 50%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.12 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.39 ± 28%     -97.1%       0.01 ±142%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.08 ± 25%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      1.31 ±177%     -96.3%       0.05 ±132%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     98.14 ± 31%    +133.3%     228.98 ±  7%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    101.95 ± 58%     -55.9%      44.92 ± 12%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      0.09 ±  8%  +21799.8%      19.67 ± 23%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.08 ±  6%   +1892.9%       1.60 ± 22%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.do_epoll_pwait.part
      0.23 ±  7%     -78.1%       0.05 ± 39%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.do_epoll_ctl
      0.98 ± 18%     -50.8%       0.48 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      3.47 ±  2%     +21.6%       4.22 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     79.12 ± 17%     +23.9%      98.05        perf-sched.wait_time.avg.ms.schedule_timeout.unix_wait_for_peer.unix_stream_connect.__sys_connect
     19.75 ± 21%    +921.7%     201.74 ± 45%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.28 ±327%     -99.9%       0.00 ± 73%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      5.17 ± 33%     -92.6%       0.38 ± 39%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.alloc_skb_with_frags
      7.41 ± 38%     -99.3%       0.05 ±164%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.allocate_slab.___slab_alloc
     18.93 ± 19%     -96.8%       0.60 ±153%  perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.__fput.__x64_sys_close
      3.79 ± 67%     -99.8%       0.01 ± 52%  perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.__fput.task_work_run
      0.67 ± 83%     -97.4%       0.02 ±269%  perf-sched.wait_time.max.ms.__cond_resched.__fput.task_work_run.syscall_exit_to_user_mode.do_syscall_64
     21.06 ±119%     -99.2%       0.16 ±112%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
      3.82 ± 22%     -91.5%       0.33 ± 41%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      3.06 ± 52%     -99.8%       0.00 ±147%  perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.do_epoll_ctl
      7.74 ± 38%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      2.64 ± 44%     -95.1%       0.13 ±331%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.55 ±151%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
     20.62 ± 18%     -98.4%       0.33 ± 44%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__sock_release.sock_close.__fput
      2.66 ± 85%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
     42.10 ±151%     -98.8%       0.50 ± 71%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.79 ±188%     -99.6%       0.00 ± 88%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.task_work_run.syscall_exit_to_user_mode
      4.78 ± 30%     -91.9%       0.39 ± 32%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.unix_find_other.unix_stream_connect
     22.71 ± 15%     -97.1%       0.66 ± 52%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.unix_release_sock.unix_release
    635.37 ± 68%     -99.9%       0.65 ±130%  perf-sched.wait_time.max.ms.__cond_resched.kfree_rcu_work.process_one_work.worker_thread.kthread
     19.35 ± 40%     -97.9%       0.40 ± 27%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc_pseudo.alloc_file_pseudo
     14.50 ± 18%     -97.2%       0.41 ± 89%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.sock_alloc_inode.alloc_inode.sock_alloc
      4.24 ± 30%     -91.4%       0.36 ± 28%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     13.15 ±199%     -97.1%       0.38 ± 44%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.sock_wmalloc.unix_stream_connect
      3.04 ± 32%     -91.6%       0.26 ± 55%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.sock_wmalloc
     17.87 ± 20%     -98.1%       0.34 ± 36%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.sock_alloc_file
      3.71 ±110%     -92.4%       0.28 ± 55%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.do_timer_create.__x64_sys_timer_create.do_syscall_64
     18.46 ± 21%     -98.2%       0.32 ± 40%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.ep_insert.do_epoll_ctl.__x64_sys_epoll_ctl
      5.51 ± 63%     -99.8%       0.01 ± 63%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.ep_ptable_queue_proc.__ep_eventpoll_poll.isra
     15.79 ± 17%     -98.5%       0.24 ± 63%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.ep_ptable_queue_proc.unix_poll.sock_poll
      3.76 ± 22%     -90.9%       0.34 ± 21%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.getname_kernel.kern_path.unix_find_other
     18.23 ± 23%     -97.9%       0.38 ± 27%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
     12.52 ±186%     -96.7%       0.41 ± 29%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.sk_prot_alloc.sk_alloc.unix_create1
     46.47 ± 62%     -99.5%       0.22 ±174%  perf-sched.wait_time.max.ms.__cond_resched.kvfree_rcu_drain_ready.kfree_rcu_monitor.process_one_work.worker_thread
      2.18 ± 93%     -99.8%       0.00 ±135%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.__ep_eventpoll_poll.isra.0
     20.73 ± 20%     -98.3%       0.35 ± 40%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.do_epoll_ctl.__x64_sys_epoll_ctl.do_syscall_64
      3.11 ± 46%     -99.7%       0.01 ±137%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.ep_insert.do_epoll_ctl.__x64_sys_epoll_ctl
      7.57 ± 31%     -99.3%       0.05 ±171%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.ep_loop_check_proc.do_epoll_ctl.__x64_sys_epoll_ctl
      6.56 ± 38%     -96.4%       0.24 ± 58%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.ep_send_events.ep_poll.do_epoll_wait
     11.80 ± 31%    -100.0%       0.00 ± 63%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.eventpoll_release_file.__fput.__x64_sys_close
      0.12 ±131%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
    278.03 ±146%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
     28.52 ±234%     -99.9%       0.02 ± 99%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.08 ± 49%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     47.81 ± 39%     -98.7%       0.63 ± 99%  perf-sched.wait_time.max.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    168.89 ±220%     -99.5%       0.80 ±  6%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.08 ± 29%     -99.9%       0.01 ±135%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      2.02 ± 54%    -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
    196.78 ±183%     -99.9%       0.13 ±154%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     16.11 ± 25%     -97.1%       0.46 ± 37%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.do_epoll_ctl
      6.64 ± 75%     -76.5%       1.56 ±  4%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      1868 ± 37%     +98.4%       3707 ± 14%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     83.79 ±329%    -100.0%       0.02 ± 96%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open


***************************************************************************************************
lkp-srf-2sp1: 256 threads 2 sockets GENUINE INTEL(R) XEON(R) (Sierra Forest) with 128G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-srf-2sp1/epoll/stress-ng/60s

commit: 
  feb864ee99 ("posix-timers: Make signal_struct:: Next_posix_timer_id an atomic_t")
  1535cb8028 ("posix-timers: Improve hash table performance")

feb864ee99a2d8a2 1535cb80286e6fbc834f075039f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     43148           +13.5%      48960 ±  3%  uptime.idle
 1.055e+09 ± 51%    +533.3%  6.682e+09 ± 24%  cpuidle..time
    538108 ± 15%   +1136.2%    6652185 ± 12%  cpuidle..usage
  19057763 ±  2%    +184.7%   54249799 ± 30%  numa-numastat.node1.local_node
  19247181 ±  2%    +182.8%   54435088 ± 30%  numa-numastat.node1.numa_hit
      2528 ±  8%    +139.1%       6046 ± 19%  perf-c2c.DRAM.local
     14118 ±  2%     -59.4%       5735 ± 40%  perf-c2c.DRAM.remote
     19925 ±  2%     +42.1%      28317 ± 26%  perf-c2c.HITM.local
     12344 ±  3%     -72.4%       3407 ± 38%  perf-c2c.HITM.remote
      8.32 ± 32%    +424.2%      43.62 ± 22%  vmstat.cpu.id
     90.61 ±  2%     -39.3%      55.04 ± 17%  vmstat.cpu.sy
    311.79 ±  4%     -46.1%     168.04 ± 16%  vmstat.procs.r
    890824 ±  2%     -87.0%     115560 ± 13%  vmstat.system.cs
    678218 ±  2%     -31.3%     466212 ± 11%  vmstat.system.in
      5.97 ± 56%     +35.8       41.74 ± 24%  mpstat.cpu.all.idle%
      0.86 ±  3%      -0.3        0.51 ± 11%  mpstat.cpu.all.irq%
      0.10 ±  3%      +2.0        2.11 ± 13%  mpstat.cpu.all.soft%
     92.01 ±  3%     -37.7       54.27 ± 18%  mpstat.cpu.all.sys%
      1.06 ±  3%      +0.3        1.37 ±  8%  mpstat.cpu.all.usr%
     27.83 ± 38%     -84.4%       4.33 ± 31%  mpstat.max_utilization.seconds
  33851562          +125.5%   76322657 ±  6%  stress-ng.epoll.ops
    563917          +124.9%    1268302 ±  6%  stress-ng.epoll.ops_per_sec
  28793963           -92.5%    2170167 ± 12%  stress-ng.time.involuntary_context_switches
     99879            +3.8%     103635        stress-ng.time.minor_page_faults
     24802           -43.4%      14035 ± 18%  stress-ng.time.percent_of_cpu_this_job_got
     14926           -43.8%       8382 ± 18%  stress-ng.time.system_time
    115.24           +47.3%     169.80 ±  7%  stress-ng.time.user_time
  28334081           -91.0%    2554796 ± 19%  stress-ng.time.voluntary_context_switches
  15224825 ±  2%      -9.9%   13712660 ±  2%  numa-vmstat.node0.nr_free_pages
     24052 ±  5%     +11.2%      26754 ±  7%  numa-vmstat.node0.nr_kernel_stack
     26695 ± 30%     +94.3%      51869 ± 25%  numa-vmstat.node0.nr_slab_reclaimable
     80931 ±  2%    +629.1%     590074 ±  3%  numa-vmstat.node0.nr_slab_unreclaimable
    884632 ± 28%     -67.7%     285909 ± 29%  numa-vmstat.node1.nr_active_anon
    247805 ± 34%     -83.9%      39842 ± 86%  numa-vmstat.node1.nr_mapped
     25014 ± 32%    +130.7%      57701 ± 11%  numa-vmstat.node1.nr_slab_reclaimable
     75561 ±  2%    +240.7%     257418 ±  9%  numa-vmstat.node1.nr_slab_unreclaimable
    884628 ± 28%     -67.7%     285908 ± 29%  numa-vmstat.node1.nr_zone_active_anon
  19254705 ±  2%    +182.7%   54434306 ± 30%  numa-vmstat.node1.numa_hit
  19065286 ±  2%    +184.5%   54249017 ± 30%  numa-vmstat.node1.numa_local
   4955679 ±  4%     -30.9%    3424278 ±  5%  meminfo.Active
   4955679 ±  4%     -30.9%    3424278 ±  5%  meminfo.Active(anon)
   6755066 ±  3%     -22.9%    5210854 ±  3%  meminfo.Cached
   8262544           -17.7%    6803834 ±  2%  meminfo.Committed_AS
    207031          +110.4%     435508 ± 11%  meminfo.KReclaimable
   1206797 ±  7%     -58.6%     499961 ± 15%  meminfo.Mapped
  11812020           +34.0%   15824159        meminfo.Memused
    207031          +110.4%     435508 ± 11%  meminfo.SReclaimable
    625945          +440.8%    3385294 ±  4%  meminfo.SUnreclaim
   3240345 ±  7%     -47.7%    1696129 ± 11%  meminfo.Shmem
    832977          +358.7%    3820803 ±  2%  meminfo.Slab
  12134020 ±  2%     +40.3%   17018684 ±  2%  meminfo.max_used_kB
    107034 ± 30%     +94.2%     207898 ± 26%  numa-meminfo.node0.KReclaimable
     24086 ±  5%     +10.9%      26717 ±  7%  numa-meminfo.node0.KernelStack
  60890354 ±  2%      -9.9%   54851181 ±  2%  numa-meminfo.node0.MemFree
   4808400 ± 28%    +125.6%   10847573 ± 14%  numa-meminfo.node0.MemUsed
    107034 ± 30%     +94.2%     207898 ± 26%  numa-meminfo.node0.SReclaimable
    324929          +626.1%    2359208 ±  3%  numa-meminfo.node0.SUnreclaim
    431963 ±  8%    +494.3%    2567107 ±  3%  numa-meminfo.node0.Slab
   3538358 ± 28%     -67.7%    1144230 ± 29%  numa-meminfo.node1.Active
   3538358 ± 28%     -67.7%    1144230 ± 29%  numa-meminfo.node1.Active(anon)
     99985 ± 32%    +132.3%     232273 ± 11%  numa-meminfo.node1.KReclaimable
    983848 ± 34%     -83.8%     159767 ± 86%  numa-meminfo.node1.Mapped
     99985 ± 32%    +132.3%     232273 ± 11%  numa-meminfo.node1.SReclaimable
    301620          +240.5%    1027163 ±  9%  numa-meminfo.node1.SUnreclaim
    401606 ±  8%    +213.6%    1259437 ±  8%  numa-meminfo.node1.Slab
   1237560 ±  4%     -30.8%     856038 ±  5%  proc-vmstat.nr_active_anon
   2976831            -3.4%    2876549        proc-vmstat.nr_dirty_background_threshold
   5960941            -3.4%    5760131        proc-vmstat.nr_dirty_threshold
   1688680 ±  3%     -22.8%    1303065 ±  3%  proc-vmstat.nr_file_pages
  29966049            -3.4%   28961759        proc-vmstat.nr_free_pages
     49329            +1.6%      50128        proc-vmstat.nr_kernel_stack
    304482 ±  7%     -58.6%     125967 ± 15%  proc-vmstat.nr_mapped
    809999 ±  7%     -47.6%     424383 ± 11%  proc-vmstat.nr_shmem
     51715          +109.8%     108516 ± 12%  proc-vmstat.nr_slab_reclaimable
    156635          +440.7%     846916 ±  4%  proc-vmstat.nr_slab_unreclaimable
   1237560 ±  4%     -30.8%     856038 ±  5%  proc-vmstat.nr_zone_active_anon
  37826648          +125.5%   85303573 ±  6%  proc-vmstat.numa_hit
  37562632          +126.4%   85036326 ±  6%  proc-vmstat.numa_local
     97014 ±  8%     +26.4%     122652 ± 10%  proc-vmstat.numa_pages_migrated
  45240990          +150.6%  1.134e+08 ±  5%  proc-vmstat.pgalloc_normal
    798177            -5.8%     752280 ±  2%  proc-vmstat.pgfault
  43937747          +156.1%  1.125e+08 ±  5%  proc-vmstat.pgfree
     97014 ±  8%     +26.4%     122652 ± 10%  proc-vmstat.pgmigrate_success
      0.69 ±  7%    +313.5%       2.85 ± 11%  perf-stat.i.MPKI
 1.549e+10 ±  3%     -22.1%  1.207e+10 ±  5%  perf-stat.i.branch-instructions
  73994092 ±  2%     +22.3%   90471635 ±  3%  perf-stat.i.branch-misses
     35.70            +6.8       42.45 ± 10%  perf-stat.i.cache-miss-rate%
  47382742          +284.6%  1.822e+08 ± 11%  perf-stat.i.cache-misses
 1.291e+08 ±  3%    +220.0%  4.132e+08 ±  5%  perf-stat.i.cache-references
    934844 ±  3%     -87.1%     120611 ± 13%  perf-stat.i.context-switches
      8.80 ±  2%     -23.7%       6.71 ± 17%  perf-stat.i.cpi
 6.394e+11 ±  3%     -34.8%  4.166e+11 ± 16%  perf-stat.i.cpu-cycles
     13976 ±  5%     -82.1%       2495 ±  7%  perf-stat.i.cycles-between-cache-misses
 7.202e+10 ±  3%     -13.1%   6.26e+10 ±  5%  perf-stat.i.instructions
      0.12 ±  6%     +35.7%       0.16 ± 20%  perf-stat.i.ipc
      5.21 ±  3%     -88.7%       0.59 ± 93%  perf-stat.i.metric.K/sec
    402199 ±  3%     -39.9%     241847 ± 33%  perf-stat.i.page-faults
      0.66 ±  2%    +345.5%       2.93 ± 12%  perf-stat.overall.MPKI
      0.48            +0.3        0.75 ±  3%  perf-stat.overall.branch-miss-rate%
     36.72            +7.6       44.28 ± 10%  perf-stat.overall.cache-miss-rate%
      8.88           -24.5%       6.70 ± 18%  perf-stat.overall.cpi
     13516 ±  2%     -83.2%       2269 ±  7%  perf-stat.overall.cycles-between-cache-misses
      0.11           +37.4%       0.15 ± 18%  perf-stat.overall.ipc
 1.526e+10 ±  3%     -22.2%  1.188e+10 ±  5%  perf-stat.ps.branch-instructions
  72600465 ±  2%     +22.6%   89019409 ±  3%  perf-stat.ps.branch-misses
  46600547          +286.1%  1.799e+08 ± 11%  perf-stat.ps.cache-misses
 1.269e+08 ±  2%    +220.4%  4.067e+08 ±  5%  perf-stat.ps.cache-references
    920856 ±  2%     -87.1%     118969 ± 13%  perf-stat.ps.context-switches
 6.299e+11 ±  3%     -34.8%  4.106e+11 ± 16%  perf-stat.ps.cpu-cycles
 7.094e+10 ±  3%     -13.2%  6.161e+10 ±  5%  perf-stat.ps.instructions
    396054 ±  3%     -40.1%     237181 ± 33%  perf-stat.ps.page-faults
 4.463e+12           -14.9%  3.798e+12 ±  5%  perf-stat.total.instructions
   7856122           -72.6%    2151482 ± 76%  sched_debug.cfs_rq:/.avg_vruntime.avg
   8590951           -64.0%    3092345 ± 72%  sched_debug.cfs_rq:/.avg_vruntime.max
   7042407 ±  7%     -82.6%    1227046 ± 84%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.67 ±  6%     -73.6%       0.18 ± 55%  sched_debug.cfs_rq:/.h_nr_queued.avg
      2.08 ±  8%     -44.0%       1.17 ± 20%  sched_debug.cfs_rq:/.h_nr_queued.max
      0.65 ±  5%     -72.5%       0.18 ± 55%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      2.08 ±  8%     -44.0%       1.17 ± 20%  sched_debug.cfs_rq:/.h_nr_runnable.max
     75.67 ± 22%     +72.8%     130.79 ± 30%  sched_debug.cfs_rq:/.load_avg.stddev
   7856124           -72.6%    2151482 ± 76%  sched_debug.cfs_rq:/.min_vruntime.avg
   8590951           -64.0%    3092345 ± 72%  sched_debug.cfs_rq:/.min_vruntime.max
   7042407 ±  7%     -82.6%    1227046 ± 84%  sched_debug.cfs_rq:/.min_vruntime.min
      0.52           -66.0%       0.18 ± 54%  sched_debug.cfs_rq:/.nr_queued.avg
      0.13 ± 19%    +131.6%       0.29 ± 21%  sched_debug.cfs_rq:/.nr_queued.stddev
    712.87 ±  3%     -69.0%     221.26 ± 41%  sched_debug.cfs_rq:/.runnable_avg.avg
      1791 ±  5%     -33.4%       1193 ± 19%  sched_debug.cfs_rq:/.runnable_avg.max
    291.83 ± 72%    -100.0%       0.00        sched_debug.cfs_rq:/.runnable_avg.min
    562.59           -61.2%     218.45 ± 41%  sched_debug.cfs_rq:/.util_avg.avg
    204.08 ± 85%    -100.0%       0.00        sched_debug.cfs_rq:/.util_avg.min
    124.33 ±  9%    +130.6%     286.67 ± 26%  sched_debug.cfs_rq:/.util_avg.stddev
    667089 ±  2%     +26.3%     842681 ±  7%  sched_debug.cpu.avg_idle.avg
     37749 ±  6%     -73.7%       9926 ± 48%  sched_debug.cpu.avg_idle.min
     31.26 ± 20%     -35.5%      20.15 ± 20%  sched_debug.cpu.clock.stddev
      3365 ±  2%     -68.3%       1067 ± 60%  sched_debug.cpu.curr->pid.avg
    588.77 ± 10%    +168.8%       1582 ± 35%  sched_debug.cpu.curr->pid.stddev
      0.67 ±  6%     -74.0%       0.17 ± 57%  sched_debug.cpu.nr_running.avg
      2.08 ±  8%     -44.0%       1.17 ± 20%  sched_debug.cpu.nr_running.max
    112229           -90.6%      10588 ± 66%  sched_debug.cpu.nr_switches.avg
    131899 ±  2%     -74.8%      33294 ± 34%  sched_debug.cpu.nr_switches.max
     86555 ±  8%     -97.4%       2240 ± 83%  sched_debug.cpu.nr_switches.min
      0.27 ± 21%     -97.1%       0.01 ±101%  sched_debug.cpu.nr_uninterruptible.avg
      0.20 ± 12%    +215.1%       0.64 ± 54%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.alloc_skb_with_frags
      1.05 ± 75%     -94.5%       0.06 ±168%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
      0.16 ±111%    +555.0%       1.03 ± 55%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
      0.19 ±122%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.04 ± 60%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.01         +4716.7%       0.53 ± 71%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.16 ± 10%    +209.1%       0.48 ± 51%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.path_put.unix_find_other.unix_stream_connect
      0.04 ± 22%   +1735.0%       0.79 ±103%  perf-sched.sch_delay.avg.ms.__cond_resched.kfree_rcu_work.process_one_work.worker_thread.kthread
      0.11 ± 12%    +432.0%       0.58 ± 53%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc_pseudo.alloc_file_pseudo
      0.26 ±  4%    +121.3%       0.56 ± 47%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      0.16 ±  4%    +267.9%       0.58 ± 46%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.sock_wmalloc.unix_stream_connect
      0.16 ± 28%    +377.0%       0.75 ± 85%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.sock_wmalloc
      0.10 ± 46%    +492.9%       0.61 ± 56%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.do_timer_create.__x64_sys_timer_create.do_syscall_64
      0.15 ± 10%    +426.6%       0.80 ± 71%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.getname_kernel.kern_path.unix_find_other
      0.14 ±  8%    +267.4%       0.53 ± 46%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.sk_prot_alloc.sk_alloc.unix_create1
      0.22 ± 17%     -81.1%       0.04 ±105%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.21 ± 22%     -83.9%       0.03 ± 57%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.05 ±  7%    +153.4%       0.13 ± 44%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.21 ± 17%     -85.4%       0.03 ± 96%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.09 ± 16%     -42.9%       0.05 ± 41%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.08 ± 10%     -53.7%       0.04 ± 48%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.05 ±  3%    +367.7%       0.22 ± 27%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.19 ± 30%     -82.0%       0.03 ± 50%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      1.18 ± 42%    +632.2%       8.64 ± 38%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.alloc_skb_with_frags
      4.01 ± 60%     -98.5%       0.06 ±155%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
      2.71 ± 56%    +302.4%      10.92 ± 34%  perf-sched.sch_delay.max.ms.__cond_resched.__dentry_kill.dput.__fput.__x64_sys_close
      0.79 ±114%   +2021.6%      16.77 ± 22%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
      1.46 ± 65%    +367.7%       6.82 ± 83%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      2.34 ± 31%    +170.9%       6.33 ± 32%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.62 ± 93%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.21 ± 52%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      6.68 ± 26%    +457.7%      37.23 ± 37%  perf-sched.sch_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      1.59 ± 31%    +408.3%       8.07 ± 40%  perf-sched.sch_delay.max.ms.__cond_resched.dput.path_put.unix_find_other.unix_stream_connect
      0.17 ± 29%  +62821.2%     106.44 ±196%  perf-sched.sch_delay.max.ms.__cond_resched.kfree_rcu_work.process_one_work.worker_thread.kthread
      2.14 ± 52%    +577.6%      14.52 ± 29%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc_pseudo.alloc_file_pseudo
      1.38 ±111%    +575.2%       9.32 ± 40%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.sock_alloc_inode.alloc_inode.sock_alloc
      1.37 ± 35%   +1092.7%      16.35 ± 28%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      1.49 ± 19%    +888.9%      14.77 ± 21%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.sock_wmalloc.unix_stream_connect
      1.52 ± 45%    +481.7%       8.83 ± 58%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.sock_wmalloc
      0.37 ± 48%   +1749.5%       6.77 ± 37%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.do_timer_create.__x64_sys_timer_create.do_syscall_64
      1.89 ± 67%    +501.1%      11.35 ± 49%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.getname_kernel.kern_path.unix_find_other
      3.28 ± 63%    +414.6%      16.87 ± 28%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
      2.47 ± 47%    +658.0%      18.73 ± 26%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.sk_prot_alloc.sk_alloc.unix_create1
      2.54 ± 56%    +385.8%      12.35 ± 44%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.do_epoll_ctl.__x64_sys_epoll_ctl.do_syscall_64
      2.81 ± 78%     -87.4%       0.35 ±210%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
      4.53 ± 45%     -98.0%       0.09 ± 72%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.35 ± 30%   +2421.7%       8.88 ± 56%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.74 ± 56%     -88.4%       0.20 ± 99%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
     10.65 ± 11%    +156.4%      27.30 ± 48%  perf-sched.sch_delay.max.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.71 ± 43%    +444.3%       9.29 ± 71%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      2.27 ± 22%     -73.1%       0.61 ± 88%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.01 ±103%     -83.0%       0.17 ±118%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      6.60 ± 76%     -70.6%       1.94 ±137%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      6.12 ± 22%    +133.1%      14.27 ± 24%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.16 ± 56%     -92.7%       0.16 ± 68%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     18.92 ± 37%   +1957.7%     389.39 ± 74%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.06 ±  5%    +228.9%       0.20 ± 55%  perf-sched.total_sch_delay.average.ms
      1.09         +1306.4%      15.38 ± 22%  perf-sched.total_wait_and_delay.average.ms
   4862008           -91.5%     414956 ± 18%  perf-sched.total_wait_and_delay.count.ms
      1.03         +1370.8%      15.18 ± 22%  perf-sched.total_wait_time.average.ms
      2.88          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      7.65 ± 53%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.__sock_release.sock_close.__fput
      0.03 ±  9%   +5978.6%       1.56 ± 59%  perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
     11.25 ± 52%     -79.8%       2.27 ± 73%  perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.path_put.unix_release_sock.unix_release
      4.87 ± 61%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.sock_alloc_inode.alloc_inode.sock_alloc
      4.50 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.sock_alloc_file
      7.72 ± 30%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.ep_insert.do_epoll_ctl.__x64_sys_epoll_ctl
     10.49 ± 27%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.ep_ptable_queue_proc.unix_poll.sock_poll
      3.76 ± 41%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
      5.08 ± 21%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.do_epoll_ctl.__x64_sys_epoll_ctl.do_syscall_64
     13.88 ± 21%    +332.9%      60.10 ± 60%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.18 ± 74%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     12.40 ±118%    +166.8%      33.07 ±  3%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      4.34 ± 70%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     93.41 ± 18%    +199.5%     279.81 ± 20%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.53         +1911.6%      10.61 ± 47%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.44          +524.5%       2.77 ± 22%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.do_epoll_pwait.part
      1.66 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      4.06 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.15 ±  2%    +354.0%       0.68 ± 22%  perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     62.27           +16.1%      72.33 ±  2%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1536          -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      5.83 ± 60%     -91.4%       0.50 ±223%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
     39.67 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.down_write.__sock_release.sock_close.__fput
    497089 ±  2%     -97.4%      12678 ± 28%  perf-sched.wait_and_delay.count.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
    317.33 ± 14%   +1910.9%       6381 ± 20%  perf-sched.wait_and_delay.count.__cond_resched.dput.path_put.unix_release_sock.unix_release
     42.33 ± 45%    +807.5%     384.17 ± 30%  perf-sched.wait_and_delay.count.__cond_resched.kfree_rcu_work.process_one_work.worker_thread.kthread
     22.00 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_lru_noprof.sock_alloc_inode.alloc_inode.sock_alloc
     53.00 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.sock_alloc_file
     75.17 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.ep_insert.do_epoll_ctl.__x64_sys_epoll_ctl
     36.00 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.ep_ptable_queue_proc.unix_poll.sock_poll
     59.50 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
     77.00 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.do_epoll_ctl.__x64_sys_epoll_ctl.do_syscall_64
     53.33 ± 47%     -93.4%       3.50 ±223%  perf-sched.wait_and_delay.count.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
     41.67 ± 36%    +999.6%     458.17 ± 56%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    229578 ±  5%     -75.4%      56521 ± 56%  perf-sched.wait_and_delay.count.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.67 ± 28%    -100.0%       0.00        perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      6.00        +40144.4%       2414 ± 15%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    244.00 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    739.83 ± 19%     -66.1%     250.67 ± 30%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
    930842           -94.1%      55225 ± 32%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
   1423312           -89.3%     152928 ± 23%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.ep_poll.do_epoll_wait.do_epoll_pwait.part
     28105 ±  8%     -47.9%      14637 ± 41%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.do_epoll_ctl
     79.83 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      1253 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
   1682676           -98.2%      30021 ± 57%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     17624           +63.2%      28758 ± 14%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1001          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     63.56 ± 48%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.__sock_release.sock_close.__fput
     47.03 ± 79%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.sock_alloc_inode.alloc_inode.sock_alloc
     40.36 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.sock_alloc_file
     61.87 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.ep_insert.do_epoll_ctl.__x64_sys_epoll_ctl
     60.75 ± 52%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.ep_ptable_queue_proc.unix_poll.sock_poll
     52.23 ± 35%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
     53.65 ± 22%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.do_epoll_ctl.__x64_sys_epoll_ctl.do_syscall_64
     76.72 ± 30%    +574.4%     517.47 ± 74%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     21.30 ± 11%    +518.9%     131.79 ± 52%  perf-sched.wait_and_delay.max.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.33 ± 40%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    229.85 ±160%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     89.98 ± 25%     -53.0%      42.33 ± 24%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.do_epoll_ctl
      6.63 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      8.99 ± 32%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2212 ± 23%     +45.0%       3208 ± 17%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.20 ± 12%    +309.5%       0.83 ± 77%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.alloc_skb_with_frags
      1.05 ± 75%     -94.5%       0.06 ±168%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
      0.26 ± 13%    +248.4%       0.91 ± 56%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      1.03 ± 54%     -97.5%       0.03 ±158%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      7.19 ± 57%     -77.3%       1.63 ± 48%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__sock_release.sock_close.__fput
      0.03 ± 62%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.01 ± 15%   +7172.9%       1.03 ± 53%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.16 ± 10%    +353.5%       0.70 ± 39%  perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.unix_find_other.unix_stream_connect
     10.54 ± 55%     -85.2%       1.56 ± 66%  perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.unix_release_sock.unix_release
      0.26 ±  4%    +165.7%       0.68 ± 52%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      0.16 ±  4%    +349.7%       0.71 ± 56%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.sock_wmalloc.unix_stream_connect
      0.16 ± 28%    +533.4%       0.99 ± 72%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.sock_wmalloc
      4.35 ± 17%     -53.4%       2.03 ± 76%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.sock_alloc_file
      0.10 ± 46%    +727.9%       0.85 ± 67%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.do_timer_create.__x64_sys_timer_create.do_syscall_64
      7.51 ± 31%     -80.7%       1.45 ± 84%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.ep_insert.do_epoll_ctl.__x64_sys_epoll_ctl
     10.24 ± 27%     -76.5%       2.40 ± 85%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.ep_ptable_queue_proc.unix_poll.sock_poll
      0.15 ± 10%    +426.6%       0.80 ± 71%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.getname_kernel.kern_path.unix_find_other
      3.53 ± 45%     -59.3%       1.44 ± 73%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
      0.14 ±  8%    +299.4%       0.57 ± 49%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.sk_prot_alloc.sk_alloc.unix_create1
      4.89 ± 22%     -69.6%       1.49 ± 82%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.do_epoll_ctl.__x64_sys_epoll_ctl.do_syscall_64
      0.14 ± 22%     -86.3%       0.02 ±151%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
     13.79 ± 21%    +335.0%      59.97 ± 60%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      7.93 ±100%    +176.8%      21.96 ± 45%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.40 ±118%    +166.8%      33.07 ±  3%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.21 ± 71%     -96.0%       0.01 ±223%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      2.50 ±119%    +605.3%      17.65 ± 48%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.10 ± 66%  +35978.3%      37.64 ±112%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
     93.36 ± 18%    +199.7%     279.77 ± 20%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.48         +2103.7%      10.48 ± 48%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.39          +583.2%       2.65 ± 22%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.do_epoll_pwait.part
      1.15 ±  5%     -50.8%       0.57 ± 59%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.do_epoll_ctl
      3.97 ±  2%     +27.4%       5.06 ±  4%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.10 ±  2%    +348.6%       0.47 ± 20%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     62.18           +16.1%      72.22 ±  2%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.18 ± 42%   +1710.8%      21.38 ±134%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.alloc_skb_with_frags
      4.01 ± 60%     -98.5%       0.06 ±155%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
      1.46 ± 65%   +1683.9%      25.99 ±114%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      2.38 ± 51%     -98.9%       0.03 ±158%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.21 ± 52%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      1.59 ± 31%   +3311.2%      54.16 ± 84%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.unix_find_other.unix_stream_connect
     84.86 ± 27%     -52.1%      40.62 ± 36%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.unix_release_sock.unix_release
      1.37 ± 35%   +9209.7%     127.60 ± 65%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      1.49 ± 19%   +5627.3%      85.56 ± 89%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.sock_wmalloc.unix_stream_connect
      1.52 ± 45%   +1550.7%      25.05 ±135%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.sock_wmalloc
      0.37 ± 48%   +5929.2%      22.07 ±158%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.do_timer_create.__x64_sys_timer_create.do_syscall_64
     61.20 ± 21%     -55.7%      27.08 ± 70%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.ep_insert.do_epoll_ctl.__x64_sys_epoll_ctl
     60.17 ± 51%     -58.9%      24.71 ± 65%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.ep_ptable_queue_proc.unix_poll.sock_poll
      1.89 ± 67%    +501.1%      11.35 ± 49%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.getname_kernel.kern_path.unix_find_other
      2.47 ± 47%   +3700.3%      93.91 ± 63%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.sk_prot_alloc.sk_alloc.unix_create1
     52.73 ± 20%     -56.5%      22.96 ± 57%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.do_epoll_ctl.__x64_sys_epoll_ctl.do_syscall_64
     42.82 ± 27%     -70.8%      12.49 ± 55%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.ep_loop_check_proc.do_epoll_ctl.__x64_sys_epoll_ctl
      2.81 ± 78%     -87.4%       0.35 ±210%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
      0.22 ±  3%     -91.6%       0.02 ±151%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
     76.63 ± 30%    +575.0%     517.27 ± 74%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     10.65 ± 11%   +1061.1%     123.63 ± 61%  perf-sched.wait_time.max.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.51 ± 76%     -97.4%       0.01 ±223%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      1.01 ±103%     -82.8%       0.17 ±116%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
     19.43 ±110%    +417.5%     100.53        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.96 ±107%  +30626.2%     293.64 ±113%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
     84.15 ± 22%     -67.6%      27.23 ± 29%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.do_epoll_ctl
      6.62 ±  5%     +76.8%      11.70 ± 33%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2212 ± 23%     +45.0%       3208 ± 17%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


