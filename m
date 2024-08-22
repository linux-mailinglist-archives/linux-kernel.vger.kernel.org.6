Return-Path: <linux-kernel+bounces-297319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A74895B639
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26201F26C46
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50A2136354;
	Thu, 22 Aug 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYLW9onj"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC026AC1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332551; cv=none; b=YSYP1I+RQ4EekbEqKVWUIEtbM+rdQ7XdBVH1kPfpA9xBzkynbQ4dOALMLu1fLYoSMPWJXN6E7mVnyfp+0Fc7xMBO3MKzS3E0fVKOY/tM/7qT30Qa4xJXgcx7tOHbFTvsNbI6WWbH40bcIpV08hmeNw1dGsye9iucftkO/QsGzg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332551; c=relaxed/simple;
	bh=+a4vyuLhy5+MCil3cmI+hYW3KSFXfWMrNUevrGxRhUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3AVni80MqlTbpcePfPbbguntnnIB+JvfJgBwbSY0txzEloQfZ11ge42Bz1s7Q+39lZeNa75kfgX1RcoylDPMOiVjX2QnROnvjhzLlonH983x2mvI602JKa8Rufvy2kVEM+A5/ewC6jMyXtQnYW22jmLM+L0gOF00EL4LGMzvHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FYLW9onj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-429e29933aaso5582545e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724332548; x=1724937348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Idmjk6aKOsq8wCB/fJDf4A1bA+oTBg6iy4ZBWLmaOX4=;
        b=FYLW9onjyjNxtedei0gJ1eCf69rqNXgbadw9bPi+oOVzmSNsH2mrdZWi3eEaHimgYt
         EffDCX/nJxh62Okc2jDkQwApAvbMqPlJYbxqdaoYEEJKcEXx1vrmtG7XvR++2Z9PFF5n
         /xm4m+LWgK9PJrthT6XiSjw01OKrBsu0JDZL8CzfMBkv9KTVnY7eRf7kTqBtSZct+2Fq
         HbZe4rfKbKDnhsT59hLbtaXumtkrkYs0ldeZyhk2GM3Cq2CMlgOHTvs0E6rQc9ehBwji
         vOiyvyZJD9+Y5VYnWMz3Lr+3Htbe8hWegbTBPs2H0tK6n+6kb78EghgTbb8V/sW8Gi/4
         rTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724332548; x=1724937348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Idmjk6aKOsq8wCB/fJDf4A1bA+oTBg6iy4ZBWLmaOX4=;
        b=DrnyDRNwzPn2PtZaYMBNBHZ2kQRoa7k5Mb+WIpy+OP8q9SJFy1/wmqQbXqMdzGA+EE
         HrTG0tAU4lDlHNQrfXybBnrhGpzZkmC4q5Wu5rHHsN2NCaSm9w0BNpO2hKn0n/Cb8auI
         2//hprgEPGGgBKuAo/WuvyPxsDig4ExVwya1dedd7hczrULcQAWLu1hji+sccdQw7zB4
         rc6jJKsFuyV6dKWwLUlk64Ay7jnFzfOMTegIrRGEWs+fWAGpNaDX+UdXgonED7iKzeF4
         tQnU0Uyp37c1HMfEe210FVCjJ6aFMESlIPFlgLUhGGGU0FJkTithu3hs+oj4Rh7mkOhF
         K96Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrillR7nc/9VCxodFl4vUzf3DcWlRtTJ9/5e7qvIEbunIuY1XUTfkIf5X/YLLLyCp3nUAfe66UWqrADtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV043IZ0zFO/M6qtESJIP+ZYXcez5OLbgX14kDRZsSfVknvMJq
	wL49Qio+mZCteBth7ZZsQ5cZ+0ey4HPEWKHl9FxtnL6gDTc74icAZpfcPRtEoVocstKynbYKhg2
	tmnl1gKQrU5lKUACfXbwsCTGnLuh6dw8zlXb/
