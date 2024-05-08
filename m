Return-Path: <linux-kernel+bounces-173788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E25C8C055A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE9BBB23300
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD17130AEC;
	Wed,  8 May 2024 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c69RNwZt"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327BA130AC1
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715198881; cv=none; b=CGqlOOCtDoU1t2SZfzXZPpL7mOIiGUCYoPStrT3J056s2ScpYuEdIH97PbdeDrcx5NrRNJNbwNamNpMY6V3M4YOPb10HDiQA4uKOYdw32jqqpCRVva272Yy+OgPMTDviAlUEba7isRL2ts9dRIkll2a5oVpZgaSWjD2KV7ybMi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715198881; c=relaxed/simple;
	bh=cUhMA3hEDpUsxR6hzz85ZAu88LnRo8wpM9SADaguZmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ei9hT6JvhuM/F7xd7hz1EuQh1AUHKFzIisiR01OSt3nMBFB8Cz/g9fGMoy/i684tcweLLm3DSMFf20we8mzRkv82TnJeH2YoJ1t4+Vo9SauOTVa/6siWkwcEEl523jHhpsr0C3ZpBi3+GA8UQzJdqzDJV/D6KyBPH9UhQ243eOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c69RNwZt; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51ff65b1e14so87566e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 13:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715198877; x=1715803677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KNS3uukLqvQS7T/1QMyWRNid+5RlhH+5kk2j7s9gPHA=;
        b=c69RNwZt7i9rvNaTJ1H/ApakTxMtwE8yExIpP/CtkuC1Vy0B20P0ywr53temR2QQKg
         jdACnyFqju9aASG36FbnXPf1dYJNKn/02Miw6UQzvlP/QrxzkWLET/4pJwFzbi9Hy2GL
         QXAsWUsQRXWbv46329z5ePFvSpGtN6VHfB1EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715198877; x=1715803677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNS3uukLqvQS7T/1QMyWRNid+5RlhH+5kk2j7s9gPHA=;
        b=FcZ9gicGA+SZnBY34JBxJ3d9Tavut5feEBHv0Rmb92QP2XPAYPcadwx4kvUmEADl72
         eOq43DVZbiAjTlU52Nm8YCRZ2OlyuRmQt1WrFW8qChUEWAdXxZpSgeCF/ptTL6KNBHvZ
         6DS8fALh0UpaZyDWKG9fSvfxPwajMv/9Jy6ivFF+c0UaCcyQk/iJANt6LmT7qUkOmsr7
         jFJsPuk/J0qi4lQ2252Vl3v6Tn6O1e4tWErMpJqCNAAeKa7QXNu9ng9yim65+3QYEeVe
         i5Qow2BbsbDC/EnuMG6rmm+dQVOF9O5UJky1vlE2poXaJ4ceh5apKlWQToOg4Fe2gGJ0
         WUfA==
X-Forwarded-Encrypted: i=1; AJvYcCW4QMBvWnGVAO5mYKuTTG+N98E/D7AJkfw/01HQuoKzNmcIljxWiJF2izcdz3sI8hlFrXwaO9l9+f9P1Z5zefwff/UiNX0IuWNBX69a
X-Gm-Message-State: AOJu0YwbnzaX5KhX1IUUU7E4r/hN9IHY1KxWSpR2XaHA4pUILhE86100
	AlRQQfAvxb2K/pZDT9XkatXKWnhFE9z65tExQErXE669fTFDzQd3jCSOdud2zr9XY/qaHLFVTl2
	sTslDNw==
X-Google-Smtp-Source: AGHT+IFyol8uYoEb6xGrrdFgIr16074ZFWXcd6y2Kb0U+iJTA+VJHMP2rZsMyS3eVTgkPyivoJCMFA==
X-Received: by 2002:ac2:4e0b:0:b0:51a:b110:3214 with SMTP id 2adb3069b0e04-5217cc4ad07mr3195856e87.49.1715198877074;
        Wed, 08 May 2024 13:07:57 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id lx4-20020a170906af0400b00a5239720044sm7968533ejb.8.2024.05.08.13.07.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 13:07:56 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a599a298990so28374366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 13:07:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVriMLRviFnJhNi7M1FEpt94YKlZxtnWzVzbDKgyXi0tAb0b81xAB3Byxn/vw7239zsPFTJzxdqWLGY9cORZaw2u1+5t/B7a4srHu/z
X-Received: by 2002:a17:906:74d:b0:a59:bb20:9964 with SMTP id
 a640c23a62f3a-a59fb94b8f0mr259835466b.23.1715198875937; Wed, 08 May 2024
 13:07:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook>
In-Reply-To: <202405081144.D5FCC44A@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 May 2024 13:07:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
Message-ID: <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 May 2024 at 12:45, Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, May 08, 2024 at 10:52:44AM -0700, Linus Torvalds wrote:
> > Example:
> >
> >    static inline u32 __hash_32_generic(u32 val)
> >    {
> >         return val * GOLDEN_RATIO_32;
> >    }
>
> But what about:
>
> static inline u32 __item_offset(u32 val)
> {
>         return val * ITEM_SIZE_PER_UNIT;
> }

What about it? I'm saying that your tool NEEDS TO BE SMART ENOUGH to
see the "what about".

> All I did was change the names of things and now we have to wonder if
> the result is going to be used for indexing or sizing

Exactly. Your tool needs to take that into account.

Any kind of mindless "this can wrap around" is inexcusable.

It needs to be smarter than that. And yes, that means exactly taking
into account how the result of the possible wrap-around is actually
used.

If it's used as a size or as an array index, it might be a problem.
But if it's used for masking and then a *masked* version is used for
an index, it clearly is NOT a problem.

IOW, exactly the same as "a+b < a". Yes, "a+b" might wrap around, but
if the use is to then compare it with one of the addends, then clearly
such a wrap-around is fine.

A tool that doesn't look at how the result is used, and just blindly
says "wrap-around error" is a tool that I think is actively
detrimental.

And no, the answer is ABSOLUTELY NOT to add cognitive load on kernel
developers by adding yet more random helper types and/or functions.

We already expect a lot of kernel developers. We should not add on to
that burden because of your pet project.

Put another way: I'm putting the onus on YOU to make sure your pet
project is the "Yogi Bear" of pet projects - smarter than the average
bear.

As long as you are approaching this from a "this puts the onus on
others", *YOU* are the problem.

Be the solution, not the problem.

              Linus

