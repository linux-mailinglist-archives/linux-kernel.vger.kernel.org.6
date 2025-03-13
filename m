Return-Path: <linux-kernel+bounces-559757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0E5A5F92B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDBE2189AA06
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E4A268C4F;
	Thu, 13 Mar 2025 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5oxhg8q"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8B267B7A;
	Thu, 13 Mar 2025 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878009; cv=none; b=AeIDJQsSTviHR0GSzxny5Gsc9zh+Pgw93rJ2BTDff3irLgMUtC2Bc5Y+PxGxPJ0YNI6ZYZv6JF73IkZMRj0nLNisxx+iaI5cw+eamgJPDMDLSM0hdt6G5pfzhBBtXTiz5eJAFgyUlwfZQNZF+kHzRkaSJGreyeRhkQhI4jswLnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878009; c=relaxed/simple;
	bh=KC1m31817J7462d/SmhYdKFn5PuYI2mViXOADan3lxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQY8ISobVe1eY7Nh26mGs7Hg7JNPArKe4ByYLad1F375k3hPtC9/OUgmSB6+kNm4OamocRX7i5AyLC2d6JY58wKAl/8DlXWWzxarMxkVGA4MYrTxAABw+Mb8hI6Ie8lKTgli0C0TqOMAc47uB+U4xt5HkQdh+dn0rdAmuipTDog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5oxhg8q; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c24ae82de4so109228185a.1;
        Thu, 13 Mar 2025 08:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741878006; x=1742482806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyPn7NjBk5S3/v/4X6t5VKp3w1Z1FvuZfz4F9ZBY5FA=;
        b=D5oxhg8qg6l2D/0w4K5pOIS7kb/4F2qfrKPoLemC8yOnV0fpCAgsb/i6+b2Az0p1qj
         YszWmcKCjNfgKJK2vfkIXK6bAst5yB8jMNF0XrXO6xMYppmNdqQd2j3TgNs9ffFxF1qw
         NfQEmdDlmycdCE/wRRnQu+b8101qWCS8P7z3sofQMJErF7S9tDV+xjyA3yvDEzVdAIzu
         aHzmEQj5pkfwqOSELz0q/RzHlGQdqITk/PX1GZmodcKkU2NrH5s3hOrDwxervBlb7TbM
         iC+MQKKm5NQ0fWHhraIkm1BYmIJDWa8y/XjIBp+sYqxr8CKPtDAD7u7iagnWj+kwvxUX
         w+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741878006; x=1742482806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyPn7NjBk5S3/v/4X6t5VKp3w1Z1FvuZfz4F9ZBY5FA=;
        b=l5mK7ZVyLJXXkz/OBJsW4vxGI3dx4QuxUE1ItgCKosYAOskbuGOF6wZUeZXBPDDcle
         61DPRl142lULAg+D4MBRnqSHehD54sCpkiJBNzuL6Kdc1Y3/gIwoPCENbpFpManc5uEr
         iLBI+rYfkeLwp3FSjTDuA5SHFxUks2BPTUef/cmB9vfIjG8CUJUcxVeLUn8ijsxgwq35
         S2K3Rh5I+T87wpNBwKeZHxFNdqiLOgwOUvD9Q/TdjKCAQFZy2BfyU02n58+e9lZHEwdD
         aBg2Nnjn3BCt/UULUa9SrIe0z5hFh8EuqDhdv7NMKUTMgcJKZwqjzbLDxa8DedW7qrol
         hvUA==
X-Forwarded-Encrypted: i=1; AJvYcCWfzizMU/EXAtO7cr1GQ6sBr+OOrXkrijyETS7lgqIpTUdNXTTlTaCCoF4wlaqiO654BxfOa6n9RRNBBWDxolk=@vger.kernel.org, AJvYcCX8HYyZZV4em9F0BnGmKkKzqYObwna3/uPFaRdC3s+10nGhkzxv58NtsOawtiATy90XdH3ZeUsCIITbQaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPQPb+xdlAhHebEhI3qwvTKYFDqP1yGj/haZqbkyN9tixZCTEY
	+z1k+45fdwkPOZZS/sKNgM+xiAP7nncVVOIbUTsLdkWqcRKn9Sb6
