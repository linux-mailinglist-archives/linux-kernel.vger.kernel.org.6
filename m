Return-Path: <linux-kernel+bounces-542657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8650A4CC08
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413B73AA95B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2395230BE0;
	Mon,  3 Mar 2025 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw+Gvtmx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376CA1C8604;
	Mon,  3 Mar 2025 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030601; cv=none; b=Jg3dyBQzjSwed4crE6+yaWPpMxFl5LWpU5c1/Dx5iSZze+DspoAVJr0Ofb/Bm+7rTdcHdhQ6V1RtpnTCZnWh8Qt9s5rXEM4iJ3RWmm1eqeTvyExnHO1aizOOiaLqJeogZXdokSDcXTvAp83rcud4SU4GNxJhydGvL69UZwpXZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030601; c=relaxed/simple;
	bh=Rrsi+P0TAaJlgstiL0zX1C6HHgzkHudV6w9RtYlyxZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCHvhu4JjHc/W8oHH+52mpOrXcYVVMgDzQeEVs/mgs3XvaZi4G4PbawPa9nuM3ivK6ydt/A/JWJCcJtrmi9Hx0Vv+fyGzanYVjihaM87XxxM7ighxCJ0DZQ70LKUy5m+2xtVAL/CLaxpr9xgdGRdkexbmaGjqZVaSgql1yTwZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw+Gvtmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9D0C4CEE6;
	Mon,  3 Mar 2025 19:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741030599;
	bh=Rrsi+P0TAaJlgstiL0zX1C6HHgzkHudV6w9RtYlyxZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lw+GvtmxYWZ2f2i11D7C8244EfvjE1OuRDe19aHlmeaPyExIxG6O/SzaKJ6eQpLAE
	 98rvdoHLTrRxKpjrBq2F8+2wP1nza/gtUkLRxurNJUuYPGyO/UByVt0njer/WbZpvL
	 6c1wGiTofN6V/gH4X/mHqvQtY+nsiUolTF6lA6eWAokTgMQhp5AXPH5W1wUZ0nri91
	 5DK7u8z6dFuOdZCeGPQLvPZHG4T90UjvkvHQc7DH3/ky8aKG5KKaMdDROndmedBo9N
	 r8sMF3hPMtwbS4BFX5lpr9Gii6u62R2aq3KwDGeCKjQHkd1C+ad6zWoy2joKPqQZ6I
	 N1QayNH6Iq7EQ==
Date: Mon, 3 Mar 2025 20:36:34 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <Z8YEwrBJyLYL6sci@cassiopeiae>
References: <20250227144618.GE39591@nvidia.com>
 <Z8CCKl_yA74WjpQ1@Mac.home>
 <20250227161733.GH39591@nvidia.com>
 <Z8CY7fqbtbO4v1jv@Mac.home>
 <Z8ChnwPC0UwM8xBe@cassiopeiae>
 <20250227192321.GA67615@nvidia.com>
 <Z8DYNszfONdsKZsl@boqun-archlinux>
 <20250227220013.GQ39591@nvidia.com>
 <Z8Dp9dM1MxhzuvmR@pollux>
 <20250228185534.GH39591@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228185534.GH39591@nvidia.com>

On Fri, Feb 28, 2025 at 02:55:34PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 27, 2025 at 11:40:53PM +0100, Danilo Krummrich wrote:
> > On Thu, Feb 27, 2025 at 06:00:13PM -0400, Jason Gunthorpe wrote:
> > > On Thu, Feb 27, 2025 at 01:25:10PM -0800, Boqun Feng wrote:
> > > > 
> > > > Most of the cases, it should be naturally achieved, because you already
> > > > bind the objects into your module or driver, otherwise they would be
> > > > already cancelled and freed. 
> > > 
> > > I'm getting the feeling you can probably naturally achieve the
> > > required destructors, but I think Danillo is concerned that since it
> > > isn't *mandatory* it isn't safe/sound.
> > 
> > Of course you can "naturally" achieve the required destructors, I even explained
> > that in [1]. :-)
> > 
> > And yes, for *device resources* it is unsound if we do not ensure that the
> > device resource is actually dropped at device unbind.
> 
> Why not do a runtime validation then?
> 
> It would be easy to have an atomic counting how many devres objects
> are still alive.

(1) It would not be easy at all, if not impossible.

A Devres object doesn't know whether it's embedded in an Arc<Devres>, nor does
it know whether it is embedded in subsequent Arc containers, e.g.
Arc<Arc<Devres>>.

It is impossible for a Devres object to have a global view on how many
references keep it alive.

> 
> Have remove() WARN_ON to the atomic and a dumb sleep loop until it is 0.
> 
> Properly written drives never hit it. Buggy drivers will throw a
> warning and otherwise function safely.

Ignoring (1), I think that's exactly the opposite of what we want to achieve.

This would mean that the Rust abstraction does *not avoid* but *only detect* the
problem.

The formal problem: The resulting API would be unsound by definition.

The practical problem: Buggy drivers could (as you propose) stall the
corresponding task forever, never releasing the device resource. Not releasing
the device resource may stall subsequent drivers trying to probe the device, or,
if the physical memory region has been reassigned to another device, prevent
another device from probing. This is *not* what I would call "function safely".

With the current API nothing of that kind is possible at all. And that is what
we want to achieve as good as possible: Make Rust driver APIs robust enough,
such that even buggy drivers can't mess up the whole kernel. Especially for a
monolithic kernel this seems quite desirable.

- Danilo

