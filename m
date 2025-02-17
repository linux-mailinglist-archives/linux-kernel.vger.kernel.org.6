Return-Path: <linux-kernel+bounces-515585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF6DA3667D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8863F3B2CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13721C84C6;
	Fri, 14 Feb 2025 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dLdjlEyy"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5E51C84B7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562657; cv=none; b=ismm94x8aTFDID2aYXPk3mnYN8ZDvELz3mLUtC4jcp9ZaUuXDwFTTYtp8MT0wj23aCvxqunQBW+UKGvbc7/YIGDRW9Tnp2+YR6MGZmXgokzSwLLkfB0llW1jJRggKBhWhzrniXpi9yGnhHPUSpaSxg7bQGe1YHbHLWjvw0pHyCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562657; c=relaxed/simple;
	bh=DwUTVYnjC40TrkHdh/Mi0mheTlk/nJ8tixLZFXZJOv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+U3QY8Vl8mRKRv4RW23dvF1rckkYayxVmkQr5qFnRfgAZLnm3dG/nDAb7m7weTFfPbdlWMcOYxFeBgFbEXSzNou2FyeWydCNQ3xW8vUA/Vn20tcnHooL3MKUiIC++3n8gNEYD985Ld2Z4DAUpTNap3Z8+k4YTaRJ7GmxVhBbeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dLdjlEyy; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d147331fb5so24055ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739562654; x=1740167454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMGxgVjqnFXecO8jpntKOUuSRl25sDscdmjbdyKJKwI=;
        b=dLdjlEyyWcozLOAd78m5Y61YdqSF1pvf0ywteyakgOTlgH5ijApT/nCIHo75rSamhj
         nR2zpfLdQqxPL3wEwFESq139/cmN74OgsavAZUvIMdtLl9Y4XoQBLaaK7/f+MjUHAZfQ
         qT07JMUG5YTlCGhaCRm+RHP2IM3vnU6MC8egKeJdPa5LdSjJ8LOemkct+WRxm9fTln4b
         7cfhBcvTyuGHZaBfTzQf6Z90Pqx3YAbG4AUoO+EchQ6o4C6YwiY6IrD0AlQqQbZps9Dv
         hu4QzrCZopE2q9OHVW8uuTMlA07L5vr9xtkbSIOczqf/yQC+2hIxAwuibVmSNJZv7jED
         +sVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739562654; x=1740167454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMGxgVjqnFXecO8jpntKOUuSRl25sDscdmjbdyKJKwI=;
        b=tsQnnA+FbVjWcMHy3wlhjSKnf7MhXMbLlyY3h6drid/tCLENIvJug/uvsC89i09iM9
         LwLHqYxaBSyuNVe3oYv+Ns84oSSQC9HUwj5lIrqOC+4AQ3cObHjvLqYSUFndOCFCkKY0
         cvvTp9UllL4VoLWiDuSoNXlYEP9VIPGTIaknJ4wjftcGz3rxiGpm137eOwWvIFlakfOD
         Lt/R6N76UaW2MyAG4P8d9/tPOaNuSk8U4O5Gyywx4PRt4XL7NBFXe7f38rnnSQGya7Uh
         ph2AGckSyparN11wxhF48jSOFRwAvLPotovwoXA+nCPHos42lYR33yFvXMplY+kiLdTy
         TDng==
X-Forwarded-Encrypted: i=1; AJvYcCWJ4+AmCZ00H6lKwTIcLdQpeddvjHLz+yBVY4ARvVofEHN5XRHDM3dATiIFn3Hdw9Y3pVUGK7bz27oErVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Aw1miirFMvGfKiR5FKSCLrYwTEIedH5NoeGf8T4XA30c62mD
	7RuSR3vy+5P+mBE9FpRZdQbKpgASB/wGcwxVPa/ZKlbmU9aXlUqDgcnP9xNiT03CMtksNe6t6Zc
	uNuUqhnw07kEubBx0EAdVusb1iBMzdIl811ue
X-Gm-Gg: ASbGncshkgZJ6AqMiUrCPvq74wQ/z9KUjBs2MtXrXOKAGOftO9LHDCKutgMflqGnZoC
	fHCPFKSu2gf7TfPqrosRwxCeIHYtt64skUwsAWlxhYssb1M8VxRWDZOvFKtj86kMLcWlT1vfXrA
	==
