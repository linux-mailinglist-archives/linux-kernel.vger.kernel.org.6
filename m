Return-Path: <linux-kernel+bounces-229240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F471916D34
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE3628CA1F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C148216FF4D;
	Tue, 25 Jun 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYIxoqnv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BB616F910
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329720; cv=fail; b=QkDnIRsW2KDz+QkmvN92LjBOASeJUTTLc+zoV/Zg7h3D+HyHfBl3u/Ec92dNnBAhotsy9fS4yxANC0dZvwNmcEHPlka2EdZ4vadh+kmWLlJLVHqUPhzhupeIqfT4TGS3do7fSC6U1HyzqJkYFav3MQzeDGpqmL2do0hEEO4F+LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329720; c=relaxed/simple;
	bh=N0LUmHGAJPAE3n/O1OcVN3kliRQ2awhmyLYE53EhCcg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MpVcW2dqRRC8VHmrZH16HPhBe7rMTWYySHdE5ymVU5+dJsDbRNIo6MpY9iOiM6z4/YjNTcowMdr1rTmLeqJYU3n5dIaZPo91hfEEU79wpWkLikWtGTYK8B+Z0ODecmyxVF9tZIddift+pmWUGbmsbCWjVcBwOvvphWbZolF11cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYIxoqnv; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719329718; x=1750865718;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N0LUmHGAJPAE3n/O1OcVN3kliRQ2awhmyLYE53EhCcg=;
  b=MYIxoqnvyujQi85mlQ6Cy+RBs5AsF9Z7n51ZRf/WzV2J6cl660rFzJHa
   HeI2AeQIiZRRb5jiw4J0kYHcQfYG4fy8GOym1tGsI8IxxFna+5H5Sng6n
   prGjOg04APWKOMfil+3r2346POdUeyKhxj/+N/sUgfgw2U2gqrwym0Qdd
   ZnqcnDy51Li3Qu1FPsj8SYJdCSgnYAeYKzfQ/rhKcKvWDLBatP4GLIzbS
   fI7A0fUliJIwU5S1B7yawstelrxFYfAH4rXmWoxtVaGM8URZklJc9cE+Z
   TMOxvmyhSgCnT4gdOuUOt7J0T7xN3364iLmGK45Z7hlsjhczm3AeR+wpP
   Q==;
X-CSE-ConnectionGUID: grEEuc8+TTySpTN1a8TJhA==
X-CSE-MsgGUID: 75x7rXDsQH6owfBsM3GrbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="26947263"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="26947263"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 08:35:17 -0700
X-CSE-ConnectionGUID: rw/aWB1CR5yaR1TtEGVEZQ==
X-CSE-MsgGUID: bZxlmvWLSpq3Kn5C4HkX6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="44397347"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 08:35:18 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 08:35:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 08:35:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 08:35:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLN+muokfgr9t/z+N/jwvo45kRVHFfJR/X2nsgeUoAm+aHMu0gOxlpYDx1AV0SLGihG3HkKDjDL1dxYK+hWSkCxAH2x/kLZa599HjI2VeovRNfEGbm0Uk3ZUURam1KLDrrGeABu+SPA3u1g8rJufkoCNUq4F6uElGuIlZ7ID8f9Ota0dlczu8waqOb2qxiWsDDx4q7KaOCLJGxwjk+Gbi38cJRbvXj/4l/WHWe6Bh09tGimwSQEft7iss2N467I2Drph1xchdK2JHpqFVyrUKR9xCmgK5d+IInI5LV4oShPaD4YxNcWk58ohMmTtvxMget7/AJoK3/4kLQE9ks4hyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTGoJv0rMz+jaEFL/ktejeQQaFQlDyjMjwsqVYCfPf0=;
 b=BGIb5xXOSQ0s9WhzA+eSblm7y+0awZRaBmttPlCFAGRaMh1iwJ/0CLVZfHL90HiJv1D8zAKKc+p3nf066gZUjdRrzty/w1hwCxFYNfcOz0l2QYh7sIZtH9vQ40Yqm340yYBjHBj6Z27KThf6gZpSTslwdxDGlP+qpiKWUl1NTuFc/BzCoB3/62RXhwMov+Pnsqv+ic0/6DoxOY2UtGxiVKJr0L1arHvgDxfYIZjceyAZZufD/+jsyTNtFH10H/WEgYu210WFAtItkwxHk6gHLZNESlD+DUGCZCXV2gtFCLd1C+gkafEUxAKNiAp/OtXlxrGqtoOESk18wY22ByDcSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by SJ1PR11MB6204.namprd11.prod.outlook.com (2603:10b6:a03:459::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 15:35:14 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45%6]) with mapi id 15.20.7698.023; Tue, 25 Jun 2024
 15:35:14 +0000
