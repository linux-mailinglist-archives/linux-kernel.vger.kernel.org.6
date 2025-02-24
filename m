Return-Path: <linux-kernel+bounces-530021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A287AA42DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9036D1895997
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8C4263C86;
	Mon, 24 Feb 2025 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpCDitiu"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E191A5B8B;
	Mon, 24 Feb 2025 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428854; cv=none; b=fiEDyLEyzWDj5uCT3xYxoWIaaV3NUHDJSxAkuusNtjTZOlllryVArksBusxdQWV0AV6xotG/NQ9niKjzg6lwSoJ7mopaxD0OtoaRYNTFjg5bAtZpVSVtJz8m57LBh8vRijhxNKRBGtd7LpM0nYP0EPmUJYet1+jXgzyERHcb/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428854; c=relaxed/simple;
	bh=h10XZuVFeGOS+X8KDzOz2Otz9RUUWVYfl6at+9PXAOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeuXqwZTQxAFgx675MNZ9p5pu7UPPTp0hFlxhV8Qhabfm4swhZoofgqpl1mz4WPqkOTl2DeNTw+6aOebdGUiE16DL+BdD0Fp2zvLvozSHoj0HGmBwJPHxyUC2jWdOK0EvlFSHfa7sZPS+V4rl7Dse2e8TJ7bt39t5a7MqN1Df8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpCDitiu; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4be66604050so1451880137.3;
        Mon, 24 Feb 2025 12:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740428851; x=1741033651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XEmC/kn2Zh+e/KhqBOkxIA63LvxRFsyvoI5so3k5p1c=;
        b=YpCDitiuAqLIinzJpznEAw4ixmCt3IcDexdTQ2yUkW5QEBAUVK1YbqvAzNdBMvTYsk
         wBamYAQZNaJgXj9K6NNrlzoJiY2NcYpTTkUZbRW2RHJVEdYMIekKpxkBDBEV4mBMPXOE
         BsL0VAJdi/sdzusib563L/jUinmuj1GiBk0h1t2mSaTNoGMeec4lchnqNVGCD3pIt23g
         HHqAoZyniMcVV9FcQ6z5yLeMmW01D2+wD1hSAszhPGjvS2FqXqs9NjoSqeUgFkbIzgr+
         WL5kpZjdXsAhOuklfpsLGt/3UxglkqMzj8hkwFOdhp72HgWNLY6vKMAJ9BhbKgeoZPTc
         KY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740428851; x=1741033651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEmC/kn2Zh+e/KhqBOkxIA63LvxRFsyvoI5so3k5p1c=;
        b=VbC/4ei1MKxztAq9746DO+0KEoLnrAP82NctfFo67FzYisneCh9NAcKGO0F5wI1Adv
         GHEr0YlDjWIhzvrcbZBRHoBs0bGvAwkZPDVQb1+sP8/bFEV0t3UvDvkL11Pu5z6Nea42
         PIXXNlqdT98hBBoI+4RB93BJ+vuD3W9iBaPPcAS1xrIkYH4zD5kNaIgmvHLeFrt86EU5
         u/gICMX0EYlG/Bxpz6xOFPihAja43Hfw4MHGvjC02pX4YgUfVaU6gJZAzBDzX/EXwfTW
         lJ1MY1VD25In24rcJ6dNtjoz8WS5UlLxaBvJVv7YkP6/C7BAjp7HLbdmShycI8olm1ja
         HRxw==
X-Forwarded-Encrypted: i=1; AJvYcCVZsFKzIwkvER5ft3V2whAFS9SjR+gU9d8ZfNq7/jEHGC8h8sneQIHgzp9crPxiK5fewKLBKUd911+pTGA=@vger.kernel.org, AJvYcCXPGgH5sF0iZENyizchF8ZRniS2BlPTe4PP4bwG3lob1JgIOKmaU3Lapxn2usPfCbnuaCodC75mVo3fXnmU6bI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5cWRZmwV4R6kLvUi6xm/dklA1H0pgPvCt5Tile4o0W+rTDuj4
	53V/MSmFk7byb+6HOR5claKKIvgr6IGZcSC157i1FBTx5mPlC5EFnZnjBxeP7rwclOtQHd1ebRo
	eIEzqOWOML6V8QUuXh3xxH2Q++8W4RoFwK2U=
X-Gm-Gg: ASbGncvPrX7rkcppssvPIVqoKwf6EaLmJatbZjQAOxY2s8v98sx8AQBj3LxVy/E8kiL
	wazEM1u1pphQZUHSlTik/Ny3iNpdE50t6w6VvSa/HA7Ksk+owIigKf8YAxSrWNuBWGNMxn/2/XN
	w2iXn7UKBsA21q7EUxstY/XFia4jALMMGKR/wdhO7F
