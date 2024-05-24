Return-Path: <linux-kernel+bounces-188471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55C08CE26B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62FC1C216CE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8F8128829;
	Fri, 24 May 2024 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fk5J5e1P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E689A839F1
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716539806; cv=fail; b=qL8rn9Hinly5D0Tnt43GN0YWVUE1cxgAmjRHvJhiYsieeaKsZrij9zUrym+O4B7xon1wYNWZKr+aYX0vqcYe1Dzw2vI1UVrGBzshZtrRNKYKIhbajpH6SHqQUn0nVmzjpkzFZY1FDYrPRpIXazeuldySWBtlyiZA/Kgb8uw9ssU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716539806; c=relaxed/simple;
	bh=GDGk9SDBA4/JFq5A0mothzbbDERlmoCObhaHidTfc4o=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=X+hRC2E79W/mHiCx8NJVMHgYQbKOXZFEJtd1LFU1vWAaJDnWFiOCJiDrUk6fZKcroULJ+26ePs4+aOdeHLrZebPpxUnjjfxg8AxfGcERSkz2DWJ3e+HjpXbPCYJrkidC0jY11XhojPgNoD34f9X1oXiVwJyBMyQnbgdvnH5yr3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fk5J5e1P; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716539804; x=1748075804;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GDGk9SDBA4/JFq5A0mothzbbDERlmoCObhaHidTfc4o=;
  b=fk5J5e1PBcMKcbzlHIkIW0M5f8CXMMeXCX2CtqA38dPbD1l244FucMXg
   k3Yjxaw95m7Xwh7f/q7xddzEilZwXBPU9KSHKlL5FqmrZv6aGD2XT66nO
   FCu9amP5J/xTRdDEMERepI4LPisXnyhN+sA1hL14Tvu+rtn0PCHBbbIUD
   XgAx6umKyOVI08jz6o9ewGv1zOd1Upwzhg86JBgX0Dm0nnoVGwx26d2bv
   Wp6G81FzlGCf/0G6QelkzyP36B3WeAIxaU7tf/hgnlbjfvmAnmfi3K+ek
   P/NExTyICdf2ArjzPK1Q4vwOnc7gzN3JjX/z/RCJT9kOxlH9JfIQDF2iS
   A==;
