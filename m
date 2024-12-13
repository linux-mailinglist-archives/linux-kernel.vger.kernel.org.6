Return-Path: <linux-kernel+bounces-444232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1EA9F031A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439A2188BE01
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB2D1531E8;
	Fri, 13 Dec 2024 03:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AlovSj4O"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6512238385
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060678; cv=none; b=mx2H6H8MpuDZgWo8uAP/FagppmjHeXw4kmLfhIg7jSeG3vVfMJfZzOiugU+nmB3YK+5j1FavmAavGGJ2lKdxoYR+YwAFMe8HOGGy0P+9wb9SbfRsHw+s3+I8tGaSXiRiAkdeauGJsd2Ph5eaD0Iy3n2NgYuta86AWMAFYH96OJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060678; c=relaxed/simple;
	bh=qxhiYi6a2Ku5GEwakKPEn5VPWTIdoMp+zhe19IXXiCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmrAjrLSJq6ch8fek2B27WxzEBQWiIHW/4r8EK00VhKiIPc4yWIinQDDKiL/SffrIDRGHvZ/hbPXuu1Ze8TM7bi19BSLAlAL4MXsjP9+IFVZg0uOH7QFAj8P8TQ/8xT4SnNkkVjJ1xFWsKwJ3+CVoyVQi3/PTK7XaHUBWYSvH4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AlovSj4O; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a814c54742so61935ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734060675; x=1734665475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPZsHe+9d6UK2cKEY6UXv1myi2iXWNd+qR0B6b7kmr8=;
        b=AlovSj4OAY/9j+NrfwsnxUcfMyaVcCdioUN40Oe9JwbVWqQApsHADMd8NZ+wbfH07y
         GjdEL36wbOeJfg0/4AoL0wMyfC9Y9XNRzyrINT/1N9bJknvh1tpkggGDAbKCsjvnWYb9
         4FFfkvxLwmk2Id6BCElDbgr1qTrWWjDCanaRnkmIVhf7WNfSJo7Z1sRR3G4zCwSpB5UO
         HX4e281SBQ4nvDkuqz7XN2pVxwZzeQZWn+XJrOtud/NH1EPXylF5I8oyon+6i5xFAoMo
         A0ibOK8lYTy/o5iRCFISG3QLMx6WdzXKPHfB/cpCY7lD8CB5upN+GYJADytGXvLFAWan
         Wlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734060675; x=1734665475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPZsHe+9d6UK2cKEY6UXv1myi2iXWNd+qR0B6b7kmr8=;
        b=SmcaA/PkDJwLqps3wGTO+lc6ZWANPAsAV2b6H5BjjA4Fxvr2nz7q/oIptp5+hRnnI2
         oYoShe4G8ZutQvPl8ABhOPuGM5/pEexII335Ty2G9dlC19WFuY5OYnnPTdW+Mt29wTAz
         zL4Gb4OwHN9YZyIUeBwb/6hmwYKCc4p16icY9cTHWgAoMc5UZK3TX6/Rad1q3EW9Cq4C
         HQ1Qs2kC4tp3jsDo4LpmE9w1zMJHPt2PVP+9wnVz5LMJ39H8kBOApsJenw4htm20ovO7
         yQumJxi+Sokp7D+9R2p0iac1cwQMzbjBKlqCmJEUAm7jubKzmKUERrht3Y5sLhyVXeVp
         3LgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTQgtKyEP8QMkTyOC8SZYH5tfpvq+sm0zQExwTAbt8ebOvrZ8gRW14b5BI/JHHXY3Fqs8DzQL3iKjaqsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdibBgWWFLiJyNVSq8nbDdbmLmyRtyCtmcyWBa+PHXO03fhnxt
	nSUQuvJE88o8w96+ADqYvQt3k6443xcU75+UrtEgQDF5AMdT8OSZKndCRdiz/6j6XkbKDmQ3sS/
	CQP9zuZ+69voiIqvYlN+qkFZKHojHyawK+pIR
X-Gm-Gg: ASbGncspI9Cm/5sKKn5UFvfZGw85slqWbRmma/wyXUrC/UQ/xqsPWmynPYlLGD832DG
	eOEDBa9axXAe1IqbUMC+RoAEhDtdx546TX1zY1C0=
X-Google-Smtp-Source: AGHT+IFFhpPpvYV3XFLjAm84ti030wjvefcYWAzjKri6pk1s0NQhtAwpUKZ9uemzlhhem1eOp5LnQuUEMDAdHpKey5E=
X-Received: by 2002:a92:d084:0:b0:3a7:c962:95d1 with SMTP id
 e9e14a558f8ab-3b02674964bmr1044595ab.5.1734060675401; Thu, 12 Dec 2024
 19:31:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212173354.9860-1-irogers@google.com> <Z1uQWmq3KAQx1tA3@google.com>
In-Reply-To: <Z1uQWmq3KAQx1tA3@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Dec 2024 19:31:04 -0800
Message-ID: <CAP-5=fU+PSGyrB9HUYS3XECRdZHqU57xAOgKvyUyE90DpiUDVA@mail.gmail.com>
Subject: Re: [PATCH v2] perf test stat: Avoid hybrid assumption when virtualized
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 5:39=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Dec 12, 2024 at 09:33:54AM -0800, Ian Rogers wrote:
> > The cycles event will fallback to task-clock in the hybrid test when
> > running virtualized. Change the test to not fail for this.
> >
> > Fixes: a6b8bb2addd0 ("perf test: Add a test for default perf stat comma=
nd")
>
> I cannot find this commit.

Sorry, should have been:
Fixes: 65d11821910b ("perf test: Add a test for default perf stat command")

Thanks,
Ian

> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Other than that,
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>
> > ---
> >  tools/perf/tests/shell/stat.sh | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/st=
at.sh
> > index 5a2ca2bcf94d..da42427bb077 100755
> > --- a/tools/perf/tests/shell/stat.sh
> > +++ b/tools/perf/tests/shell/stat.sh
> > @@ -163,7 +163,11 @@ test_hybrid() {
> >    # Run default Perf stat
> >    cycles_events=3D$(perf stat -- true 2>&1 | grep -E "/cycles/|  cycle=
s  " | wc -l)
> >
> > -  if [ "$pmus" -ne "$cycles_events" ]
> > +  # The expectation is that default output will have a cycles events o=
n each
> > +  # hybrid PMU. In situations with no cycles PMU events, like virtuali=
zed, this
> > +  # can fall back to task-clock and so the end count may be 0. Fail if=
 neither
> > +  # condition holds.
> > +  if [ "$pmus" -ne "$cycles_events" ] && [ "0" -ne "$cycles_events" ]
> >    then
> >      echo "hybrid test [Found $pmus PMUs but $cycles_events cycles even=
ts. Failed]"
> >      err=3D1
> > --
> > 2.47.1.613.gc27f4b7a9f-goog
> >

