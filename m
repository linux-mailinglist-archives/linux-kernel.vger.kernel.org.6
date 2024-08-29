Return-Path: <linux-kernel+bounces-307689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059D4965181
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6DE328600E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0441B5EC5;
	Thu, 29 Aug 2024 21:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8zW67Fw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF3E1AE87B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724965753; cv=none; b=BKd9dMz2xkgQs9JRMdDL3X6Axd5e72MIu/rSg7LGBTUDZ4wi2zgcEeRPESSnQTYhUgeomLQylN7zK0r68zK44bofMQdB2g8rIW2qAoNNLQD8bwWwd/bZdf/fBm8PBJ7GgznRTL2NowmpR2dIVEOBDsL2W+z3NXA8jdaecILj+EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724965753; c=relaxed/simple;
	bh=gQBV4n/0RiFx2vmjbP/p5g1dpzh1pN9HHZdx24O449Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBD5K4x7vPGxgYX/S2QICiFoqG5nSkWD9Y73icN5SbHcRZUvKZfbftxAQZFIYGMqe0yppl1RXoEScmRfGBQO6ycF0gyjSdzPeaGnCpOQA2YfNlCUCylSBMqCoWXcCntNAdpX/k8HLUPGQ4Qffp3tkqQN9yPLwWyz+3XE5wrlsOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8zW67Fw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D214C4CEC2;
	Thu, 29 Aug 2024 21:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724965753;
	bh=gQBV4n/0RiFx2vmjbP/p5g1dpzh1pN9HHZdx24O449Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r8zW67FwTB5gVJjEIAMbpDQ3hDmdYl/D4rj6G5jABAQqd2jMsawmP+7E+XYdLLLcZ
	 ugiN6KBblybNcRdx9swjMPCMAOyakAlXpSQOGLoIqqns98fOi7kdO1R+YpIOYeckME
	 FqwW7ZNLzAKIIkIKpys8bBGYirmoLBt0NyEuVyirVo8+mklQfI6KsZx5Yau5S5XSlu
	 QSgDeaCrEfpwbGrVLbnU4yYCJYkc5NFzZO5f1K8vc13NaiDoZF1ZwKFaTqOld8GtSj
	 JpXhexVZTiLz2laeG+YDcI1hoK50EYLLTaHaxC0vpYKEAqwuVojFX39v7mDS3m4C9q
	 4HT6TAxVUlS1A==
Date: Thu, 29 Aug 2024 18:09:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Veronika Molnarova <vmolnaro@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Radostin Stoyanov <rstoyano@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf tests pmu: Initialize all fields of test_pmu
 variable
Message-ID: <ZtDjdt1QwbxJVKZ0@x1>
References: <ZroIIXkmErNGZjQO@x1>
 <e26941f9-f86c-4f2e-b812-20c49fb2c0d3@redhat.com>
 <CAP-5=fXFH8aqxzCVAgRRdZufUdiC2UMBApEeSnak3yhZ_CXNyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXFH8aqxzCVAgRRdZufUdiC2UMBApEeSnak3yhZ_CXNyA@mail.gmail.com>

On Thu, Aug 29, 2024 at 01:17:13PM -0700, Ian Rogers wrote:
> On Mon, Aug 12, 2024 at 7:05 AM Veronika Molnarova <vmolnaro@redhat.com> wrote:
> > On 8/12/24 15:03, Arnaldo Carvalho de Melo wrote:
> > > This makes the code more robust, avoiding the error recently fixed when
> > > the .alias_name was used and contained a random value.

> > > +++ b/tools/perf/tests/pmu.c
> > > @@ -458,10 +458,10 @@ static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __
> > >  static int test__pmu_match(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> > >  {
> > > -     struct perf_pmu test_pmu;
> > > -     test_pmu.alias_name = NULL;
> > > +     struct perf_pmu test_pmu = {
> > > +             .name = "pmuname",
> > > +     };

> > > -     test_pmu.name = "pmuname";
> > >       TEST_ASSERT_EQUAL("Exact match", perf_pmu__match(&test_pmu, "pmuname"),      true);
> > >       TEST_ASSERT_EQUAL("Longer token", perf_pmu__match(&test_pmu, "longertoken"), false);
> > >       TEST_ASSERT_EQUAL("Shorter token", perf_pmu__match(&test_pmu, "pmu"),        false);

> > Reviewed-by: Veronika Molnarova <vmolnaro@redhat.com>
 
> This seems like a simple enough fix for a test that it could be
> cherry-picked into perf-tools for v6.11, I'm not seeing it currently:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git/log/tools/perf/tests/pmu.c?h=perf-tools

This is not a fix, its just to make the code more future proof by
initializing all non explicitely initialized fields to zeros.

Veronika's fix, that this improves upon, is enough for the problems
detected so far.

Or are you noticing some other bug that gets fixed by my patch?

Ok, now I noticed that Veronika's fix:

	https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git/commit/?h=perf-tools&id=37e2a19c98bf99747ca997be876dfc13f9165e0a

is marked with:

  perf test pmu: Set uninitialized PMU alias to null
    Notice: this object is not reachable from any branch.

Being only in perf-tools-next:

  https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=37e2a19c98bf99747ca997be876dfc13f9165e0a

So yeah, probably Namhyung can cherry-pick that patch (Veronika's) into
perf-tools for v6.11.

There were a few more fixes that I noticed and picked for
perf-tools-next that then people reported that should also be
cherry-picked for v6.11, Namhyung?

- Arnaldo

