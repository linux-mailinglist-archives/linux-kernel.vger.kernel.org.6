Return-Path: <linux-kernel+bounces-436126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9B49E8182
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 19:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB2B1884038
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6ED1509A0;
	Sat,  7 Dec 2024 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P6Oo0eVX"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539341494CF
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733595597; cv=none; b=lJFzSSW3CGkBnGa8voJJcSjy2aoAJORYFfJ+AX1LgAI77/WH+62O8ly+2pvP6p7OPab/hdUTRWView/WbAWIrWmQIqI6lIHXNtBJp4WMUbu6VDg6n3quliJct53vANsZuR6d/xaW93zWVvMSHjHB+1rMu1vUe0z2SChbK8jED2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733595597; c=relaxed/simple;
	bh=xXsYNQRaodrrqkXbZvBZDBxwyz9RKFl5ErY9YCsri3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpYaUAjYMq/1DHBv4vxocg1H5D3xq3/2h4K4TTODkwgmawdvbe8Vl2C3nHcq1mJ4mUXYl3c1DWiQCch8qnxspSpi0HK+2vNOwUwZGrExHyI/wOiG7bjBEDH9nAEiTrucnGcAirHJ0dMnOzTmbzM0Ah0WtHXxHD8Rk9hcr4qxXds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P6Oo0eVX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso596727666b.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 10:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733595593; x=1734200393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hz+XAesKzHzZKAdlmXfk5ETHyOV9LQeE1EOaQCTU32k=;
        b=P6Oo0eVX93O/JUuUwj/akmnL8TSpWIT7fF//bcKu80m0r9kPJ97jRCfNuP0pxtm/3L
         kL1W0ySTHrsdcVh4w5sqAHz3NhKJdVpF8MBJZ1+lFdmarQW+zam0mPBtH5M5uStm60QA
         MYR9orFEqrUCIIYmvjRPLQCtJBdEIbv9/0VHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733595593; x=1734200393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hz+XAesKzHzZKAdlmXfk5ETHyOV9LQeE1EOaQCTU32k=;
        b=kxNf5fwR9CfoQIOrpIT/vEKa9yb1ywacEg2yyvAJ2aU5XqoLlzNcHAbE1a41XSE26N
         B/nJE2OBiJMNWcRfXZruAHzD9KoBA0RoT3T6jWEOkulQcLBmUL2kuRhk84VgsFKevq1R
         TfnhDE8N32fqJHs1l5QtQID3PA6tRP7TXdYuCqkdXhFdWhVWPOC0zwHvJP7oqAHpJwL3
         0xoEt2eEnLeu5u5BWbLgncX+e15rpodi87vablvJgR2SqQKFwed9/npu28zXAZ9pDIs6
         dHwOUyeGhIYnUnGjZNLPKUcL7l8d1MXdCGdHYBSVAgzpZtJS66BU501J9wSNwYqd6Q7/
         5gJg==
X-Forwarded-Encrypted: i=1; AJvYcCVSQ4Yltwgi+IOsq0i+CyUW+TEYmOiVyJP8/x2O836Wn471eDfy606j3VGWAVe6iiImk90CRrPfmjmJcxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG0BAaQ14vq31v35JaAOgpXAJldMriOM/7ObCNxxmBj4izSJZt
	cTnvib7zwVr5wLBWIOJ4UnBZ+UXjvcNx/4pX9ur+vnq2F+G+83I5ilfLHRRXK3OBOIlHdbQHKOQ
	cGo7TBw==
X-Gm-Gg: ASbGncvA8WzD+o3/Rds+Nt09El82l6b1azW6Ux5vA9UXW7mnN5lZGt0RD4U91BpwEbF
	jYNTtJVXsJ8rxZSU89znbFuVTzKS1RzQyoKv5P8s9/o7b9HlENYqxozq/YZ6HsK8qp273gn154H
	b0GJIWh3mZ17XDGXhn7zqWmb0KBFMxrDZfFid7tzE7GXm99X2LLkmIlkJ/9qHALOvmHkb1nnS3M
	LlsHlGWLoQUiFgpREQPFs54TPUfdqwdyyEpmYXQpB5AfNRlcMZ65sogszp6eDZJWzGqTzxqheQE
	xX1M2WWpxWaGnBmzhhGQfAg9
