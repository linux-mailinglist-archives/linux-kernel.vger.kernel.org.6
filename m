Return-Path: <linux-kernel+bounces-562713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDF8A6319B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 19:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63731172C05
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 18:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D37204C26;
	Sat, 15 Mar 2025 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qyq9svWW"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0833F200100
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742063505; cv=none; b=kiAVB63igdRGyQHpIewoI6ObvjTyTrcxIdSHNfadJRzLCM1oI62aecd89Ae8UPD4vMRMRriUiIBXYP29qD7f8eO1h8EZQZdB6qgTVsBv31IO3Wz7crJqq4ml6as4fkHZxajrz5mK4rXVSZZ29ucTyYUISCa4Hph1864S8ObyFWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742063505; c=relaxed/simple;
	bh=XV+UOWy1S9PWbjopZNL+DwSwF3sDIJJk6cvH5cVz+Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eo6Q+aO9TDz56PIjCQK8SxnWkiI21QGhko7t8G8o1dx1ZxYhMZ4GRRIRvoX35vw6qSRfJH8xNj8lX5Y2bp64rJIS9fP3gFPbXnYL4jGqnUdSE4tInSdvuDQg23frSu8IL4ybjuX1sBrhgvi5IGYkEnh+J3IEDL6XTS+9X6AlLEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qyq9svWW; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac25313ea37so634015566b.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742063500; x=1742668300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fUg4fCMuPkYhbF/nCEDejVAU0bc8GhrExOsFutZjexE=;
        b=Qyq9svWWJfrlbkarBEyfjOFYl+tEA1JClX2+Vk9OTZuVPdCwDoPrsZ9fGr8eldWJ1v
         O5r3NMIpYi4vq1EG3ArxemdQKFvITWE/NOp5SfAcbIbJ7K0kOBm7FPNVqpOAsfq2yI5U
         Xf4wOFEbnLj4EUZkylFKZe7VCc0o011Ekwb/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742063500; x=1742668300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUg4fCMuPkYhbF/nCEDejVAU0bc8GhrExOsFutZjexE=;
        b=AWQeWUeJw1Nx6FVSbHDeOysqige8CxOGGdM/jPSEXUJePjat4nPvqaDNpi62Vsv3sR
         Myz2194cY+1pFnDlcNH3PS+hq75GCiH2R06fmTAnpk2QZ332GMyyj+6+0jcCr9ui41CY
         CneYFOYkt8OOkEPrT98nmUyGTcaJzOXdLl5U/i7Iu8dROMO4bQFQyAY7EagD/P2G5nfQ
         ETtQ5JSt0ZAusVmGvRmgquRrSQ5Ao5q0dwglFqVgae/XtknUpOJV18Q92H+y/PUWLyia
         5jEFV4iwkjC/Prgx6/fmYUVr4xHCLfVyOEtaggXnwIV3KDMWrlJJyoHbMVFovansiWYv
         baYw==
X-Forwarded-Encrypted: i=1; AJvYcCWKs8HM7AN68xE4hJho0jQKTEpigG439i3V/YM4St2nBIH3bijpBcpXu7mDggA9rZGV5OSQgVtJ+ngAGjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeBVFPc+TImCpaYyvqjoovCtH1chBtDl/oxQMoCNZYfJkXxSj7
	valLVGQUAizZCAiWuXrq324XedUeGDvEIaiDfFxe/9G2ukURMIBZ09EQ9zFcgDdzTY9VujxwDMy
	kiW8=
X-Gm-Gg: ASbGncs7XOwhk1NM+szD9HYPt3350ScsNe/bz5RsJqDQxH5UalDJxzOtcXKDOP6JMlf
	QtWmewO+pMiwgCrNNyd1UmEFNhMzMjjA5HqY9mruh6q6rjFzg1np2qiBuEusPtywoxRPBxVkWWv
	4BVWzoqIjZWoDEOLqvRjHClcX6TPAsiy/hmn2IznK9lvKgQmh7huAVUrsBGjauLZvx61GfNiMjt
	5+BkTJdCD6kFph3cV/JEsKGCwUv/im+QwoXoFwb1XH5SG1WvbIH8VG+7BmtMLgAE43rhr9Fs72G
	e0W45t6qF7bbb90JewsjR0xFiFyGGjIMLKRLcX8gSU5Hj3kgf5AtX+tHn8SU3a942amFgzhRyCY
	9UXRHfBaoWLzFIOEcmgM=
