Return-Path: <linux-kernel+bounces-563176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F9DA637D3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403B2188EE7C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5F71A8F79;
	Sun, 16 Mar 2025 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gon042SJ"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E431EBE;
	Sun, 16 Mar 2025 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742165302; cv=none; b=m5g+UQ0frv5+DLEB5ciUzcVpfNoTp0pkGJ4WcJCThvmVvbpFiaDh6bc8F/c4107K1JR1SswSg4xki2Tux9pXhdotNL8f0opYLngQF90DDWSb/vfxzrJWIMEv1WtYF4ikk58r2lUKjqT64xtgkKLNfUNJDYw5sgRdrfjzlP4PYL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742165302; c=relaxed/simple;
	bh=FivMKDN386RQtE12sE9oOxJ5RlOzw1/cN58jsJEta/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bU8F951fgIonaKBKF3RL4k5ws+QJHDU1ZoMN8+NaE30jQLuWaqK1qyeoOpl1kHn1QnBtbgoG7wcvwJWvIbx898t9HL+ohq9kMOJ4CVZQ8CBCkLj1WozuwqeaAnWA0Vqr2F6J3Uvu0qPFZBpRPYagCTryx41/xaOGyTzsuIXHYCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gon042SJ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bfd4d4c63so38926431fa.2;
        Sun, 16 Mar 2025 15:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742165299; x=1742770099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJPYog7JvdUEwWLbcWydz/oqXYSqd/DOxqNL/VwI0bU=;
        b=Gon042SJJJA0PYb7wnIRPmtOaGoVwTBWnDzqapoxM775U5tj8kSpz5mGQ1gXEoUrqB
         g3JcC5JGB1S602fF1fz2IyplfpBck4sgM5tbtwnp+KoHDzEjypzCIs1Y5BAfjsirWSz6
         KoT9lDv48EOeIEgmmZa49SzLY7KSzY7zv2+uJxWwKbuYfLG3qplDGxZU50HlTwzhNxnQ
         ptINpbPMsD6g6wW5Bb7ONRaXvj3lQlyjElFIg4WwTVWFBdML1OtZvgKzyIL9P7g8+9Ls
         CCv7YLfjU+oROX839WwKfVGXGl61W4aH8BYpHoomDgvjW1HIXgNfG6+P7cz9eEgs+kjJ
         lxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742165299; x=1742770099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJPYog7JvdUEwWLbcWydz/oqXYSqd/DOxqNL/VwI0bU=;
        b=B6iKbrtPcPdBWfTEs+Zjg5f7Ggd+fWWyBeRBFBF+4PllkqCqplo4Du7WASLiVT9z+d
         3sOlbRmm2pu6zvGn4iHHl0pc3f25uaoYCRocVwyyny8q3SKqy+wpQNmupXiiVaZ83kg3
         q8JYDPLPHur/DL1Omz+y8SD66h4WEXuswp5A31O6Y9PonsV67e2zSzL3F2Jr/jdxIirB
         ZSElEPc1LGDtLLjmYB18qorwMShNtnIlFmZ/0CeaYJWql4jWvzEj+ih+5U6Vq7+XKCMC
         ddH0+WZ9HAB+D9GWkd+z7DWuAAeEGVAGUUnoMbkRoBA1HihfTi0oXJiSr5ew14Yc43uU
         Idqg==
X-Forwarded-Encrypted: i=1; AJvYcCVjf2MyeZ+BJ7sWIx/sUhMWIeC9YoLb27vhNgWAHW1pWCfQh4Cci+tBCVGwnEb5FHcXdGIEyWme8Y1LGhQ=@vger.kernel.org, AJvYcCXjCS866+YXusgctC37G0u9x6r62Ct2dYHcO3eqR181dNIxTOWtxZuOO0G/AMl4AWXkepvdlfnf8mF9Itj/lzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD3YXjojv6VmdlGaxt2kw5sw7+Uf1k75QVjxCsLtMnAJwG4pul
	/FNrG0NihiEGzNpeYIFZSKahXAAz9nVwnx51GbQEwHLZAlpl9d5Lm/yKcJ0xhGBQANjswsyl9Ec
	sX/C0fn3IlsYDHjgdS/85ZZZVnKI=
X-Gm-Gg: ASbGncvHbuULda3Ak9DSi61vtNGMs3fFVSM6imw/+7ix54hEjqlLm09bo9FB2nG7RRG
	+uiP/pgqZ2LWHnh3vMy6BjJso7eGCnmedt2bLSP5EyFAVpLafTS9MesimVNq/ZZvU2k6vQankgF
	xU2nyBq/t80zR43Q0Br4tIDcRYOwIpXTNBQlTZ5ZUl3ya8Rww+T58tMjmaI2kY
X-Google-Smtp-Source: AGHT+IFFx/xmhi1v+HRfgVULGLyc0vHNsC6St1OlXK7+lVSli1yFqfxghUn6J9paJqUVpLuTVXg0cB0/0RE7XjahltE=
X-Received: by 2002:a2e:be06:0:b0:30c:2dbc:6e1c with SMTP id
 38308e7fff4ca-30c4a8d90d7mr51089391fa.31.1742165298943; Sun, 16 Mar 2025
 15:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com> <Z9dTspva0aJRWG3Y@pollux>
In-Reply-To: <Z9dTspva0aJRWG3Y@pollux>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 16 Mar 2025 18:47:42 -0400
X-Gm-Features: AQ5f1JpuA6gXMQg4_p21SxH4W7vALBfVM8qjtTJ6EOrEkV9620n30eksYK7G-Kk
Message-ID: <CAJ-ks9mwuLaULKW0cwD73yb3yH-p9KS3ZFoJJ3OxhvUOpXo3KA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Andrew Ballance <andrewjballance@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 6:42=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Sun, Mar 16, 2025 at 06:32:01PM -0400, Tamir Duberstein wrote:
> > Add `Vec::dec_len` that reduces the length of the receiver. This method
> > is intended to be used from methods that remove elements from `Vec` suc=
h
> > as `truncate`, `pop`, `remove`, and others. This method is intentionall=
y
> > not `pub`.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/alloc/kvec.rs | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > index d43a1d609434..5d604e04b9a5 100644
> > --- a/rust/kernel/alloc/kvec.rs
> > +++ b/rust/kernel/alloc/kvec.rs
> > @@ -195,6 +195,21 @@ pub unsafe fn inc_len(&mut self, additional: usize=
) {
> >          self.len +=3D additional;
> >      }
> >
> > +    /// Decreases `self.len` by `count`.
> > +    ///
> > +    /// Returns a mutable reference to the removed elements.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// - `count` must be less than or equal to `self.len`.
>
> Why? We can catch this, no?
>
> We can keep the debug_assert!(), but use self.len.saturating_sub(count) i=
nstead.

This is why I didn't want to write this until we had an actual caller :)

We can, but it's not clear why that's better. What does it mean if the
caller asked to decrement by more than self.len? Again, my preference
is that this is introduced when there's a second caller.

