Return-Path: <linux-kernel+bounces-192856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F818D2320
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2AA1C228E5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF4E4CDEC;
	Tue, 28 May 2024 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EARHVhWq"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB51547F6C
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919952; cv=none; b=N2wGH4fgL+jQIdgs/Ee0WlkyNOjmVwCs+CXgd/jBMJ1XlCa53krXgNAaxpQlri3MwqSXpdMMf6wTphVLHeyhNyDpVU5mBBKcQkuCR6LhnVFbQZLjCZq7OsLFCh5q0daomNSAVlFOV+GkQh9PvYEMx70X1pxeHzS/DHOhUWwL9FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919952; c=relaxed/simple;
	bh=uBFofHxY79sXdXXq73E6gE3Zjpo2XLY4SFJJWjwUqS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EajdM2rWYg21hNw1GIVJciUSZbI236YPSi6slDOKbZW9CWeD/9sUty7adnu9umnEpXH+e2TgEuJxkQb0vab7KmkvvpueaIK+zPAbh7qM9P/mmD2WeTRz5PUXS3jOqqFH2Qxu/CmFakSq0UtnBmBvdBHbY+iZ39mjqJDOQkbUb9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EARHVhWq; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57857e0f464so1622910a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716919948; x=1717524748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HWWwKaisjyRPFI3vZm/ptH496eo+7DY2MiI53H9w4ls=;
        b=EARHVhWq1Q4YvaLt6Tzxy/pgGBiVbplorBwK3/ygFEE5JGc3w/HTZQU1pV4SWnN1WC
         nulmHQibGiXD49SAob+TsJ3xLqYUz0ohixfQwk9sjiAiZdtr7FBQgU8LeZZiTnlTqWD6
         9O231ltWPP8ODtlUqKqxIjckhwuf5nNxEpXbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716919948; x=1717524748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWWwKaisjyRPFI3vZm/ptH496eo+7DY2MiI53H9w4ls=;
        b=ZzuYajyDJ8UcTp1V5aofQFPVTNZWVjAJw7h4u89VEE7CDbYZrb2dEVWr1j6WGvjo2c
         pgQdDoLhukDsBEJj2ZGzP57ZfIrwpukB4ssMmRQtHVfJVP4gAOvCxRUzZSxosmtJLYvT
         Ii2aabqJBHM4FI/fOVuaBjeFQxzzHmzPZtUMk52pq+jkBxhYTUtg3N2uMTL5dKy0pIBS
         FHisacWTjcvLPee5/nwolIAJl6bqld1pCpH1IjGsjnsePuViAWA9CHniQzVETSvqFCcL
         bZ24yX1V9aC9cPM9HmYlI9ld4AT3hq8kRNNgVx8LPx0rPLXZ7TxMjyvLfZZhVS0in47q
         z+ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUel4m5qZmK5n/Dd/hSR92n5SmYAgOkml8jjPlKfwu1NxgMET19Y+NivSWVdgfAste1a3uA4LtJQjE8LOPaaY9Tn9UsrqMcxbzMSnb
X-Gm-Message-State: AOJu0YwMmMKd35tDixTSoCN3E7gUF42Ez2tGC8QEuQi9JYUnrZCZ22DQ
	i0Iew0ZOWp1R9fO2rIOrrI8KjC157wuCPSs7B1k6UaSxHTbcpJc3yBOaX6R3Th8kzlcqtZV+aJa
	VZTckrg==
X-Google-Smtp-Source: AGHT+IFCKcPBXqpALdEktjteiVzeL4/WNsOi/xs7ZvOdx9S8EZHM9U607ZA2s64X08ZZFz8/86m1kg==
X-Received: by 2002:a50:c30d:0:b0:578:5f9f:89ea with SMTP id 4fb4d7f45d1cf-5785f9f91b2mr8665445a12.31.1716919948217;
        Tue, 28 May 2024 11:12:28 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57967499969sm4984513a12.22.2024.05.28.11.12.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 11:12:28 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6267778b3aso123165866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:12:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZWjQdMHOzjXaPVFQw/GeXVhNzLvHBLuDc16Nakon89u6BGkCL6bg8EWZ2STpy+USQR+HoYayXQJ9FvcovYt2SpvdmRCsRPTVfDHKJ
