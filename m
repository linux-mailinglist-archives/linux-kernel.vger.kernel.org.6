Return-Path: <linux-kernel+bounces-380994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D78339AF8C4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8485F282F44
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 04:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6E318B484;
	Fri, 25 Oct 2024 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="XsiTcJZt"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659751DFD8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 04:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729829424; cv=none; b=DAt6r6edvKHlvo60fSdPWHuTJe5IAzrzmy7IraTVyuaySVuc0rBBWnwdCueHc3s/dbckRVR468xqbZ9ftBFQsBZrbBB5jNKiL7E73LTQuO3FCoHO9RyWPIT+swPk9jKKWiUefWkWZ8m/iAh7hPb/PZ4MVOTFwMwdIv0ZON3vfNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729829424; c=relaxed/simple;
	bh=ekdJWWct6csrgu0g3q5eQ/4BZKKv6zAydS4GjVC4oKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhjjc8iHOpN4mbEjZd2UE5dAHiCAUQW4Hl/mWBjuPOWOV1T+DcTWl4nfDVXM/hrWUUGL6DCIeudqXu7h7TeYvaN0kHzQyCnFB/XPeOyNDJh5JGwtPD9iXmOyuQbjpd4JacEqDmqPux+bSsQXhKmp6Cj94ajhcmy7G+5TPhvd6ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=XsiTcJZt; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e28fea0f5b8so1691431276.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1729829421; x=1730434221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1IUI/Dv7tIqR57YCOc1ojUu2ND9yCjRYfTcqCJ6tlg=;
        b=XsiTcJZt/kvwxxuwjK2mIW3fryNvVfNF/PSKw0KAnW4nHJNz93eKzVIsWmb8x+UhVo
         AkpJOO4F3dw4SPohytlDLN5kAqEdzCeHnDXhhEmlnb+cOEvOg02qMKVeXxuggICdUH5f
         eOcM1+3/xAXdzIajZuLT6HF6TaJ9n9p4c8JLzRgf+B8P8qLTnEHieJ74qQdDoWJWBnIV
         h9BEl5LZBtlTTaVsmfqo2QJli9/1BCSdmUtwrl45EK6MNujht1hT6Bj6KLWwT9yOzyZX
         +vJftNqhTpFB8Fk+IVGXaM1h/iej2z0u2w1FkF2d7r0EQnUvoi14ARNrgetuprPWKYNL
         0+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729829421; x=1730434221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1IUI/Dv7tIqR57YCOc1ojUu2ND9yCjRYfTcqCJ6tlg=;
        b=uHUE3xwrLD968yvpOw+ZURZluixfgLFN+Jtpkw7jTm9n2ALdBFtdHkXIAI7FpRXf4w
         Ub9weambBVwW45JVGZl2w+PKwCSUNjDKIHhvaQo3gVIjKtAJsnIFs3MeZDUry3V6z0lM
         EnzbUC7RW18fnng3h1KjOOR2UbVQN+xFDg3QZYnR5NYAw4nNTEWv4eQH08X5hMrxoPmh
         OxQWF+Cwu5lZHdiwvOP7ZmmnrUfewbz9pkA//QwIPmqWH5nkLFUDdy8R/WDYu9sICcxy
         Uiiur903fklfsGXMBC3GvUyIKJXbqSyEWsUA5Mwi/rHT1p0iJJjIXs0vRX+Szc83bE7t
         mT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCViqTuIrfXTF/KQOlgzqrIPKP+lh9gVhWKvmkDyrfUZQFJYP5UdnU5bFd9TMS4ZJJpIjV2Ggh9JdluQff8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0uDYk3J5vROlxhu/C27I7PEXw3+D7AjwgUxT+rUB6NIyDVMu1
	awNhUsLghHLolCYM2yhQinNlRU4/DPpFWh8DT5zVD0YKd+ASqJVlfq7eYefOfF04Yl5ROyIdsmB
	4Fvxq+P0HjUPlmRrsiD3x9qWEQ0WWweAaDc4eGQ==
X-Google-Smtp-Source: AGHT+IHcK0AVcQUDIMsT5GR4MQ8q5gxpZbDoGV4WWKNOcxg9dr5CYVu9m9eOZ4ZodKrAUOmLJSUvoxDXs2zYREtYdNA=
X-Received: by 2002:a05:690c:ec1:b0:6e3:430c:b120 with SMTP id
 00721157ae682-6e85814c704mr43629697b3.5.1729829421356; Thu, 24 Oct 2024
 21:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com> <20241001-b4-miscdevice-v2-1-330d760041fa@google.com>
In-Reply-To: <20241001-b4-miscdevice-v2-1-330d760041fa@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Thu, 24 Oct 2024 23:10:10 -0500
Message-ID: <CALNs47tbt46VAcT5rm0Y6QBP6kc4ocBFDPOZugthPmNdaHrwPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: types: add Opaque::try_ffi_init
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 3:23=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> This will be used by the miscdevice abstractions, as the C function
> `misc_register` is fallible.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/types.rs | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 9e7ca066355c..070d03152937 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -299,6 +299,22 @@ pub fn ffi_init(init_func: impl FnOnce(*mut T)) -> i=
mpl PinInit<Self> {
>          }
>      }
>
> +    /// Creates a fallible pin-initializer from the given initializer cl=
osure.
> +    ///
> +    /// The returned initializer calls the given closure with the pointe=
r to the inner `T` of this
> +    /// `Opaque`. Since this memory is uninitialized, the closure is not=
 allowed to read from it.
> +    ///
> +    /// This function is safe, because the `T` inside of an `Opaque` is =
allowed to be
> +    /// uninitialized. Additionally, access to the inner `T` requires `u=
nsafe`, so the caller needs
> +    /// to verify at that point that the inner value is valid.
> +    pub fn try_ffi_init<E>(
> +        init_func: impl FnOnce(*mut T) -> Result<(), E>,
> +    ) -> impl PinInit<Self, E> {
> +        // SAFETY: We contain a `MaybeUninit`, so it is OK for the `init=
_func` to not fully
> +        // initialize the `T`.
> +        unsafe { init::pin_init_from_closure::<_, E>(move |slot| init_fu=
nc(Self::raw_get(slot))) }
> +    }

[1] adjusts `ffi_init` to use `try_ffi_init`. Maybe this should do the same=
?

[1]: https://lore.kernel.org/rust-for-linux/20241022213221.2383-2-dakr@kern=
el.org/

