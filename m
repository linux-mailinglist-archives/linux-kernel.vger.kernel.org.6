Return-Path: <linux-kernel+bounces-404509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110539C4492
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C91283586
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADD61AA787;
	Mon, 11 Nov 2024 18:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZmKdjx8"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF87C1A7066
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348542; cv=none; b=FVwYV1pZHaFfHZSwAEo8mgXUGr9z+deGwBRxKvkyu5chzdNNS+1W5JPF/1I20MQ+k0Pt/YQC6F4TrB6h4q6sfpevojbYm8KRs/IkFNFrQnFv/Gt2eUld6pUMuBrRQWQDbo8HwwYxeWnUajssIMZA93PWCOuq9Iktxrxaofym77Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348542; c=relaxed/simple;
	bh=+olZ5sDQhxS7+5VbaMBZxP2EBhVUkFyFGJZus+nf10Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S92fk1bwuExPil6HttzsY5HQJuEVfrKs0+HAk6j5d2VBOQ0eLiXnii8dgEVM0QupIMTPhB6Z6k4imMRBJDIJDyiYB0UwVboTImgfnjO1iPTY3fGvJlIYURz9aMUJhefSvHB/LIj0Bvxpdq14mk2Qa+cbCi1/aYfwqd5+QZwqyZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BZmKdjx8; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso5615ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731348540; x=1731953340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNEY19iZBbxXIaQg0/D9FwGzGfUYeqyG0tUI+MNK9Wg=;
        b=BZmKdjx8YR9IhBl2FK/cL9BC3ZklfpFXADrLGwviPMB0LvjUzwoLKNfJw8yC8AuLI8
         FykniceMuGccqOWLR9tKrrnyoK+Pl97f2Rq0E0Gs3+IwnComTU7/mu2SwDcf19fPKWs3
         sf3VRBc4WUDbhGE6cKhz1vanKm+IU0whQ6nRNVJv3vgsoUlbkjMs5hDPEz9B+H9mULTr
         2gEfgidJwocuwgrHDMcKxQ73jdqhUX2qHumKAmfxEKZzzXBphzTpDdEUj03aLloj64Ds
         Eu8EmKVp7BJX1G87dH7a8NhgYVbtFwvoxV2QRGynBaFIbvEEYIQqSDEzv9YZIN0YY9ms
         AsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731348540; x=1731953340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNEY19iZBbxXIaQg0/D9FwGzGfUYeqyG0tUI+MNK9Wg=;
        b=nWkiNgH9UoTObIv/0xG1MaIULWyypfhLa7+83lQRmQkErBbhPHT4KDYLxmqe8c5sgG
         VlaU3QRHBA1wc/O16+mtHeq7fJZVjamkWELoFI81aQR3r8gFKbutNXka4JsUwXQDw1yN
         EqYT+B1n9hk7ewg64q31pMU1hN7aUFE1Ii6Y+v+NcTJJkd+Y92PLftudmrsqBxVQ6Aym
         4CnBUCimzK2L4IHwC0k0S6FcpAy7cdI/YuBYirZJOlGs98EUa5YfzXND8ouMBtvI2VTi
         GoXnU67eW1A1DUdDJ3o7GsvbtrkJzw4xnqmkoDSxWcyr2MNNaEEI+qm+eRyW2lAkIAAy
         XfGw==
X-Forwarded-Encrypted: i=1; AJvYcCUXAyxFe/ROleBdzX+HYNADUreYii0mFn2EeFykBIITHFun7cr5MeqDtOC7trw0pnJqqmHzvGV+Sbg2bnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW/3eWjOzCJ8Ntgf7zVOVZxgq0fKttpKdRFNp5PjV1ZbOxwKzn
	W6PKxBK0cIgUdPduNF0iXcjUePb4u88/weLJ+hFplALHaTYTmWnnTsCWhsgsTISUmfN5X4TBbaU
	ntiVa4t2Vm9rOrTzIDXQ9lRC2XOo91h3uNwme
X-Gm-Gg: ASbGncs+cdk943ZTO8awFGDGn0w9KtwBiMel02Kv1nAPUmdxUMjzRDZSef3O/gt+Z9O
	n6bz1EivA4wCsyQ9fcNwo3fWOimqKIUOIZ+8fSo1q6AJfqWwNP2RYD+aPPhk1dPk=
X-Google-Smtp-Source: AGHT+IFZSuPj8LxNceeOupyoW1iZI+pgjz4ngu2gLWcKj6u7BRiLDzpA7XauiYmwCFssZXSk3yomoxCQBEdATWpjOZY=
X-Received: by 2002:a05:6e02:1ca7:b0:39b:b1f:5be1 with SMTP id
 e9e14a558f8ab-3a6f94ebbbamr8889475ab.1.1731348539752; Mon, 11 Nov 2024
 10:08:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com> <20241108204137.2444151-11-howardchu95@gmail.com>
