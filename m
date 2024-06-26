Return-Path: <linux-kernel+bounces-231178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D78918774
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DEADB23DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E991891BA;
	Wed, 26 Jun 2024 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TfEjLyFO"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47DD18A929
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418740; cv=none; b=rxaP21P9oTIY0lTG2Nsi9BdY2dh9f1ULpLYAMdYboKi8SSXHyYuOOy4J+r6gTlpC0+0fXZaSDLvmhQ8ZwxwlP6S6B3QWpax4Ape5+ueUvNiSaL8K0d3kQCjbiG5oyNixdCFFkSSq+DlsVxQZN+XBzkMLSYCqMdep+2xUTkJVLzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418740; c=relaxed/simple;
	bh=n6XWrveWu9ZibcNSjFbwHuOZZQqE7pIo1MO/Ikzqq8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s46ZkJ2MBC7+q402kdfRrAwtiH5l48oBujRfou6VtJd7DVJqAtZucaPn0RpfCTJRWYQ4v2mOVoqCAjQ4PnxzJiG/BIHS+rkxDZBXvc50OkN+J/oYr1j9Bypo8QdIm1Mmp2UuXhRspqEttp85aDCKymXoVIhRupGWnxBQy6rBPJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TfEjLyFO; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52cdea1387eso4645638e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719418736; x=1720023536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOXAoPOZbipJ93XdyhTiv94Fgw7fYvC41s+vnDXKabQ=;
        b=TfEjLyFO26NVBTjzcou8iMefJLkruqj4BdbYOMK5lL7NnDsnZ5Kui85qm9+DM2QPLU
         f7qeKE9IuMHOBWrQYr7NDg5ErHJZvwJ0/D6USkvidV5On6miKWXEYi5n3BLkOF4/YJJN
         RLU4GEn1dNodemfB0eT+HOboTQ/1VqHVNdX4tRrQC+Gul3LuDLaIAr3BAu0wUN5leg4V
         MY5sKBZN02mL/LW+TTjJ/fPxwzlmToIj9320FtmNLPMACPsPkg88Avncj5NPv6jWrM21
         0t++fD+PAsbXSBUFM1IWKJ5Bq3I2v+55c0/XhI/Tym+KXfJhKLecl2UhgRc5v5BePV72
         bPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719418736; x=1720023536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOXAoPOZbipJ93XdyhTiv94Fgw7fYvC41s+vnDXKabQ=;
        b=L+su2Ei4B5vUV7I7tS/x+KSiox7zSOy+LeNwwkNprqCtvqLMv66AyyFw9qKyQ4KUMe
         FApGCOwVT+VaIqFRIQflb8Eth+XIAS7kEmN09jYohLYdEOe7FXlXk7T5L0rIV08oH0st
         Osn1OWFDpS2X5NcNQDETsaV+CQlBT0gCiUbGlviFl0rtJaLGzgZmLqBKYCqfC3uPQsiI
         1D0EoowdUGJ5wWkKyFZUn1J8YCqi+xN1e2iSlDdES2ySFCe3nkGmcaSlbP53T8TWKZ9S
         Yr+JhtkAgkPBi6pPEYaXxC1eXcqi+Dl2g9FyOSlbRxfYsP2eFQL18XYS+XnUaNi8u7Lt
         gEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdl0C00l0QgTaaquxQTi9/bqOt6optJSOvDYh8VUE2IRYvHVHLeq1opSkYLM6TKTof/zc8L3tEFCTfMHmOuvtrBi4v834H1dGY2plY
X-Gm-Message-State: AOJu0Yx0Qv/W4caZr+2DObbO6t457HkNRLOLNlt/0EBUEWTXoWkLGrNV
	DjvyM0Br3ohQjOXQoCgQELXQiDSBmcyhatt4JGpzJu/pm51g4oLBQw5rTfcinY4/7ElCurvlq1F
	cGH7WHUpKixpgmRbjUukACLLnitURkHZYvhZCwg==
X-Google-Smtp-Source: AGHT+IHNMa1ftMAu8i49jJuPkee7HG52HPPQSvV++KhF04KmDg7GQRHQsI3P2aVaZhduWTy7dwIB7UF0h0Ip+fgNqPY=
X-Received: by 2002:a05:6512:2111:b0:52c:7fe8:6489 with SMTP id
 2adb3069b0e04-52cf5110982mr2440255e87.63.1719418736102; Wed, 26 Jun 2024
 09:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626-misc_perf_fixes-v3-0-de3f8ed88dab@rivosinc.com>
 <20240626-misc_perf_fixes-v3-2-de3f8ed88dab@rivosinc.com> <96ff4dd2-db66-4653-80e9-97d4f1381581@sifive.com>
In-Reply-To: <96ff4dd2-db66-4653-80e9-97d4f1381581@sifive.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Wed, 26 Jun 2024 09:18:46 -0700
Message-ID: <CAHBxVyHx9hTRPosizV_yn6DUZi-MTNTrAbJdkV3049D-qsDHcw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drivers/perf: riscv: Reset the counter to hpmevent
 mapping while starting cpus
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org, 
	Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 6:24=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> On 2024-06-26 2:23 AM, Atish Patra wrote:
> > From: Samuel Holland <samuel.holland@sifive.com>
> >
> > Currently, we stop all the counters while a new cpu is brought online.
> > However, the hpmevent to counter mappings are not reset. The firmware m=
ay
> > have some stale encoding in their mapping structure which may lead to
> > undesirable results. We have not encountered such scenario though.
> >
>
> This needs:
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>

Oops. Sorry I missed that.

@Alexandre Ghiti @Palmer Dabbelt : Can you add that while picking up
the patch or should I respin a v4 ?

> otherwise your commit message looks fine to me.
>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  drivers/perf/riscv_pmu_sbi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index a2e4005e1fd0..94bc369a3454 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -762,7 +762,7 @@ static inline void pmu_sbi_stop_all(struct riscv_pm=
u *pmu)
> >        * which may include counters that are not enabled yet.
> >        */
> >       sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> > -               0, pmu->cmask, 0, 0, 0, 0);
> > +               0, pmu->cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
> >  }
> >
> >  static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
> >
>

