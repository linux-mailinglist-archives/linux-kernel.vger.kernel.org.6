Return-Path: <linux-kernel+bounces-328522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEA3978539
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2541F252C3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA93C6E2BE;
	Fri, 13 Sep 2024 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rSRwJJnD"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE4655898
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242937; cv=none; b=HQv5UOacD9ytnTollFAVeNR839nsA9sRdJT4PVWzcMmCOxIsyfizYZMt1O1Vn/oZ1mJdoybSS40bFdv+m48EZWQIBewSxjvd8qsqlKaJBcudQsbvarZTu7t6ROx/GoBD7LpI6hjnsYyFr87J7jvM8E4BRHd+wbH08STFVR1IrDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242937; c=relaxed/simple;
	bh=8s3oHjbs5/lflkiw1KL+IULZoBmCAjbLZjGI+ii+jLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7qaZ8AzX4EkUnTFKWwl3vVIr524zMbhZYOX9LC7/HL2rw/4Ev8cIULx2VNJwXYZHU99onKO0+H/IftiLQd/b9V05chfrWHnvvUe+Hj0p/IT9RNm4+JQOlIjh634o/d+J+NjMA7T7Tf9cxfdYdYZ+QlNiu7TDasxbLlhjybJsDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rSRwJJnD; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so1993210a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726242934; x=1726847734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptB184qF7K7OOnnwilbdHhrGFXmoIc/avBzvIW/sc1c=;
        b=rSRwJJnD5xH+MnVWuPU6VNhy4SlwJXJupH0UnujW78RLsQoIVlFTMD9LWV9dgq37Wa
         sNj9/OwzlhEuOTSNzFMRyUfkmA75pVaRZuWp7GOcsEqvw2WN3jxK6T2CI2mepLez0VLh
         lRCS9/jXVoSi3MbwvPMUks/w9NYMXNeOejfPTQFZYlitKlIzLKQh4nGTVwe5g4ej2vnG
         uVH6ljZzLc4cO536C9ER2X3WIFnDoiPHFBy1nStUWJrJJUle/36Dih/VxlIpQ2WPM7G7
         Hjl28xl0psaOhojexu4PA2/Sof3EK046DTn+/150Ie++Uurkw3b2cK8kV/rD1u3PZbVQ
         VPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726242935; x=1726847735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptB184qF7K7OOnnwilbdHhrGFXmoIc/avBzvIW/sc1c=;
        b=FVSKLQjbUZnrXi3I3czGZC5dzBC6+SFFjffuiFxyaYlPIAZLNggkcet/VRoLcbgqdx
         j68l3MRIANx0TVZI7euDMKhOxB9mEMCnCrydHLw2u7Qj+3prxIpp7z8g/JLlhG8gCF3m
         hi6A9ZoBTTrptts3QlMo+1C+Nk4f4lVttH33esdhwKOyMSxVt/RKm6Jxjg6JLLAmdOyx
         CoW6wpOGCkt2Vt5Ck+aRiDmYEWV3QoNGlx+J18of5ymvFzYPSZzcWpqY1uteeiRmnepC
         CmwsT9VyigRhMcOPYsgMFfgNiffQUP4XdERl+2m1qQfTpttbju53+MwCQ8Y0pIlY4cun
         SOvw==
X-Forwarded-Encrypted: i=1; AJvYcCXHgHIpZYaeOm/ECYUzwOcu4YCOZEjBEpxz4c85UJU44cNwCOp3JnlO1gC2S9lXlXXeZRY0AI6BiAWMQ5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOwmK5cRu4qMuAcCyaaMGM34vatydL84E/MYSaxDuywKXLEDQD
	xTUvyleHjXVMS5woMveq7boTVICR5422uCtHmLpfeK/Y0O+8OI0F1OK7yNXzGPKFaucNAUKDFuX
	E4yzhdM730rLKzTllNmATm2T4Mrco3QaRYQ6/NA==
X-Google-Smtp-Source: AGHT+IF+hu2Fc0Cs60/knGO+U/HYfmACvm7ASzG5u0jrXL8s7NK4zYfl6RAPoNnbmWtsFIQiROhuPQAw4xcdu7xlmqU=
X-Received: by 2002:a17:90a:5d17:b0:2d8:83ce:d4c0 with SMTP id
 98e67ed59e1d1-2db9ffcc174mr8884327a91.13.1726242934339; Fri, 13 Sep 2024
 08:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725120315.212428-1-zhengzucheng@huawei.com>
 <3e68ccda-1606-9494-f57a-75be9668b83d@huawei.com> <cb3a3f3e-727a-4cbb-b4a8-f9469ed4f08d@redhat.com>
 <9982cb8d-9346-0640-dd9f-f68390f922e9@huawei.com>
In-Reply-To: <9982cb8d-9346-0640-dd9f-f68390f922e9@huawei.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 13 Sep 2024 17:55:23 +0200
Message-ID: <CAKfTPtCdfzZ9Wxr7+zH5WW171LJGttgzto4W2wH9mm4d0jcTLg@mail.gmail.com>
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