X-Google-Smtp-Source: AGHT+IFEJ8VhdFJGx983dbCOSRUTa1r+mEgXJQjyfnmnU8udNafH9EsY1spL/R4LRNe6zh9h2AVIKwb4mPs7SFIJMh4=
X-Received: by 2002:a05:6102:a54:b0:4bb:f0aa:b317 with SMTP id
 ada2fe7eead31-4c00ad349a7mr388924137.9.1740428851234; Mon, 24 Feb 2025
 12:27:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025021954-flaccid-pucker-f7d9@gregkh> <20250221051909.37478-1-felipe.contreras@gmail.com>
 <Z7gQ3kSeCf7gY1i9@Mac.home> <CAMP44s1Ai5qMU4yV+Rwz4cY869ZA=cxBcTf2wuaUY1oyLKUNCg@mail.gmail.com>
 <CAPM=9ty9KWFE+AkHi5FDrb8=O5bzbVEroT2fx7jLG5JK6HZ+tg@mail.gmail.com>
In-Reply-To: <CAPM=9ty9KWFE+AkHi5FDrb8=O5bzbVEroT2fx7jLG5JK6HZ+tg@mail.gmail.com>
From: Felipe Contreras <felipe.contreras@gmail.com>
Date: Mon, 24 Feb 2025 14:27:20 -0600
X-Gm-Features: AQ5f1Jrlgip45JggOoU7MpBqrGSxxSsSYL7JFZ8jQSB0BRa_C93J-emmek_cS9M
Message-ID: <CAMP44s3DYzwnKbRoiUBAWBVGEc8M78wkkD-DAkJDK=qZmXNtZw@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Dave Airlie <airlied@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, gregkh@linuxfoundation.org, hch@infradead.org, 
	hpa@zytor.com, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

Dave Airlie wrote:
>
> On Fri, 21 Feb 2025 at 15:59, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Boqun Feng wrote:
> > >
> > > On Thu, Feb 20, 2025 at 11:19:09PM -0600, Felipe Contreras wrote:
> > > > Greg KH wrote:
> > > > > But for new code / drivers, writing them in rust where these types of
> > > > > bugs just can't happen (or happen much much less) is a win for all of
> > > > > us, why wouldn't we do this?
> > > >
> > > > *If* they can be written in Rust in the first place. You are skipping that
> > > > very important precondition.
> > >
> > > Hmm.. there are multiple old/new drivers (not a complete list) already
> > > in Rust:
> >
> > That is a black swan fallacy. Just because you've seen 4 white swans
> > that doesn't mean all swans are white.
> >
> > > , so is there still a question that drivers can be written in Rust?
> >
> > I didn't say no driver can be written Rust, I questioned whether *all*
> > drivers can be written in Rust.
> >
> > People are operating under that assumption, but it isn't necessarily true.
>
> That doesn't make sense, like you could make a statement that not all
> drivers could be written in C, but it would be trash, so why do you
> think rust is different?

Because different languages are different?

Just because B is in the same category as A doesn't mean that B can do
everything A can.

C has had more than 35 years of stability, Rust has had only 10, and
I've stumbled upon many compatibility issues after it was supposedly
stable.

Even compiling linux on a compiler other than gcc has been a
challenge, but somehow getting it to compile on an entirely new
language would not be a problem?

I find it interesting that most senior linux developers say the same
thing "I don't know much about Rust", but then they make the
assumption that everything that can be done in C can be done in Rust.
Why make that assumption?

Especially when we already know that the Rust for Linux project has
used many unstable features [1], precisely because compiling for linux
isn't a walk in the park.

But this is not how logic works. You don't get to say "god exists,
prove me wrong". Anyone who claims that *all* drivers can be written
in Rust has the burden of proof. I don't have the burden of proof
because saying that something isn't necessarily true is the default
position.

> if you said 100% safe rust I'd agree, but that isn't the goal.

The *only* advantage that has been sold to linux developers is that a
whole category of bugs would be gone -- that is in fact what Greg was
arguing, but now you say maybe the code cannot be "100% safe". OK,
what is the minimum you expect? 80% safe?

But even if a driver is written in 80% safe Rust, that doesn't
necessarily mean a whole category of bugs is gone for 80% of the code
because compilers -- like all software -- aren't perfect, and the Rust
compiler has been known to introduce memory-safety issues in the past.

So who is to say some drivers aren't going to stumble into compiler
bugs even in "100% safe" Rust code?

I don't understand why I have to explain that theory isn't the same
thing as practice, I thought the Linux project of all places would get
that.

[1] https://github.com/Rust-for-Linux/linux/issues/2

-- 
Felipe Contreras

