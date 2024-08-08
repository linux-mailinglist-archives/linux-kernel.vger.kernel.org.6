Return-Path: <linux-kernel+bounces-280171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3091D94C6B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 00:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CB91C219E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B18A15B99F;
	Thu,  8 Aug 2024 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIDbEP5b"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD97B156C78
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723154720; cv=none; b=WsWSylYaFIYyQbBc5yxXxo3seOjjdK85pm51xvXNflKsrQjxDSr9PNKKrKIlX0MPHmNWt9qH64zTc0Px0YZEvhOfN3FkoYKl84EMkWg0DyAGpZydbbXNM7Tmpxe6PkeLNz2wwwiuB2AWUgCSV9FnKrXUx09eUWItC82HnYJ7mpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723154720; c=relaxed/simple;
	bh=VS9RhnQcAx8bVfljIwN5nss8vnHxFq29bU8o2dOxP0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7VIA4TExSe0ctXSPAD+xAiM/h88VEf7H0FzzPE75Gtu+DI9tShmDYP7PNtikHJWEedw0pBLj70AC2/4Konlz1I7yUoR8NuVvwsWqxI9ADwvZVlFnAg0MEb1uJKa2Zgoo+OHW6Y1JhNUTNtrHe0VmpmDDmcAaX8eVhc89SCsV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIDbEP5b; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cd5d6b2581so1189797a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723154718; x=1723759518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VS9RhnQcAx8bVfljIwN5nss8vnHxFq29bU8o2dOxP0Y=;
        b=FIDbEP5bPUuma6LKTG3g2R7NDfV/hVwl1JUqGao3eK6w/Z8KIr5dBkpO3/Be3dtjWF
         trbVmdi+gI9RqeDxE9GZHRQqgewBY/JTCtyJ9SunS2mXqn78HCvCV5lEFpvdLt/3eYzv
         YVJi+E9fBJ5O7JgfCcq75S7IWdjn0KVGvKYOToDyH6Cn57e+mTT9gEGN8OHVHPXviBSu
         t1MYpHmlbVh3oRyoXMHrI9545+/zBLhmMLhCJdYnCXPItrwfyNfJpNNXbxLZkhkjvayo
         qK7nAcSxOZpLLANcYuHfeRIDEGN7lV3HrQVL34MxLz64WViG+ctFVlmHmA5tgnF3tXgB
         NoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723154718; x=1723759518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VS9RhnQcAx8bVfljIwN5nss8vnHxFq29bU8o2dOxP0Y=;
        b=AJB+GzgVvOn5e3tTpsa6Z+Pl4HAicbtftedEtMomvMdbKw8VDKqz5Uc9xQa/c6lwX6
         Uqh7S7imsvKBf0YWBvev1m8dsevyRUzL6s/D7o9kb1bQPdpyrK1vHuTXx52VxAf0aADw
         EnKQB4BSwZPS0fu7qD/zApci36rzw5ycZI8hiPIsw8iB4nU/ddF31N55QHFi2zKeOpUq
         ECiI+I3rJrnsHnKyLd7Mktvaps2IuNfoF79olmEsS75I+JX5ca2nxAwwL3X23/X5Pn7K
         8Yy/Krf5MzQhKGC24XcFHCWY5H6EQkeR7QnbF5djUxp7fHqzzQaAiav6dxAhKPZ1CRqJ
         gRQg==
X-Forwarded-Encrypted: i=1; AJvYcCVN5UwjAcDGuwPbfo9B34a/siRai+1/DqFsL5CXVabbrQUGWvxda8OWdj74mHCDs2zyPLQU3DslKnAmnmS5EnnRKwfei1LbH56w3P9H
X-Gm-Message-State: AOJu0YyAyYLp0M58WjUCY8djClGxn3YcT996X5zBVAk7dmDp7cR2pKjp
	62xCku+s/ZCwirbBusdhAkN+tFscOexBjZwqApHRXry73ANmZu3SuMFeIP8HM89kbd11q2m19fn
	AhmAv5H1hKaO1z7FBlOrfEt+aMRwWBw==
X-Google-Smtp-Source: AGHT+IFHmLN4iW78Tt/ZhNvVTM2l59XEo9720FW+/GAAJwnuB/X4Qj5hzBa1kvCGjqN61sU+d81WsX1p9oHtMyEhvWE=
X-Received: by 2002:a17:90a:8a10:b0:2c9:7803:1cf6 with SMTP id
 98e67ed59e1d1-2d1c33fe286mr3697436a91.20.1723154717943; Thu, 08 Aug 2024
 15:05:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807182325.2585582-1-surenb@google.com> <CAEf4BzaocU-CQsFZ=s5gDM6XQ0Foss_HroFsPUesBn=qgJCprg@mail.gmail.com>
 <CAJuCfpHsvhjYxj=aovZjTd2qUvJWHpcnEn1kYfd0m23HVrPwDg@mail.gmail.com>
 <CAEf4BzYqKAaGE6GEcMs9MTcrV4cA+i0M5pniqFTy1LQ+g0Yxkw@mail.gmail.com> <CAG48ez08f0GNfkqtKa3EV6-miRs3AbXej9WdVh4TvB8ErA6S3w@mail.gmail.com>