On Fri, 13 Sept 2024 at 06:03, zhengzucheng <zhengzucheng@huawei.com> wrote=
:
>
> In the VM overcommitment scenario, the overcommitment ratio is 1:2, 8
> CPUs are overcommitted to 2 x 8u VMs,
> and 16 vCPUs are bound to 8 cpu. However, one VM obtains only 2 CPUs
> resources, the other VM has 6 CPUs.
> The host is configured with 80 CPUs in a sched domain and other CPUs are
> in the idle state.
> The root cause is that the load of the host is unbalanced, some vCPUs
> exclusively occupy CPU resources.
> when the CPU that triggers load balance calculates imbalance value,
> env->imbalance =3D 0 is calculated because of
> local->avg_load > sds->avg_load. As a result, the load balance fails.
> The processing logic:
> https://github.com/torvalds/linux/commit/91dcf1e8068e9a8823e419a7a34ff434=
1275fb70
>
>
> It's normal from kernel load balance, but it's not reasonable from the
> perspective of VM users.
> In cgroup v1, set cpuset.sched_load_balance=3D0 to modify the schedule
> domain to fix it.
> Is there any other method to fix this problem? thanks.

I'm not sure how to understand your setup and why the load balance is
not balancing correctly 16 vCPU between the 8 CPUs.

From your test case description below,  you have 8 always running
threads in cgroup A and 8 always running threads in cgroup B and the 2
cgroups have only 8 CPUs among 80. This should not be a problem for
load balance. I tried something similar although not exactly the same
with cgroupv2 and rt-app and I don't have noticeable imbalance

Do you have more details that you can share about your system ?

Which kernel version are you using ? Which arch ?

>
> Abstracted reproduction case=EF=BC=9A
> 1.environment information=EF=BC=9A
>
> [root@localhost ~]# cat /proc/schedstat
>
> cpu0
> domain0 00000000,00000000,00010000,00000000,00000001
> domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
> domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
> cpu1
> domain0 00000000,00000000,00020000,00000000,00000002
> domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
> domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
> cpu2
> domain0 00000000,00000000,00040000,00000000,00000004
> domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
> domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
> cpu3
> domain0 00000000,00000000,00080000,00000000,00000008
> domain1 00000000,00ffffff,ffff0000,000000ff,ffffffff
> domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff

Is it correct to assume that domain0 is SMT, domain1 MC and domain2 PKG  ?
 and cpu80-83 are in the other group of PKG ? and LLC is at domain1 level ?

>
> 2.test case:
>
> vcpu.c
> #include <stdio.h>
> #include <unistd.h>
>
> int main()
> {
>          sleep(20);
>          while (1);
>          return 0;
> }
>
> gcc vcpu.c -o vcpu
> -----------------------------------------------------------------
> test.sh
>
> #!/bin/bash
>
> #vcpu1
> mkdir /sys/fs/cgroup/cpuset/vcpu_1
> echo '0-3, 80-83' > /sys/fs/cgroup/cpuset/vcpu_1/cpuset.cpus
> echo 0 > /sys/fs/cgroup/cpuset/vcpu_1/cpuset.mems
> for i in {1..8}
> do
>          ./vcpu &
>          pid=3D$!
>          sleep 1
>          echo $pid > /sys/fs/cgroup/cpuset/vcpu_1/tasks
> done
>
> #vcpu2
> mkdir /sys/fs/cgroup/cpuset/vcpu_2
> echo '0-3, 80-83' > /sys/fs/cgroup/cpuset/vcpu_2/cpuset.cpus
> echo 0 > /sys/fs/cgroup/cpuset/vcpu_2/cpuset.mems
> for i in {1..8}
> do
>          ./vcpu &
>          pid=3D$!
>          sleep 1
>          echo $pid > /sys/fs/cgroup/cpuset/vcpu_2/tasks
> done
> ------------------------------------------------------------------
> [root@localhost ~]# ./test.sh
>
> [root@localhost ~]# top -d 1 -c -p $(pgrep -d',' -f vcpu)
>
> 14591 root      20   0    2448   1012    928 R 100.0   0.0 13:10.73 ./vcp=
u
> 14582 root      20   0    2448   1012    928 R 100.0   0.0 13:12.71 ./vcp=
u
> 14606 root      20   0    2448    872    784 R 100.0   0.0 13:09.72 ./vcp=
u
> 14620 root      20   0    2448    916    832 R 100.0   0.0 13:07.72 ./vcp=
u
> 14622 root      20   0    2448    920    836 R 100.0   0.0 13:06.72 ./vcp=
u
> 14629 root      20   0    2448    920    832 R 100.0   0.0 13:05.72 ./vcp=
u
> 14643 root      20   0    2448    924    836 R  21.0   0.0 2:37.13 ./vcpu
> 14645 root      20   0    2448    868    784 R  21.0   0.0 2:36.51 ./vcpu
> 14589 root      20   0    2448    900    816 R  20.0   0.0 2:45.16 ./vcpu
> 14608 root      20   0    2448    956    872 R  20.0   0.0 2:42.24 ./vcpu
> 14632 root      20   0    2448    872    788 R  20.0   0.0 2:38.08 ./vcpu
> 14638 root      20   0    2448    924    840 R  20.0   0.0 2:37.48 ./vcpu
> 14652 root      20   0    2448    928    844 R  20.0   0.0 2:36.42 ./vcpu
> 14654 root      20   0    2448    924    840 R  20.0   0.0 2:36.14 ./vcpu
> 14663 root      20   0    2448    900    816 R  20.0   0.0 2:35.38 ./vcpu
> 14669 root      20   0    2448    868    784 R  20.0   0.0 2:35.70 ./vcpu
>

