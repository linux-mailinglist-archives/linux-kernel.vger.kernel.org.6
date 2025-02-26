Return-Path: <linux-kernel+bounces-532730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D310EA45185
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9BF1792B9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE9313D52E;
	Wed, 26 Feb 2025 00:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPsxWft9"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4513B19A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740530126; cv=none; b=AcEBGRltGNNR6Iu5LRw4S7BTpnlV2wRpwZm8NKFD7GaXUVIPy6qRQSZKGjApzQsLdrqC11lc+xUs4M9Gu7jzFtZCKjBnGwAPlMJjARv+gwPO8c0fAtH39/BUORGXCs83NFGWsYY8MO0oI6v470yRd8K1op1uG0+IVFG/U9yF4Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740530126; c=relaxed/simple;
	bh=WXk+NSNdAwFqqx+MVizfGGgWgwuhd31Tk8ZujVhcpSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9aS4qaaWyzi3D2NdeVesHEOCZOur8xKL56v1japJHZHyY2PUmhoBniMDKBgDP3sOE8ghQ63O+qvqld3OcFxsv88BGAKWF1eumY8kE/AqRyMKXqKJpcRGYAm6iTgI+0iBjIGC9g0J8mFdK0qCwst0NvxxDh2u8IIKqWRRr+f+m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPsxWft9; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-aaec111762bso441644966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740530122; x=1741134922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2sWr60tesWUFRYFPqf/atpsmtwt+NxovXy8XB/PMBUs=;
        b=XPsxWft9THEr2JoV4vovD48+FoVfhZXPJK6tY/CUJulVZ5xRUWkFx17+PjtcHVKIu1
         OxGctuiMtMDR1sNsnzQkb24gR4JZqJpAck4nSxWRA+Q6bFTZVN9iGH02zDDMYkl6ztFO
         yS8EDK+pGsGLzGRAqh5l2emYBFQ3gAETJ9ea9xwM4T0jxypNqUHhyunzJanNESW6PWZ8
         qyc4PMvdNFyXHAnvm/p5XF6TUrA8iLOLnXVtX/40Fy6msc7Gztk98bLyzPa3nYITuq6P
         dLfFnW1mhsTxEG++ncwBMaUzLuXnHnb1hhJNXRVoT0vK8/iaoMoZNK5jdgWlyphO1eJq
         6e5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740530122; x=1741134922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2sWr60tesWUFRYFPqf/atpsmtwt+NxovXy8XB/PMBUs=;
        b=q9oeCEJUYJjf+za65+hz8LL52Dy6Asyj7fruoDZhE1T3xS8AqXKq4h5WVoSAIHLWph
         zDmQEXcl9lnqM+cKxZJFiZspkzK6VBhrTy3kqxP4StceTCyK3dIsVuAve4YFpnV225Wd
         yXiG04RLKvdUqs+2DWqM3N0E3FUbzUGSG3tV4U44CDteLwcwWWQt5IKhO37YgOcnPNfx
         /rVuEs+S1KaO2F8qy/Y3SC1fMgiFyGfuwbvUcc2/QYWKT/Jx1fN94IJcepYs6BU4S5F4
         eehwIJhyLxbQsrETe2UxQ4USimyNKh4CvXhc7L0w192sht+iD5GyxNpFNp9PFIz72gpV
         vhZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHldyFNeR9mu5YlcNVjYWvuGGkFf/FYNb8fBe5uJT7AFteJviJ4mh3jFu2A/tkP5qgUV54UtjJetBaNvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKqQd7fyQB7eA2FWWRe9uq4FZFLiq+LqTfIlm7lEkn6wp8Dqsg
	uxABDKPL+7n8J6QtSPSrzelOiaOZX0YHcIRokfjJQL22nYoZMty++BSr5nXjGhuJGA==
X-Gm-Gg: ASbGncuJnKICyvdiQTsiXF9Y63rvFsTvUpm6i1UnSlukiyHN32YJa1NkqL0ZM+T/iOG
	D9c66ia4KKj1B5trljXu1+aYL09mIy9qX33fbP2TIMfBoXhSkTNZ44iSRTFyObf7hqfMvTMuitp
	T5S92DZaGsVElnjsV+JWZBke+YjYFCckAZ0Y5r2jUeNU9p9yFvYc0lQCKOPO9oPWYFcdzifPJHN
	/yhZy1Xjd9ifIoz1dJFXat28z7jbjx9MP1PQIyf/Q2QpKI1OJLe1CXncX5MHc6lsJ2NoautBAZ6
	utbPIARtjfAaV1gA0iFMRJyzvdXgu16k4OcK3zEJKdO0irPV6MR57j+Bo5fdo7uozOJPXKSZHDe
	wt0Z4ygpzyxmDdHq4gFM9mBb5g+KOecre2Nnqfm0W+mKRTGL+wuZfvPk=
