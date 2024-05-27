Return-Path: <linux-kernel+bounces-190451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E353F8CFE75
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E3C1C20FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDA313B7A4;
	Mon, 27 May 2024 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+3QucYU"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC61026AFA
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807491; cv=none; b=r315txkXPU4DNz0x61Zxr3is6djmUzyzv2rq09v/44IdjxXQ/ZHQHMTvBstyg1UExpmB+HtcrSzCP+EYRiqaMEtwRnldEvQLziB11sqNNhripFx2Pj57u1J8ZPbRJK3yM8c+kLFtamBWNHeDIm7KsWtRvSIgCG1WQasQuPN4oj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807491; c=relaxed/simple;
	bh=TGdyq6q2uv761stw9lPH9WL97UEXPvkRhyCELLpk3eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pp3htA7DVN7IyMpUxpf0gzdYeXlzP9RceuLJuqqZN7tG4ubRUnvXitNTBYxI98zA1wrZwwLTvjFl9CDCu7Yqq/miNqWdDmSTZ+W4d7ntj3eQunqnEP0e3kY39wNJfB9ENYv1yftWtopk+bdFYquQawxGohSwjDIsMXhFHVJF2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+3QucYU; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-24ca0876a83so1702578fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 03:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716807489; x=1717412289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRLFyUfzVJD7HXj5m7GcBh6/yvo5g3CHgmkZE4w+OEc=;
        b=j+3QucYUNG10gRGDzmdvPlLMVdoJTAJWAB5UDMssvv9RUNcIwgkldGk1PP5rMn53t3
         4zNwVt8W97rLbMD7r5XFfFx1GH4t5DQa6uAGb/bx8LOXerqBijuC2LPO9GA1Ke3Wvwvz
         BtS/FNFmuBQspGFPoztNC+kl4unKFlH6BY9nAqGGJIG3AZhlFtKE+NUlStRzt3jvpcUL
         yVl0mVELWnOk41uzVMzg0ieMv5RbM9yTr4Kexm9vetkadAdf4O8J1RSkBibWCkk63KPu
         GKDpqTGqtLfEcRPN2C7IIJwM5YO5F9vuQbPm4eaVY4jEUx9EAu5xm2uU2g2fJS9jmzVS
         DR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716807489; x=1717412289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRLFyUfzVJD7HXj5m7GcBh6/yvo5g3CHgmkZE4w+OEc=;
        b=ZD2WRdzo4BM7tOeWOluUcb5VOEFv49bvCiS3y4aaJJKhpmfkCd+cTToocLlin+nJ5O
         +VYl9kc8hjgdQvc5qHvRuZkv/TQbLsVITodFO9JannBskwtqZ68lkwK+gNbEMjFtRe83
         sSwAh+dej84BDU/mcR6gDKCi5rsjIkdbWQRMdEt1O7IvD/mfQ+I2w0Xc7O1V8Bfpg3kh
         BoyGaw2QCiJ1AG3W6BbHw1EMgCzrg8hRdwcy841Y2TzEt5CTafKddWjVcTbYehQ0Ycf9
         7fBxBZ8g1XsmtJJsP+GxAl6bZjHs5EwFiEOHGC8fQjet0nkCOI2avKi8RcbC4gNOtijG
         wZ/g==
X-Forwarded-Encrypted: i=1; AJvYcCWKopbWUrBxwwIeGqP1LNfcWn4u/L4HtCjAhz9/366bvu7pGMnKiWo+wwVNOrHYvcQ9d6VbTef9ikaH3wkFCnCfBmefoSfIJTHsVu3T
X-Gm-Message-State: AOJu0Yz2v8jMBkGmAi1izeiYbASAku2/2TcxfCvTcanjCKPMxeaNnkND
	JBHhhthIDZfAc6m69p+AFVOidV8Ql7Lrpb5AbkvTTEC2aRRO+We1o7yM5gLD+rvWxUjbRPXivDY
	JBXAHNoSp0qEIt5e0NpG8NTO24s4T+0nK
X-Google-Smtp-Source: AGHT+IEgzV3pA7sfPp3l25KDffUfXVce9oKUMTbG1PU+welpRFCzBVJjgPArrE+7ABcyO/+Tp2Pvj/O75vGyR31vCX0=
X-Received: by 2002:a05:6870:350b:b0:24f:cd06:c811 with SMTP id
 586e51a60fabf-24fcd06cd71mr6703359fac.54.1716807488656; Mon, 27 May 2024
 03:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507072242.585-1-xuewen.yan@unisoc.com>
In-Reply-To: <20240507072242.585-1-xuewen.yan@unisoc.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 27 May 2024 18:57:57 +0800
Message-ID: <CAB8ipk9ASAqvZurJVojmf-TK0m4KXKSaucXniS2COSfLFjvt_w@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: Clear user_cpus_ptr only when no intersection
 with the new mask
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, longman@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Friendly ping...

