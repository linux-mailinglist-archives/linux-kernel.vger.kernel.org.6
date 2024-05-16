Return-Path: <linux-kernel+bounces-180645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E9F8C713C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15C528242B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD1919479;
	Thu, 16 May 2024 04:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/g+XreN"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04A610A26
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 04:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715835393; cv=none; b=om4TIPEH9ynF76PycfRuc2FojyBI37PrcuX3UckRAeD8PuG8hJM4M4T3z07o/0mp3nmmeTCtnbOjA0QLpbgMq3z9TF6rOMsFlBSIUECrWOdivaVrpMCbXpJvA5rOfAeiJvmeDxLZlT8StxxhFZzqAIg8LdbcA/jHD9WWcjkb+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715835393; c=relaxed/simple;
	bh=JwWyISgIkyh7dn8oHMIGe/EQKAVjws5uA5+GPSEkhw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrkKlbccuiqpPBLBDkM99wjFdiTya0EVffvXw7cY1unwvqugQ+dFvZioldhL86ckoAjHBIkjc6I0BTnSnOUUWb4YhNVlVZY2WXWYknbd271ewl4lygQl/rhL+bJXFWbrU71hTKaZK9ae563ajaNRuJguKsnRPAIORR2kqKM1494=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/g+XreN; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43dfe020675so2501601cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715835390; x=1716440190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xCvPhj2snwk9qo0oBLZupJijw2DEcTcDH7Djs/ftR4=;
        b=s/g+XreNK9x8SAYRDKG2L5jNMkxv8nplS79A9uGyahjQosSXVJXxe24gUN6qM3QRSY
         R4gkt22TeT62w0kdGZ0RYy0QGeeiG1oksG+jkmDFxyOql4mCkUcZShcUaq/aS94ZIXro
         1CsthdbZ9Klp8/JxxhSXIoGHmxoO1cyA7eLzq48jej2TOQpTxlVqKYk16KS4s5hvyJRB
         1pJCvF7MSUBJUh9F7mtfHukQYFBi/l6EamqDvuawOa8ozCKFaSTJMGpJxeOvcH4V9FpN
         Wj+9UunCJNwhP7ii3DRZiU3jztm//jZhncdH188+0ollw6zv8wFZXyrZYWlfx9bearro
         WB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715835390; x=1716440190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xCvPhj2snwk9qo0oBLZupJijw2DEcTcDH7Djs/ftR4=;
        b=BlkYImO4u+lO292WVgvU/mjOe7AGPtqwIUdwWk7WKiLx6aW9ztKrmdoivxNAhSf6Tz
         yhuGcbUxyjNB/a0kQlgAyB1Ei2RdD34E+YPvv0AOT7A5jDyJBoqKeVbdiqS2LmEZETyx
         A2I/Vx+5wtxwJl4kEijB2v26qSo4m9hqrsFtdT9Y+8OUO7OgLyCpqeMbJi+zPRP1bilj
         duu2PBaVeC4embuPIpQjZ7q9IUCQoDKQO3UhTWQ00QEFlQ8xt1gmTkgGSQE0+rGEP0Eh
         /iTyCr6wnlEW3feniaWw45Ugz8nmD+WDq40PyTUhHmDTua91/keI6j4OKWOOFCjaGVg3
         fXeA==
X-Forwarded-Encrypted: i=1; AJvYcCWew01dqtJNJShgle0wtXqVt5wA1CmrP/nKhGusn2mk5dEejRc+QGpddbLf292PyyD0OGDWoqk5V6XA8VgDOUdncBsgQB9eHQMR0KiH
X-Gm-Message-State: AOJu0YxC1D9mCnf7mZu6j06ARGq1/Tptpn2BPYDbIgfl7lIRy01Z8Fx7
	tU8zOqCYfY/xZjLlCni+7cGtj86uyiw+/AfIeHN/DqNADuaIQFopUCrB73nbd5qRtmhTO3nsDPY
	T24sx7RMuGq6vMqfX+yMWglpTfFQoNpWCl9kt
