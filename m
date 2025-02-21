Return-Path: <linux-kernel+bounces-525695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0648BA3F344
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B632189E288
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F3C2080F4;
	Fri, 21 Feb 2025 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPFMKgDt"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5B20550D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138551; cv=none; b=iRsMQjME3UQ2hLDj/bpr5mX5JPy8CY8w/RO5CXzzpfJfsvPxQ3t3ufjNFL7iWcPVnW7gMdclrZCqOtGdMKTHuqm+Nfj34tYgNH9nYs75d3zd4Pm3S34+6dn+TmvSPASzNTIzpzKobztt6Z+Q6R54ClQhEQ2tdCsb12f4NfskiaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138551; c=relaxed/simple;
	bh=rBCn26SKuERi+K4acNcV/AEZi1MsaI5ALTJmnv5MRtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RD8+mlkkkXk72edbUC5dxmLJQRGQYqRpIgjM5bpCgXjrUrObIMtv3sAlQp+tlb0yctku+orKQswzQoVXQzyMCamD/HlN6SVUJ+YP5AI/1HJVfkOKx1NjH/Spr+IVbCGoT1l9+Zbbo/6h2919prUbv0ss42s0nWfXA+1JTDtyQhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KPFMKgDt; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso2549818a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740138547; x=1740743347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DG8wPb2kV/9iYl+Wn7aZlDrzmlhxomPPSfL6qAQ1p+E=;
        b=KPFMKgDtNwh0A8uD7EAipePz0QICBaQw3+owzwwxghnSc0qFZ7RpT6TrbhAw4m6iBX
         1jt+5fg6zgo7WWL60e9Wuzi4b/PH9kE2lNxJTZoqyBcngsrcHiF1mKAuFfEMw33Tzql2
         wq3LjwTqmeX64DnpTdiJbF5+jkpHg0rwkcMTgQumKeif9Z8sv8nTOdKvcmdc/P9/FArU
         X28UsCaoJtY9m43pYJgrIB0ISn1CBFjPGiqqr5YLrwvSXy2TNmTYQAWxjWHRUMsXB7Q8
         YuL5H9EbhuxTXAHKYsuEuJ5JCjSeJ5NK4hrjbvnkKI0slTA1fU60yiNvdkARpc4FMPRS
         V29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740138547; x=1740743347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DG8wPb2kV/9iYl+Wn7aZlDrzmlhxomPPSfL6qAQ1p+E=;
        b=rd/dJeR7YhtemEXQEYof+7emS6Nvd+G7/Vhv61eITIHpQK49wBXTVWCmUTRdnaxcVy
         otRSVaXLr8iSQAtD2H6yxMklcbNlqsPeb8NexmgYfhk9NDgIc5dhVX/mBtngRdx3mE4F
         v5cjLsBokyqcwVyU7IBMezG9X2VtjNqOJ0U6FN7YNQGiSLn2laXyNH0VRgffHm2Y9Zpz
         W4Uz2o3UpQvf6s8QZW/VMcZG5ShmkF6LgRBne4KKDCDsG6Hc6L7A1wtMBQh1554+ASHq
         sEmk0fGd9KhV+oODv1Tbz8SEYQJBHi93+vM6Pb4bx5UoCBfKPnPzd4SjSE58JrSa5voa
         zIWw==
X-Forwarded-Encrypted: i=1; AJvYcCVGAerNh9O/tyvsWysVfn2hFoWe5vQNSACeXN4Nq4i+RGx1TUYtVP0WDUkUBqZ9RSEwDrnK7Q1qlRlnXDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvdEyn+hl3D1GOrUZBAUC/C1fbh3h/ZLdQidiKckzR9XTYMmK2
	egvuh9KrsXLGZ40NAljqQde+Ck81ulcDMKQ0ESKOzP9zTRSNDYxX9y+bvHq6kMpkeovl1ShrZnd
	UG6w/+A1zfYrB1Bj5kO4fx+2n+NlTzJPHiHHxdw==
X-Gm-Gg: ASbGncuGlPlCJyhmLa7yjJ2nZQQPJeCLwXH+tbsgAmh07dhJh5poHL4B/KhUE9CfOXG
	wzqJjaqxuA1iKUdAgwZCohMOZnwh/kqzWdO8EAAvCPsfldkbYASGL5QYrtESfnPNG2Hdy6u23U4
	7sb6kAup//YQ8T35cW3MY2nuAxoxf3rZIdIRDy
X-Google-Smtp-Source: AGHT+IHDZOHwjhHYUSvphB+NwmYxo/bfrrJtTGZfAtHWzJg28NcQtjXAhkKHnW0f9pBc/5j6zzEh739LRBCxYioUrFo=
X-Received: by 2002:a05:6402:3488:b0:5e0:8b68:e2c3 with SMTP id
 4fb4d7f45d1cf-5e0b7265813mr6028593a12.29.1740138547390; Fri, 21 Feb 2025
 03:49:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221111226.64455-1-wuyun.abel@bytedance.com> <20250221111226.64455-2-wuyun.abel@bytedance.com>
In-Reply-To: <20250221111226.64455-2-wuyun.abel@bytedance.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 21 Feb 2025 12:48:55 +0100
X-Gm-Features: AWEUYZkSXVZ4GQ-z4ro9kS7bzhxwhhXZCqwdQ1bfcrZZzB0xRA6JdjBNyU-sFXE
Message-ID: <CAKfTPtDTs2btXekkhcSw3vNy3bR-S7+FY69Cb0AQEhK+RsQMZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: Do not let idle entities preempt others
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Josh Don <joshdon@google.com>, 
	Tianchen Ding <dtcccc@linux.alibaba.com>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 12:12, Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> A task with SCHED_IDLE policy doesn't preempt others by definition, and
> the semantics are intended to be preserved when extending to cgroups
> introduced in commit 304000390f88 ("sched: Cgroup SCHED_IDLE support").
>
> But current implementation allows idle entities to preempt each other
> on wakeup, which seems not behave as expected especially after
> commit faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")
> so fix this by explicitly skip wakeup preemption for idle entities.
>
> Fixes: 304000390f88 ("sched: Cgroup SCHED_IDLE support")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  kernel/sched/fair.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1c0ef435a7aa..4340178f29b7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8778,12 +8778,15 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>         pse_is_idle = se_is_idle(pse);
>
>         /*
> -        * Preempt an idle entity in favor of a non-idle entity (and don't preempt
> -        * in the inverse case).
> +        * Preempt an idle entity in favor of a non-idle entity.
>          */
>         if (cse_is_idle && !pse_is_idle)
>                 goto preempt;
> -       if (cse_is_idle != pse_is_idle)
> +
> +       /*
> +        * IDLE entities do not preempt others.
> +        */
> +       if (unlikely(pse_is_idle))
>                 return;

Fair enough

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
>         /*

> --
> 2.37.3
>

