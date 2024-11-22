Return-Path: <linux-kernel+bounces-417636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4D59D56F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59241F22E92
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E735CB8;
	Fri, 22 Nov 2024 01:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aMNPlTO3"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B568415A8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732237350; cv=none; b=t6v57joPAGm1CayY+Jz+OwiEOgWYopmHBwQO3f53ly9cbPixRHdvztxd40WmuBQe2IZur1Iaxdjjc7jYG3bF36X6neZE8LqTlOP12Q27+d4bWh+9ELnLqfBkTg+5ANM8zegWXnKzLoI05kIkkcZSRLZ/Zl8V/WkMqv0f0uVu7C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732237350; c=relaxed/simple;
	bh=aIcRWyhdLEDnl9/KQbnhfXb95m+NHW/PB866ttFytUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAgnEaPqZkg1QPxiy9oWh9LQA8MkDJr+wLTC6U3Ac6tp48M4paNvz70xPtReMYzva5KO7Awsd6Y4fK1Ps5FT8YZzgKvEGI7otONLSEFJaa1DNQApSW+wBYPVCoofyNlj0sQweTesjtDuAXysIGTjn9KmKcFiRH/fyUCIr42UkpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aMNPlTO3; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d0062e9c80so1930187a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732237345; x=1732842145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FDUaf5mQgLqX7fwS6brwxsKX3Lly2Xe2pTNHm3Zr32k=;
        b=aMNPlTO3lnDxAfzx943kt+ttrI8zGKCtL+Y4ZUXu44GZLhW3eyt3NTXedcXPDjT/3D
         9X58s9jjRBE6266wut/RNW28J4yeoLybDvRJxNJJfMzQapjHm2tyMOVeVXJXWXforWOL
         5cveGlmAhUeysjTF7vre1oNP9tcCL7Dzc0AkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732237345; x=1732842145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDUaf5mQgLqX7fwS6brwxsKX3Lly2Xe2pTNHm3Zr32k=;
        b=urZr5IdQwN27/ByP5TT49COnXPUHMXz11TYRWHgMisbwp5HJmwhI4QElMCpA1CrKrs
         nA2TGfYgikt9qe/BXf3uSyUOm9MNnZ8ZVzaU/hKLgxTPDfGt3Rf7+CgPTFUqSdzljo5O
         jc8o5wwEY/jQ8a1GNUrwKtLcP8g3P8IfJfFb1Tf3Okd2YSYDZ7o7gmOAd5KVXTeWSC2h
         S9AQpdM4MCcoIMTw2j8nnE6ZYcxmRUWZFQCYFjfONiBNbKSzflZXz7zpjmTOfl3FLSb0
         K5gHg7ArdIiSDjKLuhFxsYMkPfUhU1X8MkoJg/F59VdM05proTdqeY1woU3T9vm7JlDy
         FjGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/97AfJYibwkl3jyAeGa4bMtpiZyuW7sDNueu+4Ozk32fxYm43PBJ2ChkO70DYVK0UygaTeGzNW3qTTog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Zh11sALvK8kbBRbJ3eu0STmdvvFh0KpLMmIooKH0PgyDGewI
	qQbX/GGwQA8KF+ePwWI3xUe5zlr87LQeBRpA9FNyVmbRSsd9AZUnZ9pKKAGJVzn/cA8yGSkSSPt
	zR+VEEw==
X-Gm-Gg: ASbGnct5PGLhWwM4ys4XaszxLVnFJnstF6oRp9Dx5Cu20SXP5w6//q2OJCvFUrj7nUV
	syWcWFytoHAoeymL7xhZmNtWmdypLEyw3iKvInrF/4auuqae2GMrqG6cHzjINN39vxH2HLagq3r
	j2oo1qMNh2mOmDhhSdCyjpBAjlRZspA72l1QXUfhtoHpVOjpGjcmSlZ281kwvQAlnTAHLE5uajc
	lwGFCb5zRM6lOULVMDyrqkV9yVy+Dy4Ze86jbOhoyPQl4ubRgUKxkONib+1yif93FlSWy22Vz+3
	MIVlW56g8GDH7/PnWPXBcQ9e
X-Google-Smtp-Source: AGHT+IG9YR5/e2u5TeYOmBqop18pRoqha0w9WNXTNMWuCEsTgFZYGahQD6gszFGy5chFbB7V7spBdg==
X-Received: by 2002:a17:906:18a1:b0:a7a:9144:e23a with SMTP id a640c23a62f3a-aa509c073femr92762666b.43.1732237344648;
        Thu, 21 Nov 2024 17:02:24 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b57cb64sm30444166b.149.2024.11.21.17.02.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 17:02:23 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d01db666ceso383274a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:02:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxvGKQ3qlvYyi/JqwbFGgCAR8JuSZOTxcFzt6gt/eGKghs8i72SYhF5CxE3vxqt+yH7bq8Hss8IYhRq+Y=@vger.kernel.org
