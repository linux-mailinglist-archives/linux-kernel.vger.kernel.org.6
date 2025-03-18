Return-Path: <linux-kernel+bounces-566889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 555C4A67DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D209189250F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F30212FB1;
	Tue, 18 Mar 2025 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg99E6j2"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF801DED6E;
	Tue, 18 Mar 2025 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742329045; cv=none; b=IGJEf9M6dQzjTGjRoUJSaiUfsuieKCq/XViHD98LSuc+JvPws4G3iFz6+5tkxV2s+VN3bjlClezmjqDnxZ933ABvxvO4+vu7fIHQpuxOon/3ZEY4rEOKUAP3fTTF16dyB35BRC/yaBllOzTjnP0gI+226gQKZ1CLY+pj0xE1yco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742329045; c=relaxed/simple;
	bh=Y1xBwEjcZzjmqJ5gH2XrlDBNu1gUB2n7igslri/bUh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMfnt+H1/4s2mxh7nGP+cowyWN+gt7oZXdzJqhjXhZf/CjfJyyq+NhFq2DdcXkb3F6IoOWmykJBauzhXc91ZhSSqlfRrPNqkqACaSZ1Dz4e5OYzcD+zEreYYBrPMvXMVQXs5AqtNu4oYy3VwmTnkxei1XWV3/iW/Y0N72ZuhziY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hg99E6j2; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bd21f887aso55438381fa.1;
        Tue, 18 Mar 2025 13:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742329041; x=1742933841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4whO+ZxVNLik2oHzFAiu+JwHpc4ckCB7J5pv1Uynz84=;
        b=hg99E6j2LII955L4PmEtjs0OTdHXF1vgDRXKV26nXHmlRcAWuczOOV5YhrAzINvYnK
         TnJXO7DWPASRiAg+aAqurjgjcwPOwALNOMfXUWwrUoL2q/IW8HtgR7qFvukdzeJ67V0M
         qSJiGwHQerUcMdrB4+ZwoLQjVuEvb5pk2ZrSUSlTRh3EC/iGbKVgPHb6sBE44YSnG7H/
         YiyTPT5lttiI5VfDjymmo3tclZzZtKSKahIpm2mQlmUc7d1Wu2DdWVOL7ez3mkaQFAfx
         UTWwWQimrE6fN0B5UjY8M5lXcMWP1mTJKoSVoQc/GOHtxAKOL73fgjxfQMKJwwAEGQ83
         d4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742329041; x=1742933841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4whO+ZxVNLik2oHzFAiu+JwHpc4ckCB7J5pv1Uynz84=;
        b=tt+irQqRR1ttpem3hkJADLgEaTyCN74ICTLJTj0BWr+OUXSKWc5e2Vt7k0bugmECZx
         upfAfOJGLE2fZ82M3b6fHHmWNKiIbXt9YcPBzNEbaQ0kM5FOD6ypkF1BNQU1LF6mCZ9X
         fPBONZaU0R5BMzHpsgfvaeUsBK+L9yIu4Z58upS74bUf/+jqXldbaSS+AId8qFKL9dqM
         iQWZ3W6X50FztJOFboPShsUXOPnTVKJXEfPMFKTT49Sexu55qkYgS4FnA+BlqX7+JgQ1
         tO5a7zJAxmOpxB44ohMyJHte6sf8LQDLGZuTo445JH4so0WKVZsdIs3OFveHfFFIIonK
         lkig==
X-Forwarded-Encrypted: i=1; AJvYcCX8HqFcQMR4Qpt4HxgexzoT80T9iux2HYRu0V2Hh5XyVDzzHoODw126dSxJS8AHHZYCu8Lz7GMoQ2JuqNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YykDYknq917sbiMRIEEYNYZK9CpCB5NF6IpNUBltvUQpaQpfVtX
	O6XQLZc1KlOcf0zcJcxAD7SSgAHgnmgIY0Kfo6TFq64Vm41n1uYRJg8Y9Ny1E1CfXUj6hfU6anJ
	xONwJBMaRptgMrvQaUlFUHEYQEyp8yBbECqdJqg==
