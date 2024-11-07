Return-Path: <linux-kernel+bounces-400064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CFB9C0867
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CD81C2224C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A08212632;
	Thu,  7 Nov 2024 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7sS1Quz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC60320FA9A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988409; cv=fail; b=cBTbkITOLdEyXZoV/Ey70V5fw7BQmw9Ju1lKZ8ABfk6hS9KJWBiBGrx93BFhZRGkXBcQLZ9y0dtBKv61zCWq5EMTFu31CHeTCQhumIirZsb0yPdump58ZxeyIOqfPKJPfnD2B1pa35IrMOrU5qyrNMKaF0kpNJyjxn4npStsdmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988409; c=relaxed/simple;
	bh=btWaBRjnuHvpKZIhn3JcNPdR+ZLnf/uI9bbsw0F3tTk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m4NZBM7vvVFVHcBnTHxHQbtx5DvXN41CapdHUPemauyEYyKLBsPjbSnQBRkl5fABGC0DjEB1Js1fsVIqVbAGxwmxVPuuRuRX5s0gGIpS3gG0L33ulESp/aCl01MLToQcWaTzBXWfxWCi+O9sT9EflnDZmn6g73ypRgXdE/Ysars=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f7sS1Quz; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730988408; x=1762524408;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=btWaBRjnuHvpKZIhn3JcNPdR+ZLnf/uI9bbsw0F3tTk=;
  b=f7sS1QuzNzWQ9ZBTPeNxbDPUcqUIsLPWUtAolSmABtSsHBIrvZ23mcSP
   arnYrJckCwNV20ghYiijfgCSuYOGVQgIpSKvneRsFozwYxW91CGXXxBnt
   vEusur4MD+hHss1Tm8cxHgLH8j06SHI0ST+U9M+VhZmyJ9g57G1huh5P0
   7blIZKrIeDUq9LMa1KO2aQ2NGiDyjceMHOKyVfzrqoiqNu62YtGq2E+cO
   NYhXCA5JLMwR0Yl2O+5ePMUw8A3R3c5MZMkfTC/SulHeWS9nNRPNDxI+d
   vdYKQBtSZZuWuj3aJm/VAX5Ss7XJ9WU5m54lpwrOFAzS/0T+QkbGb2mn1
   w==;
X-CSE-ConnectionGUID: izFy2BS/S6u56sUCp3xc/w==
X-CSE-MsgGUID: ffJb8jAFTI2YOg/XZKW0HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30685984"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30685984"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 06:06:48 -0800
X-CSE-ConnectionGUID: nmboWyBXSIeq2KddY60fTw==
X-CSE-MsgGUID: XOGDtATTRe68S+DWwJOdDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="115910328"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 06:06:48 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 06:06:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 06:06:46 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 06:06:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mi208K6RZukysU4dIIDixD+esPr4OP/tKj/mqwDNvXy4DJWxsS9SdH/dJxjgbjAlaK5xjs9fM7Ry/dCA5G9rUrqFndjISAj5PoxQFlrYuBLGlkMw3NVpv14lAhdKYJpKTMXcZMyCrPh1rv19V+Qi4DS/FrMuDelzK1InWP5DJNPEdrl/v6aFphbHzingQvbScXfynmV8gzx2eb7lIhWRliyKxxamxrTEwuiyhapuzfpq8MzZsFa628CL35TXQcFMhK/I4xM/j9ChgmIM6Z/r95jETZQJFqaDYfvCr33WdPkDFr2xnIv6XCq3uY9Wcyf0AyG6SkywC+dR+7EHSkbA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tKlyTHT7nBAPxLJgka5ZfD0atT2w5B7V3siha8b1E0=;
 b=neFyUSXJEwrCm+k1lTPPVLffX1KMRwHBBrNY5yHJnQR8eSf05mPBMdJSvrjlVjgmW+Yfcse5CxW+0pbhsL2E2B/8CU2B/No1JypxpYEeuHe4Sp8JZvBEFOrXiIQw2f2TUpqHCD7YrH7nYPrNK6PrCCMaULBE5wNqjuemS91QUctOBhUtHp26wuDe0qsSwZgdbC982xuqO+Qtjo0MekurcRPYOuaWNhUwig6qQ1ti/ouvCXztlV3hDuA8d/wNy2PHUp90I8YYO2ZmARuA2OxX1nF+pgl3X54+p6uA7nCeb3s+pSpyuIFOWbS//S5y2vuyoR59KghJSqBoSBRa3nDiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6165.namprd11.prod.outlook.com (2603:10b6:8:ae::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.19; Thu, 7 Nov 2024 14:06:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 14:06:43 +0000