In-Reply-To: <CAG48ez08f0GNfkqtKa3EV6-miRs3AbXej9WdVh4TvB8ErA6S3w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Aug 2024 15:05:05 -0700
Message-ID: <CAEf4BzZT+c3VHkGy2qtpsbrRVLQwE9ESTtvhJ3_xtJ9L=Hmi_g@mail.gmail.com>
Subject: Re: [RFC 1/1] mm: introduce mmap_lock_speculation_{start|end}
To: Jann Horn <jannh@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 2:43=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Aug 8, 2024 at 11:11=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Thu, Aug 8, 2024 at 2:02=E2=80=AFPM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> > >
> > > On Thu, Aug 8, 2024 at 8:19=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Aug 7, 2024 at 11:23=E2=80=AFAM Suren Baghdasaryan <surenb@=
google.com> wrote:
> > > > >
> > > > > Add helper functions to speculatively perform operations without
> > > > > read-locking mmap_lock, expecting that mmap_lock will not be
> > > > > write-locked and mm is not modified from under us.
> > > > >
> > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > ---
> > > >
> > > > This change makes sense and makes mm's seq a bit more useful and
> > > > meaningful. I've also tested it locally with uprobe stress-test, an=
d
> > > > it seems to work great, I haven't run into any problems with a
> > > > multi-hour stress test run so far. Thanks!
> > >
> > > Thanks for testing and feel free to include this patch into your set.
> >
> > Will do!
> >
> > >
> > > I've been thinking about this some more and there is a very unlikely
> > > corner case if between mmap_lock_speculation_start() and
> > > mmap_lock_speculation_end() mmap_lock is write-locked/unlocked so man=
y
> > > times that mm->mm_lock_seq (int) overflows and just happen to reach
> > > the same value as we recorded in mmap_lock_speculation_start(). This
> > > would generate a false positive, which would show up as if the
> > > mmap_lock was never touched. Such overflows are possible for vm_lock
> > > as well (see: https://elixir.bootlin.com/linux/v6.10.3/source/include=
/linux/mm_types.h#L688)
> > > but they are not critical because a false result would simply lead to
> > > a retry under mmap_lock. However for your case this would be a
> > > critical issue. This is an extremely low probability scenario but
> > > should we still try to handle it?
> > >
> >
> > No, I think it's fine.
>
> Modern computers don't take *that* long to count to 2^32, even when
> every step involves one or more syscalls. I've seen bugs where, for
> example, a 32-bit refcount is not decremented where it should, making
> it possible to overflow the refcount with 2^32 operations of some
> kind, and those have taken something like 3 hours to trigger in one
> case (https://bugs.chromium.org/p/project-zero/issues/detail?id=3D2478),
> 14 hours in another case. Or even cases where, if you have enough RAM,
> you can create 2^32 legitimate references to an object and overflow a
> refcount that way
> (https://bugs.chromium.org/p/project-zero/issues/detail?id=3D809 if you
> had more than 32 GiB of RAM, taking only 25 minutes to overflow the
> 32-bit counter - and that is with every step allocating memory).
> So I'd expect 2^32 simple operations that take the mmap lock for
> writing to be faster than 25 minutes on a modern desktop machine.
>
> So for a reader of some kinda 32-bit sequence count, if it is
> conceivably possible for the reader to take at least maybe a couple
> minutes or so between the sequence count reads (also counting time
> during which the reader is preempted or something like that), there
> could be a problem. At that point in the analysis, if you wanted to
> know whether it's actually exploitable, I guess you'd have to look at
> what kinda context you're running in, and what kinda events can
> interrupt/preempt you (like whether someone can send a sufficiently
> dense flood of IPIs to completely prevent you making forward progress,
> like in https://www.vusec.net/projects/ghostrace/), and for how long
> those things can delay you (maybe including what the pessimal
> scheduler behavior looks like if you're in preemptible context, or how
> long clock interrupts can take to execute when processing a giant pile
> of epoll watches), and so on...
>

And here we are talking about *lockless* *speculative* VMA usage that
will last what, at most on the order of a few microseconds? So I stand
by "can never happen", because if it does, your system is so
overloaded that something like this uprobe issue is your least
concern.

> > Similar problems could happen with refcount_t,
> > for instance (it has a logic to have a sticky "has overflown" state,
> > which I believe relies on the fact that we'll never be able to
> > increment refcount 2bln+ times in between some resetting logic).
> > Anyways, I think it's utterly unrealistic and should be considered
> > impossible.
>
> IIRC refcount_t protects against this even in theoretical, fairly
> pessimal scenarios, because the maximum number of tasks you can have
> on Linux is smaller than the number of refcount decrements you'd have
> to do in parallel to bring a pinned refcount back down to 0.
>
> I know this is a weakness of seqcount_t (though last time I checked I
> couldn't find any examples where it seemed like you could actually
> abuse this).
>
> But if you want a counter, and something bad would happen if the
> counter wraps, and you don't have a really strong guarantee that the
> counter won't wrap, I think it's more robust to make it 64-bit. (Or an
> unsigned long and hope there aren't too many people who still run
> 32-bit kernels on anything important... though that's not very
> pretty.)

