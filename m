Return-Path: <linux-kernel+bounces-292376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EE7956E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349FA1C21214
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D8B3B1A4;
	Mon, 19 Aug 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mSboWkT2"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961054779F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080857; cv=none; b=lVsNB7OZeyI70tolWEksFvBYboDbezuWy1qTlPHM4sav0HIRX2D8a+p/pDEB4ewLhTBEB0+f+yBu3LEtzVL+geDoLH2sdxAN7olwYKX8L3z0ETJu3OtC7L+f/VW2aKMgliTrgYTd0C3PqGsOO22+ajnG6mj3ePmNiUaCQk3+HBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080857; c=relaxed/simple;
	bh=T7qaaicGJUnoLXKokM7lS8p2Swf1u65hJRrhBHJ4Cq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZPw/xctYJapofldNI1UXBNvjKMJpQLqVTrIgjdPkGZmTC1AUGU8qFYWKYYLkDjNPE21Dm1t8DCoWWidOkbRCHrB3BHejKse4N6M0tuOCiE8BHvbV4qKrRRsv0e6axfN+6Od7o6NRi5MCQJ2l506XvnZw1WMUqNFmxSGe+9v9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mSboWkT2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fd7509397bso115505ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724080855; x=1724685655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFRYt1Wga+lCQYlrwyH/jQ7PLLA0jQfcjmSTgkpdY8k=;
        b=mSboWkT2LK3HK41e2CQ1nDnrdUZWecsxtQys/omoYUb5p8/IAGei/fuaGOXsLzi60y
         nUNDCFEMBsr0HXcAhX2LkqsktVpi5WTHcE/y/WBgTm6KZ6QXsWNzsHwyo0vClr3V34Vr
         JeSZevpsi7/wu2jnj/BcIuFJo4uJcIe8aVeQEeCrFLExQ5yPcFn3aGHsKkT6UwC+vN2U
         IeVqn/8tQSKURvEDz8EiWYOo0VK1fGBCBMlBsKVoq/ja02MhSJBmegik1c487yFNlF81
         HIYI8Tq54F2So+Qeq4GJI1S0PzprpXMdmz081OXwdXPajuXxCKfwtFzn3Gak2ektKuN/
         GiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724080855; x=1724685655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFRYt1Wga+lCQYlrwyH/jQ7PLLA0jQfcjmSTgkpdY8k=;
        b=TnspFEQDWuPW09R6ucMBTMTrMaCqBV+buM5bH0M2BwDAOr3SEeUTyztjkLc2EesXNv
         LTifeMx2FQV6Nsy80jFSND8YgXQkYpev7lsAZfTPWOvhk+WRHeRZ2Lth+xyRn4MLPE/1
         hVrVx680o/GgXJhX+PnH+g8P47AXv7xF1pP1D2mQbId8e2X0mLWJHhBLvthbWbYriNGI
         rPqHEgBvAQV4UdWsChyDbVa1o78VNge0z8YF0H65Rp33XXOExM9apu3JwiqYb2EZ8Y8i
         2Xy5HzVMMTsQFfyVsAdjge6KIQ/+x8MK6V+W7uiQJPdPkHBBzeZqD7xXy+QnKkfqAXT7
         kkBA==
X-Forwarded-Encrypted: i=1; AJvYcCWkeygbOzXq9SZA4VVjW8/CRZwXeegsYrSEWFQ32iaHdS3MCdT6IeCCC1tBe8G1504A1xy/wSGfWMfkx4rdrIi0SmGX9SQkYdfJYaCN
X-Gm-Message-State: AOJu0YxcRNNeNeTch0P5vt7X39CzCO2yS+CmMGfkJajfNIkqO9wG1OFh
	E7PX0AbfgGHyadwtkEJDcFVZxIZ9yG8Zuk20gLGG6LPkVWz3x+iDpaNXoKGVL/Hg/I7hOn0ETgl
	q7thtSJmAHVUtxWw9uAwAiOs/xyccjSbrMkyX
X-Google-Smtp-Source: AGHT+IFatrDwzmdUbS4q6O9KOGQeYdl7aB8/H49bOtD2OTjVUoJK6sYswiWNTrCU8Kup3Nu2/Hm3I8yeMaFQOnnNFM0=
X-Received: by 2002:a17:902:d2c6:b0:1fa:f738:62fd with SMTP id
 d9443c01a7336-2021bcf798bmr1410285ad.7.1724080854415; Mon, 19 Aug 2024
 08:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818212948.2873156-1-namhyung@kernel.org> <20240818212948.2873156-2-namhyung@kernel.org>
In-Reply-To: <20240818212948.2873156-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 19 Aug 2024 08:20:43 -0700
Message-ID: <CAP-5=fXzXYD1FE_0k45hWzHsKtnra2WOR-K+u30eTECP3i9KOQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Add cgroup sampling test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 2:29=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Add it to the record.sh shell test to verify if it tracks cgroup
> information correctly.  It records with --all-cgroups option can check
> if it has PERF_RECORD_CGROUP and the names are not "unknown".
>
>   $ sudo ./perf test -vv 95
>    95: perf record tests:
>   --- start ---
>   test child forked, pid 2871922
>    169c90-169cd0 g test_loop
>   perf does have symbol 'test_loop'
>   Basic --per-thread mode test
>   Basic --per-thread mode test [Success]
>   Register capture test
>   Register capture test [Success]
>   Basic --system-wide mode test
>   Basic --system-wide mode test [Success]
>   Basic target workload test
>   Basic target workload test [Success]
>   Branch counter test
>   branch counter feature not supported on all core PMUs (/sys/bus/event_s=
ource/devices/cpu) [Skipped]
>   Cgroup sampling test
>   Cgroup sampling test [Success]
>   ---- end(0) ----
>    95: perf record tests                                               : =
Ok
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index 36883b03169f..048078ee2eca 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -206,6 +206,28 @@ test_branch_counter() {
>    echo "Branch counter test [Success]"
>  }
>
> +test_cgroup() {
> +  echo "Cgroup sampling test"
> +  if ! perf record -aB --synth=3Dcgroup --all-cgroups -o "${perfdata}" $=
{testprog} 2> /dev/null
> +  then
> +    echo "Cgroup sampling [Skipped not supported]"
> +    return
> +  fi
> +  if ! perf report -i "${perfdata}" -D | grep -q "CGROUP"
> +  then
> +    echo "Cgroup sampling [Failed missing output]"
> +    err=3D1
> +    return
> +  fi
> +  if ! perf script -i "${perfdata}" -F cgroup | grep -q -v "unknown"
> +  then
> +    echo "Cgroup sampling [Failed cannot resolve cgroup names]"
> +    err=3D1
> +    return
> +  fi
> +  echo "Cgroup sampling test [Success]"
> +}
> +
>  # raise the limit of file descriptors to minimum
>  if [[ $default_fd_limit -lt $min_fd_limit ]]; then
>         ulimit -Sn $min_fd_limit
> @@ -216,6 +238,7 @@ test_register_capture
>  test_system_wide
>  test_workload
>  test_branch_counter
> +test_cgroup
>
>  # restore the default value
>  ulimit -Sn $default_fd_limit
> --
> 2.46.0.184.g6999bdac58-goog
>

