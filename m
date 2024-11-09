Return-Path: <linux-kernel+bounces-403020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1FF9C2FA2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 22:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F82282463
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 21:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8520D19FA92;
	Sat,  9 Nov 2024 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/lrQryE"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A559233D6B;
	Sat,  9 Nov 2024 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731188049; cv=none; b=vBEaaQeeJDwx7/3gpEO3+3o+OUlTbtRhOz/QqfcX9k+HzpaigHGuxfQkImMUA+jYK/+HB5cTWqmnRxTGNDS0VGP/eS3TV+pfMxOllkB80u+IisQ2e9Or81U93PY5dlMgLyOj9IIWlx3rDbIkPEXIpSgdPG1JPVQNUHYnnkN7+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731188049; c=relaxed/simple;
	bh=lY2jEnVpw3BZrXFgwFiVRVGI8wBnYT8YNEaDAGosAT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JY3IacZ1JQ57XwGKs4b5MqsRmbbEG3cTnwvCk9z2982ENNEHCKHy/xoyvaKkz+/zv+npY/3SJVc+X2HmAqiDq7cOOfV/OHQUCY9+OMoK7/DnPWJwFCzAU1VWStifje3m1/4TEFGBb0lgY+BA2T/unIvihmZ6M6znERX4v+kTWO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/lrQryE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2a96b242cso483942a91.3;
        Sat, 09 Nov 2024 13:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731188047; x=1731792847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lokj0MMRbis0DPUCTnD75vgXf42ybMc8L84P/XJjnhU=;
        b=I/lrQryEjzhNCvowlpXk6DLBhzOQucTMEfLaWmZwllSnarGwg2hCaVyTk6MhJvM5PI
         TxIRC1j2hfeJXiX2ZOqUTzSwJ8UeLGys91yBDkJ6WwSvynpVJo/h7vHmZX4TbOqCP1Kb
         LPlY+X2W6I0ZHn/LKs8u+TLRxQY0jNwh7O1wMZ0HtJhCHYtUK5OOvvK8g+xWfT3Rvuc9
         ZAoMXpna6V67XrEG3TUOxTeBsZLNW84fh2ufgi9vlJraFSfq8jMwnKH5xiMXRubdG9d/
         Kqt2ChWRuElAT6ETsgnqgwSekEqCTlCufqM2icFSrbojohyzMDnwl4BrLPztZmzKGfy+
         L3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731188047; x=1731792847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lokj0MMRbis0DPUCTnD75vgXf42ybMc8L84P/XJjnhU=;
        b=FOYaqNCWSqJtEphaA1/AaOTBjd773aqhz1f5gsLqO57Efrp5KhyxSgjCtIkLEVb41+
         iU4lvDBDG4As7WKC092J99vAr6fqWymtSS69kQLUa/XhiZYcl5lYaVqOWi4eOtOAjeqd
         atyfxipU/HOUcTk4TDdFp6npV4yyPW9lpa15Bxtv4tOgh+nUylGmK/S8QgS9cgVq+O+8
         XR1k1nLhF0X0C9KoF8F1X3yljpoNiZbfVz63JW2iwORqNpsJYYaaewILvWxbpEUt9ymY
         r6W4kpjayFlKfRAHYXBHsjr4lLrEFBQuWCAk6/DLhU92ECPrUfwxqNp0yVq1SLLnvFXw
         HCJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/ZLH/dcgJJXPV1A8MuMSC4sc8bzSDhwIdAo2JgNIQE+SZNtDi/MSJXiTWMyueoRn5Xz7pZnG/mCU3W7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMw7Az0bkWGbxVFPPQeOXLrSTnE+iVkIinPTEHn39WiH1oCPVt
	TjjqTWLooXMX9x6ZdQKl1xu3I56XTqrQ1y3Ch0MPi3z7bn/yHJqrywJPG6kUgId+XWwu7yHjo0K
	Z0+3ttKkmP5pVHMxa/tPKsTPS6d8=
X-Google-Smtp-Source: AGHT+IHhyPITlstlNsviNfUw+SiyH4FYFcCTVP42liLZCYHvt0fw03aghXl20OqcafsLi4ObolNuD6FHdTcKH+lrsWY=
X-Received: by 2002:a17:90b:33c9:b0:2e2:b20b:59de with SMTP id
 98e67ed59e1d1-2e9b16aa2cdmr4389812a91.3.1731188047438; Sat, 09 Nov 2024
 13:34:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109055442.85190-1-christiansantoslima21@gmail.com>
