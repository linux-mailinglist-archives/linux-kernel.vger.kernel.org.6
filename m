Return-Path: <linux-kernel+bounces-555824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC44A5BD39
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA0F16824E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE1E22F389;
	Tue, 11 Mar 2025 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHMgUjq/"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34C42065
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687640; cv=none; b=lICfzcJFnFJFUM4eCX4vTQQU5NKnJyLnDvyPbGMIW4qmCNDWqPDYizMmHBCt3/AVocfC0sjdGctmsALwvR/Z0Wf7NCwP4Q1jmVcpVCVHJJ+Jahxu3dViCoyFlfQVEt85PMoo6U7cSEEU8I5U5M6YF3lxPnsK7bfbgdKk6YwV8+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687640; c=relaxed/simple;
	bh=ks/m4Dg9e0LsX5W+24SIh9BwJqlTaUJ+OARn0HBP7Yw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oOwq4p+vFt4mcLM2YRSLG4xfp+MfBzgv9mIPMhyLB3agqYL/V88/oaCU5B5LP7nIDgChjG+6GrSYBirDp9WNv0PQ2aE6MViH0sRTWVelEGEyDOdsxHbD7Mjn9xjLa6P/rwPlP5MLHLhpJBOqjCCSwqP0we4VwRvqJnLqMkEKe7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vHMgUjq/; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4394c489babso26126345e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 03:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741687637; x=1742292437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6gKIm9f9CvLqznwxBzrfnGnuGny9X8dBk6FhNmJ3B9Q=;
        b=vHMgUjq/ssU1zIaLt1vOipk+B7sHPXhE17iQFWczzaFqVJ/j0wqhc5KnqkAae2mooI
         wcHM9Wmf2GmY+Z/tFvDvkdmwGVf6Vep7qNyimmyZokE6QyNDaGGjk2Xbrc3OUzXagWOh
         X5TIbKEW0jZIwucLSAjxkqBf0zeIVI2r5aVD9tLpNZW2E74Tyv14p21nWwUbmMEQJkpd
         RE1WZmGSWfHulrSI2nEmOUo2devSWHQDr+Lo6E9o/G1R+LN6SXHutCKLgqPbinxcoVm1
         DKVMR1GtO/yS8RRoDsdsYfoa6LSQy6CHKh2H7IwAMP82Uk6nVIC3dd4Yn+uORzAbEetv
         G+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741687637; x=1742292437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6gKIm9f9CvLqznwxBzrfnGnuGny9X8dBk6FhNmJ3B9Q=;
        b=RHlpQOuheS+VNB4ntuzy+5SVYmV0JF5wCA0EYLfjuSyFQd1M+5CdMZze4pcYnVAeya
         2BawoYYRwaiuIspPl/12N9FXUhXUFRtWjOffzEE+JFKBacRAzQNvfGYghGQ+/JKBaac7
         cb2JmNdoLdbiIfq+JS16eLsuiyML05+rTCgbemDWq1YdsVBLjYWYZEmV/iRBiHbFNthJ
         pb2ksvfeetK2QHJun6TNMvZMt8/PAkFtOTEXVPQJ+fLChlukw9tWtGJ30oHz3skkKpSV
         Fuh8Wko6CtGRhG4NJ8o8zxh/Q30HGM+Ykxz7fA29ko9ivlPRT2lHV6OZvIGVtyO/jVLS
         5cdg==
X-Forwarded-Encrypted: i=1; AJvYcCWsbxq59/81hfChCSg5tQEk2ngXO7Mu3A0/kxiQ2tWJ5mHpA3UXHO//ncECXWoFQuIpJ+qe2mwiq+mNir8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX7iVM7cwl91YXvnCDglQsmEBXKpu1IdkwMYiGLwBy8yNPcRkV
	RcflEQiDo9+uK8dtyKDIDOxvyjLNVO6fFUqMlyYKLGbg4w/++imVzkFlBLIKwpChNUBeu9ObymV
	QcdkMS2fopEqQ3g==