X-Google-Smtp-Source: AGHT+IFzMpNXWmIw2/Y+hlKnTQ3trxxxkty6msKxvHAsncca2ufdbEaAx5xBHKVf2wi2LRPyAM02ljSR+f/e4H388fo=
X-Received: by 2002:a05:600c:1f82:b0:426:6000:565a with SMTP id
 5b1f17b1804b1-42ac55da23dmr12344035e9.16.1724332548019; Thu, 22 Aug 2024
 06:15:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813222548.049744955@infradead.org> <CAJWu+oqUSOUrro-Rk-Bg7P6PyCWGKRZVT5i4Bi36XpRRFumL5w@mail.gmail.com>
 <CAJWu+opjcGs8vs9=NcgSU_nuWZE+z73rMaOO7s7OX_=AHvSOiQ@mail.gmail.com>
In-Reply-To: <CAJWu+opjcGs8vs9=NcgSU_nuWZE+z73rMaOO7s7OX_=AHvSOiQ@mail.gmail.com>
From: Joel Fernandes <joelaf@google.com>
Date: Thu, 22 Aug 2024 09:15:36 -0400
Message-ID: <CAJWu+opPO18zgQZPDqPkALXqU4Tn=ohPPDM=jmdpL=z1J=PJhA@mail.gmail.com>
Subject: Re: [PATCH 0/9] sched: Prepare for sched_ext
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, tj@kernel.org, void@manifault.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, 
	"Joel Fernandes (Google)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 8:58=E2=80=AFAM Joel Fernandes <joelaf@google.com> =
wrote:
>
> On Wed, Aug 21, 2024 at 5:41=E2=80=AFPM Joel Fernandes <joelaf@google.com=
> wrote:
> >
> > On Tue, Aug 13, 2024 at 6:50=E2=80=AFPM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > Hi,
> > >
> > > These patches apply on top of the EEVDF series (queue/sched/core), wh=
ich
> > > re-arranges the fair pick_task() functions to make them state invaria=
nt such
> > > that they can easily be restarted upon picking (and dequeueing) a del=
ayed task.
> > >
> > > This same is required to push (the final) put_prev_task() beyond pick=
_task(),
> > > like we do for sched_core already.
> > >
> > > This in turn is done to prepare for sched_ext, which wants a final ca=
llback to
> > > be in possesion of the next task, such that it can tell if the contex=
t switch
> > > will leave the sched_class.
> > >
> > > As such, this all re-arranges the current order of:
> > >
> > >   put_prev_task(rq, prev);
> > >   next =3D pick_next_task(rq); /* implies set_next_task(.first=3Dtrue=
); */
> > >
> > > to sometihng like:
> > >
> > >   next =3D pick_task(rq)
> > >   if (next !=3D prev) {
> > >     put_prev_task(rq, prev, next);
> > >     set_next_task(rq, next, true);
> > >   }
> > >
> > > The patches do a fair bit of cleaning up. Notably a bunch of sched_co=
re stuff
> > > -- Joel, could you please test this stuff, because the self-tests we =
have are
> > > hardly adequate.
> > >
> > > The EEVDF stuff was supposed to be merged already, but since Valentin=
 seems to
