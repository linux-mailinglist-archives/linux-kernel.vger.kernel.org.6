Return-Path: <linux-kernel+bounces-541981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC01A4C424
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DD8188E478
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A552135CB;
	Mon,  3 Mar 2025 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FShK3EoR"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B2218D620;
	Mon,  3 Mar 2025 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014237; cv=none; b=lpnMf2NQqZwvATrAEgKljekDY9heFX7H7VEBW/jdlqQtosXNufinu1F/Cy5hXPaRmOwNwjG+CNgzIottBggNgadDTtKHsJ5TOgmBdv0ki7A37x4UusBXMldgFx5W9mka6DQFjYUcxhbE1zSC0ZEyF+2ZrAimGjxBJJSaWqHSPFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014237; c=relaxed/simple;
	bh=D+2OjHifyWJer/WkKi39uakZygvjoE6gINPmlEYsVE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLvjP7CImlbr1vIaazlj4ijE1g3P9EebjFxAahbOtYrVcENufw7tQUHNkmmT0KCmaWfJY3nWbazV9dkbdFrV+rkiL4pmX+qx9w2EWAKITYVoPXkIy9bD8ZuqCQaLkqI2O7DE6AffqTCPO876GvM1ns6Ey3V7scMT7YqqS4XqSl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FShK3EoR; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f768e9be1aso52330097b3.0;
        Mon, 03 Mar 2025 07:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741014234; x=1741619034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+dzQxlm+hznt93iYLJumzN/omtywLYvhZijugcl3wM=;
        b=FShK3EoRJG1gIEDFoe0UKv77whxEamO2wL22VUSBf4Gi4InDQqt7omBNkXQaX5O4sD
         /RF3inAkTcviOQDOfHldfMRGD1DdedKCER7PF/++McionyaEcSeLH464y3SBN+lRWYYN
         9RxRM+dzBgYFqVza8AqEpFLAaTpEpVJp866P7vvdA6QjiWQ6GMt+g6YND8qLnBgyh3RN
         m5HXwAEaE/phxuUmPL9enIJ+6gA0zZQd2A8GteHKnIBj1iko1uD2MpOrDHBD/M8Uj89O
         z6oXBAGj1CG/lt5xp5r3EtQyHNpAB4Dfiwhsk8g5V6yK96sdxm9PhozlwOMbQfqqI571
         bzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741014234; x=1741619034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+dzQxlm+hznt93iYLJumzN/omtywLYvhZijugcl3wM=;
        b=CgMy4noXCFqwQgDrxymMdnRWMyX8XlwL5cnzqixTyFpFkmoWSvIzuIGbnwTrpnQEiu
         dwxbFty6jmDKtxdqK8NLVj9lxAwmklkgiKo5C0B863iBQa092UYPVZgVxCwoz7WtbN4+
         IIA8sxgkxD7XrW5t2qpwNpqsrUnY6aLlRHVJvCpirs4fqXCeErQUFYeH2oEWTHFSajpR
         ZNlUkLiQzQEsSKpqO/YP6W5DAY+U1RfQ7OY60gjuWU+1OJd5Wx6eK3yRiGFFoo9yXbRp
         i4cgxk4pjKDd6aJuN56GpE9VJkXyzWFJU32DUM0YQDZLMdM1T9LxSG+P4FmpZrzcCDbP
         jELQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE3mmNjJWemw/2SzmQMxebE0Wm1qP1cQbuO523DBaTCQmP5VoartG3fFfgC4e/cqeVeh0D0heoJDFfim3buZY=@vger.kernel.org, AJvYcCWKqKWEAnftolgPYQEHLXQUpVq+9Lwc3Og0oj0xQeYm4LdA6ysfNwVRkLQAZAfM3KRf80zmOL9EtekWuHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIgwkYhx2ZZ0hyrSh7KpKRdNWGrWTa7mHIndHVnEjFO4cw0b0m
	wiamvyPgOrnJiQMp3bw+A/v8N8VMBpThu4uyH7XU48lU0fJz1klg
