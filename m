Return-Path: <linux-kernel+bounces-429633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D2E9E1ED5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD411163F43
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDD51F4261;
	Tue,  3 Dec 2024 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fmQV/RoD"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAFA1E868
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235390; cv=fail; b=UF0MgGtOcoqVQB5SzDTlOBhUaGBr4ilCKFc8PaJ+KKagI3xJoXKi31kKWWlh+xoKi3rK0hLwyqA10V5iQwDsIwFISSwcq3o3Vixjgfw6+4I3BUayBsDC/ibM09I/4DmhLEUpQ6NqrPDkg6cutc4JmfID7pVb3AqORyzBR5zt8O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235390; c=relaxed/simple;
	bh=ze3g/cBXJJswrduI4+vWvVGOsPiyaBZwXdjTBTb3L5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ka3qhEMX1k1akR47oUSqjyBKhFsPlvXoRZOdLSAQ4UG74vPA6Nf7VpGWI+OziUsJvktQgHyKPjzO5+Vz8aDFIO8QcLWNwCVHIPvuX+VCmN95nO0S7dHVANp7EATi3+gTsmuedAmiBC/sII5MmpDjbbPUQ+E1+MZm4FtJLivp7SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fmQV/RoD; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnkgmIbsXUV+LGowshoj2nlTpZXf6QxrUNOSspJcS6YIsi+GcTjLwRhA7gJWx0uVGtToXE5KM5kaF/I+t/W38uQbXZIxSSWcVi95i+51Q+yftnGHFwgxnE1SjByDOAN2k0mWuY4A8yPCd3CI0SR6jOTXte8hAoqmkJ+dxIdi2P7VpoUl9Xnzjo/eFC3A9ZO2Q4YrBxpbaoZ98mhOnRuM0dmVMjzOGdjdavKxqGsmYtXkGFmcI0BiQ0vwSBi6n0ts3pCannzKpE6EcFfogfEpFqvBSBUSihkkXUDvfkyLX8l9UoxRgKMcGia8KxsipKth5UQ/r/5uZflTa39PJSK60A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQNbbKM+DIhHfNCmHf92Bzd279Gy6w0l7Tz2nOBg3D8=;
 b=uiu46PnpBQuXj9z970RW/qoCTUKq0J5M9N7XsSjAG9aAWq0UFLXROp7IRgrTuyAR08WK3oLIkoY81AuyZkVUq2StOnRR9uoWgtmrBnc4JzsaZD3y6bYTifCM5O7gdjgjUvC0hZhgT63ms9Hhk26YGlegrN97CDnVa/hSNEQkEpaIXTzSNAWwO+OZgR6cOSU+D+xCRFQvIuNMYhAmFrTQrniM0w2/KKQ5qEnKkNpTCgOG7eT9Lh7GmYgbdV2uOfJoV9Twr9xT/ePq/ZlLWoGnXaXGh89P/ESncr53EQQEYUl6cUkBkJq5gejMFtXVoxUTk1keFwWSCKnn8WSO55QvyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQNbbKM+DIhHfNCmHf92Bzd279Gy6w0l7Tz2nOBg3D8=;
 b=fmQV/RoDHno3xydu2ZSDMedNpSKsBZdjUhRKSOLGO4lQ+0XmD795Jn9APOqkHyXTFOuq55sc7NJztx5FzDmRvscJMz2CC4gz5fHh7rWWHvKNGugi+iYIth54MCG6NsQ0DzZpN7e8amNEsVeBXa5s9Yd/L57abSfVy1P00nQMsa/Bfmg4Ep8+uQ031dJ8d9ZVNAZ7yUlLXK/JOBTTHRw+/WRKtLD58yU26lxtSb6JRUawMMremGAhijwcaAtD6qxNka18JtRtjEUpKq5K9UO4TFDzi0CN0dIFWF2CAhNoWZljBsJOoQQMizVNMqH9hBE+PPsRcIKBTix+wTJEDsu1/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 14:16:22 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:16:22 +0000
Date: Tue, 3 Dec 2024 15:16:17 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Introduce per-NUMA idle cpumasks
Message-ID: <Z08SsR2BVuYkoD7N@gpd3>
References: <20241129181230.69213-1-arighi@nvidia.com>
 <20241129181230.69213-3-arighi@nvidia.com>
 <Z0oYTbacS0lnO-jS@yury-ThinkPad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0oYTbacS0lnO-jS@yury-ThinkPad>
