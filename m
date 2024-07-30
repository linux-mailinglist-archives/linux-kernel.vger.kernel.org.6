Return-Path: <linux-kernel+bounces-267871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 997AA9417E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F837282DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7B0189907;
	Tue, 30 Jul 2024 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYK/RXEO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91C1898FF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356048; cv=fail; b=U9ClVgfONOL4ElrVM7+Gollaji+uSXjrBAWoG0ihCXARfEZ2rbX2/ZHMJ0ORvoqBE4vWtI5oNEhOiDHe9nGG2SdWmC38d+8H4Qn5X25cJSgCcdHnMYPlvXWrLdDrIfkxw6/45sigwwVinyFHMi6mqQVt4Hjk7we0ZKrjMK/6DPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356048; c=relaxed/simple;
	bh=+F2Q6ev9t25iNav3PuySVhQXUD347kNTQ4FKHva0B14=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k+7Abh4lCrZRPKV45FMBdNEHgomTGlQJLJOMfA9Tbj7I3l7ZOELvkNbjJxS+JiEKxTEUDUfYu2WNoAbp9mafGf66PIK0rQsQITsUnEVgrI5w8eSk4FeHu3ZvG9ixI7MLWHCfOZJTTRa4r4qrYkWOEeRRd7+KhKNy+lCaHpHv/Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYK/RXEO; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722356046; x=1753892046;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+F2Q6ev9t25iNav3PuySVhQXUD347kNTQ4FKHva0B14=;
  b=aYK/RXEOA/mTYivHeUTmDJiMEf94gX1oRFJaT/ZCXKMUJKq37ir7wl/F
   tODGf4QF8/zdsXAiZAtfbODP8+Yr87XLQXqft8aKr+dLYBbvkIq1K3PIs
   cmChWf7NnXioTC/p5NVV64miYs2b0zdi6km5T/48Q2gRldgiqy90D8lFH
   Ihjpgo5q4YQaa7CUeINaAyLaRNhaS1vHZkQ89if52A5MSJ+xjkuftIxhg
   Br3Oqj7dE+6iHe7ShZ7Qs3gq0eAr9mwtqnxY8Ri7dGNatsP/m4lpPoJ/C
   ItHvtDMaDFKkQBz1U6OiwTaUYVGzalj+Swg7Whop4xXtaOV/gS/8Y95N5
   w==;
X-CSE-ConnectionGUID: ZYzRs+/VRISY9F3rGFRZuA==
X-CSE-MsgGUID: y47MPtw5RrizF+THE2SKgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="19991749"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="19991749"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 09:14:06 -0700
X-CSE-ConnectionGUID: RM5WZ7T7RO+C0zqVkkiLxg==
X-CSE-MsgGUID: YG24rXh9Rxy2+u0iP+eH+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="54369690"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 09:14:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 09:14:05 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 09:14:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 09:14:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 09:14:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKpEEFS+aL5RmLbDc+jkyAcSI7bT4HCOCjz//aqrsIYID6kGtASkbSvxd9aeHAtQr4fmA1hZeYHwFk3Rt3LWVEPaXX02ujbymccZVcah6GUwdwEWJUu9Rev7PHW1bliZOibPmJO+/2+aN6cYhdR+633Ec9Y6xt0yko2zZYwsXGzkonbwT1do2hxU2lpIPUA4dYRdALMbV5iEQOkJ/y7EcGf1et0MBtm77sABmwQz2XtpByTX3K+Tdaw4jHdeQXesFA7o911XAbwBBHQXc6FuLsqDawVWJzq9OAppLqDMt5lWS4tnfvFI1/HmHwiqDWMbVBJq2p8wVQ7EfaSA0cxyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/8J86ovkA9EFBZOCwz61yTPw/7fYMNCQKeg42WkrTU=;
 b=iNk1tlVv4EEDRfm3L31GGXvSNTrJyqTVRIHvpoiwh3OJ1J10AahayqfG3TNilX0/9cGMqrmKkFPxJGQQvfUSAd1pUp53tk3V+6fGV0SQVmkxGEk1NaRlDrVy97nogC4C+lxFil0uV8ZNAV859XZ3ALDW+pJqQLKemwdsNkYePj+wLn1O1bdIZ1c0efxiFah84lkXmtscyPuVI5QexbwJO2H97/s0X5DsFz86PdzM36LylPyyucbgWtjpk8rfqIHdHJE6UVpG1VGqFVlQnk+C+klrgqtZY18pKTJHo1xAL64Dqf1SwuGK4efb/fIFtTqIoTOaAV4w7G3q8ny7HLoFxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA1PR11MB8100.namprd11.prod.outlook.com (2603:10b6:208:445::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 16:14:01 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 16:14:00 +0000
Date: Wed, 31 Jul 2024 00:13:40 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Daniel
 Bristot de Oliveira" <bristot@redhat.com>, Valentin Schneider
	<vschneid@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, Imran Khan
	<imran.f.khan@oracle.com>, Leonardo Bras <leobras@redhat.com>, Guo Ren
	<guoren@kernel.org>, Rik van Riel <riel@surriel.com>, Tejun Heo
	<tj@kernel.org>, Cruz Zhao <CruzZhao@linux.alibaba.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, Zqiang
	<qiang.zhang1211@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, "Gautham
 R. Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH 2/3] sched/core: Introduce SM_IDLE and an idle re-entry
 fast-path in __schedule()
