Return-Path: <linux-kernel+bounces-532423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EEDA44D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5204516A43F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830592192EA;
	Tue, 25 Feb 2025 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hWvPkTiT"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87095218AC4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515136; cv=none; b=DMYb99ojXytf9wwXv0HhER4NkGvoB3+yX9o3VZUxj6gTcosvDeboMBAfJySH7PHYFT8EtYAp8wYH8Gw5Yq/evxe8TbCzLljQAJMaoLLdPqqWtFd94AsYUY3brgmGVu4PTmiHu01CpwiAsmLGk8jiAQ2C7mgM+unGQY4pV8NF/kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515136; c=relaxed/simple;
	bh=tBOWs+8gBz/+ugcAnXzgbAqo5bkP1lDarIPnI+3UAZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3zHbWIh5OsJ+S2d3qT3kHzJYvnqoPJTlKHVbkpD4iw9QW/L0g+8bBBSHfHY61p7w0TTYgDYOp9f8nZe1VjuJFXsuv8rapOKlxRGeU1WDoIow5dvIFThnj+AtH6g+URQAlbq2fBTvMH7OqUzgRUp42nevNQ45w9A4qzicJVYwYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hWvPkTiT; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso10816019a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740515133; x=1741119933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y61pcTR3GsuY043VMbi4v/Cd+bs9ipxDEF9XwQhZi9g=;
        b=hWvPkTiTQ0Dqm3G6ntkqDUXF6WpVQ3lStY0zTSSRLVcopuPVs+Q6QUjrw4DIqPCe6L
         XYUzVi388KfQ0F+oQB9ZOGh50YUnxXCc4ZeN3+6a9WCR+xcLzQm/m3PIiK9KBnAZVtsf
         MY0xIGANSyNbsV3/k3f5EwS+r6vw6R6FlHsto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740515133; x=1741119933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y61pcTR3GsuY043VMbi4v/Cd+bs9ipxDEF9XwQhZi9g=;
        b=Jo87NpSPaCRopGFVa3L34mMXWGaHbu1+L4ORe+bnapfrT9W9OVJR4q8VnspqYuSWKd
         O4g7OOXj70TdQdVAA8qo0Zx/2Ue7WU7k9FeWke9FImmGnzxEOIcCzsnEupPYTvwySHhQ
         UA635JiVIQEog7qD1cHk5svD/V9pxv+Fg+T9Bob0018GGli8A08+9nYxFnBj/mlkslzD
         icUpz5u98xKG+UlbH+v10KJxFpEqTg+W2RFCsh+OpaTPtwLLMwkrBB7to/z/KDfXf9rn
         DdN2hd5Mxw5dAoPCDB5Ci+jNN6RGWEkDvCS6rNuGUEk85VjFgdiT/q/MHqHHND6CNv24
         HUow==
X-Forwarded-Encrypted: i=1; AJvYcCVaNmv3Gi6SD8ViNcG31PTnE5MAexIlJ0RXBXhASHy72ZNg88s+GeW5hPRxh+sTY8Kq5hNxgGX6tRr9t88=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPlO8C6gK7ZTqzxgKZQFBt6PAXzlNfpkEhR5vb9Z10qdO2RZwO
	UrJ/p7D/yE2wQvW6LpntPxm6JC+zLUby36iuS6DQmwMkMgbb3jBpLSrBcEb9hON9PMyjffIUPiI
	+SNs=
X-Gm-Gg: ASbGnctijo9ykCeT9NItPJAToVKGeMiMWb9SVFvpTs6vI6IPLSVrKiSy7k1bm5c7ruB
	LyKI07X4KlQSvz51VJHEA6e+Xomc/PL+MBqDnDABU9O6LBgh0TqqFHaq2QXvuXd6vVly+6vSBTN
	yk9OaMQUCF8jL3YOZtp5d72IYGN23om5Wd8yQMxDx2yb67F8rVpU1fubyIjJ1I9KHuUJoACrJww
	OABy7uJUiCgpLc2ZsykEi2yDPcqpTmYuJc0dClEXLaEXaAjseSJ1IXRPKauFmSNCSoBHNNqNbxe
	IgeAeVp/K61bE1nMl5L9TyAlv6gH89KKULO/mnEkIoX7ncI4u0wAnNlsxzqe7uehevvum+hVJAX
	f
