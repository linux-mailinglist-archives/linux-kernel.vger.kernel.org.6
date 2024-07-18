Return-Path: <linux-kernel+bounces-256525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDD0934FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2601C21552
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD0F143C60;
	Thu, 18 Jul 2024 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JqPirRKf"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1AC2A8FE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315562; cv=none; b=rtTNdkm72kA3vl3fw0Z7f95MgG/q6xCC5YF6AU3t7dEgtHFjKbhtPDmkpq5FSCZv1hfo9qI77RodqhHwr62xcdcpVIbcN3ec5kieI+ebjLEdCcsif0F5v8uBbXQsS0VMTGm+yDGjjU8GPBJGLyR2A+WmWT8T1dA5dF4prVIq5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315562; c=relaxed/simple;
	bh=vpnk/Ml68wNsV3YCDkRmeDyUgYOqV5PsMUdDY82bZZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjuprWKyXYLGt1oWFs4IH3OE29IoiCHqukcjtb4YpM/Ngcxlb3e0BZ9AxkbuBthWYchUGtUMQXVtD7hf0L9f9UWbYFPyQL8wIbFmE/n1zuoF3FntExsLi4oqMwYNCdzuGDU8iFXbUlgVVfO8EE3YIpEMOoIHqHKCyZTOrEUVbC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JqPirRKf; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3815ad8adc9so162505ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721315560; x=1721920360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1uVC0gEc7ytXHhe/ddZaTs4m7NnErpAclBKBE12jhQ=;
        b=JqPirRKfxIyHiP5Y7Cp2udHnM8o+4hK7sBqKr0bsweaJbOc446yaeUXird/1Zki2Ua
         CcqTQ3/d0YS92WQRfghRe1rwxLDyykxTtlBw+mvezx3lRu1/LM/ak4o5vkNszNR/27JN
         bL+lZlIs1+YVFoOqSkzc2U65IDdylboFMZR2N0XcbQZE+LsIqh+qZnPsVmkKBHprj0d0
         AIIC1U1OgYLv4SS3mfPiHyLnv7BkatPLZ84uhtri6+BYuKtVMqMXkuRI68KQTWOPnJYs
         54fJxpUcz62PiVLOdCz0kMAuIAYfrifOw4OMepn6tpo/FGQh8B4DjH5rTfnmRT4zppOd
         otDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721315560; x=1721920360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1uVC0gEc7ytXHhe/ddZaTs4m7NnErpAclBKBE12jhQ=;
        b=mzZkJ4ZATxDpu07sonKyAKGYzFtoCcrZElXDXu26gKGLqGjUXnwVACKln80Rw+COe4
         fFmJauchAUexwIJ9DGADZsRGNnMJGgFwb+QHgDUcj0y9lOCa3DyT8SUpUgp0oOgPIJfq
         y1ufQ0oFUfOJK1KYeFFCDQXEF1C66gmndSX9wIuTgR1JYlDFlvKlmMV1D5bbgId2iDU5
         BMJar8IGhZ0X5p2sjM0zDUwsh3WMsITmEIz0CsT3U8LNrEHz7eTOfB18CRkYqEuJ7fCs
         YwXahi1MFWiP8sB4YS1vAs6CQToUF8DT6aCjLqjZvjyd4V4FrC15A+/gdxjCbAyN385g
         OZjw==
X-Forwarded-Encrypted: i=1; AJvYcCVWnrABdeOAxcOWmAEoLamFIGPz4v/x5RDGaruDrGkFtNhu/pXEkwXAx0kGKIQPVzLgxuUJV6lSHyXr2Sb8DNE0LE7rD1ii9S2QUYY+
X-Gm-Message-State: AOJu0Yz/LkSfKeEnaRO1mpAao8u+FvIfXjslLKhNTuE+E5kvaL357N5s
	sqW9Llf2+b/0zg8SvVaqqd4yoMK7VA13qDE3+y4sR8ZwaSQpXhD4ZT2efwMgSqLiOe4PIDitxko
	aFRqbTApXdmBzLI5j3G7Jgd5SrzbGvjpHcbwQ
X-Google-Smtp-Source: AGHT+IFa5I5DOiVGOvwoKlGw6AmBXgPdW/uZdu3AmcpjU7mnxwdSOU1I+Rv4p0v9bZ9wfaiQWkMwNeGJYQ5IhfVGIHI=
X-Received: by 2002:a05:6e02:154c:b0:383:de0e:88e5 with SMTP id
 e9e14a558f8ab-39699ad7d16mr2195805ab.26.1721315559524; Thu, 18 Jul 2024
 08:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com> <20240718003025.1486232-7-irogers@google.com>
 <febefab7-7351-4bd5-a6cc-a0116248484f@linux.intel.com>
