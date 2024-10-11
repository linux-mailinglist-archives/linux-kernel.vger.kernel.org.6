Return-Path: <linux-kernel+bounces-360865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0825299A0B1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B861F2505B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C7120FAB5;
	Fri, 11 Oct 2024 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TkMNdizR"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4701B20FAA2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640989; cv=none; b=fxJ6z446nRmzjvZ7Rp6StAIRHuu2W0W+WchN35V9wB52hKKO/zoKv2g4uB+yeXrqmFhQWOxo0wSngwupbXSR5lp/uS/OVDvbKBoUiK+yhjNzQnA1RNNV1ZuXD5gMNS6ng4O5mKYUrUlf3R9Z2SJqL/GKTS+d7EPN1wwEu/sY7hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640989; c=relaxed/simple;
	bh=naYtp1lZscek112KRpfBFbWur/ZMGekKLlhMvarC0mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=AcSGU2nnXZRd9TUosL+Us3mAM6Hbwwt+e/qha1h2SaSRgOsnAsSz9F7xeF+p9RnrzYlNf8qO3E5bZKc0oYEU01oWQDQ59TVsjj1/s/PJ+yxBoQIdGTSFlGhyfu8s9Mlr8WLxtHeWRkYWUj9mrOp9SiPZ2TR8w2Rj1NL6Ice8O40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TkMNdizR; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539908f238fso2262513e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728640985; x=1729245785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o6jLzclq8qqUVYgMZwk1ZImEBXfgfrGEoJFHygAMsyo=;
        b=TkMNdizRVap/C1imeUInAckxJXM96b8WCxjEgaGjeMZGHvHAnfBoEr7vJWnewsAIjc
         UhVLhDalZ9J0EFu84r1fjQ+vbaKcAp7rfVwwMm3QJClGyOK8UPthA0ta6uqop/z4KN7i
         48Z/PpUsY9yrq05Mb5jO26YG3UJBCujecbZAqGMZn/dI1LG15HbadBbvFF6oOw0TVS+z
         ebTzcJhad8HiUFdy5XhC9mEGZfAJhRacAocFrmOLW5Eq5O4UMNzgCdnEW3LcPKKQDrNb
         p/bVY5uFExJVCnwn9bXsFaV/+aX27L9GfbUvFYRIRInfQGH2B5WMhV/IIRmiRew+IHef
         GH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728640985; x=1729245785;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6jLzclq8qqUVYgMZwk1ZImEBXfgfrGEoJFHygAMsyo=;
        b=PVxQOfXX/aPMZoGzMxsaFa5DgBitPTt5G4oBPJFbeBCq9SjoOAFPN492AmnsjGs3zl
         Ar0CLA+X5+tfzYZVkvIi3kg33pzYvQBvZzvKh15SlFC203csxtr/EWqSFHTPAUFC+zje
         LXfYIgo3biumluC+6kp7TxP3YeaOTTMCWlUaRj8RDRyqj9lfXcwhdWmZVuP+Bdkq1sZS
         OwyzbdIvnH8slaraV3mFjhkydi3YklErzPLg1zw8KpGYqgt2NgVdvmAk0JKK38fqOpSW
         kocnfjMI+BDrHNtsJLzZI3Q2oQjEotJSnuTUQMZzdMV4MGyPwDB47g7EjGn94YYJJ6Yj
         gUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqHuydnZiGc0BSsssgL2TquswS7OGdXSA1rfNNF5qPIiVDPv0eJcm/3V559iqyRMfpyaVU4qkL+G30aE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdo4h9pgqSch7Ki2HI35rV7Pcx2uIWbrsAczfEOWiSoaU7QQES
	ToF6caPzOIoWsDqqS/V2svJkuf7dWwBZehhZijGqD46mXMUQff6ZXqRb5X8ZcBk=
X-Google-Smtp-Source: AGHT+IE4hHizV9yL/qQxX0Tp93XhlA79njW9O2LII+4OIQZhCEMoD5n1Aaf7picS5VfgYT1c3YFdlQ==
X-Received: by 2002:a05:6512:3045:b0:539:a039:9bb6 with SMTP id 2adb3069b0e04-539da58cf3cmr1010640e87.56.1728640985323;
        Fri, 11 Oct 2024 03:03:05 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d78dcsm38257665e9.5.2024.10.11.03.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 03:03:04 -0700 (PDT)
Message-ID: <231a275e-00db-499b-92a4-259dab8f9d80@linaro.org>
Date: Fri, 11 Oct 2024 11:03:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/8] Run tests in parallel showing number of tests
 running
To: Ian Rogers <irogers@google.com>
References: <20241011073559.431302-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>,
 Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
 Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova
 <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>,
 Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241011073559.431302-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/2024 8:35 am, Ian Rogers wrote:
> Avoid waitpid so that stdout/stderr aren't destroyed prior to wanting
> to read them for display. When running on a color terminal, display
> the number of running tests (1 if sequential). To avoid previous
> flicker, only delete and refresh the display line when it changes. An
> earlier version of this code is here:
> https://lore.kernel.org/lkml/20240701044236.475098-1-irogers@google.com/
> 
> Add a signal handler for perf tests so that unexpected signals are
> displayed and test clean up is possible.
> 
> In perf test add an "exclusive" flag that causes a test to be run with
> no other test. Set this flag manually for C tests and via a
> "(exclusive)" in the test description for shell tests. Add the flag to
> shell tests that may fail when run with other tests.
> 
> Change the perf test loop to run in two passes. For parallel
> execution, the first pass runs all tests that can be run in parallel
> then the 2nd runs remaining tests sequentially. This causes the
> "exclusive" tests to be run last and with test numbers moderately out
> of alignment.
> 
> Change the default to be to run tests in parallel. Running tests in
> parallel brings the execution time down to less than half.
> 
> Ian Rogers (8):
>    tools subcmd: Add non-waitpid check_if_command_finished()
>    perf test: Display number of remaining tests
>    perf test: Reduce scope of parallel variable
>    perf test: Avoid list test blocking on writing to stdout
>    perf test: Tag parallel failing shell tests with "(exclusive)"
>    perf test: Add a signal handler around running a test
>    perf test: Run parallel tests in two passes
>    perf test: Make parallel testing the default
> 
>   tools/lib/subcmd/run-command.c                |  33 +++
>   tools/perf/tests/builtin-test.c               | 267 ++++++++++++------
>   tools/perf/tests/shell/list.sh                |   5 +-
>   .../tests/shell/perftool-testsuite_report.sh  |   2 +-
>   tools/perf/tests/shell/record.sh              |   2 +-
>   tools/perf/tests/shell/record_lbr.sh          |   2 +-
>   tools/perf/tests/shell/record_offcpu.sh       |   2 +-
>   tools/perf/tests/shell/stat_all_pmu.sh        |   2 +-
>   tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
>   .../perf/tests/shell/test_stat_intel_tpebs.sh |   2 +-
>   tools/perf/tests/tests-scripts.c              |   5 +
>   tools/perf/tests/tests.h                      |   1 +
>   tools/perf/util/color.h                       |   1 +
>   13 files changed, 226 insertions(+), 100 deletions(-)
> 

Not really a big deal but remaining doesn't work when a subset of tests 
are run:

  $ perf test 111 110
  110: Check Arm64 callgraphs are complete in fp mode      : Ok
  111: Check Arm CoreSight trace data recording and synthesized samples:
    Running (150 remaining)

Other than that:

Tested-by: James Clark <james.clark@linaro.org>


