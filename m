Return-Path: <linux-kernel+bounces-222297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D77C90FF5F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE7FDB26AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCB219A291;
	Thu, 20 Jun 2024 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeXz71j+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5333740858
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873214; cv=fail; b=B1HLDzGvozJZ1ybtlvIymUZB3Y3QVxKsDcKdjHmRfm0KxPx+7dzyUedyHc18WpJfxRqkP+folY4EKKjMhC3pujiYa34ZMHihzo8xJNxpg7F5XL6KNldXV7wVVhVbWkyn3EDEi7PVzRYFkgXVzX2jlCXws0GJyx9IevsJCeGRI4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873214; c=relaxed/simple;
	bh=GF/OQoXQPVu2roNthmBixq9Cuqf/nhokeP3B46wlGR0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=dZD7Ed5x8DOJ3VjR59bDVrDQ+k/U8A3HT2T2aKtSOeXzrXY9o1NLErQf7KJdyYHRXyfzX0zJeJBUcad1+2GuXa/PBDTqisj8HRIm2Bbi75EdIe1EwWLMlcYMTei4zvF9b5QfTTfiAiOpe6LpR/GzgEdiMbb4wPXTL/2W4hyuU/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeXz71j+; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718873211; x=1750409211;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GF/OQoXQPVu2roNthmBixq9Cuqf/nhokeP3B46wlGR0=;
  b=JeXz71j+1dWOC/n6pbBkttcqcc2cUTO8VMoVlJ3NkD+nLK1Kf1Oerd7y
   WJTlSsy7os0uZ27ACFoKCjwRcQB5zyiz0VN2Q0AQfJiWndxXTxWkycIbo
   eQgA7uZfN6EfzM6f6vMCofOaQ8LlUS9aq0//Jk1RAg9uJhUbAjb8vlvH4
   Z4kfEfC0fFA3VF/6jFa4/LAvBBUTgIbyyz/zF/g1DLe1nVl140WeH2GKj
   d4OxGx1wxh5/feOQENcD6FD4nQCibn2leKbyfoE6Nyddiz+hJYBzhjo6G
   YbAF4vX8JnzDzmWn7vwqBW4/0X+ZnVc7mcrc1abp9nR+yyPlwpamGXlVw
   g==;
