Return-Path: <linux-kernel+bounces-533188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2A0A4569C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A0C3A88F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2AA26A1D7;
	Wed, 26 Feb 2025 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EsdaXhfv"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B233997
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740554824; cv=fail; b=aazE/BvVfs+z329/Ky3t4I0CLPO1Xi4NqGgJgZvVIaoWO6T8nBYl0elqyR22W3+v0lKbyBC1WydS5jifX1jyvGs5JWxPXr2XCLIdktKBnRdFIwcLyHwMjQCfH09yH5Es5vV7Uwh4wZGr6zZD7rzqPDL7RphOiyEzgmeWE1xNdwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740554824; c=relaxed/simple;
	bh=3jS4SrKGN6yDaRr+KY+iYbtu0UF7B123dF1m/l3k6V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NY/yRpxxMIuY6TESjyg9c9tyuWvZixGi6iQUD8yw/nmSW+5TbUexbkAuXjCjoWrWt9Hz6IPsBRXlCCSNV0tzYCu0w959zrFD7qKSPDCpTgvg9zKDVTQ0jJZNNhspeoSljX8Wvg9hLGusSJtRqlFMF0CYMcpbaYsSmO9966V3Xok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EsdaXhfv; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COqqFOsQokQnM6JsE91yHq/2GUj1NJqseS7U2NSYXyDmfEkuhAebz7/gvjekIkYDTB/z0sI2pfVeIp76RpNiGUrv88KJRIZ1NvM74ApSTAIVGDQZIT20bOgJoHk7VM+puj4nFeewpj16zbC9rVmxyaEl5o3l+dC6VKdOls01ozvGawAhexZo1sw5/LOHk6OFBytzMWgYtlcvZyp7mnmOtBSKfYi6xl3kVIsFOgDgrp4KD0PgiZhe0oBXxN8zXPRI1sXdZadp7jvfr8TqB80ZA8W/KAVuH7252QFqb3POLRItuLXLfxB+mw+9h9v/BOnUhBGttG50rQLeWbs4tBoK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTHM9ndcKr5OgKWlXWelnILO3qpcpESRiUUvSCUAuSw=;
 b=OkK3BbC0Livv+h6WKwRb4Ld6Z8nOsRRLYMDUNWzhrVaLXqiZGB5tR/eES74/HgBftYNvJEqUlzWnFQ53J/y0ueN2R0wIqBWDqasNKK7iC9BM/Cf/IhSLFpjyXEKKE4CU205Jlq5yF6zPSWJJI/x/vRg/MoDyqyH87QkvuqQCSMKrwr45GfJE1bR0GevQm7kTUv3WXXTg4qCn1piLqiyXCdk5xJ0gNLuPi5dViOKNe6t2Z6lpNjJGY9vppnwvanl7aEpLBqkBIcenuqiAUa3cPqjiwqxJnajnNKMud4GvegFwsEGfUOSQQogg9lczA+96gyhTiaSc3zuJOK6kSOvrJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTHM9ndcKr5OgKWlXWelnILO3qpcpESRiUUvSCUAuSw=;
 b=EsdaXhfvOlEshO8nnl9+N2NwIXITwZDifuAeSkOVOH3vHbEx6xdM2sOYnM8Lo65At9t/o6cWNwxGMOW2Gk1qR3b3ehf+HLL+V9fDHTlHRYB9vRAezAkhHdlg9V/E+B4iMsRuzay/O6ytryX64O0SYzJDw6jhFNDMPxIg7rIbSW/h8VcHbJZVjVjSGcav90nt/KbkK5CQvapg/2vMSNSM1wBBy4VDliNbdwpJ/Mj2PvrgnzjgAu+CN5LtJ8MTs6wajXSJjFPlfFwjxwhyf02Ieo2W1earqQ0q7ECpe2RhdTdIAIWUyVVd3HlOVn9rWr/GwJqfnX+h8JOZi779keamKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 07:26:59 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 07:26:59 +0000
