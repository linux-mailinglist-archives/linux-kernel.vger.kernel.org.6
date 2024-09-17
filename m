Return-Path: <linux-kernel+bounces-331327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C581C97AB58
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B87828C1ED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFF354F95;
	Tue, 17 Sep 2024 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gPJksEur"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514373A8F7
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726553961; cv=none; b=Vk1T7KceY/LdSLr6rPefB84GRqh1I3QcO08IRHTO8uuslJGTGduepvISpbKHbx05xApJm3p7AXVfwwWh/AscR/Zdog2ncVmG2NM7jWOnwTqjVnhOuBp/425XCoVuP90bIPEWSyvIV5gJ1+CCLvrFqReNwKKGfT4tgM8opw+uxpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726553961; c=relaxed/simple;
	bh=PPxQI8/Ol6thjErA4MShvQ6/FUJXqJ3cLMcF4VLikNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuhmBSkWRjMvqUu/4SYncDKs+Hu0l5bl0/NYTw/NWHEJ4jgv0T4ok09kponJScCk5k3apTMyqhOz6UZMn0bZz8fPB4Ji2i9kwYwhn9+nRXYzz84N+lvacV+UBiLTUy1TTM+IsTbUziraKb81qdZmUAW+gfJaLfMfTM5UryGHA7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gPJksEur; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so3368801a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 23:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726553959; x=1727158759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rKaSVCwL8V6+GJeMoSG0acZSwK+zyKLY/9ImuFAJRM=;
        b=gPJksEuryfP93Zub/MNXkTXsg2GS1TPCmg53pj7+8kw2+ckJ9KJlxm/Re/Fk+kkaM2
         oOsUVqfDyqDvupCh3A8xfID61R+Gu1Ca5Jd3AtMTtP46RwDv8DRrl0TuZABiDabIel74
         0EgNIePozCovWfum97yi39em5JETr0wmE4XC1L61GgTDvh0zaOJN6mYL2VZ0LPALSNhT
         XLQyj4ywKD5/m0BlvDrpyrjq4+YX5fHaW7SahTDHURkPXXqReYop1WQwT5owGIvFlW/J
         EAKxwdbFD94oEcXtJU9H61pxwipq3wRjSBe2gGdLG4B6Mx/0BUr6GRcYXYhmuz9A1JJv
         oQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726553959; x=1727158759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rKaSVCwL8V6+GJeMoSG0acZSwK+zyKLY/9ImuFAJRM=;
        b=ZVioXdTE5Qht76IaBdFUtv2FF3uASbPfNZxuDu+Fj4L6fIHOk1EdJhTHpOHkt7D5aX
         /aQCSG/OVJYhhrlX80tOz5bvFVgOcYA4mkM0/S56GGf/hUWC00n29HqZqgDaFED0ukEF
         may3Msq6emOOyaBAWuCY8Dj8oGSrDaEn2k/j3E32AKgJARE70ZLrmEjvntJXYKO1XOZE
         O/ZaOYJ4rfRptARjCESObyIH4u/K6W14CGW2zj2W+kdyaRdcRY0xu+wElRPxGA4F7vaj
         v2FN9Zx0i/gl/94yqgYfLmsxKzFbsXYWZySO49CIRBNjTpSuDkfb0xD4wpSDRmqL3eHG
         oPkw==
X-Forwarded-Encrypted: i=1; AJvYcCXSfby/7DdPkBVVbgwqc/m5uFX9zFtwgvXZpxqL5kCWvuJHGJz3WGm96FT0L9WBjSu8pDiZ/bLhd77zjzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC4BeIwKsPopELT8TCfDj8mfIzAvwiq/XD5SUc5lVuaCqF3X6y
	xbhBiGTe5S1PNXYpOmb14YfIrhu7bRO51CLdBiD/Kd7UCXClrk8bMWXC8qeab1NvGoHNWSnjgnX
	oANMQ76YQBlA9oJTTZXEyCJKdAHZghnm4y1n5eg==
