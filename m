Return-Path: <linux-kernel+bounces-420310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1AC9D789D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 23:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B508AB23997
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 22:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936D517A597;
	Sun, 24 Nov 2024 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fv2Ix7zx"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3EB13D246
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732487974; cv=none; b=e/GXuRf5BQa46PGswykUO0568YW6QZfcjMxGnMlijLhRp5CLz3HM8+Uji7wc/chmXrmtz29Lg8rUpQwinhxxAYShxKQFb5tZB0gJt2mrUZU0eRov5HLXnJb53mJRmZK0aM5Z71iKVBn/7MiqFpO/TltdJLCHjV5uRC1+Gr+50L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732487974; c=relaxed/simple;
	bh=UNkljXU1Th/F00ACjUWkzyCBqCMg14NM52aU91eCHhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ny+PMGYNJeiP856yb0RddNr/kWLnFvLRou0Kn49XSfovfNUvkLnlnTJDVLayfnLcNlrujYCFkVzOS1eM8aF/otYuRSNbKGLemd3ZFd1v2bDXWkIcs00pLpvSlaItfPTjjj3sFcL/FXrlNbNopGcSApTTsiNLX4q5ir8NZfHYyaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fv2Ix7zx; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa535eed875so207338966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 14:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732487971; x=1733092771; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mpf35aOuOMsH6rt6rf3g/KIHnIy4FQVAsb8BgJLC2NU=;
        b=fv2Ix7zxxV4pHJhd6LqglDctLnPe/TV6akclbxldlI1vDNqerat5YVGArvB6CnJkFa
         bNp4IVytSXl18gyNixkuNZxT+648N4PIa1vrmVKP5KwEwtunmfzt4gvcTO0BzqWAkjTG
         W5+fljBggbRifugqaU4lbp24YrXGyDUK3w1hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732487971; x=1733092771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mpf35aOuOMsH6rt6rf3g/KIHnIy4FQVAsb8BgJLC2NU=;
        b=H7nSodKFdmc7lyYh3fB7naxIsA43H9yuctTz42Y4j1TSnnZLS2L3AufXDMSUgLazDn
         9nXSWJ7Ac8TyCRsAbqyAInvw0ooARlHj/BEC1e+nNVX8BlJ1eGjR/t8/Xki9cbDzhyDH
         gp+9a3Euwp4RWtG6I24ctxPB8VZrFaNFc/2ir/6b2YpGjRuVD6kQFCnTXOY122OcgCcS
         6t6+KKG659AVc/Q53S7ysNRacIRwkGj4ckaO052K13/3nOO7Vhkk94ueWC0iYc26Vg4w
         hHNWw32jn7ARrFWqFNWXTtcHQwULEukn31Td8kLuLdMZMgYVMMw8q+Ph0kUQGPo81Hzt
         YOCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmoZ+y4MLmHXCpAHI1dsE0HZSIrzTKrNCH8KtpRbb9gN36Io26vOk7vgtcjBE1Vr+yXaP0y6pXL6ICv40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2nb/rsZDCPN0/aHPEQG52FrdA4EbFmSR1lVkJS8qYF6cDOcKR
	Rumj1nKLm9H/k5XBQClwE8EaqYz2wiBzcAtWzArEqq4hqNQ4FcGDUdCLgfSp5XKcuJjF+y8ds5j
	kxpzojw==
X-Gm-Gg: ASbGnctVqlS7B609izcC1Lm3cklk6qJBPYt+VTFdPTWxhH0by3Vm84Pdi1hW3jjnkrw
	4hDnHJfZgKmqk/7dcRWvo0PJ0D8kRi8A8tB/zCG051X52R91tE85D5bmnlAzy1JwbBTP+iUOMIa
	GhQjRDuE9kB2wxV3RNjSc0gHFG8nGbu8+x3U90pvSHGZprEob/8xoCHxbV1Gi0PA5YancKt8GMw
	6D5ajYpyG/9BLqYy7FCwZOgAB4OXiXAfdDErUbVDeYvqclaKcbm54Pzj/KBfqfA2dx4vkESgWZV
	SXqyIutadjxT2kyA4efHiq6F