On Tue, May 7, 2024 at 3:23=E2=80=AFPM Xuewen Yan <xuewen.yan@unisoc.com> w=
rote:
>
> The commit 851a723e45d1c("sched: Always clear user_cpus_ptr in do_set_cpu=
s_allowed()")
> would cause that online/offline cpu will produce different results
> for the !top-cpuset task.
> For example:
>
> If the task was running, then offline task's cpus, would lead to clear
> its user-mask.
>
> unisoc:/ # while true; do sleep 600; done&
> [1] 6786
> unisoc:/ # echo 6786 > /dev/cpuset/top-app/tasks
> unisoc:/ # cat /dev/cpuset/top-app/cpus
> 0-7
> unisoc:/ # cat /proc/6786/status | grep Cpus
> Cpus_allowed:   ff
> Cpus_allowed_list:      0-7
>
> unisoc:/ # taskset -p c0 6786
> pid 6786's current affinity mask: ff
> pid 6786's new affinity mask: c0
> unisoc:/ # cat /proc/6786/status | grep Cpus
> Cpus_allowed:   c0
> Cpus_allowed_list:      6-7
>
> After offline the cpu6 and cpu7, the user-mask would be cleared:
>
> unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu7/online
> unisoc:/ # cat /proc/6786/status | grep Cpus
> Cpus_allowed:   40
> Cpus_allowed_list:      6
> ums9621_1h10:/ # echo 0 > /sys/devices/system/cpu/cpu6/online
> ums9621_1h10:/ # cat /proc/6786/status | grep Cpus
> Cpus_allowed:   3f
> Cpus_allowed_list:      0-5
>
> When online the cpu6/7, the user-mask can not bring back:
>
> unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu6/online
> unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu7/online
> unisoc:/ # cat /proc/6786/status | grep Cpus
> Cpus_allowed:   ff
> Cpus_allowed_list:      0-6
>
> However, if we offline the cpu when the task is sleeping, at this
> time, because would not call the fallback_cpu(), its user-mask will
> not be cleared.
>
> unisoc:/ # while true; do sleep 600; done&
> [1] 5990
> unisoc:/ # echo 5990 > /dev/cpuset/top-app/tasks
> unisoc:/ # cat /proc/5990/status | grep Cpus
> Cpus_allowed:   ff
> Cpus_allowed_list:      0-7
>
> unisoc:/ # taskset -p c0 5990
> pid 5990's current affinity mask: ff
> pid 5990's new affinity mask: c0
> unisoc:/ # cat /proc/5990/status | grep Cpus
> Cpus_allowed:   c0
> Cpus_allowed_list:      6-7
>
> unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu6/online
> unisoc:/ # cat /proc/5990/status | grep Cpus
> Cpus_allowed:   80
> Cpus_allowed_list:      7
> unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu7/online
> unisoc:/ # cat /proc/5990/status | grep Cpus
> Cpus_allowed:   3f
> Cpus_allowed_list:      0-5
>
> After 10 minutes, it was waked up, it can also keep its user-mask:
> ums9621_1h10:/ # cat /proc/5990/status | grep Cpus
> Cpus_allowed:   3f
> Cpus_allowed_list:      0-5
>
> And when online the cpu6/7,the user-mask could bring back.
> unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu6/online
> unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu7/online
> unisoc:/ # cat /proc/6786/status | grep Cpus
> Cpus_allowed:   c0
> Cpus_allowed_list:      6-7
>
> Indeed, there is no need to clear the user_cpus_ptr if there is an
> intersection between user_cpus_ptr and new_mask.
> So add the judgement of whether there is an intersection between them.
> Clear user_cpus_ptr only when no intersection with the new mask.
> In this way, the above problems can also be solved.
>
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
> previous discussion:
>  https://lore.kernel.org/all/e402d623-1875-47a2-9db3-8299a54502ef@redhat.=
com/
> ---
>  kernel/sched/core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7019a40457a6..bbb8e88949f4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2796,21 +2796,24 @@ __do_set_cpus_allowed(struct task_struct *p, stru=
ct affinity_context *ctx)
>  }
>
>  /*
> - * Used for kthread_bind() and select_fallback_rq(), in both cases the u=
ser
> - * affinity (if any) should be destroyed too.
> + * Used for kthread_bind() and select_fallback_rq().
> + * Destroy user affinity if no intersection with the new_mask.
>   */
>  void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *ne=
w_mask)
>  {
>         struct affinity_context ac =3D {
>                 .new_mask  =3D new_mask,
>                 .user_mask =3D NULL,
> -               .flags     =3D SCA_USER,  /* clear the user requested mas=
k */
> +               .flags     =3D 0,
>         };
>         union cpumask_rcuhead {
>                 cpumask_t cpumask;
>                 struct rcu_head rcu;
>         };
>
> +       if (p->user_cpus_ptr && !cpumask_intersects(p->user_cpus_ptr, new=
_mask))
> +               ac.flags =3D SCA_USER;    /* clear the user requested mas=
k */
> +
>         __do_set_cpus_allowed(p, &ac);
>
>         /*
> --
> 2.25.1
>
>

