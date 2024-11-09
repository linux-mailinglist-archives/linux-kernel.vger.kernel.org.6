Return-Path: <linux-kernel+bounces-402854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D3F9C2D9F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 14:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47E2282039
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 13:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD42192B9E;
	Sat,  9 Nov 2024 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jBVXigdp"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87A31E4BE
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731160038; cv=fail; b=RKIBY7I6KxZsLNdmI3Aksy3UG9Y5AVsj8cJWDhPa6t9xkFN/5oY4ge+h5qXVK96Dq4eLfVylK2BlsnPTBJly/kTFevfoalVBdqZ+zNlMfE1dfKKjBFQkdJ4lMBlmHg7j0YsBnkbifsqmwmn6Gpf7GQg5wByip1f0I+F8mlUcxLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731160038; c=relaxed/simple;
	bh=6/Nz6CzCMie3tz6PIa5Z+iH3Qq9zF0XTLlv9w0OIYyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pe9nl++Dg2bD4RH5pX9arqOSUAvhZdQM/EUQgZE6sOiHIZetFgr5qtW8P+ieJopMf/hY5U6GzhudpKsGp7RjFBXiunNP9+yaXfrA+OZ8ZoiLo9ghadCM9bbiCGtS5O982q5rxEZ5I3MbikPxx029QkXnG5xPACdcO4g9/Vj08zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jBVXigdp; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oE8ofFvKOb8w74Ai67eblZw8igf7sLSh+XPHtACJhMKc4+aYlhh2f7dDdGZtggyKgLV+1KRmRXqTb7iviBuQAFRoZUUBfZRvHmkPyvf1RQ+A5Ea0Gga5JiPH9WW7l2kbxSL1hVy6lIQ/W/u0d8aKrVaQjl42qd/tfOV8P3sZgo4KR6viIOyB2r7nlKnrHaVDt6QPtz2xN2er5qwZhizAY+JhUcJE8VNwTISVEV32BCzsGBxRPcWJjADy9V0nlQtppCMuDqrR39hlIRIz3ReJLyW1aE92A538HwD2czqge4B+0Z7BVFa//yb3G9Ly7uzD/q0mck6hvLQVfjVmNN9rvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqMrnHdzRu8XpaXMYrK3Qib9I2PS/VqSxo7eMvPdBAA=;
 b=SQXbVdZnFZ0hWJ6M1yBgyjWVMY9nvAPvRqDEVitkbeJ6/gWFKYWWgAIHHxSi4VJUtq1Sa6xUhfByQBfP0z5ZJwXQUNrAZRufTGYqO/+WJszqYCER7QYQ8xe+GBMji4GyRoBtoJeYByOnKdGHOZJU3NmfCPsT2ibJWmn1Gr2V1gNRw/4nImVsJ55qUkkabFdiz9LgKYKbOOUY6m3b1OkWpJ2547pjsavPUyrdMqwcui1l9H5JiWOvTYCj8ESmRpUxoZB1M/XSF1hBMdUpQ3L7K9Xz8eWutXynvNY7bCCFU+H4efOmfw1/NJRfJ4wCERRd1Z64nRd9O3vLrZc4AroJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqMrnHdzRu8XpaXMYrK3Qib9I2PS/VqSxo7eMvPdBAA=;
 b=jBVXigdpfvcS4BzpQ50m9blhzh/Zo2VAGcZ2dG2fs/U6YhF3Y4SQ3GzM4IFNiLoRlG4VIu4xDgH8Mkd8NvvxfGTVxePpqI5cwqtvKthT67BmJ/alCRRQ/iQWoO/gxkZOiyTfJKZXVy7/aHNRVYe4QMGd3EMmWH9vQAdtqBBZsmuFTX1Bh+Kpc99MlahIOmzfjBy7VocgpoQenhdmQNxKQGWA4i6o8CmjQZBByCMw9TjUT4wQ8MTa7GREoMmzjgSfpd8ejvGec6myz3MVWfBw2553M8dq2ZQVk4KFNGXBtk5gZ5TNgbzbyfM4C8wVbsjSYb9ROPmJ4GwJwnApBcz/9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Sat, 9 Nov
 2024 13:47:11 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8137.021; Sat, 9 Nov 2024
 13:47:11 +0000
