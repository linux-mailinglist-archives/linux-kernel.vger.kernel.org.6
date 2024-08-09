Return-Path: <linux-kernel+bounces-281285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B28094D51A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005C2286D75
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25613219F;
	Fri,  9 Aug 2024 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SUIcZ35M"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D837B1CF96
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723222533; cv=none; b=r3EhUCX41hyYV0PDsnfBFqA9EYLPt2FQv5xO9KJZSawn9VpoEoUx09/6sS0RbqqOa/n6Qtv7Bb9bkXP4yug9TTRheiwOYNrEkaCqQaEIGVJAeJQ/Slf8JFFkKklqHCZ39HJOYOfVUBT6STVPz9FMr88Tf81uSGj4ou/DaWqbXek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723222533; c=relaxed/simple;
	bh=J5i/p0omALrzZ58Vf9x0UYTuhGGWDAQBmom9R+mFQxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M112Be79z/PRf87popch16S2YWOC3E2XVMfeT0icdAAVmxaiP5Kg4MbrE41AAog8pKhN9RR8jVvADam3wXQcbLs3CSeJ+vMMfL9BjEXfm3Gdhza3F2V4/aA57x7M0DyHMJn0Mng+qP9qD3KYz8eT0XQUXdeX/l0XV/wI+2tYfy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SUIcZ35M; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-65f9708c50dso23698497b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723222531; x=1723827331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5i/p0omALrzZ58Vf9x0UYTuhGGWDAQBmom9R+mFQxo=;
        b=SUIcZ35MiRC2E9y4yd3ke6HxBnDjiAxkUubi2TDFphWuMeY7o4z8dyBjWomoAwHicA
         +2OMmVfiWAHDg5cnmOx36zlSu2nBaZg4UlHPuD/w/TAYO0yzIao9OKwh/I8IBNypXGwa
         DuuYFUm+zP1X3qcySV43xdK0f9vw7ABC53VzQo8I7+8Rz7Lw9v2tR7cFaRGc/5pPLUDb
         UAH7p6TdSqhs90GIhVmjuohvlwKjQ14X8zN7OigKYMvD7ALtZeJvIFLuwMS5gx0qYQBC
         cw/qEL3MITm+D8LlPWIF07xWWRjZPSOLHTRfcLbstW85NvWAwn2HPpe3f133PfsooNZ/
         Mzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723222531; x=1723827331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5i/p0omALrzZ58Vf9x0UYTuhGGWDAQBmom9R+mFQxo=;
        b=ZPg9GTSCLtgeG8aVbIkBb0uL/lQQDtH0FBwFgPKaoqnCwTwABTa4d3wkiBewMZL6jA
         WY+ycUsLre1sXTs/u0f7rRTBH3qS89rT1pGXg7Dq+WFQB+zjQLSozCsce4HAixRpTL0p
         mig5DotIOUy/ld61pXTCzsc6huFsG0xoaSNThA3aFHtEsKW53gktgKeNf8Tv/uX4w9Yf
         gtUW5eaY2s4LxczzlFPkkntDhsiCmprnwA3SYuwmGp4SmPgEoyzbIroFKF5b27+9A2Gt
         z9DXtIj0LiVmpD+KEpl0UK0VFTvVgjYoZwT7xNJ/gMJa0FqA31SM/QqR42MrLYfuwJ9+
         ytiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRIHkNZJRnJz4pE8T3a6WfwsAuDf3LiSLy774mup3jqKVl0P6jcyAkACjxLjMuQHsl3J8oG3a8LXJhFL7I+ca/BOUs7OjQFJakkly8
X-Gm-Message-State: AOJu0YxQCtjuOTF3kYzAOCT1ratQ9a2MD2Nq4K+q9/8fTs3SziEFyCpw
	BUnZiDko8ZtByb695MaWYjqH8Hus5aHk7+gc84IOOXcm3wO3FCo2LqEZl/H0FuNLsU9L3XRCl54
	YJranjdtPuutQuPePwRAHA5mtWMJSlg0H92CpGaGnnj7Z7RofZw==
