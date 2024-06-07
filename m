Return-Path: <linux-kernel+bounces-205825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C2F9000DC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F88A1F25DBF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C8515E5C8;
	Fri,  7 Jun 2024 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOpIc55N"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D4515B967
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756364; cv=none; b=m8HOzZauil8o1YglxRp1lZHssAUipvutsgBUuoME4Wjph7JAVyf/QPfdO1Oa/0tGT5VcNm/V/Q7wjsqYUylgntTFYffXhYt3YFlozp0QngQK28QrhKqABHl3GCqC2Fyv6jQnJ6x2Rr6kYN7cTDl9WRkHU6tkI2ymGOWgbyx2uQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756364; c=relaxed/simple;
	bh=os0cVuPzw+jWCbn9VAhGFBwppdv0iftcBV0RHdJQu8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I50MJ72uHBOMRryUO0G12Vw98U4MsS7CRbN46cL/+jzB/hW6bKYGpClfrypVuB9bkHlb3a7/IB+BGH6eHch41p0Dzr3Gyzgejq9waRCIgdHTZf0FdsjW2FznqkTQWoZKV3UuoryisKTx6014zDhCkT+Zdp14us7duQTFFE8bHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOpIc55N; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2547e1c7bbeso75899fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 03:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717756361; x=1718361161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNWU6NevmfP/UVY2xrrnkXoHv1zTsYjWHUFESWwCj/8=;
        b=lOpIc55N8Y9hKOX+QQK0VogJcX1sBx4gMqlfnuR6egxHndcMsPSsAqiTQaTFSCngxb
         ZY4+VfGO12xonkUftx11B5/D5UiOH2zkooJUrYsZGqkwKE0nFt0OSdg2LgvIeSQKKE7V
         e8hrp7dqFDWGXIurWckKW8RVYnUgpcW+yfZ6nidwsSwloNdFvTSZ90Pgp5m8U0ikTIbs
         NH5rGt986F9PH36hxINXX35SVsWjbIBLMjHRLphDdRbQqdToPp7Hq7dCGM8umBmliOJR
         +/JEyaABNHneJxaS6uYewh22PYKE4nQ0gill0LOves+OZI2Z93m3ydVEvvICHm6Z37uX
         tU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717756361; x=1718361161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNWU6NevmfP/UVY2xrrnkXoHv1zTsYjWHUFESWwCj/8=;
        b=CbfvqER8fLdVfAi5wBCjDLNu75lL/DJbjVK2sY713zTFGkjX8mNa4aQhNVd7P/SM03
         yIwoodhNSkazz2g0ELFPmBqLbzKhr6toJgw5lPNCqDC5jbdVmOS/ltQWPY+coe41FbrE
         kuDuOeIY2FHvYhn2zOPOQeDf7XpR+Zoyq9TKrEIwDo7HAZSeRbTr5BOvY2p9OazHT8ZF
         YaDt/dhHEKuMZ+VS381/FHk4mtN8zhYi/A0YToH2OuRAem/pc7ZucEUWJR7y6wklJRlF
         rfXwwHBBRNNstD7H/WP685VVOICTsm6lFLMuORVD1Mu+XJ17dB9aSs7OJv1x+7MzMQny
         hC5w==
X-Forwarded-Encrypted: i=1; AJvYcCVRZTpvox2nzGleVhKm2A42/W93u7Y0SdfjVdTd8ukRM08d4sDMnf2DyU6wmmQNH12xcouJEjnfORhM811wdheGz9DYGpQWylNNtPrd
X-Gm-Message-State: AOJu0YzyTluFLJQNSCQ8l3jfTjGyGhVuWzJhVMM759cCE0LIKQJKri46
	gDFqXXFTNK/0BAs9NUO4S+mWbCZlIKEzXmtV8/GcIhX+yf1CETAAziWHtQANJ1lILWlPp8ajO7c
	/1Qp1kVFKb7QcbHX00eiEbpf+IqM=
X-Google-Smtp-Source: AGHT+IFihNgTHkTKtEHFmdxD5PcHYYJNrfIij0oP9vRuroIVk4WKeGn8wwbTlwgWwdeXzuj9/dJJxtR2CNBOz/zQ2mY=
X-Received: by 2002:a05:6870:c1d4:b0:250:129a:d0ef with SMTP id
 586e51a60fabf-25464e9e9a6mr2164048fac.36.1717756361069; Fri, 07 Jun 2024
 03:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507072242.585-1-xuewen.yan@unisoc.com> <ZmLavE/tO66VUP3D@linux.ibm.com>
