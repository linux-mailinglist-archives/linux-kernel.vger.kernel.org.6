Return-Path: <linux-kernel+bounces-527889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8E9A410E7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E61587A3210
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C3917C7C4;
	Sun, 23 Feb 2025 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Enu4E3fK"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E712DD8A
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740335531; cv=none; b=oygIXCIncWtci0wzzUF33F79FB1VcRzMi5G5vEikb2iN5rUkR5LrAx2Rgo+L9Y54JqWn1DroXLvyxJI9OBsUY6FLwxu74YmAOA8BJEJvRdot+WnF+hOjC0VT+QG2ihs3288VjfprpVyub9neYRBso7T9hxHH0nY7z0sGKA6uPqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740335531; c=relaxed/simple;
	bh=F16gjWpfzILm5UlOwuP2B/0g3980gm949Ip5/wshaZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhvjX9cE6JUX85tBZLkGRjjkNkX8nvBtWU2CzLyLcXlLEg0F/F0H5TlXcqww1KyeT4BcNAB2oPntt/RBX5pkWaVoPxouqZmcBkpp8xL7EqVQTlPX3BLA0HJTTNg4QOmP94fPms86eB4rKqSgTSabBMaQxIU9MmwqUt3T8XdzO7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Enu4E3fK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abba1b74586so556761966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740335528; x=1740940328; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TcuxBHhEa12WEoosMAkaHe0om9pJLB2v6SQU4kBUAzc=;
        b=Enu4E3fKlTtoNzbrJIGZ66Bab7/81XXpCSfkUUtO4gHWsUTNioWVW33512Smxpf2aw
         X5EynUed4N7Fa5x8cB5uUuoUuLWoc9x+Z5e7L+5IYvJtGCzQBD+vKXsYt4oVOgjn3AmK
         SHw8sxkOaR7wr5kPfTP8M8LkrI+/4dSPtp398=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740335528; x=1740940328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcuxBHhEa12WEoosMAkaHe0om9pJLB2v6SQU4kBUAzc=;
        b=LeB2V0IZEAI5yuSFUkX8pKaHQs9AbYLxYczTceOMBy+fHWV7rZ+MX/jAfDTg7cx4Xp
         ZcSznQXt+e6scvGe3kyrad3vlY6sgNRrX6a7YJ/OGPNY0Ejkm/t+rX4P4JuL8KK86RrP
         uB4Ej6CFfwzFCJ9cRXmJJAYVsqWN0hTfiNb6nrFIvIHsC0ryesc2+x5sADivZwoyqh6V
         3tAp4QWe7YllSPtCs58kQEwSLu/2jjGXkw+F46EJ/WICFAfEvDT1j3otkYza9bT7hW8j
         eEcDZ6WxpdJ3Kj2HWHoXioVErY8vi7I81wLycEWaUJujISmtlsoUdDr6F1wJP/2mMloM
         OAuA==
X-Forwarded-Encrypted: i=1; AJvYcCUnYkU+B90D2vW/dYF+JN3x+bnLhniw+n4hbXNs31ivgkpJrzMft6iQB+dZ4TLn6IkQvLkaiqH6ah2aLG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxayzYg5Qrzvg5YyB23xg+R2RVK+TmP+xcw+TqbGPPX+t1iG0he
	hGZViH92QoVc3YEDbYFhEm4JhjwLVwzWcuuuy5VMbXtmjeDjjD7X3v/qRdHA5JG0NOMzaPOzGu5
	ZtJU=
X-Gm-Gg: ASbGncuPJ6UGZk1Gjw56YceshxbzR2rMXnhqQVxElT53M3uYgdu/Yj2JHxSmI1ItEQa
	0HfqEkpcDSgFdJc/55RiwlqR2eb10Q357vmQXJVY45D7uCZyul6hpYGyC/2NJkZJXs6Y/twvKh3
	0MFFsEGA9qm9LL+kuhDdAgzIrD3e85DiDEnqAY2pUIQrYqrbjOhD0fgxFzDl/587R7ORIo1N7Om
	ij5JdWlWWtnp6ZZq520D9WI6YhPEhdb4FBw4qL37fP4ITv/pbEh3nteEQJ4PT3fNXzzE9aOkOhI
	sMb21bI4EcH35uw5PtzM2lv2neMGuYMKWRfowPMs04r8rlLDEeY3IiFRXHIyf3YdDs/dCGRHTLI
	Y
