Return-Path: <linux-kernel+bounces-201364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CDC8FBD8C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB80284EE6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D42714BFAE;
	Tue,  4 Jun 2024 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cByaJ4hu"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114E914B97D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534358; cv=none; b=JHXECmTrKtKtW8+mNVeXIGrhxz7t7MXIDrpqFXvJOd1GHKyxn4yPhqfxFX0qVl9jocGQrEZI+STcCicSLnHCRGz457CUNCow9hj7Id0jnsN1SE8uFJuohdcbJE1yrsTFUDoWa5PZTjNnSUJCw2sEFimGwHS1GnhylPUkexCGu6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534358; c=relaxed/simple;
	bh=lTzurSuy+sTB/+xYz5UJ7uXansp4aRLe290h4X7ZcIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePiSj/QCEeu2MVEw4EVxpSB5JMLUKtX0VIceVpgxwcjlKi4lU+TdQyQg75WFpkiYF/+BHQytpga1cZ4ORM76B6Vt/OHUZMhOdAEneQeVr/gEDnlD/uggr8sac3tGrMDXxtPTwmQgQobJEmkfX2XnIL0kNKC397g9moIX+s+xhGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cByaJ4hu; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaa80cb573so47634691fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 13:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717534355; x=1718139155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jC9d73OOtgTNGntmuaDsfT65a7uzZs0IHtC3nuFuas=;
        b=cByaJ4huHfZnXZr0pxTONQs0aU/8ApI19YUWHZnXjOeblsqQ0OK5Ck6Ks29xk1PWsh
         M98Dk3+Uv6Bk+jOoa8RpqpsZZVbyEwieIrVJOEDA0zgLe6VS+yNzpAp6Ix6hMKZMNzCK
         FKtOxTRXn+Bi7ZoUYuuc2wtfWrVTbrakwWM84TTmgmyd5RVWByktYeM0a6ovtp2xI9Gl
         2Cz67ijDKIAPWfhtDMCGmO73/hScSAMSyPLNasPJSRKI7a0wDM8ul/I0kmVelc+tX3AK
         pDMRssoHoitvaCXG4wIL7kEFiO8e7Ilf2Cen+++JXTjZ+Trk1qKhhAfAZj0JxE9nDBv4
         GuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717534355; x=1718139155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jC9d73OOtgTNGntmuaDsfT65a7uzZs0IHtC3nuFuas=;
        b=hDvpuOP2pl/GcJQ8p+q46LOrSjrbVr52g3eIaojbEMmsBsPUw1NUjaBPxFJtXxOkvp
         IxqMI6Jl1NOGw1JqA0zPWTl1mwulIGDbWd9PNm6AzkTDd+GVKodGoEAOQ0GirDi2I3Md
         15zv1St3oONB5p79ILZXD2CGl8/F/pohmCkDjr1GrtkmX/KxmvRRFz6SRNj77hmTpvix
         jkDk8vYprpeJntnw6DZW0yRBdy+PZLMO++tcnochDLznAw7prw0Llc2wm+xNnxfBm+oA
         hS/myPBoAdcAg1JpR6L93WYSYzKkCMIIMSK8vjXb/mm0f9cDINFs12j2MuSW1RcY0znf
         FtlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC2L42aCqDcLngztKuJa5p3Oq1dnbBVuFximGNF1FDWlGOCDXkobiGAS1jVOdHfrBNvOtrdY2YtMvzM2LR7JnEOjN0WdTKg866mnWz
X-Gm-Message-State: AOJu0YwTDa8uDQ8vbl4jvvR0n0rEGKV71IUdF++B3bCGXWUCtIOIiI+8
	5VV+Zgakk1GcV8qVAwo8pRhBYtECxD+1xWZNtVCzaK35BJc6XsV5gWLhObDRpd/3AS4pWPYNgfU
	Rz4woYWKctT3/5jhBNHZ0LknTZwn9Prpt40Gfdw==
X-Google-Smtp-Source: AGHT+IHSz9LQMaMYtdTksGpHEiQ16vlUmwhr1VfZwYoH47CN3ui+RiawoFFHfOTDLYSN7yRc3iPG2mXCt1rFNOU/H3Y=
X-Received: by 2002:a05:651c:210a:b0:2e6:be3c:9d37 with SMTP id
 38308e7fff4ca-2eac79c2ea9mr2458351fa.14.1717534355187; Tue, 04 Jun 2024
 13:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1dee481f-d584-41d6-a5f1-d84375be5fe8@paulmck-laptop> <20240604170437.2362545-4-paulmck@kernel.org>
In-Reply-To: <20240604170437.2362545-4-paulmck@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Jun 2024 22:52:23 +0200
Message-ID: <CACRpkdaYQWGsjtDPzbJS4C9Y9z8JGv=3ihQrVKvegJf8ujqSmA@mail.gmail.com>
Subject: Re: [PATCH v3 cmpxchg 4/4] ARM: Emulate one-byte cmpxchg
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, elver@google.com, akpm@linux-foundation.org, 
	tglx@linutronix.de, peterz@infradead.org, dianders@chromium.org, 
	pmladek@suse.com, torvalds@linux-foundation.org, arnd@arndb.de, 
	Mark Brown <broonie@kernel.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Nathan Chancellor <nathan@kernel.org>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Andrew Davis <afd@ti.com>, Eric DeVolder <eric.devolder@oracle.com>, Rob Herring <robh@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

thanks for your patch! This caught my eye:

On Tue, Jun 4, 2024 at 7:04=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:

> Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on ARM systems
> with ARCH < ARMv6K.

ARCH =3D=3D ARMv6.

This ARCH < ARMv6K comes from inversion of the the a bit terse
comment for ifndef CONFIG_CPU_V6, which means "out of the
post-v6 CPUs, the following applies to those > V6".

The code in the patch, IIUC make use of cmpxchg_emu_u8()
if and only if the CPU is V6.

> -#ifndef CONFIG_CPU_V6  /* min ARCH >=3D ARMv6K */
> +#ifdef CONFIG_CPU_V6   /* min ARCH < ARMv6K */

This is now a set with one member so this comment should say:

/* ARCH =3D=3D ARMv6 */

After this change.

Yours,
Linus Walleij

