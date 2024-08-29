Return-Path: <linux-kernel+bounces-307433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2232964D93
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5769C1F2382F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A00A1B86CB;
	Thu, 29 Aug 2024 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqxgsCrN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88221B5EB4;
	Thu, 29 Aug 2024 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955452; cv=none; b=V9g7WgnEAj35p375ursqZXLcbTXnelxgsOKcJvy7KpXL5F5TGv4q/V1E5Af3SHci7/5tiXodDO7AnYp7YGvhM6JWhtu2+kn9ztFfDo8u94OXCtc42/qzDZ76Dq1OepD7fQLh6j8wKn3VAC4uHnLtUNJg9eF9wnooFdzw/gUFtgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955452; c=relaxed/simple;
	bh=PQ8NlAQBi9YMzKHfqEYVZxQkx9i4+zrKJSJVjyL8mLE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=R/52SoxxhJX3+yDxoqnyBT9yzh2yfqFmMA1hCNvBHl4m59f9uwr5mhXFMU8MKeTQ4yev3g8jcBMZQrvmGP55V/y4OIXiIusNw7RbFGbzo92uYiNJ9js88cB7B0KDqQeMUX04bJUR1yO0v05pcWsMqekLcLS22jsvHsQrk0SRLXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqxgsCrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32543C4CEC1;
	Thu, 29 Aug 2024 18:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724955452;
	bh=PQ8NlAQBi9YMzKHfqEYVZxQkx9i4+zrKJSJVjyL8mLE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=kqxgsCrNZ5pvHD/nrx5mXB/rly/1GcB8AsCi87Ae/YPO/96pNXan9yE/uBeqNYpBh
	 sEuVfXZtkOu27d2MWuvCnJSqFrQIrnhDvEwgHplymhp2t9TGjU4/FbdWbF4egohHYz
	 7UIqY9V+kUKwtEDnfkd2QaEwpqgXonXiE8viKu29jA0kwo+ftU3qmEHbbrg9BDkMWG
	 JzHACGv48pwWrcujx1Lo1L4tVpcXkB2g2J+lVwS2CAQm18yYD4fckBWyKf1AYOyRtp
	 THXd5+RS9WgRxjkzpkE9QD97UWA9Uol3DNAih9A1X8qwHBQxQLZyPw09APZFWSdIH3
	 7eyq0nXTY5GnA==
Message-ID: <1bd17a02bab46391872e4934895b83e8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2024082824-emphasis-thwarting-4ef4@gregkh>
References: <20240826123602.1872-1-hpausten@protonmail.com> <20240826123602.1872-8-hpausten@protonmail.com> <2024082655-cubicle-flashily-6ab3@gregkh> <D3QXIGN92QZ7.S2LY531JZ1L9@protonmail.com> <ced9ed863c4b648a65c80447a8482cb2.sboyd@kernel.org> <2024082824-emphasis-thwarting-4ef4@gregkh>
Subject: Re: [PATCH v3 7/9] uio: add Xilinx user clock monitor support
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Harry Austen <hpausten@protonmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 29 Aug 2024 11:17:30 -0700
User-Agent: alot/0.10

Quoting Greg Kroah-Hartman (2024-08-28 00:10:46)
> On Tue, Aug 27, 2024 at 04:40:52PM -0700, Stephen Boyd wrote:
> > Quoting Harry Austen (2024-08-27 12:08:52)
> > > On Mon Aug 26, 2024 at 2:11 PM BST, Greg Kroah-Hartman wrote:
> > > > Why do you want a UIO api for a clock device?  What userspace code =
is
> > > > going to access the hardware this way?  Why not use the normal
> > > > kernel/user apis instead?
> > >=20
> > > I was just trying to provide userspace access to these _unexpected_ c=
lock
> > > status event indications (clock stopped, underrun, overrun or glitche=
d) and UIO
>=20
> That is going to be a brand-new user/kernel api that isn't documented
> anywhere and will be unique to this one device.  Please don't do that.
>=20
> > Maybe unexpected events can be indicated through the EDAC subsystem,
> > except that is usually about memory or cache errors, not device driver
> > issues.
>=20
> If you all need a new way to report issues like this to userspace, then
> let's create the correct api for it, don't require userspace to mmap a
> random device and expect to poke around in it safely to get the
> information.
>=20
> Odds are that mmap will change with the next version of this device,
> right?

Agreed. I'm wondering if we don't even need to invent anything new
though and can simply use devcoredump. Harry?

