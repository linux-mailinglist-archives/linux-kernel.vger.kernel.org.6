Return-Path: <linux-kernel+bounces-555274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89927A5AE85
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9F0174539
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8AC221F03;
	Mon, 10 Mar 2025 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qVS+DokJ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56B222172C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741650050; cv=none; b=jMx8PywhUHqK2Yl0LlYN+lV3VBWbpHbtwMYhNQyflHyX7HVglbD13f/cZyiTMfF7/9giERyvQaKHFPtOBwc8q3C6Oql4bj5t52/4XOOAihtFx433Db5O9OH9l1hu8R+V+KGjX9MTLiR3zrosPkk37KdHDbP+oiuTpDSdWWzAr7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741650050; c=relaxed/simple;
	bh=x40/ETGWHUSDRpQLwYAWfFBMNQ7ZHfZ0GBicDTi7eWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQDpcfHBpumd88nEHaIUMGXHlUpTVU6YAjJjNfrP2h3nUV8mp7Pjddb2iXbSzZO3E2/LwWqlv6gfjyeMxGXycgjM/GCzd5YZ1LTspDYX2c5ykPo9B2pva82rGLIhaedwMG/KQTzOoC+SLu4+rk+tZUi/ZNfPtWFtPGeSx+ryUMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qVS+DokJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240aad70f2so41635ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741650048; x=1742254848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3CJk04DNfcWCA8ao7G6n3tZ6Syq2WgT8HbIaJ/f+4g=;
        b=qVS+DokJDgw3j2+hn+/XSBFwjRCgFoj8tPMHaBbgb4yYAIoHhmjXheXjb3ME3F5BEB
         IaFk29mHYjjHIW3HJjHoCTE8EQ7qunmO83ZRioAzQW9BAVDpJHgXXiTNMIfLIMieS0ax
         uWtVf7F5xyCai9Rgk+l6w+nx5Zo9sUqFjSdb2v7jxmTpSRdUJf6zYSSOVEMnSS2mECc8
         +8NiLARwMnb8vxgq0iDaCZcznvrymmLJGHB+DR7hMDxKXHz7nmELxLoMZcrTq+x7YfPr
         EQXZZpGAyZ50qF6rCzcZ7WtulvHatHHWHW+H0Fg8nZBZR5jB7Exfykz8i/Yj3VBHJ3wb
         MlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741650048; x=1742254848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3CJk04DNfcWCA8ao7G6n3tZ6Syq2WgT8HbIaJ/f+4g=;
        b=pZLmmK/moYgvlwjT8hlJggb35+r0nQzUZsf9Ib1QRampdNkw5Lp9xsDe75WhhtTZia
         fFGB03BH1zmdFZkaf3Zn7KMgmUwmlQ7nxnrXiIJ0zKUAmX2F2762BaYrcgEX5FIVcRwv
         TDr3cKYv9G1sstUmzxNuqXqPsEVbuo2KwEkpZOm8UD7mkwqi6QKuhPE/enfn/WhuAWzZ
         x7dxd+XJrIZjyZoKjh/kc3rMqKFJPMKWKd5TpuSJCMorr0OjLkNWvYFgubnG4mEx4D6+
         S4vT9+dHz7zW2lrsl3uuQd3P6NFVNqW9+puz7YhaA/v5sqZ/2lEN6tzqeXP1v2s/ohHd
         hXzg==
X-Forwarded-Encrypted: i=1; AJvYcCVNiJsIorqg2B9vk5iZhjKIHvxz1iES2RnHJ7G9yniJywuRKceAoecMVrgBFnCn9nbJrPpnwkiHkTaMHi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Q+eafORHoFyhKxB/kdQ2Cq+ZUV7bBFr4ABxh/aUALlzdtftz
	In7qIP352TZMljuFt35uszWiYQ5+zU3ons47rRv2uMCs+e+bj3XC253TfMZcFC9W7/AUHK7hTtS
	/TCAUxKO1jqOCSG2HP0Cew4AdG2WaNsSC4HUn