X-Google-Smtp-Source: AGHT+IGVwXuZ0BprBpcC1fxl06B1UuMEnsbrR+Md4UA5nLoDgtlNhsFIMoLeIwc16v+dQcXnDPBOaNZh1RAivzk5BHw=
X-Received: by 2002:a92:cd87:0:b0:3d1:8a3d:ea90 with SMTP id
 e9e14a558f8ab-3d2826ec471mr264115ab.19.1739562654297; Fri, 14 Feb 2025
 11:50:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214191641.756664-1-namhyung@kernel.org>
In-Reply-To: <20250214191641.756664-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Feb 2025 11:50:42 -0800
X-Gm-Features: AWEUYZn46iatFnw4K7GkgJuonnk6iTL5o9ilSnWJZg5y1qa5zgD09rSp5sMfLIM
Message-ID: <CAP-5=fXnx_kzUjVwA7cm-JwpqRDevaj59UdTbKnLOjbNx_OUNQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf tools: Fix compile error on sample->user_regs
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 11:16=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> It's recently changed to allocate dynamically but misses to update some
> arch-dependent codes to use perf_sample__user_regs().
>
> Fixes: dc6d2bc2d893a878 ("perf sample: Make user_regs and intr_regs optio=
nal")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Thanks for this! My tag in case it is useful:
Reviewed-by: Ian Rogers <irogers@google.com>

Would be nice to have asan testing to make sure there are arch
dependent memory leaks, less arch code would be nice.

Thanks,
Ian

> ---
> v2) fix arm (32-bit) as well
>
>  tools/perf/arch/arm/tests/dwarf-unwind.c      | 2 +-
>  tools/perf/arch/arm/util/unwind-libdw.c       | 2 +-
>  tools/perf/arch/csky/util/unwind-libdw.c      | 2 +-
>  tools/perf/arch/loongarch/util/unwind-libdw.c | 2 +-
>  tools/perf/arch/powerpc/tests/dwarf-unwind.c  | 2 +-
>  tools/perf/arch/powerpc/util/unwind-libdw.c   | 2 +-
>  tools/perf/arch/riscv/util/unwind-libdw.c     | 2 +-
>  tools/perf/arch/s390/util/unwind-libdw.c      | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/arch/arm/tests/dwarf-unwind.c b/tools/perf/arch/a=
rm/tests/dwarf-unwind.c
> index 9bc304cb7762b5d1..f421910e07097152 100644
> --- a/tools/perf/arch/arm/tests/dwarf-unwind.c
> +++ b/tools/perf/arch/arm/tests/dwarf-unwind.c
> @@ -45,7 +45,7 @@ static int sample_ustack(struct perf_sample *sample,
>  int test__arch_unwind_sample(struct perf_sample *sample,
>                              struct thread *thread)
>  {
> -       struct regs_dump *regs =3D &sample->user_regs;
> +       struct regs_dump *regs =3D perf_sample__user_regs(sample);
>         u64 *buf;
>
>         buf =3D calloc(1, sizeof(u64) * PERF_REGS_MAX);
> diff --git a/tools/perf/arch/arm/util/unwind-libdw.c b/tools/perf/arch/ar=
m/util/unwind-libdw.c
> index 4e02cef461e3af34..fbb643f224ec4b27 100644
> --- a/tools/perf/arch/arm/util/unwind-libdw.c
> +++ b/tools/perf/arch/arm/util/unwind-libdw.c
> @@ -8,7 +8,7 @@
>  bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
>  {
>         struct unwind_info *ui =3D arg;
> -       struct regs_dump *user_regs =3D &ui->sample->user_regs;
> +       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
>         Dwarf_Word dwarf_regs[PERF_REG_ARM_MAX];
>
>  #define REG(r) ({                                              \
> diff --git a/tools/perf/arch/csky/util/unwind-libdw.c b/tools/perf/arch/c=
sky/util/unwind-libdw.c
> index 79df4374ab18dc36..b20b1569783d7e98 100644
> --- a/tools/perf/arch/csky/util/unwind-libdw.c
> +++ b/tools/perf/arch/csky/util/unwind-libdw.c
> @@ -10,7 +10,7 @@
>  bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
>  {
>         struct unwind_info *ui =3D arg;
> -       struct regs_dump *user_regs =3D &ui->sample->user_regs;
> +       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
>         Dwarf_Word dwarf_regs[PERF_REG_CSKY_MAX];
>
>  #define REG(r) ({                                              \
> diff --git a/tools/perf/arch/loongarch/util/unwind-libdw.c b/tools/perf/a=
rch/loongarch/util/unwind-libdw.c
> index 7b3b9a4b21f8f482..60b1144bedd5f325 100644
> --- a/tools/perf/arch/loongarch/util/unwind-libdw.c
> +++ b/tools/perf/arch/loongarch/util/unwind-libdw.c
> @@ -10,7 +10,7 @@
>  bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
>  {
>         struct unwind_info *ui =3D arg;
> -       struct regs_dump *user_regs =3D &ui->sample->user_regs;
> +       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
>         Dwarf_Word dwarf_regs[PERF_REG_LOONGARCH_MAX];
>
>  #define REG(r) ({                                                      \
> diff --git a/tools/perf/arch/powerpc/tests/dwarf-unwind.c b/tools/perf/ar=
ch/powerpc/tests/dwarf-unwind.c
> index 5ecf82893b84d5c0..66af884baa660389 100644
> --- a/tools/perf/arch/powerpc/tests/dwarf-unwind.c
> +++ b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
> @@ -45,7 +45,7 @@ static int sample_ustack(struct perf_sample *sample,
>  int test__arch_unwind_sample(struct perf_sample *sample,
>                              struct thread *thread)
>  {
> -       struct regs_dump *regs =3D &sample->user_regs;
> +       struct regs_dump *regs =3D perf_sample__user_regs(sample);
>         u64 *buf;
>
>         buf =3D calloc(1, sizeof(u64) * PERF_REGS_MAX);
> diff --git a/tools/perf/arch/powerpc/util/unwind-libdw.c b/tools/perf/arc=
h/powerpc/util/unwind-libdw.c
> index e9a5a8bb67d9186e..82d0c28ae3459ecd 100644
> --- a/tools/perf/arch/powerpc/util/unwind-libdw.c
> +++ b/tools/perf/arch/powerpc/util/unwind-libdw.c
> @@ -16,7 +16,7 @@ static const int special_regs[3][2] =3D {
>  bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
>  {
>         struct unwind_info *ui =3D arg;
> -       struct regs_dump *user_regs =3D &ui->sample->user_regs;
> +       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
>         Dwarf_Word dwarf_regs[32], dwarf_nip;
>         size_t i;
>
> diff --git a/tools/perf/arch/riscv/util/unwind-libdw.c b/tools/perf/arch/=
riscv/util/unwind-libdw.c
> index 5c98010d8b59777f..dc1476e16321736d 100644
> --- a/tools/perf/arch/riscv/util/unwind-libdw.c
> +++ b/tools/perf/arch/riscv/util/unwind-libdw.c
> @@ -10,7 +10,7 @@
>  bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
>  {
>         struct unwind_info *ui =3D arg;
> -       struct regs_dump *user_regs =3D &ui->sample->user_regs;
> +       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
>         Dwarf_Word dwarf_regs[32];
>
>  #define REG(r) ({                                              \
> diff --git a/tools/perf/arch/s390/util/unwind-libdw.c b/tools/perf/arch/s=
390/util/unwind-libdw.c
> index f50fb6dbb35c5dc6..c27c7a0d1076c890 100644
> --- a/tools/perf/arch/s390/util/unwind-libdw.c
> +++ b/tools/perf/arch/s390/util/unwind-libdw.c
> @@ -11,7 +11,7 @@
>  bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
>  {
>         struct unwind_info *ui =3D arg;
> -       struct regs_dump *user_regs =3D &ui->sample->user_regs;
> +       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
>         Dwarf_Word dwarf_regs[ARRAY_SIZE(s390_dwarf_regs)];
>
>  #define REG(r) ({                                              \
> --
> 2.48.1.601.g30ceb7b040-goog
>

