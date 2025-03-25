Return-Path: <linux-kernel+bounces-575618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8355A704DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111911655DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED25525BAD4;
	Tue, 25 Mar 2025 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y1UHD4y7"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0361F4E4B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915969; cv=fail; b=uYq1l+iazOF4I6OY7vdWQHb+70DUcq7QlUrSV2lntgG3qB4Qrg5zsscHXRy2dPirgUJTm9G5KY5Itftnrn9hOlfHYyBY6CjizHESq1THjgAWnNAOiJzC6CpzGvwQqA4asR4QvQX4amor4uxfwPrwsCaZcmwpfb7XxKQiacN/0ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915969; c=relaxed/simple;
	bh=chffXI7HRCkhaVaQ3yjR3nqbo0ouXRfJicdOfOJw0w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eRHtM7HvHyHYk8AZMolk8iyNrHg3XHxRTapapo/9a0ZAAjSU78PA80Uy57bGHpj564hv3znK2TW05XarHAn2xG6h5csEm9MByKijejo26s+A/P0eL/raqBe1oshMBxL65glKXovr4b/qgzl8zTQn3vGkhM6nH/E4f8bDoIP51vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y1UHD4y7; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGuf9ZSDInRKzzfjHVNZEo4/EQmQ9vtaG6Pf4Wu2o6HHyggUwnC9RIAYoN/M/v5zrOdehnjaTgVK/xjQm7Z2+Qt5AsL7yRH1JzvFMNBBiWcZoVvXU3Aut9MgKySSqSuPq12ABJaGmvtDgQrw1LNBQnB2JxZGA5fcmeF/JqtKjqjUBnO08UhYDgGlvztQwp9+5RXu33pFHJUUYBKWGAsxSnY/XwPCthQr47Wfhc4ijt9mibGCGkiLF/YwEOyo+qy63jgBmvM7WpKezK5OAQSz7w+qXaGFxwTgd56HRYamwbYWdpD6WlJ3JZE1am+uS+9My7q7tnc9+P1o1qQKu4tN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdg9gqmstVSHEY+qkQJXO2AzazvPc/5TwJweyr0o0KM=;
 b=R2IpwQiMvdNXqbRGX2TVkqOHQ0QSF6eg+IN4wE8EbAfsgGfMafSKi34lPVCYS1XC8QgqUBc9GbnjMeMgsUvROB9mfdCzLaQhDe8VNtU6g5eFj47bsHTrc4w/6ymBSgbFNm0ZXtAhq3SLUGD/JgXCLsFqCynyPgsNhlYYaos7BmU006FlRSC1lT9IlcxxNsX4U6ZfQ0+q+0pKaRxDCIcnMsOB/8zje2iM1YcZpy1MXSeu5McBRIuj0pqAUBcO5MBqpT1I3+QfCiD7L6NgQjx1Nvpz2Iv8qMx5h5eRQ+TTCq/FDa5EnbAbMg25m9Mk5mA9fW2XsPD/ir+AKF9+RbTa9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdg9gqmstVSHEY+qkQJXO2AzazvPc/5TwJweyr0o0KM=;
 b=Y1UHD4y7sNOPs+AN17lWZ4FaHe0LPWIMMTAErU7+852tCF1nDnjkkA9T1LSTs2lZdd+z8av68qcWP3JKWLJw43dMhG0zd5OWE7QdiU9O/6UzWGgJk+n8jLwjatxfmCRc5wxBbfWyHkD4V6HeX/x+GO1Yfb53LzyDCe0+tY0PkI/A4fjShArg0FzKY8//Qic4zRih1n12wrX6MnARJsQydIJ3fNcfcZEFrOZeHHMCHVnRIq7jf2ejetUuMUiS3yXwnSbGka2ytLLWuCikQccelpDBGo67cUCR0t2YdnTTx3y1NsUt/qfeYvvoHN8gou8UAXm8dMQSP0z5y6j3zFNqOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 15:19:22 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 15:19:22 +0000
Date: Tue, 25 Mar 2025 11:19:20 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: initialize built-in idle state before
 ops.init()
