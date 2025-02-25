Return-Path: <linux-kernel+bounces-532661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5A7A4506D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589FF167B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239E5225795;
	Tue, 25 Feb 2025 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ah36awh1"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F17D2236E5;
	Tue, 25 Feb 2025 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523524; cv=none; b=KsduryUS1apPMexJwNUVXD/g7Sw4GRO5p7kNHtSKLFhTaZLAhgJmtvTe9sJaK6I+JF17gri69IBw9NwDOM1UjNitd9C70OgVDH7AdZ+WL2oKDB08Ta76O0jsqkTmB95SsCoK1j7w1kwJJ2XpitYfSyc7P3Yq8Zv6P8qL+APseGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523524; c=relaxed/simple;
	bh=2994Cx+0BEvrnRr3hg0JQaVKoaoIXzC1cKTbjQ8vkWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pup72/U6pdkY+UFK4v+ohYC35JVs6CrlCBCq1zbYxKHk/h0HoF9TqbvmwhVz27gqs/Isdg3dhOmwL6RqCbe4Ql5XvBsK+ZWgpFxi01V02ry7p+IskJSDCJW6y1HPew9/ThFtUuEWvA3V1XxvOmVRlJhRigpF3GeIPOgvIo03FHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ah36awh1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fc0ab102e2so1550454a91.1;
        Tue, 25 Feb 2025 14:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740523522; x=1741128322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BREjBIu3LhC9CjTs4V1jX9U/z2RLLn2jYU7SiNJkd7A=;
        b=Ah36awh1+YGVdua/jDOpvfCCi+3Uekelgg2fCxr1wjyBiRFj+coNbiSc82QDIlQrMM
         sG1lJ38R+glDZjadaXjL0Oon/qm3UL+vFUcsVZJEcsSnk0y6jCjmJibjcXqrkROuILak
         9/39h8ZJhxaIkc8SCx2zxsaUvQYvUHq5MThj8GgkM2ubcNykkJ8blGMAtmUIedRaZpgq
         TcJ8RpoyC2iO6yZCJHO4aNRGiUDt4bwp9/1bFwvpInLpJrAGr/IltU47CMmLhVcWjW/4
         xQfqDrZCew9hZnOUW58sFdDZcRQDg+y5feHoet0oVObxUh80w7Ura76VlFGjOe/rJ56G
         Pvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740523522; x=1741128322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BREjBIu3LhC9CjTs4V1jX9U/z2RLLn2jYU7SiNJkd7A=;
        b=o4S5EVIu2WZDPz1wiwITW86KctbCQOQtuEv/vAvUejK1k43hyTjXZMc7/yLtKtJHTm
         b52Gc1hZutkKnOStF5y33uxRKRI/XRAnkEUdCnp3jZwBsqVneDmtEtYkXkbgOHPxkBZz
         jxsDLqujHPUNLRRexPBZnzCmRNL1ITbZLcXcMPYdcKeABm7bksoigZVmVVIfr4l9DWzN
         3Ruawbgb7aDaHP/Dj2tueIcPXtCrSg9bSKq9tPdxHWk9KXR9X04qllxm1oAorsJQZcXp
         6xd+K8o+GSmXzR96uNZW9zxu9xEfpTyDufVHCWmRZ7JqiQelhTpFNWF/bdkVHdTgTTv5
         XEGw==
X-Forwarded-Encrypted: i=1; AJvYcCVScC6fSZ6daKDGF720o8MiGdz84KHojk50NOoCGwAstAvEIvyjyHUjb9egnmSCZOlGogN2VOiVAVcsbWk=@vger.kernel.org, AJvYcCX0zbuq/uEQ0EFAW31MfuBePyouea1vsBlbRYkNT/biIFfeG5fVcMEeGOv6Fm30F2D/Z5Gsq7ExX7sAlh1QCO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Q4phpoFimOqgIQacQenr8eSaiE2ZU0wcEetMPSs2SfK7cfFG
	IDmx8+SHUcZpT7zTdNZmqH4ZegnYQVYkeb0eM00NFSi0qarcxkYDHFvotuo+BR3xOgHfbREcfUk
	IQbDe8EkaRYMjeBWOY/Khu0PpbPc=
