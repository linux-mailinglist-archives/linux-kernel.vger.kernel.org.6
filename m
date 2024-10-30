Return-Path: <linux-kernel+bounces-388068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71B79B5A16
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C516280DEF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F288C192D7C;
	Wed, 30 Oct 2024 02:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvcUKlLk"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEA446B5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730256343; cv=none; b=VDdhF07xK+9+Sp6xQquLiBh2/jeW5wzdT7S3vSKvq+Ex2x9AnU87lyTADgzS8IVdUI4tpKajLQVPX08tRSifgmtUWc9LDyE9nHQTLLT0JNicZJeTq6IVZ9ULbVM4ZMH+NIZ5Hk6urF6sjIJgR8kDvwHw/dmj7rc0AZ9fdd3bYqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730256343; c=relaxed/simple;
	bh=BN0fMx46VXTzuiutOEuMnPGnMLAB0k3T+4RsPuGzPs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2mGM2cyZaTR5l/+6a/5FZHbafSVjpcLInHkMFounSJSDrxVHDzCtqi+BNIkXtumhfzZg0CEMH+sP4FY9N7Fh1u2rubiWfqz6Jo7FiBG78fpE1054fh+oJ0X6S8uXFrKFDGx9y/o2xgBK9IC/Yqjc49hZDlKu3guyL8mJM3uKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvcUKlLk; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so97815ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 19:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730256340; x=1730861140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvvnEelLqLmapO0x0c3RWR/JLiOjk0uX66oljX30Htg=;
        b=FvcUKlLkM6LGiittVx7Rli3t416TkMnrVoVfV753sltNkzsCZjKqYziKR5owhLHMs9
         vKRTxyLoKrDLcR5I1wqlQ44f613vESiMvt6V6y9bPyDQmM0n9k2Vviyzq28WsWvTtxoB
         uo+s7IJ4lEap0pDH+vLve6YRweOtwJrlnqbL09l9zk5Rjwsq7g9Dp/c/h5y0r4S+GUha
         MkqR4Uo0U2QlhiWGORwvx6BQz5rqHOX/aESdcobMcDFyUwYMm0n+J4iSzn0J0nOhBHsg
         N/q6pKon/uGYTw1fs85FjCKAkmIHW4Y77EjiNNZ+d7dYgadcUmjfZnQnJiwVwzw5HGyp
         zf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730256340; x=1730861140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvvnEelLqLmapO0x0c3RWR/JLiOjk0uX66oljX30Htg=;
        b=jFhBorK0Tu7Ugh8BdGdB3fieHBuCWlwEz7xZkbHwlrBujjxqWU5bKSYSDY0LHJlq0T
         MMghnljwxAvGQEtR2spOujZIKxNAgYf1L4K6RD0EcrXEyCSrz5O40MyhFJ3hNHUz2WYh
         lMo+jziwVKo7Q6pCzctHKhI///mGTo2ByV0MEfNabXrukRNwxTr7TTcmnv04uXANWR2E
         sURDORcRlL+yziTmGOADiOU+HRabM49B8Hk7QasiZ+JbPGEX32hj1UHusPFKWINu1yDo
         twoCeJLYtyhpxfe/t+4+yBciYcF2J2GMZRbeSR2fcd4YgCgFMVp4cqAihbbJhulwQKSZ
         lZRA==
X-Forwarded-Encrypted: i=1; AJvYcCV+dKnxA3PzCAXhoyL3HRXPHrLNEV/hS4VMRP/MFyFgjNqWxsH6a4JjU8WruWAnZJvs8xV+Wge83FTvCdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYUciDCnHKHCyPhuGVs7wzInrLXFr1bjjpxCslLJkDZCV2gu3o
	wo9wbCutA/FesTD6pyuYrOdXvIkeb7EQZwEE/9SPPSDTK+cNICUScd4+f83RjNd5kalQPI2Kceo
	vT3cbqFEuJgrDMYBe189JDFIY30VgdJY5FM2z