X-Google-Smtp-Source: AGHT+IHwl21ga2QVXOubK6IJ50lga/afqKwqYD4YmD9ir5JeOUVzHZydd1Dwr7FS/O3o4nlmU0WiBg==
X-Received: by 2002:a17:907:7715:b0:abb:e7ed:d603 with SMTP id a640c23a62f3a-abc099b83d5mr1039685666b.9.1740335527626;
        Sun, 23 Feb 2025 10:32:07 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb989d89edsm1414361366b.81.2025.02.23.10.32.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 10:32:06 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ded1395213so6176659a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:32:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXoVoNAdlsuDqizUDrlTiQ7okXdp686gmkUKs5NZlW9EnRwEZAo8mBGfbAkJNjQDaVbPEFjELrVpovFE1A=@vger.kernel.org
X-Received: by 2002:a17:906:6a10:b0:ab7:76d7:dcb with SMTP id
 a640c23a62f3a-abc09a97b01mr1026613166b.28.1740335526003; Sun, 23 Feb 2025
 10:32:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <Z7bO1jT2onZFZwgH@infradead.org> <CAHk-=wgLbz1Bm8QhmJ4dJGSmTuV5w_R0Gwvg5kHrYr4Ko9dUHQ@mail.gmail.com>
 <Z7hulnJ4fwslRILy@pollux> <20250223180330.GC15078@pendragon.ideasonboard.com>
In-Reply-To: <20250223180330.GC15078@pendragon.ideasonboard.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 23 Feb 2025 10:31:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wie_Winz7CtRCM62S2b1pWKN2Jt2wdGHgFBv=aBU8qwqg@mail.gmail.com>
X-Gm-Features: AWEUYZmAe5aQKMqbMOvhjrLvqPDF0CXPi8iaHSYLNnVAdHMEHMUU3HW0e3qcqRo
Message-ID: <CAHk-=wie_Winz7CtRCM62S2b1pWKN2Jt2wdGHgFBv=aBU8qwqg@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Feb 2025 at 10:03, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
>   > I can't answer for Linus, sorry.  But a generic "hey, this broke our
>   > working toolchain builds" is something that is much much much
>   > different than "an api changed so I now have to turn off this driver
>   > in my build" issue.
>
>   I haven't found a clear statement from Linus on this topic.
>
> Those three statements can't all be true together, we can at best have
> two. I would like to understand which one we will drop first, and I
> believe many other developers and maintainers are wondering the same.

This is literally why linux-next exists. It's where breakage is
supposed to be found.

And guys, you have to realize that there is no such thing as "works
every time". Just this merge window, we had a case where I didn't pull
some stuff because it broke 'bindgen', and the reason was simply that
not a lot of people seem to be running the rust builds on linux-next.
But realistically, my normal build testing has had rust enabled for
the last year or so, and that was literally the first time something
like this happened.

So be realistic: can rust cause toolchain problems? Sure.

But we have that issue - and we've had it *much*more* - with the
regular C side too. We have those kinds of issues pretty much every
single release, and it's usually "this doesn't build on some esoteric
architecture that people don't test any more".

For example, this merge window I did have that unusual "this doesn't
work for my rust build" situation, but that one was caught and fixed
before the merge window even closed. Guess what *wasn't* caught, and
then wasn't fixed until -rc3? A bog-standard build error on the
esoteric platform called "i386".

Yes, linux-next is supposed to catch interactions between different
development trees. And yes, various build bots test different
configurations. But nothing is ever perfect, and you really shouldn't
expect it to be.

At the same time, people harping on some rust issues seem to do so not
because rust is any worse, but because they have internalized our
*normal* issues so much that they don't even think about them. EVERY
SINGLE RELEASE Guenter Rockl sends out his test-results for -rc1, and
EVERY SINGLE RELEASE we have new failed tests and most of the time we
have several build errors too.

Guys and gals - this is *normal*. You should expect it. Breakage
happens. All the time. And that has nothing to do with Rust. It has to
do with the fact that we are doing software development.

Ask yourself: how many problems has rust caused you in the last year?
I'm claiming that the main problem has been people who have been
forthing at the mouth, not the actual rust support.

So next time you want to write an email to complain about rust
support: take a look in the mirror.

Is the problem actually the rust code causing you issue, or is the
problem between the keyboard and the chair, and you just want to vent?

                 Linus