In-Reply-To: <febefab7-7351-4bd5-a6cc-a0116248484f@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Jul 2024 08:12:27 -0700
Message-ID: <CAP-5=fUUcehu-C=ytHVVixOpeCYoW4oJkkj6p6W=M0HtQ2wrRA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] perf parse-events: Add "cpu" term to set the CPU
 an event is recorded on
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 7:41=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-07-17 8:30 p.m., Ian Rogers wrote:
> > The -C option allows the CPUs for a list of events to be specified but
> > its not possible to set the CPU for a single event. Add a term to
> > allow this. The term isn't a general CPU list due to ',' already being
> > a special character in event parsing instead multiple cpu=3D terms may
> > be provided and they will be merged/unioned together.
> >
> > An example of mixing different types of events counted on different CPU=
s:
> > ```
> > $ perf stat -A -C 0,4-5,8 -e "instructions/cpu=3D0/,l1d-misses/cpu=3D4,=
cpu=3D5/,inst_retired.any/cpu=3D8/,cycles" -a sleep 0.1
> >
> >  Performance counter stats for 'system wide':
> >
> > CPU0              368,647      instructions/cpu=3D0/              #    =
0.26  insn per cycle
> > CPU4        <not counted>      instructions/cpu=3D0/
> > CPU5        <not counted>      instructions/cpu=3D0/
> > CPU8        <not counted>      instructions/cpu=3D0/
> > CPU0        <not counted>      l1d-misses [cpu]
> > CPU4              203,377      l1d-misses [cpu]
> > CPU5              138,231      l1d-misses [cpu]
> > CPU8        <not counted>      l1d-misses [cpu]
> > CPU0        <not counted>      cpu/cpu=3D8/
> > CPU4        <not counted>      cpu/cpu=3D8/
> > CPU5        <not counted>      cpu/cpu=3D8/
> > CPU8              943,861      cpu/cpu=3D8/
> > CPU0            1,412,071      cycles
> > CPU4           20,362,900      cycles
> > CPU5           10,172,725      cycles
> > CPU8            2,406,081      cycles
> >
> >        0.102925309 seconds time elapsed
> > ```
> >
> > Note, the event name of inst_retired.any is missing, reported as
> > cpu/cpu=3D8/, as there are unmerged uniquify fixes:
> > https://lore.kernel.org/lkml/20240510053705.2462258-3-irogers@google.co=
m/
> >
> > An example of spreading uncore overhead across two CPUs:
> > ```
> > $ perf stat -A -e "data_read/cpu=3D0/,data_write/cpu=3D1/" -a sleep 0.1
> >
> >  Performance counter stats for 'system wide':
> >
> > CPU0               223.65 MiB  uncore_imc_free_running_0/cpu=3D0/
> > CPU0               223.66 MiB  uncore_imc_free_running_1/cpu=3D0/
> > CPU0        <not counted> MiB  uncore_imc_free_running_0/cpu=3D1/
> > CPU1                 5.78 MiB  uncore_imc_free_running_0/cpu=3D1/
> > CPU0        <not counted> MiB  uncore_imc_free_running_1/cpu=3D1/
> > CPU1                 5.74 MiB  uncore_imc_free_running_1/cpu=3D1/
> > ```
> >
> > Manually fixing the output it should be:
> > ```
> > CPU0               223.65 MiB  uncore_imc_free_running_0/data_read,cpu=
=3D0/
> > CPU0               223.66 MiB  uncore_imc_free_running_1/data_read,cpu=
=3D0/
> > CPU1                 5.78 MiB  uncore_imc_free_running_0/data_write,cpu=
=3D1/
> > CPU1                 5.74 MiB  uncore_imc_free_running_1/data_write,cpu=
=3D1/
> > ```
> >
> > That is data_read from 2 PMUs was counted on CPU0 and data_write was
> > counted on CPU1.
>
> There was an effort to make the counter access from any CPU of the packag=
e.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dd6a2f9035bfc27d0e9d78b13635dda9fb017ac01
>
> But now it limits the access from specific CPUs. It sounds like a
> regression.

Thanks Kan, I'm not sure I understand the comment. The overhead I was
thinking of here is more along the lines of cgroup context switches
(although that isn't in my example). There may be a large number of
say memory controller events just by having 2 events for each PMU and
then there are 10s of PMUs. By putting half of the events on 1 CPU and
half on another, the context switch overhead is shared. That said, the
counters don't care what cgroup is accessing memory, and users doing
this are likely making some kind of error.

Thanks,
Ian

