Return-Path: <linux-kernel+bounces-307636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69499650A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25CC71C22B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269A41BAED3;
	Thu, 29 Aug 2024 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H2LTMSq8"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F2926296
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962656; cv=none; b=T3Iw0Ntu2NpIUAhfWiJ/UJaLpkVzhHvr5ngjsQ8rB9MHzYFAeiIJwRppcdZYENcL7GssyucQquUNYQbL+WwbsmScYag3D/Edikc7S4uqa1mPCh0vYaP5Pu6NPfiXhc9YasCAL1RQ7U71ABiSW2Ag537dQmlNdzZjntzzcfY20Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962656; c=relaxed/simple;
	bh=CrkWyT8pe3Nd1uhQnHymqD0o3bjBUQXEIDkpFvPBmdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5xjidEGxREIYW1jWvFcKia79hk/cAg5Cn7+XVxTmIgJIGLj4XQCEK0ksOC0zm8mmIov/a36FS372ZG7XX20KF0x9yEZ+IyeM+kL13/sOpc5I5WHoeOMGimgg9T+Da6zopp1Tg7v8hKq5+N0JGDn7NOgBy0bnOoYeW3/+EUoQ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H2LTMSq8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-201fed75b38so13475ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724962654; x=1725567454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJMs50eYovIDOFEhpZInzBfPSvFGV4+H7LoK3B/OWoE=;
        b=H2LTMSq8WsQI5lNdjj7Ij3SHv5kzH8w4fbKvT4qH7Zyxt9VS41Etu/YjMO/zHH6tZG
         2eKnwUR3sqJ/JXu5VNrBtLk+dHYWxbLTR0ePpCMr02zmFhM/gd53U8Dxzdpno4i7jXI8
         0OQCj+hxie00ZMhm0zl6gq8MaEnyIHgSXp1XtvIby6F8w0X64WkNRcAY/gv7qzwCIs4L
         1rQYhAPtAJPt0TbhuEhs4MVT0ci+NDwsvnb3HRrdgEWoXnudaSeeEYEqDgvXExm+8UrZ
         zjXRc2/R/1odr2OJsCFiGQfuH4TKOX09rWQZPuARIf6v4W5tNksmR1a3PmqkN1fdmcFq
         Wfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724962654; x=1725567454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJMs50eYovIDOFEhpZInzBfPSvFGV4+H7LoK3B/OWoE=;
        b=oqNogzc3475zGxyVD0c4dn+Xk3FEkI7pCbwRW0dCnOBe8hmSHOAu7AS2pyeve8zj9m
         4I3XSKjye72WOvZBiaxcjTwIcoc6LyhPxuDpmhjm7DOqfXnICrWKQl5bTwgrvba+f+iG
         6jRCpc/IVoOxQMzLhbs4rZvGQ/Go0XdDj0LSlZIWseF2cWDTx0xQP/7Dvb/3+CGOqqbF
         lo5YZ+tNuVjpFGQYKyDgwz+JGKO3ZdWA0Gx/xX1EXURIcEkwM8bq1vggrHBgPYYCGoGm
         /k8V2GVF4dz6q7497Y7BiTPaRyHQ67nHrHfSxRn0iN/A1zO27SAUoY7u0XkxIyPRBGBK
         7tyA==
X-Forwarded-Encrypted: i=1; AJvYcCUxyw+3ZBdwGwiAGCUKz1spUCNsZcwZOIT3QYTDtatjw8xmlOW2fVUXwOOqBMF0MRqu0AS7OjkCRvM4OWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzxmiTzSE/9BxO4WoaBZkM9UjlpSb1kWVjB/l51g/gUXNV1FHP
	aNu7ielyKCJvR7ZuxtMLyQS9o8L8SHYSyN4H+2bEZh9IQucQzcu3126hxalJRnWcd3N4mSdvv89
	YN6mugNKsbBX8zjV2b65n0EsWT28GyyPUr52M
X-Google-Smtp-Source: AGHT+IFkkYHj2L1ALDI9BMs5KndvjNqvefCuumyrWxnld/zPA5GPvJU/HkeNTbD8gfSM9TDCAZllylLFiNeb3cTLltY=
X-Received: by 2002:a17:902:e54f:b0:1fa:f738:62fd with SMTP id
 d9443c01a7336-20524bca3acmr576955ad.7.1724962653789; Thu, 29 Aug 2024
 13:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZroIIXkmErNGZjQO@x1> <e26941f9-f86c-4f2e-b812-20c49fb2c0d3@redhat.com>
In-Reply-To: <e26941f9-f86c-4f2e-b812-20c49fb2c0d3@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Aug 2024 13:17:13 -0700
Message-ID: <CAP-5=fXFH8aqxzCVAgRRdZufUdiC2UMBApEeSnak3yhZ_CXNyA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tests pmu: Initialize all fields of test_pmu variable
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Radostin Stoyanov <rstoyano@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 7:05=E2=80=AFAM Veronika Molnarova <vmolnaro@redhat=
.com> wrote:
>
>
>
> On 8/12/24 15:03, Arnaldo Carvalho de Melo wrote:
> > Instead of explicitely initializing just the .name and .alias_name,
> > use struct member named initialization of just the non-null -name field=
,
> > the compiler will initialize all the other non-explicitely initialized
> > fields to NULL.
> >
> > This makes the code more robust, avoiding the error recently fixed when
> > the .alias_name was used and contained a random value.
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: James Clark <james.clark@arm.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Michael Petlan <mpetlan@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Radostin Stoyanov <rstoyano@redhat.com>
> > Cc: Veronika Molnarova <vmolnaro@redhat.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/tests/pmu.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> > index a4730b5dc0d9259d..be18506f6a242546 100644
> > --- a/tools/perf/tests/pmu.c
> > +++ b/tools/perf/tests/pmu.c
> > @@ -458,10 +458,10 @@ static int test__name_cmp(struct test_suite *test=
 __maybe_unused, int subtest __
> >   */
> >  static int test__pmu_match(struct test_suite *test __maybe_unused, int=
 subtest __maybe_unused)
> >  {
> > -     struct perf_pmu test_pmu;
> > -     test_pmu.alias_name =3D NULL;
> > +     struct perf_pmu test_pmu =3D {
> > +             .name =3D "pmuname",
> > +     };
> >
> > -     test_pmu.name =3D "pmuname";
> >       TEST_ASSERT_EQUAL("Exact match", perf_pmu__match(&test_pmu, "pmun=
ame"),      true);
> >       TEST_ASSERT_EQUAL("Longer token", perf_pmu__match(&test_pmu, "lon=
gertoken"), false);
> >       TEST_ASSERT_EQUAL("Shorter token", perf_pmu__match(&test_pmu, "pm=
u"),        false);
>
> Reviewed-by: Veronika Molnarova <vmolnaro@redhat.com>
>
> Thanks for the rework,
> Veronika

This seems like a simple enough fix for a test that it could be
cherry-picked into perf-tools for v6.11, I'm not seeing it currently:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git/log/too=
ls/perf/tests/pmu.c?h=3Dperf-tools

Thanks,
Ian

