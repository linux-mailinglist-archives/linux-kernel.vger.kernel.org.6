Return-Path: <linux-kernel+bounces-395899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA4A9BC4BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F7B282738
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458401B0F18;
	Tue,  5 Nov 2024 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OKDHbWIA"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3D184523
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730784973; cv=none; b=T/MILxzNr6P5iovZQxRzGJIL0b7uC/Bkfo7nqEyZJhWs6Auq5NAxHRRjwXPmcmVyfcBZG8WexOTTWRoh5CGFegpykDOVYsz352MrghVp9BNlWE0pEQLd4krUulsyj6voUp5W72qq+jIs+k/theRkwI3WzYk6cdSY3CYnGhizafw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730784973; c=relaxed/simple;
	bh=7z9yHy3i3NUkPoqHbhSmBzTngDJ/OtHBHeOPuOtBWfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkSe0sS5+StiLDjrAVf2LfYzmOXwRGGJkQTQ2LOs3umtezE2TY9KglMg1j5xd8xT3j1cc2voewSZz8VmJfiKLE6SYNbYiIgj9TZ7fvnBWPUtwsHO5yUbjcquJXm5T6cP4+Yv4aJun9NFp+br5yx/+/YF5Yelp/dtBuPrQ6TQLOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OKDHbWIA; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a6c3bdbebcso152235ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730784971; x=1731389771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNSFaFJwvVfOVEo0X1S6A+LBXmbYg521VtI6VYdAuZ0=;
        b=OKDHbWIANdaD6RxdH7/zpsWYOxHQHscoFZs5vhzf0ZrfvxQfNk1IGrJqw2Wk0r5duz
         N/1u9/fxAuZyKbEq5Otd6O6jOsFjchn0P+s/PX++UX/qNT2hsZ/RkR/vsrPyMZHFmWYw
         XD8SKLwoI1dboxoJUWiEn+AEj7/Of2zbaLdvLt6DzNVApwuHsP7Y0iHVPnuvzqCtlXhR
         PKsk+Q18/XjnhJ34pCuhNkqQih6J8o04YaxZw+4J/7pooP/Q6wG08f5JH+LM/Nl6Hcn+
         3pLYKEgXTw1V5O/liCFKVa7BH4bVHqKK7mUi/MfOB2HLS+4PTIL8M4z/WrfuMu+/8UDk
         VzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730784971; x=1731389771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNSFaFJwvVfOVEo0X1S6A+LBXmbYg521VtI6VYdAuZ0=;
        b=hBxoXkIQvrIsx49YJ6wtUEmRuUPbOu8gJV04B/o2zJuqvMvHiaT3kWI3VyQe3tnGR5
         1vuazQp2Zvs2Glvij8dWa2aFvPHlmJcDTuBKRnB3AmmHaE5bZGmh5vgmUI+nhDTDuMEH
         njbkM71Ek2slQsh5C9ycz6IwXuTsE6WOP73UzjxxWaomavfmX6u7ZVDI5IiGGn5aZ9FQ
         5uqK19ldgUllvqhWpJWsLYvwBRRzdpkflFxzsFhPX5auajE9dSHWZt05oTHG/KT/A6Rq
         O4pwkHLBszclK4IDFtbqaCFLSYQYHHjNJvh+FPbMeL8P6EI3damb9yWEItUo+0ABjmZx
         IYdg==
X-Forwarded-Encrypted: i=1; AJvYcCW/WvAWgbu4x6/nSjeR9wmppIWSylmvq/GPBwUx7PbOOuWT/ScSbZlFdp4p6QU4KafYIx9CILmAYif0MRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFUgl5Ol8soTlQay0cMS3y56x9pwu4h9H5lXtMN9NEIuhyQZO
	aAlp2m8efkM4kYyxUVpRs2LclqQvTBL9YzTbFsqpnKtvrRs8hf68d3W2+7VMj/XeshWSrsor518
	IgGvM1hNZSrlJOjn9o2XkqCcPGi2tYY78Z05d
X-Gm-Gg: ASbGncszFA5aEgv8l3hUE1JGcqqLSAw16B5+DTRiC4UsfcF4UKPbU8v/gGFNI/nNky/
	05VMpqfIgYMag9I6ziwTL2WSj8yMaTpBH
X-Google-Smtp-Source: AGHT+IGmaULqokzt1HTA4nM35nJDyXIBRmsZflaF2PjI6BZHG4xLEFkCqeyZKcquRxBTyidznYW+LIwBteTLYjfc42A=
X-Received: by 2002:a05:6e02:152e:b0:3a6:abc2:73a9 with SMTP id
 e9e14a558f8ab-3a6dba4d7b7mr1322165ab.25.1730784971249; Mon, 04 Nov 2024
 21:36:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105052409.7783-1-haiyuewa@163.com>
In-Reply-To: <20241105052409.7783-1-haiyuewa@163.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 21:35:59 -0800
Message-ID: <CAP-5=fX1OV4+amaEeMfFJUeh0Bpdyp2K1KuNPU3diD0AAXBcVQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf tools: Add the empty-pmu-events build to .gitignore
To: Haiyue Wang <haiyuewa@163.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 9:25=E2=80=AFPM Haiyue Wang <haiyuewa@163.com> wrote=
:
>
> The commit 0fe881f10ceb ("perf jevents: Autogenerate empty-pmu-events.c")
> build will generate two files, add them to .gitignore:
>
>         tools/perf/pmu-events/empty-pmu-events.log
>         tools/perf/pmu-events/test-empty-pmu-events.c
>
> Signed-off-by: Haiyue Wang <haiyuewa@163.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> index f5b81d439387..51713b655f62 100644
> --- a/tools/perf/.gitignore
> +++ b/tools/perf/.gitignore
> @@ -39,6 +39,8 @@ trace/beauty/generated/
>  pmu-events/pmu-events.c
>  pmu-events/jevents
>  pmu-events/metric_test.log
> +pmu-events/empty-pmu-events.log
> +pmu-events/test-empty-pmu-events.c
>  tests/shell/*.shellcheck_log
>  tests/shell/coresight/*.shellcheck_log
>  tests/shell/lib/*.shellcheck_log
> --
> 2.47.0
>