X-Gm-Gg: ASbGncvE+dQVYPaZlkOhM2UI9t8MAG+wIWlf4CpDgeDPJ8kVpRZU6wZ8KXYf5/iZOw5
	L+8tCp3sh2AZJd8p/UVxoA+w+L73IvLHw
X-Google-Smtp-Source: AGHT+IGJtjwJHAQsSLgiWc5Li3w18zYO/PzbZ+kAbilKcgZZ5rvAE4pC+0zbV7W/oHUrm0RGdQr3vvEFSZNivzhE3z8=
X-Received: by 2002:a05:6e02:1d1b:b0:3a3:f86f:2d1f with SMTP id
 e9e14a558f8ab-3a50b47f5e5mr6322215ab.23.1730256340327; Tue, 29 Oct 2024
 19:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025090307.59127-1-james.clark@linaro.org>
 <20241025090307.59127-3-james.clark@linaro.org> <ZyGA9cjrtbE_eWik@google.com>
In-Reply-To: <ZyGA9cjrtbE_eWik@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 29 Oct 2024 19:45:26 -0700
Message-ID: <CAP-5=fW=DfWK9qvrtxp7z+N7aELar2xMts_=twUjWbfEQ_9vHg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf stat: Also hide metric from JSON if units are an
 empty string
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, tim.c.chen@linux.intel.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 5:42=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Fri, Oct 25, 2024 at 10:03:05AM +0100, James Clark wrote:
> > We decided to hide NULL metric units rather than showing it as "(null)"=
,
> > but on hybrid systems if the process doesn't hit a PMU you get an empty
> > string metric unit instead. To make it consistent also remove empty
> > strings.
> >
> > Note that metric-threshold is already hidden in this case without this
> > change.
> >
> > Where a process only runs on cpu_core and never hits cpu_atom:
> > Before:
> >  $ perf stat -j -- true
> >  ...
> >  {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/b=
ranch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00, "metric-value" =
: "0.000000", "metric-unit" : ""}
> >  {"counter-value" : "6326.000000", "unit" : "", "event" : "cpu_core/bra=
nch-misses/", "event-runtime" : 293786, "pcnt-running" : 100.00, "metric-va=
lue" : "3.553394", "metric-unit" : "of all branches", "metric-threshold" : =
"good"}
> >  ...
>
> I guess you're talking about "metric-unit", not plain "unit", right?
> Then please update the subject line to reduce the config.
>
> Ian, can you please review?

It'd be nice to see the stack trace for when metric-unit is "" as I'm
not seeing the logic in stat-shadow.c. If we know the caller than it
seems logical the unit can be passed as NULL rather than "".

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > After:
> >  ...
> >  {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/b=
ranch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00}
> >  {"counter-value" : "5778.000000", "unit" : "", "event" : "cpu_core/bra=
nch-misses/", "event-runtime" : 282240, "pcnt-running" : 100.00, "metric-va=
lue" : "3.226797", "metric-unit" : "of all branches", "metric-threshold" : =
"good"}
> >  ...
> >
> > Signed-off-by: James Clark <james.clark@linaro.org>
> > ---
> >  tools/perf/util/stat-display.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-disp=
lay.c
> > index a5d72f4a515c..9b7fd985a42a 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -506,7 +506,7 @@ static void print_metric_json(struct perf_stat_conf=
ig *config __maybe_unused,
> >       struct outstate *os =3D ctx;
> >       FILE *out =3D os->fh;
> >
> > -     if (unit) {
> > +     if (unit && strlen(unit)) {
> >               json_out(os, "\"metric-value\" : \"%f\", \"metric-unit\" =
: \"%s\"", val, unit);
> >               if (thresh !=3D METRIC_THRESHOLD_UNKNOWN) {
> >                       json_out(os, "\"metric-threshold\" : \"%s\"",
> > --
> > 2.34.1
> >

