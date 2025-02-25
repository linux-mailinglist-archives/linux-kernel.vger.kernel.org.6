Return-Path: <linux-kernel+bounces-532052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6978AA44806
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0D13BBA08
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC443198A34;
	Tue, 25 Feb 2025 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZWAVlzM"
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539821ABC6;
	Tue, 25 Feb 2025 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504106; cv=none; b=WDgMbz9++JwNdGPA/co7mwUem5DiWS8Lp8HfjDzThfyTKAX8MgwGoSyGKsiDQ1IcVE+X7R1TmHNDL+0BpX0kO4f31Lo21W06IxbKJpz8KaG5qGD2JQ0AuHvwlbzIUVRqZRGv/g/vNhsYkD7QDwK2SiR3fWZQ+uh8xFy2kxzg7r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504106; c=relaxed/simple;
	bh=g8b94iQeKit7M6efwtxa16qoL3Q0/wQFaWwGXIVnAsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZP0FGYXLGE5RaRYNM+P+Hdn6l38WUVUMQLZ1p5rHb/uVuwCo4zE1IOhpoEMLhYhfHUaLRAOl16uRocpxJ27pzLe+rRiLB8uEktdxt6fEniRsYCoubew/y5W8Se7HDxOdAc+JULKt9sELzkCcC5XHxKPjKsum0xlywfcg+7L+68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZWAVlzM; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-54298ec925bso8193991e87.3;
        Tue, 25 Feb 2025 09:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740504102; x=1741108902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFp1PXg9ibzgWTyF7i/yFKZcS7KZ9Zv8rxtRiXS5hLs=;
        b=AZWAVlzMdwdjIGOrezZTMBWOz56YA2HBpLlNos2w6jQRp0lE8f24w42E7e4b+YwU1U
         VVfKgfyF1v+/lWAUx+4Yf68IxkLqfOcCWA9Sdxne0QEn4kQxGeQT9Hm1IzMyS7alaRpx
         ZUbLRF2fyOfrtKvF1XaJgkndQK5stnSiA3uXH190SnFEo0YD4o6dYxuYzMnUVk9j1saO
         qeDsugHQShTW0/I3zkaxHbnVTMohkORJQnRj6glrDTLJwsp4ee1mBBCse28Fj3d3vxh+
         1bL+fsJkd7Phw3c1IhSHpSuBXPU2xZSpjBibJ7oHWqCNypB5RJGKd3pnw97XlEkHe0ej
         jujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740504102; x=1741108902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFp1PXg9ibzgWTyF7i/yFKZcS7KZ9Zv8rxtRiXS5hLs=;
        b=wCar+sF5tySi9SNRETVCcwRN/c5P4Y/X7AuqOs6sa1shnM7/kzEYhQK7Y6+1kT/HXq
         MnmkBlvCp2juOWZEKF9M0pLzTHvt7xQA1q5q8Z67iKqTd6HZlbNO/s789B/T2RVMfbQW
         yu/tkVdKPkDJXW4ALBQm2/RmEmJ38XWC8PYVp+eRwvGwvfIgM/RkGujQQwqZE2SlxnQf
         u5kQSc/OpOaWQHBMEL4EzKJ60/7+L+7uzBY6AfU5sx4S+O0GIFn5Kga+H54aCWgzE+l2
         tb1UL23G276W/pdYCZPP/9FUShs/CnDHIxb45t7ueDjC6cwkr8skxGLk/shXbfT9ek9p
         0k1w==
X-Forwarded-Encrypted: i=1; AJvYcCULH0kEbWQnkoxdyxDzQseWAiv8EuMUpRDarTB8kctAsOTF592G0uJOY9vStv17G6JGfv0OmKJZQxci76A=@vger.kernel.org, AJvYcCUeS94/zCjsktjSImEK4p+wxjmtRSkgfKYiR+Tg1+u9KZeIFSLjyiPnl8FIR6X8ihxCnZd8d3lmVD0HsmwzA9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqyvgA+PhTG+xfQ1Ep4aRtMXYBtOHRaLTFhfj2oZYIoNRfXo1w
	/++hrAtoUiLtTBlV4/6e7CY4bUugAT7bUd9x94qR1arBM/RA8st3lADshMUHgLDFwVg/L52iTYG
	dX5CtoGNW+V2pwLLBYGY0hgu5Oyw=
X-Gm-Gg: ASbGncu07hyFRA5R1gZ5+13+BSNG6uYapn9YPR0hwMEfbfa572D/XOocmBf/ENeQsNj
	TMTAl8uXB0euDsD/kmBTfcO1kpAEKmZCWRVocMubKxB5GevHll3D1qw8ONGiNt4wX9R+rc7WKaj
	oAG2pRBbUa
