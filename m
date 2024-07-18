Return-Path: <linux-kernel+bounces-256419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CC4934E24
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4951F23B52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED48913E88B;
	Thu, 18 Jul 2024 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7reQk0R"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B0F13E039
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309143; cv=none; b=JPptvORXPyra6bmmvJ9nV4RdBuQAlc/BtAL0ccBTgG0GmliKtD7Tq5Nsmij7oAW1vDK0U7VD0D+EMiOyWR1QDd5vgYXYeClJL57k+WrRWjlsPfYDNgEiZYaRDypLB9j50SByvxuGbtv8LoxqciTY/rx06EQWuEAYuSfhuHLGOUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309143; c=relaxed/simple;
	bh=7E9MLCxN2+UcJZmebDx3rYcx3CZhfBW8CLjhhNkWsL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MK+bM3OOnwTQSxNpyAtcGHMWKXrUUVZ7HaMYMzk03FaC8ADlGJVqPybuRsu+K8a8VN3uXzxXgFZ5y2tcgvqRNrY//2lY06zJCYji23yMy73fRNyfqfR281+kKso5rqPPUJNvV8w5D5rVeKE8TZNt2bAidoD+Bklc0A+XM60bCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h7reQk0R; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d93df6b54dso396712b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721309140; x=1721913940; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6u33BE/Zx9BQXUadkdADDVxjMkkZVQKQkWWACwS8Fdk=;
        b=h7reQk0Ru2RJAtemnEAQq8DXkMknQEQP/rwztoxLBS1/KGBL/1+7v5OqMQNDMC01Vc
         8Ubl8hvAZADAWs6NmKWdS7GmVNv0que8d5V/IWZTHKkVq4FMF/IeQ8p1DZAi68ghjYye
         qqSPmsDzkFpWsDQdo4qZQ6Cew58++rY2kyeVivlf6Hhh0BOPbFPCAj6UumFkPjtafqS9
         j80Muk6tOiFrgcVu+OIhp5PW8hLuaWl2TJseagPPXcSqZh2d6PD42ANYji+J2N17BB1Z
         FfXNnwKYXJwApNwcnIPBiRkimx/xN/YSvr8XMs6SKjsbBWy3a/tgKzjshxT5jzmhgH8R
         CbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721309140; x=1721913940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6u33BE/Zx9BQXUadkdADDVxjMkkZVQKQkWWACwS8Fdk=;
        b=tazA2hAKfXS+mZ8wu5EoprT4Ns1c7iBjszrIAa4KcKVAg18/GkWSmXVFbWnA36pRNw
         KfexDCKqN/xZ3+bVzDwgx7dDdlwHsicW1YYxKevcs5FYStg3D7yv336Ss2K7jMAq4UUJ
         UET+j99+IlsHr0/YFFHNxtCCgkJBERvMQq5NmUpNPy3R3Hzs8qUKgDPR49HU/JUhCF5M
         VH1N6/FuZe9ynIVIS1+X+yFUUVBdtXsLMLFz5OVULeJidkBpl/bRvhK5AuEl9CQ+Sy1m
         c9EPv5RrFbqkkCVwgw/MxsZpPn1+1BUSthj1mfj7cX6WQE14qlqPkmPvfyq5OtzB0Ha/
         H/qg==
X-Forwarded-Encrypted: i=1; AJvYcCXahOY1gofmkcPrW+XE3xb6ZSHtaXiyWF31soDQmW3mRk6mzoxTB5IO/kj03Ui+0aBkxPd8HZKJBi19go2U588QxGRozCl5EgvTzNvG
X-Gm-Message-State: AOJu0YwC3p82z4zUMLO8sMcZWgW8bk3Zz4VD22/3Y8vqnLcuMmge8Mjw
	AcxUnQ/TUHq2ad4zTJ1JZCtkteTfDQTurCy9ce2OEHR0Uw/5J+sCOtveauzyOUVIHxJM0UEmYtR
	pE5weCtKCQXp+QTG9PUC5Wfy0manZkqIQaaZkvg==
X-Google-Smtp-Source: AGHT+IGKC/ZsbnFgt4JyjJAfnoT/3Lb+kggEiogigNqLWPbn73aOYqG3+3JwCEvetKDXFvcd02w9i8v9M948PkzRZ2g=
X-Received: by 2002:a05:6871:293:b0:254:a57e:1aed with SMTP id
 586e51a60fabf-260d907c717mr4383695fac.26.1721309140544; Thu, 18 Jul 2024
 06:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712102029.3697965-1-james.clark@linaro.org> <20240712102029.3697965-9-james.clark@linaro.org>
