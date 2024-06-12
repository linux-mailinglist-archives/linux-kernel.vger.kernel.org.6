Return-Path: <linux-kernel+bounces-210928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF46A904A88
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BAA41F25B99
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494D62C69B;
	Wed, 12 Jun 2024 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F/T7R24+"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E69BF4FA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 05:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718168505; cv=none; b=QTrVGJvOturk7okiMP4DxfgB7JxKzak714lWUnqH7LWfWZGioIImafNo99NZdyGX6altrEFig5Gy49Ti11UfFXLTvuCWUDCytBjt/m2dAb6aL7mjP7ofwWKtsy7ekmUlPb+95ZT9fPJg4+NnwOC4wW8o6fXbi93on63e4Flr/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718168505; c=relaxed/simple;
	bh=+FPO0pOUHca0YkNQOpF9tmWvBXnMagAcn71iVDG+Doo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZ2uHP9Zez2KYxkFu/FE2cQBiflYJPdywYDZtG0wSDXcpJQq9MTGPb+6frjvQQKrMR3WvkOpzuenz+Bjsgz+wTBcG2vlETLjDGdYonjh6Jvq9Q0G2FrKndh+FmF8tSksgRmZ9elUlOG/gdZ827rkLx35QcnaHLAhKnLB+NzH3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F/T7R24+; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dfaff6bf125so4891235276.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 22:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718168502; x=1718773302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxWIpqVuiSpUi+w7zOEokbBeKNv8goSyLfXEzEpVegA=;
        b=F/T7R24+CEGSDEtfDTqEqyMzVPL/i/yUiF5Z0vCTWFaafDhVG3y5z5pgtD2/0YAVaD
         bClU4N2gOFxE7faXqkpAg0OSxb/GOORbUmlFkJz4EVqkQh2Go2a4AQMC2fPs+dnEwLFH
         uQDPb0T7ft4AEKOIeRTLQFIidLRZLF6kyhvTeDu+t9luvwAxu/XCUAXh+30/4aS8Fcvd
         U4xwLerYoT7P14Tfxs06gZTSPrSSFDkzhBjq+9ofdWlOt3XiyT537HJAAQeezgPTNalv
         i6Liz8qb53jsiWq9ScRJYAykn2fQfaRVtU5vaPuHLmmvOTzEljJevPfNO7zE6SK9jZ82
         U9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718168502; x=1718773302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxWIpqVuiSpUi+w7zOEokbBeKNv8goSyLfXEzEpVegA=;
        b=IaswhtBcjteiXrl6Bm6w/HXcCqZGOUIPAnd9MolPqa1mQbbY4Wx/v01J/gBptErdZM
         056eExcquzWoaygiH827MNAGqlEVoSLxF/JbuWLmKCCMembxn+Iq69QEZ7dlTVQAVuVi
         3AGclFht+Tw4cNqbLB3cNWdHYgkFKp52oC57+acGt3t5Xu8vWfIfgx4XDBiMNdW+Yt64
         z7s2C66R++L5tpNsphB+Uw9/XClltps1wRu1hJ80OwC+2TGqeTcd8bTrKgBipPHGQp5X
         WSjqCIFrE2AwQ/Pzhzx9iVu0dQOxzLxn3WiJ/n9D9uU4k4vaGTXzh4YggYnPE4qN9O0D
         xvPQ==
X-Forwarded-Encrypted: i=1; AJvYcCURh0EOMiitV3uORpPltYnNZ5LNjVXJbkHt6lXuqMRIN4gWTYOhgQOvmub2kfK8Q5r5KAcReyT/SzbIy1GQfwNK10zuYRUVktqcRF+O
X-Gm-Message-State: AOJu0YwpDgRt8rYvlNMeoPfBvPIy8RJvJyxkxbjeDe4JUqCkk66e4Swb
	iQc07dg75lxE+2fhogNI+xr9HYheHmEXU2hLX2+x3La1XwGoIRqHyd3vK3gTqfkKh4ywdSFvjuz
	4KTFFqYCNN4QXWghxlf0nklM/Lzdyo2m03aGzlDdQovlPfG3boznTCnrn9plT8v/zkXVbyjvUo5
	hQV1O4fkQeuaU5WGBVWuMGX2NIFiWuJPh3DoF5T7vM4Q==
X-Google-Smtp-Source: AGHT+IEGT1ppFwble93yNyGFU3HfypCIF0j2RjdVYDRmiDNX921lOKQDwbNO1DL6O5v1S+6ccec+5Tlob2xzQ/tdtT0=
X-Received: by 2002:a25:8583:0:b0:df7:978a:73de with SMTP id
 3f1490d57ef6-dfe66461d07mr699038276.19.1718168501928; Tue, 11 Jun 2024
 22:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
In-Reply-To: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 11 Jun 2024 22:01:29 -0700
Message-ID: <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com>
Subject: Re: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ccpol: medium

