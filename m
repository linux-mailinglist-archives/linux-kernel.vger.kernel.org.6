Return-Path: <linux-kernel+bounces-545394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A6A4EC6A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C26647AAD51
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4EA24C096;
	Tue,  4 Mar 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d/M1JYKX"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425BD24C060
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741114131; cv=none; b=TOTEb9Um+1A6zhyLe7iacMKlnEvHJ12kif1qkQaQnrPSghdGpJELOKnRrSa/rnLjQGLlvorvb+jVgF0hi3hh5cS1us+GwpkcFvrudInSrK+yomJ4utrtm8tAPXif/zZmvO8aWVBv7P/LHYQFZlS2IOHeGJs4NtiKkYGfK8I7WRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741114131; c=relaxed/simple;
	bh=KvrG3UYpihGsPQkJiVzXVu3yOw8i8R2qlV9YOjObyK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHvs9PF4ABBAVll25PH9LDHoar9mJphAgoqAAxxL4HK6tN/Zu5NefObR0Rame3Z/gdXSXDOKd2KnbP7t2wYvhF2+ClaicMCHI24s6ur+oirlkMdJl111fIu2sfmwbaxW+Cy8gcgmACKYzfLxfTDJKzcQcX1wMDNJcnH6owag5yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d/M1JYKX; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e4f5cc3172so7201626a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 10:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741114127; x=1741718927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OuB99XEjibRdIGozjeXGZHXV949oela18xWJ3pUZ9Ts=;
        b=d/M1JYKXhj3f4+thvc9Ow+9qlJe4sbjiAiQroJ/n9tSNaryIkXdwrdWprtUjbaewRy
         +yYHR4Lmgg4FgyhGt+0/VNzxYVRicoYJ4Wy7/qYBDA/685lMrNd2x9ti+c8xytdZnGkF
         zY+WfHvqFENU+/NB+s0sPmlVr3TwN0tUDoG2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741114127; x=1741718927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuB99XEjibRdIGozjeXGZHXV949oela18xWJ3pUZ9Ts=;
        b=nKmXJSvkeedzphCThUooVoQajMAII00C7/DQ1HPKObiwwpPLYgM6TUUp17nfG9mV2j
         8hwa89qroOi/k6dk8e6gN/7UJOCT9AAWdua1d6WFJnbsiAebXVWrDQGETlA6DOVH+PdJ
         WXoDmn8CX1vxrMEX9e2LyBkx60KJOp6s+nvI9/el1OxK8c/kOuaR/rd9fZzkwM8U43QG
         gkf+x3EyCzXsQkmtBcboIdg6BaB7+TkkQF4ADF53DP3FiDXHRaRME4cMkPpPFqJeboP7
         WwcriSqtG3jBjzTznhLPN0bkwWIy4pw1RZIHlwuKrqrli1/DrAvBe++l8ffpgGHKoSG4
         KPOg==
X-Forwarded-Encrypted: i=1; AJvYcCWyv0POhRjs5OOfyx7Z2YQMaROhKgS4K3AQvIx8HvlZH99wqa2Q21r1g6ETdbYUAQ+UzdyEJEk9CaE/gdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDhUvJzvNj64eiaB6OHIaTyhukDNj/iJDbg4swYVeiV/o1lox
	QcAWzjtxmNoUStpLW0YUaWYEfuTgL6OMF5OkIz1i0e9XA8WqB5i7Q/CHBHWq5MvcDleTw9BHKIw
	8UYLmrw==
X-Gm-Gg: ASbGncscPShIv0NmnvZxC09n1HzTsfQjphMvzZDSDjIfEf93KEIBz6kojlXuulaIitO
	rX5pqCn4on/uTLgf/h87AcMtRloQ5Fi4TDiSMbvnjzxCpbj6+cFShr8q3NUzvoYmjS2BV2ZPZCF
	XyYbAfXJcSFBGPhFEfTT7wnyi5AsJGmgyxg2Nj0gi6pseRgdxRdM48xTk/W9pOulrwTUY1TnTr3
	0HHsQb8Zh3JTe90+d+dljOim2AUgZ0Z3GnKWHv4IzY4Ca5Qm91hlZ6RTlmwpbfO/Aui1vhocl8z
	vJZEefvP/djglWeabdpww50ptTLvCcuPyW1zVG9Vpk4TAuIQ5ZAGU9X+DkiXvuyO5Ei/hkMUjux
	QvcP9IPXHcCTY1x+q5sQ=
X-Google-Smtp-Source: AGHT+IF1evqmCRFIKkURu94pRVXc0stkit4L7l44HQ8AwNTmRghTy2OZLOkPNbTzOsr5lsLo08B+7Q==
X-Received: by 2002:a05:6402:26d0:b0:5de:39fd:b2f5 with SMTP id 4fb4d7f45d1cf-5e59f38585emr153940a12.1.1741114126963;
        Tue, 04 Mar 2025 10:48:46 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a61d5sm8553507a12.65.2025.03.04.10.48.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 10:48:46 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaec111762bso1097753566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 10:48:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPrrs+Gt8t8E24vacpl7f315pHWu/NHSwKAFeD1pRFoGFjqyLLa6rqEtBFPyQjPOo16GL1b9T6zRx2fC0=@vger.kernel.org
X-Received: by 2002:a17:906:dc8b:b0:abf:742e:1fca with SMTP id
 a640c23a62f3a-ac20d8bcb34mr40348266b.18.1741114125409; Tue, 04 Mar 2025
 10:48:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
 <Z8a66_DbMbP-V5mi@gmail.com> <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
 <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com> <20250304182132.fcn62i4ry5ndli7l@jpoimboe>
In-Reply-To: <20250304182132.fcn62i4ry5ndli7l@jpoimboe>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 08:48:29 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>
X-Gm-Features: AQ5f1JoR0UB9UqGJBBKA99pH7jooWGFdTpOHx-xCCHAEUPCx70AEUbGOKmD0Lgw
Message-ID: <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 08:21, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> I'm utterly confused, what are these new problems you're referring to?

Random ugly code, untested, special versions for different config options.

> And how specifically is this more fragile?

Random ugly code, untested, special versions for different config options.

__builtin_frame_address() is much more complex than just the old "use
a register variable".

> AFAICT, there was one known bug before the patches.  Now there are zero
> known bugs.

Big surprise - since it hasn't been tested on very many compiler versions.

> I'm excited to hear we can get rid of a lot of old GCC cruft, but this
> has nothing to do with the compiler version.
>
> It's needed for CONFIG_UNWINDER_FRAME_POINTER, for all compiler
> versions.  Otherwise the callee may skip the frame pointer setup before
> doing the call.

So you claim. But the original ASM_CALL_CONSTRAINT code was for a gcc
bug that was reportedly fixed in gcc-7.1

So is it *actually* required?

Because in my testing, gcc doesn't move inline asms to before the
frame pointer setup any more.

But I actually didn't base my arguments on my very limited testing,
but on our own documented history of this thing.

In your own words from 8 years go in commit f5caf621ee35 ("x86/asm:
Fix inline asm call constraints for Clang"), just having the register
variable makes the problem go away:

    With GCC 7.2, however, GCC's behavior has changed.  It now changes its
    behavior based on the conversion of the register variable to a global.
    That somehow convinces it to *always* set up the frame pointer before
    inserting *any* inline asm.  (Therefore, listing the variable as an
    output constraint is a no-op and is no longer necessary.)

and the whole ASM_CALL_CONSTRAINT thing is just unnecessary.

So I repeat: why are we making the code worse?

               Linus

