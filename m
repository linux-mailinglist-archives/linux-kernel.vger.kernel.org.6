Return-Path: <linux-kernel+bounces-241581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3BA927CC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A757D1C23BE7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF16F065;
	Thu,  4 Jul 2024 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="F7tr2q0O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754F1101DB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720116281; cv=none; b=Ilbn8wxStODfBBlzMTyrBTCC0zhRZ2zWsLWoZ1hcfGe4Xhc73H75sB8fdqvUbFPyTO17rOABedTJ1mNiy5K/YamKDaA5+PB96LxP8mNEGQoFO/ySielUoYpci2ZgNN3H4cYabI1+j5VUN5RCZZhmdX1S5sW4Jbhgg90KUpqL+DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720116281; c=relaxed/simple;
	bh=97+i6GHk7R1DDPMRY0cuvzpl8qoIaymD2g3ylPYcJxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BW1PUraQ3LDfqLbWBMkqesvX4cqvt7piVZeaA13Su41BJZ2YAg0rTyJ3gdBrJiNgczglBFLq0HGW3RjqgjW7ZUPdv50N8S3/+dBCI6BjgnZxRd+u8gmr2q9pShSUstunTfB95HNrmK6wZiE2DKqASu6uABxJ9IgRyr4nl0USBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=F7tr2q0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08CBC4AF0A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:04:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="F7tr2q0O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720116278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97+i6GHk7R1DDPMRY0cuvzpl8qoIaymD2g3ylPYcJxk=;
	b=F7tr2q0O4fVBpXEZ6dHpBLU0XIBobCXCRPVOIAyJonMVxW1p9ur3vDb0r1SHl/C9GI8b/y
	pQdF26VExl7VKu7jpa7zD8KvlikK1WlL/aLPXqaFPjNhdoLh+p1JVRbSYK2/j7N5EfNJQ+
	SBcQy0gdwE4ivB4Na+Mn6fNG6Jvgl6E=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f31466a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Thu, 4 Jul 2024 18:04:38 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25e3d8d9f70so98709fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 11:04:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWr4qQExXiEl0L8px0oU9Cr/6ggYEM8PpBdztF+vC5ZcHuTL2TBHqzp952qNJhcpqP8IjLvb3paKytzuGW6sGcclXfGiyhX57BLMt6g
X-Gm-Message-State: AOJu0Yy0jwKAdwpZcEws+JyD36dpsAPYwKl2nWgE9+Vmn5DjXPbr0iKx
	AXzEY7Px+rRDkfh//SE587YgtwQCQkjyaLf2vX034r/CnWhaaslTv1aq7W/6IZdM1GjZw2OCOAZ
	NjRvWU4+W6l6jsrGQRy1dqVqSXB8=
X-Google-Smtp-Source: AGHT+IEf4q9+rgBaq4Lk/H1NLhmaAsvxXZtHc7l1BZNuaWRSspUeqOY+g9GRSdl6NXL07YxiRbcBrGIVMNft81mnIgU=
X-Received: by 2002:a05:6870:2012:b0:25e:d62:f297 with SMTP id
 586e51a60fabf-25e2bec984bmr1957523fac.45.1720116277549; Thu, 04 Jul 2024
 11:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZobXdDCYBi8OM-Fo@zx2c4.com> <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <Zobf3fZOuvOJOGPN@zx2c4.com> <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
In-Reply-To: <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 4 Jul 2024 20:04:26 +0200
X-Gmail-Original-Message-ID: <CAHmME9pm+ZE2_qf1DNxukB6ufPrjTAsnwin05-VX_gS03Yq-ag@mail.gmail.com>
Message-ID: <CAHmME9pm+ZE2_qf1DNxukB6ufPrjTAsnwin05-VX_gS03Yq-ag@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Thu, Jul 4, 2024 at 7:56=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, 4 Jul 2024 at 10:46, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > As far as speed goes, there are many legitimate applications that canno=
t
> > make a syscall every time.
>
> This is not an argument.
>
> Nobody suggested a system call each time.

Well, that's currently the only way to get random numbers that are
sure to be fresh and not, for example, cloned or resumed in a VM.

> What I talked about, and suggested, was rdrand and user-space mixing.
> The system call would be a "initialize the pool" thing with possibly
> some re-seeding occasionally.

And this does not work well at all. The question is "when to reseed?"
and only the kernel is in a position to reliably know this in a
race-free manner.

> > Anyway, those actual users exist, and the partial solutions and hacks
> > required to workaround this shortcoming are kind of grotesque and in on=
e
> > way or another bad. This isn't theoretical. I'm not working on this for
> > "fun".
>
> Once again: I don't want to hear "users exist".
>
> I want to hear *from* those users. Because I would have expected all
> those users to already have perfectly working setups in place already.

What do you want me to do here? Every time somebody talks to me about
this, tell them, "hey would you talk to Linus about this?" and then,
"omg you want me to send Linus an email?!" Library authors wish they
could call getrandom() for their needs, yet they cannot, and are
forced to invent incomplete solutions. Coupling kernel RNG semantics
to userspace RNG semantics is not even a new idea; Microsoft heard
from their customers, for example, and made things work. (Maybe
hearing "Microsoft ..." will turn you off even more? I don't know.
This solution isn't like theirs and is nicer, but it stems from the
same need.)

Jason

