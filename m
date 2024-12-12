Return-Path: <linux-kernel+bounces-442458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF559EDD1A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 02:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F587283209
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726C0558BC;
	Thu, 12 Dec 2024 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Oz3QWW5"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1CDC2E0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733967269; cv=none; b=EpTq8UXmAGdFEIga+sdarbg7h1cbrK9CSbUIBfxw8PGB+H3ClzlpokJSts+gUk5vwvYfd+1DA0/IX+K5ZdeoqpZvcT7Ai7JO5npX/TCChPGMlm6ZZlDPUzSzleff/naZHVupCgSd5IOeCCtDlpTJTYrX9z3CJ3/6EthUCGTGnMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733967269; c=relaxed/simple;
	bh=OMKBR+ci1c7k1v5DnvnICnYO66Tlnm0duZoKFcrCoy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoKhFy/X1Bi+WnnQns4/Yl/gyKyMpqJS3kppvq51U52TJPTvgJQKSsAzKm+slQr2qLGE9sP3jpecW9G7m8DrYvFqE1wMJMZuowDv+2RnVNwmWCPZKJyYEQtmZTskmNW+WFkqHGuc+OuqJZQzxDVIhgojGsIl1qMoYLvBgwn44kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Oz3QWW5; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a814c54742so37605ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733967266; x=1734572066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoSeGE7KRT0J5hZUjyFKX6WyMjOqBpUk3jQgJgPHXEg=;
        b=1Oz3QWW57BlUiI9iQIiSSqTM/C7RM/NCVdiDFWBLcOGLK3i4rj1TPZm+KtDSvbV2J5
         kasE7zdlfS2ZCE/wT8/f0lLV2UgBZvv5YJU1jzYi6DPCN12I9dzLUNPXZZk+dneL1vxZ
         dZiXfzMATTuerMudOUhX10WK0Z85FKn+G811ts232EDFHkc6LErZ+vj2bqCddWW2cVmF
         GXNsC7i+0QShDzdsAuEmkFG5KJn+zBqrVFf0vf8MxXCD956JyvmFnc561J9s8pmpxNdJ
         a2Tt5+dEF5ZR56Fa+//k48FjOXhAblyCD6TLlOBR1anW2gAw+GSYnbNSn3Ls7a7NQquS
         Xmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733967266; x=1734572066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoSeGE7KRT0J5hZUjyFKX6WyMjOqBpUk3jQgJgPHXEg=;
        b=ej5vM1PRvBMlb/u+4pR/Pu1awQsA3FThSssNXENOkShZYowu0ewMNNSCFyFhtlXAir
         k4W1yjV1NzbcfhPsbL9HlpHvwM1IZeRqbK2eqvs+7XV5/FjJK/edqrC4F0SdjIMNlOXQ
         LWbGj3e4ANvBaoNdj5OdpRwNI3TaVD3Y4lx7y9sX10OekF4MKdY1lGvuA0Bgnu6WPc1C
         ONw853bs+fGkiSa5vcYGve70WRU63ujfO4De3gpN6Y4Bar/hmCcCMo6Ij75Rt6LFkCsd
         U5jVXgKtR9LX6RRCP31DS5vy4r+IzDzNh0DXm6rYmSonOY99Fj7vozFJG2WCW3X5XE+D
         m3IA==
X-Forwarded-Encrypted: i=1; AJvYcCWKKB1u1YNFiYyDmvix3j6OPyIYVPzDR6QP+6z5brQssCQWBVmTFDyhYbCaEUpRHP6cfNgVvHeex1GB9pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCIsCXqqTYd8TmddnJNIZ6m2qKe0BpT5PQaKkrz0BNFzJuVpcA
	tQUge7119sJ+9pooZRAzCO6SyFWh2otAyC6YT4q/s/4JSkrUpwhKDGTbgyCJLL99yS8tr601u1w
	uW3Sx0Cy3PU3AwMo0Moj10KXTxJqwkOqeSFnP
X-Gm-Gg: ASbGncu6CBE5haT6R+87+CUrykJvBGD3gjQeUCFC5gEob4xeK3e82UTwFcMt907IP+t
	WpfcFGvP5yJ8aDtHUAQTyeKDgKEJFzdT4Ig9pbV0=
X-Google-Smtp-Source: AGHT+IFcrIO8GEmPDpFRPD6n3RHIMPeTVCZptIg1afWB7cXTxt/55viwG7unrcjtahU828hRhibNtv1s3HHCMR9DR2c=
X-Received: by 2002:a05:6e02:3b44:b0:3a7:d8f7:7c2c with SMTP id
 e9e14a558f8ab-3ac8874eb67mr1442905ab.12.1733967266312; Wed, 11 Dec 2024
 17:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211222110.2430610-1-namhyung@kernel.org> <Z1oXs1xjCG1Ee27p@x1>
