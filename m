Return-Path: <linux-kernel+bounces-325199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35A4975606
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235D81C26768
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37831AAE0C;
	Wed, 11 Sep 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU/sVYc2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED91E50B;
	Wed, 11 Sep 2024 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066219; cv=none; b=YvW4DFEBPH++T3Gqfo+Ic4OWMnbS4oaj4oEC3qeBRlc/n0+xTZLXgjcb0DaDh6lbHFrmMfs2+SFlOUbY8WFFrwdTHDSQoevhB7vFQeDuEMoRDoLZhsEPesz0ZNNwEM1yR4YUVT2SlYV0bvG5srf8O7wuf0bpbJcY9FsJgDeXq+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066219; c=relaxed/simple;
	bh=5NUgVGZKhPsPWqKpyoN/ipsM7yaoeIQ2D1gjHv5lqK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1KYYaE8ynHvzGOZYX/jvezsoE3YvUwFVzHJIJcMPgQzFNIpne41Mvp35Nnrw5eWdMGbH2hKfRm/wwl0JBY4ogHBqGxWspIA4sQlX76hbSvRDKAAvDJqeAoypJRsKD4ujSSwTLEbnND8RqeY7i9VsExs9IHmhIS0lVmp3hRYsDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU/sVYc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0742C4CEC5;
	Wed, 11 Sep 2024 14:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726066218;
	bh=5NUgVGZKhPsPWqKpyoN/ipsM7yaoeIQ2D1gjHv5lqK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bU/sVYc2192PKf7Us9pOQty5kCoCfdUqYEKsDiTbLmYUKjTJ2rD/tYa3G0wzGs/VV
	 aYY8jR+6BYZzAHFbvkt2qSuTdEOWpaTYlj3NwlCyfPHbDQyFCtAOZAoos5TYyMZyzB
	 5jw4lZ6Ec5liT19SJkV5nuxoOclkhanzA/Fd8vqbyfLpy8gkFu0sLyQm7g0nlCQ3mj
	 asxDJHXOKzUQI5p6iiq92sl0XNIi5X9f/8YSgfydEjNnCbTvHG/X+soTPUv7VE04c5
	 j3mQ6likvODvO3CTpnmo5xsZWsXIBTvdirO/BzPPW5Fs0pYXukOkdXcevKLa3yYvdr
	 8kCnjFMpAF47A==
Date: Wed, 11 Sep 2024 16:50:11 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <benno.lossin@proton.me>, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 09/26] rust: alloc: implement kernel `Box`
Message-ID: <ZuGuI7Ow0jJQBim6@cassiopeiae>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-10-dakr@kernel.org>
 <0146cb78-5a35-4d6b-bc75-fed1fc0c270c@proton.me>
 <ZuCEneJeXcRo5qs8@pollux>
 <19d81a27-9600-4990-867c-624104e3ad83@proton.me>
 <ZuDVekRzfeBkWmKz@pollux>
 <77b91448-a21e-4e1b-9a8e-3d2052d79a78@proton.me>
 <ZuF444VO8gK8l7UR@pollux>
 <b80cb238-5fcc-4bbb-8b03-42e173c28653@proton.me>
 <CAH5fLghwj-rD8zoPFgp3g1JYm8WrOhuiWnm7w=zStqOfRRZUJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghwj-rD8zoPFgp3g1JYm8WrOhuiWnm7w=zStqOfRRZUJw@mail.gmail.com>

