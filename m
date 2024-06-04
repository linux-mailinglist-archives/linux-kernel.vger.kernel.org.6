Return-Path: <linux-kernel+bounces-199959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0CA8FA834
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D9DB27EEB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A8D13D2BA;
	Tue,  4 Jun 2024 02:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3cg/iD1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2124E1E485
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717467046; cv=fail; b=rdzr9m/fp8OjLW+FzLKfCjgQIT6Zea+X8T74sIgCUUaXyEsAO0tRVfvg9H52mMI1RXhVc1FWhgPgONYiW1zE/NdUWApz5WJ4yrcj4BDw7DYm8Ru2xH+oJUMaQJmGnXFAtfrGNsdCUjS+XEeIDGcAGQNkHCOQACcEfUyNzaUcNGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717467046; c=relaxed/simple;
	bh=+pbOfCVFn0bH3Eeub79E2ots+UM/rDwzTg3MPpIEp4w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mcagTpTC7PYPm15LntzOy04IEDYX6TKDTT4ezXp7bhz0RK/ffFyhgxos7hPRS/xerPN0nVbZNiexRHLGzCkAIK5z07ssY5qzTYiHQvyK1zQsKwu0t+USaodgkzy096WmiwzzqbXuQjYrswrlQNIhARpTz4lPVv/rlWK05z/7PNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3cg/iD1; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717467045; x=1749003045;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+pbOfCVFn0bH3Eeub79E2ots+UM/rDwzTg3MPpIEp4w=;
  b=l3cg/iD1cQu0/RC9WmQGup1fS5ZgVU/gI438KKfMTQqXwi5bldGx542L
   N0wmgGWZYtDCZMeP0X6GZUovX+n9QqLUWwidbSOWkc6uUQVc2ycPHA69V
   TYjCTYC9QXrl6RsAe/k3bv24/WWa7pILal1PE6mKdDQym9sbb4GJF/o+I
   qenkj6AiU6uh3QvTsljJOoZcEekXWofksyEc+9NbMn3lF3gZjs+oi7aTn
   YKzu+euq2ytOinN18cQ23MRgchR8eX5j7cdmSXUmy6+g29JM5YF7I10qO
   iChE6YdC4EPplb9AsXriD08+pajqU6L8yvabTy+xDAjs9PAjvgW0MpAxn
   A==;
X-CSE-ConnectionGUID: icFWofJ/SXWzQlWAExh+AQ==
X-CSE-MsgGUID: v8Vc41WJTsGPJVgRah+e2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24612667"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="24612667"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 19:10:44 -0700
X-CSE-ConnectionGUID: qnzIqgtNRm+SXmq4NuvseQ==
X-CSE-MsgGUID: zU5nlhq6TZ6DdD65YZSRcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37535799"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 19:10:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 19:10:43 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 19:10:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 19:10:43 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 19:10:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBkIGD8Rf5X2bD/5IaQXpfpuZkv+VQva9+c+OW84Xl6HqRtI+S0ZedcxNrvylHKyUqlf2E3Fvl/lIroPwlJ09RGSq8Zw82CtPu0WXMNZWX53jhlG2iaF6dyWGyXTeZd4YX3mrX/GAh7OCleYkzyWyNE3UNnf3PuK9W8/5NflUgUDGCP77Iqlz/bKF5T0EgEnSvFuVY+n91eRs67BoO2jrBf6QANdGwmWUSfYYwbWoVi4RZy78AEz/uklWZlzyCccH+++IxxH9o3R8E0REQLVr9usW0WqlPrPJBsusMX0cKzTF3joSRKmjd24aIvtk7Eb8zdYMMhvHB9+jrLph1MxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bLOOcnVwoJrTyBbvjyOgvbsq14lI7d60rjsqNs5iUM=;
 b=a4eACW/L8a4uez+yPzKXjFsepqnlk58ffN96145SXi3dFiPh8nbxTKeCRS8Ms+bLgJkl0hydknbSfVIHBcFdMYkZ4g2Gg0f3iPFUOaXuA/rJQWT0isxaAeGEIhSKbx6Cdjr3jaBLtTkwk305uy937EnBrfIFVbF7DGlum+TKnuSAlsXs2pHUu+Wb4ch/fJM5zj+M8YmT7NFZnjOzAkwqCrnF0LJiFgRok3NnrMgSgfv8DJSjefvIqXTluB4YGlV15D/fCv8OJu4V5re4uTwBGuZK23Y2zlcJbXFePLKBNJDW4cVLSbwtht4prFdmxzETz7gnOspCcFacPHJ1x3ljgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19)
 by DM6PR11MB4595.namprd11.prod.outlook.com (2603:10b6:5:2ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 02:10:41 +0000
Received: from PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::39d2:ae29:6e3f:1b6a]) by PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::39d2:ae29:6e3f:1b6a%5]) with mapi id 15.20.7633.018; Tue, 4 Jun 2024
 02:10:40 +0000