In-Reply-To: <20241108204137.2444151-11-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 10:08:48 -0800
Message-ID: <CAP-5=fUnV_vkHGgQuK0M-oLOf2+DmZOBH=WtOddPmviB-+tuSw@mail.gmail.com>
Subject: Re: [PATCH v7 10/10] perf test: Add direct off-cpu test
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:42=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Why is there a --off-cpu-thresh 2000000?
>
> We collect an off-cpu period __ONLY ONCE__, either in direct sample form,
> or in accumulated form (in BPF stack trace map). If I don't add
> --off-cpu-thresh 200000, the sample in the original test goes into the
> ring buffer instead of the BPF stack trace map. Additionally, when using
> -e dummy, the ring buffer is not open, causing us to lose a sample.

Lgtm, could we move some of this commit message into a comment in the
code. Often refactoring will move things around making hunting for
appropriate comments like this a challenge.

Thanks,
Ian

> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/tests/builtin-test.c         |  1 +
>  tools/perf/tests/shell/record_offcpu.sh | 31 ++++++++++++++++++++++++-
>  tools/perf/tests/tests.h                |  1 +
>  tools/perf/tests/workloads/Build        |  1 +
>  tools/perf/tests/workloads/offcpu.c     | 16 +++++++++++++
>  5 files changed, 49 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/tests/workloads/offcpu.c
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index d2cabaa8ad92..2228e6064d16 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -145,6 +145,7 @@ static struct test_workload *workloads[] =3D {
>         &workload__brstack,
>         &workload__datasym,
>         &workload__landlock,
> +       &workload__offcpu,
>  };
>
>  #define workloads__for_each(workload) \
> diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/s=
hell/record_offcpu.sh
> index 678947fe69ee..fda1c1ad4555 100755
> --- a/tools/perf/tests/shell/record_offcpu.sh
> +++ b/tools/perf/tests/shell/record_offcpu.sh
> @@ -6,6 +6,10 @@ set -e
>
>  err=3D0
>  perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +TEST_PROGRAM=3D"perf test -w offcpu"
> +
> +ts=3D$(printf "%u" $((~0 << 32))) # OFF_CPU_TIMESTAMP
> +dummy_timestamp=3D${ts%???} # remove the last 3 digits to match perf scr=
ipt
>
>  cleanup() {
>    rm -f ${perfdata}
> @@ -39,7 +43,7 @@ test_offcpu_priv() {
>  test_offcpu_basic() {
>    echo "Basic off-cpu test"
>
> -  if ! perf record --off-cpu -e dummy -o ${perfdata} sleep 1 2> /dev/nul=
l
> +  if ! perf record --off-cpu --off-cpu-thresh 2000000 -e dummy -o ${perf=
data} sleep 1 2> /dev/null
>    then
>      echo "Basic off-cpu test [Failed record]"
>      err=3D1
> @@ -88,6 +92,27 @@ test_offcpu_child() {
>    echo "Child task off-cpu test [Success]"
>  }
>
> +test_offcpu_direct() {
> +  echo "Direct off-cpu test"
> +
> +  # dump off-cpu samples for task blocked for more than 1.999999s
> +  # -D for initial delay, to enable evlist
> +  if ! perf record -e dummy -D 500 --off-cpu --off-cpu-thresh 1999999 -o=
 ${perfdata} ${TEST_PROGRAM} 2> /dev/null
> +  then
> +    echo "Direct off-cpu test [Failed record]"
> +    err=3D1
> +    return
> +  fi
> +  # Direct sample's timestamp should be lower than the dummy_timestamp o=
f the at-the-end sample.
> +  if ! perf script -i ${perfdata} -F time,period | sed "s/[\.:]//g" | \
> +       awk "{ if (\$1 < ${dummy_timestamp} && \$2 > 1999999999) exit 0; =
else exit 1; }"
> +  then
> +    echo "Direct off-cpu test [Failed missing direct sample]"
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
> index af284dd47e5c..58de36e0edc5 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -216,6 +216,7 @@ DECLARE_WORKLOAD(sqrtloop);
>  DECLARE_WORKLOAD(brstack);
>  DECLARE_WORKLOAD(datasym);
>  DECLARE_WORKLOAD(landlock);
> +DECLARE_WORKLOAD(offcpu);
>
>  extern const char *dso_to_test;
>  extern const char *test_objdump_path;
> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workload=
s/Build
> index 5af17206f04d..0e78fd01eaf1 100644
> --- a/tools/perf/tests/workloads/Build
> +++ b/tools/perf/tests/workloads/Build
> @@ -7,6 +7,7 @@ perf-test-y +=3D sqrtloop.o
>  perf-test-y +=3D brstack.o
>  perf-test-y +=3D datasym.o
>  perf-test-y +=3D landlock.o
> +perf-test-y +=3D offcpu.o
>
>  CFLAGS_sqrtloop.o         =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_leafloop.o         =3D -g -O0 -fno-inline -fno-omit-frame-pointer=
 -U_FORTIFY_SOURCE
> diff --git a/tools/perf/tests/workloads/offcpu.c b/tools/perf/tests/workl=
oads/offcpu.c
> new file mode 100644
> index 000000000000..57cee201a4c3
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
> +       /* get past the initial delay */
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
> 2.43.0
>