Message-ID: <20250325151920.GA750298@joelnvbox>
References: <20250325093212.47188-1-arighi@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325093212.47188-1-arighi@nvidia.com>
X-ClientProxiedBy: MN2PR14CA0001.namprd14.prod.outlook.com
 (2603:10b6:208:23e::6) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: ee645aae-c06e-4a77-c61d-08dd6bb06bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u02sGNFIar/owr001KVZSv8DRYfC/7LhKTir/o4PzuXUf9KhFvE0zpixFdTy?=
 =?us-ascii?Q?od7vjfzvkC+YmI93i0uaZM3jJFQt2AMvLpHJnhkk8MJl5q5c86qmS9t5IKCc?=
 =?us-ascii?Q?0kY6sS2EB9GibUlgr7qDpdeQRCi+KnIPeFjJy8+e3AEGl31PYDxCoqlGIv4r?=
 =?us-ascii?Q?3MZOnQPu9oC9ZgTt+neyFaoZF7B6pTqy0CdXtr/kFFxCWXpoFM20RB/T2AOB?=
 =?us-ascii?Q?ltsLplXzkHtX6N/gYbNk1YFFZPdl0DpI+FfgVWzwegF+fkEFd0bE12RLt2wF?=
 =?us-ascii?Q?YMvrc1avO78tntgOy1JZSw5RI5X/RA5nlWdRx6gBr5eISe6RS0SELO/hTJAB?=
 =?us-ascii?Q?tL3/FHZ+vMkwJ+SSM0bpahW0vZy28yjrBWkUaKIsZrgFVACoKfZjDxlF5QAL?=
 =?us-ascii?Q?+N9OkXweI/N3ShW+Av6/9zO9ka6MhheGQYxSgjBa8yPrYjX+Cm53RCPtxeM3?=
 =?us-ascii?Q?nezleXIkEQ8/thOByn+ThjfGYiaFK3TaQaFMniP8pNNHrGT6DHQpdiXeBE6v?=
 =?us-ascii?Q?EVB+JRiOKk6lk7yf7miU3OXSB1lDQNw7KpY3Z7lqaJ3LlWGq8wK0jsidY0QS?=
 =?us-ascii?Q?LX1jCUQu8aE+kFPvpG1RbZyRfxYdeeOz6GJkyr1j0tdKvMUTTCUaFOu2jY20?=
 =?us-ascii?Q?RTufWFiLE6+hVb5oMOidkTxOCpqU1NruGClay7INwlW0BpwulKnxpglDDMA4?=
 =?us-ascii?Q?Lst0eCQHHqiL5z0X0ALt64T6T8AkdhpsSl6ioktV65Whdmc6q+MnhpJJWy83?=
 =?us-ascii?Q?cF06f69Yy8yAe6qyqair5EyeD1Bz86OSKmEzVICXGHkYnRXoozq2W/kyVRUS?=
 =?us-ascii?Q?gQHaGvwB1oEWwoVd5mqdzHga4cnBmsmo12wO1GNHKjDOulbOsFiI7Vq+SR/3?=
 =?us-ascii?Q?mn56v+sgIHSFIQbdQqzD+EgacUP/ZKklN8UdC7JIV1DjIVn9SHdXKYSMM3WZ?=
 =?us-ascii?Q?n/9zwuafveQIIYW16GKpx+vAF5M7TxJFEy1UoCkJ2Diz1h2Nbo6NJX6DDcgy?=
 =?us-ascii?Q?136oe3ihXKL7MgARVVZKiMRdaNewstA/XRCOqdZub6R3cgnHDnX810329XQK?=
 =?us-ascii?Q?PD4zCvbNHvEJy3AQKKMr4HMbvtHU6mMBdKfW9KjnAnY/HzQ2ui6iBH6QqG0r?=
 =?us-ascii?Q?zLvqZFoz0i6IHYAULlNfRwT63Syk/d4VZZAnHTZGTp3WlpuKDwwJkPbp4qdv?=
 =?us-ascii?Q?znockVGAc1sRNwYYHQo2ESel/NBAQNHzjRkR5+N6n3WHuf1RB+UaVeiOmmU2?=
 =?us-ascii?Q?xWR38PVmUXwXjXQUtKytf2iH68j/DVbf0YQ86sdFhauzwDt93AGUz4spKYwL?=
 =?us-ascii?Q?FnZ1Icvb/E0Q1LXvpY6Rb0LJOnxs9P34UQKPym1sOzUof0gOVTDZQ/GCq6q6?=
 =?us-ascii?Q?Y1bWwyHJG9Rr41+yT3WQKAB1j/DQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7NaRc5HL8qNCclfAERveZYi/CtHVfm8guRvZEkRVeMYhIdM2kG8JpggpeBKA?=
 =?us-ascii?Q?JmPG8r4XdvKXUnSfVhXKJcl2MakRnIbXr9uUoSCEaWdSXzJyQKS/u1W6db8p?=
 =?us-ascii?Q?z2yrGxqbf3B8P0be2SEAxlSMkHXnZgVgQwgpjBrPQYovgcpcIl4sPik0xqAX?=
 =?us-ascii?Q?7yqNGvqvif7olUWbpQDMaDQBs3ndBuNZ3isLpekq2p4t4Rp6BFTAyAjXTtIP?=
 =?us-ascii?Q?ywOXlvEMO3+bzxqzYlGmnCxXxymsmtgNKuPJ/nb0wAgFeQkIEBqcdfW1tImP?=
 =?us-ascii?Q?rLgk1cTz6RUDF4fpZMIAjEj2dD5NAvGYIxfh6BPpPwwxqu3NG6eYFS36o76m?=
 =?us-ascii?Q?kjvs5wrvb9ajo9RiF5q8KIB8oGFYPArCjOd5rB9G0xCNN5dA5OAYm9pn4Js2?=
 =?us-ascii?Q?tpfVufNTYD8nsTi3yz4y8+gItcHZpbCRv3kbcmEqK88voWL/T6ChxC+FDNps?=
 =?us-ascii?Q?ZoeTZaYO4VK3EbXeRx/Wzz52kJWQs87tzRCy3tpc6uGzPoliDGhxTDVRD78R?=
 =?us-ascii?Q?yY/63s1alDdH82hmLxLJQ4U/oldCV34u15vccIza2fAEQLSyc/G0EjUlgxnG?=
 =?us-ascii?Q?4oleiBEbpY1wqLU43AVC/PtCCSKpzAkb1ituqNliUgwnsjPiXVCCx60hgU/L?=
 =?us-ascii?Q?J0QikbI/oK6uBi8fAEhpmskRqsspl+AzjOyA/pA4+XicBkAs1s2+oxjUa5ws?=
 =?us-ascii?Q?aWNMUgtOgRYSFY2+RQ3FZUddiHvMFJEKAn7nTKzm9vkKvPlE0FAHqtTFub28?=
 =?us-ascii?Q?hk/rVcZgc2MnZgBke+85wn+olHMC8s0OmPsj1vMtkPtQB7D77EhT0Ftv681F?=
 =?us-ascii?Q?nw2220uusBa1C1tuJl3Jo/0aPXLKreH+CTeKKZ8hvNzbQVJ7DQSxwYFEtf8T?=
 =?us-ascii?Q?/hdF321LQHmg21p3AgP0xfGlFQm8s1u55Y9F6tpcf4dfiGBzgg1fM7zgcOpX?=
 =?us-ascii?Q?n+TWPCaXJZKys95U4l85jvmrAO9waStKlkc1YQpIaram2sPAFh3Wyle1CEI9?=
 =?us-ascii?Q?infoM9dEa+/CocZz1aUGNRmq8afpVGUtyc+BowsmvtM2dYtvCdXM2SS9gjWO?=
 =?us-ascii?Q?bEtA3DBl7EhMUnW6fJ33dUoxB8a3INClu61JS8zDRnX0Dm8je0idMnBsgxdE?=
 =?us-ascii?Q?iSDorsqE+NDJ7aX1eYS215cJeC+sC3tcCbvNiKXllWQnLMoNegg4ZOCOQz/9?=
 =?us-ascii?Q?DeGUSv6l2QjqfG4yKJxz9epTJVD9aHhw9PvfH2apSlJAnzQvigUNRKstifH5?=
 =?us-ascii?Q?7R3Ot+WUSm955bOEzRH5V3lQme+UrnV3mGVn5luQQ76jO6yVga25uAK4QOUr?=
 =?us-ascii?Q?s0n4lcHYgdzPJns6HHFripBK6J7rmIrVrJKxYiMXK2H9gYzJGBmhFAjr81Ix?=
 =?us-ascii?Q?1p9R2akwgkPIm2AIcaEIqiJmNMTXTMYzERubgtIlDuSaq4GWyvKUiLHRciM3?=
 =?us-ascii?Q?OOB3I+EnJlnI1zLo6nno3UgUnQq5S+NJFyk29pYO4/tb/g1w+qotkvlQPW7o?=
 =?us-ascii?Q?r7MHGumaHm24ye1ELGv+LH6Cybl7H/Kyzw2PLpLUJutLT2lMZgLgUHwHeEXV?=
 =?us-ascii?Q?H3c6W0LZhZVnsp2KU1RhrEUqosn7kq17z0IyOmES?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee645aae-c06e-4a77-c61d-08dd6bb06bb9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 15:19:22.5042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCMKFMTe0vZUgAG90UGzD4kXsd4es9RbR3YmJyuD/nxdlpmjV/Uq2Ab9bg5RPP1fcAWAVCCd5l1YDggBndiedQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067

