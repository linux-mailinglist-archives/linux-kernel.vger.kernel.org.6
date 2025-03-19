Return-Path: <linux-kernel+bounces-567417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DE5A685AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F71D423475
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD35E1991CD;
	Wed, 19 Mar 2025 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4nWVAFCY"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB3922094
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742368673; cv=none; b=rgJiLJDt4l2GLog/wheYhIfk+E1DWi5eW7xmqAyuDFj9qFdvFQ93kJszqW5j/eh2+nmhiXerGiJmEYympBl525Di+wWEXZ3XKEz84AiUdQJwvvnQQjyItAX64scAF4QdqEJcWl0FHxGfTr2+Ud91Z0nFBeSFJ4EkFA2zLNwnCNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742368673; c=relaxed/simple;
	bh=vt44rzjhWVgeITUyhaSgN8a16HAn/tFr/x+0In0XnmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbzYo6Df3uVOihud3cPh7QiPvt5uN1VklhFoGD1NL71tPs8lYzhvawM7Lg4MEqXrQ6hDhx/nS8KF/jQiJU1sxhUbJn/2aC8cYgYr6tWHpnaAk42RWgiAmjyP13JnIWlhk89ToNJKDg6Lm93UZ31PoGZaiexH/eRBJaKCaRaHpnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4nWVAFCY; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-549924bc82aso3637e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 00:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742368669; x=1742973469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KU9HnwjDebldqtBx4QeCjTCYcgz8DT96ZzxqdTu8Q8=;
        b=4nWVAFCYBT8W3ahM18NLv8yevFG7gMVE2FpuGJKEL1WItFjed1Cp8tXnTlqAu6DpcS
         KTlGCGtN9R1VamTka+d7dRppjVA04MdIHpU1+gDrXZmsDRnjUqEE8v1e27xFi6UvBM/R
         EZuXjkF04cioLt0X/uVPG5G/XRlzsUyHFNrfFmq+vUtv6/R5TYLsEt84V6xANIlgRZh0
         nZ7iuOX3TT5WvoWquBmNUDJFxR/zEfzkNPo6dWP2naHmRn/SJxeI3BnbS9Hhp5IpyPAW
         xi8xGIZPok03BvOGVleuiJ3CLHxgJyESe10/lPipujfdTBxo99hrkblowrI6cMDYz3U5
         qO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742368669; x=1742973469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KU9HnwjDebldqtBx4QeCjTCYcgz8DT96ZzxqdTu8Q8=;
        b=Ym0dvoI6QB23UQZoZ6gNOsOpm4Vi2UzwaghZD6ZlyqHv3SdA0RgX2DgOH5xoWicFYO
         vqVgBhJQz6qMjE81jJ+Md07r5EEtEgaoK34v6v4oBMrC3zxZX2/AiESm99cWzn75ex9P
         UrHTxX5HK5jCMFoa0OmodJnJCXyY9PjFxPNi70AJ0dt1akWQimeA8fP9Bp5ZXCAWM9OU
         rxzDTA0ex18lwsFhHeqpFwtKAr2tkSYOvjZEswKb6rrMLWy5o9sRXtlGdQYj1xsQ3B+A
         jZ+0hhw5r74HC/10XduzHsvI8MnAd2ejZXKyyXuAhY79HcxhfwOo+8Z7xHGgRZzWgmTB
         yIBw==
X-Forwarded-Encrypted: i=1; AJvYcCWeVadqPVZGaZOGV0m0qveFhZ/pJG854QMvoHa+XB3PWl3PHios7y+o3ZFEEKp+vz02bigTc20UlhgqtRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc4C8tFP+ho6Qxy3MIIDA51BIGcGS7brkLe6pWTB7EZfwptrsa
	WXKN3vjgMwFWxzRx/m2Pq99NAMsjiWIZynTDlUtq82HfnUBdbbT941ALEW9yolj28TvjuiINPbS
	KqyPp7SZMZtua/BNnsZ2hMACIuPs7dzaQKIwp
X-Gm-Gg: ASbGnctCB/8poIN8+GNeghoZODh8jJXA7fRP/bBH8ofydOMmJkfr9qJkxwRp/uzK2Vt
	5dg6zYHNRpIq/oX+fvdLTuDPWU1PIp3g2dfefoBoXHrOgx/NxjiuU2K4GWODz8GM5hF5QubHegS
	DmAArQbNHOArkDu1Y4zv7lNLSmSQ==
X-Google-Smtp-Source: AGHT+IGAuYELn1G87/xbGf4nJJAc6yxKnaHo9lkXX2pHo7+K5xnrKuihHzBJgwOlUA+gTl6bWjvlUKKpgs3k02Bbgoc=
X-Received: by 2002:a05:6512:3da7:b0:542:6b39:1d57 with SMTP id
 2adb3069b0e04-54acafe30e4mr153843e87.3.1742368668855; Wed, 19 Mar 2025
 00:17:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319071330.898763-1-gthelen@google.com>
