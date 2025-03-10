Return-Path: <linux-kernel+bounces-555144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B36A5A60C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332B81894480
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5893B1E0E05;
	Mon, 10 Mar 2025 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tmp4oSuS"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8961DEFC5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641493; cv=none; b=FiwO5FuoSjNS/IIHqB2o/sL/Ishe99wSHgDThuUOADuevTSiamXgp+UooJP2z2iXqRtR9mdw0Dy/r2q1lZckRJ5qOPEGiY1a81R40MQhCqB69JYKXZMQ8hG8gmwkQhA1xgnve/WDn7ssSbh2lRQYh2EapXbOD2ZHEl0PaEAXoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641493; c=relaxed/simple;
	bh=bBmFJkWRZjCuzb5So1S/G2mprn5W5AV/YnYHEEd3qv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vqi1sxJJPEoTp4EqEZtpq2qFdtHexRvscFt3HA9UZgmIoHb7AKvSID16SAWZf61SP93ON924jMQ5PiCBgLITk/aruFKGgKqIxT1gzcmhrMHe7ONM+qMBvXwSmrpObNrIuRqQ8k+gIHhHYDxTN+VHgi33Cfer4nalG6b2ahcwkEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tmp4oSuS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240aad70f2so22575ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741641491; x=1742246291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8/dmJY11N7mbJOlMfyA1217WC0CE5deOB2W73RSb2U=;
        b=Tmp4oSuSMR/HvqtcogCYC7E9rEU29vZttff4juhnDacQEmTPECJs2PDsBCDOwfLLma
         zrrH4iCKl6zY9Gb9CZN4Cu0QpZpWxNaRC+X4sy7gs+IzNm7ids1M++uhqYywaiA5a6nC
         aU+MausJWB60t4S8ox53JAzfVYeuM8UNDpcmbcD2YPJ/C0gMGwPmIS4CmCQwkTR7ZEGe
         n3IiHynrzhqyJoBf+I8qlDf0Ozty5pi1ilgOGyOkX0CvSqvEKZD0wB0LG5GTQIOTylUB
         oqlav1ivawFI7Kv7tG/vWhUEIvgSaQqoNzAcMi3JvDvgDwi1VXzDCyTedIX1ghaS5LP+
         sGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741641491; x=1742246291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8/dmJY11N7mbJOlMfyA1217WC0CE5deOB2W73RSb2U=;
        b=PtBhsg6sPAXQlFmhyJZK+sdZl2jR2aO3N4lihCZqi1oNL45ZKLMdh7Y/NDfa4Hlt/u
         ItttMqtOc0yyt3Q/2qfY9ymL3BEUvT9n9mo91/43uyke4ShvTqnANqNyVBg69nXnCbA9
         D4zt9nPkx82ztaMFrcYvgJCJd4LJpcVzvlB7jE/G2D9h0Fl/w1PRwCaoGv3QEHbDYdbY
         TuE+6l+TVI+r0RwZUWvdcu9+ODd6n5HGqi0DiapFObRDpQvqOugAHdPW/Cd9xYuNlb2V
         28j582KaKNCXHfeNxZo5gNEre/GZ/MuGqQuW6ThqzxW9rKlSLHh8mzPOkNC9PlHvyvbs
         OU4g==
X-Forwarded-Encrypted: i=1; AJvYcCWVyOQvW/pot8GXg7A4XI1b/rjCZ96OtR4TjQlMjkyTwp0lafLR0U5jRMVLdzJU1J2YUpDwKI1jd4VQTUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywusrwr1WcK6jpCe5ZWFDp3h/vmZBvzahrbcxFx3jJIadQquHz1
	37imrUZTRN/dsal5rJQIUJPoENYlcSg1w1NCL8uD+PKpGPVs7fbD4+nOmGDSVZOKTSRiuFHXYVZ
	qmwKRFR6oOAEzjEbbNu9/momcKhM0gNa9c+lx
