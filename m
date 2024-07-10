Return-Path: <linux-kernel+bounces-247256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E408A92CD36
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70CD1C235C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC1C131E4B;
	Wed, 10 Jul 2024 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTznOG59"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9212BEBB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600636; cv=fail; b=h7aQHPOaKG3hu9j17WxR7z9zSQhBLE7L38WMgDcOcgxnwKpoFMZK8lGijxoWirqNFZ4xIqKaAdPuchjp777z9/o2qxv9QgsUTjzTqpyjJHDDILopw9x8djqrelwbaAN8cZkZu9NlQH+j2TljoafTG5h3NdLsAdETuvwlYKzXsbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600636; c=relaxed/simple;
	bh=rsGbKuWxQQOQ3jYol8wteCezeXdEQwgsqntVHVVA4+U=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=spNOoA+UE6KqBLnMrgLGZTp+Y1LW3PiXhpIul1SOUIW+2n2GoXXuOHGF7EpsKd8IZClPxtjxtSbgXHFGrgbka1wbZ5jf5KLcmMFs+a8/2AU/NT0lIUfl6ibSK4fW2EJ9t+Q2rhwow2oiMV7Y+Re711hMVO7iex8Z9ACC8zuBERc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTznOG59; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720600635; x=1752136635;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rsGbKuWxQQOQ3jYol8wteCezeXdEQwgsqntVHVVA4+U=;
  b=NTznOG59mpOd0h7q9ABRi3DIgt79k4YO8Hqrk7QdyEkRuudOfKtUejtP
   DLHoPJWxe2Jdir4F/+NsyJzqdyCpeZseGupQOwiTSWinqbkb1xPKncLR3
   oe/Azx+I/8gDHuqpQlfacA4zDzXdkVHV+5a1AHbfmJOGUP98rC8wkMg3u
   Ai4mm9Kyfq2CmU490D4MVggCpZU2K85fvCG24by0LtPrHPWL+THnMPpsa
   gXqj9irrOnNtKdflwa3M2D4fzht9kTeemgLsPVrZKqCXpRlBPdki3b9Nr
   tzDfW3wYkNzZGUWVOh7SiGv6WtWcthsv28lBsE8hpThokWRDopZs6qPK+
   w==;
