Return-Path: <linux-kernel+bounces-351830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEDE9916A8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDFE283ECA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 12:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B915314C5AA;
	Sat,  5 Oct 2024 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wTNBG1Xo"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D0C85628
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728130025; cv=none; b=b/anqWCbmigm2PXKZlC+RIaVcKw94VrvNlWLLkrsmez5fM5QzqcWMjNVoyCEt3GRndcj4V61jrH13l7JVTzl/lHnEOv0xtZ5dDyYpMS+uLTII8UQJ26ePufhgiZtbDJbOcPbF2rDkk0lf2Wbz+tXH2vDJRQTLH2FQJNoN7IU80Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728130025; c=relaxed/simple;
	bh=7Wv79x5E9AcwAGG/zQcK660mw1zBEwy03YrLbK9EGno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqpQzVbFA/AJsVVSTg812Hs87zbPU7ECmf3scWSmpBrj3rmeroxykDmShZBHMShOrlnZtwpQJdpskb7HFomiQ/xHEZQCKVRxpscwi9pjnT+AqNsjJRzrfIURgfpHO96+AXOvT3pZyyBPwlmwxKwAAflKUObJEEG0MBzgJqaUtS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wTNBG1Xo; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37cc9aeb01dso2082486f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 05:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728130020; x=1728734820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r98QtsF1/DiiG9GkQhRBoJ7Pv1Ng6Yq06tif7n6/E6c=;
        b=wTNBG1Xo87ornraNFjtYgRvbmOqxtttc8T0nfmYoL5+Mqr03KOwzs3fxozdtMuv3wl
         QxQrAXgKYr4Pw+B679wYglzgLnByO8kzqwsQt59f03BpK/SlahE2wT2MMGHFPFbeyoDE
         +BER1SgGzmELUPMkWxabEliAR4/lNxj8TGMIB+lfnwRgIO9WUaJ0+VyMR3JsnH6UYj+w
         0pGOI49FTeIl7pQ+MPJupRa2ViDEjHQn0ObLK1vc6vxQEZ3uFV+n23N+n+IlEUuzeo8n
         3ksRsj5p+Gx8CQ4N01pSma6gWcOOiTDmfmr6tw+6qHbkCaQe/qpfv1YlfoxDyb1nyl1z
         rjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728130020; x=1728734820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r98QtsF1/DiiG9GkQhRBoJ7Pv1Ng6Yq06tif7n6/E6c=;
        b=rN5f9UcDyWzJjza/S8DEXEUBpgCQ2AkCKMSZUaMnUvTOmm42aqolFpXBBVQRLRtDWi
         KdsPhQIR9Xya3RHsMD5ZQ3M6Rg5UklwHt30VmaHisoSmqAPe5nC0+5Uu6XJ1IOHfpK3K
         nf5A4RjGqZRPEPlCeDS/BWBdbcwFFjZg5Oeh804yRF5xx9duaR0zhv/LZxtiORq7L6D8
         RLo9qRSpNvg1YzqU498WoUFcYOpBLqBEJxk/h/uHuKKyWj1pUpSdcHLMYAfX/Ynf6rlv
         uXrxypwGxzRpdNvBiDKvnyjgPSFpMiv5BwBasepchBSjBXLjGKrvR+ILZZdKno2TOc40
         cp6w==
X-Forwarded-Encrypted: i=1; AJvYcCUFbBCpUNbtZW2lcWuv84RWzY42cSSdYhNU8nx0H6Z2fcwEMYR8pMDB3AcQaV+giBWPrzVMHBiVcZDuRT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw1Mo/47aegcmHJCA+wjsupPbQGrCw9jpCzXgnZlrgX5IMiY4Z
	ouuSEk02CPuy3uDPs6FFGMpqJN+B+YE3S2XdG/icX948ofKs9r1kwbT4gYfMaXnLx+JVcUyfz+U
	uO7pGN10YFF0CkKZEtgmUvwuorycWEApYEQV3
