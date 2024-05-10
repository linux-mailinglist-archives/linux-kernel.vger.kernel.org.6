Return-Path: <linux-kernel+bounces-176087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191CD8C29BD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F67C1C2136A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C173F25779;
	Fri, 10 May 2024 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b2Biy/VG"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F97D18EA1
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715364833; cv=none; b=Ks/vuQu6CDY1pRYJTsYr1bnlcOeNW5pmNxqgk8mZfE+621ZSKqmWupA1XDe/1ZH2a4uEby8KJCQ/fqFzQez0Aj+4dtnJF6m3+9RrPoexIFSCqP+k43C4ahxuzScA2zkwczCbQwYcBUFHaR5vswOQzBz9r0Y/dTJbE1mmK4w3h9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715364833; c=relaxed/simple;
	bh=t4K3aj+Qg+DY7iHNJVbgeEYoin9ImKEn5FRMCsBcwks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ODYOGKUatpM8YHVhhLTmOirIGRXCmfkBeSqNOk0CRsPi+YxiuRLjypWFZXS/MUXBBTYA2PBrtY2kb5T2yauNWlqJ7+jKw+EJvBON9antVluzX2CarsWAUbXx5hpziqOepUe/BBR86M+f06A+Ol0hpWyTnXsBUXloJ21vmuXIzZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b2Biy/VG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-439b1c72676so31631cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715364829; x=1715969629; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awbg1hXHMBJgOYCrGAE0ipMK3UY/AVrGWhRCU4GMaY8=;
        b=b2Biy/VGw50x3T3UuqP1/VVLjtSMd5YQ1qLUo1O0Q623UnL0BhjELKNs1f8K7+1oic
         EY4FAxFlDjxEINmjbJLDQQUvx1O26yFKVkmdoj9BrMVluB2cdrOsZGxS3CGZjyZxtg/V
         /kWumo9s0/jSEvTbTOwH4Z9Wl0sPYXg7xDaQQ7oYUuZ6H/q35la5V6wg9Sn2wm0QczUs
         IArMVkkk1kGQ6qOaLeyCM89i0WStj/N0nHvLTY6kJclfSqKKZeyhufMSQTf2j4ejZZiA
         WaY6rBCR87nZtzlWlpWpl0jfcG0uSyEBWLaQu1uBc/cKqrjmBmdegB9Hf2b/EaTmuqrB
         59ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715364829; x=1715969629;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awbg1hXHMBJgOYCrGAE0ipMK3UY/AVrGWhRCU4GMaY8=;
        b=AgPxkr0xfvfPolK03f5uSNuXmb1MInCM3ALxWYldH9vp2IAJgZ/NZ7oz/DXr4PAk+K
         AuvYLlCDq0p74iBVL1FzrJsVABW1cS/uy6W6fCp0woLl0DGfE4NyEb9NYx0Y1xQIo45s
         6dgoDIZ8SEjor0GgbMfXOo4B7t50hXLlScEc3eXEJdaNsAGKn5He3a0DQ5G+yM6ESrt8
         t5fdRcO8s7fLgBKx1GQC5hfR3i1dhomv5xyasQS8ftkzI0PdFr/e1mV6Kh6h2hm08aqA
         MN2K+5BIv9x4of/anTU8d7hfbpYXa7X83wInKfCoc9Ir8jS4ZTqD53+R0MreHp1QEFye
         kQqg==
X-Forwarded-Encrypted: i=1; AJvYcCUOQ69A6QabUHvV/gMqJcr5OQjco7HlaxfJJHIXOCFd1qEpden3WcozVmkTCrVjhwadeXVO2+bClxV6Ns5x7QELBg1ubfCDYG1VNGLi
X-Gm-Message-State: AOJu0Yzsbr2KTebNx9kwDSph7/VYh3d+YfCMve8ZTpZjlo07UsJTKac6
	vNQnrNLahkEyqlXOvy0LKOtRrcAGLT2oTZwPwp5tMwUoA0DTdUaUTaKEFJG7DW40D/Ten2a8r8f
	0DA/AWcxWDgpnp2mmVneJ053q+Tn1y+Hj/J1f
X-Google-Smtp-Source: AGHT+IHed/SSXFd7UB/8BtmerloL3E1Jl/Hl2Ocgkk5LRBYR3cjzr2/OJ3RNL8woXCagYxNtcvof15fYxmywrF5Wk6c=
X-Received: by 2002:a05:622a:5407:b0:43d:e9ce:63ad with SMTP id
 d75a77b69052e-43e09222ee6mr278621cf.0.1715364829085; Fri, 10 May 2024
 11:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505031624.299361-1-irogers@google.com>
In-Reply-To: <20240505031624.299361-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 10 May 2024 11:13:36 -0700
Message-ID: <CAP-5=fVSAQOXbSfpSLTVkWcZKGx+LqiuC_ZkCxnc0iPtyfrzvQ@mail.gmail.com>
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
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 8:16=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> The mrvl_ddr_pmu is uncore and has a hexadecimal address
> suffix. Current PMU sorting/merging code assumes uncore PMU names
> start with uncore_ and have a decimal suffix. Add support for
> hexadecimal suffixes and add tests.
>
> v3. Rebase and move tests from pmus.c to the existing pmu.c.
>
> Ian Rogers (2):
>   perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
>   perf tests: Add some pmu core functionality tests

Hi, these patches have been hanging around since March [1], it would
be nice to either be landing them or getting feedback on what to fix.

Thanks,
Ian

[1] https://lore.kernel.org/lkml/20240329064803.3058900-1-irogers@google.co=
m/

>  tools/perf/tests/pmu.c | 95 ++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/pmu.c  |  4 +-
>  tools/perf/util/pmus.c | 53 ++++++++++++-----------
>  tools/perf/util/pmus.h |  7 +++-
>  4 files changed, 131 insertions(+), 28 deletions(-)
>
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>

