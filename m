Return-Path: <linux-kernel+bounces-281254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C32694D4D9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AE41C20CC5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E221A1CD37;
	Fri,  9 Aug 2024 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4NqL8oo"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573AA1CA8D
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723221591; cv=none; b=KWfbJ9aCz6RWOeFsXGsG1pVshzxH8yh/hi5OMTFixiB8dsPWyz93SXF1hysEyfJRLgJC1DAvFJ014oP9C68pAGvhHbTajCbI/+nk3+xvk/lfYjKEkyVnPsVdusOEQ3dqa5JXJCzJb+rc5CgMw0tQPEn8Uug+rF+RM6nAymxUXSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723221591; c=relaxed/simple;
	bh=K8h94mQb5lQjqtK7zDJ1PwY5ziFswJopQOJnwekObas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPXZcbvwieOcJxtFE5hpCsVmPz22op58pP3q+qXLkFDMrV8dCzENih8FN65e4uNXiFf8A9a48tsiOCpq4kejMqzfGMBxOycBaN6p2QM8au8HsByS+yyHDfxPF5tlGr1H5gtocw7FhRJg0Qp5Gkw4LpX92FzkhL9ECJt073UQ7NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4NqL8oo; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7c3d9a5e050so154929a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723221588; x=1723826388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8h94mQb5lQjqtK7zDJ1PwY5ziFswJopQOJnwekObas=;
        b=G4NqL8ooJG/Af5qyq44uLTMmfYkDRtX/A5zNyGiUqr7qCbGBvamLuB1flduHUo5Utu
         v3KprSLrnyvRsOsrBTI/aFddjVRizv3JyeX/y0AcyVKh1pRedoebzODQfuG8nD1twS4q
         ns/r8Y4SM400loO8JTq8ditC2z/Fp9N/GxEX3d+fRdrNbk5YCYf2gAomVuhzrVEx2d8t
         C4f2qn0ab2PtVABh7rRWidpA85u2P99/MLRIWnKKSMIPt3QDiNWkvGg6FP+K/E8HIxG6
         n/l2yn+iHevr/uNHG67LfMaiU3CeZ0pyPYJk8iunSl2NFaNfLzk0iREd9wX11RauskvL
         /67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723221588; x=1723826388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8h94mQb5lQjqtK7zDJ1PwY5ziFswJopQOJnwekObas=;
        b=wJNmO7Es56yfR2oCjl5Nvi8Q8CZxhYF5mMrnSXwIebdkQhptZNJSfar9cWFBNXzOEO
         7GaLVRZm1xPKzCvmmU+LeEPN4zSkLlW5INnOvrp/2tjWz+SXGMu+oR6quhf/yTAD8/YP
         LiNQ/su+CNiWeRF/AcArxNBtU48wUE4jGGqFO2SY+ve9G6m03pR2FADse4ThB+dssNw9
         g2kcW9fHWJb1FWqh1T5ukddLmtcV4+D1DDlgo2j3Omr6ntcI0hRduXvOpW3ROrBcCDQ1
         4MzeaLKLME7NlsYzUqyU9ewzr3UH2rxSbSJoipmkWMqwdmxidsWj5Z5YZu8MhBLhopHb
         0uTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+Lq8ldPLg7fH/1zfZ23gH43hPys84yK7nTSfHzEebSBtU7+NUaQviSZUY1wfZ70rIGHXJPuk4JXd3LZexSx6aURqaXGpD+96ScT2L
X-Gm-Message-State: AOJu0Yzr8kEuuQkbsPyxU7dEVhqkS4B5oPjeCQp2N/4KUg4Oq56NJZZv
	dEVHDsfTuctv2Yl6H/JbJO1XmbpPKyrXi9iJSeKET3KbtibPxZXBEG6bVJCJeG+plPl9oUWpvTS
	lbtPKql/ae3u8AepFibtXfSCqpml+zD5G
