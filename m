Return-Path: <linux-kernel+bounces-276692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D25949719
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB361F21E72
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558657347C;
	Tue,  6 Aug 2024 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W+ZUt7zt"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BFF2A1C5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722966622; cv=none; b=s0Ww6bY/aBPE/rW6HrWkQQPyr6Q1BSAvWJCa+u299o8gunEUsyzv1sUMHbnrnN3IjV8a655r+dQB2pv52ZXn/kVnSekLS8gr8MGYvG6JMSWKB5EUkx8HZ4JxauZA1n3WCyRWFpbCMUJSnMHnxKqDAMi8bqBK3+Lk7REwVWhUufQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722966622; c=relaxed/simple;
	bh=55LuJW7aLxHedglkTrjEuWqkrs4/0wc54LyvDSYDHO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+WZ4qwhWFBbklxX1aUGWJkW9hGGm4kPtyYdx0B1YGLwYdYnDGiPbl13X8frbmkD/gXa5OmJ9nmPPy46nrm6mYsRRI7GpdUZc/0z8kSM9B6akdA0nG6EphmQuXCHQO8Kr3bBXnkEFX+LKiMGmQ3mKV2+RX/xfDyLtPwkS/Kn1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W+ZUt7zt; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so1055407a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722966618; x=1723571418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z0zMo04KKh0y+kNNC4Vm6QM8kJTTcnqycTCj7GXfBl0=;
        b=W+ZUt7zt43INU2rTG9dkaxXnzo0sc20c+AnHIh7Z0VEtLvPUeqxlEofbgK1D9P5G8y
         xPeqMhxFAHMJY5oYczNl8Q+k6hkpW87BxNEZZOXyjbBwS38T1JmlwZZ3pG9L7AXCsFsB
         vX5Tb6VRJ45n45o4zbua7Jvdx2Jf40qw6eQ2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722966618; x=1723571418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0zMo04KKh0y+kNNC4Vm6QM8kJTTcnqycTCj7GXfBl0=;
        b=K02YKNkpz8Pe0KT0O97I71W77+k3VCxQCI/ItAcJPoaBtEBmeBC1Y16U3WfbJYxkqG
         LnFBBlCpmqNlFyI/5pU/hD1JDgxWJa8w+rpqhPdDlAkQkDYhZ8bpPff0EpErd+6frmsP
         M6h6dJ8zhvXNspsx9ZmR22TJaUkUAnYjCFCCfqT4hwo7JOvtQwYJxWYx3cUvjehSgfI2
         jt/8oaS9KrLffcZrPZvq9CVbkeVnhcyZYEP5gApdEcpWRdJWIhwtgcM0jvR2axw+RCgY
         EI3whZgRvRD2ZUfK1LWU3ExShIlg+QWt+Nyv5VOOzLGkrMI8FxoCSEwnffvlEHhvS4Gj
         NcGw==
X-Forwarded-Encrypted: i=1; AJvYcCX4uMQUcWZEUMshzPu6fNFyhTnZpLqnrh0RqL/vA+tc44AE194kbc+isEpCNeQS9McQ3gF2WRE/WO/4aEQtfHydxPdPke8alYo9D+bb
X-Gm-Message-State: AOJu0Ywu11VtwWMLYo3y1r+nSeXRGqWqxNZuzBG3RZlOZ33IsM2e2o1c
	1uy38MHCqL1WRrm2siiAZXjblqsdwU/Xst4M7OzNPokYOj15TkHSxfcW8IMRtrwYVaOIBEJsN3n
	1vxq92Q==
X-Google-Smtp-Source: AGHT+IFevHAZw+EXOdgU5yeDJET/n7B7wXxuAcjZIgCZboGK1zNXeciLQcaTb4rWOfC6ivDfiZSvhg==
X-Received: by 2002:aa7:d755:0:b0:5a1:7570:8914 with SMTP id 4fb4d7f45d1cf-5b7f3cc6926mr11099645a12.11.1722966618169;
        Tue, 06 Aug 2024 10:50:18 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83960f26bsm6149303a12.14.2024.08.06.10.50.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 10:50:16 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bb477e3a6dso1120872a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:50:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJ1DULxgcgy1lEqINOpgDxMPI7deexOTnDpslc1Hcyx0BMd8zkajBQzYxkopH4aMuQd1ZlVhH5a61f/VW1PyxbsgYLnHDkYzpoqRzW
