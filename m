Return-Path: <linux-kernel+bounces-443519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1A79EF33C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F1C29176E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE59622B59F;
	Thu, 12 Dec 2024 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p9CndFYr"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD9C2144C0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022234; cv=none; b=F7aRbi8fprzW2pEzrO8y7LM3XNqS7jdWRrCAOh44fmPMSmTrwrlXlo65AcXOzM9voE9GWIcbU/8I5rtXHg/PaTBpRd/hPUtCWOTFdpdNZyCGOtZWIdY13r4kL+vckamXrUMQ8rEKod4XlzGJ3zvF7bV4o2L4AO9j+uM/L2AYihM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022234; c=relaxed/simple;
	bh=dHloNiBUJ7bLsqmh9wIPd62e5v2PCyB3TZUo+KgkVQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=toCRfR0D/6Gd5yLWMOCQo4F6wEYS+/V46J6QFTquukeOa8Bwxuw/6XGNbKqp+w4bTZkTeU6/YbGG9TyEUwuoro2O/rZfdrLCEta7OnfaYGhrvj4MkZAqS7Re/x3GqtNCHUfpfidzkm+aZzguQJZYbdMPcpKaVfpL0j3LddmtNww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p9CndFYr; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725f2f79ed9so663167b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734022232; x=1734627032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KCbfEF4lyl4HC7RLSlayiasY4pJVdnriIQ3YnsD1m5g=;
        b=p9CndFYrLgz/gEudx1yI6gtcm6ft5U/lJG+F64I7HCcmNmqMzzM2bzGvIURERw8lHI
         RRM41TQELbMmrfEyewnNxQlKQYPT70zTBUKDc5QQUF1R3VJ510QMAnZ+DPrxzgGFM/02
         eVSYUqQ53qNE4wHBeMje2lAAWISRZV55o/rxbaLYl4T1YmOQWrbrjj5epGvmDD1FiyIA
         LAm/87qDxqMk0/m73pk/Ow8VYj+y89em5uM5S97w/mgSUqZFIi5Ak3Xh8RC5pY9Ntriw
         kMN248kOXHUJGH9dv/zVT+eOs+D1plYkcD5hUZtENAjRVVZBaO496VGN+HBxFssBneRn
         4UOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734022232; x=1734627032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCbfEF4lyl4HC7RLSlayiasY4pJVdnriIQ3YnsD1m5g=;
        b=R6x4h1WgES6Mi3fZVCE5w38DZNRlGd49tWOGrPNakPhiA/F16meuIv6Ed2s7rkr8t7
         5hQdyrPXqNlFNuFdgGUqf23NvrJpzweFyimevgsuK+JoIABYjpj3gts/oByZKXS9Y2sQ
         9VM2wLQOKAlCa+KCAeSH4P25SW5NCzrnL6iBj0TfS64+com08KZuVL2o1CFLFc1zkG5Z
         nIZwUp2G5m6b0QaDPncnAWzqaWyfD/Gw+ShAtJlMF8o0nm1skhXr0rlBuakmFzBOsuMi
         bp9CsDvuPaKq1P5xTMLwu0+itx+grLQogcgeFgPOuZWXDrPaeeZcVyVW52tKKF3s/ey/
         ueOQ==
X-Gm-Message-State: AOJu0YzYIHLC5CVE/ENUF5qmeP96LnMCUAG/9eazpzAU7KyYYWBJ6ypb
	GnOFXCCh6cIVtRTJAmDdan9BBsMqpGO17Zw6tNE/XfkfBFKr581Cd8PZVE5vt2cqlj58kdjW8bE
	MZcfb33ed8tLqVyyEVlHwiWPZTqNNSU3oNXqdWA==
X-Gm-Gg: ASbGncuecqfCpufWxhK2psF1A1nn0mVbbN4h1bqULEXmv9NFXLo0Lsev5BQG3V70bo9
	aO46OnHo2eCe8F/tTarixXwbt5tyc3V4aF0hmNhpExNLEREpjsBjTuqHmoHPFRyw2z9E=
X-Google-Smtp-Source: AGHT+IG8nR5vlKF90c2NpBuZITN8zh2ypGJYDwjdrM9VRjekVUmalhlBLf5HinS4nt4joQcQ8tfiL+9oJP36qwhb5R0=
X-Received: by 2002:a05:6a20:1590:b0:1d4:fc66:30e8 with SMTP id
 adf61e73a8af0-1e1dab29f1amr1505647637.10.1734022231650; Thu, 12 Dec 2024
 08:50:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212043102.584863-2-vishalc@linux.ibm.com>