Date: Tue, 4 Jun 2024 10:10:29 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Tim Chen <tim.c.chen@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
	Vinicius Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH] sched/balance: Skip unnecessary updates to idle load
 balancer's flags
Message-ID: <Zl53lXjEmnWhlW8p@chenyu5-mobl2>
References: <20240531205452.65781-1-tim.c.chen@linux.intel.com>
 <Zlygeqy+SVs1KZYW@chenyu5-mobl2>
 <c3d2a49e580cea9ae86e692f72094119310adc8f.camel@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c3d2a49e580cea9ae86e692f72094119310adc8f.camel@linux.intel.com>
X-ClientProxiedBy: SG2PR04CA0205.apcprd04.prod.outlook.com
 (2603:1096:4:187::6) To PH7PR11MB6005.namprd11.prod.outlook.com
 (2603:10b6:510:1e0::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6005:EE_|DM6PR11MB4595:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a57708d-4630-4fc4-4d47-08dc843b8839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v7F7enPbXPzwKycgqwAh1x0j4145l+e9Jgncp/v4MYmgT71qWPazq66m5MtG?=
 =?us-ascii?Q?mDVGslmpi3lmprkIh4iWPsK/yDTJDnQYDJn8nnONeFXWS7c+hn3Z+isIs+DT?=
 =?us-ascii?Q?M3RI2xeGegGhyI/RdU3StOQRGDoEqlFaEiRN0fTdWNUCtxmJamb5W82ZVqb6?=
 =?us-ascii?Q?9eDRkgEQ88dbyzdIYPAKPI2W66zMbAuGsqQAXn5YVpfsuSUNv170gJbuRTXP?=
 =?us-ascii?Q?pu+I6AGRxQp9ITBimqzuvw540WtBpbqgZ9iOPoG0XW6iSPfPmk4ZwnFJyRD0?=
 =?us-ascii?Q?UxF0UdAmuNQbkUQcLLXcGVHLUMmefYpn5hgDsftxFY1gD0XUbMxz7IpsmA4d?=
 =?us-ascii?Q?dvpH0GC9v1oucuowMJKvH2Wo3Nn40ZTnHahvqmhwLv1buJi6PFtzJzDTuMof?=
 =?us-ascii?Q?z/2TnzSI7xahY0OFmywASjaG63fq3uVww5s0+YVPdbHJVew8OME/yaX3B9v8?=
 =?us-ascii?Q?kcEfxRBZ1MDdFZJe8L+B/lWnAi8fvmMbijz7NyGZ6wWIpTeZklLVMcLRsSnI?=
 =?us-ascii?Q?KSMsysusvPnCTQC4p5+RKJ47CvP/rXMNBnxVAA7VH/g3xSx4epJnYoxoEKq9?=
 =?us-ascii?Q?8XiK8PK6OtSnb3plNN1yFqDsw0yjZFQtalIcyHLsRyff+z9lF8yEEoVRn7sc?=
 =?us-ascii?Q?nrczc/6RvTjTcsr0ZEfd/2eZRt+qQ3qctnPUDX/jkqDpiWr37nU7PGqEzqKp?=
 =?us-ascii?Q?Jzcp1Gt4VTgvAhfPVoJaZUq/55UfuzONOSOWGT8LC1ifOcZ0Msw9e9d6mCVo?=
 =?us-ascii?Q?ZZvNT6gRqqiHAIqbsBo6pkMDTcWoOpM0NpPauCEN2YFIqsWXJaWidd96Twyz?=
 =?us-ascii?Q?4wsKMwM7RmiQaBicr0O6vIlTEgjbxdY2CBWNwZTW9alJ0ZpuZZHCD7nR9thI?=
 =?us-ascii?Q?chtscrt/FOz7SXgrm7Pcm/tU/l+aCmkjB9aL/WwPqcL/8eYY9NK+jHSMQhwe?=
 =?us-ascii?Q?sBCxQ/ZPAkeqJ356frQshtB5e1lAnKkSS5/t41Ug9wVqMSvD/OlUW7bE9N1o?=
 =?us-ascii?Q?9xWzLL5H5HGkloVrcSJYXMlbh4eMA3IzHtRts32Hcc578umHx1f+Bfz+i9Ti?=
 =?us-ascii?Q?8LckEo+jWCdPgHIhyVSKb0qoFTa/1QAYvijrfNS4kGa3v0aXSnbH1r4S5ZEy?=
 =?us-ascii?Q?AlnB7XOGlmS0cJaTKSaem7icbnj3AEScJHPuiUbGoUNF5/25PaoK/F41QEDj?=
 =?us-ascii?Q?jfXB8KMUCvikxDnpc/4di1EJkPBTdOCeEStF5eAupuiDfW2vmGqtIff9Shy8?=
 =?us-ascii?Q?reBFc3WriCxnGLHmjCd//BBCwKZwmOEGnelW+vtysg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DyeCDPtRS4jsGe3Ch62PO/DtIc+WnF7TuCVHizl2yNLhZ40P8xzJHHHfGr1I?=
 =?us-ascii?Q?GjHAbnTOXVjZNuP4ZrGT1b+Kf4/UjOCWuObf24meQEHBqOaSSo6E6Js0T8mR?=
 =?us-ascii?Q?MJOzEMIkKqi4v9QmyPu1gBBwnNGZa1YKJAnWgcHz6wBxbXf2SDkyDBKcW3Aw?=
 =?us-ascii?Q?hy/JevW1d2JzalcUicLpO460QWwZRo2UPOPfXS/md4pUFhvtiXZ9uLzbiZP9?=
 =?us-ascii?Q?wogCCHxxVptfJPvUyJSJ+nkFlc5R3cSAPm9QM2qwc+Qzru6ZeGQ3Kle1pzO6?=
 =?us-ascii?Q?wcCG1sI0gPI1iPhYMuJ1IIlSWRcZAtk4ZCQGLrR4QUIwUcwmFNRZKUJj7m2r?=
 =?us-ascii?Q?BLmWhC+j9Dt0OVC9XdOdOJYOzKlhZMQwBTb6HYSoEWgtVHw+yNi+SiAIUcpO?=
 =?us-ascii?Q?I7ElSzTaONd7pPFscJLO56joyKW2f9yRVXSdgSrXAYuWNvURdYac+QZF0zji?=
 =?us-ascii?Q?l2cezP3xEvWUPQox9+m6D0TLmclYUtd4IDr4k7uYuIyj6AeAB8yihatsLxIL?=
 =?us-ascii?Q?QoOV9d83dJ/YsmI9VyPEKcFtaXQMRp17QxWgiLU0kSgBYOFwj2nVwDgNnmoD?=
 =?us-ascii?Q?X6cV2CH+lQ3YzW266jdQYXC7eglNBMU/Qm/qgw2b0xagQPWMl2UummLn2OVT?=
 =?us-ascii?Q?5e2uAzXGV0RzKlFWdrgHsVMgXIF6Fm1H8+5etDdIoeUvoGsuUzic0L/BTuIb?=
 =?us-ascii?Q?ZvI90R/hx1/pUAfu/M1PoX7bMrwJFdVX6rmVWp3+kTpQCEI6dIESHZje/KG9?=
 =?us-ascii?Q?b7VuYbIJeV6TDvCcyeOGnRUwMqq/ZdvngdtdulehfbQcgU1QPxZQW6JJK26D?=
 =?us-ascii?Q?PSjVon1Ru7KHpjK2HDkQqlFAiWrNj6ZqvmJZRUUEdgzMzrv1no7V2taCwguh?=
 =?us-ascii?Q?JEaWjkx6jWZFBugLf10WeNxd2RatxQEHQmX0nAPHU2CtiGGtubBg8gkK5VCU?=
 =?us-ascii?Q?wLlaEs2VvvOXMJ9d0fUMRwh/GgIpPpgYwbIcEmzYOppkpWmKRgScsdOBCibI?=
 =?us-ascii?Q?Y6oN0rVK/ZO0kaCC7nfg1ss9B5jBwp6X25UlgBR442+PtqAqdz8LPcY5qnIl?=
 =?us-ascii?Q?zgyYR4b5eTsLtzLILn8XEegR4dwwcWc0D5xmGaphksZzqBgrj4iOj5TZJucg?=
 =?us-ascii?Q?kBXQC85FEuffIY/fB3qNJjy3zdwlH+8S7q6WK+IgFeKSvcXBKEbr4iK3c3VR?=
 =?us-ascii?Q?wjRgUHRDx7rnVdcn/3xPCcT6TsdjYcxmN5uAAUe4UDGzHO27STySgS/fmiGM?=
 =?us-ascii?Q?lHsyX7ZViX36qccuAglT2zJe+ynmEmBppxZXMpGBktFduN3z4BmvddjSpJAE?=
 =?us-ascii?Q?lRsnRoWqpja0q2yWkvvu0GWobpzwf5ltSNb05H5t13kcyplc+uihIEgO+TNb?=
 =?us-ascii?Q?vKRrhd3fa0C9iY1Iqx5ymFjo9MpsvKsOX1OSeRD/mLoiuXxlLNinfRnig5yK?=
 =?us-ascii?Q?vOZ0HI3izwH/Z6yJ9aQ5f+iapr0jUziE/HLskX6wpleIadoYtjz8tvNvy0Dv?=
 =?us-ascii?Q?5y/LlplwKoFaXEkIOyL9oGqJNIQFzQW4qfWAP6D7zl7WoUYrb8Ut86KRQHjp?=
 =?us-ascii?Q?hLj5KsPdKKlHnBQadDmssTZ4RM32oaXKejf0GZXO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a57708d-4630-4fc4-4d47-08dc843b8839
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6005.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 02:10:40.4203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/sPYAI2l3i33szhqITXv1Wtggjv84BjOM0mwNmDypJiYu/rJKS+81FaVLMr29gBODi5GJDrRUqn+qFoOMJrSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4595
X-OriginatorOrg: intel.com

On 2024-06-03 at 09:13:47 -0700, Tim Chen wrote:
> On Mon, 2024-06-03 at 00:40 +0800, Chen Yu wrote:
> > > 
> > > With instrumentation, we found that 81% of the updates do not result in
> > > any change in the ilb_cpu's flags.  That is, multiple cpus are asking
> > > the ilb_cpu to do the same things over and over again, before the ilb_cpu
> > > has a chance to run NOHZ load balance.
> > > 
> > > Skip updates to ilb_cpu's flags if no new work needs to be done.
> > > Such updates do not change ilb_cpu's NOHZ flags.  This requires an extra
> > > atomic read but it is less expensive than frequent unnecessary atomic
> > > updates that generate cache bounces.
> > 
> > A race condition is that many CPUs choose the same ilb_cpu and ask it to trigger
> > the nohz idle balance. This is because find_new_ilb() always finds the first
> > nohz idle CPU. I wonder if we could change the
> > for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask)
> > into
> > for_each_cpu_wrap(ilb_cpu,  cpumask_and(nohz.idle_cpus_mask, hk_mask), this_cpu+1) 
> > so different ilb_cpu might be found by different CPUs.
> > Then the extra atomic read could brings less cache bounces.
> > 
> 
> Your proposal improves scaling.  However,
> that could result in many idle CPUs getting kicked.  I assume that
> current approach of delegating to a common idle CPU will disturb fewer CPUs
> and let them stay in deeper idle states, and get the power benefits
> from NOHZ scheme.
>