X-Google-Smtp-Source: AGHT+IE6lOhiV8AUT/AWS4FxtQDaY+UUJb+dcT6oiv5c4kdJ6oVocf3Xy+ko/9QcAtCv0+EgmZjhoA==
X-Received: by 2002:a17:907:770f:b0:a9a:c57f:964f with SMTP id a640c23a62f3a-aa509e78de1mr1013130566b.16.1732487971011;
        Sun, 24 Nov 2024 14:39:31 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa53299ff77sm253678566b.73.2024.11.24.14.39.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 14:39:29 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9e8522445dso555372066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 14:39:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWMuLXFkj2Rv8iTnYhTqqmEZVKz6sdCp+E/S+8kLf+Hygu7eXeVi9Y85SwTWtoW+8LPpf2KQO/YUC/PAd0=@vger.kernel.org
X-Received: by 2002:a17:906:2191:b0:aa5:d1c:3dac with SMTP id
 a640c23a62f3a-aa50d1c4062mr889546766b.36.1732487968121; Sun, 24 Nov 2024
 14:39:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0edca3e5d2194cdf9812a8ccb42216e9@AcuMS.aculab.com>
 <CAHk-=wik4GHHXNXgzK-4S=yK=7BsNnrvEnSX3Funu6BFr=Pryw@mail.gmail.com>
 <b90410d3f213496ebfdd2f561281791b@AcuMS.aculab.com> <CAHk-=wgq1eEoUFK5mSUM6d53USDRaWY4G+ctTNEw9w_PsUqf1w@mail.gmail.com>
In-Reply-To: <CAHk-=wgq1eEoUFK5mSUM6d53USDRaWY4G+ctTNEw9w_PsUqf1w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 14:39:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh0oKkRHHqnft8mHaz5nuZNEspGQ5HW4oPJmGGwmccF1w@mail.gmail.com>
Message-ID: <CAHk-=wh0oKkRHHqnft8mHaz5nuZNEspGQ5HW4oPJmGGwmccF1w@mail.gmail.com>
Subject: Re: [PATCH v2] x86: Allow user accesses to the base of the guard page
To: David Laight <David.Laight@aculab.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, "bp@alien8.de" <bp@alien8.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
	Mikel Rychliski <mikel@mikelr.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 14:03, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 24 Nov 2024 at 12:49, David Laight <David.Laight@aculab.com> wrote:
> >
> > Doesn't that just need a <= changed to < ?
> > (And possibly of name)
>
> Well, more importantly, it means that we can't use the same helper
> function at all.

Oh, the 'sbb' trick also ends up being one byte off if we increase
USER_PTR_MAX from being the "maximum valid address" to being "one past
the max valid address".

And yeah, none of this *matters*, since "one byte off" is then covered
by the fact that we have that guard page, but this just ends up
annoying me sense of how it all *should* work.

I'm starting to think that instead of changing the USER_PTR_MAX value
(that was selected to be the right constant for things that don't care
about the size), we just say "the slow case of access_ok() takes a
tiny hit".

Kind of like Mikel Rychliski's patch, but we can certainly do better,
ie something like

  --- a/arch/x86/include/asm/uaccess_64.h
  +++ b/arch/x86/include/asm/uaccess_64.h
  @@ -101,8 +101,9 @@ static inline bool __access_ok(..
                return valid_user_address(ptr);
        } else {
                unsigned long sum = size + (__force unsigned long)ptr;
  +             unsigned long max = runtime_const_ptr(USER_PTR_MAX)+1;

  -             return valid_user_address(sum) && sum >= (__force
unsigned long)ptr;
  +             return sum <= max && sum >= (__force unsigned long)ptr;
        }
   }
   #define __access_ok __access_ok

would seem like it should work, and now doesn't make the fast-cases be
off by one.

Yes, it adds a "add 1" to the runtime path (instead of the init-time
constant fixup), which is admittedly annoying. But this really
*should* be the slow path.

We do have a few annoying non-constant access_ok() calls in core code.
The iter code uses access_ok + raw_copy_to_user, because it's evil and
bad. I'm really not sure why it does that. I think it's *purely* bad
history, ie we used to do access_ok() far away from the iov_iter copy,
and then did __copy_from_user(), and then at some point it got changed
to have the access_ok() closer, rather than just use
"copy_from_user()".

So I get the feeling that those access_ok() cases could be removed
entirely in favor of just using the right user copy function. Getting
rid of the whole silly size checking thing.

David, does that patch above work for you?

           Linus

