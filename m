Return-Path: <linux-kernel+bounces-213149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8645A906D46
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC4B1C20EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA391428FC;
	Thu, 13 Jun 2024 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJ/zybvR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66AC144D16
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279669; cv=fail; b=Egu5cFCKAF7AtO7FvmCYdJs+vFoZvgLX6Bdjb7GSYUlxqxf5m/80F3lecUn367AVTrTZdIf/wAEXpkYl+VRodL69GC3SAlHcZ1Y+Tvz6ExwPB4Se9pAnHuNI6OFNcM6efE0xbBz1a5mICgKDPJeoJwawaLtt3vkhnlG7nUCL/+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279669; c=relaxed/simple;
	bh=hXXJph7MKMvNnc5VaAyCAgrk+lLUn0dOFWPwsusBXUQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BNwgbKCJE38nzsMwSktBGIks1eiFYnZOHcvG2E3zT26w50dXB+//Q6bXiOzwXzGkqpsmKi1c0e6EwYBSmIvNcKQuLBsoGP2JvZ2lS/Ll0DoOi/MsNFD8leC8H6GCIDiysPN/qfippYYN/4InOW/8WBR4ZG3Q/Cr929h5JxFTafo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJ/zybvR; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718279668; x=1749815668;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hXXJph7MKMvNnc5VaAyCAgrk+lLUn0dOFWPwsusBXUQ=;
  b=GJ/zybvR3zideBNy7PLhJ/YsIDnaSdx2NX6EczKMZSL/oIF0Cdy1ziJ1
   uDSu8H7SUsfkCOC/7PUTG9enxcth3Teg15sHE6zu93Vu2B34rZ7kyEVxt
   uOKFdNbNyC5xIQq2eOhyPIwaNl/dUnFXB/D8cOtMJeGZL4TqqBBDVNz2e
   HFNPBclAjmn69MTspF0CseS3qKyIIDHnzspcQFrqfxnztori2nCY80nyB
   vBjemGLBGOgnAktc/0EUZ1YM4LWBvgtHSSrFB9v1V4Lqb2sob0/MMb4vS
   KxGup606QByBvPnd8nEIc4xe0pbGgk0lx+gaW9GpVkBRZtoWOaX7J+sRc
   g==;
X-CSE-ConnectionGUID: ezAHk/f5TVCSq07Gk/WNbg==
X-CSE-MsgGUID: j7fMnrCUSTWpRDEGwVyTPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="12054887"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="12054887"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 04:54:26 -0700
X-CSE-ConnectionGUID: PRsGcmAcSH2im/5/5DXG3Q==
X-CSE-MsgGUID: wMdEid9GSX+3IaYkpe014A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="40185244"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 04:54:25 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 04:54:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 04:54:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 04:54:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 04:54:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWWCIiQwXcxlb0SrzvFE/3tUXpBwnFfjrPP290wKJ5TRkPGPPoRNb2Btys29FQ2F/kJ0Vc42v3tSp/vytYWwA1onmuwWj1QYCnPu/uyko6Rt46cGdjTuQ3pDhxkD+3ZeoFCCUv1hG/FEAir0DC20eGzTCEkGMnjaLYztN67K3P0txC2fxJf046rlhoqEVWQIo99DVqpQVYpNK6gcIfQEnjphF+txkqDtzkwq0sy3Q1bsfeeJqnI5u1iYil24GF6Gd7ZIBwC30AWo390K4QOq0hlN2e+X483NQ/x33MgNerCCPm6B20DB30d0vqhVxBP2Ghc0PHqiWbvjqr6g08SLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7UnEkn2ptE+d3C5ySSNBhpS7tLGZjj4MyrGQZQHhG8=;
 b=jfHS5NeLlHLwLXCj7iZPu2d+yS3AKLuMIIaayWKN7MYLI8QghrDqma979j1o93+cbTm86fEz/eEGOLDh5L0M3jCMoZpmACqsJe6bZnyDiGsxvBzZ+Qv4BidccLmC1ijTiP4+j9h6kb3ZSWJ+ZxpofbKhA0JgYozSMDwDP6mJwkHlL//usKN5RORRuemeR4U1pm34QivKmsyCqw19HMB4v6xel8WGGRNwc/qFOsX82yd4Dj9XQlAYEzXDUPl7UmvbVZmCB/0wXkWF6g1Kz4L95MJ5r1ZVKlbPDtOhN4XbtnQi8qYGgaVB+feYZed/i4Gg1f4PMtrZHGU9ppNQW1b8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA2PR11MB4988.namprd11.prod.outlook.com (2603:10b6:806:f8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.25; Thu, 13 Jun 2024 11:54:17 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 11:54:17 +0000
