Return-Path: <linux-kernel+bounces-314226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D6E96B041
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0C91C2384D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 05:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B37482866;
	Wed,  4 Sep 2024 05:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDH7hCXf"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6080B2A1BF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 05:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426203; cv=none; b=jtc0gu1OXi8+T5qdd/dDImZaYInLlGTXxQaGMif7R+SjVoL+c7StawRbs4rkGGAsONlBwNGjcn3jwXPxchjdwfWp7KtjhHiCpFoHsC+ecO49z4dVkDQzVNObQM5Rw1BTPyQnpqfZ6CTKpqfUUI8ai5Vd8sXfG+mJFVW4IOzokcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426203; c=relaxed/simple;
	bh=PgQSIHPPaPcmAm+knXEyHt6qQxQ4Ml/ktvDvf43bWL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvfkOUrjDswvHrZWkJl0eXRPK2cYbbvE+P09pA/6/7KQz45jV2rbBMUVqBGgFsthOb39vSbBbNYuFQqR/3c7To+t3KIz7oE5PhgfRgH9OHUeC+e/uCDu4Zj38Sa7/+xEYzBlZoafX8IW3r7ssATB9VAOLF2wHy2PzRS49IsUPnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sDH7hCXf; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39d2a107aebso91555ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 22:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725426201; x=1726031001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUqFxyibmNEUdmAh831YwQL84u1yegFcAIFBz15HPh0=;
        b=sDH7hCXfqxfcb9GJpqAivBcTqmgKb7lfhDXV7GxvYpBnhLVC/2EQ97g92wagmbU+E1
         xDxCxUuTugebRI3avKXqE+W0XOOhK1kjBKsezUzuWgl5Ugaf/HrHiiwsZNOo7uiKlMTz
         aoZ0VsbwIG+yEuiYg3Rx9IXo3xHUsSCgx6SZ3BzfdBNnYfZZn4fA1P2XL39Ljx7pXyHH
         S816+tY45dclpwWN7jryOSZVcRDJ2p/FpJiSuIAcaOGGL0vAYd9NYWC6gd7tMut38ThI
         fQvCLkgvGyUJuRyUhNEpSooGm5zLCtYvpW/cK7k9Ccq75l+AxRnVl3O5O+VQMadeczps
         0snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725426201; x=1726031001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUqFxyibmNEUdmAh831YwQL84u1yegFcAIFBz15HPh0=;
        b=IFzJ2BR9wthgwoa0qg8qkcCpsjp5k6fozFCVLz/HBjecWoHPRbG36SyLT97ompaohO
         u7g/ZQFM21MdCNZ2hKZ9zrAGn4Z68uCLlH1DJ1YLxvfWOU8GDHX89xz167iAgAY8IbuE
         M0M6erAptoylUgDrO9DxRyIeqhxeO/XVIH3EtIRbkHfRQkCujo8MpBW+UMG73feMszyP
         qxSj1FKuCTWxiK4RUIXiV7cB72a41SzOwKmqJYTAKpAuMybBHhRW3xSXA5euXnHgm3PM
         A2hjVNzUW7O6ZFQ0yg6fprTAzYd62j+IzVk6RfvOEt4oGiKR0Xc1Hp/dOooMBcHkx25L
         SA0g==
X-Forwarded-Encrypted: i=1; AJvYcCWwSkqTa9caw9kjTkW5r9RcSd63RMY2P4LlAzYMInvJlfrwwGWS91biCw6Cg3WZyYAg0PqdChU4wih1VlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxEaRvUJ1BIF3/xPyXobm9OU3AbbO2cAvyplQc6u9UaWWhZPbB
	IUcujluI5Z4pZtqNd2XnBeuVM95yz3mPykVHc8E1Ni49+kQp5SSrahnWwb+v6JMw4kPxe+sX8+t
	6OciRgVswmjZsr0s7hO6ygLap4fxUSXOuGq00
