Return-Path: <linux-kernel+bounces-529486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4F4A426E7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8EB3AA56F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAE825A64B;
	Mon, 24 Feb 2025 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8px87k5"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0795C23FC52;
	Mon, 24 Feb 2025 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411842; cv=none; b=TbWpc6MLVSiFC79hUGm9W8U1AQyigHIEoSJRNlCaLGrquqLAwCgEkqhsuZsQ2qZyEcYuhRrR5CTIrfPZUBNOszuhOrVGutwuimGWo7xT8y4NPDiQnkb1SFxYmc8F3nSWry3qn5Hd6AIkkIOe7yps0Jy7ZYRLpsaUVfH4qaWy/XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411842; c=relaxed/simple;
	bh=axizuVZoqFdJlZVQmQhwpOvsd8I6FUTt/CSaw6hCKi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPI4xiQBcKJioxLhBESZvYQpAG10qBSplCwg3oWvfXhqRVYKwsTUJx2Ths7hPydWPTftVx6YUta0VkR/tLEC02VCJ47zMzICH1zOY5YcrkXxem7MWxN/ecpnss7AzXMk4k/wWxyEWfspBQ2+uwJW8vj+aqtqHHndnb3om39NB6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8px87k5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fc317ea4b3so1285231a91.3;
        Mon, 24 Feb 2025 07:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740411840; x=1741016640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axizuVZoqFdJlZVQmQhwpOvsd8I6FUTt/CSaw6hCKi0=;
        b=f8px87k5eoVbpvaAHLsWURKBO8vycupiPfF6rYQBtWktn3Sr7pcZNrkXlU2Zyz/ucN
         iPr2cQAR8qhGMu+79dpDJaO1RO1QRFohhlwTKvmGBaQiaQ7G6jQmnaZtf3m5+lYQOTQU
         /OwZw8ChG4kFxgqJDau62WJa9sU26pKItDEhVT2QlcuRPKpRggNS9rvzzZN0rYV9sMH7
         dTHnYgcgvBOde23bwxslnQei7ix8e+lYa0vGo8jAimkagC4wX4Dkvl/izxGDpT/rhvTu
         0Lt6+mD5CqV0sxdO1r6J0tcLcNpC/sOoHLRb5kZmSVl3/RwZ69pQitFMR7F9x0fmFP0n
         Br6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740411840; x=1741016640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axizuVZoqFdJlZVQmQhwpOvsd8I6FUTt/CSaw6hCKi0=;
        b=BfmP9YIhcKoYTlkpZ631oYBmqCkHBDXVizWe+g6WTB0HmOjp4WuaydWYHwvjQQ3ol0
         0FGVM6N8+8jiCxcKCIueh31WLsv2Zm6NeD80TuzjCc+NevpcALmEXVQndGx4RGwPYfKE
         EfIZ9ISvz0M38SLkB91aS+Ojxbpl9b/Csv7EoWpLJcdPQVjcFdHmZWjPQVZJfqVh3F/P
         Cb4mfW7FSuIePPow2xiuXfBhB4gOH57NQsnhwhsj8QtY9IS13O4xNFBL7CmZY3AsAKyz
         32WfHeTZTbWfgFq9bT37GuuDugIII/jfu8QDhhsma5T3Qfp6i8CF5XMBEzjU495ZeqsW
         o55Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOZkaUzDJ1e1qEb7ehesupXBKr5lp9TYlWwEQ6329G9LPxNqPOyU70swBZXpROejxIwHpjDprMHI/t6tUe8eM=@vger.kernel.org, AJvYcCX/27iSu+hZyeG4nxWxBZ2+PWYJTD0obOxGQbQCYs5vEd9crqsYDcBoM/0dkwMKChtSkYRru8JujpelJ+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIl7GL8ACXMfyvaA9eJT/vf6FNHmnbvKjuhzeJaPKhbIxhbJFW
	LWCiYikyJl/bxM/JxuO/ORP64MO/9z5hy44R9ufhsN9opasZL6ZgXfckas6Gv080XKSGWcupjsf
	LGrrBUKCxSt4UtenPQuGfD4aP0M8=
X-Gm-Gg: ASbGncsnMnFies68b/1HF9i4+3hYZ/jKnsDMfmu18cEHr3AyyyUZduUprzoO/L7Yi6a
	M05HlCSlSwOY43ZTCSbxlbc0jWi9IfXCLpbqiKiuq0Q/bVZfI9STI1kBL9XlfZ5xKllmhAp0RVf
	nMDKEJ4Pg=
X-Google-Smtp-Source: AGHT+IFwccVA735YcajFZZgRua28QRhXt3kkmuR2LYi+4BBuJGijedB8C1NxvHdYe2jYJY5Fv/jEa+P3KDPk5l1yvRc=
X-Received: by 2002:a17:90b:3907:b0:2fc:f63:4b6a with SMTP id
 98e67ed59e1d1-2fce75f086bmr8812865a91.0.1740411840237; Mon, 24 Feb 2025
 07:44:00 -0800 (PST)
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
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com> <20250224125805.GA5729@mit.edu>
In-Reply-To: <20250224125805.GA5729@mit.edu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Feb 2025 16:43:46 +0100
X-Gm-Features: AWEUYZnJreLlUCqRvmxLmsng7Wps3b03pCHHq2EiNBIl5m7TmvKE7HVAH1sXkPM
Message-ID: <CANiq72kMQW6a991e9TgR39pmG5hVd-NcoeJANum4ap-6n=Mhhw@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Ventura Jack <venturajack85@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 1:58=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> That being said, until Rust supports all of the platforms that the
> Linux kernel does has, it means that certain key abstractions can not
> be implemented in Rust --- unless we start using a GCC backend for
> Rust, or if we were to eject certain platforms from our supported
> list, such as m68k or PA-RISC....

By the way, the real constraint here is dropping C code that cannot be
replaced for all existing use cases. That, indeed, cannot happen.

But the "abstractions" (i.e. the Rust code that wraps C) themselves
can be implemented just fine, even if are only called by users under a
few architectures. That is what we are doing, after all.

Similarly, if the kernel were to allow alternative/parallel/duplicate
implementations of a core subsystem, then that would be technically
doable, since the key is not dropping the C code that users use today.
To be clear, I am not saying we do that, just trying to clarify that
the technical constraint is generally dropping C code that cannot be
replaced properly.

We also got the question about future subsystems a few times -- could
they be implemented in Rust without wrapping C? That would simplify
greatly some matters and reduce the amount of unsafe code. However, if
the code is supposed to be used by everybody, then that would make
some architectures second-class citizens, even if they do not have
users depending on that feature today, and thus it may be better to
wait until GCC gets to the right point before attempting something
like that.

That is my understanding, at least -- I hope that clarifies.

Cheers,
Miguel

