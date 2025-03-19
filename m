Return-Path: <linux-kernel+bounces-568094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F08F5A68E09
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD3B7AC1CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADDD212B02;
	Wed, 19 Mar 2025 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqM16Og1"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7B325743D;
	Wed, 19 Mar 2025 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391692; cv=none; b=FTfUunzk8VHa8MB6gGFiOTiOUkvuTEQv8LDmAbTOyQ/PA5w/BCktkSKYd9njtWgOo8kgNDbEFoD8lRp/5yXejpvNEHUGUwOguciQyDqe6hjcYbLj+cRx+q3WZkd6KPFZcc37GL3ftFxy0y/9FwhR15orM/5+VxH13ytuOvWuYoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391692; c=relaxed/simple;
	bh=BSFGkwzdrGwntku3dBxvuDqydmKp+4+nwXzeHvX1anQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYtT7WhwekTeagPYvhPdIO0iuIcHSjS11Er1Hp0eQiFU2kaGztBXXwQSKzsGhRt2mIs0OOSc7YvHI+kkklncvFSm466vVDVLah5GPUZyOqc6c7IJBUN4yq6MEz3c4ICZBEUIbrmm2Atmu2an+8VsisRUoXK2KfyN4a+B+yY1XZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqM16Og1; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bae572157so68686731fa.3;
        Wed, 19 Mar 2025 06:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742391688; x=1742996488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5Ow/IYgNbSJc31zI95VCPqBlotLe/Wijm75VBDSERI=;
        b=RqM16Og1Hpi6/m+IvhPSuarKA9pRQcb57+KBSZgEomxH0dze0KfUAmr1ckD5CUGXQY
         eI3NE/R1jqFut5TlHfypaALtScubbOE2Qz3pKRWYvhnrkMjHQSRs1cA//XAoMQ8xnMp2
         rMQ0JjdWi7ALwRAiU+jUUgHvX1XtwCa9y5+Z2l6t23tsiuaBwRlKWNgdqLp6BVMUjPMT
         PtoJKpECEwf8LYd16jp5wjXr/pmFE83UyS6VZrFWXO759xubmMqND7F6yblUYwcCL3yl
         sq5WCIMiFUsdkdqWRkyozaSVcHAhV9UHjao86j+vp1FT69SwXVJWNHX28hAafmdZarix
         /FuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742391688; x=1742996488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5Ow/IYgNbSJc31zI95VCPqBlotLe/Wijm75VBDSERI=;
        b=rWz/KgSD6yrM9jZHR0W4tvlDCspBKGJOA90L9hSBOyPETIsFuqlacvOog1GX8LzX4p
         6QsqXTdpSI+xxsYEkk3ZOg18if3kH0J9mTa8TpKyqdi3Dg4DqwLGTQZeWXrEOqhakeoB
         SzpNShjQCoEFnQIB7jYDpjnzhqdJSF0aGSutJpboIz8bR56DX5jeWgxMsmotmqF6+P8R
         iqCt0qCYiiSJDMVCfxefY4Co33wgE+XQVyOe9Qo893Am+5US8ON8367xzG9cp3+vsI5/
         B3T0+/1v5SOi3IaPq3d9RKFnZ3U6ddyC3Sp1DXFeI9BCAxsOgUEzHJnuGa9eyOZ0kLPS
         vXPw==
X-Forwarded-Encrypted: i=1; AJvYcCUSrr+NwvFso/+Nn3448oGw2PSto19IiZCTLC9rKKgWrjdCcK2Jf3u4aQqTxp3jh3fqdjQYgWhEtTwyy/Y=@vger.kernel.org, AJvYcCV4nvB2HBy650JyYo6/8AmG48HxdQqjtq+HfNb4XB++nBAtLPuIDTDDvnPbcGCmiOx3VZp85Z6HKHlTnCuV1Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+8DkaAE+dUWiB5txuvPQS3DgPRapofFciSLgmCCC/NMddgdBF
	qb4FTP7kZmG3PDuPZ3gHWD2k7gaScsPu8qRyil8SASxvJ91bpyt5WgzNCdmVON4ZEHg948Ipt7n
	stYsUQ97DBfAFjnlczq6ViRIi3zE=
