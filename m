Return-Path: <linux-kernel+bounces-532690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790D9A45104
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1D417F97F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939E823A981;
	Tue, 25 Feb 2025 23:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIugjpVa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C01191F95;
	Tue, 25 Feb 2025 23:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740527152; cv=none; b=fwbj8BrPkjLDUfket1TcgnS6rMRtJuZVD7ArIjXDqrw8hTDnZb50MUcC0obvoQzEW7XWpvpJYYtkR5V9n4TEYs9spUltvbUwRFbnfzyNzZo1I6EIEVO85L12VpPZ+MX2G0/gVVXIPuXM8HAch1ajqO7kdODR6+ZoaiPM4HA6wns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740527152; c=relaxed/simple;
	bh=uz+tadVAdTb7AZ+aJWh9/fa1TwcRYK6fdtNwn3BIO0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlAEEBoitBIstUg01rsbJ0UfLgbwD6tNZj4JKB3KYYKogQoWHwDhiih7IiuYXomL8VSyToc7camFrswn4B3CQcn7xtk6NJPJmK2nUOid/wrSRwVYCwWp/QGhZkTdkcIkY9n/N1RBOaxs/JWvCstPnsGvRQEP7Y/WoM4qWqSRi8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIugjpVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F2CC4CEDD;
	Tue, 25 Feb 2025 23:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740527151;
	bh=uz+tadVAdTb7AZ+aJWh9/fa1TwcRYK6fdtNwn3BIO0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIugjpVayFWN0SmzcJZYQ2eNpVbvNoGTaYgthH0q1kR5S7JXiWZqk8BDfHpJic2wU
	 +yD4iDnlUZ19xYylMr2BjRNbiBUK7wvus6vJrs70eG9/UAbpl1DaqEP7pbKwRjtDUE
	 yudyFIZSdFVODKD7+3F8wW9phL8RbflZgUMy++M+6hXb07BDgtrCDdtV3yNf4cyTcW
	 TMQh8tgNVQvCo85EWlewElkymYcIYCWGkWq+pZ5IZR8/SjYaP1jmcnOs6zUAifnp5A
	 inZZI8VivYmCSjo4wU+taV7PF8w+N/0WqK0o66D/E/pCJ6RL0V8+KNAntAeEY2j7v9
	 H/6P0m/m817IQ==
Date: Wed, 26 Feb 2025 00:45:45 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <Z75WKSRlUVEqpysJ@cassiopeiae>
References: <CAPM=9tyu84z4Xk5X0fykO3Dazby2UqRgwtN4woNKe4Z2yMyDZg@mail.gmail.com>
 <D80AK2CLL4AZ.1G6R7OBHOF08O@nvidia.com>
 <Z7xg8uArPlr2gQBU@pollux>
 <Z7xh5bEyh_MII4WV@pollux>
 <20250224184502.GA1599486@joelnvbox>
 <Z70EcwNIX0KtWy36@cassiopeiae>
 <2f062199-8d69-48a2-baa6-abb755479a16@nvidia.com>
 <Z73rP4secPlUMIoS@cassiopeiae>
 <20250225210228.GA1801922@joelnvbox>
 <20250225225756.GA4959@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225225756.GA4959@nvidia.com>

On Tue, Feb 25, 2025 at 06:57:56PM -0400, Jason Gunthorpe wrote:
> The common driver shutdown process in the kernel, that is well tested
> and copied, makes the driver single threaded during the remove()
> callback.

All devres callbacks run in the same callchain, __device_release_driver() first
calls remove() and then all the devres callbacks, where we revoke the pci::Bar,
by which gets dropped and hence the bar is unmapped and resource regions are
free. It's not different to C drivers. Except that in C you don't lose access to
the void pointer that still points to the (unmapped) MMIO address.