> > > be doing a read-through, I figured I'd give him a little extra time. =
A complete
> > > set can be found at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sche=
d/prep
> > >
> >
> > So I booted queue.git sched/core branch on a newish Chromebook (after
> > applying 700 patches for making it boot and spending 2 days on it
> > since we boot old kernels -- I wasn't joking when I said I would carve
> > some time up for you this week :P).
> >
> > With sched/core , it boots fine with core scheduling disabled, but
> > when core scheduling is enabled I am getting hard hangs and
> > occasionally get to the login screen if I'm lucky. So there's
> > definitely something wonky in sched/core branch and core sched.
> > I could not get a trace or logs yet, since once it hangs I have to
> > hard power off.
> >
> > I could bissect it tomorrow though since it looks like a manageable
> > set of patches on 6.11-rc1.  Or did you already figure out the issue?
> >
> > I am based on:
> > commit aef6987d89544d63a47753cf3741cabff0b5574c
> > Author: Peter Zijlstra <peterz@infradead.org>
> > Date:   Thu Jun 20 13:16:49 2024 +0200
> >
> >     sched/eevdf: Propagate min_slice up the cgroup hierarchy
>
> One of these 29 in sched/core broke core-scheduling, causes hangs.
> Haven't narrowed it down to which. Not much time today. Will probably
> try to collect some logs.
> https://hastebin.com/share/uqubojiqiy.yaml
>
> Also I realized I should apply the 9 in this set too. But very least
> it appears the above 29 broke core-sched vs bissection, probably the
> delayed-dequeue or task-pick rework?
>
> I will try the sched/prep branch now, which has the 9 in this set too..

Same issue with sched/prep which has these 9. Looks like it hung on rq
lock Picked up a dmesg this time:

[   13.856485] Hardware name: Google XXXXXX
[   13.856487] RIP: 0010:queued_spin_lock_slowpath+0x140/0x260

[   13.856496] RSP: 0018:ffff91d90253b9b8 EFLAGS: 00000046
[   13.856498] RAX: 0000000000000000 RBX: ffff8b4f3792e880 RCX:
ffff8b4f37b2f6c0
[   13.856499] RDX: ffff8b4f37b80000 RSI: fffffffffffffff8 RDI:
ffff8b4f3792e880
[   13.856500] RBP: ffff91d90253b9d8 R08: 0000000000000002 R09:
ffff8b4dc2bbc3c0
[   13.856501] R10: 0000000000000005 R11: 0000000000000005 R12:
ffff8b4f37b00000
[   13.856502] R13: 0000000000000000 R14: 0000000000340000 R15:
0000000000340000
[   13.856504] FS:  0000788e7f133c40(0000) GS:ffff8b4f37b00000(0000)
knlGS:0000000000000000
[   13.856505] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.856507] CR2: 00005a4901a073f8 CR3: 00000001131b2000 CR4:
0000000000750ef0
[   13.856508] PKRU: 55555554
[   13.856508] Call Trace:
[   13.856512]  <NMI>
[   13.856516]  ? nmi_cpu_backtrace+0x101/0x130
[   13.856521]  ? nmi_cpu_backtrace_handler+0x11/0x20
[   13.856524]  ? nmi_handle+0x59/0x160
[   13.856526]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.856528]  ? default_do_nmi+0x46/0x110
[   13.856530]  ? exc_nmi+0xb1/0x110
[   13.856532]  ? end_repeat_nmi+0xf/0x53
[   13.856534]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.856535]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.856537]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.856538]  </NMI>
[   13.856539]  <TASK>
[   13.856540]  raw_spin_rq_lock_nested+0x4c/0x80
[   13.856543]  sched_balance_rq+0x15ff/0x1860
[   13.856548]  sched_balance_newidle+0x193/0x390
[   13.856550]  balance_fair+0x25/0x40
[   13.856553]  __schedule+0x899/0x1110
[   13.856555]  ? timerqueue_add+0x86/0xa0
[   13.856558]  ? hrtimer_start_range_ns+0x225/0x2f0
[   13.856560]  schedule+0x5e/0x90
[   13.856562]  schedule_hrtimeout_range_clock+0xc2/0x130
[   13.856564]  ? __pfx_hrtimer_wakeup+0x10/0x10
[   13.856566]  do_epoll_wait+0x627/0x6b0
[   13.856571]  ? __pfx_ep_autoremove_wake_function+0x10/0x10
[   13.856574]  __x64_sys_epoll_wait+0x50/0x80
[   13.856577]  do_syscall_64+0x6a/0xe0
[   13.856580]  ? clear_bhb_loop+0x45/0xa0

Let me know if you have cluses on which but I will dig further and see
which patch(es) cause it, thanks,

 - Joel

