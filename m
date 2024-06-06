Return-Path: <linux-kernel+bounces-205034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CB78FF681
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E861C24B90
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FD6197A65;
	Thu,  6 Jun 2024 21:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qleoegue"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C65F196449
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717708252; cv=none; b=qtQ25CVq0Lpbb7peCXhe+FBGoTjJM11sDZumcNUJeztuknkcgzlJeWgBA8C348o3l6Ye0ZTKRSiglKokPFvSh/5eq5X6isUkJ8Sx3hvX0j0gzpLqiXnU3j4LhQuoR7WkeXBMnm8Who/V9zeo5WlQL+Y+xnfUvwoEqI5cavQ2UUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717708252; c=relaxed/simple;
	bh=AUHnthjxhvSfZt1T5NTkzWwZswiKcMJtW7KrT1ABp7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIpKXfHheks3RCBOhCemAlilxoDch3ZTyFPxmBnMnEr4zNGa4nmmcIOa3CieKcKOBcMhj3Tl9KaSpvKadOL2bLfHvR3LRm4m6h3zGYXcMOZdobUhlEAHdwbHfhaEDOaiYuzIqPxAHdbLgh9Ou14zX+XManLAIfiszUZRXEWkKOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qleoegue; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eadaac1d28so8541241fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 14:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717708248; x=1718313048; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8TjgBjt57C936onmGqCK9GXQjMks7PTUKgl/Z6/JtaU=;
        b=QleoegueDBMmbfgGAKMJE3mOmI25sjdOU0wZAUndzcyXNd75pblKCoD36zYwtEQRDQ
         R+rKJ5pKcuedBsC5fiyne7iq/a12dEpOLZTvpvEtvPIU2XgRwDg2Sfagwc7Hc6RzFd2F
         QovBS+vIknSfwpYkev1Kbfnuty6enkm/ICL/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717708248; x=1718313048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TjgBjt57C936onmGqCK9GXQjMks7PTUKgl/Z6/JtaU=;
        b=RTwZGS0/5iCl9TXvi8Oar2ZLpXEel/d5VcFH0pn8SXCkoMVbabuBqtuuac57kp8S40
         1lJuVmXZBIHJGpq4z03Z0XrAqx/4KM7G0ArcJwtiAuNRzuGuIg4GTHYwUghan5+cYNWT
         m3kBlSmieITC4uSnXotk0qObHUeNeb56UWE4+iCxqBl5pq3e02GoVQBXIV75iSbnUorb
         7uX/Df8ZvPcjNlh5HjDKo4lYy3rDhpwwjGoivDc41XvSKoaqqYvpnuA+YGjWz5PjTXaV
         Go0/4/j7ASgSjXBFisi+2Oc+eEkpooXSUtNnWQ8CATn/nkR9qFSKw2nEGF7t5EfCvxr5
         dJZA==
X-Forwarded-Encrypted: i=1; AJvYcCXHfl8uVnA71UZYxK6WgsQtPwqjOX4WP0dX6kkGHHVpL9CTDrtTF8jU1W1tlAVbFUOf7asfVFV1oJ+L14/0RO0rRRqDMJJT/qpTy8Ep
X-Gm-Message-State: AOJu0YwUCo3bMLz9D/F3tXq5Wz5Fcq1b0agvkp//Y/M2oZ5ZibusTrNh
	gxENUKwDQiC3iSV1fl+n9tSLc4aOQyVWacXKO8s6Yc+tbXNd6mjBaE9PuJH9s7/sleTMCBaEcoT
	w
X-Google-Smtp-Source: AGHT+IHv/jKdu5UGvgVHoibT1EjVGRrIl2R8k37l5VetQF27bw0kszR4nftyu+c5ythVRLH7ezrloA==
X-Received: by 2002:a2e:351a:0:b0:2ea:c0ad:f974 with SMTP id 38308e7fff4ca-2eadce78587mr5599251fa.36.1717708248088;
        Thu, 06 Jun 2024 14:10:48 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae0ca5e3sm1660224a12.25.2024.06.06.14.10.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 14:10:47 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso1984141a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 14:10:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXl/ixrIP3sT+zjNccb0eskjy+mUkQIV0lrO5mztHOg1yp6SH+DdBbg9vSAFCgkcvxB8ZZ6sNf/Nw1NJcA3aOghUOY4U5/LgC7xlnq9