X-Google-Smtp-Source: AGHT+IFNEzOq1xF5WTsUzl1TKhhGpdlElRJhAaNe630/4pPwivHiEWJodDzT7cxT+SOXtwKnOzb/GYiiaI5QG0UIuzI=
X-Received: by 2002:a5d:5245:0:b0:37c:d4e8:2c6a with SMTP id
 ffacd0b85a97d-37d0e8de992mr3782657f8f.51.1728130020147; Sat, 05 Oct 2024
 05:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004155247.2210469-1-gary@garyguo.net> <20241004155247.2210469-3-gary@garyguo.net>
In-Reply-To: <20241004155247.2210469-3-gary@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 5 Oct 2024 14:06:48 +0200
Message-ID: <CAH5fLggOEVxNQLfLxMg+0B2zEciaJ9Y7wkmrMoYXEcEQOg5HNQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: convert `Arc` to use `Refcount`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Wedson Almeida Filho <walmeida@microsoft.com>, 
	Valentin Obst <kernel@valentinobst.de>, Alex Mantel <alexmantel93@mailbox.org>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 5:53=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> With `Refcount` type created, `Arc` can use `Refcount` instead of
> calling into FFI directly.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

[...]

> -            // SAFETY: We have exclusive access to the arc, so we can pe=
rform unsynchronized
> -            // accesses to the refcount.
> -            unsafe { core::ptr::write(refcount, bindings::REFCOUNT_INIT(=
1)) };
> +            // We have exclusive access to the arc, so we can modify the=
 refcount at will.
> +            refcount.set(1);

Why are you changing this to an atomic write? We just took ownership,
so we have exclusive access and can perform an unsynchronized write.

>  impl<T: ?Sized> Drop for Arc<T> {
>      fn drop(&mut self) {
> -        // SAFETY: By the type invariant, there is necessarily a referen=
ce to the object. We cannot
> -        // touch `refcount` after it's decremented to a non-zero value b=
ecause another thread/CPU
> -        // may concurrently decrement it to zero and free it. It is ok t=
o have a raw pointer to
> -        // freed/invalid memory as long as it is never dereferenced.
> -        let refcount =3D unsafe { self.ptr.as_ref() }.refcount.get();
> -
>          // INVARIANT: If the refcount reaches zero, there are no other i=
nstances of `Arc`, and
>          // this instance is being dropped, so the broken invariant is no=
t observable.
> -        // SAFETY: Also by the type invariant, we are allowed to decreme=
nt the refcount.
> -        let is_zero =3D unsafe { bindings::refcount_dec_and_test(refcoun=
t) };
> +        // SAFETY: By the type invariant, there is necessarily a referen=
ce to the object.
> +        // NOTE: we cannot touch `refcount` after it's decremented to a =
non-zero value because
> +        // another thread/CPU may concurrently decrement it to zero and =
free it. However it is okay
> +        // to have a transient reference to decrement the refcount, see
> +        // https://github.com/rust-lang/rust/issues/55005.
> +        let is_zero =3D unsafe { self.ptr.as_ref().refcount.dec_and_test=
() };

This code needs to make use of this guarantee for correctness:

For both `&T` without `UnsafeCell<_>` and `&mut T`, you must also not
deallocate the data until the reference expires. As a special
exception, given an `&T`, any part of it that is inside an
`UnsafeCell<_>` may be deallocated during the lifetime of the
reference, after the last time the reference is used (dereferenced or
reborrowed). Since you cannot deallocate a part of what a reference
points to, this means the memory an `&T` points to can be deallocated
only if *every part of it* (including padding) is inside an
`UnsafeCell`.

from https://doc.rust-lang.org/stable/std/cell/struct.UnsafeCell.html

so when invoking `dec_and_test()` you can have a reference to the
`Refcount`, but not necessarily to other parts of `ArcInner` like you
do here.

Alice

