Return-Path: <linux-kernel+bounces-532455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1AFA44DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257FB19C1AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C7520E31D;
	Tue, 25 Feb 2025 20:44:30 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2606C183CB0;
	Tue, 25 Feb 2025 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516270; cv=none; b=jcq9V3qjjyYoPIQCQB90EYWBi+O6/mJWuIQ3JWmH/S97oz7s8H25Hmp/7Nr1Gr+Gb9ULB+HdZStMyy4C2Kaxp4vXCtjFViNpg/cMDL2brWbsxf+m88XNtrr7zWcF4GNkyq2kjTS3w+wucLcKnTyo0XDYSjRH7F7giwd4cM63a+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516270; c=relaxed/simple;
	bh=PH5YdRnivR9kB6Smke+lsCS/cQYYOFOc+a/7o9cCsl4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hjvF8rzX1U0/97AFfKcozSFMf6PnjuWwqoEI8Mlblzf5tRK/X/FxYqnitnFwQAxM+bK5Y0lgyJGf1G6fDbzwJRoKmYrycrIMjEZ2ChnAbPqI0JpbG8HCLWoF/J1yQ4nyHySHenub40dkdutbWHu7ueE6tKMa2Njl2ndAH3zl+2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id DC8B492009C; Tue, 25 Feb 2025 21:44:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id D8F6A92009B;
	Tue, 25 Feb 2025 20:44:20 +0000 (GMT)
Date: Tue, 25 Feb 2025 20:44:20 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Richard Henderson <richard.henderson@linaro.org>, 
    Ivan Kokshaysky <ink@unseen.parts>, Matt Turner <mattst88@gmail.com>
cc: Arnd Bergmann <arnd@arndb.de>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Magnus Lindholm <linmag7@gmail.com>, 
    "Paul E. McKenney" <paulmck@kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Al Viro <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alpha: Emulate unaligned LDx_L/STx_C for data
 consistency
In-Reply-To: <alpine.DEB.2.21.2502181912230.65342@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2502252030380.65342@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2502181912230.65342@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 19 Feb 2025, Maciej W. Rozycki wrote:

> Interestingly enough no kernel mode traps have triggered with a kernel 
> built with GCC 12 (and with most user traps coming from GCC verification):
> 
> kernel unaligned acc	: 0 (pc=0,va=0)
> user unaligned acc	: 1766720 (pc=20000053064,va=120020189)
> 
> but with GCC 15 a small quantity happened (even before I ran GCC testing):
> 
> kernel unaligned acc    : 78 (pc=fffffc0000ad5194,va=fffffc0002db5784)
> user unaligned acc      : 883452 (pc=20000053064,va=120020189)
> 
> It seems a compiler regression worth checking -- the trap recorded was in 
> `icmp6_dst_alloc' with a pair of quadword writes to `rt->rt6i_dst.addr', 
> which however by its type (`struct in6_addr') is only longword-aligned and 
> indeed starts at offset 148 from the outermost struct.  I have a sneaking 
> suspicion one of my earlier GCC changes might be at fault.  At least I now 
> have a test case to experiment with.

 FYI my suspicion wasn't wrong, I have submitted a compiler fix now[1].  

 My plan has been to complete the GCC side first as it's more urgent given 
its annual only release cycle model targetting April/May, whereas I think 
the Linux side can slip a release or two in our roughly bi-monthly cycle.  
I'm going to schedule my time accordinly and with my upcoming holiday also 
in the picture I may not be able to post v2 of this proposal until around 
end of March the earliest.

References:

[1] "Alpha: Fix base block alignment calculation regression", 
    <https://inbox.sourceware.org/gcc-patches/alpine.DEB.2.21.2502251934260.65342@angie.orcam.me.uk/>

  Maciej

