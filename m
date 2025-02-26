Return-Path: <linux-kernel+bounces-534000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3057A46156
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55065188D2F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49F321930F;
	Wed, 26 Feb 2025 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erpXeq9n"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2A9218858;
	Wed, 26 Feb 2025 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578021; cv=none; b=d2sGyI5X1wws9sbKMSRxWcsbqKtcl/AKQ5Dm8JztA5LZKIT3zjzDIQX0PSAw8xHVRUPV3TN0bdQRu9Y2Gl9VBnjsOhqwkjusBUQII+1i1z5ERjaab1woHZdKhPmA6NjBRh0D0TNFVIOdt8KHpkL46XZu6h7J0xhMmSNdsIAargE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578021; c=relaxed/simple;
	bh=Uh6z8rQNgbDVnnMLgo/z3Q5x11Klh8iEccl7RxrJ8yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T80PYMHvvGa+JlpcA5EcvhKgdgDQKu/GzRuK5t5umAFdQT7A1gjQ51kSEVUhijswCcOH5uERocXNmcPDhIwo/Qm5jTl/8aLV57KBn/paWDbdrqTxGOOXwtXtjF2nfxNOddS5wVUH8sJlM26JCFr5KzZPzc7nyyc9/7B6XQpVn2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erpXeq9n; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f74e6c6cbcso1768555a91.2;
        Wed, 26 Feb 2025 05:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740578019; x=1741182819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uh6z8rQNgbDVnnMLgo/z3Q5x11Klh8iEccl7RxrJ8yA=;
        b=erpXeq9noPu8rB2i1whSnHGP+m2e+6CiuMIL/apySiqOg5/sdJtIIgDDk242RyHhZv
         Ly72hrg7exC5sv7uAVRCueT7mtQvB5bIF+3RGPYJ+/6/lDLL7ppLHw4iKWyp3qb/25lG
         B+g17F2d7ObG2azEqtKvrRD4e0CIlqAARRqb+fPJh+4bTAIBVB0h2ROF1PWcYsDUfm9u
         9S2bxcsU47q39LD0hCAsJ+UnfWXkUr5VtgB28gRJnpUjfba0dCqC51Ud39YIoEFXMx+5
         w0EFp5/uoxqJRfjSpZwzYwAkVwFUPc5d7r38NFEB/Rm39GltVIJ6a+iK1aDirTgeW6Mg
         6v3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740578019; x=1741182819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uh6z8rQNgbDVnnMLgo/z3Q5x11Klh8iEccl7RxrJ8yA=;
        b=iuVK1w3FATubE4txY8+1WlNREk9itIYgtppiYPf6fnjTH1N08iNB30YFlCgxUCiGAL
         UMk+gHNCL89CYqXCKVfsYutHTbkGIVAxY1zrmlhnvphCcYfSu2Cxkv+AD5aDJbYHXhRL
         jrs3rr5wJIih2eO9CWoZW+89pfkoYis8KaqOscan8U6JuWRb40NKya8UcnRme7NVE3WL
         fvbb/GqCZ0nfqTvFgnrNCtsvVwHHZRxmUFWi77zqDPgmB0CxFdIU2DIochZYaQp/nWw3
         JK7DEvjQi79tscdVhQdKiyx3gQhB/8R1KKstPqm7xzJ+8EwMq5y6FHmQiIVaxpD/1uA3
         Jkxg==
X-Forwarded-Encrypted: i=1; AJvYcCXNnE0tsC7mNdRi6WZ0NYi64lbGsVVfOsOuDcYC9ASkit2c7M6jApsFBf6DkmF8im20P4b8uFViQGIwVww=@vger.kernel.org, AJvYcCXopBCD6t3Re7gJQ9kv2D793E22Efyk8FYVbsPypaUZr+L4jevsCwYXk0NzA3Gal3qlL8TdtGJFjWwzvF63SGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKQhgv0q8Pu6JChugvv2ulRcHj4hDusmY22xGyVbAMKy54souQ
	a83nQgk6pdUxF+28Bmy+ZSjOCpvoUxPvabhnK6lHWXSk+5mft3j9MpKpxh2fK1lguM209qWiqtu
	Amz9B5jBI6herl891jzqeRdc0A1Y=
X-Gm-Gg: ASbGncvTqart5aN8rlRAkWZpv6xwEmY7d4NXKmlDq4NSZ9R7i7eTIV+gblHnb/oEFNJ
	ViWSdQ7gcYvm0Z4UYMCPOGrWTDWs9R60MoJLivsgAnfSGsRCwy2M5gyC2NW0psFgj3HcD0Cs5OR
	e40TaS4m4=
X-Google-Smtp-Source: AGHT+IFc3vG+EM1f/rxnkv+OF/YygbsxYUceTo8OxTTlUPuCjNKj3oW/GAYpwubqK/Dn82eMPU67bI5AbXTauhqj7+g=
X-Received: by 2002:a17:90b:38c3:b0:2fb:f9de:9497 with SMTP id
 98e67ed59e1d1-2fce7b0946fmr14258276a91.5.1740578019277; Wed, 26 Feb 2025
 05:53:39 -0800 (PST)
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
 <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
 <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
 <5E3FEDC4-DBE3-45C7-A331-DAADD3E7EB42@zytor.com> <2rrp3fmznibxyg3ocvsfasfnpwfp2skhf4x7ihrnvm72lemykf@lwp2jkdbwqgm>
 <CAFJgqgS-SMMEE2FktuCUimdGkPWMV3HB2Eg38SiUDQK1U8=rNg@mail.gmail.com>
In-Reply-To: <CAFJgqgS-SMMEE2FktuCUimdGkPWMV3HB2Eg38SiUDQK1U8=rNg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 26 Feb 2025 14:53:26 +0100
X-Gm-Features: AQ5f1JprDdbWkneGamDB4RKH0D53hDCpYV1WQY_4j8FMlfOIcHEje14fR44RDZc
Message-ID: <CANiq72mOp0q1xgAHod1Y_mX86OESzdDsgSghtQCwe6iksNt-sA@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ventura Jack <venturajack85@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, "H. Peter Anvin" <hpa@zytor.com>, 
	Alice Ryhl <aliceryhl@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Ralf Jung <post@ralfj.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 2:03=E2=80=AFPM Ventura Jack <venturajack85@gmail.c=
om> wrote:
>
> One worry I do have, is that the aliasing rules being officially
> tied to LLVM instead of having its own separate specification,
> may make it harder for other compilers like gccrs to implement
> the same behavior for programs as rustc.

I don't think they are (or rather, will be) "officially tied to LLVM".

> Interestingly, some other features of Rust are defined through C++
> or implemented similar to C++.

Of course, Rust has inherited a lot of ideas from other languages.

It is also not uncommon for specifications to refer to others, e.g.
C++ refers to ~10 documents, including C; and C refers to some too.

> Exception/unwind safety may be another subject that increases
> the difficulty of writing unsafe Rust.

Note that Rust panics in the kernel do not unwind.

Cheers,
Miguel

