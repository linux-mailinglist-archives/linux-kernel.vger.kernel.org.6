Return-Path: <linux-kernel+bounces-372464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD559A48E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318F61C233A7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E64418C92A;
	Fri, 18 Oct 2024 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X9qIxKfk"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11584204F7F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286812; cv=none; b=Qa9YFPjO7dokj3LFQvWidjS807Sm9p32TxE5Umxt4ipSsbB3dPIYNWwvyGYzse3gNW+lDcCRFYg9dy3NtmD8y7jgopkwYz4dciGHbw8UkP2mH1szkDk1xynni7q3v74/XkJKigxXXSpPp79rpBoIS3E0FQOHc0tNeQK/p0Gdcdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286812; c=relaxed/simple;
	bh=Bifc0ooLfxCPKSJr3sxfNROTVgXl3ObhrwqkBSyou8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIXASzX3Kxi/ysy8s+xQgikO6FjMWxZ+zBg1ZIx+Dm1X83wz2ses3PzpkZVZUAQh9KoUZE7k9xZPziLjWYKxHXCnvl+tFJCuNZY9nxupEv7z3mQRoxhMJwFhpItQOXm06HAIvfKFUBhFLMlSv/j6zciX19Hh/3xqMgQKbSU1EBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X9qIxKfk; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460a8d1a9b7so22181cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729286809; x=1729891609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bT8Ba4ZWeSCG80fJdq0OruJ7WQHACI1LDVOlqFGGrC4=;
        b=X9qIxKfkF8yz3ryrRvAe6STEtVwB9WUAbyyZ8ncodGXWWmhTN8TF405HaUKW5Ig0KK
         +p0dqTvPhY2yqI1n1++EE/o4qegMoij19/06N2EbtRzFGBQ9rLACLwOpzTH4B5h5CSE5
         1ao0YoPJKJ47JIY5aU9f+stXZqh9+HkESDBGUi17QeA0cEwEdvbXYijVKX+xEa8JBxhn
         49TlNYPoaI2keTIZ+xmm9J2BVEBBQvINb8uPeplD8LSc9B8w4VEZV8wmGf7FCE9GNEB5
         P8JIFT02iNKQB7pDAtpMgEbEzZFxIE/dVzjtzkBycR8e4hLPa9dMp+KUB1huydMWGiOu
         opfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729286809; x=1729891609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bT8Ba4ZWeSCG80fJdq0OruJ7WQHACI1LDVOlqFGGrC4=;
        b=VkPOS9P7rgIuzatEEAQBJWaGUw5pYmM9KXFcQ+f+A1RnLFFk8WaYQr3tDW9N2FSyTq
         xUC76T0A3evMe1rPLsf/HymPEXvrIteN1AUmFteJ+ujOANZmg/Dsh6wZ1dzxNtDgP8it
         QNIUM7tLvGSELNM0UvNZAIwEk+dVX7AcJhITrLFKzCF4+iIFKEIfENTCrlEDR+Md3RNQ
         PRKPYwtqWGJsNsT71LP2uCyw03W40WzI1ria7jIcNAmOWLax3HUiTpXBVleKGNbaj36i
         Tpgp9/ywKpB4PB36nc7ZuEhGXXOb4nQ6WEMDfkEfqd2VrMkn26Zu4ubuuno+5ZlCWzvl
         cLyA==
X-Forwarded-Encrypted: i=1; AJvYcCUqcabwbcqo7l+5xO39JTfvjM2ILXNPdsUb454DI5rlG7+oDSs0j3szZuhMe3dTVu2ZvNtdBwApzfoBQYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7dWf73L2wIrb0q1WtehUrbuVtwy7IMD2AAhDfk+NIqTs8D5W6
	9JnLpi5Fs53qfqarIQN7KyoiFx9HbKZezNTI75wSCH1HEPe9uTDGDshR+xJbv771HgUFLlJwhMq
	ZhOC9EYL7eihLgQuViGO5d6ElN36wuh76eda9wq3tJ5MHThpZIMXF
X-Google-Smtp-Source: AGHT+IHZ0lrEqW26XgwqaSsbg0q2R0Ve84a2kdgbZqy21howwoTK7IjHy0dsGYUjRDu4c/H0tHhL4vj/GFexTy3Oc8g=
X-Received: by 2002:ac8:5ac2:0:b0:460:48fc:3cd8 with SMTP id
 d75a77b69052e-460be411dbfmr292291cf.5.1729286808639; Fri, 18 Oct 2024
 14:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018204306.741972-1-namhyung@kernel.org>
