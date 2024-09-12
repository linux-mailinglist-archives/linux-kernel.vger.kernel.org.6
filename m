Return-Path: <linux-kernel+bounces-327343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2F997746A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2791F25447
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035681C2322;
	Thu, 12 Sep 2024 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F9Hz1K1Q"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9551C2332
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726180707; cv=none; b=rQmCDEZOFPzlano93XNNvOIQvyP+/RGoRGbg6WcCIzBcR6ynzinZg1+Q/EQbBKat4+WkPuxKls1fXlP6gu4cvaBAAE6KHBsTc/tMCqtHnR1lZGc4Z+rNOs59PMTFl3HpV7MPLZDgTwy7DgBJoOkzD2k8DM3gL8YErd+5HLSDkIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726180707; c=relaxed/simple;
	bh=9mj6BM6fizLwX9nwJwjHGY4UPMEYPOw8jxKpidVNMZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chvVahn4qPNnbD/NV4V1esZiE0B/K69TIH7c3U/UG6LD990hcs/dou+Hr1OXkdUaaiFdM+K4h9msOKkr4upYInMmiDtgxfcutlhsMJqxBd8dJUxjsQ6YxLsv+94whdszijIf7VI1uzZ7X9tXw5zt4rt2smyHEhWr7CKcNgjIZ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F9Hz1K1Q; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4581cec6079so104161cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726180705; x=1726785505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAcTkMgtXgcEEPNABEcxJ+4/CfIqLdprERFyE6aHb/Q=;
        b=F9Hz1K1QHawzkXFRhsx/kLe8o97yIk5qrK0oOeNQ15NDLfIUPDpxLxQQrHb0ls4XUR
         /lKeO5Fp+wHj1sMV43yFDIZNbq1ktKctr7yhQmwHA2E24ZWRaw7oKNYyX+iIghHtQXdU
         AfFw6AKXFS9qbYgNbO7BtH1kpPwI9h3S3ipMpe7XeJYPBsCVZ9F+o0qxDVCeYQy9zZx9
         kejVXJo1ju144JRa2YJodUj70w7w1YovhTaxEVKzyLoi/20vvqM1MF2P3HO/deZnQFd/
         Sf8WNOGlXmEH2TxW0p1K5zqvZ5fE6EYfoCGtmZdBt7zMJ0/TtvuchHCx9oeu7EvlFnYY
         5C0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726180705; x=1726785505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAcTkMgtXgcEEPNABEcxJ+4/CfIqLdprERFyE6aHb/Q=;
        b=P8AzyYYYEALd5br4ADLLvxOKi406QhQpaouaJdGegrI/X84z218eopc352Ds+O6bQX
         a1g/ZqxVpKjHlTBQnUEv5CyiI0WQKEu8rlEz55NVxZ/C4aiFdPq1ZA8IUU2sxCQX1QzS
         tfRkV7+YY5wZgoXuSC22pVRi2ZXorDrn6u7kG2wOg/dO8TqMbprIwEACYZZcViO9GZXm
         TpiWFPax/BHho0fDKrxyQakq9cCev8SEDpKP1As82xpJu8BIXFlruTQTXkpC3ouOJ3q+
         k8DPpikI84axhEEv8VpJWrVLfg/m+LsjUfNj+ztz/nRPXm4l7UghGtgxoSCH65/Jv27H
         3qmA==
X-Forwarded-Encrypted: i=1; AJvYcCX9Jxq31L2629BYq26UiTDMcJfE9Umq90s9l1FQJA7nQnAiMd4njfrWAufFbmLrKTJ5AUgx0QQrVY2RbwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSD2fzxeZFovqih2q49zGRdk3hNsTKr2MQX4GHMDnN4/8I/IdX
	gsUz0zgCbE3QVopRzbZwRPaD8tLhlUaNLY9btS711mW3JQXmtsJyBwDvruN4iyfk8CjH7hyL/mL
	jGJhNlpxfo3akUsWGShOKiFBScl+wavoat+dR
