Return-Path: <linux-kernel+bounces-563178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52310A637EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 00:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68FAA188EA5F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58CD19CD19;
	Sun, 16 Mar 2025 23:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHaQqWCX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A59F13C9A3;
	Sun, 16 Mar 2025 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742166179; cv=none; b=dWTGyj3pIvA/ONt6EUHl0bNCOisHTtveRvS1prlcvq/10j3eng4Pr1CXuIU3+nc0q1TLSJh7yCXTg/8zOwpu4BOVqJcwdvNUCYWYFKoAAihf8oB595MvAlkmCrST3Nu1yASsgUh4VrGh/wV1abpt6bkfLAXDyXgBmFyyi4s053o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742166179; c=relaxed/simple;
	bh=bAfV31tUMDhZXJLS608anPqJUMpahm9TNEde1X7abtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiFR9LGW8YZJme1kNyJL5C/aD+eOBJzkG/V5VBU2aFIsncCY3eOW8VcMPByFhPtMScrgLFZHMkO2fdxVbZEuXqbbdk3MCA1munC7XYDfRkRRI4nL715Fi3diT+pts+fecrHjt8gaLh9RwLzzsUDhbc/v3vKXzuEE9kbiwdSW31A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHaQqWCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15543C4CEDD;
	Sun, 16 Mar 2025 23:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742166178;
	bh=bAfV31tUMDhZXJLS608anPqJUMpahm9TNEde1X7abtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PHaQqWCX/QYHydapgrgsPxEyp8p1z3d8YQvWxZrHSwod6++N3UVu/3XW4Oh2Gq2b6
	 RQa72cIhWStHMDRlaTmDRAStnOnYGcwaKAX07zBstU4sMQvGYqdWqrzbtmHaurImBH
	 a2UFpYxbS0TEu4kPz8qWL+0tcBgxrZkUGhn5x1b6+P6ajE98zdkTPXiDlQR3rvDO9b
	 o5iC9NacPNg57CsDY9G32UuZVVq9lCnnZzzI0FlBZQyhPkZ7AgEapF0pqKTQv1Klg1
	 eebw0WIPUVhXyLiI3Q4ELwROZAHHODDBY1kMdUkGhU8sJX+rkl+IGJybuHuj+LnOuM
	 wILN3J7TVxwsA==
Date: Mon, 17 Mar 2025 00:02:53 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andrew Ballance <andrewjballance@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
Message-ID: <Z9dYnSC13ruc-VC5@pollux>
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com>
 <Z9dTspva0aJRWG3Y@pollux>
 <CAJ-ks9mwuLaULKW0cwD73yb3yH-p9KS3ZFoJJ3OxhvUOpXo3KA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9mwuLaULKW0cwD73yb3yH-p9KS3ZFoJJ3OxhvUOpXo3KA@mail.gmail.com>

On Sun, Mar 16, 2025 at 06:47:42PM -0400, Tamir Duberstein wrote:
> On Sun, Mar 16, 2025 at 6:42 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Sun, Mar 16, 2025 at 06:32:01PM -0400, Tamir Duberstein wrote:
> > > Add `Vec::dec_len` that reduces the length of the receiver. This method
> > > is intended to be used from methods that remove elements from `Vec` such
> > > as `truncate`, `pop`, `remove`, and others. This method is intentionally
> > > not `pub`.
> > >
> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > ---
> > >  rust/kernel/alloc/kvec.rs | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > > index d43a1d609434..5d604e04b9a5 100644
> > > --- a/rust/kernel/alloc/kvec.rs
> > > +++ b/rust/kernel/alloc/kvec.rs
> > > @@ -195,6 +195,21 @@ pub unsafe fn inc_len(&mut self, additional: usize) {
> > >          self.len += additional;
> > >      }
> > >
> > > +    /// Decreases `self.len` by `count`.
> > > +    ///
> > > +    /// Returns a mutable reference to the removed elements.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// - `count` must be less than or equal to `self.len`.
> >
> > Why? We can catch this, no?
> >
> > We can keep the debug_assert!(), but use self.len.saturating_sub(count) instead.
> 
> This is why I didn't want to write this until we had an actual caller :)

That just defers this question, the methods you mention in your commit message
will be added, hence I think it's better to do it right away.

> We can, but it's not clear why that's better. What does it mean if the
> caller asked to decrement by more than self.len?

It tells us that the caller is buggy, but that's what the debug_assert!() is
for.

But to me both is fine, it's also good when the caller has to justify.

Forgot to mention, for dec_len(), please add the corresponding invariant comment
when adjusting self.len.

