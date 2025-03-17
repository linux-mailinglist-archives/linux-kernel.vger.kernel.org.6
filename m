Return-Path: <linux-kernel+bounces-563953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7708A64B15
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822323B8D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC0E2376FE;
	Mon, 17 Mar 2025 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+pLKvMD"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27048224B03
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208495; cv=none; b=diNLLamM29yE3kE22oiwswpzLfrnprK4E3pXDgNxiF/BXGpd3MwqereqrjZiB1e8kAOZKoYwZ6ScA467SKBp41lFs5yPB/IBMlm1OmYyKNFMPZisfb3V4FMynVpVIfeZ3BR8em1+hBh+rInO6colRKZxRdMV0IuDLcAlT1yfaN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208495; c=relaxed/simple;
	bh=jq3X0qE7jYhioS2GfUtcrq4s/m8J6errewmpVsYEE2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kkX3fbBu1dFVtJvZ9nnYSrp5d/5UYHeolcyKmHl3x775hkzEJGey1a79Ni5u2CwDNsSnRObhHLsxCk53StVMa0OqrmHtTToO+XSx0+wBZuvYSUqwb22cr+IxeDXWLveTtHpABkR9XP6uQay7c+nTAnYu19T5XRsye+Gd8/RNjRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A+pLKvMD; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bd0586b86so10795505e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742208492; x=1742813292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1YqLMhKi92fKgJeFnMXT0ZI/xZbNY0Jf2K0ZDkFduU=;
        b=A+pLKvMDLPAH4V4ihmTvWlgfx0uYCVBBvSUplK3EArr6NEWh2NuL9cpQtSYgxQUTa7
         rC7kaIUSBIwG2r9baAiaIbxXH4eDnkCgUU7bmfIzzsq4bt6E1bF4W+nx4OHB+5Ze+C9/
         lm5MuCJ1xMUSuje3cXJZXOzjsCwdGYclwP1xo1iY6ADRJowrD/9tBbtf1Su32M11DFSD
         tjw6CRpohsuNeE4y0hLYzoDU8swDmS4uWbSnnlD7IhZ+AWxhayvZvSTx380ZyWtbbNRa
         YsT0xm57NlyCQWbwkaFbeMKsDuDg4RMzgrkxq5706ihBaw6eIIat7/p5uDfrkmBt/uQh
         PJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208492; x=1742813292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1YqLMhKi92fKgJeFnMXT0ZI/xZbNY0Jf2K0ZDkFduU=;
        b=ubd0q6rD6Uo0fxwwHz92k5PhDDyofYrrDZ5U+FkEnQIMxphsTKRZVnv7sh2Cq6zQCV
         LTDBdEjRMW8udJxPpDi8J+fXuluyo2mh/WKlQo6hOR65JJa6IAIfzwqUUkjPLlxsut13
         Vv3Y60nyhx8Y6J9BAHm3v2/aUSJPk3Hl01FQTnusWERYm7x6Gqr9HsFp6i0CaimK1L2M
         7nR19FusJUM1Jk+vLmqHL4i/iR2vGhupSeSPXza9hs3SJvqHZlPCsLYnePD9PsQdaWOG
         X6YzhBcm1dFxl5KUUAjjizLhMcpgGSd3hHQzv8TCqDcAi0SL47eazlMDAllMQ8C5FXTa
         nvxg==
X-Forwarded-Encrypted: i=1; AJvYcCXuIwE1ndylaJiZOPxkMhn6nBwRoVcz+0eK7Ltbf4GoTKyHY9dSrFIRdLGTJDsKeDwbzh7rF+skj7VzGb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVP7JKjiv7ix/oTsHZPUoqqedJ7hJdYxKNaOwl5soOOvcP4cJV
	wXguANEJH62kRGXn2NPxumwCSOMLbUzpj3KWEQx88Cz06V7/w3EEOymIQvVdaOyiAGMrvLpffCM
	h0+eUfKm3tK8GIQ==
X-Google-Smtp-Source: AGHT+IF3KkGZpUivbQITsaAM4gxRphWh2JM6vssmC9PpAf7F4Mbtsj9GtT0ALM5KGS0vxlqAe/mqwVwDm3pM4Zk=
X-Received: from wmbep23.prod.google.com ([2002:a05:600c:8417:b0:43c:f5b8:aad0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3106:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-43d1ecd933amr126390135e9.31.1742208492614;
 Mon, 17 Mar 2025 03:48:12 -0700 (PDT)
Date: Mon, 17 Mar 2025 10:48:10 +0000
In-Reply-To: <D8IGB61NVPBT.1I3IZYPVPIEMU@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-1-60f98a28723f@gmail.com> <D8IGB61NVPBT.1I3IZYPVPIEMU@proton.me>
Message-ID: <Z9f96iXE0xxj8th7@google.com>
Subject: Re: [PATCH 1/2] rust: alloc: replace `Vec::set_len` with `inc_len`
From: Alice Ryhl <aliceryhl@google.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Tamir Duberstein <tamird@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Mar 17, 2025 at 09:58:35AM +0000, Benno Lossin wrote:
> On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
> > Rename `set_len` to `inc_len` and simplify its safety contract.
> > ---
> >  rust/kernel/alloc/kvec.rs | 19 +++++++++----------
> >  rust/kernel/str.rs        |  2 +-
> >  rust/kernel/uaccess.rs    |  2 +-
> >  3 files changed, 11 insertions(+), 12 deletions(-)
> >
> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > index ae9d072741ce..d43a1d609434 100644
> > --- a/rust/kernel/alloc/kvec.rs
> > +++ b/rust/kernel/alloc/kvec.rs
> > @@ -183,17 +183,16 @@ pub fn len(&self) -> usize {
> >          self.len
> >      }
> >  
> > -    /// Forcefully sets `self.len` to `new_len`.
> > +    /// Increments `self.len` by `additional`.
> 
> I would keep the "Forcefully".
> 
> >      ///
> >      /// # Safety
> >      ///
> > -    /// - `new_len` must be less than or equal to [`Self::capacity`].
> > -    /// - If `new_len` is greater than `self.len`, all elements within the interval
> > -    ///   [`self.len`,`new_len`) must be initialized.
> > +    /// - `self.len + additional` must be less than or equal to [`Self::capacity`].
> > +    /// - All elements within the interval [`self.len`,`self.len + additional`) must be initialized.
> >      #[inline]
> > -    pub unsafe fn set_len(&mut self, new_len: usize) {
> > -        debug_assert!(new_len <= self.capacity());
> > -        self.len = new_len;
> > +    pub unsafe fn inc_len(&mut self, additional: usize) {
> > +        debug_assert!(self.len() + additional <= self.capacity());
> 
> What if this overflows? Do we always have overflow debugging on when
> debug assertions are enabled? If yes, then this is fine.

I don't think we do.

> > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > index 28e2201604d6..005713839e9e 100644
> > --- a/rust/kernel/str.rs
> > +++ b/rust/kernel/str.rs
> > @@ -840,7 +840,7 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
> >  
> >          // SAFETY: The number of bytes that can be written to `f` is bounded by `size`, which is
> >          // `buf`'s capacity. The contents of the buffer have been initialised by writes to `f`.
> > -        unsafe { buf.set_len(f.bytes_written()) };
> > +        unsafe { buf.inc_len(f.bytes_written()) };
> 
> This change seems wrong unless the code was wrong to begin with.
> 
> Otherwise the change looks good.

The buffer has length zero as it was just created with:

let mut buf = KVec::with_capacity(size, GFP_KERNEL)?;

Alice

