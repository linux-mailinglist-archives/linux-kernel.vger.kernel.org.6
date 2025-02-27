Return-Path: <linux-kernel+bounces-536983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBA5A486A6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0251638E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1AD1DE2B9;
	Thu, 27 Feb 2025 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeXhWU9t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856DD27002E;
	Thu, 27 Feb 2025 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677541; cv=none; b=GJWZsZCmHMoa6voHodqtvqoKvBhIoVbN0hvU3HUiY/ruOG+EIbVcXa0p8YbgO1P1NqeicsZAWh3YRohWaj206tPBxpRp4lu6uaYsNTyeuipkM0UsjAElDUQyrMrH9taQNSHwj41rv5YO+iLXdDwWOyrZQLvJ8MB5H3xiHTYZFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677541; c=relaxed/simple;
	bh=ZF9S4DgsXojdfwe8fyj+o1u2upec991trSXQ85ErxyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USI4Rh50QCq1WDuKLlFvxrOnn/K7hDAAo9WarwCuAGhwmZRrfbWbKviRd94YYf8HfQmVqgR9K/sOGMOTz/H+fl5E42ELMuZKZGaD0Q2ssnWU1dZ6B2pJHqKoEJFp6F/xWzLtu7J5636F7HJfX0Bmponz2HhqyAr7A6o7IOoZmhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeXhWU9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27526C4CEDD;
	Thu, 27 Feb 2025 17:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740677541;
	bh=ZF9S4DgsXojdfwe8fyj+o1u2upec991trSXQ85ErxyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QeXhWU9tdT1xqO+/pAOx7GfponmkwTQKFnO5Gb4eSyOf1P2H9bcbKQ9U0kKL9Ppu2
	 4KOCZl+UK7UIVCCHUMUzH452/mHiXadW2aa1wU5YrFFqXrsGWlLCcXydeHCPjk4IXL
	 MSA9DTTNaBPsSjja8HR24z+tJZoSND3XA6QHvH4X9+EbDQtePCa6e6P10HUqmcXsDX
	 H00mllT4FUfyYMWeXXerbKdY2tkbs1ZZ1RlcAC//aMUK6uJv5pqrpKQEVu7X8I5pHL
	 5oHRfkZS9Ivc2P7osQ0Fl+8iB8DoIjH4xGeEdX4CgBHsBChMsm9uj1qr5Rdt8fZrqx
	 jtYlHBn5PPSaQ==
Date: Thu, 27 Feb 2025 18:32:15 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <Z8ChnwPC0UwM8xBe@cassiopeiae>
References: <20250226004916.GB4959@nvidia.com>
 <Z75riltJo0WvOsS5@cassiopeiae>
 <20250226172120.GD28425@nvidia.com>
 <Z7-IHgcVVS8XBurW@cassiopeiae>
 <20250226234730.GC39591@nvidia.com>
 <Z7-0pOmWO6r_KeQI@boqun-archlinux>
 <20250227144618.GE39591@nvidia.com>
 <Z8CCKl_yA74WjpQ1@Mac.home>
 <20250227161733.GH39591@nvidia.com>
 <Z8CY7fqbtbO4v1jv@Mac.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8CY7fqbtbO4v1jv@Mac.home>

On Thu, Feb 27, 2025 at 08:55:09AM -0800, Boqun Feng wrote:
> On Thu, Feb 27, 2025 at 12:17:33PM -0400, Jason Gunthorpe wrote:
> 
> > I still wonder why you couldn't also have these reliable reference
> > counts rooted on the device driver instead of only on the module.
> > 
> 
> You could put reliable reference counts anywhere you want, as long as it
> reflects the resource dependencies.

Right, as I explained in a different reply, the signature for PCI driver probe()
looks like this:

	fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>

The returned Pin<KBox<Self>> has the lifetime of the driver being bound to the
device.

Which means a driver can bind things to this lifetime. But, it isn't forced to,
it can also put things into an Arc and share it with the rest of the world.

If something is crucial to be bound to the lifetime of a driver being bound to a
device (i.e. device resources), you have to expose it as Devres<T>.

Subsequently, you can put the Devres<T> in an Arc and do whatever you want, the
result will still be that T is dropped once the device is unbound.

