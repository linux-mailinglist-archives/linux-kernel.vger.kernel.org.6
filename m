Return-Path: <linux-kernel+bounces-180649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70B68C7149
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 07:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64EF5281B14
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 05:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8CB1C695;
	Thu, 16 May 2024 05:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0xJuJhfh"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44BBE57B
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 05:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715835898; cv=none; b=R/QmHJqKEMnXMOufisvzc+n6Y8khCJ0okCQZXgUfEFiC+NVyv7AmoeviI/zZChaXMRGUQ4p8nG9m1K2vZznqBstiVxPCtMPL5cxxBAL9+rzc+ojM12O7+TFliWyPw2k57rhQtZBZ1JAknJ1NJFRFNUQermoV89oArT6yYOrRLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715835898; c=relaxed/simple;
	bh=KsZqB9Nc++1f2JW88Ah8LooOEDUxTd/rxuTVQxTapyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=UQGlEbmpJ8CETWVptiQZrhGsitr8WE+yJgQMNwrdb/azHzz81tUQiSCzQzMY9IMBiv6PnWg1s1Y7TQnUt1E9oSPRtqo1lnMGJeIj5kc5sAhGFPC5OqnZoBOSPVue7D4t+dnqq9du/dYAOYaCAhSVQoCorIvqdQQFu56GJaN7qlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0xJuJhfh; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43df9ac3ebcso2405101cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715835895; x=1716440695; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQ2BUrI4nA4aMqiJQpw6TRcFQ7FyURr1y+deeKNa2KE=;
        b=0xJuJhfhO10M8YW1sfgMSZe9zjaPoYMLSCr0kyavNp9OxDnH55jRV8gq4OwVDTtzVV
         S7v5QKMTNqJetuu3g7WAFO459906V/VJ+6VTJQvtbH8GtJ1DstCu2voPddvpBk8iSA82
         xRt/zIIVFL3QHF3fRzovud6m+OUiravriNRCswoAI/9JcphQC4PrMKjbmouBagUeBhoE
         yMKovw5KXj8iM+3tw6jTy83lx/wKbiRNhg5qs2T0zxYsRIvz11LLEwA3n8V7Rod8btZE
         g3IhAz7uo+WwBZaZ5eUi6kVnSCKX7N/Ed/sPAyx9qBhVhbFrQDK9kBxGFCJWiO8T/x7G
         z4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715835895; x=1716440695;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQ2BUrI4nA4aMqiJQpw6TRcFQ7FyURr1y+deeKNa2KE=;
        b=ePGIo6aAX4kGOa1kPmVZs2fbqXZJUk5ABokomzaNkkRWlEyg/ushh3xO8t9V/eM596
         5OLYNxvQ8zjmtaOP3TdlipwGUTWlLl6diD94xVgfMmiUhWUwU9SS1zIiKNykh/fjVECz
         hze2YX1YNJmyGTXcgfQwlr2R9ga+3dzwlukFCFaU1oytqC2L15Rk6i/ZZtiN3EqhY94W
         2PoDPxeTxZOQBV5xrsMzzvvfIxTi4uYb6GNkwYYi/MYPnsPmLj2p1FcIi8vMEcxrUUGG
         tj0m4ZX9mJ7ZMA6fpZce62Ythhqk3SsKZ2Gg8gCxwODITgqDIPQ7J4IZaBS/kydMOZvA
         qXFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjNxUr8vN03YkLYOf3A4fS1Tkn9XL6A/z8ERPLPHbFltJWcZDP+G4S1QBr65aQs2Ee+pw7gu/hdxnEkOiD3McJYuDRYjYS3jrGKt4L
X-Gm-Message-State: AOJu0Yxmca9lp5v51tPzdX1zKT4718nL129vTtwAq30pD31uOHD1QRrl
	PbRPcZJ3/mmPLTNF3wRjnGvWHXASuBodyNbZOPtWFHwIUAdJnpMthOyVZZ6KnI8w+oRD6p4AY8w
	KM439rLlVr0k6QIX3Q5waj24bNx20jmTQoGNg
X-Google-Smtp-Source: AGHT+IFdCOpo9CTmEBe6R3dl72AtUqLUZ+386ogOqBR9a8yxYG3hJ321sFlDlm2ZYE/FIMcMokrMttTHp1aGLlB7EwA=
X-Received: by 2002:a05:622a:7e0a:b0:43e:a94:c1c9 with SMTP id
 d75a77b69052e-43e0a94c28dmr12178511cf.20.1715835895129; Wed, 15 May 2024
 22:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516041948.3546553-1-irogers@google.com>
In-Reply-To: <20240516041948.3546553-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 May 2024 22:04:43 -0700
Message-ID: <CAP-5=fW8TA0KQOepQRuC_0mhyp6kHbPodh+6-uoVxsmC=09tTw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Use BPF filters for a "perf top -u" workaround
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 9:20=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Allow uid and gid to be terms in BPF filters by first breaking the
> connection between filter terms and PERF_SAMPLE_xx values. Calculate
> the uid and gid using the bpf_get_current_uid_gid helper, rather than
> from a value in the sample. Allow filters to be passed to perf top, this =
allows:
>
> $ perf top -e cycles:P --filter "uid =3D=3D $(id -u)"
>
> to work as a "perf top -u" workaround, as "perf top -u" usually fails
> due to processes/threads terminating between the /proc scan and the
> perf_event_open.

Fwiw, something I noticed playing around with this (my workload was
`perf test -w noploop 100000` as different users) is that old samples
appeared to linger around making terminated processes still appear in
the top list. My guess is that there aren't other samples showing up
and pushing the old sample events out of the ring buffers due to the
filter. This can look quite odd and I don't know if we have a way to
improve upon it, flush the ring buffers, histograms, etc. It appears
to be a latent `perf top` issue that you could encounter on other low
frequency events, but I thought I'd mention it anyway.

Thanks,
Ian

> Ian Rogers (3):
>   perf bpf filter: Give terms their own enum
>   perf bpf filter: Add uid and gid terms
>   perf top: Allow filters on events
>
>  tools/perf/Documentation/perf-record.txt     |  2 +-
>  tools/perf/Documentation/perf-top.txt        |  4 ++
>  tools/perf/builtin-top.c                     |  9 +++
>  tools/perf/util/bpf-filter.c                 | 55 ++++++++++++----
>  tools/perf/util/bpf-filter.h                 |  5 +-
>  tools/perf/util/bpf-filter.l                 | 66 +++++++++----------
>  tools/perf/util/bpf-filter.y                 |  7 +-
>  tools/perf/util/bpf_skel/sample-filter.h     | 27 +++++++-
>  tools/perf/util/bpf_skel/sample_filter.bpf.c | 67 +++++++++++++++-----
>  9 files changed, 172 insertions(+), 70 deletions(-)
>
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>