X-Gm-Gg: ASbGnctGYIjrCyxfTA9HjF+RfBOIrLRiRShIN13OhauZ86rZlzpKn/bQAqEFyuyuWS8
	IrzHbe4nCfROpcnZD6H59YiyLLxjDC86n9+HSp32F3pFjyDt0bzr0i/SPgFXPjiun2BpKT45777
	X+JTMFPtPMjPFv9LxHx73M0LZzsKjNE/bRFHSE+v2KQQ==
X-Google-Smtp-Source: AGHT+IHd+c/L0WNa8hU9BaG2rfDjISirj1WkOf8TCQcdO1hD+HO4W9tJZCYYrFJacfgJc9KdnVkG1+/XsZcTn8Nq8mE=
X-Received: by 2002:a2e:bc09:0:b0:2ff:d0c4:5ffe with SMTP id
 38308e7fff4ca-30d6a3e18a1mr11713931fa.16.1742391688068; Wed, 19 Mar 2025
 06:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-vec-set-len-v2-0-293d55f82d18@gmail.com>
 <20250318-vec-set-len-v2-3-293d55f82d18@gmail.com> <Z9qUBe_8SM4c-9UI@google.com>
In-Reply-To: <Z9qUBe_8SM4c-9UI@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 09:40:51 -0400
X-Gm-Features: AQ5f1JoA7wFy_KoTfU5Ep1Lg3TnD_iDU6J8Xk2ethLlxfUg9yanq0t1x893Jjac
Message-ID: <CAJ-ks9n-wGg70+dRj3x4ETYqjTfnnKoPqv9RncHzX_UKAPFHzw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] rust: alloc: refactor `Vec::truncate` using `dec_len`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 5:53=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Tue, Mar 18, 2025 at 04:13:55PM -0400, Tamir Duberstein wrote:
> > Use `checked_sub` to satisfy the safety requirements of `dec_len` and
> > replace nearly the whole body of `truncate` with a call to `dec_len`.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/alloc/kvec.rs | 29 +++++++++++------------------
> >  1 file changed, 11 insertions(+), 18 deletions(-)
> >
> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > index 97cc5ab11e2a..6f4dc89ef7f8 100644
> > --- a/rust/kernel/alloc/kvec.rs
> > +++ b/rust/kernel/alloc/kvec.rs
> > @@ -489,25 +489,18 @@ pub fn reserve(&mut self, additional: usize, flag=
s: Flags) -> Result<(), AllocEr
> >      /// # Ok::<(), Error>(())
> >      /// ```
> >      pub fn truncate(&mut self, len: usize) {
> > -        if len >=3D self.len() {
> > -            return;
> > +        match self.len().checked_sub(len) {
> > +            None =3D> {}
> > +            Some(count) =3D> {
>
> This could be simplified as:
> if let Some(count) =3D self.len().checked_sub(len) {
>     // logic here
> }
>
> or
> let Some(count) =3D self.len().checked_sub(len) else {
>     return;
> }
> // logic here

=F0=9F=91=8D

>
> > +                // SAFETY: `count` is `self.len() - len` so it is guar=
anteed to be less than or
> > +                // equal to `self.len()`.
> > +                let tail =3D unsafe { self.dec_len(count) };
> > +
> > +                // SAFETY: the contract of `dec_len` guarantees that t=
he elements in `tail` are
> > +                // valid elements whose ownership has been transferred=
 to the caller.
> > +                unsafe { ptr::drop_in_place(ptr) };
>
> We have a mutable reference to these elements until after the
> `drop_in_place` call, but the elements are invalidated by that call.
> This means that we have a mutable reference to invalid values, which
> violates the invariants for mutable references.
>
> Consider converting to a raw pointer when creating `tail` instead to
> avoid that:
>
> let tail: *mut [T] =3D unsafe { self.dec_len(count) };
> unsafe { ptr::drop_in_place(ptr) };

=F0=9F=91=8D

