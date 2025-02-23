Return-Path: <linux-kernel+bounces-527995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0159FA41243
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 00:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C90A3A3111
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 23:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C28F2046A4;
	Sun, 23 Feb 2025 23:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWFEwJMk"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCC913B58F;
	Sun, 23 Feb 2025 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740353525; cv=none; b=cI9ymu9EYQwztXrcFAw9dE8Kyv4e13ag/zVNSnRX5iGgQjlN1mL3jxg9OupaTTZ3qbTeFQPBSgTJ7NtGT7TRh23NIoGTT7HAGg2i8QZM3IFNlTRc9pVwEm792SLGDJAplEGchrJe7bORJTi92RaPQXyWYHIvSDt7Z1UURwk5fYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740353525; c=relaxed/simple;
	bh=9SzP/lO9Oz47p1WDXAFv3n6XXzHZVzHB28BymtT8unw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KeK0m0Ia3uSgEDxilCDJGpOxkJdmg4/vizf81l9r1poFugu0ec721v/GLRY9POSocHvUmV2P+7ntObIk+HqkQgGFORhYOo62Q8hV5f8jno8agzPtOge0evNXzw7YYLLSplYy/fz/1CB6Kx7l9vzNEr2+2u8HHDdP7VeOgaUez0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWFEwJMk; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fc1c80cdc8so5889886a91.2;
        Sun, 23 Feb 2025 15:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740353523; x=1740958323; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY/FjH8ifVrO4AXW9HJfHpvRmVFP8k+aKW+4qs+JeF4=;
        b=XWFEwJMk5v4WT29u/V6mGJEuY6hJJR9jemIwiL3X0jXedrfF2eAQ6QRMD0hWWmZtTM
         vCEhGKhFvuLPQhjlrXT/dp0yh0IJk9Wt5p2qQAWPNNhOuSOlnixAgIF4EYH81RW+BBnY
         PU3D3HDd9N1BX5ZQDiHdo8ehJqtNCjleUj5eLZItVoBLHkwSlAUvePPwk3ng2Edxmgnc
         m6IkiDUP6JgmRc5+ukkHQ2/lpOEjZuASdd4N2EZbKzQhtv8w4fXA2IWl74toz30CZS+f
         Sl0suI6pINNwazeZ3Ch2XYH+9sImL39vdg0mxmiPNLhoOSRuoO3kbkscj+KX3NnyVIZ0
         Si7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740353523; x=1740958323;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cY/FjH8ifVrO4AXW9HJfHpvRmVFP8k+aKW+4qs+JeF4=;
        b=DOb2jrVGXRA9Tepw0r9FKqzyIkCkym5loTEoEfAcIU3pJ6/Bz2Uwevh98g5K0HK+J/
         f3Fu1qmTRa7KEzZ+aSosdIxbGXATatwl3v56EqQ1fwVdWdQjpqPNrj1fqk8jbNOgVO99
         eqoBYsvx13gDlpROtThjm6Aat5jSXZ/f2fywd1fmkLZwWr3K7pi1MZfBrzYEgnGTJQod
         fyeoolMC37UFKpAHVP0orCs0JjUbdfgw6ov2AocTMNPFsGW+yVka9TRCHVRdB5LZqori
         /xPcpUcZfTKPyJSKoUTcDIVm5bQA6yJfKiaG1oqsh8J4IMEYpeVW1SXB7hMtupBBgiwq
         szbw==
X-Forwarded-Encrypted: i=1; AJvYcCVpUItu+PJnJVqYxf6Cy/+uCdAfrEf0hrkL/v0g7wDosxJyIgkAU/WUqYLh+ViaZQupXrpC0BtS5nXkcXs=@vger.kernel.org, AJvYcCWjGDKz9+tH06ueMTcK87k3vQlQcLKNDDO7R6FbpmqlDZb5o7c+QbQ2c7i3gVl3qQfeZRGCeo8XZ8v3JzUxeA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuOCNIjQVx0mokjAa5DQRXT1Brlc5huIv61OktzilRaudKVyT+
	GPL7VucMYiKmj+tc2xFnlv3dlN9TVV9EhQpMVzUU75aBNqbKYEcMEAdZhWDB
X-Gm-Gg: ASbGncuuBIqmOoKnu1TGx94eMDZYUPdrPv/3Sooi+qNyjckDkeX1mNeP1nibbBdGfQH
	SLTyV8KO+nX7PAKP64YHDnTQKtHiwGmJAg54IzaJkBDdvj7U2uZ+zTKlIvuHnXsJAztNGFF+6L0
	IsdF9EjqcU3mvKGgcqjZ3ZVMk4xA/QKyj/EFC+BD0ssXAqWx8NIJi4gI6WFTVGzsC8t8+3F80rI
	Fg9eBkwQDM2cnLu4TxjI7EUMaEseyLwMv28oHzz1MWr0yFOSHwAheOdl7sX2bE28X0d5QWsx/IA
	FUjTHh+wVOnQDyWK5MtyUMRYgouok3EIBxpII/rsKb7oFQvI
