Return-Path: <linux-kernel+bounces-388853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6318B9B6537
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955D71C220B1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0721EF923;
	Wed, 30 Oct 2024 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzP2bmj9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304611EE02F;
	Wed, 30 Oct 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297167; cv=none; b=bn1yyVM/c7PRCI7u6wWVo+wseMfS+X0Xautb0oQ6ve6qoV+Siu9r6BL28wvSU5R8lfiVPXaHdFWCfaRTawsUz1mhJkbyAWeiFbM7B/UjaV/chinufWjnUzH8P8gz9GqzTah0Dn404zP0jOBvRTEnpaBIOD6S2m4E86CAKTxbD4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297167; c=relaxed/simple;
	bh=GrmqlZoNz0TpM8NpGoFe5fj7IqEdF5q25++QH0auuBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSDAOGgCzDoXWeC7CwA/fnsrtRizB0i9oupuX+7Nvuyh5C5DYQkXmCUj8WRoQ9XWtcLisiBU7v1ZgPpKTFTxzY8B7ZO7wiWJ6BnIrUTANrPAbie8kduzWjn9lh9w41UY+LCsaP9DTULTiZNeNoxOdaJz51KHl77l3ltb8JSVTmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzP2bmj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57ABC4CED1;
	Wed, 30 Oct 2024 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730297166;
	bh=GrmqlZoNz0TpM8NpGoFe5fj7IqEdF5q25++QH0auuBg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LzP2bmj9AU3xmjif/OR1xSgemSO8y2JeqioNRTfxa/Lbzlf/Eh9+hUMaGhz4mFnV+
	 J0doz+2H2b5iWoHqvkpMwZEacYe+YMVqB6Xp49/dtZFB59jKDpbUrgATImW5U7h1BB
	 zZ/QWDLYJ2/XpcljqWkQ7DFTVQbhdHiWwYDOeIfj/uMEY6pzZmhOlIZvor7spf/GDj
	 v4Y6ne/7qjIWMP7b3qilD9WRrLlbFR2Sb/GX58yqC81vmVggcivhWuQQWOe9rrMlgz
	 wv59/toTTGeD3E01qWwIC5D6AfZ+h1SelSp1R2vvlMJgbvyD2UCNLvc6gRefHcRyhp
	 0ILKJo7UF83kg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb3ce15172so9310791fa.0;
        Wed, 30 Oct 2024 07:06:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrweV4YYyBapi/duR1wfqinpOFs3eV/0B7BK481kRrENyc2WKc+Th5k+CE58Ri6ly7W8ddPtsXWfWYudKEgjY=@vger.kernel.org, AJvYcCVgt8WYUTVRkJT0z4o2JXTNFBjXjQKeQ4hcQT7NlKI4yEnB/3cEzNcmknkPjy0jAyTBnpDQTrK4XZhc@vger.kernel.org, AJvYcCWcxoE7LtHcV5f3HqzPMuVK7DaIyW8yC1Fb25fs8VaenxBlaDPj9wcO6rLnvsuAhSEnHKbt+NE5xIb1OL4W@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8eCSlAP8uKZ0nHLT3ztYhLGE9s+QXFjLcfrFmma/XzA3ySAdu
	DQE9wHlVeA1EX72FRSqNxcU/lcJHAkWgcZomAGSIcjVnXWqfw+JSV4CGldLObjY+UvYjV6RALGA
	YR+bPBclx6FEsGrYy4CAvv6QATQ==
X-Google-Smtp-Source: AGHT+IHraIDvgEshI6B9Lhwn0jf1bScQv1+cJh9BmMoQ68/u5a9ivzRXYW10ns73NHalIqSCwJ3femN7Utb8XdqZF+8=
X-Received: by 2002:a05:6512:a93:b0:53b:48f2:459b with SMTP id
 2adb3069b0e04-53c316319a7mr876648e87.23.1730297165207; Wed, 30 Oct 2024
 07:06:05 -0700 (PDT)
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
 <CAL_Jsq+T6T_3p2C62U3v4aSjm_oc-Ycjxi_ckF0ufh=JJDz=rg@mail.gmail.com> <CAH5fLggCDiKUu_dvJZeJr8UD5RvUpqRJbdYKf1F3_MvCdOVK6g@mail.gmail.com>
In-Reply-To: <CAH5fLggCDiKUu_dvJZeJr8UD5RvUpqRJbdYKf1F3_MvCdOVK6g@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 30 Oct 2024 09:05:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL+b-f5K24qTxyA09c_QPeb07s4Hb=s1VqrdksBB4BQ=Q@mail.gmail.com>
Message-ID: <CAL_JsqL+b-f5K24qTxyA09c_QPeb07s4Hb=s1VqrdksBB4BQ=Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Saravana Kannan <saravanak@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 3:15=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Tue, Oct 29, 2024 at 8:35=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Tue, Oct 29, 2024 at 1:57=E2=80=AFPM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > >
> > > On Tue, Oct 29, 2024 at 7:48=E2=80=AFPM Alice Ryhl <aliceryhl@google.=
com> wrote:
> > > >
> > > > One option is to define a trait for integers:
> >
> > Yeah, but that doesn't feel like something I should do here. I imagine
> > other things might need the same thing. Perhaps the bindings for
> > readb/readw/readl for example. And essentially the crate:num already
> > has the trait I need. Shouldn't the kernel mirror that? I recall
> > seeing some topic of including crates in the kernel?
>
> You can design the trait to look similar to traits in external crates.
> We did that for FromBytes/AsBytes.
>
> I assume you're referring to the PrimInt trait [1]? That trait doesn't
> really let you get rid of the catch-all case, and it's not even
> unreachable due to the u128 type.

It was num::Integer which seems to be similar.

>
> [1]: https://docs.rs/num-traits/0.2.19/num_traits/int/trait.PrimInt.html
>
> > > +1, one more thing to consider is whether it makes sense to define a
> > > DT-only trait that holds all the types that can be a device property
> > > (like `bool` too, not just the `Integer`s).
> > >
> > > Then we can avoid e.g. `property_read_bool` and simply do it in `prop=
erty_read`.
> >
> > Is there no way to say must have traitA or traitB?
>
> No. What should it do if you pass it something that implements both trait=
s?
>
> If you want a single function name, you'll need one trait.

I'm not sure I want that actually.

DT boolean is a bit special. A property not present is false.
Everything else is true. For example, 'prop =3D <0>' or 'prop =3D
"string"' are both true. I'm moving things in the kernel to be
stricter so that those cases are errors. I recently introduced
(of|device)_property_present() for that reason. There's no type
information stored in DT.  At the DT level, it's all just byte arrays.
However, we now have all the type information for properties within
the schema. So eventually, I want to use that to warn on accessing
properties with the wrong type.

For example, I think I don't want this to work:

if dev.property_read(c_str!("test,i16-array"))? {
    // do something
}

But instead have:

if dev.property_present(c_str!("test,i16-array")) {
    // do something
}

To actually warn on property_read_bool, I'm going to have to rework
the underlying C implementation to separate device_property_present
and device_property_read_bool implementations.

Rob

