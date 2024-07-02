Return-Path: <linux-kernel+bounces-237148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFC391EC78
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 03:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BFA9B209C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 01:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E671747F;
	Tue,  2 Jul 2024 01:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JNHHq05y"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534473C38
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 01:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719882860; cv=none; b=cvOCWbI/U6o1tbtBVA9YxFn10Y7EVsiwktwZP1g6bC5kaCzfT/ARd0MOf7pNsrMoMsrudhf+HjiG6L9u4LAuwiBgHbEnQwH/NK6MJXGqFRpj6ZQN45oNxZ0LIxDDc3IuhQyhaMg22ZBldQTaTuIoEf3a/NWX7/RWBFF5nJNCEiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719882860; c=relaxed/simple;
	bh=QelD7l9K3MLiRKSI3TmOQlwu0oOf3H1O5UiFoI9SNy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkBpiWgEbtw0Tk6CuzKIeipgqRTcY1YUwtdzwebCJG0AYj0cZFGZpDi0E0foWcDtUVSCDRqSmxTiYTGZo4+tZalhrrNQKYKQQKknwW2ifvmmL88xQipgtLp8FSREQ3EFQECOD9nv4UQFbDMRpigBpIRIAdnyVKCtrn2H3wRhpTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JNHHq05y; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cd80e55efso6319600e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 18:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719882856; x=1720487656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IIiH8RHFlYrKhFK2Fs5cxJSZlfpFxlG2qGiEMGvL3oo=;
        b=JNHHq05yxvgSnmnxT4xbTiVlsCfo5fhR9RrJslVUHsY7s4CW7J+zr0MVfl40z7ECo2
         6RP9ZESJKdguVNwO+Hz0YDHYIXzSgUL0Lu2yh48Nk85isAoB+AIMhfB43UmIbUcLqQQB
         VXLbWqpyxIeO2c61jyXvCLGdrNuPpHfPWLyfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719882856; x=1720487656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIiH8RHFlYrKhFK2Fs5cxJSZlfpFxlG2qGiEMGvL3oo=;
        b=Axmep1S5LEgvBto7z+rgDrfwJnWz6GGw0NQ5oMJ6+x98gcytpoNKviI8M9Mgewiu3C
         1MO8/5UYfnKfAJA6bPXWhypH3ufMhtihWshl2mTVFI6YC2cZ5PFMnfjrgIaCb7Wq86hI
         Z6DAr7vRbWpI26SDtF6DFKaY3LyThDKtzjZldKrc7IeLI9WId+MHTKLHwK+2AiG+hvNa
         sd/ZnpkEZ7mQv+ylS4+NXzLZl24nvoZG1Ftn0A2GaQj+4C09v3k+gy0vUOeFskqyTxrY
         QpaNNrTh9q+A7HwJy8LUtH58Hx+SR2Lzf5BbzxAXPV5AbDOA2kIsh74/J+5f28GJwH4w
         7njw==
X-Forwarded-Encrypted: i=1; AJvYcCXnBmbylAfYz7rWMnniPTURU0aDEPeU5xKiMYd+AC4yt8kZ/EQGFukwyI7rXK6/A2ACPeP/oRmgErAqZbABu2RmIZZdL8f/X/WN9jRg
X-Gm-Message-State: AOJu0YwZmWS1mkcUbdR5/Jf9mt4Hr22r1AS9Eh8L8lp7qbPYBkjdNSvk
	s/7bOMm+ogBx6xPn//8wDkfEjiSTIC/wxTee1omZriKWqG5dvvlgosqqOGkGbVYcqlQCXpOmucX
	1vltLyA==