In-Reply-To: <Z1oXs1xjCG1Ee27p@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Dec 2024 17:34:15 -0800
Message-ID: <CAP-5=fXYke_n7TDe+mB-webNH7vCvea7ZVPqfqygw7bTNd8G3g@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf trace: Add --syscall-period option
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 2:52=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Dec 11, 2024 at 02:21:10PM -0800, Namhyung Kim wrote:
> > This option is to implement the event sampling for system calls.
> > The period is given in msec as it shows the time in msec.
> >
> >   # perf trace -C 0 --syscall-period 100 sleep 1
> >            ? (         ): fleetspeakd/1828559  ... [continued]: futex()=
)                                            =3D -1 ETIMEDOUT (Connection t=
imed out)
> >        0.050 (100.247 ms): gnome-shell/572531 recvmsg(fd: 10<socket:[33=
55761]>, msg: 0x7ffef8b39d20)                =3D 40
> >      100.357 (100.149 ms): pipewire-pulse/572245 read(fd: 5<anon_inode:=
[eventfd]>, buf: 0x7ffc0b9dc8f0, count: 8)      =3D 8
> >      200.553 (100.268 ms): NetworkManager/3424 epoll_wait(epfd: 19<anon=
_inode:[eventpoll]>, events: 0x5607b85bb880, maxevents: 6) =3D 0
> >      300.876 (         ): mon/4932 poll(ufds: 0x7fa392784df0, nfds: 1, =
timeout_msecs: 100)            ...
> >      400.901 ( 0.025 ms): TaskCon~ller #/620145 futex(uaddr: 0x7f3fc596=
fa00, op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
> >      300.876 (100.123 ms): mon/4932  ... [continued]: poll())          =
                                   =3D 0 (Timeout)