Date: Sat, 9 Nov 2024 14:47:02 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <multics69@gmail.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: add a missing rcu_read_lock/unlock pair at
 scx_select_cpu_dfl()
Message-ID: <Zy9n1qhuraDfHV7e@gpd3>
References: <20241109062905.204434-1-changwoo@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109062905.204434-1-changwoo@igalia.com>
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SJ1PR12MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: fea92aa9-1a6b-4791-8e46-08dd00c50287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sl8ywt0+/Ut7tklYTAqvdk9Dk3UVbeMV7YMFPsR9k/ZOdv7K8i/58NHKyOzW?=
 =?us-ascii?Q?LZLJ7E6LKQGDBj3ENpq4s/TLvrNJ7GVGXI0/wndpoZz4nH12ObfODor9PbxX?=
 =?us-ascii?Q?7vGi0I0WtS7SFo4SXPyAnjs8xZAo9frbMSOZ7Zgz8bQdBKAJN5Yzc653bdhe?=
 =?us-ascii?Q?YocQfqsbE5ZvpSgvPASPxLwrar6S0o8ImBkjw4OYZFgyuytnELNqg4kBVSyl?=
 =?us-ascii?Q?m2lbMuhBsnaF0w8N0OHfzVfNjg9xoPaISE4PZXxkAGNbWPEa0ULVafV/ePFX?=
 =?us-ascii?Q?yOBKa0tb0OtB3DJzHu90NzdTm/9Z8Jdip/LRrkGedeBrXe4cRFIu6jkK32rZ?=
 =?us-ascii?Q?eCR9qbeXfG6ULzi7H+3WYh7v2TPJwhDQrI+MCbJQCuldxgsI/R1NykTtFuqr?=
 =?us-ascii?Q?MFJ25lyTx3t0+W6ZRmLnyjmxQ+jZHhIGwPw9MOh2GyqrfOvEQ7FwnezZ7qBx?=
 =?us-ascii?Q?t6YuDG7yrwVTfOqIgNxUqjaaMPs4WAKpNI009lfN6gqST1YT07XGx9vvW/+o?=
 =?us-ascii?Q?lcLaItBHxSjAQACp3rmkM3MFMyX7OnJlUuTXS6ZAYjeub2nyowIo3j81eNAd?=
 =?us-ascii?Q?77iyVr+gKVvvsWvt5d3rUbdDlwiUoox2lzIovGkye+ZA5ZwRdyraIVsJnYGU?=
 =?us-ascii?Q?wkISQdiWQUhaMWAAk0jN8vU2JDmnLsqYPbgg2UArCIPo7K1thluwHiKZ4fs8?=
 =?us-ascii?Q?FzPVa6Y1KxV5o0vv9UofdEsG4AbD8Nt3dj+hvnLNuHVHxQdlFnBMhiIkPKW0?=
 =?us-ascii?Q?XeZ/V+JdaoIqAf2dJg+9cRQCRlMGCTioqcXZrRFdZhngkfHETWNvCXp8ScD+?=
 =?us-ascii?Q?/b7Arp5Gbn5mBTUs5sEa7QEkJo+lfsgaSi+u0jzSzqEsdInRa6yOxBlBDSJE?=
 =?us-ascii?Q?Jm9CjGlXwbSIJE71LA+BfoAvkY81MckQDhWOhtPFgkAMk52IjhSdGPNpWSxZ?=
 =?us-ascii?Q?AiXM/Fn+60E0od9YwBGvEHuX9tfowJ/nSvsnmSlTAlKr+OlaDWdCoXKQb01u?=
 =?us-ascii?Q?NlMNI4Y45lkruHtIB7xlkSrQpsLtQ8Cm52Xcv1KlJPIlF7YZj0+F8IjxnYis?=
 =?us-ascii?Q?6SVFON0mHm5jTwI8QdGJ50suCt5sPQQ/R6UnjhQEdn361lI9pAKVRNvYEv5o?=
 =?us-ascii?Q?+0iDVa7nBYn1UHn1FoyG+UqW/O4Ap9uGNP+dgUxAcGMy2hZ0MJaL3SN6zxkI?=
 =?us-ascii?Q?BG/Wjk4CD+uPo1eNEJ3iA8QoXxl42WF1wB4xH7eDAiO3TiOJMM+RCIGr+0YY?=
 =?us-ascii?Q?kU0vmLNpypm5FzpsXZvgYZnemwAbE9RiaEM2klFHBefpMrkD8lBjo6A8f8x+?=
 =?us-ascii?Q?NAJX5zS9Hm/AZtxP1ehrMRkB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dEL8NLhJcKuJIpAi9aORcBPalv1BhZWNbWWdRGPGseHxVyHACa1rfQEGzBpe?=
 =?us-ascii?Q?x/cS4esJ/lxgQi04jkFDAxZOVoRfJShYgnTAQcbqBAWR0/8l5SJOYaD1YqND?=
 =?us-ascii?Q?6Np4E6xN/RsS5f/tMFkeiONao8PWmJjEO+JSkShF9bb1Qbniq7tU6d1LiKzQ?=
 =?us-ascii?Q?JM8+gvMuLpsngPS028OfbbNJW8HGLbedqlf8spMaBPzAMmkTWciBWnogaHMX?=
 =?us-ascii?Q?0dv7AoKwddQ7ehKc2O07C/OyuxnYgRFn4tp/ZQfbjJY23rPGKDiMboKGsIzb?=
 =?us-ascii?Q?Md6++92AFQr+LWfpA8RsG2dh1EYuEi8my9S5UXIvIRV6lzyJ7IWcMUwNUZAF?=
 =?us-ascii?Q?WwTuG8DfODcRFVpWovAnAqGepqqJYseRQKe2hyDNoceWxmvTr3WgowAf8mFY?=
 =?us-ascii?Q?fkIPLpSXBCeItZ2rxaq1IFvL/v6IZwMcFHfrU1JY2EUAmPEsWiAsfz4BDDrj?=
 =?us-ascii?Q?ZlXUgZjQVGZ91v/ZPGwQlRqJzvyopDyWhzjKCBHQKz1jyrbIUxR//Eo6aOPe?=
 =?us-ascii?Q?6C/AL3a2fE3m0Ok/flX4WMAqKx0YU1lbaptDyu44PLPR62O2aA/HcZFkulYe?=
 =?us-ascii?Q?ZeT/0ORq9n+IDuYx87snpqFUQmKH9McOs1ame5wXKtXl5DfyzAnkDZhGtAQR?=
 =?us-ascii?Q?/NfpGZhfXBzWPwj9PYcyBhkeR/V7FjqSCuh5vEQTMXFo5p0/t0DDoGMAJTsI?=
 =?us-ascii?Q?3sjJU4l5v7Tm93bFh5V2JeZzaUfPHPTXUzGgiysrjXPoFsvAp3BwNtDW5naB?=
 =?us-ascii?Q?x2OpKIujDhqCpkw4rpnZc4gpzeEX1chn7p0QQkXfpRUTjrKnPdFgQDbOggxF?=
 =?us-ascii?Q?sQYbE6kRYjV2PyTXtI+Yh7UYUsyssSYZ2pM8hNWXlupPyX1LU+BoaRvQVCVn?=
 =?us-ascii?Q?l9v5dJdQCyee3vi0CCUkQYC4yZNtwmFcCJTULrZW5mytz1b8oF2qUzPp8tfF?=
 =?us-ascii?Q?h7Dfei0U5yhDIBAtD+9HJeKtHO6sta8dkqVbc8+0JPhxSYyk3hmvxK+nUJBS?=
 =?us-ascii?Q?WOiyAZska7lfu5Y+gZyr561g5SZL5t3dsSDMeG+oHnkN1pjV49GWjgiQw6aj?=
 =?us-ascii?Q?ZLM5wW5Uo8ZLX7R+O2TUcbKzei58NvMAjFOb6DCAp+UFfpyj+5d8UOmfj78H?=
 =?us-ascii?Q?A1F45JOona1IhFg4AHA9QCHup0JAnmGXhGfv5jC9UIL+D1kGtWSIp5vf1sWD?=
 =?us-ascii?Q?8ENIcB3spPHEWUriSc1yRvWgI2tdXqcs811v4pOOUZNJJ8kFWOOSw4kQmFTY?=
 =?us-ascii?Q?L0kPwOLGSRyA0AbxvsJqd7s/uyHe2yfFFEya3fLLpw7jXG4hHsRxlwvXmFjJ?=
 =?us-ascii?Q?qTA3mAuaUX7ZkIvykl7ecDCVshxNRt9eH9yijrlGWi0eYt2Mn3uM4XGf7Tvp?=
 =?us-ascii?Q?ePR0KcVdeRSbiE0TBW7rZQ/RVPXdo2Azafp0Rr1aZbj9jjDgK8TMUPGOWMWG?=
 =?us-ascii?Q?gwgxeLLLVjhHAv/THxZZER8LQKbf+P0AoVm2J2iFpSXy0V+6vOxbYxgUOM4W?=
 =?us-ascii?Q?0LHc5gySbZqJWJ02QPqGEy9Lm7QCYrLwBDjMLaeZBSlkjXunEMC1SbOlfKvY?=
 =?us-ascii?Q?rk3qo9LNacHwlVgi5TXHlcFbUFdoTCGykzw6vQpl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea92aa9-1a6b-4791-8e46-08dd00c50287
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 13:47:11.0707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDISZjUi+SpSDlnSo8tgfJqarKabaWBbFZbGhpVWkz5J2kP8QkJriME4CiKuc5bUukgmSLX/VHKOPA8ZSuLJRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244

