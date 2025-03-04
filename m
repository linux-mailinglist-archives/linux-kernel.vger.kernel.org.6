Return-Path: <linux-kernel+bounces-543377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12790A4D4D9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5143A8311
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5776E1F63FE;
	Tue,  4 Mar 2025 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SegvU3ZP"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09148AD24
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073481; cv=none; b=f0duBDkykJUtfV/yvGnl6XG1Ipigy+E2eP3D/AxPP1LsNFcF6MO3zkDGj/HS7+evZs9J//kN7MGpyAPggBLvc717RE7XhkXa61bS8CqbUz3VYbIqg7WZkeetLRTuPmpep2sP1I/JS3s4CkxuELf9zAzvVMh711ggxmOFUxL0xpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073481; c=relaxed/simple;
	bh=tpN98sYNx6NgaaNJaNzJjhfkNLECKzO5ZtZBIw9ZphA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFwPBHBM0S3mQS+JBIlR59BxXBdHIURT/G1RcWMiSSqsdhnQKUQlBTLmzzWTitMxFdjkQgy2fXbEolGLutJfuc6Io5eZ//246Q/ELS1XPI7unPBOWjMW0SezU68Lh7IVKv5C117nL2BP0y9a2bfaK0rUc+8DYEIoTEfJmv6CV3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SegvU3ZP; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54964f8ce4bso2001413e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 23:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741073478; x=1741678278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsNGbnsLqSkU3I8v0oKk58JnonHmFCpGP5Ckb34MbPw=;
        b=SegvU3ZPa0feQ3QVjApd0e2+Vj2ilFNx/ugOLK5zBl+q00IYfqXYdi3FtgjPP4sdxs
         muQNipSdsiRxEoYrRTF8g3Lve1rEn9ezJItTrpIKvwQU3f2udpp+zrKhUkmPtLHRGPAs
         jCbrTRHwONlNvmK5gErhSCkwLF/9ZR+r1XqU0r2zfAZ2lcxrcF1hXrB6VVUpmufnvwBT
         fLX7kr5ovjd6oHJjFv+F8Pj2fpaTt3VI4A1iJo1/KJM5X7MmmoW2UYb8jE5b9cesesq+
         x3DHxgznNjEFEYtm6YLMHKye7oEpy9juzb7NzZvo+vFJFjZW4pBzQshcMYpBLru55c5K
         F5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741073478; x=1741678278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsNGbnsLqSkU3I8v0oKk58JnonHmFCpGP5Ckb34MbPw=;
        b=nGvdFe7WxWgvKOh1E1pWHd0jHeaRrqooj/vxdLjjEiGtRUU6UG1GD0gAkqWh/BG4BO
         KRT00pIfjdvWZvi3JFSinM9FUWbZ6P5s1qHzyvljogZE6GTgkmNWYHt3Pn2kTjq4xsLQ
         Kn1EFmfK43ePs5o+Uvmkfzx/0WVbyemRZ68860iMQO7rB+BTpUE+9xlNeYATVaIKE7rN
         VYDN17ChBQw9q8u7CzAp+4DNO1j5N22oLgkrNFGLfr/6hb9CLl1nSBy4635zKghZ9M8k
         qGPvPFqTE0Aa8JYHhRRWH8hqo5911CWlO9SUlKEn0DIm7gtLubVm9kyoOo3q7XAGqZiA
         km9g==
X-Forwarded-Encrypted: i=1; AJvYcCWRc/b9coMm3wrxv9bJ2xnXwttkCYwVbn3wkVXmZ4h/tMI6gmg1X/EtNaKN5i16n2YyVY0D4WYGzwJ3GmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5pEg57LlHSGaItMzkVFHiW96dFSxq89c93UgpLGHazPB1mdnH
	IZ6nbA0/S6F56avIuzhduhFBzmZnhI749rAVa7lAjtn/pRRm0NUGCF8HHJ/YpiDjiFholMfclm+
	4EH/Xk76th41pSzpmm/f8btuz2oJxgqIz7wejOg==
X-Gm-Gg: ASbGnctU198MaYQkgu8KocoJxK0gPoUq0jfLlpdKWQ1PmCKu5Fj5uOd0VQhkG5osqVV
	H0k7O6gI0mB0/yDfszBiWE3nCHt7Ya8QJzrp9y/vzeDx3TmfR1Rsyy6/E9slUHw00aASlmXt+Fz
	LHAlfOhFa0hGy87AIiUpD7zoohcw==
X-Google-Smtp-Source: AGHT+IGXmA371lT7C1gO2PiMuw8QGq/Oxyz60NAUpFqe9NaMOJoZxgRPOUxapC7rGv2iphJZKsi+29SyMJYP0KghgcY=
X-Received: by 2002:a05:6512:398e:b0:545:b25:ace with SMTP id
 2adb3069b0e04-5494c3282cdmr5632664e87.18.1741073478093; Mon, 03 Mar 2025
 23:31:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302-04-gpio-irq-threecell-v2-0-34f13ad37ea4@gentoo.org>
 <20250302-04-gpio-irq-threecell-v2-1-34f13ad37ea4@gentoo.org>
 <87jz97cml1.ffs@tglx> <20250303124011-GYA59067@gentoo>
In-Reply-To: <20250303124011-GYA59067@gentoo>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 08:31:07 +0100
X-Gm-Features: AQ5f1JqjLIt-xiSK5fnSqtY7c8S-APPE94mFjAG2-VPGFTkMlXbz-5UAA8K1r5k
Message-ID: <CACRpkdZn93oA6Tmi4EaWw9U=TAjEAdqgtK+2Ct_Nf1YUUrurgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] irqdomain: support three-cell scheme interrupts
To: Yixun Lan <dlan@gentoo.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Bartosz Golaszewski <brgl@bgdev.pl>, Alex Elder <elder@riscstar.com>, 
	Inochi Amaoto <inochiama@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 1:40=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:
> On 19:30 Sun 02 Mar     , Thomas Gleixner wrote:

> > Why is the three cell translation not following the one/two cell scheme
> > and has the parameters at the same place (index 0,1), i.e. adding the
> > extra information at the end? That makes sense to me as the extra cell
> > is obviously not directly related to the interrupt mapping.
>
> I think we currently just following the scheme with gpio cells order
> scheme, which is (index(instance) offset flag..), the index and offset
> are parameters to locate the irq which can easily derive from global
> gpio pin number, so I thought it's more intuitive to group them
> orderly together..

Right, the DT bindings are mainly for human consumption, and the
cells are positioned in left-to-right intuitive order.

If they were only for machines it would be another issue, but it's
people who have to write and maintain these files.

For example, in a library a machine could arrange books by
first letter in the title, then by second letter in the title etc, but
that would be very confusing for humans who expect to find
them in author order.

There are many examples of this in the DT bindings.

Yours,
Linus Walleij

