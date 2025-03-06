Return-Path: <linux-kernel+bounces-548100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A041AA53FF0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB7D16A163
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55151624C4;
	Thu,  6 Mar 2025 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIxAk0i+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F8224FA;
	Thu,  6 Mar 2025 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741224572; cv=none; b=iovJj384dxw+PY3qDu+86bIWVsSLYwe5ggTkJrLyIZ5/3KDvDI75GTQ9iNKe+hQlGXRsmT2WTnrejUU5o9AYzIfGHVWvkd/diDttcstexRyASVPR3fCmhCnpyNLK6BO2x7YTaIVW4y7AZFiFWp+fxhz3lHTs0z1ga2lud7ODg6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741224572; c=relaxed/simple;
	bh=dJlANX6sAseVQ82aST6VrHKfnrfmDH28jV7K8jzluCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKj7IVkh4qiM+wH65P/NFu+FNnVVraJQxg8NCiX62QAgVqiWp2QqYXDdZRkXZf1PDnbxQ+Yt/ZJ2x6wWlfNtr6RxvXBVr9vLEYYjrhENBAUqOQ9LxyVXARk/8SL4ygf2YdDEB6O0GdD0d7ON1SA6Rvtv238WCRlUehfWIjD8O6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIxAk0i+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8424C4CED1;
	Thu,  6 Mar 2025 01:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741224571;
	bh=dJlANX6sAseVQ82aST6VrHKfnrfmDH28jV7K8jzluCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIxAk0i+iwHHX3sEoNk1IxumZkXWViAVZV2acku/awxDPy+gl+YzahGURwoMXw83x
	 Ck0e/vC1BzSQ5eRjXZeqBpGCxE7i5g0bCJd7eCSf6xA4+4+6LeTN158H/PDqEajra1
	 DST1xE5667opKpTpyTswj7Ea84pVmftGXag1xkyDi6RM2Sv/sXOopQlGcN6NSjLXZG
	 E3jj265/l/EupkA+TpM4ryz4YqSss3RGlA14zmHwwwbGqFtH18hVspBVqQwWY+LRic
	 tWEi8fioKcNSWsfGipR0NIkS4Lp3I7qHd0hlxJNWiigOggZVZX5jZzdW2grupehWMn
	 2HYcIRbjQbOFw==
Date: Thu, 6 Mar 2025 02:29:22 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com,
	pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, gregkh@linuxfoundation.org,
	mcgrof@kernel.org, russ.weight@linux.dev,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 2/5] rust: firmware: introduce
 `firmware::ModInfoBuilder`
Message-ID: <Z8j6ckpD6JVY4m-p@pollux>
References: <20250304173555.2496-1-dakr@kernel.org>
 <20250304173555.2496-3-dakr@kernel.org>
 <D88OSC9XJXZL.C5HXWFYCG9U6@proton.me>
 <Z8jSV5CpZDcXrviY@pollux>
 <D88Q7503C8FF.2TMMBSEMOGKU1@proton.me>
 <Z8jk3qs6nCIJz-39@pollux>
 <D88R7HI1Z6GG.ZOQ9A1VQOR28@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D88R7HI1Z6GG.ZOQ9A1VQOR28@proton.me>

On Thu, Mar 06, 2025 at 12:24:21AM +0000, Benno Lossin wrote:
> On Thu Mar 6, 2025 at 12:57 AM CET, Danilo Krummrich wrote:
> > On Wed, Mar 05, 2025 at 11:36:54PM +0000, Benno Lossin wrote:
> >> On Wed Mar 5, 2025 at 11:38 PM CET, Danilo Krummrich wrote:
> >> > On Wed, Mar 05, 2025 at 10:30:31PM +0000, Benno Lossin wrote:
> >> >> On Tue Mar 4, 2025 at 6:34 PM CET, Danilo Krummrich wrote:
> >> >> > +    /// Push an additional path component.
> >> >> > +    ///
> >> >> > +    /// After a new [`ModInfoBuilder`] instance has been created, [`ModInfoBuilder::prepare`] must
> >> >> > +    /// be called before adding path components.
> >> >> > +    pub const fn push(self, s: &str) -> Self {
> >> >> > +        if N != 0 && self.n == 0 {
> >> >> > +            crate::build_error!("Must call prepare() before push().");
> >> >>
> >> >> This will only prevent the first `prepare` call being missed, right?
> >> >
> >> > Correct, unfortunately there's no way to detect subsequent ones.
> >>
> >> Does it make sense to do that one in the constructor?
> >>
> >> (After looking at the example below) Ah maybe you can't do that, since
> >> then you would have two `prepare()` calls for the example below...?
> >
> > Exactly.
> >
> >> >> If you always have to call this before `push`, why not inline it there?
> >> >
> >> > You can push() multiple times to compose the firmware path string (which is the
> >> > whole purpose :).
> >>
> >> Ah I see, I only looked at the example you have in the next patch. All
> >> in all, I think this patch could use some better documentation, since I
> >> had to read a lot of the code to understand what everything is supposed
> >> to do...
> >
> > I can expand the example in module_firmware! to make things a bit more obvious.
> >
> > Otherwise, what information do you think is missing?
> 
> Abstractly: what `ModInfoBuilder` *does*, concretely:
> - why the generic constant `N` exists,

It doesn't really matter to the user, since the user never needs to supply it.
That happens in the module_firmware! macro.

I agree it not good to not mention anything about it at all, but I wouldn't want
to bother the user with all implemention details.

We can probably just mention that it's used internally and is supplied by
module_firmware!. (That module_firmware! does that by doing a dry run of the
builder itself, isn't necessary to know for the user I think.)

> - what `prepare()` does,

Same here, it's an implementation detail not relevant to the user. All the user
needs to know is that prepare() acts as a separator to be able to supply the
next firmware path.

> - what happens with the `module_name` parameter of `new`

Should probably just mention it's supplied by module_firmware! and used
internally.

> - answer the question "I want that the builder outputs the string `???`
>   can it do that? If yes, how do I do it?"

All it does is concatenating multiple &str in const context, which I thought is
clear since there are only push() and prepare() as public methods.

May it be that your request is more about can we add more hints on the
implementation details rather than user focused documentation?