X-Google-Smtp-Source: AGHT+IHwKW3X4+AXy29wn1PPcwdHP0thN+lIo3cPlO9DXxJ4LZ7aLHTb0Yt4meAI3noOGoRFcH2v+g==
X-Received: by 2002:a05:6512:b11:b0:52b:be6b:d16a with SMTP id 2adb3069b0e04-52e82686b4dmr6645089e87.31.1719882856266;
        Mon, 01 Jul 2024 18:14:16 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab0b889dsm378357866b.225.2024.07.01.18.14.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 18:14:14 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3629c517da9so2910699f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 18:14:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcfbt+rHZQrY4xka4EQgKyvKLdGm9YU4Xp7H5CA3gOtpJtMj/LDRgs8jiORW4SVSFnhQgwPMFZS6P3sU3RHW/HwXUFXzjK2wICvBo8
X-Received: by 2002:adf:f390:0:b0:366:f74f:abf0 with SMTP id
 ffacd0b85a97d-367756a8316mr4903766f8f.16.1719882853953; Mon, 01 Jul 2024
 18:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503081125.67990-1-arnd@kernel.org> <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de>
 <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk> <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk> <4bb50dc0-244a-4781-85ad-9ebc5e59c99a@app.fastmail.com>
 <CAHk-=wimJ2hQhKSq7+4O1EHtkg7eFBwY+fygxD+6sjWqgyDMTQ@mail.gmail.com> <alpine.DEB.2.21.2406302009480.43454@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2406302009480.43454@angie.orcam.me.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 1 Jul 2024 18:13:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihNu+_bGwD8F107ds7Lv1Z6ODTwvYYvXeW3im1=4R65w@mail.gmail.com>
Message-ID: <CAHk-=wihNu+_bGwD8F107ds7Lv1Z6ODTwvYYvXeW3im1=4R65w@mail.gmail.com>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Arnd Bergmann <arnd@kernel.org>, 
	linux-alpha@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
	Michael Cree <mcree@orcon.net.nz>, Frank Scheiner <frank.scheiner@web.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 16:48, Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
>  Looking from today's perspective it was clearly a bad choice.  However it
> was 30+ years ago, it wasn't so certain as it is now that x86 was there to
> stay

No.

The thing is, it was objectively the wrong thing to do even 30 years
ago, and has nothing to do with x86.

The lack of byte operations literally means that even _word_
operations aren't reliable.

Because when you emulate byte operations with quad-word operations -
which is the way the alpha instruction set was literally designed -
you mess with the adjacent word too.

So even word accesses aren't safe. And I'm pretty sure that
'sig_atomic_t' was just 32-bit on alpha (that's what glibc had, and
I'm pretty sure OSF/1 did too). So...

And that's an issue even just UP, and just completely bog-standard
POSIX 1003.1 and C.

You really can't get much more basic than that.

So supposedly portable programs would have subtle bugs because the
architecture was bad, and the workarounds for that badness were
incomplete.

SMP and IO - which are a thing, and which were things that the
architecture was allegedly designed for - are then only much worse.

The architecture was wrong 30 years ago. It's not that it "became"
wrong in hindsight. It was wrong originally, and it's just that people
hadn't thought things through enough to realize how wrong it was.

The only way it's not wrong is if you say "byte accesses do not
matter". That's a very Cray way of looking at things - Cray 1 had a
64-bit "char" in C, because there were no byte accesses.

That's fine if your only goal in life is to do HPC.

So if you simply don't care about bytes, and you *only* work with
words and quad-words, then alpha looks ok.

But honestly, that's basically saying "in a different universe, alpha
is not a mis-design".

That's not the universe we live in, and it's entirely unrelated to
x86. Bytes were very much a thing 30 years ago, and they will be a
thing 30 years from now even if x86 is dead and buried.

Basically, the fundamental mistake of thinking that you can do byte
operations by just masking quad-words screwed up POSIX compatibility,
screwed up SMP, and majorly screwed up the alpha IO layer too.

And by the time it was fixed, it was too late.

Don't make excuses for it. It's not ok today, but it really wasn't ok
30 years ago either.

It's ok to have rose-colored glasses and have a weak spot in your
heart for an architecture. But let's not make that weak spot in your
heart be a weak spot in your mind.

            Linus

