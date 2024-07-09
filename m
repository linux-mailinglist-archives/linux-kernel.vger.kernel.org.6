Return-Path: <linux-kernel+bounces-245547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C307B92B432
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E663F1C219DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A73156880;
	Tue,  9 Jul 2024 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGjg0Ce0"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503C155C93;
	Tue,  9 Jul 2024 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518081; cv=none; b=tcqF/m43PsDbzZlz3bgF0gVO2l7YLxI3pO8i0SyeH4/IM/sDaKdNOg+mjJSdGUXsMtKnYesJH7fpFGvpdnLcB9JORpgtDKIqu+TUZwGVGt5ykuGVafNahIS87pjzNRgatPFerRDB+ROS6B0d18kFV1QwPfdah7VVNhI1blH2PYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518081; c=relaxed/simple;
	bh=6/8m5t3tBJG+vQHucRBM2B3L/XB592V14euivKILF9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h07UjGTDjz4R5beyT1jr9w/nqe6rMFdHmuyVOTagIm9dl2wNSfSCqP/c+noEzQ0G1FaU6WvkQosD/KFo0IexxhPGNmb+Q8otwKFvKCfDElZaJDWg6E6zTaL6gTrbdb2JJzctBiqERvQ5ZIfWlVvizDfQcmGjfosCqVh2MuAbb6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGjg0Ce0; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c927152b4bso3332892a91.2;
        Tue, 09 Jul 2024 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720518079; x=1721122879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVroGXjljN7UKU/yhFIYpLiSd6PbIzKS4cUQFOHvuWw=;
        b=iGjg0Ce0P/9yEInGqudsvhaCU6JRtqUtUaTY7qecXQsa6++ODQ15F8BPa38hRmihMx
         kB6Z37QP58SdtpNYf4YuFvUuUwgSKifHMzgYhH/OULQEsvUTLRXljclspxr146S52oXd
         3QGUnYS5ssSkvo+qJbh9Ag/kPmmTeAEV/BxiyyHf4oGE6pGfFlTXZCP8IUgE3woYzVqW
         po+xUadHAUtSS4eQ/YiOSSfvyF97GCrSd93xoin8N7Mgip6cb5+Vt95HWjiaSypJmH2Q
         hthc/rDZD3haDnJfjsV1nO4ccUDkTeM2jzuJsrBXU6ooVTsdFsyciEELGrKyw34sJ8x3
         Ix+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720518079; x=1721122879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVroGXjljN7UKU/yhFIYpLiSd6PbIzKS4cUQFOHvuWw=;
        b=RwqhyYJByh8kpd5vhqNp7pNt1t6B9oUvLJ+AnTm90Ps69ELSPLjSw0MB3oNiCnUjM4
         4C8/NQeGhUYA52vUvgA291SCBXsX0XKUtJDWsNunoqFUo2pYBvK0tXSaPd4TuWm/hfdh
         IdW4o3IySYt+rsIcUempp5svEJ4LuB2aNCNZ5JPbzvgOR2yUxquxdb7KkWSlJXY1Al8i
         ULHtW3Y5Fd/w4/1lbjMO4zQklSLiGfkPmbIjWH5wdsv4hdkKWT549e7iowNtKfxrm5Bt
         1ZXoQfyQPomn5IeNYQa9vplSzwN4DR/nOT735NfFgdMSbzfewOeurzjIQzp1bkS6SHCc
         uU1A==
X-Forwarded-Encrypted: i=1; AJvYcCUZajYMN0TMAJMzMFcONmANW2JiUtyQK4WmW2tP+G4B40IRUW/obkuZNYJREJ+7SU35lggWnuXPp+enIJLUul95oSSX+xT4cXf9I4WqjqeWtqMfPB75b5N7O4doFRpFMDqoZ6vYlGCaSDZJa5k=
X-Gm-Message-State: AOJu0YxxvoI7DGIsz2D9M1ofT7FIXmEgvzg8k4dYYO15PRk8vQS8DHwY
	HWbu+XDPlHJZB1EEXurftGv2Fv7CqVId0p9BnfJ4HMTw9/4/KJn6YTyTEvu3FeQVtFUIQASWYCF
	NG4y+WMCOnYxwwVX1n2nRrxf0ugs=
X-Google-Smtp-Source: AGHT+IF8ZjDYhseE4Khi5hh3/IVLxfQ67v9J2c5cotmB0Lq+rDdIDmRbQdZ5yWgqnTKcX7faKxVbS2/+f/aXqcOR3ns=
X-Received: by 2002:a17:90b:1e05:b0:2c8:1f30:4e04 with SMTP id
 98e67ed59e1d1-2ca35d48f74mr1921776a91.36.1720518079028; Tue, 09 Jul 2024
 02:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709084458.158659-1-jfalempe@redhat.com> <20240709084458.158659-5-jfalempe@redhat.com>
