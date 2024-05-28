Return-Path: <linux-kernel+bounces-193125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496CE8D272C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C77286689
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9654017BB1D;
	Tue, 28 May 2024 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Tb7fR9MA"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A90D17B414
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716932249; cv=none; b=lzNxG8Z+lZllTHT/exTHFifycbWqu9ylgjw2yjI/KKY9B6puVThfzcc5yhkUgCjCk7CmCDLRzO2TSAoWTpuZagqYAiMJ6XGddLNGn3WqXAcSghoMFianBj7cNW862WkVDRCNxq7g4WAHaRzTtbdMKl55G5WBr0JTfq7VEfmLWQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716932249; c=relaxed/simple;
	bh=SsDxcfoFmVudU5qcwetcdxdS1LKnErpH8kSgxXfkkAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBOXMsGLAKVbbpD/jI8jSV9o0oq01JmXTTChs32O9J8XR0a3EK1dppk77IwTvYnC+y+2BsTfDQAp6KWKmtp+YQBK7CsInrfRLjtaJqDJVsX++CYm7cT6i0F5TIKsoKblJ7KSWrMQGVKqQE89/YAuGfWRs5WaaY3bvsRkLVm3HvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tb7fR9MA; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43f87dd6866so123731cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716932247; x=1717537047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPwGfiPlf+WqkvXaVakNOlRGi5pamM/ueJ5jAwmmZSs=;
        b=Tb7fR9MASa1cLVQEtvycGhIWUlpBqPVx5l6R0DreLHR9MscRteqZ0lXLZGKpCUUOHx
         MRR96/papJswYGarZFUo7pc0QWrlEosJVTdMvcd3Cqj7jKWYHLejeKy1A9N4p3rlnl54
         3klME8OujkABg4AlFaZNYFgafr20IPlTHI3tkfgC5LD77hhk/g053ex/qC/m5ejLiPMo
         SgduQJIbXWb+1G6xbyUt3uGmqbhziJUExjF4ND4/URcgqSTZE0QxHQ0um/TDx2/EHtr3
         S0RABS0ny6UrC0NOX45i/mb49Efb291xB6f+CN9vx3p/P4dHEZ12JlKd9Jdn8w39RQWR
         /Bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716932247; x=1717537047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPwGfiPlf+WqkvXaVakNOlRGi5pamM/ueJ5jAwmmZSs=;
        b=kit7hveEjGUqhsf7QpujEY+3cuM3dTSoa8GoDpyga3D+GdPHvhL8yszNcmDJyLExcH
         AqFVsfiN6/FG6XE6w1UfXcZACfZ24m4PvGHTt/K802nM6BIuOk3qMDcFpJZ2rq3cvZZo
         PiZPz8gIC3zOTHh7rZW0PW9E7TMtoqMLdN6fSuHunwPBnXCL/tLGqMrl8KGkdo/PUXsk
         y0wSkaNPdGZPcZpC0/pEmL7R2GYLjhXX7n+IqE54bxvFAu/eL/e+gItjuMljJ7txnueF
         FXRxJ/33OuYrXvjwRKhBHcMVGSbs69n5xcVJEZ0YPvVk0hecDqKS+jdiVlmqaNEhP8TO
         a3mg==
X-Forwarded-Encrypted: i=1; AJvYcCW/LDjWq1LxKiO2fDgIOGRQFJ3DlpdTnv4uJJ4y6yPgdquatOLSCKTMGCezuF3LqcSV6qP/vEspba6rKmBSPg1Dj+zcuD/Zxt96YyP7
X-Gm-Message-State: AOJu0Yw8MdTkMzq2Wiqb1KWGDbYU90/dTpKGXa/L2Tt+F7ARXSXHKvQq
	V9RG7QEQKXd3WRy0KvzVZIZaS9yDiiFOrFX7zjgTAicmY7VFTuRGM/oMTkzUAX98XRlq0/cn+cI
	knbx6R9EH4hF8fiaO0iNz2hAYdv26+n0zcdyr
X-Google-Smtp-Source: AGHT+IEPX/gImccRtXhjiUA8F0Ssi6h+jKt/Gp5bvVZRreU65jVp/PjHyS8RiZ/C6Y8Ra0yIfpdRg4rUxwfPlBlOA2A=
X-Received: by 2002:a05:622a:618a:b0:43f:dbfc:1f1b with SMTP id
 d75a77b69052e-43fe0f8fd09mr451991cf.18.1716932246737; Tue, 28 May 2024
 14:37:26 -0700 (PDT)
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
 <CAP-5=fUp+gSoLC90vT50X7So_SyAC9OprAMvh_Jj_8NTuO6j_w@mail.gmail.com>
 <CAHk-=wiDheOd3pdZ4vdLwrMbbVs3LUcSD=afASEWbND-HZhuPA@mail.gmail.com>
 <CAP-5=fVGF6A7fwZyF8o0Sz5nNhtXb0007JoCxaiL2XHCKS3=0A@mail.gmail.com>
 <CAHk-=wh2yboV-UtCO_NFV2TsbbMeHTw0Fqn4rnovbGQzkZLCJg@mail.gmail.com>
 <CAP-5=fUwcgsB-AruAmGhw6WVNViMaiJ_iHWuZ8=ksrN7Y3V9QQ@mail.gmail.com> <CAHk-=wgtb7y-bEh7tPDvDWru7ZKQ8-KMjZ53Tsk37zsPPdwXbA@mail.gmail.com>
