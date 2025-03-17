Return-Path: <linux-kernel+bounces-564590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5C8A657E6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1FE18935DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0483119F120;
	Mon, 17 Mar 2025 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Za4XG4i/"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A5019F11F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228577; cv=none; b=qLZiMcWxfhFxw49s2fy3G7y97u9VHUC0IawpkNVPQSkaXHG8O8pMFKt7Vj6PtlWb2lJnl48tk7Q7rXVy7QVmHi6hGW8OAycp5wJf2lqmMseEJJJbLEhOCC7A07a1jl7RBcZUBbgsAwRVAvwc5koWNN8jNjPI2OJ+ZxVTptR1mPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228577; c=relaxed/simple;
	bh=APzyuFHBTGMrxfIH3Njwymc3R9+HIjMnH4ACe4NgVEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=RQbx9e1Mz8lKhmDLgjp7huUnjZm0MsPQIzuQnuh/YRTnQTf2P87/eEBnk3FtMt0FTAx8ehgOPuC3lqnJbZaHjlMF43MbxygBUMERd4go4Vtz5Q9rTYR0qL/ADIlIAJavDP6DAfeRX0SfFKW/ohFmGbPCm0tXMIFEbfPSTIvVqyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Za4XG4i/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240aad70f2so51565ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742228575; x=1742833375; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cI/NBBP6a2u02KtJF9xtB6xkZu2x4DHKqcwXfazBTNw=;
        b=Za4XG4i/tBXvsijosDxpIGfZWwByPJcY1rSlycCEFVhoKoCdz1GUlggbJN1Ug4VbXQ
         01+qarvmmEeLmydmb6mEJ8obJZRBsODBTtF5BKj2s7VxNg0TpDz3FRETQuN3d4TW56yu
         pH95OyTqdI95x8OET+Xy2A1IvOl8jrXXYVoH8dqt4Yq3ZSs035neSA9sbDQccjGHFXx2
         RX7Q8eEUJqems2TdqbJ3c6WnqtldPOOB3AJuuXiarohcAv6KoVj/YGgZYhrkdvvoeBc7
         DJCRhJIkhglbpdNpUTMSq4yaJYqNxqmj5L9m9mjpHipT5VLVuVP0Tqtfj7b4x7aqce1F
         dFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742228575; x=1742833375;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cI/NBBP6a2u02KtJF9xtB6xkZu2x4DHKqcwXfazBTNw=;
        b=S4eFN9djD3GsYWXt2n2g6zDBob5fALr4Si9XRNS6H5bsUm8yW+RYasgVHF8DNqqWBF
         qHHsekWRbRuo75O6PA7Is5YqRqWbyfz6UWRxEtpr0AsHzisbqhCmYZZIlseme4NNwRrq
         qSikIV1u3DbgCYoS6rO5A24gqwNzSj3OuGZOABDxNU0HdWUBaYN+M2RxnHVeaaX7o33E
         zlGn4DmiCw8Of8mGHwfDdd04/cM7vBx2ix8p/MtYx1pG3DGaJpFCpXKb/GgUoqc9hp49
         OSlSIHm2lbgOF7FMmNLzwdM29oXPWKtaOr59bXUNJBFeBZcz9E/gvRfIMju+GAwfDJRa
         eZig==
X-Forwarded-Encrypted: i=1; AJvYcCW63ErLkPQPV5rc0/g/qRKhChRuRnXSzc03R7C7mc9xaWWp+S7FC63nIiICnSquJDYfnl5Qb5ipiAazLb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgjCNjhzLEGomo9veaODYy21HDaqi3kw5KMEaC4ULYIspAsumT
	KoQsT8Qnl3QzETnUJLHwmSrxTr4kQCAqAqCS1HaqoGqZ3x6fXJwMPcpRSv95jHA8coOgqw9M+Cn
	PPPUsLQwFMXkBzP13g/c7Lk2PQURH7yGXgoo3
X-Gm-Gg: ASbGncvb4IAEyLxjBv9D8uwwGPa/WNuFGEn638Gxn/Z8LlXsoKRceM5Kz4Rhqc0c+6n
	oq+EEQxgMpCRRIPbgmI3ls7ds8jCEDKzihkyhHEW3QdvJgOuRC9ZGzIJCPo4Q0oRM6ZYQcPnqLt
	3/wawjpCy/9g3JAmFUF9QEnMuazo5Se8JV+jM2G0bHjqeDPLWgcLoxpOU=
X-Google-Smtp-Source: AGHT+IFOK87UnBB0mY1F+kwN+ps4KiWKMyJmdvkSBPkz30vTxZyulOW1oKjCSKzg5kO5BmGcLLPbd+vuc37jIIarScI=
X-Received: by 2002:a17:902:c941:b0:224:a93:704d with SMTP id
 d9443c01a7336-225f3c0e8a9mr4510885ad.2.1742228575006; Mon, 17 Mar 2025
 09:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210183808.130522-1-irogers@google.com>
In-Reply-To: <20250210183808.130522-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 09:22:43 -0700
X-Gm-Features: AQ5f1Jpd8P2JoIcocmi63i50Kw3E17a21rJAClkYrXLfOfkrJ-R0y41DHRP2IFA
Message-ID: <CAP-5=fVH=HN0csS6cXLPAYdk7Vn-g8FSdKWkaHcjfYKRA1o1Ag@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add support for cpu event term
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 10:38=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Being able to set the cpu mask per event was discussed in the context
> of a sysfs event.cpus file is discussed here:
> https://lore.kernel.org/lkml/CAP-5=3DfXXuWchzUK0n5KTH8kamr=3DDQoEni+bUoo8=
f-4j8Y+eMBg@mail.gmail.com/
> Ultimately Kan preferred to have multiple PMUs with a cpumask each
> rather than an event.cpus file per event. It is still useful to have
> the cpu event term and so the sysfs part of the original patch series
> is dropped.
>
> v5: Purely a rebase.
> v4: Add the stat-display output change for zero counters Namhyung
>     requested as part of the series:
>     https://lore.kernel.org/lkml/Zvx9VbJWtmkcuSBs@google.com/
>     This skips zero values for CPUs not in the evsel's cpumask rather
>     than the evsel's PMU's cpumask.
> v3: Drop sysfs event.cpus file support patch from series.  Reference
>     to using cpu to modify uncore events is dropped from the commit
>     message. Reference counting issues on the cpumap are addressed.
> v2: Add support for multiple cpu terms on an event that are
>     merged. For example, an event of "l1d-misses/cpu=3D4,cpu=3D5/" will
>     now be opened on both CPU 4 and 5 rather than just CPU 4.
>
> Ian Rogers (4):
>   libperf cpumap: Add ability to create CPU from a single CPU number
>   perf stat: Use counter cpumask to skip zero values
>   perf parse-events: Set is_pmu_core for legacy hardware events
>   perf parse-events: Add "cpu" term to set the CPU an event is recorded

Ping.

Thanks,
Ian

