Return-Path: <linux-kernel+bounces-198618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0586B8D7B16
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82EB61F21A09
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C5A225D0;
	Mon,  3 Jun 2024 05:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJ0rsasm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B9522F0F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717393895; cv=fail; b=a1lX6/0t2D4uF0zVznL4AW14Usm6h/UCd6YYbRCiSG8ct78f1tCa9KHIMyZGB6pEpzQ9XCmYDzRtC6hYxlYPtzGPvw0utcCNpBrxObEnR2kSq3LMHYKMzEmF5NiTMrk1Vq+Fao83jcreA5ZK2dsaTpqgAuZlyI/DG1yBUavn8ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717393895; c=relaxed/simple;
	bh=ETkR4AQVOQQJ0r3SokueCrrsqpEztdEYnMNLcDI5EGw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BRAg2UDp+PyQujJp80kB+Icbv4bMdPUM+UJ+53ZJJQ1FuY4mLl5hU6EWj3k5kNSmMBO8Nn+0/KAYWJEmDMHeRswK92tWp5l4448Ztg/M2EmjpHLDyjqCIXH7D1LADy5qIcRzUjOk1uLQIQVFMl5q59i7dCcueZEhcpCTazYGf3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJ0rsasm; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717393893; x=1748929893;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=ETkR4AQVOQQJ0r3SokueCrrsqpEztdEYnMNLcDI5EGw=;
  b=gJ0rsasml5K5OsGq1TRqmdlOpDX2pY15NG/iJ937cb65fNCPOmVWTFlV
   xe0kcXKHVYZUV3pExHrnb13lAY7Ohhqq6K/qJopTHrqPFfwTjbvmWVa31
   gPE6MoBriO6Uio45nUC+ODz9cCKCTPqS5keO1sgjzCs4F3QNQW/Ehbfci
   PXKDqiQHrkH+4elxJW+7kP8FrZ2plBXW3iMde20CH0bdgdij1+WjOWrt5
   mJGn1ABD8aYt23zCaKxRFa22r0Y2dCpS7nMgC3S4/nJgm6vNGd55tUN7P
   fWNL1J7fgUMygw8885FKualIWbRxR+qYs04BIn/TvuUbea0MQe8ggy7z7
   w==;
X-CSE-ConnectionGUID: cwmiakzXQbinEhQvRRmL/g==
X-CSE-MsgGUID: M3l6P7CwQauJu950czH6Rg==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="14097494"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="14097494"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 22:51:32 -0700
X-CSE-ConnectionGUID: 7THUJRekSIGz1fVGFdR8lQ==
X-CSE-MsgGUID: ypK/OdCoSgGtZ+2wLPO2fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="41696017"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jun 2024 22:51:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 2 Jun 2024 22:51:30 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 2 Jun 2024 22:51:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 2 Jun 2024 22:51:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 2 Jun 2024 22:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjSHVTVQHqwLtdDv8yLGtiSUf16M8FR7E8jbILBDxemgEqrsvGgopNy9YWva0qLhEM6czxp4eKjCk1BoW1kw23EASNapdDiwXtGDPMOLU6xvrnDsougPykGMvFJPYyCki6Vlq+6oOPZzpjE4yMv5Fck5qICKkvpcGWh2edY1DxJP4We54jZ2DzYREaRUIGHHacViIKxu+mYAMNpu+vJkLxR1Koj7ASFDxuQ7rNw6RqHsGOZxKo2AfRMvgItqYMQoNCCKmF8NUlSciAN/YuJMh2/OZwM8zMCyEIWpUEV6QpVu67hksubAbSLkKp4o5vT/2Tvv+OJoTZAminEBSNgJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7XN2bhJYef8k28Qs1wHzTCtmwb1Qpi7FlHkDIPsepY=;
 b=SlnCoOXpcBY7hCrZy4mDFCnIBwbLX10gZFc0L1/BFHNqbsOq8nxvfprXMGqemVzPt2QY7Kx3R7hSMtGe5g1k74RhVUNQNmeIDCXOZxRulXgWLTzgEIGieoJf9/3C4ms2VVXI5JuInTHAWo0RHDD0PEZQVcticUudfgtxZC7oYlmMa4LRVWQ0mHQ3mQgEgnsiovZbI4vkR7LMjzyNh7jIVjroMxmYzzaAE55WV0BQvMlJwa+2WlDwlNcEJvq+6Bh3LqEW0awNy4wu7cpvzgAV+XY1qndKs/RAf81oehuNAahkvslXN+EEUDBLBJ1G1QK9UCxwIbUwtOsFD9In4UxbvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6148.namprd11.prod.outlook.com (2603:10b6:208:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 05:51:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:51:27 +0000
Date: Mon, 3 Jun 2024 13:51:15 +0800
From: kernel test robot <oliver.sang@intel.com>
To: pugaowei <pugaowei@oppo.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, pugaowei <pugaowei@oppo.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] sched/fair: updates weight of cfs_rq before
 update_cfs_group() in enqueue_entity()