Date: Wed, 26 Feb 2025 08:26:55 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Qais Yousef <qyousef@layalina.io>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Laight <david.laight.linux@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Kconfig.hz: Change default HZ to 1000
Message-ID: <Z77CP01ZYdZ9rcZN@gpd3>
References: <20250226000810.459547-1-qyousef@layalina.io>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226000810.459547-1-qyousef@layalina.io>
X-ClientProxiedBy: LO4P123CA0192.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::17) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be290e0-6d9f-4dbf-4c19-08dd5636f4a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NM7ptlfF9jQREpytWopNWWLIRQOJti4WzJXfoitWrX9wJ//jNVAZ3J+ne0XW?=
 =?us-ascii?Q?s/T5LfsbiIKpZvzKYt27DpiamIfAvbSOgGPaOunlU3ya6yZKtGxU8F+6zMsU?=
 =?us-ascii?Q?hP7lZ01JWoLvKpYytMTcG456GjSBEzmVKPEqrvzUCEHu1Ol7WVZYtz/Cq0Pa?=
 =?us-ascii?Q?BX6VGCFsN5/XjiMERp3VfQTa3qA7t6RO5jG/JMazk6RAK3fw0S1M6XFgFM//?=
 =?us-ascii?Q?ydEz21ZCxoXOWPNTblrhrsOeTn1pZQE3n4KGVq9uvAFda7tmdIgve3oC3W28?=
 =?us-ascii?Q?l7fV81f9XyMtV0ZMvdgwNyWbBl9SyX8ksOMMiqHn6PCEjVdFZqcGdl1PcmP5?=
 =?us-ascii?Q?P//pP5TJWJnZzHeiALEOvhGDD3UF0ktOPLf1RwBFec441H/qO8/npq/+AcFG?=
 =?us-ascii?Q?eVFN2l2SNL99cU+yyo00WJlDmVz0rvmJe2lLMKBQBzKMibeC/BZmhNtzPQ6D?=
 =?us-ascii?Q?hAlvqrXL9JKTf8mgyRsQ/cx9wGxOnbCH65aG02Z8+PCaJGL5Zbg1OmXk0f5d?=
 =?us-ascii?Q?T50CRL5GBqc+HKOWBr0Iy5ALtVEv0J0yabebWLPyeywvgFubXU07Pu+ovyu7?=
 =?us-ascii?Q?wiJU05JT/DbF+w8gTkNWmCTw7h0K0SQv2MCuYJWbHT7tM6WrJUXoeCsw0mBz?=
 =?us-ascii?Q?+7yX9b8CKx7mD4fxnyNC+3E/PT63RGUcgSMrcWeF0kD/3xTFFFc0GqJIBzlg?=
 =?us-ascii?Q?XBx+qTFiUlgbAynzzjHRKXfgz4vsKxK9SfgUHEESHcqfBXBgfuDeF0YSOnxG?=
 =?us-ascii?Q?yJfo8OZ2fhUL21IZp8wXu0J1eiqMoOevRcuqysXrtybIJfGfe+sycynf4S3X?=
 =?us-ascii?Q?URTy0ktFvIZjcBQDOczmznfuyLaTnkVGYlZfyiUUtujRYLY+dQdcKtr5qIAL?=
 =?us-ascii?Q?i2MPsGs0qEHyUh0CFNrx1RRVmKPY9gGG6fLzMLYBJ88bNMoH/U84GNqgwxzA?=
 =?us-ascii?Q?OaDSMan1czS60vZk/e1rm6fk2JiH6m5WVP7ZJ8JoSNv+ia9NCzcH2YwM5tc3?=
 =?us-ascii?Q?ayYe8NDstMBeVRYXJmH/ZN1tfRFzeg7YsvZiRYwWY3FK0zP8ie2OStOTVTO+?=
 =?us-ascii?Q?vwPYsK8slyyaQNp1yWxL7uXiyMCv2paQOkfxR+y/L+NnkuEfzxdGrFKlngnw?=
 =?us-ascii?Q?BDCbfgR405Dn2miAhnueCAuDq/7oPAjpUg9/XsONuUmUuR+rbteSqv/Pi2y4?=
 =?us-ascii?Q?v5QXXFV+2Pe3Zd0SxJ0mUgC1Mcahkqcj8qKbl39Mx+0R8g+N+/f/SmOCM7w5?=
 =?us-ascii?Q?RIpPju5+7bXAuvLM/+4fn+oCBwqeN/mZ1kMNYQSZ9BNbxJXuxsSiZy8KNrxc?=
 =?us-ascii?Q?OKo8njxHORJ+dp6fV42NQKvly7sPNVRHuzVR7kqnobJBCpN+4Grr/ji/8BuB?=
 =?us-ascii?Q?2FdlFh5Dj4Su7df3uHJ/IB7QeHSh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q8ed+TPX0X5qtO2W1E1iyLpD9ZEjEUSoSlfp2L4NTb8+/mQGl3q7YqzXaUFN?=
 =?us-ascii?Q?w8s3TTANhcue6hFMDkGW5sIT5ShR2sU7ItUU6iCZyTnIN3/+KLEqNHrBEzsh?=
 =?us-ascii?Q?GGGg/K+83gUIi9x/8F1WQ9BNzbG+54EZeat7ded76TkaxyLHRtZ48tucUjrX?=
 =?us-ascii?Q?Dj+rAtGDqpedKl6xsHweoq4adjbQBiB//HAJQQFxL0R1KtVhJtqGLZB86HzC?=
 =?us-ascii?Q?5gnnLXfgjHYQFq1KGvbDghxh31k7PhJMMLbbigLaQZZ95A8LbHLgLQj6SHNN?=
 =?us-ascii?Q?adNWe+mi40+H5EVNfaLtN1HyUtcwByMgqX00J9Y38HvN3CeZW/yq5X3vpjab?=
 =?us-ascii?Q?3BH6Kmxeu046m6JzkyY3uOYPoDe1UIKN1RhU85K7EA/lKFSehbLQoy5ekSbH?=
 =?us-ascii?Q?4f7nAeqYXxR4BNLoxzSnpZ72244eHoiWza77o5hfS3P1j+QSEXlA4PX7g1Ok?=
 =?us-ascii?Q?iu3KbeJb/QT4PRYdhP0HS9YXMRngPpE9xe9YsAOd9AroPZgjSK/fh98vxoAL?=
 =?us-ascii?Q?00sKUX5gVGb986wN6gqPWBN6Cl9lkKU9Hte9PPI9mIlL1BuqAydDVpL6sz+L?=
 =?us-ascii?Q?0XVHOqPgVVYunXMDuR9h4Hjz6sjHA1csqNTnJVMaa+Q4Lx3hgiSNak4Y5mMZ?=
 =?us-ascii?Q?35XLLkmrt90LikZIzv/Ret6EwCC64RcvA4HaY5ehMtg36efGq5igyUTzpYwN?=
 =?us-ascii?Q?gajZsi4WpkZbrHy+qUziv6hr6KoYD+kdKR1x4Y9B0XfPf1qCQrvg5J1w4mQA?=
 =?us-ascii?Q?peYznKwvGGsUOm0Wngu3iCaZdMeQJR9AHh/b/Tg1SWG/Z6JS5rPwsv+2qyL3?=
 =?us-ascii?Q?ypQ1U4++cVvElPqMFMrQ+QpLj0/IVTIOhnLcl7j9TJy9A86lbiPCI84Txpzy?=
 =?us-ascii?Q?YsPBCvRrbcytHj3GEeI0olTwsQZDHmqKpNoJsnhtCWVB4m1y5j5bN+gHOE57?=
 =?us-ascii?Q?XF6fgAUgX70T9+t1x0SUtvnOCzgvUNbxaqc4v/BwtMLcdt3sySDlU0qzxXly?=
 =?us-ascii?Q?3GpHVL2mRhEvIRdpk1TAtYOutKaANkxDW7K4dvHF7MxRPcBzSnRVlNcgV2rI?=
 =?us-ascii?Q?7SeddrSQtrn7QVjOdSBmcl1S85X7RmxPBYvdwlUCqP9xLyAt5katbBvQNbNE?=
 =?us-ascii?Q?XRQrVuqusj5eeFUZOhiX3MKW6gWbVT+RdeIjWNZNjkjiCZ74xnuxQwXId3bA?=
 =?us-ascii?Q?Nwm1d+9vV+AJAIw48BmfkzmN8y6AF0PPJMR+tyt6/C9tO/poBaugwPG6sJao?=
 =?us-ascii?Q?EpcZ42zKLLn4/W8VDjqf5jZcaK7+TS/UGqI8mzwhln9wZJrcrqp1qppPt1FH?=
 =?us-ascii?Q?wI8SriSBa8S298uqqJiqBWsVzuhqOtWDOkSa5cA0lZR3AVVXjdcmRjZCniBT?=
 =?us-ascii?Q?0czRzA/actC9Kxswo67h/JMAroEKe9r4e4nxoZYXSO+bNcJMMhlg0kO7TA+0?=
 =?us-ascii?Q?iF27SYqu6vjas+cikwHmWhH3fceHAztdNevxBcoAE+aWnOLsUQvEtaAaA8ZP?=
 =?us-ascii?Q?TXs6s/6pi6H7Nvg4NcKedQ80Ky/MoBSmSyOUev/wkjW6imbeTk1VlAn3QksW?=
 =?us-ascii?Q?w8kAF80AyIvFc1yvgN9L2CulRVlWwADghvsF6OoP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be290e0-6d9f-4dbf-4c19-08dd5636f4a4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 07:26:59.1005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1P9oUmogc2GQPhjvj4XGO41KuXkwx1wuaR2UyoxCd+5MRCElqmP9PbUa9hFUJAWXESYsHXVESoWVV/9gKzGZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690