On Tue, Jun 4, 2024 at 12:16=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> Hi kernel people,
> I have a problem that I have been trying to debug for a few days, but
> I got lost in the depths of the scheduler code; I'm stuck and I need
> your help.
> We have several servers which show a constant memory.pressure value of
> 30 to 100 (or more), even when the server is idle. I tracked this down
> to psi_group_cpu.tasks[NR_MEMSTALL]=3D=3D1 even though no such process
> exists, but I can't figure out why the kernel thinks there is still
> one task stuck in memstall. I tried to track down all the code paths
> that lead to psi_group_change(), but found nothing conclusive, and
> failed to reproduce it on a test machine with kernel patches injecting
> delays (trying to cause data race bugs that may have caused this
> problem).
>
> This happened on servers that were very busy and indeed were in
> memstall often due to going over memory.high frequently. We have one
> "main" cgroup with memory.high configured, and all the workload
> processes live in sub-cgroups, of which we always have a few thousand.
> When memory.events gets triggered, our process manager stops a bunch
> of idle processes to free up memory, which then deletes the sub-cgroup
> they belong to. In other words: sub-cgroups get created and deleted
> very often, and they get deleted when there is indeed memory stall
> happening. My theory was that there could be a data race bug that
> forgets to decrement tasks[NR_MEMSTALL], maybe when a stalled child
> cgroup gets deleted.

Hi Max,
I'm not an expert in the scheduler (I maintain mostly PSI triggers),
so my feedback might be utterly wrong.
I looked a bit into the relevant code and I think if your theory was
correct and psi_task_change() was called while task's cgroup is
destroyed then task_psi_group() would have returned an invalid pointer
and we would crash once that value is dereferenced.
Instead I think what might be happening is that the task is terminated
while it's in memstall. do_exit() calls do_task_dead() at the very
end, which sets current->__state to TASK_DEAD and calls the last
__schedule() for this task. __schedule() will call deactivate_task(rq,
prev, DEQUEUE_SLEEP) which will set prev->on_rq =3D NULL and call
dequeue_task(..., DEQUEUE_SLEEP) leading to psi_dequeue(..., true).
Note that because of that last parameter of psi_dequeue() is "true",
psi_task_change() will not be called at this time. Later on
__schedule() calls psi_sched_switch(). That leads to psi_task_switch()
but note that the last parameter will be "true" because prev->on_rq =3D=3D
NULL. So we end up calling psi_task_switch(, true). Now, note this
line: https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L95=
5.
It will clear TSK_MEMSTALL_RUNNING but not TSK_MEMSTALL. So, if the
task was in TSK_MEMSTALL state then that state won't be cleared, which
might be the problem you are facing.
I think you can check if this theory pans out by adding a WARN_ON() ar
the end of psi_task_switch():

void psi_task_switch(struct task_struct *prev, struct task_struct
*next, bool sleep)
{
...
        if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
                clear &=3D ~TSK_ONCPU;
                for (; group; group =3D group->parent)
                        psi_group_change(group, cpu, clear, set, now,
wake_clock);
        }
+        WARN_ON(prev->__state & TASK_DEAD && prev->psi_flags & TSK_MEMSTAL=
L);
}

Again, I am by no means an expert in this area. Johannes or Peter
would be much better people to consult with.
Thanks,
Suren.

