Return-Path: <linux-kernel+bounces-413619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4D89D1C09
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 00:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5BF28188F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE5F1E7C0A;
	Mon, 18 Nov 2024 23:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NOfPtLdL"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C54C19754D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 23:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731973790; cv=none; b=IDlJGUEBeIzs9EqSnJ0rgJ+j8tOyJCLnHHxObYy4SUPJh6MVTdoloIArOEmgH/8cJrPaCK6le9FThN3m5JjhtjY8aEkU4OFwpGkw31O60eD+PzXkQZ/wfIhY0ObnIIbXBie7LK3NEnPXSv3/FD/BhqqrxwZYapBEI1MuOWfLR8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731973790; c=relaxed/simple;
	bh=5KhDUPPzU93GbFnSsCpuzV6Iz+SPNky6RTbpDz23aII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5mcluqqZqZD9dvU/UF54fh/efeHmqoFDu9rZRJ7ngoWPZt0p2TyDim8EYpF1ZbBLrAJVLv66fHUMbcljpCc8ttk7vIdrg6sw0N3euNmyVVZfOgQp/HAhAiLXLYvpeZOJyc5Mp/47etKr+o4N33zxXbrcXcBIq+wrDfVM5lXvko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NOfPtLdL; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4608dddaa35so128261cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731973787; x=1732578587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lK6bzE8aI/V2pC6nlWjgg4fvEcS2VY0hiKfSVmi168k=;
        b=NOfPtLdL/BaN6W7Z3TmBfuuHoIgeEsK1ByyQWo1odZjjk+vESJarwAWezxkNua8xlZ
         5YRZyYF7eKGMUCh0/6pAIbpEIIBs4uEgii460SAxYkm7t505SIJN1VXhTydrSBZT2D3i
         le7O+yV/kF5GPzYgesA8/Jq++nKcZQnkVXlq5UjSTF5rn/m6fWz/IH0hnz+AGcm0yFzO
         smFSRPhd26MxpE8DVSq8pyqPAgSIG6CpGCFhlzkpLz9QHhv/lo79l0KCydTHm/NRg3F9
         mtCXTvQmqTqSPAQtIIsMuAvwJQrqLJ9zOkcUQY8xG2BwN0axAp4EGzZxZFCGvAG6oGwA
         deuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731973787; x=1732578587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lK6bzE8aI/V2pC6nlWjgg4fvEcS2VY0hiKfSVmi168k=;
        b=K2bCPULpuwWe3qw7fWPWLaXHiiVaCUy4XwLN1m0sCTFiVOTAyx6iS6cahcDJ131Ycw
         Hz4uXYMxUvTzKCpT7r6KBHirLX6pj7oT+y5yYigiOh6adyRgI+GTLlcQQ+5QfzcZmcIr
         7RUtHk0NbieqRSmjTsyL1/DiHHOwy2hAnb6BO6kRLwKgHVZ4If8BckKUfEfoFohWJkGF
         blew2I2OiFbUUc4h7kDkh+7B/cX0ytUpn4QSi978fRFLAnkRT7TxU39zhIJai/1jLT4G
         qDTNXFFPI0/lcXtgzJWJ5b8UkD0NOf4Ug1sb6FMGIustgUQxnq7JYMGifw6rKy35cveo
         O3cg==
X-Forwarded-Encrypted: i=1; AJvYcCXsOjXfHqdIXXT3poStFxJuzqHUNUqjRZyJBUhICsBFR4vtl6xgTePW9vfA67W0nGvF9Jn7qz0F1eCrPxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsjHmkfoDLSfsUfWa2WvQPv4hBC1ribjunGiDfvWUTnchy54gD
	V71TK2miCPSsiLRHmfj0u1krhNo5qMeatFynAffaXoz3eW876OILEwFLXdLSu+aOM8EGPCibeMM
	cZe9e5b1a1S2bXMDajcjqSBsZoVhj1zEpuG93
X-Gm-Gg: ASbGncuUZrYXpxw8YFAqzDdtvWhpMjRRjiyEA8RT3rsFoHqp25USi3dwzBEEjEfJGEg
	+rhv/anjDlU0x3CyAEzAZ6YHK0RIzQ4TCMF33HL+l/GO3U+x3cFqPEqgJtXDlAw==