In-Reply-To: <20241212043102.584863-2-vishalc@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Dec 2024 17:50:20 +0100
Message-ID: <CAKfTPtA-h+wehFrYRHNTWjj4ZwOD9KWMhsaudytBdwNEHA0fVQ@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: Fix CPU bandwidth limit bypass during CPU hotplug
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	sshegde@linux.ibm.com, srikar@linux.ibm.com, vineethr@linux.ibm.com, 
	zhangqiao22@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 05:32, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
>
> CPU controller limits are not properly enforced during CPU hotplug
> operations, particularly during CPU offline. When a CPU goes offline,
> throttled processes are unintentionally being unthrottled across all CPUs
> in the system, allowing them to exceed their assigned quota limits.
>
> Consider below for an example,
>
> Assigning 6.25% bandwidth limit to a cgroup
> in a 8 CPU system, where, workload is running 8 threads for 20 seconds at
> 100% CPU utilization, expected (user+sys) time = 10 seconds.
>
> $ cat /sys/fs/cgroup/test/cpu.max
> 50000 100000
>
> $ ./ebizzy -t 8 -S 20        // non-hotplug case
> real 20.00 s
> user 10.81 s                 // intended behaviour
> sys   0.00 s
>
> $ ./ebizzy -t 8 -S 20        // hotplug case
> real 20.00 s
> user 14.43 s                 // Workload is able to run for 14 secs
> sys   0.00 s                 // when it should have only run for 10 secs
>
> During CPU hotplug, scheduler domains are rebuilt and cpu_attach_domain
> is called for every active CPU to update the root domain. That ends up
> calling rq_offline_fair which un-throttles any throttled hierarchies.
>
> Unthrottling should only occur for the CPU being hotplugged to allow its
> throttled processes to become runnable and get migrated to other CPUs.
>
> With current patch applied,
> $ ./ebizzy -t 8 -S 20        // hotplug case
> real 21.00 s
> user 10.16 s                 // intended behaviour
> sys   0.00 s
>
> This also has another symptom, when a CPU goes offline, and if the cfs_rq
> is not in throttled state and the runtime_remaining still had plenty
> remaining, it gets reset to 1 here, causing the runtime_remaining of
> cfs_rq to be quickly depleted.
>
> Note: hotplug operation (online, offline) was performed in while(1) loop
>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Suggested-by: Zhang Qiao <zhangqiao22@huawei.com>
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

With fixing the typo below
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> v3: https://lore.kernel.org/all/20241210102346.228663-2-vishalc@linux.ibm.com
> v2: https://lore.kernel.org/all/20241207052730.1746380-2-vishalc@linux.ibm.com
> v1: https://lore.kernel.org/all/20241126064812.809903-2-vishalc@linux.ibm.com
>
> ---
>  kernel/sched/fair.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index aa0238ee4857..72746e75700c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6679,6 +6679,10 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
>
>         lockdep_assert_rq_held(rq);
>
> +       // Do not unthrottle for an active CPU

typo: please use /* my comment */

> +       if (cpumask_test_cpu(cpu_of(rq), cpu_active_mask))
> +               return;
> +
>         /*
>          * The rq clock has already been updated in the
>          * set_rq_offline(), so we should skip updating
> @@ -6693,19 +6697,21 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
>                 if (!cfs_rq->runtime_enabled)
>                         continue;
>
> -               /*
> -                * clock_task is not advancing so we just need to make sure
> -                * there's some valid quota amount
> -                */
> -               cfs_rq->runtime_remaining = 1;
>                 /*
>                  * Offline rq is schedulable till CPU is completely disabled
>                  * in take_cpu_down(), so we prevent new cfs throttling here.
>                  */
>                 cfs_rq->runtime_enabled = 0;
>
> -               if (cfs_rq_throttled(cfs_rq))
> -                       unthrottle_cfs_rq(cfs_rq);
> +               if (!cfs_rq_throttled(cfs_rq))
> +                       continue;
> +
> +               /*
> +                * clock_task is not advancing so we just need to make sure
> +                * there's some valid quota amount
> +                */
> +               cfs_rq->runtime_remaining = 1;
> +               unthrottle_cfs_rq(cfs_rq);
>         }
>         rcu_read_unlock();
>
>
> base-commit: 231825b2e1ff6ba799c5eaf396d3ab2354e37c6b
> --
> 2.47.0
>

