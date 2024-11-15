Return-Path: <linux-kernel+bounces-410303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575F29CD9A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A67282BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EEC185924;
	Fri, 15 Nov 2024 07:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1Z5t6ZI"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BD61F95A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731654172; cv=none; b=eHRtal6FpLmR9axsuhFsWUsBAxjiLOVv/3Fs2HMC3Dk//iDU83/HYedZkiCFVeDK+xcQfob+nN178OheT5HYC1Re3/p5eF/QV4F+e13Eby4X5oLxm8UOxn1ugvgXqZUy5qHsl48UCMwk7BahG85O3O7MVdyWk6hkk874DZ6WrmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731654172; c=relaxed/simple;
	bh=ucRdI4zZiJOb3gsW2929kn/SeFGdDlj7BOd7CP512xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAwEAyFhXjXvrLTL45G3YgsWnRRbY29TScop58WBTBvXkrZxjrCcKXGRj6pv0yh87DCPXnPAME0j53fE2IykDdtT2TW5nv3wTUAEVzQGrw3xZAymtWW1rYX9shsAM/yKLPDVNcMhakxznj9RBOY+eqatSbyrfDEVwjD2MURjTk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M1Z5t6ZI; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4635b03a3cdso98981cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731654168; x=1732258968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdhHbTzTKc3SMetmKy+wNf6PkpzJgq0XFpQInOkKr7k=;
        b=M1Z5t6ZIW6ifi0pvQPdcVfskk3l+t2kp4zNiW2kuMcXKNisCxPG2lNgQaQKpIfBVKu
         z1qYUwHGTVcf0UXQwN2V/q0Zr2z7QHUOeiDHzSyw1Szp4Nu/mou7Ypl3xkV+IUNNHOH8
         9DXLEjBHQg+WYbOLmpjxcR8A8vkUIf4i/XZRcNyHktbF5niV8SomJzeD7Jwm91pNUVf2
         +ahKpHwv+eJjfSVClAQRClRkbUYfn5oQ6T8oePKcucQPxnljatlkyDcxLvVmTT+TX52u
         xbDyeUCrKu7d4NGIKJFqHQiWsSNz2ydXrZ1qmf3i6e/geVkX9Shj2HrBT1kcTw63HNn6
         DgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731654168; x=1732258968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdhHbTzTKc3SMetmKy+wNf6PkpzJgq0XFpQInOkKr7k=;
        b=cuHBvslaH7G/KJE5+G/9AY1BZTSkmpfx6uee2oXvf7Rh+6S+Eix/T/L0MMoKs7ecI4
         mTHyl2yJI/MUew5aw8xz1jECetFHTUPgkz9hmv5qrujKycoNA4xSXC+kNqd/J5MhDCc7
         IlWks9ts/rosIOU6ZM7JLxhf9plaNCJLMKiEl23ervjayI86yxYyVWOmYsjxX/PTZm9w
         2pOCa8g2qmVxm7MNNGKp64IrFgJcL9KxPdxse2WQvjKj5Qh/K+fqn/Z348XLahGeGO5h
         7wjkwzbhn4wSi4EX69YJEGEM2BCQNYVru+xBNJiom55IoHn4EsLwBZhMb89yTvVHvN+H
         WGmA==
X-Forwarded-Encrypted: i=1; AJvYcCWslu5huHSMn/giD56JILEBxHPhzT0g5FQHgH/gVpdBo3vC5mZ/iZOIeyWjtHP5Es/HqrEP0qs68n9RXs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoAiM0ttz/dNzNlQKVMXd/QZMZnnX7TS1Y4T7f8UBW9bXAC9ny
	87BFro4ajbMw/7WkjLJIVRS0dA+KgRgnRTfCfZh4MJ7u88ZFZBVnY5AVLMrjY0ymkWkolfwZ/Lv
	DC/WvcpEH22jVnLi/wxpspJLFtR/UqliYOfSj
X-Gm-Gg: ASbGncvg8lTCyox0lwi/i9vTzkbyKcoQkg1kPIJbXKcddvpolsaHjlb8nYhyVmhYnhi
	5DBnBa8cb+bK42t7QsVyBx/pqmkbtAg==
X-Google-Smtp-Source: AGHT+IEZQumBx9rAByuSeR05qYBdTIlqZ++eXdNrS2altRO43l1pCrcUxa66OFIF831o8TKPmzacL49GHPpAP9FS1l8=
X-Received: by 2002:a05:622a:47ce:b0:461:32e9:c5f1 with SMTP id
 d75a77b69052e-463637282c0mr2202191cf.10.1731654167227; Thu, 14 Nov 2024
 23:02:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115051107.3374417-1-yabinc@google.com>
In-Reply-To: <20241115051107.3374417-1-yabinc@google.com>
From: Rong Xu <xur@google.com>
Date: Thu, 14 Nov 2024 23:02:35 -0800
Message-ID: <CAF1bQ=R=481iZu1Zp8p42zvGd_oLrU-K9UHtSe9TbZUDkS8Qkw@mail.gmail.com>
Subject: Re: [PATCH] arm64: Allow CONFIG_AUTOFDO_CLANG to be selected
To: Yabin Cui <yabinc@google.com>
Cc: Han Shen <shenhan@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yabin,

Thanks for working to enable this on ARM64 and test the performance on Andr=
oid!
Please see my comments below.

Thanks,

-Rong

On Thu, Nov 14, 2024 at 9:11=E2=80=AFPM Yabin Cui <yabinc@google.com> wrote=
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
>  Documentation/dev-tools/autofdo.rst | 18 +++++++++++++++++-
>  arch/arm64/Kconfig                  |  1 +
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/autofdo.rst b/Documentation/dev-tool=
s/autofdo.rst
> index 1f0a451e9ccd..f0952e3e8490 100644
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
> +   - For ARM platforms:

The instructions for SPE might be different. Can we change to "- For
ARM platforms with ETM trace:"

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

The instructions in "Step 3: Convert ETM data to AutoFDO profile"
currently use create_llvm_prof to generate
 a "binary" profile format. This is incompatible with the default
FSAFDO format used for the kernel, which
 requires an "extbinary" format.

To correct this, please update the instructions to include the flag
"-format extbinary" in the
create_llvm_prof command.

Using a non-FSAFDO profile with FSAFDO can negatively impact performance.
Therefore, I recommend rerunning the test with the updated flag to
potentially achieve better results.

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