X-Gm-Gg: ASbGncs8niAoVDHnEPH5VU+E1w5GZUGjXwwGlDOJ8JhN8ALh7Anc3L2BXdHsXPMVgBh
	E5Z0RIH+EkfUuWofgrE9TwSto0kvT9x6cpBOI0uMDfGPvKiB1K/Od4dl0SqrQb7yB5GLLNEmU+T
	kLecV0nZvSIUqU7qB0PeLRSUqXpe4=
X-Google-Smtp-Source: AGHT+IEdDTmafL6+kz46zTmKdETyNnR4TVhZjmHQC9cggz64O1VLujRseTG+KgbKE84sXIpVuGgc58WTxKuXlHpHD6E=
X-Received: by 2002:a17:903:19eb:b0:223:5182:6246 with SMTP id
 d9443c01a7336-22547816b5bmr5030855ad.23.1741641491355; Mon, 10 Mar 2025
 14:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com> <20250228222308.626803-12-irogers@google.com>
 <Z89We45bGpeJvO9C@x1> <Z89WvaIVyF7klGp6@x1>
In-Reply-To: <Z89WvaIVyF7klGp6@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Mar 2025 14:17:59 -0700
X-Gm-Features: AQ5f1JoLHb4xh3ITTFUZ_NtIcvq8OxlMrKt3KV8oD97kCJcxo2j8FynWiAP_8rc
Message-ID: <CAP-5=fXzva636zCZR2isdfrjT6mM3o42C+oGWNkGieqGVajfHA@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] perf python tracepoint: Switch to using parse_events
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 2:16=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Mar 10, 2025 at 06:15:42PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Feb 28, 2025 at 02:23:08PM -0800, Ian Rogers wrote:
> > > Rather than manually configuring an evsel, switch to using
> > > parse_events for greater commonality with the rest of the perf code.
> > >
> > > Reviewed-by: Howard Chu <howardchu95@gmail.com>
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Now will all in place I'm trying to test it and I am getting some
> > strange results:
> >
> > root@number:/home/acme/git/perf-tools-next# tools/perf/python/tracepoin=
t.py
> > <SNIP lots of seemingly ok lines>
> > time 78318710956557 prev_comm=3Dsudo prev_pid=3D3133818 prev_prio=3D120=
 prev_state=3D0x1 =3D=3D> next_comm=3Dswapper/14 next_pid=3D0 next_prio=3D1=
20
> > time 78318720082300 prev_comm=3Dswapper/16 prev_pid=3D0 prev_prio=3D120=
 prev_state=3D0x0 =3D=3D> next_comm=3Dkworker/u112:8 next_pid=3D1752774 nex=
t_prio=3D120
> > time 78318706232435 prev_comm=3Dkworker/u112:17 prev_pid=3D1551246 prev=
_prio=3D120 prev_state=3D0x80 =3D=3D> next_comm=3Dswapper/21 next_pid=3D0 n=
ext_prio=3D120
> > time 78318708202121 prev_comm=3Dsudo prev_pid=3D3133818 prev_prio=3D120=
 prev_state=3D0x2 =3D=3D> next_comm=3Dswapper/25 next_pid=3D0 next_prio=3D1=
20
> > time 78318748346989 prev_comm=3Dswapper/26 prev_pid=3D0 prev_prio=3D120=
 prev_state=3D0x0 =3D=3D> next_comm=3Dgnome-terminal- next_pid=3D3551 next_=
prio=3D120
> > Traceback (most recent call last):
> >   File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py"=
, line 47, in <module>
> >     main()
> >   File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py"=
, line 42, in main
> >     event.next_comm,
> >     ^^^^^^^^^^^^^^^
> > AttributeError: 'perf.sample_event' object has no attribute 'next_comm'
> > root@number:/home/acme/git/perf-tools-next#
> >
> > But it shouldn't get there as there is this check:
> >
> >             if not isinstance(event, perf.sample_event):
> >                 continue
> >
> >
> > :-\
> >
> > Trying to debug that...
>
> And it doesn't seem related to your series, I checked and v6.13 has the
> same problem, I nuked the build dir, etc.

Right. I'd seen the same issue.

Thanks,
Ian