On Wed, Feb 26, 2025 at 12:08:09AM +0000, Qais Yousef wrote:
> The frequency at which TICK happens is very important from scheduler
> perspective. There's a responsiveness trade-of that for interactive
> systems the current default is set too low.
> 
> Historically it was set to 250 to address throughput and power concerns.
> But these issues should no longer be true. Throughput is more sensitive
> to base_slice which can be controlled with task sched_attr::runtime. And
> current state of NOHZ and RCU_LAZY should make frequent TICKS not
> a problem from keeping CPUs at deep idle state to save power when the
> system doesn't any activities.
> 
> Joel indicated that ChromeOS has seen power gains on x86 with HZ=1000.
> Andrea has done analysis at Ubuntu [1] which confirms that power is the
> same or better on x86  with no significant impact on performance.
> Phoronix has also conducted an experiment that shows performance is
> better in a number of use cases and slightly lower in others with no
> significant power impact [2]. Testing on Android environment shows that
> UI pipeline can have 54% and 13% less missed frames at 6.67% power cost
> due to increased responsiveness of util signal as explained below.
> 
> Generally having a slow TICK frequency can lead to the following
> shortcomings in scheduler decisions:
> 
> 1. Imprecise time slice
> -----------------------
> 
> Preemption checks occur when a new task wakes up, on return from
> interrupt or at TICK. If we have N tasks running on the same CPU then as
> a worst case scenario these tasks will time slice every TICK regardless
> of their actual slice size.
> 
> By default base_slice ends up being 3ms on many systems. But due to TICK
> being 4ms by default, tasks will end up slicing every 4ms instead in
> busy scenarios.  It also makes the effectiveness of reducing the
> base_slice to a lower value like 2ms or 1ms pointless. It will allow new
> waking tasks to preempt sooner.  But it will prevent timely cycling of
> tasks in busy scenarios. Which is an important and frequent scenario.
> 
> 2. Delayed load_balance()
> -------------------------
> 
> Scheduler task placement decision at wake up can easily become stale as
> more tasks wake up. load_balance() is the correction point to ensure the
> system is loaded optimally. And in the case of HMP systems tasks are
> migrated to a bigger CPU to meet their compute demand.
> 
> Newidle balance can help alleviate the problem. But the worst case
> scenario is for the TICK to trigger the load_balance().
> 
> 3. Delayed stats update
> -----------------------
> 
> And subsequently delayed cpufreq updates and misfit detection (the need
> to move a task from little CPU to a big CPU in HMP systems).
> 
> When a task is busy then as a worst case scenario the util signal will
> update every TICK. Since util signal is the main driver for our
> preferred governor - schedutil - and what drives EAS to decide if
> a task fits a CPU or needs to migrate to a bigger CPU, these delays can
> be detrimental to system responsiveness.
> 
> ------------------------------------------------------------------------
> 
> Note that the worst case scenario is an important and defining
> characteristic for interactive systems. It's all about the P90 and P95.
> Responsiveness IMHO is no longer a characteristic of a desktop system.
> Modern hardware and workloads are interactive generally and need better
> latencies. To my knowledge even servers run mixed workloads and serve
> a lot of users interactively.
> 
> On Android and Desktop systems etc 120Hz is a common screen
> configuration. This gives tasks 8ms deadline to do their work. 4ms is
> half this time which makes the burden on making very correct decision at
> wake up stressed more than necessary. And it makes utilizing the system
> effectively to maintain best perf/watt harder. As an example [3] tries
> to fix our definition of DVFS headroom to be a function of TICK as it
> defines our worst case scenario of updating stats. The larger TICK means
> we have to be overly aggressive in going into higher frequencies if we
> want to ensure perf is not impacted. But if the task didn't consume all
> of its slice, we lost an opportunity to use a lower frequency and save
> power. Lower TICK value allows us to be smarter about our resource
> allocation to balance perf and power.
> 
> Generally workloads working with ever smaller deadlines is not unique to
> UI pipeline. Everything is expected to finish work sooner and be more
> responsive.
> 
> As pointed out to me by Saravana though, the longer TICK did indirectly
> help with timers delayed trigger which means it could hide issues with
> drivers/tasks asking for frequent timers preventing entry to deeper idle
> states (4ms is a high value to allow entry to deeper idle state for many
> systems). But one can argue this is a problem with these drivers/tasks.
> And if the delayed trigger behavior is desired we can make it
> intentional rather than accidental.
> 
> The faster TICK might still result in higher power, but not due to TICK
> activities. The impact is more prominent with schedutil governor. The system
> is more responsive (as intended) and it is expected the residencies in higher
> freqs would be higher as they were accidentally being stuck at lower freqs. The
> series in [3] attempts to improve scheduler handling of responsiveness and give
> users/apps a way to better provide/get their needs.
> 
> Since the default behavior might end up on many unwary users, ensure it
> matches what modern systems and workloads expect given that our NOHZ has
> moved a long way to keep TICKS tamed in idle scenarios.
> 
> Noteworthy that some folks reported that PREEMPT_LAZY helps undo the
> slight throughput loss in some benchmarks.
> 
> [1] https://discourse.ubuntu.com/t/enable-low-latency-features-in-the-generic-ubuntu-kernel-for-24-04/42255
> [2] https://www.phoronix.com/news/Linux-250Hz-1000Hz-Kernel-2025
> [3] https://lore.kernel.org/lkml/20240820163512.1096301-6-qyousef@layalina.io/
> 
> Acked-by: Joel Fernandes <joelagnelf@nvidia.com>
> Acked-by : Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>

FWIW, since I proposed the same in the Ubuntu generic kernel:

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
> 
> Changes in v2:
> 	* Update commit message to include some data
> 	* Add Acked-bys
> 
>  kernel/Kconfig.hz | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/Kconfig.hz b/kernel/Kconfig.hz
> index 38ef6d06888e..c742c9298af3 100644
> --- a/kernel/Kconfig.hz
> +++ b/kernel/Kconfig.hz
> @@ -5,7 +5,7 @@
>  
>  choice
>  	prompt "Timer frequency"
> -	default HZ_250
> +	default HZ_1000
>  	help
>  	 Allows the configuration of the timer frequency. It is customary
>  	 to have the timer interrupt run at 1000 Hz but 100 Hz may be more
> -- 
> 2.34.1
> 

