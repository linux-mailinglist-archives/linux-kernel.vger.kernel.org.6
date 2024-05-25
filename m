Return-Path: <linux-kernel+bounces-189375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BBF8CEF3A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 16:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560E71C20926
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 14:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E881F4DA13;
	Sat, 25 May 2024 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JfeJQdVa"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC2C55C1A
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716646174; cv=none; b=ItyZju6gtdQhJaQVV3SLldBp3IdTI4UP9LcBF+nT6IoDfdCC/U1mUNhFsediVNv+Bmu81ApRYi2ASDRtZlDfmFQQTZ+R/DjdfAxOHpyVoaOHZL4gNMSnJIe+H89aYiQePzxn4mc6Inj3TR9Y/i5otOqYhHtaLqF8K3sqaU1mJjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716646174; c=relaxed/simple;
	bh=9AB3F+ERpeNgpHuSA/LmQ68qrAHdgCH0rbQPc3A19C4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X16JwDxoN5jiWhfRhEb6SwHhCY9JvKztffkfbtlEgB340aeGfVpMKHRuepvvVnUQvjqe+wyOzSoJxQjQfmWstsZ3CdF6VeJ03h263ElfM1bm06CXzgivXNNomBVVUUniERNOrLWs+gaTFx/Hv1G6NQfO+rWd+/Khhj1w36LkK50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JfeJQdVa; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36db863679bso92545ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 07:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716646170; x=1717250970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhqZJUOejfkCvi+8WQ97T+9L3dgb+ZhC9CuNx3x7Y5k=;
        b=JfeJQdVaPDDRqaDFp3aHqgbnq8m99oxcwMxmHy7tJCmDS4DlQfrDwoxZkmoHed/qFs
         EW+R/yKEAQc6TarD+FlhY27iNnMVccZiFzb3blO2N1CWKa3/0tyhR6MrfflNIKM0bVkj
         FVTZm+ArCySxiOoZ6MAl93adqkfJv7ItSNaqjnT3zDR0tQsH28fJZc/++oSEdeX3C5PF
         Htc5MSpzflpPjX9opP5sYWS1EhjRBNfatQM8myrCcRU20CQK1wZDOQAdd+VbuEyADlLc
         fTTQc97IUrdsb//wuqECF60Os9GI3d9SHp5NRN27gULOzvVT4wS9rONhYg3Wvo8+xh1c
         qDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716646170; x=1717250970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhqZJUOejfkCvi+8WQ97T+9L3dgb+ZhC9CuNx3x7Y5k=;
        b=ou0N2iuPCZAH7HzA+qfTcpTjggKIzH3jla2ZfQ1C/sT6uRwg8NWhgdJAp3jqJLl47B
         BTwbYYQyBKZxqVvY6e/f27mokr433F2Y4WMx8ul56fOC+9FNhgFep7mwCojnk92TPodG
         WHLg2q4aV7St/rSxobZ9d05T0ZzRsyAQ7akKbFObDNIPNK5VLW5y30h8KauggPNX5df3
         9+pmsKehDfXkdAU5nzrc8uVA4tz3GUMauPz/8YkodKRUF4DfaZSOifOg01+Jn3VHqhbJ
         03gpWvS/KUvLAI+y6B1CQ7nh9dVrNItEpDY1EWPLpvYO11BE9ZH7pejICLuxhoAedRFa
         EFVg==
X-Forwarded-Encrypted: i=1; AJvYcCWiujlMA+v6z/Wpqu+WNomFVZ7dUAmbtoK7mkRFDBAzz3oScjg+QehgWUs6LfPTYOdmskIn4OBRN7/vkduJUFIFsOWQ1grUmnMjzdxn
X-Gm-Message-State: AOJu0YxKmR7KMAbxSe9eFa/y7CjNcAbCMn9LOGqYztvgb1yj51v90BpB
	IKXPaHsxaHHF8MDmtqgLtSYo15nrvCazOKDL/kGGCft57aaeIdUTi2UbBd7NpA18xT+7+yiTc/N
	43F/O7gspNJ6QMGGrMpJoA9kfm53aKc2gUcgS
X-Google-Smtp-Source: AGHT+IHF3UOqk63Ap5kc83idT/QbuIH4w9EjhqgctPC+S356f6TJ3LRsJ5FLjAdwUyQtn+68L2808l5lIeQhsirgkGk=
X-Received: by 2002:a92:c991:0:b0:36c:7fe9:333f with SMTP id
 e9e14a558f8ab-3738a749048mr1820085ab.14.1716646170263; Sat, 25 May 2024
 07:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521192614.3937942-1-acme@kernel.org> <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
 <ZlFE-wbwStOqt8Ra@x1> <ZlFGpxWGQskCTjeK@x1> <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
 <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
