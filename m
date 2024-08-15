Return-Path: <linux-kernel+bounces-288072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760049532F7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF0FEB25BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F831B3F39;
	Thu, 15 Aug 2024 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rodQTSjR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9061AE035;
	Thu, 15 Aug 2024 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730968; cv=none; b=p8dzo/KCDKaPzoPuXRCVbBNszA6sK/FPRGO314I6DkLro2mCXdvsm21D3lW3GScdsAMeEDNQ7MIUPxGE/1DCjOvIBrMBkwB/IZSpzAorN5q1T7tZKTyDeiKGd6oNWGns9DWT/DEB98kDSvpsFlAhG/F7iLwlQBjsxGyFqcCHeuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730968; c=relaxed/simple;
	bh=2WMl6EaRKHyEK2/ZQZdr02Mc4qbGm1r0DYQ2zC7R8LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BojKYfXtYsXNeTUWkf2aXihEzuVbWCcZ5yJFVHZZ8lq7jmow8DcmRFR0r1Cxwt7L9b5RwvC2HmvC+SNAOlZHeYwTIMO19O1yDtAPRJ7oXq0oUQiLc/8GCtjsaQl6E3WUYsen2nEzVcOYm4ibzOU3VZ8h3N9lpt3tISSCoksjJ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rodQTSjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DE7C4AF0D;
	Thu, 15 Aug 2024 14:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730968;
	bh=2WMl6EaRKHyEK2/ZQZdr02Mc4qbGm1r0DYQ2zC7R8LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rodQTSjRyZaZMi9wvpDn6L5vd2PItWpn+1+Hze3ZI6tx7NDN1XGsNH/seMN8chlZe
	 9fnuYBBvRX+7FPpJwcgzS61CVgHj7TpWsViVSxyWAJfwZv5gTJ1V5BHbnpYInVZ2cF
	 KyOnhrzJApsM5HutwlWg0lYgo+oeuiXznnrPE5JKDqA/IqHGZ5C9r8/zsVBoM8j5vZ
	 MDNtDGgNoV7mA+SHZni/cBBbXo9uJ8w/DzB5Bd50+Js6boJ/M4nOpliwp2rI4EgkBO
	 DrJhnZ34rnCUrCpq547G11cZIXcB/P7ujFG4j9I+pWp1uUxIWIdGm58EIE52f+JgoF
	 S1lapkYIrjUOg==
Date: Thu, 15 Aug 2024 16:09:20 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 00/26] Generic `Allocator` support for Rust
Message-ID: <Zr4MEPlbYGrx6BbO@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org>
 <Zr0GP0OXliPRqx4C@boqun-archlinux>
 <Zr1teqjuOHeeFO4Z@cassiopeiae>
 <CAH5fLgjvuE5uU00u4y+HyHTkQU_OBYvHe6NS5ohAhrLntTX1zQ@mail.gmail.com>
 <Zr31jqnA2b3qHK5l@cassiopeiae>
 <CAH5fLgjzNpeVVurPqVS=tMkKQOhXz08EsXRO4s9wYsNBuT6eVw@mail.gmail.com>
 <Zr4DpPSjDqSoMh0j@cassiopeiae>
 <e0b0bffb-c240-4d23-bf4d-0c1c19608f60@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0b0bffb-c240-4d23-bf4d-0c1c19608f60@proton.me>

On Thu, Aug 15, 2024 at 01:39:05PM +0000, Benno Lossin wrote:
> On 15.08.24 15:33, Danilo Krummrich wrote:
> > On Thu, Aug 15, 2024 at 02:34:50PM +0200, Alice Ryhl wrote:
> >> On Thu, Aug 15, 2024 at 2:33 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >>>
> >>> On Thu, Aug 15, 2024 at 11:20:32AM +0200, Alice Ryhl wrote:
> >>>> On Thu, Aug 15, 2024 at 4:52 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >>>>>
> >>>>> On Wed, Aug 14, 2024 at 12:32:15PM -0700, Boqun Feng wrote:
> >>>>>> Hi Danilo,
> >>>>>>
> >>>>>> I'm trying to put your series on rust-dev, but I hit a few conflicts due
> >>>>>> to the conflict with `Box::drop_contents`, which has been in rust-dev
> >>>>>> for a while. And the conflict is not that trivial for me to resolve.
> >>>>>> So just a head-up, that's a requirement for me to put it on rust-dev for
> >>>>>> more tests from my end ;-)
> >>>>>
> >>>>> I rebased everything and you can fetch them from [1].
> >>>>>
> >>>>> I resolved the following conflicts:
> >>>>>
> >>>>>   - for `Box`, implement
> >>>>>     - `drop_contents`
> >>>>>     - `manually_drop_contents` [2]
> >>>>
> >>>> Not sure I like this name. It sounds like something that runs the
> >>>> destructor, but it does the exact opposite.
> >>>
> >>> I thought it kinda makes sense, since it's analogous to `ManuallyDrop::new`.
> >>>
> >>> What about `Box::forget_contents` instead?
> >>
> >> One option is `into_manually_drop`. This uses the convention of using
> >> the `into_*` prefix for conversions that take ownership of the
> >> original value.
> > 
> > The signature of the current `Box::manually_drop_contents` is the same as for
> > `Box::drop_contents`, namely
> > `fn manually_drop_contents(this: Self) -> Box<MaybeUninit<T>, A>`.
> > 
> > `into_manually_drop` seems misleading for for returning a
> > `Box<MaybeUninit<T>, A>`.
> > 
> > I still think `forget_contents` hits it quite well. Just as `drop_contents`
> > drops the value, `forget_contents` makes the `Box` forget the value.
> 
> I think `forget_contents` sounds good. Can you please add some more docs
> to that function though? Like an example and change "Manually drops the
> contents, but keeps the allocation" to "Forgets the contents (does not
> run the destructor), but keeps the allocation.".

I can't really think of a good real world example other than moving out of a
`Box`, can you? Otherwise, maybe it just shouldn't be public?

> 
> Another thing that I spotted while looking at the patch, `move_out`
> doesn't need the `transmute_copy`, you should be able to just call
> `read` on the pointer.

While technically it's the same I thought `transmute_copy` is considered better,
since it has less stict safety requirements?

For `transmute_copy` we only need to say, that dst has the same type as src,
whereas for `read` the pointer must be valid for reads, properly aligned and
point to an initialized value.

> 
> ---
> Cheers,
> Benno
> 

