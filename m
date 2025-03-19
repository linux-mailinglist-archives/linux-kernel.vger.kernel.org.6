Return-Path: <linux-kernel+bounces-568755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F79A69A29
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A547719C4A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB94521481E;
	Wed, 19 Mar 2025 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bskinUHF"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434C1B0F20;
	Wed, 19 Mar 2025 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742415785; cv=none; b=B213h+ulVSaELjAYfs6cHQ8zQu2h+loF60yhz/YhMQxwQrvm9LGx4uBkjYNt5Vrg7vmC8F0i6AvUuS+7ZuOd53MGYK25BJqGwXqsV51ryuk+079YfXi5CDsjBXvA0FSAaiXDnHMajoOkCoziDK7tgziNkihWqyv8OpKCeaK4CVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742415785; c=relaxed/simple;
	bh=7H1eRir+pgJiFdJfaw8yp+IJMTn/KBZvY5am6i6VAwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oimSkxPIR6sz0/LeWOUTtcYhZsCGM3axH3WBS0C7VEYNeS9iu+QHc1esrbCKgpx57w7T4eTPMRtdtYSEG2Bogl3kSjFZm1SipQHtkInEoXW1Pc1ldJGNw+wWnbqTsPTaDve778ZLNqegpV9YmrGjh+CBGJtKD+lJ6JqeRF1dVoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bskinUHF; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3061513d353so1069211fa.2;
        Wed, 19 Mar 2025 13:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742415781; x=1743020581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3jf1XQZlOfq06nnc3o1xA23ufkPqQPKJph3kt8IGLQ=;
        b=bskinUHFevdO8Y6vq24q4w2ixodmP53pP2lZ9grFxcFf1Ub0e2yVhbTvovfaki+MYA
         ZbKoIYpRxFHkEGLo5f8orDPfhiBDs30ckHed78uF1GRYartAN415mGWZCotld6nGdN9Q
         lBjOsVNRekOJCoVPBN7/M0RSD8J/BqvQIrUbIkPkOv6RaaKAe4O5YEXZ5PqNlgw0k5pf
         MZPzJW6UwNijw6leKYKdSJvZgtnu+p/VlRKOLOrroVzdC9AXjtwoOzgUStb07C74H8ow
         CiTPCwfr8EuhO5WgBzz6nPe+kbewWSyyEKZ+faHu8mzGDnpZVHaoku5p1RItRuKgRyI1
         88lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742415781; x=1743020581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3jf1XQZlOfq06nnc3o1xA23ufkPqQPKJph3kt8IGLQ=;
        b=MQw3EF+Y2R97Em/PxqRuQwQqALvoEyDaZDAY2OvYT4Vl4VQ11oeC9rVRfqTSvpwdyC
         6HEYs1LxJuHuHnVqTtRf5RfgwK446ukF6faqZEAhsr+TE0FozDPeTSUp8y92Ug2RknMq
         e8UZ6cBZjxM64y7H602hV6epQDvZC5z7gsE8kOcWCCZSK8yqWW/GQDHXsZzGGpSOi/3N
         rEEEiwROuntylTjgcFBxBkCvlTUpjGg5pfniZwAb5iV5fyzY+eL74X3xaASzK/PNFQg8
         0dnDrwLKXqEokSW8X7mwGM5TRDVMwbwUj4Y8f0320yCHubI95pIV5JGhv1/eYbq5kjuA
         mpyg==
X-Forwarded-Encrypted: i=1; AJvYcCWeob8UHBeVIQCzscdvnzyiw7n40u3DyUIx3BF9QMGnFlPsV6r//2I5ZHJuRWMj2JpXUmCwBNdKFtQ2jONIL/k=@vger.kernel.org, AJvYcCXNo1ijtahuDg8tvUBwjfX7dPZPM2xdUsCtE5mNgpfcHotenV4FQzAwB5KF4MsDMhhoPAgPjo+zqkh69xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzel5UWrn0T+MoLVHN1lCqgn+sLFCa5arfeyPI3b16DKL+Fj13R
	j2TQhjtg0snu2Ql7yvfDL1nGd0nWmdjovJrow13FrmvR7QS9JHYPAPFeVI+CEpRY9Gbel5+BRlf
	y/Ke7PGO/aLGk34kliQA3yL9kE7b7/uzd/YUTkXRm
X-Gm-Gg: ASbGncsQo5I6m6J/d++CJ9sQgv6eMYiyvoHsPvgw92WJzxw2Bzg8TJ9pq5K/MaJE7D5
	vtJ3MFIPSO+1eq4d5haVkOiLzDHRj0C3pT39vOnS6H8cli/v/az1WhaEHI6c6bce+US5dGKMvlh
	vARcbcFHqEqAxUIi2isbFgagP1pmOnt11icMVBT4PFZg==
X-Google-Smtp-Source: AGHT+IGEE950ZJqlgiditqk04+oeurn9EpEu1Sn7iJnqKr0P9EmfPIj6sLCiZBoI57ZD369XOCGpAYR43jqpYLtDi2s=
X-Received: by 2002:a05:651c:a0b:b0:30b:a20b:6667 with SMTP id
 38308e7fff4ca-30d6a4271d6mr18444771fa.9.1742415781360; Wed, 19 Mar 2025
 13:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com> <20250311-iov-iter-v1-4-f6c9134ea824@google.com>
In-Reply-To: <20250311-iov-iter-v1-4-f6c9134ea824@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 16:22:24 -0400
X-Gm-Features: AQ5f1JoJA5T6EfzSkIKQ_dmVbS4U1POYFpnzAFGDeTpKReq1YZY6M7KDPJR6J-w
Message-ID: <CAJ-ks9koLRdtQHBOEBHDYUR7i+HYntYNH2Nxnsqaiqc6fHObDw@mail.gmail.com>
Subject: Re: [PATCH 4/5] rust: alloc: add Vec::clear
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 10:27=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Our custom Vec type is missing the stdlib method `clear`, thus add it.
> It will be used in the miscdevice sample.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/alloc/kvec.rs | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index ae9d072741cedbb34bed0be0c20cc75472aa53be..2d213ede2873cef87116a5527=
e8e24008c970a58 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -395,6 +395,33 @@ pub fn into_raw_parts(self) -> (*mut T, usize, usize=
) {
>          (ptr, len, capacity)
>      }
>
> +    /// Clears the vector, removing all values.
> +    ///
> +    /// Note that this method has no effect on the allocated capacity
> +    /// of the vector.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v =3D kernel::kvec![1, 2, 3]?;
> +    ///
> +    /// v.clear();
> +    ///
> +    /// assert!(v.is_empty());
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    #[inline]
> +    pub fn clear(&mut self) {
> +        let elems: *mut [T] =3D self.as_mut_slice();
> +
> +        // INVARIANT: This call changes the number of elements to zero.
> +        self.len =3D 0;
> +
> +        // SAFETY: The values being dropped are valid values of type `T`=
 by the type invariants.
> +        // It's okay to invalidate them as we just changed the length to=
 zero.
> +        unsafe { ptr::drop_in_place(elems) };
> +    }
> +
>      /// Ensures that the capacity exceeds the length by at least `additi=
onal` elements.
>      ///
>      /// # Examples
>
> --
> 2.49.0.rc0.332.g42c0ae87b1-goog
>
>

It'd be great to implement this in terms of `truncate` from Andrew's series=
[0].

[0] https://lore.kernel.org/all/20250316111644.154602-2-andrewjballance@gma=
il.com/

