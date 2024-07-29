Return-Path: <linux-kernel+bounces-265986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A2D93F8C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5623F1C21FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F321015538C;
	Mon, 29 Jul 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEtwpnbZ"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D6A153836
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264788; cv=none; b=SqLwh0heUsVtrkjfCHWvygAUNe/3et+cvFMLcHRiKbMtFq7zL4Uj7yCoxlb/lfYxq4qTWM4Shu8hu0FfkpA5gkVXbYdxm0USw4K0J9V5fd0wx2R4jM5uLt9JkUsD9xniUj4WT32FvMvRmSpPwoeQ+XLN9RSGCAjrNzCQH17oj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264788; c=relaxed/simple;
	bh=1jqQctM2a+S+lyJbT7V/HPsKNox1qfH+F+rAd8K6hZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taiSI20Nx2wISZO68UNgqnuHAEEJ7p65z/FJzjLvPqzoGpZFlkQN/grK/gr+mzO31crcMUgIf68RALjbLRj9ZzHbOh56rZRA1Gp1HKQu04qNyICTN+PRkBv5O9q1ITJLfg3U/AnekANgc21YKDavX5vCty1598ormnjKp5ZSakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEtwpnbZ; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39a16fab332so277895ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722264786; x=1722869586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9K9fhpcFFyliwAIwtK/bwTIbpmSXLXKLb0zgxn5arM=;
        b=uEtwpnbZeXyftztXESR2gTXxplX6ZXHm3qhrKbG2zMeHSUilr6gzTlfZ6nWmVFrN5f
         JOHFTs9tvM2PIE46qKLxFQtQxaCrbLIJxgpOJ9R/dyMY80MOL1QrvMa3j+6wC7rO4Pxx
         xlf3An8kXw8mUB1xcGRpTGZ7CE0TMjr20g30ObvS8r7Wx/farBNrnTLIpS5Vm6vJOLru
         8fGS/oYmSjKIOZzDYLjhrqbBhp+2wwN6UdD0okZhqbL9qBbw6OAZTqGQ7ApYqgNqCTlF
         ytMeO2vWS9kUOBixmjwwTmfKF1XoHmXVm6x2HREDn2V7fKe54Qm+EcYMKjReSgNiCHXm
         QxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722264786; x=1722869586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9K9fhpcFFyliwAIwtK/bwTIbpmSXLXKLb0zgxn5arM=;
        b=wiwDxkODsgjfSakBWrlqLqw5IIsP7h5LRyJFRwECkB+rWaJwiFdVF4KWLYrZe91yzl
         quhetZFDI1b7YppbahlyT0e5pMaNiI0X6hpUpMVt0rBo7ijpmqBfiuQnlH7yOu67RT5d
         C4OSJ2Uat/VcI8GHRekQW3gJa61eeyOGk5lrAnQy6ngR8pV6z6jAkKVnRowmlNrVwhio
         tRTEW0a5Hao9Nuwcjk7QnjNfkpLlIpi3He5Qq0FCVmQgrA73ZmpmQS9gCkcxBjajIN0F
         FH0NVlvJy6EpYR0DQwaseBFwn5BeVXfLbZPoszcCr6Ljgba5VuztiuGuiNFltydlkkgT
         qQFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9w4lXWwBOcHV2qv3t0flhnamyz1JIaIRgN3bWomUXIvkjjxyL3gSKO3n7dvw54lAjqcEVVYp9Oc0WGNd2mRNgrDhaSml5EcIG4+Hf
X-Gm-Message-State: AOJu0YxC5b2PgiZBwDhWeIMfXmcoosXI013E6B84Gnz9GZH2gA5sEaV0
	QYVLLl4IwMg2aWRjLKHwyTAnpuTyyRghd4ojyqJg5k0ejfJJ4GVzWghx/nnk7oTNJOE7v7bOOD9
	3cXWdgyoMzGaqDEZtLsnvzALUylq5b45kcFUp
X-Google-Smtp-Source: AGHT+IFHH53OjdvvY6abM1KuykhTshVGRqx85vpCme4XgZS/mGrELULyrbRiwMenTyQvf9NV/0FWpW2As9XJg0+07jY=
X-Received: by 2002:a92:c56f:0:b0:377:15c7:1aa0 with SMTP id
 e9e14a558f8ab-39b038c4e4bmr1725ab.25.1722264785831; Mon, 29 Jul 2024 07:53:05
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727175919.1041468-1-linux@treblig.org>
In-Reply-To: <20240727175919.1041468-1-linux@treblig.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 29 Jul 2024 07:52:53 -0700
Message-ID: <CAP-5=fW+VbDaFV+YQCMMKYzrraMLLuVqb=BChL0o=-D5Y=4N_w@mail.gmail.com>
Subject: Re: [PATCH] perf test pmu: Remove unused test_pmus
To: linux@treblig.org
Cc: kan.liang@linux.intel.com, acme@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 10:59=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> Commit aa1551f299ba ("perf test pmu: Refactor format test and exposed
> test APIs") added the 'test_pmus' list, but didn't use it.
> (It seems to put them on the other_pmus list?)
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Strange that the compiler doesn't warn about unused stuff like this,
we get unused variables within a function and unused static
functions...

Reviewed-by: Ian Rogers <irogers@google.com>

Possibly:
Fixes: aa1551f299ba ("perf test pmu: Refactor format test and exposed
test APIs")

Thanks,
Ian

> ---
>  tools/perf/tests/pmu.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> index 40132655ccd1..0b2f04a55d7b 100644
> --- a/tools/perf/tests/pmu.c
> +++ b/tools/perf/tests/pmu.c
> @@ -18,9 +18,6 @@
>  #include <sys/stat.h>
>  #include <sys/types.h>
>
> -/* Fake PMUs created in temp directory. */
> -static LIST_HEAD(test_pmus);
> -
>  /* Cleanup test PMU directory. */
>  static int test_pmu_put(const char *dir, struct perf_pmu *pmu)
>  {
> --
> 2.45.2
>

