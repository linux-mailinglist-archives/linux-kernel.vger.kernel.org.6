Return-Path: <linux-kernel+bounces-193487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AB08D2CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D7528D092
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798E71D531;
	Wed, 29 May 2024 06:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Idi5cux8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05E615CD41
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716962829; cv=fail; b=HM1r1mq0bOugxrR8UchOQI3JLYH+YzomBnG1RtEswGJmaDTMo85XjxUBG7c0KWuUOgcOi6HW4ewq+eUiAnRv0UDwCDXeXY3ZzanlsVA9AN8hVRu2NnxmhAtMRkF2i6EgRavWHvHnpd3ui3HoO4K6RSmFG+HStEHz+VpWfeWdVCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716962829; c=relaxed/simple;
	bh=ZX8NhplzOoR+pbEltrosFZzKbdZnJRfuc6wNsTopcvg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ehzDgiuCffqZAeby2sh5vM7hME+Ik1/AkG+uGt0c04sQo0Pk/QWWwjnieKwHXv+2kgIpwBEPKB54yEpmNixv016UHtoqvmaFfCEXu00cyvykGaTlRnTFggeS3FAfMQjJPisZ2KV2lF7VTNdlNjhKXq7dyH9r6nyoeZCqmIf+YTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Idi5cux8; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716962823; x=1748498823;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ZX8NhplzOoR+pbEltrosFZzKbdZnJRfuc6wNsTopcvg=;
  b=Idi5cux8JGMuKbGVPb7zpto3kx5htiZTyY8W2l7zsTKSpNxKXMl5qvKk
   zt3RDfETFA/Ie4VUovZ2ZP4WLgYWgOjTxNdrKGFPzqJVUCnSKZfO0uMKy
   Nw2k14jA1VNjOjvN3Qdar31YQmNrFbpfqtJCryyu4pDYqeZazJRumDqFL
   mUSD1kdr73q1ZSTAEsPIt6wjjjdSWHibfZfmayHh3vYGcxcFwuo4RiaA4
   j2bIOIHitIi36TiIM/xtEWlWvmW9KggdMrXYpRa/JSaqPLf+0JVCInPoQ
   35aqZQX+QmB1HQ2WuTwfJrRZBkZ3WfZUTT8s34oct5LxXJLaz9hucgfm2
   w==;
X-CSE-ConnectionGUID: 21Sy4Hs0Rv2sc4qkGLX8Nw==
X-CSE-MsgGUID: wcb7FjL3RBiBPnl+nI8L5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17177872"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="17177872"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 23:07:00 -0700
X-CSE-ConnectionGUID: 8/dJemeyS8O5KxnIkcUojQ==
X-CSE-MsgGUID: rrNtaeiSQ6WeKcsDKZUbvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35263855"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 23:07:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 23:06:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 23:06:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 23:06:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 23:06:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebKqSoE1dApvW8q1D53mnPwzcQnfACZkW6j9sc/tGrLzsVtXKZUDPfqxahtznxZekgQ4YCceojJVQ+ep8wsfq1Ce7LvMiSQUuPnAtae3S64njAE0nRpV69NBReAzV6krIk5jNiavwfGKgHIAoEh4Wceu+9t7VwAOHdWzxti3WxT1y1Pp8SjTNEACrlIBMYUxR34igEvfdG6wSKy2UxewVNtnlOahrYFABoO4p3XJ1evyzM6Dd3850VNZ+xmRZQR5x3VhB15VK2VKBJtJKbZN2yh+o0bd6Y0ASOtdpRoGWZIBD8QD+28WSOeE3vcd/6V6HwqFisHZK9SJBOhHwwo2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTtgKtKwuwq3OYezCRds/fdAQXK6mFvdW0AMFV+I/Co=;
 b=cKTYxEy1PB2pAGeuUG1gHUjeP0h6dU+9dKhRTUMuepsn1yDQ28L4Iuh/hAK2M/63q3oXHGEFNm37iCA/oMnNMzdCQZ+SuURqydCnOkByk55hJwWukGQmGRvuM+PhwJqcBc5hgwaTBbTdYOE77vvJLAY2p/xMeG70qQZh3L0wupvS7avjqkWrDdsTDZ8ECFGkIIiXL71M9xIFRSkRReXPIm5ZYkYA5eS4wbZxWmebjI5bLx++9qwrg3BCRWCXFZi0Ey2klWutLWHBii1L4aKGz1KM4Kn5VFgIafLov8lvXWTbMOBkgc/Jx3HsD/DSc2CBpxrK2TnXeJDvKoqMomqDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4597.namprd11.prod.outlook.com (2603:10b6:208:268::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Wed, 29 May
 2024 06:06:49 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 06:06:49 +0000
Date: Wed, 29 May 2024 14:06:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Chunxin Zang <spring.cxz@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Chunxin Zang
	<zangchunxin@lixiang.com>, Chen Yang <yangchen11@lixiang.com>,
	<linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, <mingo@redhat.com>, <peterz@infradead.org>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<zhouchunhua@lixiang.com>, Chunxin Zang <spring.cxz@gmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] sched/fair: Reschedule the cfs_rq when current is
 ineligible
Message-ID: <202405291359.3f662525-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240524134011.270861-1-spring.cxz@gmail.com>
X-ClientProxiedBy: SGXP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::24)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4597:EE_
X-MS-Office365-Filtering-Correlation-Id: b53d15bb-d1e0-4bf3-a4fd-08dc7fa586d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?uL2C4rsK7XxXII+ZlYzqHs/5p6koPpZpdZW3/9UmaU+W4wvFfW5/jeIHWh?=
 =?iso-8859-1?Q?Quf6oy+K04vC+QrPkEwFzLt7t/caZ2GzT1ltNVdzXiuNMSqZZA/KN+x1Kc?=
 =?iso-8859-1?Q?LurULGm0diwqa0LJkfcu/HC4euKpbVwvqRR9VNJY1Iv3Nfj6ZbquG9/rW9?=
 =?iso-8859-1?Q?kDnKUiyGsqnuuNRjPbrC1JC9vFuE1x3eJd299ATSZy7mGM3tduTxcGPtLj?=
 =?iso-8859-1?Q?9uOJ+8tzBA71nN5w5Y5+K8dgcZRrQlkaxRxbdxwybHADGAjBStFmNkDwN7?=
 =?iso-8859-1?Q?2B0aODxeWDeA95JfuaOyLxpDi/C5irbUryMLlzTgrnYYsG2KwPcPkq67xV?=
 =?iso-8859-1?Q?faoIojKyfRU0LH9dOLVajYsGgi1xP/4+/G4PIWql2KnSFzq1k4warDBHig?=
 =?iso-8859-1?Q?1hYHzEBCvnkdHqOPABk9rl2+7oK1XCTsVszkKpOA8LG7sjKMmbMyxtAELA?=
 =?iso-8859-1?Q?Mmblysw3qXSp8s2kXiYkbhFQYpLIjFCwb0Nb25Bgtvu7iQU0s4d+yerLay?=
 =?iso-8859-1?Q?DVwPLI9QgUrFWfs0IdYv0Dq7g7NbHkJbb937qxDdmGOy9Rwcmffp7HqEli?=
 =?iso-8859-1?Q?sC+/Ly4bIUqQN8JatLBh18r28fAB1SuC7j6iTZ/AJaDfQkipxbs6C+feSW?=
 =?iso-8859-1?Q?6jy1GigoGxJNA3Plj9KwABeI4qlmxq8SS8NNH+VIBIB/xza4K1wjRYFKJI?=
 =?iso-8859-1?Q?rGBP5RsVW/J59CwlFTAy5ZDjA7gO0I5BycTift+MxkBqdP/KyDq52GCAS2?=
 =?iso-8859-1?Q?TxEijsInVCiBZIkZit8U82D2kCkGp8shEIlpG1+7z74iIuNUTQiZTuLTf8?=
 =?iso-8859-1?Q?+VpS4lIWiDlQVk80nR79VIbvTK3SBWUXBGAzbyrY6Q9/mPB1rPeYcwSCJe?=
 =?iso-8859-1?Q?gL4JLcc2V/7Re/OMx127M9gi5fk4J/bIl/GicWaLz0LoxpfGS37L3dOMMN?=
 =?iso-8859-1?Q?RxZSKKry2R+qS5yMJhSCBVYFC081yIQBtO55NeVWmI/3ErcBBu8CmWnCwL?=
 =?iso-8859-1?Q?/RwALcGHxXB3t2lgVUlC2lEN3D7CZ2DpBBXkaNA0KaVpQrXoipV4c0OgHd?=
 =?iso-8859-1?Q?wmU+TA21y04yzIkVRsd8yBHF3uGYa8QqmH6b+LH2MM4v5SgNhiOS6Z1/Rf?=
 =?iso-8859-1?Q?OrwtLbRzXArX/RPO2Gty3W3zvWn/NaPjI8AKZsZRQWPNErM2Z7HYup+g6a?=
 =?iso-8859-1?Q?NU6J9UysxWTI/T9zYgyfmMdJKhATuDgHrBQoSxhcQYsf7QqmtowBtimwIm?=
 =?iso-8859-1?Q?KTl97U6Fz6xT16xp5+77zW3XtCkQF3VfxqaHKLOgE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wItDQx///pyyAfcjFVtZmvjDx/hq7VLP5BAjcfjX798qGbwVh3dpUkaIwA?=
 =?iso-8859-1?Q?1qNQSr9c0DHycQyCCck3K8SCoi1FotZ4XU8zl5Z+It5XN5kqYKwLBr8MPR?=
 =?iso-8859-1?Q?UUzQjbf71AzBgmKmRfN8hXyiMMq7WeW7exDQch3U/Kk6cBnTk/hHIyiBIt?=
 =?iso-8859-1?Q?EK4M/n43Jyj2qYoQzRXDHVSMLXjv7iGDTIJ+to9cEEivDonvuaoiSqYLil?=
 =?iso-8859-1?Q?GBDD3nX9/qTnzIPZtm3ExVQDRl8M1qSYWBRVrelcA1M7WDrFooemiDQBO3?=
 =?iso-8859-1?Q?4JYh7DeUJRuRe9ludAwJbPzVDuJJnwLM5hEvg+qgONvipnNW+ASlCnlIxY?=
 =?iso-8859-1?Q?JJeSkFZpEZaAnrh1iftnYmYS6gGiXKnfcer6XESl27ZLxKuhjum6T92rrp?=
 =?iso-8859-1?Q?0ct/rXivoUciWxLm03ubSv2d514FDUDOYez7qf/sh2k4h0Xj7J8aD7xJca?=
 =?iso-8859-1?Q?sBEKHOQoIUj1yNWefEat4TdUMXtczMQwpONiERAfwXA+vjZSm6kPJTObWm?=
 =?iso-8859-1?Q?wgt0nXqtsnEyUB8eFejLBEQU72xvLa2Yggz3Md03mX+XVE2+4vutJyLiHC?=
 =?iso-8859-1?Q?7cHTlO5XOlxEWPd3BbCwWlcaYSPsJFzOSDoLisZx5fhp3wS0fNxdIpgCvu?=
 =?iso-8859-1?Q?wjaWnzJTXcPFzjaW/EVkMnk5znR+3XI5DMULfSV5M3aaRYlJOuxksiKni7?=
 =?iso-8859-1?Q?2z/L6/B4QYcDVHxcbXy2MlSUR0ZtC0ie/5D9+ftp9Ya3f+4Q/3w7HLIFmX?=
 =?iso-8859-1?Q?+dDWEgmMmz0pceaG2XfDd9O9YW0wRE3lqeAjt0HPNNDDJ6tfdrg9iZN3+t?=
 =?iso-8859-1?Q?Nq03QYR+ptT2bsJ6m173O2QZaqyCWCK5s0L9n71yExyZpmzKYeJ4sHfe+H?=
 =?iso-8859-1?Q?eF9Pv1Wgf8DShQTu9b2fr0gmL7eWxBTv627o7ipP7LDgB2rlQMJg8RPjJZ?=
 =?iso-8859-1?Q?6Ma+XhFxYEPF+NdcCLOjKFPen/W0GAMa+XwisJ3ws5fVIKco1vXpI3hjEj?=
 =?iso-8859-1?Q?Fo+nsJJvBn16C5KcgJfwVxY2qT7p/rlTN/SkWlGs2Ci30kkbPcgDivpCjW?=
 =?iso-8859-1?Q?cIpBv+611/0lrQgPN1kz3H1K2F0knu/nXuKr9VH0wsL1BJ2jRKCWT3piRg?=
 =?iso-8859-1?Q?FuLTpzJ2tW+xhsmIz3kN1MsF7ZZtR9k3pNLYWrkXU15m36jCUwY7SP2xOg?=
 =?iso-8859-1?Q?8iflh4bgixgSCcBAJKvpz0UueFJFVM/ZTbY4ZdYzKoaCrIKKYDypmryPc7?=
 =?iso-8859-1?Q?/mH1dNEaBo/BvuAqKRVFdNW+OupSIATJtoVK5CeysQyoHbmlrEaG5GoBeg?=
 =?iso-8859-1?Q?SyMQLtQFDOUtGlXbKagN4lo8gErzMomtTZHfFx++lsOH4y9kApfeEKt0HR?=
 =?iso-8859-1?Q?gPXieD53vdU0M/3AACt6iDdA2+Sf1iGpDcGfCu3Yeijq/5cm3LTr68E9vp?=
 =?iso-8859-1?Q?P9I0C9mEksLlW24cxrB8hz+DmO69OWFx6fWc9oRFkW56ZqERHUQiM4y4XE?=
 =?iso-8859-1?Q?nfqQ+Q0Bl3p0goqvtLjnxpJzAOh3jX1XlCEQVZdHfXyGgpnQdeyBagU4Ej?=
 =?iso-8859-1?Q?QLW5ctlVI/6Aw5iEGuIEGVzGjzWsgPSTlkxslhkSL48pfUoHS0XE7qPa53?=
 =?iso-8859-1?Q?NG/x7CqLPBausvBF3NHyJhTAx1Y5mUCJPTPImDxHEHrKbLZGMsxcty6A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b53d15bb-d1e0-4bf3-a4fd-08dc7fa586d8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:06:49.4975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eooCB+1dG96RAAfsVl7whvB3eHmjr7Yg0Hpk5Vc2HBkgNhokzGBu2Poay2SkKp0/v3rjyDKMn2ZGhH8fG4QcAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4597
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -11.8% regression of netperf.Throughput_Mbps on:


commit: e2bbd1c498980c5cb68f9973f418ae09f353258d ("[PATCH] sched/fair: Reschedule the cfs_rq when current is ineligible")
url: https://github.com/intel-lab-lkp/linux/commits/Chunxin-Zang/sched-fair-Reschedule-the-cfs_rq-when-current-is-ineligible/20240524-214314
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 97450eb909658573dcacc1063b06d3d08642c0c1
patch link: https://lore.kernel.org/all/20240524134011.270861-1-spring.cxz@gmail.com/
patch subject: [PATCH] sched/fair: Reschedule the cfs_rq when current is ineligible

