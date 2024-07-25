Return-Path: <linux-kernel+bounces-262287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC5893C379
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CE21F22D29
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D8F19D072;
	Thu, 25 Jul 2024 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UU97x7eZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1326A22339
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916054; cv=fail; b=sZUny6AxPNopNftZrkHUMJTpOHgw2gUN7UwfO4Ie7KP4ZhZMP7H79xBCasn0mSH/4EXAvCGlj/ZECg9Elb1RtG2nbhiF7XWGbhRlFMENu3vH7KfezYGpzfkfaZRXC75mkImi/BxuLawnSFiIEA5wnvBFSdzjvJxdMhsPadxf1ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916054; c=relaxed/simple;
	bh=KXUzMR753VLhDwZWhqggtlUifaiku3HLIFu5rvaaFsM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iwmAtwp+Nd7btazoPD7coOVcGLTjcW0XGYi3e6QBlLoTpKOmpeI3sunEs/8yqgR+VihkGK78kJurODay7PGYXkmFb3R1Nidn5wqw24sAfeC50zg8afD3iKF9yQBHE+ccZvxOwFt/IoQf8i1n8EeMpwgXDd0neZS0CaDfKUMrU4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UU97x7eZ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721916053; x=1753452053;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KXUzMR753VLhDwZWhqggtlUifaiku3HLIFu5rvaaFsM=;
  b=UU97x7eZWTVTLfal3PG/H4+i8ZTrQaMSCwkuQT+Q4qCJQusGav6fCMu9
   qQSqoK+JBl3wb2sdKhw/Vl9R1xR5VKGq06ApnBSCsvoJ9LpwqAlTBfilr
   /h3IRrD+5PKGexOHsVMvHL/n7Ghuku30KXfjJMnQhMc21u7O1rJoh5/Vz
   xG96LUQDiN/eZcJ6xMo4eKj7FzH6xsJjEeBfdSCc53iWnj2TrrXzvElrX
   l/f9kXmfUJImXQ2OSbVut5+PDyt1On5KIYVEhVrqdySfKj02ZPOXx93Cf
   iTFDyHBIvjJ+xP/jpljBUHyuLrIrIiUw1rTkgVrVTng/wPUNwyZXgov8v
   A==;
X-CSE-ConnectionGUID: 0IIYDKdsRJaevR87IdahsQ==
X-CSE-MsgGUID: IGL+7L9TRqmPvWTTw+Aq/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="30274922"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="30274922"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 07:00:52 -0700
X-CSE-ConnectionGUID: 15vsDanqRbuySbwB8k6oGA==
X-CSE-MsgGUID: vQ+SbRl6STyKHN6uW7Ws1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="52940042"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 07:00:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 07:00:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 07:00:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 07:00:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izVXrJrS7y2DcxzRGewt+FpU4AyZSJe95PHlyXi0skDBRqJ/nJtHejSJ/KUGcvHgcQy0gvAnOVgliOq/79I/1MiliiF67gjMbqzLPYG+h3QT7Gs0hDeFxHbY9ynju7Jzemh1Gt09hSdtqj5ldwovTjbXwVEmdwlTqIuRJvd+CgLQrsqW7tbAigWhbJh6gW7QQrXpE2s8URrPSrNvBwqNUwIOwp/h2TJrXkSvhjtJPgInC68x2IKDltrpfDqxtyoA1ujys1CvZuwB42YQzCVRQa/VxV48X8SnytWPRV4M/GbSyLsRXbG/vktGlVgzgRPnBgK2Yk+icwZIYcvJMOJDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8hpd1tv1ilKvezae5NHDgTCt7DjMSyZm+WDqKvW4UY=;
 b=G0x6gu0CeZlq762OYFtetp49qfNqA/ade1pxQ/YK5PcFkSFV9TY2aJG4sTgu5/v+/hG9coBvFxNIxxuKMPowtSkUKylJY+fB4tjYvvFQ0o4bunAkqC9qpNtMHDrE3toCjiPRMWy0k7QDOTrrN+1Po9C5tFZbqj5iGjfSZQMn+M1IEKneAkDFQTA4p0dY2N5s+DYZehObpISuGwYiw5D7o1l1fQ5Pngih55Xp9bBpiY6OcJcHS0Rsmdl5HTYekGDjplRDTTutMNohupKrcphTE+A3m6RgPvPyEKoYUgqxVzVAeVz6bhSGJHYSwQ1lYqrrikiMSOL8ksdu8QqDK3MWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CY5PR11MB6535.namprd11.prod.outlook.com (2603:10b6:930:41::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.29; Thu, 25 Jul 2024 14:00:46 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7784.013; Thu, 25 Jul 2024
 14:00:46 +0000
Date: Thu, 25 Jul 2024 22:00:29 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Hongyan Xia <hongyan.xia2@arm.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Qais Yousef
	<qyousef@layalina.io>, Lukasz Luba <lukasz.luba@arm.com>,
	<linux-kernel@vger.kernel.org>, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] sched/pelt: Use rq_clock_task() for hw_pressure