X-Received: by 2002:a17:906:26d8:b0:a68:f43f:6f31 with SMTP id
 a640c23a62f3a-a6cdc0e40e4mr47636166b.64.1717708247141; Thu, 06 Jun 2024
 14:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjHf6C_74VQPxmge-sMmu5yuhmNor1TaO0Uq--zrA13HA@mail.gmail.com>
 <20240606194525.cdnnidxurejsjtx4@treble>
In-Reply-To: <20240606194525.cdnnidxurejsjtx4@treble>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Jun 2024 14:10:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdrJ1H7sbsaL8_bLvRmt26_io=5_b3k_g33kd+bwFHzA@mail.gmail.com>
Message-ID: <CAHk-=wjdrJ1H7sbsaL8_bLvRmt26_io=5_b3k_g33kd+bwFHzA@mail.gmail.com>
Subject: Re: objtool query: section start/end symbols?
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Jun 2024 at 12:45, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> That should be trivial.  But ideally the interface would be less magical
> and wouldn't need objtool to sprinkle any pixie dust.  Could it be
> implemented similar to static keys by making the static const variable
> an opaque structure instead of just a "normal" variable?

So I will absolutely add some wrappers - we'll need them just to make
the "no static constants" case work.

I doubt I'll need any more than a simple wrapper, because there is no
equivalent of a trampoline when it comes to static constants - the
whole point is avoiding any indirection at all, and generating better
code.

So the only "wrapper" needed is the "different architectures will have
to have different ways to generate the runtime constant operations"
and the "with no support, it will just use the variable as before".

But the data itself is fundamentally embedded in the inline asm that
generates the constant op (note that I say "op" - it's not just
loading a constant, it's using a constant as *part* of the
instruction).

IOW, think of this more as an "alternative asm", where the alternative
is about the constants used in order to avoid memory loads and extra
registers.

I did name it after the "static call" model, but it's actually pretty different.

For example, if we ever extend this to modules, then any constants
will be fixed up by the module loader. There will not ever be any
dynamic rewriting like static calls support.

This would be for some very core constants only. Not random code that
wants to avoid an indirect call.

My code did the dentry hash table and size, but I would envision it
would be for pseudo-constants like __VIRTUAL_MASK_SHIFT etc (which
_used_ to be a big pain for put_user() and friends, but we solved it
with a different model).

Things that depend purely on boot time stuff.

>   DEFINE_STATIC_CONST(dentry_hashtable);
>
> That could create something similar to 'struct static_key' which
> correlates the const variable with all its use sites.

Oh, honestly, I don't need the disgusting things that static_calls()
do. The patch I already have is better than that.

IOW, already have the list of where the static call data is (the thing
that the .static_call_sites section contains).

Sure, it's not a "single" array of sites, because my sections are
partitioned by size (the static calls use a flag value instead), and
my "key" for the array traversal is just the address of the runtime
constant that they deal with.

It all works fine, although it will need some abstraction to deal with
different architectures.

I'm not at all interested in creating some fancy linked list of those
things like static calls do in __static_call_init() at runtime.,

This is literally for a one-time constant for built-in code, I think
the static call code is completely over-designed and inappropriate for
this.

So what I'm interested in would be to simplify things, and get rid of
the "key" entirely, because with a good symbol for the start and end
of the array of users (for _each_ pseudo-constant symbol), it all
makes the code a lot more straightforward.

In particular, it would make the architecture side much more
straightforward, because instead of traversing some "array of keys and
types" and pick up the ones that match, it would just traverse an
array that is already pre-matched, because each key goes into its own
section.

So I want to *simplify* the code, not make it the horrendous
complicated mess that is static calls. No "build up that list of
sites" at run-time.

Now, I actually suspect that doing this thing would then allow *other*
cases - like possibly static calls - to simplify their code too. I
think the static calls could easily use this to simplify the code.

So I would throw your question back at you and say "No! I'm asking for
this support because it would allow me to *not* do even a simplified
version of the horrible things that static calls do".

                    Linus

