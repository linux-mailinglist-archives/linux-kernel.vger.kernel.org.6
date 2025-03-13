Return-Path: <linux-kernel+bounces-559905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B79A9A5FAF7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD7F3A5C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9A626A0B3;
	Thu, 13 Mar 2025 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GW+PyTZO"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF4B268FF9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881684; cv=none; b=p1K3YzVLdDygtSPG1VKrcSZLzTl11hcDOd2bjUZJ2KnSe9fzGwz5yeiJGDRfFAxwd+lqE4vkvU3BSlPBYceYiUK5b78GJftoFd8LN6kCSEZZXvN6oI6bJAE8LnAxraxZf7DmW7luDzwTeUgamAtGOCaH2Xus3Mh+qjNJlNUBGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881684; c=relaxed/simple;
	bh=He1qoD1LyuJLmPXOu6Sug+RnIL2fCie3WCh5VYdyMDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPYiNtzGe1jeJ+U5v9kruc9XJnqLFfBXkXM0ljy/+MXCufSjzB+PSCdqewb4cux6Cu1e2Y7y/BlGpELoTUJbHVtZswiZ6fZJCLGH+Fc1l9Xu5WfByetQD5fvA/0qfuxzPHFfRxb5EYa4A7wr9B0qbQfHVyOjRG7Znqo13xEreG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GW+PyTZO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240aad70f2so197895ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741881682; x=1742486482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/yH+WMcOt8tNQM0srrtHpsC9U4iKncCQNGb3KLC61c=;
        b=GW+PyTZOHDeFgOzZP5gVqe5lzT1KIkWwdj++6Dx8csEPtaVJQ1iuHfuXCuS5SjMSti
         pe9QJ/ciDWV7+ka4PisEo0k2EDF6aN3s8tK0nzpO1TJSd9xoHlhFoibQGVg9BtHW4vAX
         JPxEx+F03e/zb1HFhjoYJV6dzbw2PVwpp20SU3BXykIIxarVGv9M3kybqT8ig7PMVawf
         c5q5OxmXPcbyP6w/GpEmHjfA4oF4na6VWlX/ceY02c1eDSO27Hx6fpPcqo+HoegZi5oz
         dahS4uGaA33s+sf0KotUXzSjZiQ++5U7ojxHSDy09hBsLopOR5Ts7IuPuc/6EIuCcS5S
         Tz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741881682; x=1742486482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/yH+WMcOt8tNQM0srrtHpsC9U4iKncCQNGb3KLC61c=;
        b=Oqank+7nLk6/EsnrvVDn1/0NNAZcJgC06Vqnaw31UkfNnwGK86UAvjVeSvqZuE7cWk
         2Hl3YD7bZyod6idv/6Hs0aD8q50R1xX1ja8GktfWyRfuOAUOyATKtfQCH/JfkxeIJ22i
         gDH67ad8UYBUDSLpo/q26BjFROORCVjjFvF+PjAJftMNS2G8Uvsl3TG2e6ijw2TkFFKC
         iiHYCew/h1gV/jq02qJQkZgFGm28F9aG2G49OwMeky8Kw3hUfQ1+zVl/w8cFJxV0tdzO
         3z72/Qk+Ek6ftPBA8R6H1AZbkcmvQ0Es7lszc5javCMX2crSOnZs4vFibzUE+Rxyk1X5
         Ajvw==
X-Forwarded-Encrypted: i=1; AJvYcCWqm8BCdgzVkxGCnxwbEBGCtnRn4+xQ2fmBAc6r1ipVyWatKfSOV/o4sndK6no7N0T7MmkNcxrmVPZOTj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwK+xZgHl1CTOZIPKJhemYYpF9TSJp8qkrWD7zrrMs8w3Zz2vU
	Vgxa35dREXmvI93bcLsNue7AiDdoC/rbc40WJnNaSHpoOStrcn2xtEFGQYBHtKyX7Cbq7wU0p3F
	tOSoG6PSZ+PQkVgvC8W9bWyDt+F36RNlAKPk5
X-Gm-Gg: ASbGncuoO3Kcr6vvXXC4bStdMCVZrpZxde5WvXDm8ZmB1DO8sf0uwDrWYHLVC5ZZbFZ
	1UWQgq2PlrjVHhuM1RiBUu4piVufxTIuhfx270F+951c3vjCNxjbV5VnSzkz1U0DGJJu/U8/9ux
	3KGuqO4+SqvFoxrqIODBkhw7/C751MJU+YPk6ju54sQdUE/vwyrS5ll/E=
X-Google-Smtp-Source: AGHT+IEfR+iXZ7BebnhxB5okisX5ERNMertQsNLMEMPpFQikCdkWp3eUopoaUifcDnJZ/HTnk/fkfvYLDMyu7hcQBE8=
X-Received: by 2002:a17:903:19e8:b0:215:7ced:9d66 with SMTP id
 d9443c01a7336-225c5322e12mr2999115ad.10.1741881681251; Thu, 13 Mar 2025
 09:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313075126.547881-1-gautam@linux.ibm.com> <Z9LnuXCvK5P5KCiU@thinkpad2024>