testcase: netperf
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 200%
	cluster: cs-localhost
	test: UDP_STREAM
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.fstat.ops_per_sec -3.9% regression                                            |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory          |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | disk=1HDD                                                                                          |
|                  | fs=ext4                                                                                            |
|                  | nr_threads=100%                                                                                    |
|                  | test=fstat                                                                                         |
|                  | testtime=60s                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min 9.6% improvement                                                           |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | disk=4BRD_12G                                                                                      |
|                  | fs=xfs                                                                                             |
|                  | load=300                                                                                           |
|                  | md=RAID1                                                                                           |
|                  | test=sync_disk_rw                                                                                  |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | kbuild: kbuild.user_time_per_iteration 2.3% regression                                             |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory |
| test parameters  | build_kconfig=defconfig                                                                            |
|                  | cpufreq_governor=performance                                                                       |
|                  | nr_task=200%                                                                                       |
|                  | runtime=300s                                                                                       |
|                  | target=vmlinux                                                                                     |
+------------------+----------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405291359.3f662525-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240529/202405291359.3f662525-oliver.sang@intel.com

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-13/performance/ipv4/x86_64-rhel-8.3/200%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/UDP_STREAM/netperf

commit: 
  97450eb909 ("sched/pelt: Remove shift of thermal clock")
  e2bbd1c498 ("sched/fair: Reschedule the cfs_rq when current is ineligible")