X-CSE-ConnectionGUID: otfESOUwTxSILdr8hf2dkA==
X-CSE-MsgGUID: qJR/jGSfSt+q55Z9yh8BkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15955467"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15955467"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 01:46:51 -0700
X-CSE-ConnectionGUID: zoFHHua1SOyQSiIyjhEIdQ==
X-CSE-MsgGUID: uMuwPg0UTzC4BXFbvypJfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="42051444"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 01:46:51 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 01:46:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 01:46:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 01:46:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUypGu59FXuzyZiA3ghTLUrRfii3yh9UbN3+mMk7UyFVPpbIht4ACyA9HAyNVOx1/4udnjwl89uzSw4H23rYMcOqLH4BurxDw5yDh3vgNjw3VB7vs0vqaqVjrMwsaVI2aUaUvmHrLsXCU3msk+x3yd1xxRT5qGNX9+fRchOFTp7uO/oOQYDnVIQVrFMheF76s6H3IOZCimOfkUbBTSrm+KvWPOucYLWBFVOdaFJmQVL/O6ggP6roqaB3wLQVPWeSWyxXAtftruD/bWK/CRy2m7Bxcn7Ai4ZkWDMftRtTh7u0h35eipcBmrjBAGfmISLH5Mlr/oS3RG+wJxF/6tqVRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RG7rzCsz/a+MMdCUOjRvPUw2xwGUIJiuiO8XCJS/D4=;
 b=G4+W2xYOAc+Zfm7W87Pb7jj07i5j4aiOaAbABChI0C5DPxJfeErUbSL8wURIaH5PZtoJjfQc+uCr/wNB4mtJYQYdnWOyzB+eY5io4/sjM0Lj4tSgj/WYdLGv7lYKmysDIhTbzXkTNOHv9IDX7gsV9kkGS1ieeU/ZsxRv9veBebMAA9DweU7uBijG4CBD3aJW8a2l71VJuodDlgGN569z7mplHgfgDeC5Y879aVPuStkL7brxLQ9PNlP5evWlv8fvVPHYlIRkfanpqkLmK2cr5bUiZBfLByGuHwPEGHK0+yhFnKedFBu0SBpCuIE8P4CuyeWWZAnqN8ax/9Apfjs10w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8276.namprd11.prod.outlook.com (2603:10b6:510:1af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 20 Jun
 2024 08:46:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 08:46:47 +0000
Date: Thu, 20 Jun 2024 16:46:37 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [workqueue]  5df9197edd:
 BUG:soft_lockup-CPU##stuck_for#s![swapper:#]
Message-ID: <202406201623.d1a3b599-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: a465aead-6ea9-4b66-1165-08dc91058545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eo3cUeU7XPm0iXxJRQZDi5rqh0OAw/gQN0VT6NaYP/5FpEdMvrIeSBr1OKwH?=
 =?us-ascii?Q?DfaQCy2DzNektGdqWo3NOjYkFPPW0tpAPo/M3ySyOjnjXh1wEIRJCxZU5da+?=
 =?us-ascii?Q?K0Us6CIdoECvIeiff5oO6mV3yejEyV6q47Cms+sw0AVukXWhrjeLJ6JiVu+z?=
 =?us-ascii?Q?rNScRaeYvPZz6TQ9Ag7omn5WcYDM3uNFXWhMmynY3ePQcSyDl1WLcoz/WgUj?=
 =?us-ascii?Q?dX528xQ8AJaUa4zAMo2hv7Nfdnrd5pjNwmoW6RKri7JZ+txVQdZcB0FMkKwm?=
 =?us-ascii?Q?nPbluSAGzUfXbOga/FxWlFMwlG+FAF47ErxtTmfzQreRDvpxH51qoSw9Tdrx?=
 =?us-ascii?Q?tyvWk+qXzparOFFnAJx9MlP00yfWjRNPlQcFe5ipc3AeFy8w/+ydoXk8sLo0?=
 =?us-ascii?Q?hm6ZpiLeFmKkG/4Py5g4CjvCWcc+MnopZneObrYBd4gSmNNAu82EUXlPLAPG?=
 =?us-ascii?Q?VcuBbcdNAs9BZLovrNDWZ4OVHRnv1mgouk1jbYQWKxs1YOPJ4dPdIFxJwb11?=
 =?us-ascii?Q?bHTCMi9F16Di0ucmvzds08jZ6BBUZ1zZgK7MZ3VVbY37hSvHn6SsjFuFT1CU?=
 =?us-ascii?Q?V099Wz2vIQ5p7mK3ozY99OVGLTvrz/vwNwq6sGVPeyYHDTnMM0TuKa5Qm9kM?=
 =?us-ascii?Q?kDHkIcRvCWljA59AdHju2zNxMJaHMNkzzriH/3/j2sht4cILk4gzpf1R2tFU?=
 =?us-ascii?Q?Iwp5pvw39oibM4252vM4x16o/kvNb141isfLAId2E3UTt9Tmjtx1IzWIeagJ?=
 =?us-ascii?Q?jQ4eAGtSdyin9ytFatgEXJcnnK9MIiVKhvdGv7UKECnbyoNtY9qGOJK4D40d?=
 =?us-ascii?Q?R2IjlNTMEMRNuV9GwTcZ6akFp1EJ3JoOod0gHx4i/UNhwurdyGNkGVA/jbN7?=
 =?us-ascii?Q?WI2Kph83oxJh+xZzQcgP2Le+QlheGcLp6qa32g+4OZddhSHPzH2foDfHC0UC?=
 =?us-ascii?Q?kpGLVjhBffFIDQk2RbfmGLiZhMVzlVN7BVzDULhOPFvNl8sV/+P8pISNVlPG?=
 =?us-ascii?Q?3Viz65YniRz43iHBNFutUgcyy4yVRLOq7nRni0+pYipRPBc2P5XSfkybipaw?=
 =?us-ascii?Q?GqxIR+Al1C68XiqRcc4J1mHkaaomRR1ZhWhH9ciUk5enLJay7BvgH4J3iAfi?=
 =?us-ascii?Q?uh/twdd5+8yOqRkn9MyLRn9YLqBNerY3RbF9xdLNMbXMx0w0cnVnbdxkSXab?=
 =?us-ascii?Q?ChtTVAXHQAaeeOy7cQ0r7yFklQMbZJnK9CPY41A/xdz12n45cCKQ/Bnei3yg?=
 =?us-ascii?Q?UyAOavTWCjObJMsmbDcHwRBuJJt9r+k9sLfKlYNpmw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SKtY4HTdfuhw2KgPuQlQqsbBXEZbGnVrPUmGdeJ6lNXpf8yLUso/q+IJzcvl?=
 =?us-ascii?Q?WCePkK9ePAI4QKLEIfCKylv2cO1zU333LDPU0YhPY795Mn6xF2+Vq7h4qkhT?=
 =?us-ascii?Q?93LEGAGtTiCJB3z4qVkx+ClCkYIwHzFcnbnraxh6ZIMA2axRGx17Mslz0oBS?=
 =?us-ascii?Q?U0snZ8Ty2cf840wF2uFW0vdhbghw0JrShuyQQ9OToGknmjXXB+Fo2LCLyp/7?=
 =?us-ascii?Q?jqixjQYUvWORTMTKEPpQNOy3vsAcTgFlyON34OZB+WXRQTXVBovoR/49hBPy?=
 =?us-ascii?Q?voY11kRLzGpmCv6GV4KBYCWB5IKTY9iBnWWz7Ofv5sLc7hl3rWxs4YgPg/qC?=
 =?us-ascii?Q?lcS6kHkJnk4qZ3havfyp6X5xPdQwv8jPgdG7RQHFH+1G/2Vp7wj3ynwYpdVw?=
 =?us-ascii?Q?tytgwEnrAqcx0TfBOfuQKSf2K+Z4gEAvexlzwlbXdkVOWO1E5SBUX4gTsLVY?=
 =?us-ascii?Q?aIg4XzOLxuLo/saXoRSDyKE5E353Yhe602yFEDJ1Yq4ldoTwF4YvndBVZiU+?=
 =?us-ascii?Q?1xdyhqIa9jJ3prQ9mS5lypXgIA/ikXtccZg6c5ngRd1P/6wQtcr5CrNVU2Xs?=
 =?us-ascii?Q?mD0GHbvIOd5RF9hcEv7ujT3v88nrqkkQZ0Jtpzm3dObdwqgI7vjKKqORVH8h?=
 =?us-ascii?Q?H32CSCf3e4+AkFL61EqD6AL9NNTypoDlKI8I7esHaZmo3igPVNbqFnHJuerq?=
 =?us-ascii?Q?6QxHUasA1U0a9UkmogBE1MGa+uPxsdSDjgGNt7Fi6+dQ/C/EM2Qbgr2uyUDm?=
 =?us-ascii?Q?VLkS0cUWg9z20g8mwthtuySmQ4qZQ6wzszVhf+lltFrfF5tk2tHnHN7Xpvnr?=
 =?us-ascii?Q?A7FxSoNAnWeQchPvenscIzSWuk3F0liPFEfmC3ueILqS0Hm5aRBM8T/saZmf?=
 =?us-ascii?Q?xOr4BY1JLI4LD37ziiQ73XVN72oziY5Cg1UYFBuW4OXuc5EBUtbaeWuJSdGM?=
 =?us-ascii?Q?UTOs0LJmWyj3RadRA2NHAfBoFtHwHqrNpi62oSbSUrFIi0MFzcUQBDfB96V7?=
 =?us-ascii?Q?5eIBouz0WX+yFk/1IP6iLrm9YE3DaO34GOfHDJWihIQzrcAkHsD9zZfhrVq4?=
 =?us-ascii?Q?foQXF+jdNBckuxnOy1u2wVHK8GFGYxzrBR/KxaZWCFYEA/M867TDF6+kv8hc?=
 =?us-ascii?Q?7+nZtf8jAaiTeN0zVl+WUqm6MuOeNN08H+PJQzQycPrwLs8pYPvjKSgcKLK9?=
 =?us-ascii?Q?6Be0Nfm2NtmbXV9BhKF70eN6xGeiuOR9UGjFZjUzBCud0M0jFx2QquU6yCeg?=
 =?us-ascii?Q?oWhGKMR3cIEUXEc0xgcBi9ifmHwKyJ6drNPanyK/vVlOv+cOpiPWA+JCDpgl?=
 =?us-ascii?Q?lB8mU/nzAewC5LZ7FUxG4CpVmBH/a6nVegMtIKcE35wcWRx5lKEX1uDo4tp7?=
 =?us-ascii?Q?lO3dlbIgs49vfV5miW9Hs/efhprWeM0+JulCobXWgLpMeiLIVyjHtvUWlOvR?=
 =?us-ascii?Q?OVutlozINE+AamFJ+kB995z6bT/4h8ycayx3G20+1yyfZC27JLhdsHH+AoyJ?=
 =?us-ascii?Q?+WSraB82XmKJDP255+996jiZvcycWFzHEfai9gzaL8PWkepBiTaxl6zasCaq?=
 =?us-ascii?Q?YMo7zaECten+/Ialqn6rUFreM7//cvhdvR1I5/J+E5TqLd0gLvJ/zCbRJsL6?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a465aead-6ea9-4b66-1165-08dc91058545
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 08:46:47.8139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrMwEiqteWn+KWeu89/MAqp6uZcheE1rKiwaoVwbtIMICh8SPqrxrild2pNsX0EyoHuHtD10dUP3O34yX9+hGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8276
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![swapper:#]" on:

commit: 5df9197edd731a44682444631d68c2384f381bf1 ("workqueue: make wq_subsys const")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      d20f6b3d747c36889b7ce75ee369182af3decb6b]
[test failed on linux-next/master 6906a84c482f098d31486df8dc98cead21cce2d0]

in testcase: boot

compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


we don't have enough knowledge why this commit could cause random issues,
while the parent keeps clean even when we run both till 999 times.

=========================================================================================
compiler/kconfig/rootfs/sleep/tbox_group/testcase:
  gcc-13/i386-randconfig-r015-20211011/debian-11.1-i386-20220923.cgz/1/vm-snb/boot

f297a3844aa059c5 5df9197edd731a44682444631d6
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :999          6%          56:999   dmesg.BUG:kernel_hang_in_boot_stage
           :999          1%           8:999   dmesg.BUG:kernel_hang_in_test_stage
           :999          0%           1:999   dmesg.BUG:soft_lockup-CPU##stuck_for#s![kcompactd0:#]
           :999          0%           3:999   dmesg.BUG:soft_lockup-CPU##stuck_for#s![kworker##:#]
           :999          9%          89:999   dmesg.BUG:soft_lockup-CPU##stuck_for#s![swapper:#]
           :999         10%         102:999   dmesg.BUG:workqueue_lockup-pool
           :999          1%           7:999   dmesg.EIP:__do_softirq
           :999          0%           1:999   dmesg.EIP:__down_trylock_console_sem
           :999          1%          10:999   dmesg.EIP:_raw_spin_unlock_irq
           :999          0%           3:999   dmesg.EIP:_raw_spin_unlock_irqrestore
           :999          0%           2:999   dmesg.EIP:console_flush_all
           :999          0%           1:999   dmesg.EIP:console_unlock
           :999          1%           7:999   dmesg.EIP:lock_acquire
           :999          1%           7:999   dmesg.EIP:lock_release
           :999          1%          12:999   dmesg.EIP:raw_spin_rq_unlock_irq
           :999          0%           1:999   dmesg.EIP:rcu_check_gp_start_stall
           :999          0%           2:999   dmesg.EIP:seqcount_lockdep_reader_access
           :999          0%           1:999   dmesg.EIP:tcp_orphan_update
           :999          9%          88:999   dmesg.EIP:tick_clock_notify
           :999          0%           1:999   dmesg.EIP:vprintk_store
           :999          0%           1:999   dmesg.EIP:vsnprintf
           :999          2%          15:999   dmesg.INFO:rcu_preempt_detected_stalls_on_CPUs/tasks
           :999          0%           3:999   dmesg.INFO:rcu_preempt_self-detected_stall_on_CPU
           :999          3%          29:999   dmesg.INFO:task_blocked_for_more_than#seconds
           :999          2%          16:999   dmesg.IP-Config:Auto-configuration_of_network_failed
           :999          3%          29:999   dmesg.Kernel_panic-not_syncing:hung_task:blocked_tasks
           :999          9%          93:999   dmesg.Kernel_panic-not_syncing:softlockup:hung_tasks
           :999          0%           1:999   dmesg.WARNING:at_kernel/rcu/tree_stall.h:#rcu_check_gp_start_stall

one hint we could supply is the config for this test is a randconfig which is
uploaded to [1]

at the same time, we also tried another config as attached
  not-reproduce-config-6.8.0-rc2-00006-g5df9197edd73

both parent/this commit seem clean in the tests for this config.

=========================================================================================
compiler/kconfig/rootfs/sleep/tbox_group/testcase:
  gcc-13/i386-debian-10.3-func/debian-11.1-i386-20220923.cgz/1/vm-snb/boot

f297a3844aa059c5 5df9197edd731a44682444631d6
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
        999:999          0%         999:999   pass


but since the diff between two configs are very big, it's hard for us to
supply further information.

just made this report FYI what we observed in our tests.
if you have any debug patch want us to test, please let us know. Thanks


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406201623.d1a3b599-lkp@intel.com


[  696.522062][    C0] watchdog: BUG: soft lockup - CPU#0 stuck for 626s! [swapper:1]
[  696.522062][    C0] Modules linked in:
[  696.522062][    C0] irq event stamp: 110942
[ 696.522062][ C0] hardirqs last enabled at (110941): timekeeping_notify (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 include/linux/stop_machine.h:154 include/linux/stop_machine.h:161 kernel/time/timekeeping.c:1506) 
[ 696.522062][ C0] hardirqs last disabled at (110942): sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1076) 
[ 696.522062][ C0] softirqs last enabled at (110790): __do_softirq (arch/x86/include/asm/preempt.h:26 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 696.522062][ C0] softirqs last disabled at (110779): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[  696.522062][    C0] CPU: 0 PID: 1 Comm: swapper Not tainted 6.8.0-rc2-00006-g5df9197edd73 #1
[ 696.522062][ C0] EIP: tick_clock_notify (arch/x86/include/asm/bitops.h:55 include/asm-generic/bitops/instrumented-atomic.h:29 kernel/time/tick-sched.c:1607) 
[ 696.522062][ C0] Code: 15 d4 1b 8e 98 8b 45 e4 8b 55 e8 a3 d8 1b 8e 98 89 15 dc 1b 8e 98 89 35 c0 1b 8e 98 89 1d c4 1b 8e 98 83 c4 10 5b 5e 5f 5d c3 <80> 0d e4 1b 8e 98 01 c3 80 0d e4 1b 8e 98 01 c3 0f ba 35 e4 1b 8e
All code
========
   0:	15 d4 1b 8e 98       	adc    $0x988e1bd4,%eax
   5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   8:	8b 55 e8             	mov    -0x18(%rbp),%edx
   b:	a3 d8 1b 8e 98 89 15 	movabs %eax,0x1bdc1589988e1bd8
  12:	dc 1b 
  14:	8e 98 89 35 c0 1b    	mov    0x1bc03589(%rax),%ds
  1a:	8e 98 89 1d c4 1b    	mov    0x1bc41d89(%rax),%ds
  20:	8e 98 83 c4 10 5b    	mov    0x5b10c483(%rax),%ds
  26:	5e                   	pop    %rsi
  27:	5f                   	pop    %rdi
  28:	5d                   	pop    %rbp
  29:	c3                   	ret
  2a:*	80 0d e4 1b 8e 98 01 	orb    $0x1,-0x6771e41c(%rip)        # 0xffffffff988e1c15		<-- trapping instruction
  31:	c3                   	ret
  32:	80 0d e4 1b 8e 98 01 	orb    $0x1,-0x6771e41c(%rip)        # 0xffffffff988e1c1d
  39:	c3                   	ret
  3a:	0f                   	.byte 0xf
  3b:	ba 35 e4 1b 8e       	mov    $0x8e1be435,%edx