> On our Grafana, I can easily track the beginning of this bug to a
> point two weeks ago; in the system log, I can see that hundreds of
> processes needed to be terminated due to memory pressure at that time.
>
> The affected servers run kernel 6.8.7 with a few custom patches, but
> none of these patches affect the scheduler or cgroups; they're about
> unrelated things like denying access to Ceph snapshots and adjusting
> debugfs permissions. (I submitted most of those patches to LKML long
> ago but nobody cared.)
> Newer kernels don't seem to have fixes for my problem; the relevant
> parts of the code are unchanged.
>
> One of the servers is still running with this problem, and I can
> access it with gdb on /proc/kcore. I'll keep it that way for some more
> time, so if you have any idea what to look for, let me know.
>
> This is the psi_group of the "main" cgroup:
>
>  $1 =3D {parent =3D 0xffff9de707287800, enabled =3D true, avgs_lock =3D {=
owner
> =3D {counter =3D 0}, wait_lock =3D {raw_lock =3D {{val =3D {counter =3D 0=
},
> {locked =3D 0 '\000', pending =3D 0 '\000'}, {locked_pending =3D 0, tail =
=3D
> 0}}}}, osq =3D {tail =3D {
>         counter =3D 0}}, wait_list =3D {next =3D 0xffff9de70f772820, prev=
 =3D
> 0xffff9de70f772820}}, pcpu =3D 0x3fb640033900, avg_total =3D
> {6133960836647, 5923217690044, 615319825665255, 595479374843164,
> 19259777147170, 12847590051880},
>   avg_last_update =3D 1606208471280060, avg_next_update =3D
> 1606210394507082, avgs_work =3D {work =3D {data =3D {counter =3D 321}, en=
try =3D
> {next =3D 0xffff9de70f772880, prev =3D 0xffff9de70f772880}, func =3D
> 0xffffffff880dcc00}, timer =3D {entry =3D {
>         next =3D 0x0 <fixed_percpu_data>, pprev =3D 0xffff9e05bef5bc48},
> expires =3D 4455558105, function =3D 0xffffffff880a1ca0, flags =3D
> 522190853}, wq =3D 0xffff9de700051400, cpu =3D 64}, avg_triggers =3D {nex=
t =3D
> 0xffff9de70f7728d0,
>     prev =3D 0xffff9de70f7728d0}, avg_nr_triggers =3D {0, 0, 0, 0, 0, 0},
> total =3D {{6133960836647, 5923217690044, 615328415599847,
> 595487964777756, 19281251983650, 12869064888360}, {6092994926,
> 5559819737, 105947464151, 100672353730,
>       8196529519, 7678536634}}, avg =3D {{0, 0, 0}, {0, 0, 0}, {203596,
> 203716, 198499}, {203596, 203716, 198288}, {0, 0, 60}, {0, 0, 0}},
> rtpoll_task =3D 0x0 <fixed_percpu_data>, rtpoll_timer =3D {entry =3D {nex=
t =3D
> 0xdead000000000122,
>       pprev =3D 0x0 <fixed_percpu_data>}, expires =3D 4405010639, functio=
n
> =3D 0xffffffff880dac50, flags =3D 67108868}, rtpoll_wait =3D {lock =3D {{=
rlock
> =3D {raw_lock =3D {{val =3D {counter =3D 0}, {locked =3D 0 '\000', pendin=
g =3D 0
> '\000'}, {
>                 locked_pending =3D 0, tail =3D 0}}}}}}, head =3D {next =
=3D
> 0xffff9de70f772a20, prev =3D 0xffff9de70f772a20}}, rtpoll_wakeup =3D
> {counter =3D 0}, rtpoll_scheduled =3D {counter =3D 0}, rtpoll_trigger_loc=
k =3D
> {owner =3D {counter =3D 0},
>     wait_lock =3D {raw_lock =3D {{val =3D {counter =3D 0}, {locked =3D 0 =
'\000',
> pending =3D 0 '\000'}, {locked_pending =3D 0, tail =3D 0}}}}, osq =3D {ta=
il =3D
> {counter =3D 0}}, wait_list =3D {next =3D 0xffff9de70f772a48, prev =3D
> 0xffff9de70f772a48}},
>   rtpoll_triggers =3D {next =3D 0xffff9de70f772a58, prev =3D
> 0xffff9de70f772a58}, rtpoll_nr_triggers =3D {0, 0, 0, 0, 0, 0},
> rtpoll_states =3D 0, rtpoll_min_period =3D 18446744073709551615,
> rtpoll_total =3D {6092994926, 5559819737, 105947464151,
>     100672353730, 8196529519, 7678536634}, rtpoll_next_update =3D
> 1100738436720135, rtpoll_until =3D 0}
>
> This is a summary of all psi_group_pcpu for the 32 CPU cores (on the
> way, I wrote a small gdb script to dump interesting details like these
> but that went nowhere):
>
>   state_mask 0 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 1 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 2 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 3 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 4 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 5 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 6 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 7 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 8 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 9 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 10 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 11 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 12 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 13 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 14 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 15 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 16 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 17 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 18 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 19 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 20 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 21 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 22 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 23 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 24 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 25 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 26 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 27 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 28 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 29 =3D 0x0 tasks {0, 0, 0, 0}
>   state_mask 30 =3D 0x4c tasks {0, 1, 0, 0}
>   state_mask 31 =3D 0x0 tasks {0, 0, 0, 0}
>
> CPU core 30 is stuck with this bogus value. state_mask 0x4c =3D
> PSI_MEM_SOME|PSI_MEM_FULL|PSI_NONIDLE.
>
> The memory pressure at the time of this writing:
>
>  # cat /sys/fs/cgroup/system.slice/system-cm4all.slice/bp-spawn.scope/mem=
ory.pressure
>  some avg10=3D99.22 avg60=3D99.39 avg300=3D97.62 total=3D615423620626
>  full avg10=3D99.22 avg60=3D99.39 avg300=3D97.54 total=3D595583169804
>  # cat /sys/fs/cgroup/system.slice/system-cm4all.slice/bp-spawn.scope/_/m=
emory.pressure
>  some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D0
>  full avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D0
>  # cat /sys/fs/cgroup/system.slice/system-cm4all.slice/bp-spawn.scope/cgr=
oup.stat
>  nr_descendants 1
>  nr_dying_descendants 2224
>
> There is currently no worker process; there is only one idle dummy
> process in a single sub-cgroup called "_", only there to keep the
> systemd scope populated. It should therefore be impossible to have
> memory.pressure when the only leaf cgroup has pressure=3D0.
>
> (nr_dying_descendants is decremented extremely slowly; I deactivated
> the server shortly before collecting these numbers, to make sure it's
> really idle and there are really no processes left to cause this
> pressure. I don't think nr_dying_descendants is relevant for this
> problem; even after two days of full idle, the counter and the
> pressure didn't go back to zero.)
>
> Please help :-)
>
> Max

