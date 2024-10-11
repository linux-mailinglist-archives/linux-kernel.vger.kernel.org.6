Return-Path: <linux-kernel+bounces-361515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B099899A929
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C661C21CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C0019E993;
	Fri, 11 Oct 2024 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1WILygnj"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7818027
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665544; cv=none; b=d2k3sc9CGRr9omeXLuakYSfg4m5p/jIrM/O3kQNSYXcaCw5wGvtY+Rp7nlEk0yio9SD1AZJHFwu7pGnUD8ghLZxYXy5/hrkqEr6XKtvbOkoOaYQ2I7MR/4mZE1mYsToWboX/StHsycZPVLp2lHok0O0OS4Ke8rWwFN4cZL/sgno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665544; c=relaxed/simple;
	bh=NthClo5AnxaarNMb5Qh+0j2rMjzn/l80tfd+wgQu3+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqHdDNvaG8Jsy4gzCp3A6BSkUqU116Pik6bUOdSubMbXCg450//T7BpCf3uknnO59TKcAxq/EaWbxk/OuVyPEXK9I1HsDB1UxB5lbXojlTNKIvKaKnZaopOsSQzgNEj34OBZPW+VevjCG00DPV9rLIZzmmyh39tVTjHPQ6rmmxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1WILygnj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ca4877690so2285ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728665542; x=1729270342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPimW3AOtehNUkqhF51LIDldD47EJvyRRoaWLoxR7ic=;
        b=1WILygnj/8FcptDemOF6FrvIiNcppqQ12lHfVBMZK73MlZqB1FOkhn7DyFdkVvH9gH
         7xlZbcPNcFj2c20NoqU/Ju6tpYyfgsoKr5/b1cgvcGDGudC27ps4CUu2JLLeDoFEdyNg
         U6Vm2wLU9c7V1BSDWSVi+zF0L6AF75Hjc9HvRcNU11tZypbmys2o+qhStv/A+ahUA2Du
         O/JF3NyodWwoQ8lGB8woQahgAcXrueA/UkRQnHB18c6qOFeMy5xffroY+JdgQEmTgQJJ
         CdOOHNeE1gW5lAsCsV1o0F2zkxtAIcR438+8VckGcV4pubsGV8gHTGfeRkt+qtLZ6mpe
         SlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728665542; x=1729270342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPimW3AOtehNUkqhF51LIDldD47EJvyRRoaWLoxR7ic=;
        b=PnBSi2cels/YCrDKhBCc6hP/Q4nH0568MmKfwqcabyqhMXFwGsjYiaSDJeTAM0rGiV
         j+3EioUchk1bSsZyJrCGRPDjOctZLUcysAqHxyYLrdti7XVsNZqMp+jGgYo9C/ThDPAh
         vltQjmDyw39uy5B3IjOG/yfTrTJaDuRr0c2w4HfY4BsIo+lqXqHbcNI3w1xMgYF3XFC7
         Ib/GlN/pCuljtZc1zVY+4Dv3cHIvQLVPDPKwAoU99F4PDGLtD0r5S9bpnzE6RfxkloCw
         Oxci0Yakafr0Q0QpaHrR9a2lx8ZNdiQ3RiNGCAOuBISkXWU5Qr2CnG9qZC6K03XoT+sV
         W4hw==
X-Forwarded-Encrypted: i=1; AJvYcCWzyJSIaBCNo0EbQPy7/ejn7Uahaj+4xMCElvsULs24aBe/JJ6OHxA9x6QjwXPM3iCyVhZeEC4N1B9QS38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj/n9U8brxWcXMImpx4yvT1qurfEuZRFEbIEdkxjxS6N+g64F9
	CD4wmIUPPGMduYrRp6zFkoV4LBfrJL09qEK/ImlHbU7YAgs4fmvp7KA++foqvi6oP8yVh8/o9Av
	J3yzztH7U7UOPjx6HN1mLMM3Kc8t1dVRcM5y1