X-CSE-ConnectionGUID: kIuVUvdxRiaImlFaxjseng==
X-CSE-MsgGUID: XZ3U1CYwTW2eGPo0Pr31dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="18108945"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="18108945"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 01:37:14 -0700
X-CSE-ConnectionGUID: MTMk8VTZSnWQErCOVf7j1w==
X-CSE-MsgGUID: L/m2dQXzT+qNixz+jmYA8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48868019"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 01:37:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 01:37:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 01:37:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 01:37:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 01:37:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lC8wDV5WERvkvPtui5y8Tk4VapznOOpMPb+vpUYSYMp7jtVg9eLi2bjgLYl39Z610IUOszRUgjUq0XpTki+l4RpLOlz/44sSWS3WewQQFVP5XZs1672WlaF4MerMZMYwb6FQgGVKoZtoQJSfchXIk+JRK1MwA0XbKXH31qPX6LIeGYW7BVKQAkOEkApl0xVtZCS1mwC2XfCKWuACpgwOKgk2TZS4knCkifp8BSAEEg+ctlXHpMRZ54BSsNKi9ZLv1vYijSiGqrHOzCRY2kNOySu2bhXa7Y+Y5oJqTWwO6/nc7M91OMVw5lPO2sAziJ7Xp6VXAjrabiNXJX1FYtbWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGugNQQVTtN5b4FMQk7C8yKQ87UtsljST4NSL9pX3bk=;
 b=eNyGmiDm1cO0JbruecUV09I6eTH4c+F55L1IlNPvOsviSd6Lb0cduE3P0wL3Igl8qL1Jm4DQKZJO7b/3vqwL8qzMWPnaDdR2DEGh8gC0mpoBfpfl/xPg4IQEc1/R1LpzNzBwV/slw3KjkBbBDfUuXYCeYDuAEFMuT8HsFG63uvWdzW4Vox2C4NqbfDr4xS/hQPWi8MfaIyrUbXyWXI8dIgz9QgYl6wahvmuUPzsxmQXMFodw7f2z9HWlfvqFOOMprHvdK0zdqYEBktiQH4Plte0SE0VHqhiYyAD/GmmcGc0HuVDD1eS2YZ8HETRS3+56C5+yGATOROvouDk2Ag4bqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8479.namprd11.prod.outlook.com (2603:10b6:510:30c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 08:37:10 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 08:37:10 +0000
Date: Wed, 10 Jul 2024 16:37:00 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker
	<frederic@kernel.org>, <oliver.sang@intel.com>
Subject: [tip:timers/urgent] [timers/migration]  8cdb61838e:
 WARNING:at_kernel/time/timer_migration.c:#tmigr_connect_child_parent
Message-ID: <202407101636.d9d4e8be-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 1efa54a4-3592-42dd-f878-08dca0bb7d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mh4sd4oLmmMqmCZuDJ0sYMDmW3JAsltKxrnRkj1PW8E2LGuKbAKlhCAgj4c3?=
 =?us-ascii?Q?xG39+DS33aA9rwV+GV1hXzvT171gGrdTo6AmjWcvgW1H8CP+5GypksJGxqvA?=
 =?us-ascii?Q?j0VdXwZYVAjBKnyKE4cE5LZtsBNC0+wphUjMW8Wn/mbal8mJA736CPQGCY4W?=
 =?us-ascii?Q?ajJa4RfhXFyGKvkMQaymGPnfhHOrBF8r3VBSH7uYutNcf/lVm41pzYbkc0Fs?=
 =?us-ascii?Q?JGdoPbIjMhP3CizxMIChxXpsLg5XuRZR9CZNK0hJKL3qwtWrEQfH/Hw0uvbC?=
 =?us-ascii?Q?LlhHAuWYR4VeJG4sojqnIXdjsaPi4zFpsdGw+W4p/S+gU4tsB7z0GUsFGU0l?=
 =?us-ascii?Q?UD78RAaKmqcdKomqdRhPxo4yFC4yVf5+eVyiGFvwUlpEcCXt4XL+T4GAgRf9?=
 =?us-ascii?Q?TUYlN1bQTg010u2Zn5VFmIw3mC+wu5sKblab0SP3618qnnEbOOloEUKfyyO/?=
 =?us-ascii?Q?YUC7Ik/WXhu4NqnXRMjPvMLxoKnK0rvJJSQl19SBnUtZIgD+aJW6kkMoHCnw?=
 =?us-ascii?Q?PICLqetEyDIK7L3oLfvaFia/NDn4AJ8Z1UgM83Y+Ol8DoWmZkt5TR0stoFa9?=
 =?us-ascii?Q?gVaaV11AXMBIwgQYpmFfv7yyHjKOGSkA2dvkDyAfmnjVNB8CbOPEciDhRRyU?=
 =?us-ascii?Q?qO0TrLoTvAq7eQ5NDkkXSZiwN2m+9MXoxFzVFlZaOor0oR0JQsW+REA9YKd0?=
 =?us-ascii?Q?CWC77rDXplajyQE4RsVkSP2MVuDs4cNHvobjpkDi15DYpdlwjAljVoUgvzxg?=
 =?us-ascii?Q?eUskH6owd/WFqmEoJb0UTja2KQIDmRAFEBU05DkU7Rsv2GELsgE9ntW5cy+4?=
 =?us-ascii?Q?Ap3wegXKNh+13aeogs4IS1q53z9Sz4jF9UMGBGnTv1vJvwtvkyzEjHAyvHEs?=
 =?us-ascii?Q?DPTMUoVw7Ha/sME/IhklB0tm1ikXG17nq1Yp6/IgFkP7gTP0BAwqkF3jzL7o?=
 =?us-ascii?Q?CzStBbyBSGeIXmnYpWARvAxUDgG1XK0xYd1OPD2g3Z7uwMC1cGm46BTnzHGe?=
 =?us-ascii?Q?2wBIVB/KBP5qFLJFJiUwD9K/havZZGr8fy33AqXaN+59fCEkLjr2SZ1/ih+M?=
 =?us-ascii?Q?5pyhdYktN+Bk9+oPE0/yiBttTkpte2BS9AtTM/ftqd1rHTWNFmkEiqn13k1P?=
 =?us-ascii?Q?eU6mb5iycFWjDVrLrsjpG/oeP+KCwtv12dCkc/HFONkBrv9tTUop4TFRoBmD?=
 =?us-ascii?Q?+Zbd+hOjgxmoEmBSOoiuTH/EPbtQdp7sATLV1b9LcKYINR9JnIAmJ1jQ6kmr?=
 =?us-ascii?Q?z+BAxxqKxMTDxWiCrN+8CNVsK111QRtj/L1QhAIeV0Eq4MESwXV0EIEhCr3H?=
 =?us-ascii?Q?EAY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zBV5Aq4sDTnxIWS2CPIG4rAyhgb7ZZpvoqcIdVlRhbJG3pq6fO3JM48o3dQI?=
 =?us-ascii?Q?FkVNEIMzh8Y/Y7l83I81z0a27/VXpUtHqjb6AlrHVFJzOoopzpUaZ5F0ETvj?=
 =?us-ascii?Q?zZNVvaZtcLQCs73YMLkrV+YlMEg4FhAxFLsObZga4TS3/uJ/VdHNOF1rGPS2?=
 =?us-ascii?Q?HXNao5t8/5UfiY343dMl1m5eDCDGGPSax6Q5E0DLE2UPZop95u/7xomD1hoW?=
 =?us-ascii?Q?xiNlJYWyofRcV9ik9HRMEMIqDKSDVtPbiYLZBGRk6GZwnvbtcNH6IeiuXaVE?=
 =?us-ascii?Q?59rrU9WRSyCScJYXQjD7jvO2Fq7tM4h2yl/AlYV7dxcsoGSF0KViklhg6QZL?=
 =?us-ascii?Q?IS0X0ZQuIpBnwJqf86W5nP2qZxuVMmRPfmjw/29lHXYypW7XsD+vLVJSKGS4?=
 =?us-ascii?Q?uw8oLv/8KCcZZxQVe16Cptd61sBI7yKCwo5RHYhIfxT9IxDZ0DzGtodWhiGa?=
 =?us-ascii?Q?LMO6leMj8gFYJw3op9pED19hGGO5dUVDUmAhvpdRUGtzYcWxe1kNzqUAVhq9?=
 =?us-ascii?Q?lkR8cKNtcBy+dx0iAz/qWbKhlOn/Nvm7Z9INUpUB8Z+fSOPfXkERQIKJRSG7?=
 =?us-ascii?Q?gBlnXmkrazb714GiM2FyHJcqowYCfh3rh/v3QKK0b19b/EyyRUFgLFHtWygk?=
 =?us-ascii?Q?ne/MNawgDhFT1CCBPbzNuP9oO2R7TXA/6iURB9pNItgzRPyAZRSqnkkvBMO0?=
 =?us-ascii?Q?XYlvcEpwctO/xjDHxyc6l2gwWd7KN9Hu5yBOV9GnYpymUvqZ2cf5arveHYPt?=
 =?us-ascii?Q?1VgAQeAc8CTXeqWWvDbSrERi9yvLePC86B1p7cGrdoGL9OpmCKDb22vTNNAX?=
 =?us-ascii?Q?V5tP58udRPjVATgqBwc8iuBgmmayH0nTTdFxMVRraw/UIsr/LwBvVhOlZyd/?=
 =?us-ascii?Q?g/QeKAYRGgUgDXKMXrPhR6ZDlIkySZ3esQWG4VxAfDdfhZ5QIFkDtsEgCZgv?=
 =?us-ascii?Q?ZPUzDKqDXCGKG/nkszhhfvhNjk5EFlC83dR66btUGevxfpa9k6HQA2gSXRZ8?=
 =?us-ascii?Q?p0Ck4y/DyFdGcrToEDU7TWL3SKKqr4ZNi4ns2ezqCyo9hexTXb72AXH2A4uZ?=
 =?us-ascii?Q?YMFmEZ+NCe6NPK/ag2sLplpsVSHqX8PedFjfu5twqwlE10b6HrlGrZ8YHIAO?=
 =?us-ascii?Q?YMhsoSB0a4D68vyUQIwcKniCmwZmN6RvcVkhLtVCa1ALNjlnEk221I5qFN36?=
 =?us-ascii?Q?Iu4DmWKgmaFwacG3OuYp0ETIbXH87y0gNxCuMpNOUyOCWj50i+2CI56Tkg+L?=
 =?us-ascii?Q?V56ZpI3BT3a/fnjTShMg+E0h7bAfIy3dgUpDbZFBP5RKVsbLoG6DTbQ0wij9?=
 =?us-ascii?Q?BcyMqKixufEGtz6CIFNxwrun2Ee+49uS6QabQTcJtcfsChdFAldWTL6TkLag?=
 =?us-ascii?Q?BroKvImuCCn31KLzSJtebP+Uasr40nNR+kBJWvaujOFcjsyhdia4A4xl7RG4?=
 =?us-ascii?Q?UxTsuV5OND6MCewJYOPtVRzIzi752n14S53PkVcNDwfOT2xhjYYlv4bONwII?=
 =?us-ascii?Q?AXIK9Pn3+cqQMwaEcAtNYiqcpCzEe3KFgyOOlepbEYz7Y4Nv+e43pBUmxGiG?=
 =?us-ascii?Q?UrwGYCDv+SJ8B6VowcsXP23TVfkmEROny5tj9/oJcJwmQtnIf1Bh7pUi0Do7?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efa54a4-3592-42dd-f878-08dca0bb7d40
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 08:37:10.3570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45gTYuK9Cnv9q0mKYzPYkwCTig5kXPw0VeVeFbdMZhmYuz/rAkDcJy9Zxu/pPrw9vSdW+YnMZZbIAO44aOlbEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8479
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/time/timer_migration.c:#tmigr_connect_child_parent" on:

commit: 8cdb61838ee5c63556773ea2eed24deab6b15257 ("timers/migration: Move hierarchy setup into cpuhotplug prepare callback")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git timers/urgent

[test failed on linux-next/master 82d01fe6ee52086035b201cfa1410a3b04384257]

in testcase: filebench
version: filebench-x86_64-22620e6-1_20240224
with following parameters:

	disk: 1HDD
	fs: xfs
	test: randomwrite.f
	cpufreq_governor: performance



compiler: gcc-13
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407101636.d9d4e8be-oliver.sang@intel.com


[   16.306955][  T209] ------------[ cut here ]------------
[ 16.312287][ T209] WARNING: CPU: 32 PID: 209 at kernel/time/timer_migration.c:1620 tmigr_connect_child_parent (kernel/time/timer_migration.c:1620 (discriminator 7)) 
[   16.323148][  T209] Modules linked in:
[   16.326901][  T209] CPU: 32 PID: 209 Comm: cpuhp/32 Not tainted 6.10.0-rc6-00002-g8cdb61838ee5 #1
[ 16.335766][ T209] RIP: 0010:tmigr_connect_child_parent (kernel/time/timer_migration.c:1620 (discriminator 7)) 
[ 16.341945][ T209] Code: c6 07 00 0f 1f 00 fb 66 90 0f b6 45 60 48 89 e2 48 89 ee 48 89 df 88 44 24 18 e8 ec fc ff ff 84 c0 75 09 48 83 7b 08 00 74 02 <0f> 0b 48 8b 44 24 20 65 48 2b 04 25 28 00 00 00 75 36 48 83 c4 28
All code
========
   0:	c6 07 00             	movb   $0x0,(%rdi)
   3:	0f 1f 00             	nopl   (%rax)
   6:	fb                   	sti    
   7:	66 90                	xchg   %ax,%ax
   9:	0f b6 45 60          	movzbl 0x60(%rbp),%eax
   d:	48 89 e2             	mov    %rsp,%rdx
  10:	48 89 ee             	mov    %rbp,%rsi
  13:	48 89 df             	mov    %rbx,%rdi
  16:	88 44 24 18          	mov    %al,0x18(%rsp)
  1a:	e8 ec fc ff ff       	callq  0xfffffffffffffd0b
  1f:	84 c0                	test   %al,%al
  21:	75 09                	jne    0x2c
  23:	48 83 7b 08 00       	cmpq   $0x0,0x8(%rbx)
  28:	74 02                	je     0x2c
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  31:	65 48 2b 04 25 28 00 	sub    %gs:0x28,%rax
  38:	00 00 
  3a:	75 36                	jne    0x72
  3c:	48 83 c4 28          	add    $0x28,%rsp

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
   7:	65 48 2b 04 25 28 00 	sub    %gs:0x28,%rax
   e:	00 00 
  10:	75 36                	jne    0x48
  12:	48 83 c4 28          	add    $0x28,%rsp
[   16.361382][  T209] RSP: 0000:ffa0000007587da0 EFLAGS: 00010286
[   16.367302][  T209] RAX: 0000000000000000 RBX: ff11002000b56b00 RCX: 0000000000010101
[   16.375130][  T209] RDX: 0000000000010101 RSI: ff11002000b56b00 RDI: ff11002000b56b50
[   16.382955][  T209] RBP: ff11002000b57500 R08: 0000000000000101 R09: ffa0000007587da0
[   16.390782][  T209] R10: 0000000000000001 R11: 00000000c5672a10 R12: 0000000000000001
[   16.398608][  T209] R13: ff11001084311240 R14: 0000000000000020 R15: 0000000000000002
[   16.406433][  T209] FS:  0000000000000000(0000) GS:ff11001fffe00000(0000) knlGS:0000000000000000
[   16.415213][  T209] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.421650][  T209] CR2: 0000000000000000 CR3: 000000207de1c001 CR4: 0000000000771ef0
[   16.429477][  T209] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   16.437301][  T209] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   16.445128][  T209] PKRU: 55555554
[   16.448535][  T209] Call Trace:
[   16.451680][  T209]  <TASK>
[ 16.454479][ T209] ? __warn (kernel/panic.c:693) 
[ 16.458405][ T209] ? tmigr_connect_child_parent (kernel/time/timer_migration.c:1620 (discriminator 7)) 
[ 16.463980][ T209] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 16.468338][ T209] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 16.472523][ T209] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 16.477055][ T209] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 16.481936][ T209] ? tmigr_connect_child_parent (kernel/time/timer_migration.c:1620 (discriminator 7)) 
[ 16.487507][ T209] tmigr_setup_groups+0x1e6/0x430 
[ 16.492993][ T209] ? __pfx_tmigr_cpu_prepare (kernel/time/timer_migration.c:1727) 
[ 16.498305][ T209] tmigr_cpu_prepare (kernel/time/timer_migration.c:1721 kernel/time/timer_migration.c:1737) 
[ 16.502927][ T209] cpuhp_invoke_callback (kernel/cpu.c:194) 
[ 16.507980][ T209] ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
[ 16.513291][ T209] cpuhp_thread_fun (kernel/cpu.c:1092 (discriminator 1)) 
[ 16.517910][ T209] smpboot_thread_fn (kernel/smpboot.c:164) 
[ 16.522615][ T209] kthread (kernel/kthread.c:389) 
[ 16.526367][ T209] ? __pfx_kthread (kernel/kthread.c:342) 
[ 16.530814][ T209] ret_from_fork (arch/x86/kernel/process.c:147) 
[ 16.535088][ T209] ? __pfx_kthread (kernel/kthread.c:342) 
[ 16.539533][ T209] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   16.544153][  T209]  </TASK>
[   16.547039][  T209] ---[ end trace 0000000000000000 ]---
[   16.562459][    T1] Timer migration setup failed



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240710/202407101636.d9d4e8be-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