X-Google-Smtp-Source: AGHT+IF3XIr+VPlmtfyD5U0Gg/aRmrzOoS9BOhDrJkrfSsducyRIXJb03Wm06EbWrn1gJBz30qxBmA==
X-Received: by 2002:a17:907:d8a:b0:abb:aef3:6052 with SMTP id a640c23a62f3a-abeeef81b5emr99428266b.55.1740530122412;
        Tue, 25 Feb 2025 16:35:22 -0800 (PST)
Received: from [26.26.26.1] (ec2-3-73-218-181.eu-central-1.compute.amazonaws.com. [3.73.218.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20b5cc5sm226238966b.168.2025.02.25.16.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 16:35:21 -0800 (PST)
Message-ID: <f77cc212-deb0-47a7-90fa-8d76bc891564@gmail.com>
Date: Wed, 26 Feb 2025 08:35:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
To: Jason Gunthorpe <jgg@ziepe.ca>, Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Yunhui Cui
 <cuiyunhui@bytedance.com>, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
 <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
 <20250225142610.GB545008@ziepe.ca>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20250225142610.GB545008@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/25/2025 10:26 PM, Jason Gunthorpe wrote:
> On Tue, Feb 25, 2025 at 04:54:54PM +0800, Ethan Zhao wrote:
>>> On 2025/2/25 14:48, Yunhui Cui wrote:
>>>> We found that executing the command ./a.out &;reboot -f (where a.out
>>>> is a
>>>> program that only executes a while(1) infinite loop) can
>>>> probabilistically
>>>> cause the system to hang in the intel_iommu_shutdown() function,
>>>> rendering
>>>> it unresponsive. Through analysis, we identified that the factors
>>>> contributing to this issue are as follows:
>>>>
>>>> 1. The reboot -f command does not prompt the kernel to notify the
>>>> application layer to perform cleanup actions, allowing the
>>>> application to
>>>> continue running.
>>>>
>>>> 2. When the kernel reaches the intel_iommu_shutdown() function, only the
>>>> BSP (Bootstrap Processor) CPU is operational in the system.
>>>>
>>>> 3. During the execution of intel_iommu_shutdown(), the function
>>>> down_write
>>>> (&dmar_global_lock) causes the process to sleep and be scheduled out.
> Why does this happen? If the kernel has shutdown other CPUs then what
> thread is holding the other side of this lock and why?

The down_write() actually executes might_sleep()->might_resched()->__cond_resched()->

__schedule() first before acquiring the lock, thus there is change to got scheduled out.

The caller is scheduled out due to voluntary sleep or because its time slice is exhausted,

not because the lock is held by other processes here.

>>>> 4. At this point, though the processor's interrupt flag is not cleared,
>>>>    allowing interrupts to be accepted. However, only legacy devices
>>>> and NMI
>>>> (Non-Maskable Interrupt) interrupts could come in, as other interrupts
>>>> routing have already been disabled. If no legacy or NMI interrupts occur
>>>> at this stage, the scheduler will not be able to run.
>>>> 5. If the application got scheduled at this time is executing a
>>>> while(1)-
>>>> type loop, it will be unable to be preempted, leading to an infinite
>>>> loop
>>>> and causing the system to become unresponsive.
> If the schedular doesn't run how did we get from 4 -> 5?

We got from 4-->5 because caller thread's voluntary invocation of the scheduler.

>
> Maybe the issue is the shutdown handler here is running in the wrong
> time and it should not be running after the scheduler has been shut
> down.

Move thex86_platform.iommu_shutdown() before hpet_disable() ?

I didn't figure out why we need scheduler is active when we execute

iommu_shutdown(), or the reason to keep this pair of down_write()/

up_write(). could you help to shed light ?

Thanks,
Ethan

>
> I don't think removing the lock is a great idea without more
> explanation.
>
> Jason
>

