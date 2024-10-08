Return-Path: <linux-kernel+bounces-356067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6358C995BCA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2401F25EF5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0718C218591;
	Tue,  8 Oct 2024 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EkQMY+ar"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBFA21791E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430729; cv=none; b=RwpRkGv/18EYl7ZQD+qiD4uWRw0BS0jtPy/6Oqel5Av9ZTewM/kdwTNFZufga+TNkBAenUWBIMqk6HxY6sHFq5G2zYlTQpLkuFCcXFufuspAJ0qW9gyvnnnUXrK0YPnUBs5SstOF2sYxeI0Khyw0KIbyxaXpqXqwb+DbuM82AvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430729; c=relaxed/simple;
	bh=oUjhuh0m3i8RgOTrYtsfvXtmndX3wABUgKfm7URsTdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfkxAF4o4xd5hUHLScIMWMtzeNrXI+hcSdJnmI/8MVyuwIe12mS8DK5tHRVhAWil+hiFh/CK5Vs8dQnaum8au+v4aiEQMMKS4iEoM2KZW4HSvyHMN0LxN6261ZUh2Zju6fjhw8bnmYqDNR+zj7YRCdflsCpYZs3uYrmshP7H3xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EkQMY+ar; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a36ad4980bso91055ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 16:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728430727; x=1729035527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHj9uIC0swgJ4C4niINoMHMUrPFl+whV9rsACB8aKtY=;
        b=EkQMY+arcoSlMXOnE6IHy9PklfS7nAtmJwzFjiXNiKLDjeWJCewq3a/wNW0O5BRdwF
         tLPxYpDeuvGG8C8kyKQDdlYdSov+RnIs5sQ+Zr46oQvtHGRTqIKb58FzoSSOZpmYjZmr
         ZkwNnfrdr0MvfyLpAgbyNkbbgklXPKSUgfsHJEoZ2EKz26X1qs3KqSj/PulIHh6YZO2d
         oMGgWxMvWTal15WMEhXteEGAw6DkCTrHCR3VmF1+CSokSkhM4zGQxlSti8zFzWH/iz6Q
         qtYGksbtkhzJakxjtffiTPnV5ZVUInWFyxvLSbcbW7L4lN5AJO+k0AKVcN79IcT0vWvx
         6fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728430727; x=1729035527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHj9uIC0swgJ4C4niINoMHMUrPFl+whV9rsACB8aKtY=;
        b=F+52B8lS5fzCAkJ17ZS77vkKSYe2YNRZ0QSihy2g2Y15HBpmQawjocL7BBMVUG69KI
         SllJoks5rU2C/DuwIzRJnKNnXOiPlpwnUnyImyiVT2UO/GRuDrJzZh+d/8sUNEtwZwf6
         wlUZGebfre2P9MsZE/9cFz5P1CqhWPASKB3U7OPTPa86InrOTEZg7BqCffVYSzv9/u9s
         J/nIdy6wfmr20d+sKpulWd+M/UC51oRCYqSNhFLkTXg5uRdpeFoovk1IjQPoZNGowJ0k
         RsVSG0KSIMwoUKAb3cXr0MrABZ18taFh+LXObGds0TvXSS9xddKKvU2TJbjypexhYYRb
         fLSw==
X-Forwarded-Encrypted: i=1; AJvYcCXdWp/baVaDzHps7oBdejwQZHkVx0gDk3cvh2nURKCVSk44pPQB7j6um7aT4YOPW42u9TsjXDwchTavj68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgBBhxoho1mn+a7AiE8l9EyriFr88t2ebKmwAoCDoIDAEDU0zd
	baYejrgmxx2X442y1q/wjY2uah+oGp0Mt/dIO8v8pEqC5eRJ0rGOfT4yK5aO5V/zQNju1Qif9hs
	ceC8VleRm60V+2mz8Ev/BgzTas7LCeDapQPOx
X-Google-Smtp-Source: AGHT+IGvm5mnDB6DWZj6bA268J+u+U3ZlPi+fXdRCd2hqT9nIdqdxX+YeP1jgiw4HyN8d8ya2CF5ZGmt+dUAB2g3Gxk=
X-Received: by 2002:a05:6e02:170d:b0:3a0:aa15:3491 with SMTP id
 e9e14a558f8ab-3a398090d54mr917195ab.23.1728430726922; Tue, 08 Oct 2024
 16:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004234120.1495209-1-irogers@google.com> <20241004234120.1495209-4-irogers@google.com>
 <ZwW0b8km5DnaOETr@google.com>
In-Reply-To: <ZwW0b8km5DnaOETr@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Oct 2024 16:38:35 -0700
Message-ID: <CAP-5=fW0QQSwEAxK11bt8a8uPA+M=PyOUb=Y2+se+15peDqwPQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] perf stat: Display "none" for NaN with metric only json
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Weilin Wang <weilin.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 3:38=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Fri, Oct 04, 2024 at 04:41:15PM -0700, Ian Rogers wrote:
> > Return earlier for an empty unit case. If snprintf of the fmt doesn't
> > produce digits between vals and ends, as happens with NaN, make the
> > value "none" as happens in print_metric_end.
>
> Then it could be "NaN" or is there any other case?  But probably "none"
> would be more generic.

We use "none" here in print_metric_end as mentioned in the commit message:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/stat-display.c?h=3Dperf-tools-next#n1090
If we used NaN then it'd be another case for users to parse, hence
trying to be consistent and using "none".

Thanks,
Ian

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/stat-display.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-disp=
lay.c
> > index 5402998881c4..e392ee5efb45 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -609,19 +609,22 @@ static void print_metric_only_json(struct perf_st=
at_config *config __maybe_unuse
> >  {
> >       struct outstate *os =3D ctx;
> >       FILE *out =3D os->fh;
> > -     char buf[64], *vals, *ends;
> > +     char buf[64], *ends;
> >       char tbuf[1024];
> > +     const char *vals;
> >
> >       if (!valid_only_metric(unit))
> >               return;
> >       unit =3D fixunit(tbuf, os->evsel, unit);
> > +     if (!unit[0])
> > +             return;
> >       snprintf(buf, sizeof(buf), fmt ?: "", val);
> > -     ends =3D vals =3D skip_spaces(buf);
> > +     vals =3D ends =3D skip_spaces(buf);
> >       while (isdigit(*ends) || *ends =3D=3D '.')
> >               ends++;
> >       *ends =3D 0;
> > -     if (!unit[0] || !vals[0])
> > -             return;
> > +     if (!vals[0])
> > +             vals =3D "none";
> >       fprintf(out, "%s\"%s\" : \"%s\"", os->first ? "" : ", ", unit, va=
ls);
> >       os->first =3D false;
> >  }
> > --
> > 2.47.0.rc0.187.ge670bccf7e-goog
> >

