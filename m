Return-Path: <linux-kernel+bounces-368267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0119A0D73
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63255288445
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5074B20CCEA;
	Wed, 16 Oct 2024 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="agmDJ8UU"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C2920821C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090533; cv=none; b=lltsTI8zrKx8LDWQs3t/yxwZFKs1IkZpt425BYpTQJg2ZtvI6hSCqgAojBq4J7aj0ZmDx5f3NOgCLbuH3JuCL6UA49+a4QOkB5iE9UkJiZqIog06mcBlPZVaS70sa8kHxdJxtfzSjRIVgY1KOo+zjiB95uBSpJs4hwmWkYnXVGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090533; c=relaxed/simple;
	bh=lhStgkW1nOmPDE/zibhXWPJlliM/BQNg1rEJG90y3R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgu8xdeNXlsiog28AlPkIYQO+LIkIBySvLpETfWwwEyI3R9MnpypqS7DttdW6eXYyLd1kmoZ6NwRdfHUfeezJShDY0z3k7WeCfVFxfUD3mANp6j9L7f7gNBpJ85PSCvmlOFnMbhEIhXWcBjn+msC8OkHsl7sN9VB7iW3xaMbo5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=agmDJ8UU; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so171805ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729090531; x=1729695331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5ndcWCV7GBa6KmSNUJ6McmDrO0FkYlO8NF3CckatKQ=;
        b=agmDJ8UUPD8qZNqIasRUSLjKi62ccJvOmPjOG3xj/UGR39qJUXcCj8haLNpK/ixbW+
         7Lr26Ryq2MXUby2lHvqpKwAo34hE1QNc/XjTjMr1odgpiWpGqx1cgo6b0MCcwAJBIrri
         A6zgQ0ixMgA7/R3Hjeu1tBTNCYP+mga+cko1PoC9zmn0wkif/0nFLjFx9LhgO/ue/t2K
         j50Qu/Ql2VrJjCFATyBHmxoZTgOQHHmxwSz1WQ2J7u66ptLG//fK6IsyGDDIeWuW9Wt2
         3RjQ/ifz0N93Z5ZV1Nmgj7bz5BGcsFKlSV/R/pm7sxdXyvLnM+OrBQV8SYcJeB/Nk+Ka
         WPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729090531; x=1729695331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5ndcWCV7GBa6KmSNUJ6McmDrO0FkYlO8NF3CckatKQ=;
        b=oN59NYaRuok/s9Kr0OZJJbnEjxA6AUFpuaz6QBaG/TcSSrpcQ4d84Tm9us+z445lqY
         42B6/3R2W7zjsgjleuQGKlRa7TWApe0hzeZzr//P8NS+OVTe47wC+4SxiI3VbwDbvXbv
         zoyQIwr7OPHwyR7YK9BlJmHSwp9VuZw2v0sNr/kdbXFUWxysh3N+FSlr6CcZ33QXPgmh
         twvHIGeT7AHDuRAmSzjpNr9QFYaRbCELIOpRCpedKb0xNmC+BQy8dLW/dUhLfcNeRkmE
         8EBdz8E4h+ilvOmSzNkUgTonJmDGA1opWFdzfEapFk/+Oj73lDr+I+4WlxaR/Tln3WCL
         9PHA==
X-Forwarded-Encrypted: i=1; AJvYcCVWYIrfDHkWk9fyyJUeBZqzLRMFt7ImTOnei/6lmKaMGzROMyMdbHF17ZVWDAGV47Lo1ZUnUVZV/pt0qo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQur2xAJ5DoA4igZV5Ec7z3USRUu9dfSzoWW0Eitq8HP/ZrRx
	sdqShn7wHzx+Ovr2OeyByvO1Bv1TE5euhL6awTuoedANAAeZmCfDlQRfccSKJoROEtWw+zKghLm
	OVv4ZUFjNmxtRUqIwS27INIJiU5FtTiebQBlP
X-Google-Smtp-Source: AGHT+IFAD0SSxWQ+/5diCeKc7c0u4sL0M9E0RTFkufYU9vk1dYWzrc01o217x2qTlswxzulprYDuCd9aEEc+tGDtBM8=
X-Received: by 2002:a05:6e02:13aa:b0:375:bb49:930d with SMTP id
 e9e14a558f8ab-3a3de7d22dfmr2880775ab.23.1729090531199; Wed, 16 Oct 2024
 07:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016065654.269994-1-namhyung@kernel.org> <c28ce930-9a70-4f23-9f6b-541c16c212e3@linaro.org>
In-Reply-To: <c28ce930-9a70-4f23-9f6b-541c16c212e3@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Oct 2024 07:55:17 -0700
Message-ID: <CAP-5=fW3So87z8Q+J5eNf+a2PP2toDe3GX5HB7akecR7TBV__A@mail.gmail.com>
Subject: Re: [PATCH] perf test: Speed up some tests using perf list
To: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>, 
	German Gomez <german.gomez@arm.com>, Carsten Haitzler <carsten.haitzler@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 1:25=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 16/10/2024 7:56 am, Namhyung Kim wrote:
> > On my system, perf list is very slow to print the whole events.  I thin=
k
> > there's a performance issue in SDT and uprobes event listing.  I notice=
d
> > this issue while running perf test on x86 but it takes long to check
> > some CoreSight event which should be skipped quickly.
> >
> > Anyway, some test uses perf list to check whether the required event is
> > available before running the test.  The perf list command can take an
> > argument to specify event class or (glob) pattern.  But glob pattern is
> > only to suppress output for unmatched ones after checking all events.
> >
> > In this case, specifying event class is better to reduce the number of
> > events it checks and to avoid buggy subsystems entirely.
> >
> > No functional changes intended.
> >
> > Cc: German Gomez <german.gomez@arm.com>
> > Cc: Carsten Haitzler <carsten.haitzler@arm.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
>
> Reviewed-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

There's a nice better than >2x speed up waiting in too :-)
https://lore.kernel.org/lkml/20241011220354.756798-1-irogers@google.com/

Thanks,
Ian

