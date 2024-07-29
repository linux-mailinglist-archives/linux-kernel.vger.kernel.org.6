Return-Path: <linux-kernel+bounces-265105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AADF93ECAB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2D11C2157A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547C980026;
	Mon, 29 Jul 2024 04:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c/iJCuB1"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF405579F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 04:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722228395; cv=fail; b=QQQf9Dw7ZW71fdm2Rl4j+yzJFB28/MwcGW/wAalk343eSKueOgb+S1OQ6AepE1UcGCBqJ5wmClo3bzMHFyCuZropNayJDeZAi0DOoILn5U8sfYkWsPgw3RjgGI4miUTHGaDb1TvsJsD94ynninWm+LZqu1mQF4NXIpLTlbwpfek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722228395; c=relaxed/simple;
	bh=9EjhyKxBgidjkXynG2TFp2Ema9liuuyY/ILMJ9tNF5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DdzWrhw7wpbvzoZ6PXRyRU5zRqA/U/y5r1GtYG0205ywr3dWXuKMqZZfDt2899sF1P2rhyDuhRQ+6/vrbwlc2bIFDhnKmVAmb3/f7tz0uKwJjfK7WjMTdLQZVMYX5oTfWyZh0U6we3wUCgaSNwOLojmATcvNsJ97dWYJAm3pHjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c/iJCuB1; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUEf9/Mow4hlL2/+Ap5mgWIheMkG/8f/gDE4d9Dzl5LsiqdTH/H43YfTouYzyuKiuTu5Svrg0gnZPhn9IB69AswjTI487u8hTQ/ayFpk4TV1Lb+YdAeMSJQ49sAlu09K7q+laGyGvomUGlyRsIdUUy8/0YERMlsDX2Ya3FiX58nQWo3wtKpyx0YmRNOYQS9zyI9RgnAjbJjrLSscPUTgi0QNuSZD3OXvQUkWi7bVGuWzYvOukp26g6VOyWszvx0YQR9Ixyh4U3z9lvEGpTCZZrCZtEZ5wRyUlCRErdWaRaO0KC+li0tX55ezvJIRWcGviVu116v7k2lxJEXrK/Mf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ff1SAufniw68F4GY4RUKW5SLDp7A2g5ajLZ1WEsaMo4=;
 b=mx/aDOas2wo+ncUskIIVqBAVzSeSGyGXCmoYRyM0lbQ5dreK4nfAbrvv7ZYH5351CqI3Os+aZm2mX1/VzYUOuYLynPtsZByax+Rjv16YPxH0menpT7Ynya71424wr7NNpc6OeD4wdnUOLI4AAvKMzhHW1BNc8rQMqYXA6Zswa8SVhBd+eJva54mcrkHXUfS0+uFDRNkBVSsmW2rf45kiSLqws2V/shCgLEy09m5HT6svxRzUIUsIXhms6ag64sjPxKirD4Jt6W8myqdTtUAh1XykRHxCeOCjmAVpsW56BBuWC0+sR32w5b41RS4uC0qTl02+N2LrAcJmGqPcpJ4JJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ff1SAufniw68F4GY4RUKW5SLDp7A2g5ajLZ1WEsaMo4=;
 b=c/iJCuB1F0+n0BWww+QC2A/HZK9CKWjEMKpMA6Pq/rlodYPWDY3feB+RcAiiuLnYo3CFBh5IwoOSeWNgEnrPsbqe21tsLJyOfu+zqccVdm0ajiqpim1qr+8R5hTKBuHYchWCpdymuFpw5xeHiTbZqKoGYoL+xXXi4D/gDfGuhvc=
Received: from PH7PR03CA0002.namprd03.prod.outlook.com (2603:10b6:510:339::21)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 04:46:30 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::98) by PH7PR03CA0002.outlook.office365.com
 (2603:10b6:510:339::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Mon, 29 Jul 2024 04:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 29 Jul 2024 04:46:29 +0000
Received: from [10.136.40.92] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 28 Jul
 2024 23:46:25 -0500
Message-ID: <0a6182b4-e5e8-0eb6-234a-9097fffe5069@amd.com>
Date: Mon, 29 Jul 2024 10:15:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] psi: Inherit parent cgroup psi enable state
Content-Language: en-US
To: Chuyi Zhou <zhouchuyi@bytedance.com>
CC: <chengming.zhou@linux.dev>, <linux-kernel@vger.kernel.org>,
	<tj@kernel.org>, <hannes@cmpxchg.org>, <mkoutny@suse.com>,
	<surenb@google.com>, <peterz@infradead.org>
