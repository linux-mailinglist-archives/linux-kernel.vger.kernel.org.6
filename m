Return-Path: <linux-kernel+bounces-192554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBFD8D1F13
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7BF1F2369C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCE616FF39;
	Tue, 28 May 2024 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML3Ccw8Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF23316F27E;
	Tue, 28 May 2024 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907415; cv=none; b=OltXzjqPaiz5VDcXdK1tYeDdZlC+tPQdJXYNL/4+Tf/zQQsRVIOT3yG3DO2AFLFlELOghP37FqeArelgbSAHNNOZSzdy7JhV0kcZ1CUX8LXa/OzYhJ+7zjhyq9OAurBognOfQOQbewGoopLKLRh6C2sk2ueDjeTKipHrhbre0Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907415; c=relaxed/simple;
	bh=rBOsmkJf6TERqc6dB5o9t0xQJxVujKORYddvFjHhnYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxeuzN3BmZDNCTBu4rAqjpDC43gPAd1kx00Kn94qF3t4A/fA8nPHveMetHNXxy2pTF1xjKDzG5oQUuItdmghUpUTec/bi1FVCIDUAVCtsqZXcONaafCjxX8X+yD/7pRE2Y4qKAner863LuS6QLkaQ9XkFtYuM29gj5uXIG5pAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML3Ccw8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DB0C3277B;
	Tue, 28 May 2024 14:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716907414;
	bh=rBOsmkJf6TERqc6dB5o9t0xQJxVujKORYddvFjHhnYs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ML3Ccw8QMmd+lYanHo+WyyIg5yFrlmTv+x/7gbkj89Iv8JVtcK3yioGRH9BucIBVK
	 XGZL2KHMd6KYzcglnGr38vUH94fbffhqnfglhRuDBz7OUvxJc52lEOGw0s37fYbV65
	 i47YOSapHt4YpJF/YAbBgPz6YxC7tAB9ZW06+djHuNEHoewpfYXNMGqlYsGjMIwyGj
	 U1CDHPtZGLgEQ6b/j+tL7QkuX3quBtBHHdcDyuXHZ843h2A9SfchfHLxvJHLxHQaUH
	 XoFiio3McaEErz1QpeTPzZwzTp3fXfPbhGHhH3MdTL8dasL+0hnlwoKw0jhDGUVI7f
	 p+EM93tNXsD5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0CF27CE0F8F; Tue, 28 May 2024 07:43:34 -0700 (PDT)
Date: Tue, 28 May 2024 07:43:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>,
	Frank Scheiner <frank.scheiner@web.de>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
Message-ID: <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240503081125.67990-1-arnd@kernel.org>
 <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de>
 <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk>

On Tue, May 28, 2024 at 12:49:16AM +0100, Maciej W. Rozycki wrote:
> On Fri, 3 May 2024, John Paul Adrian Glaubitz wrote:
> 
> > > I had investigated dropping support for alpha EV5 and earlier a while
> > > ago after noticing that this is the only supported CPU family
> > > in the kernel without native byte access and that Debian has already
> > > dropped support for this generation last year [1] after it turned
> > > out to be broken.
> > 
> > That's not quite correct. Support for older Alphas is not broken and
> > always worked when I tested it. It's just that some people wanted to
> > raise the baseline in order to improve code performance on newer machines
> > with the hope to fix some minor issues we saw on Alpha here and there.
> 
>  I'm not quite happy to see pre-EV5 support go as EV45 is all the Alpha 
> hardware I have and it's only owing to issues with the firmware of my 
> console manager hardware that I haven't deployed it at my lab yet for 
> Linux and GNU toolchain verification.  I'd rather I wasn't stuck with an 
> obsolete version of Linux.
> 
> > > This topic came up again when Paul E. McKenney noticed that
> > > parts of the RCU code already rely on byte access and do not
> > > work on alpha EV5 reliably, so I refreshed my series now for
> > > inclusion into the next merge window.
> > 
> > Hrrrm? That sounds like like Paul ran tests on EV5, did he?
> 
>  What exactly is required to make it work?

Whatever changes are needed to prevent the data corruption that can
currently result in code generated by single-byte stores.  For but one
example, consider a pair of tasks (or one task and an interrupt handler
in the CONFIG_SMP=n case) do a single-byte store to a pair of bytes
in the same machine word.  As I understand it, in code generated for
older Alphas, both "stores" will load the word containing that byte,
update their own byte, and store the updated word.

If two such single-byte stores run concurrently, one or the other of those
two stores will be lost, as in overwritten by the other.  This is a bug,
even in kernels built for single-CPU systems.  And a rare bug at that, one
that tends to disappear as you add debug code in an attempt to find it.

So if you want to run current kernels on old Alphas, you will need to
do something to fix this.

There might well be other things in need of fixing, for but one example,
it might be that the same issue will soon need to be addressed for
two-byte stores.  You will therefore need to carefully investigate this
issue to determine the full extent of work required to solve it.

							Thanx, Paul

