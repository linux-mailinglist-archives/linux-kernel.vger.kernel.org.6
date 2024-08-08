Return-Path: <linux-kernel+bounces-280197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBC594C702
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 00:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF2028562F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC01E15A853;
	Thu,  8 Aug 2024 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fip/Fzqp"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D91812E1EE
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723156587; cv=none; b=UDrx+bywWOeONH4G6y5ApEQ8/rChRkMgw1bnaH858TswwVjs7DTdpLaMp2aKqRko9QjXxDVGKdvr8/mPEVa9LNg67eTBWI8FApjtNizA+Gg6ktTi2Tg1DVnvblYzVjpbH/D0urcXo+0VpmP6a2cGr5jhx4ELxLYXsLXDlcHxFl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723156587; c=relaxed/simple;
	bh=SWRVMLga6wpH1SouyS7VgkovpZarU2ZzxsG01R4Pwp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVe4nkNHn6NXCxTdHDMjeDsRTkPbG14uWwtMSJ7dqbGEZLvxrLY6AQjVWhLoZHWX0lJJ9ejqOXG98ZZnrQJJtvt6lxQ5xltCli2XyoCtGo0DSsViMKFzrNBzHHH2TDkKCLTjgBCXno1ZHsWzbBSpkBcPpjYq0wKA1UK5cS+fg68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fip/Fzqp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-369c609d0c7so1125529f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723156583; x=1723761383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWRVMLga6wpH1SouyS7VgkovpZarU2ZzxsG01R4Pwp0=;
        b=fip/FzqpJVXv9szn6yAzVJJeHhc/vfjtKdQaZCZWnRP8tmpxb3kc0qZrFDbnSeIgQ3
         VY5ArCBtCWCr+ljEYuglqhO3dnVAekavBAPZ1EEpfMq3RqF8asoPXto6RlorXXrIoF8I
         kXpnsMr1fL5sRu8ibOEpxmTvmocv3DaObfN5sMZiPbfs88xJethC5KoMfTcoAYasOvWE
         noP8DKEhiNUO1KoCRJKZLFZ4tolz2q4c1nHj2eqwbXacU5EVU+67ErtFjVJFET3+7UZj
         ApiXIwdNHiug1Na6saY64P1zAqX+v/YJg6NRcySAEOa+GY1Pxf5t3IxqPUElDYwQ7eV9
         GS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723156583; x=1723761383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWRVMLga6wpH1SouyS7VgkovpZarU2ZzxsG01R4Pwp0=;
        b=MkfwJq0coBgO9IeqDlLHEd22Zj5q3QJRvSm94ebpQho7CLrpjyXLiZtxnrYpevrxrj
         ZIsW5CV4koWfiFX3c1DUwOieheHMVkEPHdTaiN9hCDIOd3cpyc+mwokeSBsbJOBr4rS6
         P+yL/4MCI3pnsTKt0Mljn90kIWOsAx5BVftRWHYb6/l+TSIPmGjnNxw/C/ePL9CUg4wE
         a8Gku+HoT1grQf8u5krjw2fdggkvSNccm25ByT5dd/7mu7Tes57/9qPJG2fjzXxEDDDA
         Lev33zdo9j44wlGDnVFi6M8BXm4heujuVqA0QshR4xkPFbIWyD/R7gkugjW7rS/+7c3/
         4KWw==
X-Forwarded-Encrypted: i=1; AJvYcCVY3Ry/t8COOOXVtUDyNZwSuf0zGNOls/rwv90yxmw7ArMa2dPFp8hU1TgzROA6LUjWxGjoiIJcXW6m3Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4nm4SSruRaoW9AWoZvbz2kMwpARsEveVwvYm1LEdwufxLsLtn
	K9OZ+Gk1U0izYgptrXzKZdkhI55OKMxp70vd4MxD71aR2biT8qowL2q2+KdivhmfvjxX9dUwVhF
	C/ZMbDBu9UZ8XNy//aVk+xyyFeY4=
X-Google-Smtp-Source: AGHT+IGOjgtP6nMtssysUHus8AAiD01zv6ZlWb5Mdmhxz8LZtrPQegQq8dWT1goSEzdDMr70MJh3e+mhdBBKMh2UgX8=
X-Received: by 2002:a5d:456b:0:b0:366:ee01:30d6 with SMTP id
 ffacd0b85a97d-36d27580bd8mr2915803f8f.49.1723156583212; Thu, 08 Aug 2024
 15:36:23 -0700 (PDT)
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
 <CAEf4BzZT+c3VHkGy2qtpsbrRVLQwE9ESTtvhJ3_xtJ9L=Hmi_g@mail.gmail.com> <CAG48ez1_xx=oVB=4Q3Ywf7UPyO3aWR+N=HwGE5SEuO9+Fgiw_g@mail.gmail.com>
