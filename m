Return-Path: <linux-kernel+bounces-263935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3871193DCC7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78C2283B43
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAE21C36;
	Sat, 27 Jul 2024 00:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujmkvrwL"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F4815BB
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 00:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722041694; cv=none; b=lGtg9Pxi9sVeedeTbeQcvnOxNUbj2kEOzrGlJtMnGw2d3BmU2SCAhKb6zKF8sOBA6VWhOeFN4swQULeNotxD2dmcZidm6Pt9BXduepkx1MHWJi5KTnMi9lmCx5d/yxr5xpW2TwqCiAEX4w99ioAqBHbspuySE03uT9uGJC4MMH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722041694; c=relaxed/simple;
	bh=43/e7OL5mDAX+nxlbTd3MQKh6bPhy36nNsvSvH0Ggb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g515/50954E8XYq0hRMuvPmWIZL0T7OuZvcwFZCSofdeFu/LAkgOvAugfH/KVXOrr1IRbJVb7YZLauix0sRgsu9ZRItuv0rgOc1LKJHMQ9IQz4gvstvO3LNkCid0QVsYP6sgfPCKVAF/hQy/0mQuCxTKqoNl9Lbg3c2VMC/KLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujmkvrwL; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44e534a1fbeso4901cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722041692; x=1722646492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DNL/itS01ACipudqtOXhEIJgpANaHep/1GbrKh0bQQ=;
        b=ujmkvrwLSC4GmoT60X+SdxsNu2JSSOcvuzM7afEMtl5SLTQFHaHiml62O069RE495o
         tiXtbSBeqnYKIkF1w/lfyTv3P0m8xEvUkiq/7fRjOUuV0ipQVLuq2gKBTKzXti8GC8i3
         gK7JuNadIPIRUxfa62126rTmuvJnvu0F2e91rSKnGdIvRW2VbvOyNGBbaVJw8h06fySZ
         Fb+Enm4BR2XDqgJxWEs3SfFyBpMOpGzU7OsSw6W9Cg5zGA+GbFQCg/chqXW84jyHrpd3
         EEpXm4IV7kirpzCI6MqswpdS05k506yLDtfNUqsqTUumX5jZWnr4WkCrhcp2ktxHsQ0W
         5WFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722041692; x=1722646492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DNL/itS01ACipudqtOXhEIJgpANaHep/1GbrKh0bQQ=;
        b=unWhTU/TWy4IadXRQnZI5HU/YdObOMbTHrkE1IIZG27uvjB3zc1l9TDoNSlYprxV7i
         ioiT3IvZd1cr4qVGR6Wnfcb7ixt6l0HZen6nuGW3wLLRixSNLpxbtHvqWPun7Du2bYM+
         A3LRDDpsqtQbQf1VeKYX9bv4U/amPgZyKXJ8jdjDSzsO+PJPcUusZHnFh6OmYCqE01oh
         4jxU50w5pf9Ks3zvb1/13v3KAwGDsR82C7HW+3hW9QSQB60sPrfXHFoB8mvao9RR3VK4
         wjrlKLYZXdhEzOE+CZwkRmTrwRXRzzdcXihk7hNGlgrs5+EdKEqMg1Wz7eJfFiLA3hyD
         JUQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0yvRWv5YMXXYMQqVGfS05oZsRqWojAgMSW8rRxry8Xxv2PjSR1Hbv+OLtYXZhXnhvOKOcTU0MhNANiCgrRAAsupF7m8xFPapPVT1W
X-Gm-Message-State: AOJu0YwyqYDqkinhDTmnL6V+BBAug+YQKYijfnJw89AybD/XsEJEJV6v
	HVvBzH3wanjRM0IhDUe6MItI4Yxa9QiFnkYSylaabDmOvcwFnKDGUP043u1X6MpbB/pKMTRpq4v
	d4VziCFHpXXfXUs55bgSmc/W+ckQ9TO2Nnyu3
X-Google-Smtp-Source: AGHT+IE3JtqBwHojGMjdeDgn3Wlmq60256m9PWSY8cvh/uSekhvw6xMEHK2SQjFR+8baFtW0FtKOBGSN9qMhqgVlp5Y=
X-Received: by 2002:ac8:5ac9:0:b0:44f:9db1:7fca with SMTP id
 d75a77b69052e-44ff3b37a18mr5683761cf.28.1722041691571; Fri, 26 Jul 2024
 17:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726102826.787004-1-howardchu95@gmail.com> <20240726102826.787004-6-howardchu95@gmail.com>
In-Reply-To: <20240726102826.787004-6-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 26 Jul 2024 17:54:40 -0700
Message-ID: <CAP-5=fUztDHbZcwpT4VrXaGahH3k=B=uU-otv4tniJr=fazkFg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] perf record off-cpu: Add direct off-cpu test
To: Howard Chu <howardchu95@gmail.com>
Cc: namhyung@kernel.org, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 3:28=E2=80=AFAM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Add a simple workload(offcpu.c) to create the scenario for direct
> off-cpu dumping.
>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Suggested-by: Ian Rogers <irogers@google.com>

