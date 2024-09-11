Return-Path: <linux-kernel+bounces-324745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFDB97505B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3524328CF26
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060E3184551;
	Wed, 11 Sep 2024 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8JOiQgd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51415383B;
	Wed, 11 Sep 2024 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726052587; cv=none; b=KRUNTIptoZs/cuJEfn07+lVjztAlKm8+Q53uunuruNjddpyuLRsGJtrYZBjMLUNokhQIETN0xK6yGE+cra8dMKe04qkV8RvsA20rzv/3wISjMOw96yWh5xCpGgZ6pdlOW8rW8pZG5W/AwPaBER7rkEO7gB1iOCbLeqcQY85/Eqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726052587; c=relaxed/simple;
	bh=30PyCaGPw86nPfq4/D2gDA2paLlWYzbM2d1hzDaciZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=la1tU4sVcdoKTEJfZVdHuN5ld7UFvjz9/csIit9idhJUHkad+DOytz7SJWHtp1S2ZtAn3uKcppg25aisAi7p4LMhUj7Kc+USVwmXWnC6eNiRMCR852f10CQCOVrZADsrHBvpuvBdrPbVPia9nuPi2AIDf2YqocQLIk4e5Pl1lGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8JOiQgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9DAC4CEC5;
	Wed, 11 Sep 2024 11:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726052586;
	bh=30PyCaGPw86nPfq4/D2gDA2paLlWYzbM2d1hzDaciZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H8JOiQgdNrhOJwCp2OCKdb3xqA+Z8hWOwHlps5zaVb2y2DDyVGpvhfVo/BCA7FFzt
	 aX1QcdwxSaMgBeC55TEo7fm00U7cxqxox4Npi+ispeSFMibD/9ECY5tAi5GzTW/q2V
	 Nxh4SioLfHXSYjaytl5r1RkyW+VqAYhaDkbWX/v4T1qu9OudYtsqPbabpqhshduAoq
	 mzOmWrARD73NhUnPkGVoaZk+XwnVR0fIT5/Q+2JA9saxnZ4oZZdrSi4bidV1sCZXjP
	 UFLqYOm9GvWWtDkOLDMrCa+T7aSicaJjOcDVzJwNeXxZA2Viei8Aaj3hQAQSvL2rtO
	 jnioDidiQ4RVw==
Date: Wed, 11 Sep 2024 13:02:59 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 09/26] rust: alloc: implement kernel `Box`
Message-ID: <ZuF444VO8gK8l7UR@pollux>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-10-dakr@kernel.org>
 <0146cb78-5a35-4d6b-bc75-fed1fc0c270c@proton.me>
 <ZuCEneJeXcRo5qs8@pollux>
 <19d81a27-9600-4990-867c-624104e3ad83@proton.me>
 <ZuDVekRzfeBkWmKz@pollux>
 <77b91448-a21e-4e1b-9a8e-3d2052d79a78@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77b91448-a21e-4e1b-9a8e-3d2052d79a78@proton.me>