X-Google-Smtp-Source: AGHT+IF7uqC0gcdFaCLvBTjnywcZ6LwTIkcwdRvTw2JopR6WYSP8oSMFOY/h/UaWC6sG/6mmrR1OZQ==
X-Received: by 2002:a05:6402:1ecb:b0:5e0:4a92:6b44 with SMTP id 4fb4d7f45d1cf-5e44b763649mr5127656a12.30.1740515132600;
        Tue, 25 Feb 2025 12:25:32 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4518460dcsm1706755a12.0.2025.02.25.12.25.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 12:25:31 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so9528532a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:25:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIbjPAIYgWSX6by9VWIscknbg7qYxT35XTMfvqHnY8PGntScDsK4m+0fpHPd2hMG0/qc+kerdbvUbtLS8=@vger.kernel.org
X-Received: by 2002:a17:907:72d6:b0:ab6:dace:e763 with SMTP id
 a640c23a62f3a-abed100fee4mr509174466b.38.1740515130517; Tue, 25 Feb 2025
 12:25:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com> <gqw7cvclnfa7x4xdz4vkns2msf2bqrms5ecxp2lwzbws7ab6dt@7zbli7qwiiz6>
In-Reply-To: <gqw7cvclnfa7x4xdz4vkns2msf2bqrms5ecxp2lwzbws7ab6dt@7zbli7qwiiz6>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Feb 2025 12:25:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=whGY2uYcXog8kmuAAAPJy4R84Jy9rEfXfoHBe-evmuYDQ@mail.gmail.com>
X-Gm-Features: AWEUYZlOXj6mDCIezjuum6eAqCm_wlo9l5dfNahDjnlsJi-NDtjLkzkbOckahpM
Message-ID: <CAHk-=whGY2uYcXog8kmuAAAPJy4R84Jy9rEfXfoHBe-evmuYDQ@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Alice Ryhl <aliceryhl@google.com>, Ventura Jack <venturajack85@gmail.com>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 11:48, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Well, the whole point of unsafe is for the parts where the compiler
> can't in general check for UB, so there's no avoiding that.

No, that's most definitely NOT the whole point of unsafe.

The point of unsafe is to bypass some rules, and write *SOURCE CODE*
that does intentionally questionable things.

The point of unsafe is *not* for the compiler to take source code that
questionable things, and then "optimize" it to do SOMETHING COMPLETELY
DIFFERENT.

Really. Anybody who thinks those two things are the same thing is
completely out to lunch. Kent, your argument is *garbage*.

Let me make a very clear example.

In unsafe rust code, you very much want to bypass limit checking,
because you might be implementing a memory allocator.

So if you are implementing the equivalent of malloc/free in unsafe
rust, you want to be able to do things like arbitrary pointer
arithmetic, because you are going to do very special things with the
heap layout, like hiding your allocation metadata based on the
allocation pointer, and then you want to do all the very crazy random
arithmetic on pointers that very much do *not* make sense in safe
code.

So unsafe rust is supposed to let the source code bypass those normal
"this is what you can do to a pointer" rules, and create random new
pointers that you then access.

But when you then access those pointers, unsafe Rust should *NOT* say
"oh, I'm now going to change the order of your accesses, because I
have decided - based on rules that have nothing to do with your source
code, and because you told me to go unsafe - that your unsafe pointer
A cannot alias with your unsafe pointer B".

See the difference between those two cases? In one case, the
*programmer* is doing something unsafe. And in the other, the
*compiler* is doing something unsafe.

One is intentional - and if the programmer screwed up, it's on the
programmer that did something wrong when he or she told the compiler
to not double-check him.

The other is a mistake. The same way the shit C aliasing rules (I
refuse to call them "strict", they are anything but) are a mistake.

So please: if a compiler cannot *prove* that things don't alias, don't
make up ad-hoc rules for "I'm going to assume these don't alias".

Just don't.

And no, "but it's unsafe" is *NOT* an excuse. Quite the opposite. When
you are in *safe* mode, you can assume that your language rules are
being followed, because safe code gets enforced.

In unsafe mode, the compiler should always just basically assume "I
don't understand what is going on, so I'm not going to _think_ I
understand what is going on".

Because *THAT* is the point of unsafe. The point of unsafe mode is
literally "the compiler doesn't understand what is going on".

The point is absolutely not for the compiler to then go all Spinal Tap
on the programmer, and turn up the unsafeness to 11.

           Linus

