Return-Path: <linux-kernel+bounces-376680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF749AB4CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2101F245BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978E44438B;
	Tue, 22 Oct 2024 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FnzOozB0"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BDF28373
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617354; cv=none; b=BIKU+NAegKs4SiFSGdPO/dEnn02MfRLQdv/ZI/5DYQrftuGElTA6RcuWnNbJaF3H+Xaev+yr8OATd3JNM8M2en+y4Tyu+GyIM2bVf/BRhNHxNNoGFi8pzxtlrHvqhfuyt0n/xettfKJ20AIn+mMtLsdrcMnDJAaeTx0O7JKccBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617354; c=relaxed/simple;
	bh=z2ipP4my5QnyVNvAfHRwu9o0oRXT4HEUJ/+g6IV1ubU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hf+uC72KSIYN9P31ZLSkqrY7XU1QTRzSqoTQK9E6vtsjLXrFrAiw2b42iMFVRFy0Y8MlC+32vZgNstSO21h1gokSzbBt0ufIabYc8L8wC3TzBvqbXMlkx1lmlMvpYu6nYyrwqVXn47q/PnTUL78xMW+MaMTrUEDE/uN/DLT2hOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FnzOozB0; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3b3f4b2afso12105ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729617351; x=1730222151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaXzMvAYvUxlUCWeHAnHy7Ln3CXIQTuXNPgjIoy8xAk=;
        b=FnzOozB01z9Qpepj9QiuDDEkO3Jhb82YPgMQGWpL1pmJ6f0vf0ZzqO90N9v0vkrVbR
         glyHUEiRfYRZWSEEEV7k1EA4PUEr5DLhtuxNmLghKMaWkiNBwIJ/pBNv6kskteBeLVCF
         21so9r4O7UNZyzYuPCfi9efNO4cUVFVtFD9YUULwMD3ofq7b4dk6Q6UekJGxVQAyr8Xk
         uqeDLgmVKED3+i97lCATOlvcwdPlIpaI/zmXsG8POEuamdsnVXSFC87pgGt2lR8YuFlt
         cXzplSjc9JnUYNT7Ez4+eR5L+xSdAEiVtcD41LS1Zssf8y+wGppuUGguKqwCNG/3pJrj
         gUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617351; x=1730222151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaXzMvAYvUxlUCWeHAnHy7Ln3CXIQTuXNPgjIoy8xAk=;
        b=hpYFJjk4CLFZlEKB760EBdV0bMjxhCuoc3/b4l0HIoZXiPBqaXq30xg1dG+7M5jjb+
         j1jmekISqQA3RZBl+4pqWNd0HA89Q72a3FsrDMMw2yiuADPB0h0iMpIOXE0ZU8oCldce
         0VaD7dg/nTsCNqcDw9pLx+uJqpSHROp+3ndzHvdR0iPiV0A9lMhBCON+ymYnBTd16Ort
         fGywoFXwsjkj4qMg5JCWcT2lDxHOKIZlNTbXkjYuubhQ0ekWBPHgZ5Np1vOUMfXxOSAU
         cGMQcOnQq0zJTVabWPkyoyso6ogYKN5qGApG9f8QaZT9AM8wuT1p3JJM7rb+IqJ3SMHr
         72BQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Je/itM6Oh0gPllQf8DLiOY1TVkRAN05pj4Jx9vjAPBsbTeGdXh/G8g5Ba4lAo6WfTniOhDyJjW6w2Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww0QXOvPrkFLxXyqgFRL6ntZnovI2iOetWmfb7fvAlLUFzHoFg
	xSNsnrnFiLZurXwGYLcPwTa1s4fzEQ+ltU0L/AFHX9PUZljQ+VB4dZhPDmrNOolx5OMeXA1dTiO
	bYiKHDNXmBeBd9HgAEMdG2TcT8wVucnvaA5b8
X-Google-Smtp-Source: AGHT+IEVy5VyzazC8qQI5OZ8jkSTr1uF7DIcZre/POs3/p26eCu/ktnn4YnUyuyzRspoVg/9iqbEOoec2ztXipcoSMk=
X-Received: by 2002:a05:6e02:1381:b0:3a0:9b7c:7885 with SMTP id
 e9e14a558f8ab-3a4cca013f9mr5069435ab.22.1729617351393; Tue, 22 Oct 2024
 10:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com> <20241016042415.7552-14-irogers@google.com>
 <ZxdJyRpCv7dmmin9@google.com>
In-Reply-To: <ZxdJyRpCv7dmmin9@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 22 Oct 2024 10:15:37 -0700
Message-ID: <CAP-5=fU7n6iumZuNaUcS7VjsG9uF3ib-mP_6cvUGExKaY-CNQw@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] perf bench: Remove reference to cmd_inject
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 11:44=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Oct 15, 2024 at 09:24:12PM -0700, Ian Rogers wrote:
> > Avoid `perf bench internals inject-build-id` referencing the
> > cmd_inject sub-command that requires perf-bench to backward reference
> > internals of builtins. Replace the reference to cmd_inject with a call
> > to main. To avoid python.c needing to link with something providing
> > main, drop the libperf-bench library from the python shared object.
>
> Looks like a clever trick!  But I guess by removing libperf-bench from
> the python object, you can remove the reference to cmd_inject, right?

So this change is looking to clean up cmd_inject yes, an alternative
thing to do is to remove libperf-bench.a as a python dependency but
that would use an unused stub. I'm looking to remove all the stubs.
Once you start cleaning up the cmd_inject stub then you get where this
patch is.

Wrt cmd_inject have 4 choices:
1) status quo - have libperf-bench.a be depended on by builtin-bench
but have a cycle where libperf-bench.a depends on builtin-inject. This
can yield build issues I've wrestled with in the past and in general
this shouldn't be done.
2) this patch - have a dependency from libperf-bench.a to main in
perf.c, which is less of an internal dependency on the perf.c/builtin
code but is still an annoying cycle. It's not much better than (1) but
at least it shouldn't require a #include "../builtin.h" which is
obviously bad. That #include isn't in the bench code as it re-declares
the function, again bad. The patch here declares main which isn't
great, but at least the declaration of main should not be subject to
change whereas the builtins could be.
3) move perf inject into util or some other 3rd library. Out of scope
for this change, but also not something I think we want.
4) have `perf bench internals inject-build-id` fork/exec the perf
command. My preference but out of scope here.

So I went with 2 to improve things but without doing some larger
rewrite. The cleanups all relate to removing cyclic dependencies to
cmd_inject hence 1 patch.

Thanks,
Ian