97450eb909658573 e2bbd1c498980c5cb68f9973f41 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.46 ±  5%      +0.1        0.56 ±  4%  mpstat.cpu.all.irq%
   1867628 ±  2%     -12.6%    1632289 ±  8%  meminfo.Active
   1867580 ±  2%     -12.6%    1632257 ±  8%  meminfo.Active(anon)
   1865825 ±  2%     -12.7%    1629647 ±  9%  numa-meminfo.node1.Active
   1865809 ±  2%     -12.7%    1629633 ±  9%  numa-meminfo.node1.Active(anon)
     68.00 ±  8%    +136.3%     160.67 ± 18%  perf-c2c.DRAM.local
      2951 ±  9%     +98.5%       5858        perf-c2c.DRAM.remote
   7054758            -5.6%    6656686        vmstat.system.cs
    192398            -9.7%     173722        vmstat.system.in
 1.632e+09           -10.7%  1.458e+09        numa-numastat.node0.local_node
 1.633e+09           -10.7%  1.458e+09        numa-numastat.node0.numa_hit
 1.632e+09           -11.4%  1.446e+09        numa-numastat.node1.local_node
 1.633e+09           -11.4%  1.447e+09        numa-numastat.node1.numa_hit
 1.633e+09           -10.7%  1.458e+09        numa-vmstat.node0.numa_hit
 1.632e+09           -10.7%  1.458e+09        numa-vmstat.node0.numa_local
    466378 ±  2%     -12.6%     407484 ±  8%  numa-vmstat.node1.nr_active_anon
    466377 ±  2%     -12.6%     407484 ±  8%  numa-vmstat.node1.nr_zone_active_anon
 1.633e+09           -11.4%  1.447e+09        numa-vmstat.node1.numa_hit
 1.632e+09           -11.4%  1.446e+09        numa-vmstat.node1.numa_local
    467142 ±  3%     -12.7%     407846 ±  9%  proc-vmstat.nr_active_anon
     31481            +2.0%      32110        proc-vmstat.nr_kernel_stack
    467142 ±  3%     -12.7%     407846 ±  9%  proc-vmstat.nr_zone_active_anon
 3.266e+09           -11.0%  2.905e+09        proc-vmstat.numa_hit
 3.264e+09           -11.0%  2.904e+09        proc-vmstat.numa_local
 2.608e+10           -11.0%   2.32e+10        proc-vmstat.pgalloc_normal
 2.608e+10           -11.0%   2.32e+10        proc-vmstat.pgfree
     29563           -10.1%      26584        netperf.ThroughputBoth_Mbps
   7563274           -10.3%    6783505        netperf.ThroughputBoth_total_Mbps
      7788            -5.1%       7388        netperf.ThroughputRecv_Mbps
   1992482            -5.4%    1885347        netperf.ThroughputRecv_total_Mbps
     21775           -11.8%      19196        netperf.Throughput_Mbps
   5570791           -12.1%    4898158        netperf.Throughput_total_Mbps
 1.083e+09            -5.3%  1.025e+09        netperf.time.involuntary_context_switches
      8403            -3.4%       8116        netperf.time.percent_of_cpu_this_job_got
     24883            -3.5%      24000        netperf.time.system_time
    789.48            +1.2%     799.09        netperf.time.user_time
  4.33e+09           -10.3%  3.883e+09        netperf.workload
      4.31 ±  4%     +11.6%       4.81 ±  4%  sched_debug.cfs_rq:/.h_nr_running.max
      0.68 ±  3%     +12.6%       0.77        sched_debug.cfs_rq:/.h_nr_running.stddev
     16.51 ± 12%     +19.3%      19.70 ±  6%  sched_debug.cfs_rq:/.load_avg.avg
      5.04 ± 34%     +60.0%       8.07 ± 17%  sched_debug.cfs_rq:/.removed.load_avg.avg
     28.02 ± 21%     +27.6%      35.75 ±  7%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      2.48 ± 35%     +48.3%       3.68 ±  9%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
      2.48 ± 35%     +48.3%       3.68 ±  9%  sched_debug.cfs_rq:/.removed.util_avg.avg
    114.64 ±  8%     -10.3%     102.79 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
     36.81 ± 10%     +50.7%      55.47 ± 11%  sched_debug.cpu.clock.stddev
      0.00 ±  6%     +43.3%       0.00 ±  9%  sched_debug.cpu.next_balance.stddev
      4.31 ±  4%     +10.3%       4.75 ±  3%  sched_debug.cpu.nr_running.max
      0.68 ±  3%     +12.4%       0.76 ±  2%  sched_debug.cpu.nr_running.stddev
   7177076 ±  2%      -9.9%    6466454 ±  4%  sched_debug.cpu.nr_switches.min
      0.23 ± 88%    +290.5%       0.92 ± 24%  sched_debug.rt_rq:.rt_time.avg
     30.05 ± 88%    +290.5%     117.32 ± 24%  sched_debug.rt_rq:.rt_time.max
      2.65 ± 88%    +290.5%      10.33 ± 24%  sched_debug.rt_rq:.rt_time.stddev
      1.39 ±  3%    +232.7%       4.63        perf-stat.i.MPKI
 2.345e+10            -9.9%  2.113e+10        perf-stat.i.branch-instructions
      1.05            +0.0        1.09        perf-stat.i.branch-miss-rate%
 2.419e+08            -6.1%   2.27e+08        perf-stat.i.branch-misses
      4.04 ±  3%      +5.9        9.96        perf-stat.i.cache-miss-rate%
 1.769e+08 ±  3%    +200.3%  5.312e+08        perf-stat.i.cache-misses
  4.43e+09           +20.9%  5.355e+09        perf-stat.i.cache-references
   7118377            -5.9%    6699288        perf-stat.i.context-switches
      2.32           +10.4%       2.56        perf-stat.i.cpi
      1759 ±  4%     -63.3%     644.95        perf-stat.i.cycles-between-cache-misses
 1.271e+11            -9.9%  1.145e+11        perf-stat.i.instructions
      0.44            -9.1%       0.40        perf-stat.i.ipc
     55.61            -6.0%      52.29        perf-stat.i.metric.K/sec
      1.39 ±  3%    +233.2%       4.64        perf-stat.overall.MPKI
      1.03            +0.0        1.07        perf-stat.overall.branch-miss-rate%
      3.99 ±  3%      +5.9        9.91        perf-stat.overall.cache-miss-rate%
      2.31           +10.3%       2.55        perf-stat.overall.cpi
      1658 ±  3%     -66.9%     548.75        perf-stat.overall.cycles-between-cache-misses
      0.43            -9.4%       0.39        perf-stat.overall.ipc
 2.337e+10           -10.0%  2.103e+10        perf-stat.ps.branch-instructions
  2.41e+08            -6.2%   2.26e+08        perf-stat.ps.branch-misses
 1.764e+08 ±  3%    +199.8%   5.29e+08        perf-stat.ps.cache-misses
 4.417e+09           +20.8%  5.336e+09        perf-stat.ps.cache-references
   7096909            -6.0%    6672410        perf-stat.ps.context-switches
 1.266e+11           -10.0%   1.14e+11        perf-stat.ps.instructions
 3.879e+13           -10.0%  3.492e+13        perf-stat.total.instructions
     67.36            -3.1       64.24        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
     67.58            -3.1       64.47        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.send_omni_inner
     71.02            -3.0       68.03        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.send_omni_inner.send_udp_stream
     64.63            -2.9       61.72        perf-profile.calltrace.cycles-pp.udp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     72.79            -2.9       69.94        perf-profile.calltrace.cycles-pp.send_omni_inner.send_udp_stream.main
     72.82            -2.8       69.97        perf-profile.calltrace.cycles-pp.send_udp_stream.main
     71.47            -2.8       68.64        perf-profile.calltrace.cycles-pp.sendto.send_omni_inner.send_udp_stream.main
     70.66            -2.8       67.87        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendto.send_omni_inner.send_udp_stream.main
     45.90            -1.2       44.69        perf-profile.calltrace.cycles-pp.ip_make_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     15.20            -1.2       14.03        perf-profile.calltrace.cycles-pp.udp_send_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     14.76            -1.1       13.62        perf-profile.calltrace.cycles-pp.ip_send_skb.udp_send_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto
     13.76            -1.1       12.70        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg.__sys_sendto
     13.10            -1.0       12.09        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg
     10.87            -0.7       10.16        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb
     10.78            -0.7       10.07        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb
     10.64            -0.7        9.94        perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
     34.84            -0.6       34.20        perf-profile.calltrace.cycles-pp.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_sendmsg.__sys_sendto
      4.83 ±  4%      -0.6        4.19        perf-profile.calltrace.cycles-pp.__ip_make_skb.ip_make_skb.udp_sendmsg.__sys_sendto.__x64_sys_sendto
      9.72            -0.6        9.10        perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      4.34 ±  4%      -0.6        3.73        perf-profile.calltrace.cycles-pp.__ip_select_ident.__ip_make_skb.ip_make_skb.udp_sendmsg.__sys_sendto
      9.41            -0.6        8.82        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip
      9.33            -0.6        8.74        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.do_softirq
     33.97            -0.6       33.42        perf-profile.calltrace.cycles-pp._copy_from_iter.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_sendmsg
      8.70            -0.5        8.17        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__do_softirq
      7.36            -0.5        6.84 ±  2%  perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      7.29            -0.5        6.78 ±  2%  perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
      7.02            -0.5        6.54 ±  2%  perf-profile.calltrace.cycles-pp.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
      5.91            -0.4        5.56 ±  2%  perf-profile.calltrace.cycles-pp.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      5.81            -0.3        5.47 ±  2%  perf-profile.calltrace.cycles-pp.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.55            -0.3        0.25 ±100%  perf-profile.calltrace.cycles-pp.irqtime_account_irq.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      1.42            -0.2        1.22        perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb
      1.26            -0.2        1.08        perf-profile.calltrace.cycles-pp.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_send_skb
      1.49            -0.2        1.31        perf-profile.calltrace.cycles-pp.kfree_skb_reason.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu
      1.45            -0.2        1.27        perf-profile.calltrace.cycles-pp.skb_release_data.kfree_skb_reason.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv
      1.94 ±  2%      -0.2        1.77        perf-profile.calltrace.cycles-pp.ip_route_output_flow.udp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      1.54            -0.2        1.38        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      1.38 ±  3%      -0.1        1.26        perf-profile.calltrace.cycles-pp.ip_route_output_key_hash_rcu.ip_route_output_flow.udp_sendmsg.__sys_sendto.__x64_sys_sendto
      1.22 ±  3%      -0.1        1.12        perf-profile.calltrace.cycles-pp.fib_table_lookup.ip_route_output_key_hash_rcu.ip_route_output_flow.udp_sendmsg.__sys_sendto
      1.72            -0.1        1.63        perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.__ip_append_data.ip_make_skb.udp_sendmsg.__sys_sendto
      0.71            -0.1        0.62        perf-profile.calltrace.cycles-pp.__udp4_lib_lookup.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      1.35            -0.1        1.26        perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data.ip_make_skb.udp_sendmsg
      0.66            -0.1        0.59        perf-profile.calltrace.cycles-pp.__check_object_size.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_sendmsg
      0.79            -0.1        0.71        perf-profile.calltrace.cycles-pp.free_unref_page.skb_release_data.kfree_skb_reason.udp_queue_rcv_one_skb.udp_unicast_rcv_skb
      1.26            -0.1        1.19        perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data.ip_make_skb
      0.62            -0.1        0.57        perf-profile.calltrace.cycles-pp.move_addr_to_kernel.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.14            -0.0        1.11        perf-profile.calltrace.cycles-pp.recvfrom
      0.54            -0.0        0.52        perf-profile.calltrace.cycles-pp.sockfd_lookup_light.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.05            +0.1        3.13        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.send_omni_inner
      0.91 ± 17%      +0.2        1.07        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom.recv_omni
      2.12 ±  2%      +0.3        2.41        perf-profile.calltrace.cycles-pp.skb_page_frag_refill.sk_page_frag_refill.__ip_append_data.ip_make_skb.udp_sendmsg
      2.17 ±  2%      +0.3        2.46        perf-profile.calltrace.cycles-pp.sk_page_frag_refill.__ip_append_data.ip_make_skb.udp_sendmsg.__sys_sendto
      1.65 ±  3%      +0.3        1.95        perf-profile.calltrace.cycles-pp.alloc_pages_mpol.skb_page_frag_refill.sk_page_frag_refill.__ip_append_data.ip_make_skb
      0.59            +0.3        0.89        perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.alloc_pages_mpol.skb_page_frag_refill
      1.50 ±  3%      +0.3        1.81        perf-profile.calltrace.cycles-pp.__alloc_pages.alloc_pages_mpol.skb_page_frag_refill.sk_page_frag_refill.__ip_append_data
      1.19 ±  3%      +0.3        1.52        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.alloc_pages_mpol.skb_page_frag_refill.sk_page_frag_refill
      0.09 ±223%      +0.4        0.53 ±  4%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      0.00            +0.6        0.55        perf-profile.calltrace.cycles-pp.free_unref_page_commit.free_unref_page.skb_release_data.__consume_stateless_skb.udp_recvmsg
      0.82 ± 19%      +0.6        1.40        perf-profile.calltrace.cycles-pp.skb_release_data.__consume_stateless_skb.udp_recvmsg.inet_recvmsg.sock_recvmsg
      0.84 ± 19%      +0.6        1.40        perf-profile.calltrace.cycles-pp.__consume_stateless_skb.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      0.39 ± 70%      +0.6        1.01        perf-profile.calltrace.cycles-pp.free_unref_page.skb_release_data.__consume_stateless_skb.udp_recvmsg.inet_recvmsg
     14.08            +2.3       16.40        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg
     14.82            +2.4       17.18        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
     14.78            +2.4       17.16        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg.sock_recvmsg
     21.41            +2.8       24.22        perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     21.60            +2.8       24.42        perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.33            +2.8       24.14        perf-profile.calltrace.cycles-pp.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
     22.52            +2.8       25.36        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom
     21.96            +2.9       24.81        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom.recv_omni
     23.14            +2.9       26.02        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvfrom.recv_omni.process_requests.spawn_child
     23.11            +2.9       25.99        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom.recv_omni.process_requests
     23.45            +2.9       26.33        perf-profile.calltrace.cycles-pp.recvfrom.recv_omni.process_requests.spawn_child.accept_connection
     23.94            +2.9       26.87        perf-profile.calltrace.cycles-pp.recv_omni.process_requests.spawn_child.accept_connection.accept_connections
     21.17 ± 18%      +5.7       26.88        perf-profile.calltrace.cycles-pp.accept_connection.accept_connections.main
     21.17 ± 18%      +5.7       26.88        perf-profile.calltrace.cycles-pp.accept_connections.main
     21.17 ± 18%      +5.7       26.88        perf-profile.calltrace.cycles-pp.process_requests.spawn_child.accept_connection.accept_connections.main
     21.17 ± 18%      +5.7       26.88        perf-profile.calltrace.cycles-pp.spawn_child.accept_connection.accept_connections.main
     73.35            -3.0       70.38        perf-profile.children.cycles-pp.send_udp_stream
     73.55            -2.9       70.64        perf-profile.children.cycles-pp.sendto
     73.42            -2.9       70.53        perf-profile.children.cycles-pp.send_omni_inner
     67.53            -2.9       64.66        perf-profile.children.cycles-pp.__sys_sendto
     67.74            -2.9       64.88        perf-profile.children.cycles-pp.__x64_sys_sendto
     64.82            -2.7       62.13        perf-profile.children.cycles-pp.udp_sendmsg
     46.18            -1.2       44.97        perf-profile.children.cycles-pp.ip_make_skb
     15.36            -1.2       14.17        perf-profile.children.cycles-pp.udp_send_skb
     14.91            -1.2       13.76        perf-profile.children.cycles-pp.ip_send_skb
     13.90            -1.1       12.82        perf-profile.children.cycles-pp.ip_finish_output2
     13.25            -1.0       12.23        perf-profile.children.cycles-pp.__dev_queue_xmit
     11.02            -0.7       10.29        perf-profile.children.cycles-pp.__local_bh_enable_ip
     10.90            -0.7       10.18        perf-profile.children.cycles-pp.do_softirq
     10.77            -0.7       10.08        perf-profile.children.cycles-pp.__do_softirq
     35.12            -0.7       34.47        perf-profile.children.cycles-pp.ip_generic_getfrag
      4.90 ±  4%      -0.6        4.25        perf-profile.children.cycles-pp.__ip_make_skb
      9.82            -0.6        9.19        perf-profile.children.cycles-pp.net_rx_action
      4.39 ±  4%      -0.6        3.77        perf-profile.children.cycles-pp.__ip_select_ident
      9.51            -0.6        8.90        perf-profile.children.cycles-pp.__napi_poll
      9.43            -0.6        8.84        perf-profile.children.cycles-pp.process_backlog
     34.24            -0.6       33.68        perf-profile.children.cycles-pp._copy_from_iter
     40.92            -0.5       40.38        perf-profile.children.cycles-pp.__ip_append_data
      8.79            -0.5        8.26        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      7.44            -0.5        6.91 ±  2%  perf-profile.children.cycles-pp.ip_local_deliver_finish
      7.37            -0.5        6.86 ±  2%  perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
      7.11            -0.5        6.62 ±  2%  perf-profile.children.cycles-pp.__udp4_lib_rcv
      5.97            -0.4        5.61 ±  2%  perf-profile.children.cycles-pp.udp_unicast_rcv_skb
      5.91            -0.4        5.55 ±  2%  perf-profile.children.cycles-pp.udp_queue_rcv_one_skb
      1.45            -0.2        1.25        perf-profile.children.cycles-pp.dev_hard_start_xmit
      1.32            -0.2        1.13        perf-profile.children.cycles-pp.loopback_xmit
      1.52            -0.2        1.33        perf-profile.children.cycles-pp.kfree_skb_reason
      1.97 ±  2%      -0.2        1.80        perf-profile.children.cycles-pp.ip_route_output_flow
      1.56            -0.2        1.40        perf-profile.children.cycles-pp.ttwu_do_activate
      0.27            -0.1        0.15        perf-profile.children.cycles-pp.wakeup_preempt
      1.40 ±  3%      -0.1        1.28        perf-profile.children.cycles-pp.ip_route_output_key_hash_rcu
      0.18            -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.check_preempt_wakeup_fair
      1.24 ±  3%      -0.1        1.14        perf-profile.children.cycles-pp.fib_table_lookup
      0.74            -0.1        0.64        perf-profile.children.cycles-pp.__udp4_lib_lookup
      1.75            -0.1        1.66        perf-profile.children.cycles-pp.sock_alloc_send_pskb
      1.38            -0.1        1.29        perf-profile.children.cycles-pp.alloc_skb_with_frags
      1.30            -0.1        1.22        perf-profile.children.cycles-pp.__alloc_skb
      0.36            -0.1        0.29        perf-profile.children.cycles-pp.sock_wfree
      0.53 ±  2%      -0.1        0.46        perf-profile.children.cycles-pp.__netif_rx
      1.22            -0.1        1.14        perf-profile.children.cycles-pp.__check_object_size
      0.50            -0.1        0.43        perf-profile.children.cycles-pp.netif_rx_internal
      0.47 ±  2%      -0.1        0.40        perf-profile.children.cycles-pp.enqueue_to_backlog
      0.51            -0.1        0.44 ±  2%  perf-profile.children.cycles-pp.udp4_lib_lookup2
      0.32 ±  2%      -0.1        0.26        perf-profile.children.cycles-pp.pick_eevdf
      0.65            -0.1        0.59        perf-profile.children.cycles-pp.move_addr_to_kernel
      0.59            -0.1        0.53        perf-profile.children.cycles-pp.irqtime_account_irq
      0.83            -0.1        0.78        perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.56            -0.1        0.50        perf-profile.children.cycles-pp.sched_clock_cpu
      0.35            -0.0        0.30        perf-profile.children.cycles-pp.validate_xmit_skb
      0.48            -0.0        0.44        perf-profile.children.cycles-pp.sched_clock
      0.40            -0.0        0.36        perf-profile.children.cycles-pp._raw_spin_trylock
      0.40            -0.0        0.35        perf-profile.children.cycles-pp.reweight_entity
      0.46            -0.0        0.42        perf-profile.children.cycles-pp._copy_from_user
      0.94            -0.0        0.90        perf-profile.children.cycles-pp.update_load_avg
      1.11            -0.0        1.07        perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.36            -0.0        0.32        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.40 ±  2%      -0.0        0.36        perf-profile.children.cycles-pp.kmalloc_reserve
      0.43            -0.0        0.39        perf-profile.children.cycles-pp.native_sched_clock
      0.65            -0.0        0.61        perf-profile.children.cycles-pp.kmem_cache_free
      1.27            -0.0        1.23 ±  2%  perf-profile.children.cycles-pp.activate_task
      1.23            -0.0        1.20 ±  2%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.48            -0.0        0.45        perf-profile.children.cycles-pp.__virt_addr_valid
      0.78            -0.0        0.75        perf-profile.children.cycles-pp.check_heap_object
      0.17 ±  2%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.destroy_large_folio
      0.38            -0.0        0.35        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.33            -0.0        0.30        perf-profile.children.cycles-pp.__cond_resched
      0.12            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge
      0.36            -0.0        0.33        perf-profile.children.cycles-pp.__mkroute_output
      0.30            -0.0        0.27        perf-profile.children.cycles-pp.ip_output
      0.56            -0.0        0.53        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.24            -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.ip_setup_cork
      0.18            -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.ipv4_pktinfo_prepare
      0.27            -0.0        0.24        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.18 ±  2%      -0.0        0.16        perf-profile.children.cycles-pp.netif_skb_features
      0.27            -0.0        0.25 ±  2%  perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.51            -0.0        0.49        perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.26            -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.__ip_local_out
      0.17 ±  2%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.dst_release
      0.15            -0.0        0.13        perf-profile.children.cycles-pp.update_curr_se
      0.12            -0.0        0.10        perf-profile.children.cycles-pp.rcu_all_qs
      0.10 ±  5%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.vruntime_eligible
      0.13 ±  4%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.security_sock_rcv_skb
      0.29 ±  3%      -0.0        0.27        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.15            -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.ip_send_check
      0.19 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.siphash_3u32
      0.21 ±  3%      -0.0        0.19        perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.14 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__folio_put
      0.20 ±  2%      -0.0        0.18        perf-profile.children.cycles-pp.udp4_csum_init
      0.21 ±  2%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.ipv4_mtu
      0.25 ±  2%      -0.0        0.23        perf-profile.children.cycles-pp.skb_set_owner_w
      0.26            -0.0        0.24        perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      0.14 ±  2%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__ip_finish_output
      0.30            -0.0        0.29        perf-profile.children.cycles-pp.__update_load_avg_se
      0.15 ±  2%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.avg_vruntime
      0.08            -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.skb_network_protocol
      0.14            -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.check_stack_object
      0.13 ±  2%      -0.0        0.12        perf-profile.children.cycles-pp.xfrm_lookup_route
      0.14            -0.0        0.13        perf-profile.children.cycles-pp.__put_user_8
      0.09            -0.0        0.08        perf-profile.children.cycles-pp.nf_hook_slow
      0.09            -0.0        0.08        perf-profile.children.cycles-pp.raw_v4_input
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.validate_xmit_xfrm
      0.11            -0.0        0.10        perf-profile.children.cycles-pp.xfrm_lookup_with_ifid
      0.11            +0.0        0.12        perf-profile.children.cycles-pp.security_socket_recvmsg
      0.06            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.demo_interval_tick
      0.08 ±  4%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__build_skb_around
      0.07 ±  5%      +0.0        0.09        perf-profile.children.cycles-pp.should_failslab
      0.06            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.skb_clone_tx_timestamp
      0.37            +0.0        0.39        perf-profile.children.cycles-pp.simple_copy_to_iter
      0.06 ±  7%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.task_work_run
      0.06 ±  6%      +0.0        0.09        perf-profile.children.cycles-pp.task_mm_cid_work
      0.21 ±  2%      +0.0        0.24 ±  5%  perf-profile.children.cycles-pp.recv_data
      0.69            +0.0        0.73 ±  2%  perf-profile.children.cycles-pp.ip_rcv
      0.25            +0.0        0.30 ±  2%  perf-profile.children.cycles-pp.ip_rcv_core
      0.06 ± 13%      +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.__free_one_page
      0.85            +0.1        0.91        perf-profile.children.cycles-pp.switch_fpu_return
      0.71            +0.1        0.78 ±  2%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.28 ±  5%      +0.1        0.36 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.31 ±  5%      +0.1        0.40 ±  2%  perf-profile.children.cycles-pp.tick_nohz_handler
      4.78            +0.1        4.88        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.34 ±  4%      +0.1        0.44 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.43 ±  6%      +0.1        0.56 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.46 ±  6%      +0.1        0.59 ±  5%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.49 ±  5%      +0.2        0.64 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.58 ±  5%      +0.2        0.75 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      2.21 ±  2%      +0.3        2.50        perf-profile.children.cycles-pp.sk_page_frag_refill
      2.41            +0.3        2.69        perf-profile.children.cycles-pp.skb_release_data
      2.15 ±  2%      +0.3        2.44        perf-profile.children.cycles-pp.skb_page_frag_refill
      1.70 ±  2%      +0.3        1.99        perf-profile.children.cycles-pp.alloc_pages_mpol
      0.62 ±  2%      +0.3        0.92 ±  2%  perf-profile.children.cycles-pp.rmqueue
      1.54 ±  2%      +0.3        1.85        perf-profile.children.cycles-pp.__alloc_pages
      1.23 ±  3%      +0.3        1.56        perf-profile.children.cycles-pp.get_page_from_freelist
      0.08 ± 12%      +0.3        0.41 ±  3%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.18 ±  4%      +0.3        0.52 ±  2%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      1.40 ±  2%      +0.4        1.75        perf-profile.children.cycles-pp.free_unref_page
      0.09 ± 11%      +0.4        0.47 ±  2%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.27 ±  7%      +0.4        0.65        perf-profile.children.cycles-pp.free_unref_page_commit
      0.94 ±  2%      +0.5        1.41        perf-profile.children.cycles-pp.__consume_stateless_skb
      0.52            +0.6        1.10        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.06 ±  9%      +0.6        0.66 ±  3%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     14.10            +2.3       16.43        perf-profile.children.cycles-pp._copy_to_iter
     14.80            +2.4       17.17        perf-profile.children.cycles-pp.__skb_datagram_iter
     14.82            +2.4       17.19        perf-profile.children.cycles-pp.skb_copy_datagram_iter
     21.42            +2.8       24.24        perf-profile.children.cycles-pp.inet_recvmsg
     21.61            +2.8       24.43        perf-profile.children.cycles-pp.sock_recvmsg
     21.34            +2.8       24.16        perf-profile.children.cycles-pp.udp_recvmsg
     22.59            +2.8       25.43        perf-profile.children.cycles-pp.__x64_sys_recvfrom
     22.53            +2.8       25.37        perf-profile.children.cycles-pp.__sys_recvfrom
     24.70            +2.9       27.55        perf-profile.children.cycles-pp.recvfrom
     23.94            +2.9       26.88        perf-profile.children.cycles-pp.accept_connection
     23.94            +2.9       26.88        perf-profile.children.cycles-pp.accept_connections
     23.94            +2.9       26.88        perf-profile.children.cycles-pp.process_requests
     23.94            +2.9       26.88        perf-profile.children.cycles-pp.spawn_child
     23.94            +2.9       26.88        perf-profile.children.cycles-pp.recv_omni
     34.03            -0.6       33.41        perf-profile.self.cycles-pp._copy_from_iter
      4.17 ±  5%      -0.6        3.56 ±  2%  perf-profile.self.cycles-pp.__ip_select_ident
      0.87            -0.1        0.77        perf-profile.self.cycles-pp.__sys_sendto
      1.14            -0.1        1.04        perf-profile.self.cycles-pp.udp_sendmsg
      0.92 ±  3%      -0.1        0.84 ±  2%  perf-profile.self.cycles-pp.fib_table_lookup
      0.36            -0.1        0.28        perf-profile.self.cycles-pp.sock_wfree
      1.80            -0.1        1.72        perf-profile.self.cycles-pp.__ip_append_data
      0.31            -0.1        0.26        perf-profile.self.cycles-pp.loopback_xmit
      0.63            -0.1        0.58 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.30            -0.0        0.26        perf-profile.self.cycles-pp.udp4_lib_lookup2
      0.46            -0.0        0.41        perf-profile.self.cycles-pp.do_syscall_64
      0.58            -0.0        0.54        perf-profile.self.cycles-pp.ip_finish_output2
      0.38            -0.0        0.34        perf-profile.self.cycles-pp._raw_spin_trylock
      0.45            -0.0        0.41        perf-profile.self.cycles-pp._copy_from_user
      0.37            -0.0        0.33        perf-profile.self.cycles-pp.udp_send_skb
      0.34            -0.0        0.30 ±  2%  perf-profile.self.cycles-pp.__alloc_skb
      0.39 ±  3%      -0.0        0.36        perf-profile.self.cycles-pp.__dev_queue_xmit
      0.35            -0.0        0.31        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.42            -0.0        0.38        perf-profile.self.cycles-pp.native_sched_clock
      1.09            -0.0        1.06        perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.46 ±  2%      -0.0        0.43        perf-profile.self.cycles-pp.__virt_addr_valid
      0.32            -0.0        0.29        perf-profile.self.cycles-pp.__mkroute_output
      0.23 ±  4%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.pick_eevdf
      0.23 ±  2%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.__udp4_lib_lookup
      0.46            -0.0        0.43        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.21            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.ip_route_output_flow
      0.06            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.check_preempt_wakeup_fair
      0.26            -0.0        0.23 ±  2%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.29            -0.0        0.26        perf-profile.self.cycles-pp.net_rx_action
      0.11 ±  4%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__mem_cgroup_uncharge
      0.29 ±  2%      -0.0        0.26        perf-profile.self.cycles-pp.__check_object_size
      0.50            -0.0        0.48        perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.28            -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.process_backlog
      0.22 ±  2%      -0.0        0.19        perf-profile.self.cycles-pp.ip_output
      0.35            -0.0        0.33        perf-profile.self.cycles-pp.__ip_make_skb
      0.38            -0.0        0.36        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.26            -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.47            -0.0        0.45        perf-profile.self.cycles-pp.kmem_cache_free
      0.17 ±  2%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.reweight_entity
      0.22            -0.0        0.20        perf-profile.self.cycles-pp.__udp4_lib_rcv
      0.14            -0.0        0.12        perf-profile.self.cycles-pp.validate_xmit_skb
      0.15            -0.0        0.13        perf-profile.self.cycles-pp.dst_release
      0.36            -0.0        0.34        perf-profile.self.cycles-pp.__do_softirq
      0.10 ±  3%      -0.0        0.08        perf-profile.self.cycles-pp.rcu_all_qs
      0.08            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.vruntime_eligible
      0.24 ±  2%      -0.0        0.23 ±  4%  perf-profile.self.cycles-pp.__udp_enqueue_schedule_skb
      0.16 ±  4%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.enqueue_to_backlog
      0.19            -0.0        0.17        perf-profile.self.cycles-pp.siphash_3u32
      0.25            -0.0        0.24        perf-profile.self.cycles-pp.rseq_update_cpu_node_id
      0.14            -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.ip_send_check
      0.14            -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.ip_setup_cork
      0.28            -0.0        0.26        perf-profile.self.cycles-pp.__update_load_avg_se
      0.16            -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.ip_route_output_key_hash_rcu
      0.19            -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.19            -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.udp4_csum_init
      0.17            -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.ip_generic_getfrag
      0.23 ±  2%      -0.0        0.21 ±  3%  perf-profile.self.cycles-pp.ip_send_skb
      0.13            -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.update_curr_se
      0.12            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__netif_receive_skb_one_core
      0.08 ±  8%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__sk_mem_raise_allocated
      0.11 ±  3%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.security_sock_rcv_skb
      0.06 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.ip_local_deliver_finish
      0.20            -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.__cond_resched
      0.20 ±  3%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.ipv4_mtu
      0.30            -0.0        0.28 ±  2%  perf-profile.self.cycles-pp.__alloc_pages
      0.14 ±  2%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.do_softirq
      0.07 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.skb_network_protocol
      0.13            -0.0        0.12        perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.13            -0.0        0.12        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.14            -0.0        0.13        perf-profile.self.cycles-pp.ip_make_skb
      0.13            -0.0        0.12        perf-profile.self.cycles-pp.move_addr_to_kernel
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.__ip_finish_output
      0.14 ±  2%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.12 ±  3%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.recvfrom
      0.08 ±  6%      +0.0        0.09        perf-profile.self.cycles-pp.__build_skb_around
      0.28            +0.0        0.30        perf-profile.self.cycles-pp.udp_recvmsg
      0.06 ±  6%      +0.0        0.08        perf-profile.self.cycles-pp.should_failslab
      0.05            +0.0        0.07 ±  8%  perf-profile.self.cycles-pp.demo_interval_tick
      0.20            +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.__skb_datagram_iter
      0.26            +0.0        0.28        perf-profile.self.cycles-pp.prepare_task_switch
      0.06            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.21 ±  3%      +0.0        0.24 ±  4%  perf-profile.self.cycles-pp.recv_omni
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.update_rq_clock
      0.25            +0.1        0.30 ±  2%  perf-profile.self.cycles-pp.ip_rcv_core
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.skb_clone_tx_timestamp
      0.04 ± 71%      +0.1        0.10        perf-profile.self.cycles-pp.__free_one_page
      0.01 ±223%      +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.71            +0.1        0.78        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.10 ±  3%      +0.1        0.18 ±  3%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.06 ±  9%      +0.6        0.66 ±  3%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
     14.03            +2.3       16.35        perf-profile.self.cycles-pp._copy_to_iter