References: <20240729034100.1876510-1-zhouchuyi@bytedance.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240729034100.1876510-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: dc12046c-28cc-40b9-f995-08dcaf896972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTlxL1crbkdHdDlYckdJZVlMZWk4d00wQm1EU1ZQZGZVRFpLcEJXbXpNbUFk?=
 =?utf-8?B?S2psRWl1cEUxUENzSVZpK2tPY2JMS0w5Vy9QSkhvOHhvR0FBSFU5VGwvM292?=
 =?utf-8?B?ZE1JeWdFRzBzQm1NMll4eUFORjZ6eXMxelJzQWZSclRPemwyVmNObWp0THVy?=
 =?utf-8?B?Unh5WFNrakhpbG9sT0ZjMm95aHBGWm8yUWNnT2pYaFFNcE8weDhWRm45dE1G?=
 =?utf-8?B?d1R0dG9RTHNUY0hseEthcUZJaXVBL1pEZjEwK2M3NzYrZ25vWmRZZ25WZndm?=
 =?utf-8?B?T2xzYUpvYjhPMTljZ0w3ZkF5R3FuMCs2MXpPSW5idXd1Qkk0L1hIbW5yamJz?=
 =?utf-8?B?UlZCUHJEVWp4ODFLQ2dMbHpYdTRYRXNoNEhoeEF5QlBTd3NkR0krL0tqOVU3?=
 =?utf-8?B?UVZqck5xdldqRWdYNGg5OVJVR2w4NHpTNVlsYXFjT0hvYXlOb2lyWDRmQVBJ?=
 =?utf-8?B?SGR6bDJvUThnUjRnb1pZOFFHM0pqN1JSQUY5eTZVakx5aE05OWFIU3UxZ2RI?=
 =?utf-8?B?OVA5NWhHTWNBaGxmcmZUSnI5OW1remlBZ05wZms2d1UvR0xJem15clRiajBQ?=
 =?utf-8?B?M2pabHpEUFNRR05ZSUV1Rm0rTnNvUG9GWXlTNDJUdm9TSHRLcTZyVXE4Qlox?=
 =?utf-8?B?T0lsUm1aSHRMdjIrNU1rWWFXUFl5NlQ3OElVbldydEc3N2VwYnMyazFURHN6?=
 =?utf-8?B?dU5PVkJhdUtvM294THJGWW5HeTRPVWYwN2JtbDFGakJnV050a1Z1VGo5OGdX?=
 =?utf-8?B?MkRjTlhzeWN0RDdndUcvVWtJcEV2Z291RkJVQ29GUHMwc2RQMFBwa1EvWFEr?=
 =?utf-8?B?KytVelI1ODNFK2pFdW5VdUtEUmNlaTEyU3U4dXFqbW05SG5GUEREUE9sdU1D?=
 =?utf-8?B?S0pqUUYyK2hydkYyNklFS1pRMytaRllDd0Z3K281UXI0ZTlleGJhZkxSWXJX?=
 =?utf-8?B?UDd0RkVOODJXRGQwQWtIb3U2S1N4YVNBY3RmWmpiWEtPcHgwdkpBM3F4T01U?=
 =?utf-8?B?SDNkNlo1amVCcERYY3ZsWnZPYzh3aU94MS8rd1hBWDBMM2toQU1qakxzdzI3?=
 =?utf-8?B?a0Z4eTFvbS9rQmtkQk5HdytUdXJ3ZFJ4cWVJaDNzMmhrNlZneWd1L1BiYk0z?=
 =?utf-8?B?aVNzUDZWL3dSN3JXLzBOblptOWRjV3NHTUVVRitCczhUQ29HUDYvdldJa2Fx?=
 =?utf-8?B?MllRbHplK3NZZzN4RFUxUkVkYjZDS0JUU3MzRkxSdVllVFFUQXI1KzZENkJx?=
 =?utf-8?B?OVZpdUJUaEVsSnFVakRGd2pPcGd3dUlpUkRZbjlPL3FUcmRIeW1KMkplSUxu?=
 =?utf-8?B?Vi91MFJJVlJMMzNlMTJ6V200VW9zM3hmWkNoaFhMV0YzVTVKeFF2bDI1Mk9Y?=
 =?utf-8?B?U09pMGNVeExhN1NTWWJSall2SlBiSWhjNHlCaStpQlB1b3Q4T2VPcU9hUWFN?=
 =?utf-8?B?NzVUZSs5ZmhOTWY2K1cwZytVbUhXRFpkTXZFZGVPZ3QxUmpMUGVzZDhXVG1j?=
 =?utf-8?B?RkROdmlYRjRkZ2QvWWU5OHZFbm9obGxuVnhHU01IK2NzTkp3VjVNNDJ2dXFV?=
 =?utf-8?B?VTloSmVPdFRWUU5EUC9VK1l5YmNhYzB5ck1kTGVsU3djdjNoNUhRRmh5a3pR?=
 =?utf-8?B?OWNLUmxyY0hHem9KREZOaXplRnJlT2ZvYTVaTHk3dS9CQVhSVFo3dklYdC9V?=
 =?utf-8?B?TDVJeEJpa2RSUHIzUjJtL3lzeXlLVVFPb1c0YnpMajZvdjl0UzJQTHBlcllp?=
 =?utf-8?B?ZnRwSnNkRjJoZDF6QUVnbnFkMFNLT2VTY3ErODRVQlcrSmpSNGpFOUdIa1hE?=
 =?utf-8?B?U1F1SzRMMkR6Yk9SUzVPSEFMeUc0N2h3Rk4zYTZpclJwU2NwUnN6ZjFjWjdR?=
 =?utf-8?B?SytZK1VrM0RMd21CaUZ6dG1wSndibVdDdlFDU3RxZmlWMDRRNGZSYXYvby9Q?=
 =?utf-8?Q?hxQ2P+R2LOpc53352nXS107ehg3QVpC3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 04:46:29.3822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc12046c-28cc-40b9-f995-08dcaf896972
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615

