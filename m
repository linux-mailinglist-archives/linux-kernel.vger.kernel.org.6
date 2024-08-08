Return-Path: <linux-kernel+bounces-280219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0566994C759
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8325E1F24820
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562D7160796;
	Thu,  8 Aug 2024 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3sBiRu1"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306B915FA92
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723159579; cv=none; b=eG+v97B0C2LL/trSEgiO7aERKEEzohP0PewPBXuekrIzTTrbb+6Zko88X35vqfuqHVMevkj8JSbArKOw4pa196EbIMyv/VUrLx0ee25DnS5emM3+xSogCGB8PmhGsC+pSm1LT2fNqI+Ms3o7MULMXldssfZXb+M1ElsQ+wwwP9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723159579; c=relaxed/simple;
	bh=hTOczmfkmfbd2Qji/V+C8NN0tzSDjEY6GPHucHSjG1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuLMtkJNYptxfrH9DvybmU7AtTGRCHNKMBRUJaaO7CjAoOV46BfRS/2lRuHDJ/hOlkTSfMFXp6EWoOfGvNbXLZRstBWO0mYqR4NkJTkDWpiz/3wMw2UkPrBliM9AMwS34qoNo+Z/HwecKdKn4xPqi3Qpct6El/+5KglpilcW+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v3sBiRu1; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-66108213e88so13981677b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 16:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723159576; x=1723764376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTOczmfkmfbd2Qji/V+C8NN0tzSDjEY6GPHucHSjG1A=;
        b=v3sBiRu1aqOusYt0O/cfnSeroPKqCGdYVsIKMe0L1gRn0NqmXQ5/JlTa75zzr7bgAO
         UqBL2DnIB0lAzqVdbqf2D1JPgvvpJ4NGYzlP+wU/OHkhIJEtMxGHTmqtdtx1wXFrIOaY
         ovdNKIt0OgwBCq/znRH92q3tJv1cMvuHpdl50KgXrrVdvmDd2mC+EOGsGUMBxWsEJA1F
         lEICDsMINxF0FnT8jA8pBdt+1WMfqE01cm1qY3gsav8MtgCWUo9ljYW+SovTKUbrqENQ
         1cWJK4+Gww6PEpVm00e+TAob+ABMGtRpVQbz09vusBz555RkFgVLS9b9vf+N9Cv3JBAT
         wesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723159576; x=1723764376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTOczmfkmfbd2Qji/V+C8NN0tzSDjEY6GPHucHSjG1A=;
        b=URI0N124uH5RBf/xaJbCTky9ENH3XTgo8CY5WaZBllHqfDgFLBQRGp68YoMaVlFCIX
         2SZI6A2P6H2n+hXa9A7jbKp2uUlunI55yy/YjajnHdeyu8j5sbxgHYgUX+3pU9GfDCOl
         C+n2E8ynFPO+2EyzMIEy3gJvqAwpLcgsrrDCbNL/ZPbsB7/b56CViScs8Jbrh7yZYlZp
         E3Nr91/xrpwpjslRYzUdbzGm038ytoJACJsVjhuCzA0+Hb0Op5sfWk9rpdFVKTFdtP52
         uOSL82FipCm/i8op7pJ9PEevNwMxicXJkX3gTq6xIntV2Xq9Dk5lXZ2oSz9D1vk0q9zG
         Bchw==
X-Forwarded-Encrypted: i=1; AJvYcCU9jwN32hlOozKYQFQ542aYeXPRy1ws6MX/Tv8LCE4g0pH1Cd8onDtGV/lTh5+Z2wNWNXWo+UDIPmBZBAVS3Fu71MI9D4ri3mjcnBLt
X-Gm-Message-State: AOJu0YyzG7NvTNHdihU6PxdWfbLq1AlDtcQiYTBx+KaJJakzuOmEbr61
	Hl60lQkj2OkD4rCX8ISn8Ip0mNwOzW6SKppgh09Q6z1Qg7s7uNx6E02wE0DB+G8UlLOdnFZKuv5
	FNpVZhPj0rmP5YXbvPhc57+P01LuGmAUkGFMl
X-Google-Smtp-Source: AGHT+IHmhi740nEBn9y0GocruTloZ3uho06rlLESqotsWUBPQ6bSPEmzO3C/G2fKr5Vp+ESUvZNTRUSlGXUMszcttVk=
X-Received: by 2002:a05:690c:f93:b0:649:8f00:5254 with SMTP id
 00721157ae682-69bf7540e14mr42926727b3.1.1723159575709; Thu, 08 Aug 2024
 16:26:15 -0700 (PDT)
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
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 8 Aug 2024 16:26:02 -0700
Message-ID: <CAJuCfpFb+4PtZtTLFHjg4mfPU4=RaGDO87HkeB5vSV=D_fgVHw@mail.gmail.com>
Subject: Re: [RFC 1/1] mm: introduce mmap_lock_speculation_{start|end}
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jann Horn <jannh@google.com>, akpm@linux-foundation.org, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 3:36=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
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
> in the middle. On RT it can get preempted even within RCU locked
> region, if I understand correctly. If you manage to make this part run
> sufficiently long to overflow 31-bit counter, it's probably a bigger
> problem than mmap's sequence wrapping over, no?

I was also thinking that an easy way to strengthen the guarantee this
overflow does not happen is to make mm->mm_lock_seq a 64-bit counter
while keeping vma->vm_lock_seq as is. When comparing them we can use
the lowest 32 bits of mm->mm_lock_seq without any loss of correctness.
Seems easy enough (famous last words). If we decide to do that I will
run performance tests to make sure performance does not suffer.

>
> >
> > https://www.vusec.net/projects/ghostrace/ is pretty amazing - when you
> > look at the paper
> > https://download.vusec.net/papers/ghostrace_sec24.pdf you can see in
> > Figure 4 how they managed to turn a race window that's 8 instructions
> > wide into a window they can stretch "indefinitely", and they didn't
> > even have to reschedule to pull it off. If I understand correctly,
> > they stretched the race window to something like 35 seconds and could
> > have stretched it even wider if they had wanted to?
> >
> > (And yes, Linux fixed the specific trick they used for doing that, but
> > it still shows that this kinda thing is possible in principle.)