I tried with and without --off-cpu-thresh=3D1 but I only see 1
offcpu-time sample and no offcpu-time-direct.

Thanks,
Ian

> ---
>  tools/perf/tests/builtin-test.c         |  1 +
>  tools/perf/tests/shell/record_offcpu.sh | 29 +++++++++++++++++++++++++
>  tools/perf/tests/tests.h                |  1 +
>  tools/perf/tests/workloads/Build        |  1 +
>  tools/perf/tests/workloads/offcpu.c     | 16 ++++++++++++++
>  5 files changed, 48 insertions(+)
>  create mode 100644 tools/perf/tests/workloads/offcpu.c
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index c3d84b67ca8e..5062058ad17d 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -152,6 +152,7 @@ static struct test_workload *workloads[] =3D {
>         &workload__sqrtloop,
>         &workload__brstack,
>         &workload__datasym,
> +       &workload__offcpu,
>  };
>
>  static int num_subtests(const struct test_suite *t)
> diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/s=
hell/record_offcpu.sh
> index 67c925f3a15a..1ea0a44336e2 100755
> --- a/tools/perf/tests/shell/record_offcpu.sh
> +++ b/tools/perf/tests/shell/record_offcpu.sh
> @@ -6,6 +6,7 @@ set -e
>
>  err=3D0
>  perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +TEST_PROGRAM=3D"perf test -w offcpu"
>
>  cleanup() {
>    rm -f ${perfdata}
> @@ -88,6 +89,30 @@ test_offcpu_child() {
>    echo "Child task off-cpu test [Success]"
>  }
>
> +test_offcpu_direct() {
> +  echo "Direct off-cpu test"
> +  # dump off-cpu samples for tasks blocked for more than 1999ms (1.9s)
> +  # -D for initial delay, which is necessary if we want to enable evlist
> +  if ! perf record -F 1 -D 999 --off-cpu --off-cpu-thresh 1999 -o ${perf=
data} ${TEST_PROGRAM} 2> /dev/null
> +  then
> +    echo "Direct off-cpu test [Failed record]"
> +    err=3D1
> +    return
> +  fi
> +  if ! perf evlist -i ${perfdata} | grep -q "offcpu-time-direct"
> +  then
> +    echo "Direct off-cpu test [Failed no event]"
> +    err=3D1
> +    return
> +  fi
> +  if ! perf script -i ${perfdata} | grep -q -E ".*2[0-9]{9}[ ]*offcpu-ti=
me-direct" # 2 seconds (2,000,000,000)
> +  then
> +    echo "Direct off-cpu test [Failed missing output]"
> +    err=3D1
> +    return
> +  fi
> +  echo "Direct off-cpu test [Success]"
> +}
>
>  test_offcpu_priv
>
> @@ -99,5 +124,9 @@ if [ $err =3D 0 ]; then
>    test_offcpu_child
>  fi
>
> +if [ $err =3D 0 ]; then
> +  test_offcpu_direct
> +fi
> +
>  cleanup
>  exit $err
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 3aa7701ee0e9..84ab15683269 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -205,6 +205,7 @@ DECLARE_WORKLOAD(leafloop);
>  DECLARE_WORKLOAD(sqrtloop);
>  DECLARE_WORKLOAD(brstack);
>  DECLARE_WORKLOAD(datasym);
> +DECLARE_WORKLOAD(offcpu);
>
>  extern const char *dso_to_test;
>  extern const char *test_objdump_path;
> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workload=
s/Build
> index 48bf0d3b0f3d..f37e9be8b142 100644
> --- a/tools/perf/tests/workloads/Build
> +++ b/tools/perf/tests/workloads/Build
> @@ -6,6 +6,7 @@ perf-test-y +=3D leafloop.o
>  perf-test-y +=3D sqrtloop.o
>  perf-test-y +=3D brstack.o
>  perf-test-y +=3D datasym.o
> +perf-test-y +=3D offcpu.o
>
>  CFLAGS_sqrtloop.o         =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_leafloop.o         =3D -g -O0 -fno-inline -fno-omit-frame-pointer=
 -U_FORTIFY_SOURCE
> diff --git a/tools/perf/tests/workloads/offcpu.c b/tools/perf/tests/workl=
oads/offcpu.c
> new file mode 100644
> index 000000000000..02be3d05b06d
> --- /dev/null
> +++ b/tools/perf/tests/workloads/offcpu.c
> @@ -0,0 +1,16 @@
> +#include <linux/compiler.h>
> +#include <unistd.h>
> +#include "../tests.h"
> +
> +static int offcpu(int argc __maybe_unused, const char **argv __maybe_unu=
sed)
> +{
> +       /* get pass initial delay */
> +       sleep(1);
> +
> +       /* what we want to collect as a direct sample */
> +       sleep(2);
> +
> +       return 0;
> +}
> +
> +DEFINE_WORKLOAD(offcpu);
> --
> 2.45.2
>