X-Gm-Gg: ASbGncsbCc/6z820ZeryFbWFLcjmfv1g+5C8pKAi5sANEs8t7ZSvSKUHk7zkmAzW4B7
	HEebERtiTvs3eueNMoI7j5ghSqe7yi+EZ+ilE1+LKa9WW3jlLDOJEr373JCEiSvB2CknB+8suwC
	+wBxFQN+q+zit7RfGiXtkRU8AzBCI=
X-Google-Smtp-Source: AGHT+IG8ZbJq9d3fOC2d1WzTRzoCvLclS0qrQU2tOiogJ4Ztx6P+CKCMeJ9Eq2d7KIOBSgUw60hfwsy3X1Gl0bCqIqI=
X-Received: by 2002:a17:902:dacc:b0:220:c905:68a2 with SMTP id
 d9443c01a7336-2254779cef4mr5526915ad.5.1741650047858; Mon, 10 Mar 2025
 16:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com> <20250228222308.626803-12-irogers@google.com>
 <Z89k6lWxRSBfCGvM@google.com>
In-Reply-To: <Z89k6lWxRSBfCGvM@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Mar 2025 16:40:36 -0700
X-Gm-Features: AQ5f1Jqm0hhpEhKAQajzWvx41-veMYX8cdpwcxztn5nYV3jmEU6IdvOQfPYBejM
Message-ID: <CAP-5=fUV5yt4c-PrvTFqW6ehuudwkqdO7QuQpvbUBDm6aT6+dQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] perf python tracepoint: Switch to using parse_events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 3:17=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Feb 28, 2025 at 02:23:08PM -0800, Ian Rogers wrote:
> > Rather than manually configuring an evsel, switch to using
> > parse_events for greater commonality with the rest of the perf code.
> >
> > Reviewed-by: Howard Chu <howardchu95@gmail.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/python/tracepoint.py | 23 +++++++++++------------
> >  1 file changed, 11 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracep=
oint.py
> > index bba68a6d4515..38b2b6d11f64 100755
> > --- a/tools/perf/python/tracepoint.py
> > +++ b/tools/perf/python/tracepoint.py
> > @@ -5,24 +5,23 @@
> >
> >  import perf
> >
> > -class tracepoint(perf.evsel):
> > -    def __init__(self, sys, name):
> > -        config =3D perf.tracepoint(sys, name)
> > -        perf.evsel.__init__(self,
> > -                            type   =3D perf.TYPE_TRACEPOINT,
> > -                            config =3D config,
> > -                            freq =3D 0, sample_period =3D 1, wakeup_ev=
ents =3D 1,
> > -                            sample_type =3D perf.SAMPLE_PERIOD | perf.=
SAMPLE_TID | perf.SAMPLE_CPU | perf.SAMPLE_RAW | perf.SAMPLE_TIME)
> > -
> >  def main():
> > -    tp      =3D tracepoint("sched", "sched_switch")
> >      cpus    =3D perf.cpu_map()
> >      threads =3D perf.thread_map(-1)
> > +    evlist =3D perf.parse_events("sched:sched_switch", cpus, threads)
> > +    # Disable tracking of mmaps and similar that are unnecessary.
> > +    for ev in evlist:
> > +        ev.tracking =3D False
> > +    # Configure evsels with default record options.
> > +    evlist.config()
>
> I think the default option uses frequency of 4000 but tracepoints want
> to use period of 1.  Also I'm not sure if it sets the proper sample type
> bits namely PERF_SAMPLE_RAW.

I used trace to ensure they matched. Fwiw, the sample_period for a
tracepoint is set to 1 in evsel__newtp_idx:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/evsel.c?h=3Dperf-tools-next#n621
and the evsel__config won't overwrite an already set sample_period:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/evsel.c?h=3Dperf-tools-next#n1341

Thanks, Ian

> Thanks,
> Namhyung
>
>
> > +    # Simplify the sample_type and read_format of evsels
> > +    for ev in evlist:
> > +        ev.sample_type =3D ev.sample_type & ~perf.SAMPLE_IP
> > +        ev.read_format =3D 0
> >
> > -    evlist =3D perf.evlist(cpus, threads)
> > -    evlist.add(tp)
> >      evlist.open()
> >      evlist.mmap()
> > +    evlist.enable();
> >
> >      while True:
> >          evlist.poll(timeout =3D -1)
> > --
> > 2.48.1.711.g2feabab25a-goog
> >

