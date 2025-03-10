Return-Path: <linux-kernel+bounces-555255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4489A5AA76
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFCB171BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725AF1F09B0;
	Mon, 10 Mar 2025 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0jZe5jL"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088118C011;
	Mon, 10 Mar 2025 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741647700; cv=none; b=HhB52j8KnzMNm+9Kx6vIuyBvvUWkS+kxHlvWdV/jbtqVo5HcyljD1Cx+3FAWuyx2oPjRzXf/CimYmSXOige3AoQCtxkDoFa77M3Mkd8lfAuIuYXblC5eZ7EUrFHeyqlrZ4VtqTAnW62gGCOryS0TRL4fxNYPLBXXG8HOPGaBh1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741647700; c=relaxed/simple;
	bh=VB9rAb4iaNZ43WyWj8V13VIqb7dDpxTESXi6vMpB7ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFUjFiRjbmI+qEtu3cl2gt3kgtGQY1dBplANETgk7F4EuwEUYnBtE3Yh8yXCUStO4dkqdNjGMn5+ChYHfG59z60D7XXRoHD54jCQBDvvaxL7N9z1+6QiWowtitkKdHmxwJW8CNr+SwEr+G46SgD0+IdNfhL7uQIEQMRizx0XXno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0jZe5jL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2235189adaeso80879485ad.0;
        Mon, 10 Mar 2025 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741647698; x=1742252498; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2m2S/nSTwDrkiV57yVeTIokC681YWEsu5yiHRcDLoXE=;
        b=c0jZe5jLSY/fjurGLL3+g4MOS29rQL/JN4frLhCdV6bBxNdgacXrCM8eUV+4SZhn80
         TB8DvRDjU8a6jHKH3Tc1MSQ9eLaPMB1PjrGMAMKsL7uy+TrE+XV1XxrPiB/iywjq2Ifg
         Ne5HUDE6F8fNCbC1JvSt/4RjMxR2E/LUTOSkLe1xiTEpEcxIexX4atGlqhOJvROGhwZx
         H0hYmzxiZrtVGqMu75HsYgNIzREWUi8HJprCz3oiKlDrsCMFQHAIGUSAeK+3GYdQ+nEx
         gwqTy6ZejX7UelTHv1QJxhTf/v7f8p9CcirGdse6jURAxFzz7FpXtaOLFMg/Ytlx47QW
         wEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741647698; x=1742252498;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2m2S/nSTwDrkiV57yVeTIokC681YWEsu5yiHRcDLoXE=;
        b=Ileo58Bjv/i8rnAzC4v8F7RdLlYx0dTqqOYa6F34rqfBpkDKN7hufRmHt1MLTkRYXf
         uRsaXErk0uydq7LOcA99TlvaRP2Vk8gzerzUxhxYcPSa0/WQAuAwcTgTXbgtg6jUKat+
         PyG9dcT9H0xZsbepcJ9AOcEs6FXwFxS/NDyweGsWMoYbZsTYDeTyije5qrEcOXdjXCha
         ROvbqucE0lp7myzNSHOu0Pmf+HwAWFBfqS3PsodpByfM6T0B0FquNkAghZUkECHkm61v
         wW2WBTLGvVtzVHwKlVBQLMKehWJm8SRNIjgsMlNC7roCUcpDk4SNxW1VfdmgoWzBPP73
         5rsw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ8/sws/qNbiNTzns+z90Yd3qalgbTiDV6XQt+khPo/2R5zzIEGSyjVso5NvRx553khTD5GywFBsWsNt4=@vger.kernel.org, AJvYcCWz2SLBN5xXDlgzTzEyyLe+uc/P1zv/qThZz5jQOqbiqC3fIu6NgP5kccby91p4UwahIZhpl0+BCGznvAKlay0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFElUtVo3lkw6X37oOWnB+/P6g8qi9XeTohjjSSM3FzBkKHYBk
	Y/o/Syjb4FlraDPIUnyMTZCSHJm+fR+7jznG0UynyGmUhOaXpgzc
X-Gm-Gg: ASbGncvVQczYG0g8+xebX4THnMBgKl2ki1Ia6v4wFj1EGfXs6+C77zP9zBeobUa+b/m
	GJCUxY2+8nS+fN/rZhx7CnW7dybKG7kfSJWcQL6sDqbYnu5dzyZv3Ps/eXro6WP7EAezR9iTteb
	LO66Vdz2c7lmEzISjeEL++SUp/FZQMrxxVx3sR88xbhM/uJA0M0z4gaixQ+6jow5Kby7WwTb2TI
	fv1vO/Fa+3Tz60CmmN9Vv3x53F/tWSOtwlOSEokkPAKhTimfhIbWBWGqbmrM0C4EnSm1cv860Xl
	3hOhWEDqLYrJZey0j27gvsltqp98SQxcHBa7x3DAZjtm