In-Reply-To: <ZmLavE/tO66VUP3D@linux.ibm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Fri, 7 Jun 2024 18:32:30 +0800
Message-ID: <CAB8ipk8N5MjmPDJzBdc-FZdtVAG7-Wa1YNjq2U05sDPCxE3tgQ@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: Clear user_cpus_ptr only when no intersection
 with the new mask
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, longman@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, ke.wang@unisoc.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Saket

On Fri, Jun 7, 2024 at 6:02=E2=80=AFPM Saket Kumar Bhaskar <skb99@linux.ibm=
.com> wrote:
>
> On Tue, May 07, 2024 at 03:22:42PM +0800, Xuewen Yan wrote:
> > The commit 851a723e45d1c("sched: Always clear user_cpus_ptr in do_set_c=
pus_allowed()")
> > would cause that online/offline cpu will produce different results
> > for the !top-cpuset task.
> > For example:
> >
> > If the task was running, then offline task's cpus, would lead to clear
> > its user-mask.
> >
> > unisoc:/ # while true; do sleep 600; done&
> > [1] 6786
> > unisoc:/ # echo 6786 > /dev/cpuset/top-app/tasks
> > unisoc:/ # cat /dev/cpuset/top-app/cpus
> > 0-7
> > unisoc:/ # cat /proc/6786/status | grep Cpus
> > Cpus_allowed:   ff
> > Cpus_allowed_list:      0-7
> >
> > unisoc:/ # taskset -p c0 6786
> > pid 6786's current affinity mask: ff
> > pid 6786's new affinity mask: c0
> > unisoc:/ # cat /proc/6786/status | grep Cpus
> > Cpus_allowed:   c0
> > Cpus_allowed_list:      6-7
> >
> > After offline the cpu6 and cpu7, the user-mask would be cleared:
> >
> > unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu7/online
> > unisoc:/ # cat /proc/6786/status | grep Cpus
> > Cpus_allowed:   40
> > Cpus_allowed_list:      6
> > ums9621_1h10:/ # echo 0 > /sys/devices/system/cpu/cpu6/online
> > ums9621_1h10:/ # cat /proc/6786/status | grep Cpus
> > Cpus_allowed:   3f
> > Cpus_allowed_list:      0-5
> >
> > When online the cpu6/7, the user-mask can not bring back:
> >
> > unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu6/online
> > unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu7/online
> > unisoc:/ # cat /proc/6786/status | grep Cpus
> > Cpus_allowed:   ff
> > Cpus_allowed_list:      0-6
> >
> > However, if we offline the cpu when the task is sleeping, at this
> > time, because would not call the fallback_cpu(), its user-mask will
> > not be cleared.
> >
> > unisoc:/ # while true; do sleep 600; done&
> > [1] 5990
> > unisoc:/ # echo 5990 > /dev/cpuset/top-app/tasks
> > unisoc:/ # cat /proc/5990/status | grep Cpus
> > Cpus_allowed:   ff
> > Cpus_allowed_list:      0-7
> >
> > unisoc:/ # taskset -p c0 5990
> > pid 5990's current affinity mask: ff
> > pid 5990's new affinity mask: c0
> > unisoc:/ # cat /proc/5990/status | grep Cpus
> > Cpus_allowed:   c0
> > Cpus_allowed_list:      6-7
> >
> > unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu6/online
> > unisoc:/ # cat /proc/5990/status | grep Cpus
> > Cpus_allowed:   80
> > Cpus_allowed_list:      7
> > unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu7/online
> > unisoc:/ # cat /proc/5990/status | grep Cpus
> > Cpus_allowed:   3f
> > Cpus_allowed_list:      0-5
> >
> > After 10 minutes, it was waked up, it can also keep its user-mask:
> > ums9621_1h10:/ # cat /proc/5990/status | grep Cpus
> > Cpus_allowed:   3f
> > Cpus_allowed_list:      0-5
> >
> > And when online the cpu6/7,the user-mask could bring back.
> > unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu6/online
> > unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu7/online
> > unisoc:/ # cat /proc/6786/status | grep Cpus
> > Cpus_allowed:   c0
> > Cpus_allowed_list:      6-7
> >
> > Indeed, there is no need to clear the user_cpus_ptr if there is an
> > intersection between user_cpus_ptr and new_mask.
> > So add the judgement of whether there is an intersection between them.
> > Clear user_cpus_ptr only when no intersection with the new mask.
> > In this way, the above problems can also be solved.
> >
> > Suggested-by: Waiman Long <longman@redhat.com>
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> > previous discussion:
> >  https://lore.kernel.org/all/e402d623-1875-47a2-9db3-8299a54502ef@redha=
t.com/
> > ---
> >  kernel/sched/core.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 7019a40457a6..bbb8e88949f4 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2796,21 +2796,24 @@ __do_set_cpus_allowed(struct task_struct *p, st=
ruct affinity_context *ctx)
> >  }
> >
> >  /*
> > - * Used for kthread_bind() and select_fallback_rq(), in both cases the=
 user
> > - * affinity (if any) should be destroyed too.
> > + * Used for kthread_bind() and select_fallback_rq().
> > + * Destroy user affinity if no intersection with the new_mask.
> >   */
> >  void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *=
new_mask)
> >  {
> >       struct affinity_context ac =3D {
> >               .new_mask  =3D new_mask,
> >               .user_mask =3D NULL,
> > -             .flags     =3D SCA_USER,  /* clear the user requested mas=
k */
> > +             .flags     =3D 0,
> >       };
> >       union cpumask_rcuhead {
> >               cpumask_t cpumask;
> >               struct rcu_head rcu;
> >       };
> >
> > +     if (p->user_cpus_ptr && !cpumask_intersects(p->user_cpus_ptr, new=
_mask))
> > +             ac.flags =3D SCA_USER;    /* clear the user requested mas=
k */
> > +
> >       __do_set_cpus_allowed(p, &ac);
> >
> >       /*
> > --
> > 2.25.1
> >
>
> Hi Xuewen,
>
> I have a query here:
>
> 1. From the example where task is running, " while true; do sleep 600; do=
ne& "
>    is being used, which is a sleeping task. How running task is emulated =
here?
>
> 2. Tried without patch (6.9.0-rc4) on a 64 CPUs system. Results are:
>
>    For a task that is running:
>
>    # stress-ng -l 100 --cpu 1
>    stress-ng: info:  [2307] defaulting to a 86400 second (1 day, 0.00 sec=
s) run per stressor
>    stress-ng: info:  [2307] dispatching hogs: 1 cpu
>
>    #taskset -p c0 2308
>    pid 2308's current affinity mask: ffffffffffffffff
>    pid 2308's new affinity mask: c0
>
>    # cat /proc/2308/status |grep Cpus
>    Cpus_allowed:        00000000,000000c0
>    Cpus_allowed_list:   6-7
>
>    #chcpu -d 6,7
>    CPU 6 disabled
>    CPU 7 disabled
>
>    After disabling CPUs 6 and 7:
>
>    # cat /proc/2308/status |grep Cpus
>    Cpus_allowed:        ffffffff,ffffffff
>    Cpus_allowed_list:   0-63
>
>    After enabling CPUs 6 and 7:
>
>    ## chcpu -e 6,7
>    CPU 6 enabled
>    CPU 7 enabled
>
>    # cat /proc/2308/status |grep Cpus
>    Cpus_allowed:        ffffffff,ffffffff
>    Cpus_allowed_list:   0-63
>
>    From the above output, after disabling CPUs 6 and 7, all the CPUs in t=
he
>    system are displayed rather than showing only remaining online CPUs(as
>    shown in above example).
>
>    For a task that is sleeping:
>
>    # while true; do sleep 60; done&
>    [1] 2541
>
>    # taskset -p c0 2541
>    pid 2541's current affinity mask: ffffffffffffffff
>    pid 2541's new affinity mask: c0
>
>    # cat /proc/2541/status |grep Cpus
>    Cpus_allowed:        00000000,000000c0
>    Cpus_allowed_list:   6-7
>
>    After disabling CPUs 6 and 7:
>
>    # chcpu -d 6,7
>    CPU 6 disabled
>    CPU 7 disabled
>
>    # cat /proc/2541/status |grep Cpus
>    Cpus_allowed:        00000000,000000c0
>    Cpus_allowed_list:   6-7
>
>    After 1 minute:
>
>    # cat /proc/2541/status |grep Cpus
>    Cpus_allowed:        ffffffff,ffffffff
>    Cpus_allowed_list:   0-63
>
>    # chcpu -e 6,7
>    CPU 6 enabled
>    CPU 7 enabled
>
>    # cat /proc/2541/status |grep Cpus
>    Cpus_allowed:        ffffffff,ffffffff
>    Cpus_allowed_list:   0-63
>
>    From the above output, after disabling CPUs 6 and 7, it waked up after
>    1 minute and Cpus_allowed_list got changed to 0-63 (which is contrary
>    to the above example).
>
>    So, there is some deviation in behaviour seen without the patch,
>    than reported or am I missing something?

Whether the thread you are testing belongs to top-cpuset? If so, I
think is normal.
And you can see the patch: 3fb906e7fabbb (group/cpuset: Don't filter
offline CPUs in cpuset_cpus_allowed() for top cpuset tasks).

BR
---
xuewen
>
> Thanks and regards,
> Saket Kumar Bhaskar