I see, from power point of view, current solution is better.
 
> > > 
> > > We saw that on the OLTP workload, cpu cycles from trigger_load_balance()
> > > (or sched_balance_trigger()) got reduced from 0.7% to 0.2%.
> > > 
> > > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > > ---
> > >  kernel/sched/fair.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 8a5b1ae0aa55..9ab6dff6d8ac 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -11891,6 +11891,13 @@ static void kick_ilb(unsigned int flags)
> > >  	if (ilb_cpu < 0)
> > >  		return;
> > >  
> > > +	/*
> > > +	 * Don't bother if no new NOHZ balance work items for ilb_cpu,
> > > +	 * i.e. all bits in flags are already set in ilb_cpu.
> > > +	 */
> > > +	if ((atomic_read(nohz_flags(ilb_cpu)) & flags) == flags)
> > 
> > Maybe also mention in the comment that when above statement is true, the
> > current ilb_cpu's flags is not 0 and in NOHZ_KICK_MASK, so return directly
> > here is safe(anyway just 2 cents)
> 
> Not sure I follow your comments about return being safe.  Let me explain
> in details.
> 
> We will return directly if and only if the bits set in flags are also set
> in nohz_flags(ilb_cpu).  
> 
> The comment's intention is to say that if the above statement is true, then
> the later operation of 
> 
> 	atomic_fetch_or(flags, nohz_flags(ilb_cpu))
> 
> will be useless and not result in any change to nohz_flags(ilb_cpu), since all the set bits
> in flags are already set in nohz_flags(ilb_cpu).

