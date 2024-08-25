Return-Path: <linux-kernel+bounces-300562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8348695E51D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F9AB21AB8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31AD16F0D2;
	Sun, 25 Aug 2024 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR7HdnuX"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA208481B7;
	Sun, 25 Aug 2024 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724617349; cv=none; b=pTJ6GVFBV+kjeByGkYBiURRqTOFwDeLPP1oRBz8vwsHhry2kT4ns56FJ1EQceVUDFXS56n/lYD1bzirGyIkJLg/vCRRKBDhOF5AzglXCaBfunoiSxEyHr4id9eAXja1nhkPJb3qLVNm31nb0V33vY1TVfE/CKAfyyJgHjtBcoYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724617349; c=relaxed/simple;
	bh=bcDrus2x7qjngtd9HfGohvO7PpI3tdrC/mNNgO20QR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qz6wTiSzSF75C1XOYY+vuJCHTIQ3PDTKXM/dTXfY5e6hZvPrG1Dz7XGKEE7V475/5rIUfbaQUh94nf4bquKXmITBX98Upg59uopuaZufEvrRDZ7Lv+h+6y+AmumA0Y9a1uG/iMaFU/S/tI2mgfT80vTZ5cJGGDkU0Ex+YBGfL3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XR7HdnuX; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7cd94fb88cbso421902a12.2;
        Sun, 25 Aug 2024 13:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724617347; x=1725222147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TA7z9uR8uwwIK2Am1DEh3j+frBHwJK1KKr0ycGgX0M=;
        b=XR7HdnuX95cK/B7dZH7HjwlN9GajgY8ZxyH7FOilpgqPaP36YTKdGIxXoWqQOZq3wi
         /AAct5cm6gA35uQ7r7izm7b4RfcC8P4wCewAvWkt9lfpZpAI3F/rqkqWh/u5aST0C1P0
         el6QhJtynXRmOuS+D5olhC64ntodW7T1FJj36C6RmJ9DLrkda2zWRTOW9IPwlJeV9xUH
         pDb+TARUsTnNSYwIA60VG6CF162TX0JYvOUx304dWXar+iTDUzNdv5eLYhwwhQYCNoEi
         iKCuksY/WLA6XqevdRY+XCVa+LVwoUs40eH1opcJaxYu3dY6uoEkUj8a2vNBafjz8nrf
         S6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724617347; x=1725222147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TA7z9uR8uwwIK2Am1DEh3j+frBHwJK1KKr0ycGgX0M=;
        b=TRTQeMsk/3llQLS9j3a2NsTKuYgyesV813iraNyoGS5L2acytN6qktf4aQJ6eo7xBz
         DqWYO1scighnSB76qLeYW1+xeRBJNooviusS6MK0XlP3UKndH6nK93EfyqQ+6Vb4cmNh
         sZ/e6YLSAajF5pdeg5x90MsA2u3wgg4cS6nvkYp1eVk983nnUDtnU0Qfg2WlBY1TBbTx
         cuXHVRFwGP9xhQgF74xbDCMK/TbYB3m4svQJAc8nrxD8ooqJPN1qdRYJWrdINSLiPpXm
         ci+M1Nhv3jb+BfXn3aGv4piiJD3tIpknvbfZKdxDA7PPd4xxWmHeGEp1flkCYdANy6P0
         bzQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpdbVo8mKD5hrcXFOFxsJ8MUiRE8aWWbianC9UwQK20hemXHNYu8KUGfWrJFZVuC97+P6LjNVnxvH6FXef@vger.kernel.org, AJvYcCV6iLab0H8TNZTZtCPpE+GECqvDXuNSjxAmMsCy3WzLZ7Vm2bsJI9Hri1FuQtd8YxxRTqccllIrIHo=@vger.kernel.org, AJvYcCWNA84ZSl8k7E9cAkE69CWm8ddhRkLssCg7kxiCs2qq+1H56915LWS7PZmySa+VhY2JcBkPHi5NXYtNiy0IEGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi4uyBrSgesZCHBxSZPjVpY1IXdlyXxQsOffdzatSZSzRBjgU/
	MxDn8KrM0HTk8Un/3FT40953QF8FHMyn1IYu+ibqPo2sb6fe8077WKjWYRWb5xRlvWzctWQNV0f
	OxJd9GXNryNzRwAEJDW6rPOudwXw=
X-Google-Smtp-Source: AGHT+IGdXDKjouH0Gm9b7skaHai1GdkNTzwqm4rX+MkI9SAYI8T9MUrfWdgwvMOdX4c8YHBJOqjJdEIsctvJ/uR+410=
X-Received: by 2002:a17:902:ec85:b0:1f7:2046:a8ae with SMTP id
 d9443c01a7336-2039e34360dmr65583485ad.0.1724617346868; Sun, 25 Aug 2024
 13:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818141249.387166-1-ojeda@kernel.org>
In-Reply-To: <20240818141249.387166-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 25 Aug 2024 22:22:12 +0200
Message-ID: <CANiq72=amLCxV3QRVqK0gVKnGZe_YeqB79LkydEjZ_hJ6_K4QA@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: enable rustdoc's `--generate-link-to-definition`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
	Guillaume Gomez <guillaume1.gomez@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 4:13=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> In Rust 1.56.0 [1], rustdoc introduced the "jump to definition"
> feature [2], i.e. the unstable flag `--generate-link-to-definition`.
> It adds links to the source view of the documentation.
>
> For instance, in the source view of `rust/kernel/sync.rs`, for this code:
>
>     impl Default for LockClassKey {
>         fn default() -> Self {
>             Self::new()
>         }
>     }
>
> It will add three hyperlinks:
>
>   - `Default` points to the rendered "Trait `core::default::Default`"
>     page (not the source view, since it goes to another crate, though
>     this may change).
>
>   - `LockClassKey` points to the `pub struct LockClassKey(...);` line
>     in the same page, highlighting the line number.
>
>   - `Self::new()` points to the `pub const fn new() -> Self { ... }`
>     associated function, highlighting its line numbers (i.e. for the
>     full function).
>
> This makes the source view more useful and a bit closer to the experience
> in e.g. the Elixir Cross Referencer [3].
>
> I have provisionally enabled it for rust.docs.kernel.org [4] -- one can
> take a look at the source view there for an example of how it looks like.
>
> Thus enable it.
>
> Cc: Guillaume Gomez <guillaume1.gomez@gmail.com>
> Link: https://github.com/rust-lang/rust/pull/84176 [1]
> Link: https://github.com/rust-lang/rust/issues/89095 [2]
> Link: https://elixir.bootlin.com [3]
> Link: https://rust.docs.kernel.org [4]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks!

Let's enable this since it has already been useful for people. If it
happens to break, we can always disable it. And it may help getting it
stabilized.

Cheers,
Miguel

