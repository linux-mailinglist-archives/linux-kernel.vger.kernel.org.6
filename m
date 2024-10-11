Return-Path: <linux-kernel+bounces-361485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DC699A8DE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9A51C212E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F9C19922F;
	Fri, 11 Oct 2024 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnyqjGjI"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978AB198E7F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663999; cv=none; b=nQTusQmI7itC0loPLAHq+YKrBeyweYVVxXGwn7iWiKE5zXDIWhVcY6UooeOXwvn+SHRTb6ln0N5uHbF8K3tfitxy+5Hg8c9fSxfu3ujRqidzt2CYSer9uDLanHun0bcJxo9h8Q2tFTzEnNK7BJ8kpomxnnf7C7AShYnoRfiZ77o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663999; c=relaxed/simple;
	bh=JJfLcSJT6SUfxQIYKsr7yBThKwI/qs9OrJLzfzkQ++E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjJ6f5OGZaEr8pGuxlqVN58Z+zRtu+RZTTX/iiLTVUiaRO6KYERz+lXRbdRW2/BECt0T7irFOKYThNWEfLqPav8JDSXPI5EaIaH5lfXNsAZwiA673VCOCXva8Izuployn1AMmFBkFUvtUswM7AGk/pO3kBOfuDdimZMh0lrZuFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JnyqjGjI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c8ac50b79so226705ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728663997; x=1729268797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgBi2CgoUh+yA9kfntiaJkcuQrlnuJ/H6QCxY+XAqP4=;
        b=JnyqjGjIJjxGLG6QIzwwVKp02T0FC0W1wHjDtvjOJPTep6yU3dvz3ihkskmgCH7Sly
         BlDvAzug4DjRRQ0ey8yjAlKG2hLtCdclv7yuMDpL22lxXOhp8kCL6wTDjq5OjRxipj16
         v88AmlPXz2hZMiepxGrj1nSRHzhc7Rd7f9sQDN7klG1awRKV11kC/ry28u2VtS+fpqSI
         eju5lyYIGLHRkBflOMtO8ou2427UP4H+8Zo5u59Iod7HgZSGgSN9tuBwQxsC9MuqwPTL
         NYBBK0NMwu51jCbpnC3FS7+7ssAy45a1xK4pfP4/SqGRfjIZ5lBVXxubh5TnQDALRv+a
         hk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728663997; x=1729268797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgBi2CgoUh+yA9kfntiaJkcuQrlnuJ/H6QCxY+XAqP4=;
        b=CRKpzXCAQ4R8rJOBlpUe0W201VTcRRRbfIWnro/YSpTBbPu1LzwqhYEoDY0mQWpHTf
         dfiSEJKg1uULfIABpdDvpyoOA4sThJFy9qsCKyuHAn6HFtnTc005q3LmxJZKRLv3fBI7
         6RUbZBg3N6t2kAcKM/F3ow7yXn7cKLXvltQg8dRy01Osnpk1Wiy9pReX5khPR/owbNPI
         NIuSC7oJxxse2o7FceljogbaliTqjNnov5CSOei2pV7S1mJjFXa8YoHsu1XOs8OqYVfy
         ChWjPBVV1wry3KMJDbgQeIjjBXVObSIYicR+WXVsS3EgOCqZbUcuTjY+EBPnxCCwLb7E
         qFxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNvWuAGjVxgBdrRlHv7p0ILKSeQTL7pXABva62LhWOIs9Jx6rjzB7m0wqFTXMENLhX8KvudA3M8P8hEYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJnX15b4fv8aRcWkhCQTdMcRNuiscuedeNCiIqaIEEZpySrYW5
	WXOjktHaN/WdwM8pnOxwcxfq20Ehe9ciWxxIDtpaqr26QCs1M4Ub5XUnaWr2kCNqJ8tf/KRqQjZ
	NfzS8oE3iJ0CGGLP7QoAxxx/DwW32qkLpkSgJ
