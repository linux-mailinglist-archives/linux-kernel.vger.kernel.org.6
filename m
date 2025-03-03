Return-Path: <linux-kernel+bounces-540834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AFDA4B59F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 01:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04396188E27A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 00:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6D11DFED;
	Mon,  3 Mar 2025 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7ux2MwJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5579B6F073
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740961778; cv=fail; b=bVc2WBKjgAy4PIpXEfe50plezrgFYuisztMOrFH1Ts/mgDMrutF1I/gkqpYHMUFYWZ3TF5Mulaz91xIwu5vS+eDh64SUum4czaTDCuK6mKKcIGC4DKZm/X274nz1E8d/ZjdDdVIunB3f8mFuWBo4AygjPol6PgQ9A8z9aiQEBTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740961778; c=relaxed/simple;
	bh=Befgc/T/RiI+gcjQxMdISn98GTq2ZuU6uPlB+l54lxw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=W11X934vSURk2ZhC3Sosy6NBrjuFz7R3oiu09PCMaY0wR6L6DzHuVBS0SoSZ16FI6BBt9cnaesIPqmhETFTRHsxoeGQBBdwAt7TM7PMqcRYSpYYQylXAOme3zfl56tPrg/WaWMys9VGJRhJ4kCgV5/MV+1osgouCdYuRkBCdRB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7ux2MwJ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740961776; x=1772497776;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Befgc/T/RiI+gcjQxMdISn98GTq2ZuU6uPlB+l54lxw=;
  b=V7ux2MwJ1cZIc5EKZ73+1j1pNSdwm+xFlvjmb5whgcMxYDMwWPFzC8kU
   6i6HcuRU3emlfhef1ExYAgn2JE8awVsE122OyNdszkCMC5OC05XYUrK71
   Mi5dpedRKxqo7lwwzeResUUcsUwnw8YUaEJzM5Ii794C06X2NntAcCc+Q
   U3RQxmAJw8Wiv8lxWimwA/cpj29bM+/JXpXlEd7fdgwT0RqnxWuFG9pj2
   H5+CpcmItpzFGeG0tlCWKaGh2lUKTlLSWOt1G4NHeCsXwteHZbDurhBV/
   Eqe8uayfHTb49pMK1VonqLUxwzJ0boBMjMmYLxTI9m7rAl8mQiKm/Fr/5
   Q==;