X-Google-Smtp-Source: AGHT+IH3KO2eXIco+jhz5X2Czg/TofsMwiLTZ4qvSN8L2cUwE0C3LYstiRFZ7aMgUw+jBr0pYAM3GA==
X-Received: by 2002:a17:902:dacc:b0:223:517a:d4ed with SMTP id d9443c01a7336-22593d84b17mr14738555ad.15.1741647697859;
        Mon, 10 Mar 2025 16:01:37 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddffesm84371935ad.40.2025.03.10.16.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 16:01:37 -0700 (PDT)
Date: Mon, 10 Mar 2025 19:01:35 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Burak Emir <bqe@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: add bindings and API for bitmap.h and bitops.h.
Message-ID: <Z89vSWdl3skR-N2q@thinkpad>
References: <20250310161947.1767855-2-bqe@google.com>
 <Z88rhn5nVbd4-JSE@thinkpad>
 <CACQBu=VJNA-BFyxGd6ZLCp3hH19emDZX_TikZb9O=_Amu+BwNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACQBu=VJNA-BFyxGd6ZLCp3hH19emDZX_TikZb9O=_Amu+BwNQ@mail.gmail.com>

On Mon, Mar 10, 2025 at 11:01:37PM +0100, Burak Emir wrote:
> > > +            let ptr = unsafe { bindings::bitmap_zalloc(nbits_u32, flags.as_raw()) };
> > > +            // Zero-size allocation is ok and yields a dangling pointer.
> >
> > Zero-sized allocation makes no sense, and usually is a sign of a bug.
> > What for you explicitly allow it?
> >
> 
> I copied from dbitmap, but more importantly Rust requires that when
> memory is accessed, it has to be initialized before. So if I used alloc,
> I'd have to initialize manually.

If you have a pointer to a memory area of size 0, it's unsafe to
even dereference it. Luckily, initialization of 0-bit array is a
no-op. I don't understand how to initialize 0 bits.

This dbitmap thing looks messy. It uses atomic set_bit() where
non-atomic should be used. Now it encourages to create 0-sized
bitmaps. Please don't copy anything blindly from there...

[...]

