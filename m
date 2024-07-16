Return-Path: <linux-kernel+bounces-253734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 321E8932614
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B356C1F22C57
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5D3195FE8;
	Tue, 16 Jul 2024 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfPU+mCO"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B411CA9F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721131273; cv=none; b=qP9QJ5PQWOPidIty/NbYaRFj0qDerwyzabQraUDNm4PpMgX4FEh0ruLm+K6zEHJFb9E4r6Allh7yexvldqoZ1eVVH093Woct5+QnQgXLXZW2kNg74cEalf1Zg3ev5ODX6rD+1uTU3IbgBdyKb3nSPGTqZVI+9uY4if+kYtL5FPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721131273; c=relaxed/simple;
	bh=WLrC6303y1CuWwTqT4Hq19/LjVv0oNDQam+0R7DofS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlZmDwFJjdtILTOLCl0Jf6cgqSBOHn2atB5g+woQZov+Ogx7Rkus70rXwvwOaMgb4HjaDex9i1MaxEUQglR9dtgYANVrJGkoIXAvL8uqiwHkoiB8VYCwbwlx/9ToF8YFfUwy9/RrSqNhebsAfzc0swnxO6PmexxKQrrCuJ0G7PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfPU+mCO; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-25e134abf00so2651653fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721131271; x=1721736071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8G+O43a2cJN5Lg9/71+1+Z/ywQQTj8X6yfoV7PP9dU=;
        b=DfPU+mCOfLxbeiIg0iO4bkpHKWO2M4wEyWn43KdoN2XXQMKn0NrGdz5hJFikkxj1wd
         8jUbxB0BEWsLE6lp6nOEk88Md0LAyxLW6CxzriGWXs6PWDOu44jb1lbPW6u8zYKdiuFw
         V+eZhULxDIAla+j0k0y7EtGsnrRZtKuLFIV1G9ULrOxeyvk4DM0K4oJNJHVcuQnrRQqu
         2kUHQdQpzxC6eNhL5O21LiwD9gMVpBgYHZfPxHkvPFrAfIDZgNfRyN6mKhlRvig4CiTx
         nnEWF7VBRhtyakUnarZrmfrsYinRGE2ytClHvMynCuoLUNQY0WceCch23Rcs/ZOnWJ7F
         UaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721131271; x=1721736071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8G+O43a2cJN5Lg9/71+1+Z/ywQQTj8X6yfoV7PP9dU=;
        b=IfnzXIKLZB3ez6ov/CKrt3QjA9SAELAwxF+OYbRE1dXCcl0bcH8JbGMENtTyy4pw6k
         u84LHeLyLKOZn+0Hzefs095K1UyEuKeY+CtQoxzImyocploIk6zonYO1aFfQLGYwKwu/
         ND0yuHjaW2XqQfiy5D3g+xAWCrRviRpDE7cK+HRrmKpaUkmVfFpdW7tQQWpXrElP0gYo
         TjjyJypXN/REDR/I6PXUuJuxMoE7RqZNu/+/2fxCeEJTuMkSlOHnqpUWRuDREaZIff/V
         6qWLi/3ssxpurN2eg4kcliVLmzP/51/l6AnaSIxLSZoymgLJr8561Vx6MXqIWIco0ahx
         E3Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUk8jFvpghDGUAm//ZvihF8Q5yQ31G9MksshAXerPfvM73Fe/KC7GhT4f5VU2tvkgpwChGDv9ebYjEwKDrCBBe0EFYPaNOF510RcojA
X-Gm-Message-State: AOJu0YxI/RzGfhZS6B01mcJrhHYz9FRhLaaXjsT+SQHQfsVCmKkSPz76
	MEA5ks8jRLgEYcV+HfK3fXH9fwBsqsdqdRYBE/3kTAJFcZqL8QqNyUxWYIu3V0rcELB0HOmBjFQ
	ziz9o2Gv+HoXO1xtp39++eTJp9Q0=
X-Google-Smtp-Source: AGHT+IGjNegrAaFQHqDetHpbOkioAUdczDLg0HOi4yOfbP20ScveXYR6yf2v9NSMbFQJuVkNuifZ4o03vbMlD0wOdIw=
X-Received: by 2002:a05:6871:5223:b0:25e:bd3d:624a with SMTP id
 586e51a60fabf-260bd52cf0emr1401551fac.7.1721131271161; Tue, 16 Jul 2024
 05:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507072242.585-1-xuewen.yan@unisoc.com>
In-Reply-To: <20240507072242.585-1-xuewen.yan@unisoc.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 16 Jul 2024 20:01:00 +0800
Message-ID: <CAB8ipk_dy1PyAowefiysS_QB_sxiW9bQD_Y+AQp_b_iUTWhqbw@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: Clear user_cpus_ptr only when no intersection
 with the new mask
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, longman@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org, 
	Saket Kumar Bhaskar <skb99@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Friendly ping..

Could anyone please give some comments?

Thanks!

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

