Return-Path: <linux-kernel+bounces-573997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510CDA6DF66
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9313B189C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C239262D13;
	Mon, 24 Mar 2025 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afcdtANx"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F9262D0A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832972; cv=none; b=lY44rogA6ptCjaU7YARiMUVFtl5tqZFjep/2ZL3yc3ZYFiwW0CAbzdIANguPqSIT4a26hQgqT6I60w3H8Mi1fxiHYe4Jjt5Kc5D0DUVcqupf6BiXyFbL3oMbbbP9QuiyPBZl6v2J5AHWYqLvrFAlHBmg4kRnI9nyNq/tZyN5Hj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832972; c=relaxed/simple;
	bh=M4+Lrf+tBhiaUGrW68bHw0hJrDpp+VAINoN6zAcbL9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FlOjYYzqnEYBLk3paESbTXve0O63MNCT3lLunFASFhoiHQ7s2Fc85fr4mATLm1F4CTglrW5/vNEcEziqPPWQmNyIzalYwfvZYY0HTyKTU+6lX5E/aVV0Csld/0Czr/n1ZAQwqIE38MXj7WhNJ8l91KfCuD/1KOw3kU45rN0C8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afcdtANx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2242ac37caeso389265ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742832970; x=1743437770; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SRc0E5JJcFqM7BjfBegdLV1cJ0uZ5Z9Ovl532RgmCA=;
        b=afcdtANxbbleWVisj0rq1N3Gtn2QJ8XNKiXr9Asiuml8cOBcUvGIWF3KIfuU3QJnXV
         1RKj2x7dXycxp/b64g8KVK5Tt/TWkx6sCADfEukcAOMDHRdtvcRXRIRa4Mfdtlq25Ala
         jpr2iCNWj/zJ/gGNFQAB0nKlgV8U/fACNhySfEftqr7tO1hZVfaSSNxaScqjLd4Y97Pu
         /1byYASYQsZwlQbnpCqFXejMPtCW1atNljCQhI9ONsuMLbM+wHUI38ua2FbVPBAZiAIr
         GQyOobSGibTO6tro4nGJ4euifKcGk/VkSYJz2Ec2/yuN5WXaDFC9HGSIshXtQQsSHL56
         PXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742832970; x=1743437770;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SRc0E5JJcFqM7BjfBegdLV1cJ0uZ5Z9Ovl532RgmCA=;
        b=Bbmmh05dCIX542hKY8/a0FGQjYgTEMze4EfyowI0/7UGto20uz2d6e0dTfVdxQJUua
         PXJzTqOcztR7UtENoL1Dbk/X466slA9YSchwXWptWCTm+MkKmSKOu/QLE2HZv0nWiVF0
         O7brNBl85sxNytNm6AMgVUDnnt0OjEwq67lR10IrerTmUTHh3jwU5NloDUpgouLgohk0
         7/wRyafIgN4n+Wr4Eu9iVr9pkKzpjEViAibhad4JODmewoDl23ODk+RLhiq86/SdEES+
         o1uLXEk5NL4yqJRPxD9L3gUL3HCJHXXEDh5e96knYyPkkliIrt3eF5gYlXGNpINpn3Nb
         KWdg==
X-Forwarded-Encrypted: i=1; AJvYcCXcZcPVlwRoTTsijsixG9MAapA379DHTfmO2HiwfVoXhUvO2uGsgz5/H8Mq3zxy6Vlk6GuPPHYpQahJkZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRquBb3HAJkCPFE0pNTw9njGXZTvD71FjTJTj7SyoQDQMj5QFb
	CZXHcc2xlBr6VZMzE19DXvUlyJiBffNkf+bhBjTW7w3gu/HEzFRnw6ROCwsbdroR3uEnDXOom1t
	NDPK7cXYwKKGH8c4JKOUdMXyK3/P2a+OdqirD
X-Gm-Gg: ASbGncs3olEM5w3ch3Ux34ccBnM+rSwc78H+tN2Q5tkHeg61DOT4ro9BitOJTZS07/M
	K0xwtcZgpatn5p6VeR3lFk1l5JPoZe6AQgH5LWSFwg2mVX77OiYl5PNDqFWI8zuY/etc3IaE9XM
	r7XuV86neDf6y+LgPkLzA9VfJjzSgRI6Mz+uN29i9ujtXfmt7zWRWsfvVDTnX9eXYV8w==
X-Google-Smtp-Source: AGHT+IFJdl0wwlNRPgxAYdSAvv48PsxCERa1aF2/9Rzp4Fd3VvhzX/0iRMyvcecJa+ev9tM8gvDsxiL/wSSwlZrUwAk=
X-Received: by 2002:a17:903:3d06:b0:21d:dca4:21ac with SMTP id
 d9443c01a7336-227982a7e42mr5582265ad.6.1742832970059; Mon, 24 Mar 2025
 09:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311213628.569562-1-irogers@google.com>
In-Reply-To: <20250311213628.569562-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Mar 2025 09:15:58 -0700
X-Gm-Features: AQ5f1JpPJbKS_0ytg1eSMnLwkzKCjJrQfOfha4Pc7G-W8NP0BTmBN2w8ZWG67fc
Message-ID: <CAP-5=fUZ9_0hOx2La7B4a_3oPDFdAWDC-NDcMibAfb166kt7gA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Mypy and pylint build support
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, John Garry <john.g.garry@oracle.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 2:36=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Support building perf checking the python code with mypy and/or
> pylint. Currently there are too many errors to make this a default.
>
> Shellcheck generates no output on success, so linking shellcheck files
> doesn't cause `ld` to fail. Mypy and pylint generate output that will
> break `ld` so change the Makefile.build to ignore test log files.
>
> Address some initial mypy errors.
>
> v2: Rebase. Add James Clark's reviewed-by tags. Add example mypy and
>     pylint error output.

Ping.

Thanks,
Ian

> Ian Rogers (6):
>   tools/build: Don't pass test log files to linker
>   perf build: Rename TEST_LOGS to SHELL_TEST_LOGS
>   perf build: Add mypy build tests
>   perf build: Add pylint build tests
>   perf test: Address attr.py mypy error
>   perf python: Fix setup.py mypy errors
>
>  tools/build/Makefile.build         |  6 +++++-
>  tools/perf/Build                   | 32 +++++++++++++++++++++++++++---
>  tools/perf/Makefile.perf           | 14 +++++++++++--
>  tools/perf/arch/x86/Build          |  6 +++---
>  tools/perf/arch/x86/tests/Build    |  6 +++---
>  tools/perf/pmu-events/Build        | 25 ++++++++++++++++++++++-
>  tools/perf/scripts/Build           | 26 ++++++++++++++++++++++++
>  tools/perf/tests/Build             | 32 +++++++++++++++++++++++++++---
>  tools/perf/tests/shell/lib/attr.py |  8 +-------
>  tools/perf/trace/beauty/Build      |  6 +++---
>  tools/perf/util/Build              | 31 ++++++++++++++++++++++++++---
>  tools/perf/util/setup.py           | 10 ++++++++--
>  12 files changed, 171 insertions(+), 31 deletions(-)
>
> --
> 2.49.0.rc0.332.g42c0ae87b1-goog
>