> On Mon, Mar 10, 2025 at 7:12 PM Yury Norov <yury.norov@gmail.com> wrote:
> > > +    /// Copies all bits from `src` and sets any remaining bits to zero.
> > > +    ///
> > > +    /// # Panics
> > > +    ///
> > > +    /// Panics if `src.nbits` has more bits than this bitmap.
> > > +    #[inline]
> > > +    pub fn copy_from_bitmap_and_extend(&mut self, src: &Bitmap) {
> > > +        if self.nbits < src.nbits {
> > > +            panic_not_in_bounds_le("src.nbits", self.nbits, src.nbits);
> >
> > The _lt usually stands for 'less than', or '<'. And _le is 'less than or
> > equal', or '<='. But in your code you do exactly opposite. Is that on
> > purpose?
> >
> 
> Yeah, I realize this is a bit hard to read. Made the check consistent
> with the panic message call.
> 
> > Also, you can make it similar to BUG_ON() semantics, so that it will
> > be a single line of code, not 3:
> >
> >         RUST_PANIC("Copy: out of bonds", self.nbits < src.nbits);
> >
> > And to that extend, panic message should be available to all rust
> > subsystems, just like BUG_ON().
> 
> A general bound checking macro BUG_ON sounds interesting
> I will have to ask the other folks about this. For now, I'd like
> to keep the simpler but more verbose if & panic.

I don't suggest to use BUG_ON(). I suggest to use similar semantics.
You repeat that 3 lines again and again. It cries to become a nice
macro.
 
> > > +        }
> > > +        // SAFETY: nbits == 0 is supported and access to `self` and `src` is within bounds.
> > > +        unsafe {
> > > +            bindings::bitmap_copy_and_extend(self.as_mut_ptr(), src.as_ptr(), src.nbits as u32, self.nbits as u32)
> > > +        };
> > > +    }
> > > +
> > > +    /// Finds the last bit.
> > > +    #[inline]
> > > +    pub fn find_last_bit(&self) -> usize {
> > > +        // SAFETY: nbits == 0 is supported and access is within bounds.
> > > +        unsafe { bindings::_find_last_bit(self.as_ptr(), self.nbits) }
> > > +    }
> > > +
> > > +    /// Finds the last bit, searching up to `nbits` bits.
> > > +    ///
> > > +    /// # Panics
> > > +    ///
> > > +    /// Panics if `nbits` is too large for this bitmap.
> > > +    #[inline]
> > > +    pub fn find_last_bit_upto(&self, nbits: usize) -> usize {
> >
> > So this is not a binding, right? This is a new function. In C code we
> > don't support partial search. Can you confirm you need a partial
> > search here? What's your use scenario?
> >
> > Really, this should go with the series that converts dbitmap.
> > Otherwise it's hard to understand what you're trying to do.
> >
> 
> Tamir asked about these as well. I think I misunderstood the
> C API as supporting partial search, and wanted to make
> sure the functionality is preserved.
> 
> I now realize that the intention of the size parameter is to always
> pass the size. Will remove.

OK, good. You may look at cpumasks and nodemasks - those are 2 most
developed wrappers around bitmaps, and good examples of the API usage.

> > > +        if self.nbits < nbits {
> > > +            panic_not_in_bounds_le("nbits", self.nbits, nbits);
> > > +        }
> > > +        // SAFETY: nbits == 0 is supported and access is within bounds.
> > > +        unsafe { bindings::_find_last_bit(self.as_ptr(), nbits) }
> > > +    }
> > > +
> > > +    /// Finds the next zero bit, searching up to `nbits`.
> > > +    ///
> > > +    /// # Panics
> > > +    ///
> > > +    /// Panics if `nbits` is too large for this bitmap.
> > > +    #[inline]
> > > +    pub fn find_next_zero_bit_upto(&self, nbits: usize) -> usize {
> >
> > 1. This should be 'find_first_zero_bit'.
> >
> > 2. The same question as to previous function. In this case you will
> > most likely be OK with plain find_first_zero_bit(). So if it returns a
> > number greater than 'nbits', it means that first nbits are empty for
> > sure. Is it a performance trick?
> >
> 
> No, I just looked at the find_first_zero implementation and thought
> that it supports partial search. Removing.

In C user provides nbits explicitly, so partial search is allowed
automatically. Here you pack a pointer with size, and it makes your
API less robust. This robustness may or may not be needed by users.
Cpumasks and nodemasks don't need floating nbits, so they just hardcode
it.

You didn't show the actual code, and I don't understand what exactly do
you need. If you want to operate on first nbits, just don't attach size
to the pointer, IMO...

> > > +        if self.nbits < nbits {
> > > +            panic_not_in_bounds_le("nbits", self.nbits, nbits);
> > > +        }
> > > +        // SAFETY: nbits == 0 is supported and access is within bounds.
> > > +        unsafe {
> > > +            bindings::_find_next_zero_bit(self.as_ptr(), nbits, 0 /* offset */)
> >
> > For offset == 0 we have find_first_bit() functions.
> >
> 
> Good point, I will remove this and expose only the variant with offset.
> That is the one used by dbitmap anyways.
> 
> > > +        }
> > > +    }
> > > +
> > > +    /// Finds the next zero bit, searching up to `nbits` bits, with offset `offset`.
> > > +    ///
> > > +    /// # Panics
> > > +    ///
> > > +    /// Panics if `nbits` is too large for this bitmap.
> > > +    #[inline]
> > > +    pub fn find_next_zero_bit_upto_offset(&self, nbits: usize, offset: usize) -> usize {
> > > +        if self.nbits < nbits {
> > > +            panic_not_in_bounds_le("nbits", self.nbits, nbits);
> > > +        }
> > > +        // SAFETY: nbits == 0 and out-of-bounds offset is supported, and access is within bounds.
> >
> > find_bit() functions are all safe against nbits == 0 or
> > offset >= nbits. If you add those panics for hardening reasons - it's
> > OK. If you add them to make your code safer - you don't need them. The
> > C version is already safe.
> >
> 
> I assume you are asking about the SAFETY comment, not the bound check.

No, I'm asking about your panic()s. find_bit() functions don't dereference
memory that is out of boundaries, and don't crash the kernel. If nbits is
0, or offset >= nbits, find_bit() returns immediately and doesn't touch
any memory. But you may want to print a message and go panic. This is not
how the original find_bit() works. But you may want to do it for debugging
or hardening reasons.

So I wanted to clarify: is it intentional? Maybe add a comment? Also,
if it's a debugging feature, you most likely need to make it depending
on CONFIG_DEBUG_XXX.

Thanks,
Yury

> The convention with SAFETY comments is in the Rust coding guidelines.
> The comments are there to convince the reader that the
> immediately-following "unsafe {...}" block can never lead to undefined behavior.
> I looked at the C code and documented that it is safe, so the reader
> does not have to. The goal
> is to enable local reasoning, so the reader can check a piece of code
> in isolation.
>
> I call out the nbits == 0 case every time, because we are passing a
> dangling pointer to C.
> It may not be very obvious that this is an ok thing to do, and
> explicit is better than implicit.
> 
> > > +        unsafe { bindings::_find_next_zero_bit(self.as_ptr(), nbits, offset) }
> > > +    }
> > > +}
> > > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > > index efbd7be98dab..be06ffc47473 100644
> > > --- a/rust/kernel/lib.rs
> > > +++ b/rust/kernel/lib.rs
> > > @@ -36,6 +36,7 @@
> > >  pub use ffi;
> > >
> > >  pub mod alloc;
> > > +pub mod bitmap;
> > >  #[cfg(CONFIG_BLOCK)]
> > >  pub mod block;
> > >  #[doc(hidden)]
> > > --
> > > 2.49.0.rc0.332.g42c0ae87b1-goog