Hello Chuyi,

On 7/29/2024 9:11 AM, Chuyi Zhou wrote:
> Currently when a parent cgroup disables psi through cgroup.pressure, newly
> created child cgroups do not inherit the psi state of the parent cgroup.
> 
> This patch tries to solve this issue. When a child cgroup is created, it
> would inherit the psi enabled state of the parent in group_init().
> Once the enable state is found to be false in the css_populate_dir(), the
> {cpu, io, memory}.pressure files will be hidden using cgroup_file_show().
> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>   kernel/cgroup/cgroup.c | 21 +++++++++++++++++++--
>   kernel/sched/psi.c     |  4 ++--
>   2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index c8e4b62b436a4..775fe528efcad 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1719,6 +1719,24 @@ static void css_clear_dir(struct cgroup_subsys_state *css)
>   	}
>   }
>   
> +static int populate_psi_files(struct cgroup_subsys_state *css)
> +{
> +	struct cgroup *cgrp = css->cgroup;
> +	int ret, i;
> +
> +	ret = cgroup_addrm_files(css, cgrp, cgroup_psi_files, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (cgrp->psi && !cgrp->psi->enabled) {
> +		for (i = 0; i < NR_PSI_RESOURCES; i++)
> +			cgroup_file_show(&cgrp->psi_files[i], 0);
> +	}
> +
> +	return ret;
> +}
> +
> +
>   /**
>    * css_populate_dir - create subsys files in a cgroup directory
>    * @css: target css
> @@ -1742,8 +1760,7 @@ static int css_populate_dir(struct cgroup_subsys_state *css)
>   				return ret;
>   
>   			if (cgroup_psi_enabled()) {
> -				ret = cgroup_addrm_files(css, cgrp,
> -							 cgroup_psi_files, true);
> +				ret = populate_psi_files(css);
>   				if (ret < 0) {
>   					cgroup_addrm_files(css, cgrp,
>   							   cgroup_base_files, false);
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 020d58967d4e8..d0aa17b368819 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -180,7 +180,7 @@ static void group_init(struct psi_group *group)
>   {
>   	int cpu;
>   
> -	group->enabled = true;
> +	group->enabled = group->parent ? group->parent->enabled : true;

Since this is only the init path, if the user later enables PSI
accounting for a parent, should it not re-evaluate it for the groups
down the hierarchy?

Looking at "cgroup_pressure_write()", I could not spot it calling
"css_populate_dir()". Should it not walk the hierarchy and do a
"cgroup_file_show()" considering the changes in you patch?

(P.S. I'm not too familiar with this piece of code so please do let me
  know if I missed something obvious)

>   	for_each_possible_cpu(cpu)
>   		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
>   	group->avg_last_update = sched_clock();
> @@ -1114,8 +1114,8 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
>   		kfree(cgroup->psi);
>   		return -ENOMEM;
>   	}
> -	group_init(cgroup->psi);
>   	cgroup->psi->parent = cgroup_psi(cgroup_parent(cgroup));
> +	group_init(cgroup->psi);
>   	return 0;
>   }
>   

-- 
Thanks and Regards,
Prateek