In-Reply-To: <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 25 May 2024 07:09:18 -0700
Message-ID: <CAP-5=fVFJNqYaQNekrWNVRg8=_2K0T-WKZ=8-iafU4CCfUCXSA@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Anne Macedo <retpolanne@posteo.net>, 
	Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 9:20=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 24 May 2024 at 20:48, Ian Rogers <irogers@google.com> wrote:
> >
> > Thanks for the report. TL;DR try putting the PMU name with the event
> > name, so "cycles:pp" becomes "armv8_pmuv3_0/cycles/pp", where
> > armv8_pmuv3_0 is the name of the PMU from /sys/devices.
>
> What? No.
>
> If that is the new rule, then I'm just going to revert. I'm not going
> to use some random different PMU names across architectures when all I
> want is just "cycles".

The issue is that perf previously would do two things, if you asked
for a 'cycles' event then as the name was a legacy one it would encode
the type in the perf_event_attr as PERF_TYPE_HARDWARE and the config
as PERF_COUNT_HW_CPU_CYCLES job done. With BIG.little/hybrid/.. those
events now need opening on multiple PMUs otherwise you end up only
sampling on either the big or the little core. On Intel with hybrid,
cycles had to become cpu_core/cycles/ and cpu_atom/cycles/.

If we look at an event name that isn't a legacy one, like
inst_retired.any, then when no PMU is specified perf's behavior is to
try to open this event on every PMU it can. On Intel this event will
be found on the 'cpu' PMU, or on a hybrid Intel on cpu_core and
cpu_atom. Were the event 'data_read' then it could be found on the
uncore_imc_free_running_0 and uncore_imc_free_running_1 PMUs. My point
here is that wildcarding an event to every PMU that supports it is
arguably a feature as it avoids users needing to remember a specific
PMU name. PMU names are often duplicated and it would be laborious to
name them all.

> In fact, the "cycles:pp" is a complete red herring. Just doing a simple
>
>  $ perf record sleep 1
>
> with no explicit expression at all, results in that same
>
>   Error:
>   cycles:P: PMU Hardware doesn't support sampling/overflow-interrupts.
> Try 'perf stat'
>
> because perf *ITSELF* uses the sane format by default.
>
> So ABSOLUTELY NO. We're not changing the rules to "You have to know
> some idiotic per-architecture JSON magic".
>
> I don't want any excuses like this. No "You are holding it wrong".
> This is a BUG. Treat it as such.
>
> And yes, "perf record -vv" shows that it apparently picked some insane
> arm_dsu_0 event. Which just shows that trying to parse the JSON rules
> instead of just having sane defaults is clearly not working.
>
> So here's the deal: I will revert your commit tomorrow unless you show
> that you are taking it seriously and have a sane fix.
>
> Because no, "You are holding it wrong" is not the answer. Never was,
> never will be. Things used to work, they don't work any more. That
> shit is not acceptable.

I wasn't trying to say you were holding it wrong, I was trying to give
you practical advice that would solve your problem whilst we determine
what the right fix is.

The question is what to do about events when no PMU is specified, here
are the alternatives I see:

1) make legacy event names special and only open them on core PMUs,
2) make sure PMUs, like arm_dsu_0 in your case, don't advertise events
matching legacy names like cycles,
3) make perf record only scan PMUs that support sampling,
4) in the case that we're using cycles:P as a default event, only open
that on core PMUs (on Intel make cycles:P ->
cpu_core/cycles/P,cpu_atom/cycles/P).

A revert achieves (1) and I consider it a regression as now the
behavior of 'cycles' doesn't match 'inst_retired.any' and the user
somehow needs to know that certain event names are special.
Changing the driver (2) is a workaround, but it feels like a burden on
the driver writers.
In order to determine whether a PMU supports sampling (3) we'd need to
try probe using perf_event_open. The perf_event_open may fail due to
things like host/guest permissions, etc. so we need fallbacks. We do
something similar here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/util/print-events.c#n242
(4) is the simplest change and I think it lowers the surprise from the
behavior change in the patch. It means that were you to do "perf
record -e cycles ..." you would still need to specify a PMU on Linus'
special ARM box. We may lack permissions to read sysfs and so then it
is hard to determine the PMU name, but the code was likely to fail
then anyway.

I'll write a patch to do (4), hopefully this qualifies as being
serious, but it would be useful if the interested parties could work
out what they think the behavior should be.

Thanks,
Ian

>                    Linus
>