In-Reply-To: <CAG48ez1_xx=oVB=4Q3Ywf7UPyO3aWR+N=HwGE5SEuO9+Fgiw_g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Aug 2024 15:36:07 -0700
Message-ID: <CAEf4BzZQ3oXBUVJVBJJ2C49jWL0hMSSxZiCpbMeadof7Q-KPzw@mail.gmail.com>
Subject: Re: [RFC 1/1] mm: introduce mmap_lock_speculation_{start|end}
To: Jann Horn <jannh@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 3:16=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Aug 9, 2024 at 12:05=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Thu, Aug 8, 2024 at 2:43=E2=80=AFPM Jann Horn <jannh@google.com> wro=
te:
> > >
> > > On Thu, Aug 8, 2024 at 11:11=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > On Thu, Aug 8, 2024 at 2:02=E2=80=AFPM Suren Baghdasaryan <surenb@g=
oogle.com> wrote:
> > > > >
> > > > > On Thu, Aug 8, 2024 at 8:19=E2=80=AFPM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Aug 7, 2024 at 11:23=E2=80=AFAM Suren Baghdasaryan <sur=
enb@google.com> wrote:
> > > > > > >
> > > > > > > Add helper functions to speculatively perform operations with=
out
> > > > > > > read-locking mmap_lock, expecting that mmap_lock will not be
> > > > > > > write-locked and mm is not modified from under us.
> > > > > > >
> > > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > > > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > > > ---
> > > > > >
> > > > > > This change makes sense and makes mm's seq a bit more useful an=
d
> > > > > > meaningful. I've also tested it locally with uprobe stress-test=
, and
> > > > > > it seems to work great, I haven't run into any problems with a
> > > > > > multi-hour stress test run so far. Thanks!
> > > > >
> > > > > Thanks for testing and feel free to include this patch into your =
set.
> > > >
> > > > Will do!
> > > >
> > > > >
> > > > > I've been thinking about this some more and there is a very unlik=
ely
> > > > > corner case if between mmap_lock_speculation_start() and
> > > > > mmap_lock_speculation_end() mmap_lock is write-locked/unlocked so=
 many
> > > > > times that mm->mm_lock_seq (int) overflows and just happen to rea=
ch
> > > > > the same value as we recorded in mmap_lock_speculation_start(). T=
his
> > > > > would generate a false positive, which would show up as if the
> > > > > mmap_lock was never touched. Such overflows are possible for vm_l=
ock
> > > > > as well (see: https://elixir.bootlin.com/linux/v6.10.3/source/inc=
lude/linux/mm_types.h#L688)
> > > > > but they are not critical because a false result would simply lea=
d to
> > > > > a retry under mmap_lock. However for your case this would be a
> > > > > critical issue. This is an extremely low probability scenario but
> > > > > should we still try to handle it?
> > > > >
> > > >
> > > > No, I think it's fine.
> > >
> > > Modern computers don't take *that* long to count to 2^32, even when
> > > every step involves one or more syscalls. I've seen bugs where, for
> > > example, a 32-bit refcount is not decremented where it should, making
> > > it possible to overflow the refcount with 2^32 operations of some
> > > kind, and those have taken something like 3 hours to trigger in one
> > > case (https://bugs.chromium.org/p/project-zero/issues/detail?id=3D247=
8),
> > > 14 hours in another case. Or even cases where, if you have enough RAM=
,
> > > you can create 2^32 legitimate references to an object and overflow a
> > > refcount that way
> > > (https://bugs.chromium.org/p/project-zero/issues/detail?id=3D809 if y=
ou
> > > had more than 32 GiB of RAM, taking only 25 minutes to overflow the
> > > 32-bit counter - and that is with every step allocating memory).
> > > So I'd expect 2^32 simple operations that take the mmap lock for
> > > writing to be faster than 25 minutes on a modern desktop machine.
> > >
> > > So for a reader of some kinda 32-bit sequence count, if it is
> > > conceivably possible for the reader to take at least maybe a couple
> > > minutes or so between the sequence count reads (also counting time
> > > during which the reader is preempted or something like that), there
> > > could be a problem. At that point in the analysis, if you wanted to
> > > know whether it's actually exploitable, I guess you'd have to look at
> > > what kinda context you're running in, and what kinda events can
> > > interrupt/preempt you (like whether someone can send a sufficiently
> > > dense flood of IPIs to completely prevent you making forward progress=
,
> > > like in https://www.vusec.net/projects/ghostrace/), and for how long
> > > those things can delay you (maybe including what the pessimal
> > > scheduler behavior looks like if you're in preemptible context, or ho=
w
> > > long clock interrupts can take to execute when processing a giant pil=
e
> > > of epoll watches), and so on...
> > >
> >
> > And here we are talking about *lockless* *speculative* VMA usage that
> > will last what, at most on the order of a few microseconds?
>
> Are you talking about time spent in task context, or time spent while
> the task is on the CPU (including time in interrupt context), or about
> wall clock time?

We are doing, roughly:

mmap_lock_speculation_start();
rcu_read_lock();
vma_lookup();
rb_find();
rcu_read_unlock();
mmap_lock_speculation_end();


On non-RT kernel this can be prolonged only by having an NMI somewhere
in the middle. On RT it can get preempted even within RCU locked
region, if I understand correctly. If you manage to make this part run
sufficiently long to overflow 31-bit counter, it's probably a bigger
problem than mmap's sequence wrapping over, no?

>
> https://www.vusec.net/projects/ghostrace/ is pretty amazing - when you
> look at the paper
> https://download.vusec.net/papers/ghostrace_sec24.pdf you can see in
> Figure 4 how they managed to turn a race window that's 8 instructions
> wide into a window they can stretch "indefinitely", and they didn't
> even have to reschedule to pull it off. If I understand correctly,
> they stretched the race window to something like 35 seconds and could
> have stretched it even wider if they had wanted to?
>
> (And yes, Linux fixed the specific trick they used for doing that, but
> it still shows that this kinda thing is possible in principle.)

