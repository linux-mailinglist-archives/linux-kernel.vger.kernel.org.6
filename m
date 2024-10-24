Return-Path: <linux-kernel+bounces-379518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AB29ADF98
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C17B21BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57461B219A;
	Thu, 24 Oct 2024 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obQFI0yF"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C05258
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729760375; cv=none; b=pfKj/WHGNEz3sVrR/fwv+Am6zcRNzaxwSWnqE7cCBnY00mZhjXEQreEgsJDp2K9FKVUYU0vbMFRm8TwhW0DAToQQBTaVECE0NrHhBq/X05ktK+jFmdf8jzxfqOJggCAcWeE5z4zKm1cve+hSsj8zKeTzcfkVt78Ipi3rKhM9tVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729760375; c=relaxed/simple;
	bh=Gi55KWZfPe+eJnUbCK4Qcgpau9bd6owVWBYpPQQUefk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvfsTex7Y6TeSjJ1G4u8qWCUQyGQdhBtYVESfV670a9or03eToTP7p45f/A8KxACS7UyA9ukaWxHilOIhBVA/0IlGrFTj1gUTd+96y6Nr49IlW5RXmhIEPaObtGsJs/OWDB+sgkdXBA8Kfrq5oyqza6WKDdb70/Pwe0R/cFfKgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=obQFI0yF; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so1413343a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729760371; x=1730365171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBrtqvck7wdqmorht6mkF0PUhEwWcAVanz6GRI4Rr3I=;
        b=obQFI0yFGg24DywugggEWZLifjUZaVbZWU+75azYMN4p5GFtgvuenM06Ed8IIeFuvv
         ebGZ4J6x6MAijMQyE7wAA1FlKrvzVyycG2DkHcR27W4HF12BJ7j/yjPUVIvBWewVYSgI
         M2Zxa+GVaaLfZOqC53GQDeI2/d6L2JwXaAfAHl5EaCs8O3fMnd3u9PQ+lOnvKn7j3UuJ
         aQLdXj7GH111/JRVTL/pu2aJ30G/y2d21ZGXpFDI0rPuqNeBnTesaOP+RpslNjNBf4M6
         uP/TgTrrgMB1lDnCuwux7c8fMwyw9RCJ+p6CR8I47GV7OgtxteDtbz/qgFc3O0sZ9uoi
         /wfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729760371; x=1730365171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBrtqvck7wdqmorht6mkF0PUhEwWcAVanz6GRI4Rr3I=;
        b=jHFiFTwlpMl3aAqUM9bHFrTC9T8KN6yjp+VA/ninDCdPWbYu4UhmptkwCG5bCvOHff
         qiLu0RvrU1uFGXopP4rIX0mSlhgOBICJK3juExpqXqO9paPlmYbq6G3Y4mYCGYM4lOxo
         4oqbt6Wbve42IF9ZFioDd5ZptFi82OcFaIr2TGFmBl425NB0nVtbwOsjkR0LfdhSCFSH
         4GVdDc4LokSJO2yogQNZ8ShjXgVeq7Hl+GIALuCC5zZEZS4DHlLZg3REcsRsVgiRBDOG
         EE3P+fT5R1qLh0ZaaWpuoVY06+XQl6Fk1mAyW7loH/iFF7wLCqDYRYY7V3j+QcF3s4iv
         MvYw==
X-Forwarded-Encrypted: i=1; AJvYcCWx8OamFJvVff+P7o3xgTssgqplqniaMF6TaQ6sSa5fiDt09ZZhoYt5zGcQxEzP/Krh3Y0EWJwsaQ/kvLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsOAdp/ki3x6jtAHeJaLBGAPHI8t/oU9q8jYhWqFp4J4JzY7fx
	hnJr8l3FqLvPnWI5LPM0iD6YlvctcL2sMs06yUvmaYcXv4s8yrKPd+/6RvHjVL8=
X-Google-Smtp-Source: AGHT+IEUHBtr9xd7QNtcGeqztuujtZH9FU0x+gDQEsYh4kOW5+vhqoePs9KZeWlWvOU4I1gl4Rez7g==
X-Received: by 2002:a05:6402:1e92:b0:5cb:77d1:fd7f with SMTP id 4fb4d7f45d1cf-5cba20217d2mr1399644a12.7.1729760371108;
        Thu, 24 Oct 2024 01:59:31 -0700 (PDT)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c72757sm5414086a12.92.2024.10.24.01.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 01:59:30 -0700 (PDT)
Message-ID: <4b96f1f8-e084-4599-abe9-05039bfac569@linaro.org>
Date: Thu, 24 Oct 2024 09:59:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/2] media: venus: sync with threaded IRQ during inst
 destruction
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241024061809.400260-1-senozhatsky@chromium.org>
 <20241024061809.400260-3-senozhatsky@chromium.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241024061809.400260-3-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/10/2024 07:16, Sergey Senozhatsky wrote:
> When destroying an inst we should make sure that we don't race
> against threaded IRQ (or pending IRQ), otherwise we can concurrently
> kfree() inst context and inst itself.
> 
> BUG: KASAN: slab-use-after-free in vb2_queue_error+0x80/0x90
> Call trace:
> dump_backtrace+0x1c4/0x1f8
> show_stack+0x38/0x60
> dump_stack_lvl+0x168/0x1f0
> print_report+0x170/0x4c8
> kasan_report+0x94/0xd0
> __asan_report_load2_noabort+0x20/0x30
> vb2_queue_error+0x80/0x90
> venus_helper_vb2_queue_error+0x54/0x78
> venc_event_notify+0xec/0x158
> hfi_event_notify+0x878/0xd20
> hfi_process_msg_packet+0x27c/0x4e0
> venus_isr_thread+0x258/0x6e8
> hfi_isr_thread+0x70/0x90
> venus_isr_thread+0x34/0x50
> irq_thread_fn+0x88/0x130
> irq_thread+0x160/0x2c0
> kthread+0x294/0x328
> ret_from_fork+0x10/0x20
> 
> Allocated by task 20291:
> kasan_set_track+0x4c/0x80
> kasan_save_alloc_info+0x28/0x38
> __kasan_kmalloc+0x84/0xa0
> kmalloc_trace+0x7c/0x98
> v4l2_m2m_ctx_init+0x74/0x280
> venc_open+0x444/0x6d0
> v4l2_open+0x19c/0x2a0
> chrdev_open+0x374/0x3f0
> do_dentry_open+0x710/0x10a8
> vfs_open+0x88/0xa8
> path_openat+0x1e6c/0x2700
> do_filp_open+0x1a4/0x2e0
> do_sys_openat2+0xe8/0x508
> do_sys_open+0x15c/0x1a0
> __arm64_sys_openat+0xa8/0xc8
> invoke_syscall+0xdc/0x270
> el0_svc_common+0x1ec/0x250
> do_el0_svc+0x54/0x70
> el0_svc+0x50/0xe8
> el0t_64_sync_handler+0x48/0x120
> el0t_64_sync+0x1a8/0x1b0
> 
> Re-arragne inst destruction.  First remove the inst from the
> core ->instacnes list, second synchronize IRQ/IRQ-thread to
> make sure that nothing else would see the inst while we take
> it down.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>   drivers/media/platform/qcom/venus/vdec.c | 12 +++++++++++-
>   drivers/media/platform/qcom/venus/venc.c | 12 +++++++++++-
>   2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 0013c4704f03..b3192a36f388 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -1750,10 +1750,20 @@ static int vdec_close(struct file *file)
>   	vdec_pm_get(inst);
>   
>   	cancel_work_sync(&inst->delayed_process_work);
> +	/*
> +	 * First, remove the inst from the ->instances list, so that
> +	 * to_instance() will return NULL.
> +	 */
> +	hfi_session_destroy(inst);
> +	/*
> +	 * Second, make sure we don't have IRQ/IRQ-thread currently running
> +	 * or pending execution, which would race with the inst destruction.
> +	 */
> +	synchronize_irq(inst->core->irq);
> +
>   	v4l2_m2m_ctx_release(inst->m2m_ctx);
>   	v4l2_m2m_release(inst->m2m_dev);
>   	ida_destroy(&inst->dpb_ids);
> -	hfi_session_destroy(inst);
>   	v4l2_fh_del(&inst->fh);
>   	v4l2_fh_exit(&inst->fh);
>   	vdec_ctrl_deinit(inst);
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index 6a26a6592424..36981ce448f5 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -1517,9 +1517,19 @@ static int venc_close(struct file *file)
>   
>   	venc_pm_get(inst);
>   
> +	/*
> +	 * First, remove the inst from the ->instances list, so that
> +	 * to_instance() will return NULL.
> +	 */
> +	hfi_session_destroy(inst);
> +	/*
> +	 * Second, make sure we don't have IRQ/IRQ-thread currently running
> +	 * or pending execution, which would race with the inst destruction.
> +	 */
> +	synchronize_irq(inst->core->irq);
> +
>   	v4l2_m2m_ctx_release(inst->m2m_ctx);
>   	v4l2_m2m_release(inst->m2m_dev);
> -	hfi_session_destroy(inst);
>   	v4l2_fh_del(&inst->fh);
>   	v4l2_fh_exit(&inst->fh);
>   	venc_ctrl_deinit(inst);

This needs a Fixes: tag too.

It also occurs to me that most of the close() operation code is shared 
between venc_close() and vdec_close() a welcome patch for V3 would be to 
functionally decompose the common code to a shared location.

So that would be your two Fixes: first and then a reduction patch for a 
total of three.

Anyway with the Fixes applied

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

---
bod