X-Google-Smtp-Source: AGHT+IH5lpLxRSv+Ef1lv9y8MK66pwPMKTVD9AsACrrkYKgXn/FVOuvAN7BqzEM0cVTwMVYTx3KoEdw8CA/zH6PY4TU=
X-Received: by 2002:a17:902:e802:b0:20b:bf5a:c8 with SMTP id
 d9443c01a7336-20c9ee6eda0mr3316825ad.10.1728665542180; Fri, 11 Oct 2024
 09:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011073559.431302-1-irogers@google.com> <20241011073559.431302-6-irogers@google.com>
 <c32f8c46-3895-49e0-a837-98859345039b@linaro.org> <affbe9b6-4d27-47d7-8767-9531f92b3d32@linaro.org>
In-Reply-To: <affbe9b6-4d27-47d7-8767-9531f92b3d32@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 11 Oct 2024 09:52:10 -0700
Message-ID: <CAP-5=fWep2dV4-1tzVDQ8z-Ud7tmnw4JBKqkpLoN=nRbbMpxVg@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] perf test: Tag parallel failing shell tests with "(exclusive)"
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 3:29=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 11/10/2024 11:01 am, James Clark wrote:
> >
> >
> > On 11/10/2024 8:35 am, Ian Rogers wrote:
> >> Some shell tests compete for resources and so can't run with other
> >> tests, tag such tests.  The "(exclusive)" stems from shared/exclusive
> >> to describe how the tests run as if holding a lock.
> >>
> >> Signed-off-by: Ian Rogers <irogers@google.com>
> >> ---
> >>   tools/perf/tests/shell/perftool-testsuite_report.sh | 2 +-
> >>   tools/perf/tests/shell/record.sh                    | 2 +-
> >>   tools/perf/tests/shell/record_lbr.sh                | 2 +-
> >>   tools/perf/tests/shell/record_offcpu.sh             | 2 +-
> >>   tools/perf/tests/shell/stat_all_pmu.sh              | 2 +-
> >>   tools/perf/tests/shell/test_intel_pt.sh             | 2 +-
> >>   tools/perf/tests/shell/test_stat_intel_tpebs.sh     | 2 +-
> >>   7 files changed, 7 insertions(+), 7 deletions(-)
> >>
> >
> > The following ones would also need to be marked as exclusive, not sure
> > if you can include those here or you want me to send a patch:
> >
> >   tools/perf/tests/shell/coresight/asm_pure_loop.sh
> >   tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
> >   tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
> >   tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
> >   tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
> >   tools/perf/tests/shell/test_arm_coresight.sh
> >   tools/perf/tests/shell/test_arm_coresight_disasm.sh
> >   tools/perf/tests/shell/test_arm_spe.sh

I'll add it to v2 and add your suggested-by. Thanks.

> > In theory all tests using probes would also need to be exclusive becaus=
e
> > they install and delete probes globally. In practice I don't think I sa=
w
> > any failures, whether that's just luck or because of some skips I'm not
> > sure.
> >
> > And this one fails consistently in parallel mode on Arm:
> >
> >    22: Number of exit events of a simple workload
> >      : FAILED!

This looks like it could be a real issue. I believe the test is doing
uid filtering:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/task-exit.c?h=3Dperf-tools-next#n49
uid filtering scans /proc looking for processes of the given uid. This
is inherently racy with processes exiting and we'd be better using a
BPF filter to drop samples with the wrong uid - same effect but no
racy /proc scan. I've seen the racy /proc scan cause termination
issues, so possibly this is the issue you are seeing.

It could also be that tweaking the retry count will fix things:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/task-exit.c?h=3Dperf-tools-next#n134

Anyway, for now I think it is expedient to mark the test as exclusive.

> > But it's a C test so I assume there isn't an exclusive mechanism to ski=
p
> > it? It doesn't look like it should be affected though, so maybe we coul=
d
> > leave it failing as a real bug.
> >
>
> Oh I see it says in the cover letter it can be set for C tests. But can
> that be done through all the existing TEST_CASE() etc macros?

Currently only whole suites can be exclusive. We could add macros for
exclusive C tests but my preference would be to make the test work
non-exclusive. I'll make test cases exclusive and mark this one.

Thanks,
Ian