X-CSE-ConnectionGUID: Tavs5GruQOq9YUX5z53PLQ==
X-CSE-MsgGUID: D5U9wVEySnK30cl5w9PkXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="23575875"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="23575875"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 01:36:43 -0700
X-CSE-ConnectionGUID: xhrlgKc7SD26C1o0QOUPsg==
X-CSE-MsgGUID: MZcNJOOATwSm2rDzh28HsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="34557379"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 May 2024 01:36:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 01:36:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 24 May 2024 01:36:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 01:36:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mr55je7mn023mWOvGjTmHCgi03Og0oS3GKj4CvJkIXTnlEJv56fCfreTkf+W3DQ2zuQm99T9RJHHWbuUhFgjznUy9ku4nsHsDajISViFmPqP320SsvqbKPX/M33fzBLrnhsCVbNKUaIR6lhIWI0DS60qdXEadBnrqAPuGPAtBUVPRVRfWWmX9V/Brr4+01tHGAGZ1DDQP/z0XlmEQcNFLMPPI+kvQX8iAZr850+ms1cv6ienQabn4TYGfwnB8pk1Xxs5rV3sGl5IGsMUZtO/JQq+eC/nIU3as+it1/UZXRUMT4VEppMPaRnQdo0EtVGglFUF1P4e4c2wzrNykzZNkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JHi41D7ZAHSN1Hmh8h0yDnbAmWlL0jOS89li9PkzlU=;
 b=WNNf+8+BOoK1Nozg0Hb5DTwhxvtzZFfORgPdyF97IEJeIvLJtqp9IIrJe7DblyHgoEr+fFRhkZjiRXjIeel7ValFFMbhDEncE+yagQGpA1enIInBpDwK/t1iSJayl30BukglvJZClhaFrKXGzGBReP+FRRcwF+Evpw1y/W6v7MYaltunBHVgNp77PFcoP5QzkuBsVSPU5jIRlsNez3Jqq35XNGOa7gMUbY6l1lsT1Goz4xBYU7bowjq8e/6Iz2TBhKf0QnI6B9kzL7eN1jaJDZhH5akHtHbasfpGyP8gbOPzFwNCwa3rw4gj7snO8RBqfJ83ctp+NQRhKWBWsuNwmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB7301.namprd11.prod.outlook.com (2603:10b6:8:10a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 08:36:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 08:36:34 +0000
Date: Fri, 24 May 2024 16:36:25 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, <oliver.sang@intel.com>
Subject: [linus:master] [timekeeping]  e84f43e34f:
 BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns
Message-ID: <202405241607.d3fd7eb0-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:820:f::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ad20a7-7e43-45d6-5a46-08dc7bcc9e41
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MyJGAX66818jqTDADC/6edFib5DxjzH+hhKIT/RjGl5kdPZO/BsVbBa3Zto2?=
 =?us-ascii?Q?6KtzDtpgsCerIz3YI8elVB9DAz01/JgIbSFM2YbjsCVnWt2l6A0dc18Zm5Fm?=
 =?us-ascii?Q?r9j7fQYPur73JPyWf+f3HK9lHnUyXOLOjKLleatGEeqmPWFcQ89GQllBmiac?=
 =?us-ascii?Q?ZIQaHCd8+FpGA/uVlZ02pU8hKHEOl229oR83g4aLwTnjaRV2yrG+HkOaiT7c?=
 =?us-ascii?Q?05ffJwqFE7kp4d6MuCKesrOQj/KPfdnO+EE3Qh34jJGLYUF+mgLspoD6juta?=
 =?us-ascii?Q?MEBtlP7jsStbuOnrOGjEUh33ThUH8TGLiQ+mjMgkuOMBoQ3GWXoauWtj9WK2?=
 =?us-ascii?Q?ggGKGMzvENrozMUalyhy/n9OUCBvaU2CleTlGIc+I4dfH65rgbkCylCmoF1i?=
 =?us-ascii?Q?Wznn/bGPTnhQOk9VRHzW0J/SLmLRWyjt1ABqw0hp3YA/B3oq3V/mimdziDji?=
 =?us-ascii?Q?eB3F9306npnKPRGJ656DI5+zsv7NXlN7MShB7VHPDerduHtnHmNbne2naDsA?=
 =?us-ascii?Q?5GJhqXsRq8+Nu7ppf3t+6vx62FpWFhJJ/w1MEA78NWYc5QyjYh5azZAx0GeO?=
 =?us-ascii?Q?91YmyVmYYY9otklrIld8/T8ONfb63dliOxTyqh9Ke0d4mG+PoTLGkXYubkBA?=
 =?us-ascii?Q?HzkYl7iwLPqkoY3Z/X91oLXZBpTKF2WgkdkeXbJA8eZUXQ3kQXP7CXKGzb5+?=
 =?us-ascii?Q?PsZlNAH9ZHq8j06o+pp+1GmYOpHdLVUOfnqTgeaeMD+bjk9pLXR8n8hiRPcc?=
 =?us-ascii?Q?BpZfwHikFCCeokzWF6zPLl4JWoj98Fgro3MiS9YWljFflHShhXG3l7jtHg9g?=
 =?us-ascii?Q?d9RAzWeYfMPcFygapcx5srcVcC0bcoYufVP2bmxJjCpDf6N+mlnJEjRj2Y4W?=
 =?us-ascii?Q?+EMgJobyzG4rNIyKyAJYppmJj5ZkGctccoCuD/0HYzxTPzzI6xsqkz+cwPdN?=
 =?us-ascii?Q?hsLfIu+97HkFbVmOCf2QgtckrKQ2hVRPyPdVSv2PY+G5h3o7kTbIcQANrCRO?=
 =?us-ascii?Q?ZVmEI4L4lMYg6joAKsX8OYptiBFCjnj5iIgeGizp65OZgk2SdBC6EcCMFc3v?=
 =?us-ascii?Q?rcm2sqtbgHmF+NHHRNxCWtEbWqvU15GmeHtlnfjOzivsnrTWCkkhgENzmZ7T?=
 =?us-ascii?Q?8bWFKaz3Kc7RCMUNA+kOwLxpX9vDb3VPiFeFdnhyfzkWCgsLthajzYShEBmC?=
 =?us-ascii?Q?nkTLlnfFmhWbVSzPK4e4tRQDQbrltISafFM01E/to2QLhA808J1VCG0FYvc?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5tdrr9DewW78uCUdhPfqBPMtzuBYVeeyR8QK/3RpVG3LlE/7o0be30gr2xfT?=
 =?us-ascii?Q?uQUS/4h3YNLAv7VEqMbjeXpVVVJfexHydIsV+w7LEnIPQCzFTL7BwXbdgHuo?=
 =?us-ascii?Q?pPe3SxO4kf87j6lTOz24RKgFuu0CgBXOeUYG20ehVo1PcLObTUQLNLZlxHEj?=
 =?us-ascii?Q?5mhvIZMWB1jhgHms4qen67ZesBypHegq5cfFrHhf8XPhFkXJwbgyDIUY97dg?=
 =?us-ascii?Q?kz52Qvw70kQFcWm661qunAOrBM1HBNzAD4RmMYvR7cZ5Mu4egfcTLVDCOQuh?=
 =?us-ascii?Q?VPeXzoEV0brxCLbXIrvjb91H1Tatz0LNzlkBxBMLDOJnDS1JW+cJiOKvmtaR?=
 =?us-ascii?Q?xHsLZDdMsbvmJ0s+G3UfjgpqEzpnCkU1vKLuMKV6qzyxTqpK/EIMNEGGTU2E?=
 =?us-ascii?Q?7wRhjWjP2VKUAGtKROlZKjCi1SNnmnpia7SYwGkRiN8GYxlSt0RVbflAtXGu?=
 =?us-ascii?Q?MAU6FX7iamRQjkREJWnoHzglofspjxCnH3MYB4yfUOU6idL5GoLwGC9q2LZl?=
 =?us-ascii?Q?DGC+TLhoyj8uTAvFx8Y/rpxZBccGCW+zB6TayotojUuYch5rhJK7SfNWpOl0?=
 =?us-ascii?Q?MJnoaPe/XPjEhIaSAvekuegnQnKF/ShR+91hWY9CqWJkZZ0aVB3lgeaTqpzi?=
 =?us-ascii?Q?0dW9C6CTH0xYqgPVCl65Lj7USmTsp5MQe41y87U2hAs8xK7oxDzWvgReTAPj?=
 =?us-ascii?Q?FzHy+iidmp4Lk63X7PYpQ9syk4EEzHoGCDx2xVXx9392Pz5bx1cL7S4yqEHg?=
 =?us-ascii?Q?sqsT3/2t3CNSGSx/fnPBYrlFKysmhQYaNIc8MuSziFtVwk/0CGJKg7AQTbOu?=
 =?us-ascii?Q?Vr3S8CF9W7SfIF2BmsJgIwxeLDW5iw+ImffYnEuqS5XXBsNfXAy3MuSbvoGh?=
 =?us-ascii?Q?h88T8nq+ygXYVUYGJHxr+Fn18JtTjNyh8mz5DfvHLx73qyeMMiu3NqcBzO+N?=
 =?us-ascii?Q?tYYsNRJPD9d6eDiftLCiFnZRhRtgU4v4ekWEYqKOybm43wVr31BWkFxB9yMW?=
 =?us-ascii?Q?NCfdghlm8OQCkEHqJNj1d2daOpnTh4fY/E/Z8AnNGdnO1p/qMpNN2m9F+qeX?=
 =?us-ascii?Q?SUp7ZvGh12ngQITUKsGwGwROf+gLeA9aV3fIjPpLDriTWuTd2Cce1WX3uoME?=
 =?us-ascii?Q?MFJBmvjj9GAEzUo7EEWpL2EJGHiloCP2NgzCYEHcPvOZPOSzn4NvUCfFDRLw?=
 =?us-ascii?Q?2vJqBT9Sway6GvzobQv3ZmIalShACFsWmcvlpSIyG8uD9phsqheyKrqICNkb?=
 =?us-ascii?Q?Bfmk9vqQKk0O3FFUlcTM4yuvr1QYZQmpxp+pBQKDlvqu2Jiqhu70FUGCyS1K?=
 =?us-ascii?Q?/zRUajLt18qwrmU1ZZBuCh/gsjjHg1sU6gw0Z0sxfDDLM2zeRhLk+3cHuYVt?=
 =?us-ascii?Q?pBMDKtgP3IvlghZ7MOhRJT69WFodx2ip+QZfVCECmnb2iVVph+8/e+17l9Xi?=
 =?us-ascii?Q?BfvI+FUfa26G09MxEj+81MVRSeZyI0Rq9z7BRuAFPBXAy+eDWzYozebZbk1v?=
 =?us-ascii?Q?OyxF9UTvA+g2dP9sZrqJRohV4VopS4VTVnOdyR5TrfU0avAEdq3cmuX0dh/R?=
 =?us-ascii?Q?DC+snPfsXIXlWMhguMPZRZ967GRYRSvyku99EaambVd473j6OZSYkdfmMxSR?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ad20a7-7e43-45d6-5a46-08dc7bcc9e41
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 08:36:34.1683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIfUlPZia2gTp9oeYWcYrkIY6CY+AsRvw9iXNYeLrc1i5fykOouFdnZnFvs6zLftgtQFgLjRIT5v3d8rs401kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7301
X-OriginatorOrg: intel.com


hi Adrian Hunter,

we sent the similar report
  "[tip:timers/core] [timekeeping]  e84f43e34f: BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns"
when this commit is in tip:timers/core [1]

we noticed you made some comments, but we don't have enough knowledge it there
will be or need some fix.

now the commit is in mainline now, we just report again FYI.

similar as mentioned in [1], we only observed the
  dmesg.BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns
upon e84f43e34f at the ~50% rate.

but parent has other KCSAN issues (also ~50% rate) which doesn't happen on
e84f43e34f.

e8e9d21a5df655a6 e84f43e34faf85816587f805945
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          9:20         -45%            :20    dmesg.BUG:KCSAN:data-race_in_ktime_get/timekeeping_advance
          9:20         -45%            :20    dmesg.BUG:KCSAN:data-race_in_ktime_get_update_offsets_now/timekeeping_advance
           :20          55%          11:20    dmesg.BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns


[1] https://lore.kernel.org/all/202404161050.38f1c92e-lkp@intel.com/


below is the full report.


Hello,

kernel test robot noticed "BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns" on:

commit: e84f43e34faf85816587f80594541ec978449d6e ("timekeeping: Consolidate timekeeping helpers")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      0450d2083be6bdcd18c9535ac50c55266499b2df]
[test failed on linux-next/master c75962170e49f24399141276ae119e6a879f36dc]