X-Google-Smtp-Source: AGHT+IFuW6dBNf3DOn+Q2nKitRY27VuOT+N2wFm4dWqungxdicQl/uT9EyLoawRHLMVTRfq/KuMW5W8Zp0OjVBTXoBM=
X-Received: by 2002:a17:90b:886:b0:2d3:c0b9:7c2a with SMTP id
 98e67ed59e1d1-2db9ffee669mr20639834a91.20.1726553958529; Mon, 16 Sep 2024
 23:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725120315.212428-1-zhengzucheng@huawei.com>
 <3e68ccda-1606-9494-f57a-75be9668b83d@huawei.com> <cb3a3f3e-727a-4cbb-b4a8-f9469ed4f08d@redhat.com>
 <9982cb8d-9346-0640-dd9f-f68390f922e9@huawei.com> <CAKfTPtCdfzZ9Wxr7+zH5WW171LJGttgzto4W2wH9mm4d0jcTLg@mail.gmail.com>
 <f389a220-b628-575a-7af1-d897ee5730cc@huawei.com>
In-Reply-To: <f389a220-b628-575a-7af1-d897ee5730cc@huawei.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 17 Sep 2024 08:19:07 +0200
Message-ID: <CAKfTPtDMuqJUKfKSJNXMCPP13SfhG_sXMF2VUMw=6DD1XmxhWg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BQuestion=5D_sched=EF=BC=9Athe_load_is_unbalanced_in_the?=
	=?UTF-8?Q?_VM_overcommitment_scenario?=
To: zhengzucheng <zhengzucheng@huawei.com>
Cc: Waiman Long <longman@redhat.com>, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, oleg@redhat.com, 
	Frederic Weisbecker <frederic@kernel.org>, mingo@kernel.org, peterx@redhat.com, tj@kernel.org, 
	tjcao980311@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Sept 2024 at 09:04, zhengzucheng <zhengzucheng@huawei.com> wrote=
:
>
>
> =E5=9C=A8 2024/9/13 23:55, Vincent Guittot =E5=86=99=E9=81=93:
> > On Fri, 13 Sept 2024 at 06:03, zhengzucheng <zhengzucheng@huawei.com> w=
rote:
> >> In the VM overcommitment scenario, the overcommitment ratio is 1:2, 8
> >> CPUs are overcommitted to 2 x 8u VMs,
> >> and 16 vCPUs are bound to 8 cpu. However, one VM obtains only 2 CPUs
> >> resources, the other VM has 6 CPUs.
> >> The host is configured with 80 CPUs in a sched domain and other CPUs a=
re
> >> in the idle state.
> >> The root cause is that the load of the host is unbalanced, some vCPUs
> >> exclusively occupy CPU resources.
> >> when the CPU that triggers load balance calculates imbalance value,
> >> env->imbalance =3D 0 is calculated because of
> >> local->avg_load > sds->avg_load. As a result, the load balance fails.
> >> The processing logic:
> >> https://github.com/torvalds/linux/commit/91dcf1e8068e9a8823e419a7a34ff=
4341275fb70
> >>
> >>
> >> It's normal from kernel load balance, but it's not reasonable from the
> >> perspective of VM users.
> >> In cgroup v1, set cpuset.sched_load_balance=3D0 to modify the schedule
> >> domain to fix it.
> >> Is there any other method to fix this problem? thanks.
> > I'm not sure how to understand your setup and why the load balance is
> > not balancing correctly 16 vCPU between the 8 CPUs.
> >
> > >From your test case description below,  you have 8 always running
> > threads in cgroup A and 8 always running threads in cgroup B and the 2
> > cgroups have only 8 CPUs among 80. This should not be a problem for
> > load balance. I tried something similar although not exactly the same
> > with cgroupv2 and rt-app and I don't have noticeable imbalance
> >
> > Do you have more details that you can share about your system ?
> >
> > Which kernel version are you using ? Which arch ?
>
> kernel version: 6.11.0-rc7
> arch: X86_64 and cgroup v1

okay

>
> >> Abstracted reproduction case=EF=BC=9A
> >> 1.environment information=EF=BC=9A
> >>
> >> [root@localhost ~]# cat /proc/schedstat
> >>
> >> cpu0
> >> domain0 00000000,00000000,00010000,00000000,00000001
> >> domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
> >> domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
> >> cpu1
> >> domain0 00000000,00000000,00020000,00000000,00000002
> >> domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
> >> domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
> >> cpu2
> >> domain0 00000000,00000000,00040000,00000000,00000004
> >> domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
> >> domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
> >> cpu3
> >> domain0 00000000,00000000,00080000,00000000,00000008
> >> domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
> >> domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
> > Is it correct to assume that domain0 is SMT, domain1 MC and domain2 PKG=
  ?
