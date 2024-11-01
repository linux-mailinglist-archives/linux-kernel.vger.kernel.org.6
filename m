Return-Path: <linux-kernel+bounces-392002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5DE9B8E7A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558C71F25A8B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004631598F4;
	Fri,  1 Nov 2024 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FlIy/8L0"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5191814D70F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455203; cv=none; b=N04gcvNZoxckITaPZpeXvLuN6TBxsV9FnHbrmTnCB+coj1eGRvqI/Bu1WoLlBe2SB6YRjmbWT/f7Gy49mUFQIvjabkFsUWgxi5UpIPfA3iSAJPcT0nbeWpeWV3287teK5hYjsrT8kVkqWEy8Uj2nwXQ9amBI1wFp+7iEerGG7TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455203; c=relaxed/simple;
	bh=ZkIHuit9XH/WbkdUw4J0iAuXlse9CJHtPB9iDLM0soo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAWA57WYm3ET78iyQ2oSoEojoFNyqx1cwjg7bb6GR1GdO99zaURI1OITGtStE4womxjopKMs9j+zyOwZQAn5NI+dRcYoIoVY0Wd5fRyc1qh5NpR4VPhxfeu5FlylZREIDLmq/wbtMR3lnrqayk8vDI2k8IiHhJ2jiPLSVwYQiU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FlIy/8L0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d533b5412so1074608f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 03:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730455198; x=1731059998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kCMYxsENI5KzW+rkth2c1UykDj87pqP/pFjISR1rPF0=;
        b=FlIy/8L0sfKqvUXy3lvLzupC8nboS0ldmM0VdAMLYCYe+CkMzxceUqMuNNrifBpTDh
         BQoW+BTg+f8Ic6KuCg6gUBqLzDO+v/krXH3Glmf6prBtauSGuN+JO0vb7kTXq5Jgxp33
         KzUtLIie66NGhuD+1AP46+GnKaDLcr7WXLbn9X3pu6KZBeV0gkG4OnBYNPi2zb7ySjST
         3VS4NiR1yUJjvM32Px5v2rzJjXud9z7a48wn3jMvlP8uwKUYFo688+AV+R0k6qwnGdBC
         AmF0EBs2xzlT7r4+75AN+K9cg4ZwUOdgfCfRCMJFxeVEJOd0mW99GKr96qxzDD/HfbPj
         ozWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730455198; x=1731059998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCMYxsENI5KzW+rkth2c1UykDj87pqP/pFjISR1rPF0=;
        b=l9HikBRG10muVMQwvd2rg3rvtX0sF7hWSqVyRC3A0l8Bt9/Msk9Okx2Iaf1mMb6S4Z
         S4K8AW43m8qRHqhZQEAzM1gHZmYsDdf1FOMx5Jzvz7CO0En0q6U0/lHs2KpJNgtthBIC
         dTmAQuKfc29UoumMEQNDDpi8OJC248E0BQKA1F91MUcOOVzmsap6tdXpBPlp1TxXZ04a
         GRcCznri5Tv8k0bbgwvNClpBXwchG72YMRtYwwZOZOeRivYEQeXgsCOFOqow5NMXcXsV
         61/w302C1ukDlkEZhUwrYec2XWdH7eiZCN5rjJXVU/SMy3GpRW+QO9qoQ/0MB3BCb6gr
         Xjmw==
X-Forwarded-Encrypted: i=1; AJvYcCUcA5ux454tgy63MpBTPwQbKwmioa1jUx+2eB/wWQbeZkQSVPpJLBtqtQyOvsH90bGCD5uexfwDbWsWk9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBPfjJ8Y9S1End5UEIzczuqnzHZzVe4MeXw16Mtex8WkB7pXOG
	nXxLCJeeQzlKXRpiAawoEor97qGIPlFCAg05WTOGRYzAjImBy1Ms5wnm4af/K+s=
X-Google-Smtp-Source: AGHT+IHPedYLVwzy/bVIibNk6iPvacu9rvmCe3Ib1wQ1oV/5dOpF8xEpg5pq4bozzuGmgbu3MZNKhw==
X-Received: by 2002:a5d:6a51:0:b0:37d:5301:6edb with SMTP id ffacd0b85a97d-38061221e7bmr14762555f8f.57.1730455198581;
        Fri, 01 Nov 2024 02:59:58 -0700 (PDT)
Received: from [192.168.0.17] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c11898easm4569503f8f.117.2024.11.01.02.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 02:59:58 -0700 (PDT)
Message-ID: <a7975bd0-8593-4ecc-91d4-cbf2113037f4@linaro.org>
Date: Fri, 1 Nov 2024 09:59:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] media: venus: Fix pm_runtime_set_suspended() with
 runtime pm enabled
To: Jinjie Ruan <ruanjinjie@huawei.com>, sakari.ailus@linux.intel.com,
 mchehab@kernel.org, ming.qian@nxp.com, eagle.zhou@nxp.com,
 stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
 shijie.qin@nxp.com, hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: chenridong@huawei.com
References: <20241101094050.2421038-1-ruanjinjie@huawei.com>
 <20241101094050.2421038-4-ruanjinjie@huawei.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241101094050.2421038-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/11/2024 09:40, Jinjie Ruan wrote:
> It is not valid to call pm_runtime_set_suspended() for devices
> with runtime PM enabled because it returns -EAGAIN if it is enabled
> already and working. So, call pm_runtime_disable() before to fix it.
> 
> Cc: stable@vger.kernel.org
> Fixes: af2c3834c8ca ("[media] media: venus: adding core part and helper functions")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2:
> - Add Cc stable.
> ---
>   drivers/media/platform/qcom/venus/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 84e95a46dfc9..cabcf710c046 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -412,8 +412,8 @@ static int venus_probe(struct platform_device *pdev)
>   	of_platform_depopulate(dev);
>   err_runtime_disable:
>   	pm_runtime_put_noidle(dev);
> -	pm_runtime_set_suspended(dev);
>   	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
>   	hfi_destroy(core);
>   err_core_deinit:
>   	hfi_core_deinit(core, false);

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