X-Google-Smtp-Source: AGHT+IFxU92LC/Yu17Eq7ByosE5bKTLoyHWcepiXM7BWM5Jn7DeLhwnV0QV3X6fDS1XGaHWOKCVgA6sgQltQP3wrtgc=
X-Received: by 2002:a05:622a:24f:b0:456:7d9f:2af8 with SMTP id
 d75a77b69052e-458645121e9mr4595011cf.7.1726180704399; Thu, 12 Sep 2024
 15:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-37-samitolvanen@google.com> <alpine.LSU.2.21.2408301114000.1124@pobox.suse.cz>
 <CABCJKucCWfeC0yL6Q2ZcBfef0tMd9L_gmHRJt-cUYkg_4PDtnA@mail.gmail.com>
 <599892ec-3cf5-4349-984b-7c94f2ba5687@suse.com> <CABCJKuer=O3FnLJNGMg2+-HxFJFUrccTuuHt5OiMpRsAJBvBsg@mail.gmail.com>
 <2b2d4953-d2a3-4ea2-98a4-078901cfbda3@proton.me> <CABCJKue-YtCQWinad2GW7uJuVN-ZSUmRYttK_PUurJOR51Urgg@mail.gmail.com>
 <66694e9a-16d1-4d4e-b825-b90707f2b42e@proton.me>
In-Reply-To: <66694e9a-16d1-4d4e-b825-b90707f2b42e@proton.me>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 12 Sep 2024 15:37:45 -0700
Message-ID: <CABCJKufJD6Zea7P_aPHNQQgCMgqkw98-XcvW8hRaTx6kcg4vUw@mail.gmail.com>
Subject: Re: [PATCH v2 16/19] gendwarfksyms: Add support for reserved
 structure fields
To: Benno Lossin <benno.lossin@proton.me>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Miroslav Benes <mbenes@suse.cz>, 
	Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 12, 2024 at 2:58=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 12.09.24 22:58, Sami Tolvanen wrote:
> > That's an interesting point. Is the problem that you cannot assign
> > arbitrary values to the Rust enum that bindgen generates, or is using
> > a #define the problem? We could probably just make the hidden enum
> > values visible to bindgen only if needed.
>
> So if I take your example from above add it to our bindgen input, then I
> get the following output:
>
>     pub const e_A: my_own_test_enum =3D 0;
>     pub const e_B: my_own_test_enum =3D 1;
>     pub type e_enum =3D core::ffi::c_uint;
>
> So it doesn't pick up the other constants at all. That is probably
> because we haven't enabled the bindgen flag that adds support for
> function-like macros. If I enable that flag (`--clang-macro-fallback`,
> then the output becomes:
>
>     pub const C: u32 =3D 2;
>     pub const D: u32 =3D 3;
>     pub const e_A: e =3D 0;
>     pub const e_B: e =3D 1;
>     pub type e =3D ::std::os::raw::c_uint;
>
> So it doesn't really work as we would like it to (ie missing e_ prefix).

If defines are a problem, we can always use a const int instead. It
doesn't have to be defined inside the enum either, and probably we can
add a prefix too.

> But even if bindgen were to start supporting `#define` inside of the
> enum. It might still have a problem with the `#define`: there is the
> `--rustified-enum <REGEX>` option for bindgen that would change the
> output to this:
>
>     #[repr(u32)]
>     #[derive(Debug, Copy, Clone, Hash, PartialEq, Eq)]
>     pub enum e {
>         A =3D 0,
>         B =3D 1,
>     }
>
> Which makes using the values on the Rust side a lot easier, since you
> get exhaustiveness checks when using `match`. Adding the
> `--clang-macro-fallback` flag, I get:
>
>     pub const C: u32 =3D 2;
>     pub const D: u32 =3D 3;
>     #[repr(u32)]
>     #[derive(Debug, Copy, Clone, Hash, PartialEq, Eq)]
>     pub enum e {
>         A =3D 0,
>         B =3D 1,
>     }
>
> Which is a big problem, because the enum `e` won't have 2 or 3 as valid
> values (it will be UB to write them to a variable of type `e`).

Yes, I sort of thought that this might be an issue. I don't see this
in bindgen flags right now, are you planning on switching the kernel
bindgen to use --rustified-enum?

If you do plan to use --rustified-enum, we could just use #ifdef
__BINDGEN__ to hide the fields from everyone else, but I think we
might actually need a more generic solution after all. I'll think
about it a bit more.

> Would you add conditions to the `#define`? For example checking for the
> version of kABI? (or how would it work?)

Perhaps the folks maintaining distros can chime in, but I suspect
there's typically one kABI version per branch, so there should be no
need to maintain multiple kABI versions in the same source file.

Sami

