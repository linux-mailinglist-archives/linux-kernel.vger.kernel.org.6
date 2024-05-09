Return-Path: <linux-kernel+bounces-174805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588548C1540
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C3C1C21B5E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA70F7F7C6;
	Thu,  9 May 2024 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZBcnF8Ym"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3227EEE7
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282162; cv=none; b=V76JRviImmltvMfiE2pRghBuBfTnBDHys5roTx65TTCmb0UE/VzE+Oh/WqPOnHqddM1jbtOqTqb1CCnpooiWwktDsGsVYr4tuFEljgb3sT4wbnUU+dRwU3ktXZW163RCOXE1BVQgSYZm/Z+1lana2hgX1nl3tmTN/SbwuYMC0EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282162; c=relaxed/simple;
	bh=f5hTjmwtrBNmeRfEZwqwz3MoeEtUyLOcEt2AbxYcVbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfrCXtiESEpVHeBgpz4pWxkrcvPJmF0SUqYMqdSRGCGIXgky/SE0OmKMioNqj+3quVvFSMSnz+VzRXdNLfuK7FtiHTzai5PxwBIpIHTwwmE5lJC3e0j8CiIXAV7CcSeVKOf8GzmR0xxlnnvexd2jvVKQHuZ+EjcX6ELevXMYOwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZBcnF8Ym; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a64db066so316880766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 12:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715282158; x=1715886958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C9PPjpFCo1HBrR3dhTun969JD1naScZ8g1ToZzUTce0=;
        b=ZBcnF8YmhrjyvmPATrpxIJwnO/LAVDHVpKlE2c2K0TTYwfVyk9f3esVGbFrHqF70n7
         dlptd/NDbOgWA8FsY8w0ZecCKbH23DM236FhxJ9dY/rAXpG5bWE+9XnOs8dhTzPLfDvb
         uqR1LLMUB1GxE8mixDpUWggKypq9UmjV7DQkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715282158; x=1715886958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9PPjpFCo1HBrR3dhTun969JD1naScZ8g1ToZzUTce0=;
        b=kRD1kc6W5iN4ALNjz5H1ToqRYIDOFuPzYudwq4ktPmiHA7omfKQvOyzHL+VhWcIw/j
         /nwDVPzgBxbYvZ6JZeruukgtNspAYkFdwk7UUUcrSPzcxNQVnyhj/Xb5/4lH/SWuH0ie
         NagERzPfa43DMgfGiyrKRvMZVEKrmh5v26BJ550WEOcmw/ScNSGtWz2O+sseJP0LJkWX
         AnGinlG512Bu+LbQtl3uPPbjC/Vmron3A2mF0mWrpV/Nc3cMmCN5ybzoWJw1PJXr35VM
         7akxMlcKoDpxjJ6H3e3HYgmKBrgXgDDtSRJdsNbygZI2Wz7vIJA6igzpCXXHqALC+d9F
         bbUg==
X-Forwarded-Encrypted: i=1; AJvYcCVQsjn/Ic1Fk93KvbOsRDyM6qv+Jh11u0Gau3Q/Fs8nBer24pIwdm9EVTrmcA3KdfHJu+BUY/9FEiGLMNvSgl+CDsDAP4sE0tQdT8ZH
X-Gm-Message-State: AOJu0YzkBe5u+1lCYcPEFrRvpnKeZQiSFWPtVMguey33BgGe5mcgUMVU
	426JButwCf+Ana/d2pfL1WTPXjMJIUG871rhXObZaYB0ha2pkGHNiqS/DU8ydQvwUS6pqrvGhji
	i3yeHdg==
X-Google-Smtp-Source: AGHT+IHq5fD2MbPQl2PRK0m59BgcnSyrMm32j7q6/9EbTIisAWkmaLnBnag8YWoR0nDsmxvHuXb6GQ==
X-Received: by 2002:a17:907:20a2:b0:a59:a3ef:21f9 with SMTP id a640c23a62f3a-a5a2d6656b2mr33290266b.52.1715282158415;
        Thu, 09 May 2024 12:15:58 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d1fcsm102989466b.35.2024.05.09.12.15.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 12:15:57 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a599c55055dso332163066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 12:15:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJp9foXcNrwkASZ5w2PYq4ophlVH5eHpOSyU5pTBG0WRep4BfortuycXtXJF3C7BR13lErR2xCuXmTjvUAKyufULs18Ep9pO8PnSPM
X-Received: by 2002:a17:906:f88c:b0:a59:c52b:9938 with SMTP id
 a640c23a62f3a-a5a2d6653bamr36083966b.55.1715282157122; Thu, 09 May 2024
 12:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook> <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <202405081949.0565810E46@keescook> <20240509140854.GF3620298@mit.edu>
 <CAHk-=wgKyP2ffZPa6aKYtytzzFibiNVN5MS=D2cn7_UGCECKdw@mail.gmail.com>
 <20240509175417.GR2118490@ZenIV> <CAHk-=wgXm15gZHvt8waSFhXS9yZTfvMV95xyvNtPc6FSEA_rvA@mail.gmail.com>
 <CAHk-=wgBprh=8Us-MtwH9sVNELZK2hdOkFn3EoauwecYgtXOCQ@mail.gmail.com> <20240509184806.GS2118490@ZenIV>
In-Reply-To: <20240509184806.GS2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 May 2024 12:15:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjHA8Di-cpT0pKcScwcWNVYRFvmhBwMrug=Mj5WUwa2rw@mail.gmail.com>
Message-ID: <CAHk-=wjHA8Di-cpT0pKcScwcWNVYRFvmhBwMrug=Mj5WUwa2rw@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>, 
	Justin Stitt <justinstitt@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 11:48, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, the thing that somewhat worries me about having a helper along
> the lines of combine_to_u64(low, high) is that
>         foo->splat = combine_to_u64(something, something_else);
> would be inviting hard-to-catch brainos -
>         foo->splat = combine_to_u64(something_else, something);

Yeah, we'd have to be very clear about naming and ordering. So it
would probably have to be something like

        result = combine_to_u64_hi_lo(high, low);

to be easy to use.

The good news is that if you *do* get it wrong despite clear naming,
the resulting value will be so obviously wrong that it's generally a
"Duh!" thing if you do any testing what-so-ever.

Of course, I say that as somebody who always points out that I haven't
tested my own patches at all, and they are "something like this,
perhaps?".

But having "hi_lo" kind of naming would hopefully make it really
obvious even when just looking at the source code.

              Linus