X-Google-Smtp-Source: AGHT+IHeZZZIN2AC8gtdHpx65kuXunukB4bIZkAxWSenK2JsRwdXlVyUCGquSPw3PUwE0LWPwXNFLaVp+SfO9nDa5mQ=
X-Received: by 2002:a17:90a:a103:b0:2c9:8020:1b51 with SMTP id
 98e67ed59e1d1-2d1e7f998c8mr2287078a91.3.1723221588395; Fri, 09 Aug 2024
 09:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807182325.2585582-1-surenb@google.com> <CAEf4BzaocU-CQsFZ=s5gDM6XQ0Foss_HroFsPUesBn=qgJCprg@mail.gmail.com>
 <CAJuCfpHsvhjYxj=aovZjTd2qUvJWHpcnEn1kYfd0m23HVrPwDg@mail.gmail.com>
 <CAEf4BzYqKAaGE6GEcMs9MTcrV4cA+i0M5pniqFTy1LQ+g0Yxkw@mail.gmail.com>
 <CAG48ez08f0GNfkqtKa3EV6-miRs3AbXej9WdVh4TvB8ErA6S3w@mail.gmail.com>
 <CAEf4BzZT+c3VHkGy2qtpsbrRVLQwE9ESTtvhJ3_xtJ9L=Hmi_g@mail.gmail.com>
 <CAG48ez1_xx=oVB=4Q3Ywf7UPyO3aWR+N=HwGE5SEuO9+Fgiw_g@mail.gmail.com>
 <CAEf4BzZQ3oXBUVJVBJJ2C49jWL0hMSSxZiCpbMeadof7Q-KPzw@mail.gmail.com> <CAG48ez3Q5PkiEjfKQR1zA=4dL6RXWNTmPqD==MtGKuTZp2HGtw@mail.gmail.com>
In-Reply-To: <CAG48ez3Q5PkiEjfKQR1zA=4dL6RXWNTmPqD==MtGKuTZp2HGtw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Aug 2024 09:39:35 -0700
Message-ID: <CAEf4BzarYwnt-MT+1icXeTVdk0gLUmXuJtV_5dA9=a8CWE3=Tg@mail.gmail.com>
Subject: Re: [RFC 1/1] mm: introduce mmap_lock_speculation_{start|end}
To: Jann Horn <jannh@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 8:21=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Aug 9, 2024 at 12:36=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Thu, Aug 8, 2024 at 3:16=E2=80=AFPM Jann Horn <jannh@google.com> wro=
te:
> > >
> > > On Fri, Aug 9, 2024 at 12:05=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > On Thu, Aug 8, 2024 at 2:43=E2=80=AFPM Jann Horn <jannh@google.com>=
 wrote:
> > > > >
> > > > > On Thu, Aug 8, 2024 at 11:11=E2=80=AFPM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > On Thu, Aug 8, 2024 at 2:02=E2=80=AFPM Suren Baghdasaryan <sure=
nb@google.com> wrote:
> > > > > > >
> > > > > > > On Thu, Aug 8, 2024 at 8:19=E2=80=AFPM Andrii Nakryiko
> > > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Aug 7, 2024 at 11:23=E2=80=AFAM Suren Baghdasaryan =
<surenb@google.com> wrote:
> > > > > > > > >
> > > > > > > > > Add helper functions to speculatively perform operations =
without
> > > > > > > > > read-locking mmap_lock, expecting that mmap_lock will not=
 be
> > > > > > > > > write-locked and mm is not modified from under us.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > > > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > > > > > ---
> > > > > > > >
> > > > > > > > This change makes sense and makes mm's seq a bit more usefu=
l and
> > > > > > > > meaningful. I've also tested it locally with uprobe stress-=
test, and
> > > > > > > > it seems to work great, I haven't run into any problems wit=
h a
> > > > > > > > multi-hour stress test run so far. Thanks!
> > > > > > >
> > > > > > > Thanks for testing and feel free to include this patch into y=
our set.
> > > > > >
> > > > > > Will do!
> > > > > >
> > > > > > >
> > > > > > > I've been thinking about this some more and there is a very u=
nlikely
> > > > > > > corner case if between mmap_lock_speculation_start() and
> > > > > > > mmap_lock_speculation_end() mmap_lock is write-locked/unlocke=
d so many
> > > > > > > times that mm->mm_lock_seq (int) overflows and just happen to=
 reach
