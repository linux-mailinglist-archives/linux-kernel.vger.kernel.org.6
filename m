Return-Path: <linux-kernel+bounces-522021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7C9A3C4FA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35B7170002
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660731FDE10;
	Wed, 19 Feb 2025 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gsuIcR7V"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610C1F417A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982327; cv=none; b=OFrPyIZcr3QcOU+/viajfalME5TkKvcxd2rOof2F92se3zZYCp7mRbeRD3SJAlNU22EgObUNWioW/0MVWWy3xmgbkoy2REfLgEzeNzzU6zj0RiW5eI8vsa0BKWo4LXDZtrhWH0MXfrvIu+YMt7BXcUrOLId71ShpLiM1kHIiczA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982327; c=relaxed/simple;
	bh=wfF5o1CDJal8cfQTpr0XKVI6lWBEXW9eOcdNhbClFU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FS1b2YeTqs9zHghFVx7fZpwZmcX0iTfuhuJiqTaok18pjNv+CTvcIXWL8ZvZfJs49N1dtfAsFDCbxBYNE2XSVWKjab0wv+KoOOXLbEcQQDNSxBc1EeDMjPZkcakZ7V5Kh1oIAcdWA3bK0yVaLyN29GTxReRF3cz6V/rYlH/TCAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gsuIcR7V; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e07897bf66so2992204a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739982324; x=1740587124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vfr8xcnV6SOXQrnYOMtzUn70KMqxWnNTiIb61QR+9Ko=;
        b=gsuIcR7VCb5OlnJS9CGGJL6XPSi4FHTUwdMP/m2NYl/5x1B80szfpHSwX0hKJLjbUL
         FDAVYFxcCwc3j8wAyFObpCQqCCCYirYVSDGvxnWU1W+z8eRWt4axObX8hyXp7GC6YOJz
         ESd5BXTalas46BO2WAxwarpv8CLAfeMK3SGDgL7rXJM7fe1IAPkqvR8GxUuartbBKaeF
         KwGWEXFbzkmhtpkV5Slm0+mEGdB76m3eHW0hSAAmOfIukvBjuuDQHEpz+XR3YvlYlHT5
         fImA9KpCmAREWq6el3dGhvLXWrM2iqPTcEVOQOspbQRHBrjGFaAgnFRBZ1JAB56R7w2K
         xREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739982324; x=1740587124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vfr8xcnV6SOXQrnYOMtzUn70KMqxWnNTiIb61QR+9Ko=;
        b=Zw09Vzcg5SuLlCRi4dV1v98jzOzYSbUr/p2fyTTVGSzXq27SIGmElacaMwPI6DCcCJ
         RdLy6r9yyls9MnZcDfjb0E3EU7u114izFIexSqeYIP4f8HoK4j3Z+R/SR14O2Kh+/4GJ
         oJVTQEYRL2TbAId6EoYxeA+oZhJOT5ysQLFCY0DaOVmtWaooc6PgRDJdPw4F5lXvKTzI
         5lb+vKjMGK3LW/AZa2cmRO9cWi0V/oMgxb2Y6UpVvRZ6VLW6R1L8eFC81yIKU0/JILg5
         92qJaNp7xKd7WriRD0YekbL4li5E46+eQhvHGUD1u8i8UeW1iQTxbW9+rCF2G6aygB4e
         hoAg==
X-Forwarded-Encrypted: i=1; AJvYcCW3UuVWRV+noCIjnBKixWa6d0j8hFibAVsR86lkl2GNJBaGKMg2vb1RWOdRwS5hkyPC47Fcm8Vuh/Qywdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj49zDUsXb3V33WhTXLRiuyq8vZYMpo/P5y+2C8us/EUcApZAo
	iAzOLrRrmU/10n3K+WBn5P2tG9iXSbveYvAyqtaMNGsS11nRk3t0lnC6fPUH+2o5PTbQ6UQTSFE
	JaokSyAtqTzkQ4vlCU37v5EbJa4d0kGw8DiIycg==
X-Gm-Gg: ASbGnctIR5LU3HYCblBB4Ajp2aJzIlY/Jqs65rBNJT8SX9uDeXMxamsriL2A1DisaBo
	zXQFI7kHoYz3u6OzGiApOGqJ3JMZHsYUwI9Nt6kQS1/lvKkQc4zookqJZRrnlfmu3vIGhfJus5J
	ZkGex0+eNc9/87uruI6VnbBthFrw==
