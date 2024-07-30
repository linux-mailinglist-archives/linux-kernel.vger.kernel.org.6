Return-Path: <linux-kernel+bounces-267883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19936941900
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FD8285B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969A31A618E;
	Tue, 30 Jul 2024 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVlz7RrK"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A21A6160
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356864; cv=none; b=dqtZntYiKUTI69OaVmz79RJTuIxU0pcOcA0oERHfeeZ1IgEMBV7s0j+H+n0WVnXV8MjJcrr68NDtIedNGazQuclrhptC3cdGNjcIkFj5u53lVJYzrOMvwGDtwlu8vN20yl4m0iTvmyHBrj7JT1A4KAI4tQcPbf/PyVEi8qlkJc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356864; c=relaxed/simple;
	bh=rAH6AMsvIiLGMl4BOA32ybHtRVjZL+YRo4kv3IueAVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JejOrUs9G05fxAsrqOetz/qcSv08dXN0ac8sLTl58lcjqYyR/kozwrl1ctmSuSDmDHvM9HqUyXNrwgo2PLU9z0xELz+/hegLAGr6vb38Kij0YHl4p4Hg1lDT6tggK1nsJ7PwLaDLtEQeY5pOu/diu26BUPR2kX/s8oxApy9f5PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVlz7RrK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so7195610a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722356859; x=1722961659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQMm3j/WDX5wm2f/0bMEKkx0ZnqFo9kz+zHN+GCN6hs=;
        b=IVlz7RrK4px1cRuX3XoW3CDlalSQDgq7rtn+KJFx1jMn97KlQR1DLX1uKUcDdhyWi0
         9iNY75/XwoBv7gsXWDeTR3/YOUWL3d74lsxds7TvMkZkpdLoPrO1jETC9JWjDopenOD4
         zcLUG5Lwf5l5MXDHnLBwrOScnW7zYSPr8IkLxMorF/qYavvK+vRWSo80QLAU3aif7q1N
         mM3k5RyydVT9bmWN02lMqwFZbwda6syeqzWIZ6W6PqbKVoIDqaKz/8DmkkvknLRJD6Yn
         8uNLVT+HVdtz1oSiYF2Ch02pzoJwKuwjaE1Y3IC1VorJez0V5FihAOHNG5UKWmW6yojo
         3uoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722356859; x=1722961659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQMm3j/WDX5wm2f/0bMEKkx0ZnqFo9kz+zHN+GCN6hs=;
        b=n7yu8b5Hyo2dqGUvBmb+dvNlB5axLVtGc3w0R2EzMmRazR+khJVrDBilpDrFfwjS5i
         YENckJ+5sRrQv6+BJOqB0UsoCGqM7kuYWzebkZ+mXPfBIBJEpof7dcg5c5S1GGwhRsfK
         Z+WiVTPm3FQOKBxOyrLViOLOzU1LxO32LOO23sB4hcKjSAqW66pgZf8qRJn9eSwQlJut
         qqlgTys+WSpmu1w9TiYI9yNO5ylsQMjQuESLuvgh/WB8f5+wVYBl8Ka0b6jK24CiJ5Oi
         4R+7dXq6cJE3UaDQoNiES4qWxP6a6dTwKfClBhrvdTo1yao/au5SdG1J81bkCJLRvodH
         kE8w==
X-Forwarded-Encrypted: i=1; AJvYcCX5JupKHpz+AKOP0DHJuIPfXBoGTiZjOpHVmwqmyTGeBtNHF2NVp/yTNvkkpCdU9DjOBZvBtlHtdeTf0injWtHBZTHVGpEzQqa4toVz
X-Gm-Message-State: AOJu0YzbaQaxBACOqpwnu3dMFdhtLGCr+Zi91/56nt2EM0pIA7nS3r9T
	Ivxh1bWeHdT29KFQfqJ3IrXv3+FL1zT0cw3RQwus0JcATV12tz95b6Kbz0k9PoXNmyGH/FYv886
	P52Q2yfOAqTQTdLtzeULyhwEPamA=
X-Google-Smtp-Source: AGHT+IEawiuRpfNoqf12SzW44BnpY3hQf+/7DfHQBAHQN8MUUs+CehBB8Rl4GCcTifyw+pnQ2rwaBYTO97pGym0rkKg=
X-Received: by 2002:a50:c30b:0:b0:58b:73f4:2ed with SMTP id
 4fb4d7f45d1cf-5b0224cf4d6mr6499683a12.35.1722356858839; Tue, 30 Jul 2024
 09:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zqd9AsI5tWH7AukU@pc636> <20240730093630.5603-1-ahuang12@lenovo.com>
 <ZqjQp8NrTYM_ORN1@pc636>