Date: Thu, 7 Nov 2024 22:06:35 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Frederic Weisbecker
	<frederic@kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [paulmckrcu:dev.2024.11.01a] [rcutorture] 622baf5d79:
 WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
Message-ID: <ZyzJa9tR0503k70s@xsang-OptiPlex-9020>
References: <202411051012.f9224879-lkp@intel.com>
 <1092459d-48e2-4839-a84d-c38d96fa2a36@paulmck-laptop>
 <ZyxeC9WVcbdTAu0x@xsang-OptiPlex-9020>
 <7b36e5d1-e936-41af-aa2b-9b0cd102f341@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7b36e5d1-e936-41af-aa2b-9b0cd102f341@paulmck-laptop>
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b508b48-805f-4dc0-d366-08dcff3568de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t6EFNmfKptKf3RXNIgmfSlBZfF6qUfZJbQ6tbd+poP7lkpJw6q2b8j9w8H+P?=
 =?us-ascii?Q?bq9+2tE9pMkBle9RvpcmP2EBobReH2L7442RTcuOqjDpcN+ODpPplOZnXTAg?=
 =?us-ascii?Q?fXxZASWvFVJVWByjh4kgsTpWIeqsgidl0daF3B8LUCklIBbsx8HvuSaucmFy?=
 =?us-ascii?Q?3kQpxnqDu+oIYzQ8dphWhcbiimidtMbUIEsh0ltn+6Jwbg34AAsbrHht98vG?=
 =?us-ascii?Q?T/nzbMBQjM3hXQtUjnxitKXBKmnRDsE6MaI/Bb9GHUkWpi2ctZFjTM1Dih9C?=
 =?us-ascii?Q?49B1npTbEM9tsfTJ4RlmrjGZfObx4wgYJQByBC/WThagSDgZ8Jka+iPVIUgA?=
 =?us-ascii?Q?uev2bmnUSdxcnstgVOLGZ9tUxxt8gedquWvhwhfTLncNtsFHACQ70KyGNRrn?=
 =?us-ascii?Q?0Gj07SMZCORDt0ZGqO4LF1S7QD1nf6MgYVxpwHADTa6UfNmhhMF9HbOjlGAI?=
 =?us-ascii?Q?AS5sYwWEr7uiTo9hAYKSGA5GRlpFbD5UdbeVZailHiEVQ43GbAXLdqabVcEe?=
 =?us-ascii?Q?w+XXPUAD5BCFnUgP5yrMEJ/VM5GNn8h4LHil+suQtEEXhLsyX0PPpOQ97Ge5?=
 =?us-ascii?Q?pdO6SugLTVVpJjpL3p7QqH8caN06zc8E66XwijBans59d1JW2nosKZ4kWvQl?=
 =?us-ascii?Q?MXBSFxjA/7sBN32jZvVhaKSA0+5Zk7Pt6om1qPYTdvetpTfhlr2OQNzcn8Eo?=
 =?us-ascii?Q?URVsnOPbbWtJof2M5GyiKhPcknXyZOwB6wzm2o/bKecio+vEsQ5DeQxK9Fe/?=
 =?us-ascii?Q?a6xKBHKxbuOZnvNcu5SOtXoZpKQHv/X9n4LZ3R80rBAYWm48qoS1VuBpX1Sa?=
 =?us-ascii?Q?7wn/QtigmSrBD9e1il6UVaAwH1g0A1YtQt1viIShdkU7NxqPlA8UuqZaXyCn?=
 =?us-ascii?Q?BfAkxiWHvDbPDSrCaquFHleBFttSnZGcoDIV8jLdIoEmQsexlfCB+iNkT6bF?=
 =?us-ascii?Q?z6lEGo5GVjGU87rwkyFJhUazgBE2yXYf+Y9IoM7tvktglI2ZNDBTjQKGRCVi?=
 =?us-ascii?Q?BGijj2/94y7/gnHKrJubJOppGV4ZRaSWE2MfL380/isHn7OUh+M7mxTWJqvO?=
 =?us-ascii?Q?mliw1cFwI8ze1PHojyEv75G/DdEnLcqsnigGDLZeM04i/q35jAZ6XDvUYk/A?=
 =?us-ascii?Q?V/vFLwbzfL3vxcI/rZ1RsFJTZZdYfsjiyLW+27JBtsBLbMzQw9TORq6Ek0VM?=
 =?us-ascii?Q?oWHxPJAfSEyoVCkCqtGX2rvw5NZnCXhoY4BTyb0FC97XnT8SMgFiT3CztsD0?=
 =?us-ascii?Q?un6R4PIhPclwSmoMKFyD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r6FLMJRnwV5AHT+N6WvablYKr93L0Ry+OgE3eCSOO9Qs2b0h5QA/o86IE6IR?=
 =?us-ascii?Q?wJDneZDHmP3vYLDBB0UTGzP0jAHeLcY8iJr51RKKHQ6jWSzji2U/uZxAwIQh?=
 =?us-ascii?Q?H+9OLoxj9SKSCS3/W38L/F6iqZEJWMI137BD7VdUqtHv6Zl+eWeUME8UVigj?=
 =?us-ascii?Q?Rv4bDgCst2M+nSRpVceAjG3R8sXqcjHhz7OhBsVvw8SErG4z86KyNSwERzEj?=
 =?us-ascii?Q?trjOMUoC7Op8Nts/9gjCv5hQ/lbVVis3JikQ/PUKbkOXyA9swOkQWbiamUrM?=
 =?us-ascii?Q?rN3e1osjzreroOSb1gPfA8WmfUhGNXPIelwvEjGMMbrGxCeU2JwULCXqTwgb?=
 =?us-ascii?Q?1x6La6JrM+UbpHNC0AJT8zNApzyffQ7rl8u/cy1FTpQvV4PYBXLt5f/hluAV?=
 =?us-ascii?Q?WPPjvfSEVP0sbWXkL30re2vnFZzFFDdiFSzaOTghUJ7P0cuZAuQ/ayrqxPqK?=
 =?us-ascii?Q?JQH3RanZDt8SDdTUv7YH+J//ITtyDVkKaEmkT8N9qMKouEotMmtNbth+s0yK?=
 =?us-ascii?Q?dhAglY5gAhzh1Cb/tlGliV9D2xEJfV5m0Tof7MeM8tH7UH/52QK0dzmrg1sR?=
 =?us-ascii?Q?xwRuurHNSWXm4IxRI8e2QhG3WXZ29Sm6DaABBJiIT9jAgy54fXRT3w1af0Kg?=
 =?us-ascii?Q?lOZy6uLIlW4tAUmXDWEqqLSiTEMUYfap57hCSuU9svL8Tmtb5s3kBkQd58E2?=
 =?us-ascii?Q?qmPlGH5JjEXdKtlaORgr35Ax2p++2V85LBo3hSkh9fgqHyfEsxxqRHGG32tt?=
 =?us-ascii?Q?90J4ePeCL/NJvRKNxvvqbOd6XF73SmM0LyFSf9HTvx7Po5OfhXb3zVhi/QZo?=
 =?us-ascii?Q?jy3kB+GjEAols/XU+0+Li5Auz7eiiIfGwijE26yK3xMViBLE84lslv4uxVJW?=
 =?us-ascii?Q?YrqSCjuC/gN7WN/ul4XUbENAsVFdk0tAYRP5Dg5usSZNBCx6RUYJd+n7AGtw?=
 =?us-ascii?Q?/9Lt66zVYXvuNalDuPCYv/MHm9d8zYkhMr3SGw6NcYsBHUAOqFIUNupypqk7?=
 =?us-ascii?Q?ddywhV7moVjIu4TGQOA0GcgoFqx20vgYF9P+dYelyXpxHu6sk890fQzpMA9K?=
 =?us-ascii?Q?nJcVPU/fIX4W5Qz9ZwjmRc+zfLR4Wojg3Y7ruRV5hMdJIX2eXTXpHXS6apVc?=
 =?us-ascii?Q?AT1vXDqdckRejlzJ8bkVVvhije2847N/Q1oQumAigTwzJAINrTtpsQp13C7Z?=
 =?us-ascii?Q?elmM1pDKCxxSThrQaOhoF2O3g42Pv1Q2GudYVFOOkOavEaIQAMgkNxN+bT7I?=
 =?us-ascii?Q?VK8IXNW6FGUM/WggAbNQGAN2we7d9ao6/fnRDSGoPWtS7YC8poTjzCHuYlA3?=
 =?us-ascii?Q?I01c8fu8Zbz3grz9+I4iquUzqe4w96BHwSpk9RroZdqP/3ymyHVtvpvsdl7q?=
 =?us-ascii?Q?383ZZzmi3s9bMlJJZJYepiFSfcT6wsyhLOib5hH4Srt73DEVp4quXi6DDaoY?=
 =?us-ascii?Q?VUsjhq/nbbp6bSP52LmqXrgHCSpKR8BdrbFlPZdAcaFZdLfAFog5WR8cZIKJ?=
 =?us-ascii?Q?h3IX+AxEgBWl7THMAthtUfeKdwDX8RUKpqq48Ayv6OXkERrVX5+t0iE3XCSg?=
 =?us-ascii?Q?zr02cEGxbtnFWcdIwcrSvtrheOD6dnKhGm5XSSqyakQubuEk9T8iV2mQPofP?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b508b48-805f-4dc0-d366-08dcff3568de
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 14:06:43.8824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDYXStLrr8N8eRoZgTa2Mlz98QDYH6F3HJcP2dUHhXne2fExoZ5R/xPQwKVW8sPnmBP13qIfxik8hcuSBEQJEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6165
X-OriginatorOrg: intel.com