In-Reply-To: <20241109055442.85190-1-christiansantoslima21@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 9 Nov 2024 22:33:54 +0100
Message-ID: <CANiq72mhgL-eidEBhxkzMKFztAjRjAFEdeO5Oe6Uv1mVMtEdoA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: transmute: Add implementation for FromBytes trait
To: Christian dos Santos de Lima <christiansantoslima21@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, ~lkcamp/patches@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 6:54=E2=80=AFAM Christian dos Santos de Lima
<christiansantoslima21@gmail.com> wrote:
>
> Add implementation and documentation for FromBytes trait.

Thanks for the patch! Some comments below...

The title does not need to be duplicated in the message.

More importantly, the commit message should explain what you are
changing and why.

In particular, "Add implementation and documentation for FromBytes
trait." seems wrong, because we already have the implementation and
the documentation for the `FromBytes` trait.

> Add new feature block in order to allow using ToBytes
> and bound to from_bytes_mut function. I'm adding this feature
> because is possible create a value with disallowed bit pattern
> and as_byte_mut could create such value by mutating the array and
> accessing the original value. So adding ToBytes this can be avoided.

I understand that you want to add those two features, but you need to
justify more precisely why they are needed, e.g. is there a way to do
it without them? If yes, why cannot use that alternative way? e.g. is
it too complicated? Or is it that it cannot be achieved without the
feature at all? Please try to be explicit and mention both features by
name.

Also, you should mention their status if you know about it, since we
should avoid adding new features, given that we are trying to get
Linux into stable Rust:

    https://rust-for-linux.com/unstable-features#usage-in-the-kernel

>  //! Traits for transmuting types.
>
> +use core::simd::ToBytes;
>  /// Types for which any bit pattern is valid.

Please try to be consistent with the rest of the code in its style,
e.g. newline here, whitespace elsewhere, safety comments, use
Markdown, etc. (but we can discuss that in a later version).

> +pub unsafe trait FromBytes {
> +    /// Get an imutable slice of bytes and converts to a reference to Se=
lf

Typo (`scripts/checkpatch.pl` has spell checking capabilities).

More importantly, this `unsafe fn` does not have a `# Safety` section.

> +    /// # Safety
> +    ///
> +    /// Bound ToBytes in order to avoid use with disallowed bit patterns

This `# Safety` section does not explain the safety preconditions; and
the bound is anyway in the signature already, i.e. this section is not
about explaining how you implemented something, but for users to learn
how to use it properly.

> +// Get a reference of slice of bytes and converts into a reference of in=
teger or a slice with a defined size

This seems misplaced?

> +/// Get a reference of slice of bytes and converts into a reference of a=
n array of integers
> +///
> +/// Types for which any bit pattern is valid.
> +///
> +/// Not all types are valid for all values. For example, a `bool` must b=
e either zero or one, so
> +/// reading arbitrary bytes into something that contains a `bool` is not=
 okay.
> +///
> +/// It's okay for the type to have padding, as initializing those bytes =
has no effect.
> +///

This also seems misplaced, and apparently is a mixture of the
`FromBytes` docs (?).

> +unsafe impl<T: FromBytes> FromBytes for [T] {
> +    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self {
> +        // Safety: Guarantee that all values are initialized

Please see how other safety comments are written: we need to justify
the preconditions of the unsafe operations within the block. So, for
instance, indeed, the values need to be initialized to call
`from_raw_parts_mut`, but why they are so?

Some operations here do not need to be in the block -- we try to minimize t=
hem.

>  pub unsafe trait AsBytes {}
> -
>  macro_rules! impl_asbytes {
>      ($($({$($generics:tt)*})? $t:ty, )*) =3D> {
>          // SAFETY: Safety comments written in the macro invocation.
> @@ -63,7 +141,6 @@ macro_rules! impl_asbytes {
>      bool,
>      char,
>      str,
> -
>      // SAFETY: If individual values in an array have no uninitialized po=
rtions, then the array

Please avoid spurious/unrelated changes -- these should not be in the patch=
.

Thanks!

Cheers,
Miguel

