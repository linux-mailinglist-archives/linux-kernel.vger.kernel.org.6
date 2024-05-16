Return-Path: <linux-kernel+bounces-181543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0278C7D73
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 21:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C831F224DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4279C15746E;
	Thu, 16 May 2024 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQ5yDQWv"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F66A282E1
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715888941; cv=none; b=eJsNZhFutUBKSmZu0FkKACKx/pPHGH/r+qA2wtUJ+LJe43trjYUhXpW4eJo0tw1UsrU2mCYzjG3dG8IAB2j0dGvhRr/OyGxsbiq2KxP877lZOVPyJxlBwZC/sqvV8H5zH0tcyDX2oEaYZmA89bxh/m+rxPEswh/k8eNgAvh61DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715888941; c=relaxed/simple;
	bh=OnX7TnYfvl3uumb2LydyuGYxZJ5YcwNFgjrDTi8iz+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FE794ZVjbXwtaZqFGpL1Wg1rvC9tF24o7K9qN6nWT48uoDNdy15xIZBQFLWtK0wb+KUwcQpPwd6R96KbuyV0YLpqEmMiLeZel+AIk9kfLLJ0PpRYH1dFRXIgMVnlAIwucYcaR8pySf5JcND0O5oykNV+sml04adRqVgh+/4zujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YQ5yDQWv; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-47eee2af758so4881320137.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715888939; x=1716493739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnX7TnYfvl3uumb2LydyuGYxZJ5YcwNFgjrDTi8iz+g=;
        b=YQ5yDQWvjZV9vZI77vEo0PtG4+3gXrJ9/uoY8K1KHwCwzlQAPQ9eCCAbY2ic3hc1cR
         Ukg0GwhoqLDrAX/ZGkxFoCr9bJm2zQFTfeKt+QBM1Tf74Wil8n78iMYA6G++bYRAqQH7
         5Kph3NGE+lLnwwBtKfWC+t7kisr15VkXIAIJIptQU02fdKV8vADxP0uDK68L5KOBvFmH
         bbDy2pK23/iRy5SyvASoC6XVhBEB/zvgzD8f9tglNL0GPg/2GXxUAu/83YkV0qz/CGSy
         FFWahm4QkDnEuOUDS2s4gPCLy4YipIZ0eEYHqJQeWpyeOg4ARZzzra9j8EkrVBNoU8hZ
         bfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715888939; x=1716493739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnX7TnYfvl3uumb2LydyuGYxZJ5YcwNFgjrDTi8iz+g=;
        b=aR3nRs4Xs2RgNbErXB4NiKzcPBphNOKbXo+JWKwRHnUHc//TxR7a+FPfUWaWfRiCRC
         1Nh5BBSNCVBUa+Yvvu3Jv6ay57OA9nvI5kQrfogUeKkABiPj33S0Abh7tMgIRD/QoOf6
         qgSVZEKqEAKQ0xyk9j0+rQz78D8zoN1oLuxB0KpCCed3SSG/EHJdkp2p2SkRHIPpZGmG
         Z1NTum/Nz39m5eyzok8j42MP0VQCjL83fX2HVyOTJZx5svhNt7yBowxN4kC0R8CWBF0j
         GDNPyuNzIyFOyNB06qvKTgK6MPnuQD4XRPD2vsq+MCKYn2I78DKhoER8vQQPwSa3GEbG
         544A==
X-Forwarded-Encrypted: i=1; AJvYcCWp4dBtD2CJGwAL7JAl8tqKSKlXy8K54I9WcCTqczTTg5nWOMb9WVu3t+x5zwitp4gkccljQL+gLboHP4nwtd5PjMleIMkWDLtn612J
X-Gm-Message-State: AOJu0YxqiGMYuXv/QQm2a48Bj53bSduiz/13YdJLV8+zv4aJ+8+zDxWj
	vDYd22ZqmG4MZUeZU4zmyiKjjntyiDwBQ2Nti5vnkoHcOh7lkvtm/2a3xshQnM2EMl1KpQdxv81
	AlDwjdhoPLpqIfLA/mAnV5VKZZSqdLTEO3myi
X-Google-Smtp-Source: AGHT+IF4MCz5IrJ5BpbDJ2N7fvi58cP7oeWW87v31abeJJofLDv76BLf5VYJSRIBXM+DlfiDjV2yxEXxI8RcHWd8W/k=
X-Received: by 2002:a05:6102:dd1:b0:480:70d2:34c9 with SMTP id
 ada2fe7eead31-48070d242f7mr22514069137.15.1715888938839; Thu, 16 May 2024
 12:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook> <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <20240515073636.GY40213@noisy.programming.kicks-ass.net> <25882715-FE44-44C0-BB9B-57F2E7D1F0F9@kernel.org>
 <20240516140951.GK22557@noisy.programming.kicks-ass.net>
In-Reply-To: <20240516140951.GK22557@noisy.programming.kicks-ass.net>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 16 May 2024 12:48:47 -0700
Message-ID: <CAFhGd8qCCCrccQ2z5bjBD5YcMWHkym9aVz_qYkyyj662XEeHvA@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 16, 2024 at 7:09=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, May 16, 2024 at 06:30:32AM -0700, Kees Cook wrote:
> >
> > I am a broken record. :) This is _not_ about undefined behavior.
>
> And yet you introduced CONFIG_UBSAN_SIGNED_WRAP... *UB*san, get it?

We should think of UBSAN as an "Unexpected Behavior" Sanitizer. Clang
has evolved to provide instrumentation for things that are not
*technically* undefined behavior.

Go to [1] and grep for some phrases like "not undefined behavior" and
see that we have quite a few sanitizers that aren't *technically*
handling undefined behavior.

>
> > This is about finding a way to make the intent of C authors
> > unambiguous. That overflow wraps is well defined. It is not always
> > _desired_. C has no way to distinguish between the two cases.
>
> The current semantics are (and have been for years, decades at this
> point) that everything wraps nicely and code has been assuming this. You
> cannot just change this.

Why not :>)

Lots and lots of exploits are caused by unintentional arithmetic overflow [=
2].

>
> So what you do is do a proper language extension and add a type
> qualifier that makes overflows trap and annotate all them cases where
> people do not expect overflows (so that we can put the
> __builtin_*_overflow() things where the sun don't shine).

It is incredibly important that the exact opposite approach is taken;
we need to be annotating (or adding type qualifiers to) the _expected_
overflow cases. The omniscience required to go and properly annotate
all the spots that will cause problems would suggest that we should
just fix the bug outright. If only it was that easy.

I don't think we're capable of identifying every single problematic
overflow/wraparound case in the kernel, this is pretty obvious
considering we've had decades to do so. Instead, it seems much more
feasible that we annotate (very, very minimally so as not to disrupt
code readability and style) the spots where we _know_ overflow should
happen.

[1]: https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html#ubsan-chec=
ks
[2]: https://cwe.mitre.org/data/definitions/190.html

Thanks
Justin

