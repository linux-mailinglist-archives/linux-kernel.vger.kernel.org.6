Return-Path: <linux-kernel+bounces-280190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF25894C6E9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 00:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C25D1F215A8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6251615B149;
	Thu,  8 Aug 2024 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HMAiPnaT"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FB41F19A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 22:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723155412; cv=none; b=panlYLma8lFMNro8Gxs8OdU3NpvNrJwjhQD+pKeDaFRpCsDTdyacJS1Xi4EQtIYMzFBgW49e8uL1KseRuL9hE89MYlAPHPIhtaeg/I8YaNjR/pUvENWcfuOxNc7Giyc60NLpR4jVvmCg23AKPjioUzIK5Sr25AJqtNsDwzVoqkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723155412; c=relaxed/simple;
	bh=vD633yduOKBgasPPct2yhHXxR5UbK3+yFP/Pe6LEU00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1dO2pnkcYZVB4T8K8OvbSV5VmANds/bn1HYuLnwJYlB1c9nMriHJ26JuqqZ+NURA5217CCkqJDCg6hJuCk3QOoFtDWtcOFw55+Pm5urZ6sHxv7HPMS9zSd2e5axVGAzAvCCoED5jFVRX8dIL+5LiUlWT+OuMoovQG2J3YebD8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HMAiPnaT; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso4290a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 15:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723155409; x=1723760209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vD633yduOKBgasPPct2yhHXxR5UbK3+yFP/Pe6LEU00=;
        b=HMAiPnaT3pgH80GfY1K1Sw1l8zXeg7uqj/ElPwdzuKwbiDeWeHgkPYk8Yzg2SGKzda
         AZBbQO7e145mbiKTMLw2bP7XWhaiJIbAwq6Hkxq39DQUQ+c9ezD2SKIUb80+EovrGDx2
         Ns3HgKPO0hI+X/fbXcn9cXTUjAjJLu0quPQIQ/Wrue1904iz4trMM3l8MhQBZGd50b0a
         9zAOH5OQ12VLgVz+L2cldXwwWcgpgroJltFsO/WLWt+tcdNXKLKDmve7ozP/teAMJ6QC
         pCje4RdRnAdbHSDjvE7XcjN0ENTZxKuQNDos2gUsMOKs2JMESeN+3xoWzm5NszCgLfPF
         KFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723155409; x=1723760209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vD633yduOKBgasPPct2yhHXxR5UbK3+yFP/Pe6LEU00=;
        b=u3uHuuP7JgbQr709DivhwqxKwSYIkBoHQnZ/BbKxN8inWYzw1guzV5BFV9Ac4mREIX
         aw8bGL0BoS2aPc0VSgilJPwtsj+0Erf23lTa8Akhf/M2uAT4ZfMeqpc7ob0qBrRIyxsL
         hbavIU0ndqn/+VmpTG70BUHzeU9lwfTAC3VliknpLyH6Xx3ak73/Wum4lzNYTnELxDzv
         67BiuW8jXhvFyQihU//X13gxYCvSQDaYo+0ZkEznseJmlvXQECyRXdtMubY+LuD3xEGW
         iJxIzjZzTb04JeA67f4h5jYXYVmKr/pjSxCeWyo0udouBYmyBvNTlep/LeFRACnc4MZt
         wb3A==
X-Forwarded-Encrypted: i=1; AJvYcCVc2boEOC5fQCr9K41iYj25DXapVtwSmBfX57o504e8151nPd9vfj1cf3TLJChGLVM/iM/E5hUIh3MUIkzXx6vM25yqAhIzxab5KBro
X-Gm-Message-State: AOJu0Yzv4CuIskST3bkzWf7D2M5/aCfqB7yQyiVyjQLze19Q9z72cR8d
	gv+Auc6DPoacVO3YEKa41dzTTXKexxTPD5wvoTpTzHtPmhXEcn6gT47Mo9+49Wmc8moV4gqh6AF
	eRj3YOmsMgPoEGi4olzoQtzV1pXZ0tBMXoQ0A
X-Google-Smtp-Source: AGHT+IEOZWtXx34JWNvL+d6ELvLP8XfqXiM1qC8rozN7hYCkV3RfD9vAKGeZ/H9Uld93ZDVZfoRLupxOvgTXLK7kB8s=
X-Received: by 2002:a05:6402:35cc:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5bc4b3fc8d7mr29569a12.3.1723155408169; Thu, 08 Aug 2024
 15:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807182325.2585582-1-surenb@google.com> <CAEf4BzaocU-CQsFZ=s5gDM6XQ0Foss_HroFsPUesBn=qgJCprg@mail.gmail.com>
 <CAJuCfpHsvhjYxj=aovZjTd2qUvJWHpcnEn1kYfd0m23HVrPwDg@mail.gmail.com>
 <CAEf4BzYqKAaGE6GEcMs9MTcrV4cA+i0M5pniqFTy1LQ+g0Yxkw@mail.gmail.com>
 <CAG48ez08f0GNfkqtKa3EV6-miRs3AbXej9WdVh4TvB8ErA6S3w@mail.gmail.com> <CAEf4BzZT+c3VHkGy2qtpsbrRVLQwE9ESTtvhJ3_xtJ9L=Hmi_g@mail.gmail.com>