X-Google-Smtp-Source: AGHT+IHqtIXHbgDwBWNWcYCygzM0IEEDf/gvIXxqhjoKQACQ+ujuHX041JX4SWBZXmd30WXWWV5AC5KXwn/M4cQNoc0=
X-Received: by 2002:a17:903:27cd:b0:20c:a97d:cc83 with SMTP id
 d9443c01a7336-20ca97dd06amr1662835ad.16.1728663996483; Fri, 11 Oct 2024
 09:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011073559.431302-1-irogers@google.com> <231a275e-00db-499b-92a4-259dab8f9d80@linaro.org>
In-Reply-To: <231a275e-00db-499b-92a4-259dab8f9d80@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 11 Oct 2024 09:26:19 -0700
Message-ID: <CAP-5=fULBYVqrgcQ1hHgou29HATOtXfZxR84r-Q2WTccT7SOBg@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] Run tests in parallel showing number of tests running
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

On Fri, Oct 11, 2024 at 3:03=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 11/10/2024 8:35 am, Ian Rogers wrote:
> > Avoid waitpid so that stdout/stderr aren't destroyed prior to wanting
> > to read them for display. When running on a color terminal, display
> > the number of running tests (1 if sequential). To avoid previous
> > flicker, only delete and refresh the display line when it changes. An
> > earlier version of this code is here:
> > https://lore.kernel.org/lkml/20240701044236.475098-1-irogers@google.com=
/
> >
> > Add a signal handler for perf tests so that unexpected signals are
> > displayed and test clean up is possible.
> >
> > In perf test add an "exclusive" flag that causes a test to be run with
> > no other test. Set this flag manually for C tests and via a
> > "(exclusive)" in the test description for shell tests. Add the flag to
> > shell tests that may fail when run with other tests.
> >
> > Change the perf test loop to run in two passes. For parallel
> > execution, the first pass runs all tests that can be run in parallel
> > then the 2nd runs remaining tests sequentially. This causes the
> > "exclusive" tests to be run last and with test numbers moderately out
> > of alignment.
> >
> > Change the default to be to run tests in parallel. Running tests in
> > parallel brings the execution time down to less than half.
> >
> > Ian Rogers (8):
> >    tools subcmd: Add non-waitpid check_if_command_finished()
> >    perf test: Display number of remaining tests
> >    perf test: Reduce scope of parallel variable
> >    perf test: Avoid list test blocking on writing to stdout
> >    perf test: Tag parallel failing shell tests with "(exclusive)"
> >    perf test: Add a signal handler around running a test
> >    perf test: Run parallel tests in two passes
> >    perf test: Make parallel testing the default
> >
> >   tools/lib/subcmd/run-command.c                |  33 +++
> >   tools/perf/tests/builtin-test.c               | 267 ++++++++++++-----=
-
> >   tools/perf/tests/shell/list.sh                |   5 +-
> >   .../tests/shell/perftool-testsuite_report.sh  |   2 +-
> >   tools/perf/tests/shell/record.sh              |   2 +-
> >   tools/perf/tests/shell/record_lbr.sh          |   2 +-
> >   tools/perf/tests/shell/record_offcpu.sh       |   2 +-
> >   tools/perf/tests/shell/stat_all_pmu.sh        |   2 +-
> >   tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
> >   .../perf/tests/shell/test_stat_intel_tpebs.sh |   2 +-
> >   tools/perf/tests/tests-scripts.c              |   5 +
> >   tools/perf/tests/tests.h                      |   1 +
> >   tools/perf/util/color.h                       |   1 +
> >   13 files changed, 226 insertions(+), 100 deletions(-)
> >
>
> Not really a big deal but remaining doesn't work when a subset of tests
> are run:
>
>   $ perf test 111 110
>   110: Check Arm64 callgraphs are complete in fp mode      : Ok
>   111: Check Arm CoreSight trace data recording and synthesized samples:
>     Running (150 remaining)

Thanks, I'd been so focussed on other issues that I'd missed testing
like this. v2 will fix the "remaining" but I've renamed it "active" as
the count doesn't reflect the remaining tests as exclusive tests will
be missing and they will show 1 test remaining which isn't accurate.

> Other than that:
>
> Tested-by: James Clark <james.clark@linaro.org>

Thanks,
Ian

