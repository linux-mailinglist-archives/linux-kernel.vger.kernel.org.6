Return-Path: <linux-kernel+bounces-417620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B6D9D56C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B021F2295C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D58469D;
	Fri, 22 Nov 2024 00:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5uJxpXw"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1C71853
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732235683; cv=none; b=oxv94FangwCpDMilfsl4hLpSDXqQBSx2lmGArCrfRrsYkvtGiVmsRJ8npo8qM+xwgEk9234KGbNK06uaR0Vv31vlhOepNahqKhWZVdSooZE7Dw1iPWYMxWzXtSGFTQdHoKeVldJ6MiotdJsLzKoIqdyVx1lRjfLRNkGpiNyjk40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732235683; c=relaxed/simple;
	bh=Q+kB8GukyHoLwdT/iF2iKe7Jz2OI1D8IDTP7K3gZIvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FY0tGyES/Hu6PaeyaiVIqSRcdU50RH4j57+GCIRAczsbj/xE4RQrc3nkPQWqNtUfXqfixXJfIGyrLndOFLeJcjfAoj9F8mWMR9RwzXhHChC2KIN+MKgyoiOPGs0vkRsAhU/qfq8E6TP1B6SesqcoZGaUDWmBqvxucUedJWYZAGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s5uJxpXw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3823e45339bso1217025f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732235679; x=1732840479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+APhAD0gW6t/wDLQQQ3ibcvOvy2UBvvN1wB+uw9VShY=;
        b=s5uJxpXwRudOm6qRtB1JHKsuXdblU0oSHoTHsJa9wrcRdHkannomBSEtKu7TPGxvp8
         Ytsb36LAMWJM190UlYeE6vhC8qu4KW7x1qn4a+jSC99OhmjHF+UbUmmWXti0Sq0dCMeU
         dr3bi9QS2d/zGBQ4BYJaUNPsP0ps3nYtp8VJDoCc824GC9QI98hGqkMF6Yb3rzWKv+v1
         eJ18x6cdzZ/uLMovvtftPmo3/ga3nB9zoA53Cs4mgUyqAkT/tE7Ygysu6WnmYmuV8jhq
         bpzpK9mHgMpZSAI60LkkKT3GXdVUIp22cYOVe0IlINTBbgmC/9xFMUk8sC4DWmU+pulb
         GKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732235679; x=1732840479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+APhAD0gW6t/wDLQQQ3ibcvOvy2UBvvN1wB+uw9VShY=;
        b=ppTSP68IgcWHfblX+i8QhHd4Y1T97vGDZPgwUYG4bKhnp0EMebMljGDNHPejb7eJxA
         dqG/mO5EjrHlGzFDP36ZStrZkGdiY0/y+HrcMIF0CiWCUru00pqqpzyV60xuT1e8tZ6o
         6/nmOTP2D+8WPYOgYy67M9ypgcTbJBCEBvoYaqE+KtH9Yt6grkdjS2EPEzaet3qymCo4
         09WQaGWNfS2gT9GzYbhhvEvpNOLexwpiPNgkOxge8BBXXyZT837cAUokBrJIBzr1g34W
         JqTaQPneRchlGxZPwJb8VqnAcsgEZfNThZgSDZwa9zIWH56Qbdc5cFiJr6gupfWQ3B4g
         IO8w==
X-Gm-Message-State: AOJu0Yzvt7Il1CxDz0EGoYl38FVsz09IgTFHVgEQtwU/h3Gl6q71UyA3
	OZbzxOnKeHn/AOW7eaNWUVUfV6abSN8OEaXjwIgP5/TDGQt/i8qFUruuly20LN+qaMI9i2nJ28z
	GbkB034DvCyCmiSLaqB+KsBxuLy5NWPxVD8ZXH+rUcKXRbp0q4bnBB1/VOw==
