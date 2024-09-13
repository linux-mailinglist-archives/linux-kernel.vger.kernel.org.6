Return-Path: <linux-kernel+bounces-327922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D17977CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0311F263D1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B37C1D86C4;
	Fri, 13 Sep 2024 09:57:36 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C31D7E42
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221455; cv=none; b=TBBqgkJfck/V9xz8y8IEAGsk5vcoh8tRro6/GSZs/mKeLrIvlOgzDtg+eVfrxcjHYvLSspwbJ0+jprwMPGID39Tje/ZfRJoJf4HomOmxp86wQRZPSoY5ER5+0i080zHqogyyMEB3dQZ2WjRhNlRYt05Sath0IuA3Bnh1OKlt/hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221455; c=relaxed/simple;
	bh=wQ8+QXv/Zotz6sPCe1Tr3v8Fb8/Ka826oQpsymIlEN4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=QCiJzOm+ZxPv7+aYRyTKl4tgGZXUKk3eGk+3Ev3ILm/B0KvBUfTwR0WB3kTX1EkESMy83OxPkopEw3BYc312v27n87RjsOk/Px6L0tEZZ7fBCnKfJXyt7mwyrq7xZo+ZecZdgUVB4vTyWtFaJE9FL/a5YS0T7O15UKpEL6B6fSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X4qTk1fNhz2CpcZ;
	Fri, 13 Sep 2024 17:56:58 +0800 (CST)
Received: from kwepemd500019.china.huawei.com (unknown [7.221.188.86])
	by mail.maildlp.com (Postfix) with ESMTPS id 1927718001B;
	Fri, 13 Sep 2024 17:57:30 +0800 (CST)
Received: from [10.67.109.61] (10.67.109.61) by kwepemd500019.china.huawei.com
 (7.221.188.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Sep
 2024 17:57:29 +0800
Message-ID: <a316316a-f828-3a51-f6eb-18a31c8b4c35@huawei.com>
Date: Fri, 13 Sep 2024 17:57:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] sched: Remove the check on the return value of
 sched_update_scaling()
From: zhengzucheng <zhengzucheng@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>
References: <20240812120819.1083687-1-zhengzucheng@huawei.com>
In-Reply-To: <20240812120819.1083687-1-zhengzucheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500019.china.huawei.com (7.221.188.86)

Friendly ping. Any more question about this patch?

在 2024/8/12 20:08, Zheng Zucheng 写道:
> sched_update_scaling() always returns 0, so there's no need to check if
> sched_update_scaling() was successful.
>
> Fixes: 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs")
> Signed-off-by: Zheng Zucheng <zhengzucheng@huawei.com>
> ---
>   kernel/sched/debug.c | 3 +--
>   kernel/sched/fair.c  | 4 +---
>   kernel/sched/sched.h | 2 +-
>   3 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 845b79238398..87c683c8635f 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -188,8 +188,7 @@ static ssize_t sched_scaling_write(struct file *filp, const char __user *ubuf,
>   		return -EINVAL;
>   
>   	sysctl_sched_tunable_scaling = scaling;
> -	if (sched_update_scaling())
> -		return -EINVAL;
> +	sched_update_scaling();
>   
>   	*ppos += cnt;
>   	return cnt;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index efb2b3062179..b3d79b693021 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -954,7 +954,7 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
>    * Scheduling class statistics methods:
>    */
>   #ifdef CONFIG_SMP
> -int sched_update_scaling(void)
> +void sched_update_scaling(void)
>   {
>   	unsigned int factor = get_update_sysctl_factor();
>   
> @@ -962,8 +962,6 @@ int sched_update_scaling(void)
>   	(normalized_sysctl_##name = sysctl_##name / (factor))
>   	WRT_SYSCTL(sched_base_slice);
>   #undef WRT_SYSCTL
> -
> -	return 0;
>   }
>   #endif
>   #endif
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 9373426d5aae..d8319e58a0c6 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2054,7 +2054,7 @@ static inline void update_sched_domain_debugfs(void) { }
>   static inline void dirty_sched_domain_sysctl(int cpu) { }
>   #endif
>   
> -extern int sched_update_scaling(void);
> +extern void sched_update_scaling(void);
>   
>   static inline const struct cpumask *task_user_cpus(struct task_struct *p)
>   {

