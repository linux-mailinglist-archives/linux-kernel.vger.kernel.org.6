Return-Path: <linux-kernel+bounces-336507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869D9983B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AC91C22070
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3CC1BC20;
	Tue, 24 Sep 2024 03:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E7jlnefV"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0501B85D0
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 03:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727149262; cv=fail; b=nLH/qzDXNgkSP5h+NlXp7Gez7wMFst/I/elN8gPFyVHYwtuGSF/fsh8/6/HvKtkn/wZv3HXBOzutQCKELHn8RP8o5T400tSj0oF8itE6ydPN85g+HqK7NK7Er1+Syni8rU9Y81R5dO7f6ZFpN2n2RylJh4gSa05Mco6hI7YF+9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727149262; c=relaxed/simple;
	bh=geQ1TIW+ncIPRNsTshQvW2plQXmZ7tgVXGwEAispYCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j5UBZaR2DrF/BKz9YsDhdTSHXbUHQchzaETcmCX08Uu1LBd7SSquvOpL8R96D+9U+Z5uWoeRl3zqmf3M7dRyQnaa4DRCrgOzf4OIzVE0CPkyyv4whuLVja/8KVvTvKqQgDWKEqbraIYAAvjJaBS3TieMMqU6y/HJXXQhoo6PWO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E7jlnefV; arc=fail smtp.client-ip=40.107.212.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3VGv/iBGAZJ8CLeme21H8yXkylR8U2arA19GW3gf/lZkmurGOaZzuiVr8PzAY/nivPUI4k9hMZgSQOFVbPV0WFCx22vTbONrK8BD2UFgHeaL/wfkVr6CqZKl2y/s9+1EhVY/vfmrnvo4SUImdZooQK+IDC9Ow/twcqb4oMg9QuK7RIiMBAIm2gSl+XN9ecqJJWh6v1uZSb5p21E46BFUDznCoqYjLBj0NJpNHIYgbz4qVYFUkoaeB/RVHUZboKRgU+pJ2at60laTImiBNojDYlnKtZrlq3Mg08vTwLYsKBO5yM3qFyL5JBvoviCJA+cavUUa7o2lXjaFoxHtvQ2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isHh1p9hDN5fR/PrBnjH2zkk1ngv1KfEE87sjsas5f0=;
 b=hfTqqaSmvoRG0ieWFy50Iu7bpSuDkntpJq4KAYraGhw8EllZwt1IlLUe34A9xmtTxuNPeVPplviYhnuhrrCiZ5pwqpnM2RA/PRy8npl/auRPyRuhwYkaHkvpzmeMp/rSw+ORxRkYw/HcKuHtF+gGcBeGkFba0xu2N26zk/jF7UObW5htA/ZPsMUtfojYK77P3n3bwT18RFcrxcEX7WMLVrVdnW88RpmtETuJxVMCU/+tJ229R7x8s32odjueh4mPu61O9DWRxJ6tdcm9AHEHWutY+O9QTZo4sSJJnqTiSznBE0P+CRwj1z9jGVuzkV+5n1frjgISQklMU9APCyacMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isHh1p9hDN5fR/PrBnjH2zkk1ngv1KfEE87sjsas5f0=;
 b=E7jlnefVPvtrBjYh7+FbH+vxmwCL/YLGM5DpZVJ8OLA8cNtrAFVm0hnaqq+HSMaENu/jxVv8EFrz0vvPg1f6wT2ipF7WjemX3FrLgFKtTuCcga4lztrRB4dzQ/MqsnqqJlx8cwPE6NBcGntI1hrtW6cj0GAon5GXcw++/l4z6X4=
