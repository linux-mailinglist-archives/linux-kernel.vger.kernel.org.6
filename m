Return-Path: <linux-kernel+bounces-535177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB664A46FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A6C16D9E1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4BD270045;
	Thu, 27 Feb 2025 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="f0GNYwN0"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454AECF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740614827; cv=none; b=RlV7gGGr2Ujhnt9b/ONa8Ljzjy/YxfZn/8DTM8EZ2bKs9K0J3JXhWK6dNd0NIGuhkKQCQaIhFbOW54Pcxod73fu/124SGwi3B3Amd80J4HIJgvWTT/aKnJSBUIcsZoT8wDVcVMsNpakTMC45sU9EPmZg0HCvVnjx/WjC1Ktaw+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740614827; c=relaxed/simple;
	bh=DkPeBtNqC/aRYA3ImpbvO0yl2A63EdTm7b+jLLWXvrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQaaufh0DGLXiDbmPae5b2cJmgkR+gwVEn1qaephwYNTnk9hzFw1jUvT19Fq0BTdSgYoxpoJGvOCnrMTOSJOc8wIuCP0D1k58VgdQ1GRBCytQFxTZfjYWrxGILq7VP+e2M9MvBvoa23Rc1L+pKYVs/OPxJsiEf/fPrSSJG3K2tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=f0GNYwN0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fc20e0f0ceso633379a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740614825; x=1741219625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nOMcPPI5c1jXJRM+8g52gTtzt6JEQOhHcXYY3HpyA0=;
        b=f0GNYwN03MwYAyNrLbuPJLRnVAXf/pJZcgh2BSUCuyCEDO2XnFYqZ3OwKvbq76I9pj
         XYrawbW40GiaS1YyEfn2cf8ubmFIuxoKxj1wllx1yjvFHiZAgY3qdLpYbpURU/hNt5iZ
         Nkass/0ciwtnSYrV/KLFrKucLfopoWBHyFIk+ZnCa3Z5p0STmziO3ZqDOFj6JziPYQNp
         S5tdEIkNzCO1wtDQlxDfN+3oBzhmWirbjqdEqpDrmq/PZrgO4dweHzldKvM/E5qDrO4L
         LXHuu7kictSP0IvxmQ/tOWQ/cx8rL3xaSAH+88kVivakjGaH9eG/3mTfYEPC+Jd31R8Q
         p6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740614825; x=1741219625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nOMcPPI5c1jXJRM+8g52gTtzt6JEQOhHcXYY3HpyA0=;
        b=sX+f+9N80DV5U1gKX9ImUKd2IvxClU6dMAoxp6zNlnIYkul8zNXSe8pfvSjeQN06ar
         QB5PiK+ba2nuPSQoGFr6sw6pZ8WGSy4hV5SZAauUjNUoSgZYhRF3vZPkUH/OxpTGCcAh
         wJcU1ax7tpRz4hY7oW8lIrn7UN11+hwg99dU3WAekRifewST4HnUHc8oDdA4DouEMoBW
         GkBDRtpa9qLoFVy7LNZR/b40mT4wNyk9LJVWSovKDQSEIk3/4N5mDYMCWP0pXC9dnyFB
         +Bgv3xkcmhn+7FbqRRNqkwiPZLGhJVdYi6l1lXSjz92TEU5X+UDqW8p7hblvW6R9dVIl
         qckQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrKabfN5DZXktmCWnjPmcqkQdHtvGK9/3Z67E9bWcVrk43VzxhWHdCu6eBHTK8iJIiBbzmknfDz3Aub6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmV/w5jk9ddDXNBTyLhtheagiXVwh2OCIzuknaFrmeF44NAmxv
	22LchRHvriiOB5KTmx0wyS05+WyOR+eDl5wR+C/SdDNUGRbyuwax4C7RCWkfBR51aiKxSgs4aef
	ByX1KkzVDEbYNIf9cg1scid6+IFtS8oF2zV7JrA==
X-Gm-Gg: ASbGnctMa+NPgpxGGvnK48VCvpTDtmpYnMJqFi+DixuypjXKRYyAwzEKCXZPhZ3QOJe
	kn8FlM117pHjfmg4JDcTxVUpYhUfvu0kdn/TmYxXScq+8EVAlpG01Aw/oagQSG+dFAEOl9gRlbc
	YmaghGDg==