Message-ID: <ZqkRNGLEHIsgxtSt@chenyu5-mobl2>
References: <20240710090210.41856-1-kprateek.nayak@amd.com>
 <20240710090210.41856-3-kprateek.nayak@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240710090210.41856-3-kprateek.nayak@amd.com>
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|IA1PR11MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d9bfc7-1758-4857-a506-08dcb0b29f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HjOcxv2qytdPM1yc5E6NJF25NMRlTZqhGNSNeD07RNoP8sMguRQBMQ1ODL+A?=
 =?us-ascii?Q?55N4pCq3PsDqxiGKHDAYsHVQh8di/nDsrmpLlwI4AqOmkutdvJ7CDS4V0O3l?=
 =?us-ascii?Q?vlY/Fpswb+iFbfM2s4LkSMA5nQOmqInQ1YeF3Po51YoSfdwWR/1paAuj+Nwh?=
 =?us-ascii?Q?fdVH7s3MP8f03oY0fdGzMVzJ8gxzxtEcBC7k+aqkztH9k6N5N9n5yewBcJKl?=
 =?us-ascii?Q?eofzheO0skdSg6nHGGATYrupZFqoW6zoYB9INA50D+I6ZJIwDyYyrOiTz/GV?=
 =?us-ascii?Q?U7vhN0oFyLuRE1evMpVOatZtSNoIB5+zY63Ef49XPWknRee6PaNDXOtbli8i?=
 =?us-ascii?Q?FA5nHBcDin3LxadHUgLUoGLgv1Ipo1PYjdp5qG197Vqcat7mp+Cc8w80ePud?=
 =?us-ascii?Q?IgTT8O+J7x4GpZsBy7iiR4tLsP1J/CpYY3/aujaxyZSJtSxiL9JY5k6fVmGG?=
 =?us-ascii?Q?OTuISv4FmTlcqqoV+cDgW95Htu5sprMRLweifVl1wFNLbqxXzpgWG89HoluQ?=
 =?us-ascii?Q?BB22MuZPceBXEc3x7HTRKzfikq4gfdChOuY6kOlEV5FBpU8CQ4FmSwSYQWC+?=
 =?us-ascii?Q?jYUmodkSzXTvywZdYJlBfYR+ikubEpv38c/EhggBLxSQClW3wxau83Z2fmYI?=
 =?us-ascii?Q?u5So3PRB5FJyPZpdpYM1WAv+t5tMsi002Ct13tTbtaMtDXKaZhb1995/JtgT?=
 =?us-ascii?Q?cEFYR7gtFFqjoqR+ztOHvDXUwBKAhbXGGDDHsZTBprfmyd7Ev73iX3xgf9BI?=
 =?us-ascii?Q?0IY0k85kWkA4ie9Gt1awdxQvilZe2RzjLXNQNG9HzwzyZYHxt8nNCMnpexH7?=
 =?us-ascii?Q?p7ZGwgtvdn98A+wlKevwF21v4Exoaao/2slx7a7V6ZHO+PLNcqgcnJhbAGuV?=
 =?us-ascii?Q?L9Z6fCQVOh6eybHecvhnkO6eS6RzF+U1vxfL37oui3LcaZmTK0jYqZsMOpOY?=
 =?us-ascii?Q?bXoo4AlJS6B6jFZjJYy1hTV8fbWF0DZIbNN6qtnDgJqtmwbY8IKOAp0z9+Hf?=
 =?us-ascii?Q?OllQgUi4qWFvCePqpJ9K3jCzaPyG3NwYATStDH2wvv7YeObYsljCfVzVMMTB?=
 =?us-ascii?Q?4GumG8hgipUwq+eHctsArKWDOAad5stDYpSDytvEt2n3iw92WTp9/qgQatgl?=
 =?us-ascii?Q?9b26jU86VfW26G1BId151pIurFTdoDjisK0oUjIJFoCzO2cNrsbYioKhck+b?=
 =?us-ascii?Q?0ghE3jIeKDACkAbCPsGxbizkOY7D7QenITRsUGvgq8sdn5MZK9mx1q9PENz7?=
 =?us-ascii?Q?TbtJzCESiVmAILSLVCb/P2KulO3oCW2DJRn3DgQADR7jormoT+uxC0pHIfJO?=
 =?us-ascii?Q?/fY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AhUr5sQs44VBe+99Ah1AW1fVKNGYD/gF08gZ4UTnDIS/0eDjx43MxleAXRVU?=
 =?us-ascii?Q?/IFpQxf8V02Hxr2SmP+QjQlvuSFvJNxnJBmwAPO1Z0/RDjsFCzKwpzEy14C3?=
 =?us-ascii?Q?Cb2AtcoNed2ry1mE8jPkor5KwjDcg5Nws4buCqFnW/UbHZki7Z3QftYr0wxO?=
 =?us-ascii?Q?HK4ilEJwhF/byWYlXAJlJHFX6VHLlYvFrKOXhQQCm8fMMsyttNBqCNJc3osR?=
 =?us-ascii?Q?ybpx3tPli/znmZb5yt4OPI+FbYx9QoIv96qKG1Hp++uvHfLj1ibSd/Srw4bd?=
 =?us-ascii?Q?CfqzuIqmz26dXtLDBdZYiV/WAe5MIUMC88n4swiVaqsZLNimq4t7r29XDvrF?=
 =?us-ascii?Q?Ef6si41o5qbvOlyQXFiKE+YXR2U93XYjdG99+G0GPDZbNfPv+WU9/4URmdp4?=
 =?us-ascii?Q?iGDi77r7MsXqmepHZ0Xk7k5etx4CKErOXNpqLC6Zh3Myw9kQh2sITeoFj6wm?=
 =?us-ascii?Q?d6MOxZNMzfOK3x7YFJq/j9ZlxJMHe5GmX1OeWttQzDRipf0XxLp082/MBzRg?=
 =?us-ascii?Q?a1WSKdTCbv7xqvmO3OovYyPcXem3BgBmDX/TZLCxp+O6UvTBushtU2nifqVa?=
 =?us-ascii?Q?vRwwTvEwCP8EHKPXeVOOx/BiySamcjyBoJRNMjSBM0+LyFucNYN3VPMsPvyr?=
 =?us-ascii?Q?o043iC3etytITJqjsZDEhtrIAT+FpAsLmWKZ8uJfaLDdpBq1dZDtVm4B4j0c?=
 =?us-ascii?Q?q8Y8fx813rIoCA8OxCUttE3hLZB+QU44F0kxpHmR1Qrsyu+DCtZQTjiI6MVB?=
 =?us-ascii?Q?6HnfsXYO0AiYzYD82ArQ3mosfpLhjuFmLiR1FhcYjPve9vWH6uZxtH01ZEO0?=
 =?us-ascii?Q?UCDe+kqyoZn0ilcLmXhxDalNEQdF/51mvnMr2ja1yMHTChyiuaRfi/BZbFo7?=
 =?us-ascii?Q?xTPzhr1581vBhHqUVc130VCkegGbfpQGuKE1NcpkjhZptsFBvvPnVGGC0kan?=
 =?us-ascii?Q?yQYD4kURjyRGS23TBPBS4bvd/BYeoLqCg36tSvuk6Uc1aEWXK6oiXKxnPql6?=
 =?us-ascii?Q?BQfdZBB6/XKNUimD8p82qrtXBr4GKTwF/3hBN+lU+Zsioy+xdovfbETkKS41?=
 =?us-ascii?Q?zHQa9USgbFG/F2a0QUz7HVdCGMbM0u9ieXsG6+ossuCbF896Us/h4A5kBaAt?=
 =?us-ascii?Q?U2ez/o3uvfBt+DSJ5gbERPvCzXJ+gHz8MmQVcAaSZ+w6FHuqHCoi8GiTscQh?=
 =?us-ascii?Q?CzQwDopOwXa9A7bbKhq8uuylK51j/ipTyhHQ6tazev9vuwzD9aSLcD4NFYML?=
 =?us-ascii?Q?4e9WG04cBVKIL51RWI8Bc0atzAm8tOZPieVOVp+LCPYiiER66JgZ28XOhpYY?=
 =?us-ascii?Q?obO+layEW26Hu87z3sdy/gtgeErt/ruXk5HfPwnmsK3fGcjE+/NXcjZLSrAY?=
 =?us-ascii?Q?aCOVncT6L2sAIqivOJcBOerGmWwpq2TiHz34awV4hCiJbGhL6MmVHHpBJQsS?=
 =?us-ascii?Q?Py3mjMXN3YNdlkT9xuFKnfJw0TTSovTmoC55BLpk6nZZfoomczw0cpHBCUdd?=
 =?us-ascii?Q?Kl4YF8D1cE9W28cyMKowUEqua9ScHv6VFxsmQfYY7lEKV3aH0301QKQz0FFz?=
 =?us-ascii?Q?YRZyzAfCkyKUO3YisfjMKwz6dh7zIBKB7Z/XyzT1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d9bfc7-1758-4857-a506-08dcb0b29f8b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 16:14:00.8752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Q9AWW5lhC62OMBtNIQW3LJlzFFxYvRmLEqsGsTrPdi6vityCZf6FK3OSP37wfJEXN+nq++8+8kF5/hFGqSsZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8100
