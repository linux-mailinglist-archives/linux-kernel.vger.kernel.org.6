Return-Path: <linux-kernel+bounces-192892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0208D23A0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F00285CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C522B17167A;
	Tue, 28 May 2024 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VnlRwlYn"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7282563
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922754; cv=none; b=CkVX3ssDtbqgR9DHehlvtah2Td3mNAigOZYRRs0DfnMfsy40K5DbLEGz41hYOnIE5KeYXwK0S9ZoPo+1HwfgDnfsHVX4wpfdYLCdarigT7UvmLlx3R289n8vORpsZFuOX1iliyIMQVeuLNQPNibzMIPd/TtxhJZoDQfWDxOynco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922754; c=relaxed/simple;
	bh=JugizINjHqR9cpFF0CnjW8t70zU3RksmSvm7HZuLe+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqX4POZOemWrWCjpC0rXJkcR/Q2Be9R2faGvylO01KX9RIeBDR7IhbOwHaQnzlWNuaxhOdUqYz1aaUkD/N0wUGyrnPPdW+2Ji+Q96OWVfkTjSb1kzAO++F8txT56UBmSnGokguhp81FdQN82WCdNTR+sMxIJPltEMdYjyF4jddw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VnlRwlYn; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43dfe020675so97231cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716922752; x=1717527552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELD/2chU87F21aDYaAH3EcQFIS5J1igS3MiO/QHUtns=;
        b=VnlRwlYngljvmFF/6OmFFb9TNFCmIbL/c8gCfKzGqTS25EnMoocjHx/Wy2XirzRCDn
         QtxFqve5IjRl/xX8bJXsFuMxRgsCMWS9mt4k22uYU7o2btVp9rrarSlPIXO20L6mPYuV
         MISvB0dbXS3jvu0mWCgUCH9NsN33bfO56XvCPKSBfwr+devMWLY6vvWSjwvhAL8aIOPm
         EdRcyROt8BH5CpmVvmL80nb/0JZHd6PhuwI6D8YI+Ar/bA+V+l8qAoKvR88u5jbyVJHV
         kxfW8JV9cTKZWcOJ7hdBLjqblnPP0WAmzCHQ0eA8AqoDXzO5yH7WtDvo9Ya9TBCIFMQk
         v+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716922752; x=1717527552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELD/2chU87F21aDYaAH3EcQFIS5J1igS3MiO/QHUtns=;
        b=gaZu3/d97CpGadSVfZfkDqiFDtuu2Sk/Mc3fR5kUjDFqRQYl7I4Ssdrq9p7oCiDTtG
         /jBcLlqWweaWqUN7FhteYA7NH0NWV23bQ0hidl6rPhPZESLLnq9x13qXdW8fXTosMnZj
         PoM2FAXxtqAvLJ6ml25G1Nmf/RFpGcKNhlSQ/LfukqV+D4d46m64guzigMvgcAssvv+O
         DWdnOX96i35aKZGIC2UkdwJIGT351bsBXLNi070+n+8x++4TIV0MO8cvM8T3+P6uR/HK
         22kBpe8m0/CBMzCrw5xjcABAxlfcTbA5KpBmjfZlX9Hcp/liMirz9ZLoJOfpHk+o97YR
         RsGA==
X-Forwarded-Encrypted: i=1; AJvYcCUVBuRqYrx40Waog/ZtYIbvNf2H0yrU+61sBY795e8ZgXlZjXd0VI+Zux4ZNIY0rgxJbuIgkTDbSzSWZnvRRkFKCPU7UpsdBYmRN9le
X-Gm-Message-State: AOJu0YzyUw1I/eAz41eK5vVmWBqXXDeTgAXk+50tOuydNdA2WBFWkayH
	vQakoOPLtUhG1rBaURzuxPaOa+6Pw0Ay47exq1rzQvFu5X06Wk5yKhuHKyUj2jhCv30rEn4sen+
	SHVbiR6Hgyi4fPCOT5acYx3EF8tUvuJgGXBfIaGP3nITXoeqpJHgbehM=
X-Google-Smtp-Source: AGHT+IGnNIRgwwM8j0F+3ahcPSXWF53AQe7JkGqjY5dz35qv2JbOIoODEI7twGYMBh4iLOF1jVuRR7Pdc56bxdiA80U=
X-Received: by 2002:a05:622a:5106:b0:43e:e09:d346 with SMTP id
 d75a77b69052e-43fe0d85cdemr201621cf.5.1716922751982; Tue, 28 May 2024
 11:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev> <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <CAHk-=wgcoODsCbba423uZwQqOjJ8r29GZyCd472K6L6Dt-NbPg@mail.gmail.com>
 <CAP-5=fUp+gSoLC90vT50X7So_SyAC9OprAMvh_Jj_8NTuO6j_w@mail.gmail.com> <CAHk-=wiDheOd3pdZ4vdLwrMbbVs3LUcSD=afASEWbND-HZhuPA@mail.gmail.com>