Understand. My previous thought was that, what if the current nohz_flags(ilb_cpu) is 0 or
NOHZ_NEWILB_KICK. If yes, return directly might miss one ipi to the ilb_cpu(because
the current code checks flags & NOHZ_KICK_MASK to return directly). But from the current
logic when we reach kick_ilb(), the flag is not 0, and the flag passed by nohz_balancer_kick()
satisfy (flags & NOHZ_KICK_MASK), so returns here is ok.

> 
> So will it be clearer if I say
> 
> 	/*
> 	 * Don't bother if no new NOHZ balance work items for ilb_cpu,
> 	 * i.e. all bits in flags are already set in ilb_cpu.
> 	 * Later OR of flags to nohz_flags(ilb_cpu)
> 	 * will not change nohz_flags(ilb_cpu).
> 	 */
>

Yes, this is ok.


thanks,
Chenyu
 
> Thanks.
> 
> 
> Tim
> 
> > Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> > 
> > thanks,
> > Chenyu
> > 
> > > +		return;
> > > +
> > >  	/*
> > >  	 * Access to rq::nohz_csd is serialized by NOHZ_KICK_MASK; he who sets
> > >  	 * the first flag owns it; cleared by nohz_csd_func().
> > > -- 
> > > 2.32.0
> > > 
> 

