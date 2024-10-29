Return-Path: <linux-kernel+bounces-387504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DCB9B520F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C0B1F24266
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDC9205142;
	Tue, 29 Oct 2024 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xXqhOR4L"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421261DE2BD
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227712; cv=none; b=DiHlXtZA9jA3Fk7XEY8kq8q5Aftbr6EXv6V8xyc0+YdEaHj1+xp0dhOgyOHE1wqo/1o3v0cjvbI0s9CmJxmaPFjroghHWcOPybxgmstiOh6ZQcMkAuY6h1LWiltNLmWmi17OF/DXdYEY8x/Yd4O/ecyxgzLNFJELxda+fWiVsac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227712; c=relaxed/simple;
	bh=7bQ2c5K2bySeqxQLy/E0/yWXCi6/x2r8Sa5nZWj7IcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgUjAXbUtCD1S5k5NHp9DNCNQwldyp3+Cj0l0eNfKS6gOfO+x1Kgucnv8KzoOOkGIh09tbTHfAJ12enOSV4xw8e4zgzzpFgVSWn+X/+QLivcZjnFY62ki9qihCcOoykodJuVftSDpWNRbpL/NUSDDm5rkWCc7/U36x6Oza6ose0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xXqhOR4L; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d4a5ecc44so3745064f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730227708; x=1730832508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nq33YNnXaO1IemEIjM7xWgkz4Yk6zdfg2TYveKMKzik=;
        b=xXqhOR4LG4XukME6zhLXu3baOC4HlcSvIjxIvUBH+1RorWc7cOkH3JqUBxuekYfkt9
         kU1TwR9lbgZbf26Dv7ieU089YBdRazlPz9Ex6FaeAWHWqTRQt/wS3EuSxH4q/PCQHSpJ
         kOCRB7OROR2PMQd6snwMaGkMNRKL7aEgX70pCwSpQQfWaKPbCR6k+joWVTOZ+wFPDebg
         oej6oFGe/R6sm9vPS7/a26vXr+kNFqKk9FqsinOf2dx/DPDW8SHml5hg9N76TZegYsnA
         kafbljxD05zyWy5uLYmA2A310e2XEGKJ8jnkGwH4UtRSgs1+tdK4zXb+wJBPJksdMf2t
         Doaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730227708; x=1730832508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nq33YNnXaO1IemEIjM7xWgkz4Yk6zdfg2TYveKMKzik=;
        b=HCS3uZgwh6mehvGx+d2ulEZolx73Ogl0HddY17k6gt2wNO9dC9ZOAniie5U7sDzRr2
         UjhdkRsnLTz9bFpMmkbEvBBuQh0feZKGEA/n2/HBVnr4ama1NL79zycC5qJ0iEoiYt5X
         hWj531FIprbtjPJQfO1cFXkiX81R1NAPW1ag4pn85nCorzqIR5oHZkKdziuguZR0Hwo4
         PRCgCOJ57OqCPlzjlwYTzI6Urx9cYFKBQmwzYJJkXEElBc9jTE77pKXYIrR3amfVngbZ
         fJNmriUeZUtJZ9P7IJF+F0cBHCFFNtegykAc8y2ta2oYvfIZs/ysid4hp1DsliINy1+R
         skBw==
X-Forwarded-Encrypted: i=1; AJvYcCWXfIrADdzAvAZwvmQRcGQlwJqWLluibvzvdW/OlCh95RJ3nWGd9vVO1dC++o+aJN1DO4WkqqlvzJUhTEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9C6ZVfhi6m0J9vkQpEywSy+PiQIq6FAYGtvq1qKrEpMW/ywDn
	cucok5OJX4WLLvmChA3PrdEygKYzQyrUUvZF6qd4smvu85Zt9VPMqqMdFIsMcHZlr7QY5p9KrNr
	PPA0zPnXFu1EBqJWzLAEFL/G99DYrjnyCvuq6
X-Google-Smtp-Source: AGHT+IE4V1McJ1YIF4n1pbor8M12iqCCsEPeL1YeNp9Ovb0vaRsRmYSJlv6qVmLNxEUxcVPtNTwkrTs5FEo51gdIpbA=
X-Received: by 2002:adf:fb85:0:b0:37d:5047:76d8 with SMTP id
 ffacd0b85a97d-38061205e66mr9038891f8f.59.1730227708483; Tue, 29 Oct 2024
 11:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
 <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org> <CAH5fLgjhiLUYPgTt_Ks+L-zhWaQG5-Yjm-Y3tfh2b2+PzT=bLg@mail.gmail.com>
 <CAL_JsqJWPR-Q=vsxSvD7V9_v=+om5mRuW9yYNqfavVRUwH9JFw@mail.gmail.com>