X-Google-Smtp-Source: AGHT+IFU1bq8mMWQr/nfAv06hNruBT5LhpE0t240NRVcR7JAq7ma1dPyg4mvl61oVDhks/31ToFVQUQ4SS/zaz0yHCw=
X-Received: by 2002:a17:90b:5446:b0:2ee:c04a:4276 with SMTP id
 98e67ed59e1d1-2fe7e2fad73mr7598919a91.5.1740614825599; Wed, 26 Feb 2025
 16:07:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205-counter_delegation-v4-0-835cfa88e3b1@rivosinc.com>
 <20250205-counter_delegation-v4-9-835cfa88e3b1@rivosinc.com> <d03581a9-495d-47df-99f2-96065b06ee8f@rivosinc.com>
In-Reply-To: <d03581a9-495d-47df-99f2-96065b06ee8f@rivosinc.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Wed, 26 Feb 2025 16:06:54 -0800
X-Gm-Features: AQ5f1Jor6j_JB-qT3VHcFUngBC7pDF2lQ8l_4vLXmUWI5FABCG8w44W6HyNkHE4
Message-ID: <CAHBxVyFxX78+zf3NFvRZ8sE6PV83gkQ0ibHMTPY7kr8HNr8naQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/21] RISC-V: Add Ssccfg ISA extension definition and parsing
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, weilin.wang@intel.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 12:13=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
>
>
> On 06/02/2025 08:23, Atish Patra wrote:
> > Ssccfg (=E2=80=98Ss=E2=80=99 for Privileged architecture and Supervisor=
-level
> > extension, =E2=80=98ccfg=E2=80=99 for Counter Configuration) provides a=
ccess to
> > delegated counters and new supervisor-level state.
> >
> > This patch just enables the definitions and enable parsing.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/hwcap.h | 2 ++
> >  arch/riscv/kernel/cpufeature.c | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index b4eddcb57842..fa5e01bcb990 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -103,6 +103,8 @@
> >  #define RISCV_ISA_EXT_SSCSRIND               94
> >  #define RISCV_ISA_EXT_SMCSRIND               95
> >  #define RISCV_ISA_EXT_SMCNTRPMF         96
> > +#define RISCV_ISA_EXT_SSCCFG            97
> > +#define RISCV_ISA_EXT_SMCDELEG          98
> >
> >  #define RISCV_ISA_EXT_XLINUXENVCFG   127
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 8f225c9c3055..3cb208d4913e 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -390,12 +390,14 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =
=3D {
> >       __RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
> >       __RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
> >       __RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> > +     __RISCV_ISA_EXT_DATA(smcdeleg, RISCV_ISA_EXT_SMCDELEG),
>
> Hi Atish,
>
> based on your dt-binding commit, if smcdeleg depends on Sscsrind, Zihpm,
> Zicntr, then you could add a validation callback here:
>

Sure.

> static int riscv_smcdeleg_validate(const struct riscv_isa_ext_data
> *data, const unsigned long *isa_bitmap)
> {
>         if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_SSC=
SRIND) &&
>             __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZIH=
PM) &&
>             __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZIC=
NTR))
>                 return 0;
>
>         return -EPROBE_DEFER;
> }
>
> __RISCV_ISA_EXT_DATA_VALIDATE(smcdeleg, RISCV_ISA_EXT_SMCDELEG,
> riscv_smcdeleg_validate),
>
> >       __RISCV_ISA_EXT_DATA(smcntrpmf, RISCV_ISA_EXT_SMCNTRPMF),
> >       __RISCV_ISA_EXT_DATA(smcsrind, RISCV_ISA_EXT_SMCSRIND),
> >       __RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
> >       __RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinux=
envcfg_exts),
> >       __RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
> >       __RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> > +     __RISCV_ISA_EXT_DATA(ssccfg, RISCV_ISA_EXT_SSCCFG),
>
> Ditto for this one with Smcdeleg, Sscsrind, Zihpm, Zicntr, Sscofpmf,
> Smcntrpmf.
>

Smcdeleg is dependent on Sscofpmf/Smcntrpmf only for some of the registers.
For example, Sscofpmf dependancy is only for sireg2 (hpmevent3h-hpmevent31h=
)
while Smcntrpmf is only for cyclecfg/instretcfg[1].

So we can't include those for validation but I will include other
extensions which are always required.

[1] https://github.com/riscvarchive/riscv-smcdeleg-ssccfg/blob/main/body.ad=
oc
> Thanks,
>
> Cl=C3=A9ment
>
> >       __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> >       __RISCV_ISA_EXT_DATA(sscsrind, RISCV_ISA_EXT_SSCSRIND),
> >       __RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinux=
envcfg_exts),
> >
>