Code starting with the faulting instruction
===========================================
   0:	80 0d e4 1b 8e 98 01 	orb    $0x1,-0x6771e41c(%rip)        # 0xffffffff988e1beb
   7:	c3                   	ret
   8:	80 0d e4 1b 8e 98 01 	orb    $0x1,-0x6771e41c(%rip)        # 0xffffffff988e1bf3
   f:	c3                   	ret
  10:	0f                   	.byte 0xf
  11:	ba 35 e4 1b 8e       	mov    $0x8e1be435,%edx
[  696.522062][    C0] EAX: 0001b15d EBX: 984678a0 ECX: 00000006 EDX: 83f6d220
[  696.522062][    C0] ESI: 988e0820 EDI: 00000001 EBP: 82d17ed8 ESP: 82d17ec0
[  696.522062][    C0] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00000202
[  696.522062][    C0] CR0: 80050033 CR2: ffda9000 CR3: 18c90000 CR4: 000406d0
[  696.522062][    C0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  696.522062][    C0] DR6: fffe0ff0 DR7: 00000400
[  696.522062][    C0] Call Trace:
[ 696.522062][ C0] ? show_regs (arch/x86/kernel/dumpstack.c:478 (discriminator 1)) 
[ 696.522062][ C0] ? watchdog_timer_fn (kernel/watchdog.c:545) 
[ 696.522062][ C0] ? __hrtimer_run_queues+0x10b/0x196 
[ 696.522062][ C0] ? schedule_work (drivers/usb/core/hub.c:890) 
[ 696.522062][ C0] ? hrtimer_run_queues (kernel/time/hrtimer.c:1928) 
[ 696.522062][ C0] ? update_process_times (kernel/time/timer.c:2065 (discriminator 2) kernel/time/timer.c:2086 (discriminator 2)) 
[ 696.522062][ C0] ? tick_periodic+0xb0/0xb2 
[ 696.522062][ C0] ? tick_handle_periodic (kernel/time/tick-common.c:145) 
[ 696.522062][ C0] ? sysvec_hyperv_stimer0 (arch/x86/kernel/apic/apic.c:1076) 
[ 696.522062][ C0] ? __sysvec_apic_timer_interrupt (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1083) 
[ 696.522062][ C0] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1076 (discriminator 4)) 
[ 696.522062][ C0] ? handle_exception (arch/x86/entry/entry_32.S:1056) 
[ 696.522062][ C0] ? sysvec_hyperv_stimer0 (arch/x86/kernel/apic/apic.c:1076) 
[ 696.522062][ C0] ? tick_cancel_sched_timer (arch/x86/include/asm/bitops.h:55 include/asm-generic/bitops/instrumented-atomic.h:29 kernel/time/tick-sched.c:1607) 
[ 696.522062][ C0] ? sysvec_hyperv_stimer0 (arch/x86/kernel/apic/apic.c:1076) 
[ 696.522062][ C0] ? tick_cancel_sched_timer (arch/x86/include/asm/bitops.h:55 include/asm-generic/bitops/instrumented-atomic.h:29 kernel/time/tick-sched.c:1607) 
[ 696.522062][ C0] ? timekeeping_notify (kernel/time/timekeeping.c:1508) 
[ 696.522062][ C0] __clocksource_select (kernel/time/clocksource.c:1047 (discriminator 1)) 
[ 696.522062][ C0] ? boot_override_clock (kernel/time/clocksource.c:1079) 
[ 696.522062][ C0] clocksource_select (kernel/time/clocksource.c:1064) 
[ 696.522062][ C0] clocksource_done_booting (kernel/time/clocksource.c:1088) 
[ 696.522062][ C0] do_one_initcall (init/main.c:1236) 
[ 696.522062][ C0] ? parse_args (kernel/params.c:168) 
[ 696.522062][ C0] do_initcalls (init/main.c:1297 (discriminator 3) init/main.c:1314 (discriminator 3)) 
[ 696.522062][ C0] ? rest_init (init/main.c:1433) 
[ 696.522062][ C0] kernel_init_freeable (init/main.c:1553) 
[ 696.522062][ C0] kernel_init (init/main.c:1443) 
[ 696.522062][ C0] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 696.522062][ C0] ? rest_init (init/main.c:1433) 
[ 696.522062][ C0] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 696.522062][ C0] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[  696.522062][    C0] Kernel panic - not syncing: softlockup: hung tasks
[  696.522062][    C0] CPU: 0 PID: 1 Comm: swapper Tainted: G             L     6.8.0-rc2-00006-g5df9197edd73 #1
[  696.522062][    C0] Call Trace:
[ 696.522062][ C0] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 696.522062][ C0] dump_stack (lib/dump_stack.c:114) 
[ 696.522062][ C0] panic (kernel/panic.c:362) 
[ 696.522062][ C0] watchdog_timer_fn (kernel/watchdog.c:519) 
[ 696.522062][ C0] __hrtimer_run_queues+0x10b/0x196 
[ 696.522062][ C0] ? schedule_work (drivers/usb/core/hub.c:890) 
[ 696.522062][ C0] hrtimer_run_queues (kernel/time/hrtimer.c:1928) 
[ 696.522062][ C0] update_process_times (kernel/time/timer.c:2065 (discriminator 2) kernel/time/timer.c:2086 (discriminator 2)) 
[ 696.522062][ C0] tick_periodic+0xb0/0xb2 
[ 696.522062][ C0] tick_handle_periodic (kernel/time/tick-common.c:145) 
[ 696.522062][ C0] ? sysvec_hyperv_stimer0 (arch/x86/kernel/apic/apic.c:1076) 
[ 696.522062][ C0] __sysvec_apic_timer_interrupt (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1083) 
[ 696.522062][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1076 (discriminator 4)) 
[ 696.522062][ C0] handle_exception (arch/x86/entry/entry_32.S:1056) 
[ 696.522062][ C0] EIP: tick_clock_notify (arch/x86/include/asm/bitops.h:55 include/asm-generic/bitops/instrumented-atomic.h:29 kernel/time/tick-sched.c:1607) 
[ 696.522062][ C0] Code: 15 d4 1b 8e 98 8b 45 e4 8b 55 e8 a3 d8 1b 8e 98 89 15 dc 1b 8e 98 89 35 c0 1b 8e 98 89 1d c4 1b 8e 98 83 c4 10 5b 5e 5f 5d c3 <80> 0d e4 1b 8e 98 01 c3 80 0d e4 1b 8e 98 01 c3 0f ba 35 e4 1b 8e
All code
========
   0:	15 d4 1b 8e 98       	adc    $0x988e1bd4,%eax
   5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   8:	8b 55 e8             	mov    -0x18(%rbp),%edx
   b:	a3 d8 1b 8e 98 89 15 	movabs %eax,0x1bdc1589988e1bd8
  12:	dc 1b 
  14:	8e 98 89 35 c0 1b    	mov    0x1bc03589(%rax),%ds
  1a:	8e 98 89 1d c4 1b    	mov    0x1bc41d89(%rax),%ds
  20:	8e 98 83 c4 10 5b    	mov    0x5b10c483(%rax),%ds
  26:	5e                   	pop    %rsi
  27:	5f                   	pop    %rdi
  28:	5d                   	pop    %rbp
  29:	c3                   	ret
  2a:*	80 0d e4 1b 8e 98 01 	orb    $0x1,-0x6771e41c(%rip)        # 0xffffffff988e1c15		<-- trapping instruction
  31:	c3                   	ret
  32:	80 0d e4 1b 8e 98 01 	orb    $0x1,-0x6771e41c(%rip)        # 0xffffffff988e1c1d
  39:	c3                   	ret
  3a:	0f                   	.byte 0xf
  3b:	ba 35 e4 1b 8e       	mov    $0x8e1be435,%edx

Code starting with the faulting instruction
===========================================
   0:	80 0d e4 1b 8e 98 01 	orb    $0x1,-0x6771e41c(%rip)        # 0xffffffff988e1beb
   7:	c3                   	ret
   8:	80 0d e4 1b 8e 98 01 	orb    $0x1,-0x6771e41c(%rip)        # 0xffffffff988e1bf3
   f:	c3                   	ret
  10:	0f                   	.byte 0xf
  11:	ba 35 e4 1b 8e       	mov    $0x8e1be435,%edx


[1]
The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240620/202406201623.d1a3b599-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