X-Google-Smtp-Source: AGHT+IF1XhwKDV1Bav4JUZFc55VomsKzUYb17r978IahiZBdYS+4Lge+HrjRZBZNnZ+TABeT8jU/fw==
X-Received: by 2002:a17:907:1ca3:b0:ac2:d1bd:3293 with SMTP id a640c23a62f3a-ac3301e34c8mr645593166b.19.1742063500115;
        Sat, 15 Mar 2025 11:31:40 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147f0ecdsm399430766b.73.2025.03.15.11.31.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 11:31:38 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac289147833so556465166b.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 11:31:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxjKfZW4VJdZVhEaEQbk1iK4GCUwpuiCN8bOZg/cmaLVkaKxbXbTVPfaS9C3teQKGcPBTXmWjkTx63xY4=@vger.kernel.org
X-Received: by 2002:a17:907:6e8d:b0:ac3:47ad:41e8 with SMTP id
 a640c23a62f3a-ac347ad42e1mr292577866b.1.1742063497897; Sat, 15 Mar 2025
 11:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315025852.it.568-kees@kernel.org> <20250315031550.473587-2-kees@kernel.org>
In-Reply-To: <20250315031550.473587-2-kees@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 15 Mar 2025 08:31:21 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiFjwOk9knz8i-zAqE=Kc73+3TgkMuj-C_mNB1U=k2W7A@mail.gmail.com>
X-Gm-Features: AQ5f1JqnUqw5FSbsGnxD4hWFlYlctW64jtsJobEgwKJ2Lw8II8J0HunpM362-9I
Message-ID: <CAHk-=wiFjwOk9knz8i-zAqE=Kc73+3TgkMuj-C_mNB1U=k2W7A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] slab: Introduce kmalloc_obj() and family
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marco Elver <elver@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, 
	Tony Ambardar <tony.ambardar@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Alexander Potapenko <glider@google.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 17:15, Kees Cook <kees@kernel.org> wrote:
>
> Introduce type-aware kmalloc-family helpers to replace the common
> idioms for single, array, and flexible object allocations:
>
>         kmalloc_obj(ptr, gfp);
> [ ... ]

Honestly, I absolutely hate this.

Don't do this. It's a huge mistake.

Yes, it's a really easy and convenient interface to use.

And it's a ABSOLUTELY HORRENDOUSLY BAD interface to actually then *maintain*.

Why? Because it's simply visually and syntactically entirely wrong.
It's much much too easy to miss that there's an assignment there,
because the assignment is hidden inside that macro that visually looks
like a function call.

So when you scan the code, the data flow becomes very hard to see.

So no. A hard NAK on this. It's wrong, it's bad, and it's crap.

Maintaining code is AT LEAST as important as writing it, and arguably
much more so. And making code and data flow visually clear is
important, and this is actively detrimental to that.

So I understand why you want to do this, but no, this is absolutely
not the way to do it.

It needs at a minimum some way to make it very very visually clear
that this is an assignment to 'ptr', and honestly, I do not see how to
do that cleanly.

Alternatively, this might be acceptable if the syntax makes mistakes
much harder to do. So for example, if it wasn't just an assignment,
but also declared the 'ptr' variable, maybe it would become much safer
simply because it would make the compiler warn about mis-uses.

Using visual cues (something that makes it look like it's not a
regular function call) might also help. The traditional C way is
obviously to use ALL_CAPS() names, which is how we visually show "this
is a macro that doesn't necessarily work like the normal stuff". Some
variation of that might help the fundamental issue with your
horrendous thing.

But something very serious needs to be done before this is acceptable.
Because no, the advantage of writing

        kmalloc_obj(ptr, gfp);

instead of

        ptr = kmalloc(sizeof(*ptr), gfp);

is absolutely NOT worth the horrendous disadvantages of that
disgusting and wrong syntax. You saved a handful of characters, and
made the code faster to write, at the cost of making the result be
much worse.

My suggestion would be to look at some bigger pattern, maybe including
that declaration. To take a real example matching that kind of
pattern, we have

        struct mod_unload_taint *mod_taint;
        ...
        mod_taint = kmalloc(sizeof(*mod_taint), GFP_KERNEL);

and maybe those *two* lines could be combined into something saner like

        ALLOC(mod_taint, struct mod_unload_taint, GFP_KERNEL);

which would stand out visually (which is admittedly very different
from being "pretty" ;), and would also save you some typing because it
also gets rid of the declaration.

We allow declarations in the middle of code these days because we
needed it for the guarding macros, so this would be a new kind of
interface that dos that.

And no, I'm not married to that disgusting "ALLOC()" thing. I'm
throwing it out not as TheSOlution(tm), but as a "this interface
absolutely needs clarity and must stand out syntactically both to
humans and the compiler".

          Linus