X-Google-Smtp-Source: AGHT+IEck6xMZmVO50703MWINq6qnIu7HvngT5vX/8c+opsyGxR16BYh0iiv5ys03WK109fWbm3Iu+oIo9ZiKO0KJB0=
X-Received: by 2002:a05:690c:b05:b0:646:3ef4:6ace with SMTP id
 00721157ae682-69ec66fea64mr28248707b3.24.1723222530393; Fri, 09 Aug 2024
 09:55:30 -0700 (PDT)
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
 <CAEf4BzZQ3oXBUVJVBJJ2C49jWL0hMSSxZiCpbMeadof7Q-KPzw@mail.gmail.com>
 <CAG48ez3Q5PkiEjfKQR1zA=4dL6RXWNTmPqD==MtGKuTZp2HGtw@mail.gmail.com> <CAEf4BzarYwnt-MT+1icXeTVdk0gLUmXuJtV_5dA9=a8CWE3=Tg@mail.gmail.com>
In-Reply-To: <CAEf4BzarYwnt-MT+1icXeTVdk0gLUmXuJtV_5dA9=a8CWE3=Tg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 9 Aug 2024 16:55:17 +0000
Message-ID: <CAJuCfpHquwbc2768MjOp8vUT7fSaV=xd+pBn4fPOUHBHJdNxnA@mail.gmail.com>
Subject: Re: [RFC 1/1] mm: introduce mmap_lock_speculation_{start|end}
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jann Horn <jannh@google.com>, akpm@linux-foundation.org, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 4:39=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Aug 9, 2024 at 8:21=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
> >
> > On Fri, Aug 9, 2024 at 12:36=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Thu, Aug 8, 2024 at 3:16=E2=80=AFPM Jann Horn <jannh@google.com> w=
rote:
> > > >
> > > > On Fri, Aug 9, 2024 at 12:05=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > On Thu, Aug 8, 2024 at 2:43=E2=80=AFPM Jann Horn <jannh@google.co=
m> wrote:
> > > > > >
> > > > > > On Thu, Aug 8, 2024 at 11:11=E2=80=AFPM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > On Thu, Aug 8, 2024 at 2:02=E2=80=AFPM Suren Baghdasaryan <su=
renb@google.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Aug 8, 2024 at 8:19=E2=80=AFPM Andrii Nakryiko
> > > > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Aug 7, 2024 at 11:23=E2=80=AFAM Suren Baghdasarya=
n <surenb@google.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Add helper functions to speculatively perform operation=
s without
> > > > > > > > > > read-locking mmap_lock, expecting that mmap_lock will n=
ot be
> > > > > > > > > > write-locked and mm is not modified from under us.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > > > > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > This change makes sense and makes mm's seq a bit more use=
ful and
> > > > > > > > > meaningful. I've also tested it locally with uprobe stres=
s-test, and
> > > > > > > > > it seems to work great, I haven't run into any problems w=
ith a
> > > > > > > > > multi-hour stress test run so far. Thanks!
> > > > > > > >
> > > > > > > > Thanks for testing and feel free to include this patch into=
 your set.
> > > > > > >
> > > > > > > Will do!
> > > > > > >
> > > > > > > >
> > > > > > > > I've been thinking about this some more and there is a very=
 unlikely