X-Gm-Gg: ASbGnctjEbvUtLC8E1GqlijoPmIXPlHYkZyO8L1L1VTMJkklZ+iDLfWV1+6ypUBAnTb
	Hn/B+ghY6WDzSgI/YUUzq3qgbZ5P2rRvUdUYNAzGuSED9M2sGqLiXdXwbgXTikfdOoJD4Q0Recg
	PfAfdHLMg=
X-Google-Smtp-Source: AGHT+IHW/s/T1gk//zFpUU2//2FctOurcPUs7k9tldIQX5WWLhusS9PC80LFS5bIUyvczF3LpCt7Z9oB8SZfEuTLt8k=
X-Received: by 2002:a17:90b:4c0a:b0:2ee:b665:12c2 with SMTP id
 98e67ed59e1d1-2fce769a322mr12045299a91.2.1740523522212; Tue, 25 Feb 2025
 14:45:22 -0800 (PST)
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
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <gqw7cvclnfa7x4xdz4vkns2msf2bqrms5ecxp2lwzbws7ab6dt@7zbli7qwiiz6> <CAHk-=whGY2uYcXog8kmuAAAPJy4R84Jy9rEfXfoHBe-evmuYDQ@mail.gmail.com>
In-Reply-To: <CAHk-=whGY2uYcXog8kmuAAAPJy4R84Jy9rEfXfoHBe-evmuYDQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 25 Feb 2025 23:45:09 +0100
X-Gm-Features: AQ5f1Jovuvs9MoeS3e0E3JJ3UTqjDjDZQtBXriL-HUMRHDG6UIjWV-N8PidE8Qg
Message-ID: <CANiq72kSdPvh81uOm=N-=37f7NT7udRV-PozfO2pcfbT6aaWyw@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Ralf Jung <post@ralfj.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 9:25=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> No, that's most definitely NOT the whole point of unsafe.

There are a few viewpoints here, which can be understood as correct in
different senses.

It is true that unsafe Rust is supposed to be used when you cannot
implement something in safe Rust (be it because the safe subset does
not support it or for performance reasons). In that sense, the point
of unsafe is indeed to expand on what you can implement.

It is also true that `unsafe` blocks in Rust are just a marker, and
that they don't change any particular rule -- they "only" enable a few
more operations (i.e the only "rule" they change is that you can call
those operations). Of course, with those extra operations one can then
implement things that normally one would not be able to.

So, for instance, the aliasing rules apply the same way within
`unsafe` blocks or outside them, and Rust currently passes LLVM the
information which does get used to optimize accordingly. In fact, Rust
generally passes so much aliasing information that it surfaced LLVM
bugs in the past that had to be fixed, since nobody else was
attempting that.

Now, the thing is that one can use pointer types that do not have
aliasing requirements, like raw pointers, especially when dealing with
`unsafe` things. And then one can wrap that into a nice API that
exposes safe (and unsafe) operations itself, e.g. an implementation of
`Vec` internally may use raw pointers, but expose a safe API.

As an example:

    fn f(p: &mut i32, q: &mut i32) -> i32 {
        *p =3D 42;
        *q =3D 24;
        *p
    }

optimizes exactly the same way as:

    fn f(p: &mut i32, q: &mut i32) -> i32 {
        unsafe {
            *p =3D 42;
            *q =3D 24;
            *p
        }
    }

Both of them are essentially `restrict`/`noalias`, and thus no load is
performed, with a constant 42 returned.

However, the following performs a load, because it uses raw pointers instea=
d:

    fn f(p: *mut i32, q: *mut i32) -> i32 {
        unsafe {
            *p =3D 42;
            *q =3D 24;
            *p
        }
    }

The version with raw pointers without `unsafe` does not compile,
because dereferencing raw pointers is one of those things that unsafe
Rust unblocks.

One can also define types for which `&mut T` will behave like a raw
point here, too. That is one of the things we do when we wrap C
structs that the C side has access to.

Cheers,
Miguel