Date: Tue, 25 Jun 2024 23:27:02 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Raghavendra K T <raghavendra.kt@amd.com>
CC: Chen Yu <yu.c.chen@intel.com>, Mel Gorman <mgorman@techsingularity.net>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Chen Yu <yu.chen.surf@gmail.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>, Xiaoping Zhou <xiaoping.zhou@intel.com>
Subject: Re: [RFC PATCH] sched/numa: scan the vma if it has not been scanned
 for a while
Message-ID: <ZnrhxnFRNI7CWlFG@yujie-X299>
References: <20240614045649.133878-1-yu.c.chen@intel.com>
 <021e0e63-7904-b952-af9c-7e1764e524dd@amd.com>
 <ZnEk3yARRPP9WXr9@yujie-X299>
 <b6c85c1d-0f67-4cb1-d1fa-0cee7e70885a@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b6c85c1d-0f67-4cb1-d1fa-0cee7e70885a@amd.com>
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|SJ1PR11MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 142e9c5e-bcc7-4d86-8976-08dc952c681b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vqhHeV034k5T1LTFlSQiOzsV2BugAtaWFsGuSR1NwLPKU7kFR/AkfrLywECV?=
 =?us-ascii?Q?/9IyaMnzxVhelPymyYZvtRGXBnIPNZDzavAndU6pcMlnyOlNvmdN4AnvmJxe?=
 =?us-ascii?Q?fak0XCAYnBft1oGc5dgGwK4McX9jM+EJgEK2TK+zto+Rb8RONIJBpb7TQb71?=
 =?us-ascii?Q?ueGWmdJdwE697Q5Um/xnmZWd2FFS+l1DdRDs8ZTgKQJHcPsm5l9HlX90R188?=
 =?us-ascii?Q?6NVUeH4WSPqzqMxlczSyA25QMJ3o6pEkZRDLORwFKxTqgePrv8WgO2cTVAfD?=
 =?us-ascii?Q?gmLt2h8Mz+hGv2LRovIBrASMKTghhTb9CifcTC406DmlF06ybLAUNC8WEyOg?=
 =?us-ascii?Q?iV5Uu/6EiZ8fMnzAcO5o9sj/wz1HPhwb3ctOAAaD5s10lUFG7DpXfZIsOj/D?=
 =?us-ascii?Q?srBj7aPIHx/kePJwlSzeUtd5ZzJiW+F7mbshrYF7eiNlwFB7OcT9fKUmKaye?=
 =?us-ascii?Q?mL67gmHtpvvHbTt0cM2LK3I61bPOzTrnuB/QKDGn80BmHnbCw6+t4iL1SeUk?=
 =?us-ascii?Q?3wUpCnF7WYgXXj3C/bwjEAwBDBQ7mqm++zr0vf4uHmp5QmwhsYs225R9t4V/?=
 =?us-ascii?Q?juj1jGVOwbwnv9YGGk9qBH18L59YqsGCFdy2XJh/3luzhutY6GRamyeozA9j?=
 =?us-ascii?Q?QvwCiIX/ShLCjOYnljsWAStHq+bf90iTxHPoPlPlP3VJAIiWV+3npw4TxZJu?=
 =?us-ascii?Q?9EglX7OQtxWJ2qxeU3EIuVC3mJDNBQbGcmFmsSs+OjHpbn7rJ5LG9IpzAhdn?=
 =?us-ascii?Q?aFsMIMGO0gL1gUDUj9du0oYOgNbnfDgMZs7sKfM5qMoKZVc/7o6XH/xF781E?=
 =?us-ascii?Q?pGFUUN/V+0Rkx8sI2JxExmsneAHTZP6USftbsRpf0ACrKXgG+WZTVRUa1n84?=
 =?us-ascii?Q?wlz7NihaA88cpHgz2iEuox8vHicyvgQVURdIeakzrSSRwSrvMsxSQ6Aop6iy?=
 =?us-ascii?Q?UICj1gO6e0Pl058q1n0WFjpsQLyyf7G9LokcVMqv0v7YeQAEf6izSWU5SASO?=
 =?us-ascii?Q?la4hmixnfLFPHvRWDjAzySjaeJgWk2HlJ1vZDWCQwt3mShpjLuMV453U0Xyj?=
 =?us-ascii?Q?E8H09Ld/rrOSACmlr6cT4j4URoyWkK5QoqzRv+7WcyKXi/TTkWSnoyvdge3b?=
 =?us-ascii?Q?kIEG2OGXyN9Dlj0H+ashN4MjbrF0ToMK0Joh1dbI2Xfg6tOuZvNNXdA9NIN+?=
 =?us-ascii?Q?3S+3eUbL9JDcNKDP95TGubrb4jDgi3xDXC9hMhTzJ647JTsXERm27RS/Xyf7?=
 =?us-ascii?Q?Vnv5LRA7o817UQd7/REhrx6xHrTZ5Z3ygLrhG9pDkg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fbj5ZH3c/aKGLblNIncGRr4MwHT3JuOZoXnUlKdMho1F0mdn2+AUt9FqgKiS?=
 =?us-ascii?Q?LwMxZyPmZaR/3dkhE1bUy9po67linXO+jxSFSkKWWbSOJAA3KGusYCN7LjJn?=
 =?us-ascii?Q?4jQKjCaz0H50hVEQhUR8l4P4eqPD58fdZX/ML+atThj9zah7YmRZE9sRkv/F?=
 =?us-ascii?Q?wRC+I22CKRbTvj9Dj4jbSszf3LRYoilvtnf2gksuqG1MVGd/e1JLspcdVKi2?=
 =?us-ascii?Q?chE91GcoC9CMree7GNuGjMnYxUCEUbZY2rSmRlNZwrUk1kTfGddoOgPgB9Tt?=
 =?us-ascii?Q?UOWwh95HTfU+7JwYE/jGI5D4pS14+EIOzOsgLYKFtzEj89ymiTYWHikrDovl?=
 =?us-ascii?Q?grBl+Xdd2dW/S7t8Y3BK29DFwUBVJQdgkyCak/Pbwfu2GimRHLBBbzreVjLC?=
 =?us-ascii?Q?dSmmTHZgU3q5XAxNujDk2HzU1qBYGHut2pdnieqFS+J/EnELlFf0QWb3oa+i?=
 =?us-ascii?Q?QpUdwWGd5mEgPFWc6AqArvviHTbrBe2z/SqhZQH2dSZ2Kvo2Z1utQy2qzFXW?=
 =?us-ascii?Q?/AM1fkdiFUyJ/0AKbJI/zIeGRzbrUsjl9UuybisTlxVsw22X4m4gjvC1JDXu?=
 =?us-ascii?Q?QRWxu+Bf5Q7lzEHeAwr/1OyPZ01COQYJu1JYJfYkRh4eG9ixIqoznw635/CU?=
 =?us-ascii?Q?OuzijrrdS9Hc9ZdtxpusZOIQ24HdsAMuQ3/se8vrYzMNJwx/T9AAqs6rSMoK?=
 =?us-ascii?Q?PdiU2ogxBc9p9R0JfPxcRoEY0DCWxU65GFrcfxesCAE+LmtnMjyZ9opbledX?=
 =?us-ascii?Q?t7B8G24jpkRFK3ivcIJ2hDp0GPT52GKIS7Y5+Kyrf9Mz/aG986vMmjD+hD/H?=
 =?us-ascii?Q?BOrokIr2d/RF1Dq7S+Kv5kjyhN0gAl40LP4G0bhEszYwSVim++my6eHWRYj+?=
 =?us-ascii?Q?4bVg7Zq45zGQvRE01rQXwngY8OTjTVbpc3VCgnAIX6fxI5lxRM9cPNApHTYj?=
 =?us-ascii?Q?B8vHOl+WrsjuYWoxZX5hczEfR/DmPXBJC1N+6ZD8V1ya/v/VzeEJvAxlJT44?=
 =?us-ascii?Q?RLlQncwNcNAJpDZHdV89tee7sJ4euu2p/QP7fpsuEWjNiQZnI7ANC5cp23Wz?=
 =?us-ascii?Q?eK6+x+V5i6phta+UJ9oXJ9/1F9iVWh42LT0ZQUJWAAmd4Hn2x+xLlbPrFqNq?=
 =?us-ascii?Q?xYUBI1vSCTNgSKvmhOfGHz4joRUusCyngD/P5WysPAaRIoLvZAfdd4OVGpgi?=
 =?us-ascii?Q?zdMVTQk9SPTZi199cohuv2Q6KQ620JB0qygAUmucNaKsIsdChTAu6acbAFBy?=
 =?us-ascii?Q?x0cEw7IgfH2qPBg66h8QyhQHS4XDph5iXBX170oTiFJaMFV7TibHmx6jryBE?=
 =?us-ascii?Q?Ct2BKM9G53h6A9ytOgrtLOMpS3R3myC0zUOpPHPB9h77/n57Tn/KzPgOAHTL?=
 =?us-ascii?Q?gGJceN/qNnKCt5Wueao0ACODSAVhbibqZsnt5LQWtzKWAeh1mATIttsxj2ci?=
 =?us-ascii?Q?ZV1kb73Uss/Ydeu53yzfRsOpofjyLcnKgekVLBHjuk5jNaC+Ci1hwKBP77LD?=
 =?us-ascii?Q?xZoTNvsVt/vizAL5+D2NB9DYrdC+KBmFsBKgrqnbBLEM4bBqVp1sOvZ2/R4o?=
 =?us-ascii?Q?LQiySAlerGSwJvdxXzn4qdVev4Cq2uy7K2vt3EmN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 142e9c5e-bcc7-4d86-8976-08dc952c681b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 15:35:14.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mth+sbkhx9ShwciSHarreEDketOqe55h55UQBv7z5xV8DH3RYL/YErYPlwnX0l6WFt4s8I02j1eF1xIpFUwShg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6204
