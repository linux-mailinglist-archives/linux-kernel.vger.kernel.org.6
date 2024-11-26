Return-Path: <linux-kernel+bounces-422845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5E39D9EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A9D284DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA411DF996;
	Tue, 26 Nov 2024 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QaxmnhJf"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032B1DDA24
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657256; cv=none; b=u+b64+DU6vnG6caA4F109T0R1yuimNsEGmcukmMLrfaASgJ2VLGNTOl1hiMTJv5K6ToSKGgp4G4v/w3MVpEGcmSHOPa6CwGqJMJPDqAerOQaeP8rO5TuucYvQ2SrMfj+BwSIXp86C1WKWyQgQhj78NUnam5sIkwUN9bMAWBde7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657256; c=relaxed/simple;
	bh=belh2CV8APzbS9dXWHLOhUBIRwdrOI2hkzBGAxoY46E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyk8CS8oiJf3bds2FfpIcsaeUcO3QH56QXPApGvVui2nQQX1VMcRHYMsRhocpxWyuFXrKr54mcjnHH1Xhq8l2MA8EM3YoDGUaPIM1N/lecs9U9zVYty64JqvSmne8bfhXHb48fWQZU/tDBw+RF7NEzHO2nwiPXNRz6IvEhbsjck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QaxmnhJf; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3822ba3cdbcso3795311f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732657253; x=1733262053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oexzxl/eFGfdwHCHd7BSU9VYXC+atjXizjV/OPIWL38=;
        b=QaxmnhJfCRcIugOEzpT1qQCXzxwm4N/FwEb9pciy5Q3nGTUGxW/LPF5HV9FMsuH7IQ
         3vFsj6QcjA2VPH7tst2jl0HnwkypYLklkljUCAvaJjU9ChCn4RSDpHf3F9qUfdMKQAIw
         LEOm6mmYdj1tvT/DmLsXowcc8FmRRA/WpjhbD9e+xoLzM+B2bJdF/vXqmQqwNRSV5CnP
         83wq4YDxJnujYypgMfkGzL4Shz4lLwm1q6+KnLhK5aBcSMn9bm0hb3/Y3PSUSy57FR38
         pMOjsH2/m0BaMrJNiBEUb0fOmm1l9jSgXcBPmyfKBVAVlfy+pWDjJWpwx58igAbJmdxe
         opag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732657253; x=1733262053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oexzxl/eFGfdwHCHd7BSU9VYXC+atjXizjV/OPIWL38=;
        b=dVcjNiP37dBWw4MnnKNwb54zdWfTXc34La9+6J+zZCdYZysGeAaQeeVyCkCCIw+Q37
         Ov1qSku7A5+TCUdIj3o2RJoiOtZBu5qbtFsr0JBSdWrFAgq6WGsG1vrwdr9PGelY+kHa
         Uz1G300BpPF+4Z78fRwajYOOZ1NdWaYdjTwMwX3E3pzDHUgFY2A8kLUXx0Uh+ThEq6GO
         Mp0hCzylTMlF3qWpIUTzkg8ByR2hkhL93v4+PzreIKrccSQvYJD+WDCeyrLQgC/P7VtU
         S3UCZCMIfW9eTHkyqx5AwI5a1kaPFx2rILKzEWZ8rztmfKpXmdzkLx0ft5s0uKWRgI/t
         bwbA==
X-Gm-Message-State: AOJu0YwY+B5JCGKw/hItfSY3URvIa7kWLmrmhZ3Xr6K/NZddbJpxhk1d
	RyOzU5nlLlI/t0gbPIWgKIxM10KdUWC64Po6Caj6fL5dBGoI0f7VfUU2O9IUj3EtoSuKfEsEp4V
	YTs/4MaKZT84JusCBkGsGBWPTr+DUbmrIBsBd
X-Gm-Gg: ASbGncs9UZxnUzIvYKGekGdojiVZHMcGnx9sPAhSSiXEReXeQCWwY2bcTRej4CrIjLV
	yms0XfANFmBiNF54d0Yb/8CVX1QJoaHWbr89/rvwhRlIGLXn/2wlYoNUJTXsh50I=
X-Google-Smtp-Source: AGHT+IHtbB68ic/1ReybhYMyq1GPGuAL9P82gcwJIu8iFqYJ/7OftXpYkHHpyB2Oy6vvrkImns7wROBKCUFwOT45Ap0=
X-Received: by 2002:a05:6000:2a9:b0:382:49c4:ef54 with SMTP id
 ffacd0b85a97d-385c6ebd749mr352736f8f.23.1732657252537; Tue, 26 Nov 2024
 13:40:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122002752.4179915-1-ctshao@google.com> <Z0VljcVm4ni-lJrE@google.com>