X-Google-Smtp-Source: AGHT+IGXW86Y5uXJaj4gmqhs+qSiomqpZPyllViTRBmStJiGRZ/22S4HGPtBcjpjrscAZ/clniD4iA==
X-Received: by 2002:a17:906:314e:b0:aa6:5ec2:966c with SMTP id a640c23a62f3a-aa65ec298f1mr233775166b.7.1733595593454;
        Sat, 07 Dec 2024 10:19:53 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa672d377fbsm9875766b.75.2024.12.07.10.19.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 10:19:51 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9e44654ae3so500921766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 10:19:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJWrtH2TXrL8vu8pL8HrWeTHpa+EGgmKRjkv8gFCh8tPLC3AbUxAxs5/pKLfWB41pNIy829CUhNSGXZHE=@vger.kernel.org
X-Received: by 2002:a17:906:1db1:b0:aa6:3de7:f258 with SMTP id
 a640c23a62f3a-aa63de7f394mr497786166b.37.1733595590996; Sat, 07 Dec 2024
 10:19:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com> <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com> <CAHk-=wjmeU6ahyuwAymqkSpxX-gCNa3Qc70UXjgnxNiC8eiyOw@mail.gmail.com>
 <CAMZ6Rq+SzTA25XcMZnMnOJcrrq1VZpeT1xceinarqbXgDDo8VA@mail.gmail.com>
 <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
 <d23fe8a5dbe84bfeb18097fdef7aa4c4@AcuMS.aculab.com> <CAHk-=win8afdcergvJ6f2=rRrff8giGUW62qmYs9Ae6aw=wcnA@mail.gmail.com>
 <0f5c07b827c3468c8fa3928a93a98bfa@AcuMS.aculab.com> <e806dd51b1ac4e289131297fbf30fc37@AcuMS.aculab.com>
 <CAMZ6RqLOR3aCRW_js2agV+VFiHdazb4S2+NdT5G4=WbDKNB8bA@mail.gmail.com>
 <b1ff4a65594a4d39b2e9b8b44770214e@AcuMS.aculab.com> <CAMZ6RqJFReLJTd-O8s02oQNeB0SPQh3C-Mg+Nif5vMB9gFtQww@mail.gmail.com>
In-Reply-To: <CAMZ6RqJFReLJTd-O8s02oQNeB0SPQh3C-Mg+Nif5vMB9gFtQww@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Dec 2024 10:19:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjpN4GWtnsWQ8XJvf=gBQ3UvBk512xK1S35=nGXA6yTiw@mail.gmail.com>
Message-ID: <CAHk-=wjpN4GWtnsWQ8XJvf=gBQ3UvBk512xK1S35=nGXA6yTiw@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: David Laight <David.Laight@aculab.com>, "w@1wt.eu" <w@1wt.eu>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"uecker@tugraz.at" <uecker@tugraz.at>
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Dec 2024 at 04:24, Vincent Mailhol <vincent.mailhol@gmail.com> wrote:
>
> > No good - expands everything twice.
>
> And? __is_const_zero() does not evaluate its arguments, so no side effect:

No, the problem is literally the expansion.

Double expansion of these fundamental helpers gets exponential,
because they are used in various nested ways in other fundamental
helpers.

That's why we then spent so much effort on trying to clean up the
min/max macros, because a single line of code would expand to
literally tens of megabytes of horrific expansions.

And the problem with these things is that you can't make them inline
functions, so they have to be macros, and then you build up other
macros using them (like that "clamp()" macro), and it really gets
horrendous and affects the build time.

And yes, it is very sad. Particularly since a compiler would have a
really easy time with some nice helper builtins.

Of course, often the compiler *does* have helper builtins, but we
can't use them, because they aren't *quite* the right thing. Like that
"__builtin_constant_p()" not actually working for some situations
where we absolutely need not just a constant value, but a constant
_expression_ due to C parsing rules.

Quite a lot of the pain we tend to have with these things is directly
related to the fact that we often want to do these tests in contexts
like global array initializers etc.

If there is one feature of C I would have liked it is "allow inline
functions and statement expressions with constant arguments as
constant expressions". Other languages have done that, and it really
does help. And yes, it means that you have to basically have a
language interpreter in the compiler (you do want to allow loop
constructions etc), but it really is very useful.

Oh well. Even if compilers added that today, it would be years until
we could take advantage of it.

At one point I literally was thinking I'd do 'sparse' as a
pre-processor for kernel code, in order to have extended language
facilities like that.

            Linus