In-Reply-To: <20241018204306.741972-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 18 Oct 2024 14:26:34 -0700
Message-ID: <CAP-5=fXBJ7XpaXJ+9ZChJfkB3QX5jjM20CxvPH14oN=NFjy8eA@mail.gmail.com>
Subject: Re: [PATCH] perf test: Update all metrics test like metricgroups test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 1:43=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Like in the metricgroup tests, it should check the permission first and
> then skip relevant failures accordingly.
>
> Also it needs to try again with the system wide flag properly.  On the
> second round, check if the result has the metric name because other
> failure cases are checked in the first round already.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/stat_all_metrics.sh | 87 ++++++++++++++++------
>  1 file changed, 66 insertions(+), 21 deletions(-)
>
> diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/test=
s/shell/stat_all_metrics.sh
> index 54774525e18a7b9a..73e9347e88a964bd 100755
> --- a/tools/perf/tests/shell/stat_all_metrics.sh
> +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> @@ -2,42 +2,87 @@
>  # perf all metrics test
>  # SPDX-License-Identifier: GPL-2.0
>
> +ParanoidAndNotRoot()
> +{
> +  [ "$(id -u)" !=3D 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid=
)" -gt $1 ]
> +}
> +
> +system_wide_flag=3D"-a"
> +if ParanoidAndNotRoot 0
> +then
> +  system_wide_flag=3D""
> +fi
> +
>  err=3D0
>  for m in $(perf list --raw-dump metrics); do
>    echo "Testing $m"
> -  result=3D$(perf stat -M "$m" true 2>&1)
> -  if [[ "$result" =3D~ ${m:0:50} ]] || [[ "$result" =3D~ "<not supported=
>" ]]
> +  result=3D$(perf stat -M "$m" $system_wide_flag -- sleep 0.01 2>&1)
> +  result_err=3D$?
> +  if [[ $result_err -gt 0 ]]
>    then
> -    continue
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
> +      continue
> +    elif [[ "$result" =3D~ "in per-thread mode, enable system wide" ]]
> +    then
> +      echo "Permissions - need system wide mode"
> +      echo $result
> +      if [[ $err -eq 0 ]]
> +      then
> +        err=3D2 # Skip
> +      fi
> +      continue
> +    elif [[ "$result" =3D~ "<not supported>" ]]
> +    then
> +      echo "Not supported events"
> +      echo $result
> +      if [[ $err -eq 0 ]]
> +      then
> +        err=3D2 # Skip
> +      fi
> +      continue
> +    elif [[ "$result" =3D~ "FP_ARITH" || "$result" =3D~ "AMX" ]]
> +    then
> +      echo "FP issues"
> +      echo $result
> +      if [[ $err -eq 0 ]]
> +      then
> +        err=3D2 # Skip
> +      fi
> +      continue
> +    elif [[ "$result" =3D~ "PMM" ]]
> +    then
> +      echo "Optane memory issues"
> +      echo $result
> +      if [[ $err -eq 0 ]]
> +      then
> +        err=3D2 # Skip
> +      fi
> +      continue
> +    fi
>    fi
> -  # Failed so try system wide.
> -  result=3D$(perf stat -M "$m" -a sleep 0.01 2>&1)
> +
>    if [[ "$result" =3D~ ${m:0:50} ]]
>    then
>      continue
>    fi
> -  # Failed again, possibly the workload was too small so retry with some=
thing
> -  # longer.
> -  result=3D$(perf stat -M "$m" perf bench internals synthesize 2>&1)
> +
> +  # Failed, possibly the workload was too small so retry with something =
longer.
> +  result=3D$(perf stat -M "$m" $system_wide_flag -- perf bench internals=
 synthesize 2>&1)
>    if [[ "$result" =3D~ ${m:0:50} ]]
>    then
>      continue
>    fi
>    echo "Metric '$m' not printed in:"
>    echo "$result"
> -  if [[ "$err" !=3D "1" ]]
> -  then
> -    err=3D2
> -    if [[ "$result" =3D~ "FP_ARITH" || "$result" =3D~ "AMX" ]]
> -    then
> -      echo "Skip, not fail, for FP issues"
> -    elif [[ "$result" =3D~ "PMM" ]]
> -    then
> -      echo "Skip, not fail, for Optane memory issues"
> -    else
> -      err=3D1
> -    fi
> -  fi
> +  err=3D1
>  done
>
>  exit "$err"
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

