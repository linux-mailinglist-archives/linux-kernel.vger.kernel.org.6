Return-Path: <linux-kernel+bounces-389171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C84969B697E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36162B20B16
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0104721501E;
	Wed, 30 Oct 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2YGCmmd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D112768FC;
	Wed, 30 Oct 2024 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306863; cv=none; b=SK11opp6sCzK3Yw5+TFLbkGxp8H5/Y8ayc49O2iOyZQxQ48yw9UQQ4cXhVrAygQZ7+aBNw5i0zFBjsxu9Z68JdEiPLddq31Y+qQmUWExB/TCfhuF0/XAleGq4qeTICBdeuWxppEzTzDVOXZ2xjfp2C4hFkkXrf+51sTc1DsHsfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306863; c=relaxed/simple;
	bh=G9u9zhuA94H/fUMNkQs5qyanCAF7/yxcojMjY/sX3ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrjuG55osYKlzAWFEtzz/nYHS4uzSorGVidxPqo370m5J4rTaG8iH979meB9wUc2a3gYFYE4M4F6dX87MKDEnPpa3jXNx4VEaayb/TMcPyD9hvjdCfIn6wlflHrxQffGj7cCK/qlozu95er4MovePCm2m0lam638x68J1Yv56MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2YGCmmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1DAC4CEDA;
	Wed, 30 Oct 2024 16:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730306862;
	bh=G9u9zhuA94H/fUMNkQs5qyanCAF7/yxcojMjY/sX3ZU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T2YGCmmdSBZ8gg0xGA6L+5GpJbCouJJeTP/WKv2ItzgiZDaDS4/bEDxnUKeZEUBl5
	 ue079TH0egbePlIkyn0w4Q5Ci2V2SsZi7C7Lz7yrd0wXxhHkvXAv2VjnxKiExU1Sw9
	 +7XSQ5TsYMMSflwswMty1KA3kIMRxK4olo3q2J3uowEqjwie8joHRywRHFyOOkYOeJ
	 S2EuO3wJlNgJmmAI8b8cDSY5XGmWnIRSBMrKAl4+Z1wvj8fA2Ib1EsrJGH/xTx6jxw
	 tzqcMxE6jQl/u2aXlqgYLfYhuyPy8fKIOFumSXLnZRXAK86d9MWq+AFdieza7hWQge
	 XRMT9U/38FOng==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso28494e87.2;
        Wed, 30 Oct 2024 09:47:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZH0JrnV3ntGMIoos4k+kCrlUiTf2X2eVg+YVyE5CsJXe5hxelP12w3+rjyw70tykqH75n5TnBybre+vMZ@vger.kernel.org, AJvYcCUnM0CiODB4FEKzoODqbdyfT4HmJL5PtjbQfd+EMfNMlZHixcJfNx7OitnvadCVayclFgJ5o2OEXn3tQhed+AE=@vger.kernel.org, AJvYcCXYEoesBoLndS62lvrbts78JOrA1g8BkfoTJ7OkxHqct//ROM5C/XgRMJ0Cmta+1efjdYS3qn0sew5J@vger.kernel.org
X-Gm-Message-State: AOJu0YzI2YgUi+HduQrkpXju/E89qatNoQZ7cLouaF+oAvIoiAgJeIuR
	ZZWXkR0EwEuV1ShcgLylBI96XgTOg9wLA7D59R2wZjxe+MrerlsIoOjCJqdxikaIRsCYRcYYDNG
	DFZnxzNrI2z0yb23tPDybhF6xPQ==
X-Google-Smtp-Source: AGHT+IGQ6H9qIhqtA2x22Lv1WNjZfStTB5wUkQiDjZODnFYdktSwlxnt6RTQXmtXnMQMYc0LM7iws8mWHFwymfjBU5U=
X-Received: by 2002:a05:6512:32c7:b0:536:a50a:3c25 with SMTP id
 2adb3069b0e04-53b348c1612mr8787033e87.12.1730306860915; Wed, 30 Oct 2024
 09:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
 <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org> <CAH5fLgjhiLUYPgTt_Ks+L-zhWaQG5-Yjm-Y3tfh2b2+PzT=bLg@mail.gmail.com>
 <CAL_JsqJWPR-Q=vsxSvD7V9_v=+om5mRuW9yYNqfavVRUwH9JFw@mail.gmail.com>
 <CAH5fLgiXPZqKpWSSNdx-Ww-E9h2tOLcF3_8Y4C_JQ0eU8EMwFw@mail.gmail.com>
 <CANiq72kaidDJ=81+kibMNr9jNxg467HjOm9C_4G7WRvaiddGvg@mail.gmail.com>
 <CAL_Jsq+T6T_3p2C62U3v4aSjm_oc-Ycjxi_ckF0ufh=JJDz=rg@mail.gmail.com>
 <CAH5fLggCDiKUu_dvJZeJr8UD5RvUpqRJbdYKf1F3_MvCdOVK6g@mail.gmail.com>
 <CAL_JsqL+b-f5K24qTxyA09c_QPeb07s4Hb=s1VqrdksBB4BQ=Q@mail.gmail.com> <79c47555-c9e9-4ff6-8c43-c7c26a91afd4@gmail.com>
