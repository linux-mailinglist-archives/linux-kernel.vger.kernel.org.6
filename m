Return-Path: <linux-kernel+bounces-336227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D04A97F0DB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8320B21AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E41819F105;
	Mon, 23 Sep 2024 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hUKWUStb"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208BB14A85
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727117529; cv=none; b=lbCVSG+BV0u68BjyLuIo4N9KmkiZ7GlD00ZX9tJr5Vygobjbk+9wqjZ01d49n6kkrTAWUDVKS90xdAn/484tS/dhmTZrISW3GnnI6EaJMDKNeXEoMx7qIzfeVKZf0MRBctWgs47Y9d3MpAaXz0XZnc+YiQIjgfZ0ld4GkX/Zr5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727117529; c=relaxed/simple;
	bh=zLpUr1SxnEAF71ZZ0b+lxYmH+BbaNSeMXUJA3JUB1Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Cv4yzJu+9MlfvVl2cd92NZ/iyyuHIzLTpmN248BXTjv2VWVWhHk8QHarf26v1dzlRsWJBrpk8W4KkB4PnNT8LXPsIG5DalG/w+8WKAZzTEfqy6QcYvKecFLNufwIjLFhqd9BVzSedlmuNYqZ8acRA10oPGN6HKOg/0Jpe7d2XAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hUKWUStb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20546b8e754so27635ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727117527; x=1727722327; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXmMrEY65D+AePLk+PY6S5yXHIk7WNDJcw3IWnzcWek=;
        b=hUKWUStbPz0/lVAoVSGzHiy8Xw3nsjdBIHN3lF00Cg4P1/pfze4uFEX+EhZQoLviWj
         ZEuhaLaUCNr1WXkv2VPjrpnnpMeem+OeY5wffs9f5zBbZohsIMxvyw8GmPwtlIGfOvlP
         jLKhwfGPJTJa0qDft/kALSDiaepz6/lHU2FgpXVetxFNp+N+OpCeuNG1sFxWUSmR4uyM
         Ycx1WH05KVP3tUtyFk21heqF44lfiWMmhOtKc/0gDz0QLxXp8gTgsHhV13lCLfh3BsWc
         hKH5EJ7QvNSmqYMEQc9/gZtjb1i3VOHP+b3ynydIUzoVbBE0ny2Ou78olOrYVCuBxrpW
         BtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727117527; x=1727722327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXmMrEY65D+AePLk+PY6S5yXHIk7WNDJcw3IWnzcWek=;
        b=B8ApDpigxwFlmZ0xfKIAoI46lKcmFxvsrCp01KXTgr2BQhhBn1bIJHLxIgDFiiysiG
         ymNc2HxCDsxma41yhd/L20Pfg6/9yXj2H3bbhWqLSJoWsbpi0OLs8ryYhBU/F979wQzN
         6dndjDdkREXb9JsQHbl4pWpd9vmSstQdpChypyKMVRnRLaBZlbHoF2A1lFiGzoMVvR6L
         pSLLp42aqrlGwD84j9fONsM8w7tSdbA9SmcuW3+E+/ndjWZoCyz5RDELLJX4XXMd3TQc
         gqInMkEvfJ2XwNAEXFISIbdQpRHneKgkBZI2BB5dYk1uPTmFrH1gUvNfb0msPle5+v5m
         U6Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXcFN9LAj2KZEdjeA9wwaJbEQ1STO0wnbzsox6JayqDgXfp498ZnBu5a0t9gs8qkgVPyAV6CFCcok81g30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNnQMm2KHvlaNaFL7kbJzTzVBNPbI7NciGDNmvZbh7quQHSC/m
	Q6rPwmMkiJUMehQM6ZHXK7XGi3idFMivy64zYAc91dOHfpN7i2kVVA9+36Q5AF+P0oTpRKRXECd
	awqyx4gypj//r5Rat3InNF2nVxHtIr+pQGV3G
X-Google-Smtp-Source: AGHT+IHhtTzu2ptbvGN+YZHo5PJz5j6+4vOkPRlt/xchM9K51k7a14RCaGHYbGk/xjJ2jQV3gdSH2Vc/n3mWPlU1B1Q=
X-Received: by 2002:a17:902:db02:b0:206:aa47:adc6 with SMTP id
 d9443c01a7336-20aef38cb7emr254245ad.11.1727117527029; Mon, 23 Sep 2024
 11:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502223115.2357499-1-irogers@google.com>
In-Reply-To: <20240502223115.2357499-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Sep 2024 11:51:53 -0700
Message-ID: <CAP-5=fXGaLsnqd2DdEx-+9V8tO6Wi_HNFgzrGdhdFo5nFSCb9w@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Be more tolerant of metricgroup failures
To: Veronika Molnarova <vmolnaro@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 3:31=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Previously "set -e" meant any non-zero exit code from perf stat would
> cause a test failure. As a non-zero exit happens when there aren't
> sufficient permissions, check for this case and make the exit code
> 2/skip for it.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2. Add skip if event mode isn't valid in per-thread mode. Suggested
>     by Veronika Molnarova <vmolnaro@redhat.com>.

Ping.

Thanks,
Ian

> ---
>  .../perf/tests/shell/stat_all_metricgroups.sh | 36 +++++++++++++++----
>  1 file changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf=
/tests/shell/stat_all_metricgroups.sh
> index 55ef9c9ded2d..c6d61a4ac3e7 100755
> --- a/tools/perf/tests/shell/stat_all_metricgroups.sh
> +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
> @@ -1,9 +1,7 @@
> -#!/bin/sh
> +#!/bin/bash
>  # perf all metricgroups test
>  # SPDX-License-Identifier: GPL-2.0
>
> -set -e
> -
>  ParanoidAndNotRoot()
>  {
>    [ "$(id -u)" !=3D 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid=
)" -gt $1 ]
> @@ -14,11 +12,37 @@ if ParanoidAndNotRoot 0
>  then
>    system_wide_flag=3D""
>  fi
> -
> +err=3D0
>  for m in $(perf list --raw-dump metricgroups)
>  do
>    echo "Testing $m"
> -  perf stat -M "$m" $system_wide_flag sleep 0.01
> +  result=3D$(perf stat -M "$m" $system_wide_flag sleep 0.01 2>&1)
> +  result_err=3D$?
> +  if [[ $result_err -gt 0 ]]
> +  then
> +    if [[ "$result" =3D~ \
> +          "Access to performance monitoring and observability operations=
 is limited" ]]
> +    then
> +      echo "Permission failure"
> +      echo $result
> +      if [[ $err -eq 0 ]]
> +      then
> +        err=3D2 # Skip
> +      fi
> +    elif [[ "$result" =3D~ "in per-thread mode, enable system wide" ]]
> +    then
> +      echo "Permissions - need system wide mode"
> +      echo $result
> +      if [[ $err -eq 0 ]]
> +      then
> +        err=3D2 # Skip
> +      fi
> +    else
> +      echo "Metric group $m failed"
> +      echo $result
> +      err=3D1 # Fail
> +    fi
> +  fi
>  done
>
> -exit 0
> +exit $err
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>

