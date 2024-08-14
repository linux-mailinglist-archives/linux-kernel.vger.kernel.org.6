Return-Path: <linux-kernel+bounces-286813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E051951F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4494B2902E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DE11B86C8;
	Wed, 14 Aug 2024 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFgHSrKK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3810C2943F;
	Wed, 14 Aug 2024 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651303; cv=none; b=SOWn2CrW7cCJoDb+JxVpQUZkItSkGjrTSkWHSz5zDhQlHeQ3XYr4boSoKcLCO7XS+zZ+ktPZq4negXwme9p5y1De9NKpU2eACdmoBKYkW+Fn7gUxZxJz+4DAoK8qQawT+rLFHPo+r7671LTHOQnOXdLk9Qm6Da3WwxxPbXEQJPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651303; c=relaxed/simple;
	bh=sqI86+s257b6BM/In45crAL7usB4OpYm9FJqWdk3u/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqhNfu/aHow6ymHZyTruVB70VzKbO+Ig36RrW/T0pWqwgoJUejbY5FhgAfDmomzfFa/+VMBmCcZxtqdve78N/4WKxPsPgqJyK3gFBwPpQNY5bj8Rqxx4DJOxx+ciIU9yBy5LXd+MLRGdhjb/WGYfxYerF26a418R1dP8vH1jAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFgHSrKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51D9C116B1;
	Wed, 14 Aug 2024 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723651302;
	bh=sqI86+s257b6BM/In45crAL7usB4OpYm9FJqWdk3u/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFgHSrKKeN9MNzjtW4J1Ij0pJ9I4ZGwp4xrhah5wK4palblivmfjBrApGa5tUoD6a
	 0Fru+/zYGPe/ASywMr0F8ALyP2x52lmbJbKiIA0i3HI4UwpInCPpQGPvHNzFFZC+Yg
	 xSAdM2Ygu6tZ0SgeT6VEkBBXqDAjPzVo/J4fqXa08OjH4z6V6qCcDMBBi+kjocG9R1
	 eOyqGJtTHuecsnAOxC75uBNj75GYQimItqfWwBiDZNcfAax+MRnAtwdyFA7ox9zK4R
	 zN8JYnAAgNHtupL8n7fG0OpegeN4IhH+MUBO0AB8wluEMU5Y/DrKHZ1rD8A1JPnFda
	 PTBoA4FQjxwRQ==
Date: Wed, 14 Aug 2024 18:01:34 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <ZrzU3pkwJN4_jkig@cassiopeiae>
References: <20240812182355.11641-5-dakr@kernel.org>
 <CAH5fLgit0hSFWi_Bv4DFK6vvhoLfSz=BMaPDBU0Z0oyZta9U9w@mail.gmail.com>
 <Zryy04DvEsnxsRCj@pollux>
 <CAH5fLghsONUtxFPgD6vC139H-Uj5LDju7w5eS0JB+BnDMmfngw@mail.gmail.com>
 <Zry1qwJnPDUtp2Nw@cassiopeiae>
 <CAH5fLgjNfJyyZygWzeTyrNi8TQNAquufxFxDgJHzq6dan=b9BQ@mail.gmail.com>
 <Zry4iOGtR0nd6lNP@cassiopeiae>
 <CANiq72nsSOaG=WhGP5GUQ=ygCh23iDQBc0kgjRP3B5MoF0CUjg@mail.gmail.com>
 <ZrzLHu5Ey9vLwNJg@cassiopeiae>
 <fae5176a-20bd-4ed4-b61c-5114adc674fc@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fae5176a-20bd-4ed4-b61c-5114adc674fc@proton.me>

On Wed, Aug 14, 2024 at 03:28:10PM +0000, Benno Lossin wrote:
> On 14.08.24 17:19, Danilo Krummrich wrote:
> > On Wed, Aug 14, 2024 at 05:03:21PM +0200, Miguel Ojeda wrote:
> >> On Wed, Aug 14, 2024 at 4:00 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >>>
> >>> If we keep them, we'd consequently also need to add them for vrealloc() and
> >>> kvrealloc(). But again, they don't do anything for us, and hence are more
> >>> misleading than helpful IMO.
> >>
> >> In general, they could do something (e.g. `noreturn`), perhaps in the future.
> > 
> > Indeed, and I think once they're honored we should add them again.
> 
> That sounds like it will be a lot of work, going through every function
> and checking if it has the given attribute. Especially when the
> attributes are enabled one by one. I think we should keep them (and of
> course introduce them on new functions).

I don't think it's gonna be a lot of work, if they're honored one day, which we
don't know, do we?

Since it seems that everyone else prefers to have those attributes, I'll keep /
add them accordingly.

However, I think we should at least keep a comment in rust/helpers.c that
documents which attributes are honored by bindgen and which aren't. For now,
the comment should probably say that non of them are honored?

> 
> ---
> Cheers,
> Benno
> 
> > It's just that I think as long as compiler attributes aren't honored, we should
> > not have them in the first place to avoid confusion about whether they do or do
> > not have any effect.
> 