In-Reply-To: <79c47555-c9e9-4ff6-8c43-c7c26a91afd4@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 30 Oct 2024 11:47:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJkkUk6AoAdgfVHROk=wpRo0En=gi7zwXe6S7LUEsdocQ@mail.gmail.com>
Message-ID: <CAL_JsqJkkUk6AoAdgfVHROk=wpRo0En=gi7zwXe6S7LUEsdocQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: Dirk Behme <dirk.behme@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 11:03=E2=80=AFAM Dirk Behme <dirk.behme@gmail.com> =
wrote:
>
> On 30.10.24 15:05, Rob Herring wrote:
> > On Wed, Oct 30, 2024 at 3:15=E2=80=AFAM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> >>
> >> On Tue, Oct 29, 2024 at 8:35=E2=80=AFPM Rob Herring <robh@kernel.org> =
wrote:
> >>>
> >>> On Tue, Oct 29, 2024 at 1:57=E2=80=AFPM Miguel Ojeda
> >>> <miguel.ojeda.sandonis@gmail.com> wrote:
> >>>>
> >>>> On Tue, Oct 29, 2024 at 7:48=E2=80=AFPM Alice Ryhl <aliceryhl@google=
.com> wrote:
> >>>>>
> >>>>> One option is to define a trait for integers:
> >>>
> >>> Yeah, but that doesn't feel like something I should do here. I imagin=
e
> >>> other things might need the same thing. Perhaps the bindings for
> >>> readb/readw/readl for example. And essentially the crate:num already
> >>> has the trait I need. Shouldn't the kernel mirror that? I recall
> >>> seeing some topic of including crates in the kernel?
> >>
> >> You can design the trait to look similar to traits in external crates.
> >> We did that for FromBytes/AsBytes.
> >>
> >> I assume you're referring to the PrimInt trait [1]? That trait doesn't
> >> really let you get rid of the catch-all case, and it's not even
> >> unreachable due to the u128 type.
> >
> > It was num::Integer which seems to be similar.
> >
> >>
> >> [1]: https://docs.rs/num-traits/0.2.19/num_traits/int/trait.PrimInt.ht=
ml
> >>
> >>>> +1, one more thing to consider is whether it makes sense to define a
> >>>> DT-only trait that holds all the types that can be a device property
> >>>> (like `bool` too, not just the `Integer`s).
> >>>>
> >>>> Then we can avoid e.g. `property_read_bool` and simply do it in `pro=
perty_read`.
> >>>
> >>> Is there no way to say must have traitA or traitB?
> >>
> >> No. What should it do if you pass it something that implements both tr=
aits?
> >>
> >> If you want a single function name, you'll need one trait.
> >
> > I'm not sure I want that actually.
> >
> > DT boolean is a bit special. A property not present is false.
> > Everything else is true. For example, 'prop =3D <0>' or 'prop =3D
> > "string"' are both true. I'm moving things in the kernel to be
> > stricter so that those cases are errors. I recently introduced
> > (of|device)_property_present() for that reason. There's no type
> > information stored in DT.  At the DT level, it's all just byte arrays.
> > However, we now have all the type information for properties within
> > the schema. So eventually, I want to use that to warn on accessing
> > properties with the wrong type.
> >
> > For example, I think I don't want this to work:
> >
> > if dev.property_read(c_str!("test,i16-array"))? {
> >     // do something
> > }
> >
> > But instead have:
> >
> > if dev.property_present(c_str!("test,i16-array")) {
> >     // do something
> > }
>
> I think we have "optional" properties which can be there (=3D=3D true) or
> not (=3D=3D false). Let's assume for this example "test,i16-array" is suc=
h
> kind of "optional" property. With what you gave above we need two
> device tree accesses, then? One to check if it is there and one to
> read the data:

Yes, lots of properties are optional especially since any new property
added has to be because the DT is an ABI.

> let mut array =3D <empty_marker>;
> if dev.property_present(c_str!("test,i16-array")) {
>     array =3D dev.property_read(c_str!("test,i16-array"))?;
> }
>
> ?
>
> Instead of these two accesses, I was thinking to use the error
> property_read() will return if the optional property is not there to
> just do one access:
>
> let mut array =3D <empty_marker>;
> if let Ok(val) =3D dev.property_read(c_str!("test,i16-array")) {
>        array =3D val;
> }
>
> (and ignore the error case as its irrelvant in the optional case)
>
> Have I missed anything?

If you grep "_property_present", most if not all calls never need the
data. When you need the data, you read it and test for EINVAL if you
want to handle "not present". The overhead of parsing the data is not
nothing, so I think it is better to provide both.

The typical pattern in the C code is:

u32 val =3D DEFAULT_VALUE;
of_property_read_u32(node, "a-property", &val);

// val is now either the read property or the default. If the property
is required, then the error code needs to be checked.

Maybe we should have:

let val: u32 =3D dev.property_read_optional(c_str!("test,i16-array"),
DEFAULT_VALUE);

Or looks like Option<> could be used here?:

let val: u32 =3D dev.property_read(c_str!("test,i16-array"),
Option<DEFAULT_VALUE>);

One thing I'd like to improve is having fewer driver error messages
and a printk for a missing required property is a common one. We have
APIs like clk_get and clk_get_optional (which parse firmware
properties). The difference is the former prints an error message on
error case and the latter is silent.

Rob