On Wed, Sep 11, 2024 at 08:36:38AM +0000, Benno Lossin wrote:
> On 11.09.24 01:25, Danilo Krummrich wrote:
> > On Tue, Sep 10, 2024 at 07:49:42PM +0000, Benno Lossin wrote:
> >> On 10.09.24 19:40, Danilo Krummrich wrote:
> >>> On Sat, Aug 31, 2024 at 05:39:07AM +0000, Benno Lossin wrote:
> >>>> On 16.08.24 02:10, Danilo Krummrich wrote:
> >>>>> +/// # Examples
> >>>>> +///
> >>>>> +/// ```
> >>>>> +/// let b = KBox::<u64>::new(24_u64, GFP_KERNEL)?;
> >>>>> +///
> >>>>> +/// assert_eq!(*b, 24_u64);
> >>>>> +/// # Ok::<(), Error>(())
> >>>>> +/// ```
> >>>>> +///
> >>>>> +/// ```
> >>>>> +/// # use kernel::bindings;
> >>>>> +/// const SIZE: usize = bindings::KMALLOC_MAX_SIZE as usize + 1;
> >>>>> +/// struct Huge([u8; SIZE]);
> >>>>> +///
> >>>>> +/// assert!(KBox::<Huge>::new_uninit(GFP_KERNEL | __GFP_NOWARN).is_err());
> >>>>> +/// ```
> >>>>
> >>>> It would be nice if you could add something like "KBox can't handle big
> >>>> allocations:" above this example, so that people aren't confused why
> >>>> this example expects an error.
> >>>
> >>> I don't think that's needed, it's implied by
> >>> `SIZE == bindings::KMALLOC_MAX_SIZE + 1`.
> >>>
> >>> Surely, we could add it nevertheless, but it's not very precise to just say "big
> >>> allocations". And I think this isn't the place for lengthy explanations of
> >>> `Kmalloc` behavior.
> >>
> >> Fair point, nevertheless I find examples a bit more useful, when the
> >> intention behind them is not only given as code.
> >>
> >>>>> +///
> >>>>> +/// ```
> >>>>> +/// # use kernel::bindings;
> >>>>> +/// const SIZE: usize = bindings::KMALLOC_MAX_SIZE as usize + 1;
> >>>>> +/// struct Huge([u8; SIZE]);
> >>>>> +///
> >>>>> +/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
> >>>>> +/// ```
> >>>>
> >>>> Similarly, you could then say above this one "Instead use either `VBox`
> >>>> or `KVBox`:"
> >>>>
> >>>>> +///
> >>>>> +/// # Invariants
> >>>>> +///
> >>>>> +/// The [`Box`]' pointer is always properly aligned and either points to memory allocated with `A`
> >>>>
> >>>> Please use `self.0` instead of "[`Box`]'".
> >>>>
> >>>>> +/// or, for zero-sized types, is a dangling pointer.
> >>>>
> >>>> Probably "dangling, well aligned pointer.".
> >>>
> >>> Does this add any value? For ZSTs everything is "well aligned", isn't it?
> >>
> >> ZSTs can have alignment and then unaligned pointers do exist for them
> >> (and dereferencing them is UB!):
> > 
> > Where is this documented? The documentation says:
> > 
> > "For operations of size zero, *every* pointer is valid, including the null
> > pointer. The following points are only concerned with non-zero-sized accesses."
> > [1]
> 
> That's a good point, the documentation looks a bit outdated. I found
> this page in the nomicon: https://doc.rust-lang.org/nomicon/vec/vec-zsts.html
> The first iterator implementation has an alignment issue. (Nevertheless,
> that chapter of the nomicon is probably useful to you, since it goes
> over implementing `Vec`, but maybe you already saw it)
> 
> > [1] https://doc.rust-lang.org/std/ptr/index.html
> 
> Might be a good idea to improve/complain about this at the rust project.

Well, my point is how do we know? There's no language specification and the
documentation is (at least) ambiguous.

> 
> >>     #[repr(align(64))]
> >>     struct Token;
> >>
> >>     fn main() {
> >>         let t = 64 as *mut Token;
> >>         let t = unsafe { t.read() }; // this is fine.
> >>         let t = 4 as *mut Token;
> >>         let t = unsafe { t.read() }; // this is UB, see below for miri's output
> >>     }
> >>
> >> Miri complains:
> >>
> >>     error: Undefined Behavior: accessing memory based on pointer with alignment 4, but alignment 64 is required
> >>      --> src/main.rs:8:22
> >>       |
> >>     8 |     let t = unsafe { t.read() }; // this is UB, see below for miri's output
> >>       |                      ^^^^^^^^ accessing memory based on pointer with alignment 4, but alignment 64 is required
> >>       |
> >>       = help: this indicates a bug in the program: it performed an invalid operation, and caused Undefined Behavior
> >>       = help: see https://doc.rust-lang.org/nightly/reference/behavior-considered-undefined.html for further information
> >>       = note: BACKTRACE:
> >>       = note: inside `main` at src/main.rs:8:22: 8:30
> > 
> > `read` explicitly asks for non-null and properly aligned even if `T` has size
> > zero.

I mentioned this because for `read` it's explicitly documented.

However, the nomicon also says "This is possibly needless pedantry because
ptr::read is a noop for a ZST, [...]".

> 
> Dereferencing (ie `*t`) also requires that (I just didn't do it, since
> then the `Token` must implement `Copy`).

Again, how do you know? The documentation isn't clear about it.

> 
> ---
> Cheers,
> Benno
> 