In-Reply-To: <ZqjQp8NrTYM_ORN1@pc636>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Wed, 31 Jul 2024 00:27:27 +0800
Message-ID: <CAHKZfL3c2Y91yP6X5+GUDCsN6QAa9L46czzJh+iQ6LhGJcAeqw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/vmalloc: Combine all TLB flush operations of KASAN
 shadow virtual address into one operation
To: Uladzislau Rezki <urezki@gmail.com>
Cc: ahuang12@lenovo.com, akpm@linux-foundation.org, andreyknvl@gmail.com, 
	bhe@redhat.com, dvyukov@google.com, glider@google.com, hch@infradead.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	ryabinin.a.a@gmail.com, sunjw10@lenovo.com, vincenzo.frascino@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 7:38=E2=80=AFPM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> > On Mon, Jul 29, 2024 at 7:29 PM Uladzislau Rezki <urezki@gmail.com> wro=
te:
> > > It would be really good if Adrian could run the "compiling workload" =
on
> > > his big system and post the statistics here.
> > >
> > > For example:
> > >   a) v6.11-rc1 + KASAN.
> > >   b) v6.11-rc1 + KASAN + patch.
> >
> > Sure, please see the statistics below.
> >
> > Test Result (based on 6.11-rc1)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > 1. Profile purge_vmap_node()
> >
> >    A. Command: trace-cmd record -p function_graph -l purge_vmap_node ma=
ke -j $(nproc)
> >
> >    B. Average execution time of purge_vmap_node():
> >
> >       no patch (us)           patched (us)    saved
> >       -------------           ------------    -----
> >                147885.02                3692.51        97%
> >
> >    C. Total execution time of purge_vmap_node():
> >
> >       no patch (us)           patched (us)    saved
> >       -------------           ------------    -----
> >         194173036               5114138        97%
> >
> >    [ftrace log] Without patch: https://gist.github.com/AdrianHuang/a5be=
c861f67434e1024bbf43cea85959
> >    [ftrace log] With patch: https://gist.github.com/AdrianHuang/a200215=
955ee377288377425dbaa04e3
> >
> > 2. Use `time` utility to measure execution time
> >
> >    A. Command: make clean && time make -j $(nproc)
> >
> >    B. The following result is the average kernel execution time of five=
-time
> >       measurements. ('sys' field of `time` output):
> >
> >       no patch (seconds)      patched (seconds)       saved
> >       ------------------      ----------------        -----
> >           36932.904              31403.478             15%
> >
> >    [`time` log] Without patch: https://gist.github.com/AdrianHuang/987b=
20fd0bd2bb616b3524aa6ee43112
> >    [`time` log] With patch: https://gist.github.com/AdrianHuang/da2ea4e=
6aa0b4dcc207b4e40b202f694
> >
> I meant another statistics. As noted here https://lore.kernel.org/linux-m=
m/ZogS_04dP5LlRlXN@pc636/T/#m5d57f11d9f69aef5313f4efbe25415b3bae4c818
> i came to conclusion that below place and lock:
>
> <snip>
> static void exit_notify(struct task_struct *tsk, int group_dead)
> {
>         bool autoreap;
>         struct task_struct *p, *n;
>         LIST_HEAD(dead);
>
>         write_lock_irq(&tasklist_lock);
> ...
> <snip>
>
> keeps IRQs disabled, so it means that the purge_vmap_node() does the prog=
ress
> but it can be slow.
>
> CPU_1:
> disables IRQs
> trying to grab the tasklist_lock
>
> CPU_2:
> Sends an IPI to CPU_1
> waits until the specified callback is executed on CPU_1
>
> Since CPU_1 has disabled IRQs, serving an IPI and completion of callback
> takes time until CPU_1 enables IRQs back.
>
> Could you please post lock statistics for kernel compiling use case?
> KASAN + patch is enough, IMO. This just to double check whether a
> tasklist_lock is a problem or not.

Sorry for the misunderstanding.

Two experiments are shown as follows. I saw you think KASAN + patch is
enough. But, in case you need another one. ;-)

a) v6.11-rc1 + KASAN

The result is different from yours, so I ran two tests (make sure the
soft lockup warning was triggered).

