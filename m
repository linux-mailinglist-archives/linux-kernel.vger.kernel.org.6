Return-Path: <linux-kernel+bounces-567675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D50A688D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDCC1898B16
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D12A2505C3;
	Wed, 19 Mar 2025 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ec+8lCNa"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC7F1F4E37
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377995; cv=none; b=GlcWHqoWm3oXDPGBhL8C8/f0N7LGskEWNxoYfYlN0MJgkrXRRrCGiM/RJRC75hpRK3Q3PQO6bqbbEmIoVgYIY7wmKS8Xc/q28UDJeVwVA98W9wQXh5DZuBK2qEFCwgRgRNjWZqgU6D3xycQdsg1RlOB9vvxgiPVslbPYpexxJ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377995; c=relaxed/simple;
	bh=7OXvWzLYLp96HzrnAXRUdsB4V2yc1f4pGWk6gTmcbtk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YDKEquQH4RhgEeZ560+hPtq4kapXp8zJSE8FBE4F0yI801Tqd6N1WSXJqhrcuOgUYPXEP6TKozpb+1wDq8Ohhaa6UQdZdkolqxt/4l2qgkhIFMfhb4FplljuU7kjcHr4QglRUBSl9Lq3K0PnSJlYvV5ehPBFP+5CJ7KTamwjx68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ec+8lCNa; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so23400615e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742377991; x=1742982791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vFFcKQLNGz7N9ayp7megx3xG2FAub1rSop04ZFqYxm0=;
        b=Ec+8lCNargbsiadHjeFU8SMAbDaJUZRWMO6CRmWkNEIjMR8QANOmtWvSZwsLQ2x1+D
         8VsyL1qDBEAtQQHJfbMvyUftHBzoUlwGb/Ym9F8cggF1euWm8bIfQdQYGpJw0SP+uWnm
         QONsGt6guLrlA4Miufox2ckDL9351DP+yXUD1sNUfZoW1Vz4/mnb7L2NuIsD5xvAywYR
         22HLLKQon7x3zDwbpublKomWpdSzXNK55JtRNbfneC36G8wKK65kdrgLI4faIh2IkCCz
         kfWh+VD3xvM+m+ghoqw/ZdbcVqEKi9qTvBTozPvwYer8VExKGLt5vWyqtvngVgRVAum1
         0Byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742377991; x=1742982791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFFcKQLNGz7N9ayp7megx3xG2FAub1rSop04ZFqYxm0=;
        b=KahlYymXvOzVNEIgFwAPIchk6TU0+hvP1B+edIR48sgu0rSnweh3/Vm2UrVogb31OU
         09/aQRrG+ntikgYmtpGBUoYN5/ePMUVccrpzv1k572Q7B2eurkJSLjzLBQnJmxuRd8V2
         tnsf8du3RIBpmNptjGtZOh/s4Lyunjcn2FyAVyh6B1ToQayviQsu6gXuQsAi9F0h4Gcm
         2g0YVmrZbAyFxic0CsXKXitegS6+8c/AZigcTRr9VLpccxFl/tl7yYDiPyylRELxenHi
         u4HqP3GvceIYK8CTTP4Hpjd2cHcfNPiuOyN2G2MXVFFLhyydcNnRKTMv5FFa+MYfE5yz
         4qKA==
X-Forwarded-Encrypted: i=1; AJvYcCVx1oIcrl57sLyiA2E55PPDAdCZqgcWrRfFFvemGYOayYiXPISUto0dCLs9rFP4H3c4fXY8SKiN1zVm3vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwEqp2xxcURIeLklr7gbrNUbPPpmAR+9usvL+68oGlVZRt+79M
	vY4R0CcPiYXO+0rS3rvlEs0O8nRszf+/XearwaP4T3287/hWCM8u7moDicaGYmpDAzVfZ47hzBV
	0rzrqM8Wyh16uDA==
X-Google-Smtp-Source: AGHT+IH+DHqDsC8qcXIyCNJGx+eWKB/6/GVLfZ5h3NUdOn7PEcGICGe7gmXSaCcD4fe82ezSM8oNGRIGEGqrt/0=
X-Received: from wmcq14.prod.google.com ([2002:a05:600c:c10e:b0:43c:e51c:1a5a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:b95:b0:43c:fe15:41e1 with SMTP id 5b1f17b1804b1-43d437801e2mr17282485e9.4.1742377991823;
 Wed, 19 Mar 2025 02:53:11 -0700 (PDT)
Date: Wed, 19 Mar 2025 09:53:09 +0000
In-Reply-To: <20250318-vec-set-len-v2-3-293d55f82d18@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318-vec-set-len-v2-0-293d55f82d18@gmail.com> <20250318-vec-set-len-v2-3-293d55f82d18@gmail.com>
Message-ID: <Z9qUBe_8SM4c-9UI@google.com>
Subject: Re: [PATCH v2 3/4] rust: alloc: refactor `Vec::truncate` using `dec_len`
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Mar 18, 2025 at 04:13:55PM -0400, Tamir Duberstein wrote:
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
> @@ -489,25 +489,18 @@ pub fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocEr
>      /// # Ok::<(), Error>(())
>      /// ```
>      pub fn truncate(&mut self, len: usize) {
> -        if len >= self.len() {
> -            return;
> +        match self.len().checked_sub(len) {
> +            None => {}
> +            Some(count) => {

This could be simplified as:
if let Some(count) = self.len().checked_sub(len) {
    // logic here
}

or
let Some(count) = self.len().checked_sub(len) else {
    return;
}
// logic here

> +                // SAFETY: `count` is `self.len() - len` so it is guaranteed to be less than or
> +                // equal to `self.len()`.
> +                let tail = unsafe { self.dec_len(count) };
> +
> +                // SAFETY: the contract of `dec_len` guarantees that the elements in `tail` are
> +                // valid elements whose ownership has been transferred to the caller.
> +                unsafe { ptr::drop_in_place(ptr) };

We have a mutable reference to these elements until after the
`drop_in_place` call, but the elements are invalidated by that call.
This means that we have a mutable reference to invalid values, which
violates the invariants for mutable references.

Consider converting to a raw pointer when creating `tail` instead to
avoid that:

let tail: *mut [T] = unsafe { self.dec_len(count) };
unsafe { ptr::drop_in_place(ptr) };

Alice