X-ClientProxiedBy: FR2P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: c77a7fc1-35da-42bf-4756-08dd13a51054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/RBOFwgRAOHfSlLi1iwnRyImhllssQFL1zJU0tHUMCEJ0TXO1qBacTq+cp2V?=
 =?us-ascii?Q?7P+dz6cVClHJv4fDucy3A5SmigRAYOaTMzkx3HjRcj7vpW4uIDWYm9pFpuGW?=
 =?us-ascii?Q?QDS1ss/DvkaJdmx5uzW7zljCFdq+MvEe4IENG4oChHpmiqPd4M5EzHaF2bFH?=
 =?us-ascii?Q?Id03gL/gfA2+YJxyEobeN9HHWczQkO1GKAdKi1aVJJUR8pdz3LaKkfmUEYOM?=
 =?us-ascii?Q?6TL5CPisPPNYRco3DFXF9u9X1zzQ5xK882nJ7wescplKC1OwBIjJDSFCs3dK?=
 =?us-ascii?Q?pNsbKD3oy7GLs5r0MafDYIGsprtToZr52lY2/vM1CEC5HXuyoWstTLnMV3qE?=
 =?us-ascii?Q?G82zjiwMV3+cuuPjV0qTu1qhmMEE8VgqgaNxB5Ej6UEJLl3bl3PzUSg4JYh1?=
 =?us-ascii?Q?fUtpaI8Z0I0vm6tCaZ2GeKroYBBzji7Wvtfj5g/xqTA9zUEyynZgTtknE9+5?=
 =?us-ascii?Q?0MzbNrOjJbSAvt5kp7HPHvaeo7mzTtGWeAiaQQbdJeKhUbPTqQtgK7CLKDUU?=
 =?us-ascii?Q?VnRZt/Q1o3TbHkkhAL3H1L6ito0bM/kilFR4aewrbG6wKqVbnnBc3SC7HV/B?=
 =?us-ascii?Q?48ddXXd/vYqa948tvwgpQz6kUcc8TJEuJfpoRB4w9lZ/zSMGiraHMM1neLJW?=
 =?us-ascii?Q?IVMLMyw2F9QIUm48FYw9IE4FjS21Pcs+6MgQEQEeHzYMo4X+TP3kTCKYiQdq?=
 =?us-ascii?Q?uyIVBbVRApV0/on4tNkplNajJ8y2FFoldJ0lcFMvRj2Ap8skWagElObz527u?=
 =?us-ascii?Q?kdVCZqYD1grhum+qcVCCfluuEuyRQpihj0wyNDqdMqA8endnhdDNLiZKJrpC?=
 =?us-ascii?Q?wxcMsinYxjZYKmxLHQ9d1+oLjV5ENxKpSeFjqYzmaqYFgM0w/rlKhnZLorM4?=
 =?us-ascii?Q?n4FwpwWS1O1p5urywmAO5PU6QltaUqeeIu864eP9PhnU0/vzqbTG4wOiYrS1?=
 =?us-ascii?Q?yKtKtFPccxyej2go/okrZdNOHxAt0JLhbkocnNVETejIdc2KYS55+n70RCI7?=
 =?us-ascii?Q?fhuxC1kI3aEcQKH07mwL+075V6v3B2zVUkoTCPxdyk+6q+bfnddpH7CmWcmz?=
 =?us-ascii?Q?JXqnh3ko3xJ+AvHXIiwD4fqe5QNBMTuemk1iQ1cnajBobPVS6u2/iya/EylC?=
 =?us-ascii?Q?7SuOUWBT8cl7u/28p2O2Fp00NYOVfIxftYgJYAbqLzPmvHNb2Q36qWMH6OrS?=
 =?us-ascii?Q?U+rRvI0SzG6GDcor54+bgwJ3ah3qbIaYdzWD+T9eC2SFpB6cJQZiHnf4c4ci?=
 =?us-ascii?Q?cN61viCWe8KJ1uKfsfHANuxxt/LJ3y8soKqn6tbccw2Y6iYRtNAgkU98ztYG?=
 =?us-ascii?Q?+9KczaZHG7vDsPdV5nDRCOhzn+TgfIX3hGI3v6XQzwqk4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eZRbwajI1YCyTU+vOhD0fMPy2AvP+BGKgV1VvmI3LqrA9yhsBzlzJvyGIF8j?=
 =?us-ascii?Q?JB5TVvT/WksLGtMimij4S25TEKMZ3mpZowyQ8k0FJRR6tZS4gAqipnQs2sGx?=
 =?us-ascii?Q?Ql8w2wo2/1wfDcQY6qhRlrSXJP7AHCgmJGPFgZKDu2A8mD7TjSNjNqCcRzmM?=
 =?us-ascii?Q?FWTFa4bRwCQcws6cZrcxGAvqMtWhqAvmHrTDjLuNnYf7vHBM0SBFQ34vsqA9?=
 =?us-ascii?Q?QIkfz7Fx3Cwj11ilS/zxwivtzoC1meazJZqnHBdoePVVUjKuoepTNDrRmhLR?=
 =?us-ascii?Q?BUIBsFbkEziWpYD+uI6yHKzaS0TiDRkrK9ICj5iv/g+H2438IIxU22GcLT3z?=
 =?us-ascii?Q?+qJlc/ls/uttvNjLfOF6NOuarEOrDUUdt+eGf/x1g4zb4mJW+AugcqI84AjX?=
 =?us-ascii?Q?QYX2H8Ck6LfuatzlciFQMbA4N9y4lnD3yEuI5/s2eX8lcQs4xySuGjX44urd?=
 =?us-ascii?Q?GrncisTJU8gzNC3chByvzptHInpUJDVJEfDNR266HWo2jQDXORwydyGnFsV8?=
 =?us-ascii?Q?AxqJ/umbJDe+AdZzRdc2klO/YgmEQWcqxidI3tGdrIIjCv14PxOFwkrSW+Mi?=
 =?us-ascii?Q?ilNVWbxsnNY8Fc3U+Crn+YGKVD/IxO11O8VvB4LyYVmHfFFQa3aiQCBslAxS?=
 =?us-ascii?Q?OYYO2E2z78eptEcbJm2Ib0Bo7eI2lg2lo0SfqdFPG/6ZGwZeValnJEeGURb/?=
 =?us-ascii?Q?AL8gO1DbWdjEzqAVrKd9mMCK9Zm22dn0N4vcvad5hL9BzgGzwjXAzhaqgU9/?=
 =?us-ascii?Q?TdGSfA8dLOSOPOMhtD3DMcUhjyBF/yz7aC6b3DS+QX2d+dmsp1nE9KYzcY0Q?=
 =?us-ascii?Q?UJp+db7ECLR9sRA8nWoC3iBy9GNXxQGJFzUR+CjlybZjqBbEOZVTiwmUBf20?=
 =?us-ascii?Q?269vSs2IHP0I4mjYn3feFAKqGrVpR0VT9SEUiDdbT8nVfWSz3k3wY/Iy97am?=
 =?us-ascii?Q?Soh4+jUAthR1BGHoWL6+/HmHaHXGdqvK5joq+AjTRzt/eAnMNnpvKTMbobjS?=
 =?us-ascii?Q?Jlw2HHKoHAaJlJCv7rODcZ10EpEMlCCPRiBCjc/uo+daIj2ohbFPOP+an1Si?=
 =?us-ascii?Q?SqMooLMY3EEX3XBosZVPY/Uyejao7KEELOlcz6nPhw8nH1dRSjKIRDriTN+O?=
 =?us-ascii?Q?zkypxJX1FPovU/e0pRxGw4FaEPoaOLcmESQtkPi5rFVYht8K+v+iOKnSQ/uR?=
 =?us-ascii?Q?zvZXqH0qoIl1wzUOqx2PWEtML0RxQDP3cnB+viC+3OrTS06lkOtkdpmy6EUH?=
 =?us-ascii?Q?PuqW0YnVwC9MUmde2av9vpEPXqXYLNj2569Z8XcPRe7h+5zc6CcHp9z+VHaJ?=
 =?us-ascii?Q?yBztPh8R6sTodBUrjwWT4J26uVuQtVziJnElV4W1gr2KtIap+ed2JmGyn2uz?=
 =?us-ascii?Q?MN3DaiOh/N+A0xyVqzhIbMmUP590i3TSkD4N5w64S2BjrfRq+yPor7n0BdVQ?=
 =?us-ascii?Q?YWPjxw2SAWoHolMq6w15g1N6kx5fVZ2VNVEeEfYtozIKTFrItqR26FctUAYa?=
 =?us-ascii?Q?8TxtMLUS+cFoGP8uRfaEXsncKpcFqdxeHSvEHeUi5srga7EpaLPhUHeu23ZK?=
 =?us-ascii?Q?I3mPYTR8RF937g7zS2nr8qtaxyh32ibQwiHMqHNO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77a7fc1-35da-42bf-4756-08dd13a51054
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:16:22.2548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByDDp7axm2zt22gBBiEOgTLy1+q7pUkyZEdrUIljyCUAdK3D0rowaZVtej3cQWuEYzOoW9RBWVYBlhqLSQIXHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427