In-Reply-To: <CAHk-=wiDheOd3pdZ4vdLwrMbbVs3LUcSD=afASEWbND-HZhuPA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 May 2024 11:58:57 -0700
Message-ID: <CAP-5=fVGF6A7fwZyF8o0Sz5nNhtXb0007JoCxaiL2XHCKS3=0A@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 11:13=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 28 May 2024 at 10:40, Ian Rogers <irogers@google.com> wrote:
> >
> > I agree it picked the wrong PMU for default events. This was a problem
> > on no systems that anybody was bothering to test with. Having been
> > made aware of the issue I fixed it in this patch, you're welcome.
>
> You didn't just pick it for default events. You also picked it for
> when the user explicitly asks for "profile for cycles"
>
> > What is still not clear from this is what should the behavior be of:
> >
> > $ perf record -e cycles ...
>
> Why do you claim that?
>
> I've already told you that CLEARLY it's wrong to pick a cycles event
> that doesn't support 'record'.
>
> I've also suggested that you might look at core only PMUs.
>
> But more importantly, you should look at documented and historical behavi=
or.
>
> So what is your argument? Because from where I'm sitting, you keep
> making irrelevant arguments about *other* events, not about "cycles".
>
> It used to work. It doesn't any more.
>
> > Should it wildcard all events and open them on all PMUs potentially
> > failing? Well this has always been perf's behavior were the event:
> >
> > $ perf record -e inst_retired.any ...
>
> You keep making up irrelevant arguments.
>
> Lookie here: I do "perf list" to just see the events, and what do I
> get? Let me quote that for you:
>
>     List of pre-defined events (to be used in -e or -M):
>     ...
>       cpu-cycles OR cycles                               [Hardware event]
>
> and then later on in the list I get
>
>     general:
>       cpu_cycles
>            [Cycle. Unit: armv8_pmuv3_0]
>
> and dammit, your patch broke the DOCUMENTED way to get  the most
> obvious profiling data: cycles.
>
> So stop making shit up. All your arguments have been bogus garbage
> that have been talking about entirely different things than the one
> thing I reported was broken.
>
> And you *keep* doing that. Days into this, you keep making shit up
> that isn't about this very simple thing.
>
> Every single time I tell you what the problem is, you try to twist to
> be about something entirely different. Either a different 'perf'
> command entirely, or about a different event that is ENTIRELY
> IRRELEVANT.
>
> What the hell is your problem? Why can't you just admit that you
> f*cked up, and fix the thing I told you was broken, and that is very
> clearly broken and there is no "what about" issues AT ALL.
>
> So stop the idiocy already. Face the actual issue. Don't make up other th=
ings.
>
> Dammit, if I wanted "arm_dsu_58/cycles/", I would SAY so. I didn't. I
> said "cycles", which is the thing that has always worked across
> architectures, that is DOCUMENTED to be the same as "cpu-cycles", and
> that used to work just fine.
>
> It's literally RIGHT THERE in "perf list". Using "-e cycles" is
> literally also what the man-pages say. This is not me doing something
> odd.

But nobody else ever reported the issue, even ARM who maintain the PMU
driver whose event name conflicts. This hasn't been a problem for
anybody else.

> And yes, I use an explicit "-e cycles:pp" because the default is not
> that. and "cycles:pp" does better than the default.

This is wrong. cycles:P means use the maximum precision, so if the PMU
supports it it will use cycles:ppp and on x86 this is often the case.
The number of 'p's used after the event with :P is read from sysfs:
```
$ cat /sys/devices/cpu/caps/max_precise
3
```
The default using cycles:P is intentional and better than cycles:pp.
If `/sys/devices/cpu/caps/max_precise` is wrong for your PMU driver
then that should get fixed.

> Again, this is all documented, with "man perf-record" literally
> talking about "-e cycles" and then pointing to "man perf-list" for the
> modifier details, which detail that 'pp' as meaning "use maximum
> detected precise level". Which is exactly what I want (even if on this
> machine, it turns out that "p" and "pp" are the same because the armv8
> pmuv3  doesn't have that "correct for instruction drift" that Intel
> does on x86).
>
> Why is this simple thing so hard for you to understand?
>
> The fact is, if you make "cycles" mean ANYTHING ELSE than the
> long-documented actual obvious thing, you have broken perf. It's that
> simple.
>
> So stop the excuses already. Stop making up other stuff that isn't
> relevant. Stop bringing up events or PMU's that are simply not the
> issue.
>
> Face your bug head on, instead of making me have to tell you the same
> thing over and over and over again.

I keep saying the same thing as I don't agree with you, you have
broken perf in 6.10 and are presumably looking to me to pick up the
pieces. To work around the naming conflict on systems with
arm_dsu_*/events/cycles/ I don't think it is unreasonable to specify
armv8_pmuv3_0/cycles/, the blame for this lies with ARM's event name
within the arm_dsu_* PMU driver, admittedly they didn't know this
would be an issue given perf's non-uniform handling of legacy events.
When ARM requested that legacy events be a lower priority than
sysfs/json then the ball was set in motion for this problem. This was
done to work around an ARM PMU problem on Apple ARM CPUs.

Let's say an Apple CPU has a PMU called armv8_pmuv3_0. If you try to
program a legacy event on it then it will be broken - I lack a system
to test this but I'm reliably informed (user bugs and by ARM) and heck
it was a bunch of work to get this working if it was for nobody. To
fix this perf must read event data for armv8_pmuv3_0/cycles/ from
sysfs. If you don't specify a PMU then perf will try to program a
legacy event. This is the behavior in Linux 6.9. Oh, but legacy events
are broken on my Apple ARM CPU. The change made it so when you don't
specify a PMU you will use the sysfs/json one first instead of the
legacy one. Viola, your favorite `perf record -e cycles:pp ..` should
be fixed on Apple ARM CPUs.

So I think the revert is a real regression for a larger user base.
There is a testing issue here, not least I don't possess an Apple ARM
machine. All of these issues revolve around ARM and yet they do
minimal to try to fix them, beside complain that I should fix the
legacy/sysfs/json issue which is how we got here.

There's of course the alternate universe view that I need to admit I'm
wrong and I should stop going out of my way to break people. Hello
alternate universe, I admit it, I'm wrong and a terrible person please
accept my most sincere apologies. Please alternate universe, can you
tell me how to wild card event names and make them work across PMUs
without the behavior being specific to certain perf comands or event
names (which I think is worse than having to specify which PMU you
think the event should apply)?

Thanks,
Ian

>                    Linus
>