X-OriginatorOrg: intel.com

On 2024-07-10 at 09:02:09 +0000, K Prateek Nayak wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Since commit b2a02fc43a1f ("smp: Optimize
> send_call_function_single_ipi()") an idle CPU in TIF_POLLING_NRFLAG mode
> can be pulled out of idle by setting TIF_NEED_RESCHED flag to service an
> IPI without actually sending an interrupt. Even in cases where the IPI
> handler does not queue a task on the idle CPU, do_idle() will call
> __schedule() since need_resched() returns true in these cases.
> 
> Introduce and use SM_IDLE to identify call to __schedule() from
> schedule_idle() and shorten the idle re-entry time by skipping
> pick_next_task() when nr_running is 0 and the previous task is the idle
> task.
> 
> With the SM_IDLE fast-path, the time taken to complete a fixed set of
> IPIs using ipistorm improves significantly. Following are the numbers
> from a dual socket 3rd Generation EPYC system (2 x 64C/128T) (boost on,
> C2 disabled) running ipistorm between CPU8 and CPU16:
> 
> cmdline: insmod ipistorm.ko numipi=100000 single=1 offset=8 cpulist=8 wait=1
> 
>    ==================================================================
>    Test          : ipistorm (modified)
>    Units         : Normalized runtime
>    Interpretation: Lower is better
>    Statistic     : AMean
>    ==================================================================
>    kernel:				time [pct imp]
>    tip:sched/core			1.00 [baseline]
>    tip:sched/core + SM_IDLE		0.25 [75.11%]
> 
> [ kprateek: Commit log and testing ]
> 
> Link: https://lore.kernel.org/lkml/20240615012814.GP8774@noisy.programming.kicks-ass.net/
> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>

Only with current patch applied on top of sched/core commit c793a62823d1,
a significant throughput/run-to-run variance improvement is observed
on an Intel 240 CPUs/ 2 Nodes server. C-states >= C1E are disabled,
CPU frequency governor is set to performance and turbo-boost disabled.

Without the patch(lower the better):

158490995
113086433
737869191
302454894
731262790
677283357
729767478
830949261
399824606
743681976

(Amean): 542467098
(Std):   257011706


With the patch(lower the better):
128060992
115646768
132734621
150330954
113143538
169875051
145010400
151589193
162165800
159963320

(Amean): 142852063
(Std):    18646313

I've launched full tests for schbench/hackbench/netperf/tbench
to see if there is any difference.

thanks,
Chenyu

