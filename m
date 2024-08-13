Return-Path: <linux-kernel+bounces-284992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D15A9507D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2B21F21CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6BE19E7E3;
	Tue, 13 Aug 2024 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WyUOpuux"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30919DF99
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559743; cv=none; b=j0axevnitHOZvcISMKXkwTJFcQMMqofgArVKKEEKPHvB7+uj1b05/lhusIBtTs/RCaoDGZ3kmf0ACRAMy1dYydNs7SrUtBxHOFr48nUmlnXux+palSyLNaIU75KIUOu97xy65F+BYbdCjXivT0FVMYsWR3Y/eLfG09xKHmojoG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559743; c=relaxed/simple;
	bh=/U0bEOSp/3QdNXRfWrsK41EAsnN5dwry0LytGlDVYsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rh1/NOing8NFZhQ0383WbdXs7eJNOEI+D06lM6O9Yjk/YWxOtamnjjSJrHZLA3fgkgBRQ9tKOQ0ERQgSHdIsbo7kNOiUVi0o2209oRuAvKP78309vWKRLTrEWBicxoIWmICRwoGZReXaML6fPi+gqFP2Ry3qxk4ZgXgOmpUkc54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WyUOpuux; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd657c9199so76995ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723559740; x=1724164540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7pc96sK52WRBwn+cvdiy9TXwY56asjOvTauds/TjSE=;
        b=WyUOpuuxcguJsfi72VdNEPxG74cjdtnvS3ymyyvL8dylIAVDolgFmtnHf1FLbZHKOI
         gI7o2n/x3gwFjwdztii8hHLsYrGSM5rvByjJeyK7GkDtLEmknNvvJEbCQGuX59SbUWi7
         2p6tGZ6eRc42nUBnrLAvNIZ4IaPsClg9EtYsm5jrGW034JtHdV2Fcpi1+wpb88LCjN/E
         1hRj17n60IQwvLTIhef6eq0PfowKjWwHr86Ae9kml9D7FiSR1M1B9YJRtCe4ZGP/Dpuf
         s0caBRHLJRkbqodvbaxYuGqwoqnRzNMsT89WiRs9IoCkm3O2qKAlNSsqR05oajefjauI
         EGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559740; x=1724164540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7pc96sK52WRBwn+cvdiy9TXwY56asjOvTauds/TjSE=;
        b=MTX5FP3eu7011oT8hi+4LqtWKv3+EArnZPkPoWUqRnxHX3W0KJrrxct411krHfg4Ln
         CXxx/wI0XmhEVsltFYHTuSLPb0FBOLYsxmIv9LlJHeVbTgBS+LU1ZxB3q1AFzBUjMi9B
         f39XVMcB6+z+zMu0aFLaNictJS3KFnl1ZoqG4fqJYgQFJr3ElxJA+RIS6hBfprVqVEjd
         HOvTRCfcemi5k8wk3uqRiAG3UtCMSgq0u/KU2beW5DdDSaWaPQfkPpAhq+rfXNma2S3y
         PeCvUri8qcynmMoETr71dJcIP6Nhq2WtXSQLvijdGSnGz7Wvgg0MKKlpqnSc+23bunvc
         1K8g==
X-Forwarded-Encrypted: i=1; AJvYcCXfgCmFsyhrr2WA4nbTS6q4MjFH79oGa52GRTuADXu4z3W6iadK1ax1mv9SH45jtcYgaAUfNEw691FLaxgv6ZdOE1CxYdJs7MfhGFQZ
X-Gm-Message-State: AOJu0YxKNNat/dNFVxOyML38GdLZ9BOwmr5XXbtY1KxtsWKmqFKvqG6P
	Cn/Nm1qJPA7ZO+k/87hy1Wf2g0ZGa918xzWHF/t/KUdXFrDcfVOnN7L3vRC5glSKcVsdiaWJpA4
	uz0P15ZQCbWAMjuQMR51R4MJagAyjRHwQPxut
X-Google-Smtp-Source: AGHT+IE0VoC9VcV6SgZkxmyeAJGUUTFJJ9xLJ8cYKbx41BA9DBvjiYvv/gf36S/dHf7zHn5/HI4NvYNzjlRN3bKejUg=
X-Received: by 2002:a17:903:2302:b0:1fb:2924:5c7e with SMTP id
 d9443c01a7336-201cdc2cfc4mr1273945ad.11.1723559740228; Tue, 13 Aug 2024
 07:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813132323.98728-1-james.clark@linaro.org>
In-Reply-To: <20240813132323.98728-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Aug 2024 07:35:27 -0700
Message-ID: <CAP-5=fUVchraZxYg9LY-CtqYZ5DN05-T3vhJmaUG+24Ka6Bsyg@mail.gmail.com>
Subject: Re: [PATCH 0/7] perf stat: Make default perf stat command work on Arm big.LITTLE
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong1@huawei.com>, 
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 6:24=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> The important patches are 3 and 5, the rest are tidyups and tests.
>
> I don't think there is any interaction with the other open issues
> about the uncore DSU cycles event or JSON/legacy hw event priorities
> because only hw events on core PMUs are used for the default
> stat command. And also just sharing the existing x86 code works so
> no big changes are required.
>
> For patch 3 the weak arch specific symbol has to continue to be used
> rather than picking the implementation based on
> perf_pmus__supports_extended_type() like in patch 5. This is because
> that function ends up calling evsel__hw_name() itself which results
> in recursion. But at least one weak arch_* construct has been removed,
> so it's better than nothing.

Let's not do things this way. The use of strings is architecture
neutral, means we don't need to create new arch functions on things
like RISC-V, it encapsulates the complexity of things like topdown
events, Apple ARM M CPUs not supporting legacy events, etc.
Duplicating the existing x86 logic, when that was something trying to
be removed, is not the way to go. That logic was a holdover from the
hybrid tech debt we've been working to remove with a generic approach.

Thanks,
Ian

> James Clark (7):
>   perf stat: Initialize instead of overwriting clock event
>   perf stat: Remove unused default_null_attrs
>   perf evsel: Use the same arch_evsel__hw_name() on arm64 as x86
>   perf evsel: Remove duplicated __evsel__hw_name() code
>   perf evlist: Use hybrid default attrs whenever extended type is
>     supported
>   perf test: Make stat test work on DT devices
>   perf test: Add a test for default perf stat command
>
>  tools/perf/arch/arm64/util/Build   |  1 +
>  tools/perf/arch/arm64/util/evsel.c |  7 ++++
>  tools/perf/arch/x86/util/evlist.c  | 65 ------------------------------
>  tools/perf/arch/x86/util/evsel.c   | 17 +-------
>  tools/perf/builtin-stat.c          | 12 ++----
>  tools/perf/tests/shell/stat.sh     | 33 ++++++++++++---
>  tools/perf/util/evlist.c           | 65 ++++++++++++++++++++++++++----
>  tools/perf/util/evlist.h           |  6 +--
>  tools/perf/util/evsel.c            | 19 +++++++++
>  tools/perf/util/evsel.h            |  2 +-
>  10 files changed, 119 insertions(+), 108 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/evsel.c
>
> --
> 2.34.1
>