Hi Changwoo,

On Sat, Nov 09, 2024 at 03:29:05PM +0900, Changwoo Min wrote:
> When getting an LLC CPU mask in the default CPU selection policy,
> scx_select_cpu_dfl(), a pointer to the sched_domain is dereferenced
> using rcu_read_lock() without holding rcu_read_lock(). Such an unprotected
> dereference often causes the following warning and can cause an invalid
> memory access in the worst case.

Thanks for catching this! I'm wondering why we didn't hit this in our
CI... I'll investigate.

Just a minor nit below, apart than that looks good to me.

Acked-by: Andrea Righi <arighi@nvidia.com>

> 
> Therefore, protect dereference of a sched_domain pointer using a pair
> of rcu_read_lock() and unlock().
> 
> [   20.996135] =============================
> [   20.996345] WARNING: suspicious RCU usage
> [   20.996563] 6.11.0-virtme #17 Tainted: G        W
> [   20.996576] -----------------------------
> [   20.996576] kernel/sched/ext.c:3323 suspicious rcu_dereference_check() usage!
> [   20.996576]
> [   20.996576] other info that might help us debug this:
> [   20.996576]
> [   20.996576]
> [   20.996576] rcu_scheduler_active = 2, debug_locks = 1
> [   20.996576] 4 locks held by kworker/8:1/140:
> [   20.996576]  #0: ffff8b18c00dd348 ((wq_completion)pm){+.+.}-{0:0}, at: process_one_work+0x4a0/0x590
> [   20.996576]  #1: ffffb3da01f67e58 ((work_completion)(&dev->power.work)){+.+.}-{0:0}, at: process_one_work+0x1ba/0x590
> [   20.996576]  #2: ffffffffa316f9f0 (&rcu_state.gp_wq){..-.}-{2:2}, at: swake_up_one+0x15/0x60
> [   20.996576]  #3: ffff8b1880398a60 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0x59/0x7d0
> [   20.996576]
> [   20.996576] stack backtrace:
> [   20.996576] CPU: 8 UID: 0 PID: 140 Comm: kworker/8:1 Tainted: G        W          6.11.0-virtme #17
> [   20.996576] Tainted: [W]=WARN
> [   20.996576] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> [   20.996576] Workqueue: pm pm_runtime_work
> [   20.996576] Sched_ext: simple (disabling+all), task: runnable_at=-6ms
> [   20.996576] Call Trace:
> [   20.996576]  <IRQ>
> [   20.996576]  dump_stack_lvl+0x6f/0xb0
> [   20.996576]  lockdep_rcu_suspicious.cold+0x4e/0x96
> [   20.996576]  scx_select_cpu_dfl+0x234/0x260
> [   20.996576]  select_task_rq_scx+0xfb/0x190
> [   20.996576]  select_task_rq+0x47/0x110
> [   20.996576]  try_to_wake_up+0x110/0x7d0
> [   20.996576]  swake_up_one+0x39/0x60
> [   20.996576]  rcu_core+0xb08/0xe50
> [   20.996576]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   20.996576]  ? mark_held_locks+0x40/0x70
> [   20.996576]  handle_softirqs+0xd3/0x410
> [   20.996576]  irq_exit_rcu+0x78/0xa0
> [   20.996576]  sysvec_apic_timer_interrupt+0x73/0x80
> [   20.996576]  </IRQ>
> [   20.996576]  <TASK>
> [   20.996576]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [   20.996576] RIP: 0010:_raw_spin_unlock_irqrestore+0x36/0x70
> [   20.996576] Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 11 b4 36 ff 48 89 df e8 99 0d 37 ff f7 c5 00 02 00 00 75 17 9c 58 f6 c4 02 75 2b <65> ff 0d 5b 55 3c 5e 74 16 5b 5d e9 95 8e 28 00 e8 a5 ee 44 ff 9c
> [   20.996576] RSP: 0018:ffffb3da01f67d20 EFLAGS: 00000246
> [   20.996576] RAX: 0000000000000002 RBX: ffffffffa4640220 RCX: 0000000000000040
> [   20.996576] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffa1c7b27b
> [   20.996576] RBP: 0000000000000246 R08: 0000000000000001 R09: 0000000000000000
> [   20.996576] R10: 0000000000000001 R11: 000000000000021c R12: 0000000000000246
> [   20.996576] R13: ffff8b1881363958 R14: 0000000000000000 R15: ffff8b1881363800
> [   20.996576]  ? _raw_spin_unlock_irqrestore+0x4b/0x70
> [   20.996576]  serial_port_runtime_resume+0xd4/0x1a0
> [   20.996576]  ? __pfx_serial_port_runtime_resume+0x10/0x10
> [   20.996576]  __rpm_callback+0x44/0x170
> [   20.996576]  ? __pfx_serial_port_runtime_resume+0x10/0x10
> [   20.996576]  rpm_callback+0x55/0x60
> [   20.996576]  ? __pfx_serial_port_runtime_resume+0x10/0x10
> [   20.996576]  rpm_resume+0x582/0x7b0
> [   20.996576]  pm_runtime_work+0x7c/0xb0
> [   20.996576]  process_one_work+0x1fb/0x590
> [   20.996576]  worker_thread+0x18e/0x350
> [   20.996576]  ? __pfx_worker_thread+0x10/0x10
> [   20.996576]  kthread+0xe2/0x110
> [   20.996576]  ? __pfx_kthread+0x10/0x10
> [   20.996576]  ret_from_fork+0x34/0x50
> [   20.996576]  ? __pfx_kthread+0x10/0x10
> [   20.996576]  ret_from_fork_asm+0x1a/0x30
> [   20.996576]  </TASK>
> [   21.056592] sched_ext: BPF scheduler "simple" disabled (unregistered from user space)
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  kernel/sched/ext.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> ChangeLog v1 -> v2:
>   - Extend the RCU critical section to cover the use of llc_cpus.
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 6ff501a18b88..f0e9c77eb33b 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3302,6 +3302,12 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  
>  	*found = false;
>  
> +

^ Can we remove this empty line?

> +	/*
> +	 * This is necessary to protect llc_cpus.
> +	 */
> +	rcu_read_lock();
> +
>  	/*
>  	 * Determine the scheduling domain only if the task is allowed to run
>  	 * on all CPUs.
> @@ -3436,9 +3442,12 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  	if (cpu >= 0)
>  		goto cpu_found;
>  
> +	rcu_read_unlock();
>  	return prev_cpu;
>  
>  cpu_found:
> +	rcu_read_unlock();
> +
>  	*found = true;
>  	return cpu;
>  }
> -- 
> 2.47.0
> 

