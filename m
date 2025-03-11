Return-Path: <linux-kernel+bounces-556309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D35A5C3DD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A7818815BE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D334625CC67;
	Tue, 11 Mar 2025 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIkSDHg6"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A137F1925AF;
	Tue, 11 Mar 2025 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703597; cv=none; b=fN5ZMfdJao5G/UDKGqwaxGsDPUTE+6WAfqaikvwMzuNhavJKwSxy1Mn28z7t40ww4F9qpPLw4a4980I1oILC5S/r4iznHw047LM+thrQeiwk8m5PYFUbC83gCNT8r4PONw0wp4MLhU1LrilZn6X78rpOvLFpD4UsKrN6ow17lww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703597; c=relaxed/simple;
	bh=HdnCgmb2taCXgdDthxDkPSxyzIEd7qc+UeCPOJqtH9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTHHAhI0DsqVHe26sAzfC7nVZcia2YV3TCKqmwROZvsrh0FDfwor3/EphQgWZiLOxLJjOOBPTZN/wsMbL2SLuiAfHeSx6LAPpvfUF8M+evQ1FUprGpFgYS0Y8GL+rU/Ps1bXh1QVPtTc1F51EPHVy4dnLEc1xl06Rgst9AVmqkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIkSDHg6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2235189adaeso95146255ad.0;
        Tue, 11 Mar 2025 07:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741703595; x=1742308395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7IrnrFSjoSHcIPHm0oCpypuhfZ/F8/I+NOHsDs/8fXA=;
        b=nIkSDHg6VXdZI7CzMQqkgn0PLT205SWtkrbu6tGSk7RaYZGSWvDotZ3Z0ae9sXQRUn
         LuKMsMCMj8XNIsF/kK0el9DYHRCog6m/04Dd7P8g6zUcSU4br7tSJiI0pWJjC3VRgHO0
         MyDwrbOTQxSL4QJEG0ROpHYbeicuQtwzdFzWwT0Y3JK58Lwwr6EdViK/sKHvls5Zjg4m
         8TH42Kq2zr9lasp288vV2p8YI2D+jR9lKWnl2aQXYlzFM4teaZodanKI4jnUm60EXeJ0
         TKnZYTbBGHV4vhpvR/Nn4M+QEgV9Tmc3CRRB44acS/R23w6p1iybfZ7cJqRa/Ok33V6A
         rxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741703595; x=1742308395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IrnrFSjoSHcIPHm0oCpypuhfZ/F8/I+NOHsDs/8fXA=;
        b=G2zmumFRxj42/EsvvdbQsQpbQDH1/pnxmkkp3ynhuher0wjHxj3fy3tUKodDQNVBHn
         WatHIvwdOHjYrhVPru+a2dLstFhE6imEucJy9c1sEEaQLxAc42XqVeiyxUvfBCMOzofO
         Emf906uM7hQJk0WrWlvz9jrGVnfpIZxe4D9oAwqLfa8l1c3qGgbo2siKkqN7KWdDdRMx
         k4M5D1qPpuFZqc/GC6JdlR06lWBoTABW8W//N0ZbCJstjyg/67vbycG6FOLw/yAMHMN7
         g8oEBhRhf23mnRkiRIcKIcWT2IZpn5zZibpFqNsjgMrOX3B0OBGxrqC4SjAsyJLnxdsN
         P+Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUXoR4H51MfnTnH15WoALP+YJwU/t95ZCTKWbC8HSNtKYCg0lt5HP3+xx4xo6FRHXCYKgLkKJf7bR/WOi8=@vger.kernel.org, AJvYcCX+B03cUW1rxRYDki0U8cDYEqFnT1x6ate8VfEV08Nn3YV6O61f03LmSe/reqNpXwDYGTNE6qAVkTd5/JZAfgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrbYs5Mh4Y5m/qqxQlBMfQMAAZhM7fvSL8hiSdeSlqA4sbESTz
	6MwHh4ZhTLTFzB2hQz6srR0wiNmdBoaQ8ezjMHuMxoXmINW1dC9Q
X-Gm-Gg: ASbGnctNTsmUwTJo1khwstSyRtvfvo6Mp+azIkk83wS2RmOlChNOfeoexZfZeSh/UnJ
	sgx02ftaF/y42acL6sWDr+cgMLfLNGz0Z9BKTUUe4vV0hqExfomyis4TC0gdPsEipxwzXZqQw0t
	Cr339qkcE0sn3sxG9uCqCn6wO5ZQpl4jbK+M4VTNbmf3KOAg8g5uESa/Mq5jn5e5EJF9DJZB2AZ
	P10NHwrj6OxJlu1hZy0mC3Ke9MbQEPaKChhI1Us3tTRY/h4y/yyqfSXM+etN8JylOevmEojCOCv
	Rn5/20O2yIYzbsZXtv/ZNquUmCOY4tnZjej47mHud0qge0r+ppeI7FB7e8BVX7ydK8gj
