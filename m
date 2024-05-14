Return-Path: <linux-kernel+bounces-178874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C418C58EE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA35F1F22C89
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1634A17F377;
	Tue, 14 May 2024 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tb859D3h"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E042817F36F
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701174; cv=none; b=gLtid+DI4eQmqVhiQ5N0/WesPJENLTkBO0kuMTyj1I6dY8G2Q8YYjdhg9ZFbJk6i9kd/boXZxcfMa7x6zVB1jgxuXCd7DRHFSJzdaU5WyuTZw7PeM3NAuC2UsWoSHDBhV5sCTD4qPd27pfMSc3t8bTR3Jfm5Hvjw58efb3i5PgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701174; c=relaxed/simple;
	bh=wPQNzP+a91MdWa0iSqIQy+ouXi9GvhZ2QK7RwkKxXjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=RU+OC4rDUwJKQFnJRib7KygKB12p9VEAPVii/ZK/MggbXp5nNWr4fv6xm5f7XbRX7e2nJlZNFdQ/Uzsm9beIj/Oa5PmNNRH5+dU0n6KNwQ4yp9EmKCwxA0sCYf8lmRVZeHioNkxEe93GoN5QpsnjTV5aar1YZUxMqStRw2q5Oeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tb859D3h; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43df9ac3ebcso1393411cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715701172; x=1716305972; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMCjVuovCRRhsqJzS9OSQQK8JqKttyF9yzBankV6qIQ=;
        b=tb859D3hPAsQabIEeAmjrE0A+xpNNSpjhtnfvoGYoeGhZoXFkEwKRdTWGjRnvbINCV
         qG90Ocr1bBBNzbJGtF9/nWt699Z7WVcS10PnlNcJVNcNUnse93kieyyoSYjhxy8AzJaI
         6yxIffTe/6zTvPi82p5P4TmEhmw2U4/RrNS/0lRBqafuBzwMQ2gKzxgLdDsxhbUmXK5+
         EExW5wZl1xss6Iu9bWBpxqLn2IXOpts9Cn2UJJkUzLVBNiUDAIqHs7/y9YNT7/GxFdZu
         T08nrkiz6mcCwjR1/37M2H82ZLjc7O+K5kp7yeb+UBM9/vl7zvvk1lEtrVSBj2pNjHgH
         9ACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715701172; x=1716305972;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMCjVuovCRRhsqJzS9OSQQK8JqKttyF9yzBankV6qIQ=;
        b=imtJbzb9NXMH3FG119sBVa6aJqeZ6fDd5tSE+I50sSDOczNEAhBOi/tur7HMbmKdS0
         JGznX8k/aV6FuLOn+PKtH1cPc+GdtkbNOHQhoaXorSVyEfm8yisabmUsNSjwLhxW7KRv
         lk0kneRsWO9hq8wcx53pBdeZIJSnCuSKyk4EhvV0g+Rd701cU4+9rxYu+RI6yvGXh1EB
         prydsSAhZZscedhb14BiUJ3PD0VVwlpGhvmCUc80hJrTCDj+CWz2IYI/RBBlX5/Ca99R
         dHK04Qqjhibvu+pnxT8hpVuIcUZqrqiao+T8s+RrAsR+vLk/05tsQNdYtrN8QVfnlWdF
         JomQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbhCHn3uwVS4GHAolYnD+gHIpyvTPFrSJqmqKcPRN1jRrPJHqTQj89gXwdjKVwPCcQGkUKPaseW9MtHbbrPmO51GVRKPYYiYqI2f/Z
X-Gm-Message-State: AOJu0Yx1mOXbg0bus3vs5HHXyKFpENGGBxM9bIGnB9xnlWr/yGb8xMjR
	ffdApa1cL91vcQh3NMGL8qRONvm6f/ui/5UoaZ/iW76EQ9CI2tRCuNtKFg2SGfwXl4VCEmWcd0m
	eqFQpsWhR1UR0/iP6mqTnbn5Km1tr0uJjllUD
X-Google-Smtp-Source: AGHT+IGRiHrKQBjng6lRxwDWXwXv+NiWgwfQUej3AihZUjdkQkMx6PO1ulTbHW8n5o8KChINFcUfX6NEuDYWxi5Z6nc=
X-Received: by 2002:a05:622a:1e0b:b0:43a:e258:8fed with SMTP id
 d75a77b69052e-43e095453ffmr7359681cf.18.1715701171651; Tue, 14 May 2024
 08:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514052402.3031871-1-irogers@google.com>
In-Reply-To: <20240514052402.3031871-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 14 May 2024 08:39:20 -0700
Message-ID: <CAP-5=fUc8zFup-87JjDfX38GoRpPdPwTdtfsxPqKmqJr1aHWGw@mail.gmail.com>
Subject: Re: [PATCH v1] perf arm-spe: Unaligned pointer work around
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linux.dev>, 
	James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 10:24=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Use get_unaligned_leXX instead of leXX_to_cpu to handle unaligned
> pointers. Such pointers occur with libFuzzer testing.
>
> A similar change for intel-pt was done in:
> https://lore.kernel.org/r/20231005190451.175568-6-adrian.hunter@intel.com
>
> Signed-off-by: Ian Rogers <irogers@google.com>

+Leo Yan +James Clark surprisingly missed by get_maintainer.pl.

Thanks,
Ian

> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 23 ++++---------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
>
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tool=
s/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index a454c6737563..7bf607d0f6d8 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -10,24 +10,11 @@
>  #include <byteswap.h>
>  #include <linux/bitops.h>
>  #include <stdarg.h>
> +#include <linux/kernel.h>
> +#include <asm-generic/unaligned.h>
>
>  #include "arm-spe-pkt-decoder.h"
>
> -#if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> -#define le16_to_cpu bswap_16
> -#define le32_to_cpu bswap_32
> -#define le64_to_cpu bswap_64
> -#define memcpy_le64(d, s, n) do { \
> -       memcpy((d), (s), (n));    \
> -       *(d) =3D le64_to_cpu(*(d)); \
> -} while (0)
> -#else
> -#define le16_to_cpu
> -#define le32_to_cpu
> -#define le64_to_cpu
> -#define memcpy_le64 memcpy
> -#endif
> -
>  static const char * const arm_spe_packet_name[] =3D {
>         [ARM_SPE_PAD]           =3D "PAD",
>         [ARM_SPE_END]           =3D "END",
> @@ -70,9 +57,9 @@ static int arm_spe_get_payload(const unsigned char *buf=
, size_t len,
>
>         switch (payload_len) {
>         case 1: packet->payload =3D *(uint8_t *)buf; break;
> -       case 2: packet->payload =3D le16_to_cpu(*(uint16_t *)buf); break;
> -       case 4: packet->payload =3D le32_to_cpu(*(uint32_t *)buf); break;
> -       case 8: packet->payload =3D le64_to_cpu(*(uint64_t *)buf); break;
> +       case 2: packet->payload =3D get_unaligned_le16(buf); break;
> +       case 4: packet->payload =3D get_unaligned_le32(buf); break;
> +       case 8: packet->payload =3D get_unaligned_le64(buf); break;
>         default: return ARM_SPE_BAD_PACKET;
>         }
>
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>