X-Gm-Gg: ASbGnct4e5Zt08vga1V4zVdGWE5s/LpGcHIdHC5pQexO0fHyyMt5SB6X7tiHPRpcDoN
	kvbC2C6jWScegNiYhC/SzT03YwE0l+fNwUDiekuYqtc2taU4C5Ed+X1AcsuDB40QxA+mUFb/TCf
	RrhQvaNnKp3wgspeAzgJYYCDpqeXuiMtYg5QGFzVGemHSd0KCCx0xJLpsFiJTFDbHxhczZ31/dl
	SX+uhSmcLGmgkPB9414HysCxboiHWe4Lto6aImDwy7syAMHtlshzIBvYZEVpLtVbB9e3ec3xRXD
	FS6Hr8GkA5x/hPMRKBdl5PgxO8zW+aaiNHR/PdVGf9liFSEb0ebl8b7e9GWzaOlQYplz+o611Hx
	WSHwJ
X-Google-Smtp-Source: AGHT+IHGiYXy/BjrKAy1qTEMsokZjZvqxm65haT2o9Z0kZqUyVg0LDK8WBbag2g6ZRoQJNTfFSCJ7A==
X-Received: by 2002:a05:6902:1089:b0:e60:88f9:b081 with SMTP id 3f1490d57ef6-e60b23f8464mr17772239276.17.1741014234375;
        Mon, 03 Mar 2025 07:03:54 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e60a3a1fef8sm2978694276.12.2025.03.03.07.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:03:53 -0800 (PST)
Date: Mon, 3 Mar 2025 10:03:52 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: add bindings and API for bitmap.h and bitops.h.
Message-ID: <Z8XE2H3vGDNiOra7@thinkpad>
References: <20250303114037.3259804-2-bqe@google.com>
 <CAH5fLgjPTvXzcSVDWeYN7nLgxMZgeHUbHiDOv4R=uRBG=50UNQ@mail.gmail.com>
 <CAH5fLgiQkPpMUV0Bvmwd5zUsHy=GHLdoVFjRuAPxpWCbBiD2Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLgiQkPpMUV0Bvmwd5zUsHy=GHLdoVFjRuAPxpWCbBiD2Jw@mail.gmail.com>

On Mon, Mar 03, 2025 at 02:01:44PM +0100, Alice Ryhl wrote:
> > > +void rust_helper_bitmap_copy(unsigned long *dst, const unsigned long *src, unsigned int nbits)
> > > +{
> > > +       bitmap_copy(dst, src, nbits);
> > > +}
> >
> > I was about to say that this could just be a memcpy, but ...
> >
> > > +    /// Copy up to `nbits` bits from this bitmap into another.
> > > +    ///
> > > +    /// # Panics
> > > +    ///
> > > +    /// Panics if `nbits` is too large for this bitmap or destination.
> > > +    #[inline]
> > > +    pub fn bitmap_copy(&self, dst: &mut Bitmap, nbits: usize) {
> > > +        if self.nbits < nbits {
> > > +            panic_not_in_bounds_le("nbits", self.nbits, nbits);
> > > +        }
> > > +        if dst.nbits < nbits {
> > > +            panic_not_in_bounds_le("nbits", dst.nbits, nbits);
> > > +        }
> > > +        // SAFETY: nbits == 0 is supported and access to `self` and `dst` is within bounds.
> > > +        unsafe { bindings::bitmap_copy(dst.as_mut_ptr(), self.ptr.as_ptr(), nbits as u32) };
> > > +    }
> >
> > ... then I realized that we're probably not using it correctly. I
> > would expect this to modify the first `nbits` bits in `dst`, leaving
> > any remaining bits unmodified. However, if nbits is not divisible by
> > BITS_PER_LONG it might modify some bits it shouldn't.
> >
> > That said, Binder needs this only in the case where the sizes are
> > equal. Perhaps we could rename this to `copy_from_bitmap` with this
> > signature:
> > fn copy_from_bitmap(&mut self, src: Bitmap)
> 
> Sorry I meant src: &Bitmap here.

Yes, you're right. bitmap_copy() copies the whole bitmap. So if your
Bitmap already has size, you don't need to pass it explicitly.
 
> Also, we could rewrite it to just call memcpy rather than go through
> bitmap_copy. Though that requires us to have a Rust version of
> bitmap_size, which I think it makes sense to avoid using a Rust helper
> for.

No, you couldn't. I don't want rust bindings to diverge from the main
kernel. So the rule is simple: if inline wrapper exists only for the
small_const_nbits() optimization - go ahead and use the outlined
underscored version. If the wrapper does something else - no matter
what - it should be wrapped.

> We could reimplement it by first computing the number of longs and
> then computing the number of bytes
> 
> const fn bitmap_size(nbits: usize) -> usize {
>     nbits.div_ceil(c_ulong::BITS) * size_of::<c_ulong>()
> }
> 
> Thoughts?
> 
> Alice

