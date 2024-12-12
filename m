Return-Path: <linux-kernel+bounces-442573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0439C9EDE75
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 05:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82ECC281292
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 04:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCE21662E7;
	Thu, 12 Dec 2024 04:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3gggZ5a"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089DA7DA88
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 04:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977727; cv=none; b=I7dwYLKCl3ul55I396GPxKAvCGioy0c/CrQ0JjjAe/i+rx1nA1FS5MHyM9Q7av88NDakBGJbIwsiFRJHJ59DGXUA7d1hV6DijyX3g4KzECkV0kWcRDnZGRMFRogfyjeMPOvzW+Zz42f/zPoH4cNhVcsvzp6VYcTraOclZn4EzNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977727; c=relaxed/simple;
	bh=1uVfkMcFBnS4E2OrJo/j5skqXbc4Wz8hSI9RNce+xvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tw4J9KxbgAjLZBZoWRT0fPuSo8YbPa1UCOe8UQRZpYCzsSAlw/o8GrAyY7XZ9QRq/xFAwpilmOEPjY7sb5bLSz8E/f5CvS3PMk39lFdtxwoMsZQnACTaGRK69JR30U7ZWQ7epv0Im5Wedrdp6ePLlJfSuV7zFiisOE5QTaaJTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s3gggZ5a; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a814c54742so60575ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733977725; x=1734582525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUlp4kACTZsdNiDphyB4eQ3PRMckdr5Zz5AQugujOIc=;
        b=s3gggZ5aV+poV8CzNmHh8JE/a2x+iY35Ky+yap14vdH3iDjwxNGb5oCCp+nyOgzToQ
         2V7mjiZKwQwbtRRqJD7j3g77qs1wo+//vh7lpZhx2u8rG4oH9jypG0ZcNlh6mfc0jv/j
         HOvg9JnzYWZUEXIOTxzNBrNCRG8ssnXB/y1nMrtSLHvhiEJuNdt85Y3ASxs05pZZaiX0
         sLPFtQ1i8SMvziugMQ9QcRQKfdItdpeTJWp0oPhUhFg/KcbgAAho9DnZl+DS4UG4xqBD
         UH0sd/Fi0uo8SEJ6lQHXVZyC01XOzvRPFMDOVtD66+guy2Dcc2pZFudc5SJjl2pJnEUR
         pXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733977725; x=1734582525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUlp4kACTZsdNiDphyB4eQ3PRMckdr5Zz5AQugujOIc=;
        b=Nd7uz8u2EyiaoV8b+6J2mgrxS+iENlKdjxXxgd1+QBttsMGBWoAmasQpZzqa2Bn02/
         M+AZzSk886FGICCZzJk0ZWwpQeKhJxecFrIEIyK9rg9qpJoOTSFa22c4zAFFPD80L84T
         KThpvA5JkkzSvNXJ4THv/9NgYIb1M4HOKEaRvUtT3HlA08wx6cHue/LnYyiDkP7LZJeE
         rl3QeLtsnZVCWkYV0KEfXq4ayOSK7rQORiSPlrQ7a6uWLZNzeoeSTpKAJYodoTqP20Bs
         CkTIy+MV8rxaejv9x5b4yFMlKIkrxPybpphOXENlTMAjx1lWiitG4GubLHwuLF2ETqVe
         JUcA==
X-Forwarded-Encrypted: i=1; AJvYcCXqLLYCJgoiOGcIVSiKEzeIdT/HyXvYwV86qDlUL5EAGv2wZB5Qph5aihUMGjnuc5LIBpx8jvMvZ4vd6yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAjO4RCkw564kUdzFhOmo0oIqS7IPlbIEhUUlOWDUBro/FuWzb
	pvvANen/VOH8NiVDSyAwvXQlnYxtVubxpQswUo1ucf48QtuV+L6Wd4FQn+IrCbhd9tlDe5q1jh0
	n0iYHbsv4ClM5zPe0eJ9xjVxZziPu3lfTPdt0
X-Gm-Gg: ASbGnctkDDeMrc+WAz94IvNR/4Lc6AqcbQLeWuBekzbQt5xJyI9YIbUy92a//5+75gn
	sKIIUSYB3LtduaTjhYI1QQPQPzYEw/iHMZ1ciXoE=
X-Google-Smtp-Source: AGHT+IHTxvBJXom6N4YvIoI7gy9RDQIryr8CtAB+7FlS82yH3xhzVBz48qVzYXnXwf8/PlrkdNWEt24OBFPDwl/Uq+E=
X-Received: by 2002:a05:6e02:8e:b0:3a7:cd21:493f with SMTP id
 e9e14a558f8ab-3ac8d4711bbmr1830075ab.26.1733977725110; Wed, 11 Dec 2024
 20:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211222110.2430610-1-namhyung@kernel.org> <Z1oXs1xjCG1Ee27p@x1>
 <CAP-5=fXYke_n7TDe+mB-webNH7vCvea7ZVPqfqygw7bTNd8G3g@mail.gmail.com> <CAH0uvogs8EAzLemVQXq238KGFXJhD2TBhpXHQUnRYaQtcn_HPQ@mail.gmail.com>