X-Google-Smtp-Source: AGHT+IHm3IFgyjHliXGRSyHcjqv5KSX/xVFX6JhRSVcGMyAOulpQHr5iOaqTDRsQTZV+1DDQGv83dxho+R9CegY=
X-Received: from wmgg5.prod.google.com ([2002:a05:600d:5:b0:43b:bd03:5d2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5120:b0:43c:f85d:1245 with SMTP id 5b1f17b1804b1-43cf85d1427mr68893195e9.17.1741687637311;
 Tue, 11 Mar 2025 03:07:17 -0700 (PDT)
Date: Tue, 11 Mar 2025 10:07:15 +0000
In-Reply-To: <Z88rhn5nVbd4-JSE@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250310161947.1767855-2-bqe@google.com> <Z88rhn5nVbd4-JSE@thinkpad>
Message-ID: <Z9ALU7XVPt8JKKFR@google.com>
Subject: Re: [PATCH v3] rust: add bindings and API for bitmap.h and bitops.h.
From: Alice Ryhl <aliceryhl@google.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Mar 10, 2025 at 02:12:22PM -0400, Yury Norov wrote:
> On Mon, Mar 10, 2025 at 04:19:46PM +0000, Burak Emir wrote:
> > Adds a Rust bitmap API and necessary bitmap and bitops bindings.
> > These are for porting the approach from commit 15d9da3f818c ("binder:
> > use bitmap for faster descriptor lookup") to Rust. The functionality
> > in dbitmap.h makes use of bitmap and bitops.
> 
> Please add it in the same series that converts dbitmap to rust. This
> all is a dead code otherwise, right?

Rust Binder is not upstream yet. We are upstreaming its dependencies
before the driver itself, so there will be dead code no matter what. The
number of dependencies is so large that it's completely impractical to
land them together with the driver.

We can include a patch that includes the wrapper data structure that
Rust Binder builds on top of bitmap. We can also include a link to the
Rust Binder change that makes Binder start using this code.

> > +            let ptr = unsafe { bindings::bitmap_zalloc(nbits_u32, flags.as_raw()) };
> > +            // Zero-size allocation is ok and yields a dangling pointer.
> 
> Zero-sized allocation makes no sense, and usually is a sign of a bug.
> What for you explicitly allow it?

I do think that it makes sense to allow a bitmap of size zero. We allow
bitmaps of any other length. Why should that length be special?

Of course, I guess it might make sense to not call `bitmap_zalloc` when
calling `new(0)`? But kmalloc does seem to allow them.

> > +    /// Copies all bits from `src` and sets any remaining bits to zero.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `src.nbits` has more bits than this bitmap.
> > +    #[inline]
> > +    pub fn copy_from_bitmap_and_extend(&mut self, src: &Bitmap) {
> > +        if self.nbits < src.nbits {
> > +            panic_not_in_bounds_le("src.nbits", self.nbits, src.nbits);
> 
> The _lt usually stands for 'less than', or '<'. And _le is 'less than or
> equal', or '<='. But in your code you do exactly opposite. Is that on
> purpose?
> 
> Also, you can make it similar to BUG_ON() semantics, so that it will
> be a single line of code, not 3:
> 
>         RUST_PANIC("Copy: out of bonds", self.nbits < src.nbits);
> 
> And to that extend, panic message should be available to all rust
> subsystems, just like BUG_ON().

We could use
assert!(src.nbits <= self.nbits, "Copy: out of bounds.");

but using these explicit function calls would generate less code and
avoid duplicating the error messages.

Also, we should add #[track_caller] to these methods so that the line
number in the panic message is taken from the caller rather than this
file.

> > +        }
> > +    }
> > +
> > +    /// Finds the next zero bit, searching up to `nbits` bits, with offset `offset`.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `nbits` is too large for this bitmap.
> > +    #[inline]
> > +    pub fn find_next_zero_bit_upto_offset(&self, nbits: usize, offset: usize) -> usize {
> > +        if self.nbits < nbits {
> > +            panic_not_in_bounds_le("nbits", self.nbits, nbits);
> > +        }
> > +        // SAFETY: nbits == 0 and out-of-bounds offset is supported, and access is within bounds.
> 
> find_bit() functions are all safe against nbits == 0 or
> offset >= nbits. If you add those panics for hardening reasons - it's
> OK. If you add them to make your code safer - you don't need them. The
> C version is already safe.

Ah, that's nice! I do think it's still good to have them for hardening
reasons. Passing an out-of-bouds offset is a bug.

Alice