X-Gm-Gg: ASbGncsUT9vVQff4NyKs6aTVgolzXM2nKa+jJzcblWx3nxZv6LDrTaVJ7rzj594hum3
	elILhDe0vZxE/BdajZy0A9GhYAdrm4MOV8L9iRElubRQOM/LVAhuWwO/7FohyqPW4dJE7yexQYz
	4hy6s3ExHLL2hL/M6bidykU9GlPmsBF9MwOcFktgwNr7er4ClpQQHmyOOmwfIeJsKcN7B5C5NJN
	knVFOuc+jylXiloyRtKhYJnkRsHZJB2d8ojVKq5e92FnYArvy+isi928dE3wh3IkDpD11C48n31
	TdaeeuOwMKgE/u2UIExaHCoN4hGnMDLQmNS5JVhW7nS6Uz2opQDYquDVIBa1dzKQezBaRri0Kh0
	tObF1Je+or9+R4D/sD0a2+HyXQFtatjvA6ow=
X-Google-Smtp-Source: AGHT+IGJLszst2prXRgVjyt/QDtTt/i9C9tc48ilAaxuLQv9Z7ou63EzpbJA2WopAZyHMMgeYc4OXw==
X-Received: by 2002:a05:620a:489a:b0:7c5:4750:92ff with SMTP id af79cd13be357-7c55e843a89mr2064223485a.7.1741878004819;
        Thu, 13 Mar 2025 08:00:04 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9a818sm107776585a.50.2025.03.13.08.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 08:00:04 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id B41221200071;
	Thu, 13 Mar 2025 11:00:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 13 Mar 2025 11:00:03 -0400
X-ME-Sender: <xms:8_LSZ-1SyuH9AvYs7m-0Ls75Aomku9NjcaQJOmGfJqTsMOT9va_j1g>
    <xme:8_LSZxFZGCooH_Ed5cYy1mZ6WUnICruQG-5s_ENc75HaPFyfWsln6svCff5k5h4kq
    aExsA234GumKvWgoQ>
X-ME-Received: <xmr:8_LSZ26Kb529KeYIrnGwRhU1167lFz3NZEShx3ccXnTpXrbNKq9n6kVD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegrtghouhhrsghothesnhhvihguihgrrd
    gtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesgh
    grrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhm
    rghilhdrtghomhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrd
    hmvgdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepthhmgh
    hrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:8_LSZ_0wKIWpY6PDq29PVbF_7lHjd1hnu5CGcEbIFKv0EUcOQiRcvA>
    <xmx:8_LSZxHun5l7ezOle6sESUF-rls_W1tc_9FzOXZhuocnvGth3CFAQg>
    <xmx:8_LSZ48_js-CGA84apO00xMpALFFaHJ22ZFiZvtDoyg01N5KIyBQZg>
    <xmx:8_LSZ2kbHTkzszmBj1cJHsoozWqGS0OHeMMmko0yAz0zrIQqIylm7w>
    <xmx:8_LSZ5HOgdPinX6vlSEvl-2wdjIXmo1kZxiZ3sJc3MFnoKTJgwY8o8bB>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 11:00:03 -0400 (EDT)
Date: Thu, 13 Mar 2025 08:00:01 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH RFC] rust: add macros to define registers layout
Message-ID: <Z9Ly8R-kZaiamicV@Mac.home>
References: <20250313-registers-v1-1-8d498537e8b2@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-registers-v1-1-8d498537e8b2@nvidia.com>