***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/1HDD/ext4/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/fstat/stress-ng/60s

commit: 
  97450eb909 ("sched/pelt: Remove shift of thermal clock")
  e2bbd1c498 ("sched/fair: Reschedule the cfs_rq when current is ineligible")

97450eb909658573 e2bbd1c498980c5cb68f9973f41 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      5.96 ±  2%     +22.6%       7.30 ±  3%  iostat.cpu.user
      6.10 ±  2%      +1.4        7.50 ±  3%  mpstat.cpu.all.usr%
    728616           +22.2%     890173        vmstat.system.cs
   1448236 ±  4%     -81.4%     268871 ± 17%  meminfo.Active
   1441121 ±  4%     -81.8%     261809 ± 18%  meminfo.Active(anon)
   6834186           +13.2%    7738594        meminfo.Inactive
   6821947           +13.3%    7726478        meminfo.Inactive(anon)
    152537 ± 31%     -94.5%       8342 ± 61%  numa-meminfo.node0.Active
    150754 ± 32%     -95.4%       6931 ± 78%  numa-meminfo.node0.Active(anon)
   1297193 ±  4%     -79.9%     261111 ± 16%  numa-meminfo.node1.Active
   1291857 ±  4%     -80.2%     255458 ± 16%  numa-meminfo.node1.Active(anon)
     37730 ± 32%     -95.4%       1725 ± 77%  numa-vmstat.node0.nr_active_anon
     37730 ± 32%     -95.4%       1725 ± 77%  numa-vmstat.node0.nr_zone_active_anon
    323570 ±  4%     -80.5%      63052 ± 16%  numa-vmstat.node1.nr_active_anon
    323570 ±  4%     -80.5%      63052 ± 16%  numa-vmstat.node1.nr_zone_active_anon
   4980068            -3.9%    4786411        stress-ng.fstat.ops
     83000            -3.9%      79773        stress-ng.fstat.ops_per_sec
  12565616           +88.8%   23722089        stress-ng.time.involuntary_context_switches
      4457            +8.9%       4855        stress-ng.time.percent_of_cpu_this_job_got
      2494            +7.3%       2678        stress-ng.time.system_time
    183.10 ±  2%     +30.7%     239.27 ±  2%  stress-ng.time.user_time
   7738050            -1.3%    7637067        stress-ng.time.voluntary_context_switches
   1011067           +10.6%    1118668        sched_debug.cfs_rq:/.avg_vruntime.min
     63124 ±  2%     +24.2%      78376 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.stddev
   1011067           +10.6%    1118668        sched_debug.cfs_rq:/.min_vruntime.min
     63124 ±  2%     +24.2%      78376 ±  3%  sched_debug.cfs_rq:/.min_vruntime.stddev
    779551 ±  5%     -16.6%     649990 ± 14%  sched_debug.cpu.curr->pid.avg
   1406043 ±  2%     -27.2%    1023836        sched_debug.cpu.curr->pid.max
    695149 ±  3%     -30.9%     480606 ±  6%  sched_debug.cpu.curr->pid.stddev
    356539           +22.0%     435017        sched_debug.cpu.nr_switches.avg
    375244           +21.5%     455819        sched_debug.cpu.nr_switches.max
    239983           +21.3%     290992        sched_debug.cpu.nr_switches.min
     17526 ±  2%     +25.0%      21908 ±  3%  sched_debug.cpu.nr_switches.stddev
    360657 ±  4%     -81.8%      65651 ± 18%  proc-vmstat.nr_active_anon
   2656885            -2.5%    2589142        proc-vmstat.nr_file_pages
   1706585           +13.3%    1933352        proc-vmstat.nr_inactive_anon
     20023            +1.3%      20285        proc-vmstat.nr_kernel_stack
   1863195            -3.6%    1795497        proc-vmstat.nr_shmem
    360657 ±  4%     -81.8%      65651 ± 18%  proc-vmstat.nr_zone_active_anon
   1706585           +13.3%    1933352        proc-vmstat.nr_zone_inactive_anon
  56763914            -6.2%   53230553        proc-vmstat.numa_hit
  56704746            -6.2%   53170292        proc-vmstat.numa_local
     57428 ±  2%     -50.0%      28742 ±  4%  proc-vmstat.pgactivate
  76049389            -7.0%   70719008        proc-vmstat.pgalloc_normal
  73054423            -7.1%   67838944        proc-vmstat.pgfree
      1.88           -18.2%       1.54        perf-stat.i.MPKI
 2.208e+10           +17.1%  2.586e+10        perf-stat.i.branch-instructions
      0.30            -0.0        0.27        perf-stat.i.branch-miss-rate%
  61030073            +4.7%   63912456        perf-stat.i.branch-misses
     25.57            -0.3       25.30        perf-stat.i.cache-miss-rate%
 2.211e+08            -2.8%  2.149e+08        perf-stat.i.cache-misses
 8.649e+08            -1.7%  8.499e+08        perf-stat.i.cache-references
    765417           +21.4%     928892        perf-stat.i.context-switches
      1.90           -16.2%       1.59        perf-stat.i.cpi
    168415           -15.6%     142157        perf-stat.i.cpu-migrations
      1008            +2.6%       1034        perf-stat.i.cycles-between-cache-misses
 1.177e+11           +18.5%  1.394e+11        perf-stat.i.instructions
      0.53           +18.7%       0.63        perf-stat.i.ipc
     14.67           +14.4%      16.78        perf-stat.i.metric.K/sec
      1.88           -18.0%       1.54        perf-stat.overall.MPKI
      0.28            -0.0        0.25        perf-stat.overall.branch-miss-rate%
     25.57            -0.3       25.30        perf-stat.overall.cache-miss-rate%
      1.89           -15.8%       1.59        perf-stat.overall.cpi
      1007            +2.6%       1033        perf-stat.overall.cycles-between-cache-misses
      0.53           +18.8%       0.63        perf-stat.overall.ipc
    724089 ±  6%     +17.5%     850512 ±  7%  perf-stat.ps.context-switches
    159312 ±  6%     -18.3%     130155 ±  7%  perf-stat.ps.cpu-migrations
 4.962e+12 ±  2%     +21.1%  6.007e+12 ±  2%  perf-stat.total.instructions
     60.50           -11.7       48.80        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     60.48           -11.7       48.78        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     33.86            -7.5       26.35        perf-profile.calltrace.cycles-pp.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
     33.85            -7.5       26.34        perf-profile.calltrace.cycles-pp.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
     29.48            -7.4       22.06        perf-profile.calltrace.cycles-pp.exit_notify.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.34            -4.2       21.15        perf-profile.calltrace.cycles-pp.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.38            -4.2       17.18        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.29            -4.2       21.10        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.14            -4.1       10.07        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.copy_process.kernel_clone.__do_sys_clone3.do_syscall_64
     13.70            -4.1        9.65        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.copy_process.kernel_clone.__do_sys_clone3
     13.86            -3.7       10.11        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.exit_notify.do_exit.__x64_sys_exit.do_syscall_64
     13.42            -3.7        9.68        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.exit_notify.do_exit.__x64_sys_exit
     15.23            -3.6       11.59        perf-profile.calltrace.cycles-pp.release_task.exit_notify.do_exit.__x64_sys_exit.do_syscall_64
     13.21            -3.6        9.59        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.release_task.exit_notify.do_exit.__x64_sys_exit
     12.73            -3.6        9.12        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.release_task.exit_notify.do_exit
      0.53            -0.3        0.25 ±100%  perf-profile.calltrace.cycles-pp.remove_vm_area.vfree.delayed_vfree_work.process_one_work.worker_thread
      1.20            -0.1        1.09        perf-profile.calltrace.cycles-pp.__schedule.do_task_dead.do_exit.__x64_sys_exit.do_syscall_64
      2.66            -0.1        2.54        perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      2.44            -0.1        2.32        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      1.22            -0.1        1.10        perf-profile.calltrace.cycles-pp.do_task_dead.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.29            -0.1        2.19        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.72            -0.1        0.66        perf-profile.calltrace.cycles-pp.__schedule.schedule.futex_wait_queue.__futex_wait.futex_wait
      0.85            -0.1        0.78        perf-profile.calltrace.cycles-pp.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.84            -0.1        0.78        perf-profile.calltrace.cycles-pp.futex_wait.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.83            -0.1        0.76        perf-profile.calltrace.cycles-pp.__futex_wait.futex_wait.do_futex.__x64_sys_futex.do_syscall_64
      0.74            -0.1        0.67        perf-profile.calltrace.cycles-pp.futex_wait_queue.__futex_wait.futex_wait.do_futex.__x64_sys_futex
      0.73            -0.1        0.66        perf-profile.calltrace.cycles-pp.schedule.futex_wait_queue.__futex_wait.futex_wait.do_futex
      0.85            -0.1        0.79        perf-profile.calltrace.cycles-pp.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.05            -0.1        0.99        perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.50            -0.0        1.45        perf-profile.calltrace.cycles-pp.alloc_pid.copy_process.kernel_clone.__do_sys_clone3.do_syscall_64
      1.17            -0.0        1.12        perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.24            -0.0        1.19        perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.85            -0.0        0.81        perf-profile.calltrace.cycles-pp.delayed_vfree_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.80            -0.0        0.76        perf-profile.calltrace.cycles-pp.vfree.delayed_vfree_work.process_one_work.worker_thread.kthread
      0.94            -0.0        0.90        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.alloc_pid.copy_process.kernel_clone
      1.16            -0.0        1.12        perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.94            -0.0        0.90        perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.12            -0.0        1.08        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.alloc_pid.copy_process.kernel_clone.__do_sys_clone3
      1.15            -0.0        1.11        perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
      1.14            -0.0        1.10        perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn
      0.90            -0.0        0.87        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
      0.89            -0.0        0.86        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.88            -0.0        0.86        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.82            -0.0        0.79        perf-profile.calltrace.cycles-pp.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct.copy_process
      0.89            -0.0        0.87        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.67            -0.0        0.65        perf-profile.calltrace.cycles-pp.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.66            -0.0        0.64        perf-profile.calltrace.cycles-pp.__alloc_pages_bulk.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      0.92            -0.0        0.89        perf-profile.calltrace.cycles-pp.__madvise
      2.11            +0.0        2.13        perf-profile.calltrace.cycles-pp.update_sg_wakeup_stats.sched_balance_find_dst_group.sched_balance_find_dst_cpu.select_task_rq_fair.wake_up_new_task
      0.61            +0.0        0.64        perf-profile.calltrace.cycles-pp.do_futex.mm_release.exit_mm.do_exit.__x64_sys_exit
      0.60            +0.0        0.64        perf-profile.calltrace.cycles-pp.futex_wake.do_futex.mm_release.exit_mm.do_exit
      0.64            +0.0        0.67        perf-profile.calltrace.cycles-pp.mm_release.exit_mm.do_exit.__x64_sys_exit.do_syscall_64
      0.78            +0.0        0.82        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.52            +0.2        0.70        perf-profile.calltrace.cycles-pp.kmem_cache_free.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
      0.53            +0.2        0.72        perf-profile.calltrace.cycles-pp.cp_statx.do_statx.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.53            +0.2        0.72        perf-profile.calltrace.cycles-pp.security_inode_getattr.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      0.55            +0.2        0.75        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.strncpy_from_user.getname_flags.vfs_fstatat
      0.51            +0.2        0.72        perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.64 ±  3%      +0.2        0.86        perf-profile.calltrace.cycles-pp.shim_statx
      0.64            +0.3        0.89        perf-profile.calltrace.cycles-pp.complete_walk.path_lookupat.filename_lookup.vfs_statx.do_statx
      0.70            +0.3        0.95        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.strncpy_from_user.getname_flags.__x64_sys_statx
      0.72            +0.3        0.99        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.getname_flags.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      0.63            +0.3        0.90        perf-profile.calltrace.cycles-pp.dput.path_put.vfs_statx.vfs_fstatat.__do_sys_newfstatat
      0.43 ± 44%      +0.3        0.72        perf-profile.calltrace.cycles-pp.lockref_put_return.dput.path_put.vfs_statx.vfs_fstatat
      0.67            +0.3        0.96        perf-profile.calltrace.cycles-pp.path_put.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      0.67            +0.3        0.96        perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.42 ± 44%      +0.3        0.71        perf-profile.calltrace.cycles-pp.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.83            +0.3        1.13        perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.do_statx
      0.75            +0.3        1.08        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.75            +0.3        1.08        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.93            +0.3        1.28        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.getname_flags.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.04            +0.4        1.40        perf-profile.calltrace.cycles-pp.cp_new_stat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.87            +0.4        1.23        perf-profile.calltrace.cycles-pp.__sched_yield
      1.09            +0.4        1.48        perf-profile.calltrace.cycles-pp.__check_object_size.strncpy_from_user.getname_flags.vfs_fstatat.__do_sys_newfstatat
      1.42            +0.5        1.89        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.statx
      1.42            +0.5        1.90        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.fstatat64
      1.38            +0.5        1.88        perf-profile.calltrace.cycles-pp.__check_object_size.strncpy_from_user.getname_flags.__x64_sys_statx.do_syscall_64
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp._copy_to_user.cp_new_stat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.54 ±  2%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.path_lookupat.filename_lookup.vfs_statx
      1.38            +0.5        1.93        perf-profile.calltrace.cycles-pp.complete_walk.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      0.00            +0.6        0.55        perf-profile.calltrace.cycles-pp.path_init.path_lookupat.filename_lookup.vfs_statx.do_statx
      0.00            +0.6        0.59        perf-profile.calltrace.cycles-pp.common_perm_cond.security_inode_getattr.vfs_statx.vfs_fstatat.__do_sys_newfstatat
      0.00            +0.6        0.60 ±  2%  perf-profile.calltrace.cycles-pp.path_init.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      0.00            +0.6        0.65 ±  2%  perf-profile.calltrace.cycles-pp.walk_component.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      1.84            +0.7        2.50        perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      0.00            +0.7        0.67 ±  2%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      1.69            +0.7        2.37        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat.filename_lookup
      2.09            +0.7        2.81        perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      1.90            +0.8        2.65        perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.path_lookupat.filename_lookup.vfs_statx
      2.30            +0.8        3.14        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.do_statx.__x64_sys_statx
      2.63            +0.9        3.54        perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.95            +1.0        1.91        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat
      2.87            +1.0        3.92        perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.do_statx.__x64_sys_statx.do_syscall_64
      3.50            +1.2        4.72        perf-profile.calltrace.cycles-pp.getname_flags.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.10            +1.4        5.54        perf-profile.calltrace.cycles-pp.getname_flags.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
      4.03            +1.5        5.52        perf-profile.calltrace.cycles-pp.vfs_statx.do_statx.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.67            +1.7        6.40        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat
      5.24            +1.9        7.15        perf-profile.calltrace.cycles-pp.do_statx.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
      5.44            +2.0        7.44        perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      7.67            +2.8       10.49        perf-profile.calltrace.cycles-pp.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.57            +3.8       14.36        perf-profile.calltrace.cycles-pp.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
     11.30            +4.1       15.41        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
     11.56            +4.2       15.77        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.statx
     12.09            +4.4       16.46        perf-profile.calltrace.cycles-pp.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
     13.87            +5.0       18.84        perf-profile.calltrace.cycles-pp.statx
     13.97            +5.0       18.98        perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
     14.70            +5.3       20.04        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
     14.99            +5.5       20.46        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatat64
     17.21            +6.2       23.42        perf-profile.calltrace.cycles-pp.fstatat64
     43.74           -11.4       32.30        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     41.21           -11.4       29.78        perf-profile.children.cycles-pp.queued_write_lock_slowpath
     33.86            -7.5       26.35        perf-profile.children.cycles-pp.__x64_sys_exit
     33.86            -7.5       26.36        perf-profile.children.cycles-pp.do_exit
     29.50            -7.4       22.07        perf-profile.children.cycles-pp.exit_notify
     25.30            -4.2       21.10        perf-profile.children.cycles-pp.kernel_clone
     25.34            -4.2       21.15        perf-profile.children.cycles-pp.__do_sys_clone3
     21.40            -4.2       17.21        perf-profile.children.cycles-pp.copy_process
     15.24            -3.6       11.60        perf-profile.children.cycles-pp.release_task
     89.78            -2.0       87.81        perf-profile.children.cycles-pp.do_syscall_64
     90.27            -1.8       88.48        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.73            -0.2        0.58        perf-profile.children.cycles-pp.sched_balance_newidle
      0.64            -0.1        0.50 ±  2%  perf-profile.children.cycles-pp.sched_balance_rq
      1.22            -0.1        1.10        perf-profile.children.cycles-pp.do_task_dead
      2.44            -0.1        2.32        perf-profile.children.cycles-pp.ret_from_fork
      2.66            -0.1        2.54        perf-profile.children.cycles-pp.ret_from_fork_asm
      1.70            -0.1        1.60        perf-profile.children.cycles-pp.__do_softirq
      2.29            -0.1        2.19        perf-profile.children.cycles-pp.kthread
      1.59            -0.1        1.49        perf-profile.children.cycles-pp.rcu_core
      1.56            -0.1        1.47        perf-profile.children.cycles-pp.rcu_do_batch
      0.91            -0.1        0.83        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.74            -0.1        0.67        perf-profile.children.cycles-pp.futex_wait_queue
      0.84            -0.1        0.78        perf-profile.children.cycles-pp.futex_wait
      0.85            -0.1        0.79        perf-profile.children.cycles-pp.__x64_sys_futex
      0.54            -0.1        0.48        perf-profile.children.cycles-pp.irq_exit_rcu
      0.83            -0.1        0.77        perf-profile.children.cycles-pp.__futex_wait
      1.05            -0.1        0.99        perf-profile.children.cycles-pp.worker_thread
      0.21            -0.1        0.16 ±  2%  perf-profile.children.cycles-pp.detach_tasks
      0.87            -0.0        0.83        perf-profile.children.cycles-pp.activate_task
      1.50            -0.0        1.46        perf-profile.children.cycles-pp.alloc_pid
      1.17            -0.0        1.12        perf-profile.children.cycles-pp.run_ksoftirqd
      1.24            -0.0        1.19        perf-profile.children.cycles-pp.smpboot_thread_fn
      0.55            -0.0        0.51 ±  2%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.85            -0.0        0.81        perf-profile.children.cycles-pp.delayed_vfree_work
      0.54            -0.0        0.50 ±  2%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.94            -0.0        0.90        perf-profile.children.cycles-pp.process_one_work
      0.55            -0.0        0.51 ±  2%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.80            -0.0        0.76        perf-profile.children.cycles-pp.vfree
      0.19 ±  3%      -0.0        0.15        perf-profile.children.cycles-pp.free_unref_page_commit
      0.24 ±  2%      -0.0        0.20        perf-profile.children.cycles-pp.free_unref_page
      0.50            -0.0        0.46 ±  2%  perf-profile.children.cycles-pp.read
      0.49            -0.0        0.45        perf-profile.children.cycles-pp.ksys_read
      0.89            -0.0        0.85        perf-profile.children.cycles-pp.enqueue_task_fair
      0.48            -0.0        0.44 ±  2%  perf-profile.children.cycles-pp.seq_read
      0.48            -0.0        0.44 ±  2%  perf-profile.children.cycles-pp.seq_read_iter
      0.44            -0.0        0.41 ±  2%  perf-profile.children.cycles-pp.proc_pid_status
      0.17 ±  4%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.48            -0.0        0.44 ±  3%  perf-profile.children.cycles-pp.machine__process_fork_event
      0.48            -0.0        0.44        perf-profile.children.cycles-pp.vfs_read
      0.95            -0.0        0.91        perf-profile.children.cycles-pp.dequeue_task_fair
      1.46            -0.0        1.42        perf-profile.children.cycles-pp.do_futex
      0.19 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.47            -0.0        0.44 ±  2%  perf-profile.children.cycles-pp.____machine__findnew_thread
      0.45            -0.0        0.41        perf-profile.children.cycles-pp.proc_single_show
      0.78            -0.0        0.74        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.20            -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.56            -0.0        0.53        perf-profile.children.cycles-pp.dequeue_entity
      0.19 ±  4%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__put_partials
      0.51            -0.0        0.48        perf-profile.children.cycles-pp.enqueue_entity
      0.53            -0.0        0.50        perf-profile.children.cycles-pp.remove_vm_area
      0.17 ±  2%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.92            -0.0        0.90        perf-profile.children.cycles-pp.__madvise
      0.89            -0.0        0.86        perf-profile.children.cycles-pp.__x64_sys_madvise
      0.82            -0.0        0.79        perf-profile.children.cycles-pp.__vmalloc_area_node
      0.89            -0.0        0.86        perf-profile.children.cycles-pp.do_madvise
      0.68            -0.0        0.65        perf-profile.children.cycles-pp.madvise_vma_behavior
      0.28            -0.0        0.25        perf-profile.children.cycles-pp.__slab_free
      0.66            -0.0        0.64        perf-profile.children.cycles-pp.__alloc_pages_bulk
      0.09            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.63            -0.0        0.61        perf-profile.children.cycles-pp.zap_page_range_single
      0.52            -0.0        0.50        perf-profile.children.cycles-pp.perf_event_task_output
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.11 ±  4%      -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.80            -0.0        0.78        perf-profile.children.cycles-pp.__exit_signal
      0.09            -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.schedule_tail
      0.57            -0.0        0.55        perf-profile.children.cycles-pp.perf_iterate_sb
      0.14 ±  3%      -0.0        0.13        perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.48            -0.0        0.46        perf-profile.children.cycles-pp.clear_page_erms
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.__free_pages
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.bitmap_string
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.mem_cgroup_handle_over_high
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.06            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.cpuacct_charge
      0.06            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.os_xsave
      0.18 ±  2%      +0.0        0.19        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.select_idle_sibling
      0.07 ±  5%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.shmem_is_huge
      0.09 ±  5%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.11 ±  3%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.select_task_rq
      0.09            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__switch_to
      0.10 ±  3%      +0.0        0.12        perf-profile.children.cycles-pp.___perf_sw_event
      0.05            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.make_vfsgid
      0.07 ±  5%      +0.0        0.09        perf-profile.children.cycles-pp.__enqueue_entity
      0.13            +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.stress_fstat_thread
      0.21            +0.0        0.23        perf-profile.children.cycles-pp.set_next_entity
      0.05            +0.0        0.07        perf-profile.children.cycles-pp.proc_pid_get_link
      0.07            +0.0        0.09        perf-profile.children.cycles-pp.pick_eevdf
      0.49            +0.0        0.51        perf-profile.children.cycles-pp.try_to_wake_up
      0.41            +0.0        0.43        perf-profile.children.cycles-pp.wake_up_q
      0.22 ±  2%      +0.0        0.25        perf-profile.children.cycles-pp.switch_fpu_return
      0.12 ±  4%      +0.0        0.15        perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.18 ±  2%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.06 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__x64_sys_newfstatat
      0.17 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.03 ± 70%      +0.0        0.06        perf-profile.children.cycles-pp.statx@plt
      0.19 ±  2%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.33            +0.0        0.36 ±  3%  perf-profile.children.cycles-pp.pick_link
      0.09            +0.0        0.12        perf-profile.children.cycles-pp.should_failslab
      0.05            +0.0        0.08        perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.07            +0.0        0.10        perf-profile.children.cycles-pp.mntput
      0.60            +0.0        0.64        perf-profile.children.cycles-pp.futex_wake
      0.24 ±  2%      +0.0        0.27 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.23 ±  2%      +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.10 ±  4%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.legitimize_links
      0.64            +0.0        0.67        perf-profile.children.cycles-pp.mm_release
      0.16            +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.prepare_task_switch
      0.07            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.yield_task_fair
      0.78            +0.0        0.82        perf-profile.children.cycles-pp.exit_mm
      0.12 ±  3%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.mntput_no_expire
      0.15 ±  3%      +0.0        0.19        perf-profile.children.cycles-pp.__get_user_1
      0.18            +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.13 ±  3%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.vfs_fstat
      0.20            +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.02 ±141%      +0.0        0.06 ± 17%  perf-profile.children.cycles-pp.try_to_unlazy_next
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.apparmor_inode_getattr
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.tid_fd_revalidate
      0.16 ±  3%      +0.1        0.21        perf-profile.children.cycles-pp.security_inode_permission
      0.17 ±  2%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.from_kgid_munged
      0.15            +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.is_vmalloc_addr
      0.15 ±  2%      +0.1        0.21        perf-profile.children.cycles-pp.amd_clear_divider
      0.16            +0.1        0.22        perf-profile.children.cycles-pp.from_kuid_munged
      0.67            +0.1        0.73        perf-profile.children.cycles-pp.update_curr
      0.11 ±  4%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.put_prev_entity
      0.24 ±  4%      +0.1        0.31 ±  5%  perf-profile.children.cycles-pp.__fdget_raw
      0.23 ±  2%      +0.1        0.30        perf-profile.children.cycles-pp.rcu_all_qs
      0.19 ± 16%      +0.1        0.26 ± 10%  perf-profile.children.cycles-pp.__lookup_mnt
      0.16 ±  2%      +0.1        0.23        perf-profile.children.cycles-pp.do_sched_yield
      0.26            +0.1        0.34        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.23 ±  2%      +0.1        0.32 ±  5%  perf-profile.children.cycles-pp.terminate_walk
      0.24 ±  2%      +0.1        0.33        perf-profile.children.cycles-pp.make_vfsuid
      0.28            +0.1        0.38        perf-profile.children.cycles-pp.map_id_up
      1.42            +0.1        1.52 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.28            +0.1        0.39        perf-profile.children.cycles-pp.check_stack_object
      0.32            +0.1        0.44        perf-profile.children.cycles-pp.generic_fillattr
      0.34            +0.1        0.46 ±  2%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.31 ±  4%      +0.1        0.46 ±  6%  perf-profile.children.cycles-pp.set_root
      0.44            +0.1        0.59        perf-profile.children.cycles-pp.vfs_getattr_nosec
      0.49            +0.2        0.64        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.53            +0.2        0.70 ±  2%  perf-profile.children.cycles-pp.generic_permission
      0.58            +0.2        0.76        perf-profile.children.cycles-pp.shmem_getattr
      0.55            +0.2        0.74        perf-profile.children.cycles-pp.cp_statx
      0.45 ±  2%      +0.2        0.64 ±  4%  perf-profile.children.cycles-pp.nd_jump_root
      0.62            +0.2        0.82        perf-profile.children.cycles-pp.__check_heap_object
      0.69            +0.2        0.91        perf-profile.children.cycles-pp._copy_to_user
      0.66 ±  3%      +0.2        0.88        perf-profile.children.cycles-pp.shim_statx
      0.60            +0.2        0.84        perf-profile.children.cycles-pp.__cond_resched
      0.45 ± 34%      +0.2        0.70 ± 25%  perf-profile.children.cycles-pp.stress_fstat_helper
      0.67            +0.2        0.91        perf-profile.children.cycles-pp.common_perm_cond
      0.66 ±  2%      +0.2        0.90 ±  2%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.66 ±  4%      +0.2        0.91 ±  4%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.77            +0.3        1.04        perf-profile.children.cycles-pp.inode_permission
      2.72            +0.3        3.01        perf-profile.children.cycles-pp.__schedule
      0.82            +0.3        1.11        perf-profile.children.cycles-pp.putname
      0.67            +0.3        0.96        perf-profile.children.cycles-pp.__x64_sys_sched_yield
      1.06 ±  2%      +0.3        1.36 ±  2%  perf-profile.children.cycles-pp.step_into
      0.81            +0.3        1.11        perf-profile.children.cycles-pp.security_inode_getattr
      1.94            +0.3        2.27        perf-profile.children.cycles-pp.kmem_cache_free
      0.88            +0.3        1.21 ±  2%  perf-profile.children.cycles-pp.path_init
      0.82            +0.3        1.16 ±  2%  perf-profile.children.cycles-pp.lockref_put_return
      1.44            +0.3        1.78        perf-profile.children.cycles-pp.schedule
      1.00 ±  2%      +0.3        1.34 ±  2%  perf-profile.children.cycles-pp.lookup_fast
      0.88            +0.4        1.24        perf-profile.children.cycles-pp.__sched_yield
      1.08            +0.4        1.45        perf-profile.children.cycles-pp.cp_new_stat
      1.19 ±  2%      +0.4        1.60 ±  2%  perf-profile.children.cycles-pp.walk_component
      1.07            +0.4        1.50        perf-profile.children.cycles-pp.path_put
      1.51            +0.5        1.96        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.13            +0.5        1.58        perf-profile.children.cycles-pp.dput
      1.37            +0.5        1.86        perf-profile.children.cycles-pp.check_heap_object
      1.27            +0.5        1.79        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.43            +0.6        2.00        perf-profile.children.cycles-pp.lockref_get_not_dead
      1.87            +0.6        2.46        perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.84            +0.7        2.50        perf-profile.children.cycles-pp.kmem_cache_alloc
      1.80            +0.7        2.52        perf-profile.children.cycles-pp.__legitimize_path
      1.96            +0.8        2.73        perf-profile.children.cycles-pp.try_to_unlazy
      2.04            +0.8        2.85        perf-profile.children.cycles-pp.complete_walk
      2.84            +1.0        3.81        perf-profile.children.cycles-pp.link_path_walk
      2.78            +1.0        3.75        perf-profile.children.cycles-pp.__check_object_size
      4.85            +1.7        6.52        perf-profile.children.cycles-pp.strncpy_from_user
      5.28            +1.9        7.21        perf-profile.children.cycles-pp.do_statx
      7.37            +2.6        9.97        perf-profile.children.cycles-pp.path_lookupat
      8.01            +2.8       10.82        perf-profile.children.cycles-pp.getname_flags
      8.65            +3.0       11.70        perf-profile.children.cycles-pp.filename_lookup
     10.65            +3.8       14.48        perf-profile.children.cycles-pp.__x64_sys_statx
     12.16            +4.3       16.49        perf-profile.children.cycles-pp.vfs_statx
     12.54            +4.4       16.91        perf-profile.children.cycles-pp.vfs_fstatat
     14.41            +5.0       19.42        perf-profile.children.cycles-pp.__do_sys_newfstatat
     13.92            +5.0       18.92        perf-profile.children.cycles-pp.statx
     17.67            +6.2       23.87        perf-profile.children.cycles-pp.fstatat64
     43.74           -11.4       32.29        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.36            -0.0        1.33        perf-profile.self.cycles-pp.queued_write_lock_slowpath
      0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.07 ±  5%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.smp_call_function_many_cond
      0.60            -0.0        0.58        perf-profile.self.cycles-pp.__memcpy
      0.47            -0.0        0.46        perf-profile.self.cycles-pp.clear_page_erms
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.__free_pages
      0.13            -0.0        0.12        perf-profile.self.cycles-pp.sched_balance_find_dst_cpu
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.available_idle_cpu
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.__dequeue_entity
      0.09            +0.0        0.10        perf-profile.self.cycles-pp.__switch_to
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.shmem_is_huge
      0.06            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.os_xsave
      0.18 ±  2%      +0.0        0.19        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.10 ±  4%      +0.0        0.11        perf-profile.self.cycles-pp.___perf_sw_event
      0.12            +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.stress_fstat_thread
      0.06 ±  6%      +0.0        0.08        perf-profile.self.cycles-pp.pick_eevdf
      0.05            +0.0        0.07        perf-profile.self.cycles-pp.mntput
      0.05            +0.0        0.07        perf-profile.self.cycles-pp.should_failslab
      0.07            +0.0        0.09        perf-profile.self.cycles-pp.__enqueue_entity
      0.07            +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.legitimize_links
      0.08 ±  4%      +0.0        0.11        perf-profile.self.cycles-pp.amd_clear_divider
      0.09            +0.0        0.12        perf-profile.self.cycles-pp.__legitimize_path
      0.08            +0.0        0.11        perf-profile.self.cycles-pp.pick_next_task_fair
      0.10            +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.complete_walk
      0.11 ±  4%      +0.0        0.14        perf-profile.self.cycles-pp.dput
      0.11 ±  4%      +0.0        0.14 ±  2%  perf-profile.self.cycles-pp.security_inode_getattr
      0.11            +0.0        0.15        perf-profile.self.cycles-pp.mntput_no_expire
      0.12 ±  3%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.try_to_unlazy
      0.86            +0.0        0.90        perf-profile.self.cycles-pp._raw_spin_lock
      0.11            +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.is_vmalloc_addr
      0.18 ±  2%      +0.0        0.22        perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.14 ±  3%      +0.0        0.18        perf-profile.self.cycles-pp.__get_user_1
      0.13            +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.security_inode_permission
      0.13            +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.terminate_walk
      0.32            +0.0        0.36 ±  2%  perf-profile.self.cycles-pp.update_curr
      0.14            +0.0        0.19 ±  2%  perf-profile.self.cycles-pp.nd_jump_root
      0.19 ±  2%      +0.0        0.24        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.18            +0.0        0.23        perf-profile.self.cycles-pp.rcu_all_qs
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.from_kgid_munged
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.make_vfsgid
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.path_put
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__x64_sys_newfstatat
      0.18 ±  2%      +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.walk_component
      0.22            +0.1        0.28        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.16 ± 16%      +0.1        0.23 ± 12%  perf-profile.self.cycles-pp.__lookup_mnt
      0.23 ±  4%      +0.1        0.29 ±  5%  perf-profile.self.cycles-pp.__fdget_raw
      0.20 ±  2%      +0.1        0.27        perf-profile.self.cycles-pp.lookup_fast
      0.20 ±  2%      +0.1        0.27        perf-profile.self.cycles-pp.shmem_getattr
      0.18            +0.1        0.25        perf-profile.self.cycles-pp.make_vfsuid
      0.21            +0.1        0.28        perf-profile.self.cycles-pp.vfs_fstatat
      0.22            +0.1        0.30        perf-profile.self.cycles-pp.cp_statx
      0.24 ±  2%      +0.1        0.32        perf-profile.self.cycles-pp.generic_fillattr
      0.23            +0.1        0.31        perf-profile.self.cycles-pp.check_stack_object
      0.24 ±  3%      +0.1        0.33        perf-profile.self.cycles-pp.map_id_up
      0.24            +0.1        0.33        perf-profile.self.cycles-pp.__x64_sys_statx
      0.31 ±  2%      +0.1        0.40        perf-profile.self.cycles-pp.__cond_resched
      0.23 ±  2%      +0.1        0.32 ±  3%  perf-profile.self.cycles-pp.inode_permission
      0.30 ±  2%      +0.1        0.40        perf-profile.self.cycles-pp.path_init
      0.34            +0.1        0.44        perf-profile.self.cycles-pp.__schedule
      0.32            +0.1        0.42        perf-profile.self.cycles-pp.path_lookupat
      0.31            +0.1        0.42 ±  2%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.30 ±  3%      +0.1        0.43 ±  6%  perf-profile.self.cycles-pp.set_root
      0.42            +0.1        0.56        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.42            +0.1        0.56 ±  3%  perf-profile.self.cycles-pp.generic_permission
      0.41            +0.1        0.56        perf-profile.self.cycles-pp.vfs_getattr_nosec
      0.48            +0.1        0.63        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.42            +0.2        0.57        perf-profile.self.cycles-pp.cp_new_stat
      0.48            +0.2        0.64        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.59            +0.2        0.77        perf-profile.self.cycles-pp.__check_heap_object
      0.54            +0.2        0.72        perf-profile.self.cycles-pp.vfs_statx
      0.54            +0.2        0.73 ±  2%  perf-profile.self.cycles-pp.step_into
      0.52 ±  8%      +0.2        0.72 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.58            +0.2        0.77        perf-profile.self.cycles-pp.check_heap_object
      0.56            +0.2        0.77        perf-profile.self.cycles-pp.__check_object_size
      0.67            +0.2        0.88        perf-profile.self.cycles-pp._copy_to_user
      0.62 ±  3%      +0.2        0.83        perf-profile.self.cycles-pp.shim_statx
      0.62            +0.2        0.84        perf-profile.self.cycles-pp.common_perm_cond
      0.39 ± 38%      +0.2        0.62 ± 27%  perf-profile.self.cycles-pp.stress_fstat_helper
      0.61 ±  4%      +0.2        0.84 ±  4%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.60 ±  2%      +0.2        0.84 ±  2%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.65            +0.2        0.88        perf-profile.self.cycles-pp.do_statx
      0.67            +0.2        0.90        perf-profile.self.cycles-pp.__do_sys_newfstatat
      0.78            +0.3        1.04        perf-profile.self.cycles-pp.do_syscall_64
      0.76            +0.3        1.02        perf-profile.self.cycles-pp.putname
      0.77            +0.3        1.05        perf-profile.self.cycles-pp.getname_flags
      0.84            +0.3        1.12 ±  3%  perf-profile.self.cycles-pp.link_path_walk
      0.87            +0.3        1.16        perf-profile.self.cycles-pp.fstatat64
      0.94            +0.3        1.26        perf-profile.self.cycles-pp.statx
      0.80            +0.3        1.12 ±  2%  perf-profile.self.cycles-pp.lockref_put_return
      1.21            +0.4        1.60        perf-profile.self.cycles-pp.kmem_cache_free
      1.46            +0.4        1.90        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.26            +0.4        1.70        perf-profile.self.cycles-pp.filename_lookup
      1.39            +0.5        1.89        perf-profile.self.cycles-pp.kmem_cache_alloc
      1.39            +0.6        1.96        perf-profile.self.cycles-pp.lockref_get_not_dead
      2.12            +0.7        2.83        perf-profile.self.cycles-pp.strncpy_from_user



