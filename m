Return-Path: <linux-kernel+bounces-399629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D15F9C01EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87F41F22150
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D711E7C21;
	Thu,  7 Nov 2024 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LHevrShu"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09051E5718
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974158; cv=none; b=C1DCQ9Ezc/UD5adq7jFUFaihjKEt53gQTLNnUZKKPZWF8la7iire5TeJdB2SOloZaubeMLzjvmnRZ/MYnJOD8iOP+za7/f08l6ARgPtlPPv6mjbrv8qWtPvapqRJO2caf+K/5CuMeP6Se29LeK/0DBzxOzECZX6Uvrop19lZngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974158; c=relaxed/simple;
	bh=TP+F9gIeVCvmoR+H+MTVsZugSnked7G2p8S7gJTNe+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPWAXRR9dRp58FdBsv3x2WXspV5MR70g5/SDfFo/v/zimHy7ON4jeoiLPFtSny0d/fnxZsYn1NZIrLigMGxr+wuqtUbN3n84TDWkqM91leL07KCBh+N8I5yxFkpfJGfJduBLxGqOM3xN/8AVq+rp7V6K0y1LCrOO6Q2uo1ss0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LHevrShu; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cb15b84544so950221a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 02:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730974154; x=1731578954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpDrSskUv1o1NTarlsHfGOMJt+ymu1r/HgLDqyVtDWA=;
        b=LHevrShuQwkpsacwC6pm6IQGGzxoee6JXcp2Yp+s64g1IkofKeMde28sAdA3sI18zc
         TVQHepuiVknRlu7LIZcRq/tdSNuZtvEghRIsx2HF3bcYCZtmZ8xRN891QqWZzPhWvA6i
         bNaZ4TBxsd12iSXb/5L4Qyigvta/peb40FFQpyKcKcZ6J+p6q/k8+wUIUz6dTfNXfI+P
         3pNrSfUIcnh1DiVBUAsk81AN/AKCSMo9EFIskgmLZ7VnVK6saH2T6Z486tYrH24VpC6u
         L5BOfAjKka9C9vd275E1JtKI7ghshelDDlEHrCeGVZAiXK0wy992LMB0AcZA9VrSKS5S
         vYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730974154; x=1731578954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpDrSskUv1o1NTarlsHfGOMJt+ymu1r/HgLDqyVtDWA=;
        b=RAynWWyKQWuT0HaZfcRs+oQ5vhdnt0VYgme0JB0bi+5oYznxXLM+ydZElMfAluAOQG
         kjG18PbeiGfr0iqNZnqJlcpZ8TC4uWD0DPo3eyhv1zfdVl1c2RIZy7GJ8D2otTgo2pN0
         /izWRBam1YF6q/SGJ1h+fUVK7CgkHT53+RoD85kw3pzL9AYtEuZRNzyNMSymOO6V9jvK
         xU5Y+mDdQkUGUDwGOoPUNgu2kYk6AKzPwZRy5qG4F8Ng4Lbb/c9hxuKWWfyrgmo/PHkd
         tLgAHGAvaybxaL/KaeQIwDbMzh5a3Bhp94smsgnoD9CJfIwfXnK3Uw7sTzjgzu+cdd7X
         WBfg==
X-Forwarded-Encrypted: i=1; AJvYcCUojcfWpduID7NdapqX8W6sqwnq3+IB7l/q612RnrS1p46lemnwUzKuPuqvSs1GsQ4iTamqlg9tHWtJ29k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl4/rug9kBb4VP/GmFPlwUsPnVyyfr1Rmfu2n5v6C6t5Mtewnr
	kn/BdNJmJFFcwCGUSWSHuiKfG8uEpOdD0TDz5TGXWIotq/Qz6YVZ9AHaZUKleGu39TmS1zdb2aA
	fVmK8V7laikN9RdPMX83NWCTU7tgAwiOUFeCwfWqe2tuf1fOQ
X-Google-Smtp-Source: AGHT+IERZV6Psk5Yyx4TfQfVXmINj5F1hDhQ/XqQ1JTLYObIeW3O+9WxU1vcOqYi3njcPAbsIOTANJXFovMSGP962Q4=
X-Received: by 2002:a05:6402:50cf:b0:5cf:529:1e73 with SMTP id
 4fb4d7f45d1cf-5cf05291f47mr741826a12.13.1730974154217; Thu, 07 Nov 2024
 02:09:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106193208.290067-1-bjorn@kernel.org> <20241107091307.GA2016393@myrica>
In-Reply-To: <20241107091307.GA2016393@myrica>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 7 Nov 2024 11:09:03 +0100
Message-ID: <CAHVXubh4A9JY2hVzYW0ES1QxfLL2iYczXBCcr5OXsrYoZcWJKw@mail.gmail.com>
Subject: Re: [PATCH] tools: Override makefile ARCH variable if defined, but empty
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Quentin Monnet <qmo@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, David Abdurachmanov <davidlt@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bj=C3=B6rn,

On Thu, Nov 7, 2024 at 10:12=E2=80=AFAM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Wed, Nov 06, 2024 at 08:32:06PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
> > From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >
> > There are a number of tools (bpftool, selftests), that require a
> > "bootstrap" build. Here, a bootstrap build is a build host variant of
> > a target. E.g., assume that you're performing a bpftool cross-build on
> > x86 to riscv, a bootstrap build would then be an x86 variant of
> > bpftool. The typical way to perform the host build variant, is to pass
> > "ARCH=3D" in a sub-make. However, if a variable has been set with a
> > command argument, then ordinary assignments in the makefile are
> > ignored.
> >
> > This side-effect results in that ARCH, and variables depending on ARCH
> > are not set.
> >
> > Workaround by overriding ARCH to the host arch, if ARCH is empty.
> >
> > Fixes: 8859b0da5aac ("tools/bpftool: Fix cross-build")
> > Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>
> > ---
> >  tools/scripts/Makefile.arch | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
> > index f6a50f06dfc4..eabfe9f411d9 100644
> > --- a/tools/scripts/Makefile.arch
> > +++ b/tools/scripts/Makefile.arch
> > @@ -7,8 +7,8 @@ HOSTARCH :=3D $(shell uname -m | sed -e s/i.86/x86/ -e =
s/x86_64/x86/ \
> >                                    -e s/sh[234].*/sh/ -e s/aarch64.*/ar=
m64/ \
> >                                    -e s/riscv.*/riscv/ -e s/loongarch.*=
/loongarch/)
> >
> > -ifndef ARCH
> > -ARCH :=3D $(HOSTARCH)
> > +ifeq ($(strip $(ARCH)),)
> > +override ARCH :=3D $(HOSTARCH)
> >  endif
> >
> >  SRCARCH :=3D $(ARCH)
> >
> > base-commit: 7758b206117dab9894f0bcb8333f8e4731c5065a
> > --
> > 2.45.2
> >

You can add:

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