X-Google-Smtp-Source: AGHT+IGg0L2G18ybzjJhT/nuNLljUfMebQR4U+Qx20CQIV2uJH1FVYMEDY2DEJ77A8Q/BgGVqabuhNZ/bsrJvAlDy/I=
X-Received: by 2002:a05:6512:39c5:b0:545:d70:1d0e with SMTP id
 2adb3069b0e04-5493c54ce34mr128422e87.3.1740504101982; Tue, 25 Feb 2025
 09:21:41 -0800 (PST)
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
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com> <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
In-Reply-To: <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
From: Ventura Jack <venturajack85@gmail.com>
Date: Tue, 25 Feb 2025 10:21:28 -0700
X-Gm-Features: AWEUYZkUwDT8aBSZwqWOVandZso4Q43TwCtZOPgm5JWe1L0EPqYxR9ThVnT5vic
Message-ID: <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Alice Ryhl <aliceryhl@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 9:12=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Sun, Feb 23, 2025 at 4:30=E2=80=AFPM Ventura Jack <venturajack85@gmail=
.com> wrote:
> >
> > Just to be clear and avoid confusion, I would
> > like to clarify some aspects of aliasing.
> > In case that you do not already know about this,
> > I suspect that you may find it very valuable.
> >
> > I am not an expert at Rust, so for any Rust experts
> > out there, please feel free to point out any errors
> > or mistakes that I make in the following.
> >
> > The Rustonomicon is (as I gather) the semi-official
> > documentation site for unsafe Rust.
> >
> > Aliasing in C and Rust:
> >
> > C "strict aliasing":
> > - Is not a keyword.
> > - Based on "type compatibility".
> > - Is turned off by default in the kernel by using
> >     a compiler flag.
> >
> > C "restrict":
> > - Is a keyword, applied to pointers.
> > - Is opt-in to a kind of aliasing.
> > - Is seldom used in practice, since many find
> >     it difficult to use correctly and avoid
> >     undefined behavior.
> >
> > Rust aliasing:
> > - Is not a keyword.
> > - Applies to certain pointer kinds in Rust, namely
> >     Rust "references".
> >     Rust pointer kinds:
> >     https://doc.rust-lang.org/reference/types/pointer.html
> > - Aliasing in Rust is not opt-in or opt-out,
> >     it is always on.
> >     https://doc.rust-lang.org/nomicon/aliasing.html
> > - Rust has not defined its aliasing model.
> >     https://doc.rust-lang.org/nomicon/references.html
> >         "Unfortunately, Rust hasn't actually
> >         defined its aliasing model.
> >         While we wait for the Rust devs to specify
> >         the semantics of their language, let's use
> >         the next section to discuss what aliasing is
> >         in general, and why it matters."
> >     There is active experimental research on
> >     defining the aliasing model, including tree borrows
> >     and stacked borrows.
> > - The aliasing model not being defined makes
> >     it harder to reason about and work with
> >     unsafe Rust, and therefore harder to avoid
> >     undefined behavior/memory safety bugs.
>
> I think all of this worrying about Rust not having defined its
> aliasing model is way overblown. Ultimately, the status quo is that
> each unsafe operation that has to do with aliasing falls into one of
> three categories:
>
> * This is definitely allowed.
> * This is definitely UB.
> * We don't know whether we want to allow this yet.
>
> The full aliasing model that they want would eliminate the third
> category. But for practical purposes you just stay within the first
> subset and you will be happy.
>
> Alice

Is there a specification for aliasing that defines your first bullet
point, that people can read and use, as a kind of partial
specification? Or maybe a subset of your first bullet point, as a
conservative partial specification? I am guessing that stacked
borrows or tree borrows might be useful for such a purpose.
But I do not know whether either of stacked borrows or tree
borrows have only false positives, only false negatives, or both.

For Rust documentation, I have heard of the official
documentation websites at

    https://doc.rust-lang.org/book/
    https://doc.rust-lang.org/nomicon/

And various blogs, forums and research papers.

If there is no such conservative partial specification for
aliasing yet, I wonder if such a conservative partial
specification could be made with relative ease, especially if
it is very conservative, at least in its first draft. Though there
is currently no specification of the Rust language and just
one major compiler.

I know that Java defines an additional conservative reasoning
model for its memory model that is easier to reason about
than the full memory model, namely happens-before
relationship. That conservative reasoning model is taught in
official Java documentation and in books.

On the topic of difficulty, even if there was a full specification,
it might still be difficult to work with aliasing in unsafe Rust.
For C "restrict", I assume that "restrict" is fully specified, and
C developers still typically avoid "restrict". And for unsafe
Rust, the Rust community helpfully encourages people to
avoid unsafe Rust when possible due to its difficulty.

Best, VJ.