X-Google-Smtp-Source: AGHT+IEph7lOyHwSpuS97PiF2Kgsuziv3mAEnQgsw5vlTz4FLKn9yiFHzBFAY1EL0le1rxOcJ/o/Djv3+QDp2jEXEM8=
X-Received: by 2002:a05:622a:4286:b0:439:ef72:75fb with SMTP id
 d75a77b69052e-43e0a21e3c8mr11449831cf.1.1715835389800; Wed, 15 May 2024
 21:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424024805.144759-1-howardchu95@gmail.com>
 <CAM9d7chOdrPyeGk=O+7Hxzdm5ziBXLES8PLbpNJvA7_DMrrGHA@mail.gmail.com>
 <Zil1ZKc7mibs6ONQ@x1> <CAP-5=fVYHjUk8OyidXbutBvZMPxf48LW7v-N3zvHBe5QME1vVQ@mail.gmail.com>
 <CAM9d7cggak7qZcX7tFZvJ69H3cwEnWvNOnBsQrkFQkQVf+bUjQ@mail.gmail.com> <CAH0uvohPg7LtSOLDNaPwnC5ePwjwg0NtKzLZ_oJcAz7zOwdwdw@mail.gmail.com>
In-Reply-To: <CAH0uvohPg7LtSOLDNaPwnC5ePwjwg0NtKzLZ_oJcAz7zOwdwdw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 May 2024 21:56:18 -0700
Message-ID: <CAP-5=fUzD8VZRnsxEBNPK_7PAGzdFjzmBAupA-eh=7VCDHBkbA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Dump off-cpu samples directly
To: Howard Chu <howardchu95@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	zegao2021@gmail.com, leo.yan@linux.dev, ravi.bangoria@amd.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 9:24=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hello,
>
> Here is a little update on --off-cpu.
>
> > > It would be nice to start landing this work so I'm wondering what the
> > > minimal way to do that is. It seems putting behavior behind a flag is
> > > a first step.
>
> The flag to determine output threshold of off-cpu has been implemented.
> If the accumulated off-cpu time exceeds this threshold, output the sample
> directly; otherwise, save it later for off_cpu_write.
>
> But adding an extra pass to handle off-cpu samples introduces performance
> issues, here's the processing rate of --off-cpu sampling(with the
> extra pass to extract raw
> sample data) and without. The --off-cpu-threshold is in nanoseconds.
>
> +-----------------------------------------------------+------------------=
---------------------+----------------------+
> | comm                                                | type
>                        | process rate         |
> +-----------------------------------------------------+------------------=
---------------------+----------------------+
> | -F 4999 -a                                          | regular
> samples (w/o extra pass)      | 13128.675 samples/ms |
> +-----------------------------------------------------+------------------=
---------------------+----------------------+
> | -F 1 -a --off-cpu --off-cpu-threshold 100           | offcpu samples
> (extra pass)           |  2843.247 samples/ms |
> +-----------------------------------------------------+------------------=
---------------------+----------------------+
> | -F 4999 -a --off-cpu --off-cpu-threshold 100        | offcpu &
> regular samples (extra pass) |  3910.686 samples/ms |
> +-----------------------------------------------------+------------------=
---------------------+----------------------+
> | -F 4999 -a --off-cpu --off-cpu-threshold 1000000000 | few offcpu &
> regular (extra pass)     |  4661.229 samples/ms |
> +-----------------------------------------------------+------------------=
---------------------+----------------------+
>
> It's not ideal. I will find a way to reduce overhead. For example
> process them samples
> at save time as Ian mentioned.
>
> > > To turn the bpf-output samples into off-cpu events there is a pass
> > > added to the saving. I wonder if that can be more generic, like a sav=
e
> > > time perf inject.
>
> And I will find a default value for such a threshold based on performance
> and common use cases.
>
> > Sounds good.  We might add an option to specify the threshold to
> > determine whether to dump the data or to save it for later.  But ideall=
y
> > it should be able to find a good default.
>
> These will be done before the GSoC kick-off on May 27.

This all sounds good. 100ns seems like quite a low threshold and 1s
extremely high, shame such a high threshold is marginal for the
context switch performance change. I wonder 100 microseconds may be a
more sensible threshold. It's 100 times larger than the cost of 1
context switch but considerably less than a frame redraw at 60FPS (16
milliseconds).