X-Gm-Gg: ASbGncvAampcY3Becu0v0SHQn6yzhRAvM5Sj5Nh0cqAO4Np3kQkTS1/GJRzEUlwo+Rc
	SGOR4pokoG0xAGDJBjOjAXz0bft3udMJVuHR7gEvHG5zm+2CuRQvxwrjdxQ==
X-Google-Smtp-Source: AGHT+IEqGCvzZcwsA9xQ4LFOSqV8kyx8Qo86ksuyEPGlXjjDKGhBOmPmAnpVY/ogt6uNmhjCIA0W/ET1vhUZZGEZnFI=
X-Received: by 2002:a5d:6d8f:0:b0:382:3afd:1273 with SMTP id
 ffacd0b85a97d-38260b89164mr704290f8f.30.1732235679038; Thu, 21 Nov 2024
 16:34:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121044551.3899270-1-ctshao@google.com> <Zz7evEkguMdglxdZ@google.com>
In-Reply-To: <Zz7evEkguMdglxdZ@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Thu, 21 Nov 2024 16:34:27 -0800
Message-ID: <CAJpZYjVDVQ7ytJjBBjjK4On7bOdRN+8Q3wGeen3EeSmevyb=1Q@mail.gmail.com>
Subject: Re: [PATCH] perf lock: Fix parse_lock_type which only retrieve one
 lock flag
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Namhyung! please check my patch v2:
https://lore.kernel.org/all/20241122002752.4179915-1-ctshao@google.com

On Wed, Nov 20, 2024 at 11:18=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi CT,
>
> On Thu, Nov 21, 2024 at 04:45:51AM +0000, Chun-Tse Shao wrote:
> > `parse_lock_type` can only add the first lock flag in `lock_type_table`
> > given input `str`. For example, for `Y rwlock`, it only adds `rwlock:R`
> > into this perf session. Another example is for `-Y mutex`, it only adds
> > the mutex without `LCB_F_SPIN` flag. The patch fixes this issue, makes
> > sure both `rwlock:R` and `rwlock:W` will be added with `-Y rwlock`, and
> > so on.
>
> Thanks for working on this.  I think I broke it at some point.
>
> >
> > Testing:
> >   $ ./perf lock con -ab -Y rwlock,mutex -- perf bench sched pipe
> >   # Running 'sched/pipe' benchmark:
> >   # Executed 1000000 pipe operations between two processes
> >
> >        Total time: 7.870 [sec]
> >
> >          7.870224 usecs/op
> >            127061 ops/sec
> >    contended   total wait     max wait     avg wait         type   call=
er
> >
> >          122      1.01 ms     18.73 us      8.32 us        mutex   pipe=
_read+0x57
> >           33    149.06 us      8.88 us      4.52 us        mutex   pipe=
_write+0x50
> >            5     56.06 us     15.07 us     11.21 us        mutex   do_e=
poll_wait+0x24d
> >            2     26.43 us     14.62 us     13.22 us        mutex   do_e=
poll_wait+0x24d
> >            2     21.51 us     15.68 us     10.76 us        mutex   pipe=
_read+0x282
> >            2     20.57 us     10.74 us     10.29 us        mutex   do_e=
poll_ctl+0x3d4
> >            1      8.58 us      8.58 us      8.58 us     rwlock:W   do_e=
poll_wait+0x255
> >            1      8.38 us      8.38 us      8.38 us     rwlock:W   do_e=
poll_ctl+0xb65
> >            1      8.11 us      8.11 us      8.11 us     rwlock:R   ep_p=
oll_callback+0x35
> >            1      5.49 us      5.49 us      5.49 us        mutex   do_e=
poll_ctl+0x6c1
>
> It should have
>
> Fixes: d783ea8f62c4 ("perf lock contention: Simplify parse_lock_type()")

Done.