X-Google-Smtp-Source: AGHT+IFZwt76OGyj44JQnW6JI/5s2J93C6DIK6J7wzakmW8yqQSea3vMGSHEwAzZUnUOrt5xqan1wN37RWPJqIC6h2Q=
X-Received: by 2002:ac8:59d0:0:b0:460:463d:78dd with SMTP id
 d75a77b69052e-463937a8f55mr1170181cf.4.1731973787136; Mon, 18 Nov 2024
 15:49:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118222540.27495-1-yabinc@google.com>
In-Reply-To: <20241118222540.27495-1-yabinc@google.com>
From: Rong Xu <xur@google.com>
Date: Mon, 18 Nov 2024 15:49:35 -0800
Message-ID: <CAF1bQ=SwtGDpOJeQwhbnO6Md=kFbcmkM4iVgXUgjzNXu+d8cEA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: Allow CONFIG_AUTOFDO_CLANG to be selected
To: Yabin Cui <yabinc@google.com>
Cc: Han Shen <shenhan@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch looks good to me.

I assume the profile format change in the Android doc will be submitted soo=
n.
Since "extbinary" is a superset of "binary", using the "extbinary"
format profile
in Android shouldn't cause any compatibility issues.

Reviewed-by: Rong Xu <xur.google.com>

-Rong

On Mon, Nov 18, 2024 at 2:25=E2=80=AFPM Yabin Cui <yabinc@google.com> wrote=
:
>
> Select ARCH_SUPPORTS_AUTOFDO_CLANG to allow AUTOFDO_CLANG to be
> selected.
>
> On ARM64, ETM traces can be recorded and converted to AutoFDO profiles.
> Experiments on Android show 4% improvement in cold app startup time
> and 13% improvement in binder benchmarks.
>
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>
> Change-Logs in V2:
>
> 1. Use "For ARM platforms with ETM trace" in autofdo.rst.
> 2. Create an issue and a change to use extbinary format in instructions:
>    https://github.com/Linaro/OpenCSD/issues/65
>    https://android-review.googlesource.com/c/platform/system/extras/+/336=
2107
>
>  Documentation/dev-tools/autofdo.rst | 18 +++++++++++++++++-
>  arch/arm64/Kconfig                  |  1 +
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/autofdo.rst b/Documentation/dev-tool=
s/autofdo.rst
> index 1f0a451e9ccd..a890e84a2fdd 100644
> --- a/Documentation/dev-tools/autofdo.rst
> +++ b/Documentation/dev-tools/autofdo.rst
> @@ -55,7 +55,7 @@ process consists of the following steps:
>     workload to gather execution frequency data. This data is
>     collected using hardware sampling, via perf. AutoFDO is most
>     effective on platforms supporting advanced PMU features like
> -   LBR on Intel machines.
> +   LBR on Intel machines, ETM traces on ARM machines.
>
>  #. AutoFDO profile generation: Perf output file is converted to
>     the AutoFDO profile via offline tools.
> @@ -141,6 +141,22 @@ Here is an example workflow for AutoFDO kernel:
>
>        $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -a =
-N -b -c <count> -o <perf_file> -- <loadtest>
>
> +   - For ARM platforms with ETM trace:
> +
> +     Follow the instructions in the `Linaro OpenCSD document
> +     https://github.com/Linaro/OpenCSD/blob/master/decoder/tests/auto-fd=
o/autofdo.md`_
> +     to record ETM traces for AutoFDO::
> +
> +      $ perf record -e cs_etm/@tmc_etr0/k -a -o <etm_perf_file> -- <load=
test>
> +      $ perf inject -i <etm_perf_file> -o <perf_file> --itrace=3Di500009=
il
> +
> +     For ARM platforms running Android, follow the instructions in the
> +     `Android simpleperf document
> +     <https://android.googlesource.com/platform/system/extras/+/main/sim=
pleperf/doc/collect_etm_data_for_autofdo.md>`_
> +     to record ETM traces for AutoFDO::
> +
> +      $ simpleperf record -e cs-etm:k -a -o <perf_file> -- <loadtest>
> +
>  4) (Optional) Download the raw perf file to the host machine.
>
>  5) To generate an AutoFDO profile, two offline tools are available:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fd9df6dcc593..c3814df5e391 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -103,6 +103,7 @@ config ARM64
>         select ARCH_SUPPORTS_PER_VMA_LOCK
>         select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
>         select ARCH_SUPPORTS_RT
> +       select ARCH_SUPPORTS_AUTOFDO_CLANG
>         select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>         select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
>         select ARCH_WANT_DEFAULT_BPF_JIT
> --
> 2.47.0.338.g60cca15819-goog
>

