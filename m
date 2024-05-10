Return-Path: <linux-kernel+bounces-176136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 892CF8C2A69
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5C11F23935
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F94481BA;
	Fri, 10 May 2024 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gL6NtgmR"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8C2770C
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368569; cv=none; b=K4vl9JDEisWa8ZbHGrWviNycI5NehSoDXKfmKVPLwGIRh69Iyzrt5NrXHI0CvnHQZYbp7A6dAJ3WxmDur1hcng+grseR+uKFsW28DNhZtYFg+P5ScB0bevL3llQgd9l8WPl03kNiJw9Gqa4fn8NFcO23BZqNmrQK67QWYrtvi6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368569; c=relaxed/simple;
	bh=HSek40Kmp8UYD79s6PacIEy1fMXsFf57BBsWNTeAAfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=S/VkLKjM3O1chE3AYNtK4X6VQSHnaHHfe0f1L3rXzYwmxfexwOrEkS5hGYvyrpixMJoPoyp8QY2O96kMt1iC8bXQWa2ba+JDmddRESz8nB9Ss895QApbapvoXxrg9PxK3+yb0fQuIm0uaoIYPVyyVScfs1cZxMsrr444IN0kGTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gL6NtgmR; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43df9ac3ebcso56521cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715368567; x=1715973367; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLePWLlO1FMCtiS0T/B6hmJEHnrLSEzEWYLSk5IFE9A=;
        b=gL6NtgmRTrbv9YWiqrwGh+h5sL+vxakljGY4KP2qfDLboFJ6gt5mUugJq3Ddt283OY
         m+pqTDIPGQWNfCLxzALxWAdNtf2wK6j38Ij3/xoiOo8ftJ/l0eWzuZJwaGNKn4OkD+zR
         1vQSiP0b8MfaW6872FwwrPX37FvUNxQW/ihYQ6cDHJeixlhNdrucH2NBvOGnyJ60ZuvJ
         FNEPh+0bVNBBma2+kQPaM+e+jQTs5Dvb9Fc6xJWNnTG5D5PlJBmBYPZIFItuSOTqDABD
         aHEmoPfJvQ60kqSFoG50oI6c9YS5KqKMvJcoJE0azdNjvfujf9r7+j1Xb4JwwIgPHLG7
         Z3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715368567; x=1715973367;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLePWLlO1FMCtiS0T/B6hmJEHnrLSEzEWYLSk5IFE9A=;
        b=EXgXjfBoPe6ujgclNz3Gw+0gTQLDHdes5Xw7kOPBmSuiRBJVV6fdSTLrDoS0Ijj/Ax
         dwUO7ljtFG0QsbuJ/sOK7jqVSvoKulYMZHff3kb29GBvwxEkGorpfXDQNn9G0Wp4YQo9
         WEZVKHABEVQ9oQPiJ0Vki8kHN/bde1cnSgmHf3+MNKltVkNqaRvU4VheJNY0CkQ2Bvj2
         KmJeZKwJdU4g8CrdJL5R5CxmF4+U/wYWXOaJb1TvDSvKKuknQv+r/rDmuKcpJ+RlGHLr
         9+OV0Stk13ru/37p+vGspWGKUyJYJzrXkNlSVowVycQ77nbwEQZIHg0Sx5Bq5JX95LrJ
         C7lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnBsECKM0qQWZEXpG++teggHubvK1jpLSDVOx/W0k9aQl/5BBgxYEBHGkCsyXu9l87kPg/uAEJmwYZRLMdRKO1Hxny8ZWkHf2eqe4r
X-Gm-Message-State: AOJu0YzHeeFieC4p/BR6WDHePnDiqKB1FMmcLeBS9IrbWsRoJtnca7Pw
	3paZW3P9rW/H0QELeuUNS04dB77LtNdwAbw15o4V16jMmSKXy9P8WYXaAE3t73SZQR9lniBe8PG
	+HofnM1guJkiU2UeDrBnzKz7TIIAj0a7dkhro
X-Google-Smtp-Source: AGHT+IFDUy2tc99ghId8O6iiguPxUhm1Vs+n9s6f2Absozkmlx7+QxkdEcEpLr6oLhQ8grVm9xpwcRT/fm5ulLkdGsk=
X-Received: by 2002:a05:622a:1b22:b0:43b:43c:2e05 with SMTP id
 d75a77b69052e-43e097011demr246651cf.19.1715368566650; Fri, 10 May 2024
 12:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505031624.299361-1-irogers@google.com> <CAP-5=fVSAQOXbSfpSLTVkWcZKGx+LqiuC_ZkCxnc0iPtyfrzvQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVSAQOXbSfpSLTVkWcZKGx+LqiuC_ZkCxnc0iPtyfrzvQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 10 May 2024 12:15:53 -0700
Message-ID: <CAP-5=fXuneU6ockdzFcnLGqATKkEfvEuTa778Hj92rBmkbiS1w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
To: Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>, Tuan Phan <tuanphan@os.amperecomputing.com>, 
	Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 11:13=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Sat, May 4, 2024 at 8:16=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > The mrvl_ddr_pmu is uncore and has a hexadecimal address
> > suffix. Current PMU sorting/merging code assumes uncore PMU names
> > start with uncore_ and have a decimal suffix. Add support for
> > hexadecimal suffixes and add tests.
> >
> > v3. Rebase and move tests from pmus.c to the existing pmu.c.
> >
> > Ian Rogers (2):
> >   perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
> >   perf tests: Add some pmu core functionality tests
>
> Hi, these patches have been hanging around since March [1], it would
> be nice to either be landing them or getting feedback on what to fix.
>
> Thanks,
> Ian
>
> [1] https://lore.kernel.org/lkml/20240329064803.3058900-1-irogers@google.=
com/

+Tuan Phan, Robin Murphy

Here is another PMU with the same suffix convention/issue:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/drivers/perf/arm_dmc620_pmu.c?h=3Dperf-tools-next#n706

Thanks,
Ian

> >  tools/perf/tests/pmu.c | 95 ++++++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/pmu.c  |  4 +-
> >  tools/perf/util/pmus.c | 53 ++++++++++++-----------
> >  tools/perf/util/pmus.h |  7 +++-
> >  4 files changed, 131 insertions(+), 28 deletions(-)
> >
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> >

