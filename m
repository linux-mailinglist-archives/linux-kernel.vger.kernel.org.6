Return-Path: <linux-kernel+bounces-186603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305AA8CC627
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD0F2812A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337E5145B03;
	Wed, 22 May 2024 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sDFdTlS8"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3658AA929
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401639; cv=none; b=uu7pjbCZlQ0OSHRiwjtnhIZAAXMn425G55CGj6aF6qj7yl4Lpw54aWXwiMshXsMbeGXy6axUZC7/hOL8y6AL8aITPj9W0m88xIpinqtToW4T0HxXTw1o2sm6Gxnf7CGUXlhS5AUMreZURNGivIQIK/pBns/8+4KJZI7aIa0vsNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401639; c=relaxed/simple;
	bh=5NMsDfY6VTABrDzPgIWhs/3DIYKZtHGT8JJUJOlXrjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJiNHIF0ujwR29Fsk6BW8vdgHCRgrwn/Wl3iKlbGHgxlmDOHQPClgCpYJZEE8zjHGJeW1bURappas6c2S7/Iw4o4hXwzVFT2flomulqpzO/X5IEL1eDV6X/4s3C4H5Uu7H2HOK09RBUal45S9jy0x42be+VEhYp/349uvNFwVTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sDFdTlS8; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36d92f4e553so2570675ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716401636; x=1717006436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tGhFk+6Mn+aFTeEhhRU2V2oXQp27/bTpuMCUZ0uMfqc=;
        b=sDFdTlS8EOzGAOHHLTGwbBbK8QPgMUI1LZJ/aFXTmJNHuh4Dhj0rEeTGzYW723BxQl
         jgVZS00+3VaDoeFk3sCytEgvFrDBeqo8PntiCMXpDT+ybg0X3SGpO414j1ejYz5KX7es
         6ZG+NisAD20kc4hPuuA+F9f4tHIkPDwHEH1yWpRfd6wKhjp4xjLs1E4MjtVnzsMd6L38
         z2Pk6QaNvnWl/69X1IRe+Iuj+oLH5uNbp7saNfsltDLwIMgcYfjG4dMX9/hCrHmClCAB
         NK1yG/BKHJipV3iu6HuPf5EeANiqFALYgLQp2mO6sXR2nZQ3YrsHnfqh5/M7uCyRhu97
         Sbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716401636; x=1717006436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGhFk+6Mn+aFTeEhhRU2V2oXQp27/bTpuMCUZ0uMfqc=;
        b=buaTsA4bSE7XkWNw1zCEMDik+utNhiqepmJ+WTMSIcw9KHoZ1bazF5O9bC1JXYxRWA
         7IuRkG5IX++79oKrogSuImLKQjxgGU0xUr/l8Ho0ZR64AzrJOvzF4ckuAjaHgu2jWkSl
         kLZmOpTclaZneRb+h/9iH3QPyBOqJ4R8DHkBHgq1CpTSWJWMyXKvyIxYiqFwgkP6Ikum
         Wn+HMGWtPJNg/SMbndS0r5L6av6HzURXCUHs3h9JOsujVcdj5gXkfFmw7eIdDcMGpuBH
         9GdcDBEjfJqSYmrqUwYcToOqrCgsrEteDgFz6S29fMV3VKbp1wSUUedVmT3N4Via9Bjy
         Q76w==
X-Forwarded-Encrypted: i=1; AJvYcCVGFiKIZjDPONwBz5GKiAq5i3muCywn2Xl8mUSOaRDS8b0o6drH6VXGQS7pMpXzlo1Z6zSaHHUFkrRQX8JXEtQG0Ecokqotj9LvsBOE
X-Gm-Message-State: AOJu0Yza1xRJjAU6JGy7SKYGYwWDQ2yXjZG9HK+GMv1zixxq01dF94fs
	5/iKu3LGAiJPsf6nOMrlARZf1p3DcTx+ay4xR69a62f7eAYbkorDOTm6K/0GNUQ=
X-Google-Smtp-Source: AGHT+IG5ECb2ChN21OliaANFfuAG3aNrPryJwmc8jxQsxZ2EjfcJpXARxHMFz1c3VkuESsX03wb0sQ==
X-Received: by 2002:a5e:cb03:0:b0:7e1:d865:e700 with SMTP id ca18e2360f4ac-7e38b2004fbmr306212539f.2.1716401636350;
        Wed, 22 May 2024 11:13:56 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376dc51esm7796324173.122.2024.05.22.11.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 11:13:55 -0700 (PDT)
Message-ID: <d9795483-ef64-4fd6-be71-a3946ae8fb3e@kernel.dk>
Date: Wed, 22 May 2024 12:13:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: inherit the ioprio in loop woker thread
To: Bart Van Assche <bvanassche@acm.org>,
 Yunlong Xing <yunlong.xing@unisoc.com>, yunlongxing23@gmail.com,
 niuzhiguo84@gmail.com, Hao_hao.Wang@unisoc.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240522074829.1750204-1-yunlong.xing@unisoc.com>
 <5166bc31-1fd9-4f7f-bc51-f1f50d9d5483@acm.org>
 <68cfbc08-6d39-4bc6-854d-5df0c94dbfd4@kernel.dk>
 <f6d3e1f2-e004-49bb-b6c1-969915ccab37@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f6d3e1f2-e004-49bb-b6c1-969915ccab37@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/24 12:12 PM, Bart Van Assche wrote:
> On 5/22/24 10:57, Jens Axboe wrote:
>> On 5/22/24 11:38 AM, Bart Van Assche wrote:
>>> On 5/22/24 00:48, Yunlong Xing wrote:
>>>> @@ -1913,6 +1921,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
>>>>            set_active_memcg(old_memcg);
>>>>            css_put(cmd_memcg_css);
>>>>        }
>>>> +
>>>> +    if (ori_ioprio != cmd_ioprio)
>>>> +        set_task_ioprio(current, ori_ioprio);
>>>> +
>>>>     failed:
>>>>        /* complete non-aio request */
>>>>        if (!use_aio || ret) {
>>>
>>> Does adding this call in the hot path have a measurable performance impact?
>>
>> It's loop, I would not be concerned with overhead. But it does look pretty
>> bogus to modify the task ioprio from here.
> 
> Hi Jens,
> 
> Maybe Yunlong uses that call to pass the I/O priority to the I/O submitter?
> 
> I think that it is easy to pass the I/O priority to the kiocb submitted by
> lo_rw_aio() without calling set_task_ioprio().

Yeah that was my point, it's both the completely wrong way to do it, nor
is it a sane way to do it. If the current stack off that doesn't allow
priority to be passed, then that work would need to be done first.

-- 
Jens Axboe