X-Google-Smtp-Source: AGHT+IHQBEIHsZVyeycE7fivGlzMEEtEwNHnuqIzam/OZZjAgHRnz6FJFxQCLkYEUS034I3fKZFwV69phIEn6tQXZi4=
X-Received: by 2002:a05:6402:42c9:b0:5de:481a:cbc1 with SMTP id
 4fb4d7f45d1cf-5e08951cbe6mr4299900a12.16.1739982323909; Wed, 19 Feb 2025
 08:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219093747.2612-1-xuewen.yan@unisoc.com> <20250219093747.2612-2-xuewen.yan@unisoc.com>
In-Reply-To: <20250219093747.2612-2-xuewen.yan@unisoc.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 19 Feb 2025 17:25:12 +0100
X-Gm-Features: AWEUYZnAy44goPgfZ57mSEh_j555Ws6BqhvsM4T9ShWk7WDHRvA05P6bJ_F-NAU
Message-ID: <CAKfTPtDuZSL4UdCbjkAqy2bnKo_FrqEU33EcuuPwfTS+sO8R3w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched/uclamp: Add uclamp_is_used() check before
 enable it
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, christian.loehle@arm.com, 
	hongyan.xia2@arm.com, ke.wang@unisoc.com, di.shen@unisoc.com, 
	xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 10:40, Xuewen Yan <xuewen.yan@unisoc.com> wrote:
>
> Because the static_branch_enable() would get the cpus_read_lock(),
> and sometimes users may frequently set the uclamp value of tasks,
> and this operation would call the static_branch_enable()
> frequently, so add the uclamp_is_used() check to prevent calling
> the cpus_read_lock() frequently.
> And to make the code more concise, add a helper function to encapsulate
> this and use it everywhere we enable sched_uclamp_used.
>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>

Apart the small comment below

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> V2:
> - change some commit message;
> - Add a helper function and use it everywhere when enable uclamp (Vincent)
> ---
> ---
>  kernel/sched/core.c     |  6 +++---
>  kernel/sched/sched.h    | 14 ++++++++++++++
>  kernel/sched/syscalls.c |  2 +-
>  3 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 38a7192bfc19..0466a2f61b99 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1942,12 +1942,12 @@ static int sysctl_sched_uclamp_handler(const struct ctl_table *table, int write,
>         }
>
>         if (update_root_tg) {
> -               static_branch_enable(&sched_uclamp_used);
> +               sched_uclamp_enable();
>                 uclamp_update_root_tg();
>         }
>
>         if (old_min_rt != sysctl_sched_uclamp_util_min_rt_default) {
> -               static_branch_enable(&sched_uclamp_used);
> +               sched_uclamp_enable();
>                 uclamp_sync_util_min_rt_default();
>         }
>
> @@ -9295,7 +9295,7 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
>         if (req.ret)
>                 return req.ret;
>
> -       static_branch_enable(&sched_uclamp_used);
> +       sched_uclamp_enable();
>
>         guard(mutex)(&uclamp_mutex);
>         guard(rcu)();
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3624fdce5536..bd22af347d0b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3407,6 +3407,18 @@ static inline bool uclamp_is_used(void)
>         return static_branch_likely(&sched_uclamp_used);
>  }
>
> +/*
> + * Enabling static branches would get the cpus_read_lock(),
> + * check whether uclamp_is_used before enable it to avoid always
> + * calling cpus_read_lock(). Because we never disable this
> + * static key once enable it.

Maybe, simply:

Enabling static branches would get the cpus_read_lock(),
check uclamp_is_used before enabling it. There is no race issue
because we never disable this static key once enabled.


> + */
> +static inline void sched_uclamp_enable(void)
> +{
> +       if (!uclamp_is_used())
> +               static_branch_enable(&sched_uclamp_used);
> +}
> +
>  static inline unsigned long uclamp_rq_get(struct rq *rq,
>                                           enum uclamp_id clamp_id)
>  {
> @@ -3486,6 +3498,8 @@ static inline bool uclamp_is_used(void)
>         return false;
>  }
>
> +static inline void sched_uclamp_enable(void) {}
> +
>  static inline unsigned long
>  uclamp_rq_get(struct rq *rq, enum uclamp_id clamp_id)
>  {
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 456d339be98f..9100a77e9d79 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -368,7 +368,7 @@ static int uclamp_validate(struct task_struct *p,
>          * blocking operation which obviously cannot be done while holding
>          * scheduler locks.
>          */
> -       static_branch_enable(&sched_uclamp_used);
> +       sched_uclamp_enable();
>
>         return 0;
>  }
> --
> 2.25.1
>