In-Reply-To: <CAL_JsqJWPR-Q=vsxSvD7V9_v=+om5mRuW9yYNqfavVRUwH9JFw@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 29 Oct 2024 19:48:15 +0100
Message-ID: <CAH5fLgiXPZqKpWSSNdx-Ww-E9h2tOLcF3_8Y4C_JQ0eU8EMwFw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 6:58=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Tue, Oct 29, 2024 at 9:16=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > On Fri, Oct 25, 2024 at 11:06=E2=80=AFPM Rob Herring (Arm) <robh@kernel=
.org> wrote:
> > > +
> > > +    /// Returns array length for firmware property `name`
> > > +    ///
> > > +    /// Valid types are i8, u8, i16, u16, i32, u32, i64, u64
> > > +    pub fn property_count_elem<T>(&self, name: &CStr) -> Result<usiz=
e> {
> >
> > This always returns usize? I'm a bit confused ...
>
> The C version returned an int so we could return an errno or positive
> count. With Result, we don't need negative values and isn't usize
> generally used for counts of things like size_t in C?

Ok, I think I misunderstood what this does. usize is fine.

> > > +        match size_of::<T>() {
> > > +            1 =3D> {
> > > +                ret =3D unsafe {
> > > +                    bindings::device_property_read_u8_array(
> > > +                        self.as_raw(),
> > > +                        name.as_ptr() as *const i8,
> > > +                        ptr::null_mut(),
> > > +                        0,
> > > +                    )
> > > +                }
> > > +            }
> > > +            2 =3D> {
> > > +                ret =3D unsafe {
> > > +                    bindings::device_property_read_u16_array(
> > > +                        self.as_raw(),
> > > +                        name.as_ptr() as *const i8,
> > > +                        ptr::null_mut(),
> > > +                        0,
> > > +                    )
> > > +                }
> > > +            }
> > > +            4 =3D> {
> > > +                ret =3D unsafe {
> > > +                    bindings::device_property_read_u32_array(
> > > +                        self.as_raw(),
> > > +                        name.as_ptr() as *const i8,
> > > +                        ptr::null_mut(),
> > > +                        0,
> > > +                    )
> > > +                }
> > > +            }
> > > +            8 =3D> {
> > > +                ret =3D unsafe {
> > > +                    bindings::device_property_read_u64_array(
> > > +                        self.as_raw(),
> > > +                        name.as_ptr() as *const i8,
> > > +                        ptr::null_mut(),
> > > +                        0,
> > > +                    )
> > > +                }
> > > +            }
> > > +            _ =3D> return Err(EINVAL),
> >
> > You can use `kernel::build_error!` here to trigger a build failure if
> > the size is wrong.
>
> I really want a build error if the type is wrong, then the _ case
> would be unreachable. No way to do that?

One option is to define a trait for integers:

trait Integer: FromBytes + AsBytes + Copy {
    const SIZE: IntSize;
}

enum IntSize {
    S8,
    S16,
    S32,
    S64,
}

macro_rules! impl_int {
    ($($typ:ty),* $(,)?) =3D> {$(
        impl Integer for $typ {
            const SIZE: IntSize =3D match size_of::<Self>() {
                1 =3D> IntSize::S8,
                2 =3D> IntSize::S16,
                4 =3D> IntSize::S32,
                8 =3D> IntSize::S64,
                _ =3D> panic!("invalid size"),
            };
        }
    )*};
}

impl_int! {
    u8, u16, u32, u64, usize,
    i8, i16, i32, i64, isize,
}

Using the above trait, you can match on the IntSize.

pub fn property_count_elem<T: Integer>(&self, name: &CStr) -> Result<usize>=
 {
match T::SIZE {
    IntSize::S8 =3D> ...,
    IntSize::S16 =3D> ...,
    IntSize::S32 =3D> ...,
    IntSize::S64 =3D> ...,
}

this leaves no catch-all case and calling it with non-integer types
will not compile.

Alice