X-Google-Smtp-Source: AGHT+IEZaCc7mLw+80g8Jz/kMgvS1gsDVAhNQEI/CkIHmF8ulm2CfeFAyRuF0ozUizRn4JTp1yw7lQ==
X-Received: by 2002:a17:90b:17cd:b0:2ee:8aa7:94a0 with SMTP id 98e67ed59e1d1-2fce7b04fc2mr16642616a91.32.1740353523482;
        Sun, 23 Feb 2025 15:32:03 -0800 (PST)
Received: from smtpclient.apple ([2601:645:4300:5ca0:1452:c642:288f:cb14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb02df30sm5182530a91.3.2025.02.23.15.32.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Feb 2025 15:32:02 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: Rust kernel policy
From: comex <comexk@gmail.com>
In-Reply-To: <D7ZDF8NZGPS3.3QBMAVC1NTUDM@maslowski.xyz>
Date: Sun, 23 Feb 2025 15:31:51 -0800
Cc: Martin Uecker <uecker@tugraz.at>,
 Greg KH <gregkh@linuxfoundation.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Christoph Hellwig <hch@infradead.org>,
 rust-for-linux <rust-for-linux@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <E0BD1BDB-0EBC-4E27-9324-7CA70ACE194B@gmail.com>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
 <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
 <2025022024-blooper-rippling-2667@gregkh>
 <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
 <D7ZDF8NZGPS3.3QBMAVC1NTUDM@maslowski.xyz>
To: =?utf-8?Q?Piotr_Mas=C5=82owski?= <piotr@maslowski.xyz>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

> On Feb 22, 2025, at 3:42=E2=80=AFPM, Piotr Mas=C5=82owski =
<piotr@maslowski.xyz> wrote:
>=20
> I'm sure you already know this, but the idea of safety in Rust isn't
> just about making elementary language constructs safe. Rather, it is
> primarily about designing types and code in such a way one can't "use
> them wrong=E2=80=9D.

And importantly, it=E2=80=99s very hard to replicate this approach in C, =
even in a hypothetical =E2=80=98C + borrow checker=E2=80=99, because C =
has no generic types.  Not all abstractions need generics, but many do.

Rust has Option<T>.  C has null, and you manually track which pointers =
can be null.

Rust has Result<T, E>.  Kernel C has ERR_PTR, and you manually track =
which pointers can be errors.

Rust has Arc<T> and Box<T> and &T and &mut T to represent different =
kinds of ownership.  C has two pointer types, T * and const T *, and you =
manually track ownership.

Rust has Vec<T> and &[T] to represent arrays with dynamic length.  C has =
pointers, and you manually keep the pointer and length together.

Rust has Mutex<T> (a mutex along with a mutex-protected value of type =
T), and MutexGuard<T> (an object representing the fact that a mutex is =
currently locked).  C has plain mutexes, and you manually track which =
mutexes protect what data, along with which mutexes are currently =
locked.

Each of these abstractions is simple enough that it *could* be bolted =
onto C as its own special case.  Clang has tried for many.  In place of =
Option<T>, Clang added _Nullable and _Nonnull annotations to pointer =
types.  In place of Arc<T>/Box<T>, Clang added ownership attributes [1]. =
 In place of &[T], Clang added __counted_by / bounds-safety mode [2].  =
In place of Mutex<T>, Clang added a whole host of mutex-tracking =
attributes [3].

But needing a separate (and nonstandard) compiler feature for every =
abstraction you want to make really cuts down on flexibility.  Compare =
Rust for Linux, which not only uses all of that basic vocabulary (with =
the ability to make Linux-specific customizations as needed), but also =
defines dozens of custom generic types [4] as safe wrappers around =
specific Linux APIs, forming abstractions that are too codebase-specific =
to bake into a compiler at all.

This creates an expressiveness gap between C and Rust that cannot be =
bridged by safety attributes.  Less expressiveness means more need for =
runtime enforcement, which means more overhead.  That is one of the =
fundamental problems that will face any attempt to implement =E2=80=98safe=
 C=E2=80=99.

(A good comparison is Clang=E2=80=99s upcoming bounds-safety feature.  =
It=E2=80=99s the most impressive iteration of =E2=80=99safe C=E2=80=99  =
I=E2=80=99ve seen so far.  But unlike Rust, it only protects against =
indexing out of bounds, not against use-after-frees or bad casts.  A C =
extension protecting against those would have to be a lot more invasive. =
 In particular, focusing on spatial safety dodges many of the cases =
where generics are most important in Rust.  But even then, bounds-safety =
mode requires lots of annotations in order to bring overhead down to =
acceptable levels.)

[1] =
https://clang.llvm.org/docs/AttributeReference.html#ownership-holds-owners=
hip-returns-ownership-takes-clang-static-analyzer
[2] https://clang.llvm.org/docs/BoundsSafety.html
[3] https://clang.llvm.org/docs/ThreadSafetyAnalysis.html
[4] =
https://github.com/search?q=3Drepo%3Atorvalds%2Flinux+%2F%28%3F-i%29struct=
+%5B%5E+%5C%28%5D*%3C.*%5BA-Z%5D.*%3E%2F+language%3ARust&type=3Dcode =
(requires GitHub login, sorry)=