In-Reply-To: <20250319071330.898763-1-gthelen@google.com>
From: Greg Thelen <gthelen@google.com>
Date: Wed, 19 Mar 2025 00:17:12 -0700
X-Gm-Features: AQ5f1JoP9xcA4Ytb0_6iu1s5e84MKlmwW3vfsv1tKFtcMFfXXevba6DA_ParSgI
Message-ID: <CAHH2K0Yief2sdxnWHjqFz3NomEzZOsyy0y57fYH9f_wCAmKH+A@mail.gmail.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(fix mistyped CC address to Eric)

On Wed, Mar 19, 2025 at 12:13=E2=80=AFAM Greg Thelen <gthelen@google.com> w=
rote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> cgroup_rstat_flush_locked() grabs the irq safe cgroup_rstat_lock while
> iterating all possible cpus. It only drops the lock if there is
> scheduler or spin lock contention. If neither, then interrupts can be
> disabled for a long time. On large machines this can disable interrupts
> for a long enough time to drop network packets. On 400+ CPU machines
> I've seen interrupt disabled for over 40 msec.
>
> Prevent rstat from disabling interrupts while processing all possible
> cpus. Instead drop and reacquire cgroup_rstat_lock for each cpu. This
> approach was previously discussed in
> https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/,
> though this was in the context of an non-irq rstat spin lock.
>
> Benchmark this change with:
> 1) a single stat_reader process with 400 threads, each reading a test
>    memcg's memory.stat repeatedly for 10 seconds.
> 2) 400 memory hog processes running in the test memcg and repeatedly
>    charging memory until oom killed. Then they repeat charging and oom
>    killing.
>
> v6.14-rc6 with CONFIG_IRQSOFF_TRACER with stat_reader and hogs, finds
> interrupts are disabled by rstat for 45341 usec:
>   #  =3D> started at: _raw_spin_lock_irq
>   #  =3D> ended at:   cgroup_rstat_flush
>   #
>   #
>   #                    _------=3D> CPU#
>   #                   / _-----=3D> irqs-off/BH-disabled
>   #                  | / _----=3D> need-resched
>   #                  || / _---=3D> hardirq/softirq
>   #                  ||| / _--=3D> preempt-depth
>   #                  |||| / _-=3D> migrate-disable
>   #                  ||||| /     delay
>   #  cmd     pid     |||||| time  |   caller
>   #     \   /        ||||||  \    |    /
>   stat_rea-96532    52d....    0us*: _raw_spin_lock_irq
>   stat_rea-96532    52d.... 45342us : cgroup_rstat_flush
>   stat_rea-96532    52d.... 45342us : tracer_hardirqs_on <-cgroup_rstat_f=
lush
>   stat_rea-96532    52d.... 45343us : <stack trace>
>    =3D> memcg1_stat_format
>    =3D> memory_stat_format
>    =3D> memory_stat_show
>    =3D> seq_read_iter
>    =3D> vfs_read
>    =3D> ksys_read
>    =3D> do_syscall_64
>    =3D> entry_SYSCALL_64_after_hwframe
>
> With this patch the CONFIG_IRQSOFF_TRACER doesn't find rstat to be the
> longest holder. The longest irqs-off holder has irqs disabled for
> 4142 usec, a huge reduction from previous 45341 usec rstat finding.
>
> Running stat_reader memory.stat reader for 10 seconds:
> - without memory hogs: 9.84M accesses =3D> 12.7M accesses
> -    with memory hogs: 9.46M accesses =3D> 11.1M accesses
> The throughput of memory.stat access improves.
>
> The mode of memory.stat access latency after grouping by of 2 buckets:
> - without memory hogs: 64 usec =3D> 16 usec
> -    with memory hogs: 64 usec =3D>  8 usec
> The memory.stat latency improves.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Greg Thelen <gthelen@google.com>
> Tested-by: Greg Thelen <gthelen@google.com>
> ---
>  kernel/cgroup/rstat.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index aac91466279f..976c24b3671a 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -323,13 +323,11 @@ static void cgroup_rstat_flush_locked(struct cgroup=
 *cgrp)
>                         rcu_read_unlock();
>                 }
>
> -               /* play nice and yield if necessary */
> -               if (need_resched() || spin_needbreak(&cgroup_rstat_lock))=
 {
> -                       __cgroup_rstat_unlock(cgrp, cpu);
> -                       if (!cond_resched())
> -                               cpu_relax();
> -                       __cgroup_rstat_lock(cgrp, cpu);
> -               }
> +               /* play nice and avoid disabling interrupts for a long ti=
me */
> +               __cgroup_rstat_unlock(cgrp, cpu);
> +               if (!cond_resched())
> +                       cpu_relax();
> +               __cgroup_rstat_lock(cgrp, cpu);
>         }
>  }
>
> --
> 2.49.0.rc1.451.g8f38331e32-goog
>

