Return-Path: <linux-kernel+bounces-403163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D27F19C31D5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 12:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545EA1F21351
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 11:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92C11547E4;
	Sun, 10 Nov 2024 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pmp8SIS+"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF1E149C7A
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731239143; cv=fail; b=QZnLzifiyIfIE2xzTAi7xe4C1/wWThLi6bMCScLYXuoX6P1LVWjm355C02r1i8COyR6HMCh9cCAKQtnueKcnMHNovLBEJOrxEqLdJtWZMhKdNKwxOOiLkm4Ud9Vu+0AvH9LmUNAjHLbWJCOLmbP7WqX97x9AO9jzSjzJj2WqeHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731239143; c=relaxed/simple;
	bh=fDbUkiAAAQ7qpN26++cwqpIji3XT8SWIiMOgGw9rjXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RxdBNyFbQnh7JZNkA/9OBMEwJrWGwxcSNMGcZuny3QD9YTCSWjXiKnYgafdF8QjGpOUlFQZMGJievvg1vcgZ/pfzpkuP+7/AbAU0mYG2t2H9cm+k4fc/ULTQEPUwOAt9bjOxXO27+C/pG3HKa3QrbdWcW606KaR9VIwmRbpDE+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pmp8SIS+; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/IYdTk3xuhnnmyyURhSatkuTV0eiIiveB4Gj52R1YR7KxcDTEkPQC3Vd91Y0RWKfgwAhkMiYTYxrLVYrIKpHTfboj1CJyxySmb9AZgWEPia9p8rcgO60+cd56OJl/DzUOj9SRFGbvE3EEBLGxaEX4GzzzM3NwY7eH2JCM/FVf1vdYhI8GHpf+uLE8JmdQWTSeYqgyZ3ltvr+lC2F1W1DxRtNtFlGF26ciHdcRh9kuZvVbQNvByHxcJvG0UmEmphRZnsavzY7MoagSUsUiollrwMqIswKx/t48YskCyXOWWQ62x3ONgwhf52vt/k9zs8D0l72SE5Zs1XT3xfffoOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nc4EZy7BtbscM2EZZx+O6tVlFIYvGms+Us0l8VVnX7I=;
 b=t3d1h2f9TV5jIcEYJrmxEUcN4GmTdHFkYv/UQMWx3F7ds+EdLFbhTnQiI6uoG0v+zMyIEmfLPbu1TgnvdiH+zAES+Y+jC6dj8znRD21VVPGrSj/W/OKpHVYYcgzaW+LruZ6t3UfaqQ+V/xOjPBTVn/KWr4RMIkDCwtFCYMNh5hELfKC1Qe7ZS040P1ulD+jzcEkQivI9TvQ29Ic9Bj8ombxBl41qOoDBhk+3A8NCvFXOoZ8yTDogEhsqp2uJ2KrT7r77PdlMtGX1n8P4f8raFMqgxscHSI2o8Fo65uI2N3LeNLeHT+aUTAefprk0DAI08f4IPLHX7/MwIDuwd1Vupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nc4EZy7BtbscM2EZZx+O6tVlFIYvGms+Us0l8VVnX7I=;
 b=pmp8SIS+0BNgMablHI4GCjiEgcYdgvnZ1mK6KNBBT5k8yoOIo5RR30xAcmvqwVtMkYVhK0NgDAmXcebwjaCOA8KsoBGacSA2j6TBnZbGfB4e90DREMfntJ/DIsZkiUMucN20aXJdlo2cQ6/FM4XKIDAGemEsP27E/buCHVAFCmVTbawPCEsvYCpqQ2F1JvTNrAC1mGPYbG/QueNPXd2dIfZZvXhwBXCt/mud3CZEoU0FK2pA9w2fzzhG7TWHPk/vrubDT2/X/N3qzIregHlQAGyDS6EDJKGz69yPN3VkYOBUBOZ1pGEP20mcB6cRJQBCZUC38JlRXtbOPfBNIJeGgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by BL1PR12MB5899.namprd12.prod.outlook.com (2603:10b6:208:397::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Sun, 10 Nov
 2024 11:45:39 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8137.027; Sun, 10 Nov 2024
 11:45:38 +0000
Date: Sun, 10 Nov 2024 12:45:34 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	sched-ext@meta.com, multics69@gmail.com, me@mostlynerdless.de,
	ggherdovich@suse.com, dschatzberg@meta.com, yougmark94@gmail.com
Subject: Re: [PATCHSET sched_ext/for-6.13] sched_ext: Rename dispatch and
 consume kfuncs
Message-ID: <ZzCc3h7RN4T-NKv9@gpd3>
References: <20241109194853.580310-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109194853.580310-1-tj@kernel.org>
X-ClientProxiedBy: MI2P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|BL1PR12MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c34e22-a39b-4799-2364-08dd017d3287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yXziyMUq7OGysfWgise3bQKZrvAFAR6lTXWMXoxSlkLw21cSrSdFGNX4lFbW?=
 =?us-ascii?Q?JtBd2Svfv8IrEn9ttMpzGr6aNrKz3zEHPcw+xNDoyKkbqR5fLpLlSD/1u/wM?=
 =?us-ascii?Q?nzb6m6k17qxgebCifHqCJ/19xwQFf2factrlZxIJzqNh+nGSfzkKlTuGJ9vi?=
 =?us-ascii?Q?VSAl3T+7JSxGFtu0opVLrsKSUN6FpL/g4PVLUbJj/Shldm6I2gvw/OJUo2KW?=
 =?us-ascii?Q?VajKX/eMagK+Vxw8okMFsqiFuOIlCWH9aZKLUqHPem/+OMU4EHMRkGoutGnC?=
 =?us-ascii?Q?2KT6FUPMl4hjr7V2eKderTLQYvHA/Llag14H1M7lPQuygXq5WFdVWshH4JiX?=
 =?us-ascii?Q?n7YGYuDpffJoRgJ5s5cO59yAU+Th04VatZRH6Do8JfObs9gUEomY/TlO8Z8H?=
 =?us-ascii?Q?MbUTddgz2SMu3d4scdKCmi1Esvj1LRm2b+dKd7SRCE0h7Vw3HobBoU1pU2va?=
 =?us-ascii?Q?VVAtSvgjzgqHXmF8AoBtAg6d6pJn6CZedGLpgDxa101WK//nntZZpl8+cEnp?=
 =?us-ascii?Q?g6781fKyB1WWoFK5vwZZ+JCNcZyuJaJAHd1picv7POAEM4NwypxjEVYAwH0C?=
 =?us-ascii?Q?vSh72c6EbH7HdGX5tf6TWjLp5Fh5xLbVAF2vHdZvEGgU4EUK/ShM3K3/QvAm?=
 =?us-ascii?Q?sRky9N9mzaaEOgl9HwjBqE3eW2torByA+/XqEeuiKEMSOGtu9PjakbS9HYdN?=
 =?us-ascii?Q?LeYBpGrZLpgUeYu3t0JmgMZBM48UHEZlWfZy8lmSlBH/dMQKMQpr8rsbvrFk?=
 =?us-ascii?Q?N7PJgQ16evidweH/ms583R5wAvTV0bgnXShTHXcrPLnJK8WtNibyZAyJ/+ez?=
 =?us-ascii?Q?7HgtC45XAMM9d3bJO32O0K6Lfbs5CPJBDguvHYIafazuxopEWBs8GNeaA74E?=
 =?us-ascii?Q?xwL9DBCiAzQzHQ1JxUZXwf1hsLsX7SUYFoVhxTGcEPQFt6tlGKXi8JbHy1cK?=
 =?us-ascii?Q?m+t959iRPk+yodl038ML7mLdD2cyvT/QMPh+ZTk1skvK05fAfXamgtY3sspO?=
 =?us-ascii?Q?y2iWhdxoUyCG8CmxLT1/0Zmqyxe22q2x/n6Xv0mCJFdxTfvWK4KhqThs11Ht?=
 =?us-ascii?Q?IhMzXcGbTQ+VJluEiPTuX9NQADdBhCpFk0y7XGs1UAs8PvW8tUUl0u4Q7HUw?=
 =?us-ascii?Q?hTN8V2N9gaXVUUN1YxF2dc/x2sQdXWghPsCLU9MHdTMCUGT1BEUG32Jfstze?=
 =?us-ascii?Q?dk2QvGSPFrrirVlLCrxBH+9lytc0ZUaSv6I2zss9PckFhwl2LWYwOEk0IuZ2?=
 =?us-ascii?Q?T9V5HU90xMjfAQHpuM2dqjgcwIX+sEka7zMckisqmcaS6jGMC4hxgTcAj4ZU?=
 =?us-ascii?Q?MnC5mNhC8el51S9ia5x4naT0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ojOzi9yKe7+pgGf/jcwip9Lux9UnQuhNuc09se3TMIJ/8o6F09dqPJm2BvAp?=
 =?us-ascii?Q?MgD/wD4Zg46y7QfOjUOA++rQ46WqfIZ75cN0JArsmJccGZAfnQSBuTMQ2elf?=
 =?us-ascii?Q?1b6kieJBIVbBnHmhluuF4rxkxBo3uQkEiEE5uVkBtOxCqFp1anfdswPEZ/KY?=
 =?us-ascii?Q?XZNpCeIuS9Z63Lqn1RtwBbuHNI0oskn589NkcUYtKY6IyZ39wBcTNFQ5wYpi?=
 =?us-ascii?Q?rs9ox5Lc5FwX7G/V9oaOdjyrKgQDR8tyzJ3O0XzfnEYDgrSzACmjHPVa7qXx?=
 =?us-ascii?Q?zhUVA5gwdHVZFgAQ9nh5yeI5+CMBjINYDVbes702KTHh4D8+APQrmejK+yOI?=
 =?us-ascii?Q?5VEaIxEoikI6bFpKoAG4gwUi8c5tmD2GjNLKWmm67PupepnbdU7699lW5WZi?=
 =?us-ascii?Q?nuNBpQRY9nfTLnlHWsLkAMf5iKrU+5pt8fZIndO49LvxalyMGhmGOVx5/5zL?=
 =?us-ascii?Q?jjvTotoxPstS5H70MJzvYUtbDBcsAllZdZt47APflVCAkojmimTGA0UtkCNv?=
 =?us-ascii?Q?5wbOJNexJGEg50/wv013duDi8OVAJnG/jNC5ndy3eDM6nujAt8vE4iQgGqPl?=
 =?us-ascii?Q?cKfj7W9V8kOb6fhhPxbkMJol/A6GveQmWeXDVAuLHIILlZgqa3SjhCMygmUJ?=
 =?us-ascii?Q?LIAUZ4VGpIX9vgEw5kwUVB2Ri0p/gXYcUglzIXm4pk75gyiFi3DiUYjhAO0i?=
 =?us-ascii?Q?KN2GJW7LTD/MfI8q5f0AOOtxDq0sz3BUyO42PiQ1vzdyL/1KffmiHtbQKbpb?=
 =?us-ascii?Q?PKxO4lJSqOUkQse+svxZH23A6QKX8i82E7SXYkw+OQnTwtqQdBOO7tQj/Q8E?=
 =?us-ascii?Q?15lqJKWWQcOJ1kMz9ZhWKutmzDptzO1UBh+scg5a4GxsIy/xsC77TPuWm6hP?=
 =?us-ascii?Q?AZK9wO9PBXlv09goiM20JoLzs55tX7L/7SJTcKWK6YgAiKkKunPRl/Zt0vwG?=
 =?us-ascii?Q?mO+dMzWpla3JQ4sJJ4zQ5MQ6hAEhbZLVpjQN8BfvUh1tIHdW5ONyxoz/SXiH?=
 =?us-ascii?Q?q+eATMxFH8znyKeUokjoF24e30yczJirkLMetTac29P2e1tjdyfh+KZ5o1mK?=
 =?us-ascii?Q?1kSZCR7iPg/OAiHEnVLMcFFlZEMXQHkfXf+Y1pAd8WMTLqSZ0WSLuGlYn3wQ?=
 =?us-ascii?Q?ohIqjJNMPntn0nYi5QZXudUvedSamu9VEdMLZloXsOLAH9RrecT63mESwWx3?=
 =?us-ascii?Q?Nq9ZJOR4V44ba0PXHxUrprwTTc2CtHD2Pa3R0uN0er5U7n6rw7f/O8eOPitU?=
 =?us-ascii?Q?AZwSjxxIi1MxBq713EuVHQYfL5L5RS3XNcsaXaMGMQRUrpXk43bkMiCDlQJr?=
 =?us-ascii?Q?1T/ToF+8ivC41Gpkt6B9IhqlBo7ET8L5fLd5Pv+0QbJbAHKAuscwSQB7pGGb?=
 =?us-ascii?Q?f5FPPXQaITby9D+F3BG1Ic2cPy4wectCl+g7ole7ge9IGQ80nwcz89gqYj4J?=
 =?us-ascii?Q?oNavrVEO2fVXt0sQzBCcV1Zxj7IwmBqLUpue5eJ3tYJas6tHvwHjrf9DtvsM?=
 =?us-ascii?Q?CDj85IZcbwAjbCEjxPOpXFbr5ibKT/5xZUeSn539aUoJgOOrZj7Gn09/vzAb?=
 =?us-ascii?Q?o2qQiVLtG0WF/YOGoBiNvjGqA+iQDyk3eNGWZT3v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c34e22-a39b-4799-2364-08dd017d3287
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2024 11:45:38.9276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3jLs6sa7varJVE3FlqmcmW7lmNL1izad9EhqobdZyg0NTWKE3e7VR6fYEqGfN48G3cE1UqDdRbeHF9RLhG1MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5899

Hi Tejun,

On Sat, Nov 09, 2024 at 09:48:29AM -1000, Tejun Heo wrote:
> In sched_ext API, a repeatedly reported pain point is the overuse of the
> verb "dispatch" and confusion around "consume":
> 
> - ops.dispatch()
> - scx_bpf_dispatch[_vtime]()
> - scx_bpf_consume()
> - scx_bpf_dispatch[_vtime]_from_dsq*()
> 
> This overloading of the term is historical. Originally, there were only
> built-in DSQs and moving a task into a DSQ always dispatched it for
> execution. Using the verb "dispatch" for the kfuncs to move tasks into these
> DSQs made sense.
> 
> Later, user DSQs were added and scx_bpf_dispatch[_vtime]() updated to be
> able to insert tasks into any DSQ. The only allowed DSQ to DSQ transfer was
> from a non-local DSQ to a local DSQ and this operation was named "consume".
> This was already confusing as a task could be dispatched to a user DSQ from
> ops.enqueue() and then the DSQ would have to be consumed in ops.dispatch().
> Later addition of scx_bpf_dispatch_from_dsq*() made the confusion even worse
> as "dispatch" in this context meant moving a task to an arbitrary DSQ from a
> user DSQ.
> 
> Clean up the API with the following renames:
> 
> 1. scx_bpf_dispatch[_vtime]()           -> scx_bpf_dsq_insert[_vtime]()
> 2. scx_bpf_consume()                    -> scx_bpf_dsq_move_to_local()
> 3. scx_bpf_dispatch[_vtime]_from_dsq*() -> scx_bpf_dsq_move[_vtime]*()
> 
> This patchset is on top of sched_ext/for-6.13 72b85bf6a7f6 ("sched_ext:
> scx_bpf_dispatch_from_dsq_set_*() are allowed from unlocked context") and
> contains the following patches:
> 
>  0001-sched_ext-Rename-scx_bpf_dispatch-_vtime-to-scx_bpf_.patch
>  0002-sched_ext-Rename-scx_bpf_consume-to-scx_bpf_dsq_move.patch
>  0003-sched_ext-Rename-scx_bpf_dispatch-_vtime-_from_dsq-s.patch
> 
> and is always available in the following git branch:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-api-rename-dispatch
> 
> diffstat follows. Thanks.
> 
>  kernel/sched/ext.c                       |  238 +++++++++++++++++++++++++++++++++--------------------
>  tools/sched_ext/include/scx/common.bpf.h |   18 ++--
>  tools/sched_ext/include/scx/compat.bpf.h |  117 +++++++++++++++++++++++---
>  tools/sched_ext/scx_central.bpf.c        |   14 +--
>  tools/sched_ext/scx_flatcg.bpf.c         |   20 ++--
>  tools/sched_ext/scx_qmap.bpf.c           |   36 ++++----
>  tools/sched_ext/scx_simple.bpf.c         |   16 +--
>  7 files changed, 308 insertions(+), 151 deletions(-)

Overall it looks good to me, we should probably update also
Documentation/scheduler/sched-ext.rst.

Thanks,
-Andrea