X-Received: by 2002:a17:907:9715:b0:a77:cacf:58b5 with SMTP id
 a640c23a62f3a-a7dc4da659bmr1188256466b.1.1722966615960; Tue, 06 Aug 2024
 10:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731095022.970699670@linuxfoundation.org> <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <f63c6789-b01a-4d76-b7c9-74c04867bc13@roeck-us.net>
 <CAHk-=wjmumbT73xLkSAnnxDwaFE__Ny=QCp6B_LE2aG1SUqiTg@mail.gmail.com>
In-Reply-To: <CAHk-=wjmumbT73xLkSAnnxDwaFE__Ny=QCp6B_LE2aG1SUqiTg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Aug 2024 10:49:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiss_E41A1uH0-1MXF-GjxzW_Rbz+Xbs+fbr-vyQFpo4g@mail.gmail.com>
Message-ID: <CAHk-=wiss_E41A1uH0-1MXF-GjxzW_Rbz+Xbs+fbr-vyQFpo4g@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Guenter Roeck <linux@roeck-us.net>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	Linux-MM <linux-mm@kvack.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

[ Adding s390 people, this is strange ]

New people, see

  https://lore.kernel.org/all/CAHk-=wjmumbT73xLkSAnnxDwaFE__Ny=QCp6B_LE2aG1SUqiTg@mail.gmail.com/

for context. There's a heisenbug that depends on random code layout
issues on s390.

On Tue, 6 Aug 2024 at 10:34, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. Do we have some alignment confusion?
>
> The alignment rules for 192 are to align it to 64-byte boundaries
> (because that's the largest power of two that divides it), and that
> means it stays at 192, and that would give 21 objects per 4kB page.
>
> But if we use the "align up to next power of two", you get 256 bytes,
> and 16 objects per page.
>
> And that 21-vs-16 confusion would seem to match this pretty well:
>
>   [    0.000000] BUG kmem_cache_node (Not tainted): objects 21 > max 16
>
> which makes me wonder...

I'd suspect commit ad59baa31695 ("slab, rust: extend kmalloc()
alignment guarantees to remove Rust padding"), perhaps with some odd
s390 code generation issue for 'ffs()'.

IOW, this new code in mm/slab_common.c

        if (flags & SLAB_KMALLOC)
                align = max(align, 1U << (ffs(size) - 1));

might not match some other alignment code.

Or maybe it's the s390 ffs().

It looks like

  static inline int ffs(int word)
  {
        unsigned long mask = 2 * BITS_PER_LONG - 1;
        unsigned int val = (unsigned int)word;

        return (1 + (__flogr(-val & val) ^ (BITS_PER_LONG - 1))) & mask;
  }

where s390 has this very odd "flogr" instruction ("find last one G
register"?) for the non-constant case.

That uses a "union register_pair" but only ever uses the "even"
register without ever using the full 128-bit part or the odd register.
So the other register in the register pair is uninitialized.

Does that cause random compiler issues based on register allocation?

Just for fun, does something like this make any difference?

  --- a/arch/s390/include/asm/bitops.h
  +++ b/arch/s390/include/asm/bitops.h
  @@ -305,6 +305,7 @@ static inline unsigned char __flogr(unsigned long word)
                union register_pair rp;

                rp.even = word;
  +             rp.odd = 0;
                asm volatile(
                        "       flogr   %[rp],%[rp]\n"
                        : [rp] "+d" (rp.pair) : : "cc");


Thomas notices that the special "div by constant" routines moved
around, and I'm not seeing how *that* would matter, but it's all
obviously very strange.

              Linus