X-Google-Smtp-Source: AGHT+IGpzpjnJ8S/CWjBEu/WHcV7Hie4ZZ+quYOqn+gTcaDZzj7EtvugVrKwdF4U+eKa3nYVrjWu0w==
X-Received: by 2002:a17:902:f541:b0:21f:6ce8:29df with SMTP id d9443c01a7336-22593d3fe0dmr42037295ad.3.1741703593258;
        Tue, 11 Mar 2025 07:33:13 -0700 (PDT)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa4be4sm98009605ad.216.2025.03.11.07.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:33:12 -0700 (PDT)
Date: Tue, 11 Mar 2025 10:33:10 -0400
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
Subject: Re: [PATCH v3] rust: add bindings and API for bitmap.h and bitops.h.
Message-ID: <Z9BJpq_qoECimNua@thinkpad>
References: <20250310161947.1767855-2-bqe@google.com>
 <Z88rhn5nVbd4-JSE@thinkpad>
 <Z9ALU7XVPt8JKKFR@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9ALU7XVPt8JKKFR@google.com>

On Tue, Mar 11, 2025 at 10:07:15AM +0000, Alice Ryhl wrote:
> On Mon, Mar 10, 2025 at 02:12:22PM -0400, Yury Norov wrote:
> > On Mon, Mar 10, 2025 at 04:19:46PM +0000, Burak Emir wrote:
> > > Adds a Rust bitmap API and necessary bitmap and bitops bindings.
> > > These are for porting the approach from commit 15d9da3f818c ("binder:
> > > use bitmap for faster descriptor lookup") to Rust. The functionality
> > > in dbitmap.h makes use of bitmap and bitops.
> > 
> > Please add it in the same series that converts dbitmap to rust. This
> > all is a dead code otherwise, right?
> 
> Rust Binder is not upstream yet. We are upstreaming its dependencies
> before the driver itself, so there will be dead code no matter what. The
> number of dependencies is so large that it's completely impractical to
> land them together with the driver.

I don't ask to upstream all at once. But at least dbitmaps is less
than 200 LOCs in C. Together with a test that demonstrates how you're
using it, it would be enough.
 
> We can include a patch that includes the wrapper data structure that
> Rust Binder builds on top of bitmap. We can also include a link to the
> Rust Binder change that makes Binder start using this code.
>
> > > +            let ptr = unsafe { bindings::bitmap_zalloc(nbits_u32, flags.as_raw()) };
> > > +            // Zero-size allocation is ok and yields a dangling pointer.
> > 
> > Zero-sized allocation makes no sense, and usually is a sign of a bug.
> > What for you explicitly allow it?
> 
> I do think that it makes sense to allow a bitmap of size zero. We allow
> bitmaps of any other length. Why should that length be special?
> 
> Of course, I guess it might make sense to not call `bitmap_zalloc` when
> calling `new(0)`? But kmalloc does seem to allow them.

Without looking at the code it's "I think vs you think". 

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
> > Also, you can make it similar to BUG_ON() semantics, so that it will
> > be a single line of code, not 3:
> > 
> >         RUST_PANIC("Copy: out of bonds", self.nbits < src.nbits);
> > 
> > And to that extend, panic message should be available to all rust
> > subsystems, just like BUG_ON().
> 
> We could use
> assert!(src.nbits <= self.nbits, "Copy: out of bounds.");
> 
> but using these explicit function calls would generate less code and
> avoid duplicating the error messages.

What I see is that you generate more code - 3 lines vs 1.

Do you have any numbers supporting your statement? Can you show how
exactly the messages are duplicated when using assert()? Can this
assert() be fixed to avoid duplication?

> Also, we should add #[track_caller] to these methods so that the line
> number in the panic message is taken from the caller rather than this
> file.
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
> 
> Ah, that's nice! I do think it's still good to have them for hardening
> reasons. Passing an out-of-bouds offset is a bug.

Ironically, you don't test the offset for safety.

Whether it's a bug or not - depends on algorithm you're implementing. 
Check how for_each_set_bitrange() works. For it, offset >= nbits is
expected, at last iteration. It's completely safe, although out-of-range.

Thanks,
Yury