Received: from SJ2PR07CA0005.namprd07.prod.outlook.com (2603:10b6:a03:505::29)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 03:40:56 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::1b) by SJ2PR07CA0005.outlook.office365.com
 (2603:10b6:a03:505::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27 via Frontend
 Transport; Tue, 24 Sep 2024 03:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 24 Sep 2024 03:40:56 +0000
Received: from [10.136.36.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Sep
 2024 22:40:05 -0500
Message-ID: <3e6fdedc-a87c-ff8a-a75c-5c1282a122b5@amd.com>
Date: Tue, 24 Sep 2024 09:10:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH sched_ext/for-6.12-fixes] Disable SM_IDLE/rq empty path
 when scx_enabled
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
CC: <void@manifault.com>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <sched-ext@meta.com>, <peterz@infradead.org>, Pat
 Somaru <patso@likewhatevs.io>
References: <20240920194159.158152-1-patso@likewhatevs.io>
 <ZvGMjn1Va3aNbieH@slm.duckdns.org>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZvGMjn1Va3aNbieH@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: d7bd99bf-756c-431b-4fbb-08dcdc4ab2c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3djOWNSbC9TK0JXSlU5Wmw2Q3ZHc3h0azRXemF0V0xHRTBkYnhWdThxemt2?=
 =?utf-8?B?b1U0Uk5IU1hsQ2VpS09aUG44UE1GbTNHTEtaTU5PK3hYRGlZNGZNQ3RqWmRu?=
 =?utf-8?B?dkordUhHQ2ZreVR3Uk5nZlVpdU9PdWcwbEorTGdJZDF0UFhLV2pKZitCY1Fa?=
 =?utf-8?B?YitxT0JsdzY3VE0ycDg0S01TalB4OGZsRmk4SHFXRjdnbmROTzh4VXp4M1JO?=
 =?utf-8?B?VlpxTGtGMnRSelltMFJjZ1d0WkZsQVVuL05aZ2IxNURZZGg0eldobXpaYmRK?=
 =?utf-8?B?eHJsT1NFYXFZeTVwQmxDc09iM0RjUUFFdjBOYVpUT1hkWTMrUEFCWEhaWSs2?=
 =?utf-8?B?ZWlBdTB2ajRBNzd2alVvbnJnWEE2MDlyZ2ZIaGNpU0tBQVpsZE5qek50ODNU?=
 =?utf-8?B?WnhpK3Z5Z3JrSjRhUWN4dlpNUzZ3TnF2OTBaQSt6TXF1Z2RmSis2ekFRTkcw?=
 =?utf-8?B?SnM0dmprc2tZc1BXbXZaWUQ4K0ZnUk9NVVdBekxUN1FMWlVRdWl4WWZudWw0?=
 =?utf-8?B?VWxWWnk0L1FoWGw1YlFITjVwSlZKUU44ZjRCalF2VDBPQzZSb0oyMWxOb1lk?=
 =?utf-8?B?RE9vZ0tGcFNjMGxWc0k3Qm0rbVcwWXNRN3NvdXBzZlVvb1ZBYW9RVlZRMXA1?=
 =?utf-8?B?K0dGVHJWdzRIeURBN3NHd1k2a0QxeTFkNWpiYjJDc3pYdXpJYlhKTWVCcXRj?=
 =?utf-8?B?QmVYRWkxeGFNNnFaR1MxR0h1a2dlc0Nha0hTcURhMU5zV1lBblFOd0JuMW0v?=
 =?utf-8?B?K1k3THgyUjNVSGNSeFBNVkVuR0lJZFNSRlF4K1Y2TGVlb20zYktsc1lOemNi?=
 =?utf-8?B?MWVBWXRxVDN0WHpaSmRtMVFUM1lPQXFFVDlvTm4rNlNyU0Z1cThOLyt2ZlpC?=
 =?utf-8?B?Ujh1TjlwS0xXUm9UYVU4ZmQ4MlAxQXh1Nm1BZnBlQURRMGNKNjJINW5lOU5G?=
 =?utf-8?B?ajhzRFNjZUpzYUJFSlk0YVVkQnB5dnBaU1pYNUNHb1JxeURpV3FEemdUV0x4?=
 =?utf-8?B?YUlIazc3ZnVaUkxaWC9nS3pkbUtIVjNxcG45cWRMSHo1UDNzUzY3eFgyYTJO?=
 =?utf-8?B?S0x5RC8yK1IzMERIRlluSUFGeEhuNm1RMEZMcDlBQ01IQW5hcnYzYXI1YzUy?=
 =?utf-8?B?QjZqZ3ZQbWZkWi8vR3l6UGpOL2pxT05TWVVscnZkVzloZmlCbXZPSHNJRUJB?=
 =?utf-8?B?Tzh0RlFibGZ0T0ptcmwzd2hhK0NVdGVGVTZMb0FpczlSR056OWpCK0lnT2Zv?=
 =?utf-8?B?NWlLUmQ2bS9BTkJVTlZwSmFxZmhyZjdrQWhkem1vc0drTjVwUGg2WSs5QW1Q?=
 =?utf-8?B?c2hGVWF3YUMySUM3Wmg4bUtMUXBKdlh0R3dIQnpZNGZoRUh3QzN6MU9NWkRP?=
 =?utf-8?B?S0ZzZkdBaGRKMmxtbzFNM0YvV1RPbXlJQUoyWG9RbkNqTm9McFFqWUpqWFYv?=
 =?utf-8?B?ODlrSUVmSTVpbW1mYkxrbHlicGw2NVIwWTJiS05nK1d0dG01UEg2cEY0c3Jp?=
 =?utf-8?B?Uzl2WnFtNW1mbHFjaElpWGkzYUV1ZFMyMU9Ub1VlamVWeWVEUFY4amFSd2Zi?=
 =?utf-8?B?TUhVL2F4bEQ0ajNxMHV0NGEvUDg0KzhVUkNhQ0MzaW0vT2JqWlpUTzUrREVW?=
 =?utf-8?B?M1J5NlA3SHhFNDVoN1NobksrNTlCZHVxeitQSkRXWEtoMzkwRUdRbEJwNm10?=
 =?utf-8?B?WEZ2VFMyMEdZZFBOZzF5Y0l5RFpIKzh5SlhHd0dhMmxLQ21NS2pnNS9ja1li?=
 =?utf-8?B?VEN6RlRnOHpQc1pwdU0zc0htNm5zWHhCbWMzd3U5a3FXL3RKb2pKTW1XeVlO?=
 =?utf-8?Q?yifDZx6C9sLLmY4IRQ8j7IlCzPbbe6o2QapAw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 03:40:56.3262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bd99bf-756c-431b-4fbb-08dcdc4ab2c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068

Hello Tejun,

Just seeking some clarification here; the reasoning to bypass SM_IDLE
fast-path looks sound otherwise.

On 9/23/2024 9:13 PM, Tejun Heo wrote:
> Applied to sched_ext/for-6.12-fixes with minor edits:
> ------ 8< ------
>  From edf1c586e92675c4e0eb27758fcdb55a56838de1 Mon Sep 17 00:00:00 2001
> From: Pat Somaru <patso@likewhatevs.io>
> Date: Fri, 20 Sep 2024 15:41:59 -0400
> Subject: [PATCH] sched, sched_ext: Disable SM_IDLE/rq empty path when
>   scx_enabled()
> 
> Disable the rq empty path when scx is enabled. SCX must consult the BPF
> scheduler (via the dispatch path in balance) to determine if rq is empty.
> 
> This fixes stalls when scx is enabled.
> 
> Signed-off-by: Pat Somaru <patso@likewhatevs.io>
> Fixes: 3dcac251b066 ("sched/core: Introduce SM_IDLE and an idle re-entry fast-path in __schedule()")
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>   kernel/sched/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b6cc1cf499d6..43e453ab7e20 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6591,7 +6591,8 @@ static void __sched notrace __schedule(int sched_mode)
>   	 */
>   	prev_state = READ_ONCE(prev->__state);
>   	if (sched_mode == SM_IDLE) {
> -		if (!rq->nr_running) {
> +		/* SCX must consult the BPF scheduler to tell if rq is empty */

I was wondering if sched_ext case could simply do:

		if (scx_enabled())
			prev_balance(rq, prev, rf);

and use "rq->scx.flags" to skip balancing in balance_scx() later when
__pick_next_task() calls prev_balance() but (and please correct me if
I'm wrong here) balance_scx() calls balance_one() which can call
consume_dispatch_q() to pick a task from global / user-defined dispatch
queue, and in doing so, it does not update "rq->nr_running".

I could only see add_nr_running() being called from enqueue_task_scx()
and this is even before the ext core calls do_enqueue_task() which hooks
into the bpf layer which makes the decision where the task actually
goes.

Is my understanding correct that whichever CPU is the target for the
enqueue_task_scx() callback initially is the one that accounts the
enqueue in "rq->nr_running" until the task is dequeued or did I miss
something?

> +		if (!rq->nr_running && !scx_enabled()) {
>   			next = prev;
>   			goto picked;
>   		}

-- 
Thanks and Regards,
Prateek

