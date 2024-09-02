Return-Path: <linux-kernel+bounces-311241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C590996867A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0332D1C228D0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC831D6783;
	Mon,  2 Sep 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ESh/3z1K"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9831D6194
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277388; cv=none; b=XViQ56xxEHFUw4Cfz6OpBDRj6TG9EMm+f1znLKNOKHjijX95/i92ErbB4k2M5WksWN+6Veug1iDEyd+snY8hNSSA9VspR5DPTzuCwBX1/CnsBAl7CVJbVJGaXuXILnZG2yjH1ZDgrHLdFIOZp4XztY9ZPA4c7A2E3QRs2801f5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277388; c=relaxed/simple;
	bh=aMluMbJLhmb0IEL3J16AEDzecT8DhkBRh9kGj9W/BbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uo5z1iEinn2CxHyoPX2J1VVrXQ6t1Tw1a5cPMm7DrzrKCQq+glCK/vIDj9+rGNXEecph0cxWMfNyja0MWGyFPS5jgmmTAYtt9/1iV6xshU8oDADG/PaogGNODLDlYPli0e4VCV+U0htb/HmTyfwf53fON02UbJtD20vxaj8E5TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ESh/3z1K; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-374c7d14191so595027f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 04:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725277385; x=1725882185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJVoV8ur5E5PML26OjWYrL4zwoEkKD/ilxgSBTROy2E=;
        b=ESh/3z1KIOEVftA18H5JcLTsOpY1u9kXHa7GlM5nUSBpXH/KVnl6Tf7Leb3GY4Vo6g
         nuid1oxXHD8WUQFl8y33X8PrNgGYAu22LFH4Q7SQwmer4ZS2AV29cQlUnA3/QVMm5cb/
         eXBGoCSG9892h8r/aA6tlLhU2WcfLz6vXK1DajsSwakL9n/QT5BBk34MJlZdgJLKzydy
         qWvIog7HUKgBo2/gfhQVn2GBu+Gg8cFt7yqOQoKse5lRzMyxQ1N+/z13p2RkQ2XAEDem
         SW6mRs9/ijcdThuPJ28EWbIH0M6iy1taaOwuIfqxcQXfO5ps7Fk+d7UzYdfKw0b7QDLd
         1xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725277385; x=1725882185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJVoV8ur5E5PML26OjWYrL4zwoEkKD/ilxgSBTROy2E=;
        b=Kz9KOjxH0NYbcQvyvb/Sw2xxfq6n2c5s4viX+IRGVzwB4YaNYxNhXTHSSl2/pWa3GQ
         yEaZ0HECJwXRb9p9+W6wNeUTsF63g3ImcJ3FGiESDnTdEBzsAhrW7JRgws343821Pt/r
         hlWT03AS2HHRuQ0t5iPVKPxfR+SfHi+c7+WPRKxNEs1EbFQyK4EGhbAgxNGC1/302xGq
         lwDGDQPeHenLoAEZzyB0B3hDudBhHhvEskyk7VU7pTVpXcXpA9GEAtSCUzs8wgbjnk5+
         njmv/UzAuAh9VOF/c5vEzx2t6V36+X/0SPwx7gi0//xjWapsMiqPbEK8+5C+WvNOwmNA
         FmKg==
X-Forwarded-Encrypted: i=1; AJvYcCUc3ixicXaBnMk6s2dE4usy/qsFFPVIqLl+Z4L8++l21R4tL73b0wYuM6sAYL5jVPBKiHgyjUnMGbZh1qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvQN3yGJoimUZBEicn3RNnOEyD5XX44bMGfVUJ6MWBPq6iLzxD
	16Fmn10Pb4mNARKqde5eE2nLrtkbb6Wb4/a6TW7TPeyXVhxAMA8Z1eQxaVlfrwcoSi7bvSiB59X
	RlY62rfzg8vu12CUok5cFGBrOUWNebHMALw2g
X-Google-Smtp-Source: AGHT+IGBSIuAmK8flBxMTjfhqRpEYf59h0KGrVS2RkXNR24CE2gpartKGqUw821ZfLCdJ0tVXO06AU7ju/cNywO36CI=
X-Received: by 2002:a5d:4565:0:b0:374:c3e4:d6e3 with SMTP id
 ffacd0b85a97d-374c3e4d8a1mr2546132f8f.5.1725277384952; Mon, 02 Sep 2024
 04:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827-static-mutex-v2-1-17fc32b20332@google.com>
 <10453342-d269-4b78-8962-821ef53d3cb5@proton.me> <CAH5fLgh-DYvXobXQVaQ9txYS4Rx8QhjyVvfTphk6vvnUOGzPnw@mail.gmail.com>
 <3b557f61-cead-4568-b2b4-4a56c4cbff52@proton.me> <CAH5fLggE-fWDuZXH_F3ixDSo7sQEFwnUV3cd+9_rpFH+XmnA2Q@mail.gmail.com>
In-Reply-To: <CAH5fLggE-fWDuZXH_F3ixDSo7sQEFwnUV3cd+9_rpFH+XmnA2Q@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 2 Sep 2024 13:42:53 +0200
Message-ID: <CAH5fLgiZt3uVZiU1xXPcvYNR-Em2V3y+-C9EbsqrNvkScbiAYA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add global lock support
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 1:37=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Fri, Aug 30, 2024 at 3:22=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
> >
> > On 30.08.24 07:34, Alice Ryhl wrote:
> > > On Thu, Aug 29, 2024 at 8:17=E2=80=AFPM Benno Lossin <benno.lossin@pr=
oton.me> wrote:
> > >>
> > >> On 27.08.24 10:41, Alice Ryhl wrote:
> > >>> For architectures that don't use all-zeros for the unlocked case, w=
e
> > >>> will most likely have to hard-code the correct representation on th=
e
> > >>> Rust side.
> > >>
> > >> You mean in `unsafe_const_init`?
> > >
> > > No, I mean we would have `unsafe_const_new` directly set `state` to
> > > the right value and let `unsafe_const_init` be a no-op.
> >
> > But how do you set the right value of a list_head? The value will be
> > moved.
>
> Right ... we probably can't get around needing a macro. Can statics
> even reference themselves?

Looks like they can:

use std::ptr::addr_of;

struct MyStruct {
    ptr: *const MyStruct,
}

static mut MY_STRUCT: MyStruct =3D MyStruct {
    ptr: addr_of!(MY_STRUCT),
};

Alice