> >      500.901 ( 0.012 ms): evdefer/2/2335122 futex(uaddr: 0x5640baac5198=
, op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
> >      602.701 ( 0.017 ms): Compositor/1992200 futex(uaddr: 0x7f1a51dfdd4=
0, op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
> >      705.589 ( 0.017 ms): JS Watchdog/947933 futex(uaddr: 0x7f4cac1d424=
0, op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
> >      812.667 ( 0.027 ms): fix/1985151 futex(uaddr: 0xc0008f7148, op: WA=
KE|PRIVATE_FLAG, val: 1)             =3D 1
> >      912.807 ( 0.017 ms): Xorg/572315 setitimer(value: 0x7ffc375d6ba0) =
                                     =3D 0
> >
> > The timestamp is kept in a per-cpu array and the allowed task is saved
> > in a hash map.
>
> Interesting concept, and one that is done just on the BPF part, so I
> think we should at least warn a user that is running this on a build
> without BPF skels.
>
> Will try it tomorrow,
>
> - Arnaldo
>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-trace.txt       |  6 ++
> >  tools/perf/builtin-trace.c                    |  5 ++
> >  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 67 ++++++++++++++++++-
> >  3 files changed, 76 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Docum=
entation/perf-trace.txt
> > index 6e0cc50bbc13fc7f..9f338a8c5357a67e 100644
> > --- a/tools/perf/Documentation/perf-trace.txt
> > +++ b/tools/perf/Documentation/perf-trace.txt
> > @@ -241,6 +241,12 @@ the thread executes on the designated CPUs. Defaul=
t is to monitor all CPUs.
> >       printing using the existing 'perf trace' syscall arg beautifiers =
to map integer
> >       arguments to strings (pid to comm, syscall id to syscall name, et=
c).
> >
> > +--syscall-period::
> > +     Trace a system call in the given period (in msec).  This implemen=
ts
> > +     sampling for syscalls in order to reduce the monitoring overhead.
> > +     For example, setting the sysall period to 100 (msec) means it wil=
l
> > +     sample a syscall and next one after 100 msec.

Is this similar to the -D/--delay option to perf-record? Perhaps share the =
name?

> > +
> >
> >  PAGEFAULTS
> >  ----------
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 3c46de1a8d79bfe6..789eb0ffd5f90b61 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -185,6 +185,7 @@ struct trace {
> >       } stats;
> >       unsigned int            max_stack;
> >       unsigned int            min_stack;
> > +     unsigned long           sample_period_ms;
> >       int                     raw_augmented_syscalls_args_size;
> >       bool                    raw_augmented_syscalls;
> >       bool                    fd_path_disabled;
> > @@ -5219,6 +5220,7 @@ int cmd_trace(int argc, const char **argv)
> >                    "start"),
> >       OPT_BOOLEAN(0, "force-btf", &trace.force_btf, "Prefer btf_dump ge=
neral pretty printer"
> >                      "to customized ones"),
> > +     OPT_ULONG(0, "syscall-period", &trace.sample_period_ms, "syscall =
sampling period in ms"),
> >       OPTS_EVSWITCH(&trace.evswitch),
> >       OPT_END()
> >       };
> > @@ -5326,6 +5328,9 @@ int cmd_trace(int argc, const char **argv)
> >                               bpf_program__set_autoattach(prog, /*autoa=
ttach=3D*/false);
> >               }
> >
> > +             if (trace.sample_period_ms)
> > +                     trace.skel->rodata->sample_period =3D trace.sampl=
e_period_ms * NSEC_PER_MSEC;
> > +
> >               err =3D augmented_raw_syscalls_bpf__load(trace.skel);
> >
> >               if (err < 0) {
> > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/to=
ols/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > index 4a62ed593e84edf8..12272620dcd73700 100644
> > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > @@ -113,6 +113,22 @@ struct pids_filtered {
> >       __uint(max_entries, 64);
> >  } pids_filtered SEC(".maps");
> >
> > +struct sample_timestamp {
> > +     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> > +     __type(key, int);
> > +     __type(value, __u64);
> > +     __uint(max_entries, 1);
> > +} sample_timestamp SEC(".maps");
> > +
> > +struct sample_filtered {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __type(key, pid_t);
> > +     __type(value, bool);
> > +     __uint(max_entries, MAX_CPUS);
> > +} sample_filtered SEC(".maps");
> > +
> > +const volatile __u64 sample_period;

nit: sample_period -> sample_period_ns

Thanks,
Ian

> > +
> >  struct augmented_args_payload {
> >       struct syscall_enter_args args;
> >       struct augmented_arg arg, arg2; // We have to reserve space for t=
wo arguments (rename, etc)
> > @@ -428,6 +444,44 @@ static bool pid_filter__has(struct pids_filtered *=
pids, pid_t pid)
> >       return bpf_map_lookup_elem(pids, &pid) !=3D NULL;
> >  }
> >
> > +static bool sample_filter__allow_enter(__u64 timestamp, pid_t pid)
> > +{
> > +     int idx =3D 0;
> > +     __u64 *prev_ts;
> > +     bool ok =3D true;
> > +
> > +     /* default behavior */
> > +     if (sample_period =3D=3D 0)
> > +             return true;
> > +
> > +     prev_ts =3D bpf_map_lookup_elem(&sample_timestamp, &idx);
> > +
> > +     if (prev_ts) {
> > +             if ((*prev_ts + sample_period) > timestamp)
> > +                     return false;
> > +             *prev_ts =3D timestamp;
> > +     } else {
> > +             bpf_map_update_elem(&sample_timestamp, &idx, &timestamp, =
BPF_ANY);
> > +     }
> > +
> > +     bpf_map_update_elem(&sample_filtered, &pid, &ok, BPF_ANY);
> > +
> > +     return true;
> > +}
> > +
> > +static bool sample_filter__allow_exit(pid_t pid)
> > +{
> > +     /* default behavior */
> > +     if (sample_period =3D=3D 0)
> > +             return true;
> > +
> > +     if (!bpf_map_lookup_elem(&sample_filtered, &pid))
> > +             return false;
> > +
> > +     bpf_map_delete_elem(&sample_filtered, &pid);
> > +     return true;
> > +}
> > +
> >  static int augment_sys_enter(void *ctx, struct syscall_enter_args *arg=
s)
> >  {
> >       bool augmented, do_output =3D false;
> > @@ -526,7 +580,9 @@ static int augment_sys_enter(void *ctx, struct sysc=
all_enter_args *args)
> >  SEC("tp/raw_syscalls/sys_enter")
> >  int sys_enter(struct syscall_enter_args *args)
> >  {
> > +     pid_t pid =3D getpid();
> >       struct augmented_args_payload *augmented_args;
> > +
> >       /*
> >        * We start len, the amount of data that will be in the perf ring
> >        * buffer, if this is not filtered out by one of pid_filter__has(=
),
> > @@ -537,7 +593,10 @@ int sys_enter(struct syscall_enter_args *args)
> >        * initial, non-augmented raw_syscalls:sys_enter payload.
> >        */
> >
> > -     if (pid_filter__has(&pids_filtered, getpid()))
> > +     if (pid_filter__has(&pids_filtered, pid))
> > +             return 0;
> > +
> > +     if (!sample_filter__allow_enter(bpf_ktime_get_ns(), pid))
> >               return 0;
> >
> >       augmented_args =3D augmented_args_payload();
> > @@ -561,9 +620,13 @@ int sys_enter(struct syscall_enter_args *args)
> >  SEC("tp/raw_syscalls/sys_exit")
> >  int sys_exit(struct syscall_exit_args *args)
> >  {
> > +     pid_t pid =3D getpid();
> >       struct syscall_exit_args exit_args;
> >
> > -     if (pid_filter__has(&pids_filtered, getpid()))
> > +     if (pid_filter__has(&pids_filtered, pid))
> > +             return 0;
> > +
> > +     if (!sample_filter__allow_exit(pid))
> >               return 0;
> >
> >       bpf_probe_read_kernel(&exit_args, sizeof(exit_args), args);
> > --
> > 2.47.0.338.g60cca15819-goog