X-Received: by 2002:a17:906:9b1:b0:a63:3170:14ae with SMTP id
 a640c23a62f3a-a6331701592mr183130366b.9.1716919947490; Tue, 28 May 2024
 11:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev> <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <CAHk-=wgcoODsCbba423uZwQqOjJ8r29GZyCd472K6L6Dt-NbPg@mail.gmail.com> <CAP-5=fUp+gSoLC90vT50X7So_SyAC9OprAMvh_Jj_8NTuO6j_w@mail.gmail.com>
In-Reply-To: <CAP-5=fUp+gSoLC90vT50X7So_SyAC9OprAMvh_Jj_8NTuO6j_w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 May 2024 11:12:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDheOd3pdZ4vdLwrMbbVs3LUcSD=afASEWbND-HZhuPA@mail.gmail.com>
Message-ID: <CAHk-=wiDheOd3pdZ4vdLwrMbbVs3LUcSD=afASEWbND-HZhuPA@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 10:40, Ian Rogers <irogers@google.com> wrote:
>
> I agree it picked the wrong PMU for default events. This was a problem
> on no systems that anybody was bothering to test with. Having been
> made aware of the issue I fixed it in this patch, you're welcome.

You didn't just pick it for default events. You also picked it for
when the user explicitly asks for "profile for cycles"

> What is still not clear from this is what should the behavior be of:
>
> $ perf record -e cycles ...

Why do you claim that?

I've already told you that CLEARLY it's wrong to pick a cycles event
that doesn't support 'record'.

I've also suggested that you might look at core only PMUs.

But more importantly, you should look at documented and historical behavior.

So what is your argument? Because from where I'm sitting, you keep
making irrelevant arguments about *other* events, not about "cycles".

It used to work. It doesn't any more.

> Should it wildcard all events and open them on all PMUs potentially
> failing? Well this has always been perf's behavior were the event:
>
> $ perf record -e inst_retired.any ...

You keep making up irrelevant arguments.

Lookie here: I do "perf list" to just see the events, and what do I
get? Let me quote that for you:

    List of pre-defined events (to be used in -e or -M):
    ...
      cpu-cycles OR cycles                               [Hardware event]

and then later on in the list I get

    general:
      cpu_cycles
           [Cycle. Unit: armv8_pmuv3_0]

and dammit, your patch broke the DOCUMENTED way to get  the most
obvious profiling data: cycles.

So stop making shit up. All your arguments have been bogus garbage
that have been talking about entirely different things than the one
thing I reported was broken.

And you *keep* doing that. Days into this, you keep making shit up
that isn't about this very simple thing.

Every single time I tell you what the problem is, you try to twist to
be about something entirely different. Either a different 'perf'
command entirely, or about a different event that is ENTIRELY
IRRELEVANT.

What the hell is your problem? Why can't you just admit that you
f*cked up, and fix the thing I told you was broken, and that is very
clearly broken and there is no "what about" issues AT ALL.

So stop the idiocy already. Face the actual issue. Don't make up other things.

Dammit, if I wanted "arm_dsu_58/cycles/", I would SAY so. I didn't. I
said "cycles", which is the thing that has always worked across
architectures, that is DOCUMENTED to be the same as "cpu-cycles", and
that used to work just fine.

It's literally RIGHT THERE in "perf list". Using "-e cycles" is
literally also what the man-pages say. This is not me doing something
odd.

And yes, I use an explicit "-e cycles:pp" because the default is not
that. and "cycles:pp" does better than the default.

Again, this is all documented, with "man perf-record" literally
talking about "-e cycles" and then pointing to "man perf-list" for the
modifier details, which detail that 'pp' as meaning "use maximum
detected precise level". Which is exactly what I want (even if on this
machine, it turns out that "p" and "pp" are the same because the armv8
pmuv3  doesn't have that "correct for instruction drift" that Intel
does on x86).

Why is this simple thing so hard for you to understand?

The fact is, if you make "cycles" mean ANYTHING ELSE than the
long-documented actual obvious thing, you have broken perf. It's that
simple.

So stop the excuses already. Stop making up other stuff that isn't
relevant. Stop bringing up events or PMU's that are simply not the
issue.

Face your bug head on, instead of making me have to tell you the same
thing over and over and over again.

                   Linus