hi, Paul,

On Thu, Nov 07, 2024 at 06:01:15AM -0800, Paul E. McKenney wrote:
> On Thu, Nov 07, 2024 at 02:28:27PM +0800, Oliver Sang wrote:
> > hi, Paul,
> > 
> > On Wed, Nov 06, 2024 at 12:07:37PM -0800, Paul E. McKenney wrote:
> > > On Tue, Nov 05, 2024 at 01:00:53PM +0800, kernel test robot wrote:
> > > > 
> > > > 
> > > > Hello,
> > > > 
> > > > kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]" on:
> > > > 
> > > > commit: 622baf5d79169496973d50fc43636469e6af02b7 ("rcutorture: Make rcutorture_one_extend() check reader state")
> > > > https://github.com/paulmckrcu/linux dev.2024.11.01a
> > > 
> > > This is an old commit that failed to handle any torture_type other than
> > > "rcu", including the "srcu" that you tested with.  It has since been
> > > replaced by a series of newer commits fixing this and other bugs, with
> > > the current version here:
> > > 
> > > c815d319a933 ("rcutorture: Make rcutorture_one_extend() check reader state")
> > > 
> > > Does this one work for you?
> > 
> > yes, this one works. issue gone when we run same test case up to 20 times.
> > 
> > d5e74d8e46e8e45c 622baf5d79169496973d50fc436 c815d319a9331530032be3df69c
> > ---------------- --------------------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
> >            |             |             |             |             |
> >            :6          100%           6:6            0%            :20    dmesg.EIP:rcutorture_one_extend_check
> >            :6          100%           6:6            0%            :20    dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
> 
> Again, thank you!  Would you like me to apply your Tested-by to the
> resulting commit?

sure! thanks

Tested-by: kernel test robot <oliver.sang@intel.com>

> 
> 							Thanx, Paul
> 

