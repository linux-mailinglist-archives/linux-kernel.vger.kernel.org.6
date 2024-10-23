Return-Path: <linux-kernel+bounces-378895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5A89AD6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AF3284F3D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936C01F7087;
	Wed, 23 Oct 2024 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aqoBl4ab"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CFDE56A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729719661; cv=none; b=lxqHVM8w10sUyqYOUNZngSmzcAxS3g2ALKm21miWotrP8rkvqPi0qOM3TzHTMYD+99nnRbvD0muXLlzTt77NEi+K29t9V66mFu9VKJdNg1yjEIcD6ESNFVSqzoBVMWT0Zd280HBTcViiaRfl5HmAX8TzJq+0vVKyuY/Zam7LY8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729719661; c=relaxed/simple;
	bh=1uf8OIKKp+NdtE/pJfJZCgDe/L5ipzQNnNqRIsLrXZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lt/EjJajI1S8k4k9lHCU4kiVommNJZQXlMz4FCttNFwsfTquDBjvIh/eT5tPKOL2MRomftvKBiYNejl1DVbf6xP8005SBs2s3zCgl22bVydOJ/p+zsNSs/6Yor3263LU6m6F9oMxXU7TwGWgdlQFzFdix+9tUJ7kjGJ/6u/Kcqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aqoBl4ab; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4608dddaa35so36441cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729719658; x=1730324458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfvazoqlYCjqRkYx7l7QlbGhjN9SEp8GOHbwEYd68EI=;
        b=aqoBl4abMgcf+PEbRmyl9gi37e7pi0AOpPrsfj3OXH3KweP0Zh6Mh044z+oCn+Ivii
         6714UeENIL65BVlio3YwC4S4i/GS6gZGTR2tClpLqMrJ1PJCSh2maz02f8ag6cOQEEMv
         PtCEe3taG2sTRlsg9mRORoJyzFPSKf6c/PlDxDxKzhiMLqO6HfmJ+Dqdc59lsS2DeTdN
         a/80ITNvuyJQrp5IO5rkDVUseUnG4RvmVnLuB3eMi/YrTXKuGeHDjZstlU9rTs808EGd
         ZIi7pWnm76t558bk/eTopCHzAoFasZhK2RXbUkjSnqM/3wNEsioWDievVdmylZrdocyp
         OcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729719658; x=1730324458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfvazoqlYCjqRkYx7l7QlbGhjN9SEp8GOHbwEYd68EI=;
        b=KeGYK2Ujt4NxIJfUeThSLRwc47xW6zPhPbcfGGSe8R9+T6UXY2717SNIgiDyO2lcDv
         Jja/oGrgINR4xc9TMnY3Eh3gXqHjpk3dV1R9VzXjE+dOAn4EeXnieWTcSZoo1F5mZZdT
         SCQkd1syaJTVxQ54tJSfUBVHB+KbxUUPjND/k6qJj03ry5ZybBw8RzJ2tvZgAU9TgcY8
         mu9VBu+TruwwnsL1vZBgfdZYhu5Qy2eDus7GomOMTqnI/ELAnXwcPks+z+UxJThlva/v
         5+7NP8L0xEaEieI2SHWY3J95lmzmFUJOwVND5DjKLgxeSG/j2/v039laWCsTjw2j6QJA
         wdWw==
X-Forwarded-Encrypted: i=1; AJvYcCXTiYpDSr8OU98JTKD3iw2qsAa+5nUlXTd0rwEQ4MA1+HZ6MEeOEsvDhgJ5FoQ6xEUz8ZoqN+WfOZh/EH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPazmN92znZFMmVBF4hUhV7wcKOX0TUHZ7xDQ0kavSOfqcxxpS
	TQCf9nmNXrEZUZ1/ZtibWTcMw+Fau0mjcuay5kVJsJavAr4EAGi3s+lJmCwey+t2krqd9j7Mc5p
	bWEFFK4Hy/+dNPrsxmiU1+t3KTlnScTe+wfk6
X-Google-Smtp-Source: AGHT+IGt5BrL0ynohwcQHFAarnxSHCFSAf9jK25+4hYiJBIoa94ycBS2i1HnMLE/a0ATqe+WrRn1kONilfmhu2zwb9Y=
X-Received: by 2002:ac8:7f8d:0:b0:460:4a47:fd83 with SMTP id
 d75a77b69052e-4612439f4a8mr196671cf.27.1729719657708; Wed, 23 Oct 2024
 14:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxllAtpmEw5fg9oy@x1>
In-Reply-To: <ZxllAtpmEw5fg9oy@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Oct 2024 14:40:45 -0700
Message-ID: <CAP-5=fUF1kfioGSgnXzPmadwKrd65mUpHPamPNt29ra9qZAzJw@mail.gmail.com>
Subject: Re: [PATCH 1/1 perf-tools] perf python: Fix up the build on
 architectures without HAVE_KVM_STAT_SUPPORT
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:05=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Noticed while building on a raspbian arm 32-bit system.
>
> There was also this other case, fixed by adding a missing util/stat.h
> with the prototypes:
>
>   /tmp/tmp.MbiSHoF3dj/perf-6.12.0-rc3/tools/perf/util/python.c:1396:6: er=
ror: no previous prototype for =E2=80=98perf_stat__set_no_csv_summary=E2=80=
=99 [-Werror=3Dmissing-prototypes]
>    1396 | void perf_stat__set_no_csv_summary(int set __maybe_unused)
>         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /tmp/tmp.MbiSHoF3dj/perf-6.12.0-rc3/tools/perf/util/python.c:1400:6: er=
ror: no previous prototype for =E2=80=98perf_stat__set_big_num=E2=80=99 [-W=
error=3Dmissing-prototypes]
>    1400 | void perf_stat__set_big_num(int set __maybe_unused)
>         |      ^~~~~~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors
>
> In other architectures this must be building due to some lucky indirect
> inclusion of that header.
>
> Fixes: 9dabf4003423c8d3 ("perf python: Switch module to linking libraries=
 from building source")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

So this will at least conflict with:
https://lore.kernel.org/lkml/20241022173015.437550-6-irogers@google.com/
where the #ifdef-ed out functions are removed. Does that series fix
the ARM32 issue? Could we land that?

Thanks,
Ian

> ---
>  tools/perf/util/python.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 31a223eaf8e65fa3..ee3d43a7ba4570f0 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -19,6 +19,7 @@
>  #include "util/bpf-filter.h"
>  #include "util/env.h"
>  #include "util/kvm-stat.h"
> +#include "util/stat.h"
>  #include "util/kwork.h"
>  #include "util/sample.h"
>  #include "util/lock-contention.h"
> @@ -1355,6 +1356,7 @@ PyMODINIT_FUNC PyInit_perf(void)
>
>  unsigned int scripting_max_stack =3D PERF_MAX_STACK_DEPTH;
>
> +#ifdef HAVE_KVM_STAT_SUPPORT
>  bool kvm_entry_event(struct evsel *evsel __maybe_unused)
>  {
>         return false;
> @@ -1384,6 +1386,7 @@ void exit_event_decode_key(struct perf_kvm_stat *kv=
m __maybe_unused,
>                            char *decode __maybe_unused)
>  {
>  }
> +#endif // HAVE_KVM_STAT_SUPPORT
>
>  int find_scripts(char **scripts_array  __maybe_unused, char **scripts_pa=
th_array  __maybe_unused,
>                 int num  __maybe_unused, int pathlen __maybe_unused)
> --
> 2.46.0
>