Test #1: waittime-max =3D 5.4ms
<snip>
...
class name    con-bounces    contentions   waittime-min   waittime-max
waittime-total   waittime-avg    acq-bounces   acquisitions
holdtime-min   holdtime-max holdtime-total   holdtime-avg
...
tasklist_lock-W:        118762         120090           0.44
5443.22    24807413.37         206.57         429757         569051
       2.27        3222.00    69914505.87         122.86
tasklist_lock-R:        108262         108300           0.41
5381.34    23613372.10         218.04         489132         541541
       0.20        5543.40    10095470.68          18.64
    ---------------
    tasklist_lock          44594          [<0000000099d3ea35>]
exit_notify+0x82/0x900
    tasklist_lock          32041          [<0000000058f753d8>]
release_task+0x104/0x3f0
    tasklist_lock          99240          [<000000008524ff80>]
__do_wait+0xd8/0x710
    tasklist_lock          43435          [<00000000f6e82dcf>]
copy_process+0x2a46/0x50f0
    ---------------
    tasklist_lock          98334          [<0000000099d3ea35>]
exit_notify+0x82/0x900
    tasklist_lock          82649          [<0000000058f753d8>]
release_task+0x104/0x3f0
    tasklist_lock              2          [<00000000da5a7972>]
mm_update_next_owner+0xc0/0x430
    tasklist_lock          26708          [<00000000f6e82dcf>]
copy_process+0x2a46/0x50f0
...
<snip>

Test #2:waittime-max =3D 5.7ms
<snip>
...
class name    con-bounces    contentions   waittime-min   waittime-max
waittime-total   waittime-avg    acq-bounces   acquisitions
holdtime-min   holdtime-max holdtime-total   holdtime-avg
...
tasklist_lock-W:        121742         123167           0.43
5713.02    25252257.61         205.02         432111         569762
       2.25        3083.08    70711022.74         124.11
tasklist_lock-R:        111479         111523           0.39
5050.50    24557264.88         220.20         491404         542221
       0.20        5611.81    10007782.09          18.46
    ---------------
    tasklist_lock         102317          [<000000008524ff80>]
__do_wait+0xd8/0x710
    tasklist_lock          44606          [<00000000f6e82dcf>]
copy_process+0x2a46/0x50f0
    tasklist_lock          45584          [<0000000099d3ea35>]
exit_notify+0x82/0x900
    tasklist_lock          32969          [<0000000058f753d8>]
release_task+0x104/0x3f0
    ---------------
    tasklist_lock         100498          [<0000000099d3ea35>]
exit_notify+0x82/0x900
    tasklist_lock          27401          [<00000000f6e82dcf>]
copy_process+0x2a46/0x50f0
    tasklist_lock          85473          [<0000000058f753d8>]
release_task+0x104/0x3f0
    tasklist_lock            650          [<000000004d0b9f6b>]
tty_open_proc_set_tty+0x23/0x210
...
<snip>


b) v6.11-rc1 + KASAN + patch: waittime-max =3D 5.7ms
<snip>
...
class name    con-bounces    contentions   waittime-min   waittime-max
waittime-total   waittime-avg    acq-bounces   acquisitions
holdtime-min   holdtime-max holdtime-total   holdtime-avg
...
tasklist_lock-W:        108876         110087           0.33
5688.64    18622460.43         169.16         426740         568715
       1.94        2930.76    62560515.48         110.00
tasklist_lock-R:         99864          99909           0.43
5868.69    17849478.20         178.66         487654         541328
       0.20        5709.98     9207504.90          17.01
    ---------------
    tasklist_lock          91655          [<00000000a622e532>]
__do_wait+0xd8/0x710
    tasklist_lock          41100          [<00000000ccf53925>]
exit_notify+0x82/0x900
    tasklist_lock           8254          [<00000000093ccded>]
tty_open_proc_set_tty+0x23/0x210
    tasklist_lock          39542          [<00000000a0e6bf4d>]
copy_process+0x2a46/0x50f0
    ---------------
    tasklist_lock          90525          [<00000000ccf53925>]
exit_notify+0x82/0x900
    tasklist_lock          76934          [<00000000cb7ca00c>]
release_task+0x104/0x3f0
    tasklist_lock          23723          [<00000000a0e6bf4d>]
copy_process+0x2a46/0x50f0
    tasklist_lock          18223          [<00000000a622e532>]
__do_wait+0xd8/0x710
...
<snip>

