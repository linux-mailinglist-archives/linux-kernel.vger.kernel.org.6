Return-Path: <linux-kernel+bounces-294802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDB49592AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 04:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCE5EB24EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584F21292CE;
	Wed, 21 Aug 2024 02:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="V+OXngmN"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D5762F7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724206862; cv=none; b=TmEClOnpzvaz0wm3amJX0NVmtaBw0A/UsEqHfWPI8amlHCN/iiVFBC5pj7wKFVjRaT80LAbrpiyDmWCD8dA13SmQ0IxBZQAZdM29d3Ezfprg5g7+GQYvg+NTUMY/gS+H+Ddo2TTy8bPsNe0W9scjhiXO+o9tOflZ0LtTPV46e2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724206862; c=relaxed/simple;
	bh=VKEopUy5uaeVw8EldQJqajHCN45rFu4kFYIxEF8KmgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+GzfCtiRbnjeMYYHnjbYFM9uSCV5aR1V8OVn/LYIhTo/9dOtYUdwZVTwC6CkuZDDMHfuip0k+JMnBuV6Mzr5FAj1DpPXit1PmkojFuzMioPv9GYEDm2Z6b7h2rFiJERGSN4qhnyVV4xpC1zBM0V93yk5VGfnyzkRVIXZBXpkuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=V+OXngmN; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724206857; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fgMs9fxEwK6R86E8GznAkMJVuLhtqjJi/m3zDh7uEHc=;
	b=V+OXngmNeVl9zbvLkBJC7Rl4H/aS+ExPcJXaEdYms+TbJI+i9wGQF6FNaD+WBS4xV21/cxASWdJWuLp2VGq3y6eoQrbyLPKVFfbt+pllHusMo7SYZaDgBwvLgJr9sRJENtjYhSt34f0E2uyK7jd9BIRuqJXF+gXD4RgjlC1ZZaQ=
Received: from 30.15.196.200(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0WDK4yif_1724206855)
          by smtp.aliyun-inc.com;
          Wed, 21 Aug 2024 10:20:56 +0800
Message-ID: <2a70eaa3-f1c5-4803-948b-4b8eb86190c6@linux.alibaba.com>
Date: Wed, 21 Aug 2024 10:20:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/perf: Fix ali_drw_pmu driver interrupt status
 clearing
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Will Deacon <will@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>
References: <1724068110-45239-1-git-send-email-renyu.zj@linux.alibaba.com>
 <ZsRfdn58mPLRIfVk@J2N7QTR9R3>
From: Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <ZsRfdn58mPLRIfVk@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2024/8/20 下午5:18, Mark Rutland 写道:
> On Mon, Aug 19, 2024 at 07:48:30PM +0800, Jing Zhang wrote:
>> The alibaba_uncore_pmu driver forgot to clear all interrupt status
>> in the interrupt processing function. After the PMU counter overflow
>> interrupt occurred, an interrupt storm occurred, causing the system
>> to hang.
>>
>> Therefore, clear the correct interrupt status in the interrupt handling
>> function to fix it.
>>
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> 
> Presumably this should have
> 
> Fixes: cf7b61073e4526ca ("drivers/perf: add DDR Sub-System Driveway PMU driver for Yitian 710 SoC")
> 
> ... right?

You are right, I forgot it.

> 
> With that:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Mark.
> 
>> ---
>>  drivers/perf/alibaba_uncore_drw_pmu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
>> index 38a2947..c6ff1bc 100644
>> --- a/drivers/perf/alibaba_uncore_drw_pmu.c
>> +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
>> @@ -400,7 +400,7 @@ static irqreturn_t ali_drw_pmu_isr(int irq_num, void *data)
>>  			}
>>  
>>  			/* clear common counter intr status */
>> -			clr_status = FIELD_PREP(ALI_DRW_PMCOM_CNT_OV_INTR_MASK, 1);
>> +			clr_status = FIELD_PREP(ALI_DRW_PMCOM_CNT_OV_INTR_MASK, status);
>>  			writel(clr_status,
>>  			       drw_pmu->cfg_base + ALI_DRW_PMU_OV_INTR_CLR);
>>  		}
>> -- 
>> 1.8.3.1
>>