On Wed, Sep 11, 2024 at 03:27:57PM +0200, Alice Ryhl wrote:
> On Wed, Sep 11, 2024 at 3:26 PM Benno Lossin <benno.lossin@proton.me> wrote:
> >
> > On 11.09.24 13:02, Danilo Krummrich wrote:
> > > On Wed, Sep 11, 2024 at 08:36:38AM +0000, Benno Lossin wrote:
> > >> On 11.09.24 01:25, Danilo Krummrich wrote:
> > >>> On Tue, Sep 10, 2024 at 07:49:42PM +0000, Benno Lossin wrote:
> > >>>> On 10.09.24 19:40, Danilo Krummrich wrote:
> > >>>>> On Sat, Aug 31, 2024 at 05:39:07AM +0000, Benno Lossin wrote:
> > >>>>>> On 16.08.24 02:10, Danilo Krummrich wrote:
> > >>>>>>> +///
> > >>>>>>> +/// ```
> > >>>>>>> +/// # use kernel::bindings;
> > >>>>>>> +/// const SIZE: usize = bindings::KMALLOC_MAX_SIZE as usize + 1;
> > >>>>>>> +/// struct Huge([u8; SIZE]);
> > >>>>>>> +///
> > >>>>>>> +/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
> > >>>>>>> +/// ```
> > >>>>>>
> > >>>>>> Similarly, you could then say above this one "Instead use either `VBox`
> > >>>>>> or `KVBox`:"
> > >>>>>>
> > >>>>>>> +///
> > >>>>>>> +/// # Invariants
> > >>>>>>> +///
> > >>>>>>> +/// The [`Box`]' pointer is always properly aligned and either points to memory allocated with `A`
> > >>>>>>
> > >>>>>> Please use `self.0` instead of "[`Box`]'".
> > >>>>>>
> > >>>>>>> +/// or, for zero-sized types, is a dangling pointer.
> > >>>>>>
> > >>>>>> Probably "dangling, well aligned pointer.".
> > >>>>>
> > >>>>> Does this add any value? For ZSTs everything is "well aligned", isn't it?
> > >>>>
> > >>>> ZSTs can have alignment and then unaligned pointers do exist for them
> > >>>> (and dereferencing them is UB!):
> > >>>
> > >>> Where is this documented? The documentation says:
> > >>>
> > >>> "For operations of size zero, *every* pointer is valid, including the null
> > >>> pointer. The following points are only concerned with non-zero-sized accesses."
> > >>> [1]
> > >>
> > >> That's a good point, the documentation looks a bit outdated. I found
> > >> this page in the nomicon: https://doc.rust-lang.org/nomicon/vec/vec-zsts.html
> > >> The first iterator implementation has an alignment issue. (Nevertheless,
> > >> that chapter of the nomicon is probably useful to you, since it goes
> > >> over implementing `Vec`, but maybe you already saw it)
> > >>
> > >>> [1] https://doc.rust-lang.org/std/ptr/index.html
> > >>
> > >> Might be a good idea to improve/complain about this at the rust project.
> > >
> > > Well, my point is how do we know? There's no language specification and the
> > > documentation is (at least) ambiguous.
> >
> > So I went through the unsafe-coding-guidelines issues list and only
> > found this one: https://github.com/rust-lang/unsafe-code-guidelines/issues/93
> > Maybe I missed something. You could also try to ask at the rust zulip in
> > the t-opsem channel for further clarification.
> >
> > I think we should just be on the safe side and assume that ZSTs require
> > alignment. But if you get a convincing answer and if they say that they
> > will document it, then I don't mind removing the alignment requirement.

I agree -- I also wrote this in a previous mail.

I was just wondering why you are so sure about it, since the documentation
doesn't seem to be clear about it.

> 
> Please see the section on alignment in the same page. Just because a
> pointer is valid does not mean that it is properly aligned.
> 
> From the page:
> 
> Valid raw pointers as defined above are not necessarily properly
> aligned (where “proper” alignment is defined by the pointee type,
> i.e., *const T must be aligned to mem::align_of::<T>()). However, most
> functions require their arguments to be properly aligned, and will
> explicitly state this requirement in their documentation. Notable
> exceptions to this are read_unaligned and write_unaligned.
> 
> When a function requires proper alignment, it does so even if the
> access has size 0, i.e., even if memory is not actually touched.
> Consider using NonNull::dangling in such cases.

Good point.

It still sounds like it's only required for functions that explicitly state so.

And as cited from nomicon "This is possibly needless pedantry because ptr::read
is a noop for a ZST, [...]". But, no question, of course we have to honor it
anyways.

> 
> Alice
> 

