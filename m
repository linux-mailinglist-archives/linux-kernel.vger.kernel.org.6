Return-Path: <linux-kernel+bounces-441801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C49A99ED431
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0F3165C92
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4271FF1D1;
	Wed, 11 Dec 2024 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XsHXVk/g"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4FE1FF1D0
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939909; cv=none; b=qb7nCjTFN3yXhtNmDDYT90XLrMR/2ThuGlloOiLRQaAehtPFVg233L1/7HflDO4WkMqHHzrjTqWGMM8rPczI9lVPRdWNP8Xi4Kv2JPmNNfGvDrdY3yUM2xQHLeG5+X2QQiIR3cudsDGv5VkBfZWi+CRHgPL0gPToMHCTIM62NJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939909; c=relaxed/simple;
	bh=R3T11l8xt1aGZ6P9H11qj4eLnK8r2GPCU6lVevf41bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaFEZAKGE0LQY4+qKAbir9MzIZhXKjvxxGQ0jjy8OuQYBRXdLltEGPlq4yH0AggLbFkZlG/74D5r1zJyMeFXYKmwvpOeboA1qZgob7NMFeX4joy6fO8jAroOHANj+/+wAD8JD5USXQ6TWToZi2/wm3ArsJuvrVbwkfMZk4f6Kf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XsHXVk/g; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a814c54742so2865ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733939906; x=1734544706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFoTN4ef6tsaYaPXHrZT3l6uMHwk3tr1FxPfQlIdTqE=;
        b=XsHXVk/gUp1n/P2qs5daDpxWxsG/EDXYUkHfMPzT+XQkmw4Y/VXn1h5eA8cMZ2Ie3D
         pM5hWtm36M43FDhMEm+nZBmMuC6hO+wtZIEDzPryVM4OHxLiEUMGZ1BZWlbZWKWihNHr
         5v/mtHiQu9kCyrxVGsIkYKD7qRt2p5uedf6aNrPzcX8YgpVNZg6fiATzQ4nN5DCayluD
         cmRSXa4EDvqy4uKmHZxUni5DTQYd25EdYn8hp/1dS1P3ZXwerJ+lVnDyZAYC8L4GCdAC
         lhv/IIaHk3afC1c+9JfE3fchSzYQMYud0dUYn1qNwuMlOK58bE5eDA72rRJJGRt0OlMc
         djVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733939906; x=1734544706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFoTN4ef6tsaYaPXHrZT3l6uMHwk3tr1FxPfQlIdTqE=;
        b=EGQ7gtQJAb/KrVoGztDEuSABUHdnpCGM8ifWs0ZsZVHJHtEcFufQCTHMRJx0U0qG6N
         QvOqhyCZackq5TzsjtXOQccOhVFKU8SOCKqG+M3dr0JxKcaUm8AsICa0/tlhh9s3+BEk
         3kKqSoAsZci1x67Z0q8lFavRr6Z1ubNi02CopWFc65ahPRlCBMqRihhP0R8GkEueJX+W
         yrIQo1jpA/bX/Afi3aEfHRZjuSq/uePs+by+DiIAGj0/D06GmVFX1glGRjm8BBHHibUL
         UdTH8JgweOSFodWdYwXmyBu+vQqPNyQf6Zk/eaSh/3KEPNvmLieu3lyUA52eMGSMixuO
         FsJw==
X-Forwarded-Encrypted: i=1; AJvYcCWan88kKWsZGchnh9tnEoNWALzhiSFzvJF3r44KlFKG7hzQVNal8SWAQdjDK/ZJ/7T7FlaAEXbrdc98rjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKbomafqlcw6bl7zI2pV4wkc+pKsfT7QzQoU0h7prj6/2CMUfI
	nDHfzSm4Wv2Emu3zCc3HZhWEDcG490t1u2/q6WoupYWzU0E2WRKowOri5teD1JVXyEj7XDJ5cxF
	L2hU/dQWo5CZgYQM4oIhkVybkj0/3W68dfverJ0KZdmby5kAnS8jqFsk=
