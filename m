Return-Path: <linux-kernel+bounces-567958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C27A68C67
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFAC880EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929EE255257;
	Wed, 19 Mar 2025 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sXgjGvIF"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F11E1DF4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386128; cv=none; b=IQbUS6/491PnIZUsMPUcW3Ah2AL3fTwfp7VAARlhfBukf/GE1HqUltoNLj8FH6CFBa5aYhjzC/ChKQAqK0FCAIBogkHAHLkQf1ABDEnCYewZJNaznghdG6Bw34cxKZAbMaHrh3BQdgfwnteLGzk1PE6IXJ3nHAZkDcWdvIkKRks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386128; c=relaxed/simple;
	bh=Uu5dXM9ILfjH5TJ5YQGk13KTL641uUmhuLSYu+lGQ+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OGqTgLgf54zsksI+F/pJWoJDfplTts47ycmEszDMUno6Izjs17GjhWZf5y9Ddl0ba+G82QKmM+ZpZbEo0b8W+Qiuq8Hw5ydGGT/bBj+GI+tez58HNyjSuLsGzBExkijC8B3+CYPJEw3r02R3l1D4T3OXEXrssP0goxOW2Jr9APU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sXgjGvIF; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-438e180821aso20039835e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742386124; x=1742990924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hsK/Ju+fyU70N3qDFOX/p7Jl1CF8IdfwtoJGuoZeV9Y=;
        b=sXgjGvIF0oukfJr4Av/V0wSjTDqaxWyyyzF9xVn0ROUi68vUURNrmq9xakMsGV0nw1
         Xlhg3qQgxKqfhjtGX6SGJBRSVnf1Dba8bEtICEjU6WORD1sYDLMYGWSNoDsH1lov6VC8
         5BFu0qBKEkuJ8MUTY8Rimu3dFFFoTtu8sDVKs+d4ZiXfPAFQsv4I0TtSCa1M1GJJifMv
         vfCSwJjf946Cpyma7RKzoRO4i+SmtImXqs5dr2tHg6v+DbsRam9mxhdfArHmt7c8Y/qQ
         UoNDVchge5lAEdt5q/46N+6ZJJjkfYnYsMu0QJaJcq/hCB9DBUwvuelMYYqwYrBWgpJl
         2fCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742386124; x=1742990924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsK/Ju+fyU70N3qDFOX/p7Jl1CF8IdfwtoJGuoZeV9Y=;
        b=fQdYOQLhQfyx2N+o/XfCOTG0j6xCjdFeL81nhg74eFzEdX+hWhEYZRIqCvz1otnOV/
         j2n1GsHhP8tz7nSULQBZ4TV7G+o4QXW02THrw1a9xAqkGqyLrM+S2LpXn4nUBKOEMi5P
         xsrZyC8q0Ma4OkQNc97FUZPykvRaCRBEvRJTuCGqM6lP2E/YgTOG+yTJq6knNVAbD1WP
         wHl+LpcoCghh1qN+r8uHPGXdUMnz0fRmXyieO8prXBuq4mkGkikRpPV/s/Rv+zYFxuvN
         UrIlGztn2bKZf20TXf/cE7ZmnXsZMf5ApXZZ1V2zgGNg2bR7s6wdecLBKiLs1MwoPPy6
         IBZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+hLkGmpOTxT0WSyWRRNZrV0PaYUpp0BTRn5RB+cU6djtsFS2A15lOqBA/u9G3n187X9aiEzod5whiHKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTFrkR14cS5YaFJ9CxVa2NT0rOzvzJQlFInzojUxGMwKfoDqp/
	W79WAXaOrGYg2suYKGfiu+JzKqccXsoTc47rJ+BbnXKcwSzOYDtfd4IuAZCQK0iz8x3gdBQ9pv2
	uKBZYqCkwFrsrMw==
X-Google-Smtp-Source: AGHT+IHd1aW4u/kzG/dypqQfgnodStD5Twuyynf5bbudirbCcFVKmaxlhD5DRkvuqFc/qi4LsGdKy4E0fjxPxp4=
X-Received: from wmqd12.prod.google.com ([2002:a05:600c:34cc:b0:43b:d6ca:6dd3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8187:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-43d43793a12mr23610325e9.11.1742386124780;
 Wed, 19 Mar 2025 05:08:44 -0700 (PDT)
Date: Wed, 19 Mar 2025 12:08:42 +0000
In-Reply-To: <123de698-190f-460c-af8c-e51bcd948c0f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
 <20250311-iov-iter-v1-1-f6c9134ea824@google.com> <123de698-190f-460c-af8c-e51bcd948c0f@gmail.com>
Message-ID: <Z9qzytBl2GLztjwC@google.com>
Subject: Re: [PATCH 1/5] rust: iov: add iov_iter abstractions for ITER_SOURCE
From: Alice Ryhl <aliceryhl@google.com>
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Mar 18, 2025 at 09:10:47PM +0100, Christian Schrefl wrote:
> Hi Alice
> 
> On 11.03.25 3:25 PM, Alice Ryhl wrote:
> > This adds abstractions for the iov_iter type in the case where
> > data_source is ITER_SOURCE. This will make Rust implementations of
> > fops->write_iter possible.
> > 
> > This series only has support for using existing IO vectors created by C
> > code. Additional abstractions will be needed to support the creation of
> > IO vectors in Rust code.
> > 
> > These abstractions make the assumption that `struct iov_iter` does not
> > have internal self-references, which implies that it is valid to move it
> > between different local variables, and that you can make a copy of it to
> > get two IO vectors into the same buffers.
> 
> Would it make sense to add comments in the C side `struct iov_iter` for
> these assumptions?

Good idea.

> > +    /// Returns the number of bytes available in this IO vector.
> > +    ///
> > +    /// Note that this may overestimate the number of bytes. For example, reading from userspace
> > +    /// memory could fail with EFAULT, which will be treated as the end of the IO vector.
> > +    #[inline]
> > +    pub fn len(&self) -> usize {
> > +        // SAFETY: It is safe to access the `count` field.
> > +        unsafe {
> > +            (*self.iov.get())
> > +                .__bindgen_anon_1
> > +                .__bindgen_anon_1
> > +                .as_ref()
> > +                .count
> > +        }
> > +    }
> 
> Maybe add a C helper to avoid having to use '__bindgen_anon_1'?

I guess I could do that. Though it introduces a mandatory function call
that can't be inlined to get the length.

Alice

