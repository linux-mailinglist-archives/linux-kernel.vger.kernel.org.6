Return-Path: <linux-kernel+bounces-283666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4EE94F78C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1701C21CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661C61917CD;
	Mon, 12 Aug 2024 19:38:41 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3D217A5B5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491521; cv=none; b=Tay9rWslyCoO4+nSBOMqhFCqgpfRKXreYz9VzbuYVYIBXem1LjwRX+5Aj1E9h++6saavMJam3Kxiglw3cU8AJaFwWgfuzP0Zm1v55P0ydcWH7Z6h9hmUEmxGu7e7CwQnr7+H1a64ELLzrAHyn8KSP2otB7ouEINK3POMw8YS+ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491521; c=relaxed/simple;
	bh=s/A5uX7yfaaDfrgHpeQ+Gmfl+MK0xIzRFPutyIkEPuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMh+X+uNHYcphIDgqkap6DlHttrQmhSFwC2+5QSM02h1mvppOzKbBqniYDao6hIgmbWaTsXrc6Fpo715ZgNZMiH/g3FjwA9Q7FPdRuUhEyGH20OqE7zrmwFHAVDc3ro+F5Yg9Hlultg34EiXBikxdmtx3q6w5fWVTFO8Ji0SnIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 47CJcQFq025695;
	Mon, 12 Aug 2024 21:38:26 +0200
Date: Mon, 12 Aug 2024 21:38:26 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/nolibc: x86_64: wrap asm functions in functions
Message-ID: <Zrpksrnrbykx+IML@1wt.eu>
References: <20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net>
 <20240810-nolibc-lto-v1-3-a86e514c7fc1@weissschuh.net>
 <ZrdZKcQ1SClUHWa1@biznet-home.integral.gnuweeb.org>
 <121f58b7-b781-44cf-a18f-6f8893c82187@t-8ch.de>
 <20240810143556.GA9168@1wt.eu>
 <384a1d29-13ca-4e4b-b4b7-2a99e3fdb01b@t-8ch.de>
 <17ed9bf5-64da-418e-b40e-6e3d40c67769@t-8ch.de>
 <20240810170030.GA4461@1wt.eu>
 <65cf1965-841b-4fb1-9222-913c6bd9ccd4@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65cf1965-841b-4fb1-9222-913c6bd9ccd4@t-8ch.de>

Hi Thomas,

On Mon, Aug 12, 2024 at 07:01:26PM +0200, Thomas Weißschuh wrote:
> > > The memcpy / memmove combination could be split up into one real
> > > function and one C inline wrapper and then the same pattern would apply.
> > > 
> > > But to be honest I'd be fine with not supporting -flto on GCC.
> > 
> > That could also be a reasonable solution. The primary goal of nolibc
> > is to make it easy for developers to develop tests, and for those who
> > want to create pre-boot code to do so. By nature this code is prone to
> > bugs. If it becomes totally unreadable for very unlikely cases, it will
> > cause issues that are hard to debug by the users themselves. It's sure
> > that supporting a variety of compilers and setups is great, but we should
> > keep in mind the maintainability goal when thinking about this. I think
> > that LTO will mostly be used for testing, and in this case I think it's
> > totally reasonable to restrict the choice of compatible compilers.
> 
> IMO LTO is useful for nolibc to reduce the size of the generated binaries.
> For example the custom function sections that then can be combined with
> --gc-sections to get rid of unused functions is all implicit in LTO.
> And on top of that it can perform other size optimizations.

Well, probably, but my experience of it till now has been quite negative,
between stuff that doesn't build and stuff that takes ages to link on a
single core, for most of the time tiny to no gain at all :-/  But I admit
that in our case here at least we shouldn't witness long link times.

> But the complications for GCC are not worth it.
> And there seem general with LTO on GCC anyways as evidenced by the
> constructor and duplicate-asm bugs.

Yes, and the trouble it will cause will result in a lot of head-scratching
for those affected.

> After this discussion I think we should also change the __nolibc_naked
> attribute back to __nolibc_entrypoint as it was before.
> It is indeed not a replacement for a proper "naked".

Indeed, it sort of emulates it but does not have the exact same properties
as we've seen.

> What do you think about me rewriting the existing commits on nolibc-next
> to fix this up?

I'm obviously fine with this :-)

Thank you!
Willy

