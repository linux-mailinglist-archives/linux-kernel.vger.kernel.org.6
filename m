Return-Path: <linux-kernel+bounces-176144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECBE8C2AAF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCC19B21531
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858E74AEC3;
	Fri, 10 May 2024 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lhM08lbA"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EDF481CD
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369448; cv=none; b=YagkSs8rCNvSWTky2lLYLRjgQcCz+s441/WlgwjWSBu+iGd1G/G53UkzRPea5S/3P4Via6EqHF9QBU+lm1OCk/aWr9rVB0uEvmadjh0r1/jGSjpWLzW5443i8xq30NoPJIlNlcpypNVNw6P1yTuUNvfeV2NPm2kqfrXP7BP78fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369448; c=relaxed/simple;
	bh=he2a9hcmuJQnUK7aryhRR1M/btcudQQJrMwYFjwe9ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCIEimPhECekmrrbs7rEDj1xRZRYbs+Ep0EKqsjQG8CW/VQHOH/65jDmC1KLPUdNILmwQJn+yfOj2kJX3Q7kxbPJMboQgrnzyIVeNvsY5NyS0vvnj5SrbipnhG2zsP76kiJ4YUNVKHzPxfebzLFkaNdjUmWbcJGVre09Smxw9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lhM08lbA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1eed90a926fso28955ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715369447; x=1715974247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEgao1l5ZzOInVDyOB7HP2eKoju5m2/DiQoI1a8wG8I=;
        b=lhM08lbA/SJyqYkRbR7xF2F0jm8lKBcRG5EovJbv/PpW31z0HF9IdY0mnQqEi+1xjQ
         mYoB0RzWIfEUvjSJ3mFn/FYkT59bi23o2Lxe0HfphV7yCGZ1KCoo4gxcSLLoOw1Q4AB4
         LjfK4I1QES8VbKJXJfo/abFKc50f9/scghrhAF+TXSNHyltwoEtZOIl/KFcmhp4sHPg7
         8djuRGEN+I4tG8pBsdhaCf4P8WVjL7GAv6GHPsvXUyhj9Y3uQg284okrQjf4F3YoYFTD
         LySkB92jlmxboiVn/PlsbhklkNJNQyTV1mbjv4WI0dZDfaveHBDx2uUfq+qt4eg/U3Q7
         fK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369447; x=1715974247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEgao1l5ZzOInVDyOB7HP2eKoju5m2/DiQoI1a8wG8I=;
        b=V25v87qxPUu7HJ0yp4Jh/oxJH5eTzOlpjvP053dOm1xDiIAL7BnD9rGQvAHpFRyJjM
         DO5XbFBZo8Z5gKN3Ib4milhO9kOm2TjVbUNqbWaIJKSDcvnbq7KtBnbv4GEKwkBCWjJy
         lFYh2Ndsrbt2crabsJX5qo/jkNhyVkuenzp6NTXhIa/9TYuUdXcOdyrLFBttAkVKHXqS
         SuzP3AYgIxUcgIcptEkrZK9tENq4Wtmr5AynbnBL3MTuHHjMyI/Z5cW3pvrXUSB0AoiD
         +468msoOJdl/fR4EQL3U4OWf6m6kMsu4Pwu1hGJN5xe+kPaApvtFDnEtZ7vYa1j87dq7
         WR9w==
X-Forwarded-Encrypted: i=1; AJvYcCXgyF+shNmDHeqB111sBHrlbqH9OhR/2Kih9Q/mGFKHSkL+a3KKekN+Uq8Du0mHG8bATw/P/vSgQwBWQP3UREMtg/rprCjhpPUy8UoU
X-Gm-Message-State: AOJu0YxPVl4ed+qOxHKQupM5j9qLKcoecW4+aZDYM1v8GLGGT94+SwWK
	+OiujV4cp1mXLcwkw9vp8M4Km+/Kq3UVizhTBQAoy6cekonzRDH3WVVFrAVHEEf1ns3R7X105Rn
	t43k2WTQfapQEJL4PFIjURR66UpH2iZvagtkP
X-Google-Smtp-Source: AGHT+IEeMmaR84YdyIbdSRfTS6JoxztS4D5XcffJtiYsGlOga75SWy8nQXq5TgwjLZWdH5yVy+rHzUQawGRhibOn1I0=
X-Received: by 2002:a17:902:e80b:b0:1e5:62:7a89 with SMTP id
 d9443c01a7336-1f05f77e7b8mr342885ad.18.1715369446353; Fri, 10 May 2024
 12:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510191423.2297538-1-yabinc@google.com>
In-Reply-To: <20240510191423.2297538-1-yabinc@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 10 May 2024 12:30:19 -0700
Message-ID: <CAP-5=fX1URY_v+66ifMHqQBWTywitCB5ekVh7pB9xbuxPjWrWA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] perf/core: Check sample_type in sample data saving
 helper functions
To: Yabin Cui <yabinc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 12:14=E2=80=AFPM Yabin Cui <yabinc@google.com> wrot=
e:
>
> Hello,
>
> We use helper functions to save raw data, callchain and branch stack in
> perf_sample_data. These functions update perf_sample_data->dyn_size witho=
ut
> checking event->attr.sample_type, which may result in unused space alloca=
ted in
> sample records. To prevent this from happening, this patchset enforces ch=
ecking
> sample_type of an event in these helper functions.
>
> Thanks,
> Yabin
>
>
> Changes since v1:
>  - Check event->attr.sample_type & PERF_SAMPLE_RAW before
>    calling perf_sample_save_raw_data().
>  - Subject has been changed to reflect the change of solution.
>
> Changes since v2:
>  - Move sample_type check into perf_sample_save_raw_data().
>  - (New patch) Move sample_type check into perf_sample_save_callchain().
>  - (New patch) Move sample_type check into perf_sample_save_brstack().
>
> Changes since v3:
>  - Fix -Werror=3Dimplicit-function-declaration by moving has_branch_stack=
().
>
> Original commit message from v1:
>   perf/core: Trim dyn_size if raw data is absent
>
> Original commit message from v2/v3:
>   perf/core: Save raw sample data conditionally based on sample type
>
> Yabin Cui (3):
>   perf/core: Save raw sample data conditionally based on sample type
>   perf/core: Check sample_type in perf_sample_save_callchain
>   perf/core: Check sample_type in perf_sample_save_brstack

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  arch/s390/kernel/perf_cpum_cf.c    |  2 +-
>  arch/s390/kernel/perf_pai_crypto.c |  2 +-
>  arch/s390/kernel/perf_pai_ext.c    |  2 +-
>  arch/x86/events/amd/core.c         |  3 +--
>  arch/x86/events/amd/ibs.c          |  5 ++---
>  arch/x86/events/core.c             |  3 +--
>  arch/x86/events/intel/ds.c         |  9 +++-----
>  include/linux/perf_event.h         | 20 ++++++++++++-----
>  kernel/events/core.c               | 35 +++++++++++++++---------------
>  kernel/trace/bpf_trace.c           | 11 +++++-----
>  10 files changed, 49 insertions(+), 43 deletions(-)
>
> --
> 2.45.0.118.g7fe29c98d7-goog
>