On Thu, Mar 13, 2025 at 11:48:25PM +0900, Alexandre Courbot wrote:
> Add two macros, reg_def!() and reg_def_rel!(), that define a given
> register's layout and provide accessors for absolute or relative
> offsets, respectively.
> 
> The following example (taken from the rustdoc) helps understanding how
> they are used:
> 
>     reg_def!(Boot0@0x00000100, "Basic revision information about the chip";
>         3:0     minor_rev => as u8, "minor revision of the chip";
>         7:4     major_rev => as u8, "major revision of the chip";
>         28:20   chipset => try_into Chipset, "chipset model"
>     );
> 
> This defines a `Boot0` type which can be read or written from offset
> `0x100` of an `Io` region. It is composed of 3 fields, for instance
> `minor_rev` is made of the 4 less significant bits of the register. Each
> field can be accessed and modified using helper methods:
> 
>     // Read from offset `0x100`.
>     let boot0 = Boot0.read(&bar);
>     pr_info!("chip revision: {}.{}", boot0.major_rev(), boot0.minor_rev());
> 
>     // `Chipset::try_from` will be called with the value of the field and
>     // returns an error if the value is invalid.
>     let chipset = boot0.chipset()?;
> 
>     // Update some fields and write the value back.
>     boot0.set_major_rev(3).set_minor_rev(10).write(&bar);
> 
> Fields are made accessible using one of the following strategies:
> 
> - `as <type>` simply casts the field value to the requested type.
> - `as_bit <type>` turns the field into a boolean and calls
>   <type>::from()` with the obtained value. To be used with single-bit
>   fields.
> - `into <type>` calls `<type>::from()` on the value of the field. It is
>   expected to handle all the possible values for the bit range selected.
> - `try_into <type>` calls `<type>::try_from()` on the value of the field
>   and returns its result.
> 
> The documentation strings are optional. If present, they will be added
> to the type or the field getter and setter methods they are attached to.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> I have written these initially for the nova-core driver, then it has
> been suggested that they might be useful outside of it as well, so here
> goes.
> 
> This is my first serious attempt at writing Rust macros and I am sure
> there is a lot that is wrong with them, but I'd like to get early
> feedback and see whether this is actually something we want for the
> kernel in general.
> 
> The following in particular needs to be improved, suggestions are
> welcome:
> 
> - Inner types other than `u32` need to be supported - this can probably
>   just be an extra parameter of the macro.
> - The syntax can certainly be improved. I've tried to some with
>   something that makes the register layout obvious, while fitting within
>   the expectations of the Rust macro parser, but my lack of experience
>   certainly shows here.
> - We probably need an option to make some fields or whole registers
>   read-only.
> - The I/O offset and read/write methods should be optional, so the
>   layout part can be used for things that are not registers.
> - The visibility of the helper macros is a bit of a headache - I haven't
>   found a way to completely hide them to the outside, so I have prefixed
>   them with `__` for now.
> - Formatting - there are some pretty long lines, not sure how to break
>   them in an idiomatic way.
> 
> Sorry if this is still a bit rough around the edges, but hopefully the
> potential benefit is properly conveyed.
> ---
>  rust/kernel/lib.rs |   1 +
>  rust/kernel/reg.rs | 284 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 285 insertions(+)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 398242f92a961c3a445d681c65449047a847968a..d610199f6675d22fa01d4db524d9989581f7b646 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -69,6 +69,7 @@
>  pub mod prelude;
>  pub mod print;
>  pub mod rbtree;
> +mod reg;

This is for io registers? Could you please move it into kernel::io
instead of defining it as a top level mod?

Regards,
Boqun

>  pub mod revocable;
>  pub mod security;
>  pub mod seq_file;
> diff --git a/rust/kernel/reg.rs b/rust/kernel/reg.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..3f0bad18b4f757fb3e7d45f2fde6c3214fa957c8
> --- /dev/null
> +++ b/rust/kernel/reg.rs
> @@ -0,0 +1,284 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Types and macros to define register layout and accessors.
> +//!
> +//! A single register typically includes several fields, which are accessed through a combination
> +//! of bit-shift and mask operations that introduce a class of potential mistakes, notably because
> +//! not all possible field values are necessarily valid.
> +//!
> +//! The macros in this module allow to define, using an intruitive and readable syntax, a dedicated
> +//! type for each register with its own field accessors that can return an error is a field's value
> +//! is invalid. They also provide a builder type allowing to construct a register value to be
> +//! written by combining valid values for its fields.
> +
> +/// Helper macro for the `reg_def` family of macros.
> +///
> +/// Defines the wrapper `$name` type, as well as its relevant implementations (`Debug`, `BitOr`,
> +/// and conversion to regular `u32`).
> +#[macro_export]
> +macro_rules! __reg_def_common {
> +    ($name:ident $(, $type_comment:expr)?) => {
> +        $(
> +        #[doc=$type_comment]
> +        )?
> +        #[repr(transparent)]
> +        #[derive(Clone, Copy, Default)]
> +        pub(crate) struct $name(u32);
> +
> +        // TODO: should we display the raw hex value, then the value of all its fields?
> +        impl ::core::fmt::Debug for $name {
> +            fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
> +                f.debug_tuple(stringify!($name))
> +                    .field(&format_args!("0x{0:x}", &self.0))
> +                    .finish()
> +            }
> +        }
> +
> +        impl core::ops::BitOr for $name {
> +            type Output = Self;
> +
> +            fn bitor(self, rhs: Self) -> Self::Output {
> +                Self(self.0 | rhs.0)
> +            }
> +        }
> +
> +        impl From<$name> for u32 {
> +            fn from(reg: $name) -> u32 {
> +                reg.0
> +            }
> +        }
> +    };
> +}
> +
> +/// Helper macro for the `reg_def` family of macros.
> +///
> +/// Defines the getter method for $field.
> +#[macro_export]
> +macro_rules! __reg_def_field_getter {
> +    (
> +        $hi:tt:$lo:tt $field:ident
> +            $(=> as $as_type:ty)?
> +            $(=> as_bit $bit_type:ty)?
> +            $(=> into $type:ty)?
> +            $(=> try_into $try_type:ty)?
> +        $(, $comment:expr)?
> +    ) => {
> +        $(
> +        #[doc=concat!("Returns the ", $comment)]
> +        )?
> +        #[inline]
> +        pub(crate) fn $field(self) -> $( $as_type )? $( $bit_type )? $( $type )? $( core::result::Result<$try_type, <$try_type as TryFrom<u32>>::Error> )? {
> +            const MASK: u32 = ((((1 << $hi) - 1) << 1) + 1) - ((1 << $lo) - 1);
> +            const SHIFT: u32 = MASK.trailing_zeros();
> +            let field = (self.0 & MASK) >> SHIFT;
> +
> +            $( field as $as_type )?
> +            $(
> +            // TODO: it would be nice to throw a compile-time error if $hi != $lo as this means we
> +            // are considering more than one bit but returning a bool...
> +            <$bit_type>::from(if field != 0 { true } else { false }) as $bit_type
> +            )?
> +            $( <$type>::from(field) )?
> +            $( <$try_type>::try_from(field) )?
> +        }
> +    }
> +}
> +
> +/// Helper macro for the `reg_def` family of macros.
> +///
> +/// Defines all the field getter methods for `$name`.
> +#[macro_export]
> +macro_rules! __reg_def_getters {
> +    (
> +        $name:ident
> +        $(; $hi:tt:$lo:tt $field:ident
> +            $(=> as $as_type:ty)?
> +            $(=> as_bit $bit_type:ty)?
> +            $(=> into $type:ty)?
> +            $(=> try_into $try_type:ty)?
> +        $(, $field_comment:expr)?)* $(;)?
> +    ) => {
> +        #[allow(dead_code)]
> +        impl $name {
> +            $(
> +            ::kernel::__reg_def_field_getter!($hi:$lo $field $(=> as $as_type)? $(=> as_bit $bit_type)? $(=> into $type)? $(=> try_into $try_type)? $(, $field_comment)?);
> +            )*
> +        }
> +    };
> +}
> +
> +/// Helper macro for the `reg_def` family of macros.
> +///
> +/// Defines the setter method for $field.
> +#[macro_export]
> +macro_rules! __reg_def_field_setter {
> +    (
> +        $hi:tt:$lo:tt $field:ident
> +            $(=> as $as_type:ty)?
> +            $(=> as_bit $bit_type:ty)?
> +            $(=> into $type:ty)?
> +            $(=> try_into $try_type:ty)?
> +        $(, $comment:expr)?
> +    ) => {
> +        kernel::macros::paste! {
> +        $(
> +        #[doc=concat!("Sets the ", $comment)]
> +        )?
> +        #[inline]
> +        pub(crate) fn [<set_ $field>](mut self, value: $( $as_type)? $( $bit_type )? $( $type )? $( $try_type)? ) -> Self {
> +            const MASK: u32 = ((((1 << $hi) - 1) << 1) + 1) - ((1 << $lo) - 1);
> +            const SHIFT: u32 = MASK.trailing_zeros();
> +
> +            let value = ((value as u32) << SHIFT) & MASK;
> +            self.0 = self.0 | value;
> +            self
> +        }
> +        }
> +    };
> +}
> +
> +/// Helper macro for the `reg_def` family of macros.
> +///
> +/// Defines all the field setter methods for `$name`.
> +#[macro_export]
> +macro_rules! __reg_def_setters {
> +    (
> +        $name:ident
> +        $(; $hi:tt:$lo:tt $field:ident
> +            $(=> as $as_type:ty)?
> +            $(=> as_bit $bit_type:ty)?
> +            $(=> into $type:ty)?
> +            $(=> try_into $try_type:ty)?
> +        $(, $field_comment:expr)?)* $(;)?
> +    ) => {
> +        #[allow(dead_code)]
> +        impl $name {
> +            $(
> +            ::kernel::__reg_def_field_setter!($hi:$lo $field $(=> as $as_type)? $(=> as_bit $bit_type)? $(=> into $type)? $(=> try_into $try_type)? $(, $field_comment)?);
> +            )*
> +        }
> +    };
> +}
> +
> +/// Defines a dedicated type for a register with an absolute offset, alongside with getter and
> +/// setter methods for its fields and methods to read and write it from an `Io` region.
> +///
> +/// Example:
> +///
> +/// ```no_run
> +/// reg_def!(Boot0@0x00000100, "Basic revision information about the chip";
> +///     3:0     minor_rev => as u8, "minor revision of the chip";
> +///     7:4     major_rev => as u8, "major revision of the chip";
> +///     28:20   chipset => try_into Chipset, "chipset model"
> +/// );
> +/// ```
> +///
> +/// This defines a `Boot0` type which can be read or written from offset `0x100` of an `Io` region.
> +/// It is composed of 3 fields, for instance `minor_rev` is made of the 4 less significant bits of
> +/// the register. Each field can be accessed and modified using helper methods:
> +///
> +/// ```no_run
> +/// // Read from offset 0x100.
> +/// let boot0 = Boot0.read(&bar);
> +/// pr_info!("chip revision: {}.{}", boot0.major_rev(), boot0.minor_rev());
> +///
> +/// // `Chipset::try_from` will be called with the value of the field and returns an error if the
> +/// // value is invalid.
> +/// let chipset = boot0.chipset()?;
> +///
> +/// // Update some fields and write the value back.
> +/// boot0.set_major_rev(3).set_minor_rev(10).write(&bar);
> +/// ```
> +///
> +/// Fields are made accessible using one of the following strategies:
> +///
> +/// - `as <type>` simply casts the field value to the requested type.
> +/// - `as_bit <type>` turns the field into a boolean and calls `<type>::from()` with the obtained
> +///   value. To be used with single-bit fields.
> +/// - `into <type>` calls `<type>::from()` on the value of the field. It is expected to handle all
> +///   the possible values for the bit range selected.
> +/// - `try_into <type>` calls `<type>::try_from()` on the value of the field and returns its
> +///   result.
> +///
> +/// The documentation strings are optional. If present, they will be added to the type or the field
> +/// getter and setter methods they are attached to.
> +#[macro_export]
> +macro_rules! reg_def {
> +    (
> +        $name:ident@$offset:expr $(, $type_comment:expr)?
> +        $(; $hi:tt:$lo:tt $field:ident
> +            $(=> as $as_type:ty)?
> +            $(=> as_bit $bit_type:ty)?
> +            $(=> into $type:ty)?
> +            $(=> try_into $try_type:ty)?
> +        $(, $field_comment:expr)?)* $(;)?
> +    ) => {
> +        ::kernel::__reg_def_common!($name);
> +
> +        #[allow(dead_code)]
> +        impl $name {
> +            #[inline]
> +            pub(crate) fn read<const SIZE: usize, T: Deref<Target=Io<SIZE>>>(bar: &T) -> Self {
> +                Self(bar.readl($offset))
> +            }
> +
> +            #[inline]
> +            pub(crate) fn write<const SIZE: usize, T: Deref<Target=Io<SIZE>>>(self, bar: &T) {
> +                bar.writel(self.0, $offset)
> +            }
> +        }
> +
> +        ::kernel::__reg_def_getters!($name; $( $hi:$lo $field $(=> as $as_type)? $(=> as_bit $bit_type)? $(=> into $type)? $(=> try_into $try_type)? $(, $field_comment)? );*);
> +
> +        ::kernel::__reg_def_setters!($name; $( $hi:$lo $field $(=> as $as_type)? $(=> as_bit $bit_type)? $(=> into $type)? $(=> try_into $try_type)? $(, $field_comment)? );*);
> +    };
> +}
> +
> +/// Defines a dedicated type for a register with a relative offset, alongside with getter and
> +/// setter methods for its fields and methods to read and write it from an `Io` region.
> +///
> +/// See the documentation for [`reg_def`] for more details. This macro works similarly to
> +/// `reg_def`, with the exception that the `read` and `write` methods take a `base` argument that
> +/// is added to the offset of the register before access, and the `try_read` and `try_write`
> +/// methods are added to allow access with offsets unknown at compile-time.
> +#[macro_export]
> +macro_rules! reg_def_rel {
> +    (
> +        $name:ident@$offset:expr $(, $type_comment:expr)?
> +        $(; $hi:tt:$lo:tt $field:ident
> +            $(=> as $as_type:ty)?
> +            $(=> as_bit $bit_type:ty)?
> +            $(=> into $type:ty)?
> +            $(=> try_into $try_type:ty)?
> +        $(, $field_comment:expr)?)* $(;)?
> +    ) => {
> +        ::kernel::__reg_def_common!($name);
> +
> +        #[allow(dead_code)]
> +        impl $name {
> +            #[inline]
> +            pub(crate) fn read<const SIZE: usize, T: Deref<Target=Io<SIZE>>>(bar: &T, base: usize) -> Self {
> +                Self(bar.readl(base + $offset))
> +            }
> +
> +            #[inline]
> +            pub(crate) fn write<const SIZE: usize, T: Deref<Target=Io<SIZE>>>(self, bar: &T, base: usize) {
> +                bar.writel(self.0, base + $offset)
> +            }
> +
> +            #[inline]
> +            pub(crate) fn try_read<const SIZE: usize, T: Deref<Target=Io<SIZE>>>(bar: &T, base: usize) -> ::kernel::error::Result<Self> {
> +                bar.try_readl(base + $offset).map(Self)
> +            }
> +
> +            #[inline]
> +            pub(crate) fn try_write<const SIZE: usize, T: Deref<Target=Io<SIZE>>>(self, bar: &T, base: usize) -> ::kernel::error::Result<()> {
> +                bar.try_writel(self.0, base + $offset)
> +            }
> +        }
> +
> +        ::kernel::__reg_def_getters!($name; $( $hi:$lo $field $(=> as $as_type)? $(=> as_bit $bit_type)? $(=> into $type)? $(=> try_into $try_type)? $(, $field_comment)? );*);
> +
> +        ::kernel::__reg_def_setters!($name; $( $hi:$lo $field $(=> as $as_type)? $(=> as_bit $bit_type)? $(=> into $type)? $(=> try_into $try_type)? $(, $field_comment)? );*);
> +    };
> +}
> 
> ---
> base-commit: 4d872d51bc9d7b899c1f61534e3dbde72613f627
> change-id: 20250313-registers-7fdcb3d926b0
> 
> Best regards,
> -- 
> Alexandre Courbot <acourbot@nvidia.com>
> 

