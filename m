Return-Path: <linux-kernel+bounces-288002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D00952F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE971C247A4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914411A01C3;
	Thu, 15 Aug 2024 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngYAa+J4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B11A00FE;
	Thu, 15 Aug 2024 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728812; cv=none; b=vD4Clwa3qhgXcPf+8Qv3hVdI0neArtO4UZ5xnUnYXU+KREZwZVR7o+HFx+WIV5LOclyfWOqdfRxaIlt5XPp69b1TYAJ3pbWzENX6msq5LBKQxWwKcKgghE0dnC4o3Voufa6B/IJMUyuEDOdy6Yl3CLVvaIx8wm0NUNiHKH0kiBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728812; c=relaxed/simple;
	bh=PyWZsXcN1KLaK/0ybPQA0H3GW8k5zX8A1tAoYrLpzpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRKMUin3gRvNzIqFFAASPTXilYaVB8e6b9hxWsECtE6jF7wP3B2bJGSEoshT0W6X1bIYSfnrGO8tKqWAxDz0m1nqf8b5pxMtPKOuMGNLQW03MqlfGAlPL/DHJb7oNUcg7zFxY9f8Y5ldFFvlYW1ZfFNSf5cTrKqGXjcncdPkWVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngYAa+J4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65E4C32786;
	Thu, 15 Aug 2024 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723728811;
	bh=PyWZsXcN1KLaK/0ybPQA0H3GW8k5zX8A1tAoYrLpzpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ngYAa+J4Ou6sP2e00T0jBO21XSV4TJCGBdv5oJJqDxbg0+WiW9Waf8Pd9QTu0SvLX
	 73iVIVi59bIdBbu0KRHJXpq6h/qZBZMIFQTslKrx1evOMnd7LtWu6zyBEpWRchHBL3
	 853MrCVLMtUDryXkpE7QtPDczyLmiLYb98sbou9oHVkATDhSofH7rjb541/PpgfZsl
	 soRlMuPnq0KbZ7hqusJV3CU0i7/fNKrd6KHVllQkO/AS01Q8zQyA/hK1RQPkvbsWb/
	 SWAkU42i70iGbdxkVso5lVTJBGzG8do4sIBRTw0ErenTFaleOh7D0q1ukBFu+HIBpz
	 o+837E+kpnjqw==
Date: Thu, 15 Aug 2024 15:33:24 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, akpm@linux-foundation.org,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 00/26] Generic `Allocator` support for Rust
Message-ID: <Zr4DpPSjDqSoMh0j@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org>
 <Zr0GP0OXliPRqx4C@boqun-archlinux>
 <Zr1teqjuOHeeFO4Z@cassiopeiae>
 <CAH5fLgjvuE5uU00u4y+HyHTkQU_OBYvHe6NS5ohAhrLntTX1zQ@mail.gmail.com>
 <Zr31jqnA2b3qHK5l@cassiopeiae>
 <CAH5fLgjzNpeVVurPqVS=tMkKQOhXz08EsXRO4s9wYsNBuT6eVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjzNpeVVurPqVS=tMkKQOhXz08EsXRO4s9wYsNBuT6eVw@mail.gmail.com>

On Thu, Aug 15, 2024 at 02:34:50PM +0200, Alice Ryhl wrote:
> On Thu, Aug 15, 2024 at 2:33 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Thu, Aug 15, 2024 at 11:20:32AM +0200, Alice Ryhl wrote:
> > > On Thu, Aug 15, 2024 at 4:52 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > > >
> > > > On Wed, Aug 14, 2024 at 12:32:15PM -0700, Boqun Feng wrote:
> > > > > Hi Danilo,
> > > > >
> > > > > I'm trying to put your series on rust-dev, but I hit a few conflicts due
> > > > > to the conflict with `Box::drop_contents`, which has been in rust-dev
> > > > > for a while. And the conflict is not that trivial for me to resolve.
> > > > > So just a head-up, that's a requirement for me to put it on rust-dev for
> > > > > more tests from my end ;-)
> > > >
> > > > I rebased everything and you can fetch them from [1].
> > > >
> > > > I resolved the following conflicts:
> > > >
> > > >   - for `Box`, implement
> > > >     - `drop_contents`
> > > >     - `manually_drop_contents` [2]
> > >
> > > Not sure I like this name. It sounds like something that runs the
> > > destructor, but it does the exact opposite.
> >
> > I thought it kinda makes sense, since it's analogous to `ManuallyDrop::new`.
> >
> > What about `Box::forget_contents` instead?
> 
> One option is `into_manually_drop`. This uses the convention of using
> the `into_*` prefix for conversions that take ownership of the
> original value.

The signature of the current `Box::manually_drop_contents` is the same as for
`Box::drop_contents`, namely
`fn manually_drop_contents(this: Self) -> Box<MaybeUninit<T>, A>`.

`into_manually_drop` seems misleading for for returning a
`Box<MaybeUninit<T>, A>`.

I still think `forget_contents` hits it quite well. Just as `drop_contents`
drops the value, `forget_contents` makes the `Box` forget the value.

> 
> Alice
> 