***************************************************************************************************
lkp-csl-2sp3: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase:
  gcc-13/performance/4BRD_12G/xfs/x86_64-rhel-8.3/300/RAID1/debian-12-x86_64-20240206.cgz/lkp-csl-2sp3/sync_disk_rw/aim7

commit: 
  97450eb909 ("sched/pelt: Remove shift of thermal clock")
  e2bbd1c498 ("sched/fair: Reschedule the cfs_rq when current is ineligible")

97450eb909658573 e2bbd1c498980c5cb68f9973f41 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  24356729 ±  2%     +15.8%   28212175        cpuidle..usage
     30.69 ±  2%     +13.6%      34.87 ±  2%  iostat.cpu.idle
     68.53            -6.3%      64.25        iostat.cpu.system
    753687           +10.4%     831869 ±  4%  meminfo.Inactive(anon)
    164050 ±  6%     +45.9%     239358 ± 11%  meminfo.Mapped
      6182            +9.6%       6775 ±  2%  perf-c2c.DRAM.remote
      3724 ±  3%     +11.5%       4151 ±  2%  perf-c2c.HITM.remote
    648354            +7.8%     698666 ±  2%  vmstat.io.bo
     95.98 ±  6%     -12.9%      83.64 ±  4%  vmstat.procs.r
    801317           +16.2%     930980 ±  2%  vmstat.system.cs
     29.52 ±  2%      +4.2       33.67 ±  3%  mpstat.cpu.all.idle%
      0.04 ±  5%      -0.0        0.04 ±  5%  mpstat.cpu.all.iowait%
      0.74            +0.1        0.85 ±  3%  mpstat.cpu.all.usr%
     85.46           -10.7%      76.32        mpstat.max_utilization_pct
     16199            +9.6%      17753        aim7.jobs-per-min
    111.17            -8.7%     101.44        aim7.time.elapsed_time
    111.17            -8.7%     101.44        aim7.time.elapsed_time.max
   4379281           +75.1%    7669146        aim7.time.involuntary_context_switches
      6400            -6.5%       5983        aim7.time.percent_of_cpu_this_job_got
      7089           -14.8%       6042        aim7.time.system_time
  52793765            -4.9%   50219682        aim7.time.voluntary_context_switches
    336033            +3.7%     348553 ±  2%  proc-vmstat.nr_active_anon
   1179748            +2.6%    1210206        proc-vmstat.nr_file_pages
    188573           +10.4%     208211 ±  4%  proc-vmstat.nr_inactive_anon
     41560 ±  6%     +45.9%      60654 ± 11%  proc-vmstat.nr_mapped
    360884            +8.6%     391938        proc-vmstat.nr_shmem
    336033            +3.7%     348553 ±  2%  proc-vmstat.nr_zone_active_anon
    188573           +10.4%     208211 ±  4%  proc-vmstat.nr_zone_inactive_anon
   1474174           -21.8%    1153102        sched_debug.cfs_rq:/.avg_vruntime.avg
   1644121           -20.9%    1300217 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.max
   1394133           -21.2%    1098002 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.min
     38297 ±  7%     -36.5%      24315 ± 12%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.78 ± 18%     -27.4%       0.57 ±  7%  sched_debug.cfs_rq:/.h_nr_running.avg
   1474174           -21.8%    1153102        sched_debug.cfs_rq:/.min_vruntime.avg
   1644121           -20.9%    1300217 ±  3%  sched_debug.cfs_rq:/.min_vruntime.max
   1394133           -21.2%    1098002 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
     38297 ±  7%     -36.5%      24315 ± 12%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.47 ±  2%      -9.8%       0.42 ±  4%  sched_debug.cfs_rq:/.nr_running.avg
    853.31 ± 10%     -26.5%     627.20        sched_debug.cfs_rq:/.runnable_avg.avg
      3612 ± 27%     -45.1%       1983 ± 17%  sched_debug.cfs_rq:/.runnable_avg.max
    588.74 ± 21%     -37.5%     367.74 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
      2305 ± 22%     -30.1%       1612 ± 16%  sched_debug.cfs_rq:/.util_avg.max
    394.30 ± 16%     -21.5%     309.35 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
    272.57 ± 17%     -41.5%     159.47 ±  7%  sched_debug.cfs_rq:/.util_est.avg
    377.83 ± 35%     -43.3%     214.15 ± 16%  sched_debug.cfs_rq:/.util_est.stddev
      0.79 ± 18%     -30.8%       0.55 ±  7%  sched_debug.cpu.nr_running.avg
    221477           +20.1%     265968        sched_debug.cpu.nr_switches.avg
    238906 ±  3%     +18.7%     283476 ±  2%  sched_debug.cpu.nr_switches.max
      6940 ±  8%     +31.5%       9124 ±  9%  sched_debug.cpu.nr_switches.stddev
      1.47 ±  2%     +10.1%       1.62 ±  3%  perf-stat.i.MPKI
      1.21            +0.2        1.36 ±  3%  perf-stat.i.branch-miss-rate%
  86242084 ±  4%     +16.3%  1.003e+08 ±  4%  perf-stat.i.branch-misses
  80906704 ±  2%     +12.5%   90980799 ±  2%  perf-stat.i.cache-misses
    817901           +16.5%     952574 ±  2%  perf-stat.i.context-switches
      3.85            -7.4%       3.57        perf-stat.i.cpi
 2.134e+11            -5.3%   2.02e+11        perf-stat.i.cpu-cycles
      2671 ±  2%     -14.9%       2272 ±  3%  perf-stat.i.cycles-between-cache-misses
      0.32            +7.6%       0.34        perf-stat.i.ipc
     10.77           +13.5%      12.23 ±  2%  perf-stat.i.metric.K/sec
      6523            +8.0%       7047 ±  3%  perf-stat.i.minor-faults
      6524            +8.0%       7048 ±  3%  perf-stat.i.page-faults
      1.54 ±  2%     +10.5%       1.70 ±  2%  perf-stat.overall.MPKI
      0.80 ±  3%      +0.1        0.92 ±  4%  perf-stat.overall.branch-miss-rate%
      4.06            -7.0%       3.78        perf-stat.overall.cpi
      2640 ±  2%     -15.8%       2222 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.25            +7.6%       0.26        perf-stat.overall.ipc
  85266080 ±  4%     +16.3%   99200665 ±  4%  perf-stat.ps.branch-misses
  80071004 ±  2%     +12.5%   90070323 ±  2%  perf-stat.ps.cache-misses
    809411           +16.5%     943274 ±  2%  perf-stat.ps.context-switches
 2.113e+11            -5.3%      2e+11        perf-stat.ps.cpu-cycles
 5.852e+12            -6.5%   5.47e+12 ±  2%  perf-stat.total.instructions
     12.13 ±  4%      -4.2        7.88 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.md_flush_request.raid1_make_request.md_handle_request
     12.19 ±  4%      -4.2        7.96 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.md_flush_request.raid1_make_request.md_handle_request.__submit_bio
     13.44 ±  4%      -4.2        9.25 ±  3%  perf-profile.calltrace.cycles-pp.md_flush_request.raid1_make_request.md_handle_request.__submit_bio.__submit_bio_noacct
     13.46 ±  4%      -4.2        9.27 ±  3%  perf-profile.calltrace.cycles-pp.md_handle_request.__submit_bio.__submit_bio_noacct.submit_bio_wait.blkdev_issue_flush
     13.48 ±  4%      -4.2        9.30 ±  3%  perf-profile.calltrace.cycles-pp.__submit_bio_noacct.submit_bio_wait.blkdev_issue_flush.xfs_file_fsync.xfs_file_buffered_write
     13.44 ±  4%      -4.2        9.26 ±  3%  perf-profile.calltrace.cycles-pp.raid1_make_request.md_handle_request.__submit_bio.__submit_bio_noacct.submit_bio_wait
     13.48 ±  4%      -4.2        9.30 ±  3%  perf-profile.calltrace.cycles-pp.__submit_bio.__submit_bio_noacct.submit_bio_wait.blkdev_issue_flush.xfs_file_fsync
     13.57 ±  4%      -4.2        9.41 ±  3%  perf-profile.calltrace.cycles-pp.submit_bio_wait.blkdev_issue_flush.xfs_file_fsync.xfs_file_buffered_write.vfs_write
     13.59 ±  4%      -4.2        9.43 ±  3%  perf-profile.calltrace.cycles-pp.blkdev_issue_flush.xfs_file_fsync.xfs_file_buffered_write.vfs_write.ksys_write
     84.77            -3.7       81.04        perf-profile.calltrace.cycles-pp.xfs_file_fsync.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64
     86.25            -3.7       82.54        perf-profile.calltrace.cycles-pp.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     86.38            -3.7       82.68        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     86.40            -3.7       82.69        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     86.57            -3.7       82.88        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     86.56            -3.7       82.88        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     86.80            -3.7       83.13        perf-profile.calltrace.cycles-pp.write
      3.35            -1.3        2.10 ±  3%  perf-profile.calltrace.cycles-pp.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write.vfs_write
      3.06            -1.2        1.86 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.remove_wait_queue.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync
      3.06            -1.2        1.86 ±  2%  perf-profile.calltrace.cycles-pp.remove_wait_queue.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
      3.05            -1.2        1.85 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.remove_wait_queue.xlog_wait_on_iclog.xfs_log_force_seq
      3.86 ±  2%      -1.1        2.78 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.remove_wait_queue.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync
      3.84 ±  2%      -1.1        2.76 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.remove_wait_queue.xlog_cil_force_seq.xfs_log_force_seq
      3.86 ±  2%      -1.1        2.78 ±  3%  perf-profile.calltrace.cycles-pp.remove_wait_queue.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
      0.84 ±  2%      -0.0        0.80        perf-profile.calltrace.cycles-pp.kiocb_modified.xfs_file_write_checks.xfs_file_buffered_write.vfs_write.ksys_write
      0.82 ±  2%      -0.0        0.77        perf-profile.calltrace.cycles-pp.xfs_vn_update_time.kiocb_modified.xfs_file_write_checks.xfs_file_buffered_write.vfs_write
      0.58 ±  2%      -0.0        0.55 ±  2%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_vn_update_time.kiocb_modified.xfs_file_write_checks.xfs_file_buffered_write
      0.51            +0.0        0.56        perf-profile.calltrace.cycles-pp.xfs_end_ioend.xfs_end_io.process_one_work.worker_thread.kthread
      0.52            +0.0        0.57        perf-profile.calltrace.cycles-pp.xfs_end_io.process_one_work.worker_thread.kthread.ret_from_fork
      0.58 ±  2%      +0.1        0.62 ±  3%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64
      0.90 ±  2%      +0.1        0.99 ±  3%  perf-profile.calltrace.cycles-pp.copy_to_brd.brd_submit_bio.__submit_bio.__submit_bio_noacct.iomap_submit_ioend
      2.58 ±  2%      +0.1        2.68 ±  2%  perf-profile.calltrace.cycles-pp.__submit_bio.__submit_bio_noacct.iomap_submit_ioend.xfs_vm_writepages.do_writepages
      2.59 ±  2%      +0.1        2.70 ±  2%  perf-profile.calltrace.cycles-pp.__submit_bio_noacct.iomap_submit_ioend.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc
      2.12            +0.1        2.22        perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.62 ±  2%      +0.1        2.73 ±  2%  perf-profile.calltrace.cycles-pp.iomap_submit_ioend.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
      1.17 ±  2%      +0.1        1.29 ±  3%  perf-profile.calltrace.cycles-pp.brd_submit_bio.__submit_bio.__submit_bio_noacct.iomap_submit_ioend.xfs_vm_writepages
      2.24            +0.1        2.38        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      2.24            +0.1        2.38        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      2.24            +0.1        2.38        perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      2.23            +0.1        2.37        perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.91 ±  2%      +0.7        1.58        perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq
     54.72            +1.0       55.70        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq
      1.71 ±  5%      +1.1        2.86 ± 10%  perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     64.02            +1.6       65.62        perf-profile.calltrace.cycles-pp.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write.vfs_write
      7.56 ±  2%      +1.9        9.42        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     55.82            +2.0       57.86        perf-profile.calltrace.cycles-pp.__mutex_lock.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq
     58.14            +2.6       60.76        perf-profile.calltrace.cycles-pp.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync
     59.46            +2.7       62.18        perf-profile.calltrace.cycles-pp.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
      9.68 ±  2%      +3.2       12.86 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      9.69 ±  2%      +3.2       12.86 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      9.86 ±  2%      +3.2       13.08 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     10.46 ±  2%      +3.5       13.94 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     10.47 ±  2%      +3.5       13.94 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     10.47 ±  2%      +3.5       13.94 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     10.60 ±  2%      +3.5       14.08 ±  2%  perf-profile.calltrace.cycles-pp.common_startup_64
     22.14 ±  2%      -6.5       15.63 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     12.70 ±  3%      -4.2        8.46 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irq
     13.54 ±  4%      -4.2        9.34 ±  3%  perf-profile.children.cycles-pp.md_flush_request
     14.22 ±  3%      -4.2       10.06 ±  3%  perf-profile.children.cycles-pp.md_handle_request
     14.20 ±  3%      -4.2       10.04 ±  3%  perf-profile.children.cycles-pp.raid1_make_request
     13.57 ±  4%      -4.2        9.41 ±  3%  perf-profile.children.cycles-pp.submit_bio_wait
     13.59 ±  4%      -4.2        9.43 ±  3%  perf-profile.children.cycles-pp.blkdev_issue_flush
     16.32 ±  3%      -4.1       12.26 ±  2%  perf-profile.children.cycles-pp.__submit_bio
     16.34 ±  3%      -4.1       12.28 ±  2%  perf-profile.children.cycles-pp.__submit_bio_noacct
     84.77            -3.7       81.04        perf-profile.children.cycles-pp.xfs_file_fsync
     86.25            -3.7       82.54        perf-profile.children.cycles-pp.xfs_file_buffered_write
     86.40            -3.7       82.70        perf-profile.children.cycles-pp.vfs_write
     86.41            -3.7       82.71        perf-profile.children.cycles-pp.ksys_write
     86.71            -3.7       83.03        perf-profile.children.cycles-pp.do_syscall_64
     86.71            -3.7       83.04        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     86.85            -3.7       83.18        perf-profile.children.cycles-pp.write
      8.05            -2.3        5.71 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      7.14            -2.3        4.82 ±  2%  perf-profile.children.cycles-pp.remove_wait_queue
      3.48            -1.3        2.23 ±  3%  perf-profile.children.cycles-pp.xlog_wait_on_iclog
      0.28 ±  3%      -0.1        0.21 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.26 ±  3%      -0.1        0.19 ±  4%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.24 ±  3%      -0.1        0.18 ±  5%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.16 ± 14%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.sb_clear_inode_writeback
      0.15 ± 10%      -0.1        0.10 ±  8%  perf-profile.children.cycles-pp.sb_mark_inode_writeback
      0.34 ±  6%      -0.0        0.29 ±  4%  perf-profile.children.cycles-pp.__folio_end_writeback
      0.21 ±  8%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.84 ±  2%      -0.0        0.80        perf-profile.children.cycles-pp.kiocb_modified
      0.82 ±  2%      -0.0        0.78        perf-profile.children.cycles-pp.xfs_vn_update_time
      0.33 ±  4%      -0.0        0.30 ±  4%  perf-profile.children.cycles-pp.iomap_writepage_map
      0.43 ±  3%      -0.0        0.40 ±  3%  perf-profile.children.cycles-pp.iomap_writepages
      0.10 ±  6%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.xfs_log_ticket_ungrant
      0.12            -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.xlog_state_clean_iclog
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.__update_blocked_fair
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.kmem_cache_free
      0.11            +0.0        0.12        perf-profile.children.cycles-pp.llseek
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.switch_fpu_return
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.sched_clock
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.wake_page_function
      0.10            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      0.10 ±  3%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__switch_to_asm
      0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.ktime_get
      0.05 ±  8%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.xfs_btree_lookup_get_block
      0.07 ±  7%      +0.0        0.08        perf-profile.children.cycles-pp.__switch_to
      0.05 ±  7%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.05 ±  7%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.mutex_lock
      0.07 ±  5%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.select_idle_core
      0.05 ±  8%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.llist_add_batch
      0.06 ±  8%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.mutex_unlock
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.perf_tp_event
      0.14 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.xlog_cil_committed
      0.12 ±  3%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.iomap_iter
      0.08 ±  4%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.xfs_btree_lookup
      0.14 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.xlog_cil_process_committed
      0.13 ±  5%      +0.0        0.15        perf-profile.children.cycles-pp.xlog_cil_write_commit_record
      0.07 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.submit_flushes
      0.13 ±  4%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.xlog_cil_set_ctx_write_state
      0.09 ±  5%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.kick_pool
      0.14 ±  4%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.xfs_bmap_add_extent_unwritten_real
      0.11 ±  3%      +0.0        0.13 ±  4%  perf-profile.children.cycles-pp.__queue_work
      0.07 ±  6%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.13 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.14 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.prepare_task_switch
      0.11            +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.15 ±  3%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.18 ±  4%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.xfs_bmapi_write
      0.08            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      0.15 ±  5%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.xfs_bmapi_convert_unwritten
      0.28 ±  3%      +0.0        0.30        perf-profile.children.cycles-pp.select_idle_sibling
      0.18 ±  5%      +0.0        0.20 ±  4%  perf-profile.children.cycles-pp.available_idle_cpu
      0.11 ±  4%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.queue_work_on
      0.12            +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.58            +0.0        0.60 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.22 ±  4%      +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.select_idle_cpu
      0.14 ±  3%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.menu_select
      0.36 ±  2%      +0.0        0.41        perf-profile.children.cycles-pp.xfs_iomap_write_unwritten
      0.51            +0.0        0.56        perf-profile.children.cycles-pp.xfs_end_ioend
      0.52            +0.0        0.57        perf-profile.children.cycles-pp.xfs_end_io
      0.58 ±  2%      +0.1        0.63 ±  3%  perf-profile.children.cycles-pp.iomap_file_buffered_write
      0.48            +0.1        0.53        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.poll_idle
      0.57            +0.1        0.63        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.24 ±  3%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.flush_workqueue_prep_pwqs
      0.20 ±  3%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.schedule_idle
      2.12            +0.1        2.22        perf-profile.children.cycles-pp.process_one_work
      2.62 ±  2%      +0.1        2.73 ±  2%  perf-profile.children.cycles-pp.iomap_submit_ioend
      1.04 ±  2%      +0.1        1.15 ±  2%  perf-profile.children.cycles-pp.copy_to_brd
      2.24            +0.1        2.38        perf-profile.children.cycles-pp.kthread
      2.24            +0.1        2.38        perf-profile.children.cycles-pp.ret_from_fork
      2.24            +0.1        2.38        perf-profile.children.cycles-pp.ret_from_fork_asm
      2.23            +0.1        2.37        perf-profile.children.cycles-pp.worker_thread
      1.32 ±  2%      +0.1        1.46 ±  2%  perf-profile.children.cycles-pp.brd_submit_bio
      0.36 ±  2%      +0.1        0.50 ±  2%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.89            +0.2        1.05 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.09 ±  4%      +0.2        0.27 ±  2%  perf-profile.children.cycles-pp.wake_up_q
      1.25            +0.2        1.46        perf-profile.children.cycles-pp.try_to_wake_up
      0.10 ±  8%      +0.2        0.31 ± 18%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.12 ±  3%      +0.3        0.40        perf-profile.children.cycles-pp.__mutex_unlock_slowpath
      0.91 ±  2%      +0.7        1.58        perf-profile.children.cycles-pp.mutex_spin_on_owner
     54.74            +1.0       55.72        perf-profile.children.cycles-pp.osq_lock
      2.02 ±  5%      +1.3        3.30 ± 10%  perf-profile.children.cycles-pp.intel_idle_irq
     64.02            +1.6       65.62        perf-profile.children.cycles-pp.xlog_cil_force_seq
      7.66 ±  2%      +1.9        9.52        perf-profile.children.cycles-pp.intel_idle
     55.82            +2.0       57.86        perf-profile.children.cycles-pp.__mutex_lock
     58.14            +2.6       60.76        perf-profile.children.cycles-pp.__flush_workqueue
     59.46            +2.7       62.18        perf-profile.children.cycles-pp.xlog_cil_push_now
      9.81 ±  2%      +3.2       12.99 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter_state
      9.81 ±  2%      +3.2       12.99 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter
      9.98 ±  2%      +3.2       13.22 ±  3%  perf-profile.children.cycles-pp.cpuidle_idle_call
     10.47 ±  2%      +3.5       13.94 ±  2%  perf-profile.children.cycles-pp.start_secondary
     10.60 ±  2%      +3.5       14.08 ±  2%  perf-profile.children.cycles-pp.do_idle
     10.60 ±  2%      +3.5       14.08 ±  2%  perf-profile.children.cycles-pp.common_startup_64
     10.60 ±  2%      +3.5       14.08 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
     22.12 ±  2%      -6.5       15.60 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.xfs_log_ticket_ungrant
      0.05            +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.finish_task_switch
      0.05 ±  8%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.llist_add_batch
      0.06 ±  8%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.mutex_unlock
      0.06 ±  6%      +0.0        0.08        perf-profile.self.cycles-pp.__switch_to
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.prepare_task_switch
      0.06 ±  6%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.try_to_wake_up
      0.14 ±  2%      +0.0        0.16 ±  5%  perf-profile.self.cycles-pp.__schedule
      0.18 ±  4%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.available_idle_cpu
      0.07 ± 10%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.menu_select
      0.37            +0.0        0.41        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.12 ±  6%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.flush_workqueue_prep_pwqs
      0.23 ±  2%      +0.0        0.28 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.vfs_write
      0.08 ±  4%      +0.1        0.14 ±  6%  perf-profile.self.cycles-pp.__mutex_lock
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.poll_idle
      0.36 ±  2%      +0.1        0.45 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      1.01 ±  2%      +0.1        1.12 ±  2%  perf-profile.self.cycles-pp.copy_to_brd
      0.90 ±  2%      +0.7        1.57        perf-profile.self.cycles-pp.mutex_spin_on_owner
     54.26            +1.0       55.30        perf-profile.self.cycles-pp.osq_lock
      1.96 ±  5%      +1.3        3.22 ± 10%  perf-profile.self.cycles-pp.intel_idle_irq
      7.66 ±  2%      +1.9        9.52        perf-profile.self.cycles-pp.intel_idle