X-Gm-Gg: ASbGncvJW/EyVf9hvtQHm6mc+Ed8OXy/2RiYIWnJTRU1sIcUv9RSIrynh9D4i+PC013
	93qsVBT5jI0C6exMq7pDZfVY+4rQobhDMdYWQ4kFIpNmpvjG2WXg6XlfNya+7s1A9chcKjQZwnc
	6HGrACI/SPVuWsPW/op4jtvz/u+F4NrnbSthC+XICfAg==
X-Google-Smtp-Source: AGHT+IHrYh05F6/t/t39/nwpTj+mtPQtNKFj6frv6OKaMOpNssnAtmDKQ92A4K5n8dBBPDR/swKT+x49q13QIaRdKgc=
X-Received: by 2002:a05:651c:221c:b0:30b:a92e:8b42 with SMTP id
 38308e7fff4ca-30d6a43be64mr403441fa.26.1742329041019; Tue, 18 Mar 2025
 13:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-vec-set-len-v2-0-293d55f82d18@gmail.com> <20250318-vec-set-len-v2-3-293d55f82d18@gmail.com>
In-Reply-To: <20250318-vec-set-len-v2-3-293d55f82d18@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 18 Mar 2025 16:16:44 -0400
X-Gm-Features: AQ5f1JrNJzvMufXDuDwcy3-knbDgaBa1LZbRXxZ-GQ6_SfCau-VUfpThKFTVPb4
Message-ID: <CAJ-ks9n597+YPap+xMGbMwJ_AUGNRNjB7npaE5dee8SG5W=6iQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] rust: alloc: refactor `Vec::truncate` using `dec_len`
To: Danilo Krummrich <dakr@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 4:14=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Use `checked_sub` to satisfy the safety requirements of `dec_len` and
> replace nearly the whole body of `truncate` with a call to `dec_len`.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/alloc/kvec.rs | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
>
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index 97cc5ab11e2a..6f4dc89ef7f8 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -489,25 +489,18 @@ pub fn reserve(&mut self, additional: usize, flags:=
 Flags) -> Result<(), AllocEr
>      /// # Ok::<(), Error>(())
>      /// ```
>      pub fn truncate(&mut self, len: usize) {
> -        if len >=3D self.len() {
> -            return;
> +        match self.len().checked_sub(len) {
> +            None =3D> {}
> +            Some(count) =3D> {
> +                // SAFETY: `count` is `self.len() - len` so it is guaran=
teed to be less than or
> +                // equal to `self.len()`.
> +                let tail =3D unsafe { self.dec_len(count) };
> +
> +                // SAFETY: the contract of `dec_len` guarantees that the=
 elements in `tail` are
> +                // valid elements whose ownership has been transferred t=
o the caller.
> +                unsafe { ptr::drop_in_place(ptr) };

Whoops, this should be s/ptr/tail/. Will fix on respin if necessary.

> +            }
>          }
> -
> -        let drop_range =3D len..self.len();
> -
> -        // SAFETY: `drop_range` is a subrange of `[0, len)` by the bound=
s check above.
> -        let ptr: *mut [T] =3D unsafe { self.get_unchecked_mut(drop_range=
) };
> -
> -        // SAFETY:
> -        // - this will always shrink the vector because of the above bou=
nds check
> -        // - [`new_len`, `self.len`) will be dropped through the call to=
 `drop_in_place` below
> -        unsafe { self.set_len(len) };
> -
> -        // SAFETY:
> -        // - the dropped values are valid `T`s by the type invariant
> -        // - we are allowed to invalidate [`new_len`, `old_len`) because=
 we just changed the
> -        //   len, therefore we have exclusive access to [`new_len`, `old=
_len`)
> -        unsafe { ptr::drop_in_place(ptr) };
>      }
>  }
>
>
> --
> 2.48.1
>