In-Reply-To: <Z9LnuXCvK5P5KCiU@thinkpad2024>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Mar 2025 09:01:10 -0700
X-Gm-Features: AQ5f1JrxRsSvm9uzSroxX2RwhQ6wbjbDcA0dzrSUad0a-XkWOT__3vkZ8beC4io
Message-ID: <CAP-5=fWjca+SMBdsyPe8Ggsqrqz=ZzWqxDYhaF+pcYk0MJ12zA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Introduce a C extension module to allow libperf
 usage from python
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: Gautam Menghani <gautam@linux.ibm.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 7:12=E2=80=AFAM John B. Wyatt IV <jwyatt@redhat.com=
> wrote:
>
> Hello Gautam
>
> On Thu, Mar 13, 2025 at 01:21:21PM +0530, Gautam Menghani wrote:
> > In this RFC series, we are introducing a C extension module to allow
> > python programs to call the libperf API functions. Currently libperf ca=
n
> > be used by C programs, but expanding the support to python is beneficia=
l
> > for python users.
> >
> > The structure of the patch series is as follows:
> > 1. Patch 1 : Create wrappers for the perf structs which are used by
> > examples/counting.c
> >
> > 2. Patch 2: Create the C extension module that maps and exposes the
> > libperf functions to python programs
>
> May I ask why you are not using SWIG? With libcpupower the kernel has
> already been using SWIG to generate Python bindings for a C user-space AP=
I.
>
> This has several advantages including a much smaller footprint (you only
> need to copy the header definitions into a .swg file), can generate for
> several languages (Perl, Ruby, Java and C#), and SWIG is an active,
> tested, and mature piece of software code that has been around for
> almost as long as the Linux kernel.
>
> Python bindings including the makefile as an example:
> https://elixir.bootlin.com/linux/v6.13.6/source/tools/power/cpupower/bind=
ings/python
>
> How to use the bindings in a script:
> https://elixir.bootlin.com/linux/v6.13.6/source/tools/power/cpupower/bind=
ings/python/test_raw_pylibcpupower.py
>
> Original discussion:
> https://lore.kernel.org/linux-pm/20240724221122.54601-1-jwyatt@redhat.com=
/
>
> SWIG has been pretty useful as it helped me find two issues in the
> libcpupower API that have been around for over 10 years:
> https://lore.kernel.org/linux-pm/20240905021916.15938-1-jwyatt@redhat.com=
/T/#mf04b4ba93f79fe68c20c1d88d8ed966164a1c7d7
> https://lore.kernel.org/linux-pm/20250305210901.24177-1-jwyatt@redhat.com=
/

So I think we should probably get rid of libperf and re-integrate it
back into the perf code. There are issues in the code, like removing a
list element:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/lib/perf/evlist.c?h=3Dtmp.perf-tools-next#n58
just leaks the removed element. Deleting the element means that the
container evsel, rather than the libperf perf_evsel, leaks things like
the name variable. We can add yet more call backs and complexity but
I'm not sure what we're winning. Perhaps we can move things the other
way, perf code into libperf, like machine, session, pmus, .. I'd
prefer if we were to do that we refactored the code and adopted the
same license as libbpf as both libraries have similar packaging
issues. The viral GPLv2 on libperf is something of an issue. Perhaps
we can also migrate this code to Rust.

SWIG is fine, there is also CLIF, I'm way of dependencies as even a
python dependency in the perf build is optional.

We already have perf python bindings, and I've been working to extend
those for example in:
https://lore.kernel.org/lkml/20250228222308.626803-1-irogers@google.com/
and I've been working to expand those for things like hybrid CPUs. It
seems a shame to reinvent all of that logic again on top of libperf.

Thanks,
Ian

> >
> > 2. Patch 3: A python variant of counting.c - counting.py to demonstrate
> > the usage of libperf from python
> >
> > We have not added support for entire libperf, as we want to get
> > community feedback on the approach taken in this series.
> >
> > Gautam Menghani (3):
> >   libperf: Introduce wrappers for perf structs to be exposed to python
> >   libperf: Introduce a C extension module for python
> >   libperf: Add counting.py example to demonstrate libperf usage from
> >     python
> >
> >  tools/lib/perf/Build                          |   1 +
> >  .../perf/Documentation/examples/counting.py   |  74 +++
> >  tools/lib/perf/Makefile                       |  12 +-
> >  tools/lib/perf/include/perf/py_perf.h         | 431 ++++++++++++++++++
> >  tools/lib/perf/libperf.map                    |   1 +
> >  tools/lib/perf/py_perf.c                      | 262 +++++++++++
> >  6 files changed, 779 insertions(+), 2 deletions(-)
> >  create mode 100755 tools/lib/perf/Documentation/examples/counting.py
> >  create mode 100644 tools/lib/perf/include/perf/py_perf.h
> >  create mode 100644 tools/lib/perf/py_perf.c
> >
> > --
> > 2.47.0
> >
>
> --
> Sincerely,
> John Wyatt
> Software Engineer, Core Kernel
> Red Hat
>