X-Google-Smtp-Source: AGHT+IGOZwXDIEewBVh+sribLgHgJauqFq3yGYw9foTrMuhyBtnnqfLTGlY5eceQ9mJ8RCor8gG93uaGHiyGtcN2ptA=
X-Received: by 2002:a05:6e02:1d13:b0:39f:52b4:e286 with SMTP id
 e9e14a558f8ab-39f739c95bamr2205845ab.26.1725426201077; Tue, 03 Sep 2024
 22:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831070415.506194-1-irogers@google.com> <20240831070415.506194-6-irogers@google.com>
 <ZtccNpePJAM24nA7@x1>
In-Reply-To: <ZtccNpePJAM24nA7@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Sep 2024 22:03:09 -0700
Message-ID: <CAP-5=fVpT2ntV8YND4iuTWet1or8m2hPD-+Ohx_j1sdqgkwj6g@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] perf parse-events: Vary default_breakpoint_len on
 i386 and arm64
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Jihong <yangjihong@bytedance.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, 
	David Ahern <dsa@cumulusnetworks.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 7:24=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Sat, Aug 31, 2024 at 12:04:14AM -0700, Ian Rogers wrote:
> > On arm64 the breakpoint length should be 4-bytes but 8-bytes is
> > tolerated as perf passes that as sizeof(long). Just pass the correct
> > value.
> >
> > On i386 the sizeof(long) check in the kernel needs to match the
> > kernel's long size. Check using an environment (uname checks) whether
> > 4 or 8 bytes needs to be passed. Cache the value in a static.
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ gcc --version
> gcc (GCC) 14.2.1 20240801 (Red Hat 14.2.1-1)
> Copyright (C) 2024 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is N=
O
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ gcc --version
> gcc (GCC) 14.2.1 20240801 (Red Hat 14.2.1-1)
> Copyright (C) 2024 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is N=
O
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ uname -a
> Linux toolbox 6.10.4-200.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Sun Aug 11 15=
:32:50 UTC 2024 x86_64 GNU/Linux
> =E2=AC=A2[acme@toolbox perf-tools-next]$ head /etc/os-release
> NAME=3D"Fedora Linux"
> VERSION=3D"40 (Toolbx Container Image)"
> ID=3Dfedora
> VERSION_ID=3D40
> VERSION_CODENAME=3D""
> PLATFORM_ID=3D"platform:f40"
> PRETTY_NAME=3D"Fedora Linux 40 (Toolbx Container Image)"
> ANSI_COLOR=3D"0;38;2;60;110;180"
> LOGO=3Dfedora-logo-icon
> CPE_NAME=3D"cpe:/o:fedoraproject:fedora:40"
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
>  CC      /tmp/build/perf-tools-next/tests/bp_signal_overflow.o
> tests/bp_signal.c: In function =E2=80=98__event=E2=80=99:
> tests/bp_signal.c:115:28: error: operand of =E2=80=98?:=E2=80=99 changes =
signedness from =E2=80=98int=E2=80=99 to =E2=80=98long unsigned int=E2=80=
=99 due to unsignedness of other operand [-Werror=3Dsign-compare]
>   115 |         pe.bp_len =3D is_x ? default_breakpoint_len() : sizeof(lo=
ng);
>       |                            ^~~~~~~~~~~~~~~~~~~~~~~~
>   LD      /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o

Teach me to build only with clang. Fixed in v2.

Thanks,
Ian

> cc1: all warnings being treated as errors
> make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:1=
05: /tmp/build/perf-tools-next/tests/bp_signal.o] Error 1
>   CC      /tmp/build/perf-tools-next/builtin-mem.o
> make[4]: *** Waiting for unfinished jobs....
>   CC      /tmp/build/perf-tools-next/util/symbol.o
>   CC      /tmp/build/perf-tools-next/builtin-version.o
>   AR      /tmp/build/perf-tools-next/libpmu-events.a
>   CC      /tmp/build/perf-tools-next/util/metricgroup.o
>   CC      /tmp/build/perf-tools-next/builtin-c2c.o
>   CC      /tmp/build/perf-tools-next/util/header.o
> make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:1=
58: tests] Error 2
> make[2]: *** [Makefile.perf:777: /tmp/build/perf-tools-next/perf-test-in.=
o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>