Thanks,
Ian

> Thanks,
> Howard
>
> On Thu, Apr 25, 2024 at 6:57=E2=80=AFAM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Wed, Apr 24, 2024 at 3:19=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Wed, Apr 24, 2024 at 2:11=E2=80=AFPM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Wed, Apr 24, 2024 at 12:12:26PM -0700, Namhyung Kim wrote:
> > > > > Hello,
> > > > >
> > > > > On Tue, Apr 23, 2024 at 7:46=E2=80=AFPM Howard Chu <howardchu95@g=
mail.com> wrote:
> > > > > >
> > > > > > As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=3D=
207323
> > > > > >
> > > > > > Currently, off-cpu samples are dumped when perf record is exiti=
ng. This
> > > > > > results in off-cpu samples being after the regular samples. Als=
o, samples
> > > > > > are stored in large BPF maps which contain all the stack traces=
 and
> > > > > > accumulated off-cpu time, but they are eventually going to fill=
 up after
> > > > > > running for an extensive period. This patch fixes those problem=
s by dumping
> > > > > > samples directly into perf ring buffer, and dispatching those s=
amples to the
> > > > > > correct format.
> > > > >
> > > > > Thanks for working on this.
> > > > >
> > > > > But the problem of dumping all sched-switch events is that it can=
 be
> > > > > too frequent on loaded machines.  Copying many events to the buff=
er
> > > > > can result in losing other records.  As perf report doesn't care =
about
> > > > > timing much, I decided to aggregate the result in a BPF map and d=
ump
> > > > > them at the end of the profiling session.
> > > >
> > > > Should we try to adapt when there are too many context switches, i.=
e.
> > > > the BPF program can notice that the interval from the last context
> > > > switch is too small and then avoid adding samples, while if the int=
erval
> > > > is a long one then indeed this is a problem where the workload is
> > > > waiting for a long time for something and we want to know what is t=
hat,
> > > > and in that case capturing callchains is both desirable and not cos=
tly,
> > > > no?
> >
> > Sounds interesting.  Yeah we could make it adaptive based on the
> > off-cpu time at the moment.
> >
> > > >
> > > > The tool could then at the end produce one of two outputs: the most
> > > > common reasons for being off cpu, or some sort of counter stating t=
hat
> > > > there are way too many context switches?
> > > >
> > > > And perhaps we should think about what is best to have as a default=
, not
> > > > to present just plain old cycles, but point out that the workload i=
s
> > > > most of the time waiting for IO, etc, i.e. the default should give
> > > > interesting clues instead of expecting that the tool user knows all=
 the
> > > > possible knobs and try them in all sorts of combinations to then re=
ach
> > > > some conclusion.
> > > >
> > > > The default should use stuff that isn't that costly, thus not getti=
ng in
> > > > the way of what is being observed, but at the same time look for co=
mmon
> > > > patterns, etc.
> > > >
> > > > - Arnaldo
> > >
> > > I really appreciate Howard doing this work!
> > >
> > > I wonder there are other cases where we want to synthesize events in
> > > BPF, for example, we may have fast and slow memory on a system, we
> > > could turn memory events on a system into either fast or slow ones in
> > > BPF based on the memory accessed, so that fast/slow memory systems ca=
n
> > > be simulated without access to hardware. This also feels like a perf
> > > script type problem. Perhaps we can add something to the bpf-output
> > > event so it can have multiple uses and not just off-cpu.
> > >
> > >
> > > I worry about dropping short samples we can create a property that
> > > off-cpu time + on-cpu time !=3D wall clock time. Perhaps such short
> > > things can get pushed into Namhyung's "at the end" approach while
> > > longer things get samples. Perhaps we only do that when the frequency
> > > is too great.
> >
> > Sounds good.  We might add an option to specify the threshold to
> > determine whether to dump the data or to save it for later.  But ideall=
y
> > it should be able to find a good default.
> >
> > >
>
> >
> > Agreed!
> >
> > Thanks,
> > Namhyung