***************************************************************************************************
lkp-csl-2sp3: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
=========================================================================================
build_kconfig/compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/target/tbox_group/testcase:
  defconfig/gcc-13/performance/x86_64-rhel-8.3/200%/debian-12-x86_64-20240206.cgz/300s/vmlinux/lkp-csl-2sp3/kbuild

commit: 
  97450eb909 ("sched/pelt: Remove shift of thermal clock")
  e2bbd1c498 ("sched/fair: Reschedule the cfs_rq when current is ineligible")

97450eb909658573 e2bbd1c498980c5cb68f9973f41 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1944235           -11.3%    1724001        cpuidle..usage
      0.07            -0.0        0.07        mpstat.cpu.all.soft%
     18920          +173.4%      51728        vmstat.system.cs
     66019            +2.3%      67537        vmstat.system.in
    238928 ±  4%     +18.7%     283496 ±  6%  numa-meminfo.node1.Active
    238928 ±  4%     +18.7%     283496 ±  6%  numa-meminfo.node1.Active(anon)
    252057 ±  4%     +19.9%     302260 ±  6%  numa-meminfo.node1.Shmem
     59680 ±  4%     +18.6%      70769 ±  6%  numa-vmstat.node1.nr_active_anon
     62962 ±  4%     +20.0%      75559 ±  6%  numa-vmstat.node1.nr_shmem
     59680 ±  4%     +18.6%      70769 ±  6%  numa-vmstat.node1.nr_zone_active_anon
     40.33 ± 16%     +46.7%      59.17 ± 17%  perf-c2c.DRAM.remote
     99.50 ±  7%     +36.3%     135.67 ± 10%  perf-c2c.HITM.local
     21.67 ± 22%     +85.4%      40.17 ± 18%  perf-c2c.HITM.remote
    266436           +22.5%     326455        meminfo.Active
    266436           +22.5%     326455        meminfo.Active(anon)
     71309           +19.2%      85005        meminfo.Mapped
    284474           +23.8%     352101        meminfo.Shmem
     50.65            +1.4%      51.35        kbuild.buildtime_per_iteration
     50.65            +1.4%      51.35        kbuild.real_time_per_iteration
    162.16            +1.3%     164.26        kbuild.sys_time_per_iteration
   4290772          +259.3%   15415002        kbuild.time.involuntary_context_switches
      5389            +1.0%       5444        kbuild.time.percent_of_cpu_this_job_got
    983.50            +1.3%     996.08        kbuild.time.system_time
     17417            +2.3%      17819        kbuild.time.user_time
      2898            +2.3%       2965        kbuild.user_time_per_iteration
     66625           +22.7%      81776        proc-vmstat.nr_active_anon
   1491011            +2.1%    1522533        proc-vmstat.nr_anon_pages
   1496099            +2.2%    1529304        proc-vmstat.nr_inactive_anon
     18140           +18.3%      21461        proc-vmstat.nr_mapped
      9585            +1.5%       9732        proc-vmstat.nr_page_table_pages
     71184           +23.7%      88073        proc-vmstat.nr_shmem
     66625           +22.7%      81776        proc-vmstat.nr_zone_active_anon
   1496099            +2.2%    1529304        proc-vmstat.nr_zone_inactive_anon
     64689            +7.4%      69486        proc-vmstat.numa_huge_pte_updates
  33355254            +7.4%   35829277        proc-vmstat.numa_pte_updates
    377789            +4.4%     394459        proc-vmstat.pgactivate
      2.67            +0.1        2.76        perf-stat.i.branch-miss-rate%
 7.979e+08            +3.1%  8.224e+08        perf-stat.i.branch-misses
     27.01            -1.2       25.84        perf-stat.i.cache-miss-rate%
 2.753e+08            +3.3%  2.843e+08        perf-stat.i.cache-misses
 8.884e+08           +11.4%  9.895e+08        perf-stat.i.cache-references
     18965          +174.5%      52066        perf-stat.i.context-switches
      1.08            +1.5%       1.09        perf-stat.i.cpi
 1.538e+11            +1.2%  1.557e+11        perf-stat.i.cpu-cycles
    702.89            -5.5%     664.26        perf-stat.i.cpu-migrations
      1.05            -1.0%       1.04        perf-stat.i.ipc
     12.50           -10.1%      11.23 ±  2%  perf-stat.i.major-faults
    329354            -1.1%     325687        perf-stat.i.minor-faults
    329366            -1.1%     325698        perf-stat.i.page-faults
      2.30            +4.3%       2.40        perf-stat.overall.MPKI
      3.07            +0.1        3.20        perf-stat.overall.branch-miss-rate%
     30.99            -2.2       28.74        perf-stat.overall.cache-miss-rate%
      1.28            +2.2%       1.31        perf-stat.overall.cpi
    558.80            -2.0%     547.74        perf-stat.overall.cycles-between-cache-misses
      0.78            -2.2%       0.76        perf-stat.overall.ipc
 7.966e+08            +2.9%  8.199e+08        perf-stat.ps.branch-misses
 2.748e+08            +3.2%  2.835e+08        perf-stat.ps.cache-misses
 8.869e+08           +11.2%  9.865e+08        perf-stat.ps.cache-references
     18918          +174.4%      51908        perf-stat.ps.context-switches
 1.536e+11            +1.1%  1.553e+11        perf-stat.ps.cpu-cycles
    701.06            -5.6%     662.09        perf-stat.ps.cpu-migrations
 1.197e+11            -1.1%  1.183e+11        perf-stat.ps.instructions
     12.47           -10.2%      11.20 ±  2%  perf-stat.ps.major-faults
    328614            -1.2%     324786        perf-stat.ps.minor-faults
    328627            -1.2%     324797        perf-stat.ps.page-faults
      0.73           -45.9%       0.40        sched_debug.cfs_rq:/.h_nr_running.avg
      2.06 ±  6%     -23.0%       1.58 ±  8%  sched_debug.cfs_rq:/.h_nr_running.max
      0.33           -50.0%       0.17        sched_debug.cfs_rq:/.h_nr_running.min
      0.38 ±  6%     -18.2%       0.31 ±  3%  sched_debug.cfs_rq:/.h_nr_running.stddev
      1689           -48.8%     864.97        sched_debug.cfs_rq:/.load.min
      1.61 ±  4%     -48.3%       0.83        sched_debug.cfs_rq:/.load_avg.min
      0.38 ±  2%     -41.7%       0.22        sched_debug.cfs_rq:/.nr_running.avg
      0.33           -50.0%       0.17        sched_debug.cfs_rq:/.nr_running.min
      0.16 ±  8%     +19.4%       0.20 ±  3%  sched_debug.cfs_rq:/.nr_running.stddev
    741.02 ±  2%     -43.4%     419.70        sched_debug.cfs_rq:/.runnable_avg.avg
      1841 ±  4%     -25.7%       1368 ±  2%  sched_debug.cfs_rq:/.runnable_avg.max
    310.50 ±  7%     -49.2%     157.89 ±  7%  sched_debug.cfs_rq:/.runnable_avg.min
    328.61 ±  6%     -21.0%     259.55 ±  3%  sched_debug.cfs_rq:/.runnable_avg.stddev
    404.14 ±  3%     -38.5%     248.50 ±  2%  sched_debug.cfs_rq:/.util_avg.avg
    181.06 ± 13%     -51.2%      88.44 ± 14%  sched_debug.cfs_rq:/.util_avg.min
     64.30 ±  8%     -18.5%      52.39 ±  2%  sched_debug.cfs_rq:/.util_est.avg
     92.86 ± 13%     -24.6%      70.04 ±  4%  sched_debug.cfs_rq:/.util_est.stddev
    720896           +17.0%     843275 ±  3%  sched_debug.cpu.avg_idle.avg
     11.27 ± 12%     -39.6%       6.81 ±  5%  sched_debug.cpu.clock.stddev
     52931           -42.2%      30600 ±  2%  sched_debug.cpu.curr->pid.avg
      7508 ± 22%     +67.6%      12586 ± 11%  sched_debug.cpu.curr->pid.stddev
      0.73           -45.8%       0.40 ±  2%  sched_debug.cpu.nr_running.avg
      0.33           -50.0%       0.17        sched_debug.cpu.nr_running.min
      0.38 ±  9%     -18.5%       0.31 ±  5%  sched_debug.cpu.nr_running.stddev
     30375          +163.9%      80145        sched_debug.cpu.nr_switches.avg
     42800 ±  4%    +120.8%      94514 ±  2%  sched_debug.cpu.nr_switches.max
     25282          +190.1%      73354        sched_debug.cpu.nr_switches.min
   -107.64           -18.1%     -88.19        sched_debug.cpu.nr_uninterruptible.min
     36.76 ±  4%     -17.1%      30.49 ±  5%  sched_debug.cpu.nr_uninterruptible.stddev
      4.63 ±  6%      -1.9        2.69 ±  8%  perf-profile.calltrace.cycles-pp.common_startup_64
      4.57 ±  7%      -1.9        2.66 ±  9%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      4.57 ±  7%      -1.9        2.66 ±  9%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      4.57 ±  7%      -1.9        2.66 ±  9%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      4.55 ±  7%      -1.9        2.65 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      4.46 ±  7%      -1.8        2.62 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      4.42 ±  7%      -1.8        2.61 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      3.97 ±  7%      -1.5        2.44 ±  9%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.64 ±  2%      -0.1        0.59 ±  3%  perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.40 ±  2%      +0.1        1.46        perf-profile.calltrace.cycles-pp.open64
      1.00 ±  2%      +0.1        1.06 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.99 ±  2%      +0.1        1.06 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.81            +0.1        1.92        perf-profile.calltrace.cycles-pp.malloc
      0.72 ±  4%      +0.1        0.87 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.35 ± 70%      +0.2        0.56 ±  2%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      4.63 ±  6%      -1.9        2.69 ±  8%  perf-profile.children.cycles-pp.common_startup_64
      4.63 ±  6%      -1.9        2.69 ±  8%  perf-profile.children.cycles-pp.cpu_startup_entry
      4.63 ±  6%      -1.9        2.69 ±  8%  perf-profile.children.cycles-pp.do_idle
      4.61 ±  6%      -1.9        2.69 ±  8%  perf-profile.children.cycles-pp.cpuidle_idle_call
      4.57 ±  7%      -1.9        2.66 ±  9%  perf-profile.children.cycles-pp.start_secondary
      4.51 ±  6%      -1.9        2.65 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter
      4.51 ±  6%      -1.9        2.65 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter_state
      4.01 ±  6%      -1.5        2.47 ±  8%  perf-profile.children.cycles-pp.intel_idle
      1.92 ±  3%      -0.2        1.76 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.56 ±  3%      -0.1        1.48        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.27 ±  6%      -0.1        0.21 ±  5%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.07 ± 10%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.11 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.07 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.perf_rotate_context
      0.25            +0.0        0.26        perf-profile.children.cycles-pp.ggc_free(void*)
      0.08            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.dput
      0.25            +0.0        0.27        perf-profile.children.cycles-pp._cpp_pop_context
      0.27 ±  3%      +0.0        0.29 ±  2%  perf-profile.children.cycles-pp.mmap_region
      0.08 ± 10%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__split_vma
      0.13 ±  5%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.32 ±  3%      +0.0        0.34        perf-profile.children.cycles-pp.mark_exp_read(tree_node*)
      0.12 ±  5%      +0.0        0.14        perf-profile.children.cycles-pp.do_vmi_munmap
      0.11 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      0.11 ±  6%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.20 ±  4%      +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.filemap_map_pages
      0.35            +0.0        0.37 ±  2%  perf-profile.children.cycles-pp.walk_component
      0.32 ±  3%      +0.0        0.35 ±  2%  perf-profile.children.cycles-pp.do_mmap
      0.34 ±  3%      +0.0        0.37 ±  2%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.29 ±  3%      +0.0        0.32 ±  3%  perf-profile.children.cycles-pp.lookup_name(tree_node*)
      0.22 ±  4%      +0.0        0.25 ±  3%  perf-profile.children.cycles-pp.do_read_fault
      0.05            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.27 ±  4%      +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.do_fault
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__update_load_avg_se
      1.20 ±  2%      +0.1        1.26        perf-profile.children.cycles-pp.path_openat
      1.41 ±  2%      +0.1        1.47        perf-profile.children.cycles-pp.open64
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.run_ksoftirqd
      1.21 ±  2%      +0.1        1.28        perf-profile.children.cycles-pp.do_filp_open
      1.42 ±  2%      +0.1        1.49        perf-profile.children.cycles-pp.__x64_sys_openat
      1.41 ±  2%      +0.1        1.48        perf-profile.children.cycles-pp.do_sys_openat2
      1.84            +0.1        1.95        perf-profile.children.cycles-pp.malloc
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.pick_next_task_fair
      4.32            +0.1        4.43        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      4.30            +0.1        4.42        perf-profile.children.cycles-pp.do_syscall_64
      0.13 ±  5%      +0.2        0.30 ±  3%  perf-profile.children.cycles-pp.__schedule
      0.12 ±  7%      +0.2        0.30 ±  4%  perf-profile.children.cycles-pp.schedule
      0.20 ±  4%      +0.2        0.43        perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      4.01 ±  6%      -1.5        2.47 ±  8%  perf-profile.self.cycles-pp.intel_idle
      0.09 ±  9%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.28 ±  3%      +0.0        0.31 ±  3%  perf-profile.self.cycles-pp.lookup_name(tree_node*)
      1.71            +0.1        1.80        perf-profile.self.cycles-pp.malloc





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