In-Reply-To: <20240712102029.3697965-9-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 18 Jul 2024 14:25:29 +0100
Message-ID: <CAJ9a7ViLNtH+tHgxDTRQGO3m+kF-t8v_HB_-JuGiFwnS9UJZEQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/17] perf: cs-etm: Add runtime version check for OpenCSD
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com, 
	gankulkarni@os.amperecomputing.com, leo.yan@linux.dev, 
	anshuman.khandual@arm.com, James Clark <james.clark@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 11:22, James Clark <james.clark@linaro.org> wrote:
>
> From: James Clark <james.clark@arm.com>
>
> OpenCSD is dynamically linked so although there is a build time check,
> at runtime the user might still have the wrong version. To avoid hard
> to debug errors, add a runtime version check.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/build/feature/test-libopencsd.c               |  4 ++--
>  tools/perf/Makefile.config                          |  2 +-
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c     | 13 +++++++++++++
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h     |  1 +
>  tools/perf/util/cs-etm-decoder/cs-etm-min-version.h | 13 +++++++++++++
>  tools/perf/util/cs-etm.c                            |  3 +++
>  6 files changed, 33 insertions(+), 3 deletions(-)
>  create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-min-version.h
>
> diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
> index 4cfcef9da3e4..d092a0c662f4 100644
> --- a/tools/build/feature/test-libopencsd.c
> +++ b/tools/build/feature/test-libopencsd.c
> @@ -1,12 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <opencsd/c_api/opencsd_c_api.h>
> +#include "cs-etm-decoder/cs-etm-min-version.h"
>
>  /*
>   * Check OpenCSD library version is sufficient to provide required features
>   */
> -#define OCSD_MIN_VER ((1 << 16) | (2 << 8) | (1))
>  #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
> -#error "OpenCSD >= 1.2.1 is required"
> +#error "OpenCSD minimum version (OCSD_MIN_VER) not met."
>  #endif
>
>  int main(void)
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 7f1e016a9253..2d21be42820e 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -141,7 +141,7 @@ endif
>  ifdef CSLIBS
>    LIBOPENCSD_LDFLAGS := -L$(CSLIBS)
>  endif
> -FEATURE_CHECK_CFLAGS-libopencsd := $(LIBOPENCSD_CFLAGS)
> +FEATURE_CHECK_CFLAGS-libopencsd := $(LIBOPENCSD_CFLAGS) -I$(src-perf)/util
>  FEATURE_CHECK_LDFLAGS-libopencsd := $(LIBOPENCSD_LDFLAGS) $(OPENCSDLIBS)
>
>  # for linking with debug library, run like:
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index b78ef0262135..5e1b4503aab1 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -16,6 +16,7 @@
>
>  #include "cs-etm.h"
>  #include "cs-etm-decoder.h"
> +#include "cs-etm-min-version.h"
>  #include "debug.h"
>  #include "intlist.h"
>
> @@ -835,3 +836,15 @@ const char *cs_etm_decoder__get_name(struct cs_etm_decoder *decoder)
>  {
>         return decoder->decoder_name;
>  }
> +
> +int cs_etm_decoder__check_ver(void)
> +{
> +       if (ocsd_get_version() < OCSD_MIN_VER) {
> +               pr_err("OpenCSD >= %d.%d.%d is required\n", OCSD_MIN_MAJOR,
> +                                                           OCSD_MIN_MINOR,
> +                                                           OCSD_MIN_PATCH);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index 12c782fa6db2..2ec426ee16dc 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -107,5 +107,6 @@ int cs_etm_decoder__get_packet(struct cs_etm_packet_queue *packet_queue,
>
>  int cs_etm_decoder__reset(struct cs_etm_decoder *decoder);
>  const char *cs_etm_decoder__get_name(struct cs_etm_decoder *decoder);
> +int cs_etm_decoder__check_ver(void);
>
>  #endif /* INCLUDE__CS_ETM_DECODER_H__ */
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-min-version.h b/tools/perf/util/cs-etm-decoder/cs-etm-min-version.h
> new file mode 100644
> index 000000000000..c69597e9d0af
> --- /dev/null
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-min-version.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef INCLUDE__CS_ETM_MIN_VERSION_H__
> +#define INCLUDE__CS_ETM_MIN_VERSION_H__
> +
> +#define OCSD_MIN_MAJOR 1
> +#define OCSD_MIN_MINOR 2
> +#define OCSD_MIN_PATCH 1
> +
> +#define OCSD_MIN_VER ((OCSD_MIN_MAJOR << 16) | \
> +                     (OCSD_MIN_MINOR << 8) |  \
> +                     (OCSD_MIN_PATCH))
> +
> +#endif /* INCLUDE__CS_ETM_MIN_VERSION_H__ */
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 49fadf46f42b..2385d5ed5ea5 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -3369,6 +3369,9 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>         u64 *ptr = NULL;
>         u64 **metadata = NULL;
>
> +       if (cs_etm_decoder__check_ver())
> +               return -EINVAL;
> +
>         /* First the global part */
>         ptr = (u64 *) auxtrace_info->priv;
>         num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>
--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