Message-ID: <ZqJafRf/fM/whI+6@chenyu5-mobl2>
References: <20240725114200.375611-1-yu.c.chen@intel.com>
 <38a631cf-1f6d-4d68-887a-12c7c5808ebf@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <38a631cf-1f6d-4d68-887a-12c7c5808ebf@arm.com>
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CY5PR11MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d4499b-ac22-4d5a-c6bf-08dcacb22e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SHlDhcnPD7u8t1KFb6ZKPpVuI2zFb/471BV+5CAQPTw8QV4HbVJyyyaaxod/?=
 =?us-ascii?Q?ixU51KUiAmMjxu5ddsBt4K03BX/a54UAe21lR9ssONNEwX0Ej5G6S3UZxqVi?=
 =?us-ascii?Q?WCsGmFqQNt8M1tOTdBO0XoGHkiuXn+2VDlfWBFGqNL5DR0Cn1N5xNZcYL4dR?=
 =?us-ascii?Q?P0loAeeFt8XoWbceJiQQ/KQXEli5W78D1ru1IzYJvOV7gwXywwH61A3c2sQ9?=
 =?us-ascii?Q?qoNQEaf/zR2r2s07B4OWku/UQ6+5teLPyUVmDdx/00nQ9qqSL/h78TkXH/Pd?=
 =?us-ascii?Q?1+l+DoKrCf4tT0FkKznRqdC+0xCpEPePtA/hdo1jO/f3D9qDwaYuXbRX/90c?=
 =?us-ascii?Q?MoTyhSqU6skwVWeF0+Rysu4RiPML5AIL63KcksCXbbdZI+FlYdr4+gbiO4OK?=
 =?us-ascii?Q?kpqAkrG8fexxBAaJar57tlDUjmaY3nzkFhyLMlGWU1twgB9vq8kXi4et3TDS?=
 =?us-ascii?Q?7r93VTbUcqgST3MXm9cwU+m+Pp7BGfOSuk5lNRg8yh3PLY83YpsJju8v9WhJ?=
 =?us-ascii?Q?ETvkK1f2l3pft8EUSsCutzDZc28BIG7d+CrTU94bzyUy7hW2Qxp8euluJMLo?=
 =?us-ascii?Q?T0yhRZzQylTbf0HImASsY9sKumMQOMVqhInChCjuJ9qwq4Ewl8k4TPN9t1in?=
 =?us-ascii?Q?M4NNjeqI4nyzH7VTyUWw4y735hd/u5VUaIW2CeFD+KYw4KuOko8vgWNiJr7v?=
 =?us-ascii?Q?wWnymIMA1Y0LTOCTY0we2+7mqy1+FVf83lt9c/8YyV5kiCneSB8zzfjfrqC+?=
 =?us-ascii?Q?vND6v2ggQ2VJamMQj9SOpzjMUwgJiA8fCNlyzB7omwOfA+pimuzGxXo4fFn+?=
 =?us-ascii?Q?XQdBwUAPonqBlSvFzRYyTAYio279mp6yGsCZ74dVuuyNBgb2tduZC2ahCuuz?=
 =?us-ascii?Q?z/qgCDmFTZq548Jxlre3ak8gOopCO0wyJLNwmVVaDVRMcPZ7BJ6TollYM9zQ?=
 =?us-ascii?Q?TuHCruP/4g8KrtbgoE9rBu2OGlU7jPT/b9OpwEatWs4HG+AvJbXvm+VmD5DH?=
 =?us-ascii?Q?77Ekf819rrT/5qq3tiusQze6RVPc0HI1etrP6koeyT41VXbeqXn4rNoPvCgQ?=
 =?us-ascii?Q?CfHWAdoRZgtcdeiFcrnyglm1kPTBKqQDfoGxbfibjSRq9E0bTOmk3Sx8PhyL?=
 =?us-ascii?Q?dvy65hAQ4xPR7Xo0/9IRqMcualJ7MXjz0B/BKYIFdQeOUsJX69W4iyMm0t+D?=
 =?us-ascii?Q?UDjfCIxFfB+YaLBjfKz+aqDz27j9jF8wTCI33/Mbh+EkfJw5mOlX4yD3af8V?=
 =?us-ascii?Q?f/KwM0hpOf7WWvNp3pncAERgKnmLp+qeWmFqRkzVf1L99iU6+uPPUEjVjccG?=
 =?us-ascii?Q?sx4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rhMIaBOL7NoYZ4c1CwC+u/YiVvl7GM+E3BzWwjGR59ybW/nxQzood8aBfzx6?=
 =?us-ascii?Q?VVs78CcpcgdIgtp8gzJm6WiFkqnLUjllqSmbCocy2QuNsxMcu6MvlQFtAFk+?=
 =?us-ascii?Q?6uLDSM2uegiNeMxqxgv3GRR0NA7Q5B8JTT0EPkzNZCtGE2s2XQ3/3/eIxuq2?=
 =?us-ascii?Q?Vuq06o3HaTLzRGe3M+TtaHKe6RFUybxiIjVf3hXGj0wrjqFADfDCBwSh0Gdu?=
 =?us-ascii?Q?8dgobMqA6dIy2WIUVi5lM5S/w0x0P4xwYipQ2+Ee0Le/FU7E/Gdel4KQ1ybo?=
 =?us-ascii?Q?U9jxTQGF+cLvkykQcZdz/ZkGUB0YniLu6UZAL0KU7Mm49NSjrzgysgADddvH?=
 =?us-ascii?Q?IF0ssXS7qz5UvirESqtmXHIt38tRvz2D0o8J07XvxW6HmFf14J3x8INnAmj0?=
 =?us-ascii?Q?uSteP7e73SIg/qelBVvkuyfC9jXhriJBiiySdVNfDbUnhYW6JqkrYkM/5DIf?=
 =?us-ascii?Q?O+5GRbcV8SwQoy1h4PQhTatw9Xy2+CFqxKqcjVXI0U5R2EzBBgrFvV6QbwME?=
 =?us-ascii?Q?S5X0grsMDABBLboKNoN2S5vv94s3ALpYLTkU8TcP2pMBgHFHoq/MlOddauRM?=
 =?us-ascii?Q?alVRxxHVeXM3Gn7oYh4qPbmWSzssqRtp15T+kx23Y7hpH93n5M7gd/uBECUe?=
 =?us-ascii?Q?3pJhEao0Crd5cALOyPgXLLlUiekSkdps2w67AhR7xzy1nHsP50hZaqd5daY1?=
 =?us-ascii?Q?nQkt3flvYbdTCBy8OTDoBKLJcvToEL+PutejidTBRJuVqq/VXgW4TWD+4q4f?=
 =?us-ascii?Q?0wqjrXOBMetWb4Mb8Qmcc1xCbW7mEtBw0PonhyPZpgfNOl3UOYPrUZyS9Eul?=
 =?us-ascii?Q?DEjTiIA2TaH+Q8qsdXA21xC4DzOga6Tqjwa7x4Byr27Wpv37/0pyBh2V/YhQ?=
 =?us-ascii?Q?OOi3CZL5ASJ8cJVFOZ6KQAV+5qkXpTrd10MjQY2Va2wRyrR5xteGmll7oK/m?=
 =?us-ascii?Q?kyVAlDPYNTnM6vdqdq6nyHNGTz3IeTDMM1Cqsi7Sx1zQf8zs+KbdmEeqj0lF?=
 =?us-ascii?Q?ElloZPNxAx5nB7c55g1DmCuYqlBSF/TE/qxYT4kt2xZTY/3yEdDvN1wVk3f+?=
 =?us-ascii?Q?yQc7G94WGY8E8NVGd8ARKHqq9qomJeOqTRHV6lplCmc9nEALir0V7J5WTh1U?=
 =?us-ascii?Q?sFEqGzwSQISboBlSnx8+rsGz6BNBuG3Fc969VQKE3Fkr7NvT1Ta1lY+6XjsT?=
 =?us-ascii?Q?c1R6JdrVPw7zz+sw9Ia2QlKm00wLq1PCJU1iekRpzUhMirczzYfOcSumh7df?=
 =?us-ascii?Q?MkHpsKqdfoGGj5HBn0h8fdEbPCMjB9z/439ugTrlabkxfm1LE8rW/GrGCY8a?=
 =?us-ascii?Q?YMHuCb4iwXKSroIL0xsfquyEy5qyUulovgA+BEeXuEIO3hVR38Deb1lPHd+7?=
 =?us-ascii?Q?8h5ht7lrqw4rDp9ycrUllS9Oxc3QR3FET/Nqlk87JTELWPFYJJRLg6M/U7Q5?=
 =?us-ascii?Q?sltaqoqvKyxT5UkKs4nDb8/ihEej9wtytqcYEEqdnbpdeOHMfSrvO8zexdQA?=
 =?us-ascii?Q?NcRzdmyFysY5OJfvZVWnIld7QNvkwq30DTWZjWB4jse70ss8OKS/7LnJgKrk?=
 =?us-ascii?Q?uggIgZAkLAqYXBSjVjY3q0wBhw3z3EN3JOKx3HHW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d4499b-ac22-4d5a-c6bf-08dcacb22e5a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 14:00:46.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prgLhtfffe5qxsMoB7KRZY+0KT3x98Q3hc/maPt8LSpVQWzvDFJddtcI6jn0lKduhvfQhZXaQvg/KuIsb/qIcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6535
