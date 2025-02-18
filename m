Return-Path: <linux-kernel+bounces-519422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1315DA39CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444F017236D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE20265CDB;
	Tue, 18 Feb 2025 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxXDodDl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB022FF31;
	Tue, 18 Feb 2025 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883647; cv=none; b=kP58NUTK7iuWt6yJ6xA9mTRC1Y2kUROeg8OyRr9DJlh+xSvr5Eyd/P2UIl05RzLwuko0l5QvVHhOPFhTuYCbMF7+8jCd+EiAiUd5B4KTVMxn+KxntJHyU9Sv0PM/OmCrK4ARTZCoYDOGfo7/B9tKv4RuHEfvizvGFcc2kTHhFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883647; c=relaxed/simple;
	bh=GDpD05YzyjayjIzK9MSpI8Tss4m7PkJ8S7ngYrvM31A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFt9PXYytb38TvTqd1qTKMCwN63mf4xfBbuL0zR7BSDvNGi2bB46p0LccMUd2rkMf3c2PHdon/hzHpVW1ZAw2GnYcPMvrYl0I5VxGGHfEChlW9ckaFoOgMn4f9oqQudh0Haqk7DxJOtzu6mCkE+PTiennH6jWTLiw6VWjWIRP/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxXDodDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A434FC4CEE2;
	Tue, 18 Feb 2025 13:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739883647;
	bh=GDpD05YzyjayjIzK9MSpI8Tss4m7PkJ8S7ngYrvM31A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxXDodDlyPmuHgrYMb3Uk1sFK7RuSZjH8XN5j40YuN5BKiwHtcon2CjI3PsQn9uOW
	 N2rRq7rMjOWpDwiiNbebK2C17L0CaDPNj4oloISoU6ZhV7Vu3RzFG0s2nSgBKQEs/B
	 5slXGke5UKr209UWjw/TAAESd/9RINiOiHxI2v2XY9BuIQqheaKxYGvkNBLcXVJ1tC
	 gnNZr6Pmh4WpXGeN6jAYaGiN6LSiEzGkQeFolQBsVDrMFZr3fK0cfhiWPixil5q3fn
	 wNnALSeR5c0B4a3wtyU1g6GsMmqoUo9sfgIGZ693+moC2gCDKcHPnL8dWZd9ybaubY
	 N2J/HxoQHZDkw==
Date: Tue, 18 Feb 2025 14:00:40 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Fiona Behrens <me@kloenk.dev>,
	Charalampos Mitrodimas <charmitro@posteo.net>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rust: configfs: introduce rust support for
 configfs
Message-ID: <Z7SEeBFJT7fRtvVN@pollux>
References: <20250207-configfs-v2-0-f7a60b24d38e@kernel.org>
 <20250207-configfs-v2-2-f7a60b24d38e@kernel.org>
 <S6DKlLVx4KKevl_q2zrW69Z7oS0jwyX4DXpDZrFiIy1lKo4VYHM52aDiV82c2yf52Ecr7t9FayuqBUPR9onvZA==@protonmail.internalid>
 <dd63fcde-ba4c-4a6e-9bde-1af5af37e91b@proton.me>
 <87h64su8ux.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h64su8ux.fsf@kernel.org>

On Mon, Feb 17, 2025 at 12:08:22PM +0100, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
> 
> > On 07.02.25 15:41, Andreas Hindborg wrote:
> >> +//!
> >> +//! C header: [`include/linux/configfs.h`](srctree/include/linux/configfs.h)
> >> +//!
> >> +//! [C documentation]: srctree/Documentation/filesystems/configfs.rst
> >> +//! [rust_configfs.rs]: srctree/samples/rust/rust_configfs.rs
> >> +
> >> +use crate::alloc::flags;
> >> +use crate::container_of;
> >> +use crate::page::PAGE_SIZE;
> >> +use crate::prelude::*;
> >> +use crate::str::CString;
> >> +use crate::sync::Arc;
> >> +use crate::types::ForeignOwnable;
> >> +use crate::types::Opaque;
> >> +use core::cell::UnsafeCell;
> >> +use core::marker::PhantomData;
> >> +use core::ptr::addr_of;
> >> +use core::ptr::addr_of_mut;
> >
> > I usually would import this like so:
> >
> >     use crate::{
> >         alloc::flags,
> >         container_of,
> >         page::PAGE_SIZE,
> >         prelude::*,
> >         str::CString,
> >         sync::Arc,
> >         types::{ForeignOwnable, Opaque},
> >     };
> >     use core::{
> >         cell::UnsafeCell,
> >         marker::PhantomData,
> >         ptr::{addr_of, addr_of_mut},
> >     };
> >
> > To me this is more readable.
> 
> I disagree with that. I don't think what you suggest is easier to read,
> and it is much more difficult to work with when rebasing and merging
> things.

I have to agree that it is more difficult to work with. So far I used the style
as proposed by Benno, but it creates unncessary big and difficult to review
diffs when rustfmt moves things from a horizontal list to a vertical one and
vice versa.

> >> +    /// Implementations can use this method to do house keeping before
> >> +    /// `configfs` drops its reference to `Child`.
> >> +    fn drop_item(
> >
> > `drop` doesn't really fit here, I think something like `unlink_item`
> > fits better, since the child isn't actually dropped after this function
> > returns.
> 
> Yea, I know. But the function is called `drop_item` on the C side of
> things. Usually we keep the C names.

I agree C names should be kept as possible.

To me it seems obvious from the context, but maybe it'd still makes sense to add
a brief note that this callback's name is not related to 'drop' in the sense of
Rust?

