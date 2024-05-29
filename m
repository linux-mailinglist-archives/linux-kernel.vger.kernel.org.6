Return-Path: <linux-kernel+bounces-194086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ABE8D3665
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D8C289184
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA06E181309;
	Wed, 29 May 2024 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dsHjE0jo"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859EE180A9F
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985757; cv=none; b=drYsdFC7i6GFAtg5iJRi9s7XkG77HnsN+KQRLbUChmJ/X3Inn8c9VWN7yuOgg/Q658RgLKO9XWNs2f/5kcbbPJGyeTzdR7ad0oyXVEoi0t24lq0Or3M4nBNjWHittZNUcL1zF91ylJBdBuutTcQOIGYOUDhNuufvtukQ3MXS/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985757; c=relaxed/simple;
	bh=idIfNjbOL1qD0ETg1hT6YfT88MOe7waFfNRjHCRqyJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2uw3yIl2lN/03Iio4D0Ru3xWNRsSnNhLSufB4ojxk43G7yjL2nX7uxUUNTJCOSoYTxJuMgA/0FdsVkM+YspBdrJc8bDj1sm0nInxaUk4ggitrt6IXmCaSorbaz5gE1SzCJXt/SomVEn0KuQzJJ6sIHCl9sNjhyZhEVxo30h27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dsHjE0jo; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a62614b9ae1so236322566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716985754; x=1717590554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGOEscTDwTYqe9co9+vKadCnOa5+j3XpvvU3cG9r11k=;
        b=dsHjE0joBJ+pINsd1aEDha8rBVzEkpvitdyXLo7dwKlw2lgPXQ5uhB743UYcwCkCZZ
         h4P9LYTAM/Cev2OmYo0eeSucugyHn7x/XxHP8rn6EsHlIxBhKxdTzQKhK5ivwV66HPyN
         mT6kvcttDvRlVKRcMyAgqBhcQstk7TBAfy3O9zBXDZiK6tpQbdcbOpyCu/WK27aDbJkb
         noriGWhgky95jdcVtszZxReBt/gaN+xRcjdmjFhLGjWGfbIalKxVufzl8UFB3IQPMOLa
         WPWSnzcWBemAQ9dPfwLh2pABMvp+8tCmX8ZqGw8qNSnau0MFx/4g9uw5JuAXV5sR/LFs
         J9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716985754; x=1717590554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGOEscTDwTYqe9co9+vKadCnOa5+j3XpvvU3cG9r11k=;
        b=iayNZoeLQfdZ7qYhWLKK+WaGuR3A+BPy2+J3/HBG4ojGPmVqMr9ykgXhxqGl2qyvqR
         xaEDN1ZDFiKHOioUV1RGsQafkHzhkOfgmxRHNhV4Lcn3NmTD/rhDF2pLC0nyCYmperb/
         1sqIJEPwJwEOroFyBiD57zYClUtej57ZNHeIcmVONdls5qrw3dy1RkeYJJ5wKAYWORu2
         9JJI9gt8Guk/pgytoi2agv3Lmftzv9qNA8/EulAP3wYTGPCVWDoGgGbstGBLObqny3xb
         3zgpznJBzqJ4aWyMJ0ncF79fopl+XkBnh9Azhwmh7CNA1G1fiFd+SyieBMJ90lY+hhhL
         E9MA==
X-Forwarded-Encrypted: i=1; AJvYcCXUFd5kyZwZkEi/UfH8KuGlO5Y1M1yKBT9eTSeSGMnaaIlH8EjciudvWVKenhXLUhGSfdVYluN1175VafAwslmivuCn9dIhjgM9nR11
X-Gm-Message-State: AOJu0YwlAyaWC0kqWi7s+BJg1CkIsgUjybMRttO17RmAvNWw6sg+y0IS
	r2pr+8lnPeOkpITkpQpO1pKC5oLt7LrChcfnMp2bHjsA9CAuQLpQuux+2gleke/a7EyoAAYWEr3
	UYNXhACi3Hb5A0It7qTG/nF11lCLLUPFaSmHR2A==
X-Google-Smtp-Source: AGHT+IEQgikhsrsUYBnaJMpD1uGbxEZ77OxlR6yJ2c4VtevK8CwBEfxhj58UbW9AHXXHwN+zwIK7XfHdcV5UtsKrn0U=
X-Received: by 2002:a17:906:a455:b0:a5b:53e2:519e with SMTP id
 a640c23a62f3a-a62642ea4f9mr995846166b.26.1716985753806; Wed, 29 May 2024
 05:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-3-alexghiti@rivosinc.com> <ZlZurXUUUfXHZJaX@andrea>
In-Reply-To: <ZlZurXUUUfXHZJaX@andrea>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 29 May 2024 14:29:02 +0200
Message-ID: <CAHVXubj1RpN80f0vNQwFtaNKORnw2F3yzA1_0txa3A+9-usdFw@mail.gmail.com>
Subject: Re: [PATCH 2/7] riscv: Implement cmpxchg8/16() using Zabha
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 1:54=E2=80=AFAM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> > +zabha:                                                                =
       \
> > +     __asm__ __volatile__ (                                          \
> > +             prepend                                                 \
> > +             "       amocas" cas_sfx " %0, %z2, %1\n"                \
> > +             append                                                  \
> > +             : "+&r" (r), "+A" (*(p))                                \
> > +             : "rJ" (n)                                              \
> > +             : "memory");                                            \
>
> Couldn't a platform have Zabha but not have Zacas?  I don't see how this
> asm goto could work in such case, what am I missing?

Zabha amocas.[b|h] instructions are only implemented if Zacas is
present, as the specification states: "If Zacas [2] extension is also
implemented, Zabha further provides the AMOCAS.[B|H] instructions."

But the code you mention is only for 8 and 16bit operations, so I
think we are good anyway?

Thanks,

Alex

>
>   Andrea