X-CSE-ConnectionGUID: AijWWlZuQQi4KHT56N8UvA==
X-CSE-MsgGUID: Lxtu8UTZQx6d535+JodSWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="42081256"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="42081256"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 16:29:33 -0800
X-CSE-ConnectionGUID: 1R5Gk8G2Tt6KALubGDQmxg==
X-CSE-MsgGUID: WUL8yveGQ5ap0NHIJl6rRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="118341735"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 16:29:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 2 Mar 2025 16:29:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 2 Mar 2025 16:29:32 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 2 Mar 2025 16:29:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsgzO2UCJ6WIVFVOH7QhJEKG8tbBnyoFdEUnEMpdbC+GOTuKEI+qtIPQDPicceeWj3nYP13BL+K+QczxlQg6z6SyY/IrR2rmNbmkp7t9Io/Lj4lTt96bGKPgM+9+yj5tyzu0EXJKG0tZR1rc+XVwJF+f2SPMT+wEC3IKGwQG0o/lfgB+r+M0Y0s7rD5nyvzRTCoGr6skQP72h/vNY4XnPzEeTkLOtzuSVoepPv8WVTR4pIFqxtXIydtKLDq47+DjAxaE1hbiz9GtO3Bqa8gONphbvyStiBmdc822HoPzFDlQlBv7UnwpBqNu6zErohGDo3LAAhHbm3wr4kk0R/OUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mx/y9qQoq1vwc4CldMhGn3I3lKWG8z9ggr0A9o2aFag=;
 b=KjA+BvmhnIQPJwCW5VD1nUiNZs8oI4BYloCI0Bk8+oNlfhfW4xhMiwFOTlBk4xWRBYFIU7Vx92/ZRilULFgBO5xxNO089hDMRUSrtXrw0/uPrWN240qqXwJeKUtKu3sA7a9R5fzAzk8iQhxCi52jdvQBsRNjDCFTDy3oeZOMqOebxW1p/4TzQnUv8D/mih7Ml8ff/eANaG5b67Z8qE30wusotVsBsOC5mGkdzoQH2N03ZfhCV/tHfpuMhfMtIbqU7vDursMSNHEbXjVZMHMj9cScJ7UuLjU+8H72nkNT9OhRvLCp3IQSgwMaadgMJ09qEuZz8zV+Nn5U6vs+VuzZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by PH8PR11MB8260.namprd11.prod.outlook.com (2603:10b6:510:1c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 00:29:28 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 00:29:26 +0000
Date: Mon, 3 Mar 2025 08:29:17 +0800
From: kernel test robot <lkp@intel.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Geert
 Uytterhoeven" <geert+renesas@glider.be>, Laurent Pinchart
	<laurent.pinchart+renesas@ideasonboard.com>
Subject: arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:169.9-178.5: Warning
 (graph_child_address): /soc/display@10890000/ports: graph node has single
 child node 'port@0', #address-cells/#size-cells are not necessary
Message-ID: <Z8T33ZCPiOKEioWq@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|PH8PR11MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: d7695fdd-4ccc-434e-7c6b-08dd59ea73e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3uMz2Cq+ORHOA6j8XtUKfJ5NElMJzKQj5UngoRUaUCDvoHgmcFWmjqgFQp5Z?=
 =?us-ascii?Q?OBVZWbEJKz19QSu32xDkrRW1v+YjcFC1jRPi+nR+pB8C2DC3vWac8BTMSC4X?=
 =?us-ascii?Q?qzNeIf+p5erkXLp5+TgjHfMZYmMbwj50OWpiLiucYPzXA5Yy00VR09CzE6Sq?=
 =?us-ascii?Q?bybGu4Doqbx/Sg6L8/FmnvytNC+Fy10ruafFBZQcsfLC/Sx44KLx2VgzV2Gc?=
 =?us-ascii?Q?EqCKBrCE7ZEDUD9QNnjGZ8YveDNcqzjBAPNNLhgAnvAbQmUbBmadC5A4R20c?=
 =?us-ascii?Q?XOWJrvN8m1ka8lJ+yA3aYGQGRL3qp+1RENK14JDKhkWdqBtLaEBnk5YhgLl2?=
 =?us-ascii?Q?E+CUb9o+Igis2/I5Caon9V4USEJYs50QSk6Vb5bIS5kd9f7suLoAn1lAlvTi?=
 =?us-ascii?Q?ve0Lk+BBD5Uc9qNHJ3Ha4eXb+E44xa9b0ym0Iz4EV9N9JHerex0MXMHZeF6e?=
 =?us-ascii?Q?Gm/Zoa8siuqFc3zVe9VTjiT5ZWQ9A444k6eD1epEUeUvJJHjF4S5+3hlzgz3?=
 =?us-ascii?Q?EGCZDg4soo2WpI8qeSDurQUK/LhSztZtTKi79gjfuHtJCpAZOettkJEIRyVZ?=
 =?us-ascii?Q?xpc3+cH+gfVgir0OYsbkTokYi2HWzeJvPX7dBpqAPai6wWUkUPQF3upihXp4?=
 =?us-ascii?Q?n80xcmEyrouq4QOeHR9fd40fQdtfe+fUSr00t9cgUMGRmHRk2OrjMWvDtYFR?=
 =?us-ascii?Q?jR49uESFiuNsbeXUBSqb6kxXYz16xfWH9+d4Y7KXLkCf8dXKsgiUnHeK9kfw?=
 =?us-ascii?Q?UatOMmeVx0DO/WzOVZUAymW0cjEbpBZ0nbVkZu6sik1KNvXtGoFDzQKjTpdE?=
 =?us-ascii?Q?M4QcQkOLJ0UAalHiqs2aTXbDs095DMzpSg+pc/efgW0dQUvYKa3jke8Blm/A?=
 =?us-ascii?Q?jmEnFzhBKESBJ1WZYB1N4EuWbuYtIkfO2KxRoPxq9oKursBWuBePtvxLuDVW?=
 =?us-ascii?Q?uhqY9myiNpY6nObeknxJLTmU0jEfYDF/5CTo7oiMZdQUbjYEqhZn8eM74+Ka?=
 =?us-ascii?Q?Y7zqQc++XKtasFGNbq6tCArY75Jw4iwCuCa8rM6uDJ6wtJD1Ga+/VQPDGr4B?=
 =?us-ascii?Q?c5gOkKto2wSCEj1zTHjL5AwTDqZ/RMpZ/xuB9S+mjYbh9v444Cgju2JY4yJQ?=
 =?us-ascii?Q?JdIX+t9Sgm8gaN4MvICHBKfImf8HOGzeL34hzW9DDs2ZLQsoVXJNEeJXOZ3G?=
 =?us-ascii?Q?5O+/PNl6sBr++yiI5U/bBCSchUW77oLuoQYNnok4LyB1M8mSrdv75zWWID1j?=
 =?us-ascii?Q?8p1M7Sx9IOKTVyvdmAp8x06dk+ktbCtT898h6TsBzAPwhBEuYx2iJAaAGPxH?=
 =?us-ascii?Q?mXx7GAeUUbag1o07FBmpncfjWBkdoxSWKSnOQhQxFrj+skh1R9Hbwyu+YFoY?=
 =?us-ascii?Q?a3GBfWZOKaw391o7zkzjn9vfDRqs9Vg6mlce+Z5Vt70KmQcfmA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?njzCTM3m05aJ7rL9kRJzZEJfUhitanw2XxssgXPdg2/A9hK8T5ZyyKgoZYUT?=
 =?us-ascii?Q?C56iwkeWoS7wu1d0JKVg1CujOin+wZh+ndVWJ149iPSGahXOZ5phTmHtp/zX?=
 =?us-ascii?Q?RJgVO90HiLMxwHsGQRZzT+c8ca+blEwBm/h/Xn9RHsLNoYUA7YjGMNIT5S5f?=
 =?us-ascii?Q?mlbL+48DqLB6rR8PTowMCoSdUkKgZuqBRo0jLzNM8DYVpw3GODJiVsdrYUri?=
 =?us-ascii?Q?fAQj4RQAejuuOJVJmhbxOlBcuy0/41ocWJ9wVlZyPyZMKJMucrEfz0nPtukG?=
 =?us-ascii?Q?2t+G3aL7CuS5et2/uPZb8lTCj0L8qSseeROxEE65i42aPi8yqGvi5Ibi+z5b?=
 =?us-ascii?Q?KeSFqn/I5Hql7M+FdKJ47NX0ygYT+FKaDSXNj0RVdOBtI73HX+8DiULF9zh/?=
 =?us-ascii?Q?sDcMGyRWVjYJRqbNCSlzFAz0pRujzFkGQfiyv/AuctjfU02c1Ko4/qFwkP28?=
 =?us-ascii?Q?gDCZF52GyH4sjhhui6cF5Ley7atV3sMcU5n3gOAGrccbT8rjWvvdvdzm/THX?=
 =?us-ascii?Q?/rMA3Se7+WBApi4GuBm8/lQvF+8OpmYeZZD7L0N1j9LQlvAeihh/cmxZp7yu?=
 =?us-ascii?Q?13OjF+MdidBCu0vfieRtT94yTl1VHC79g1GUlvSOo6dlkmK/fa8d7RyMU/hY?=
 =?us-ascii?Q?1gXkiD1jMqfH7Iv+uUIO7bp82FqWSxrofqQVWkbb3bXUgNsAI1UkVBGly8/a?=
 =?us-ascii?Q?LwqZ134hjX0ET59ignYcloPa7eZreEaJiohn3RWtywk/RWKAA4X+trRfcpyt?=
 =?us-ascii?Q?74QL2afs1ZoIXw272df3WAJKYP3O45o0WlzxxGZ6V4u/7RALoG2Lc7TgB2YD?=
 =?us-ascii?Q?p2pHnlP1pdV9K0rVj7li6W0/S0h1XURxgrlifSP6qhACLGOCYAyNhzUSJzvE?=
 =?us-ascii?Q?l1u90CdWkdufUoPVLN5abyh3tIhB41tWVe3Mwl9YXwhUFl+5qxo86pLoe93f?=
 =?us-ascii?Q?iYUtWcY85W6+6X252HosD+0aMFYz5ndQ27Y15I0eEecBFFiq8wrpGHdMV4IF?=
 =?us-ascii?Q?EpEKHTIOkW0zbIuW8GzYkUPViCZKXV7LaFs9bQYeXxgGaRa+quoHV09NrmaE?=
 =?us-ascii?Q?nJNTtpC2zI+dNndrVR765Z8acelhlGZgnM9+XuOj2YKVWzw+Bb//h1o8CQXx?=
 =?us-ascii?Q?GpbPdIosPhIr9pHs61Osy0L4S301idedv0bG4VONCXst9MOaPtCRiKxxh0K4?=
 =?us-ascii?Q?m7uxyJG7je1UxUDvremSIubICHQdrTpjWzOlwBlViQhvicNpBztyK+PxIAgD?=
 =?us-ascii?Q?Cw1TKXk0cm8e80EHy6GawHWCo4jNT5miH0PNxOyHlSciJWh7KMfPdUxAZHTk?=
 =?us-ascii?Q?6XDqm/XAqRVgks4UEKV5txg8bv1KdxfEMSQzrBMl46EbHguZF32axgc6M7fG?=
 =?us-ascii?Q?L955KZEsiyHZSRsCFXo7ySTXAlCMVTmpgWkDIiFsgW/pqmd1u+FCWnwKB6Yq?=
 =?us-ascii?Q?zzFlLNuy2KErPQ2wJ6yJtxGGdpXlRED/q3PxIV8Dy+pfuJjIFQ241Ai2Gq4F?=
 =?us-ascii?Q?tKwX3FaAxLtkltzPQdO0W9tPpT4UY/Xue6giwWtWYQ1XKLqe7rVs+OiIVtiX?=
 =?us-ascii?Q?5XAvy2w5x+4bRClfZZbh2SxmuRMtpwF4dy0Lu+3dU8B9mZDD93+NoC2mbGXq?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7695fdd-4ccc-434e-7c6b-08dd59ea73e4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 00:29:26.3640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UgiIM3zU6DkyVcBew4XSgxZNw5ktMyhN3AI+IoKEHn3TSUFkQnW/cJykoVvUzRtizh2/tKCgwYPuqm4/XAYzbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8260
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7eb172143d5508b4da468ed59ee857c6e5e01da6
commit: e895a806608a1f95067d27ae3870c9b4c5a236ee arm64: dts: renesas: r9a07g043u: Add DU node
date:   6 months ago
:::::: branch date: 4 hours ago
:::::: commit date: 6 months ago
config: arm64-randconfig-001-20241212 (https://download.01.org/0day-ci/archive/20250303/202503030708.8JclqdGF-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250303/202503030708.8JclqdGF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202503030708.8JclqdGF-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:84.11-93.6: Warning (graph_child_address): /soc/video@10830000/ports/port@1: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
   arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:119.11-128.6: Warning (graph_child_address): /soc/csi2@10830400/ports/port@1: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:169.9-178.5: Warning (graph_child_address): /soc/display@10890000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary

vim +169 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi

b9a0be205496402 Lad Prabhakar 2022-10-25   59  
b9a0be205496402 Lad Prabhakar 2022-10-25   60  &soc {
b9a0be205496402 Lad Prabhakar 2022-10-25   61  	interrupt-parent = <&gic>;
b9a0be205496402 Lad Prabhakar 2022-10-25   62  
971c17f879352ad Biju Das      2024-01-26   63  	cru: video@10830000 {
971c17f879352ad Biju Das      2024-01-26   64  		compatible = "renesas,r9a07g043-cru", "renesas,rzg2l-cru";
971c17f879352ad Biju Das      2024-01-26   65  		reg = <0 0x10830000 0 0x400>;
971c17f879352ad Biju Das      2024-01-26   66  		clocks = <&cpg CPG_MOD R9A07G043_CRU_VCLK>,
971c17f879352ad Biju Das      2024-01-26   67  			 <&cpg CPG_MOD R9A07G043_CRU_PCLK>,
971c17f879352ad Biju Das      2024-01-26   68  			 <&cpg CPG_MOD R9A07G043_CRU_ACLK>;
971c17f879352ad Biju Das      2024-01-26   69  		clock-names = "video", "apb", "axi";
971c17f879352ad Biju Das      2024-01-26   70  		interrupts = <SOC_PERIPHERAL_IRQ(167) IRQ_TYPE_LEVEL_HIGH>,
971c17f879352ad Biju Das      2024-01-26   71  			     <SOC_PERIPHERAL_IRQ(168) IRQ_TYPE_LEVEL_HIGH>,
971c17f879352ad Biju Das      2024-01-26   72  			     <SOC_PERIPHERAL_IRQ(169) IRQ_TYPE_LEVEL_HIGH>;
971c17f879352ad Biju Das      2024-01-26   73  		interrupt-names = "image_conv", "image_conv_err", "axi_mst_err";
971c17f879352ad Biju Das      2024-01-26   74  		resets = <&cpg R9A07G043_CRU_PRESETN>,
971c17f879352ad Biju Das      2024-01-26   75  			 <&cpg R9A07G043_CRU_ARESETN>;
971c17f879352ad Biju Das      2024-01-26   76  		reset-names = "presetn", "aresetn";
971c17f879352ad Biju Das      2024-01-26   77  		power-domains = <&cpg>;
971c17f879352ad Biju Das      2024-01-26   78  		status = "disabled";
971c17f879352ad Biju Das      2024-01-26   79  
971c17f879352ad Biju Das      2024-01-26   80  		ports {
971c17f879352ad Biju Das      2024-01-26   81  			#address-cells = <1>;
971c17f879352ad Biju Das      2024-01-26   82  			#size-cells = <0>;
971c17f879352ad Biju Das      2024-01-26   83  
971c17f879352ad Biju Das      2024-01-26   84  			port@1 {
971c17f879352ad Biju Das      2024-01-26   85  				#address-cells = <1>;
971c17f879352ad Biju Das      2024-01-26   86  				#size-cells = <0>;
971c17f879352ad Biju Das      2024-01-26   87  
971c17f879352ad Biju Das      2024-01-26   88  				reg = <1>;
971c17f879352ad Biju Das      2024-01-26   89  				crucsi2: endpoint@0 {
971c17f879352ad Biju Das      2024-01-26   90  					reg = <0>;
971c17f879352ad Biju Das      2024-01-26   91  					remote-endpoint = <&csi2cru>;
971c17f879352ad Biju Das      2024-01-26   92  				};
971c17f879352ad Biju Das      2024-01-26   93  			};
971c17f879352ad Biju Das      2024-01-26   94  		};
971c17f879352ad Biju Das      2024-01-26   95  	};
971c17f879352ad Biju Das      2024-01-26   96  
971c17f879352ad Biju Das      2024-01-26   97  	csi2: csi2@10830400 {
971c17f879352ad Biju Das      2024-01-26   98  		compatible = "renesas,r9a07g043-csi2", "renesas,rzg2l-csi2";
971c17f879352ad Biju Das      2024-01-26   99  		reg = <0 0x10830400 0 0xfc00>;
971c17f879352ad Biju Das      2024-01-26  100  		interrupts = <SOC_PERIPHERAL_IRQ(166) IRQ_TYPE_LEVEL_HIGH>;
971c17f879352ad Biju Das      2024-01-26  101  		clocks = <&cpg CPG_MOD R9A07G043_CRU_SYSCLK>,
971c17f879352ad Biju Das      2024-01-26  102  			 <&cpg CPG_MOD R9A07G043_CRU_VCLK>,
971c17f879352ad Biju Das      2024-01-26  103  			 <&cpg CPG_MOD R9A07G043_CRU_PCLK>;
971c17f879352ad Biju Das      2024-01-26  104  		clock-names = "system", "video", "apb";
971c17f879352ad Biju Das      2024-01-26  105  		resets = <&cpg R9A07G043_CRU_PRESETN>,
971c17f879352ad Biju Das      2024-01-26  106  			 <&cpg R9A07G043_CRU_CMN_RSTB>;
971c17f879352ad Biju Das      2024-01-26  107  		reset-names = "presetn", "cmn-rstb";
971c17f879352ad Biju Das      2024-01-26  108  		power-domains = <&cpg>;
971c17f879352ad Biju Das      2024-01-26  109  		status = "disabled";
971c17f879352ad Biju Das      2024-01-26  110  
971c17f879352ad Biju Das      2024-01-26  111  		ports {
971c17f879352ad Biju Das      2024-01-26  112  			#address-cells = <1>;
971c17f879352ad Biju Das      2024-01-26  113  			#size-cells = <0>;
971c17f879352ad Biju Das      2024-01-26  114  
971c17f879352ad Biju Das      2024-01-26  115  			port@0 {
971c17f879352ad Biju Das      2024-01-26  116  				reg = <0>;
971c17f879352ad Biju Das      2024-01-26  117  			};
971c17f879352ad Biju Das      2024-01-26  118  
971c17f879352ad Biju Das      2024-01-26  119  			port@1 {
971c17f879352ad Biju Das      2024-01-26  120  				#address-cells = <1>;
971c17f879352ad Biju Das      2024-01-26  121  				#size-cells = <0>;
971c17f879352ad Biju Das      2024-01-26  122  				reg = <1>;
971c17f879352ad Biju Das      2024-01-26  123  
971c17f879352ad Biju Das      2024-01-26  124  				csi2cru: endpoint@0 {
971c17f879352ad Biju Das      2024-01-26  125  					reg = <0>;
971c17f879352ad Biju Das      2024-01-26  126  					remote-endpoint = <&crucsi2>;
971c17f879352ad Biju Das      2024-01-26  127  				};
971c17f879352ad Biju Das      2024-01-26  128  			};
971c17f879352ad Biju Das      2024-01-26  129  		};
971c17f879352ad Biju Das      2024-01-26  130  	};
971c17f879352ad Biju Das      2024-01-26  131  
6bfd974d03a433e Biju Das      2024-08-05  132  	vspd: vsp@10870000 {
6bfd974d03a433e Biju Das      2024-08-05  133  		compatible = "renesas,r9a07g043u-vsp2", "renesas,r9a07g044-vsp2";
6bfd974d03a433e Biju Das      2024-08-05  134  		reg = <0 0x10870000 0 0x10000>;
6bfd974d03a433e Biju Das      2024-08-05  135  		interrupts = <SOC_PERIPHERAL_IRQ(149) IRQ_TYPE_LEVEL_HIGH>;
6bfd974d03a433e Biju Das      2024-08-05  136  		clocks = <&cpg CPG_MOD R9A07G043_LCDC_CLK_A>,
6bfd974d03a433e Biju Das      2024-08-05  137  			 <&cpg CPG_MOD R9A07G043_LCDC_CLK_P>,
6bfd974d03a433e Biju Das      2024-08-05  138  			 <&cpg CPG_MOD R9A07G043_LCDC_CLK_D>;
6bfd974d03a433e Biju Das      2024-08-05  139  		clock-names = "aclk", "pclk", "vclk";
6bfd974d03a433e Biju Das      2024-08-05  140  		power-domains = <&cpg>;
6bfd974d03a433e Biju Das      2024-08-05  141  		resets = <&cpg R9A07G043_LCDC_RESET_N>;
6bfd974d03a433e Biju Das      2024-08-05  142  		renesas,fcp = <&fcpvd>;
6bfd974d03a433e Biju Das      2024-08-05  143  	};
6bfd974d03a433e Biju Das      2024-08-05  144  
a94a244a5b1a204 Biju Das      2024-08-05  145  	fcpvd: fcp@10880000 {
a94a244a5b1a204 Biju Das      2024-08-05  146  		compatible = "renesas,r9a07g043u-fcpvd", "renesas,fcpv";
a94a244a5b1a204 Biju Das      2024-08-05  147  		reg = <0 0x10880000 0 0x10000>;
a94a244a5b1a204 Biju Das      2024-08-05  148  		clocks = <&cpg CPG_MOD R9A07G043_LCDC_CLK_A>,
a94a244a5b1a204 Biju Das      2024-08-05  149  			 <&cpg CPG_MOD R9A07G043_LCDC_CLK_P>,
a94a244a5b1a204 Biju Das      2024-08-05  150  			 <&cpg CPG_MOD R9A07G043_LCDC_CLK_D>;
a94a244a5b1a204 Biju Das      2024-08-05  151  		clock-names = "aclk", "pclk", "vclk";
a94a244a5b1a204 Biju Das      2024-08-05  152  		power-domains = <&cpg>;
a94a244a5b1a204 Biju Das      2024-08-05  153  		resets = <&cpg R9A07G043_LCDC_RESET_N>;
a94a244a5b1a204 Biju Das      2024-08-05  154  	};
a94a244a5b1a204 Biju Das      2024-08-05  155  
e895a806608a1f9 Biju Das      2024-08-22  156  	du: display@10890000 {
e895a806608a1f9 Biju Das      2024-08-22  157  		compatible = "renesas,r9a07g043u-du";
e895a806608a1f9 Biju Das      2024-08-22  158  		reg = <0 0x10890000 0 0x10000>;
e895a806608a1f9 Biju Das      2024-08-22  159  		interrupts = <SOC_PERIPHERAL_IRQ(152) IRQ_TYPE_LEVEL_HIGH>;
e895a806608a1f9 Biju Das      2024-08-22  160  		clocks = <&cpg CPG_MOD R9A07G043_LCDC_CLK_A>,
e895a806608a1f9 Biju Das      2024-08-22  161  			 <&cpg CPG_MOD R9A07G043_LCDC_CLK_P>,
e895a806608a1f9 Biju Das      2024-08-22  162  			 <&cpg CPG_MOD R9A07G043_LCDC_CLK_D>;
e895a806608a1f9 Biju Das      2024-08-22  163  		clock-names = "aclk", "pclk", "vclk";
e895a806608a1f9 Biju Das      2024-08-22  164  		power-domains = <&cpg>;
e895a806608a1f9 Biju Das      2024-08-22  165  		resets = <&cpg R9A07G043_LCDC_RESET_N>;
e895a806608a1f9 Biju Das      2024-08-22  166  		renesas,vsps = <&vspd 0>;
e895a806608a1f9 Biju Das      2024-08-22  167  		status = "disabled";
e895a806608a1f9 Biju Das      2024-08-22  168  
e895a806608a1f9 Biju Das      2024-08-22 @169  		ports {
e895a806608a1f9 Biju Das      2024-08-22  170  			#address-cells = <1>;
e895a806608a1f9 Biju Das      2024-08-22  171  			#size-cells = <0>;
e895a806608a1f9 Biju Das      2024-08-22  172  
e895a806608a1f9 Biju Das      2024-08-22  173  			port@0 {
e895a806608a1f9 Biju Das      2024-08-22  174  				reg = <0>;
e895a806608a1f9 Biju Das      2024-08-22  175  				du_out_rgb: endpoint {
e895a806608a1f9 Biju Das      2024-08-22  176  				};
e895a806608a1f9 Biju Das      2024-08-22  177  			};
e895a806608a1f9 Biju Das      2024-08-22  178  		};
e895a806608a1f9 Biju Das      2024-08-22  179  	};
e895a806608a1f9 Biju Das      2024-08-22  180  
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  181  	irqc: interrupt-controller@110a0000 {
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  182  		compatible = "renesas,r9a07g043u-irqc",
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  183  			     "renesas,rzg2l-irqc";
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  184  		reg = <0 0x110a0000 0 0x10000>;
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  185  		#interrupt-cells = <2>;
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  186  		#address-cells = <0>;
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  187  		interrupt-controller;
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  188  		interrupts = <SOC_PERIPHERAL_IRQ(0) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  189  			     <SOC_PERIPHERAL_IRQ(1) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  190  			     <SOC_PERIPHERAL_IRQ(2) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  191  			     <SOC_PERIPHERAL_IRQ(3) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  192  			     <SOC_PERIPHERAL_IRQ(4) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  193  			     <SOC_PERIPHERAL_IRQ(5) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  194  			     <SOC_PERIPHERAL_IRQ(6) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  195  			     <SOC_PERIPHERAL_IRQ(7) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  196  			     <SOC_PERIPHERAL_IRQ(8) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  197  			     <SOC_PERIPHERAL_IRQ(444) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  198  			     <SOC_PERIPHERAL_IRQ(445) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  199  			     <SOC_PERIPHERAL_IRQ(446) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  200  			     <SOC_PERIPHERAL_IRQ(447) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  201  			     <SOC_PERIPHERAL_IRQ(448) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  202  			     <SOC_PERIPHERAL_IRQ(449) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  203  			     <SOC_PERIPHERAL_IRQ(450) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  204  			     <SOC_PERIPHERAL_IRQ(451) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  205  			     <SOC_PERIPHERAL_IRQ(452) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  206  			     <SOC_PERIPHERAL_IRQ(453) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  207  			     <SOC_PERIPHERAL_IRQ(454) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  208  			     <SOC_PERIPHERAL_IRQ(455) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  209  			     <SOC_PERIPHERAL_IRQ(456) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  210  			     <SOC_PERIPHERAL_IRQ(457) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  211  			     <SOC_PERIPHERAL_IRQ(458) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  212  			     <SOC_PERIPHERAL_IRQ(459) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  213  			     <SOC_PERIPHERAL_IRQ(460) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  214  			     <SOC_PERIPHERAL_IRQ(461) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  215  			     <SOC_PERIPHERAL_IRQ(462) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  216  			     <SOC_PERIPHERAL_IRQ(463) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  217  			     <SOC_PERIPHERAL_IRQ(464) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  218  			     <SOC_PERIPHERAL_IRQ(465) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  219  			     <SOC_PERIPHERAL_IRQ(466) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  220  			     <SOC_PERIPHERAL_IRQ(467) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  221  			     <SOC_PERIPHERAL_IRQ(468) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  222  			     <SOC_PERIPHERAL_IRQ(469) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  223  			     <SOC_PERIPHERAL_IRQ(470) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  224  			     <SOC_PERIPHERAL_IRQ(471) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  225  			     <SOC_PERIPHERAL_IRQ(472) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  226  			     <SOC_PERIPHERAL_IRQ(473) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  227  			     <SOC_PERIPHERAL_IRQ(474) IRQ_TYPE_LEVEL_HIGH>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  228  			     <SOC_PERIPHERAL_IRQ(475) IRQ_TYPE_LEVEL_HIGH>,
14fe225dd5fcd59 Lad Prabhakar 2024-02-05  229  			     <SOC_PERIPHERAL_IRQ(25) IRQ_TYPE_EDGE_RISING>,
14fe225dd5fcd59 Lad Prabhakar 2024-02-05  230  			     <SOC_PERIPHERAL_IRQ(34) IRQ_TYPE_EDGE_RISING>,
14fe225dd5fcd59 Lad Prabhakar 2024-02-05  231  			     <SOC_PERIPHERAL_IRQ(35) IRQ_TYPE_EDGE_RISING>,
14fe225dd5fcd59 Lad Prabhakar 2024-02-05  232  			     <SOC_PERIPHERAL_IRQ(36) IRQ_TYPE_EDGE_RISING>,
14fe225dd5fcd59 Lad Prabhakar 2024-02-05  233  			     <SOC_PERIPHERAL_IRQ(37) IRQ_TYPE_EDGE_RISING>,
14fe225dd5fcd59 Lad Prabhakar 2024-02-05  234  			     <SOC_PERIPHERAL_IRQ(38) IRQ_TYPE_EDGE_RISING>,
14fe225dd5fcd59 Lad Prabhakar 2024-02-05  235  			     <SOC_PERIPHERAL_IRQ(39) IRQ_TYPE_EDGE_RISING>;
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  236  		interrupt-names = "nmi",
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  237  				  "irq0", "irq1", "irq2", "irq3",
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  238  				  "irq4", "irq5", "irq6", "irq7",
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  239  				  "tint0", "tint1", "tint2", "tint3",
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  240  				  "tint4", "tint5", "tint6", "tint7",
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  241  				  "tint8", "tint9", "tint10", "tint11",
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  242  				  "tint12", "tint13", "tint14", "tint15",
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  243  				  "tint16", "tint17", "tint18", "tint19",
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  244  				  "tint20", "tint21", "tint22", "tint23",
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  245  				  "tint24", "tint25", "tint26", "tint27",
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  246  				  "tint28", "tint29", "tint30", "tint31",
14fe225dd5fcd59 Lad Prabhakar 2024-02-05  247  				  "bus-err", "ec7tie1-0", "ec7tie2-0",
14fe225dd5fcd59 Lad Prabhakar 2024-02-05  248  				  "ec7tiovf-0", "ec7tie1-1", "ec7tie2-1",
14fe225dd5fcd59 Lad Prabhakar 2024-02-05  249  				  "ec7tiovf-1";
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  250  		clocks = <&cpg CPG_MOD R9A07G043_IA55_CLK>,
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  251  			<&cpg CPG_MOD R9A07G043_IA55_PCLK>;
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  252  		clock-names = "clk", "pclk";
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  253  		power-domains = <&cpg>;
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  254  		resets = <&cpg R9A07G043_IA55_RESETN>;
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  255  	};
48ab6eddd8bbcf7 Lad Prabhakar 2023-01-02  256  
b9a0be205496402 Lad Prabhakar 2022-10-25  257  	gic: interrupt-controller@11900000 {
b9a0be205496402 Lad Prabhakar 2022-10-25  258  		compatible = "arm,gic-v3";
b9a0be205496402 Lad Prabhakar 2022-10-25  259  		#interrupt-cells = <3>;
b9a0be205496402 Lad Prabhakar 2022-10-25  260  		#address-cells = <0>;
b9a0be205496402 Lad Prabhakar 2022-10-25  261  		interrupt-controller;
ab39547f739236e Lad Prabhakar 2024-07-30  262  		reg = <0x0 0x11900000 0 0x20000>,
ab39547f739236e Lad Prabhakar 2024-07-30  263  		      <0x0 0x11940000 0 0x40000>;
b9a0be205496402 Lad Prabhakar 2022-10-25  264  		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
b9a0be205496402 Lad Prabhakar 2022-10-25  265  	};
b9a0be205496402 Lad Prabhakar 2022-10-25  266  };
b9a0be205496402 Lad Prabhakar 2022-10-25  267  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