In-Reply-To: <CAEf4BzZT+c3VHkGy2qtpsbrRVLQwE9ESTtvhJ3_xtJ9L=Hmi_g@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 9 Aug 2024 00:16:09 +0200
Message-ID: <CAG48ez1_xx=oVB=4Q3Ywf7UPyO3aWR+N=HwGE5SEuO9+Fgiw_g@mail.gmail.com>
Subject: Re: [RFC 1/1] mm: introduce mmap_lock_speculation_{start|end}
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:05=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Thu, Aug 8, 2024 at 2:43=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
> >
> > On Thu, Aug 8, 2024 at 11:11=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Thu, Aug 8, 2024 at 2:02=E2=80=AFPM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > > >
> > > > On Thu, Aug 8, 2024 at 8:19=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Wed, Aug 7, 2024 at 11:23=E2=80=AFAM Suren Baghdasaryan <suren=
b@google.com> wrote:
> > > > > >
> > > > > > Add helper functions to speculatively perform operations withou=
t
> > > > > > read-locking mmap_lock, expecting that mmap_lock will not be
> > > > > > write-locked and mm is not modified from under us.
> > > > > >
> > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > > ---
> > > > >
> > > > > This change makes sense and makes mm's seq a bit more useful and
> > > > > meaningful. I've also tested it locally with uprobe stress-test, =
and
> > > > > it seems to work great, I haven't run into any problems with a
> > > > > multi-hour stress test run so far. Thanks!
> > > >
> > > > Thanks for testing and feel free to include this patch into your se=
t.
> > >
> > > Will do!
> > >
> > > >
> > > > I've been thinking about this some more and there is a very unlikel=
y
> > > > corner case if between mmap_lock_speculation_start() and
> > > > mmap_lock_speculation_end() mmap_lock is write-locked/unlocked so m=
any
> > > > times that mm->mm_lock_seq (int) overflows and just happen to reach
> > > > the same value as we recorded in mmap_lock_speculation_start(). Thi=
s
> > > > would generate a false positive, which would show up as if the
> > > > mmap_lock was never touched. Such overflows are possible for vm_loc=
k
> > > > as well (see: https://elixir.bootlin.com/linux/v6.10.3/source/inclu=
de/linux/mm_types.h#L688)
> > > > but they are not critical because a false result would simply lead =
to
> > > > a retry under mmap_lock. However for your case this would be a
> > > > critical issue. This is an extremely low probability scenario but
> > > > should we still try to handle it?
> > > >
> > >
> > > No, I think it's fine.
> >
> > Modern computers don't take *that* long to count to 2^32, even when
> > every step involves one or more syscalls. I've seen bugs where, for
> > example, a 32-bit refcount is not decremented where it should, making
> > it possible to overflow the refcount with 2^32 operations of some
> > kind, and those have taken something like 3 hours to trigger in one
> > case (https://bugs.chromium.org/p/project-zero/issues/detail?id=3D2478)=
,
> > 14 hours in another case. Or even cases where, if you have enough RAM,
> > you can create 2^32 legitimate references to an object and overflow a
> > refcount that way
> > (https://bugs.chromium.org/p/project-zero/issues/detail?id=3D809 if you
> > had more than 32 GiB of RAM, taking only 25 minutes to overflow the
> > 32-bit counter - and that is with every step allocating memory).
> > So I'd expect 2^32 simple operations that take the mmap lock for
> > writing to be faster than 25 minutes on a modern desktop machine.
> >
> > So for a reader of some kinda 32-bit sequence count, if it is
> > conceivably possible for the reader to take at least maybe a couple
> > minutes or so between the sequence count reads (also counting time
> > during which the reader is preempted or something like that), there
> > could be a problem. At that point in the analysis, if you wanted to
> > know whether it's actually exploitable, I guess you'd have to look at
> > what kinda context you're running in, and what kinda events can
> > interrupt/preempt you (like whether someone can send a sufficiently
> > dense flood of IPIs to completely prevent you making forward progress,
> > like in https://www.vusec.net/projects/ghostrace/), and for how long
> > those things can delay you (maybe including what the pessimal
> > scheduler behavior looks like if you're in preemptible context, or how
> > long clock interrupts can take to execute when processing a giant pile
> > of epoll watches), and so on...
> >
>
> And here we are talking about *lockless* *speculative* VMA usage that
> will last what, at most on the order of a few microseconds?

Are you talking about time spent in task context, or time spent while
the task is on the CPU (including time in interrupt context), or about
wall clock time?

https://www.vusec.net/projects/ghostrace/ is pretty amazing - when you
look at the paper
https://download.vusec.net/papers/ghostrace_sec24.pdf you can see in
Figure 4 how they managed to turn a race window that's 8 instructions
wide into a window they can stretch "indefinitely", and they didn't
even have to reschedule to pull it off. If I understand correctly,
they stretched the race window to something like 35 seconds and could
have stretched it even wider if they had wanted to?

(And yes, Linux fixed the specific trick they used for doing that, but
it still shows that this kinda thing is possible in principle.)