X-OriginatorOrg: intel.com

On Mon, Jun 24, 2024 at 11:26:50AM +0530, Raghavendra K T wrote:
> On 6/18/2024 11:40 AM, Yujie Liu wrote:
> > Hi Raghu,
> > 
> > On Tue, Jun 18, 2024 at 12:41:05AM +0530, Raghavendra K T wrote:
> > > On 6/14/2024 10:26 AM, Chen Yu wrote:
> > > > From: Yujie Liu <yujie.liu@intel.com>
> > > > 
> > > > Problem statement:
> > > > Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic"), the
> > > > Numa vma scan overhead has been reduced a lot. Meanwhile, it could be
> > > > a double-sword that, the reducing of the vma scan might create less Numa
> > > > page fault information. The insufficient information makes it harder for
> > > > the Numa balancer to make decision. Later,
> > > > commit b7a5b537c55c08 ("sched/numa: Complete scanning of partial VMAs
> > > > regardless of PID activity") and commit 84db47ca7146d7 ("sched/numa: Fix
> > > > mm numa_scan_seq based unconditional scan") are found to bring back part
> > > > of the performance.
> > > > 
> > > > Recently when running SPECcpu on a 320 CPUs/2 Sockets system, a long
> > > > duration of remote Numa node read was observed by PMU events. It causes
> > > > high core-to-core variance and performance penalty. After the
> > > > investigation, it is found that many vmas are skipped due to the active
> > > > PID check. According to the trace events, in most cases, vma_is_accessed()
> > > > returns false because both pids_active[0] and pids_active[1] have been
> > > > cleared.
> > > > 
> > > 
> > > Thank you for reporting this and also giving potential fix.
> > > I do think this is a good fix to start with.
> > 
> > Thanks a lot for your valuable comments and suggestions.
> > 
> > > > As an experiment, if the vma_is_accessed() is hacked to always return true,
> > > > the long duration remote Numa access is gone.
> > > > 
> > > > Proposal:
> > > > The main idea is to adjust vma_is_accessed() to let it return true easier.
> > > > 
> > > > solution 1 is to extend the pids_active[] from 2 to N, which has already
> > > > been proposed by Peter[1]. And how to decide N needs investigation.
> > > > 
> > > 
> > > I am curious if this (PeterZ's suggestion) implementation in PATCH1 of
> > > link:
> > > https://lore.kernel.org/linux-mm/cover.1710829750.git.raghavendra.kt@amd.com/
> > > 
> > > get some benefit. I did not see good usecase at that point. but worth a
> > > try to see if it improves performance in your case.
> > 
> > PATCH1 extends the array size of pids_active[] from 2 to 4, so the
> > history info can be kept for a longer time, but it is possible that the
> > scanning could still be missed after the task sleeps for a long enough
> > time. It seems that the N could be task-specific rather than a fixed
> > value.
> > 
> > Anyway, we will test PATCH1 to see if it helps in our benchmark and
> > come back later.

Sorry for my late reply. Our test machine was not available temporarily
for the last few days, and I finished the testing just now. After
applying PATCH1, the average level of remote memory access doesn't have
significant change in our benchmark (SPEC CPU omnetpp_r test), and we
can still see a few cores having ~500MB/s remote memory access for ~20
seconds, which may indicate some potential missed vma scans.

It seems that extending the pids_active size to 4 doesn't have
significant impact on this specific benchmark we used, but it may
help on other cases. Chenyu has tested PATCH1 with autonuma benchmark,
and replied to that thread with detailed data [1].

[1] https://lore.kernel.org/all/ZnrSIGKBpyeTmSJt@chenyu5-mobl2/

> > > > solution 2 is to compare the diff between mm->numa_scan_seq and
> > > > vma->numab_state->prev_scan_seq. If the diff has exceeded the threshold,
> > > > scan the vma.
> > > > 
> > > > solution 2 can be used to cover process-based workload(SPECcpu eg). The
> > > > reason is: There is only 1 thread within this process. If this process
> > > > access the vma at the beginning, then sleeps for a long time, the
> > > > pid_active array will be cleared. When this process is woken up, it will
> > > > never get a chance to set prot_none anymore. Because only the first 2
> > > > times of access is regarded as accessed:
> > > > (current->mm->numa_scan_seq) - vma->numab_state->start_scan_seq) < 2
> > > > and no other threads can help set this prot_none.
> > > > 
> > > 
> > > To Summarize: (just thinking loud on the problem IIUC)
> > > The issue overall is, we are not handling the scanning of a single
> > > (fewer) thread task that sleeps or inactive) some time adequately.
> > > 
> > > one solution is to unconditionally return true (in a way inversely
> > > proportional to number of threads in a task).
> > > 
> > > But,
> > > 1. Does it regress single (or fewer) threaded tasks which does
> > >   not really need aggressive scanning.
> > 
> > We haven't observed such regression so far as we don't have a suitable
> > workload that can well represent the scenario of "tasks that do not
> > need aggressive scanning."
> > 
> > In theory, it will bring extra scanning overhead, but the penalty of
> > missing the necessary scanning for the tasks that do need to be migrated
> > may be more serious since it can result in long time remote node memory
> > access. This is more likely a trade-off between the scanning cost and
> > coverage.
> > 
> > > 2. Are we able to address the issue for multi threaded tasks which
> > > show similar kind of pattern (viz., inactive for some duration regularly).
> > 
> > Theoretically it should do. If multi-threads access different VMAs of
> > their own, like autonuma bench THREAD_LOCAL, each thread can only help
> > itself to do the pg_none tagging. We have observed slight performance
> > improvement with this patch applied when running autonuma bench
> > THREAD_LOCAL.
> > 
> > In common use cases, tasks with multiple threads are likely to share
> > some vmas, so there could be higher chance that other threads help tag
> > the pg_none for the current thread, thus we can tolerate more vma skip,
> > and vice versa.
> > 
> 
> Agree with above points, meanwhile when I ran my normal mmtest,
> Results:
> 
> base = 6.10-rc4
> 
> autonumabench NUMA01
>                            base                  patched
> Amean     syst-NUMA01      194.05 (   0.00%)      165.11 *  14.92%*
> Amean     elsp-NUMA01      324.86 (   0.00%)      315.58 *   2.86%*
> 
> Duration User      380345.36   368252.04
> Duration System      1358.89     1156.23
> Duration Elapsed     2277.45     2213.25
> 
> 
> autonumabench NUMA02
> 
> Amean     syst-NUMA02        1.12 (   0.00%)        1.09 *   2.93%*
> Amean     elsp-NUMA02        3.50 (   0.00%)        3.56 *  -1.84%*
> 
> Duration User        1513.23     1575.48
> Duration System         8.33        8.13
> Duration Elapsed       28.59       29.71
> 
> kernbench
> Amean     user-256    22935.42 (   0.00%)    22535.19 *   1.75%*
> Amean     syst-256     7284.16 (   0.00%)     7608.72 *  -4.46%*
> Amean     elsp-256      159.01 (   0.00%)      158.17 *   0.53%*
> 
> Duration User       68816.41    67615.74
> Duration System     21873.94    22848.08
> Duration Elapsed      506.66      504.55
> 
> ( I have not done bench-marking with smaller threads, some larger
> workload run is TBD)
> 
> But overall results look promising.
> Also on the plus side we have a very simple patch, So
> 
> If PeterZ/Mel are okay with using nr_thread notion,
> please feel free to add.
> 
> Reviewed-and-Tested-by: Raghavendra K T <raghavendra.kt@amd.com>

Thanks a lot for reviewing and testing this patch! We will improve the
commit message and send out the formal patch soon.

Best Regards,
Yujie