Date: Thu, 13 Jun 2024 19:54:02 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Chunxin Zang <spring.cxz@gmail.com>
CC: Honglei Wang <jameshongleiwang@126.com>, <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, Mike Galbraith <efault@gmx.de>,
	K Prateek Nayak <kprateek.nayak@amd.com>, <linux-kernel@vger.kernel.org>,
	<yangchen11@lixiang.com>, Jerry Zhou <zhouchunhua@lixiang.com>, Chunxin Zang
	<zangchunxin@lixiang.com>
Subject: Re: [PATCH v2] sched/fair: Reschedule the cfs_rq when current is
 ineligible
Message-ID: <Zmrd2hwqHB8RQjqB@chenyu5-mobl2>
References: <20240529141806.16029-1-spring.cxz@gmail.com>
 <ZmKVjmuC4kGrUH5V@chenyu5-mobl2>
 <2E6EB0D6-D913-4205-B7DD-35EF4FA25667@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2E6EB0D6-D913-4205-B7DD-35EF4FA25667@gmail.com>
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA2PR11MB4988:EE_
X-MS-Office365-Filtering-Correlation-Id: 03757dc9-7b64-4ed5-1c05-08dc8b9f8d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|7416008|366010|1800799018;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZBaS+8QkzumE4qhu1uEvxIDaDQmoERUlwpTxmFxTo3HpL1rzT+64HHFYZkGu?=
 =?us-ascii?Q?EreNAQU2s62288kW8QFVlDFhSgAULpalUhsNkfdWl4ff/jjhASLjM5z2m1iO?=
 =?us-ascii?Q?JY+zM1D3l+p9GOck8t/g0L728vYIJucP4OremtJDboecAFgiTiJk1HHBxZvP?=
 =?us-ascii?Q?8rcB0dUbaLl9i7p+6JdNhebyv3TlSiooKi13Iw4UDRKpSROvdor8/ndrjVHd?=
 =?us-ascii?Q?megeWe7JwRHQz0gYKYhpff2Cto8fNdkbm3cL2hvK1+HqGaqP+FJ8FZnrAXMu?=
 =?us-ascii?Q?nnndAH0cizPiDceaerVtqmKWB68/BGtVCEFGdDdYpfNVnrIaJIbxlAtHMauO?=
 =?us-ascii?Q?557aArviC8KhvUHRF8S1HAVrF1SPb4neVQU7osVogZ31h0Jd3lbmahNnh2aI?=
 =?us-ascii?Q?vh+rkvkyFiK7+TI72bNvRP/Whk+DvhB9B/+m0ro5JmNUW7bhE082MgwEmwuq?=
 =?us-ascii?Q?0NkovQkJm/3sk/G89OR2wl82TZV48HN9ZLa+2NE3DQPMGgK+DO/gAsdvmio9?=
 =?us-ascii?Q?CFofQ5KGRj/9KxGLfZsvQWTGjPIqiCThuXWD84gXke+BxJ+f5EbtfGWya3QQ?=
 =?us-ascii?Q?lIEQ4WhiWGsya7g1Q8n3xTTQ8rg3ia/1bVdpEE9AKtXTgaWsyTD+5zApNa47?=
 =?us-ascii?Q?NyG6xM53Nz8bKjAm8TAhL0isTQsgi3xyRD2MLuPhFc9g+f19QrX3l36yL4ao?=
 =?us-ascii?Q?Vr35g4hHClSQp53BKs0ec+iX1EseP7SB6JRHTQOjUM+J395EUDaObiu6zsJ5?=
 =?us-ascii?Q?Mo3sw70MwlNlfg2EQKQ0oK90ED91NNZOlQhZw769E1keye3QD9WNkqxFc42J?=
 =?us-ascii?Q?rVhbFcqlmzjf49PwUtlBvU4Dd0Hz/4vjiPjurNFXGT1tqkwuP2WW9ZqW9IUq?=
 =?us-ascii?Q?Zxor+yiek7nnrTA7hhiPCPI2hqLctsmrIRRIl5O++17fszWY0U8wZ5oJqdUv?=
 =?us-ascii?Q?srtDzuul9Q+GnbevoD0F6o9wxGH4F1aHd95J26/6kpGobKtfr1a+c+x/aNGv?=
 =?us-ascii?Q?JyshqwG/mb+x2xaODLwyIYZpNa6szIKqyyiqf2WuAtHodCWot437i9hVqD5T?=
 =?us-ascii?Q?uuwnsHUVAlRxL3vICsqLjS0Mepdkar2Po/eJ5axg1p52+F9CPN4zYZ1D1yvg?=
 =?us-ascii?Q?mnwxjFF88H+poHq547Fu8tgXyDZ6muBPaf3VrVGYKGl6wnEzd0XPnZf5k6+d?=
 =?us-ascii?Q?HNE/boEJ/HuRkmLh3+RZCroPonnt8u2qmzGV2Ydd32mCE8VExxQYH/xNt8Mi?=
 =?us-ascii?Q?e901TLPhaAHGgfiwtSh9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(7416008)(366010)(1800799018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7KKzsznY1jRzq87vB7d/fn3lgGchaId/efLPfwxPbFRvGWUXeBzrZSZMK3M9?=
 =?us-ascii?Q?hqYBoL1AgtuNfrOKcQF1nUd7E64KwwZiiuFsz71susJGOUTyVli2/6COD6HA?=
 =?us-ascii?Q?YyqHKhFTrlQPWqunMUgj85iQYjTcW17q6NcBX3kKsLWyLpzawof+pMX5Oa9M?=
 =?us-ascii?Q?j2HbNqInV2jxx4B8a0zu+cOeFDyVj0bubeR/U4KgogbXUgHb3l3UT1jpol3z?=
 =?us-ascii?Q?+Wwe6xAK1Olu2kiUv9WfysFvzptwQklZkvMqi448ih9PYDx8rA06Y5hpy/ZX?=
 =?us-ascii?Q?UINUW9coa/zhxjtu0triPRHzrFPfybtlxcXa4eOfFa7JvGwRexydEsGkzj1a?=
 =?us-ascii?Q?SrNTm0TVBPKAoZKdTWBSr3OyX8MlaUWMIwM2/eUOW+UDlCo1aRUdFbmqpWxn?=
 =?us-ascii?Q?xa7OvMmR3O1jIvzCtYJ4Q5iA4DIxx3DPkYrK61Ffee3DuKsA4BmgkG41DL3B?=
 =?us-ascii?Q?Ij2nD6w4iRhdEzV2W9Eqm2enWEpZy2r1iSW6dU0M9R3McD2MwuqZKxYS5/Lm?=
 =?us-ascii?Q?TCbAd2Wo+3CW9P7F9GcZuZ771sOqGFaBWQuxvqTxueK/YqqgPSTR/ttB0d0k?=
 =?us-ascii?Q?JC+eWRbvQJjqOoRd0O4luOHYBlVXku6S8EIl6JjtzfnV/PamMh9rTYy0txuw?=
 =?us-ascii?Q?bkV6zphhD8QLhSzRUavOYT8tV+ISQGp3esmepJ/BZ3NJ6RJVmhXcUlKRjMRW?=
 =?us-ascii?Q?hNgAgkrIXTB/Wu3f4W5MKH6NJ2Bmxsx/Jz+peFe7yXj+Nxm3M3xBNL6rnuYN?=
 =?us-ascii?Q?dagbPj89riQd7n1CjGpFrW7WdHezIcUvJtjq+DDYECEmBa4ANN0Dn4/bkpPI?=
 =?us-ascii?Q?QO/M8xIb9Ji2X0IUZACZLapeELuraCtzNHXCH+4U1vkLZMRM4Q5VBJkLo9jL?=
 =?us-ascii?Q?UR9vzwo6f56mWv7wli0CI3UVPyfR0uI6ZWoUDF+s2zibJPdoE5iwkwGLfCKl?=
 =?us-ascii?Q?n6wKG5GiBpz0MyNDErLMrzSKZePY8z3YEW/gG2M9w6+AJyHBgsZMZIjw+wYR?=
 =?us-ascii?Q?yLWN4D07OEnxXgRQCWObA+6VZYHvXmTOyyjQt6bXLudmcujzDz/Z7WDEH7AN?=
 =?us-ascii?Q?8RT8oe5J0blXL50I+iCKgw+ecL1JQDfrFq79r6b20tAFh7Iha58HGT4X4loe?=
 =?us-ascii?Q?r9DOM8XJDoFp12R4rVsKSRHhqgm3lCbGoAJog84y70oDIa59dN2JT5lHfY8h?=
 =?us-ascii?Q?S7hf3I4LXx4rJwHMfK52QU7V++7Tcc3cc6gXr7nqKyMV2tuCQ/cnQxOWaSdx?=
 =?us-ascii?Q?k3mqew9VUGwFXeNRwPsGPc2VHrWSg5mioJJSs5wE/McG7dT2RvTimh0VVMrO?=
 =?us-ascii?Q?JD6xUbCuagEZBXCKcr7Z6u7G85KiCHOXwArB+zJiQIna6mu4EpMXifWUHF+p?=
 =?us-ascii?Q?Giey08Ce9IA4hw2GT7/f6Vj8NV7s4l5oVJ4ese6pxhDhTZ4ozOfScHYEQmai?=
 =?us-ascii?Q?3qen+zl78zenz+5AE0njVXneSU1p4Ma76y01+JxGpaMBVGlaJgWmkMvX5Wad?=
 =?us-ascii?Q?QUYGMrhZGWL67isUo5lgH0HO72vvDZhmtgEjWNbRr0zQB9Y2phnxXQoit6wy?=
 =?us-ascii?Q?jBhjiIcXCzTEdTRS+Lqsjy1Wbwj6i64HqOdeOTd4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03757dc9-7b64-4ed5-1c05-08dc8b9f8d68
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 11:54:16.9554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckOysxQ1B6zsFRaBMIR9oL2clCQ+PJIynaOuI6OkVIMWHjbDeKLpQsUNPas9DQW0ovL31/pLk6/a0+yyjnSs4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4988
X-OriginatorOrg: intel.com

On 2024-06-12 at 18:39:11 +0800, Chunxin Zang wrote:
> 
> 
> > On Jun 7, 2024, at 13:07, Chen Yu <yu.c.chen@intel.com> wrote:
> > 
> > On 2024-05-29 at 22:18:06 +0800, Chunxin Zang wrote:
> >> I found that some tasks have been running for a long enough time and
> >> have become illegal, but they are still not releasing the CPU. This
> >> will increase the scheduling delay of other processes. Therefore, I
> >> tried checking the current process in wakeup_preempt and entity_tick,
> >> and if it is illegal, reschedule that cfs queue.
> >> 
> >> When RUN_TO_PARITY is enabled, its behavior essentially remains
> >> consistent with the original process. When NO_RUN_TO_PARITY is enabled,
> >> some additional preemptions will be introduced, but not too many.
> >> 
> >> I have pasted some test results below.
> >> I isolated four cores for testing and ran hackbench in the background,
> >> and observed the test results of cyclictest.
> >> 
> >> hackbench -g 4 -l 100000000 &
> >> cyclictest --mlockall -D 5m -q
> >> 
> >>                                 EEVDF      PATCH  EEVDF-NO_PARITY  PATCH-NO_PARITY
> >> 
> >>                # Min Latencies: 00006      00006      00006      00006
> >>  LNICE(-19)    # Avg Latencies: 00191      00133      00089      00066
> >>                # Max Latencies: 15442      08466      14133      07713
> >> 
> >>                # Min Latencies: 00006      00010      00006      00006
> >>  LNICE(0)      # Avg Latencies: 00466      00326      00289      00257
> >>                # Max Latencies: 38917      13945      32665      17710
> >> 
> >>                # Min Latencies: 00019      00053      00010      00013
> >>  LNICE(19)     # Avg Latencies: 37151      25852      18293      23035
> >>                # Max Latencies: 2688299    4643635    426196     425708
> >> 
> >> I captured and compared the number of preempt occurrences in wakeup_preempt
> >> to see if it introduced any additional overhead.
> >> 
> >> Similarly, hackbench is used to stress the utilization of four cores to
> >> 100%, and the method for capturing the number of PREEMPT occurrences is
> >> referenced from [1].
> >> 
> >> schedstats                          EEVDF       PATCH   EEVDF-NO_PARITY  PATCH-NO_PARITY  CFS(6.5)
> >> .stats.check_preempt_count          5053054     5045388    5018589    5029585
> >> .stats.patch_preempt_count          -------     0020495    -------    0700670    -------
> >> .stats.need_preempt_count           0570520     0458947    3380513    3116966    1140821
> >> 
> >> From the above test results, there is a slight increase in the number of
> >> preempt occurrences in wakeup_preempt. However, the results vary with each
> >> test, and sometimes the difference is not that significant.
> >> 
> >> [1]: https://lore.kernel.org/all/20230816134059.GC982867@hirez.programming.kicks-ass.net/T/#m52057282ceb6203318be1ce9f835363de3bef5cb
> >> 
> >> Signed-off-by: Chunxin Zang <zangchunxin@lixiang.com>
> >> Reviewed-by: Chen Yang <yangchen11@lixiang.com>
> >> 
> >> ------
> >> Changes in v2:
> >> - Make the logic that determines the current process as ineligible and
> >>  triggers preemption effective only when NO_RUN_TO_PARITY is enabled.
> >> - Update the commit message
> >> ---
> >> kernel/sched/fair.c | 17 +++++++++++++++++
> >> 1 file changed, 17 insertions(+)
> >> 
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 03be0d1330a6..fa2c512139e5 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -745,6 +745,17 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >> return vruntime_eligible(cfs_rq, se->vruntime);
> >> }
> >> 
> >> +static bool check_entity_need_preempt(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >> +{
> >> + if (sched_feat(RUN_TO_PARITY) && se->vlag != se->deadline)
> >> + return true;
> > 
> > If I understand correctly, here it intends to check if the current se
> > has consumed its 1st slice after been picked at set_next_entity(), and if yes do a reschedule.
> > check_entity_need_preempt() is added at the end of entity_tick(), which could overwrite
> > the police to reschedule current: (entity_tick()->update_curr()->update_deadline()), only there
> > are more than 1 runnable tasks will the current be preempted, even if it has expired the 1st
> > requested slice.
> > 
> 
> The purpose of the modification is to increase preemption opportunities without breaking the
> RUN_TO_PARITY rule. However, it clearly introduces some additional preemptions, or perhaps
> there should be a check for the eligibility of the se. Also, to avoid overwriting the scheduling
> strategy in entity_tick, would a modification like the following be more appropriate?
>

I wonder if we can only take care of the NO_RUN_TO_PARITY case? Something like this,
 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 03be0d1330a6..5e49a15bbdd3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -745,6 +745,21 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
>         return vruntime_eligible(cfs_rq, se->vruntime);
>  }
> 
> +static bool check_entity_need_preempt(struct cfs_rq *cfs_rq, struct sched_entity *se)
> +{
	if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <= 1 ||
	    !entity_eligible(cfs_rq, se))
		return false;

	return true;

Thoughts?

thanks,
Chenyu

> +       if (cfs_rq->nr_running <= 1)
> +               return false;
> +
> +       if (sched_feat(RUN_TO_PARITY) && se->vlag != se->deadline
> +                                     && !entity_eligible(cfs_rq, se))
> +               return true;
> +
> +       if (!sched_feat(RUN_TO_PARITY) && !entity_eligible(cfs_rq, se))
> +               return true;
> +
> +       return false;
> +}
> +

