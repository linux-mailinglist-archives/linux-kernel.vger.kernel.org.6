Return-Path: <linux-kernel+bounces-423733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D82CE9DABFD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB9F164CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A76920126E;
	Wed, 27 Nov 2024 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aUPDbmAi"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D9201256
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732725896; cv=none; b=GFwL9n7PDl1m9kIZWck7md5nxk3JebbMfjHxqqonq5fPjIZiGjWEHbVwJpk7+X4jxo2t2+S6NL4K4Dncv7xB4gHNw8gyv7rGBa2JdBGi2+5X+lz6KvrcdCC3LyPh9DK+BXyeAXZGHhT6wL1YVBH5cBOU16ibDjkKymWyInnoPKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732725896; c=relaxed/simple;
	bh=B0NJtAswW/ENp89+GUemsEmKD4nhWS8fdJGHlmvIv1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqlG8p5J5yvzcd2ZxL7Jj9fWpkv8xti8xmtrP7o24nR9bl4GBcVr8hNKFenLZruEb4BcY6z856J4lCBr/gH5M/KqZwALc4PW/G4pjMIYQQyMf4rDKwIZheLB++G17hjdhgJFMH6VRu0/ACpGtBYiPIN4Msj3WIXnH7nPiIJ9okw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aUPDbmAi; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df31ca44eso575308e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732725893; x=1733330693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fW8xExxeIKpIvS1coftBu84q3jUSvnzFCGKxsDAIRY4=;
        b=aUPDbmAiy3kXFHjb7LsmvWNLZgbxSgNaOnaT+F5rermZg9R7Y00LWYFei2XfxqwZf8
         rxmNpN7g/JQ2RAzgVi4b/Qbi44QpF+tC/itep0RS7JPnkie9j82a94mQ6MeHYyVNm7Zj
         WyYH6ITUWhNdhx7/FWYSC5BRX81bLlQURhzCEfzQKruIXIMCvHdMRwdweY9WSCSNdC1X
         +A8PRnENAN4jAz+sksF5Da0kNG0cgf9ZVEWzaUVD0E+5ew9B5ixUMugzrmWeYxL1giMp
         Ww+diIiQWpD4l0lbJXyOwwLhExWq/OYXKBhz0YPp4N1xYP5ECgy7M6Oa6mo2nC/IkC9G
         ZVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732725893; x=1733330693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fW8xExxeIKpIvS1coftBu84q3jUSvnzFCGKxsDAIRY4=;
        b=hP7zFEqC38kxBGMeRPt0kXpExPaYuWc4L6VqhK7ssiIH1M73IVuGQvLseqGhmVNTlT
         yETL0RAjqSYHvTMR4Ga4UkMtVdTEdvUYUKwFDFOO810/g5rIWOu/oXZKIvKUKA7Qwaav
         U2LTKt+I8Fqj7ydrEfs8P+vUHkoqRJS2TNDEWwbqasqdgPqr4PwYpa22znDX/zPmrsQI
         fyCtMqEGoyFAOCrrUCIycWcoDGsGk8sjQ9V7FEAahzxpbJW4bFeHTtF7b9steeLXvpdq
         4kr3dAckh075Tw3gCt7fi65BshyOq3gdux7zy+wV+nPBJTH3r1tXTETNeZpaFv/B/Z9y
         u1GA==
X-Forwarded-Encrypted: i=1; AJvYcCVuYQMxwM6+MX+ATNtsOAwSs2iPmitmGMi1k1LRhjr0hbiJqoRy3RaIGc4uq8aQWtWQJz+88f3lzvRBAXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfuacg8fRVuCewuOX4mmmtM8G/dM3OSqdIaNbJpxSC8go2JY+H
	rHx3IzOEGz81qw7U3SN6mdZKPFgzy2J1COtwALKjU+DODN9Q5S8bGUqBhLuiZJo=
X-Gm-Gg: ASbGncuRKMsOA+PpidoM6/OIPAncvUBy8M+1/wr+IkXo1AGv9m3ZhVKv/JWu1+fSL1e
	veN95rQh/XQfftlEkJuJh0co1Ph4iHUbairxhTM20OvXdXdoDEhrn/EPelBkA15WkjiU2xIP7gr
	DK4TizuoUb9KwjV0m4ehe2nE1XvtPohPwEcIdj52jCdJoCO9o5xuH2Sb9r6mhE1yXSvuaj/wi1q
	yNiX51lx4v7DVpSGUzMltwKDIL+B4jdfruQpQoM8jiUWZoQXpqTpkS6c1JY