On Tue, Mar 25, 2025 at 10:32:12AM +0100, Andrea Righi wrote:
> A BPF scheduler may want to use the built-in idle cpumasks in ops.init()
> before the scheduler is fully initialized, either directly or through a
> BPF timer for example.
> 
> However, this would result in an error, since the idle state has not
> been properly initialized yet.
> 
> This can be easily verified by modifying scx_simple to call
> scx_bpf_get_idle_cpumask() in ops.init():
> 
> $ sudo scx_simple
> 
> DEBUG DUMP
> ===========================================================================
> 
> scx_simple[121] triggered exit kind 1024:
>   runtime error (built-in idle tracking is disabled)
> ...
> 
> Fix this by properly initializing the idle state before ops.init() is
> called. With this change applied:
> 
> $ sudo scx_simple
> local=2 global=0
> local=19 global=11
> local=23 global=11
> ...
> 
> Fixes: d73249f88743d ("sched_ext: idle: Make idle static keys private")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Makes sense, I think this is restriction is because static branch will use
IPIs in some architectures which requires to exclude hotplug operations.

thanks,

 - Joel


> ---
>  kernel/sched/ext.c      | 4 ++--
>  kernel/sched/ext_idle.c | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> ChangeLog v1 -> v2:
>  - fix potential deadlock with cpu_hotplug_lock
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index d82e9d3cbc0dc..3d20228052217 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5361,6 +5361,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  	 */
>  	cpus_read_lock();
>  
> +	scx_idle_enable(ops);
> +
>  	if (scx_ops.init) {
>  		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, init);
>  		if (ret) {
> @@ -5427,8 +5429,6 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  	if (scx_ops.cpu_acquire || scx_ops.cpu_release)
>  		static_branch_enable(&scx_ops_cpu_preempt);
>  
> -	scx_idle_enable(ops);
> -
>  	/*
>  	 * Lock out forks, cgroup on/offlining and moves before opening the
>  	 * floodgate so that they don't wander into the operations prematurely.
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index 746fd36050045..811f8bff2ff02 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -794,14 +794,14 @@ static void reset_idle_masks(struct sched_ext_ops *ops)
>  void scx_idle_enable(struct sched_ext_ops *ops)
>  {
>  	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE))
> -		static_branch_enable(&scx_builtin_idle_enabled);
> +		static_branch_enable_cpuslocked(&scx_builtin_idle_enabled);
>  	else
> -		static_branch_disable(&scx_builtin_idle_enabled);
> +		static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
>  
>  	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
> -		static_branch_enable(&scx_builtin_idle_per_node);
> +		static_branch_enable_cpuslocked(&scx_builtin_idle_per_node);
>  	else
> -		static_branch_disable(&scx_builtin_idle_per_node);
> +		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
>  
>  #ifdef CONFIG_SMP
>  	reset_idle_masks(ops);
> -- 
> 2.49.0
> 