in testcase: boot

compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405241607.d3fd7eb0-lkp@intel.com


[  106.344081][    C0] BUG: KCSAN: data-race in timekeeping_advance / timekeeping_debug_get_ns
[  106.345565][    C0]
[  106.346110][    C0] write to 0xffffffff83dfe578 of 296 bytes by interrupt on cpu 1:
[ 106.347495][ C0] timekeeping_advance (kernel/time/timekeeping.c:2207 (discriminator 1)) 
[ 106.348455][ C0] update_wall_time (kernel/time/timekeeping.c:2222 (discriminator 1)) 
[ 106.349310][ C0] tick_do_update_jiffies64 (kernel/time/tick-sched.c:149) 
[ 106.350321][ C0] tick_nohz_lowres_handler (kernel/time/tick-sched.c:229 kernel/time/tick-sched.c:287 kernel/time/tick-sched.c:1492) 
[ 106.351343][ C0] __sysvec_apic_timer_interrupt (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1050) 
[ 106.352397][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 (discriminator 47) arch/x86/kernel/apic/apic.c:1043 (discriminator 47)) 
[ 106.353427][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 106.354479][ C0] _raw_spin_unlock_irqrestore (arch/x86/include/asm/preempt.h:94 (discriminator 1) include/linux/spinlock_api_smp.h:152 (discriminator 1) kernel/locking/spinlock.c:194 (discriminator 1)) 
[ 106.355503][ C0] get_partial_node+0xaf/0x300 
[ 106.356480][ C0] get_partial (mm/slub.c:2702) 
[ 106.357291][ C0] ___slab_alloc (mm/slub.c:3506) 
[ 106.358162][ C0] kmem_cache_alloc (mm/slub.c:3610 mm/slub.c:3663 mm/slub.c:3835 mm/slub.c:3852) 
[ 106.359084][ C0] getname_flags (fs/namei.c:140 (discriminator 1)) 
[ 106.359916][ C0] getname (fs/namei.c:219) 
[ 106.360669][ C0] do_sys_openat2 (fs/open.c:1400) 
[ 106.361540][ C0] __ia32_compat_sys_openat (fs/open.c:1479) 
[ 106.362526][ C0] __do_fast_syscall_32 (arch/x86/entry/common.c:165 (discriminator 1) arch/x86/entry/common.c:321 (discriminator 1)) 
[ 106.363487][ C0] do_fast_syscall_32 (arch/x86/entry/common.c:346 (discriminator 1)) 
[ 106.364392][ C0] do_SYSENTER_32 (arch/x86/entry/common.c:385) 
[ 106.365229][ C0] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:121) 
[  106.366347][    C0]
[  106.366895][    C0] read to 0xffffffff83dfe598 of 8 bytes by interrupt on cpu 0:
[ 106.368257][ C0] timekeeping_debug_get_ns (kernel/time/timekeeping.c:373 kernel/time/timekeeping.c:383 kernel/time/timekeeping.c:280) 
[ 106.369256][ C0] ktime_get (kernel/time/timekeeping.c:394 kernel/time/timekeeping.c:838) 
[ 106.370061][ C0] tick_nohz_lowres_handler (kernel/time/tick-sched.c:220 kernel/time/tick-sched.c:287 kernel/time/tick-sched.c:1492) 
[ 106.371062][ C0] __sysvec_apic_timer_interrupt (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1050) 
[ 106.372099][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 (discriminator 47) arch/x86/kernel/apic/apic.c:1043 (discriminator 47)) 
[ 106.373091][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 106.374155][ C0] __tsan_read8 (kernel/kcsan/core.c:787 (discriminator 1) kernel/kcsan/core.c:1025 (discriminator 1)) 
[ 106.375033][ C0] __d_lookup_rcu (fs/dcache.c:2172) 
[ 106.375897][ C0] d_alloc_parallel (fs/dcache.c:2473) 
[ 106.376807][ C0] lookup_open+0x5f1/0x8a0 
[ 106.377759][ C0] open_last_lookups (fs/namei.c:3566) 
[ 106.378687][ C0] path_openat (fs/namei.c:3796) 
[ 106.379520][ C0] do_filp_open (fs/namei.c:3826) 
[ 106.380375][ C0] do_sys_openat2 (fs/open.c:1406) 
[ 106.381236][ C0] __ia32_compat_sys_openat (fs/open.c:1479) 
[ 106.382243][ C0] __do_fast_syscall_32 (arch/x86/entry/common.c:165 (discriminator 1) arch/x86/entry/common.c:321 (discriminator 1)) 
[ 106.388006][ C0] do_fast_syscall_32 (arch/x86/entry/common.c:346 (discriminator 1)) 
[ 106.388925][ C0] do_SYSENTER_32 (arch/x86/entry/common.c:385) 
[ 106.389787][ C0] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:121) 
[  106.391298][    C0]
[  106.392364][    C0] value changed: 0x0014811664800000 -> 0x00149f9ae4800000
[  106.394806][    C0]
[  106.396026][    C0] Reported by Kernel Concurrency Sanitizer on:
[  106.398293][    C0] CPU: 0 PID: 126 Comm: (mount) Tainted: G            E    N 6.9.0-rc3-00015-ge84f43e34faf #1
[  106.401465][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  106.404332][    C0] ==================================================================
Mounting Kernel Configuration File System...
Starting Load/Save Random Seed...
Starting Apply Kernel Variables...
Starting Create System Users...
[  OK  ] Started Journal Service.
[  OK  ] Mounted FUSE Control File System.
[  OK  ] Mounted Kernel Configuration File System.
[  OK  ] Finished Load/Save Random Seed.
[  OK  ] Finished Apply Kernel Variables.
Starting Flush Journal to Persistent Storage...
[  OK  ] Finished Create System Users.
Starting Create Static Device Nodes in /dev...
[  OK  ] Finished Flush Journal to Persistent Storage.
[  OK  ] Finished Create Static Device Nodes in /dev.
[  OK  ] Reached target Local File Systems (Pre).
[  OK  ] Reached target Local File Systems.
Starting Preprocess NFS configuration...
Starting Create Volatile Files and Directories...
[  OK  ] Finished Preprocess NFS configuration.
[  OK  ] Started Rule-based Manager for Device Events and Files.
[  OK  ] Finished Create Volatile Files and Directories.
Starting RPC bind portmap service...
Starting Update UTMP about System Boot/Shutdown...
[  OK  ] Started RPC bind portmap service.
[  OK  ] Finished Update UTMP about System Boot/Shutdown.
[  OK  ] Reached target Remote File Systems (Pre).
[  OK  ] Reached target Remote File Systems.
[  OK  ] Reached target RPC Port Mapper.
[*     ] A start job is running for Coldplug All udev Devices (6s / no limit)
[  113.764048][  T153] parport_pc 00:03: reported by Plug and Play ACPI
[  113.776436][  T153] parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
[  113.952514][  T139] Linux agpgart interface v0.103
[  114.090513][    C1] ==================================================================
[  114.091583][    C1] BUG: KCSAN: data-race in timekeeping_advance / timekeeping_debug_get_ns
[  114.092597][    C1]
[  114.092970][    C1] write to 0xffffffff83dfe578 of 296 bytes by interrupt on cpu 0:
[ 114.093933][ C1] timekeeping_advance (kernel/time/timekeeping.c:2207 (discriminator 1)) 
[ 114.094583][ C1] update_wall_time (kernel/time/timekeeping.c:2222 (discriminator 1)) 
[ 114.095166][ C1] tick_do_update_jiffies64 (kernel/time/tick-sched.c:149) 
[ 114.095849][ C1] tick_nohz_lowres_handler (kernel/time/tick-sched.c:229 kernel/time/tick-sched.c:287 kernel/time/tick-sched.c:1492) 
[ 114.096537][ C1] __sysvec_apic_timer_interrupt (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1050) 
[ 114.097280][ C1] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 (discriminator 47) arch/x86/kernel/apic/apic.c:1043 (discriminator 47)) 
[ 114.097994][ C1] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 114.098736][ C1] __orc_find (arch/x86/kernel/unwind_orc.c:100 (discriminator 3)) 
[ 114.099285][ C1] unwind_next_frame (arch/x86/kernel/unwind_orc.c:494 (discriminator 4)) 
[ 114.099925][ C1] arch_stack_walk (arch/x86/kernel/stacktrace.c:24 (discriminator 1)) 
[ 114.100549][ C1] stack_trace_save (kernel/stacktrace.c:123) 
[ 114.101154][ C1] set_track_prepare (mm/slub.c:886) 
[ 114.101768][ C1] __alloc_object (mm/kmemleak.c:681 (discriminator 1)) 
[ 114.102377][ C1] __create_object (mm/kmemleak.c:750) 
[ 114.102967][ C1] __kmalloc_node (include/linux/kmemleak.h:42 mm/slub.c:3802 mm/slub.c:3845 mm/slub.c:3965 mm/slub.c:3973) 
[ 114.103566][ C1] kvmalloc_node (mm/util.c:662) 
[ 114.104150][ C1] seq_read_iter (fs/seq_file.c:210 (discriminator 1)) 
[ 114.104748][ C1] kernfs_fop_read_iter (fs/kernfs/file.c:281) 
[ 114.105388][ C1] vfs_read (include/linux/fs.h:2104 fs/read_write.c:395 fs/read_write.c:476) 
[ 114.105938][ C1] ksys_read (fs/read_write.c:619) 
[ 114.106485][ C1] __ia32_sys_read (fs/read_write.c:627) 
[ 114.107082][ C1] __do_fast_syscall_32 (arch/x86/entry/common.c:165 (discriminator 1) arch/x86/entry/common.c:321 (discriminator 1)) 
[ 114.107729][ C1] do_fast_syscall_32 (arch/x86/entry/common.c:346 (discriminator 1)) 
[ 114.108364][ C1] do_SYSENTER_32 (arch/x86/entry/common.c:385) 
[ 114.108943][ C1] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:121) 
[  114.109697][    C1]
[  114.110062][    C1] read to 0xffffffff83dfe588 of 8 bytes by interrupt on cpu 1:
[ 114.110988][ C1] timekeeping_debug_get_ns (kernel/time/timekeeping_internal.h:21 kernel/time/timekeeping.c:381 kernel/time/timekeeping.c:280) 
[ 114.111685][ C1] ktime_get (kernel/time/timekeeping.c:394 kernel/time/timekeeping.c:838) 
[ 114.112236][ C1] tick_nohz_lowres_handler (kernel/time/tick-sched.c:220 kernel/time/tick-sched.c:287 kernel/time/tick-sched.c:1492) 
[ 114.112924][ C1] __sysvec_apic_timer_interrupt (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1050) 
[ 114.113647][ C1] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 (discriminator 47) arch/x86/kernel/apic/apic.c:1043 (discriminator 47)) 
[ 114.114332][ C1] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 114.115063][ C1] _raw_spin_unlock_irqrestore (arch/x86/include/asm/preempt.h:94 (discriminator 1) include/linux/spinlock_api_smp.h:152 (discriminator 1) kernel/locking/spinlock.c:194 (discriminator 1)) 
[ 114.115753][ C1] __create_object (mm/kmemleak.c:756) 
[ 114.116355][ C1] kmem_cache_alloc (include/linux/kmemleak.h:42 mm/slub.c:3802 mm/slub.c:3845 mm/slub.c:3852) 
[ 114.116993][ C1] skb_clone (net/core/skbuff.c:2063) 
[ 114.117535][ C1] do_one_broadcast (net/netlink/af_netlink.c:1466 (discriminator 1)) 
[ 114.118170][ C1] netlink_broadcast_filtered (net/netlink/af_netlink.c:1543 (discriminator 11)) 
[ 114.118883][ C1] netlink_broadcast (net/netlink/af_netlink.c:1568 (discriminator 1)) 
[ 114.119493][ C1] kobject_uevent_net_broadcast (lib/kobject_uevent.c:331 (discriminator 1) lib/kobject_uevent.c:410 (discriminator 1)) 
[ 114.120211][ C1] kobject_uevent_env (lib/kobject_uevent.c:593) 
[ 114.120844][ C1] kobject_uevent (lib/kobject_uevent.c:642) 
[ 114.121414][ C1] driver_register (drivers/base/driver.c:255) 
[ 114.122024][ C1] __parport_register_driver (drivers/parport/share.c:289) parport
[ 114.122833][ C1] ppdev_init (drivers/char/ppdev.c:811) ppdev
[ 114.123470][ C1] do_one_initcall (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 include/trace/events/initcall.h:48 init/main.c:1239) 
[ 114.124079][ C1] do_init_module (kernel/module/main.c:2538) 
[ 114.124700][ C1] load_module (kernel/module/main.c:3001) 
[ 114.125281][ C1] init_module_from_file (kernel/module/main.c:3169) 
[ 114.125945][ C1] idempotent_init_module (kernel/module/main.c:3185) 
[ 114.126610][ C1] __ia32_sys_finit_module (include/linux/file.h:47 kernel/module/main.c:3207 kernel/module/main.c:3189 kernel/module/main.c:3189) 
[ 114.127271][ C1] __do_fast_syscall_32 (arch/x86/entry/common.c:165 (discriminator 1) arch/x86/entry/common.c:321 (discriminator 1)) 
[ 114.127912][ C1] do_fast_syscall_32 (arch/x86/entry/common.c:346 (discriminator 1)) 
[ 114.128530][ C1] do_SYSENTER_32 (arch/x86/entry/common.c:385) 
[ 114.129117][ C1] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:121) 
[  114.129880][    C1]
[  114.130247][    C1] value changed: 0x0000001ac6927aaf -> 0x0000001ac6cf83af
[  114.131074][    C1]
[  114.131445][    C1] Reported by Kernel Concurrency Sanitizer on:
[  114.132179][    C1] CPU: 1 PID: 144 Comm: systemd-udevd Tainted: G            E    N 6.9.0-rc3-00015-ge84f43e34faf #1
[  114.133442][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  114.134654][    C1] ==================================================================
[  114.141741][  T144] ppdev: user-space parallel port driver
[  114.556211][  T153] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
[  114.791100][   T95] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input4
[  114.842626][  T139] bochs-drm 0000:00:02.0: vgaarb: deactivate vga console
[  114.849602][  T139] Console: switching to colour dummy device 80x25
[  114.934666][  T139] [drm] Found bochs VGA, ID 0xb0c5.
[  114.934674][  T139] [drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebf0000.
[  115.023240][  T139] [drm] Found EDID data blob.
[  115.104489][  T139] [drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:02.0 on minor 0
[  115.223445][  T158] mousedev: PS/2 mouse device common for all mice
[K[  OK  ] Reached target System Initialization.
[  OK  ] Started Daily apt download activities.
[  OK  ] Started Daily apt upgrade and clean activities.
[  OK  ] Started Discard unused blocks once a week.
[  OK  ] Started Daily rotation of log files.
[  OK  ] Started Daily Cleanup of Temporary Directories.
[  OK  ] Reached target Timers.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Basic System.
[  OK  ] Started Regular background program processing daemon.
[  OK  ] Started D-Bus System Message Bus.
Starting Helper to synchronize boot up for ifupdown...
Starting LSB: OpenIPMI Driver init script...
Starting System Logging Service...
Starting User Login Management...
[  OK  ] Finished Helper to synchronize boot up for ifupdown.
Starting Raise network interfaces...
Starting LSB: Load kernel image with kexec...
[  120.559025][  T225] IPMI message handler: version 39.2
[  OK  ] Started LSB: Load kernel image with kexec.
[  120.991196][  T239] ipmi_si: IPMI System Interface driver
[  121.000344][  T239] ipmi_si: Unable to find any System Interface(s)
[  OK  ] Finished Raise network interfaces.
[  OK  ] Started User Login Management.


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240524/202405241607.d3fd7eb0-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


