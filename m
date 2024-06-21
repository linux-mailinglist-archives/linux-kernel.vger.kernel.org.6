Return-Path: <linux-kernel+bounces-225314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEE2912EFB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6028928150D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C046B17C201;
	Fri, 21 Jun 2024 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WAp6Exow"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE817BB1B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003228; cv=none; b=GipWQWNben7MjFblQdNuHREHcCNBDJ21Q2lTHr7hYBooKH3ASy12pPqcwDSoqUVsC+spCyuVVuzn+GIm6l2JJ5e6X2i8FYdiUaTQJJPawP8W06P4lpqjWabmkonIV0C8kW3cpz7P03APeXJXjooX2Qsq/kAg37pEfhOvsksI5bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003228; c=relaxed/simple;
	bh=YWZe1Lj9Vz+tStN44K7jpQj+Z+3vyQq0YL6FgPpbD54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHw6HCwZPlij7BzolZ+TAZl/Q+/wkpmKndNCTyAa5zbAJxo8ewMwHDLAVA4IFYQWztGRKoZLImh2LGBqLCCHodBRdQrlrenzgPpqHQvNtnZGVqBrh+Jqte7a2NmCvGSEvP5fUBVFbx/VLL83jP7Py3haZaWZ9/4QQfh11g4XUMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WAp6Exow; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d20d89748so2459001a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719003225; x=1719608025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aka5C4EsbSufYMzFLVzRVqI0mEYp4vGgv996ytXzems=;
        b=WAp6Exow6AXYRoHPkRJ3Fh7gJ4SCirvZ5zyKEj8FGexUA1LZZltt+353sJ/5xiD1e5
         ntLXjGA1Gox1r82TlymHsCrxIn+RgKez/z509adeqAEt/NIRo18BBMGsjHNf9o+EjQGb
         wQJ1oF1ULwt/CWaQtdGxBpE88iElTCYpVSu9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003225; x=1719608025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aka5C4EsbSufYMzFLVzRVqI0mEYp4vGgv996ytXzems=;
        b=IZfmaOHZiuwk97x6W7pwnFlAObsGiUDzYHliu5Dhf6CJDMvmgJ+Uz9NxICVnbu5B4d
         ci2BnEbD8zeS6THrx+JvUbJqP4P2Ua/dnSckZN9sGkecDL+gPRHNQNZAR8di3x2KF5Jf
         +4wJXqcVpH5WUFJ+44y+OXSwbj32J3TUoatLFkQxsip1jhEL3IRkCqG/ky+gAv52BO+k
         L6nYI9GnqP8U6lXosFNamAuneqY5Ii3hXmjaBbA+7XmrriflVOIOyQEzqrMBqBwTLztU
         ewX0X5bPiJkuPGMVAyghB9XnqrS/5CKNMBiqU9NnagrZ/kAPePElOhPwmOvgVz2uLsU0
         Qi7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJhZfo+3lPW2P9p8PJvlxvq0yGq3JBH9Z1nfKck74pWQ7f4hIQ9YOIPQn2iMle5QsD27wpFJzvHyS9tUcswd0rvaZAq6NKWNiAElxh
X-Gm-Message-State: AOJu0YwcHrfDqq3hM4lQs3eSLaGW80n4yG8TFoTLXc5iMi54TsntJJ86
	2li3yjcd0Wyfi5YtUivxWsfq3sQCTZyakTynAXRH9bqEGg9DLjHW/r9h36gFUGrgRU57HjUs66k
	wCUU07g==
X-Google-Smtp-Source: AGHT+IGSqQdsfwRD2DlSx8kUoKxB3rOx/FQiCX6voECL0TtWAkd/mTW3yd2xGBA4rN1r9ljaW16IXA==
X-Received: by 2002:aa7:c392:0:b0:57d:107e:dd79 with SMTP id 4fb4d7f45d1cf-57d107edd96mr4608507a12.26.1719003225107;
        Fri, 21 Jun 2024 13:53:45 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30563440sm1391186a12.84.2024.06.21.13.53.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 13:53:44 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d06101d76so2572871a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:53:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUykhkLyoKeW4ef4g9tmpjPOXaWLapiD3bF+VY2FtlExk4v/MZ38dU3e8U3giSbKXUdmveRkVedy53YR0t1ppHaPLtoji7+xXPz21JW
X-Received: by 2002:a50:cd85:0:b0:57a:322c:b1a5 with SMTP id
 4fb4d7f45d1cf-57d07ede1demr6003602a12.38.1719003223715; Fri, 21 Jun 2024
 13:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
 <ZnNDbe8GZJ1gNuzk@casper.infradead.org> <CAHk-=wi1zgFX__roHZvpYdAdae4G9Qkc-P6nGhg93AfGPzcG2A@mail.gmail.com>
 <ZnXc2qDZsZrCIxSQ@casper.infradead.org>
In-Reply-To: <ZnXc2qDZsZrCIxSQ@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 21 Jun 2024 13:53:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrwcJVBJjjqD4cMrYhH=A-fmD0SQJyW7r7noyQAXnBSg@mail.gmail.com>
Message-ID: <CAHk-=wjrwcJVBJjjqD4cMrYhH=A-fmD0SQJyW7r7noyQAXnBSg@mail.gmail.com>
Subject: Re: FYI: path walking optimizations pending for 6.11
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 13:04, Matthew Wilcox <willy@infradead.org> wrote:
>
> What I was reacting to in your email was this:
>
> : And on my arm64 machine, it turns out that the best optimization for the
> : load I tested would be to make that hash table smaller to actually be a
> : bit denser in the cache, But that's such a load-dependent optimization
> : that I'm not doing this.
>
> And that's exactly what rosebush does; it starts out incredibly small
> (512 bytes) and then resizes as the buckets overflow.  So if you suspect
> that a denser hashtable would give you better performance, then maybe
> it'll help.

Well, I was more going "ok, on the exact load _I_ was running, it
would probably help to use a smaller hash table", but I suspect that
in real life our actual hash tables are better.

My benchmark is somewhat real-world in that yes, I benchmark what I
do. But what I do is ridiculously limited. Using git and building
kernels and running a web browser for email does not require 64GB of
RAM.

But that's what I have in what is now my "small" machine, literally
because I wanted to populate every memory channel.

Not because I needed the size, but because I wanted the memory channel
bandwidth.

IOW, my machines tend to be completely over-specced wrt memory. The
kernel build can use about as many cores as you can throw at it, but
even with multiple trees, and everything cached, and hundreds of
parallel compilers going, I just don't use that much RAM. The kernel
build system is pretty damn lean (ask the poor people who do GUI tools
with C++ and the situation changes, but the kernel build is actually
pretty good on resource use).

So the kernel - very reasonably - provisions me with a big hash table,
because I literally have memory to waste.

And it turns out that since _all_ I do on the arm64 box in particular
(it's headless, so not even a web browser) is to build kernels. I
could "tweak" the config for that.

But while it might benchmark better, it would likely not be better in reality.

I'm going to be on the road this weekend, but if you have something
that you think is past the "debug build" stage and is worth
benchmarking, I can try to run it on my machines next week.

              Linus