X-Gm-Gg: ASbGncuua/YDN/l7iQnYhlq4Go9dr6UjDMz5WdXgVflX66o/vOeasL7EbR53AQZPGi5
	H3SEvoc2Xu1pIONafCQPHD2icu6TJsZcLmiNA
X-Google-Smtp-Source: AGHT+IHDUGLYwHXig3aPIIAKQG3r40UaPaRtA3rpSGtI44vdk6Im5yMjdEylYcZQsSBzcdLJC2Q34UzaQjz94xGLGt4=
X-Received: by 2002:a05:6e02:3388:b0:3a7:d85a:b1bd with SMTP id
 e9e14a558f8ab-3ac42aa9446mr488505ab.4.1733939904140; Wed, 11 Dec 2024
 09:58:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211061010.806868-1-irogers@google.com> <7c118b40-3b31-46d0-8967-e7c35f6a4868@linaro.org>
In-Reply-To: <7c118b40-3b31-46d0-8967-e7c35f6a4868@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Dec 2024 09:58:11 -0800
Message-ID: <CAP-5=fVxPaSYtB62ZqcLOG1F9Va-0rwBWUCiVNdaBpmsGXUVaA@mail.gmail.com>
Subject: Re: [PATCH v1] perf test stat: Avoid hybrid assumption when virtualized
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 1:50=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> On 11/12/2024 6:10 am, Ian Rogers wrote:
> > The cycles event will fallback to task-clock in the hybrid test when
> > running virtualized. Change the test to not fail for this.
> >
> > Fixes: a6b8bb2addd0 ("perf test: Add a test for default perf stat comma=
nd")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/tests/shell/stat.sh | 10 +++++++---
> >   1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/st=
at.sh
> > index 5a2ca2bcf94d..60cea07350e1 100755
> > --- a/tools/perf/tests/shell/stat.sh
> > +++ b/tools/perf/tests/shell/stat.sh
> > @@ -165,9 +165,13 @@ test_hybrid() {
> >
> >     if [ "$pmus" -ne "$cycles_events" ]
> >     then
> > -    echo "hybrid test [Found $pmus PMUs but $cycles_events cycles even=
ts. Failed]"
> > -    err=3D1
> > -    return
> > +     # If virtualized the software task-clock event will be used.
> > +     if ! perf stat -- true 2>&1 | grep -q "task-clock"
> > +     then
> > +       echo "hybrid test [Found $pmus PMUs but $cycles_events cycles e=
vents. Failed]"
> > +       err=3D1
> > +       return
> > +     fi
> >     fi
> >     echo "hybrid test [Success]"
> >   }
>
> Hi Ian,
>
> Isn't the distinction between task-clock and cpu-clock whether the event
> is per-cpu or not?
>
> $ perf stat -C 1 -- true 2>&1 | grep cpu-clock
>                1.49 msec cpu-clock       #    0.917 CPUs utilized
>
> $ perf stat -- true 2>&1 | grep task-clock
>                0.30 msec task-clock      #    0.366 CPUs utilized
>
> The test uses per-task mode so this change makes it always pass, even
> when the number of cycles events doesn't match the PMUs.

So I'm confused by the test, but it has caused a passing test to be
broken for me when I run virtualized. The test is checking a cycles
event is opened on each hybrid PMU, but this is conflated with
checking perf stat's "default" output. The cycles event will fall back
to task-clock in per-task mode but we also open a task-clock in
default mode. Should:
```
if [ "$pmus" -ne "$cycles_events" ]
```
be something like this then:
```
# The expectation is that default output will have a cycles events on
each hybrid
# PMU, but in situations with no cycles PMU events, like
virtualized,this can fall
# back to task-clock and so the end count may be 0. Fail if neither
condition holds.
if [ "$pmus" -ne "$cycles_events" ] && [ "$pmus" -ne "0" ]
```

Thanks,
Ian

