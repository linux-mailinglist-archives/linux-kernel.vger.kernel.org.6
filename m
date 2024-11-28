Return-Path: <linux-kernel+bounces-424572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6639F9DB616
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D63816342A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929ED192D95;
	Thu, 28 Nov 2024 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8GGwCqv"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C02152E0C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732791364; cv=none; b=pbYA6p510jRBab4dBo6iNlxjXpTprdGt6nkfU5DMQR9zIcMMWfj0zHZux+wABRnRKjRYYDbBHfkhizNfZYT2OfF/T5R4NovVq77F5/f76K0cPoOmhdsk5uOOKWDicXbEPOtS9lVGto1mrS/UbI0SB7H8vFKUVMuqKXv0GkmdRMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732791364; c=relaxed/simple;
	bh=sNl8pXR3Ebgfz60+ljXMS9IQkAzupjib/Jfyu0z6Yps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ps7+iVB6nY0mx1o0F9M6CC+hEZvl0tspDHfIs8Bxy7SpZJrtVBGowiOZRTpITJZ+aMSt6GScgRd6dOTnyTjL16nUCSmd/VkiEErHhfAZ8/BL7xt9N3u/wIEu46xfGCK96sIXBumtFTtXUiuRfDsiiuiklfrXl05pJFq7pyJC9KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e8GGwCqv; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so1328267a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732791361; x=1733396161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sqpsi2rhTNaEAfBxryPApXcrOr2+7ywjD7Fk+1YK40o=;
        b=e8GGwCqvxT6NbAgEjy/wtf5dMNkzqMI0FwKuEGmkIeG6NL2pJ/hKhzn5jbTMpJZ/He
         7OJGVEYWMcP4aurnKC8wYY2vnM/dqn7hUFiMBepg7oEw5MxqGO8/aiZhgqaR+vtiNsTJ
         BjPBpkan3eiAGUF6oeYw1INXK0/qeHP7NHINVc8Z/X7bUZvHYuYGQUM1bnJycdpFq5R3
         jNKrN6TxTy2AH7BxK8Q0X0NkKIaUME7u7lgmZm/TP6BDpPHkpkgNIhaC5UXm1mwjWKBw
         tmdGfWlIddL2hov26pCSeikzfXF8+8YjDkUmud/v/zzLKfguPIJyUrbW3Mct8bfFPjNr
         9HAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732791361; x=1733396161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sqpsi2rhTNaEAfBxryPApXcrOr2+7ywjD7Fk+1YK40o=;
        b=nwEzztWwZIDYFWKjxH3eIrYr5NnnXsFyAU8VRL9WeNnkRwagR8aemJaYVeF/16AZvU
         UcC47inu8i/MWz6SkQlLuIN+gOPscze8DJRK66jZ1Sy/6Wbzltv+5pUR0R3dDx7cEjOl
         oTWUROwQYipq7UQmK9qpi7qGTCWKl3zvKXkrd7opDMmd+fxyCpEq4YFQXviujGHgQP/w
         F+St4Ac05x+K48M8P86pyu0wesSp/1obHXB/SA91wq9RAbNwxaojuPGjny1ybTR1ODk0
         oz5fELOVw1LTchU4Ua29kTMlK1yhWajxPSvfuz4+ii9lhDymBYxAAol/ILssZevbSuOx
         1JRg==
X-Forwarded-Encrypted: i=1; AJvYcCULvXoQFTbFDZVItl780k3o3/5RjXKSp9QyoxuFdxnkZO2XKahpQsswu1mxNQ+6p8XoDkI4cEi/SnpBQRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+83rXEOqxiyqpkdmWnK0+A2IFTbyAyDCJZ/RJ4Tnrj/SH4uhc
	2rU+/XvOcMFwQ5v/pJghqUwLDbzUt2929Jt8gfeifVmxSPymOP+pliU/b6jSO/U=
X-Gm-Gg: ASbGncucYEuo3A26mQurINU1NK5dm+NVdDg/we67hGQJr4aPWG9Woss7Ceg9HEWSpfM
	2sWFWMjkAcCDBbLyL/F8XpQ993PNCR07h3ino67FQvMX1CCTpQswwRbJ+2Sq4RNZh+MjtvU2fpH
	Xm0qANBwv+IIcyNDv8GCtQ4Z7NY9KuoIohcH7ogwyUeierTQOmOVHN6/fUVw4YJX7AQbt4EgVqN
	DMkEEPtkiKF1q33xeYffYfqa0ru8NiXhnjrd+zNPcwYn86MAum2JVop3jwA
X-Google-Smtp-Source: AGHT+IEnjxh9ZBhFyGvzawlD+/dtL6pKTEdS19cAB25msc9FJ2UvOItsJK1YudpESRUS0TPKtq58ow==
X-Received: by 2002:a05:6402:510b:b0:5d0:96db:dd96 with SMTP id 4fb4d7f45d1cf-5d096dbe865mr1728463a12.0.1732791361409;
        Thu, 28 Nov 2024 02:56:01 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.200])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097e8dcfasm626237a12.67.2024.11.28.02.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 02:56:00 -0800 (PST)
Message-ID: <6468302c-f1f1-4edb-a6b6-ca248944cbbf@linaro.org>
Date: Thu, 28 Nov 2024 10:55:58 +0000
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

Can TPIU be used as a sink with Perf? If so that one is missing the update.

Makes me wonder if something like a "perf_component" flag in 
coresight_device or a #define would make sense. Then the lock type gets 
auto picked. Seems like in a few years we will have completely forgotten 
why some of the coresight locks are raw and others aren't.