Hi Yuri,

On Fri, Nov 29, 2024 at 11:38:53AM -0800, Yury Norov wrote:
...
> > @@ -3156,39 +3186,48 @@ static bool test_and_clear_cpu_idle(int cpu)
> >  	 */
> >  	if (sched_smt_active()) {
> >  		const struct cpumask *smt = cpu_smt_mask(cpu);
> > +		struct cpumask *idle_smt = get_idle_smtmask(cpu);
> >  
> >  		/*
> >  		 * If offline, @cpu is not its own sibling and
> >  		 * scx_pick_idle_cpu() can get caught in an infinite loop as
> > -		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
> > -		 * is eventually cleared.
> > +		 * @cpu is never cleared from the idle SMT mask. Ensure that
> > +		 * @cpu is eventually cleared.
> >  		 */
> > -		if (cpumask_intersects(smt, idle_masks.smt))
> > -			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
> > -		else if (cpumask_test_cpu(cpu, idle_masks.smt))
> > -			__cpumask_clear_cpu(cpu, idle_masks.smt);
> > +		cpumask_andnot(idle_smt, idle_smt, smt);
> > +		__cpumask_clear_cpu(cpu, idle_smt);
> >  	}

these cpumask_intersects() and cpumask_test_cpu() seem to help instead.

I think the reason is that they can help reduce some memory writes and
therefore alleviate cache coherence pressure. So, even though we could
logically remove them, they seem to offer practical benefits. I'll
re-introduce them and add a comment to clarify this in the next patch
set version.

-Andrea