X-OriginatorOrg: intel.com

Hi Hongyan,

On 2024-07-25 at 14:16:30 +0100, Hongyan Xia wrote:
> On 25/07/2024 12:42, Chen Yu wrote:
> > commit 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
> > removed the decay_shift for hw_pressure. While looking at a related
> > bug report, it is found that this commit uses the sched_clock_task()
> > in sched_tick() while replaces the sched_clock_task() with rq_clock_pelt()
> > in __update_blocked_others(). This could bring inconsistence. One possible
> > scenario I can think of is in ___update_load_sum():
> > 
> > u64 delta = now - sa->last_update_time
> > 
> > 'now' could be calculated by rq_clock_pelt() from
> > __update_blocked_others(), and last_update_time was calculated by
> > rq_clock_task() previously from sched_tick(). Usually the former chases
> > after the latter, it cause a very large 'delta' and brings unexpected
> > behavior. Although this should not impact x86 platform in the bug report,
> > it should be fixed for other platforms.
> 
> I agree with this patch but I'm a bit confused here. May I know what you
> mean by 'should not impact x86 platform in the bug report'? But it closes a
> bug report on qemu x86_64, so it does have an impact?
>

It should not have any impact on x86_64. I added the bug link here because I checked
the code while looking at that report. But that report might be false positve,
or at least not caused by this logic introduced by this commit, because
CONFIG_SCHED_HW_PRESSURE was not even set in the kernel config[1]. Maybe I should
remove the 'reported-by' and 'closes' tags?

[1] https://download.01.org/0day-ci/archive/20240709/202407091527.bb0be229-lkp@intel.com/config-6.9.0-rc1-00051-g97450eb90965

> > -		  update_hw_load_avg(now, rq, hw_pressure) |
> > +		  update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure) |
> >   		  update_irq_load_avg(rq, 0);
> >   	if (others_have_blocked(rq))
> 
> Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>

Thanks!

Best,
Chenyu

