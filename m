Return-Path: <linux-kernel+bounces-281118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B82894D34C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A0D1C2220A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D610198A30;
	Fri,  9 Aug 2024 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTPdD8Cg"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D5D198A20
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216883; cv=none; b=RAd8I60a9ALE1OPQeeUFtCtkp6Z1Sg55CjnQ7OMos0T1aoMc11dAo4cBjr+wfFg/YqHJj16sD63AeSwSZnR6diQ02pdq4KS8mFSeQOki2imwBIEEw08FMcldX2M9rmIe4Ky9d4OVUoga6eOB6lpVK8t3oc0Ac6KFif9RXk/+g14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216883; c=relaxed/simple;
	bh=x7ltWGIKIMpSEQUqVRb7EjS3z17Cftjz65DvSer+VyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cr86qdPdtO2RBcgHtMnEn6hIc1CRCNo11V6z4nUvIw2e/NPk/MwiEx6DSqf9kb2bli+4IQ/keWMYAm1n7Gr/qSE8mdThnJ7eUSO58m8f5FpA08tksd8L9EbDtjx0o32Ik4qBUj5e/x5o7dil3BdEs1Kc2STa11hvyzTEUNkUBl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kTPdD8Cg; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5b9fe5ea355so12965a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 08:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723216880; x=1723821680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7ltWGIKIMpSEQUqVRb7EjS3z17Cftjz65DvSer+VyY=;
        b=kTPdD8Cg1FJSzE/gKIApNOyc94xurBPKo7Lh3B6lIGqHpHEbhxD3UJxi0m4YivgtHX
         XWBdgn70fvUeyUosWrK683mcuNrAZiBq8f0lJgFZSkPtKpZ48Ry7W6mBxNTB+606wLZO
         pWh8YXmfJPy3Fh2sei/ATVRjxchH9tTv8BDqT6AymxLpImZOijRphETQK4UhUpoQ2cj+
         6+EOI5PtOffcE1KSHSRGvTXbLnMdWlx+aSQy0tJY+cPUHU7ldgnrf8+HA0XOR01Jn7eI
         r3iOLoH+xppGewJqACS9wj/30tfq+XNJgEB0Wm4BU6rU7gn9IB/J6GlWJcAVOAGDzmbo
         eZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723216880; x=1723821680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7ltWGIKIMpSEQUqVRb7EjS3z17Cftjz65DvSer+VyY=;
        b=f7AAWgmTxm++J/qu3YtApHY+/eauiEBz9nNKaXNJRJ7thKQfEltkfcBAw/xwjpFnFC
         KTD+uZhFUJo4WCYduMvifhs9ggoaS1ikyhgv1+p2qqy+OQeKJA7/gBMzkn+4vtqzf1ou
         KC/LzvJTC1Xo+tVNSbkYEtoClw+2wOn4e2lLa/uGT0FshzaosCkFEqVCuThLPvynFjLr
         cGzpMMWW/aQJwQ5af771ui2iaS2hNv4if/owIkFD8u5wZolvD/KJr4uIAEDcsc23VNES
         He8VcDpQOxlufxRrUNyqoo2omtO85E5FyrIHYabyXTYAjiXfGefSRnu7qWU9pWQSp17N
         s1YA==
X-Forwarded-Encrypted: i=1; AJvYcCUyRPNonhpzhGSOYfbY3ZEu/QF+Qb3OXoHugIV7QnbCHmmRqY/GfZ+hKmiANzR6qgE8Kg/L0UGlNyKPZNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy715fQATdZbHC8TZKTnJyNq8nubBUiO0uWq8r/JHId1QJMep2S
	2rwoyoCYOpCU7SiDHxxatSqxlEsnsuN3yS+wQpbr2RGh8D0I1/g3/WA4CAvl6xfMFGRPijbWXzW
	SqTE4j5vmEnoKkcx67MlqR+2xE4dhnoIgxO5x
X-Google-Smtp-Source: AGHT+IGIPHfXCaWajaFbVpbJ28cd50OKg5ViAT7LMapyd6SOHzEqqQ0FInqgFF3aIds28z6LZdkvYr5YURDWIpve5tg=
X-Received: by 2002:a05:6402:5216:b0:5b8:ccae:a8b8 with SMTP id
 4fb4d7f45d1cf-5bc4b3fd7b2mr150033a12.3.1723216878902; Fri, 09 Aug 2024
 08:21:18 -0700 (PDT)
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
 <CAG48ez1_xx=oVB=4Q3Ywf7UPyO3aWR+N=HwGE5SEuO9+Fgiw_g@mail.gmail.com> <CAEf4BzZQ3oXBUVJVBJJ2C49jWL0hMSSxZiCpbMeadof7Q-KPzw@mail.gmail.com>
