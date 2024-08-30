Return-Path: <linux-kernel+bounces-307991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CF49655FB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375482828E5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFD61531F3;
	Fri, 30 Aug 2024 03:49:20 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E671531E5
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724989759; cv=none; b=eTBhKv6YAyj/PHz7aNYQynbEtpBYOfr6FEwag0WbPP+pDUpXdrOifQtg5ke7GKGprmRdMDcRx1soXkjtq10JGUczVB4lrIJ3ftCGxMvM15HkuIKM7H4mslfnL2/LBgxkTQR783FQ5NxlwzdM96Q+vr//jbsCbCWCHofQldB3h3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724989759; c=relaxed/simple;
	bh=kyLsTe4QV/3bzadkW66gw2NVKrftRrWCB8nCDAYaFn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bltK+R8L2F3XvWtkA2C/Qo/OPLdSLIivpXuk3BOyHhOf3T5vzXwD91yfEbch7V6ukYd7FWk71dlw5amJaNAM0r87djOlzqvJeWODqdSIYJlDv4bRtX7lnNnSWj6neNj2Ztq6xOZ+86Rspz1cb48NvF833lpT2N+rxvLxx7rB0/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3da054f7cso1041991a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724989757; x=1725594557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsiMix7QWyWaHMy+hCzRFuEqEKFrp90cPKH26mDgQBA=;
        b=NgBsLEOS064u3THeTWcQuj0kBg/3BC6R4l/SvrsJHyL8wqg6e4eGdWJCmtZhgLhPda
         YHk3B2Efe56tboOAqLF4aLTYl8QHrM6DdZjYhXkUxaB5iI/R8NCPr8T8KinjK+3zQwTg
         rnGHIlnwtmn2tAJAkAS4aaJ74hfIdgVbtf0dEfq5/1mn3JwVinJdc3AwYgD4Btri8f1G
         bTD/hmHSRbUJrI0+406E6M+lo3vRf/bGKR1f4YILDgH0NokQaAyqYleUDxu+xINVaQ7y
         Ye7n2QXikrUwxuq2HZAs9xHR6KI1B9rzEY3JVo2ruCyW/NCrluD1nJA1OckvsibQJ8sQ
         HZhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs6KYeKENdCLTUkbcm1wBfQnvCVmpgAzecRE5WqZcQcRGUB+BNblPq5b9jVZRhFkacvyKOXXwv9KY5cEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx66/xDMYtNzlVpyn0VF/nrBeWDv2e2YAuk3t8ieCQZSxgRMLz1
	8F2ejcDuY/knQWYDgNCvNIU8hkBN8Sybu4FC/UixjMlgl+WPrHi+maCgUeqdyb81q6868lmXGhI
	m5KbaIWTeP+F2f4qmMZM0e2B5JsTPGA==
X-Google-Smtp-Source: AGHT+IEnoZZJRnPfrnbg87C9e9JsYdhryGU2112XvjF/KEnAObexxrGbVvRHbb6C1uTYEn26Gk9Es+hI0lDHOkpgSZc=
X-Received: by 2002:a17:90a:d196:b0:2d3:c5f1:d0d9 with SMTP id
 98e67ed59e1d1-2d8561db9ffmr5436151a91.25.1724989757285; Thu, 29 Aug 2024
 20:49:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZroIIXkmErNGZjQO@x1> <e26941f9-f86c-4f2e-b812-20c49fb2c0d3@redhat.com>
 <CAP-5=fXFH8aqxzCVAgRRdZufUdiC2UMBApEeSnak3yhZ_CXNyA@mail.gmail.com> <ZtDjdt1QwbxJVKZ0@x1>
In-Reply-To: <ZtDjdt1QwbxJVKZ0@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 29 Aug 2024 20:49:05 -0700
Message-ID: <CAM9d7ch3wYvqKE9HANvhinnBqgtnA6suzLYrd4bkFZ-wjqdOQw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tests pmu: Initialize all fields of test_pmu variable
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Radostin Stoyanov <rstoyano@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 29, 2024 at 2:09=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Aug 29, 2024 at 01:17:13PM -0700, Ian Rogers wrote:
> > On Mon, Aug 12, 2024 at 7:05=E2=80=AFAM Veronika Molnarova <vmolnaro@re=
dhat.com> wrote:
> > > On 8/12/24 15:03, Arnaldo Carvalho de Melo wrote:
> > > > This makes the code more robust, avoiding the error recently fixed =
when
> > > > the .alias_name was used and contained a random value.
>
> > > > +++ b/tools/perf/tests/pmu.c
> > > > @@ -458,10 +458,10 @@ static int test__name_cmp(struct test_suite *=
test __maybe_unused, int subtest __
> > > >  static int test__pmu_match(struct test_suite *test __maybe_unused,=
 int subtest __maybe_unused)
> > > >  {
> > > > -     struct perf_pmu test_pmu;
> > > > -     test_pmu.alias_name =3D NULL;
> > > > +     struct perf_pmu test_pmu =3D {
> > > > +             .name =3D "pmuname",
> > > > +     };
>
> > > > -     test_pmu.name =3D "pmuname";
> > > >       TEST_ASSERT_EQUAL("Exact match", perf_pmu__match(&test_pmu, "=
pmuname"),      true);
> > > >       TEST_ASSERT_EQUAL("Longer token", perf_pmu__match(&test_pmu, =
"longertoken"), false);
> > > >       TEST_ASSERT_EQUAL("Shorter token", perf_pmu__match(&test_pmu,=
 "pmu"),        false);
>
> > > Reviewed-by: Veronika Molnarova <vmolnaro@redhat.com>
>
> > This seems like a simple enough fix for a test that it could be
> > cherry-picked into perf-tools for v6.11, I'm not seeing it currently:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git/log=
/tools/perf/tests/pmu.c?h=3Dperf-tools
>
> This is not a fix, its just to make the code more future proof by
> initializing all non explicitely initialized fields to zeros.
>
> Veronika's fix, that this improves upon, is enough for the problems
> detected so far.
>
> Or are you noticing some other bug that gets fixed by my patch?
>
> Ok, now I noticed that Veronika's fix:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.g=
it/commit/?h=3Dperf-tools&id=3D37e2a19c98bf99747ca997be876dfc13f9165e0a
>
> is marked with:
>
>   perf test pmu: Set uninitialized PMU alias to null
>     Notice: this object is not reachable from any branch.
>
> Being only in perf-tools-next:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/?h=3Dperf-tools-next&id=3D37e2a19c98bf99747ca997be876dfc13f9165e0a
>
> So yeah, probably Namhyung can cherry-pick that patch (Veronika's) into
> perf-tools for v6.11.
>
> There were a few more fixes that I noticed and picked for
> perf-tools-next that then people reported that should also be
> cherry-picked for v6.11, Namhyung?

Ok, I can pick this up.  I think my perf lock contention fix also can
go to perf-tools.
What others do you want me to pick up?

Thanks,
Namhyung

