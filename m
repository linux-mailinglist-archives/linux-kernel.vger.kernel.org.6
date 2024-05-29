Return-Path: <linux-kernel+bounces-193678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2338F8D3068
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551431C26495
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1455D16A377;
	Wed, 29 May 2024 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gDaCxHnY"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A743615DBAD
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969869; cv=none; b=oUez1zU86yrY+mU0RU+dlfXeocV0VVz55cZEFI88VVu0605xqcxq3mJFSBE9N6BYIFdJAqZltVhT2gnhEgiLTT8WJfAkD1cR6Jw3D5W5Q/OGM4F3P//r79rUbHpiUq5Op5mnyuzd521BGsB5T1paBh+eZfPuvJgSFaYomgk1Wvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969869; c=relaxed/simple;
	bh=pft0aWV0nsM4NfbvHg75f+OMYeiKUeGHKGBBrvtxlgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjLp0JWUZfF59ng5gF3JqgNyZZjvwQqX97HsKoAfu+JxJUNidy/dIJSaiFz/xfJjGYXXUX2rFfZg8HC2YMFy2oBg0iIk77AMwvdY5pTszooSHTjJL0LwDUP3N27hIGc1X5uHCowCu+8PFbnU8+ukVGQoybqZpk4j8jHmiR0k6k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gDaCxHnY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a626919d19dso109471666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716969866; x=1717574666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iugICvJDzmJo7xGBPHogMYo6Gg3CJ7ooLOOivaduvyI=;
        b=gDaCxHnYmZS0tm8Ol8dqXsV9KxY5zbTD/Y2jCSfQ7lMLjC94uBPmMMa6rVKfwn53iD
         Cgs4wuotuXpq6DfuEljDV94CsuMBHsmP76PXqu+iPnHhN/Nbw6yEsfeLCt+ibrouGb/0
         pbRFNeTTD+gJ6NpChHHUhYX5JlTkOKKOe/p83Dl9xlKBYTTf2/BVZY1q8ZTRBSBDeXUP
         EOtUHt3o8uyiWWuX3cYv+DCKOK6dxZFidarv1f9RNa5HsUJXKPxlbyX/nR140bkcOhgm
         XArzyOY7YFwN67BfjMo+kXzwmzmZzsIID8PVhWug278JWScwQn0IhjuqWWNKdQTPhfIe
         9HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716969866; x=1717574666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iugICvJDzmJo7xGBPHogMYo6Gg3CJ7ooLOOivaduvyI=;
        b=SCTSfTRNlhQQL9VPoDSVpIWeiA8J0cpXw92Dg0UN3W4wv9qI7xONuUtdiYwo/Cwokd
         LkG/hBEMDki2Vo3seVwmFG5Zgu6/pO1lxYTwNCvU4BC5gc9jis1WG+Ote4EE/j0gGaND
         M7qkCTFE7UkZvxC36l5tDQCQJX8Q2rahmGUYi7QcWCJlgZv4CbqBCHg/sBI8TFOiTWSC
         rX0v8yNYSkZjhjI0XyIYUNAJUvBMv8v3MK1AtDeHfzpIXWtSTz/s0iCmv5SeU1H2no9e
         2sqdp7QD4fO3xCCigc8OXKH1pv5ChgPvmgfNZgGzrn9tIRQTtY+8mJ7/hqXpz1uqZyBz
         +aEw==
X-Forwarded-Encrypted: i=1; AJvYcCXEbtfRFLbXvQdB/xFwkYhUW6HhLf8rUu06iy8S/ESMLPlRC38GRRzAy1f2GPzbIoEJ//MStnX1A4/+jSzuWCkZ1XIdtYioa2UUscva
X-Gm-Message-State: AOJu0YwURbh/mFJgy4CsxB1vvgkKEJI4T8UyyGyjAYSS3+23S4dhsF3S
	WDwSGhsR3YiOikRqEuq/Py3HJMctJucfFyl2arqsdCOwb0cHTGwQVF/nJaEB7fMAVyuuD2SiJLY
	Hm2aIuZ/CVv1ZTsYTs/pL4Y/txeLVsQk49Ek6yA==
X-Google-Smtp-Source: AGHT+IG6iwinAXXk+z85s+DZ7rCxbual1zF0BnW9/urFx8Jq0vjUfxC8W1lP9e0VTumF0FrEVCZkoP1D8o+mWg7nLg0=
X-Received: by 2002:a17:906:3e4f:b0:a5c:d4b2:6a44 with SMTP id
 a640c23a62f3a-a642d3846f7mr95336266b.16.1716969865779; Wed, 29 May 2024
 01:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-5-alexghiti@rivosinc.com> <ZlYbupL5XgzgA0MX@andrea>
In-Reply-To: <ZlYbupL5XgzgA0MX@andrea>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 29 May 2024 10:04:14 +0200
Message-ID: <CAHVXubgBDxyow3-CFwBrkJ7xoAXCv8Tq7nNTAcvbzbA=TAaf5A@mail.gmail.com>
Subject: Re: [PATCH 4/7] riscv: Implement xchg8/16() using Zabha
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

Hi Andrea,

On Tue, May 28, 2024 at 8:00=E2=80=AFPM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> > -#define __arch_xchg_masked(prepend, append, r, p, n)                 \
> > +#define __arch_xchg_masked(swap_sfx, prepend, append, r, p, n)        =
       \
>
> This actually indicates a problem in the current (aka, no Zabha)
> implementation: without your series, xchg16() gets mapped to
>
>   lr.w     a2,(a3)
>   and      a1,a2,a5
>   or       a1,a1,a4
>   sc.w     a1,a1,(a3)
>   bnez     a1,43c <.L0^B1>
>
> which is clearly wrong... (other "fully-ordered LR/SC sequences"
> instead follow the mapping
>
>   lr.w     a2,(a3)
>   and      a1,a2,a5
>   or       a1,a1,a4
>   sc.w.rl  a1,a1,(a3)
>   bnez     a1,43c <.L0^B1>
>   fence    rw,rw  )
>
> A similar consideration for xchg8().

Ok, I will fix that separately and make it merged in -rc2.

Thanks,

Akex

>
>   Andrea