X-Received: by 2002:a17:907:7852:b0:a9a:a7fd:d840 with SMTP id
 a640c23a62f3a-aa509976333mr95234166b.1.1732237343540; Thu, 21 Nov 2024
 17:02:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730166635.git.jpoimboe@kernel.org> <82cbb9983fef5ecf6f1cb33661e977172d40a7e6.1730166635.git.jpoimboe@kernel.org>
 <20241029032735.pw3bg64bpneqnfhk@treble.attlocal.net> <76bb85ceeb854e3ab68d87f846515306@AcuMS.aculab.com>
 <20241115230653.hfvzyf3aqqntgp63@jpoimboe> <CAHk-=wgLCzEwa=S4hZFGeOPjix-1_fDrsqR-QLaBcDM-fgkvhw@mail.gmail.com>
 <20241121214011.iiup2fdwsys7hhts@jpoimboe> <CAHk-=wigHm2J4LkUL1=y_H8zGwM0JsK2CrWyLNbz9fvXfbaBQA@mail.gmail.com>
 <20241122001223.t4uywacusrplpefq@jpoimboe>
In-Reply-To: <20241122001223.t4uywacusrplpefq@jpoimboe>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Nov 2024 17:02:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=whm4fEYrzrrRrqEhELLFz2xNCMT9be+J0uiR_EwXwa0DA@mail.gmail.com>
Message-ID: <CAHk-=whm4fEYrzrrRrqEhELLFz2xNCMT9be+J0uiR_EwXwa0DA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] x86/uaccess: Avoid barrier_nospec() in 64-bit __get_user()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: David Laight <David.Laight@aculab.com>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Waiman Long <longman@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Mark Rutland <mark.rutland@arm.com>, "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 16:12, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> The asm looks good, but the C exploded a bit... why not just have an
> inline get_user()?

That was originally one of my goals for the "unsafe" ones - if done
right, they'd be the proper building blocks for a get_user(), and we'd
only really need one single good implementation.

But it really does blow up the code size quite noticeably. The old
sign-based thing wasn't quite so bad, and was one of the main reasons
I really didn't like having to switch to the big constant thing, but
with the constant, the "get_user()" part is basically 27 bytes per
location.

The uninlined call is 5 bytes.

(And both then have the error handling - the inlined one can use the
asm goto to *maybe* make up for some of it because it avoids tests,
but I suspect it ends up being pretty similar in the end).

So I'm not really sure inlining makes sense - except if you have code
that you've profiled.

Part of the problem is that you can't really just make an inline
function. You need to make one for each size. Which we've done, but it
gets real messy real quick. I don't want to have yet another "switch
(sizeof..)" thing.

Or you'd make it a macro (which makes dealing with different types
easy), but then it would have to be a statement expression to return
the error, and to take advantage of that exception handling error
handling gets messed up real quick too.

End result: the

        if (can_do_masked_user_access())
                from = masked_user_access_begin(from);
        else if (!user_read_access_begin(from, sizeof(*from)))
                goto enable_and_error;

        unsafe_get_user(val, from, Efault);
        user_access_end();

pattern is very good for generating fine code, but it's rather nasty
to encapsulate as one single macro somewhere. It really ends up having
those two error cases: the one that just returns the error, and the
one that has to do user_access_end().

[ Time passes ]

Ugh. I tried it. It looks like this:

#define inlined_get_user(res, ptr) ({                           \
        __label__ fail2, fail1;                                 \
        __auto_type __up = (ptr);                               \
        int __ret = 0;                                          \
        if (can_do_masked_user_access())                        \
                __up = masked_user_access_begin(__up);          \
        else if (!user_read_access_begin(__up, sizeof(*__up)))  \
                goto fail1;                                     \
        unsafe_get_user(res, ptr, fail2);                       \
        user_access_end();                                      \
        if (0) {                                                \
fail2:  user_access_end();                                      \
fail1:  __ret = -EFAULT;                                        \
        }                                                       \
        __ret; })

and maybe that works. It generated ok code in this case, where I did

  int futex_get_value_locked(u32 *dest, u32 __user *from)
  {
        int ret;

        pagefault_disable();
        ret = inlined_get_user(*dest, from);
        pagefault_enable();
        return ret;
  }

but I'm not convinced it's better than open-coding it. We have some
ugly macros in the kernel, but that may be one of the ugliest I've
ever written.

> > How would you speed it up?
>
> I'm not sure if you saw the example code snippet I posted up-thread,
> here it is below.

Oh, ok, no I hadn't seen that one.

Yeah, it looks like that would work. What a horrendous crock. But your
point that it would find the nasty __get_user() cases is nicely made.

             Linus