In-Reply-To: <Z0VljcVm4ni-lJrE@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 26 Nov 2024 13:40:41 -0800
Message-ID: <CAJpZYjXTnnEHvqjw_ph5fruNVe-t4bFcJa_SFR5kLyGCzmJxRw@mail.gmail.com>
Subject: Re: [PATCH v2] perf lock: Fix parse_lock_type which only retrieve one
 lock flag
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Namhyung! please check my v3 patches:
https://lore.kernel.org/all/20241126212255.3793822-1-ctshao@google.com/

On Mon, Nov 25, 2024 at 10:07=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Fri, Nov 22, 2024 at 12:27:51AM +0000, Chun-Tse Shao wrote:
> > `parse_lock_type` can only add the first lock flag in `lock_type_table`
> > given input `str`. For example, for `Y rwlock`, it only adds `rwlock:R`
> > into this perf session. Another example is for `-Y mutex`, it only adds
> > the mutex without `LCB_F_SPIN` flag. The patch fixes this issue, makes
> > sure both `rwlock:R` and `rwlock:W` will be added with `-Y rwlock`, and
> > so on.
> >
> > Testing:
> >   $ ./perf lock con -ab -Y mutex,rwlock -- perf bench sched pipe
> >   # Running 'sched/pipe' benchmark:
> >   # Executed 1000000 pipe operations between two processes
> >
> >        Total time: 8.425 [sec]
> >
> >          8.425402 usecs/op
> >            118688 ops/sec
> >    contended   total wait     max wait     avg wait         type   call=
er
> >
> >          194      1.68 ms     44.16 us      8.66 us        mutex   pipe=
_read+0x57
> >           10    423.03 us     44.27 us     42.30 us     rwlock:W   do_e=
xit+0x365
> >           54    254.67 us     58.87 us      4.72 us        mutex   pipe=
_write+0x50
> >           21    146.64 us     11.54 us      6.98 us        mutex   pipe=
_read+0x282
> >           10    141.27 us     20.62 us     14.13 us     rwlock:W   rele=
ase_task+0x6f
> >            5     58.92 us     16.37 us     11.78 us        mutex   do_e=
poll_wait+0x24d
> >            3     29.81 us     17.66 us      9.94 us        mutex   do_e=
poll_ctl+0x6c1
> >            4     26.82 us     11.02 us      6.70 us        mutex   do_e=
poll_wait+0x24d
> >            2     18.32 us     12.49 us      9.16 us     rwlock:W   do_e=
poll_wait+0x255
> >            1     11.34 us     11.34 us     11.34 us     rwlock:W   ep_d=
one_scan+0x2d
> >            1     11.02 us     11.02 us     11.02 us     rwlock:R   mm_u=
pdate_next_owner+0x4e
> >            1     10.60 us     10.60 us     10.60 us     rwlock:W   do_e=
poll_ctl+0xb65
> >            1      9.90 us      9.90 us      9.90 us     rwlock:W   do_e=
xit+0x365
> >
> > Fixes: d783ea8f62c4 ("perf lock contention: Simplify parse_lock_type()"=
)
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  tools/perf/builtin-lock.c | 93 ++++++++++++++++++++++++++-------------
> >  1 file changed, 62 insertions(+), 31 deletions(-)
> >
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index 062e2b56a2ab..052dbf423efd 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -15,6 +15,7 @@
> >  #include "util/lock-contention.h"
> >  #include "util/bpf_skel/lock_data.h"
> >
> > +#include <string.h>
> >  #include <subcmd/pager.h>
> >  #include <subcmd/parse-options.h>
> >  #include "util/trace-event.h"
> > @@ -1575,8 +1576,13 @@ static void sort_result(void)
> >
> >  static const struct {
> >       unsigned int flags;
> > -     const char *str;
> > +     /* Name of the lock. */
> >       const char *name;
>
> I think this is the name of flag or access - read or write.
>

Rename to `flags_name`.

>
> > +     /*
> > +      * Name of the group this lock belongs to.
> > +      * For example, both rwlock:R and rwlock:W belong to rwlock.
> > +      */
> > +     const char *group;
>
> And this is the name of the lock (type) - rwlock or rwsem.
>

Rename to `lock_name`.

>
> >  } lock_type_table[] =3D {
> >       { 0,                            "semaphore",    "semaphore" },
> >       { LCB_F_SPIN,                   "spinlock",     "spinlock" },
> > @@ -1591,42 +1597,38 @@ static const struct {
> >       { LCB_F_PERCPU | LCB_F_WRITE,   "pcpu-sem:W",   "percpu-rwsem" },
> >       { LCB_F_MUTEX,                  "mutex",        "mutex" },
> >       { LCB_F_MUTEX | LCB_F_SPIN,     "mutex",        "mutex" },
> > -     /* alias for get_type_flag() */
> > -     { LCB_F_MUTEX | LCB_F_SPIN,     "mutex-spin",   "mutex" },
> >  };
> >
> > -static const char *get_type_str(unsigned int flags)
> > +static const char *get_type_name(unsigned int flags)
> >  {
> >       flags &=3D LCB_F_MAX_FLAGS - 1;
> >
> >       for (unsigned int i =3D 0; i < ARRAY_SIZE(lock_type_table); i++) =
{
> >               if (lock_type_table[i].flags =3D=3D flags)
> > -                     return lock_type_table[i].str;
> > +                     return lock_type_table[i].name;
> >       }
> >       return "unknown";
> >  }
> >
> > -static const char *get_type_name(unsigned int flags)
> > +static const char *get_type_group(unsigned int flags)
> >  {
> >       flags &=3D LCB_F_MAX_FLAGS - 1;
> >
> >       for (unsigned int i =3D 0; i < ARRAY_SIZE(lock_type_table); i++) =
{
> >               if (lock_type_table[i].flags =3D=3D flags)
> > -                     return lock_type_table[i].name;
> > +                     return lock_type_table[i].group;
> >       }
> >       return "unknown";
> >  }
> >
> > -static unsigned int get_type_flag(const char *str)
> > +static unsigned int get_type_flags_by_name(const char *name)
> >  {
> >       for (unsigned int i =3D 0; i < ARRAY_SIZE(lock_type_table); i++) =
{
> > -             if (!strcmp(lock_type_table[i].name, str))
> > -                     return lock_type_table[i].flags;
> > -     }
> > -     for (unsigned int i =3D 0; i < ARRAY_SIZE(lock_type_table); i++) =
{
> > -             if (!strcmp(lock_type_table[i].str, str))
> > +             if (!strcmp(lock_type_table[i].name, name))
> >                       return lock_type_table[i].flags;
> >       }
> > +
> > +     pr_err("Unknown lock flags: %s\n", name);
>
> I'm not sure if there will be another caller, but it seems better to
> have this error message in the parse function directly.
>

Done. I removed this function since imo it did not help readability,
and was only used for once.

>
> >       return UINT_MAX;
> >  }
> >
> > @@ -1732,7 +1734,8 @@ static void print_lock_stat_stdio(struct lock_con=
tention *con, struct lock_stat
> >
> >       switch (aggr_mode) {
> >       case LOCK_AGGR_CALLER:
> > -             fprintf(lock_output, "  %10s   %s\n", get_type_str(st->fl=
ags), st->name);
> > +             fprintf(lock_output, "  %10s   %s\n",
> > +                     get_type_name(st->flags), st->name);
> >               break;
> >       case LOCK_AGGR_TASK:
> >               pid =3D st->addr;
> > @@ -1742,7 +1745,7 @@ static void print_lock_stat_stdio(struct lock_con=
tention *con, struct lock_stat
> >               break;
> >       case LOCK_AGGR_ADDR:
> >               fprintf(lock_output, "  %016llx   %s (%s)\n", (unsigned l=
ong long)st->addr,
> > -                     st->name, get_type_name(st->flags));
> > +                     st->name, get_type_group(st->flags));
> >               break;
> >       case LOCK_AGGR_CGROUP:
> >               fprintf(lock_output, "  %s\n", st->name);
> > @@ -1783,7 +1786,8 @@ static void print_lock_stat_csv(struct lock_conte=
ntion *con, struct lock_stat *s
> >
> >       switch (aggr_mode) {
> >       case LOCK_AGGR_CALLER:
> > -             fprintf(lock_output, "%s%s %s", get_type_str(st->flags), =
sep, st->name);
> > +             fprintf(lock_output, "%s%s %s",
> > +                     get_type_name(st->flags), sep, st->name);
> >               if (verbose <=3D 0)
> >                       fprintf(lock_output, "\n");
> >               break;
> > @@ -1795,7 +1799,7 @@ static void print_lock_stat_csv(struct lock_conte=
ntion *con, struct lock_stat *s
> >               break;
> >       case LOCK_AGGR_ADDR:
> >               fprintf(lock_output, "%llx%s %s%s %s\n", (unsigned long l=
ong)st->addr, sep,
> > -                     st->name, sep, get_type_name(st->flags));
> > +                     st->name, sep, get_type_group(st->flags));
> >               break;
> >       case LOCK_AGGR_CGROUP:
> >               fprintf(lock_output, "%s\n",st->name);
> > @@ -2338,41 +2342,68 @@ static bool add_lock_type(unsigned int flags)
> >       unsigned int *tmp;
> >
> >       tmp =3D realloc(filters.types, (filters.nr_types + 1) * sizeof(*f=
ilters.types));
> > -     if (tmp =3D=3D NULL)
> > +     if (tmp =3D=3D NULL) {
> > +             pr_err("Failed to add lock flags: %u\n", flags);
> >               return false;
> > +     }
> >
> >       tmp[filters.nr_types++] =3D flags;
> >       filters.types =3D tmp;
> >       return true;
> >  }
> >
> > -static int parse_lock_type(const struct option *opt __maybe_unused, co=
nst char *str,
> > -                        int unset __maybe_unused)
> > +static int parse_lock_type(const struct option *opt __maybe_unused,
> > +                        const char *str, int unset __maybe_unused)
> >  {
> >       char *s, *tmp, *tok;
> > -     int ret =3D 0;
> >
> >       s =3D strdup(str);
> >       if (s =3D=3D NULL)
> >               return -1;
> >
> > -     for (tok =3D strtok_r(s, ", ", &tmp); tok; tok =3D strtok_r(NULL,=
 ", ", &tmp)) {
> > -             unsigned int flags =3D get_type_flag(tok);
> > +     for (tok =3D strtok_r(s, ", ", &tmp); tok;
> > +          tok =3D strtok_r(NULL, ", ", &tmp)) {
>
> I think you changed this because of the 80 column limit.  But I think
> it's recently increased to 100 so you don't need to change this line
> uncessarily.
>
> Other lines containing actual changes may be accceptable.  It's up to
> you but I generally prefer smaller changes.
>

Done.

>
> > +             bool found =3D false;
> >
> > -             if (flags =3D=3D -1U) {
> > -                     pr_err("Unknown lock flags: %s\n", tok);
> > -                     ret =3D -1;
> > -                     break;
> > +             /* `tok` is a lock name if it contains ':'. */
> > +             if (strchr(tok, ':')) {
> > +                     unsigned int flags =3D get_type_flags_by_name(tok=
);
> > +
> > +                     if (flags =3D=3D UINT_MAX || !add_lock_type(flags=
)) {
> > +                             free(s);
> > +                             return -1;
> > +                     }
> > +                     continue;
> >               }
> >
> > -             if (!add_lock_type(flags)) {
> > -                     ret =3D -1;
> > -                     break;
> > +             /* Otherwise look up flags by lock group */
> > +             /*
> > +              * By documentation, `percpu-rwmem` should be `pcpu-sem`.
> > +              * For backward compatibility, we replace pcpu-sem with p=
ercpu-rwmem.
> > +              */
> > +             if (!strcmp(tok, "pcpu-sem"))
> > +                     tok =3D (char *)"percpu-rwsem";
>
> Can you please split this into a separate fix?
>

Done. Now I have two patches, the first one is for renaming, the
second one is for parsing logic.

> Thanks,
> Namhyung
>
> > +
> > +             for (unsigned int i =3D 0; i < ARRAY_SIZE(lock_type_table=
); i++) {
> > +                     if (!strcmp(lock_type_table[i].group, tok)) {
> > +                             if (add_lock_type(lock_type_table[i].flag=
s)) {
> > +                                     found =3D true;
> > +                             } else {
> > +                                     free(s);
> > +                                     return -1;
> > +                             }
> > +                     }
> > +             }
> > +
> > +             if (!found) {
> > +                     pr_err("Unknown lock flags: %s\n", tok);
> > +                     free(s);
> > +                     return -1;
> >               }
> >       }
> >
> >       free(s);
> > -     return ret;
> > +     return 0;
> >  }
> >
> >  static bool add_lock_addr(unsigned long addr)
> > --
> > 2.47.0.371.ga323438b13-goog
> >

