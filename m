Return-Path: <linux-kernel+bounces-267118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC98D940CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A2AB26202
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D712194128;
	Tue, 30 Jul 2024 09:02:42 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BBF442C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330162; cv=none; b=DCr0k8X9gPXtpzBWxMfaaKMAa44ZxJZKvsbT2ImaFEiPQQ4RKt5KUoPMQCMToP5t3+FDvICwNKtPVKfUJ0U2GnFTMRQmK4ePjWJHDOi3kpZUZxFJ0E5xG6zrtNLYBZ2rLWyMcwYxW/ObvtV9f8Kz0y+Cuy2ND0P5dUzBD20tdE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330162; c=relaxed/simple;
	bh=haamtbP7P1AS05UpaIZRbA3fAGQeOlmNGOHrR7ugnLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WVUnGGCVHVncd1kx7PSjsBWrT7h+3ZpvGRx4teiIlUOwLpqWzrVt2ouS7QbPzLzLEXTOxWpC/OZ/X/puILnF55mFPsnyL0flV5XiUFTgkIWzzh7tGHIrIExcgoRE+xmsrJugCUtltOsiupm4WdhM2Iqc7dfaacZO8faC37wbJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WY8JP0rmJz2Clb0;
	Tue, 30 Jul 2024 16:57:57 +0800 (CST)
Received: from kwepemd500019.china.huawei.com (unknown [7.221.188.86])
	by mail.maildlp.com (Postfix) with ESMTPS id AB4F51A016C;
	Tue, 30 Jul 2024 17:02:29 +0800 (CST)
Received: from [10.67.109.61] (10.67.109.61) by kwepemd500019.china.huawei.com
 (7.221.188.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 30 Jul
 2024 17:02:29 +0800
Message-ID: <2c7d8983-2004-4886-32b2-93091a0c0679@huawei.com>
Date: Tue, 30 Jul 2024 17:02:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] sched/fair: Correct CPU selection from isolated domain
To: wujing <realwujing@qq.com>, <mingo@redhat.com>, <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <dongml2@chinatelecom.cn>, QiLiang Yuan
	<yuanql9@chinatelecom.cn>
References: <tencent_E2C5C1A1B50F453656C6C7FB140CD3AFB305@qq.com>
From: zhengzucheng <zhengzucheng@huawei.com>
In-Reply-To: <tencent_E2C5C1A1B50F453656C6C7FB140CD3AFB305@qq.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd500019.china.huawei.com (7.221.188.86)

it has already been addressed by the following patches in tip/sched/core:

8aeaffef8c6e ("sched/fair: Take the scheduling domain into account in 
select_idle_smt()")
23d04d8c6b8e ("sched/fair: Take the scheduling domain into account in 
select_idle_core()")

在 2024/7/30 15:10, wujing 写道:
> We encountered an issue where the kernel thread `ksmd` runs on the PMD
> dedicated isolated core, leading to high latency in OVS packets.
>
> Upon analysis, we discovered that this is caused by the current
> select_idle_smt() function not taking the sched_domain mask into account.
>
> Kernel version: linux-4.19.y
>
> Signed-off-by: wujing <realwujing@qq.com>
> Signed-off-by: QiLiang Yuan <yuanql9@chinatelecom.cn>
> ---
>   kernel/sched/fair.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 09f82c84474b..0950cabfc1d0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6171,7 +6171,8 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
>   		return -1;
>   
>   	for_each_cpu(cpu, cpu_smt_mask(target)) {
> -		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
> +		if (!cpumask_test_cpu(cpu, &p->cpus_allowed) ||
> +			!cpumask_test_cpu(cpu, sched_domain_span(sd)))
>   			continue;
>   		if (available_idle_cpu(cpu))
>   			return cpu;