In-Reply-To: <CAEf4BzZQ3oXBUVJVBJJ2C49jWL0hMSSxZiCpbMeadof7Q-KPzw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 9 Aug 2024 17:20:42 +0200
Message-ID: <CAG48ez3Q5PkiEjfKQR1zA=4dL6RXWNTmPqD==MtGKuTZp2HGtw@mail.gmail.com>
Subject: Re: [RFC 1/1] mm: introduce mmap_lock_speculation_{start|end}
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:36=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Thu, Aug 8, 2024 at 3:16=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
> >
> > On Fri, Aug 9, 2024 at 12:05=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Thu, Aug 8, 2024 at 2:43=E2=80=AFPM Jann Horn <jannh@google.com> w=
rote:
> > > >
> > > > On Thu, Aug 8, 2024 at 11:11=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > On Thu, Aug 8, 2024 at 2:02=E2=80=AFPM Suren Baghdasaryan <surenb=
@google.com> wrote:
> > > > > >
> > > > > > On Thu, Aug 8, 2024 at 8:19=E2=80=AFPM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Aug 7, 2024 at 11:23=E2=80=AFAM Suren Baghdasaryan <s=
urenb@google.com> wrote:
> > > > > > > >
> > > > > > > > Add helper functions to speculatively perform operations wi=
thout
> > > > > > > > read-locking mmap_lock, expecting that mmap_lock will not b=
e
> > > > > > > > write-locked and mm is not modified from under us.
> > > > > > > >
> > > > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > > > > ---
> > > > > > >
> > > > > > > This change makes sense and makes mm's seq a bit more useful =
and
> > > > > > > meaningful. I've also tested it locally with uprobe stress-te=
st, and
> > > > > > > it seems to work great, I haven't run into any problems with =
a
> > > > > > > multi-hour stress test run so far. Thanks!
> > > > > >
> > > > > > Thanks for testing and feel free to include this patch into you=
r set.
> > > > >
> > > > > Will do!
> > > > >
> > > > > >
> > > > > > I've been thinking about this some more and there is a very unl=
ikely
> > > > > > corner case if between mmap_lock_speculation_start() and
> > > > > > mmap_lock_speculation_end() mmap_lock is write-locked/unlocked =
so many
> > > > > > times that mm->mm_lock_seq (int) overflows and just happen to r=
each
> > > > > > the same value as we recorded in mmap_lock_speculation_start().=
 This
> > > > > > would generate a false positive, which would show up as if the
> > > > > > mmap_lock was never touched. Such overflows are possible for vm=
_lock
> > > > > > as well (see: https://elixir.bootlin.com/linux/v6.10.3/source/i=
nclude/linux/mm_types.h#L688)
> > > > > > but they are not critical because a false result would simply l=
ead to
> > > > > > a retry under mmap_lock. However for your case this would be a
> > > > > > critical issue. This is an extremely low probability scenario b=
ut
> > > > > > should we still try to handle it?
> > > > > >
> > > > >
> > > > > No, I think it's fine.
> > > >
> > > > Modern computers don't take *that* long to count to 2^32, even when
> > > > every step involves one or more syscalls. I've seen bugs where, for
> > > > example, a 32-bit refcount is not decremented where it should, maki=
ng
> > > > it possible to overflow the refcount with 2^32 operations of some
> > > > kind, and those have taken something like 3 hours to trigger in one
> > > > case (https://bugs.chromium.org/p/project-zero/issues/detail?id=3D2=
478),
> > > > 14 hours in another case. Or even cases where, if you have enough R=
AM,
> > > > you can create 2^32 legitimate references to an object and overflow=
 a
> > > > refcount that way
> > > > (https://bugs.chromium.org/p/project-zero/issues/detail?id=3D809 if=
 you
> > > > had more than 32 GiB of RAM, taking only 25 minutes to overflow the
> > > > 32-bit counter - and that is with every step allocating memory).
> > > > So I'd expect 2^32 simple operations that take the mmap lock for
> > > > writing to be faster than 25 minutes on a modern desktop machine.
> > > >
> > > > So for a reader of some kinda 32-bit sequence count, if it is
> > > > conceivably possible for the reader to take at least maybe a couple
> > > > minutes or so between the sequence count reads (also counting time
> > > > during which the reader is preempted or something like that), there
> > > > could be a problem. At that point in the analysis, if you wanted to
> > > > know whether it's actually exploitable, I guess you'd have to look =
at
> > > > what kinda context you're running in, and what kinda events can
> > > > interrupt/preempt you (like whether someone can send a sufficiently
> > > > dense flood of IPIs to completely prevent you making forward progre=
ss,
> > > > like in https://www.vusec.net/projects/ghostrace/), and for how lon=
g
> > > > those things can delay you (maybe including what the pessimal
> > > > scheduler behavior looks like if you're in preemptible context, or =
how
> > > > long clock interrupts can take to execute when processing a giant p=
ile
> > > > of epoll watches), and so on...
> > > >
> > >
> > > And here we are talking about *lockless* *speculative* VMA usage that
> > > will last what, at most on the order of a few microseconds?
> >
> > Are you talking about time spent in task context, or time spent while
> > the task is on the CPU (including time in interrupt context), or about
> > wall clock time?
>
> We are doing, roughly:
>
> mmap_lock_speculation_start();
> rcu_read_lock();
> vma_lookup();
> rb_find();
> rcu_read_unlock();
> mmap_lock_speculation_end();
>
>
> On non-RT kernel this can be prolonged only by having an NMI somewhere
> in the middle.

I don't think you're running with interrupts off here? Even on kernels
without any preemption support, normal interrupts (like timers,
incoming network traffic, TLB flush IPIs) should still be able to
interrupt here. And in CONFIG_PREEMPT kernels (which enable
CONFIG_PREEMPT_RCU by default), rcu_read_lock() doesn't block
preemption, so you can even get preempted here - I don't think you
need RT for that.

My understanding is that the main difference between normal
CONFIG_PREEMPT and RT is whether spin_lock() blocks preemption.

> On RT it can get preempted even within RCU locked
> region, if I understand correctly. If you manage to make this part run
> sufficiently long to overflow 31-bit counter, it's probably a bigger
> problem than mmap's sequence wrapping over, no?

From the perspective of security, I don't consider it to be
particularly severe by itself if a local process can make the system
stall for very long amounts of time. And from the perspective of
reliability, I think scenarios where someone has to very explicitly go
out of their way to destabilize the system don't matter so much?

