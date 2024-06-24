Return-Path: <linux-kernel+bounces-227197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF879149D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516E51C22101
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB31113C83A;
	Mon, 24 Jun 2024 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PS/xHdOR"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E54A13C682
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719232104; cv=none; b=fvxUE8P5Nmwp3KWdzmlUmCrkjSbAGX7iaG6Y71DxwCsMbVp1VajsfWuL4+PmPzZXTMB3/9NvXdeXa17w+6CTmZ/tgnHs/kReUlBcQEVO/UaYAI4pY3K2P5qO48glYboncapVBhRuQVyYiVhj4fo942J1IdGUYYP7JZVJg/zDcOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719232104; c=relaxed/simple;
	bh=kvTHFbGwSn0IbVatzWle3jPEgWzYIiq7ayVFCi8dSZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyUWd/hBAT67EX/A+gsXqxmjTCX8K26GdALvvyCVBgYq27c2JYna0ly3icd8zlTZB+Wvl0yE2LpOMkfAp/voI55yK0CqTg0vUeorEaVFfWrR5R+T4Jc1qATsVc+Vsrj7FUvrlmd5zY4bT+gM814CSz1/YsRaMn5TYPklsISJVtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PS/xHdOR; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4e4efbc3218so1664646e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719232101; x=1719836901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Veq9TPKZ17jNotCvSeoq8DmaGeF2hh54pN8hjaplz58=;
        b=PS/xHdORlCUV/pNJIdzlT73EkbzCqf+i3fBotoQ/YDmOq1tX72rvKiQn0TwlrTBKqr
         Nem9gQWqhMQko+WDaZXzW310ggLeMw0uhOLsvCstjhV2eIljQvkAEaaj4TMR8qN/OnDr
         bJwojc0aFJL4jqPdUVmjbOZPUzFHdrn2a8YA3OEvEhAyC+L1DzaEkHiwbfXil3m4j1ex
         UpAbdF5ULwyzyFvSM8jX9WMScAjnz8+sOv+ogH7xT3EXuYN3J78YHKWiOAZ13valh+53
         YdqcP03rSGrlpQM1vbbxHuuKF+jjB16tUiyFdK5qL6DBCRuDBhjdpXzSSwN2xdxyUmIq
         85sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719232101; x=1719836901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Veq9TPKZ17jNotCvSeoq8DmaGeF2hh54pN8hjaplz58=;
        b=utesAHWxsw+HPcez99/53bOTpaJEVQGIujsoQRQboGCisUpo9duJx8ln3HR1Gf8i7t
         lwSCj5jcJ/oT74jAaSaJm49LbximCi42+7tReSHrXofMJ1CnhfGcRyWnqrP2vIfxI6JL
         2DV8uHWfsxF1dPVSCxEerIgLHYSL/byXV78/rzYQ0ylQPkQN0+zcW6aUMyvVb/M+K6fk
         9TIRhBrOa+DHHagYo2fVgnL9dzsgYOn+yk6Yf8Jr0sJCLbIqQOUgzxbIS++9wC2GeN/F
         3j3m8J8oqoamWK+jRKQIeyeX0gaa4i2b0nQ5NB2PUy7RajzyZxVtTbl4ne5JI6RqKg+5
         ZXkg==
X-Forwarded-Encrypted: i=1; AJvYcCWqaW0ErKgY+d6mrkKsbfUc5YGNvLNRQip/Bpr1RXYLzntZmjj9oEgVMi24PfP2j9RvD8rNZCcxfM+WAmP5oP9OQuHeU+B6Cnnmi1/Y
X-Gm-Message-State: AOJu0YxlaYlQuYUfOmErgor5l50k+UlRl1KCfHZb00irXTkQ7lqtRewL
	Oii5efp8rh+zgziF6hvRqFGgd4pI5Yqv8n8f4cfuSwaPSQy6NugCVqceH1IF0JCbb2IQyuoF8zZ
	e+zNtjrYwWaH30QVoWihDLzrAWQUMmi1J3yoU
X-Google-Smtp-Source: AGHT+IEXY6PfnqaCkx4O1P/wV/eai3a7cnOBgNvRi5EAgYDjt9F/J+oZ3D9g8gZzjIfIUtDcMFymywqTTqC2iMwIxw0=
X-Received: by 2002:a05:6122:921:b0:4ec:f758:e514 with SMTP id
 71dfb90a1353d-4ef6d8ad6e8mr2427978e0c.11.1719232101181; Mon, 24 Jun 2024
 05:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f214f15e-4a0a-4f24-9bd7-8f84cbc12e5a@p183>
In-Reply-To: <f214f15e-4a0a-4f24-9bd7-8f84cbc12e5a@p183>
From: Marco Elver <elver@google.com>
Date: Mon, 24 Jun 2024 14:27:43 +0200
Message-ID: <CANpmjNO=zv6D807cNLAQ3eGLrigUs9xtYNxoHhyuYvHkhhSUWg@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: simplify data_race() macro
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 13:49, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Use auto type deduction and comma expression to decrease macro expansion
> size.
>
> __unqual_scalar_typeof() is quite wordy macro by itself.
>
> "expr" can be arbitrary complex so not expanding it twice is good.
> Should be faster too because type is deduced only once
> from the initializer.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Thanks for cleaning up.  That code certainly predates the availability
of __auto_type. Although if I recall correctly, __unqual_scalar_typeof
became the first user of _Generic (the first C11 keyword we used in
the kernel?), but we used some ifdef to still support ancient
compilers initially (that definitely also didn't have __auto_type).

Reviewed-by: Marco Elver <elver@google.com>

Which tree is this for?

> ---
>
>  include/linux/compiler.h |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -200,10 +200,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>   */
>  #define data_race(expr)                                                        \
>  ({                                                                     \
> -       __unqual_scalar_typeof(({ expr; })) __v = ({                    \
> -               __kcsan_disable_current();                              \
> -               expr;                                                   \
> -       });                                                             \
> +       __auto_type __v = (__kcsan_disable_current(), expr);            \
>         __kcsan_enable_current();                                       \
>         __v;                                                            \
>  })