> > > > > > > the same value as we recorded in mmap_lock_speculation_start(=
). This
> > > > > > > would generate a false positive, which would show up as if th=
e
> > > > > > > mmap_lock was never touched. Such overflows are possible for =
vm_lock
> > > > > > > as well (see: https://elixir.bootlin.com/linux/v6.10.3/source=
/include/linux/mm_types.h#L688)
> > > > > > > but they are not critical because a false result would simply=
 lead to
> > > > > > > a retry under mmap_lock. However for your case this would be =
a
> > > > > > > critical issue. This is an extremely low probability scenario=
 but
> > > > > > > should we still try to handle it?
> > > > > > >
> > > > > >
> > > > > > No, I think it's fine.
> > > > >
> > > > > Modern computers don't take *that* long to count to 2^32, even wh=
en
> > > > > every step involves one or more syscalls. I've seen bugs where, f=
or
> > > > > example, a 32-bit refcount is not decremented where it should, ma=
king
> > > > > it possible to overflow the refcount with 2^32 operations of some
> > > > > kind, and those have taken something like 3 hours to trigger in o=
ne
> > > > > case (https://bugs.chromium.org/p/project-zero/issues/detail?id=
=3D2478),
> > > > > 14 hours in another case. Or even cases where, if you have enough=
 RAM,
> > > > > you can create 2^32 legitimate references to an object and overfl=
ow a
> > > > > refcount that way
> > > > > (https://bugs.chromium.org/p/project-zero/issues/detail?id=3D809 =
if you
> > > > > had more than 32 GiB of RAM, taking only 25 minutes to overflow t=
he
> > > > > 32-bit counter - and that is with every step allocating memory).
> > > > > So I'd expect 2^32 simple operations that take the mmap lock for
> > > > > writing to be faster than 25 minutes on a modern desktop machine.
> > > > >
> > > > > So for a reader of some kinda 32-bit sequence count, if it is
> > > > > conceivably possible for the reader to take at least maybe a coup=
le
> > > > > minutes or so between the sequence count reads (also counting tim=
e
> > > > > during which the reader is preempted or something like that), the=
re
> > > > > could be a problem. At that point in the analysis, if you wanted =
to
> > > > > know whether it's actually exploitable, I guess you'd have to loo=
k at
> > > > > what kinda context you're running in, and what kinda events can
> > > > > interrupt/preempt you (like whether someone can send a sufficient=
ly
> > > > > dense flood of IPIs to completely prevent you making forward prog=
ress,
> > > > > like in https://www.vusec.net/projects/ghostrace/), and for how l=
ong
> > > > > those things can delay you (maybe including what the pessimal
> > > > > scheduler behavior looks like if you're in preemptible context, o=
r how
> > > > > long clock interrupts can take to execute when processing a giant=
 pile
> > > > > of epoll watches), and so on...
> > > > >
> > > >
> > > > And here we are talking about *lockless* *speculative* VMA usage th=
at
> > > > will last what, at most on the order of a few microseconds?
> > >
> > > Are you talking about time spent in task context, or time spent while
> > > the task is on the CPU (including time in interrupt context), or abou=
t
> > > wall clock time?
> >
> > We are doing, roughly:
> >
> > mmap_lock_speculation_start();
> > rcu_read_lock();
> > vma_lookup();
> > rb_find();
> > rcu_read_unlock();
> > mmap_lock_speculation_end();
> >
> >
> > On non-RT kernel this can be prolonged only by having an NMI somewhere
> > in the middle.
>
> I don't think you're running with interrupts off here? Even on kernels
> without any preemption support, normal interrupts (like timers,
> incoming network traffic, TLB flush IPIs) should still be able to
> interrupt here. And in CONFIG_PREEMPT kernels (which enable
> CONFIG_PREEMPT_RCU by default), rcu_read_lock() doesn't block
> preemption, so you can even get preempted here - I don't think you
> need RT for that.

Fair enough, normal interrupts can happen as well. Still, we are
talking about the above fast sequence running long enough (for
whatever reason) for the rest of the system to update mm (and not just
plan increment counters) for 2 billion times with mmap_write_lock() +
actual work + vma_end_write_all() logic. All kinds of bad things will
start happening before that: RCU stall warnings, lots of accumulated
memory waiting for RCU grace period, blocked threads on
synchronize_rcu(), etc.

>
> My understanding is that the main difference between normal
> CONFIG_PREEMPT and RT is whether spin_lock() blocks preemption.
>
> > On RT it can get preempted even within RCU locked
> > region, if I understand correctly. If you manage to make this part run
> > sufficiently long to overflow 31-bit counter, it's probably a bigger
> > problem than mmap's sequence wrapping over, no?
>
> From the perspective of security, I don't consider it to be
> particularly severe by itself if a local process can make the system
> stall for very long amounts of time. And from the perspective of
> reliability, I think scenarios where someone has to very explicitly go
> out of their way to destabilize the system don't matter so much?

So just to be clear. u64 counter is a no-brainer and I have nothing
against that. What I do worry about, though, is that this 64-bit
counter will be objected to due to it being potentially slower on
32-bit architectures. So I'd rather have
mmap_lock_speculation_{start,end}() with a 32-bit mm_lock_seq counter
than not have a way to speculate against VMA/mm at all.