X-Google-Smtp-Source: AGHT+IESX0M/mKeeOPEaJAvih6k+WhOExY781wFMg2q0kk+FhBaoTszX5Z/64SQGu7rfW5ScvTae1A==
X-Received: by 2002:a05:6512:2355:b0:53d:e5fd:a445 with SMTP id 2adb3069b0e04-53df00dd3ddmr2625559e87.32.1732725892585;
        Wed, 27 Nov 2024 08:44:52 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa53a146fd0sm538629966b.143.2024.11.27.08.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 08:44:52 -0800 (PST)
Message-ID: <22ef761d-7a9c-46a2-8d61-3d16c2188c0c@linaro.org>
Date: Wed, 27 Nov 2024 16:44:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
To: Yeoreum Yun <yeoreum.yun@arm.com>, suzuki.poulose@arm.com,
 mike.leach@linaro.org
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, nd@arm.com,
 alexander.shishkin@linux.intel.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241125094816.365472-1-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/11/2024 9:48 am, Yeoreum Yun wrote:
> In some coresight drivers, drvdata->spinlock can be held during __schedule()
> by perf_event_task_sched_out()/in().
> 
> Since drvdata->spinlock type is spinlock_t and
> perf_event_task_sched_out()/in() is called after acquiring rq_lock,
> which is raw_spinlock_t (an unsleepable lock),
> this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.
> 
> To address this,change type drvdata->spinlock in some coresight drivers,
> which can be called by perf_event_task_sched_out()/in(),
> from spinlock_t to raw_spinlock_t.
> 
> Levi Yun (9):
>    coresight: change coresight_device lock type to raw_spinlock_t
>    coresight-etm4x: change etmv4_drvdata spinlock type to raw_spinlock_t
>    coresight: change coresight_trace_id_map's lock type to raw_spinlock_t
>    coresight-cti: change cti_drvdata spinlock's type to raw_spinlock_t
>    coresight-etb10: change etb_drvdata spinlock's type to raw_spinlock_t
>    coresight-funnel: change funnel_drvdata spinlock's type to
>      raw_spinlock_t
>    coresight-replicator: change replicator_drvdata spinlock's type to
>      raw_spinlock_t
>    coresight-tmc: change tmc_drvdata spinlock's type to raw_spinlock_t
>    coresight/ultrasoc: change cti_drvdata spinlock's type to
>      raw_spinlock_t
> 
>   .../hwtracing/coresight/coresight-config.c    |  21 +-
>   .../hwtracing/coresight/coresight-config.h    |   2 +-
>   drivers/hwtracing/coresight/coresight-core.c  |   2 +-
>   .../hwtracing/coresight/coresight-cti-core.c  |  65 +-
>   .../hwtracing/coresight/coresight-cti-sysfs.c | 135 +++--
>   drivers/hwtracing/coresight/coresight-cti.h   |   2 +-
>   drivers/hwtracing/coresight/coresight-etb10.c |  62 +-
>   .../coresight/coresight-etm4x-core.c          |  71 ++-
>   .../coresight/coresight-etm4x-sysfs.c         | 566 +++++++++---------
>   drivers/hwtracing/coresight/coresight-etm4x.h |   2 +-
>   .../hwtracing/coresight/coresight-funnel.c    |  34 +-
>   .../coresight/coresight-replicator.c          |  36 +-
>   .../hwtracing/coresight/coresight-syscfg.c    |  75 ++-
>   .../hwtracing/coresight/coresight-tmc-core.c  |   9 +-
>   .../hwtracing/coresight/coresight-tmc-etf.c   | 195 +++---
>   .../hwtracing/coresight/coresight-tmc-etr.c   | 199 +++---
>   drivers/hwtracing/coresight/coresight-tmc.h   |   2 +-
>   .../hwtracing/coresight/coresight-trace-id.c  |  93 ++-
>   drivers/hwtracing/coresight/ultrasoc-smb.c    |  12 +-
>   drivers/hwtracing/coresight/ultrasoc-smb.h    |   2 +-
>   include/linux/coresight.h                     |   4 +-
>   21 files changed, 751 insertions(+), 838 deletions(-)
> 
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 

Reviewed-by: James Clark <james.clark@linaro.org>

Somewhat related to this change, but not something that needs to be done 
now:

All of the spinlocks for the syfs store/read functions don't need to be 
raw spinlocks, or spinlocks at all. They're never called from the 
scheduling code and can be locked by coresight_mutex instead. 
coresight_mutex is held on the sysfs enable/disable path when those 
values are actually used.

Same point as here: 
https://lore.kernel.org/linux-arm-kernel/9a637e74-d81d-405c-bad0-c97ec1aa4b77@linaro.org/

Probably needs a review of which values in each device might be shared 
between perf mode and sysfs mode when they shouldn't be, as there was 
one in the link above.

I thought the only thing shared between sysfs and perf should be the 
'mode' which is taken with a compare and swap without locking anyway.