> >   and cpu80-83 are in the other group of PKG ? and LLC is at domain1 le=
vel ?
>
> domain0 is SMT and domain1 is MC
> thread_siblings_list:0,80. 1,81. 2,82. 3,83

Yeah, I should have read more carefully the domain0 cpumask

> LLC is at domain1 level
>
> >> 2.test case:
> >>
> >> vcpu.c
> >> #include <stdio.h>
> >> #include <unistd.h>
> >>
> >> int main()
> >> {
> >>           sleep(20);
> >>           while (1);
> >>           return 0;
> >> }
> >>
> >> gcc vcpu.c -o vcpu
> >> -----------------------------------------------------------------
> >> test.sh
> >>
> >> #!/bin/bash
> >>
> >> #vcpu1
> >> mkdir /sys/fs/cgroup/cpuset/vcpu_1
> >> echo '0-3, 80-83' > /sys/fs/cgroup/cpuset/vcpu_1/cpuset.cpus
> >> echo 0 > /sys/fs/cgroup/cpuset/vcpu_1/cpuset.mems
> >> for i in {1..8}
> >> do
> >>           ./vcpu &
> >>           pid=3D$!
> >>           sleep 1
> >>           echo $pid > /sys/fs/cgroup/cpuset/vcpu_1/tasks
> >> done
> >>
> >> #vcpu2
> >> mkdir /sys/fs/cgroup/cpuset/vcpu_2
> >> echo '0-3, 80-83' > /sys/fs/cgroup/cpuset/vcpu_2/cpuset.cpus
> >> echo 0 > /sys/fs/cgroup/cpuset/vcpu_2/cpuset.mems
> >> for i in {1..8}
> >> do
> >>           ./vcpu &
> >>           pid=3D$!
> >>           sleep 1
> >>           echo $pid > /sys/fs/cgroup/cpuset/vcpu_2/tasks
> >> done
> >> ------------------------------------------------------------------
> >> [root@localhost ~]# ./test.sh
> >>
> >> [root@localhost ~]# top -d 1 -c -p $(pgrep -d',' -f vcpu)
> >>
> >> 14591 root      20   0    2448   1012    928 R 100.0   0.0 13:10.73 ./=
vcpu
> >> 14582 root      20   0    2448   1012    928 R 100.0   0.0 13:12.71 ./=
vcpu
> >> 14606 root      20   0    2448    872    784 R 100.0   0.0 13:09.72 ./=
vcpu
> >> 14620 root      20   0    2448    916    832 R 100.0   0.0 13:07.72 ./=
vcpu
> >> 14622 root      20   0    2448    920    836 R 100.0   0.0 13:06.72 ./=
vcpu
> >> 14629 root      20   0    2448    920    832 R 100.0   0.0 13:05.72 ./=
vcpu
> >> 14643 root      20   0    2448    924    836 R  21.0   0.0 2:37.13 ./v=
cpu
> >> 14645 root      20   0    2448    868    784 R  21.0   0.0 2:36.51 ./v=
cpu
> >> 14589 root      20   0    2448    900    816 R  20.0   0.0 2:45.16 ./v=
cpu
> >> 14608 root      20   0    2448    956    872 R  20.0   0.0 2:42.24 ./v=
cpu
> >> 14632 root      20   0    2448    872    788 R  20.0   0.0 2:38.08 ./v=
cpu
> >> 14638 root      20   0    2448    924    840 R  20.0   0.0 2:37.48 ./v=
cpu
> >> 14652 root      20   0    2448    928    844 R  20.0   0.0 2:36.42 ./v=
cpu
> >> 14654 root      20   0    2448    924    840 R  20.0   0.0 2:36.14 ./v=
cpu
> >> 14663 root      20   0    2448    900    816 R  20.0   0.0 2:35.38 ./v=
cpu
> >> 14669 root      20   0    2448    868    784 R  20.0   0.0 2:35.70 ./v=
cpu
> >>

So I finally understood your situation. The limited cpuset screws up
the avg load of system for domain1. The group_imbalanced state is
there to try to fix an imbalanced situation related to tasks that are
pinned to a subset of CPUs of the sched domain. But this can't cover
all cases.

> > .

