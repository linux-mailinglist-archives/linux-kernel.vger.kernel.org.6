Return-Path: <linux-kernel+bounces-178136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 023218C4989
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 00:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D28C1F21A75
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE93184D05;
	Mon, 13 May 2024 22:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FuEd38Yl"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1835B84A53
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 22:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715638394; cv=none; b=UFlH13Uej5xPwd6FMWEew5r8l5r6FDkQMbQxVbE5ZyaYUUgS/qEcJFeaFANbIo/LpdclisRcZ0k27c0WdqbmUXc6L5SssTBh8tQyT8OU7JGbygFkh0vntS/zvSf2/XcVn59FGZ/O9zrUk6/a1mCoa/4jBXciXaNLCnnvzzd2ywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715638394; c=relaxed/simple;
	bh=kd7mGogZ8Fm6S2jihTGjWVAjQyjfhfYYNYzr2e886ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucOUC++ODyKvuexPGuz80z0bxVHyUB6SDh79DV44fMz5h4J1RzTWsqtOSPhJGplH3W4r803sS7NozpwHKK5XQ/2cnDXIrDOCTBxqLMLq3IlU+NuWAH0Bci/cBf70UHbFKpQ5igdcvtUBhC+6JmVsxxB/Fr6N5RnnrO2iMmaJlK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FuEd38Yl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59a934ad50so1155586666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715638391; x=1716243191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ps+jWjBcJqtAnfvkCrJQhLLxq6+xUCZXu8MlaxS7yCo=;
        b=FuEd38Yl+T9l+EPYhb+5aWa/9EZG9pv2mHpqvHJ9WAzDqsspyGdF8+TehMhERzi6OV
         OFgrDUsagks92fQ718MNtg38+N1TTygyk0j2qu2xN6w20MtaDPdiRheIpkYHVA28V5I8
         VjRWjogTt+pka6Pi4pP86pncBCBKrFM9HkEnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715638391; x=1716243191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ps+jWjBcJqtAnfvkCrJQhLLxq6+xUCZXu8MlaxS7yCo=;
        b=hHgd5OqNn2l3uRbPI6R3q21Cyg2pkKECgt2YUtQdG+WxOb41hd1Y+MSInMmbeeH4Iq
         U0OVzIuKPZENPo+VcY5iPygytW5mkABvPC7wQ8g2qYk1AezoB61wluiDmHrprxUSOIha
         BQ6MqGeWHiSBJ19gx85KHMey+SiHIEgf9/D/eKByyq1g51GJ/qwSCT9/5gzOpcZc/FaC
         k6mjYUZlIGteb6AZgFj2ZaT2zkf4HSD50KzKh1v0iPuBwfl1VG9mncLj5t1kJptAitZS
         XFV2m5LubSLpoY5X0JF6Bx6PKV0bSHecuLGjVStPQ7Cn7RVSck6RBtAR3PIvGvNxVYEm
         ENFw==
X-Forwarded-Encrypted: i=1; AJvYcCWkcTTIif/SG5hijgrYNRczbN5rd2+p+ifrOCTiLErqaWEmL0nvSYsvbyFZaSVst71SY29em5D0nWOmiue/D3OL0hAriaYWEKkMw/OP
X-Gm-Message-State: AOJu0YwzIKR8iKxwPS3GttofQIzlG8NFCmb1NKbBjl50GQqpNAq/EFzu
	m6Bsb7zI3O63TVUuA4KAhBTnGd+YmvBte+GRJ+gMFS7LnQQCj4+Nks4BSa4df/co/6DuyiNbYQj
	md4P4Xg==
X-Google-Smtp-Source: AGHT+IFy2hfFFAqQBoPXFpVOzsqO05gft61p5rpwgCnYnNF2m3c7uCbv3D3RZ/lWnjhH9rYAy5cnZQ==
X-Received: by 2002:a17:907:720c:b0:a5a:5cb0:e58a with SMTP id a640c23a62f3a-a5a5cb0e6f6mr395153866b.17.1715638391267;
        Mon, 13 May 2024 15:13:11 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7f32sm648220666b.106.2024.05.13.15.13.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 15:13:11 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a599c55055dso1262894266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:13:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWuaxREjY8R8F457yWP75CCzkqTgKpZwR4l9JZtsxBlFeeDEH8t3uG5gY6h1FNHiGjgf9tLE+7GFIakA0AMme0LaNf+clwSb1tnqb3h
X-Received: by 2002:a17:906:aa4d:b0:a59:c23d:85d8 with SMTP id
 a640c23a62f3a-a5a2d6653f4mr737764966b.51.1715638390051; Mon, 13 May 2024
 15:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Yui+kNeY+Qg4fKVl@gondor.apana.org.au> <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au> <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au> <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au> <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
 <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au> <ZfO6zKtvp2jSO4vF@gondor.apana.org.au> <ZkGN64ulwzPVvn6-@gondor.apana.org.au>
In-Reply-To: <ZkGN64ulwzPVvn6-@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 May 2024 15:12:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmwmWv3sDCNq8c4VHWZUtZH72tDqR=TcgfpxTegL=aZw@mail.gmail.com>
Message-ID: <CAHk-=wjmwmWv3sDCNq8c4VHWZUtZH72tDqR=TcgfpxTegL=aZw@mail.gmail.com>
Subject: Re: [GIT PULL] Crypto Update for 6.10
To: Herbert Xu <herbert@gondor.apana.org.au>, Lukas Wunner <lukas@wunner.de>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 May 2024 at 20:50, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Lukas Wunner (1):
>       X.509: Introduce scope-based x509_certificate allocation

I absolutely hate how this commit tries to remove one single compare
instruction by introducing a *very* dangerous hack.

The whole 'assume()' thing will generate actively wrong code if that
assumption conditional doesn't hold, to the point of being completely
impossible to debug.

Having random kernel code add random "assume()" lines is absolutely
not what we should do. Particularly not in some random code sequence
where it absolutely does not matter ONE WHIT.

Now, I've pulled this, but I killed that  "assume()" hackery in my merge.

Because there is no way we will ever encourage random code to make
these kinds of patterns, and I most definitely do not want anybody
else to try to copy that horrendous thing.

Yes, yes, we have "unreachable()" in other places, and yes, you can
make compilers generate garbage by using that incorrectly. But they
should be about obvious code warning issues, not about "let's save one
conditional instruction".

Now, if somebody really *really* cares about that one extraneous
conditional, particularly if it shows up in some more important place
than some random certificate parsing routine where is most definitely
is not in the least critical, there are better models for this
optimization.

Maybe somebody can teach the kernel build in *general* that
"kmalloc()" and friends never return an error pointer, only NULL or
success? That would not necessarily be a bad idea if the scope-based
cleanup otherwise causes issues.

But this kind of hacky "one random piece of kernel code uses a very
dangerous pattern to state that some *other* piece of kernel code has
particular return patterns" - that is not at all acceptable.

Put another way: it would probably be ok if the SLAB people added some
"this function cannot return error codes" annotation on their core
declaration and it fixed an issue in _general_.

But it is *not* ok if random kernel code starts randomly asserting the
same thing.

Quod licet Iovi, non licet bovi.

                 Linus

