Return-Path: <linux-kernel+bounces-395509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D329BBEDF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C145B21FF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4801F5852;
	Mon,  4 Nov 2024 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHzGnAyB"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB06E1CC177
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752686; cv=none; b=E7tLFakUpYOBEOFB9yNe3+PLWpbAOnNfk6aKvBd0uhk0Aek7+GFt6uwpt+Q8TzxZ3gj8RoACjDy/ghccf0I1y42VnVuUKUUY6f+zxR8cOVA/UUzFPXEovzzcnIFbIqySgr0hOZU5vZ41EZTMywwpj1P3UBHdwGwc+CMBL/aC4+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752686; c=relaxed/simple;
	bh=EKafFQrcHqow9XPVbJXW8QnhNB4BpZ5ghDQ4nVOgs4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlUwb9/mFb7JlUxcVc6CMmYG7PgVQYlWk3xycRsAkpaRMuKCdtcpE2OwW+AG50ilv+YX+7snlXb4q7COW4TwqLIxWClAIeAEp7ZAZVvDkBpFc0AetKZSqpoRgBmzDIh8ivnGzQNlOubhMfg2HX4etzF0od0iNazcPGwjkbT012Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vHzGnAyB; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so31455ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 12:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730752684; x=1731357484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVs9awL5pwovmY2hQCH3pAdF4ZPipMvKa1BaDejQHMc=;
        b=vHzGnAyBAD023s+j7k7i5d/wSAnTq5UhCYwiEVwplKHYTYOXJpo/QV+olSmNIoVE4t
         yrb7aNmfJAUTJHQmExqLl1G8XdHooN9WSn5WGnFmTIdTY/OPXay0E02/HsQ5fW6cxlIW
         NlIf+WYIzxtt8OSdKvy1S0bzypgv+Uje3GHwZS1vwSpbbA1NidxensmejeWXvgtSUa11
         YLFdC9u7pCC9J0SXBqKEc1XWlya5SsAXfqmEzcQaCZqv05yUfScDIlBQRZUCi47+7X1c
         Bi/v0I/lrUSUmEI4RhQLZ52KoFo7mKiYQ7cY7m5dy5WTIvFKadWjBT8hoDH53SJAdR6c
         vmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730752684; x=1731357484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVs9awL5pwovmY2hQCH3pAdF4ZPipMvKa1BaDejQHMc=;
        b=Z7i1Ss0Bpcgd0c+AuedgzQu/NGvE9anSZzfrhICC7xJnFXIy2FwuvfzWmK9HUarzAy
         Gno4TrDhtp55bI8tdM8peB/vGG3s6GmFHG7brus0FrIKIT7tobZkBk93zLkrltchPnLT
         cz+H7qImykG7UwG+bURO0KGkQlG8HoDwjbWECrMIJLL25vYi/eTl1xzyFjBC/MHj14qV
         WdTFm97YZH2eqcyaFOzX84qeF86mAnbA0/YItFPGajknpYvtAe0KTrwdAHUTh01kG5Vl
         wgjAXtu1njc+E1P/nBL1WP4bFd5ZmzL8+XxpLULTk254Uab0e9TBzI7HSEbxmiP2SMpN
         n2ug==
X-Forwarded-Encrypted: i=1; AJvYcCUSLPYmSbO6RFIG/6lmd7ioJxNfw+/kJPydLKHXivwMdibEpGV5N0WTIwmAUkvqBpwf7QayH0CH9/dx1Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZh+zpj73/dTK6eWu6BFzHuGWdK5kAFhk1zDNkQ5JQUFyN6XlG
	MSxkfLHtlblj5KbJQ7nxEWWD4elUA4Wq3uwp/7osdDqgBZUA4lRh8Z1Wu2d+EUfq8qUJvlGjkYr
	JdDWkWSLp/ES/d31LVA0e8UR7kx1+Yn1dIR6R
X-Gm-Gg: ASbGncu6z41Gre/ubHmdPViHn0Nn3H4npGePoBs4lbjrs0l7g32yhXhY5PifoG3dmg1
	gIzgmt/7xVVhvfxSelvtsg+Z8VeYTDs0un6jNgrA0BHkpjkxwSow/Vwf+Da/GAg==
X-Google-Smtp-Source: AGHT+IEEd3WZqMqGwi0DOclLDdNE3GFZvePWwxu3+r9Hp4UUKKAxQnCVELnwD/+bq1Kic9iZOf6yhkkcdiQhPEr5Zrs=
X-Received: by 2002:a05:6e02:1a0b:b0:3a6:b3b0:5696 with SMTP id
 e9e14a558f8ab-3a6daa9633cmr605255ab.7.1730752683770; Mon, 04 Nov 2024
 12:38:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZyjbksKYnV22zmz-@x1>
In-Reply-To: <ZyjbksKYnV22zmz-@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 12:37:52 -0800
Message-ID: <CAP-5=fXNis590NMNfS=7nuJ3DoiB4ojvWtv1xvTVvnz7DFXG4Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tests: Remove dangling CFLAGS for removed attr.o object
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, James Clark <james.clark@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Thomas Richter <tmricht@linux.ibm.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Weilin Wang <weilin.wang@intel.com>, Ze Gao <zegao2021@gmail.com>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 6:35=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Since the C test wrapper for attr.py was removed we don't have an attr.o
> object for that CFLAGS_attr.o to apply for, remove it.
>
> Fixes: 3a447031f5fc21c4 ("perf test: Remove C test wrapper for attr.py")
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Howard Chu <howardchu95@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Leo Yan <leo.yan@linux.dev>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Veronika Molnarova <vmolnaro@redhat.com>
> Cc: Weilin Wang <weilin.wang@intel.com>
> Cc: Ze Gao <zegao2021@gmail.com>
> Cc: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/Build | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 03cbdf7c50a09be4..01ed9335db4dba4e 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -72,7 +72,6 @@ ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powe=
rpc))
>  perf-test-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
>  endif
>
> -CFLAGS_attr.o         +=3D -DBINDIR=3D"BUILD_STR($(bindir_SQ))" -DPYTHON=
=3D"BUILD_STR($(PYTHON_WORD))"
>  CFLAGS_python-use.o   +=3D -DPYTHONPATH=3D"BUILD_STR($(OUTPUT)python)" -=
DPYTHON=3D"BUILD_STR($(PYTHON_WORD))"
>  CFLAGS_dwarf-unwind.o +=3D -fno-optimize-sibling-calls
>
> --
> 2.47.0
>

