Return-Path: <linux-kernel+bounces-415032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8379D30DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F69C1F23205
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AF21D3584;
	Tue, 19 Nov 2024 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i91ZN6N1"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229219AD8B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 23:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732058204; cv=none; b=BA9DKP7yIewD+ShBRuuEx6jjiAjDVEV/hYE66FRVpNjSISnS5QQQIjywDVucI5zYwg/JAL9CsjYGWfnaYmO8oJpoFb/iodWmDMispsTO+rTr3dDYWeHApy7+QSXPFdhHoT1b2NVt2Cs3bo0jBt0aNk0QvI6g3CrfUv/p8xAXscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732058204; c=relaxed/simple;
	bh=gJVYi3jm77VpqhVfMseqvv+8fgAUOv5rTQPWXtguMXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgDGB772/hpmzmk4kmNI1qGHv0i2KIrRx9ia1gEcLR4VxBLegiBdSjUpARvSOBm8129nj2aV8yrejlHs0Ka9t2tkMCXwnYfTQz0mNIm1p76HTn0/61i5CNUmsMGbARUJ6v4WkB9iTi+gS9CRSGECXSE5aYL5znSK9YGm2kM2r3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i91ZN6N1; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so202635ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732058202; x=1732663002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVnhxKRj40qafR8ARBDWNX+xTYjxRZzrf4WtxCS1dp8=;
        b=i91ZN6N1nBsv64RMS23VFe3gDUxFPbFEad+QmeAsktVJfrk3IS+3ZVMSGxxHquhctS
         n4OU/e3Ve4Gn55+pox9y1sVabABizdigoxJ54z2TMy5ht6ns4CNo5TG4Lyt2HXNQC9Xb
         dc2S6GRhYDxMSPQ5FYeqH934AFXeGDxkRhff82gu8wu59BgFizxUnM9rblE3+0H6Gf36
         W7VMwyOdhs/EJJYAjCpacls6aMlVEmqjx7sfK0qJ/1r5PHujeeXYV4UxgM7pfoD7ql4V
         +pGrVuAxwaeTuzkEejQTSXSoHyaGKttZ9gILTnKyBciLkN+V2AC8zDEWB0XwCnerCcqH
         JOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732058202; x=1732663002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVnhxKRj40qafR8ARBDWNX+xTYjxRZzrf4WtxCS1dp8=;
        b=NuswRClPOuo83PABkRC1NzMl91vKsfifQwS2gKfaXjMT0stRi1By/AO6nCM8C8y0PM
         pE23HSwIm7IjcGG9Z/ztGnlq+HvEUaj503wMh3kyYWSjIXhs+4HsN9cfw8WOWGR05C1a
         m0CWBYcf0QhAUe+Ge5HA392CN5JJqZn555+Kxv+1vRKiQN12iT3Djf4rb/rSisUbH8I4
         mLzK7rhWwxlLK4S9oOclXMN5xwOXEQeLs7BmXT3LKzuD7jfWD+r3Kl9nOMiVLxgNAE2b
         CCoKK4e9cwmwce+D2No3gbWxMolRYZ3aCJGYKUavXu+IeSGOEkYIp0HKypWB/trAjSti
         zmcw==
X-Forwarded-Encrypted: i=1; AJvYcCVpHTaQdEhS+qw4qHl4PQC1UhiGNMB1IY0ZCG46cE5GIE8VZDisPdl70zcNhJBgcSpy63FC42KcME9uOxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWTHFmz9rTvtHhm5lhcawSAJcIHDy+7L2hAiiDKUfu8wbiZgRC
	3YnJrB6Ty4NZYFYdFqtigEggZXJxCpEuEzKEKseOokhRIQskOp5cJKM5dLlmdlchzMH8TMjPbf2
	M5/8Bsr34+DTBPmpls1R+STtyYoFQrVMRNUFf
X-Gm-Gg: ASbGncsEyKWZgP/P28oOhc0BI4sDjrrRTwrBIcvIQJIRyagHf7dHyfqyC7MyZpjhBHf
	jU2F8EWFgr515DzFd3Mmc/G4JjeuVzaxWsMsaUcb8MjwlfYNgcByq8NQCrH4aUWw=
X-Google-Smtp-Source: AGHT+IE4kxt+RM91kdha5M+O5Kblvww1VGaxV1RtvZbt6tpYdKEVnjqJ6hETp11EO4U/zF94NtUJtoqNhSDu060F6JI=
X-Received: by 2002:a05:6e02:1d8a:b0:3a7:683e:2fc7 with SMTP id
 e9e14a558f8ab-3a7859160ffmr1463305ab.4.1732058201842; Tue, 19 Nov 2024
 15:16:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117080446.182201-1-guanjing@cmss.chinamobile.com>
In-Reply-To: <20241117080446.182201-1-guanjing@cmss.chinamobile.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Nov 2024 15:16:30 -0800
Message-ID: <CAP-5=fW-e=YPgVMYGY_8cV9-+L83dEx_s1asoAoz62bX=kEfVw@mail.gmail.com>
Subject: Re: [PATCH v1] perf tests: Fix unsigned comparison with less than zero
To: guanjing <guanjing@cmss.chinamobile.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	mpetlan@redhat.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 11:24=E2=80=AFPM guanjing <guanjing@cmss.chinamobil=
e.com> wrote:
>
> The return value from the call to readlink() is not unsigned.
> However, the return value is being assigned to an size_t
> variable 'len', so making 'len' an ssize_t.
>
> Eliminate the following coccicheck warning:
>
> tools/perf/tests/tests-scripts.c:181:5-8: WARNING:
> Unsigned expression compared with zero: len < 0
>
> Fixes: 964461ee370f ("perf tests: Run time generate shell test suites")
> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>

Thanks, there is already an outstanding fix for this:
https://lore.kernel.org/lkml/20241115091527.128923-1-jiapeng.chong@linux.al=
ibaba.com/

Ian

> ---
>  tools/perf/tests/tests-scripts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index cf3ae0c1d871..1d5759d08141 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -174,7 +174,7 @@ static void append_script(int dir_fd, const char *nam=
e, char *desc,
>         char filename[PATH_MAX], link[128];
>         struct test_suite *test_suite, **result_tmp;
>         struct test_case *tests;
> -       size_t len;
> +       ssize_t len;
>         char *exclusive;
>
>         snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
> --
> 2.33.0
>
>
>
>

