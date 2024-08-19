Return-Path: <linux-kernel+bounces-292081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4307956AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35C39B25911
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEDC16C6B6;
	Mon, 19 Aug 2024 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NTB8Kn2k"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF116848F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070337; cv=none; b=eKYW7VP0/tznlOiNWDFWskFkZXAGr0t4/uD8nVNd+4bJ9q1YWJsmlMNpsAffRhpY7WD58c1LAFvG1IrmqZ4tFh8VboE74TEUN+yLzHez66AwA2JpjThhl/4thL8YFjVASIa6J+nAc53m/wvLvIt3/DFGTDbGQT3bv0C/3e7UVwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070337; c=relaxed/simple;
	bh=k5o4y5VSo0c8GejdI87IOdeqQN5MXNRusNn7egeiFSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QA7gROP/i2iUbmMXkaJn9HSNByAjvl3Ym13JEG7LMAHMyCaMLKb233mA7BLfUf5Tu10oVP0s5PSsnZPuvGsHmytwgnxmYFZCBZzp8PBlaztlhCWq3l0z/rQgmkveAsjaMe4c7UXCvZLQmMyPO7WllD0eYWeZTrxpjXfrAF6hS24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NTB8Kn2k; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724070332; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=k4kNH4THhZ5Nwg8AiZRRkhfef0lufAmi3R+L4j9cBb4=;
	b=NTB8Kn2kR4roFj6SJmmUsoaxnEHJ/bLS27OgLwuBMvUi01DuBfcsUQi86ymLoB1bZsrS9V8kh7pjTJC8bZLSqllHhyA3JiZ5zNkTY1KI8u8jjcOgFMGJvtNUFIULAuFYj2cfe8ujSf8FeiFBKgFbke31M8n4JA4Z6LMH8ru4F0g=
Received: from 30.246.160.136(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WDCu7VX_1724070330)
          by smtp.aliyun-inc.com;
          Mon, 19 Aug 2024 20:25:31 +0800
Message-ID: <601bf843-94c7-49f7-8fa3-536a118b4ae0@linux.alibaba.com>
Date: Mon, 19 Aug 2024 20:25:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/perf: Fix ali_drw_pmu driver interrupt status
 clearing
To: Jing Zhang <renyu.zj@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>
References: <1724068110-45239-1-git-send-email-renyu.zj@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <1724068110-45239-1-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/8/19 19:48, Jing Zhang 写道:
> The alibaba_uncore_pmu driver forgot to clear all interrupt status
> in the interrupt processing function. After the PMU counter overflow
> interrupt occurred, an interrupt storm occurred, causing the system
> to hang.
> 
> Therefore, clear the correct interrupt status in the interrupt handling
> function to fix it.
> 
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>   drivers/perf/alibaba_uncore_drw_pmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
> index 38a2947..c6ff1bc 100644
> --- a/drivers/perf/alibaba_uncore_drw_pmu.c
> +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
> @@ -400,7 +400,7 @@ static irqreturn_t ali_drw_pmu_isr(int irq_num, void *data)
>   			}
>   
>   			/* clear common counter intr status */
> -			clr_status = FIELD_PREP(ALI_DRW_PMCOM_CNT_OV_INTR_MASK, 1);
> +			clr_status = FIELD_PREP(ALI_DRW_PMCOM_CNT_OV_INTR_MASK, status);
>   			writel(clr_status,
>   			       drw_pmu->cfg_base + ALI_DRW_PMU_OV_INTR_CLR);
>   		}

Yes, it is a bug due to typo.

Thank you.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Shuai