>
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  tools/perf/builtin-lock.c | 118 +++++++++++++++++++++++---------------
> >  1 file changed, 71 insertions(+), 47 deletions(-)
> >
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index 062e2b56a2ab..2692b8e9eb9a 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -1575,61 +1575,57 @@ static void sort_result(void)
> >
> >  static const struct {
> >       unsigned int flags;
> > -     const char *str;
> > +     /* Name of the lock, it is unique and 1-1 mapping to flags */
> >       const char *name;
> > +     /*
> > +      * Name of the group this lock belongs to.
> > +      * For example, both rwlock:R and rwlock:W belong to rwlock.
> > +      * This is used for reverse parsing while user specify the group =
name (ex. mutex/rwlock),
> > +      * And for symbol name in LOCK_AGGR_ADDR mode.
> > +      */
> > +     const char *affiliated_group_name;
> > +     /*
> > +      * This is used for caller type in LOCK_AGGR_CALLER mode.
> > +      */
> > +     const char *caller_type;
>
> I admit that the 'str' and 'name' are not good but I'm not sure if we
> need those 3 different names because they are mostly the same.  Maybe we
> have rename the original fields to 'name' and 'group'?

Done.

>
>
> >  } lock_type_table[] =3D {
> > -     { 0,                            "semaphore",    "semaphore" },
> > -     { LCB_F_SPIN,                   "spinlock",     "spinlock" },
> > -     { LCB_F_SPIN | LCB_F_READ,      "rwlock:R",     "rwlock" },
> > -     { LCB_F_SPIN | LCB_F_WRITE,     "rwlock:W",     "rwlock" },
> > -     { LCB_F_READ,                   "rwsem:R",      "rwsem" },
> > -     { LCB_F_WRITE,                  "rwsem:W",      "rwsem" },
> > -     { LCB_F_RT,                     "rt-mutex",     "rt-mutex" },
> > -     { LCB_F_RT | LCB_F_READ,        "rwlock-rt:R",  "rwlock-rt" },
> > -     { LCB_F_RT | LCB_F_WRITE,       "rwlock-rt:W",  "rwlock-rt" },
> > -     { LCB_F_PERCPU | LCB_F_READ,    "pcpu-sem:R",   "percpu-rwsem" },
> > -     { LCB_F_PERCPU | LCB_F_WRITE,   "pcpu-sem:W",   "percpu-rwsem" },
> > -     { LCB_F_MUTEX,                  "mutex",        "mutex" },
> > -     { LCB_F_MUTEX | LCB_F_SPIN,     "mutex",        "mutex" },
> > -     /* alias for get_type_flag() */
> > -     { LCB_F_MUTEX | LCB_F_SPIN,     "mutex-spin",   "mutex" },
> > +     { 0,                            "semaphore",    "semaphore",    "=
semaphore" },
> > +     { LCB_F_SPIN,                   "spinlock",     "spinlock",     "=
spinlock" },
> > +     { LCB_F_SPIN | LCB_F_READ,      "rwlock:R",     "rwlock",       "=
rwlock:R" },
> > +     { LCB_F_SPIN | LCB_F_WRITE,     "rwlock:W",     "rwlock",       "=
rwlock:W" },
> > +     { LCB_F_READ,                   "rwsem:R",      "rwsem",        "=
rwsem:R" },
> > +     { LCB_F_WRITE,                  "rwsem:W",      "rwsem",        "=
rwsem:W" },
> > +     { LCB_F_RT,                     "rt-mutex",     "rt-mutex",     "=
rt-mutex" },
> > +     { LCB_F_RT | LCB_F_READ,        "rwlock-rt:R",  "rwlock-rt",    "=
rwlock-rt:R" },
> > +     { LCB_F_RT | LCB_F_WRITE,       "rwlock-rt:W",  "rwlock-rt",    "=
rwlock-rt:W" },
> > +     { LCB_F_PERCPU | LCB_F_READ,    "pcpu-sem:R",   "percpu-rwsem", "=
pcpu-sem:R" },
> > +     { LCB_F_PERCPU | LCB_F_WRITE,   "pcpu-sem:W",   "percpu-rwsem", "=
pcpu-sem:W" },
>
> I've realized that it doesn't match with the documentation.  It should
> match with 'pcpu-sem'.  Maybe we can replace the 'pcpu-sem' string in
> the parse_lock_type() to 'percpu-rwsem'.

Done.

>
> > +     { LCB_F_MUTEX,                  "mutex-nospin", "mutex",        "=
mutex" },
> > +     { LCB_F_MUTEX | LCB_F_SPIN,     "mutex-spin",   "mutex",        "=
mutex" },
>
> These are not for users and we don't track mutex-spinning precisely
> (yet).  So I think we can name both of them simply as "mutex".
>
>   { LCB_F_MUTEX,                "mutex", "mutex" },
>   { LCB_F_MUTEX | LCB_F_SPIN    "mutex", "mutex" },
>
> And remove the last alias entry.

Done.

>
> >  };
> >
> > -static const char *get_type_str(unsigned int flags)
> > +static const char *get_lock_caller_type(unsigned int flags)
> >  {
> >       flags &=3D LCB_F_MAX_FLAGS - 1;
> >
> >       for (unsigned int i =3D 0; i < ARRAY_SIZE(lock_type_table); i++) =
{
> >               if (lock_type_table[i].flags =3D=3D flags)
> > -                     return lock_type_table[i].str;
> > +                     return lock_type_table[i].caller_type;
> >       }
> >       return "unknown";
> >  }
> >
> > -static const char *get_type_name(unsigned int flags)
> > +static const char *get_lock_affiliated_group_name(unsigned int flags)
> >  {
> >       flags &=3D LCB_F_MAX_FLAGS - 1;
> >
> >       for (unsigned int i =3D 0; i < ARRAY_SIZE(lock_type_table); i++) =
{
> >               if (lock_type_table[i].flags =3D=3D flags)
> > -                     return lock_type_table[i].name;
> > +                     return lock_type_table[i].affiliated_group_name;
> >       }
> >       return "unknown";
> >  }
> >
> > -static unsigned int get_type_flag(const char *str)
> > -{
> > -     for (unsigned int i =3D 0; i < ARRAY_SIZE(lock_type_table); i++) =
{
> > -             if (!strcmp(lock_type_table[i].name, str))
> > -                     return lock_type_table[i].flags;
> > -     }
> > -     for (unsigned int i =3D 0; i < ARRAY_SIZE(lock_type_table); i++) =
{
> > -             if (!strcmp(lock_type_table[i].str, str))
> > -                     return lock_type_table[i].flags;
> > -     }
> > -     return UINT_MAX;
> > -}
> > -
> >  static void lock_filter_finish(void)
> >  {
> >       zfree(&filters.types);
> > @@ -1732,7 +1728,8 @@ static void print_lock_stat_stdio(struct lock_con=
tention *con, struct lock_stat
> >
> >       switch (aggr_mode) {
> >       case LOCK_AGGR_CALLER:
> > -             fprintf(lock_output, "  %10s   %s\n", get_type_str(st->fl=
ags), st->name);
> > +             fprintf(lock_output, "  %10s   %s\n",
> > +                     get_lock_caller_type(st->flags), st->name);
> >               break;
> >       case LOCK_AGGR_TASK:
> >               pid =3D st->addr;
> > @@ -1742,7 +1739,7 @@ static void print_lock_stat_stdio(struct lock_con=
tention *con, struct lock_stat
> >               break;
> >       case LOCK_AGGR_ADDR:
> >               fprintf(lock_output, "  %016llx   %s (%s)\n", (unsigned l=
ong long)st->addr,
> > -                     st->name, get_type_name(st->flags));
> > +                     st->name, get_lock_affiliated_group_name(st->flag=
s));
> >               break;
> >       case LOCK_AGGR_CGROUP:
> >               fprintf(lock_output, "  %s\n", st->name);
> > @@ -1783,7 +1780,8 @@ static void print_lock_stat_csv(struct lock_conte=
ntion *con, struct lock_stat *s
> >
> >       switch (aggr_mode) {
> >       case LOCK_AGGR_CALLER:
> > -             fprintf(lock_output, "%s%s %s", get_type_str(st->flags), =
sep, st->name);
> > +             fprintf(lock_output, "%s%s %s",
> > +                     get_lock_caller_type(st->flags), sep, st->name);
> >               if (verbose <=3D 0)
> >                       fprintf(lock_output, "\n");
> >               break;
> > @@ -1795,7 +1793,7 @@ static void print_lock_stat_csv(struct lock_conte=
ntion *con, struct lock_stat *s
> >               break;
> >       case LOCK_AGGR_ADDR:
> >               fprintf(lock_output, "%llx%s %s%s %s\n", (unsigned long l=
ong)st->addr, sep,
> > -                     st->name, sep, get_type_name(st->flags));
> > +                     st->name, sep, get_lock_affiliated_group_name(st-=
>flags));
> >               break;
> >       case LOCK_AGGR_CGROUP:
> >               fprintf(lock_output, "%s\n",st->name);
> > @@ -2333,6 +2331,7 @@ static int parse_max_stack(const struct option *o=
pt, const char *str,
> >       return 0;
> >  }
> >
> > +
> >  static bool add_lock_type(unsigned int flags)
> >  {
> >       unsigned int *tmp;
> > @@ -2350,29 +2349,54 @@ static int parse_lock_type(const struct option =
*opt __maybe_unused, const char *
> >                          int unset __maybe_unused)
> >  {
> >       char *s, *tmp, *tok;
> > -     int ret =3D 0;
> >
> >       s =3D strdup(str);
> >       if (s =3D=3D NULL)
> >               return -1;
> >
> >       for (tok =3D strtok_r(s, ", ", &tmp); tok; tok =3D strtok_r(NULL,=
 ", ", &tmp)) {
> > -             unsigned int flags =3D get_type_flag(tok);
> > +             bool found =3D false;
> >
> > -             if (flags =3D=3D -1U) {
> > -                     pr_err("Unknown lock flags: %s\n", tok);
> > -                     ret =3D -1;
> > -                     break;
> > +             /* Traverse lock name first. */
> > +             for (unsigned int i =3D 0; i < ARRAY_SIZE(lock_type_table=
); i++) {
> > +                     if (!strcmp(lock_type_table[i].name, tok)) {
> > +                             if (add_lock_type(lock_type_table[i].flag=
s)) {
> > +                                     found =3D true;
> > +                                     break;
> > +                             }
> > +                             pr_err("Failed to alloc lock: %s\n", tok)=
;
> > +                             free(s);
> > +                             return -1;
> > +                     }
> >               }
> > +             if (found)
> > +                     continue;
>
> Then I think the logic can be like this.
>
>                 if (strchr(tok, ':')) {
>                         flags =3D get_type_flag(tok);
>                         add_lock_type(flag);
>                         continue;
>                 }
>
>                 if (!strcmp(tok, "pcpu-sem"))
>                         tok =3D "percpu-rwsem";
>
>                 for (i =3D 0; i < ARRAY_SIZE(lock_type_table); i++) {
>                         if (!strcmp(lock_type_table[i].group, tok))
>                                 add_lock_type(...);
>                 }

Done. I think `get_type_flag` would be unnecessary since it's only called o=
nce.

>
> Thanks,
> Namhyung
>
> >
> > -             if (!add_lock_type(flags)) {
> > -                     ret =3D -1;
> > -                     break;
> > +             /*
> > +              * If `tok` can not be found in lock name, look up the lo=
ck affiliated group
> > +              * instead. A group would contain more than one lock flag=
.
> > +              */
> > +             for (unsigned int i =3D 0; i < ARRAY_SIZE(lock_type_table=
); i++) {
> > +                     if (!strcmp(lock_type_table[i].affiliated_group_n=
ame, tok)) {
> > +                             if (add_lock_type(lock_type_table[i].flag=
s)) {
> > +                                     found =3D true;
> > +                             } else {
> > +                                     pr_err("Failed to alloc lock: %s\=
n", tok);
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