In-Reply-To: <20240709084458.158659-5-jfalempe@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jul 2024 11:41:06 +0200
Message-ID: <CANiq72kS2fAgRnR8yNfpN69tMG+UPfgfytaA8sE=tYH+OQ_L6A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/panic: Add a qr_code panic screen
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jocelyn,

A quick docs-only review of the Rust side (some of these apply in
several cases -- I just wanted to give an overview for you to
consider).

On Tue, Jul 9, 2024 at 10:45=E2=80=AFAM Jocelyn Falempe <jfalempe@redhat.co=
m> wrote:
>
> +//! This is a simple qr encoder for DRM panic.
> +//!
> +//! Due to the Panic constraint, it doesn't allocate memory and does all

Perhaps clarify "Panic constraint" here?

> +//! the work on the stack or on the provided buffers. For
> +//! simplification, it only supports Low error correction, and apply the

"applies"?

> +//! first mask (checkboard). It will draw the smallest QRcode that can

"QR code"? "QR-code"?

In other places "QR-code" is used -- it would be ideal to be
consistent. (Although, isn't the common spelling "QR code"?)

> +//! contain the string passed as parameter. To get the most compact
> +//! QR-code, the start of the url is encoded as binary, and the

Probably "URL".

> +//! compressed kmsg is encoded as numeric.
> +//!
> +//! The binary data must be a valid url parameter, so the easiest way is
> +//! to use base64 encoding. But this waste 25% of data space, so the

"wastes"

> +//! whole stack trace won't fit in the QR-Code. So instead it encodes
> +//! every 13bits of input into 4 decimal digits, and then use the

"uses"

> +//! efficient numeric encoding, that encode 3 decimal digits into
> +//! 10bits. This makes 39bits of compressed data into 12 decimal digits,
> +//! into 40bits in the QR-Code, so wasting only 2.5%. And numbers are
> +//! valid url parameter, so the website can do the reverse, to get the

"And the numbers are valid URL parameters"?

> +//! Inspired by this 3 projects, all under MIT license:

"these"

> +// Generator polynomials for QR Code, only those that are needed for Low=
 quality

If possible, please remember to use periods at the end for both
comments and docs. It is very pedantic, but if possible we would like
to try to be consistent across subsystems on how the documentation
looks etc. If everything looks the same, it is also easy to
remember/check how to do it for new files and so on.

> +/// QRCode parameter for Low quality ECC:
> +/// - Error Correction polynomial
> +/// - Number of blocks in group 1
> +/// - Number of blocks in group 2
> +/// - Block size in group 1
> +/// (Block size in group 2 is one more than group 1)

We typically leave a newline after a list.

> +    // Return the smallest QR Version than can hold these segments
> +    fn from_segments(segments: &[&Segment<'_>]) -> Option<Version> {

Should be docs, even if private? i.e. `///`?

Also third person and period.

> +// padding bytes
> +const PADDING: [u8; 2] =3D [236, 17];

`///`?

> +/// get the next 13 bits of data, starting at specified offset (in bits)

Please capitalize.

> +        // b is 20 at max (bit_off <=3D 7 and size <=3D 13)

Please use Markdown for comments too.

> +/// EncodedMsg will hold the data to be put in the QR-Code, with correct=
 segment
> +/// encoding, padding, and Error Code Correction.

Missing newline? In addition, for the title (i.e. first paragraph), we
try to keep it short/simple, e.g. you could perhaps say something
like:

    /// Data to be put in the QR code (with correct segment encoding,
padding, and error code correction).

> +/// QrImage
> +///
> +/// A QR-Code image, encoded as a linear binary framebuffer.

Please remove the title -- the second paragraph should be the title.

> +/// Max width is 177 for V40 QR code, so u8 is enough for coordinate.

`u8`

> +/// drm_panic_qr_generate()

You can remove this title.

> +/// C entry point for the rust QR Code generator.
> +///
> +/// Write the QR code image in the data buffer, and return the qrcode si=
ze, or 0
> +/// if the data doesn't fit in a QR code.
> +///
> +/// * `url` The base url of the QR code. It will be encoded as Binary se=
gment.

Typically we would write a colon. after the key, e.g.

    /// * `url`: the base URL of the QR code.

> +/// # Safety
> +///
> +/// * `url` must be null or point at a nul-terminated string.
> +/// * `data` must be valid for reading and writing for `data_size` bytes=
.
> +/// * `data_len` must be less than `data_size`.
> +/// * `tmp` must be valid for reading and writing for `tmp_size` bytes.

It would be nice to mention for which duration these need to hold,
e.g. the call or something else.

> +        // Safety: url must be a valid pointer to a nul-terminated strin=
g.

Please use the `// SAFETY: ` prefix instead, since it is how we tag
these (i.e. differently from from the `# Safety` section).

> +/// * `version` QR code version, between 1-40.

If something like this happens to be used in several places, you may
want to consider using transparent newtypes for them. This would allow
you to avoid having to document each use point and it would enrich the
signatures.

Thanks!

Cheers,
Miguel