In-Reply-To: <CAH0uvogs8EAzLemVQXq238KGFXJhD2TBhpXHQUnRYaQtcn_HPQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Dec 2024 20:28:33 -0800
Message-ID: <CAP-5=fXTSZtcrc3hgYHQAHyZVsJ6eLQ_RMzQgVrKFhjvdcwSqw@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf trace: Add --syscall-period option
To: Howard Chu <howardchu95@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 5:47=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hello Ian,
>
> On Wed, Dec 11, 2024 at 5:34=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Wed, Dec 11, 2024 at 2:52=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Wed, Dec 11, 2024 at 02:21:10PM -0800, Namhyung Kim wrote:
> > > > This option is to implement the event sampling for system calls.
> > > > The period is given in msec as it shows the time in msec.
> > > >
> > > >   # perf trace -C 0 --syscall-period 100 sleep 1
> > > >            ? (         ): fleetspeakd/1828559  ... [continued]: fut=
ex())                                            =3D -1 ETIMEDOUT (Connecti=
on timed out)
> > > >        0.050 (100.247 ms): gnome-shell/572531 recvmsg(fd: 10<socket=
:[3355761]>, msg: 0x7ffef8b39d20)                =3D 40
> > > >      100.357 (100.149 ms): pipewire-pulse/572245 read(fd: 5<anon_in=
ode:[eventfd]>, buf: 0x7ffc0b9dc8f0, count: 8)      =3D 8
> > > >      200.553 (100.268 ms): NetworkManager/3424 epoll_wait(epfd: 19<=
anon_inode:[eventpoll]>, events: 0x5607b85bb880, maxevents: 6) =3D 0
> > > >      300.876 (         ): mon/4932 poll(ufds: 0x7fa392784df0, nfds:=
 1, timeout_msecs: 100)            ...
> > > >      400.901 ( 0.025 ms): TaskCon~ller #/620145 futex(uaddr: 0x7f3f=
c596fa00, op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
> > > >      300.876 (100.123 ms): mon/4932  ... [continued]: poll())      =
                                       =3D 0 (Timeout)
> > > >      500.901 ( 0.012 ms): evdefer/2/2335122 futex(uaddr: 0x5640baac=
5198, op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
> > > >      602.701 ( 0.017 ms): Compositor/1992200 futex(uaddr: 0x7f1a51d=
fdd40, op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
> > > >      705.589 ( 0.017 ms): JS Watchdog/947933 futex(uaddr: 0x7f4cac1=
d4240, op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
> > > >      812.667 ( 0.027 ms): fix/1985151 futex(uaddr: 0xc0008f7148, op=
: WAKE|PRIVATE_FLAG, val: 1)             =3D 1
> > > >      912.807 ( 0.017 ms): Xorg/572315 setitimer(value: 0x7ffc375d6b=
a0)                                      =3D 0
> > > >
> > > > The timestamp is kept in a per-cpu array and the allowed task is sa=
ved
> > > > in a hash map.
> > >
> > > Interesting concept, and one that is done just on the BPF part, so I
> > > think we should at least warn a user that is running this on a build
> > > without BPF skels.
> > >
> > > Will try it tomorrow,
> > >
> > > - Arnaldo
> > >
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/Documentation/perf-trace.txt       |  6 ++
> > > >  tools/perf/builtin-trace.c                    |  5 ++
> > > >  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 67 +++++++++++++++=
+++-
> > > >  3 files changed, 76 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/D=
ocumentation/perf-trace.txt
> > > > index 6e0cc50bbc13fc7f..9f338a8c5357a67e 100644
> > > > --- a/tools/perf/Documentation/perf-trace.txt
> > > > +++ b/tools/perf/Documentation/perf-trace.txt
> > > > @@ -241,6 +241,12 @@ the thread executes on the designated CPUs. De=
fault is to monitor all CPUs.
> > > >       printing using the existing 'perf trace' syscall arg beautifi=
ers to map integer
> > > >       arguments to strings (pid to comm, syscall id to syscall name=
, etc).
> > > >
> > > > +--syscall-period::
> > > > +     Trace a system call in the given period (in msec).  This impl=
ements
> > > > +     sampling for syscalls in order to reduce the monitoring overh=
ead.
> > > > +     For example, setting the sysall period to 100 (msec) means it=
 will
> > > > +     sample a syscall and next one after 100 msec.
> >
> > Is this similar to the -D/--delay option to perf-record? Perhaps share =
the name?
>
> I think this is more like a throttling for the perf trace output,
> instead of a one-time delay or a range of enabled time like -D, as the
> prev_ts here is continuously updated. This restricts the maximum
> sampling frequency to 1 / syscall-period, meaning every syscall is
> sampled just after the syscall-period has passed.

Thanks Howard, so it is some kind of "throttle" or "max-per" value.
I'd suggest rephrasing the text.

Thanks,
Ian