In-Reply-To: <CAHk-=wgtb7y-bEh7tPDvDWru7ZKQ8-KMjZ53Tsk37zsPPdwXbA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 May 2024 14:37:14 -0700
Message-ID: <CAP-5=fUQLxt1X6QASNf0Bop+vjam28HsD9ua9ODEd2xnAst5Wg@mail.gmail.com>
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

On Tue, May 28, 2024 at 1:33=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 28 May 2024 at 13:03, Ian Rogers <irogers@google.com> wrote:
> >
> > But you've traded a fix for one set of users with a fix for another.
>
> No.
>
> You don't seem to understand what "regression" means.
>
> The "no regressions" rule is that we do not introduce NEW bugs.
>
> It *literally* came about because we had an endless dance of "fix two
> bugs, introduce one new one", and that then resulted in a system that
> you cannot TRUST.
>
> We had years of this with suspend/resume in particular, where the
> argument was always exactly "this fixed many more systems" when
> something else broke.
>
> But because random other things kept breaking, it meant that people
> couldn't upgrade the kernel and feel safe about it.
>
> Your old laptop might no longer work, because somebody had deemed that
> all those *new* laptops were more important.
>
> So I introduced that "no regressions" rule something like two decades
> ago, because people need to be able to update their kernel without
> fear of something they relied on suddenly stopping to work.
>
> The fact that the "suddenly stopped working" may be a minority DOES
> NOT MATTER ONE WHIT.
>
> Stability matters.

I think stability in the context of this problem is an abstract term
especially given the low amount of ARM support for PMUs. Does it
matter more that between Linux 6.9 and 6.10 `perf record -e cycles:pp
.` which is objectively worse than just `perf record ..` (which is
fixed by the patch) work on a Neoverse N1, or someone who is running
Linux on an ARM Apple machine is able to run `perf record -e cycles:pp
.` without triggering a PMU driver bug? Which user is making the
strange request and whose stability matters more?

A phrase I think I coined was the Beyonce principle, she said in a
song, "if you like it, then you should've put a ring on it." The
principle in software is that if you want something then you better
put a test on it - this made it into Titus Winter's book unattributed
so maybe it wasn't me :-). I've been helping drive testing in the perf
tool. If we don't follow the Beyonce principle we're held hostage to
Hyrum's law, "With a sufficient number of users of an API, it does not
matter what you promise in the contract: all observable behaviors of
your system will be depended on by somebody."

Something we could do is rename the ARM dsu PMU's event from cycles to
clockticks (as is conventional in existing PMUs) and then have a test
to enforce that no PMU has events named cycles.

Making this a driver bug doesn't satisfy the desire to shout at the
person whose change exposed the latent issue, but maybe that's the
right fix.

> It's MUCH MUCH better to have legacy bad behavior that you never dealt
> with correctly, than to introduce *new* bugs that hit something that
> used to work.
>
> So something that "perf" has never done correctly is simply not an issue.
>
> You deal with that by saying "that has never worked properly before eithe=
r".
>
> You might even document it along with (hopefully) possible workarounds.
>
> The whole "one step forward, two steps back" is absolutely fine if you
> are line dancing.
>
> But we're not line dancing.
>
> We take it slow and steady, and if you can't fix something without
> breaking something else, then that thing simply does not get fixed.
>
> And there are always exceptions. Sometimes something may need to be
> broken because it's an acute security issue.
>
> And if it takes a year for somebody to find a regression, and in the
> meantime others have started relying on the new behavior, then at some
> point it's a "yes, that's a regression, but it wasn't reported in a
> timely enough manner".
>
> And sometimes the use-case is basically a museum machine and we retire
> support for it because such a machine should use museum software too.
>
> So it's not like it's some long-term absolute guarantee. But it
> absolutely *is* the #1 rule in the kernel.
>
> A fix that breaks something else is not a fix at all.
>
> And in this case, when the regression was noted within days, and
> within the merge window, there's simply no discussion about it.

We moved development to being in perf-next automatically merging to
linux-next because (as I understand it) there was a complaint of new
possibly untested features coming in during the merge window. If IBM
can test s390 on linux-next and post about breakages in the perf tool,
why is this beyond the people who support and use Neoverse N1s? Why
use linux-next if nobody is testing there?

Thanks,
Ian

>               Linus
>

