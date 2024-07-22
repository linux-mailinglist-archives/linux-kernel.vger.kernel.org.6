Return-Path: <linux-kernel+bounces-258426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A874B9387CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 05:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644A4281650
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 03:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA611401B;
	Mon, 22 Jul 2024 03:47:44 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94333D6D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721620063; cv=none; b=IUiAbOkJ2t9I47hm1FbZelGfrnHHDhI6vE8TTcgHwKM0v8qoR10YvQK96sE0ARHudNfGKvX3eHLrm75cYaLvLj6MojnkKRzTFW23Bk8gFDU+Yynq9Pa6DOZHML81C5zELc2ST4xLI8I1T/72d79huPmUyT4pcz2NwftU0kJ+Suo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721620063; c=relaxed/simple;
	bh=ib40NOBPYchrL4HHKAn3glH/jgQ6UCRPdzzwLhumC10=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Aji/FkPdPYOnr7q6VLlVPPNiUL4/SU271Od18cCl8R6GuYajZWjTXjx6ZXWxLdwwYTXlunTjMixCoTCi0odiePtOWuatNtE2NxQWE9wILfqOF2hd/+xlWRD141YqihK3l5dBFFFb0tdUJNXa3qN2VfFi8pJenpj64/ecJ96FLOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WS5ly6Wrtzdjbh;
	Mon, 22 Jul 2024 11:45:50 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id E72C31800A1;
	Mon, 22 Jul 2024 11:47:36 +0800 (CST)
Received: from [10.45.191.75] (10.45.191.75) by kwepemg200007.china.huawei.com
 (7.202.181.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Jul
 2024 11:47:35 +0800
Message-ID: <91e88019-52f7-4fa6-a14b-ca5ecb8e63cf@huawei.com>
Date: Mon, 22 Jul 2024 11:47:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/fair: Decrease cfs bandwidth usage in
 task_group destruction
To: Chuyi Zhou <zhouchuyi@bytedance.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>
CC: <chengming.zhou@linux.dev>, <linux-kernel@vger.kernel.org>,
	<joshdon@google.com>
References: <20240721125208.5348-1-zhouchuyi@bytedance.com>
 <20240721125208.5348-2-zhouchuyi@bytedance.com>
From: Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <20240721125208.5348-2-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200007.china.huawei.com (7.202.181.34)



Hi, Chuyi

在 2024/7/21 20:52, Chuyi Zhou 写道:
> The static key __cfs_bandwidth_used is used to indicate whether bandwidth
> control is enabled in the system. Currently, it is only decreased when a
> task group disables bandwidth control. This is incorrect because if there
> was a task group in the past that enabled bandwidth control, the
> __cfs_bandwidth_used will never go to zero, even if there are no task_group
> using bandwidth control now.
> 
> This patch tries to fix this issue by decrsasing bandwidth usage in
> destroy_cfs_bandwidth().
> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  kernel/sched/fair.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b1e07ce90284..7ad50dc31a93 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6447,6 +6447,9 @@ static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>  	hrtimer_cancel(&cfs_b->period_timer);
>  	hrtimer_cancel(&cfs_b->slack_timer);
>  
> +	if (cfs_b->quota != RUNTIME_INF)
> +		cfs_bandwidth_usage_dec();

This calls static_key_slow_dec_cpuslocked, but destroy_cfs_bandwidth
isn't holding the hotplug lock [1].

For fixing this issue, i also sent a patch, but it be not merged into mainline [2].

[1]: https://lore.kernel.org/all/20210712162655.w3j6uczwbfkzazvt@oracle.com/
[2]: https://lore.kernel.org/all/20210910094139.184582-1-zhangqiao22@huawei.com/

Thanks,

-- 
Qiao Zhang.

> +
>  	/*
>  	 * It is possible that we still have some cfs_rq's pending on a CSD
>  	 * list, though this race is very rare. In order for this to occur, we