Message-ID: <202406031240.f2476e94-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240531030833.3375-1-pugaowei@oppo.com>
X-ClientProxiedBy: SG2PR06CA0195.apcprd06.prod.outlook.com (2603:1096:4:1::27)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3b6aa9-b261-46df-22a5-08dc8391358e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p5A+M/GFcMGgWwszSZHYVXHHnhq7yLOyfhDM6wmQBtT9/eCIijz1h0NqAI4I?=
 =?us-ascii?Q?+aL2jzuPMVTREpaIi2jeBgZDjOlUuzq1QTg/G6c6ZA0/yTwZdr2du7Ypt1mr?=
 =?us-ascii?Q?+cm+YgI8KKFGj7UhJt54iIHXRiNTexNBIf7Il/k2bdtV3MpesmGqx2MsRVF0?=
 =?us-ascii?Q?LX2CS2Pd3m/1fQmOqYg2M/Y6UiUIcNjCWcY0N7SnPDYOIO7nXjzlM/OstSRi?=
 =?us-ascii?Q?IXO+woBSZ/ckD/2kQV6NAeB62AKE52LItQc18sNwKxqhbmBM/Ay9Phcnj4Dn?=
 =?us-ascii?Q?CEwnvv9Gsi1L33l2Ljk6QzsWzMKTnPcSd3r5cHabWz58tfoiUeRuiqKO1Uaw?=
 =?us-ascii?Q?Q7LNOw4eu/L4IQO4/LHYOqEkk15fyq7TDW94Ira8usIFk0agCQA1EogvQC6m?=
 =?us-ascii?Q?KWLAXseWxWnAajXpyZFKAXnLOKNBtSGRqDQC8mTfp+R4ENMubTPPvdSpl2l0?=
 =?us-ascii?Q?ZUCqoVyQPqsd3+oNW3wI0BljyqTEfB/psOg1YsxhBg6ClqgR92kw/gNg02tE?=
 =?us-ascii?Q?97IOT/+MTUtEsDT5bPusU/4H8t7qxdH55PVBHwLk9lAp00n8ywH3PIInbQDq?=
 =?us-ascii?Q?h8p042Ge0ArkMCeRB4icsPigJMbg2A1pkswhIb2PZGoZolNd7tZMfoYCLcPm?=
 =?us-ascii?Q?jqicTOXcXSZs+CoK5kjhfyQ7n3p/a1r2ijb3RQYyHs01b7h9CY8yDIBmoPXL?=
 =?us-ascii?Q?5utI/DvtYg3WVI1jCi8qT4G5qz5oPqRtdjcMtbaQmsBKMiDBE0wVPmlSccOs?=
 =?us-ascii?Q?eqXWdYVm/NJjsEWyvfiDIl9dj6xzZOuNzuUfyg0Wtcnh2/P76A/N7FivTeiE?=
 =?us-ascii?Q?rfoKnk3+POPPdW7WLuyxSprOYpsaiXe7PFfi8IaB9HR5ShRMWhpcEFi96MJM?=
 =?us-ascii?Q?cc0iz3LxDuV6eFrw9fJEx0aTSP/7TxkSS7Uro6KxiFRwKszviqCkgBdqNnJy?=
 =?us-ascii?Q?No2JAzcIQwHSY6/DzYle0vXNY+c299hdias0a8YPsHxVutamzY96JkUvBSFC?=
 =?us-ascii?Q?fQTvlWC9LYqPBtbOZgisa3gPxWHOUrsTfTw6x+idne+aTNdeNFZEEb1Jmh3Y?=
 =?us-ascii?Q?yC7yBk7x3WnHrETOHysOdl0XQUHNHCXYuUur8XOpZ5X/gLVJyFWR87m66z4A?=
 =?us-ascii?Q?9oipESLawUEOV2aWpGyyZyaTZ1vny2iYrLrr6iBXYQkfzj9iI5tBhbpT8+sX?=
 =?us-ascii?Q?QFcPLDFS84xyrsX9yoDWzsSYoYFPTgXOcuZmSjFjHxs1tOKNmz0XXTo+ee8?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IdfKc5zOIFB9TTMryF6bVmWdfzLg14QkeIk0eL0D/eZ8+WokTS2Vq0R1koSU?=
 =?us-ascii?Q?nbu3TLFv7aUiW0fVjIZ47ZYv5WhmkQhwSLD8T0LJx88GsihEzipK7AsQWwq3?=
 =?us-ascii?Q?h8FeiE0d0HfMkcAESriPlJfJdorQC/Kw1nZsEFUfTyIIodb5M3Yj3pMNPMQX?=
 =?us-ascii?Q?J2OBUBMdNT6DuKgRq8og04pb73fIRlzB1uP9FFEnINiUOluNkIIpF2BQ/kQK?=
 =?us-ascii?Q?d2OhLkpI9BCDufLutGAYK/k9Yp7DcdmhsVb2knErQbhkW9p1WaRN7+RtfNTU?=
 =?us-ascii?Q?y55N6e4A2CroTnrCTWPDWanGpuW4udJGH7Wmjtu4ZuVY7M1ukP5Ei6ev4mvy?=
 =?us-ascii?Q?4fGgJgUb8vUV5QVeR+TDDtcXyW/7ydKvoleZzpkM6McEeqk6/LOxQgjWvhla?=
 =?us-ascii?Q?g1YeLK3SOeG79HrPBUZrej1/pOTu+lmx6Xe+rLHFzuO0wSaeC8Qfs7qMFv29?=
 =?us-ascii?Q?vWcLKfM5sIzZlmEnr85UAKQEAc1rXhLlLyWdds9ETIALmbpfVA2vJk3RexLW?=
 =?us-ascii?Q?GP93X+30aiO+53u/bhAj9NxBZ7FmDIEP7Su9t7SjSDY1yq5wXmx8+2eoWHvq?=
 =?us-ascii?Q?Nz8GRGSdSRTwrIy7RFUgxrS0EEF11KLY1hJaPKuOQy43iSbTenn80TzUG1kd?=
 =?us-ascii?Q?WtJe7ne/WWXhqassjWJ58OjNow/8ie6LZ+yuQL+Kn17v2FJ2CdXn0UwmpGkQ?=
 =?us-ascii?Q?f/zjdmOjtqkTPRsxvg16KTQCEUIFc4HDNmpudcSEK1NBQ2rEpvn/Q3W3fj1M?=
 =?us-ascii?Q?gSKjzc5ueAaY81Udtl34Pg+2mlMl9lxm48TbuiJXdysvQnRpepy4KOa+b9Ux?=
 =?us-ascii?Q?FC6K5V598e9ZpQ/FUaKTnnpsFvhV40axB0+KBHWn5kZdN6OuEg/6kXVxLuqt?=
 =?us-ascii?Q?Lmd8zdI9bk6BkVVybPYERsDtMADDmQt71nWXyeUM7ehmDmyh+H/no3E6j/dI?=
 =?us-ascii?Q?Qz/lPJqz/NUTk49fts4QaDuRS8R8iqQ36Kj0MV7Gi9laNSJJWA1AflW6h//X?=
 =?us-ascii?Q?/53Oe/sq6sWhLvul5J27IZtX8RBsDLGDwlDKUJ6FGPJVo9xBHXHxwOnf+l7D?=
 =?us-ascii?Q?/cCTdNLO90Uj2cpb0uefuG9CoaMtfpe7MLwrtlgmhttWkwRknQgUlpT9YlCF?=
 =?us-ascii?Q?NtlJktJu1hp6tZfM7bo3z4qXPQ8/62APnWTXH/GL433WGMX+2A/RiWVhAtHu?=
 =?us-ascii?Q?uoBYx2QlLc6Qq5uj4fEfoqbPA9XBbUDeXTHmGai+KRO9z9lrld27kpctTaUh?=
 =?us-ascii?Q?XIib34Xzhjy71uCiZukaf1AOdxk9CV7W5MSyAYdYjJ+2uduM0DdwTht5TByU?=
 =?us-ascii?Q?v+oareK9p29NH9vYkjomKG1Sd2zzx9QDeNx1z2vzgyVjViZ471T7GYCA0wFe?=
 =?us-ascii?Q?HX+unl2eYK8wNNpanFX7DYSxdE+2/sF7STyZoHa/IGMgVBhq3/BZZX1txKGu?=
 =?us-ascii?Q?drbdlxs8tBJIpxSQ2sJS9rtRxsUJ4SuSvaasFaXPBhNAX6y1+GnAdR1y6gxF?=
 =?us-ascii?Q?s6fTY0ztaty8H2H3WBBckSSUV6Jir6gKahT2hcXLZd1DuegVtj4GGEFdwN3W?=
 =?us-ascii?Q?/YVYpSNPWAKD9+cV9hYzhJEK2Tb6coO/TOVqkXh1nt/SLGTCYO06VGUi9VE1?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3b6aa9-b261-46df-22a5-08dc8391358e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 05:51:27.4877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1An0R4rj3G4ikD48u+NDF1/KgWZ4m3Cww2io9YvjJ7UilkGbU/I/n7F/CDpMUIIk9+8agCGHXo8zYmk35xW/Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6148
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/sched/fair.c:#place_entity" on:

commit: 06d0c29c533e77cef4f1793343c78180b32645e0 ("[PATCH] sched/fair: updates weight of cfs_rq before update_cfs_group() in enqueue_entity()")
url: https://github.com/intel-lab-lkp/linux/commits/pugaowei/sched-fair-updates-weight-of-cfs_rq-before-update_cfs_group-in-enqueue_entity/20240531-111010
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 402de7fc880fef055bc984957454b532987e9ad0
patch link: https://lore.kernel.org/all/20240531030833.3375-1-pugaowei@oppo.com/
patch subject: [PATCH] sched/fair: updates weight of cfs_rq before update_cfs_group() in enqueue_entity()

in testcase: boot

compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------+------------+------------+
|                                              | 402de7fc88 | 06d0c29c53 |
+----------------------------------------------+------------+------------+
| WARNING:at_kernel/sched/fair.c:#place_entity | 0          | 8          |
| RIP:place_entity                             | 0          | 8          |
+----------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406031240.f2476e94-oliver.sang@intel.com


[    0.400409][    T0] ------------[ cut here ]------------
[ 0.400603][ T0] WARNING: CPU: 0 PID: 0 at kernel/sched/fair.c:5256 place_entity (kernel/sched/fair.c:5256 (discriminator 1)) 
[    0.400603][    T0] Modules linked in:
[    0.400603][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0-rc1-00003-g06d0c29c533e #1
[    0.400603][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 0.400603][ T0] RIP: 0010:place_entity (kernel/sched/fair.c:5256 (discriminator 1)) 
[ 0.400603][ T0] Code: 29 c5 eb 82 b9 02 00 00 00 49 c1 ee 0a 49 39 ce 4c 0f 42 f1 49 8d 0c 16 eb d4 48 89 de e8 a0 5c ff ff 48 89 c7 e9 50 ff ff ff <0f> 0b eb d1 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
All code
========
   0:	29 c5                	sub    %eax,%ebp
   2:	eb 82                	jmp    0xffffffffffffff86
   4:	b9 02 00 00 00       	mov    $0x2,%ecx
   9:	49 c1 ee 0a          	shr    $0xa,%r14
   d:	49 39 ce             	cmp    %rcx,%r14
  10:	4c 0f 42 f1          	cmovb  %rcx,%r14
  14:	49 8d 0c 16          	lea    (%r14,%rdx,1),%rcx
  18:	eb d4                	jmp    0xffffffffffffffee
  1a:	48 89 de             	mov    %rbx,%rsi
  1d:	e8 a0 5c ff ff       	callq  0xffffffffffff5cc2
  22:	48 89 c7             	mov    %rax,%rdi
  25:	e9 50 ff ff ff       	jmpq   0xffffffffffffff7a
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	eb d1                	jmp    0xffffffffffffffff
  2e:	0f 1f 40 00          	nopl   0x0(%rax)
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	eb d1                	jmp    0xffffffffffffffd5
   4:	0f 1f 40 00          	nopl   0x0(%rax)
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
[    0.400603][    T0] RSP: 0000:ffffffff8f403d38 EFLAGS: 00010046
[    0.400603][    T0] RAX: 0000000000000000 RBX: ffff9a3e4026a880 RCX: 0000000000000400
[    0.400603][    T0] RDX: 0000000000000000 RSI: fffffffffff00000 RDI: 00000000000b71b0
[    0.400603][    T0] RBP: fffffffffff00000 R08: 0000000000000001 R09: 0000000000000000
[    0.400603][    T0] R10: 0000000000000000 R11: 0000000094f4efa8 R12: ffff9a416fc348c0
[    0.400603][    T0] R13: 0000000000000008 R14: 0000000000000400 R15: 0000000000000001
[    0.400603][    T0] FS:  0000000000000000(0000) GS:ffff9a416fc00000(0000) knlGS:0000000000000000
[    0.400603][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.400603][    T0] CR2: ffff9a417ffff000 CR3: 00000001e4a1c000 CR4: 00000000000406f0
[    0.400603][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.400603][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.400603][    T0] Call Trace:
[    0.400603][    T0]  <TASK>
[ 0.400603][ T0] ? __warn (kernel/panic.c:693) 
[ 0.400603][ T0] ? place_entity (kernel/sched/fair.c:5256 (discriminator 1)) 
[ 0.400603][ T0] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 0.400603][ T0] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 0.400603][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 0.400603][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 0.400603][ T0] ? place_entity (kernel/sched/fair.c:5256 (discriminator 1)) 
[ 0.400603][ T0] ? place_entity (kernel/sched/fair.c:5182) 
[ 0.400603][ T0] enqueue_entity (kernel/sched/fair.c:5328) 
[ 0.400603][ T0] enqueue_task_fair (kernel/sched/fair.c:6785) 
[ 0.400603][ T0] wake_up_new_task (kernel/sched/core.c:2015 (discriminator 2) kernel/sched/core.c:4693 (discriminator 2)) 
[ 0.400603][ T0] kernel_clone (kernel/fork.c:2831 (discriminator 1)) 
[ 0.400603][ T0] user_mode_thread (kernel/fork.c:2876) 
[ 0.400603][ T0] ? __pfx_kernel_init (init/main.c:1459) 
[ 0.400603][ T0] rest_init (init/main.c:712) 
[ 0.400603][ T0] start_kernel (include/trace/events/initcall.h:27 init/main.c:1234 init/main.c:1001) 
[ 0.400603][ T0] x86_64_start_reservations (arch/x86/kernel/head64.c:495) 
[ 0.400603][ T0] x86_64_start_kernel (arch/x86/kernel/head64.c:437 (discriminator 5)) 
[ 0.400603][ T0] common_startup_64 (arch/x86/kernel/head_64.S:421) 
[    0.400603][    T0]  </TASK>
[    0.400603][    T0] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240603/202406031240.f2476e94-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