> > > > > > > > corner case if between mmap_lock_speculation_start() and
> > > > > > > > mmap_lock_speculation_end() mmap_lock is write-locked/unloc=
ked so many
> > > > > > > > times that mm->mm_lock_seq (int) overflows and just happen =
to reach
> > > > > > > > the same value as we recorded in mmap_lock_speculation_star=
t(). This
> > > > > > > > would generate a false positive, which would show up as if =
the
> > > > > > > > mmap_lock was never touched. Such overflows are possible fo=
r vm_lock
> > > > > > > > as well (see: https://elixir.bootlin.com/linux/v6.10.3/sour=
ce/include/linux/mm_types.h#L688)
> > > > > > > > but they are not critical because a false result would simp=
ly lead to
> > > > > > > > a retry under mmap_lock. However for your case this would b=
e a
> > > > > > > > critical issue. This is an extremely low probability scenar=
io but
> > > > > > > > should we still try to handle it?
> > > > > > > >
> > > > > > >
> > > > > > > No, I think it's fine.
> > > > > >
> > > > > > Modern computers don't take *that* long to count to 2^32, even =
when
> > > > > > every step involves one or more syscalls. I've seen bugs where,=
 for
> > > > > > example, a 32-bit refcount is not decremented where it should, =
making
> > > > > > it possible to overflow the refcount with 2^32 operations of so=
me
> > > > > > kind, and those have taken something like 3 hours to trigger in=
 one
> > > > > > case (https://bugs.chromium.org/p/project-zero/issues/detail?id=
=3D2478),
> > > > > > 14 hours in another case. Or even cases where, if you have enou=
gh RAM,
> > > > > > you can create 2^32 legitimate references to an object and over=
flow a
> > > > > > refcount that way
> > > > > > (https://bugs.chromium.org/p/project-zero/issues/detail?id=3D80=
9 if you
> > > > > > had more than 32 GiB of RAM, taking only 25 minutes to overflow=
 the
> > > > > > 32-bit counter - and that is with every step allocating memory)=
.
> > > > > > So I'd expect 2^32 simple operations that take the mmap lock fo=
r
> > > > > > writing to be faster than 25 minutes on a modern desktop machin=
e.
> > > > > >
> > > > > > So for a reader of some kinda 32-bit sequence count, if it is
> > > > > > conceivably possible for the reader to take at least maybe a co=
uple
> > > > > > minutes or so between the sequence count reads (also counting t=
ime
> > > > > > during which the reader is preempted or something like that), t=
here
> > > > > > could be a problem. At that point in the analysis, if you wante=
d to
> > > > > > know whether it's actually exploitable, I guess you'd have to l=
ook at
> > > > > > what kinda context you're running in, and what kinda events can
> > > > > > interrupt/preempt you (like whether someone can send a sufficie=
ntly
> > > > > > dense flood of IPIs to completely prevent you making forward pr=
ogress,
> > > > > > like in https://www.vusec.net/projects/ghostrace/), and for how=
 long
> > > > > > those things can delay you (maybe including what the pessimal
> > > > > > scheduler behavior looks like if you're in preemptible context,=
 or how
> > > > > > long clock interrupts can take to execute when processing a gia=
nt pile
> > > > > > of epoll watches), and so on...
> > > > > >
> > > > >
> > > > > And here we are talking about *lockless* *speculative* VMA usage =
that
> > > > > will last what, at most on the order of a few microseconds?
> > > >
> > > > Are you talking about time spent in task context, or time spent whi=
le
> > > > the task is on the CPU (including time in interrupt context), or ab=
out
> > > > wall clock time?
> > >
> > > We are doing, roughly:
> > >
> > > mmap_lock_speculation_start();
> > > rcu_read_lock();
> > > vma_lookup();
> > > rb_find();
> > > rcu_read_unlock();
> > > mmap_lock_speculation_end();
> > >
> > >
> > > On non-RT kernel this can be prolonged only by having an NMI somewher=
e
> > > in the middle.
> >
> > I don't think you're running with interrupts off here? Even on kernels
> > without any preemption support, normal interrupts (like timers,
> > incoming network traffic, TLB flush IPIs) should still be able to
> > interrupt here. And in CONFIG_PREEMPT kernels (which enable
> > CONFIG_PREEMPT_RCU by default), rcu_read_lock() doesn't block
> > preemption, so you can even get preempted here - I don't think you
> > need RT for that.
>
> Fair enough, normal interrupts can happen as well. Still, we are
> talking about the above fast sequence running long enough (for
> whatever reason) for the rest of the system to update mm (and not just
> plan increment counters) for 2 billion times with mmap_write_lock() +
> actual work + vma_end_write_all() logic. All kinds of bad things will
> start happening before that: RCU stall warnings, lots of accumulated
> memory waiting for RCU grace period, blocked threads on
> synchronize_rcu(), etc.
>
> >
> > My understanding is that the main difference between normal
> > CONFIG_PREEMPT and RT is whether spin_lock() blocks preemption.
> >
> > > On RT it can get preempted even within RCU locked
> > > region, if I understand correctly. If you manage to make this part ru=
n
> > > sufficiently long to overflow 31-bit counter, it's probably a bigger
> > > problem than mmap's sequence wrapping over, no?
> >
> > From the perspective of security, I don't consider it to be
> > particularly severe by itself if a local process can make the system
> > stall for very long amounts of time. And from the perspective of
> > reliability, I think scenarios where someone has to very explicitly go
> > out of their way to destabilize the system don't matter so much?
>
> So just to be clear. u64 counter is a no-brainer and I have nothing
> against that. What I do worry about, though, is that this 64-bit
> counter will be objected to due to it being potentially slower on
> 32-bit architectures. So I'd rather have
> mmap_lock_speculation_{start,end}() with a 32-bit mm_lock_seq counter
> than not have a way to speculate against VMA/mm at all.

IMHO the probability that the 32-bit counter will wrap around and end
up at exactly the same value out of 2^32 possible ones is so minuscule
that we could ignore that possibility.

